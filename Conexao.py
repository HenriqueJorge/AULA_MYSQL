import mysql.connector
from mysql.connector import errorcode
try:
    db_connection = mysql.connector.connect(host='127.0.0.1',
                                            user='root',
                                            password='123456',
                                            database='banco_central')
    cursor = db_connection.cursor()

    sql = ("select id,nome from status_conta ")
    cursor.execute(sql)
    
    for (id,nome) in cursor:
      print(id,nome)
    print("\n")

    valores = (1,2)
    cursor.callproc('soma',valores)
    resultados = cursor.stored_results()
    for i in cursor.stored_results():
        print(i.fetchall())

    #sql = "insert into alunos (nome,data_nascimento) values (%s,%s)"
    #values = ("Maria", "2008-01-01")

    #cursor.execute(sql, values)
    #print(cursor.rowcount, "record inserted.")

    #sql = ("select id,nome,data_nascimento from alunos ")
    #cursor.execute(sql)
    
    #for (id, nome, data_nascimento) in cursor:
      #print(id, nome, data_nascimento)
    #print("\n")

    cursor.close()
	
except mysql.connector.Error as error:
    print(error)
else:
    db_connection.commit()
    db_connection.close()
