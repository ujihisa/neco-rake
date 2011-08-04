" filetypes aren't only vimshell but also vim for command-line window.
let s:source = {
      \ 'name': 'rake',
      \ 'kind' : 'ftplugin',
      \ 'filetypes': { 'vimshell': 1, 'vim': 1 },
      \ }

function! s:source.initialize()
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_pos(cur_text)
  return matchend(a:cur_text[:getpos('.')[2]], 'rake\s\+')
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
  let V = vital#of('neocomplcache') " fixme
  let result = V.system('rake -T')
  "if !V.get_last_status()
  "  return []
  "endif
  let list = split(result, "\n")[1:]
  call map(list, 'split(v:val, "\\s\\+#\\s\\+")')
  return map(list, "{'word': substitute(v:val[0], '^rake ', '', ''), 'menu': v:val[1], 'kind': 'rake'}")
endfunction

function! neocomplcache#sources#rake#define()
  return executable('rake') ? s:source : {}
endfunction
