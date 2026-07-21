/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_payload.gsc
************************************************/

init() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AB23109F838B7B7448013FC5BBA84402D013");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97D715AB703EF3ADD2C928B0BDD3459E8E130B36559856");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_8CE50ED185C48D59A325B238360B36AC");

  if(getdvarint("_encstr_8CED183FBB4A29FE0331B3993B132080672FB993347748B0573A", 1) != 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8EC10D5F713FFBE6C151ED77E87034", ::_id_1365D);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::playerrespawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::_id_126F1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97670EEB0EFB48B1BA22F028DA0D6701", ::manage_fakebody_hides);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AC2A12B9D6A538A4DC66A5366A95B8BACA9BD8AC", ::_id_133D6);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF", ::modifyplayerdamage);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81351512099891B53044A89EC2083BB97F9C6F596C9F70", ::_id_125C4);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", ::playerdropplunderondeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AAF215A7382770D5F975C84D2081C06EE5B8E0792397EB", ::spawninitialvehicles);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", ::onplayerconnect);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AFF616E3B8631BCA703B9D99E5C0C3B79F33BABAE5462FBA", ::_id_133E1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_ADE213BB6277F7A91DAF5111C146C83DBB789060EA", ::_id_133DB);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8D051D58D8D14BD9583A95D2D2C663E61D2795165B9E7314AB9CC60DB0CDAC", ::attempted_to_use_gunship);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", scripts\engine\utility::void);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F00CAFF7571301BDFBC0989252", ::_id_12804);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97AC148F3596E7DDA6E7381B21A33B2BC2474D5BC883", ::_id_12006);

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    level._id_133E0 = 1;

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B10("_encstr_AF271030FA259FABDF34F5681CD7F35BCF93", ["_encstr_B607038AAB", "_encstr_93900B1640A7B35878B0E85104"]);
  var_0 = "_encstr_9BD50A1CA7C0E553306372BF";

  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    var_0 = "_encstr_BD370F28DAD38398C711DDDF0A53217D7A";

  level.disable_super_in_turret._id_1226A = getDvar("_encstr_B27C1493B933574275A127EFF8459FA9D121D059EB21", var_0);
  level.disable_super_in_turret.getquestscalervalue = getdvarint("_encstr_8DC61F67E3E28146BB996B71C3FB88383F47CF298D0E98972712A0DBC9F3B38097", 240);
  level.disable_super_in_turret.maxtime = getdvarint("_encstr_B11F18CAA6FDE9426BD1F3BF88C03772B9D0D5C6937F93815038", 300);
  level.disable_super_in_turret.getpropspawnlocation = getdvarint("_encstr_B1FD217BCE6AE12E0357D1FBA78AE06814A9E190F7A388DF0AB7F5A927533DC0A9BCC8", 60);
  level.disable_super_in_turret._id_14242 = getdvarfloat("_encstr_99D81B73C790D18336FE1B320201FF1678D70EED49E066635516C22B48", 6);
  level.disable_super_in_turret._id_14243 = getdvarfloat("_encstr_AD8720DA61D6D609922FBBB9A32A47FB902F13E0089496B5DFEFD0EB31768E20C73F", 1);
  level.disable_super_in_turret._id_14240 = getdvarfloat("_encstr_923D209713F29156ABA95B61D38B98280F571523B09CA8A91F8171EB6BAF58B0A2C8", 12);
  level.disable_super_in_turret._id_14241 = getdvarfloat("_encstr_8E2E203B10EDD18BB3588089635877E67959F3D230B3968B89A09590F3460B2EBF98", 8);
  level.disable_super_in_turret._id_1422D = getdvarfloat("_encstr_BD5D208F580B176AB5F8423ED3A172F11151635F98C063D2E390CE36367749B5FB50", 2);
  level.disable_super_in_turret._id_1422E = getdvarfloat("_encstr_9AD82537C64EAFC439F5072CCB8DF6B032FACE5986A5D836ACFA4C2C6C5BF56B07437D6E63EDDD", 1);
  level.disable_super_in_turret._id_13633 = getdvarfloat("_encstr_95C92137BED01770A6E7D021F35B17811A81FAD807C8F0AF84605F2BD94FB58732D875", 7500);
  level.disable_super_in_turret._id_13632 = getdvarfloat("_encstr_BD1921CB7F28694BFE26D3CACAD9475E309F433093D8EDF7AD98FBA316A7E353604FC3", 5500);
  level.disable_super_in_turret._id_13660 = getdvarfloat("_encstr_97342333E1C25FCAC2F9A31F22A1BA47918993222FECFBF9C86198117253413D2D36E2B398", 1500);
  level.disable_super_in_turret._id_1365F = getdvarfloat("_encstr_8C4923EBB1E69F7E784F8861FB70C5AF05AE6363593C23798013996FF19881F7B523DADA60", 1000);
  level.disable_super_in_turret._id_1368F = getdvarfloat("_encstr_8889239B369CBE4C4E7D0E169763EDC28CD79B38B0EEE6AF4E16915A5DCDEB199533B27332", 500);
  level.disable_super_in_turret._id_1368E = getdvarfloat("_encstr_83B723EBC03D015B8368B0D9132827D64989535348DF8577BB6FACD92D131F1EC1A8FAFAF0", 500);
  level.disable_super_in_turret._id_11B58 = getdvarint("_encstr_8632240328D5F9A36BB06871BB704FBE11316ABA58376FE7E087476D40B90785592873B2783D", 25);
  level.disable_super_in_turret._id_1225F = getdvarint("_encstr_A3EC144B867B4FB6CDD91B02C0D92D6F5160A5D32840", 1);
  level.disable_super_in_turret._id_129CB = getdvarint("_encstr_9A701CE33EC3F71E6581737AA88195C7B9886A69C5C857A517087B72F0ED", 1);
  level.disable_super_in_turret.set_force_aitype_sniper = getdvarint("_encstr_82DE1C331602D9C693D1C1B750DDF053C8F0D98AF5A83DEF5950C317F08D", 1);
  level.disable_super_in_turret.set_force_aitype_shotgun = getdvarint("_encstr_AF2620A00AA2FF09830F6FEF11C3904B8F51885022BB25815F4B77D7F7235E0BB68B", 20);
  level.disable_super_in_turret._id_13746 = getdvarint("_encstr_811F1BC8DF22A68D63E90F9F78DACF299C9740406FC9193F5B4A8F9C95", 0);
  level.disable_super_in_turret._id_13601 = getdvarint("_encstr_82D51CB9D8277D984EAF83162F36DE0B91F516D14716D8ADB227AFC2A54E", 0);
  level.disable_super_in_turret._id_13602 = getdvarint("_encstr_91B1203A8970BFFAEE6F0B474B9952F9A8963643C3304BA24D0DAF3F73BE993D381A", 0);
  level.disable_super_in_turret._id_13604 = getdvarint("_encstr_8DD0265E8B2306356A09800B8305F719D30FE657E14F6807D2C380B07A9E89961FD1EE586C9FF04B", 5);
  level.disable_super_in_turret._id_1365C = getdvarint("_encstr_92972937B139AF4CC9F51C5897B1F65891AFCD0716EEB97D0E4E7B8E56C6477D3B39DBAE9B327D4796ADB2", 10);
  level.juggheli_spawner_jammer5_3 = getdvarint("_encstr_A9BB1B33693E779680A75049C3589DD76D863B9AF11947CA11F5775F93", 12000);
  level.disable_super_in_turret.checkpoint_objective = getdvarint("_encstr_822E1BB673DBFEDD82D1A838AB5D8F71FB27372DDC072637ACFAB86063", 1);
  level.disable_super_in_turret.getquestscaledvalue = getdvarint("_encstr_8A4221F8F69877BAC67FDB98F0433759FBF096C399B770E7BF1C108959A99DA11D2906", 1);
  level.disable_super_in_turret.getpropsize = getdvarint("_encstr_BDB41CB01AB28F79F31F7FFF21D380BB9F61B018220C23B36F5806E3131F", 5000);
  level.disable_super_in_turret.getquesttimefrac = getdvarint("_encstr_BDCC1BB98DE4BE4C9CF583B05E63B70B23AFD1BD772B9CAFC1E4D236AC", 2500);
  level.disable_super_in_turret.mine_caves_turret_1_support = getdvarint("_encstr_A36C18E66CE4BE3139EB38B09763B71646FA9D2B1A5AB1D8599B", 0);
  level.disable_super_in_turret._id_136AB = getdvarfloat("_encstr_A1792270DA724FB9335F3FBF6193C0FB5FA1F8F0924B75560B8DCBA353FBC93F832AB0D0", 10);
  level.disable_super_in_turret._id_142F8 = getdvarfloat("_encstr_A1B817C367E321A0C87E5893E049A78FEFE083D8AF025709DB", 20000);
  level.disable_super_in_turret._id_14305 = getdvarfloat("_encstr_B8F317C862CAE711AB3757C7F93B7863B74978A01922D388AF", 20000);
  level.disable_super_in_turret._id_142F6 = getdvarfloat("_encstr_A1B817C367E321A0C87E5893E049A78FEFE083D8AF025709DB", 5000);
  level.disable_super_in_turret._id_142FF = getdvarfloat("_encstr_B28817ABDFC219DDD3D1672383D9AFEF10817B202640928B9D", 10000);
  level.disable_super_in_turret.brking_oncrateuse = getdvarint("_encstr_AA5519D75E18D98EAB59E30B7B016A5F99DF19D9A93FC81979284E", 1);
  level.disable_super_in_turret.convoy = getdvarint("_encstr_9A85169B38B0A98A9317DA0A926DD80941A74F758B731843", 1);
  level.disable_super_in_turret.idflags_hyper_burst_round = getdvarint("_encstr_92551BE7EF1ED14288FE125ED29087CAFD7F3F1F4D449A21B9A14C226B", 750);
  level.disable_super_in_turret.idflags_no_dismemberment = level.disable_super_in_turret.idflags_hyper_burst_round * level.disable_super_in_turret.idflags_hyper_burst_round;
  level.disable_super_in_turret.little_bird_mg_mp_spawncallback = getdvarint("_encstr_810B210B2BF349DDDBD92B769BDC10A98921A74BE3E913F28FB7B06B98E79A813A0B57", 1);
  var_1 = getdvarfloat("_encstr_994A1D1B30CDF1AB53B86069437857861939D352695D37DF0B807B6855A11F", 1500);
  level.disable_super_in_turret._id_142FE = var_1 * var_1;
  var_2 = getdvarfloat("_encstr_A76516DC36E4BE2693FA83169763EDC28CEB3BDED7DE9837", 700);
  level.disable_super_in_turret._id_14300 = var_2 * var_2;
  level.disable_super_in_turret.brmini_kickplayersatcircleedge = getdvarint("_encstr_9BCB239F3708B098A25E08CFE314175FD137483B8A8AC757876B2F9F80B708E76F30E1E5BB", 120);
  level.disable_super_in_turret._id_136C4 = getdvarint("_encstr_A50F13932672F9362B6FFFC1AF4308B122BDB8294A", 1);
  level.disable_super_in_turret._id_136C2 = getdvarint("_encstr_8C3F1998329AB741DB47A61F51E788EFC09A08A0693203594F75AE", 1700);
  level.disable_super_in_turret._id_136BE = getdvarint("_encstr_9A55184FCB3A59AE5361E38B6AAF50A1D02FEDEB6329A86353FA", 1);
  level.disable_super_in_turret._id_136C1 = getdvarfloat("_encstr_847F1FA2CE6571EAC3695763A05BAE392D506D5FAE97CA25EB183713E8369C43D5", 3);
  level.disable_super_in_turret._id_136C5 = getdvarint("_encstr_BA511A5A366D79F2DB616F6BB853A62115586557B0DF522AA0C8232F", 1);
  level.disable_super_in_turret._id_136C9 = getdvarint("_encstr_A2511E9F9776B92AD0D6EA3209A07EF1CA37635F071C82F21878A5FFE660B9FA", 300);
  level.disable_super_in_turret._id_136C0 = getdvarint("_encstr_96F5232EFB5376653A592838D213050E1B6F38AD6FFFB8ADA9F2D050AAACFD81371C3311AD", 1000);
  level.disable_super_in_turret._id_136BF = getdvarint("_encstr_A5D3246EC6E4BE8927F537E08577E6D7D37B9B95BEBDDEC4AF33DE277696D9CA7D9BD80BD859", 2.0);
  level.disable_super_in_turret.start_drones_event = getdvarint("_encstr_929C191F43A321408BE7E10AE6E0FF531E178FA1435B49AF10E742", 1);
  level.disable_super_in_turret._id_13DED = getdvarint("_encstr_8379179327703163D61EBB23A3A68FF930AD35079D71060FFB", 1);
  level.disable_super_in_turret.playerplunderdeposit = getdvarint("_encstr_8C26206B31661FFEF8CF08E17BF0452F852EB212BBB68FF9E08B15EA45908E5FBD63", 0);
  level.disable_super_in_turret._id_12CAA = getdvarint("_encstr_BA7C20F6966BF7093247B020C774E0C3B231EE756AA35393062F40909F821B6BCAA3", 1);
  level.disable_super_in_turret._id_11F9D = getdvarint("_encstr_863B22AFC76BE0402A896B4128ECF027E2CF1F152FB3B71B5C1FB67BD6D13966CA9FE193", 40);
  level.disable_super_in_turret._id_121FC = getdvarint("_encstr_ADA31D9BC639FA2627EBE0B05E36DB85197DE0C2D1D0F5E4594695E0C6DEBC", 5);
  level.disable_super_in_turret._id_12199 = getdvarint("_encstr_AF2B1C3F17522E9AF3A6C14783B9D7466DD1172B050679B2DB612759EAD0", 120);
  level.disable_super_in_turret._id_1219E = getdvarint("_encstr_BA241BCDB19CF5C49CAF1C16E58D7B2C32EB7BB35939A34B5BCAD76E4C", 60);
  level.disable_super_in_turret._id_1219F = getdvarint("_encstr_A9241B3F497BAF29838EB3C7C9042778304F0FF3C12B7364B1E897DEFA", 70);
  level.disable_super_in_turret._id_121A0 = getdvarint("_encstr_8C241B6B31661FFEF8CF08E17BF0452F852E2283593ECB7428932FFBC7", 80);
  level.disable_super_in_turret._id_121A1 = getdvarint("_encstr_9A241BE61B27F54C9CEB0758BCD8DE85C8BEF6B3AC938ED25B56D7B9D0", 90);
  level._id_127CD = 11;
  level._id_13C56 = 1;
  level.playerlocationtriggerexit = 1;
  level.debug_silo_thrust = spawnStruct();
  level.debug_silo_thrust.disabled = 0;
  level.debug_silo_thrust.minigameapplyplayernamesettings = getdvarint("_encstr_B446216FE67397158A275BB0B919E168845F8031F2C7E94723AA07FC5A2D102105F2A0", -1);
  level.debug_silo_thrust.minigamewinnersettings = getdvarfloat("_encstr_AAA82570D983FE2905C76FC19161554F6C6FC92749EB6160E328F76D858F6371D37FAB87853033", 0.33);

  if(level.disable_super_in_turret.checkpoint_objective)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_93320D7BF0CF0FDFA807F1CF4FE862");

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE" && level.disable_super_in_turret._id_1226A != "_encstr_AF1904A7F929")
    level.disable_super_in_turret._id_1226A = "_encstr_A5AE098ADB583E0AF7A5AB";

  level.dialog_wait_ready_civ = 4;
  level.debug_safehouse_gunshop_start = 1;
  level.disable_super_in_turret.paths = [];
  level.playerzombieupdatetagobjectives = ["_encstr_86510C82737817CD40B38B720A15", "_encstr_8C190467402B", "_encstr_8AD40926E431B1C07B0EB3", "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8FE608B268BFF756987D", "_encstr_91CD07D045CF0B0BB8", "_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_85DE05A6B2AC0E", "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_AF390B295782C3585F1B21D8C4", "_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_911904464232", "_encstr_A7B30DE187CA05B92B54B8537A15E8"];
  setDvar("_encstr_B8F20B31E043F917232347D1D2", 1);
  setDvar("_encstr_97720B8110327704CFACD8A143", 0);
  setDvar("_encstr_AB150B27C9D4134DA69CA8A745", 0);
  thread toggleusbstickinhand();
  thread delay_start_escort_enter_vehicle_objective();
}

toggleusbstickinhand() {
  waittillframeend;

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_95BD0B27EDABDC468DA5D62D8E", 2);
  level.roundlimit = scripts\mp\utility\dvars::getwatcheddvar("_encstr_95BD0B27EDABDC468DA5D62D8E");
  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_AB460CD345D5D0959B6F6B294752", 1);
  level.roundswitch = scripts\mp\utility\dvars::getwatcheddvar("_encstr_AB460CD345D5D0959B6F6B294752");
  level._id_12888 = ::emp_drone_proximity_explode;
  level._id_11C76 = ::dyn_door;
  level.defenderflagreset = ::eliminatedhudmonitor;
  level._id_12DB7 = ::endgame_stars;
  level.ontimelimit = ::ontimelimit;
  level._id_11C7B = ::_id_12607;
  level._id_11C7C = ::_id_12608;
  level._id_13B7E = ::timelimitclock;
  level._id_11C68 = ::_id_11C68;
  level._id_12059 = ::munition_source_getridof;
  level.modeonspawnplayer = ::embassy_level_init;
  level._id_11C73 = ::_id_12054;
  level.forcegivesuper = ::eliminateplayer;

  if(level.disable_super_in_turret._id_1225F)
    level._id_11C7A = ::_id_1226B;

  scripts\mp\flags::gameflaginit("_encstr_A2D20FE4880D52A426C867576878654BD3", 0);
  scripts\mp\flags::gameflaginit("_encstr_A7FC13191DB4928A8E0BC660C587BE3DF146532F6C", 0);
  level.disable_back_light = 1;
  level.roundenddelay = 5;
  level.checkforlaststandfinish = 1;
  level._id_133E6 = 1;
  level._id_133CD = 1;
  level._id_133D7 = 1;
  level.set_tier_lights = getdvarfloat("_encstr_A3B12482EE85910A2389BB074018CFBA71680FBBC0D54A42AE78C71759F3BDB2FB9E5334386D", 0.4);
  level.set_total_successful_vehicle_spawns_from_module = getdvarfloat("_encstr_865C1E3B10EDD18BB3588089635877E67959E2D373BD17F3CE3D958768A307ED", 0.4);
  level._id_12281 = "_encstr_BAC20FBEE6F88945F163A37BD68409923B";
  level._id_12283 = "_encstr_A60C19403F13E980298333C01BDB8F332FAA409FE87798B0802269";
  level.disable_super_in_turret._id_1426E = 250;
  level.disable_super_in_turret._id_1426D = 200;
  level.disable_super_in_turret._id_14249 = (0, 0, 200);
  level.disable_super_in_turret._id_1226E = getdvarint("_encstr_B8C2165BD7CB9F6930A7DF264B7A9D3B19500B034AD8FBDB", 1);
  level.disable_super_in_turret._id_12275 = getdvarint("_encstr_8E60243798D3A86EC321BBE9333C82A381D78AE56218B9B8A99FE7A61BF93BBBC1CE44035B0F", 0);
  level.disable_super_in_turret._id_12271 = getdvarint("_encstr_AC3E2148E24A67912BB7D74779BBF8E337C9C0F03AA279CBC7BE5D4947FF6383DEE258", 1);
  level.disable_super_in_turret._id_12272 = getdvarint("_encstr_BDC51E6EB19CBE2693F5382CCB63ED8519BE2EAE2BCDA3E67DE8C289D856D1CD", 1);
  level.disable_super_in_turret._id_12273 = getdvarint("_encstr_87F51E802A829F69E36F0F8F31E3B0AB6F712088931A33837F6C9F760CEF1B57", 1);
  level.disable_super_in_turret._id_1226F = getdvarint("_encstr_BD841FCDD8E4EB2639FA380B2F1BDEC232AF5CAB95DC8E9BBE762D9D2B7DB08EA3", 1);
  level.disable_super_in_turret._id_12270 = getdvarint("_encstr_96831F638E42AF1D965E0302CB2050696356973BE2731B9B6701CB705D10B313EF", 0);
  level.disable_super_in_turret._id_1227C = getdvarint("_encstr_AC5621B39865A9F33BC01801EBC0FF6EE1E13BFBC013DFCFD335073906A977F303D8C2", 45);
  level.disable_super_in_turret._id_12288 = getdvarint("_encstr_8EB31D9BB04D712BD338E0E9C3F8D70699B9B323E9C7F44FA91AE8EFD380E3", 2000);
  scripts\mp\rank::_id_12189("_encstr_ABD70578F3D02C", 100);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366", ::vehicle_spawn_mp_gamemodesupportsrespawn);
  level.vehicle.spawn._id_12CA2 = getdvarint("_encstr_AD5A1FB9D893D7C44EFA0E58F21BDB5823D79DAC1A5AD81B2B7D9C59E607B0BB73", 30);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14176(level._id_12281, ::_id_14259);
  var_2 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");
  var_2._id_13E92 = "_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862";
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D(level._id_12281, "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_8D48079DD59BE65627"]);
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(level._id_12281, var_3);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, [var_3]);
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(level._id_12281, var_3);
  var_4.exitids = ["_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AA5606FD1AF05085", "_encstr_82CF0B6862EF3316CB61BC2354"];
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, [var_3]);
  var_4._id_13E8A = getcompleteweaponname("_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862");
  var_4._id_13E92 = "_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862";
  scripts\cp_mp\vehicles\vehicle_interact::_id_141A7("_encstr_A7D708BA0E769358C859", ::_id_1418D, ::_id_141AE, ::_id_1418D, ::_id_1418D);
  scripts\cp_mp\vehicles\vehicle_interact::_id_141A7("_encstr_966C0E37C0B3B9320575CA07DE33BA6D", ::_id_1418D, ::_id_141AE, ::_id_1418D, ::_id_1418D);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D(level._id_12281, "_encstr_A7D708BA0E769358C859", ["_encstr_A96D107BAE9F014632C3DBD39BD901683643", 0, ::_id_1418C]);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D(level._id_12281, "_encstr_966C0E37C0B3B9320575CA07DE33BA6D", ["_encstr_8FBE114B21BC6FCA1BC54D55E5B9D2FFD478C3", 0, ::_id_1418C]);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AC0B185773E206F0A1DDA5F9028D094E1AA383DFDF685688ECF7", ::eliminate_drone_spotlight_speed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE", ::init_relic_fastbleedout);
  level.headiconbox = undefined;
  timetonextcheckpoint();
  toggle_fx_trap();
  time_between_rocket_fire();
  timed_laser_trap_trigger();
  thankyou_photo();
  totalcollecteditems();
  timed_death();
  tracegroundheightexfil();
  technical_initdamage();
  terminal_pusher_approach_array_counter();
  time_on_floor();
  thread toggle_player_settings();
  tmtyl_vip_interactions();
  level thread totalmuncurrencyearned();
  tomastrike_isflyingvehicle();
  _encstr_839E1893E31D7A4150D34CD228E89CB266170B1B4B3EE20F385B();
  level.teamdata[game["_encstr_991C0AB9ED5B57161FE89B83"]]["_encstr_86410DE597333F0B678D9589355988"] = getdvarint("_encstr_A504229B36E4FA89C9FA0E16CBB1DB8532BE9B0E85DD73AF32AC1BB0F2AF5847D1C26CB6", 0);
  level.teamdata[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]["_encstr_86410DE597333F0B678D9589355988"] = getdvarint("_encstr_814C22C39F0690B6AB1630C178D8B2D7519133F3F74FAE60876DE4C29B268F9706B0A2CA", 15);
  thread _id_1452D(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  thread _id_1452D(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  if(istrue(level.disable_super_in_turret._id_1226E)) {
    _encstr_83852BDAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067BF406BF31A6760EBC18FB32AD34B9A8FF778::init();
    thread _id_1226D();
  }

  thread _id_1225E();
  thread _id_1226C();
  thread _id_12258();
  thread _id_131D6();
  level.isoutside = 0;
  level.isopenable = 0;
}

_encstr_839E1893E31D7A4150D34CD228E89CB266170B1B4B3EE20F385B() {
  var_0 = getEnt("_encstr_88881F13575AD88C2C898D56F51B0DCA6CDA83B7B4CD47AF6CC6A51C98C9AEDCA1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_96771F0B28A8E4CA53A685FFAF7793B193C82BB7A08132A1AF49CCB2F605AB6B38", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = (0, 0, 0);
  var_0.origin = var_2;
  var_1.origin = var_2;
}

_id_141AE(var_0, var_1, var_2, var_3) {
  var_1.disabled = 1;
}

player_get_primary_weapon_object(var_0) {
  if(!isDefined(var_0))
    return "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";

  switch (var_0) {
    case "_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1":
    case "_encstr_995B109BAB0756E47DCA5B837D914EEDB995":
    case "_encstr_8BBA05185F8B99":
      return "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";
    default:
      return var_0;
  }
}

eliminateplayer(var_0, var_1, var_2, var_3) {
  var_0 = player_get_primary_weapon_object(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_0, var_1, var_2, var_3);
}

_id_1226C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime());
  thread _id_13277(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  thread _id_13277(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  foreach(var_1 in level.players) {
    if(isDefined(var_1 scripts\mp\supers::getcurrentsuper())) {
      var_1 scripts\mp\supers::setsuperbasepoints(0);
      var_1 scripts\mp\supers::setsuperextrapoints(0);
    }
  }
}

_id_13277(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1)
  scripts\mp\utility\outline::outlineenableforteam(var_3, var_0, "_encstr_8B4E16F6EA47C6D23756F5C8B20E8E1ABE0EB0BCB1DB5819", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
}

_id_11C68() {
  setomnvar("_encstr_BA0211D5D2FAD8D5399CCA37A3F539F657E646", 1);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AADE09481E247875C2EFAB", 0, undefined, 1, 2);
  wait 10;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 1);
    var_1 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  }
}

onplayerconnect(var_0) {
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(var_0.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_0 _id_13184(0);
  else
    var_0 _id_13184(1);

  thread _id_13277(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  thread _id_13277(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

  if(scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3")) {
    var_0 thread _id_1268D();
    var_0 thread _id_126E0();

    if(isDefined(var_0 scripts\mp\supers::getcurrentsuper())) {
      var_0 scripts\mp\supers::setsuperbasepoints(0);
      var_0 scripts\mp\supers::setsuperextrapoints(0);
    }
  }

  var_0.heli_landing_volumes = [];
}

onplayerspawned() {
  level endon("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    play_smoke_fx(self);
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  }
}

onplayerkilled(var_0) {
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(isDefined(var_2.vehicle) && isDefined(var_2.vehicle.occupants) && isDefined(var_2.vehicle.occupants["_encstr_8D48079DD59BE65627"])) {
    if(var_2 == var_2.vehicle.occupants["_encstr_8D48079DD59BE65627"]) {
      var_2 thread scripts\mp\rank::giverankxp("_encstr_99B01A186009C897983D529B12DE2B38A9E8B809A62784100B38681D", 50);
      var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_99B01A186009C897983D529B12DE2B38A9E8B809A62784100B38681D");
      var_2 thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(50, "_encstr_99B01A186009C897983D529B12DE2B38A9E8B809A62784100B38681D");
    }
  }

  if(isDefined(var_1.vehicle) && isDefined(var_1.vehicle.occupants) && isDefined(var_1.vehicle.occupants["_encstr_8D48079DD59BE65627"])) {
    if(var_1 == var_1.vehicle.occupants["_encstr_8D48079DD59BE65627"]) {
      var_2 thread scripts\mp\rank::giverankxp("_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835", 100, undefined);
      var_2 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptableusestate("_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835", int(50.0), var_2.currentweapon, 1);
      var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835");
      var_2 thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(100, "_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835");
    }
  }
}

_id_12054(var_0) {
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::droptogroundmultitrace(var_0);

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    _id_12508();
}

_id_12508() {
  var_0 = getdvarint("_encstr_A6CB1ADC6CC9BE89397DC1B0CBD8DEB091F56ED12C4E47FA0B6BADBD", 2);

  if(var_0 == -2) {
    foreach(var_2 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_2)) {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
        self givemaxammo(var_2);
      }
    }
  } else if(var_0 == -1)
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  else if(var_0 > 0) {
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();

    foreach(var_6 in [self.primaryweapon, self.secondaryweapon])
    _id_13197(var_6, var_0);

    _id_13141();
  }

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
}

_id_13141() {
  foreach(var_1 in [self.primaryweapon, self.secondaryweapon]) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(var_1, "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD") || scripts\engine\utility::string_starts_with(var_1, "_encstr_A34C12B0EB7A380815D7690B13FA20F68F12C8FB")) {
      var_2 = asmdevgetallstates(var_1);
      var_3 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_2);

      if(isDefined(var_3)) {
        var_4 = getdvarint("_encstr_91FB1EB98DC9FA3127FA8D93ED9BDC31F6EEAF16ADB67BBEEDECCA9CE44BC8AC", 20);
        _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, var_3, var_4, 0);
      }

      break;
    }
  }
}

_id_13197(var_0, var_1) {
  var_2 = asmdevgetallstates(var_0);
  var_3 = scripts\mp\utility\weapon::getweaponbasenamescript(var_2);
  var_4 = weaponclass(var_3);
  var_5 = "_encstr_84781AA0B74ADEF50BF127A750C227C184AFC8D817FF13AF422595A0" + var_4;
  var_6 = int(max(0, getdvarint(var_5, var_1)));
  var_7 = weaponclipsize(var_0);
  var_8 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_2);

  if(isDefined(var_8)) {
    self.br_ammo[var_8] = 0;

    if(istrue(var_2.should_spawn_boss_one))
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::zone_bounds(var_2, 1);
    else
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, var_8, var_7 * var_6, 0);
  }
}

attempted_to_use_gunship(var_0) {
  switch (var_0) {
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 1;
    default:
      return undefined;
  }
}

totalmuncurrencyearned() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  foreach(var_1 in level.players)
  var_1.shouldfinishshootinglongdeath = 0;

  for(;;) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      if(istrue(var_4.hidesmokinggunhudfromplayer)) {
        continue;
      }
      if(!isDefined(var_4.obj_payload_stage)) {
        continue;
      }
      foreach(var_6 in var_4.obj_payload_stage.touchlist) {
        foreach(var_8 in var_6) {
          foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_8.player.team, var_8.player.squadindex)) {
            if(!isDefined(var_1._id_1227E))
              var_1._id_1227E = 0;

            var_1._id_1227E = var_1._id_1227E + 5;

            if(var_1._id_1227E >= 20) {
              if(!var_1.shouldfinishshootinglongdeath)
                var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_82FE1C325BB8DB46E8F15F5989B18AA7D551CA694088AFFAF0E3442F9B50");

              var_1.shouldfinishshootinglongdeath = 1;
              var_10 = getdvarint("_encstr_A53220F3D8256933FBAFDCC92121BFEDC950DBFA50DB1F8FD2FFFFEECD2B8374D9D8", 18);
              var_11 = int(var_10) * var_1._id_1227E;
              var_1 thread scripts\mp\rank::giverankxp("_encstr_82FE1C325BB8DB46E8F15F5989B18AA7D551CA694088AFFAF0E3442F9B50", var_11, undefined);
              var_1 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::searchradiusidealmax(min(40, var_1._id_1227E) * 1000);
              var_1 thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(var_11, "_encstr_82FE1C325BB8DB46E8F15F5989B18AA7D551CA694088AFFAF0E3442F9B50");
              var_1._id_1227E = 0;
            }
          }
        }
      }
    }

    foreach(var_1 in level.players)
    var_1.shouldfinishshootinglongdeath = 0;

    wait 5;
  }
}

_id_1418C(var_0, var_1) {}

_id_1418D(var_0, var_1, var_2, var_3) {}

vehicle_spawn_mp_gamemodesupportsrespawn() {
  return 1;
}

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(!istrue(game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"]) && !istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    scripts\mp\hud_message::showsplash("_encstr_A31814C493D7C193CAADC21DD81AEBDDACD81BDB6B2B");
}

_id_1365D(var_0) {
  if(istrue(level.dmztut_endgametransition) && isDefined(self.thrust_fx_model) && !istrue(var_0.br_infilstarted)) {
    var_1 = spawnStruct();
    var_0.br_infilstarted = 1;
    var_0._id_1286F = var_0.thrust_fx_model;
    var_0._id_1286F.index = -1;
    var_0 thread _id_126A4(var_1);
  }

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) && isDefined(self.thrust_fx_model))
    return 1;

  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

manage_fakebody_hides() {
  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }

  level.disable_super_in_turret._id_13916 = 0;

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    scripts\mp\deathicons::_id_12BFD();
  else
    _id_143F7();

  _id_1361B();
  level.dmztut_endgametransition = 1;
  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1 thread _id_1255F();
  }

  level thread maxnumsites();

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    wait 2;

  scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  _id_143F8(getdvarfloat("_encstr_8B3B1A5AE910DF5A4ECFABE7AB79B25908F654652190A441244BD78B", 9));

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1 thread _id_1255D();
  }

  scripts\mp\flags::gameflagset("_encstr_A7FC13191DB4928A8E0BC660C587BE3DF146532F6C");
  wait 6.66667;
  waitframe();
  scripts\mp\flags::gameflagset("_encstr_A2D20FE4880D52A426C867576878654BD3");
  waitframe();
  last_unresolved_collision_time();
}

maxnumsites() {
  level endon("_encstr_A2D20FE4880D52A426C867576878654BD3");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!scripts\mp\flags::gameflag("_encstr_A7FC13191DB4928A8E0BC660C587BE3DF146532F6C")) {
      var_0 thread _id_1255F(1);
      continue;
    }

    var_0 thread _id_1255D();
  }
}

_id_143F7() {
  var_0 = gettime() + 10000;

  while(gettime() < var_0 && getactiveclientcount() != level.players.size)
    waitframe();
}

_id_133D6() {
  scripts\mp\flags::gameflagset("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

_id_1361B() {
  var_0 = 8;
  level.disable_super_in_turret.gas_trigger_player_think = [];
  var_1 = int(max(getactiveclientcount(), level.players.size));

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_3 setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    level.disable_super_in_turret.gas_trigger_player_think[level.disable_super_in_turret.gas_trigger_player_think.size] = var_3;

    if((var_2 + 1) % var_0 == 0)
      waitframe();
  }
}

last_unresolved_collision_time() {
  foreach(var_1 in level.disable_super_in_turret.gas_trigger_player_think) {
    if(isDefined(var_1) && !istrue(var_1.inuse))
      var_1 delete();
  }

  level.disable_super_in_turret.gas_trigger_player_think = undefined;
}

_id_1255F(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.cameraent)) {
    return;
  }
  self.br_infilstarted = 1;

  if(istrue(var_0))
    waitframe();

  if(!isDefined(level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()])) {
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_1 setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()] = var_1;
  }

  self.cameraent = level.disable_super_in_turret.gas_trigger_player_think[self getentitynumber()];
  self.cameraent.inuse = 1;

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();

  var_2 = round_enemies_push_logic(self.team, self.squadindex);
  var_3 = level.disable_super_in_turret.paths[var_2];

  if(!isDefined(self._id_13689)) {
    _id_12689(var_3);
    self._id_13689 = _id_1257C(var_3);
  }

  self.cameraent.origin = self._id_13689.origin;
  self.cameraent.angles = _id_1257A(var_3, self.cameraent.origin);
  var_4 = _id_1257B();
  self.cameraent scriptmodelplayanim(var_4, "_encstr_9BFB12B98358DDB9F51B85B6AC27B07D2CE696B5");
  self.cameraent scriptmodelpauseanim(1);
  waittillframeend;
  var_5 = self.cameraent gettagorigin("_encstr_AFAA09344628DA52A72756");
  var_6 = getdvarint("_encstr_BDBE243736C9F5C4277D2D9B2D8EB40B63EBCDD19C2BC26BBE8EB4AD56ED5D47D7E01BBED69B", 12000);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_5, var_6, 1);

  if(!istrue(var_0) && !istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    wait 2.0;

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  self setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  self setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_5, self.cameraent.angles);

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 5);

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  level.disable_super_in_turret._id_13916++;
}

_id_1257A(var_0, var_1) {
  if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0)
    var_2 = var_0.nodes[0].origin - var_1;
  else if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_2 = var_0.nodes[var_0.nodes.size - 1].origin - var_1;
  else
    var_2 = var_0.nodes[0].origin - var_1;

  var_3 = vectortoangles(var_2);
  return (0, var_3[1], 0);
}

_id_1257B() {
  switch (level.disable_super_in_turret._id_1226A) {
    case "_encstr_BD370F28DAD38398C711DDDF0A53217D7A":
      if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
        return "_encstr_912132C42840D60D33598B116BF9AD60D90F1DD61B1E4AB2325741205B1BDDF751AF11D03BD7E1A77F675788199D0980B579281A";
      else
        return "_encstr_8A3A325F40FA5F22EDA00A469BE9CA29D999E74F8889C89A895854BD05BD82CFC1C05F9FB8612FA35768DD32F819B9878D33DB03";

      break;
    case "_encstr_8B1F0C8164E29078A0B989506260":
      if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
        return "_encstr_970332AFE71BF162681EF2BEF2B0A7AA9D1F074FB7EF4B5D82E6AC454B38FF81E6FBAF6F3D076103F0C825CA46991DD95F392FDF";
      else
        return "_encstr_862D3204E411910A2389BB074018CFBA71688F3A46CB1B55C3A1D733A3F3B701D79F1537B673218BF338D753418D55C9E1A45DEF";

      break;
    case "_encstr_AC480657D870D2F2":
      if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
        return "_encstr_B48631175FB359CA30768AD6AA181F7265F7AFE7DFB7F3856A5EC41DE3C057E94E23773765EFC96B48207D62BEB15FC09DBFE7";
      else
        return "_encstr_99A331A5BB70AFC427D7382CBC63BD85327D95E68D0B83950DBEA5DCA39CF6BED885DA2BE458F5B9DD7BF683FA9A7D8833B991";

      break;
    default:
      if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
        return "_encstr_95182C20EFA299323387584B4FFA7D4365A9C82090A2B55F1E57C2491329AFC7D7984F43879A054DD6A7781523A3";
      else
        return "_encstr_956B2C232F7758E872D103394044488F0A27BBA55BBB1839BBB6A8B1AA31913ED37F3FE15F02D5B8D54D7189D20B";

      break;
  }
}

round_enemies_push_logic(var_0, var_1) {
  if(isDefined(level.squaddata[var_0][var_1].time_after_shoot))
    return level.squaddata[var_0][var_1].time_after_shoot;

  if(!isDefined(level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"])) {
    var_2 = relic_squadlink_outline_monitor(var_0);

    if(isDefined(level.teamdata[var_2]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"]))
      level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"] = level.teamdata[var_2]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"];
    else
      level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"] = randomint(level.disable_super_in_turret.paths.size);
  }

  level.squaddata[var_0][var_1].time_after_shoot = level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"];
  level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"]++;

  if(level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"] >= level.disable_super_in_turret.paths.size)
    level.teamdata[var_0]["_encstr_853E0FF5C1A81C51679B8FF3D3376A45D0"] = 0;

  return level.squaddata[var_0][var_1].time_after_shoot;
}

_id_1255D() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.sessionstate != "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258")
    _id_1255F(1);
  else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  _id_1255C();

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 5);

  _id_13185(1);
  var_0 = 1;
  var_1 = 6.66667 - var_0;
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  self clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 1);
  self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 1);
  self clearsoundsubmix("_encstr_AB541D8922C9FD7B6F9F58388757F33373CD7007BF614780358348382B8549", 0.5);
  self clearpredictedstreampos();
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
  self cameralinkTo(self.cameraent, "_encstr_AFAA09344628DA52A72756", 1, 1);
  self.cameraent scriptmodelpauseanim(0);
  thread _id_12560();
  wait(var_1);
  var_2 = angleclamp180(angleclamp180(self.angles[1]) - angleclamp180(self.cameraent.angles[1]));
  self.cameraent rotateYaw(var_2, var_0, 0.1, 0.1);
  wait(var_0);
  thread _id_1255E();
  wait 1;
  self.cameraent delete();
}

_id_12560() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 0.5;
  var_1 = 1.0;
  var_2 = 6.66667 - var_0 - var_1;
  self setsoundsubmix("_encstr_8F121C4B471F30B0DA79BB9198BCA057B27FC3FDABD26191E3CEAD694299");
  wait(var_0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_830E100EC2CB63B75846F577CA36D8DED6B2", self);

  if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
    var_3 = "_encstr_BE5E1DE62219B23218C152CB69D974F2CC877880C07902D9D46A78B137EB9E";

    if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0)
      var_3 = "_encstr_AC89225B403EA8CA13D135AECDB76345A020F7EF4096F4F2757D7DE7A5D57B3728E87B47";

    scripts\mp\hud_message::showsplash(var_3);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_81980E74BDC19F9DC901620A403D1506", self);
  } else {
    var_3 = "_encstr_AC611D9843D78B43EB6DD8D747A1A7915CAF686867BFE151E3D6C6EA1F0BF7";

    if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0)
      var_3 = "_encstr_AB032261B26FB087ABF39793CB91D450E44E48189F87E0C553AF878FE7AB1E398DA4D010";

    scripts\mp\hud_message::showsplash(var_3);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_87C10EC247D10BC65BD7A573E839BDC4", self);
  }

  wait(var_1);
  self setplayermusicstate("_encstr_A77118139C33AF38B09763BD16467DC9F6D5B946BE37E858E4D1");
  wait(var_2);
  self clearsoundsubmix("_encstr_8F121C4B471F30B0DA79BB9198BCA057B27FC3FDABD26191E3CEAD694299", 6);
}

_id_1255C(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AB491873D099C1EA25EF9688E937E264C550E3F7E83770927798");
  self endon("_encstr_AB491873D099C1EA25EF9688E937E264C550E3F7E83770927798");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
  self.forcespawnorigin = self._id_13689.origin;
  self.forcespawnangles = self._id_13689.angles;
  self._id_12CA8 = !game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"];

  if(!isalive(self))
    self._encstr_9316179BB30739809BE3A9BB06477875AB7A31819A4FEB68B2 = 1;

  self.plotarmor = 1;
  scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  waitframe();
  self._id_13689 = undefined;
  self.plotarmor = undefined;
  self._id_12CA8 = undefined;
  self.thrust_fx_model = undefined;
  self freezecontrols(1);
  self playerhide();
}

_id_1255E() {
  self cameraunlink();
  self freezecontrols(0);
  self playershow();

  if(_encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_relic_punchbullets())
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();

  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);

  if(level.disable_super_in_turret._id_13602 > -1)
    thread _id_1253A();

  _id_13185(0);

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    scripts\mp\supers::setsuperbasepoints(0);
    scripts\mp\supers::setsuperextrapoints(0);
  }

  _id_1255B();
}

_id_143F8(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1 && level.disable_super_in_turret._id_13916 < level.players.size)
    waitframe();
}

_id_136AA(var_0) {
  _id_13230();

  foreach(var_2 in level.disable_super_in_turret.paths) {
    _id_1367A(var_2, game["_encstr_991C0AB9ED5B57161FE89B83"], var_0);

    if(level.disable_super_in_turret.convoy)
      _id_1367B(var_2, game["_encstr_991C0AB9ED5B57161FE89B83"], var_0);
  }

  init_relic_doubletap(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  init_relic_doubletap(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  thread _id_13C54();
}

_id_1367A(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = var_0;
  var_5 = undefined;
  var_6 = 0;

  if(level.disable_super_in_turret.convoy)
    var_6 = 1;

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[var_6]) && isDefined(var_0.nodes[var_6 + 1])) {
    var_4 = var_0.nodes[var_6];
    var_5 = var_0.nodes[var_6 + 1];
    var_3 = vectortoangles(var_5.origin - var_4.origin);
  } else if(isDefined(var_0.target)) {
    if(level.disable_super_in_turret.convoy)
      var_4 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_4 = var_0;

    if(isDefined(var_4) && isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 = vectortoangles(var_5.origin - var_4.origin);
    }
  }

  var_7 = spawnStruct();
  var_7.origin = var_4.origin;
  var_7.angles = var_3;
  var_7.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_7.spawnmethod = "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5";
  var_7.team = var_1;
  var_7.player_rig_create = ::_id_1423F;
  var_7.vehicletype = level._id_12283;
  var_7.modelname = "_encstr_97581DC3D70B702675E012EF190E656097B71911176AFEE0196A2B087F5F2A";
  var_7.turretmodel = "_encstr_A6BF24CC9B73BA01977223D1205809E9774338DDFF6A0B87A96D3282CDE5A08823DA5188EA01";
  var_8 = spawnStruct();
  var_9 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(level._id_12281, var_7, var_8);
  var_9.ondeathrespawn = undefined;
  var_9 unmarkkeyframedmover(1);
  var_9 _meth_87C2(1);

  foreach(var_11 in var_9.turrets) {
    var_11 setscriptablepartstate("_encstr_A19A0772BF43C35FD9", "_encstr_BD1805CB69C063");
    _id_136A4(var_11);
  }

  if(istrue(var_2) && level.disable_super_in_turret._id_13DED)
    _id_1360A(var_9);

  if(isDefined(var_5)) {
    var_0.vehicle = var_9;
    var_9.path = var_0;
  }

  var_9 _id_14260(var_0);

  if(isDefined(var_5))
    var_9 thread _id_1422F(var_0);

  return var_9;
}

_id_136A4(var_0) {
  if(getdvarint("_encstr_845D1443F642C9061B3FA993BFA2D870EC412BD91DB4", 1) == 0) {
    return;
  }
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_ABFE2B4B7990E83971130BCF71A8D2D7106D0455D0BA2BF1D5330B635B4DA930282AFD1D89A03FDAA02B5F6FA9");
  var_1 linkTo(var_0, "_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D", (0, 0, 0), (0, 0, 0));
  var_0._id_13E84 = var_1;
}

_id_1360A(var_0) {
  var_1 = (-158, -43, 67);
  var_2 = (0, 0, 0);
  var_3 = 80;
  var_4 = "_encstr_86D724EB1C172077A1D385D7C38A3030FFF4D12045AF40A53AF3B1A1F7B286B0978ADE19ADE0";
  var_5 = &"_encstr_B2AE1E151719CCC8E11F100C6149CC3461E7C7860359C0E96ECE7FF1B859E92D";
  var_6 = "_encstr_961B0FBD525BDB0B5F7F60805FAA851F33";
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_7 setModel("_encstr_93AD1FBDCCCC0D16DC32AFEE6BF56EBA0E0EBDC9A313DB0FEB16C9DAED4E7D13E4");
  var_7 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1, var_2);
  var_7 setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_7 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_BE1A09DBE095E64A32C6CA", 0);
  var_7._id_13F0F = 1;
  var_7.team = game["_encstr_991C0AB9ED5B57161FE89B83"];
  var_7 scripts\mp\equipment\support_box::supportbox_addheadicon(var_4);
  var_7 thread scripts\mp\equipment\support_box::supportbox_makeusable(var_6, var_5);
  var_7 setuserange(var_3);
  var_7 setusefov(90);
  var_7 notsolid();
  setheadiconsnaptoedges(var_7.showdroplocations, var_3);
  setheadiconsnaptoedges(var_7.showemergencyhint, var_3);
  var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel = var_7;
}

_id_14234() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8C0E13437198B1E2F903CF0B7B177AE583FCBD8DCB");
  self endon("_encstr_8C0E13437198B1E2F903CF0B7B177AE583FCBD8DCB");
  self endon("_encstr_8A810D40806B991F5F1958C163A95D");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = canceljoins(undefined, undefined, self.origin, level.disable_super_in_turret._id_1426E);

    foreach(var_2 in var_0) {
      if(issubstr(var_2.type, "_encstr_A36A09876C7957D217B049"))
        var_2 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lastgoodjobplayer();
    }

    waitframe();
  }
}

_id_133E1(var_0) {
  var_1 = self;

  foreach(var_3 in level.disable_super_in_turret.paths) {
    if(isDefined(var_3.vehicle) && _id_11A3E(var_3.vehicle, var_1.origin))
      return 1;

    foreach(var_5 in var_3._id_11F9E) {
      if(isDefined(var_5) && _id_11A3D(var_5, var_1.origin))
        return 1;
    }
  }

  return 0;
}

_id_11A3E(var_0, var_1) {
  var_2 = level.disable_super_in_turret._id_1426E * level.disable_super_in_turret._id_1426E;
  var_3 = distance2dsquared(var_1, var_0.origin);
  return var_3 < var_2;
}

_id_11A3D(var_0, var_1) {
  var_2 = 10000;
  var_3 = distance2dsquared(self.origin, var_0.origin);
  return var_3 < var_2;
}

_id_133DB(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(isDefined(var_2.vehicle) && _id_11A3E(var_2.vehicle, var_0.origin))
      return 1;

    foreach(var_4 in var_2._id_11F9E) {
      if(_id_11A3D(var_4, var_0.origin))
        return 1;
    }
  }

  return 0;
}

_id_1367B(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = undefined;

  if(isDefined(var_0.nodes) && isDefined(var_0.nodes[1])) {
    var_4 = var_0.nodes[1];
    var_3 = vectortoangles(var_4.origin - var_0.origin);
  }

  var_5 = spawnStruct();
  var_5.origin = var_0.origin;
  var_5.angles = var_3;
  var_5.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_5.spawnmethod = "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5";
  var_5.team = var_1;
  var_5.player_rig_create = ::_id_1423F;
  var_5.vehicletype = level._id_12283;
  var_5.modelname = "_encstr_B4BB24CE59D01C7DDAA536FA363723FA6BDA9663DE4699F50E852FC6BD8519AFB1DBE667B72F";
  var_5.turretmodel = "_encstr_A6BF24CC9B73BA01977223D1205809E9774338DDFF6A0B87A96D3282CDE5A08823DA5188EA01";
  var_6 = spawnStruct();
  var_7 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(level._id_12281, var_5, var_6);
  var_7.ondeathrespawn = undefined;
  var_7 _meth_87C2(1);

  foreach(var_9 in var_7.turrets) {
    var_9 setscriptablepartstate("_encstr_A19A0772BF43C35FD9", "_encstr_BD1805CB69C063");
    _id_136A4(var_9);
  }

  if(istrue(var_2)) {
    var_7 _id_13DEC(var_0._id_12358, 0);

    if(level.disable_super_in_turret._id_13DED)
      _id_1360A(var_7);
  }

  if(isDefined(var_4)) {
    var_0.idle_sfx = var_7;
    var_7.path = var_0;
  }

  if(level._id_12281 == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
    var_7 setscriptablepartstate("_encstr_A7D708BA0E769358C859", "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
    var_7 setscriptablepartstate("_encstr_966C0E37C0B3B9320575CA07DE33BA6D", "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
  }

  var_7.uav_getenemyplayersinrange = 1;

  if(isDefined(var_4))
    var_7 thread _id_14236(var_0);

  return var_7;
}

_id_1423F(var_0, var_1) {}

_id_14259(var_0) {
  return !isDefined(self.path);
}

_id_14260(var_0) {
  if(!isDefined(var_0.trigger))
    var_0.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, level.disable_super_in_turret._id_1426E, level.disable_super_in_turret._id_1426D);

  if(!istrue(var_0.trigger.x1loadout)) {
    var_0.trigger enablelinkTo();
    var_0.trigger.x1loadout = 1;
  }

  var_0.trigger linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.trigger.brkillstreakbeginusefunc = 1;

  if(!isDefined(var_0.obj_payload_stage))
    var_0.obj_payload_stage = scripts\mp\gameobjects::createuseobject(self.team, var_0.trigger, [], level.disable_super_in_turret._id_14249);

  var_0.obj_payload_stage.usecondition = ::getlocationnameforpoint;
  var_0.obj_payload_stage.getrandompointincirclewithindistance = 1;
  var_0.obj_payload_stage.nousebar = 1;
  var_0.obj_payload_stage scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_0.obj_payload_stage scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_0.obj_payload_stage scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_0.obj_payload_stage.iconname = self.path.iconname;
  var_0.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
  var_0.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_84F718487789E3377245ED609F8B7748EA5B8118CF3DBBC51AED", "_encstr_861B16BB85BCC1B7D2DC8EBE34C263D1FAE6B2ABE89CB0D8");
  _func_042C(var_0.obj_payload_stage.objidnum, 1);
  playencryptedcinematicforall(var_0.obj_payload_stage.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_0.obj_payload_stage.objidnum, self);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_0.obj_payload_stage.objidnum, var_0.obj_payload_stage.offset3d[2]);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.obj_payload_stage.objidnum, 0);

  if(level._id_12281 == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
    self setscriptablepartstate("_encstr_A7D708BA0E769358C859", "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
    self setscriptablepartstate("_encstr_966C0E37C0B3B9320575CA07DE33BA6D", "_encstr_A5F311F6DF7812C7A85BB70540A3E74B0A1315");
  }

  self.obj_payload_stage = var_0.obj_payload_stage;
}

relic_squadlink_outline_monitor(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return "_encstr_9A8507BA4040188D08";
  else
    return "_encstr_8E8405EA382B2A";
}

_id_14251() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  self notify("_encstr_B63C125437EABB090CCF39309B5D87C1525ECD55");
  self endon("_encstr_B63C125437EABB090CCF39309B5D87C1525ECD55");
  self endon("_encstr_8A810D40806B991F5F1958C163A95D");
  self endon("_encstr_AD75063D571AE108");
  waittillframeend;
  var_0 = getdvarint("_encstr_968025638E42AF1D965E0302CB2050696356141B3269F9841306F9C85310F30B2D91406BEBE2BB", 6000);
  var_1 = getdvarint("_encstr_A9B421B98D277D269CBEC10BF28DDEB046BECEAC435AD8C6B2EB072C5EF59B3658B195", 4);
  var_2 = getdvarint("_encstr_935D2A9BD827D74C9CFA382C2F1BBDC291AF3B2B1A5A1BD8CAAFC82B99B27346AC9CD7072C2FBE37B1856395", 7);
  var_3 = gettime() + var_0;
  var_4 = self.path;
  var_5 = var_4.idle_sfx;
  _id_14247(var_5);
  var_6 = gettime() + 1000;

  for(;;) {
    var_7 = _id_14245(self.team);
    var_8 = _id_14245(relic_squadlink_outline_monitor(self.team));
    _id_14274(var_7, var_8);
    _id_14272();

    if(var_3 < gettime()) {
      var_3 = gettime() + var_0;
      _id_12284(var_7, var_8, var_1, var_2);
    }

    if(gettime() >= var_6) {
      _id_1422C();
      var_6 = gettime() + 1000;
    }

    var_9 = undefined;

    if(istrue(level.disable_super_in_turret._id_1227B))
      var_10 = level.disable_super_in_turret._id_14241;
    else
      var_10 = level.disable_super_in_turret._id_14242;

    var_11 = var_10;
    var_12 = level.disable_super_in_turret._id_1422D;

    if(isDefined(var_5)) {
      var_13 = distance2dsquared(self.origin, var_5.origin);

      if(var_13 < level.disable_super_in_turret.idflags_no_dismemberment) {
        var_11 = level.disable_super_in_turret._id_14243;
        var_12 = level.disable_super_in_turret._id_1422E;
      }
    }

    if(!var_7 && var_8 && !self.carriable_explode) {
      self vehicle_setspeed(var_12);
      self.veh_transmission = "_encstr_8C1F08DAF5A51A223B70";

      if(isDefined(var_5)) {
        if(!istrue(var_5.carriable_fuse_light_watch)) {
          var_5 vehicle_setspeed(level.disable_super_in_turret._id_1422D);
          var_5.veh_transmission = "_encstr_8C1F08DAF5A51A223B70";
        } else
          var_5 vehicle_setspeed(0);
      }

      var_9 = "_encstr_8C1F08DAF5A51A223B70";

      if(isDefined(self.tutonplayerkilled) && isDefined(self.cone)) {
        var_14 = anglesToForward(self.angles) * -1;
        var_15 = vectorNormalize(self.origin - self.cone);
        var_16 = vectordot(var_14, var_15);

        if(var_16 > 0) {
          var_17 = distance(self.cone, self.origin);

          if(var_17 > getdvarfloat("_encstr_87C31DE636C9FAE00B5EB17BC2327DD59B268D7BC6DAEBC8D29BD1589BC695", 2.0)) {
            self.tutonplayerkilled = undefined;
            self.carriable_physics_launch = undefined;
            self.cone = undefined;
          }
        }
      }
    } else if(isDefined(self.tutonplayerkilled)) {
      var_9 = "_encstr_A359083664B761C74F5A";
      self vehicle_setspeed(0);

      if(isDefined(var_5))
        var_5 vehicle_setspeed(0);
    } else if(var_7 && !var_8) {
      self vehicle_setspeed(var_10);
      self.veh_transmission = "_encstr_B42E085325A82CB3F221";
      self.carriable_explode = 0;
      _id_14273();

      if(isDefined(self.carriable_physics_launch)) {
        self.carriable_physics_launch _id_11F9B();
        self.carriable_physics_launch = undefined;
      }

      if(isDefined(var_5)) {
        var_5 vehicle_setspeed(var_11);
        var_5.veh_transmission = "_encstr_B42E085325A82CB3F221";
        var_5.carriable_fuse_light_watch = 0;
      }

      var_9 = "_encstr_B42E085325A82CB3F221";
    } else {
      if(var_7 && var_8)
        var_9 = "_encstr_B85C0AD87B9B8E95CD8E2B46";

      self vehicle_setspeed(0);

      if(isDefined(var_5))
        var_5 vehicle_setspeed(0);
    }

    if(!var_7)
      _id_1425B();

    [var_9, var_19] = _id_14252(var_9);
    var_20 = var_7 > 0;
    _id_11F92(self.path, var_20, var_9, var_19);
    waitframe();
  }
}

_id_14247(var_0) {
  self vehicle_setspeed(level.disable_super_in_turret._id_14242);

  if(isDefined(var_0))
    var_0 vehicle_setspeed(level.disable_super_in_turret._id_14242);

  wait 0.5;
}

_id_14252(var_0) {
  var_1 = relic_amped_last_kill_time(self.path);

  if(var_1 < 0 || !isDefined(var_0) || var_0 != "_encstr_B42E085325A82CB3F221")
    return [var_0, undefined];

  var_2 = self.path;
  var_3 = var_2.getquestreward_checkforvalueoverride[var_1]._id_11EA5;
  var_4 = var_2.nodes[var_3].origin;
  var_5 = distance2dsquared(self.origin, var_4);

  if(var_5 < level.disable_super_in_turret._id_142FE)
    return ["_encstr_A7BA0552987332", var_1 + 1];

  return [var_0, undefined];
}

_id_1423A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B8CC16B38B41C76E6DBA6BC102378C19492A7C1A8BF2682B");
  self endon("_encstr_B8CC16B38B41C76E6DBA6BC102378C19492A7C1A8BF2682B");
  self endon("_encstr_AD75063D571AE108");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_7)) {
      continue;
    }
    if(var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers()) {
      var_7 _id_1423E(self);
      continue;
    }

    if(isDefined(var_7.equipmentref) && var_7.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
      var_7 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 1);
  }
}

_id_1423E(var_0) {
  self._id_12282 = 1;
  self dodamage(self.health, var_0.origin, var_0, var_0);

  if(isDefined(self))
    self._id_12282 = undefined;
}

_id_14274(var_0, var_1) {
  if(!var_0 && var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(relic_squadlink_outline_monitor(self.team));
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_9A2511EE0B9707ED5ACD47D734C2D8D1D2DC76", "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B");
    _id_12206(self.path, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_8419044EB232");
    _id_12206(self.path, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_B29B0550F33591");
    var_2 = scripts\engine\utility::ter_op(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"], "_encstr_A56906E3FF715B40", "_encstr_8D6906D02CD8E889");
    self setscriptablepartstate("_encstr_8ADF0D9A0BB94723B8E316703BDF13", var_2, 0);
    _func_042C(self.obj_payload_stage.objidnum, 0);
    self.status = "_encstr_B69B0589C236B6";
    _id_13190(self.path.script_index, 2);
  } else if(isDefined(self.tutonplayerkilled)) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AD9911DD2CE5077B4BB91DD74CD87B6C5B5619");
    _id_12206(self.path, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_957407BAC223B9F05B");
    _id_12206(self.path, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_957407BAC223B9F05B");
    self setscriptablepartstate("_encstr_8ADF0D9A0BB94723B8E316703BDF13", "_encstr_93B508770F528D90B3DB", 0);
    _func_042C(self.obj_payload_stage.objidnum, 0);
    self.status = "_encstr_A359083664B761C74F5A";
    _id_13190(self.path.script_index, 0);
  } else if(var_0 && !var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_BA7F1308D1E7C287B875D398BB8098BFC3C4C17B7F", "_encstr_BAD20E33CA3FEFA894A62907D8FEF8B5");
    _id_12206(self.path, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_B29B0550F33591");
    _id_12206(self.path, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8419044EB232");
    var_2 = scripts\engine\utility::ter_op(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"], "_encstr_A12E0848AF03B0BD1342", "_encstr_932E08C976223F03CB33");
    self setscriptablepartstate("_encstr_8ADF0D9A0BB94723B8E316703BDF13", var_2, 0);
    _func_042C(self.obj_payload_stage.objidnum, 0);
    self.status = "_encstr_B42E085325A82CB3F221";
    _id_13190(self.path.script_index, 1);
  } else if(var_0 && var_1) {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509");
    _id_12206(self.path, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_957407BAC223B9F05B");
    _id_12206(self.path, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_957407BAC223B9F05B");
    self setscriptablepartstate("_encstr_8ADF0D9A0BB94723B8E316703BDF13", "_encstr_93B508770F528D90B3DB", 0);
    _func_042C(self.obj_payload_stage.objidnum, 0);
    self.status = "_encstr_B85C0AD87B9B8E95CD8E2B46";
    _id_13190(self.path.script_index, 3);
  } else {
    self.obj_payload_stage scripts\mp\gameobjects::setownerteam(self.team);
    self.obj_payload_stage scripts\mp\gameobjects::setobjectivestatusicons("_encstr_84F718487789E3377245ED609F8B7748EA5B8118CF3DBBC51AED", "_encstr_861B16BB85BCC1B7D2DC8EBE34C263D1FAE6B2ABE89CB0D8");
    _id_12206(self.path, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_998806DD1A96D12B");
    _id_12206(self.path, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_998806DD1A96D12B");
    self setscriptablepartstate("_encstr_8ADF0D9A0BB94723B8E316703BDF13", "_encstr_A7C5056BD931D1", 0);
    _func_042C(self.obj_payload_stage.objidnum, 1);
    self.status = "_encstr_A7C5056BD931D1";
    _id_13190(self.path.script_index, 4);
  }

  _id_14272();
}

_id_14272() {
  var_0 = self.path;
  var_1 = _id_14244();
  var_2 = var_1 / var_0._id_13BF1;

  if(var_0.getquestplunderrewardinstance >= 0) {
    var_3 = 0;

    if(var_0.getquestplunderrewardinstance > 0)
      var_3 = var_0.getquestreward_checkforvalueoverride[var_0.getquestplunderrewardinstance - 1].loot_choppers;

    var_4 = var_0.getquestreward_checkforvalueoverride[var_0.getquestplunderrewardinstance].loot_choppers - var_3;
    var_1 = var_1 - var_3;
    var_5 = var_1 / var_4;
  } else
    var_5 = 0;

  _id_1318F(var_0.script_index, var_2);

  if(isDefined(level.teamdata[game["_encstr_991C0AB9ED5B57161FE89B83"]]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_0.script_index]))
    level.teamdata[game["_encstr_991C0AB9ED5B57161FE89B83"]]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_0.script_index].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(var_2, 0);

  if(isDefined(level.teamdata[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_0.script_index]))
    level.teamdata[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_0.script_index].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(var_2, 0);

  var_5 = clamp(var_5, 0, 1);
  objective_setprogress(self.obj_payload_stage.objidnum, var_5);
}

_id_14244() {
  var_0 = self;
  var_1 = var_0.path;

  if(istrue(var_1.hidesmokinggunhudfromplayer))
    return var_1._id_13BF1;

  var_2 = var_1._id_136FC[var_1._id_136FB].points[var_1.initial_enemy_spawner];
  var_3 = var_1._id_136FC[var_1._id_136FB].points[var_1.initial_enemy_spawner + 1];
  var_4 = pointonsegmentnearesttopoint(var_2, var_3, var_0.origin);
  var_5 = distance(var_4, var_2);
  var_6 = var_1._id_136FC[var_1._id_136FB].armsrace_c4_planter_internal[var_1.initial_enemy_spawner];
  var_6 = var_6 + var_5;
  return var_6;
}

_id_14273() {
  var_0 = self;

  if(isDefined(var_0._id_12945) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  var_0._id_12945 = spawnStruct();
  var_0._id_12945.starttime = gettime();
  var_0._id_12945._id_13842 = var_0 _id_14244();
}

_id_1425B() {
  var_0 = self;

  if(!isDefined(var_0._id_12945) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  var_1 = var_0 _id_14244();
  var_2 = var_1 - var_0._id_12945._id_13842;
  var_3 = var_0.path;

  if(var_3._id_119D6 < var_2)
    var_3._id_119D6 = var_2;

  var_4 = gettime() - var_0._id_12945.starttime;
  var_3._id_13BF5 = var_3._id_13BF5 + var_4;
  var_0._id_12945 = undefined;
}

_id_1422C() {
  foreach(var_1 in self.obj_payload_stage.touchlist[game["_encstr_991C0AB9ED5B57161FE89B83"]]) {
    var_2 = var_1.player;
    var_2 scripts\mp\utility\stats::incpersstat("_encstr_ACF5089FF6827199725B", 1);
    var_2 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ACF5089FF6827199725B", var_2.pers["_encstr_ACF5089FF6827199725B"]);
    var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_ACF5089FF6827199725B", var_2.pers["_encstr_ACF5089FF6827199725B"]);
  }

  foreach(var_1 in self.obj_payload_stage.touchlist[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) {
    var_2 = var_1.player;
    var_2 scripts\mp\utility\stats::incpersstat("_encstr_ACF5089FF6827199725B", 1);
    var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_ACF5089FF6827199725B", var_2.pers["_encstr_ACF5089FF6827199725B"]);
  }
}

freight_lift_build(var_0, var_1) {
  var_2 = 0.0000157828;
  var_3 = 3600;
  var_4 = 10;
  var_5 = distance(var_0, var_1);
  var_6 = var_5 * var_2;
  var_7 = max(var_6 / level.disable_super_in_turret._id_14242 * var_3, var_4);
  return var_7;
}

freeze_timer_at_max_time_bomb_vest(var_0, var_1) {
  var_0._id_136FC = [];
  var_0.getquestreward_checkforvalueoverride = [];
  var_0._id_11F9E = [];
  var_0.initial_enemy_spawner = 0;
  var_0._id_136FB = 0;

  if(level.disable_super_in_turret.checkpoint_objective)
    var_0.wait_for_at_least_one_player_spawns_in = [];

  if(level.disable_super_in_turret.convoy) {
    var_0.idflags_penetration_player_only = spawnStruct();
    var_0.idflags_penetration_player_only.points = [];
    var_0.idflags_penetration_player_only.times = [];
  }

  var_2 = var_0.nodes;

  if(!isDefined(var_2) || istrue(var_1)) {
    if(isDefined(var_0.target)) {
      var_3 = var_0;
      var_2 = [var_0];

      for(;;) {
        var_3 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_2[var_2.size] = var_3;

        if(!isDefined(var_3.target)) {
          break;
        }
      }

      var_0.nodes = var_2;
    } else {}
  } else {}

  var_9 = int(var_2.size / 31);
  var_10 = var_2.size - var_9 * 31;

  if(var_10 != 0)
    var_9++;

  var_11 = var_10 > 0 && var_10 < 4;
  var_12 = var_9 - 2;
  var_13 = var_9 - 1;
  var_14 = undefined;

  if(level.disable_super_in_turret.checkpoint_objective)
    var_0.wait_for_at_least_one_player_spawns_in[0] = 0;

  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;

  for(var_21 = 0; var_21 < var_9; var_21++) {
    var_0._id_136FC[var_21] = spawnStruct();
    var_0._id_136FC[var_21].points = [];
    var_0._id_136FC[var_21].times = [];
    var_0._id_136FC[var_21].tv_station_interior_enemy_should_break_stealth_immediately = [];
    var_0._id_136FC[var_21].update_player_enemy_on_death = [];
    var_0._id_136FC[var_21].armsrace_c4_planter_internal = [];
    var_22 = 31;

    if(var_21 == var_12 && var_11)
      var_22 = 27 + var_10;
    else if(var_21 == var_13 && var_10 > 0) {
      if(var_10 >= 4)
        var_22 = var_10;
      else
        var_22 = 4;
    }

    var_23 = 0;

    if(var_21 > 0) {
      var_0._id_136FC[var_21].points[var_23] = var_2[var_16].origin;
      var_0._id_136FC[var_21].times[var_23] = freight_lift_build(var_2[var_16].origin, var_2[var_16].origin);
      var_0._id_136FC[var_21].armsrace_c4_planter_internal[var_23] = var_19;
      var_23++;
      var_22++;
      var_2[var_16]._id_136FB = var_21;
    } else
      var_2[var_21]._id_136FB = var_21;

    for(var_24 = var_23; var_24 < var_22; var_24++) {
      var_25 = var_24;

      if(level.disable_super_in_turret.convoy && var_21 == 0) {
        var_0.idflags_penetration_player_only.points[var_25] = var_2[var_15].origin;
        var_0.idflags_penetration_player_only.times[var_25] = freight_lift_build(var_2[var_16].origin, var_2[var_15].origin);
        var_25 = var_25 - 1;

        if(var_25 == 0)
          var_16 = 1;
      }

      if(!level.disable_super_in_turret.convoy || var_21 > 0 || var_25 >= 0) {
        var_0._id_136FC[var_21].points[var_25] = var_2[var_15].origin;
        var_0._id_136FC[var_21].times[var_25] = freight_lift_build(var_2[var_16].origin, var_2[var_15].origin);
        var_26 = distance(var_2[var_16].origin, var_2[var_15].origin);
        var_19 = var_19 + var_26;
        var_0._id_136FC[var_21].armsrace_c4_planter_internal[var_25] = var_19;

        if(isDefined(var_2[var_15].checkpoint)) {
          var_0._id_136FC[var_21].tv_station_interior_enemy_should_break_stealth_immediately[var_25] = var_17;
          var_0.getquestreward_checkforvalueoverride[var_17] = spawnStruct();
          var_0.getquestreward_checkforvalueoverride[var_17].loot_choppers = var_19;
          var_0.getquestreward_checkforvalueoverride[var_17]._id_11EA5 = var_15;
          var_2[var_15].checkpoint = var_0.getquestreward_checkforvalueoverride[var_17];

          if(level.disable_super_in_turret.checkpoint_objective) {
            var_27 = var_15 - var_20;
            var_28 = int(var_27 * 0.33) + var_20;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_28;
            var_29 = int(var_27 * 0.66) + var_20;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_29;
            var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_15;
            var_20 = var_15;
          }

          var_17++;
        }

        if(isDefined(var_2[var_15].obstacle)) {
          var_0._id_136FC[var_21].update_player_enemy_on_death[var_25] = var_18;

          if(!isent(var_2[var_15].obstacle))
            var_2[var_15].obstacle = init_structs(var_2[var_15].obstacle.origin, var_2[var_15].obstacle.angles);

          var_0._id_11F9E[var_18] = var_2[var_15].obstacle;
          var_0._id_11F9E[var_18].path = var_0;
          var_0._id_11F9E[var_18].dist = var_19;
          var_0._id_11F9E[var_18].index = var_18;
          var_0._id_11F9E[var_18].getquestplunderrewardinstance = var_17;
          var_18++;
        }

        var_16 = var_15;
      }

      var_15++;
    }
  }

  var_30 = var_15 - 1;

  if(level.disable_super_in_turret.checkpoint_objective) {
    var_27 = var_15 - var_20;
    var_28 = int(var_27 * 0.33) + var_20;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_28;
    var_29 = int(var_27 * 0.66) + var_20;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_29;
    var_0.wait_for_at_least_one_player_spawns_in[var_0.wait_for_at_least_one_player_spawns_in.size] = var_30;
  }

  var_0.getquestreward_checkforvalueoverride[var_17] = spawnStruct();
  var_0.getquestreward_checkforvalueoverride[var_17].loot_choppers = var_19;
  var_0.getquestreward_checkforvalueoverride[var_17]._id_11EA5 = var_30;
  var_0._id_13BF1 = var_19;
}

_id_1422F(var_0, var_1) {
  self notify("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 1;
  self.carriable_explode = 1;
  self.tutonplayerkilled = undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  var_0.initial_enemy_spawner = 0;
  var_0._id_136FB = var_1;

  foreach(var_4 in var_0._id_11F9E)
  var_4 _id_11F9C(0);

  thread _id_14251();
  thread _id_1423A();
  thread _id_14234();
  var_6 = 1;

  while(var_0._id_136FB < var_0._id_136FC.size) {
    self startpathnodes(var_0._id_136FC[var_0._id_136FB].points, var_0._id_136FC[var_0._id_136FB].times, 0, 0.5, 0.5, 0, 0, var_2, 1, !var_6, 1, 1);
    var_2 = 0;
    var_6 = _id_14275(var_0, var_6);

    if(unset_relic_gas_martyr()) {
      break;
    }
  }

  self vehicle_setspeed(0);

  if(isDefined(var_0.idle_sfx))
    var_0.idle_sfx vehicle_setspeed(0);

  self notify("_encstr_8A810D40806B991F5F1958C163A95D");
  var_0.hidesmokinggunhudfromplayer = 1;
  var_0 notify("_encstr_8A810D40806B991F5F1958C163A95D");

  if(level.disable_super_in_turret._id_13601)
    var_0._id_13620.hidesmokinggunhudfromplayer = 1;

  _id_1425B();
  loadoutexecutionquip(var_0);

  if(!unset_relic_gas_martyr() && _id_132FD(var_0)) {
    _id_12AA3(var_0);
    var_0.getquestplunderrewardinstance++;
    start_pipe_room_menu();

    if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
      var_7 = relic_amped_monitor();

      foreach(var_9 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)
      var_9 setvalue(var_7);
    }

    var_0 notify("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995");
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();
    getquestrewardgroupstablerewards();
  } else if(!unset_relic_gas_martyr() && level.disable_super_in_turret.brking_oncrateuse)
    player_death(var_0);
}

player_death(var_0) {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_BD6D166A03E0930E90B90711B179D62B915E83220E45B307", undefined, game["_encstr_991C0AB9ED5B57161FE89B83"]);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_A2881C89E4F58358BCD8ED58C8D75836D8EB3A7BEB56DC917D59CDB25BCB", undefined, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.vehicle.obj_payload_stage.objidnum);
  _id_12206(var_0, game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_998806DD1A96D12B");
  _id_12206(var_0, game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_998806DD1A96D12B");
  var_1 = relic_amped_last_kill_time(var_0);
  thread _id_11F92(var_0, 1, "_encstr_A7460B06CA52CF18C9D769262C", var_1 + 1);
  _id_12AA3(var_0);
  var_0.getquestplunderrewardinstance++;
  start_pipe_room_menu();
  _id_1322F(var_0);
  _id_1326A(var_0, var_0.getquestplunderrewardinstance);
  var_0 notify("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995");

  if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
    var_2 = relic_amped_monitor();

    foreach(var_4 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)
    var_4 setvalue(var_2);
  }

  thread _id_12CB8(var_0);

  if(level.disable_super_in_turret._id_121FC)
    thread _id_121FC(var_0);
}

_id_14236(var_0, var_1) {
  self notify("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  self endon("_encstr_96B1117E4DD22017F5C97D2527A0E5E9AF9C4A");
  var_0 endon("_encstr_8A810D40806B991F5F1958C163A95D");
  self endon("_encstr_AD75063D571AE108");
  var_2 = 1;

  if(!isDefined(var_1))
    var_1 = 0;

  self.initial_enemy_spawner = 0;
  self._id_136FB = var_1;
  thread _id_1423A();
  var_3 = 1;

  while(self._id_136FB < var_0._id_136FC.size) {
    if(self._id_136FB == 0) {
      var_4 = var_0.idflags_penetration_player_only.points;
      var_5 = var_0.idflags_penetration_player_only.times;
    } else {
      var_4 = var_0._id_136FC[self._id_136FB].points;
      var_5 = var_0._id_136FC[self._id_136FB].times;
    }

    self startpathnodes(var_4, var_5, 0, 0.5, 0.5, 0, 0, var_2, 1, !var_3, 1, 1);
    var_2 = 0;
    var_3 = _id_14237(var_0, var_4);

    if(unset_relic_gas_martyr()) {
      break;
    }
  }

  self vehicle_setspeed(0);
}

_id_14237(var_0, var_1) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_1.size - 1;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_3);
    var_4 = self._id_136FB == 0 && var_3 == 0;
    self.initial_enemy_spawner = var_3;

    if(var_4) {
      self.carriable_fuse_light_watch = 1;
      continue;
    }

    if(var_3 <= 0) {
      self._id_136FB--;
      self.initial_enemy_spawner = var_1.size - 2;
      return 0;
    } else if(var_3 >= var_2) {
      self._id_136FB++;
      self.initial_enemy_spawner = 0;
      return 1;
    }
  }
}

_id_132FD(var_0) {
  if(level.disable_super_in_turret.brking_oncrateuse) {
    foreach(var_0 in level.disable_super_in_turret.paths) {
      if(!istrue(var_0.hidesmokinggunhudfromplayer))
        return 0;
    }
  }

  return 1;
}

_id_14275(var_0, var_1) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0._id_136FC[var_0._id_136FB];
  var_3 = var_2.points.size - 1;

  if(var_1)
    var_4 = 0;
  else
    var_4 = var_3;

  var_5 = var_1;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_6);
    var_7 = var_0._id_136FB == 0 && var_6 == 0;

    if(!var_7 && var_6 == var_0.initial_enemy_spawner) {
      var_5 = !var_5;
      var_0.initial_enemy_spawner = var_6 - 1;
    } else {
      var_5 = var_7 || var_6 > var_0.initial_enemy_spawner;
      var_0.initial_enemy_spawner = var_6;
    }

    if(isDefined(var_2.update_player_enemy_on_death[var_6])) {
      var_8 = var_2.update_player_enemy_on_death[var_6];
      var_9 = var_0._id_11F9E[var_8];

      if(istrue(var_9.hostdefensefactormod) && var_5) {
        self.tutonplayerkilled = var_9;
        self.cone = var_2.points[var_6];
      } else if(!istrue(var_9.hostdefensefactormod) && var_5)
        var_9 _id_11F9B();
      else if(!istrue(var_9.hostdefensefactormod) && !var_5)
        var_9 _id_11F9C(1);
    }

    if(var_7 || isDefined(var_2.tv_station_interior_enemy_should_break_stealth_immediately[var_6]) && var_6 < var_3) {
      self.carriable_explode = 1;

      if(var_6 > var_4 && isDefined(var_2.tv_station_interior_enemy_should_break_stealth_immediately[var_6])) {
        level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.origin, "_encstr_8218041DF5FA");
        _id_11E6F(var_2.tv_station_interior_enemy_should_break_stealth_immediately[var_6], var_0);
      }
    } else if(var_6 <= 0) {
      var_0._id_136FB--;
      var_0.initial_enemy_spawner = var_0._id_136FC[var_0._id_136FB].points.size - 2;
      return 0;
    } else if(var_6 >= var_3) {
      var_0._id_136FB++;
      var_0.initial_enemy_spawner = 0;
      return 1;
    }

    var_4 = var_6;
  }
}

_id_14245(var_0) {
  if(!isDefined(self.obj_payload_stage))
    return 0;

  return self.obj_payload_stage.numtouching[var_0];
}

_id_125F2(var_0) {
  if(!isDefined(var_0))
    return 0;

  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(isDefined(var_2.trigger) && var_0 istouching(var_2.trigger))
      return 1;
  }

  return 0;
}

_id_13C54() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_841214E475984E37B728BA2311FE1FCAC01D5879C178");
  level endon("_encstr_841214E475984E37B728BA2311FE1FCAC01D5879C178");

  foreach(var_1 in level.disable_super_in_turret.paths)
  var_1.numplayers = [];

  var_3 = game["_encstr_991C0AB9ED5B57161FE89B83"];

  for(;;) {
    foreach(var_1 in level.disable_super_in_turret.paths)
    var_1.numplayers[var_3] = 0;

    foreach(var_7 in level.players) {
      if(!isDefined(var_7) || !isalive(var_7) || var_7.team != var_3) {
        continue;
      }
      var_8 = var_7 _id_12575();
      var_9 = var_7 _id_12576();

      if(isDefined(var_8) && var_9 > gettime()) {
        var_8.numplayers[var_3]++;
        continue;
      }

      var_10 = var_7 _id_1255A();

      if(isDefined(var_10)) {
        var_10.numplayers[var_3]++;
        var_7 _id_12689(var_10);
        var_7 _id_12679();
      }
    }

    var_3 = relic_squadlink_outline_monitor(var_3);
    waitframe();
  }
}

_id_1255A() {
  var_0 = undefined;
  var_1 = undefined;

  if(!isDefined(self.heli_landing_volumes) || self.heli_landing_volumes.size == 0) {
    return;
  }
  foreach(var_3 in level.disable_super_in_turret.paths) {
    var_4 = self.heli_landing_volumes[var_3.label];
    var_5 = var_3.nodes[var_4];
    var_6 = distance2dsquared(var_5.origin, self.origin);
    var_7 = var_4;
    var_8 = var_6;
    var_9 = var_6;

    for(var_10 = var_4 + 1; var_10 < var_3.nodes.size; var_10++) {
      var_11 = var_3.nodes[var_10];
      var_12 = distance2dsquared(var_11.origin, self.origin);

      if(var_12 < var_8) {
        var_7 = var_10;
        var_8 = var_12;
      }

      if(var_12 > var_9) {
        break;
      }

      var_9 = var_12;
    }

    for(var_10 = var_4 - 1; var_10 >= 0; var_10--) {
      var_11 = var_3.nodes[var_10];
      var_12 = distance2dsquared(var_11.origin, self.origin);

      if(var_12 < var_8) {
        var_7 = var_10;
        var_8 = var_12;
      }

      if(var_12 > var_9) {
        break;
      }

      var_9 = var_12;
    }

    self.heli_landing_volumes[var_3.label] = var_7;

    if(!isDefined(var_0) || var_8 < var_1) {
      var_0 = var_3;
      var_1 = var_8;
    }
  }

  return var_0;
}

_id_12679() {
  var_0 = 3500;

  if(getdvarint("_encstr_A79A176606FB6799A2B740B057C47053C2A1D0E0DEC1ED218A", 0) == 0) {
    return;
  }
  if(!scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3")) {
    return;
  }
  var_1 = _id_12575();
  var_2 = self.heli_landing_volumes[var_1.label];
  var_3 = var_1.nodes[var_2];
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(var_2 + 1 >= var_1.nodes.size) {
    var_6 = var_2 - 1;
    var_4 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_6].origin, self.origin);
  } else if(var_2 - 1 < 0) {
    var_6 = var_2 + 1;
    var_4 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_6].origin, self.origin);
  } else {
    var_7 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_2 + 1].origin, self.origin);
    var_8 = pointonsegmentnearesttopoint(var_1.nodes[var_2].origin, var_1.nodes[var_2 - 1].origin, self.origin);
    var_9 = distance2dsquared(self.origin, var_7);
    var_10 = distance2dsquared(self.origin, var_8);

    if(var_10 < var_9) {
      var_4 = var_8;
      var_5 = var_10;
      var_6 = var_2 - 1;
    } else {
      var_4 = var_7;
      var_5 = var_9;
      var_6 = var_2 + 1;
    }
  }

  if(!isDefined(var_5))
    var_5 = distance2dsquared(self.origin, var_4);

  var_11 = getdvarint("_encstr_8EFC1D73C790D18336FE1B320201FF1678D715E96951A7775E73E13AABEF9F", var_0);
  var_12 = var_11 * var_11;
  var_13 = 0;

  if(var_5 > var_12)
    var_13 = 1;

  if(var_13 && !isDefined(self._id_12268)) {
    var_14 = relic_squadlink_outline_monitor(self.team);
    self._id_12268 = scripts\mp\utility\outline::outlineenableforteam(self, var_14, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  } else if(!var_13 && isDefined(self._id_12268)) {
    scripts\mp\utility\outline::outlinedisable(self._id_12268, self);
    self._id_12268 = undefined;
  }
}

_id_12559() {
  self endon("_encstr_84790A10835CDCAF08B7AF2E");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  self._id_12268 = undefined;
}

thankyou_photo() {
  if(!istrue(level.disable_super_in_turret.set_force_aitype_sniper)) {
    return;
  }
  switch (level.mapname) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      _encstr_95E93B6ED8E4A507A3DCE5B607973BB0ADAC3AE51C95B9E5C493F583B0CB63DE1632EB6E0758DD9BB9FAD61CF54C9CF56B2B1B1A16B94B6CCD179DCD8D::initspawns();
      break;
    case "_encstr_8CD508CA98A70FAFC01D":
      _encstr_932033A6C63BCB1B64C77A9033C7311312EF9D2B9A2287A85AEBF1705FB928577A5780B6F2DA474813477868BFFC809D576D043E8E::initspawns();
      break;
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
      _encstr_9B94366E6C274B83D1375EB5C1BC3B2CADB28E2F83566ECB264EFA3858978DDB2C91EB6EE085EE9B6EFA6B0E7DB2CDD816079586B8CE9B8D::initspawns();
      break;
  }

  if(level.disable_super_in_turret._id_13695[game["_encstr_991C0AB9ED5B57161FE89B83"]].size == 0 || level.disable_super_in_turret._id_13695[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].size == 0)
    level.disable_super_in_turret.set_force_aitype_sniper = 0;

  if(level.disable_super_in_turret.set_force_aitype_sniper) {
    _id_1326F(game["_encstr_991C0AB9ED5B57161FE89B83"]);
    _id_1326F(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }
}

play_spotrep_capture_sfx(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = var_0.radius + 50;
  var_2 = anglesToForward(var_0.angles);
  var_0.playergetplunderomnvarbitpackinginfo = var_0.origin + var_2 * var_1;
}

_id_1326F(var_0) {
  var_1 = level.disable_super_in_turret._id_13695[var_0];

  if(isDefined(level.disable_super_in_turret._id_13876))
    var_1 = scripts\engine\utility::array_combine(var_1, level.disable_super_in_turret._id_13876[var_0]);

  foreach(var_3 in var_1) {
    play_smoke_fx(var_3);
    play_spotrep_capture_sfx(var_3);
  }
}

play_smoke_fx(var_0) {
  var_0.heli_landing_volumes = [];

  foreach(var_2 in level.disable_super_in_turret.paths) {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;

    for(var_6 = 0; var_6 < var_2.nodes.size; var_6++) {
      var_7 = var_2.nodes[var_6];
      var_8 = distance2dsquared(var_7.origin, var_0.origin);

      if(!isDefined(var_3) || var_8 < var_4) {
        var_3 = var_6;
        var_4 = var_8;
      }

      if(!isDefined(var_5)) {
        var_5 = var_8;
        continue;
      }

      if(var_8 > var_5) {
        break;
      }
    }

    var_0.heli_landing_volumes[var_2.label] = var_3;
  }
}

_id_1452D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"] = 0;

  if(level.teamdata[var_0]["_encstr_86410DE597333F0B678D9589355988"] == 0) {
    return;
  }
  for(;;) {
    level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"] = gettime() + level.teamdata[var_0]["_encstr_86410DE597333F0B678D9589355988"] * 1000;
    wait(level.teamdata[var_0]["_encstr_86410DE597333F0B678D9589355988"]);
  }
}

runkilltriger(var_0, var_1) {
  if(level.teamdata[var_0]["_encstr_86410DE597333F0B678D9589355988"] == 0)
    return 0;

  if(!isDefined(var_1))
    var_1 = level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"];

  var_2 = max(var_1 - gettime(), 0);
  var_3 = int(var_2 / 1000);
  return var_3;
}

dyn_door(var_0) {
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && istrue(level.disable_super_in_turret._id_12CAA))
    _id_126BB();

  return 1;
}

playerrespawn(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || !istrue(self.br_infilstarted) || isDefined(self.cameraent))
    return 0;

  thread _id_126A4(var_0);
  return 1;
}

_id_126A4(var_0) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(level.debug_safehouse_regroup_start))
    self.class = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1234A();

  var_1 = level.teamdata[self.team]["_encstr_A78C0CCD950FA39456DC0E16DDE6"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

  if(var_2 > 1 && !unset_relic_gas_martyr())
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, undefined, 1);

  headlightright();

  if(unset_relic_gas_martyr())
    level waittill("_encstr_ABA008615A631510C7EA");

  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);
  thread _id_1253A();

  while(!isalive(self))
    waitframe();

  waitframe();
  _id_1255B();
  scripts\mp\utility\outline::outlineenableforteam(self, self.team, "_encstr_8B4E16F6EA47C6D23756F5C8B20E8E1ABE0EB0BCB1DB5819", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_3 = !self calloutmarkerping_getEnt();
  var_4 = gettime();

  if(var_3) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_4 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self.waitingtospawn = 0;
  self freezecontrols(0);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  scripts\mp\damage::resetplayervariables();
}

_id_1255B() {
  if(getdvarint("_encstr_A5A31ADA378A909E6357A012730257A71CD179E0772BF9767C2AE323", 0) != 0)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
  _id_12508();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  thread _id_126AC();
  thread _id_126AD();
  self.warroomtvs = undefined;
}

_id_1369E(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A17D0C78BA323B7B8774B3B97DEB");
  waitframe();
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 4);
  var_1 = var_0;
  var_2 = gettime() + var_1 * 1000;
  self setclientomnvar("_encstr_96FC169BD7814FE8E91BA11BC7CDB30D2A0B5711AFCA9DD0", var_2);
  scripts\engine\utility::_id_143BA(var_0, "_encstr_A17D0C78BA323B7B8774B3B97DEB", "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 0);
}

_id_126AC() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.warroomtvs)) {
    return;
  }
  if(getdvarint("_encstr_954C1B37B14ED7989CAF1C85F2B17B16C8F56E0E58DD9BBE9B83CACAC8", 1) == 0) {
    return;
  }
  if(isbot(self)) {
    return;
  }
  if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
    return;
  }
  var_0 = self.warroomtvs;

  if(isPlayer(var_0) || istrue(var_0.bot_gametype_attacker_limit_for_team)) {
    return;
  }
  var_1 = var_0;

  if(get_bomb_vest_id_vfx(var_1)) {
    while(isalive(self) && !self isonground())
      waitframe();
  }

  if(!isalive(self)) {
    return;
  }
  var_2 = 0;
  var_3 = getdvarint("_encstr_B8F920FF973BB0305AF93B11183C20D732FF774137B3E011730A81E94727301B1A7F", 0);

  if(var_3 == 0) {
    var_4 = getdvarint("_encstr_A58E212BE2E5DFDB38A8303787E9A7C77858FF5B86F81DB7E653DBFF17796E4037C3D8", 290);
    var_5 = var_1.vehicle;
    var_6 = distance(self.origin, var_5.origin);
    var_3 = var_6 / var_4 - getdvarfloat("_encstr_A53425F3D8256933FBAFD8C12B8D3F2EA1A17B3B20F79D8FB3FFD5FD4D8EC3F5CF68934198B9D4", 5);

    if(var_3 < 0)
      var_3 = 0;
  }

  var_7 = getdvarfloat("_encstr_AB671AD6B64BD7291227D040A754C0E352D14EDF8F927976E5A738E0", 0.4);
  thread _id_1369E(var_3);
  var_8 = self.fastcrouchspeedmod;
  self.fastcrouchspeedmod = var_7;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  while(isalive(self) && var_2 < var_3) {
    if(self issupersprinting())
      self refreshsprinttime();

    wait 0.1;
    var_2 = var_2 + 0.1;
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    _id_12E60("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    _id_12E60("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    _id_12E60("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  self.fastcrouchspeedmod = var_8;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

_id_12E60(var_0) {
  if(scripts\mp\utility\perk::_hasperk(var_0))
    scripts\mp\utility\perk::removeperk(var_0);
}

_id_12695() {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self._id_12204;

  if(isbot(self)) {
    if(!isDefined(var_0)) {
      var_0 = respawnfade("_encstr_994C0238");
      _id_12689(var_0);
    }

    return var_0;
  }

  if(getdvarint("_encstr_B2151F32CA26BA9DEBCE6EB1BE9B83B0BB37EBD8347BA58D59BECAE6589836B291", 0) == 1) {
    var_1 = scripts\mp\hud_util::createicon("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", 400, 35);
    var_1.sort = 0;
    var_1.color = relic_doubletap_helper("_encstr_9AED0A14AB406453B68DC3CA");
    var_1.archived = 0;
    var_1.alpha = 0.5;
    var_2 = [];
    var_3 = respawnfade("_encstr_994C0238");
    var_4 = undefined;
    var_5 = undefined;

    if(isDefined(var_3)) {
      var_4 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
      var_4.archived = 0;
      var_4.label = &"_encstr_AC611399C3D78F03E965C8C74FA6EF37717F61F9F7";
      var_4.path = var_3;
      var_4 thread spawndogtagtoken(self, var_3);

      if(isDefined(var_0) && !isPlayer(var_0) && var_3 == var_0)
        var_1.getteamtokenshud = var_4;

      var_2[var_2.size] = var_4;

      if(level.disable_super_in_turret._id_13601 && self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        var_5 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
        var_5.archived = 0;
        var_5.label = &"_encstr_933E1748F9D7726776711F091DD0670A93B91011C17FFEBFCF";
        var_5.path = var_3._id_13620;

        if(isDefined(var_0) && !isPlayer(var_0) && var_3._id_13620 == var_0)
          var_1.getteamtokenshud = var_5;

        var_2[var_2.size] = var_5;
      }
    }

    var_6 = respawnfade("_encstr_8B4C0248");
    var_7 = undefined;
    var_8 = undefined;

    if(isDefined(var_6)) {
      var_7 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
      var_7.archived = 0;
      var_7.label = &"_encstr_A3611305D2A9F9D717A88C7510F696B1764F9547AA";
      var_7.path = var_6;
      var_7 thread spawndogtagtoken(self, var_6);

      if(isDefined(var_0) && !isPlayer(var_0) && var_6 == var_0)
        var_1.getteamtokenshud = var_7;

      var_2[var_2.size] = var_7;

      if(level.disable_super_in_turret._id_13601 && self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        var_8 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2.0);
        var_8.archived = 0;
        var_8.label = &"_encstr_933E1748F9D7726776711F091DD0670A93B91011C17FFEBFCF";
        var_8.path = var_6._id_13620;

        if(isDefined(var_0) && !isPlayer(var_0) && var_6._id_13620 == var_0)
          var_1.getteamtokenshud = var_8;

        var_2[var_2.size] = var_8;
      }
    }

    var_9 = [];

    if(level.disable_super_in_turret._id_13746) {
      var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

      foreach(var_12 in var_10) {
        if(var_12 == self) {
          continue;
        }
        var_13 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
        var_13.archived = 0;
        var_13 setplayernamestring(var_12);
        var_13.player = var_12;
        var_13._id_1284F = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
        var_13._id_1284F.archived = 0;
        var_9[var_9.size] = var_13;
      }
    }

    if(!isDefined(var_1.getteamtokenshud))
      var_1.getteamtokenshud = var_2[0];

    var_15 = undefined;
    scripts\mp\utility\player::_freezecontrols(0, 1, "_encstr_B2440F93B92B2B45A861EFDB11B08C6F5D");
    var_16 = 250;
    var_17 = 300;
    var_18 = undefined;
    var_19 = undefined;
    var_20 = undefined;

    while(!isDefined(var_15)) {
      var_21 = _id_134D7(var_2, var_9);
      var_22 = self getnormalizedmovement();
      var_23 = var_22[0] > 0;
      var_24 = var_22[0] < 0;

      if(isDefined(var_19)) {
        if(gettime() >= var_19 || !var_23 && !var_24)
          var_19 = undefined;
      } else if(var_23)
        var_20 = -1;
      else if(var_24)
        var_20 = 1;

      for(var_25 = 0; var_25 < var_21.size; var_25++) {
        var_26 = var_21[var_25];

        if(var_1.getteamtokenshud == var_26) {
          if(!isDefined(var_26.path) && !isDefined(var_26.player)) {
            var_1.getteamtokenshud = var_2[0];
            var_27 = undefined;
            var_28 = undefined;
            var_18 = undefined;
            var_20 = undefined;
          } else if(isDefined(var_20)) {
            var_29 = var_25 + var_20;

            if(var_29 < 0)
              var_29 = var_21.size - 1;
            else if(var_29 >= var_21.size)
              var_29 = 0;

            var_30 = var_21[var_29];
            var_1.getteamtokenshud = var_30;
            var_1 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_30.yoffset);
            var_20 = undefined;
            var_27 = undefined;
            var_28 = undefined;
            var_19 = gettime() + var_17;
          } else
            var_1 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_26.yoffset);

          break;
        }
      }

      _id_13FE1(var_2, var_9, var_1);
      _id_139D8(var_1.getteamtokenshud.path);
      var_20 = undefined;

      if(self useButtonPressed()) {
        if(isDefined(var_18) && gettime() >= var_18) {
          var_31 = var_1.getteamtokenshud;

          if(isDefined(var_31.path) && !istrue(var_31.path.hidesmokinggunhudfromplayer))
            var_15 = var_31.path;
          else if(isDefined(var_31.player) && isalive(var_31.player) && !issquadmateindanger(var_31.player))
            var_15 = var_31.player;
        } else if(!isDefined(var_18))
          var_18 = gettime() + var_16;
      } else
        var_18 = undefined;

      waitframe();
    }

    self notify("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
    var_1 destroy();

    foreach(var_33 in var_2)
    var_33 destroy();

    foreach(var_33 in var_9) {
      var_33._id_1284F destroy();
      var_33 destroy();
    }

    return var_15;
  } else if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0) {
    _id_13182(0);
    self notify("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
    return respawnfade("_encstr_994C0238");
  } else {
    if(istrue(level.disable_super_in_turret._id_12CAA))
      thread startspectatorview();

    var_15 = undefined;

    while(!isDefined(var_15)) {
      var_3 = respawnfade("_encstr_994C0238");
      thread _id_13621(self, var_3);
      var_6 = respawnfade("_encstr_8B4C0248");
      thread _id_13621(self, var_6);
      self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_37, var_38);

      if(var_37 == "_encstr_958212CDC1C2EEDC7DB1D0DE96C695BE8316D1D0") {
        if(0 == var_38)
          var_0 = respawnfade("_encstr_994C0238");
        else
          var_0 = respawnfade("_encstr_8B4C0248");

        var_15 = var_0;
        _id_13182(0);
      } else if(var_37 == "_encstr_829F11EB9AE930B8613B7F45279B685081F3F0") {
        if(0 == var_38)
          var_0 = respawnfade("_encstr_994C0238");
        else
          var_0 = respawnfade("_encstr_8B4C0248");

        thread playergulaggetrespawnpoint(var_0);
      } else if(var_37 == "_encstr_8A7114B9E016EEB9BE6C437B4BD859BE0E8DC2CB5627") {
        var_15 = scripts\mp\playerlogic::getplayerfromclientnum(var_38);
        _id_13182(0);
      }

      if(isDefined(var_15)) {
        self notify("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
        return var_15;
      }
    }
  }
}

playergulaggetrespawnpoint(var_0) {
  self notify("_encstr_BDFF140CE5FAE1D8477BB0109F63953332C3F3033D22");
  self endon("_encstr_BDFF140CE5FAE1D8477BB0109F63953332C3F3033D22");
  self endon("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(self.playergulagvictorysetcontrols) - gettime();

  if(var_1 > 0)
    wait(var_1);

  self.playergulagvictorysetcontrols = gettime() + 250;
  _id_139D8(var_0);
}

_id_134D7(var_0, var_1) {
  var_2 = -60;
  var_3 = 30;
  var_4 = var_2;
  var_5 = [];

  foreach(var_7 in var_0) {
    var_7 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_4);
    var_5[var_5.size] = var_7;
    var_4 = var_4 + var_3;

    foreach(var_9 in var_1) {
      if(!isDefined(var_9.player)) {
        continue;
      }
      var_10 = var_9.player _id_12575();

      if(var_10 == var_7.path) {
        var_9 scripts\mp\hud_util::setpoint("_encstr_A5AD0568058CE3", "_encstr_A5C407E57585313DB1", 0, var_4);
        var_9._id_1284F scripts\mp\hud_util::setpoint("_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", 0, var_4);
        var_5[var_5.size] = var_9;
        var_4 = var_4 + var_3;
      }
    }
  }

  return var_5;
}

_id_13FE1(var_0, var_1, var_2) {
  var_3 = -60;
  var_4 = 30;
  var_5 = 0;

  foreach(var_7 in var_1) {
    if(!isDefined(var_7.player)) {
      var_7.alpha = 0;
      var_7._id_1284F.alpha = 0;
      continue;
    }

    if(!isalive(var_7.player)) {
      var_7.color = (1, 0, 0);
      var_7._id_1284F.color = (1, 0, 0);
      var_7._id_1284F.label = &"_encstr_97DF164892D7A00A56899E1488F24D41A05D39FA88A80522";
      continue;
    }

    if(issquadmateindanger(var_7.player)) {
      var_7.color = (1, 0, 0);
      var_7._id_1284F.color = (1, 0, 0);
      var_7._id_1284F.label = &"_encstr_A6F81880DA5F91DF1E75B4875DB8DE71A7B110B72F7F99815844";
      continue;
    }

    var_7.color = (0, 1, 1);
    var_7._id_1284F.color = (1, 1, 1);

    if(var_2.getteamtokenshud == var_7) {
      var_7._id_1284F.label = &"_encstr_AF0E1CA6DAF78713C058D9A1F0756FDFE7A7D8A07637CCCB7F71D9C908F7";
      var_5 = 1;
      continue;
    }

    var_7._id_1284F.label = &"_encstr_AF51174892F50A82B2317A1444F2A905285D72D7950AC42911";
  }

  foreach(var_10 in var_0) {
    var_11 = !istrue(var_10.path.hidesmokinggunhudfromplayer);

    if(!var_11)
      var_10.color = (1, 0, 0);

    if(istrue(var_10.path.bot_gametype_attacker_limit_for_team) && var_10.path.path.label == "_encstr_994C0238") {
      if(var_2.getteamtokenshud == var_10 && var_11)
        var_10.label = &"_encstr_8BE41C559B21FFD1B9F504DDEF2789373867D5E76F892FE9EA19EC140574";
      else
        var_10.label = &"_encstr_861C171249AF41A0B298E982225E9A410A7527FA82D7A0924A";

      continue;
    }

    if(istrue(var_10.path.bot_gametype_attacker_limit_for_team) && var_10.path.path.label == "_encstr_8B4C0248") {
      if(var_2.getteamtokenshud == var_10 && var_11)
        var_10.label = &"_encstr_B8691C6D999FF3E8A9A4677920E831D161FFC0BEF06F8F98DB1F916F9353";
      else
        var_10.label = &"_encstr_933E1748F9D7726776711F091DD0670A93B91011C17FFEBFCF";

      continue;
    }

    if(var_10.path.label == "_encstr_994C0238") {
      if(var_2.getteamtokenshud == var_10 && var_11)
        var_10.label = &"_encstr_828C18BD62A7795F913B8F9B33DE9EC1118BA496DEFFF16018E3";
      else
        var_10.label = &"_encstr_AC611399C3D78F03E965C8C74FA6EF37717F61F9F7";

      continue;
    }

    if(var_10.path.label == "_encstr_8B4C0248") {
      if(var_2.getteamtokenshud == var_10 && var_11) {
        var_10.label = &"_encstr_865C182899B71207D6D1BFA9FD3087AA3319707161DF5C07AC2D";
        continue;
      }

      var_10.label = &"_encstr_A3611305D2A9F9D717A88C7510F696B1764F9547AA";
    }
  }
}

issquadmateindanger(var_0) {
  var_1 = 5000;
  var_2 = 3000;
  var_3 = 450;
  var_4 = 200;
  var_5 = gettime();

  if(isDefined(var_0) && (isDefined(var_0.lastdamagetime) && var_0.lastdamagetime + var_1 > var_5) || isDefined(var_0.lasttimedamaged) && var_0.lasttimedamaged + var_1 > var_5)
    return 1;

  if(var_0 isonladder())
    return 1;

  var_0 scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(var_0.recentattackers) && var_0.recentattackers.size > 0)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && var_0.watch_for_players_touching_ground + var_2 > var_5)
    return 1;

  if(isDefined(var_0.watch_for_players_touching_ground) && isDefined(var_0.watch_for_players_regrouping_to_plane) && var_0.watch_for_players_touching_ground > var_0.watch_for_players_regrouping_to_plane || isDefined(var_0.watch_for_players_touching_ground) && !isDefined(var_0.watch_for_players_regrouping_to_plane))
    return 1;

  var_6 = var_0 getspawnbucketforplayer(var_3, var_4, 1);

  if(isDefined(var_6))
    return 1;

  if(isDefined(var_0.vehicle))
    return 1;

  if(var_0 scripts\mp\outofbounds::istouchingoobtrigger())
    return 1;

  var_7 = var_0 _id_12575();

  if(isDefined(var_7)) {
    var_8 = var_7.vehicle;

    if(var_0 istouching(var_7.trigger) && var_8.status == "_encstr_B85C0AD87B9B8E95CD8E2B46")
      return 1;
  }

  if(!var_0 isonground()) {
    var_9 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_0.origin, 0, -200);

    if(var_9["_encstr_A53009A25003666B9818C6"] == 1)
      return 1;
  }

  return 0;
}

respawnfade(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.label == var_0)
      return var_2;
  }

  return undefined;
}

respawn_enemies(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_0 != var_2)
      return var_2;
  }

  return undefined;
}

_id_121FC(var_0) {
  var_1 = respawn_enemies(var_0);

  if(var_1.getquestplunderrewardinstance + 1 < var_0.getquestplunderrewardinstance) {
    foreach(var_3 in level.players) {
      if(!isalive(var_3)) {
        continue;
      }
      var_4 = var_3 _id_12575();

      if(var_4 == var_0 && !isDefined(var_3._id_12276))
        var_3 thread _id_125C5(var_1);
    }
  }
}

_id_125C5(var_0) {
  var_1 = level.disable_super_in_turret._id_121FC;
  var_2 = gettime() + var_1 * 1000;
  scripts\mp\utility\lower_message::_id_1316E("_encstr_AA5514F51A71A00F876A120BAA98BB5D99AB08D9AF19", var_2, var_1);
  wait(var_1);
  _id_125C4(var_0);
}

_id_125C4(var_0) {
  var_1 = "_encstr_A34D1F330AE7A69359E761B31EB1D8F58B02283933677090ECCC51972CA208B747";
  var_2 = 0;
  var_3 = "_encstr_B14B23D596AF8939EB1CD5391BD058CD2B7D5BB41B8D6ED14E5658B6FA3995E638DBE69BB2";
  var_4 = 1;
  self setclientomnvar(var_3, var_4);
  self setclientomnvar(var_1, var_2);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B48D064CB8E8E33A");
  var_5 = var_0;

  if(!isDefined(var_5))
    var_5 = _id_12695();

  if(isPlayer(var_5))
    var_6 = var_5 _id_12575();
  else if(istrue(var_5.bot_gametype_attacker_limit_for_team))
    var_6 = var_5.path;
  else
    var_6 = var_5;

  self.warroomtvs = var_5;
  _id_12689(var_6);

  if(isDefined(self)) {
    var_7 = _id_1257C(var_5);
    self notify("_encstr_BE061A2944C3436B0DB1A72780BB2F7881D0AADF31635AA50ED0ABBB");
    _id_12648(var_7);
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_B48D064CB8E8E33A");
    return 1;
  } else
    return 0;
}

_id_12648(var_0) {
  var_1 = self;
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
  var_3 = 1.0;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_0.origin[0], var_0.origin[1], level.juggheli_spawner_jammer5_3);
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  var_1 playerhide();
  wait(var_3);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
  var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126C3(var_0.origin, var_0.angles);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_81E7093272DCB353B86F77");
  waitframe();
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "_encstr_81E7093272DCB353B86F77");
  var_1 playershow();
  var_1 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_1 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);

  if(level.disable_super_in_turret._id_13602 > -1)
    thread _id_1253A();

  _id_1255B();
}

spawndogtagtoken(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = -1;

  for(;;) {
    if(var_2 != var_1.numplayers[var_0.team]) {
      self setvalue(var_1.numplayers[var_0.team]);
      var_2 = var_1.numplayers[var_0.team];
      _id_1318B(var_1.script_index, var_1.numplayers[var_0.team]);
    }

    waitframe();
  }
}

_id_13621(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = -1;

  for(;;) {
    if(var_2 != var_1.numplayers[var_0.team]) {
      var_2 = var_1.numplayers[var_0.team];
      _id_1318B(var_1.script_index, var_1.numplayers[var_0.team]);
    }

    waitframe();
  }
}

_id_1253A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8C092708BBB0653F370161BB0919075BF85F8370D398AD37673B7AE311662354509537EE71CBB4AB84");

  while(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    waitframe();

  if(self.spawnpos[2] <= 1100)
    thread scripts\cp_mp\parachute::startfreefall(undefined, 0, undefined, undefined, 1, 0, 1);
  else {
    thread scripts\cp_mp\parachute::startfreefall(0, 1, undefined, undefined, 1, 0);
    self skydive_deployparachute();
  }

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && level.disable_super_in_turret._id_13604) {
    self._id_12278 = 1;
    thread _id_126A9();
    var_0 = gettime() + level.disable_super_in_turret._id_13604 * 1000;

    while(!self isonground() && self playerads() < 0.5 && gettime() < var_0)
      waitframe();

    self._id_12278 = undefined;
    self notify("_encstr_8C092708BBB0653F370161BB0919075BF85F8370D398AD37673B7AE311662354509537EE71CBB4AB84");
  }
}

_id_126A9() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8C092708BBB0653F370161BB0919075BF85F8370D398AD37673B7AE311662354509537EE71CBB4AB84");
  self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
  self._id_12278 = undefined;
  self notify("_encstr_8C092708BBB0653F370161BB0919075BF85F8370D398AD37673B7AE311662354509537EE71CBB4AB84");
}

embassy_level_init() {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::onspawnplayer();

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
}

emp_drone_should_take_damage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self clearpredictedstreampos();
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) || scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
}

emp_drone_proximity_explode(var_0, var_1) {
  var_2 = 4.0;
  var_3 = 3.0;
  var_4 = var_2 + var_3;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_proximity_explode(var_0);
    return;
  }

  if(self calloutmarkerping_getEnt()) {
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
    return;
  }

  self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 1);

  if(unset_relic_gas_martyr())
    level waittill("_encstr_ABA008615A631510C7EA");

  thread emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    if(!isDefined(var_1))
      var_1 = 0;

    var_5 = runkilltriger(self.team, var_1);
    var_6 = var_5 > 0;
    var_7 = undefined;
    var_8 = max(var_5 - var_4, 0);

    if(var_6) {
      var_7 = var_5 * 1000;
      var_9 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

      if(var_9 == 1) {
        self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", self getentitynumber());
        _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
        _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(self.origin + (0, 0, 100), self.angles);
        scripts\mp\spectating::setdisabled();
        scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_7));
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_7));
      wait(var_8);
    }

    var_10 = gettime();
    var_11 = _id_12695();

    if(isPlayer(var_11)) {
      var_12 = var_11 _id_12575();
      var_11 thread scripts\mp\rank::giverankxp("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778", 20);
      var_11 thread scripts\mp\rank::scoreeventpopup("_encstr_A5A31E9E15C1071F02645812A2316FAF0D5E6980532B28607A6ACB27C9C85778");
    } else if(istrue(var_11.bot_gametype_attacker_limit_for_team))
      var_12 = var_11.path;
    else
      var_12 = var_11;

    if(istrue(var_12.hidesmokinggunhudfromplayer)) {
      var_12 = respawn_enemies(var_12);
      var_11 = var_12;

      if(istrue(var_12.hidesmokinggunhudfromplayer))
        level waittill("_encstr_ABA008615A631510C7EA");
    }

    self.warroomtvs = var_11;
    _id_12689(var_12);
    var_13 = (gettime() - var_10) / 1000.0;
    _id_126BC(var_11, var_8, var_13, var_5, var_6, var_7);
  } else {
    self.thrust_fx_model = undefined;
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

_id_126BC(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A685148308376FD7933FD4DA7BB09D9B6D83FB1AF318");
  self endon("_encstr_A685148308376FD7933FD4DA7BB09D9B6D83FB1AF318");
  self._id_12276 = 1;
  self._id_1286F = _id_1257C(var_0);

  if(isDefined(self._id_1286F))
    self._id_1286F.index = -1;

  var_6 = getdvarint("_encstr_A98E20C8132B69065B488CA6C807FF0FC5772273063B6A6F107F0D17D7C8643F02E3", 9000);
  var_7 = self._id_1286F.origin;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_7, var_6, 1, 0, var_5);
  var_8 = 1.0;
  var_9 = 0.25;
  var_10 = var_8 - var_9;
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::fadeoutin(var_8);
  wait(var_10);
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_7, self._id_1286F.angles);
  scripts\mp\spectating::setdisabled();

  if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) == 0)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_7[0], var_7[1], level.juggheli_spawner_jammer5_3);

  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  wait(var_9);

  if(var_4) {
    var_11 = max(var_3 - var_1 - var_2 - var_8, 0);
    wait(var_11);

    if(self._id_12276 > 1)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
    else
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  } else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  self._id_12276 = undefined;
}

_id_12006() {
  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) || scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3")) {
    var_0 = round_enemies_push_logic(self.team, self.squadindex);
    var_1 = level.disable_super_in_turret.paths[var_0];
    _id_12689(var_1);
    self._id_13689 = _id_1257C(var_1);
    return self._id_13689;
  }
}

get_bomb_vest_id_vfx(var_0) {
  if(level.disable_super_in_turret._id_13602 < 0)
    return 0;

  if(!isDefined(var_0.getquestplunderrewardinstance))
    return 1;

  return var_0.getquestplunderrewardinstance <= level.disable_super_in_turret._id_13602;
}

_id_1257C(var_0) {
  var_1 = var_0;

  if(isPlayer(var_0))
    var_1 = var_0 _id_12575();
  else if(istrue(var_0.bot_gametype_attacker_limit_for_team))
    var_1 = var_0.path;

  var_2 = self.team == game["_encstr_991C0AB9ED5B57161FE89B83"] && get_bomb_vest_id_vfx(var_1) || istrue(var_0.bot_gametype_attacker_limit_for_team);

  if(level.disable_super_in_turret.set_force_aitype_sniper && !var_2) {
    if(isPlayer(var_0)) {
      _id_1252E(var_0);
      [var_4, var_5] = var_0 _id_1256C(var_0.origin, var_0.angles);
    } else
      var_4 = _id_1256A(var_1);

    if(isDefined(var_4))
      return var_4;
  }

  var_6 = var_1._id_136FC[var_1._id_136FB].points[var_1.initial_enemy_spawner];

  if(var_2)
    [var_8, var_9] = _id_1257F(var_1);
  else if(level.disable_super_in_turret._id_129CB)
    [var_8, var_9] = _id_12578(var_1);
  else {
    var_11 = var_1._id_136FC[var_1._id_136FB].points[var_1.initial_enemy_spawner + 1];
    var_12 = vectorNormalize(var_11 - var_6);

    if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
      var_13 = level.disable_super_in_turret._id_13633;
      var_9 = level.disable_super_in_turret._id_13660;
      var_14 = level.disable_super_in_turret._id_1368F;
    } else {
      var_13 = level.disable_super_in_turret._id_13632;
      var_9 = level.disable_super_in_turret._id_1365F;
      var_14 = level.disable_super_in_turret._id_1368E;
      var_12 = var_12 * -1;
    }

    var_15 = var_6 + var_12 * var_13;
    var_16 = (0, randomintrange(0, 360), 0);
    var_17 = randomfloat(var_14);
    var_18 = anglesToForward(var_16) * -1;
    var_19 = var_18 * var_17;
    var_8 = var_15 + var_19;
  }

  if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_8, 0)) {
    var_8 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::_id_1342E(var_6, var_8);
    var_20 = vectorNormalize(var_6 - var_8);
    var_8 = var_8 + var_20 * 100;
  }

  if(level.disable_super_in_turret.start_drones_event) {
    var_21 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
    var_22 = scripts\engine\trace::ray_trace_ents(var_8, var_6, [var_1.start_drones_event], var_21);

    if(var_22["_encstr_A53009A25003666B9818C6"] < 1.0)
      var_8 = var_22["_encstr_BD260953AA97E3F014279D"];
  }

  var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_8);
  var_16 = vectortoangles(var_6 - var_8);
  var_4 = spawnStruct();
  var_4.origin = var_8 + (0, 0, var_9);
  var_4.angles = var_16;
  var_4.height = var_9;
  return var_4;
}

_id_1257F(var_0) {
  var_1 = 21;
  var_2 = 11;
  var_3 = 50;
  var_4 = isDefined(level.disable_super_in_turret._id_13876) && isDefined(self.cameraent);
  var_5 = var_2;

  if(var_4)
    var_5 = var_1;

  var_6 = _id_1256A(var_0, 1, var_5);
  var_7 = var_0.spawncount[self.team];
  var_8 = var_7 % 2 == 0;
  var_9 = int(var_7 / 2);
  var_10 = var_9 * var_3;
  var_11 = var_6.origin;

  if(var_8) {
    var_12 = anglestoright(var_6.angles);
    var_11 = var_6.origin + var_12 * var_10;
  } else {
    var_13 = anglestoleft(var_6.angles);
    var_11 = var_6.origin + var_13 * var_10;
  }

  return [(var_11[0], var_11[1], 0), level.disable_super_in_turret._id_1365F];
}

_id_12578(var_0) {
  var_1 = 20;
  var_2 = 1;
  var_3 = getdvarfloat("_encstr_8E7C1D6ED89CBEC4397D38852F63ED2C23F56E380BEECDD72356B3932BB237", var_1);
  var_4 = getdvarfloat("_encstr_8E7C1D6ED89CBEC4397D38852F63ED2C23F56E380BEECDD72356B3932BB237", var_2);
  var_5 = var_0._id_136FC[var_0._id_136FB].points[var_0.initial_enemy_spawner];

  if(!isDefined(var_0._id_13603) || var_0._id_13603 != var_0.initial_enemy_spawner) {
    var_6 = var_0._id_136FC[var_0._id_136FB].points[var_0.initial_enemy_spawner + 1];
    var_7 = vectorNormalize(var_6 - var_5);
    var_0._id_13603 = var_0.initial_enemy_spawner;
    var_0._id_136B6 = vectortoyaw(var_7);
    var_0._id_136B5 = vectortoyaw(-1 * var_7);
    var_0._id_136B8 = -1 * var_3;
    var_0._id_136B7 = -1 * var_3;
  }

  if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
    var_8 = level.disable_super_in_turret._id_13633;
    var_9 = level.disable_super_in_turret._id_13660;
    var_10 = level.disable_super_in_turret._id_1368F;
    var_11 = var_0._id_136B6 + var_0._id_136B8;
    var_0._id_136B8 = var_0._id_136B8 + var_4;

    if(var_0._id_136B8 > var_3)
      var_0._id_136B8 = -1 * var_3;
  } else {
    var_8 = level.disable_super_in_turret._id_13632;
    var_9 = level.disable_super_in_turret._id_1365F;
    var_10 = level.disable_super_in_turret._id_1368E;
    var_11 = var_0._id_136B5 + var_0._id_136B7;
    var_0._id_136B7 = var_0._id_136B7 + var_4;

    if(var_0._id_136B7 > var_3)
      var_0._id_136B7 = -1 * var_3;
  }

  var_12 = var_5[0] + var_8 * cos(var_11);
  var_13 = var_5[1] + var_8 * sin(var_11);
  return [(var_12, var_13, 0), var_9];
}

_id_1256A(var_0, var_1, var_2) {
  var_3 = self.team;
  var_4 = isDefined(level.disable_super_in_turret._id_13876) && isDefined(self.cameraent);

  if(isDefined(var_0.getquestplunderrewardinstance))
    var_5 = var_0.getquestplunderrewardinstance;
  else
    var_5 = 0;

  var_6 = var_0.initchallengeandeventglobals;

  if(!isDefined(var_0._id_13695[var_3]) || var_5 != var_0._id_1361E[var_3] || !var_4 && istrue(var_0._id_13874)) {
    if(var_4) {
      var_0._id_13695[var_3] = scripts\engine\utility::array_randomize(remove_dko_spawnflags(var_3, var_6));
      var_0._id_13874 = 1;
    } else {
      var_0._id_13695[var_3] = scripts\engine\utility::array_randomize(remove_crusader_class(var_3, var_6, var_5));
      var_0._id_13874 = 0;
    }

    if(var_0._id_13695[var_3].size == 0) {
      iprintlnbold("_encstr_A7E31F9A977193D3C3767807CDB00B83D1B3884AF017F602C051B38F2EE1062C58");
      return;
    }

    var_0._id_13663[var_3] = randomint(var_0._id_13695[var_3].size);
    var_0.spawncount[var_3] = 0;
    var_0.spawntime[var_3] = gettime();
    var_0._id_1361E[var_3] = var_5;
  }

  if(var_0._id_13695[var_3].size == 0)
    iprintlnbold("_encstr_A7E31F9A977193D3C3767807CDB00B83D1B3884AF017F602C051B38F2EE1062C58");
  else {
    var_7 = var_0._id_13663[var_3];
    var_8 = var_0._id_13695[var_3][var_7];

    if(!isDefined(var_2)) {
      var_2 = level.disable_super_in_turret.set_force_aitype_shotgun;

      if(isDefined(var_8.radius) && var_8.radius < 200)
        var_2 = var_2 / 2;
    }

    if(var_0.spawntime[var_3] + 3000 < gettime() || var_0.spawncount[var_3] >= var_2) {
      var_0.spawncount[var_3] = 0;
      var_0._id_13663[var_3]++;

      if(var_0._id_13663[var_3] >= var_0._id_13695[var_3].size)
        var_0._id_13663[var_3] = 0;

      var_7 = var_0._id_13663[var_3];
      var_8 = var_0._id_13695[var_3][var_7];
    }

    if(!isDefined(var_8.angles))
      var_8.angles = (0, 0, 0);

    _id_1252E(var_8);

    if(istrue(var_1)) {
      var_0.spawntime[var_3] = gettime();
      var_0.spawncount[var_3] = var_0.spawncount[var_3] + 1;
      return var_8;
    }

    [var_10, var_11] = _id_1256C(var_8.origin, var_8.angles, var_0.spawncount[var_3]);
    var_12 = var_8.playergetplunderomnvarbitpackinginfo - var_10.origin;
    var_10.angles = vectortoangles(var_12);
    var_0.spawntime[var_3] = gettime();
    var_0.spawncount[var_3] = var_11 + 1;
  }
}

_id_1256C(var_0, var_1, var_2, var_3) {
  var_4 = 32;
  var_5 = 8;
  var_6 = 50;
  var_7 = 20;
  var_8 = 5;
  var_9 = -200;

  if(!isDefined(var_2))
    var_2 = 0;

  var_10 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_11 = isscriptabledefined() && getdvarint("_encstr_ABEC1D7358A5E9B37B805841AB80BFAE2121FBBBA0771D0F90F746754D8B6B", 1);
  var_12 = 0;
  var_13 = 0;
  var_14 = var_2;

  for(;;) {
    var_15 = remove_closest_chopper_boss_vandalize_node_down(var_0, var_1[1], var_14);

    if(var_11 && !ispointonnavmesh(var_15))
      var_15 = getclosestpointonnavmesh(var_15);

    var_16 = var_15 + (0, 0, var_7);
    var_17 = var_15 + (0, 0, var_9);
    var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
    var_12++;

    if(var_18["_encstr_A53009A25003666B9818C6"] == 0) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_16 = var_15 + (0, 0, var_6);
      var_17 = var_15 + (0, 0, var_9);
      var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
      var_12++;
    }

    if(var_18["_encstr_A53009A25003666B9818C6"] == 0) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_16 = var_15 + (0, 0, var_8);
      var_17 = var_15 + (0, 0, var_9);
      var_18 = scripts\engine\trace::player_trace(var_16, var_17, var_1, self, var_10);
      var_12++;
    }

    if(var_18["_encstr_A53009A25003666B9818C6"] > 0 && var_18["_encstr_A53009A25003666B9818C6"] != 1) {
      if(!istrue(var_3) && var_12 >= var_5) {
        var_12 = 0;
        waitframe();
      }

      var_19 = var_0 + (0, 0, 60);
      var_20 = var_18["_encstr_BD260953AA97E3F014279D"] + (0, 0, 60);
      var_21 = scripts\engine\trace::ray_trace(var_19, var_20, self, var_10);
      var_12++;

      if(var_21["_encstr_A53009A25003666B9818C6"] != 1) {
        if(!istrue(var_3) && var_12 >= var_5) {
          var_12 = 0;
          waitframe();
        }

        var_19 = var_0 + (0, 0, 25);
        var_20 = var_18["_encstr_BD260953AA97E3F014279D"] + (0, 0, 60);
        var_21 = scripts\engine\trace::ray_trace(var_19, var_20, self, var_10);
        var_12++;
      }

      if(var_21["_encstr_A53009A25003666B9818C6"] == 1) {
        var_22 = spawnStruct();
        var_22.origin = var_18["_encstr_BD260953AA97E3F014279D"];
        var_22.angles = var_1;
        var_22.height = 0;
        return [var_22, var_14];
      }
    }

    var_14++;
    var_13++;

    if(var_13 >= var_4) {
      var_15 = var_0;

      if(var_11 && !ispointonnavmesh(var_15))
        var_15 = getclosestpointonnavmesh(var_15);

      var_22 = spawnStruct();
      var_22.origin = var_15;
      var_22.angles = var_1;
      var_22.height = 0;
      return [var_22, var_2];
    }

    if(!istrue(var_3) && var_12 >= var_5) {
      var_12 = 0;
      waitframe();
    }
  }
}

_id_1252E(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths)
  self.heli_landing_volumes[var_2.label] = var_0.heli_landing_volumes[var_2.label];
}

remove_dko_spawnflags(var_0, var_1) {
  var_2 = level.disable_super_in_turret._id_13876[var_0];
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5.script_group == var_1)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

remove_crusader_class(var_0, var_1, var_2) {
  var_3 = level.disable_super_in_turret._id_13695[var_0];
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6.script_group == var_1 && var_6.script_index == var_2)
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

remove_closest_chopper_boss_vandalize_node_down(var_0, var_1, var_2) {
  var_3 = 10;
  var_4 = 100.0;
  var_5 = 100.0;
  var_6 = 90;
  var_7 = 10.0;
  var_8 = 360.0 / var_3;
  var_9 = int(var_2 / var_3);
  var_10 = var_2 - var_9 * var_3;
  var_11 = var_1 + var_6 + (var_10 * var_8 + var_9 * var_7);
  var_12 = var_4 + var_9 * var_5;
  var_13 = (0.0, var_11, 0.0);
  var_14 = anglesToForward(var_13);
  var_15 = var_0 + var_14 * var_12;
  return var_15;
}

respawnheightoverride(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.script_index == var_0)
      return var_2;
  }
}

respawndelayoverride(var_0) {
  foreach(var_2 in level.disable_super_in_turret.paths) {
    if(var_2.initchallengeandeventglobals == var_0)
      return var_2;
  }
}

isused(var_0, var_1) {
  level notify("_encstr_999E111435122B1409834F83A23D72F9847C48");
  level endon("_encstr_999E111435122B1409834F83A23D72F9847C48");

  for(;;)
    waitframe();
}

_id_12689(var_0) {
  var_1 = 500;

  if(isDefined(self._id_12204) && self._id_12204 == var_0) {
    return;
  }
  var_2 = self._id_12204;
  self._id_12204 = var_0;
  self._id_12202 = gettime() + var_1;
  _id_13181(var_0.label != "_encstr_994C0238");
}

_id_12575() {
  return self._id_12204;
}

_id_12576() {
  return self._id_12202;
}

modifyplayerdamage(var_0) {
  var_1 = var_0.damage;

  if(istrue(self._id_12279) || istrue(self._id_12278)) {
    var_1 = 0;

    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker))
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("_encstr_994F100430B86B13BFE7BB3B15509BB5D83B");
  }

  if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_2 = isDefined(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers() && istrue(var_0.attacker._id_12282);

    if(var_2)
      var_1 = int(min(var_1, level.disable_super_in_turret._id_11B58));
  }

  if(isDefined(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::nuke_vault_suicidebombers() && isDefined(var_0.attacker.path))
    var_1 = 0;

  if(getdvarint("_encstr_BDA61E2F47EB60C0AA09EBC1A86C70A7624F9B8FF3813430DE5D71BBD94C28EC", 1) && isDefined(var_0.victim.set_thirdperson)) {
    if(isPlayer(var_0.attacker) && scripts\engine\utility::isbulletdamage(var_0.meansofdeath) && var_1 < 100) {
      var_3 = var_0.idflags &level.idflags_penetration;
      var_4 = scripts\mp\utility\damage::isheadshot(var_0.shitloc, var_0.meansofdeath, var_0.attacker);
      var_5 = weaponclass(var_0.objweapon) == "_encstr_A1100738A33A638123";

      if(var_3)
        var_1 = var_1 * level.set_total_successful_vehicle_spawns_from_module;
      else if(!var_4 || !var_5)
        var_1 = var_1 * level.set_tier_lights;
    }
  }

  return var_1;
}

_id_1226B(var_0, var_1) {
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    var_2 = var_0.attacker;

    if(!isDefined(var_2) || !isPlayer(var_2)) {
      if(isDefined(var_0.attacker) && isDefined(var_0.attacker.owner) && isPlayer(var_0.attacker.owner))
        var_2 = var_0.attacker.owner;
      else if(isDefined(var_0.inflictor) && isPlayer(var_0.inflictor))
        var_2 = var_0.inflictor;
      else if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.owner) && isPlayer(var_0.inflictor.owner))
        var_2 = var_0.inflictor.owner;
      else
        var_2 = undefined;
    }

    if(isDefined(var_2) && var_2 != self) {
      var_3 = 0;

      if(var_2.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
        var_3 = getdvarint("_encstr_A59A2753E632B9766B2FB9A38FB2C880FC71994BCB89E0BA72F3EFBF275A8129805602A6B2F3B8E1AA", 4);
      else
        var_3 = getdvarint("_encstr_A9F72786E61B87794257A010F7641033A201F5053FC25DE13D8BD1485F8C48178B36F380D2DA0B28E5", 3);

      if(_id_125F2(var_2))
        var_3 = var_3 + 4;

      _id_12261(var_2, var_3, "_encstr_867D0D6FB7AB09F03998EF8CFBBA40");
    }
  }

  return _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_damage_monitor(var_0, var_1);
}

playerdropplunderondeath(var_0, var_1) {
  if(self.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(getdvarint("_encstr_8F1D24DB16EBDF067D698B92B0A9BDDFC190515435D1670C0B38617B63A3B58359EEDCEAC05B", 1) == 0)
      return 1;

    var_2 = getdvarint("_encstr_85FA226F966321CDFBCE830FA02948298C7FD990CBF3CF10D54E5FEBA7B365EF10221A0F", 7.0);
    var_3 = getdvarint("_encstr_8CD5212B1BFDC19B43A87099536867960949B2D320B386E79926578467B26F9CABD87A", 0.0);
    var_4 = getdvarint("_encstr_AD9F2270679A0E25FB01F777E07277B1F4FF78C0832141CF5272788D3A7A913B509F68F0", 0.0);
  } else {
    if(getdvarint("_encstr_B2CD24AFC0FB1EFAC67731DFCFB0B76EFBF04FE099E57D113FCB6EA90D1758AD4253332A68E8", 1) == 0)
      return 1;

    var_2 = getdvarint("_encstr_BD8E22026E05118AA3093B87C0984F3AF1E84F3F44437AD469488FC728F33D43411F52B7", 7.0);
    var_3 = getdvarint("_encstr_8D09216E8DC9EB4C27BE38B0CBB1EDB023F5195699B2379159E4FA4758E16E3485E4AC", 0.0);
    var_4 = getdvarint("_encstr_8FE722B3E9BEF7169327D0C943D81D57ED06BA5AD19DFB4F4065C7D42D98E2D7037953C2", 0.0);
  }

  if(isDefined(self.plundercount) && self.plundercount > 0)
    var_5 = self.plundercount;
  else {
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(0, var_0);
    return 1;
  }

  var_6 = var_2 + var_3 + var_4;
  var_7 = var_2 / var_6;
  var_8 = int(max(var_5 - 5, int(min(var_5, max(2, int(var_5 * var_7))) + 0.5)));
  var_9 = int(var_5 - var_8);
  var_10 = max(1, var_3 + var_4);
  var_11 = var_3 / var_10;
  var_12 = var_4 / var_10;
  var_13 = int(max(0, int(var_9 * var_12)));
  self.plundercountondeath = var_8;
  var_14 = spawnStruct();
  var_14._id_133E4 = 1;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_8, var_14);

  if(var_13 <= 0)
    return 1;

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_13, var_0);
  return 1;
}

_id_12284(var_0, var_1, var_2, var_3) {
  if(!level.disable_super_in_turret._id_1225F) {
    return;
  }
  if(var_0) {
    var_4 = self.obj_payload_stage.touchlist[self.team];
    _id_12262(var_4, var_2, "_encstr_B14A11D95634A5B18D597D3A4BC6DA7D0BD1A3");
  }

  if(var_1 || isDefined(self.tutonplayerkilled)) {
    var_4 = self.obj_payload_stage.touchlist[game["_encstr_B6A70A23CA6659DC91CAE4DC"]];
    _id_12262(var_4, var_3, "_encstr_B14A11D95634A5B18D597D3A4BC6DA7D239533");
  }
}

_id_12262(var_0, var_1, var_2) {
  var_3 = getdvarfloat("_encstr_91F1207BB64B7F661D09EB22700DDF2FE330E7E8DBD0DFE1C788A2EA606B93D79884", 0.4);
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(isbot(var_6.player) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    var_7 = var_1;

    if(!scripts\mp\utility\player::isreallyalive(var_6.player))
      var_7 = int(max(var_1 * var_3, 1));

    if(!isDefined(var_6.player.plundercount))
      var_6.player.plundercount = 0;

    var_6.player _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_7);
    level.br_plunder._id_12784 = level.br_plunder._id_12784 + var_7;
    var_6.player _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(var_6.player, var_2, var_7);
  }
}

_id_12261(var_0, var_1, var_2) {
  var_3 = getdvarfloat("_encstr_91F1207BB64B7F661D09EB22700DDF2FE330E7E8DBD0DFE1C788A2EA606B93D79884", 0.5);
  var_4 = 0;

  if(isbot(var_0) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
    return;
  }
  var_5 = var_1;

  if(!scripts\mp\utility\player::isreallyalive(var_0))
    var_5 = int(var_1 * var_3);

  if(!isDefined(var_0.plundercount))
    var_0.plundercount = 0;

  var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_5);
  level.br_plunder._id_12784 = level.br_plunder._id_12784 + var_5;
  var_0 _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(var_0, var_2, var_5);
}

totalcollecteditems() {
  if(!level.disable_super_in_turret._id_136C4) {
    return;
  }
  foreach(var_1 in level.disable_super_in_turret.paths) {
    [var_3, var_4] = _id_11F46(var_1);
    var_1._id_136C3 = [];
    var_1._id_136C3[game["_encstr_991C0AB9ED5B57161FE89B83"]] = [];
    var_1._id_136C3[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = [];

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_6 = init_trap_room_wave(var_1);
      var_1._id_136C3[game["_encstr_991C0AB9ED5B57161FE89B83"]][var_5] = var_6;
    }

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = init_trap_room_wave(var_1);
      var_1._id_136C3[game["_encstr_B6A70A23CA6659DC91CAE4DC"]][var_5] = var_6;
    }
  }

  if(istrue(level.disable_super_in_turret._id_136C5)) {
    level.disable_super_in_turret._id_136AE = [1500, 2000, 2500, 2800, 3000, 3200, 3500];
    level._effect["_encstr_868411C10B5E367B2C91EB7BB798AF13A90C0C"] = loadfx("_encstr_A2DF3BDB102172580F8F01DA32275CBE0A6740509EA03E370BA3CAE08742EEB3D1F0BF657B2F3390F029A077EF69DFA7F248DAC1830351B5310BEBE292");
    level._effect["_encstr_977B11780AE0856AA1BBF918D8595FD662EFF2"] = loadfx("_encstr_93F73BB399E1E5A5EE0EAF4C395ECE2CADB2078DB02FF2C1169736B7C219CBD933F0BE984EF50E2CBCC6DB85197DEDEDC4FAD8D227B163CAF52360C081");
    level._effect["_encstr_A67B111B31A393FD20F9672F974089A2ED8397"] = loadfx("_encstr_88F63B3355AB9A7FEBC110EA660FBF0BF339B975B7185E815E4B496791DB86B6BD7851BA92D61837102930EFA921A025F6A717A1F6181AC559C6373923");
    level._effect["_encstr_8F7B11CFAE6329ED897321A877A25ECD1F8267"] = loadfx("_encstr_BAF73BEC3387F296DD1CFA98275E9D856B95388D58F2F283859763BD16235EB3CC0FFA13277D07B05EB1BD2C8CAFF6F6C4AF8DD29C6C1B59BEC870600C");
    level._effect["_encstr_8F721142719034A2FF813F87EF16E92382F3EA"] = loadfx("_encstr_8AEE3B6733F0F2A5BB1CBE314ECB3BC2B69507632CE55E830B2F8DF62C32976766F0EB98E4F50E855E63B716197DBDDE31AFC696C93663CAEB66601818");
    level._effect["_encstr_8272113BF0D26CF2CB3DC1C590F5C97B13E2B2"] = loadfx("_encstr_85EE3B0EB5B8B5273C8A61BAEB38279EB82B806CD3E8FD8BEF5A4A5291E54E9318B937EA4D31F2978BD072BA5950978D900F8379A568BD4FA0235FB7EB");
    level._effect["_encstr_B87211CFAE6329ED897321A877A25ECFCF8267"] = loadfx("_encstr_B6EE3BC3699B16F408C99FAA35A23F7749A11BEA11F3DE6A8053D4BF2B20D5E3647A61929B58DB66A851DFB9C9D18D3F9E363AAA232E635FC1179DD079");
  }
}

_id_140D5() {
  foreach(var_1 in level.disable_super_in_turret._id_136C3) {}
}

init_trap_room_wave(var_0) {
  var_1 = getmaxobjectivecount(0, 0, level.disable_super_in_turret._id_136C2);
  var_1 setmapcirclecolorindex(0);
  var_1 hide();
  var_1.enabled = 0;
  var_1.path = var_0;
  return var_1;
}

_id_11F46(var_0) {
  var_1 = [];
  var_1[game["_encstr_991C0AB9ED5B57161FE89B83"]] = [];
  var_1[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = [];

  foreach(var_3 in level.disable_super_in_turret._id_136C3) {
    if(var_3.script_group != var_0.initchallengeandeventglobals) {
      continue;
    }
    var_4 = scripts\engine\utility::ter_op(var_3.team == "_encstr_9A8507BA4040188D08", game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

    if(!isDefined(var_1[var_4][var_3.script_index])) {
      var_1[var_4][var_3.script_index] = 1;
      continue;
    }

    var_1[var_4][var_3.script_index]++;
  }

  var_6 = 0;

  foreach(var_8 in var_1[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) {
    if(var_8 > var_6)
      var_6 = var_8;
  }

  var_10 = 0;

  foreach(var_8 in var_1[game["_encstr_991C0AB9ED5B57161FE89B83"]]) {
    if(var_8 > var_10)
      var_10 = var_8;
  }

  return [var_6, var_10];
}

init_trigger_spawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, var_1, 2000);
  var_5.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  var_5.radius = var_1;
  var_5.script_team = var_2;
  var_5._id_136BC = var_3;
  var_5.spawntime = gettime();

  if(!istrue(var_4))
    thread scripts\mp\outofbounds::watchoobtrigger(var_5);

  return var_5;
}

_id_13270(var_0, var_1) {
  if(!level.disable_super_in_turret._id_136C4) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  _id_13271(var_0, var_1, game["_encstr_991C0AB9ED5B57161FE89B83"]);
  _id_13271(var_0, var_1, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_13271(var_0, var_1, var_2) {
  var_3 = relic_squadlink_outline_monitor(var_2);
  var_4 = remove_crusader_class(var_2, var_0.initchallengeandeventglobals, var_1);
  var_5 = rootweapon(var_4, var_0, var_1, var_2);
  [var_7, var_8] = removeplayeraslootleader(var_4);

  for(var_9 = 0; var_9 < var_0._id_136C3[var_2].size; var_9++) {
    var_10 = var_0._id_136C3[var_2][var_9];

    if(isDefined(var_10.trigger))
      lastdialogfinishedtime(var_10.trigger);

    var_10 has_relic_amped_victim_filled_bar();

    if(var_9 < var_5.size) {
      var_11 = var_5[var_9];
      var_10.origin = (var_11.origin[0], var_11.origin[1], var_11.radius);
      var_12 = (var_11.origin[0], var_11.origin[1], var_7 + -1000);
      var_10.trigger = init_trigger_spawn(var_12, var_11.radius, var_3, var_10);

      if(istrue(level.disable_super_in_turret._id_136C5)) {
        var_13 = init_trigger_spawn(var_12, int(var_11.radius + level.disable_super_in_turret._id_136C9), var_3, var_10, 1);
        var_13.targetname = "_encstr_A7A80B9EF6C4D5169CCDB4B9EC";
        scripts\mp\utility\trigger::makeenterexittrigger(var_13, ::_id_136C6, ::_id_136C7);
        var_10._id_14427 = var_13;
        var_10.radius = var_11.radius;
      }

      if(!var_10.enabled) {
        if(!level.disable_super_in_turret._id_136BE)
          var_10 showtoteam(var_3);

        var_10.enabled = 1;
      }

      var_10.enabled = 1;
      continue;
    }

    var_10 hide();
    var_10.enabled = 0;
  }
}

lastdialogfinishedtime(var_0) {
  foreach(var_2 in var_0.entstouching) {
    if(isDefined(var_2.oob) && var_2.oob > 0)
      scripts\mp\outofbounds::disableoob(var_2);

    var_2.oobtriggers = scripts\engine\utility::array_remove(var_2.oobtriggers, var_0);

    if(var_2.oobtriggers.size == 0)
      var_2.oobtriggers = undefined;
  }

  var_0 notify("_encstr_8AA50991E565083EF82F9D");
  var_0 delete();
}

loadoutexecutionquip(var_0) {
  if(!level.disable_super_in_turret._id_136C4) {
    return;
  }
  foreach(var_2 in var_0._id_136C3[game["_encstr_991C0AB9ED5B57161FE89B83"]]) {
    if(isDefined(var_2.trigger))
      lastdialogfinishedtime(var_2.trigger);

    var_2 has_relic_amped_victim_filled_bar();
    var_2.enabled = 0;
    var_2 hide();
  }

  foreach(var_2 in var_0._id_136C3[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) {
    if(isDefined(var_2.trigger))
      lastdialogfinishedtime(var_2.trigger);

    var_2 has_relic_amped_victim_filled_bar();
    var_2.enabled = 0;
    var_2 hide();
  }
}

ropeguy(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = [];

  if(isDefined(level.disable_super_in_turret._id_136C3) && level.disable_super_in_turret._id_136C3.size > 0) {
    foreach(var_5 in level.disable_super_in_turret._id_136C3) {
      if(var_5.script_group != var_0.initchallengeandeventglobals) {
        continue;
      }
      if(var_5.script_index != var_1) {
        continue;
      }
      var_6 = scripts\engine\utility::ter_op(var_5.team == "_encstr_9A8507BA4040188D08", game["_encstr_991C0AB9ED5B57161FE89B83"], game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

      if(var_6 != var_2) {
        continue;
      }
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

rootweapon(var_0, var_1, var_2, var_3) {
  var_4 = ropeguy(var_1, var_2, var_3);

  if(var_4.size == 0) {
    [var_6, var_7] = removeplayeraslootleader(var_0);
    var_8 = (var_7[0], var_7[1], var_6);
    var_4[0] = spawnStruct();
    var_4[0].origin = var_8;
    var_4[0].radius = level.disable_super_in_turret._id_136C2;
  }

  return var_4;
}

removeplayeraslootleader(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_1 = var_1 + var_4.origin;

    if(!isDefined(var_2) || var_4.origin[2] < var_2)
      var_2 = var_4.origin[2];
  }

  var_6 = var_1;

  if(var_0.size > 0)
    var_6 = var_6 / var_0.size;

  return [var_2, var_6];
}

showtoteam(var_0) {
  self hide();
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1)
  self showtoplayer(var_3);
}

_id_126AD() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9349203816F263DEB032EB9C2B6BF69D2BF56EE02CDDDCAFE093DE472B6C1D2DF69B");

  if(isDefined(self.warroomtvs) && (isPlayer(self.warroomtvs) || istrue(self.warroomtvs.bot_gametype_attacker_limit_for_team))) {
    return;
  }
  if(isDefined(self.warroomtvs))
    var_0 = self.warroomtvs;
  else
    var_0 = _id_12575();

  if(get_bomb_vest_id_vfx(var_0)) {
    return;
  }
  self._id_12279 = 1;
  thread _id_126AE();
  var_1 = gettime() + level.disable_super_in_turret._id_1365C * 1000;
  var_2 = _id_1257E(var_0);

  while(isDefined(var_2) && isDefined(var_2.trigger) && self istouching(var_2.trigger) && self playerads() < 0.5 && gettime() < var_1)
    waitframe();

  self._id_12279 = undefined;
  self notify("_encstr_9349203816F263DEB032EB9C2B6BF69D2BF56EE02CDDDCAFE093DE472B6C1D2DF69B");
}

_id_1257E(var_0) {
  if(!isDefined(var_0))
    var_0 = _id_12575();

  var_1 = var_0._id_136C3[self.team];

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(!istrue(var_3.enabled)) {
        continue;
      }
      if(self istouching(var_3.trigger))
        return var_3;
    }
  }
}

_id_126AE() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9349203816F263DEB032EB9C2B6BF69D2BF56EE02CDDDCAFE093DE472B6C1D2DF69B");
  self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
  self._id_12279 = undefined;
  self notify("_encstr_9349203816F263DEB032EB9C2B6BF69D2BF56EE02CDDDCAFE093DE472B6C1D2DF69B");
}

room_doors(var_0) {
  var_1 = "_encstr_A15A0D0F59DFB09F1E0AA92092F6C7" + var_0;
  return var_1;
}

_id_136C6(var_0, var_1) {
  if(!isPlayer(var_0) || var_0.team != var_1.script_team) {
    return;
  }
  var_2 = var_1._id_136BC;

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_2._id_14425))
    var_2._id_14425 = [];

  var_3 = var_0 getentitynumber();
  var_4 = room_doors(var_2.radius);
  var_5 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
  var_2._id_14425[var_3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_2._id_14425[var_3] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2._id_14425[var_3] hide();
  var_2._id_14425[var_3] showtoplayer(var_0);
  thread _id_136C8(var_0, var_2._id_14425[var_3], var_4);
}

_id_136C8(var_0, var_1, var_2) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  var_1 unmarkkeyframedmover(1);
  playFXOnTag(scripts\engine\utility::getfx(var_2), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 = var_1.origin[0];
  var_4 = var_1.origin[1];

  for(;;) {
    var_1.origin = (var_3, var_4, var_0.origin[2]);
    waitframe();
  }
}

_id_136C7(var_0, var_1) {
  if(!isPlayer(var_0) || var_0.team != var_1.script_team) {
    return;
  }
  var_2 = var_0 getentitynumber();
  var_3 = var_1._id_136BC;

  if(!isDefined(var_3) || !isDefined(var_3._id_14425) || !isDefined(var_3._id_14425[var_2])) {
    return;
  }
  var_3._id_14425[var_2] delete();
  var_3._id_14425[var_2] = undefined;
}

has_relic_amped_victim_filled_bar() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_14427)) {
    var_0._id_14427 delete();
    var_0._id_14427 = undefined;
  }

  if(isDefined(var_0._id_14425)) {
    foreach(var_2 in var_0._id_14425) {
      if(isDefined(var_2))
        var_2 delete();
    }

    var_0._id_14425 = undefined;
  }
}

_id_131D4(var_0) {
  if(var_0 <= 0) {
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime());
    return;
  }

  var_1 = scripts\mp\utility\game::gettimepassed();
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_0 * 1000));
  var_2 = int(var_1 / 1000);
  var_3 = var_2 + var_0;
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", var_3);
  setDvar("_encstr_A26D119A30E6465823A63BC34D3B7AC2EA1B0B", var_3);
}

unset_relic_gas_martyr() {
  return istrue(level._id_1225C) || istrue(level.gameended);
}

ontimelimit() {
  if(unset_relic_gas_martyr()) {
    return;
  }
  if(waittill_player_uses_munition()) {
    return;
  }
  if(istrue(level._id_1227F) || unset_relic_gas_martyr()) {
    return;
  }
  level._id_1227F = 1;
  _id_12AA3();
  _id_12AA5();
  var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
  var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  var_2 = "_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D";
  thread _id_14301("_encstr_8F79084EEB0211E38D73", undefined, undefined, 2);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_0, 2, undefined, 1, 1, 1);
  munition_slot_gunship_emptied_message();
  _id_1225D(1, var_1);
  _id_11ECC(var_1);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brendgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_2], 0);
}

_id_11ECC(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && var_2.team == var_0)
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
  }
}

munition_slot_gunship_emptied_message() {
  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])) {
    return;
  }
  foreach(var_1 in level.players) {
    var_2 = var_1.pers["_encstr_82FB06EB26785BD7"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_B4C40D9B2207F8E88A9F5F77C702B8"]), var_1.pers["_encstr_B4C40D9B2207F8E88A9F5F77C702B8"], 0);
    var_1.score = var_2;
    var_3 = var_1.pers["_encstr_8E8D0697EB01F243"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_A6990D3B82A758482A3F8F832425A8"]), var_1.pers["_encstr_A6990D3B82A758482A3F8F832425A8"], 0);
    var_1.kills = var_3;
    var_4 = var_1.pers["_encstr_8E0607055DBFB3919A"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_A7DA0E0B1F055ADC3A46BFC7B928E843"]), var_1.pers["_encstr_A7DA0E0B1F055ADC3A46BFC7B928E843"], 0);
    var_1.deaths = var_4;
    var_5 = var_1.pers["_encstr_A1F308589BCD96CD476E"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_92A90F5570A5CB3831474EBAB8544F1C13"]), var_1.pers["_encstr_92A90F5570A5CB3831474EBAB8544F1C13"], 0);
    var_1.assists = var_5;
    var_6 = var_1.pers["_encstr_B2BE0788BAF573592F"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_BAF20EC9ED5D9B1998BE8C16D62CECAC"]), var_1.pers["_encstr_BAF20EC9ED5D9B1998BE8C16D62CECAC"], 0);
    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", var_6);
    var_7 = var_1.pers["_encstr_ACF5089FF6827199725B"] + scripts\engine\utility::ter_op(isDefined(var_1.pers["_encstr_B43A0F93DEBACD19C47D7B4C9AA8A55B59"]), var_1.pers["_encstr_B43A0F93DEBACD19C47D7B4C9AA8A55B59"], 0);
    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_ACF5089FF6827199725B", var_7);
  }
}

munition_source_getridof() {
  foreach(var_1 in level.players)
  _func_0435(var_1);

  foreach(var_1 in level.players) {
    var_1.force_remove_stim = var_1.pers["_encstr_8AEF05472BC2D6"];
    var_1.force_var_to_array = var_1.pers["_encstr_95F40D132396A012D8950D14F04283"];
    var_1.forced_aitypes = var_1.pers["_encstr_82FB06EB26785BD7"];
    var_1.force_teleport_player_into_plane = var_1.pers["_encstr_8E8D0697EB01F243"];
    var_1._encstr_AAA30C0780E1F8C2512DFEB38327 = var_1.pers["_encstr_8E0607055DBFB3919A"];
    var_1._encstr_814A0DC19B8E0B359A9328C9281873 = var_1.pers["_encstr_A1F308589BCD96CD476E"];
    var_1.force_maze_ai_state = var_1.pers["_encstr_B2BE0788BAF573592F"];
    var_1.forceabshotfoot = var_1.pers["_encstr_ACF5089FF6827199725B"];
    var_1.forcearmordropondeath = var_1.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"];
  }

  _func_0436();

  foreach(var_1 in level.players) {
    var_1.pers["_encstr_8AEF05472BC2D6"] = var_1.force_remove_stim;
    var_1.pers["_encstr_95F40D132396A012D8950D14F04283"] = var_1.force_var_to_array;
    var_1.pers["_encstr_B4C40D9B2207F8E88A9F5F77C702B8"] = var_1.forced_aitypes;
    var_1.pers["_encstr_A6990D3B82A758482A3F8F832425A8"] = var_1.force_teleport_player_into_plane;
    var_1.pers["_encstr_A7DA0E0B1F055ADC3A46BFC7B928E843"] = var_1._encstr_AAA30C0780E1F8C2512DFEB38327;
    var_1.pers["_encstr_92A90F5570A5CB3831474EBAB8544F1C13"] = var_1._encstr_814A0DC19B8E0B359A9328C9281873;
    var_1.pers["_encstr_BAF20EC9ED5D9B1998BE8C16D62CECAC"] = var_1.force_maze_ai_state;
    var_1.pers["_encstr_B43A0F93DEBACD19C47D7B4C9AA8A55B59"] = var_1.forceabshotfoot;
    var_1.pers["_encstr_AF1B0AEBFFA5FA7C8825972C"] = var_1.forcearmordropondeath;
  }

  game["_encstr_A9310C0449DDA97F583FADB0FD01"] = undefined;
  game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"] = undefined;
}

_id_13230() {
  level.disable_super_in_turret.initsharedomnvars = 0;
  level.disable_super_in_turret.waittill_scout_drone_defined = 0;
  _id_1313A(0);

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_1.getquestplunderrewardinstance = -1;
    _id_11E6F(var_1.getquestplunderrewardinstance, var_1);
  }
}

relic_amped_last_kill_time(var_0) {
  return var_0.getquestplunderrewardinstance;
}

_id_11E6F(var_0, var_1) {
  if(!getquesttablerewardgroup()) {
    return;
  }
  if(var_1.getquestplunderrewardinstance >= 0)
    level notify("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995", var_1);

  if(var_1.getquestplunderrewardinstance >= 0) {
    _id_12AA3(var_1);
    start_pipe_room_menu();
  }

  var_2 = var_1.getquestplunderrewardinstance;
  var_1.getquestplunderrewardinstance++;
  level.disable_super_in_turret.initsharedomnvars = gettime();

  if(isDefined(level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)) {
    var_3 = relic_amped_monitor();

    foreach(var_5 in level.disable_super_in_turret.getquestrewardscalerstablescaleinfo)
    var_5 setvalue(var_3);
  }

  if(var_1.getquestplunderrewardinstance > 0) {
    _id_1318A(var_1.script_index, var_1.getquestplunderrewardinstance);
    var_7 = "_encstr_B20F1665381F02663B68929F9568AE22D9F9F3A170B0E8B5";
    var_8 = "_encstr_B1601CB5BB814F70F99D60B987F7A88B9A573F19B78A18E007374831EDA9";
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7(var_7, undefined, game["_encstr_991C0AB9ED5B57161FE89B83"]);
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7(var_8, undefined, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);

    foreach(var_10 in level.teamdata[game["_encstr_991C0AB9ED5B57161FE89B83"]]["_encstr_9775086022BE1B413B8B"]) {
      var_10 thread scripts\mp\rank::giverankxp("_encstr_B26C1E1ECB79F06ACBA9D7E791E0635D207114A76121AB322D4FDF9B9F93EA84", level.disable_super_in_turret._id_12288, undefined);
      var_10 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptableusestate("_encstr_B26C1E1ECB79F06ACBA9D7E791E0635D207114A76121AB322D4FDF9B9F93EA84", int(level.disable_super_in_turret._id_12288 / 2), var_10.currentweapon, 1);
      var_10 thread scripts\mp\rank::scoreeventpopup("_encstr_B26C1E1ECB79F06ACBA9D7E791E0635D207114A76121AB322D4FDF9B9F93EA84");
    }

    _id_11F92(var_1, 1, "_encstr_A7460B06CA52CF18C9D769262C", var_1.getquestplunderrewardinstance);
    thread _id_13639(game["_encstr_991C0AB9ED5B57161FE89B83"]);
    thread _id_13639(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && _encstr_AF1C0C87C72C8A7618801AA39BA8()) {
    setnojiptime(1, 1);
    setnojipscore(1, 1);
    level.nojip = 1;
  }

  var_1 notify("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995");
  level thread getquestperkbonus(var_1);
  thread _id_1322F(var_1);
  thread _id_13270(var_1, var_1.getquestplunderrewardinstance);
  thread _id_13260(var_1, var_1.getquestplunderrewardinstance);
  thread _id_1286A(var_1.getquestplunderrewardinstance, var_1);
  thread _id_1326A(var_1, var_1.getquestplunderrewardinstance);
  thread _id_13257(var_1, var_1.getquestplunderrewardinstance);
  thread _id_12CB8(var_1);
}

_id_12CB8(var_0) {
  var_1 = var_0;

  if(istrue(var_0.hidesmokinggunhudfromplayer))
    var_1 = respawn_enemies(var_0);

  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_12276) && var_3._id_12276 > 0) {
      var_4 = var_3 _id_12575();

      if(var_4 == var_0) {
        var_3._id_12276++;
        var_3._id_1286F = var_3 _id_1257C(var_1);

        if(isDefined(var_3._id_1286F))
          var_3._id_1286F.index = -1;

        var_5 = var_3._id_1286F.origin;
        var_6 = getdvarint("_encstr_A98E20C8132B69065B488CA6C807FF0FC5772273063B6A6F107F0D17D7C8643F02E3", 9000);
        var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_5, var_6, 1, 0);
        var_3 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
        var_3 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_5, var_3._id_1286F.angles);
        var_3 scripts\mp\spectating::setdisabled();
        var_3 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_5[0], var_5[1], level.juggheli_spawner_jammer5_3);
        var_3 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
      }
    }
  }
}

relic_amped_monitor() {
  var_0 = 0;

  foreach(var_2 in level.disable_super_in_turret.paths) {
    var_3 = 0;

    if(isDefined(var_2.getquestplunderrewardinstance))
      var_3 = var_2.getquestplunderrewardinstance;

    var_0 = var_0 + var_3;
  }

  return var_0;
}

_encstr_AF1C0C87C72C8A7618801AA39BA8() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    if(!isDefined(var_1.getquestplunderrewardinstance) || var_1.getquestplunderrewardinstance + 1 < var_1.getquestreward_checkforvalueoverride.size)
      return 0;
  }

  return 1;
}

_id_1322F(var_0) {
  level notify("_encstr_BAF910E62B4757070D342BD8B6E0BDA573D1");
  level endon("_encstr_BAF910E62B4757070D342BD8B6E0BDA573D1");

  if(var_0.getquestplunderrewardinstance == 0)
    var_1 = level.disable_super_in_turret.getquestscalervalue;
  else {
    var_1 = int(level.disable_super_in_turret.waittill_scout_drone_defined / 1000) + level.disable_super_in_turret.brmini_kickplayersatcircleedge;
    setmusicstate("_encstr_87F31D083BD29F2BAF49018829C3B6812C52B859A2DF1141934798FD14B378");

    if(level.disable_super_in_turret.maxtime > 0)
      var_1 = int(min(var_1, level.disable_super_in_turret.maxtime));

    level notify("_encstr_88B018F8678EB113121977882D5A4B58EBEFF8A1DB5109C90A3F");
    thread timelimitclock();
  }

  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  _id_131D4(var_1);
  _id_1313B(var_1);
}

_id_131D6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  wait 1;
  _id_1318E(1);
}

_id_12AA3(var_0) {
  if(!getquesttablerewardgroup()) {
    return;
  }
  var_1 = gettime() - level.disable_super_in_turret.initsharedomnvars;

  if(isDefined(var_0))
    level.disable_super_in_turret.waittill_scout_drone_timeout = var_0;

  var_2 = relic_amped_on_ai_kill();

  if(var_1 > var_2)
    var_1 = var_2;

  level.disable_super_in_turret.waittill_scout_drone_defined = var_2 - var_1;
}

_id_1313C(var_0, var_1, var_2) {
  var_3 = "_encstr_85870C736A4F45093298390BA411" + var_1;
  game[var_0 + "_encstr_B6CF09F5382C9763BDC219"][var_3] = var_2;
}

relic_amped_pause(var_0, var_1) {
  var_2 = "_encstr_85870C736A4F45093298390BA411" + var_1;
  var_3 = game[var_0 + "_encstr_B6CF09F5382C9763BDC219"][var_2];
  return var_3;
}

_id_1313B(var_0, var_1) {
  var_2 = "_encstr_AA2215AB7C452B80F29F9B9B83A9D060EAD7F123E4A6C8";
  game[var_2] = int(var_0 * 1000);
}

relic_amped_on_ai_kill(var_0) {
  var_1 = "_encstr_AA2215AB7C452B80F29F9B9B83A9D060EAD7F123E4A6C8";
  return game[var_1];
}

_id_1313A(var_0) {
  if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    game["_encstr_8CF51AE84FF57E570ADFCEC272928B8034FFD9688B9A710FF3C4BCDD"] = var_0;
}

start_pipe_room_menu() {
  if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    game["_encstr_8CF51AE84FF57E570ADFCEC272928B8034FFD9688B9A710FF3C4BCDD"] = game["_encstr_8CF51AE84FF57E570ADFCEC272928B8034FFD9688B9A710FF3C4BCDD"] + 1;
}

relic_amped_monitor_beeps() {
  return game["_encstr_8CF51AE84FF57E570ADFCEC272928B8034FFD9688B9A710FF3C4BCDD"];
}

getquesttablerewardgroup() {
  var_0 = 1;
  return var_0;
}

getquestrewardgroupstablerewards() {
  if(unset_relic_gas_martyr()) {
    return;
  }
  level.ontimelimit = scripts\engine\utility::void;
  _id_12AA5();
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  _id_1318E(0);
  var_0 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
  var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
  var_2 = "_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC";
  thread _id_14301("_encstr_AF2F096B034EE88B9BE1E9", undefined, undefined, 2);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_0, 2, undefined, 1, 1, 1);
  munition_slot_gunship_emptied_message();
  _id_1225D(0, var_1);
  _id_11ECC(var_1);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brendgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_2], 0);
}

eliminatedhudmonitor(var_0) {
  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::handleendgamesplash(var_0);
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::setup_player_stealth(var_0);

    if(istrue(level._id_13364))
      level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::setup_player_marks(var_0);

    if(isDefined(level.defensefactormod))
      wait(level.defensefactormod);

    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::setup_player_stealth(var_0);

    if(istrue(level._id_13364))
      level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::setup_player_marks(var_0);
  }
}

endgame_stars(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 thread scripts\mp\utility\game::setuipostgamefade(0.0);

  if(!var_1)
    wait(var_0);
  else {
    wait(var_0 / 2);
    level notify("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
    wait(var_0 / 2);
  }

  level notify("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739");
}

relic_squadlink_onsteppedfar(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(level.disable_super_in_turret.waittill_scout_drone_timeout) && isDefined(level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle) && (!var_0 || var_1 == "_encstr_8D19048EA595"))
    var_2 = level.disable_super_in_turret.waittill_scout_drone_timeout.vehicle;
  else {
    var_3 = undefined;

    foreach(var_5 in level.disable_super_in_turret.paths) {
      if(istrue(var_5.hidesmokinggunhudfromplayer) || !isDefined(var_5.vehicle)) {
        continue;
      }
      if(!isDefined(var_3) || var_5.getquestplunderrewardinstance > var_3.getquestplunderrewardinstance) {
        var_3 = var_5;
        var_6 = var_5.getquestplunderrewardinstance;
      }
    }

    var_2 = var_3.vehicle;
  }

  return var_2;
}

_id_1426B() {
  var_0 = self.path;
  var_1 = var_0.idle_sfx;

  if(var_0.getquestplunderrewardinstance == 0) {
    var_2 = 1;
    var_3 = 0;
  } else {
    var_2 = var_0.getquestreward_checkforvalueoverride[var_0.getquestplunderrewardinstance - 1]._id_11EA5;
    var_3 = var_2 - 2;
  }

  var_4 = var_0.nodes[var_2];
  var_5 = var_4.origin;
  var_6 = respawningbr(var_0, var_2);
  var_7 = vectortoangles(var_6);
  self vehicle_teleport(var_5, var_7);
  var_8 = var_0.nodes[var_3];
  var_9 = var_8.origin;
  var_6 = respawningbr(var_0, var_3);
  var_10 = vectortoangles(var_6);
  var_1 vehicle_teleport(var_9, var_10);
  return [var_5, var_7];
}

relic_squadlink_onbecameinvalidplayer(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_3 = var_1.nodes[var_1.nodes.size - 1];
    var_2 = var_3.origin;
  } else {
    if(var_1.getquestplunderrewardinstance == 0)
      var_4 = 1;
    else
      var_4 = var_1.getquestreward_checkforvalueoverride[var_1.getquestplunderrewardinstance - 1]._id_11EA5;

    var_5 = var_1.nodes[var_4];
    var_2 = var_5.origin;
  }

  return var_2;
}

registerbrsquadleaderjumpcommands(var_0, var_1) {
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  if(var_1 == game["_encstr_B6A70A23CA6659DC91CAE4DC"] && level.disable_super_in_turret._id_1226A == "_encstr_810D059BE07D8B" && var_0.label == "_encstr_994C0238" && var_0.getquestplunderrewardinstance == 1) {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"] && level.disable_super_in_turret._id_1226A == "_encstr_97C70E3B2AD9F088F31B1331471AC092" && var_0.label == "_encstr_994C0238") {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"] && level.disable_super_in_turret._id_1226A == "_encstr_9BD50A1CA7C0E553306372BF" && var_0.label == "_encstr_8B4C0248") {
    var_3 = (0, -10, 0);
    var_4 = var_3;
  } else if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"] && level.disable_super_in_turret._id_1226A == "_encstr_9BD50A1CA7C0E553306372BF" && var_0.label == "_encstr_994C0238")
    var_4 = (0, 25, 0);

  return [var_3, var_4];
}

_id_1225D(var_0, var_1, var_2, var_3) {
  level._id_1225C = 1;
  level notify("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level notify("_encstr_B48B10CF58B0F96A343FB7E78BE502262081");
  var_4 = relic_squadlink_onsteppedfar(var_0, var_1);
  var_5 = var_4.path;
  var_6 = relic_squadlink_onbecameinvalidplayer(var_1, var_5);

  foreach(var_8 in level.players) {
    var_8 notify("_encstr_B6730EE73AE71389B1DA381842565B08");
    var_8.cancelkillcam = 1;

    if(var_8.team == var_1)
      var_8 setclientomnvar("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", 1);

    var_8 _id_13182(0);
    var_8 freezecontrols(1);
    var_8 clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
    var_8 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
    var_8 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
    var_8 setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);

    if(isDefined(var_8._id_12135)) {
      var_8._id_12135 stoploopsound(self._id_12136);
      var_8._id_12135 delete();
      var_8._id_12135 = undefined;
      var_8._id_12136 = undefined;
    }

    var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_6);
  }

  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 9);
  wait 3;
  setomnvar("_encstr_B17E1560778AD811ABBEEEE197316140CF437930C73491", 1);
  removeallcorpses();

  if(level.disable_super_in_turret.getquestscaledvalue) {
    foreach(var_11 in level.disable_super_in_turret.getquestrewardstabletype) {
      var_11.getquestrewardstablevaluecolumnindex hide();

      if(isDefined(var_11.getquestrewardstablevaluecolumnindex.turret))
        var_11.getquestrewardstablevaluecolumnindex.turret hide();
    }

    foreach(var_11 in level.disable_super_in_turret._id_13C1A)
    var_11.getquestrewardstablevaluecolumnindex hide();
  }

  var_15 = undefined;

  if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_15.angles = (0, var_4.angles[1], 0);
    var_15 setModel("_encstr_925D1A5333C1F9A36BB06871BB704FBE11318A2AB04FACA3A0834E7C");
    var_15 unmarkkeyframedmover(1);
    var_15 setscriptablepartstate("_encstr_A7460B06CA52CF18C9D769262C", "_encstr_B4BA07CC5ADCB4CDD0");
  } else
    thread contestedtime(var_4);

  if(var_1 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0) {
      var_16 = "_encstr_B6171FE942A9B97929FB3830A377B1F732AEDF65CB414DA01BB330A0FF5F890B7A";
      var_17 = "_encstr_92CC1CDD1B6110C9BB21E73FF0C6FA2B5BF3DBA783F6719F53876907AEB5";
    } else {
      var_16 = "_encstr_A90217BBA3915F60096D90A997C7101B8A1B070D1FF9AE3825";
      var_17 = "_encstr_B41514F8934179B147C41807A4B7583F32CBF11B3A65";
    }

    var_18 = var_5.nodes[var_5.nodes.size - 1];
    var_19 = var_18.origin;
    var_20 = respawningbr(var_5, var_5.nodes.size - 1);
    var_21 = vectortoangles(var_20);
  } else {
    if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0) {
      var_16 = "_encstr_92CC1CDD1B6110C9BB21E73FF0C6FA2B5BF3DBA783F6719F53876907AEB5";
      var_17 = "_encstr_B6171FE942A9B97929FB3830A377B1F732AEDF65CB414DA01BB330A0FF5F890B7A";
    } else {
      var_16 = "_encstr_B41514F8934179B147C41807A4B7583F32CBF11B3A65";
      var_17 = "_encstr_A90217BBA3915F60096D90A997C7101B8A1B070D1FF9AE3825";
    }

    var_19 = var_4.origin;
    var_21 = var_4.angles;
  }

  [var_23, var_24] = registerbrsquadleaderjumpcommands(var_5, var_1);
  var_25 = var_21 + var_23;
  var_26 = var_21 + var_24;
  var_27 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_19);
  var_27.angles = var_25;
  var_27 setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_27 unmarkkeyframedmover(1);
  var_28 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_19);
  var_28.angles = var_26;
  var_28 setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_28 unmarkkeyframedmover(1);
  var_27 scriptmodelplayanim(var_16, "_encstr_BA1D11805713CD305B6A3F2ACF1DFBC0F8449F");
  var_28 scriptmodelplayanim(var_17, "_encstr_BA1D11805713CD305B6A3F2ACF1DFBC0F8449F");
  var_29 = scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9775086022BE1B413B8B");

  foreach(var_8 in var_29) {
    var_8 thread scripts\mp\playerlogic::respawn_asspectator(var_19 + (0, 0, 60), (0, 0, 0));
    var_8 scripts\mp\spectating::setdisabled();
    var_8 cameralinkTo(var_27, "_encstr_AFAA09344628DA52A72756", 1, 1);
  }

  var_32 = scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9775086022BE1B413B8B");

  foreach(var_8 in var_32) {
    var_8 thread scripts\mp\playerlogic::respawn_asspectator(var_19 + (0, 0, 60), (0, 0, 0));
    var_8 scripts\mp\spectating::setdisabled();
    var_8 cameralinkTo(var_28, "_encstr_AFAA09344628DA52A72756", 1, 1);
  }

  foreach(var_8 in level.players) {
    if(var_8.team == var_1)
      var_8 setplayermusicstate("_encstr_91C51AE0D33A47F3877139A041BBDE87958AE818DA837B49A787B328");
    else
      var_8 setplayermusicstate("_encstr_ADAE1BCA403241B981222840F2A33FCB488F73087DABEF62D7647033B1");

    var_8 thermalvisionoff();
    var_8 setsoundsubmix("_encstr_AB541D8922C9FD7B6F9F58388757F33373CD7007BF614780358348382B8549", 0.5);
  }
}

contestedtime(var_0) {
  wait 1.5;
  var_1 = var_0.path;
  var_2 = var_1.idle_sfx;

  if(isDefined(var_1._id_12358))
    var_1._id_12358 delete();

  foreach(var_4 in var_1.pieces) {
    if(isDefined(var_4))
      var_4 delete();
  }

  if(isDefined(var_2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel))
    var_2.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();

  var_2 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
  wait 1;

  if(isDefined(var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel))
    var_0.calloutmarkerpingvo_playpredictivepingacknowledgedcancel delete();

  var_0 scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode();
}

toggle_fx_trap() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A60C0CE31733E980D801D3C66B5B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(level.disable_super_in_turret.paths))
      level.disable_super_in_turret.paths = [];

    var_3 = level.disable_super_in_turret.paths.size;
    level.disable_super_in_turret.paths[var_3] = var_2;
  }

  for(var_5 = 0; var_5 < level.disable_super_in_turret.paths.size; var_5++) {
    var_2 = level.disable_super_in_turret.paths[var_5];
    var_6 = "_encstr_934C02A2";
    var_7 = "_encstr_950703EBCA";
    var_8 = &"_encstr_AAAE122549174F690814CFCB04FDA9BF43801E4D";

    switch (var_2.script_index) {
      case 0:
        var_6 = "_encstr_994C0238";
        var_7 = "_encstr_B20703DFCF";
        var_8 = &"_encstr_87AE12A191611995A7846877A456FF831B98D131";
        break;
      case 1:
        var_6 = "_encstr_8B4C0248";
        var_7 = "_encstr_B40703E96D";
        var_8 = &"_encstr_96AE124AD6A10753B8EC6701AB926A617BA0390A";
        break;
      case 2:
        var_6 = "_encstr_834C02D0";
        var_7 = "_encstr_B6070359BA";
        var_8 = &"_encstr_88AE12F1ABBFD75B41DD601FA75E01BDDC5B9141";
        break;
      case 3:
        var_6 = "_encstr_A14C02D5";
        var_7 = "_encstr_A2070318DC";
        var_8 = &"_encstr_81AE122D8A7F3A3E1161C131014EB94BA14C4F44";
        break;
      default:
        break;
    }

    var_2.label = var_6;
    var_2.iconname = var_7;
    var_2._id_12201 = var_8;
    var_2._id_13695 = [];
    var_2._id_13663 = [];
    var_2.spawncount = [];
    var_2._id_1361E = [];
    var_2.spawntime = [];
    var_2.numplayers = [];
    var_2.numplayers[game["_encstr_991C0AB9ED5B57161FE89B83"]] = 0;
    var_2.numplayers[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = 0;
    var_2._id_14307 = "_encstr_8BBA05185F8B99";
    var_2._id_14306 = 0;
    var_2._id_142F7 = 0;
    var_2._id_142F9 = 0;
    var_2.objidnum = [];
    var_2._id_12CD5 = [];
    var_2._id_11F48 = [];
    var_2.pieces = [];
    var_2.wait_for_computer_power = [];
    var_2._id_11F9F = 0;
    var_2._id_119D6 = 0.0;
    var_2._id_13BF5 = 0;

    if(level.disable_super_in_turret._id_13601) {
      var_2._id_136BD = 0;
      var_2._id_13620 = spawnStruct();
      var_2._id_13620.bot_gametype_attacker_limit_for_team = 1;
      var_2._id_13620.path = var_2;
    }

    if(level.disable_super_in_turret._id_13602 > -1)
      var_2._id_136BD = 0;

    if(level.disable_super_in_turret.getquestscaledvalue)
      var_2.getquestscaledvalue = [];

    freeze_timer_at_max_time_bomb_vest(var_2);
  }
}

time_on_floor() {
  if(!level.disable_super_in_turret.start_drones_event) {
    return;
  }
  thread time_passed_no_target_threshold();
}

time_passed_no_target_threshold() {
  var_0 = getEntArray("_encstr_AA410C0EC2E58DEDB032AFEDED98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in level.disable_super_in_turret.paths) {
    foreach(var_5 in var_0) {
      if(var_3.initchallengeandeventglobals == var_5.script_group) {
        var_1 = var_5;
        var_1.index = 0;
        break;
      }
    }

    if(isDefined(var_1)) {
      break;
    }
  }

  foreach(var_3 in level.disable_super_in_turret.paths)
  var_3.start_drones_event = var_1;

  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  thread _id_12285(var_1);
}

_id_12285(var_0) {
  var_0.entstouching = [];
  thread _id_12287(var_0);
  thread _id_12286(var_0);
}

_id_12286(var_0) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8B600A25242A93D2CED99539");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1.sq_entergulag) && var_1.sq_entergulag > 0) {
      continue;
    }
    _id_12265(var_0, var_1);
  }
}

_id_12287(var_0) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8B600A25242A93D2CED99539");

  for(;;) {
    var_1 = var_0.entstouching;

    foreach(var_4, var_3 in var_1) {
      if(!isDefined(var_3))
        var_0.entstouching[var_4] = undefined;

      if(isDefined(var_3) && !var_0 istouching(var_3))
        _id_12266(var_0, var_3);
    }

    waitframe();
  }
}

_id_12265(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_1._id_12CCE))
    var_1._id_12CCE = undefined;

  if(isDefined(var_0._id_13AB7) && isDefined(var_1.owner) && var_0._id_13AB7 != var_1.owner.team) {
    return;
  }
  if(isDefined(var_0._id_13AB7) && !isDefined(var_1.owner) && var_0._id_13AB7 != var_1.team) {
    return;
  }
  if(!isDefined(var_1.sq_movequestlocale)) {
    var_1.sq_movequestlocale = [];

    for(var_3 = 0; var_3 < level.disable_super_in_turret.paths.size; var_3++)
      var_1.sq_movequestlocale[var_3] = 0;
  }

  var_1.sq_movequestlocale[var_0.index] = 1;
  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobtriggers))
    var_1.oobtriggers = [];

  var_4 = [var_0];

  foreach(var_6 in var_1.oobtriggers)
  var_4[var_4.size] = var_6;

  var_1.oobtriggers = var_4;

  if(isDefined(var_1.sq_entergulag))
    var_1.sq_entergulag++;
  else
    var_1.sq_entergulag = 1;

  if(isDefined(var_1.oob) && var_1.oob > 0)
    scripts\mp\outofbounds::disableoob(var_1);
}

_id_12266(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0._id_13AB7) && isDefined(var_1.owner) && var_0._id_13AB7 != var_1.owner.team) {
    return;
  }
  if(isDefined(var_0._id_13AB7) && !isDefined(var_1.owner) && var_0._id_13AB7 != var_1.team) {
    return;
  }
  if(isDefined(var_1.sq_entergulag) && var_1.sq_entergulag > 0 && var_1.sq_movequestlocale[var_0.index]) {
    var_1.sq_movequestlocale[var_0.index] = 0;
    var_1.sq_entergulag--;

    foreach(var_4 in var_1.sq_movequestlocale) {
      if(istrue(var_4))
        return;
    }

    scripts\mp\outofbounds::enableoob(var_1);
  }

  if(isDefined(var_1.oobtriggers)) {
    var_1.oobtriggers = scripts\engine\utility::array_remove(var_1.oobtriggers, var_0);

    if(var_1.oobtriggers.size == 0)
      var_1.oobtriggers = undefined;
  }
}

_id_12607(var_0, var_1, var_2) {
  var_3 = scripts\mp\outofbounds::getlastoobtrigger(self);

  if(isDefined(var_3) && isDefined(var_3.spawntime)) {
    if(gettime() - var_3.spawntime < level.disable_super_in_turret._id_136C0) {
      var_4 = scripts\mp\outofbounds::getoutofboundstime(var_2, self);
      var_4 = var_4 * level.disable_super_in_turret._id_136BF;
      self.oobendtime = int(gettime() + var_4 * 1000);
      thread scripts\mp\outofbounds::watchooboutoftime(self, var_4);
    }
  }

  scripts\mp\outofbounds::playerentercallback(var_0, var_1, var_2);
  self notify("_encstr_BDDB1DDB8DAB2B6FFA91FDCA2E3311DAE6A970A19524F7966CA3DB9B617ED7");

  if(!isDefined(self._id_12269)) {
    var_5 = relic_squadlink_outline_monitor(self.team);
    self._id_12269 = scripts\mp\utility\outline::outlineenableforteam(self, var_5, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  }

  if(level.disable_super_in_turret._id_136BE) {
    if(isDefined(self._id_12267)) {
      self._id_12267 hidefromplayer(self);
      self._id_12267 = undefined;
    }

    foreach(var_3 in self.oobtriggers) {
      if(isDefined(var_3._id_136BC)) {
        var_3._id_136BC showtoplayer(self);
        self._id_12267 = var_3._id_136BC;
      }
    }
  }

  thread _id_1260A();
}

_id_12608(var_0, var_1, var_2) {
  scripts\mp\outofbounds::playerexitcallback(var_0, var_1, var_2);

  if(isDefined(self._id_12CD3))
    self._id_12CD3.alpha = 0;

  if(isDefined(self._id_12269))
    thread _id_12537();
}

_id_12537() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_BDDB1DDB8DAB2B6FFA91FDCA2E3311DAE6A970A19524F7966CA3DB9B617ED7");
  self endon("_encstr_BDDB1DDB8DAB2B6FFA91FDCA2E3311DAE6A970A19524F7966CA3DB9B617ED7");
  wait(level.disable_super_in_turret._id_136C1);
  scripts\mp\utility\outline::outlinedisable(self._id_12269, self);
  self._id_12269 = undefined;

  if(isDefined(self._id_12267)) {
    self._id_12267 hidefromplayer(self);
    self._id_12267 = undefined;
  }
}

headlightright() {
  var_0 = self;
  var_0.sq_movequestlocale = undefined;
  var_0.sq_entergulag = undefined;
}

toggle_player_settings() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  foreach(var_1 in level.disable_super_in_turret.paths) {
    var_1.trigger.playersintrigger = [];
    var_1.trigger thread _id_144EC();
    var_1.trigger thread _id_144ED();
  }
}

_id_144EC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_1 = var_0 getentitynumber();

    if(isDefined(self.playersintrigger[var_1])) {
      continue;
    }
    self.playersintrigger[var_1] = var_0;
    _id_12026(var_0);
  }
}

_id_144ED() {
  for(;;) {
    foreach(var_2, var_1 in self.playersintrigger) {
      if(isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 istouching(self)) {
        continue;
      }
      _id_1202F(var_1);
      self.playersintrigger[var_2] = undefined;
    }

    wait 1;
  }
}

_id_12026(var_0) {
  var_0 thread _id_12609();
}

_id_1202F(var_0) {
  var_0 notify("_encstr_ADA015887F8E6B5FDB8E73F165A26176E44B3858CF2563");
}

_id_12609() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ADA015887F8E6B5FDB8E73F165A26176E44B3858CF2563");

  for(;;) {
    wait 1;

    if(!isDefined(self._id_13BF4))
      self._id_13BF4 = 0;

    self._id_13BF4 = self._id_13BF4 + 1;

    if(self._id_13BF4 % 5 == 0)
      scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_A1A7068392D8372B");
  }
}

tmtyl_vip_interactions() {
  level.disable_super_in_turret._id_11E97 = [];
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (18755, -21000, -160), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (21415, -17040, -170), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (21900, -16675, -195), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (20890, -23335, -170), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (24850, -19405, -190), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_9BD50A1CA7C0E553306372BF", (25935, -14950, -240), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (37075, -26140, -550), 150, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (35945, -27130, -550), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (36375, -25765, -550), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (38735, -23415, -540), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (38530, -23595, -540), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (38400, -23735, -540), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_810D059BE07D8B", (34305, -25675, -550), 180, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-22730, -27155, -120), 150, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-19540, -25000, -180), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-13500, -21525, -320), 180, 120);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-22445, -28805, -105), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-15630, -24035, -260), 275, 90);
  battle_tracks_toggleoffstate("_encstr_8CD508CA98A70FAFC01D", "_encstr_97C70E3B2AD9F088F31B1331471AC092", (-8735, -21455, -270), 275, 90);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (1930, -7157.5, 712.5), 80, 160);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-253.5, -7015.5, 712.5), 60, 150);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-346, -6995, 712.5), 60, 150);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-1109.5, -6707, 712.5), 60, 150);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-1202.5, -6662, 712.5), 60, 150);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-1714, -6184, 707.5), 40, 128);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-1822.5, -6050, 707.5), 40, 128);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-4613, -977, 708.5), 50, 128);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-4631.5, -894.5, 708.5), 50, 128);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-4066, 4178, 620), 75, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", (-3628.5, 5052, 610.5), 75, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1217, 4405.5, 864.5), 85, 110);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (708, 4182, 952), 80, 60);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1018, 4570, 855), 200, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1268, 4270, 862), 50, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1286, 4124, 866), 200, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1388, 3932, 862), 60, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1402, 3744, 866), 200, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1492, 3364, 866), 200, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1592, 2974, 866), 200, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1648, 2812, 830), 60, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1656, 2618, 858), 200, 70);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1710, 2252, 849), 200, 55);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1797, 2009, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1809, 1897, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1822, 1787, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1834, 1672, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1849, 1544, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1858, 1436, 853), 75, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1888, 1318, 853), 82, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1910, 1206, 853), 82, 75);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1934, 1093, 856), 90, 50);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (2000, 983, 856), 118, 50);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1154, 2289, 1006), 125, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1144, 2438, 995), 125, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1135, 2579, 980), 125, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1134, 2703, 974), 125, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_8B1F0C8164E29078A0B989506260", (1127, 2848, 968), 125, 80);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-2137, 9697.5, 669.5), 120, 300);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2729, 5032, 383), 60, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2912.5, 4905.5, 383), 200, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2820, 4740, 383), 60, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2983, 4661, 383), 200, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2878.5, 4528, 383), 60, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3039.5, 4463, 383), 200, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3096, 4273, 383), 200, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3091, 4118, 383), 150, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3027.5, 4006.5, 383), 60, 140);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (1097, 6176, 600), 82, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (1038, 6257, 600), 82, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (998, 6356, 600), 82, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (971, 6463, 600), 82, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (202, 8582, 715), 260, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (48, 8794, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-44, 8870, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-136, 8948, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-228, 9032, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-320, 9116, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (-400, 9184, 715), 81, 200);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3114, 2007, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3089, 2104, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3065, 2203, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3035, 2313, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3007, 2420, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (2983, 2524, 345), 77, 240);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3523, 2898, 210), 300, 120);
  battle_tracks_toggleoffstate("_encstr_AF690B8DE7364F0A17C0C3EA12", "_encstr_AC480657D870D2F2", (3161, 3734, 210), 110, 160);
}

battle_tracks_toggleoffstate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.disable_super_in_turret._id_11E97)) {
    return;
  }
  if(var_0 != level.mapname || var_1 != level.disable_super_in_turret._id_1226A) {
    return;
  }
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, var_3, var_4);
  var_5.targetname = "_encstr_8D241BC1C2E536DEC2467DB9DEBE6CDBDC8ECAE6A3F54727B4CEEC569C";
  var_5.radius = var_3;
  var_5.height = var_4;
  level.disable_super_in_turret._id_11E97[level.disable_super_in_turret._id_11E97.size] = var_5;
}

getlocationnameforpoint(var_0) {
  if(!isDefined(var_0) || !isPlayer(var_0) || level.disable_super_in_turret._id_11E97.size == 0)
    return 1;

  foreach(var_2 in level.disable_super_in_turret._id_11E97) {
    if(var_0 istouching(var_2))
      return 0;
  }

  return 1;
}

timetonextcheckpoint() {
  _encstr_8F993B92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FBB9882A412C32DE942CF4942B7A0B0270B383E6D7A9FB3EE7DA38F4BEFE36ACF47D8::toggle_farah_lights(0, "_encstr_AF1904A7F929", 0);
  _encstr_A5883B937A8AAFFA40E25F3307382838102DE30A408D7B8EB856670319318DA77F21310319F3B33F9FB06F36736142A1F0E9F6D54876E2877FCA59A302::toggle_farah_lights(1, "_encstr_AF1904A7F929", 1);
  _encstr_96B43B6E1B4ED2E0A3DC97B61C5E3BC2D659E8BCC12BB9E59893D7832C2F36F62C19BE38858E437DB683AF13C9BE5B561B430BCD2DB1E67D9171ECCD36::toggle_farah_lights(2, "_encstr_AF1904A7F929", 2);
  _encstr_ADAD3B8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B0AE7D1B0F6F4CFB15113A868177BBE6123A719A88E403B15F1BEA8500676B14BDA::toggle_farah_lights(3, "_encstr_AF1904A7F929", 3);
  _encstr_8F993B92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FBB9882A412C32DE942CF4942B7A0B0270B383E6D7A9FB3EE7DA38F4BEFE36ACF47D8::toggle_farah_lights(0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
  _encstr_A5883B937A8AAFFA40E25F3307382838102DE30A408D7B8EB856670319318DA77F21310319F3B33F9FB06F36736142A1F0E9F6D54876E2877FCA59A302::toggle_farah_lights(1, "_encstr_A5AE098ADB583E0AF7A5AB", 1);
  _encstr_870833637E8BF10ACB9B86A9CFD7F7B9272168DB80B52FA79D8A69886920C89A20BA8F6BF935627780405F5A974B2DD99205AF9803::toggle_farah_lights(0, "_encstr_883009BD28232B4B688B98", 0);
  _encstr_A3FA339F3BE299D07B0A20FA73766AB1E5CDD847407817406EE0AF43C36204B7109CF14B9FC5BBE88A5F592AA060A2E00A3AF7E0EF::toggle_farah_lights(1, "_encstr_883009BD28232B4B688B98", 1);
  _encstr_B6FF336ED8C95A831D37CBB6E05EEC16DAB2A3E5C156B9F289E4AF380BE5B1ED0B46EB07B01D0D7DD683AFC8F67368D72371ECCDC6::toggle_farah_lights(2, "_encstr_883009BD28232B4B688B98", 2);
  _encstr_A221333B5F736A08E3E7B2FB4BFE2CCE57EFBBE97BEF0BE82273BF114A5B58DA6B672E936F3C4041BFA38769B2385B1916CACF876A::toggle_farah_lights(0, "_encstr_AFD40D24BE99C11BC3956F29C2B020", 3);
  _encstr_B6053306669B6BBBC467DAF053A791B3B20F7D8B3A42E708BA0B5110FF19C8F71AF76097D62B99CE6D1B49A8DF568B5FF70DE49E2E::toggle_farah_lights(1, "_encstr_AFD40D24BE99C11BC3956F29C2B020", 4);
  _encstr_B11733DCC6C996C18E37795B38793B58B62BA3F2E05937CB89C9EB0E582FC6B75819AFC1851D43FA6B0EBEC8BD731ABE538BB3CDB1::toggle_farah_lights(2, "_encstr_AFD40D24BE99C11BC3956F29C2B020", 5);
  _encstr_A12B33F8EF1270B91392D0892ADEEF39656F48100BDDCBCF5AFAE00F46933120D10389D0B764E0777262F81DDD3AD96E6E92C05017::toggle_farah_lights(0, "_encstr_9B7E0A83E4EDD6CA732CC8AC", 6);
  _encstr_8332335636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21402FE9F8872A0750E7E6DBA9BE5DCB19982F06BBAF973D34EEFE::toggle_farah_lights(1, "_encstr_9B7E0A83E4EDD6CA732CC8AC", 7);
  _encstr_BE22335B869E880BC31F5818081F978721A31B68AB9D973F2853570319C0658892C9F18BFA01483719A0DF90689883516FB60966C8::toggle_farah_lights(2, "_encstr_9B7E0A83E4EDD6CA732CC8AC", 8);
  _encstr_B42D330726A82391F40F2298B35232E7A73DB8CBC89D777F13D861E78120536D3099476190A33AEF2D60CFC7A0372BC10BBA5F6B90::toggle_farah_lights(0, "_encstr_92D60A53F94A30B62FE3D13B", 9);
  _encstr_8FAE349BC6E42DE01DDC5EDA3897B358B656D1F207566E791393AF0E0BBC36DE168CAFE0B04786BEADC1EB32BD9B68BE260371ECB936::toggle_farah_lights(1, "_encstr_92D60A53F94A30B62FE3D13B", 10);
  _encstr_AF9134179372A0DF33EB3060C3061CA8CDED919B281FA88883D336CBBA7741206644BF01A18338F8870B0E3162D325E9AA89D5975B2E::toggle_farah_lights(2, "_encstr_92D60A53F94A30B62FE3D13B", 11);
  _encstr_A3FA339F3BE299D07B0A20FA73766AB1E5CDD847407817406EE0AF43C36204B7109CF14B9FC5BBE88A5F592AA060A2E00A3AF7E0EF::toggle_farah_lights(0, "_encstr_9BD50A1CA7C0E553306372BF", 1);
  _encstr_870833637E8BF10ACB9B86A9CFD7F7B9272168DB80B52FA79D8A69886920C89A20BA8F6BF935627780405F5A974B2DD99205AF9803::toggle_farah_lights(1, "_encstr_9BD50A1CA7C0E553306372BF", 0);
  _encstr_A3FA339F3BE299D07B0A20FA73766AB1E5CDD847407817406EE0AF43C36204B7109CF14B9FC5BBE88A5F592AA060A2E00A3AF7E0EF::toggle_farah_lights(0, "_encstr_99D50AC47DD4A0D360F7B88B", 1);
  _encstr_B6FF336ED8C95A831D37CBB6E05EEC16DAB2A3E5C156B9F289E4AF380BE5B1ED0B46EB07B01D0D7DD683AFC8F67368D72371ECCDC6::toggle_farah_lights(1, "_encstr_99D50AC47DD4A0D360F7B88B", 2);
  _encstr_A221333B5F736A08E3E7B2FB4BFE2CCE57EFBBE97BEF0BE82273BF114A5B58DA6B672E936F3C4041BFA38769B2385B1916CACF876A::toggle_farah_lights(0, "_encstr_97C70E3B2AD9F088F31B1331471AC092", 3);
  _encstr_B6053306669B6BBBC467DAF053A791B3B20F7D8B3A42E708BA0B5110FF19C8F71AF76097D62B99CE6D1B49A8DF568B5FF70DE49E2E::toggle_farah_lights(1, "_encstr_97C70E3B2AD9F088F31B1331471AC092", 4);
  _encstr_938C341AA950A9BB8D5716177918F2196BF1536023307B06EE2DCF5B43DB8A5F187901AAB9D038D9B101C703B70857B732CBD5F793D0::toggle_farah_lights(0, "_encstr_810D059BE07D8B", 12);
  _encstr_A19534CB06FB17B241386E4208DFAFEFF0FD344927A1372D1528518B78AB259F29D597D837EBE3C9235059C220ED0BA78BE67E4756D1::toggle_farah_lights(1, "_encstr_810D059BE07D8B", 13);
  _encstr_8260369BD8392D071D6E5EDA0E5E7658B6591D2F83CACD5E4C4EBEC1C29763DBC232D7C1588EA1BED6E0F5ACDC361638CAA1EB99B8CEB9C6::toggle_farah_lights(0, "_encstr_BD370F28DAD38398C711DDDF0A53217D7A", 0);
  _encstr_9392369EC813D7D01053E0D01008F4E7BDAD831BA96F4F3D13FB58828FA304A0AA2B5FF3D72B18301A1A0F1A32C0C1F08791C8CA9DC7C391::toggle_farah_lights(0, "_encstr_8B1F0C8164E29078A0B989506260", 1);
  _encstr_9B9836B307509C0BF5BB2E32E3609F5670E34C31B940A22E96F321EB29A38B8D7859EFA033B02C27C9AB39A273F6F782E091776DD58032AF::toggle_farah_lights(0, "_encstr_AC480657D870D2F2", 2);

  if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0)
    _id_1318D(1, -1);
}

_id_1318D(var_0, var_1) {
  if(var_1 > 31 || var_0 >= 2) {
    return;
  }
  var_2 = 5;
  var_3 = var_0 * 5;
  var_4 = int(pow(2, var_2)) - 1;
  var_5 = (var_1 &var_4) << var_3;
  var_6 = ~(var_4 << var_3);
  var_7 = getomnvar("_encstr_B1AB0C6720D0A2C371807F41D817");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  setomnvar("_encstr_B1AB0C6720D0A2C371807F41D817", var_9);
}

balloon_deposit_cash_vo_explanation(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.targetname = var_0;
  var_3.target = var_1;
  var_3.script_index = var_2;

  if(isDefined(var_3.targetname)) {
    if(!isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_3.targetname]))
      level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_3.targetname] = [];

    var_4 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_3.targetname].size;
    level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_3.targetname][var_4] = var_3;
  }

  if(isDefined(var_3.target)) {
    if(!isDefined(level.struct_class_names["_encstr_A16007A921A23B85E3"][var_3.target]))
      level.struct_class_names["_encstr_A16007A921A23B85E3"][var_3.target] = [];

    var_4 = level.struct_class_names["_encstr_A16007A921A23B85E3"][var_3.target].size;
    level.struct_class_names["_encstr_A16007A921A23B85E3"][var_3.target][var_4] = var_3;
  }

  if(isDefined(var_3.script_noteworthy)) {
    if(!isDefined(level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_3.script_noteworthy]))
      level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_3.script_noteworthy] = [];

    var_4 = level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_3.script_noteworthy].size;
    level.struct_class_names["_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"][var_3.script_noteworthy][var_4] = var_3;
  }

  return var_3;
}

_id_13929(var_0, var_1) {
  self.origin = var_0;
}

init_relic_trex(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 2.0;

  if(isDefined(var_7))
    var_9 = newteamhudelem(var_7);
  else
    var_9 = newhudelem();

  var_9.elemtype = "_encstr_9779056EEA2583";
  var_9.font = "_encstr_8B1608EC43B8D647A113";
  var_9.fontscale = var_8;
  var_9.basefontscale = var_8;
  var_9.x = 0;
  var_9.y = 0;
  var_9.width = 0;
  var_9.height = int(level.fontheight * var_8);
  var_9.xoffset = 0;
  var_9.yoffset = 0;
  var_9.children = [];
  var_9 scripts\mp\hud_util::setparent(level.uiparent);
  var_9.hidden = 0;
  var_9.archived = 0;
  var_9.alpha = 1;
  var_9 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0))
    var_9.label = var_0;

  if(isDefined(var_1))
    var_9 setvalue(var_1);

  if(isDefined(var_6))
    var_9.color = var_6;

  return var_9;
}

time_between_rocket_fire() {
  var_0 = 0;
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_96011ADD58BC0EF6B4E68ED72B6E6CB7273AD737CAD5D1C92C1B7D16", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_87011A2BD22787C0ECDE411FFD5298C0A31BA6F07ACF3D6086A40F5D", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BD011AAF67FA13151BB0FB4180474E3733553F3E8D83CB9A33B8319A", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_82011A0F51F881C7C0F22558B1A28E5F6AD997B6BB0B2C9B0F71F970", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_92011AB7DFCB671801F5FB96DFE3801093136F3D67532DB8214D8629", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_95F612DD2CBC83DB969BA3AFACB9D8F64ED1AF16", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B4F6122B9EB148784263095767CBB6685233D601", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B6F612D3A8538227B8B8FCDFC503EF8DAD98D92A", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A6F612D3E913936718FDD3887933C6823EA8985B", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B2F612137303BB27E0FDEC99B9B741B80BFC9720", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_9BCD161225EB280595989EA022CBD34852AF51A61A3D4A8A", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_851A15B79BB34950B91A88292253B0F8E8B5A078CFBF60", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_990F1921257D0505AC317A0511E5E909927D2A4D86E9A4A225C9D1", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B21A15EEC25E0EB75AE647D72BDC36BD9C3A969BCEBEC4", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_990F1921257D0505AC317A0511E5E909927D2A4D86E9A4A225C9D1", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_841A15EEB0BC1C7BB437D1AFB29B36DE9CE8969BD9FAC6", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_990F1921257D0505AC317A0511E5E909927D2A4D86E9A4A225C9D1", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AA1A1577162F83EDD2E647D7599BC67B4E3A5ADC3BF5C8", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_990F1921257D0505AC317A0511E5E909927D2A4D86E9A4A225C9D1", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_811A1583AE6303273F409B4E51BB966796236805572E9D", var_0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_990F1921257D0505AC317A0511E5E909927D2A4D86E9A4A225C9D1", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A31C18EE0B5EC17BD2CDE8D71A588D1DEBDC2B5DA393851BFA85", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A71C18D07A309198DFEEBD20F02720511132C858438AEBB02F0A", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A11C18EE0BBC83F65AE68EEB0D16D88EAFE695D51DE48536FAB1", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_991C18AF67FA13151BB0FB41E8638D5B9658052505639F1D4FF8", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AB1C189F2B20F24F433043F918AF9B2BB98D05056993FE0B6049", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B18B105C890FE32FAC1AA0F19246F1BB3F31", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B48B104BB958E07A335DAB0FB9EF923CC161", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_958B10DD58F238DBA59BE8EB43B0B1D17D1B", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A68B10EE58BC0EDE2DDC8ED743858D3AAF46", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B68B10DD16CBE0F6D2E63A7D862CB1A3F52B", var_0, "_encstr_88BF06FD784A6393", "_encstr_AD8D148AA9A9A2F1337B1831F1DF0DA22D30B177A8A1", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A2EE130837C9A3773205AD209C6AA9EB31F33BD19F", var_0, "_encstr_88BF06FD784A6393", "_encstr_9105170873C951B1F03147E1F85887E6C42FA17321E3211157", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B6EE13D3891B6B75F865B49701D0FD234BC06AD971", var_0, "_encstr_88BF06FD784A6393", "_encstr_9105170873C951B1F03147E1F85887E6C42FA17321E3211157", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B4EE137F63239BF7D8409BA978600C13F3E5B767CF", var_0, "_encstr_88BF06FD784A6393", "_encstr_9105170873C951B1F03147E1F85887E6C42FA17321E3211157", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B2EE13F3887362C758581C3F6361F32BFB687A09C8", var_0, "_encstr_88BF06FD784A6393", "_encstr_9105170873C951B1F03147E1F85887E6C42FA17321E3211157", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A6EE13CF414098A0B7EA8B16726FE9709CD66727ED", var_0, "_encstr_88BF06FD784A6393", "_encstr_9105170873C951B1F03147E1F85887E6C42FA17321E3211157", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BA411567BF22CBDDD388B319F8075513191EECED458ED7", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A16419C512E9B99757E8CC3550B658E174874F27E683A9C60B10A5", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_954115DD2CE583F6D2731DF5D8DE37E8CA9B3A9532EB26", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A16419C512E9B99757E8CC3550B658E174874F27E683A9C60B10A5", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A24115CC2EE3918001DBF8A9C72FF8C14AD2C55DC7397F", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A16419C512E9B99757E8CC3550B658E174874F27E683A9C60B10A5", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B64115D436FB898809E3F0B1CF57E0C942DACD55CF3179", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A16419C512E9B99757E8CC3550B658E174874F27E683A9C60B10A5", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B44115C331D068E2BBD5D38737503AA4E8DBBBCF098905", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_A16419C512E9B99757E8CC3550B658E174874F27E683A9C60B10A5", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_917013FF4B40922F2350E359F989770EB83B644FE3", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_AFE4171225F5A014B2627A0A11979E0992AF2413F4345A8A88", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8E7013FC1ED3A1D0518B88D9937CE83F5A87FD1036", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_AFE4171225F5A014B2627A0A11979E0992AF2413F4345A8A88", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B87013DF5170A89087FA9BE6224B58F80CAD7117FB", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_AFE4171225F5A014B2627A0A11979E0992AF2413F4345A8A88", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_937013EE85BC07B7D2E61DEB4C1BBDC6B52B46D78C", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_AFE4171225F5A014B2627A0A11979E0992AF2413F4345A8A88", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A1701357AF32DBCDC3784309E031055FA805CCC735", var_0, "_encstr_93B508770F528D90B3DB", "_encstr_AFE4171225F5A014B2627A0A11979E0992AF2413F4345A8A88", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
}

init_relic_doubletap(var_0) {
  var_1 = 0;
  var_2 = 150;
  var_3 = 15;
  level.teamdata[var_0]["_encstr_A7460B06CA52CF18C9D769262C"] = spawnStruct();
  level.teamdata[var_0]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial = [];
  var_7 = var_2;
  var_8 = scripts\engine\utility::ter_op(level.disable_super_in_turret.paths.size <= var_1, level.disable_super_in_turret.paths.size, var_1);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_10 = level.disable_super_in_turret.paths[var_9];
    level.teamdata[var_0]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_10.script_index] = init_relic_damage_from_above(var_0, var_7, var_10);
    var_7 = var_7 + var_3;
  }
}

_id_12206(var_0, var_1, var_2) {
  var_3 = relic_doubletap_helper(var_2);
  var_4 = level.teamdata[var_1]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[var_0.script_index];

  if(isDefined(var_4))
    var_4.choppergunner_refillmissiles.bar.color = var_3;
}

relic_doubletap_helper(var_0) {
  switch (var_0) {
    case "_encstr_8419044EB232":
      return (1, 0, 0);
    case "_encstr_B29B0550F33591":
      return (0, 0.75, 1);
    case "_encstr_957407BAC223B9F05B":
      return (1, 1, 0);
    case "_encstr_932906F74A6F1818":
      return (0, 1, 0);
    case "_encstr_B8BC07D01BBF370877":
      return (1, 0.5, 0);
    case "_encstr_9AED0A14AB406453B68DC3CA":
      return (0.25, 0.5, 1);
    case "_encstr_998806DD1A96D12B":
    default:
      return (1, 1, 1);
  }
}

init_relic_damage_from_above(var_0, var_1, var_2) {
  var_3 = 14;
  var_4 = 14;
  var_5 = 14;
  var_6 = 140;
  var_7 = var_3 + var_4;
  var_8 = newteamhudelem(var_0);
  var_8.fontscale = 1.2;
  var_8.x = var_3;
  var_8.y = var_1;
  var_8.alignx = "_encstr_A5AD056A019C63";
  var_8.aligny = "_encstr_AC190479FF92";
  var_8.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_8.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_8.alpha = 0.5;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;
  var_8.label = var_2._id_12201;
  var_9 = init_tut_doors(var_0, (1, 1, 1), var_6, var_5);
  var_9.x = var_7;
  var_9.y = var_1;
  var_9.alignx = "_encstr_A5AD056A019C63";
  var_9.aligny = "_encstr_AC190479FF92";
  var_9.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_9.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_9.alpha = 0.5;
  var_9 _id_132A8();
  var_9.archived = 1;
  var_9.hidewheninmenu = 1;
  var_9.bar.archived = 1;
  var_9.bar.hidewheninmenu = 1;
  var_9.bar.alpha = 0.5;
  var_8.choppergunner_refillmissiles = var_9;
  var_8.ticks = [];
  var_8.med_transport_initomnvars = [];

  for(var_10 = 0; var_10 < var_2.getquestreward_checkforvalueoverride.size - 1; var_10++)
    var_8.ticks[var_10] = init_relic_doomslayer(var_0, var_7, var_1, var_5, var_6, var_2, var_10);

  for(var_10 = 0; var_10 < var_2._id_11F9E.size; var_10++)
    var_8.med_transport_initomnvars[var_10] = init_structs_mp_br_mechanics(var_0, var_7, var_1, var_5, var_6, var_2, var_10);

  return var_8;
}

last_vampire_sound(var_0) {
  foreach(var_2 in var_0.ticks)
  var_2 destroy();

  var_0.ticks = undefined;

  foreach(var_5 in var_0.med_transport_initomnvars)
  var_5 destroy();

  var_0.med_transport_initomnvars = undefined;
  var_0.choppergunner_refillmissiles.bar destroy();
  var_0.choppergunner_refillmissiles.bar = undefined;
  var_0.choppergunner_refillmissiles destroy();
  var_0.choppergunner_refillmissiles = undefined;
  var_0 destroy();
}

_id_132A8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "_encstr_A5AD056A019C63";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;
  self.bar.x = self.x;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

init_tut_doors(var_0, var_1, var_2, var_3, var_4) {
  var_5 = newteamhudelem(var_0);
  var_5.x = 0;
  var_5.y = 0;
  var_5.frac = 0;
  var_5.color = var_1;
  var_5.sort = -2;
  var_5.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_5 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_2, var_3);
  var_5.hidden = 0;

  if(isDefined(var_4))
    var_5.flashfrac = var_4;

  var_6 = newteamhudelem(var_0);
  var_6.elemtype = "_encstr_B61904310B39";
  var_6.width = var_2;
  var_6.height = var_3;
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_6.bar = var_5;
  var_6.children = [];
  var_6.sort = -3;
  var_6.color = (0, 0, 0);
  var_6.alpha = 0.5;
  var_6 scripts\mp\hud_util::setparent(level.uiparent);
  var_6 setshader("_encstr_929210CB2BA86FFEB853E3571327CBC1164F", var_2, var_3);
  var_6.hidden = 0;
  return var_6;
}

init_relic_doomslayer(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1;
  var_8 = var_5.getquestreward_checkforvalueoverride[var_6].loot_choppers / var_5._id_13BF1;
  var_9 = var_1 + var_8 * var_4;
  var_10 = newteamhudelem(var_0);
  var_10.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_10 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_7, var_3);
  var_10.x = var_9;
  var_10.y = var_2;
  var_10.alignx = "_encstr_A5AD056A019C63";
  var_10.aligny = "_encstr_AC190479FF92";
  var_10.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_10.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_10.alpha = 0.5;
  var_10.glowalpha = 0;
  var_10.hidewheninmenu = 1;
  var_10.archived = 1;
  var_10.color = (1, 1, 1);
  return var_10;
}

init_structs_mp_br_mechanics(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 3;
  var_8 = 4;
  var_9 = var_5._id_11F9E[var_6].dist / var_5._id_13BF1;
  var_10 = var_1 + var_9 * var_4 - var_7 / 2.0;
  var_11 = var_2 + var_3 / 2.0 - var_8 / 2.0;
  var_12 = newteamhudelem(var_0);
  var_12.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_12 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_7, var_8);
  var_12.x = var_10;
  var_12.y = var_11;
  var_12.alignx = "_encstr_A5AD056A019C63";
  var_12.aligny = "_encstr_AC190479FF92";
  var_12.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_12.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_12.alpha = 1.0;
  var_12.glowalpha = 0;
  var_12.hidewheninmenu = 1;
  var_12.archived = 0;
  var_12.color = relic_oneclip_monitor(var_0, 0);
  return var_12;
}

has_balloon() {
  foreach(var_1 in level.teamnamelist) {
    if(isDefined(level.teamdata[var_1]["_encstr_A7460B06CA52CF18C9D769262C"])) {
      foreach(var_3 in level.teamdata[var_1]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial)
      last_vampire_sound(var_3);
    }
  }
}

init_trap_room_obj(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.archived = 0;
  return var_2;
}

init_trap_room_interactions(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.frac = 0;
  var_3.color = var_0;
  var_3.sort = -2;
  var_3.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_3 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_1, var_2);
  var_3.hidden = 0;
  var_3.archived = 0;
  var_4 = newhudelem();
  var_4.elemtype = "_encstr_B61904310B39";
  var_4.width = var_1;
  var_4.height = var_2;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.bar = var_3;
  var_4.children = [];
  var_4.sort = -3;
  var_4.color = (0, 0, 0);
  var_4.alpha = 0.5;
  var_4 scripts\mp\hud_util::setparent(level.uiparent);
  var_4 setshader("_encstr_929210CB2BA86FFEB853E3571327CBC1164F", var_1 + 4, var_2 + 4);
  var_4.hidden = 0;
  var_4.archived = 0;
  return var_4;
}

init_structs(var_0, var_1) {
  var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0, 100, -100);
  var_2 = (0, var_1[1], 0);
  var_3 = anglesToForward(var_2);
  var_4 = var_0 + var_3 * 110;
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_4, 100, -100);
  var_4 = var_5["_encstr_BD260953AA97E3F014279D"];
  var_6 = vectortopitch(var_5["_encstr_820E07FAE8780B3A4C"]) + 90;
  var_7 = (var_6, var_1[1], 0);
  var_8 = var_0 + var_3 * -30;
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_8, 100, -100);
  var_8 = var_5["_encstr_BD260953AA97E3F014279D"];
  var_6 = vectortopitch(var_5["_encstr_820E07FAE8780B3A4C"]) + 90;
  var_9 = (var_6, var_1[1], 0);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_10.angles = var_7;
  var_10 setModel("_encstr_813E15B33381F0F8F782D679DAC3B890A59139099FA212");
  var_10 notsolid();
  var_10 hide();
  var_10._id_11FA2 = var_4;
  var_10._id_11FA1 = var_7;
  var_10._id_11F97 = var_8;
  var_10._id_11F96 = var_9;
  var_11 = var_1[1] - 90;
  var_10.scriptable = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_10.scriptable.angles = (0, var_11, -1 * var_6);
  var_10.scriptable setModel("_encstr_9B4723737EA354A7EE5298A2C0F9D9CA197A1DE1F1C80F9F47C803D45883A7639AE5791BE9");
  var_10.scriptable unmarkkeyframedmover(1);
  var_10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_10.objidnum != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_10.objidnum, "_encstr_930B07BB1B6B3854FF", var_0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_10.objidnum);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_10.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_10.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_10.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(var_10.objidnum, "_encstr_8EA81FD351E15817570253FEDA87CF8087BE2B0FC9567B502FCA6963B35F0EC0DF");
    _func_421(var_10.objidnum, 1);
  }

  var_10.hostdefensefactormod = 0;
  var_10 _id_11F9B();
  return var_10;
}

_id_13260(var_0, var_1) {
  foreach(var_3 in var_0._id_11F9E) {
    if(var_1 == 0) {
      var_3 show();
      var_3.scriptable setscriptablepartstate("_encstr_865C09FA18EF1B8791C195", "_encstr_83320ADDB7DB01AB8F3FF8E8");
      var_3.scriptable notsolid();
    }

    if(var_3.getquestplunderrewardinstance == var_1) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_3.objidnum);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objidnum);
  }
}

_id_1268D() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    foreach(var_3 in var_1._id_11F9E) {
      if(var_3.getquestplunderrewardinstance == var_1.getquestplunderrewardinstance) {
        if(istrue(self.hostdefensefactormod) && self.team == game["_encstr_991C0AB9ED5B57161FE89B83"] || !istrue(self.hostdefensefactormod) && self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
          self enableplayeruse(self);
          self hudoutlineenableforclient(self, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");
          continue;
        }

        self disableplayeruse(self);
        self hudoutlinedisableforclient(self);
      }
    }
  }
}

_id_144E8() {
  var_0 = 5.0;
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_844711EF8743B6485F8E73AB765B20FD09A7B3");
  self endon("_encstr_844711EF8743B6485F8E73AB765B20FD09A7B3");

  if(!istrue(self.firstinit)) {
    wait 3;
    self.firstinit = 1;
  }

  var_1 = self;
  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setusepriority(-1);
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 setuserange(100);
  var_1 setHintString(&"_encstr_A95A1A9029EB0A829562D35044BC9E4835510A1A26A2F521AA298911");
  var_1.userate = 1;
  var_1.curprogress = 0;
  var_1.usetime = var_0;
  var_1.inuse = 0;
  var_1.playerusing = undefined;
  var_1 _id_11FA0();

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

      continue;
    }

    if(get_cave_combat_logic(var_2)) {
      _id_13880(var_2);
      var_1.playerusing = var_2;
      var_1 makeunusable();
      var_3 = _id_144E9(var_2);

      if(istrue(var_1.isusable))
        var_1 makeusable();

      var_1.playerusing = undefined;

      if(istrue(var_3))
        _id_11F98(var_2);
    }
  }
}

_id_144E9(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_1 = self;
  var_1.id = "_encstr_AFCB082AC1D6A3EA7B73";
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);

  if(!istrue(self.hostdefensefactormod)) {
    var_1.id = "_encstr_8BE206FB5F08C023";
    self.scriptable setscriptablepartstate("_encstr_865C09FA18EF1B8791C195", "_encstr_86BA0988CBC479290FDE04");
  }

  var_2 = gettime();

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && get_alive_able_players(var_0) && var_0 useButtonPressed(1) && istrue(var_0.tuttxtbox)) {
    var_1.curprogress = var_1.curprogress + level.framedurationseconds * var_1.userate;

    if(var_1.curprogress >= var_1.usetime) {
      if(isDefined(var_0))
        _id_138F6(var_0);

      var_1.playerusing = undefined;
      var_1.curprogress = 0.0;
      return 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1);
    waitframe();
  }

  if(self.hostdefensefactormod)
    self show();

  var_1.playerusing = undefined;

  if(isDefined(var_0))
    _id_138F6(var_0);

  if(!istrue(self.hostdefensefactormod)) {
    var_3 = (gettime() - var_2) / 1000;
    _id_11F99(0, var_3);
  } else {
    for(;;) {
      if(isDefined(var_0) && isalive(var_0)) {
        var_4 = var_0 getcurrentweapon();

        if(var_4.basename == "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B") {
          waitframe();
          continue;
        }
      }

      break;
    }
  }

  var_1.curprogress = 0.0;
  return 0;
}

_id_11F9C(var_0) {
  self.isusable = 1;
  self makeusable();
  _id_11FA0();

  if(var_0)
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);

  thread _id_144E8();
}

_id_11F9B() {
  self notify("_encstr_864F154237382DB7F8B36BF22A11B0D718AB80AA1618A2");
  self.isusable = 0;
  self.playerusing = undefined;
  self makeunusable();
  self hudoutlinedisable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
}

_id_13880(var_0) {
  var_1 = self;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_9B3B0DAAC3EA57FDE20F2050271BF1", 0);
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_828C09996A99584D51C7DB", 0);

    var_0.tuttxtbox = 1;

    if(self.hostdefensefactormod) {
      self hide();
      var_0 thread _id_125C3("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B", self);
    } else
      var_0 thread _id_125C0("_encstr_A5A7129E1B4C099D016A4052118357A014D17B68", self);
  }

  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0);
}

_id_138F6(var_0) {
  var_1 = self;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_9B3B0DAAC3EA57FDE20F2050271BF1", 1);
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_828C09996A99584D51C7DB", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B")]](var_1, 0);

  var_0.tuttxtbox = undefined;
  var_0 notify("_encstr_AF9A11981A0B0C2B630A71D92BE39988D04644");
}

get_cave_combat_logic(var_0) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 isonladder())
    return 0;

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()]))
    return 0;

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.squadindex != self.squadindex || var_0.team != self.team)
      return 0;
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.team != self.team)
      return 0;
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() != "_encstr_9A7205B39CB919" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")]](self.cratetype))
          return 0;
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")]](self.cratetype))
        return 0;
    }
  }

  if(!self.isusable)
    return 0;

  if(var_0 isskydiving())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(isDefined(self.playerusing) && self.playerusing != var_0)
    return 0;

  return 1;
}

get_alive_able_players(var_0) {
  if(!scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(var_0 isinexecutionvictim())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(distancesquared(var_0.origin, self.origin) >= 10000)
    return 0;

  if(!self.isusable)
    return 0;

  return 1;
}

_id_11F98(var_0) {
  if(istrue(self.hostdefensefactormod)) {
    self.hostdefensefactormod = 0;
    self.path._id_11F9F++;
    self setHintString(&"_encstr_A95A1A9029EB0A829562D35044BC9E4835510A1A26A2F521AA298911");
    _id_11F99(1);
    self setModel("_encstr_813E15B33381F0F8F782D679DAC3B890A59139099FA212");
    self.origin = self._id_11FA2;
    self.angles = self._id_11FA1;
    self dontinterpolate();
    self show();
    var_1 = 0;

    if(isDefined(self.path.vehicle.tutonplayerkilled) && self.path.vehicle.tutonplayerkilled == self) {
      self.path.vehicle.tutonplayerkilled = undefined;
      self.path.vehicle.cone = undefined;
      self.path.vehicle.carriable_physics_launch = self;
      var_1 = 1;
    } else {
      var_2 = distance2dsquared(self.path.vehicle.origin, self.origin);

      if(var_2 < level.disable_super_in_turret._id_14300)
        var_1 = 1;
    }

    if(var_1)
      _id_11F92(self.path, 0, "_encstr_969210B789CDA385D88D5994B25BBDECAC19");

    foreach(var_4 in level.players) {
      if(!isalive(var_4)) {
        continue;
      }
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_8EFF1C62E5F91A8FB398EA32A198FFD6C08119EB4180691B5550E24BE96D", undefined, var_0);
    }

    if(isDefined(var_0)) {
      foreach(var_4 in level.teamdata[var_0.team]["_encstr_9775086022BE1B413B8B"]) {
        var_7 = getdvarint("_encstr_A917299388F65032DB19ED6675EFAA0A1B20172FD06987AACBAE33DAE88BC2D42628CB17F8C1E2930BCD7F", 500);
        var_4 thread scripts\mp\rank::giverankxp("_encstr_8ADA1E13C9AF0EC2BCC6DB2C32EBBDC49B472CB1D8B2FA9195DCE8E4BDF295C8", 500, var_7, undefined);
        var_4 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptableusestate("_encstr_8ADA1E13C9AF0EC2BCC6DB2C32EBBDC49B472CB1D8B2FA9195DCE8E4BDF295C8", int(250.0), var_4.currentweapon, 1);
        var_4 thread scripts\mp\rank::scoreeventpopup("_encstr_8ADA1E13C9AF0EC2BCC6DB2C32EBBDC49B472CB1D8B2FA9195DCE8E4BDF295C8");
        var_4 thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(500, "_encstr_8ADA1E13C9AF0EC2BCC6DB2C32EBBDC49B472CB1D8B2FA9195DCE8E4BDF295C8");
      }
    }

    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, game["_encstr_991C0AB9ED5B57161FE89B83"]);
  } else {
    self.hostdefensefactormod = 1;
    self.origin = self._id_11F97;
    self.angles = self._id_11F96;
    self dontinterpolate();
    self setHintString(&"_encstr_829A1B0B1249F29D3983D751557F991D7F84319E4197B10175A13C0E78");
    self setModel("_encstr_93161A78F20BBB801DE4C79F0589407E9F7AD161EA27653936F75BAD");
    self.scriptable setscriptablepartstate("_encstr_865C09FA18EF1B8791C195", "_encstr_9AB50CB1F6DCCDD1E4AB6CE82B19");

    if(isDefined(self.path.vehicle.carriable_physics_launch) && self.path.vehicle.carriable_physics_launch == self) {
      self.path.vehicle.tutonplayerkilled = self;
      self.path.vehicle.carriable_physics_launch = undefined;
    }

    if(isDefined(var_0)) {
      foreach(var_4 in level.teamdata[var_0.team]["_encstr_9775086022BE1B413B8B"]) {
        var_7 = getdvarint("_encstr_B469256A131689275AB1B7BABAFF7768BEBB382E99F9F7939B544B9917DB9B10B55B681328DDD1", 1000);
        var_4 thread scripts\mp\rank::giverankxp("_encstr_BE9F1AC66A0111C19153A0D85B9F586DAB93CFDE451A8769655F8068", 1000, var_7, undefined);
        var_4 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptableusestate("_encstr_BE9F1AC66A0111C19153A0D85B9F586DAB93CFDE451A8769655F8068", int(500.0), var_4.currentweapon, 1);
        var_4 thread scripts\mp\rank::scoreeventpopup("_encstr_BE9F1AC66A0111C19153A0D85B9F586DAB93CFDE451A8769655F8068");
        var_4 thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(1000, "_encstr_BE9F1AC66A0111C19153A0D85B9F586DAB93CFDE451A8769655F8068");
      }
    }

    var_11 = self.scriptable physics_getentityaabb();
    var_12 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
    var_13 = physics_aabbbroadphasequery(var_11["_encstr_8719046B4BB9"], var_11["_encstr_B81904B62CC3"], var_12, []);
    var_14 = self._id_11FA2 - self._id_11F97;
    var_15 = vectorNormalize(var_14);
    var_16 = distance(self._id_11FA2, self._id_11F97);
    var_17 = var_16 / 2.0;
    var_18 = self._id_11F97 + var_15 * var_17;

    foreach(var_4 in var_13) {
      if(!isDefined(var_4) || !isalive(var_4)) {
        continue;
      }
      var_20 = var_4.origin - var_18;
      var_21 = vectorNormalize(var_20);
      var_22 = var_4.origin - self._id_11F97;
      var_23 = var_4.origin - self._id_11FA2;
      var_24 = vectordot(var_15, var_22);
      var_25 = vectordot(var_15, var_23);

      if(!(var_24 > 0 && var_25 < 0)) {
        continue;
      }
      var_26 = vectordot(var_15, var_21);
      var_27 = var_26 * var_17;
      var_27 = abs(var_27);
      var_28 = var_17 + 35 - var_27;
      var_28 = var_28 * scripts\engine\utility::sign(var_26);
      var_29 = var_4.origin + var_15 * var_28;
      var_29 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_29, 100, -100);
      var_4 setOrigin(var_29);
    }

    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }

  _id_1318C(self.path.script_index, self.index, self.hostdefensefactormod);

  if(isDefined(var_0))
    _id_12261(var_0, level.disable_super_in_turret._id_11F9D, "_encstr_865C09FA18EF1B8791C195");

  _id_11FA0();
  _id_11FA3(game["_encstr_991C0AB9ED5B57161FE89B83"]);
  _id_11FA3(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
}

_id_11F99(var_0, var_1) {
  var_2 = 2;
  self makeunusable();

  if(var_0) {
    playsoundatpos(self.origin + (0, 0, 50), "_encstr_82DB1D47C94039D85125A78D05DFB0401F830937516897ED66503561A2B90A");
    wait 2;
    self hide();
  }

  var_3 = "_encstr_A1B80BB27FC3932020BA908D67";
  var_4 = var_2;

  if(isDefined(var_1)) {
    if(var_1 <= 2.3) {
      var_3 = "_encstr_AF0311408739C081D2A58480BF0AC3889D7B72";
      var_4 = 0.7;
    } else if(var_1 <= 3) {
      var_3 = "_encstr_9A031190D3DC510137F62C08D63FE80987AA5A";
      var_4 = 1.0;
    } else if(var_1 <= 3.6) {
      var_3 = "_encstr_8C0311C4ABD23691D2379DAF33C24B1B598C66";
      var_4 = 1.4;
    } else if(var_1 <= 4.3) {
      var_3 = "_encstr_A90311A5B7F2514819ED916E17F9E899EA5BBD";
      var_4 = 1.7;
    } else {
      var_3 = "_encstr_BA031189EA4B1B91B49BCEAF3316B4C6564613";
      var_4 = 1.9;
    }
  }

  self.scriptable setscriptablepartstate("_encstr_865C09FA18EF1B8791C195", var_3);
  wait(var_4);

  if(istrue(self.isusable)) {
    self makeusable();
    _id_11FA0();
  }
}

relic_oneclip_monitor(var_0, var_1) {
  if(istrue(var_1)) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
      return relic_doubletap_helper("_encstr_8419044EB232");
    else
      return relic_doubletap_helper("_encstr_B29B0550F33591");
  } else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    return relic_doubletap_helper("_encstr_B29B0550F33591");
  else
    return relic_doubletap_helper("_encstr_8419044EB232");
}

_id_11FA3(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_A7460B06CA52CF18C9D769262C"].choppersupport_modifydamage_trial[self.path.script_index];

  if(isDefined(var_1)) {
    var_2 = var_1.med_transport_initomnvars[self.index];
    var_2.color = relic_oneclip_monitor(var_0, self.hostdefensefactormod);
  }
}

_id_11FA0() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9775086022BE1B413B8B");
  var_1 = scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9775086022BE1B413B8B");

  if(istrue(self.hostdefensefactormod)) {
    foreach(var_3 in var_0)
    self enableplayeruse(var_3);

    foreach(var_3 in var_1)
    self disableplayeruse(var_3);

    if(var_0.size > 0)
      self hudoutlineenableforclients(var_0, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");

    if(var_1.size > 0) {
      self hudoutlinedisableforclients(var_1);
      return;
    }
  } else {
    foreach(var_3 in var_1)
    self enableplayeruse(var_3);

    foreach(var_3 in var_0)
    self disableplayeruse(var_3);

    if(var_1.size > 0)
      self hudoutlineenableforclients(var_1, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");

    if(var_0.size > 0)
      self hudoutlinedisableforclients(var_0);
  }
}

_id_11F92(var_0, var_1, var_2, var_3) {
  thread _id_14301(var_2, var_3, var_0);

  if(istrue(var_1))
    _id_12194(var_0.label);
}

timed_laser_trap_trigger() {
  level.disable_super_in_turret.overtime = [];
  _id_121A3();
  _id_13189(0);
  level thread _id_11E10();
}

_id_12194(var_0) {
  _id_121A3();

  if(_id_12198())
    level.disable_super_in_turret.overtime[var_0] = level.disable_super_in_turret._id_121A2 + _id_1219D();
  else
    level.disable_super_in_turret.overtime[var_0] = gettime();

  level.disable_super_in_turret.overtime[var_0] = level.disable_super_in_turret.overtime[var_0] + respawn_solo() * 1000;
}

_id_12198() {
  var_0 = _id_1219B();
  return var_0 >= _id_1219D();
}

_id_1219B() {
  if(isDefined(level.disable_super_in_turret._id_121A2))
    return gettime() - level.disable_super_in_turret._id_121A2;

  return 0;
}

_id_1219C() {
  return level.disable_super_in_turret._id_12199;
}

_id_1219D() {
  return int(_id_1219C() * 1000);
}

_id_121A3() {
  var_0 = _id_1219B();
  var_1 = var_0 / 1000;
  var_2 = [5.0, 4.0, 3.0, 2.0, 1.0];

  if(var_1 < level.disable_super_in_turret._id_1219E || _id_12198())
    var_3 = var_2[0];
  else if(var_1 < level.disable_super_in_turret._id_1219F)
    var_3 = var_2[1];
  else if(var_1 < level.disable_super_in_turret._id_121A0)
    var_3 = var_2[2];
  else if(var_1 < level.disable_super_in_turret._id_121A1)
    var_3 = var_2[3];
  else
    var_3 = var_2[4];

  level.disable_super_in_turret._id_1219A = var_3;
  _id_13188(int(var_3));
}

respawn_solo() {
  return level.disable_super_in_turret._id_1219A;
}

respawn_state_greyout(var_0) {
  var_1 = var_0;
  var_1 = var_1 - gettime();

  if(var_1 <= 0)
    var_1 = 0;

  return var_1;
}

respawn_trigger_think() {
  var_0 = gettime();

  foreach(var_3, var_2 in level.disable_super_in_turret.overtime) {
    if(var_2 > var_0)
      var_0 = var_2;
  }

  _id_13189(respawn_state_greyout(int(var_0)));
  return int(var_0);
}

respawn_state_ready() {
  var_0 = respawn_trigger_think();
  var_0 = (var_0 - gettime()) / 1000;

  if(var_0 <= 0)
    var_0 = 0;

  return var_0;
}

respawn_state_hidden() {
  var_0 = respawn_trigger_think();
  var_0 = var_0 - gettime();

  if(var_0 <= 0)
    var_0 = 0;

  return var_0;
}

waittill_player_uses_munition() {
  var_0 = respawn_state_ready();

  if(var_0 <= 0)
    return 0;

  _id_12194("_encstr_A1570C5BD29BD39D2B931D2DAD2B");
  level.timelimitoverride = 1;
  level.disable_super_in_turret._id_121A2 = gettime();
  level notify("_encstr_8DF60F23B0D392DBEE488E95DE53779D73");
  thread _id_14301("_encstr_8B6D0940CC35339149DA08");
  level thread waittill_player_uses_scavenger_contract();

  while(scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0)
    waitframe();

  level notify("_encstr_9BFB0EB9A3DB1C7DF6B395398E96B695");
  _id_13189(0);
  level.timelimitoverride = 0;
  level.disable_super_in_turret._id_121A2 = undefined;
  _id_121A3();
  return scripts\mp\gamelogic::gettimeremaining() > 0;
}

waittill_player_uses_scavenger_contract() {
  level endon("_encstr_9BFB0EB9A3DB1C7DF6B395398E96B695");

  for(;;) {
    waittillframeend;
    var_0 = respawn_state_ready();
    waitframe();
  }
}

_id_12197() {
  return scripts\mp\gamelogic::gettimeremaining() <= 0 && respawn_state_ready() > 0;
}

_id_12193() {
  var_0 = "_encstr_9708136EB193EB7BCE5927E8D2DA2BD7C859985DB3";
  setDvar(var_0, 0);

  for(;;) {
    while(!getdvarint(var_0, 0))
      wait 0.5;

    var_1 = scripts\mp\hud_util::createservertimer("_encstr_A6F60722FD29B27FD9", 1.0);
    var_1 scripts\mp\hud_util::setpoint("_encstr_9A490B0C9DF56BA6AF8961E879", undefined, 15, -80);
    var_1.color = (1, 0, 0);
    var_1.archived = 0;
    var_1.label = &"_encstr_844E13CF8B026EF8093DC171AAED88284A2B2FAD6A";
    var_2 = scripts\mp\hud_util::createservertimer("_encstr_A6F60722FD29B27FD9", 1.0);
    var_2 scripts\mp\hud_util::setpoint("_encstr_9A490B0C9DF56BA6AF8961E879", undefined, 15, -60);
    var_2.color = (1, 0, 0);
    var_2.archived = 0;
    var_2.label = &"_encstr_8B3F1727C5C5D5E932612DFA91DA3BA2DE1DBB3635E0D99722";
    var_3 = scripts\mp\hud_util::createservertimer("_encstr_A6F60722FD29B27FD9", 1.0);
    var_3 scripts\mp\hud_util::setpoint("_encstr_9A490B0C9DF56BA6AF8961E879", undefined, 15, -40);
    var_3.color = (1, 0, 0);
    var_3.archived = 0;
    var_3.label = &"_encstr_B808119B8FB00B98563DE6129821F3FF4FFDC8";
    var_4 = scripts\mp\hud_util::createservertimer("_encstr_A6F60722FD29B27FD9", 1.0);
    var_4 scripts\mp\hud_util::setpoint("_encstr_9A490B0C9DF56BA6AF8961E879", undefined, 15, -20);
    var_4.color = (1, 0, 0);
    var_4.archived = 0;
    var_4.label = &"_encstr_A78015A8B7D185C6013D9D56C9A32DDA9501D485F0A380";

    while(getdvarint(var_0, 0)) {
      waitframe();
      waittillframeend;
      var_1 setvalue(respawn_state_ready());
      var_2 setvalue(respawn_solo());
      var_3 setvalue(_id_1219B() / 1000);
      var_4 setvalue(_id_1219C());
    }

    level notify("_encstr_9BFB0EB9A3DB1C7DF6B395398E96B695");
    var_1 destroy();
    var_2 destroy();
    var_3 destroy();
    var_4 destroy();
  }
}

timed_death() {
  if(!level.disable_super_in_turret.checkpoint_objective) {
    return;
  }
  var_0 = [];

  if(isDefined(level.disable_super_in_turret.wait_for_gl_pickup) && level.disable_super_in_turret.wait_for_gl_pickup.size > 0) {
    foreach(var_2 in level.disable_super_in_turret.wait_for_gl_pickup) {
      var_3 = var_2.script_group;

      if(!isDefined(var_3)) {
        continue;
      }
      var_4 = respawndelayoverride(var_3);

      if(isDefined(var_4)) {
        var_5 = var_2.angles;

        if(!isDefined(var_5))
          var_5 = (0, 0, 0);

        var_6 = easepower("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", var_2.origin, var_5);

        if(isDefined(var_6)) {
          var_6.path = var_4;
          var_6.getquestplunderrewardinstance = var_2.script_index;

          if(!isDefined(var_6.getquestplunderrewardinstance))
            var_6.getquestplunderrewardinstance = 0;

          var_0[var_0.size] = var_6;
          var_4.wait_for_computer_power[var_4.wait_for_computer_power.size] = var_6;
        }
      }
    }
  }

  if(var_0.size == 0) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      foreach(var_10 in var_4.wait_for_at_least_one_player_spawns_in) {
        var_11 = var_4.nodes[var_10].origin;
        var_12 = respawningbr(var_4, var_10);
        var_6 = init_seq_button(var_11, var_12, var_4.script_index);

        if(isDefined(var_6)) {
          var_6.path = var_4;
          var_6.getquestplunderrewardinstance = var_4.script_index;

          if(!isDefined(var_6.getquestplunderrewardinstance))
            var_6.getquestplunderrewardinstance = 0;

          var_0[var_0.size] = var_6;
          var_4.wait_for_computer_power[var_4.wait_for_computer_power.size] = var_6;
        }
      }
    }
  }

  thread _id_1316A(var_0);
}

_id_1316A(var_0) {
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_id_131C0(var_0);
}

init_seq_button(var_0, var_1, var_2) {
  var_3 = 300;
  var_4 = 600;
  var_5 = 50;
  var_6 = 100;
  var_7 = vectortoangles(var_1);
  var_8 = anglestoright(var_7);
  var_9 = -1 * var_8;

  for(var_10 = var_3; var_10 <= var_4; var_10 = var_10 + var_5) {
    var_11 = var_0 + var_10 * var_8;
    var_12 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_11);
    var_13 = abs(var_0[2] - var_12[2]);

    if(var_13 < var_6) {
      var_14 = vectortoangles(var_9);
      var_15 = easepower("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", var_12, var_14);
      return var_15;
    }

    var_16 = var_0 + var_10 * var_9;
    var_17 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_16);
    var_13 = abs(var_0[2] - var_17[2]);

    if(var_13 < var_6) {
      var_14 = vectortoangles(var_8);
      var_15 = easepower("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", var_17, var_14);
      return var_15;
    }
  }
}

isusingremotekillstreak(var_0, var_1, var_2, var_3) {
  isteamonlycrate(var_0, var_1, var_2, (0, 1, 0), var_3);
}

isspreadweapon(var_0, var_1, var_2, var_3) {
  isteamonlycrate(var_0, var_1, var_2, (1, 1, 0), var_3);
}

isteamonlycrate(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    if(getdvarint("_encstr_8C1D0F73C8A99D9A5147E31C27C7B25EB3", 0) != var_2) {
      waitframe();
      continue;
    }

    if(isDefined(var_1)) {}

    if(isDefined(var_4)) {}

    waitframe();
  }
}

_id_13257(var_0, var_1) {
  foreach(var_3 in var_0.wait_for_computer_power) {
    if(var_3.getquestplunderrewardinstance == var_1) {
      var_3 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_BE8B08E323FB2BCD6268");
      continue;
    }

    var_3 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_95DF070DD22319CA9B");
  }
}

toggle_in_use() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_B8FE12888F7188DFEAEF405692E7A956DC1FE820");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_AFBA1B5BA5365AA3C2C9F2F5D8584ECA1CC28DD60BD9ACAF60C4EB9893";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 2.0;
  var_0.otherusetime = 2.0;
  var_0.activatecallback = scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
  var_0.capturecallback = ::dialog_wait_think_civ;
  var_0.destroycallback = scripts\cp_mp\killstreaks\airdrop::dialogqueue;
  var_0.ingame = scripts\cp_mp\killstreaks\airdrop::dialogueindex;
  var_0.destroyoncapture = 0;
}

dialog_wait_think_civ(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA51129F3EFD14A0A6239BBDDF03738838BBB");
  var_0._id_12CD2 = 1;
}

eliminate_drone_spotlight_speed() {
  return !istrue(self._id_12CD2);
}

init_relic_fastbleedout(var_0, var_1) {
  if(var_1 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    var_0._id_133CE = 1;

  return var_0;
}

tracegroundheightexfil() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_830E100EC2CB63B75846F577CA36D8DED6B2"] = "_encstr_97CA1159EED59085530B1B6723FA4B607F46A1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AADE09481E247875C2EFAB"] = "_encstr_88021AD721606D434319679701675BACC8898F5178683C5A1DC34F77";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87EE0C73E808CD9B5B8F698AD6B9"] = "_encstr_A3BF0E23764950802AD3F73527B2DB08";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86130BDBE85257EFE03B889E4A"] = "_encstr_93540F830BE536DE2CC8D71B18AF37CA6C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF130B80B27DE343E748905D65"] = "_encstr_8C4A0FDBF163533DE039A73463E9C2BF86";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA130B8E96B5B29BAB1CFA8C18"] = "_encstr_8FB90F70DF42DBBDA378A16FC287F2B779";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7130B8318F83D6B8B5FB93A67"] = "_encstr_B4900F332ADF0148764C9F7B20D1605D6F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA410C0EC2E58DEDB032AFEDED98"] = "_encstr_8D410C0766ABE1D851BBD960C77C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81E7093272DCB353B86F77"] = "_encstr_8272173BF0D26CF2CB3DC1461DD92A2B3899B34BB8ABD9EB2B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A77125E350A01AB8157703147DB834B021AC555"] = "_encstr_8A77125E350A01AB8157703147DB834B021AC555";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDF2124A9048531A8057ECFF6FC8E50BE149B352"] = "_encstr_BDF2124A9048531A8057ECFF6FC8E50BE149B352";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6C60ED8EDB9E8C9B08DD1AF33C2D236"] = "_encstr_A6C60ED8EDB9E8C9B08DD1AF33C2D236";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87C10EC247D10BC65BD7A573E839BDC4"] = "_encstr_AC0C1D6F19B72DBB1343704E503D23D671BBE6FBE0F52E55E703A965C2701A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDC10E2C3A1DC2365BF5B4CDA393EDC8"] = "_encstr_83F51EC7AFFB725C02B0AF3F68F9135AC7BFCEF88117CA94EE10E39B6811F397";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87A7129FB8934112FF80EA67F6BB7B01B8B8EF27"] = "_encstr_9A571A49C9F8C0281FD266A93BA3D740941FF3F960E4E078775A5BD1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92A712F993037FD01C9F5F7BCBC39333C31AB601"] = "_encstr_AAE01A4B1E3128F842CBDFABA33B3788CB79F183868678B8FAFFB5BB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A60310C0FBA3EF1E2FA1958F938ADDC97F70"] = "_encstr_AFC6166B41D3C3AD7049D7F171A3F637723EF20149A7A7E4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A0310F26BDD6F36A8476C67F750BDAF9001"] = "_encstr_869016EF8E430920A95341B87BD4B94FCAB96EE0A63ADF68";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84DA1362853B1A3AE2F1E14F9B08A9EB8308C167BA"] = "_encstr_91DE19C7214B7A279FB3FED99323A38F5F1071FF38107EE3FFA7C4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8ADA130BD13A2CC6B5F5D8ED378E95E6A3568CAFC4"] = "_encstr_883A19137988A8105B335129C17BF90648B1CA3F972A36BB799F69";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2A011711B8BE748941785E15FFE40BD9301C9"] = "_encstr_871E19FA571B2A9FD9D87F8FB093490297E006B94E4952DBA0C86B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6A01179CDDCF156A76F461B479E6D37A5F6A3"] = "_encstr_879119380BF2B1BDC223EB2CE84785C6B5EB26EB31B1F68DADCA8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A17512029B2D9FC678975F5AA7E80EEF59D1798A"] = "_encstr_A2250E82B150F4623F41FFC7B5DEA931";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A77512EFC8E31142AFD05D162E49BADB48F89F7B"] = "_encstr_B6250E07585E1BF65846D7ED139BAF26";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABA3125847A3C2C6B5FAE656365D93CA324CAF58"] = ["_encstr_8D4719A3F0DFA55A638F3903C3C4677182F19249F6657EB6E5EFEA", "_encstr_A134154F2F3B410AEF725790F3A5BEA22AB86FFA80D7BA"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83A3120B47E8B06C5BFA9B598DEA392BC889EB26"] = ["_encstr_9B84190E585ED8F65819EB0BD147166C6DD731FA9BAEB1C6ACCDDC", "_encstr_A134154F2F3B410AEF725790F3A5BEA22AB86FFA80D7BA"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7A31285E81D586C6DFAE62BD8AB4EAC23C8AFC2"] = ["_encstr_8D4719A3F0DFA55A638F3903C3C4677182F19249F6657EB6E5EFEA", "_encstr_8F3415B7D61B5168E1EB8960B32C618782F1AEB7EB11B5"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3A312588ED10BB15B7D6E95D8AB2756C88C7D31"] = ["_encstr_9B84190E585ED8F65819EB0BD147166C6DD731FA9BAEB1C6ACCDDC", "_encstr_8F3415B7D61B5168E1EB8960B32C618782F1AEB7EB11B5"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1A3120BA38E16B1ADD7DCCA1BAB39959199F558"] = ["_encstr_AF8D167B2E0118C8921B2F5B73EB07D8BB09E3D11348C9F7", "_encstr_A33415D84A5EB988EF14D8CFFC43B16F6C3148E8B3D17F"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAA3124125939FCEC7F133AAE8034247492EF7FA"] = ["_encstr_A98D16D0119B5A4517D5B72F1005C186F79FE25143FC799B", "_encstr_A33415D84A5EB988EF14D8CFFC43B16F6C3148E8B3D17F"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D4719A3F0DFA55A638F3903C3C4677182F19249F6657EB6E5EFEA"] = "_encstr_8D4719A3F0DFA55A638F3903C3C4677182F19249F6657EB6E5EFEA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B84190E585ED8F65819EB0BD147166C6DD731FA9BAEB1C6ACCDDC"] = "_encstr_9B84190E585ED8F65819EB0BD147166C6DD731FA9BAEB1C6ACCDDC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF8D167B2E0118C8921B2F5B73EB07D8BB09E3D11348C9F7"] = "_encstr_AF8D167B2E0118C8921B2F5B73EB07D8BB09E3D11348C9F7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A98D16D0119B5A4517D5B72F1005C186F79FE25143FC799B"] = "_encstr_A98D16D0119B5A4517D5B72F1005C186F79FE25143FC799B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A134154F2F3B410AEF725790F3A5BEA22AB86FFA80D7BA"] = "_encstr_A134154F2F3B410AEF725790F3A5BEA22AB86FFA80D7BA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F3415B7D61B5168E1EB8960B32C618782F1AEB7EB11B5"] = "_encstr_8F3415B7D61B5168E1EB8960B32C618782F1AEB7EB11B5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A33415D84A5EB988EF14D8CFFC43B16F6C3148E8B3D17F"] = "_encstr_A33415D84A5EB988EF14D8CFFC43B16F6C3148E8B3D17F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_859210DEBD619AF3F8611F7398F3BC423B5D"] = "_encstr_B8EA185B90B2CC526B9D61E6FD39CA8B98F9AFFB180B2CFA5B25";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_924D0F8A3871CE1FE028EE1DDF2B9E9983"] = "_encstr_9AE01791DFC371809A252E58D140E0E794B7AF299613D2F6F2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE4D0FB08EA30B8D5BFA73560B9CC4BE31"] = "_encstr_A7271707C2F236ED168CF5C28ED158366DF54CF53759583962";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B44D0F39B1F806EFD286922AA9B65271B8"] = "_encstr_BAE0170E165E1BF68523F5C2D1E82CB1B6FAB0BECDAC582764";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_954D0F163A8E58D8DAAF9B95C2C991F5C4"] = "_encstr_A32717637A8F5118063CEF8B342B20AEBFF1B90E32571F080A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_884D0FB01DE8C28D6D7D9BCA0B27CCBE85"] = "_encstr_A9E017A3A8538527B9BDD7E14DE3E78E9FC13AE97833BE1BDB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_974D0F52CB7DCF9608E70E0DB3E84AEFAE"] = "_encstr_932717D959685098AF62F6394BD347F0048F050FCED7705E9E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1CA105F8423D93F24F13858FA7CD730DF3C"] = "_encstr_A53413C3C833A507999DF7C1AD0307AEBFA13BAA58";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84BD0FD09BC3238947AF4EC567D313E32F"] = "_encstr_9913145F0BAB412FBB1D61C81BF3FFBFD2F09C08936F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81980E74BDC19F9DC901620A403D1506"] = "_encstr_8B1F1D01266291DB709B9B81C270B73BFE1AA0AA49B749A05F2F353CCAD5BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88980E8C563359738CF54B734793DE23"] = "_encstr_86071ECF61A5D0CD17EB4936925F06A871E84B8B048D481D67424119EA1BB5FA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2D103CE599C7D581B9FAC2B0F38D97165F"] = "_encstr_9344160357877A1DD0CFD13F2DA2EB6D5B112A50D570C4BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC2D1032CA99B237C8F5B1B76EA537B3BE98"] = "_encstr_AC38161C2CF2B1F61646FA1959CC2B9B32FA137DB5BDCECA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DA5123256332BE6C8F5B9CA8DEA392DCDCEEB58"] = "_encstr_9A541949C9F8C0281FD266092AEBD528571FF39F62A748EE57BA1B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CA512F23099C18D9DE0483B33085869E2C7591E"] = "_encstr_B8161950D7CAB23873198FD1F368CF5B22AF5657D2411553597E3D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96DA1323ACCCCADC23D78DB79B472B371D568CD785"] = "_encstr_AFAC19B28160C4522F51EF1B4B443A0E70AE6EF179789E9B75574B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87DA133A65D2E9D3DD114357EA239DD773DA1869EA"] = "_encstr_A2B2190E0BF263BD2C46D78CAC99597346AF98BE6CBDE6D1B2373A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF51118C2B66ACDCC87D13C6F636B5568C7D0B"] = "_encstr_825A171B02F739705E6447398D47F8F02B59B1665ADBE058F4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D5111C2B74307E09FDF19B12F23C39842F92E"] = "_encstr_9672174388AAE47A53A549BF1D7592BE5111737708A02F62BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99721259B735B96D51D9982B7718F9C8B9E2E149"] = "_encstr_832D19FB876380EDF63AF001BD518DAD17D94761D96F16030B28BB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B7212A3FB1C7A4623F6CD966B5891D2E103C723"] = "_encstr_A1B2194137D8A1989A697773D2304DE85C7F8E2884D06B35EA5D7B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFE00FC82B33ACDCC8D7D87B37A3C4F558"] = ["_encstr_81D91BC12CBCC6BD1646BE8CCACC2BDC46EBC64EDEE6DC7D662CD263C4", "_encstr_938115FFA92F400F8E9A19C8A267C3D8B36F86FF140FA3"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9AE00FB9DDFD6388CAB84828DF406217D6"] = ["_encstr_81D91BC12CBCC6BD1646BE8CCACC2BDC46EBC64EDEE6DC7D662CD263C4", "_encstr_938115FFA92F400F8E9A19C8A267C3D8B36F86FF140FA3"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95E00F8CCA3359DC19BE367B3747C8D7C2"] = ["_encstr_ADD91BB9390830F8CF02D6B97ABBA578E7AF2735AF729B28EB4A68A037", "_encstr_9181152F79FF90FF7E6AC91812D793A8E3DF362FC4BF93"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2E00F99081D20601CF9CD0A727CF631FA"] = ["_encstr_ADD91BB9390830F8CF02D6B97ABBA578E7AF2735AF729B28EB4A68A037", "_encstr_9181152F79FF90FF7E6AC91812D793A8E3DF362FC4BF93"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91E00FCDA1C4EA238B5F9818522307F777"] = ["_encstr_959D16B3B3D3AA0768D18157E90855C225B73B6F31F341C1", "_encstr_8F8115AF1A5B60BF51B9699D617447F8D8175F7273175B"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EE00F32CACCACCD91EB367B9B47CCAF4C"] = ["_encstr_A69D166847D1FC558F83D83B6F1CC1F5A5F6EBCAFB68697A", "_encstr_8F8115AF1A5B60BF51B9699D617447F8D8175F7273175B"];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81D91BC12CBCC6BD1646BE8CCACC2BDC46EBC64EDEE6DC7D662CD263C4"] = "_encstr_81D91BC12CBCC6BD1646BE8CCACC2BDC46EBC64EDEE6DC7D662CD263C4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADD91BB9390830F8CF02D6B97ABBA578E7AF2735AF729B28EB4A68A037"] = "_encstr_ADD91BB9390830F8CF02D6B97ABBA578E7AF2735AF729B28EB4A68A037";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_959D16B3B3D3AA0768D18157E90855C225B73B6F31F341C1"] = "_encstr_959D16B3B3D3AA0768D18157E90855C225B73B6F31F341C1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A69D166847D1FC558F83D83B6F1CC1F5A5F6EBCAFB68697A"] = "_encstr_A69D166847D1FC558F83D83B6F1CC1F5A5F6EBCAFB68697A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_938115FFA92F400F8E9A19C8A267C3D8B36F86FF140FA3"] = "_encstr_938115FFA92F400F8E9A19C8A267C3D8B36F86FF140FA3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9181152F79FF90FF7E6AC91812D793A8E3DF362FC4BF93"] = "_encstr_9181152F79FF90FF7E6AC91812D793A8E3DF362FC4BF93";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F8115AF1A5B60BF51B9699D617447F8D8175F7273175B"] = "_encstr_8F8115AF1A5B60BF51B9699D617447F8D8175F7273175B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAD010D17D8F38389BF1103BBA2BED80E5D5"] = "_encstr_84E91890976980D712E758DDBFBA1B08DCD7E038EF1ADB93FA4F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88840F235699CACD8C7DCD56169326BE2C"] = "_encstr_8C3D17801258D1E0977CB01555A3E98D479970717AF7039B2E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96840F19B2992BCD91FADCCA163926F589"] = "_encstr_928317B877EA73657B9059E2B05DDFC3E1F0321F18B18F6A83";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2840F91CA662B9B32BECD59C29C8CAFC2"] = "_encstr_B13D1778CBC015AFA791D16A990CDFCD40CFE1CF7D989E13F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1840F0BB051C54261AF2DE77735FFB7B9"] = "_encstr_878317AFCE034960E9138150FF06F9957AF92EA065BA1B8B82";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95840F11BD4FF8F85B317019BA6B0E7126"] = "_encstr_BA3D1760BF22BBDDC3D801AAC815977B3908F9D740C9D7A24F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA840FB5BD446DABEA71EDCBA9FB732812"] = "_encstr_BD8317CB9EB1A878C24B5F21679AB56044F971A6C51588AE9F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84D30F6A2BE57F9B91B8637C48FB2B8719"] = "_encstr_91E113C7214B7A279FB3FE79D761AB956310679350";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F20103CCDF5B218457E5E63EDA95310C5F8"] = "_encstr_8B5514EFB93F503FBEAA09D85297D3E8A31F79E80317";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91830E2E77CFD0E9F11B98207217BF0B"] = undefined;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFC40E0B1F055ADC4961FEC41820F222"] = undefined;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5010B93F6EA73917D234E16BB"] = undefined;
}

_id_14301(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_2._id_14307 = "_encstr_8BBA05185F8B99";
    var_2._id_14306 = gettime() + level.disable_super_in_turret._id_14305;
    var_2._id_142F9 = gettime() + level.disable_super_in_turret._id_142F8;
    return;
  }

  if(isDefined(var_3))
    wait(var_3);

  var_4 = _id_1332C(var_0);
  var_5 = isDefined(var_2) && var_2._id_14307 == var_0;

  if(!var_4 && var_5 && isDefined(var_2) && var_2._id_14306 > gettime() && var_2._id_142F9 > gettime()) {
    var_2._id_142F7 = gettime() + level.disable_super_in_turret._id_142F6;
    return;
  }

  if(!var_4 && !var_5 && isDefined(var_2) && var_2._id_142F7 > gettime()) {
    var_2._id_142F9 = gettime() + level.disable_super_in_turret._id_142F8;
    var_2._id_14306 = gettime() + level.disable_super_in_turret._id_142FF;
    return;
  }

  var_6 = var_5 && isDefined(var_2) && var_2._id_142F9 <= gettime();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = var_4;
  var_10 = var_4;
  var_11 = undefined;

  switch (var_0) {
    case "_encstr_B42E085325A82CB3F221":
      var_7 = "_encstr_A12410F0BBE3C369A74FAEAD4BE7739BCD12" + var_2.iconname;
      var_8 = "_encstr_BD630E71AA634580F7B73907A39CC81C" + var_2.iconname;

      if(var_6)
        var_10 = 1;

      break;
    case "_encstr_8C1F08DAF5A51A223B70":
      var_7 = "_encstr_95F30E220153D056A0AF093710C452EF" + var_2.iconname;
      var_8 = "_encstr_B4F910499FAEE0F892A707237FAB3E584EF7" + var_2.iconname;

      if(var_6)
        var_9 = 1;

      break;
    case "_encstr_B85C0AD87B9B8E95CD8E2B46":
      var_7 = "_encstr_8DF91102B0F9568768509B9FD053471A5180DA" + var_2.iconname;
      var_8 = "_encstr_AADB11E3527A4A8ED7396178CDD0C7936BB3FD" + var_2.iconname;

      if(var_6)
        var_9 = 1;

      break;
    case "_encstr_A359083664B761C74F5A":
      var_7 = "_encstr_A3630F43F46370C6DF9929D0A2C78A183F" + var_2.iconname;
      break;
    case "_encstr_969210B789CDA385D88D5994B25BBDECAC19":
      var_7 = "_encstr_B8A4105003BB784AE2297FFACB10898F08CF" + var_2.iconname;
      var_8 = "_encstr_85CE10AB10F125A281E08DC6DE996AEB1888" + var_2.iconname;
      break;
    case "_encstr_A7460B06CA52CF18C9D769262C":
      var_7 = "_encstr_BEDF0FE27BCD7F2658B7637DE780AAD77D" + var_1 + var_2.iconname;
      var_8 = "_encstr_822E0C3D758BB9C507D148480B5B" + var_1 + var_2.iconname;
      var_11 = 2;
      break;
    case "_encstr_8B6D0940CC35339149DA08":
      var_7 = "_encstr_859210DEBD619AF3F8611F7398F3BC423B5D";
      var_8 = "_encstr_BAD010D17D8F38389BF1103BBA2BED80E5D5";
      break;
    case "_encstr_A7BA0552987332":
      var_7 = "_encstr_85C90C37FC5BA1574C69D080A222" + var_1 + var_2.iconname;
      var_8 = "_encstr_AC1D0C59F517A0B01389B8C17293" + var_1 + var_2.iconname;

      if(var_6)
        var_10 = 1;

      break;
    case "_encstr_AF2F096B034EE88B9BE1E9":
      var_7 = "_encstr_B1CA105F8423D93F24F13858FA7CD730DF3C";
      var_8 = "_encstr_8F20103CCDF5B218457E5E63EDA95310C5F8";
      break;
    case "_encstr_8F79084EEB0211E38D73":
      var_7 = "_encstr_84BD0FD09BC3238947AF4EC567D313E32F";
      var_8 = "_encstr_84D30F6A2BE57F9B91B8637C48FB2B8719";
      break;
    default:
      return;
  }

  if(var_9)
    thread watchweapondrop(var_7, game["_encstr_991C0AB9ED5B57161FE89B83"], 1, var_11, undefined, 1);
  else if(isDefined(var_7))
    thread watchweapondrop(var_7, game["_encstr_991C0AB9ED5B57161FE89B83"], 1, var_11, undefined, 1, var_2);

  if(var_10)
    thread watchweapondrop(var_8, game["_encstr_B6A70A23CA6659DC91CAE4DC"], 1, var_11, undefined, 1);
  else if(isDefined(var_8))
    thread watchweapondrop(var_8, game["_encstr_B6A70A23CA6659DC91CAE4DC"], 1, var_11, undefined, 1, var_2);

  if(isDefined(var_2)) {
    var_2._id_14307 = var_0;
    var_2._id_142F7 = gettime() + level.disable_super_in_turret._id_142F6;
    var_2._id_14306 = gettime() + level.disable_super_in_turret._id_14305;

    if(!var_5 || var_6)
      var_2._id_142F9 = gettime() + level.disable_super_in_turret._id_142F8;
  }
}

watchweapondrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isarray(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    for(var_7 = 0; var_7 < game["_encstr_B2DA070A5F8BAB87AF"][var_0].size; var_7++) {
      var_8 = game["_encstr_B2DA070A5F8BAB87AF"][var_0][var_7];

      if(isDefined(var_6))
        watchweapondeathordisconnect(var_8, var_1, var_6, var_3);
      else
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_8, var_1, var_2, var_3, var_4, var_5);

      waitframe();
    }
  } else if(isDefined(var_6))
    watchweapondeathordisconnect(var_0, var_1, var_6, var_3);
  else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_1332C(var_0) {
  switch (var_0) {
    case "_encstr_969210B789CDA385D88D5994B25BBDECAC19":
    case "_encstr_AF2F096B034EE88B9BE1E9":
    case "_encstr_A7460B06CA52CF18C9D769262C":
    case "_encstr_8F79084EEB0211E38D73":
    case "_encstr_8B6D0940CC35339149DA08":
      return 1;
    default:
      break;
  }

  return 0;
}

watchweapondeathordisconnect(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_4 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_7 = var_6 _id_12575();

    if(isDefined(var_7) && var_2 != var_7) {
      continue;
    }
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_0, var_6, 1, 1, var_3);
  }
}

_id_1260A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self._id_142F5)) {
    return;
  }
  self._id_142F5 = 1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_AA410C0EC2E58DEDB032AFEDED98", self);
  wait 5;
  self._id_142F5 = undefined;
}

timelimitclock() {
  level endon("_encstr_88B018F8678EB113121977882D5A4B58EBEFF8A1DB5109C90A3F");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    if(scripts\mp\utility\game::gettimelimit() == 0) {
      waitframe();
      continue;
    }

    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit() && !istrue(level.bombsplanted)) {
      var_6 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var_7 = int(var_6 + 0.5);

      if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && !_encstr_AF1C0C87C72C8A7618801AA39BA8()) {
        var_8 = scripts\mp\gamelogic::checkdefaultjiprules();

        if(!isDefined(level.nojip) || var_8 != level.nojip) {
          setnojiptime(var_8, var_8);
          level.nojip = var_8;
        }
      }

      var_9 = 0;

      if(var_5 == 2 && var_7 % 2 == 1)
        var_9 = 1;

      if(!var_0 && (var_9 == 1 && var_7 == 121 || var_9 == 0 && var_7 == 120)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_87EE0C73E808CD9B5B8F698AD6B9", 0, undefined, 1);
        var_0 = 1;
      } else if(!var_1 && (var_9 == 1 && var_7 == 61 || var_9 == 0 && var_7 == 60)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_86130BDBE85257EFE03B889E4A", 0, undefined, 1);
        var_1 = 1;
      } else if(!var_2 && (var_9 == 0 && var_7 == 46 || var_9 == 1 && var_7 == 45)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AF130B80B27DE343E748905D65", 0, undefined, 1);
        var_2 = 1;
      } else if(!var_3 && (var_9 == 1 && var_7 == 21 || var_9 == 0 && var_7 == 20)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AA130B8E96B5B29BAB1CFA8C18", 0, undefined, 1);
        setmusicstate("_encstr_8DF618328077D9CB2943949F5751AF4AD951ABDA60D74DD7E12D");
        var_3 = 1;
      } else if(!var_4 && (var_9 == 1 && var_7 == 11 || var_9 == 0 && var_7 == 10)) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A7130B8318F83D6B8B5FB93A67", 0, undefined, 1);
        var_4 = 1;
      }

      if(var_7 <= 10 || var_7 <= 30 && var_7 % var_5 == var_9) {
        level notify("_encstr_A15F178159EB5191911A2078F2F5B76E4BC596038F2F18D785");
        var_10 = 1;

        if(var_7 == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < var_7)
          var_10 = 0;

        if(var_10) {
          var_11 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_6);
          playsoundatpos((0, 0, 0), var_11);
        }
      }

      if(var_6 - floor(var_6) >= 0.05) {
        wait(var_6 - floor(var_6));
        continue;
      }
    }

    wait 1.0;
  }
}

technical_initdamage() {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }
  setomnvar("_encstr_99F3234EACC5AB96C9AC9B7DE68D274B38A3B5DB3BCA27EB1BB08C32954EEB1BD0CA1B5BDC", 1);
  _id_13231(level.disable_super_in_turret.getquestrewardstabletype, "_encstr_865115B2672824E1E0A268B2E90FD817702C984A9308B3", "_encstr_88881F13575AD88C2C898D56F51B0DCA6CDA83B7B4CD47AF6CC6A51C98C9AEDCA1", "_encstr_8C42138D1A956CB61CDB4B37A37D0313BE85CDB45B", "_encstr_AF081C18EB38C10E6337B19B87AAC088F449E3919493D8A83AE795B7EFB3", &"_encstr_843B1B469F2980D86B5987B7210891DDE9054C1E570147204545EFBF35", &"_encstr_86FB240949F5140A65627A0522CBA0AA25344282A615D709AA275A1525BE22526AA012625122", level.disable_super_in_turret.getpropsize, "_encstr_B8551D3DDC715B7327FBF899EF314BE37A85B550B4EA1778FF03D828EF4D43");
  _id_13231(level.disable_super_in_turret._id_13C1A, "_encstr_931C158665B2635179BA597F4148DF26453D534F178793", "_encstr_96771F0B28A8E4CA53A685FFAF7793B193C82BB7A08132A1AF49CCB2F605AB6B38", "_encstr_B66E13ECEA2CE4918EEDDDB2C9F5C026AF58375A5B", "_encstr_BE671B9334C85E386D5FC358F0F8FF16AFEFAA19619AAFE7F9B7739F83", &"_encstr_A29B1AEDD9186858F0A4F098286E2BDF016714D66FD8666C1FF71891", &"_encstr_97A6232429F5820A65C4E9A022BC82AA29342150D4A27DA87ABAA2927D1192A90524622A11", level.disable_super_in_turret.getquesttimefrac, "_encstr_BD351CD596AF6B83F5C4C9BEB516385B56CD5DF5D28DEDDCAF47DBBBCA27");
  toggle_in_use();
}

_id_13231(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_10 in var_0) {
    if(!isDefined(var_10.angles))
      var_10.angles = (0, 0, 0);

    var_10._id_11C75 = var_3;
    var_10.helistoreplunder = var_2;
    var_10._id_13931 = var_1;
    var_10._id_129F0 = var_4;
    var_10._id_1293F = 0;
    var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
    var_11.angles = var_10.angles;
    var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_11 hide();
    var_11._id_14082 = var_5;
    var_11.price = var_7;
    var_11.loc = var_10;
    var_10.getquestrewardstablevaluecolumnindex = var_11;
    var_11.scriptable = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
    var_11.scriptable.angles = var_10.angles;
    var_11.scriptable setModel("_encstr_ADAC1DBB0945106DD76B6AD6B2EFB0089A99011397BA3220BB7262B8EA87D5");
    var_11.scriptable unmarkkeyframedmover(1);
    var_11.scriptable setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_A7C5056BD931D1");
    var_12 = var_11.scriptable;
    var_12._id_14082 = var_6;
    var_12.price = var_7;
    var_12.loc = var_10;
    var_10.getquestrewardtier = var_12;
    var_10.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(var_10.objidnum != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_10.objidnum, "_encstr_930B07BB1B6B3854FF", var_10.origin);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_10.objidnum);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_10.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_10.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_10.objidnum, 0);
      scripts\mp\objidpoolmanager::update_objective_icon(var_10.objidnum, var_8);
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_10.objidnum, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
      _func_421(var_10.objidnum, 1);
    }

    var_13 = 0;

    if(isDefined(var_10.script_group))
      var_13 = var_10.script_group;
    else
      var_10.script_group = var_13;

    var_14 = respawndelayoverride(var_13);

    if(isDefined(var_14)) {
      var_15 = var_14.getquestscaledvalue.size;

      if(isDefined(var_10.script_index))
        var_15 = var_10.script_index;
      else
        var_10.script_index = var_15;

      if(!isDefined(var_14.getquestscaledvalue[var_15]))
        var_14.getquestscaledvalue[var_15] = [];

      var_16 = var_14.getquestscaledvalue[var_15].size;
      var_14.getquestscaledvalue[var_15][var_16] = var_10;
    }
  }
}

_id_1286A(var_0, var_1) {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }
  var_2 = var_0 - 1;
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  if(isDefined(var_1)) {
    if(var_0 > 0 && isDefined(var_1.getquestscaledvalue[var_2])) {
      foreach(var_4 in var_1.getquestscaledvalue[var_2]) {
        if(!istrue(var_4._id_1293F))
          var_4 _id_1392D();
      }
    }

    if(isDefined(var_1.getquestscaledvalue[var_0])) {
      foreach(var_4 in var_1.getquestscaledvalue[var_0])
      var_4 _id_1392E();
    }
  } else {
    foreach(var_1 in level.disable_super_in_turret.paths) {
      if(var_0 > 0 && isDefined(var_1.getquestscaledvalue[var_2])) {
        foreach(var_4 in var_1.getquestscaledvalue[var_2]) {
          if(!istrue(var_4._id_1293F))
            var_4 _id_1392D();
        }
      }

      if(isDefined(var_1.getquestscaledvalue[var_0])) {
        foreach(var_4 in var_1.getquestscaledvalue[var_0])
        var_4 _id_1392E();
      }
    }
  }
}

_id_13932() {
  var_0 = 5.0;
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_910C16EB51F42B8EF33BBB61432FD6C883A6534FF91E10ED");
  self notify("_encstr_A99912DE1CA3C3B76B2B10A0E1C641D96385665D");
  self endon("_encstr_A99912DE1CA3C3B76B2B10A0E1C641D96385665D");
  var_1 = self;
  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setusepriority(-1);
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 setHintString(var_1._id_14082);
  var_1 sethintstringparams(var_1.price);
  var_1.userate = 1;
  var_1.curprogress = 0;
  var_1.usetime = var_0;
  var_1.inuse = 0;
  var_1.playerusing = undefined;

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A22320B8F7B4381163A5E1A3F80F0804B76777CF487F36C40FB7BF7508487F19236F");

      continue;
    }

    if(var_1 _id_1392A(var_2)) {
      var_3 = int(var_1.price / 100);
      var_2 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_2.plundercount - var_3);
      _id_1361F(var_1.loc, var_2);
      return;
    }
  }
}

_id_1392A(var_0) {
  if(!var_0 scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 isonladder())
    return 0;

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()]))
    return 0;

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.squadindex != self.squadindex || var_0.team != self.team)
      return 0;
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0))
      return 0;

    if(var_0.team != self.team)
      return 0;
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() != "_encstr_9A7205B39CB919" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D")]](self.cratetype))
          return 0;
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB")]](self.cratetype))
        return 0;
    }
  }

  if(!self.isusable)
    return 0;

  if(var_0 isskydiving())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(isDefined(self.playerusing) && self.playerusing != var_0)
    return 0;

  var_1 = int(self.price / 100);

  if(var_0.plundercount < var_1)
    return 0;

  return 1;
}

_id_1392E() {
  self.getquestrewardstablevaluecolumnindex show();
  self.getquestrewardstablevaluecolumnindex.isusable = 1;
  self.getquestrewardtier.isusable = 1;
  self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_A7C5056BD931D1");
  self.getquestrewardstablevaluecolumnindex makeusable();
  self.getquestrewardtier makeusable();
  var_0 = int(self.getquestrewardstablevaluecolumnindex.price / 100);
  var_1 = scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
    self.getquestrewardtier disableplayeruse(var_3);
    self.getquestrewardstablevaluecolumnindex disableplayeruse(var_3);
  }

  var_5 = scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_5) {
    var_7 = isDefined(var_3.plundercount) && var_3.plundercount >= var_0;
    var_8 = !istrue(self._id_1293F);

    if(var_8 && var_7 == 0) {
      self.getquestrewardstablevaluecolumnindex disableplayeruse(var_3);
      self.getquestrewardtier enableplayeruse(var_3);
      self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
      continue;
    }

    self.getquestrewardstablevaluecolumnindex enableplayeruse(var_3);
    self.getquestrewardtier disableplayeruse(var_3);

    if(var_8 && var_7) {
      self.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient(var_3, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");
      continue;
    }

    self.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(var_3);
  }

  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.getquestrewardstablevaluecolumnindex.loc.objidnum, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.getquestrewardstablevaluecolumnindex.loc.objidnum);
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.getquestrewardstablevaluecolumnindex.loc.objidnum, game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  self.getquestrewardstablevaluecolumnindex thread _id_13932();
  self.getquestrewardtier thread _id_13932();
}

_id_1392D() {
  self.getquestrewardstablevaluecolumnindex notify("_encstr_910C16EB51F42B8EF33BBB61432FD6C883A6534FF91E10ED");
  self.getquestrewardtier notify("_encstr_910C16EB51F42B8EF33BBB61432FD6C883A6534FF91E10ED");
  self.getquestrewardstablevaluecolumnindex.isusable = 0;
  self.getquestrewardtier.isusable = 0;
  self.getquestrewardstablevaluecolumnindex.scriptable setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_A7C5056BD931D1");
  self.getquestrewardstablevaluecolumnindex makeunusable();
  self.getquestrewardtier makeunusable();
  self.getquestrewardstablevaluecolumnindex _id_13930();
  self.getquestrewardtier _id_13930();
  self.getquestrewardstablevaluecolumnindex.scriptable _id_1392B();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.getquestrewardstablevaluecolumnindex.loc.objidnum);
  self.getquestrewardstablevaluecolumnindex hide();
}

_id_13930() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9775086022BE1B413B8B");
  var_1 = scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1)
  self enableplayeruse(var_3);

  foreach(var_3 in var_0)
  self disableplayeruse(var_3);
}

_id_1392B() {
  var_0 = scripts\mp\utility\teams::getteamdata(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_9775086022BE1B413B8B");
  var_1 = scripts\mp\utility\teams::getteamdata(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9775086022BE1B413B8B");

  if(var_0.size > 0)
    self hudoutlinedisableforclients(var_0);

  if(var_1.size > 0)
    self hudoutlinedisableforclients(var_1);
}

_id_126E0() {
  if(!level.disable_super_in_turret.getquestscaledvalue) {
    return;
  }
  if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
    foreach(var_1 in level.disable_super_in_turret.getquestrewardstabletype)
    _id_126DF(var_1);

    foreach(var_1 in level.disable_super_in_turret._id_13C1A)
    _id_126DF(var_1);
  }
}

_id_126DF(var_0) {
  if(var_0._id_1293F == 0) {
    var_1 = int(var_0.getquestrewardstablevaluecolumnindex.price / 100);

    if(self.plundercount >= var_1) {
      var_0.getquestrewardstablevaluecolumnindex enableplayeruse(self);
      var_0.getquestrewardtier disableplayeruse(self);

      if(istrue(var_0.getquestrewardstablevaluecolumnindex.isusable))
        var_0.getquestrewardstablevaluecolumnindex.scriptable hudoutlineenableforclient(self, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");
    } else if(self.plundercount < var_1) {
      var_0.getquestrewardstablevaluecolumnindex disableplayeruse(self);
      var_0.getquestrewardtier enableplayeruse(self);
      var_0.getquestrewardstablevaluecolumnindex.scriptable hudoutlinedisableforclient(self);
    }
  }
}

_id_1361F(var_0, var_1) {
  var_0._id_1293F = 1;
  var_2 = var_0.getquestrewardstablevaluecolumnindex;
  var_2 makeunusable();
  var_0.getquestrewardstablevaluecolumnindex = var_2;
  var_2 _id_1392F(var_1, var_0._id_11C75, var_0._id_129F0);
  var_3 = getEnt(var_0.helistoreplunder, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_3)) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_4.angles = var_0.angles;
    var_4 clonebrushmodeltoscriptmodel(var_3);
    var_2.collision = var_4;
    var_5 = getentarrayinradius("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009", var_0.origin, 500);

    foreach(var_1 in var_5) {
      if(!isalive(var_1)) {
        continue;
      }
      if(var_1 istouching(var_4))
        var_1 setOrigin(var_0.origin);
    }
  }

  if(var_0._id_13931 == "_encstr_865115B2672824E1E0A268B2E90FD817702C984A9308B3")
    var_2 thread flagwatchradarownerlost();
  else if(var_0._id_13931 == "_encstr_931C158665B2635179BA597F4148DF26453D534F178793")
    var_2 _id_13C18(var_1);

  return var_2;
}

_id_1392F(var_0, var_1, var_2) {
  var_3 = 1.53;
  var_4 = anglesToForward(self.angles);
  var_5 = self.origin + var_4 * 50;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_6.angles = self.angles;
  var_6 setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_6 scriptmodelplayanim(var_2, "_encstr_8E5811D00BD2BB398B155EDD274B2175FFA2A0");
  var_6 scriptmodelpauseanim(1);
  self.scriptable delete();
  self setModel(var_1);
  self linkTo(var_6, "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
  self dontinterpolate();
  var_6 scriptmodelpauseanim(0);
  wait(var_3);
  waitframe();
  var_6 delete();
}

br_circle_closing_music(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_0 + (0, 0, 3000), var_0, (0, 0, 0), "_encstr_B8FE12888F7188DFEAEF405692E7A956DC1FE820", "_encstr_8882099673858D1D4B6756", undefined, 1);
  var_2.nevertimeout = 1;
  var_2 setotherent(var_1);
  var_2 waittill("_encstr_93510A16C71B20636A2AB8B8", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  waitframe();
  var_2 scripts\cp_mp\killstreaks\airdrop::makecrateunusable();
  var_2 delete();
}

run_techo_spawner(var_0, var_1, var_2) {
  if(!isDefined(var_0.getquestscaledvalue[var_1])) {
    return;
  }
  foreach(var_4 in var_0.getquestscaledvalue[var_1]) {
    if(var_4._id_13931 == var_2 && !istrue(var_4._id_1293F))
      return var_4;
  }
}

firesalediscount(var_0, var_1) {
  return fix_door_clip(var_0, var_1, "_encstr_865115B2672824E1E0A268B2E90FD817702C984A9308B3");
}

fix_wall_traversal(var_0, var_1) {
  return fix_door_clip(var_0, var_1, "_encstr_931C158665B2635179BA597F4148DF26453D534F178793");
}

fix_door_clip(var_0, var_1, var_2) {
  var_3 = 25;
  var_4 = 26;
  var_5 = var_1.path;
  var_6 = level.disable_super_in_turret.getquestplunderrewardinstance;

  if(var_6 == 0 && var_0.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_0 _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::addtop3brcharge(var_3);
    return 0;
  }

  if(var_0.team == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_6--;

  if(isDefined(var_5.getquestscaledvalue[var_6])) {
    var_7 = run_techo_spawner(var_5, var_6, var_2);

    if(isDefined(var_7)) {
      _id_1361F(var_7, var_0);
      return 1;
    }
  }

  var_0 _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::addtop3brcharge(var_4);
  return 0;
}

flagwatchradarownerlost() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, -30, 0);
  var_1 = (0, -90, 0);
  var_2 = rotatevector(var_0, self.angles);
  var_3 = self.origin + var_2;
  var_4 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_3, "_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07", 0);
  var_4.angles = (0, self.angles[1], 0) + var_1;
  var_4 setModel("_encstr_9B5D1B14F7BA4948CEE728E0FF1581DF829D06930D524F53BD7B08A8BB");
  var_4 setscriptablepartstate("_encstr_A3880DF0A46428A82B87F1F3A7F28D", 1, 0);
  self.turret = var_4;
  var_5 = "_encstr_97B00AA6BED19C2DEC3B95C9";
  var_6 = var_4 gettagorigin(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83"))
    var_4.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")]](var_6, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AF0A157DA267B99FD17BCFDB739E5D29C20A053719ADC9", -1, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 80, 60, 80, 60);

  var_4.useownerobj linkTo(var_4, var_5);
  var_4 setdefaultdroppitch(0);
  var_4 setturretmodechangewait(1);
  var_4.maxhealth = 999999;
  var_4.health = var_4.maxhealth;
  var_4 makeunusable();

  for(;;) {
    var_4.useownerobj waittill("_encstr_8F5C086405E70FBA4B4A", var_7);
    var_8 = var_7.origin;
    var_7 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(0);
    var_7 disableturretdismount();
    var_4.owner = var_7;
    var_7 giveweapon("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07", -1, 0, -1, 1);
    var_9 = var_7 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07", 1);

    if(!istrue(var_9)) {
      if(isalive(var_7)) {
        var_7 enableturretdismount();
        var_7 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(1);

        if(var_7 hasweapon("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07"))
          var_7 takeweapon("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07");

        var_7 scripts\mp\utility\inventory::switchtolastweapon();
      }

      continue;
    }

    var_4 setotherent(var_7);
    var_4 setentityowner(var_7);
    var_7 controlturreton(var_4);
    var_7 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 2);
    var_7 setplayerangles(var_4.angles);
    var_7 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(var_7, 0.5, 1);
    waitframe();

    while(var_7 useButtonPressed())
      waitframe();

    while(isalive(var_7) && !var_7 useButtonPressed() && !var_7 isinexecutionvictim())
      waitframe();

    if(isDefined(var_7)) {
      var_7 enableturretdismount();
      var_7 controlturretoff(var_4);
      var_7 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 0);
      var_7 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(1);

      if(var_7 hasweapon("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07"))
        var_7 takeweapon("_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07");

      var_7 scripts\mp\utility\inventory::switchtolastweapon();
      var_7 thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC7();
      var_7 setOrigin(var_8);
    }

    var_4.owner = undefined;
    var_4 setotherent(undefined);
    var_4 setentityowner(undefined);
    wait 0.5;
  }
}

_id_13C18(var_0) {
  var_1 = 4;

  if(!isDefined(level.disable_super_in_turret._id_129C6))
    level.disable_super_in_turret._id_129C6 = [];

  if(level.disable_super_in_turret._id_129C6.size >= var_1) {
    var_2 = undefined;
    var_3 = undefined;

    foreach(var_6, var_5 in level.disable_super_in_turret._id_129C6) {
      if(!isDefined(var_3) || var_5._id_129C7 < var_3) {
        var_2 = var_6;
        var_3 = var_5._id_129C7;
      }
    }

    level.disable_super_in_turret._id_129C6[var_2] clearportableradar();
    level.disable_super_in_turret._id_129C6[var_2] = undefined;
  }

  self._id_129C7 = gettime();
  self makeportableradar(var_0);
  level.disable_super_in_turret._id_129C6[self getentitynumber()] = self;
}

_id_1225E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  if(!level.disable_super_in_turret.little_bird_mg_mp_spawncallback) {
    return;
  }
  var_0 = getentitylessscriptablearrayinradius("_encstr_A62D248AE6BDCA10EB60FBCBA866EB92550BD2C35FC5D24DD658BF53E05EB1DBCF95DD7F354D", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = getentitylessscriptablearrayinradius("_encstr_85E32937B14E2D831D5889D895D7371B27A5C11D0B31D82BEB585D1DEDEBC2371B95DC46B2277DCDED1BDE", "_encstr_AC110A7F14873B5B3D073009");
  var_2 = getentitylessscriptablearrayinradius("_encstr_8AD62E6266933C50F587AB80BD373E67FB2A6F2BE1B181F506978B93F098670A017D45CA7BD3A14E1758C12925AC718B", "_encstr_AC110A7F14873B5B3D073009");
  var_3 = getentitylessscriptablearrayinradius("_encstr_BE6133679FD64393985A1EEBEFE95ABB086008E5D14BB86D7FBA082308F9DFBEB2B3880B7DFA81DB8FD937280BB8A968B9500F60CE", "_encstr_AC110A7F14873B5B3D073009");

  if(var_0.size) {
    foreach(var_5 in var_0) {
      if(var_5 getscriptablehaspart("_encstr_8D1F09027BA68F8523E342"))
        var_5 setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", "_encstr_8698096D1870821A51010B");
    }
  }

  if(var_1.size) {
    foreach(var_5 in var_1) {
      if(var_5 getscriptablehaspart("_encstr_965B0EC237B12BDC195939AFCDBDC6BD"))
        var_5 setscriptablepartstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_8698096D1870821A51010B");
    }
  }

  if(var_2.size) {
    foreach(var_5 in var_2) {
      if(var_5 getscriptablehaspart("_encstr_8D1F09027BA68F8523E342"))
        var_5 setscriptablepartstate("_encstr_8D1F09027BA68F8523E342", "_encstr_8698096D1870821A51010B");
    }
  }

  if(var_3.size) {
    foreach(var_5 in var_3) {
      if(var_5 getscriptablehaspart("_encstr_965B0EC237B12BDC195939AFCDBDC6BD"))
        var_5 setscriptablepartstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_8698096D1870821A51010B");
    }
  }
}

terminal_pusher_approach_array_counter() {
  if(!level.disable_super_in_turret.mine_caves_turret_1_support) {
    return;
  }
  var_0 = ["_encstr_85DE05A6B2AC0E", "_encstr_9A120A1D8536F5E4ED3BB293"];
  var_1 = 0;

  if(!isDefined(level.disable_super_in_turret.vehiclespawns))
    level.disable_super_in_turret.vehiclespawns = scripts\engine\utility::getStructArray("_encstr_965F17E016BC63DE5819AF3B95A1968D362BD7CDE00BDD9B9B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in level.disable_super_in_turret.vehiclespawns) {
    var_3._id_1425C = var_3.script_parameters;

    if(!isDefined(var_3._id_1425C)) {
      var_3._id_1425C = var_0[var_1];
      var_1++;

      if(var_1 >= var_0.size)
        var_1 = 0;
    }

    if(!isDefined(var_3.angles))
      var_3.angles = (0, 0, 0);

    var_4 = var_3.script_index;
    var_5 = var_3.script_group;
    var_6 = respawndelayoverride(var_5);

    if(isDefined(var_6)) {
      var_7 = var_6.getquestreward_checkforvalueoverride[var_4];

      if(!isDefined(var_7.vehiclespawns))
        var_7.vehiclespawns = [];

      var_8 = game["_encstr_991C0AB9ED5B57161FE89B83"];

      if(var_3.targetname == "_encstr_8E460991ACCC59378C56C9")
        var_8 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];

      if(!isDefined(var_7.vehiclespawns[var_8]))
        var_7.vehiclespawns[var_8] = [];

      var_9 = var_7.vehiclespawns[var_8].size;
      var_7.vehiclespawns[var_8][var_9] = var_3;
    }
  }
}

spawninitialvehicles() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::spawninitialvehicles();
  else {
    _id_136AA(1);
    thread _id_13639(game["_encstr_991C0AB9ED5B57161FE89B83"]);
    thread _id_13639(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }
}

_id_13639(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_83341C56F2FA0728A413987847DA206BF1DF43D38E82FB735C57B0E863CF" + var_0);
  level endon("_encstr_83341C56F2FA0728A413987847DA206BF1DF43D38E82FB735C57B0E863CF" + var_0);
  var_1 = 2;
  var_2 = 1;

  foreach(var_4 in level.disable_super_in_turret.paths)
  var_4._id_11F48[var_0] = 0;

  for(;;) {
    foreach(var_4 in level.disable_super_in_turret.paths) {
      var_7 = relic_amped_last_kill_time(var_4);

      if(var_7 < 0)
        var_7 = 0;

      var_8 = var_4.getquestreward_checkforvalueoverride[var_7];

      if(isDefined(var_8) && isDefined(var_8.vehiclespawns)) {
        var_9 = var_8.vehiclespawns[var_0];

        foreach(var_11 in var_9) {
          if(var_4._id_11F48[var_0] >= var_1) {
            break;
          }

          if(istrue(var_11.inuse)) {
            continue;
          }
          var_12 = _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::tryspawnavehicle(var_11._id_1425C, var_11, "_encstr_8E520CA189533FE85731A38A2855");

          if(isDefined(var_12)) {
            scripts\cp_mp\vehicles\vehicle_spawn::_id_14219(var_12);
            var_12 thread _id_14250(var_4, var_11, var_0);

            if(!var_2) {
              break;
            }
          }
        }
      }
    }

    var_2 = 0;
    wait(level.disable_super_in_turret._id_136AB);
  }
}

_id_14250(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_11F48[var_2]++;
  var_1.inuse = 1;
  self waittill("_encstr_AD75063D571AE108");
  var_0._id_11F48[var_2]--;
  var_1.inuse = undefined;
}

respawningbr(var_0, var_1) {
  var_2 = var_0.nodes[var_1].origin;

  if(var_1 + 1 < var_0.nodes.size) {
    var_3 = var_0.nodes[var_1 + 1].origin;
    var_4 = var_3 - var_2;
  } else {
    var_5 = var_0.nodes[var_1 - 1].origin;
    var_4 = var_2 - var_5;
  }

  return var_4;
}

_id_132F6(var_0) {
  if(level.disable_super_in_turret._id_1226A == "_encstr_810D059BE07D8B" && var_0.label == "_encstr_8B4C0248" && var_0.getquestplunderrewardinstance == 0 || level.disable_super_in_turret._id_1226A == "_encstr_97C70E3B2AD9F088F31B1331471AC092" && var_0.label == "_encstr_994C0238" && var_0.getquestplunderrewardinstance == 1)
    return 1;

  return 0;
}

getquestperkbonus(var_0) {
  [var_2, var_3, var_4, var_5] = play_rooftop_success_vo(var_0, var_0.getquestplunderrewardinstance);
  thread init_relic_dogtags(var_0, var_2, var_4);
  thread init_relic_dogtags(var_0, var_3, var_4);
}

play_rooftop_success_vo(var_0, var_1) {
  var_2 = 150;
  var_3 = 200;
  var_4 = 5;
  var_5 = 30;
  var_6 = 184;
  var_7 = var_2 - var_4;
  var_8 = 50;
  var_9 = var_0.getquestreward_checkforvalueoverride[var_1]._id_11EA5;
  var_10 = var_0.nodes[var_9].origin;
  var_11 = var_0.nodes[var_9].angles;
  var_12 = vectorNormalize(respawningbr(var_0, var_9));
  var_13 = vectortoangles(var_12);
  var_14 = anglestoright(var_13);
  var_15 = -1 * var_14;
  var_16 = var_10 + var_6 * var_12 + var_2 * var_14;
  var_17 = var_10 + var_6 * var_12 + var_2 * var_15;
  var_18 = 0;
  var_19 = 0;

  for(var_20 = var_2; var_20 <= var_3; var_20 = var_20 + var_4) {
    var_21 = var_10 + var_6 * var_12 + var_20 * var_14;
    var_22 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_21);
    var_23 = abs(var_10[2] - var_22[2]);
    var_24 = var_23 < var_5;

    if(var_24 && !var_19) {
      var_17 = var_22;
      var_19 = 1;
    }

    var_25 = var_10 + var_6 * var_12 + var_20 * var_15;
    var_26 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_25);
    var_27 = abs(var_10[2] - var_26[2]);
    var_28 = var_27 < var_5;

    if(var_28 && !var_18) {
      var_16 = var_26;
      var_18 = 1;
    }

    if(var_28 && var_24)
      return [var_22, var_26, var_13, 1];
  }

  waitframe();

  if(!var_18 || !var_19) {
    for(var_20 = var_8; var_20 <= var_7; var_20 = var_20 - var_4) {
      if(!var_19) {
        var_21 = var_10 + var_6 * var_12 + var_20 * var_14;
        var_22 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_21);
        var_23 = abs(var_10[2] - var_22[2]);
        var_24 = var_23 < var_5;

        if(var_24) {
          var_17 = var_22;
          var_19 = 1;
        }
      }

      if(!var_18) {
        var_25 = var_10 + var_6 * var_12 + var_20 * var_15;
        var_26 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_25);
        var_27 = abs(var_10[2] - var_26[2]);
        var_28 = var_27 < var_5;

        if(var_28) {
          var_16 = var_26;
          var_18 = 1;
        }
      }

      if(var_18 && var_19) {
        break;
      }
    }
  }

  return [var_16, var_17, var_13, 0];
}

init_relic_dogtags(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3.angles = (0, var_2[1], 0);
  var_3 setModel("_encstr_925D1A5333C1F9A36BB06871BB704FBE11318A2AB04FACA3A0834E7C");
  var_3 unmarkkeyframedmover(1);
  var_4 = "_encstr_A7460B06CA52CF18C9D769262C";

  if(_id_132F6(var_0))
    var_4 = "_encstr_8A8313D8C87A8FBF401890C541FF584C669B97E7D2";

  var_3 setscriptablepartstate("_encstr_A7460B06CA52CF18C9D769262C", var_4);
  _id_1438D(var_0);
  var_3 setscriptablepartstate("_encstr_A7460B06CA52CF18C9D769262C", "_encstr_9937116C4395B16D1C7B5A37E8AFC68DCA2C39");
  wait 5;
  var_3 delete();
}

_id_1438D(var_0) {
  var_0 waittill("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995");
}

_id_125C3(var_0, var_1) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self giveweapon(var_0);
  self setweaponammostock(var_0, 0);
  self setweaponammoclip(var_0, 0);
  scripts\mp\supers::allowsuperweaponstow();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0, 1);

  if(!istrue(var_2)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    else
      self takeweapon(var_0);
  }

  var_1 notify("_encstr_8A8611FD4D6C501D5763F0F8CA7FCEC086B433");

  while(istrue(self.tuttxtbox)) {
    waitframe();

    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_0))
      self.tuttxtbox = 0;
  }

  var_1 show();
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  var_1 notify("_encstr_8E490FAED50728617982C0A8CBCD2B636F");
}

_id_125C0(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(var_2 isgestureplaying("_encstr_99031E30C318D9947AFF87A1CFC36910199F7EE9EBA1B8DDF193F3ADABEA2520")) {
    return;
  }
  var_2 enableoffhandweapons();
  var_2 giveandfireoffhand(var_0);
  waitframe();

  if(!var_2 hasweapon(var_0)) {
    var_2 giveandfireoffhand(var_0);
    waitframe();
  }

  var_1 notify("_encstr_8A8611FD4D6C501D5763F0F8CA7FCEC086B433");

  while(istrue(var_2.tuttxtbox))
    waitframe();

  self takeweapon(var_0);
  var_1 notify("_encstr_8E490FAED50728617982C0A8CBCD2B636F");
}

_id_1226D() {
  if(!istrue(level.disable_super_in_turret._id_12272)) {
    return;
  }
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_13AC8 = [];
  level._id_13AC8[game["_encstr_991C0AB9ED5B57161FE89B83"]] = [];
  level._id_13AC8[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = [];
  level._id_13ABE = [];
  level._id_13ABE[game["_encstr_991C0AB9ED5B57161FE89B83"]] = undefined;
  level._id_13ABE[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = undefined;
  var_0 = 1;

  for(;;) {
    level waittill("_encstr_85EB111BA950A62FAF60027A2B057BDFD80995", var_1);
    var_2 = int(max(relic_amped_monitor() - 1, 0));
    wait 3;
    var_3 = undefined;
    var_4 = undefined;

    if(istrue(level.disable_super_in_turret._id_1226F) || istrue(level.disable_super_in_turret._id_12273)) {
      var_5 = _encstr_83852BDAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067BF406BF31A6760EBC18FB32AD34B9A8FF778::registermovequestlocale();
      var_3 = var_5[var_2 % var_5.size];
    }

    if(istrue(level.disable_super_in_turret._id_12270) || istrue(level.disable_super_in_turret._id_12273)) {
      var_6 = _encstr_83852BDAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067BF406BF31A6760EBC18FB32AD34B9A8FF778::relic_nuketimer_playvo();
      var_4 = var_6[var_2 % var_6.size];
    }

    var_7 = level.disable_super_in_turret._id_12271;

    if(istrue(level.disable_super_in_turret._id_1226F)) {
      thread init_relic_bang_and_boom(var_1, var_7, game["_encstr_991C0AB9ED5B57161FE89B83"], var_3, game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_4);

      if(var_0)
        _id_13357(game["_encstr_991C0AB9ED5B57161FE89B83"]);
    }

    if(istrue(level.disable_super_in_turret._id_12270)) {
      thread init_relic_bang_and_boom(var_1, var_7, game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_4, game["_encstr_991C0AB9ED5B57161FE89B83"], var_3);

      if(var_0)
        _id_13357(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
    }

    if(var_0)
      var_0 = 0;
  }
}

init_relic_bang_and_boom(var_0, var_1, var_2, var_3, var_4, var_5) {
  level notify("_encstr_8FE915B2CB350F93B827D1DD7B20DBAFE5C1DACAB1158F");
  level endon("_encstr_8FE915B2CB350F93B827D1DD7B20DBAFE5C1DACAB1158F");

  for(var_6 = 0; var_6 < var_1; var_6++)
    init_relic_amped(var_0, var_2, var_3, var_4, var_5);
}

init_relic_amped(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  var_5 = -600;
  var_6 = -300;
  var_7 = 15;
  var_8 = var_0;

  if(istrue(var_0.hidesmokinggunhudfromplayer))
    var_8 = respawn_enemies(var_0);

  var_9 = undefined;

  if(isDefined(var_8.idle_sfx))
    var_9 = var_8.idle_sfx;
  else
    var_9 = var_8.vehicle;

  if(isDefined(var_9)) {
    var_10 = randomfloatrange(-1 * var_7, var_7);
    var_11 = (0, var_9.angles[1] + var_10, 0);
    var_12 = anglesToForward(var_11);
    var_13 = randomfloatrange(var_5, var_6);
    var_14 = var_9.origin + var_12 * var_13;
    var_15 = _id_1361C(var_14, var_1, var_2, var_3, var_4);
    var_15.path = var_8;
  }
}

_id_1361C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 20;
  var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0);
  var_6 = var_6 + (0, 0, var_5);
  var_7 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_135DF(var_2, var_6);

  if(isDefined(var_7)) {
    var_7.team = var_1;

    if(van_infil_sfx_chief())
      var_7._id_12395 = ::play_reset_sequences;

    if(istrue(level.disable_super_in_turret._id_12273)) {
      var_7._id_12157 = ::registerscriptableinstance;
      var_7.otherteam = var_3;
      var_7._id_12158 = var_4;
    }

    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_7);
  }

  return var_7;
}

play_reset_sequences(var_0, var_1) {
  var_2 = var_1.path;

  if(!van_infil_sfx_chief() || !isDefined(var_2))
    return undefined;

  level.disable_super_in_turret._id_1297A = var_2;
  var_3 = scripts\engine\utility::array_sort_with_func(level.disable_super_in_turret._id_12979, ::ammorestock_used);
  level.disable_super_in_turret._id_1297A = undefined;
  var_4 = var_3[0];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_7 = 0;

    foreach(var_9 in var_2._id_136C3[var_0.team]) {
      if(isDefined(var_9.trigger) && ispointinvolume(var_6.origin, var_9.trigger)) {
        continue;
      }
      if(isDefined(var_9._id_14427) && ispointinvolume(var_6.origin, var_9._id_14427)) {
        continue;
      }
      var_7 = 1;
    }

    if(!istrue(var_7)) {
      continue;
    }
    var_4 = var_6;
    break;
  }

  var_11 = spawnStruct();
  var_11.origin = var_4.origin;
  var_11.angles = var_4.angles;
  var_11.spawnflags = 16;
  var_11._id_12978 = var_4;
  return var_11;
}

registerscriptableinstance(var_0) {
  var_1 = var_0.otherteam;
  var_2 = var_0.path;

  if(!isDefined(var_1) || !isDefined(var_2) || !isDefined(var_2.vehicle))
    return undefined;

  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.squaddata[var_1]) {
    var_7 = 0;
    var_8 = var_6.players.size;

    if(var_8 > 0) {
      foreach(var_10 in var_6.players)
      var_7 = var_7 + distancesquared(var_10.origin, var_2.vehicle.origin);

      var_7 = var_7 / var_8;

      if(!istrue(var_4) || var_7 > var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3) && var_3.players.size > 0)
    return var_3.players[0];

  return undefined;
}

_id_13357(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3))
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_9765251A9D81A607BFE3126A4895C79A782B8374AF106C83E6FB79E391E6435788F709E46358F3");
  }
}

van_infil_sfx_chief() {
  return isDefined(level.disable_super_in_turret._id_12979) && level.disable_super_in_turret._id_12979.size > 0;
}

ammorestock_used(var_0, var_1) {
  var_2 = level.disable_super_in_turret._id_1297A;
  var_3 = var_2.vehicle.origin;
  return distancesquared(var_0.origin, var_3) < distancesquared(var_1.origin, var_3);
}

_id_13181(var_0) {
  _id_13156("_encstr_86F31FD8EA272759E61DBEE08D2CF2CA39EB38C2471A7D169BB9A59D73DAACCDE8", var_0);
}

_id_13184(var_0) {
  _id_13156("_encstr_A6E31F365DE43995E63AF5C1D8C22F959CD7D19516DAD7C2CDCDA53B37AD59B91D", var_0);
}

_id_13182(var_0) {
  _id_13156("_encstr_826717631DDA8BBDA8E356C3FB5788B5838F63ED93E7094B6E", var_0);
}

_id_13183(var_0) {
  _id_13156("_encstr_AD9A168DAEC9272B73D1D71C8DC2CBAC93F51DB0D8DAC2E0", var_0);
}

_id_13185(var_0) {
  _id_13156("_encstr_81301D5408698BB3D00FC891C3A83769FE97AD51729FD83F5FC388D2022F38", var_0);
}

_id_1318B(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "_encstr_AF541EDD75A5E8453B190811211B0DB8FDF54B910D8AB998A3F1E3F9FB032878", "_encstr_86541EF09B120511CACFD090E7E429BBBA05FF05772BB7188EB730905368A6F3");
  _id_13157(var_2, var_1);
}

_id_13190(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "_encstr_8DAD0D0AF953039043570E5313A0A1", "_encstr_AD280DBBFAF58B29436F13A3378383");
  _id_13157(var_2, var_1);
}

_id_1318A(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "_encstr_BA9C1CC1B01DD0EB26D71BA1956CAD83BD96DCA3E6BE8DDBD6E01BCA8E59", "_encstr_BE061CE24FE9825721E997832B592B4B87D3ED9B2E178ABF4878A3BFE0F1");
  _id_13157(var_2, var_1);
}

_id_13189(var_0) {
  var_1 = int(var_0 / 100);
  var_1 = scripts\engine\utility::ter_op(var_1 <= 0, 0, var_1);
  _id_13157("_encstr_A198117CBF63DBD1C7B8E20AF81319139811FD", var_1);
}

_id_13188(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  _id_13157("_encstr_86AC15B116B9A3EBB1D085DC1BACAFADB0E1D78EB4ADCA", var_0);
}

_id_1318E(var_0) {
  _id_13157("_encstr_88FE1A187B611A88868857D48B20075B71E8AB8833A9F28131B57FF5", var_0);
}

_id_11AA2(var_0) {
  var_1 = 0;

  if(var_0 >= 0.999)
    var_1 = 10000;
  else if(var_0 > 0.0)
    var_1 = int(var_0 * 10000);

  return var_1;
}

_id_1318F(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_0 == 1, "_encstr_918A18C158E834AF987D83CA391BB2E6477DC6ED6BC163CA1D56", "_encstr_843C180B0BFD429FB05EB2FFD388ED9A55DFDFFFEB27CA9D4061");
  var_3 = _id_11AA2(var_1);
  _id_13157(var_2, var_3);
}

_id_1318C(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0 == 1, "_encstr_BA2416C1B01D86BE98AFDB26CD8E0B6C36ACFA9B1DB0A32B", "_encstr_B645169367A450A1F72740C6671B26FE517740734B9E8153");
  var_4 = scripts\engine\utility::ter_op(var_2 == 1, 1, 0);
  _id_13157(var_3, var_4, var_1);
}

_id_13157(var_0, var_1, var_2) {
  [var_4, var_5, var_6, var_1] = reload_use_trigger(var_0, var_1);

  if(isDefined(var_2))
    var_4 = var_4 + var_2;

  if(var_6 == "_encstr_B40101") {
    return;
  }
  _id_1260E(var_6, var_1, var_4, var_5);
}

_id_13156(var_0, var_1) {
  [var_3, var_4, var_5, var_1] = reload_use_trigger(var_0, var_1);

  if(var_5 == "_encstr_B40101") {
    return;
  }
  _id_1260D(var_5, var_1, var_3, var_4);
}

reload_use_trigger(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_86F31FD8EA272759E61DBEE08D2CF2CA39EB38C2471A7D169BB9A59D73DAACCDE8":
      [var_2, var_3] = [0, 1];
      var_4 = "_encstr_82F31AA31F876A5DC622497928B07E555960220DA81FEA39D477ABC0";
      break;
    case "_encstr_A6E31F365DE43995E63AF5C1D8C22F959CD7D19516DAD7C2CDCDA53B37AD59B91D":
      [var_2, var_3] = [1, 1];
      var_4 = "_encstr_82F31AA31F876A5DC622497928B07E555960220DA81FEA39D477ABC0";
      break;
    case "_encstr_826717631DDA8BBDA8E356C3FB5788B5838F63ED93E7094B6E":
      [var_2, var_3] = [2, 1];
      var_4 = "_encstr_82F31AA31F876A5DC622497928B07E555960220DA81FEA39D477ABC0";
      break;
    case "_encstr_81301D5408698BB3D00FC891C3A83769FE97AD51729FD83F5FC388D2022F38":
      [var_2, var_3] = [3, 1];
      var_4 = "_encstr_82F31AA31F876A5DC622497928B07E555960220DA81FEA39D477ABC0";
      break;
    case "_encstr_AD9A168DAEC9272B73D1D71C8DC2CBAC93F51DB0D8DAC2E0":
      [var_2, var_3] = [4, 1];
      var_4 = "_encstr_82F31AA31F876A5DC622497928B07E555960220DA81FEA39D477ABC0";
      break;
    case "_encstr_86541EF09B120511CACFD090E7E429BBBA05FF05772BB7188EB730905368A6F3":
      [var_2, var_3] = [0, 6];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_AF541EDD75A5E8453B190811211B0DB8FDF54B910D8AB998A3F1E3F9FB032878":
      [var_2, var_3] = [6, 6];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_AD280DBBFAF58B29436F13A3378383":
      [var_2, var_3] = [12, 3];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_8DAD0D0AF953039043570E5313A0A1":
      [var_2, var_3] = [15, 3];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_BE061CE24FE9825721E997832B592B4B87D3ED9B2E178ABF4878A3BFE0F1":
      [var_2, var_3] = [18, 2];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_BA9C1CC1B01DD0EB26D71BA1956CAD83BD96DCA3E6BE8DDBD6E01BCA8E59":
      [var_2, var_3] = [20, 2];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_A198117CBF63DBD1C7B8E20AF81319139811FD":
      [var_2, var_3] = [22, 10];
      var_4 = "_encstr_8701136B52BF8E2861C06B53F4558845171A61B33A";
      break;
    case "_encstr_B645169367A450A1F72740C6671B26FE517740734B9E8153":
      [var_2, var_3] = [0, 1];
      var_4 = "_encstr_82A1152BDCD798B6615B635B034A77F0BFF7D183466FD2";
      break;
    case "_encstr_BA2416C1B01D86BE98AFDB26CD8E0B6C36ACFA9B1DB0A32B":
      [var_2, var_3] = [10, 1];
      var_4 = "_encstr_82A1152BDCD798B6615B635B034A77F0BFF7D183466FD2";
      break;
    case "_encstr_86AC15B116B9A3EBB1D085DC1BACAFADB0E1D78EB4ADCA":
      [var_2, var_3] = [20, 3];
      var_4 = "_encstr_82A1152BDCD798B6615B635B034A77F0BFF7D183466FD2";
      break;
    case "_encstr_88FE1A187B611A88868857D48B20075B71E8AB8833A9F28131B57FF5":
      [var_2, var_3] = [23, 1];
      var_4 = "_encstr_82A1152BDCD798B6615B635B034A77F0BFF7D183466FD2";
      break;
    case "_encstr_843C180B0BFD429FB05EB2FFD388ED9A55DFDFFFEB27CA9D4061":
      [var_2, var_3] = [0, 16];
      var_4 = "_encstr_B19E175DD2BE9893BEC1855EB17B1691AF83B2C9D85937D16E";
      break;
    case "_encstr_918A18C158E834AF987D83CA391BB2E6477DC6ED6BC163CA1D56":
      [var_2, var_3] = [16, 16];
      var_4 = "_encstr_B19E175DD2BE9893BEC1855EB17B1691AF83B2C9D85937D16E";
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

_id_1260D(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7)
    self setclientomnvar(var_0, var_9);
}

_id_1260E(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = getomnvar(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7)
    setomnvar(var_0, var_9);
}

_id_12258() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0) {
    wait 7.66667;
    thread _id_12257();
  } else {
    wait 6.0;
    thread _id_12257();
    scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
    wait(randomintrange(20, 25));
    thread _id_12257();
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

_id_12257() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = [];
  var_1 = undefined;
  var_2 = level.disable_super_in_turret._id_1226A;
  var_3 = [];
  var_4 = 1.2;

  switch (var_2) {
    case "_encstr_810D059BE07D8B":
      var_0[var_0.size] = (38775, -23332, 197);
      var_0[var_0.size] = (33582, -25827, -278);
      var_1 = 255;
      break;
    case "_encstr_97C70E3B2AD9F088F31B1331471AC092":
      var_0[var_0.size] = (-9592, -17688, -360);
      var_0[var_0.size] = (-7456, -20160, 592);
      var_1 = 15;
      break;
    case "_encstr_9BD50A1CA7C0E553306372BF":
      var_0[var_0.size] = (24012, -22726, 371);
      var_0[var_0.size] = (21811, -18619, 784);
      var_1 = 60;
      break;
    case "_encstr_A5AE098ADB583E0AF7A5AB":
      var_0[var_0.size] = (0, 0, 0);
      var_1 = 0;
      break;
    case "_encstr_BD370F28DAD38398C711DDDF0A53217D7A":
      var_0[var_0.size] = (-17, -7150.75, 707.5);
      var_0[var_0.size] = (-1349.5, -7417, 640.75);
      var_0[var_0.size] = (-1654.75, -6373.75, 701);
      var_1 = 170;
      break;
    case "_encstr_8B1F0C8164E29078A0B989506260":
      var_0[var_0.size] = (1281.5, 4766.75, 830.25);
      var_0[var_0.size] = (1323.5, 3293.75, 948.25);
      var_0[var_0.size] = (269.5, 3797.75, 1199.25);
      var_1 = 270;
      break;
    case "_encstr_AC480657D870D2F2":
      var_0[var_0.size] = (-3363, 3374.75, 616.75);
      var_0[var_0.size] = (-4397, 3984.75, 615);
      var_0[var_0.size] = (-2523.5, 5642, 879.25);
      var_1 = 65;
      break;
    default:
      break;
  }

  var_5 = spawnStruct();
  var_5.streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  var_5.owner = play_random_sound_event();
  var_5.score = 0;
  var_5.shots_fired = 0;
  var_5.hits = 0;
  var_5.damage = 0;
  var_5.kills = 0;
  var_5.setuptimelimit = 0;
  var_5.brmini_ontimelimit = 0;
  var_6 = undefined;
  var_7 = % _encstr_A940106B83FA0BD89958C40CF533C65EB4E6;
  var_8 = undefined;
  var_9 = 24000;
  var_10 = 6500;
  var_11 = 1000;
  var_12 = 1500;

  if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0) {
    var_5.setuptimelimit = 1;
    var_11 = 1200;
  }

  var_13 = 215;
  var_14 = (0, var_1, 0);
  var_15 = undefined;
  var_16 = play_random_sound_event();

  if(isDefined(var_16) && istrue(var_0.size > 0)) {
    for(var_17 = 0; var_17 < var_0.size; var_17++) {
      var_18 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0[var_17], var_14, var_9, 1, var_11, var_10, var_12, var_5.streakname, var_15);
      wait(var_4);
      var_11 = var_11 + randomintrange(200, 300);
      level thread scripts\cp_mp\killstreaks\airstrike::doplanestrike(var_0[var_17], var_18["_encstr_B18C0B5E9C6FA319E20A487853"], var_18["_encstr_ACB7092280809AF7F8F8DB"], var_11, var_6, var_5, var_7, var_5.owner, var_8);

      if(var_17 == 0 && getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) > 0)
        level thread onteammatereviveweapontaken(var_2, var_4);
    }

    if(getdvarint("_encstr_A1F515DC1BC9F58927EB58363A7D6BF63256D7D6D29BA5", 0) == 0)
      level thread onteammatereviveweapontaken(var_2, var_4);
  }
}

onteammatereviveweapontaken(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;

  switch (var_0) {
    case "_encstr_810D059BE07D8B":
      scripts\engine\utility::exploder("_encstr_9775136022313B20238A48A875FB2B8F27BA40304B");
      wait(var_1 - 1);
      scripts\engine\utility::exploder("_encstr_A6C31418937F4CABB13E4829E2E3E8FF7DB80F073B13");
      break;
    case "_encstr_97C70E3B2AD9F088F31B1331471AC092":
      wait 0.5;
      scripts\engine\utility::exploder("_encstr_8C8A143B2158629E48AB050161C3C859A5753BBF8978");
      wait(var_1 - 0.7);
      scripts\engine\utility::exploder("_encstr_8A0C15B128EEB4C5B38BBA59ED9B73A93C437D934B0E0A");
      break;
    case "_encstr_9BD50A1CA7C0E553306372BF":
      wait(var_1 - 1);
      scripts\engine\utility::exploder("_encstr_8ECC1253283763C34C850788DF096B0F21D0CBE8");
      scripts\engine\utility::exploder("_encstr_83B613DBB8678C6B43FEAFE71DAA5B5949C823B2D2");
      break;
    case "_encstr_BD370F28DAD38398C711DDDF0A53217D7A":
      wait 2.5;
      scripts\engine\utility::exploder("_encstr_A3121FEB71AE82220DDBCF5EA8EBC3662952AD48B8A917FF0F50506B7AB0700A52");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_AC121FC86141E47BFD83222949D33BD170F346298D582A5F2FFB8BB2B3AE4F42FA");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_91121FC18DEB96DCD1C9BD7D590F0EF5365A6796737617BAC29C8EB24EB9AFC033");
      break;
    case "_encstr_8B1F0C8164E29078A0B989506260":
      wait 2.5;
      scripts\engine\utility::exploder("_encstr_8C891C705986CFFD89C8A2B968C9325F79339D8563A9378543732AB1AA73");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_A9891C4002111BCD03AA6848951B0BAFC6AA1020CAB643183FAE644038EA");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_BA891CBFB4D86BABEBA3ADBF295B302802C845B7B317C7F815B0C2A9B107");
      break;
    case "_encstr_AC480657D870D2F2":
      wait 2.5;
      scripts\engine\utility::exploder("_encstr_9161160815FFDCDA4C6D7F5747B867408A4BB03BA51652A3");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_9361167BA9FF92464DD590BFADA8C8D98B80FF1D28D80852");
      wait(var_1);
      scripts\engine\utility::exploder("_encstr_A3611661ECA93040A34B88B602AB07C9FA70D71D8D014236");
      break;
    case "_encstr_A5AE098ADB583E0AF7A5AB":
      scripts\engine\utility::exploder("_encstr_AD580F5AE090DB281353287169B807467B");
      break;
    default:
      break;
  }
}

play_random_sound_event() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(isalive(var_2) && var_2.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

startspectatorview() {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();

  if(isbot(self)) {
    return;
  }
  thread _id_12535();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  _id_13182(1);
  waitframe();
  var_0 = respawntokenclosewithgulag();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetthermalforplayer("_encstr_AF500C2C1B136660BE8D7BC6F627");
  self thermalvisionon();
  self playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  self setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
  self waittill("_encstr_AA6D0CFF2311CBCD0EAB87DBB165");
  self clearclienttriggeraudiozone(0.5);
}

_id_13FD8(var_0, var_1, var_2, var_3) {
  self unlink();
  var_4 = self.origin;
  var_5 = self.angles;
  var_6 = 0;

  if(var_1[0] != var_4[0]) {
    self moveTo(var_1, 0.1);
    var_6 = 1;
  }

  if(istrue(var_6)) {
    var_7 = anglesToForward(var_2) * 300;
    var_7 = var_7 * (1, 1, 0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_7, 1000);
  }

  thread x1fin_think(var_3);
}

x1fin_think(var_0) {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_9B420907FD535DAC6DF285");

  if(isDefined(var_0))
    self linkTo(var_0);
}

_id_139D8(var_0) {
  if(isDefined(self.play_nuclear_core_vo) && isDefined(self._id_12204) && !isbot(self)) {
    [var_2, var_3, var_4] = _id_12574(var_0);
    self.play_nuclear_core_vo _id_13FD8(self, var_2, var_3, var_4);
  }
}

_id_12574(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self._id_12204))
      var_0 = self._id_12204;
    else
      var_0 = level.disable_super_in_turret.paths[0];
  }

  var_1 = var_0.label;
  var_2 = 0;

  if(var_1 != "_encstr_994C0238")
    var_2 = 1;

  var_3 = respawnheightoverride(var_2);
  var_4 = var_3.vehicle;
  var_5 = 88;
  var_6 = var_4.angles[1];
  var_7 = anglesToForward((0, var_6, 0));
  var_8 = 500;
  var_9 = 5000;
  var_10 = (var_4.origin[0] + var_7[0] * var_8, var_4.origin[1] + var_7[1] * var_8, var_9);
  var_11 = (var_5, var_6, 0);

  if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"])
    var_11 = (var_5, var_6 + 180, 0);

  return [var_10, var_11, var_4];
}

respawntokenclosewithgulag() {
  if(isDefined(self.play_nuclear_core_vo))
    return self.play_nuclear_core_vo;

  var_0 = _id_12575();
  [var_2, var_3, var_4] = _id_12574(var_0);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_5.angles = var_3;
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 hide();
  var_5 unmarkkeyframedmover(1);
  var_5 showtoplayer(self);
  self.play_nuclear_core_vo = var_5;
  return self.play_nuclear_core_vo;
}

_id_126BB() {
  var_0 = _id_12575();
  [var_2, var_3, var_4] = _id_12574(var_0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_2);
}

_id_125E7() {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_87A218DB78315972CD07AA67FEB97B0D59E89F1FD8CBB4BAE9A5");
  wait 2;
  thread scripts\mp\spawncamera::startoperatorsound();
  waitframe();

  if(isDefined(self._id_12135)) {
    self._id_12135.origin = self.origin + (0, 0, 80);
    self._id_12135 linkTo(self);
  }

  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  if(isDefined(self._id_12135)) {
    self clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
    self._id_12135 unlink();
    self._id_12135 stoploopsound(self._id_12136);
    self._id_12135 delete();
    self._id_12135 = undefined;
    self._id_12136 = undefined;
  }
}

_id_12535() {
  level endon("_encstr_994D102B20DB3D9F3125536749FB5B8739E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\mp\spawncamera::startoperatorsound();
  waitframe();

  if(isDefined(self._id_12135)) {
    self._id_12135.origin = self.origin + (0, 0, 80);
    self._id_12135 linkTo(self);
  }
}

tomastrike_isflyingvehicle() {
  if(!isDefined(level.disable_super_in_turret._id_12EAC)) {
    var_0 = [];

    foreach(var_2 in level.disable_super_in_turret.paths) {
      var_0[var_0.size] = _id_13697("_encstr_BEB435403AB9AB59F7E833B8FD6B82071AC240D8C20DFBB3C737C620DC4FABE146DA701869B289EEBB3DC430B8773291ADB2F0F9027CFF", var_2.initchallengeandeventglobals, 0, "_encstr_BE50196BC64BA305EC087D738F9332682FB3C1C8B0A5E01792621A");
      var_0[var_0.size] = _id_13697("_encstr_BEB435403AB9AB59F7E833B8FD6B82071AC240D8C20DFBB3C737C620DC4FABE146DA701869B289EEBB3DC430B8773291ADB2F0F9027CFF", var_2.initchallengeandeventglobals, 1, "_encstr_BE50196BC64BA305EC087D738F9332682FB3C1C8B0A5E01792621A");
      var_0[var_0.size] = _id_13697("_encstr_A59B2C91671F28F77AF38BBDFF53C371EBFE3B69CD84B0357247B1AB3BCA8129C042C64336E9D060EAB3F7B73BF7", var_2.initchallengeandeventglobals, 2, "_encstr_847214E61647CAD8365A3A95FA1C8537AC36F5D87B63");
    }

    level.disable_super_in_turret._id_12EAC = var_0;
  }

  var_4 = getEnt("_encstr_8F651C38AAE019284FB47866892351D10DB29068A1BEA1A063DAF65D73BB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_4))
    var_4 delete();

  foreach(var_2 in level.disable_super_in_turret.paths) {
    foreach(var_7 in level.disable_super_in_turret._id_12EAC) {
      if(var_7.script_group == var_2.initchallengeandeventglobals) {
        var_8 = var_7;

        if(!isent(var_8))
          var_8 = _id_13697(var_7.model, var_7.script_group, var_7.script_index + 1);

        var_2.pieces[var_2.pieces.size] = var_8;
      }
    }

    var_2._id_12358 = _id_13697("_encstr_85B83B1DA529ADF76190F298150328399B28E3E9A9E343DBF7519BA0B27BCB35EF732115DF40B3F9112EAD0F2FBF0D62A09FA13A67191B49A7694F4702");
  }
}

_id_13697(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.script_group = var_1;
  var_4.script_index = var_2;

  if(isDefined(var_3)) {
    var_5 = getEnt(var_3, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_5)) {
      var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
      var_6.angles = var_4.angles;
      var_6 clonebrushmodeltoscriptmodel(var_5);
      var_6 linkTo(var_4);
    }
  }

  var_4 hide();
  return var_4;
}

rocket_fuel_x1(var_0, var_1) {
  foreach(var_3 in var_0.pieces) {
    if(var_3.script_index == var_1)
      return var_3;
  }
}

_id_1326A(var_0, var_1) {
  if(var_1 > 0) {
    var_2 = rocket_fuel_x1(var_0, var_1);
    var_0.idle_sfx _id_13DEC(var_2, var_1);
  }
}

_id_13DEC(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = (0, 0, 0);
  var_3 = (0, 0, 0);

  switch (var_1) {
    case 0:
      var_3 = (-41.3, -9.2, 106.1);
      break;
    case 1:
      var_3 = (-23.7, 40.8, 127.1);
      var_2 = (0, 2, -80);
      break;
    case 2:
      var_3 = (-70.7, 40.8, 127.1);
      var_2 = (0, 2, -80);
      break;
    case 3:
      var_3 = (9.7, -1.8, 100.1);
      var_2 = (0, -90, -84);
      break;
    default:
      break;
  }

  var_0 show();
  var_0 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3, var_2);
}

delay_start_escort_enter_vehicle_objective() {
  wait 5;
  scripts\mp\utility\sound::besttime("_encstr_B62D14FDC631782F1D2DA780E7C230C7905DB9230410");
  setglobalsoundcontext("_encstr_AAAC09D09972B9C83F2B7F", "_encstr_A1D0081CC297B1EDB08C");
}

_id_11E11() {
  level endon("_encstr_9BFB0EB9A3DB1C7DF6B395398E96B695");
  var_0 = 0;
  var_1 = respawn_trigger_think();

  for(;;) {
    var_2 = respawn_trigger_think();

    if(var_2 > var_1) {
      if(var_0 >= 10) {
        foreach(var_4 in level.players)
        var_4 playlocalsound("_encstr_A55D1998A32A47F3877139A041BBDE9FD30AF8D81AC57B2E7B993D");
      }

      var_0 = 0;
    } else if(var_2 == var_1)
      var_0 = var_0 + 1;

    var_1 = var_2;
    waitframe();
  }
}

_id_11E12() {
  while(isDefined(level.allowmeleevehicledamage) == 1) {
    foreach(var_1 in level.players) {
      var_2 = isDefined(var_1.allowmodestructs);

      if(var_2 == 0) {
        var_1 setplayermusicstate("_encstr_8A4E1EF122F339FFDA37013F6FB250706E7F7BCB0C055020936F370997FA8E78");
        var_1 playlocalsound("_encstr_A55D1998A32A47F3877139A041BBDE9FD30AF8D81AC57B2E7B993D");
        var_1.allowmodestructs = 1;
      }
    }

    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = isDefined(var_1.allowmodestructs);

    if(var_2 == 1) {
      var_1 setplayermusicstate("_encstr_BD041ABAEEB3AFD20B087A42A0694137B3DD12248B808FD117B8D27A");
      var_1.allowmodestructs = undefined;
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(4.5);

  foreach(var_1 in level.players)
  var_1 setplayermusicstate("_encstr_B40101");
}

_id_11E10() {
  for(;;) {
    level waittill("_encstr_8DF60F23B0D392DBEE488E95DE53779D73");
    level.allowmeleevehicledamage = 1;
    level thread _id_11E12();
    level thread _id_11E11();
    level waittill("_encstr_9BFB0EB9A3DB1C7DF6B395398E96B695");
    waittillframeend;
    level.allowmeleevehicledamage = undefined;
  }
}

_id_12804(var_0) {
  thread _id_126E0();
}

_id_12AA5() {
  foreach(var_1 in level.disable_super_in_turret.paths) {
    if(!isDefined(var_1) || !isDefined(var_1.vehicle)) {
      continue;
    }
    var_2 = var_1.vehicle;
    var_2 _id_1425B();
    getentitylessscriptablearray("_encstr_B23A1F22E8D0F7B95895E5E679613E7B10C3CA7B70B8A72FB1AF19FD6339874325", ["_encstr_BAF90AE00B4786F5B9B06B59", level.disable_super_in_turret._id_1226A, "_encstr_8E900BA7E9E5F426CF72D97B70", var_1.script_index, "_encstr_A67D145BF025A73DD1D14D3399A947CFCE0B8242D975", var_2 _id_14244(), "_encstr_A34D16106A2324B852FC3F9905BA18E0D3A24B9B124B6EE0", var_1._id_119D6, "_encstr_99041093C5542811D9F3D3A7EBA1652015DF", var_1._id_13BF5, "_encstr_A65616C61AAC1BD683EDD2B9E86EAF1BEDD683D8AC3A5623", var_1.getquestplunderrewardinstance, "_encstr_A14D14B07A976D5896248BDF6F3F30B6D3D308FA9223", var_1._id_11F9F]);
  }
}