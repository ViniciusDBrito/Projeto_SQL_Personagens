-- 1. Liste todas as colunas e linhas das tabelas personagem, estudio e tipo.

SELECT * FROM personagem;
SELECT * FROM estudio;
SELECT * FROM tipo;
SELECT * FROM personagem_heroi;

/* 2. Liste o id, nome, data de criação e valor de mercado dos personagens. 
      Ordene os resultados por nome. */

SELECT ID, NOME, DATA_CRIACAO, VALOR_MERCADO
  FROM personagem
 ORDER BY NOME;

/* 3. Liste o id, nome, idade, sexo e valor de mercado dos personagens com idade
	  superior a 70 e do sexo masculino. Ordene os resultados por valor de mercado
      de forma decrescente (do maior para o menor)*/

SELECT ID, NOME, IDADE, SEXO, VALOR_MERCADO
  FROM personagem
 WHERE IDADE > 70 AND SEXO = 'M'
 ORDER BY VALOR_MERCADO DESC;

/* 4. Liste o id, nome, idade e id do tipo dos personagens com idade superior a 30
      e que sejam dos tipos 1 ou 2. Ordene os resultados por tipo de forma
      crescente e depois por idade de forma decrescente*/

SELECT ID, NOME, IDADE, ID_tipo
  FROM personagem
 WHERE IDADE > 30 AND ID_TIPO IN (1,2)
 ORDER BY ID_TIPO, IDADE DESC;

/* 5. Liste o nome, data de criação, sexo e id do estúdio dos personagens criados
      entre 1920 e 1960 e que pertençam necessariamente a algum estúdio. 
      Ordene os resultados primeiro por sexo (crescentemente) e depois por
      data de criação (decrescentemente). */

SELECT NOME, DATA_CRIACAO, SEXO, ID_ESTUDIO
  FROM personagem
 WHERE DATA_CRIACAO BETWEEN '1920-01-01' AND '1960-12-31' 
   AND ID_ESTUDIO IS NOT NULL
 ORDER BY sexo, data_criacao DESC;

/* 6. Liste todas as colunas dos personagens masculinos dos tipos 1 ou 2, ou
      dos personagens femininos dos tipos 3 ou 4. Ordene os resultados por tipo */

SELECT *
  FROM personagem
 WHERE (ID_TIPO IN (1, 2) AND SEXO = 'M') OR (ID_TIPO IN (3, 4) AND SEXO = 'F')
 ORDER BY ID_TIPO;

/* 7. Liste o nome, id do estúdio e idade dos personagens que não possuem estúdios
      associados a eles. */

SELECT NOME, ID_ESTUDIO, IDADE
  FROM personagem
 WHERE ID_ESTUDIO IS NULL;
 
-- 8. Liste o nome dos personagens que começam com a letra B.

SELECT NOME
  FROM personagem
 WHERE NOME LIKE 'B%';

/* 9. Liste o id, nome e idade dos personagens onde a segunda letra do nome
      seja "u" ou a antepenúltima letra do nome seja "s", e cujas idades
      sejam inferior a 50 anos. Ordene os resultados por nome. */

SELECT ID, NOME, IDADE
  FROM personagem
 WHERE (NOME LIKE '_u%' OR NOME LIKE '%s__') AND IDADE < 50
 ORDER BY nome;

/* 10. Liste o nome, id do tipo e valor de mercado dos personagens com
       valor de mercado entre 30 mil e 80 mil.
       Ordene os resultados por tipo e, dentro do tipo, por valor de mercado. */

SELECT NOME, ID_TIPO, VALOR_MERCADO
  FROM personagem
 WHERE valor_mercado BETWEEN 30000 AND 80000
 ORDER BY id_tipo, valor_mercado;

/* 11. Liste o nome em letras maiúsculas e também as 6 primeitas letras do nome
       dos personagens femininos com idade inferior a 50.
       Apelide as colunas de NOME_MAIUCULO e PROP_INIC. */

SELECT UPPER(NOME) AS NOME_MAIUSCULO, SUBSTR(NOME,1,6) PROP_INIC
  FROM personagem
 WHERE IDADE < 50 AND SEXO = 'F';
 
/* 12. Liste a data de criação mais antiga e a data de criação mais nova
       dos personagens. Apelide as colunas de DATA_MAIS_ANTIGA e DATA_MAIS_NOVA. */

SELECT MIN(DATA_CRIACAO) AS "DATA MAIS ANTIGA", MAX(DATA_CRIACAO) AS "DATA MAIS NOVA"
  FROM personagem;

/* 13. Liste o id do tipo e a quantidade de personagens de cada id de tipo,
       considerando apenas os personagens que pertençam a algum estúdio.
       Ou seja, NÃO devem aparecer nos resultados personagens que não pertençam
       a nenhum estúdio */

SELECT ID_TIPO, COUNT(*) QTDE
  FROM personagem
 WHERE ID_ESTUDIO IS NOT NULL
 GROUP BY ID_TIPO;

/* 14. Liste o id do tipo e a média de idade para cada tipo de personagem.
       Ordene os resultados por média de idade decrescentemente. Trunque a
       média de idade para exibir apenas 0 casas decimais. 
       Apelide a coluna referente à média de idade de MEDIA_IDADE. */

SELECT ID_TIPO, TRUNC(AVG(IDADE),0) AS MEDIA_IDADE
  FROM personagem
 GROUP BY ID_TIPO
 ORDER BY MEDIA_IDADE;

/* 15. Liste o id_estudio, a somatória do valor de mercado e a média do valor
       de mercado apenas para os ids de estúdio 10, 30 e 50. Apelide as colunas
       referentes à soma e à média de SOMA_MERCADO e MEDIA_MERCADO, respectivamente.
       Arredonde a soma e média para 2 casas decimais apenas. */

SELECT ID_ESTUDIO, ROUND(SUM(VALOR_MERCADO),2) SOMA_MERCADO,
       ROUND(AVG(VALOR_MERCADO),2) MEDIA_MERCADO
  FROM personagem
 WHERE ID_ESTUDIO IN (10, 30, 50)
 GROUP BY id_estudio;

/* 16. Liste o id do tipo, sexo e a quantidade de personagens de cada tipo e sexo,
       isto é, quantos personagens masculinos e quantos femininos existem dentro
       de cada id de tipo. Apelide a coluna referente à quantidade de QTDE. 
       Deixe na listagem final apenas os tipos/sexo que possuam quantidade
       maior que 2. */

SELECT ID_TIPO, SEXO, COUNT(*) AS QTDE
  FROM personagem
 GROUP BY ID_TIPO, SEXO
HAVING COUNT(*) > 2
ORDER BY 1, 2;

/* 17. Liste o id do estúdio e a maior idade apenas dos personagens que possuem
       id de estúdio cadastrados. Deixe na listagem final apenas os ids de estúdios
       cuja idade maior do personagem seja maior que 30. Apelide a coluna referente
       à maior idade de IDADE. Ordene os resultados por idade. */

SELECT ID_ESTUDIO, MAX(IDADE) AS IDADE
  FROM personagem
 WHERE ID_ESTUDIO IS NOT NULL
 GROUP BY ID_ESTUDIO
HAVING MAX(IDADE) > 30
 ORDER BY IDADE;

-- 18. Liste o id e nome dos personagens e o id e nome do estúdio a que pertencem.
SELECT p.id, p.nome, e.id AS id_estudio, e.nome
  FROM personagem p JOIN estudio e ON p.id_estudio = e.id;
--ou
SELECT p.id, p.nome, e.id AS id_estudio, e.nome
  FROM personagem p, estudio e
 WHERE p.id_estudio = e.id;

/* 19. Liste o nome e idade dos personagens e o nome do estúdio a que pertencem.
       Inclua na listagem também os personagens que não estão vinculados a nenhum
       estúdio. Ordene os resultados por nome do estúdio */
SELECT p.nome, p.idade, e.nome
  FROM personagem p LEFT JOIN estudio e ON p.id_estudio = e.id
 ORDER BY e.nome;

/* 20. Liste o id e nome dos personagens, o id e nome do estúdio a que pertencem
       e o id e descrição de seus tipos. */

SELECT p.id as id_pers, p.nome as nome_pers, e.id AS id_estudio,
       e.nome as nome_estudio, t.id as id_tipo, t.descricao as descr_tipo
  FROM personagem p JOIN estudio e ON p.id_estudio = e.id
  JOIN tipo t ON p.id_tipo = t.id;
  
-- 21. Liste o nome do personagem e o nome de seu inimigo

SELECT p.nome as nome_personagem, i.inimigo as nome_inimigo
  FROM personagem p JOIN personagem_heroi i ON p.id = i.id;

/* 22. Liste o nome dos personagens, o nome do estúdio a que pertence, a descrição
       de seus tipos e o nome do seu inimigo (se houver). Todos os personagens
       devem aparecer na listagem final, independentemente de estarem vinculados
       a um tipo, estúdio ou serem heróis e possuírem inimigo */

SELECT p.nome as nome_pers, e.nome as nome_estudio, t.descricao as descr_tipo,
       i.inimigo as nome_inimigo
  FROM personagem p LEFT JOIN estudio e ON p.id_estudio = e.id
  LEFT JOIN tipo t ON p.id_tipo = t.id 
  LEFT JOIN personagem_heroi i ON p.id = i.id;
  
/* 23. Liste o nome e o id do estúdio dos personagens que pertençam aos estúdios
       Disney ou Marvel. A consulta deve utilizar os nomes dos estúdios e não seus
       IDs. Utilize subconsulta para resolver o exercício */

SELECT nome, id_estudio
  FROM personagem
 WHERE id_estudio IN (SELECT id FROM estudio
                       WHERE nome IN ('Disney', 'Marvel'));

/* 24. Liste o nome e idade, bem como o id e a descrição do tipo a que pertencem,
       dos personagens que estão acima da idade média de todos os personagens.
       Ordene os resultados por idade decrescentemente. */

SELECT p.nome, p.idade, p.id_tipo, t.descricao
  FROM personagem p JOIN tipo t ON p.id_tipo = t.id 
 WHERE p.idade > (SELECT AVG(idade) FROM personagem)
 ORDER BY p.idade DESC;

/* 25. Liste o id, nome, id do tipo, idade e valor de mercado dos personagens que
       pertençam a algum estúdio e que são do tipo Terror ou Comédia */

SELECT id, nome, id_tipo, idade, valor_mercado
  FROM personagem
 WHERE id_estudio is not null
   AND id_tipo IN (SELECT id from tipo
                    WHERE descricao IN ('Terror', 'Comédia'));

/* 26. Liste o nome e valor de mercado dos personagens cujos valores de mercado
       sejam maiores do que os valores de mercado dos personagens Pato Donald e
       do Homem de Ferro. */

SELECT nome, valor_mercado
  FROM personagem
 WHERE valor_mercado > ALL (SELECT valor_mercado FROM personagem
                             WHERE nome IN ('Pato Donald','Homem de Ferro'));

/* 27. Liste o nome e o sexo dos personagens, bem como o nome do estúdio a que
       pertencem para os personagens do sexo masculino e que pertençam aos
       estúdios Disney ou DC Comics. Ordene os resultados por nome do estúdio. */
SELECT p.nome, p.sexo, e.nome
  FROM personagem p JOIN estudio e ON p.id_estudio = e.id
 WHERE p.sexo = 'M'
   AND e.nome IN ('Disney', 'DC Comics')
 ORDER BY e.nome;

/* 28. Liste o nome do personagem e o id do estudio dos personagens que pertençam
       necessariamente a algum estúdio. Utilize o operador EXISTS para resolver
	   o exercício */

SELECT p.nome, p.id_estudio
  FROM personagem p
 WHERE EXISTS (SELECT 1 FROM estudio e WHERE e.id = p.id_estudio);

/* 29. Liste o nome do personagem e o id do tipo dos personagens que não pertençam
       a nenhum tipo. Utilize o operador NOT EXISTS para resolver o exercício */

SELECT p.nome, p.id_tipo
  FROM personagem p
 WHERE NOT EXISTS (SELECT 1 FROM tipo t WHERE t.id = p.id_tipo);

/* 30. liste o id, nome e data de criação dos personagens que não possuem inimigos.
       Utilize o operador NOT EXISTS para resolver o exercício */

SELECT p.id, p.nome, p.data_criacao
  FROM personagem p
 WHERE NOT EXISTS (SELECT 1 FROM personagem_heroi i WHERE i.id = p.id);
 
/* 31. Crie uma view chamada V_HEROI_INFO que liste o nome e idade dos personagens, 
       o nome do estúdio a que pertencem, a descrição do tipo e o nome do inimigo dos 
	   personagens que também são herois. Ordene as tuplas da view por nome do estúdio e, 
	   na sequência, por nome do personagem. Chame as colunas na view de nome_personagem, 
	   idade, nome_estudio, tipo e inimigo */

CREATE OR REPLACE VIEW V_HEROI_INFO(nome_personagem, idade, nome_estudio, tipo, inimigo) AS
	SELECT p.nome, p.idade, e.nome, t.descricao, h.inimigo
	  FROM personagem p JOIN estudio e ON p.id_estudio = e.id
	  JOIN tipo t on p.id_tipo = t.id
	  JOIN personagem_heroi h on h.id = p.id
	  ORDER BY e.nome, p.nome;
	  
select * from v_heroi_info;

/* 32. Crie uma view chamada V_ESTUDIO_QTDE que liste o nome do estúdio e a quantidade
       de personagens que possui. Chame as colunas de nome_estudio e qtde_personagens, respectivamente.
	   Deixe na listagem somente os estúdios que tenham dois ou mais personagens. */

CREATE OR REPLACE VIEW V_ESTUDIO_QTDE(nome_estudio, qtde_personagens) AS
	SELECT e.nome, COUNT(*)
	  FROM estudio e, personagem p
	 WHERE p.id_estudio = e.id
	 GROUP BY e.nome
	HAVING COUNT(*) > 1;
	
select * from v_estudio_qtde;

/* 33. Crie uma view que liste o nome, data de criação, valor de mercado e id do estúdio
       dos personagens que são do tipo 2 e pertencem aos estúdios de nome 'Fox' ou 'Dark Horse Comics',
	   e dos personagens que são do tipo 3 e pertencem aos estúdios de nome 'DC Comics' ou 'Marvel'.
	   Utilize operadores de conjunto para ajudar na criação da view. */

CREATE OR REPLACE VIEW V_PERS_ESTUDIO_TIPO AS
	SELECT nome, data_criacao, valor_mercado, id_estudio
	  FROM personagem
	 WHERE id_estudio in (SELECT id FROM estudio
						   WHERE nome IN('Fox','Dark Horse Comics'))
	   and id_tipo = 2
	 UNION
	SELECT nome, data_criacao, valor_mercado, id_estudio
	  FROM personagem
	 WHERE id_estudio in (SELECT id FROM estudio 
						   WHERE nome IN('DC Comics','Marvel'))
	   and id_tipo = 3;

select * from v_pers_estudio_tipo;

/* 34. Crie uma listagem com 3 colunas para todos os personagens, sendo a primeira 
       coluna o id do personagem, a segunda o nome do personagem (quando houver) e 
	   a terceira o nome do inimigo (quando houver). Ordene os resultados por id.
	   Utilize operadores de conjunto para auxiliar na criação da listagem. */

SELECT id, nome as nome_personagem, null as nome_inimigo
  FROM personagem 
UNION
SELECT id, null, inimigo
  FROM personagem_heroi
 ORDER BY id;