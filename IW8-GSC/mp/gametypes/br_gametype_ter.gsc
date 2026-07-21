/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_ter.gsc
***********************************************/

init() {
  level.deletetimedrunhud = spawnStruct();
  level.deletetimedrunhud.autotarget = 0;
  level.deletetimedrunhud.waittillplayerlanded = -1;
  level.deletetimedrunhud.watchflashgrenadeexplode = [];
  level.deletetimedrunhud.teams = ["_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A"];
  level.deletetimedrunhud._id_12169 = getdvarint("_encstr_86411EE78F23A81862C19389B26738F51BABA76F4B5906F899A3B9E05B0970A1", 1);
  level.deletetimedrunhud._id_12C45 = getdvarint("_encstr_953F1FDC6CC9FA26E4FA1D569CBE39CAE2ABB4C9B2EB16B136EBB7EA47C1BD9BA3", 1);
  level.deletetimedrunhud.brjugg_watchgasdamage = getdvarfloat("_encstr_BEAB189BE06B977932B8DB0FAB16BE3C9490FC116A2820F75B33", 1);
  level.deletetimedrunhud.is_main_pilot = getdvarint("_encstr_914425DFDFBB6F62F656EBAB7DE7C3DB7B7FFFCBA029098341F69D0790DF650838EA9B28E948F3", 2);
  level.deletetimedrunhud.is_greater_than_equal_to = getdvarint("_encstr_87C926070FFE31A2285EB3FFD369EC6AD9A3CFD7F32ECA9D1941EF420BF83FA3B8196B6F45450242", 2);
  level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone = getdvarint("_encstr_A78125E6B1C97D26937D1D56C9FA8CC2B50B7695C226B1CAFA23959B47277B5EEB9B3816EEDCB9", 4);
  level.deletetimedrunhud.is_inflictor_a_carepackage = getdvarint("_encstr_817D296348B599C30B904C551EF6835E23E0AA9AB06D8D178665255B35BB67E01F18635298DD02C738DF30", 6);
  level.deletetimedrunhud.is_in_gas = getdvarint("_encstr_B6A92CDC6C39BE1327AFD1959CFA19586BC23BB25898D859BE23B237D139DBCBF537830BDD73BE0EC6AE7323959C", 3);
  level.deletetimedrunhud.is_helicopter_player_occupied = getdvarint("_encstr_8D8A29F86F4B577E2B79F3201317617972BE2735A1C2ACF0613963831B556F61B7FE6B5BBF7397A2C7BF37", 4);
  level.deletetimedrunhud.is_hostage_oob = getdvarint("_encstr_B4D62AB9364EAF31E4EBA32B937D8C856BC2CE2B584C8D95AF91ACE61DE4BD97FA371C5877DCF5169CD67B9C", 1);
  level.deletetimedrunhud.is_killstreak_valid_for_swat = ["_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA", "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922", "_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"];
  level.deletetimedrunhud.is_kidnapping_player = ["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"];
  level.deletetimedrunhud.is_instant_use_munition = ["_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18", "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD", "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"];
  level.deletetimedrunhud._id_141C4 = ["_encstr_BDC80A5437EAD749519A6068", "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_85DE05A6B2AC0E", "_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8C190467402B", "_encstr_99C20BA548E9F27A61D897932B"];
  level.deletetimedrunhud._id_1420A = getdvarfloat("_encstr_BAC121BA66F88E0623A9637A9289431278098EE3A766638DD30BF19BF6962F6013DFF8", 5);
  level.deletetimedrunhud.types = [];
  level.phonesringing_code = getdvarint("_encstr_AADA21BF323BE98252398339838907710EB17B7030CE2823091159419F836F03BAE55B", 1);
  level.phonesringing_singlemorse = getdvarint("_encstr_BD481A9BC196CF2E287FBCB53D19776BA899B2036966DB276979B5BC", 1);
  teleport_to_track_start();
  teleport_to_silo_airlock();
  timeoutradialunfill();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AB23109F838B7B7448013FC5BBA84402D013");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97D715AB703EF3ADD2C928B0BDD3459E8E130B36559856");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_93320D7BF0CF0FDFA807F1CF4FE862");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AAF215A7382770D5F975C84D2081C06EE5B8E0792397EB", ::spawninitialvehicles);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97670EEB0EFB48B1BA22F028DA0D6701", ::manage_fakebody_hides);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AC2A12B9D6A538A4DC66A5366A95B8BACA9BD8AC", ::_id_133D6);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::playerrespawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
  level.dialog_wait_ready_civ = 6;
  br_circleradiizero();
  br_circleshowdelaydanger();
  level thread testclient_run_funcs();
}

testclient_run_funcs() {
  waittillframeend;
  scripts\mp\flags::gameflaginit("_encstr_B14F123B23DE1196F0D8941E3098F7ABB743AFDB", 0);
  scripts\mp\flags::gameflaginit("_encstr_BAC4107BE7F88EC67227206BD982C252800E", 0);
  scripts\mp\flags::gameflaginit("_encstr_95481347B24ED71B58BCDBD5E87D9B07C277CDAC19", 0);
  scripts\mp\flags::gameflaginit("_encstr_A2D20FE4880D52A426C867576878654BD3", 0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_8E1318E912B74D912D942347ADD240B763DBE3373A977F38C366", ::vehicle_spawn_mp_gamemodesupportsrespawn);
  level._id_12888 = ::emp_drone_proximity_explode;
  level._id_11C76 = ::dyn_door;
  scripts\engine\scriptable::_id_12F5B("_encstr_93F30F7D2D83A6990E8A685022264D1837", ::is_riding_heli);
  level.spawnprotectiontimer = getdvarfloat("_encstr_B2682062E6939F397B1FC997ADC61F5F61F8509283C8D01568CC62F708FDC45145A0", 5);
  level.deletetimedrunhud._id_12CA1 = getdvarint("_encstr_B445176FE67397158A277191B519EE908117186FA2B7E94913", 0);
  thread _id_1452D("_encstr_9A8507BA4040188D08");
  thread _id_1452D("_encstr_8E8405EA382B2A");
  tracegroundheightexfil();
  initstructs();
  timed_laser_trap_trigger_array();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = getDvar("_encstr_A3B81702B14887F2F677132F55085AF148983B4BAE4041DA45", "_encstr_8B1608EC43B8D647A113");
  var_1 = level.deletetimedrunhud.watchflashgrenadeexplode[var_0];
  var_1 watchfor_pain_or_nearby();
  scripts\mp\flags::gameflagset("_encstr_95481347B24ED71B58BCDBD5E87D9B07C277CDAC19");
  scripts\mp\flags::gameflagset("_encstr_BAC4107BE7F88EC67227206BD982C252800E");
  var_1 watchdumpsterplayerexit();
}

tracegroundheightexfil() {
  level.deletetimedrunhud.vo = spawnStruct();
  level.deletetimedrunhud.vo._id_13B72 = [];

  foreach(var_1 in level.deletetimedrunhud.teams)
  level.deletetimedrunhud.vo._id_13B7D[var_1] = [];

  var_3 = getdvarint("_encstr_8D8A26F86F4B577E2B79F32013176171B2FD373466F2ACB861396392AA5B6D7B5FE8AA47B738A6C2", 5000);
  var_4 = getdvarint("_encstr_A30D2808D7D881080B6FD3D2E5F12752F0BBFA7AA92FD1B940231B02106348913377372B51CBC097D260", 5000);
  traceresultisValid("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A9341086475D6B710127AD68ED4042EFC908");
  traceresultisValid("_encstr_815C115F2F8A0550A1553936FF95C8B74393D9", "_encstr_92D90ECA58D9ECAFFFE5F62B1D0FDDFF", var_4);
  traceresultisValid("_encstr_B1170EDCCA8D57C92DE63BD7310B9B59", "_encstr_88BF0CF09BE95F9DD0C3F8349D71", var_4);
  traceresultisValid("_encstr_A7270B37CAC6BA4E96CD76BE2C", "_encstr_A7270B37CAC6BA4E96CD76BE2C", var_4);
  traceresultisValid("_encstr_AB270BF3CD11AFEAA31812A940", "_encstr_AB270BF3CD11AFEAA31812A940", var_4);
  traceresultisValid("_encstr_99270B0B3F0BC056E2C34F371F", "_encstr_99270B0B3F0BC056E2C34F371F", var_4);
  traceresultisValid("_encstr_91270B68A22E13B3A766BCB844", "_encstr_91270B68A22E13B3A766BCB844", var_4);
  traceresultisValid("_encstr_8F270B380596131AEB68C8A788", "_encstr_8F270B380596131AEB68C8A788", var_4);
  traceresultisValid("_encstr_B1C1109B2BC6D527B223D78CB2CC16EAB13A", "_encstr_87EB0D3BC089CF595705669BF613A2");
  traceresultisValid("_encstr_84040D372B1B57E4CA32BE89166ECA", "_encstr_8CD90B0B4B0893C5803B12DFF1");
  traceresultisValid("_encstr_A7010A03FD5FFFE3521A09C8", "_encstr_A7010A03FD5FFFE3521A09C8");
  traceresultisValid("_encstr_9B010A0FFD30CD6AE50956EB", "_encstr_9B010A0FFD30CD6AE50956EB");
  traceresultisValid("_encstr_99010A734743881E7AA38787", "_encstr_99010A734743881E7AA38787");
  traceresultisValid("_encstr_8B010A9BC5CF20CDF9FAE19D", "_encstr_8B010A9BC5CF20CDF9FAE19D");
  traceresultisValid("_encstr_83010ACD591B5DC959C87D56", "_encstr_83010ACD591B5DC959C87D56");
  traceresultisValid("_encstr_B6AB0F1BEDB9D27376AF9195990B5D1BA3", "_encstr_81FB0C66D908DF7739F82BB2E084", var_3);
  traceresultisValid("_encstr_A95D0C1BB76E2DDC76FA98583795", "_encstr_A67B139A33B0AF7EA8D94D329B208717C548C2729A", var_3);
  traceresultisValid("_encstr_9BDC098D7BCD96DC76FA2C", "_encstr_9BDC098D7BCD96DC76FA2C", var_3);
  traceresultisValid("_encstr_83DC0901B70A98F85731F1", "_encstr_83DC0901B70A98F85731F1", var_3);
  traceresultisValid("_encstr_8BDC0955A0D021A28C87BF", "_encstr_8BDC0955A0D021A28C87BF", var_3);
  traceresultisValid("_encstr_93DC09C6F637B437CEEB19", "_encstr_93DC09C6F637B437CEEB19", var_3);
  traceresultisValid("_encstr_A1DC0929273333A5D46689", "_encstr_A1DC0929273333A5D46689", var_3);
  traceresultisValid("_encstr_85470DCC7F38BBD79D19DAD263E133", "_encstr_86B50A09DDA9F06012670701");
  traceresultisValid("_encstr_BE6B0A1138833BD14D61A378", "_encstr_83440C6C91D7D9D77BD336F887A4");
  traceresultisValid("_encstr_AD68071BF6B9A3BE0B", "_encstr_AD68071BF6B9A3BE0B");
  traceresultisValid("_encstr_976807690FAFEBD7F6", "_encstr_976807690FAFEBD7F6");
  traceresultisValid("_encstr_AA68071BD0C3C4417F", "_encstr_AA68071BD0C3C4417F");
  traceresultisValid("_encstr_A66807089AB2999EEB", "_encstr_A66807089AB2999EEB");
  traceresultisValid("_encstr_B26807A5E0B3C99E27", "_encstr_B26807A5E0B3C99E27");
}

traceresultisValid(var_0, var_1, var_2) {
  game["_encstr_B2DA070A5F8BAB87AF"][var_0] = var_1;

  if(isDefined(var_2))
    _id_13286(var_0, var_2);
}

teleport_to_track_start() {
  level.deletetimedrunhud.is_goal_crowded = [];
  level.deletetimedrunhud.is_lower = ["_encstr_8ABE19FA4BDF69C550C198A1C55A92D789A381E7FE37F513306772", "_encstr_BD740AAF03B8971B675312CB", "_encstr_8BD109806AE5BF89C365A1", "_encstr_917D079BB2E43B2BE4", "_encstr_844F0CB9D753E5A1133F23BB27FA", "_encstr_B123084EA6A74B4E0888", "_encstr_8F8213AF2B3AE3B15E996995E1707F6098295D1251", "_encstr_84980B1A7547721727CFA2F06D", "_encstr_87680AB085AF1DBA93C92B1D"];
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[0]] = init_relic_focus_fire("_encstr_96010BDCD8392D073A164C1B2B");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[1]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_A58B203AF3BFF4C738A8250BB38F8BC73047D70F86509D8DF0B1DBD35710EF2337C2", 525, "_encstr_AA8F2A06AAC1D9815A5F3060DB5F792B0A960C1DC6AAA1C90FA7087867AA914972FAE8155FD329D317B72B20", 90);
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[2]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_A23F1F46EA8199C11A1F70209B1FB9EBCA564C5D86EA6109CFC728284F7CB30B12", 375, "_encstr_8B9D29332856B4922D608F45DD4FBA69B828AFD7582914DA1FB794FD50D11325C0713B5F708342A28B2DDF");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[3]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_ADDC1D9D2A81F0FD83B191F86B5F250BA5912F1BA136F8350F6BE963736FE6", 675, "_encstr_96ED2713937D1DB29CEB56E6E8D723C2D658ECB2B098D8CA7DE62B93D9594EFA3256CD3A4EEDF25932", 0, (12, 12, 0));
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[4]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_A2902226C9BEE8B29CD72BCD47D79116AD85CE560B89632BD71DB0072BEB9B56933BB2C9", 600, "_encstr_82F22CD273870B7363E9C96EE8B63FD77A484285A8EB1A2B593397E0BA3E6383BA655DA676D52AD39BDBB08F5333", 180);
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[5]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_8BB31EC439D7A3CAE47D95CDE87D91166B163B562C98D859BE166C7D57734B1D", 450, "_encstr_935F28139CF51DAC9CFAB2CD8ED791C2B5B0B32B589863CABEB0C6FAD5374B47EB1959378E4EDE97B291", -90, (12, 0, 0));
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[6]] = init_relic_focus_fire("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_96541EC44EAF1D2BE4AF95CD1DEB1C4EED83C237CAEB47859BB6F5B1B027EC59", 2200, "_encstr_9274283280AF139F4B509D9EDD36135A67288A6A50D74BC7E0A25F847FFB0727DF6072334025459FF91D");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[7]] = init_relic_focus_fire("_encstr_84980B1A7547721727CFA2F06D");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[8]] = init_relic_focus_fire("_encstr_87680AB085AF1DBA93C92B1D");
}

init_relic_focus_fire(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.is_minimap_forcedisabled = var_0;

  if(var_0 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    if(!isDefined(var_4))
      var_4 = 0;

    if(!isDefined(var_5))
      var_5 = (0, 0, 0);

    var_6.model = var_1;
    var_6.health = var_2;
    var_6.modeldestroyed = var_3;
    var_6._id_11A49 = var_4;
    var_6._id_11A3F = var_5;
  } else if(var_0 == "_encstr_84980B1A7547721727CFA2F06D" || var_0 == "_encstr_87680AB085AF1DBA93C92B1D") {
    if(!isDefined(var_4))
      var_4 = 0;

    if(!isDefined(var_5))
      var_5 = (0, 0, 0);

    var_6._id_11A49 = var_4;
    var_6._id_11A3F = var_5;
  }

  var_6._id_12C46 = !(var_0 == "_encstr_87680AB085AF1DBA93C92B1D" && !getdvarint("_encstr_95A81CDCD8C9BE4C93F5E8954EFA2CB0FA3BD537DCF5272BC5D5A593B223", 1));
  return var_6;
}

teleport_to_silo_airlock() {
  var_0 = ["_encstr_993E0FDA20CB9DCF164096B7ED794FA361", "_encstr_879B0C97EF6A47F8E6591BB2BAD5", "_encstr_BA4B12F74B889A37B87EAA62810E0F19A82B956D", "_encstr_853311E8C7314397A2E9069FFA4AAFC8995FF0"];

  foreach(var_2 in var_0) {
    level.deletetimedrunhud.is_position_open[var_2] = [];
    level.deletetimedrunhud.is_raid_gamemode[var_2] = [];
  }

  level.deletetimedrunhud.is_raid_gamemode["_encstr_993E0FDA20CB9DCF164096B7ED794FA361"]["_encstr_8DED0A31E71B664BCF5A8880"] = 0.1;
  level.deletetimedrunhud.is_raid_gamemode["_encstr_BA4B12F74B889A37B87EAA62810E0F19A82B956D"]["_encstr_A1100738A33A638123"] = 0.25;
  level.deletetimedrunhud.is_same_combat_action = getdvarint("_encstr_8313216340360726DB01795AA3D73F95487EC2223E5D098067D7BA0D599148AF986710", 50);
  level.deletetimedrunhud.is_scriptable_healthy = getdvarint("_encstr_92122DA397D391C29E8F426AC201B2213963708A010D9AEB5A0151117EC78FF39AAAA9EEF720FAD54355A085F1E573", 500);
  level.deletetimedrunhud.is_so_stars_enabled = getdvarfloat("_encstr_879D2412A15897E28607232F7B27FAE578294D1FDE90757A53170B3737D9C256E193C2E73158", 5.0);
}

timeoutradialunfill() {
  level.deletetimedrunhud._id_1196C = [];
  level.deletetimedrunhud._id_1196C["_encstr_8B1608EC43B8D647A113"] = init_server("_encstr_BD351CD596AF6B83F5C4C9BEB516385B56CD5DF5D28DEDDCAF47DBBBCA27", "_encstr_928017BD732E676667C05982082F9BEF23F034251C31DFED09", &"_encstr_B4F8188D5297696DF1667977FF0920196D7FD6C50F36893D6893", "_encstr_8B1608EC43B8D647A113");
  level.deletetimedrunhud._id_1196C["_encstr_994C023A"] = init_server("_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", "_encstr_A3A7115D2D7D4BB17BB9EB899CFA4756E4D785", &"_encstr_AA83127A8BF6D1B70332A1D73671908B612920E7", "_encstr_994C023A");
  level.deletetimedrunhud._id_1196C["_encstr_8B4C024C"] = init_server("_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", "_encstr_8FA7115B174103A0AF5D269942B7504D2B67ED", &"_encstr_978312214ABE2A2AA4F2317A34FA93A03515D790", "_encstr_8B4C024C");
  level.deletetimedrunhud._id_1196C["_encstr_834C02D8"] = init_server("_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", "_encstr_91A7113BB91980767F5A5EE183E7B5A8EA379F", &"_encstr_AD83122425EB512A92E5C4D386AF9C05A6A2FA68", "_encstr_834C02D8");
  level.deletetimedrunhud._id_1196C["_encstr_A14C02D1"] = init_server("_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", "_encstr_ACA7113B381FB8969AD3770D9EC7690DD59FF1", &"_encstr_8583120992D78A5449BC89A7A17D935053A2D711", "_encstr_A14C02D1");
  level.deletetimedrunhud._id_1196C["_encstr_934C02B2"] = init_server("_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", "_encstr_B8A711F04471384AE0A0BFFAEB499C97F82765", &"_encstr_8A8312D119D9E1076238B9872FFFC806ED2F197F", "_encstr_934C02B2");

  foreach(var_1 in level.deletetimedrunhud.teams)
  level.deletetimedrunhud._id_1196C[var_1] = init_server("_encstr_8EA81FD351E15817570253FEDA87CF8087BE2B0FC9567B502FCA6963B35F0EC0DF", "_encstr_BD3914E0DA998339E70EC85E0AFF03533A41D0D8D3AF", &"_encstr_8C97152492AF455192F2139E86EB93509A2AFA8482A62A", "_encstr_A29B05E9400E5D");
}

init_server(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_11F89 = var_0;
  var_4.hudicon = var_1;
  var_4.locname = var_2;
  var_4._id_14308 = "_encstr_BA4C02DF" + var_3;
  return var_4;
}

initstructs() {
  if(isDefined(level.tower_ground_mortar))
    [[level.tower_ground_mortar]]();
}

timed_laser_trap_trigger_array() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_82E20B431502D9C1DF58FFE713", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2._id_13A8F = "_encstr_8B4A078DB097ED571D";
    var_2.name = var_2.script_noteworthy;
    var_2.script_noteworthy = undefined;
    level.deletetimedrunhud.watchflashgrenadeexplode[var_2.name] = var_2;
  }

  foreach(var_2 in level.deletetimedrunhud.watchflashgrenadeexplode)
  var_2 _id_13A83();
}

_id_13A83() {
  self.targets = [];

  if(!isDefined(self.target)) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.target = undefined;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_9B0D05E058E6CD" && isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_5 in var_3)
      var_0[var_0.size] = var_5;
    }
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_9B0D05E058E6CD") {
      continue;
    }
    if(!_id_13A90(var_2.script_noteworthy) || !is_riding_hel(var_2.script_parameters) || !_id_14270(var_2.script_parameters)) {
      continue;
    }
    if(!istrue(var_2._id_128A9)) {
      var_2._id_13A8F = var_2.script_noteworthy;
      var_2.script_noteworthy = undefined;
      var_2.name = var_2.script_parameters;
      var_2.script_parameters = undefined;

      if(!isDefined(var_2.angles))
        var_2.angles = (0, 0, 0);

      var_2._id_128A9 = 1;
      var_2 _id_13A83();
    }

    if(!isDefined(self.targets[var_2._id_13A8F]))
      self.targets[var_2._id_13A8F] = [];

    var_8 = self.targets[var_2._id_13A8F].size;
    self.targets[var_2._id_13A8F][var_8] = var_2;

    if(!isDefined(var_2._id_13A82))
      var_2._id_13A82 = [];

    var_2._id_13A82[var_2._id_13A82.size] = self;
  }
}

watchfor_pain_or_nearby() {
  allow_br_loot_to_br_marked();

  if(getdvarint("_encstr_85EA230BBFE8A90BBE6682CB2B18C71FF83DAF70C928ADDFF01BCBB2F3ED8FD2A88B1FE64F", 0)) {
    foreach(var_1 in level.deletetimedrunhud.types["_encstr_A29B05E9400E5D"])
    var_1 chuckerlogic();
  }

  level.deletetimedrunhud.types["_encstr_AC6E09881A36337B5F6F30"] = scripts\engine\utility::array_combine(level.deletetimedrunhud.types["_encstr_A29B05E9400E5D"], level.deletetimedrunhud.types["_encstr_8F1308474FDBA7D8DBB3"]);
}

chuckerlogic() {
  var_0 = undefined;

  foreach(var_2 in self.targets["_encstr_8F1308474FDBA7D8DBB3"]) {
    var_0 = var_2;
    break;
  }

  if(!isDefined(var_0)) {
    return;
  }
  self.targets["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"] = [];

  if(!isDefined(level.deletetimedrunhud.types["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"]))
    level.deletetimedrunhud.types["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"] = [];

  var_4 = var_0.origin - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_5 = vectortoangles(var_4);
  var_6 = getdvarfloat("_encstr_B4D92AD2BEF5E17A53D9AFE798A80F2AA340518A917B2A851E90F3BFC0E3D793216F238586DF02CDE0C8BB93", 6000);
  var_7 = getdvarfloat("_encstr_84F32B53C07BC00A53B9AF05437FBE92F523B920D316D522970765C7AA303677F267478036E70B5DC6DB464B29", -2000);
  var_8 = getdvarfloat("_encstr_AA6A2B67B0E3EF925D109E93ED3F199FA9605FF32079062A2F1EA38ED6E1D1335370470340165343AB3EEC45B4", 800);
  var_9 = getdvarint("_encstr_BA3A297FBFE2877DE629B09D2497292AD5A029194BC97A92618F931010EB014AA36388E5C778B350C36843", 20);
  var_10 = vectorcross(var_4, (0, 0, 1));
  var_11 = var_10 * (var_9 / 2) * var_8 + self.origin + (0, 0, var_6) + var_4 * var_7;

  for(var_12 = 0; var_12 < var_9; var_12++) {
    var_13 = spawnStruct();
    var_13.origin = var_11 - var_10 * (var_12 * var_8);
    var_13.angles = var_5;
    var_13._id_13A8F = "_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3";
    var_13.targets = [];
    var_14 = self.targets["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"].size;
    self.targets["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"][var_14] = var_13;
    var_14 = level.deletetimedrunhud.types["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"].size;
    level.deletetimedrunhud.types["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"][var_14] = var_13;
  }
}

allow_br_loot_to_br_marked() {
  if(istrue(self.spawned)) {
    return;
  }
  self.spawned = 1;
  var_0 = self._id_13A8F;

  if(!isDefined(level.deletetimedrunhud.types[var_0]))
    level.deletetimedrunhud.types[var_0] = [];

  var_1 = level.deletetimedrunhud.types[var_0].size;
  level.deletetimedrunhud.types[var_0][var_1] = self;

  foreach(var_0, var_3 in self.targets) {
    foreach(var_6, var_5 in var_3) {
      var_5 _id_13A8B();
      var_5 allow_br_loot_to_br_marked();
    }
  }
}

_id_13A8B() {
  switch (self._id_13A8F) {
    case "_encstr_A3DB0B46B0ADC2CE56C24C8D56":
      self.team = self._id_13A82[0].team;
      thread is_relic_swat_active();
      break;
    case "_encstr_AA15062C769537A3":
      self.team = self._id_13A82[0].team;
      thread bintheplane();
      break;
    case "_encstr_B1A410B32B0D96B1B159D7C6AB933995B93A":
    case "_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C":
    case "_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99":
    case "_encstr_9A50080BA7292FFA0DA2":
      thread _id_14262();
      break;
    case "_encstr_A29B05E9400E5D":
      self.team = self.name;
      target_in_range_and_fov("_encstr_8F1308474FDBA7D8DBB3");
      break;
    case "_encstr_8F1308474FDBA7D8DBB3":
      self.team = self._id_13A82[0].team;

      if(!isDefined(self.name))
        self.name = "_encstr_8B1608EC43B8D647A113";

      target_in_range_and_fov("_encstr_8F1308474FDBA7D8DBB3");
      break;
    case "_encstr_B48D064CB8E8E33A":
      thread wait_for_garage_open();
      break;
    default:
      break;
  }
}

_id_13A90(var_0) {
  var_1 = "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97";

  if(!isDefined(var_0))
    return 1;

  switch (var_0) {
    case "_encstr_AA15062C769537A3":
      var_1 = var_1 + "_encstr_AA15062C769537A3";
      break;
    case "_encstr_B1A410B32B0D96B1B159D7C6AB933995B93A":
    case "_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C":
    case "_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99":
    case "_encstr_9A50080BA7292FFA0DA2":
      var_1 = var_1 + "_encstr_9A50080BA7292FFA0DA2";
      break;
    case "_encstr_B48D064CB8E8E33A":
      var_1 = var_1 + "_encstr_B48D064CB8E8E33A";
      break;
    default:
      return 1;
  }

  if(var_1 == "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97")
    return 1;

  if(getdvarint(var_1, 0) != 0)
    return 0;

  return 1;
}

is_relic_swat_active() {
  var_0 = undefined;
  var_1 = level.deletetimedrunhud.is_goal_crowded[self.name];

  switch (var_1.is_minimap_forcedisabled) {
    case "_encstr_96010BDCD8392D073A164C1B2B":
      var_0 = easepower(self.name, self.origin, self.angles);
      break;
    case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
      var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      var_0.angles = self.angles;
      var_0 setModel(var_1.model);
      var_0 solid();
      break;
    case "_encstr_87680AB085AF1DBA93C92B1D":
      if(isDefined(level.arenaflag_setenabled))
        var_0 = self[[level.arenaflag_setenabled]]();

      break;
    default:
      break;
  }

  self.is_minimap_forcedisabled = var_1.is_minimap_forcedisabled;
  self._id_12C46 = var_1._id_12C46;
  self.ent = var_0;
  self.ent._id_13A85 = self;
}

is_riding_hel(var_0) {
  var_1 = "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97";

  if(!isDefined(var_0))
    return 1;

  if(var_0 == "_encstr_87680AB085AF1DBA93C92B1D" && !getdvarint("_encstr_A56E13EBAFD915984AA2E9C38A3F4040921B797B53", 0))
    return 0;

  foreach(var_3 in level.deletetimedrunhud.is_lower) {
    if(var_0 == var_3) {
      var_1 = var_1 + var_3;
      break;
    }
  }

  if(var_1 == "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97")
    return 1;

  if(getdvarint(var_1, 0) != 0)
    return 0;

  return 1;
}

bintheplane() {
  self.state = "_encstr_88C5055208731B";
  var_0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.is_minimap_forcedisabled = var_0.is_minimap_forcedisabled;
}

_id_14262() {
  self.state = "_encstr_88C5055208731B";
}

_id_14270(var_0) {
  var_1 = "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97";

  if(!isDefined(var_0))
    return 1;

  foreach(var_3 in level.deletetimedrunhud._id_141C4) {
    if(var_0 == var_3) {
      var_1 = var_1 + var_3;
      break;
    }
  }

  if(var_1 == "_encstr_B606149BBAD0619A882849AF33B7F387A79A06E10F97")
    return 1;

  if(getdvarint(var_1, 0) != 0)
    return 0;

  return 1;
}

watchdumpsterplayerexit() {
  watchdangerresetaction();

  foreach(var_1 in self.targets["_encstr_A29B05E9400E5D"]) {
    var_1 circle();
    var_1 thread _id_11987(var_1);
  }

  self waittillmatch("_encstr_969E1436864BD823EB360D2C37762B467DB91DB08E56", "_encstr_83320ADDB7DB01AB8F3FF8E8");
  var_3 = [];

  foreach(var_1 in self.targets["_encstr_A29B05E9400E5D"]) {
    if(var_1.state == "_encstr_83320ADDB7DB01AB8F3FF8E8")
      var_3[var_3.size] = var_1.team;
  }

  if(var_3.size == 1)
    var_6 = var_3[0];
  else
    var_6 = scripts\engine\utility::random(level.deletetimedrunhud.teams);

  var_7 = respawn_flare_used(var_6);
  var_8 = "_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC";
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_6, 2, undefined, 1, 1, 1);
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brendgame(var_7, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_8], 0);
}

_id_11987(var_0) {
  if(isDefined(self.state)) {
    return;
  }
  self endon("_encstr_83320ADDB7DB01AB8F3FF8E8");
  _id_11981(var_0);

  foreach(var_2 in self.targets["_encstr_8F1308474FDBA7D8DBB3"])
  var_2 thread _id_11987(var_0);

  thread _id_11988();

  if(level.deletetimedrunhud._id_12169)
    _id_1198B("_encstr_AB250AF04690AB2FB7C8321A");
  else
    _id_1198B("_encstr_930B07BB1B6B3854FF");

  if(level.deletetimedrunhud._id_12C45)
    _id_11998();
  else
    _id_11999();

  _id_1198B("_encstr_AF5A081BBAC993AC73A3");
}

_id_11988() {
  self endon("_encstr_83320ADDB7DB01AB8F3FF8E8");
  _id_11997();
  thread _id_1198B("_encstr_83320ADDB7DB01AB8F3FF8E8");
}

circle() {}

_id_11981(var_0) {
  foreach(var_2 in self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"])
  var_2 sub_civtarget();

  self.state = "_encstr_B40101";
  _id_11982(var_0);
  _id_1198B("_encstr_95DF070DD22319CA9B");
  var_4 = ["_encstr_AC230AABDAA970F8214B2B25", "_encstr_B4230A5718B1D742171FABA3", "_encstr_9B010C0F7720CF6DDFEB33E7C57C", "_encstr_92A20CBBD35774B811B06173C6C7", "_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"];

  foreach(var_6 in var_4) {
    if(!isDefined(self.targets[var_6])) {
      continue;
    }
    self._id_11E85[var_6] = 0;
    self.targets[var_6] = scripts\engine\utility::array_randomize(self.targets[var_6]);
  }
}

sub_civtarget() {
  self.state = "_encstr_B40101";
  is_relic_collat_dmg_active("_encstr_AB250AF04690AB2FB7C8321A");
}

_id_1198B(var_0, var_1) {
  if(self.state == var_0) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  self.state = var_0;

  switch (self.state) {
    case "_encstr_95DF070DD22319CA9B":
      _id_11989(0);
      _id_1198A("_encstr_8267056410C669", 1, 0, 0);
      _id_11990(0.0);
      break;
    case "_encstr_AB250AF04690AB2FB7C8321A":
      _id_11989(0);
      _id_1198A("_encstr_930B07BB1B6B3854FF", 1, 1, 0);
      _id_11990(0.5);
      _id_11971("_encstr_9A50080BA7292FFA0DA2");
      _id_11971("_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C");
      break;
    case "_encstr_930B07BB1B6B3854FF":
      _id_11989(1);
      _id_1198A("_encstr_930B07BB1B6B3854FF", 1, 0, 0);
      _id_11990(1.0);
      _id_11971("_encstr_9A50080BA7292FFA0DA2");
      _id_11971("_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C");
      break;
    case "_encstr_AF5A081BBAC993AC73A3":
      _id_11989(1);
      _id_1198A("_encstr_AF5A081BBAC993AC73A3", 4, 0, 1);
      _id_11990(1.0);
      _id_11971("_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C");
      _id_11971("_encstr_B1A410B32B0D96B1B159D7C6AB933995B93A");
      _id_1196F("_encstr_AA15062C769537A3");
      break;
    case "_encstr_83320ADDB7DB01AB8F3FF8E8":
      foreach(var_3 in self.targets["_encstr_8F1308474FDBA7D8DBB3"])
      var_3 _id_1198B("_encstr_83320ADDB7DB01AB8F3FF8E8", 1);

      _id_11989(0);
      _id_1198A("_encstr_8267056410C669", 1, 0, 0);
      _id_11993();
      _id_11971("_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99");
      _id_11979("_encstr_8A9716CCE71CF0912B19E788A86477A7AF6EA3BB30D32F9C");
      _id_11979("_encstr_B1A410B32B0D96B1B159D7C6AB933995B93A");
      _id_11978("_encstr_AA15062C769537A3");

      if(!var_1) {
        level thread scripts\mp\hud_message::notifyteam("_encstr_A66814784BB999D9B3DF3035EC63405FDB218088330B", "_encstr_8B8B18264A6E7C05BD616D90AC6A886FADE726518849F3DACF49", self.team);
        dmztutendgame(_id_1197E(), respawn_flare_used(self.team));
        dmztutendgame(_id_1197D(), self.team);
      }

      break;
    default:
      break;
  }

  self notify(self.state);

  foreach(var_6 in self._id_13A82)
  var_6 notify("_encstr_969E1436864BD823EB360D2C37762B467DB91DB08E56", self.state);
}

_id_11982(var_0) {
  self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(self.objidnum != -1) {
    var_1 = _id_1197A();
    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, "_encstr_A2BE0AB4DC3BB46E5A981BAC", self.origin);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, var_1._id_11F89);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, var_0.team);
    objective_setfriendlylabel(self.objidnum, "_encstr_B88912246F887B7FA1670F0AC5A177675C2578E8");
    objective_setenemylabel(self.objidnum, "_encstr_9BDD1348927D458A2579E924947D22A2358AA43DB2");
    _func_421(self.objidnum, 1);
  }
}

brc130airdropcratecapturecallback(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 128);
  var_3 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_8D481B95B959D697F563BBBE989CAF4DBAEC9D594E37C2AB8EF5D12B27", var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  var_3.team = var_2;

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, var_3.team))
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, var_3.team);

  var_4 = getdvarint("_encstr_875417B9C69CEB264EEBD19527F553AECE767DD0B216D83A86", 3500);
  var_3.loadout_giveweaponobj = 1;
  var_3.maxhealth = var_4;
  var_3.health = var_4;
  var_3.agentdamagefeedback = 0;
  var_3.eliminate_drone_minigun_speed = 10000;
  var_3.eliminate_drone_internal = 2;
  return var_3;
}

bot_custom_classes_allowed() {
  if(isDefined(self))
    self kill();
}

br_circleshowdelaydanger() {
  level.agent_funcs["_encstr_B46C210149BDAF7BAF4ADE39671BD108CFD93AD3393C432A8F032A383FDD44AFF4E562"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::frontend5lobby;
  level.agent_funcs["_encstr_B46C210149BDAF7BAF4ADE39671BD108CFD93AD3393C432A8F032A383FDD44AFF4E562"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_B46C210149BDAF7BAF4ADE39671BD108CFD93AD3393C432A8F032A383FDD44AFF4E562"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypekilled;
}

br_circleradiizero() {
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\engine\scriptable::scriptable_setinitcallback(::brc130airdropcrateactivatecallback);
}

brc130airdropcrateactivatecallback() {
  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  scripts\engine\utility::flag_set("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
}

frontend5lobby(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(getdvarint("_encstr_9BC219FB36CBFFE69D892B32C8EF9D8381B063685853B76C73E8B2", 0))
    var_2 = 99999;

  scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

spawninitialvehicles() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::spawninitialvehicles();
  else
    scripts\mp\flags::gameflagset("_encstr_B14F123B23DE1196F0D8941E3098F7ABB743AFDB");
}

vehicle_spawn_mp_gamemodesupportsrespawn() {
  return 0;
}

onplayerkilled(var_0) {
  var_1 = var_0.victim;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(isDefined(var_1)) {
    if(!istrue(var_1.br_infilstarted)) {
      return;
    }
    var_1 _id_126D9();
  }
}

_id_126D9(var_0) {
  if(!istrue(var_0)) {
    if(isDefined(self._id_136A6)) {
      var_1 = getdvarfloat("_encstr_840725A357F607907379833F93D6E9489913E7FDD9B74B32C03D41EBF141D509FF211861977DEE", 8.0);
      var_2 = var_1 * 1000;
      var_3 = gettime() - self._id_136A6;

      if(var_3 < var_2)
        return;
    }
  }

  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in level.deletetimedrunhud.types["_encstr_AC6E09881A36337B5F6F30"]) {
    if(var_7.state == "_encstr_AF5A081BBAC993AC73A3") {
      var_8 = distance(var_7.origin, self.origin);

      if(!isDefined(var_5) || var_8 < var_5) {
        var_5 = var_8;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_4)) {
    var_10 = 1;
    var_11 = _id_1257D();

    if(var_11 == "_encstr_A29B05E9400E5D") {
      var_12 = _id_12565();
      var_13 = distance(var_12.origin, self.origin);

      if(var_13 < var_5)
        var_10 = 0;
    }

    if(var_10) {
      if(var_4.team == self.team)
        _id_12678(var_4);
      else
        _id_1266E(var_4);
    }
  }
}

manage_fakebody_hides(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }

  _id_143F7();

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(!isDefined(var_2)) {
      continue;
    }
    if(!isalive(var_2))
      var_2 scripts\mp\playerlogic::spawnplayer(0);

    if(istrue(var_2.delay_enter_combat_after_investigating_grenade))
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_2);

    var_2 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
    var_2 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
    var_2.br_infilstarted = 1;

    if(!var_0)
      var_2 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();

    var_2 thread _id_1255F();
  }

  if(!var_0)
    wait 2.0;

  level.disable_super_in_turret._id_13916 = 0;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 thread _id_1255C();
  }

  scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  _id_143F8(10);

  if(!var_0) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2))
        var_2 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
    }
  }

  waitframe();

  foreach(var_2 in level.players)
  var_2 _id_1255E();

  scripts\mp\flags::gameflagset("_encstr_A2D20FE4880D52A426C867576878654BD3");
  dmzwincost("_encstr_9A2B0A12F03587575B7BBEA5");
}

_id_143F7() {
  var_0 = gettime() + 10000;

  while(gettime() < var_0 && getactiveclientcount() != level.players.size)
    waitframe();
}

_id_133D6() {
  manage_fakebody_hides(1);
}

_id_1255F() {
  _id_1268B("_encstr_A29B05E9400E5D");
  self.player_enemy = _id_1257C();
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(self.player_enemy);
}

_id_1255C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
  self.forcespawnorigin = self.player_enemy.origin;
  self.forcespawnangles = self.player_enemy.angles;
  self._id_12CA8 = 1;
  self.plotarmor = 1;
  scripts\mp\playerlogic::spawnplayer();

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  waitframe();
  self.player_enemy = undefined;
  self.plotarmor = undefined;
  self._id_12CA8 = undefined;
  self.thrust_fx_model = undefined;
  self freezecontrols(1);
  self playerhide();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  if(_id_13875())
    _id_12613();

  level.disable_super_in_turret._id_13916++;
}

_id_1255E() {
  self cameraunlink();
  self freezecontrols(0);
  self playershow();
  _id_1255B();
}

_id_143F8(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1 && level.disable_super_in_turret._id_13916 < level.players.size)
    waitframe();
}

dyn_door(var_0) {
  return 1;
}

playerrespawn(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || !istrue(self.br_infilstarted))
    return 0;

  thread _id_126A4(var_0);
  return 1;
}

_id_126A4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_8201151FD310A9EF20E12D4531630B3F6BD96FAA990A3C");

  if(!istrue(level.debug_safehouse_regroup_start))
    self.class = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1234A();

  var_1 = level.teamdata[self.team]["_encstr_A78C0CCD950FA39456DC0E16DDE6"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

  if(var_2 > 1)
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, undefined, 1);

  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);

  while(!isalive(self))
    waitframe();

  waitframe();

  if(getdvarint("_encstr_B8AB224F278BAFA0CA694B614ABF70CF12CFFD8FC7135D70F37C5659B67D50059AEF7F5F", 0) == 1 && _id_1257D() == "_encstr_AA7B09475984AF0F6F0F0B")
    _id_12613();

  _id_1255B();
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
}

_id_1255B() {
  if(getdvarint("_encstr_BD6D167B21762FCEC8DF1C159D79951F1E3B31E36B47B307", 0) != 0)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(1);
  var_0 = getdvarint("_encstr_95A3166FB8EBF78A5518A39FF667D384D198CB5730E00D82", 1);

  if(var_0 == -2) {
    foreach(var_2 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_2)) {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
        self givemaxammo(var_2);
      }
    }

    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
  } else if(var_0 == -1)
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  else if(var_0 > 0) {
    foreach(var_6 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_6)) {
        var_3 = weaponclipsize(var_6);
        self setweaponammoclip(var_6, var_3);
        var_2 = asmdevgetallstates(var_6);
        var_7 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_2);

        if(isDefined(var_7))
          _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, var_7, var_3 * var_0);
      }
    }

    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
  }

  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
}

_id_12613() {
  self skydive_interrupt();
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self.br_contractxpearned = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.br_contractxpearned setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.br_contractxpearned unmarkkeyframedmover(1);
  self playerlinkTo(self.br_contractxpearned);
  self playerlinkedoffsetenable();
  allowvipdamage();
  self.br_contractxpearned delete();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
}

allowvipdamage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1;
  var_0 = self.origin;
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.owner = self;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.cannotbesuspended = 1;
  var_1.modelname = "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E";
  var_1.vehicletype = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";
  var_2 = spawnStruct();
  var_3 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_1, var_2);

  if(isDefined(var_3)) {
    wait 2;

    while(!isDefined(var_3.vehiclename)) {
      var_3 endon("_encstr_AD75063D571AE108");
      waitframe();
    }

    self unlink();
    var_4 = "_encstr_A266062032BD7723";
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_3, var_4, self);
  }
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

  foreach(var_6 in level.players)
  var_6 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 1);

  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    var_8 = runkilltriger(self.team, var_1);
    var_9 = var_8 > 0;
    var_10 = undefined;
    var_11 = max(var_8 - var_4, 0);

    if(var_9) {
      var_10 = ai_spawn_intel_extras(var_8);
      var_12 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

      if(var_12 == 1) {
        self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", self getentitynumber());
        _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
        _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(self.origin + (0, 0, 100), self.angles);
        scripts\mp\spectating::setdisabled();
        scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_10));
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_10));
      var_13 = _id_12669(var_10);

      if(isDefined(var_13) && var_13 == "_encstr_BDBA103756B156C6477D8C59CCAC37232B4E")
        _id_12561("_encstr_8E460991ACCC59378C56C9");
      else if(isDefined(var_13) && var_13 == "_encstr_966A10B3878CC856AB8F3BE9DB02AE705DDA")
        _id_12561("_encstr_AA7B09475984AF0F6F0F0B");
    }

    self._id_1286F = _id_1257C();

    if(isDefined(self._id_1286F))
      self._id_1286F.index = -1;

    var_14 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B8(self._id_1286F.origin, self._id_1286F.height);
    var_15 = getdvarint("_encstr_A98E20C8132B69065B488CA6C807FF0FC5772273063B6A6F107F0D17D7C8643F02E3", 9000);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_14, var_15, 1, 0, var_10);

    if(var_9) {
      var_16 = 1.0;
      var_17 = 0.25;
      var_18 = var_16 - var_17;
      thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::fadeoutin(var_16);
      wait(var_18);
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_14, self._id_1286F.angles);
      scripts\mp\spectating::setdisabled();
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_14[0], var_14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
      wait(var_17);
      var_19 = max(var_8 - var_11 - var_16, 0);
      wait(var_19);
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
      self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
    } else {
      var_20 = 0.5;
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in(var_14[0], var_14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 4);
      wait(var_20);
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_14, self._id_1286F.angles);
      scripts\mp\spectating::setdisabled();
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
    }
  } else {
    self.thrust_fx_model = undefined;
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

ai_spawn_intel_extras(var_0) {
  if(getdvarint("_encstr_85F41F2646BB27D9E2F72050BB37F18D52AE11A5D1832303DDDF1858973009E70A", 1) != 0)
    return var_0 * 1000;
  else
    return level.deletetimedrunhud._id_12CA1 * 1000;
}

_id_12669(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(getdvarint("_encstr_AA8E1F8EEE138F615A5FB838C35F5935CA56891D49ABB30B20BF98788FABD07383", 0) == 1) {
    self._id_14391 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
    self._id_14391 scripts\mp\hud_util::setpoint("_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", 0, 50);
    self._id_14391.label = &"_encstr_923E0FF522B9C9C52BAE1FE5717B8F9985";
    var_1 = gettime() + var_0;
    var_2 = gettime();

    while(gettime() < var_1) {
      var_3 = 1000;
      var_4 = gettime() - var_2;

      if(self useButtonPressed() && var_4 > var_3) {
        self._id_14391 destroy();
        return "_encstr_BDBA103756B156C6477D8C59CCAC37232B4E";
      }

      waitframe();
    }

    if(getdvarint("_encstr_B1851A5780D3FF824DAFABE7FE6FAB89D8A06FF348AE392B6927761C", 0) == 1) {
      self._id_14391 destroy();
      return "_encstr_966A10B3878CC856AB8F3BE9DB02AE705DDA";
    }

    self._id_14391 destroy();
  } else
    wait(var_0 / 1000);

  return "_encstr_995408F398012F656821";
}

_id_1257C(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = self.team;
  var_2 = _id_1257D();
  var_3 = [];

  if(var_2 != "_encstr_A29B05E9400E5D") {
    foreach(var_5 in level.deletetimedrunhud.types["_encstr_AC6E09881A36337B5F6F30"]) {
      var_6 = var_2 == "_encstr_8E460991ACCC59378C56C9" && var_5.team == self.team || var_2 == "_encstr_AA7B09475984AF0F6F0F0B" && var_5.team != self.team;

      if(var_6 && var_5.state == "_encstr_AF5A081BBAC993AC73A3")
        var_3[var_3.size] = var_5;
    }
  }

  if(!var_3.size) {
    foreach(var_9 in level.deletetimedrunhud.types["_encstr_A29B05E9400E5D"]) {
      if(var_9.team == self.team)
        var_3[var_3.size] = var_9;
    }
  }

  var_5 = undefined;
  var_11 = undefined;

  if(usestartspawns()) {
    var_9 = _id_12565();

    if(isDefined(var_9.targets["_encstr_9B010C0F7720CF6DDFEB33E7C57C"])) {
      var_11 = "_encstr_9B010C0F7720CF6DDFEB33E7C57C";
      var_5 = var_9;
    }

    if(_id_13875()) {
      if(isDefined(var_5.targets["_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3"]))
        var_11 = "_encstr_AF37121733E24C885FDA8339825CC9078ADFB5B3";
      else
        var_11 = "_encstr_92A20CBBD35774B811B06173C6C7";
    }
  }

  if(!isDefined(var_11)) {
    if(var_2 == "_encstr_AA7B09475984AF0F6F0F0B")
      var_11 = "_encstr_B4230A5718B1D742171FABA3";
    else
      var_11 = "_encstr_AC230AABDAA970F8214B2B25";

    if(canspawnVehicle() && getdvarint("_encstr_B8AB224F278BAFA0CA694B614ABF70CF12CFFD8FC7135D70F37C5659B67D50059AEF7F5F", 0) == 1 && var_2 == "_encstr_AA7B09475984AF0F6F0F0B")
      var_11 = "_encstr_92A20CBBD35774B811B06173C6C7";

    if(isDefined(self._id_1366E)) {
      foreach(var_13 in var_3) {
        if(self._id_1366E == var_13) {
          var_5 = var_13;
          break;
        }
      }
    }

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(var_3);
      self._id_1366E = var_5;
    }
  }

  var_15 = var_5.targets[var_11][var_5._id_11E85[var_11]];

  if(!var_0) {
    var_5._id_11E85[var_11]++;

    if(var_5._id_11E85[var_11] >= var_5.targets[var_11].size)
      var_5._id_11E85[var_11] = 0;
  }

  var_15.height = 0;
  return var_15;
}

_id_1452D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"] = 0;

  if(level.deletetimedrunhud._id_12CA1 == 0) {
    return;
  }
  for(;;) {
    level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"] = gettime() + level.deletetimedrunhud._id_12CA1 * 1000;
    wait(level.deletetimedrunhud._id_12CA1);
  }
}

runkilltriger(var_0, var_1) {
  if(level.deletetimedrunhud._id_12CA1 == 0)
    return 0;

  if(!isDefined(var_1))
    var_1 = level.teamdata[var_0]["_encstr_A78C0CCD950FA39456DC0E16DDE6"];

  var_2 = max(var_1 - gettime(), 0);
  var_3 = int(var_2 / 1000);
  return var_3;
}

_id_1266E(var_0) {
  _id_1268B("_encstr_AA7B09475984AF0F6F0F0B", var_0);
}

_id_12678(var_0) {
  _id_1268B("_encstr_8E460991ACCC59378C56C9", var_0);
}

_id_12561(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.deletetimedrunhud.types["_encstr_AC6E09881A36337B5F6F30"]) {
    if(var_3.state == "_encstr_AF5A081BBAC993AC73A3" && var_3.team == self.team) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1))
    _id_1268B(var_0, var_1);
  else {
    var_5 = _id_12565();
    _id_1268B(var_0, var_5);
  }
}

_id_1268B(var_0, var_1) {
  self._id_136A6 = gettime();
  self.spawntype = var_0;
  self._id_1366E = var_1;
}

_id_1257D() {
  if(!isDefined(self.spawntype))
    return "_encstr_A29B05E9400E5D";

  return self.spawntype;
}

_id_1198A(var_0, var_1, var_2, var_3) {
  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, var_1);
  _func_042C(self.objidnum, var_2);
  objective_setshowprogress(self.objidnum, var_3);
}

_id_11984() {
  self notify("_encstr_852B0E3A429B6D7A24504C9791730F8C");
  self endon("_encstr_852B0E3A429B6D7A24504C9791730F8C");
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
  wait 0.1;
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
  wait 0.5;
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
}

_id_11991() {
  if(level.deletetimedrunhud.spawnaccesscards._id_14291 == 1)
    _id_11994("_encstr_A3C505966CBDE6", (1, 0.760784, 0.0823529), 1.0);
  else
    _id_11994("_encstr_AABF093042CE93D01F0ADC", (1, 0.760784, 0.0823529), 1.0);
}

_id_11992() {
  thread _id_11995("_encstr_B61904310B39", (1, 0.341176, 0.341176));
  thread _id_11984();
}

_id_11995(var_0, var_1) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_3 in level.deletetimedrunhud.teams) {
      var_4 = self.spawnanglemax.monitor_hack_prox[var_3][var_0];

      if(isDefined(var_4))
        var_4 thread spawn_wheelson_blinking_lights(var_1);
    }
  }
}

_id_11994(var_0, var_1, var_2) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_4 in level.deletetimedrunhud.teams) {
      var_5 = self.spawnanglemax.monitor_hack_prox[var_4][var_0];

      if(isDefined(var_5))
        var_5 thread spawn_weapon_box_cache(var_1, var_2);
    }
  }
}

_id_11990(var_0) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_2 in level.deletetimedrunhud.teams) {
      foreach(var_4 in self.spawnanglemax.monitor_hack_prox[var_2]) {
        if(!isDefined(var_4)) {
          continue;
        }
        var_4.alpha = var_0;
      }
    }
  }
}

_id_11993() {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_1 in level.deletetimedrunhud.teams) {
      foreach(var_4, var_3 in self.spawnanglemax.monitor_hack_prox[var_1]) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(var_4 == "_encstr_AABF093042CE93D01F0ADC") {
          if(var_1 == self.team) {
            var_3 spawn_weapons_by_player_count();
            var_3 spawndistancemin((1, 0.341176, 0.341176));
          } else {
            var_3 spawn_weapons_by_player_count();
            var_3 spawndistancemin((0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var_4 == "_encstr_8DEC06B1E9032149") {
          if(var_1 == self.team) {
            var_3 spawn_weapons_by_player_count();
            var_3 spawndistancemin((1, 0.341176, 0.341176));
          } else {
            var_3 spawn_weapons_by_player_count();
            var_3 spawndistancemin((0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var_4 == "_encstr_A3C505966CBDE6") {
          if(var_1 == self.team) {
            var_3 setshader("_encstr_928017BD732E676667C05982082F9BEF23F023259EB3C3AF29", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards._id_14291 == 1) {
              var_3 spawn_weapons_by_player_count();
              var_3 spawndistancemin((1, 0.341176, 0.341176));
            }
          } else {
            var_3 setshader("_encstr_87E51457D2FAA5D8B7DCBEC4E4F51D2BC9BE63BDE6D1", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards._id_14291 == 1) {
              var_3 spawn_weapons_by_player_count();
              var_3 spawndistancemin((0.337255, 0.690196, 0.929412));
            }
          }

          continue;
        }

        if(var_4 == "_encstr_B61904310B39") {
          var_3.alpha = 0;
          continue;
        }

        if(var_4 == "_encstr_A28E061BDE5DB9D1")
          var_3 destroy();
      }
    }
  }
}

allow_deleteme_on_path(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(istrue(var_3._id_12C46))
      var_1++;
  }

  return var_1;
}

_id_11996() {
  var_0 = isDefined(self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]);
  var_1 = isDefined(self.targets["_encstr_AA15062C769537A3"]);
  var_2 = 0;
  var_3 = 0;

  if(var_0)
    var_3 = var_3 + allow_deleteme_on_path(self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]);

  if(var_1)
    var_3 = var_3 + allow_deleteme_on_path(self.targets["_encstr_AA15062C769537A3"]);

  if(var_0) {
    foreach(var_5 in self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]) {
      if(var_5.state == "_encstr_83320ADDB7DB01AB8F3FF8E8" && istrue(var_5._id_12C46))
        var_2++;
    }
  }

  if(var_1) {
    foreach(var_8 in self.targets["_encstr_AA15062C769537A3"]) {
      if(var_8.state == "_encstr_83320ADDB7DB01AB8F3FF8E8" && istrue(var_8._id_12C46))
        var_2++;
    }
  }

  var_10 = var_2 / var_3;
  objective_setprogress(self.objidnum, var_10);

  if(isDefined(self.spawnanglemax)) {
    foreach(var_12 in level.deletetimedrunhud.teams) {
      var_13 = self.spawnanglemax.monitor_hack_prox[var_12]["_encstr_B61904310B39"];

      if(isDefined(var_13))
        var_13 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", int((1.0 - var_10) * level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand), 15);

      var_14 = self.spawnanglemax.monitor_hack_prox[var_12]["_encstr_A28E061BDE5DB9D1"];

      if(isDefined(var_14))
        var_14 setvalue(var_3 - var_2);
    }
  }
}

_id_11989(var_0) {
  foreach(var_2 in self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]) {
    if(var_0) {
      if(var_2.state == "_encstr_AB250AF04690AB2FB7C8321A")
        var_2 is_relic_collat_dmg_active("_encstr_913B0AB8E07B49D512772799");

      continue;
    }

    var_2 is_relic_collat_dmg_active("_encstr_AB250AF04690AB2FB7C8321A");
  }
}

_id_11999() {
  for(;;) {
    if(_id_11974()) {
      break;
    }

    self waittillmatch("_encstr_969E1436864BD823EB360D2C37762B467DB91DB08E56", "_encstr_83320ADDB7DB01AB8F3FF8E8");
  }
}

_id_11974() {
  if(!isDefined(self.targets["_encstr_8F1308474FDBA7D8DBB3"]))
    return 1;

  if(!self.targets["_encstr_8F1308474FDBA7D8DBB3"].size)
    return 1;

  foreach(var_1 in self.targets["_encstr_8F1308474FDBA7D8DBB3"]) {
    if(var_1.state == "_encstr_83320ADDB7DB01AB8F3FF8E8")
      return 1;
  }

  return 0;
}

_id_11998() {
  for(;;) {
    if(_id_11973()) {
      break;
    }

    self waittillmatch("_encstr_969E1436864BD823EB360D2C37762B467DB91DB08E56", "_encstr_83320ADDB7DB01AB8F3FF8E8");
  }
}

_id_11973() {
  if(!isDefined(self.targets["_encstr_8F1308474FDBA7D8DBB3"]))
    return 1;

  foreach(var_1 in self.targets["_encstr_8F1308474FDBA7D8DBB3"]) {
    if(var_1.state != "_encstr_83320ADDB7DB01AB8F3FF8E8")
      return 0;
  }

  return 1;
}

_id_11997() {
  for(;;) {
    _id_11996();

    if(_id_11972()) {
      break;
    }

    self waittill("_encstr_BE7B183701404952ADDB9BBBCB58DB94D84BEF71F9C011BAF4FB");
  }
}

_id_11972() {
  var_0 = isDefined(self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]);
  var_1 = isDefined(self.targets["_encstr_AA15062C769537A3"]);

  if(!var_0 && !var_1)
    return 1;

  if(var_0) {
    foreach(var_3 in self.targets["_encstr_A3DB0B46B0ADC2CE56C24C8D56"]) {
      if(var_3.state != "_encstr_83320ADDB7DB01AB8F3FF8E8")
        return 0;
    }
  }

  if(var_1) {
    foreach(var_6 in self.targets["_encstr_AA15062C769537A3"]) {
      if(var_6.state != "_encstr_83320ADDB7DB01AB8F3FF8E8")
        return 0;
    }
  }

  return 1;
}

_id_11971(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }
  foreach(var_2 in self.targets[var_0])
  var_2 thread _id_14229();
}

_id_14229() {
  if(self.state == "_encstr_A9090A79DFB844FB97A3627A") {
    return;
  }
  self.state = "_encstr_A9090A79DFB844FB97A3627A";
  self notify("_encstr_A9090A79DFB844FB97A3627A");
  scripts\mp\flags::gameflagwait("_encstr_B14F123B23DE1196F0D8941E3098F7ABB743AFDB");
  _id_1435D();

  if(!canspawnVehicle()) {
    return;
  }
  thread _id_14269();
}

_id_14269() {
  self endon("_encstr_A26D0C5F2B6FC1E84F836FF94539");
  var_0 = spawnStruct();

  for(;;) {
    var_1 = _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::tryspawnavehicle(self.name, self, "_encstr_911A0B4402F3E9AAB3B88FA23B", var_0);

    if(!isDefined(var_1)) {
      return;
    }
    self.ent = var_1;
    self.ent._id_13A85 = self;

    if(level.deletetimedrunhud._id_1420A < 0) {
      return;
    }
    var_1 waittill("_encstr_AD75063D571AE108");
    wait(level.deletetimedrunhud._id_1420A);
  }
}

_id_11970(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }
  foreach(var_2 in self.targets[var_0])
  var_2 thread _id_1422A();
}

_id_1422A() {
  _id_14229();
  _id_1423D();
}

_id_11979(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }
  foreach(var_2 in self.targets[var_0])
  var_2 thread _id_1423D();
}

_id_1423D() {
  if(self.state == "_encstr_A26D0C5F2B6FC1E84F836FF94539") {
    return;
  }
  self.state = "_encstr_A26D0C5F2B6FC1E84F836FF94539";
  self notify("_encstr_A26D0C5F2B6FC1E84F836FF94539");
}

_id_1196F(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }
  foreach(var_2 in self.targets[var_0])
  var_2 thread binoculars_used();
}

binoculars_used() {
  if(self.state == "_encstr_930B07BB1B6B3854FF") {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BAC4107BE7F88EC67227206BD982C252800E");
  _id_1435D();
  thread birds_in_square_monitor();
}

birds_in_square_monitor() {
  self endon("_encstr_83320ADDB7DB01AB8F3FF8E8");
  var_0 = spawnStruct();

  for(;;) {
    var_1 = brc130airdropcratecapturecallback(self.origin, self.angles, self.team);

    if(!isDefined(var_1)) {
      waitframe();
      continue;
    }

    self.ent = var_1;
    self.ent._id_13A85 = self;
    is_relic_collat_dmg_active("_encstr_930B07BB1B6B3854FF");
    var_1 waittill("_encstr_AD75063D571AE108", var_2);
    binoculars_watchracedeath(var_2);
    is_relic_collat_dmg_active("_encstr_83320ADDB7DB01AB8F3FF8E8");
    return;
  }
}

_id_11978(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }
  foreach(var_2 in self.targets[var_0])
  var_2 thread binoculars_watchraceadson();
}

binoculars_watchraceadson() {
  if(self.state == "_encstr_83320ADDB7DB01AB8F3FF8E8") {
    return;
  }
  self.ent bot_custom_classes_allowed();
  is_relic_collat_dmg_active("_encstr_83320ADDB7DB01AB8F3FF8E8");
}

_id_1197A() {
  var_0 = self.name;

  if(!isDefined(level.deletetimedrunhud._id_1196C[self.name]))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  return level.deletetimedrunhud._id_1196C[var_0];
}

_id_1197F() {
  return _id_1197B("_encstr_823109E62B1BAB27D2B93B");
}

_id_1197E() {
  return _id_1197B("_encstr_AAE70838F27E43E327DC");
}

_id_1197C() {
  return _id_1197B("_encstr_8267076C10DBE8B6E0");
}

_id_1197D() {
  return _id_1197B("_encstr_86AD05B1F6B9A3");
}

_id_1197B(var_0) {
  var_1 = _id_1197A();
  return var_0 + var_1._id_14308;
}

_id_12565() {
  foreach(var_1 in level.deletetimedrunhud.types["_encstr_A29B05E9400E5D"]) {
    if(var_1.team == self.team)
      return var_1;
  }

  return undefined;
}

_id_125B7(var_0) {
  var_1 = spawnStruct();
  var_1._id_133E4 = 1;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(self.plundercount + var_0, var_1);
}

respawn_flare_used(var_0) {
  if(var_0 == "_encstr_9A8507BA4040188D08")
    return "_encstr_8E8405EA382B2A";
  else
    return "_encstr_9A8507BA4040188D08";
}

request_crate_drop(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("_encstr_993E0FDA20CB9DCF164096B7ED794FA361", var_0);
}

safecheckweapon(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("_encstr_879B0C97EF6A47F8E6591BB2BAD5", var_0);
}

runpain(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("_encstr_BA4B12F74B889A37B87EAA62810E0F19A82B956D", var_0);
}

runlogicbasedoncircuitbreaker(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("_encstr_853311E8C7314397A2E9069FFA4AAFC8995FF0", var_0);
}

relic_nobulletdamage_modifyplayerdamage(var_0, var_1) {
  if(!isDefined(var_1))
    return 1.0;

  var_1 = tolower(var_1);
  var_2 = level.deletetimedrunhud.is_position_open[var_0][var_1];

  if(!isDefined(var_2)) {
    var_3 = level.deletetimedrunhud.is_raid_gamemode[var_0][var_1];

    if(!isDefined(var_3))
      var_3 = 1.0;

    var_2 = getdvarfloat("_encstr_967815CD369CBE4C27D7192CD658D9ACEB9B6C16C6957D" + var_0 + "_encstr_BA4C02DF" + var_1, var_3);
    level.deletetimedrunhud.is_position_open[var_0][var_1] = var_2;
  }

  return var_2;
}

dmzwincost(var_0) {
  foreach(var_2 in level.deletetimedrunhud.teams)
  dmztutendgame(var_0, var_2);
}

dmztutendgame(var_0, var_1) {
  if(unfreezeplayercontrols(var_0, var_1)) {
    return;
  }
  level thread scripts\mp\utility\dialog::leaderdialog(var_0, var_1);
  _id_13287(var_0, var_1);
}

unfreezeplayercontrols(var_0, var_1) {
  var_2 = rungwperif_tracers(var_0);

  if(!isDefined(var_2) || var_2 == 0)
    return 0;

  var_3 = rungwperifeffets(var_0, var_1);

  if(!isDefined(var_3))
    return 0;

  return gettime() < var_3 + var_2;
}

_id_13287(var_0, var_1) {
  if(isDefined(var_1))
    level.deletetimedrunhud.vo._id_13B7D[var_1][var_0] = gettime();
  else {
    foreach(var_1 in level.deletetimedrunhud.teams)
    _id_13287(var_0, var_1);
  }
}

rungwperifeffets(var_0, var_1) {
  if(isDefined(var_1))
    return level.deletetimedrunhud.vo._id_13B7D[var_1][var_0];
  else {
    var_2 = undefined;

    foreach(var_1 in level.deletetimedrunhud.teams) {
      var_4 = rungwperifeffets(var_0, var_1);

      if(isDefined(var_2)) {
        if(isDefined(var_4) && var_4 < var_2)
          var_2 = var_4;

        continue;
      }

      var_2 = var_4;
    }
  }
}

_id_13286(var_0, var_1) {
  var_2 = getdvarint("_encstr_B66A1C6E6CC9AF4C27F5A356C9BE234B161BDE76F5C8AC26B7EA736C59BE" + var_0, var_1);
  level.deletetimedrunhud.vo._id_13B72[var_0] = var_2;
}

rungwperif_tracers(var_0) {
  if(!isDefined(level.deletetimedrunhud.vo._id_13B72[var_0]))
    _id_13286(var_0, 0);

  return level.deletetimedrunhud.vo._id_13B72[var_0];
}

_id_1435D() {
  while(level.deletetimedrunhud.waittillplayerlanded == gettime())
    waitframe();

  level.deletetimedrunhud.waittillplayerlanded = gettime();
}

usestartspawns() {
  return !scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3");
}

is_module_active(var_0) {
  var_1 = self._id_13A85;

  if(isDefined(var_0.attacker)) {
    if(istrue(var_1._id_12C46)) {
      var_0.attacker thread scripts\mp\rank::scoreeventpopup("_encstr_8B06154CC9EBE82B4E7D7B13A6F5232BB947C9BDCBAC91");
      scripts\mp\utility\sound::playsoundonplayers("_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559", respawn_flare_used(var_1.team));
      scripts\mp\utility\sound::playsoundonplayers("_encstr_8C321BB60EBE98DB46BC8DB7EACD3AD73AB4C65BEBCD59D9B0D196B3CA", var_1.team);
      var_0.attacker _id_125B7(level.deletetimedrunhud.is_greater_than_equal_to);
    }

    var_1 is_moving_platform_train(var_0);
  }

  var_1 is_relic_collat_dmg_active("_encstr_83320ADDB7DB01AB8F3FF8E8");
}

is_moving_platform_train(var_0) {
  if(level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone > 0) {
    var_1 = level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone;

    if(level.deletetimedrunhud.is_inflictor_a_carepackage > var_1)
      var_1 = randomintrange(var_1, level.deletetimedrunhud.is_inflictor_a_carepackage);

    var_2 = [];

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_in_gas; var_3++)
      var_2[var_2.size] = scripts\engine\utility::random(level.deletetimedrunhud.is_killstreak_valid_for_swat);

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_hostage_oob; var_3++)
      var_2[var_2.size] = scripts\engine\utility::random(level.deletetimedrunhud.is_kidnapping_player);

    var_4 = 0;

    if(level.deletetimedrunhud.is_helicopter_player_occupied && isDefined(var_0.objweapon)) {
      var_5 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_0.objweapon);

      if(isDefined(var_5)) {
        var_2[var_2.size] = var_5;
        var_4 = 1;
      }
    }

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_helicopter_player_occupied - var_4; var_3++)
      var_2[var_2.size] = scripts\engine\utility::random(level.deletetimedrunhud.is_instant_use_munition);

    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_6 = min(var_1, var_2.size);
    var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_8 = level.deletetimedrunhud.is_goal_crowded[self.name];

    for(var_3 = 0; var_3 < var_6; var_3++) {
      var_9 = var_2[var_3];
      var_10 = self.origin + rotatevector(var_8._id_11A3F, self.angles);
      var_11 = self.angles + (0, var_8._id_11A49, 0);
      _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_9, var_7, var_10, var_11, 1, 0);
    }
  }
}

is_on(var_0) {
  var_1 = var_0.damage;
  var_2 = self._id_13A85;
  var_3 = getdvarint("_encstr_8EBC2137D84EF58927FA3AB29CAF16B1C6F6EEF5CC39A595B99163F27D460BAD2C76CA", 0);

  if(isDefined(var_0.attacker) && var_2.team == var_0.attacker.team && !var_3)
    var_1 = 0;
  else if(getdvarint("_encstr_9BC219FB36CBFFE69D892B32C8EF9D8381B063685853B76C73E8B2", 0))
    var_1 = 99999;
  else if(isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(var_0.inflictor vehicle_getspeed() < level.deletetimedrunhud.is_so_stars_enabled)
      var_1 = 0;
    else if(isDefined(var_2._id_11E89) && gettime() < var_2._id_11E89)
      var_1 = 0;
    else {
      var_1 = level.deletetimedrunhud.is_same_combat_action;
      var_2._id_11E89 = gettime() + level.deletetimedrunhud.is_scriptable_healthy;
    }
  } else {
    var_1 = var_1 * request_crate_drop(var_0.meansofdeath);

    if(isDefined(var_0.objweapon)) {
      var_1 = var_1 * safecheckweapon(var_0.objweapon.type);
      var_1 = var_1 * runpain(var_0.objweapon.classname);
      var_1 = var_1 * runlogicbasedoncircuitbreaker(var_0.objweapon.basename);
    }

    var_1 = int(ceil(var_1));
  }

  if(var_1 > 0 && istrue(var_2._id_12C46)) {
    if(isDefined(var_0.attacker))
      var_0.attacker _id_1266E(var_2._id_13A82[0]);

    var_2 is_relic_collat_dmg_active("_encstr_93C508AF0763AAA769E8");
    var_4 = var_2 is_object_allowed_in_gametype();
    dmztutendgame(var_4 _id_1197F(), respawn_flare_used(var_4.team));
    dmztutendgame(var_4 _id_1197C(), var_4.team);
    var_4 _id_11991();
  }

  return var_1;
}

binoculars_watchracedeath(var_0) {
  var_1 = self.ent;

  if(isDefined(var_0) && istrue(var_1._id_12C46)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_8B06154CC9EBE82B4E7D7B13A6F5232BB947C9BDCBAC91");
    scripts\mp\utility\sound::playsoundonplayers("_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559", respawn_flare_used(self.team));
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8C321BB60EBE98DB46BC8DB7EACD3AD73AB4C65BEBCD59D9B0D196B3CA", var_1.team);
    var_0 _id_125B7(level.deletetimedrunhud.is_greater_than_equal_to);
  }

  is_relic_collat_dmg_active("_encstr_83320ADDB7DB01AB8F3FF8E8");
}

binoculars_watchraceadsoff(var_0, var_1) {
  var_2 = self.ent;
  var_3 = var_0;

  if(var_3 > 0 && istrue(var_2._id_12C46)) {
    if(isDefined(var_1))
      var_1 _id_1266E(self._id_13A82[0]);

    is_relic_collat_dmg_active("_encstr_93C508AF0763AAA769E8");
    var_4 = is_object_allowed_in_gametype();
    dmztutendgame(var_4 _id_1197F(), respawn_flare_used(var_4.team));
    dmztutendgame(var_4 _id_1197C(), var_4.team);
    var_4 _id_11991();
  }
}

arenaloadouts_getoverrideweaponswithgroup(var_0, var_1) {
  var_2 = self.ent;
  var_3 = var_0;

  if(var_3 > 0 && istrue(var_2._id_12C46)) {
    if(isDefined(var_1))
      var_1 _id_1266E(self._id_13A82[0]);

    is_relic_collat_dmg_active("_encstr_93C508AF0763AAA769E8");
    var_4 = is_object_allowed_in_gametype();
    dmztutendgame(var_4 _id_1197F(), respawn_flare_used(var_4.team));
    dmztutendgame(var_4 _id_1197C(), var_4.team);
    var_4 _id_11991();
  }
}

is_one_player_near_point2d() {
  if(self.is_minimap_forcedisabled == "_encstr_96010BDCD8392D073A164C1B2B")
    thread is_playing_vo();
  else if(self.is_minimap_forcedisabled == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
    thread is_point_in_cylinder();
  else if(self.is_minimap_forcedisabled == "_encstr_84980B1A7547721727CFA2F06D")
    thread is_operations_gametype();
  else if(self.is_minimap_forcedisabled == "_encstr_87680AB085AF1DBA93C92B1D")
    thread is_opened();
}

is_playing_vo() {
  self endon("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
  self.ent setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A7A90CEAE6E09CF61DACB1D1AC32");

  while(self.ent getscriptablepartstate("_encstr_A29B05E9400E5D") != "_encstr_83320ADDB7DB01AB8F3FF8E8")
    waitframe();

  is_relic_collat_dmg_active("_encstr_83320ADDB7DB01AB8F3FF8E8");
}

is_point_in_cylinder() {
  var_0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.ent scripts\mp\damage::monitordamage(var_0.health, "_encstr_A2FB098A2035874AB0F358", ::is_module_active, ::is_on);
}

is_operations_gametype() {
  self endon("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
  self.ent endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.ent waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);
    binoculars_watchraceadsoff(var_0, var_1);
  }
}

is_opened() {
  self endon("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
  self.ent endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.ent waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);
    arenaloadouts_getoverrideweaponswithgroup(var_0, var_1);
  }
}

is_player_damage_disabled() {
  if(self.is_minimap_forcedisabled == "_encstr_96010BDCD8392D073A164C1B2B")
    thread is_player_part_exposed_to_chopper_boss();
  else if(self.is_minimap_forcedisabled == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
    thread is_player_valid_for_team_proximity();
  else if(self.is_minimap_forcedisabled == "_encstr_84980B1A7547721727CFA2F06D")
    thread is_player_in_focus_fire_attacker_list();
  else if(self.is_minimap_forcedisabled == "_encstr_87680AB085AF1DBA93C92B1D")
    thread is_player_in_aggro();
}

is_player_part_exposed_to_chopper_boss() {
  self.ent setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_AB250AF04690AB2FB7C8321A");
  self notify("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
}

is_player_valid_for_team_proximity() {
  self.ent scripts\mp\damage::monitordamageend();
}

is_player_in_focus_fire_attacker_list() {
  self.ent bot_custom_classes_allowed();
  self notify("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
}

is_player_in_aggro() {
  self notify("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
}

is_relic_collat_dmg_active(var_0) {
  if(var_0 == self.state) {
    return;
  }
  if(self.is_minimap_forcedisabled == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    switch (var_0) {
      case "_encstr_AB250AF04690AB2FB7C8321A":
        is_relic_active(var_0);
        is_player_damage_disabled();
        break;
      case "_encstr_913B0AB8E07B49D512772799":
        if(isDefined(self.ent.damagetaken))
          self.ent.damagetaken = 0;

        is_relic_active(var_0);
        self.ent setscriptablepartstate("_encstr_93F30F7D2D83A6990E8A685022264D1837", "_encstr_8B1608EC43B8D647A113");
        is_one_player_near_point2d();
        break;
      case "_encstr_93C508AF0763AAA769E8":
        is_relic_active(var_0);
        self.ent setscriptablepartstate("_encstr_93F30F7D2D83A6990E8A685022264D1837", "_encstr_93C508AF0763AAA769E8");
        var_1 = getdvarint("_encstr_B2C11E485FA2260DE3698D1D3A69530814D7E0B1AF46B9DB7B01861592628B73", 0);

        foreach(var_3 in level.players) {
          if(!level.deletetimedrunhud.brjugg_watchgasdamage) {
            self.ent disablescriptableplayeruse(var_3);
            continue;
          }

          if(var_1 || var_3.team == self.team) {
            self.ent enablescriptableplayeruse(var_3);
            continue;
          }

          self.ent disablescriptableplayeruse(var_3);
        }

        break;
      case "_encstr_83320ADDB7DB01AB8F3FF8E8":
        is_relic_active(var_0);
        var_5 = level.deletetimedrunhud.is_goal_crowded[self.name];
        self.ent setModel(var_5.modeldestroyed);
        self.ent setscriptablepartstate("_encstr_93F30F7D2D83A6990E8A685022264D1837", "_encstr_83320ADDB7DB01AB8F3FF8E8");
        is_player_damage_disabled();
        var_6 = is_object_allowed_in_gametype();
        var_6 _id_11992();
        break;
      default:
        break;
    }
  } else if(self.is_minimap_forcedisabled == "_encstr_84980B1A7547721727CFA2F06D" || self.is_minimap_forcedisabled == "_encstr_87680AB085AF1DBA93C92B1D") {
    switch (var_0) {
      case "_encstr_913B0AB8E07B49D512772799":
      case "_encstr_930B07BB1B6B3854FF":
        is_relic_active(var_0);
        is_one_player_near_point2d();
        break;
      case "_encstr_93C508AF0763AAA769E8":
        is_relic_active(var_0);
        break;
      case "_encstr_83320ADDB7DB01AB8F3FF8E8":
        is_relic_active(var_0);
        is_player_damage_disabled();
        var_6 = is_object_allowed_in_gametype();
        var_6 _id_11992();
        break;
      case "_encstr_AB250AF04690AB2FB7C8321A":
        is_relic_active(var_0);
        break;
      default:
        break;
    }
  }

  self.state = var_0;

  foreach(var_8 in self._id_13A82)
  var_8 notify("_encstr_BE7B183701404952ADDB9BBBCB58DB94D84BEF71F9C011BAF4FB", self);
}

is_riding_heli(var_0, var_1, var_2, var_3, var_4) {
  var_3 _id_12678(var_0.entity._id_13A85._id_13A82[0]);
  var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_96A1142627FAE82B4EF5ED4C35F59356C1B05A39AC46");
  var_3 playlocalsound("_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559");
  var_3 _id_125B7(level.deletetimedrunhud.is_main_pilot);
  var_0.entity._id_13A85 is_relic_collat_dmg_active("_encstr_913B0AB8E07B49D512772799");
}

is_relic_active(var_0) {
  var_1 = self;
  var_2 = self.team;
  var_3 = respawn_flare_used(self.team);

  if(!istrue(var_1._id_12C46)) {
    var_1.ent hudoutlinedisable();
    return;
  }

  var_4 = getdvarint("_encstr_AA162B6E36C9AF1393D7A35939F57B5DD1D8A53795AF8C56CDD1277BBC2B237DC859CD1D4ED58D4716311BCADC", 0);

  switch (var_0) {
    case "_encstr_913B0AB8E07B49D512772799":
    case "_encstr_930B07BB1B6B3854FF":
      var_1.ent spawnc130pathstructnewinternal(var_2, "_encstr_85BB179AC0817DC790E50F2C8D3BFB04AF30D372F81DB72BAA");
      var_1.ent spawnc130pathstructnewinternal(var_3, "_encstr_860614DF75E398434BBA0E51820B85F071FD55B30508");
      break;
    case "_encstr_93C508AF0763AAA769E8":
      var_1.ent spawnc130pathstructnewinternal(var_2, "_encstr_A5971FD0633420F3AAC7E7A9FF7345C8C73FFBE88F86D839B34799AB378A04F894");
      var_1.ent spawnc130pathstructnewinternal(var_3, "_encstr_85441CCF4BA3BD0F9819498261EF33F401C3764DE38089E33730A2BA49CD");
      break;
    case "_encstr_83320ADDB7DB01AB8F3FF8E8":
      if(var_4) {
        var_1.ent spawnc130pathstructnewinternal(var_2, "_encstr_912B2168C76480DBE2A758DDBFDB39C8E73308C0EF06D999BBC1CD5512F37D9019D723");
        var_1.ent spawnc130pathstructnewinternal(var_3, "_encstr_91391E686D3B44D1E2F7A999A70FEBA9C7171288F2770909493B383DFFD0CBB1");
      } else
        var_1.ent hudoutlinedisable();

      break;
    case "_encstr_AB250AF04690AB2FB7C8321A":
      var_1.ent hudoutlinedisable();
      break;
    default:
      break;
  }
}

is_object_allowed_in_gametype() {
  return self._id_13A82[0];
}

wait_for_garage_open() {
  _id_1435D();
  self.ent = easepower("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", self.origin, self.angles);
  self.ent._id_13A85 = self;
  level.br_armory_kiosk.scriptables[level.br_armory_kiosk.scriptables.size] = self.ent;
  self.ent setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_BE8B08E323FB2BCD6268");
  self.ent.visible = 1;
}

watchdangerresetaction() {
  level.deletetimedrunhud.spawnaccesscards = spawnStruct();
  level.deletetimedrunhud.spawnaccesscards._id_13BDE = getdvarint("_encstr_87FD1638923A17E17BE78B7DB4A76B2FE2F960185A92ABFB", 40);
  level.deletetimedrunhud.spawnaccesscards._id_14291 = getdvarint("_encstr_822A17B673DBFEDD82D188181B9181F3FB27BC25DA77E03F6D", 0);
  level.deletetimedrunhud.spawnaccesscards.watchcratetimeout = getdvarint("_encstr_99E7160E896AD972B21F2D5DBA192ACB528730C9D86F4363", 1);
  level.deletetimedrunhud.spawnaccesscards._id_13347 = getdvarint("_encstr_85431BD367307123965EFB92837843B3D8B76B40E7F089FF3033528B8B", 1);
  level.deletetimedrunhud.spawnaccesscards.enabled = getdvarint("_encstr_886E17E66CC9AF3193AFA359C9AF0DD5327D599B0B98B1B219", 1);

  if(!level.deletetimedrunhud.spawnaccesscards.enabled) {
    return;
  }
  level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand = 45;

  if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1)
    level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand * 2;

  level.deletetimedrunhud.spawnaccesscards.temp = spawnStruct();
  level.deletetimedrunhud.spawnaccesscards.temp._id_11B59 = [];
  level.deletetimedrunhud.spawnaccesscards.temp._id_11B55 = [];
  level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto = [];

  foreach(var_1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.spawnaccesscards.temp._id_11B59[var_1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp._id_11B55[var_1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[var_1] = [];
  }

  foreach(var_4 in self.targets["_encstr_A29B05E9400E5D"])
  var_4 _id_11986(0);

  foreach(var_4 in self.targets["_encstr_A29B05E9400E5D"])
  var_4 _id_11977();

  level.deletetimedrunhud.spawnaccesscards.temp = undefined;
}

_id_11986(var_0) {
  if(isDefined(self.spawnanglemax)) {
    return;
  }
  self.spawnanglemax = spawnStruct();
  self.spawnanglemax.temp = spawnStruct();

  if(isDefined(level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0]))
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0]++;
  else
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0] = 0;

  var_1 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0];
  level.deletetimedrunhud.spawnaccesscards.temp._id_11B55[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp._id_11B55[self.team], var_1);
  level.deletetimedrunhud.spawnaccesscards.temp._id_11B59[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp._id_11B59[self.team], var_0);
  self.spawnanglemax.temp.lasttimespawngroupcalled = var_0;
  self.spawnanglemax.temp.disable_ignore_if_near_player = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0];

  foreach(var_4, var_3 in self.targets["_encstr_8F1308474FDBA7D8DBB3"])
  var_3 _id_11986(var_0 + 1);
}

_id_11977() {
  if(isDefined(self.spawnanglemax.monitor_hack_prox)) {
    return;
  }
  var_0 = _id_1197A();
  self.spawnanglemax.monitor_hack_prox = [];

  foreach(var_2 in level.deletetimedrunhud.teams) {
    if(!isDefined(self.spawnanglemax.monitor_hack_prox[var_2]))
      self.spawnanglemax.monitor_hack_prox[var_2] = [];

    var_3 = level.deletetimedrunhud.spawnaccesscards.temp._id_11B59[self.team];
    var_4 = 5;
    var_5 = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand + var_4;
    var_5 = var_5 + (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * (var_3 - self.spawnanglemax.temp.lasttimespawngroupcalled);

    if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var_5 = var_5 - int((var_3 + 1) * (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * 0.5);
      var_6 = 2;
    } else
      var_6 = 4;

    var_7 = 7.5;
    var_7 = var_7 + level.deletetimedrunhud.spawnaccesscards._id_13BDE;
    var_7 = var_7 + (15 + var_6) * self.spawnanglemax.temp.disable_ignore_if_near_player;
    var_8 = level.deletetimedrunhud.spawnaccesscards.temp._id_11B55[self.team];
    var_9 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][self.spawnanglemax.temp.lasttimespawngroupcalled];

    if(var_8 > 0 && var_9 < var_8) {
      var_10 = var_6 + 15;
      var_10 = var_10 * ((var_8 - var_9) / var_8);
      var_7 = var_7 + var_10;
    }

    var_11 = var_5;

    if(level.deletetimedrunhud.spawnaccesscards._id_14291 != 1)
      var_11 = var_11 + 15;

    var_12 = var_7;

    if(self.team == var_2) {
      var_5 = var_5 * -1;
      var_11 = var_11 * -1;
      var_13 = "_encstr_A5AD0568058CE3";
    } else if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var_7 = var_7 + (15 + var_6) * (var_8 + 1);
      var_12 = var_12 + (15 + var_6) * (var_8 + 1);
      var_5 = var_5 * -1;
      var_11 = var_11 * -1;
      var_13 = "_encstr_A5AD0568058CE3";
    } else
      var_13 = "_encstr_8253061E6BDF6331";

    var_14 = var_2;
    var_15 = scripts\engine\utility::ter_op(self.team == var_2, (0.337255, 0.690196, 0.929412), (1, 0.341176, 0.341176));
    var_16 = scripts\engine\utility::ter_op(level.deletetimedrunhud.spawnaccesscards._id_14291 == 1, var_15, (1, 1, 1));
    var_17 = hudicon(var_14, var_0.hudicon, var_16);
    var_17 scripts\mp\hud_util::setpoint(var_13, "_encstr_AD7E0A3454C9512A928AF414", var_11, var_12);
    self.spawnanglemax.monitor_hack_prox[var_2]["_encstr_A3C505966CBDE6"] = var_17;

    if(level.deletetimedrunhud.spawnaccesscards._id_14291 != 1) {
      var_18 = spawnboardroom_gasmask(var_14, var_15);
      var_18 scripts\mp\hud_util::setpoint(var_13, "_encstr_AD7E0A3454C9512A928AF414", var_11, var_12);
      self.spawnanglemax.monitor_hack_prox[var_2]["_encstr_AABF093042CE93D01F0ADC"] = var_18;
    }

    var_19 = spawn_transition_camera(var_14);
    var_19 scripts\mp\hud_util::setpoint(var_13, "_encstr_AD7E0A3454C9512A928AF414", var_5, var_7);
    self.spawnanglemax.monitor_hack_prox[var_2]["_encstr_B61904310B39"] = var_19;
    thread _id_11976(var_2, var_14, var_13, var_11 + 15, var_12);
  }

  foreach(var_23, var_22 in self.targets["_encstr_8F1308474FDBA7D8DBB3"])
  var_22 _id_11977();

  self.spawnanglemax.temp = undefined;
}

_id_11976(var_0, var_1, var_2, var_3, var_4) {
  if(level.deletetimedrunhud.spawnaccesscards._id_13347 == 0) {
    return;
  }
  if(level.deletetimedrunhud.spawnaccesscards._id_13347 == 1)
    self waittill("_encstr_AF5A081BBAC993AC73A3");

  var_5 = spawn_tut_loot(var_1);
  var_5 scripts\mp\hud_util::setpoint(var_2, "_encstr_AD7E0A3454C9512A928AF414", var_3, var_4);
  self.spawnanglemax.monitor_hack_prox[var_0]["_encstr_A28E061BDE5DB9D1"] = var_5;
}

hudicon(var_0, var_1, var_2) {
  var_3 = newteamhudelem(var_0);
  var_3.archived = 0;
  var_3.elemtype = "_encstr_B40101";
  var_3.width = 15;
  var_3.height = 15;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3.sort = 0;
  var_3 spawndistancemin(var_2);
  var_3.alpha = 1.0;
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3 setshader(var_1, 15, 15);
  var_3.hidden = 0;
  return var_3;
}

spawnboardroom_auav(var_0, var_1) {
  var_2 = 15 / level.fontheight;
  var_3 = newteamhudelem(var_0);
  var_3.archived = 0;
  var_3.elemtype = "_encstr_9779056EEA2583";
  var_3.font = "_encstr_8B1608EC43B8D647A113";
  var_3.fontscale = var_2;
  var_3.basefontscale = var_2;
  var_3.sort = 0;
  var_3.width = 11;
  var_3.height = 15;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3.hidden = 0;
  var_3.label = var_1;
  var_3 spawndistancemin((1, 1, 1));
  return var_3;
}

spawnboardroom_gasmask(var_0, var_1) {
  var_2 = newteamhudelem(var_0);
  var_2.archived = 0;
  var_2.elemtype = "_encstr_B40101";
  var_2.width = 15;
  var_2.height = 15;
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.sort = -1;
  var_2 spawndistancemin(var_1);
  var_2.alpha = 1.0;
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", 15, 15);
  var_2.hidden = 0;
  return var_2;
}

spawn_transition_camera(var_0) {
  var_1 = newteamhudelem(var_0);
  var_1.archived = 0;
  var_1.elemtype = "_encstr_B40101";
  var_1.width = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand;
  var_1.height = 15;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  var_1.children = [];
  var_1.sort = -3;
  var_1 spawndistancemin((1, 1, 1));
  var_1.alpha = 1.0;
  var_1 scripts\mp\hud_util::setparent(level.uiparent);
  var_1 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand, 15);
  var_1.hidden = 0;
  return var_1;
}

spawn_tut_loot(var_0) {
  var_1 = 15 / level.fontheight;
  var_2 = newteamhudelem(var_0);
  var_2.archived = 0;
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = "_encstr_8B1608EC43B8D647A113";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.sort = 0;
  var_2.width = 15;
  var_2.height = 15;
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2 spawndistancemin((1, 1, 0));
  return var_2;
}

spawndistancemin(var_0) {
  self.color = var_0;
  self.juggernauts_spawned = var_0;
}

spawn_wheelson_blinking_lights(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_8BBA0A9D5EA3DEF52552D010");
  self endon("_encstr_8BBA0A9D5EA3DEF52552D010");
  self.color = var_0;
  wait 0.2;
  self.color = self.juggernauts_spawned;
}

spawn_weapon_box_cache(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8FAD0DC5B864B9A814F74A132F38CF");
  self.player_onspawn = var_0;

  if(isDefined(self.player_origin_inside_front_zone)) {
    var_2 = gettime() + var_1 * 1000;

    if(var_2 > self.player_origin_inside_front_zone)
      self.player_origin_inside_front_zone = var_2;

    return;
  } else
    self.player_origin_inside_front_zone = gettime() + var_1 * 1000;

  while(gettime() < self.player_origin_inside_front_zone) {
    self.color = self.player_onspawn;
    wait 0.1;
    self.color = self.juggernauts_spawned;
    wait 0.1;
  }

  spawn_weapons_by_player_count();
}

spawn_weapons_by_player_count() {
  self.color = self.juggernauts_spawned;
  self.player_onspawn = undefined;
  self.player_origin_inside_front_zone = undefined;
  self notify("_encstr_8FAD0DC5B864B9A814F74A132F38CF");
}

target_in_range_and_fov(var_0) {
  if(!isDefined(self.targets))
    self.targets = [];

  if(!isDefined(self.targets[var_0]))
    self.targets[var_0] = [];
}

hide_bomb_case_timer(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = var_0[2];
  return ((1 - var_2) * var_1 + var_2, (1 - var_3) * var_1 + var_3, (1 - var_4) * var_1 + var_4);
}

spawnc130pathstructnewinternal(var_0, var_1) {
  if(level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"].size)
    self hudoutlineenableforclients(level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"], var_1);
}

canspawnVehicle() {
  return level.vehiclecount < getdvarint("_encstr_B1391DBFD77BF0701AB9FBD11ACFF01733BF3D2B5392A64825810168C3D670", 120);
}

_id_13875() {
  return canspawnVehicle() && getdvarint("_encstr_8FFC1B775E7A49562607633A0297CB9C8F12BBC70BD2FFC06349E078D7", 0);
}