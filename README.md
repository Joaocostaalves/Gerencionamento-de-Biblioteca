# 📚 Gerenciamento de Biblioteca

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![Database](https://img.shields.io/badge/Database-Relational-green)
![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow)

Este projeto tem como objetivo demonstrar a modelagem e implementação de um sistema de gerenciamento de biblioteca, focando na organização de acervos, controle de usuários e fluxo de empréstimos.

## 📝 Sobre o Projeto

O sistema foi concebido para resolver problemas comuns de logística em bibliotecas, como o rastreio de livros disponíveis, prazos de devolução e histórico de leitores. Através de scripts SQL, estruturamos as tabelas e relacionamentos necessários para garantir a integridade dos dados.

## 🚀 Funcionalidades Principais

* **Cadastro de Acervo:** Registro detalhado de livros, autores e categorias.
* **Gestão de Usuários:** Controle de leitores e informações de contato.
* **Controle de Empréstimos:** Registro de saídas e entradas de livros com datas de devolução.
* **Consultas Avançadas:** Relatórios de livros mais lidos e usuários inadimplentes.

## 🛠️ Tecnologias Utilizadas

* **SQL:** Linguagem para manipulação e consulta de dados.
* **Modelagem Relacional:** Estrutura baseada em normalização de dados.
* **PostgreSQL**: Sistema de banco.

## 📂 Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes entidades principais:
* `Livros`: Título, ISBN, Ano de Publicação.
* `Autores`: Nome e Nacionalidade.
* `Usuarios`: Nome, CPF e Endereço.
* `Emprestimos`: Data de saída, data prevista e status.

## 💻 Exemplo de Consulta

Aqui está um exemplo de uma das consultas desenvolvidas para o projeto:

```sql
-- 01. INNER JOIN – Título do livro e nome da editora responsável
SELECT b.title AS "Título do Livro", p.name AS "Editora"
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id;
```

🗂️ Organização do Repositório

```
 ├── /ddl
    │   ├── 01_criacao_tabelas.sql
    │   ├── 02_inserir_dados.sql
    │   ├── 03_consultas.sql
    └── README.md
