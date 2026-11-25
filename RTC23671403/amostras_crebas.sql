DROP TABLE if exists gct.gcttb264_amsta_equipe;
DROP TABLE if exists gct.gcttb265_amsta_solicitacao;
DROP TABLE if exists gct.gcttb266_amsta_slctco_equipe;
DROP TABLE if exists gct.gcttb267_amsta_ciclo_trabalho;
DROP TABLE if exists gct.gcttb268_amsta_vigencia_membros_equipe;
DROP TABLE if exists gct.gcttb268_amsta_membros_equipe;

--
-- Name: gcttb264_amsta_equipe; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb264_amsta_equipe (
    dt_referencia date,
    nu_equipe numeric(10,0),
    co_equipe character varying(15),
    nu_situacao_equipe numeric(2,0),
    nu_area_interna numeric(5,0),
    nu_tipo_grupo numeric(10,0),
    nu_contrato numeric(6,0),
    co_sitio character(2),
    de_equipe character varying(500),
    dt_solicitacao_alocacao timestamp without time zone,
    dt_inicio_atendimento timestamp without time zone,
    dt_final_atendimento timestamp without time zone,
    vr_previsto_calculado numeric(11,2),
    dh_inclusao_informacao timestamp without time zone,
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    de_justificativa_alteracao character varying(500),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb264 primary key(dt_referencia, nu_equipe)
);


ALTER TABLE gct.gcttb264_amsta_equipe OWNER TO gct;

--
-- Name: gcttb265_amsta_solicitacao; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb265_amsta_solicitacao (
    dt_referencia date,
    nu_solicitacao numeric(10,0),
    nu_unidade_custo numeric(4,0),
    nu_natural_custo numeric(6,0),
    co_solicitacao character varying(15),
    de_solicitacao text,
    de_tipo_solicitacao character varying(500),
    de_tipo_manutencao character varying(500),
    de_pendencia character varying(500),
    de_origem_solicitacao character varying(10),
    de_situacao_solicitacao character varying(500),
    co_siplo character varying(20),
    co_acao_operacional character varying(500),
    no_sigla_sistema character varying(500),
    pc_atendimento_slcto numeric(3,0),
    dh_processamento timestamp without time zone,
    no_solicitacao character varying(1000),
    de_versao_planejada character varying(200),
    nu_quatidade_incluida character varying(20),
    nu_quatidade_alterada character varying(20),
    nu_quatidade_excluida character varying(20),
    nu_sistema_intgo numeric(3,0),
    no_item_portfolio character varying(500),
    de_modulo character varying(500),
    dh_inicio timestamp without time zone,
    dh_prevista timestamp without time zone,
    dh_efetiva timestamp without time zone,
    de_situacao_solicitacao_gct character varying(50),
    co_solicitacao_pai character varying(50),
    dh_cadastro timestamp without time zone,
    dh_resolucao timestamp without time zone,
    dh_modificacao timestamp without time zone,
    nu_situacao_solicitacao numeric,
    dh_acionamento timestamp without time zone,
    de_equipe_responsavel character varying(300),
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    de_justificativa_alteracao character varying(500),
    nu_execucao numeric,
    nu_mtrca_alteracao_custo numeric,
    dh_alteracao_custo timestamp without time zone,
    co_solicitacao_custo character varying(30),
    ic_acesso_restrito character(1),
    no_tipo_solicitacao character varying(200),
    de_tipo_desenvolvimento character varying(200),
    no_planejado_para character varying(150),
    no_area_projeto character varying(150),
    qt_erro numeric(3,0),
    no_squad character varying(150),
    ic_pendente_atualizacao character(1),
    qt_pontos_historia numeric(2,0),
    nu_item_portfolio numeric(10,0),
    co_matrca_responsavel character varying(10),
    nu_modulo numeric(9,0),
    nu_solicitacao_pai numeric,
    co_area_projeto character varying(100),
    nu_tipo_situacao_vinculacao numeric(1,0),
    no_tipo_grupo character varying(50),
    no_tipo_servico character varying(50),
    co_rubrica character varying(20),
    ic_bef character(1),
    no_modulo character varying(100),
    nu_rubrica numeric(5,0),
    sg_unidade_custo character varying(50),
    co_solicitacao_bef character varying(15),
    dh_avaliacao_bef timestamp without time zone,
    dh_amostra timestamp with time zone,
    constraint pk_gcttb265 primary key(dt_referencia, nu_solicitacao)
);


ALTER TABLE gct.gcttb265_amsta_solicitacao OWNER TO gct;

--
-- Name: gcttb266_amsta_slctco_equipe; Type: TABLE; Schema: gct; Owner: postgres
--

CREATE TABLE gct.gcttb266_amsta_slctco_equipe (
    dt_referencia date,
    nu_solicitacao_equipe numeric(10,0),
    nu_equipe numeric(10,0),
    nu_ciclo_trabalho numeric(10,0),
    nu_solicitacao numeric(10,0),
    nu_tipo_servico numeric(10,0),
    nu_tamanho_servico numeric(14,2),
    nu_demanda numeric(10,0),
    ic_solicitacao_compoe_fns character(1),
    co_falha_solicitacao bpchar,
    vr_questionario_avaliacao numeric(6,3),
    vr_nota_qualidade_produto numeric(6,3),
    vr_total_apurado_avaliacao numeric(6,3),
    nu_mtrca_avaliacao_equipe numeric(6,0),
    dh_avaliacao_solicitacao timestamp without time zone,
    nu_ajuste numeric,
    nu_fatura_ajuste numeric,
    gctfn135_recuperar_rubrica numeric,
    nu_fatura_previa numeric,
    nu_comunidade numeric(3,0),
    co_rubrica character varying(20),
    no_comunidade character varying(100),
    co_forma_vinculacao character(1),
    de_justificativa_alteracao character varying(500),
    de_justificativa_falha character varying(500),
    nu_acao_historico numeric(4,0),
    nu_execucao numeric,
    nu_mtrca_acao_hstro numeric,
    nu_mtrca_avaliacao_solicitacao numeric(6,0),
    nu_ordem_servico numeric(10,0),
    no_tipo_servico character varying(50),
    ic_bef character(1),
    ic_bef_pode_ajustar_rubrica character(1),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb266 primary key(dt_referencia, nu_solicitacao_equipe)
);

ALTER TABLE gct.gcttb266_amsta_slctco_equipe OWNER TO gct;

--
-- Name: gcttb267_amsta_ciclo_trabalho; Type: TABLE; Schema: gct; Owner: gct
--

CREATE TABLE gct.gcttb267_amsta_ciclo_trabalho (
    dt_referencia date,
    nu_equipe numeric(10,0),
    nu_ciclo_trabalho numeric(10,0),
    nu_situacao_ciclo_trabalho numeric(2,0),
    de_ciclo_trabalho character varying(500),
    dt_inicio_ciclo_trabalho timestamp without time zone,
    dt_alvo_ciclo_trabalho timestamp without time zone,
    dt_final_ciclo_trabalho timestamp without time zone,
    co_falha_ciclo_trabalho character(2),
    nu_acao_historico numeric(4,0),
    nu_mtrca_acao_hstro numeric,
    vr_questionario_avaliacao numeric(6,3),
    vr_nota_qualidade_produto numeric(6,3),
    vr_total_apurado_avaliacao numeric(6,3),
    nu_mtrca_avaliacao_equipe numeric(6,0),
    de_justificativa_falha character varying(500),
    de_justificativa_alteracao character varying(500),
    nu_mtrca_fechamento_equipe numeric(6,0),
    dt_fechamento_ciclo_trabalho timestamp without time zone,
    de_justificativa_fechamento character varying(500),
    de_justificativa_cancelar_fechamento character varying(500),
    ic_nao_se_aplica character(1),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb267 primary key(dt_referencia, nu_equipe, nu_ciclo_trabalho)
);


ALTER TABLE gct.gcttb267_amsta_ciclo_trabalho OWNER TO gct;

--
-- Name: gcttb268_amsta_membros_equipe; Type: TABLE; Schema: gct; Owner: postgres
--

CREATE TABLE gct.gcttb268_amsta_membros_equipe (
    dt_referencia date not null,
    nu_vigencia_membro numeric(10,0) not null,
    nu_membro numeric,
    nu_perfil numeric(6,0),
    nu_equipe numeric(10,0),
    dt_inicio_membro date,
    dt_fim_membro date,
    nu_posicao_membro numeric,
    pc_alocacao_membro numeric(3,2),
    dh_amostra timestamp with time zone,
    constraint pk_gcttb268 primary key(dt_referencia, nu_vigencia_membro)
);

drop index if exists gct.ix_gcttb264_1;
drop index if exists gct.ix_gcttb265_1;
drop index if exists gct.ix_gcttb266_1;
drop index if exists gct.ix_gcttb267_1;
drop index if exists gct.ix_gcttb268_1;

create index ix_gcttb264_1 on gct.gcttb264_amsta_equipe (dt_referencia);
create index ix_gcttb265_1 on gct.gcttb265_amsta_solicitacao (dt_referencia);
create index ix_gcttb266_1 on gct.gcttb266_amsta_slctco_equipe (dt_referencia);
create index ix_gcttb267_1 on gct.gcttb267_amsta_ciclo_trabalho (dt_referencia);
create index ix_gcttb268_1 on gct.gcttb268_amsta_membros_equipe (dt_referencia);