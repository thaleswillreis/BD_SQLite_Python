import os
import sqlite3


class SQLiteDatabase:
    def __init__(self, db_path: str, script_path: str):
        self.db_path = db_path
        self.script_path = script_path
        self.connection = None

    def remove_database(self):
        """Remove o arquivo de banco de dados, se ele existir.."""
        if os.path.exists(self.db_path):
            os.remove(self.db_path)

    def connect(self):
        """Conecta ao banco de dados SQLite e habilite chaves estrangeiras"""
        self.connection = sqlite3.connect(self.db_path)
        self.connection.execute("PRAGMA foreign_keys = ON;")

    def execute_script(self):
        """Executa o script SQL para criação do banco de dados."""
        with open(self.script_path, 'r') as file:
            script_sql = file.read()
        cursor = self.connection.cursor()
        cursor.executescript(script_sql)
        self.connection.commit()

    def close(self):
        """Fecha a conexão com o banco de dados."""
        if self.connection:
            self.connection.close()


if __name__ == "__main__":
    db = SQLiteDatabase('./Dados/BD_SQLite.db', './Dados/ScriptBDSQLite.sql')
    db.remove_database()
    db.connect()
    db.execute_script()
    db.close()
