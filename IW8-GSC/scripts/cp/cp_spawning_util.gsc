/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning_util.gsc
***********************************************/

function enable_juggernaut_move_behavior(var0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("juggernaut")) {
    self.juggernautdisablemovebehavior = undefined;
    return;
  }
}

function disable_juggernaut_move_behavior(var0) {
  if(scripts\cp\cp_modular_spawning::is_specified_unittype("juggernaut")) {
    self.juggernautdisablemovebehavior = 1;
    return;
  }
}

function enable_cover_node_behavior(var0) {
  self.combatmode = "cover";
}

function disable_cover_node_behavior(var0) {
  self.combatmode = "no_cover";
}

function end_objective_when_all_dead(var0, var1, var2, var3) {
  thread end_objective_when_all_dead_interal(var0, var0, var1, var2);
}

function end_objective_when_all_dead_interal(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 waittill("all_group_spawns_dead");

  if(isDefined(var2)) {
    level notify(var2);
  }

  if(isDefined(var1)) {
    scripts\cp\cp_objectives::debugbeatobjective(var1);
    return;
  }
}

function disable_spawner_until_owner_death(var0) {
  var0 scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::waittill_any_ents(self, "death", self.group, "death");
  var0 scripts\cp\cp_modular_spawning::set_default_spawner_values();
  var0 scripts\cp\cp_modular_spawning::mounted();
}

function register_module_for_spawn_owner_disables(var0) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var1 = 0; var1 < level.ambientgroups[var0].size; var1++) {
        level.ambientgroups[var0][var1].disable_spawners_until_owner_death = 1;
      }

      return;
    }

    level.ambientgroups[var0].disable_spawners_until_owner_death = 1;
    return;
  }
}

function ref_12ae3(var0, var1, var2) {
  if(var1.size != var2.size) {
    return;
  }

  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var3 = 0; var3 < level.ambientgroups[var0].size; var3++) {
        level.ambientgroups[var0][var3].set_chosen_spawner_from_uid = var1;
        level.ambientgroups[var0][var3].serverroomrewardroll = var2;
      }

      return;
    }

    return;
  }
}

function rear_door_collision_brush(var0) {
  var1 = 0;

  if(!isarray(var0)) {
    var0 = [var0];
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var0[var2];
    var1 += scripts\cp\cp_modular_spawning::get_spawn_count_from_groupname(var3);
  }

  return var1;
}

function module_disables_spawners_until_owner_death() {
  return istrue(self.disable_spawners_until_owner_death);
}

function combine_module_counters(var0, var1) {
  if(!isDefined(level.hideallunselectedextractpads[var1])) {
    level.hideallunselectedextractpads[var1] = [];
  }

  level.hideallunselectedextractpads[var1][level.hideallunselectedextractpads[var1].size] = var0;
  var0.hide_rocket_fuel_readings_to_player = var1;
}

function ref_12bd3(var0) {
  var1 = propwatchdeath(var0);
  var0.hide_rocket_fuel_readings_to_player = undefined;

  if(!isDefined(var1)) {
    return;
  }

  if(isDefined(level.hideallunselectedextractpads[var1])) {
    level.hideallunselectedextractpads[var1] = scripts\engine\utility::array_remove(level.hideallunselectedextractpads[var1], var0);
  }

  if(isDefined(level.hideallunselectedextractpads[var1]) && level.hideallunselectedextractpads[var1].size < 1) {
    level.hideallunselectedextractpads[var1] = undefined;
    return;
  }
}

function group_has_combined_counters(var0) {
  var1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var0);

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(isDefined(var3.hide_rocket_fuel_readings_to_player)) {
      return true;
    }
  }

  return false;
}

function propwatchdeath() {
  return self.hide_rocket_fuel_readings_to_player;
}

function register_module_init_func(var0, var1) {
  if(isarray(level.ambientgroups[var0])) {
    for(var2 = 0; var2 < level.ambientgroups[var0].size; var2++) {
      if(!isDefined(level.ambientgroups[var0][var2].module_init_funcs)) {
        level.ambientgroups[var0][var2].module_init_funcs = [];
      }

      level.ambientgroups[var0][var2].module_init_funcs[level.ambientgroups[var0][var2].module_init_funcs.size] = var1;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var0].module_init_funcs)) {
    level.ambientgroups[var0].module_init_funcs = [];
  }

  level.ambientgroups[var0].module_init_funcs[level.ambientgroups[var0].module_init_funcs.size] = var1;
}

function ref_12aeb(var0, var1) {
  if(isarray(level.ambientgroups[var0])) {
    for(var2 = 0; var2 < level.ambientgroups[var0].size; var2++) {
      if(!isDefined(level.ambientgroups[var0][var2].lightsfloor02)) {
        level.ambientgroups[var0][var2].lightsfloor02 = [];
      }

      level.ambientgroups[var0][var2].lightsfloor02[level.ambientgroups[var0][var2].lightsfloor02.size] = var1;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var0].lightsfloor02)) {
    level.ambientgroups[var0].lightsfloor02 = [];
  }

  level.ambientgroups[var0].lightsfloor02[level.ambientgroups[var0].lightsfloor02.size] = var1;
}

function run_module_init_funcs_on_module_struct() {
  if(isDefined(self.level_module_struct)) {
    var0 = self.level_module_struct;

    if(isDefined(var0.module_init_funcs)) {
      for(var1 = 0; var1 < var0.module_init_funcs.size; var1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var0.module_init_funcs[var1]);
      }

      return;
    }

    return;
  }
}

function ref_12aec(var0, var1, var2) {
  if(isarray(level.ambientgroups[var0])) {
    for(var3 = 0; var3 < level.ambientgroups[var0].size; var3++) {
      if(!isDefined(level.ambientgroups[var0][var3].ref_11caa)) {
        level.ambientgroups[var0][var3].ref_11caa = [];
      }

      level.ambientgroups[var0][var3].ref_11caa[level.ambientgroups[var0][var3].ref_11caa.size] = var1;

      if(!isDefined(level.ambientgroups[var0][var3].ref_11caf)) {
        level.ambientgroups[var0][var3].ref_11caf = [];
      }

      level.ambientgroups[var0][var3].ref_11caf[level.ambientgroups[var0][var3].ref_11caf.size] = var2;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var0].ref_11caa)) {
    level.ambientgroups[var0].ref_11caa = [];
  }

  level.ambientgroups[var0].ref_11caa[level.ambientgroups[var0].ref_11caa.size] = var1;

  if(!isDefined(level.ambientgroups[var0].ref_11caf)) {
    level.ambientgroups[var0].ref_11caf = [];
  }

  level.ambientgroups[var0].ref_11caf[level.ambientgroups[var0].ref_11caf.size] = var2;
}

function ref_12dee() {
  if(isDefined(self.level_module_struct)) {
    var0 = self.level_module_struct;

    if(isDefined(var0.ref_11caa)) {
      for(var1 = 0; var1 < var0.ref_11caa.size; var1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var0.ref_11caa[var1]);
      }

      return;
    }

    return;
  }
}

function ref_12def() {
  if(isDefined(self.level_module_struct)) {
    var0 = self.level_module_struct;

    if(isDefined(var0.ref_11caf)) {
      for(var1 = 0; var1 < var0.ref_11caf.size; var1++) {
        scripts\cp\cp_modular_spawning::process_module_var(self, var0.ref_11caf[var1]);
      }

      return;
    }

    return;
  }
}

function increase_wave_ai_killed_counter(var0) {
  var1 = 0;

  if(isent(self) && isPlayer(self)) {
    var2 = var0 - self getorigin();
    var3 = anglesToForward(self getplayerangles(1));
    var1 = vectordot(var2, var3);
  } else {
    jumpiffalse(isDefined(self.angles)) LOC_0000004d;
    var4 = self.angles;
    goto LOC_00000060;
  }

  return var4 > 0;
}

function increase_wave_ai_spawned_counter(var0) {
  var1 = 0;

  if(isPlayer(self)) {
    var2 = var0 - self getorigin();
    var3 = anglestoright(self getplayerangles(1));
    var1 = vectordot(var2, var3);
  } else {
    jumpiffalse(isDefined(self.angles)) LOC_00000045;
    var4 = self.angles;
    goto LOC_00000058;
  }

  return var4 > 0;
}

function init_airlock(var0) {
  level.agent_definition[var0] = [];
  level.agent_definition[var0]["animclass"] = "soldier_cp";
  level.agent_definition[var0]["asm"] = "soldier_cp";
  level.agent_definition[var0]["behaviorTree"] = "soldier_agent";
  level.agent_definition[var0]["health"] = 150;
  level.agent_definition[var0]["height"] = 70;
  level.agent_definition[var0]["radius"] = 15;
  level.agent_definition[var0]["reward"] = 100;
  level.agent_definition[var0]["setup_func"] = &ref_11e56;
  level.agent_definition[var0]["setup_model_func"] = &pauseallgulagfights;
  level.agent_definition[var0]["species"] = "human";
  level.agent_definition[var0]["team"] = "axis";
  level.agent_definition[var0]["traversal_unit_type"] = "soldier";
  level.agent_definition[var0]["xp"] = 50;
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

function pauseallgulagfights(var0) {
  self.animationarchetype = "soldier_cp";
  self.voice = "alqatala";
  self setModel("body_spetsnaz_ar");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
}

function balloon_deposit(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.radius = var1;
  var2 scripts\engine\flags::assign_unique_id();
  level.ref_13648[var2.unique_id] = var2;
  return var2.unique_id;
}

function ref_12bf2(var0) {
  if(isDefined(level.ref_13648[var0])) {
    level.ref_13648[var0] = undefined;
    return;
  }
}

function ref_13bbd(var0) {
  level.ref_133bd = var0;
}

function binoculars_addmarkpoints(var0) {
  if(isDefined(var0)) {
    level.little_bird_mg_exitend = var0;
    return;
  }

  level.little_bird_mg_exitend = undefined;
}

function get_module_spawn_points() {
  var0 = [];
  var1 = scripts\cp\cp_modular_spawning::process_module_var(self, self.spawn_points);
  return var1;
}

function ref_130ad(var0, var1) {
  var0.ref_12a81 = var1;
}