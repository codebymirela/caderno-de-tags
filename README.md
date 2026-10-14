# Caderno de Tags

Bloco de notas pessoal organizado por tags. É um único arquivo HTML, sem instalação.

## O que ele faz

- **Tags**: pelo campo de tags ou escrevendo `#ideia` no meio do texto.
- **Pastas e subpastas**: botão **+ Pasta** na barra lateral, ou **+ Subpasta** dentro de uma pasta. No `⋯` da pasta dá para renomear, mover para dentro de outra, apagar e dar tags à pasta. As notas da pasta (e das subpastas) herdam essas tags. Para mudar uma nota de pasta, use o seletor abaixo do título ou arraste a nota da lista para a pasta.
- **Links entre notas**: escreva `[[Nome da nota]]` (aparecem sugestões ao digitar `[[`). Na visualização o link abre a nota; se ela não existir, é criada. No fim de cada nota aparece **"Mencionada em"**, com as notas que apontam para ela. Ao renomear uma nota, os links nas outras são atualizados. Use `[[Nome da nota|outro texto]]` para mostrar um texto diferente.
- **Imagens**: cole um print (`Ctrl+V`), arraste uma imagem para o texto ou use **+ Imagem**. As imagens são reduzidas para no máximo 1600 px e guardadas no Supabase Storage, numa pasta privada da sua conta. Precisa estar com a sincronização ativa.
- **Tamanho das imagens**: em **Visualizar**, clique na imagem e escolha Pequena, Média, Grande, Inteira ou Original, ou arraste o quadradinho do canto. No modo de edição, clicar numa miniatura leva direto para a imagem. O tamanho fica no texto, como no Obsidian: `![imagem|50%](...)` ou `![imagem|300](...)` (em pixels).
- **Markdown**: `**negrito**`, `*itálico*`, `# título`, `- lista`, `1. lista`, `> citação`, `` `código` ``, `[texto](https://link)`. O botão **Visualizar** (`Ctrl+Alt+P`) alterna entre editar e ver formatado. Dois cliques na visualização voltam para a edição.
- **Tarefas**: linhas com `[ ]` ou `- [ ]` viram caixas de marcar na visualização. A lista mostra o progresso (☑ 2/5).
- **Editar tags**: passe o mouse sobre uma tag na barra lateral e clique em `⋯` para renomear, juntar com outra (é só renomear para um nome que já existe), escolher a cor ou tirar a tag de todas as notas.
- **Ordenar**: por última edição, por data de criação ou por título.
- **Fixar** notas no topo.
- **Lixeira**: notas apagadas ficam 30 dias recuperáveis.
- **Modo foco** (`Ctrl+Alt+F`, `Esc` para sair): esconde as colunas.
- **Backup**: exporta tudo em JSON (para importar de volta) ou em Markdown (para ler em qualquer editor). A importação aceita `.json`, `.md` e `.txt`.
- **Sincronização** entre aparelhos com o Supabase (opcional, gratuito).

Atalhos: `Ctrl+Alt+N` cria uma nota nova.

## Arquivos

| Arquivo | Para quê |
|---|---|
| `index.html` | O aplicativo. É o arquivo que você edita e publica. |
| `config.js` | Configuração da sincronização. Pode ficar vazio. |
| `supabase.sql` | Cria a tabela de notas no Supabase. |
| `supabase-imagens.sql` | Cria o espaço privado para as imagens no Supabase Storage. |
| `icon.svg`, `icon-*.png` | Ícone do caderno. |
| `wrangler.jsonc`, `.assetsignore` | Publicação na Cloudflare. |
| `caderno.html` | Cópia gerada para o Artifact do claude.ai. Não edite à mão. |

## Usar sem sincronização

Abra o `index.html` no navegador. As notas ficam salvas **só naquele navegador**. Use **Exportar JSON** de vez em quando como backup.

## Ativar a sincronização (Supabase, plano gratuito)

1. Crie uma conta em https://supabase.com e um projeto novo.
2. No projeto, abra **SQL Editor → New query**, cole o conteúdo de `supabase.sql` e clique em **Run**. Faça o mesmo com `supabase-imagens.sql` para poder colar imagens.
3. Em **Authentication → URL Configuration**, coloque o endereço onde o caderno vai ficar (por exemplo `https://seunome.github.io/caderno-de-tags/`) em **Site URL** e também em **Redirect URLs**. Para testar no computador com o Live Server, adicione também `http://127.0.0.1:5500/**`.
4. Em **Project Settings → API**, copie a **Project URL** e a **anon public key** para o `config.js`.
5. Abra o caderno, clique em **Backup e sincronização**, digite seu e-mail e clique em **Entrar**. Abra o link que chegar no e-mail **no mesmo navegador**.

Faça o mesmo login no celular e as notas aparecem lá também. As notas que já estavam no navegador são enviadas para a nuvem no primeiro login. A sincronização roda ao abrir a página, ao voltar para a aba e a cada minuto.

Observações:
- A sincronização só funciona quando a página está num endereço `http(s)://`, como o GitHub Pages ou o Live Server. Abrindo o arquivo direto (`file://`), o login por e-mail não volta para a página.
- Projetos gratuitos do Supabase são pausados depois de uma semana sem uso. Basta reativar no painel. As notas continuam salvas no navegador enquanto isso.
- Se duas pessoas editarem a mesma nota em aparelhos diferentes ao mesmo tempo, fica a versão salva por último.

## Hospedar de graça

- **GitHub Pages**: suba os arquivos para um repositório e ative em **Settings → Pages → Branch: main**.
- **Cloudflare Pages**, **Netlify** ou **Vercel**: conecte o repositório ou arraste a pasta.
