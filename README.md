# 🛡️ Bug Hunter Installer v2.0

![Bug Bounty](https://img.shields.io/badge/Bug-Bounty-red?style=for-the-badge&logo=securityscorecard)
![Bash](https://img.shields.io/badge/Shell-Script-blue?style=for-the-badge&logo=gnu-bash)
![Go](https://img.shields.io/badge/Go-Tools-00ADD8?style=for-the-badge&logo=go)
![Python](https://img.shields.io/badge/Python-Tools-3776AB?style=for-the-badge&logo=python)

O **Bug Hunter Installer** é um script de automação premium projetado para hackers éticos e caçadores de bugs que desejam configurar um ambiente de reconhecimento completo em minutos. 

Com uma interface visual dinâmica e uma seleção curada das melhores ferramentas do mercado, este script elimina a fadiga de configuração manual.

---

## ✨ Funcionalidades

- 🎨 **Interface Premium**: Banner ASCII, cores ANSI e animações de carregamento (spinner).
- ⚙️ **Automação Total**: Verifica e instala dependências como Go, Python3 e Git.
- 🚀 **Performance**: Instalações otimizadas com feedback em tempo real.
- 📦 **Arsenal Completo**: Mais de 15 ferramentas essenciais pré-configuradas.

---

## 🛠️ Arsenal de Ferramentas

### 🐹 Go-Based Tools
| Ferramenta | Descrição |
| :--- | :--- |
| **Subfinder** | Reconhecimento de subdomínios rápido. |
| **HTTPX** | Kit de ferramentas HTTP multiuso. |
| **Nuclei** | Scanner de vulnerabilidades baseado em templates. |
| **Naabu** | Scanner de portas focado em velocidade. |
| **FFUF** | Fuzzing de diretórios e parâmetros. |
| **Assetfinder** | Descoberta de ativos relacionados. |
| **GAU** | Get All URLs de várias fontes. |
| **Waybackurls** | Busca URLs no Wayback Machine. |
| **Hakrawler** | Crawler rápido para descoberta de endpoints. |

### 🐍 Python-Based Tools
- **Sqlmap**: Automação de injeção SQL.
- **Arjun**: Descoberta de parâmetros HTTP.
- **ParamSpider**: Mineração de parâmetros em URLs.
- **Dirsearch**: Bruteforce de diretórios e arquivos.
- **SecretFinder**: Extração de segredos e APIs em arquivos JS.
- **Waymore**: Download de respostas de arquivos arquivados.

---

## 🚀 Como Iniciar

### Pré-requisitos
O script foi testado em sistemas baseados em Debian/Ubuntu, mas funciona em qualquer Linux com `apt`.

### Instalação em um Passo
Basta clonar o repositório e executar o script:

```bash
chmod +x bughunterinstall.sh
./bughunterinstall.sh
```

---

## 📸 Demonstração Visual

Quando você executa o script, ele apresenta um dashboard dinâmico:

```text
  ██████╗ ██╗   ██╗ ██████╗      ██╗  ██╗██╗   ██╗███╗   ██╗████████╗███████╗██████╗ 
  ... (Banner estilizado) ...

ℹ Checking system environment...
✔ git is already installed
✔ go is already installed
⚠ pip3 is missing. Installing... [|]
```

---

## 📝 Notas de Configuração

Após a instalação, certifique-se de que o diretório de binários do Go está no seu PATH. Adicione as seguintes linhas ao seu `~/.bashrc` ou `~/.zshrc`:

```bash
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

---

## 🤝 Contribuição

Sinta-se à vontade para abrir issues ou enviar pull requests para adicionar novas ferramentas ou melhorar o design!

---

<p align="center">
  Desenvolvido com ❤️ para a comunidade de Bug Bounty.
</p>
