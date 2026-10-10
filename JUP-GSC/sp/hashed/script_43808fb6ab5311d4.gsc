/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_43808fb6ab5311d4.gsc
*************************************************/

#using script_222a289abd7b1064;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_98841a455c1f61d4;

function main() {
  thread function_bb46f3b62442eb0b();
  thread function_97fa450d44ef3a35();
  thread function_55ed75e1b80a8fd0();
  thread function_e0a6df1c25f90ea1();
  thread function_c7a011bca059d46e();
  thread function_80ca1ce08e9a1007();
}

function function_a6fea76a4085e5c1() {
  wait 1;
  setDvar(@ "hash_7c6e3f49a053cc4c", 0.2);
  setDvar(@ "hash_b345e52965c135b5", 0.2);
  setDvar(@ "hash_bc13d3a46e2c2877", 0.4);
}

function function_380ba3d037ad5bdb() {
  wait 0.05;
  flag_wait("player_spawned_with_loadout");
}

function function_1be9145b47c4b31d() {
  thread function_61a998996cc98831();
  setDvar(@ "hash_6e3f8cef6be16b33", 1);
  setDvar(@ "hash_1ea8544d78048529", 1);
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 8);
  setDvar(@ "hash_eca4b727b01fd254", 12);
  setDvar(@ "hash_e08232af8b8b695c", 6);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
}

function function_26280fbed5700639() {
  thread function_9160006a3f10b2cd();
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_dacffbfd52c2fdc5", 8);
  setDvar(@ "hash_cb82c01fec2d534b", 8);
  setDvar(@ "hash_e08232af8b8b695c", 2);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
}

function function_97fa450d44ef3a35() {
  flag_wait("lgt_intro_start");
  level.var_f86dca03b4e10a79 = 1;
  showcinematicletterboxing(0, 0);
  thread function_1be9145b47c4b31d();
  thread function_a91a68d942ea5bcf();
  setDvar(@ "hash_8667c0bb90c5bfc3", 5000);
  function_238c2a0aae70e973("intro_cin_light_rim_shot_1", 0, 3);
  function_238c2a0aae70e973("intro_cin_light_under_key", 0, 12);
  function_238c2a0aae70e973("intro_cin_light_under_rim", 0, 4);
  function_238c2a0aae70e973("intro_cin_lights_top_strong_rim", 0, 8);
  function_238c2a0aae70e973("top_dam_light_1", 0, 10);
  flag_wait("lgt_intro_lookup");
  flag_wait("lgt_intro_top");
  function_238c2a0aae70e973("intro_cin_lights_top_strong_rim", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_top_key", 0, 0.48);
  function_238c2a0aae70e973("intro_cin_light_top_rim", 0, 3.18);
  function_238c2a0aae70e973("intro_cin_light_top_under", 0.25, 4);
  flag_wait("lgt_intro_closeup");
  function_238c2a0aae70e973("intro_cin_light_under_key_shot4", 0, 3.18);
  function_238c2a0aae70e973("intro_cin_light_rim_shot_4", 0, 2);
  function_238c2a0aae70e973("intro_cin_light_rim_shot_1", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_under_key", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_under_rim", 0, 0);
  hidecinematicletterboxing(2, 0);
  level waittill("lgt_intro_end");
  function_238c2a0aae70e973("intro_cin_light_rim_shot_1", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_under_key", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_under_rim", 0, 0);
  function_238c2a0aae70e973("intro_cin_lights_top_strong_rim", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_top_key", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_top_rim", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_top_under", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_under_key_shot4", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_rim_shot_4", 0, 0);
  function_238c2a0aae70e973("intro_cin_light_rim_shot_4", 0, 0);
  level.var_f86dca03b4e10a79 = undefined;
  thread function_26280fbed5700639();
  thread function_a6fea76a4085e5c1();
  wait 2;
  setDvar(@ "hash_8667c0bb90c5bfc3", 1500);
  thread function_c8abae08e191a6c7();
}

function function_c8abae08e191a6c7() {
  wait 0.05;
  infil_lights = getEntArray("infil_lights", "script_noteworthy");

  if(isDefined(infil_lights)) {
    foreach(light in infil_lights) {
      light setlightintensity(0);
      wait 0.1;
      light delete();
    }
  }
}

function function_7b3ec3155fda930b() {
  wait 0.05;
  top_of_dam_lights = getEntArray("top_of_dam_lights", "script_noteworthy");

  if(isDefined(top_of_dam_lights)) {
    foreach(light in top_of_dam_lights) {
      light setlightintensity(0);
      wait 0.1;
      light delete();
    }
  }
}

function function_a91a68d942ea5bcf() {
  flag_wait("lgt_intro_start");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2, 170, 15, 50);
  flag_wait("lgt_intro_lookup");
  level.player setphysicaldepthoffield(2, 550, 15, 50);
  flag_wait("lgt_intro_top");
  level.player setphysicaldepthoffield(2, 160, 15, 50);
  flag_wait("lgt_intro_closeup");
  level.player setphysicaldepthoffield(4, 60, 15, 50);
  level waittill("lgt_intro_end");
  level.player disablephysicaldepthoffieldscripting();
}

function function_18b504ad8c1a063a() {
  wait 1;
  probe = getEnt("helicopter_reflection_probe", "targetname");
  probe linkTo(level.heli_model, "tag_light_interior_01", (120, -1, -50), (0, 0, 0));
  light = getEnt("exfil_light_1", "targetname");
  light linkTo(level.heli_model, "tag_light_interior_01", (0, 0, -1), (90, 0, 0));
  light = getEnt("exfil_light_2", "targetname");
  light linkTo(level.heli_model, "tag_light_interior_03", (0, 0, -1), (90, 0, 0));
}

function function_bb46f3b62442eb0b() {
  flag_wait("flag_dungeon_intro_complete");
  var_56aba44597c62c29 = getEntArray("top_dam_trigger", "targetname");

  foreach(var_6c5ffb662f1c557a in var_56aba44597c62c29) {
    var_6c5ffb662f1c557a thread function_16c4c769edad3860();
  }
}

function function_16c4c769edad3860() {
  self waittill("trigger");
  thread lerp_dvar(@ "hash_5a83a561cb4970b2", 6000, 15);
  thread function_238c2a0aae70e973("car_tail_lights", 15, 0.64);
  thread function_7b3ec3155fda930b();
  thread function_c8abae08e191a6c7();
}

function function_345c92e9f27a2056() {
  var_eed66cd61a8d4130 = getEntArray("light_trig_on", "targetname");

  foreach(var_351e125a1ef0e2f8 in var_eed66cd61a8d4130) {
    var_351e125a1ef0e2f8 thread function_3b9dbd0a40675e06();
  }
}

function function_3b9dbd0a40675e06() {
  while(true) {
    self waittill("trigger");
    function_238c2a0aae70e973("tunnel_light", 4, 5);
  }
}

function function_a1da388042baee18() {
  var_659d41a0b3e63acc = getEntArray("light_trig_off", "targetname");

  foreach(var_414d1b98bcb6ad02 in var_659d41a0b3e63acc) {
    var_414d1b98bcb6ad02 thread function_7176fa10a981b4ea();
  }
}

function function_7176fa10a981b4ea() {
  while(true) {
    self waittill("trigger");
    function_238c2a0aae70e973("tunnel_light", 2, 0);
  }
}

function function_55ed75e1b80a8fd0() {
  wait 0.5;
  ents1 = getEntArray("water_bomb_lights", "targetname");

  foreach(light in ents1) {
    light thread blink_light(0.5, 0.3, 0, 1, 0.75, 0.5);
    thread namespace_cf0990776c0e3528::function_7a77200a30e3cf3d(light, "flag_bomb_1_defused");
  }

  flag_wait("flag_bomb_1_defused");

  foreach(light in ents1) {
    light notify("kill_flicker");
    wait 0.05;
    light setlightintensity(0);
  }
}

function function_e0a6df1c25f90ea1() {
  wait 0.5;
  ents2 = getEntArray("catwalk_bomb_lights", "targetname");

  foreach(light in ents2) {
    light thread blink_light(0.5, 0.3, 0, 1, 0.75, 1);
    thread namespace_cf0990776c0e3528::function_f70f9e22bd8bc6c5(light, "flag_bomb_2_defused");
  }

  flag_wait("flag_bomb_2_defused");

  foreach(light in ents2) {
    light notify("kill_flicker");
    wait 0.05;
    light setlightintensity(0);
  }
}

function function_c7a011bca059d46e() {
  wait 0.5;
  var_f90822454418f294 = getEntArray("bunker_bomb_lights", "targetname");

  foreach(light in var_f90822454418f294) {
    light thread blink_light(0.5, 0.3, 0, 1, 0.75, 0.5);
    thread namespace_cf0990776c0e3528::function_f70f9e22bd8bc6c5(light, "flag_bomb_3_defused");
  }

  flag_wait("flag_bomb_3_defused");

  foreach(light in var_f90822454418f294) {
    light notify("kill_flicker");
    wait 0.05;
    light setlightintensity(0);
  }
}

function function_80ca1ce08e9a1007() {
  wait 0.5;
  flag_wait("flag_bomb_4_defused");
}