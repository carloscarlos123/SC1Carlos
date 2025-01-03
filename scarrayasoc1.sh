#! /bin/bash
clear

declare -A colores

if [ $# -eq 0 ]; then
	echo "Debes añadir obligatoriamente un color por parametro por lo menos"
else
	echo "Has introducido $# colores"

	for color in $@; do
		color_fich=$(cat /home/usuario/colores.txt | grep $color | cut -d ":" -f1)
		hex=$(cat /home/usuario/colores.txt | grep $color | cut -d ":" -f2)
		if [[ "$color_fich" == "$color" ]]; then
			colores[$color]=$hex
		fi
	done

	echo "Colores introducidos:"
	for color in ${!colores[@]}; do
		echo "$color: ${colores[$color]}"
	done

	read -p "¿De que color quieres el fondo? " fondo
	colorback=${colores[$fondo]}
	read -p "¿De que color quieres el div? " div
	colordiv=${colores[$div]}
	read -p "De que color quieres el texto? " texto
	colortext=${colores[$texto]}


	for ima in $(cat /home/usuario/imagenes.txt); do
		echo $ima
	done
	read -p "¿Qué imagen eliges?" imagen


	texto_ej=$(ifconfig)
	crear_html="<style>body{background: #$colorback;}div{background: #$colordiv;}p{color: #$colortext;}</style><body><div><p>$texto_ej<p></div><img src="imagenes/$imagen.png"><body>"

	echo $crear_html > index.html
	sudo docker-compose up -d --force-recreate
fi
