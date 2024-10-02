local ls = require 'luasnip'
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets(nil, {
  all = {
    snip({
      trig = 'mod',
      namr = 'Module',
      dscr = 'Skeleton for a React module',
    }, {
      text { 'export const ' },
      insert(1, 'mod_name'),
      text { ' = () => {', '  return (', '    <' },
      insert(2, 'div'),
      text { '>' },
      insert(0, ''),
      text { '</' },
      insert(3, 'div'),
      text { '>', '  );', '}' },
    }),
  },
})

return {}
