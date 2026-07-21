/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_so_highway\cp_so_highway.gsc
***************************************************/

main() {
  syringe_finish_stand();
  level._id_11B51 = 35;
  level.nightmap = 1;
  setdvarifuninitialized("_encstr_86E10F37B1C9AFEA6E2BEBE68BAB2CC89B", 1);
  setdvarifuninitialized("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  setdvarifuninitialized("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  setdvarifuninitialized("_encstr_8C1617C7CF3EF161B01E32BA73D8AC49197F4B17CF65DB4808", "_encstr_A34C02BB");
  setdvarifuninitialized("_encstr_9B580EE6B139F5DC5BBDAD95E8B2378E", "_encstr_934C0218");
  setdvarifuninitialized("_encstr_A301174F278BAFF0D167C8238E99114EB2B7C18FE7B25DE8FF", 0);
  setdvarifuninitialized("_encstr_8B730F5BEE4AC10CB2839793AB9ACDF0F4", 0);
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  _encstr_B1A3399B1B4E9638D1DCCBC68379B685C1B9F2D807D7B9F67D0D4BD90DBB58F2791BE0D7CDF6D7D0A5CE43BB16E5FA839356B10BD8A1CA5C9DCD8D::main();
  _encstr_8BFA38EB4938E770EC50763B93504063D8CE10AE9B9973B719C1E78FAA8363A81772A8A00589400133D22F2923790953AA4A1F72D2F17501B711::main();
  _encstr_A39033F79F728A200B9797E14938B8D250B85F276F291F3279EA7CA7ECEBA9D05FDF0711FB9F517BA418AB3C7E9F6145408E87F75A::main();
  scripts\vehicle\pindia::main("_encstr_B8D414D0EB63CBEFFDA31BD0AC3838B7E3A8B201A07E", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_8E7F26D7BF1383B8349183F944016849DAE77B572A29D5906DF628B66AF9D8F572879FAFC3129DE0");
  scripts\vehicle\pindia::main("_encstr_A5BA1A530D4BB841C2C1C41E096DCD01A3572BA8E29701F351AB0F20", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_9B2F265B966B8702F1E96B52B8233E6B6110D9D79396BBCAAB30A209601B350358E7677AC1F93F54");
  scripts\vehicle\pindia::main("_encstr_886A1A4877744B170DDF11F7220EF91171E9B20123F75F2B737BCAAD", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_8EBA2637D84E96C147FA3BB21AB436B156F52D7707AFD1C9D58D5BBEC196738C2D16BEB19C2B2CB5");
  scripts\vehicle\pindia::main("_encstr_87F518A84A0451CE9F59019024EBD1D76A12E080229E67A3977C", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_AFAD2472C138C1A3A5274B1F51C35A0C78AE6CFB12F984FB7D7737FF89FBD27CB0F16902D178");
  scripts\vehicle\pindia::main("_encstr_81F518BB632CB0D75D9419E7C155A2B9B03220588801C7A359B8", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_ADAD248703C2106F83B98B91B28FAE705FA73B37F061A3B6AF5220DE1BA7D0E8F4F1CFB95195");
  scripts\vehicle\techo::main("_encstr_8DEB19BCED2B8A2F4E0A10517225013E33954E3B4F4F0B93F6D2F8", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_9B0D25E6D8E4A51CD1AF67B2A14B363656EB5AEEC1D78E39AED8DAFAD12B6CD0DED74E5926ACD8");
  scripts\vehicle\techo::main("_encstr_953119ECCA1AE0D71B2DCEFA36DC32AF8ECAC686DBBE31B12CC6AD", "_encstr_A3A20E1D4ED51BB5FAB52DB95A6B1607", "_encstr_87FF2538923A7BA363E78475B87F8929A7F95090BF99893B5FC302609C9771E98D8180D0C22ECF");
  scripts\vehicle\mindia8::main("_encstr_BE3F2ADD5534EA88978A98E6125FD6198DA16561F1DEB2F0F733B1C8195B0780A43FA1F9618090AEBBDAA951", "_encstr_A7441001DAE2D308EB795F25317880A5FBD8", "_encstr_969F26373693D2838EF5CEAC34961BC695AF5ABB07F5AD4BE6C896C283F50ED885CBAC3939B48C56");
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 1.25);
  setDvar("_encstr_83920A488F414D730D6721C8", 4);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 2048);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);

  if(level.createfx_enabled) {
    return;
  }
  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_86CD1238A8B31A477018B7B5F4D5A3BD2A64C20A", ::initarmsraceanims);
  level.disable_hotjoin_via_ac130 = 1;
  level.loadoutsecondaryaddblueprintattachments = 1;
  level.hostdamagefactorlow = 0;
  level.map_interaction_func = _encstr_BEB83DF05AF2A37BABF3103EE81EAD7BDAE39AE803C1CFD02F68CB24D817C9F3D50AD881AB655F088F374324A917F69BEDE3F89022BE71E0BF56D6B087D739::register_interactions;
  level.custom_onspawnplayer_func = ::onplayerspawn;
  level.weapon_rank_event_table = "_encstr_AD92413F37D67A9840B31D16CBC2DDB2AF6FC6E7B9E8034FF1F8841FA02819CBA8E7C39F2728893078E1FC63B9A01F63557B4BE7F5CED2FE5BCEB72BD1307C2E3EB7CB";
  level.player_interaction_monitor = _encstr_BEB83DF05AF2A37BABF3103EE81EAD7BDAE39AE803C1CFD02F68CB24D817C9F3D50AD881AB655F088F374324A917F69BEDE3F89022BE71E0BF56D6B087D739::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = _encstr_BEB83DF05AF2A37BABF3103EE81EAD7BDAE39AE803C1CFD02F68CB24D817C9F3D50AD881AB655F088F374324A917F69BEDE3F89022BE71E0BF56D6B087D739::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = ::interaction_trigger_properties;
  level.mud_sfx = ::mud_sfx;

  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  if(!scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_init("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_init("_encstr_A2D20FE4880D52A426C867576878654BD3");

  level.eogscoreboard = ["_encstr_A19B0973B543C35FDDE063", "_encstr_8E8D0697EB01F243", "_encstr_96D30A3468575BA7C307A128", "_encstr_A9AB06297DDFD816", "_encstr_B642089B65A658E8F597"];
  scripts\cp\cp_compass::setupminimap("_encstr_BEE21AC218413BA698EF4F75E3A8E1CF77B65B8A66AB171F981F6959");
  scripts\engine\utility::flag_set("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_init("_encstr_97E9156FB843A22267EBBFF543BF3A79E8C9CF9B681BE0");
  scripts\engine\utility::flag_init("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D");
  scripts\engine\utility::flag_init("_encstr_8B96091B56589D59D7D8A7");
  support_box_delay_max_ammo_hint();
  thread syringe_inject();
  init_spawners();

  if(getdvarint("_encstr_A301174F278BAFF0D167C8238E99114EB2B7C18FE7B25DE8FF"))
    _id_1437B();
  else
    intro_main();

  jumped();
  _id_1216D();
}

syringe_finish_stand() {
  var_0 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::is_equal(var_2.target, "_encstr_8B8C06E68B0B6751")) {
      continue;
    }
    var_2.origin = var_2.origin - (0, 0, 160);
  }

  var_4 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = [(-4484, -4047, 1768), (2485, 6151, 1768)];

  foreach(var_8, var_7 in var_4)
  var_7.origin = var_5[var_8];

  var_9 = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_11 in var_9) {
    var_11.origin = var_11.origin - (0, 0, 256);

    if(var_11.origin == (-3344, -2720, 1232))
      var_11.origin = var_11.origin - (0, 256, 0);
  }

  var_13 = getEntArray();

  foreach(var_15 in var_13) {
    if(var_15.origin == (-1507.75, -1416.5, 1171.5)) {
      var_15.origin = (-1505.25, -1416.5, 1171.5);
      continue;
    }

    if(var_15.origin == (-1513.72, -1431.54, 1171.5)) {
      var_15.origin = (-1509.72, -1431.54, 1171.5);
      var_16 = _id_1249F(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-529.988, -1715.24, 1210.5)) {
      var_15.origin = (-529.988, -1716.24, 1210.5);
      var_16 = _id_1249F(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1468.21, -2578.1, 1071.24)) {
      var_16 = _id_1249D();
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1326.1, -2557.79, 1076.24)) {
      var_16 = _id_1249D();
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1193.79, -2573.9, 1077.24)) {
      var_16 = _id_1249D();
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1185.9, -2472.21, 1081.24)) {
      var_16 = _id_1249D();
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1318.54, -1412.28, 1171.5)) {
      var_16 = _id_1249F(2);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-625.5, -1745.5, 1210.5)) {
      var_16 = _id_1249F(2);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1507.75, -1416.5, 1171.5)) {
      var_16 = _id_1249F(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
      continue;
    }

    if(var_15.origin == (-1303.5, -1417.25, 1171.5)) {
      var_16 = _id_1249F(1);
      var_17 = createheadicon(var_16);
      var_18 = spawn("_encstr_B2010820C5337B67C8CF" + var_17, var_15.origin, 1);
      var_18.angles = var_15.angles;
      var_18 itemweaponsetammo(weaponclipsize(var_18), weaponmaxammo(var_18));
      var_15 delete();
    }
  }

  var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2442, -2077, 1050));
  var_20 dontinterpolate();
  var_20.angles = (2, 0, 0);
  var_21 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_20 clonebrushmodeltoscriptmodel(var_21);
  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1258, -2398, 1060));
  var_22 dontinterpolate();
  var_22.angles = (0, 73, 0);
  var_23 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1276, -2416, 1056));
  var_22 dontinterpolate();
  var_22.angles = (0, 73, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1558, -1854, 1062));
  var_22 dontinterpolate();
  var_22.angles = (322, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1560, -1576, 1140));
  var_22 dontinterpolate();
  var_22.angles = (0, 340, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1398, -754, 790));
  var_22 dontinterpolate();
  var_22.angles = (0, 20, 0);
  var_22 clonebrushmodeltoscriptmodel(var_23);
  var_24 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2416, -1832, 992));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, 0);
  var_25 = getEnt("_encstr_A2BD0EB1D8B438668C1ECC463C23D4C6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_24 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-860, -2234, 1106));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, -122);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_24 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-872, -2234, 1106));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, -122);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_20 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-844, -2230, 1200));
  var_20 dontinterpolate();
  var_20.angles = (5.295, 2.825, -151.869);
  var_20 clonebrushmodeltoscriptmodel(var_21);
  var_24 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-584, -2656, 1010));
  var_24 dontinterpolate();
  var_24.angles = (0, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_25);
  var_26 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-458, -1262, 856));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_27 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_26 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-522, -1264, 858));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_26 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-586, -1264, 858));
  var_26 dontinterpolate();
  var_26.angles = (0, 358, 0);
  var_26 clonebrushmodeltoscriptmodel(var_27);
  var_28 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-770, -2490, 936));
  var_28 dontinterpolate();
  var_28.angles = (0, 316, 0);
  var_29 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_28 clonebrushmodeltoscriptmodel(var_29);
  var_30 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2428.32, -1977.25, 1154.54));
  var_30 dontinterpolate();
  var_30.angles = (90, 0, 0);
  var_31 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2392.32, -2225.25, 1186.54));
  var_30 dontinterpolate();
  var_30.angles = (90, 16, 0);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2484.87, -2310.06, 1206.56));
  var_30 dontinterpolate();
  var_30.angles = (0, 40, -90);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_30 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2664.87, -2490.06, 1206.56));
  var_30 dontinterpolate();
  var_30.angles = (0, 50, -90);
  var_30 clonebrushmodeltoscriptmodel(var_31);
  var_32 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-774.51, -2733.74, 1228));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_33 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-598.51, -2733.74, 1260));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-771.37, -2736.12, 1292));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_32 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-556.011, -2725.13, 1236));
  var_32 dontinterpolate();
  var_32.angles = (0, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_33);
  var_34 = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3483.93, -718.783, 806.96));
  var_35 dontinterpolate();
  var_35.angles = (0, 35, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2771.93, -1110.78, 894.96));
  var_35 dontinterpolate();
  var_35.angles = (0, 35, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2444.24, -2349.37, 1094.7));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2818.05, -2866.49, 1124.31));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_35 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2690.05, -2866.49, 1124.31));
  var_35 dontinterpolate();
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_35 disconnectPaths();
  var_36 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2384.71, -2441.04, 1112.77));
  var_36.angles = (7.43938, 99.1471, 18.1777);
  var_36 setModel("_encstr_9A4C1E368D30DAE1EB60E2E918DB628FA9E1A1D5177E4F739BE0BA2201291A7B");
  var_36 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2750.08, -2884.09, 1140.8));
  var_36.angles = (352.628, 9.14556, 15.7999);
  var_36 setModel("_encstr_9A4C1E368D30DAE1EB60E2E918DB628FA9E1A1D5177E4F739BE0BA2201291A7B");
  var_36 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2789.97, -1137.88, 986.641));
  var_36.angles = (11.3127, 352.884, -15.6063);
  var_36 setModel("_encstr_9A4C1E368D30DAE1EB60E2E918DB628FA9E1A1D5177E4F739BE0BA2201291A7B");
  var_36 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3460.21, -682.763, 883.417));
  var_36.angles = (359.425, 175.707, -12.8315);
  var_36 setModel("_encstr_9A4C1E368D30DAE1EB60E2E918DB628FA9E1A1D5177E4F739BE0BA2201291A7B");
  var_37 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-805.316, -2706.05, 1226));
  var_37.angles = (0, 180, -8);
  var_37 setModel("_encstr_99E7250D2821BAB2A435AED5BAA8BA5AE1D750C73047F20629D28C982BD30FB3CBB71A8777FA19");
  var_37 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-805.316, -2704.05, 1258));
  var_37.angles = (350, 90, 0);
  var_37 setModel("_encstr_99E7250D2821BAB2A435AED5BAA8BA5AE1D750C73047F20629D28C982BD30FB3CBB71A8777FA19");
  var_38 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-599, -2671, 1306));
  var_38.angles = (0, 0, 0);
  var_38 setModel("_encstr_993F215B50B7DBA730C59F9F663E5FA05988B3120885998F8935998C68E117EAE7BA0F");
  var_39 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1185.97, -1429.64, 1053.96));
  var_39 setModel("_encstr_BED313F39CB21153D95751902BF169199944FD06F5");
  var_39.angles = (0, 135.999, 15.2997);
  var_40 = getEntArray("_encstr_A24414B6BDC9A3B027E6EBB93A58E4E8D7DAB723591B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_42 in var_40) {
    if(var_42.origin == (-1313.04, 12624.6, -1027.39))
      var_42 delete();
  }

  var_44 = [(-4262.21, -2103.35, 1029.15), (-4262.21, -2151.35, 1027.82), (-4270.21, -2199.35, 1024.57), (-4270.21, -2239.35, 1030.85)];
  var_45 = [(-4088.65, -2766.21, 1109.15), (-4040.65, -2766.21, 1107.82), (-3992.65, -2774.21, 1104.57), (-3952.65, -2782.21, 1110.85)];
  var_46 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];
  var_47 = scripts\engine\utility::getStructArray("_encstr_8F1B0ECD900917C027088B92C0AD3F93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_48 = scripts\engine\utility::getStructArray("_encstr_96ED149B6BBDDAB2D7ACE656DA5EFAE60758EE37B29C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_47 = scripts\engine\utility::array_combine(var_47, var_48);

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }
      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3942.21, -847.355, 916.54), (-3942.21, -895.355, 930.206), (-3950.21, -943.355, 947.497), (-3950.21, -983.355, 963.497)];
  var_45 = [(-3824, -704, 896), (-3776, -704, 896), (-3728, -712, 896), (-3688, -712, 888)];
  var_51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }
      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3374.21, -1183.35, 990.46), (-3374.21, -1231.35, 994.262), (-3382.21, -1279.35, 998.008), (-3382.21, -1319.35, 1005.29)];
  var_45 = [(-3048, -1096, 1002.7), (-3000, -1104, 1001.98), (-2952, -1112, 996.719), (-2912, -1120, 998.522)];
  var_51 = [(0, 180, 0), (0, 180, 0), (0, 180, 0), (0, 180, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }
      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }

  var_44 = [(-3270.21, -2279.35, 1068.57), (-3270.21, -2319.35, 1069.8), (-3942.21, -1319.35, 1034.04)];
  var_45 = [(-3127.35, -3017.79, 1170.2), (-3167.35, -3017.79, 1167.58), (-3112, -64, 712)];
  var_51 = [(0, 360, 0), (0, 360, 0), (0, 0, 0)];

  for(var_8 = 0; var_8 < var_44.size; var_8++) {
    var_49 = var_44[var_8];
    var_50 = var_45[var_8];
    var_51 = var_46[var_8];

    foreach(var_53 in var_47) {
      if(var_53.origin != var_49) {
        continue;
      }
      var_53.origin = var_50;
      var_53.angles = var_51;
      break;
    }
  }
}

syringe_inject() {
  wait 2.5;
  playFX(level._effect["_encstr_978D144B18D9F183F3A769574ED923091D8893F269E3"], (-3124.65, -2680.78, 1100.46));
  waitframe();
  playFX(level._effect["_encstr_978D144B18D9F183F3A769574ED923091D8893F269E3"], (-4658.99, -2590.47, 1068.88));
  waitframe();
  playFX(level._effect["_encstr_978D144B18D9F183F3A769574ED923091D8893F269E3"], (-4477.19, -2970.69, 1109.02));
  waitframe();
  playFX(level._effect["_encstr_978D144B18D9F183F3A769574ED923091D8893F269E3"], (-2649.79, -2934.28, 1167.31));
}

onplayerspawn() {
  _encstr_A39824FFD7C234188B1A3A6970CE4FB72B1FEC33032D33FE0F60C9CF6B2D7107706705929B82::givedefaultloadout();
  var_0 = _id_1249D();
  self giveweapon(var_0);
  self setweaponammoclip(var_0, weaponclipsize(var_0));
  self setweaponammostock(var_0, weaponmaxammo(var_0));
  self switchtoweapon(var_0);
  var_1 = _id_1249E();
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  level.hostdamagefactorlow++;

  if(!getdvarint("_encstr_A301174F278BAFF0D167C8238E99114EB2B7C18FE7B25DE8FF"))
    trial_shooters_quota();
}

_id_1249D() {
  var_0 = scripts\cp\cp_weapon::buildweapon_variant("_encstr_8C160DAFE71BF161681EB5BCB0F8FC", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
  var_0 = var_0 withattachment("_encstr_93F308F62787A6315A4F");
  var_0 = var_0 withoutattachment("_encstr_8C570C0DED1B7B7DDD2B371D0C26");
  var_0 = var_0 withattachment("_encstr_AAB01460FBE35E284707BF83332BAA866F92BB08320F");
  return var_0;
}

_id_1249E() {
  return scripts\cp\cp_weapon::buildweapon("_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07", ["_encstr_A2AD0F4C27B0D6ACD7AD5AAD2B269C9813", "_encstr_B81E17E61B961995BE3AE44B1D4BEA6BF5AD4BADCA89C96289", "_encstr_B1B01175D132C8101BEA7E2012D7DDEA18795B"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
}

_id_1249F(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon_variant("_encstr_A32A0FA7EFE3098B8006FCC79BB0ADE210", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_0);
  var_1 = var_1 withattachment("_encstr_93F308F62787A6315A4F");
  var_1 = var_1 withattachment("_encstr_BE3610CED337B17B0E59AF862327EDADCA7B");
  var_1 = var_1 withattachment("_encstr_99421178AD6351B670AB4F5F08807AEF223B50");
  var_1 = var_1 withattachment("_encstr_B4500F4EF940BD5AF57F1B234D2842ED7B");
  return var_1;
}

trial_shooters_quota() {
  if(scripts\engine\utility::flag("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D")) {
    return;
  }
  var_0 = ["_encstr_9101096BBF4A4F97FB983D", "_encstr_AC0109244BFFEEA19D7293", "_encstr_B801093B97E7D9579BF09E", "_encstr_8D01091D589DFA9D5DBCE0"];
  var_1 = [(3, -10, -25), (3, 10, -25), (3, 10, -25), (3, -10, -25)];
  var_2 = [40, 50, 50, 40];
  var_3 = [50, 40, 40, 50];

  if(!isDefined(level.trial_shooters._id_13A26))
    level.trial_shooters._id_13A26 = [];

  var_4 = undefined;
  var_5 = undefined;

  foreach(var_8, var_7 in var_0) {
    if(isDefined(level.trial_shooters._id_13A26[var_7])) {
      continue;
    }
    level.trial_shooters._id_13A26[var_7] = 1;
    var_4 = var_7;
    var_5 = var_8;
    break;
  }

  var_9 = var_1[var_5];
  var_10 = var_2[var_5];
  var_11 = var_3[var_5];
  var_12 = scripts\cp\laser_traps\cp_laser_traps::_id_124E9(self, "_encstr_8BB007E03658CBCAE4");
  var_12 linkTo(level.trial_shooters, var_4, var_9, (0, 0, 0));
  self playerlinktodelta(var_12, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1, 1, 1);
  self lerpviewangleclamp(1, 0.25, 0.25, var_10, var_11, 80, 80);
  waitframe();
  thread trial_small_fire(self, var_12);
  level.trial_shooters waittill("_encstr_86EF0F6F49289BC7D0219D249EF010C270");
  self unlink();
  var_12 delete();
}

trial_small_fire(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  for(;;)
    var_1 scripts\cp\cp_anim::anim_player_solo(var_0, var_1, "_encstr_B6A90B5ACD3AE47BF5B491B159");
}

registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration))
        self.interaction_trigger setuseholdduration(var_1.useduration);

      break;
  }
}

intro_main() {
  skipburndownlow();
  var_0 = getaiarray("_encstr_8E8405EA382B2A");
  scripts\engine\utility::array_thread(var_0, scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin);
  var_1 = scripts\cp\utility::create_client_overlay("_encstr_83AB065EE1391A7B", 1.0);
  var_2 = scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5, var_4 in level.players) {
    var_4 unlink();
    var_4 freezecontrols(1);
    var_4 setOrigin(var_2[var_5].origin);
    var_4 setplayerangles(var_2[var_5].angles);
    var_4 allowstand(1);
    var_4 allowmovement(0);
    var_4 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  }

  scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_92802CACFB2E4FA25F496AB29B7751F741693C2F959377AF3DE0620B798F12E739C587CBAF598FB5DB90CA61F221");
  var_6 = 5.0;
  wait(var_6);

  foreach(var_4 in level.players) {
    var_4 freezecontrols(0);
    var_4 allowmovement(1);
    var_4 shellshock("_encstr_822D103D758B39F30563D140CA9A8FF3D31C", 3.0);
    var_4 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
    var_4 clearaccessory();
    var_4 takeallweapons();
    var_8 = "_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07";
    var_9 = scripts\cp\cp_weapon::buildweapon(var_8, undefined, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", 1);
    var_4 giveweapon(var_9);
    var_4 switchtoweapon(var_9);
    var_4.loadoutaccessoryweapon = var_4 scripts\cp\cp_loadout::cac_getaccessoryweapon();
    var_4.loadoutaccessorydata = var_4 scripts\cp\cp_loadout::cac_getaccessorydata();
    var_4.loadoutaccessorylogic = var_4 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

    if(isDefined(var_4.loadoutaccessorydata) && isDefined(var_4.loadoutaccessoryweapon) && var_4.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99")
      var_4 scripts\cp\cp_accessories::giveplayeraccessory(var_4.loadoutaccessorydata, var_4.loadoutaccessoryweapon, var_4.loadoutaccessorylogic);

    var_4 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  }

  set_objective("_encstr_AFE108E6AB93CED2EC59");
  var_11 = 5.0;
  var_1 fadeovertime(var_11);
  var_1.alpha = 0;
  var_1 scripts\engine\utility::delaycall(var_11, ::destroy);
  var_12 = [3, 6, 8, 10];
  var_13 = scripts\engine\utility::getStructArray("_encstr_822D14BB7EC35BC7C9725818EA18EF33AB193CA0CD73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = scripts\engine\utility::array_randomize(var_13);
  var_0 = [];
  var_14 = var_12[level.players.size - 1];

  foreach(var_20, var_16 in var_13) {
    if(var_20 >= var_14) {
      break;
    }

    var_17 = var_16 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var_18 = scripts\engine\utility::random(level.players);
    var_17 setgoalentity(var_18);
    var_17.goalradius = 300;
    var_19 = var_17 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
    var_17 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
    var_17 scripts\engine\utility::delaythread(5.0, scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var_19);
    var_0 = scripts\engine\utility::array_add(var_0, var_17);
  }

  scripts\cp\laser_traps\cp_laser_traps::_id_13067();
  scripts\engine\utility::array_wait(var_0, "_encstr_AD75063D571AE108");
}

jumpscenenode() {
  var_0 = [(-1406.52, -1537.56, 1154.25), (-520.306, -1863.58, 1193.75)];
  var_1 = [(0, 162.743, 0), (0, 182.744, 0)];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_0[var_2], var_1[var_2]);

  var_3 = (-1354.86, -1406.15, 1017.5);
  var_4 = (0, 160.849, 0);
  scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_3, var_4);
  var_5 = (-521.718, -1719.51, 1041.5);
  var_6 = (0, 179.765, 0);
  scripts\cp\laser_traps\cp_laser_traps::_id_11CB8(var_5, var_6);
  var_7 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-721.301, -1094.8, 834.118), (354.711, 3.04249, -28.3572));
  setheadiconsnaptoedges(var_7.headiconid, 800);
}

jumped() {
  level._id_12DB9 = 1;
  jumpscenenode();
  scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_A39D2939A8E7A087F3B7091B2FDB5810718540D6170E58310BCF2D2B5FF21C301A5E0968BF6688F6815EA1");
  scripts\engine\utility::delaythread(8.0, ::weapon_xp_iw8_sm_augolf);
  israndompistolloadouts();
  var_0 = 45;
  wait(var_0);
  var_1 = 25;
  var_2 = 20;
  var_3 = 10;
  var_4 = 2;
  var_5 = 6.0;
  var_6 = 7.0;
  var_8 = ["_encstr_9AA32846E1D76C076E7D63856E37BED885C6D8BDEA3AFAD6ED4E3A5893BEC2E83AB0C66D5A379DAF8918", "_encstr_9BA32840833F31B96399718FEA1B9F79694B88A01FCC4E4B8AFA758782F12B43C4176808977E01778772"];
  var_9 = ["_encstr_BD6E240A42E0DF4AC0DF04119F1859131778722149C09F45788313277D80DC474E906AA95B87", "_encstr_A39D2939A8E7A087F3B7091B2FDB5810718540D6170E58310BCF2D2B5FF21C301A5E0968BF6688F6815EA1"];
  var_10 = ["_encstr_924F19C887F55B0E857DAE3747C6FAA1D237E8F5AD5A63C6C23636", "_encstr_A5D81E461ED7D61C0BAFD59BD11BEB6D34FAB9B9D2079527BE43AE9339F2EA1C"];
  var_11 = ["_encstr_8A912A9CB0CE086BAA077D6B337B090852CEF8B51DC5C303263FD10E4B4F3DB4D77B7348D25CA6D7BB71E7DB", "_encstr_A6B22885580F05AF60FFED3B2C81E905591F74BC78FFD2DBBAF4EF05EE751F60E32B937B431191A78B68"];

  for(;;) {
    var_12 = int(tablelookupbyrow("_encstr_82803E633AC3B380E38BAF2F901DA00F739370E9731FF640F1782B2FA07398CBE60A1316EB073830144FD137D1D8A116BF8368F9B1A768386B21ED37B686B8DC", level._id_12DB9, level.players.size));

    if(var_12 > 0) {
      var_13 = var_8[0];

      if(isDefined(var_13)) {
        scripts\engine\utility::delaythread(6.0, ::_id_12758, var_13);
        var_8 = scripts\engine\utility::array_remove(var_8, var_13);
      }

      thread _id_12DAB(var_12);
      var_14 = var_3 * var_12;
      var_14 = var_14 * (1 / level.players.size);
      wait(var_14);
    }

    var_15 = var_9[0];

    if(isDefined(var_15)) {
      thread _id_12758(var_15);
      var_9 = scripts\engine\utility::array_remove(var_9, var_15);
    }

    var_16 = var_10[0];

    if(isDefined(var_16)) {
      scripts\engine\utility::delaythread(7.0, ::_id_12758, var_16);
      var_10 = scripts\engine\utility::array_remove(var_10, var_16);
    }

    thread _id_12DB2();
    wait(var_2);
    thread _id_12DB0();
    _id_12DB1();
    thread _id_12DA7();
    _id_12DB6();

    if(!_id_12DA5()) {
      if(level._id_12DB9 == var_4)
        _id_12DAD();
      else
        _id_12DA6();

      var_17 = var_11[0];

      if(isDefined(var_17)) {
        scripts\engine\utility::delaythread(2.0, ::_id_12758, var_17);
        var_11 = scripts\engine\utility::array_remove(var_11, var_17);
      }

      var_18 = randomfloatrange(var_5, var_6);
      wait(var_18);
    }

    level notify("_encstr_8AAB11C62B67AC36BEE4EDEA7391D7BDEC59C9");
    var_19 = _id_12DA9();

    foreach(var_21 in var_19) {
      if(!isDefined(var_21)) {
        continue;
      }
      var_21 delete();
    }

    level._id_12DB9++;

    if(level._id_12DB9 > 3) {
      break;
    }

    var_23 = ["_encstr_95BC1C460FFADA072C7D576E8EC6F5C296272339EDC17D16D886D256D959", "_encstr_AF0721B9286750075237BBBFB3AAD888F90221F3159009343B9783BDEB5213319DDA89"];
    var_24 = scripts\engine\utility::random(var_23);
    scripts\engine\utility::delaythread(3.0, ::_id_12758, var_24);
    scripts\engine\utility::delaythread(6.0, ::weapon_xp_iw8_sm_augolf);
    wait(var_1);
  }
}

_id_12DA5() {
  return level._id_12DB9 == 3;
}

_id_12DAD() {
  var_0 = 6.0;
  var_1 = 0.5;
  var_2 = 1.0;
  var_3 = scripts\engine\utility::getStructArray("_encstr_AAFE1183D86F743F4E2DF6F42813A3FAB3507B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_5.origin, (0, 0, 4), 0.05);
    var_6 = randomfloatrange(var_1, var_2);
    wait(var_6);
  }

  foreach(var_9 in level.players) {
    magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_9.origin, (0, 0, -4), 0.05);
    var_9 visionsetnakedforplayer("_encstr_884D14B11CBEE6BDEBA15ACE437785F27DB9D6F6D695", var_0);
  }

  wait(var_0);
  var_11 = _id_11D38();

  foreach(var_13 in var_11)
  var_13 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();

  thread _id_12DAF();
  thread _id_12DAE();
  var_15 = [0, 40, 60, 70, 80];
  var_16 = var_15[level.players.size];
  var_17 = scripts\engine\utility::getStructArray("_encstr_96ED149B6BBDDAB2D7ACE656DA5EFAE60758EE37B29C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(var_16 > 0) {
    var_18 = var_17[randomint(var_17.size)];
    var_19 = var_18 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_19))
      var_16--;

    wait 1.0;
  }

  _id_12DB6();
  _id_12DA6();

  foreach(var_9 in level.players)
  var_9 visionsetnakedforplayer("_encstr_B40101", 60);
}

_id_12DAF() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  level endon("_encstr_8AAB11C62B67AC36BEE4EDEA7391D7BDEC59C9");
  var_0 = 5.0;
  wait(var_0);
  var_1 = level.players;
  var_2 = 12;
  var_3 = 30;
  var_4 = max(var_2, var_3 / var_1.size);
  var_5 = 7;
  var_6 = 1;
  var_7 = 3;

  for(;;) {
    var_8 = getaiarray("_encstr_8E8405EA382B2A");

    if(var_8.size < var_5) {
      waitframe();
      continue;
    }

    var_9 = scripts\engine\utility::random(var_1);
    var_10 = randomintrange(var_6, var_7);

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_12 = var_9.origin + (0, 0, 300) + scripts\engine\utility::randomvectorrange(15, 30);
      var_8[0].grenadeweapon = getcompleteweaponname("_encstr_92A70ABB8267F5E0D89F6351");
      var_8[0] magicgrenademanual(var_12, (0, 0, -5), 2);
    }

    var_1 = scripts\engine\utility::array_remove(var_1, var_9);

    if(!var_1.size)
      var_1 = level.players;

    wait(var_4);
  }
}

_id_12DAE() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  level endon("_encstr_8AAB11C62B67AC36BEE4EDEA7391D7BDEC59C9");
  var_0 = 8.0;
  wait(var_0);
  var_1 = level.players;
  var_2 = 14;
  var_3 = 33;
  var_4 = max(var_2, var_3 / var_1.size);
  var_5 = [(-648.919, -1298.07, 1746.41), (-538.559, -1801.64, 2024), (-1434.56, -1993.64, 2056), (-1402.56, -1497.64, 2024)];
  var_6 = [(19.625, 267.558, 0), (90, 0, 90), (90, 0, 90), (90, 0, 90)];
  var_7 = [5000, 1, 1, 1];
  var_8 = 7;

  for(;;) {
    var_9 = getaiarray("_encstr_8E8405EA382B2A");

    if(var_9.size < var_8) {
      waitframe();
      continue;
    }

    for(var_10 = 0; var_10 < var_5.size; var_10++) {
      var_11 = var_5[var_10];
      var_12 = anglesToForward(var_6[var_10]) * var_7[var_10];
      var_9[0].grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
      var_13 = var_9[0] magicgrenademanual(var_11, var_12);
      var_9[0] scripts\cp\powers\coop_molotov::molotov_used(var_13);
    }

    wait(var_4);
  }
}

_id_12DB2() {
  level endon("_encstr_8AAB11C62B67AC36BEE4EDEA7391D7BDEC59C9");
  var_0 = getEntArray("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = int(tablelookupbyrow("_encstr_99783FB93693A51CD19BE5B1075EADC2C1B9BCC61CAFDCDBFA344B760DDD0B5E5E1BC1AF37EDBE1A4BCE86BBB02FEB9CEDBA3791AFEC5934968D1BCA9B17C6DC3B", level._id_12DB9, level.players.size));
  var_2 = 2.0;
  var_3 = 1.0;

  while(var_1 > 0) {
    if(!var_0.size) {
      return;
    }
    var_4 = var_0[0];
    var_5 = var_4 scripts\common\utility::spawn_vehicle();

    if(!isDefined(var_5.riders))
      var_5 waittill("_encstr_92FC0E6B1809EB7D6084BF222B493B63");

    var_6 = 0;

    foreach(var_8 in var_5.riders) {
      if(var_8.vehicle_position != 0) {
        continue;
      }
      var_6 = 1;
      break;
    }

    if(!istrue(var_6)) {
      var_5 delete();
      wait(var_3);
      continue;
    }

    var_1--;
    thread _id_12DB4(var_5);
    var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    var_0 = sortbydistance(var_0, var_4.origin);
    wait(var_2);
  }
}

_id_1420C() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B4350A0AAB73BA371120E5FC");
  thread nodetype();
}

_id_12DB0() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  level endon("_encstr_8AAB11C62B67AC36BEE4EDEA7391D7BDEC59C9");
  var_0 = int(tablelookupbyrow("_encstr_AF9E3E47763223D3093BD047ABE21DA940D7C51690F71FC750DC8AF782A7878ACF9A4277530D0F44FCDADCB3065AD122CD5B3527497A8FADBE13A263AD3EC056", level._id_12DB9, level.players.size));

  if(var_0 <= 0) {
    return;
  }
  var_1 = 14;
  wait(var_1);
  var_2 = 4.0;
  var_3 = 8.0;
  _id_12758("_encstr_A2742F233CD76CC16ED7C6B0DCB9D71BC21BB17B5D47AFB957A5D896C8B2BE267BD6269539EBDCC158BB73B4B9ECBE9106");
  var_4 = [(-3158.13, -1064.1, 994.668), (-3167.07, -3017.07, 1171.24)];

  while(var_0 > 0) {
    var_5 = scripts\engine\utility::random(var_4);
    var_6 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1("_encstr_AF071B99AD5D5083B1C7B1E7E7AACF79F4C7C31152940936EA878DABB3", var_5, (0, 0, 0), 1);

    if(isDefined(var_6))
      var_0--;

    var_7 = randomfloatrange(var_2, var_3);
    wait(var_7);
  }
}

_id_12DA6() {
  level notify("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  var_0 = getaiarray("_encstr_8E8405EA382B2A");
  var_1 = scripts\engine\utility::getStructArray("_encstr_A35A15D79D8DEA41C9637F035B2061B3483F1B734326C3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    if(istrue(var_3.stadium_two_death_func)) {
      continue;
    }
    var_1 = sortbydistance(var_1, var_3.origin);
    var_3 thread nextdest(var_1[0]);
  }
}

_id_12DA7() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  var_0 = randomfloatrange(10, 15);
  wait(var_0);
  var_1 = 0.2;
  var_2 = 0.5;
  var_3 = 2.25;
  var_4 = 3.55;
  var_5 = 2;
  var_6 = 4;

  for(;;) {
    var_7 = randomintrange(var_5, var_6);
    var_8 = getaiarray("_encstr_8E8405EA382B2A");

    foreach(var_12, var_10 in var_8) {
      if(!isDefined(var_10)) {
        continue;
      }
      if(!isalive(var_10)) {
        continue;
      }
      if(var_10 islinked()) {
        continue;
      }
      if(istrue(var_10.stadium_two_death_func)) {
        continue;
      }
      var_10 childthread no_previous_interaction_point();

      if(var_12 >= var_7) {
        break;
      }

      var_11 = randomfloatrange(var_1, var_2);
      wait(var_11);
    }

    var_13 = randomfloatrange(var_3, var_4);
    wait(var_13);
  }
}

_id_12DB4(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0.targetname = "_encstr_BE230E44859CE87B09157DB81153BB97";
  var_0 vehicleshowonminimap(1);
  var_0 aiupdatecoverexposetype(1);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_0);
  childthread _id_12DB5(var_0);

  while(!var_0 vehicle_getspeed())
    waitframe();

  var_1 = [0, 32, 35, 35];
  var_2 = var_1[level._id_12DB9];
  var_0 vehicle_setspeed(var_2, 9999, 9999);
  var_0 setwaitspeed(0);
  var_0 waittill("_encstr_83F31382ADE312408110479F407814999FBFCFFF85");
  var_0 vehicleshowonminimap(0);
}

_id_12DB5(var_0) {
  var_1 = "_encstr_8C4D15BB71EB473E883BA772C388439F85AE6363D9350B";
  var_0 scripts\engine\utility::ent_flag_init(var_1);
  thread scripts\common\vehicle_paths::gopath(var_0);
  var_0 scripts\engine\utility::ent_flag_wait(var_1);
  var_0 resumespeed(7);
}

_id_12DA9() {
  return getEntArray("_encstr_BE230E44859CE87B09157DB81153BB97", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

weapon_xp_iw8_sm_augolf() {
  var_0 = int(tablelookupbyrow("_encstr_873A3CFA49B0491B2DF7B68F197832B948D3654683811BA290F9B767317CBAE90A392AC19BA8EF0AD38FBB2F0B2381235060A552D3B89DD23ABF9A67574C", level._id_12DB9, level.players.size));

  if(var_0 == 1)
    thread _id_12758("_encstr_88551871D8875DC31789032B6033B127B325F1137F7F8F8BAF80");
  else if(var_0 > 1)
    thread _id_12758("_encstr_88A02123F0EBB538EDEBBA9BB7C1F5582DC946C9DB38FA6BD5B13AD207C659EBAB9B59");

  var_1 = 2.0;
  wait(var_1);
  var_2 = scripts\engine\utility::getStructArray("_encstr_8C0123D82BECB2B1BEB18539B2E00BD8DA2CCEB27DD0B2C64BAF199CED83D7DC1D93BA1BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawnStruct();
  var_3.origin = (-1229.57, -1160.71, 2000);
  var_3.angles = (0, 180, 0);
  var_3.script_radius = 20000;
  var_3.script_index = 3;
  var_2 = scripts\engine\utility::array_add(var_2, var_3);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::can_play_ending(var_2);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_5 = squared(70);

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_7 = var_2[var_6].script_radius;
    var_8 = var_2[var_6].script_radius;
    var_9 = var_2[var_6].angles;
    var_10 = var_2[var_6].origin;

    for(;;) {
      var_11 = 1;

      foreach(var_13 in var_4) {
        if(distance2dsquared(var_13.origin, var_10) > var_5) {
          continue;
        }
        var_11 = 0;
        break;
      }

      if(var_11) {
        break;
      } else
        var_10 = var_10 + (60, 0, 0);
    }

    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, undefined, ::weapon_xp_iw8_sm_charlie9);
    wait 3.0;
  }
}

weapon_xp_iw8_sm_charlie9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    if(!isDefined(level._id_12A94))
      level._id_12A94 = [];

    if(!isDefined(var_0._id_12881))
      var_0._id_12881 = [];

    var_3 = tablelookupbyrow("_encstr_873A3CFA49B0491B2DF7B68F197832B948D3654683811BA290F9B767317CBAE90A392AC19BA8EF0AD38FBB2F0B2381235060A552D3B89DD23ABF9A67574C", level._id_12DB9, 6);
    var_3 = strtok(var_3, "_encstr_974C0246");
    var_4 = tablelookupbyrow("_encstr_873A3CFA49B0491B2DF7B68F197832B948D3654683811BA290F9B767317CBAE90A392AC19BA8EF0AD38FBB2F0B2381235060A552D3B89DD23ABF9A67574C", level._id_12DB9, 5);
    var_4 = strtok(var_4, "_encstr_974C0246");

    if(var_3.size) {
      foreach(var_6 in var_3) {
        if(!scripts\engine\utility::array_contains(level._id_12A94, var_6)) {
          continue;
        }
        var_3 = scripts\engine\utility::array_remove(var_3, var_6);
      }
    }

    if(var_3.size)
      var_8 = var_3;
    else
      var_8 = var_4;

    var_8 = scripts\engine\utility::array_remove_array(var_8, var_0._id_12881);

    if(!var_8.size)
      var_8 = var_4;

    var_2 = scripts\engine\utility::random(var_8);
  }

  if(!scripts\engine\utility::array_contains(level._id_12A94, var_2))
    level._id_12A94 = scripts\engine\utility::array_add(level._id_12A94, var_2);

  var_0._id_12881 = scripts\engine\utility::array_add(var_0._id_12881, var_2);
  var_9 = "_encstr_B2010820C5337B67C8CF";

  if(getsubstr(var_2, 0, var_9.size) == var_9) {
    var_10 = spawn(var_2, var_1 + (0, 0, 25));
    var_10 itemweaponsetammo(weaponclipsize(var_10), weaponmaxammo(var_10));
    var_10 physicslaunchserveritem(var_10.origin, (0, 0, 2000));
  } else
    scripts\cp\laser_traps\cp_laser_traps::_id_124A5(var_0, var_2);
}

initarmsraceanims(var_0) {
  return (0, 1, 0);
}

_id_12758(var_0) {
  if(!isDefined(level._id_121A7))
    level._id_121A7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  level._id_121A7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level._id_121A7 playSound(var_0);
  wait(var_1);
}

_id_1437B() {
  scripts\cp\laser_traps\cp_laser_traps::_id_1437A();
}

mud_sfx(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    return 0;

  var_1 = 60000;

  if(level.time_survived < 10 * var_1)
    return 3;
  else if(level.time_survived < 15 * var_1)
    return 2;

  return 1;
}

skipburndownlow() {
  var_0 = getEnt("_encstr_ABA20B5AE6A3E4DEAF43CAC696", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0 scripts\common\utility::spawn_vehicle();
  var_1 setmaxpitchroll(10, 25);
  level.trial_shooters = var_1;
  var_1 thread skip_overheat();
  var_1 scripts\common\vehicle::godon();
  var_1.script_team = "_encstr_9A8507BA4040188D08";
  var_1 thread skipprematch();
  thread trial_special_vfx();
  var_2 = missile_createrepulsorent(var_1, 5000, 1000);
  var_3 = getEntArray("_encstr_A504154BE6E893BD7D43ACC64B7D1995B9E893EDE59523", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3)
  var_5 hide();

  _id_1437B();

  foreach(var_8 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::_id_12486(var_8);
    var_8 setsoundsubmix("_encstr_A7D11716F76F42B611A85B8FD8AB73AA970C1F4CD3BF4AC5DB", 0.5);
  }

  scripts\engine\utility::delaythread(1.0, ::_id_12758, "_encstr_93C81953C32EA5CB1378833AD521F17F5308AF83A141F4D36B0E0C");
  var_10 = level.vehicle.templates.aianims[var_1 scripts\common\vehicle_code::get_vehicle_classname()];
  var_11 = var_10[0].vehicle_getoutanim;
  thread scripts\cp\vehicle::matchdata_logweaponstat(var_1, var_11);
  var_12 = 11;
  wait(var_12);
  scripts\engine\utility::delaythread(4.0, ::_id_12758, "_encstr_ABA4271987FADAE0B0FAEA37471BFAEA3719B29CD72C47D1858DADD7CCC92DB2DC461B2FD70D5663A5");
  scripts\engine\utility::flag_set("_encstr_97E9156FB843A22267EBBFF543BF3A79E8C9CF9B681BE0");
  missile_deleteattractor(var_2);
  waitframe();
  var_13 = missile_createattractorent(var_1, 999999, 2000);

  for(;;) {
    var_1 waittill("_encstr_B2BE0788BAF573592F", var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_14, var_15);

    if(weaponclass(var_15) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0") {
      break;
    }
  }

  scripts\engine\utility::delaythread(1.5, ::_id_12758, "_encstr_8730249AD27057FAE04F8D73E170C9BB852B1343983B0FB739158261EB484FC333464ABA809B");
  missile_deleteattractor(var_13);
  var_1 notify("_encstr_A3CC0DF798D030B185790845D0AF7B");
  scripts\engine\utility::flag_set("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D");
  var_1 heli_crash(var_3);
  scripts\cp\laser_traps\cp_laser_traps::little_bird_mg_cp_ondeathrespawncallback();
}

skipprematch(var_0) {
  self notify("_encstr_9B31161EFD37417892D788B056133E539380E84E11A6CF33");
  self endon("_encstr_9B31161EFD37417892D788B056133E539380E84E11A6CF33");
  self endon("_encstr_AD75063D571AE108");

  if(istrue(var_0))
    var_1 = 0.45;
  else
    var_1 = 0.14;

  for(;;) {
    if(istrue(var_0)) {
      earthquake(0.3, var_1, level.trial_shooters.origin, 5000);

      foreach(var_3 in level.players)
      var_3 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

      wait(var_1 * 0.5);
      continue;
    }

    earthquake(0.12, var_1, level.trial_shooters.origin, 5000);

    foreach(var_3 in level.players)
    var_3 playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");

    wait(var_1 * 0.5);
  }
}

skip_overheat() {
  self endon("_encstr_A3CC0DF798D030B185790845D0AF7B");
  var_0 = scripts\engine\utility::getStruct("_encstr_8B2211C0E5F373B841989B1812A1B1399B1C22", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0;
  self vehicle_setspeed(40, 20);

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var_1.origin);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");

    if(isDefined(var_1.target)) {
      var_1 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      continue;
    }

    var_1 = var_0;
  }
}

heli_crash(var_0) {
  thread skipprematch(1);
  self setmaxpitchroll(25, 25);
  var_1 = scripts\engine\utility::getStructArray("_encstr_AD20152DB98E93DEAFA1ACD8B4F5465658D10D07B0E8D0", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = var_1[0];
  thread _id_12758("_encstr_A3B922C7D221BBD376771777619F69E2A81BBE0BE9C9509AC13F1BCF7F45723A88E662C2");
  self playLoopSound("_encstr_A6A01E7BCFF7F21277DFCB63578001742013EB8A9BD1A7CBCF48598EA0F038CB");
  var_3 = var_2;
  thread heli_spin();
  self vehicle_setspeed(80, 50, 50);
  self setyawspeed(150, 50, 50, 0);
  var_4 = "_encstr_B498110DCAC62DBE6C4E2C370DD7B22C9363BC";
  thread sixthsense_inotherplayertargetcone(self, var_4);

  foreach(var_6 in level.players)
  var_6 mountain_one_death_func();

  for(;;) {
    self setneargoalnotifydist(200);
    self setvehgoalpos(var_3.origin);
    var_8 = scripts\engine\utility::_id_143AE("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958", var_4);

    if(!isDefined(var_3.target) || var_8 == var_4) {
      break;
    }

    var_3 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  self notify("_encstr_86EF0F6F49289BC7D0219D249EF010C270");
  thread scripts\engine\utility::play_sound_in_space("_encstr_857C1CC328A80C99A1C565DC3E47A3C41158A767682153B2F7EBED171319", self.origin);

  foreach(var_6 in level.players)
  var_6 clearsoundsubmix("_encstr_A7D11716F76F42B611A85B8FD8AB73AA970C1F4CD3BF4AC5DB", 2);

  foreach(var_12 in var_0)
  var_12 show();

  foreach(var_6 in level.players) {
    scripts\cp\laser_traps\cp_laser_traps::_id_12484(var_6);
    var_6 _id_12C5A();
  }

  playFX(level._effect["_encstr_978D144B18D9F183F3A769574ED923091D8893F269E3"], (-1434.42, -2929.26, 1105.3));
  scripts\engine\utility::delaycall(0.2, ::delete);
}

mountain_one_death_func() {}

_id_12C5A() {}

sixthsense_inotherplayertargetcone(var_0, var_1) {
  var_0 endon("_encstr_86EF0F6F49289BC7D0219D249EF010C270");
  var_2 = scripts\engine\utility::getStructArray("_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\cp\utility\entity::getaverageorigin(var_2)[2];

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(var_6.origin[2] <= var_3) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      break;
    }

    waitframe();
  }

  var_0 notify(var_1);
}

heli_spin() {
  self endon("_encstr_86EF0F6F49289BC7D0219D249EF010C270");

  for(;;) {
    self settargetyaw(self.angles[1] - 90);
    wait 1;
  }
}

trial_special_vfx() {
  while(!isDefined(level.agentarray) || level.agentarray.size < 10)
    waitframe();

  wait 1;
  var_0 = scripts\engine\utility::getStructArray("_encstr_8F17144B23DBA6D8F7F778119DA9215312A7F9F3B782", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, ::thermiteradiusdamage);
  var_1 = scripts\engine\utility::getStructArray("_encstr_B6AB0C5ACD3AE47BF5B2B9955BCB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_1, ::trial_rpg_settings);
}

thermiteradiusdamage() {
  var_0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

  if(isDefined(var_0)) {
    var_0 endon("_encstr_AD75063D571AE108");
    var_0 setentitytarget(level.trial_shooters, 1.0);
    scripts\engine\utility::flag_wait("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D");
    var_1 = scripts\engine\utility::getStructArray("_encstr_822D14BB7EC35BC7C9725818EA18EF33AB193CA0CD73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = sortbydistance(var_1, var_0.origin);
    var_0.ignoreall = 1;
    var_0.goalradius = 32;
    var_0 setgoalpos(var_1[0].origin);
    var_0 waittill("_encstr_8B7205D9ED5958");
    var_0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
  }
}

trial_rpg_settings() {
  level.trial_shooters endon("_encstr_86EF0F6F49289BC7D0219D249EF010C270");

  for(;;) {
    var_0 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_0)) {
      var_0.script_forcegoal = 1;
      var_0.dontevershoot = 1;
      var_0.solospawn = 1;
      var_0.goalradius = 20;
      self.rocketammo = 200;
      var_0 skipplaybodycountsound();

      if(scripts\engine\utility::flag("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D")) {
        if(isalive(var_0))
          var_0 thread skipleaderupdate(self);

        return;
      }
    }

    wait(randomfloatrange(1, 3));
  }
}

skipleaderupdate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  self.goalradius = 32;
  self.dontevershoot = 1;
  self setgoalpos(var_0.origin);
  self waittill("_encstr_8B7205D9ED5958");
  scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

skipplaybodycountsound() {
  level endon("_encstr_B63614D273A39CDEAF34561BD2D76CC9C2E60D96DC9D");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8B7205D9ED5958");
  self.dontevershoot = 0;
  self setentitytarget(level.trial_shooters, 1.0);
  self waittill("_encstr_AD75063D571AE108");
}

_id_1216D() {
  thread _id_1216B();
  thread _id_1216C();
  skipignoredamage();
}

_id_1216B() {
  wait 1.5;
  _id_12758("_encstr_BDD52791C37D1BE0CDFAB116CD9BEBC9CA6E8D5D56AFD0D996EB8C5633CAE6237D6C06DC2B8DBE8C81");
  wait 3.0;
  _id_12758("_encstr_812C2741D08FC8EFEB9F31333733A0884DEA29FB3F27C8A422B729338B7A7040DF52BBB3A743B97E8F");
  wait 5.0;
  _id_12758("_encstr_B25924191ED7D80ECDAF8DB0DCDCF5078D169B59BE59F0CCA5B17D1B85B923EBCDB0B3BE8918");
}

_id_1216C() {
  level endon("_encstr_8B96091B56589D59D7D8A7");
  var_0 = scripts\engine\utility::getStructArray("_encstr_8F1B0ECD900917C027088B92C0AD3F93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [0, 20, 30, 40, 50];
  var_2 = var_1[level.players.size];
  var_3 = 0.25;

  while(var_2 > 0) {
    var_4 = var_0[randomint(var_0.size)];
    var_5 = var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_5))
      var_2--;

    wait(var_3);
  }

  var_6 = [0, 15, 20, 25, 30];
  var_7 = var_6[level.players.size];
  var_8 = 2.0;

  for(;;) {
    if(getaiarray("_encstr_8E8405EA382B2A").size < var_7) {
      var_4 = var_0[randomint(var_0.size)];
      var_5 = var_4 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    }

    wait(var_8);
  }
}

skipignoredamage() {
  set_objective("_encstr_8A12060D5BA9C745");
  var_0 = getEnt("_encstr_973A13AC1E332DD8F5865963B4EBB90EC2DDCD5627", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.vehicletype = "_encstr_A7441001DAE2D308EB795F25317880A5FBD8";
  var_1 = var_0 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var_1 sethoverparams(0, 0, 0);
  var_1 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_8BC8103776908F37FB6B742B917B48B53F75", 3);
  objective_setdescription(var_2, &"_encstr_92D42D1FC8410928F784549DE83FF781F57FA585453E7963EBC86E85546BB0A1359723392E144150D730646F3907CE");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_onentity(var_2, var_1);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_3 dontinterpolate();
  var_4 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 linkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-144, 16, -192), (0, 0, 0));
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_3 dontinterpolate();
  var_4 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  var_3 linkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-144, -16, -192), (0, 0, 0));
  var_5 = getEnt("_encstr_A2821523B8B9EECA1F9FB5EE0303F3BF6368AF87109122", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 enablelinkTo();
  var_5 linkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_1 scripts\common\vehicle::godon();
  var_6 = 1500;
  var_7 = 0;

  for(;;) {
    var_8 = 1;

    foreach(var_10 in level.players) {
      if(!isalive(var_10)) {
        continue;
      }
      if(!var_10 istouching(var_5)) {
        var_8 = 0;
        break;
      }
    }

    if(var_8) {
      if(!var_7)
        var_7 = gettime();

      if(gettime() >= var_7 + var_6) {
        break;
      }
    } else
      var_7 = 0;

    waitframe();
  }

  objective_state(var_2, "_encstr_8267056410C669");

  foreach(var_13 in level.outofboundstriggers)
  var_13.origin = var_13.origin - (0, 0, 10000);

  scripts\engine\utility::flag_set("_encstr_8B96091B56589D59D7D8A7");

  foreach(var_10 in level.players) {
    if(!isalive(var_10)) {
      continue;
    }
    var_16 = var_10 scripts\engine\utility::spawn_tag_origin();
    var_16 linkTo(var_1);
    var_10 playerlinkTo(var_16, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 0, 180, 180, 180, 180, 0);
  }

  scripts\engine\utility::delaythread(2.0, ::_id_12758, "_encstr_B4AE224687BEADC1C2BEEADC8ED8F5EC166B95E6A32CD1567DD8F6E61DBE43CAC28D3A86");
  var_18 = 4.0;
  wait(var_18);
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

streampoint() {
  level.hacking_player_nearby = spawnStruct();
  level.hacking_player_nearby.civs = [];
  level.hacking_player_nearby.leader = undefined;
  level.hacking_player_nearby.light_tank_update = [];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange = [];
  level.hacking_player_nearby.light_tank_update["_encstr_834409AA94AB7AD3B9F5F7"] = ["_encstr_B8671721C89F7F0A98C30B6752CB632153B9577A5255435A56", "_encstr_8F6717910FBEB9BD1ABB5EF51B5A3BFA37D10BCB1AACC92B46"];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange["_encstr_834409AA94AB7AD3B9F5F7"] = 0;
  level.hacking_player_nearby.light_tank_update["_encstr_933E090A10B17DDFB3E135"] = ["_encstr_BAC5157FA0910B4582A3C2D9D60443B1080F09E325630B", "_encstr_A9C51523F07D6EDB86EE977DD85ACEBECCBDB163BDDD23", "_encstr_8CC515233CD7E6DB0DBB5ED7D85AD9F533EDB1B1F6DD66", "_encstr_B6C5155773EF633750D88F0F60A8E66965B7DDCD50174F"];
  level.hacking_player_nearby.light_tank_stopwatchingmissileinputchange["_encstr_933E090A10B17DDFB3E135"] = 0;
}

spawn_civ(var_0, var_1) {
  var_2 = var_0 scripts\cp\laser_traps\cp_laser_traps::_id_134F1("_encstr_8FA2137717D303D8A99ECD3E069809CD5AD7E3DD9B", var_0.origin, var_0.angles);

  if(isDefined(var_2)) {
    level.hacking_player_nearby.civs[level.hacking_player_nearby.civs.size] = var_2;

    if(isDefined(var_1.radius))
      var_2.goalradius = var_1.radius;
    else
      var_2.goalradius = 200;

    var_2 setgoalpos(var_1.origin);
    var_2 thread hacking_lua_notify_func();
    var_2 thread hackclientomnvarclamp();
  }
}

hacking_lua_notify_func() {
  level endon("_encstr_AF600952485C1737B0ABF4");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_818E10B9D1EDC1F56C5A67FA3A86E4ACC232");
}

hackclientomnvarclamp() {
  self waittill("_encstr_AD75063D571AE108");
  level.hacking_player_nearby.civs = scripts\engine\utility::array_remove(level.hacking_player_nearby.civs, self);
}

nextdest(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self.ignoreall = 1;
  self.script_pushable = 1;
  self.goalradius = 80;
  self setgoalpos(var_0.origin);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 20.0);
  scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

no_previous_interaction_point() {
  var_0 = scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08");
  var_0 = sortbydistance(var_0, self.origin);
  self.goalradius = 300;
  self setgoalpos(var_0[0].origin);
}

_id_12DB1() {
  var_0 = int(tablelookupbyrow("_encstr_A5EB3EFB4EEAD0A7E367EF7F033E61E88022E871321FC8D089337B0F7B83BFE067BE8B4E1A87F11BC2E77127778BE8E0CF9330A189F5B045FAC75337B272C608", level._id_12DB9, level.players.size));
  var_1 = scripts\engine\utility::getStructArray("_encstr_8F1B0ECD900917C027088B92C0AD3F93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 1.0;

  while(var_0 > 0) {
    var_3 = var_1[randomint(var_1.size)];
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var_4)) {
      var_0--;
      thread _id_12DA8(var_4);
    }

    wait(var_2);
  }
}

_id_12DA8(var_0) {
  var_1 = var_0.origin;
  wait 8.0;
  var_2 = squared(200);

  if(distance2dsquared(var_1, var_0.origin) > var_2) {
    return;
  }
  var_0 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}

_id_12DB6() {
  var_0 = int(tablelookupbyrow("_encstr_9A483F338E739F2AD9B0D62A9057A577EB6EE7DB9F7E4FB5E743BA62B80F9E4F68DE206FB6EDB7BC5360B27BE84B59ABD8BDB6CCD88997C571602A3290CD8ED713", level._id_12DB9, level.players.size));

  while(getaiarray("_encstr_8E8405EA382B2A").size > var_0)
    waitframe();
}

init_spawners() {
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("_encstr_8F1B0ECD900917C027088B92C0AD3F93", ::nodetype);
  scripts\cp\laser_traps\cp_laser_traps::array_spawn_function_targetname("_encstr_96ED149B6BBDDAB2D7ACE656DA5EFAE60758EE37B29C", ::_id_13420);
  var_0 = getEntArray("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3)
    var_5 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(::_id_1420C);
  }
}

nodetype() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  self endon("_encstr_AD75063D571AE108");
  waitframe();

  if(scripts\engine\utility::cointoss()) {
    self.grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
    self.grenadeammo = 255;
    self.grenadesafedist = 400;
    self.grenadeweapon.ammo = 255;
  }

  var_0 = scripts\engine\utility::getStructArray("_encstr_ABE213EB9B7291E06F6FF0CBD22199D63B43736F6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];

  if(self.origin[0] < -1100) {
    foreach(var_3 in var_0) {
      if(var_3.origin[0] < -1100)
        var_1[var_1.size] = var_3;
    }
  } else {
    foreach(var_3 in var_0) {
      if(var_3.origin[0] > -1100)
        var_1[var_1.size] = var_3;
    }
  }

  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var_1);
  scripts\cp\laser_traps\cp_laser_traps::go_to_node(var_3);
  var_7 = scripts\engine\utility::random(level.players);
  var_8 = distance(var_7.origin, self.origin);
  self.goalradius = var_8;
  self setgoalpos(var_7.origin);

  for(;;) {
    var_8 = var_8 - randomintrange(50, 300);
    var_8 = max(var_8, 400);
    self.goalradius = var_8;
    wait(randomfloatrange(3, 10));
  }
}

_id_13420() {
  level endon("_encstr_B8CE17F08B7DF7E9A1BAC34102178DDBD91A3E4A8412482A40");
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  self.grenadeweapon = getcompleteweaponname("_encstr_BA730BF8AFF178988293F158B9");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
  var_0 = scripts\engine\utility::getStructArray("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var_0);
  self.maxsightdistsqrd = 160000;
  self.goalradius = 400;
  scripts\cp\laser_traps\cp_laser_traps::go_to_node(var_1);
  wait(randomfloatrange(5, 10));
  var_2 = scripts\engine\utility::random(level.players);
  var_3 = distance(var_2.origin, self.origin);
  self.goalradius = var_3;
  self setgoalpos(var_2.origin);

  for(;;) {
    var_3 = var_3 - randomintrange(50, 300);
    var_3 = max(var_3, 400);
    self.goalradius = var_3;
    wait(randomfloatrange(3, 10));
  }
}

_id_12DAB(var_0) {
  var_1 = getEntArray("_encstr_A24414B6BDC9A3B027E6EBB93A58E4E8D7DAB723591B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 1.0;
  var_3 = 2.0;
  var_4 = _id_11D37();
  var_5 = scripts\engine\utility::random(var_4);

  for(var_6 = 0; var_6 < var_0; var_6++) {
    var_7 = randomfloatrange(var_2, var_3);
    wait(var_7);
    var_8 = scripts\engine\utility::random(var_1);
    var_9 = scripts\engine\utility::getStruct(var_8.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 = scripts\cp\laser_traps\cp_laser_traps::_id_134F1(var_9.script_type, var_9.origin, var_9.angles);

    if(!isDefined(var_10)) {
      continue;
    }
    var_10.ignoreall = 1;
    var_10.ignoreme = 1;
    var_10.stadium_two_death_func = 1;
    var_10 allowedstances("_encstr_B13D076BED70539F23");
    var_10.goalradius = 20;
    var_10 setgoalpos(var_10.origin);
    var_10.health = 1;
    var_10 scripts\cp\laser_traps\cp_laser_traps::disable_long_death();
    var_10.targetname = "_encstr_9A8E0EB5BDE44758396E7D2B37CAB65E";
    thread _id_11D35(var_10, var_8, var_5);
    var_1 = scripts\engine\utility::array_remove(var_1, var_8);

    if(isDefined(var_5))
      var_4 = scripts\engine\utility::array_remove(var_4, var_5);
  }
}

_id_11D37() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(_id_11D39(var_2))) {
      continue;
    }
    if(var_2 islinked()) {
      continue;
    }
    if(var_2 scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      continue;
    }
    if(var_2 scripts\cp_mp\killstreaks\chopper_gunner::isusingchoppergunner()) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  return var_0;
}

_id_11D3A(var_0, var_1) {
  var_0.update_hint_logic_juggernaut = var_1;
}

_id_11D39(var_0, var_1) {
  return var_0.update_hint_logic_juggernaut;
}

_id_11D35(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = scripts\engine\utility::getStructArray("_encstr_84691B05D78BE45E5E47F0CBFA708947D329FD39E85FF8C3E966DD6683", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_1.origin;
  var_5 = "_encstr_8DB00ED6B7278E2CC9EB2DB683B0D81D";
  var_6 = 2.0;
  var_7 = 1;
  var_8 = 3;
  var_9 = 5;
  var_10 = squared(500);

  if(isDefined(var_2))
    var_11 = var_2.origin;
  else
    var_11 = undefined;

  var_12 = 0.5;
  var_13 = 2.0;
  var_14 = randomfloatrange(var_12, var_13);
  wait(var_14);

  for(;;) {
    var_15 = isDefined(var_2) && (var_7 == 1 || var_7 >= var_8 || var_7 >= var_9);

    if(var_15)
      var_16 = var_2.origin;
    else {
      var_17 = scripts\engine\utility::random(var_3);
      var_16 = var_17.origin;
    }

    thread _id_11D36(var_1, var_4, var_16, var_5);
    level waittill(var_5, var_18);

    if(!isDefined(var_2) || !isalive(var_2)) {
      var_19 = _id_11D37();
      var_2 = scripts\engine\utility::random(var_19);

      if(isDefined(var_2))
        var_11 = var_2.origin;
    }

    if(isDefined(var_2)) {
      var_20 = distance2dsquared(var_11, var_2.origin) >= var_10;

      if(var_20) {
        var_7 = 1;
        var_11 = var_2.origin;
      }

      if(var_7 == 1) {
        var_2 shellshock("_encstr_822D103D758B39F30563D140CA9A8FF3D31C", 2.0);
        var_2 dodamage(3, var_18, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
      } else if(var_7 >= var_8) {
        var_2 shellshock("_encstr_822D103D758B39F30563D140CA9A8FF3D31C", 2.0);
        var_2 dodamage(20, var_18, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
      }

      if(var_7 >= var_9)
        var_2 dodamage(99999, var_18, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

      var_7++;
    }

    var_21 = max(1, _id_11D38().size);
    var_22 = var_21 * var_6;
    wait(var_22);
  }
}

_id_11D38() {
  return getEntArray("_encstr_9A8E0EB5BDE44758396E7D2B37CAB65E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_11D36(var_0, var_1, var_2, var_3) {
  thread scripts\engine\utility::play_sound_in_space("_encstr_A62911B6B7E4E80BC9EB332DE4B2BE46B4E6A3", var_1);
  physicsexplosionsphere(var_1, 350, 350, 200);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_4 setModel("_encstr_A103252B175D960EB6CA373AEBB6BD391D0B4EAF9B34AC36B1F52DD61C4EB7CE5ADC2B46BE60C4");
  var_5 = 0.15;
  wait(var_5);
  playFX(level._effect["_encstr_8E8D10E3F50BC15D506B034E43F99E7AE61B"], var_1, anglesToForward(var_0.angles));
  playFXOnTag(level._effect["_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"], var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = lookupsoundlength("_encstr_A3C20DD6EDC94716C9EB3A9CC25A1B") * 0.001 * 0.8;
  var_7 = max(0.05, 7 - var_6 - 0.5);
  var_4 scripts\engine\utility::delaycall(var_7, ::playsound, "_encstr_AF95102B9F7248572B29F8CDF20719E80DEF");
  var_8 = 0.00714286;
  var_9 = 0;

  while(var_9 < 1) {
    var_10 = var_4.origin;
    var_4.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, 2500, var_9);
    var_4.angles = vectortoangles(var_4.origin - var_10);
    var_9 = var_9 + var_8;
    waitframe();
  }

  var_4 stoploopsound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  level notify(var_3, var_4.origin);
  mortars_explodemortarprojectile(var_4, var_0);
}

mortars_explodemortarprojectile(var_0, var_1) {
  var_2 = var_0.origin;
  var_0 delete();
  physicsexplosionsphere(var_2, 2000, 1000.0, 150);
  var_3 = 0.24;
  var_4 = max(1, _id_11D38().size);
  var_5 = var_3 / var_4;
  earthquake(var_5, 1.0, var_2, 3000);
  playrumbleonposition("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", var_2);
  thread scripts\engine\utility::play_sound_in_space("_encstr_88FA177353CF60A7A86F868BEF525F20D99B81B9E340BABDDA", var_2);
  playFX(level._effect["_encstr_842E12A354404681982A3B07BA519F12FB232F3B"], var_2);
}

israndompistolloadouts() {}

set_objective(var_0) {
  if(!isDefined(level.weapondrop_createdropondeath)) {
    level.weapondrop_createdropondeath = [];
    level.weapondrop_createdropondeath["_encstr_AFE108E6AB93CED2EC59"] = 2;
    level.weapondrop_createdropondeath["_encstr_8A12060D5BA9C745"] = 3;
    setomnvar("_encstr_999B13469361F7B2BA430FABA35C0A0F08F83F4F0A", 1);
  }

  setomnvar("_encstr_AA6D19DF23D6C8819A2D8B55F0EC6A0FABE02A09531F424A2FCD9A", level.weapondrop_createdropondeath[var_0]);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

support_box_delay_max_ammo_hint() {
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B6A90B5ACD3AE47BF5B491B159"] = % _encstr_A3011E4F3B8BAFA8C8690B61CCBF88C62397CDEF3F63D570E471FB3EB46C408D;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_B6A90B5ACD3AE47BF5B491B159"] = "_encstr_A3011E4F3B8BAFA8C8690B61CCBF88C62397CDEF3F63D570E471FB3EB46C408D";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_B6A90B5ACD3AE47BF5B491B159"] = "_encstr_96490ED713F8593950480E0F73E1013B";
}