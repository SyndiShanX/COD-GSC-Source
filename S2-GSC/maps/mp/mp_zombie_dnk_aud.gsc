/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dnk_aud.gsc
*********************************************/

func_00F9() {
  lib_0367::func_8E3E("bp_ship");
  func_7BBA();
  func_5C22();
  level.var_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level.var_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  lib_0366::snd_set_mus_combat_cues_override(level.var_11CB.wave_cues);
  lib_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  lib_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

func_5C22() {
  thread func_35E1();
  thread cable_oneshots();
  thread boat_oneshots();
  thread wave_oneshots();
  thread pool_oneshots();
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("aud_repair_leaking_water", ::repair_leaking_water);
  lib_0378::func_8DC7("zombie_soul_suck", ::func_ABF8);
  lib_0378::func_8DC7("zombie_soul_suck_threshold", ::func_ABF9);
  lib_0378::func_8DC7("start_water_trap", ::start_water_trap);
  lib_0378::func_8DC7("water_trap_damage_player", ::water_trap_damage_player);
  lib_0378::func_8DC7("zmb_dnk_ship_tilt", ::zmb_dnk_ship_tilt);
  lib_0378::func_8DC7("start_vehicle_slide", ::start_vehicle_slide);
  lib_0378::func_8DC7("straub_laugh_hallucination", ::straub_laugh_hallucination);
  lib_0378::func_8DC7("zmb_dnk_uber_leak_start", ::zmb_dnk_uber_leak_start);
  lib_0378::func_8DC7("zmb_fish_jump", ::zmb_fish_jump);
  lib_0378::func_8DC7("ee_follow_fish_earthquake", ::ee_follow_fish_earthquake);
  lib_0378::func_8DC7("ctf_void_enter", ::ctf_void_enter);
  lib_0378::func_8DC7("ctf_void_exit", ::ctf_void_exit);
  lib_0378::func_8DC7("ctf_bucket_move", ::ctf_bucket_move);
  lib_0378::func_8DC7("ctf_fish_360", ::ctf_fish_360);
  lib_0378::func_8DC7("escape_boat_rise", ::escape_boat_rise);
  lib_0378::func_8DC7("flare_fx", ::func_3D34);
}

start_intermission_music_override_callback() {
  var_00 = level.var_11CB.intermission_music_aliases[randomint(level.var_11CB.intermission_music_aliases.size)];
  var_01 = 3;
  var_02 = 5;
  lib_0366::func_8E31(var_00, var_01, var_02);
}

func_7248() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_init();
  if(!isDefined(self.var_11CB)) {
    self.var_11CB = spawnStruct();
  }
}

func_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
}

func_A979(param_00) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(param_00);
}

func_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
}

func_ABF8(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

func_ABF9(param_00) {
  lib_0380::func_2889("zombie_soul_suck_threshold", undefined, param_00);
}

start_water_trap(param_00) {
  var_01 = param_00.var_117.var_116;
  lib_0380::func_2889("zmb_dnk_trap_water_activate", undefined, var_01);
}

water_trap_damage_player() {
  var_00 = self;
  lib_0380::func_288B("zmb_dnk_trap_spark", undefined, var_00);
}

func_8E8F() {}

func_35E1() {
  level.var_11CB.var_35E1 = [];
  wait(0.5);
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_pipe_water_hum_int_lp", undefined, (70, 1557, -248));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_canvas_flap_small_lp", undefined, (930, -497, -58));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_canvas_flap_small_lp", undefined, (950, -1122, -161));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_canvas_flap_small_lp", undefined, (60, -1325, 75));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_canvas_flap_small_lp", undefined, (408, -619, 177));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_pipe_water_hum_int_lp", undefined, (681, 1635, -208));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_pipe_water_small_lp", undefined, (711, 1451, -184));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_pipe_water_hum_int_lp", undefined, (397, 692, -123));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_vent_rattle_metal_lp", undefined, (604, -207, -135));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_mp_projector_lp", undefined, (598, -354, -204));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("mp_bat_waves_lp", undefined, (-167, -1200, -190));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("mp_bat_waves_lp", undefined, (960, -900, -190));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (70, 542, -1));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (348, 834, -120));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (348, 375, -136));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (348, -3, -136));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (700, 985, -147));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (850, 1736, -184));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (610, -1518, -184));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (743, 1289, -184));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (538, 1109, -184));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (726, -601, -123));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_electric_hum_small_lp", undefined, (70, 542, -2));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_lamp_hum_lp", undefined, (172, 1109, -135));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_lamp_hum_lp", undefined, (207, 1369, -198));
  level.var_11CB.var_35E1[level.var_11CB.var_35E1.size] = lib_0380::func_6842("emt_steam_leak_int_lp", undefined, (625, 1729, -200));
}

cable_oneshots() {
  level endon("death");
  var_00 = 0.75;
  var_01 = 5;
  var_02 = 0;
  var_03 = [(401, -1290, 24), (137, -645, 90), (660, -660, 90), (280, -540, 230), (522, -540, 230), (522, -784, 230), (522, -784, 230), (280, -784, 230), (604, 243, 295), (200, 249, 299)];
  var_04 = ["mp_bat_ship_cables_creak", "mp_bat_ship_cables_wind", "emt_chain_rattles_sml", "emt_metal_stress_crane"];
  for(;;) {
    var_05 = randomint(var_03.size);
    while(var_05 == var_02) {
      var_05 = randomint(var_03.size);
    }

    var_06 = var_03[var_05];
    var_02 = var_05;
    var_07 = var_04[randomint(var_04.size)];
    lib_0380::func_2889(var_07, undefined, var_06);
    wait(randomfloatrange(var_00, var_01));
  }
}

boat_oneshots() {
  level endon("death");
  var_00 = 1.5;
  var_01 = 6;
  var_02 = 0;
  var_03 = [(125, -1055, -20), (353, -865, -20), (683, -200, 63), (570, -275, -20), (411, -91, -34), (-119, -28, 25), (916, -66, 25)];
  var_04 = ["mp_bat_metal_stress_large", "mp_bat_metal_stress", "mp_bat_metal_squeak", "mp_bat_cable_railing"];
  for(;;) {
    var_05 = randomint(var_03.size);
    while(var_05 == var_02) {
      var_05 = randomint(var_03.size);
    }

    var_06 = var_03[var_05];
    var_02 = var_05;
    var_07 = var_04[randomint(var_04.size)];
    lib_0380::func_2889(var_07, undefined, var_06);
    wait(randomfloatrange(var_00, var_01));
  }
}

wave_oneshots() {
  level endon("death");
  var_00 = 4.5;
  var_01 = 15;
  var_02 = [-167, 960];
  var_03 = -190;
  var_04 = ["mp_bat_waves_lrg", "mp_bat_waves_low"];
  for(;;) {
    var_05 = var_02[randomint(var_02.size)];
    var_06 = randomintrange(-1500, -900);
    var_07 = var_04[randomint(var_04.size)];
    var_08 = (var_05, var_06, var_03);
    lib_0380::func_2889(var_07, undefined, var_08);
    wait(randomfloatrange(var_00, var_01));
  }
}

pool_oneshots() {
  level endon("death");
  var_00 = 1.5;
  var_01 = 6;
  var_02 = 0;
  var_03 = [(248, -74, -303), (407, 1138, -303), (824, -92, -303)];
  var_04 = ["emt_water_pipe_drips"];
  for(;;) {
    var_05 = randomint(var_03.size);
    while(var_05 == var_02) {
      var_05 = randomint(var_03.size);
    }

    var_06 = var_03[var_05];
    var_02 = var_05;
    var_07 = var_04[randomint(var_04.size)];
    lib_0380::func_2889(var_07, undefined, var_06);
    wait(randomfloatrange(var_00, var_01));
  }
}

zmb_dnk_ship_tilt(param_00) {
  var_01 = 200;
  if(param_00 == "ship_tilting_starboard") {
    var_02 = var_01;
  } else {
    var_02 = -1 * var_02;
  }

  foreach(var_04 in level.var_744A) {
    var_05 = var_04.var_116 + (var_02, 0, 0);
    lib_0380::func_2889("mp_bat_waves_low", var_04, var_05);
    wait(0.3);
    lib_0380::func_2888("zmb_dnk_ship_tilt", var_04);
    lib_0380::func_2888("zmb_dnk_ship_tilt_water", var_04);
  }
}

start_vehicle_slide(param_00, param_01) {
  var_02 = self;
  switch (param_01) {
    case "ship_tilting_starboard":
      if(self.var_116 != self.starboardorigin) {
        var_02.slide_strt = lib_0380::func_288B("zmb_dnk_truck_slide_strt", undefined, var_02);
        var_02.slide_lp = lib_0380::func_6844("zmb_dnk_truck_slide_lp", undefined, var_02, 0.5);
        var_02 thread metal_wronk_oneshot(param_00);
        var_02 thread tire_squeak_oneshot(param_00);
        wait(param_00);
        lib_0380::func_6850(var_02.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_02.impact_snd = lib_0380::func_288B("zmb_dnk_truck_slide_imp", undefined, var_02);
      }
      break;

    case "ship_tilting_port":
      if(self.var_116 != self.portorigin) {
        var_02.slide_strt = lib_0380::func_288B("zmb_dnk_truck_slide_strt", undefined, var_02);
        var_02.slide_lp = lib_0380::func_6844("zmb_dnk_truck_slide_lp", undefined, var_02, 0.5);
        var_02 thread metal_wronk_oneshot(param_00);
        var_02 thread tire_squeak_oneshot(param_00);
        wait(param_00);
        lib_0380::func_6850(var_02.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_02.impact_snd = lib_0380::func_288B("zmb_dnk_truck_slide_imp", undefined, var_02);
      }
      break;

    case "ship_tilting_original":
      if(self.var_116 != self.var_6C55) {
        var_02.slide_strt = lib_0380::func_288B("zmb_dnk_truck_slide_strt", undefined, var_02);
        var_02.slide_lp = lib_0380::func_6844("zmb_dnk_truck_slide_lp", undefined, var_02, 0.5);
        var_02 thread metal_wronk_oneshot(param_00);
        var_02 thread tire_squeak_oneshot(param_00);
        wait(param_00);
        lib_0380::func_6850(var_02.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_02.impact_snd = lib_0380::func_288B("zmb_dnk_truck_slide_imp", undefined, var_02);
      }
      break;
  }

  level.ship_is_tilting = 0;
}

metal_wronk_oneshot(param_00) {
  self endon("aud_stop_vehicle_slide_oneshots");
  var_01 = self;
  for(;;) {
    var_02 = randomfloatrange(0.1, 0.3);
    var_03 = lib_0380::func_288B("zmb_dnk_metal_wronks", undefined, var_01);
    lib_0380::func_288F(var_03, var_01, "metal_wronk_done");
    var_01 waittill("metal_wronk_done");
    wait(var_02);
  }
}

tire_squeak_oneshot(param_00) {
  self endon("aud_stop_vehicle_slide_oneshots");
  var_01 = self;
  for(;;) {
    var_02 = randomfloatrange(1.5, 2);
    var_03 = lib_0380::func_288B("zmb_dnk_tire_squeaks", undefined, var_01);
    lib_0380::func_288F(var_03, var_01, "tire_squeak_done");
    var_01 waittill("tire_squeak_done");
    wait(var_02);
  }
}

repair_leaking_water() {
  var_00 = self;
  level endon("sg_obj_timeout");
  lib_0380::func_6842("mp_bat_pipe_burst", undefined, var_00.var_116);
  wait(0.5);
  var_00.spraying_snd = lib_0380::func_6842("emt_water_pipe_spray_lp", undefined, var_00.var_116, 0.1);
  var_00.dripping_snd = lib_0380::func_6842("mp_bat_hose_water_lp", undefined, var_00.var_116, 0.1);
  var_00.humming_snd = lib_0380::func_6842("emt_pipe_water_hum_in_lp", undefined, var_00.var_116, 0.1);
  self waittill("interact_completed");
  lib_0380::func_6850(var_00.spraying_snd, 0.75);
  lib_0380::func_6850(var_00.dripping_snd, 0.75);
  lib_0380::func_6850(var_00.humming_snd, 0.75);
}

straub_laugh_hallucination(param_00) {
  lib_0380::func_2888("straub_laugh_hallucination", param_00);
}

zmb_dnk_uber_leak_start(param_00) {
  var_01 = lib_0380::func_6842("zmb_dnk_uber_leak_start", undefined, param_00);
  level.var_11CB.uber_leak_loop = lib_0380::func_6842("zmb_dnk_uber_leak_lp", undefined, param_00);
}

zmb_dnk_uber_leak_stop() {
  lib_0380::func_6850(level.var_11CB.uber_leak_loop);
}

zmb_fish_jump(param_00) {
  lib_0380::func_2889("zmb_fish_jump", undefined, param_00.var_116);
}

ee_follow_fish_earthquake(param_00) {
  var_01 = param_00 * 0.2;
  var_02 = param_00 * 0.6;
  var_03 = lib_0380::func_6840("zmb_dnk_ship_shake", undefined, var_01);
  wait(param_00 - var_02);
  var_04 = lib_0380::func_6840("zmb_dnk_ship_shake_sweetener");
  lib_0380::func_684E(var_03, 0, var_02 * 1.25);
  wait(var_02 * 1.25);
  lib_0380::func_6850(var_03, var_02 * 1.25);
}

ctf_void_enter() {
  foreach(var_01 in level.var_744A) {
    var_01 soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_clear();
    var_01 method_8626("enter_the_void", 3);
    var_01 notify("kill_dlc3_wave_mus_switcher");
    var_01 thread play_void_music();
    var_01.var_11CB.in_the_void = 1;
  }

  var_03 = lib_0380::func_2888("ctf_void_enter");
  level.var_11CB.void_ambi = lib_0380::func_6840("amb_zmb_dnk_the_void_ext", undefined, 3);
}

ctf_void_exit() {
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("enter_the_void", 3);
    var_01 lib_0366::func_8E09();
    var_01 notify("kill_void_music_thread");
    var_01.var_11CB.in_the_void = undefined;
  }

  var_03 = lib_0380::func_2888("ctf_void_exit");
  lib_0380::func_6850(level.var_11CB.void_ambi, 3);
  lib_0380::func_6850(level.var_11CB.void_geist_gun_lp, 1);
}

play_void_music() {
  self endon("kill_void_music_thread");
  var_00 = 4;
  var_01 = ["zmb_mus_creepy_amb_lp_01", "zmb_mus_creepy_amb_lp_02", "zmb_mus_creepy_amb_lp_03", "zmb_mus_creepy_amb_lp_04", "zmb_mus_creepy_amb_lp_05", "zmb_mus_creepy_amb_lp_06"];
  for(;;) {
    lib_0366::func_8E31(var_01[randomint(var_01.size)], var_00);
    wait(randomintrange(120, 180));
    lib_0366::func_8E32(var_00);
  }
}

ctf_bucket_move(param_00, param_01) {
  thread ctf_bucket_start_stop(param_00, param_01);
  var_02 = lib_0380::func_6844("ctf_bucket_move", undefined, param_00);
  wait(param_01 * 0.8);
  lib_0380::func_684E(var_02, 0, param_01 * 0.2 + 0.15);
  wait(1);
  lib_0380::func_6850(var_02);
}

ctf_bucket_start_stop(param_00, param_01) {
  var_02 = lib_0380::func_6844("ctf_bucket_start_stop", undefined, param_00);
  wait(param_01 * 0.9);
  var_02 = lib_0380::func_6844("ctf_bucket_start_stop", undefined, param_00);
}

ctf_fish_360(param_00, param_01) {
  param_01 = param_01 * 0.5;
  var_02 = lib_0380::func_6842("ctf_fish_360", undefined, param_00);
  wait(param_01);
  var_02 = lib_0380::func_6842("ctf_fish_360_2", undefined, param_00);
}

escape_boat_rise(param_00) {
  lib_0380::func_288B("zmb_dnk_boat_rise_strt", undefined, self);
  var_01 = lib_0380::func_6844("zmb_dnk_boat_rise_lp", undefined, self, 0.75);
  wait(param_00 - 2.75);
  lib_0380::func_6850(var_01, 1);
  lib_0380::func_288B("zmb_dnk_boat_rise_end", undefined, self);
}

func_3D34() {
  var_00 = (1078, -560, -2196);
  lib_0380::func_2889("void_flare_vfx", undefined, var_00);
  if(!isDefined(level.var_11CB.void_geist_gun_lp)) {
    level.var_11CB.void_geist_gun_lp = lib_0380::func_6842("void_geist_gun_lp", undefined, (1016, -392, -2108));
  }
}