import psycopg2
import csv

# Configurações de conexão
conn = psycopg2.connect(
    host='localhost',
    port='5432',
    dbname='gctdes01',
    user='postgres',
    password='postgres'
)
cur = conn.cursor()

# Lista todas as views
cur.execute("""
    SELECT schemaname, viewname
    FROM pg_views
    WHERE schemaname NOT IN ('pg_catalog', 'information_schema');
""")
views = cur.fetchall()

# Salva os resultados em CSV
with open('analise_views.csv', 'w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(['schema', 'view', 'execution_plan'])

    for schemaname, viewname in views:
        query = f'EXPLAIN ANALYZE SELECT * FROM "{schemaname}"."{viewname}";'
        try:
            cur.execute(query)
            plan = cur.fetchall()
            plan_text = '\n'.join(row[0] for row in plan)
            writer.writerow([schemaname, viewname, plan_text])
        except Exception as e:
            writer.writerow([schemaname, viewname, f'Erro: {str(e)}'])

cur.close()
conn.close()
print("Análise concluída. Resultados em 'analise_views.csv'.")