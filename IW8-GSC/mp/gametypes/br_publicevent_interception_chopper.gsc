/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_interception_chopper.gsc
****************************************************************/

init() {
  var_0 = spawnStruct();
  var_0.attackerswaittime = ::ascendermodelview;
  var_0.isfeaturedisabled = ::deactivate;
  var_0._id_14382 = ::_id_14382;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0.weight = getdvarfloat("_encstr_B4681E7B31B3D72B3B2889FA099373D8B57B28AF97DB9BA7ADD927BB7BA7FB8D", 0);
  var_0._id_11B78 = getdvarint("_encstr_ABBA21B98D27EB269CF50E59FA96733A2B276C9507D14BBDCDFAADB0E1EB3A965BACE6", 0);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_8BED0D607AA349DB90A76A411B3758", "_encstr_ABA8275A47195E4023EAF2FA128BB8A6D5A7C6D6FF4116083952EA021AB1F0EE69374E6E9FE9CED013");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_8BED0D607AA349DB90A76A411B3758");
  level thread tracegroundheightexfil();
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(17, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  tr_vis_radius_override_lod2();
  _encstr_A5E90F93FBD27D283F8DD3EB361AE03DAB();
  thermite_linktostuck();
  thermite_watchglstuck();
  scripts\engine\scriptable::_id_12F5B("_encstr_A7F21C2F6B5A831B73A71B1DC7F7607EE888228FD151BB584F6ED916D0C8", ::_encstr_BA01118DD07B1CC1B29CBE310B76AF57375646);
}

tr_vis_radius_override_lod2() {
  level._id_12E2B = spawnStruct();
  level._id_12E2B._encstr_B6B91485F59BBEB29DCA731DEB63ED1BB08ED2DEE6B9 = _encstr_AC3F1DE882CB67D35F9B564362BBB99F775B60282BA9494837B1DD4B778B23();
  level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3 = [];
  level._id_12E2B.sg_ontimerexpired = getdvarint("_encstr_996B1F7786D341F010C92D6807EAB3DB33DFB8682BDF7269680763312AA88A3360", 1);
  level._id_12E2B._id_11F1F = getdvarint("_encstr_9A2E20D3F805097F18F5ADB20601638B5B7B8AA938D37D073055BDC13F69FFD5D988", 5);
  level._id_12E2B.spawnregions = getdvarint("_encstr_887921CDB1E47D4B37A3AC273695E0D14BF6CDFAB1A17B3807CA275D855AE82AA55BCA", 120);
  level._id_12E2B._encstr_B22A10A0037F972397568F7D3127CB9727BB = getdvarint("_encstr_ADFE1F2B43AB488CE8AC3D3326B243BCC9C29817035361176B4A819367BB7F6BE2", 4);
  level._id_12E2B._encstr_9AE81530AF5B289FDACDB83DA7B257D2A0BF28C817ECE0 = getdvarint("_encstr_87B82363D662E9A3FAF3E3D5B71277F801AD487E7ED950EB30B7FFD1C72AAB209385D19025", 50);
  level._id_12E2B._encstr_95A115FFB3D6EA3763B08D53E9186FA32FB74B6F3D74E2 = getdvarint("_encstr_8B18238750030FC285653FF2C64B8BEC88C87BAFF8D97B9AA9F0856B3D6141907410F3C750", 100);
  level._id_12E2B._encstr_8A20100B3B56CDA3AFB54B1B365619F50FC1 = getdvarint("_encstr_A2091F0EDB7356135D8BF848D2B7198BB74F189031FFD95583B480803A4FF946AB", 10);
  level._id_12E2B._encstr_AAC60DD816B9D0F50B1B5A0BDC9537 = ["_encstr_990F0BB116CD86B1B7BDA3CDB5", "_encstr_960F0BA630CBE8014F88CB5F72", "_encstr_B2230CB10BCDD036DBED47D839D9", "_encstr_99660D3706C3F85018FFA5D0212AD1", "_encstr_B2FB0F1673A33A2B20FFECAAB99F813853"];
  var_0 = getDvar("_encstr_A3B12082EE859101A0D0EF4B9039D0EB6B704D3141DBFA7369C0D3C38853B9D3D996", "_encstr_B40101");
  level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8 = [];

  if(var_0 != "_encstr_B40101") {
    var_1 = strtok(var_0, "_encstr_974C0246");

    foreach(var_3 in var_1)
    level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8[level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8.size] = int(var_3);
  } else
    level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8 = [15, 0, 0, 0, 0];

  var_5 = getDvar("_encstr_A3AC201B9EA8B1EBD255A728128D6B81589F0DA9FA3B81AD1B8E0967674F026B1390", "_encstr_B40101");
  level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B = [];

  if(var_5 != "_encstr_B40101") {
    var_6 = strtok(var_5, "_encstr_974C0246");

    foreach(var_3 in var_6)
    level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B[level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B.size] = float(var_3);
  } else
    level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B = [25, 0, 0, 0, 0];

  if(level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B.size != level._id_12E2B._encstr_AAC60DD816B9D0F50B1B5A0BDC9537.size || level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8.size != level._id_12E2B._encstr_AAC60DD816B9D0F50B1B5A0BDC9537.size) {}

  level._id_12E2B._id_11BAB = ["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922", "_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996", "_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC"];
  level._id_12E2B.waitteardowninfilmapomnvars = ["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A", "_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"];
  level._id_12E2B._id_14292 = ["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926", "_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2"];
  level._id_12E2B._encstr_AF410DA735F548B0876D5038A7035F = ["_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18", "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014", "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"];
  level._id_12E2B._encstr_8F810AA31AFB81B94259F01D = !level.br_circle_disabled;
  level._effect["_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"] = loadfx("_encstr_8C4525D999E1E596DD0EFAB183BC0727DEC1E53B99F0FA9B5BB5EBCD2DD99B16C6EBD9C995959B");
}

_encstr_A5E90F93FBD27D283F8DD3EB361AE03DAB() {
  var_0 = [];

  switch (getDvar("_encstr_9570084B1793A090CDFF")) {
    default:
      switch (scripts\mp\utility\game::getgametype()) {
        default:
          var_0["_encstr_87FD19B083BD774063E708F4B67BC92DE7F94060CA92B7F943CF8F"] = 1;
          var_0["_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768"] = 1;
          var_0["_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B"] = 1;
          var_0["_encstr_A6D71613391BBDEDA37DED33991A16E68C7D350BADDA569C"] = 1;
          var_0["_encstr_91591A4CE463DE7BA3AF9B57C12BE4AFB6AB734B3A4BB7379B31DB3C"] = 1;
          var_0["_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3"] = 1;
          var_0["_encstr_AC671D783B12B7EDC91F150ACC43E745DD41509F6150853097CBB3D0D3EFCD"] = 1;
      }

      break;
  }

  _handlevehiclerepair::_id_11A45("_encstr_BD751AA11568971B6671E3ABD848B3C110E32E31B9899A3F98E99BE2", var_0);
}

tracegroundheightexfil() {
  waitframe();

  if(!isDefined(game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"]))
    game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"] = [];

  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_A6841B1248BD1F128853D0DC63C05DAF6F01AAEA93808B0FF061F9C715", "_encstr_B14D289187AF89392CD7A1B183E8D7C1AB8963B4D8EBACD9ACE61D37FAB09DCA371DF593B29BC185EEE6");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_A6AD1944A38BCF562227CB3BEA07E5E9AA5D178BE4119F9CA25574", "_encstr_8D1E26521AB893822897525B91D881A3D5314A0AC110477BD0CD5C33E758133FF06BF113CBD743B3");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_ABF71B2DB9A3B2E41B56C1D14BDEE6BEC6A1ED1C07599CAFC693C26E43", "_encstr_8B7A2B8DF3D70235432FC809E01B2FDB158589BF18B7AF1DFF66204E6E60AB5184EB9773F38F6BAFB3D2EE6F92");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_A9B01F96DCD1B2936CB283475ADEB9D73634F68307594EF5A1CA16D847D0AF9B4D", "_encstr_AA0230F83B879935DA118B06B2E32783F5FB6318CF6FB1E5A245FD1641FAABC8418790487BED2BFF9AAF7F9163D29770BF7F");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_81B01F4885D377F22B283804684F4877CF482F705230457F090D5F082DE9AF4F32", "_encstr_93322F3A72D00B1A802FF0C34910690B6DA932927988AFD348A5E4DB7F98AFA39B219A8B237D3BC178ABE9DC3140F98E9F");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_8EB01F3AD841FF6BF125E0FCCB98D3899743C22390CB72A7C81DF9EC5D404F9A93", "_encstr_A5322F82C37F267399AFC0C3AF03FF6A83488AAA30A75F2B71F0C4EBD068DF35C3E822B330BBD257086DD9FC5D306F6AD3");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_8D391C3B15CB43CBE3EFF0C8C73780FF023CA03FEAB23556DA07D8C8835E", "_encstr_A6742C6D181F298D368138988B8B1FA36FAAE1539B77B1DD1FBAD01051A41378B753F857E4279B478212C8389B7D");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_9A3716F3401BCAC2BE5F63B5F118382F3C42EA23963EE0A1", "_encstr_92A2285953AFFE589E9F6977D88369BFAF4AD0600A57A5B0B7B6294FCF6D2088F3F1C808E3176630CE84");
  _encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D("_encstr_922717C3A83B55120B6F73C5690F9B9167F3EB4008EF6509A7", "_encstr_A1E92EA10B3660521051F98FC86BE9E84066EAB4EF415DFB63202303CF9C5A2D18D19A40591FDE8F5F43F777020AA17A");
}

_encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3) {
    if(scripts\mp\utility\player::isreallyalive(var_5))
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_0, var_5);
  }
}

_encstr_AC3F1DE882CB67D35F9B564362BBB99F775B60282BA9494837B1DD4B778B23() {
  var_0 = [];

  switch (getDvar("_encstr_9570084B1793A090CDFF")) {
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      var_0[var_0.size] = _id_12ADE((-224, -302, 1290), [], 100, 700);
      var_0[var_0.size] = _id_12ADE((-4432, 1726, 1406), [], 100, 800);
      var_0[var_0.size] = _id_12ADE((9991, 5704, 130), [], 100, 800);
      var_0[var_0.size] = _id_12ADE((10952, 2090, 633), [], 100, 700);
      var_0[var_0.size] = _id_12ADE((7518, -5720, 605), [], 100, 700);
      var_0[var_0.size] = _id_12ADE((11280, -4330, 605), [], 100, 700);
      var_0[var_0.size] = _id_12ADE((-8000, 4046, 250), [], 100, 700);
      var_0[var_0.size] = _id_12ADE((-4300, -4520, 1118), [], 100, 700);
      break;
    default:
      var_0[var_0.size] = _id_12ADE((-146, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      var_0[var_0.size] = _id_12ADE((0, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      var_0[var_0.size] = _id_12ADE((146, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      break;
  }

  return var_0;
}

_id_12ADE(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.minecart_run = var_0;
  var_4._encstr_AAE00D4B1E3CD8F8922781ABA3FA3E = var_1;
  var_4.minigun_internal = var_2;
  var_4._encstr_AC920BFB62F351C360AD3FA3B3 = var_3;
  var_4._id_13B91 = 0;
  var_4.new_rider_combat_logic = [];
  return var_4;
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

thermite_linktostuck() {
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AAE208481F244BE0C2E3"] = % _encstr_997517F83389FE757DD960136FC8FCF8B64192C9816B8F22CD;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_8A7A0A5BA3208BF9C830903B"] = % _encstr_97891980DB4A08B002C77151F5ED48ED9BB13889D2A740B81DDF79;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_873A093C894049E9A0FBDB"] = % _encstr_87DB18EA7737AEE3D61150515B821DFB6B7978E7E4DB6F807B90;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

thermite_watchglstuck() {
  level.scr_animtree["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"] = #animtree;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_BD990893ED1CCAF55ACD"] = % _encstr_84011C96BBC1F5C4E4AFE0B157CDC82B9CBE0DB2D85ABE93F61C59FAB49B;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_BD990893ED1CCAF55ACD"] = "_encstr_84011C96BBC1F5C4E4AFE0B157CDC82B9CBE0DB2D85ABE93F61C59FAB49B";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A38109E4ED0E2BD7DBBA1D"] = % _encstr_BDA71D1B174F60C0AA09EB60AB6E28A5034F919BD3E22808DFDA711ED55DE0;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A38109E4ED0E2BD7DBBA1D"] = "_encstr_BDA71D1B174F60C0AA09EB60AB6E28A5034F919BD3E22808DFDA711ED55DE0";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_97F90789B0ECFA4BDC"] = % _encstr_85B11B6CDBF26F0A1E9FDBA3E3C8B28D4826A4F710C02742FFF75FAF2D;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_97F90789B0ECFA4BDC"] = "_encstr_85B11B6CDBF26F0A1E9FDBA3E3C8B28D4826A4F710C02742FFF75FAF2D";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AB33087537C218C0B5DB"] = % _encstr_A3961CCB8750B988EB11C08858DA49B515F7F00BC221F12A07D8C9F77FA5;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AB33087537C218C0B5DB"] = "_encstr_A3961CCB8750B988EB11C08858DA49B515F7F00BC221F12A07D8C9F77FA5";
}

_encstr_A58E1F3B82CFE99F08B532CFC7EDCBC5C846D35BC3085D86F0D1C3EF15F8EC033D(var_0, var_1) {
  game["_encstr_B2DA070A5F8BAB87AF"][var_0] = var_1;
  game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"][var_0] = 1;
}

ascendermodelview() {
  level._id_12E2B._encstr_B6B91485F59BBEB29DCA731DEB63ED1BB08ED2DEE6B9 = scripts\engine\utility::array_randomize(level._id_12E2B._encstr_B6B91485F59BBEB29DCA731DEB63ED1BB08ED2DEE6B9);
  var_0 = undefined;
  var_1 = 0;
  var_2 = 0;

  if(level._id_12E2B._encstr_8F810AA31AFB81B94259F01D) {
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::inithelirepository() < 30 + level._id_12E2B.spawnregions && !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::islastcircle();
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::inithelirepository() < 30 && !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::islastcircle();
  }

  foreach(var_4 in level._id_12E2B._encstr_B6B91485F59BBEB29DCA731DEB63ED1BB08ED2DEE6B9) {
    if(!level._id_12E2B._encstr_8F810AA31AFB81B94259F01D) {
      if(!scripts\engine\utility::array_contains(level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3, var_4.minecart_run))
        var_0 = var_4;

      continue;
    }

    if(var_2) {
      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updatescavengerhud(var_4.minecart_run) && !scripts\engine\utility::array_contains(level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3, var_4.minecart_run))
        var_0 = var_4;

      continue;
    }

    if(var_1) {
      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updatescavengerhud(var_4.minecart_run) && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_4.minecart_run) && !scripts\engine\utility::array_contains(level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3, var_4.minecart_run))
        var_0 = var_4;

      continue;
    }

    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_4.minecart_run) && !scripts\engine\utility::array_contains(level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3, var_4.minecart_run))
      var_0 = var_4;
  }

  if(isDefined(var_0)) {
    foreach(var_7 in level.players) {
      var_7 thread scripts\mp\hud_message::showsplash("_encstr_8BC8193A7E39CA3B316B7809325590B35B73F14FD53E8B43979370");

      if(scripts\mp\utility\player::isreallyalive(var_7))
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A6AD1944A38BCF562227CB3BEA07E5E9AA5D178BE4119F9CA25574", var_7);
    }

    level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3[level._id_12E2B._encstr_A9E019B2594D494FFB3DECDFC5A3F7CDA1C1EAEA103BFB775090E3.size] = var_0.minecart_run;
    thread _id_13794(var_0);
    scripts\common\vehicle_code::_encstr_8E0D1B1C7FA2F3717487F1982B91AB3139E61B30D61BB77824AF60E077();
  }
}

deactivate() {}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");

  if(getdvarint("_encstr_8266157316DA2EBA482930BFCF430DA5438F02ED626F11", 0) == 1 && level.br_circle.circleindex <= 1)
    level waittill("_encstr_9A5B122613D778EAB328E0F5608153BAB6EB3D4C");
}

_id_13794(var_0) {
  var_0._encstr_BDC70B58360BD7AB0FEBF820D7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.minecart_run + (0, 0, -30), 0, var_0._encstr_AC920BFB62F351C360AD3FA3B3, var_0._encstr_AC920BFB62F351C360AD3FA3B3 * 2);
  var_1 = randomfloat(360);
  var_2 = var_0.minecart_run + -1 * anglesToForward((0, var_1, 0)) * 26000 + (0, 0, 3300);
  var_3 = vectortoangles(var_0.minecart_run - var_2);
  var_4 = 99;
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "_encstr_A215169359C387A680CB7370EBD12AF3F5902A2AC33007DA", "_encstr_8DA02CD95986E07DDAB4C6BE852D937D6BD2378CD2C270AF5B59E436CA73B09CCBAFB23C4793166C1D96BDE6AFC3");

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = var_0.minecart_run * (1, 1, 0) + (0, 0, 3300);
  var_0.heli = var_5;
  var_5._id_11980 = var_0;
  var_5.damagecallback = ::callback_vehicledamage;
  var_5.speed = 50;
  var_5.accel = 125;
  var_5.health = 10000;
  var_5.maxhealth = var_5.health;
  var_5.defendloc = var_0.minecart_run;
  var_5.lifeid = 0;
  var_5.flaresreservecount = var_4;
  var_5.pathgoal = var_6;
  var_5._id_121FF = var_0.minecart_run + anglesToForward(var_3) * 26000 + (0, 0, 3300);
  var_5.endpoint = var_6;
  var_5.select_mountain_two_spawners = var_3[1];
  var_5.animname = "_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192";
  var_5.leaving = 0;
  var_5._encstr_A7A4138DEA9C9CACCDA3D8CB1C632C2F4BB9B3EC7B = 0;
  var_5._encstr_825F131BD297B3201F3793218D86B0FD1B8AB1C3CA = 0;
  var_5._encstr_81D7130E8D0BBC5646D4811A2BB08DD134890B93DA = 0;
  var_5._encstr_954A1307362C5E5919194DA1CA856347D0262C4EDA = 0;
  var_5.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.defendloc);
  var_5.scenenode.angles = var_3;
  var_5.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5.vehiclename = "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B";
  var_5 setCanDamage(1);
  var_5 setmaxpitchroll(10, 25);
  var_5 vehicle_setspeed(var_5.speed, var_5.accel);
  var_5 sethoverparams(50, 100, 50);
  var_5 setturningability(0.05);
  var_5 setyawspeed(45, 25, 25, 0.5);
  _id_13693(var_5);
  var_5 thread showquestcircletoplayer();
  var_5 thread handledestroydamage();
  var_5 thread givebrbonusxp();
  var_5 _meth_87E8();
  var_5 thread _encstr_BE6C230DB263D2462B37E8E47B97B3590DB48DC6CA6ED8DE8DC6969B96B7B9DCB7E82D33E5();
  var_5 thread givebrweaponxp();
}

givebrweaponxp() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "_encstr_AAE208481F244BE0C2E3");
  thread scripts\common\anim::anim_single_solo(self.rope, "_encstr_BD990893ED1CCAF55ACD", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_97F90789B0ECFA4BDC", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_0 = givequestsplash(self.pathgoal, self._id_11980);
  thread _encstr_A6F318401AFBF3B9E248F3C74EC190494F52792E6227B6203F22();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self._id_11980._encstr_A720129F1D80A3BB35E6523BC817475A28B31EF4, "_encstr_8218041DF5FA");
  var_1 = spawnStruct();
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(11, 4, 2, self._id_11980._encstr_A720129F1D80A3BB35E6523BC817475A28B31EF4);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(1000);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  level thread _encstr_B19E265CEACADCA3BE8DA59C8D63567DB163B2859B5D387DED9BF5D843F61CE0B2E4EB9156581D43(var_1);
  self waittill("_encstr_8B7205D9ED5958");
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();
  thread givespecialistbonusifneeded();
  givebmodevloadouts(self.endpoint, var_0);
}

_encstr_B19E265CEACADCA3BE8DA59C8D63567DB163B2859B5D387DED9BF5D843F61CE0B2E4EB9156581D43(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  self endon("_encstr_8B7205D9ED5958");
  self waittill("_encstr_AD75063D571AE108");
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();
}

_encstr_A6F318401AFBF3B9E248F3C74EC190494F52792E6227B6203F22() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self._id_11980._encstr_A720129F1D80A3BB35E6523BC817475A28B31EF4 - (0, 0, 3));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self._encstr_8F6D0CE6B5DE5BCACE99E195B9E8 = var_0;
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

givebmodevloadouts(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25.0, 31.25);
  thread _encstr_97C21A36E0378371CFBB5930F3E62D5B9F914CBD4EE3AEBF729220C0(0.1, 0.8);
  level thread _encstr_8B991A5876599B1DD7EE168E1B0DF532B09B9D9593F51BA539D81BAC(self._id_11980);
  self waittill("_encstr_8B7205D9ED5958");
  self sethoverparams(1, 1);
  thread giverandomloadoutindex();
}

_encstr_BE6C230DB263D2462B37E8E47B97B3590DB48DC6CA6ED8DE8DC6969B96B7B9DCB7E82D33E5() {
  self endon("_encstr_A9B60A3495C6A5F5D9DEB92B");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_7) && var_7 nuke_vault_suicidebomber_internal()) {
      var_7 dodamage(var_7.health, self.origin, self, self, "_encstr_8D4E0A501FCB898912CB3FA3");
      self dodamage(self.maxhealth / 2, self.origin, var_7, var_7, "_encstr_8D4E0A501FCB898912CB3FA3");
    }
  }
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

_encstr_8B991A5876599B1DD7EE168E1B0DF532B09B9D9593F51BA539D81BAC(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_8D5E16376C9CAF4C39F5D84B396C8DCAD7914B6E0B26632B") == 0) {
    while(var_0.new_rider_combat_logic.size > 0 || isDefined(var_0.heli) && !var_0.heli.leaving) {
      foreach(var_2 in var_0.new_rider_combat_logic) {
        if(isDefined(var_2) && isalive(var_2)) {
          if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_2.origin))
            var_2 dodamage(var_2.health, var_2.origin, var_2, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", undefined);
        }
      }

      wait 0.1;
    }

    scripts\common\vehicle_code::_encstr_A9F51ACE950D2D6C63CABECDD1ED0EBEC2A5AFB067F6D219B0B98DB2();
  }
}

_encstr_97C21A36E0378371CFBB5930F3E62D5B9F914CBD4EE3AEBF729220C0(var_0, var_1) {
  waitframe();
  var_2 = level._id_12E2B._id_11F1F - self._id_11980.new_rider_combat_logic.size;

  if(var_2 == 0) {
    return;
  }
  var_3 = 360 / var_2;
  var_4 = anglesToForward(self.angles);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = var_3 * var_5;
    var_7 = var_3 * (var_5 + 1);
    var_8 = randomfloatrange(var_6, var_7);
    var_9 = self._id_11980._encstr_AC920BFB62F351C360AD3FA3B3 * var_0;
    var_10 = self._id_11980._encstr_AC920BFB62F351C360AD3FA3B3 * var_1;
    var_11 = randomfloatrange(var_9, var_10);
    var_12 = vectorNormalize(rotatevector(var_4, (0, var_8, 0)));
    var_13 = self._id_11980.minecart_run + var_12 * var_11;
    var_13 = getclosestpointonnavmesh(var_13);
    var_14 = getgroundposition(var_13, 32, 2000, 1500);

    for(var_15 = 0; distancesquared(var_14, var_13) > 1024 && var_15 < 5; var_14 = getgroundposition(var_13, 32, 2000, 1500)) {
      var_15++;
      var_8 = randomfloatrange(var_6, var_7);
      var_12 = vectorNormalize(rotatevector(var_4, (0, var_8, 0)));
      var_11 = randomfloatrange(var_9, var_10);
      var_13 = self._id_11980.minecart_run + var_12 * var_11;
      var_13 = getclosestpointonnavmesh(var_13);
    }

    var_16 = _encstr_992A1297B362CC08DF5F23B902CC490FBA4F3511(var_14, self._id_11980, (0, 0, 180), 1, "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B", "_encstr_8EA90CD15D6E5880FB53B1D84BE7");
    var_16 thread _encstr_A6E31516D9CA37D1F5B696B9D2BEAD851CD7C1A5E6CEDC();
    var_16 thread _encstr_A1981271BCA1B31BBF40E2ABF80919531917ECE0(self._id_11980);

    if(var_5 < self._id_11980._encstr_AAE00D4B1E3CD8F8922781ABA3FA3E.size)
      var_16._encstr_839D11F3F3150B4740134E1308789F72E02177 = self._id_11980._encstr_AAE00D4B1E3CD8F8922781ABA3FA3E[var_5];

    self._id_11980.new_rider_combat_logic = scripts\engine\utility::array_add(self._id_11980.new_rider_combat_logic, var_16);
    waitframe();
  }
}

_encstr_A6E31516D9CA37D1F5B696B9D2BEAD851CD7C1A5E6CEDC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0.5;
  var_1 = 15.0;

  for(;;) {
    self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(var_0);
    self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(var_1);
  }
}

_encstr_A1981271BCA1B31BBF40E2ABF80919531917ECE0(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108", var_1);
  var_0.new_rider_combat_logic = scripts\engine\utility::array_remove(var_0.new_rider_combat_logic, self);

  if(isPlayer(var_1)) {
    var_1 thread scripts\mp\rank::giverankxp("_encstr_ABD70578F3D02C", level._id_12E2B._encstr_8A20100B3B56CDA3AFB54B1B365619F50FC1, var_1 getcurrentweapon());
    var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_ABD70578F3D02C");
  }

  var_2 = [];

  if(randomint(2) == 1)
    var_2[var_2.size] = "_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA";

  switch (randomint(3)) {
    case 0:
      var_2[var_2.size] = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
      break;
    case 1:
      var_3 = randomintrange(0, level._id_12E2B._encstr_AF410DA735F548B0876D5038A7035F.size);
      var_2[var_2.size] = level._id_12E2B._encstr_AF410DA735F548B0876D5038A7035F[var_3];
      break;
  }

  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  foreach(var_6 in var_2) {
    var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_4, self.origin + (0, 0, 2), self.angles, self);
    var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_6, var_7, 1, 1);
  }
}

giverandomloadoutindex() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  wait(level._id_12E2B.spawnregions);
  _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_8D391C3B15CB43CBE3EFF0C8C73780FF023CA03FEAB23556DA07D8C8835E", self.origin, 1000);
  thread givequestreward();
}

_encstr_BA01118DD07B1CC1B29CBE310B76AF57375646(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0.entity._id_11980.heli endon("_encstr_BA2D081B2B58B32D37EC");
  var_5 = level._id_12E2B._encstr_B22A10A0037F972397568F7D3127CB9727BB + level._id_12E2B.sg_ontimerexpired;
  var_6 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_7 = var_0.entity _id_13C2D(var_0.origin, 100, [var_0.entity]);
  var_8 = var_7[2] + 2;
  var_0.entity._id_11980._id_13B91++;

  if(var_0.entity._id_11980._id_13B91 >= var_5) {
    var_0 setscriptablepartstate("_encstr_A7F21C2F6B5A831B73A71B1DC7F7607EE888228FD151BB584F6ED916D0C8", "_encstr_ADB209DDA0A3209B828060");

    if(level._id_12E2B.sg_ontimerexpired) {
      level thread _handlevehiclerepair::_id_13673("_encstr_BD751AA11568971B6671E3ABD848B3C110E32E31B9899A3F98E99BE2", (var_0.origin[0], var_0.origin[1], var_8), randomint(3) + 2, 0);
      var_3 thread scripts\mp\rank::giverankxp("_encstr_93D50D50754757B91858A1848079C8", level._id_12E2B._encstr_95A115FFB3D6EA3763B08D53E9186FA32FB74B6F3D74E2);
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_93D50D50754757B91858A1848079C8");
    } else {
      chopper_gunner_assigntargetmarkers(var_0.entity, var_6, var_8, 1, 1);
      var_3 thread scripts\mp\rank::giverankxp("_encstr_93D50D50754757B91858A1848079C8", level._id_12E2B._encstr_9AE81530AF5B289FDACDB83DA7B257D2A0BF28C817ECE0);
      var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_93D50D50754757B91858A1848079C8");
    }

    _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_922717C3A83B55120B6F73C5690F9B9167F3EB4008EF6509A7", var_0.origin, 800);
    var_0.entity._id_11980.heli thread givequestreward();
  } else {
    chopper_gunner_assigntargetmarkers(var_0.entity, var_6, var_8, 1, 1);
    var_3 thread scripts\mp\rank::giverankxp("_encstr_93D50D50754757B91858A1848079C8", level._id_12E2B._encstr_9AE81530AF5B289FDACDB83DA7B257D2A0BF28C817ECE0);
    var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_93D50D50754757B91858A1848079C8");

    if(var_0.entity._id_11980._id_13B91 == 2) {
      var_0.entity._id_11980.heli _encstr_97C21A36E0378371CFBB5930F3E62D5B9F914CBD4EE3AEBF729220C0(0.75, 1.0);
      _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_A6841B1248BD1F128853D0DC63C05DAF6F01AAEA93808B0FF061F9C715", var_0.origin, 800);
    } else if(scripts\engine\utility::cointoss())
      _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_9A3716F3401BCAC2BE5F63B5F118382F3C42EA23963EE0A1", var_0.origin, 800);
  }
}

givespecialistbonusifneeded() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread givequestreward();
}

givequestreward() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;

  foreach(var_1 in level.players)
  var_1 thread scripts\mp\hud_message::showsplash("_encstr_A21917264EEB832BBED2E63A2B4EC6ACE08E2DED9BEB953746");

  self sethoverparams(25, 20, 10);
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  thread scripts\common\anim::anim_single_solo(self.rope, "_encstr_A38109E4ED0E2BD7DBBA1D", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_AB33087537C218C0B5DB", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  self waittill("_encstr_8B7205D9ED5958");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_121FF, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  self notify("_encstr_A9B60A3495C6A5F5D9DEB92B");
  giveachievementsmoke();
  giveawardfake();
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_1 = var_1.owner;
  }

  if(var_1 == self) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  if(!self._encstr_A7A4138DEA9C9CACCDA3D8CB1C632C2F4BB9B3EC7B) {
    if(!self._encstr_954A1307362C5E5919194DA1CA856347D0262C4EDA && self.health < self.maxhealth * 0.25) {
      self._encstr_954A1307362C5E5919194DA1CA856347D0262C4EDA = 1;
      self._encstr_81D7130E8D0BBC5646D4811A2BB08DD134890B93DA = 1;
      self._encstr_825F131BD297B3201F3793218D86B0FD1B8AB1C3CA = 1;
      _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_8EB01F3AD841FF6BF125E0FCCB98D3899743C22390CB72A7C81DF9EC5D404F9A93", self.origin, 1000);
      thread _encstr_A6B2108CE00FC627F897C7CA379F48B7439B(lookupsoundlength("_encstr_8EB01F3AD841FF6BF125E0FCCB98D3899743C22390CB72A7C81DF9EC5D404F9A93", 1) / 1000);
    } else if(!self._encstr_81D7130E8D0BBC5646D4811A2BB08DD134890B93DA && self.health < self.maxhealth * 0.5) {
      self._encstr_81D7130E8D0BBC5646D4811A2BB08DD134890B93DA = 1;
      self._encstr_825F131BD297B3201F3793218D86B0FD1B8AB1C3CA = 1;
      _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_81B01F4885D377F22B283804684F4877CF482F705230457F090D5F082DE9AF4F32", self.origin, 1000);
      thread _encstr_A6B2108CE00FC627F897C7CA379F48B7439B(lookupsoundlength("_encstr_81B01F4885D377F22B283804684F4877CF482F705230457F090D5F082DE9AF4F32", 1) / 1000);
    } else if(!self._encstr_825F131BD297B3201F3793218D86B0FD1B8AB1C3CA && self.health < self.maxhealth * 0.75) {
      self._encstr_825F131BD297B3201F3793218D86B0FD1B8AB1C3CA = 1;
      _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_A9B01F96DCD1B2936CB283475ADEB9D73634F68307594EF5A1CA16D847D0AF9B4D", self.origin, 1000);
      thread _encstr_A6B2108CE00FC627F897C7CA379F48B7439B(lookupsoundlength("_encstr_A9B01F96DCD1B2936CB283475ADEB9D73634F68307594EF5A1CA16D847D0AF9B4D", 1) / 1000);
    }
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_encstr_A6B2108CE00FC627F897C7CA379F48B7439B(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._encstr_A7A4138DEA9C9CACCDA3D8CB1C632C2F4BB9B3EC7B = 1;
  wait(var_0);
  self._encstr_A7A4138DEA9C9CACCDA3D8CB1C632C2F4BB9B3EC7B = 0;
}

chopper_gunner_assigntargetmarkers(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(var_3) {
    var_6 = randomintrange(1, 3);

    for(var_7 = 0; var_7 < var_6; var_7++)
      var_5[var_5.size] = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";
  }

  if(var_4) {
    var_8 = randomintrange(1, 3);

    for(var_7 = 0; var_7 < var_8; var_7++) {
      var_9 = randomintrange(0, level._id_12E2B._encstr_AF410DA735F548B0876D5038A7035F.size);
      var_5[var_5.size] = level._id_12E2B._encstr_AF410DA735F548B0876D5038A7035F[var_9];
    }
  }

  for(var_7 = 0; var_7 < level._id_12E2B._encstr_AAC60DD816B9D0F50B1B5A0BDC9537.size; var_7++) {
    var_10 = randomintrange(level._id_12E2B._encstr_92BE11B04A455F896F83C3507A87F3EBAA02C8[var_7], level._id_12E2B._encstr_99DA116DC3C0D187BF7B9AD163859F16C8A10B[var_7] + 1);

    for(var_11 = 0; var_11 < var_10; var_11++)
      var_5[var_5.size] = level._id_12E2B._encstr_AAC60DD816B9D0F50B1B5A0BDC9537[var_7];
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);

  foreach(var_13 in var_5) {
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, (var_0.origin[0], var_0.origin[1], var_2), var_0.angles, var_0);
    var_15 = "_encstr_B40101";

    switch (var_13) {
      case "_encstr_990F0BB116CD86B1B7BDA3CDB5":
        var_15 = "_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA";
        break;
      case "_encstr_960F0BA630CBE8014F88CB5F72":
        var_15 = scripts\engine\utility::random(level._id_12E2B._id_11BAB);
        break;
      case "_encstr_B2230CB10BCDD036DBED47D839D9":
        var_15 = scripts\engine\utility::random(level._id_12E2B.waitteardowninfilmapomnvars);
        break;
      case "_encstr_99660D3706C3F85018FFA5D0212AD1":
        var_15 = scripts\engine\utility::random(level._id_12E2B._id_14292);
        break;
      case "_encstr_B2FB0F1673A33A2B20FFECAAB99F813853":
        var_15 = "_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72";
        break;
      default:
        var_15 = var_13;
        break;
    }

    var_16 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_15, var_14, 1, 1);
  }
}

showquestcircletoplayer() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8617083B2B9203E9606B");

  for(;;)
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

givebrbonusxp() {
  self endon("_encstr_A9B60A3495C6A5F5D9DEB92B");
  self endon("_encstr_8617083B2B9203E9606B");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("_encstr_AD75063D571AE108", var_2, var_3, var_4, var_5);
  _encstr_A28A1683D858E57D3B7BAFB995C239AFC6BDC6B0D14BEDB9("_encstr_ABF71B2DB9A3B2E41B56C1D14BDEE6BEC6A1ED1C07599CAFC693C26E43", self.origin, 1000);
  var_6 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  chopper_gunner_assigntargetmarkers(self, var_6, self.origin[2], 0, 0);

  foreach(var_8 in level.players)
  var_8 thread scripts\mp\hud_message::showsplash("_encstr_A1111DB083714901CFD188FDB513893BE24B5050DA99A9D947D48E78919791");

  giveachievementsmoke();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread giveammo(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  givelaststandifneeded(var_2);
}

handledestroydamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8617083B2B9203E9606B");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "_encstr_A63B18C2B0DA5A9B6E4BC6CAFA0E9CDE35CA36475A8D59FA6BE0" || var_9.basename == "_encstr_A29408E6D5D6CAAF5B1C") && var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      giveachievementwildfire();
    }
  }
}

_id_13693(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_BA95205B96E61BEB392C1C563663B437CEFAC97BE0ACBE8198F533B4269527EB26E4");
  var_1 linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (11, 20, 42), (0, 180, 0));
  var_1.animname = "_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192";
  var_1 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "_encstr_BD990893ED1CCAF55ACD", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_2 setModel("_encstr_976B256E121FC8A3F24250F09A0A53462FB0EDDE998793E39DBA89A8F2A50B3B8742F3C0F23739");
  var_2 linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  var_2.animname = "_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192";
  var_2 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "_encstr_97F90789B0ECFA4BDC", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_0.rope = var_1;
  var_0.crate = var_2;
  var_2._id_11980 = var_0._id_11980;
}

giveachievementsmoke() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();

  if(isDefined(self._id_11980._encstr_BDC70B58360BD7AB0FEBF820D7))
    self._id_11980._encstr_BDC70B58360BD7AB0FEBF820D7 delete();

  giveachievementwildfire();
}

givelaststandifneeded(var_0) {
  var_1 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, 40);
  playFX(scripts\engine\utility::getfx("_encstr_86A914B1963AA38DB2BE89D2938CAFAC3CC11BED32AC"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "_encstr_B1CA1AD495531E3FE4F288904ABA8F539F285FC0FA4B46074AFA9858");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("_encstr_860808CB78E2984063BA");
  wait 0.35;
  giveachievementwildfire();
  giveawardfake();
}

giveawardfake() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

giveammo(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self notify("_encstr_A3AC0E689D58D2870256B720A28B8AA7");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

giveachievementwildfire() {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(isDefined(self._encstr_8F6D0CE6B5DE5BCACE99E195B9E8))
    self._encstr_8F6D0CE6B5DE5BCACE99E195B9E8 delete();
}

givequestsplash(var_0, var_1) {
  var_2 = 715;
  var_3 = _id_13C2D(var_0, 100, [self]);
  var_4 = var_3[2];
  var_5 = var_4 + var_2;
  var_1._encstr_A720129F1D80A3BB35E6523BC817475A28B31EF4 = var_3;
  return var_5;
}

_id_13C2D(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1))
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  else
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);

  if(isDefined(var_6))
    return var_6["_encstr_BD260953AA97E3F014279D"];
  else
    return undefined;
}

_encstr_86690FD7BEBEF5582DF50D2B8D38ACC99B() {}

_encstr_992A1297B362CC08DF5F23B902CC490FBA4F3511(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B";

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_5))
    var_5 = "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";

  var_6 = spawnStruct();
  var_6._encstr_84F915B83FAFE32BC38666FB9BFB7B4EEB4B70D0E32D7B = 1;
  var_7 = _testing_ending::_encstr_82F017C37BFB3B65E0678B7040137ED62AE87385A8FF8A3D93(var_0, var_2, 1, var_4, var_5);

  if(!isDefined(var_7)) {
    return;
  }
  var_7.guid = var_7 getguid();
  var_7 setgoalvolumeauto(var_1._encstr_BDC70B58360BD7AB0FEBF820D7);
  var_7.move_closest_chopper_boss_vandalize_node_down = 1;
  var_7 _testing_ending::ammobox_getbufferedattachmentsourceweapon();
  var_7 thread _testing_ending::alwaysdoskyspawnontacinsert();
  var_7 thread _testing_ending::activeparachutersfactionvo();
  var_7 thread _testing_ending::activestate();

  if(var_3)
    var_7 _testing_ending::scriptable_token_scriptable_touched_callback(250);

  var_7.maxsightdistsqrd = 9000000;
  level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed._id_1363D, var_7);
  return var_7;
}

activate_destructible_cinderblock() {}