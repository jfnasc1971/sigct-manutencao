import pandas as pd
import os

path = r"C:\caixa\manutencao\WebServices\SIGCT_Relatorio_Indicadores_V26.xlsx"
xls = pd.ExcelFile(path, engine='openpyxl')
print('ARQUIVO:', os.path.basename(path))
for name in xls.sheet_names:
    df = pd.read_excel(path, sheet_name=name, engine='openpyxl')
    print('\n===', name, '===')
    print('Linhas dados:', len(df), '| Colunas:', len(df.columns))
    print('Preenchidas:', int(df.notna().sum().sum()), '/', len(df)*len(df.columns))
    for col in ['FATURA','INDICADOR','GRUPO','AREA','COMUNIDADE','CODIGO CONTRATO','EQUIPE','FAIXA FNS']:
        if col in df.columns:
            print(col, 'unicos=', df[col].nunique(dropna=True), '| mais comuns=', df[col].value_counts(dropna=True).head(8).to_dict())
    for col in ['DT. FINAL FATURA','DATA CONSIDERAR FNS','DT. INICIO DESENVOLVIMENTO','DT. INICIO TRIMESTRE','DT. FIM TRIMESTRE','DATA EFETIVA','DATA INICIO']:
        if col in df.columns:
            vals = pd.to_datetime(df[col], errors='coerce')
            print(col, 'nulos=', int(vals.isna().sum()), '| periodo=', (vals.min().date().isoformat() if vals.notna().any() else None), 'a', (vals.max().date().isoformat() if vals.notna().any() else None))
