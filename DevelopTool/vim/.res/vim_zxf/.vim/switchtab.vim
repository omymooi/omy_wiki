function! TabPos_ActivateBuffer(num)  
	let s:count = a:num   
	exe "tabfirst"  
	exe "tabnext" s:count    
endfunction  

function! TabPos_Initialize()  
	for i in range(1, 9)   
		exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"  
	endfor  
	exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"  
endfunction  

autocmd VimEnter * call TabPos_Initialize() 
