#!/bin/bash

NAME_FILE="new.gcode"
TEMPERATURA_MESA=230
TEMPERATURA_BICO=70

GCODE_INICIAL='; -----------------------------------------------------------------
M106 S128                 ; Ligar fan 100%
M109 S80                  ; Esperar temperatura nozzle
M107                      ; Desliga fan
G90                       ; Usa coordenadas absolutas
M83                       ; Extrusora em modo relativo
G28                       ; Homing de todos os eixos
M420 S1                   ; Carrega a malha de nivelamento
G1 Z0 F240                ; Move o bico para 0 mm acima da mesa
G92 E0                    ; Zera o extrusor
; -----------------------------------------------------------------'

GCODE_FINAL='; -----------------------------------------------------------------
M140 S0                   ; Desliga aquecimento da mesa
M104 S0                   ; Desliga bico
M106 S128                 ; Ligar fan 100%
G1 X-2.5 F12000           ; Cabeçote para posição de garagem
G4 S600                   ; Espera 10 min
M107                      ; Desliga fan
M84 X Y E                 ; Desabilita motores
; -----------------------------------------------------------------'

awk '{ 
    sub(/;.*/,"");            # remove comentários
    sub(/^[[:space:]]+/,"");  # remove espaços do início
    sub(/[[:space:]]+$/,"");  # remove espaços do fim
    gsub(/[[:space:]]+/, " ");# normaliza espaços internos
    if(length) print           # imprime apenas linhas não vazias
}' "$NAME_FILE" > RAM

sed -i 's|M104.*||g' RAM
sed -i 's|M109.*||g' RAM
sed -i 's|M140.*||g' RAM
sed -i 's|M190.*||g' RAM

sed -i "s|YILURESERVADA|M190 S${TEMPERATURA_MESA} ; esperar temperatura mesa\\
M109 S${TEMPERATURA_BICO} ; esperar temperatura nozzle|" RAM

{
    echo "$GCODE_INICIAL"
    cat RAM
    echo "$GCODE_FINAL"
} > "$NAME_FILE"

rm RAM
echo "Processamento concluído: $NAME_FILE"
