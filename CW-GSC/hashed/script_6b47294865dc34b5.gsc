/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6b47294865dc34b5.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_70b6424f429d140;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace tkdn_heli_convoy_aslt;

function starting(var_d3440450) {
  level.var_aece851d = [];
  flag::set("heli_door_opening");
}

function main(var_d3440450, var_50cc0d4f) {
  level.var_33621ea7 = 0;
  thread function_a7dc18f3();
  thread namespace_a052577e::function_e04b45ab();
  level flag::wait_till("heli_convoy_aslt_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("heli_convoy_aslt_complete");
  level flag::init("intro_takeout_driver");
  level flag::init("intro_takeout_target");
  level flag::init("intro_takeout_never");
}

function init_clientfields() {}

function function_22b7fffd() {}

function function_46693791() {
  driver = getent("intro_driver_assassinate", "targetname", 1);

  if(!isDefined(level.var_664fd741)) {
    level.var_664fd741 = getent("woods_chopper_from_scene", "script_noteworthy", 1);

    if(!isDefined(level.var_664fd741)) {
      spawners = getspawnerarray("intro_assault_ally_hudson", "targetename");

      if(!isDefined(spawners) || spawners.size == 0) {
        spawners = getspawnerarray("intro_assault_ally_hudson", "script_noteworthy");
      }

      level.var_664fd741 = spawners[0] spawner::spawn(1);
    } else {
      level flag::wait_till("heli_intro_path_ally");
      level.var_664fd741 thread spawner::go_to_node();
    }

    level.var_664fd741.ignoreall = 1;
    level.var_664fd741.ignoreme = 1;
    level.var_aece851d[level.var_aece851d.size] = level.var_664fd741;
    level thread util::magic_bullet_shield(level.var_664fd741);
  }

  flag::set("woods_gogo");

  if(isDefined(driver)) {
    driver ai::bloody_death(0.2);
  }

  wait 1.2;
  level.var_664fd741.ignoreall = 0;
  wait 1;
  objectives::follow("woods_hit1", level.var_664fd741);
  level.var_95a74232 = 1;
  aiarray = ai::array_spawn("intro_assault_extra_guys");
  aiarray = arraycombine(aiarray, getEntArray("intro_enemy_truck_guys", "script_noteworthy"), 1, 0);

  foreach(guy in aiarray) {
    guy.ignoreall = 1;
    guy.ignoreme = 1;

    if(!isDefined(driver)) {
      if(isDefined(guy.script_parameters) && guy.script_parameters == "intro_driver_assassinate") {
        driver = guy;
      }
    }
  }

  wait 0.2;

  foreach(guy in aiarray) {
    if(isDefined(guy)) {
      guy.ignoreme = 0;
    }
  }

  level.var_664fd741.ignoreall = 0;
  level.var_664fd741.ignoreme = 0;

  foreach(guy in aiarray) {
    if(isDefined(guy)) {
      if(!(isDefined(guy.script_parameters) && guy.script_parameters == "squirter")) {
        guy.ignoreall = 0;
      }
    }
  }
}

function function_149bd557() {
  if(!isDefined(level.var_abaa6487)) {
    return;
  }

  wait 0.1;

  foreach(truck in level.var_abaa6487) {
    thread function_d8f00fe0(truck);
  }
}

function function_c42508f4() {
  self endon(#"death");
  self endon(#"exited_vehicle");
  start = gettime();

  while(true) {
    print3d(self.origin + (0, 0, 72), "<dev string:x38>", (1, 0, 0), 1, 0.5, 1, 1);
    self.unload_time = int((gettime() - start) / 10) / 100;
    print3d(self.origin + (0, 0, 60), "<dev string:x45>" + self.unload_time, (1, 0, 0), 1, 0.5, 1);

    waitframe(1);
  }
}

function function_77937c90() {
  self.ignoreme = 0;

  if(!isDefined(self.target)) {
    return;
  }

  self endon(#"death");
  self waittill(#"exited_vehicle");
  waitframe(2);
  to = getnode(self.target, "targetname");

  if(!isDefined(to)) {
    to = getent(self.target, "targetname");
  }

  if(isDefined(to)) {
    self setgoal(to, 1);
  }
}

function function_d8f00fe0(truck) {
  if(truck.script_parameters == "truck_bustout_unload") {
    foreach(rider in truck.var_761c973.riders) {
      if(isDefined(rider)) {
        rider.ignoreme = 1;
      }
    }
  }

  level flag::wait_till(truck.script_parameters);

  if(isalive(truck)) {
    arrayremovevalue(truck.var_761c973.riders, undefined, 1);
    array::thread_all(truck.var_761c973.riders, &function_77937c90);
    truck thread vehicle::unload("crew");
    truck thread vehicle::unload("passenger1");
    truck thread vehicle::unload("driver");
  }
}

function function_a7dc18f3() {
  aiarray = array();

  if(!isDefined(level.var_40b02b72)) {
    player = getplayers()[0];
    player val::set("takedown_hit1_intro", "show_weapon_hud", 0);
    thread tkdn_heli_intro::function_c6662dbb("intro_enemy_trucks", 1);
    waitframe(4);
    level flag::set("intro_heli_lights_on");
    thread tkdn_heli_intro::function_3d66ebcc("intro_heli_player", 1, 1);
    wait 2.5;
  }

  aiarray = getEntArray("intro_enemy_truck_guys", "script_noteworthy", 1);
  thread function_46693791();
  array::wait_till(aiarray, "death");
  level.var_664fd741.ignoreall = 1;
  level.var_664fd741.ignoreme = 1;
  thread function_83cd8600();
  level flag::wait_till("intro_takeout_target");
  dialogue::radio("vox_cp_tdwn_01300_chp1_notsureithought_5a");
  level flag::set("truck_bustout_unload");
  wait 2;
  level flag::set("heli_convoy_aslt_complete");
}

function function_83cd8600() {
  flag::wait_till("intro_moving_to_bustout");
  wait 1;
  level.var_664fd741.ignoreall = 0;
  level.var_664fd741.ignoreme = 0;
}