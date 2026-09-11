/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning_util.gsc
***********************************************/

function enable_juggernaut_move_behavior(var_0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("juggernaut")) {
    self.juggernautdisablemovebehavior = undefined;
    return;
  }
}

function disable_juggernaut_move_behavior(var_0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("juggernaut")) {
    self.juggernautdisablemovebehavior = 1;
    return;
  }
}

function enable_cover_node_behavior(var_0) {
  self.combatmode = "cover";
}

function disable_cover_node_behavior(var_0) {
  self.combatmode = "no_cover";
}

function end_objective_when_all_dead(var_0, var_1, var_2, var_3) {
  thread end_objective_when_all_dead_interal(var_0, var_0, var_1, var_2);
}

function end_objective_when_all_dead_interal(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 waittill("all_group_spawns_dead");

  if(isDefined(var_2)) {
    level notify(var_2);
  }

  if(isDefined(var_1)) {
    scripts\cp\cp_objectives::debugbeatobjective(var_1);
    return;
  }
}

function disable_spawner_until_owner_death(var_0) {
  var_0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::waittill_any_ents(self, "death", self.group, "death");
  var_0 scripts\cp\cp_modular_spawning::set_default_spawner_values();
  var_0 scripts\cp\cp_modular_spawning::mounted();
}

function register_module_for_spawn_owner_disables(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++) {
        level.ambientgroups[var_0][var_1].disable_spawners_until_owner_death = 1;
      }

      return;
    }

    level.ambientgroups[var_0].disable_spawners_until_owner_death = 1;
    return;
  }
}

function ref_12ae3(var_0, var_1, var_2) {
  if(var_1.size != var_2.size) {
    return;
  }

  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        level.ambientgroups[var_0][var_3].set_chosen_spawner_from_uid = var_1;
        level.ambientgroups[var_0][var_3].serverroomrewardroll = var_2;
      }

      return;
    }

    return;
  }
}

function rear_door_collision_brush(var_0) {
  var_1 = 0;

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1 += scripts\cp\cp_modular_spawning::get_spawn_count_from_groupname(var_3);
  }

  return var_1;
}

function module_disables_spawners_until_owner_death() {
  return istrue(self.disable_spawners_until_owner_death);
}

function combine_module_counters(var_0, var_1) {
  if(!isDefined(level.hideallunselectedextractpads[var_1])) {
    level.hideallunselectedextractpads[var_1] = [];
  }

  level.hideallunselectedextractpads[var_1][level.hideallunselectedextractpads[var_1].size] = var_0;
  var_0.hide_rocket_fuel_readings_to_player = var_1;
}

function ref_12bd3(var_0) {
  var_1 = propwatchdeath(var_0);
  var_0.hide_rocket_fuel_readings_to_player = undefined;

  if(!isDefined(var_1)) {
    return;
  }

  if(isDefined(level.hideallunselectedextractpads[var_1])) {
    level.hideallunselectedextractpads[var_1] = scripts\engine\utility::array_remove(level.hideallunselectedextractpads[var_1], var_0);
  }

  if(isDefined(level.hideallunselectedextractpads[var_1]) && level.hideallunselectedextractpads[var_1].size < 1) {
    level.hideallunselectedextractpads[var_1] = undefined;
    return;
  }
}

function group_has_combined_counters(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3.hide_rocket_fuel_readings_to_player)) {
      return true;
    }
  }

  return false;
}

function propwatchdeath() {
  return self.hide_rocket_fuel_readings_to_player;
}

function register_module_init_func(var_0, var_1) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
      if(!isDefined(level.ambientgroups[var_0][var_2].module_init_funcs)) {
        level.ambientgroups[var_0][var_2].module_init_funcs = [];
      }

      level.ambientgroups[var_0][var_2].module_init_funcs[level.ambientgroups[var_0][var_2].module_init_funcs.size] = var_1;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var_0].module_init_funcs)) {
    level.ambientgroups[var_0].module_init_funcs = [];
  }

  level.ambientgroups[var_0].module_init_funcs[level.ambientgroups[var_0].module_init_funcs.size] = var_1;
}

function ref_12aeb(var_0, var_1) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
      if(!isDefined(level.ambientgroups[var_0][var_2].lightsfloor02)) {
        level.ambientgroups[var_0][var_2].lightsfloor02 = [];
      }

      level.ambientgroups[var_0][var_2].lightsfloor02[level.ambientgroups[var_0][var_2].lightsfloor02.size] = var_1;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var_0].lightsfloor02)) {
    level.ambientgroups[var_0].lightsfloor02 = [];
  }

  level.ambientgroups[var_0].lightsfloor02[level.ambientgroups[var_0].lightsfloor02.size] = var_1;
}

function run_module_init_funcs_on_module_struct() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0.module_init_funcs)) {
      for(var_1 = 0; var_1 < var_0.module_init_funcs.size; var_1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0.module_init_funcs[var_1]);
      }

      return;
    }

    return;
  }
}

function ref_12aec(var_0, var_1, var_2) {
  if(isarray(level.ambientgroups[var_0])) {
    for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
      if(!isDefined(level.ambientgroups[var_0][var_3].ref_11caa)) {
        level.ambientgroups[var_0][var_3].ref_11caa = [];
      }

      level.ambientgroups[var_0][var_3].ref_11caa[level.ambientgroups[var_0][var_3].ref_11caa.size] = var_1;

      if(!isDefined(level.ambientgroups[var_0][var_3].ref_11caf)) {
        level.ambientgroups[var_0][var_3].ref_11caf = [];
      }

      level.ambientgroups[var_0][var_3].ref_11caf[level.ambientgroups[var_0][var_3].ref_11caf.size] = var_2;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var_0].ref_11caa)) {
    level.ambientgroups[var_0].ref_11caa = [];
  }

  level.ambientgroups[var_0].ref_11caa[level.ambientgroups[var_0].ref_11caa.size] = var_1;

  if(!isDefined(level.ambientgroups[var_0].ref_11caf)) {
    level.ambientgroups[var_0].ref_11caf = [];
  }

  level.ambientgroups[var_0].ref_11caf[level.ambientgroups[var_0].ref_11caf.size] = var_2;
}

function ref_12dee() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0.ref_11caa)) {
      for(var_1 = 0; var_1 < var_0.ref_11caa.size; var_1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0.ref_11caa[var_1]);
      }

      return;
    }

    return;
  }
}

function ref_12def() {
  if(isDefined(self.level_module_struct)) {
    var_0 = self.level_module_struct;

    if(isDefined(var_0.ref_11caf)) {
      for(var_1 = 0; var_1 < var_0.ref_11caf.size; var_1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var_0.ref_11caf[var_1]);
      }

      return;
    }

    return;
  }
}

function increase_wave_ai_killed_counter(var_0) {
  var_1 = 0;

  if(isent(self) && isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglesToForward(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    jumpiffalse(isDefined(self.angles)) LOC_0000004d;
    var_4 = self.angles;
    goto LOC_00000060;
  }

  return var_4 > 0;
}

function increase_wave_ai_spawned_counter(var_0) {
  var_1 = 0;

  if(isPlayer(self)) {
    var_2 = var_0 - self getorigin();
    var_3 = anglestoright(self getplayerangles(1));
    var_1 = vectordot(var_2, var_3);
  } else {
    jumpiffalse(isDefined(self.angles)) LOC_00000045;
    var_4 = self.angles;
    goto LOC_00000058;
  }

  return var_4 > 0;
}

function init_airlock(var_0) {
  level.agent_definition[var_0] = [];
  level.agent_definition[var_0]["animclass"] = "soldier_cp";
  level.agent_definition[var_0]["asm"] = "soldier_cp";
  level.agent_definition[var_0]["behaviorTree"] = "soldier_agent";
  level.agent_definition[var_0]["health"] = 150;
  level.agent_definition[var_0]["height"] = 70;
  level.agent_definition[var_0]["radius"] = 15;
  level.agent_definition[var_0]["reward"] = 100;
  level.agent_definition[var_0]["setup_func"] = &ref_11e56;
  level.agent_definition[var_0]["setup_model_func"] = &pauseallgulagfights;
  level.agent_definition[var_0]["species"] = "human";
  level.agent_definition[var_0]["team"] = "axis";
  level.agent_definition[var_0]["traversal_unit_type"] = "soldier";
  level.agent_definition[var_0]["xp"] = 50;
}

function ref_11e56() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "soldier";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_falima_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self.grenadeammo = 2;
}

function pauseallgulagfights(var_0) {
  self.animationarchetype = "soldier_cp";
  self.voice = "alqatala";
  self setModel("body_spetsnaz_ar");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
}

function balloon_deposit(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.radius = var_1;
  var_2 scripts\engine\flags::assign_unique_id();
  level.ref_13648[var_2.unique_id] = var_2;
  return var_2.unique_id;
}

function ref_12bf2(var_0) {
  if(isDefined(level.ref_13648[var_0])) {
    level.ref_13648[var_0] = undefined;
    return;
  }
}

function ref_13bbd(var_0) {
  level.ref_133bd = var_0;
}

function binoculars_addmarkpoints(var_0) {
  if(isDefined(var_0)) {
    level.little_bird_mg_exitend = var_0;
    return;
  }

  level.little_bird_mg_exitend = undefined;
}

function get_module_spawn_points() {
  var_0 = [];
  var_1 = scripts\cp\cp_modular_spawning::process_module_var(self, self.spawn_points);
  return var_1;
}

function ref_130ad(var_0, var_1) {
  var_0.ref_12a81 = var_1;
}