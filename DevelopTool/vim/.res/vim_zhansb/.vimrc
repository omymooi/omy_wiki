"===========================================================================
" 项目: gvim 配置文件
" 作者: yonsan [QQ:82555472]
" 安装: sudo apt-get install vim-gtk
" 用法: 将本文件(.vimrc)拷贝到$HOME/
"===========================================================================
 
" 使用 murphy 调色板
colo sienna

" 设置用于GUI图形用户界面的字体列表。
"  set guifont=SimSun
"  set guifont=Ubuntu\ Mono\ 15  
set guifont=Courier\ 10\ Pitch\ 14  
set guioptions-=T " 隐藏工具栏
" set guioptions-=m " 隐藏菜单栏

" VIM 不使用和 VI 相容的模式
set nocompatible 
" 设定文件浏览器目录为当前目录
set bsdir=buffer
"  set autochdir
if has("multi_byte")
	" 设置编码
	set enc=utf-8
	" 设置文件编码
	set fenc=utf-8
	" 设置文件编码检测类型及支持格式
	set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
	" 指定菜单语言
	set langmenu=zh_CN.UTF-8
endif
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim
" 在搜索中忽略大小写
set ignorecase      
" 如果搜索中有大写字符，忽略 'ignorecase' 选项
set smartcase       
" 设置语法高亮度
set syn=cpp
"显示行号
set nu!
" 突出显示当前行
set cursorline 
" 查找结果高亮度显示
set hlsearch
" tab宽度
set tabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
" 用space替代tab的输入
set expandtab
" C/C++注释
set comments=://
" 修正自动C式样注释功能 <2005/07/16>
set comments=s1:/*,mb:*,ex0:/
" 增强检索功能
set tags=./tags,./../tags,./**/tags,./.tags
" 保存文件格式
set fileformats=unix,dos

" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2 
" 设置在状态行显示的信息
set statusline=\ %<%f[%1*%M%*%n%R%H]%=0x%B\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 

"
" 命令行高度
set cmdheight=1
" 中文帮助
if version > 603
set helplang=cn
endi

"-----------------------------------------------------------------
" plugin - cscope
" Ctrl+M,s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
" Ctrl+M,g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
" Ctrl+M,d: 查找本函数调用的函数
" Ctrl+M,c: 查找调用本函数的函数
" Ctrl+M,t: 查找指定的字符串
" Ctrl+M,e: 查找egrep模式，相当于egrep功能，但查找速度快多了
" Ctrl+M,f: 查找并打开文件，类似vim的find功能
" Ctrl+M,i: 查找包含本文件的文件
"-----------------------------------------------------------------
if has("cscope")
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
" 把Cscope的查找结果输出到quickfix窗口
set cscopequickfix=s-,c-,d-,i-,t-,e-
set csverb
nmap <C-M>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-M>g :cs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-M>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-M>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-M>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-M>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-M>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-M>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>

map <C-F11> :!cscope -Rbq -f cscope.out<CR>
endif

"-----------------------------------------------------------------
" plugin - catgs
" Ctrl+F12 生成tags文件
"-----------------------------------------------------------------
map <C-F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"-----------------------------------------------------------------
" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
let g:neocomplcache_enable_quick_match=1 
let g:AutoComplPop_NotEnableAtStartup = 1
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_TagsAutoUpdate = 1
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_MinSyntaxLength = 3
let g:NeoComplCache_EnableSkipCompletion = 1
let g:NeoComplCache_SkipInputTime = '0.5'
let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" snippets expand key
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

"-----------------------------------------------------------------
" plugin - OmniCppComplete 类或结构体的属性或方法的提示和补全
"-----------------------------------------------------------------
set nocp  
filetype plugin on  

"-----------------------------------------------------------------
" plugin - taglist.vim 查看函数列表，需要ctags程序
" F4 打开隐藏taglist窗口
"-----------------------------------------------------------------
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
nnoremap <silent><F5> :TlistToggle<CR>
let Tlist_Show_One_File = 1 " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 " 如果taglist窗口是最后一个窗口，则退出vim
"  let Tlist_Use_Right_Window = 1 " 在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close=1 " 自动折叠当前非编辑文件的方法列表
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
" let Tlist_GainFocus_On_ToggleOpen=1	"Jump to taglist window on open.

"-----------------------------------------------------------------
" F2 保存session到.svim
"-----------------------------------------------------------------
map <C-F9> :mks! .svim<CR>

"-----------------------------------------------------------------
" c 复制所选内容到系统粘帖板
"-----------------------------------------------------------------
map <C-c> "+y

" vim无参数时，默认打开上次对话
if filereadable(".svim") &&  argc() == 0
	source .svim
endif
