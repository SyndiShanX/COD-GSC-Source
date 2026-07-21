/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_mxp.gsc
***********************************************/

activate_laser_trap_parent() {}

init() {
  if(!getdvarint("_encstr_A31414DBF60BE1E20E6FC138209912602D92FFC8B34B", 0)) {
    return;
  }
  unloadinfiltransient("_encstr_B6A31F6BE0F55ADC99D2D8D7BB9EFA2D37360BCD23AFB34E2BB2DC89B05ED7474E");
  unloadinfiltransient("_encstr_AD4D1ED683AF2D9B662DD8AFDD9ED796E68DC2B946BEDACA73DBB90D2CD7A3C9");
  teleportplayertoselection();
  tr_vis_radius_override_lod2();
  zombieregendelayscaleingas();
  vehicle_outline_watcher();
  post_safeges_weapon();
  testing();
  _id_13220();
  toggle_ai_settings();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8F3D0D4E3F80D93A908562A277D7A9", ::_encstr_8B0110B9C3D5F0EFFB7A6E9688B02AD3DC68);
  thread toggleusbstickinhand();
}

tr_vis_radius_override_lod2() {
  level.disable_super_in_turret.brlootchoppercratedestroycallback = 1;
  level.disable_oob_immunity_on_riders = 1;
  level._id_11E18 = spawnStruct();
  level._id_11E18._encstr_BE591956CAE8A5B65689958EEEB256E691D2C2B1B7CE36B4E6CACD = getdvarfloat("_encstr_928521BBE1B6EF0E081FC5C85939974F487B92C28998C307D067C5DD0D111D8708F14B", 1.5);
  level._id_11E18._encstr_963B1CB23A053E256968BB6ADC37F0BCEA535BC0193FA0B53BEAC44A8375 = getdvarint("_encstr_8B0D286ED893FA3193F5D60FC1BE6DFA1ACA2C91BE36A158D86356CD9DACBEE84E963BBE8656B4EC868E", 1250);
  level._id_11E18._encstr_A2BC1CB5D0B2B08CD81A588D3656B9ECB21D4EB476EC2B933958C8D2BADC = getdvarint("_encstr_830E286EC693FA319CF5D687E0AFDABE86B2858CBE36A185C63659739D2B7DA339963BFA39C2C8D2ABDC", 750);
  level._id_11E18._encstr_837318DA1BD00BD8D8CADCECACA3395AEC9D95C934565AB386E8 = getdvarint("_encstr_958B23CDD8E4AF98C9D7DA0F83AFAD7D8D43581BC656E6D956FAD1C9D29DD786595A3B1A8E", 1750);
  level._id_11E18._encstr_B2AF180251F0C6F47117373FEF3102D0F88F8D4A834F55302B82 = getdvarint("_encstr_BD1B23CB7F28694BFE26025BEB4057D108F1512C8948ED172D5E8BC3D0A44FD26041C1BD0F", 150);
  level._id_11E18._encstr_8BBF159A43E319E527B238100A3EB9F15FEA178DA16720 = getdvarfloat("_encstr_A9711F9B2E8A01CE2377CBE9E3D982B9234341B097FFC8F02953C3E3ABA15D20DA", 2.5);
  level._id_11E18._encstr_B1941559957D36DBBDB1C8DBDDE67D915D3916D15ABDB9 = getdvarfloat("_encstr_8FA217573F9318A8B21160DAC2B7D84DF997F7E7FB1AD838F6", 1.0);
  level._id_11E18._encstr_8D3E158AA46BE33B44E3281B877C5117A3CC75037F1269 = getdvarint("_encstr_A32125E64BF201803AAED3712BA692E737AC03E1A9A7A13A1F97A37F04D0CEDCA93CB054270ACC", 2000);
  level._id_11E18._encstr_B66311F7ADEB7B877CC7C6BBAF9A2A81505792 = getdvarint("_encstr_8E3A1FF77392F136CB0958E2E3A77A392CDD4369277F1886FB0230899ACF213047", 17500);
  level._id_11E18._encstr_B1D613B5A657B5388C969BE885E6D8CAAD5AC8DCB8 = level._id_11E18._encstr_B66311F7ADEB7B877CC7C6BBAF9A2A81505792 * level._id_11E18._encstr_B66311F7ADEB7B877CC7C6BBAF9A2A81505792;
  level._id_11E18._encstr_8662126D4DD55BC18C4B6E1D58CD8DAC8D7BB9CE = getdvarint("_encstr_B8E120B9D8C9D72627AFB5F01C7DB6AF35576BE07D23D2378E16E68D2BBE1BF637EC", 27500);
  level._id_11E18._encstr_BE661492BA8518A84169A3F030E8E717AD8FB6D97B1A = level._id_11E18._encstr_8662126D4DD55BC18C4B6E1D58CD8DAC8D7BB9CE * level._id_11E18._encstr_8662126D4DD55BC18C4B6E1D58CD8DAC8D7BB9CE;
  level._id_11E18._encstr_868E10788B55B0F96292B7C4ACAB1378A103 = getdvarint("_encstr_A7281E37C6E4AF4C27EBD6F00E7DDAF54D57AD07AFD99CB0ECA5A35ED76BD237", 4000);
  level._id_11E18._encstr_A78E106DA9AE6B1C769C2C67A54797B52D19 = getdvarint("_encstr_86281E63EE5BE74B1BF1207A508E4A50E24B15D3D00792616332239088223B9B", 8000);
  level._id_11E18._encstr_A98E10081A5B4A820FDE89A4F805D981E303 = getdvarint("_encstr_AC281E7FFB0A69BE4371D07A6B1FE2B1A445FBF15F3748776B0A0B42A18FAFC0", 12500);
  level._id_11E18._encstr_8E4D0E2ACA77084972B390E88A8D3320 = getdvarint("_encstr_B63D24D6B64BD729122738888367409FB25B41DF01F35131EDE3A1D88B7FBB314902CF68E74A", 6000);
  level._id_11E18._encstr_964D0EC750EDB80113EB0F3569C08339 = getdvarint("_encstr_866822DCC6E4F5984EF5ADC30EAF6D7D53D55BC17DB90E56CA23EBB64B32D7C9589BD9CA", 7500);
  level._id_11E18._encstr_AF4D0E5B535DDA1C37C1AC2B91B658C3 = getdvarint("_encstr_AB78235B966B5F86FDE9DA83784F3CA78005DDD02013AB0F8B08E13A981577EF3BE7567F45", 9000);
  level._id_11E18._encstr_8AE0198330955F2350A170381BEB1193DD53B50D5B03A89DB4A5A8 = getdvarint("_encstr_8203251F11A0DFCFE213B042F6A7065F6DED7B8791AA2DEB1BE898F0DDC0C7CAC34E3A99196D0E", 2.0);
  level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27 = getdvarint("_encstr_9B2D1E5B966B5F45E990F9B2013F7A676388D4FFB790BFCD89D133EAC01BF35F", 4000);
  level._id_11E18._encstr_B8060E5492680B6847B3E252A81BFFF3 = getdvarfloat("_encstr_9588183FBB4A29792BC356D8596B2080E22FA9BB3276B8B34F3A", 1.25);
  level._id_11E18._encstr_A9170E8788F04103E195AA667D83AA06 = getdvarfloat("_encstr_847D18A0B74ADEEBAB3AB0A4D92327C192AFE0186BF1F3BBA2A5", 2.5);
  level._id_11E18._encstr_AF3317C4998037BC49A8C2DAA0BD36EF38754D5AA78B570515 = getdvarfloat("_encstr_868020B3E9BEF7D55079FFC46380DC037021AA5A911EC78E303FFCC52DE8E3BF8098", 0.5);
  level._id_11E18._encstr_9B8318A3DAAC46D2ABADCCAC958C13B08DAD46AEC9588E2DDEB9 = getdvarfloat("_encstr_9103211BB71B4F9DB8D057CDEA311F2B0D2FD03B732378681F47EFFDBD92A2A517A7E5", 1.0);
  level._id_11E18._encstr_968A17D10D9558EC2F99B259462616D86D32EAE4854796DBE6 = getdvarfloat("_encstr_AD4A20371B39EB5B870EBE3495589D97BECCCA9546C458C65BD732AE4E58A3A5F6B9", 1.25);
  level._id_11E18._encstr_A2EF141003D94179E307253D9F5AB30933833058876D = getdvarint("_encstr_97BF1DB93693D7B51EC1D78D4B76341DF59959AC2326B0C6B5D74E0BE6CEAC", 10000);
  level._id_11E18._encstr_935C15A35B56192D5D6B33ACAC1989C28DB5390B9BD92B = getdvarint("_encstr_A55A1E68C26A4750E378A0A145BB18AB15A95850DA8775E9579BA82659EB8143", 10000);
  level._id_11E18._encstr_BD2214D10DCA16ECCB9959AC9126C28DD6E485373B95 = getdvarint("_encstr_91B31D3A8970BF0AEB31B763731FC3E171B13707C12849224A571B3F7D343A", 10000);
  level._id_11E18.wait_for_player_in_gas = getdvarint("_encstr_BD6B19A643EBCEEDB2C150804B81B786CFE1A008D9475323DDFAA8", 2);
  level._id_11E18.wait_for_player_gulag_respawn = getdvarint("_encstr_81A6197BCF98D99B2EF6F2AB3B90E78108B3F8CF63A8DB7F58C82B", 3);
  level._id_11E18.select_bunker_courtyard_spawners = getdvarfloat("_encstr_886E17E66CC9AF3193AF6B1EC1AFEC7DB5CDD7D84358B9B159", 0.5);
  level._id_11E18.select_bunker_interior_groups = getdvarint("_encstr_8F4F149B36E4BEC427D7ADE183D7ECD7D6DCEBADB0C3", 20000);
  level._id_11E18.select_bunker_interior_four_spawners = getdvarint("_encstr_8F4F149B36E4BEC427D7ADE183D7ECD7D6DCEBADB0C3", 10000);
  level._id_11E18._encstr_91B717B3E65B0B1B1B5B96B1366E8E27ACC2DA932C915AD5DC = getdvarint("_encstr_9ACF16721E5541DAF3397F33580E9B09C72AF1EAF19BAAEC", 1000);
  level._id_11E18.wait_for_players_init_puzzle = getdvarint("_encstr_955F1403590E47A6D0F73D208191ACFF3AF3596AE1E3", 20000);
  level._id_11E18.wait_for_player_to_getup = getdvarint("_encstr_955F1403590E47A6D0F73D208191ACFF3AF3596AE1E3", 8000);
  level._id_11E18.waitandstartplunderpolling = getdvarint("_encstr_A3431686238BAE8DD2A130A06BA1576637DB187EB56F70C9", 2000);
  level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D = getdvarint("_encstr_8B0A186E8D4EBE134E7D6BC307F5230BB6169D95FA2DB98E95B1", 300);
  level._id_11E18._encstr_871A12230BB516B3ACABCD1D966337DE1DD21B59 = getdvarint("_encstr_815E195F379B10D0BA1978D2FAAFD8B7C2A7FF8B2F82C028C96E61", 1200);
  level._id_11E18._encstr_8B751158EA4F300552D79FBDDF4BC7A0F9C3C3 = getdvarint("_encstr_A21F1F3B5F730998FBBFA0D14B3F2A412F6BFEE489FF1FE132D0BF154AD5F87B4F", 6000);
  level._id_11E18._encstr_8D6A11D66EEEC2A32C9D9D4EB7A1954BCE868E = getdvarint("_encstr_88EF1F6E6CC9BE3127AFD63CC1AFD6BEE6DD851DAFB0D976937BEB34B25AD9348E", 3500);
  level._id_11E18._encstr_83BD1223FEABC723E918BA5258F9DD632166B5B4 = getdvarint("_encstr_BA5B2037C693BE8939FAB5C31CAFADD76E77B01DFA43954BB3343AAFF6CC33375647", 0);
  level._id_11E18._encstr_A9AC0CC87ADFA095233F2F13779A = getdvarfloat("_encstr_A1991A63BE43779EE501226B606714BFDB1CF9FCD84AD7E397786AA2", 40.0);
  level._id_11E18._encstr_82AC0C8433E03913F38B9F8FF31B = getdvarfloat("_encstr_8E991A9B2F78397BCE16D28B1BB087E1D8BF01043F58FE676048EA93", 115.0);
  level._id_11E18._encstr_970E0C574FF33728E2CE1188F3CB = getdvarint("_encstr_B173190FD88B97EA357885F8D747B24F7390BF9BA123E1D27B050A", 350);
  level._id_11E18._encstr_825D0C7823CFBFA81C652B3F80C3 = getdvarint("_encstr_9AED190BBFE8A90BBE66421BABAF1711480F9174AF606FEFEC78CB", 500);
  level._id_11E18._encstr_93AB10AD8DD2AD96E8B0372D6B370EB22C6D = getdvarint("_encstr_81E11E13A7F0B1E3569EAA0383380F79D81BB58111F1468BF3F04379AB0D5F2C", 1);
  level._id_11E18._encstr_8E5B10B5C28DA38D930BA3CA58A31DB0C6B6 = getdvarint("_encstr_BDF3174B1146FF1E182FF5D8494964B76768B3F1791EBF5348", 1);
  level._id_11E18._encstr_8EC50A0F5F389AE4A050AA73 = getdvarint("_encstr_BA85173EBB4E709B8B712DF18B29272842CF41B3A819E79B9D", 100);
  level._id_11E18._encstr_AC9311DF02B5A08D482B57E3B3F76879BB1501 = level._id_11E18._encstr_8EC50A0F5F389AE4A050AA73 * level._id_11E18._encstr_8EC50A0F5F389AE4A050AA73;
  level._id_11E18._encstr_A1210E290BD2F050B68F93C9759F2836 = getdvarint("_encstr_BD7F1AAB1EBA31FEF3A73B1933093D8041B55381070279274A5F1315", 1);
  level._id_11E18._encstr_8E0C0A947EB2FB736C97A828 = getdvarint("_encstr_AAF91772C138F782A627276B61D81A3F58686DF17BA0919B75", 5);
  level._id_11E18._encstr_9A4916270511F3EFFB88328A80CD253B2865A0DD13792373 = getdvarint("_encstr_A1242460CA62BF49C34FA123584FD1F74B72E0B8C2BB07E1478A3E9032E3D92FB49AA030AA53", 500);
  level._id_11E18._encstr_931D180362326B51B84ADA4F8D10C76345BD165F47B7931F50A8 = getdvarint("_encstr_86032637E0B35F22EDA04D1E1F8F7B171B68CB13E808E77A33C115FA05BD22F1C03167AFB8211CC2", 6);
  level._id_11E18._encstr_9588100FB40DA87A5B3253788B27A5C02303 = getdvarint("_encstr_82F01EC337DDB97D63E9C878C8B6FCC86A38C28259F32A0F15F9DB68AAF803AF", 6000);

  if(level._id_11E18.wait_for_player_gulag_respawn < level._id_11E18.wait_for_player_in_gas)
    level._id_11E18.wait_for_player_gulag_respawn = level._id_11E18.wait_for_player_in_gas + 1;

  level._id_11E18._encstr_AD1507DAD2466395B9 = ["_encstr_B4891D7FD9AF7AD859F0CF1568E01872F89BAB9BD3A8D292E099839C86D209", "_encstr_A983215069F9776901522725C7FB78DF710BE7D04F971287E8120B63C7D33569780277", "_encstr_A17B1C70AF392BFB876BB53877EF20FB91C24010D24141910786C5B8308E", "_encstr_85291FB90D7D5B38EB6D2BCDBD9BD058FAD246632BF5D673EAD8ADB1CACDBE8162", "_encstr_8A291FB90DD7AD0EAFADACE6BDDC860BF55A918D56D75B9BD5D8B6B1CADCAF0C46"];
  level._id_11E18._encstr_BE7707A750581422D6 = ["_encstr_B4B11E3743BEADC1BECEE459ACDC262C97FAA5C863AC7D26C9CA16E81ABE8162", "_encstr_833E221A2B771D6FA9A23D2DE7CB6ABF3ABFB4FAC0DD778C7F0D8048637065F5EC50DF47", "_encstr_9A231DB9D0AFD683EBB3C9AC56731385F2AFA5191BACFAA30BEA378EFA0698"];
}

teleportplayertoselection() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD9B129DEBA5E61B7BB55A9BECBE0B8EA316D8B5"] = "_encstr_A17A1BD0CBB73B387361BBA07387A0E19A13F058924C17915F9C4B2C55";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8A31960C9FC734AE0B867F6494989D3C8DF63EBD72379F160B1B3"] = "_encstr_9273226280DB57B3494F81AF52F063DD5F08BBDA70BF81C7412D699E7D5E5B65A3887223";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1C70E5CAF777B11A63250E94BFAFBB1"] = "_encstr_A2391C402A7227ED9B4321F05FB6986FCA59C5D607B9F76B756F90D837E1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B6112ADF5B473C6DE5BA53776BE853A472CD8AD"] = "_encstr_8E3B1AC7759570BEA3EA1E80726BF958ABDA534B13B1588EFB823349";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95BF19B6EB4BDC36EDB596CDECF516E847161BB5EBC1B1165E56E4"] = "_encstr_879421B52BDCBDCDD00BEB6DD2C6B1E63A4E562CB57D168DD1D2CE95D7C1C60BF2ACC9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D2E0E6B993FBD63695FAF5F4B171533"] = "_encstr_86191B7BCD34ADB7E6D0EBC8B2EC4B8D2BF5BA9BCAD7B5CACDF6DCD0C2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF2D105F6F4A6B95FBA6F37B8E38DF4468DF"] = "_encstr_911017E755B5509E830AFE83922B5F9001A1656FF7DD3868D7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C1119C33690B6E2781367037F088AE42059BE8CAEB04C1A4B2B03"] = "_encstr_B2EE18C3C86926C39EDA010C612393AAE310BA09E01FDB175335";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDF5174B114617DEE02FFCC545F8665F78C9C213BB93F31740"] = "_encstr_8B2B10307B5487B89708C8DF1B47234B3AE2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABEC1C7358A567BF98804C452C208FAF57D0FAABAB4B1AE7D1E8547D4689"] = "_encstr_8CEA1407ABCC8878074256FBFA7F2718672FA99B33F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93FE1D7A58E37DC7F6AE737A4DD95F0919E8D332884BB9DF29976D69DE6123"] = "_encstr_B827175238714427FBBBD7E1C643B70CAD106AE92025BF6792";
}

toggle_ai_settings() {
  level._id_11E18.notetracks = [];
  var_0 = [];
  var_0 = ["_encstr_B80A13548560706044B6CF724803C79BA76F845EDA", "_encstr_AB960B480BABE9B637E2DF6938"];
  level._id_11E18.notetracks["_encstr_A17B1C70AF392BFB876BB53877EF20FB91C24010D24141910786C5B8308E"] = var_0;
  level._id_11E18.notetracks["_encstr_AFF71BE353786FC2193F9596DF900CA780100A9AC1D01BFE2807B7307B"] = var_0;
  var_0 = ["_encstr_B80A13548560706044B6CF724803C79BA76F845EDA", "_encstr_AB960B480BABE9B637E2DF6938", "_encstr_A69D0B6C43DCF11577DF4D3F3B"];
  level._id_11E18.notetracks["_encstr_85291FB90D7D5B38EB6D2BCDBD9BD058FAD246632BF5D673EAD8ADB1CACDBE8162"] = var_0;
  var_0 = ["_encstr_968F12ADACB9DBE60D58AFD9271626D74EB7C6D6", "_encstr_B18C13528D53ED17ECEAF9A89282F7DB3F22E8DEEB"];
  level._id_11E18.notetracks["_encstr_AD451DAB82FE4B3F07E3B3AA3A1E80FFE6C0C7FF4F174F7B133B48EF2830B3"] = var_0;
  level._id_11E18.notetracks["_encstr_84451DE7D2F1B1884FCCB1E8F54B43FFA9BBA76F57590F709CA679409150EA"] = var_0;
  var_0 = ["_encstr_927E15A375087F6269B859D2084FDBC3E1F0202F95D09B"];
  level._id_11E18.notetracks["_encstr_A1831EAB81012D736FA8DFF2F7FB28AE3F3E53E7D017193983CBFFC1D20F7262"] = var_0;
  var_0 = ["_encstr_B80A13548560706044B6CF724803C79BA76F845EDA"];
  level._id_11E18.notetracks["_encstr_84662182612EFD1AC877EDC5DA68804F19487B31D007E723E9EFCB6249771C616702D9"] = var_0;
  var_0 = ["_encstr_B80A13548560706044B6CF724803C79BA76F845EDA", "_encstr_A69D0B6C43DCF11577DF4D3F3B"];
  level._id_11E18.notetracks["_encstr_85931F5A9D375AE07EC03713C8D3A0C25F562356258F522CE388171F31685F1F5B"] = var_0;
  level._id_11E18.notetracks["_encstr_8A291FB90DD7AD0EAFADACE6BDDC860BF55A918D56D75B9BD5D8B6B1CADCAF0C46"] = var_0;
  var_0 = ["_encstr_A69D0B6C43DCF11577DF4D3F3B", "_encstr_AB960B480BABE9B637E2DF6938"];
  level._id_11E18.notetracks["_encstr_9BBA1C1B019135B3D810D26A78260BEE3905959DE1E9FAEBFF2B3B61AB5F"] = var_0;
  var_0 = ["_encstr_8DB40E6279E06702A02BAF8BE9704DE3"];
  level._id_11E18.notetracks["_encstr_A79E221BE2BF608B5E2F62404D9F686BB9ED824F97F27DBF0B529E5FEC1D0B37BA2F60DE"] = var_0;
  var_0 = ["_encstr_ADBD12E0CDE04FF344A9E618F2E279C9A0373611"];
  level._id_11E18.notetracks["_encstr_81401CBF6C81387737F291F8DAEF230B299A0B0BB0799BBDCF8A4BC6173E"] = var_0;
  var_0 = ["_encstr_A69D0B6C43DCF11577DF4D3F3B"];
  level._id_11E18.notetracks["_encstr_965F1FE643AF6BE0D7DAB237BDCD8685AF9BDD85E8FA581DA3B08DDABE9CFA81C4"] = var_0;
  level._id_11E18.notetracks["_encstr_A983215069F9776901522725C7FB78DF710BE7D04F971287E8120B63C7D33569780277"] = var_0;
  level._id_11E18.notetracks["_encstr_97AD18FFA398E3E1976408BAE2AF294AD1C3CBD6C8317906CB53"] = var_0;
  level._id_11E18.notetracks["_encstr_9AAD18E686F5D6C1FAB6CA9BB7E60D0BAFA3BA39E6D7B1F57260"] = var_0;
  level._id_11E18.notetracks["_encstr_B2EE19B3223F25BB9EDA0D0EE023E36E97B85BDB9867DDCFBB1E45"] = var_0;
  level._id_11E18.notetracks["_encstr_93EE19670A46DDB3070A9F5560076A99EEB0F7FB30BE0489F3BBB2"] = var_0;
  level._id_11E18.notetracks["_encstr_B69B18CD68F5D607FAD6B2E67BCDA116BE4757C9DC7D27EB0D4D"] = var_0;
  level._id_11E18.notetracks["_encstr_9A9B181FC99195B1397A4DE595277A708FA3CD6090972249C262"] = var_0;
  level._id_11E18.notetracks["_encstr_ABEA1973E2FF65FBDE9A4D4EA063A3AE57789B9BD8271A0F7BDE05"] = var_0;
  level._id_11E18.notetracks["_encstr_AFEA1983F5065FFA5F80822AB85FB4277EBD0D1A60AEFBC96B32DF"] = var_0;
  level._id_11E18.notetracks["_encstr_A7C1175FD3A8D053F7CA986868A0D6E9A0819F1463BDB937CA"] = var_0;
  level._id_11E18.notetracks["_encstr_A50B16B9D0F55B0EF5CE93ACAC9B4CB0CBFA2BB6594EECCA"] = var_0;
  level._id_11E18.notetracks["_encstr_86EF196FC9304AE869611A27D9180242FB87FBCFEDC011BC4123C3"] = var_0;
  level._id_11E18.notetracks["_encstr_BEEF19EBF161C563084193EA69F853BE38BF6455D53081DBD0B2AF"] = var_0;
  level._id_11E18.notetracks["_encstr_A69C1A6BEDF7FD92778F4E3F6F1821362BF6FB8B9B58699A17A3D3C3"] = var_0;
  level._id_11E18.notetracks["_encstr_A29C1A37A1F55B1CF5763956599B890BE5AFA35D9373EBC6BE4C1C81"] = var_0;
  level._id_11E18.notetracks["_encstr_87A719D7BAF64D23979CAA67F58D7A095A794377200887CBBF0D63"] = var_0;
  level._id_11E18.notetracks["_encstr_ADA7199B68AF6B07F5ECE4B2593798855E7DE8EAC9DCF5E4D793C0"] = var_0;
  level._id_11E18.notetracks["_encstr_A9371A4BA2C9084BE907C307AD0398093F889B331305F963596EA627"] = var_0;
  level._id_11E18.notetracks["_encstr_96371ABEFF183D2FEE899DFAD51B71BF2B994320BB7D71B5A0AF903F"] = var_0;
  level._id_11E18.notetracks["_encstr_A73C1C5FF9205AF87991EA37C92832528B97C78F215221AC805963B14BBA"] = var_0;
  level._id_11E18.notetracks["_encstr_8DB81DE353786FC21927829DCB788EA793D63B4AE0CAEF3AF01F8074A7B202"] = var_0;
  level._id_11E18.notetracks["_encstr_A7E21792B54FD0ABEFA7761345FE1A8BCB11B040A0076082EA"] = var_0;
  level._id_11E18.notetracks["_encstr_B8DD1C037A667552DF57BB02D74D90C1B0D84FB02C64EFFFDBB7B1F7BBF7"] = var_0;
  level._id_11E18.notetracks["_encstr_833E221A2B771D6FA9A23D2DE7CB6ABF3ABFB4FAC0DD778C7F0D8048637065F5EC50DF47"] = var_0;
  var_0 = ["_encstr_AB960B480BABE9B637E2DF6938"];
  level._id_11E18.notetracks["_encstr_9A231DB9D0AFD683EBB3C9AC56731385F2AFA5191BACFAA30BEA378EFA0698"] = var_0;
  var_0 = ["_encstr_B8E4141FFE039ABE99D0079750D161D29F966516E6A1"];
  level._id_11E18.notetracks["_encstr_8F781D4EFB012BE3B77F48F85FAEF96B0B5945DF048A874B7D7F7888CFA85B"] = var_0;
  level._id_11E18.notetracks["_encstr_B2CC1CAF7A2958E8504F35DDBFA0BA6E8FF00CE8D8E51FD12FCBE8F71A06"] = var_0;
}

toggleusbstickinhand() {
  waittillframeend;
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  thread _id_135FF();
  thread _encstr_B2B60948DAB8D21F24CB4B();
}

zombieregendelayscaleingas() {
  level._effect["_encstr_AC7B0E48BB15C1B54206EBE0DE6AF388"] = loadfx("_encstr_84924103509195FFBB5317220EC887CAD1F00A9AB277FE27D15F3C59A3E05F976DB08213384F7353AAD03A429E362F1E9BE0094AB0AB2BCBE12B3F4A5D99CFB5EDF003");
}

_encstr_B2B60948DAB8D21F24CB4B() {
  if(getdvarint("_encstr_975D167BE76D3F6D53AF68F8F9B9DDBD41B0AAD1AE9119E8", 1)) {
    scripts\engine\scriptable::_id_12F5B("_encstr_ADA80E87105EA1E5971B6833E2BF28B0", ::_encstr_97101E4B17713E08E9CFB30BF4C8A87D3A3B1FCFD3BA07F009E618019B93D025);
    var_0 = getentitylessscriptablearrayinradius("_encstr_A39F0B18EFD69808834F6F1377", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(getdvarint("_encstr_842923E6D839D73193AFB5C383AFACCAAF772CD28EEB667B9CFA6B588E6C1AAF9BD185C947", 1)) {
      foreach(var_2 in var_0)
      var_2 setscriptablepartstate("_encstr_ADA80E87105EA1E5971B6833E2BF28B0", "_encstr_BA19049F4B2D");

      scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
    }

    foreach(var_2 in var_0)
    var_2 setscriptablepartstate("_encstr_ADA80E87105EA1E5971B6833E2BF28B0", "_encstr_AB0703DBB9");
  }
}

_id_135FF() {
  if(level.agentarray.size < 2)
    level waittill("_encstr_B43D134691384702BCC3BB2B17489BBF3959FECD29");

  var_0 = getdvarint("_encstr_A31414DBF60BE1E20E6FC138209912602D92FFC8B34B", 0);

  if(var_0 == 2) {
    set_mission_ai_cap((13496.2, 11587, 8766.97), (0, 156.672, 0));
    level._id_11E18.setjailtimeouthud = level._id_11E18.setincomingremovedcallback;
    level._id_11E18.setincomingremovedcallback = undefined;
    set_mission_ai_cap((-16837.6, -16622, 888.125), (0, -128.981, 0));
    waitandstartscorepolling((11761, 12636, 8528), (0, -22, 0));
    level._id_11E18.wait_for_one_player_near_point = level._id_11E18.wait_for_next_hack_complete;
    level._id_11E18.wait_for_next_hack_complete = undefined;
    waitandstartscorepolling((-18417.4, -18107.9, 888.125), (0, 488.342, 0));
  } else {
    thread set_omnvar_for_icon();
    thread waitfor_trigger_near_obit();
  }

  thread _id_13E32();
}

testing() {
  level._id_11E18.seq3_tanksettings = [];
  level._id_11E18.seq3_tanksettings = [players_in_correct_volume((-1300, 60000, -640)), players_in_correct_volume((25600, 62360, -640)), players_in_correct_volume((49100, 52054, -640)), players_in_correct_volume((58000, 23000, -640)), players_in_correct_volume((50500, -9000, -640)), players_in_correct_volume((49270, -47613, -640)), players_in_correct_volume((16640, -61500, -640)), players_in_correct_volume((-18560, -55888, -640)), players_in_correct_volume((-35500, -35000, -640)), players_in_correct_volume((-50920, -6128, -640)), players_in_correct_volume((-56870, 15000, -640)), players_in_correct_volume((-34800, 40600, -640))];
}

players_in_correct_volume(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.score_event_civilian_killed = reset_use_think(var_0);
  return var_1;
}

reset_use_think(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_8, var_6 in level._id_11E18.setlethalonunresolvedcollision) {
    var_7 = distance2dsquared(var_6, var_0);

    if(!isDefined(var_2) || var_7 < var_1) {
      var_3 = var_1;
      var_4 = var_2;
      var_1 = var_7;
      var_2 = var_8;
      continue;
    }

    if(!isDefined(var_4) || var_7 < var_3) {
      var_3 = var_7;
      var_4 = var_8;
    }
  }

  var_9 = var_2 - var_4;

  if(abs(var_9) != 1 && abs(var_9) != level._id_11E18.setlethalonunresolvedcollision.size - 1) {}

  if(abs(var_9) == level._id_11E18.setlethalonunresolvedcollision.size - 1)
    var_9 = 0 - var_9;

  return scripts\engine\utility::ter_op(var_9 < 0, var_2, var_4);
}

sappliedstages() {
  var_0 = level._id_11E18.setincomingremovedcallback scripts\engine\utility::array_sort_with_func(getarraykeys(level._id_11E18.seq3_tanksettings), ::post_race);

  if(!isDefined(level.br_circle.dangercircleent)) {
    var_1 = level._id_11E18.seq3_tanksettings[var_0[0]];
    return [var_1.score_event_civilian_killed, var_1.origin];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1 = level._id_11E18.seq3_tanksettings[var_3];

    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_1.origin))
      return [var_1.score_event_civilian_killed, var_1.origin];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1 = level._id_11E18.seq3_tanksettings[var_3];

    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_1.origin))
      return [var_1.score_event_civilian_killed, var_1.origin];
  }

  var_1 = level._id_11E18.seq3_tanksettings[var_0[0]];
  return [var_1.score_event_civilian_killed, var_1.origin];
}

post_race(var_0, var_1) {
  var_2 = level._id_11E18.seq3_tanksettings[var_0].origin;
  var_3 = level._id_11E18.seq3_tanksettings[var_1].origin;
  return distancesquared(var_2, self.origin) < distancesquared(var_3, self.origin);
}

set_mission_ai_cap(var_0, var_1) {
  var_2 = !isDefined(level._id_11E18.setincomingremovedcallback);

  if(var_2) {
    level._id_11E18.setincomingremovedcallback = spawnnewagent("_encstr_8D800929E3570DC82ED15B", "_encstr_82790FBB4FF5DA67BE76C9B259B9268597", var_0, var_1, 3000, 8100, ::postgamehitmarkerwaittime);
    level._id_11E18.setincomingremovedcallback unmarkkeyframedmover(1);
    level._id_11E18.setincomingremovedcallback _id_13E31("_encstr_9A9E175DC8E1E3B9F0B6BB7FDF1AEA70B0621BEFE7533E1FB3", 8100);
    _id_13187(0, level._id_11E18.setincomingremovedcallback getentitynumber());
    level._id_11E18.setincomingremovedcallback.turnrate = 0.01;
    level._id_11E18.setincomingremovedcallback.linked_mover = 0;
    level._id_11E18.setincomingremovedcallback._encstr_A3FD0DA8907982F8A3F40762316F0F = [];
    level._id_11E18.setincomingremovedcallback._encstr_9AF60D31FA87A5801369E53795FB40 = [];
    level._id_11E18.setincomingremovedcallback sethitlocdamagetable("_encstr_8D3E168F64C9E3FB6F9B581BB361734FA28D748DFEB259C1");
    level._id_11E18.setincomingremovedcallback.x1fin_respawn = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    level._id_11E18.setincomingremovedcallback.x1fin_respawn setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level._id_11E18.setincomingremovedcallback.x1fin_respawn unmarkkeyframedmover(1);
    level._id_11E18.setincomingremovedcallback.clear_look_at_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    level._id_11E18.setincomingremovedcallback.clear_look_at_ent setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    level._id_11E18.setincomingremovedcallback.clear_look_at_ent unmarkkeyframedmover(1);
    level._id_11E18.setincomingremovedcallback.clear_look_at_ent linkTo(level._id_11E18.setincomingremovedcallback, "_encstr_8EEB0D29A16741010FFB2B90611343", (0, 0, 0), (0, 90, 0));
    level._id_11E18.setincomingremovedcallback._encstr_853510409B3561A1C2660D157E2AC1A9963B = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    level._id_11E18.setincomingremovedcallback._encstr_853510409B3561A1C2660D157E2AC1A9963B setModel("_encstr_916A14E8B076D7DB392DCE5AE6FAD94E5956CDC416CB");
    level._id_11E18.setincomingremovedcallback._encstr_853510409B3561A1C2660D157E2AC1A9963B unmarkkeyframedmover(1);
    level._id_11E18.setincomingremovedcallback._encstr_853510409B3561A1C2660D157E2AC1A9963B linkTo(level._id_11E18.setincomingremovedcallback, "_encstr_8EEB0D29A16741010FFB2B90611343", (0, 0, 0), (0, 0, 0), 1);

    if(getdvarint("_encstr_AD07206BB0BB81EA23763072A8797CC3595702855F641A89615910C2D0D37E52CF7E", 1))
      level._id_11E18.setincomingremovedcallback thread _encstr_B8111BE2DFD2B8F05C497C993B07A8A3EF0325625F973AA1077061773B();
    else {
      var_3 = level._id_11E18.setincomingremovedcallback _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(3000, 8100, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      level._id_11E18.setincomingremovedcallback._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372 = [var_3];
    }
  } else {
    level._id_11E18.setincomingremovedcallback _id_13E37();
    level._id_11E18.setincomingremovedcallback asmsetstate(level._id_11E18.setincomingremovedcallback.asmname, "_encstr_A7C5056BD931D1");
    level._id_11E18.setincomingremovedcallback.origin = var_0;
    level._id_11E18.setincomingremovedcallback.x1fin_respawn.origin = var_0;
  }

  level._id_11E18.setincomingremovedcallback orientmode("_encstr_85C814B4E90721D14ECB3038E22521D1679E4C3945FF");
  level._id_11E18.setincomingremovedcallback setplayerangles(var_1);
  level._id_11E18.setincomingremovedcallback.x1fin_respawn.angles = var_1;
  return level._id_11E18.setincomingremovedcallback;
}

_encstr_B8111BE2DFD2B8F05C497C993B07A8A3EF0325625F973AA1077061773B() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 agentsetclipmode("_encstr_8DEC06B1E943615B");
  var_1 = 0.1;
  var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1 = [];
  var_2 = getEntArray("_encstr_8E7D13EC9C59CADC3185BC7D6C7B8D8D4B372DB773", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_5 = "_encstr_9B4C023E";
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
    var_8 = var_4.script_noteworthy;

    if(var_8 == "_encstr_81CC0586952C91") {
      var_5 = "_encstr_AADA07DBF19A4A81D7";
      var_6 = (360, 190, 35);
      var_7 = (0, 0, -90);
    } else if(var_8 == "_encstr_AD9B0589ED9197") {
      var_5 = "_encstr_8EEC09159F6238030BFA23";
      var_6 = (-1670, -420, 30);
      var_7 = (0, -41, -90);
    } else {}

    var_9 = spawnStruct();
    var_9._encstr_95540C3EFF23184B87F238985ADB = var_4;
    var_9.tagname = var_5;
    var_9._encstr_B40F0D5FFB3BEA9C25AA8A10D2A799 = var_6;
    var_9.angleoffset = var_7;
    var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1[var_8] = var_9;
  }

  var_11 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(400, 500, "_encstr_AADA07DBF19A4A81D7", 1, (50, -80, -250), (0, 0, 0));
  wait(var_1);
  var_12 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(230, 1100, "_encstr_8D8B0B309FA99B7EFA735F68F1", 1, (100, -80, 10), (0, 100, 100));
  var_13 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(230, 1100, "_encstr_A78B0B4D7DAC6398F6DDEB27A5", 1, (100, -80, 10), (0, 100, 80));
  wait(var_1);
  var_14 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(550, 1900, "_encstr_AC500A7A366A5BBFC04F9465", 1, (-400, -100, -100), (90, 0, -10));
  var_15 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(550, 1900, "_encstr_BD500A3C087F4AD519410B6F", 1, (-400, -100, 100), (90, 0, -10));
  wait(var_1);
  var_16 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(800, 3300, "_encstr_8EEC09159F6238030BFA23", 1, (-3350, -1050, 0), (90, 0, -10));
  var_17 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(800, 4800, "_encstr_8EEC09159F6238030BFA23", 1, (-4000, 550, 0), (90, 0, -5));
  level._id_11E18.setincomingremovedcallback._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372 = [var_11, var_12, var_13, var_14, var_15, var_16, var_17];
  var_0._encstr_A65615C6DB8D63D29B2DDEB9D2CDB4A32D1663D24FB246 = 1;
  var_0 thread _encstr_BE2D153FE21B87D5A9202AA32BC5CEB770D989A30B4023(0);
}

_id_1436F() {
  if(isDefined(level._id_11E18.setincomingremovedcallback.idleanim)) {
    while(getanimlength(level._id_11E18.setincomingremovedcallback.idleanim) == 0)
      waitframe();
  }
}

waitandstartscorepolling(var_0, var_1) {
  if(!isDefined(level._id_11E18.wait_for_next_hack_complete)) {
    level._id_11E18.wait_for_next_hack_complete = spawnnewagent("_encstr_AF6008D2C950D7B230BB", "_encstr_A3271883CB17D1D089339B952FEA68AF6F1238C802BF9EE09F09", var_0, var_1, 850, 3400);
    level._id_11E18.wait_for_next_hack_complete attach("_encstr_BE7B18F362D14543B0CF87B3DF4E6A8129E92DFC3879180AF7F9");
    level._id_11E18.wait_for_next_hack_complete unmarkkeyframedmover(1);
    level._id_11E18.wait_for_next_hack_complete _id_13E31("_encstr_939E164FB05F797A2FBA85212D56BF8B4F1B2158F56BB9EB", 3400);
    _id_13187(1, level._id_11E18.wait_for_next_hack_complete getentitynumber());
    level._id_11E18.wait_for_next_hack_complete.turnrate = 0.01;
    level._id_11E18.wait_for_next_hack_complete._encstr_A3FD0DA8907982F8A3F40762316F0F = [];
    level._id_11E18.wait_for_next_hack_complete._encstr_9AF60D31FA87A5801369E53795FB40 = [];
    level._id_11E18.wait_for_next_hack_complete sethitlocdamagetable("_encstr_8D3E168F64C9E3FB6F9B581BB361734FA28D748DFEB259C1");
    level._id_11E18.wait_for_next_hack_complete.x1fin_respawn = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    level._id_11E18.wait_for_next_hack_complete.x1fin_respawn setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level._id_11E18.wait_for_next_hack_complete.x1fin_respawn unmarkkeyframedmover(1);
    level._id_11E18.wait_for_next_hack_complete _encstr_913112DA0D0B3719B65AD8D8D1E44BECD92B4ECD(1);

    if(getdvarint("_encstr_AD07206BB0BB81EA23763072A8797CC3595702855F641A89615910C2D0D37E52CF7E", 1))
      level._id_11E18.wait_for_next_hack_complete thread _encstr_851A1BAB8B387B88B9EA484AD3452879703321FBCEDF0811D30643FD9E();
    else {
      var_2 = level._id_11E18.wait_for_next_hack_complete _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(850, 3400, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      level._id_11E18.wait_for_next_hack_complete._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372 = [var_2];
    }
  } else {
    level._id_11E18.wait_for_next_hack_complete _id_13E37();
    level._id_11E18.wait_for_next_hack_complete asmsetstate(level._id_11E18.wait_for_next_hack_complete.asmname, "_encstr_A7C5056BD931D1");
    level._id_11E18.wait_for_next_hack_complete.origin = var_0;
    level._id_11E18.wait_for_next_hack_complete.x1fin_respawn.origin = var_0;
  }

  level._id_11E18.wait_for_next_hack_complete.angles = var_1;
  level._id_11E18.wait_for_next_hack_complete.x1fin_respawn.angles = var_1;
  return level._id_11E18.wait_for_next_hack_complete;
}

_encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = scripts\engine\utility::ter_op(istrue(var_3), "_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", "_encstr_956B0F193B6244C0659AE65B464C78857B");
  var_8 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, (0, 0, 0));
  var_9 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, (0, 0, 0));
  var_10 = spawn(var_7, var_6.origin, 0, var_0, var_1);
  var_10.targetname = "_encstr_8A450B087B887CBB4B4739B832";
  var_10.radius = var_0;
  var_10.height = var_1;
  var_10._encstr_B8400B4D439AB560A42F5BE94B = var_6;
  var_10 enablelinkTo();
  var_10 linkTo(var_6, var_2, var_8, var_9);
  var_10 thread _id_13DCE();
  scripts\mp\utility\trigger::makeenterexittrigger(var_10, ::secretstashlootcacheused);
  return var_10;
}

_encstr_BD0D1567D0E0D17299416B3F5F342A0240F99A2B6B6879() {
  self notify("_encstr_AFCB082AC1D6A3EA7B73");
  self delete();
}

_id_14372() {
  if(isDefined(level._id_11E18.wait_for_next_hack_complete.idleanim)) {
    while(getanimlength(level._id_11E18.wait_for_next_hack_complete.idleanim) == 0)
      waitframe();
  }
}

_id_13E32() {
  if(getdvarint("_encstr_AFAD1672C138F782A627276B61D82B3FD00B6F7D39A0935A", 0) == 0) {
    scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
    waittillframeend;
  }

  for(;;) {
    level._id_11E18.setincomingremovedcallback _meth_87BC(gettime() + 10000);
    level._id_11E18.wait_for_next_hack_complete _meth_87BC(gettime() + 10000);
    waitframe();
  }
}

_id_13E31(var_0, var_1) {}

set_omnvar_for_icon() {
  if(getdvarint("_encstr_AFAD1672C138F782A627276B61D82B3FD00B6F7D39A0935A", 0) == 0)
    scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  [var_1, var_2, var_3] = set_recent_spawn_time_threshold_override();
  level._id_11E18.setlastdroppableweaponobj = var_3;
  set_mission_ai_cap(var_1, var_2);
  _id_1436F();
  _encstr_8D8815C95E0BE7103C9038C0F2554F8B7113BB78A7E313();
  set_player_hurt_trigger();
}

set_pitch_roll_for_ground_normal() {
  for(;;) {
    [var_1, var_2, var_3] = set_recent_spawn_time_threshold_override(20);
    level._id_11E18.setlastdroppableweaponobj = var_3;
    set_mission_ai_cap(var_1, var_2);
    wait 1;
    var_4 = level._id_11E18.setincomingremovedcallback;
    set_maze_ai_stealth_settings(0);
    var_4.linked_mover = 0;
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 0;
    set_relic_grounded(var_4, 0);
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 1;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 2;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 3;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 4;
    set_relic_gas_martyr(var_4);
    waitframe();
    set_relic_dogtags(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_dfa(var_4);
    waitframe();
    set_relic_grounded(var_4, 12);
    waitframe();
    level._id_11E18.setlastdroppableweaponobj = 5;
    set_relic_grounded(var_4, 0);
  }
}

set_recent_spawn_time_threshold_override(var_0) {
  [var_2, var_3] = sat_choose_missing_piece();
  var_4 = scripts\engine\utility::ter_op(var_2 + 1 < level._id_11E18.setlethalonunresolvedcollision.size, var_2 + 1, 0);
  var_5 = level._id_11E18.setlethalonunresolvedcollision[var_4];
  var_6 = var_5 - var_3;
  var_7 = vectortoangles(var_6);
  return [var_3, var_7, var_2];
}

sat_choose_missing_piece() {
  var_0 = randomint(level._id_11E18.setlethalonunresolvedcollision.size);
  var_1 = level._id_11E18.setlethalonunresolvedcollision[var_0];
  var_2 = 0;

  if(getdvarint("_encstr_ADC31C13A7F0B1E3569EAA0383383F79A011B79B33F1038FE853B29A680D", 1) > 0 && level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319" && isDefined(level.infilstruct)) {
    var_3 = [];
    var_4 = level.infilstruct.c130pathstruct._id_1386E;
    var_3 = _encstr_AAA51317B021E4A3712F3AB306032AB169F8D387B8(var_3, var_4);

    if(var_3.size == 0) {
      var_4 = level.infilstruct.c130pathstruct.neurotoxin_damage_monitor;
      var_3 = _encstr_AAA51317B021E4A3712F3AB306032AB169F8D387B8(var_3, var_4);
    }

    if(var_3.size > 0) {
      level._id_11E18._encstr_B84B10276B9032C4901BD7DCB0500DDBFDA7 = var_3.size;
      var_5 = randomint(var_3.size);
      var_0 = var_3[var_5];
      var_1 = level._id_11E18.setlethalonunresolvedcollision[var_0];
      return [var_0, var_1];
    }

    var_2 = 1;
  }

  if(getdvarint("_encstr_A2EE19283FC2466D834921B39A89AD882AFF3048676BD805FAAD2D", 0) == 0 || istrue(var_2)) {
    for(var_6 = 0; updateachievementhangtime(var_1) && var_6 < level._id_11E18.setlethalonunresolvedcollision.size; var_6++) {
      var_0 = scripts\engine\utility::ter_op(var_0 + 1 < level._id_11E18.setlethalonunresolvedcollision.size, var_0 + 1, 0);
      var_1 = level._id_11E18.setlethalonunresolvedcollision[var_0];
    }
  }

  return [var_0, var_1];
}

_encstr_AAA51317B021E4A3712F3AB306032AB169F8D387B8(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_BD4F1F7A164D59D2FB41772B50368F01C9BBC2338F8D521D66A307AF688841DA93", 25000.0);
  var_3 = var_2 * var_2;

  foreach(var_7, var_5 in level._id_11E18.setlethalonunresolvedcollision) {
    if(updateachievementhangtime(var_5)) {
      continue;
    }
    var_6 = distance2dsquared(var_5, var_1);

    if(var_6 < var_3)
      var_0[var_0.size] = var_7;
  }

  return var_0;
}

post_safeges_weapon() {
  var_0 = [];
  var_0[var_0.size] = (-6969, -62217, -628);
  var_0[var_0.size] = (35110, -65651, -628);

  if(getdvarint("_encstr_A51D156FF26E7F7ABAF70B8B62D9F2CB6838A9B80BEDA8", 0) == 0) {
    var_0[var_0.size] = (49127, -52078, -628);
    var_0[var_0.size] = (57520, -35449, -628);
    var_0[var_0.size] = (60361, 48474, -628);
    var_0[var_0.size] = (22320, 64983, -628);
    var_0[var_0.size] = (-22917, 64110, -628);
    var_0[var_0.size] = (-34118, 57593, -628);
    var_0[var_0.size] = (-35796, 38018, -628);
    var_0[var_0.size] = (-53281, 23823, -628);
    var_0[var_0.size] = (-53567, 1284, -628);
    var_0[var_0.size] = (-56000, -7500, -628);
    var_0[var_0.size] = (-57800, -19500, -628);
    var_0[var_0.size] = (-28765, -49330, -628);
  }

  level._id_11E18.setlethalonunresolvedcollision = var_0;
  playerzombiesetuphud();
}

playerzombiesetuphud() {
  var_0 = getdvarint("_encstr_A1971763BE43779EE501226B606717BF7810FCEDD8E9F7E2C1", 20000);
  var_1 = [];
  var_1[var_1.size] = level._id_11E18.setlethalonunresolvedcollision[0];

  for(var_2 = 0; var_2 < level._id_11E18.setlethalonunresolvedcollision.size - 1; var_2++) {
    var_3 = var_2;
    var_4 = scripts\engine\utility::ter_op(var_3 + 1 < level._id_11E18.setlethalonunresolvedcollision.size, var_3 + 1, 0);
    var_5 = level._id_11E18.setlethalonunresolvedcollision[var_3];
    var_6 = level._id_11E18.setlethalonunresolvedcollision[var_4];
    var_7 = distance(var_5, var_6);
    var_8 = int(var_7 / var_0);

    if(var_8 > 1) {
      var_9 = var_7 / var_8;
      var_10 = vectorNormalize(var_6 - var_5);

      for(var_11 = 1; var_11 < var_8; var_11++) {
        var_12 = var_5 + var_10 * var_11 * var_9;
        var_1[var_1.size] = var_12;
      }
    }

    var_1[var_1.size] = level._id_11E18.setlethalonunresolvedcollision[var_4];
  }

  level._id_11E18.setlethalonunresolvedcollision = var_1;
}

set_player_hurt_trigger() {
  var_0 = level._id_11E18.setincomingremovedcallback;
  set_maze_ai_stealth_settings(0);
  var_0.chopper_carepackage = undefined;
  set_distances_for_groups(var_0);

  for(;;) {
    if(score_message()) {
      waitframe();
      continue;
    }

    var_1 = sat_computer_think_new();

    if(isDefined(var_0._id_12930) && !sales_discount())
      [[var_0._id_12930]](var_0);
    else if(var_1 == 14 && !sales_discount())
      _encstr_AC410BE8E3CB1B53779C5FC16B(var_0);
    else if(var_1 == 15 && !sales_discount())
      _encstr_85090FA7DF0D22442BAB460D60B8997AE5(var_0);
    else if(isDefined(var_0.vo_one_remain) && !sales_discount()) {
      set_relic_grounded(var_0, 12, 0);
      set_relic_aggressive_melee_params(var_0);
    } else if(var_1 == 12) {
      set_relic_aggressive_melee(var_0);
      set_relic_doubletap(var_0);
    } else if(_encstr_82721067B0307712D1BA4C8594D77B29DB48()) {
      if(score_event_kill(var_0)) {
        set_relic_grounded(var_0, 12, 1);
        set_player_munition_currency(var_0);
      } else
        set_relic_dfa(var_0);
    } else if(var_1 == 6) {} else if(var_1 == 5)
      set_relic_amped(var_0);
    else if(var_1 == 7) {
      set_player_munition_currency(var_0);
      set_relic_bang_and_boom(var_0);
    } else {
      var_2 = _encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0) && !_encstr_8C7A125FB34BBBE239902F0B9831AB42055EE557(var_0);
      set_relic_focus_fire(var_0, var_2);
    }

    waitframe();
  }
}

set_player_munition_currency(var_0) {
  var_1 = sandboxprintlinebold(var_0);
  level._id_11E18.setlastdroppableweaponobj = var_1;

  if(_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0) && _encstr_8C7A125FB34BBBE239902F0B9831AB42055EE557(var_0))
    _encstr_A9AD11497ACD081942630B216FEA53606315B1(var_0, undefined);

  if(sales_discount())
    set_relic_headbullets();
}

set_relic_aggressive_melee(var_0) {
  if(istrue(var_0._encstr_81A10C41271A8088323238403D85)) {
    return;
  }
  if(isDefined(level._id_11E18.score_event_headshot) && !sales_discount()) {
    var_1 = level._id_11E18.setlethalonunresolvedcollision[level._id_11E18.score_event_headshot];

    if(update_volume_flag(var_1)) {
      [var_3, var_4, var_5] = set_minigun_target_loc(var_0, level._id_11E18.score_event_headshot);

      if(isDefined(var_4))
        _encstr_828913D9AB3819161DB2D2733A2BD8B127C21D569B(level._id_11E18.score_event_headshot, var_4);

      level._id_11E18.score_event_headshot = var_4;
    }

    if(isDefined(level._id_11E18.score_event_headshot) && level._id_11E18.setlastdroppableweaponobj != level._id_11E18.score_event_headshot && !score_init(var_0, level._id_11E18.score_event_headshot))
      var_0.linked_mover = !var_0.linked_mover;
  }

  if(!sales_discount()) {
    [var_3, var_4, var_5] = set_minigun_target_loc(var_0);

    if(var_5 || score_event_nuked(var_0)) {
      if(level._id_11E18.setlastdroppableweaponobj == var_4)
        var_4 = undefined;

      _encstr_A9AD11497ACD081942630B216FEA53606315B1(var_0, var_4);
      var_0._encstr_81A10C41271A8088323238403D85 = var_5;

      if(var_3)
        var_0.linked_mover = !var_0.linked_mover;
    }
  }
}

set_distances_for_groups(var_0) {
  var_0.nodeidle = 0;
  var_0._id_11EA7 = 0;
}

set_relic_doubletap(var_0) {
  if(sendendofmatchdata(var_0)) {
    set_distances_for_groups(var_0);

    if(_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0))
      set_maze_ai_stealth_settings(5);
    else
      set_maze_ai_stealth_settings(0);
  } else if(!istrue(var_0._encstr_81A10C41271A8088323238403D85) && _encstr_85A10F0D6C03D58149B3D0B0B774D9316A(var_0)) {
    var_0._encstr_BD020DAC67587F5503C3FBF3E07BCF = gettime() + getdvarint("_encstr_8C9D15D05F05A7183259B861D181163BBB200ED0FE40BF", 40000);
    set_maze_ai_stealth_settings(14);
    waitandstartparachuteoverheadmonitoring(9);
  } else {
    if(istrue(var_0._encstr_81A10C41271A8088323238403D85))
      var_0._id_11EA7 = 0;

    if(var_0 _encstr_91DD158E8D0BB93958CD8C7B6B6DA5D863DCD19CACB0AD() && randomfloat(1.0) <= level._id_11E18.select_bunker_courtyard_spawners)
      set_relic_doubletap_params_internal(var_0);
    else {
      var_0._id_11EA7 = 1;
      set_relic_doubletap_params(var_0);
    }
  }
}

_encstr_A9AD11497ACD081942630B216FEA53606315B1(var_0, var_1) {
  var_0.chopper_carepackage = var_1;
}

_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0) {
  return isDefined(var_0.chopper_carepackage);
}

_encstr_8C7A125FB34BBBE239902F0B9831AB42055EE557(var_0) {
  return var_0.chopper_carepackage == level._id_11E18.setlastdroppableweaponobj;
}

sendendofmatchdata(var_0) {
  if(getdvarint("_encstr_B25518DCD89CD74CC9AFAD3C1CD776F5CCF69CD8CAD7E68E85E5", 0) > 0) {
    set_distances_for_groups(var_0);
    return 0;
  }

  if(sales_discount())
    return 1;
  else if(istrue(var_0._encstr_81A10C41271A8088323238403D85))
    return _encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0);
  else if(_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0))
    return 1;
  else if(score_event_nuked(var_0))
    return 0;
  else if(_encstr_85A10F0D6C03D58149B3D0B0B774D9316A(var_0))
    return 0;
  else if(score_event_fob_cleared() && !positioncheck(var_0))
    return 1;
  else if(!score_event_fob_cleared() && (var_0.nodeidle || var_0._id_11EA7))
    return 1;

  return 0;
}

send_wave_spawns_to_roof(var_0) {
  if(score_event_fob_cleared() && positioncheck(var_0)) {
    var_1 = sandbox_safe_area();

    if(isDefined(var_1))
      return 1;
  }

  return 0;
}

positioncheck(var_0) {
  if(score_event_fob_cleared())
    return level._id_11E18.score_event_headshot == level._id_11E18.setlastdroppableweaponobj;

  return 0;
}

score_event_fob_cleared() {
  if(isDefined(level._id_11E18.score_event_headshot))
    return 1;

  return 0;
}

_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_0) {
  return isDefined(var_0) && isDefined(var_0.trial_flares) && isDefined(var_0.trial_flares.type) && isDefined(var_0.trial_flares.index) && isDefined(var_0.trial_flares.expiretime);
}

sandbox_safe_area() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_1) && var_1.trial_flares.type == "_encstr_A74C0277" && var_1.trial_flares.index == level._id_11E18.setlastdroppableweaponobj && gettime() >= var_1.trial_flares.expiretime)
      return var_1;
  }
}

sandbox_safe_area_count() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_1) && var_1.trial_flares.type == "_encstr_A74C0277" && var_1.trial_flares.index == level._id_11E18.setlastdroppableweaponobj)
      return var_1;
  }
}

_encstr_828913D9AB3819161DB2D2733A2BD8B127C21D569B(var_0, var_1) {
  foreach(var_3 in level.train_hurt_damage_watcher) {
    if(_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_3) && var_3.trial_flares.type == "_encstr_A74C0277" && var_3.trial_flares.index == var_0)
      var_3.trial_flares.index = var_1;
  }
}

score_event_nuked(var_0) {
  if(update_volume_flag(var_0.origin) && !_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0))
    return 1;

  if(_encstr_A1711247AB73AFCDFD40E28A503706778B06C4FD(var_0)) {
    if(istrue(var_0._encstr_81A10C41271A8088323238403D85))
      return 0;
    else if(_encstr_8C7A125FB34BBBE239902F0B9831AB42055EE557(var_0))
      return 0;

    var_1 = level._id_11E18.setlethalonunresolvedcollision[var_0.chopper_carepackage];

    if(update_volume_flag(var_1))
      return 1;

    if(!score_event_turret_killed(var_0))
      return 1;
  }

  return 0;
}

score_event_turret_killed(var_0) {
  return score_init(var_0, var_0.chopper_carepackage);
}

score_init(var_0, var_1) {
  var_2 = level._id_11E18.setlastdroppableweaponobj - var_1;

  if(abs(var_2) > 0) {
    var_3 = 0;
    var_4 = 0;

    if(var_2 > 0) {
      var_3 = var_2;
      var_4 = level._id_11E18.setlethalonunresolvedcollision.size - level._id_11E18.setlastdroppableweaponobj + var_1;
    } else {
      var_4 = 0 - var_2;
      var_3 = level._id_11E18.setlethalonunresolvedcollision.size - var_1 + level._id_11E18.setlastdroppableweaponobj;
    }

    if(var_3 < var_4 && var_0.linked_mover)
      return 1;
    else if(var_4 < var_3 && !var_0.linked_mover)
      return 1;
  }

  return 0;
}

set_minigun_target_loc(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level._id_11E18.setlastdroppableweaponobj;

  var_2 = var_1;
  var_3 = var_1;

  for(var_4 = 0; var_4 < level._id_11E18.setlethalonunresolvedcollision.size; var_4++) {
    var_2 = sandboxprintlinebold(var_0, var_2);
    var_5 = level._id_11E18.setlethalonunresolvedcollision[var_2];

    if(!update_volume_flag(var_5))
      return [0, var_2, 0];

    var_3 = sandboxprintlineboldwait(var_0, var_3);
    var_6 = level._id_11E18.setlethalonunresolvedcollision[var_3];

    if(!update_volume_flag(var_6))
      return [1, var_3, 0];
  }

  var_7 = undefined;
  var_8 = 0;

  if(isDefined(level._id_11BCE) && isDefined(level._id_11BCE._id_12E2C)) {
    var_7 = level._id_11BCE._id_12E2C.score_event_civilian_killed;

    if(var_7 == var_1)
      var_7 = var_1;
    else {
      var_2 = var_1;
      var_3 = var_1;

      for(var_4 = 0; var_4 < level._id_11E18.setlethalonunresolvedcollision.size; var_4++) {
        var_2 = sandboxprintlinebold(var_0, var_2);
        var_5 = level._id_11E18.setlethalonunresolvedcollision[var_2];

        if(var_2 == var_7) {
          break;
        }

        var_3 = sandboxprintlineboldwait(var_0, var_3);

        if(var_3 == var_7) {
          var_8 = 1;
          break;
        }
      }
    }
  }

  return [var_8, var_7, 1];
}

set_maze_ai_stealth_settings(var_0) {
  level._id_11E18.setincomingremovedcallback.state = var_0;
}

sat_computer_think_new() {
  return level._id_11E18.setincomingremovedcallback.state;
}

_encstr_85B20DEF18405EDA15EBD7C3CBC5A2() {
  var_0 = sat_computer_think_new();
  return var_0 == 0 || var_0 == 12;
}

score_event_enemy_killed() {
  return sat_computer_think_new() == 9;
}

_encstr_82721067B0307712D1BA4C8594D77B29DB48() {
  var_0 = sat_computer_think_new();
  return var_0 == 2 || var_0 == 3;
}

sandbox_combat_area_bits(var_0) {
  var_1 = sandboxprintlinebold(var_0);
  var_2 = level._id_11E18.setlethalonunresolvedcollision[var_1];
  var_3 = distance2d(var_2, var_0.origin);
  return var_3;
}

_encstr_A7E40DB808880362B5FD3327D04108(var_0) {
  var_0 notify("_encstr_8D220D62F8A7ABC9B8C15F48A1604F");
  var_0 endon("_encstr_8D220D62F8A7ABC9B8C15F48A1604F");
  var_0 endon("_encstr_BA5B1077C263D67DB1CB8D6359AF91DBCD56");

  for(;;) {
    if(score_event_kill(var_0)) {
      var_0 notify("_encstr_A3130D9AF069D2310E87C1D9C03A82");
      set_relic_grounded(var_0, 12, 1);
      set_player_munition_currency(var_0);
      return;
    }

    waitframe();
  }
}

score_event_kill(var_0) {
  var_1 = 100;
  var_2 = sandboxprintlinebold(var_0);
  var_3 = level._id_11E18.setlethalonunresolvedcollision[var_2];
  var_4 = distance2d(var_0.origin, var_3);

  if(var_4 <= level._id_11E18._encstr_8EC50A0F5F389AE4A050AA73)
    return 1;

  var_5 = level._id_11E18.setlethalonunresolvedcollision[level._id_11E18.setlastdroppableweaponobj];
  var_6 = var_3 - var_5;
  var_7 = var_3 - var_0.origin;
  var_8 = vectordot(var_6, var_7);
  return var_8 <= 0;
}

set_relic_doubletap_params_internal(var_0) {
  var_1 = _encstr_8210145BECC039CA45C0A3D9B87831332402638F185B(var_0);

  if(!isDefined(var_1)) {
    if(send_wave_spawns_to_roof(var_0))
      var_1 = sandbox_safe_area();

    if(!isDefined(var_1))
      var_1 = var_0 _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::pristinestatehealthadd(level._id_11E18.wait_for_player_to_getup, level._id_11E18.wait_for_players_init_puzzle);
  } else
    _encstr_AA7B13CD55959F3F1B0F6910D71DC3D39A532F3A53(var_0, var_1);

  if(isDefined(var_1)) {
    var_2 = _encstr_B88318482E73873759423B8DA7AB2B12C2EF70AA6EF2C54CF096(var_1.origin, level._id_11E18._encstr_91B717B3E65B0B1B1B5B96B1366E8E27ACC2DA932C915AD5DC);
    var_3 = vectortoangles(var_2 - var_0.origin);
  } else {
    var_4 = sandboxprintlinebold(var_0);
    var_5 = level._id_11E18.setlethalonunresolvedcollision[var_4];
    var_2 = var_5 + (0, 0, 12000);
    var_6 = var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7");
    var_7 = var_2 - var_6;
    var_3 = vectortoangles(var_7);
  }

  var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_2);
  var_9 = level._id_11E18._encstr_9A4916270511F3EFFB88328A80CD253B2865A0DD13792373 < var_2[2] - var_8[2];

  if(var_9)
    _getrandomlocations::_encstr_9AA1164FAB6FF3856E370B53AB0B8AD0AD02DBBBCF4F3D4B(var_2, var_3, level._id_11E18._encstr_91B717B3E65B0B1B1B5B96B1366E8E27ACC2DA932C915AD5DC);
  else
    _getrandomlocations::serverroomdogtagrevive(var_8, var_3, level._id_11E18._encstr_91B717B3E65B0B1B1B5B96B1366E8E27ACC2DA932C915AD5DC);

  var_0._id_11EA7 = 1;
}

_encstr_B88318482E73873759423B8DA7AB2B12C2EF70AA6EF2C54CF096(var_0, var_1) {
  var_2 = randomfloat(var_1 * 0.8);
  var_3 = randomfloatrange(-180.0, 180.0);
  var_4 = (0, var_3, 0);
  var_5 = anglesToForward(var_4);
  return var_0 + var_5 * var_2;
}

set_pressure_stability_reading(var_0, var_1) {
  var_2 = vectortoangles(var_1.origin - var_0.origin);
  var_3 = _getrandomlocations::serverroomdogtagrevive(var_1.origin, var_2);
}

update_volume_flag(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  return !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_0);
}

updateachievementhangtime(var_0) {
  return !updaterespawnstatus(var_0);
}

updaterespawnstatus(var_0) {
  var_1 = relic_steelballs_stump_monitor();
  var_2 = float(relic_team_proximity_monitor());
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2)
    return 1;

  return 0;
}

relic_steelballs_stump_monitor() {
  return level.br_level.default_class_chosen[1];
}

relic_team_proximity_monitor() {
  return level.br_level.br_circleradii[1];
}

set_relic_dogtags(var_0) {
  set_relic_gas_martyr(var_0);
  set_maze_ai_stealth_settings(1);
  var_0 _id_13C1D("_encstr_8EBD1D370DEBD6C1F53B39B25937268597F5EE168DB57DCDD18593E87D0389");
  set_maze_ai_stealth_settings(2);
}

set_relic_dfa(var_0, var_1) {
  var_0 endon("_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_0 endon("_encstr_A55911EC7BB0B1FAD29B3A95C94E570EA3AC8C");
  thread _encstr_A7E40DB808880362B5FD3327D04108(var_0);
  var_2 = sat_computer_think_new();
  var_3 = 1;

  if(var_2 == 2) {
    if(scripts\engine\utility::cointoss() || istrue(var_1))
      var_0 _id_13C1D("_encstr_A7E21792B54FD0ABEFA7761345FE1A8BCB11B040A0076082EA");
    else {
      set_maze_ai_stealth_settings(3);

      if(var_0.linked_mover)
        var_0 _id_13C1D("_encstr_8DB81DE353786FC21927829DCB788EA793D63B4AE0CAEF3AF01F8074A7B202");
      else
        var_0 _id_13C1D("_encstr_A73C1C5FF9205AF87991EA37C92832528B97C78F215221AC805963B14BBA");

      var_3 = 0;
    }
  } else {
    set_maze_ai_stealth_settings(2);
    var_0 _id_13C1D("_encstr_A7E21792B54FD0ABEFA7761345FE1A8BCB11B040A0076082EA");
  }

  var_0 notify("_encstr_BA5B1077C263D67DB1CB8D6359AF91DBCD56");
}

set_relic_doomslayer(var_0) {
  var_0 notify("_encstr_8D220D62F8A7ABC9B8C15F48A1604F");
  var_0 _id_13C1D("_encstr_B8DD1C037A667552DF57BB02D74D90C1B0D84FB02C64EFFFDBB7B1F7BBF7");
}

set_relic_amped(var_0) {
  set_relic_gas_martyr(var_0);
  set_maze_ai_stealth_settings(5);
  var_0 _id_13C1D("_encstr_A7C1175FD3A8D053F7CA986868A0D6E9A0819F1463BDB937CA");
  set_maze_ai_stealth_settings(6);
  var_0 _id_13C1C("_encstr_927A179731F88220B1A9A26F81507A1A434F2F0F131969B8FA");
  var_1 = sandboxprintlinebold(var_0);
  var_2 = level._id_11E18.setlethalonunresolvedcollision[var_1];
  thread _encstr_A272173BB91D2CD1AC5BF63B593ADB93DEDBD16BDB47B4B7E6(var_0, var_2);
}

set_relic_bang_and_boom(var_0) {
  level notify("_encstr_95DC0FE9D27C0B35422FFFC5A749F71814");
  var_0 _id_13E37();
  var_0 _id_13C1D("_encstr_A50B16B9D0F55B0EF5CE93ACAC9B4CB0CBFA2BB6594EECCA");
  set_maze_ai_stealth_settings(12);
}

_encstr_A272173BB91D2CD1AC5BF63B593ADB93DEDBD16BDB47B4B7E6(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = distance(var_0.origin, var_1);
  var_4 = var_3 / getdvarint("_encstr_A6A0136B46DACF16C36FC14B3B8081B92E13BF8AFA", 3000);
  var_0 _id_13BA1();
  var_0.x1fin_respawn moveTo(var_1, var_4);
  wait(var_4);
  set_maze_ai_stealth_settings(7);
}

set_relic_focus_fire(var_0, var_1) {
  if(scripts\engine\utility::cointoss() || istrue(var_1))
    set_relic_amped(var_0);
  else
    set_relic_dogtags(var_0);
}

set_relic_grounded(var_0, var_1, var_2) {
  if(_encstr_82721067B0307712D1BA4C8594D77B29DB48())
    set_relic_doomslayer(var_0);
  else if(sat_computer_think_new() == 6)
    set_relic_bang_and_boom(var_0);

  set_maze_ai_stealth_settings(var_1);
}

sat_activate(var_0, var_1) {
  var_2 = 22.5;
  var_3 = 67.5;
  var_4 = 112.5;
  var_5 = 157.5;
  var_6 = abs(var_1);
  var_7 = scripts\engine\utility::sign(var_1) < 0;

  if(var_6 <= var_2)
    return ["_encstr_B40101", 3, 0];
  else if(var_6 < var_3) {
    if(var_7)
      return ["_encstr_87A719D7BAF64D23979CAA67F58D7A095A794377200887CBBF0D63", 2, 45];
    else
      return ["_encstr_86EF196FC9304AE869611A27D9180242FB87FBCFEDC011BC4123C3", 2, 45];
  } else if(var_6 < var_4) {
    if(var_7)
      return ["_encstr_ADA7199B68AF6B07F5ECE4B2593798855E7DE8EAC9DCF5E4D793C0", 3, 90];
    else
      return ["_encstr_BEEF19EBF161C563084193EA69F853BE38BF6455D53081DBD0B2AF", 3, 90];
  } else if(var_6 < var_5) {
    if(var_7)
      return ["_encstr_A9371A4BA2C9084BE907C307AD0398093F889B331305F963596EA627", 4.5, 135];
    else
      return ["_encstr_A69C1A6BEDF7FD92778F4E3F6F1821362BF6FB8B9B58699A17A3D3C3", 4.5, 135];
  } else if(var_7)
    return ["_encstr_96371ABEFF183D2FEE899DFAD51B71BF2B994320BB7D71B5A0AF903F", 5, 180];
  else
    return ["_encstr_A29C1A37A1F55B1CF5763956599B890BE5AFA35D9373EBC6BE4C1C81", 5, 180];
}

set_relic_gas_martyr(var_0) {
  var_1 = var_0.origin;
  var_2 = sandboxprintlinebold(var_0);
  var_3 = level._id_11E18.setlethalonunresolvedcollision[var_2];
  var_4 = var_3 - var_1;
  var_5 = vectortoangles(var_4);
  var_6 = angleclamp180(var_5[1]);
  set_maze_ai_stealth_settings(13);
  set_relic_explodedmg(var_0, var_6, var_3);
}

_encstr_AB5314ECD92B1D73CAF047969B9159F0EDE4A59D4BDC() {
  var_0 = sandboxprintlinebold(level._id_11E18.setincomingremovedcallback);

  if(!isDefined(var_0))
    var_0 = level._id_11E18.setlastdroppableweaponobj;

  var_1 = level._id_11E18.setlethalonunresolvedcollision[var_0];
  return [var_0, var_1];
}

sandboxprintlinebold(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level._id_11E18.setlastdroppableweaponobj;

  if(!var_0.linked_mover)
    return scripts\engine\utility::ter_op(var_1 + 1 < level._id_11E18.setlethalonunresolvedcollision.size, var_1 + 1, 0);
  else
    return scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level._id_11E18.setlethalonunresolvedcollision.size - 1);
}

sandboxprintlineboldwait(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level._id_11E18.setlastdroppableweaponobj;

  if(!var_0.linked_mover)
    return scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level._id_11E18.setlethalonunresolvedcollision.size - 1);
  else
    return scripts\engine\utility::ter_op(var_1 + 1 < level._id_11E18.setlethalonunresolvedcollision.size, var_1 + 1, 0);
}

set_relic_explodedmg(var_0, var_1, var_2) {
  var_3 = var_0.angles;
  var_4 = angleclamp180(var_3[1]);
  var_5 = angleclamp180(var_1 - var_4);
  [var_7, var_8, var_9] = sat_activate(var_0, var_5);

  if(var_7 != "_encstr_B40101")
    var_0 _id_13C1D(var_7);

  var_10 = (0, var_1, 0);
  var_0 orientmode("_encstr_978B0B4A20EF7FA213A07966C5", var_2);
}

set_relic_aggressive_melee_params(var_0) {
  var_1 = var_0.vo_one_remain;
  var_2 = -90;

  if(!var_0.linked_mover)
    var_2 = 90;

  if(isDefined(var_1.origin)) {
    var_3 = var_1.origin - var_0.origin;
    var_4 = vectortoangles(var_3);
    var_5 = var_4[1];
    var_6 = var_0.angles[1];
    var_2 = angleclamp180(var_5 - var_6);
  }

  [var_8, var_9, var_10] = sat_activate(var_0, var_2);
  set_maze_ai_stealth_settings(11);

  if(var_8 != "_encstr_B40101")
    var_0 _id_13C1D(var_8);

  if(var_0.vo_one_remain != var_1) {
    return;
  }
  _getrandomlocations::sequence_progression(1);
  set_maze_ai_stealth_settings(8);
  var_0 setscriptablepartstate("_encstr_B19005D885B5F6", "_encstr_990307710441B0947A");
  var_0 _encstr_9A8B0E9DC1D8165EB98E85933AC2B45B();
  set_maze_ai_stealth_settings(9);
  var_0 setscriptablepartstate("_encstr_B19005D885B5F6", "_encstr_997805335763B1");
  var_0 _id_13C1B();
  _encstr_867210BF1DB8875BD56302EA28B9C77E78A9(var_1.origin);
  var_11 = set_no_crash(var_0);
  set_maze_ai_stealth_settings(10);
  thread _encstr_B20C0D6F8829C2660D68329E1771A8(var_0);

  if(istrue(var_11))
    var_0 _id_13C1D("_encstr_8DF321206AE71851597FA625D762BD41192F48909F7DD02F21221733A10A9DA9572A42");

  set_maze_ai_stealth_settings(12);
}

_encstr_B20C0D6F8829C2660D68329E1771A8(var_0, var_1) {
  var_0 setscriptablepartstate("_encstr_B19005D885B5F6", "_encstr_A7EF0AE3A3D65A6868138F17");
  wait 4;
  var_0 setscriptablepartstate("_encstr_B19005D885B5F6", "_encstr_96A30882C9D57F355811");
  wait 4;
  var_0 setscriptablepartstate("_encstr_B19005D885B5F6", "_encstr_921D09D9D9C0090D7275B4");
}

_encstr_867210BF1DB8875BD56302EA28B9C77E78A9(var_0) {
  set_maze_ai_state(var_0);
  wait 2;
}

_encstr_9A8B0E9DC1D8165EB98E85933AC2B45B() {
  var_0 = _id_13C1C("_encstr_84FD230319892DBBD069ABC231903BE6CB67898CD77074CFF823920B5E763B5EB0A93FB0C3");
  var_1 = getanimlength(var_0);
  var_2 = var_1 - 2;
  wait(var_2);
}

set_number_of_subway_cars_on_track(var_0) {
  level._id_11E18.setincomingremovedcallback.vo_one_remain = var_0;
}

_encstr_BE810F17A040F4224BA9BD728D259AB988() {
  level._id_11E18.setincomingremovedcallback.vo_one_remain = undefined;
}

set_no_crash(var_0) {
  var_1 = undefined;
  select_woods_three_spawners(var_0);

  if(isDefined(var_0.vo_one_remain._id_134E3))
    var_1 = _getrandomlocations::server_structs(var_0.vo_one_remain);
  else
    wait 6;

  set_relic_gun_game(var_0);
  return var_1;
}

select_woods_three_spawners(var_0) {
  var_0._encstr_853510409B3561A1C2660D157E2AC1A9963B setscriptablepartstate("_encstr_B49B054CCA16AD", "_encstr_B2220C312B85DAAF59CD16C43659");
  var_0 setscriptablepartstate("_encstr_B49B054CCA16AD", "_encstr_B2220C312B85DAAF59CD16C43659");

  if(isDefined(var_0.vo_one_remain.start_area_fx_end)) {
    var_0._encstr_853510409B3561A1C2660D157E2AC1A9963B setotherent(var_0.vo_one_remain.start_area_fx_end);
    var_0.clear_mortar_settings = playfxontagsbetweenclients(scripts\engine\utility::getfx("_encstr_AC7B0E48BB15C1B54206EBE0DE6AF388"), var_0.clear_look_at_ent, "_encstr_8E010B996FB7B6B3C1D1183343", var_0.vo_one_remain.start_area_fx_end, "_encstr_8E010B996FB7B6B3C1D1183343");
    var_0.clear_mortar_settings unmarkkeyframedmover(1);
  }
}

set_relic_gun_game(var_0) {
  var_0._encstr_853510409B3561A1C2660D157E2AC1A9963B setscriptablepartstate("_encstr_B49B054CCA16AD", "_encstr_8D090D4C9585ADEB46D2B9B013B1AC");
  var_0 setscriptablepartstate("_encstr_B49B054CCA16AD", "_encstr_8D090D4C9585ADEB46D2B9B013B1AC");
  var_0._encstr_853510409B3561A1C2660D157E2AC1A9963B setotherent(undefined);

  if(isDefined(var_0.clear_mortar_settings))
    var_0.clear_mortar_settings delete();
}

_encstr_85090FA7DF0D22442BAB460D60B8997AE5(var_0) {
  if(var_0._encstr_8FA40959377202BBA19C43 == 0) {
    _encstr_91580BECE6A3C2A32BB423C695(var_0, "_encstr_9A231DB9D0AFD683EBB3C9AC56731385F2AFA5191BACFAA30BEA378EFA0698");
    var_0._encstr_8FA40959377202BBA19C43 = 1;
  } else
    _encstr_91580BECE6A3C2A32BB423C695(var_0, "_encstr_B4B11E3743BEADC1BECEE459ACDC262C97FAA5C863AC7D26C9CA16E81ABE8162");
}

_encstr_91580BECE6A3C2A32BB423C695(var_0, var_1) {
  var_0 _id_13C1D(var_1);
}

set_relic_doubletap_params(var_0, var_1) {
  if(!isDefined(var_0._encstr_924B0A0AB841CF3740B5E578) || var_0._encstr_924B0A0AB841CF3740B5E578 + 1 >= level._id_11E18._encstr_BE7707A750581422D6.size) {
    var_0._encstr_924B0A0AB841CF3740B5E578 = 0;
    var_0._encstr_973B062D1963ACE6 = scripts\engine\utility::array_randomize(level._id_11E18._encstr_BE7707A750581422D6);
  } else
    var_0._encstr_924B0A0AB841CF3740B5E578++;

  var_2 = var_0._encstr_924B0A0AB841CF3740B5E578;
  var_3 = var_0._encstr_973B062D1963ACE6[var_2];
  var_0 _id_13C1D(var_3);
  var_0.nodeidle = 1;
}

_encstr_AC410BE8E3CB1B53779C5FC16B(var_0) {
  var_1 = level._id_11E18.wait_for_next_hack_complete;
  var_2 = var_1.origin - var_0.origin;
  var_3 = vectortoangles(var_2);
  var_4 = angleclamp180(var_3[1]);
  set_relic_explodedmg(var_0, var_4, var_1.origin);
  var_5 = var_0 _id_13C1C("_encstr_B2CC1CAF7A2958E8504F35DDBFA0BA6E8FF00CE8D8E51FD12FCBE8F71A06");
  waitandstartparachuteoverheadmonitoring(10);
  var_1 notify("_encstr_A7E60B90F0D83F42207C6B31D5");
  var_0 _id_13ED2(var_5);
  var_0._encstr_8FA40959377202BBA19C43 = 0;
  set_maze_ai_stealth_settings(15);
}

postgamehitmarkerwaittime(var_0, var_1, var_2, var_3) {
  return !score_event_enemy_killed();
}

waitfor_trigger_near_obit() {
  if(getdvarint("_encstr_AFAD1672C138F782A627276B61D82B3FD00B6F7D39A0935A", 0) == 0)
    scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  [var_1, var_2, var_3] = waitformeleedamage();
  level._id_11E18.wait_for_open = var_3;
  waitandstartscorepolling(var_1, var_2);
  _id_14372();
  _encstr_8CB515B66E47584EA3B9DB1D4B33F2BBB03A6C1A95E4CD();
  _encstr_B8DA171B67837693BD5FF8429549A82037C543282967D7D31B();
  _encstr_B8B51B5BE6E02CEEDC4359B0C88D0DC2C63659CD76ACD1934BD9CE564E();
  waitforgulagfightstocomplete();
}

waitforallcrates() {
  for(;;) {
    [var_1, var_2, var_3] = waitformeleedamage(0);
    level._id_11E18.wait_for_open = var_3;
    waitandstartscorepolling(var_1, var_2);
    wait 1;
    var_4 = level._id_11E18.wait_for_next_hack_complete;
    _encstr_82A00FE85AFC80B5C25B796B578B7CD894(var_4, 2);
    waitframe();
    waitforremoteend(var_4);
    waitframe();
    waitfornukecarriernearlz(var_4, 84.7375);
    waitframe();
    waitforremoteend(var_4);
    waitframe();
    waitframe();
  }
}

waitformeleedamage(var_0) {
  var_1 = randomint(level._id_11E18.wait_for_player_eliminated.size);
  var_2 = level._id_11E18.wait_for_player_eliminated[var_1];
  var_3 = scripts\engine\utility::ter_op(var_1 + 1 < level._id_11E18.wait_for_player_eliminated.size, var_1 + 1, 0);
  var_4 = level._id_11E18.wait_for_player_eliminated[var_3];
  var_5 = var_4 - var_2;
  var_6 = vectortoangles(var_5);
  var_6 = (0, var_6[1], 0);
  return [var_2, var_6, var_1];
}

vehicle_outline_watcher() {
  var_0 = [];
  var_0[var_0.size] = (11898.5, 12257.3, 8462.71);
  var_0[var_0.size] = (20782, 29873, 3990);

  if(getdvarint("_encstr_A51D156FF26E7F7ABAF70B8B62D9F2CB6838A9B80BEDA8", 0) == 0) {
    var_0[var_0.size] = (31346, 26765, 1575);
    var_0[var_0.size] = (28493, 4769, 1353);
    var_0[var_0.size] = (2088, 2904, 3354);
    var_0[var_0.size] = (7245, 21948, 6297);
  }

  level._id_11E18.wait_for_player_eliminated = var_0;
  level._id_11E18._encstr_8A021252EB573BF4E83B6C6CDB887E9708C10AEB = 0;
}

vehicletrail() {
  var_0 = scripts\engine\utility::array_randomize(getarraykeys(level._id_11E18.wait_for_player_eliminated));

  if(!isDefined(level.br_circle.dangercircleent))
    return [var_0[0], level._id_11E18.wait_for_player_eliminated[var_0[0]]];

  foreach(var_2 in var_0) {
    if(var_2 == level._id_11E18.wait_for_open) {
      continue;
    }
    var_3 = level._id_11E18.wait_for_player_eliminated[var_2];

    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_3))
      return [var_2, var_3];
  }

  return [var_0[0], level._id_11E18.wait_for_player_eliminated[var_0[0]]];
}

waitforgulagfightstocomplete() {
  var_0 = level._id_11E18.wait_for_next_hack_complete;
  var_0.linked_mover = 0;
  waitandstartparachuteoverheadmonitoring(0);
  wait_in_spectate_for_time(var_0);

  for(;;) {
    var_1 = vehoccupancy_lastbctime();

    if(wait_for_morales_thanks()) {
      waitframe();
      continue;
    }

    if(isDefined(var_0._id_12930) && !vehiclespawn_cargotruckmg())
      [[var_0._id_12930]](var_0);
    else if(var_1 == 9)
      _encstr_A6010F901BA3EF9517F8D683906BC30829(var_0);
    else if(var_1 == 10)
      _encstr_B1730B6F584BA98B1BED86FD5A(var_0);
    else if(isDefined(var_0.vo_one_remain) && !vehiclespawn_cargotruckmg())
      waitfornukecarriernearlz(var_0);
    else
      waitforoneplayernearlz(var_0);

    waitframe();
  }
}

wait_in_spectate_for_time(var_0) {
  var_0._id_11EA4 = 0;
  var_0.nodeidle = 0;
  var_0._id_11EA9 = 0;
  var_0._id_11EA7 = 0;
  var_0._id_11F40 = randomintrange(level._id_11E18.wait_for_player_in_gas, level._id_11E18.wait_for_player_gulag_respawn + 1);
}

waitforoneplayernearlz(var_0) {
  if(wait_for_weapons_free(var_0)) {
    wait_in_spectate_for_time(var_0);
    waitforremoteend(var_0);
  } else if(!level._id_11E18._encstr_8E5B10B5C28DA38D930BA3CA58A31DB0C6B6 && wait_for_time_or_notify(var_0))
    waitforhvttrigger(var_0);
  else if(_encstr_8BC50D0B85483EFBD3FB8AB3632773(var_0))
    _encstr_B8F11108634B9BD3F70B5BC0EF47394773AA68(var_0);
  else {
    if(var_0.nodeidle && var_0._id_11EA7) {
      var_0.nodeidle = 0;
      var_0._id_11EA7 = 0;
    }

    var_1 = [];

    if(!var_0.nodeidle)
      var_1[var_1.size] = ::waitforplayerstoconnect;

    if(var_0 _encstr_91DD158E8D0BB93958CD8C7B6B6DA5D863DCD19CACB0AD())
      var_1[var_1.size] = ::waitforplayerstoconnect_countdown;

    var_2 = 0;

    if(var_1.size > 1)
      var_2 = randomint(var_1.size);

    if(var_1.size > 0)
      [[var_1[var_2]]](var_0);
    else
      waitforplayerstoconnect(var_0);
  }
}

_encstr_A6010F901BA3EF9517F8D683906BC30829(var_0) {
  var_0 endon("_encstr_A7E60B90F0D83F42207C6B31D5");
  _encstr_86CD0B40EBAB5A69F818BC35A2(var_0, "_encstr_B4891D7FD9AF7AD859F0CF1568E01872F89BAB9BD3A8D292E099839C86D209");
}

_encstr_B1730B6F584BA98B1BED86FD5A(var_0) {
  var_1 = level._id_11E18.setincomingremovedcallback;
  var_2 = var_1.origin - var_0.origin;
  var_3 = vectortoangles(var_2);
  var_4 = angleclamp180(var_3[1]);
  _encstr_B8B90D5BE6E82C8ECA93DB3AC2D1AC(var_0, var_4, var_1.origin);
  var_0 _id_13C1D("_encstr_AFF71BE353786FC2193F9596DF900CA780100A9AC1D01BFE2807B7307B");
  waitandstartparachuteoverheadmonitoring(0);

  if(getdvarint("_encstr_B25518DCD89CD74CC9AFAD3C1CD776F5CCF69CD8CAD7E68E85E5", 0) > 0)
    set_maze_ai_stealth_settings(12);
  else
    set_maze_ai_stealth_settings(0);
}

wait_for_weapons_free(var_0) {
  var_1 = _encstr_B2370ED289D5BBF55889F4E14DB8FF53();

  if(vehiclespawn_cargotruckmg())
    return 1;
  else if(_encstr_886A09A074B2E32607FF9E(var_0)) {
    if(isDefined(var_1))
      return level._id_11E18.wait_for_open != var_1;
    else {
      var_2 = _encstr_AA140E6D76953A630BDCA35A37462B1E();
      return level._id_11E18.wait_for_open != var_2;
    }
  } else if(wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !_encstr_937513D827F350A5333751EECA5AA99941A330F027())
    return 1;
  else if(!wait_after_first_counter() && var_0._id_11EA4 >= var_0._id_11F40)
    return level._id_11E18.wait_for_open != var_1;

  return 0;
}

_encstr_886A09A074B2E32607FF9E(var_0) {
  return _encstr_88D40E6D96B996DC19AC3C2DCDB3C2DC(level._id_11E18.wait_for_open);
}

_encstr_88D40E6D96B996DC19AC3C2DCDB3C2DC(var_0) {
  var_1 = level._id_11E18.wait_for_player_eliminated[var_0];

  if(update_volume_flag(var_1))
    return 1;

  return 0;
}

waitforhvttrigger(var_0) {
  var_1 = vehiclespawninginto();

  if(isDefined(var_1)) {
    var_2 = _getrandomlocations::_id_11A9F(var_0.origin, level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27, 0, 5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_0.origin, level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27, "_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5", 0);

    var_3 = var_1.origin;
    waitforplayerstoconnect(var_0);
    waitforplayerentering(var_0, var_3, var_1);
    var_2 delete();
  }
}

vehicle_occupancy_setfriendlystatusdirty() {
  if(wait_after_first_counter())
    return level._id_11E18.wait_and_destroy == level._id_11E18.wait_for_open;

  return 0;
}

wait_after_first_counter() {
  if(isDefined(level._id_11E18.wait_and_destroy))
    return 1;

  return 0;
}

_encstr_937513D827F350A5333751EECA5AA99941A330F027() {
  return _encstr_88D40E6D96B996DC19AC3C2DCDB3C2DC(level._id_11E18.wait_and_destroy);
}

vehiclespawninginto() {
  foreach(var_1 in level.train_hurt_damage_watcher) {
    if(_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_1) && var_1.trial_flares.type == "_encstr_A94C02B6" && var_1.trial_flares.index == level._id_11E18.wait_for_open && gettime() >= var_1.trial_flares.expiretime)
      return var_1;
  }

  if(level._id_11E18._encstr_8E5B10B5C28DA38D930BA3CA58A31DB0C6B6) {
    foreach(var_1 in level.train_hurt_damage_watcher) {
      if(_encstr_823D12809B0F90A3C7F4576DE16B4064D78218A9(var_1) && var_1.trial_flares.type == "_encstr_A94C02B6" && gettime() >= var_1.trial_flares.expiretime)
        return var_1;
    }
  }
}

waitandstartparachuteoverheadmonitoring(var_0) {
  level._id_11E18.wait_for_next_hack_complete.state = var_0;
}

vehoccupancy_lastbctime() {
  return level._id_11E18.wait_for_next_hack_complete.state;
}

_encstr_A75B0D22F123D04BFDAB2818D2D313() {
  var_0 = vehoccupancy_lastbctime();
  return var_0 == 1 || var_0 == 2 || var_0 == 3;
}

_encstr_8D8A0D3847C8933D4AF7EFA871BB41() {
  var_0 = vehoccupancy_lastbctime();
  return var_0 == 0;
}

_encstr_ADAE18C390A620B18FA03063B2AB0FDAC89FB2086BAB2A722F63() {
  if(level._id_11E18._encstr_93AB10AD8DD2AD96E8B0372D6B370EB22C6D && level._id_11E18.wait_for_open == level._id_11E18._encstr_8A021252EB573BF4E83B6C6CDB887E9708C10AEB) {
    [var_1, var_2] = _encstr_A61E142FB829FC6A5BAB83FC987192A830785F9750E0();

    if(level._id_11E18.wait_for_open != var_1)
      return [1, var_1];
  }

  return [0, undefined];
}

waitfornukecarriernearlz(var_0, var_1) {
  [var_3, var_4] = _encstr_ADAE18C390A620B18FA03063B2AB0FDAC89FB2086BAB2A722F63();

  if(var_3)
    waitforremoteend(var_0, var_4);

  waitandstartparachuteoverheadmonitoring(5);
  var_5 = var_0.vo_one_remain;
  var_6 = randomfloatrange(-180, 180);
  var_7 = angleclamp180(var_0.angles[1]);

  if(isDefined(var_5.origin)) {
    var_8 = var_5.origin - var_0.origin;
    var_9 = vectortoangles(var_8);
    var_6 = var_9[1];
  }

  var_10 = angleclamp180(var_6 - var_7);
  [var_12, var_13, var_14] = vehicleturretshootthread(var_0, var_10);

  if(isDefined(var_12) && var_12 != "_encstr_B40101")
    var_0 _id_13C1D(var_12);
  else {
    var_15 = (0, var_10, 0);
    var_0.x1fin_respawn rotateby(var_15, var_13);
  }

  if(var_0.vo_one_remain != var_5) {
    return;
  }
  var_0 _id_13C1D("_encstr_A1831EAB81012D736FA8DFF2F7FB28AE3F3E53E7D017193983CBFFC1D20F7262");

  if(var_0.vo_one_remain != var_5) {
    return;
  }
  if(_encstr_BA5917B5CD1AEDAB8D199156C6B0F26DD2B1B1B9A3E42B58AD(var_0)) {
    waitforplayerstoconnect(var_0);

    if(var_0.vo_one_remain != var_5)
      return;
  }

  _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback(1);

  if(var_5.change_goal_radius_weapons_free_internal == 2)
    var_0 thread _id_13C1D("_encstr_A79E221BE2BF608B5E2F62404D9F686BB9ED824F97F27DBF0B529E5FEC1D0B37BA2F60DE");
  else if(var_5.change_goal_radius_weapons_free_internal == 1)
    var_0 thread _id_13C1D("_encstr_84451DE7D2F1B1884FCCB1E8F54B43FFA9BBA76F57590F709CA679409150EA");
  else
    var_0 thread _id_13C1D("_encstr_AD451DAB82FE4B3F07E3B3AA3A1E80FFE6C0C7FF4F174F7B133B48EF2830B3");

  waitbombusestart(var_0);
  waitandstartparachuteoverheadmonitoring(0);
}

waitforplayerentering(var_0, var_1, var_2) {
  waitandstartparachuteoverheadmonitoring(8);
  var_3 = angleclamp180(var_0.angles[1]);
  var_4 = var_1 - var_0.origin;
  var_5 = vectortoangles(var_4);
  var_6 = var_5[1];
  var_7 = angleclamp180(var_6 - var_3);
  [var_9, var_10, var_11] = vehicleturretshootthread(var_0, var_7);

  if(isDefined(var_9) && var_9 != "_encstr_B40101")
    var_0 _id_13C1D(var_9);
  else {
    var_12 = (0, var_7, 0);
    var_0.x1fin_respawn rotateby(var_12, var_10);
  }

  if(isDefined(var_2))
    thread vehicle_playerenteredtrackedlittlebird(var_0, var_2, 1);

  var_0 _id_13C1D("_encstr_A1831EAB81012D736FA8DFF2F7FB28AE3F3E53E7D017193983CBFFC1D20F7262");
  waitandstartparachuteoverheadmonitoring(0);
}

vehicle_playerenteredtrackedlittlebird(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_927E15A375087F6269B859D2084FDBC3E1F0202F95D09B", 1.5);
  var_1 thread _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::train_get_anim_ents_index();
}

_encstr_BA5917B5CD1AEDAB8D199156C6B0F26DD2B1B1B9A3E42B58AD(var_0) {
  var_1 = gettime() - var_0.vo_one_remain.starttime;

  if(_encstr_AD271D0A7A7687A459A313A3BEC78B2283BA1EEF1DC8E050141372CB0985DB(var_0))
    return var_1 < getdvarint("_encstr_B24E1D58F7F8784605771A7B1141EBE7AC8BB76AC0D10897F8776595E970B8", 0);
  else
    return var_1 < getdvarint("_encstr_8C4516CDD8C9EB269CD76B3C837DB6F5D6CDEB3259D80BCB", 0);
}

_encstr_AD271D0A7A7687A459A313A3BEC78B2283BA1EEF1DC8E050141372CB0985DB(var_0) {
  return isDefined(var_0.vo_one_remain) && isDefined(var_0.vo_one_remain.player) && isPlayer(var_0.vo_one_remain.player);
}

waitfor_firstgroup_killedoffenough(var_0) {
  level._id_11E18.wait_for_next_hack_complete.vo_one_remain = var_0;
}

_encstr_B29C0F300AE36508142499DF44BA30BFAF(var_0) {
  level._id_11E18.wait_for_next_hack_complete.vo_one_remain = undefined;
}

waitbombusestart(var_0) {
  if(var_0.vo_one_remain.change_goal_radius_weapons_free_internal == 2)
    var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_8DB40E6279E06702A02BAF8BE9704DE3", 1.5);
  else
    var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_968F12ADACB9DBE60D58AFD9271626D74EB7C6D6", 1.5);

  var_0 setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_AB5E07609A5B7368E5", 0);
  _getrandomlocations::vehicle_spawn_cancelpendingrespawns(var_0.vo_one_remain);
}

vehicleturretshootthread(var_0, var_1) {
  var_2 = 22.5;
  var_3 = 67.5;
  var_4 = 112.5;
  var_5 = 157.5;
  var_6 = abs(var_1);
  var_7 = scripts\engine\utility::sign(var_1) < 0;

  if(var_6 <= var_2)
    return ["_encstr_B40101", 1, 0];
  else if(var_6 < var_3) {
    if(var_7)
      return ["_encstr_B69B18CD68F5D607FAD6B2E67BCDA116BE4757C9DC7D27EB0D4D", 2.2, 45];
    else
      return ["_encstr_97AD18FFA398E3E1976408BAE2AF294AD1C3CBD6C8317906CB53", 2.2, 45];
  } else if(var_6 < var_4) {
    if(var_7)
      return ["_encstr_9A9B181FC99195B1397A4DE595277A708FA3CD6090972249C262", 2.8, 90];
    else
      return ["_encstr_9AAD18E686F5D6C1FAB6CA9BB7E60D0BAFA3BA39E6D7B1F57260", 2.8, 90];
  } else if(var_6 < var_5) {
    if(var_7)
      return ["_encstr_ABEA1973E2FF65FBDE9A4D4EA063A3AE57789B9BD8271A0F7BDE05", 3.0, 135];
    else
      return ["_encstr_B2EE19B3223F25BB9EDA0D0EE023E36E97B85BDB9867DDCFBB1E45", 3.3, 135];
  } else if(var_7)
    return ["_encstr_AFEA1983F5065FFA5F80822AB85FB4277EBD0D1A60AEFBC96B32DF", 3.3, 180];
  else
    return ["_encstr_93EE19670A46DDB3070A9F5560076A99EEB0F7FB30BE0489F3BBB2", 3.3, 180];
}

_encstr_96FB0DA7EFB5436ED0FAF3BC51B0AD(var_0) {
  for(var_1 = 0; var_1 < level._id_11E18._encstr_AD1507DAD2466395B9.size; var_1++) {
    if(!isDefined(var_0._encstr_924B0A0AB841CF3740B5E578) || var_0._encstr_924B0A0AB841CF3740B5E578 + 1 >= level._id_11E18._encstr_AD1507DAD2466395B9.size) {
      var_0._encstr_924B0A0AB841CF3740B5E578 = 0;
      var_0._encstr_973B062D1963ACE6 = scripts\engine\utility::array_randomize(level._id_11E18._encstr_AD1507DAD2466395B9);
    } else
      var_0._encstr_924B0A0AB841CF3740B5E578++;

    var_2 = var_0._encstr_973B062D1963ACE6[var_0._encstr_924B0A0AB841CF3740B5E578];

    if(!level._id_11E18._encstr_93AB10AD8DD2AD96E8B0372D6B370EB22C6D || level._id_11E18._encstr_93AB10AD8DD2AD96E8B0372D6B370EB22C6D && !issubstr(var_2, "_encstr_85791CAFC28E056BCFC2271D387F22D156804B5BD0E64BD2A3EEAC951527")) {
      break;
    }
  }

  return var_0._encstr_924B0A0AB841CF3740B5E578;
}

waitforplayerstoconnect(var_0, var_1) {
  var_2 = [];

  if(getdvarint("_encstr_BE311F90877AEEC5DB2159DBC2211F56DC1FE8D80F04A0D7C2D945E89E8A49D93C", 1) == 1)
    var_2 = _encstr_8CC2155BB29BCA5B2D2BDC9B5958C9F637ECC9BD57B98C(var_0);

  if(var_2.size > 0) {
    var_3 = _encstr_867C14E2BEA509F57918238DF8CAE17B8447137F8F41(var_0, var_2);
    var_4 = angleclamp180(var_0.angles[1]);
    var_5 = var_3.origin - var_0.origin;
    var_6 = vectortoangles(var_5);
    var_7 = var_6[1];
    var_8 = angleclamp180(var_7 - var_4);
    [var_10, var_11, var_12] = vehicleturretshootthread(var_0, var_8);

    if(isDefined(var_10) && var_10 != "_encstr_B40101")
      var_0 _id_13C1D(var_10);

    var_0 _id_13C1D("_encstr_834822DC86BE6BE0FADAB273DB6ED016D7A5231BB2AFC6EDDB6DB4B97623B7DDCDF5C098");
  } else {
    var_13 = _encstr_96FB0DA7EFB5436ED0FAF3BC51B0AD(var_0);
    var_14 = var_0._encstr_973B062D1963ACE6[var_13];
    var_0 _id_13C1D(var_14);
  }

  var_0.nodeidle = 1;
  var_0._id_11EA4++;
}

_encstr_86CD0B40EBAB5A69F818BC35A2(var_0, var_1) {
  var_0 _id_13C1D(var_1);
}

_encstr_B8B90D5BE6E82C8ECA93DB3AC2D1AC(var_0, var_1, var_2) {
  var_3 = var_0.angles;
  var_4 = angleclamp180(var_3[1]);
  var_5 = angleclamp180(var_1 - var_4);
  [var_7, var_8] = vehicleturretshootthread(var_0, var_5);

  if(var_7 != "_encstr_B40101")
    var_0 _id_13C1D(var_7);

  var_9 = (0, var_1, 0);
  var_0 orientmode("_encstr_978B0B4A20EF7FA213A07966C5", var_2);
}

waitforremoteend(var_0, var_1) {
  waitandstartparachuteoverheadmonitoring(6);
  var_2 = var_0.origin;
  var_3 = var_0.angles;

  if(isDefined(var_1)) {
    var_4 = var_1;
    var_5 = level._id_11E18.wait_for_player_eliminated[var_4];
  } else
    [var_4, var_5] = _encstr_A61E142FB829FC6A5BAB83FC987192A830785F9750E0();

  var_7 = var_5 - var_2;
  var_8 = vectortoangles(var_7);
  var_9 = angleclamp180(var_8[1]);
  var_10 = angleclamp180(var_3[1]);
  var_11 = angleclamp180(var_9 - var_10);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
    var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_5, level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27, "_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5", 0);

  var_0 thread _encstr_81B41D1337C902619168AF8340A936AA8D4F9DCE1B73EB93D878EBBF2081ED("_encstr_AF2D105F6F4A6B95FBA6F37B8E38DF4468DF", var_5, level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27);
  [var_13, var_14, var_15] = vehicleturretshootthread(var_0, var_11);

  if(var_13 != "_encstr_B40101") {
    var_0 _id_13C1D(var_13);
    var_16 = angleclamp180(scripts\engine\utility::sign(var_11) * (abs(var_11) - var_15));
    var_17 = (0, var_16, 0);
    var_0.x1fin_respawn rotateby(var_17, 0.5);
  } else {
    var_17 = (0, var_11, 0);
    var_0.x1fin_respawn rotateby(var_17, var_14);
  }

  var_0 orientmode("_encstr_978B0B4A20EF7FA213A07966C5", var_5);

  if(getdvarint("_encstr_AD07206BB0BB81EA23763072A8797CC3595702855F641A89615910C2D0D37E52CF7E", 1)) {
    var_0 thread _encstr_BE2D153FE21B87D5A9202AA32BC5CEB770D989A30B4023(1);

    if(getdvarint("_encstr_816C1A1693DE070E62F73280A0A7212AE56679ECB810D57E73820807", 1))
      var_0 thread _encstr_B40519D636B0AECD8DA11CD82CF2959CCD46AE4ED237B3D4ABB507();
  }

  waitandstartparachuteoverheadmonitoring(1);
  var_0 _id_13C1D("_encstr_9BBA1C1B019135B3D810D26A78260BEE3905959DE1E9FAEBFF2B3B61AB5F");
  var_0 _id_13BA1();
  waitandstartparachuteoverheadmonitoring(2);
  var_0 _id_13C1C("_encstr_84F41A537AA9D92BF618AD88204758F2E8331B3DA39916E2CDB747EF");
  var_2 = var_0.origin;
  var_18 = var_5 + (0, 0, 25);
  var_19 = distance(var_2, var_5);
  var_20 = _encstr_A1180DD63BB2A3A65DD60E2DCD66DE(var_2, var_5);
  var_14 = var_19 / var_20._encstr_A2480ABD95190B2311CFB919;
  var_21 = -1 * var_20._encstr_AA1E0C687B45A89C13BFAD9B83CB;
  var_22 = trajectorycalculateinitialvelocity(var_2, var_18, (0, 0, var_21), var_14);
  level._id_11E18.wait_for_next_hack_complete.x1fin_respawn movegravity(var_22, var_14, var_20._encstr_AA1E0C687B45A89C13BFAD9B83CB);
  wait(var_14);
  level._id_11E18.wait_for_next_hack_complete.x1fin_respawn.origin = var_5;
  waitandstartparachuteoverheadmonitoring(3);
  var_0 _id_13C1D("_encstr_81401CBF6C81387737F291F8DAEF230B299A0B0BB0799BBDCF8A4BC6173E");
  var_0 _id_13E37();
  _encstr_A78F0F6DCD8E0B1D56DCAC47A5E646950F(var_4);

  if(vehiclespawn_cargotruckmg())
    waitforreturntobattlestance();

  if(getdvarint("_encstr_AD07206BB0BB81EA23763072A8797CC3595702855F641A89615910C2D0D37E52CF7E", 1))
    var_0 thread _encstr_BE2D153FE21B87D5A9202AA32BC5CEB770D989A30B4023(0);

  waitandstartparachuteoverheadmonitoring(0);
}

_encstr_B40519D636B0AECD8DA11CD82CF2959CCD46AE4ED237B3D4ABB507() {
  var_0 = self;
  var_0 notify("_encstr_B40519D626B0AECD8DA114D82CF2959CCD44AE4ED237B394ABB507");
  var_0 endon("_encstr_B40519D626B0AECD8DA114D82CF2959CCD44AE4ED237B394ABB507");

  if(var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1.size == 0) {
    return;
  }
  var_1 = getdvarfloat("_encstr_8D3C1D86E61B8779425748D8D357701111CAFE0571326BC0283F08384B81EA", 0.65);
  var_2 = getdvarint("_encstr_A9711D9B2E8A01CE2377CBE9E3D901C00F8660D156CB49F58B3BCBC99FA258", 1000);
  var_3 = getdvarint("_encstr_995D1B9B1B27F5C4C9BE5BC3C17D8D0E7D8DD0CAD8DAEB39B03296BADC", 550);
  var_4 = getdvarfloat("_encstr_81C91D8A39C00F6A7EFF8FD3C9B0D2780181C497D1F0C71258B1D7E3FD471A", 0.5);
  var_5 = getdvarint("_encstr_AAA5144790C3CFB27D30FDB08F7F0AA80E68C38708B9", 5000);
  wait(var_1);
  var_6 = var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1["_encstr_81CC0586952C91"]._encstr_95540C3EFF23184B87F238985ADB;
  var_7 = gettime() + var_2;

  while(gettime() < var_7) {
    var_8 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_6.origin, var_3);

    foreach(var_10 in var_8) {
      if(!isalive(var_10)) {
        continue;
      }
      var_11 = var_10 getgroundentity();

      if(isDefined(var_11) && var_11 == var_6)
        var_10 setvelocity((0, 0, var_5));
    }

    wait(var_4);
  }
}

_encstr_A20F1097F785735958A94708E090919A6B0D(var_0) {
  var_1 = level._id_11E18.wait_for_player_eliminated[var_0];
  return var_1;
}

_encstr_A61E142FB829FC6A5BAB83FC987192A830785F9750E0() {
  var_0 = _encstr_B2370ED289D5BBF55889F4E14DB8FF53();

  if(!isDefined(var_0))
    var_0 = _encstr_AA140E6D76953A630BDCA35A37462B1E();

  var_1 = level._id_11E18.wait_for_player_eliminated[var_0];
  return [var_0, var_1];
}

_encstr_A1180DD63BB2A3A65DD60E2DCD66DE(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._encstr_AA1E0C687B45A89C13BFAD9B83CB = level._id_11E18._encstr_A98E10081A5B4A820FDE89A4F805D981E303;
  var_2._encstr_A2480ABD95190B2311CFB919 = level._id_11E18._encstr_8E4D0E2ACA77084972B390E88A8D3320;
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 > level._id_11E18._encstr_BE661492BA8518A84169A3F030E8E717AD8FB6D97B1A) {
    var_2._encstr_AA1E0C687B45A89C13BFAD9B83CB = level._id_11E18._encstr_868E10788B55B0F96292B7C4ACAB1378A103;
    var_2._encstr_A2480ABD95190B2311CFB919 = level._id_11E18._encstr_AF4D0E5B535DDA1C37C1AC2B91B658C3;
  } else if(var_3 > level._id_11E18._encstr_B1D613B5A657B5388C969BE885E6D8CAAD5AC8DCB8) {
    var_2._encstr_AA1E0C687B45A89C13BFAD9B83CB = level._id_11E18._encstr_A78E106DA9AE6B1C769C2C67A54797B52D19;
    var_2._encstr_A2480ABD95190B2311CFB919 = level._id_11E18._encstr_964D0EC750EDB80113EB0F3569C08339;
  }

  return var_2;
}

_encstr_A78F0F6DCD8E0B1D56DCAC47A5E646950F(var_0) {
  level._id_11E18.wait_for_open = var_0;
}

_encstr_B2370ED289D5BBF55889F4E14DB8FF53() {
  if(wait_after_first_counter() && !vehicle_occupancy_setfriendlystatusdirty() && !_encstr_937513D827F350A5333751EECA5AA99941A330F027())
    return level._id_11E18.wait_and_destroy;
  else
    return _encstr_86D20D289F2DE8F642C3ABB5CF3A35();
}

_encstr_AA140E6D76953A630BDCA35A37462B1E() {
  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level._id_11E18.wait_for_player_eliminated.size; var_2++) {
    var_3 = level._id_11E18.wait_for_player_eliminated[var_2];
    var_4 = distance2dsquared(var_3, level.grouptorewards);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
      var_1 = var_2;
    }
  }

  return var_1;
}

_encstr_86D20D289F2DE8F642C3ABB5CF3A35() {
  var_0 = level._id_11E18.wait_for_open;
  var_1 = level._id_11E18.wait_for_open;

  for(var_2 = 0; var_2 < level._id_11E18.wait_for_player_eliminated.size; var_2++) {
    var_0 = scripts\engine\utility::ter_op(var_0 + 1 < level._id_11E18.wait_for_player_eliminated.size, var_0 + 1, 0);
    var_3 = level._id_11E18.wait_for_player_eliminated[var_0];

    if(!update_volume_flag(var_3))
      return var_0;

    var_1 = scripts\engine\utility::ter_op(var_1 - 1 >= 0, var_1 - 1, level._id_11E18.wait_for_player_eliminated.size - 1);
    var_4 = level._id_11E18.wait_for_player_eliminated[var_1];

    if(!update_volume_flag(var_4))
      return var_1;
  }
}

_encstr_99EF0F9287A25BE150CD9FA2481DE0F8E3(var_0) {
  var_1 = level._id_11E18.wait_for_next_hack_complete gettagorigin("_encstr_AADA07DBF19A4A81D7") + (0, 0, level._id_11E18._encstr_83BD1223FEABC723E918BA5258F9DD632166B5B4);
  var_2 = level._id_11E18._encstr_8B751158EA4F300552D79FBDDF4BC7A0F9C3C3;
  var_3 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_1, var_2);
  var_4 = tablesort(var_1, var_2, level._id_11E18._encstr_8D6A11D66EEEC2A32C9D9D4EB7A1954BCE868E);
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = [];

  foreach(var_8 in var_5) {
    var_9 = var_8.origin[2] - var_1[2];

    if(var_9 > 0 && var_9 < level._id_11E18._encstr_8D6A11D66EEEC2A32C9D9D4EB7A1954BCE868E)
      var_6[var_6.size] = var_8;
  }

  return var_6;
}

_encstr_8CC2155BB29BCA5B2D2BDC9B5958C9F637ECC9BD57B98C(var_0) {
  var_1 = level._id_11E18.wait_for_next_hack_complete gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = level._id_11E18._encstr_9588100FB40DA87A5B3253788B27A5C02303;
  var_3 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_1, var_2);
  var_4 = var_3;
  return var_4;
}

_encstr_867C14E2BEA509F57918238DF8CAE17B8447137F8F41(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = var_5.origin - var_0.origin;
    var_7 = vectordot(var_2, var_6);

    if(var_7 > 0)
      var_3[var_3.size] = var_5;
  }

  if(var_3.size > 0)
    return scripts\engine\utility::random(var_3);
  else
    return scripts\engine\utility::random(var_1);
}

_encstr_8C091113ABE0623337A2C2BB48967BDDD83D95(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isalive(var_0) && (isPlayer(var_0) || isagent(var_0)))
    return 1;

  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers()) {
    if(var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr() || var_0 scripts\common\vehicle::ishelicopter())
      return 1;
  }

  return 0;
}

_encstr_8BC50D0B85483EFBD3FB8AB3632773(var_0) {
  if(getdvarfloat("_encstr_9B33191E762A1FE6333FA892B33F3A70E730CB472929B32B8B8572", 10) > 0) {
    if(isDefined(var_0._encstr_B8340D63F943CBAF2426FCDB91E8F2) && gettime() - var_0._encstr_B8340D63F943CBAF2426FCDB91E8F2 < 10000)
      return 0;
  }

  var_1 = _encstr_99EF0F9287A25BE150CD9FA2481DE0F8E3(var_0);

  foreach(var_3 in var_1) {
    if(_encstr_8C091113ABE0623337A2C2BB48967BDDD83D95(var_3))
      return 1;
  }

  return 0;
}

_encstr_B8F11108634B9BD3F70B5BC0EF47394773AA68(var_0, var_1) {
  var_2 = _encstr_99EF0F9287A25BE150CD9FA2481DE0F8E3(var_0);
  var_3 = 0;
  var_4 = [];
  var_4[0] = 0;
  var_4[1] = 0;
  var_4[2] = 0;

  foreach(var_6 in var_2) {
    if(!_encstr_8C091113ABE0623337A2C2BB48967BDDD83D95(var_6)) {
      continue;
    }
    var_7 = level._id_11E18.wait_for_next_hack_complete.angles;
    var_8 = vectortoangles((var_6.origin[0], var_6.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
    var_9 = var_7[1] - var_8[1];
    var_10 = 0;

    if(abs(var_9) < level._id_11E18._encstr_A9AC0CC87ADFA095233F2F13779A) {
      var_4[0]++;
      var_10 = var_4[0];
    } else if(var_9 < 0 - level._id_11E18._encstr_A9AC0CC87ADFA095233F2F13779A && var_9 > 0 - level._id_11E18._encstr_82AC0C8433E03913F38B9F8FF31B) {
      var_4[1]++;
      var_10 = var_4[1];
    } else if(var_9 > level._id_11E18._encstr_A9AC0CC87ADFA095233F2F13779A && var_9 < level._id_11E18._encstr_82AC0C8433E03913F38B9F8FF31B) {
      var_4[2]++;
      var_10 = var_4[2];
    }

    if(var_10 > var_3)
      var_3 = var_10;
  }

  var_12 = [];

  foreach(var_15, var_14 in var_4) {
    if(var_14 == var_3)
      var_12[var_12.size] = var_15;
  }

  if(var_12.size > 0) {
    var_16 = scripts\engine\utility::random(var_12);
    _encstr_82A00FE85AFC80B5C25B796B578B7CD894(var_0, var_16);
  } else
    _encstr_82A00FE85AFC80B5C25B796B578B7CD894(var_0);

  var_0._encstr_B8340D63F943CBAF2426FCDB91E8F2 = gettime();
}

_encstr_82A00FE85AFC80B5C25B796B578B7CD894(var_0, var_1) {
  waitandstartparachuteoverheadmonitoring(7);
  var_2 = ["_encstr_84662182612EFD1AC877EDC5DA68804F19487B31D007E723E9EFCB6249771C616702D9", "_encstr_85931F5A9D375AE07EC03713C8D3A0C25F562356258F522CE388171F31685F1F5B", "_encstr_965F1FE643AF6BE0D7DAB237BDCD8685AF9BDD85E8FA581DA3B08DDABE9CFA81C4"];
  var_3 = [5.8, 4.5, 5.0];

  if(!isDefined(var_1))
    var_1 = randomint(var_2.size);

  var_4 = var_2[var_1];
  var_5 = var_3[var_1];
  var_0 _id_13C1D(var_4);
  var_0._id_11EA9 = 1;
  var_0._id_11EA4++;
}

_encstr_913112DA0D0B3719B65AD8D8D1E44BECD92B4ECD(var_0) {
  if(istrue(var_0)) {
    if(isDefined(level._id_11E18.wait_for_next_hack_complete._encstr_83220E1B2D73B2A790FBB4FE50B0FAEA) || isDefined(level._id_11E18.wait_for_next_hack_complete._encstr_84220E3A392DD9CE95271A16CD191B2B)) {
      return;
    }
    level._id_11E18.wait_for_next_hack_complete._encstr_83220E1B2D73B2A790FBB4FE50B0FAEA = level._id_11E18.wait_for_next_hack_complete _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(level._id_11E18._encstr_970E0C574FF33728E2CE1188F3CB, level._id_11E18._encstr_825D0C7823CFBFA81C652B3F80C3, "_encstr_9A430B70D17DFBA14F4A8BE861");
    level._id_11E18.wait_for_next_hack_complete._encstr_84220E3A392DD9CE95271A16CD191B2B = level._id_11E18.wait_for_next_hack_complete _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(level._id_11E18._encstr_970E0C574FF33728E2CE1188F3CB, level._id_11E18._encstr_825D0C7823CFBFA81C652B3F80C3, "_encstr_AD140B9ABED64B91AF1BACF589");
  } else {
    if(!isDefined(level._id_11E18.wait_for_next_hack_complete._encstr_83220E1B2D73B2A790FBB4FE50B0FAEA) || !isDefined(level._id_11E18.wait_for_next_hack_complete._encstr_84220E3A392DD9CE95271A16CD191B2B)) {
      return;
    }
    level._id_11E18.wait_for_next_hack_complete._encstr_83220E1B2D73B2A790FBB4FE50B0FAEA _encstr_BD0D1567D0E0D17299416B3F5F342A0240F99A2B6B6879();
    level._id_11E18.wait_for_next_hack_complete._encstr_84220E3A392DD9CE95271A16CD191B2B _encstr_BD0D1567D0E0D17299416B3F5F342A0240F99A2B6B6879();
  }
}

waitforplayerstoconnect_countdown(var_0) {
  var_1 = _encstr_8210145BECC039CA45C0A3D9B87831332402638F185B(var_0);

  if(!isDefined(var_1)) {
    if(level._id_11E18._encstr_8E5B10B5C28DA38D930BA3CA58A31DB0C6B6)
      var_1 = vehiclespawninginto();

    if(!isDefined(var_1))
      var_1 = var_0 _encstr_AA5725D75E186887B39B1660EBA0EA5F8BAB0C539105D0572F6BCB7A792BD2C3CF150998BF1BA7::pristinestatehealthadd(level._id_11E18.wait_for_player_to_getup, level._id_11E18.wait_for_players_init_puzzle);
  } else
    _encstr_AA7B13CD55959F3F1B0F6910D71DC3D39A532F3A53(var_0, var_1);

  if(isDefined(var_1)) {
    var_2 = _encstr_B88318482E73873759423B8DA7AB2B12C2EF70AA6EF2C54CF096(var_1.origin, level._id_11E18.waitandstartplunderpolling);
    var_3 = vectortoangles(var_2 - var_0.origin);
  } else {
    var_3 = (0, randomintrange(0, 360), 0);
    var_4 = anglesToForward(var_3);
    var_5 = randomfloatrange(3000, 15000);
    var_2 = var_0.origin + var_4 * var_5;
  }

  var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::semtex_used();
  var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::send_all_ai_to_players();

  if(getdvarint("_encstr_A770179BD827AF3139F56BE107F5AD7D16B1D1F5E827C2D8CA", 1) > 0) {
    var_8 = (var_2[0], var_2[1], min(var_6, var_2[2]));
    var_9 = 500;
    var_10 = max(var_6 + var_9 - var_8[2], 0);
    var_11 = min(var_7 - var_8[2], 0);
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_8, var_10, var_11);
  } else
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_2, abs(var_2[2]) + var_6);

  _getrandomlocations::vehicle_spawn_cp_gamemodesupportsabandonedtimeout(var_2, var_3, level._id_11E18.waitandstartplunderpolling);
  var_0._id_11EA7 = 1;
  var_0._id_11EA4++;
}

wait_for_time_or_notify(var_0) {
  [var_2, var_3] = _encstr_ADAE18C390A620B18FA03063B2AB0FDAC89FB2086BAB2A722F63();

  if(wait_after_first_counter() && vehicle_occupancy_setfriendlystatusdirty() && !var_2) {
    var_4 = vehiclespawninginto();

    if(isDefined(var_4))
      return 1;
  }

  return 0;
}

set_maze_ai_state(var_0) {
  var_1 = level._id_11E18.setincomingremovedcallback;
  var_1.gunposeoverride_internal = "_encstr_B2650840FBDB7F1188A1";
  var_1.upaimlimit = -90;
  var_1.downaimlimit = 90;
  var_1.rightaimlimit = -90;
  var_1.leftaimlimit = 90;
  var_1.aimyawspeed = 100;
  var_2 = (0, 0, 0);
  var_3 = sandbox_combat_area();
  var_4 = var_1 setaimangles(var_3, var_0, 1, var_2, 0, 0, 0);
  _encstr_8ED10D22D043EDFF51BB3F1DDE11C9(var_1, level._id_11E18._encstr_8E0C0A947EB2FB736C97A828);
}

_encstr_8ED10D22D043EDFF51BB3F1DDE11C9(var_0, var_1) {
  var_0 setaimstate(var_1);
}

sandbox_combat_area(var_0) {
  var_1 = level._id_11E18.setincomingremovedcallback.origin;

  if(isDefined(var_0))
    var_1 = var_0;

  return var_1 + (0, 0, 8100);
}

vehiclespawn_littlebirdmg() {
  return level._id_11E18.wait_for_next_hack_complete.origin + (0, 0, 3400);
}

_id_13220() {
  if(!isDefined(level.agent_funcs["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]))
    level.agent_funcs["_encstr_86EA0F2767A56AEA69611A27D9180242FB"] = [];

  level.agent_funcs["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]["_encstr_8E8A06F7D987435E"] = scripts\mp\mp_agent::default_spawn_func;
  level.agent_funcs["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::post_customization_func;
  level.agent_funcs["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::post_get_up_animation_function;

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]))
    level.agent_definition["_encstr_86EA0F2767A56AEA69611A27D9180242FB"] = [];

  level.agent_definition["_encstr_86EA0F2767A56AEA69611A27D9180242FB"]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_8D800929E3570DC82ED15B";

  if(!isDefined(level.agent_funcs["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]))
    level.agent_funcs["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"] = [];

  level.agent_funcs["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]["_encstr_8E8A06F7D987435E"] = scripts\mp\mp_agent::default_spawn_func;
  level.agent_funcs["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::vehicle_occupancy_takeriotshield;
  level.agent_funcs["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::vehicle_occupancy_updateriotshield;

  if(!isDefined(level.agent_definition["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]))
    level.agent_definition["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"] = [];

  level.agent_definition["_encstr_B6B00E2383C3A0EEAF7A69704267AB98"]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_AF6008D2C950D7B230BB";
}

spawnnewagent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = "_encstr_880B07DFB62BB72B3F" + var_0;
  var_8 = scripts\mp\mp_agent::getfreeagent(var_7);

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_8 scripts\mp\mp_agent::set_agent_team("_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");
  var_8 setModel(var_1);
  var_8 show();
  var_8 spawnagent(var_2, var_3, level.agent_definition[var_7]["_encstr_A6F10A61AAEFF1582559D7CF"], var_4, var_5, undefined, 0);
  var_8.connecttime = gettime();
  var_8.agent_height = var_5;
  var_8.agent_radius = var_4;
  var_8.callback = var_0;
  var_8.asmname = var_0;
  var_8.is_scripted_agent = 1;
  var_8.scripted_mode = 1;
  var_8.ignoreall = 1;
  var_8 scripts\mp\mp_agent::set_agent_team("_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8");
  var_8 scripts\mp\mp_agent::set_agent_health(9999);
  var_8 scripts\mp\mp_agent::add_to_characters_array();
  var_8 scripts\mp\mp_agent::activateagent();
  var_8 scripts\engine\utility::set_ai_number();
  var_8 animmode("_encstr_B69807B9DE36C69683");
  var_8.animationarchetype = var_0;
  var_8 scripts\asm\asm_mp::asm_init(var_0, var_0);
  var_8.intro_heli_animate_player = var_6;
  return var_8;
}

post_customization_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(_encstr_8DE0216E86DBAB6391B47673EDC9CACECAD0A58DD8B2160B26988DF6D81B5AB94BBD9B(var_0, var_1, var_4)) {
    return;
  }
  if(isDefined(level._id_11E18.setincomingremovedcallback._id_12930) || istrue(level._id_11E18.playerregendelayspeed))
    _encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  else
    _encstr_AC270E71F94FB8B85BC251D87AFFE568(var_0, var_1, var_2, var_4, var_5);
}

post_get_up_animation_function(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = 0;
}

vehicle_occupancy_takeriotshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(level._id_11E18.wait_for_next_hack_complete._id_12930) || istrue(level._id_11E18.playerregendelayspeed))
    _encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::sec_sys_struct_3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  else
    _encstr_AC270E71F94FB8B85BC251D87AFFE568(var_0, var_1, var_2, var_4, var_5);
}

vehicle_occupancy_updateriotshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = 0;
}

_encstr_AC270E71F94FB8B85BC251D87AFFE568(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && var_4.basename == "_encstr_9B7310AFD59D7A46303148D96B5882726203") {
    return;
  }
  var_5 = var_1;

  if(isDefined(var_1.classname) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E")) {
    if(isDefined(var_1.owner))
      var_5 = var_1.owner;
  }

  if(isPlayer(var_5)) {
    var_5 _encstr_A2421838B185CBB227EA0E32B01DCAE8DBDAB0431958DAC27659(self, var_2, var_3, var_4, 0);
    var_5 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", 0, 0, "_encstr_A5AE098ADB583E0AF7A5AB", 0, 1);
  }
}

_encstr_A2421838B185CBB227EA0E32B01DCAE8DBDAB0431958DAC27659(var_0, var_1, var_2, var_3, var_4) {
  var_1 = _encstr_87FD15C852BF7B6157DC0F71B1474935A07B30203B95BD(var_1, var_2, var_3);
  _encstr_AFD52220B199D137D3152B09426878F3C0F0E86145B0A121C7D5608C699AD90BA8FF2FB7(var_0, var_1, var_4);
  var_5 = self getentitynumber();
  var_6 = 0;

  if(!isDefined(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5])) {
    var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] = 0;
    var_6 = 1;
  }

  var_7 = int(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] / level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D);
  var_8 = (var_7 + 1) * level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D;
  var_9 = int(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] / level._id_11E18._encstr_871A12230BB516B3ACABCD1D966337DE1DD21B59);
  var_10 = (var_9 + 1) * level._id_11E18._encstr_871A12230BB516B3ACABCD1D966337DE1DD21B59;
  var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] = var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] + var_1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_96220C63C85B92E005982F279019", int(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] / 10));

  if(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] >= var_8)
    var_6 = 1;

  if(var_6) {
    var_11 = int(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] / level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D) - var_7;
    thread _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::_encstr_A11714D2CD3ACA8DAF8D7BB163B21B1D958C6BD2CD1B(self, var_11, var_3.basename);
  }

  if(var_0._encstr_A3FD0DA8907982F8A3F40762316F0F[var_5] >= var_10)
    _encstr_B259131D5D1C192CD1B22C37D95927472C27D959E8(var_0, self, 1);

  if(isPlayer(self)) {
    var_12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_3);
    var_13 = isDefined(var_12) && var_12 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";

    if(var_13) {
      if(isDefined(self.brattractions))
        self.brattractions++;
    }
  }
}

_encstr_87FD15C852BF7B6157DC0F71B1474935A07B30203B95BD(var_0, var_1, var_2) {
  if(var_0 > level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D)
    var_0 = level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D;

  var_3 = weaponclass(var_2);
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_2);
  var_5 = 0;
  var_6 = "_encstr_B27F109B8DE4F589397DAD0F1CAFB6161ED7" + var_3;
  var_7 = 50;

  if(var_3 == "_encstr_850707F7E5833355B8")
    var_7 = 150;
  else if(var_1 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")
    var_7 = level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D;
  else if(var_3 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" || issubstr(var_4, "_encstr_9243059F4C46E1")) {
    var_7 = level._id_11E18._encstr_8BCC0FD8EAA5C3E99F60A526418BB3834D;
    var_5 = 1;
  }

  var_8 = getdvarfloat(var_6, var_7);

  if(var_8 != 0)
    var_0 = int(min(var_0, var_8));

  var_9 = "_encstr_8E9C12CDD89CF51393D76B0F1CBE37B1C2D856EB" + var_4;
  var_7 = 0;

  if(issubstr(var_4, "_encstr_968113A00E45FB1B995E43434ED02BCB8F71191302")) {
    if(var_1 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")
      var_0 = 0;
    else
      var_0 = 100;
  } else if(var_5)
    var_7 = 5;
  else if(scripts\mp\utility\weapon::update_health_on_spawn(var_2))
    var_7 = 0.45;
  else {
    var_10 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_2);

    if(isDefined(var_10) && var_10 == "_encstr_9B7310AFD59D7A46303148D96B5882726203")
      return 0.0;

    if(isDefined(var_10) && var_10 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895")
      var_7 = 0.6;
  }

  var_11 = getdvarfloat(var_9, var_7);

  if(var_11 != 0)
    var_0 = int(ceil(var_0 * var_11));

  return var_0;
}

_encstr_AFD52220B199D137D3152B09426878F3C0F0E86145B0A121C7D5608C699AD90BA8FF2FB7(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    if(var_0 == level._id_11E18.wait_for_next_hack_complete)
      scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_AA261112FB5F9185819E105728F8BDF3A5DFC2", var_1);
    else
      scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_9726118D0D19BF335D38BBF12020F37758F76D", var_1);

    scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_AD26116A8B60BF634BAB63C633EBA1C28D89CB", 1);
  }

  scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_842611DA9DAF593B2B37D1FA4B378ECA36F526", var_1);
}

onplayerdisconnect(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level._id_11E18.setincomingremovedcallback))
    level._id_11E18.setincomingremovedcallback._encstr_9AF60D31FA87A5801369E53795FB40[var_1] = undefined;

  if(isDefined(level._id_11E18.wait_for_next_hack_complete))
    level._id_11E18.wait_for_next_hack_complete._encstr_9AF60D31FA87A5801369E53795FB40[var_1] = undefined;
}

_encstr_8210145BECC039CA45C0A3D9B87831332402638F185B(var_0) {
  if(var_0._encstr_9AF60D31FA87A5801369E53795FB40.size > 0) {
    var_1 = var_0 scripts\engine\utility::array_sort_with_func(var_0._encstr_9AF60D31FA87A5801369E53795FB40, ::_encstr_AC4B154B8070CDA36B96EFE6F01F8A9A7B08DBBF18CB2B);

    foreach(var_3 in var_1) {
      if(isDefined(var_3.player))
        return var_3.player;
    }
  }
}

_encstr_B259131D5D1C192CD1B22C37D95927472C27D959E8(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();
  _encstr_A18E10E816231958B9EC954E3A0B39B359E8(var_0, var_1);
  var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3].time = gettime();
  var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3]._encstr_917F0BA77687B1C53D7A801082 = var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3]._encstr_917F0BA77687B1C53D7A801082 + var_2;
}

_encstr_A18E10E816231958B9EC954E3A0B39B359E8(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(!isDefined(var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_2])) {
    var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_2] = spawnStruct();
    var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_2].player = var_1;
    var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_2]._encstr_917F0BA77687B1C53D7A801082 = 0;
  }
}

_encstr_AA7B13CD55959F3F1B0F6910D71DC3D39A532F3A53(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_2] = undefined;
}

_encstr_AC4B154B8070CDA36B96EFE6F01F8A9A7B08DBBF18CB2B(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.player))
    return 0;
  else if(!isDefined(var_1) || !isDefined(var_1.player))
    return 1;
  else if(var_0._encstr_917F0BA77687B1C53D7A801082 < var_1._encstr_917F0BA77687B1C53D7A801082)
    return 1;
  else if(var_0._encstr_917F0BA77687B1C53D7A801082 > var_1._encstr_917F0BA77687B1C53D7A801082)
    return 0;
  else
    return var_0.time > var_1.time;
}

_id_13187(var_0, var_1) {
  var_2 = "_encstr_A2D61EE30B7F02A983E84F9FE01965EAF1886FDD6DBB3BE94EC8075F10B14A63";
  var_3 = 8;
  var_4 = var_3;
  var_5 = 0;

  if(var_0)
    var_5 = var_3;

  var_6 = int(pow(2, var_4)) - 1;
  var_7 = (var_1 &var_6) << var_5;
  var_8 = ~(var_6 << var_5);
  var_9 = getomnvar(var_2);
  var_10 = var_9 &var_8;
  var_11 = var_10 + var_7;
  setomnvar(var_2, var_11);
}

_encstr_845B19233551F8851B93AD93E3535C50FA8B48189EB0E0C862BFA5(var_0, var_1) {
  if(!level._id_11E18._encstr_A1210E290BD2F050B68F93C9759F2836 || !isDefined(var_0) || !isPlayer(var_0) || !isDefined(var_1) || var_0 == var_1) {
    return;
  }
  _encstr_97BB0F3A479358B9DC99594E0BE6B35927(level._id_11E18.setincomingremovedcallback, var_0, var_1);
  _encstr_97BB0F3A479358B9DC99594E0BE6B35927(level._id_11E18.wait_for_next_hack_complete, var_0, var_1);
}

_encstr_97BB0F3A479358B9DC99594E0BE6B35927(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();

  foreach(var_5 in var_0._encstr_9AF60D31FA87A5801369E53795FB40) {
    if(isDefined(var_5) && isDefined(var_5.player) && var_5.player == var_2) {
      _encstr_A18E10E816231958B9EC954E3A0B39B359E8(var_0, var_1);
      var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3].time = gettime();
      var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3]._encstr_917F0BA77687B1C53D7A801082 = var_0._encstr_9AF60D31FA87A5801369E53795FB40[var_3]._encstr_917F0BA77687B1C53D7A801082 + var_5._encstr_917F0BA77687B1C53D7A801082;
      _encstr_AA7B13CD55959F3F1B0F6910D71DC3D39A532F3A53(var_0, var_2);
    }
  }
}

_encstr_A299134EB11867AA7DA392EAFBEBEF5B12315F1AEF() {}

_encstr_8CB515B66E47584EA3B9DB1D4B33F2BBB03A6C1A95E4CD() {
  var_0 = level._id_11E18.wait_for_next_hack_complete;
  var_0 thread vehomn_clearleveldataforvehicle();
  var_0 thread _encstr_95C9115739686BE0A91FCE81F46F0CC1DA50BA();
  var_0 thread _encstr_8FA212673F320520B41A40F9859FF8C53ABBE3DD();
  var_0 thread _encstr_85E30D4739ED2C93DD58D1C6A15927();
  var_0 thread _encstr_A11D0DE89B3A2B07DD168E6C0D56E4();
}

_encstr_8D8815C95E0BE7103C9038C0F2554F8B7113BB78A7E313() {
  var_0 = level._id_11E18.setincomingremovedcallback;
  var_0 thread _encstr_A536129FE94F6A946840BE02D870A1F316491FB3();
  var_0 thread _encstr_85E30D4739ED2C93DD58D1C6A15927();
  var_0 thread _encstr_A11D0DE89B3A2B07DD168E6C0D56E4();
}

vehomn_clearleveldataforvehicle() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_927E15A375087F6269B859D2084FDBC3E1F0202F95D09B");
    vehomn_clearcontrols();
  }
}

_encstr_95C9115739686BE0A91FCE81F46F0CC1DA50BA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_ADBD12E0CDE04FF344A9E618F2E279C9A0373611");
    self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_AB5E07609A5B7368E5", 0);
  }
}

vehomn_clearcontrols() {
  _encstr_B60D1BDB8A2CF06863DBB38B17AB2EA8DEA78371B56FA0952A9BB35F53(self.origin + (0, 0, 50), level._id_11E18._encstr_9B351312742A7F6DF2D30B70130EBD539B88084D27);
  self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_B846067B175AA56A", 0);
}

_encstr_8FA212673F320520B41A40F9859FF8C53ABBE3DD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B80A13548560706044B6CF724803C79BA76F845EDA");
    self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_8FA906CC80677438", 0);
  }
}

_encstr_A536129FE94F6A946840BE02D870A1F316491FB3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B8E4141FFE039ABE99D0079750D161D29F966516E6A1");
    self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_B846067B175AA56A", 0);
  }
}

_encstr_85E30D4739ED2C93DD58D1C6A15927() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_AB960B480BABE9B637E2DF6938");
    thread _encstr_92770E5380CF56C3C94D9D94D6F15F1C();
    thread _encstr_8F7815CD6A0233A39B6F48F85FAE79594AD648DF871ADD();
  }
}

_encstr_8F7815CD6A0233A39B6F48F85FAE79594AD648DF871ADD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level._id_11E18._encstr_B8060E5492680B6847B3E252A81BFFF3;
  var_1 = 0.25;
  var_2 = 0.0;

  if(self == level._id_11E18.setincomingremovedcallback)
    var_0 = level._id_11E18._encstr_A9170E8788F04103E195AA667D83AA06;

  while(var_2 < var_0) {
    var_3 = scripts\mp\utility\player::getplayersinradius(self.origin, level._id_11E18._encstr_BD2214D10DCA16ECCB9959AC9126C28DD6E485373B95);

    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        var_5 thread _encstr_8F4F12A307D8C2F227DB2CC99BD84E59CA9BCC0F(var_1 * 2);
        var_5 thread _encstr_885418931BDD5F97161A193D687260273E195243717D7F5A8338();
      }
    }

    wait(var_1);
    var_2 = var_2 + var_1;
  }
}

_encstr_8F4F12A307D8C2F227DB2CC99BD84E59CA9BCC0F(var_0) {
  self notify("_encstr_A9031B8923A2D7A022AD51CB5AFB301DEA735559873B25383A4358407F");
  self endon("_encstr_A9031B8923A2D7A022AD51CB5AFB301DEA735559873B25383A4358407F");
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_97CA0C18EFD69808834F750767CB", 0);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_92A6199B2257F6311AA35D7BCD0569B49B99F1807A57A50872B433", var_0);
  self notify("_encstr_AFCD1339DE85E4F5CD6C9C95B2DCF5333C7D56E68C");
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

_encstr_885418931BDD5F97161A193D687260273E195243717D7F5A8338() {
  self endon("_encstr_AFCD1339DE85E4F5CD6C9C95B2DCF5333C7D56E68C");
  self endon("_encstr_A9031B8923A2D7A022AD51CB5AFB301DEA735559873B25383A4358407F");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_92A6199B2257F6311AA35D7BCD0569B49B99F1807A57A50872B433");
}

_encstr_92770E5380CF56C3C94D9D94D6F15F1C() {
  if(self == level._id_11E18.setincomingremovedcallback)
    self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_B22B0B60727EC5024F54887037", 0);
  else
    self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_B846067B175AA56A", 0);
}

_encstr_A11D0DE89B3A2B07DD168E6C0D56E4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_A69D0B6C43DCF11577DF4D3F3B");
    thread _encstr_8FD00ED1B98E56389995953298B0C6AD();
  }
}

_encstr_8FD00ED1B98E56389995953298B0C6AD() {
  self setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_8FA906CC80677438", 0);
}

active_healthpacks() {}

_encstr_81B41D1337C902619168AF8340A936AA8D4F9DCE1B73EB93D878EBBF2081ED(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3)
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_0, var_5);
}

_encstr_91DD158E8D0BB93958CD8C7B6B6DA5D863DCD19CACB0AD() {
  if(istrue(self._id_11EA7))
    return 0;

  [var_1, var_2] = _encstr_ADAE18C390A620B18FA03063B2AB0FDAC89FB2086BAB2A722F63();

  if(var_1)
    return 0;

  if(isDefined(level.br_circle.circleindex) && level._id_11E18._encstr_931D180362326B51B84ADA4F8D10C76345BD165F47B7931F50A8 <= level.br_circle.circleindex) {
    self._id_11EA7 = 1;
    return 0;
  }

  return 1;
}

_encstr_B8B51B5BE6E02CEEDC4359B0C88D0DC2C63659CD76ACD1934BD9CE564E() {
  var_0 = level._id_11E18.wait_for_next_hack_complete;
  var_1 = level._id_11E18._encstr_A2BC1CB5D0B2B08CD81A588D3656B9ECB21D4EB476EC2B933958C8D2BADC;
  var_2 = level._id_11E18._encstr_963B1CB23A053E256968BB6ADC37F0BCEA535BC0193FA0B53BEAC44A8375;
  var_3 = "_encstr_AADA07DBF19A4A81D7";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, var_1, var_2);
  var_5.angles = var_0 gettagangles(var_3);
  var_5 enablelinkTo();
  var_5.x1loadout = 1;
  var_5 linkTo(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_0 scripts\mp\utility\trigger::makeenterexittrigger(var_5, ::_encstr_ACF41C9768801391E257DB6111EB58A2D06DC5020A1FDCB0D367B09B2D63, ::_encstr_BA851B3287436D97EAB26CC3081A25B042C554CBB31FDFB09ED133CA39, undefined, "_encstr_BA851B3287436D97EAB06CC3081A25B042C574CBB31FDFB09ED533CA39", ::_encstr_862E1D84F0B13209E168DB07E818C54A7775CB7A43C76A550B68D73BA311AA);
}

_encstr_862E1D84F0B13209E168DB07E818C54A7775CB7A43C76A550B68D73BA311AA(var_0, var_1) {
  if(isPlayer(var_0) && isalive(var_0))
    return 0;

  return 1;
}

_encstr_ACF41C9768801391E257DB6111EB58A2D06DC5020A1FDCB0D367B09B2D63(var_0, var_1) {
  if(!istrue(var_0._encstr_A9370BEABFC510FAAA089F172D)) {
    var_0._encstr_A9370BEABFC510FAAA089F172D = 1;
    var_0 thread _encstr_A77717C7F0E31192B1CB1D57207D2ADDE9F03F77A079406AB5();
  }
}

_encstr_BA851B3287436D97EAB26CC3081A25B042C554CBB31FDFB09ED133CA39(var_0, var_1) {
  if(istrue(var_0._encstr_A9370BEABFC510FAAA089F172D))
    var_0._encstr_A9370BEABFC510FAAA089F172D = 0;
}

_encstr_A77717C7F0E31192B1CB1D57207D2ADDE9F03F77A079406AB5() {
  self endon("_encstr_BA851B3287436D97EAB06CC3081A25B042C574CBB31FDFB09ED533CA39");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", level._id_11E18._encstr_8BBF159A43E319E527B238100A3EB9F15FEA178DA16720);
  scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_8726119FC588725630D813D1D0809C8AF97F52");
}

_encstr_B8DA171B67837693BD5FF8429549A82037C543282967D7D31B() {
  var_0 = level._id_11E18.wait_for_next_hack_complete;
  var_1 = level._id_11E18._encstr_B2AF180251F0C6F47117373FEF3102D0F88F8D4A834F55302B82;
  var_2 = level._id_11E18._encstr_837318DA1BD00BD8D8CADCECACA3395AEC9D95C934565AB386E8;
  var_3 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4, 0, var_1, var_2);
  var_5.angles = var_0 gettagangles(var_3);
  var_5 enablelinkTo();
  var_5.x1loadout = 1;
  var_5 linkTo(var_0, var_3, (0, 0, 0), (0, 0, 0));
  var_0 scripts\mp\utility\trigger::makeenterexittrigger(var_5, ::_encstr_923F18A72FB628D7D39AF98032AF15B04C6F3723AA9FC0A51F53, undefined, undefined, undefined, ::_encstr_ABDB198AD68EE31E28893D0EA75863432349C2929BD45F1580F322);
}

_encstr_923F18A72FB628D7D39AF98032AF15B04C6F3723AA9FC0A51F53(var_0, var_1) {
  var_2 = var_0 getvehicleowner();

  if(isDefined(var_2) && isPlayer(var_2))
    var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_96261193205907B3B7B0019FDFE3CBC2014932");
}

_encstr_ABDB198AD68EE31E28893D0EA75863432349C2929BD45F1580F322(var_0, var_1) {
  if(isDefined(var_0.vehiclename) && var_0.vehiclename == "_encstr_BDC80A5437EAD749519A6068" && isDefined(var_0 getvehicleowner()))
    return 0;

  return 1;
}

_encstr_97101E4B17713E08E9CFB30BF4C8A87D3A3B1FCFD3BA07F009E618019B93D025(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9")
    var_0 _encstr_AB9118FD69516B3E23B0C3E12B952040300F6FC393CB70972EF3(var_3);
}

_encstr_AB9118FD69516B3E23B0C3E12B952040300F6FC393CB70972EF3(var_0) {
  self setscriptablepartstate("_encstr_ADA80E87105EA1E5971B6833E2BF28B0", "_encstr_BA19049F4B2D");

  if(isDefined(self.script_noteworthy))
    _encstr_8CBB1A55BF110150B93750405FD58B731A62D9EDD57BE138615BA880(self.script_noteworthy);

  thread _encstr_B4811A877121ABD37377577F5B139BFDA8B87B8129484FCAC53F170B();
}

_encstr_8CBB1A55BF110150B93750405FD58B731A62D9EDD57BE138615BA880(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  switch (var_0) {
    case "_encstr_837D07810BC0BC5777":
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_B8CF29F1B12FEBE62D19C323222B903BBA3B3E6AB70238FAA877C86BE2AA6008B768FBF60F7ABECB570E62");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_958F29911EBE319CB5D7E66C4B197DD1A5A3589BF536F69B677B7DCDD0A51CD6599BA3DCEBE8BBDE7D4CC0");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_85FE2BDDF0192DAB8DA748D0678A4649029BC7508172EFD07E4F21580BF97B836A85C56669DBA91B559F193252");
      break;
    case "_encstr_A57D07BBAF3ACBF8BA":
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_BE8427E4B84936A6CB6E6063A00EF8381BC8F94BF9B23FFEFBFA78E8D2E8C2F827AB8FFF0E07B10B2F");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_A5C927E11AB9033AB2272B5E47B2B05C29FB19E80FBA308853B81013CABBDA54CF7B292D189A96F227");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_830729879261FAB339373BA3AF54A92408BB7E8DEEE88F2A8C7FF7FF9B060361C083799360D84D5270DB52");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_A19028DC8B5E3B327359ABA2C0E5A1BB7075215EB061477D3DC051BA78BDA287A9DE97CE30CB8BC99B52");
      break;
    case "_encstr_867D07E7BD258BF073":
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_A99227D968D9183EB7099B81721E6060ECDC5B5527BE2808F3E2168B9A172E1004239FDF8EE761EF92");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_96EF2723C37D98395BEB3736D28CFAE8961D2C37AFD8DEDCD9DEFA9B955A6E6BB4367D3AEEEDBE4C18");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_B14329983B69058B7F8F6E6E813616E14C633830A1BEA7407BD7605E65BF5B8B34BA51686A92FBF90791DF");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_9A132819E1F526E4ADAFB91BD219D7A34B3A16E6D736B7CDB37B7DCDB22DB9B54BD8EB33BDBA9CBE4C18");
      break;
    case "_encstr_AF7D07F06B4CDB320B":
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_A5682BD373E89902E1201070AD4F9915032456351E92BAC50BAA69617ADBA32FD853E3D9EF83EF42BD2DE90752");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_8FFB2BEBB896E2A353204A4613D349BCF84077BBE94957AA8DC059BD083FB373C038BB0FB043AF53D7E851E2CF");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_BA902E1987BE134EB6EB9B67B733AF3AD2A38573BE6CDE733BF6FA36F6CD47EB36DECDD1B01B3AF51D86392B56EB620C");
      break;
    case "_encstr_8D7D079847F4A057D7":
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_86B228C86B3935BB4F5FBEBE71EAC6D11C136873714E77700B8750205FDF0B47C6BBF001EAA5AB6E6EE0");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_A3B828C7D221BAF379770F37633F69E4C8FB3ECDAE284FEACC3FB70B47CD532B2003B719233007B18799");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_AB072A19E1D7894EB6F5CDB1D291FAD15A3A0BE6EB1BDE37B3F6AF37F6CAB98D161C59F547A139B2CAF5620C");
      _encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D("_encstr_AB38295773EF722AF099A7FF30A3CFDB7B8D9E4D483FFA4EFB301FC3E801BBD2C32767894C7F939AE6BA9A");
      break;
  }
}

_encstr_A3CD18AF10D630828BF38147D3B3BAE77959377BF00E8F1AF30D(var_0) {
  var_1 = lookupsoundlength(var_0);
  playsoundatpos(self.origin, var_0);
  wait(var_1 / 1000);

  if(level._id_11E18._encstr_BE591956CAE8A5B65689958EEEB256E691D2C2B1B7CE36B4E6CACD > 0)
    wait(level._id_11E18._encstr_BE591956CAE8A5B65689958EEEB256E691D2C2B1B7CE36B4E6CACD);
}

_encstr_B4811A877121ABD37377577F5B139BFDA8B87B8129484FCAC53F170B() {
  self endon("_encstr_AD75063D571AE108");
  wait(level._id_11E18._encstr_B1941559957D36DBBDB1C8DBDDE67D915D3916D15ABDB9);
  self setscriptablepartstate("_encstr_ADA80E87105EA1E5971B6833E2BF28B0", "_encstr_AB0703DBB9");
}

_encstr_B60D1BDB8A2CF06863DBB38B17AB2EA8DEA78371B56FA0952A9BB35F53(var_0, var_1) {
  var_2 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_0, var_1);

  foreach(var_4 in var_2) {
    if(isalive(var_4)) {
      if(var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
        var_4 dodamage(var_4.br_armorhealth, var_0, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5"));

      var_4 scripts\mp\weapons::setplayerstunned();
      var_4 thread scripts\mp\weapons::cleanupconcussionstun(level._id_11E18._encstr_8AE0198330955F2350A170381BEB1193DD53B50D5B03A89DB4A5A8);
      var_4 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_9B1905D3B92BF0", level._id_11E18._encstr_8AE0198330955F2350A170381BEB1193DD53B50D5B03A89DB4A5A8, 1);
    }
  }
}

_id_13C1D(var_0) {
  var_1 = _id_13C1C(var_0);
  _id_13ED2(var_1);
}

_encstr_AB0417A3325C388BAAFBA19B9343D5F8FCCEE9389FB9984BC2(var_0) {
  var_1 = _id_13C1C(var_0);
  var_2 = getanimlength(var_1);
  var_3 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_B1920ED9AD7D469CA5D9CA9BD7F69999", var_2);
  return var_3 == "_encstr_995408F398012F656821";
}

_id_13C1B() {
  self asmsetstate(self.asmname, "_encstr_ABC509D246B12BD758D2B6");
  self asmfireevent(self.asmname, "_encstr_82AB0A82D3502A13E08BE78F");
}

_id_13C1C(var_0) {
  var_1 = "_encstr_BD390ED07AD2835B8B0555C0193BA043";
  var_2 = archetypegetrandomalias(self.callback, var_1, var_0, 0);
  var_3 = self getanimentry(var_1, var_2);
  self setanimstate(var_1, var_2, 1.0);
  thread _id_13BA6(var_0, var_3);
  return var_3;
}

_id_13ED2(var_0) {
  var_1 = getanimlength(var_0);
  wait(var_1);
}

_id_13BA6(var_0, var_1) {
  if(!isDefined(level._id_11E18.notetracks) || !isDefined(level._id_11E18.notetracks[var_0])) {
    return;
  }
  foreach(var_3 in level._id_11E18.notetracks[var_0]) {
    var_4 = getnotetracktimes(var_1, var_3);
    var_5 = getanimlength(var_1);
    thread _id_13BA7(var_3, var_5, var_4);
  }
}

_id_13BA7(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B1920ED9AD7D469CA5D9CA9BD7F69999");
  var_3 = 0.0;
  var_4 = 0.0;

  foreach(var_6 in var_2) {
    var_4 = var_6 - var_3;
    wait(var_1 * var_4);
    self notify(var_0);
    var_3 = var_3 + var_4;
  }
}

_id_13BA1() {
  self.x1fin_respawn.origin = self.origin;
  self.x1fin_respawn.angles = self.angles;
  self linkTo(self.x1fin_respawn, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  self.x1fin_respawn dontinterpolate();
}

_id_13E37() {
  self unlink();
  self.x1fin_respawn.origin = self.origin;
  self.x1fin_respawn.angles = self.angles;
  self.x1fin_respawn dontinterpolate();
}

_encstr_85A10F0D6C03D58149B3D0B0B774D9316A(var_0) {
  if(isDefined(var_0._encstr_BD020DAC67587F5503C3FBF3E07BCF) && gettime() < var_0._encstr_BD020DAC67587F5503C3FBF3E07BCF)
    return 0;

  if(!_encstr_85B20DEF18405EDA15EBD7C3CBC5A2() || !_encstr_8D8A0D3847C8933D4AF7EFA871BB41())
    return 0;

  var_1 = sandbox_combat_area();
  var_2 = vehiclespawn_littlebirdmg();
  var_3 = scripts\engine\trace::create_contents(0, 1);
  var_4 = scripts\engine\trace::ray_trace_passed(var_1, var_2, [level._id_11E18.setincomingremovedcallback, level._id_11E18.wait_for_next_hack_complete], var_3);
  return var_4;
}

score_message() {
  if(istrue(level._id_11E18._id_12212))
    return 1;

  if(getdvarint("_encstr_A9F61186E61B8779425748D8D357F333B30A75", 0)) {
    if(sales_discount())
      return 0;

    return 1;
  }

  return 0;
}

wait_for_morales_thanks() {
  if(istrue(level._id_11E18._id_12212))
    return 1;

  if(getdvarint("_encstr_A9F61186E61B8779425748D8D357F333B30A75", 0)) {
    if(vehiclespawn_cargotruckmg())
      return 0;

    return 1;
  }

  return 0;
}

sales_discount() {
  return getdvarint("_encstr_A1E21507FE026793DB218350905667B987775E8F78414D", 0) || getdvarint("_encstr_96A61AD389DE977660476D70F1E1FF4F8AE10A6B963427AD90339677", 0);
}

set_relic_headbullets() {
  setDvar("_encstr_A1E21507FE026793DB218350905667B987775E8F78414D", 0);
}

vehiclespawn_cargotruckmg() {
  return getdvarint("_encstr_B25B1520F94B610ED53FEF1BD72FC027D390AEF91012A1", 0) || getdvarint("_encstr_84481ADCC639F5134EAFD63CE0FADAEBADAC2B83BE9A576B1CD2733B", 0);
}

waitforreturntobattlestance() {
  setDvar("_encstr_B25B1520F94B610ED53FEF1BD72FC027D390AEF91012A1", 0);
}

secretstashlootcacheused(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }
  if(isPlayer(var_0)) {
    var_0._id_136DC = _encstr_8F4818E077BF79398A9F0F8DB4937921E3A368F0D740F0DB12C3(var_1._encstr_B8400B4D439AB560A42F5BE94B, var_0);
    var_0 _meth_87E1(1);
    var_0 kill(var_1.origin, var_1._encstr_B8400B4D439AB560A42F5BE94B, var_1);
  } else if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers())
    var_0 dodamage(var_0.health, var_1.origin, var_1._encstr_B8400B4D439AB560A42F5BE94B, var_1);
}

_encstr_8F4818E077BF79398A9F0F8DB4937921E3A368F0D740F0DB12C3(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0.agent_type == "_encstr_86EA0F2767A56AEA69611A27D9180242FB") {
    var_2 = 3000;
    var_3 = level._id_11E18.setincomingremovedcallback.origin;
    var_4 = level.mapcenter - var_3;
  } else {
    var_2 = 3400;
    var_3 = level._id_11E18.wait_for_next_hack_complete.origin;
    var_4 = var_1.origin - var_3;
  }

  var_4 = vectorNormalize((var_4[0], var_4[1], 0));
  var_5 = (var_3[0], var_3[1], var_1.origin[2]);
  var_6 = var_5 + var_4 * (var_2 + 500);
  var_7 = [var_0, var_1];
  var_8 = scripts\engine\trace::create_contents(0, 1);
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_7, var_8);
  var_10 = var_4 * -1;
  var_11 = var_9["_encstr_BD260953AA97E3F014279D"] + var_10 * 50;
  var_12 = vectortoangles(var_10);
  var_13 = spawnStruct();
  var_13.origin = var_11;
  var_13.angles = var_12;
  return var_13;
}

_id_13DCE() {
  self endon("_encstr_AFCB082AC1D6A3EA7B73");
  var_0 = length2d((self.height / 2, self.radius, 0));

  for(;;) {
    if(self.classname == "_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72")
      var_1 = anglestoup(self.angles);
    else
      var_1 = (0, 0, 1);

    var_2 = self.origin + var_1 * self.height / 2;
    var_3 = tablesort(var_2, var_0);

    foreach(var_5 in var_3) {
      if(isDefined(var_5) && var_5 istouching(self))
        secretstashlootcacheused(var_5, self);
    }

    waitframe();
  }
}

_encstr_851A1BAB8B387B88B9EA484AD3452879703321FBCEDF0811D30643FD9E() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 agentsetclipmode("_encstr_8DEC06B1E943615B");
  var_1 = 0.1;
  var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1 = [];
  var_2 = getEntArray("_encstr_82F712F325582F525988894210B94DEF539B4F7E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_5 = "_encstr_9B4C023E";
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
    var_8 = var_4.script_noteworthy;

    if(var_8 == "_encstr_81CC0586952C91") {
      var_5 = "_encstr_AADA07DBF19A4A81D7";
      var_6 = (520, -200, 0);
      var_7 = (180, 82, 90);
    } else if(var_8 == "_encstr_95E80A8D59CCD1F533DBED3A") {
      var_5 = "_encstr_A1D50BD4BE2CDC6D36B2EBC695";
      var_6 = (360, -230, -30);
      var_7 = (0, -30, 90);
    } else if(var_8 == "_encstr_8ECF0B734B47E3AB67AD07909B") {
      var_5 = "_encstr_83D50BE2875F1037FDBA096892";
      var_6 = (340, -165, 60);
      var_7 = (0, -20, 90);
    } else if(var_8 == "_encstr_836F0E207FF0A347963BBF3321912548") {
      var_5 = "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156";
      var_6 = (-310, 140, -20);
      var_7 = (180, 260, 110);
    } else if(var_8 == "_encstr_BDB30F27D27643A37DDC0D7BEA8D8C56E4") {
      var_5 = "_encstr_A9B30EA6BECD347BAE3623569CBEC95A";
      var_6 = (300, -80, 0);
      var_7 = (180, 90, 65);
    } else if(var_8 == "_encstr_877D06BB570AB0D0") {
      var_5 = "_encstr_813B0D4027B390B37585BBC819FD28";
      var_6 = (0, -200, 0);
      var_7 = (180, 110, 90);
    } else {}

    var_9 = spawnStruct();
    var_9._encstr_95540C3EFF23184B87F238985ADB = var_4;
    var_9.tagname = var_5;
    var_9._encstr_B40F0D5FFB3BEA9C25AA8A10D2A799 = var_6;
    var_9.angleoffset = var_7;
    var_0._encstr_A16A0EC67B8DC6D26E5AB77336B437D1[var_8] = var_9;
  }

  var_11 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(550, 670, "_encstr_AADA07DBF19A4A81D7", 1, (-300, 0, 0), (180, 82, 90));
  var_12 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(500, 1200, "_encstr_813B0D4027B390B37585BBC819FD28", 1, (800, 180, -600), (0, 0, 0));
  wait(var_1);
  var_13 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(400, 1600, "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156", 1, (-100, 0, 0), (90, 0, 0));
  var_14 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(400, 1600, "_encstr_A9B30EA6BECD347BAE3623569CBEC95A", 1, (100, 0, 0), (-90, 0, 0));
  wait(var_1);
  var_15 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(400, 1100, "_encstr_8D8B0B309FA99B7EFA735F68F1", 1, (-100, 0, 0), (90, -10, 0));
  var_16 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(400, 1100, "_encstr_A78B0B4D7DAC6398F6DDEB27A5", 1, (-100, 0, 0), (-90, -10, 0));
  wait(var_1);
  var_17 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(350, 1000, "_encstr_AFDD09A6FA864B1CBEB156", 1, (200, 0, 0), (90, -15, 0));
  var_18 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(350, 1000, "_encstr_AFDD09A6FA864B1CBEC996", 1, (200, 0, 0), (90, 0, 0));
  wait(var_1);
  var_19 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(320, 1400, "_encstr_AC500A7A366A5BBFC04F9465", 1, (-100, 100, 0), (90, 0, 0));
  var_20 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(320, 1400, "_encstr_BD500A3C087F4AD519410B6F", 1, (-100, 100, 0), (90, 0, 0));
  wait(var_1);
  var_21 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(450, 120, "_encstr_A1D50BD4BE2CDC6D36B2EBC695", 1, (470, -20, 30), (0, -32, 86));
  var_22 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(450, 120, "_encstr_83D50BE2875F1037FDBA096892", 1, (470, 60, 30), (0, -23, 90));
  level._id_11E18.wait_for_next_hack_complete._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372 = [var_11, var_12, var_13, var_14, var_15, var_16, var_13, var_14, var_19, var_20, var_21, var_22];

  if(getdvarint("_encstr_837C1B9327703163D61E2A8303B88FF4C18D390BAF71837B7331825A6B", 1)) {
    var_23 = var_0 _encstr_81F014FF7FECE11B1DD316D1D747B2F2A38341706005(800, 2000, "_encstr_83890D9CA8EF0B79D830939788913A", 1, (-700, 0, 0), (90, 0, 0));
    level._id_11E18.wait_for_next_hack_complete._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372[level._id_11E18.wait_for_next_hack_complete._encstr_AC5016EA30E953BC7023976EDF58059B0D0BC21299355372.size] = var_23;
  }

  var_0._encstr_A65615C6DB8D63D29B2DDEB9D2CDB4A32D1663D24FB246 = 1;
  var_0 thread _encstr_BE2D153FE21B87D5A9202AA32BC5CEB770D989A30B4023(0);
}

_encstr_BE2D153FE21B87D5A9202AA32BC5CEB770D989A30B4023(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_BE2D153FE21F87D5E9202AA32BC5C6B770D989A30B4023");
  var_1 endon("_encstr_BE2D153FE21F87D5E9202AA32BC5C6B770D989A30B4023");

  while(!istrue(var_1._encstr_A65615C6DB8D63D29B2DDEB9D2CDB4A32D1663D24FB246))
    waitframe();

  if(var_0 == 1) {
    foreach(var_3 in var_1._encstr_A16A0EC67B8DC6D26E5AB77336B437D1) {
      var_3._encstr_95540C3EFF23184B87F238985ADB unlink();
      var_3._encstr_95540C3EFF23184B87F238985ADB linkTo(var_1, var_3.tagname, var_3._encstr_B40F0D5FFB3BEA9C25AA8A10D2A799, var_3.angleoffset);
    }
  } else {
    foreach(var_3 in var_1._encstr_A16A0EC67B8DC6D26E5AB77336B437D1) {
      var_3._encstr_95540C3EFF23184B87F238985ADB unlink();
      var_6 = var_1 _encstr_BE661F943A9399484F75405898B0E795AD89B1B96DDAEA87F7B1B39CF708709890(var_3);
      var_3._encstr_95540C3EFF23184B87F238985ADB.origin = var_6[0];
      var_3._encstr_95540C3EFF23184B87F238985ADB.angles = var_6[1];
    }

    for(;;) {
      foreach(var_3 in var_1._encstr_A16A0EC67B8DC6D26E5AB77336B437D1) {
        var_6 = var_1 _encstr_BE661F943A9399484F75405898B0E795AD89B1B96DDAEA87F7B1B39CF708709890(var_3);
        var_3._encstr_95540C3EFF23184B87F238985ADB moveTo(var_6[0], 0.1);
        var_3._encstr_95540C3EFF23184B87F238985ADB rotateTo(var_6[1], 0.1);
      }

      waitframe();
    }
  }
}

_encstr_BE661F943A9399484F75405898B0E795AD89B1B96DDAEA87F7B1B39CF708709890(var_0) {
  var_1 = self;
  var_2 = var_1 gettagorigin(var_0.tagname);
  var_3 = var_1 gettagangles(var_0.tagname);
  var_4 = var_2 + rotatevector(var_0._encstr_B40F0D5FFB3BEA9C25AA8A10D2A799, var_3);
  var_5 = combineangles(var_3, var_0.angleoffset);
  return [var_4, var_5];
}

_encstr_8B0110B9C3D5F0EFFB7A6E9688B02AD3DC68() {
  var_0 = ["_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"];
  var_1 = physics_createcontents(var_0);
  var_2 = self getvieworigin();
  var_3 = var_2 + anglesToForward(self getplayerangles()) * 50000;
  var_4 = _encstr_A7631C5A76DCDE272BFA2BE6479BEBEE0DAC37BE1DC29C76ACD13AD2E6EC();
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_4, var_1);

  if(getdvarint("_encstr_A2A9246E3639BE4C9CEB5BE183EB3839568DD29B96DE9BAF8E2CE4ECCAD1FA19966EC22636CA", 0))
    return scripts\engine\utility::ter_op(var_5["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A", undefined, var_5["_encstr_BD260953AA97E3F014279D"]);

  if(var_5["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
    return undefined;

  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];

  if(var_5["_encstr_AA1C0886968EA32FE056"] == "_encstr_88D90F8067B4334BB3F7082D0DCB53FB11") {
    var_7 = var_5["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_7) && isDefined(var_7.agent_type)) {
      if(var_7.agent_type == "_encstr_86EA0F2767A56AEA69611A27D9180242FB" || var_7.agent_type == "_encstr_B6B00E2383C3A0EEAF7A69704267AB98")
        var_6 = var_7.origin;
    }
  }

  return var_6;
}

_encstr_A7631C5A76DCDE272BFA2BE6479BEBEE0DAC37BE1DC29C76ACD13AD2E6EC() {
  var_0 = undefined;

  if(isDefined(self.vehicle))
    var_0 = [self.vehicle];
  else {
    var_1 = self getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
      var_0 = [var_1];
  }

  return var_0;
}

_encstr_8DE0216E86DBAB6391B47673EDC9CACECAD0A58DD8B2160B26988DF6D81B5AB94BBD9B(var_0, var_1, var_2) {
  return var_2 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_1) && isDefined(var_0) && var_1 == var_0 && isDefined(var_1.vehiclename) && (var_1.vehiclename == "_encstr_BDC80A5437EAD749519A6068" || var_1.vehiclename == "_encstr_83F40783ADF1D14AA3" || issubstr(var_1.vehiclename, "_encstr_9A8F0CB1A5E8471BB2EB894B39C8"));
}

activate_destructible_cinderblocks() {}