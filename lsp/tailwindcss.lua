return {
  cmd = {
    'node',
    '/home/alex/code/opensource/tailwindcss-intellisense/packages/tailwindcss-language-server/bin/tailwindcss-language-server',
    '--stdio',
  },
  filetypes = {
    'astro', 'astro-markdown', 'css', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby',
    'gohtml', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex',
    'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php',
    'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss',
    'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact',
    'vue', 'svelte', 'templ',
  },
  root_markers = {
    'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts',
    'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts',
    '.git',
  },
}
