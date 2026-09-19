/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dnk_aud.gsc
*************************************************/

main() {
  _id_0367::_id_8E3E("bp_ship");
  _id_7BBA();
  _id_5C22();
  level._id_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level._id_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  _id_0366::snd_set_mus_combat_cues_override(level._id_11CB.wave_cues);
  _id_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  _id_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

_id_5C22() {
  thread _id_35E1();
  thread cable_oneshots();
  thread boat_oneshots();
  thread wave_oneshots();
  thread pool_oneshots();
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("aud_repair_leaking_water", ::repair_leaking_water);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
  _id_0378::_id_8DC7("start_water_trap", ::start_water_trap);
  _id_0378::_id_8DC7("water_trap_damage_player", ::water_trap_damage_player);
  _id_0378::_id_8DC7("zmb_dnk_ship_tilt", ::zmb_dnk_ship_tilt);
  _id_0378::_id_8DC7("start_vehicle_slide", ::start_vehicle_slide);
  _id_0378::_id_8DC7("straub_laugh_hallucination", ::straub_laugh_hallucination);
  _id_0378::_id_8DC7("zmb_dnk_uber_leak_start", ::zmb_dnk_uber_leak_start);
  _id_0378::_id_8DC7("zmb_fish_jump", ::zmb_fish_jump);
  _id_0378::_id_8DC7("ee_follow_fish_earthquake", ::ee_follow_fish_earthquake);
  _id_0378::_id_8DC7("ctf_void_enter", ::ctf_void_enter);
  _id_0378::_id_8DC7("ctf_void_exit", ::ctf_void_exit);
  _id_0378::_id_8DC7("ctf_bucket_move", ::ctf_bucket_move);
  _id_0378::_id_8DC7("ctf_fish_360", ::ctf_fish_360);
  _id_0378::_id_8DC7("escape_boat_rise", ::escape_boat_rise);
  _id_0378::_id_8DC7("flare_fx", ::_id_3D34);
}

start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_7248() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_init();

  if(!isDefined(self._id_11CB))
    self._id_11CB = spawnStruct();
}

_id_7330() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_player_spawned();
}

_id_A979(var_0) {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_begin(var_0);
}

_id_A97A() {
  soundscripts\_snd_common_zmb_dlc3::dlc3_wave_end();
}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 _meth_82B1(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

_id_ABF9(var_0) {
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_0);
}

start_water_trap(var_0) {
  var_1 = var_0._id_0117.origin;
  _id_0380::_id_2889("zmb_dnk_trap_water_activate", undefined, var_1);
}

water_trap_damage_player() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dnk_trap_spark", undefined, var_0);
}

_id_8E8F() {}

_id_35E1() {
  level._id_11CB._id_35E1 = [];
  wait 0.5;
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_pipe_water_hum_int_lp", undefined, (70, 1557, -248));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_canvas_flap_small_lp", undefined, (930, -497, -58));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_canvas_flap_small_lp", undefined, (950, -1122, -161));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_canvas_flap_small_lp", undefined, (60, -1325, 75));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_canvas_flap_small_lp", undefined, (408, -619, 177));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_pipe_water_hum_int_lp", undefined, (681, 1635, -208));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_pipe_water_small_lp", undefined, (711, 1451, -184));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_pipe_water_hum_int_lp", undefined, (397, 692, -123));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_vent_rattle_metal_lp", undefined, (604, -207, -135));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_mp_projector_lp", undefined, (598, -354, -204));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("mp_bat_waves_lp", undefined, (-167, -1200, -190));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("mp_bat_waves_lp", undefined, (960, -900, -190));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (70, 542, -1));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (348, 834, -120));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (348, 375, -136));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (348, -3, -136));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (700, 985, -147));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (850, 1736, -184));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (610, -1518, -184));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (743, 1289, -184));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (538, 1109, -184));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (726, -601, -123));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_electric_hum_small_lp", undefined, (70, 542, -2));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_lamp_hum_lp", undefined, (172, 1109, -135));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_lamp_hum_lp", undefined, (207, 1369, -198));
  level._id_11CB._id_35E1[level._id_11CB._id_35E1.size] = _id_0380::_id_6842("emt_steam_leak_int_lp", undefined, (625, 1729, -200));
}

cable_oneshots() {
  level endon("death");
  var_0 = 0.75;
  var_1 = 5.0;
  var_2 = 0;
  var_3 = [(401, -1290, 24), (137, -645, 90), (660, -660, 90), (280, -540, 230), (522, -540, 230), (522, -784, 230), (522, -784, 230), (280, -784, 230), (604, 243, 295), (200, 249, 299)];
  var_4 = ["mp_bat_ship_cables_creak", "mp_bat_ship_cables_wind", "emt_chain_rattles_sml", "emt_metal_stress_crane"];

  for(;;) {
    for(var_5 = randomint(var_3.size); var_5 == var_2; var_5 = randomint(var_3.size)) {}

    var_6 = var_3[var_5];
    var_2 = var_5;
    var_7 = var_4[randomint(var_4.size)];
    _id_0380::_id_2889(var_7, undefined, var_6);
    wait(_func_0A5(var_0, var_1));
  }
}

boat_oneshots() {
  level endon("death");
  var_0 = 1.5;
  var_1 = 6.0;
  var_2 = 0;
  var_3 = [(125, -1055, -20), (353, -865, -20), (683, -200, 63), (570, -275, -20), (411, -91, -34), (-119, -28, 25), (916, -66, 25)];
  var_4 = ["mp_bat_metal_stress_large", "mp_bat_metal_stress", "mp_bat_metal_squeak", "mp_bat_cable_railing"];

  for(;;) {
    for(var_5 = randomint(var_3.size); var_5 == var_2; var_5 = randomint(var_3.size)) {}

    var_6 = var_3[var_5];
    var_2 = var_5;
    var_7 = var_4[randomint(var_4.size)];
    _id_0380::_id_2889(var_7, undefined, var_6);
    wait(_func_0A5(var_0, var_1));
  }
}

wave_oneshots() {
  level endon("death");
  var_0 = 4.5;
  var_1 = 15.0;
  var_2 = [-167, 960];
  var_3 = -190;
  var_4 = ["mp_bat_waves_lrg", "mp_bat_waves_low"];

  for(;;) {
    var_5 = var_2[randomint(var_2.size)];
    var_6 = _func_0A4(-1500, -900);
    var_7 = var_4[randomint(var_4.size)];
    var_8 = (var_5, var_6, var_3);
    _id_0380::_id_2889(var_7, undefined, var_8);
    wait(_func_0A5(var_0, var_1));
  }
}

pool_oneshots() {
  level endon("death");
  var_0 = 1.5;
  var_1 = 6.0;
  var_2 = 0;
  var_3 = [(248, -74, -303), (407, 1138, -303), (824, -92, -303)];
  var_4 = ["emt_water_pipe_drips"];

  for(;;) {
    for(var_5 = randomint(var_3.size); var_5 == var_2; var_5 = randomint(var_3.size)) {}

    var_6 = var_3[var_5];
    var_2 = var_5;
    var_7 = var_4[randomint(var_4.size)];
    _id_0380::_id_2889(var_7, undefined, var_6);
    wait(_func_0A5(var_0, var_1));
  }
}

zmb_dnk_ship_tilt(var_0) {
  var_1 = 200;

  if(var_0 == "ship_tilting_starboard")
    var_2 = var_1;
  else
    var_2 = -1 * var_1;

  foreach(var_4 in level.players) {
    var_5 = var_4.origin + (var_2, 0, 0);
    _id_0380::_id_2889("mp_bat_waves_low", var_4, var_5);
    wait 0.3;
    _id_0380::_id_2888("zmb_dnk_ship_tilt", var_4);
    _id_0380::_id_2888("zmb_dnk_ship_tilt_water", var_4);
  }
}

start_vehicle_slide(var_0, var_1) {
  var_2 = self;

  switch (var_1) {
    case "ship_tilting_starboard":
      if(self.origin != self.starboardorigin) {
        var_2.slide_strt = _id_0380::_id_288B("zmb_dnk_truck_slide_strt", undefined, var_2);
        var_2.slide_lp = _id_0380::_id_6844("zmb_dnk_truck_slide_lp", undefined, var_2, 0.5);
        var_2 thread metal_wronk_oneshot(var_0);
        var_2 thread tire_squeak_oneshot(var_0);
        wait(var_0);
        _id_0380::_id_6850(var_2.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_2.impact_snd = _id_0380::_id_288B("zmb_dnk_truck_slide_imp", undefined, var_2);
      }

      break;
    case "ship_tilting_port":
      if(self.origin != self.portorigin) {
        var_2.slide_strt = _id_0380::_id_288B("zmb_dnk_truck_slide_strt", undefined, var_2);
        var_2.slide_lp = _id_0380::_id_6844("zmb_dnk_truck_slide_lp", undefined, var_2, 0.5);
        var_2 thread metal_wronk_oneshot(var_0);
        var_2 thread tire_squeak_oneshot(var_0);
        wait(var_0);
        _id_0380::_id_6850(var_2.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_2.impact_snd = _id_0380::_id_288B("zmb_dnk_truck_slide_imp", undefined, var_2);
      }

      break;
    case "ship_tilting_original":
      if(self.origin != self._id_6C55) {
        var_2.slide_strt = _id_0380::_id_288B("zmb_dnk_truck_slide_strt", undefined, var_2);
        var_2.slide_lp = _id_0380::_id_6844("zmb_dnk_truck_slide_lp", undefined, var_2, 0.5);
        var_2 thread metal_wronk_oneshot(var_0);
        var_2 thread tire_squeak_oneshot(var_0);
        wait(var_0);
        _id_0380::_id_6850(var_2.slide_lp, 0.3);
        self notify("aud_stop_vehicle_slide_oneshots");
        var_2.impact_snd = _id_0380::_id_288B("zmb_dnk_truck_slide_imp", undefined, var_2);
      }

      break;
  }

  level.ship_is_tilting = 0;
}

metal_wronk_oneshot(var_0) {
  self endon("aud_stop_vehicle_slide_oneshots");
  var_1 = self;

  for(;;) {
    var_2 = _func_0A5(0.1, 0.3);
    var_3 = _id_0380::_id_288B("zmb_dnk_metal_wronks", undefined, var_1);
    _id_0380::_id_288F(var_3, var_1, "metal_wronk_done");
    var_1 waittill("metal_wronk_done");
    wait(var_2);
  }
}

tire_squeak_oneshot(var_0) {
  self endon("aud_stop_vehicle_slide_oneshots");
  var_1 = self;

  for(;;) {
    var_2 = _func_0A5(1.5, 2);
    var_3 = _id_0380::_id_288B("zmb_dnk_tire_squeaks", undefined, var_1);
    _id_0380::_id_288F(var_3, var_1, "tire_squeak_done");
    var_1 waittill("tire_squeak_done");
    wait(var_2);
  }
}

repair_leaking_water() {
  var_0 = self;
  level endon("sg_obj_timeout");
  _id_0380::_id_6842("mp_bat_pipe_burst", undefined, var_0.origin);
  wait 0.5;
  var_0.spraying_snd = _id_0380::_id_6842("emt_water_pipe_spray_lp", undefined, var_0.origin, 0.1);
  var_0.dripping_snd = _id_0380::_id_6842("mp_bat_hose_water_lp", undefined, var_0.origin, 0.1);
  var_0.humming_snd = _id_0380::_id_6842("emt_pipe_water_hum_in_lp", undefined, var_0.origin, 0.1);
  self waittill("interact_completed");
  _id_0380::_id_6850(var_0.spraying_snd, 0.75);
  _id_0380::_id_6850(var_0.dripping_snd, 0.75);
  _id_0380::_id_6850(var_0.humming_snd, 0.75);
}

straub_laugh_hallucination(var_0) {
  _id_0380::_id_2888("straub_laugh_hallucination", var_0);
}

zmb_dnk_uber_leak_start(var_0) {
  var_1 = _id_0380::_id_6842("zmb_dnk_uber_leak_start", undefined, var_0);
  level._id_11CB.uber_leak_loop = _id_0380::_id_6842("zmb_dnk_uber_leak_lp", undefined, var_0);
}

zmb_dnk_uber_leak_stop() {
  _id_0380::_id_6850(level._id_11CB.uber_leak_loop);
}

zmb_fish_jump(var_0) {
  _id_0380::_id_2889("zmb_fish_jump", undefined, var_0.origin);
}

ee_follow_fish_earthquake(var_0) {
  var_1 = var_0 * 0.2;
  var_2 = var_0 * 0.6;
  var_3 = _id_0380::_id_6840("zmb_dnk_ship_shake", undefined, var_1);
  wait(var_0 - var_2);
  var_4 = _id_0380::_id_6840("zmb_dnk_ship_shake_sweetener");
  _id_0380::_id_684E(var_3, 0, var_2 * 1.25);
  wait(var_2 * 1.25);
  _id_0380::_id_6850(var_3, var_2 * 1.25);
}

ctf_void_enter() {
  foreach(var_1 in level.players) {
    var_1 soundscripts\_snd_common_zmb_dlc3::dlc3_altered_state_clear();
    var_1 _meth_8626("enter_the_void", 3.0);
    var_1 notify("kill_dlc3_wave_mus_switcher");
    var_1 thread play_void_music();
    var_1._id_11CB.in_the_void = 1;
  }

  var_3 = _id_0380::_id_2888("ctf_void_enter");
  level._id_11CB.void_ambi = _id_0380::_id_6840("amb_zmb_dnk_the_void_ext", undefined, 3.0);
}

ctf_void_exit() {
  foreach(var_1 in level.players) {
    var_1 _meth_8627("enter_the_void", 3.0);
    var_1 _id_0366::_id_8E09();
    var_1 notify("kill_void_music_thread");
    var_1._id_11CB.in_the_void = undefined;
  }

  var_3 = _id_0380::_id_2888("ctf_void_exit");
  _id_0380::_id_6850(level._id_11CB.void_ambi, 3.0);
  _id_0380::_id_6850(level._id_11CB.void_geist_gun_lp, 1.0);
}

play_void_music() {
  self endon("kill_void_music_thread");
  var_0 = 4;
  var_1 = ["zmb_mus_creepy_amb_lp_01", "zmb_mus_creepy_amb_lp_02", "zmb_mus_creepy_amb_lp_03", "zmb_mus_creepy_amb_lp_04", "zmb_mus_creepy_amb_lp_05", "zmb_mus_creepy_amb_lp_06"];

  for(;;) {
    _id_0366::_id_8E31(var_1[randomint(var_1.size)], var_0);
    wait(_func_0A4(120, 180));
    _id_0366::_id_8E32(var_0);
  }
}

ctf_bucket_move(var_0, var_1) {
  thread ctf_bucket_start_stop(var_0, var_1);
  var_2 = _id_0380::_id_6844("ctf_bucket_move", undefined, var_0);
  wait(var_1 * 0.8);
  _id_0380::_id_684E(var_2, 0, var_1 * 0.2 + 0.15);
  wait 1;
  _id_0380::_id_6850(var_2);
}

ctf_bucket_start_stop(var_0, var_1) {
  var_2 = _id_0380::_id_6844("ctf_bucket_start_stop", undefined, var_0);
  wait(var_1 * 0.9);
  var_2 = _id_0380::_id_6844("ctf_bucket_start_stop", undefined, var_0);
}

ctf_fish_360(var_0, var_1) {
  var_1 = var_1 * 0.5;
  var_2 = _id_0380::_id_6842("ctf_fish_360", undefined, var_0);
  wait(var_1);
  var_2 = _id_0380::_id_6842("ctf_fish_360_2", undefined, var_0);
}

escape_boat_rise(var_0) {
  _id_0380::_id_288B("zmb_dnk_boat_rise_strt", undefined, self);
  var_1 = _id_0380::_id_6844("zmb_dnk_boat_rise_lp", undefined, self, 0.75);
  wait(var_0 - 2.75);
  _id_0380::_id_6850(var_1, 1);
  _id_0380::_id_288B("zmb_dnk_boat_rise_end", undefined, self);
}

_id_3D34() {
  var_0 = (1078, -560, -2196);
  _id_0380::_id_2889("void_flare_vfx", undefined, var_0);

  if(!isDefined(level._id_11CB.void_geist_gun_lp))
    level._id_11CB.void_geist_gun_lp = _id_0380::_id_6842("void_geist_gun_lp", undefined, (1016, -392, -2108));
}