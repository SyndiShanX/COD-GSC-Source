/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_spawning_util.gsc
***********************************************/

enable_juggernaut_move_behavior(var_0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79"))
    self.juggernautdisablemovebehavior = undefined;
}

disable_juggernaut_move_behavior(var_0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79"))
    self.juggernautdisablemovebehavior = 1;
}

enable_cover_node_behavior(var_0) {
  self.combatmode = "_encstr_B68E06D8F6B3CA27";
}

disable_cover_node_behavior(var_0) {
  self.combatmode = "_encstr_821109FAE81117DA568730";
}

end_objective_when_all_dead(var_0, var_1, var_2, var_3) {
  var_0 thread end_objective_when_all_dead_interal(var_0, var_1, var_2, var_3);
}

end_objective_when_all_dead_interal(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");

  if(isDefined(var_2))
    level notify(var_2);

  if(isDefined(var_1))
    scripts\cp\cp_objectives::debugbeatobjective(var_1);
}

disable_spawner_until_owner_death(var_0) {
  var_0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AD75063D571AE108", self.group, "_encstr_AD75063D571AE108");
  var_0 scripts\cp\cp_modular_spawning::set_default_spawner_values();
  var_0 scripts\cp\cp_modular_spawning::mounted();
}

register_module_for_spawn_owner_disables(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++)
        level.ambientgroups[var_0][var_1].disable_spawners_until_owner_death = 1;
    } else
      level.ambientgroups[var_0].disable_spawners_until_owner_death = 1;
  }
}

_id_12AE3(var_0, var_1, var_2) {
  if(var_1.size != var_2.size) {
    return;
  }
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        level.ambientgroups[var_0][var_3].set_chosen_spawner_from_uid = var_1;
        level.ambientgroups[var_0][var_3].serverroomrewardroll = var_2;
      }
    }
  }
}

rear_door_collision_brush(var_0) {
  var_1 = 0;

  if(!isarray(var_0))
    var_0 = [var_0];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1 = var_1 + scripts\cp\cp_modular_spawning::get_spawn_count_from_groupname(var_3);
  }

  return var_1;
}

module_disables_spawners_until_owner_death() {
  return istrue(self.disable_spawners_until_owner_death);
}

combine_module_counters(var_0, var_1) {
  if(!isDefined(level.hideallunselectedextractpads[var_1]))
    level.hideallunselectedextractpads[var_1] = [];

  level.hideallunselectedextractpads[var_1][level.hideallunselectedextractpads[var_1].size] = var_0;
  var_0.hide_rocket_fuel_readings_to_player = var_1;
}

_id_12BD3(var_0) {
  var_1 = var_0 propwatchdeath();
  var_0.hide_rocket_fuel_readings_to_player = undefined;

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(level.hideallunselectedextractpads[var_1]))
    level.hideallunselectedextractpads[var_1] = scripts\engine\utility::array_remove(level.hideallunselectedextractpads[var_1], var_0);

  if(isDefined(level.hideallunselectedextractpads[var_1]) && level.hideallunselectedextractpads[var_1].size < 1)
    level.hideallunselectedextractpads[var_1] = undefined;
}

group_has_combined_counters(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3.hide_rocket_fuel_readings_to_player))
      return 1;
  }

  return 0;
}

propwatchdeath() {
  return self.hide_rocket_fuel_readings_to_player;
}

register_module_init_func(var_0, var_1) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
      if(!isDefined(level.ambientgroups[var_0][var_2].module_init_funcs))
        level.ambientgroups[var_0][var_2].module_init_funcs = [];

      level.ambientgroups[var_0][var_2].module_init_funcs[level.ambientgroups[var_0][var_2].module_init_funcs.size] = var_1;
    }
  } else {
    if(!isDefined(level.ambientgroups[var_0].module_init_funcs))
      level.ambientgroups[var_0].module_init_funcs = [];

    level.ambientgroups[var_0].module_init_funcs[level.ambientgroups[var_0].module_init_funcs.size] = var_1;
  }
}

_id_12AEB(var_0, var_1) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
      if(!isDefined(level.ambientgroups[var_0][var_2].lightsfloor02))
        level.ambientgroups[var_0][var_2].lightsfloor02 = [];

      level.ambientgroups[var_0][var_2].lightsfloor02[level.ambientgroups[var_0][var_2].lightsfloor02.size] = var_1;
    }
  } else {
    if(!isDefined(level.ambientgroups[var_0].lightsfloor02))
      level.ambientgroups[var_0].lightsfloor02 = [];

    level.ambientgroups[var_0].lightsfloor02[level.ambientgroups[var_0].lightsfloor02.size] = var_1;
  }
}

run_module_init_funcs_on_module_struct() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0.module_init_funcs)) {
      for(var_1 = 0; var_1 < var_0.module_init_funcs.size; var_1++)
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0.module_init_funcs[var_1]);
    }
  }
}

_id_12AEC(var_0, var_1, var_2) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
      if(!isDefined(level.ambientgroups[var_0][var_3]._id_11CAA))
        level.ambientgroups[var_0][var_3]._id_11CAA = [];

      level.ambientgroups[var_0][var_3]._id_11CAA[level.ambientgroups[var_0][var_3]._id_11CAA.size] = var_1;

      if(!isDefined(level.ambientgroups[var_0][var_3]._id_11CAF))
        level.ambientgroups[var_0][var_3]._id_11CAF = [];

      level.ambientgroups[var_0][var_3]._id_11CAF[level.ambientgroups[var_0][var_3]._id_11CAF.size] = var_2;
    }
  } else {
    if(!isDefined(level.ambientgroups[var_0]._id_11CAA))
      level.ambientgroups[var_0]._id_11CAA = [];

    level.ambientgroups[var_0]._id_11CAA[level.ambientgroups[var_0]._id_11CAA.size] = var_1;

    if(!isDefined(level.ambientgroups[var_0]._id_11CAF))
      level.ambientgroups[var_0]._id_11CAF = [];

    level.ambientgroups[var_0]._id_11CAF[level.ambientgroups[var_0]._id_11CAF.size] = var_2;
  }
}

_id_12DEE() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0._id_11CAA)) {
      for(var_1 = 0; var_1 < var_0._id_11CAA.size; var_1++)
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0._id_11CAA[var_1]);
    }
  }
}

_id_12DEF() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0._id_11CAF)) {
      for(var_1 = 0; var_1 < var_0._id_11CAF.size; var_1++)
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0._id_11CAF[var_1]);
    }
  }
}

increase_wave_ai_killed_counter(var_0) {
  var_1 = 0;

  if(isent(self) && isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    if(isDefined(self.angles))
      var_4 = self.angles;
    else
      var_4 = (0, 0, 0);

    var_2 = var_0 - self.origin;
    var_3 = anglesToForward(var_4);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

increase_wave_ai_spawned_counter(var_0) {
  var_1 = 0;

  if(isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    if(isDefined(self.angles))
      var_4 = self.angles;
    else
      var_4 = (0, 0, 0);

    var_2 = var_0 - self.origin;
    var_3 = anglestoright(var_4);
    var_1 = vectordot(var_2, var_3);
  }

  return var_1 > 0;
}

init_airlock(var_0) {
  level.agent_definition[var_0] = [];
  level.agent_definition[var_0]["_encstr_A6F10A61AAEFF1582559D7CF"] = "_encstr_ACF80B97CFB24530E51A66F982";
  level.agent_definition[var_0]["_encstr_8219049FF2FA"] = "_encstr_ACF80B97CFB24530E51A66F982";
  level.agent_definition[var_0]["_encstr_AB960DF80DDBE9AE01FFC2CF387309"] = "_encstr_A7E80E1818902B623DBA872BD4C1184C";
  level.agent_definition[var_0]["_encstr_91B50734CA58631D1A"] = 150;
  level.agent_definition[var_0]["_encstr_AFF60752796347C440"] = 70;
  level.agent_definition[var_0]["_encstr_8D4607ABF0ABE4FB47"] = 15;
  level.agent_definition[var_0]["_encstr_8F9F07D3D81FB62369"] = 100;
  level.agent_definition[var_0]["_encstr_A3E30B27A5A3108FCFCA0B50A2"] = ::_id_11E56;
  level.agent_definition[var_0]["_encstr_A9CE11B9568ED5E0BE5BB72356D8EB66ABDCB1"] = ::pauseallgulagfights;
  level.agent_definition[var_0]["_encstr_B15F08D341887E0F1DDB"] = "_encstr_A9C20643EAB52C9B";
  level.agent_definition[var_0]["_encstr_8AEF05472BC2D6"] = "_encstr_8E8405EA382B2A";
  level.agent_definition[var_0]["_encstr_BA71144390C3636FBB56898C78637BEC4161CBEBE893"] = "_encstr_958C08CDDBD8325A959C";
  level.agent_definition[var_0]["_encstr_B607032B8B"] = 50;
}

_id_11E56() {
  self.additionalassets = "_encstr_B40101";
  self.subclass = "_encstr_813008928DA89D31A8CA";
  self.defaultcoverselector = "_encstr_B23B0E52885CFFF289B1E5EE5330BD63";
  self.enemyselector = "_encstr_BD8F1987E82B329183D84B97109B4F0B87750FFFC7635AC42EC033";
  self.unittype = "_encstr_958C08CDDBD8325A959C";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  self.accuracy = 0.2;

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = scripts\cp\cp_weapon::buildweapon("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      break;
    case 1:
      self.weapon = scripts\cp\cp_weapon::buildweapon("_encstr_965111B4EEC1AFB027FACC58B11C860BBE5B1C", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      break;
    case 2:
      self.weapon = scripts\cp\cp_weapon::buildweapon("_encstr_A78B112DDD07FA5827D7CC16B196D685EB5BC1", ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  self.grenadeammo = 2;
}

pauseallgulagfights(var_0) {
  self.animationarchetype = "_encstr_ACF80B97CFB24530E51A66F982";
  self.voice = "_encstr_9A01098842DA4B0317F42F";
  self setModel("_encstr_838F11866DF24346DB63B03047EE599DA91606");
  self attach("_encstr_BE591E86CAC291AF27D5CD6E2DB0E6F585E4DAE5AFC4B03616C6B1B0CE16AF4C", "_encstr_B40101", 1);
  self.headmodel = "_encstr_BE591E86CAC291AF27D5CD6E2DB0E6F585E4DAE5AFC4B03616C6B1B0CE16AF4C";
}

balloon_deposit(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.radius = var_1;
  var_2 scripts\engine\flags::assign_unique_id();
  level._id_13648[var_2.unique_id] = var_2;
  return var_2.unique_id;
}

_id_12BF2(var_0) {
  if(isDefined(level._id_13648[var_0]))
    level._id_13648[var_0] = undefined;
}

_id_13BBD(var_0) {
  level._id_133BD = var_0;
}

binoculars_addmarkpoints(var_0) {
  if(isDefined(var_0))
    level.little_bird_mg_exitend = var_0;
  else
    level.little_bird_mg_exitend = undefined;
}

get_module_spawn_points() {
  var_0 = [];
  var_1 = scripts\cp\cp_modular_spawning::process_module_var(self, self.spawn_points);
  return var_1;
}

_id_130AD(var_0, var_1) {
  var_0._id_12A81 = var_1;
}