create database revenda_de_carros
default character set utf8
default collate utf8_general_ci;

/*
Este bloco de comandos
será para a criação 
de todas as tabelas
*/
/*
as matriculas 
100 a 105
são para a area de vendas
caixa, vendedor e marketing
*/
/*
as matriculas 
106 a 110
são para a area operacinal
lavador, despachante, mecanico, segurança, comprador
*/
/*
matricula 111
pertence ao contdor
responsavel pelo caixa
*/
drop table gerente, caixa, lavador,vendedor, marketing, cliente, contador, produto, despachante,mecanico, segurança, comprador, entregador;
drop table gerente;


# TABELA GERENTE
create table if not exists gerente(
matricula int not null unique,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
primary key (matricula)
);

# TABELA CAIXA
create table if not exists caixa(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
contador_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula),
foreign key (contador_matricula) references contador(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'caixa'
DELIMITER //
CREATE TRIGGER before_insert_caixa
BEFORE INSERT ON caixa
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela caixa
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'caixa';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM caixa WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA LAVADOR
create table if not exists lavador(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'lavador'
DELIMITER //
CREATE TRIGGER before_insert_lavador
BEFORE INSERT ON lavador
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela lavador
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'lavador';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM lavador WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;


# TABELA VENDEDOR
create table if not exists vendedor(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'vendedor'
DELIMITER //
CREATE TRIGGER before_insert_vendedor
BEFORE INSERT ON vendedor
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela vendedor
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'vendedor';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM vendedor WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA MARKETING
create table if not exists marketing(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'marketing'
DELIMITER //
CREATE TRIGGER before_insert_marketing
BEFORE INSERT ON marketing
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela marketing
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'marketing';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM marketing WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA CLIENTE
create table if not exists clientes(
id int not null auto_increment,
nome varchar(100) not null,
documento varchar(14) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
primary key (id)
);

# TABELA CONTADOR
create table if not exists contador(
matricula int not null unique,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
primary key (matricula)
);

# TABELA PRODUTO
create table if not exists produto(
id int auto_increment,
tipo varchar(250) not null,
modelo varchar(100) not null,
ano varchar(4) not null,
marca varchar(15),
cor varchar(50),
quilometragem decimal (10,3) not null,
primary key (id)
);

# TABELA DESPACHANTE
create table if not exists despachante(
id int auto_increment,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
primary key (id)
);

# TABELA MECANICO
create table if not exists mecanico(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
especialidade varchar(100),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'mecanico'
DELIMITER //
CREATE TRIGGER before_insert_mecanico
BEFORE INSERT ON mecanico
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela mecanico
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'mecanico';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM mecanico WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA SEGURANÇA
create table if not exists segurança(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'segurança'
DELIMITER //
CREATE TRIGGER before_insert_segurança
BEFORE INSERT ON segurança
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela segurança
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'segurança';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM segurança WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA COMPRADOR
create table if not exists comprador(
id int auto_increment,
matricula VARCHAR(20) UNIQUE,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
gerente_matricula int not null,
primary key (id),
foreign key (gerente_matricula) references gerente(matricula)
);

# TIGGER PARA ADICIONAR MATRICULA BASEADA NO ID PARA TABELA 'comprador'
DELIMITER //
CREATE TRIGGER before_insert_comprador
BEFORE INSERT ON comprador
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    
    -- Obter o próximo ID da tabela comprador
    SELECT AUTO_INCREMENT INTO next_id
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'comprador';
                  
    SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));

    -- Verificar se a matrícula gerada já existe na tabela
    WHILE EXISTS(SELECT 1 FROM comprador WHERE matricula = NEW.matricula) DO
        SET next_id = next_id + 1;
        SET NEW.matricula = CONCAT('MAT', LPAD(next_id, 5, '0'));
    END WHILE;
END //
DELIMITER ;

# TABELA ENTREGADOR
create table if not exists entregador(
id int auto_increment,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(15),
email varchar(300),
endereco varchar(300),
cnh enum ('A', 'B', 'C', 'D', 'E', 'AB', 'BC', 'BD', 'BE', 'AE') not null,
numero_cnh int(9) not null unique, 
primary key (id)
);

/*
Este bloco de comandos
será para a criação 
de todos os relacinamentos
*/

# HISTORICO_DE_VEICULOS_LAVADOS
	create table historico_veiculos_lavados(
		id int auto_increment, 
		id_lavador int not null,
        id_produto int not null,
        data_hora_lavagem datetime,
        primary key (id),
        foreign key (id_lavador) references lavador(id),
        foreign key (id_produto) references produto(id)
    );
# VENDAS

	create table vendas(
		id int auto_increment,
        id_vendedor int not null,
		id_cliente int not null,
        id_produto int not null,
        valor decimal (10,3) not null,
        data_hora_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_vendedor) references vendedor(id),
        foreign key (id_cliente) references clientes(id),
        foreign key (id_produto) references produto(id) 
    );

# DIVULGACAO

	create table divulgação (
		id int auto_increment,
        id_produto int not null,
        id_marketing int not null,
        data_divulgação date DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_produto) references produto(id),
        foreign key (id_marketing) references marketing(id)
    );

# ENTREGA

	create table entrega(
		id int auto_increment,
        id_entregador int not null,
        id_venda int not null,
        data_hora_entrega timestamp DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_entregador) references entregador(id),
        foreign key (id_venda) references vendas(id)
    );

# MANUTENCAO
	create table manutenção(
		id int auto_increment,
        id_mecanico int not null,
        id_produto int not null,
        data_hora_manutencao timestamp DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_mecanico) references mecanico(id),
        foreign key (id_produto) references produto(id)
    );
    
# HISTORICO_DE_DOCUMENTACAO
	create table historico_documentacao(
		id int auto_increment,
        id_despachante int not null,
        id_venda int,
        id_compra int,
        data_hora_manutencao timestamp DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_despachante) references despachante(id),
        foreign key (id_venda) references vendas(id),
        foreign key (id_compra) references compras(id)
    );
    
    DELIMITER //

	CREATE TRIGGER before_historico_documentacao_insert
	BEFORE INSERT ON historico_documentacao
	FOR EACH ROW
	BEGIN
		IF (NEW.id_venda IS NULL AND NEW.id_compra IS NULL) OR (NEW.id_venda IS NOT NULL AND NEW.id_compra IS NOT NULL) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ou id_venda ou id_compra deve ser preenchido, mas não ambos ou nenhum.';
		END IF;
	END;
	//

	CREATE TRIGGER before_historico_documentacao_update
	BEFORE UPDATE ON historico_documentacao
	FOR EACH ROW
	BEGIN
		IF (NEW.id_venda IS NULL AND NEW.id_compra IS NULL) OR (NEW.id_venda IS NOT NULL AND NEW.id_compra IS NOT NULL) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ou id_venda ou id_compra deve ser preenchido, mas não ambos ou nenhum.';
		END IF;
	END;
	//

DELIMITER ;

# PAGAMENTOS

	create table pagamentos(
		id int auto_increment,
        id_venda int not null,
		id_caixa int not null,
        data_hora_pagamento timestamp DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_venda) references vendas(id),
        foreign key (id_caixa) references caixa(id)
    );
    

# COMPRA
	create table compras(
		id int auto_increment,
        id_comprador int not null,
		id_produto int not null,
        valor decimal (10,3) not null,
        data_compra date DEFAULT CURRENT_TIMESTAMP,
        primary key (id),
        foreign key (id_comprador) references comprador(id),
        foreign key (id_produto) references produto(id)
    );


