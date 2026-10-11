/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_33b87726793c8128.gsc
*************************************************/

#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_d21f61f8844fccc4;

function main() {
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 2);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  thread function_b4163285f6404555();
  thread function_e313ef4916d7642f();
  thread function_8d40c8541d7a2ae5();
  thread function_2c752967a2a82203();
  thread lighting_dvars();
  flag_init("disable_intro_beat");
  flag_init("enable_intro_beat_end");
  flag_init("enable_exfil_lighting");
  flag_init("lgt_infil_start");
  flag_init("intro_plane_lighting");
}

function lighting_dvars() {
  flag_wait("player_spawned_with_loadout");
}

function function_2c752967a2a82203() {
  setDvar(@ "hash_646ca256ecff2627", "-2000 -2000");
  setDvar(@ "hash_a734a8dc8ef7627e", "6000 6000");
  setDvar(@ "hash_23bb35bbc2d79a8", 1000);
  setDvar(@ "hash_27fa9f4c8976e565", 800);
  setDvar(@ "hash_bf2f16bd0028f6e3", "1.0 1.0 1.0");
  setDvar(@ "hash_33a035c99cb048b1", 1e-05);
  setDvar(@ "hash_99863fd36f21e4", 0.1);
  setDvar(@ "hash_43b1bfe24b9db3c5", 1);
  setDvar(@ "hash_70640ce906e6d9c2", 0.5);
  setDvar(@ "hash_5bb234e77e6e8500", 1);
  setDvar(@ "hash_248d3e2385cacb9b", 0);
  setDvar(@ "hash_2f948c271d3b0e2e", 1);
  setDvar(@ "hash_7623bd064c30088c", 0);
  setDvar(@ "hash_446ed387d5a2467b", 1000);
  setDvar(@ "hash_d5be9cf5305a87c0", 0.95);
  setDvar(@ "hash_383eb0dc42a487be", 75);
  setDvar(@ "hash_463c394a8f4350b0", "-.5 1.25 0.25");
  setDvar(@ "hash_6587b19cde46756e", "-1.0 1.0 0.0");
  setDvar(@ "hash_198bc49639574b81", 750);
  setDvar(@ "hash_b7ba2258818c9f3d", 1);
  setDvar(@ "hash_b7972c5881666d83", 0);
  setDvar(@ "hash_9e9f4b1cab77df95", 0.5);
  setDvar(@ "hash_9ad4ff0067a34902", 0.5);
  setDvar(@ "hash_a4d7a68bf38472d8", 1);
  setDvar(@ "hash_1f828b71214f1028", 25);
}

function function_4f634c9fb994a397() {
  flag_wait("player_spawned_with_loadout");
  flag_wait("flag_dungeon_intro_complete");
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 4);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  thread lerp_spot_intensity("infil_farah_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_lamp_post_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_fill", 0, 0);
}

function function_1d37f9a755d93118() {
  flag_wait("player_spawned_with_loadout");
  flag_wait("flag_dungeon_intro_complete");
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 4);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  thread lerp_spot_intensity("infil_farah_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_lamp_post_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_fill", 0, 0);
}

function function_a03a8a9f23f22041() {
  flag_wait("player_spawned_with_loadout");
  flag_wait("flag_dungeon_intro_complete");
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 4);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  level.player thread utility::dof_disable_autofocus();
  level.player disablephysicaldepthoffieldscripting();
  thread lerp_spot_intensity("infil_farah_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_lamp_post_rim", 0, 0);
  thread lerp_spot_intensity("infil_farah_fill", 0, 0);
}

function function_b4163285f6404555() {
  flag_wait("lgt_infil_begin");

  if(flag("flag_dungeon_intro_complete")) {
    return;
  }

  wait 0.05;
  level.var_f86dca03b4e10a79 = 1;
  showcinematicletterboxing(0, 0);
  thread function_61a998996cc98831();
  wait 0.1;
  setDvar(@ "hash_e08232af8b8b695c", 6);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 32);
  setDvar(@ "hash_cb82c01fec2d534b", 32);
  setDvar(@ "hash_eca4b727b01fd254", 2);
  flag_wait("lgt_infil_farah_turn");
  thread lerp_spot_intensity("infil_farah_key", 2, 0);
  thread lerp_spot_intensity("infil_farah_rim", 2, 0.4);
  thread lerp_spot_intensity("infil_farah_lamp_post_rim", 2, 6);
  flag_wait("lgt_infil_farah_box");
  hidecinematicletterboxing(1.5, 0);
  thread lerp_spot_intensity("infil_farah_rim", 2, 0);
  thread lerp_spot_intensity("infil_farah_lamp_post_rim", 2, 0);
  thread lerp_spot_intensity("infil_farah_fill", 2, 0);
  level waittill("lgt_infil_end");
  thread function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 4);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  level.var_f86dca03b4e10a79 = undefined;
}

function function_e313ef4916d7642f() {
  flag_wait("lgt_infil_begin");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(1, 30, 3, 3);
  flag_wait("lgt_infil_farah_foreground");
  level.player setphysicaldepthoffield(10, 150, 3, 3);
  level waittill("lgt_infil_end");
  level.player disablephysicaldepthoffieldscripting();
}

function run_thread_on_targetname(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  if(isDefined(level.getspawnerarrayfunction)) {
    all = builtin[[level.getspawnerarrayfunction]](msg);

    foreach(s in all) {
      if(isnonentspawner(s)) {
        array_thread([s], func, param1, param2, param3);
      }
    }
  }

  array = getStructArray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
  array = builtin[[level.getnodearrayfunction]](msg, "targetname");
  array_thread(array, func, param1, param2, param3);
  array = getvehiclenodearray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
}

function function_90b064f86380993b() {
  flag_wait("player_spawned_with_loadout");
  wait 0.1;
  run_thread_on_targetname("ranch_intro_beat_flow_lgt_trig", &ranch_intro_beat_flow_lgt_trig);
}

function ranch_intro_beat_flow_lgt_trig() {
  while(true) {
    self waittill("trigger");
    thread lerp_dvar(@ "hash_8667c0bb90c5bfc3", 4500, 3);
    waitframe();

    while(level.player istouching(self)) {
      wait 0.05;
    }

    flag_set("disable_intro_beat");
    thread lerp_dvar(@ "hash_8667c0bb90c5bfc3", 1500, 3);
  }
}

function function_8d40c8541d7a2ae5() {
  flag_init("enable_interior_shadows");
  flag_wait("player_spawned_with_loadout");
  thread function_59ac5fc08e49d758();
}

function function_59ac5fc08e49d758() {
  wait 0.05;
  level.var_adf2baf353988a4e = 0;
  interior_triggers = getEntArray("INTERIOR_TRIGGERS", "targetname");

  foreach(interior_trigger in interior_triggers) {
    interior_trigger thread function_429e69dcbcc4bf1d();
  }

  while(true) {
    level waittill("interior_trigger_count_updated");
    waittillframeend();

    if(level.var_adf2baf353988a4e > 0) {
      setsaveddvar(@ "hash_8667c0bb90c5bfc3", 500);
      continue;
    }

    setsaveddvar(@ "hash_8667c0bb90c5bfc3", 4500);

    if(level.player isxb3player()) {
      setsaveddvar(@ "hash_8667c0bb90c5bfc3", 3000);
    }

    if(level.player isps4player()) {
      setsaveddvar(@ "hash_8667c0bb90c5bfc3", 3000);
    }
  }
}

function function_429e69dcbcc4bf1d() {
  while(true) {
    self waittill("trigger");
    level.var_adf2baf353988a4e++;
    level notify("interior_trigger_count_updated");

    while(level.player istouching(self)) {
      wait 0.1;
    }

    level.var_adf2baf353988a4e--;
    level notify("interior_trigger_count_updated");
  }
}

function function_12d204d855154905() {
  thread function_f753e0176a8960ff();
  thread function_1be9145b47c4b31d();
  level.var_f86dca03b4e10a79 = 1;
  level.player utility::hidehudenable();
  showcinematicletterboxing(1.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_key", 0, 0.02);
  thread lerp_spot_intensity("vehicle_interior_lgt_key_2", 0, 0.02);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_open_door", 0, 0.02);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_seat_1", 0, 0.005);
  thread lerp_spot_intensity("vehicle_interior_lgt_alex_rim_ext", 0, 0.05);
  wait 0.8;
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_open_door", 0.3, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_door", 1.3, 1.6);
  wait 4.1;
  thread lerp_spot_intensity("vehicle_interior_lgt_key", 2.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_key_2", 2.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_truck_bounce", 2.5, 0.02);
  thread lerp_spot_intensity("vehicle_interior_lgt_truck_bounce_2", 2.5, 0.06);
  thread lerp_spot_intensity("vehicle_interior_lgt_lamp_incar", 6, 0.8);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_seat_1", 2.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_seat_2", 2.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_fill_door", 2.5, 0);
  thread lerp_spot_intensity("vehicle_interior_lgt_fara_rim_int", 2.5, 0.01);
  thread lerp_spot_intensity("vehicle_interior_lgt_alex_rim_int", 2.5, 0.02);
  thread lerp_spot_intensity("vehicle_interior_lgt_alex_rim_ext", 2.5, 0);
}

function function_f753e0176a8960ff() {
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(1, 25, 15, 50);
  wait 1.5;
  level.player setphysicaldepthoffield(1.5, 50, 15, 50);
  wait 1.5;
  level.player setphysicaldepthoffield(1.5, 40, 15, 50);
  wait 6;
  level.player setphysicaldepthoffield(5, 1000, 15, 50);
}

function function_1be9145b47c4b31d() {
  thread function_61a998996cc98831();
  thread lerp_dvar(@ "hash_8667c0bb90c5bfc3", 500, 0);
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 8);
  setDvar(@ "hash_eca4b727b01fd254", 12);
  setDvar(@ "hash_e08232af8b8b695c", 16);
  setDvar(@ "hash_63eb1893f96ac98d", 16);
  setsaveddvar(@ "hash_1dde331a8e0153d8", 16);
}