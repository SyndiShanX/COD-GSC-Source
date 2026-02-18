/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_sidemission_takedown.gsc
***********************************************/

#using script_122afd04d0de2423;
#using script_15a7051a4ff0cf46;
#using script_30cfffd6b7b2b212;
#using script_31e02d627cf2fc9d;
#using script_3890e6e179f6ed13;
#using script_52e44090bd3b849d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_3da2ad62;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  init_clientfields();
  function_37dfd679();
  load::main();
  init_callbacks();
  level.player = getplayers()[0];
  level.var_30eb363 = # "hash_4e516e60f6798859";
  level.var_85b00b2b = # "hash_42cabf1b1466580";
  setDvar(#"compassmaxrange", "2100");

  if(!function_72a9e321()) {
    setDvar(#"r_maxspotshadowupdates", 6);
    setDvar(#"r_localshadowdropsizescale", 4);
  } else {
    setDvar(#"r_maxspotshadowupdates", 12);
  }

  namespace_42da7c51::devgui();
}

function function_f4dca234() {
  var_653081c8 = getEntArray("script_lights_trucks_headlights", "script_noteworthy");

  foreach(light in var_653081c8) {
    light.var_43a76d63 = light getlightintensity();
    light setlightintensity(0);
  }
}

function function_37dfd679() {
  skipto::function_eb91535d("tkdn_heli_intro", &namespace_347b95ee::main, &namespace_347b95ee::starting, "Chaos: Heli", &namespace_347b95ee::cleanup);
  skipto::function_eb91535d("tkdn_heli_convoy_aslt", &namespace_9c42e5f3::main, &namespace_9c42e5f3::starting, "Chaos: Convoy Assault", &namespace_9c42e5f3::cleanup);
  skipto::function_eb91535d("tkdn_heli_trailer_park", &namespace_1ca393d1::main, &namespace_1ca393d1::starting, "Chaos: Trailer Park", &namespace_1ca393d1::cleanup);
  skipto::function_eb91535d("tkdn_heli_hotel_parking_lot", &namespace_f464d565::function_b474f6be, &namespace_f464d565::function_dbf2a80e, "Chaos: Hotel Parking Lot", &namespace_f464d565::function_a81c2225);
  skipto::function_eb91535d("tkdn_heli_hotel_breach", &namespace_f464d565::main, &namespace_f464d565::starting, "Chaos: Hotel Breach", &namespace_f464d565::cleanup);
  skipto::function_eb91535d("tkdn_heli_exfil", &namespace_fe8e156a::main, &namespace_fe8e156a::starting, "Chaos: Exfil", &namespace_fe8e156a::cleanup);
}

function init_clientfields() {
  clientfield::register("toplayer", "toggle_gameplayer_character_vis", 1, 1, "int");
  clientfield::register("scriptmover", "heli_rpg_trail", 1, 1, "int");
  clientfield::register("vehicle", "exfil_heli_exp", 1, 1, "int");
  clientfield::register("toplayer", "force_stream_weapons", 1, 1, "int");
  clientfield::register("world", "stream_heli_woods", 1, 1, "int");
  clientfield::register("world", "stream_heli", 1, 1, "int");
  namespace_347b95ee::init_clientfields();
  namespace_42da7c51::init_clientfields();
}

function init_callbacks() {
  callback::on_spawned(&function_8106e2e1);
  callback::on_connect(&function_5507f3ad);
}

function function_5507f3ad() {}

function function_8106e2e1() {
  self setcharacterbodytype(1);
  self setcharacteroutfit(2);
  thread namespace_42da7c51::setup_objectives(level.var_28c22d88[0]);
  knife = getweapon(#"knife_held");

  if(self hasweapon(knife, 1)) {
    self takeweapon(knife, 1);
  }

  switch (level.var_28c22d88[0]) {
    default:
      namespace_42da7c51::function_6154e4c2();
      break;
  }
}

function private event_handler[checkpoint_restore] function_50a91b64(eventstruct) {
  level thread function_fbd3dbf7();

  foreach(truck in level.var_abaa6487) {
    if(truck.targetname == "intro_enemy_trucks3") {
      truck vehicle::toggle_force_driver_taillights(0);
      continue;
    }

    truck thread namespace_42da7c51::function_3958f4d7("lights_intro_truck_" + truck.var_5eafe61e);
  }
}

function function_fbd3dbf7() {
  level flag::wait_till(#"all_players_spawned");
  level flag::wait_till(#"gameplay_started");

  if(level flag::get("flag_rpg_struck_heli")) {
    return;
  }

  while(!isDefined(level.var_9a3944f4) || !isDefined(level.var_9a3944f4.light)) {
    waitframe(1);
  }

  wait 0.5;
  playFXOnTag(#"hash_7d057d370983507f", level.var_9a3944f4.light, "tag_origin");
}