<img src="elegoo.webp">

## 🛠️ Pós-Processamento (Regex)
| Parâmetro | Valor |
| :--- | :--- |
| **Altura da primeira camada** | 0,123 |

💉 Localizar e Substituir para o fatiador.

### 💉 Regra 1:
* **🔍 Achar:**
```text
G1 Z.123 F9000
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
;YLU --\nG1 Z0 F9000\nG1 E1 F2400\nG4 S5\n;YLU --
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
G4 S300                   ; Espera 5 min
M107                      ; Desliga fan
;YLU ------------------------------------------------------------------

```

### 🧲 Abaixo estão os parâmetros de adesão à mesa utilizados neste perfil.

| Parâmetro | Valor |
| :--- | :--- |
| **Saia (Skirt) - Voltas** | 0 (Desativado) |
| **Tipo de Aba (Brim)** | Somente aba externa |
| **Largura da Aba** | 3 mm |
| **Espaçamento da Borda** | 0,5 mm |
| **Velocidade primeira camada** | 5 |
| **Expansão da primeira camada** | 0 mm |

### 💾 Configurações de Saída.

**Padrão de nome do arquivo:**
```text
{input_filename_base}_{filament_type[0]}_{print_time}.gcode
```
