from openpyxl import load_workbook
from collections import Counter
import json, os

path = r"C:\caixa\manutencao\WebServices\SIGCT_Relatorio_Indicadores_V26.xlsx"
wb = load_workbook(path, data_only=False, read_only=False)
print("ARQUIVO:", os.path.basename(path))
print("ABAS:", wb.sheetnames)

for ws in wb.worksheets:
    print("\n=== ABA:", ws.title, "===")
    print("Dimensao:", ws.max_row, "linhas x", ws.max_column, "colunas")
    print("Oculta:", ws.sheet_state)
    print("Tabelas:", list(ws.tables.keys()))
    print("Agrupamentos mesclados:", len(ws.merged_cells.ranges))

    nonempty = []
    formulas = []
    types = Counter()
    for row in ws.iter_rows():
        for c in row:
            if c.value is not None:
                nonempty.append(c)
                types[c.data_type] += 1
                if c.data_type == "f":
                    formulas.append((c.coordinate, c.value))

    print("Celulas preenchidas:", len(nonempty))
    print("Tipos:", dict(types))
    print("Formulas:", len(formulas))
    if formulas:
        print("Exemplos formulas:", formulas[:10])

    # First 20 used rows as a compact preview
    preview_rows = []
    for row in ws.iter_rows(min_row=1, max_row=min(ws.max_row, 20), values_only=True):
        vals = list(row)
        if any(v is not None for v in vals):
            preview_rows.append(vals[:20])
    print("PREVIEW:")
    for r in preview_rows:
        print(r)
