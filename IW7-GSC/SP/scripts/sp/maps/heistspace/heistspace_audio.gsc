/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_audio.gsc
***********************************************************/

main() {
  _id_0F00::_id_25D8();
  thread _id_25AC();
  thread _id_1D74();
  thread _id_DC6D();
  thread _id_B328();
}

_id_25AC() {
  scripts\engine\utility::flag_init("mons_under_attack_sounds");
  scripts\engine\utility::flag_init("map_room_ambience_shift");
  level._id_1D66 = ["random_amb_normal", "random_amb_semi_deep", "random_amb_deep"];

  foreach(var_1 in level._id_1D66)
  scripts\engine\utility::flag_init(var_1);

  wait 4;
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.7);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.0);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.3);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.0);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.7);
  soundsettimescalefactor("scn_fx_unres_2d", 0.0);
  soundsettimescalefactor("scn_fx_res_3d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
}

_id_25EC(var_0) {
  switch (var_0) {
    case "jumpto_mons_130":
      break;
    case "jumpto_mons_guns_down":
      break;
    case "jumpto_mons_halls":
      break;
    case "jumpto_mons_nav":
      break;
    case "jumpto_mons_ordnance":
      break;
    case "jumpto_zero_g_combat":
      break;
    case "jumpto_retribution_arrives":
      thread _id_52F1();
      break;
    case "jumpto_defend_mons":
      thread _id_52F1();
      break;
    case "jumpto_salter_jackal_crash":
      thread _id_52F1();
      break;
    case "jumpto_jackal_crash":
      break;
    default:
      break;
  }
}

_id_3B3A() {
  scripts\engine\utility::flag_set("mons_under_attack_sounds");
}

_id_3B3B() {}

_id_3B3C() {
  thread _id_E7D8("mons_map_rm_expl_alarm", (-66207, 13363, 2249), 3.5);
  thread _id_13E78();
  thread _id_13E77();
}

_id_3B3D() {}

_id_3B3E() {}

_id_3B42() {}

_id_3B40() {}

_id_3B30() {}

_id_DC6D() {
  level endon("ordnance_player_anim_started");
  var_0 = level._id_1D66;

  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_in_array_return(var_0);

    switch (var_1) {
      case "random_amb_normal":
        _id_FBEE();
        break;
      case "random_amb_semi_deep":
        break;
      case "random_amb_deep":
        _id_FBED();
        break;
      default:
        break;
    }

    wait 0.05;
    var_0 = scripts\sp\utility::_id_2290(level._id_1D66, [var_1]);

    foreach(var_3 in var_0)
    scripts\engine\utility::flag_clear(var_3);
  }
}

_id_FBEE() {
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
  wait 0.7;
  thread _id_8D28("amb_heist_battle_distant", 3000, 3001, 300, 0, 45, 4, 0, 0, 0, 0.3, 7, "linear_up");
  thread _id_8D28("amb_mons_impact", 3000, 3001, 300, 5, 45, 2, 1, 1, 3, 2, 6, "linear_up");
  thread _id_8D28("amb_heist_battle_tracer_short", 3000, 3001, 300, 45, 90, 1, 0, 0, 0, 1, 5, "linear_down");
  thread _id_8D28("amb_heist_battle_jack_flyby", 3000, 3001, 300, 20, 70, 2, 0, 0, 0, 0.2, 7, "inverted_bell");
  thread _id_8D28("amb_mons_impact_pound", 3000, 3001, 300, 20, 70, 2, 0, 0, 0, 0.1, 4, "inverted_bell");
}

_id_6A1D() {
  level.player notify("started_dynamic_ambience");
  setglobalsoundcontext("atmosphere", "space", 1);
  thread _id_8D28("sa_ext_expl_close", 3000, 3001, 300, 0, 0, 0, 0, 1, 3, 4, 11, "linear_up");
  thread _id_8D28("sa_ext_expl_med", 3000, 3001, 300, 0, 0, 0, 0, 0, 0, 0.2, 7, "inverted_bell");
}

_id_FBED() {
  level.player notify("started_dynamic_ambience");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_9A71();
  thread _id_8D28("amb_heist_impact_below", 3000, 3001, 300, 0, 45, 4, 0, 1, 3, 2, 5, "linear_up");
  thread _id_8D28("moon_int_explosion_sm", 3000, 3001, 300, 45, 90, 1, 0, 0, 0, 1, 5, "linear_down");
  thread _id_8D28("moon_int_explosion_lg", 3000, 3001, 300, 5, 45, 2, 0, 1, 3, 2, 6, "linear_up");
  thread _id_8D28("impact_below_shake", 3000, 3001, 300, 5, 45, 2, 1, 1, 0, 1, 15, "linear_up");
}

_id_1D74() {
  scripts\engine\utility::flag_wait_any("om130_fired_first_time", "player_never_shot_fspar");
  thread _id_E7D8("alarm_heist_mons_6", (-68766, 14437.4, 3984), 2.9);
  thread _id_E7D8("alarm_heist_mons_lp5", (-66000.2, 13470.1, 2374.19), 1.1);
  thread _id_E7D8("alarm_heist_mons_lp5", (-69572, 13196, 2538), 1);
  thread _id_E7D8("alarm_dirty_1", (-69959, 14263, 2591), 0.8);
  thread _id_E7D8("alarm_dirty_1", (-69856, 14675, 2655), 1);
  thread _id_E7D8("alarm_dirty_bell", (-66022, 11988, 2420), 2);
  thread _id_E7D8("alarm_heist_mons_lp1", (-69353.9, 14718.6, 3999.04), 1.5);
}

_id_E7D8(var_0, var_1, var_2) {
  while(!scripts\engine\utility::flag("ordnance_door_opened")) {
    scripts\engine\utility::play_sound_in_space(var_0, var_1);
    wait(var_2);
  }
}

_id_B328() {
  scripts\engine\utility::flag_wait("player_in_elevator");
  var_0 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_vent_1", (-66121, 12547, 2274));
  var_1 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_vent_2", (-66600, 13361, 2274));
  var_2 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_vent_3", (-67265, 13989, 2311));
  var_3 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_1", (-66351, 12410, 1961));
  var_4 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_2", (-66541, 12603, 1961));
  var_5 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_3", (-66283, 12932, 1961));
  var_6 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_1", (-66095, 13122, 1961));
  var_7 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_2", (-67064, 13638, 1981));
  var_8 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_comp_3", (-66862, 13840, 1981));
  var_9 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_drone_1", (-67446, 13627, 2120));
  var_10 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_drone_2", (-66639, 13341, 2023));
  var_11 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_drone_3", (-67444, 13904, 2114));
  scripts\engine\utility::flag_wait("map_room_ambience_shift");
  var_12 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_beep_1", (-66308, 13140, 1982));
  var_13 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_beep_2", (-66336, 12623, 1974));
  var_14 = scripts\engine\utility::play_loopsound_in_space("mons_map_rm_beep_3", (-66858, 13642, 1969));
  var_0 _meth_8277(0.6, 11);
  var_1 _meth_8277(0.5, 15);
  var_2 _meth_8277(0.5, 20);
  var_3 _meth_8277(0.8, 12);
  var_4 _meth_8277(0.7, 14.5);
  var_5 _meth_8277(0.6, 7);
  var_6 _meth_8277(0.9, 8.5);
  var_7 _meth_8277(0.5, 15);
  var_8 _meth_8277(0.6, 10);
  var_9 _meth_8277(0.7, 16);
  var_10 _meth_8277(0.6, 13);
  var_11 _meth_8277(0.8, 17);
  scripts\engine\utility::flag_wait("zero_g_combat_end");
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_11 delete();
  var_12 delete();
  var_13 delete();
  var_14 delete();
}

_id_BA44() {}

_id_9158() {
  wait 11.0;
  level._id_C413 playSound("bink_start_sound");
}

_id_BAF8() {
  level._id_C413 scripts\engine\utility::waittill_any("missile_damage", "damage");
  scripts\engine\utility::flag_set("mons_under_attack_sounds");
}

_id_BA78() {
  level.player scripts\sp\utility::play_sound_on_entity("elevator_button_push");
}

_id_BA79() {
  level.player scripts\sp\utility::play_sound_on_entity("mons_elevator_oneshot_event");
}

_id_BA4D() {
  thread _id_BA96();
  scripts\engine\utility::flag_set("map_room_ambience_shift");
  wait 4;
  thread _id_E7D8("mons_map_rm_expl_alarm", (-67405, 13482, 2744), 3.5);
  thread _id_13E78();
  thread _id_13E77();
}

_id_BA96() {
  scripts\engine\utility::play_sound_in_space("mons_impact_lr", (-68746, 13379, 3290));
}

_id_BACB() {
  level.player playSound("ventout_start");
  wait 11.44;
  level.player playSound("ventout_front");
  wait 3.7;
  level.player playSound("ventout_front2");
}

_id_13E78() {
  level.player endon("death");
  level endon("player_entering_jackal");
  var_0 = [];
  var_1 = [];
  var_2 = "inverted_bell";
  var_1 = level._id_2571._id_DC72[var_2];
  var_0 = _id_0F00::_id_4971(0.3, 5, var_2);

  for(;;) {
    var_3 = randomintrange(0, 3);

    switch (var_3) {
      case 0:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_mvmt", (-63914, 14610, 2068));
        break;
      case 1:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_mvmt", (-64279, 14661, 1977));
        break;
      case 2:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_mvmt", (-64739, 14655, 2060));
        break;
      default:
        break;
    }

    var_4 = _id_0F00::_id_7D78(var_1, var_0);
    wait(var_4);
  }
}

_id_13E77() {
  level.player endon("death");
  level endon("player_entering_jackal");
  var_0 = [];
  var_1 = [];
  var_2 = "inverted_bell";
  var_1 = level._id_2571._id_DC72[var_2];
  var_0 = _id_0F00::_id_4971(0.4, 10, var_2);

  for(;;) {
    var_3 = randomintrange(0, 3);

    switch (var_3) {
      case 0:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_bump", (-63914, 14610, 2068));
        break;
      case 1:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_bump", (-64279, 14661, 1977));
        break;
      case 2:
        scripts\engine\utility::play_sound_in_space("zero_g_metal_bump", (-64739, 14655, 2060));
        break;
      default:
        break;
    }

    var_4 = _id_0F00::_id_7D78(var_1, var_0);
    wait(var_4);
  }
}

_id_52F1() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp1", (-50294, 36380, 8866));
  var_1 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp2", (-42752, 34862, 8748));
  var_2 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp1", (-77543, 37532, 3218));
  var_3 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp2", (-85450, 34319, 3824));
  var_4 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp1", (-91259, -12764, 12135));
  var_5 = scripts\engine\utility::play_loopsound_in_space("amb_wounded_fire_lp2", (-83458, -13699, 11758));
  var_6 = scripts\engine\utility::play_loopsound_in_space("heistspace_zerg_battle_lp", (-63725, 30923, 3054));
  scripts\engine\utility::flag_wait("jackal_crash_begin");
  var_0 stoploopsound();
  var_1 stoploopsound();
  var_2 stoploopsound();
  var_3 stoploopsound();
  var_4 stoploopsound();
  var_5 stoploopsound();
  scripts\engine\utility::waitframe();
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  scripts\engine\utility::flag_wait("player_entering_jackal");
  var_6 delete();
}

_id_13E6D() {
  thread _id_8D28("sa_ext_expl_close", 2, 9, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_8D28("sa_ext_expl_med", 2, 6, 3, 7, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_8D28("sa_ext_expl_close", 2, 9, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
}

_id_E3AB() {
  wait 1.1;
  level.player playSound("ftl_ret");
}

_id_8D28(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level.player endon("started_dynamic_ambience");
  level.player endon("death");
  level endon("ordnance_player_anim_started");
  var_13 = [];
  var_14 = [];

  if(isDefined(var_12)) {
    var_14 = level._id_2571._id_DC72[var_12];
    var_13 = _id_0F00::_id_4971(var_10, var_11, var_12);
  }

  for(;;) {
    if(scripts\engine\utility::flag("mons_under_attack_sounds"))
      thread _id_8D27(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    var_15 = _id_0F00::_id_7D78(var_14, var_13);
    wait(var_15);
  }
}

_id_8D27(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = randomintrange(0, var_3) * randomintrange(0, 2) * 2 - 1;
  var_11 = randomintrange(var_1, var_2);
  var_12 = randomintrange(-180, 180);

  if(var_4 != var_5)
    var_13 = randomintrange(var_4, var_5);
  else
    var_13 = var_4;

  var_13 = var_13 * (randomintrange(0, 2) * 2 - 1);
  level.player thread _id_0F00::_id_FBC5(var_0, var_12, var_11, var_13, var_10, var_6);

  if(var_7 == 1) {
    wait(var_9);
    thread _id_8D29(var_8, var_6);
    thread scripts\sp\maps\heistspace\heistspace_util::_id_9A71(var_6);
  }
}

_id_8D29(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(var_1 < 1)
      var_1 = 1;

    screenshake(level.player.origin, var_0, var_0, var_0 * 0.25, var_1, 0, var_1 * 0.5, 128, 8, 6, 3);
  }
}

_id_C7B8() {
  level.player clearsoundsubmix();
  level.player playSound("scn_heistspace_outro");
  wait 21.5;
  level.player setsoundsubmix("boom_outro");
}