-- nvim-jdtls: dedicated client for the Eclipse JDT Language Server (jdtls).
--
-- jdtls cannot be driven by the generic nvim-lspconfig handler — it needs this
-- companion plugin. The actual startup lives in `after/ftplugin/java.lua`, which
-- runs for every Java buffer (the pattern recommended by nvim-jdtls). Here we just
-- declare the plugin and load it lazily when the first .java file is opened.
return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = {
    -- needed so require('jdtls').setup_dap() can register the DAP adapter
    'mfussenegger/nvim-dap',
  },
}
