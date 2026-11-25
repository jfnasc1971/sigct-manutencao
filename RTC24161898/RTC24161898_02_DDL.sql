begin;

--
-- RTC 24379532 - SIGCT - Análise e correção do BEF
--

--
-- INICIO
--

--
--
--
drop function if exists gct.gctfn900_rtc24161898();

CREATE OR REPLACE FUNCTION gct.gctfn900_rtc24161898() RETURNS void LANGUAGE plpgsql AS 
$$ 
--
-- RTC 24379532 - SIGCT - Análise e correção do BEF
--
begin

--
-- INICIO
--

update 
  gct.gcttb005_solicitacao s
set 
  ic_bef='N', 
  nu_rubrica=null, 
  co_rubrica=null 
where 
  (
    s.dh_prevista::date > '2025-09-20'
    or s.dh_efetiva::date > '2025-09-20'
  )
  and s.ic_bef = 'S';

update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018304; -- 21162287
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018327; -- 21119423
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018331; -- 21162663
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1024669; -- 21121708
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1026147; -- 21121701
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1029533; -- 21367807
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1030612; -- 21147682
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1030635; -- 21388195
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1033596; -- 21343553
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1039556; -- 21147713
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1049091; -- 21162759
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1049962; -- 21367742
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1054612; -- 21162358
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1056706; -- 21162375
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1073950; -- 21147705
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1075170; -- 21162767
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1124512; -- 21563652
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1170622; -- 20478634
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1171151; -- 20478621
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1195033; -- 21798224
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1202071; -- 21813586
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1206348; -- 21809752
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1225289; -- 21837447
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1225301; -- 21813590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1244657; -- 21911300
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1275936; -- 21913543
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1283470; -- 21162801
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1284490; -- 21963844
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1294527; -- 22017798
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1298543; -- 22042762
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1304611; -- 22055177
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1315994; -- 22074551
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1342904; -- 22148913
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1356608; -- 22231939
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360143; -- 22239652
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360149; -- 22266522
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360155; -- 22266544
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1378278; -- 22292217
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1378280; -- 22333590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1380324; -- 22333618
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1391019; -- 22444426
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393008; -- 22471854
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393357; -- 22350351
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393647; -- 22454190
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1394287; -- 22392800
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1394683; -- 21483869
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1394733; -- 22516579
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1399985; -- 22567266
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1401478; -- 21488307
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1407227; -- 22659621
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1407228; -- 22653891
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1408928; -- 22176049
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1410664; -- 22566606
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1411855; -- 22602366
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1413583; -- 22567643
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1418307; -- 22566571
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1422750; -- 22566536
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1423289; -- 22889335
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1423760; -- 22799348
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1425441; -- 22963656
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1425443; -- 22963693
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1425511; -- 22434545
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1426974; -- 22867239
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431234; -- 22642876
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431305; -- 22517203
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431324; -- 23044762
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431327; -- 23023375
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1432366; -- 21691134
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1433806; -- 22867269
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1433987; -- 23071528
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1434655; -- 22854952
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1436038; -- 22906939
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1437104; -- 23135229
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438108; -- 23157032
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438111; -- 23032572
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438643; -- 22875810
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438697; -- 23057277
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439508; -- 22945291
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439950; -- 22459315
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1441856; -- 22949306
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1442328; -- 23264197
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1442986; -- 23276826
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444471; -- 23263701
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444703; -- 23324117
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444776; -- 23198871
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445042; -- 23125208
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445240; -- 22945174
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445241; -- 22146664
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445243; -- 22945183
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445244; -- 22945186
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445704; -- 22876058
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445863; -- 22876339
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446151; -- 23338910
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446159; -- 23264747
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446269; -- 23358237
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446464; -- 23243389
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446535; -- 23071635
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446666; -- 23323374
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446717; -- 23252647
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446810; -- 23174442
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447403; -- 23375420
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447778; -- 22309334
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447800; -- 22637513
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447801; -- 23192590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447802; -- 23206030
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1449515; -- 18335463
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450073; -- 23551860
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450074; -- 23520541
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450512; -- 23422531
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1451747; -- 23493987
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452054; -- 23638884
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452300; -- 23191559
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453110; -- 23105226
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454228; -- 23266665
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454398; -- 23687222
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454883; -- 23694141
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454934; -- 23150247
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455134; -- 23467774
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455405; -- 23360276
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455474; -- 23628733
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455572; -- 23219226
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455575; -- 23218258
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455776; -- 23137216
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455825; -- 23213655
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456453; -- 23447497
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456616; -- 23376633
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456623; -- 23518629
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456782; -- 23691862
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456857; -- 22591920
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456914; -- 23115407
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457157; -- 23375743
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457159; -- 23712554
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457823; -- 22793857
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457967; -- 22184504
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458096; -- 23589431
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458112; -- 23736730
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458137; -- 22938696
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458252; -- 23757954
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458302; -- 23671403
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458489; -- 23287290
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458491; -- 23287302
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458493; -- 23283958
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458566; -- 23679264
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458740; -- 23705405
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458835; -- 23705390
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458852; -- 23550520
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458992; -- 23150490
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459129; -- 23129625
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459250; -- 22698609
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459300; -- 23118707
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459304; -- 23324517
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459334; -- 23774487
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459381; -- 22989731
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459382; -- 22989781
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459461; -- 23282351
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459509; -- 23350477
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459517; -- 23639167
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459531; -- 23806060
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459664; -- 23043676
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459772; -- 22411257
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459809; -- 22197939
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459835; -- 23719961
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459836; -- 23713821
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459838; -- 23712852
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459854; -- 22968174
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459875; -- 23374033
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459881; -- 23242158
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459991; -- 23781046
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459993; -- 23750437
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460002; -- 23423974
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460181; -- 21869128
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460257; -- 20581784
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460432; -- 23327994
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460445; -- 23823766
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460627; -- 23071243
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460631; -- 23423936
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460683; -- 23359479
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460924; -- 23865636
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461023; -- 23831074
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461132; -- 23106303
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461278; -- 23857526
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461309; -- 23807624
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461368; -- 23857977
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461369; -- 23849863
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461458; -- 23377722
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461485; -- 23829628
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461487; -- 23829541
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461516; -- 23377770
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461519; -- 23377646
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461521; -- 23377824
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461623; -- 23854346
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461666; -- 23781095
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461693; -- 23749787
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461694; -- 23725604
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461697; -- 23360219
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461698; -- 23529992
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461699; -- 23360049
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461763; -- 23674800
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461764; -- 23751764
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461852; -- 23377232
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461894; -- 23149812
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462003; -- 23830714
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462024; -- 23359831
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462026; -- 23384310
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462030; -- 23609917
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462034; -- 23383293
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462063; -- 23177051
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462072; -- 23905549
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462085; -- 23810601
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462173; -- 23430135
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462302; -- 23625813
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462413; -- 23829893
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462483; -- 23877268
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462553; -- 23846527
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462554; -- 23823607
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462579; -- 23721715
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462598; -- 23847562
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462610; -- 23830943
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462706; -- 23830864
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462761; -- 23366738
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462769; -- 23199076
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462770; -- 23199130
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462771; -- 23559387
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462778; -- 23495204
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462810; -- 23830453
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462834; -- 23760569
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462982; -- 23688589
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462994; -- 23729496
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463017; -- 23688553
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463239; -- 23360484
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463243; -- 23374841
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463398; -- 23849009
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463423; -- 23902698
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463425; -- 23813586
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463501; -- 23914958
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463607; -- 22889316
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463744; -- 23934398
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463747; -- 22869341
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463809; -- 23857303
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463814; -- 23885552
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463820; -- 23678819
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463834; -- 23679554
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463835; -- 23849928
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463836; -- 23857949
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463837; -- 23857929
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463843; -- 23301365
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463857; -- 23760502
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463865; -- 23180180
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463878; -- 23728946
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463942; -- 23914825
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463965; -- 23705689
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464169; -- 23971041
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464186; -- 22199324
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464291; -- 23283782
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464298; -- 23804278
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464308; -- 23856914
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464309; -- 23813302
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464339; -- 23726338
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464352; -- 23706504
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464430; -- 23469691
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464433; -- 23982868
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464472; -- 23811534
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464525; -- 23983228
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464533; -- 23973810
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464537; -- 23973852
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464556; -- 23706041
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464575; -- 23455374
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464596; -- 22571508
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464600; -- 22945225
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464610; -- 23806029
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464620; -- 21991509
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464649; -- 23411146
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464674; -- 23902946
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464688; -- 23688565
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464690; -- 23774660
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464692; -- 23780787
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464695; -- 23780726
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464760; -- 23254946
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464769; -- 23947733
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464816; -- 23865834
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464850; -- 23865888
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464870; -- 23931818
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464936; -- 23865244
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464983; -- 23982478
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465102; -- 23632501
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465103; -- 23874207
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465114; -- 23877267
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465115; -- 23993652
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465134; -- 23947546
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465144; -- 23877358
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465150; -- 23877345
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465152; -- 23877329
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465198; -- 23921627
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465300; -- 23878334
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465316; -- 23411057
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465357; -- 23522216
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465405; -- 23921774
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465430; -- 23997504
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465667; -- 23802641
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465734; -- 23351191
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465826; -- 23706089
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465902; -- 22833569
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465904; -- 23795225
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465996; -- 24019248
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466014; -- 23972588
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466018; -- 23980339
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466038; -- 23831000
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466068; -- 23765629
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466092; -- 22945195
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466217; -- 22945298
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466272; -- 22945258
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466324; -- 24058786
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466351; -- 22945247
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466352; -- 22945230
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466374; -- 23514341
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466375; -- 23514277
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466421; -- 23947694
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466439; -- 24071798
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466473; -- 23418264
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466560; -- 23284116
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466609; -- 22945202
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466615; -- 23160927
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466636; -- 23528316
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466785; -- 23993650
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466799; -- 23855759
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466802; -- 24009147
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466824; -- 23283551
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466993; -- 23850120
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466994; -- 24046277
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467005; -- 23944767
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467052; -- 23902759
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467053; -- 23902743
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467056; -- 23902679
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467057; -- 23914244
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467058; -- 23830651
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467059; -- 23902791
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467075; -- 23766014
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467076; -- 23784462
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467108; -- 22945286
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467110; -- 22945313
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467115; -- 24099110
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467116; -- 22757224
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467179; -- 23642048
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467183; -- 23758038
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467188; -- 22950338
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467225; -- 23673709
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467244; -- 23982205
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467524; -- 22184723
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467544; -- 23225019
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467555; -- 24050417
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467561; -- 23776253
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467704; -- 24084794
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467708; -- 24084802
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467725; -- 24088511
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467729; -- 24132179
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467819; -- 23460512
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467820; -- 23882153
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467821; -- 23287323
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467824; -- 24087790
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467850; -- 23018708
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467946; -- 23971253
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467949; -- 23971199
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467956; -- 23987225
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467960; -- 24134687
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467961; -- 23868377
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467964; -- 24133273
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467968; -- 24143385
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467978; -- 23807489
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468016; -- 24007330
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468022; -- 23982785
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468040; -- 23757752
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468069; -- 24104361
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468082; -- 24061456
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468084; -- 24058886
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468085; -- 24061347
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468086; -- 24061301
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468088; -- 24061273
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468097; -- 22835137
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468109; -- 23782307
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468114; -- 23798984
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468154; -- 23149798
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468165; -- 23502845
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468170; -- 23021789
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468179; -- 23711194
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468182; -- 24004473
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468199; -- 23502881
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468201; -- 23998599
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468204; -- 24147752
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468325; -- 24065469
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468336; -- 23781195
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468367; -- 23806642
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468377; -- 24135048
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468405; -- 24132857
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468415; -- 24156706
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468489; -- 23560521
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468494; -- 23610205
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468522; -- 23824803
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468561; -- 23992538
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468572; -- 23493140
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468586; -- 23864632
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468608; -- 23859459
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468633; -- 22838627
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468663; -- 23813340
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468677; -- 23560824
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468718; -- 23364566
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468738; -- 23149685
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468744; -- 23912552
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468763; -- 23830688
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468801; -- 23502857
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468967; -- 23830866
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468979; -- 23985022
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468984; -- 23382006
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468990; -- 24099376
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468995; -- 24059447
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469002; -- 23381781
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469007; -- 24101842
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469048; -- 23796384
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469054; -- 23993513
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469056; -- 23857631
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469061; -- 23796483
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469062; -- 23679635
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469064; -- 23877251
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469096; -- 24159076
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469161; -- 24099281
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469286; -- 23877271
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469328; -- 23085963
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469342; -- 24129816
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469361; -- 23868500
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469383; -- 22573106
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469436; -- 23681482
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469446; -- 23680245
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469456; -- 23720637
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469470; -- 23382082
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469477; -- 24223340
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469488; -- 23827489
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469530; -- 24076923
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469541; -- 24077978
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469558; -- 24148335
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469567; -- 23827550
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469570; -- 23827850
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469634; -- 22410401
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469639; -- 23827520
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469647; -- 24149407
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469648; -- 22669985
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469655; -- 24089185
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469659; -- 24148757
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469672; -- 23075986
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469686; -- 22664350
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469688; -- 23866449
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469729; -- 24148717
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469731; -- 24148679
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469785; -- 23782941
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469801; -- 23432817
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469802; -- 24129872
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469803; -- 24129897
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469817; -- 24061878
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469821; -- 23381971
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469830; -- 24148364
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469833; -- 24148523
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469862; -- 24161898
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469894; -- 24222171
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469895; -- 24222093
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469930; -- 23085461
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469961; -- 23720542
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469993; -- 24088178
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470003; -- 22854961
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470009; -- 23317444
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470016; -- 23947773
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470032; -- 24218431
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470043; -- 24161863
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470045; -- 24161844
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470046; -- 23996108
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470082; -- 24222856
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470099; -- 24187217
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470109; -- 24161625
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470141; -- 24238978
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470147; -- 24253524
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470175; -- 23985944
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470195; -- 24148653
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470267; -- 23868304
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470288; -- 23432818
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470289; -- 23432819
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470290; -- 23432827
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470291; -- 22983013
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470323; -- 23385229
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470334; -- 22945278
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470340; -- 22945271
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470349; -- 24250675
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470351; -- 24233584
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470352; -- 24233594
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470359; -- 24088234
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470383; -- 22945311
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470389; -- 24239009
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470390; -- 24100042
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470422; -- 23902655
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470446; -- 24235579
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470489; -- 21704569
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470497; -- 22945303
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470499; -- 22146887
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470552; -- 23798890
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470683; -- 24046635
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470734; -- 24016113
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470781; -- 24266817
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470821; -- 23318735
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470844; -- 24233607
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470845; -- 24233606
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470849; -- 23936942
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470851; -- 23936947
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470993; -- 24265061
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471003; -- 24233609
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471004; -- 24233611
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471013; -- 23196594
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471015; -- 22945294
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471016; -- 22945285
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471019; -- 23772525
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471022; -- 22854963
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471206; -- 23974974
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471214; -- 24253174
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471235; -- 24253484
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471246; -- 24103178
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471274; -- 21797498
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471289; -- 24078025
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471312; -- 24236122
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471314; -- 24238954
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471322; -- 24145986
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471406; -- 24132203
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471423; -- 24051116
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471436; -- 24249227
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471459; -- 23824544
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471460; -- 22672518
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471478; -- 24220358
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471514; -- 24172848
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471543; -- 23654570
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471563; -- 22656701
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471618; -- 24286538
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471639; -- 23980014
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471694; -- 24174017
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471696; -- 23432876
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471697; -- 23230556
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471708; -- 24089437
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471755; -- 23729511
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471761; -- 24019650
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471763; -- 23145590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471764; -- 23226837
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471879; -- 23920945
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471880; -- 23749604
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471891; -- 23830665
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471910; -- 24283964
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471920; -- 24160670
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471925; -- 22875911
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471961; -- 23782643
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471965; -- 23782638
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471967; -- 23782623
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471968; -- 23782614
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471971; -- 23782597
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471976; -- 23782592
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471980; -- 23782577
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471991; -- 24223492
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471994; -- 23154610
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471995; -- 22854962
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472030; -- 23685377
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472065; -- 24350108
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472103; -- 23798934
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472151; -- 24006774
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472152; -- 24006499
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472174; -- 24350694
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472191; -- 24003842
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472202; -- 24237827
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472227; -- 23944345
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472238; -- 24148290
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472292; -- 24265326
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472297; -- 23293863
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472310; -- 23639104
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472315; -- 24249668
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472357; -- 23998150
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472358; -- 22594466
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472362; -- 22668794
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472368; -- 23807380
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472376; -- 24016096
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472429; -- 23921449
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472430; -- 22973896
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472441; -- 24102555
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472457; -- 23549448
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472479; -- 24149602
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472591; -- 23776336
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472639; -- 24349100
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472640; -- 23588814
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472642; -- 23569406
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472674; -- 23806995
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472677; -- 23981118
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472678; -- 24353124
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472683; -- 23814419
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472686; -- 23980395
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472689; -- 23811580
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472690; -- 23756863
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472719; -- 22058660
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472732; -- 23757202
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472780; -- 24340084
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472879; -- 23813373
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472883; -- 23850266
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472885; -- 24146461
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472932; -- 24354521

--
-- FIM
--

END;
$$;

alter function gct.gctfn900_rtc24161898() owner to gct;

--
--
--
drop function if exists gct.gctfn900_rtc24161898_retornar();

CREATE OR REPLACE FUNCTION gct.gctfn900_rtc24161898_retornar() RETURNS void LANGUAGE plpgsql AS 
$$ 
--
-- RTC 24379532 - SIGCT - Análise e correção do BEF
--
begin

--
-- INICIO
--

update 
  gct.gcttb005_solicitacao s
set 
  ic_bef='N', 
  nu_rubrica=null, 
  co_rubrica=null 
where 
  (
    s.dh_prevista::date > '2025-09-20'
    or s.dh_efetiva::date > '2025-09-20'
  )
  and s.ic_bef = 'S';

update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018304; -- 21162287
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018327; -- 21119423
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1018331; -- 21162663
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1024669; -- 21121708
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1026147; -- 21121701
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1029533; -- 21367807
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1030612; -- 21147682
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1030635; -- 21388195
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1039556; -- 21147713
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1049091; -- 21162759
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1049962; -- 21367742
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1054612; -- 21162358
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1056706; -- 21162375
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1073950; -- 21147705
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1075170; -- 21162767
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1171939; -- 21715821
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1195033; -- 21798224
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1202071; -- 21813586
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1206348; -- 21809752
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1209559; -- 21797231
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1225289; -- 21837447
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1225301; -- 21813590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1244657; -- 21911300
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1247805; -- 21906628
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1275936; -- 21913543
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1283470; -- 21162801
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1294527; -- 22017798
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1298543; -- 22042762
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1304611; -- 22055177
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1342904; -- 22148913
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360143; -- 22239652
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360149; -- 22266522
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1360155; -- 22266544
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1378278; -- 22292217
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1378280; -- 22333590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1380324; -- 22333618
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1391019; -- 22444426
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393008; -- 22471854
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393357; -- 22350351
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1393647; -- 22454190
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1399985; -- 22567266
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1401478; -- 21488307
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1408928; -- 22176049
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1410664; -- 22566606
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1413583; -- 22567643
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1418307; -- 22566571
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1418503; -- 22682101
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1419134; -- 22764658
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1421851; -- 22457355
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1422750; -- 22566536
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1424719; -- 22625457
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1425441; -- 22963656
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1425443; -- 22963693
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1426342; -- 22625466
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1426343; -- 22628590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1428953; -- 23029412
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431305; -- 22517203
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431324; -- 23044762
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1431327; -- 23023375
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1432796; -- 23071550
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1433806; -- 22867269
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1433987; -- 23071528
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1434655; -- 22854952
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1435410; -- 23114510
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1435437; -- 22703833
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1437477; -- 23182054
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1437553; -- 23126914
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438108; -- 23157032
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1438111; -- 23032572
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439319; -- 22809497
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439344; -- 22682181
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439445; -- 22660638
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439508; -- 22945291
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1439754; -- 23216790
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1441431; -- 22786955
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1441856; -- 22949306
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1442986; -- 23276826
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444471; -- 23263701
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444703; -- 23324117
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444961; -- 23040478
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1444967; -- 21757805
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445240; -- 22945174
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445241; -- 22146664
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445243; -- 22945183
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445244; -- 22945186
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445374; -- 23320672
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445786; -- 22788740
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1445804; -- 22908733
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446151; -- 23338910
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446159; -- 23264747
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1446810; -- 23174442
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447193; -- 23365175
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447587; -- 23375851
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447616; -- 23375967
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447617; -- 23375919
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447801; -- 23192590
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447802; -- 23206030
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1447930; -- 23145986
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1448130; -- 23145930
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1448187; -- 23325626
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1449645; -- 23032396
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1449893; -- 23217277
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450095; -- 23369712
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450096; -- 23521315
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450332; -- 23418773
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450339; -- 23418762
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450343; -- 23503501
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450512; -- 23422531
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450799; -- 23569896
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1450981; -- 23571187
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452007; -- 23632446
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452010; -- 23632355
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452015; -- 23632506
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452248; -- 23629992
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452250; -- 23630234
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452256; -- 23632282
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452300; -- 23191559
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452502; -- 23618005
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452503; -- 23616434
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452505; -- 23626210
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1452506; -- 23626301
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453307; -- 22908837
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453311; -- 22908756
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453413; -- 23431407
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453583; -- 23676859
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453728; -- 22908102
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1453985; -- 23617516
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454027; -- 23691780
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454228; -- 23266665
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454735; -- 23246705
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454814; -- 23523740
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454822; -- 23587857
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454872; -- 22757602
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1454934; -- 23150247
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455134; -- 23467774
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455405; -- 23360276
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455473; -- 23643306
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455474; -- 23628733
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455510; -- 23519968
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455572; -- 23219226
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1455575; -- 23218258
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1456461; -- 23239793
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457139; -- 23757643
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457157; -- 23375743
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457159; -- 23712554
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1457263; -- 23366965
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458096; -- 23589431
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458178; -- 22392972
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458233; -- 23407578
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458252; -- 23757954
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458297; -- 23422287
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458489; -- 23287290
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458491; -- 23287302
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458493; -- 23283958
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458634; -- 23577678
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458803; -- 23796556
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458852; -- 23550520
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1458948; -- 23359060
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459023; -- 20693359
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459029; -- 20693314
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459129; -- 23129625
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459134; -- 22147186
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459256; -- 22678927
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459300; -- 23118707
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459304; -- 23324517
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459334; -- 23774487
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459349; -- 23562351
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459424; -- 23313608
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459461; -- 23282351
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459509; -- 23350477
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459568; -- 23263904
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459664; -- 23043676
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459832; -- 23313076
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459835; -- 23719961
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459836; -- 23713821
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459838; -- 23712852
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459875; -- 23374033
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1459942; -- 23822852
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460002; -- 23423974
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460229; -- 23822750
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460263; -- 23639058
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460384; -- 23854262
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460385; -- 23803657
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460432; -- 23327994
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460475; -- 23855391
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460627; -- 23071243
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460631; -- 23423936
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460636; -- 23192801
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460637; -- 23258639
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460638; -- 23217266
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460639; -- 23159715
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460640; -- 23277061
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460641; -- 22954816
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460684; -- 23644266
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460743; -- 23264260
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460745; -- 23105877
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460755; -- 23130371
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460765; -- 23455435
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460768; -- 23455483
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460771; -- 23455486
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460775; -- 23455487
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460776; -- 23708167
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460778; -- 23752176
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460780; -- 23767251
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1460829; -- 23804682
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461016; -- 23855743
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461197; -- 23873506
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461458; -- 23377722
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461485; -- 23829628
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461487; -- 23829541
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461516; -- 23377770
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461519; -- 23377646
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461521; -- 23377824
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461558; -- 23865593
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461559; -- 23865618
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461565; -- 23865655
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461586; -- 23873179
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461587; -- 23873100
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461878; -- 23813246
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461881; -- 23520133
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461893; -- 23519640
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1461987; -- 22393213
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462003; -- 23830714
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462110; -- 23875147
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462173; -- 23430135
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462194; -- 23167682
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462413; -- 23829893
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462432; -- 23381827
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462553; -- 23846527
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462554; -- 23823607
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462598; -- 23847562
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462610; -- 23830943
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462706; -- 23830864
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462763; -- 23265222
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462769; -- 23199076
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462770; -- 23199130
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462810; -- 23830453
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462834; -- 23760569
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462859; -- 23177213
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1462982; -- 23688589
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463017; -- 23688553
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463161; -- 23626723
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463204; -- 23628325
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463239; -- 23360484
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463243; -- 23374841
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463398; -- 23849009
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463425; -- 23813586
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463501; -- 23914958
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463503; -- 23628583
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463639; -- 23097951
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463747; -- 22869341
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463807; -- 23931988
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463808; -- 23932145
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463814; -- 23885552
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463820; -- 23678819
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463857; -- 23760502
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463867; -- 23931771
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463899; -- 23804434
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463903; -- 23946025
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463904; -- 22945264
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1463949; -- 23947672
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464022; -- 23493377
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464023; -- 23513554
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464028; -- 23455445
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464042; -- 23455457
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464052; -- 23455450
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464056; -- 23213236
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464057; -- 23915292
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464060; -- 23915420
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464062; -- 23915390
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464066; -- 23915433
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464074; -- 23915516
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464079; -- 23915466
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464118; -- 23915874
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464291; -- 23283782
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464298; -- 23804278
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464306; -- 23804803
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464362; -- 23587783
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464414; -- 23300133
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464445; -- 23820463
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464451; -- 23326715
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464472; -- 23811534
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464520; -- 23916305
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464533; -- 23973810
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464537; -- 23973852
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464556; -- 23706041
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464573; -- 23750474
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464596; -- 22571508
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464600; -- 22945225
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464603; -- 22945219
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464688; -- 23688565
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464690; -- 23774660
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464692; -- 23780787
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464695; -- 23780726
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464744; -- 23994201
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464760; -- 23254946
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464816; -- 23865834
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464850; -- 23865888
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464856; -- 23276565
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464908; -- 23993575
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1464983; -- 23982478
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465134; -- 23947546
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465198; -- 23921627
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465208; -- 23997010
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465209; -- 23997574
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465219; -- 23936499
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465357; -- 23522216
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465405; -- 23921774
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465433; -- 23618055
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465434; -- 23626444
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465499; -- 23947100
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465506; -- 23974734
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465511; -- 23946907
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465514; -- 23980380
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465534; -- 23982117
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465537; -- 23980364
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465561; -- 23688816
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465568; -- 23551643
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465570; -- 23758887
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465738; -- 23855936
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465760; -- 23212949
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465820; -- 23576866
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1465919; -- 24050104
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466092; -- 22945195
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466122; -- 23720871
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466123; -- 23733135
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466202; -- 23996777
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466203; -- 23685286
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466204; -- 23685227
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466213; -- 23686648
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466214; -- 23686685
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466217; -- 22945298
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466267; -- 23020990
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466272; -- 22945258
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466351; -- 22945247
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466352; -- 22945230
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466361; -- 23682444
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466374; -- 23514341
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466375; -- 23514277
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466420; -- 24008282
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466421; -- 23947694
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466609; -- 22945202
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466824; -- 23283551
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1466997; -- 23865853
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467058; -- 23830651
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467099; -- 24060755
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467108; -- 22945286
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467110; -- 22945313
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467155; -- 23680666
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467207; -- 23520163
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467211; -- 23947193
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467608; -- 23995128
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467819; -- 23460512
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467821; -- 23287323
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467824; -- 24087790
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467875; -- 23877164
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467946; -- 23971253
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467947; -- 24060706
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467949; -- 23971199
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467960; -- 24134687
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1467961; -- 23868377
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468016; -- 24007330
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468022; -- 23982785
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468101; -- 23935981
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468203; -- 24130383
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468325; -- 24065469
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468357; -- 21419716
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468377; -- 24135048
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468405; -- 24132857
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468415; -- 24156706
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468519; -- 23681702
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468520; -- 23681733
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468641; -- 24078551
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468654; -- 24142751
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468718; -- 23364566
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468763; -- 23830688
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468782; -- 24064964
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468790; -- 24065038
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468829; -- 22457376
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468848; -- 23284319
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468857; -- 23626454
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468858; -- 23626465
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468859; -- 23985095
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468860; -- 24005875
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468861; -- 23136367
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468862; -- 24019410
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468863; -- 24019415
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468865; -- 23995743
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1468866; -- 24133425
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469007; -- 24101842
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469153; -- 24076465
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469154; -- 24061540
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469270; -- 24135815
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469272; -- 24015472
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469361; -- 23868500
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469513; -- 24133810
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469541; -- 24077978
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469610; -- 23475488
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469634; -- 22410401
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469647; -- 24149407
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469686; -- 22664350
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469747; -- 24015524
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469748; -- 24015592
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469762; -- 23974617
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469777; -- 24234853
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469802; -- 24129872
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469803; -- 24129897
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469828; -- 23430964
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469894; -- 24222171
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469895; -- 24222093
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469909; -- 22943681
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1469993; -- 24088178
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470003; -- 22854961
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470013; -- 24006797
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470016; -- 23947773
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470046; -- 23996108
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470099; -- 24187217
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470123; -- 24100091
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470207; -- 24162525
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470265; -- 24130409
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470271; -- 23674830
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470334; -- 22945278
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470337; -- 23287362
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470340; -- 22945271
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470359; -- 24088234
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470383; -- 22945311
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470422; -- 23902655
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470446; -- 24235579
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470489; -- 21704569
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470497; -- 22945303
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470499; -- 22146887
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470584; -- 24162407
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470815; -- 23828607
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1470841; -- 24144357
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471013; -- 23196594
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471054; -- 24006885
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471182; -- 23736884
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471312; -- 24236122
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471314; -- 24238954
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471398; -- 22841555
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471402; -- 24008099
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471459; -- 23824544
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471460; -- 22672518
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471514; -- 24172848
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471543; -- 23654570
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471562; -- 24340909
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471597; -- 24270174
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471599; -- 24270200
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471601; -- 24341932
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471612; -- 23295263
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471613; -- 23295260
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471661; -- 24018629
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471666; -- 24018654
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471673; -- 24018602
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471690; -- 23996683
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471693; -- 23922457
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471765; -- 23711270
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471766; -- 23711190
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471767; -- 24006905
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471890; -- 23830680
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471891; -- 23830665
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471925; -- 22875911
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1471994; -- 23154610
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472079; -- 24015683
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472080; -- 24015662
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472081; -- 24015658
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472082; -- 24015571
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472203; -- 23167417
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472217; -- 24143189
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472428; -- 24324435
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472430; -- 22973896
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472435; -- 24103135
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472439; -- 23867636
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472444; -- 24327242
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472663; -- 24060778
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472729; -- 23886413
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472732; -- 23757202
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1472935; -- 24348735
update gct.gcttb005_solicitacao set ic_bef='S', nu_rubrica=null, co_rubrica=null, ic_pendente_atualizacao='S' where nu_solicitacao=1874; -- 21757805

--
-- FIM
--

END;
$$;

alter function gct.gctfn900_rtc24161898_retornar() owner to gct;

-- Index: gct.ix_gcttb170_6

DROP INDEX IF EXISTS gct.ix_gcttb170_6;

CREATE INDEX ix_gcttb170_6
  ON gct.gcttb170_termo_equipe
  USING btree
  (nu_termo_ajustado);

-- Index: gct.ix_gcttb170_7

DROP INDEX IF EXISTS gct.ix_gcttb170_7;

CREATE INDEX ix_gcttb170_7
  ON gct.gcttb170_termo_equipe
  USING btree
  (nu_tipo_termo, nu_situacao_termo, nu_equipe);

-- Index: gct.ix_gcttb170_8

DROP INDEX IF EXISTS gct.ix_gcttb170_8;

CREATE INDEX ix_gcttb170_8
  ON gct.gcttb170_termo_equipe
  USING btree
  (nu_fatura_paga, nu_tipo_termo, nu_situacao_pagamento, nu_situacao_termo, nu_contrato);

ANALYZE gct.gcttb170_termo_equipe;

--
-- FIM
--
insert into gct.gcttb900_hstco_objetos_bd(no_objeto) values ('RTC24379532_01_DML.sql');

commit;
