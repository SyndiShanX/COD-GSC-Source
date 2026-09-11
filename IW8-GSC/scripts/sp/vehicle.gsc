/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vehicle.gsc
***********************************************/

function init_vehicles() {
  if(!scripts\engine\utility::add_init_script("vehicles_sp", &init_vehicles)) {
    return;
  }

  scripts\engine\utility::create_func_ref("makefakeai", &makefakeai);
  scripts\engine\utility::create_func_ref("setturretignoregoals", &setturretignoregoals);
  scripts\engine\utility::create_func_ref("vehicle_orientto", &vehicle_orientto);
  scripts\engine\utility::create_func_ref("getspawnerarray", &getspawnerarray);
  scripts\engine\utility::create_func_ref("forcecolor_riders", &vehicle_script_forcecolor_riders);
  scripts\engine\utility::create_func_ref("vehicle_treads", &scripts\sp\vehicle_treads::vehicle_treads);
  scripts\engine\utility::create_func_ref("drone_give_soul", &scripts\sp\drone_base::drone_give_soul);
  scripts\engine\utility::create_func_ref("fakeactor_give_soul", &scripts\sp\fakeactor::fakeactor_give_soul);
  scripts\engine\utility::create_func_ref("anim_placeweaponon", &scripts\anim\shared::placeweaponon);
  scripts\engine\utility::create_func_ref("vehicle_deathflag", &scripts\sp\spawner::vehicle_deathflag);
  scripts\engine\utility::create_func_ref("vehicle_spawner_deathflag", &scripts\sp\spawner::vehicle_spawner_deathflag);
  scripts\engine\utility::create_func_ref("run_spawn_functions", &scripts\sp\spawner::run_spawn_functions);
  scripts\engine\utility::create_func_ref("anim_updateanimpose", &scripts\anim\utility::updateanimpose);
  scripts\engine\utility::create_func_ref("anim_donotetracks", &scripts\anim\notetracks::donotetracks);
  scripts\engine\utility::create_func_ref("anim_dropallaiweapons", &scripts\anim\shared::dropallaiweapons);
  scripts\engine\utility::create_func_ref("register_kill", &scripts\sp\player_stats::register_kill);
  scripts\engine\utility::create_func_ref("register_shot_hit", &scripts\sp\player_stats::register_shot_hit);
  scripts\engine\utility::create_func_ref("register_shot_hit", &scripts\sp\player_stats::register_shot_hit);
  scripts\engine\utility::create_func_ref("burst_fire_unmanned", &scripts\sp\mgturret::burst_fire_unmanned);
  scripts\engine\utility::create_func_ref("turret_watchPlayerUse", &scripts\sp\mgturret::turret_watchplayeruse);
  scripts\engine\utility::create_func_ref("use_turret", &scripts\sp\utility::use_turret);
  scripts\engine\utility::create_func_ref("asm_animcustom", &scripts\asm\asm_sp::asm_animcustom);
  scripts\engine\utility::create_func_ref("spawner_makerealai", &scripts\sp\spawner::spawner_makerealai);
  scripts\engine\utility::create_func_ref("use_a_turret", &scripts\sp\spawner::use_a_turret);
  scripts\engine\utility::create_func_ref("go_to_node", &scripts\sp\spawner::go_to_node);
  scripts\engine\utility::create_func_ref("fastrope_anim", &fastrope_anim);
  scripts\engine\utility::create_func_ref("vehicle_door_anim", &door_anim);
  scripts\common\vehicle::init_vehicles();
}

function vehicle_script_forcecolor_riders(var0) {
  foreach(var2 in self.riders) {
    if(isai(var2)) {
      var2 scripts\engine\sp\utility::set_force_color(var0);
      continue;
    }

    if(isDefined(var2.spawner)) {
      var2.spawner.script_forcecolor = var0;
    }
  }
}

function fastrope_anim(var0, var1, var2) {
  var0 animScripted(var2, var0.origin, var0.angles, var1, undefined, undefined, 0);
}

function door_anim(var0, var1) {
  var0 setflaggedanimrestart("vehicle_anim_flag", var1);
}