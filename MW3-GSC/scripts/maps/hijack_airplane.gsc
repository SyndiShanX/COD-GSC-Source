/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_airplane.gsc
********************************************/

_id_5A63() {
  common_scripts\utility::flag_init("introscreen_done");
  common_scripts\utility::flag_init("intro_player_animate");
  common_scripts\utility::flag_init("open_intro_door");
  common_scripts\utility::flag_init("start_amb_guys");
  common_scripts\utility::flag_init("start_cart_props");
  common_scripts\utility::flag_init("intro_done");
  common_scripts\utility::flag_init("follow_pres");
  common_scripts\utility::flag_init("take_position");
  common_scripts\utility::flag_init("move_pres");
  common_scripts\utility::flag_init("agent_in_position");
  common_scripts\utility::flag_init("ready_for_rescue");
  common_scripts\utility::flag_init("door_breach");
  common_scripts\utility::flag_init("tv_video_on");
  common_scripts\utility::flag_init("map_video_on");
  common_scripts\utility::flag_init("tv_off");
  common_scripts\utility::flag_init("kill_movie");
  common_scripts\utility::flag_init("delete_intro_ambient_guys");
  common_scripts\utility::flag_init("debate_starting");
  common_scripts\utility::flag_init("conf_explosion");
  common_scripts\utility::flag_init("kill_hijacker3");
  common_scripts\utility::flag_init("post_debate_vo");
  common_scripts\utility::flag_init("hallway_rumble_02");
  common_scripts\utility::flag_init("stop_constant_shake");
  common_scripts\utility::flag_init("stop_me");
  common_scripts\utility::flag_init("hallsun_right");
  common_scripts\utility::flag_init("hallsun_left");
  common_scripts\utility::flag_init("hallsun_right2");
  common_scripts\utility::flag_init("hallsun_left2");
  common_scripts\utility::flag_init("cmdr_stumbling");
  common_scripts\utility::flag_init("pre_zerog_checkpoint");
  common_scripts\utility::flag_init("go_jets3");
  common_scripts\utility::flag_init("zero_g_done");
  common_scripts\utility::flag_init("gun_ready");
  common_scripts\utility::flag_init("spawn_more_fodder");
  common_scripts\utility::flag_init("plane_roll_right");
  common_scripts\utility::flag_init("plane_roll_left");
  common_scripts\utility::flag_init("plane_third_hit");
  common_scripts\utility::flag_init("plane_levels");
  common_scripts\utility::flag_init("custom_death");
  common_scripts\utility::flag_init("scripted_death");
  common_scripts\utility::flag_init("all_hallway_terrorists_dead");
  common_scripts\utility::flag_init("agent_reached_comm_room");
  common_scripts\utility::flag_init("all_comm_room_terrorists_dead");
  common_scripts\utility::flag_init("cargo_room_commander_move");
  common_scripts\utility::flag_init("cargo_room_wave_a_dead");
  common_scripts\utility::flag_init("all_cargo_room_terrorists_dead");
  common_scripts\utility::flag_init("find_daughter_moment_finished");
  common_scripts\utility::flag_init("kill_cargo");
  common_scripts\utility::flag_init("dining_room_done");
  common_scripts\utility::flag_init("exited_dining_room");
  common_scripts\utility::flag_init("clean_up_dining_room");
  common_scripts\utility::flag_init("commander_finished_find_daughter_anim");
  common_scripts\utility::flag_init("stop_phones");
  common_scripts\utility::flag_init("turn_on_crash_sled_lights");
}

_id_5A5E() {
  level.player disableweapons();
  level._id_5A94 = getDvar("bg_viewBobAmplitudeBase");
  level._id_5A95 = getDvar("bg_viewBobAmplitudeStanding");
  setsaveddvar("bg_viewBobAmplitudeBase", "0.05");
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.014 0.014");
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level._id_58D2 = maps\hijack_code::_id_594A("commander");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor");
  level._id_58BA = maps\hijack_code::_id_594A("president");
  level._id_58CB = maps\hijack_code::_id_594A("hero_agent_01");
  level._id_58CB._id_1032 = "hero_agent";
  level._id_58CB.ignoreme = 1;
  level._id_58CB.ignoreall = 1;
  level._id_58D2 maps\_utility::_id_123B();
  level._id_58CB maps\_utility::_id_123B();
  level._id_58BA maps\_utility::_id_123B();
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  waittillframeend;
  level._id_58D2 maps\_utility::_id_24F5();
  maps\_audio::aud_send_msg("start_airplane");
  thread maps\hijack::_id_5A91();
  thread _id_5A9D();
  thread _id_5119();
  thread _id_5AB2();
  thread _id_5AB3();
  thread _id_5AC1();
  thread _id_5AEE();
  thread _id_5AF3();
  thread _id_5A9C();
  thread _id_5ADF();
  thread maps\hijack::_id_5A17();
}

_id_5A5F() {
  thread maps\hijack_code::_id_595F();
  level._id_5A65 common_scripts\utility::trigger_on();
  level._id_5A66 common_scripts\utility::trigger_on();
  var_0 = common_scripts\utility::getstruct("player_start_debate", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  level._id_5A94 = getDvar("bg_viewBobAmplitudeBase");
  level._id_5A95 = getDvar("bg_viewBobAmplitudeStanding");
  setsaveddvar("bg_viewBobAmplitudeBase", "0.05");
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.014 0.014");
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level.player disableweapons();
  level.player setmovespeedscale(0.35);
  level.player allowsprint(0);
  level._id_58D2 = maps\hijack_code::_id_594A("commander");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor");
  level._id_58BA = maps\hijack_code::_id_594A("president");
  level._id_58CB = maps\hijack_code::_id_594A("hero_agent_01");
  level._id_58CB._id_1032 = "hero_agent";
  level._id_58CB.ignoreme = 1;
  level._id_58CB.ignoreall = 1;
  level._id_5A96 = maps\_utility::_id_272F("secretary");
  level._id_5A96._id_1032 = "secretary";
  level._id_5A96.ignoreme = 1;
  level._id_5A96.ignoreall = 1;
  level._id_5A96 maps\_utility::_id_0D04();
  level._id_58C7 = maps\_utility::_id_272F("polit_1");
  level._id_58C7._id_1032 = "polit_1";
  level._id_58C7.ignoreme = 1;
  level._id_58C7.ignoreall = 1;
  level._id_58C7 maps\_utility::_id_0D04();
  level._id_5A97 = maps\_utility::_id_272F("polit_2");
  level._id_5A97._id_1032 = "polit_2";
  level._id_5A97.ignoreme = 1;
  level._id_5A97.ignoreall = 1;
  level._id_5A97 maps\_utility::_id_0D04();
  level._id_5A98 = maps\_utility::_id_272F("intro_agent1");
  level._id_5A98._id_1032 = "generic";
  level._id_5A98.ignoreme = 1;
  level._id_5A98.ignoreall = 1;
  level._id_58C9 = maps\_utility::_id_272F("intro_agent2");
  level._id_58C9._id_1032 = "generic";
  level._id_58C9.ignoreme = 1;
  level._id_58C9.ignoreall = 1;
  level._id_58C9 maps\_utility::_id_24F5();
  level._id_58D2 maps\_utility::_id_123B();
  level._id_58CB maps\_utility::_id_123B();
  level._id_58BA maps\_utility::_id_123B();
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  maps\_audio::aud_send_msg("debate");
  waittillframeend;
  level._id_58D2 maps\_utility::_id_24F5();
  common_scripts\utility::flag_set("intro_done");
  thread maps\hijack::_id_5A91();
  thread _id_5ABD();
  thread _id_5AB3();
  thread _id_5AC1();
  thread _id_5AEE();
  thread _id_5AF3();
  thread _id_5A9C();
  common_scripts\utility::flag_set("follow_pres");
  common_scripts\utility::flag_set("take_position");
  common_scripts\utility::flag_set("in_guard_position");
  thread maps\hijack::_id_5A17();
  wait 0.2;
  thread _id_5ABB();
}

_id_5A60() {
  var_0 = common_scripts\utility::getstruct("player_start_pre_zero_g", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level._id_58D2 = maps\hijack_code::_id_594A("commander");
  level._id_58BA = maps\hijack_code::_id_594A("president");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor");
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  level._id_59A0 thread maps\_anim::_id_124E(level._id_58C6, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  level._id_58CB = maps\hijack_code::_id_594A("hero_agent_01");
  level._id_58CB._id_1032 = "hero_agent";
  waittillframeend;
  level._id_58C4 = getent("intro_door3", "targetname");
  level._id_58C4 movey(50, 0.1);
  common_scripts\utility::flag_set("pre_zerog_checkpoint");
  common_scripts\utility::flag_set("player_ahead");
  level._id_5A99 = maps\_utility::_id_1287("upperhall_roller", level.player.origin);
  maps\_audio::aud_send_msg("start_pre_zero_g");
  level.player setmovespeedscale(0.85);
  level._id_58D2.goalradius = 16;
  var_1 = getnode("commander_zerog", "targetname");
  level._id_58D2 setgoalnode(var_1);
  thread maps\hijack::_id_5A91();
  thread _id_5AE7();
  thread _id_5AF0();
  thread _id_5AEE();
  thread _id_5AF3();
  thread _id_5A9C();
  common_scripts\utility::flag_set("follow_pres");
  common_scripts\utility::flag_set("take_position");
  common_scripts\utility::flag_set("in_guard_position");
  common_scripts\utility::flag_set("move_pres");
  thread maps\hijack::_id_5A17();
}

_id_5A61() {
  var_0 = common_scripts\utility::getstruct("player_start_lower_level_combat", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level._id_58D2 = maps\hijack_code::_id_594A("commander");
  level._id_58BA = maps\hijack_code::_id_594A("president");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor");
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  level._id_59A0 thread maps\_anim::_id_124E(level._id_58C6, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  level._id_58CB = maps\hijack_code::_id_594A("hero_agent_01");
  level._id_5A87 = maps\hijack_code::_id_594A("zerog_agent_01");
  level._id_5A89 = maps\hijack_code::_id_594A("zerog_agent_02");
  level.player.ignoreme = 0;
  level._id_58D2.ignoreme = 1;
  level._id_58D2.ignoreall = 1;
  level._id_58CB.ignoreme = 0;
  level._id_58CB.ignoreall = 0;
  level.player enableweapons();
  level._id_58C4 = getent("intro_door3", "targetname");
  level._id_58C4 movey(50, 0.1);
  level._id_5A87.ignoreme = 1;
  level._id_5A87.ignoreall = 1;
  level._id_5A89.ignoreme = 1;
  level._id_5A89.ignoreall = 1;
  level._id_5A9A = maps\_utility::_id_272F("zerog_agent_03");
  level._id_5A9A thread maps\_utility::_id_0D04();
  level._id_5A9A maps\hijack_code::_id_45E4();
  level._id_5A9A._id_20AF = 0.1;
  level._id_5A9A.ignoresuppression = 1;
  waittillframeend;
  thread _id_5B18();
  maps\_audio::aud_send_msg("start_lower_level_combat");
  level.player setmovespeedscale(0.85);
  thread maps\hijack::_id_5A91();
  thread _id_5AED();
  thread _id_5B1D();
  thread maps\hijack::_id_5A17();
}

_id_5A9B() {
  maps\_audio::aud_send_msg("rumble");
  earthquake(0.12, 4.5, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_low");
}

_id_5A9C() {
  var_0 = getDvar("objectiveFadeTooFar");
  common_scripts\utility::flag_wait("follow_pres");
  objective_add(maps\_utility::_id_2816("follow_president"), "current", &"HIJACK_FOLLOW_PRES", level._id_58CB.origin);
  objective_onentity(maps\_utility::_id_2816("follow_president"), level._id_58CB, (0, 0, 70));
  setsaveddvar("objectiveFadeTooFar", 1);
  wait 3;
  setsaveddvar("objectiveFadeTooFar", var_0);
  common_scripts\utility::flag_wait("take_position");
  var_1 = common_scripts\utility::getstruct("take_pos", "targetname");
  maps\_utility::_id_2727(maps\_utility::_id_2816("follow_president"));
  objective_add(maps\_utility::_id_2816("take_position"), "current", &"HIJACK_TAKE_POS", var_1.origin);
  common_scripts\utility::flag_wait("in_guard_position");
  maps\_utility::_id_2727(maps\_utility::_id_2816("take_position"));
  common_scripts\utility::flag_wait("move_pres");
  var_2 = common_scripts\utility::getstruct("obj_pres_move", "targetname");
  objective_add(maps\_utility::_id_2816("move_president"), "current", &"HIJACK_MOVE_PRES", var_2.origin);
}

_id_5A9D() {
  var_0 = 18.5;
  level.player freezecontrols(1);
  thread maps\_introscreen::_id_1D97(var_0, 4);
  var_1 = [];
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE1";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE2";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE3";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE4";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE5";
  wait 0.5;
  thread _id_5A9E();
  wait 9;
  maps\_introscreen::_id_1D96(var_1);
  wait 3;
  common_scripts\utility::flag_set("introscreen_done");
}

_id_5A9E() {
  maps\_utility::_id_11F4("hijack_plt_moscow");
  maps\_utility::_id_11F4("hijack_cmd_reportin");
  wait 0.5;
  maps\_utility::_id_11F4("hijack_fso1_presidentoffice");
  wait 0.3;
  maps\_utility::_id_11F4("hijack_fso2_lowerdeckclear");
  wait 0.6;
  maps\_utility::_id_11F4("hijack_fso3_fowardcabin");
  wait 1;
  maps\_utility::_id_11F4("hijack_cmd_landinhamburg");
  wait 0.75;
  maps\_utility::_id_11F4("hijack_cmd_remainwithpres");
}

_id_5119() {
  thread maps\hijack_code::_id_595F();
  thread _id_5AA7();
  thread _id_5AA6();
  thread _id_0116();
  thread _id_0117();
  var_0 = getent("intro_door1", "targetname");
  var_0 movey(50, 0.05);
  var_1 = getent("block_player_from_daughter", "targetname");
  var_1 hide();
  var_1 notsolid();
  level._id_58B5 = maps\_vehicle::_id_2881("mig_1a");
  level._id_58B6 = maps\_vehicle::_id_2881("mig_1b");
  level._id_58B5 maps\_vehicle::_id_2A73();
  level._id_58B6 maps\_vehicle::_id_2A73();
  level._id_58B5 thread _id_0321();
  level._id_58B6 thread _id_0321();
  level._id_58CB maps\_utility::_id_24F5();
  level._id_5A98 = maps\_utility::_id_272F("intro_agent1");
  level._id_5A98._id_1032 = "generic";
  level._id_5A98.ignoreme = 1;
  level._id_5A98.ignoreall = 1;
  level._id_5A9F = maps\_utility::_id_272F("intro_agent3");
  level._id_5A9F._id_1032 = "generic";
  level._id_5A9F.ignoreme = 1;
  level._id_5A9F.ignoreall = 1;
  level._id_5A9F pushplayer(1);
  level._id_5AA0 = maps\_utility::_id_272F("intro_daughter");
  level._id_5AA0._id_1032 = "daughter";
  level._id_5AA0.ignoreme = 1;
  level._id_5AA0.ignoreall = 1;
  level._id_5AA0 maps\_utility::_id_24F5();
  level._id_5AA0 thread _id_5AA1();
  level._id_5AA0 pushplayer(1);
  level._id_58BA pushplayer(1);
  var_2 = maps\_utility::_id_272F("assistant");
  var_2._id_1032 = "assistant";
  var_2.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2 maps\_utility::_id_24F5();
  var_2 thread _id_5AA1();
  var_3 = [];
  var_3[0] = level._id_58BA;
  var_3[2] = var_2;
  thread _id_5AA2();
  common_scripts\utility::flag_wait("introscreen_done");
  thread _id_5AA5();
  common_scripts\utility::flag_set("intro_player_animate");
  level._id_58CB waittillmatch("single anim", "start_daughter");
  level._id_59A0 thread maps\_anim::_id_1246(level._id_5AA0, "intro_scene");
  level._id_59A0 thread _id_5AB1(level._id_5A9F, "intro_cine_agent3", "intro_cine_agent3_loop", "stop_ambguy_loop");
  level._id_58CB waittillmatch("single anim", "start_intro");
  level._id_59A0 thread maps\_anim::_id_11DD(var_3, "intro_scene");
  thread _id_5AAA();
  thread _id_5AAB();
  wait 4.5;
  var_0 movey(-50, 1, 0.25, 0.5);
  maps\_audio::aud_send_msg("intro_door1_open");
  common_scripts\utility::flag_set("start_amb_guys");
  var_4 = getent("block_player_from_daughter_volume", "targetname");
  var_5 = getent("block_player_from_daughter_2", "targetname");

  if(!level.player istouching(var_4)) {
    var_1 show();
    var_1 solid();
  }

  wait 5.9;
  common_scripts\utility::flag_set("follow_pres");
  var_1 hide();
  var_1 notsolid();
  var_5 delete();
  level._id_58BA waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("intro_done");
  level._id_5A65 common_scripts\utility::trigger_on();
  level._id_5A66 common_scripts\utility::trigger_on();

  if(!common_scripts\utility::flag("in_guard_position")) {
    level._id_59A0 thread maps\_anim::_id_124E(level._id_58BA, "intro_cine_president_wait_loop", "stop_intro_loop");
  }
}

_id_0321() {
  self hidepart("front_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("front_wheel_base_jnt", "vehicle_mig29");
  self hidepart("ri_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("ri_wheel_base_jnt", "vehicle_mig29");
  self hidepart("le_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("le_wheel_base_jnt", "vehicle_mig29");
}

_id_5AA1() {
  self waittillmatch("single anim", "end");
  self delete();
}

_id_5AA2() {
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = level.player.angles;
  level.player allowsprint(0);
  level.player playerlinktoabsolute(var_0);
  common_scripts\utility::flag_wait("introscreen_done");
  wait 3;
  level.player setmovespeedscale(0.35);
  level.player freezecontrols(0);
  level.player unlink();
  var_0 delete();
  common_scripts\utility::flag_wait("follow_pres");
  thread _id_5AA4();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
  common_scripts\utility::flag_wait("second_migs");
  level._id_5AA3 = maps\_vehicle::_id_2881("mig_2a");
  level._id_58B8 = maps\_vehicle::_id_2881("mig_2b");
  level._id_5AA3 maps\_vehicle::_id_2A73();
  level._id_58B8 maps\_vehicle::_id_2A73();
  level._id_5AA3 thread _id_0321();
  level._id_58B8 thread _id_0321();
}

_id_5AA4() {
  wait 0.4;
  var_0 = spawn("script_origin", (-29408, 12720, 7312));
  var_0 playSound("hijk_pilot_bell");
  wait 1.6;
  maps\hijack_code::_id_5956("hijack_plt_message1", var_0);
  wait 1.4;
  maps\hijack_code::_id_5956("hijack_plt_message2", var_0);
  wait 1.9;
  maps\hijack_code::_id_5956("hijack_plt_message3", var_0);
  wait 5;
  var_0 delete();
}

_id_5AA5() {
  level._id_59A0 maps\_anim::_id_1246(level._id_58CB, "intro_scene");
  common_scripts\utility::flag_set("agent_in_position");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level._id_59A0 thread maps\_anim::_id_124E(level._id_58CB, "intro_cine_hero_agent_loop", "stop_intro_loop");
  }
}

_id_5AA6() {
  var_0 = getent("intro_door0", "targetname");
  var_0 movey(-52, 0.05);
  wait 0.2;
  var_1 = maps\_utility::_id_1287("door");
  level._id_59A0 thread maps\_anim::_id_11CF(var_1, "intro_cine_presdoor_open");
  var_0 linkto(var_1, "J_prop_1");
  level._id_58CB waittillmatch("single anim", "start_intro");
  level._id_59A0 thread maps\_anim::_id_1246(var_1, "intro_cine_presdoor_open");
  level._id_5AA0 waittillmatch("single anim", "close_door");
}

_id_5AA7() {
  maps\_utility::_id_27CA("ambient_workers", maps\hijack::_id_5A7F);
  var_0 = maps\_utility::_id_272C("ambient_workers");
  var_1 = maps\_utility::_id_2640("ambient_worker1", "script_noteworthy");
  var_2 = maps\_utility::_id_2640("ambient_worker2", "script_noteworthy");
  var_3 = maps\_utility::_id_2640("ambient_worker3", "script_noteworthy");
  var_4 = maps\_utility::_id_2640("ambient_worker4", "script_noteworthy");
  thread _id_5AA8();
  var_5 = getent("ambient_worker_clipboard1", "targetname");
  var_6 = getent("ambient_worker_pencil", "targetname");
  var_7 = maps\_utility::_id_1287("clipboard");
  level._id_59A0 thread maps\_anim::_id_11CF(var_7, "intro_worker_clipboard");
  var_8 = var_7 gettagorigin("J_prop_1");
  var_9 = var_7 gettagangles("J_prop_1");
  var_10 = var_7 gettagorigin("J_prop_2");
  var_11 = var_7 gettagangles("J_prop_2");
  var_5.origin = var_8;
  var_5.angles = var_9;
  var_6.origin = var_10;
  var_6.angles = var_11;
  var_5 linkto(var_7, "J_prop_1");
  var_6 linkto(var_7, "J_prop_2");
  var_12 = getent("ambient_cart", "targetname");
  var_13 = maps\_utility::_id_1287("food_cart");
  level._id_59A0 thread maps\_anim::_id_11CF(var_13, "intro_storage_cart");
  var_12 linkto(var_13, "J_prop_1");
  level._id_59A0 thread maps\_anim::_id_11CF(var_1, "intro_worker_checklist");
  level._id_59A0 thread maps\_anim::_id_11CF(var_2, "intro_storage_guy");
  level._id_59A0 thread maps\_anim::_id_11CF(var_3, "intro_kitchenette_guy1");
  level._id_59A0 thread maps\_anim::_id_11CF(var_4, "intro_kitchenette_guy2");
  var_14 = getent("coffee_stir_stick", "targetname");
  var_15 = var_3 gettagorigin("tag_weapon_right");
  var_16 = var_3 gettagangles("tag_weapon_right");
  var_14.origin = var_15;
  var_14.angles = var_16;
  var_14 linkto(var_3, "tag_weapon_right");
  common_scripts\utility::flag_wait("start_amb_guys");
  thread _id_5AB1(var_1, "intro_worker_checklist", "intro_worker_checklist_loop", "stop_ambguy_loop");
  thread _id_5AB1(var_7, "intro_worker_clipboard", "intro_worker_clipboard_loop", "stop_ambguy_loop");
  thread _id_5AA9(var_2, "intro_storage_guy", "intro_storage_guy_loop", "stop_ambguy_loop");
  level._id_59A0 thread maps\_anim::_id_1246(var_13, "intro_storage_cart");
  maps\_audio::aud_send_msg("hijk_cart_moves");
  wait 7.9;
  wait 5.9;
  thread _id_5AB1(var_3, "intro_kitchenette_guy1", "intro_kitchenette_guy1_loop", "stop_ambguy_loop");
  thread _id_5AB1(var_4, "intro_kitchenette_guy2", "intro_kitchenette_guy2_loop", "stop_ambguy_loop");
  var_4 pushplayer(1);
  maps\_audio::aud_send_msg("hijk_agent_espresso");
  maps\_audio::aud_send_msg("keypad");
  common_scripts\utility::flag_wait("delete_intro_ambient_guys");
  level._id_59A0 notify("stop_ambguy_loop");
  waittillframeend;

  if(isDefined(var_1._id_0D04)) {
    var_1 maps\_utility::_id_1902();
  }
  if(isDefined(var_2._id_0D04)) {
    var_2 maps\_utility::_id_1902();
  }
  if(isDefined(var_3._id_0D04)) {
    var_3 maps\_utility::_id_1902();
  }
  if(isDefined(var_4._id_0D04)) {
    var_4 maps\_utility::_id_1902();
  }
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_7 delete();
  var_12 delete();
  var_13 delete();
  level._id_5A9F delete();
}

_id_5AA8() {
  var_0 = getent("peanuts", "targetname");
  var_1 = getent("candy1", "targetname");
  var_2 = getent("candy2", "targetname");
  var_3 = maps\_utility::_id_1287("food_cart");
  level._id_59A0 thread maps\_anim::_id_11CF(var_3, "intro_storage_peanuts");
  var_4 = maps\_utility::_id_1287("food_cart");
  level._id_59A0 thread maps\_anim::_id_11CF(var_4, "intro_storage_candy");
  waittillframeend;
  var_5 = var_3 gettagorigin("J_prop_1");
  var_6 = var_3 gettagangles("J_prop_1");
  var_7 = var_4 gettagorigin("J_prop_1");
  var_8 = var_4 gettagangles("J_prop_1");
  waittillframeend;
  var_0.origin = var_5;
  var_0.angles = var_6;
  var_1.origin = var_7;
  var_1.angles = var_8;
  var_0 linkto(var_3, "J_prop_1");
  var_1 linkto(var_4, "J_prop_1");
  common_scripts\utility::flag_wait("start_cart_props");
  level._id_59A0 thread maps\_anim::_id_124E(var_3, "intro_storage_peanuts_loop", "stop_ambguy_loop");
  level._id_59A0 thread maps\_anim::_id_124E(var_4, "intro_storage_candy_loop", "stop_ambguy_loop");
  common_scripts\utility::flag_wait("delete_intro_ambient_guys");
  wait 0.05;
  var_0 delete();
  var_3 delete();
  var_1 delete();
  var_2 delete();
  var_4 delete();
}

_id_5AA9(var_0, var_1, var_2, var_3) {
  level._id_59A0 maps\_anim::_id_11CF(var_0, var_1);
  var_4 = getent("candy2", "targetname");
  var_5 = var_0 gettagorigin("TAG_WEAPON_CHEST");
  var_6 = var_0 gettagangles("TAG_WEAPON_CHEST");
  var_4.origin = var_5;
  var_4.angles = var_6;
  var_4 linkto(var_0, "TAG_WEAPON_CHEST");
  level._id_59A0 maps\_anim::_id_1246(var_0, var_1);
  common_scripts\utility::flag_set("start_cart_props");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level._id_59A0 thread maps\_anim::_id_124E(var_0, var_2, var_3);
    common_scripts\utility::flag_wait("debate_starting");
  }
}

_id_5AAA() {
  level._id_5AA0 waittillmatch("single anim", "sub_cliff_ru2_suspicious");
}

_id_0116() {
  level endon("second_migs");
  common_scripts\utility::flag_wait("follow_pres");

  while(!common_scripts\utility::flag("second_migs")) {
    wait 12;
    maps\_utility::_id_11F4("hijack_cmd_staywithpres");
  }
}

_id_0117() {
  level endon("in_guard_position");
  common_scripts\utility::flag_wait("intro_done");

  while(!common_scripts\utility::flag("in_guard_position")) {
    wait 12;
    maps\_utility::_id_11F4("hijack_cmd_takeposition");
  }
}

_id_5AAB() {
  var_0 = getent("pres_book", "targetname");
  var_1 = getent("pres_paper", "targetname");
  var_2 = maps\_utility::_id_1287("binder");
  level._id_59A0 thread maps\_anim::_id_11CF(var_2, "intro_cine_pres_binder");
  var_3 = var_2 gettagorigin("J_prop_1");
  var_4 = var_2 gettagangles("J_prop_1");
  var_5 = var_2 gettagorigin("J_prop_2");
  var_6 = var_2 gettagangles("J_prop_2");
  var_0.origin = var_3;
  var_0.angles = var_4;
  var_1.origin = var_5;
  var_1.angles = var_6;
  var_0 linkto(var_2, "J_prop_1");
  var_1 linkto(var_2, "J_prop_2");
  level._id_59A0 thread maps\_anim::_id_1246(var_2, "intro_cine_pres_binder");
  maps\_audio::aud_send_msg("pres_drops_paper");
  level._id_58BA waittillmatch("single anim", "drop_folder");
}

_id_5AAC(var_0) {
  maps\_audio::aud_send_msg("start_news");
  level._id_59A0 maps\_anim::_id_1246(level._id_5AAD, "intro_door2_assistant_open");
}

_id_5AAE(var_0) {
  level._id_5A96 = maps\_utility::_id_272F("secretary");
  level._id_5A96._id_1032 = "secretary";
  level._id_5A96.ignoreme = 1;
  level._id_5A96.ignoreall = 1;
  level._id_5A96 maps\_utility::_id_0D04();
  level._id_58C7 = maps\_utility::_id_272F("polit_1");
  level._id_58C7._id_1032 = "polit_1";
  level._id_58C7.ignoreme = 1;
  level._id_58C7.ignoreall = 1;
  level._id_58C7 maps\_utility::_id_0D04();
  level._id_5A97 = maps\_utility::_id_272F("polit_2");
  level._id_5A97._id_1032 = "polit_2";
  level._id_5A97.ignoreme = 1;
  level._id_5A97.ignoreall = 1;
  level._id_5A97 maps\_utility::_id_0D04();
  level._id_58C9 = maps\_utility::_id_272F("intro_agent2");
  level._id_58C9._id_1032 = "generic";
  level._id_58C9.ignoreme = 1;
  level._id_58C9.ignoreall = 1;
  level._id_58C9 maps\_utility::_id_24F5();
  level._id_5AAF = getent("conf_phone", "targetname");
  level._id_5AAF._id_1032 = "phone";
  level._id_5AAF maps\_anim::_id_1244();
  thread _id_5ADE();
  level._id_59A0 thread maps\_anim::_id_1246(level._id_5AAF, "debate_phone");
  thread _id_5AB1(level._id_58D2, "intro_cine_commander", "intro_cine_commander_wait_loop", "stop_intro_loop");
  thread _id_5AB1(level._id_58C6, "intro_cine_advisor", "intro_cine_advisor_wait_loop", "stop_intro_loop");
  thread _id_5AB1(level._id_5A96, "intro_cine_secretary", "intro_cine_secretary_wait_loop", "stop_intro_loop");
  var_1 = level._id_5A96 gettagorigin("tag_inhand");
  var_2 = level._id_5A96 gettagangles("tag_inhand");
  level._id_5AB0 = spawn("script_model", var_1);
  level._id_5AB0 setModel("electronics_pda");
  level._id_5AB0.angles = var_2;
  level._id_5AB0 linkto(level._id_5A96, "tag_inhand");
  thread _id_5AB1(level._id_5A98, "intro_cine_agent", "intro_cine_agent_loop", "stop_intro_loop");
  thread _id_5AB1(level._id_58C9, "intro_cine_agent2", "intro_cine_agent2_loop", "stop_intro_loop");
  thread _id_5AB1(level._id_58C7, "intro_cine_politician1", "intro_cine_politician1_loop", "stop_intro_loop");
  thread _id_5ABA();
  thread _id_5AB1(level._id_5A97, "intro_cine_politician2", "intro_cine_politician2_loop", "stop_intro_loop");
  thread _id_5ABD();
  level._id_58BA thread _id_5ABC("chair1", "intro_chair1");
  level._id_58C6 thread _id_5ABC("chair2", "intro_chair2");
  level._id_58D2 thread _id_5ABC("chair3", "intro_chair3");
  level._id_5A96 thread _id_5ABC("chair4", "intro_chair4");
  level._id_58C7 thread _id_5ABC("chair5", "intro_chair5");
  level._id_5A97 thread _id_5ABC("chair6", "intro_chair6");
  var_3 = getent("chair8", "targetname");
  var_3._id_1032 = "conf_chair";
  var_3 maps\_anim::_id_1244();
  level._id_59A0 maps\_anim::_id_11CF(var_3, "debate_chair8");
}

_id_5AB1(var_0, var_1, var_2, var_3) {
  level._id_59A0 maps\_anim::_id_1246(var_0, var_1);

  if(!common_scripts\utility::flag("in_guard_position")) {
    level._id_59A0 thread maps\_anim::_id_124E(var_0, var_2, var_3);
    common_scripts\utility::flag_wait("debate_starting");
  }
}

_id_5AB2() {
  common_scripts\utility::flag_wait("plane_shake1");
  var_0 = randomfloatrange(0.0, 2.0);
  wait(var_0);
  thread _id_5A9B();
}

_id_5AB3() {
  level._id_5AB4 = getent("intro_door1", "targetname");
  level._id_5AB5 = getent("intro_door1_rig", "targetname");
  level._id_5AB5._id_1032 = "door";
  level._id_5AB5 maps\_anim::_id_1244();
  level._id_5AB6 = getent("intro_door2", "targetname");
  level._id_5AAD = getent("intro_door2_rig", "targetname");
  level._id_5AAD._id_1032 = "door";
  level._id_5AAD maps\_anim::_id_1244();
  level._id_58C4 = getent("intro_door3", "targetname");
  level._id_58C4 movey(50, 0.1);
  level._id_5AB7 = getent("intro_door3_rig", "targetname");
  level._id_5AB7._id_1032 = "door";
  level._id_5AB7 maps\_anim::_id_1244();
  level._id_5AB8 = getent("intro_door4", "targetname");
  level._id_5AB8 movey(52, 0.1);
  level._id_5AB9 = getent("intro_door4_rig", "targetname");
  level._id_5AB9._id_1032 = "door";
  level._id_5AB9 maps\_anim::_id_1244();
  wait 0.2;
  level._id_59A0 thread maps\_anim::_id_11CF(level._id_5AAD, "intro_door2_worker_open");
  level._id_5AB6 linkto(level._id_5AAD, "J_prop_1");
  level._id_59A0 thread maps\_anim::_id_11CF(level._id_5AB7, "intro_door3_agent_open");
  level._id_58C4 linkto(level._id_5AB7, "J_prop_1");
  level._id_59A0 thread maps\_anim::_id_11CF(level._id_5AB9, "debate_cine_door4_blown_off");
  level._id_5AB8 linkto(level._id_5AB9, "J_prop_1");
}

_id_5ABA() {
  var_0 = getent("polit1_pitcher", "script_noteworthy");
  var_1 = getent("polit1_glass", "script_noteworthy");
  var_2 = maps\_utility::_id_1287("pitcher");
  waittillframeend;
  level._id_59A0 maps\_anim::_id_11CF(var_2, "intro_cine_pitcher");
  var_0 linkto(var_2, "J_prop_1");
  var_1 linkto(var_2, "J_prop_2");
  level._id_59A0 maps\_anim::_id_1246(var_2, "intro_cine_pitcher");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level._id_59A0 maps\_anim::_id_124E(var_2, "intro_cine_pitcher_loop", "stop_intro_loop");
  }
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

_id_5ABB() {
  common_scripts\utility::flag_wait("in_guard_position");
  level._id_58C4 unlink();
  wait 0.2;
  level._id_58C4 movey(46, 1, 0, 0.25);
  maps\_audio::aud_send_msg("debate_door_close");
  wait 1;

  if(isDefined(level._id_5A98._id_0D04)) {
    level._id_5A98 maps\_utility::_id_1902();
  }
  level._id_5A98 delete();
  common_scripts\utility::flag_set("delete_intro_ambient_guys");
}

_id_5ABC(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2._id_1032 = "conf_chair";
  var_2 maps\_anim::_id_1244();
  level._id_59A0 maps\_anim::_id_11CF(var_2, var_1);
  self waittillmatch("single anim", "swivel_chair");
  level._id_59A0 maps\_anim::_id_1246(var_2, var_1);
}

_id_5ABD() {
  var_0 = getent("chair_destroy_top", "targetname");
  var_1 = getent("chair_destroy_base", "targetname");
  var_2 = maps\_utility::_id_1287("destroy_chair");
  waittillframeend;
  level._id_59A0 maps\_anim::_id_11CF(var_2, "debate_cine_end_chair");
  var_0 linkto(var_2, "J_prop_1");
  var_1 linkto(var_2, "J_prop_2");
  common_scripts\utility::flag_wait("debate_starting");
  level._id_59A0 maps\_anim::_id_1246(var_2, "debate_cine_end_chair");
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

_id_5ABE(var_0) {
  level._id_59A0 maps\_anim::_id_1246(level._id_5AB7, "debate_cine_door3_agent_open");
}

_id_5ABF(var_0) {
  level._id_59A0 maps\_anim::_id_1246(level._id_5AB7, "intro_door3_agent_open");
}

_id_5AC0(var_0) {
  level._id_59A0 maps\_anim::_id_1246(level._id_5AB7, "intro_door3_agent_close");
}

_id_5AC1() {
  common_scripts\utility::flag_wait_all("in_guard_position", "intro_done");
  waittillframeend;
  thread maps\_utility::_id_1425("debate");
  var_0 = [];
  var_0[0] = level._id_58BA;
  var_0[2] = level._id_58C6;
  var_0[3] = level._id_5A96;
  var_0[4] = level._id_58CB;
  var_0[5] = level._id_58C9;
  var_0[6] = level._id_58C7;
  var_0[7] = level._id_5A97;
  level._id_59A0 notify("stop_intro_loop");
  common_scripts\utility::flag_set("debate_starting");
  thread _id_5AC4();
  thread _id_5AC5();
  thread _id_5AC6();
  thread _id_5AC7();
  maps\_audio::aud_send_msg("start_typing");
  level._id_59A0 thread maps\_anim::_id_11DD(var_0, "debate");
  level._id_59A0 thread maps\_anim::_id_1246(level._id_58D2, "debate", undefined, 0.04);
  thread _id_5AE3();
  level._id_58BA thread _id_5ABC("chair1", "debate_chair1");
  level._id_58C6 thread _id_5ABC("chair2", "debate_chair2");
  level._id_58D2 thread _id_5ABC("chair3", "debate_chair3");
  level._id_5A96 thread _id_5ABC("chair4", "debate_chair4");
  level._id_58C7 thread _id_5ABC("chair5", "debate_chair5");
  level._id_5A97 thread _id_5ABC("chair6", "debate_chair6");
  level._id_58C7 thread _id_5ABC("chair8", "debate_chair8");
  level._id_58D2 pushplayer(1);
  level._id_58BA waittillmatch("single anim", "dialogue02");
  level._id_58BA thread maps\_utility::_id_168C("hijack_prs_worldsafe");
  level._id_58BA waittillmatch("single anim", "notify_gunshots");
  maps\_audio::aud_send_msg("conf_room_shots");
  maps\_audio::aud_send_msg("lets_kick_ass");
  thread _id_5AC3();
  thread _id_5ACA();
  thread _id_5ACC();
  wait 0.35;
  level._id_58BA scalevolume(0, 0.2);
  level._id_58BA waittillmatch("single anim", "notify_explosion");
  maps\_audio::aud_send_msg("conf_room_explosion1");
  maps\_audio::aud_send_msg("conf_room_plant_c4");
  thread _id_5ACF();
  thread _id_5AC9();
  level._id_58BA waittillmatch("single anim", "playergun_up");
  thread _id_5AC8();
  level._id_58BA waittillmatch("single anim", "notify_chargeplant");
  common_scripts\utility::flag_set("conf_explosion");
  level._id_5AC2._id_1B71 = 1;
  level._id_58BA waittillmatch("single anim", "notify_hijack");
  thread _id_5AD1();
  thread _id_5AD9();
  thread _id_5ADC();
  thread _id_5ADA();
  thread _id_5ADB();
  thread _id_5AE7();
  thread _id_5AF0();
  level._id_58BA waittillmatch("single anim", "notify_rescue");
}

_id_5AC3() {
  var_0 = getent("hijack_screams", "targetname");
  wait 0.75;
  var_0 playSound("hijack_fem1_scream", "done1");
  var_0 waittill("done1");
  wait 0.5;
  var_0 playSound("hijack_fso1_gungun", "done2");
  var_0 waittill("done2");
  wait 0.1;
  var_0 playSound("hijack_fso1_pain", "done3");
  var_0 waittill("done3");
  wait 0.5;
  var_0 playSound("hijack_fso2_lookout", "done4");
  var_0 waittill("done4");
}

_id_5AC4() {
  level._id_58D2 waittillmatch("single anim", "sub_cliff_ru1_hostact");
  setsaveddvar("bg_viewBobAmplitudeBase", level._id_5A94);
  setsaveddvar("bg_viewBobAmplitudeStanding", level._id_5A95);
  level.player enableweapons();
  level.player allowcrouch(1);
  level._id_58CB maps\_utility::_id_257D();
}

_id_5AC5() {
  level._id_58D2 waittillmatch("single anim", "pistol_pullout");
  level._id_58D2 maps\_utility::_id_257D();
  level._id_58D2 maps\_utility::_id_104A(level._id_58D2.sidearm, "primary");
}

_id_5AC6() {
  level._id_58C9 waittillmatch("single anim", "pistol_pullout");
  level._id_58C9 maps\_utility::_id_257D();
  level._id_58C9 maps\_utility::_id_104A(level._id_58C9.sidearm, "primary");
}

_id_5AC7() {
  level._id_58CB waittillmatch("single anim", "grab_gun");
  level._id_58CB maps\_utility::_id_257D();
}

_id_5AC8() {
  var_0 = getent("door_breach", "targetname");
  var_0 playSound("hijack_hj1_placecharge", "done1");
  var_0 waittill("done1");
  wait 0.2;
  var_0 playSound("hijack_hj2_standback", "done3");
  var_0 waittill("done3");
}

_id_5AC9() {
  maps\_audio::aud_send_msg("rumble");
  earthquake(0.22, 4.5, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_medium");
  thread _id_5AD0();
  maps\_audio::aud_send_msg("seatbeltsign");
  maps\_audio::aud_send_msg("rumble_foley");

  foreach(var_1 in level._id_5A6E) {}
  var_1 show();

  thread _id_5ACB();
  var_3 = getEntArray("conf_room_physics", "targetname");

  foreach(var_5 in var_3) {}
  physicsexplosionsphere(var_5.origin, 64, 32, 0.6);

  var_7 = getEntArray("conf_room_junk", "targetname");

  foreach(var_5 in var_7) {}
  var_5 thread maps\hijack_code::_id_5966(randomintrange(120, 170), (0, -1, 0.05));

  thread _id_5ACE();
  level.player disableweapons();
  var_10 = distance(level.player.origin, level._id_58D2.origin);

  if(var_10 > 50) {
    level._id_27A4 = 1;
    var_11 = (7, 270, 0);
    var_12 = anglesToForward(var_11);
    level.player setvelocity(var_12 * 100);
    level.player maps\hijack_code::_id_595C();
    wait 0.6;
    level.player maps\hijack_code::_id_595E();
  } else {
    wait 0.6;
  }
  setphysicsgravitydir((0, 0, -1));
  wait 1.5;
  level.player enableweapons();
  wait 1;
  thread _id_5AEB();
}

_id_5ACA() {
  wait 8.13;
  level notify("stop_rocking");
  common_scripts\utility::array_thread(level._id_5961, ::_id_5ACD);
  var_0 = maps\_utility::_id_1287("conf_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::_id_11CF(var_0, "debate_cine_lurchcam");
  var_1 linkto(var_0, "J_prop_1");
  var_0 maps\_anim::_id_1246(var_0, "debate_cine_lurchcam");
  level.player playersetgroundreferenceent(level._id_5960);
  thread maps\hijack_code::_id_595F();
  var_1 delete();
  var_0 delete();
}

_id_5ACB() {
  var_0 = getent("debate_laptop", "targetname");
  var_0 delete();
  level._id_5A67 show();
  level._id_5A67._id_1032 = "debate_laptop";
  level._id_5A67 maps\_anim::_id_1244();
  level._id_59A0 thread maps\_anim::_id_1246(level._id_5A67, "debate_laptop_lurch");
  level._id_59A0 thread maps\_anim::_id_1246(level._id_5AAF, "debate_phone1_lurch");
  var_1 = getent("conf_phone2", "targetname");
  var_1._id_1032 = "phone";
  var_1 maps\_anim::_id_1244();
  level._id_59A0 thread maps\_anim::_id_1246(var_1, "debate_phone2_lurch");
  var_2 = getent("conf_room_tablet1", "targetname");
  var_3 = getent("conf_room_tablet2", "targetname");
  var_4 = getent("conf_room_closed_laptop", "targetname");
  var_5 = maps\_utility::_id_1287("debate_prop");
  level._id_59A0 thread maps\_anim::_id_11CF(var_5, "debate_props_frnt_lurch");
  var_6 = maps\_utility::_id_1287("debate_prop");
  level._id_59A0 thread maps\_anim::_id_11CF(var_6, "debate_props_bck_lurch");
  var_7 = var_5 gettagorigin("J_prop_1");
  var_8 = var_5 gettagangles("J_prop_1");
  var_9 = var_5 gettagorigin("J_prop_2");
  var_10 = var_5 gettagangles("J_prop_2");
  var_11 = var_6 gettagorigin("J_prop_1");
  var_12 = var_6 gettagangles("J_prop_1");
  var_4.origin = var_7;
  var_4.angles = var_8;
  var_2.origin = var_9;
  var_2.angles = var_10;
  var_3.origin = var_11;
  var_3.angles = var_12;
  var_4 linkto(var_5, "J_prop_1");
  var_2 linkto(var_5, "J_prop_2");
  var_3 linkto(var_6, "J_prop_1");
  level._id_59A0 thread maps\_anim::_id_1246(var_5, "debate_props_frnt_lurch");
  level._id_59A0 thread maps\_anim::_id_1246(var_6, "debate_props_bck_lurch");
}

_id_5ACC() {
  level endon("conf_explosion");
  wait 7.5;
  level._id_5AC2 = spawn("script_origin", level.player.origin);
  level._id_5AC2 linkto(level.player);
  level._id_5AC2._id_1046 = 1;
  maps\hijack_code::_id_5956("hijack_fso1_needbackup", level._id_5AC2);
  wait 0.7;
  maps\hijack_code::_id_5956("hijack_fso2_gunshots", level._id_5AC2);
  wait 1.1;
  maps\hijack_code::_id_5956("hijack_fso3_weaponsfree", level._id_5AC2);
  wait 0.1;
  maps\hijack_code::_id_5956("hijack_fso2_alert", level._id_5AC2);
}

_id_5ACD() {
  var_0 = maps\_utility::_id_1287("conf_roller", self.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::_id_11CF(var_0, "debate_cine_lurchcam");
  self linkto(var_0, "J_prop_1");
  var_0 maps\_anim::_id_1246(var_0, "debate_cine_lurchcam");
  self unlink();
  var_0 delete();
}

_id_5ACE() {
  var_0 = getEntArray("conf_room_paper", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_3.angles = (-5, 270, 0);
    playFXOnTag(common_scripts\utility::getfx("paper_flutter"), var_3, "tag_origin");
    var_2 delete();
  }

  var_5 = getEntArray("conf_room_paper_pile", "targetname");

  foreach(var_7 in var_5) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_7.origin;
    var_3.angles = (-5, 270, 0);
    playFXOnTag(common_scripts\utility::getfx("paper_pile_flutter"), var_3, "tag_origin");
    var_7 delete();
  }

  common_scripts\utility::flag_wait("door_breach");
  var_9 = getEntArray("conf_room_paper_breach", "targetname");

  foreach(var_11 in var_9) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_11.origin;
    var_3.angles = (-35, 250, 0);
    playFXOnTag(common_scripts\utility::getfx("paper_flutter"), var_3, "tag_origin");
    var_11 delete();
  }
}

_id_5ACF() {
  var_0 = getent("conf_picture", "targetname");
  var_0 maps\_utility::_id_27ED();
  var_1 = var_0._id_1DC9;
  var_2 = 110;
  var_3 = 0.75;
  var_4 = 0.75;

  for(var_5 = 0; var_5 < 13; var_5++) {
    var_1 rotateroll(var_2, var_4, var_4 * 0.333333, var_4 * 0.666667);
    wait(var_4);
    var_2 = -1 * var_2 * var_3;
    var_4 = var_4 * 0.95;
  }

  var_0 unlink();
  common_scripts\utility::flag_wait("door_breach");
  var_0 physicslaunchserver(var_0.origin, (-1, -0.3, 0.05));
}

_id_5AD0() {
  var_0 = getent("conf_room_spot1", "targetname");
  var_1 = getent("conf_room_spot2", "targetname");
  var_2 = getent("conf_light1_on", "script_noteworthy");
  var_3 = getent("conf_light1_off", "script_noteworthy");

  for(var_4 = 0; var_4 < 10; var_4++) {
    var_0 setlightintensity(0);
    var_1 setlightintensity(0);
    var_2 hide();
    var_3 show();
    wait(randomfloatrange(0.05, 0.1));
    var_5 = randomfloatrange(0.5, 1.2);
    var_0 setlightintensity(var_5);
    var_1 setlightintensity(var_5);
    var_2 show();
    var_3 hide();
    wait(randomfloatrange(0.1, 0.2));
  }

  var_0 setlightintensity(1.2);
  var_1 setlightintensity(1.2);
}

_id_5AD1() {
  thread _id_5AD6();
  common_scripts\utility::flag_set("door_breach");
  var_0 = getent("tv_destructor", "targetname");
  var_1 = getent("tv_destructor2", "targetname");
  magicbullet("ak74u", var_0.origin, var_1.origin);
  earthquake(0.3, 5.0, level.player.origin, 6000);
  var_2 = getent("door_breach", "targetname");
  level.player playFX(common_scripts\utility::getfx("conference_room_breach"), var_2.origin, anglesToForward((0, 0, 0)));
  level._id_5AB8 delete();
  var_3 = common_scripts\utility::getStructArray("breach_physics", "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5.radius;
    var_7 = 0.65;
    physicsexplosioncylinder(var_5.origin, var_6, var_6, var_7);
  }

  maps\_audio::aud_send_msg("conf_room_explosion2");
  var_9 = maps\_utility::_id_272F("conf_hijacker1");
  var_9._id_1032 = "generic";
  var_9.ignoreme = 1;
  var_9.ignoreall = 1;
  var_9.allowdeath = 1;
  var_9._id_0EC0 = 1;
  var_9 pushplayer(1);
  var_9 maps\_utility::_id_0D04();
  var_10 = maps\_utility::_id_272F("conf_hijacker2");
  var_10._id_1032 = "generic";
  var_10.ignoreme = 1;
  var_10.ignoreall = 1;
  var_10.allowdeath = 1;
  var_10._id_0EC0 = 1;
  var_10 pushplayer(1);
  var_10 maps\_utility::_id_0D04();
  level._id_5A96 thread _id_5AD7();
  level._id_58C7 thread _id_5AD8("debate_cine_politician1_death_loop");
  level._id_5A97 thread _id_5AD8("debate_cine_politician2_death_loop");
  level._id_59A0 thread maps\_anim::_id_1246(var_9, "debate_cine_hijacker1_breach");
  var_9 thread _id_5AD3();
  var_9 thread _id_5AD7();
  var_9 thread _id_5AD4();
  level._id_59A0 thread maps\_anim::_id_1246(var_10, "debate_cine_hijacker2_breach");
  var_10 thread _id_5AD7();
  var_10 thread _id_5AD5();
  level._id_58D2 thread _id_5AD2(var_9, var_10);
  level._id_58D2 waittillmatch("single anim", "dropgun");
  level._id_58D2.dropweapon = 1;
  level._id_58D2 animscripts\shared::_id_23C8();
  var_11 = maps\_utility::_id_272F("conf_hijacker3");
  var_11 maps\_utility::_id_2718();
  var_11.health = 1;
  var_11._id_0D50 = level._id_0C59["generic"]["stand_death_shoulder_spin"];
  level._id_58D2 waittillmatch("single anim", "swap_guns");
  level._id_58D2 maps\_utility::_id_104A("ak74u", "primary");
  level._id_58D2._id_1005 = level._id_58D2.weapon;
  var_9 maps\_utility::_id_24F5();
  var_9 waittillmatch("single anim", "pistol_pullout");
  var_9 maps\_utility::_id_104A("fnfiveseven", "primary");
  var_9 maps\_shg_common::_id_16B4(var_9.primaryweapon);
  common_scripts\utility::flag_wait("kill_hijacker3");
  var_12 = getent("door_breach", "targetname");
  var_13 = common_scripts\utility::getstruct("bullet_behind", "targetname");

  if(isalive(var_11)) {
    if(maps\_utility::_id_1FBD(var_12.origin)) {
      magicbullet("ak74u", var_13.origin, var_11.origin + (0, 0, 42));
    } else {
      magicbullet("ak74u", var_12.origin, var_11.origin + (0, 0, 42));
    }
  }
}

_id_5AD2(var_0, var_1) {
  var_2 = common_scripts\utility::getfx("flesh_hit_body_fatal_exit");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_0, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_2, var_0, "tag_weapon_chest");
}

_id_5AD3() {
  var_0 = common_scripts\utility::getfx("flesh_hit_body_fatal_exit");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level._id_58C7, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level._id_5A96, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level._id_58C6, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level._id_5A97, "tag_weapon_chest");
}

#using_animtree("generic_human");

_id_5AD4() {
  var_0 = % hijack_debate_cine_hijacker1_breach;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "start_ragdoll")[0];
  var_3 = var_1 * var_2;
  wait(var_3 - 0.1);
  animscripts\shared::_id_23C8();
}

_id_5AD5() {
  var_0 = % hijack_debate_cine_hijacker2_breach;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "start_ragdoll")[0];
  var_3 = var_1 * var_2;
  wait(var_3 - 0.5);
  animscripts\shared::_id_23C8();
  common_scripts\utility::flag_set("kill_hijacker3");
}

_id_5AD6() {
  common_scripts\utility::flag_clear("player_away_from_door");
  wait 0.05;
  var_0 = common_scripts\utility::getstruct("player_slide_location", "targetname");
  var_0.origin = (var_0.origin[0], var_0.origin[1], level.player.origin[2]);
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player shellshock("hijack_door_explosion", 5);
  level.player disableweapons();
  level.player freezecontrols(1);
  var_1 = maps\_utility::_id_1287("player_rig", level.player.origin);
  var_1.angles = level.player.angles;
  level.player playerlinkto(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 thread maps\_anim::_id_1246(var_1, "debate_react_player");
  wait 0.05;

  if(common_scripts\utility::flag("player_away_from_door")) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_1 linkto(var_2);
    var_2 moveto((-28436, 12728, level.player.origin[2]), 0.25, 0, 0.1);
  }

  var_1 waittillmatch("single anim", "end");
  level.player freezecontrols(0);
  level.player unlink();
  var_1 delete();
  wait 1.3;
  level.player enableweapons();
  level.player maps\_utility::_id_279B(0.85, 5);
  level.player allowcrouch(1);
  level.player allowprone(1);
  thread _id_0118();
}

_id_5AD7() {
  self endon("death");
  self._id_0EC6 = 1;
  self.a._id_0D55 = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self waittillmatch("single anim", "start_ragdoll");

  if(isDefined(self._id_0D04)) {
    maps\_utility::_id_1902();
  }
  self kill();
}

_id_5AD8(var_0) {
  self endon("death");
  self._id_0EC6 = 1;
  self.a._id_0D55 = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self waittillmatch("single anim", "end");

  if(isDefined(self._id_0D04)) {
    maps\_utility::_id_1902();
  }
  level._id_59A0 thread maps\_anim::_id_124E(self, var_0);
  self invisiblenotsolid();
}

_id_5AD9() {
  level._id_58C6 waittillmatch("single anim", "end");
  level._id_59A0 thread maps\_anim::_id_124E(level._id_58C6, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
}

_id_5ADA() {
  level endon("zero_g_trig");
  level._id_58BA waittillmatch("single anim", "end");
  level._id_59A0 thread maps\_anim::_id_124E(level._id_58BA, "debate_cine_president_end_loop", "stop_pres_debate_loop");
}

_id_5ADB() {
  level endon("zero_g_trig");
  level._id_58CB waittillmatch("single anim", "end");
  level._id_59A0 thread maps\_anim::_id_124E(level._id_58CB, "debate_cine_hero_agent_end_loop", "stop_pres_debate_loop");
}

_id_5ADC() {
  level endon("zero_g_trig");
  level._id_58C9 waittillmatch("single anim", "end");

  if(isalive(level._id_58C9) && isDefined(level._id_58C9)) {
    level._id_59A0 thread maps\_anim::_id_124E(level._id_58C9, "debate_cine_agent2_end_loop", "stop_debate_loop");
  }
}

_id_5ADD() {
  wait 7.25;
  maps\_utility::_id_11F4("hijack_fso2_resistance");
  wait 0.5;
  maps\_audio::aud_send_msg("failing_engine");
  wait 1;
  maps\_utility::_id_11F4("hijack_plt_losingcontrol");
  wait 1.1;
  maps\_utility::_id_11F4("hijack_plt_stalled");
}

_id_5ADE() {
  level._id_5A96 waittillmatch("single anim", "trigger_tv");
  common_scripts\utility::flag_set("tv_off");
  maps\_audio::aud_send_msg("stop_news");
  stopcinematicingame();
  level._id_5A96 waittillmatch("single anim", "drop_remote");
  level._id_5AB0 unlink();
  thread _id_5ABB();
}

_id_5ADF() {
  wait 1;
  setsaveddvar("cg_cinematicFullScreen", "0");
  thread _id_5AE0();

  for(;;) {
    common_scripts\utility::flag_clear("tv_video_on");
    common_scripts\utility::flag_wait("tv_video_on");
    thread _id_5AE1();
    common_scripts\utility::flag_clear("map_video_on");
    common_scripts\utility::flag_wait("map_video_on");
    thread _id_5AE0();
  }
}

_id_5AE0() {
  wait 0.05;
  level endon("tv_video_on");
  setsaveddvar("cg_cinematicFullScreen", "0");

  for(;;) {
    _id_5AE2(0);
  }
}

_id_5AE1() {
  wait 0.05;
  level endon("tv_off");
  level endon("map_video_on");

  if(common_scripts\utility::flag("tv_off")) {
    stopcinematicingame();
    common_scripts\utility::flag_set("kill_movie");
    wait 0.05;
    common_scripts\utility::flag_clear("kill_movie");
    return;
  }

  setsaveddvar("cg_cinematicFullScreen", "0");

  for(;;) {
    _id_5AE2(1);
  }
}

_id_5AE2(var_0) {
  level endon("tv_off");
  level endon("kill_movie");

  for(;;) {
    switch (var_0) {
      case 0:
        cinematicingame("hijack_map_black");
        wait 0.05;

        while(iscinematicplaying()) {
          wait 0.05;
        }
        break;
      case 1:
        cinematicingame("ny_manhattan_tvanamorphic");
        wait 0.05;

        while(iscinematicplaying()) {
          wait 0.05;
        }
        break;
      default:
        break;
    }
  }
}

_id_5AE3() {
  thread _id_5AE4();
  level._id_58D2 maps\_utility::_id_109B();
  level._id_58D2._id_1199 = 1;
  var_0 = % hijack_debate_cine_commander;
  var_1 = getanimlength(var_0);
  wait(var_1 - 5);
  maps\_audio::aud_send_msg("pre_turbulence_ready");
  common_scripts\utility::flag_clear("hero_agent_stumble");
  common_scripts\utility::flag_set("move_pres");
  maps\_utility::_id_265B("axis");
  level._id_58CB maps\_utility::_id_2688();
  level._id_58BA maps\_utility::_id_2688();
  level._id_58D2.turnrate = 0.1;
  level._id_58D2._id_0F9F = 1;
  level._id_58D2 allowedstances("stand");
  level._id_58D2._id_48BC = 1;

  if(!common_scripts\utility::flag("hero_agent_stumble")) {
    var_2 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
    var_2 maps\_anim::_id_124A(level._id_58D2, "hero_stumble");
  }

  thread maps\_utility::_id_1425("conference_room_breached");
  common_scripts\utility::flag_wait("hero_agent_stumble");
  thread _id_5ADD();
  level._id_58D2._id_1199 = 0;
  level._id_58D2.turnrate = 0.3;
  level._id_59A0 notify("stop_corner_loop");
  waittillframeend;
  var_2 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  var_2 maps\_anim::_id_124A(level._id_58D2, "hero_stumble");
  level._id_58D2.goalradius = 16;
  var_3 = getnode("commander_zerog", "targetname");
  level._id_58D2 setgoalnode(var_3);
  level._id_58D2._id_0F9F = undefined;

  if(!common_scripts\utility::flag("player_ahead")) {
    common_scripts\utility::flag_set("cmdr_stumbling");
    var_2 thread maps\_anim::_id_1248(level._id_58D2, "hero_stumble");
    maps\_audio::aud_send_msg("hijk_agent_stumblehit");
  }

  level._id_58D2 allowedstances("stand", "crouch");
  level._id_58D2._id_48BC = undefined;
}

_id_0118() {
  level endon("hero_agent_stumble");

  while(!common_scripts\utility::flag("hero_agent_stumble")) {
    wait 12;
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_onme");
  }
}

_id_5AE4() {
  common_scripts\utility::flag_wait("go_jets3");
  wait 2;
  level._id_5AE5 = maps\_vehicle::_id_2881("mig_3a");
  level._id_5AE6 = maps\_vehicle::_id_2881("mig_3b");
  level._id_5AE5 maps\_vehicle::_id_2A73();
  level._id_5AE6 maps\_vehicle::_id_2A73();
  level._id_5AE5 thread _id_0321();
  level._id_5AE6 thread _id_0321();
}

_id_5AE7() {
  level._id_5A99 = maps\_utility::_id_1287("upperhall_roller", level.player.origin);
  level._id_5A99.angles = (0, 0, 0);
  common_scripts\utility::flag_wait_any("player_ahead", "cmdr_stumbling");
  level notify("stop_rocking");
  thread _id_5AEC();
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_0);
  thread maps\hijack_code::_id_4B52(var_0);
  level._id_5A99 maps\_anim::_id_11CF(level._id_5A99, "hallway_lurchcam");
  var_0 linkto(level._id_5A99, "J_prop_1");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    maps\_audio::aud_send_msg("hallway_lurch", 1);
    level.player playrumbleonentity("hijack_plane_medium");
    level._id_5A99 thread maps\_anim::_id_1246(level._id_5A99, "hallway_lurchcam");
    level._id_5A99 waittillmatch("single anim", "corpse_slump");
    thread _id_5AE9();
    thread _id_5AEA();
    common_scripts\utility::array_thread(level._id_5961, ::_id_5AE8);
    level._id_5A99 waittillmatch("single anim", "end");
  }

  level notify("stop_rocking");

  if(!common_scripts\utility::flag("zero_g_trig")) {
    maps\_audio::aud_send_msg("rumble");
    level._id_5A99 maps\_anim::_id_124E(level._id_5A99, "hallway_lurchcam_loop", "stop_hallway_shake");
  }

  var_0 delete();
  level._id_5A99 delete();
}

_id_5AE8() {
  var_0 = maps\_utility::_id_1287("upperhall_roller", self.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::_id_11CF(var_0, "hallway_godraycam");
  self linkto(var_0, "J_prop_1");
  var_0 thread maps\_anim::_id_1246(var_0, "hallway_godraycam");
  var_0 waittillmatch("single anim", "roll_right");
  common_scripts\utility::flag_set("hallsun_right");
  var_0 waittillmatch("single anim", "roll_left");
  common_scripts\utility::flag_set("hallsun_left");
  var_0 waittillmatch("single anim", "roll_right2");
  common_scripts\utility::flag_set("hallsun_right2");
  var_0 waittillmatch("single anim", "roll_left2");
  common_scripts\utility::flag_set("hallsun_left2");
  var_0 waittillmatch("single anim", "end");
  self unlink();
  var_0 delete();
}

_id_5AE9() {
  lerpsunangles(level._id_5A6C, (-38.8, 121.9, 16.7), 1.5, 0, 0.2);
  common_scripts\utility::flag_wait("hallsun_right");
  lerpsunangles((-38.8, 121.9, 16.7), (-9.9, 113.4, -2.2), 1.7, 0.3, 0.2);
  common_scripts\utility::flag_wait("hallsun_left");
  lerpsunangles((-9.9, 113.4, -2.2), (-17.5, 114.6, 2), 0.8, 0.1, 0.1);
  common_scripts\utility::flag_wait("hallsun_right2");
  lerpsunangles((-17.5, 114.6, 2), (-13.5, 114, -0.5), 0.7, 0.1, 0.1);
  common_scripts\utility::flag_wait("hallsun_left2");
  lerpsunangles((-13.5, 114, -0.5), level._id_5A6C, 0.25, 0, 0.1);
  common_scripts\utility::flag_clear("hallsun_right");
  common_scripts\utility::flag_clear("hallsun_left");
  common_scripts\utility::flag_clear("hallsun_right2");
  common_scripts\utility::flag_clear("hallsun_left2");
}

_id_5AEA() {
  wait 1.25;
  var_0 = (0, 90, 0);
  var_1 = anglesToForward(var_0);
  level.player setvelocity(var_1 * 100);
  level.player maps\hijack_code::_id_595C();
  wait 1.5;
  level.player maps\hijack_code::_id_595E();
}

_id_5AEB() {
  var_0 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  var_1 = getent("hallway_floor_painting", "targetname");
  var_2 = maps\_utility::_id_1287("upperhall_cabinet");
  waittillframeend;
  var_0 thread maps\_anim::_id_11CF(var_2, "hallway_picture_fall");
  var_3 = var_2 gettagorigin("J_prop_2");
  var_4 = var_2 gettagangles("J_prop_2");
  var_5 = -1 * var_4[0];
  var_6 = 180 + var_4[1];
  var_4 = (var_5, var_6, var_4[2]);
  var_1.origin = var_3;
  var_1.angles = var_4;
  var_1 linkto(var_2, "J_prop_2");
  common_scripts\utility::flag_wait_any("player_ahead", "cmdr_stumbling");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    var_0 maps\_anim::_id_1246(var_2, "hallway_picture_fall");
    var_0 maps\_anim::_id_11D0(var_2, "hallway_picture_fall");
  }

  common_scripts\utility::flag_wait("zero_g_trig");
  var_2 delete();
}

_id_5AEC() {
  var_0 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  var_1 = getent("hallway_cabinet_door", "targetname");
  var_2 = maps\_utility::_id_1287("upperhall_cabinet", var_1.origin);
  var_2.angles = (0, 0, 0);
  waittillframeend;
  var_0 thread maps\_anim::_id_11CF(var_2, "hallway_cabinet_open");
  var_1 linkto(var_2, "J_prop_1");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    var_0 maps\_anim::_id_1246(var_2, "hallway_cabinet_open");
  }
  var_0 maps\_anim::_id_124E(var_2, "hallway_cabinet_loop", "end_cabinet_loop");
  common_scripts\utility::flag_wait("zero_g_trig");
  level notify("end_cabinet_loop");
  var_2 delete();
}

_id_5AED() {
  level endon("stop_constant_shake");

  for(;;) {
    earthquake(0.09, 0.05, level.player.origin, 200);
    wait 0.05;
  }
}

_id_5AEE() {
  common_scripts\utility::flag_wait("cansee_zerog_room");

  if(isDefined(level._id_58C9)) {
    level._id_58C9 maps\_utility::_id_104A("ak74u", "primary");
  }
  var_0 = maps\_utility::_id_272F("dying_agent1");
  var_0._id_1032 = "generic";
  var_0 maps\_utility::_id_24F5();
  var_0.health = 1;
  var_0.ignoreexplosionevents = 1;
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0.ignorerandombulletdamage = 1;
  var_0.grenadeawareness = 0;
  var_0._id_0D16 = 1;
  var_0._id_0EC6 = 1;
  var_0.a._id_0D55 = 1;
  maps\_utility::_id_282D(var_0, "pre_zerog_guys");
  var_0 maps\_utility::_id_261D(var_0.angles[1], 2, level._id_0C59["crawl_death_1"], 1);
  var_0 dodamage(1, var_0.origin + (16, 0, 16));

  if(isDefined(level._id_5A87)) {
    level._id_5A87 thread maps\hijack::_id_5A7C();
  }
  if(isDefined(level._id_5A89)) {
    level._id_5A89 thread maps\hijack::_id_5A7C();
  }
  if(isDefined(level._id_5A9A)) {
    level._id_5A9A thread maps\hijack::_id_5A7C();
  }
}

_id_5AEF(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  self.allowdeath = 1;
  self._id_1032 = "generic";
  self.health = 1;
  self._id_0EC6 = 1;
  self._id_0D16 = 1;
  self.diequietly = 1;
  self.a._id_0D55 = 1;
  self.delete_on_death = 0;
  self._id_5950 = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self._id_0F9F = 1;
  maps\_utility::_id_24F5();
  maps\hijack_code::_id_45E4();
  self invisiblenotsolid();
  var_2 thread maps\_anim::_id_124E(self, var_0, "dead_guys_loop");
  level._id_5A99 waittillmatch("single anim", "corpse_slump");
  var_2 maps\_anim::_id_1246(self, var_1);
  self kill();
}

_id_5AF0() {
  var_0 = maps\_utility::_id_272F("dead_assistant");
  var_0 thread _id_5AEF("hallway_dead_pose_assistant", "hallway_slump_assistant");
  var_1 = maps\_utility::_id_272F("dead_agent");
  var_1 thread _id_5AEF("hallway_dead_pose_agent", "hallway_slump_agent");
  var_2 = maps\_utility::_id_272F("dead_terrorist");
  var_2 thread _id_5AEF("hallway_dead_pose_terrorist", "hallway_slump_terrorist");
  level._id_58CB.ignoreme = 1;
  level._id_58CB.ignoreall = 1;
  level._id_5A87 = maps\hijack_code::_id_594A("zerog_agent_01");
  level._id_5A89 = maps\hijack_code::_id_594A("zerog_agent_02");
  var_3 = getnode("agent1_prezero_cover2", "targetname");
  level._id_5A87 setgoalnode(var_3);
  var_4 = getnode("agent2_prezero_cover2", "targetname");
  level._id_5A89 setgoalnode(var_4);
  level._id_5A9A = maps\_utility::_id_272F("zerog_agent_03");
  level._id_5A9A thread maps\_utility::_id_0D04();
  level._id_5A9A maps\hijack_code::_id_45E4();
  level._id_5A9A.script_pushable = 0;
  level._id_5A9A._id_20AF = 0.1;
  level._id_5A9A.ignoresuppression = 1;
  var_5 = getnode("agent3_prezero_cover", "targetname");
  level._id_5A9A setgoalnode(var_5);
  var_6 = getent("pre_zerog_spawn", "targetname");
  var_6 useby(level.player);
  common_scripts\utility::flag_wait("cansee_zerog_room");
  thread maps\_utility::_id_2738();
  level._id_58CB allowedstances("crouch", "stand", "prone");
  level._id_5AF1 = maps\_utility::_id_2641("pre_zerog_terrorists", "script_noteworthy");
  common_scripts\utility::array_thread(level._id_5AF1, ::_id_5AF2);
  common_scripts\utility::flag_wait("prezerog_extra_guys");
  var_7 = maps\_utility::_id_272F("pre_zerog_terrorist_wave2");
  level._id_5AF1 = maps\_utility::_id_2641("pre_zerog_terrorists", "script_noteworthy");
}

_id_5AF2() {
  thread _id_5B3F("stop_me");
  common_scripts\utility::flag_wait("stop_me");
  wait 0.5;

  if(isalive(self)) {
    maps\_utility::_id_1902();
  }
}

_id_5AF3() {
  level._id_5AF4 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  common_scripts\utility::flag_wait("zero_g_trig");
  var_0 = randomfloatrange(0.25, 0.75);
  wait(var_0);
  level.player disableweapons();
  wait 0.25;
  level notify("stop_rocking");
  common_scripts\utility::flag_set("stop_constant_shake");
  level._id_5A99 notify("stop_hallway_shake");
  maps\_audio::aud_send_msg("zero_g_start");
  thread _id_5AF7();
  thread _id_5AF5();
  thread _id_5AF8();
  thread _id_5B03();
  thread _id_5B0C();
  wait 0.5;
  setsaveddvar("phys_gravityChangeWakeupRadius", 3200);
  setsaveddvar("ragdoll_max_life", 3600000);
}

_id_5AF5() {
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player enabledeathshield(1);

  if(level.console) {
    setsaveddvar("aim_aimAssistRangeScale", "1");
    setsaveddvar("aim_autoAimRangeScale", "0");
  }

  level.player enableslowaim(0.4, 0.4);
  var_0 = level.player getweaponslistall();
  var_1 = level.player getcurrentweapon();

  if(var_1 == "ak74u") {
    var_2 = level.player getweaponammoclip("ak74u");
    var_3 = level.player getweaponammostock("ak74u");
    level.player takeweapon("ak74u");
    level.player giveweapon("ak74u_zero_g");
    level.player switchtoweapon("ak74u_zero_g");
    level.player setweaponammoclip("ak74u_zero_g", var_2);
    level.player setweaponammostock("ak74u_zero_g", var_3);
  } else if(var_1 == "fnfiveseven") {
    var_4 = level.player getweaponammoclip("fnfiveseven");
    var_5 = level.player getweaponammostock("fnfiveseven");
    level.player takeweapon("fnfiveseven");
    level.player giveweapon("fnfiveseven_zero_g");
    level.player switchtoweapon("fnfiveseven_zero_g");
    level.player setweaponammoclip("fnfiveseven_zero_g", var_4);
    level.player setweaponammostock("fnfiveseven_zero_g", var_5);
  }

  waittillframeend;
  var_0 = level.player getweaponslistall();
  var_1 = level.player getcurrentweapon();

  foreach(var_7 in var_0) {
    if(var_7 == "ak74u") {
      var_8 = level.player getweaponammoclip("ak74u");
      var_9 = level.player getweaponammostock("ak74u");
      level.player takeweapon("ak74u");
      level.player giveweapon("ak74u_zero_g");
      level.player setweaponammoclip("ak74u_zero_g", var_8);
      level.player setweaponammostock("ak74u_zero_g", var_9);
      continue;
    }

    if(var_7 == "fnfiveseven") {
      var_8 = level.player getweaponammoclip("fnfiveseven");
      var_9 = level.player getweaponammostock("fnfiveseven");
      level.player takeweapon("fnfiveseven");
      level.player giveweapon("fnfiveseven_zero_g");
      level.player setweaponammoclip("fnfiveseven_zero_g", var_8);
      level.player setweaponammostock("fnfiveseven_zero_g", var_9);
    }
  }

  level._id_5AF6 = maps\_utility::_id_1287("test_body", level._id_5AF4.origin);
  level.player playersetgroundreferenceent(level._id_5AF6);
  level.player playerlinktoblend(level._id_5AF6, "tag_origin", 0.5, 0, 0);
  level._id_5AF4 thread maps\_anim::_id_1246(level._id_5AF6, "zero_g_player");
  var_11 = % hijack_zero_g_player;
  var_12 = getanimlength(var_11);
  var_13 = getnotetracktimes(var_11, "player_hit_floor")[0];
  var_14 = var_12 * var_13;
  wait 0.5;
  wait 1;
  var_15 = getEntArray("pre_zerog_terrorists", "script_noteworthy");

  foreach(var_17 in var_15) {}
  var_17 delete();

  wait(var_14 - 2.5);
  level.player playerlinktoblend(level._id_5AF6, "tag_origin", 1, 0, 0);
  level._id_5AF6 waittillmatch("single anim", "player_hit_floor");
  setsaveddvar("phys_gravityChangeWakeupRadius", level._id_5A6A);
  setsaveddvar("ragdoll_max_life", level._id_5A6B);
  level.player disableweapons();
  level.player shellshock("hijack_airplane", 3.0);
  level.player playersetgroundreferenceent(level._id_5960);
  maps\_audio::aud_send_msg("zero_g_bodyslam1");
  level.player thread maps\_utility::play_sound_on_entity("hijk_explosion_lfe");
  level.player.ignoreme = 0;
  earthquake(0.5, 2.0, level.player.origin, 6000);

  if(level.console) {
    setsaveddvar("aim_aimAssistRangeScale", "1");
    setsaveddvar("aim_autoAimRangeScale", "1");
  }

  level.player disableslowaim();
  level.player enabledeathshield(0);
  level.player disableinvulnerability();
  level._id_5AF6 waittillmatch("single anim", "end");
  var_0 = level.player getweaponslistall();
  var_1 = level.player getcurrentweapon();

  if(var_1 == "ak74u_zero_g") {
    var_2 = level.player getweaponammoclip("ak74u_zero_g");
    var_3 = level.player getweaponammostock("ak74u_zero_g");
    level.player takeweapon("ak74u_zero_g");
    level.player giveweapon("ak74u");
    level.player switchtoweapon("ak74u");
    level.player setweaponammoclip("ak74u", var_2);
    level.player setweaponammostock("ak74u", var_3);
  } else if(var_1 == "fnfiveseven_zero_g") {
    var_4 = level.player getweaponammoclip("fnfiveseven_zero_g");
    var_5 = level.player getweaponammostock("fnfiveseven_zero_g");
    level.player takeweapon("fnfiveseven_zero_g");
    level.player giveweapon("fnfiveseven");
    level.player switchtoweapon("fnfiveseven");
    level.player setweaponammoclip("fnfiveseven", var_4);
    level.player setweaponammostock("fnfiveseven", var_5);
  }

  waittillframeend;
  var_0 = level.player getweaponslistall();
  var_1 = level.player getcurrentweapon();

  foreach(var_7 in var_0) {
    if(var_7 == "ak74u_zero_g") {
      var_8 = level.player getweaponammoclip("ak74u_zero_g");
      var_9 = level.player getweaponammostock("ak74u_zero_g");
      level.player takeweapon("ak74u_zero_g");
      level.player giveweapon("ak74u");
      level.player setweaponammoclip("ak74u", var_8);
      level.player setweaponammostock("ak74u", var_9);
      continue;
    }

    if(var_7 == "fnfiveseven_zero_g") {
      var_8 = level.player getweaponammoclip("fnfiveseven_zero_g");
      var_9 = level.player getweaponammostock("fnfiveseven_zero_g");
      level.player takeweapon("fnfiveseven_zero_g");
      level.player giveweapon("fnfiveseven");
      level.player setweaponammoclip("fnfiveseven", var_8);
      level.player setweaponammostock("fnfiveseven", var_9);
      continue;
    }

    if(var_7 == "pp90m1") {
      level.player takeweapon("ak74u_zero_g");
    }
  }

  var_21 = getEntArray("weapon_ak74u_zero_g", "classname");

  foreach(var_23 in var_21) {}
  var_23 delete();

  thread _id_5B07();
  thread _id_5AED();
  level.player unlink();
  level._id_5AF6 delete();
  level.player enableweapons();
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  wait 2;
  maps\_utility::_id_1C43();
}

_id_5AF7() {
  level._id_5AF1 = maps\_utility::_id_2641("pre_zerog_terrorists", "script_noteworthy");

  foreach(var_1 in level._id_5AF1) {
    if(isDefined(var_1._id_0D04)) {
      var_1 maps\_utility::_id_1902();
    }
    var_1 kill(level._id_5A9A.origin, level._id_5A9A);
  }

  level._id_59A0 notify("stop_debate_loop");
  wait 0.5;

  if(isalive(level._id_5A96) && isDefined(level._id_5A96)) {
    if(isDefined(level._id_5A96._id_0D04)) {
      level._id_5A96 maps\_utility::_id_1902();
    }
    level._id_5A96 delete();
  }

  if(isalive(level._id_58C9) && isDefined(level._id_58C9)) {
    if(isDefined(level._id_58C9._id_0D04)) {
      level._id_58C9 maps\_utility::_id_1902();
    }
    level._id_58C9 delete();
  }

  if(isalive(level._id_58C7) && isDefined(level._id_58C7)) {
    if(isDefined(level._id_58C7._id_0D04)) {
      level._id_58C7 maps\_utility::_id_1902();
    }
    level._id_58C7 delete();
  }

  if(isalive(level._id_5A97) && isDefined(level._id_5A97)) {
    if(isDefined(level._id_5A97._id_0D04)) {
      level._id_5A97 maps\_utility::_id_1902();
    }
    level._id_5A97 delete();
  }

  level._id_58D2 maps\_utility::_id_123B();
  level._id_58CB maps\_utility::_id_123B();
  level._id_58BA maps\_utility::_id_123B();
  level._id_58D2 hide();
  level._id_5A9A hide();
  level._id_58BA hide();
  level._id_58CB hide();
  level._id_59A0 notify("stop_pres_debate_loop");

  if(isDefined(level._id_282E) && isDefined(level._id_282E["pre_zerog_guys"])) {
    maps\_utility::_id_282E("pre_zerog_guys");
  }
  maps\_utility::_id_265A("axis");
}

_id_5AF8() {
  level._id_5AF9 = maps\_utility::_id_272C("zerog_terrorists");
  common_scripts\utility::array_thread(level._id_5AF9, ::_id_5AFA);
  var_0 = maps\_utility::_id_2640("zerog_terrorist1", "script_noteworthy");
  var_1 = maps\_utility::_id_2640("zerog_terrorist2", "script_noteworthy");
  var_2 = maps\_utility::_id_2640("zerog_terrorist3", "script_noteworthy");
  var_3 = maps\_utility::_id_2640("zerog_terrorist4", "script_noteworthy");
  var_4 = maps\_utility::_id_2640("zerog_terrorist5", "script_noteworthy");
  var_0 thread _id_5AFB("zerog_terror1_track", "zerog_terrorist_01_align", %hijack_zerog_terrorist_01_alive, %hijack_zerog_terrorist_01_dead);
  var_1 thread _id_5AFB("zerog_terror2_track", "zerog_terrorist_02_align", %hijack_zerog_terrorist_02_alive, %hijack_zerog_terrorist_02_dead);
  var_2 thread _id_5AFB("zerog_terror3_track", "zerog_terrorist_03_align", %hijack_zerog_terrorist_03_alive, %hijack_zerog_terrorist_03_dead);
  var_3 thread _id_5AFB("zerog_terror4_track", "zerog_terrorist_04_align", %hijack_zerog_terrorist_04_alive, %hijack_zerog_terrorist_04_dead);
  var_4 thread _id_5AFB("zerog_terror5_track", "zerog_terrorist_05_align", %hijack_zerog_terrorist_05_alive, %hijack_zerog_terrorist_05_dead);
  level._id_5AF4 thread maps\_anim::_id_1246(level._id_5A87, "zerog_moment");
  level._id_5AF4 thread maps\_anim::_id_1246(level._id_5A89, "zerog_moment");
  wait 0.1;
  level._id_5A87._id_20AF = 100;
  level._id_5A87.ignoreall = 1;
  level._id_5A89._id_20AF = 100;
  level._id_5A89.ignoreall = 1;
  thread _id_5B18();
}

_id_5AFA() {
  thread maps\hijack_code::_id_45E4();
  self._id_1032 = self.script_noteworthy;
  self.ignoreme = 1;
  maps\_utility::_id_1057();
}

_id_5AFB(var_0, var_1, var_2, var_3) {
  thread _id_0119();
  self._id_5AFC = var_2;
  self._id_5AFD = var_3;
  var_4 = maps\_utility::_id_1287(var_0);
  self._id_5AFE = var_4;
  self._id_5AFF = var_1;
  level._id_5AF4 thread maps\_anim::_id_11CF(var_4, var_1);

  if(self._id_1032 == "zerog_terrorist4" || self._id_1032 == "zerog_terrorist5") {
    self forceteleport(var_4.origin, var_4.angles);
  } else {
    self forceteleport(var_4.origin, var_4.angles + (0, -90, 0));
  }
  self linkto(var_4, "J_prop_1");
  level._id_5AF4 thread maps\_anim::_id_1246(var_4, var_1);
  self animcustom(::_id_5B00);
  self._id_0D45 = ::_id_5B01;
}

_id_0119() {
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_0) || var_0 != level.player) {
    return;
  }
  if(!isDefined(level.player._id_0119)) {
    level.player._id_0119 = 1;
  } else {
    level.player._id_0119++;
  }
  if(level.player._id_0119 == 5) {
    level.player maps\_utility::_id_1E39("FLIGHT_ATTENDANT");
  }
}

_id_5B00() {
  var_0 = "single anim";
  self clearanim(%root, 0.1);
  self setflaggedanim(var_0, self._id_5AFC, 1);
  thread maps\_anim::_id_0C61(self, var_0, self._id_5AFC, self._id_1032);
  thread maps\_anim::_id_0C62(self, var_0, self._id_5AFC);

  if(self._id_1032 == "zerog_terrorist3") {
    thread _id_5B1A();
  } else if(self._id_1032 != "zerog_terrorist4") {
    thread _id_5B02(self._id_5AFC);
  }
  self waittill("death");
}

_id_5B01(var_0, var_1) {
  self endon("scripted_death");
  common_scripts\utility::flag_set("custom_death");
  var_2 = "single anim";
  animscripts\shared::_id_23C8();
  var_3 = randomintrange(0, 5);

  if(var_3 == level._id_58B1) {
    var_3 = var_3 + 1;

    if(var_3 == 5) {
      var_3 = 0;
    }
  }

  level._id_58B1 = var_3;

  switch (var_3) {
    case 0:
      self playSound("hijk_zg_death_01");
      break;
    case 1:
      self playSound("hijk_zg_death_02");
      break;
    case 2:
      self playSound("hijk_zg_death_03");
      break;
    case 3:
      self playSound("hijk_zg_death_04");
      break;
    case 4:
      self playSound("hijk_zg_death_05");
      break;
    default:
      break;
  }

  var_4 = self getanimtime(self._id_5AFC);
  self clearanim(self._id_5AFC, 0.2);
  self setflaggedanim(var_2, self._id_5AFD, 1);
  thread maps\_anim::_id_0C61(self, var_2, self._id_5AFD, self._id_1032);
  thread maps\_anim::_id_0C62(self, var_2, self._id_5AFD);
  self setanimtime(self._id_5AFD, var_4);
  self setanimlimited(%zero_g_shot, 0.95, 0);
  wait 1.0;
  self clearanim(%zero_g_shot, 0.5);

  if(self._id_1032 == "zerog_terrorist3") {
    self waittillmatch("single anim", "unlink");
    var_5 = self getanimtime(self._id_5AFD);
    var_0 = [];
    var_0[0] = self._id_5AFE;
    level._id_5AF4 maps\_anim::_id_11CF(self._id_5AFE, self._id_5AFF);
    level._id_5AF4 maps\_anim::_id_127F(var_0, self._id_5AFF, var_5);
  }
}

_id_5B02(var_0) {
  self endon("custom_death");
  self waittillmatch("single anim", "zero_g_die");
  common_scripts\utility::flag_set("scripted_death");

  if(!isalive(self)) {
    return;
  }
  self._id_0D45 = undefined;
  self.forceragdollimmediate = 0;
  self.a._id_0D55 = 1;
  animscripts\shared::_id_23C8();
  wait 0.05;
  self kill();
}

_id_5B03() {
  thread _id_5B04();
  var_0 = getent("luggage01", "script_noteworthy");
  var_1 = getent("luggage02", "script_noteworthy");
  var_2 = getent("luggage03", "script_noteworthy");
  var_3 = getent("luggage04", "script_noteworthy");
  var_4 = getent("luggage05", "script_noteworthy");
  var_5 = getent("luggage06", "script_noteworthy");
  var_6 = getent("luggage07", "script_noteworthy");
  var_7 = getent("luggage08", "script_noteworthy");
  var_8 = getent("zerog_box01", "script_noteworthy");
  var_9 = getent("zerog_box02", "script_noteworthy");
  var_10 = getent("overhead_door_r", "targetname");
  var_11 = getent("overhead_door_l_1", "targetname");
  var_12 = getent("overhead_door_l_2", "targetname");
  var_13 = getent("foodcart", "targetname");
  var_14 = getent("zerog_laptop", "targetname");
  var_15 = getent("air_mask_module_r", "targetname");
  var_16 = getent("air_mask_module_l", "targetname");
  var_0 thread _id_5B08("zerog_suitcase1");
  var_1 thread _id_5B08("zerog_suitcase2");
  var_2 thread _id_5B08("zerog_suitcase3");
  var_3 thread _id_5B08("zerog_suitcase4");
  var_4 thread _id_5B08("zerog_suitcase5");
  var_5 thread _id_5B08("zerog_suitcase6");
  var_6 thread _id_5B08("zerog_suitcase7");
  var_7 thread _id_5B08("zerog_suitcase8");
  var_8 thread _id_5B08("zerog_squarebox");
  var_9 thread _id_5B08("zerog_rectanglebox");
  var_10 thread _id_5B0B("zerog_overhead_door_r");
  var_13 thread _id_5B08("zerog_mealcart");
  var_14 thread _id_5B0A("zerog_laptop", "zerog_laptop");
  var_15 thread _id_5B0A("zerog_o2_module", "zerog_o2_module_r");
  var_16 thread _id_5B0A("zerog_o2_module", "zerog_o2_module_l");
  var_17 = maps\_utility::_id_1287("zerog_prop");
  var_17 setModel("generic_prop_raven");
  var_17 maps\_anim::_id_1244();
  waittillframeend;
  level._id_5AF4 thread maps\_anim::_id_11CF(var_17, "zerog_overhead_door_l");
  var_11 linkto(var_17, "J_prop_1");
  var_12 linkto(var_17, "J_prop_2");
  common_scripts\utility::flag_wait("zero_g_trig");
  level._id_5AF4 thread maps\_anim::_id_1246(var_17, "zerog_overhead_door_l");
  common_scripts\utility::flag_wait("plane_third_hit");
  wait 0.5;
  var_8 dodamage(var_8.health + 100, var_8.origin);
  wait 0.2;
  var_9 dodamage(var_9.health + 100, var_9.origin);
}

#using_animtree("animated_props");

_id_5B04() {
  level._id_5B05 = common_scripts\utility::getstruct("extra_door_left", "targetname");
  level._id_5B06 = common_scripts\utility::getstruct("extra_door_right", "targetname");
  var_0 = getent("overhead_door_r_2", "targetname");
  var_1 = getent("overhead_door_l_3", "targetname");
  var_2 = getent("zerog_box03", "script_noteworthy");
  var_2 setCanDamage(1);
  var_3 = maps\_utility::_id_1287("zerog_prop");
  var_3 setModel("generic_prop_raven");
  var_3 maps\_anim::_id_1244();
  waittillframeend;
  var_4 = maps\_utility::_id_1287("zerog_prop");
  var_4 setModel("generic_prop_raven");
  var_4 maps\_anim::_id_1244();
  var_5 = maps\_utility::_id_1287("zerog_prop");
  var_5 setModel("generic_prop_raven");
  var_5 maps\_anim::_id_1244();
  waittillframeend;
  level._id_5B05 thread maps\_anim::_id_11CF(var_4, "zerog_overhead_door_l");
  var_1 linkto(var_4, "J_prop_2");
  level._id_5B05 thread maps\_anim::_id_11CF(var_3, "zerog_rectanglebox");
  var_2 linkto(var_3, "J_prop_1");
  level._id_5B06 thread maps\_anim::_id_11CF(var_5, "zerog_overhead_door_r");
  var_0 linkto(var_5, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  wait 1.75;
  level._id_5B05 thread maps\_anim::_id_1246(var_4, "zerog_overhead_door_l");
  var_4 setanimtime(%hijack_zerog_overhead_door_l, 0.65);
  level._id_5B05 thread maps\_anim::_id_1246(var_3, "zerog_rectanglebox");
  var_3 setanimtime(%hijack_zerog_rectanglebox, 0.65);
  wait 0.2;
  level._id_5B06 thread maps\_anim::_id_1246(var_5, "zerog_overhead_door_r");
  wait 0.3;
  var_2 dodamage(var_2.health + 100, var_2.origin);
}

_id_5B07() {
  var_0 = common_scripts\_destructible_types::getinfoindex("toy_luggage_01");

  if(var_0 > -1) {
    level.destructible_type[var_0].parts[0][0].v["fx_filename"][0][0] = "props/luggage_1_des";
    level.destructible_type[var_0].parts[0][0].v["fx"][0][0] = common_scripts\utility::getfx("luggage_1_des");
  }

  var_0 = common_scripts\_destructible_types::getinfoindex("toy_luggage_02");

  if(var_0 > -1) {
    level.destructible_type[var_0].parts[0][0].v["fx_filename"][0][0] = "props/luggage_2_des";
    level.destructible_type[var_0].parts[0][0].v["fx"][0][0] = common_scripts\utility::getfx("luggage_2_des");
  }

  var_0 = common_scripts\_destructible_types::getinfoindex("toy_luggage_03");

  if(var_0 > -1) {
    level.destructible_type[var_0].parts[0][0].v["fx_filename"][0][0] = "props/luggage_3_des";
    level.destructible_type[var_0].parts[0][0].v["fx"][0][0] = common_scripts\utility::getfx("luggage_3_des");
  }

  var_0 = common_scripts\_destructible_types::getinfoindex("toy_luggage_04");

  if(var_0 > -1) {
    level.destructible_type[var_0].parts[0][0].v["fx_filename"][0][0] = "props/luggage_4_des";
    level.destructible_type[var_0].parts[0][0].v["fx"][0][0] = common_scripts\utility::getfx("luggage_4_des");
  }
}

_id_5B08(var_0) {
  self setCanDamage(1);
  var_1 = maps\_utility::_id_1287("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::_id_1244();
  waittillframeend;
  level._id_5AF4 thread maps\_anim::_id_11CF(var_1, var_0);
  self linkto(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level._id_5AF4 maps\_anim::_id_1246(var_1, var_0);
  waittillframeend;
  var_1 delete();
}

_id_5B09(var_0) {
  self.health = 5;
  self setCanDamage(1);
  var_1 = maps\_utility::_id_1287("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::_id_1244();
  waittillframeend;
  level._id_5AF4 thread maps\_anim::_id_11CF(var_1, var_0);
  self linkto(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level._id_5AF4 thread maps\_anim::_id_1246(var_1, var_0);
  self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_1 stopanimscripted();
  self unlink();
  self physicslaunchclient(var_5, var_4);
  var_1 delete();
}

_id_5B0A(var_0, var_1) {
  self._id_1032 = var_0;
  maps\_anim::_id_1244();
  level._id_5AF4 thread maps\_anim::_id_11CF(self, var_1);
  common_scripts\utility::flag_wait("zero_g_trig");
  level._id_5AF4 maps\_anim::_id_1246(self, var_1);
}

_id_5B0B(var_0) {
  var_1 = maps\_utility::_id_1287("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::_id_1244();
  waittillframeend;
  level._id_5AF4 thread maps\_anim::_id_11CF(var_1, var_0);
  self linkto(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level._id_5AF4 maps\_anim::_id_1246(var_1, var_0);
}

_id_5B0C() {
  level endon("zero_g_done");

  for(;;) {
    physicsjitter((-27290, 12784, 7340), 500, 450, 0.1, 0.2);
    wait 0.05;
  }
}

_id_5B0D() {
  level endon("zero_g_done");

  for(;;) {
    physicsexplosionsphere(level.player.origin, 64, 32, 0.01);
    wait 0.05;
  }
}

_id_5B0E(var_0) {
  level.player playrumbleonentity("hijack_plane_large");
  level.player disableweapons();
  earthquake(0.15, 0.6, level.player.origin, 6000);
  level.player shellshock("hijack_minor", 1.5);
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (0, 0, 12), 1, 0, 0);
  lerpsunangles((-5, 114, 0), (-24, 96, 0), 1);
  wait 0.4;
  var_1 = getEntArray("zerog_physics", "targetname");

  foreach(var_3 in var_1) {}
  physicsexplosionsphere(var_3.origin, 64, 32, 0.45);

  wait 0.3;
  setphysicsgravitydir((0, 0, -0.02));
  maps\_audio::aud_send_msg("zero_g_bodyslam2");
  wait 0.7;
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (0, 0, 0), 0.75, 0, 0);
  setphysicsgravitydir((0, -0.02, -1));
}

_id_5B0F(var_0) {
  level endon("plane_roll_right");
  objective_delete(maps\_utility::_id_2816("move_president"));
  thread _id_5B0D();
  setphysicsgravitydir((0.02, -0.01, 0.08));
  setsaveddvar("phys_gravity", -5);
  setsaveddvar("phys_gravity_ragdoll", -100);
  wait 2.0;
  thread maps\_utility::_id_11F4("hijack_plt_inadive");
  wait 0.5;
  level.player playerlinktodelta(level._id_5AF6, "tag_origin", 1, 180, 180, 60, 60);
  level.player enableweapons();
}

_id_5B10(var_0) {
  level.player enableinvulnerability();
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (-35, 0, 0), 4, 0, 2);
  lerpsunangles((-24, 96, 0), (-11, 60, 0), 3);
  wait 1.75;
  setphysicsgravitydir((0.03, 0, 0.05));
  wait 3.6;
  thread maps\_utility::_id_11F4("hijack_plt_losingaltitude");
}

_id_5B11(var_0) {
  earthquake(0.25, 1.5, level.player.origin, 6000);
  level.player shellshock("hijack_airplane", 2.5);
  maps\_audio::aud_send_msg("zero_g_bodyslam3");
  wait 2.5;
}

_id_5B12(var_0) {
  level.player disableinvulnerability();
  level endon("plane_roll_left");
  common_scripts\utility::flag_set("plane_roll_right");
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (-35, 0, -20), 3, 1, 1);
  lerpsunangles((-11, 60, 0), (2, 95, 0), 5);
  setphysicsgravitydir((0, -0.01, 0.01));
}

_id_5B13(var_0) {
  earthquake(0.45, 2.0, level.player.origin, 6000);
  level.player thread maps\_utility::play_sound_on_entity("hijk_zero_g_bigshake");
}

_id_5B14(var_0) {
  level endon("plane_levels");
  common_scripts\utility::flag_set("plane_roll_left");
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (15, 0, 15), 2.75, 0, 0.25);
  lerpsunangles((2, 95, 0), (-23, 65, 0), 3.75);
  setphysicsgravitydir((-0.02, 0.03, 0.01));
}

_id_5B15(var_0) {
  level.player enableinvulnerability();
  common_scripts\utility::flag_set("plane_third_hit");
  earthquake(0.25, 2.0, level.player.origin, 6000);
  setphysicsgravitydir((0, 0, 0));
  level.player shellshock("hijack_airplane", 2.5);
  level.player disableweapons();
  maps\_audio::aud_send_msg("zero_g_bodyslam4");
  wait 2.5;
  level.player enableweapons();
}

_id_5B16(var_0) {
  common_scripts\utility::flag_set("plane_levels");
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (0, 0, 0), 3, 0, 0);
  lerpsunangles((-23, 65, 0), level._id_5A6C, 5, 0, 1);
  setphysicsgravitydir((0, 0, -1));
  setsaveddvar("phys_gravity", level._id_5A68);
  setsaveddvar("phys_gravity_ragdoll", level._id_5A69);
  var_1 = (-27290, 12784, 7340);
  physicsjitter(var_1, 500, 450, 0.1, 0.2, 1);
  physicsjolt(var_1, 500, 450, (0, 0, -0.05));
  _id_5B17(var_1, 500, (0, 0, -0.05));
  maps\_audio::aud_send_msg("zero_g_debris_crash");
}

_id_5B17(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = getEntArray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isDefined(var_6.classname)) {
      var_7 = var_0 - var_6.origin;

      if(getsubstr(var_6.classname, 0, 7) == "weapon_" && lengthsquared(var_7) <= var_3) {
        if(var_6.classname != "weapon_mp412") {
          var_6 physicslaunchserveritem(var_6.origin, var_2);
        }
      }
    }
  }
}

_id_5B18() {
  if(level._id_1F19 != "lower_level_combat") {
    level._id_5A89 waittillmatch("single anim", "end");
  }
  level._id_5A87.ignoreme = 1;
  level._id_5A87.ignoreall = 1;
  level._id_5A87.fixednode = 1;
  level._id_5A87.goalradius = 16;
  level._id_5A87 maps\_utility::_id_109B();
  level._id_5A87 pushplayer(1);
  level._id_5A89.ignoreme = 1;
  level._id_5A89.ignoreall = 1;
  level._id_5A89.fixednode = 1;
  level._id_5A89.goalradius = 16;
  level._id_5A89 maps\_utility::_id_109B();
  level._id_5A89 pushplayer(1);

  if(isDefined(level._id_5A9A)) {
    var_0 = getnode("agent3_postzero_node1", "targetname");
    level._id_5A9A.goalradius = 16;
    level._id_5A9A maps\_utility::_id_109B();
    level._id_5A9A setgoalnode(var_0);
  }

  var_1 = getnode("zerog_agent2_end_node", "targetname");
  level._id_5A89 setgoalnode(var_1);
  wait 0.2;
  var_2 = getnode("zerog_agent1_end_node", "targetname");
  level._id_5A87 setgoalnode(var_2);
  level._id_5A87 waittill("goal");

  if(isDefined(level._id_5A9A)) {
    var_0 = getnode("agent1_prezero_cover2", "targetname");
    level._id_5A9A setgoalnode(var_0);
  }

  var_3 = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  level._id_5B19 = getent("fire_extinguisher", "targetname");
  var_4 = maps\_utility::_id_1287("zerog_prop");
  var_4 setModel("generic_prop_raven");
  var_4 maps\_anim::_id_1244();
  waittillframeend;
  var_3 thread maps\_anim::_id_11CF(var_4, "fire_extinguisher_enter");
  level._id_5B19 linkto(var_4, "J_prop_1");
  var_3 thread maps\_anim::_id_1246(var_4, "fire_extinguisher_enter");
  var_3 maps\_anim::_id_1246(level._id_5A87, "cockpit_door_bash_enter");

  if(isDefined(level._id_5A87) && isalive(level._id_5A87)) {
    var_3 thread maps\_anim::_id_124E(var_4, "fire_extinguisher_loop");
    level._id_5A87 thread maps\hijack_code::_id_5957("true");
    var_3 maps\_anim::_id_124E(level._id_5A87, "cockpit_door_bash_loop", "end_cockpit_loop");
  }
}

#using_animtree("generic_human");

_id_5B1A() {
  var_0 = % hijack_zerog_terrorist_03_alive;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "cue_hero_agent")[0];
  var_3 = var_1 * var_2;
  thread _id_5B1B(var_3);
  wait(var_3);
  level._id_58D2 show();
  level._id_5A9A show();
  level._id_58BA show();
  level._id_58CB show();
  level._id_58D2 maps\_utility::_id_27A1(getnode("teleport_hero_agent", "targetname"));
  level._id_58D2 thread maps\_utility::_id_168C("hijack_cmd_retakecockpit");

  if(isalive(self)) {
    self.forceragdollimmediate = 0;
    self.a._id_0D55 = 1;
    level._id_5AF4 maps\_anim::_id_1246(level._id_58D2, "zerog_hero_agent");
  } else {
    level._id_5AF4 maps\_anim::_id_1246(level._id_58D2, "zerog_commander_alt");
  }
  common_scripts\utility::flag_set("zero_g_done");
  thread _id_5B1C();
}

_id_5B1B(var_0) {
  self endon("death");
  wait(var_0 * 0.98);
  animscripts\shared::_id_23C8();
}

_id_5B1C() {
  common_scripts\utility::flag_wait("zero_g_done");
  thread _id_5B1D();
}

_id_5B1D() {
  level._id_58CB.goalradius = 16;
  level._id_58CB.goalheight = 24;
  level._id_58CB maps\_utility::_id_1057();
  level._id_58CB.ignoresuppression = 1;
  level._id_58CB.ignoreme = 1;
  level._id_58CB.ignoreall = 1;
  level._id_58CB.fixednode = 1;
  level._id_58CB._id_1032 = "generic";
  level._id_58D2.goalradius = 16;
  level._id_58D2.goalheight = 24;
  level._id_58D2 maps\_utility::_id_1057();
  level._id_58D2.ignoresuppression = 1;
  level._id_58D2.ignoreme = 0;
  level._id_58D2.ignoreall = 0;
  level._id_58D2.fixednode = 0;
  level._id_58D2 maps\_utility::_id_109B();
  level._id_58D2._id_20AF = 0.1;
  thread _id_5B21();
  thread _id_5B1E();
  thread _id_5B1F();
  var_0 = getnode("commander_top_of_stairs", "targetname");
  level._id_58CB.goalradius = 32;
  level._id_58CB setgoalnode(var_0);
  var_1 = getnode("president_top_of_stairs", "targetname");
  level._id_58BA.goalradius = 32;
  level._id_58BA setgoalnode(var_1);
}

_id_5B1E() {
  maps\_utility::_id_11F4("hijack_fso3_theyhave");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_backuponway");
  common_scripts\utility::flag_wait("spawn_second_room_first_wave");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_additionalhijack");
  common_scripts\utility::flag_wait("move_president_to_first_room");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_protectpres");
  level._id_58CB maps\_utility::_id_168C("hijack_fso1_thiswaysir");
  wait 1.75;
  maps\_utility::_id_11F4("hijack_fso2_retake");

  if(common_scripts\utility::flag("dining_room_done")) {
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_roomclear");
  }
  common_scripts\utility::flag_wait("move_president_to_second_room_start");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_headdown");
  wait 0.5;

  if(common_scripts\utility::flag("dining_room_done")) {
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_roomclear");
  }
  common_scripts\utility::flag_wait("spawn_hallway_terrorists_1");
  maps\_utility::_id_11F4("hijack_fso2_jammedshut");
  common_scripts\utility::flag_wait("lower_level_rumble_hallway");
  level._id_58CB maps\_utility::_id_168C("hijack_fso1_keepmoving");
  common_scripts\utility::flag_wait("spawn_comm_room_terrorists");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_keeppushing");
  common_scripts\utility::flag_wait("move_president_to_hallway");
  maps\_utility::_id_11F4("hijack_fso2_drivenback");
  wait 0.75;
  level._id_58CB maps\_utility::_id_168C("hijack_fso1_staywithgroup");
  common_scripts\utility::flag_wait("move_president_to_comm_room");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_prestosaferoom");
  wait 0.4;
  level._id_58CB maps\_utility::_id_168C("hijack_fso1_keepgoing");
}

_id_5B1F() {
  var_0 = getEntArray("hanging_phone", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_5B20);
}

_id_5B20() {
  self._id_1032 = "hanging_phone";
  maps\_anim::_id_1244();
  wait(randomfloatrange(0.0, 0.8));
  thread maps\_anim::_id_124E(self, "phone_swaying", "stop_phones");
  common_scripts\utility::flag_wait("stop_phones");
  self notify("stop_phones");
  self stopanimscripted();
  self delete();
}

_id_5B21() {
  common_scripts\utility::flag_clear("player_moving_downstairs");
  maps\_utility::_id_265B("axis");
  thread _id_5B2F();
  thread _id_5B41();
  thread _id_5B40();
  thread _id_5B35();
  thread _id_5B2E();
  thread _id_5B2A();
  thread _id_5B29();
  thread _id_5B46();
  thread _id_5B25();
  thread _id_5B3B();
  thread _id_5B22();
  thread _id_5B23();
  thread _id_5B3E("runner_1");
  thread _id_5B3E("runner_2");
  common_scripts\utility::flag_wait("spawn_second_room_first_wave");
  var_0 = maps\_utility::_id_27CA("second_room_terrorists_1", ::_id_5B24);
  var_0 = maps\_utility::_id_272C("second_room_terrorists_1");

  foreach(var_2 in level._id_4BAB) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  thread maps\hijack_code::_id_596C(var_0, var_0.size - 1, "spawn_second_room_second_wave");
  thread _id_5B2B();
  common_scripts\utility::flag_wait("spawn_second_room_second_wave");
  var_4 = maps\_utility::_id_27CA("second_room_terrorists_2", ::_id_5B24);
  var_4 = maps\_utility::_id_272C("second_room_terrorists_2");
  thread maps\hijack_code::_id_596C(var_4, var_4.size, "dining_room_done");
  common_scripts\utility::flag_wait("dining_room_done");
  level._id_58D2.ignoresuppression = 0;
  thread _id_5B26();
  thread maps\hijack_crash_fx::_id_597E();
}

_id_5B22() {
  common_scripts\utility::flag_wait("spawn_hallway_terrorists_1");
  var_0 = maps\_utility::_id_272C("hallway_terrorists_1");
  thread maps\hijack_code::_id_596C(var_0, var_0.size, "all_hallway_terrorists_dead");
  common_scripts\utility::flag_set("exited_dining_room");
  level._id_5AC2._id_1B71 = 1;
}

_id_5B23() {
  common_scripts\utility::flag_wait_any("all_hallway_terrorists_dead", "spawn_comm_room_terrorists");
  thread _id_5B2C();
  thread _id_5B45();
  common_scripts\utility::flag_wait("spawn_comm_room_terrorists");
  var_0 = maps\_utility::_id_272C("comm_room_terrorists");
  thread maps\hijack_code::_id_596C(var_0, var_0.size, "all_comm_room_terrorists_dead");
  var_1 = maps\_utility::_id_2640("comm_runner", "script_noteworthy");
  var_2 = randomintrange(0, 1);

  if(var_2 == 0) {
    var_3 = getnode("comm_runner_left", "targetname");
    var_1 setgoalnode(var_3);
  } else {
    var_3 = getnode("comm_runner_right", "targetname");
    var_1 setgoalnode(var_3);
  }

  var_4 = maps\_utility::_id_272C("cargo_room_terrorists_a");
  thread maps\hijack_code::_id_596C(var_4, 1, "cargo_room_commander_move");
  thread maps\hijack_code::_id_596C(var_4, 3, "cargo_room_wave_a_dead");
  common_scripts\utility::flag_wait("all_comm_room_terrorists_dead");
  maps\hijack_code::_id_594C("comm_room_clear_ally_position");
  common_scripts\utility::flag_wait("find_daughter_moment_finished");
  thread maps\hijack_crash::_id_5A1A();
  common_scripts\utility::flag_wait("player_is_in_end_room");
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  maps\_spawner::_id_213C(100);
  thread maps\hijack_crash::_id_5A1F();
}

_id_5B24() {
  common_scripts\utility::flag_wait("clean_up_dining_room");

  if(isDefined(self) && isalive(self)) {
    self.diequietly = 1;
    self kill();
  }
}

_id_5B25() {
  var_0 = getEntArray("commander_color_trig_1", "script_noteworthy");
  maps\hijack_code::_id_594D(var_0, "trigger");

  foreach(var_2 in var_0) {}
  var_2 common_scripts\utility::trigger_off();

  var_4 = getEntArray("hallway_clear_ally_position", "targetname");
  maps\hijack_code::_id_594D(var_4, "trigger");

  foreach(var_2 in var_4) {}
  var_2 common_scripts\utility::trigger_off();
}

_id_5B26() {
  _id_5B27();
  common_scripts\utility::flag_wait("lower_level_rumble_room_2");
  maps\hijack_code::_id_594C("room_2_clear_ally_position");
}

_id_5B27() {
  var_0 = getent("dining_room_covering_trig", "targetname");
  var_1 = getEntArray("terrorist", "script_noteworthy");
  var_2 = -1;

  while(var_2 != 0) {
    var_2 = 0;
    var_3 = var_0 maps\_utility::_id_2789();

    foreach(var_5 in var_3) {
      if(isenemyteam(level.player.team, var_5.team)) {
        var_2++;
      }
    }

    wait 0.25;
  }
}

_id_5B28() {}

_id_5B29() {
  level._id_58D2.ignoreme = 1;
  level._id_58D2.ignoreall = 1;
  var_0 = getnode("commander_to_bottom_level", "targetname");
  level._id_58D2 setgoalnode(var_0);
  level._id_58D2 waittill("goal");
  level._id_58D2.ignoreme = 0;
  level._id_58D2.ignoreall = 0;
  level._id_58D2.ignoresuppression = 1;
  level._id_58D2.allowpain = 0;
  common_scripts\utility::flag_wait("move_commander_to_first_node");

  if(isDefined(level._id_58D2)) {
    level._id_58D2 maps\_utility::_id_2688();
    var_1 = randomfloatrange(0, 1);

    if(var_1 < 0.5) {
      var_2 = getnode("bottom_stairs_left", "targetname");
      level._id_58D2 setgoalnode(var_2);
      common_scripts\utility::flag_wait("move_commander_to_second_node");
      var_3 = getnode("first_room_left", "targetname");
      level._id_58D2 setgoalnode(var_3);
      level._id_58D2.allowpain = 1;
    } else {
      var_4 = getnode("bottom_stairs_right", "targetname");
      level._id_58D2 setgoalnode(var_4);
      common_scripts\utility::flag_wait("move_commander_to_second_node");
      var_5 = getnode("first_room_right", "targetname");
      level._id_58D2 setgoalnode(var_5);
      level._id_58D2.allowpain = 1;
    }
  }
}

_id_5B2A() {
  var_0 = maps\_utility::_id_272C("lower_level_dead_allies");

  foreach(var_2 in var_0) {
    var_2.diequietly = 1;
    var_2.delete_on_death = 0;
    var_2 kill();
  }
}

_id_5B2B() {
  level endon("exited_dining_room");
  level._id_5AC2 = spawn("script_origin", level.player.origin);
  level._id_5AC2 linkto(level.player);
  level._id_5AC2._id_1046 = 1;
  maps\hijack_code::_id_5956("hijack_fso1_sitrep", level._id_5AC2);
  wait 0.3;
  maps\hijack_code::_id_5956("hijack_fso1_shotsfired", level._id_5AC2);
  wait 0.75;
  maps\hijack_code::_id_5956("hijack_fso2_altered", level._id_5AC2);
  wait 0.1;
}

_id_5B2C() {
  level._id_5B2D = spawn("script_origin", (-28228, 12674, 7172));
  maps\hijack_code::_id_5956("hijack_fc1_descended", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc2_kgbandfso", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc1_squawking", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc2_heading", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc1_scrambling", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc2_doyoucopy", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc1_notresponding", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc2_rapidrate", level._id_5B2D);
  maps\hijack_code::_id_5956("hijack_fc1_slowdescent", level._id_5B2D);
  level._id_5B2D._id_1B71 = 1;
}

_id_5B2E() {
  common_scripts\utility::flag_wait("all_hallway_terrorists_dead");
  level._id_5A87 maps\_utility::_id_1902();
  level._id_5A87.diequietly = 1;
  level._id_5A87.allowdeath = 1;
  level._id_5A87._id_0D45 = undefined;
  level._id_5A87 kill();
  level._id_5A89 maps\_utility::_id_1902();
  level._id_5A89.diequietly = 1;
  level._id_5A89.allowdeath = 1;
  level._id_5A89._id_0D45 = undefined;
  level._id_5A89 kill();
  level._id_5A9A maps\_utility::_id_1902();
  level._id_5A9A.diequietly = 1;
  level._id_5A9A.allowdeath = 1;
  level._id_5A9A._id_0D45 = undefined;
  level._id_5A9A kill();
  level._id_5B19 delete();
}

_id_5B2F() {
  var_0 = common_scripts\utility::getstruct("bottom_of_stairs", "targetname");
  objective_add(maps\_utility::_id_2816("secure_daughter"), "current", &"HIJACK_OBJ_DAUGHTER", var_0.origin);
  common_scripts\utility::flag_wait("player_reached_bottom_of_stairs");
  var_1 = common_scripts\utility::getstruct("daughter_lower_level", "targetname");
  objective_position(maps\_utility::_id_2816("secure_daughter"), var_1.origin);
  common_scripts\utility::flag_wait("agent_reached_comm_room");
  maps\_utility::_id_2727(maps\_utility::_id_2816("secure_daughter"));
  common_scripts\utility::flag_wait("commander_finished_find_daughter_anim");
  maps\hijack_crash::_id_5A19();
}

_id_5B30() {
  level endon("planecrash_approaching");
  wait 300;
  setDvar("ui_deadquote", &"HIJACK_FAIL_CRASH");
  level notify("mission failed");
  maps\_utility::_id_1826();
}

_id_5B31(var_0) {
  var_1 = getaiarray();
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(_id_5B34(var_5) && isenemyteam(level.player.team, var_5.team) && (!isDefined(var_5._id_5B32) || !var_5._id_5B32)) {
      if(var_5.a._id_0D26 == "crouch") {
        if(var_2 % 2 == 1) {
          var_5 thread _id_5B33("hijack_generic_stumble_crouch2", var_0);
        } else {
          var_5 thread _id_5B33("hijack_generic_stumble_crouch1", var_0);
        }
        var_2 = var_2 + 1;
        continue;
      }

      if(var_5.a._id_0D26 == "stand") {
        if(var_3 % 2 == 1) {
          var_5 thread _id_5B33("hijack_generic_stumble_stand2", var_0);
        } else {
          var_5 thread _id_5B33("hijack_generic_stumble_stand1", var_0);
        }
        var_3 = var_3 + 1;
      }
    }
  }

  if(!maps\_utility::_id_0A36()) {
    level._id_58D2 thread maps\_anim::_id_11C1(level._id_58D2, "hijack_generic_stumble_stand1");
  }
}

_id_5B33(var_0, var_1) {
  self endon("death");
  wait(randomfloat(0.75));

  if(_id_5B34(self)) {
    if(self.a._id_0D26 == "crouch" || self.a._id_0D26 == "stand") {
      self.allowdeath = 1;
      self._id_0D45 = ::_id_5B38;
      maps\_anim::_id_11C1(self, var_0);
      self._id_0D45 = undefined;
    }
  }
}

_id_5B34(var_0) {
  return isDefined(var_0) && isalive(var_0) && !var_0 maps\_utility::_id_0D69() && var_0.a._id_0D55 == 0;
}

_id_5B35() {
  common_scripts\utility::flag_wait("lower_level_rumble_room_2");
  common_scripts\utility::flag_wait_or_timeout("force_bar_rumble", 8);
  var_0 = maps\_utility::_id_272F("diningroom_terrorist_bar");
  var_0 thread _id_5B24();
  var_0._id_1032 = "generic";
  var_0.health = 50;
  var_0._id_5B32 = 1;
  level._id_5B36 = maps\_utility::_id_272F("diningroom_terrorist_door");
  level._id_5B36 thread _id_5B24();
  level._id_5B36._id_1032 = "generic";
  level._id_5B36.health = 50;
  level._id_5B36._id_5B32 = 1;
  level._id_5B36 visiblesolid();
  var_1 = common_scripts\utility::getstruct("dining_room_anim_start", "targetname");
  var_1.angles = (0, 0, 0);
  var_1 thread maps\_anim::_id_1246(var_0, "hijack_diningroom_bar_terrorist");
  var_1 thread maps\_anim::_id_1246(level._id_5B36, "hijack_diningroom_door_terrorist");
  thread _id_5B37(var_0, level._id_5B36);
  wait 1;
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("jet_roll_v01");
  maps\_audio::aud_send_msg("turbine_wind_a");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_large");
  thread _id_5B39();
  level._id_27A4 = 1;
  var_2 = (7, 90, 0);
  var_3 = anglesToForward(var_2);
  level.player setvelocity(var_3 * 110);
  level.player maps\hijack_code::_id_595C();
  thread _id_5B31();
  wait 0.2;
  var_4 = getEntArray("lower_level_room_1_objects", "targetname");

  foreach(var_6 in var_4) {}
  var_6 thread maps\hijack_code::_id_5966(randomintrange(200, 240), (0, 1, 0));

  var_8 = getEntArray("bar_room_physics", "targetname");

  foreach(var_6 in var_8) {}
  var_6 thread maps\hijack_code::_id_5968(64, 64, 0.65);

  wait 1;
  level.player maps\hijack_code::_id_595E();
  wait 1;
  wait 3.75;
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (0, 0, 0), 1, 0, 0);
  wait 1;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread _id_5AED();
  common_scripts\utility::flag_wait("lower_level_rumble_hallway");
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("rumble_boom");
  earthquake(0.33, 2.0, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_medium");
  wait 2.0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread _id_5AED();
  level._id_58D2 waittillmatch("single anim", "plane_shifts");
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("rumble_boom");
  earthquake(0.3, 4.5, level.player.origin, 80000);
  level.player playrumbleonentity("hijack_plane_large");
  maps\_audio::aud_send_msg("jet_roll_v02");
  maps\_audio::aud_send_msg("turbine_wind_b");
  thread _id_5B3A();
  thread maps\hijack_crash_fx::_id_5980();
  resetsundirection();
  thread _id_5B3C();
  level._id_58D2 waittillmatch("single anim", "plane_shift_player");
  level.player disableweapons();

  if(!common_scripts\utility::flag("no_player_slide")) {
    level._id_27A4 = 1;
    var_2 = (7, 90, 0);
    var_3 = anglesToForward(var_2);
    level.player setvelocity(var_3 * 140);
    level.player maps\hijack_code::_id_595C();
    wait 1.0;
    level.player maps\hijack_code::_id_595E();
  } else {
    wait 1.0;
  }
  level.player enableweapons();
  wait 1.0;
}

_id_5B37(var_0, var_1) {
  var_0._id_0D45 = ::_id_5B38;
  var_1._id_0D45 = ::_id_5B38;
  wait 2.5;
  var_0.allowdeath = 1;

  if(var_0.health == 1) {
    var_0 dodamage(1, level.player.origin, level.player);
  }
  var_1.allowdeath = 1;

  if(var_1.health == 1) {
    var_1 dodamage(1, level.player.origin, level.player);
  }
  wait 1.7;
  var_1._id_0D45 = undefined;
  wait 0.2;
  var_0._id_0D45 = undefined;
}

_id_5B38() {
  self startragdoll();
}

_id_5B39() {
  level notify("stop_rocking");
  maps\_audio::aud_send_msg("hallway_lurch", 1);
  var_0 = maps\_utility::_id_1287("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::_id_11CF(var_0, "hallway_lurchcam");
  var_1 linkto(var_0, "J_prop_1");
  var_0 thread maps\_anim::_id_1246(var_0, "hallway_lurchcam");
  var_0 waittillmatch("single anim", "corpse_slump");
  thread _id_5AE9();
  common_scripts\utility::array_thread(level._id_5961, ::_id_5AE8);
  var_0 waittillmatch("single anim", "end");
  level.player playersetgroundreferenceent(level._id_5960);
  var_1 delete();
  var_0 delete();
}

_id_5B3A() {
  level notify("stop_rocking");
  var_0 = maps\_utility::_id_1287("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::_id_11CF(var_0, "hallway_lurchcam");
  var_1 linkto(var_0, "J_prop_1");
  var_0 maps\_anim::_id_1246(var_0, "hallway_lurchcam");
  var_0 maps\_anim::_id_124E(var_0, "hallway_lurchcam_loop", "stop_hallway_shake");

  for(var_2 = 1; !common_scripts\utility::flag("player_left_cargo_room"); var_2 = !var_2) {
    maps\_audio::aud_send_msg("rumble_boom");

    if(var_2) {
      level.player playrumbleonentity("hijack_plane_medium");
    }
  }

  level notify("stop_hallway_shake");
  var_0 delete();
}

_id_5B3B() {
  var_0 = getent("cargo_door01", "targetname");
  var_0 rotateyaw(75, 0.05);
  var_1 = getent("cargo_door02", "targetname");
  var_1 rotateyaw(-60, 0.05);
  var_2 = getent("cargo_door03", "targetname");
  var_2 rotateyaw(60, 0.05);
  var_3 = getent("cargo_door04", "targetname");
  var_3 rotateyaw(15, 0.05);
  var_4 = getent("cargo_door05", "targetname");
  var_4 rotateyaw(-45, 0.05);
  var_5 = getent("cargo_door06", "targetname");
  var_5 rotateyaw(-52, 0.05);
}

_id_5B3C() {
  level._id_5A16 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  var_0 = getent("cargo_strap1", "targetname");
  var_1 = getent("cargo_strap2", "targetname");
  var_2 = getent("cargo_door01", "targetname");
  var_3 = getent("cargo_door02", "targetname");
  var_4 = getent("cargo_door03", "targetname");
  var_5 = getent("cargo_door04", "targetname");
  var_6 = getent("cargo_door05", "targetname");
  var_7 = getent("cargo_door06", "targetname");
  var_8 = getent("cargo_lg_box_01", "targetname");
  var_9 = getent("cargo_lg_box_02", "targetname");
  var_10 = getent("cargo_lg_box_03", "targetname");
  var_11 = getent("cargo_lg_box_04", "targetname");
  var_12 = getent("cargo_lg_box_05", "targetname");
  var_13 = getent("cargo_lg_box_06", "targetname");
  var_14 = getent("cargo_sm_box_03", "targetname");
  var_15 = getent("cargo_ladder", "targetname");
  var_16 = getent("cargo_toolbox", "targetname");
  var_17 = getent("cargo_propane01", "targetname");
  var_18 = getent("cargo_propane04", "targetname");
  var_0 delete();
  var_1 delete();
  var_2 thread _id_5B3D("J_prop_2", "prop_ladder_shift", "prop_ladder_loop", level._id_5A16);
  var_3 thread _id_5B3D("J_prop_2", "prop_propane4_shift", "prop_propane4_loop", level._id_5A16);
  var_4 thread _id_5B3D("J_prop_2", "prop_box1_shift", "prop_box1_loop", level._id_5A16);
  var_5 thread _id_5B3D("J_prop_2", "prop_bag_shift", "prop_bag_loop", level._id_5A16);
  var_6 thread _id_5B3D("J_prop_2", "prop_sm_box2_shift", "prop_sm_box2_loop", level._id_5A16);
  var_7 thread _id_5B3D("J_prop_2", "prop_propane1_shift", undefined, level._id_5A16);
  var_8 thread _id_5B3D("J_prop_1", "prop_box1_shift", undefined, level._id_5A16);
  var_9 thread _id_5B3D("J_prop_1", "prop_box2_3_shift", undefined, level._id_5A16);
  var_10 thread _id_5B3D("J_prop_2", "prop_box2_3_shift", undefined, level._id_5A16);
  var_11 thread _id_5B3D("J_prop_2", "prop_toolbox_shift", undefined, level._id_5A16);
  var_12 thread _id_5B3D("J_prop_2", "prop_sm_box1_shift", undefined, level._id_5A16);
  var_13 thread _id_5B3D("J_prop_2", "prop_smbox3_lg6_shift", undefined, level._id_5A16);
  var_14 thread _id_5B3D("J_prop_1", "prop_smbox3_lg6_shift", undefined, level._id_5A16);
  var_15 thread _id_5B3D("J_prop_1", "prop_ladder_shift", "prop_ladder_loop", level._id_5A16);
  var_16 thread _id_5B3D("J_prop_1", "prop_toolbox_shift", undefined, level._id_5A16);
  var_17 thread _id_5B3D("J_prop_1", "prop_propane1_shift", undefined, level._id_5A16);
  var_18 thread _id_5B3D("J_prop_1", "prop_propane4_shift", "prop_propane4_loop", level._id_5A16);
}

_id_5B3D(var_0, var_1, var_2, var_3) {
  var_4 = maps\_utility::_id_1287("cargo");
  waittillframeend;
  var_3 maps\_anim::_id_11CF(var_4, var_1);
  self linkto(var_4, var_0);
  var_3 maps\_anim::_id_1246(var_4, var_1);

  if(isDefined(var_2)) {
    var_3 maps\_anim::_id_124E(var_4, var_2);
  }
  common_scripts\utility::flag_wait_or_timeout("kill_cargo", 300);
  self unlink();
  var_4 delete();
  self delete();
}

_id_5B3E(var_0) {
  var_1 = maps\_utility::_id_272F(var_0);
  var_1 thread _id_5B24();
  var_1.goalradius = 24;
  var_1 maps\_utility::_id_0D04();
  var_1 thread _id_5B3F("start_" + var_0);

  if(!isDefined(level._id_4BAB)) {
    level._id_4BAB = [];
  }
  level._id_4BAB[level._id_4BAB.size] = var_1;
  common_scripts\utility::flag_wait("start_" + var_0);
  wait 1;

  if(isalive(var_1)) {
    var_1 maps\_utility::_id_1902();
    var_2 = getnode(var_0 + "_target", "targetname");
    var_1 setgoalnode(var_2);
    var_1 waittill("goal");
  }

  common_scripts\utility::flag_wait("spawn_second_room_first_wave");
  wait 2.5;

  if(isalive(var_1)) {
    var_2 = getnode(var_0 + "_target_2", "targetname");
    var_1 setgoalnode(var_2);
    var_1 getenemyinfo(level.player);
    var_1 getenemyinfo(level._id_58D2);
  }
}

_id_5B3F(var_0) {
  self endon("death");
  self endon("stop_damage_watcher");

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(var_2 == level.player) {
      common_scripts\utility::flag_set(var_0);
      self notify("stop_damage_watcher");
    }
  }
}

_id_5B40() {
  common_scripts\utility::flag_wait_any("allow_glass_to_break", "move_president_to_comm_room");
  var_0 = getent("glass_blocking_clip", "targetname");
  var_1 = common_scripts\utility::getstruct("center_of_glass_origin_right", "targetname");
  var_2 = common_scripts\utility::getstruct("center_of_glass_origin_left", "targetname");

  for(var_3 = 0; !var_3 && !common_scripts\utility::flag("move_president_to_comm_room"); var_3 = var_4 || var_5) {
    wait 0.5;
    var_4 = bullettracepassed(level.player.origin + (0, 0, 24), var_1.origin, 0, var_0);
    var_5 = bullettracepassed(level.player.origin + (0, 0, 24), var_2.origin, 0, var_0);
  }

  wait 0.5;
  var_0 delete();
}

_id_5B41() {
  var_0 = [];
  var_0[0] = level._id_58CB;
  var_0[1] = level._id_58BA;
  level._id_58BA maps\_utility::_id_251E();
  level._id_58CB maps\_utility::_id_251E();
  common_scripts\utility::flag_wait("move_president_to_first_room");
  level._id_58CB._id_117F = 1;
  level._id_58CB.script_pushable = 0;
  var_1 = getnode("agent_bottom_stairs", "targetname");
  level._id_58CB setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_first_room", "targetname");
  level._id_58BA setgoalnode(var_2);
  maps\_utility::_id_2748(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_second_room_start");
  _id_5B27();
  level._id_58CB.script_pushable = 1;
  var_1 = getnode("agent_second_room_start", "targetname");
  level._id_58CB setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_second_room_start", "targetname");
  level._id_58BA setgoalnode(var_2);
  maps\_utility::_id_2748(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_hallway");
  level._id_58CB._id_117F = 0;
  var_1 = getnode("agent_hallway", "targetname");
  level._id_58CB setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_hallway", "targetname");
  level._id_58BA setgoalnode(var_2);
  maps\_utility::_id_2748(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_comm_room");
  var_1 = getnode("agent_comm_room", "targetname");
  level._id_58CB setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_comm_room", "targetname");
  level._id_58BA setgoalnode(var_2);
  maps\_utility::_id_2748(var_0, "goal");
  wait 1;
  common_scripts\utility::flag_set("agent_reached_comm_room");
}

_id_5B42() {
  var_0 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  level._id_58D2 maps\_utility::_id_123B();
  level._id_58D2 maps\_utility::_id_104A("ak74u", "primary");
  level._id_58D2._id_1005 = level._id_58D2.weapon;
  var_0 maps\_anim::_id_1246(level._id_58D2, "find_daughter_enter");
  common_scripts\utility::flag_set("commander_finished_find_daughter_anim");
  var_0 thread maps\_anim::_id_124E(level._id_58D2, "find_daughter_commander_loop");
}

_id_5B43() {
  var_0 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  level._id_58CB maps\_utility::_id_123B();
  level._id_58D2 waittillmatch("single anim", "plane_shifts");
  level._id_58CB maps\_anim::_id_1246(level._id_58CB, "hijack_generic_stumble_stand1");
  var_0 maps\_anim::_id_124A(level._id_58CB, "find_daughter_enter");
  var_0 thread maps\_anim::_id_1246(level._id_58CB, "find_daughter_enter");
  thread maps\_utility::_id_11F4("hijack_plt_emergency");
  maps\hijack_crash::_id_5A1E();
  common_scripts\utility::flag_set("turn_on_crash_sled_lights");
  var_1 = getnode("hero_agent_crash_node", "targetname");
  level._id_58CB setgoalnode(var_1);
  level._id_58CB._id_117F = 1;
}

_id_5B44() {
  setDvar("ui_deadquote", &"HIJACK_MISSIONFAIL_ALENA");
  thread maps\_utility::_id_1826();
}

_id_5B45() {
  common_scripts\utility::flag_wait_any("daughter_thrown_left", "daughter_thrown_right");
  level._id_59E0 = maps\_utility::_id_272F("find_daughter_pre_crash");
  level._id_59E0.allowdeath = 1;

  if(isDefined(level._id_59E0._id_0D04)) {
    level._id_59E0 maps\_utility::_id_1902();
  }
  level._id_59E0._id_0D45 = ::_id_5B44;
  var_0 = maps\_utility::_id_272C("cargo_room_terrorists_b");
  thread maps\hijack_code::_id_596C(var_0, var_0.size, "all_cargo_room_terrorists_dead");
  var_1 = getEntArray("daughter_triggers", "targetname");
  maps\_utility::_id_135B(var_1);
  var_2 = maps\_utility::_id_2640("daughter_terrorist", "script_noteworthy");
  var_2._id_1032 = "generic";
  var_2.ignoreme = 1;
  var_2.ignoreall = 1;
  var_3 = [];
  var_3[0] = level._id_59E0;
  var_3[1] = var_2;

  if(common_scripts\utility::flag("daughter_thrown_right")) {
    level._id_5A16 thread maps\_anim::_id_11DD(var_3, "pre_find_daughter_short");
  } else {
    level._id_5A16 thread maps\_anim::_id_11DD(var_3, "pre_find_daughter");
  }
  var_2 waittillmatch("single anim", "done_throwing");
  var_2.allowdeath = 1;
  level._id_59E0 waittillmatch("single anim", "end");

  if(isalive(var_2)) {
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
  }

  level._id_5A16 thread maps\_anim::_id_124E(level._id_59E0, "daughter_cry_loop");
}

_id_5B46() {
  level._id_5A16 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  common_scripts\utility::flag_wait("cargo_room_commander_move");
  level._id_58D2._id_20AF = 1.0;
  level._id_5A16 maps\_anim::_id_124A(level._id_58D2, "find_daughter_enter");
  common_scripts\utility::flag_wait_all("all_cargo_room_terrorists_dead", "cargo_room_wave_a_dead", "agent_reached_comm_room");
  maps\_audio::aud_send_msg("cargo_room_zone_on");
  var_0 = getnode("agent_pre_daughter_node", "targetname");
  level._id_58CB setgoalnode(var_0);
  level._id_5A16 maps\_anim::_id_124A(level._id_58BA, "find_daughter_enter");
  level._id_5A16 notify("stop_loop");
  thread _id_5B42();
  thread _id_5B43();
  var_1 = [];
  var_1[0] = level._id_58BA;
  var_1[1] = level._id_59E0;
  level._id_5A16 maps\_anim::_id_11DD(var_1, "find_daughter_enter");
  level._id_5A16 thread maps\_anim::_id_11D6(var_1, "post_find_loop");
  common_scripts\utility::flag_set("find_daughter_moment_finished");
  maps\_audio::aud_send_msg("cargo_room_zone_off");
  level waittill("crash_impact");
  level._id_5A16 notify("stop_loop");
}

_id_5B47() {
  level waittill("planecrash_approaching");
  self notify("stop_loop");
}

_id_5A1B() {
  level._id_58D2.ignoreme = 1;
  level._id_58CB.ignoreme = 1;
}

_id_5A21() {
  common_scripts\utility::flag_set("stop_phones");
  level.player.ignoreme = 0;
  level._id_58D2.ignoreme = 0;

  if(isDefined(level._id_5A87)) {
    level._id_5A87 maps\_utility::_id_1902();
    level._id_5A87._id_0D45 = undefined;
    level._id_5A87 delete();
  }

  if(isDefined(level._id_59E0)) {
    if(isDefined(level._id_59E0._id_0D04)) {
      level._id_59E0 maps\_utility::_id_1902();
    }
    level._id_59E0 delete();
  }

  if(isDefined(level._id_58C6)) {
    level._id_58C6 maps\_utility::_id_1902();
    level._id_58C6 delete();
  }

  if(isDefined(level._id_58BA)) {
    level._id_58BA maps\_utility::_id_1902();
    level._id_58BA._id_0D45 = undefined;
    level._id_58BA delete();
  }

  common_scripts\utility::flag_set("kill_cargo");
}