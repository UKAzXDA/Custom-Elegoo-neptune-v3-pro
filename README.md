<img src="elegoo.webp">

## 🛠️ Pós-Processamento (Regex)

💉 Localizar e Substituir para o fatiador.

### 💉 Regra 1:
* **🔍 Achar:**
```text
G1 Z.2 F9000
```
* **✏️ Substituir:**
```text
;YLU --\nG1 F12000\n;YLU --
```

### 💉 Regra 2:
* **🔍 Achar:**
```text
;TYPE:Skirt/Brim
```
* **✏️ Substituir:**
```text
;YLU --\nG1 Z.2 F9000\n;G1 E1 F2400\nG4 S5\n;YLU --
```

### ▶️ G-code de Início
```gcode
;YLU ------------------------------------------------------------------
M107                      ; Desliga fan
M104 S[first_layer_temperature] ; Aquecimento bico
M140 S[first_layer_bed_temperature] ; Aquecimento mesa
G90                       ; Usa coordenadas absolutas
M83                       ; Extrusora em modo relativo
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
G4 S600                   ; Espera 10 min
M107                      ; Desliga fan
;YLU ------------------------------------------------------------------
```

### 🧲 Abaixo estão os parâmetros de adesão à mesa utilizados neste perfil.

| Parâmetro | Valor |
| :--- | :--- |
| **Saia (Skirt) - Voltas** | 0 (Desativado) |
| **Tipo de Aba (Brim)** | Somente aba externa |
| **Largura da Aba** | 2 mm |
| **Espaçamento da Borda** | 0,2 mm |

### 💾 Configurações de Saída.

**Padrão de nome do arquivo:**
```text
{input_filename_base}_{print_time}.gcode
```

### 💾 Padrão GCODE atualizado:

### ▶️ G-code de Início
```gcode
;ELEGOO NEPTUNE 4 / 4 PRO / 3 PRO
M220 S100 ;Set the feed speed to 100%
M221 S100 ;Set the flow rate to 100%
M104 S140 ;Start heating extruder
M190 S{first_layer_bed_temperature} ;Wait for the bed to reach print temp
G90
G28 ;home
G1 Z10 F300
G1 X67.5 Y0 F6000
G1 Z0 F300
M109 S{first_layer_temperature} ;Wait for extruder to reach print temp
G92 E0 ;Reset Extruder
G1 X67.5 Y0 Z0.4 F300 ;Move to start position
G1 X167.5 E30 F400 ;Draw the first line
G1 Z0.6 F120.0 ;Move to side a little
G1 X162.5 F3000
G92 E0 ;Reset Extruder
```
### ⏹️ G-code Final
```gcode
G91 ;Relative positioning
G1 E-2 F2700 ;Retract a bit
G1 E-2 Z0.2 F2400 ;Retract and raise Z
G1 X5 Y5 F3000 ;Wipe out
G1 Z2 ;Raise Z more
G90 ;Absolute positioning
G1 X0 Y[print_bed_max_y - 5] ; Present print
M106 S0 ;Turn-off fan
M104 S0 ;Turn-off hotend
M140 S0 ;Turn-off bed
M84 X Y E ;Disable all steppers but Z
```
