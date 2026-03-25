-- 01. INNER JOIN – Título do livro e nome da editora responsável
SELECT b.title AS "Título do Livro", p.name AS "Editora"
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id;

-- 02. LEFT JOIN – Todos os livros e suas categorias, incluindo livros sem categoria
SELECT b.title AS "Título do Livro", c.name AS "Categoria"
FROM books b
LEFT JOIN categories c ON b.id = c.id;

-- 03. INNER JOIN – Registros de empréstimos e o nome do leitor
SELECT l.id AS "ID do Empréstimo", u.full_name AS "Nome do Leitor",
       l.loan_date AS "Data do Empréstimo", l.status AS "Situação"
FROM loans l
INNER JOIN users u ON l.user_id = u.id;

-- 04. INNER JOIN – Título do livro e nome do seu respectivo autor
SELECT b.title AS "Título do Livro", a.name AS "Autor"
FROM books b
INNER JOIN author_book ab ON b.id = ab.book_id
INNER JOIN authors a ON a.id = ab.author_id;

-- 05. LEFT JOIN – Todas as editoras e seus livros, incluindo editoras sem livros
SELECT p.name AS "Editora", b.title AS "Título do Livro"
FROM publishers p
LEFT JOIN books b ON b.publisher_id = p.id;

-- 06. INNER JOIN – Empréstimos ativos e data prevista de devolução
SELECT l.id AS "ID do Empréstimo", u.full_name AS "Leitor",
       bc.barcode AS "Código do Exemplar", l.due_date AS "Data Prevista de Devolução"
FROM loans l
INNER JOIN loan_items li ON li.loan_id = l.id
INNER JOIN book_copies bc ON bc.id = li.book_copy_id
INNER JOIN users u ON u.id = l.user_id
WHERE l.status = 'ativo';

-- 07. INNER JOIN – Livro e a estante/seção física onde está guardado
SELECT b.title AS "Título do Livro", bc.barcode AS "Código do Exemplar",
       bc.location AS "Localização Física"
FROM books b
INNER JOIN book_copies bc ON bc.book_id = b.id;

-- 08. RIGHT JOIN – Todas as categorias e os livros associados, incluindo categorias vazias
SELECT c.name AS "Categoria", b.title AS "Título do Livro"
FROM books b
RIGHT JOIN categories c ON b.id = c.id;

-- 09. INNER JOIN – Histórico de um livro específico com todos os leitores que o pegaram
SELECT b.title AS "Título do Livro", u.full_name AS "Leitor",
       l.loan_date AS "Data do Empréstimo", l.return_date AS "Data de Devolução",
       l.status AS "Situação"
FROM books b
INNER JOIN book_copies bc ON bc.book_id = b.id
INNER JOIN loan_items li ON li.book_copy_id = bc.id
INNER JOIN loans l ON l.id = li.loan_id
INNER JOIN users u ON u.id = l.user_id
WHERE b.id = 1;

-- 10. LEFT JOIN – Todos os leitores e quantidade de empréstimos, incluindo quem nunca pegou
SELECT u.full_name AS "Leitor", COUNT(l.id) AS "Total de Empréstimos"
FROM users u
LEFT JOIN loans l ON l.user_id = u.id
GROUP BY u.id, u.full_name
ORDER BY "Total de Empréstimos" DESC;

-- 11. INNER JOIN – Título do livro e o idioma em que foi cadastrado
SELECT b.title AS "Título do Livro", b.language AS "Idioma"
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id;

-- 12. INNER JOIN – Editora com telefone e contato registrados no catálogo
SELECT p.name AS "Editora", p.phone AS "Telefone",
       p.email AS "E-mail de Contato", p.website AS "Website"
FROM books b
INNER JOIN publishers p ON b.publisher_id = p.id
GROUP BY p.id, p.name, p.phone, p.email, p.website
ORDER BY p.name;
