import mysql.connector as mysql

db = mysql.connect(
    host="localhost",
    user="root",
    password="ICanDoIt!",
    # database="people",
)

cursor = db.cursor()

DB_NAME = "people"


def create_database():
    cursor.execute("CREATE DATABASE IF NOT EXISTS {}".format(DB_NAME))
    print("Database {} is created!".format(DB_NAME))


create_database()


TABLE_NAME1 = "famous_people"


def create_table():
    cursor.execute("USE {}".format(DB_NAME))
    cursor.execute("DROP TABLE IF EXISTS {}".format(TABLE_NAME1))
    cursor.execute(
        'CREATE TABLE famous_people ('
        'id INT NOT NULL AUTO_INCREMENT, '
        'name VARCHAR(255) NOT NULL, '
        'field VARCHAR(255) NOT NULL, '
        'country VARCHAR(255) NOT NULL, '
        'PRIMARY KEY (id))'
    )
    print("Table {} is created!".format(TABLE_NAME1))


create_table()


# add many logs
def add_logs():
    sql = "INSERT INTO famous_people (name, field, country) VALUES (%s, %s, %s)"
    values = [
        ("Abraham Lincoln", "president", "United States"),
        ("Bill Gates", "businessman", "United States"),
        ("Albert Einstein", "scientist", "Germany"),
        ("Queen Victoria", "monarch", "Great Britain"),
        ("Charles Darwin", "scientist", "Great Britain"),
        ("Leonardo da Vinci", "painter", "Italy"),
        ("Vincent van Gogh", "painter", "Netherlands"),
        ("George Orwell", "author", "Great Britain"),
        ("Oscar Wilde", "author", "Great Britain"),
    ]

    cursor.executemany(sql, values)
    db.commit()
    print(cursor.rowcount, "records inserted in the table famous_people!")


add_logs()
