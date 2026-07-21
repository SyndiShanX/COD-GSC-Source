/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1.gsc
**************************************************************/

main(var_0) {
  level.mlp1_obj_func = ::register_ml_p1_objectives;
  scripts\engine\utility::flag_init("_encstr_82BE1548FDB768770147C5DD872A1D783617B6E1A5FE88");
  scripts\engine\utility::flag_init("_encstr_A957215B637D0E4CFA37C116DDDCD733AB37D8475A7BDC6EAFC92B764BCDA395275619");
  scripts\engine\utility::flag_init("_encstr_95CE124E56A59BCCDB27B156AF4CAF93AC2C8CCB");
  scripts\engine\utility::flag_init("_encstr_8C2D1233286360F628CBD833E01A463BE593E9F0");
  scripts\engine\utility::flag_init("_encstr_835312FE32CA663EBF4B3232A76AD112474F71AB");
}

register_ml_p1_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!istrue(level.ml_p1_objectives_registered))
    level.ml_p1_objectives_registered = 1;
  else
    return;

  scripts\cp\cp_objectives::registerobjective("_encstr_A19E0CD5B92F93A976E813639048", ::init_ml_p1_intel, ::start_ml_p1_intel, ::end_ml_p1_intel, ::debugbeatobjective, ::debug_m1_p1_obj_start);
  level thread register_spawn_functions();
  level thread spawn_player_vehicles();
  level thread _id_12BC3();
  level thread fire_rpg_to_target();
  level.stack_patch_waittill_leaf = ["_encstr_827B153826F5D2E6E856B1AF1DC9578DB67DB393DE5D07"];
  level.waittill_any_timeout_no_endon_death_5 = 0;
}

debugbeatobjective(var_0) {}

register_spawn_functions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(!scripts\engine\utility::flag_exist("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA"))
    scripts\engine\utility::flag_init("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");

  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  var_1 = ["_encstr_87690E3ABDBB5939FACD8358EE37CAE4", "_encstr_8B620FB557B92BEADAD7CD3816EEB9B227", "_encstr_9715156CB773DCD19CAED847A5B7CD7D6EE02CDD9BCA93", "_encstr_9A9D1258C9AAE18BE9357A54071B1B91A4F2F9B3"];
  [[var_0]]("_encstr_BD050FA84F3E775521E87A4190454D5F73", 8, 8, 8, 0.1, undefined, var_1);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", ::p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", ::give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", ::alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD050FA84F3E775521E87A4190454D5F73", ::getbattlepassxpultipliertotal);
  [[var_0]]("_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0", 6, 6, 6, 0.1, undefined, "_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0", ::p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0", scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0", ::give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_916E14F8EB71D42BAD316259B80D7B8C193F727FCBB0", scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  [[var_0]]("_encstr_827B153826F5D2E6E856B1AF1DC9578DB67DB393DE5D07", 6, 6, 6, 0.1, undefined, ::proplist);
  [[var_0]]("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", 4, 4, 4, 0.1, undefined, "_encstr_A7240C96DCE8B28DF50E56E46CA1");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", ::p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", ::give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", ::alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28", ::getbattlepassxpultipliertotal);
  [[var_0]]("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", 10, 10, 10, 0.1, undefined, "_encstr_93D60E084DEB4F18F910A0219979C86B");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", ::p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", ::give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", ::alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B64011572299BBA814CF30B1C75561F3429DCD", ::getbattlepassxpultipliertotal);
  [[var_0]]("_encstr_9936160E897DB4CD1D2B1BAFDABAE6ACEAADAF8E39AB6CAD", 4, 4, 4, 0.1, undefined, "_encstr_A2BB09B4DC3AB28DD74C4C");
  [[var_0]]("_encstr_BAE9156F1AA183803CD758C9FB4FFBC3DB39E5F6E39A4F", 4, 4, 4, 0.1, undefined, "_encstr_A2B1074C0BDC5B7DC6");
  [[var_0]]("_encstr_8F6C10E0C4BE4BDC8E95B17D89DEDA31AC9C", 0, 2, undefined, 3, undefined, "_encstr_A65D0A7BF2C7EECFC056052A");

  if(!scripts\engine\utility::flag_exist("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B"))
    scripts\engine\utility::flag_init("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");

  scripts\engine\utility::flag_set("_encstr_A36D18D2CDD2E8AFB90EB0BBE6FA3BF6C6AB5B2BDCD732DE9B2B");
  scripts\engine\utility::flag_set("_encstr_A957215B637D0E4CFA37C116DDDCD733AB37D8475A7BDC6EAFC92B764BCDA395275619");
}

spawn_player_vehicles() {
  if(!scripts\engine\utility::flag_exist("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA"))
    scripts\engine\utility::flag_init("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");

  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  var_0 = scripts\engine\utility::getStructArray("_encstr_B2200F386385F2B29CEB67CA345AC6C62B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_2.team = "_encstr_9A8507BA4040188D08";

    if(!isDefined(var_2.script_noteworthy))
      var_2.script_noteworthy = "_encstr_84D70A6B2BEF3C9B30A67164";

    var_3 = getdvarint("_encstr_B8EE155780D3FFE2479861A37C0D299E59406FF3182B2C", 0);

    if(!var_3)
      var_2.script_noteworthy = "_encstr_84D70A6B2BEF3C9B30A67164";

    var_3 = getDvar("_encstr_B8CD1B1387751FEDAB0A0763A30B907B7AFAB1CB8D03E0E928775E7B32", "_encstr_B40101");

    if(var_3 != "_encstr_B40101")
      var_2.script_noteworthy = var_3;

    switch (var_2.script_noteworthy) {
      case "_encstr_8C190467402B":
        scripts\cp_mp\vehicles\atv::atv_create(var_2);
        break;
      case "_encstr_B4750649E5A638C0":
        scripts\cp_mp\vehicles\jeep::jeep_create(var_2);
        break;
      case "_encstr_B87406412C6229ED":
        scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_2);
        break;
      case "_encstr_84D70A6B2BEF3C9B30A67164":
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
      case "_encstr_B8B407A3E4DEADACDE":
        scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_2);
        break;
      case "_encstr_8C8B075B2BC0B299E0":
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
      case "_encstr_AA41066ED6A58DED":
        scripts\cp_mp\vehicles\cop_car::cop_car_create(var_2);
        break;
      case "_encstr_BE76076250081CE2DF":
        scripts\cp_mp\vehicles\hoopty::hoopty_create(var_2);
        break;
      case "_encstr_8348061DACC643DE":
        scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var_2);
        break;
      case "_encstr_BE4F09FBC308BB87EFD0F1":
        scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_2);
        break;
      default:
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
    }

    wait 0.5;
  }
}

_id_13590() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9ADD0D56DCACB6F2AF3756CDA34E97", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0)
  thread _id_1353B(var_2);
}

_id_1353B(var_0) {
  var_1 = scripts\mp\carriable::_id_131EA(var_0);
  var_1.matchdata_logaward = 1;
}

fire_rpg_to_target() {
  if(!scripts\engine\utility::flag_exist("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA"))
    scripts\engine\utility::flag_init("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");

  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  level._id_13644 = [];
  var_0 = ["_encstr_BDA6081B738B7DB08792", "_encstr_82A60860CA33FBB84772", "_encstr_92A608F832037DA811F3", "_encstr_BEA608788B4481F1D113", "_encstr_8EA6088842732DF841A5", "_encstr_B8A6081085BB58BAF862", "_encstr_ACA608B8D849391199B6", "_encstr_8AA608D065742831F9F2", "_encstr_85A6085438F94274F6EA", "_encstr_95BB0996CDA3CAC6EBC403", "_encstr_A2BB09B4DC3AB28DD74C4C", "_encstr_B1BB09549B7BEACB78C7A2", "_encstr_BABB09D2B91D2B8DF589CC", "_encstr_9AB107F6A973A06F9A", "_encstr_8CB1076E01DB08D7E2", "_encstr_A9B10726C2B9B5FA66", "_encstr_BAB1074BDB9854CF33", "_encstr_B1B10775D135F00876", "_encstr_A2B1074C0BDC5B7DC6", "_encstr_BDC60957B5AABB090527DA", "_encstr_82C609534FB91AEBA896FA", "_encstr_B46407AA20EFFC5F3B", "_encstr_B2640720FFD957B643"];

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3)) {
      var_4 = var_3;

      while(isDefined(var_4) && isDefined(var_4.script_linkto)) {
        var_4 = scripts\engine\utility::getStruct(var_4.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

        if(isDefined(var_4) && isDefined(var_4.script_unload)) {
          var_5 = spawnStruct();
          var_5.modelpart = var_4;

          if(!isDefined(var_3.angles))
            var_3.angles = (0, 0, 0);

          var_5.spawner = var_3;
          var_5.origin = var_4.origin;
          level._id_13644[level._id_13644.size] = var_5;
          break;
        }
      }
    }
  }

  var_7 = 1;
}

proplist(var_0) {
  if(!isDefined(level.modemayconsiderplayerdead)) {
    var_1 = level.ml_p1_obj_loc;
    var_2 = 4000;
    var_3 = scripts\engine\utility::get_array_of_closest(var_1.origin, level._id_13644, undefined, undefined, var_2);

    if(var_3.size > 0) {
      var_4 = min(3, var_3.size);
      var_4 = randomint(int(var_4));
      var_5 = var_3[var_4];
    } else {
      var_4 = randomint(level._id_13644.size);
      var_5 = level._id_13644[var_4];
    }

    level.modemayconsiderplayerdead = var_5.spawner;
  }

  return [level.modemayconsiderplayerdead];
}

_id_12BC3() {
  if(!scripts\engine\utility::flag_exist("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA"))
    scripts\engine\utility::flag_init("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");

  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  var_0 = scripts\engine\utility::getStructArray("_encstr_B8371A8B08C863F9F5A0C5BF80E3133E70C8DF37E846B28233488B77", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  level thread scripts\cp\cp_munitions::_id_12BE1(var_2.origin, 200);
}

give_guy_pacifist_override(var_0) {
  self.pacifist_override = 1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 250000);
  thread kicknullmusicondeath(self);
}

kicknullmusicondeath(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  waitframe();
  var_0 notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
}

spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);
  var_4 = min(var_4, 24);
  return var_4;
}

getbattlepassxpultipliertotal(var_0) {
  var_1 = self;
  var_1 thread getbeingrevivedinternal(var_1);
}

getbeingrevivedinternal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  if(!self.group scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  var_0.goalradius = int(propwaitminigamecleanup(var_0));
}

propwaitminigamecleanup(var_0) {
  if(isDefined(self.spawnpoint.spawnflags) && self.spawnpoint.spawnflags & 512)
    return self.goalradius;

  var_1 = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getclosest(self.spawnpoint.origin, var_1, 1000);

  if(isDefined(var_2))
    return var_2.radius;

  return self.goalradius;
}

alert_when_see_player(var_0) {
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

init_spawn_radius_check_for_modules() {}

_id_11F7F(var_0, var_1) {
  scripts\cp\utility::objective_update("_encstr_A19E0CD5B92F93A976E813639048", undefined, undefined, undefined, undefined, level.intel_level);
  level thread _id_13590();
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD050FA84F3E775521E87A4190454D5F73");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B64011572299BBA814CF30B1C75561F3429DCD");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8F6C10E0C4BE4BDC8E95B17D89DEDA31AC9C");
  level thread _id_1243C("_encstr_9A9D1258C9AAE18BE9357A54071B1B91A4F2F9B3");
  level thread _id_1243C("_encstr_8B620FB557B92BEADAD7CD3816EEB9B227");
  level thread _id_1243C("_encstr_87690E3ABDBB5939FACD8358EE37CAE4");
  level thread _id_1243C("_encstr_9715156CB773DCD19CAED847A5B7CD7D6EE02CDD9BCA93");
  level thread start_mortars();
  level thread _id_1311E();
  level thread _id_135EA("_encstr_8B620FB557B92BEADAD7CD3816EEB9B227", 2000, "_encstr_9936160E897DB4CD1D2B1BAFDABAE6ACEAADAF8E39AB6CAD");
  level thread _id_135EA("_encstr_87690E3ABDBB5939FACD8358EE37CAE4", 3000, "_encstr_BAE9156F1AA183803CD758C9FB4FFBC3DB39E5F6E39A4F");
  scripts\cp\cp_modular_spawning::set_wave_ref_override("_encstr_BE100CD5BFC98B302153BE933F18");
  level thread _id_13095();

  while(level.intel_level < var_1)
    wait 0.5;

  var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  foreach(var_4 in var_2)
  var_4 scripts\cp\cp_modular_spawning::clear_wave_ref_override();

  mark_group_as_killable("_encstr_BD050FA84F3E775521E87A4190454D5F73");
  remove_force_drop_on_group("_encstr_BD050FA84F3E775521E87A4190454D5F73");
  mark_group_as_killable("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28");
  remove_force_drop_on_group("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28");
  mark_group_as_killable("_encstr_B64011572299BBA814CF30B1C75561F3429DCD");
  remove_force_drop_on_group("_encstr_B64011572299BBA814CF30B1C75561F3429DCD");
}

_id_1311E() {
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\cp\cp_modular_spawning::set_wave_ref_override("_encstr_BE100CD5BFC98B302153BE933F18");
}

_id_13095() {
  level.vehicle.spawn_callback_thread = ::_id_130A4;
}

_id_130A4(var_0) {
  var_0._id_11E98 = 1;
  var_0.vehicle_skipdeathcrash = 1;
}

_id_135EA(var_0, var_1, var_2) {
  level endon("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.target == var_0) {
      var_4 = var_6;
      break;
    }
  }

  if(!isDefined(var_4)) {
    return;
  }
  var_8 = var_1 * var_1;
  var_9 = 0;

  while(!var_9) {
    foreach(var_11 in level.players) {
      if(distancesquared(var_11.origin, var_4.origin) < var_8) {
        var_9 = 1;
        break;
      }
    }

    wait 0.25;
  }

  var_13 = scripts\cp\cp_modular_spawning::run_spawn_module(var_2);
}

_id_1243C(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_B81E0EDA1BF51CC4BEB6C293DA2BE4FA" + var_0);
  var_3 = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.target == var_0) {
      var_4 = var_6;
      break;
    }
  }

  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_2, var_4.origin);
  objective_setshowdistance(var_2, 1);
  var_8 = questtimerset(var_0);

  if(isDefined(var_8))
    objective_setlabel(var_2, var_8);

  var_4 thread _id_1294A(var_2);

  for(;;) {
    level waittill("_encstr_8D1D14ADB17D1C98AFA5DCA3CA1BEB3293ED38839523", var_9);

    if(var_0 == var_9.traincar_wait_until_shown) {
      var_10 = var_9.origin;
      var_4 notify("_encstr_8D5A0E96CD1DB28DAF469C7B380EACC8");
      level thread _id_11D8F(var_2, var_10, var_0);
      break;
    }
  }

  for(;;) {
    level waittill("_encstr_83501271A2A978698F27E223D390D1176F45307A", var_11);

    if(var_0 == var_11) {
      level notify(var_0 + "_encstr_A6830D8797ABEBEF7B1FE4B0750529");
      scripts\cp\utility::objective_update("_encstr_A19E0CD5B92F93A976E813639048", undefined, undefined, undefined, undefined, level.intel_level);
      play_intel_pickup_vo();
      break;
    }
  }

  objective_state(var_2, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid("_encstr_B81E0EDA1BF51CC4BEB6C293DA2BE4FA" + var_0);
}

questtimerset(var_0) {
  switch (var_0) {
    case "_encstr_9715156CB773DCD19CAED847A5B7CD7D6EE02CDD9BCA93":
      return "_encstr_91E520A10ABE1175C9EBA2D59CEBA7909454A1A252CAA83579D09E726A8A4AAA8645";
    case "_encstr_87690E3ABDBB5939FACD8358EE37CAE4":
      return "_encstr_B8401946318925499EF753DFCB46BFE2A2B0EFE574C9791787ED55";
    case "_encstr_8B620FB557B92BEADAD7CD3816EEB9B227":
      return "_encstr_996D1D4D39319C41FDC1618701B6C4915251FB51B9D653AFEF487787C0F3AB";
    case "_encstr_9A9D1258C9AAE18BE9357A54071B1B91A4F2F9B3":
      return "_encstr_B69A210DA0F5447572BE2A75727D3D24945434519259546ACB1482A489A40A6A2A7245";
    default:
      break;
  }
}

_id_1294A(var_0) {
  self endon("_encstr_8D5A0E96CD1DB28DAF469C7B380EACC8");
  var_1 = 1500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) < var_2) {
        var_3 = 1;
        break;
      }
    }

    waitframe();
  }

  var_7 = level.train_start_from_struct[self.target];

  if(isalive(var_7)) {
    objective_onentity(var_0, var_7);
    objective_setzoffset(var_0, 90);
  }
}

_id_11D8F(var_0, var_1, var_2) {
  level endon(var_2 + "_encstr_A6830D8797ABEBEF7B1FE4B0750529");
  objective_icon(var_0, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0, var_1);
  wait 2;
  objective_state(var_0, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
}

move_objective_spot_around(var_0, var_1) {
  level endon("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level.ml_p1_intel_locs = [];
  level.intel_drop_chance_inc = 0;
  level.ml_p1_intel_area = 1;
  level._id_12325 = 0;
  scripts\cp\utility::objective_update("_encstr_A19E0CD5B92F93A976E813639048", undefined, undefined, undefined, undefined, level.intel_level);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD050FA84F3E775521E87A4190454D5F73");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB250FF0E796DFED9940A2A9D083A2BF28");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B64011572299BBA814CF30B1C75561F3429DCD");

  while(level.intel_level < var_1) {
    var_2 = get_intel_loc();

    if(isDefined(var_2)) {
      level.ml_p1_intel_locs = scripts\engine\utility::array_remove(level.ml_p1_intel_locs, var_2);
      level.ml_p1_obj_loc = var_2;
      level.ml_p1_intel_drop = 1;
      var_3 = var_0.objectiveindex;
      objective_setplayintro(var_3, 1);
      objective_setplayoutro(var_3, 0);
      objective_setbackground(var_3, 0);
      objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
      objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
      objective_position(var_3, var_2.origin);
      objective_setshowdistance(var_3, 1);
      scripts\cp\cp_objectives::_id_1317E(var_0, var_2.origin);

      if(isDefined(level.ml_p1_obj_spawners)) {
        for(var_4 = 0; var_4 < level.ml_p1_obj_spawners.size; var_4++)
          level.ml_p1_obj_spawners[var_4] = undefined;
      }

      level.ml_p1_obj_spawners = undefined;
      level.trial_combo_died = undefined;
      level.modemayconsiderplayerdead = undefined;
      var_5 = ["_encstr_83501271A2A978698F27E223D390D1176F45307A", "_encstr_8F9C1622904FF22E0E6BB6A47530CFBB4BE02A2AA1976BF3", "_encstr_8D7718BDE3B942E7A1337503B0E8D9E36AD8EA79CA153DA8EC99"];
      var_6 = level scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_5);
      level.ml_p1_intel_drop = undefined;
      level._id_12325 = 0;
      mark_group_as_killable("_encstr_BD050FA84F3E775521E87A4190454D5F73");
      remove_force_drop_on_group("_encstr_BD050FA84F3E775521E87A4190454D5F73");

      if(var_6 == "_encstr_83501271A2A978698F27E223D390D1176F45307A") {
        if(level.intel_level >= var_1)
          level.should_drop_intel_func = undefined;

        objective_state(var_3, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
        scripts\cp\utility::objective_update("_encstr_A19E0CD5B92F93A976E813639048", undefined, undefined, undefined, undefined, level.intel_level);
        play_intel_pickup_vo();
      } else
        scripts\cp\cp_dialogue::play_vo_to_all(proxy_trigger());

      level scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_2.origin);
      continue;
    }

    wait 0.5;
  }

  level notify("_encstr_AFE41C9B47F6E0F5DA7B734BD1B7E47D1939F61C075623BEE0A1B7DCCACD");
}

_id_11CDA() {
  level endon("_encstr_AFE41C9B47F6E0F5DA7B734BD1B7E47D1939F61C075623BEE0A1B7DCCACD");

  for(;;) {
    if(isDefined(level.intel_drops) && level.intel_drops.size > 1)
      level.intel_drops[1] scripts\cp\intel\cp_intel::remove_intel_piece();

    waitframe();
  }
}

_id_12117() {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(6, "_encstr_827B153826F5D2E6E856B1AF1DC9578DB67DB393DE5D07");
  wait 1;

  if(isDefined(level.ml_p1_obj_loc))
    var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_827B153826F5D2E6E856B1AF1DC9578DB67DB393DE5D07");
}

test_intel_loc() {
  var_0 = level.ml_p1_intel_locs[0];
  return var_0;
}

get_intel_loc() {
  level.ml_p1_intel_locs = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = level.ml_p1_intel_locs;
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy)) {
      if(int(var_4.script_noteworthy) == level.ml_p1_intel_area)
        var_2[var_2.size] = var_4;
    }
  }

  var_6 = undefined;

  if(var_2.size > 0) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_7 = 1500;
    var_8 = var_7 * var_7;

    if(level.intel_level == 0)
      var_6 = var_2[0];
    else {
      var_9 = [];

      foreach(var_4 in var_2) {
        if(level.ml_p1_obj_loc != var_4) {
          if(distance2dsquared(var_4.origin, level.ml_p1_obj_loc.origin) > var_8)
            var_9[var_9.size] = var_4;
        }
      }

      var_12 = [];

      foreach(var_4 in var_9) {
        var_14 = 0;

        foreach(var_16 in level.players) {
          var_17 = var_16 getEye();
          var_18 = spawnsighttrace(undefined, var_4.origin + (0, 0, 56), var_17);

          if(var_18 > 0)
            var_14 = 1;
        }

        if(!var_14)
          var_12[var_12.size] = var_4;
      }

      if(var_12.size > 0) {
        if(isDefined(level.ml_p1_obj_loc))
          var_12 = sortbydistance(var_12, level.ml_p1_obj_loc.origin);

        var_6 = var_12[0];
      } else if(var_9.size > 0)
        var_6 = var_9[0];
      else if(level.ml_p1_obj_loc != var_2[0])
        var_6 = var_2[0];
      else
        var_6 = var_2[1];
    }
  }

  level.ml_p1_intel_area++;

  if(level.ml_p1_intel_area > 4)
    level.ml_p1_intel_area = 1;

  return var_6;
}

_id_11CF6(var_0) {
  for(;;)
    wait 1;
}

_id_11C59(var_0) {
  switch (level.intel_level) {
    case 0:
      _id_123CB("_encstr_8F87127B98D4AFB1ED8D8D596C47D799A5E46EA3", var_0);
      break;
    case 1:
      _id_123CB("_encstr_B44814379D0889EFD0E0B22AE9B5E7FEC01FA4883B90", var_0);
      break;
    case 2:
      _id_123CB("_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE", var_0);
      break;
    case 3:
      _id_123CB("_encstr_B44814379D0889EFD0E0B22AE9B5E7FEC01FA4883B90", var_0);
      break;
    case 4:
      _id_123CB("_encstr_A7B8185ACDFC6F4AB05F8B9F216057971DDE72A2C84F3BC71003", var_0);
      break;
    default:
      _id_123CB("_encstr_9A3A14FF46D86986BD1DA23DFB95B1CF35524AE350BE", var_0);
      break;
  }
}

play_intel_pickup_vo() {
  switch (level.intel_level) {
    case 0:
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(0));
      break;
    case 1:
      scripts\engine\utility::flag_set("_encstr_95CE124E56A59BCCDB27B156AF4CAF93AC2C8CCB");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(1));
      break;
    case 2:
      scripts\engine\utility::flag_set("_encstr_8C2D1233286360F628CBD833E01A463BE593E9F0");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(2));
      break;
    case 3:
      scripts\cp\utility::_id_123FE("_encstr_884819B65DE6BE8D0E7D5BDE7356E5BE99B4E616D87D4BDC472BB1");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(4));
      break;
    case 4:
      break;
    case 5:
      break;
    default:
      break;
  }
}

publiceventsenabled(var_0) {
  if(!isDefined(level.traincolignorelist))
    level.traincolignorelist = ["_encstr_ACB92C32425956E828DE1C422AD92FD8D7E391F16D71A8F8A86B2BB9C3BDFD15C9C0C07B6507BB1D44D025AF43E3", "_encstr_8B202E616041515B207E87705250EF35F89EE0085B1840A869EA24A0EAC3BBBBB9DDD7C9D717186DE05BF1E00B09CE0A", "_encstr_91472BF1B369174376561AA3431F2FC37FFEF1D9808E018322768C90E8FF659E275BA328EF99306BE3C36F875B", "_encstr_818D2C32E1EB8D076ED7B60BB616BEADDE312D1B2B7D43CAB4373A7DC17B3A95E6A3D2B0D8FAB15658C8DC7D4C06", "_encstr_B8832EF868B7462856217F89A109E1D202FDD09A6D11CB4FC08B23DE486D850FC267F0DDC997BFDDBDC7665CE3DEF29F"];

  return level.traincolignorelist[var_0];
}

proxy_trigger() {
  if(!isDefined(level.transient_world_proxy_cull_playspace_proxies) || level.transient_world_proxy_cull_playspace_proxies.size == 0)
    level.transient_world_proxy_cull_playspace_proxies = ["_encstr_BD8A2AC7E35FD29883094B87907B7FFAE7760C7DC5371AD5E8402377B8132D6259AF12F2B8D9131D11392ED2", "_encstr_B18A2AD5909781112A09600B23C29798FF32EB59E5EFA87394D358E91B1A8B510BE76ECF77EBD34BBF39629A", "_encstr_A68A2AC81EAF6CE06EBE8D589BCDEBB6B7262D8D2BFA8695B4CDE8EB37E2AB16C8F5B9E0ED47A3AC32BECCC0", "_encstr_AC8A2AC9E25FFEBBDBC9141893021798A8B25FA1DAC183BB085BE330B78BABCB4FC19B4B82EB419A0AE09F4A", "_encstr_A78A2A8CE1EB1B1C37D78D16CD37F5B5ED98A51BCAD786AC4B37D1EB6E2E570B46BEE638B73A8E56467D9A03"];

  var_0 = scripts\engine\utility::random(level.transient_world_proxy_cull_playspace_proxies);
  level.transient_world_proxy_cull_playspace_proxies = scripts\engine\utility::array_remove(level.transient_world_proxy_cull_playspace_proxies, var_0);
  return var_0;
}

end_p1_spawn_loop(var_0) {
  level waittill("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level notify("_encstr_96AD06373AB7837D" + var_0 + "_encstr_A3850616E56F783F");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
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

debug_m1_p1_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E");
  _encstr_A2183F376C4E4B83E8E6F2B183E5DA2CE06EE56C1CEB91BBE6D7A3DD9BE5BD31D4ACD8E82DD92B6ECB6CC1FA8CEEB9EBE8DDB9FA37B0CCB286DE576ECAB8B3CD1B::_id_12118();
}

debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("_encstr_88241F99F0F7282C631E75574D8F400A99B38F07E293DA47403F8192F6F2BCD054");

  if(!scripts\engine\utility::flag_exist("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA"))
    scripts\engine\utility::flag_init("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");

  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");

  switch (var_0.ref) {
    case "_encstr_911F1603980DB02187A8BB03EA756DC8AF5517D81E5B8DE3":
      break;
    case "_encstr_A627153BB0EAD8A37D2CB96EC2BAD847AFC693CBC147F6":
      break;
    default:
      break;
  }
}

short_and_long_delay(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.longer_spawn_delay))
    return var_2;
  else
    return var_1;
}

make_enemies_ignore_you() {
  scripts\cp\utility::allow_player_ignore_me(1);
  self waittill("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047");
  scripts\cp\utility::allow_player_ignore_me(0);
  self.drone_strike_dir_override = undefined;
}

init_ml_p1_intel(var_0, var_1) {
  scripts\engine\utility::flag_set("_encstr_88241F99F0F7282C631E75574D8F400A99B38F07E293DA47403F8192F6F2BCD054");
  scripts\engine\utility::flag_wait("_encstr_AB4129E361799F57B87EDBD3601877D52109C957DFB867D75DD1619BA9E65F0A90EF13FF6B50ED8F05C9CA");
  scripts\engine\utility::flag_wait("_encstr_A957215B637D0E4CFA37C116DDDCD733AB37D8475A7BDC6EAFC92B764BCDA395275619");

  if(getdvarint("_encstr_AFDC1A371B27FA5DE695F5C193ACAFBB85CE2BF59B0758EECDD237B3", 1)) {
    if(scripts\engine\utility::flag_exist("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F"))
      scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");

    var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_859E1A0FAA628FC349FB30E9C770D9073A94881C49CA97A80FEB9878");
  }

  var_3 = var_0.objectiveindex;
  objective_state(var_3, "_encstr_83B306C13570D0CB");
  scripts\cp\utility::objective_update("_encstr_A19E0CD5B92F93A976E813639048", undefined, undefined, undefined, undefined, 0);
  level.max_agents_override = 30;
  level.initlethalmaxoffsetmap = "_encstr_A19E0CD5B92F93A976E813639048";
  scripts\cp\utility::skydivestreamhintdvars("_encstr_B47A06BDB537ABF6");
  level.initlethalmaxoffsetmap = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";
  level.initlocationcircle = "_encstr_82390E2DA1E3D88DCFBACBF3825F49D0";

  if(!isDefined(level.player_heli))
    _encstr_868D30B8AF5230F953D2904EEA1E3BF9B877D2804B27E9BFDAF1354C45366F832FC388608FA4435591652140DABF2DA96B67::_id_13591();
}

start_ml_p1_intel(var_0, var_1) {
  if(!isDefined(level.intel_level))
    level.intel_level = 0;

  var_2 = getdvarint("_encstr_8D0111DCD8C9FAB95DB67D1C62F54BDC1D56B1");

  if(var_2 == 0)
    var_2 = 4;

  if(!getdvarint("_encstr_AFDC1A371B27FA5DE695F5C193ACAFBB85CE2BF59B0758EECDD237B3", 1))
    var_3 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

  level thread _id_123FD();
  level thread play_vo_on_intel_drop();
  scripts\cp\utility::_id_123FE("_encstr_BA2E135BABDCFA6C38EBADB773B25E7D9B8E2CC9E8");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A3C8221A52F0EF7AF0CF14E16F08491FB789422259A8BB7708BF04D765288C673CC65F6F");

  if(getDvar("_encstr_833C171E3A775FEC20213124CB0F6FA07B94B69BC3E717826B", "_encstr_B40101") != "_encstr_A19E0CD5B92F93A976E813639048") {
    level notify("_encstr_AC3D15D812CD07339F9B5FC465ABF8CBF26AB1789AA575");
    level waittill("_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9");
  }

  _id_11F7F(var_0, var_2);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8F6C10E0C4BE4BDC8E95B17D89DEDA31AC9C");
  wait 5;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BD8A2AC7E35FD29883094B87907B7FFAE7760C7DC5371AD5E8402377B8132D6259AF12F2B8D9131D11392ED2");
  wait 3;
  level._id_139B5 = 0;
  scripts\engine\utility::flag_set("_encstr_95CE124E56A59BCCDB27B156AF4CAF93AC2C8CCB");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8EDF2432F0EB6C0ECDEB360B9B37D7B6ED4C2DC62B7D1AB2B46EE8AFD4C2B1ADC1BDA3AFC418");
  wait 0.5;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9A2E24A2205F061BBB60A3A10181DFCD5768FA9A60873C87D05EA4E7AAA9E794D168B32122F1");
  wait 0.1;
}

end_ml_p1_intel(var_0, var_1) {
  setDvar("_encstr_921F18B98D9C7DD8DECE56C9AF73ED2356FA6E1C85DD73A5373B", 0);
  setDvar("_encstr_96FB1AC7CF3EF16F8878B031D3D8BB8B1B4D07FF97675A4F50206D07", 0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_937B11C2AD4CA595E6E8D78362FA4BE6D1AC63");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F");
  level notify("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level.no_intel_drops = 1;
  level.should_drop_intel_func = undefined;
  level.max_agents_override = undefined;
  level.vehicle.spawn_callback_thread = undefined;
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_99260FC87D37E87681E74B61EF1A15D0A9");
}

_id_123CB(var_0, var_1) {
  var_2 = var_1;

  if(!isDefined(var_1))
    var_2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));

  var_3 = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, var_0);

  if(isfloat(var_3))
    wait(var_3);
}

play_vo_on_intel_drop() {
  level endon("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  level.train_delay_handler = ::_id_11C59;
  level waittill("_encstr_8D1D14ADB17D1C98AFA5DCA3CA1BEB3293ED38839523");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A6A1307CCBF7F392C76FC22F4F9F863520518F1AEAD1A40ACFEB3B8EE1F39BFB6B59B3484F055820F1FD8D70674A7131B257");
}

create_spawn_structs_in_radius(var_0) {
  if(isDefined(level.ml_p1_obj_spawners))
    return level.ml_p1_obj_spawners;

  var_1 = level.ml_p1_obj_loc;
  var_2 = [];
  var_3 = 6;
  var_4 = 100;
  var_5 = randomint(2);
  var_6 = [];
  var_7 = ["_encstr_8F2E08B9DADBDA9637B3", "_encstr_A2A70BE63DEBD0DF7AEA0808D2"];

  for(var_8 = 0; var_8 < var_5; var_8++)
    var_6[var_8] = randomint(var_3);

  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_10 in var_2) {
      var_10.script_origin_other = var_1.origin;
      var_10.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
    }
  }

  if(var_2.size < 6) {
    for(var_8 = -1; var_8 < 2; var_8++) {
      for(var_12 = -1; var_12 < 2; var_12++) {
        var_13 = (var_8 * var_4, var_12 * var_4, 0);
        var_10 = spawnStruct();
        var_14 = getclosestpointonnavmesh(var_1.origin + var_13);
        var_15 = (var_14[0], var_14[1], var_1.origin[2]);
        var_16 = scripts\engine\utility::drop_to_ground(var_15 + var_13, 100, -1000);

        if(abs(var_15[2] - var_16[2]) > 100) {
          continue;
        }
        var_10.origin = var_14;
        var_10.angles = (0, 0, 0);
        var_10.script_forcespawn = 1;
        var_10.script_origin_other = var_15;

        if(isDefined(var_1.radius))
          var_10.script_radius = var_1.radius;
        else
          var_10.script_radius = 512;

        var_10.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";

        if(isDefined(var_6[var_2.size]))
          var_10.script_animation_type = scripts\engine\utility::random(var_7);

        var_2[var_2.size] = var_10;
      }
    }
  }

  level.ml_p1_obj_spawners = var_2;
  return level.ml_p1_obj_spawners;
}

test_spawn_locations() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    level.ml_p1_obj_loc = var_2;
    create_spawn_structs_in_radius();
    wait 0.1;
  }
}

get_p1_intel_group_spawner(var_0) {
  if(!isDefined(level.trial_combo_died)) {
    level.trial_combo_died = 1;
    level thread _id_11B02(var_0);
  }

  return create_spawn_structs_in_radius(var_0);
}

p1_intel_after_spawn_func(var_0) {
  self.never_kill_off = 1;
  self._id_11E50 = 1;
  self.a.disablelongdeath = 1;
  thread little_bird_mg_cp_onentervehicle();
  var_1 = scripts\engine\utility::getStructArray("_encstr_9B0A15856B895A2B37E8D7A5DCD1CAC6FA9C8591B4EADC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1, 1000);

  if(isDefined(var_2)) {
    if(!issubstr(var_0.group_name, "_encstr_8D4708E790B3E4FA7D8B"))
      self.script_origin_other = var_2.origin;

    self.traincar_wait_until_shown = var_2.target;
    self.goal_radius = var_2.radius;
  }

  if(isDefined(self.spawnpoint.script_animation_type)) {
    if(self.spawnpoint.script_animation_type == "_encstr_A2A70BE63DEBD0DF7AEA0808D2") {
      level.train_start_from_struct[self.spawnpoint.targetname] = self;
      thread mine_launch_vfx();
    }
  }
}

mine_launch_vfx() {
  self endon("_encstr_B8CB0F83F5B80B7848302F39C8A8A49281");
  level endon("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  var_0 = self.traincar_wait_until_shown;
  self waittill("_encstr_AD75063D571AE108");
  var_1 = self.origin;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.traincar_wait_until_shown = var_0;
  var_2.angles = (0, 0, 0);
  var_2 thread scripts\cp\intel\cp_intel::drop_intel_piece();
  var_2 scripts\engine\utility::delaycall(0.25, ::delete);
}

little_bird_mg_cp_onentervehicle() {
  scripts\engine\utility::waittill_any_ents_return(level, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", self, "_encstr_92600D68A25B83032F3BE8D112FF0B");
  waitframe();
  self.a.disablelongdeath = 1;
}

_id_11B02(var_0) {
  level thread _id_12326(15);
  level waittill("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
  level._id_12325 = 1;
  var_1 = [];

  foreach(var_3 in var_0.ai_spawned) {
    if(isalive(var_3))
      var_1[var_1.size] = var_3;
  }

  var_5 = scripts\engine\utility::random(var_1);
  var_5.force_intel_drop = 1;
  var_5.force_drop = "_encstr_A98F06181E4BCA85";
  level notify("_encstr_AA06140E347B9BCAAF3B4EF657C17D6E07B0DD372B32");
}

_id_12326(var_0) {
  level endon("_encstr_83501271A2A978698F27E223D390D1176F45307A");
  level endon("_encstr_8F9C1622904FF22E0E6BB6A47530CFBB4BE02A2AA1976BF3");
  level endon("_encstr_8D7718BDE3B942E7A1337503B0E8D9E36AD8EA79CA153DA8EC99");
  level endon("_encstr_AA06140E347B9BCAAF3B4EF657C17D6E07B0DD372B32");
  wait(var_0);
  level._id_12325 = 1;
}

mark_group_as_killable(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned)
      var_5.never_kill_off = undefined;
    }
  }
}

remove_force_drop_on_group(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned)
      var_5.force_drop = undefined;
    }
  }
}

get_new_intel_dropper() {
  self.force_intel_drop = 1;
  self waittill("_encstr_AD75063D571AE108");
  level.intel_dropper = undefined;
}

should_drop_intel(var_0) {
  if(!istrue(level.ml_p1_intel_drop))
    return 0;

  if(!istrue(level._id_12325))
    return 0;

  if(isDefined(level.intel_drops) && level.intel_drops.size > 0)
    return 0;

  var_1 = 0;

  foreach(var_3 in level.spawned_enemies) {
    if(isalive(var_3)) {
      if(isDefined(var_3.force_drop) && var_3.force_drop == "_encstr_A98F06181E4BCA85")
        var_1 = 1;
    }
  }

  if(!var_1) {
    if(!self isonground())
      return 0;

    if(isDefined(self.ridingvehicle))
      return 0;

    if(gettime() - level.waittill_any_timeout_no_endon_death_5 > 5000) {
      level.waittill_any_timeout_no_endon_death_5 = gettime();
      return 1;
    }
  }

  if(istrue(self.force_intel_drop)) {
    level.waittill_any_timeout_no_endon_death_5 = gettime();
    return 1;
  }

  return 0;
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
  level._id_13C0B = getEnt("_encstr_818914EB47631AFB1712FDAFEBF03BF6603F324C305D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13C0B hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  level._id_13C0C = getEnt("_encstr_B2E71688975F89C5E9CF36B0A3122136BD7F20A317F2863D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13C0C hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level._id_13C0B thread mortar_think();
  level._id_13C0C thread mortar_think();
}

mortar_think() {
  level endon("_encstr_BE181359DC91F58398F5E6380BBBB9EB1BBDED83E6");
  self.targets = undefined;

  for(;;) {
    var_0 = race_countdown_update();

    if(var_0.size) {
      self.targets = var_0;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(self, 1, 500);
      self.targets = undefined;
      wait(randomintrange(10, 20));
      continue;
    }

    wait 1;
  }
}

race_countdown_update() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self._id_12A0A = var_1;
  var_2 = self._id_12A0A.radius;
  var_3 = var_2 * var_2;

  foreach(var_5 in level.players) {
    if(var_5 isparachuting()) {
      continue;
    }
    if(!var_5 isonground()) {
      continue;
    }
    if(distancesquared(var_5.origin, self._id_12A0A.origin) < var_3)
      var_0[var_0.size] = var_5;
  }

  return var_0;
}

_id_123FD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_92DA109B981867AFFDE5F31D471F1BD7DBE0");

  for(;;) {
    if(istrue(level.wave_cooldown_active)) {
      if(scripts\engine\utility::flag("_encstr_95CE124E56A59BCCDB27B156AF4CAF93AC2C8CCB")) {
        scripts\engine\utility::flag_clear("_encstr_95CE124E56A59BCCDB27B156AF4CAF93AC2C8CCB");
        scripts\cp\utility::_id_123FE("_encstr_8B45191A6376AF0E585F859F252850671E99D2B2A9C043469877D1");
      }

      if(scripts\engine\utility::flag("_encstr_8C2D1233286360F628CBD833E01A463BE593E9F0")) {
        scripts\engine\utility::flag_clear("_encstr_8C2D1233286360F628CBD833E01A463BE593E9F0");
        scripts\cp\utility::_id_123FE("_encstr_864519B5D5DCBE1B38FAB67B37B25ED727B2B4E6CCB7E48D56BE23");
      }

      if(scripts\engine\utility::flag("_encstr_835312FE32CA663EBF4B3232A76AD112474F71AB")) {
        scripts\engine\utility::flag_clear("_encstr_835312FE32CA663EBF4B3232A76AD112474F71AB");
        scripts\cp\utility::_id_123FE("_encstr_A545190560A381E080AED337055F7809BA5D9F60E067B3C037EFBF");
      }
    }

    waitframe();
  }
}