CREATE DATABASE Filmes;

drop table Atores;
drop table Filmes;
drop table Generos;
drop table ElencoFilme;
drop table FilmesGenero;

use Filmes;

-- Criação da tabela Atores
CREATE TABLE Atores (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    PrimeiroNome VARCHAR(50) NULL,
    UltimoNome VARCHAR(50) NULL,
    Genero VARCHAR(1) NULL
);

-- Criação da tabela Filmes
CREATE TABLE Filmes (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Nome VARCHAR(100) NULL,
    Ano INT NULL,
    Duracao INT NULL
);

-- Criação da tabela ElencoFilme
CREATE TABLE ElencoFilme (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    IdAtor INT  NOT NULL,
    IdFilme INT NULL,
    Papel VARCHAR(50) NULL,
    CONSTRAINT FK_ElencoFilme_Atores FOREIGN KEY (IdAtor) REFERENCES Atores(Id),
    CONSTRAINT FK_ElencoFilme_Filmes FOREIGN KEY (IdFilme) REFERENCES Filmes(Id)
);


CREATE TABLE Generos (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Genero VARCHAR(50) NULL
);

-- Criação da tabela FilmesGenero
CREATE TABLE FilmesGenero (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    IdGenero INT NULL,
    IdFilme INT NULL,
    CONSTRAINT FK_FilmesGenero_Generos FOREIGN KEY (IdGenero) REFERENCES Generos(Id),
    CONSTRAINT FK_FilmesGenero_Filmes FOREIGN KEY (IdFilme) REFERENCES Filmes(Id)
);




-- Inserir atores
INSERT INTO Atores (PrimeiroNome, UltimoNome, Genero)
VALUES
    ('Tom', 'Hanks', 'M'),
    ('Meryl', 'Streep', 'F'),
    ('Brad', 'Pitt', 'M'),
	('Ana', 'Maria', 'M'),
	('Fernanda', 'Silva', 'M'),
	('Gabi', 'Carla', 'F'),
	('Ana', 'Maria', 'F'),
	('Fernanda', 'Silva', 'F'),
	('Gabi', 'Carla', 'F');



	-- Inserir filmes
INSERT INTO Filmes (Nome, Ano, Duracao)
VALUES
    ('Forrest Gump', 1994, 142),
    ('O Diabo Veste Prada', 2006, 109),
    ('Clube da Luta', 1999, 139),
	('De Volta para o Futuro',1985,116),
	('Boogie Nights - Prazer Sem Limites',1997,155),
	('Princesa Mononoke - Prazer Sem Limites',1997,134),
	('Titanic - Prazer Sem Limites',1997,194),
	('Genio Indomavel - Prazer Sem Limites',1997,126);




	-- Inserir gêneros
INSERT INTO Generos (Genero)
VALUES
   
    ('Drama'),
    ('Comédia'),
    ('Ação'),
	('Misterio');



	-- Associar filmes aos gêneros
INSERT INTO FilmesGenero (IdGenero, IdFilme)
VALUES
    (4,7),
	(4,8),
    (1, 1),  -- Forrest Gump é do gênero Drama
    (2, 1),  -- Forrest Gump também é do gênero Comédia
    (2, 2),  -- O Diabo Veste Prada é do gênero Comédia
    (3, 3),  -- Clube da Luta é do gênero Ação
	(4,7),
	(4,8);



	-- Associar atores aos filmes
INSERT INTO ElencoFilme (IdAtor, IdFilme, Papel)
VALUES
    (1, 1, 'Forrest Gump'),          -- Tom Hanks em Forrest Gump
    (2, 2, 'Miranda Priestly'),      -- Meryl Streep em O Diabo Veste Prada
    (3, 3, 'Tyler Durden');          -- Brad Pitt em Clube da Luta



-- Seleciona o nome e o ano do filme
SELECT Nome,Ano FROM Filmes;


-- ordena o fime pelo ano em ordem crescente
SELECT Nome,Ano FROM Filmes ORDER BY Ano;

--  Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
SELECT Nome,Ano,Duracao FROM Filmes WHERE Nome = 'De Volta para o Futuro';

-- Busca filmes lancados em 1997
SELECT Nome,Ano,Duracao FROM Filmes WHERE Ano = '1997';

-- Busca filmes lancados apos o ano 2000
SELECT Nome,Ano,Duracao FROM Filmes WHERE Ano > 2000;


-- Buscar os filmes com a duracao maior que 100 e menor que 150, ordenando pela duracao em ordem crescente
SELECT  Nome,Ano, Duracao FROM Filmes WHERE Duracao > 100 AND Duracao < 150 ORDER BY Duracao ASC;


-- Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
SELECT Ano, COUNT(*) AS Quantidade
FROM Filmes
GROUP BY Ano
ORDER BY Quantidade DESC, Ano DESC;


-- Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
SELECT id, PrimeiroNome, UltimoNome,Genero
FROM Atores
WHERE Genero = 'M';


-- Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
SELECT id, PrimeiroNome, UltimoNome,Genero
FROM Atores
WHERE Genero = 'F'
ORDER BY PrimeiroNome;


-- Buscar o nome do filme e o gênero
SELECT F.Nome AS NomeDoFilme, G.Genero
FROM Filmes F
INNER JOIN FilmesGenero FG ON F.Id = FG.IdFilme
INNER JOIN Generos G ON FG.IdGenero = G.Id;


-- Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT F.Nome AS NomeDoFilme, G.Genero
FROM Filmes F
INNER JOIN FilmesGenero FG ON F.Id = FG.IdFilme
INNER JOIN Generos G ON FG.IdGenero = G.Id Where G.Genero = 'Misterio';


-- Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
SELECT F.Nome AS NomeDoFilme, A.PrimeiroNome, A.UltimoNome, EF.Papel
FROM Filmes F
INNER JOIN ElencoFilme EF ON F.Id = EF.IdFilme
INNER JOIN Atores A ON EF.IdAtor = A.Id;