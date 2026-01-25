<img src="elegoo.webp">

### ▶️ G-code de Início
```gcode
;YLU ------------------------------------------------------------------
M220 S100                 ; Set the feed speed to 100%
M221 S100                 ; Set the flow rate to 100%
M107                      ; Desliga fan
M104 S[first_layer_temperature] ; Aquecimento bico
M140 S[first_layer_bed_temperature] ; Aquecimento mesa
G90                       ; Usa coordenadas absolutas
M82                       ; Extrusora em modo relativo
G28                       ; Homing de todos os eixos
M420 S1                   ; Carrega a malha de nivelamento
G1 X-2.5 F12000           ; Cabeçote para posição de garagem
M190 S[first_layer_bed_temperature] ; wait for bed temp to stabilize
M109 S[first_layer_temperature]     ; wait for nozzle temp
G1 Z2 F240                ; Move o bico para 2 mm acima da mesa
G92 E0                    ; Zera o extrusor
;YLU ------------------------------------------------------------------

```
### ⏹️ G-code Final
```gcode
;YLU ------------------------------------------------------------------
M140 S0                   ; Desliga aquecimento da mesa
M104 S0                   ; Desliga bico
M106 S128                 ; Ligar fan 100%
G1 X-2.5 F12000           ; Cabeçote para posição de garagem
M84 X Y E                 ; Desabilita motores
G4 S300                   ; Espera 5 min
M107                      ; Desliga fan
;YLU ------------------------------------------------------------------

```
