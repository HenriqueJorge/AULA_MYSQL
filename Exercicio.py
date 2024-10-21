import mysql.connector

db_connection = mysql.connector.connect(host='127.0.0.1',
                                            user='root',
                                            password='123456',
                                            database='banco_central')
cursor = db_connection.cursor()
#################################################
sql = 'select id,nome from status_conta'
cursor.execute(sql)

for item in cursor:
    print(item)
############################### ##################
sql = 'insert into status_conta(id,nome) values(%s,%s)'
valores = (5,'Teste')
cursor.execute(sql,valores)
print(cursor.rowcount, "record inserted.")
##################################################
db_connection.commit()
db_connection.close()
