/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_aachen.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_raid_aachen_precache::func_F9();
  maps\createart\mp_raid_aachen_art::func_F9();
  maps\mp\mp_raid_aachen_fx::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_aachen_lighting::func_F9();
  maps\mp\mp_raid_aachen_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_aachen");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_raid_aachen_osp";
  level.var_6C5E = "mp_raid_aachen_osp";
  level.var_3445 = "mp_raid_aachen_drone";
  level.var_343A = "mp_raid_aachen_drone";
  level.var_A853 = "mp_raid_aachen_warbird";
  level.var_A852 = "mp_raid_aachen_warbird";
  level.var_75EE = 8;
  level.overridemaxagents = getdvarint("scr_default_maxagents");
  level.botsdestructionobjectivedefenseradius = 1400;
  level.var_A16 = 0;
  lib_0503::initscriptedtanktargeting();
  level.tanktargethitfunc = ::func_97DE;
  lib_04FA::func_52FD(3);
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  level.var_696E = ["tram_fill", "hostage_a", "hostage_b", "objective_radio", "tank_escort", "end"];
  level.var_696F = ["tram_fill", "objective_radio", "tank_escort", "end"];
  thread maps\mp\mp_raid_aachen_vo::func_5366();
  thread func_7FC0();
  thread maps\mp\mp_raid_aachen_vo::func_7FDF();
  thread func_7FCF();
  thread func_7F7D();
  thread func_7F89();
  thread func_7FCD();
  thread func_7FB5();
  thread func_7FDB();
}

introvignette_avatarfuncforteam(param_00, param_01, param_02) {
  self endon("death");
  for(;;) {
    self waittill(param_02, var_03);
    if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0[param_00])) {
      continue;
    }

    thread maps\mp\mp_raid_aachen_aud::footstepnotetrack(var_03);
  }
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_aachen_allies_start_player01", "mp_raids_aachen_allies_start_player02", "mp_raids_aachen_allies_start_player03", "mp_raids_aachen_allies_start_player04", "mp_raids_aachen_allies_start_player05", "mp_raids_aachen_allies_start_player06"];
  var_01 = ["mp_raids_aachen_allies_start_cam01", "mp_raids_aachen_allies_start_cam02", "mp_raids_aachen_allies_start_cam03", "mp_raids_aachen_allies_start_cam04", "mp_raids_aachen_allies_start_cam05", "mp_raids_aachen_allies_start_cam06", "mp_raids_aachen_allies_start_cam07", "mp_raids_aachen_allies_start_cam08"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA, ::func_0BFB, ::func_0BFC, ::func_0BFD, ::func_0BFE, ::alliesintrocam08func];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_allies_start", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].var_13B7 = ::func_54D2;
  level.var_54D0["allies"].var_6F27 = 1;
}

func_54D7() {
  var_00 = "vignette_notify";
  lib_0505::func_9AE("mp40_mp", 1);
  var_01 = level.var_54D0["allies"].var_116;
  var_02 = level.var_54D0["allies"].var_1D;
  var_03 = spawn("script_model", var_01);
  var_03 setModel("vehicle_usa_tank_sherman_75mm_no_turret_dozer");
  var_03.var_56E8 = 1;
  lib_0502::func_9FF(var_03);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), var_03, "tag_wheel_back_left");
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), var_03, "tag_wheel_back_right");
  var_03 method_8495("mp_raids_aachen_allies_start_sherman", var_01, var_02);
  var_03 thread vfx_tank_tread_notetracks(var_00);
  var_03 thread lib_0502::func_8C21(game["attackers"]);
  maps\mp\_utility::func_2CED(1.92, ::func_08B5, "105");
  thread introvignette_allies_sound(var_03);
  var_04 = spawn("script_model", var_01);
  var_04 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_04 method_8449(var_03, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_04 thread lib_0502::func_8C21(game["attackers"]);
  var_05 = spawn("script_model", var_01);
  var_05 setModel("mp_ger_war_train_cars");
  var_05 method_8495("mp_raids_aachen_allies_start_trainsingle_01", var_01, var_02);
  var_06 = spawn("script_model", var_01);
  var_06 setModel("mp_raid_aachen_ally_intro_wall");
  var_06 method_8495("mp_raids_aachen_allies_start_wall", var_01, var_02);
  var_07 = spawn("script_model", var_01);
  var_07 setModel("mp_raid_aachen_wall_murals");
  var_07 method_8495("mp_raids_aachen_allies_start_posters", var_01, var_02);
  var_08 = spawn("script_model", var_01);
  var_08 setModel("genericprop_x5");
  var_08 method_8495("mp_raids_aachen_allies_start_props", var_01, var_02);
  var_09 = ["ach_wood_beam_dmg_05_dust", "cob_pg_concrete_rubble_chunk_09_dust"];
  var_0A = ["j_prop_1", "j_prop_2"];
  var_0B = [];
  for(var_0C = 0; var_0C < var_09.size; var_0C++) {
    var_0D = spawn("script_model", var_01);
    var_0D setModel(var_09[var_0C]);
    var_0D method_8449(var_08, var_0A[var_0C], (0, 0, 0), (0, 0, 0));
    var_0B[var_0B.size] = var_0D;
  }

  var_0E = ["mp_raids_aachen_allies_start_fighter_01", "mp_raids_aachen_allies_start_fighter_02"];
  var_0F = [];
  var_10 = 0;
  foreach(var_12 in var_0E) {
    var_13 = spawn("script_model", var_01);
    if(var_10 % 2 == 0) {
      var_13 setModel("mp_raid_aachen_hostage_f_01");
    } else {
      var_13 setModel("mp_raid_aachen_hostage_m_01");
    }

    var_10++;
    var_13 method_8495(var_12, var_01, var_02);
    var_0F[var_0F.size] = var_13;
  }

  var_15 = spawn("weapon_mp40_mp", (0, 0, 0), 1);
  var_15 linkto(var_0F[0], "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_15 thread lib_0502::func_2FA6();
  level.var_BFF = spawnStruct();
  level.var_BFF.var_9600 = var_03;
  level.var_BFF.var_97F3 = var_04;
  level.var_BFF.train = var_05;
  level.var_BFF.wall = var_06;
  level.var_BFF.poster = var_07;
  level.var_BFF.var_778D = var_08;
  level.var_BFF.var_778F = var_0B;
  level.var_BFF.captives = var_0F;
  level.var_BFF.captiveweapon = var_15;
  func_08B5(25);
}

func_54D2(param_00, param_01) {
  thread introvignette_avatarfuncforteam("allies", param_00, param_01);
}

vfx_tank_tread_notetracks(param_00) {
  wait(5);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_intro_dust_front"), self, "TAG_GUY1");
  self waittillmatch("tankstop", param_00);
  stopFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_left");
  stopFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_right");
  stopFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_intro_dust_front"), self, "TAG_GUY1");
  self waittillmatch("tankgo", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_left");
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_right");
}

introvignette_allies_sound(param_00) {
  wait(7.9);
  lib_04F3::func_79CB("allies_intro_distant_train", (-10150, -8829, 1103));
  wait(2);
  lib_04F3::func_79CB("allies_intro_amb_plane_by", (-5394, -5676, 1412));
}

func_54D3() {
  level notify("allies_intro_cleanup");
  var_00 = level.var_BFF.var_9600;
  var_01 = level.var_BFF.var_97F3;
  var_02 = level.var_BFF.train;
  var_03 = level.var_BFF.wall;
  var_04 = level.var_BFF.poster;
  var_05 = level.var_BFF.var_778D;
  var_06 = level.var_BFF.var_778F;
  var_07 = level.var_BFF.captives;
  var_08 = level.var_BFF.captiveweapon;
  level.var_BFF = undefined;
  lib_0505::func_7CDC("mp40_mp");
  lib_0502::func_7D03(var_00, 0.5);
  var_01 delete();
  var_00 delete();
  var_02 delete();
  var_03 delete();
  var_04 delete();
  var_08 delete();
  common_scripts\utility::func_F71(var_06, ::delete);
  common_scripts\utility::func_F71(var_07, ::delete);
  var_05 delete();
}

func_0BF8(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 190, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(1);
}

func_0BF9(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 160, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(2);
}

func_0BFA(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2.5, 180, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(3);
}

func_0BFB(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 1000, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(4);
  wait(1);
  lib_04F3::func_79CB("allies_intro_walla_ally_1", (-5312, -6888, 555));
}

func_0BFC(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2.5, 46, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(5);
  lib_04F3::func_79CB("allies_intro_close_footsteps", (-5126, -6732, 476));
  lib_04F3::func_79CB("allies_intro_walla_ally_f_1", (-4948, -6589, 555));
  wait(0.6);
  lib_04F3::func_79CB("allies_intro_walla_ally_2", (-4992, -7027, 555));
}

func_0BFD(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6, 35, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(6);
}

func_0BFE(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 4, 133, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(7);
}

alliesintrocam08func(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.9, 209, 10, 10, 0);
  var_01 = lib_0505::func_3187(var_01, 0.5, 2350, 10, 10, 2);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignettealliesplayercameramix(8);
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_aachen_axis_start_player01", "mp_raids_aachen_axis_start_player02", "mp_raids_aachen_axis_start_player03", "mp_raids_aachen_axis_start_player04", "mp_raids_aachen_axis_start_player05", "mp_raids_aachen_axis_start_player06"];
  var_01 = ["mp_raids_aachen_axis_start_cam01", "mp_raids_aachen_axis_start_cam02", "mp_raids_aachen_axis_start_cam03", "mp_raids_aachen_axis_start_cam04", "mp_raids_aachen_axis_start_cam05", "mp_raids_aachen_axis_start_cam06"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482, ::func_1483, ::axisintrocam06func];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_start", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_13B7 = ::func_54D8;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
  level.var_54D0["axis"].basecostume = [2, 1, 2, 2, 2, 0];
  level.var_54D0["axis"].forceavatars = [1, 0, 0, 1, 0, 0];
}

func_54E1() {
  var_00 = "vignette_notify";
  var_01 = level.var_54D0["axis"].var_116;
  var_02 = level.var_54D0["axis"].var_1D;
  var_03 = [];
  var_04 = ["mp_raids_aachen_axis_start_pow01", "mp_raids_aachen_axis_start_pow02", "mp_raids_aachen_axis_start_pow03", "mp_raids_aachen_axis_start_pow04", "mp_raids_aachen_axis_start_pow05", "mp_raids_aachen_axis_start_pow06"];
  var_05 = 0;
  foreach(var_07 in var_04) {
    var_08 = spawn("script_model", var_01);
    if(var_05 % 2 == 0) {
      var_08 setModel("mp_raid_aachen_hostage_m_01");
    } else {
      var_08 setModel("mp_raid_aachen_hostage_f_01");
    }

    if(var_07 == "mp_raids_aachen_axis_start_pow01") {
      var_08 thread vfx_axis_intro_notetrack(var_00);
    }

    var_08 method_8495(var_07, var_01, var_02, var_00);
    var_03[var_03.size] = var_08;
  }

  var_0A = spawn("script_model", var_01);
  var_0A setModel("mp_raid_aachen_security_door");
  var_0A method_8495("mp_raids_aachen_axis_start_door01", var_01, var_02, var_00);
  var_0B = spawn("script_model", var_01);
  var_0B setModel("mp_raid_aachen_security_door");
  var_0B method_8495("mp_raids_aachen_axis_start_door02", var_01, var_02, var_00);
  var_0C = spawn("script_model", var_01);
  var_0C setModel("npc_gen_tarp_rope");
  var_0C method_8495("mp_raids_aachen_axis_start_rope", var_01, var_02, var_00);
  var_0D = [];
  var_0D[0] = var_0A;
  var_0D[1] = var_0B;
  var_0D[2] = var_0C;
  var_0E = spawn("script_model", var_01);
  var_0E setModel("genericprop_x5");
  var_0E method_8495("mp_raids_aachen_axis_start_props", var_01, var_02);
  var_0F = ["tag_origin", "tag_origin", "hur_furniture_chair_02", "hur_furniture_chair_02", "hur_furniture_chair_02"];
  var_10 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4", "j_prop_5"];
  var_11 = [];
  for(var_12 = 0; var_12 < var_0F.size; var_12++) {
    var_13 = spawn("script_model", var_01);
    var_13 setModel(var_0F[var_12]);
    var_13 linkto(var_0E, var_10[var_12], (0, 0, 0), (0, 0, 0));
    var_11[var_11.size] = var_13;
  }

  introvignette_showdoors(0);
  level notify("axis_vingnette_start");
  level.var_1484 = spawnStruct();
  level.var_1484.captives = var_03;
  level.var_1484.var_778D = var_0E;
  level.var_1484.var_778F = var_11;
  level.var_1484.animateddoors = var_0D;
  func_08B5(25);
}

func_54D8(param_00, param_01) {
  thread introvignette_avatarfuncforteam("axis", param_00, param_01);
}

func_54D9() {
  var_00 = level.var_1484.captives;
  var_01 = level.var_1484.var_778D;
  var_02 = level.var_1484.var_778F;
  var_03 = level.var_1484.animateddoors;
  level.var_1484 = undefined;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  var_01 delete();
  introvignette_showdoors(1);
  level notify("axis_vingnette_end");
}

introvignette_showdoors(param_00) {
  var_01 = [];
  var_02 = getEntArray("visuals", "script_noteworthy");
  foreach(var_04 in var_02) {
    if(var_04.var_3A == "script_model" && issubstr(var_04.var_106, "door")) {
      var_01[var_01.size] = var_04;
    }
  }

  if(param_00) {
    common_scripts\utility::func_FB2(var_01, ::lib_0502::func_79C6);
    return;
  }

  common_scripts\utility::func_FB2(var_01, ::lib_0502::func_7997);
}

vfx_axis_intro_notetrack(param_00) {
  self waittillmatch("hit", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_axis_intro_blood_impact"), self, "j_head");
}

func_147F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 7, 20, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignetteaxisplayercameramix(1);
}

func_1480(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6, 100, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignetteaxisplayercameramix(2);
}

func_1481(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 115, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignetteaxisplayercameramix(3);
}

func_1482(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 185, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignetteaxisplayercameramix(4);
}

func_1483(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.1, 260, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::introvignetteaxisplayercameramix(5);
}

axisintrocam06func(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 890, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

midpointvingnette_bombingrun() {
  var_00 = "vignette_notify";
  var_01 = common_scripts\utility::func_46B5("anim_loc_bomb_drop", "targetname");
  wait(5);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("ger_bomber_stuka");
  var_02 method_8495("mp_raids_aachen_obj03_bomber_start", var_01.var_116, var_01.var_1D, var_00);
  foreach(var_04 in level.var_744A) {
    var_04 lib_04F3::func_79F6(var_02);
  }

  maps\mp\_utility::func_2CED(5.333, ::lib_04F3::func_79CC, "stuka_flyby", var_02);
  maps\mp\_utility::func_2CED(6.5, ::func_08B5, "220");
  var_02 waittillmatch("end", var_00);
  foreach(var_04 in level.var_744A) {
    var_04 lib_04F3::func_79F7(var_02, 0.5);
  }

  var_02 delete();
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_aachen_allieswin_cam01", "mp_raids_aachen_allieswin_cam02", "mp_raids_aachen_allieswin_cam03", "mp_raids_aachen_allieswin_cam04", "mp_raids_aachen_allieswin_camhold"];
  var_01 = [::func_0C08, ::func_0C09, ::func_0C0A, ::func_0C0B, undefined];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_allies_win", "targetname");
  level.var_6C86["allies"].var_8097 = 7;
  level.var_6C86["allies"].var_1F03 = var_00;
  level.var_6C86["allies"].var_1F05 = var_01;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
}

func_6C8D() {
  deactivateraidexploder(25, 1);
  var_00 = "vignette_notify";
  var_01 = level.var_6C86["allies"].var_116;
  var_02 = level.var_6C86["allies"].var_1D;
  var_03 = spawn("script_model", var_01);
  var_03 setModel("vehicle_usa_tank_sherman_75mm_no_turret_dozer");
  var_03.var_56E8 = 1;
  lib_0502::func_9FF(var_03);
  var_03 method_8495("mp_raids_aachen_allieswin_tank01", var_01, var_02, var_00);
  var_04 = spawn("script_model", var_01);
  var_04 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_04 method_8449(var_03, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_05 = spawn("script_model", var_01);
  var_05 setModel("mp_ger_war_train_cars");
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_outro_trainsmoke"), var_05, "engine_TAG_BODY");
  var_05 method_8495("mp_raids_aachen_allieswin_trainsingle_01", var_01, var_02);
  var_03 thread vfx_allies_outro_notetrack(var_00, var_05);
  var_06 = spawn("script_model", var_01);
  var_06 setModel("genericprop_x5");
  var_06 method_8495("mp_raids_aachen_allieswin_props", var_01, var_02);
  var_07 = ["mp_raid_aachen__plattformwagen_base_01_static_des_dust", "cob_roof_dmg_section_rafters_03"];
  var_08 = ["j_prop_1", "j_prop_2"];
  var_09 = [];
  for(var_0A = 0; var_0A < var_07.size; var_0A++) {
    var_0B = spawn("script_model", var_01);
    var_0B setModel(var_07[var_0A]);
    var_0B linkto(var_06, var_08[var_0A], (0, 0, 0), (0, 0, 0));
    var_09[var_09.size] = var_0B;
  }

  var_0C = [];
  var_0D = [];
  for(var_0A = 0; var_0A < 6; var_0A++) {
    var_0C[var_0A] = [2, 1, 2, 2, 2, 0];
    var_0D[var_0A] = [2, 1, 2, 2, 2, 0];
  }

  var_0E = ["mp_raids_aachen_allieswin_player01", "mp_raids_aachen_allieswin_player02", "mp_raids_aachen_allieswin_player03"];
  var_0F = [];
  for(var_0A = 0; var_0A < 3; var_0A++) {
    var_10 = spawn("script_model", var_01);
    var_10 setcostumemodels(var_0D[var_0A], "allies");
    var_10 method_8495(var_0E[var_0A], var_01, var_02);
    var_0F[var_0A] = var_10;
  }

  outrovignette_hidetrain();
  level.alliesoutroobjects = spawnStruct();
  level.alliesoutroobjects.var_9600 = var_03;
  level.alliesoutroobjects.var_97F3 = var_04;
  level.alliesoutroobjects.train = var_05;
  level.alliesoutroobjects.var_778D = var_06;
  level.alliesoutroobjects.var_778F = var_09;
  level.alliesoutroobjects.var_BEB = var_0F;
}

vfx_allies_outro_notetrack(param_00, param_01) {
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_left");
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_tank_tread_dirt"), self, "tag_wheel_back_right");
  self waittillmatch("ledge", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_outro_tankdust"), self, "TAG_GUY1");
  self waittillmatch("hit", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_outro_sparks"), self, "TAG_GUY0");
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_allies_outro_tanksteam"), param_01, "engine_TAG_GUY1");
}

func_6C8B() {
  var_00 = level.alliesoutroobjects.var_9600;
  var_01 = level.alliesoutroobjects.var_97F3;
  var_02 = level.alliesoutroobjects.train;
  var_03 = level.alliesoutroobjects.var_778D;
  var_04 = level.alliesoutroobjects.var_778F;
  var_05 = level.alliesoutroobjects.var_BEB;
  level.alliesoutroobjects = undefined;
  lib_0502::func_7D03(var_00, 0.5);
  var_01 delete();
  var_00 delete();
  var_02 delete();
  common_scripts\utility::func_F71(var_04, ::delete);
  common_scripts\utility::func_F71(var_05, ::delete);
  var_03 delete();
}

func_0C08(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 1000, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignettealliesplayercameramix(1);
}

func_0C09(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.7, 300, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignettealliesplayercameramix(2);
}

func_0C0A(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 340, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignettealliesplayercameramix(3);
}

func_0C0B(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 340, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignettealliesplayercameramix(4);
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_aachen_axiswin_cam01", "mp_raids_aachen_axiswin_cam02", "mp_raids_aachen_axiswin_cam03", "mp_raids_aachen_axiswin_cam04", "mp_raids_aachen_axiswin_camhold"];
  var_01 = [::func_1489, ::func_148A, ::func_148B, ::axisoutrocam04func, undefined];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_win", "targetname");
  level.var_6C86["axis"].var_8097 = 7;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
}

func_6C94() {
  deactivateraidexploder(25, 1);
  thread maps\mp\mp_raid_aachen_aud::outrovignetteaxisexplos();
  var_00 = level.var_6C86["axis"].var_116;
  var_01 = level.var_6C86["axis"].var_1D;
  var_02 = "vignette_notify";
  var_03 = ["mp_raids_aachen_axiswin_player01", "mp_raids_aachen_axiswin_player02", "mp_raids_aachen_axiswin_player03", "mp_raids_aachen_axiswin_player04", "mp_raids_aachen_axiswin_player05", "mp_raids_aachen_axiswin_player06"];
  var_04 = [];
  for(var_05 = 0; var_05 < 6; var_05++) {
    var_04[var_05] = [2, 1, 2, 2, 2, 0];
  }

  var_06 = lib_0502::func_4627(game["defenders"]);
  var_06 = common_scripts\utility::func_F92(var_06);
  for(var_05 = 0; var_05 < var_06.size; var_05++) {
    var_04[var_05] = var_06[var_05].var_267E;
  }

  var_07 = [];
  var_08 = [];
  for(var_05 = 0; var_05 < 6; var_05++) {
    var_09 = spawn("script_model", var_00);
    var_09 setcostumemodels(var_04[var_05], "axis");
    if(var_05 < var_06.size) {
      var_0A = var_06[var_05] lib_0505::func_470D("m1garand_mp");
      if(var_0A != "none") {
        var_0B = "weapon_" + var_0A;
        var_0C = spawn(var_0B, (0, 0, 0), 1);
        var_0C linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
        var_08[var_08.size] = var_0C;
      }
    } else {
      var_0C = spawn("weapon_mp40_mp", (0, 0, 0), 1);
      var_0C linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_08[var_08.size] = var_0C;
    }

    var_09 method_8495(var_03[var_05], var_00, var_01);
    var_07[var_05] = var_09;
  }

  var_0D = spawn("script_model", var_00);
  var_0D setModel("mp_ger_war_train_cars");
  var_0D method_8495("mp_raids_aachen_axiswin_trainsingle_01", var_00, var_01);
  maps\mp\_utility::func_2CED(3.3, ::func_08B5, "211");
  var_0E = ["mp_raids_aachen_axiswin_bomber01", "mp_raids_aachen_axiswin_bomber02", "mp_raids_aachen_axiswin_bomber03"];
  var_0F = [];
  foreach(var_11 in var_0E) {
    var_12 = spawn("script_model", var_00);
    var_12 setModel("ger_bomber_stuka");
    if(var_11 == "mp_raids_aachen_axiswin_bomber01") {
      var_12 thread vfx_axis_outro_notetrack(var_02);
    } else {
      maps\mp\_utility::func_2CED(randomfloatrange(0.2, 0.4), ::lib_04F3::func_79CC, "stuka_flyby", var_12);
    }

    var_12 method_8495(var_11, var_00, var_01, var_02);
    var_0F[var_0F.size] = var_12;
  }

  outrovignette_hidetrain();
  level.var_148C = spawnStruct();
  level.var_148C.train = var_0D;
  level.var_148C.var_18E9 = var_0F;
  level.var_148C.var_148D = var_07;
  level.var_148C.var_148F = var_08;
}

vfx_axis_outro_notetrack(param_00) {
  self waittillmatch("bomb", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_axis_outro_bomb_drop"), self, "TAG_ORIGIN");
  wait(0.2);
  func_08B5(201);
  self waittillmatch("bomb", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_axis_outro_bomb_drop"), self, "TAG_ORIGIN");
  wait(0.2);
  func_08B5(202);
  self waittillmatch("bomb", param_00);
  playFXOnTag(common_scripts\utility::func_44F5("raid_aachen_axis_outro_bomb_drop"), self, "TAG_ORIGIN");
  wait(0.2);
  func_08B5(203);
  wait(3);
  func_08B5(210);
}

func_6C92() {
  var_00 = level.var_148C.train;
  var_01 = level.var_148C.var_18E9;
  var_02 = level.var_148C.var_148D;
  var_03 = level.var_148C.var_148F;
  level.var_148C = undefined;
  var_00 delete();
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
}

outrovignette_hidetrain() {
  var_00 = getEntArray("train", "script_noteworthy");
  common_scripts\utility::func_FB2(var_00, ::lib_0502::func_7997);
}

func_1489(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 250, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignetteaxisplayercameramix(1);
}

func_148A(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.65, 91, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignetteaxisplayercameramix(2);
}

func_148B(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 300, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignetteaxisplayercameramix(3);
}

axisoutrocam04func(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 2000, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_aachen_aud::outrovignetteaxisplayercameramix(4);
}

func_7F7D() {}

func_7FCF() {
  setgamespawnpointactivelabel("A", "A", "A");
  thread movespawnsforpartialcompletion();
  level waittill("runObjectiveTramMoveComplete");
  level thread lib_0502::func_90A7("C", "B", 20, "C", "C");
  level waittill("runRadioObjectiveComplete");
  level thread lib_0502::func_90A7("G", "X", 20, "G", "G");
  level waittill("tank_checkpoint_1");
  level thread lib_0502::func_90A7("H", undefined, 5, "H", "H");
  level waittill("tank_checkpoint_2");
  level thread lib_0502::func_90A7("I", undefined, 5, "I", "I");
}

movespawnsforpartialcompletion() {
  level endon("runObjectiveTramMoveComplete");
  var_00 = "hostage_a_complete";
  var_01 = "hostage_b_complete";
  var_02 = level common_scripts\utility::func_A716(var_00, var_01);
  if(var_02 == var_00) {
    lib_0502::func_90A4("Z", undefined);
  } else {
    lib_0502::func_90A4("Y", undefined);
  }

  lib_0502::func_90A4(undefined, "W");
}

getaachenrespawndelay() {
  if(self.var_1A7 == game["attackers"]) {
    var_00 = lib_0501::func_4648("raid_attackersRespawn");
  } else {
    var_00 = lib_0501::func_4648("raid_defendersRespawn");
    if(common_scripts\utility::func_562E(level.var_79C2.var_6980)) {
      var_00 = 0;
    }
  }

  switch (level.var_7DB3) {
    case 0:
      return 0;

    case 1:
      return var_00;

    case 2:
      return func_7A19(var_00);
  }
}

func_7A19(param_00) {
  param_00 = param_00 * 1000;
  var_01 = gettime();
  var_02 = lib_0502::func_7978();
  var_03 = param_00 * int(var_02 / param_00);
  param_00 = param_00 - var_01 - var_03 / 1000;
  return param_00;
}

func_7F89() {
  waittillframeend;
  func_92FD();
  func_27D1("ObjectiveA", ::func_92BB);
  func_27D1("ObjectiveB", ::func_92BC);
  func_27D1("ObjectiveC", ::func_92BD);
  func_27D1("ObjectiveC1", ::func_92BE);
  func_27D1("ObjectiveC2", ::func_92BF);
  maps\mp\_utility::func_3FA5("prematch_done");
  func_20C5("ObjectiveA");
  level waittill("runObjectiveTramMoveComplete");
  func_20C5("ObjectiveB");
  level waittill("runRadioObjectiveComplete");
  func_20C5("ObjectiveC");
  level waittill("tank_checkpoint_1");
  func_20C5("ObjectiveC1");
  level waittill("tank_checkpoint_2");
  func_20C5("ObjectiveC2");
}

func_92BB() {
  lib_04F4::func_863D("axis_A", "active", 5);
  lib_04F4::func_863D("axis_B", "active", 5);
  lib_04F4::func_863D("axis_C", "active", 5);
  lib_04F4::func_863D("axis_C1", "active", 5);
  lib_04F4::func_863D("axis_C2", "active", 5);
  lib_04F4::func_863D("allies_A", "active", 5);
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
}

func_92BC() {
  level thread lib_04F4::func_9C77("allies_B", 20);
  lib_04F4::func_863D("axis_A", "inactive", 5);
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
}

func_92BD() {
  level thread lib_04F4::func_9C77("allies_C", 20);
  lib_04F4::func_863D("axis_B", "inactive", 5);
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C", "axis_C"]);
}

func_92BE() {
  level thread lib_04F4::func_9C77("allies_C1", 20);
  lib_04F4::func_863D("axis_C", "inactive", 5);
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C1", "axis_C1"]);
}

func_92BF() {
  level thread lib_04F4::func_9C77("allies_C2", 20);
  lib_04F4::func_863D("axis_C1", "inactive", 5);
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C2", "axis_C2"]);
}

func_92FD() {
  if(isDefined(level.var_792A)) {}

  level.var_792A = spawnStruct();
  level.var_792A.var_2951 = "NO_BOUNDARY_ACTIVE";
  level.var_792A.var_7BE0 = [];
  func_27D1("NO_BOUNDARY_ACTIVE", undefined, undefined);
}

func_20C5(param_00) {
  if(!isDefined(level.var_792A)) {}

  if(!isDefined(level.var_792A.var_7BE0[param_00])) {
    return;
  }

  if(level.var_792A.var_2951 != param_00) {
    var_01 = level.var_792A.var_7BE0[level.var_792A.var_2951];
    if(isDefined(var_01.var_36B1)) {
      [[var_01.var_36B1]]();
    }

    var_02 = level.var_792A.var_7BE0[param_00];
    if(isDefined(var_02.var_92C1)) {
      [[var_02.var_92C1]]();
    }
  }
}

func_27D1(param_00, param_01, param_02) {
  if(!isDefined(level.var_792A)) {
    func_92FD();
  }

  var_03 = spawnStruct();
  var_03.var_109 = param_00;
  var_03.var_92C1 = param_01;
  var_03.var_36B1 = param_02;
  level.var_792A.var_7BE0[param_00] = var_03;
}

func_7FB5() {}

func_7FDB() {
  level.var_7961 = [];
  waittillframeend;
}

func_08B5(param_00) {
  common_scripts\_exploder::func_392A(param_00);
  level.var_7961[level.var_7961.size] = param_00;
}

deactivateraidexploder(param_00, param_01) {
  common_scripts\_exploder::func_2A6D(param_00, undefined, param_01);
}

func_7FC0() {
  level endon("game_ended");
  function_01DF("usa_tank_sherman_mp");
  waittillframeend;
  var_00 = common_scripts\utility::func_46B5("tank_escort", "targetname");
  level.var_9600 = var_00.var_A2C8;
  runtrammoveobjective();
  lib_0502::func_7B35();
  level lib_04FF::tanknotify("tank_move_to_destruction");
  rundestroyradioobjective();
  lib_0502::func_7B35();
  thread watchobj3tankwallbust();
  wait(0.5);
  runescortobjective();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

runtrammoveobjective() {
  level notify("runObjectiveTramMove");
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  lib_04FF::func_6972("tram_fill");
  lib_0502::func_86DE(lib_0501::func_4647("hostage_objectiveTime"), 1);
  lib_04FF::func_6982("tram_fill");
  level thread lib_0500::func_1E85(game["defenders"], 16, "tram_fill");
  level notify("runObjectiveTramMoveComplete");
}

func_97DE(param_00) {
  vfxbarrierexplosion();
  var_01 = getent("tram_bust_wall", "targetname");
  if(isDefined(var_01)) {
    var_01 lib_0502::func_7997();
  }
}

vfxbarrierexplosion() {
  var_00 = (-4406, -1570, 386);
  lib_04F3::func_79CB("aac_barrier_hit", var_00);
  func_08B5(210);
}

rundestroyradioobjective() {
  level notify("run_objective_radio");
  var_00 = "objective_radio";
  lib_04FF::func_6972(var_00);
  lib_0502::func_697F(var_00);
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  lib_0502::func_86DE(lib_0501::func_4647("destroy_objectiveTime"), 2);
  level thread destroyobjectivetankmovement();
  lib_04FF::func_6982(var_00);
  level thread lib_0500::func_1E85(game["defenders"], 13, var_00);
  level notify("runRadioObjectiveComplete");
  level lib_04FF::tanknotify("destruction_03");
}

destroyobjectivetankmovement() {
  level endon("runRadioObjectiveComplete");
  var_00 = 0.33;
  var_01 = 0.66;
  wait 0.05;
  var_02 = common_scripts\utility::func_46B5("objective_radio", "targetname");
  var_03 = var_02.var_6896;
  var_04 = 0;
  for(;;) {
    var_05 = var_02 common_scripts\utility::func_A715("prop_destroyed", "objectiveComplete");
    if(var_05 == "objectiveComplete") {
      if(var_04 < var_00) {
        level lib_04FF::tanknotify("destruction_01");
      }

      if(var_04 < var_01) {
        level lib_04FF::tanknotify("destruction_02");
      }

      return;
    }

    var_06 = var_03 - var_02.var_6896;
    var_07 = var_06 / var_03;
    if(var_04 < var_00 && var_07 >= var_00) {
      level lib_04FF::tanknotify("destruction_01");
      lib_0506::func_A618("destroy_tankprogress1");
    }

    if(var_04 < var_01 && var_07 >= var_01) {
      level lib_04FF::tanknotify("destruction_02");
      lib_0506::func_A618("destroy_tankprogress2");
      level.var_9600.dontteleport = 1;
    }

    var_04 = var_07;
  }
}

watchobj3tankwallbust() {
  var_00 = getvehiclenode(level.var_9600.var_1A2, "targetname");
  var_00 thread tankpath();
  var_01 = getEntArray("obj3_tank_bust_wall", "targetname");
  var_02 = 0;
  if(!var_02) {
    level common_scripts\utility::knock_off_battery("obj3_tank_bust_wall", "escortVehicleTeleportToObjectiveStart");
  }

  level thread midpointvingnette_bombingrun();
  var_06 = spawn("script_model", var_01[3].var_116);
  var_06 setModel("mp_raid_aachen_arch_fx_01_anim");
  var_06 method_8278("mp_raids_aachen_arch_destruction", "breakObject");
  func_08B5(150);
  foreach(var_04 in var_01) {
    var_04 lib_0502::func_7997();
  }
}

func_1BB4() {
  self notify("objectiveAnimNotetracks");
  self endon("objectiveAnimNotetracks");
  self endon("death");
  for(;;) {
    self waittill("breakObject", var_00);
    if(var_00 == "end") {
      self delete();
    }
  }
}

tankpath() {
  var_00 = self;
  var_01 = 1;
  while(isDefined(var_00)) {
    var_00 thread tanknode(var_01);
    if(!isDefined(var_00.var_1A2)) {
      break;
    }

    var_01 = 0;
    var_00 = getvehiclenode(var_00.var_1A2, "targetname");
  }
}

tanknode(param_00) {
  if(isDefined(self.var_165)) {
    if(!param_00) {
      self waittill("trigger", var_01);
    }

    level notify(self.var_165);
  }
}

runescortobjective() {
  level notify("runEscortObjective");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_04FF::func_6972("tank_escort");
  lib_0502::func_86DE(lib_0501::func_4647("escort_objectiveTime"), 3);
  lib_04FF::func_6982("tank_escort");
  level notify("runEscortObjectiveComplete");
}

gatherscorestreatknodes() {
  level.ambienatscorestreaknodes = [];
  level.ambienatscorestreaknodes["tram_fill"] = [];
  level.ambienatscorestreaknodes["objective_radio"] = [];
  level.ambienatscorestreaknodes["tank_escort"] = [];
  var_00 = common_scripts\utility::func_46B7("ambientScorestreakNode", "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.var_165) || !isDefined(var_02.var_8260)) {
      continue;
    }

    if(!isDefined(var_02.var_1D)) {
      var_02.var_1D = (0, 90, 0);
    }

    var_03 = strtok(var_02.var_165, "|");
    var_04 = var_02.var_8260;
    foreach(var_06 in var_03) {
      if(!isDefined(isDefined(level.ambienatscorestreaknodes[var_04]))) {
        level.ambienatscorestreaknodes[var_04] = [];
      }

      if(!isDefined(level.ambienatscorestreaknodes[var_04][var_06])) {
        level.ambienatscorestreaknodes[var_04][var_06] = [];
      }

      level.ambienatscorestreaknodes[var_04][var_06][level.ambienatscorestreaknodes[var_04][var_06].size] = var_02;
    }
  }
}

func_7FCD() {
  level endon("game_ended");
  gatherscorestreatknodes();
  maps\mp\gametypes\_hostmigration::func_A6F5(randomfloatrange(10, 20));
  var_00 = undefined;
  for(;;) {
    var_01 = 1;
    if(level.var_79AE.var_8DB.size != 0 && !common_scripts\utility::func_562E(level.var_79C2.var_6980)) {
      var_02 = func_8A42(level.var_79AE.var_8DB[0].var_695A);
      var_03 = 0;
      foreach(var_05 in var_02) {
        var_03 = var_03 + var_05.laststand_enter_levelspecificaction;
      }

      var_07 = common_scripts\utility::func_7A33(["allies", "axis"]);
      var_08 = randomfloat(var_03);
      var_09 = undefined;
      while(!isDefined(var_09)) {
        foreach(var_05 in var_02) {
          var_08 = var_08 - var_05.laststand_enter_levelspecificaction;
          if(var_08 < 0) {
            var_09 = var_05;
            break;
          }
        }

        if(isDefined(var_00) && var_09.var_7B79 == var_00.var_7B79 && common_scripts\utility::func_562E(var_09.var_6739)) {
          var_09 = undefined;
        }
      }

      var_00 = var_09;
      var_0F = level.var_79AE.var_8DB[0].var_695A;
      var_10 = undefined;
      var_11 = (0, 0, 0);
      var_12 = [];
      if(isDefined(level.ambienatscorestreaknodes[var_0F]) && isDefined(level.ambienatscorestreaknodes[var_0F][var_09.var_7B79])) {
        var_13 = common_scripts\utility::func_7A33(level.ambienatscorestreaknodes[var_0F][var_09.var_7B79]).var_1D;
        var_14 = spawnStruct();
        var_14.var_61BC = var_13[1] - 15;
        var_14.var_6076 = var_13[1] + 15;
        var_15 = spawnStruct();
        var_15.var_61BC = var_14.var_61BC + 180;
        var_15.var_6076 = var_14.var_6076 + 180;
        var_10 = [var_14, var_15];
        var_11 = var_13;
        if(var_07 == "axis") {
          var_11 = var_11 + (0, 180, 0);
        }

        for(var_16 = 0; var_16 < var_09.var_689D; var_16++) {
          var_12[var_12.size] = common_scripts\utility::func_7A33(level.ambienatscorestreaknodes[var_0F][var_09.var_7B79]);
        }
      } else {
        var_11 = (0, randomfloatrange(-60, 60), 0);
        if(var_07 == "axis") {
          var_11 = var_11 + (0, 180, 0);
        }

        var_12 = lib_0500::func_4678(var_09.var_689D, var_09.var_7B79, var_07, var_11, var_10);
      }

      lib_0500::func_1E8A(var_09.var_7B79, var_07, var_12);
      var_01 = 14;
      switch (level.var_79AE.var_8DB[0].var_695A) {
        case "tram_fill":
          var_01 = var_01 + 6 + randomfloat(8);
          break;

        case "objective_radio":
          var_01 = var_01 + 2 + randomfloat(6);
          break;

        case "tank_escort":
          var_01 = var_01 + randomfloat(5);
          break;

        default:
          break;
      }
    }

    maps\mp\gametypes\_hostmigration::func_A6F5(var_01);
  }
}

func_8A42(param_00) {
  var_01 = 1;
  var_02 = 1;
  var_03 = 1;
  if(param_00 == "tram_fill") {
    var_01 = 0.8;
    var_02 = 0.6;
    var_03 = 0.4;
  } else if(param_00 == "objective_radio") {
    var_01 = 1;
    var_02 = 0.9;
    var_03 = 0.8;
  }

  var_04 = [];
  var_05 = spawnStruct();
  var_05.laststand_enter_levelspecificaction = 2.285714;
  var_05.var_689D = 1;
  var_05.var_7B79 = "fighter_strike";
  var_04[var_04.size] = var_05;
  var_06 = spawnStruct();
  var_06.laststand_enter_levelspecificaction = 1.6 * var_01;
  var_06.var_689D = 3;
  var_06.var_7B79 = "mortar_strike";
  var_04[var_04.size] = var_06;
  var_07 = spawnStruct();
  var_07.laststand_enter_levelspecificaction = 1.411765 * var_02;
  var_07.var_689D = 1;
  var_07.var_7B79 = "missile_strike";
  var_04[var_04.size] = var_07;
  var_08 = spawnStruct();
  var_08.laststand_enter_levelspecificaction = 1 * var_03;
  var_08.var_689D = 1;
  var_08.var_7B79 = "airstrike";
  var_08.var_6739 = 1;
  var_04[var_04.size] = var_08;
  var_09 = 0;
  foreach(var_0B in var_04) {
    var_09 = var_09 + var_0B.laststand_enter_levelspecificaction;
  }

  return var_04;
}