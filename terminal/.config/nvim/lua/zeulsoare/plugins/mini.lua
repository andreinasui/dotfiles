return {
  { "echasnovski/mini.ai", event = { "BufReadPre", "BufNewFile" }, version = false, opts = {} },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    version = false,
    opts = {
      search_method = "cover",
      silent = true,
    },
  },
}
