/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_sh_cairo.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_safehouse;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_sh_cairo_fx;
#using scripts\cp\cp_sh_cairo_sound;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace cp_sh_cairo;

function main() {
  setclearanceceiling(120);
  setup_skiptos();
  cp_sh_cairo_fx::main();
  cp_sh_cairo_sound::main();
  load::main();
  level thread set_ambient_state();
  level thread setup_vignettes();
}

function setup_skiptos() {
  skipto::add_dev("dev_no_bunk", &function_d525a88c, "No Bunk Start");
}

function function_d525a88c(str_objective, b_starting) {
  level.var_2e24ecad = 1;
}

function set_ambient_state() {
  level flag::wait_till("all_players_connected");
  level thread start_ambient_background_vtols();
  safehouse::function_a85e8026(1);
  switch (level.next_map) {
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_infection2":
    case "cp_mi_cairo_infection3": {
      level util::set_lighting_state(0);
      break;
    }
    case "cp_mi_cairo_aquifer": {
      level util::set_lighting_state(1);
      break;
    }
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_lotus2":
    case "cp_mi_cairo_lotus3": {
      level util::set_lighting_state(0);
      break;
    }
  }
}

function start_ambient_background_vtols() {
  a_sp_vtols = getvehiclespawnerarray("ambient_vtol", "targetname");
  while(true) {
    a_sp_vtols = array::randomize(a_sp_vtols);
    foreach(sp_vtol in a_sp_vtols) {
      sp_vtol.count++;
      nd_start = getvehiclenode(sp_vtol.target, "targetname");
      vh_vtol = spawner::simple_spawn_single(sp_vtol);
      vh_vtol pathvariableoffset((300, 300, 300), 3);
      vh_vtol thread vehicle::get_on_and_go_path(nd_start);
      wait(randomfloatrange(30, 90));
    }
  }
}

function setup_vignettes() {
  a_str_scenes = [];
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_repair_3dprinter";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_bunk";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_inspect";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_diagnostics";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_firerange";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_tech_datavault";
  if(!isDefined(a_str_scenes)) {
    a_str_scenes = [];
  } else if(!isarray(a_str_scenes)) {
    a_str_scenes = array(a_str_scenes);
  }
  a_str_scenes[a_str_scenes.size] = "cin_saf_ram_armory_vign_supply_box";
  a_str_scenes = array::randomize(a_str_scenes);
  n_vign_total = randomintrange(4, 6);
  for(n_vign_index = 0; n_vign_index < n_vign_total; n_vign_index++) {
    str_scene = a_str_scenes[n_vign_index];
    level thread scene::play(str_scene);
  }
}