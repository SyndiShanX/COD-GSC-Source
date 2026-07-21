/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\vehicle.gsc
***********************************************/

init_vehicles() {
  if(!scripts\engine\utility::add_init_script("vehicles_sp", ::init_vehicles)) {
    return;
  }
  scripts\engine\utility::create_func_ref("makefakeai", ::makefakeai);
  scripts\engine\utility::create_func_ref("setturretignoregoals", ::setturretignoregoals);
  scripts\engine\utility::create_func_ref("vehicle_orientto", ::vehicle_orientto);
  scripts\engine\utility::create_func_ref("getspawnerarray", ::getspawnerarray);
  scripts\engine\utility::create_func_ref("forcecolor_riders", ::vehicle_script_forcecolor_riders);
  scripts\engine\utility::create_func_ref("vehicle_treads", scripts\sp\vehicle_treads::vehicle_treads);
  scripts\engine\utility::create_func_ref("drone_give_soul", scripts\sp\drone_base::drone_give_soul);
  scripts\engine\utility::create_func_ref("fakeactor_give_soul", scripts\sp\fakeactor::fakeactor_give_soul);
  scripts\engine\utility::create_func_ref("anim_placeweaponon", scripts\anim\shared.gsc::placeweaponon);
  scripts\engine\utility::create_func_ref("vehicle_deathflag", scripts\sp\spawner::vehicle_deathflag);
  scripts\engine\utility::create_func_ref("vehicle_spawner_deathflag", scripts\sp\spawner::vehicle_spawner_deathflag);
  scripts\engine\utility::create_func_ref("run_spawn_functions", scripts\sp\spawner::run_spawn_functions);
  scripts\engine\utility::create_func_ref("anim_updateanimpose", scripts\anim\utility.gsc::updateanimpose);
  scripts\engine\utility::create_func_ref("anim_donotetracks", scripts\anim\notetracks.gsc::donotetracks);
  scripts\engine\utility::create_func_ref("anim_dropallaiweapons", scripts\anim\shared.gsc::dropallaiweapons);
  scripts\engine\utility::create_func_ref("register_kill", scripts\sp\player_stats::register_kill);
  scripts\engine\utility::create_func_ref("register_shot_hit", scripts\sp\player_stats::register_shot_hit);
  scripts\engine\utility::create_func_ref("register_shot_hit", scripts\sp\player_stats::register_shot_hit);
  scripts\engine\utility::create_func_ref("burst_fire_unmanned", scripts\sp\mgturret::burst_fire_unmanned);
  scripts\engine\utility::create_func_ref("turret_watchPlayerUse", scripts\sp\mgturret::turret_watchplayeruse);
  scripts\engine\utility::create_func_ref("use_turret", scripts\sp\utility::use_turret);
  scripts\engine\utility::create_func_ref("asm_animcustom", scripts\asm\asm_sp::asm_animcustom);
  scripts\engine\utility::create_func_ref("spawner_makerealai", scripts\sp\spawner::spawner_makerealai);
  scripts\engine\utility::create_func_ref("use_a_turret", scripts\sp\spawner::use_a_turret);
  scripts\engine\utility::create_func_ref("go_to_node", scripts\sp\spawner::go_to_node);
  scripts\engine\utility::create_func_ref("fastrope_anim", ::fastrope_anim);
  scripts\engine\utility::create_func_ref("vehicle_door_anim", ::door_anim);
  scripts\common\vehicle::init_vehicles();
}

vehicle_script_forcecolor_riders(var_0) {
  foreach(var_2 in self.riders) {
    if(isai(var_2)) {
      var_2 scripts\engine\sp\utility::set_force_color(var_0);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner.script_forcecolor = var_0;
      continue;
    }
  }
}

fastrope_anim(var_0, var_1, var_2) {
  var_0 animScripted(var_2, var_0.origin, var_0.angles, var_1, undefined, undefined, 0);
}

door_anim(var_0, var_1) {
  var_0 setflaggedanimrestart("vehicle_anim_flag", var_1);
}