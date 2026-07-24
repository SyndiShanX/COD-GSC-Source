/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_flyin.gsc
*************************************************/

_id_6FA3() {
  var_0 = 1;
}

_id_D612() {
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("fly_in_vision_fx");
  thread _id_6FA3();
  level thread _id_D613();
}

_id_D613() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("titan_base_tr");
}

_id_D610() {
  level.player _meth_80D1();
  level.player _meth_82C0("titan_dropship", 0.05);
  setomnvar("ui_hide_hud", 1);
  thread _id_2AD3();
  wait 0.05;
  thread _id_5EA4();
  thread _id_10637();
  scripts\engine\utility::flag_wait("player_unloaded");
}

_id_D611() {
  if(isDefined(level._id_B33E))
    level._id_B33E scripts\sp\utility::_id_F3B5("orange");

  if(isDefined(level._id_2429))
    level._id_2429 scripts\sp\utility::_id_F3B5("red");

  level.player scripts\sp\utility::_id_F526("relaxed");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }
}

_id_2AD3() {
  if(!scripts\sp\maps\titan\titan_code::_id_58CC()) {
    scripts\engine\utility::flag_set("bink_done");
    return;
  }

  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("titan_dropship_turbulence");
  wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  scripts\engine\utility::flag_set("bink_done");
}

_id_AE1C() {
  setDvar("bink_capture", 1);
  level.player _meth_80D1();
  setomnvar("ui_hide_hud", 1);
  level.player _meth_81DE(45, 0.05);
  level thread _id_1293F();
  level._id_5D6C = _id_0BBF::_id_106B8("intro_dropship", undefined, "jump_seat_1");
  level._id_5D6C _id_0BBF::_id_F4B4("straps", "heavy");
  level._id_5D6C._id_E6E8 = "tag_origin";
  thread _id_AE1A();
  scripts\sp\maps\titan\titan_code::_id_10733();
  thread _id_5D77(1);
  thread _id_AE1B();
  thread _id_AE19();
}

_id_AE1A() {
  level._id_5D6C _id_0BBF::_id_F456();
  level._id_5D6C _id_0BBF::_id_F457(0);
}

_id_AE19() {
  var_0 = getanimlength(level._id_10AC8[0] scripts\sp\utility::_id_7DC1("loading_movie_scene"));
  wait(var_0 - 0.5);
  level._id_5D6C _id_0BBF::_id_F456();
}

_id_AE1B() {
  var_0 = level._id_5D6C;
  var_1 = level._id_5D6C._id_E6E8;
  level.player._id_1EB7 = spawn("script_origin", var_0.origin);
  level.player._id_1EB7.angles = var_0.angles;
  level.player._id_1EB7 linkTo(var_0, var_1, (0, 0, 0), (0, 0, 0));
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_0._id_C6EA, var_0.angles);
  scripts\sp\anim::_id_1EC2(level.player._id_1E9C, "intro_dropoff_exit", level.player._id_1EB7.origin, level.player._id_1EB7.angles);
  level.player._id_1E9C linkTo(var_0, var_1);
  scripts\sp\maps\titan\titan_code::_id_D85C();
  level.player _meth_823B(level.player._id_1E9C, "tag_player");
}

_id_5EA4() {
  level._id_5D6C = _id_0BBF::_id_106B8("intro_dropship", undefined, "jump_seat_1");
  level._id_5D6C._id_1FBB = "dropship_flyin";
  level._id_5D6C _id_0BBF::_id_106BA(1);
  level._id_5D6C._id_D27E = level._id_5D6C _id_0BBF::_id_F37F("left_01");
  var_0 = ["middle_01", "middle_02", "left_01", "right_01", "right_02"];
  level._id_5D6C _id_0BBF::_id_F596("on", var_0);
  level._id_5D6C _id_0BBF::_id_F4B4("straps", "heavy");
  level._id_5D6C scripts\sp\utility::_id_65E0("ride_start");
  level._id_5D6C scripts\sp\utility::_id_65E0("drop_end");
  level._id_5D6C scripts\sp\utility::_id_65E0("descent_prep");
  level._id_5D6C scripts\sp\utility::_id_65E0("descent_start");
  level._id_5D6C scripts\sp\utility::_id_65E0("descent_land");
  level._id_5D6C scripts\sp\utility::_id_65E0("exiting");
  var_1 = getEntArray("freighter_ships", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  if(scripts\sp\utility::hastag(level._id_5D6C.model, "tag_origin"))
    level._id_5D6C._id_E6E8 = "tag_origin";
  else
    level._id_5D6C._id_E6E8 = level._id_5D6C.model;

  scripts\sp\maps\titan\titan_code::_id_10733();
  thread _id_2C23();
  thread _id_5E64();
  scripts\engine\utility::flag_wait("bink_done");
  thread _id_5DDA();
  thread _id_5D77();
  thread _id_5E6B();
  wait 0.1;
  thread _id_FB79();
  scripts\engine\utility::flag_wait("freefall_vo_complete");
  scripts\sp\vehicle_paths::_id_845A(level._id_5D6C);
  thread level_load_transients_pc();
  scripts\engine\utility::flag_wait("player_dropship_door_open");
  level._id_5D6C _id_0BBC::_id_F365("right", level._id_EC85["dropship_flyin"]["dropship_door_open"]);
  level._id_5D6C _id_0BBC::_id_C5F1(["right"]);
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_drop_dust_spiral"), level._id_5D6C, "TAG_DOOR_RIGHT");
  scripts\engine\utility::flag_wait("squad_unloaded");
}

level_load_transients_pc() {
  if(!level.console) {
    wait 18.0;
    waitforalltransients();
  }
}

_id_11884() {
  self endon("death");
  var_0 = 0;
  scripts\engine\utility::flag_wait("begin_intro_unload");
  self notify("stop_thrusters_on_off");

  for(;;) {
    if(scripts\engine\utility::flag("titan_enable_thrusters"))
      scripts\sp\utility::_id_65DD("inside_dropship_disable_effects");
    else if(!scripts\engine\utility::flag("squad_unloaded"))
      scripts\sp\utility::_id_65E1("inside_dropship_disable_effects");

    wait 0.2;
  }
}

_id_2C23() {
  wait 1;
  var_0 = getEnt("boggs", "targetname");
  var_0.count = var_0.count + 1;
  level._id_2C23 = var_0 scripts\sp\utility::_id_10619(1);
  level._id_2C23._id_1EEF = level._id_5D6C scripts\engine\utility::spawn_tag_origin();
  level._id_2C23._id_1EEF.angles = level._id_5D6C.angles;
  level._id_2C23._id_1EEF linkTo(level._id_5D6C, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_2C23._id_1FBB = "boggs";
  level._id_2C23 linkTo(level._id_5D6C, "tag_origin");
  level._id_2C23._id_1EEF thread scripts\sp\anim::_id_1EEA(level._id_2C23, "dropship_idle");
  level._id_2C23 scripts\sp\utility::_id_86E4();
  level._id_2C23.name = "Boggs";
}

_id_5DDA() {
  var_0 = scripts\sp\utility::_id_7B27("ride_start");
  var_1 = scripts\sp\utility::_id_7B27("drop_end");
  var_2 = scripts\sp\utility::_id_7B27("descent_prep");
  var_3 = scripts\sp\utility::_id_7B27("descent_start");
  var_4 = scripts\sp\utility::_id_7B27("descent_land");
  var_5 = scripts\sp\utility::_id_7B27("exiting");
  level._id_5D6C scripts\engine\utility::delaythread(0.1, _id_0BBF::_id_F459, 0);
  level._id_5D6C scripts\sp\utility::_id_65E1("ride_start");
  thread _id_981F();
  level thread _id_134CF();
  scripts\engine\utility::flag_wait("freefall_start");
  level thread _id_1293F();
  thread scripts\sp\maps\titanjackal\titanjackal_fx::_id_5DF7();
  var_1 waittill("trigger");
  level._id_5D6C scripts\sp\utility::_id_65E1("drop_end");
  scripts\engine\utility::flag_set("free_fall_done");
  wait 0.5;
  level._id_5D6C _id_0BBF::_id_F456();
  level._id_5D6C _id_0BBF::_id_F457(0);
  scripts\engine\utility::flag_wait("player_dropship_dismount");
  thread _id_981F();
  var_2 waittill("trigger");
  level._id_5D6C scripts\sp\utility::_id_65E1("descent_prep");
  var_3 waittill("trigger");
  scripts\engine\utility::flag_set("dropship_landing");
  level._id_5D6C scripts\sp\utility::_id_65E1("descent_start");
  level thread scripts\sp\utility::_id_C12D("stop_player_jumpout_check", 6);
  level._id_5D6C sethoverparams(0, 0, 0);
  level notify("landing");
  var_4 waittill("trigger");
  level._id_5D6C scripts\sp\utility::_id_65E1("descent_land");
  level._id_5D6C scripts\sp\vehicle_code::_id_13804();
  scripts\engine\utility::flag_set("begin_intro_unload");
  scripts\engine\utility::delaythread(1.2, ::_id_5E2B);
  thread _id_FB78();
  level notify("change_camera_shake");
  level.player stoprumble("damage_light");
  level.player stoprumble("damage_heavy");
  level._id_5D6C scripts\engine\utility::delaythread(1, _id_0BBF::_id_F4B4, "straps", "light");
  var_5 waittill("trigger");
}

_id_5E2A() {
  scripts\engine\utility::flag_wait("intro_land_impact");
}

_id_5E2B() {
  level.player playSound("scn_titan_dropship_land_impt_lr");
  wait 0.1;
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "scn_titan_dropship_landing_gear");
  level.player scripts\engine\utility::delaycall(1.0, ::playsound, "scn_titan_dropship_land_shake_lr");
  earthquake(0.5, 1, level.player.origin, 400);
  wait 0.5;
  earthquake(0.1, 0.5, level.player.origin, 400);
}

_id_FB78() {
  var_0 = spawn("script_origin", (-62669, -32097, -65131));
  var_0 linkTo(level._id_5D6C);
  var_0 scripts\sp\utility::_id_10461("scn_titan_dropship_idle", 1, 5, 1);
  scripts\engine\utility::flag_wait("squad_unloaded");
  var_0 scripts\sp\utility::_id_10460(2, 1);
}

_id_FB79() {
  wait 0.5;
  level.player playSound("scn_titan_dropship_infil_01_lr");
  scripts\engine\utility::flag_wait("player_dropship_door_open");
  level._id_5D6C thread scripts\sp\utility::play_sound_on_tag("scn_dropship_door_open", "TAG_DOOR_RIGHT");
  level._id_5D6C thread scripts\sp\utility::play_loop_sound_on_tag("scn_dropship_door_wind_lp", "TAG_DOOR_RIGHT");
  level._id_5D6C thread scripts\sp\utility::play_sound_on_tag("scn_dropship_door_wind_ss", "TAG_DOOR_RIGHT");
  level.player playSound("scn_titan_dropship_infil_02_lr");
  thread titan_start_music();
  wait 21.5;
  level.player playSound("scn_titan_dropship_infil_03_lr");
  scripts\engine\utility::flag_wait("intro_land_impact");
  level._id_5D6C scripts\engine\utility::stop_loop_sound_on_entity("scn_dropship_door_wind_lp");
}

titan_start_music() {
  setmusicstate("mx_007_dropshipdoor");
  wait 40;
  setmusicstate("mx_431_titan_walkntalk");
}

_id_134D0() {
  level._id_5D6C endon("death");
  wait 3.6;

  for(var_0 = 0; var_0 < 20; var_0++) {
    if(!scripts\engine\utility::flag("freefall_start") || scripts\engine\utility::flag("dropship_fly_sfx"))
      _id_5E58("titan_dropship_radio_bursts");

    wait(randomintrange(3, 5));
  }
}

_id_134CF() {
  thread _id_5E59();
  thread _id_134D0();
}

_id_5E59() {
  var_0 = ["sc_titan_bgs_ClearTwominutesto", "sc_titan_bgs_Holdyourcocksand", "sc_titan_bgs_LevelingoffYourefree", "sc_titan_bgs_Fivesecondstothe"];

  foreach(var_2 in var_0) {
    level waittill("dropship_line");
    _id_5E58(var_2);

    if(var_2 == "sc_titan_bgs_Holdyourcocksand") {
      scripts\engine\utility::flag_set("freefall_start");
      continue;
    }

    if(var_2 == "sc_titan_bgs_Fivesecondstothe")
      scripts\engine\utility::flag_set("dropship_land_sfx");
  }
}

_id_FC50(var_0, var_1) {
  level notify("new_shake_loop");
  level endon("new_shake_loop");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0.7;

  switch (var_0) {
    case "light":
      var_2 = 0.09;
      var_3 = 0.18;
      var_4 = "damage_light";
      break;
    case "heavy":
      var_2 = 0.13;
      var_3 = 0.16;
      var_4 = "damage_heavy";
      break;
  }

  thread _id_FC4F(var_1, var_4);

  while(!scripts\engine\utility::flag(var_1)) {
    var_6 = randomfloatrange(var_2, var_3);
    earthquake(var_6, var_5, level.player.origin, 800);
    wait(var_5 * randomfloatrange(0.6, 0.9));
  }
}

_id_FC4F(var_0, var_1) {
  level.player endon("death");

  while(!scripts\engine\utility::flag(var_0)) {
    level.player _meth_8244(var_1);
    wait(randomfloatrange(1.75, 3.5));
    level.player stoprumble(var_1);
    wait(randomfloatrange(0.75, 1.85));
  }
}

_id_5FC8(var_0, var_1) {
  var_2 = var_1 / 4;
  var_3 = var_0 * 0.25;

  for(var_4 = 0; var_4 < 4; var_4++) {
    earthquake(var_0, var_2, level.player.origin, 800);
    wait(var_2);
    var_0 = var_0 - var_3;
  }
}

_id_D1AA() {
  scripts\engine\utility::flag_wait("player_locked_in_dropship");
  wait 1;
  level endon("stop_player_jumpout_check");

  while(level._id_5D6C _id_0BBF::_id_D118())
    wait 0.1;

  level.player _meth_80A1();
  level.player scripts\sp\utility::_id_54C6();
}

_id_5D77(var_0) {
  var_1 = level._id_5D6C._id_E6E8;

  foreach(var_3 in level._id_10AC8) {
    var_3._id_1EEF = level._id_5D6C scripts\engine\utility::spawn_tag_origin();
    var_3._id_1EEF.angles = level._id_5D6C.angles;
    var_3._id_1EEF linkTo(level._id_5D6C, var_1, (0, 0, 0), (0, 0, 0));
    var_3 linkTo(level._id_5D6C, var_1);
  }

  var_5 = [];
  var_6 = ["right_01", "right_02", "middle_01", "middle_02"];

  foreach(var_9, var_8 in level._id_5D6C _id_0BBF::_id_796E()) {
    if(isDefined(scripts\engine\utility::array_find(var_6, var_9)))
      var_5[var_5.size] = var_8;
  }

  var_10 = 3;
  level._id_5D6C._id_86D9 = [];

  foreach(var_9 in var_6)
  level._id_5D6C scripts\sp\anim::_id_1EC3(var_5[var_9], "dropship_intro");

  for(var_13 = 1; var_13 < var_10; var_13++) {
    level._id_5D6C._id_86D9[var_13] = scripts\sp\utility::_id_10639("dropship_seat_mount0" + var_13, level._id_5D6C.origin);
    level._id_5D6C scripts\sp\anim::_id_1EC3(level._id_5D6C._id_86D9[var_13], "seat_mount_ff", var_1);
    level._id_5D6C._id_86D9[var_13] linkTo(level._id_5D6C, var_1);
  }

  level._id_5D6C._id_D27E = level._id_5D6C _id_0BBF::_id_796D("left_01");
  level._id_5D6C._id_D27E._id_1FBB = "dropship_seat07";
  level._id_5D6C scripts\sp\anim::_id_1EC3(level._id_5D6C._id_D27E, "dropship_player_seat_exit");
  level._id_5D6C._id_D27E linkTo(level._id_5D6C);

  if(isDefined(var_0))
    var_14 = "loading_movie_scene";
  else
    var_14 = "intro_dropoff_scene";

  level notify("loading_anim_start");

  foreach(var_3 in level._id_10AC8)
  var_3._id_1EEF thread _id_9AB1(var_3, var_14);

  level._id_5D6C thread scripts\sp\anim::_id_1F2C(var_5, "dropship_intro", var_1);
  wait 1;
  scripts\engine\utility::flag_set("fly_in_grab_gun_post_fx");
  wait 1;
  level waittill("intro_scene_done");

  if(isDefined(var_0)) {
    foreach(var_3 in level._id_10AC8)
    var_3._id_1EEF thread scripts\sp\anim::_id_1EE0(var_3, var_14);

    return;
  }

  scripts\engine\utility::flag_wait("begin_intro_unload");

  foreach(var_3 in level._id_10AC8)
  var_3 scripts\engine\utility::delaythread(0.5, ::_id_873C);

  level._id_B33E scripts\sp\utility::_id_F3B5("orange");
  level._id_2429 scripts\sp\utility::_id_F3B5("red");
  scripts\sp\utility::_id_15F5("squad_to_pos1");
  level._id_5E61 _meth_80AF(undefined);
  scripts\engine\utility::flag_wait("player_unloaded");
  wait 1.0;
  level notify("boggs_sfx_takeoff");
  level._id_5D6C playSound("scn_dropship_takeoff");
  wait 0.3;
  scripts\engine\utility::flag_set("squad_unloaded");
  wait 5;

  foreach(var_3 in level._id_10AC8)
  var_3._id_1EEF delete();

  level._id_2C23 delete();
  level._id_2C23._id_1EEF delete();

  foreach(var_24 in level._id_5D6C._id_86D9)
  var_24 delete();
}

_id_9AB1(var_0, var_1) {
  if(var_0 == level._id_C47F || var_0 == level._id_B33E) {
    scripts\engine\utility::flag_set("freefall_start");
    scripts\sp\anim::_id_1F35(var_0, "intro_dropoff_scene_2");

    if(getdvarint("flyin_pip"))
      thread scripts\sp\pip_util::_id_CBA3();

    level notify("intro_scene_done");
    thread scripts\sp\anim::_id_1EEA(var_0, "intro_dropoff_idle");

    if(var_0 == level._id_B33E) {
      level waittill("kashima_clear_vo");
      level.player thread scripts\sp\utility::play_sound_on_entity("titan_grp_clear");
      wait 0.1;
      var_0 thread scripts\sp\utility::_id_10346("sc_titan_ksh_Clear");
    }

    return;
  }

  scripts\sp\anim::_id_1F35(var_0, var_1);
  level notify("intro_scene_done");
  thread scripts\sp\anim::_id_1EEA(var_0, "intro_dropoff_idle");
}

_id_5EA5(var_0) {
  var_1 = scripts\sp\utility::_id_10639("dropship_seat", level._id_5D6C gettagorigin(var_0), level._id_5D6C gettagangles(var_0));
  var_1 scripts\sp\anim::_id_1EC3(var_1, "empty_seat_ff");
  var_1 linkTo(level._id_5D6C);
  level._id_5D6C._id_61BB[level._id_5D6C._id_61BB.size] = var_1;
}

_id_873C() {
  self._id_1EEF notify("stop_loop");
  self._id_1EEF scripts\sp\anim::_id_1F35(self, "intro_dropoff_exit");
  self unlink();
  self _meth_82EE(getnode(self._id_1FBB + "_deploy_node", "targetname"));
}

_id_5E6B() {
  thread _id_7004();
  var_0 = level._id_5D6C;
  var_1 = level._id_5D6C._id_E6E8;
  level.player._id_1EB7 = spawn("script_origin", var_0.origin);
  level.player._id_1EB7.angles = var_0.angles;
  level.player._id_1EB7 linkTo(var_0, var_1, (0, 0, 0), (0, 0, 0));
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_0._id_C6EA, var_0.angles);
  scripts\sp\maps\titan\titan_code::_id_D85C();
  scripts\sp\anim::_id_1EC2(level.player._id_1E9C, "intro_dropoff_exit", level.player._id_1EB7.origin, level.player._id_1EB7.angles);
  level.player._id_1E9C linkTo(var_0, var_1);
  level.player _meth_823B(level.player._id_1E9C, "tag_player");
  thread _id_D1F5();
  level._id_5E61 = level._id_5D6C._id_4D94._id_4348;
  var_2 = (0, 35, 118);
  scripts\engine\utility::flag_set("player_locked_in_dropship");
  _id_FA08();
  thread _id_9132();
  scripts\engine\utility::flag_wait("player_dropship_dismount");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\engine\utility::delaythread(1.7, scripts\sp\specialist_MAYBE::_id_F3FF, 1);
    scripts\engine\utility::delaythread(1.7, scripts\sp\specialist_MAYBE::_id_F53C, 0);
  }

  level.player playSound("scn_titan_dropship_harness_plr");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5D6C._id_D27E, "dropship_player_seat_exit");
  thread _id_12964(4.5);
  level.player._id_1EB7 scripts\sp\anim::_id_1F35(level.player._id_1E9C, "intro_dropoff_exit");
  scripts\sp\maps\titan\titan_code::_id_DF3E();

  if(isDefined(level.player._id_13C3F))
    level.player._id_13C3F delete();

  setsaveddvar("cg_drawplayershadow", 1);
  level.player._id_1E9C delete();
  level.player._id_1EB7 delete();
  level.player _meth_80A1();
  thread _id_119C3();
  setomnvar("ui_hide_hud", 0);
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player setmovespeedscale(0.7);
  scripts\engine\utility::flag_wait("begin_intro_unload");
  wait 2;
  level.player setmovespeedscale(1.0);
  scripts\sp\maps\titan\titan_code::_id_13784(level._id_10AC8);

  while(distance2d(var_0.origin, level.player.origin) < 800)
    wait 0.1;

  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  level._id_5D6C _id_0BBC::_id_F362("right", level._id_EC85["dropship_flyin"]["dropship_door_close"]);
  level._id_5D6C _id_0BBC::_id_4265(["right"]);
  thread destroy_coverwalls_on_takeoff();
  scripts\engine\utility::flag_set("player_unloaded");
}

destroy_coverwalls_on_takeoff() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(isDefined(level.player._id_4759._id_11168) && level.player._id_4759._id_11168.size > 0)
      thread scripts\sp\coverwall::_id_DFBD();

    wait 1;
  }
}

_id_7004() {
  var_0 = getEnt("flyin_ceiling_blocker", "targetname");
  scripts\engine\utility::trigger_off("flyin_overhead_kill_trig", "targetname");
  var_0 notsolid();
  scripts\engine\utility::flag_wait("player_unloaded");
  scripts\engine\utility::trigger_on("flyin_overhead_kill_trig", "targetname");
  var_0 solid();
}

_id_12964(var_0) {
  wait(var_0);
  var_1 = ["middle_01", "middle_02", "left_01", "right_01", "right_02"];
  level._id_5D6C _id_0BBF::_id_F596("off", var_1);
}

_id_119C3() {
  _id_0B2A::_id_11429();
  level.player scripts\engine\utility::allow_fire(0);
  scripts\engine\utility::flag_wait("begin_intro_unload");
  level._id_5988 delete();
  level.player scripts\engine\utility::allow_fire(1);
  scripts\engine\utility::flag_wait("player_unloaded");
  _id_0B2A::_id_E2C0();
}

_id_5E64() {
  level._id_5988 = getEnt("dropship_door_coll", "targetname");
  level._id_59E0 = getEntArray("dropship_player_coll", "targetname");
  level._id_5988.origin = level._id_5D6C gettagorigin("TAG_DOOR_RIGHT");
  level._id_5988 linkTo(level._id_5D6C, "TAG_DOOR_RIGHT");

  foreach(var_1 in level._id_59E0)
  var_1 linkTo(level._id_5988);
}

_id_113D7() {
  level._id_4F06 = level._id_5D6C scripts\engine\utility::spawn_tag_origin(level._id_5988.origin, level._id_5988.angles);
  level._id_4F06 _id_0E46::_id_48C4("tag_origin", (0, 0, 0), "undefined", undefined, 500, 1);
  level._id_4F06 linkTo(level._id_5D6C, "TAG_DOOR_LEFT");
}

_id_D1F5() {
  if(!getdvarint("flyin_pip")) {
    return;
  }
  var_0 = getEnt("pip_monitor", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_7A8F();

  foreach(var_3 in var_1)
  var_3 linkTo(var_0);

  var_0 linkTo(level.player._id_1E9C, "tag_origin", (42, 13, 47), (0, 270, 0));
  thread scripts\sp\pip_util::_id_CBB5(level._id_C47F, "tag_eye", 29, (18, 3, 1), (0, 200, 3), 1);
  level._id_CB9C.aspectratio = 1;
  level._id_CB9C.fov = 95;
  scripts\engine\utility::flag_wait("player_dropship_dismount");
  var_0 linkTo(level._id_5D6C);
  wait 2.5;
  var_0 delete();
  scripts\engine\utility::array_call(var_1, ::delete);
}

_id_13485() {
  scripts\engine\utility::flag_wait("player_dropship_dismount");
  level.player.helmet show();
  level.player scripts\engine\utility::delaycall(0.65, ::_meth_82C0, "titan_dropship_helmet", 0.2);
  level.player.helmet._id_1EEF scripts\sp\anim::_id_1F35(level.player.helmet, "visor_down");
  thread _id_9132();
  level.player.helmet._id_1EEF delete();
  level.player.helmet delete();
}

_id_9132() {
  wait 2.6;

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_8E05();

  thread _id_0B0B::_id_25C2(2.0, "normal", "titan_dropship");
  wait 0.6;
}

_id_FA08() {
  var_0 = level.player scripts\sp\utility::_id_7D74();
  var_1 = "tag_origin";

  if(var_0.size > 0)
    var_1 = getweaponmodel(var_0[0]);

  level.player._id_13C3F = spawn("script_model", level.player._id_1E9C gettagorigin("tag_weapon_right"));
  level.player._id_13C3F.angles = level.player._id_1E9C gettagangles("tag_weapon_right");
  level.player._id_13C3F linkTo(level.player._id_1E9C, "tag_weapon_right");
  level.player._id_13C3F setModel(var_1);
}

_id_981F() {
  level notify("change_camera_shake");
  level endon("change_camera_shake");
  level childthread _id_FC50("light", "freefall_start");

  for(;;) {
    var_0 = randomfloatrange(1.6, 2.2);
    var_1 = randomfloatrange(0.5, 1);
    var_2 = randomfloatrange(0.25, 1);
    var_3 = 0.25;
    var_4 = var_3 * 0.5;
    var_5 = var_3 * 0.5;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_1293F() {
  level notify("change_camera_shake");
  level endon("change_camera_shake");
  level childthread _id_FC50("heavy", "player_dropship_dismount");

  for(;;) {
    var_0 = randomfloatrange(1.6, 2.2);
    var_1 = randomfloatrange(0.5, 1);
    var_2 = randomfloatrange(0.25, 1);
    var_3 = 0.15;
    var_4 = var_3 * 0.5;
    var_5 = var_3 * 0.5;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_5E58(var_0) {
  var_1 = spawn("script_origin", level._id_5D6C.origin);
  var_2 = (330, -100, 100);
  var_3 = (0, 0, 0);
  var_1 linkTo(level._id_5D6C, "TAG_DOOR_LEFT", var_2, var_3);
  var_1 playSound(var_0, "sound_done");
  var_1 waittill("sound_done");
  var_1 delete();
}

_id_D1CF() {
  var_0 = 1;
  level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1, 1, 1, 1, 1, 1);
  wait 0.05;
  level.player lerpviewangleclamp(var_0, var_0 * 0.5, var_0 * 0.5, 20, 30, 20, 30);
}

_id_10637() {
  var_0 = getEntArray("flyin_ships", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\sp\utility::_id_10808();
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  scripts\engine\utility::flag_wait("free_fall_done");

  foreach(var_7 in var_1)
  var_7 thread _id_7005();
}

_id_7005() {
  if(isDefined(self.script_parameters)) {
    thread scripts\sp\vehicle_paths::_id_845A(self);
    scripts\engine\utility::flag_wait("flying_docking");
    wait 30;
    scripts\engine\utility::flag_set("ship_delay_over");
  } else {
    level waittill("squad_unloaded");
    wait(randomintrange(15, 45));
    thread scripts\sp\vehicle_paths::_id_845A(self);
  }
}