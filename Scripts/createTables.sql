CREATE TABLE estudio (
	id INT NOT NULL,
	nome VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE tipo (
	id INT NOT NULL,
	descricao VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE personagem (
  id INT NOT NULL,
  nome VARCHAR(30),
  data_criacao DATE,
  idade INT,
  sexo char(1),  
  id_estudio INT,
  id_tipo INT,
  valor_mercado NUMERIC(8,2),
  PRIMARY KEY (id),
  FOREIGN KEY (id_estudio) REFERENCES estudio(id),
  FOREIGN KEY (id_tipo) REFERENCES tipo(id)
);

-- Especialização de Personagem, apenas para os que são heróis e possuem inimigo
CREATE TABLE personagem_heroi (
	id INT NOT NULL,
    inimigo VARCHAR(30),
    FOREIGN KEY (id) REFERENCES personagem(id)
);

