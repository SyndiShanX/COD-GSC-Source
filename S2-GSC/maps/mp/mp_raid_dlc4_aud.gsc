/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc4_aud.gsc
*********************************************/

func_00F9() {
  lib_02F0::func_7FE7();
  level thread lib_04F3::func_533A();
  func_51D8();
  maps\mp\_audio_submixes::func_524C();
  func_5C22();
  thread func_5C18();
  func_7BD2();
  lib_02F0::func_8014("sndentity");
}

func_51D8() {}

func_5C22() {
  thread func_18F5("breach_01");
  thread func_18F5("breach_02");
  thread bell_emitter();
  thread bell_2_emitter();
  thread func_35E1();
  thread mp_radio_static_01();
  thread mp_radio_static_02();
  thread mp_radio_static_03();
  thread mp_radio_static_04();
  thread mp_radio_static_05();
  thread mp_radio_static_06();
  thread mp_metal_rattle_01();
  thread mp_metal_rattle_02();
  thread mp_steam_01();
  thread mp_steam_02();
  thread mp_steam_03();
  thread mp_steam_04();
  thread mp_phone_01();
  thread mp_phone_02();
  thread mp_phone_03();
  thread mp_phone_04();
  thread mp_phone_05();
  thread mp_phone_06();
  thread mp_phone_07();
  thread mp_phone_08();
  thread mp_phone_09();
  thread mp_phone_10();
  thread mp_phone_11();
  thread mp_phone_12();
  thread mp_phone_13();
  thread mp_phone_14();
  thread mp_phone_15();
  thread mp_phone_16();
}

func_5C18() {
  wait(0.5);
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("emt_dlc4_clock", undefined, (6695, -2600, 1039));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (6696, -2063, 1039));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (6693, -1744, 1039));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (8130, -3131, 1200));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (7805, -3395, 1178));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (8580, -1221, 1203));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (8600, -1215, 1203));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (11418, -3437, 1048));
  lib_0380::func_6842("emt_dlc4_clock", undefined, (11416, -3454, 1048));
  lib_0380::func_6842("emt_dlc4_clock_grandfather", undefined, (8264, -2991, 1028));
  lib_0380::func_6842("emt_dlc4_electricglobe", undefined, (8878, -821, 1211));
  lib_0380::func_6842("emt_dlc4_sparks", undefined, (8883, -782, 1286));
  lib_0380::func_6842("emt_dlc4_electric_drone", undefined, (9679, -3404, 1013));
  lib_0380::func_6842("emt_dlc4_electric_drone", undefined, (9748, -4523, 1013));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (5873, -2302, 1050));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (7954, -3323, 1047));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (7387, -2157, 1042));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (9071, -1797, 1094));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (8910, -1630, 1094));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (8572, -1535, 1177));
  lib_0380::func_6842("emt_dlc4_panel_hum", undefined, (8781, -1627, 1177));
}

mp_radio_static_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (4766, -3548, 1138));
    wait(randomintrange(5, 8));
  }
}

mp_radio_static_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (7434, -2480, 1042));
    wait(randomintrange(5, 8));
  }
}

mp_radio_static_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (8172, -3063, 1011));
    wait(randomintrange(5, 8));
  }
}

mp_radio_static_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (7916, -3350, 1145));
    wait(randomintrange(5, 8));
  }
}

mp_radio_static_05() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (8486, -1286, 1204));
    wait(randomintrange(5, 8));
  }
}

mp_radio_static_06() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_radio_static", undefined, (7824, -3393, 1146));
    wait(randomintrange(5, 8));
  }
}

mp_metal_stress_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_metal_stress", undefined, (4731, -2440, 1255));
    wait(randomintrange(7, 11));
  }
}

mp_metal_rattle_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_metal_rattle", undefined, (12801, -3738, 1188));
    wait(randomintrange(2, 3));
  }
}

mp_metal_rattle_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_metal_rattle", undefined, (11272, -6123, 1221));
    wait(randomintrange(2, 3));
  }
}

mp_steam_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_gas_release", undefined, (8946, -1403, 1075));
    wait(randomintrange(3, 5));
  }
}

mp_steam_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_gas_release", undefined, (8996, -1333, 1084));
    wait(randomintrange(3, 5));
  }
}

mp_steam_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_gas_release", undefined, (9106, -1378, 1097));
    wait(randomintrange(3, 5));
  }
}

mp_steam_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_gas_release", undefined, (8807, -1244, 1113));
    wait(randomintrange(3, 5));
  }
}

mp_phone_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (6699, -1945, 1018));
    wait(randomintrange(8, 13));
  }
}

mp_phone_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (6699, -2611, 1018));
    wait(randomintrange(8, 13));
  }
}

mp_phone_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (7437, -2476, 1025));
    wait(randomintrange(8, 13));
  }
}

mp_phone_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (8664, -1659, 1177));
    wait(randomintrange(8, 13));
  }
}

mp_phone_05() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (8725, -1544, 1177));
    wait(randomintrange(8, 13));
  }
}

mp_phone_06() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (9433, -1165, 1177));
    wait(randomintrange(8, 13));
  }
}

mp_phone_07() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (9550, -1541, 1086));
    wait(randomintrange(8, 13));
  }
}

mp_phone_08() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (9485, -2239, 1100));
    wait(randomintrange(8, 13));
  }
}

mp_phone_09() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (8902, -1773, 1092));
    wait(randomintrange(8, 13));
  }
}

mp_phone_10() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (9580, -1657, 1092));
    wait(randomintrange(8, 13));
  }
}

mp_phone_11() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (9877, -2696, 1027));
    wait(randomintrange(8, 13));
  }
}

mp_phone_12() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (8767, -2970, 1018));
    wait(randomintrange(8, 13));
  }
}

mp_phone_13() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (8848, -3574, 1018));
    wait(randomintrange(8, 13));
  }
}

mp_phone_14() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (10035, -2750, 1028));
    wait(randomintrange(8, 13));
  }
}

mp_phone_15() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (11413, -3505, 1028));
    wait(randomintrange(8, 13));
  }
}

mp_phone_16() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_dlc4_phone", undefined, (10255, -4509, 1028));
    wait(randomintrange(8, 13));
  }
}

func_7BD2() {
  lib_0378::func_8DC7("aud_intro_start_sfx", ::intro_start_sfx);
  lib_0378::func_8DC7("aud_intro_allies_mixing", ::intro_allies_mixing);
  lib_0378::func_8DC7("aud_intro_axis_mixing", ::intro_axis_mixing);
  lib_0378::func_8DC7("aud_allies_victory_sfx", ::allies_victory_sfx);
  lib_0378::func_8DC7("aud_axis_victory_sfx", ::axis_victory_sfx);
  lib_0378::func_8DC7("aud_tank_push_truck", ::tank_push_truck);
  lib_0378::func_8DC7("aud_tank_break_crate", ::tank_break_crate);
  lib_0378::func_8DC7("aud_tank_fires_at_bell", ::tank_fires_at_bell);
  lib_0378::func_8DC7("aud_bell_impact", ::tank_bell_impact);
}

intro_start_sfx() {
  var_00 = 27;
  foreach(var_02 in level.var_744A) {
    var_02 thread maps\mp\_audio_submixes::func_8A9D("mp_war_intro_master", 0.1, 1);
    var_02 thread intro_mix_clear(var_00);
  }

  thread play_allies_intro_sfx();
  thread play_axis_intro_sfx();
}

play_allies_intro_sfx() {
  lib_0380::func_2888("mp_dlc4_allies_intro_tank_arrive", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_tank_depart", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_tank_shot", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_tank_impact", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_tank_impact_low", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_fs_00", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_fly_00", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_fs_01", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_fly_01", undefined);
  lib_0380::func_2888("mp_dlc4_allies_intro_bdy_fall", undefined);
}

play_axis_intro_sfx() {
  lib_0380::func_2888("mp_dlc4_axis_intro_cart_push", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_chest_open", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_bomb_shake", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_alarm", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_flybys", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_fs_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_fly_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_grp_fs_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_grp_fly_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_fs_02", undefined);
  lib_0380::func_2888("mp_dlc4_axis_intro_fly_02", undefined);
}

intro_mix_clear(param_00) {
  wait(param_00);
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", 5);
}

intro_spectator_mixing() {
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_vignette", 1);
  maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_vignette", 1);
}

intro_allies_mixing() {
  var_00 = self;
  var_01 = 1;
  var_02 = 6;
  var_03 = 0.707945;
  var_04 = 1 - var_03;
  var_05 = 30;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["allies"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_master", var_04, var_01);
    wait(var_01);
    var_08 = gettime();
    var_09 = var_08 - var_07;
    var_0A = var_09 * 0.001;
    if(var_0A < var_02) {
      var_02 = var_02 - var_0A;
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", var_02);
    var_0B = var_05 - var_02 - var_01;
    if(var_0B > 0.05) {
      wait(var_0B);
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_vignette", var_06);
  }
}

intro_axis_mixing() {
  var_00 = self;
  var_01 = 1;
  var_02 = 6;
  var_03 = 0.707945;
  var_04 = 1 - var_03;
  var_05 = 30;
  var_06 = 1;
  if(isDefined(level.var_54D0["axis"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["axis"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_master", var_04, var_01);
    wait(var_01);
    var_08 = gettime();
    var_09 = var_08 - var_07;
    var_0A = var_09 * 0.001;
    if(var_0A < var_02) {
      var_02 = var_02 - var_0A;
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", var_02);
    var_0B = var_05 - var_02 - var_01;
    if(var_0B > 0.05) {
      wait(var_0B);
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_vignette", var_06);
  }
}

allies_victory_sfx() {
  thread outro_vignette_submix();
  lib_0380::func_2888("mp_dlc4_allies_victory_tank_arrive", undefined);
  lib_0380::func_2888("mp_dlc4_allies_victory_tank_shot", undefined);
  lib_0380::func_2888("mp_dlc4_allies_victory_tank_impact", undefined);
  lib_0380::func_2888("mp_dlc4_allies_outro_fs_01", undefined);
  lib_0380::func_2888("mp_dlc4_allies_outro_fly_01", undefined);
}

axis_victory_sfx() {
  thread outro_vignette_submix();
  lib_0380::func_2888("mp_dlc4_axis_outro_fs_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_outro_fly_01", undefined);
  lib_0380::func_2888("mp_dlc4_axis_outro_bdy_drag", undefined);
  level notify("aud_stop_bell_2_loop");
}

outro_vignette_submix() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_vignette");
  }
}

func_18F5(param_00) {
  var_01 = common_scripts\utility::func_46B5(param_00, "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  level endon("breach_done");
  for(;;) {
    var_01 waittill("bomb_planted");
    lib_04F3::raidmusiconteam("attackers", "objective_bomb_planted", "objective_bomb_defused");
    var_01 waittill("bomb_defused");
    lib_04F3::raidmusiconteam("defenders", "objective_bomb_planted", "objective_bomb_defused");
  }
}

bell_emitter() {
  var_00 = lib_0380::func_6842("bell_emitter_lp", undefined, (12807, -3749, 1232));
  level waittill("aud_stop_bell_loop");
  lib_0380::func_6850(var_00, 0);
}

bell_2_emitter() {
  var_00 = lib_0380::func_6842("bell_emitter_lp", undefined, (11273, -6149, 1245));
  level waittill("aud_stop_bell_2_loop");
  lib_0380::func_6850(var_00, 4);
}

tank_push_truck(param_00) {
  lib_0380::func_2889("tank_hit_truck_main", undefined, param_00.var_116);
}

tank_break_crate() {
  lib_0380::func_2889("tank_break_crate", undefined, self.var_116);
}

tank_fires_at_bell(param_00) {}

tank_bell_impact(param_00) {
  lib_0380::func_2889("tank_shoot_bell_impact", undefined, param_00.var_116);
  level notify("aud_stop_bell_loop");
}