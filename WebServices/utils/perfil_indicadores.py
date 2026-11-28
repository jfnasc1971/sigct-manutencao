from openpyxl import load_workbook

path = r"C:\caixa\manutencao\WebServices\SIGCT_Relatorio_Indicadores_V26.xlsx"
wb = load_workbook(path, read_only=True, data_only=True)
common = {'EQUIPE','CODIGO CONTRATO','CONTRATO','AREA','COMUNIDADE','GRUPO','DT. FINAL FATURA','FATURA','COD. FATURA','DATA CONSIDERAR FNS','INDICADOR'}

for name in wb.sheetnames:
    if '(Desenvolvimento)' not in name and '(Suporte)' not in name:
        continue
    ws = wb[name]
    headers = [c.value for c in ws[1]]
    print('\n===', name, '===')
    for idx, header in enumerate(headers, start=1):
        if header in common:
            continue
        vals=[]
        for row in ws.iter_rows(min_row=2, min_col=idx, max_col=idx, values_only=True):
            v=row[0]
            if v is not None:
                vals.append(v)
        nums=[v for v in vals if isinstance(v,(int,float))]
        if nums:
            print(f'{header}: preenchidos={len(vals)}, min={min(nums)}, max={max(nums)}')
        else:
            uniques=list(dict.fromkeys(vals))
            print(f'{header}: preenchidos={len(vals)}, exemplos={uniques[:8]}')
