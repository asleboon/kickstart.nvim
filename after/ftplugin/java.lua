-- Java setup for the Lyse become-customer Spring Boot backend.
--
-- This file runs for every Java buffer (the nvim-jdtls recommended pattern). It:
--   1. starts/attaches the Eclipse JDT language server (jdtls) for code intelligence,
--   2. loads the java-debug + java-test bundles so nvim-dap works,
--   3. registers a "remote attach" debug config matching the `bcdebug` shell alias
--      (the app is launched with a JDWP agent on port 5005; we attach to it).
--
-- jdtls / the bundles are installed by Mason (see lua/plugins/lsp-config.lua).

local ok, jdtls = pcall(require, 'jdtls')
if not ok then
  return
end

local mason = vim.fn.stdpath 'data' .. '/mason'
local jdtls_pkg = mason .. '/packages/jdtls'

-- Project root — first ancestor containing one of these markers.
local root_dir = require('jdtls.setup').find_root { 'mvnw', 'pom.xml', '.git' }
if not root_dir then
  return
end

-- Per-project workspace keeps jdtls's index isolated between projects.
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. project_name

-- Equinox launcher jar — version varies, so glob it.
local launcher = vim.fn.glob(jdtls_pkg .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Lombok: jdtls's Eclipse compiler must run Lombok as a -javaagent, or it can't see
-- members Lombok generates (@Slf4j's `log`, @Builder, @Getter, …). Without it jdtls both
-- shows false errors in the editor AND writes broken .class files ("Unresolved compilation
-- problem") into target/classes — which a later `mvnw spring-boot:run` reuses and crashes on.
-- Glob the jar straight from the local Maven repo; pick the highest version present.
local lombok_jar
do
  -- Expand only ~ (not the wildcards — vim.fn.expand would resolve `*` itself and mangle the pattern).
  local pattern = vim.fn.expand '~' .. '/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar'
  local jars = vim.fn.glob(pattern, true, true)
  jars = vim.tbl_filter(function(j)
    return not j:match 'sources' and not j:match 'javadoc'
  end, jars)
  table.sort(jars)
  lombok_jar = jars[#jars] -- highest version sorts last
end

-- Collect the debug + test bundles for nvim-dap (empty table is fine if absent).
local bundles = {}
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(mason .. '/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true), '\n')
)
vim.list_extend(bundles, vim.split(vim.fn.glob(mason .. '/packages/java-test/extension/server/*.jar', true), '\n'))
-- Drop empty strings (glob returns "" when nothing matches).
bundles = vim.tbl_filter(function(j)
  return j ~= ''
end, bundles)

local config = {
  -- jdtls runs on the JVM; mise puts Java 25 on PATH, which satisfies its JDK 21+ need.
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    launcher,
    '-configuration',
    jdtls_pkg .. '/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        -- Tell jdtls where the JDK lives so it can compile Java 25 sources.
        runtimes = {
          {
            name = 'JavaSE-25',
            path = vim.fn.expand '~/.local/share/mise/installs/java/temurin-25.0.3+9.0.LTS',
          },
        },
      },
    },
  },
  init_options = {
    bundles = bundles,
  },
}

-- Prepend the Lombok agent to the JVM args (must come before `-jar`). Skipped if no jar found.
if lombok_jar and lombok_jar ~= '' then
  table.insert(config.cmd, 2, '-javaagent:' .. lombok_jar)
end

jdtls.start_or_attach(config)

-- Register the `java` DAP adapter + discover main classes / test methods.
jdtls.setup_dap { hotcodereplace = 'auto' }

-- Remote-attach config: debug the running Spring Boot app started via `bcdebug`
-- (which adds -agentlib:jdwp=...,address=*:5005). Pick this in :lua require'dap'.continue().
local dap = require 'dap'
dap.configurations.java = dap.configurations.java or {}
local has_attach = false
for _, c in ipairs(dap.configurations.java) do
  if c.name == 'Attach to Spring Boot (:5005)' then
    has_attach = true
  end
end
if not has_attach then
  table.insert(dap.configurations.java, {
    type = 'java',
    request = 'attach',
    name = 'Attach to Spring Boot (:5005)',
    hostName = '127.0.0.1',
    port = 5005,
  })
end

-- A few Java-specific niceties (buffer-local).
local map = function(keys, fn, desc)
  vim.keymap.set('n', keys, fn, { buffer = true, desc = 'Java: ' .. desc })
end
map('<leader>jo', jdtls.organize_imports, 'Organize Imports')
map('<leader>jv', jdtls.extract_variable, 'Extract Variable')
map('<leader>jc', jdtls.extract_constant, 'Extract Constant')
map('<leader>jt', jdtls.test_nearest_method, 'Test Nearest Method')
map('<leader>jT', jdtls.test_class, 'Test Class')
