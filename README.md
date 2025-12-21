# 🖨️ Custom G-Codes (PrusaSlicer / OrcaSlicer)
> **Compatibilidade:** PrusaSlicer, SuperSlicer, OrcaSlicer.

---

## 🚀 Start G-code (Início)

Copie e cole este bloco na seção **Printer Settings > Custom G-code > Start G-code**.

```gcode
;YLU ------------------------------------------------------------------
M107                      ; Desliga fan
M104 S[first_layer_temperature] ; Define temp bico (sem esperar)
M140 S[first_layer_bed_temperature] ; Define temp mesa (sem esperar)
G90                       ; Coordenadas absolutas
M83                       ; Extrusora em relativo
G28                       ; Homing
M420 S1                   ; Carrega malha de nivelamento
G1 Z5 F3000               ; Levanta Z para 5mm (segurança para viagem)
G1 X-2.5 F12000           ; Vai para a garagem
M190 S[first_layer_bed_temperature] ; Espera mesa estabilizar
M109 S[first_layer_temperature]     ; Espera bico estabilizar
G1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} F12000 ; Viaja rápido até a coordenada X e Y (Peça ou Saia)
G1 Z[first_layer_height] F600 ; Desce suave para a altura da primeira camada
G92 E0                    ; Zera extrusor
G1 E2 F1000               ; Extruda 2mm parado para preparar o bico (purge inicial)
G92 E0                    ; Zera de novo
G4 S6                     ; Senta e espera 6 segundos na posição de início
;YLU ------------------------------------------------------------------
## 🚀 Start G-code (Final)
```
Copie e cole este bloco na seção **Printer Settings > Custom G-code > Start G-code**.

```gcode
;YLU ------------------------------------------------------------------
M140 S0                   ; Desliga aquecimento da mesa
M104 S0                   ; Desliga bico
M106 S128                 ; Ligar fan 100%
G1 X-2.5 F12000           ; Cabeçote para posição de garagem
M84 X Y E                 ; Desabilita motores
G4 S300                   ; Espera 5 min
M107                      ; Desliga fan
;YLU -------------------------------------------------------------------
```
