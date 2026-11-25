rem set PGCLIENTENCODING=utf-8
chcp 65001
set PGPASSWORD=gct
rem psql -v VERBOSITY=terse -h sctdedadlx0012.df.caixa -U gct sigctdes < %~1
rem psql -v VERBOSITY=terse -h sctdedadlx0015.df.caixa -U gct sigcttqs < %~1
psql -v VERBOSITY=terse -h localhost -U gct gctdes01 < %~1
