" Yeeaaaah baby

let g:is_gui = 1

" grr
let g:loaded_ginit = 1

" let s:font_family = 'PragmataProForPowerline Nerd Font'
let s:font_family = 'Monisomme'
let s:font_size = 14

if exists('GuiFont')
    execute 'GuiFont!' fnameescape(printf('%s:h%d', s:font_family, s:font_size))
elseif exists('rpcnotify')
	" neovim-gtk
	call rpcnotify(1, 'Gui', 'Font', fnameescape(printf('%s:h%d', s:font_family, s:font_size)))
endif
