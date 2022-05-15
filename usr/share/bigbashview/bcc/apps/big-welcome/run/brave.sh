#!/usr/bin/env bash

#Translation
export TEXTDOMAINDIR="/usr/share/locale"
export TEXTDOMAIN=biglinux-welcome

windowID="$(xprop -root '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)"

BROWSER=brave-browser.desktop
PROG=$(xdg-mime default $BROWSER x-scheme-handler/http)
PROG2=$(xdg-mime default $BROWSER x-scheme-handler/https)
PROG3=$(xdg-settings set default-web-browser $BROWSER)

if [ -n "$PROG" ] || [ -n "$PROG2" ] || [ -n "$PROG3" ]; then
	kdialog --attach="$windowID" --title $"Navegador Padrão" \
--sorry $"Atenção! O navegador $BROWSER está aberto!\nEle será fechado para que a restauração tenha efeito."
	RET="$?"
	[ "$RET" == "0" ] && kill -9 $BROWSER
fi

kdialog --attach="$windowID" --title $"Navegador Padrão" \
		--msgbox $"O navegador $BROWSER foi definido como padrão com sucesso!"
exit
