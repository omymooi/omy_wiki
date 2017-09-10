set laststatus=2  
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    let curname = expand("%f%m%r%h")

    let full = ' '
    let full .= curname
    let full .= ' | '

    let fullLength = strlen(full)
    let dirLength = strlen(curdir)
    let statLength = &columns

    if statLength < dirLength + fullLength
	let droplen = dirLength + fullLength - statLength
	    if droplen < dirLength
		let curdir = strpart(curdir,droplen)  
	    else
		let curdir = ''
	    endif
    endif

    let full .= curdir

    return full

endfunction
"set statusline=\ %f%m%r%h\ \|\ %{CurDir()}
set statusline=%{CurDir()}
"set statusline=\ %f%m%r%h\ \|\ 

set autoindent
set smartindent
set tabstop=4
set ut=1
set noexpandtab
"autocmd FileType * set expandtab
autocmd FileType make set noexpandtab
autocmd FileType kconfig set noexpandtab
autocmd FileType dts set noexpandtab

set vb t_vb=
set shiftwidth=4
set softtabstop=4
set incsearch
set showmatch
set noautochdir
"set ts=4
syntax on
set nohls
set nu
set showtabline=2
set bs=2
"set cursorline 
set	wildignore+=*.o,*.so,*/Documentation/*,*/.git
set tags=.tags

set encoding=utf-8

let Tlist_Use_Right_Window=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_Close_On_Select=1
"let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SignleClick=1
let Tlist_Enable_Fold_Column=0
let Tlist_WinWidth=80
let Tlist_Inc_Winwidth=0

let mapleader=","

let g:CommandTMaxFiles=50000
let g:SuperTabDefaultCompletionType="context"
let g:CommandTMatchWindowReverse=1

let g:NERDChristmasTree=0
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0
let g:NERDTreeWinSize=40

let g:buffergator_vsplit_size=80
let g:buffergator_show_new_tab=1



:map <C-y> :tabedit :CommandT 
:map <C-n> :BuffergatorTabsOpen 
":map <C-o> :BuffergatorTabsOpen 
:map <C-p> :TlistOpen 
":map <Esc> :TlistClose 
:map <C-k> :VbookmarkListAll 
:map <C-l> :NERDTreeFind 




":map <C-i> :NERDTreeFind 
":map <C-i> :tabedit :NERDTreeFind 
":map <slient> <C-k> <C-w>gf:tabm 999 
":map <C-k> <C-w>gf

":map <M-1> 1gt
":map <M-2> 2gt
":map <M-3> 3gt
":map <M-4> 4gt
":map <M-5> 5gt
":map <M-6> 6gt
":map <M-7> 7gt
":map <M-8> 8gt
":map <M-9> 9gt
":map <M-0> :tablast 


"set clipboard=unnamedplus

set fdm=indent
set foldlevelstart=99





function MyTabLine()
	 let s = ''
	 let t = tabpagenr()

	 let i = 1
	 let fileNameLength = 0
	 while i <= tabpagenr('$')
		 let buflist = tabpagebuflist(i)
		 let winnr = tabpagewinnr(i)
		 let file = bufname(buflist[winnr - 1])
		 let file = fnamemodify(file, ':p:t')
		 if file == ''
			 let file = '[No Name]'
		 endif
		 let fileNameLength = fileNameLength + strlen(file) + 3
		 let i = i + 1
	 endwhile
	 
	let needShort = 0
	let needShowFileName = 1
	let tabline_width = &columns
	if fileNameLength > tabline_width
		"let extraStrNum = fileNameLength - tabline_width
		let maxLengthPerFile = tabline_width / (i - 1)
		let needShort = 1 
		if maxLengthPerFile <= 3
			let needShowFileName = 0
		endif
	endif

	 let i = 1
	 while i <= tabpagenr('$')
		 let buflist = tabpagebuflist(i)
		 let winnr = tabpagewinnr(i)
		 let s .= '%' . i . 'T'
		 let s .= (i == t ? '%1*' : '%2*')
		 let s .= ' '
		 let s .= '%#TabNum#'
		 let s .= i . ' '
		 let s .= '%*'
		 let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

		 if needShowFileName == 1
			 let file = bufname(buflist[winnr - 1])
			 let file = fnamemodify(file, ':p:t')
			 if file == ''
				 let file = '[No Name]'
			 endif
			 if needShort == 1
				let fileNameLenght = strlen(file)
				if fileNameLenght > (maxLengthPerFile - 3)
					let file = strpart(file,fileNameLenght + 3 - maxLengthPerFile)
				endif	
			 endif

			 let s .= file
		 endif
		 let i = i + 1
	 endwhile

	 let s .= '%T%#TabLineFill#%='
	 "let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
	 return s
endfunction


hi TabNum ctermfg=White ctermbg=2
hi TabLineSel term=bold cterm=bold ctermbg=Red ctermfg=yellow
hi TabLine ctermfg=yellow ctermbg=DarkGray
set stal=2
set tabline=%!MyTabLine()

"let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'

"autocmd VimEnter * ConqueTermTab bash

if has("cscope")
      set csprg=/usr/bin/cscope
      "set csto=0:先搜索cscope数据库，再搜索.tags文件 
      set csto=0
      "set cst: 使用cs find g 来搜索，而不是tag
      set cst
      set nocsverb
      " add any database in current directory
      if filereadable("cscope.out")
          cs add cscope.out
      " else add database pointed to by environment
      elseif $CSCOPE_DB != ""
          cs add $CSCOPE_DB
      endif
      set csverb
      "set cscopequickfix=s-!,c-!,d-,i-,t-,e-,f-,g-!
      "set cscopequickfix=s-!,c-!,d-!,i-!,t-!,e-!,f-!,g-!
      "autocmd QuickFixCmdEnd * exe "cw"
endif

 "查找这个C符号 表示先按下ctrl+\，然后在按1|2|3|4|5|6|7|8
    nmap <C-\>1 :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>2 :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>3 :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>4 :cs find f <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>5 :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>6 :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>7 :cs find s <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>8 :cs find t <C-R>=expand("<cword>")<CR><CR>

    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>s :cs find s <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
