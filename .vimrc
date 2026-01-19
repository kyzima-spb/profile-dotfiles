" Функция для настройки отступов для YAML
function! SetYAMLIndent()
  " Получаем текущую строку
  let l:line = getline('.')

  " Определяем текущий уровень вложенности по количеству начальных пробелов
  let l:indent_level = indent('.') / &shiftwidth

  " Если строка заканчивается двоеточием, увеличиваем уровень вложенности
  if l:line =~ ':$'
    let l:indent_level += 1
  endif

  " Возвращаем новую строку с нужным количеством пробелов
  return "\<CR>" . repeat(' ', l:indent_level * &shiftwidth)
endfunction


" Функция для удаления отступа в 2 пробела при нажатии Backspace
function! SmartBackspace()
  " Получаем текущую строку и позицию курсора
  let l:col = col('.') - 1  " Текущая колонка, нумерация с нуля

  " Если курсор находится на позиции, кратной 2 пробелам, и до этого пробелы
  if l:col > 0 && getline('.')[l:col - (&shiftwidth - 1) : l:col] =~ '^\s\+$'
    return repeat("\<BS>", &shiftwidth)
  else
    return "\<BS>"
  endif
endfunction


set background=dark
set t_Co=256

syntax on

set number
set tabstop=4 shiftwidth=4 expandtab
"set autoindent

filetype indent on

" Отключение автоотступов для файлов указанных файлов
" Настройка отступов в 2 пробела
" Использование функции для установки отступа при вводе новой строки
autocmd FileType html,javascript,json,yaml setlocal
  \ noautoindent nosmartindent nocindent indentexpr= formatoptions-=cro
  \ shiftwidth=2 tabstop=2 expandtab |
  \ inoremap <expr> <CR> SetYAMLIndent()

" Привязка функции SmartBackspace к клавише Backspace для автоматического удаления отступа
inoremap <expr> <BS> SmartBackspace()
