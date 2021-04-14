" Set formatoptions
au FileType * setlocal formatoptions-=ro

" Set filetypes
au BufNewFile,BufRead *.ejs,*.hbs set filetype=html
au BufNewFile,BufRead .prettierrc,.eslintrc,tsconfig.json set filetype=jsonc
au BufNewFile,BufRead *.svx,*.mdx set ft=markdown
au BufNewFile,BufRead *.svelte set ft=svelte

" Set github text field to markdown (firenvim stuff)
au BufEnter github.com_*.txt set filetype=markdown

" Set tabsize for each filetype
au FileType go,java setlocal sw=4 ts=4 sts=4 noexpandtab
au FileType lua setlocal sw=2 ts=2 sts=2
au FileType c,cpp setlocal sw=4 ts=4 sts=4
au FileType php setlocal sw=4 ts=4
au FileType json set filetype=jsonc

" disable conceal
au FileType markdown setlocal conceallevel=0 nospell

" Remove trailing whitespace on save
au BufWritePre * %s/\s\+$//e

" automatically go to insert mode on terminal buffer
autocmd BufEnter term://* startinsert

" enable/disable wordwrap
augroup Goyo
  au!
  au User GoyoEnter setlocal linebreak wrap
  au User GoyoLeave setlocal nolinebreak nowrap
augroup END

" disable nvim-compe inside telescope
augroup Compe
  au!
  au WinLeave,FileType TelescopePrompt let g:compe_enabled = v:true
  au WinEnter,FileType TelescopePrompt let g:compe_enabled = v:false
augroup END