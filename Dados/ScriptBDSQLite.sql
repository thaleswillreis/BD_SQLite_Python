CREATE TABLE usuario (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    cpf TEXT UNIQUE NOT NULL,
    data_nascimento DATE,
    genero TEXT,
    telefone1 TEXT,
    telefone2 TEXT,
    senha TEXT NOT NULL,
    perfil TEXT NOT NULL
);

CREATE TABLE estado (
    id INTEGER PRIMARY KEY,
    nome_estado TEXT NOT NULL,
    sigla TEXT NOT NULL
);

CREATE TABLE cidade (
    id INTEGER PRIMARY KEY,
    nome_cidade TEXT NOT NULL,
    estado_id INTEGER NOT NULL,
    FOREIGN KEY (estado_id) REFERENCES estado (id)
);

CREATE TABLE endereco (
    id INTEGER PRIMARY KEY,
    logradouro TEXT NOT NULL,
    numero TEXT NOT NULL,
    complemento TEXT,
    bairro TEXT NOT NULL,
    cep TEXT NOT NULL,
    estado_id INTEGER NOT NULL,
    cidade_id INTEGER NOT NULL,
    FOREIGN KEY (estado_id) REFERENCES estado (id),
    FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

CREATE TABLE categoria (
    id INTEGER PRIMARY KEY,
    nome_categoria TEXT UNIQUE NOT NULL
);

CREATE TABLE produto (
    id INTEGER PRIMARY KEY,
    nome_produto TEXT UNIQUE NOT NULL,
    preco_produto REAL NOT NULL,
    estoque_produto INTEGER NOT NULL
);

CREATE TABLE categoria_produto (
    produto_id INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,
    PRIMARY KEY (produto_id, categoria_id),
    FOREIGN KEY (produto_id) REFERENCES produto (id),
    FOREIGN KEY (categoria_id) REFERENCES categoria (id)
);

CREATE TABLE pedido (
    id INTEGER PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    status_pedido TEXT NOT NULL,
    usuario_id INTEGER NOT NULL,
    endereco_entrega_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id),
    FOREIGN KEY (endereco_entrega_id) REFERENCES endereco (id)
);

CREATE TABLE pagamento (
    id INTEGER PRIMARY KEY,
    status_pagamento INTEGER NOT NULL,
    forma_pagamento INTEGER NOT NULL,
    valor REAL NOT NULL,
    pedido_id INTEGER NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido (id)
);

CREATE TABLE pagamento_cartao (
    id INTEGER PRIMARY KEY,
    numero_cartao TEXT NOT NULL,
    data_validade DATETIME NOT NULL,
    cvc TEXT NOT NULL,
    qtd_parcelas INTEGER NOT NULL,
    pagamento_id INTEGER NOT NULL,
    FOREIGN KEY (pagamento_id) REFERENCES pagamento (id)
);

CREATE TABLE pagamento_boleto (
    id INTEGER PRIMARY KEY,
    data_vencimento DATETIME NOT NULL,
    data_pagamento DATETIME,
    pagamento_id INTEGER NOT NULL,
    FOREIGN KEY (pagamento_id) REFERENCES pagamento (id)
);

CREATE TABLE pedido_produto (
    pedido_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_produto REAL NOT NULL,
    desconto REAL,
    PRIMARY KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedido (id),
    FOREIGN KEY (produto_id) REFERENCES produto (id)
);

CREATE TABLE transportadora (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    telefone TEXT,
    email TEXT
);

CREATE TABLE frete (
    id INTEGER PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    transportadora_id INTEGER NOT NULL,
    valor REAL NOT NULL,
    prazo_estimado INTEGER NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido (id),
    FOREIGN KEY (transportadora_id) REFERENCES transportadora (id)
);

CREATE TABLE avaliacao_produto (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    nota INTEGER NOT NULL CHECK(nota >= 1 AND nota <= 5),
    comentario TEXT CHECK(LENGTH(comentario) <= 500),
    data_avaliacao DATETIME NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id),
    FOREIGN KEY (produto_id) REFERENCES produto (id)
);

CREATE TABLE cupom_desconto (
    id INTEGER PRIMARY KEY,
    codigo TEXT UNIQUE NOT NULL,
    desconto REAL NOT NULL,
    data_validade DATE NOT NULL
);

CREATE TABLE log_atividade (
    id INTEGER PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    acao TEXT NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);
