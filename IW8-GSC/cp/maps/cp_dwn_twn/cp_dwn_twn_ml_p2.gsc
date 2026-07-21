/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p2.gsc
***************************************************/

main() {
  level.mlp2_obj_func = ::register_objectives;
  level.teamnamelist = ["_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08"];
  scripts\engine\utility::flag_init("_encstr_A11D10E6A3B0A396DBE6EB4EAC16C60DB246");
  scripts\engine\utility::flag_init("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  scripts\engine\utility::flag_init("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
  scripts\engine\utility::flag_init("_encstr_92C3115B8D7D078CD7C8EDED936EEBD2734BD1");
  scripts\engine\utility::flag_init("_encstr_96EA126B637D1C19D70D56C6D2D74BDCF5582D39");
  scripts\engine\utility::flag_init("_encstr_A9EE15D2BDBA7321DF35A7D7CDD3702881263628F71FD3");
  scripts\engine\utility::flag_init("_encstr_8E2C0BDA68B71ACA16C59F866D");
  scripts\engine\utility::flag_init("_encstr_957D0E34DB6F66AAC19AB3F8C35379AF");
  scripts\engine\utility::flag_init("_encstr_8576117E152A2528B9C790806FECC35FE33F65");
  scripts\engine\utility::flag_init("_encstr_8E4B13ACD21F6841B39310D87A01076347782F955C");
  scripts\engine\utility::flag_init("_encstr_AAF20FE7C01B7895C939A8CE7081435D65");
  scripts\vehicle\techo::main("_encstr_9AD81367CA0D1CBEB19667EB63CD46AF3A2B6C1AF6", "_encstr_ADA706A3E4BA1BB6", "_encstr_8F1F252BCBDD72E84D7E4E7BE1A95130C521D343A9DFBB539D23108F5DEB987808C68748EAF368");
}

obj_default_init(var_0, var_1) {
  if(isDefined(level.getoverridedvarexceptmatchrulesvalues)) {
    if(level.getoverridedvarexceptmatchrulesvalues == var_0.objname) {
      scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

      if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
        scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

      scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
      scripts\engine\utility::flag_wait("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
      level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123FD();
      level thread mlp2_sh1_trig();
      level thread mlp2_sh2_trig();
      level thread mlp2_sh3_trig();
      wait 5;
      var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
      wait 10;
      scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
    }
  }
}

obj_default_end(var_0) {}

obj_default_beat(var_0) {}

obj_default_start(var_0) {
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123FD();
}

register_objectives() {
  if(!istrue(level.ml_p2_objectives_registered))
    level.ml_p2_objectives_registered = 1;
  else
    return;

  level thread register_spawn_modules();
  level thread _id_13592();
  init_anims();
  scripts\cp\cp_objectives::registerobjective("_encstr_99260FC87D37E87681E74B61EF1A15D0A9", ::obj_default_init, ::ml_p2_get_heli_start, ::obj_default_end, ::obj_default_beat, ::mlp2_mnu_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8E0115ABE9B953BA58D6A82180E7BBF60BD880D9E32EAB", ::obj_default_init, ::mlp2_2_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_971D1169B131E332C1B7B2C03B5D55EF7987C7", ::obj_default_init, ::mlp2_3_start, ::obj_default_end, ::obj_default_beat, ::mlp2_3_mnu_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_8737127DA8D9503FB8C3B3D333D6C3B7F091B3C7", ::obj_default_init, ::ml_p2_interrogate, ::obj_default_end, ::obj_default_beat, ::debug_ml_p2_interrogate_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_A7F419576477B112B9BB175C85F7207928C0E78196770A60566F50", undefined, ::_id_11C5A, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_978817AD6AD79F3249FE535BECA108E89F03DE49E2BBD4A098", undefined, ::_id_11C5A, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_A9F70E8925C9D9736F973080877A333B", ::obj_default_init, ::mlp2_observe_start, ::obj_default_end, ::obj_default_beat, ::mlp2_debug_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_9735132D8DEF709AEF3A812B80387A4085D081E67B", ::obj_default_init, ::mlp2_1_start, ::obj_default_end, ::obj_default_beat, ::obj_default_start);
}

register_spawn_modules() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8ADF118568912A7760A31C084F9F93B25C658F", 12, 12, 12, 0.1, undefined, "_encstr_A9540C5B637D0E8CFA96B947C9DE");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8ADF118568912A7760A31C084F9F93B25C658F", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43", 3, 3, 3, 0.1, undefined, "_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43", ::nuke_startexfilcountdown);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52", 4, 4, 4, 0.1, undefined, "_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52", ::nuke_startexfilcountdown);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B", 12, 12, 12, 0.1, undefined, "_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B", ::_id_1294B);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9B309D6D8C119FA6E3489", 4, 4, 4, 0.1, undefined, "_encstr_A9B309D6D8C119FA6E3489");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9B309D6D8C119FA6E3489", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9B309D6D8C119FA6E3489", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9B309D6D8C119FA6E3489", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_96800BA04DC2756716B817E16E", 1, 1, 1, 0.1, undefined, "_encstr_96800BA04DC2756716B817E16E");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_96800BA04DC2756716B817E16E", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_96800BA04DC2756716B817E16E", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_96800BA04DC2756716B817E16E", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_87800B218D93F566FB23F289A6", 2, 2, 2, 0.1, undefined, "_encstr_87800B218D93F566FB23F289A6");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_87800B218D93F566FB23F289A6", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_87800B218D93F566FB23F289A6", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BAB30977C16802CFDBCB22", 5, 5, 5, 0.1, undefined, "_encstr_BAB30977C16802CFDBCB22");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BAB30977C16802CFDBCB22", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BAB30977C16802CFDBCB22", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BAB30977C16802CFDBCB22", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B1B3096BDCB23A086F1AF3", 3, 3, 3, 0.1, undefined, "_encstr_B1B3096BDCB23A086F1AF3");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1B3096BDCB23A086F1AF3", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1B3096BDCB23A086F1AF3", ::spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1B3096BDCB23A086F1AF3", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7", 13, 13, 13, 0.1, undefined, "_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7", ::shoot_at_heli);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC5B0D3759475F27E8602A891BC827", 3, 3, 3, 0.1, undefined, "_encstr_AC5B0D3759475F27E8602A891BC827");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC5B0D3759475F27E8602A891BC827", ::mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC5B0D3759475F27E8602A891BC827", ::shoot_at_heli_station);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC5B0D3759475F27E8602A891BC827", ::converge_on_players);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BA4B17ED59830AF73B58DBF2E38E7F17D0019D57FFA8668F50", 1, 1, 1, 0.1, undefined, "_encstr_BA4B17ED59830AF73B58DBF2E38E7F17D0019D57FFA8668F50");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BA4B17ED59830AF73B58DBF2E38E7F17D0019D57FFA8668F50", ::setup_interrogate);
  scripts\engine\utility::flag_set("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  level thread create_stair_doors();
}

spawn_in_cover(var_0) {
  if(istrue(self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
    return;
  }
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
    self.script_origin_other = var_3;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}
}

create_stair_doors() {
  wait 5;
  level.ml_p2_doors = [];
  level.ml_p2_doors_clip = [];
  var_0 = ["_encstr_A12C0B08D33F533DA157F088AA"];

  foreach(var_2 in var_0) {
    create_door(var_2);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("_encstr_92C3115B8D7D078CD7C8EDED936EEBD2734BD1");
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
    level.ml_p2_doors[var_0] = var_5;

    if(isDefined(var_2)) {
      var_6 = scripts\engine\utility::getStructArray(var_0 + "_encstr_82DF06F1168568CF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_7 = var_6[0];
      var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7.origin);
      var_8.angles = var_7.angles;
      var_8 clonebrushmodeltoscriptmodel(var_2);
      var_8 disconnectPaths();
      level.ml_p2_doors_clip[var_0] = var_8;
    }
  }
}

connect_ml_p2_doorway_paths() {
  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  var_0 = ["_encstr_BA1210A81D578816E18BFFF7FBC9F6300972"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3)) {
      var_3 connectpaths();
      var_3 notsolid();
    }

    wait 0.1;
  }
}

open_door(var_0) {
  var_1 = level.ml_p2_doors[var_0];
  var_2 = level.ml_p2_doors_clip[var_0];
  var_1 rotateTo(var_1.angles + var_1.open_ang, 0.25);

  if(isDefined(var_2)) {
    var_2 connectpaths();
    var_2 notsolid();
  }
}

mlp2_mnu_start(var_0) {
  wait 5;
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123FD();
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  while(!isDefined(level.players) || level.players.size < 1)
    wait 0.1;

  _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::_id_12118();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AD0213DA63FAC146EB1C1BB0F295277DDCD12C9347");
}

mlp2_3_mnu_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  scripts\engine\utility::flag_wait("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123FD();
  wait 5;
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level thread mlp2_sh1_trig();
  level thread mlp2_sh2_trig();
  level thread mlp2_sh3_trig();
  wait 10;
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A23F0DC16D7315865B1FC0F0CF32BB");
}

mlp2_observe_start(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_873D0DAB1C72FAC8DF7A3BE163E39D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_1[0].origin);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8ADF118568912A7760A31C084F9F93B25C658F");
  thread _id_13526();
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8D152C983B6907CB078FE16F9B3F16EF0B326868A23B916627D5FE5D73BBDE97364AC831DAD5EDDBFFC3FD402982");
  wait 1;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_9735132D8DEF709AEF3A812B80387A4085D081E67B");
}

rear_minigun_attack_min_cooldown(var_0) {
  if(var_0 != "_encstr_AA5606FD1AF05085" && var_0 != "_encstr_AD1904A85C6C" && var_0 != "_encstr_B69B0589C236B6")
    return undefined;

  foreach(var_2 in level.mlp2_vehicles) {
    if(var_2.humanpowersenabled == var_0)
      return var_2;
  }
}

nuke_startexfilcountdown(var_0) {
  thread nuke_startmercycountdown();
}

nuke_startmercycountdown() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9A420F38D2BDC101BF4C90F631EBE8BB67");
  self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

check_player_prox_in_air() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8B1C0BFF284362A1BF653EF24D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = 0;

  while(!var_2) {
    foreach(var_4 in level.players) {
      if(distance2d(var_4.origin, var_1.origin) < 4000) {
        var_2 = 1;
        continue;
      }
    }

    wait 0.1;
  }

  level notify("_encstr_87A11B954031B8E710673B676BAEEBE589094D9D5B084FAAD00F6F3F59");
}

check_player_prox_on_ground() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A58F14CA12E1B22FD0363327ABDD8FD860CEC74F4560", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in level.players) {
      foreach(var_5 in var_0) {
        var_6 = var_5.radius * var_5.radius;

        if(distance2dsquared(var_3.origin, var_5.origin) < var_6)
          var_1 = 1;
      }

      wait 0.25;
    }

    wait 0.1;
  }

  level notify("_encstr_87A11B954031B8E710673B676BAEEBE589094D9D5B084FAAD00F6F3F59");
}

_id_1294B(var_0) {
  var_1 = self;

  foreach(var_3 in level.mlp2_vehicles) {
    if(!isDefined(var_3))
      level.mlp2_vehicles = scripts\engine\utility::array_remove(level.mlp2_vehicles, var_3);
  }

  var_5 = scripts\engine\utility::getclosest(var_1.origin, level.mlp2_vehicles);
  var_1.veh = var_5;
  var_6 = var_5 scripts\common\vehicle_aianim::get_availablepositions();
  var_7 = [];

  if(var_6.availablepositions.size > 1) {
    for(var_8 = 0; var_8 < var_6.availablepositions.size; var_8++) {
      if(istrue(var_6.availablepositions[var_8].canshootinvehicle))
        var_7[var_7.size] = var_6.availablepositions[var_8];
    }
  } else
    return;

  if(!isDefined(var_5.driver))
    var_9 = var_5 scripts\common\vehicle_aianim::choose_vehicle_position(var_1, var_6, 0);
  else if(var_7.size > 0)
    var_9 = var_7[0];
  else
    var_9 = var_5 scripts\common\vehicle_aianim::choose_vehicle_position(var_1, var_6, 0);

  var_1.forced_startingposition = var_9.vehicle_position;
  var_5.usedpositions[var_9.vehicle_position] = 1;
  var_1 scripts\vehicle\vehicle_common::entervehicle(var_5, 1, var_9, scripts\common\vehicle_aianim::anim_pos(var_5, var_1.forced_startingposition));
  var_5.attachedguys[var_5.attachedguys.size] = var_1;
  var_5.riders[var_5.riders.size] = var_1;
  var_1.vehicle_position = var_1.forced_startingposition;
  var_1._id_1376B = var_1.health;
  var_1.health = 500;

  if(var_1.forced_startingposition == 0) {
    var_5.driver = var_1;
    var_1.health = 1000;
  }
}

build_truck_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;
  var_1[var_1.size] = var_2.origin;
  var_3 = 0;

  while(isDefined(var_2) && isDefined(var_2.target)) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1[var_1.size] = var_2.origin;

    if(var_1.size > 30) {
      self.struct_node_path_array[var_3] = var_1;
      var_1 = [];
      var_1[var_1.size] = var_2.origin;
      var_3++;
    }
  }

  self.struct_node_path_array[var_3] = var_1;
}

build_truck_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;
  var_3 = 15;
  var_4 = 0;

  while(isDefined(var_2) && isDefined(var_2.target)) {
    var_5 = var_2;
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_6 = scripts\cp\cp_vehicles::get_duration_between_points(var_5.origin, var_2.origin, var_3, 1);
    var_1[var_1.size] = var_6;

    if(isDefined(var_2.speed) && var_2.speed > 0)
      var_3 = var_2.speed;

    if(var_1.size > 29) {
      var_1[var_1.size] = 4;
      self.struct_node_path_duration_array[var_4] = var_1;
      var_1 = [];
      var_4++;
    }
  }

  var_1[var_1.size] = 4;
  self.struct_node_path_duration_array[var_4] = var_1;
}

ml_p2_get_heli_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  scripts\engine\utility::flag_wait("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  level.initlethalmaxoffsetmap = "_encstr_99260FC87D37E87681E74B61EF1A15D0A9";
  scripts\mp\brclientmatchdata::getprophealth("_encstr_B47A06BDB537ABF6");
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_957A062DA3C7A23F");

  if(!isDefined(level.player_heli))
    _id_13591();

  var_1 = scripts\engine\utility::getStruct("_encstr_A1080B5A8D20531A6171CDDC6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  level thread propwhistletime();
  level thread keep_heli_in_place(var_1.origin, var_1.angles);
  level.initlethalmaxoffsetmap = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  level.initlocationcircle = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_1.origin);
  var_2 = scripts\engine\utility::getStructArray("_encstr_83E40A4D07323571F38DB0AB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_5 = getEntArray("_encstr_B8DA0E131BA0320303FDFA07C2F540EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_6 = var_5[0];

    if(isDefined(var_6)) {
      var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
      var_7.angles = var_4.angles;
      var_7 clonebrushmodeltoscriptmodel(var_6);
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(level.player_heli);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8ADF118568912A7760A31C084F9F93B25C658F");

  while(level.player_heli.occupants.size == 0)
    wait 0.1;

  level._id_124B7 = 1;
  level thread stop_wave_spawning_once_heli_leaves();
  level thread spawn_rpg_guys_when_in_heli();
  level.player_heli scripts\engine\utility::_id_143A5("_encstr_915713ADD8FAE091FA342BC6A5FAE8B0B52B7B3333", "_encstr_AD75063D571AE108");

  if(isDefined(level.player_heli))
    level.player_heli.invulnerable = undefined;

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8ADF118568912A7760A31C084F9F93B25C658F");
  thread vfx_flare(["_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B", "_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7"]);
  thread lootleadermarkweakvalue();
  thread _id_13526();
  wait_for_players_to_call();
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8E0115ABE9B953BA58D6A82180E7BBF60BD880D9E32EAB");
}

_id_13591() {
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  var_0 = scripts\engine\utility::getStruct("_encstr_A1080B5A8D20531A6171CDDC6B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  level.player_heli = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_1);
  level.player_heli setCanDamage(0);
  level.player_heli.invulnerable = 1;
  level.player_heli vehicle_turnengineon();
  level.player_heli.team = "_encstr_9A8507BA4040188D08";
  level.player_heli.health = 10000;
  level.player_heli.maxhealth = 10000;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(level.player_heli);
}

_id_13592() {
  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  var_0 = scripts\engine\utility::getStructArray("_encstr_AF5810CB6EA7904B8FDB491093030349BAAA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = scripts\mp\carriable::_id_131EA(var_2);
    var_3 thread _id_13FB0();
  }
}

_id_13FB0() {
  wait 1;
  self.matchdata_logaward = 1;
  self setleftarc(170);
  self setrightarc(170);
}

propwhistletime() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_AAFD25F2700F766BCB30F4F13E130FBAB1408A7A60E3EB9FE101C2FDD6584786E5A892C2790332");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BE5B2BE5281976239AA762CB47B86093D48F7AC09028039E57EAF9936F83882077BB3378303B96F2C9785F1FF3");
  wait 0.5;
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
  level thread _id_11E1E();
  level.skipburndownmedium = 1;
}

vfx_flare(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(isDefined(var_0) && isarray(var_0) && isDefined(var_3.enemy_group)) {
      var_4 = 0;

      foreach(var_6 in var_0) {
        if(var_3.enemy_group == var_6)
          var_4 = 1;
      }

      if(!istrue(var_4))
        var_3 dodamage(var_3.health + 100, var_3.origin);
    }
  }
}

lootleadermarkweakvalue() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_880D30D9A8C03BC9684FAB9EC577672A8106A0EFA057BC8902E8D0FBC6E0E1F7A580D0730F017B5B9A129B0113A92C415EC2");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_ABC52BC8877D1B1CDCBE36B06EE67DDC470BB6B2B7AE8EBE85B631579B1ABE9C389DAFEEB039CD5AB976FA8918");
}

_id_11E1E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!istrue(level._id_124B7)) {
    wait 60;

    if(!istrue(level._id_124B7))
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A6DE28461EBEB1C137AFB685DAC2EBCD1D58AD95F6EA1DBE85B589ABB90DD7A159365AFA37C2CEEB2606");
  }
}

stop_wave_spawning_once_heli_leaves() {
  var_0 = level.player_heli.origin;
  var_1 = 500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    if(isDefined(level.player_heli)) {
      if(distancesquared(var_0, level.player_heli.origin) > var_2)
        var_3 = 1;
    }

    wait 1;
  }

  level.player_heli notify("_encstr_915713ADD8FAE091FA342BC6A5FAE8B0B52B7B3333");
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

keep_heli_in_place(var_0, var_1) {
  level endon("_encstr_972A0F38C6B0E52BE4BE4B37D70D2B8DA5");
  var_2 = 50;
  var_3 = var_2 * var_2;

  while(!istrue(level._id_124B7)) {
    if(distancesquared(level.player_heli.origin, var_0) > var_3) {
      level.player_heli.origin = var_0;
      level.player_heli.angles = var_1;
    }

    wait 0.1;
  }
}

spawn_rpg_guys_when_in_heli() {
  while(level.player_heli.occupants.size == 0)
    wait 0.1;

  level thread waittill_heli_in_air();
  scripts\engine\utility::flag_wait("_encstr_96EA126B637D1C19D70D56C6D2D74BDCF5582D39");
  level.mlp2_roof_group = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7");
}

shoot_at_heli(var_0) {
  thread shoot_at_player_heli(var_0);
}

shoot_at_player_heli(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level.player_heli setCanDamage(1);
  level.player_heli.invulnerable = undefined;
  scripts\engine\utility::flag_wait("_encstr_96EA126B637D1C19D70D56C6D2D74BDCF5582D39");
  self.health = 10;
  var_1 = 500;
  var_2 = var_1 * var_1;
  wait 2;

  for(;;) {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) < var_2) {
        self.ignoreall = 0;
        self clearentitytarget();
        var_3 = 1;
      }
    }

    if(!var_3) {
      if(isDefined(level.player_heli)) {
        if(isDefined(level.player_heli.occupants) && level.player_heli.occupants.size > 0) {
          self.ignoreall = 0;
          self setentitytarget(level.player_heli);
        } else
          self.ignoreall = 1;
      } else
        self.ignoreall = 0;
    }

    wait 0.1;
  }
}

waittill_heli_in_air() {
  var_0 = level.player_heli.origin;
  var_1 = 500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    if(isDefined(level.player_heli)) {
      if(distancesquared(var_0, level.player_heli.origin) > var_2)
        var_3 = 1;
    }

    wait 1;
  }

  scripts\engine\utility::flag_set("_encstr_96EA126B637D1C19D70D56C6D2D74BDCF5582D39");
}

shoot_at_heli_station(var_0) {
  thread shoot_at_player_heli_station(var_0);
}

shoot_at_player_heli_station(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_A9EE15D2BDBA7321DF35A7D7CDD3702881263628F71FD3");

  for(;;) {
    if(isDefined(level.player_heli)) {
      if(isDefined(level.player_heli.occupants) && level.player_heli.occupants.size > 0) {
        self.ignoreall = 0;
        self setentitytarget(level.player_heli);
      } else
        self clearentitytarget();
    } else
      self clearentitytarget();

    wait 0.1;
  }
}

converge_on_players(var_0) {
  thread converge_after_flag(var_0);
}

converge_after_flag(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_A9EE15D2BDBA7321DF35A7D7CDD3702881263628F71FD3");
  self clearentitytarget();

  if(self.origin[2] > -262 || self.origin[2] < -382) {
    self.combat_func_override = "_encstr_A65B084B38A76BEFC350";
    thread scripts\cp\cp_modular_spawning::shotgunner_combat();
  }
}

kill_off_when_station_reached(var_0) {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
  scripts\cp\cp_modular_spawning::script_kill_ai();
}

mlp2_1_start(var_0) {
  foreach(var_2 in level.players)
  var_2 forceusehinton(&"_encstr_83021F0D14FA115D93BE517527AFD324A48A86A225B2153579F484A4D70DA06262");

  wait_for_players_to_call();
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8E0115ABE9B953BA58D6A82180E7BBF60BD880D9E32EAB");
}

wait_for_players_to_call() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8B1C0BFF284362A1BF653EF24D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[0];
  var_2 = sortbydistance(level.players, var_1.origin);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(level.player_heli.occupants["_encstr_A266062032BD7723"])) {
      if(level.player_heli.occupants["_encstr_A266062032BD7723"] == var_2[var_3])
        continue;
    } else {
      var_2[var_3] call_ai_cellphone();
      return;
    }
  }

  level.players[0] call_ai_cellphone();
}

mlp2_2_start(var_0) {
  if(isDefined(level._id_11C63))
    level._id_11C63 thread _id_11CF9(level._id_11C63);

  scripts\cp\utility::skydivestreamhintdvars("_encstr_957A062DA3C7A23F");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC5B0D3759475F27E8602A891BC827");
  scripts\engine\utility::flag_set("_encstr_835312FE32CA663EBF4B3232A76AD112474F71AB");
  mark_group_as_killable("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43");
  mark_group_as_killable("_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52");
  thread _id_1444B(20, 4500, 8);
  var_1 = scripts\engine\utility::flag_wait_any_return("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6", "_encstr_8576117E152A2528B9C790806FECC35FE33F65", "_encstr_8E4B13ACD21F6841B39310D87A01076347782F955C", "_encstr_AAF20FE7C01B7895C939A8CE7081435D65");

  if(var_1 == "_encstr_8576117E152A2528B9C790806FECC35FE33F65" || var_1 == "_encstr_8E4B13ACD21F6841B39310D87A01076347782F955C") {
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A7F419576477B112B9BB175C85F7207928C0E78196770A60566F50");
    level scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BA583632E1D76C836ED7AD16D6B0BE6EE885ADB27BEAA3D7856B3157CDA1EB33DEC663BDBBD747E4EAB1B6D73259CD4727DB2FB28CD74CC0");
    return;
  } else if(var_1 == "_encstr_AAF20FE7C01B7895C939A8CE7081435D65") {
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_978817AD6AD79F3249FE535BECA108E89F03DE49E2BBD4A098");
    return;
  }

  scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  thread vfx_flare(["_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B", "_encstr_A9B309D6D8C119FA6E3489", "_encstr_96800BA04DC2756716B817E16E", "_encstr_87800B218D93F566FB23F289A6", "_encstr_BAB30977C16802CFDBCB22", "_encstr_B1B3096BDCB23A086F1AF3", "_encstr_AC5B0D3759475F27E8602A891BC827", "_encstr_BA4B17ED59830AF73B58DBF2E38E7F17D0019D57FFA8668F50"]);
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_843D305B3968F2B0205EB5FEF308D74B55A3FFD7EFA54BA7E8602EC3EB280F52A0216B0777D8B2550BAB694F8048741927F1");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_971D1169B131E332C1B7B2C03B5D55EF7987C7");
  scripts\cp\cp_objectives::freeworldid("_encstr_8C9C0B506F3D8E70F059B843F9");
  scripts\cp\cp_objectives::freeworldid("_encstr_A3EC0C5B80F8EBF5DBD93A0210D7");
}

_id_11C5A(var_0) {
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 5;
  logevent_servermatchstart(var_0);
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

logevent_servermatchstart(var_0) {
  if(isDefined(level.objectivestabledata) && isDefined(level.objectivestabledata[var_0.objname])) {
    var_1 = level.objectivestabledata[var_0.objname].index;
    var_2 = level.objectivestabledata[var_0.objname].pathexit;

    if(isDefined(var_2) && var_2 != "_encstr_B40101") {
      foreach(var_4 in level.players)
      var_4 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", var_1);

      return;
    }

    foreach(var_4 in level.players)
    var_4 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", 0);

    return;
  } else {
    foreach(var_4 in level.players)
    var_4 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", 0);
  }
}

_id_1444B(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
  var_3 = level._id_11C63;

  if(!isDefined(var_3)) {
    return;
  }
  var_3 endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  var_3 endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_82DF163210059040BFD1C7E3565A285BC8F09897B3483D2F");
  wait(var_0);
  var_4 = 0;
  var_5 = "_encstr_B20703CEDF";

  for(;;) {
    if(!truck_airdrop(var_3.origin, var_1)) {
      wait 1;
      var_4++;

      if(var_4 >= var_2) {
        scripts\engine\utility::flag_set("_encstr_AAF20FE7C01B7895C939A8CE7081435D65");
        return;
      }

      if(var_5 != "_encstr_A71804587AF2") {
        var_5 = "_encstr_A71804587AF2";
        getbattlepassxpmultiplier("_encstr_958F0995DCC6B01CA59BCE");
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_B6F423AB12570383118185A96C86A4283B4F79B11BB14D3FEE7B7A6416073746B1F29B75FF", "_encstr_9A8507BA4040188D08", 2);
      }

      continue;
    }

    if(var_5 != "_encstr_88950636C6DE9B59") {
      var_5 = "_encstr_88950636C6DE9B59";
      getbattlepassxpmultiplier("_encstr_B1550795F7FAFB3034");
    }

    var_4 = 0;
    wait 1;
  }
}

getbattlepassxpmultiplier(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8E0115ABE9B953BA58D6A82180E7BBF60BD880D9E32EAB").objectiveindex;

  switch (var_0) {
    case "_encstr_B1550795F7FAFB3034":
    default:
      objective_setlabel(var_1, &"_encstr_8CB824340AF511EA727D15D572FA9E1225A2681525AC156A79982426AF44E99C45BE2D5231C4");
      break;
    case "_encstr_958F0995DCC6B01CA59BCE":
      objective_setlabel(var_1, &"_encstr_B6F423AB12570383118185A96C86A4283B4F79B11BB14D3FEE7B7A6416073746B1F29B75FF");
      break;
  }
}

truck_airdrop(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(distance2d(var_4.origin, var_0) <= var_1)
      return 1;
  }

  return 0;
}

_id_13A21() {
  var_0 = rear_minigun_attack_min_cooldown("_encstr_AA5606FD1AF05085");
  var_1 = rear_minigun_attack_min_cooldown("_encstr_AD1904A85C6C");
  var_2 = rear_minigun_attack_min_cooldown("_encstr_B69B0589C236B6");
  level.playerspawndata = var_0;
  level._id_11BDF = var_1;
  level.chopper_carepackage_pilot_selected = var_2;
  var_3 = scripts\cp\cp_objectives::requestworldid("_encstr_8C9C0B506F3D8E70F059B843F9");
  var_4 = scripts\cp\cp_objectives::requestworldid("_encstr_A3EC0C5B80F8EBF5DBD93A0210D7");
  var_5 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8E0115ABE9B953BA58D6A82180E7BBF60BD880D9E32EAB");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    var_5.objectiveindex = scripts\cp\cp_objectives::requestworldid("_encstr_A2EE0DA80FDE63773349A4B65D9A99");
  }

  if(isDefined(var_0)) {
    objective_onentity(var_5.objectiveindex, var_0);
    objective_setzoffset(var_5.objectiveindex, 120);
    objective_setplayintro(var_5.objectiveindex, 1);
    objective_setpings(var_5.objectiveindex, 1);
    objective_setlabel(var_5.objectiveindex, &"_encstr_8CB824340AF511EA727D15D572FA9E1225A2681525AC156A79982426AF44E99C45BE2D5231C4");
    objective_setbackground(var_5.objectiveindex, 1);
    objective_icon(var_5.objectiveindex, "_encstr_820C1B2A6711393A430918D95AC070823E53B18C4833037FCE13C2476B");
    objective_sethot(var_5.objectiveindex, 1);
    objective_state(var_5.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  }

  if(isDefined(var_1)) {
    objective_onentity(var_3, var_1);
    objective_setzoffset(var_3, 120);
    objective_setplayintro(var_3, 0);
    objective_setpings(var_3, 1);
    objective_setlabel(var_3, &"_encstr_A6F62090D85FD087FCB1D78C1CB6D0502221969B071B9D09BE5C6604A816F4F1E161");
    objective_setbackground(var_3, 1);
    objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  }

  if(isDefined(var_2)) {
    objective_onentity(var_4, var_2);
    objective_setzoffset(var_4, 120);
    objective_setplayintro(var_4, 0);
    objective_setpings(var_4, 1);
    objective_setlabel(var_4, &"_encstr_A6F62090D85FD087FCB1D78C1CB6D0502221969B071B9D09BE5C6604A816F4F1E161");
    objective_setbackground(var_4, 1);
    objective_icon(var_4, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_state(var_4, "_encstr_AF5A081BBAC993AC73A3");
  }
}

headicon_range() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_9936160E897DB4CD1D2B1BAFDABAE6ACEAADAF8E39AB6CAD");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BAE9156F1AA183803CD758C9FB4FFBC3DB39E5F6E39A4F");

  if(isDefined(level._id_11CA7)) {
    foreach(var_1 in level._id_11CA7)
    var_1 dodamage(var_1.health * 10, var_1.origin, scripts\engine\utility::random(level.players));
  }
}

_id_13526() {
  headicon_range();
  var_0 = scripts\engine\utility::getStructArray("_encstr_A55B0B9832EA9D16DB6D3BB811", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.mlp2_vehicles = [];

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_2.vehicletype = "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40";
    var_2.script_modelname = "_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382";
    var_2.classname_mp = "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98";
    var_2.script_team = "_encstr_8E8405EA382B2A";
    var_3 = scripts\cp\cp_vehicles::create_ai_plr_vehicle(var_2, "_encstr_B22E0C8072FEF9C04F4F0BF324CF");
    var_4 = level.mlp2_vehicles.size;
    level.mlp2_vehicles[var_4] = var_3;
    var_3.script_disconnectpaths = 0;
    var_3.vehicle_skipdeathmodel = 1;
    var_5 = getdvarint("_encstr_8C5C12B9C6E4AFD8ED9B9DF6BCFA43B285368EA1", 0);
    var_3.health = scripts\engine\utility::ter_op(var_5 > 0, var_5, 25000);
    var_3._id_13AAD = "_encstr_8E8405EA382B2A";
    var_3.humanpowersenabled = var_2.script_noteworthy;
    var_6 = scripts\engine\utility::getStructArray("_encstr_969816E833DF731D81F3D56B817BA9195ACBF1E823BDE967", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 build_truck_path(var_6[var_4]);
    var_3 build_truck_duration(var_6[var_4]);
    var_3 vehicle_teleport(var_6[var_4].origin, var_3.angles);
    var_3.start_node = var_6[var_4];
    var_3 thread _id_14450();
    var_3 thread watch_for_death();
    var_3 thread _id_11CF7();
    var_3 thread _id_11CEA();

    if(var_3.humanpowersenabled == "_encstr_AA5606FD1AF05085")
      level._id_11C63 = var_3;
  }

  wait 0.5;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B");
  var_8 = 0;

  while(!istrue(var_8)) {
    waitframe();
    var_8 = 1;

    for(var_9 = 0; var_9 < 3; var_9++) {
      if(!isDefined(level.mlp2_vehicles[var_9].driver))
        var_8 = 0;
    }
  }

  var_10 = level.mlp2_vehicles[0].driver;
  var_11 = level.mlp2_vehicles[1].driver;
  var_12 = level.mlp2_vehicles[2].driver;
  level thread _id_11CDF();
  level thread mlp2_sh1_trig();
  level thread mlp2_sh2_trig();
  level thread mlp2_sh3_trig();
  var_13 = level._id_11C63.origin;

  while(!truck_airdrop(var_13, 7500))
    waitframe();

  level notify("_encstr_82DF163210059040BFD1C7E3565A285BC8F09897B3483D2F");
  thread lootleaderinstance();

  foreach(var_15 in [var_10, var_11, var_12]) {
    if(isDefined(var_15) && isalive(var_15)) {
      var_15.veh notify("_encstr_87DE08E656DDC158E81A");
      var_15 thread drive_along_path(var_15.veh);
      level thread wait_until_vehicle_at_station(var_15.veh);

      if(var_15.veh.humanpowersenabled != "_encstr_AA5606FD1AF05085")
        var_15.veh thread _id_138D2();
    }

    wait 0.5;
  }

  level notify("_encstr_99971F8731F8FDD33D375FFF835FAA3930BBF1CDC80986EBB77D5B0FB106736BB0");
  waitframe();
  thread _id_13A21();
  level thread _id_12435();
  level thread _id_1435B();
  scripts\engine\utility::flag_wait("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
  mark_group_as_killable("_encstr_91F51565310BCA2919F8DBD3F00D1F2FE330F7F2D8F38B");
}

_id_11CF9(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_86B614095AA7B8F593130B2F5F09BC185932D060C504");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 120);
  objective_setplayintro(var_1, 1);
  objective_setpings(var_1, 1);
  objective_setlabel(var_1, &"_encstr_9AB728A105BE115D9CFA8AAE72D7F48429A21AA8A4B22A6A5E35148C5109E9AA4D15F54A279A288AA18A");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  level waittill("_encstr_99971F8731F8FDD33D375FFF835FAA3930BBF1CDC80986EBB77D5B0FB106736BB0");
  objective_delete(var_1);
  scripts\cp\cp_objectives::freeworldid("_encstr_86B614095AA7B8F593130B2F5F09BC185932D060C504");
}

_id_138D2() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = rear_minigun_attack_min_cooldown("_encstr_AA5606FD1AF05085");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A6("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A", "_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811", "_encstr_957D0E34DB6F66AAC19AB3F8C35379AF");
  self vehicle_setspeedimmediate(0, 300, 300);
  self stoppath(1);
}

lootleaderinstance() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8D152C983B6907CB078FE16F9B3F16EF0B326868A23B916627D5FE5D73BBDE97364AC831DAD5EDDBFFC3FD402982");
  wait 0.5;
  var_0 = scripts\engine\utility::random(level.players);
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_AC1F12285EA231F5C2132F232309B1685674F0A1");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_84A82F8BD8F64323CF802D66FEB7A91BFB883F37C86BAC19C3A1B61BE6A961D32098DBAF50E3CF8339483B53C56939C923");
}

_id_14450() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_957D0E34DB6F66AAC19AB3F8C35379AF");
  self endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");

  while(!isDefined(self.driver))
    wait 1;

  self.driver waittill("_encstr_AD75063D571AE108");
  wait 2;
  self dodamage(self.health * 2, self.origin, scripts\engine\utility::random(level.players));
}

watch_for_death() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(self))
    self delete();
}

drive_along_path(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_AFBB14DCD1B09CA3D2B9CEF5199C2DEC59BEC1C2A31A");
  var_1 = var_0.start_node;
  trial_retrieve_persistent_values(var_0, var_1);
  var_0 waittill("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  var_0 notify("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
}

trial_retrieve_persistent_values(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(level.convoy_speed_override))
    var_0.speed_override = level.convoy_speed_override;
  else
    var_0.speed_override = 12;

  var_2 = var_1;
  var_0.pathing_array = [];
  var_0.pathing_array[var_0.pathing_array.size] = var_1;

  for(var_2.pathing_index = var_0.pathing_array.size; isDefined(var_2) && isDefined(var_2.target); var_0.pathing_array[var_0.pathing_array.size] = var_2) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2.pathing_index = var_0.pathing_array.size;
  }

  if(var_0.pathing_array.size > 27)
    var_0 scripts\cp\cp_vehicles::split_large_pathing_array();

  if(!isDefined(var_0.pathing_arrays))
    var_3 = var_0.pathing_array;
  else
    var_3 = var_0.pathing_arrays;

  var_0 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_3);
}

_id_12435() {
  level endon("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
  wait 20;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A3D73023F0FAB11C6E7DDAB0B585FAB98E0BB5ACDBEAA3FA586B31D5CD1AAF66B7C6D8DEBBFAF6E61D0DACB5DE6756AF4C18");
  wait 35;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_AAC8341987AFC6079BD71B0BDCCDF5E61DB0DA95BD57D1F585DA4CEA3734EBCCED1B8DDBEE7D56E6B26B97AF5AE698B7BACD46FA4CC0");
  wait 30;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_843D305B3968F2B0205EB5FEF308D74B55A3FFD7EFA54BA7E8602EC3EB280F52A0216B0777D8B2550BAB694F8048741927F1");
}

wait_until_vehicle_at_station(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread set_flag_on_death("_encstr_957D0E34DB6F66AAC19AB3F8C35379AF");
  var_0 waittill("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  var_0 scripts\common\vehicle::vehicle_unload();

  foreach(var_2 in var_0.riders) {
    if(isDefined(var_0.driver) && var_0.driver == var_2)
      var_3 = scripts\engine\utility::getStruct("_encstr_BD1B16D56141A20A6841F34A2B5D33D128FF512CEFE0AD47", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_3 = scripts\engine\utility::getStruct("_encstr_AB6E1907093E49B65913C7F707088D600F53C787301A73F6A2BA4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    var_2 setgoalpos(var_3.origin);
  }
}

set_flag_on_death(var_0) {
  level endon(var_0);
  self waittill("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_set(var_0);
}

_id_11CDF() {
  level endon("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");

  if(isDefined(level._id_11C63))
    level._id_11C63 endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");

  level._id_11C63 thread _id_11CDE();
}

_id_11CF7() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  self waittill("_encstr_AFBB14DCD1B09CA3D2B9CEF5199C2DEC59BEC1C2A31A");
  wait 3;
  var_0 = 0;

  while(var_0 < 3 && !istrue(self._id_138DF)) {
    var_1 = self vehicle_getspeed();

    if(var_1 < 5)
      var_0 = var_0 + 0.05;
    else
      var_0 = 0;

    wait 0.05;
  }

  self vehicle_setspeedimmediate(0, 20, 20);
  scripts\common\vehicle::vehicle_unload();

  if(self == level._id_11C63) {
    scripts\engine\utility::flag_set("_encstr_8E4B13ACD21F6841B39310D87A01076347782F955C");

    if(!scripts\engine\utility::flag("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6")) {
      wait 1;
      self dodamage(self.health * 10, self.origin, scripts\engine\utility::random(level.players));
      scripts\engine\utility::flag_set("_encstr_8576117E152A2528B9C790806FECC35FE33F65");
    }
  }
}

_id_11CDE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  self waittill("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_set("_encstr_8576117E152A2528B9C790806FECC35FE33F65");
}

_id_11CEA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  var_0 = squared(256);
  var_1 = self.humanpowersenabled;

  for(;;) {
    wait 0.1;
    var_2 = isDefined(scripts\cp\utility::get_closest_living_player(var_0));

    if(var_2 || istrue(self._id_138DF)) {
      break;
    }
  }

  if(var_1 == "_encstr_AA5606FD1AF05085") {
    if(isDefined(level._id_11BDF))
      level._id_11BDF._id_138DF = 1;
  }

  if(var_1 == "_encstr_AD1904A85C6C") {
    if(isDefined(level.chopper_carepackage_pilot_selected))
      level.chopper_carepackage_pilot_selected._id_138DF = 1;
  }

  self vehicle_setspeedimmediate(0, 20, 20);
  scripts\common\vehicle::vehicle_unload();
  self stoppath(1);
}

_id_1435B() {
  level._id_11C63 waittill("_encstr_AC5318BAF0E867FD11119974D9E9859705E9A143D93717B4E811");
  scripts\engine\utility::flag_set("_encstr_A2AA130EC6B0F2AC9C6ED785A3EBB93A16D1D27BE6");
}

mlp2_3_start(var_0) {
  scripts\mp\brclientmatchdata::getprophealth("_encstr_957A062DA3C7A23F");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B2B52F400BB8D65A238E8A6E5F40811A640E622B8AB37B81286756AB5BE3C9632903DD937129E8BD9281A9286203E9C10A");
  level.initlethalmaxoffsetmap = "_encstr_8E1D11BDF9260B4A7F20E29A087DD7FF985632";

  if(!isDefined(level.enemy_test_trig))
    mlp2_sh2_trig();

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, level.enemy_test_trig.origin + (0, 0, 350));
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);

  while(!scripts\engine\utility::flag_exist("_encstr_BAB30977C16802CFDBCB22") || !scripts\engine\utility::flag_exist("_encstr_A9B309D6D8C119FA6E3489") || !scripts\engine\utility::flag_exist("_encstr_B1B3096BDCB23A086F1AF3"))
    wait 1;

  while(!scripts\engine\utility::flag("_encstr_BAB30977C16802CFDBCB22") || !scripts\engine\utility::flag("_encstr_A9B309D6D8C119FA6E3489"))
    wait 1;

  wait 5;
  wait 1;
  var_1 = 750;
  var_2 = var_1 * var_1;

  for(;;) {
    var_3 = 0;
    var_4 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    foreach(var_6 in var_4) {
      if(distance2dsquared(level.enemy_test_trig.origin, var_6.origin) < var_2)
        var_3 = 1;
    }

    if(!var_3) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_8737127DA8D9503FB8C3B3D333D6C3B7F091B3C7");
}

is_group_dead(var_0) {
  if(!isDefined(level.spawn_module_structs_memory[var_0]))
    return 1;
  else {
    foreach(var_2 in level.spawn_module_structs_memory[var_0]) {
      if(var_2.ai_spawned.size > 0)
        return 0;
    }
  }

  return 1;
}

mlp2_debug_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  scripts\engine\utility::flag_wait("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  level thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123FD();
  var_1 = scripts\engine\utility::getStruct("_encstr_B1DA11BFD1A8033201F8B7FDF029ACEA9E4B0F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  level.player_heli = scripts\cp_mp\vehicles\little_bird::little_bird_create(var_2);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8B1C0BFF284362A1BF653EF24D");
}

debug_ml_p2_interrogate_start(var_0) {
  scripts\engine\utility::flag_set("_encstr_81571457E70D973113DA21E08BE02E9E2B66C348473D");

  if(!scripts\engine\utility::flag_exist("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1"))
    scripts\engine\utility::flag_init("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");

  scripts\engine\utility::flag_wait("_encstr_931B1E0767C2AF53BB7AC05F8DF0C2A947BED2570BC3411F30E8AB9297DCF7F1");
  scripts\engine\utility::flag_wait("_encstr_9BD2291C9708A9533C40614A28977211402B9769F7806F83F01B8BB253E08F5550811DE4635039838090D2");
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  wait 1;
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A23F0DC16D7315865B1FC0F0CF32BB");
}

ml_p2_interrogate(var_0) {
  level notify("_encstr_92DA109B981867AFFDE5F31D471F1BD7DBE0");
  wait_until_interrogation(var_0);
  wait 5;
  scripts\engine\utility::flag_wait("_encstr_8E2C0BDA68B71ACA16C59F866D");
  mark_group_as_killable("_encstr_A9B309D6D8C119FA6E3489");
  mark_group_as_killable("_encstr_BAB30977C16802CFDBCB22");
  mark_group_as_killable("_encstr_B1B3096BDCB23A086F1AF3");
  mark_group_as_killable("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7");
  mark_group_as_killable("_encstr_AC5B0D3759475F27E8602A891BC827");
  mark_group_as_killable("_encstr_8C3A1071A40B8B6F4B4A6011C3E2CBFB9B43");
  mark_group_as_killable("_encstr_ABCD155BC61C23F5CEB483BE3AC9D5B1DAEBE6E08577CD");
  mark_group_as_killable("_encstr_BA7916F9554B2DAE369FB0D1EF6821EF123A78F5EF924F52");
  level.max_agents_override = undefined;
  scripts\cp\cp_modular_spawning::unpause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8AD12F6548A197433B3F60389F41FEEFBBB66A7D65FB716E11EF5080DF903627F35ED6F5FA335FD3FDBBF80833A34E1B4F", "_encstr_9A8507BA4040188D08");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A6F40CE08A377FDAE951EDC1450D");
}

setup_interrogate(var_0) {
  level.int_vips = [];
  level.int_vips[0] = self;

  if(isDefined(level.int_vips_struct))
    level.int_vips_struct.origin = self.origin;

  self.ignoreall = 1;
  self setgoalpos(self.origin);
  thread create_usable_model();
}

create_usable_model() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 50));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_1 = &"_encstr_B14E11E74948C0B2A2FC5DD315D1F7D8A61F33";
  var_0 setHintString(var_1);
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_0 setHintString(&"_encstr_8CCC226828BE22D593EB157572FA7A8492510D152565A8D4F25239A22A494AF43A50A2A8");
  var_0 makeusable();
  var_0 thread use_think(self);
  return var_0;
}

use_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(var_0.being_used)) {
        continue;
      }
      if(istrue(var_1.isjuggernaut)) {
        continue;
      }
      if(istrue(var_1.super_activated)) {
        switch (var_1.super) {
          case "_encstr_AB5C0E833A7B7539E7D67F7BCECFA046":
          case "_encstr_8B290C93058CC8486A2725E99F33":
            continue;
        }
      }

      thread interrogate_guy(var_1);
      return;
    }
  }
}

interrogate_guy(var_0) {
  if(!isDefined(level.int_vips[0]) || !isalive(level.int_vips[0])) {
    return;
  }
  self.being_used = 1;
  self makeunusable();
  var_0.interrogating = 1;
  waitframe();
  level thread doleaderfinalsurrender(var_0, 0);
  self delete();
}

wait_until_interrogation(var_0) {
  scripts\engine\utility::flag_init("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BA4B17ED59830AF73B58DBF2E38E7F17D0019D57FFA8668F50");

  while(!isDefined(level.int_vips))
    wait 0.1;

  level.int_vips[0] thread notify_on_vip_death();
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, level.int_vips[0].origin + (0, 0, 100));
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A346150729FBA9F7D202C0E09AED6721E7C984F4B12350");
  var_1 = 0;
  doleadersurrender(var_1);
  scripts\engine\utility::flag_wait("_encstr_92C3115B8D7D078CD7C8EDED936EEBD2734BD1");
  var_2 = scripts\engine\utility::getStruct("_encstr_BA1210A81D578816E18BFFF7FBC9F6300972", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait_for_player_nearby(var_2.origin, 150, -50, 100);
  open_door("_encstr_A12C0B08D33F533DA157F088AA");
  var_3 = sortbydistance(level.players, level.ml_p2_doors["_encstr_A12C0B08D33F533DA157F088AA"].origin);
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A6B60B3FF019DB0A7FF4944A6D", var_3[0]);
  scripts\engine\utility::flag_wait("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
}

notify_on_vip_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(!scripts\engine\utility::flag("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756")) {
    thread delay_vip_death_vo(1);
    thread give_death_intel();
  }
}

delay_vip_death_vo(var_0) {
  wait(var_0);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B4C1305953AF7E481A9F6F73C5C6693EAB7A30E1CAFF2DF9B6B50543E36CA18B9B43498B833FEC300B95776D191440580E9F", "_encstr_9A8507BA4040188D08");
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

doleadersurrender(var_0) {
  if(isDefined(level.int_vips[var_0]) && isalive(level.int_vips[var_0])) {
    var_1 = level.int_vips[var_0];
    var_1.invulnerable = 1;
    var_1.scripted_mode = 0;
    var_1.ignoreall = 1;
    var_1.dropweapon = 1;
    var_1 scripts\asm\shared\mp\utility::burndowntime("_encstr_974611FB48E03F6A6FEF8797DD167276285172");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8C242E1A52F0EF7AF0CF13E1539849678DE962B218BDCBF9488312FD47F8015738A31A4BC3184FAEB88B37FC511942FA", "_encstr_9A8507BA4040188D08");
    var_1 thread loopidlesurrenderanimation("_encstr_9969166304F341B1E09F2650259B1198B5F7B668AB5DB520");
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

doleaderfinalsurrender(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.int_vips[var_1]) && isalive(level.int_vips[var_1]))
    var_2 = level.int_vips[var_1];
  else
    return;

  thread _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_8E1417E822AB5058AE82272BAC1988807BCAC3339AC7F79047", var_0);
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 notify("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");

  if(istrue(var_0.has_gl)) {
    var_0 scripts\common\utility::allow_weapon_switch(1);
    var_0 scripts\common\utility::allow_weapon_pickup(1);
  }

  var_2.invulnerable = 1;
  var_0.ability_invulnerable = 1;

  if(scripts\cp\cp_weapon::_id_124AD(var_0)) {
    var_0._id_11C3D = var_0.restoreweapon;
    var_0._id_12FB2 = var_0.secondaryweaponobj;
    scripts\cp\cp_weapon::minigamefinishcount(var_0);
    var_0 waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

    for(;;) {
      var_3 = 0;
      var_4 = ["_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB", "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB", "_encstr_8BBA05185F8B99"];

      foreach(var_6 in var_4) {
        var_7 = var_0 getcurrentweapon();

        if(var_7.basename == var_6)
          var_3 = 1;
      }

      if(!var_3) {
        break;
      }

      waitframe();
    }
  }

  var_0.restoreweapon = var_0 getcurrentweapon();
  var_0 disableusability();
  var_9 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_9, undefined, undefined, 1);
  var_10 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_9, 0);
  var_0.gunlessweapon = var_9;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_11 = var_0.angles;
  var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  _id_12DA0(var_2, var_0);
  waitframe();
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_12 = var_2 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", "_encstr_A7E415302870C7C2B7F137035E234056C597FE5905C0A5");
  var_13 = var_2 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_12);
  var_0 thread create_player_rig(var_0, "_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C");
  var_2 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "_encstr_955B0CA2F80DAFA2D09737398940");
  link_player_to_rig(var_0);
  var_0.player_rig hide();
  var_14 = getanimlength(%_encstr_9A602686174107C7055258C1E5B18634482B787A4A60BFB18B0AF02EC781D237C801636B51114DCB);
  var_2 takeweapon(var_2.weapon);
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_15 = _id_136B9(var_2);
  var_15 useanimtree(#animtree);
  var_15.animname = "_encstr_958F07E95AE03A5A95";
  var_16 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2.origin);
  var_16.origin = var_2.origin;
  var_16.angles = var_2.angles;
  var_17 = getstartorigin(var_16.origin, var_16.angles, var_13);
  var_18 = getstartangles(var_16.origin, var_16.angles, var_13);
  var_2 dontinterpolate();
  var_2 forceteleport(var_17, var_18);
  var_0 setplayerangles(var_18);
  var_0 setOrigin(var_17);
  var_15.origin = var_17;
  var_15.angles = var_18;
  waitframe();
  var_0 cameraset("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
  var_0 thread _id_13BCB(var_0, 1);
  var_16 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_955B0CA2F80DAFA2D09737398940");
  var_16 thread scripts\common\anim::anim_single_solo(var_15, "_encstr_955B0CA2F80DAFA2D09737398940");
  var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_12);
  wait(var_14);
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 cameradefault();
  var_0 setplayerangles(var_11);
  var_0 thread _id_13BCB(var_0, 0);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_9);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.ability_invulnerable = undefined;

  if(isDefined(var_2) && isalive(var_2)) {
    level thread give_surrendered_intel(var_0, var_2);
    var_2.angles = var_2.angles + (0, 180, 0);
    var_2 thread loopidlesurrenderanimation("_encstr_994D1A4B60C9F1AF13B8637DC6BB7F4519E89351B85D7727681D7465", 1);
  }

  scripts\engine\utility::flag_wait("_encstr_8E2C0BDA68B71ACA16C59F866D");
  var_0 switchtoweapon(var_0.restoreweapon);

  if(istrue(var_0.has_gl)) {
    var_0 scripts\common\utility::allow_weapon_switch(0);
    var_0 scripts\common\utility::allow_weapon_pickup(0);
  }

  var_16 delete();
  var_0 enableusability();
  var_0.interrogating = 0;
  scripts\cp\utility::_id_123FE("_encstr_99E51F014B2AD962B01FA158A6C83B6922FB13CF5003E1601B92959B2B9073AECB");
}

_id_136B9(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2D9154FD2C1AFD1A556D71AB0CD91C6ABCC33B9D7DD5B");
  var_1.angles = var_0.angles;
  var_0.ziptie = var_1;
  return var_1;
}

_id_13BCB(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5"));
    var_2 setModel("_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365");
    var_2 linkTo(var_0, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5");
    var_0._id_14044 = var_2;
  } else if(isDefined(var_0._id_14044))
    var_0._id_14044 delete();
}

_id_12DA0(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 linkTo(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectortoangles(var_3);
  var_2 rotateTo(var_4, 0.4);
  wait 0.4;
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 forceteleport(var_0.origin, var_4);
  var_2 delete();
}

give_surrendered_intel(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 1;
  scripts\engine\utility::flag_set("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
  var_0 scripts\cp\intel\cp_intel::give_intel_weapon("_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3");
  wait 0.5;
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_8A930C97AA68995BEA3B7D4B225B", var_0);
  scripts\engine\utility::flag_set("_encstr_8E2C0BDA68B71ACA16C59F866D");

  foreach(var_3 in level.players)
  var_3 scripts\cp_mp\xmike109::scriptable_callback("_encstr_92F20B91BDEECDD17BBBB9AF89");
}

test_kill_vip(var_0) {
  wait 2.0;
  var_0 dodamage(var_0.health + 1000, var_0.origin);
}

give_death_intel() {
  scripts\cp\intel\cp_intel::drop_intel_piece();
  level waittill("_encstr_83501271A2A978698F27E223D390D1176F45307A");
  scripts\engine\utility::flag_set("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
}

loopidlesurrenderanimation(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");
  self endon("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693");
  level endon("_encstr_926B153B370D90C0397B625DC7D12753A08B3B79FD1C98");
  var_2 = self;
  self.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self.anchor.angles = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = var_2 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_4 = var_2 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
  var_5 = getanimlength(var_4);
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2.origin);
  var_6.angles = var_2.angles;
  var_7 = getstartorigin(var_6.origin, var_6.angles, var_4);
  var_8 = getstartangles(var_6.origin, var_6.angles, var_4);
  var_2.anchor.origin = var_7;
  var_2.anchor.angles = var_8;
  var_2 dontinterpolate();
  var_2 forceteleport(var_7, var_8);
  var_2 linkTo(self.anchor);
  var_2.scripted_mode = 0;
  var_2.ignoreall = 1;
  thread _id_144B5();

  for(;;) {
    if(istrue(var_1) && isDefined(var_2.ziptie)) {
      var_9 = var_7;
      var_10 = var_8;
      var_6 thread scripts\common\anim::anim_single_solo(var_2.ziptie, "_encstr_A7C5056BD931D1");
    }

    var_2 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
    wait(var_5);
  }
}

_id_144B5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_AA93178DB2C2192B4EAFCCA59B58C6FADCD5E49CCA9B465693", "_encstr_BE741A65D1701C2256D7ABCFB9FD1B5E0899D1EB0829A35A2145EF83");

  if(isDefined(self.anchor))
    self.anchor delete();
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

link_player_to_rig(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.2;

  var_0 playerlinktoblend(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0.25, 0.25);
  wait(var_1);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 1, 1);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_anims() {
  level.scr_animtree["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"] = #animtree;
  level.scr_anim["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"]["_encstr_955B0CA2F80DAFA2D09737398940"] = % _encstr_9A602686174107C7055258C1E5B18634482B787A4A60BFB18B0AF02EC781D237C801636B51114DCB;
  level.scr_eventanim["_encstr_918914838DB0BCB2E47DD237D1ACE4C9B79DB0E87B9C"]["_encstr_955B0CA2F80DAFA2D09737398940"] = "_encstr_82AB168653A12892FFBBD7F38F93FA6428BB7A0D29B8D4DA";
  level.scr_animtree["_encstr_958F07E95AE03A5A95"] = #animtree;
  level.scr_anim["_encstr_958F07E95AE03A5A95"]["_encstr_955B0CA2F80DAFA2D09737398940"] = % _encstr_8FAA27C3485FB2800AD78A631F3DF7EB6D836066E8B87F6E63F0B7B67FB7D5A6839F4834A296914EB7;
  level.scr_animname["_encstr_958F07E95AE03A5A95"]["_encstr_955B0CA2F80DAFA2D09737398940"] = "_encstr_8FAA27C3485FB2800AD78A631F3DF7EB6D836066E8B87F6E63F0B7B67FB7D5A6839F4834A296914EB7";
  level.scr_anim["_encstr_958F07E95AE03A5A95"]["_encstr_A7C5056BD931D1"] = % _encstr_95422B0813C1FF71EB41170D25DBBEB3F53BA0088B651FC92B79900807A3A063DF114823823F37E2778825F717;
  level.scr_animname["_encstr_958F07E95AE03A5A95"]["_encstr_A7C5056BD931D1"] = "_encstr_95422B0813C1FF71EB41170D25DBBEB3F53BA0088B651FC92B79900807A3A063DF114823823F37E2778825F717";
}

call_ai_cellphone(var_0) {
  foreach(var_2 in level.players)
  var_2 forceusehintoff();

  thread scripts\cp\intel\cp_intel::give_intel_weapon("_encstr_A7FB114B37E8958DEB6C58C61BD7C186B7E62B");
  scripts\cp\utility::_id_123FE("_encstr_AA381A45C3B0F9BF0FD692BA98ED8FA19853CCDC7FC83D4335090A13");
  wait 3;
  level notify("_encstr_9A420F38D2BDC101BF4C90F631EBE8BB67");
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_88B212986B8A3631C252740DAB594DB8FBAF6038", self);
}

mlp2_sh1_trig(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_815D0E630BBBA639BBD4F336FB82B0B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, int(var_1.radius), int(var_1.height));
  var_2.target = var_1.target;
  var_2.targetname = var_1.targetname;
  scripts\engine\utility::flag_init("_encstr_A9B309D6D8C119FA6E3489");
  var_2 thread trigger_spawn("_encstr_A9B309D6D8C119FA6E3489");
  scripts\engine\utility::flag_wait("_encstr_A9B309D6D8C119FA6E3489");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_96800BA04DC2756716B817E16E");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87800B218D93F566FB23F289A6");
  scripts\engine\utility::flag_set("_encstr_A11D10E6A3B0A396DBE6EB4EAC16C60DB246");
  level thread _id_138C6();
  thread throw_moltovs_out_windows();

  if(isDefined(var_0)) {
    foreach(var_4 in var_0) {
      if(isalive(var_4))
        var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }
  }
}

_id_138C6() {
  mark_group_as_killable("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_932F0EC8F91362A6AB8F6F3F77D8A3B7");
}

mlp2_sh2_trig(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_ABFE0E8D5850E2397E1172CF41A602EF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, int(var_1.radius), int(var_1.height));
  var_2.target = var_1.target;
  var_2.targetname = var_1.targetname;
  level.enemy_test_trig = var_2;
  var_2 thread trigger_spawn("_encstr_BAB30977C16802CFDBCB22", scripts\engine\utility::getStruct("_encstr_8AAB0C376BF66DB2BEE80DE47BDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

mlp2_sh3_trig() {
  var_0 = scripts\engine\utility::getStruct("_encstr_81900E10A5B05268FB73BF5F3BD34B30", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.origin, 0, int(var_0.radius), int(var_0.height));
  var_1.target = var_0.target;
  var_1.targetname = var_0.targetname;
  var_1 thread trigger_spawn("_encstr_B1B3096BDCB23A086F1AF3");
}

trigger_spawn(var_0, var_1) {
  self endon("_encstr_8F110E9BE8DB83EBB90785DDB95A9B76");
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_init(var_0);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set(var_0);
  var_3 = self.target;
  var_4 = scripts\cp\cp_modular_spawning::run_spawn_module(var_3);
  var_4 thread wait_for_ai_dead(var_0);
}

aud_smoke_grenade_loop() {
  wait 1;
  playsoundatpos((22865, -2282, -438), "_encstr_B4AC1D5AE9F0DF4A4FCFA7D787FA12672B1212E50640A5422A430F8B8393CA");
}

wait_for_ai_dead(var_0) {
  scripts\cp\cp_modular_spawning::wait_for_all_group_dead(self);
  scripts\engine\utility::flag_set(var_0);
}

init_molotov_throw_targets() {
  level.molotov_throw_spots = scripts\engine\utility::getStructArray("_encstr_878C0E5F37D11294A01B19DBB020C7EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.molotov_throw_targets = [];

  foreach(var_1 in level.molotov_throw_spots) {
    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1.target_spot = var_2;
      var_2.throw_loc = var_1;
      var_2.cooldown = 0;
      level.molotov_throw_targets[level.molotov_throw_targets.size] = var_2;
    }
  }
}

throw_moltovs_out_windows() {
  level endon("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  init_molotov_throw_targets();
  level thread force_molotov_throw();

  for(;;) {
    foreach(var_1 in level.molotov_throw_targets) {
      if(var_1.cooldown > gettime()) {
        continue;
      }
      var_2 = var_1.radius * var_1.radius;

      foreach(var_4 in level.players) {
        if(distancesquared(var_4.origin, var_1.origin) < var_2) {
          if(abs(var_4.origin[2] - var_1.origin[2]) < 100) {
            var_5 = try_throw_molotov_at_spot(var_1, var_4);

            if(isDefined(var_5)) {
              var_1.cooldown = gettime() + 15000;
              wait 1;
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

try_throw_molotov_at_spot(var_0, var_1) {
  var_2 = var_0.throw_loc.origin;
  var_3 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_4 = 22500;

  foreach(var_6 in var_3) {
    if(distancesquared(var_6.origin, var_2) < var_4) {
      var_0.throw_loc throw_molotov(var_6, var_1);
      return var_6;
    }
  }

  return undefined;
}

throw_molotov(var_0, var_1) {
  var_2 = var_0;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3) * 450;

  if(isDefined(var_1)) {
    var_5 = self.origin;
    var_6 = (var_1.origin[0], var_1.origin[1], self.origin[2]);
    var_7 = var_6 - var_5;
    var_7 = vectorNormalize(var_7);
    var_4 = var_7 * 450;
  }

  var_8 = var_2 launchgrenade("_encstr_BA730BF8AFF178988293F158B9", self.origin, var_4);
  var_8.owner = var_2;
  var_2 thread scripts\cp\powers\coop_molotov::molotov_used(var_8);
}

force_molotov_throw() {
  level endon("_encstr_B1E51B5B367D3823EB2D9BE82B27E4DBB30B1D59EB6C7BD60E1B564756");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  trigger_hall_molotov();
  var_0 = scripts\engine\utility::getStruct("_encstr_B6D91A1A58C6C67DADDBC67B1DDED9FA8E86E4BDEEEB39C28C5A5DE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_BA2513A1B01BC6BE5BB71BF6D1EDB3EB3A0D937BDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_0.radius;
  var_3 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_4 = var_2 * var_2;

  foreach(var_6 in var_3) {
    if(distancesquared(var_6.origin, var_0.origin) < var_4) {
      if(var_6.origin[2] > var_0.origin[2] - 50) {
        var_1 throw_molotov(var_6);
        scripts\engine\utility::flag_set("_encstr_A9EE15D2BDBA7321DF35A7D7CDD3702881263628F71FD3");
        return;
      }
    }
  }
}

trigger_hall_molotov() {
  var_0 = scripts\engine\utility::getStruct("_encstr_96CC14A10B361BFAB5BDC6B747DE9DFA4785279D5947", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.radius * var_0.radius;

  for(;;) {
    foreach(var_3 in level.players) {
      if(distancesquared(var_3.origin, var_0.origin) < var_1) {
        if(abs(var_3.origin[2] - var_0.origin[2]) < 100)
          return;
      }
    }

    wait 0.1;
  }
}

mark_never_remove(var_0) {
  self.never_kill_off = 1;
}

mark_group_as_killable(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned) {
        var_5.never_kill_off = undefined;

        if(isDefined(var_5._id_1376B))
          var_5.health = var_5._id_1376B;
      }
    }
  }
}

isplayermatched(var_0) {
  wait(var_0);
  self kill();
}