# Neovim Config

Config modular para C, C++, Python, Bash, Rust y Lua.
Tema: **Rose Pine** con fondo negro.

## Instalacion

```bash
# Backup si tienes config anterior
mv ~/.config/nvim ~/.config/nvim.bak

# Copiar esta carpeta
cp -r nvim ~/.config/nvim

# Abrir nvim (instala todo automaticamente)
nvim
# Esperar a que lazy.nvim termine de instalar plugins (:Lazy para ver progreso)
```

## Dependencias del sistema

```bash
sudo apt install build-essential gdb python3 python3-pip nodejs npm ripgrep fd-find make unzip curl clang-format clang-tidy shfmt shellcheck
pip3 install black flake8 debugpy
cargo install stylua   # opcional, para formatear Lua
```

## Atajos principales

### Archivo
| Atajo | Accion |
|-------|--------|
| `Ctrl+S` | Guardar |
| `Ctrl+P` | Buscar archivos |
| `Ctrl+F` | Buscar en archivo (/ nativo) |
| `leader+e` | Explorador de archivos |
| `Tab / S-Tab` | Buffer siguiente/anterior |
| `leader+x` | Cerrar buffer |

### Compilar y ejecutar
| Atajo | Accion |
|-------|--------|
| `F5` / `Ctrl+Enter` | Compilar y ejecutar (pide argumentos) |
| `F6` | Build del proyecto (Makefile/Cargo/CMake) |

Lenguajes soportados: C, C++, Rust, Python, Bash, Lua, JavaScript, TypeScript, ASM

### Debugger
| Atajo | Accion |
|-------|--------|
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Continuar |
| `leader+du` | Toggle DAP UI |

### LSP
| Atajo | Accion |
|-------|--------|
| `K` | Documentacion hover |
| `leader+gd` | Ir a definicion |
| `leader+gr` | Ver referencias |
| `leader+ca` | Code actions |
| `leader+rn` | Renombrar simbolo |
| `leader+gf` | Formatear buffer |

### Navegacion
| Atajo | Accion |
|-------|--------|
| `Ctrl+h/j/k/l` | Moverse entre paneles |
| `Ctrl+\` | Toggle terminal |
