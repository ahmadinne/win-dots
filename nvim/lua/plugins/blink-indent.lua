local present, indent = pcall(require, 'blink-indent')

if not present then return end

indent.setup {
  static = {
    enabled = true,
    char = '┊',
    -- specify multiple highlights here for rainbow-style indent guides
    -- highlights = { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' },
    highlights = { 'BlinkIndent' },
  },
  scope = {
    enabled = true,
    char = '│',
    -- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
    -- highlights = { 'BlinkIndentScope' },
    -- optionally add: 'BlinkIndentRed', 'BlinkIndentCyan', 'BlinkIndentYellow', 'BlinkIndentGreen'
    highlights = { 'BlinkIndentOrange', 'BlinkIndentViolet', 'BlinkIndentBlue' },
    -- enable to show underlines on the line above the current scope
    underline = {
      enabled = false,
      -- optionally add: 'BlinkIndentRedUnderline', 'BlinkIndentCyanUnderline', 'BlinkIndentYellowUnderline', 'BlinkIndentGreenUnderline'
      highlights = { 'BlinkIndentOrangeUnderline', 'BlinkIndentVioletUnderline', 'BlinkIndentBlueUnderline' },
    },
  },
}
