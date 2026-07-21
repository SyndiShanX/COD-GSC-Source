/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\objectives\cp_vault_assault.gsc
**************************************************************/

main() {
  level.vault_assault_objective_func = ::register_vault_assault_objectives;

  if(!isDefined(level.should_run_event_func))
    level.should_run_event_func = ::should_run_event;

  if(!isDefined(level.ambientgroupinit))
    level.ambientgroupinit = ::setup_module_groups;

  level._effect["_encstr_BAA70848249367CEC330"] = loadfx("_encstr_B25F2A0859EB66CCDF5827AAD75F28C3E149BBF8313243073B6BD5F729C79B5F1BB008DF69DCA5238663EB50");
  level._effect["_encstr_926C0836DCF23F7011A3"] = loadfx("_encstr_81302D930C50C7B318585993836011BBFD88FD5566C3411F33EF8FC3E26BB8AB91FB02FD67FAB08160B8B518AC4838");
  level._effect["_encstr_96AF09784EA14135B7492F"] = loadfx("_encstr_BE583D67CCF0BCB477E0BC0E4EB707F2CDC6E4A538E8B031C6CACD97CE663CD76CBD5B07BA1D5693BE0EB1AF3ADEDD2B27F5C04CD732AC9839A5CDE26733C3");
  level._effect["_encstr_A73F134B5DB379EFA8B0A1B6E3A135C30F4D678729"] = loadfx("_encstr_B63B2FEC33C3CBD2BB1CF55BE0CBACC5EAD20ED6CAB9A3CB6C1A97B3993CFAB3CACDF51B0DBE2BC3C18CAFD834713B990F");
  _encstr_A3383FCF423BBBBBD44317F0CA2EC88B601B05B7E83F5FE87A5FC35B4DB7A7260A9F26D30C8417B39A02095E34089B71F03F1519F0A3C380A1AED218FB2ADABB6B::heli_boss_precache();
  level thread scripts\cp\cp_remote_tank::init_remote_tank();
  level.bank_elevator = "_encstr_847206E88696E4C8";
  level.key_card_acquired = 0;
  level._id_12FC3 = 0;
  level.disable_hvt_pickup = ::lbravo_spawner_jammer2;
  level._id_1247C = ::_id_13F05;
  scripts\engine\utility::flag_init("_encstr_8CF509D843EC7E5F7A1DCD");
  scripts\engine\utility::flag_init("_encstr_BE730C64D1181181DDB5FFDF9FF5");
  scripts\engine\utility::flag_init("_encstr_B88017C82E734407D6226F8EB888ED23B3FBB3A966A34F8A28");
  scripts\engine\utility::flag_init("_encstr_995E13937BF666BE95D859B385D1ED4E7DBDE0CA9B");
  scripts\engine\utility::flag_init("_encstr_8A2D11B774CEBFC2066BFF1A934E21282DA928");
  scripts\engine\utility::flag_init("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");
  scripts\engine\utility::flag_init("_encstr_81221CE0D70F23A952E337807DEAD9AB947F403173CD79535B4B8D1E57B2");
  scripts\engine\utility::flag_init("_encstr_8F5913AB69D3AA66F1F3EA7FA3206F83D51FE71A5B");
  scripts\engine\utility::flag_init("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD");
  scripts\engine\utility::flag_init("_encstr_A7271216C6E8B4CE168E56BE8CBDDB27EB36AE47");
  _encstr_91B933B9C69C4B1C1D9BF28D38E5AD160EE6CB1B0E7D19DD9BBED1DDE6CB8DC1EBC8BBDCF53ABBB9FA19ED7B4EAF8DD5D117CEB91B::door_cut_precache();
  scripts\cp\cp_breach_c4::main();
  level thread init_cs_ents();
}

init_cs_ents() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag_exist("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23"))
    scripts\engine\utility::flag_init("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");

  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");

  if(!scripts\engine\utility::flag_exist("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0"))
    scripts\engine\utility::flag_init("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");

  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  level thread init_vault_door();
  var_0 = getEnt("_encstr_AF5E0E433BD1FA8C7B7B27BE6C36B438", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 disconnectPaths();
  level thread remove_extra_structs();
  var_1 = scripts\engine\utility::getStructArray("_encstr_B8371A8B08C863F9F5A0C5BF80E3133E70C8DF37E846B28233488B77", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  level thread scripts\cp\cp_munitions::_id_12BE1(var_3.origin, 200);

  level.rooftop_1_mortar = getEnt("_encstr_9BEF16F69B75FB293AB81F8CED38E3277A69E098B24D218B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.rooftop_2_mortar = getEnt("_encstr_B865164EF9A0BB39FE1F072B412893D7EA86059573887923", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.rooftop_3_mortar = getEnt("_encstr_A9BF16222930A7D980C74F4ED9405A2FC686AA7AD395474A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.rooftop_1_mortar hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  level.rooftop_2_mortar hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  level.rooftop_3_mortar hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
}

lbravo_spawner_jammer2(var_0) {
  var_1 = var_0.player;
  var_2 = 0;
  var_3 = var_0.stepstructs.size;
  var_4 = 90000;
  objective_setplayintro(var_0.id, 0);

  for(var_5 = var_3 - 1; var_5 >= var_2; var_5--) {
    if(var_5 > 0) {
      var_6 = distancesquared(var_1.origin, var_0.stepstructs[var_5]);
      var_7 = distancesquared(var_0.stepstructs[var_5], var_0.stepstructs[var_5 - 1]);

      if(var_6 < var_7) {
        var_8 = var_0.stepstructs[var_5][2] + 50;
        var_9 = var_0.stepstructs[var_5 - 1][2] - 50;

        if(var_1.origin[2] <= var_8 && var_1.origin[2] >= var_9)
          return var_5;

        var_8 = var_0.stepstructs[var_5 - 1][2] + 50;
        var_9 = var_0.stepstructs[var_5][2] - 50;

        if(var_1.origin[2] <= var_8 && var_1.origin[2] >= var_9)
          return var_5;
      }
    }
  }

  return 0;
}

create_stair_doors() {
  wait 5;
  level.bank_stair_doors = [];
  level.bank_stair_doors_clip = [];
  var_0 = ["_encstr_93860DCD8E854B27AF91EDEDC9D746", "_encstr_A1860D9BBB10E8CBEF12F7C75611FA", "_encstr_8D1D106ED1855A39AF91DE7BE4D74EB77BCC", "_encstr_88FE0F1B51794A60098837CF06665A89A7", "_encstr_ACFE0F4BD8BB2CBB86550F3776AEF6F945", "_encstr_A6FE0F479370E03389BCA04803FF035142", "_encstr_B8FE0F90DB6928E509EF58504221A35682", "_encstr_AF631253EBD7CFF289B1EFE775613A0F080129CF"];

  foreach(var_2 in var_0) {
    create_door(var_2);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("_encstr_8A2D11B774CEBFC2066BFF1A934E21282DA928");
}

create_door(var_0) {
  var_1 = getEntArray("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3[0];

  if(isDefined(var_4)) {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_5.angles = var_4.angles;
    wait 0.1;
    var_5 setModel("_encstr_84461EC9BFF23EF17D4F9309356760F80BE3A143E78A10B0B7F253C69F12502B");
    var_5.open_ang = (0, 105, 0);
    level.bank_stair_doors[var_0] = var_5;

    if(isDefined(var_2)) {
      var_6 = scripts\engine\utility::getStructArray(var_0 + "_encstr_82DF06F1168568CF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_7 = var_6[0];
      var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7.origin);
      var_8.angles = var_7.angles;
      var_8 clonebrushmodeltoscriptmodel(var_2);
      var_8 disconnectPaths();
      level.bank_stair_doors_clip[var_0] = var_8;
    }
  }
}

create_door_clip() {
  wait 5;
  level.bank_roof_doors_clip = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_93D114DD798D48A09BF210BB192B60B027EF6749E972", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];
  var_3 = "_encstr_BE1132DFB71B8BC03C1619D03F2FE036B307512957C2C1207F2FA088E2C7D87DAB8FF1F7A71A98E89447AE2141F07AB832BB6B23";
  var_4 = getentitylessscriptablearrayinradius(var_3, "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_6 in var_4)
  var_6 setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_ADB209DDA0A3209B828060");

  foreach(var_9 in var_0) {
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9.origin);
    var_10.angles = var_9.angles;
    var_10 clonebrushmodeltoscriptmodel(var_2);
    var_10 disconnectPaths();
    level.bank_roof_doors_clip[level.bank_roof_doors_clip.size] = var_10;
  }
}

connect_doorway_paths() {
  if(scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_wait("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  var_0 = ["_encstr_88291C7BEFA9F1A46B18F85D2F3F63DA28BBB83C22E7ABBFF81BE252F9B2", "_encstr_91C41F68A22E273093573C214F977BFF921B6030AB4979286782A8AE54F763372A", "_encstr_81291C84CF58491A1CAAEABB58EB5DF00B9B39EA102FF307D77908417132", "_encstr_8FC41FBB03D0156BE536822A1848C3C1B8D9213985899F27188B29C280938389F2"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3)) {
      var_3 connectpaths();
      var_3 notsolid();
    }

    wait 0.1;
  }
}

prox_open_door(var_0) {
  var_1 = level.bank_stair_doors[var_0];

  for(;;) {
    if(distance(level.players[0].origin, var_1.origin) < 100) {
      open_door(var_0);
      return;
    }

    wait 0.1;
  }
}

open_door(var_0) {
  var_1 = level.bank_stair_doors[var_0];
  var_2 = level.bank_stair_doors_clip[var_0];
  var_1 rotateTo(var_1.angles + var_1.open_ang, 0.25);

  if(isDefined(var_2)) {
    var_2 connectpaths();
    var_2 notsolid();
  }
}

remove_extra_structs() {
  if(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"].size > 1) {
    var_0 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"][0];

    for(var_1 = 0; var_1 < level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"].size; var_1++) {
      if(isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"][var_1].classname_mp))
        var_0 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"][var_1];
    }

    level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"] = [];
    level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8A1A0DABC86BF837D338F5F04C58DB"][0] = var_0;
  }
}

register_vault_assault_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!istrue(level.vault_assault_objectives_registered))
    level.vault_assault_objectives_registered = 1;
  else
    return;

  scripts\cp\cp_objectives::registerobjective("_encstr_A3531B14767BF1AB7F9F8890878D6009215A059D0A12BB932D4F800837", ::team_planted_bomb, ::_id_13829, ::hiding_munitions_purchase, ::debugbeatobjective, ::isshuttingdown);
  scripts\cp\cp_objectives::registerobjective("_encstr_82390E2DA1E3D88DCFBACBF3825F49D0", ::init_vault_assault, ::start_vault_assault, ::end_vault_assault, ::debugbeatobjective, ::debug_vault_assault_obj_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_B88B12BB62A759C8B101BFB72963501D673A5363", ::init_vault_assault_cut, ::start_vault_assault_cut, ::end_vault_assault_cut, ::debugbeatobjective, ::debug_vault_assault_cut);
  scripts\cp\cp_objectives::registerobjective("_encstr_849914147FC3C23C384EC318E73B30BBC90C596071E8", ::init_vault_assault_vault, ::start_vault_assault_vault, ::end_vault_assault_vault, ::debugbeatobjective, ::debug_vault_assault_vault);
  scripts\cp\cp_objectives::registerobjective("_encstr_B4D81D93BFFBD26CF628E7FF30EB3C1BD74CDECB91513986D950B74778A0EC", ::init_vault_assault_vault_fake_end, ::start_vault_assault_vault_fake_end, ::end_vault_assault_vault_fake_end, ::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_A627153BB0EAD8A37D2CB96EC2BAD847AFC693CBC147F6", ::init_vault_assault_crypto, ::start_vault_assault_crypto, ::end_vault_assault_crypto, ::debugbeatobjective, ::debug_vault_assault_crypto);
  scripts\cp\cp_objectives::registerobjective("_encstr_911F1603980DB02187A8BB03EA756DC8AF5517D81E5B8DE3", ::init_vault_assault_rooftop, ::start_vault_assault_rooftop, ::end_vault_assault_rooftop, ::debugbeatobjective, ::debug_vault_assault_roof_obj_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_95DC1BCB5E7D6835E19FC7CFB76B71F03FF2906007C4B8EF19A3D3E9EF", ::init_vault_assault_rooftop_heli, ::start_vault_assault_rooftop_heli, ::end_vault_assault_rooftop_heli, ::debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_A33B1DC56227B1ABFF01AF708E47E8A1193B158758149DD06929E14A5B35B1", ::init_vault_assault_rooftop_defend, ::start_vault_assault_rooftop_defend, ::end_vault_assault_rooftop_defend, ::debugbeatobjective, ::debug_vault_assault_roof_defend_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_95B41C53DA4BB07B40AE4F4A4F8538906978EFD25D9568E8618D61DF102C", ::init_vault_assault_rooftop_exfil, ::start_vault_assault_rooftop_exfil, ::end_vault_assault_rooftop_exfil, ::debugbeatobjective, ::debug_vault_assault_roof_defend_start);
  init_bank_interactions();
  spawn_functions_init();
}

register_ml_p1_objectives() {}

spawn_functions_init() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.ambientgroups))
    level.ambientgroups = [];

  if(!isDefined(level.active_spawn_modules))
    level.active_spawn_modules = [];

  level thread register_spawn_functions();
}

register_spawn_functions() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23"))
    scripts\engine\utility::flag_init("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");

  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_995A11130BE6B6BE8DDE5B1385D1EB0D95B1D2", 0, 6, undefined, [::short_and_long_delay, 0.05, 5], undefined, "_encstr_995A11130BE6B6BE8DDE5B1385D1EB0D95B1D2");
  _id_12AE4();
  _id_12AD5();
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82171B4C2CCDB57D3B590DB48DC659EB9C2BA5B9CCDE39B156DA59DC3A", 0, 16, undefined, scripts\cp\cp_modular_spawning::module_wave_spawn, undefined, "_encstr_82171B4C2CCDB57D3B590DB48DC659EB9C2BA5B9CCDE39B156DA59DC3A");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A2B1104C0BDC5B7D6CF65B4C2CD1D743673A", 1, 1, 1, 0.1, undefined, "_encstr_A2F209ADEF8ADA8910E30B");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2B1104C0BDC5B7D6CF65B4C2CD1D743673A", ::hvt_think_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BE421232FF80E7918740E20A28F1D9DBD95DB4BC", 3, 3, 3, 0.1, undefined, "_encstr_BE421232FF80E7918740E20A28F1D9DBD95DB4BC");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A2DD174CC2B9B57D8DF65B98B08E7DEC0BEA363AD7DD58CE2B", 0, 20, 100, [::spawn_wave, 0.1, 45], undefined, ["_encstr_875E0E3962CBDA91BE0F83952923C9BE", "_encstr_8E8513DAF0252C8F81508DBA7F4BC7621F08123248", "_encstr_BA1513495E6650A022A7FBEDB77BE8CA3FF651E144"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B4DA1896BFCDA24771589FBB30CB0F4A814EDCCB11075A8ED8A8", 0, 6, 6, 0.1, undefined, "_encstr_B4DA1896BFCDA24771589FBB30CB0F4A814EDCCB11075A8ED8A8");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8BA711228A201F075805DD39C77B8FADB8F702", 6, 10, undefined, 0.1, undefined, "_encstr_8BA711228A201F075805DD39C77B8FADB8F702");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8BA711228A201F075805DD39C77B8FADB8F702", ::_id_12D84);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8EBF172658CDB67D277BB733D735579D76564EE62CBAD17DC4", 1, 1, 1, 0.1, undefined, "_encstr_8EBF172658CDB67D277BB733D735579D76564EE62CBAD17DC4");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8EBF172658CDB67D277BB733D735579D76564EE62CBAD17DC4", ::roof_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B8BF17712A8382C9B247FFD54F9C505C7F828B78B2474591DA", 1, 1, 1, 0.1, undefined, "_encstr_B8BF17712A8382C9B247FFD54F9C505C7F828B78B2474591DA");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B8BF17712A8382C9B247FFD54F9C505C7F828B78B2474591DA", ::roof_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9729168223903C975E182A22212D5FB240973E37ABF8C463", 6, 6, 6, 0.1, undefined, "_encstr_9729168223903C975E182A22212D5FB240973E37ABF8C463");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B6911FA7B7A08715B506FAEE722489AECDA96", 3, 3, 3, 0.1, undefined, "_encstr_9B6911FA7B7A08715B506FAEE722489AECDA96");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_83931A7ADB68C45F96C0E21A6975277C5859F9FF55B80D735098DA33", 6, 6, 6, 0.1, undefined, ["_encstr_ADE31899C26B7A311EAF6375C98369B3EFAA70A61B97A03039E9", "_encstr_81E31802A310BC17DE98AAA2A1ADDFB49011B1B71D70C5ABE81B"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B16E1BE651081381DEB7D7D3937DC95808985C21ABA8AFCA3851CFCFE9", 6, 6, 6, 0.1, undefined, ["_encstr_AAE318091E2610E062E7BBADF73B28D0C5B59026429F7824D98E", "_encstr_96E318CE12722FB94AE7F55801DB8163BF64E309A23758299153"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B8431C7E16AA9FAE328748185F6821E5E2FBEE706DA35B331B2F78689798", 6, 6, 6, 0.5, 0, "_encstr_B8431C7E16AA9FAE328748185F6821E5E2FBEE706DA35B331B2F78689798");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8EC01B1B53B83AD71090ADF78ED8316387C1D3B727DF82B2307E65BDA3", 6, 6, 6, 0.5, 0, "_encstr_8EC01B1B53B83AD71090ADF78ED8316387C1D3B727DF82B2307E65BDA3");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A11119B0B23D7F4613CE8568BA0F093FA72B68206B53DF1B27C98D", 1, 1, 1, 0.1, undefined, "_encstr_A11119B0B23D7F4613CE8568BA0F093FA72B68206B53DF1B27C98D");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A11119B0B23D7F4613CE8568BA0F093FA72B68206B53DF1B27C98D", ::hvt_jugg_skit_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_848E140AAB18B40F43B3C379D825376FE8358E91EBB0", 1, 1, 1, 0.1, undefined, "_encstr_848E140AAB18B40F43B3C379D825376FE8358E91EBB0");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_848E140AAB18B40F43B3C379D825376FE8358E91EBB0", ::hvt_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF1B19ABE328AA4780E0DD671EA89693686D7F0747C5433E308B13", 1, 1, 1, 0.1, undefined, "_encstr_AF1B19ABE328AA4780E0DD671EA89693686D7F0747C5433E308B13");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AF1B19ABE328AA4780E0DD671EA89693686D7F0747C5433E308B13", ::roof_jugg_logic);

  if(!scripts\engine\utility::flag_exist("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B"))
    scripts\engine\utility::flag_init("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");

  scripts\engine\utility::flag_set("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");
  scripts\engine\utility::flag_set("_encstr_81221CE0D70F23A952E337807DEAD9AB947F403173CD79535B4B8D1E57B2");
}

_id_12AD5() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD", 0, 14, undefined, 0.1, undefined, "_encstr_875E0E3962CBDA91BE0F83952923C9BE");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A", 0, 14, undefined, 0.1, undefined, "_encstr_8E8513DAF0252C8F81508DBA7F4BC7621F08123248");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66", 0, 14, undefined, 0.1, undefined, "_encstr_BA1513495E6650A022A7FBEDB77BE8CA3FF651E144");
  var_0 = ["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_BA730BF8AFF178988293F158B9", "_encstr_92A70ABB8267F5E0D89F6351", "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683"];
  var_1 = [0.5, 0.1, 0.1, 0.1];
  scripts\cp\cp_spawning_util::_id_12AE3("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD", var_0, var_1);
  scripts\cp\cp_spawning_util::_id_12AE3("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A", var_0, var_1);
  scripts\cp\cp_spawning_util::_id_12AE3("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66", var_0, var_1);
}

_id_12AE4() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A57A1595FF2B4920D7D6FBF3FEC5D8FD217315D3CB720E", 1, 1, 1, 0.1, undefined, "_encstr_A57A1595FF2B4920D7D6FBF3FEC5D8FD217315D3CB720E", ::tarmac_techo_start_first);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A57A1595FF2B4920D7D6FBF3FEC5D8FD217315D3CB720E", ::keypad_activate_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B155118DCFAAFAA93B85C8212EF47123421729", 0, 24, 24, 0.1, undefined, "_encstr_B155118DCFAAFAA93B85C8212EF47123421729", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF", 2, 2, 2, 0.1, undefined, "_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF", 2, 2, 2, 0.1, undefined, "_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513", 4, 4, 4, 0.1, undefined, "_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF", 0, 24, undefined, 0.1, undefined, "_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D7217B2D7F584D06230B5C19028D9FB79086820E71A3BA964", 1, 1, 1, 0.1, scripts\cp\cp_modular_spawning::_id_14340, "_encstr_8D7217B2D7F584D06230B5C19028D9FB79086820E71A3BA964", undefined, "_encstr_83C41A4C0B735BEB6C7BB6C4168EFAD9C2AE1B3AAF4CBDB5C49593CD");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_83C41A4C0B735BEB6C7BB6C4168EFAD9C2AE1B3AAF4CBDB5C49593CD", 0, 8, undefined, 0.1, undefined, "_encstr_AF2114AA77086F697FC87A82907951F380E932251673");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A54E17F1AA03024976C77B5DF19B8154E703C8BBD18B4B88CD", 0, 8, undefined, 0.1, undefined, "_encstr_BD5E0ECB488823B997E005FEDF9171A2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A54E17F1AA03024976C77B5DF19B8154E703C8BBD18B4B88CD", [scripts\cp\cp_modular_spawning::_id_11CAD, (22374, -19506, -197)]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A54E17F1AA03024976C77B5DF19B8154E703C8BBD18B4B88CD", [scripts\cp\cp_modular_spawning::_id_11CAC, 512]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF0913796E56609072F78B9DE72BD8E0F202817315", 0, 8, 8, 0.1, undefined, "_encstr_AF0913796E56609072F78B9DE72BD8E0F202817315");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA", 6, 6, 6, 0.1, undefined, "_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA", [::show_player_clip, (24538, -17807, -135), (0, 215, 0)]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_87A2169310D04BD1EF986DA6F7B9A901B8C843DFA0E9BB5A", 4, 4, 4, 0.1, undefined, "_encstr_87A2169310D04BD1EF986DA6F7B9A901B8C843DFA0E9BB5A");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_93B4167537520241A31D6099869C094BEABFC187FB0A5C20", 2, 2, 2, 0.1, undefined, "_encstr_93B4167537520241A31D6099869C094BEABFC187FB0A5C20");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AD6517C20FD2B209C3604D0DABB1614CF5981B1155D8305BA3", 11, 11, 11, 0.1, undefined, "_encstr_AD6517C20FD2B209C3604D0DABB1614CF5981B1155D8305BA3");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5", 0, 10, 5, 0.1, undefined, "_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8E63177388A3B2F0AF32DF4B5124538B8FE3A76FE690B5A0B4", 0, 10, 5, 0.1, undefined, "_encstr_8E63177388A3B2F0AF32DF4B5124538B8FE3A76FE690B5A0B4");
  var_0 = [scripts\cp\cp_modular_spawning::module_wave_spawn, 15, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_96420CDAA6E55826590A4D7E2983", 0, 12, undefined, var_0, undefined, "_encstr_BD5E0ECB488823B997E005FEDF9171A2", [::show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF2114AA77086F697FC87A82907951F380E932251673", 0, 8, 16, var_0, undefined, "_encstr_AF2114AA77086F697FC87A82907951F380E932251673", [::show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  var_0 = [scripts\cp\cp_modular_spawning::module_wave_spawn, 10, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC6617780A32BFE1E77F954A4F331FC2584AD077C391B3A999", 0, 16, undefined, var_0, undefined, "_encstr_BD5E0ECB488823B997E005FEDF9171A2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC6617780A32BFE1E77F954A4F331FC2584AD077C391B3A999", [scripts\cp\cp_modular_spawning::_id_11CAD, (22743, -20318, 187)]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC6617780A32BFE1E77F954A4F331FC2584AD077C391B3A999", [scripts\cp\cp_modular_spawning::_id_11CAC, 512]);
  var_1 = scripts\engine\utility::getStruct("_encstr_91830D2679A3709FFD0A60C14395BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D7217B2D7F584D06230B5C19028D9FB79086820E71A3BA964", [scripts\cp\cp_modular_spawning::set_initial_goalheight, "_encstr_9782123B2CEA36A3BE46BD7B27FA9839BDAD599B"]);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("_encstr_B155118DCFAAFAA93B85C8212EF47123421729", scripts\cp\cp_modular_spawning::set_heavy_hitter);
  scripts\cp\cp_spawning_util::register_module_init_func("_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5", ::_id_13F15);
  balloon_deposit_cash_nags("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  balloon_deposit_cash_nags("_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5");
  balloon_deposit_cash_nags("_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5");
  balloon_deposit_cash_nags("_encstr_AF0913796E56609072F78B9DE72BD8E0F202817315");
  balloon_deposit_cash_nags("_encstr_B155118DCFAAFAA93B85C8212EF47123421729");
  balloon_deposit_cash_nags("_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF");
  balloon_deposit_cash_nags("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
  balloon_deposit_cash_nags("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");
  balloon_deposit_cash_nags("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA");
  balloon_deposit_cash_nags("_encstr_87A2169310D04BD1EF986DA6F7B9A901B8C843DFA0E9BB5A");
  balloon_deposit_cash_nags("_encstr_93B4167537520241A31D6099869C094BEABFC187FB0A5C20");
  balloon_deposit_cash_nags("_encstr_AD6517C20FD2B209C3604D0DABB1614CF5981B1155D8305BA3");
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF", undefined, 2500, 10000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_96420CDAA6E55826590A4D7E2983", undefined, 2500, 5000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AF2114AA77086F697FC87A82907951F380E932251673", undefined, 2500, 5000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B155118DCFAAFAA93B85C8212EF47123421729", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_87A2169310D04BD1EF986DA6F7B9A901B8C843DFA0E9BB5A", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_93B4167537520241A31D6099869C094BEABFC187FB0A5C20", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AD6517C20FD2B209C3604D0DABB1614CF5981B1155D8305BA3", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513", undefined, 2500, 25000, undefined);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("_encstr_B155118DCFAAFAA93B85C8212EF47123421729", [scripts\cp\cp_modular_spawning::group_fallback_to_pos, var_1.origin]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513", [scripts\cp\cp_modular_spawning::set_heavy_hitter, 128]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B155118DCFAAFAA93B85C8212EF47123421729", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF", ::mark_never_remove);
}

_id_13F15(var_0) {
  var_0 thread _id_13F16(var_0);
}

_id_13F16(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::ent_flag_wait("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  for(var_1 = 0; var_1 < var_0.module_vehicles.size; var_1++)
    var_0.module_vehicles[var_1] _id_13F13();
}

_id_13F13() {
  self vehicle_setspeedimmediate(0, 30, 30);
  scripts\common\vehicle::vehicle_unload();
}

show_players_breadcrumbs_to_safe_house(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, var_1, var_2, scripts\cp\cp_modular_spawning::mp_hideout_patch);
}

show_player_clip(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, "_encstr_92F91B281EFA51FDB7D553126DB11BE827E4A208E85DDE43869695F877");
}

mp_aniyah_patch() {
  self endon("_encstr_92F91B281EFA51FDB7D553126DB11BE827E4A208E85DDE43869695F877");
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\cp\cp_modular_spawning::mp_hideout_patch();
}

balloon_deposit_cash_nags(var_0) {
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func(var_0, scripts\cp\cp_modular_spawning::_id_1309B);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, ::give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, ::alert_when_see_player);
}

give_guy_pacifist_override(var_0) {
  self.pacifist_override = 1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 250000);
}

alert_when_see_player(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  return_when_cansee_player();

  foreach(var_2 in var_0.ai_spawned)
  var_2 notify("_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
}

return_when_cansee_player() {
  self endon("_encstr_8F0514DA5ADC9B96B773D7367BD6389CB7AD4BCD9532");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");

  for(;;) {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 1024);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(self cansee(level.players[var_1]))
        return;
    }

    wait 0.25;
  }
}

players_entered_bank(var_0) {}

spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);
  var_4 = min(var_4, 24);
  return var_4;
}

spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "_encstr_922406B1A6FD5E05")) {
      if(issubstr(var_1.type, "_encstr_A5AD0568019C63"))
        var_2 = var_2 + (0, 90, 0);
      else if(issubstr(var_1.type, "_encstr_8253061E2B5FE330") || issubstr(var_1.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_1.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_1.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
        var_2 = var_2 - (0, 90, 0);
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
  } else {}
}

spawn_wave(var_0, var_1, var_2, var_3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var_0, var_1, var_2, var_3);
}

end_p1_spawn_loop(var_0) {
  level waittill("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level notify("_encstr_96AD06373AB7837D" + var_0 + "_encstr_A3850616E56F783F");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
}

p1_intel_death_func() {
  self.spawner scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\cp\cp_escalation::increase_escalation_counter();
}

watch_for_spawn_min_required(var_0, var_1, var_2, var_3) {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 1)
    return 0;

  var_4 = var_2 - scripts\cp\cp_modular_spawning::get_requested_spawn_count(var_0.moduleid);
  var_4 = clamp(var_4, 0, var_2);

  if(var_4 <= 0)
    return 0;

  var_5 = int(min(clamp(var_1, 0, var_4), var_1));
  return var_5;
}

wait_after_max_spawn(var_0, var_1, var_2, var_3) {}

reset_active_count(var_0) {
  var_0.activecount = 0;
  var_0.currentmodulekills = 0;
}

isshuttingdown(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_95FA1AD92CBA631DF5589BB92CBA1B47EB91B226BA3BF5DC1D0B9C1D");
}

debug_vault_assault_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_95FA1AD92CBA631DF5589BB92CBA1B47EB91B226BA3BF5DC1D0B9C1D");
}

debug_vault_assault_cut(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A98B1EE0115B5A83EF579B26B885CC0D9F6FA3F389FFDA9B18478192E1686269");
}

debug_vault_assault_vault(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A98B1EE0115B5A83EF579B26B885CC0D9F6FA3F389FFDA9B18478192E1686269");
}

debug_vault_assault_crypto(var_0) {
  scripts\cp\cp_spawning_util::_id_13BBD(0);
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A10821EBA135238B6163DBC37B68D50B489923832B0DF7895043C2CD1F11DAF38F133B");
}

debug_vault_assault_roof_obj_start(var_0) {
  debug_trigger_objective_events(var_0);

  while(!isDefined(level.heli))
    wait 0.1;

  level.heli waittill("_encstr_88900C8656D84BD7B185B932598C");
  level thread heli_force_search();
  scripts\engine\utility::flag_set("_encstr_8CF509D843EC7E5F7A1DCD");
  scripts\engine\utility::flag_set("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_883A26D379E8A8732727303BEB6B58C3E912C4D7BDCA2CD79BC761B8C0B18247901FAF171D58B387");
}

debug_vault_assault_roof_defend_start(var_0) {
  wait 5;
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_883A26D379E8A8732727303BEB6B58C3E912C4D7BDCA2CD79BC761B8C0B18247901FAF171D58B387");
}

debug_vault_assault_roof_exfil_start(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_883A26D379E8A8732727303BEB6B58C3E912C4D7BDCA2CD79BC761B8C0B18247901FAF171D58B387");
}

delay_debug_roof_start() {
  if(isDefined(level.spawned_enemies)) {
    foreach(var_1 in level.spawned_enemies)
    var_1 dodamage(var_1.health + 1000, var_1.origin);
  }

  level.ambient_spawning_paused = 1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
  level notify("_encstr_B2501A58D910EF09294D0A1F03CFE4E7AA8889ABD0EFA815485D6195");
  wait 5;
  level.ambient_spawning_paused = undefined;
  level.bank_elevator = "_encstr_AD1F054EBDED33";
}

debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\engine\utility::flag_set("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\engine\utility::flag_wait("_encstr_81221CE0D70F23A952E337807DEAD9AB947F403173CD79535B4B8D1E57B2");

  switch (var_0.ref) {
    case "_encstr_A33B1DC56227B1ABFF01AF708E47E8A1193B158758149DD06929E14A5B35B1":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      break;
    case "_encstr_95DC1BCB5E7D6835E19FC7CFB76B71F03FF2906007C4B8EF19A3D3E9EF":
    case "_encstr_911F1603980DB02187A8BB03EA756DC8AF5517D81E5B8DE3":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      init_vault_assault_crypto();
      break;
    case "_encstr_A627153BB0EAD8A37D2CB96EC2BAD847AFC693CBC147F6":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      level thread delay_then_run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", 5);
      break;
    case "_encstr_849914147FC3C23C384EC318E73B30BBC90C596071E8":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      break;
    case "_encstr_B88B12BB62A759C8B101BFB72963501D673A5363":
      spawn_static_trucks();
      init_vault_assault();
      level thread scriptable_carriable_damage_internal();
      break;
    case "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0":
      level thread scriptable_carriable_damage_internal();
      break;
    default:
      break;
  }

  level thread _id_12BC4();
}

scriptable_carriable_damage_internal() {
  while(!isDefined(level.players))
    wait 0.1;

  while(level.players.size < 1)
    wait 0.1;

  wait 2;
  var_0 = 0;

  while(!var_0) {
    foreach(var_2 in level.players) {
      if(var_2.model != "_encstr_B40101") {
        _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::script_struct_add(var_2);
        return;
      }
    }

    wait 0.1;
  }
}

_id_12BC4() {
  if(!isDefined(level.littlebirds))
    level waittill("_encstr_BD8C1BC56B09A384410973A7989953D9F1F0CD3FD86F9BD12BA857B318");

  var_0 = scripts\engine\utility::getStruct("_encstr_AF2E0C3B0F4F098C87439F7F063C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.radius;
  var_2 = var_1 * var_1;

  foreach(var_4 in level.littlebirds) {
    if(distance2dsquared(var_4.origin, var_0.origin) < var_2)
      var_4 delete();
  }
}

debugbeatobjective(var_0) {}

init_pre_vault_assault(var_0, var_1) {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
}

start_pre_vault_assault(var_0, var_1) {
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\engine\utility::flag_set("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  scripts\engine\utility::flag_set("_encstr_A15B0B8154473327910A282832");
  scripts\engine\utility::flag_set("_encstr_B66F144ECA8EEAC9CDEBD1B77D3785CCB21AB75DDC56");
  _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::_id_1234E(var_0);
  level waittill("_encstr_A25A1158A2EADF10FF26E0EE05DBD94793CA88", var_2);
}

team_planted_bomb(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E56(getEntArray("_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  init_out_of_bounds_triggers();
  level.default_player_spawns = "_encstr_A24E1A8B93F58A3CB911EAF209B07C43583B63536B9161F3C879A23B";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_A24E1A8B93F58A3CB911EAF209B07C43583B63536B9161F3C879A23B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A24E1A8B93F58A3CB911EAF209B07C43583B63536B9161F3C879A23B");
  _id_140F4();
  level thread _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::_id_1234E(var_0);
  level.initlethalmaxoffsetmap = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  scripts\engine\utility::flag_init("_encstr_A9B60CB2B956B597D7C2B12BE48E");
  scripts\cp\utility::skydivestreamhintdvars("_encstr_B47A06BDB537ABF6");
  spawn_static_trucks();
}

init_out_of_bounds_triggers() {
  var_0 = scripts\engine\utility::getStruct("_encstr_8D211D7339ADAB03D9EB434B83E04DB3C0F07A8A210807FB01F74D2C936893", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121");
  var_2 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_3 linkTo(var_1);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 35));
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BACF179F48C189254390945D1EF7F581ABEF390FC17F21ED63", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BECC055CF3811A", 256, 75, 128, 75);
  var_4.headicon = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_4.headicon, "_encstr_B10119D463E897520E670BD7472DABF638AB0E5DDE9875EADF0F03");
  setheadicondrawthroughgeo(var_4.headicon, 0);
  setheadiconsnaptoedges(var_4.headicon, 1024);
  setheadiconmaxdistance(var_4.headicon, 256);
  addclienttoheadiconmask(var_4.headicon, -5);
  var_1.collision = var_3;
  var_1.interaction = var_4;
  var_4 thread scripts\mp\brclientmatchdata::getnextcombatareaid(var_1);
}

tarmac_techo_start_first(var_0) {
  scripts\engine\utility::flag_init("_encstr_87FE15E8423F7B20CFDC8673A64FAB4F220B1090DA17A9");
}

keypad_activate_func(var_0) {
  level.stepstructsproximity = self;
  self.nocorpse = 1;
  scripts\engine\utility::flag_set("_encstr_87FE15E8423F7B20CFDC8673A64FAB4F220B1090DA17A9");
}

_id_140F4() {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A57A1595FF2B4920D7D6FBF3FEC5D8FD217315D3CB720E");
}

_id_13829(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8D7217B2D7F584D06230B5C19028D9FB79086820E71A3BA964");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B155118DCFAAFAA93B85C8212EF47123421729");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_860D15424950C7B968A7EDEA5338711788E09B1970B9BF");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B82A178EE65A6F5ED317C88817FC96A3820C7D98FEE2ED41AA");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_96420CDAA6E55826590A4D7E2983");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AF2114AA77086F697FC87A82907951F380E932251673");
  level thread _id_135CC("_encstr_9712124CB01BDA91DBED9CF5CDB2CDD14ED2ACDC");
  level thread _id_135CC("_encstr_AC800EE8EA65D7EEC77520255A9791AF");
  level waittill("_encstr_BA3A0D7FB7A387596B26E08D34A350");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_ABC617262C9B5BF5C6DEB689851DFAB4B9D2D1D78EC9EAB1B5");
}

hiding_munitions_purchase(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  thread scripts\cp\cp_objectives::run_objective("_encstr_82390E2DA1E3D88DCFBACBF3825F49D0");
}

end_pre_vault_assault(var_0, var_1) {}

init_vault_assault(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\engine\utility::flag_set("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  level.initlethalmaxoffsetmap = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  level.initlocationcircle = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  _id_12BC4();
  level.max_agents_override = 24;

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::getStructArray("_encstr_91830D2679A3709FFD0A60C14395BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = var_2[0];
    objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_position(var_0.objectiveindex, var_3.origin);
    objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");

    if(var_0.ref == "_encstr_845012B19B02F8E8013BE0FBA9E90826BA6F1131") {
      var_4 = scripts\engine\utility::getStructArray("_encstr_BD7614BE0B60D50378F1D3DBD945BB0BD9D7343185D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_5 = var_4[0];
      var_6 = 0;
      var_7 = 49000000;

      while(!var_6) {
        foreach(var_9 in level.players) {
          if(distance2dsquared(var_9.origin, var_5.origin) < var_7)
            var_6 = 1;
        }

        wait 1;
      }
    }
  }

  scripts\cp\utility::skydivestreamhintdvars("_encstr_B47A06BDB537ABF6");
  scripts\engine\utility::flag_init("_encstr_A9B60CB2B956B597D7C2B12BE48E");
  level thread listen_for_enemy_alert();
}

start_vault_assault(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AA66123FD821EFD37B05DDD37823DB8B29B893E3");
  wait 5;
  level thread nag_get_in_bank();
  var_2 = scripts\engine\utility::getStructArray("_encstr_BD7614BE0B60D50378F1D3DBD945BB0BD9D7343185D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[0];
  var_4 = var_3.origin;
  level thread notify_when_player_nearby("_encstr_839D18EBF395EA5CD931CAD229509CA3780F6F7B273E3301D8BB", var_4, 400);
  var_5 = scripts\engine\utility::getStructArray("_encstr_81E51B3632CDA14321432F155057EF635C97D34D53EA42A7AB49AB0A8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_5[0].origin;
  level thread notify_when_player_nearby("_encstr_839D18EBF395EA5CD931CAD229509CA3780F6F7B273E3301D8BB", var_4, 200);
  level waittill("_encstr_839D18EBF395EA5CD931CAD229509CA3780F6F7B273E3301D8BB");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_B88B12BB62A759C8B101BFB72963501D673A5363");
}

end_vault_assault(var_0, var_1) {}

_id_123CA() {
  scripts\mp\vehicles\vehicle_damage_mp::_id_12409("_encstr_A9D705DF574899");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B6F31A8C18579F4AF88199CACB03A62A97E338A70B32D57DEA370AEB");
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
}

gettimetogulagclosed(var_0) {
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

cap_wave_spawning() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = 0;
    var_0 = level.spawned_enemies.size;
    var_1 = 24 - var_0;
    var_2 = max(var_1, 0);

    if(isDefined(level.active_spawn_module_structs["_encstr_A1340ECC2FCBC509A733AF20B02B7DE2"])) {
      var_3 = level.active_spawn_module_structs["_encstr_A1340ECC2FCBC509A733AF20B02B7DE2"];

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        var_5 scripts\cp\cp_modular_spawning::set_ambient_max_count(var_2);
      }
    }

    wait 1;
  }
}

nag_get_in_bank() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_839D18EBF395EA5CD931CAD229509CA3780F6F7B273E3301D8BB");

  for(;;) {
    wait 60;
    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8AF1987ABAFCB423BDFFB129BA097299E3A278F504D8BB417C77F");
  }
}

notify_when_player_nearby(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait_for_player_nearby(var_1, var_2);
  level notify(var_0);
}

init_vault_assault_cut(var_0, var_1) {
  level thread _encstr_91B933B9C69C4B1C1D9BF28D38E5AD160EE6CB1B0E7D19DD9BBED1DDE6CB8DC1EBC8BBDCF53ABBB9FA19ED7B4EAF8DD5D117CEB91B::main(var_0);
  scripts\cp\cp_spawning_util::_id_13BBD(0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
}

start_vault_assault_cut(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AA66123FD821EFD37B05DDD37823DB8B29B893E3");
  scripts\cp\utility::_id_123FE("_encstr_A6EA1AFB55C2E1A6D3F9A810127F63295ECA635BEB6C9974BF73807B");

  if(randomint(100) < 50)
    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_82F622FCAB7E1F926F79CA626BA381C311184B4F4E430B1179E0F38AA9F746D3496899B8");
  else
    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8CE1FF1B12FEFE7AA19D7C1023790F93A9ABC799E22E8DAB817D479236A4F83E2");

  level thread nag_door_cut();
  scripts\engine\utility::flag_set("_encstr_8F5913AB69D3AA66F1F3EA7FA3206F83D51FE71A5B");
  objective_position(var_0.objectiveindex, getEnt("_encstr_B1DA10D3CBBDC2740119B6FB7129AC4A1845", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin + (0, 0, 50));
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setlabel(var_0.objectiveindex, &"_encstr_A6A61F6828FA12A4FA9A2B2596AF3D09298A1A8AA46551A99734AA15EB8452E48A");
  level.cut_progress_objective = var_0.objectiveindex;
  scripts\engine\utility::flag_set("_encstr_A7271216C6E8B4CE168E56BE8CBDDB27EB36AE47");
  mark_group_as_killable("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");
  mark_group_as_killable("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");
  level thread cycle_bank_combat_cut_spawn_modules();

  while(!istrue(level.vault_door_broken))
    wait 0.1;

  scripts\cp\utility::_id_123FE("_encstr_A3E41755F86039360BC670A8FE9DF09E26AB558E4B785B82EC");
  level notify("_encstr_9782123B2CEA36A3BE46BD7B27FA9839BDAD599B");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_849914147FC3C23C384EC318E73B30BBC90C596071E8");
}

end_vault_assault_cut(var_0, var_1) {}

nag_door_cut() {
  level endon("_encstr_9782123B2CEA36A3BE46BD7B27FA9839BDAD599B");

  for(;;) {
    wait 60;

    if(!isDefined(level.total_cut_progress) || level.total_cut_progress == 0) {
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_AB9723C88307A9A81BCFDB69C07B4E22CB8D0871E7A9A1776F33A0139996CCEA783B218223");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A105242387D7360EB9BEB5B0ADB07D3158736DAF3BB08EB27D36AE47D7CCB4CD5ADC43F56260");
  }
}

cycle_bank_combat_cut_spawn_modules() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AA66123FD821EFD37B05DDD37823DB8B29B893E3");
  level endon("_encstr_9782123B2CEA36A3BE46BD7B27FA9839BDAD599B");
  level waittill("_encstr_BABE18E6D158938EF51B5DD1AF9BE0C2EE73EBADDB91BAB1CA9B");
  var_0 = ["_encstr_B155118DCFAAFAA93B85C8212EF47123421729"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0[var_1], 1);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var_4, (22686, -19207, -22));
    }
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_96420CDAA6E55826590A4D7E2983");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AF2114AA77086F697FC87A82907951F380E932251673");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_82171B4C2CCDB57D3B590DB48DC659EB9C2BA5B9CCDE39B156DA59DC3A");

  while(!istrue(level.vault_door_broken)) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD");
    wait 15;
  }
}

init_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_spawning_util::_id_13BBD(0);
  level thread open_vault_gate();
  level.deposit_box_interactions = [];
  var_2 = scripts\engine\utility::getStructArray("_encstr_8BE81E3D5783E178BFFF41FB257B5825D9B397A917EAB8A3DD52C9910B593050", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = 0;

    foreach(var_6 in level.deposit_box_interactions) {
      if(var_6.origin == var_2[var_3].origin)
        var_4 = 1;
    }

    if(!var_4) {
      var_8 = create_deposit_box_interaction(var_2[var_3]);
      level.deposit_box_interactions[level.deposit_box_interactions.size] = var_8;

      if(getdvarint("_encstr_AC9C11EA86DDC93669B1CBE7F0011D71472DF0") != 0)
        var_8.key_card = 1;
    }
  }

  var_9 = randomint(level.deposit_box_interactions.size);
  level.deposit_box_interactions[var_9].key_card = 1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B155118DCFAAFAA93B85C8212EF47123421729");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_96420CDAA6E55826590A4D7E2983");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_82171B4C2CCDB57D3B590DB48DC659EB9C2BA5B9CCDE39B156DA59DC3A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_96420CDAA6E55826590A4D7E2983");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AF2114AA77086F697FC87A82907951F380E932251673");
  var_10 = ["_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD", "_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A", "_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66"];

  for(var_3 = 0; var_3 < var_10.size; var_3++) {
    var_11 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_10[var_3], 1);

    for(var_12 = 0; var_12 < var_11.size; var_12++)
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var_11[var_12], (22374, -19506, -197));
  }

  open_vault_door();

  if(isDefined(var_0) && isDefined(var_0.objectiveindex))
    scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
}

start_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_95CB216B33B96FE026E7CC21F62727E14A08FCF7277320DB8CD15F6F28CAB30491225F");
  var_2 = scripts\engine\utility::getStructArray("_encstr_849914147FC3C23C384EC318E73B30BBC90C596071E8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[0];
  var_4 = var_3.origin;
  level.crypto_key_objective = var_0;
  wait_for_player_nearby(var_4, 500);
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_ACE726DF5316EA100EC128591B97D1CDC1DEA7F777BF70C68A416A374AFB65F63128ABD8A651D7B7");
  level thread nag_vault_search();

  while(!level.key_card_acquired)
    wait 0.1;

  level notify("_encstr_8F431282BF9BE69757CAD5017656978B5B0B0231");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A2DD174CC2B9B57D8DF65B98B08E7DEC0BEA363AD7DD58CE2B");
}

end_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_B4D81D93BFFBD26CF628E7FF30EB3C1BD74CDECB91513986D950B74778A0EC");
}

nag_vault_search() {
  level endon("_encstr_8F431282BF9BE69757CAD5017656978B5B0B0231");
  level endon("_encstr_A6281232B2E0DE9BA58EAFAEE631BE66B7EA7323");

  for(;;) {
    wait 60;

    if(!istrue(level.deposit_box_search)) {
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9B4C295373C17E72D85165434E974722F32DD0C9831DCC478A912293589B418240F0568A9069D582BFC70A");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9A4C292403D6B72AD7D1E20A88EF297BC9E0A3E71358533781B99A42D001116721DF22533BC0737F3FCA37");
  }
}

init_vault_door() {
  level.vault_door = getEnt("_encstr_AD9F15F86F86885FBB8E75F1A3416170FF4B89189325E0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.vault_door.open_pos = level.vault_door.origin;
  level.vault_door.open_ang = level.vault_door.angles;
  var_0 = scripts\engine\utility::getStructArray("_encstr_92BF17C8CA45370E33914DC97C6F91F7ED63A978B25D7F0153", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  level.vault_door.origin = var_1.origin;
  level.vault_door.angles = var_1.angles;
}

open_vault_door() {
  if(isDefined(level.vault_door)) {
    level.vault_door rotateTo(level.vault_door.open_ang, 5, 0.1, 0.5);
    level.vault_door playSound("_encstr_BAE2136C07D79816B95BF5EC85EA8D3AF57B38CACD");
  }
}

create_key_card(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("_encstr_8FE01542D8033967C9E6BC8F737063FF7D804A2B1097AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[0];

  if(isDefined(var_0)) {
    var_4 = var_0.origin + anglestoright(var_0.angles) * 10 + anglesToForward(var_0.angles) * -5;
    var_3.origin = var_4;
    var_3.angles = var_0.angles;
  }

  create_usb_pickup_interaction(var_3, var_1);
}

open_vault_gate() {
  while(!istrue(level.waiting_for_door_cut))
    wait 0.1;

  if(isDefined(level.door_cut_interactions)) {
    foreach(var_1 in level.door_cut_interactions) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }

  wait 1;
  level.vault_door_broken = 1;
  level notify("_encstr_8F2612888057470CE84860A7B8C34179539B397B");
}

init_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BEED1DEE5B3085730881838BE9756BFB09E771578FC00EBB46786A0271CEDF");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3B110C6EFBDD2370108CF0B801BFF9A53FD");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_85351240D73E20F772E5811E7E5BAF698D3B215A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AD3512130BCDB6D78DDEB6890B47D7B1AB3ABE66");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A2DD174CC2B9B57D8DF65B98B08E7DEC0BEA363AD7DD58CE2B");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_83C41A4C0B735BEB6C7BB6C4168EFAD9C2AE1B3AAF4CBDB5C49593CD");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A54E17F1AA03024976C77B5DF19B8154E703C8BBD18B4B88CD");
}

start_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B4DA1896BFCDA24771589FBB30CB0F4A814EDCCB11075A8ED8A8");
  wait 4;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BDA81EBD90794F8BF3071060AF2BA68522BDA2A82F120F31F70B3010DB6F3399");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A6021FE87AC6E7974FA154B7500ABF690308908968EBF879439AF1AE6B62E9938A");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_86111F226AC8E772E8C7ECE9779B713B0FCD6A19F034F3E1E0811CF141E809320F");
}

end_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A627153BB0EAD8A37D2CB96EC2BAD847AFC693CBC147F6");
}

init_vault_assault_crypto(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23"))
    scripts\engine\utility::flag_init("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");

  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  level.hvt_in_heli = 0;
  level.player_sees_hvt = 0;
  level.player_sees_hvt_timeout = 0;
  level thread _encstr_A3383FCF423BBBBBD44317F0CA2EC88B601B05B7E83F5FE87A5FC35B4DB7A7260A9F26D30C8417B39A02095E34089B71F03F1519F0A3C380A1AED218FB2ADABB6B::spawn_enemy_lbravo("_encstr_BE730C64D1181181DDB5FFDF9FF5");
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "_encstr_A2B1104C0BDC5B7D6CF65B4C2CD1D743673A");
  scripts\cp\cp_agent_damage::register_drop_func("_encstr_97A708863B47FA5B9597", ::drop_hvt_key, ::should_drop_hvt_key, 0);
  level.hvt_module_struct = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A2B1104C0BDC5B7D6CF65B4C2CD1D743673A");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A11119B0B23D7F4613CE8568BA0F093FA72B68206B53DF1B27C98D");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_848E140AAB18B40F43B3C379D825376FE8358E91EBB0");
  level thread open_stairwell_doors();
  level thread roof_combat_start(var_0);
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
}

_id_135CC(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    return;
  }
  for(var_2 = 0; var_2 < var_1.size; var_2++)
    thread _id_1353B(var_1[var_2]);
}

_id_1353B(var_0) {
  var_1 = scripts\mp\carriable::_id_131EA(var_0);
  var_1.matchdata_logaward = 1;
}

start_vault_assault_crypto(var_0, var_1) {
  while(!isDefined(level.bank_hvt))
    wait 0.1;

  level thread move_objective_to_hvt(var_0);
  level thread player_sees_hvt();

  while(isDefined(level.bank_hvt) && !level.player_sees_hvt && !level.player_sees_hvt_timeout)
    waitframe();

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_881C1326B037B5AF1BF6B589B08ED7C2E89396D55B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC6617780A32BFE1E77F954A4F331FC2584AD077C391B3A999");
  level thread setup_breadcrumbs_to_roof(var_0);
  level waittill("_encstr_86E50C03102BF76A7B07239CF817");
  scripts\engine\utility::flag_wait("_encstr_8CF509D843EC7E5F7A1DCD");

  while(!istrue(level.players_on_roof))
    wait 0.1;
}

end_vault_assault_crypto(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_95DC1BCB5E7D6835E19FC7CFB76B71F03FF2906007C4B8EF19A3D3E9EF");
}

open_stairwell_doors() {
  scripts\engine\utility::flag_wait("_encstr_8A2D11B774CEBFC2066BFF1A934E21282DA928");
  var_0 = ["_encstr_93860DCD8E854B27AF91EDEDC9D746", "_encstr_A1860D9BBB10E8CBEF12F7C75611FA", "_encstr_88FE0F1B51794A60098837CF06665A89A7", "_encstr_ACFE0F4BD8BB2CBB86550F3776AEF6F945", "_encstr_A6FE0F479370E03389BCA04803FF035142"];

  foreach(var_2 in var_0) {
    open_door(var_2);
    wait 0.1;
  }
}

open_roof_doors() {
  scripts\engine\utility::flag_wait("_encstr_8A2D11B774CEBFC2066BFF1A934E21282DA928");
  var_0 = ["_encstr_8D1D106ED1855A39AF91DE7BE4D74EB77BCC", "_encstr_B8FE0F90DB6928E509EF58504221A35682", "_encstr_AF631253EBD7CFF289B1EFE775613A0F080129CF"];

  foreach(var_2 in var_0) {
    open_door(var_2);
    wait 0.1;
  }
}

roof_combat_start(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9729168223903C975E182A22212D5FB240973E37ABF8C463");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8EBF172658CDB67D277BB733D735579D76564EE62CBAD17DC4");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B8BF17712A8382C9B247FFD54F9C505C7F828B78B2474591DA");
}

roof_jugg_spawn_func(var_0) {
  thread roof_jugg_wake_logic();
}

roof_jugg_wake_logic() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.ignoreall = 1;
  self setgoalpos(self.origin);
  var_0 = scripts\engine\utility::getStructArray("_encstr_880F0A18A5DC3F97608FAF9D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self.room_struct = sortbydistance(var_0, self.origin)[0];
  var_1 = 1;
  var_2 = gettime() + (30 + randomint(10)) * 1000;
  var_3 = self.origin[2] - 20;
  var_4 = self.room_struct.radius * self.room_struct.radius;

  while(var_1) {
    foreach(var_6 in level.players) {
      if(distancesquared(var_6.origin, self.room_struct.origin) <= var_4) {
        if(isDefined(var_3)) {
          if(var_6.origin[2] < var_3)
            continue;
        }

        var_1 = 0;
      }
    }

    if(gettime() > var_2)
      var_1 = 0;

    wait 0.1;
  }

  self.goalradius = 1024;
  self.ignoreall = 0;
}

player_sees_hvt() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_97431EFB49C80C1BF893878FFB95E26CF1917280C318C7614B858347E9B5DBBB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = var_1.origin;
  wait_for_player_nearby(var_2, 800, -50, 200);
  wait 1;
  level.player_sees_hvt = 1;
}

player_sees_hvt_timeout(var_0) {
  wait(var_0);
  level.player_sees_hvt_timeout = 1;
}

move_juggs_in_elevator() {
  scripts\engine\utility::flag_wait("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");
  wait 3;
  level.hvt_elevator_jugg dodamage(level.hvt_elevator_jugg.health + 1000, level.hvt_elevator_jugg.origin);
}

hvt_jugg_spawn_func(var_0) {
  if(!isDefined(level.hvt_jugg))
    level.hvt_jugg = [];

  level.hvt_jugg[level.hvt_jugg.size] = self;
  self.hvt_jugg = 1;
  level.hvt_elevator_jugg = self;
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.dont_enter_combat = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
}

hvt_jugg_skit_spawn_func(var_0) {
  level.bank_hvt_jugg = self;
  self.bank_hvt_jugg = 1;

  if(!isDefined(level.hvt_jugg))
    level.hvt_jugg = [];

  level.hvt_jugg[level.hvt_jugg.size] = self;
  self.hvt_jugg = 1;
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.dont_enter_combat = 1;
  self.allowpain = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
}

move_objective_to_hvt(var_0) {
  level thread setup_breadcrumbs_to_hvt(var_0);
  var_1 = scripts\engine\utility::getStructArray("_encstr_924A20FB90738D436637F30BDFCBEB53FF704353F9398707D830EB1FE133F71B2358", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("_encstr_A5B2158EB838201B7D8BF34FC9AEE17C80038752562AA9");
  var_3 thread break_pc_on_damage();

  while(!isDefined(level.bank_hvt))
    wait 0.1;

  level waittill("_encstr_8A6411F631A6ACB13A4B6795D7F6E6D71AB3A3");
  level thread spawninfo();
  wait 1;
  level.hvt_obj_num = var_0.objectiveindex;
  objective_setplayintro(level.hvt_obj_num, 0);
  objective_setplayoutro(level.hvt_obj_num, 0);
  objective_setbackground(level.hvt_obj_num, 0);
  objective_state(level.hvt_obj_num, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(level.hvt_obj_num, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_onentity(level.hvt_obj_num, level.bank_hvt);
  objective_setzoffset(level.hvt_obj_num, 70);
}

spawninfo() {
  var_0 = 500;
  var_1 = var_0 * var_0;
  var_2 = cos(45);

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, level.bank_hvt.origin) < var_1) {
      if(scripts\engine\utility::within_fov(var_4.origin, var_4.angles, level.bank_hvt.origin, var_2)) {
        level thread _id_124EC(var_4);
        return;
      }
    }
  }
}

_id_124EC(var_0) {
  wait 0.5;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_88B212986B8A3631C252740DAB594DB8FBAF6038");
}

break_pc_on_damage() {
  self setCanDamage(1);
  self waittill("_encstr_B2BE0788BAF573592F");
  self setModel("_encstr_A1F022D87BB507D547AC9CAF388DFA47B7775927BE0CC47DC493F6B5CA9B7D46ACB9E893");
  playFXOnTag(level._effect["_encstr_96AF09784EA14135B7492F"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playsoundatpos(self.origin, "_encstr_97AA16A3720D87E1AD22B8AAF2E721A912A0CDD74583FDA3");
}

setup_breadcrumbs_to_hvt(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("_encstr_9A8507BA4040188D08", "_encstr_BE2B122EE7BEF3D3A1B91A132BE30F87B3558DB2");
  level thread clean_up_breadcrumbs_to_hvt(var_0);
}

clean_up_breadcrumbs_to_hvt(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_86E50C03102BF76A7B07239CF817");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var_0.objbreadcrumbs);
}

spawninsafehouse() {
  var_0 = 500;
  var_1 = var_0 * var_0;
  var_2 = cos(45);
  var_3 = level.players[0];

  foreach(var_5 in level.players) {
    if(distancesquared(var_5.origin, level.bank_hvt.origin) < var_1) {
      if(scripts\engine\utility::within_fov(var_5.origin, var_5.angles, level.bank_hvt.origin, var_2)) {
        var_3 = var_5;
        break;
      }
    }
  }

  _id_124EB(var_3);
}

_id_124EB(var_0) {
  wait 0.25;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_973610CC1B0BCEDE27F59B2BB32C3A2DEC95");
  wait 8;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_AC1F12285EA231F5C2132F232309B1685674F0A1");
}

setup_breadcrumbs_to_roof(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_86E50C03102BF76A7B07239CF817");
  var_0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("_encstr_9A8507BA4040188D08", "_encstr_81D1136785EBC9BDEDCC7D98392BB08C6C39EAD689");
  level thread clean_up_breadcrumbs_to_roof(var_0);
}

clean_up_breadcrumbs_to_roof(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_979D1767F3104AA398F5B767CF30099520199CAD4ED0E5AAE3");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var_0.objbreadcrumbs);
}

tagleaderwithheadicon(var_0) {
  level.tmtyl_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.tmtyl_headicon, "_encstr_8E781B0D5D19BED2B1BD377D0D0B4E8C83F62D37A3EB8C5A0BD6B77323");
  setheadiconsnaptoedges(level.tmtyl_headicon, 0);
}

watchforvipdeath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(level.tmtyl_headicon))
    setheadiconimage(level.tmtyl_headicon);

  level thread heli_force_search();
  scripts\engine\utility::flag_set("_encstr_8CF509D843EC7E5F7A1DCD");
  level.bank_hvt = undefined;
  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_A2B1104C0BDC5B7D6CF65B4C2CD1D743673A");
}

wait_for_jugg_death(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_848E140AAB18B40F43B3C379D825376FE8358E91EBB0");
}

heli_force_search() {
  if(isDefined(level.heli)) {
    level.heli.force_search = 1;
    wait 1;
    level.heli.force_search = undefined;
  }
}

hvt_think_func(var_0) {
  level.bank_hvt = self;
  self.bank_hvt = 1;
  self.invulnerable = 1;
  self.never_kill_off = 1;
  self._id_11E50 = 1;
  self.allowpain = 0;
  self.ignoreall = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
  thread watchforvipdeath();
  thread send_hvt_to_elevator();
  level thread move_juggs_in_elevator();
  scripts\cp\cp_modular_spawning::set_character_models("_encstr_BDDC1DFA4DA12B87E9D0C71B2EE35B8AEF97C89D16E1D6D1E9A4D357394F86", "_encstr_AD3E1434590B23BE6EC6F5D6AFB5B7B9ACBCBE8D2DCE");
}

send_hvt_to_elevator(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.players_on_roof = 0;

  while(isDefined(level.bank_hvt) && !level.player_sees_hvt && !level.player_sees_hvt_timeout)
    waitframe();

  scripts\engine\utility::delaythread(8, ::allow_breach_charge);
  scripts\cp\utility::_id_123FE("_encstr_836B1FAF4B632F062B6812D720AD5B7153381F074D82700737159119F8C19120F5");
  spawn_bodyguard_and_go_to_desk();
  hvt_idle();
  scripts\cp\utility::_id_123FE("_encstr_836B1FAF4B632F062B6812D720AD5B7153381F074D82700737159119F8C19120F5");
  hvt_exit();
  level notify("_encstr_86E50C03102BF76A7B07239CF817");
  wait 1;
  scripts\engine\utility::flag_set("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");

  if(isDefined(level.bank_hvt)) {
    move_up_to_roof();
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AF1B19ABE328AA4780E0DD671EA89693686D7F0747C5433E308B13");
  } else
    scripts\cp\cp_objectives::update_objective("_encstr_A627153BB0EAD8A37D2CB96EC2BAD847AFC693CBC147F6", "_encstr_AF5A081BBAC993AC73A3", (4238, 710, 836), undefined, undefined, 2, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9", 0, 1, 1);

  waittill_players_on_roof();
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8E951FADF07036C3A761C973B2BB2EF3337ADAAEDA3B73AFB5A7A7393978BF4202");
  level thread move_marker_to_heli();
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8BA711228A201F075805DD39C77B8FADB8F702");
  give_hvt_ar();
  open_elevator_doors("_encstr_B40101");
  scripts\engine\utility::flag_set("_encstr_995E13937BF666BE95D859B385D1ED4E7DBDE0CA9B");
  hvt_run_to_heli();
  hvt_made_it_to_heli();
}

_id_133B3(var_0) {
  level._id_13B13 = 1;
  wait(var_0);
  level notify("_encstr_B2860FAAF30652D78FD16739B3DD99FF10");
  wait 1;
  scripts\engine\utility::flag_set("_encstr_BE730C64D1181181DDB5FFDF9FF5");
}

allow_breach_charge() {
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A14C20D1DB27E6D0921797FB5D7EE13E8712883EE27B2D80AE08F7F9772570686E8F");
  var_0 = scripts\engine\utility::getStructArray("_encstr_82C70C1FF9201AE620D1EA3609F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = scripts\cp\cp_breach_c4::setup_c4(var_1);
  var_2 scripts\engine\utility::ent_flag_wait("_encstr_928C0C273211552880ED1089577C");
  var_3 = anglestoright(var_2.angles);
  var_4 = anglestoup(var_3);
  playFX(level._effect["_encstr_A73F134B5DB379EFA8B0A1B6E3A135C30F4D678729"], var_2.origin, var_3, var_4);
  var_5 = getEnt("_encstr_97FC09D03B8EF5C8EDED39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 setModel("_encstr_A17C1DC81A35151E3365B3387E9F63FF1F129950724D4D56438949A757DFE9");
  level notify("_encstr_B2860FAAF30652D78FD16739B3DD99FF10");
  level thread getcashnags();
}

getcashnags() {
  spawninsafehouse();
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8ACB241C8981A6433E66528ACB16C75ED83D9B5FD958ED83F03BDA3270E44F9230830CD7CB4A");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8DFD207B280693F31F501D56AEC7D95A6920CF0FC05BDC493550258F159763DFBB3A");
  wait 5;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8E951FADF07036C3A761C973B2BB2EF3337ADAAEDA3B73AFB5A7A7393978BF4202");
}

spawn_bodyguard_and_go_to_desk() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_97AA1AEBF68DE1E997E6B86B02B7211BD1400BD550D2760643DD322A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  level.hvt_ar = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  level.hvt_ar setModel("_encstr_BD481CDB011F736DC87FBEBD67E87287B778B2F2A84DB6A9804DB0AA2F88");
  level.hvt_ar.angles = var_1.angles;
  wait 1;
  level.monitor_lookat_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (6116, 1499, 378));

  if(isDefined(level.bank_hvt) && isDefined(level.bank_hvt_jugg)) {
    var_2 = scripts\cp\cp_weapon::buildweapon("_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    level.bank_hvt giveweapon(var_2);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var_2);
    level.bank_hvt scripts\common\utility::initweapon(var_2);
    level.bank_hvt _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(var_2, "_encstr_8253060E2B5FE330");
    level.bank_hvt.sidearm = var_2;
    var_3 = scripts\engine\utility::getStructArray("_encstr_B8190934AC4B37D1765DE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = var_3[0];
    level.bank_hvt_cig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.bank_hvt gettagorigin("_encstr_A130084D2FDAD8AA8F62") + (0, 0, -3));
    level.bank_hvt_usb = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    level.bank_hvt_cig.angles = level.bank_hvt gettagangles("_encstr_A130084D2FDAD8AA8F62");
    level.bank_hvt.animstruct = var_4;
    level.bank_hvt_cig setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level.bank_hvt_cig linkTo(level.bank_hvt, "_encstr_A130084D2FDAD8AA8F62", (2.75, -0.5, -2.85), (0, 0, 0));
    level.bank_hvt_usb setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("_encstr_A9471F578176CE6628F818123188469336482BB14AB7E7398893B1191B93A360C3", var_4.origin, var_4.angles);
    level.bank_hvt thread hvt_skit_notetrack_handler();
    level.bank_hvt_jugg thread hvt_skit_notetrack_handler();
    level thread open_elevator_doors("_encstr_AA6E07A7333008839D", "_encstr_8A6411F631A6ACB13A4B6795D7F6E6D71AB3A3");
    level childthread spawnheight();
    level.bank_hvt_jugg scripts\asm\shared\mp\utility::burningpartlogic("_encstr_874111B511F530C8C30A7823034796804E7A11", var_4, undefined, 1);
    level.bank_hvt scripts\asm\shared\mp\utility::burningpartlogic("_encstr_B4C01599C26B7A31DCA56B57DC49A83D9F9933C32AE32D", var_4);
  }
}

spawnheight() {
  wait 0.1;
  playFXOnTag(level._effect["_encstr_BAA70848249367CEC330"], level.bank_hvt_cig, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

lookat_players() {
  self endon("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_0)) {
      self setlookatentity();
      wait 3;
      continue;
    }

    if(distance(var_0.origin, self.origin) < 1000)
      self setlookatentity(var_0);
    else
      self setlookatentity();

    wait 5;
  }
}

hvt_idle() {
  level endon("_encstr_B2860FAAF30652D78FD16739B3DD99FF10");
  level.bank_hvt_jugg thread lookat_players();
  var_0 = level.bank_hvt scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_813314968FE083A8E00FE883C36E3FCB78A76C716CB7");
  var_1 = level.bank_hvt_jugg scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_82CB101B53B83AD7C0D12CB2EBA1390201E3");
  var_2 = level.bank_hvt_jugg scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_1);

  for(;;) {
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("_encstr_96821E614A09D51B98D8F192C508B0CB8F501C1D226339B73383DD395B8D9313", level.bank_hvt.animstruct.origin, level.bank_hvt.animstruct.angles);
    level.bank_hvt aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_0);
    level.bank_hvt_jugg aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_1);
    wait(getanimlength(var_2));
  }
}

hvt_exit() {
  level.bank_hvt_jugg notify("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
  level.bank_hvt_jugg setlookatentity();
  level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("_encstr_86501DA273992AEB98320E624A1B9B53912D28DA9360A2A0E356421151E50A", level.bank_hvt.animstruct.origin, level.bank_hvt.animstruct.angles);
  level thread spawnflags_check();
  level.bank_hvt_jugg scripts\asm\shared\mp\utility::burndowntime("_encstr_95360F0138883B5F082B8768F3E6B83831");
  clear_animpos(level.bank_hvt_jugg);
  level.bank_hvt_jugg select_bunker_roof_spawners();
  level.bank_hvt.ignoreall = 1;
}

select_bunker_roof_spawners() {
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
  self.demeanoroverride = "_encstr_AA7C07466F9DA30713";
  scripts\asm\asm_bb::bb_requestmovetype("_encstr_AA7C07466F9DA30713");
}

spawnflags_check() {
  level.bank_hvt scripts\asm\shared\mp\utility::burndowntime("_encstr_B6CC1326B0CDB6FAA1CA5AE63AD79D57BCFA95CD32");
  close_elevator_doors("_encstr_AA6E07A7333008839D");
}

clear_animpos(var_0) {
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;
  var_0.invulnerable = 0;
}

go_into_elevator() {
  if(isDefined(level.bank_hvt)) {
    var_0 = scripts\engine\utility::getStruct("_encstr_AC781130AB0486A3A2076CFF5BCAD5CE68B760", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    self.goalradius = 8;
    scripts\engine\utility::_id_143A7("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_AD75063D571AE108");

    if(isDefined(level.bank_hvt))
      thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A67E1FBF736FE863F31FFDB74E497F29F32B01290971CD918EE8D70DC9820C4518");
  }
}

move_up_to_roof() {
  if(isDefined(level.bank_hvt)) {
    objective_state(level.hvt_obj_num, "_encstr_AF5A081BBAC993AC73A3");
    var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self linkTo(var_0);
    var_1 = scripts\engine\utility::getStructArray("_encstr_B4CF0FD0D9A3BE4EF6DE99AF9B1C2CEEDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = var_1[0];
    var_0 moveTo(var_2.origin, 5);
    var_0 waittill("_encstr_9B420907FD535DAC6DF285");
    self unlink();
    self.origin = var_2.origin;
    self.angles = var_2.angles;
    self.ignoreall = 1;
    scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
    self.goalradius = 8;
    var_0 delete();
  }
}

roof_jugg_logic(var_0) {
  self.ignoreall = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
  thread roof_jugg_run_once_doors_open();
}

roof_jugg_run_once_doors_open() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_995E13937BF666BE95D859B385D1ED4E7DBDE0CA9B");
  self notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self.ignoreall = 1;
  var_0 = scripts\engine\utility::getStructArray("_encstr_BE6F0F0D3BA3BE277BF6CCBE2B87335A8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
  self.goalradius = 8;
  self.demeanoroverride = "_encstr_92100762872552A643";
  scripts\asm\asm_bb::bb_requestmovetype("_encstr_92100762872552A643");
  self allowedstances("_encstr_A5AD069B231F0BAF");
  thread ignore_players_not_on_roof(4000, self.origin, self.origin[2] + 500, self.origin[2] - 50);
  thread hasbrspecialistbonus();
}

hasbrspecialistbonus() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_BE730C64D1181181DDB5FFDF9FF5");
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
  self.demeanoroverride = "_encstr_AA7C07466F9DA30713";
  scripts\asm\asm_bb::bb_requestmovetype("_encstr_AA7C07466F9DA30713");
}

ignore_players_not_on_roof(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_4 = var_0 * var_0;
  var_5 = 0;

  while(!var_5) {
    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      var_7 = level.players[var_6];

      if(distancesquared(var_7.origin, var_1) <= var_4) {
        if(isDefined(var_2)) {
          if(var_7.origin[2] > var_2)
            continue;
        }

        if(isDefined(var_3)) {
          if(var_7.origin[2] < var_3)
            continue;
        }

        var_5 = 1;
      }
    }

    wait 1;
  }

  self.ignoreall = 0;
}

give_hvt_ar() {
  if(isDefined(level.hvt_ar))
    level.hvt_ar delete();

  if(isDefined(level.bank_hvt)) {
    var_0 = scripts\cp\cp_weapon::buildweapon("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
    level.bank_hvt giveweapon(var_0);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var_0);
    level.bank_hvt scripts\common\utility::initweapon(var_0);
    level.bank_hvt _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(var_0, "_encstr_8253060E2B5FE330");
  }
}

hvt_run_to_heli() {
  if(isDefined(level.bank_hvt)) {
    clear_animpos(level.bank_hvt);
    level.bank_hvt.allowpain = 1;
    level.bank_hvt.ignore_all = 1;
    level.bank_hvt.force_drop = "_encstr_97A708863B47FA5B9597";
    wait 1;
    objective_state(level.hvt_obj_num, "_encstr_AF5A081BBAC993AC73A3");
    self notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
    self.ignoreall = 1;
    var_0 = scripts\engine\utility::getStructArray("_encstr_BE6F0F0D3BA3BE277BF6CCBE2B87335A8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = var_0[0];
    scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
    self.goalradius = 8;
    self.demeanoroverride = "_encstr_92100762872552A643";
    scripts\asm\asm_bb::bb_requestmovetype("_encstr_92100762872552A643");
    self allowedstances("_encstr_A5AD069B231F0BAF");
    level.bank_hvt thread hvt_if_heli_destroyed();
    thread set_hvt_gone_flag();
    scripts\engine\utility::_id_143A7("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_AD75063D571AE108");
  } else
    scripts\engine\utility::flag_set("_encstr_BE730C64D1181181DDB5FFDF9FF5");
}

set_hvt_gone_flag() {
  self.isinlaststand = ::spawnhandled;
  self waittill("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_set("_encstr_BE730C64D1181181DDB5FFDF9FF5");
}

spawnhandled(var_0) {
  if(isPlayer(var_0.eattacker))
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0.eattacker, "_encstr_8EE916EDCA43484086AA1F03B46180A9375258A842939D38");
}

hvt_if_heli_destroyed() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_BE730C64D1181181DDB5FFDF9FF5");
  self.ignoreall = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
}

hvt_made_it_to_heli() {
  if(!scripts\engine\utility::flag("_encstr_BE730C64D1181181DDB5FFDF9FF5")) {
    if(isDefined(level.bank_hvt) && isalive(level.bank_hvt)) {
      level.heli thread setup_hvt_in_heli("_encstr_93680B3AB03BAF385A1BBD8E19", (0, 0, -20));
      self.nocorpse = 1;
      self dodamage(self.health + 1000, self.origin);
      level.hvt_in_heli = 1;
      level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A2012740E3B1AF63BF274937E3574E75E62A80117A93C9DEDF13C63FD857363F0CC2D0F0C22A67DBE2");
    } else
      level thread _id_13AED();
  }
}

_id_13AED() {
  wait 4;
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BADA1D7079095B386FE6E28659C797F2A902E0D14033ABE758072B1A3143F2");
}

setup_hvt_in_heli(var_0, var_1, var_2) {
  var_3 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = (0, 0, 0);

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = (0, 0, 0);

  if(isDefined(var_2))
    var_5 = var_2;

  if(!self tagexists(var_3))
    var_3 = "_encstr_AB680B55361AD76B09EB28E886";

  self.hvt_in_heli = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_3));
  self.hvt_in_heli setModel("_encstr_951317DEBA8CD42FCFFCF7DAA7FB85D3B85F4BB88AA8984F30");
  self.hvt_in_heli linkTo(self, var_3, var_4, var_5);
  self.hvt_in_heli scriptmodelplayanim("_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC");
  thread clean_up_on_heli_death();
}

clean_up_on_heli_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.hvt_in_heli))
    self.hvt_in_heli delete();

  wait 3;
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_ACBA1DE44396F76A9791A24AC8AFE9BB092063A7565857F67D79AAF3C1430A");
}

should_drop_hvt_key(var_0) {
  if(istrue(self.bank_hvt))
    return 1;

  return 0;
}

drop_hvt_key(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = (0, 0, 0);
  level.spawnhumandogtags = 1;
  create_key_card(var_1);
}

waittill_players_on_roof() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_B4CF0FD0D9A3BE4EF6DE99AF9B1C2CEEDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = -200;
  wait_for_player_nearby(var_1.origin, 4000, var_2);
  level.players_on_roof = 1;
}

init_vault_assault_rooftop(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AC6617780A32BFE1E77F954A4F331FC2584AD077C391B3A999");
  scripts\cp\cp_spawning_util::_id_13BBD(0);
}

start_vault_assault_rooftop(var_0, var_1) {
  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("_encstr_B155118DCFAAFAA93B85C8212EF47123421729");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("_encstr_81E01802A310BC17DE98AAA2A1ADDFF4C81BACB71F7844F3F513");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("_encstr_860D15424950C7B968A7EDEA5338711788E09B19B337BF");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
  }
}

end_vault_assault_rooftop(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_95DC1BCB5E7D6835E19FC7CFB76B71F03FF2906007C4B8EF19A3D3E9EF");
}

_id_12D84(var_0) {
  self.never_kill_off = 1;
  thread _id_1301D();
}

_id_1301D() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = ["_encstr_BE23185A8010F01B051960F91953A77F208D57E12B9993AF1033", "_encstr_923A19D3C7A07264700B296FA398B68B106F6B0F3F554A3A08B11B"];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_6 = scripts\engine\utility::getclosest(self.origin, var_1);
  scripts\cp\cp_modular_spawning::set_goal_radius(96);
  scripts\cp\cp_modular_spawning::set_goal_pos(var_6.origin);
  scripts\engine\utility::_id_143AD("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  self.never_kill_off = undefined;
  scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

_id_140BF(var_0, var_1) {
  var_0 scripts\cp\cp_modular_spawning::spawner_init();

  if(isDefined(level._id_14682) && var_0.origin[2] > level._id_14682)
    return 0;

  return scripts\cp\cp_spawner_scoring::standard_spawnpoint_valid(var_0, var_1);
}

_id_140BE(var_0, var_1) {
  if(isDefined(level._id_14682) && var_0.origin[2] > level._id_14682)
    return 0;

  return scripts\cp\cp_spawner_scoring::cluster_spawnpoint_valid(var_0, var_1);
}

init_vault_assault_rooftop_heli(var_0, var_1) {
  scripts\cp\cp_spawning_util::_id_13BBD(0);
}

start_vault_assault_rooftop_heli(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("_encstr_BD7614BE0B60D50378F1D3DBD945BB0BD9D7343185D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level thread start_mortars();
  level.exfil_delay = gettime() + 120000;
  level.mark_heli = 1;

  if(isDefined(level.heli))
    level thread play_kill_heli_nags();

  level._id_121C0 = ["_encstr_8EC01B1B53B83AD71090ADF78ED8316387C1D3B727DF82B2307E65BDA3"];
  level thread _id_135AF();

  while(isDefined(level.heli))
    wait 0.1;

  level._id_121C0 = ["_encstr_8EC01B1B53B83AD71090ADF78ED8316387C1D3B727DF82B2307E65BDA3", "_encstr_B8431C7E16AA9FAE328748185F6821E5E2FBEE706DA35B331B2F78689798"];
  scripts\cp\utility::_id_123FE("_encstr_B89C1C5B57DCD7D883EB5B7B372BE57D0DCA1BBDBE19AC371D4EB7BCAC46");
  level notify("_encstr_AF111635E61F2063411A88C822690358479D4B3841E3E991");
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8CF23F1B12FEFE7AA19CBC1E37F90F93A9ABC798C62704A6861C86A92CA762B359857D760");
  level.mark_heli = 0;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A33B1DC56227B1ABFF01AF708E47E8A1193B158758149DD06929E14A5B35B1");
}

end_vault_assault_rooftop_heli(var_0, var_1) {}

_id_135AF() {
  level endon("_encstr_B46E1243AB3091CF130AC2B903AB5068D37A2AF3");

  for(;;) {
    while(level.spawned_ai.size >= 16)
      wait 1;

    if(isDefined(level.heli)) {
      scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(level._id_121C0), undefined, (-13512, 66432, 5904));
      thread _id_142EC();
    } else if(randomint(100) > 50)
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_83931A7ADB68C45F96C0E21A6975277C5859F9FF55B80D735098DA33");
    else
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B16E1BE651081381DEB7D7D3937DC95808985C21ABA8AFCA3851CFCFE9");

    wait 10;
  }
}

play_kill_heli_nags() {
  level endon("_encstr_AF111635E61F2063411A88C822690358479D4B3841E3E991");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread set_flag_when_rpg_picked_up();

  for(;;) {
    wait 60;

    if(!istrue(level.rpg_picked_up)) {
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BE281DCC595176730E5672DA786F976E08CD4B6F8FC03EF320EBBBA2069FE2");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_91A81FAD80695F9BE3F7D870C709B69552AD92B85F122B60C1DFC858EB29CE6BEF");
  }
}

set_flag_when_rpg_picked_up() {
  level endon("_encstr_AF111635E61F2063411A88C822690358479D4B3841E3E991");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8D4A0EC9C1D9F507961BB5CA19D7BA0E", var_0);
  level.rpg_picked_up = 1;
}

move_marker_to_heli() {
  while(isDefined(level.bank_hvt))
    wait 0.1;

  wait 0.1;

  if(isDefined(level.heli)) {
    objective_setplayintro(level.hvt_obj_num, 0);
    objective_setplayoutro(level.hvt_obj_num, 0);
    objective_setbackground(level.hvt_obj_num, 0);
    objective_state(level.hvt_obj_num, "_encstr_AF5A081BBAC993AC73A3");
    objective_icon(level.hvt_obj_num, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_onentity(level.hvt_obj_num, level.heli);
    objective_setzoffset(level.hvt_obj_num, 70);
    level.heli thread watchforhelideath();
  } else
    scripts\cp\cp_objectives::freeworldid("_encstr_A2F209ADEF8ADA8910E30B");
}

tag_heli_with_head_icon(var_0) {
  level.heli_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.heli_headicon, "_encstr_8E781B0D5D19BED2B1BD377D0D0B4E8C83F62D37A3EB8C5A0BD6B77323");
  setheadiconsnaptoedges(level.heli_headicon, 0);
}

watchforhelideath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_926B153B370D90C0397B625DC7D12753A08B3B79FD1C98");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(level.heli_headicon))
    setheadiconimage(level.heli_headicon);

  scripts\cp\cp_objectives::freeworldid("_encstr_A2F209ADEF8ADA8910E30B");
  level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8CF23F1B12FEFE7AA19CBC1E37F90F93A9ABC798C62704A6861C86A92CA762B359857D760");
}

init_vault_assault_rooftop_defend(var_0, var_1) {
  scripts\cp\cp_spawning_util::_id_13BBD(0);
}

start_vault_assault_rooftop_defend(var_0, var_1) {
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();

  if(isDefined(level.exfil_delay)) {
    while(gettime() < level.exfil_delay)
      wait 0.1;
  }

  while(isDefined(level.heli))
    wait 0.1;

  wait 0.1;
  level notify("_encstr_BDF60F5B1DC8E3C9C938CA920115BF7FCD");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8BA711228A201F075805DD39C77B8FADB8F702");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BACD15DD798D48A0C3F21039194B6DF067D5454DE133F8");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_910D16F551B57088AFEAB841122B40A08FA46B17EA5D086C");
  var_2 = scripts\engine\utility::getStructArray("_encstr_911F1603980DB02187A8BB03EA756DC8AF5517D81E5B8DE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[0];
  level notify("_encstr_91750BE60B41C076B37326D770", var_3.origin, 1);
  level notify("_encstr_B46E1243AB3091CF130AC2B903AB5068D37A2AF3");

  foreach(var_5 in level.players)
  var_5 notify("_encstr_8B1509EC6DF092EF2EB1D3");

  while(!isDefined(level.exfil_heli))
    wait 0.1;

  level waittill("_encstr_AF0119589B2260A512E98715F14AE1C9915B21A807CBB969FA8D08");
}

end_vault_assault_rooftop_defend(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_95B41C53DA4BB07B40AE4F4A4F8538906978EFD25D9568E8618D61DF102C");
}

_id_13E3C(var_0) {
  wait(var_0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_83931A7ADB68C45F96C0E21A6975277C5859F9FF55B80D735098DA33");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B16E1BE651081381DEB7D7D3937DC95808985C21ABA8AFCA3851CFCFE9");
}

init_vault_assault_rooftop_exfil(var_0, var_1) {
  scripts\cp\cp_spawning_util::_id_13BBD(0);
}

start_vault_assault_rooftop_exfil(var_0, var_1) {
  level thread delay_and_play_vo_to_team(10, "_encstr_8A0A213933CF1E287AFF4153FBA28956DFAA50C69A9FC1A819DD5161020E20257FF7C3");
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  level.battlechatterenabled = 0;
  scripts\cp\utility::_id_123FE("_encstr_8E75181823AAC71143D73920CE3F9A7FD48A8880F947C189FF1C");

  foreach(var_3 in level.players) {
    level notify("_encstr_B4C316B84263F9319AB5735BCD8769B6F79933A06B9325F9" + var_3.name);
    var_3 setsoundsubmix("_encstr_822C12BE606FB8DB03126818DA5FEFF0BF0B3326", 5);
  }

  wait 2;

  if(istrue(level.spawninfluencepoints)) {
    foreach(var_3 in level.players)
    var_3 scripts\cp_mp\xmike109::scriptable_callback("_encstr_87F20B38EAC3FDAB974737907A");

    level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A15E2D05404751A19AB9305053B2C7C917CE1A10BD479BEF44C238994BCB77A17F7B9E741D3B46036D5B680861F289");
  } else
    level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_965627C80FAFD883E6AFB12CDC6ED74C2C73D6AFDA2D37CD5AF6E67DB9576CD8B26EDCCC5D1B7D2606");

  foreach(var_3 in level.players) {
    var_3 scripts\cp_mp\xmike109::scriptable_callback("_encstr_BDF20B3A90C43B9BF07FF6FFCF");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_ABE60EA030024AD5672288F8419307EA");
        continue;
      }

      var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_A6C4121BF3CBCDAB973648E0416910C4E034177B");
    }
  }

  level thread mp_shipment_patch();
}

end_vault_assault_rooftop_exfil(var_0, var_1) {}

mp_shipment_patch() {
  foreach(var_1 in level.players)
  var_1 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_1 in level.players) {
    if(!istrue(var_1.try_to_punish_with_jugg)) {
      var_1.invulnerable = 1;
      var_1 allowmovement(0);
    }

    var_4 = scripts\engine\utility::getStruct("_encstr_95F71BD92CBA631D16DC9BB0AE361DF56C85B656390BF5599B235A9BCE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 spawn_endgame_camera(var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

play_get_on_heli_nags() {
  level endon("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 30;
    level thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_84A9208BD8F64323CF80EDA371EF7A09B8D8EF039848B119CB2B33DAEFBFD3EFEB6A");
  }
}

wait_for_player_nearby(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;
  var_5 = undefined;

  if(isDefined(var_2))
    var_5 = var_0[2] + var_2;

  var_6 = undefined;

  if(isDefined(var_3))
    var_6 = var_0[2] + var_3;

  for(;;) {
    var_7 = 0;

    foreach(var_9 in level.players) {
      if(distance2dsquared(var_9.origin, var_0) <= var_4) {
        if(isDefined(var_5)) {
          if(var_9.origin[2] < var_5)
            continue;
        }

        if(isDefined(var_6)) {
          if(var_9.origin[2] > var_6)
            continue;
        }

        var_7 = 1;
      }
    }

    if(var_7) {
      break;
    }

    wait 0.1;
  }
}

send_heli_reinforcements(var_0) {
  level endon("_encstr_BDF60F5B1DC8E3C9C938CA920115BF7FCD");

  for(;;) {
    wait(var_0);

    while(level.spawned_enemies.size > 12)
      wait 0.1;
  }
}

drop_intel_from_hvt() {}

open_elevator_doors_roof() {
  var_0 = getEntArray("_encstr_8BDA0E17C0603E5205E7FB57E9A0FA72", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2.starting_pos = var_2.origin;

    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_2 moveTo(var_3.origin, 2, 0.1, 0.1);
    }
  }

  wait 2;
}

close_elevator_doors_roof() {
  var_0 = getEntArray("_encstr_8BDA0E17C0603E5205E7FB57E9A0FA72", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.starting_pos))
      var_2 moveTo(var_2.starting_pos, 2, 0.1, 0.1);
  }

  wait 2;
}

open_elevator_doors(var_0, var_1) {
  var_2 = getEntArray("_encstr_8BDA0E17C0603E5205E7FB57E9A0FA72" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_3))
      var_3 = var_5;

    if(!istrue(var_5.open)) {
      var_5.starting_pos = var_5.origin;

      if(isDefined(var_5.target)) {
        var_6 = scripts\engine\utility::getStructArray(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7 = var_6[0];
        var_5 moveTo(var_7.origin, 2, 0.1, 0.1);
      }
    }
  }

  if(isDefined(var_3)) {
    var_9 = (0, 0, 0);
    var_10 = var_3.origin + var_9;
    playsoundatpos(var_10, "_encstr_A33325C06AC5DF09AB2F46CFE63F7679EF524840015FC1819B395530D2C7381157CAB1FABBF717");
  }

  wait 2;

  foreach(var_5 in var_2) {
    var_5.open = 1;
    var_5 connectpaths();
  }

  if(isDefined(var_1))
    level notify(var_1);
}

close_elevator_doors(var_0) {
  var_1 = getEntArray("_encstr_8BDA0E17C0603E5205E7FB57E9A0FA72" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_2))
      var_2 = var_4;

    if(istrue(var_4.open)) {
      if(isDefined(var_4.starting_pos))
        var_4 moveTo(var_4.starting_pos, 2, 0.1, 0.1);
    }
  }

  if(isDefined(var_2)) {
    var_6 = (0, 0, 0);
    var_7 = var_2.origin + var_6;
    playsoundatpos(var_7, "_encstr_8BED2623AAD00ECA084FEE6B1533D1E12B70CF380939749198D6D338BB8772F11823A3E132AF1A6E");
  }

  wait 2;

  foreach(var_4 in var_1) {
    var_4.open = undefined;
    var_4 disconnectPaths();
  }
}

setup_module_groups() {}

create_deposit_box_interaction(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_85C32DD8822F7B40DA24D7F35A47E9367F0AB0268B2FA4A87321FFE175EAA00607C38EC9D2BFE641CE2F2943A71620");
  waitframe();
  var_1 setHintString(&"_encstr_975B227881372407A3AF4F8185B9F79AE9B178E464E51D51668B0DB9C4F913A9A1293019");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(65);
  var_1 setuserange(72);
  var_1 setusefov(65);
  var_1 sethinttag("_encstr_924D09DB90574133A0B0F4");
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 makeusable();
  var_1.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
  else
    var_1.angles = (0, 0, 0);

  var_1 thread deposit_box_activate(var_1);
  return var_1;
}

create_usb_pickup_interaction(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");
  var_2 setHintString(&"_encstr_A7601FD005BE887572FAA275E4FAE98449A8A1A852AC5135E52DA2B2F568824911");
  var_2 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_2 sethintdisplayrange(200);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(65);
  var_2 sethintonobstruction("_encstr_BD1805CB69C063");
  var_2 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_2 makeusable();

  if(istrue(var_1)) {
    objective_position(level.crypto_key_objective.objectiveindex, var_2.origin + (0, 0, 10));
    objective_setbackground(level.crypto_key_objective.objectiveindex, 2);
  }

  var_2 hudoutlineenable("_encstr_8FCA17B7D5E8C696DCCA664B8D63D7C8AC073A86BE36E50B37");
  level notify("_encstr_A6281232B2E0DE9BA58EAFAEE631BE66B7EA7323");

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    level.key_card_acquired = 1;
    var_2 hide();
    var_2 hudoutlinedisable();
    level thread _id_12501(var_3);
    var_3 scripts\cp\intel\cp_intel::give_intel_weapon("_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3");

    if(istrue(level.spawnhumandogtags))
      level.spawninfluencepoints = 1;

    if(istrue(var_1))
      objective_state(level.crypto_key_objective.objectiveindex, "_encstr_8267056410C669");

    break;
  }

  wait 0.1;
  var_2 delete();
}

_id_12501(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_950B0CEDC4D47D380BD8B50B9D59");
}

create_key_card_interaction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_1.script_noteworthy = "_encstr_8FE01542D8033967C9E6BC8F737063FF7D804A2B1097AD";
  var_1.requires_power = 0;
  var_1.spend_type = "_encstr_A3BA05E0735C50";
  var_1.model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_1.model setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");

  if(isDefined(var_0.angles))
    var_1.model.angles = var_0.angles;
  else
    var_1.model.angles = (0, 0, 0);

  var_1.model hudoutlineenable("_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
  var_1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

tag_key_card_with_head_icon(var_0) {
  level.key_card_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.key_card_headicon, "_encstr_8E781B0D5D19BED2B1BD377D0D0B4E8C83F62D37A3EB8C5A0BD6B77323");
  setheadiconsnaptoedges(level.key_card_headicon, 0);
}

remove_key_card_head_icon() {
  if(isDefined(level.key_card_headicon))
    setheadiconimage(level.key_card_headicon);
}

init_bank_interactions() {
  scripts\cp\cp_interaction::register_interaction("_encstr_8FE01542D8033967C9E6BC8F737063FF7D804A2B1097AD", "_encstr_A3BA05E0735C50", undefined, ::key_card_hint, ::key_card_activate, 0, 0, undefined);
  scripts\cp\cp_interaction::register_interaction("_encstr_AA5822DDDE2040851FFA22208B87DB58B5DF1A55991430162F20C07BA84BD2E1E9133F90", "_encstr_A3BA05E0735C50", undefined, ::elevator_button_hint, ::elevator_button_activate, 0, 0, undefined);
}

delay_then_run_cover_node_spawning(var_0, var_1) {
  level endon("_encstr_B2501A58D910EF09294D0A1F03CFE4E7AA8889ABD0EFA815485D6195");
  wait(var_1);
  level.passive_wave_settings.high_threshold = 18;
  var_2 = 36 - level.spawned_enemies.size;
  level.passive_wave_settings.max_count = max(0, var_2);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
}

delay_then_run_spawn_module(var_0, var_1, var_2) {
  level endon("_encstr_B2501A58D910EF09294D0A1F03CFE4E7AA8889ABD0EFA815485D6195");
  wait(var_1);
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = scripts\cp\cp_modular_spawning::set_wave_ref_override(var_2);
}

_id_1337E(var_0) {
  wait(var_0);
  var_1 = scripts\engine\utility::getStruct("_encstr_BD7614BE0B60D50378F1D3DBD945BB0BD9D7343185D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  foreach(var_4 in var_2)
  var_4 thread _id_1337D(var_1);
}

_id_1337D(var_0) {
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_0.origin, 3000, 10000);
  wait_for_player_nearby(var_0.origin, 3500);
  scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_0.origin);
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_0.origin, 2000, 4000);
}

short_and_long_delay(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.longer_spawn_delay))
    return var_2;
  else
    return var_1;
}

should_run_event(var_0) {
  return 0;
}

spawn_static_trucks() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  level.static_trucks = [];
  level.static_ks_crates = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_BA351053C9283B8F9EDE8A73A6E6AB36D843", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = 0;

    foreach(var_4 in level.static_ks_crates) {
      if(var_4.origin == var_0[var_1].origin)
        var_2 = 1;
    }

    if(!var_2) {
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0[var_1].origin);
      var_4 setModel("_encstr_9BBA2105BB0834A3C7331379F92F63EF4013839BC3287F47574389F2E373776538E121");
      level.static_ks_crates[level.static_ks_crates.size] = var_4;
    }
  }

  level.static_ks_tablets = [];
  var_6 = scripts\engine\utility::getStructArray("_encstr_978811C3EB2F9DE846C7476FDF6B606EE312BB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_6.size; var_1++) {
    var_2 = 0;

    foreach(var_8 in level.static_ks_tablets) {
      if(var_8.origin == var_6[var_1].origin)
        var_2 = 1;
    }

    if(!var_2) {
      var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6[var_1].origin);
      var_8 setModel("_encstr_AC0F124F1E9B20193D13A14B182024D73E38E7E1");

      if(isDefined(var_6[var_1].target))
        var_8.target = var_6[var_1].target;

      var_8 thread activate_ks_on_use();
      level.static_ks_tablets[level.static_ks_tablets.size] = var_8;
    }
  }

  level.static_rpgs = [];
  var_10 = scripts\engine\utility::getStructArray("_encstr_973F0B7A3FE97FE22BE85AB358", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_10.size; var_1++) {
    var_2 = 0;

    foreach(var_12 in level.static_rpgs) {
      if(var_12.origin == var_10[var_1].origin)
        var_2 = 1;
    }

    if(!var_2) {
      var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10[var_1].origin);
      var_12.angles = var_10[var_1].angles;
      waitframe();
      var_12 setModel("_encstr_8FEB147FA8B9B3B856971F85C1834A5978B8F6B8B66E");
      var_12 thread activate_rpgs_on_use();
      level.static_rpgs[level.static_rpgs.size] = var_12;
    }
  }

  level thread spawn_enemy_tanks();
  level thread _id_135FA();
}

spawn_enemy_tanks() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8B7E0A8916375BD71D0BB96D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.altgunnerturret = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";
  level.enemy_tanks = [];

  foreach(var_2 in var_0) {
    level thread scripts\mp\challenges_mp::spawn_enemy_tank(var_2);
    wait(randomintrange(3, 7));
  }
}

_id_135FA() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AD7D0E61765E68984BE3839BEB53D808", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level thread spawn_remote_tank(var_4, "_encstr_8DEF05BDE933E0" + var_1, "_encstr_8F5913AB69D3AA66F1F3EA7FA3206F83D51FE71A5B");
    var_1++;
    wait 1;
  }

  var_0 = scripts\engine\utility::getStructArray("_encstr_92FA1410115A5CCF0CD35282E9D018A827690210FAD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level thread spawn_remote_tank(var_4, "_encstr_8DEF05BDE933E0" + var_1, "_encstr_A9B60CB2B956B597D7C2B12BE48E");
    var_1++;
    wait 1;
  }
}

activate_ks_on_use() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = &"_encstr_95711317D361B6098FB7E75C2D8D2976A9B39B8F3F";
  self setHintString(var_0);
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(self.target))
      var_1.drone_strike_dir_override = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    var_1 thread scripts\cp\crafting_system::giveitembasedoncraftingstruct("_encstr_B8840F126B9D8FF218872D21B7C03CC3CD");
    var_1 thread make_enemies_ignore_you();
    self makeunusable();
    break;
  }

  self delete();
}

make_enemies_ignore_you() {
  scripts\cp\utility::allow_player_ignore_me(1);
  wait 10;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.drone_strike_dir_override = undefined;
}

activate_rpgs_on_use() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = &"_encstr_820811912139AE17E8E5A1977FB3AB2652DD98";
  self setHintString(var_0);
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("_encstr_BECC055CF3811A");
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!var_1 scripts\common\utility::is_weapon_pickup_allowed()) {
      continue;
    }
    var_2 = getentarrayinradius("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", self.origin, 512);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isDefined(var_4.classname) && issubstr(var_4.classname, "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8"))
          var_4 delete();
      }
    }

    var_6 = spawnStruct();
    var_6.loadoutprimary = "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8";
    var_6.loadoutprimaryattachments = ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"];
    var_6.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
    var_6.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
    var_6.loadoutprimaryvariantid = -1;
    var_1.entnumber = var_1 getentitynumber();
    var_6.loadoutprimarypaintjobid = 0;
    var_6.loadoutprimarycosmeticattachment = "_encstr_8BBA05185F8B99";
    var_6.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var_6.loadoutprimary);
    var_6.loadoutprimaryfullname = createheadicon(var_6.loadoutprimaryobject);
    var_7 = var_1 _id_1247D();
    var_8 = var_1 _id_12475();
    var_9 = var_6.loadoutprimaryobject;

    if(!var_1 hasweapon("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8")) {
      if(scripts\cp\cp_weapon::_id_124AD(var_1)) {
        scripts\cp\cp_weapon::minigamefinishcount(var_1);
        var_1 waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

        while(scripts\cp\cp_weapon::_id_124AD(var_1))
          waitframe();

        while(nullweapon(var_1 getcurrentweapon()))
          waitframe();
      }

      if(!var_8) {
        var_1 scripts\cp\cp_weapons::minigun_track_target_think();
        var_1 giveweapon(var_9);
      } else
        var_9 = var_1 raise_airlock();
    }

    var_10 = weaponclipsize(var_9);
    var_11 = weaponmaxammo(var_9);
    var_1 setweaponammoclip(var_9, var_10);
    var_1 setweaponammostock(var_9, var_11);

    if(!var_7 && !scripts\cp\cp_weapon::_id_124AD(var_1))
      var_1 switchtoweaponimmediate(var_9);

    level notify("_encstr_8D4A0EC9C1D9F507961BB5CA19D7BA0E", var_1);
    wait 3;
  }

  self delete();
}

_id_1247D() {
  var_0 = self getcurrentprimaryweapon();

  if(var_0.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8")
    return 1;

  return 0;
}

_id_12475() {
  foreach(var_1 in self getweaponslistprimaries()) {
    if(var_1.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8")
      return 1;
  }

  return 0;
}

raise_airlock() {
  foreach(var_1 in self getweaponslistprimaries()) {
    if(var_1.basename == "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8")
      return var_1;
  }
}

modescorewinner(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_4))
    level endon(var_4);

  if(!isDefined(var_2))
    var_2 = 2000;

  if(!isDefined(var_3))
    var_3 = 1;
  else
    var_3 = max(var_3, 0.05);

  childthread modespawn(var_0, var_1, var_2, var_3);
}

modespawn(var_0, var_1, var_2, var_3) {
  for(;;) {
    var_4 = getentarrayinradius("_encstr_AD580F5F2388E9EB57322E3069A1074090", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_1, var_2);

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isDefined(var_6.classname) && issubstr(var_6.classname, var_0))
          var_6 delete();
      }
    }

    wait(var_3);
  }
}

spawn_remote_tank(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_3)) {
    if(!isDefined(var_3.angles))
      var_3.angles = (0, 0, 0);

    var_4 = scripts\cp\cp_remote_tank::spawn_remote_tank(var_3, var_1);
    var_4 thread scripts\cp\cp_remote_tank::fire_on_nearby_players();
    var_4.enemy_notify_range = 2000;
    var_4.max_detection_sq = 2250000;
    var_4 makeunusable();
    var_4.mgturret makeunusable();
    var_4 thread damage_monitor();
    var_4 thread init_global_cp_script_funcs();
    var_4 thread _id_12BC0(var_0, var_2);
  }
}

_id_12BC0(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_1))
    scripts\engine\utility::flag_wait(var_1);

  scripts\engine\utility::flag_wait("_encstr_8F5913AB69D3AA66F1F3EA7FA3206F83D51FE71A5B");
  wait 5;
  self vehicle_setspeed(1, 1, 1);
  thread _id_145B3(var_0);
}

init_global_cp_script_funcs() {
  var_0 = createnavobstaclebyent(self);
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    destroynavobstacle(var_0);
}

_id_145B3(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = _id_145AD(var_0);
  var_2 = 1;
  var_3 = 3;
  var_4 = 40000;

  if(var_1.size < 2) {
    return;
  }
  var_5 = fire_sfx_org(var_0);
  self startpathnodes(var_1, var_5, 1, 0.5, 0.5, 0, 1);
}

_id_145AD(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

fire_sfx_org(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = 4; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = 8)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

damage_monitor() {
  self endon("_encstr_B27D14935BE2787F5942A9EF0807FFA5B032184C2D15");
  self endon("_encstr_AD75063D571AE108");
  thread _id_13A41();
  self setCanDamage(1);
  self.health = 100000;
  self.currenthealth = 900;
  self._id_13C4F = 900;
  self.currentdamagestate = 0;
  var_0 = 0.25;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_2))
      continue;
    else if(isvector(var_2)) {
      continue;
    }
    if(isDefined(var_2.owner) && !isPlayer(var_2.owner))
      continue;
    else if(!isPlayer(var_2)) {
      continue;
    }
    var_11 = undefined;
    var_12 = "_encstr_A5AE098ADB583E0AF7A5AB";

    if(isDefined(var_10)) {
      if(var_10.basename == "_encstr_8DCB0F47F22330CEE7996B13A2E390583A")
        var_1 = 1000;

      if(var_10.classname == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        var_1 = max(var_1, self._id_13C4F / 2 + 10);
    }

    if(self.currenthealth - var_1 < 0)
      var_11 = 1;

    if(isDefined(var_2)) {
      if(isDefined(var_10)) {
        switch (var_10.basename) {
          case "_encstr_BA730BF8AFF178988293F158B9":
            thread _id_11CBB(6, var_2, var_4);
            break;
          case "_encstr_99410C4B48C39AB7D0CD95B769DB":
            thread _id_13B1B(7, var_2, var_4);
            break;
          default:
            break;
        }

        var_1 = scripts\cp\cp_damage::handleapdamage(var_10, var_5, var_1, var_2);
      }

      if(isDefined(var_2.owner))
        var_2.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var_12, var_11, var_1, 0);
      else
        var_2 thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var_12, var_11, var_1, 0);
    }

    var_13 = isDefined(var_2) && isPlayer(var_2);
    var_14 = isDefined(var_2.owner) && isPlayer(var_2.owner);
    var_15 = isDefined(var_2.classname) && var_2.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_2.owner) && isPlayer(var_2.owner);
    var_16 = var_15 && var_5 == "_encstr_8D4E0A501FCB898912CB3FA3";

    if(var_13 || var_14 || var_16) {
      if(!scripts\cp\utility::tryingtoleave() && isDefined(var_10)) {
        if(var_14)
          var_2 = var_2.owner;

        scripts\cp\cp_agent_damage::addattacker(self, var_2, var_2, var_10, var_1, var_4, var_3, undefined, undefined, var_5);
      }
    }

    if(scripts\engine\utility::isbulletdamage(var_5)) {
      level notify("_encstr_B13A0E93E30AE9A837B27B909BE4B095", self);
      var_1 = var_1 * var_0;
    }

    if(istrue(var_11)) {
      self notify("_encstr_AD75063D571AE108");
      return;
    }

    self.currenthealth = self.currenthealth - var_1;

    if(self.currenthealth <= int(self._id_13C4F / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      continue;
    }

    if(self.currenthealth <= int(self._id_13C4F / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
    }
  }
}

_id_11CBB(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3 = 2025;

  if(isDefined(var_2)) {
    if(distancesquared(var_2, self.origin) > var_3)
      return;
  }

  var_4 = gettime() + var_0 * 1000;

  while(var_4 > gettime()) {
    self dodamage(15, self.origin, var_1);
    wait 1;
  }
}

_id_13B1B(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3 = 2025;

  if(isDefined(var_2)) {
    if(distancesquared(var_2, self.origin) > var_3)
      return;
  }

  var_4 = gettime() + var_0 * 1000;

  while(var_4 > gettime()) {
    self dodamage(125, self.origin, var_1);
    wait 1;
  }
}

_id_13A41() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.attackerdata)) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!isDefined(var_1.guid)) {
        continue;
      }
      if(!isDefined(self.attackerdata[var_1.guid])) {
        continue;
      }
      if(!isDefined(self.attackerdata[var_1.guid].damage)) {
        continue;
      }
      var_2 = 0;

      if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.1)
        var_2 = 1;

      if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.2)
        var_2 = 2;

      if(var_2 >= 1)
        var_1 thread scripts\cp\drone\emp_drone::giverankxp("_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B", scripts\cp\drone\emp_drone::getscoreinfovalue("_encstr_99B31528D8CBCCDB2878F291A13B21683010A506257D8B"));
    }
  }

  playFX(level._effect["_encstr_9B1314A28D9BB23CE1A98BE71818DFDA699FAD1DE523"], self.origin);
  self.mgturret delete();
  self delete();
}

listen_for_enemy_alert() {
  level endon("_encstr_A9B60CB2B956B597D7C2B12BE48E");
  level waittill("_encstr_B13A0E93E30AE9A837B27B909BE4B095", var_0);
  level thread alert_enemy_soldiers();
  scripts\engine\utility::flag_set("_encstr_A9B60CB2B956B597D7C2B12BE48E");
}

proximity_alert() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A9B60CB2B956B597D7C2B12BE48E");
  var_0 = scripts\engine\utility::getStructArray("_encstr_AA5C0BE0B6606B514318224BC0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in level.players) {
      foreach(var_5 in var_0) {
        var_6 = var_5.script_radius * var_5.script_radius;

        if(distance2dsquared(var_3.origin, var_5.origin) < var_6) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      wait 0.1;
    }

    wait 0.1;
  }

  level thread alert_enemy_soldiers();
  scripts\engine\utility::flag_set("_encstr_A9B60CB2B956B597D7C2B12BE48E");
}

alert_enemy_soldiers() {
  var_0 = spawnStruct();
  var_0.type = "_encstr_A5490D5E05C3F8B363F3C8D83B3E43";

  foreach(var_2 in level.spawned_enemies)
  var_2 notify("_encstr_B4580A0740984DFBF2C57BEB", [var_0]);
}

elevator_button_hint(var_0, var_1) {
  if(var_0.floor_num == "_encstr_847206E88696E4C8")
    return &"_encstr_8259280D827D11BA937DA2AB72EBF412522A1A45A4AC156AF22A895195A015A7497D240A9AA235A2C9A8";
  else if(var_0.floor_num == "_encstr_A5A9098A811627ED901DBC")
    return &"_encstr_B6ED2490AF08BB7BC107949F4D2135FBDAA52869146477A2F22BF49545090B077E9EB1403CD4";
  else
    return "_encstr_B40101";
}

elevator_button_activate(var_0, var_1) {
  if(istrue(var_0.elevator_moving)) {
    return;
  }
  var_2 = 1;
  var_3 = 3600;
  var_4 = scripts\engine\utility::getStruct("_encstr_A98C1FE0115B5A83EF579B26B885CC0D9F77E5D1C3BECBAF20A74BD2DB58774BF3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = var_4.origin;

  foreach(var_1 in level.players) {
    if(distance2dsquared(var_1.origin, var_5) > var_3) {
      var_2 = 0;
      break;
    }
  }

  if(!var_2) {
    iprintlnbold("_encstr_96C01FE29029E62B686FA1B5FED3323D53A03A3A78096C9B09458CAD94B9AB85A5");
    return;
  }

  var_0.elevator_moving = 1;
  send_players_to_floor(var_0);
}

send_players_to_floor(var_0) {
  if(var_0.floor_num == "_encstr_847206E88696E4C8") {
    close_elevator_doors("_encstr_BA4C02DF" + var_0.floor_num);
    level.bank_elevator = "_encstr_A5A9098A811627ED901DBC";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_BE7522E351D01433C0ABAF9793FDFA44D9B91DAF2BD8B45AAE3FABEFDFB0329ACBA393B5");
    wait 3;
    var_0.floor_num = "_encstr_A5A9098A811627ED901DBC";
    var_0.elevator_moving = 0;
    open_elevator_doors("_encstr_BA4C02DF" + var_0.floor_num);
  } else if(var_0.floor_num == "_encstr_A5A9098A811627ED901DBC") {
    close_elevator_doors("_encstr_BA4C02DF" + var_0.floor_num);
    level.bank_elevator = "_encstr_AD1F054EBDED33";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_BDF1201B51C5339B7153EBD36B18A51B78493252DB97EB95F0C7E0C727216AAF9881");
    wait 3;
    var_0.floor_num = "_encstr_B40101";
    open_elevator_doors(var_0.floor_num);
  }
}

deposit_box_hint(var_0, var_1) {
  return &"_encstr_975B227881372407A3AF4F8185B9F79AE9B178E464E51D51668B0DB9C4F913A9A1293019";
}

deposit_box_activate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self playSound("_encstr_8A4815D883F5982CB9B6BE23B238DE374B3AAFDE0ECA9B");

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player())
        continue;
    }

    level.deposit_box_search = 1;

    if(istrue(var_0.key_card))
      thread create_key_card(var_0, 1);

    var_0 rotateTo(var_0.angles + (0, 60, 0), 0.25);
    var_0 makeunusable();
  }
}

key_card_hint(var_0, var_1) {
  if(!istrue(var_0.started_hack))
    return &"_encstr_A7601FD005BE887572FAA275E4FAE98449A8A1A852AC5135E52DA2B2F568824911";
  else
    return "_encstr_B40101";
}

key_card_activate(var_0, var_1) {
  if(istrue(var_0.started_hack)) {
    return;
  }
  var_0.started_hack = 1;
  level.key_card_acquired = 1;
  var_0.model hide();
  remove_key_card_head_icon();
}

hvt_skit_notetrack_handler() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_84610D49100897C2DF809A03583BFF", var_0);

    if(!isDefined(var_0))
      var_0 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

    if(!isarray(var_0))
      var_0 = [var_0];

    var_1 = undefined;

    foreach(var_3 in var_0) {
      switch (var_3) {
        case "_encstr_99570D833B0773A33905B9AA33982F":
          thread start_firing();
          var_4 = getEnt("_encstr_97FC09D03B8EF5C8EDED39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
          var_4 playSound("_encstr_929328AB09281F76107FC12B60226E789553325BAEC87357C07FC5EDCF52EE491BBD59CADB5971306AB6");
          break;
        case "_encstr_99050CD1445208885BA7FBA1F7B2":
          self shoot();
          break;
        case "_encstr_ACF70C97A3824F81E6DCC3B805CF":
          self notify("_encstr_ACF70C97A3824F81E6DCC3B805CF");
          break;
        case "_encstr_BD710A0AA0F89B815BB30B1B":
          var_5 = getEnt("_encstr_AF5E0E433BD1FA8C7B7B27BE6C36B438", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
          var_4 = getEnt("_encstr_97FC09D03B8EF5C8EDED39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
          var_4 rotateby((0, 0, 90), 0.35);
          var_5 connectpaths();
          var_5 notsolid();
          var_4 playSound("_encstr_96F1282EFB237667BA59A0B0221467E86769B6256FEBFBA7A76188B82A6AAF40EF0B3208BB7F83D94D2A");
          break;
        case "_encstr_924A091AD051CFEF233EE2":
          level.bank_hvt_usb hide();
          break;
        case "_encstr_82B909C8D28DB7B6B71B5E":
          level.bank_hvt_usb show();
          break;
        case "_encstr_BD960943CE1DBE27DBED33":
          break;
        case "_encstr_86F609B1A5E6DAFA8D4B3B":
          level.bank_hvt_cig linkTo(level.bank_hvt, "_encstr_A1190BD4FABB9396DC47EB8DAC", (2, 1, 0), (0, 0, 0));
          break;
        case "_encstr_843E0A531173F2AB41D9F47F":
          level.bank_hvt_cig unlink();
          level.bank_hvt_cig moveTo(level.bank_hvt_cig.origin + anglesToForward(level.bank_hvt.angles) * 125, 0.35);
          wait 0.35;
          playFX(level._effect["_encstr_926C0836DCF23F7011A3"], level.bank_hvt_cig.origin);
          level.bank_hvt_cig delete();
          break;
        case "_encstr_88CF0D177D8B3A03F7E4A0D0034A83":
          self notify("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
          thread lookat_players();
          break;
        case "_encstr_82880CDCA3B71CF51BB7DE5BB0A3":
          self notify("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
          self setlookatentity();
          break;
        case "_encstr_9ACA0FB1E0A8F32F4329A8A85624845886":
          self notify("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
          self setlookatentity(level.monitor_lookat_ent);
          break;
        case "_encstr_BE0709E4C4E9F16D0258CB":
          self notify("_encstr_82880CDCA3B71CF51BB7DE5BB0A3");
          self setlookatentity();
          break;
      }
    }
  }
}

start_firing() {
  self endon("_encstr_ACF70C97A3824F81E6DCC3B805CF");

  for(;;) {
    self shoot();
    wait(weaponfiretime(self.primaryweapon));
  }
}

delay_and_play_vo_to_team(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  level thread scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

mark_never_remove(var_0) {
  self.never_kill_off = 1;
}

mark_group_as_killable(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0);
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned)
      var_5.never_kill_off = undefined;
    }
  }
}

start_mortars() {
  level.get_mortar_impact_pos = ::get_mortar_impact_spot;
  mortar_launch_think();
}

get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets))
    return undefined;

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["_encstr_BD260953AA97E3F014279D"];
}

mortar_launch_think() {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "_encstr_9B6911FA7B7A08715B506FAEE722489AECDA96");
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9B6911FA7B7A08715B506FAEE722489AECDA96");
  level.rooftop_1_mortar thread mortar_think(1);
  level.rooftop_2_mortar thread mortar_think(2);
  level.rooftop_3_mortar thread mortar_think(3);
}

mortar_think(var_0) {
  self.targets = undefined;

  for(;;) {
    var_1 = get_players_on_rooftop(var_0);

    if(var_1.size) {
      self.targets = var_1;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(self, 1, 500);
      self.targets = undefined;
      wait(randomintrange(10, 20));
      continue;
    }

    wait 1;
  }
}

_id_142EC() {
  if(!isDefined(level._id_121D5))
    level._id_121D5 = gettime() - 1000;

  if(level._id_121D5 > gettime()) {
    return;
  }
  var_0 = ["_encstr_8B322CAA7A48763B469933877F27710729F0250FD5CB86117FFB6A85E327E8E31B10A1026777E71E3483B4F7DA88", "_encstr_93322C3A72D00F9A102FF3C173B86947676832F2BB1D4752689DF1DC25A02DD39D0399BBA37F2F8D70BDEFEFBD82", "_encstr_A1E42CA10B3668508051F187CB8BE9FBE061EA35B78B403B6B2E77047B9F5AEA9003F9E3511E5C084BCDCF9FC71A", "_encstr_86E42C33604ECBAB5718A59E763F1193D168AB9790C33F734BA6EED3DEDFEA48F9E0EF7F50D96FDAB3B07701E649"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
  level._id_121D5 = gettime() + 30000;
}

get_players_on_rooftop(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_B4CF0FD0D9A3BE4EF6DE99AF9B1C2CEEDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1[0];
  var_3 = var_2.origin + (0, 0, -25);
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!var_6 scripts\cp\utility::is_valid_player() || !var_6 isonground() || var_6 isonladder()) {
      continue;
    }
    if(var_6.origin[2] > var_3[2])
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_13F05() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  wait 3;

  while(istrue(self.hostmigrationcontrolsfrozen))
    waitframe();

  if(istrue(self.controlsfrozen))
    scripts\cp\utility::freezecontrolswrapper(0);
}