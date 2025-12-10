/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_island_seed.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_island_planting;
#namespace zm_powerup_island_seed;

function autoexec __init__sytem__() {
  system::register("zm_powerup_island_seed", &__init__, undefined, undefined);
}

function __init__() {
  register_clientfields();
  zm_powerups::register_powerup("island_seed", &function_6adb5862);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("island_seed", "p7_zm_isl_plant_seed_pod_01", &"ZM_ISLAND_SEED_POWERUP", &function_f766ae15, 1, 0, 0);
  }
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  thread function_7b74396f();
  level.var_9895ed0d = 0;
  level.var_325c412f = 2;
  level thread function_b2cb89c1();
  level thread function_68329bc5();
}

function register_clientfields() {
  clientfield::register("toplayer", "has_island_seed", 1, 2, "int");
  clientfield::register("clientuimodel", "zmInventory.widget_seed_parts", 9000, 1, "int");
  clientfield::register("toplayer", "bucket_seed_01", 9000, 1, "int");
  clientfield::register("toplayer", "bucket_seed_02", 9000, 1, "int");
  clientfield::register("toplayer", "bucket_seed_03", 9000, 1, "int");
}

function function_6adb5862(player) {
  var_f65b973 = player clientfield::get_to_player("has_island_seed");
  if(var_f65b973 < 3) {
    var_b5c360bd = var_f65b973 + 1;
    player clientfield::set_to_player("has_island_seed", var_b5c360bd);
    player function_3968a493(1);
    player notify("hash_97e69ab7");
  }
}

function function_58b6724f(player) {
  var_f65b973 = player clientfield::get_to_player("has_island_seed");
  if(var_f65b973 > 0) {
    var_b5c360bd = var_f65b973 - 1;
    player clientfield::set_to_player("has_island_seed", var_b5c360bd);
    player function_3968a493(1);
    player notify("hash_9d289b3a");
    println("");
    return true;
  }
  return false;
}

function function_735cfef2(player) {
  return player clientfield::get_to_player("has_island_seed");
}

function function_aeda54f6(var_f65b973) {
  self clientfield::set_to_player("has_island_seed", var_f65b973);
  self function_3968a493();
}

function function_3968a493(var_b89973c8 = 0) {
  var_f65b973 = function_735cfef2(self);
  switch (var_f65b973) {
    case 0: {
      self clientfield::set_to_player("bucket_seed_01", 0);
      self clientfield::set_to_player("bucket_seed_02", 0);
      self clientfield::set_to_player("bucket_seed_03", 0);
      break;
    }
    case 1: {
      self clientfield::set_to_player("bucket_seed_01", 1);
      self clientfield::set_to_player("bucket_seed_02", 0);
      self clientfield::set_to_player("bucket_seed_03", 0);
      break;
    }
    case 2: {
      self clientfield::set_to_player("bucket_seed_01", 1);
      self clientfield::set_to_player("bucket_seed_02", 1);
      self clientfield::set_to_player("bucket_seed_03", 0);
      break;
    }
    case 3: {
      self clientfield::set_to_player("bucket_seed_01", 1);
      self clientfield::set_to_player("bucket_seed_02", 1);
      self clientfield::set_to_player("bucket_seed_03", 1);
      break;
    }
  }
  if(var_b89973c8) {
    self thread zm_craftables::player_show_craftable_parts_ui(undefined, "zmInventory.widget_seed_parts", 0);
  }
}

function function_f766ae15() {
  if(isDefined(level.var_b426c9) && level.var_b426c9) {
    return false;
  }
  n_count = 0;
  foreach(player in level.activeplayers) {
    n_count = n_count + player clientfield::get_to_player("has_island_seed");
  }
  if(n_count == (level.activeplayers.size * 3)) {
    return false;
  }
  return true;
}

function function_68329bc5() {
  while(true) {
    level waittill("between_round_over");
    level.var_9895ed0d = 0;
  }
}

function function_b2cb89c1() {
  level flag::init("round_1_seed_spawned");
  level.var_e964b72 = 0;
  level.custom_zombie_powerup_drop = &function_7a25b639;
  level flag::wait_till("round_1_seed_spawned");
  wait(1);
  level.custom_zombie_powerup_drop = &function_1f5d3f75;
  level thread function_af95a19e();
}

function function_7a25b639(drop_point) {
  if(!level function_f766ae15()) {
    return false;
  }
  if(level flag::get("round_1_seed_spawned")) {
    return false;
  }
  if(math::cointoss() || getaicount() < 1) {
    var_93eb638b = zm_powerups::specific_powerup_drop("island_seed", drop_point);
    level flag::set("round_1_seed_spawned");
    level thread function_ca5485fa(var_93eb638b);
    level.var_9895ed0d++;
    return true;
  }
}

function function_1f5d3f75(drop_point) {
  if(!level function_f766ae15()) {
    return false;
  }
  if(level.var_9895ed0d >= level.var_325c412f) {
    return false;
  }
  rand_drop = randomint(100);
  if(rand_drop > 2) {
    if(level.var_e964b72 == 0) {
      return;
    }
    println("");
  } else {
    println("");
  }
  var_93eb638b = zm_powerups::specific_powerup_drop("island_seed", drop_point);
  level thread function_ca5485fa(var_93eb638b);
  level.var_9895ed0d++;
  level.var_e964b72 = 0;
  return true;
}

function function_af95a19e() {
  level endon("unloaded");
  players = level.players;
  level.var_e4f2021b = 2000;
  score_to_drop = (players.size * (level.zombie_vars[("zombie_score_start_" + players.size) + "p"])) + level.var_e4f2021b;
  while(true) {
    players = level.players;
    curr_total_score = 0;
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].score_total)) {
        curr_total_score = curr_total_score + players[i].score_total;
      }
    }
    if(curr_total_score > score_to_drop) {
      level.var_e4f2021b = level.var_e4f2021b * 1.14;
      score_to_drop = curr_total_score + level.var_e4f2021b;
      level.var_e964b72 = 1;
    }
    wait(0.5);
  }
}

function function_ca5485fa(var_93eb638b) {
  var_93eb638b endon("powerup_grabbed");
  var_93eb638b waittill("powerup_timedout");
  if(level.var_9895ed0d > 0) {
    level.var_9895ed0d--;
  }
}

function show_infotext_for_duration(str_infotext, n_duration) {
  self clientfield::set_to_player(str_infotext, 1);
  wait(n_duration);
  self clientfield::set_to_player(str_infotext, 0);
}

function function_ea405166(var_1d640f59, str_widget_clientuimodel, var_18bfcc38) {
  self notify("hash_6c34b226");
  self endon("hash_6c34b226");
  if(var_18bfcc38) {
    if(isDefined(var_1d640f59)) {
      self thread clientfield::set_player_uimodel(var_1d640f59, 1);
    }
    n_show_ui_duration = 3.5;
  } else {
    n_show_ui_duration = 3.5;
  }
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 1);
  wait(n_show_ui_duration);
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 0);
}

function on_player_connect() {}

function on_player_spawned() {
  self clientfield::set_to_player("has_island_seed", 0);
}

function function_7b74396f() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_903fbe7);
  adddebugcommand("");
  adddebugcommand("");
}

function function_903fbe7(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      return 1;
    }
    case "": {
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      return 1;
    }
  }
  return retval;
}