return {
  {
    'lervag/vimtex',
    ft = { 'tex' },
    init = function()
      vim.g.vimtex_compiler_engine = 'lualatex'
      vim.g.vimtex_compiler_latexmk_engines = { _ = '-lualatex' }
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_progname = 'nvr'
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = 'build',
        continuous = 1,
        executable = 'latexmk',
        options = {
          '-lualatex', -- FORCE LuaLaTeX
          '-synctex=1',
          '-interaction=nonstopmode',
          '-file-line-error',
          '-outdir=build', -- keep aux/pdf in build/
        },
      }
    end,
  },
}
