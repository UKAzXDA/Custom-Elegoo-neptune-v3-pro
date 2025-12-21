# 🖨️ Custom G-Codes (PrusaSlicer / OrcaSlicer)

Este repositório contém scripts de **Start G-code** e **End G-code** otimizados para impressão 3D.
O código inicial possui uma rotina personalizada "YLU" que pré-aquece, faz o nivelamento e viaja rapidamente até o local exato onde a peça (ou saia) começará, aguardando 6 segundos para estabilização antes de iniciar.

> **Compatibilidade:** PrusaSlicer, SuperSlicer, OrcaSlicer.

---

## 🚀 Start G-code (Início)

Copie e cole este bloco na seção **Printer Settings > Custom G-code > Start G-code**.

```gcode
;YLU ------------------------------------------------------------------
M107                        ; Desliga fan
M104 S[first_layer_temperature] ; Define temp bico (sem esperar)
M140 S[first_layer_bed_temperature] ; Define temp mesa (sem esperar)
G90                         ; Coordenadas absolutas
M83                         ; Extrusora em relativo
G28                         ; Homing de todos os eixos
M420 S1                     ; Carrega a malha de nivelamento (se houver)

; -- Aquecimento e Preparo --
G1 X-2.5 F12000             ; Vai para a garagem (fora da mesa)
G1 Z5 F3000                 ; Levanta Z para 5mm (segurança para viagem)
M190 S[first_layer_bed_temperature] ; Espera mesa estabilizar
M109 S[first_layer_temperature]     ; Espera bico estabilizar

G92 E0                      ; Zera o contador do extrusor
G1 E2 F1000                 ; Extruda 2mm parado para preparar o bico
G92 E0                      ; Zera de novo

; -- O PULO DO GATO (Movimento até a peça) --
; Viaja rápido até a coordenada X e Y onde começa a primeira camada
G1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} F12000

; Desce suave para a altura da primeira camada
G1 Z[first_layer_height] F600

; -- ESPERA --
G4 S6                       ; Senta e espera 6s na posição de início
;YLU ------------------------------------------------------------------
