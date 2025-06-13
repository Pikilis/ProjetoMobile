import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'forca_vendas.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  senha TEXT NOT NULL,
  ultimaAlteracao TEXT,
  excluido INTEGER DEFAULT 0
);
    ''');

    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        tipo TEXT NOT NULL,
        cpfCnpj TEXT NOT NULL,
        email TEXT,
        telefone TEXT,
        cep TEXT,
        endereco TEXT,
        bairro TEXT,
        cidade TEXT,
        uf TEXT,
        ultimaAlteracao TEXT,
        excluido INTEGER DEFAULT 0
      );
        ''');

    await db.execute('''
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        unidade TEXT NOT NULL,
        qtdEstoque REAL NOT NULL,
        precoVenda REAL NOT NULL,
        status INTEGER NOT NULL,
        custo REAL,
        codigoBarra TEXT,
        ultimaAlteracao TEXT,
        excluido INTEGER DEFAULT 0
      );
        ''');

    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idCliente INTEGER NOT NULL,
        idUsuario INTEGER NOT NULL,
        totalPedido REAL NOT NULL,
        ultimaAlteracao TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE pedido_itens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idPedido INTEGER NOT NULL,
        idProduto INTEGER NOT NULL,
        quantidade REAL NOT NULL,
        totalItem REAL NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE pedido_pagamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idPedido INTEGER NOT NULL,
        valor REAL NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE configuracao (
        servidorUrl TEXT
      );
    ''');
  }
}
