/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_airplane.gsc
********************************************/

airplane_init_flags() {
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

start_airplane() {
  level.player disableweapons();
  level.org_vba_base = getDvar("bg_viewBobAmplitudeBase");
  level.org_vba_standing = getDvar("bg_viewBobAmplitudeStanding");
  setsaveddvar("bg_viewBobAmplitudeBase", "0.05");
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.014 0.014");
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level.commander = maps\hijack_code::spawn_ally("commander");
  level.advisor = maps\hijack_code::spawn_ally("advisor");
  level.president = maps\hijack_code::spawn_ally("president");
  level.hero_agent_01 = maps\hijack_code::spawn_ally("hero_agent_01");
  level.hero_agent_01.animname = "hero_agent";
  level.hero_agent_01.ignoreme = 1;
  level.hero_agent_01.ignoreall = 1;
  level.commander maps\_utility::disable_ai_color();
  level.hero_agent_01 maps\_utility::disable_ai_color();
  level.president maps\_utility::disable_ai_color();
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  waittillframeend;
  level.commander maps\_utility::gun_remove();
  maps\_audio::aud_send_msg("start_airplane");
  thread maps\hijack::setup_turbines();
  thread intro_screen();
  thread intro();
  thread intro_env();
  thread intro_doors();
  thread debate();
  thread hallway_carnage();
  thread zerog();
  thread upper_level_objectives();
  thread screen_movies();
  thread maps\hijack::setup_cloud_tunnel();
}

start_debate() {
  thread maps\hijack_code::rockingplane();
  level.debate_trigger common_scripts\utility::trigger_on();
  level.debate_trigger_b common_scripts\utility::trigger_on();
  var_0 = common_scripts\utility::getStruct("player_start_debate", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  level.org_vba_base = getDvar("bg_viewBobAmplitudeBase");
  level.org_vba_standing = getDvar("bg_viewBobAmplitudeStanding");
  setsaveddvar("bg_viewBobAmplitudeBase", "0.05");
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.014 0.014");
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level.player disableweapons();
  level.player setmovespeedscale(0.35);
  level.player allowsprint(0);
  level.commander = maps\hijack_code::spawn_ally("commander");
  level.advisor = maps\hijack_code::spawn_ally("advisor");
  level.president = maps\hijack_code::spawn_ally("president");
  level.hero_agent_01 = maps\hijack_code::spawn_ally("hero_agent_01");
  level.hero_agent_01.animname = "hero_agent";
  level.hero_agent_01.ignoreme = 1;
  level.hero_agent_01.ignoreall = 1;
  level.secretary = maps\_utility::spawn_targetname("secretary");
  level.secretary.animname = "secretary";
  level.secretary.ignoreme = 1;
  level.secretary.ignoreall = 1;
  level.secretary maps\_utility::magic_bullet_shield();
  level.polit_1 = maps\_utility::spawn_targetname("polit_1");
  level.polit_1.animname = "polit_1";
  level.polit_1.ignoreme = 1;
  level.polit_1.ignoreall = 1;
  level.polit_1 maps\_utility::magic_bullet_shield();
  level.polit_2 = maps\_utility::spawn_targetname("polit_2");
  level.polit_2.animname = "polit_2";
  level.polit_2.ignoreme = 1;
  level.polit_2.ignoreall = 1;
  level.polit_2 maps\_utility::magic_bullet_shield();
  level.intro_agent1 = maps\_utility::spawn_targetname("intro_agent1");
  level.intro_agent1.animname = "generic";
  level.intro_agent1.ignoreme = 1;
  level.intro_agent1.ignoreall = 1;
  level.intro_agent2 = maps\_utility::spawn_targetname("intro_agent2");
  level.intro_agent2.animname = "generic";
  level.intro_agent2.ignoreme = 1;
  level.intro_agent2.ignoreall = 1;
  level.intro_agent2 maps\_utility::gun_remove();
  level.commander maps\_utility::disable_ai_color();
  level.hero_agent_01 maps\_utility::disable_ai_color();
  level.president maps\_utility::disable_ai_color();
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  maps\_audio::aud_send_msg("debate");
  waittillframeend;
  level.commander maps\_utility::gun_remove();
  common_scripts\utility::flag_set("intro_done");
  thread maps\hijack::setup_turbines();
  thread debate_chair_destroy();
  thread intro_doors();
  thread debate();
  thread hallway_carnage();
  thread zerog();
  thread upper_level_objectives();
  common_scripts\utility::flag_set("follow_pres");
  common_scripts\utility::flag_set("take_position");
  common_scripts\utility::flag_set("in_guard_position");
  thread maps\hijack::setup_cloud_tunnel();
  wait 0.2;
  thread intro_close_door3();
}

start_pre_zero_g() {
  var_0 = common_scripts\utility::getStruct("player_start_pre_zero_g", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level.commander = maps\hijack_code::spawn_ally("commander");
  level.president = maps\hijack_code::spawn_ally("president");
  level.advisor = maps\hijack_code::spawn_ally("advisor");
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  level.intro_origin thread maps\_anim::anim_loop_solo(level.advisor, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  level.hero_agent_01 = maps\hijack_code::spawn_ally("hero_agent_01");
  level.hero_agent_01.animname = "hero_agent";
  waittillframeend;
  level.door3 = getEnt("intro_door3", "targetname");
  level.door3 movey(50, 0.1);
  common_scripts\utility::flag_set("pre_zerog_checkpoint");
  common_scripts\utility::flag_set("player_ahead");
  level.hallway_roller = maps\_utility::spawn_anim_model("upperhall_roller", level.player.origin);
  maps\_audio::aud_send_msg("start_pre_zero_g");
  level.player setmovespeedscale(0.85);
  level.commander.goalradius = 16;
  var_1 = getnode("commander_zerog", "targetname");
  level.commander setgoalnode(var_1);
  thread maps\hijack::setup_turbines();
  thread hallway_plane_lurch();
  thread pre_zerog_behavior();
  thread hallway_carnage();
  thread zerog();
  thread upper_level_objectives();
  common_scripts\utility::flag_set("follow_pres");
  common_scripts\utility::flag_set("take_position");
  common_scripts\utility::flag_set("in_guard_position");
  common_scripts\utility::flag_set("move_pres");
  thread maps\hijack::setup_cloud_tunnel();
}

start_lower_level_combat() {
  var_0 = common_scripts\utility::getStruct("player_start_lower_level_combat", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level.commander = maps\hijack_code::spawn_ally("commander");
  level.president = maps\hijack_code::spawn_ally("president");
  level.advisor = maps\hijack_code::spawn_ally("advisor");
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  level.intro_origin thread maps\_anim::anim_loop_solo(level.advisor, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  level.hero_agent_01 = maps\hijack_code::spawn_ally("hero_agent_01");
  level.zerog_agent_01 = maps\hijack_code::spawn_ally("zerog_agent_01");
  level.zerog_agent_02 = maps\hijack_code::spawn_ally("zerog_agent_02");
  level.player.ignoreme = 0;
  level.commander.ignoreme = 1;
  level.commander.ignoreall = 1;
  level.hero_agent_01.ignoreme = 0;
  level.hero_agent_01.ignoreall = 0;
  level.player enableweapons();
  level.door3 = getEnt("intro_door3", "targetname");
  level.door3 movey(50, 0.1);
  level.zerog_agent_01.ignoreme = 1;
  level.zerog_agent_01.ignoreall = 1;
  level.zerog_agent_02.ignoreme = 1;
  level.zerog_agent_02.ignoreall = 1;
  level.zerog_agent_03 = maps\_utility::spawn_targetname("zerog_agent_03");
  level.zerog_agent_03 thread maps\_utility::magic_bullet_shield();
  level.zerog_agent_03 maps\hijack_code::no_grenades();
  level.zerog_agent_03.baseaccuracy = 0.1;
  level.zerog_agent_03.ignoresuppression = 1;
  waittillframeend;
  thread zerog_done_agents();
  maps\_audio::aud_send_msg("start_lower_level_combat");
  level.player setmovespeedscale(0.85);
  thread maps\hijack::setup_turbines();
  thread constant_rumble();
  thread moving_to_bottom_level();
  thread maps\hijack::setup_cloud_tunnel();
}

hallway_rumble_low() {
  maps\_audio::aud_send_msg("rumble");
  earthquake(0.12, 4.5, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_low");
}

upper_level_objectives() {
  var_0 = getDvar("objectiveFadeTooFar");
  common_scripts\utility::flag_wait("follow_pres");
  objective_add(maps\_utility::obj("follow_president"), "current", &"HIJACK_FOLLOW_PRES", level.hero_agent_01.origin);
  objective_onentity(maps\_utility::obj("follow_president"), level.hero_agent_01, (0, 0, 70));
  setsaveddvar("objectiveFadeTooFar", 1);
  wait 3;
  setsaveddvar("objectiveFadeTooFar", var_0);
  common_scripts\utility::flag_wait("take_position");
  var_1 = common_scripts\utility::getStruct("take_pos", "targetname");
  maps\_utility::objective_complete(maps\_utility::obj("follow_president"));
  objective_add(maps\_utility::obj("take_position"), "current", &"HIJACK_TAKE_POS", var_1.origin);
  common_scripts\utility::flag_wait("in_guard_position");
  maps\_utility::objective_complete(maps\_utility::obj("take_position"));
  common_scripts\utility::flag_wait("move_pres");
  var_2 = common_scripts\utility::getStruct("obj_pres_move", "targetname");
  objective_add(maps\_utility::obj("move_president"), "current", &"HIJACK_MOVE_PRES", var_2.origin);
}

intro_screen() {
  var_0 = 18.5;
  level.player freezecontrols(1);
  thread maps\_introscreen::introscreen_generic_black_fade_in(var_0, 4);
  var_1 = [];
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE1";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE2";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE3";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE4";
  var_1[var_1.size] = &"HIJACK_INTROSCREEN_LINE5";
  wait 0.5;
  thread introscreen_vo();
  wait 9;
  maps\_introscreen::introscreen_feed_lines(var_1);
  wait 3;
  common_scripts\utility::flag_set("introscreen_done");
}

introscreen_vo() {
  maps\_utility::radio_dialogue("hijack_plt_moscow");
  maps\_utility::radio_dialogue("hijack_cmd_reportin");
  wait 0.5;
  maps\_utility::radio_dialogue("hijack_fso1_presidentoffice");
  wait 0.3;
  maps\_utility::radio_dialogue("hijack_fso2_lowerdeckclear");
  wait 0.6;
  maps\_utility::radio_dialogue("hijack_fso3_fowardcabin");
  wait 1;
  maps\_utility::radio_dialogue("hijack_cmd_landinhamburg");
  wait 0.75;
  maps\_utility::radio_dialogue("hijack_cmd_remainwithpres");
}

intro() {
  thread maps\hijack_code::rockingplane();
  thread intro_ambient_people();
  thread intro_door0();
  thread intro_nag1();
  thread intro_nag2();
  var_0 = getEnt("intro_door1", "targetname");
  var_0 movey(50, 0.05);
  var_1 = getEnt("block_player_from_daughter", "targetname");
  var_1 hide();
  var_1 notsolid();
  level.jet_1a = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_1a");
  level.jet_1b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_1b");
  level.jet_1a maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_1b maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_1a thread hide_jet_parts();
  level.jet_1b thread hide_jet_parts();
  level.hero_agent_01 maps\_utility::gun_remove();
  level.intro_agent1 = maps\_utility::spawn_targetname("intro_agent1");
  level.intro_agent1.animname = "generic";
  level.intro_agent1.ignoreme = 1;
  level.intro_agent1.ignoreall = 1;
  level.intro_agent3 = maps\_utility::spawn_targetname("intro_agent3");
  level.intro_agent3.animname = "generic";
  level.intro_agent3.ignoreme = 1;
  level.intro_agent3.ignoreall = 1;
  level.intro_agent3 pushplayer(1);
  level.daughter1 = maps\_utility::spawn_targetname("intro_daughter");
  level.daughter1.animname = "daughter";
  level.daughter1.ignoreme = 1;
  level.daughter1.ignoreall = 1;
  level.daughter1 maps\_utility::gun_remove();
  level.daughter1 thread intro_delete_when_done();
  level.daughter1 pushplayer(1);
  level.president pushplayer(1);
  var_2 = maps\_utility::spawn_targetname("assistant");
  var_2.animname = "assistant";
  var_2.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2 maps\_utility::gun_remove();
  var_2 thread intro_delete_when_done();
  var_3 = [];
  var_3[0] = level.president;
  var_3[2] = var_2;
  thread intro_player();
  common_scripts\utility::flag_wait("introscreen_done");
  thread intro_hero_agent();
  common_scripts\utility::flag_set("intro_player_animate");
  level.hero_agent_01 waittillmatch("single anim", "start_daughter");
  level.intro_origin thread maps\_anim::anim_single_solo(level.daughter1, "intro_scene");
  level.intro_origin thread intro_anim_and_loop(level.intro_agent3, "intro_cine_agent3", "intro_cine_agent3_loop", "stop_ambguy_loop");
  level.hero_agent_01 waittillmatch("single anim", "start_intro");
  level.intro_origin thread maps\_anim::anim_single(var_3, "intro_scene");
  thread intro_vo();
  thread intro_pres_notes();
  wait 4.5;
  var_0 movey(-50, 1, 0.25, 0.5);
  maps\_audio::aud_send_msg("intro_door1_open");
  common_scripts\utility::flag_set("start_amb_guys");
  var_4 = getEnt("block_player_from_daughter_volume", "targetname");
  var_5 = getEnt("block_player_from_daughter_2", "targetname");

  if(!level.player istouching(var_4)) {
    var_1 show();
    var_1 solid();
  }

  wait 5.9;
  common_scripts\utility::flag_set("follow_pres");
  var_1 hide();
  var_1 notsolid();
  var_5 delete();
  level.president waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("intro_done");
  level.debate_trigger common_scripts\utility::trigger_on();
  level.debate_trigger_b common_scripts\utility::trigger_on();

  if(!common_scripts\utility::flag("in_guard_position")) {
    level.intro_origin thread maps\_anim::anim_loop_solo(level.president, "intro_cine_president_wait_loop", "stop_intro_loop");
  }
}

hide_jet_parts() {
  self hidepart("front_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("front_wheel_base_jnt", "vehicle_mig29");
  self hidepart("ri_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("ri_wheel_base_jnt", "vehicle_mig29");
  self hidepart("le_wheel_panel_jnt", "vehicle_mig29");
  self hidepart("le_wheel_base_jnt", "vehicle_mig29");
}

intro_delete_when_done() {
  self waittillmatch("single anim", "end");
  self delete();
}

intro_player() {
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
  thread intro_announcements();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
  common_scripts\utility::flag_wait("second_migs");
  level.jet_2a = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_2a");
  level.jet_2b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_2b");
  level.jet_2a maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_2b maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_2a thread hide_jet_parts();
  level.jet_2b thread hide_jet_parts();
}

intro_announcements() {
  wait 0.4;
  var_0 = spawn("script_origin", (-29408, 12720, 7312));
  var_0 playSound("hijk_pilot_bell");
  wait 1.6;
  maps\hijack_code::background_chatter("hijack_plt_message1", var_0);
  wait 1.4;
  maps\hijack_code::background_chatter("hijack_plt_message2", var_0);
  wait 1.9;
  maps\hijack_code::background_chatter("hijack_plt_message3", var_0);
  wait 5;
  var_0 delete();
}

intro_hero_agent() {
  level.intro_origin maps\_anim::anim_single_solo(level.hero_agent_01, "intro_scene");
  common_scripts\utility::flag_set("agent_in_position");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level.intro_origin thread maps\_anim::anim_loop_solo(level.hero_agent_01, "intro_cine_hero_agent_loop", "stop_intro_loop");
  }
}

intro_door0() {
  var_0 = getEnt("intro_door0", "targetname");
  var_0 movey(-52, 0.05);
  wait 0.2;
  var_1 = maps\_utility::spawn_anim_model("door");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_1, "intro_cine_presdoor_open");
  var_0 linkTo(var_1, "J_prop_1");
  level.hero_agent_01 waittillmatch("single anim", "start_intro");
  level.intro_origin thread maps\_anim::anim_single_solo(var_1, "intro_cine_presdoor_open");
  level.daughter1 waittillmatch("single anim", "close_door");
}

intro_ambient_people() {
  maps\_utility::array_spawn_function_targetname("ambient_workers", maps\hijack::setup_generic_script_guy);
  var_0 = maps\_utility::array_spawn_targetname("ambient_workers");
  var_1 = maps\_utility::get_living_ai("ambient_worker1", "script_noteworthy");
  var_2 = maps\_utility::get_living_ai("ambient_worker2", "script_noteworthy");
  var_3 = maps\_utility::get_living_ai("ambient_worker3", "script_noteworthy");
  var_4 = maps\_utility::get_living_ai("ambient_worker4", "script_noteworthy");
  thread intro_ambient_cart_props();
  var_5 = getEnt("ambient_worker_clipboard1", "targetname");
  var_6 = getEnt("ambient_worker_pencil", "targetname");
  var_7 = maps\_utility::spawn_anim_model("clipboard");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_7, "intro_worker_clipboard");
  var_8 = var_7 gettagorigin("J_prop_1");
  var_9 = var_7 gettagangles("J_prop_1");
  var_10 = var_7 gettagorigin("J_prop_2");
  var_11 = var_7 gettagangles("J_prop_2");
  var_5.origin = var_8;
  var_5.angles = var_9;
  var_6.origin = var_10;
  var_6.angles = var_11;
  var_5 linkTo(var_7, "J_prop_1");
  var_6 linkTo(var_7, "J_prop_2");
  var_12 = getEnt("ambient_cart", "targetname");
  var_13 = maps\_utility::spawn_anim_model("food_cart");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_13, "intro_storage_cart");
  var_12 linkTo(var_13, "J_prop_1");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_1, "intro_worker_checklist");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_2, "intro_storage_guy");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_3, "intro_kitchenette_guy1");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_4, "intro_kitchenette_guy2");
  var_14 = getEnt("coffee_stir_stick", "targetname");
  var_15 = var_3 gettagorigin("tag_weapon_right");
  var_16 = var_3 gettagangles("tag_weapon_right");
  var_14.origin = var_15;
  var_14.angles = var_16;
  var_14 linkTo(var_3, "tag_weapon_right");
  common_scripts\utility::flag_wait("start_amb_guys");
  thread intro_anim_and_loop(var_1, "intro_worker_checklist", "intro_worker_checklist_loop", "stop_ambguy_loop");
  thread intro_anim_and_loop(var_7, "intro_worker_clipboard", "intro_worker_clipboard_loop", "stop_ambguy_loop");
  thread intro_anim_and_loop_cartguy(var_2, "intro_storage_guy", "intro_storage_guy_loop", "stop_ambguy_loop");
  level.intro_origin thread maps\_anim::anim_single_solo(var_13, "intro_storage_cart");
  maps\_audio::aud_send_msg("hijk_cart_moves");
  wait 7.9;
  wait 5.9;
  thread intro_anim_and_loop(var_3, "intro_kitchenette_guy1", "intro_kitchenette_guy1_loop", "stop_ambguy_loop");
  thread intro_anim_and_loop(var_4, "intro_kitchenette_guy2", "intro_kitchenette_guy2_loop", "stop_ambguy_loop");
  var_4 pushplayer(1);
  maps\_audio::aud_send_msg("hijk_agent_espresso");
  maps\_audio::aud_send_msg("keypad");
  common_scripts\utility::flag_wait("delete_intro_ambient_guys");
  level.intro_origin notify("stop_ambguy_loop");
  waittillframeend;

  if(isDefined(var_1.magic_bullet_shield)) {
    var_1 maps\_utility::stop_magic_bullet_shield();
  }
  if(isDefined(var_2.magic_bullet_shield)) {
    var_2 maps\_utility::stop_magic_bullet_shield();
  }
  if(isDefined(var_3.magic_bullet_shield)) {
    var_3 maps\_utility::stop_magic_bullet_shield();
  }
  if(isDefined(var_4.magic_bullet_shield)) {
    var_4 maps\_utility::stop_magic_bullet_shield();
  }
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_7 delete();
  var_12 delete();
  var_13 delete();
  level.intro_agent3 delete();
}

intro_ambient_cart_props() {
  var_0 = getEnt("peanuts", "targetname");
  var_1 = getEnt("candy1", "targetname");
  var_2 = getEnt("candy2", "targetname");
  var_3 = maps\_utility::spawn_anim_model("food_cart");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_3, "intro_storage_peanuts");
  var_4 = maps\_utility::spawn_anim_model("food_cart");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_4, "intro_storage_candy");
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
  var_0 linkTo(var_3, "J_prop_1");
  var_1 linkTo(var_4, "J_prop_1");
  common_scripts\utility::flag_wait("start_cart_props");
  level.intro_origin thread maps\_anim::anim_loop_solo(var_3, "intro_storage_peanuts_loop", "stop_ambguy_loop");
  level.intro_origin thread maps\_anim::anim_loop_solo(var_4, "intro_storage_candy_loop", "stop_ambguy_loop");
  common_scripts\utility::flag_wait("delete_intro_ambient_guys");
  wait 0.05;
  var_0 delete();
  var_3 delete();
  var_1 delete();
  var_2 delete();
  var_4 delete();
}

intro_anim_and_loop_cartguy(var_0, var_1, var_2, var_3) {
  level.intro_origin maps\_anim::anim_first_frame_solo(var_0, var_1);
  var_4 = getEnt("candy2", "targetname");
  var_5 = var_0 gettagorigin("TAG_WEAPON_CHEST");
  var_6 = var_0 gettagangles("TAG_WEAPON_CHEST");
  var_4.origin = var_5;
  var_4.angles = var_6;
  var_4 linkTo(var_0, "TAG_WEAPON_CHEST");
  level.intro_origin maps\_anim::anim_single_solo(var_0, var_1);
  common_scripts\utility::flag_set("start_cart_props");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level.intro_origin thread maps\_anim::anim_loop_solo(var_0, var_2, var_3);
    common_scripts\utility::flag_wait("debate_starting");
  }
}

intro_vo() {
  level.daughter1 waittillmatch("single anim", "sub_cliff_ru2_suspicious");
}

intro_nag1() {
  level endon("second_migs");
  common_scripts\utility::flag_wait("follow_pres");

  while(!common_scripts\utility::flag("second_migs")) {
    wait 12;
    maps\_utility::radio_dialogue("hijack_cmd_staywithpres");
  }
}

intro_nag2() {
  level endon("in_guard_position");
  common_scripts\utility::flag_wait("intro_done");

  while(!common_scripts\utility::flag("in_guard_position")) {
    wait 12;
    maps\_utility::radio_dialogue("hijack_cmd_takeposition");
  }
}

intro_pres_notes() {
  var_0 = getEnt("pres_book", "targetname");
  var_1 = getEnt("pres_paper", "targetname");
  var_2 = maps\_utility::spawn_anim_model("binder");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_2, "intro_cine_pres_binder");
  var_3 = var_2 gettagorigin("J_prop_1");
  var_4 = var_2 gettagangles("J_prop_1");
  var_5 = var_2 gettagorigin("J_prop_2");
  var_6 = var_2 gettagangles("J_prop_2");
  var_0.origin = var_3;
  var_0.angles = var_4;
  var_1.origin = var_5;
  var_1.angles = var_6;
  var_0 linkTo(var_2, "J_prop_1");
  var_1 linkTo(var_2, "J_prop_2");
  level.intro_origin thread maps\_anim::anim_single_solo(var_2, "intro_cine_pres_binder");
  maps\_audio::aud_send_msg("pres_drops_paper");
  level.president waittillmatch("single anim", "drop_folder");
}

intro_asst_door(var_0) {
  maps\_audio::aud_send_msg("start_news");
  level.intro_origin maps\_anim::anim_single_solo(level.door_rig2, "intro_door2_assistant_open");
}

intro_conf_room(var_0) {
  level.secretary = maps\_utility::spawn_targetname("secretary");
  level.secretary.animname = "secretary";
  level.secretary.ignoreme = 1;
  level.secretary.ignoreall = 1;
  level.secretary maps\_utility::magic_bullet_shield();
  level.polit_1 = maps\_utility::spawn_targetname("polit_1");
  level.polit_1.animname = "polit_1";
  level.polit_1.ignoreme = 1;
  level.polit_1.ignoreall = 1;
  level.polit_1 maps\_utility::magic_bullet_shield();
  level.polit_2 = maps\_utility::spawn_targetname("polit_2");
  level.polit_2.animname = "polit_2";
  level.polit_2.ignoreme = 1;
  level.polit_2.ignoreall = 1;
  level.polit_2 maps\_utility::magic_bullet_shield();
  level.intro_agent2 = maps\_utility::spawn_targetname("intro_agent2");
  level.intro_agent2.animname = "generic";
  level.intro_agent2.ignoreme = 1;
  level.intro_agent2.ignoreall = 1;
  level.intro_agent2 maps\_utility::gun_remove();
  level.conf_phone_1 = getEnt("conf_phone", "targetname");
  level.conf_phone_1.animname = "phone";
  level.conf_phone_1 maps\_anim::setanimtree();
  thread intro_tv_off();
  level.intro_origin thread maps\_anim::anim_single_solo(level.conf_phone_1, "debate_phone");
  thread intro_anim_and_loop(level.commander, "intro_cine_commander", "intro_cine_commander_wait_loop", "stop_intro_loop");
  thread intro_anim_and_loop(level.advisor, "intro_cine_advisor", "intro_cine_advisor_wait_loop", "stop_intro_loop");
  thread intro_anim_and_loop(level.secretary, "intro_cine_secretary", "intro_cine_secretary_wait_loop", "stop_intro_loop");
  var_1 = level.secretary gettagorigin("tag_inhand");
  var_2 = level.secretary gettagangles("tag_inhand");
  level.remote = spawn("script_model", var_1);
  level.remote setModel("electronics_pda");
  level.remote.angles = var_2;
  level.remote linkTo(level.secretary, "tag_inhand");
  thread intro_anim_and_loop(level.intro_agent1, "intro_cine_agent", "intro_cine_agent_loop", "stop_intro_loop");
  thread intro_anim_and_loop(level.intro_agent2, "intro_cine_agent2", "intro_cine_agent2_loop", "stop_intro_loop");
  thread intro_anim_and_loop(level.polit_1, "intro_cine_politician1", "intro_cine_politician1_loop", "stop_intro_loop");
  thread intro_polit1_prop();
  thread intro_anim_and_loop(level.polit_2, "intro_cine_politician2", "intro_cine_politician2_loop", "stop_intro_loop");
  thread debate_chair_destroy();
  level.president thread debate_chair_anim("chair1", "intro_chair1");
  level.advisor thread debate_chair_anim("chair2", "intro_chair2");
  level.commander thread debate_chair_anim("chair3", "intro_chair3");
  level.secretary thread debate_chair_anim("chair4", "intro_chair4");
  level.polit_1 thread debate_chair_anim("chair5", "intro_chair5");
  level.polit_2 thread debate_chair_anim("chair6", "intro_chair6");
  var_3 = getEnt("chair8", "targetname");
  var_3.animname = "conf_chair";
  var_3 maps\_anim::setanimtree();
  level.intro_origin maps\_anim::anim_first_frame_solo(var_3, "debate_chair8");
}

intro_anim_and_loop(var_0, var_1, var_2, var_3) {
  level.intro_origin maps\_anim::anim_single_solo(var_0, var_1);

  if(!common_scripts\utility::flag("in_guard_position")) {
    level.intro_origin thread maps\_anim::anim_loop_solo(var_0, var_2, var_3);
    common_scripts\utility::flag_wait("debate_starting");
  }
}

intro_env() {
  common_scripts\utility::flag_wait("plane_shake1");
  var_0 = randomfloatrange(0.0, 2.0);
  wait(var_0);
  thread hallway_rumble_low();
}

intro_doors() {
  level.door1 = getEnt("intro_door1", "targetname");
  level.door_rig1 = getEnt("intro_door1_rig", "targetname");
  level.door_rig1.animname = "door";
  level.door_rig1 maps\_anim::setanimtree();
  level.door2 = getEnt("intro_door2", "targetname");
  level.door_rig2 = getEnt("intro_door2_rig", "targetname");
  level.door_rig2.animname = "door";
  level.door_rig2 maps\_anim::setanimtree();
  level.door3 = getEnt("intro_door3", "targetname");
  level.door3 movey(50, 0.1);
  level.door_rig3 = getEnt("intro_door3_rig", "targetname");
  level.door_rig3.animname = "door";
  level.door_rig3 maps\_anim::setanimtree();
  level.door4 = getEnt("intro_door4", "targetname");
  level.door4 movey(52, 0.1);
  level.door_rig4 = getEnt("intro_door4_rig", "targetname");
  level.door_rig4.animname = "door";
  level.door_rig4 maps\_anim::setanimtree();
  wait 0.2;
  level.intro_origin thread maps\_anim::anim_first_frame_solo(level.door_rig2, "intro_door2_worker_open");
  level.door2 linkTo(level.door_rig2, "J_prop_1");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(level.door_rig3, "intro_door3_agent_open");
  level.door3 linkTo(level.door_rig3, "J_prop_1");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(level.door_rig4, "debate_cine_door4_blown_off");
  level.door4 linkTo(level.door_rig4, "J_prop_1");
}

intro_polit1_prop() {
  var_0 = getEnt("polit1_pitcher", "script_noteworthy");
  var_1 = getEnt("polit1_glass", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("pitcher");
  waittillframeend;
  level.intro_origin maps\_anim::anim_first_frame_solo(var_2, "intro_cine_pitcher");
  var_0 linkTo(var_2, "J_prop_1");
  var_1 linkTo(var_2, "J_prop_2");
  level.intro_origin maps\_anim::anim_single_solo(var_2, "intro_cine_pitcher");

  if(!common_scripts\utility::flag("in_guard_position")) {
    level.intro_origin maps\_anim::anim_loop_solo(var_2, "intro_cine_pitcher_loop", "stop_intro_loop");
  }
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

intro_close_door3() {
  common_scripts\utility::flag_wait("in_guard_position");
  level.door3 unlink();
  wait 0.2;
  level.door3 movey(46, 1, 0, 0.25);
  maps\_audio::aud_send_msg("debate_door_close");
  wait 1;

  if(isDefined(level.intro_agent1.magic_bullet_shield)) {
    level.intro_agent1 maps\_utility::stop_magic_bullet_shield();
  }
  level.intro_agent1 delete();
  common_scripts\utility::flag_set("delete_intro_ambient_guys");
}

debate_chair_anim(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2.animname = "conf_chair";
  var_2 maps\_anim::setanimtree();
  level.intro_origin maps\_anim::anim_first_frame_solo(var_2, var_1);
  self waittillmatch("single anim", "swivel_chair");
  level.intro_origin maps\_anim::anim_single_solo(var_2, var_1);
}

debate_chair_destroy() {
  var_0 = getEnt("chair_destroy_top", "targetname");
  var_1 = getEnt("chair_destroy_base", "targetname");
  var_2 = maps\_utility::spawn_anim_model("destroy_chair");
  waittillframeend;
  level.intro_origin maps\_anim::anim_first_frame_solo(var_2, "debate_cine_end_chair");
  var_0 linkTo(var_2, "J_prop_1");
  var_1 linkTo(var_2, "J_prop_2");
  common_scripts\utility::flag_wait("debate_starting");
  level.intro_origin maps\_anim::anim_single_solo(var_2, "debate_cine_end_chair");
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

debate_open_first_door(var_0) {
  level.intro_origin maps\_anim::anim_single_solo(level.door_rig3, "debate_cine_door3_agent_open");
}

debate_open_first_door_intro(var_0) {
  level.intro_origin maps\_anim::anim_single_solo(level.door_rig3, "intro_door3_agent_open");
}

debate_close_first_door(var_0) {
  level.intro_origin maps\_anim::anim_single_solo(level.door_rig3, "intro_door3_agent_close");
}

debate() {
  common_scripts\utility::flag_wait_all("in_guard_position", "intro_done");
  waittillframeend;
  thread maps\_utility::autosave_by_name("debate");
  var_0 = [];
  var_0[0] = level.president;
  var_0[2] = level.advisor;
  var_0[3] = level.secretary;
  var_0[4] = level.hero_agent_01;
  var_0[5] = level.intro_agent2;
  var_0[6] = level.polit_1;
  var_0[7] = level.polit_2;
  level.intro_origin notify("stop_intro_loop");
  common_scripts\utility::flag_set("debate_starting");
  thread debate_prep_player_gun();
  thread debate_prep_comm_gun();
  thread debate_prep_agent2_gun();
  thread debate_prep_hero_agent_gun();
  maps\_audio::aud_send_msg("start_typing");
  level.intro_origin thread maps\_anim::anim_single(var_0, "debate");
  level.intro_origin thread maps\_anim::anim_single_solo(level.commander, "debate", undefined, 0.04);
  thread hallway_commander();
  level.president thread debate_chair_anim("chair1", "debate_chair1");
  level.advisor thread debate_chair_anim("chair2", "debate_chair2");
  level.commander thread debate_chair_anim("chair3", "debate_chair3");
  level.secretary thread debate_chair_anim("chair4", "debate_chair4");
  level.polit_1 thread debate_chair_anim("chair5", "debate_chair5");
  level.polit_2 thread debate_chair_anim("chair6", "debate_chair6");
  level.polit_1 thread debate_chair_anim("chair8", "debate_chair8");
  level.commander pushplayer(1);
  level.president waittillmatch("single anim", "dialogue02");
  level.president thread maps\_utility::dialogue_queue("hijack_prs_worldsafe");
  level.president waittillmatch("single anim", "notify_gunshots");
  maps\_audio::aud_send_msg("conf_room_shots");
  maps\_audio::aud_send_msg("lets_kick_ass");
  thread debate_hallway_screams();
  thread debate_view_roll();
  thread debate_radio_chatter();
  wait 0.35;
  level.president scalevolume(0, 0.2);
  level.president waittillmatch("single anim", "notify_explosion");
  maps\_audio::aud_send_msg("conf_room_explosion1");
  maps\_audio::aud_send_msg("conf_room_plant_c4");
  thread debate_picture();
  thread debate_rumble();
  level.president waittillmatch("single anim", "playergun_up");
  thread debate_hijacker_vo();
  level.president waittillmatch("single anim", "notify_chargeplant");
  common_scripts\utility::flag_set("conf_explosion");
  level.lower_radio_org.deleteme = 1;
  level.president waittillmatch("single anim", "notify_hijack");
  thread debate_hijack_start();
  thread debate_advisor_end_loop();
  thread debate_agent2_end_loop();
  thread debate_pres_end_loop();
  thread debate_hero_agent_end_loop();
  thread hallway_plane_lurch();
  thread pre_zerog_behavior();
  level.president waittillmatch("single anim", "notify_rescue");
}

debate_hallway_screams() {
  var_0 = getEnt("hijack_screams", "targetname");
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

debate_prep_player_gun() {
  level.commander waittillmatch("single anim", "sub_cliff_ru1_hostact");
  setsaveddvar("bg_viewBobAmplitudeBase", level.org_vba_base);
  setsaveddvar("bg_viewBobAmplitudeStanding", level.org_vba_standing);
  level.player enableweapons();
  level.player allowcrouch(1);
  level.hero_agent_01 maps\_utility::gun_recall();
}

debate_prep_comm_gun() {
  level.commander waittillmatch("single anim", "pistol_pullout");
  level.commander maps\_utility::gun_recall();
  level.commander maps\_utility::forceuseweapon(level.commander.sidearm, "primary");
}

debate_prep_agent2_gun() {
  level.intro_agent2 waittillmatch("single anim", "pistol_pullout");
  level.intro_agent2 maps\_utility::gun_recall();
  level.intro_agent2 maps\_utility::forceuseweapon(level.intro_agent2.sidearm, "primary");
}

debate_prep_hero_agent_gun() {
  level.hero_agent_01 waittillmatch("single anim", "grab_gun");
  level.hero_agent_01 maps\_utility::gun_recall();
}

debate_hijacker_vo() {
  var_0 = getEnt("door_breach", "targetname");
  var_0 playSound("hijack_hj1_placecharge", "done1");
  var_0 waittill("done1");
  wait 0.2;
  var_0 playSound("hijack_hj2_standback", "done3");
  var_0 waittill("done3");
}

debate_rumble() {
  maps\_audio::aud_send_msg("rumble");
  earthquake(0.22, 4.5, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_medium");
  thread debate_rumble_lights();
  maps\_audio::aud_send_msg("seatbeltsign");
  maps\_audio::aud_send_msg("rumble_foley");

  foreach(var_1 in level.seatbeltsigns) {}
  var_1 show();

  thread debate_lurch_props();
  var_3 = getEntArray("conf_room_physics", "targetname");

  foreach(var_5 in var_3) {}
  physicsexplosionsphere(var_5.origin, 64, 32, 0.6);

  var_7 = getEntArray("conf_room_junk", "targetname");

  foreach(var_5 in var_7) {}
  var_5 thread maps\hijack_code::launch_object(randomintrange(120, 170), (0, -1, 0.05));

  thread debate_paper_chaos();
  level.player disableweapons();
  var_10 = distance(level.player.origin, level.commander.origin);

  if(var_10 > 50) {
    level.custom_linkto_slide = 1;
    var_11 = (7, 270, 0);
    var_12 = anglesToForward(var_11);
    level.player setvelocity(var_12 * 100);
    level.player maps\hijack_code::hjk_beginsliding();
    wait 0.6;
    level.player maps\hijack_code::hjk_endsliding();
  } else {
    wait 0.6;
  }
  setphysicsgravitydir((0, 0, -1));
  wait 1.5;
  level.player enableweapons();
  wait 1;
  thread hallway_picture_fall();
}

debate_view_roll() {
  wait 8.13;
  level notify("stop_rocking");
  common_scripts\utility::array_thread(level.arollers, ::debate_view_roll_obj);
  var_0 = maps\_utility::spawn_anim_model("conf_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "debate_cine_lurchcam");
  var_1 linkTo(var_0, "J_prop_1");
  var_0 maps\_anim::anim_single_solo(var_0, "debate_cine_lurchcam");
  level.player playersetgroundreferenceent(level.org_view_roll);
  thread maps\hijack_code::rockingplane();
  var_1 delete();
  var_0 delete();
}

debate_lurch_props() {
  var_0 = getEnt("debate_laptop", "targetname");
  var_0 delete();
  level.debate_laptop_off show();
  level.debate_laptop_off.animname = "debate_laptop";
  level.debate_laptop_off maps\_anim::setanimtree();
  level.intro_origin thread maps\_anim::anim_single_solo(level.debate_laptop_off, "debate_laptop_lurch");
  level.intro_origin thread maps\_anim::anim_single_solo(level.conf_phone_1, "debate_phone1_lurch");
  var_1 = getEnt("conf_phone2", "targetname");
  var_1.animname = "phone";
  var_1 maps\_anim::setanimtree();
  level.intro_origin thread maps\_anim::anim_single_solo(var_1, "debate_phone2_lurch");
  var_2 = getEnt("conf_room_tablet1", "targetname");
  var_3 = getEnt("conf_room_tablet2", "targetname");
  var_4 = getEnt("conf_room_closed_laptop", "targetname");
  var_5 = maps\_utility::spawn_anim_model("debate_prop");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_5, "debate_props_frnt_lurch");
  var_6 = maps\_utility::spawn_anim_model("debate_prop");
  level.intro_origin thread maps\_anim::anim_first_frame_solo(var_6, "debate_props_bck_lurch");
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
  var_4 linkTo(var_5, "J_prop_1");
  var_2 linkTo(var_5, "J_prop_2");
  var_3 linkTo(var_6, "J_prop_1");
  level.intro_origin thread maps\_anim::anim_single_solo(var_5, "debate_props_frnt_lurch");
  level.intro_origin thread maps\_anim::anim_single_solo(var_6, "debate_props_bck_lurch");
}

debate_radio_chatter() {
  level endon("conf_explosion");
  wait 7.5;
  level.lower_radio_org = spawn("script_origin", level.player.origin);
  level.lower_radio_org linkTo(level.player);
  level.lower_radio_org.linked = 1;
  maps\hijack_code::background_chatter("hijack_fso1_needbackup", level.lower_radio_org);
  wait 0.7;
  maps\hijack_code::background_chatter("hijack_fso2_gunshots", level.lower_radio_org);
  wait 1.1;
  maps\hijack_code::background_chatter("hijack_fso3_weaponsfree", level.lower_radio_org);
  wait 0.1;
  maps\hijack_code::background_chatter("hijack_fso2_alert", level.lower_radio_org);
}

debate_view_roll_obj() {
  var_0 = maps\_utility::spawn_anim_model("conf_roller", self.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "debate_cine_lurchcam");
  self linkTo(var_0, "J_prop_1");
  var_0 maps\_anim::anim_single_solo(var_0, "debate_cine_lurchcam");
  self unlink();
  var_0 delete();
}

debate_paper_chaos() {
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

debate_picture() {
  var_0 = getEnt("conf_picture", "targetname");
  var_0 maps\_utility::add_target_pivot();
  var_1 = var_0.pivot;
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

debate_rumble_lights() {
  var_0 = getEnt("conf_room_spot1", "targetname");
  var_1 = getEnt("conf_room_spot2", "targetname");
  var_2 = getEnt("conf_light1_on", "script_noteworthy");
  var_3 = getEnt("conf_light1_off", "script_noteworthy");

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

debate_hijack_start() {
  thread debate_player_react();
  common_scripts\utility::flag_set("door_breach");
  var_0 = getEnt("tv_destructor", "targetname");
  var_1 = getEnt("tv_destructor2", "targetname");
  magicbullet("ak74u", var_0.origin, var_1.origin);
  earthquake(0.3, 5.0, level.player.origin, 6000);
  var_2 = getEnt("door_breach", "targetname");
  level.player playFX(common_scripts\utility::getfx("conference_room_breach"), var_2.origin, anglesToForward((0, 0, 0)));
  level.door4 delete();
  var_3 = common_scripts\utility::getStructArray("breach_physics", "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5.radius;
    var_7 = 0.65;
    physicsexplosioncylinder(var_5.origin, var_6, var_6, var_7);
  }

  maps\_audio::aud_send_msg("conf_room_explosion2");
  var_9 = maps\_utility::spawn_targetname("conf_hijacker1");
  var_9.animname = "generic";
  var_9.ignoreme = 1;
  var_9.ignoreall = 1;
  var_9.allowdeath = 1;
  var_9.ragdoll_immediate = 1;
  var_9 pushplayer(1);
  var_9 maps\_utility::magic_bullet_shield();
  var_10 = maps\_utility::spawn_targetname("conf_hijacker2");
  var_10.animname = "generic";
  var_10.ignoreme = 1;
  var_10.ignoreall = 1;
  var_10.allowdeath = 1;
  var_10.ragdoll_immediate = 1;
  var_10 pushplayer(1);
  var_10 maps\_utility::magic_bullet_shield();
  level.secretary thread debate_scripted_die();
  level.polit_1 thread debate_scripted_polit_die("debate_cine_politician1_death_loop");
  level.polit_2 thread debate_scripted_polit_die("debate_cine_politician2_death_loop");
  level.intro_origin thread maps\_anim::anim_single_solo(var_9, "debate_cine_hijacker1_breach");
  var_9 thread debate_hijacker1_fx();
  var_9 thread debate_scripted_die();
  var_9 thread debate_hijacker1_gun();
  level.intro_origin thread maps\_anim::anim_single_solo(var_10, "debate_cine_hijacker2_breach");
  var_10 thread debate_scripted_die();
  var_10 thread debate_hijacker2_gun();
  level.commander thread debate_commander_fx(var_9, var_10);
  level.commander waittillmatch("single anim", "dropgun");
  level.commander.dropweapon = 1;
  level.commander animscripts\shared::dropaiweapon();
  var_11 = maps\_utility::spawn_targetname("conf_hijacker3");
  var_11 maps\_utility::set_fixednode_true();
  var_11.health = 1;
  var_11.deathanim = level.scr_anim["generic"]["stand_death_shoulder_spin"];
  level.commander waittillmatch("single anim", "swap_guns");
  level.commander maps\_utility::forceuseweapon("ak74u", "primary");
  level.commander.lastweapon = level.commander.weapon;
  var_9 maps\_utility::gun_remove();
  var_9 waittillmatch("single anim", "pistol_pullout");
  var_9 maps\_utility::forceuseweapon("fnfiveseven", "primary");
  var_9 maps\_shg_common::update_weapon_tag_visibility(var_9.primaryweapon);
  common_scripts\utility::flag_wait("kill_hijacker3");
  var_12 = getEnt("door_breach", "targetname");
  var_13 = common_scripts\utility::getStruct("bullet_behind", "targetname");

  if(isalive(var_11)) {
    if(maps\_utility::player_looking_at(var_12.origin)) {
      magicbullet("ak74u", var_13.origin, var_11.origin + (0, 0, 42));
    } else {
      magicbullet("ak74u", var_12.origin, var_11.origin + (0, 0, 42));
    }
  }
}

debate_commander_fx(var_0, var_1) {
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

debate_hijacker1_fx() {
  var_0 = common_scripts\utility::getfx("flesh_hit_body_fatal_exit");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level.polit_1, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level.secretary, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level.advisor, "tag_weapon_chest");
  self waittillmatch("single anim", "fire");
  self waittillmatch("single anim", "fire");
  playFXOnTag(var_0, level.polit_2, "tag_weapon_chest");
}

#using_animtree("generic_human");

debate_hijacker1_gun() {
  var_0 = % hijack_debate_cine_hijacker1_breach;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "start_ragdoll")[0];
  var_3 = var_1 * var_2;
  wait(var_3 - 0.1);
  animscripts\shared::dropaiweapon();
}

debate_hijacker2_gun() {
  var_0 = % hijack_debate_cine_hijacker2_breach;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "start_ragdoll")[0];
  var_3 = var_1 * var_2;
  wait(var_3 - 0.5);
  animscripts\shared::dropaiweapon();
  common_scripts\utility::flag_set("kill_hijacker3");
}

debate_player_react() {
  common_scripts\utility::flag_clear("player_away_from_door");
  wait 0.05;
  var_0 = common_scripts\utility::getStruct("player_slide_location", "targetname");
  var_0.origin = (var_0.origin[0], var_0.origin[1], level.player.origin[2]);
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player shellshock("hijack_door_explosion", 5);
  level.player disableweapons();
  level.player freezecontrols(1);
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_1.angles = level.player.angles;
  level.player playerlinkTo(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 thread maps\_anim::anim_single_solo(var_1, "debate_react_player");
  wait 0.05;

  if(common_scripts\utility::flag("player_away_from_door")) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_1 linkTo(var_2);
    var_2 moveTo((-28436, 12728, level.player.origin[2]), 0.25, 0, 0.1);
  }

  var_1 waittillmatch("single anim", "end");
  level.player freezecontrols(0);
  level.player unlink();
  var_1 delete();
  wait 1.3;
  level.player enableweapons();
  level.player maps\_utility::blend_movespeedscale(0.85, 5);
  level.player allowcrouch(1);
  level.player allowprone(1);
  thread hallway_nag1();
}

debate_scripted_die() {
  self endon("death");
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self waittillmatch("single anim", "start_ragdoll");

  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }
  self kill();
}

debate_scripted_polit_die(var_0) {
  self endon("death");
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self waittillmatch("single anim", "end");

  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }
  level.intro_origin thread maps\_anim::anim_loop_solo(self, var_0);
  self invisiblenotsolid();
}

debate_advisor_end_loop() {
  level.advisor waittillmatch("single anim", "end");
  level.intro_origin thread maps\_anim::anim_loop_solo(level.advisor, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
}

debate_pres_end_loop() {
  level endon("zero_g_trig");
  level.president waittillmatch("single anim", "end");
  level.intro_origin thread maps\_anim::anim_loop_solo(level.president, "debate_cine_president_end_loop", "stop_pres_debate_loop");
}

debate_hero_agent_end_loop() {
  level endon("zero_g_trig");
  level.hero_agent_01 waittillmatch("single anim", "end");
  level.intro_origin thread maps\_anim::anim_loop_solo(level.hero_agent_01, "debate_cine_hero_agent_end_loop", "stop_pres_debate_loop");
}

debate_agent2_end_loop() {
  level endon("zero_g_trig");
  level.intro_agent2 waittillmatch("single anim", "end");

  if(isalive(level.intro_agent2) && isDefined(level.intro_agent2)) {
    level.intro_origin thread maps\_anim::anim_loop_solo(level.intro_agent2, "debate_cine_agent2_end_loop", "stop_debate_loop");
  }
}

debate_status_vo() {
  wait 7.25;
  maps\_utility::radio_dialogue("hijack_fso2_resistance");
  wait 0.5;
  maps\_audio::aud_send_msg("failing_engine");
  wait 1;
  maps\_utility::radio_dialogue("hijack_plt_losingcontrol");
  wait 1.1;
  maps\_utility::radio_dialogue("hijack_plt_stalled");
}

intro_tv_off() {
  level.secretary waittillmatch("single anim", "trigger_tv");
  common_scripts\utility::flag_set("tv_off");
  maps\_audio::aud_send_msg("stop_news");
  stopcinematicingame();
  level.secretary waittillmatch("single anim", "drop_remote");
  level.remote unlink();
  thread intro_close_door3();
}

screen_movies() {
  wait 1;
  setsaveddvar("cg_cinematicFullScreen", "0");
  thread map_movies();

  for(;;) {
    common_scripts\utility::flag_clear("tv_video_on");
    common_scripts\utility::flag_wait("tv_video_on");
    thread tv_movies();
    common_scripts\utility::flag_clear("map_video_on");
    common_scripts\utility::flag_wait("map_video_on");
    thread map_movies();
  }
}

map_movies() {
  wait 0.05;
  level endon("tv_video_on");
  setsaveddvar("cg_cinematicFullScreen", "0");

  for(;;) {
    start_movie_loop(0);
  }
}

tv_movies() {
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
    start_movie_loop(1);
  }
}

start_movie_loop(var_0) {
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

hallway_commander() {
  thread hallway_jet_flyby();
  level.commander maps\_utility::enable_cqbwalk();
  level.commander.disableexits = 1;
  var_0 = % hijack_debate_cine_commander;
  var_1 = getanimlength(var_0);
  wait(var_1 - 5);
  maps\_audio::aud_send_msg("pre_turbulence_ready");
  common_scripts\utility::flag_clear("hero_agent_stumble");
  common_scripts\utility::flag_set("move_pres");
  maps\_utility::battlechatter_on("axis");
  level.hero_agent_01 maps\_utility::enable_ai_color_dontmove();
  level.president maps\_utility::enable_ai_color_dontmove();
  level.commander.turnrate = 0.1;
  level.commander.dontevershoot = 1;
  level.commander allowedstances("stand");
  level.commander.disablereload = 1;

  if(!common_scripts\utility::flag("hero_agent_stumble")) {
    var_2 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
    var_2 maps\_anim::anim_reach_solo(level.commander, "hero_stumble");
  }

  thread maps\_utility::autosave_by_name("conference_room_breached");
  common_scripts\utility::flag_wait("hero_agent_stumble");
  thread debate_status_vo();
  level.commander.disableexits = 0;
  level.commander.turnrate = 0.3;
  level.intro_origin notify("stop_corner_loop");
  waittillframeend;
  var_2 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  var_2 maps\_anim::anim_reach_solo(level.commander, "hero_stumble");
  level.commander.goalradius = 16;
  var_3 = getnode("commander_zerog", "targetname");
  level.commander setgoalnode(var_3);
  level.commander.dontevershoot = undefined;

  if(!common_scripts\utility::flag("player_ahead")) {
    common_scripts\utility::flag_set("cmdr_stumbling");
    var_2 thread maps\_anim::anim_single_run_solo(level.commander, "hero_stumble");
    maps\_audio::aud_send_msg("hijk_agent_stumblehit");
  }

  level.commander allowedstances("stand", "crouch");
  level.commander.disablereload = undefined;
}

hallway_nag1() {
  level endon("hero_agent_stumble");

  while(!common_scripts\utility::flag("hero_agent_stumble")) {
    wait 12;
    level.commander maps\_utility::dialogue_queue("hijack_cmd_onme");
  }
}

hallway_jet_flyby() {
  common_scripts\utility::flag_wait("go_jets3");
  wait 2;
  level.jet_3a = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_3a");
  level.jet_3b = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("mig_3b");
  level.jet_3a maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_3b maps\_vehicle::vehicle_kill_rumble_forever();
  level.jet_3a thread hide_jet_parts();
  level.jet_3b thread hide_jet_parts();
}

hallway_plane_lurch() {
  level.hallway_roller = maps\_utility::spawn_anim_model("upperhall_roller", level.player.origin);
  level.hallway_roller.angles = (0, 0, 0);
  common_scripts\utility::flag_wait_any("player_ahead", "cmdr_stumbling");
  level notify("stop_rocking");
  thread hallway_props();
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_0);
  thread maps\hijack_code::set_grav(var_0);
  level.hallway_roller maps\_anim::anim_first_frame_solo(level.hallway_roller, "hallway_lurchcam");
  var_0 linkTo(level.hallway_roller, "J_prop_1");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    maps\_audio::aud_send_msg("hallway_lurch", 1);
    level.player playRumbleOnEntity("hijack_plane_medium");
    level.hallway_roller thread maps\_anim::anim_single_solo(level.hallway_roller, "hallway_lurchcam");
    level.hallway_roller waittillmatch("single anim", "corpse_slump");
    thread hallway_sun();
    thread hallway_player_slide();
    common_scripts\utility::array_thread(level.arollers, ::hallway_view_roll_obj);
    level.hallway_roller waittillmatch("single anim", "end");
  }

  level notify("stop_rocking");

  if(!common_scripts\utility::flag("zero_g_trig")) {
    maps\_audio::aud_send_msg("rumble");
    level.hallway_roller maps\_anim::anim_loop_solo(level.hallway_roller, "hallway_lurchcam_loop", "stop_hallway_shake");
  }

  var_0 delete();
  level.hallway_roller delete();
}

hallway_view_roll_obj() {
  var_0 = maps\_utility::spawn_anim_model("upperhall_roller", self.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "hallway_godraycam");
  self linkTo(var_0, "J_prop_1");
  var_0 thread maps\_anim::anim_single_solo(var_0, "hallway_godraycam");
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

hallway_sun() {
  lerpsunangles(level.orig_sundirection, (-38.8, 121.9, 16.7), 1.5, 0, 0.2);
  common_scripts\utility::flag_wait("hallsun_right");
  lerpsunangles((-38.8, 121.9, 16.7), (-9.9, 113.4, -2.2), 1.7, 0.3, 0.2);
  common_scripts\utility::flag_wait("hallsun_left");
  lerpsunangles((-9.9, 113.4, -2.2), (-17.5, 114.6, 2), 0.8, 0.1, 0.1);
  common_scripts\utility::flag_wait("hallsun_right2");
  lerpsunangles((-17.5, 114.6, 2), (-13.5, 114, -0.5), 0.7, 0.1, 0.1);
  common_scripts\utility::flag_wait("hallsun_left2");
  lerpsunangles((-13.5, 114, -0.5), level.orig_sundirection, 0.25, 0, 0.1);
  common_scripts\utility::flag_clear("hallsun_right");
  common_scripts\utility::flag_clear("hallsun_left");
  common_scripts\utility::flag_clear("hallsun_right2");
  common_scripts\utility::flag_clear("hallsun_left2");
}

hallway_player_slide() {
  wait 1.25;
  var_0 = (0, 90, 0);
  var_1 = anglesToForward(var_0);
  level.player setvelocity(var_1 * 100);
  level.player maps\hijack_code::hjk_beginsliding();
  wait 1.5;
  level.player maps\hijack_code::hjk_endsliding();
}

hallway_picture_fall() {
  var_0 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  var_1 = getEnt("hallway_floor_painting", "targetname");
  var_2 = maps\_utility::spawn_anim_model("upperhall_cabinet");
  waittillframeend;
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "hallway_picture_fall");
  var_3 = var_2 gettagorigin("J_prop_2");
  var_4 = var_2 gettagangles("J_prop_2");
  var_5 = -1 * var_4[0];
  var_6 = 180 + var_4[1];
  var_4 = (var_5, var_6, var_4[2]);
  var_1.origin = var_3;
  var_1.angles = var_4;
  var_1 linkTo(var_2, "J_prop_2");
  common_scripts\utility::flag_wait_any("player_ahead", "cmdr_stumbling");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    var_0 maps\_anim::anim_single_solo(var_2, "hallway_picture_fall");
    var_0 maps\_anim::anim_last_frame_solo(var_2, "hallway_picture_fall");
  }

  common_scripts\utility::flag_wait("zero_g_trig");
  var_2 delete();
}

hallway_props() {
  var_0 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  var_1 = getEnt("hallway_cabinet_door", "targetname");
  var_2 = maps\_utility::spawn_anim_model("upperhall_cabinet", var_1.origin);
  var_2.angles = (0, 0, 0);
  waittillframeend;
  var_0 thread maps\_anim::anim_first_frame_solo(var_2, "hallway_cabinet_open");
  var_1 linkTo(var_2, "J_prop_1");

  if(!common_scripts\utility::flag("pre_zerog_checkpoint")) {
    var_0 maps\_anim::anim_single_solo(var_2, "hallway_cabinet_open");
  }
  var_0 maps\_anim::anim_loop_solo(var_2, "hallway_cabinet_loop", "end_cabinet_loop");
  common_scripts\utility::flag_wait("zero_g_trig");
  level notify("end_cabinet_loop");
  var_2 delete();
}

constant_rumble() {
  level endon("stop_constant_shake");

  for(;;) {
    earthquake(0.09, 0.05, level.player.origin, 200);
    wait 0.05;
  }
}

hallway_carnage() {
  common_scripts\utility::flag_wait("cansee_zerog_room");

  if(isDefined(level.intro_agent2)) {
    level.intro_agent2 maps\_utility::forceuseweapon("ak74u", "primary");
  }
  var_0 = maps\_utility::spawn_targetname("dying_agent1");
  var_0.animname = "generic";
  var_0 maps\_utility::gun_remove();
  var_0.health = 1;
  var_0.ignoreexplosionevents = 1;
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0.ignorerandombulletdamage = 1;
  var_0.grenadeawareness = 0;
  var_0.no_pain_sound = 1;
  var_0.noragdoll = 1;
  var_0.a.nodeath = 1;
  maps\_utility::add_cleanup_ent(var_0, "pre_zerog_guys");
  var_0 maps\_utility::force_crawling_death(var_0.angles[1], 2, level.scr_anim["crawl_death_1"], 1);
  var_0 dodamage(1, var_0.origin + (16, 0, 16));

  if(isDefined(level.zerog_agent_01)) {
    level.zerog_agent_01 thread maps\hijack::player_damage_to_friendlies();
  }
  if(isDefined(level.zerog_agent_02)) {
    level.zerog_agent_02 thread maps\hijack::player_damage_to_friendlies();
  }
  if(isDefined(level.zerog_agent_03)) {
    level.zerog_agent_03 thread maps\hijack::player_damage_to_friendlies();
  }
}

hallway_dead_civilians(var_0, var_1) {
  var_2 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  self.allowdeath = 1;
  self.animname = "generic";
  self.health = 1;
  self.noragdoll = 1;
  self.no_pain_sound = 1;
  self.diequietly = 1;
  self.a.nodeath = 1;
  self.delete_on_death = 0;
  self.nofriendlyfire = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  maps\_utility::gun_remove();
  maps\hijack_code::no_grenades();
  self invisiblenotsolid();
  var_2 thread maps\_anim::anim_loop_solo(self, var_0, "dead_guys_loop");
  level.hallway_roller waittillmatch("single anim", "corpse_slump");
  var_2 maps\_anim::anim_single_solo(self, var_1);
  self kill();
}

pre_zerog_behavior() {
  var_0 = maps\_utility::spawn_targetname("dead_assistant");
  var_0 thread hallway_dead_civilians("hallway_dead_pose_assistant", "hallway_slump_assistant");
  var_1 = maps\_utility::spawn_targetname("dead_agent");
  var_1 thread hallway_dead_civilians("hallway_dead_pose_agent", "hallway_slump_agent");
  var_2 = maps\_utility::spawn_targetname("dead_terrorist");
  var_2 thread hallway_dead_civilians("hallway_dead_pose_terrorist", "hallway_slump_terrorist");
  level.hero_agent_01.ignoreme = 1;
  level.hero_agent_01.ignoreall = 1;
  level.zerog_agent_01 = maps\hijack_code::spawn_ally("zerog_agent_01");
  level.zerog_agent_02 = maps\hijack_code::spawn_ally("zerog_agent_02");
  var_3 = getnode("agent1_prezero_cover2", "targetname");
  level.zerog_agent_01 setgoalnode(var_3);
  var_4 = getnode("agent2_prezero_cover2", "targetname");
  level.zerog_agent_02 setgoalnode(var_4);
  level.zerog_agent_03 = maps\_utility::spawn_targetname("zerog_agent_03");
  level.zerog_agent_03 thread maps\_utility::magic_bullet_shield();
  level.zerog_agent_03 maps\hijack_code::no_grenades();
  level.zerog_agent_03.script_pushable = 0;
  level.zerog_agent_03.baseaccuracy = 0.1;
  level.zerog_agent_03.ignoresuppression = 1;
  var_5 = getnode("agent3_prezero_cover", "targetname");
  level.zerog_agent_03 setgoalnode(var_5);
  var_6 = getEnt("pre_zerog_spawn", "targetname");
  var_6 useby(level.player);
  common_scripts\utility::flag_wait("cansee_zerog_room");
  thread maps\_utility::autosave_now_silent();
  level.hero_agent_01 allowedstances("crouch", "stand", "prone");
  level.pre_zerog_guys = maps\_utility::get_living_ai_array("pre_zerog_terrorists", "script_noteworthy");
  common_scripts\utility::array_thread(level.pre_zerog_guys, ::stop_pre_zerog_behavior);
  common_scripts\utility::flag_wait("prezerog_extra_guys");
  var_7 = maps\_utility::spawn_targetname("pre_zerog_terrorist_wave2");
  level.pre_zerog_guys = maps\_utility::get_living_ai_array("pre_zerog_terrorists", "script_noteworthy");
}

stop_pre_zerog_behavior() {
  thread player_damage_watcher("stop_me");
  common_scripts\utility::flag_wait("stop_me");
  wait 0.5;

  if(isalive(self)) {
    maps\_utility::stop_magic_bullet_shield();
  }
}

zerog() {
  level.zerog_origin = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  common_scripts\utility::flag_wait("zero_g_trig");
  var_0 = randomfloatrange(0.25, 0.75);
  wait(var_0);
  level.player disableweapons();
  wait 0.25;
  level notify("stop_rocking");
  common_scripts\utility::flag_set("stop_constant_shake");
  level.hallway_roller notify("stop_hallway_shake");
  maps\_audio::aud_send_msg("zero_g_start");
  thread pre_zerog_cleanup();
  thread zerog_player_anim();
  thread zerog_anims();
  thread zerog_props();
  thread zerog_physics();
  wait 0.5;
  setsaveddvar("phys_gravityChangeWakeupRadius", 3200);
  setsaveddvar("ragdoll_max_life", 3600000);
}

zerog_player_anim() {
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

  level.zerog_player_rig = maps\_utility::spawn_anim_model("test_body", level.zerog_origin.origin);
  level.player playersetgroundreferenceent(level.zerog_player_rig);
  level.player playerlinktoblend(level.zerog_player_rig, "tag_origin", 0.5, 0, 0);
  level.zerog_origin thread maps\_anim::anim_single_solo(level.zerog_player_rig, "zero_g_player");
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
  level.player playerlinktoblend(level.zerog_player_rig, "tag_origin", 1, 0, 0);
  level.zerog_player_rig waittillmatch("single anim", "player_hit_floor");
  setsaveddvar("phys_gravityChangeWakeupRadius", level.orig_wakeupradius);
  setsaveddvar("ragdoll_max_life", level.orig_ragdoll_life);
  level.player disableweapons();
  level.player shellshock("hijack_airplane", 3.0);
  level.player playersetgroundreferenceent(level.org_view_roll);
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
  level.zerog_player_rig waittillmatch("single anim", "end");
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

  thread zerog_swap_destruct_fx();
  thread constant_rumble();
  level.player unlink();
  level.zerog_player_rig delete();
  level.player enableweapons();
  level.player allowsprint(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  wait 2;
  maps\_utility::autosave_now();
}

pre_zerog_cleanup() {
  level.pre_zerog_guys = maps\_utility::get_living_ai_array("pre_zerog_terrorists", "script_noteworthy");

  foreach(var_1 in level.pre_zerog_guys) {
    if(isDefined(var_1.magic_bullet_shield)) {
      var_1 maps\_utility::stop_magic_bullet_shield();
    }
    var_1 kill(level.zerog_agent_03.origin, level.zerog_agent_03);
  }

  level.intro_origin notify("stop_debate_loop");
  wait 0.5;

  if(isalive(level.secretary) && isDefined(level.secretary)) {
    if(isDefined(level.secretary.magic_bullet_shield)) {
      level.secretary maps\_utility::stop_magic_bullet_shield();
    }
    level.secretary delete();
  }

  if(isalive(level.intro_agent2) && isDefined(level.intro_agent2)) {
    if(isDefined(level.intro_agent2.magic_bullet_shield)) {
      level.intro_agent2 maps\_utility::stop_magic_bullet_shield();
    }
    level.intro_agent2 delete();
  }

  if(isalive(level.polit_1) && isDefined(level.polit_1)) {
    if(isDefined(level.polit_1.magic_bullet_shield)) {
      level.polit_1 maps\_utility::stop_magic_bullet_shield();
    }
    level.polit_1 delete();
  }

  if(isalive(level.polit_2) && isDefined(level.polit_2)) {
    if(isDefined(level.polit_2.magic_bullet_shield)) {
      level.polit_2 maps\_utility::stop_magic_bullet_shield();
    }
    level.polit_2 delete();
  }

  level.commander maps\_utility::disable_ai_color();
  level.hero_agent_01 maps\_utility::disable_ai_color();
  level.president maps\_utility::disable_ai_color();
  level.commander hide();
  level.zerog_agent_03 hide();
  level.president hide();
  level.hero_agent_01 hide();
  level.intro_origin notify("stop_pres_debate_loop");

  if(isDefined(level.cleanup_ents) && isDefined(level.cleanup_ents["pre_zerog_guys"])) {
    maps\_utility::cleanup_ents("pre_zerog_guys");
  }
  maps\_utility::battlechatter_off("axis");
}

zerog_anims() {
  level.zerog_guys = maps\_utility::array_spawn_targetname("zerog_terrorists");
  common_scripts\utility::array_thread(level.zerog_guys, ::zerog_terrorist_setup);
  var_0 = maps\_utility::get_living_ai("zerog_terrorist1", "script_noteworthy");
  var_1 = maps\_utility::get_living_ai("zerog_terrorist2", "script_noteworthy");
  var_2 = maps\_utility::get_living_ai("zerog_terrorist3", "script_noteworthy");
  var_3 = maps\_utility::get_living_ai("zerog_terrorist4", "script_noteworthy");
  var_4 = maps\_utility::get_living_ai("zerog_terrorist5", "script_noteworthy");
  var_0 thread zerog_terrorist_anim("zerog_terror1_track", "zerog_terrorist_01_align", %hijack_zerog_terrorist_01_alive, %hijack_zerog_terrorist_01_dead);
  var_1 thread zerog_terrorist_anim("zerog_terror2_track", "zerog_terrorist_02_align", %hijack_zerog_terrorist_02_alive, %hijack_zerog_terrorist_02_dead);
  var_2 thread zerog_terrorist_anim("zerog_terror3_track", "zerog_terrorist_03_align", %hijack_zerog_terrorist_03_alive, %hijack_zerog_terrorist_03_dead);
  var_3 thread zerog_terrorist_anim("zerog_terror4_track", "zerog_terrorist_04_align", %hijack_zerog_terrorist_04_alive, %hijack_zerog_terrorist_04_dead);
  var_4 thread zerog_terrorist_anim("zerog_terror5_track", "zerog_terrorist_05_align", %hijack_zerog_terrorist_05_alive, %hijack_zerog_terrorist_05_dead);
  level.zerog_origin thread maps\_anim::anim_single_solo(level.zerog_agent_01, "zerog_moment");
  level.zerog_origin thread maps\_anim::anim_single_solo(level.zerog_agent_02, "zerog_moment");
  wait 0.1;
  level.zerog_agent_01.baseaccuracy = 100;
  level.zerog_agent_01.ignoreall = 1;
  level.zerog_agent_02.baseaccuracy = 100;
  level.zerog_agent_02.ignoreall = 1;
  thread zerog_done_agents();
}

zerog_terrorist_setup() {
  thread maps\hijack_code::no_grenades();
  self.animname = self.script_noteworthy;
  self.ignoreme = 1;
  maps\_utility::disable_pain();
}

zerog_terrorist_anim(var_0, var_1, var_2, var_3) {
  thread achieve_flight_attendant();
  self.anim_1 = var_2;
  self.anim_2 = var_3;
  var_4 = maps\_utility::spawn_anim_model(var_0);
  self.rigname = var_4;
  self.riganim = var_1;
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(var_4, var_1);

  if(self.animname == "zerog_terrorist4" || self.animname == "zerog_terrorist5") {
    self forceteleport(var_4.origin, var_4.angles);
  } else {
    self forceteleport(var_4.origin, var_4.angles + (0, -90, 0));
  }
  self linkTo(var_4, "J_prop_1");
  level.zerog_origin thread maps\_anim::anim_single_solo(var_4, var_1);
  self animcustom(::hijack_anim_custom);
  self.deathfunction = ::hijack_anim_death;
}

achieve_flight_attendant() {
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_0) || var_0 != level.player) {
    return;
  }
  if(!isDefined(level.player.achieve_flight_attendant)) {
    level.player.achieve_flight_attendant = 1;
  } else {
    level.player.achieve_flight_attendant++;
  }
  if(level.player.achieve_flight_attendant == 5) {
    level.player maps\_utility::player_giveachievement_wrapper("FLIGHT_ATTENDANT");
  }
}

hijack_anim_custom() {
  var_0 = "single anim";
  self clearanim(%root, 0.1);
  self setflaggedanim(var_0, self.anim_1, 1);
  thread maps\_anim::start_notetrack_wait(self, var_0, self.anim_1, self.animname);
  thread maps\_anim::animscriptdonotetracksthread(self, var_0, self.anim_1);

  if(self.animname == "zerog_terrorist3") {
    thread zerog_terrorist3_kill();
  } else if(self.animname != "zerog_terrorist4") {
    thread zerog_kill(self.anim_1);
  }
  self waittill("death");
}

hijack_anim_death(var_0, var_1) {
  self endon("scripted_death");
  common_scripts\utility::flag_set("custom_death");
  var_2 = "single anim";
  animscripts\shared::dropaiweapon();
  var_3 = randomintrange(0, 5);

  if(var_3 == level.last_death_index) {
    var_3 = var_3 + 1;

    if(var_3 == 5) {
      var_3 = 0;
    }
  }

  level.last_death_index = var_3;

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

  var_4 = self getanimtime(self.anim_1);
  self clearanim(self.anim_1, 0.2);
  self setflaggedanim(var_2, self.anim_2, 1);
  thread maps\_anim::start_notetrack_wait(self, var_2, self.anim_2, self.animname);
  thread maps\_anim::animscriptdonotetracksthread(self, var_2, self.anim_2);
  self setanimtime(self.anim_2, var_4);
  self setanimlimited(%zero_g_shot, 0.95, 0);
  wait 1.0;
  self clearanim(%zero_g_shot, 0.5);

  if(self.animname == "zerog_terrorist3") {
    self waittillmatch("single anim", "unlink");
    var_5 = self getanimtime(self.anim_2);
    var_0 = [];
    var_0[0] = self.rigname;
    level.zerog_origin maps\_anim::anim_first_frame_solo(self.rigname, self.riganim);
    level.zerog_origin maps\_anim::anim_set_time(var_0, self.riganim, var_5);
  }
}

zerog_kill(var_0) {
  self endon("custom_death");
  self waittillmatch("single anim", "zero_g_die");
  common_scripts\utility::flag_set("scripted_death");

  if(!isalive(self)) {
    return;
  }
  self.deathfunction = undefined;
  self.forceragdollimmediate = 0;
  self.a.nodeath = 1;
  animscripts\shared::dropaiweapon();
  wait 0.05;
  self kill();
}

zerog_props() {
  thread zerog_extra_props();
  var_0 = getEnt("luggage01", "script_noteworthy");
  var_1 = getEnt("luggage02", "script_noteworthy");
  var_2 = getEnt("luggage03", "script_noteworthy");
  var_3 = getEnt("luggage04", "script_noteworthy");
  var_4 = getEnt("luggage05", "script_noteworthy");
  var_5 = getEnt("luggage06", "script_noteworthy");
  var_6 = getEnt("luggage07", "script_noteworthy");
  var_7 = getEnt("luggage08", "script_noteworthy");
  var_8 = getEnt("zerog_box01", "script_noteworthy");
  var_9 = getEnt("zerog_box02", "script_noteworthy");
  var_10 = getEnt("overhead_door_r", "targetname");
  var_11 = getEnt("overhead_door_l_1", "targetname");
  var_12 = getEnt("overhead_door_l_2", "targetname");
  var_13 = getEnt("foodcart", "targetname");
  var_14 = getEnt("zerog_laptop", "targetname");
  var_15 = getEnt("air_mask_module_r", "targetname");
  var_16 = getEnt("air_mask_module_l", "targetname");
  var_0 thread zerog_destructible_prop("zerog_suitcase1");
  var_1 thread zerog_destructible_prop("zerog_suitcase2");
  var_2 thread zerog_destructible_prop("zerog_suitcase3");
  var_3 thread zerog_destructible_prop("zerog_suitcase4");
  var_4 thread zerog_destructible_prop("zerog_suitcase5");
  var_5 thread zerog_destructible_prop("zerog_suitcase6");
  var_6 thread zerog_destructible_prop("zerog_suitcase7");
  var_7 thread zerog_destructible_prop("zerog_suitcase8");
  var_8 thread zerog_destructible_prop("zerog_squarebox");
  var_9 thread zerog_destructible_prop("zerog_rectanglebox");
  var_10 thread zerog_door_behavior("zerog_overhead_door_r");
  var_13 thread zerog_destructible_prop("zerog_mealcart");
  var_14 thread zerog_animated_prop("zerog_laptop", "zerog_laptop");
  var_15 thread zerog_animated_prop("zerog_o2_module", "zerog_o2_module_r");
  var_16 thread zerog_animated_prop("zerog_o2_module", "zerog_o2_module_l");
  var_17 = maps\_utility::spawn_anim_model("zerog_prop");
  var_17 setModel("generic_prop_raven");
  var_17 maps\_anim::setanimtree();
  waittillframeend;
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(var_17, "zerog_overhead_door_l");
  var_11 linkTo(var_17, "J_prop_1");
  var_12 linkTo(var_17, "J_prop_2");
  common_scripts\utility::flag_wait("zero_g_trig");
  level.zerog_origin thread maps\_anim::anim_single_solo(var_17, "zerog_overhead_door_l");
  common_scripts\utility::flag_wait("plane_third_hit");
  wait 0.5;
  var_8 dodamage(var_8.health + 100, var_8.origin);
  wait 0.2;
  var_9 dodamage(var_9.health + 100, var_9.origin);
}

#using_animtree("animated_props");

zerog_extra_props() {
  level.extra_props_left = common_scripts\utility::getStruct("extra_door_left", "targetname");
  level.extra_props_right = common_scripts\utility::getStruct("extra_door_right", "targetname");
  var_0 = getEnt("overhead_door_r_2", "targetname");
  var_1 = getEnt("overhead_door_l_3", "targetname");
  var_2 = getEnt("zerog_box03", "script_noteworthy");
  var_2 setCanDamage(1);
  var_3 = maps\_utility::spawn_anim_model("zerog_prop");
  var_3 setModel("generic_prop_raven");
  var_3 maps\_anim::setanimtree();
  waittillframeend;
  var_4 = maps\_utility::spawn_anim_model("zerog_prop");
  var_4 setModel("generic_prop_raven");
  var_4 maps\_anim::setanimtree();
  var_5 = maps\_utility::spawn_anim_model("zerog_prop");
  var_5 setModel("generic_prop_raven");
  var_5 maps\_anim::setanimtree();
  waittillframeend;
  level.extra_props_left thread maps\_anim::anim_first_frame_solo(var_4, "zerog_overhead_door_l");
  var_1 linkTo(var_4, "J_prop_2");
  level.extra_props_left thread maps\_anim::anim_first_frame_solo(var_3, "zerog_rectanglebox");
  var_2 linkTo(var_3, "J_prop_1");
  level.extra_props_right thread maps\_anim::anim_first_frame_solo(var_5, "zerog_overhead_door_r");
  var_0 linkTo(var_5, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  wait 1.75;
  level.extra_props_left thread maps\_anim::anim_single_solo(var_4, "zerog_overhead_door_l");
  var_4 setanimtime(%hijack_zerog_overhead_door_l, 0.65);
  level.extra_props_left thread maps\_anim::anim_single_solo(var_3, "zerog_rectanglebox");
  var_3 setanimtime(%hijack_zerog_rectanglebox, 0.65);
  wait 0.2;
  level.extra_props_right thread maps\_anim::anim_single_solo(var_5, "zerog_overhead_door_r");
  wait 0.3;
  var_2 dodamage(var_2.health + 100, var_2.origin);
}

zerog_swap_destruct_fx() {
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

zerog_destructible_prop(var_0) {
  self setCanDamage(1);
  var_1 = maps\_utility::spawn_anim_model("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::setanimtree();
  waittillframeend;
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(var_1, var_0);
  self linkTo(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level.zerog_origin maps\_anim::anim_single_solo(var_1, var_0);
  waittillframeend;
  var_1 delete();
}

zerog_indestructible_prop(var_0) {
  self.health = 5;
  self setCanDamage(1);
  var_1 = maps\_utility::spawn_anim_model("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::setanimtree();
  waittillframeend;
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(var_1, var_0);
  self linkTo(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level.zerog_origin thread maps\_anim::anim_single_solo(var_1, var_0);
  self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_1 stopanimScripted();
  self unlink();
  self physicslaunchclient(var_5, var_4);
  var_1 delete();
}

zerog_animated_prop(var_0, var_1) {
  self.animname = var_0;
  maps\_anim::setanimtree();
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(self, var_1);
  common_scripts\utility::flag_wait("zero_g_trig");
  level.zerog_origin maps\_anim::anim_single_solo(self, var_1);
}

zerog_door_behavior(var_0) {
  var_1 = maps\_utility::spawn_anim_model("zerog_prop");
  var_1 setModel("generic_prop_raven");
  var_1 maps\_anim::setanimtree();
  waittillframeend;
  level.zerog_origin thread maps\_anim::anim_first_frame_solo(var_1, var_0);
  self linkTo(var_1, "J_prop_1");
  common_scripts\utility::flag_wait("zero_g_trig");
  level.zerog_origin maps\_anim::anim_single_solo(var_1, var_0);
}

zerog_physics() {
  level endon("zero_g_done");

  for(;;) {
    physicsjitter((-27290, 12784, 7340), 500, 450, 0.1, 0.2);
    wait 0.05;
  }
}

player_physics_explosion() {
  level endon("zero_g_done");

  for(;;) {
    physicsexplosionsphere(level.player.origin, 64, 32, 0.01);
    wait 0.05;
  }
}

zerog_firsthit(var_0) {
  level.player playRumbleOnEntity("hijack_plane_large");
  level.player disableweapons();
  earthquake(0.15, 0.6, level.player.origin, 6000);
  level.player shellshock("hijack_minor", 1.5);
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (0, 0, 12), 1, 0, 0);
  lerpsunangles((-5, 114, 0), (-24, 96, 0), 1);
  wait 0.4;
  var_1 = getEntArray("zerog_physics", "targetname");

  foreach(var_3 in var_1) {}
  physicsexplosionsphere(var_3.origin, 64, 32, 0.45);

  wait 0.3;
  setphysicsgravitydir((0, 0, -0.02));
  maps\_audio::aud_send_msg("zero_g_bodyslam2");
  wait 0.7;
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (0, 0, 0), 0.75, 0, 0);
  setphysicsgravitydir((0, -0.02, -1));
}

zerog_flyup(var_0) {
  level endon("plane_roll_right");
  objective_delete(maps\_utility::obj("move_president"));
  thread player_physics_explosion();
  setphysicsgravitydir((0.02, -0.01, 0.08));
  setsaveddvar("phys_gravity", -5);
  setsaveddvar("phys_gravity_ragdoll", -100);
  wait 2.0;
  thread maps\_utility::radio_dialogue("hijack_plt_inadive");
  wait 0.5;
  level.player playerlinktodelta(level.zerog_player_rig, "tag_origin", 1, 180, 180, 60, 60);
  level.player enableweapons();
}

zerog_planedive(var_0) {
  level.player enableinvulnerability();
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (-35, 0, 0), 4, 0, 2);
  lerpsunangles((-24, 96, 0), (-11, 60, 0), 3);
  wait 1.75;
  setphysicsgravitydir((0.03, 0, 0.05));
  wait 3.6;
  thread maps\_utility::radio_dialogue("hijack_plt_losingaltitude");
}

zerog_secondhit(var_0) {
  earthquake(0.25, 1.5, level.player.origin, 6000);
  level.player shellshock("hijack_airplane", 2.5);
  maps\_audio::aud_send_msg("zero_g_bodyslam3");
  wait 2.5;
}

zerog_planerollright(var_0) {
  level.player disableinvulnerability();
  level endon("plane_roll_left");
  common_scripts\utility::flag_set("plane_roll_right");
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (-35, 0, -20), 3, 1, 1);
  lerpsunangles((-11, 60, 0), (2, 95, 0), 5);
  setphysicsgravitydir((0, -0.01, 0.01));
}

zerog_bigshake(var_0) {
  earthquake(0.45, 2.0, level.player.origin, 6000);
  level.player thread maps\_utility::play_sound_on_entity("hijk_zero_g_bigshake");
}

zerog_planerollleft(var_0) {
  level endon("plane_levels");
  common_scripts\utility::flag_set("plane_roll_left");
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (15, 0, 15), 2.75, 0, 0.25);
  lerpsunangles((2, 95, 0), (-23, 65, 0), 3.75);
  setphysicsgravitydir((-0.02, 0.03, 0.01));
}

zerog_thirdhit(var_0) {
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

zerog_planelevelout(var_0) {
  common_scripts\utility::flag_set("plane_levels");
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (0, 0, 0), 3, 0, 0);
  lerpsunangles((-23, 65, 0), level.orig_sundirection, 5, 0, 1);
  setphysicsgravitydir((0, 0, -1));
  setsaveddvar("phys_gravity", level.orig_phys_gravity);
  setsaveddvar("phys_gravity_ragdoll", level.orig_ragdoll_gravity);
  var_1 = (-27290, 12784, 7340);
  physicsjitter(var_1, 500, 450, 0.1, 0.2, 1);
  physicsjolt(var_1, 500, 450, (0, 0, -0.05));
  zerog_jolt_weapons(var_1, 500, (0, 0, -0.05));
  maps\_audio::aud_send_msg("zero_g_debris_crash");
}

zerog_jolt_weapons(var_0, var_1, var_2) {
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

zerog_done_agents() {
  if(level.start_point != "lower_level_combat") {
    level.zerog_agent_02 waittillmatch("single anim", "end");
  }
  level.zerog_agent_01.ignoreme = 1;
  level.zerog_agent_01.ignoreall = 1;
  level.zerog_agent_01.fixednode = 1;
  level.zerog_agent_01.goalradius = 16;
  level.zerog_agent_01 maps\_utility::enable_cqbwalk();
  level.zerog_agent_01 pushplayer(1);
  level.zerog_agent_02.ignoreme = 1;
  level.zerog_agent_02.ignoreall = 1;
  level.zerog_agent_02.fixednode = 1;
  level.zerog_agent_02.goalradius = 16;
  level.zerog_agent_02 maps\_utility::enable_cqbwalk();
  level.zerog_agent_02 pushplayer(1);

  if(isDefined(level.zerog_agent_03)) {
    var_0 = getnode("agent3_postzero_node1", "targetname");
    level.zerog_agent_03.goalradius = 16;
    level.zerog_agent_03 maps\_utility::enable_cqbwalk();
    level.zerog_agent_03 setgoalnode(var_0);
  }

  var_1 = getnode("zerog_agent2_end_node", "targetname");
  level.zerog_agent_02 setgoalnode(var_1);
  wait 0.2;
  var_2 = getnode("zerog_agent1_end_node", "targetname");
  level.zerog_agent_01 setgoalnode(var_2);
  level.zerog_agent_01 waittill("goal");

  if(isDefined(level.zerog_agent_03)) {
    var_0 = getnode("agent1_prezero_cover2", "targetname");
    level.zerog_agent_03 setgoalnode(var_0);
  }

  var_3 = common_scripts\utility::getStruct("all_plane_origin", "targetname");
  level.fire_extinguisher = getEnt("fire_extinguisher", "targetname");
  var_4 = maps\_utility::spawn_anim_model("zerog_prop");
  var_4 setModel("generic_prop_raven");
  var_4 maps\_anim::setanimtree();
  waittillframeend;
  var_3 thread maps\_anim::anim_first_frame_solo(var_4, "fire_extinguisher_enter");
  level.fire_extinguisher linkTo(var_4, "J_prop_1");
  var_3 thread maps\_anim::anim_single_solo(var_4, "fire_extinguisher_enter");
  var_3 maps\_anim::anim_single_solo(level.zerog_agent_01, "cockpit_door_bash_enter");

  if(isDefined(level.zerog_agent_01) && isalive(level.zerog_agent_01)) {
    var_3 thread maps\_anim::anim_loop_solo(var_4, "fire_extinguisher_loop");
    level.zerog_agent_01 thread maps\hijack_code::check_player_for_prone("true");
    var_3 maps\_anim::anim_loop_solo(level.zerog_agent_01, "cockpit_door_bash_loop", "end_cockpit_loop");
  }
}

#using_animtree("generic_human");

zerog_terrorist3_kill() {
  var_0 = % hijack_zerog_terrorist_03_alive;
  var_1 = getanimlength(var_0);
  var_2 = getnotetracktimes(var_0, "cue_hero_agent")[0];
  var_3 = var_1 * var_2;
  thread zerog_terrorist3_dropweapon(var_3);
  wait(var_3);
  level.commander show();
  level.zerog_agent_03 show();
  level.president show();
  level.hero_agent_01 show();
  level.commander maps\_utility::teleport_ai(getnode("teleport_hero_agent", "targetname"));
  level.commander thread maps\_utility::dialogue_queue("hijack_cmd_retakecockpit");

  if(isalive(self)) {
    self.forceragdollimmediate = 0;
    self.a.nodeath = 1;
    level.zerog_origin maps\_anim::anim_single_solo(level.commander, "zerog_hero_agent");
  } else {
    level.zerog_origin maps\_anim::anim_single_solo(level.commander, "zerog_commander_alt");
  }
  common_scripts\utility::flag_set("zero_g_done");
  thread zerog_done();
}

zerog_terrorist3_dropweapon(var_0) {
  self endon("death");
  wait(var_0 * 0.98);
  animscripts\shared::dropaiweapon();
}

zerog_done() {
  common_scripts\utility::flag_wait("zero_g_done");
  thread moving_to_bottom_level();
}

moving_to_bottom_level() {
  level.hero_agent_01.goalradius = 16;
  level.hero_agent_01.goalheight = 24;
  level.hero_agent_01 maps\_utility::disable_pain();
  level.hero_agent_01.ignoresuppression = 1;
  level.hero_agent_01.ignoreme = 1;
  level.hero_agent_01.ignoreall = 1;
  level.hero_agent_01.fixednode = 1;
  level.hero_agent_01.animname = "generic";
  level.commander.goalradius = 16;
  level.commander.goalheight = 24;
  level.commander maps\_utility::disable_pain();
  level.commander.ignoresuppression = 1;
  level.commander.ignoreme = 0;
  level.commander.ignoreall = 0;
  level.commander.fixednode = 0;
  level.commander maps\_utility::enable_cqbwalk();
  level.commander.baseaccuracy = 0.1;
  thread start_lower_combat();
  thread lower_vo_handler();
  thread lower_level_props();
  var_0 = getnode("commander_top_of_stairs", "targetname");
  level.hero_agent_01.goalradius = 32;
  level.hero_agent_01 setgoalnode(var_0);
  var_1 = getnode("president_top_of_stairs", "targetname");
  level.president.goalradius = 32;
  level.president setgoalnode(var_1);
}

lower_vo_handler() {
  maps\_utility::radio_dialogue("hijack_fso3_theyhave");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_backuponway");
  common_scripts\utility::flag_wait("spawn_second_room_first_wave");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_additionalhijack");
  common_scripts\utility::flag_wait("move_president_to_first_room");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_protectpres");
  level.hero_agent_01 maps\_utility::dialogue_queue("hijack_fso1_thiswaysir");
  wait 1.75;
  maps\_utility::radio_dialogue("hijack_fso2_retake");

  if(common_scripts\utility::flag("dining_room_done")) {
    level.commander maps\_utility::dialogue_queue("hijack_cmd_roomclear");
  }
  common_scripts\utility::flag_wait("move_president_to_second_room_start");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_headdown");
  wait 0.5;

  if(common_scripts\utility::flag("dining_room_done")) {
    level.commander maps\_utility::dialogue_queue("hijack_cmd_roomclear");
  }
  common_scripts\utility::flag_wait("spawn_hallway_terrorists_1");
  maps\_utility::radio_dialogue("hijack_fso2_jammedshut");
  common_scripts\utility::flag_wait("lower_level_rumble_hallway");
  level.hero_agent_01 maps\_utility::dialogue_queue("hijack_fso1_keepmoving");
  common_scripts\utility::flag_wait("spawn_comm_room_terrorists");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_keeppushing");
  common_scripts\utility::flag_wait("move_president_to_hallway");
  maps\_utility::radio_dialogue("hijack_fso2_drivenback");
  wait 0.75;
  level.hero_agent_01 maps\_utility::dialogue_queue("hijack_fso1_staywithgroup");
  common_scripts\utility::flag_wait("move_president_to_comm_room");
  level.commander maps\_utility::dialogue_queue("hijack_cmd_prestosaferoom");
  wait 0.4;
  level.hero_agent_01 maps\_utility::dialogue_queue("hijack_fso1_keepgoing");
}

lower_level_props() {
  var_0 = getEntArray("hanging_phone", "targetname");
  common_scripts\utility::array_thread(var_0, ::lower_level_phone);
}

lower_level_phone() {
  self.animname = "hanging_phone";
  maps\_anim::setanimtree();
  wait(randomfloatrange(0.0, 0.8));
  thread maps\_anim::anim_loop_solo(self, "phone_swaying", "stop_phones");
  common_scripts\utility::flag_wait("stop_phones");
  self notify("stop_phones");
  self stopanimScripted();
  self delete();
}

start_lower_combat() {
  common_scripts\utility::flag_clear("player_moving_downstairs");
  maps\_utility::battlechatter_on("axis");
  thread lower_level_objectives();
  thread agent_and_president_movement();
  thread glass_watcher();
  thread lower_level_rumbles();
  thread lower_level_cleanup_cockpit();
  thread lower_level_dead_allies();
  thread commander_initial_moves();
  thread find_daughter_moment();
  thread color_trigger_watcher();
  thread cargo_props_prep();
  thread lower_hallway_enemies();
  thread lower_comm_cargo_enemies();
  thread lower_level_runners("runner_1");
  thread lower_level_runners("runner_2");
  common_scripts\utility::flag_wait("spawn_second_room_first_wave");
  var_0 = maps\_utility::array_spawn_function_targetname("second_room_terrorists_1", ::lower_clean_up);
  var_0 = maps\_utility::array_spawn_targetname("second_room_terrorists_1");

  foreach(var_2 in level.runners) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  thread maps\hijack_code::ai_array_killcount_flag_set(var_0, var_0.size - 1, "spawn_second_room_second_wave");
  thread lower_level_radio_chatter();
  common_scripts\utility::flag_wait("spawn_second_room_second_wave");
  var_4 = maps\_utility::array_spawn_function_targetname("second_room_terrorists_2", ::lower_clean_up);
  var_4 = maps\_utility::array_spawn_targetname("second_room_terrorists_2");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_4, var_4.size, "dining_room_done");
  common_scripts\utility::flag_wait("dining_room_done");
  level.commander.ignoresuppression = 0;
  thread try_move_commander_through_dining_room();
  thread maps\hijack_crash_fx::handle_pre_sled_lights();
}

lower_hallway_enemies() {
  common_scripts\utility::flag_wait("spawn_hallway_terrorists_1");
  var_0 = maps\_utility::array_spawn_targetname("hallway_terrorists_1");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_0, var_0.size, "all_hallway_terrorists_dead");
  common_scripts\utility::flag_set("exited_dining_room");
  level.lower_radio_org.deleteme = 1;
}

lower_comm_cargo_enemies() {
  common_scripts\utility::flag_wait_any("all_hallway_terrorists_dead", "spawn_comm_room_terrorists");
  thread comm_room_background_chatter();
  thread cargo_room_daughter_seen();
  common_scripts\utility::flag_wait("spawn_comm_room_terrorists");
  var_0 = maps\_utility::array_spawn_targetname("comm_room_terrorists");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_0, var_0.size, "all_comm_room_terrorists_dead");
  var_1 = maps\_utility::get_living_ai("comm_runner", "script_noteworthy");
  var_2 = randomintrange(0, 1);

  if(var_2 == 0) {
    var_3 = getnode("comm_runner_left", "targetname");
    var_1 setgoalnode(var_3);
  } else {
    var_3 = getnode("comm_runner_right", "targetname");
    var_1 setgoalnode(var_3);
  }

  var_4 = maps\_utility::array_spawn_targetname("cargo_room_terrorists_a");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_4, 1, "cargo_room_commander_move");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_4, 3, "cargo_room_wave_a_dead");
  common_scripts\utility::flag_wait("all_comm_room_terrorists_dead");
  maps\hijack_code::try_activate_trigger_targetname("comm_room_clear_ally_position");
  common_scripts\utility::flag_wait("find_daughter_moment_finished");
  thread maps\hijack_crash::pre_plane_crash();
  common_scripts\utility::flag_wait("player_is_in_end_room");
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  maps\_spawner::killspawner(100);
  thread maps\hijack_crash::start_plane_crash();
}

lower_clean_up() {
  common_scripts\utility::flag_wait("clean_up_dining_room");

  if(isDefined(self) && isalive(self)) {
    self.diequietly = 1;
    self kill();
  }
}

color_trigger_watcher() {
  var_0 = getEntArray("commander_color_trig_1", "script_noteworthy");
  maps\hijack_code::array_wait_any(var_0, "trigger");

  foreach(var_2 in var_0) {}
  var_2 common_scripts\utility::trigger_off();

  var_4 = getEntArray("hallway_clear_ally_position", "targetname");
  maps\hijack_code::array_wait_any(var_4, "trigger");

  foreach(var_2 in var_4) {}
  var_2 common_scripts\utility::trigger_off();
}

try_move_commander_through_dining_room() {
  wait_till_no_enemies_in_dining_room();
  common_scripts\utility::flag_wait("lower_level_rumble_room_2");
  maps\hijack_code::try_activate_trigger_targetname("room_2_clear_ally_position");
}

wait_till_no_enemies_in_dining_room() {
  var_0 = getEnt("dining_room_covering_trig", "targetname");
  var_1 = getEntArray("terrorist", "script_noteworthy");
  var_2 = -1;

  while(var_2 != 0) {
    var_2 = 0;
    var_3 = var_0 maps\_utility::get_ai_touching_volume();

    foreach(var_5 in var_3) {
      if(isenemyteam(level.player.team, var_5.team)) {
        var_2++;
      }
    }

    wait 0.25;
  }
}

post_zerog_vo() {}

commander_initial_moves() {
  level.commander.ignoreme = 1;
  level.commander.ignoreall = 1;
  var_0 = getnode("commander_to_bottom_level", "targetname");
  level.commander setgoalnode(var_0);
  level.commander waittill("goal");
  level.commander.ignoreme = 0;
  level.commander.ignoreall = 0;
  level.commander.ignoresuppression = 1;
  level.commander.allowpain = 0;
  common_scripts\utility::flag_wait("move_commander_to_first_node");

  if(isDefined(level.commander)) {
    level.commander maps\_utility::enable_ai_color_dontmove();
    var_1 = randomfloatrange(0, 1);

    if(var_1 < 0.5) {
      var_2 = getnode("bottom_stairs_left", "targetname");
      level.commander setgoalnode(var_2);
      common_scripts\utility::flag_wait("move_commander_to_second_node");
      var_3 = getnode("first_room_left", "targetname");
      level.commander setgoalnode(var_3);
      level.commander.allowpain = 1;
    } else {
      var_4 = getnode("bottom_stairs_right", "targetname");
      level.commander setgoalnode(var_4);
      common_scripts\utility::flag_wait("move_commander_to_second_node");
      var_5 = getnode("first_room_right", "targetname");
      level.commander setgoalnode(var_5);
      level.commander.allowpain = 1;
    }
  }
}

lower_level_dead_allies() {
  var_0 = maps\_utility::array_spawn_targetname("lower_level_dead_allies");

  foreach(var_2 in var_0) {
    var_2.diequietly = 1;
    var_2.delete_on_death = 0;
    var_2 kill();
  }
}

lower_level_radio_chatter() {
  level endon("exited_dining_room");
  level.lower_radio_org = spawn("script_origin", level.player.origin);
  level.lower_radio_org linkTo(level.player);
  level.lower_radio_org.linked = 1;
  maps\hijack_code::background_chatter("hijack_fso1_sitrep", level.lower_radio_org);
  wait 0.3;
  maps\hijack_code::background_chatter("hijack_fso1_shotsfired", level.lower_radio_org);
  wait 0.75;
  maps\hijack_code::background_chatter("hijack_fso2_altered", level.lower_radio_org);
  wait 0.1;
}

comm_room_background_chatter() {
  level.comm_radio_org = spawn("script_origin", (-28228, 12674, 7172));
  maps\hijack_code::background_chatter("hijack_fc1_descended", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc2_kgbandfso", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc1_squawking", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc2_heading", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc1_scrambling", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc2_doyoucopy", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc1_notresponding", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc2_rapidrate", level.comm_radio_org);
  maps\hijack_code::background_chatter("hijack_fc1_slowdescent", level.comm_radio_org);
  level.comm_radio_org.deleteme = 1;
}

lower_level_cleanup_cockpit() {
  common_scripts\utility::flag_wait("all_hallway_terrorists_dead");
  level.zerog_agent_01 maps\_utility::stop_magic_bullet_shield();
  level.zerog_agent_01.diequietly = 1;
  level.zerog_agent_01.allowdeath = 1;
  level.zerog_agent_01.deathfunction = undefined;
  level.zerog_agent_01 kill();
  level.zerog_agent_02 maps\_utility::stop_magic_bullet_shield();
  level.zerog_agent_02.diequietly = 1;
  level.zerog_agent_02.allowdeath = 1;
  level.zerog_agent_02.deathfunction = undefined;
  level.zerog_agent_02 kill();
  level.zerog_agent_03 maps\_utility::stop_magic_bullet_shield();
  level.zerog_agent_03.diequietly = 1;
  level.zerog_agent_03.allowdeath = 1;
  level.zerog_agent_03.deathfunction = undefined;
  level.zerog_agent_03 kill();
  level.fire_extinguisher delete();
}

lower_level_objectives() {
  var_0 = common_scripts\utility::getStruct("bottom_of_stairs", "targetname");
  objective_add(maps\_utility::obj("secure_daughter"), "current", &"HIJACK_OBJ_DAUGHTER", var_0.origin);
  common_scripts\utility::flag_wait("player_reached_bottom_of_stairs");
  var_1 = common_scripts\utility::getStruct("daughter_lower_level", "targetname");
  objective_position(maps\_utility::obj("secure_daughter"), var_1.origin);
  common_scripts\utility::flag_wait("agent_reached_comm_room");
  maps\_utility::objective_complete(maps\_utility::obj("secure_daughter"));
  common_scripts\utility::flag_wait("commander_finished_find_daughter_anim");
  maps\hijack_crash::crash_objectives();
}

game_over_if_player_waits_too_long() {
  level endon("planecrash_approaching");
  wait 300;
  setDvar("ui_deadquote", &"HIJACK_FAIL_CRASH");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

enemies_stumble(var_0) {
  var_1 = getaiarray();
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(guy_is_defined_and_alive(var_5) && isenemyteam(level.player.team, var_5.team) && (!isDefined(var_5.dont_stumble) || !var_5.dont_stumble)) {
      if(var_5.a.pose == "crouch") {
        if(var_2 % 2 == 1) {
          var_5 thread enemy_stumble_single("hijack_generic_stumble_crouch2", var_0);
        } else {
          var_5 thread enemy_stumble_single("hijack_generic_stumble_crouch1", var_0);
        }
        var_2 = var_2 + 1;
        continue;
      }

      if(var_5.a.pose == "stand") {
        if(var_3 % 2 == 1) {
          var_5 thread enemy_stumble_single("hijack_generic_stumble_stand2", var_0);
        } else {
          var_5 thread enemy_stumble_single("hijack_generic_stumble_stand1", var_0);
        }
        var_3 = var_3 + 1;
      }
    }
  }

  if(!maps\_utility::is_specialop()) {
    level.commander thread maps\_anim::anim_generic(level.commander, "hijack_generic_stumble_stand1");
  }
}

enemy_stumble_single(var_0, var_1) {
  self endon("death");
  wait(randomfloat(0.75));

  if(guy_is_defined_and_alive(self)) {
    if(self.a.pose == "crouch" || self.a.pose == "stand") {
      self.allowdeath = 1;
      self.deathfunction = ::only_ragdoll;
      maps\_anim::anim_generic(self, var_0);
      self.deathfunction = undefined;
    }
  }
}

guy_is_defined_and_alive(var_0) {
  return isDefined(var_0) && isalive(var_0) && !var_0 maps\_utility::doinglongdeath() && var_0.a.nodeath == 0;
}

lower_level_rumbles() {
  common_scripts\utility::flag_wait("lower_level_rumble_room_2");
  common_scripts\utility::flag_wait_or_timeout("force_bar_rumble", 8);
  var_0 = maps\_utility::spawn_targetname("diningroom_terrorist_bar");
  var_0 thread lower_clean_up();
  var_0.animname = "generic";
  var_0.health = 50;
  var_0.dont_stumble = 1;
  level.door_terrorist = maps\_utility::spawn_targetname("diningroom_terrorist_door");
  level.door_terrorist thread lower_clean_up();
  level.door_terrorist.animname = "generic";
  level.door_terrorist.health = 50;
  level.door_terrorist.dont_stumble = 1;
  level.door_terrorist visiblesolid();
  var_1 = common_scripts\utility::getStruct("dining_room_anim_start", "targetname");
  var_1.angles = (0, 0, 0);
  var_1 thread maps\_anim::anim_single_solo(var_0, "hijack_diningroom_bar_terrorist");
  var_1 thread maps\_anim::anim_single_solo(level.door_terrorist, "hijack_diningroom_door_terrorist");
  thread allow_stumbling_terrorists_to_die(var_0, level.door_terrorist);
  wait 1;
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("jet_roll_v01");
  maps\_audio::aud_send_msg("turbine_wind_a");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_large");
  thread dining_room_lurch();
  level.custom_linkto_slide = 1;
  var_2 = (7, 90, 0);
  var_3 = anglesToForward(var_2);
  level.player setvelocity(var_3 * 110);
  level.player maps\hijack_code::hjk_beginsliding();
  thread enemies_stumble();
  wait 0.2;
  var_4 = getEntArray("lower_level_room_1_objects", "targetname");

  foreach(var_6 in var_4) {}
  var_6 thread maps\hijack_code::launch_object(randomintrange(200, 240), (0, 1, 0));

  var_8 = getEntArray("bar_room_physics", "targetname");

  foreach(var_6 in var_8) {}
  var_6 thread maps\hijack_code::start_phys_explosion_on_delay(64, 64, 0.65);

  wait 1;
  level.player maps\hijack_code::hjk_endsliding();
  wait 1;
  wait 3.75;
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (0, 0, 0), 1, 0, 0);
  wait 1;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread constant_rumble();
  common_scripts\utility::flag_wait("lower_level_rumble_hallway");
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("rumble_boom");
  earthquake(0.33, 2.0, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_medium");
  wait 2.0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread constant_rumble();
  level.commander waittillmatch("single anim", "plane_shifts");
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("rumble_boom");
  earthquake(0.3, 4.5, level.player.origin, 80000);
  level.player playRumbleOnEntity("hijack_plane_large");
  maps\_audio::aud_send_msg("jet_roll_v02");
  maps\_audio::aud_send_msg("turbine_wind_b");
  thread cargo_room_lurch();
  thread maps\hijack_crash_fx::handle_crash_lights();
  resetsundirection();
  thread cargo_move_props();
  level.commander waittillmatch("single anim", "plane_shift_player");
  level.player disableweapons();

  if(!common_scripts\utility::flag("no_player_slide")) {
    level.custom_linkto_slide = 1;
    var_2 = (7, 90, 0);
    var_3 = anglesToForward(var_2);
    level.player setvelocity(var_3 * 140);
    level.player maps\hijack_code::hjk_beginsliding();
    wait 1.0;
    level.player maps\hijack_code::hjk_endsliding();
  } else {
    wait 1.0;
  }
  level.player enableweapons();
  wait 1.0;
}

allow_stumbling_terrorists_to_die(var_0, var_1) {
  var_0.deathfunction = ::only_ragdoll;
  var_1.deathfunction = ::only_ragdoll;
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
  var_1.deathfunction = undefined;
  wait 0.2;
  var_0.deathfunction = undefined;
}

only_ragdoll() {
  self startragdoll();
}

dining_room_lurch() {
  level notify("stop_rocking");
  maps\_audio::aud_send_msg("hallway_lurch", 1);
  var_0 = maps\_utility::spawn_anim_model("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "hallway_lurchcam");
  var_1 linkTo(var_0, "J_prop_1");
  var_0 thread maps\_anim::anim_single_solo(var_0, "hallway_lurchcam");
  var_0 waittillmatch("single anim", "corpse_slump");
  thread hallway_sun();
  common_scripts\utility::array_thread(level.arollers, ::hallway_view_roll_obj);
  var_0 waittillmatch("single anim", "end");
  level.player playersetgroundreferenceent(level.org_view_roll);
  var_1 delete();
  var_0 delete();
}

cargo_room_lurch() {
  level notify("stop_rocking");
  var_0 = maps\_utility::spawn_anim_model("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_origin", level.player.origin);
  var_1.angles = (0, 0, 0);
  level.player playersetgroundreferenceent(var_1);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "hallway_lurchcam");
  var_1 linkTo(var_0, "J_prop_1");
  var_0 maps\_anim::anim_single_solo(var_0, "hallway_lurchcam");
  var_0 maps\_anim::anim_loop_solo(var_0, "hallway_lurchcam_loop", "stop_hallway_shake");

  for(var_2 = 1; !common_scripts\utility::flag("player_left_cargo_room"); var_2 = !var_2) {
    maps\_audio::aud_send_msg("rumble_boom");

    if(var_2) {
      level.player playRumbleOnEntity("hijack_plane_medium");
    }
  }

  level notify("stop_hallway_shake");
  var_0 delete();
}

cargo_props_prep() {
  var_0 = getEnt("cargo_door01", "targetname");
  var_0 rotateYaw(75, 0.05);
  var_1 = getEnt("cargo_door02", "targetname");
  var_1 rotateYaw(-60, 0.05);
  var_2 = getEnt("cargo_door03", "targetname");
  var_2 rotateYaw(60, 0.05);
  var_3 = getEnt("cargo_door04", "targetname");
  var_3 rotateYaw(15, 0.05);
  var_4 = getEnt("cargo_door05", "targetname");
  var_4 rotateYaw(-45, 0.05);
  var_5 = getEnt("cargo_door06", "targetname");
  var_5 rotateYaw(-52, 0.05);
}

cargo_move_props() {
  level.daughter_struct = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  var_0 = getEnt("cargo_strap1", "targetname");
  var_1 = getEnt("cargo_strap2", "targetname");
  var_2 = getEnt("cargo_door01", "targetname");
  var_3 = getEnt("cargo_door02", "targetname");
  var_4 = getEnt("cargo_door03", "targetname");
  var_5 = getEnt("cargo_door04", "targetname");
  var_6 = getEnt("cargo_door05", "targetname");
  var_7 = getEnt("cargo_door06", "targetname");
  var_8 = getEnt("cargo_lg_box_01", "targetname");
  var_9 = getEnt("cargo_lg_box_02", "targetname");
  var_10 = getEnt("cargo_lg_box_03", "targetname");
  var_11 = getEnt("cargo_lg_box_04", "targetname");
  var_12 = getEnt("cargo_lg_box_05", "targetname");
  var_13 = getEnt("cargo_lg_box_06", "targetname");
  var_14 = getEnt("cargo_sm_box_03", "targetname");
  var_15 = getEnt("cargo_ladder", "targetname");
  var_16 = getEnt("cargo_toolbox", "targetname");
  var_17 = getEnt("cargo_propane01", "targetname");
  var_18 = getEnt("cargo_propane04", "targetname");
  var_0 delete();
  var_1 delete();
  var_2 thread cargo_room_prop("J_prop_2", "prop_ladder_shift", "prop_ladder_loop", level.daughter_struct);
  var_3 thread cargo_room_prop("J_prop_2", "prop_propane4_shift", "prop_propane4_loop", level.daughter_struct);
  var_4 thread cargo_room_prop("J_prop_2", "prop_box1_shift", "prop_box1_loop", level.daughter_struct);
  var_5 thread cargo_room_prop("J_prop_2", "prop_bag_shift", "prop_bag_loop", level.daughter_struct);
  var_6 thread cargo_room_prop("J_prop_2", "prop_sm_box2_shift", "prop_sm_box2_loop", level.daughter_struct);
  var_7 thread cargo_room_prop("J_prop_2", "prop_propane1_shift", undefined, level.daughter_struct);
  var_8 thread cargo_room_prop("J_prop_1", "prop_box1_shift", undefined, level.daughter_struct);
  var_9 thread cargo_room_prop("J_prop_1", "prop_box2_3_shift", undefined, level.daughter_struct);
  var_10 thread cargo_room_prop("J_prop_2", "prop_box2_3_shift", undefined, level.daughter_struct);
  var_11 thread cargo_room_prop("J_prop_2", "prop_toolbox_shift", undefined, level.daughter_struct);
  var_12 thread cargo_room_prop("J_prop_2", "prop_sm_box1_shift", undefined, level.daughter_struct);
  var_13 thread cargo_room_prop("J_prop_2", "prop_smbox3_lg6_shift", undefined, level.daughter_struct);
  var_14 thread cargo_room_prop("J_prop_1", "prop_smbox3_lg6_shift", undefined, level.daughter_struct);
  var_15 thread cargo_room_prop("J_prop_1", "prop_ladder_shift", "prop_ladder_loop", level.daughter_struct);
  var_16 thread cargo_room_prop("J_prop_1", "prop_toolbox_shift", undefined, level.daughter_struct);
  var_17 thread cargo_room_prop("J_prop_1", "prop_propane1_shift", undefined, level.daughter_struct);
  var_18 thread cargo_room_prop("J_prop_1", "prop_propane4_shift", "prop_propane4_loop", level.daughter_struct);
}

cargo_room_prop(var_0, var_1, var_2, var_3) {
  var_4 = maps\_utility::spawn_anim_model("cargo");
  waittillframeend;
  var_3 maps\_anim::anim_first_frame_solo(var_4, var_1);
  self linkTo(var_4, var_0);
  var_3 maps\_anim::anim_single_solo(var_4, var_1);

  if(isDefined(var_2)) {
    var_3 maps\_anim::anim_loop_solo(var_4, var_2);
  }
  common_scripts\utility::flag_wait_or_timeout("kill_cargo", 300);
  self unlink();
  var_4 delete();
  self delete();
}

lower_level_runners(var_0) {
  var_1 = maps\_utility::spawn_targetname(var_0);
  var_1 thread lower_clean_up();
  var_1.goalradius = 24;
  var_1 maps\_utility::magic_bullet_shield();
  var_1 thread player_damage_watcher("start_" + var_0);

  if(!isDefined(level.runners)) {
    level.runners = [];
  }
  level.runners[level.runners.size] = var_1;
  common_scripts\utility::flag_wait("start_" + var_0);
  wait 1;

  if(isalive(var_1)) {
    var_1 maps\_utility::stop_magic_bullet_shield();
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
    var_1 getenemyinfo(level.commander);
  }
}

player_damage_watcher(var_0) {
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

glass_watcher() {
  common_scripts\utility::flag_wait_any("allow_glass_to_break", "move_president_to_comm_room");
  var_0 = getEnt("glass_blocking_clip", "targetname");
  var_1 = common_scripts\utility::getStruct("center_of_glass_origin_right", "targetname");
  var_2 = common_scripts\utility::getStruct("center_of_glass_origin_left", "targetname");

  for(var_3 = 0; !var_3 && !common_scripts\utility::flag("move_president_to_comm_room"); var_3 = var_4 || var_5) {
    wait 0.5;
    var_4 = bullettracepassed(level.player.origin + (0, 0, 24), var_1.origin, 0, var_0);
    var_5 = bullettracepassed(level.player.origin + (0, 0, 24), var_2.origin, 0, var_0);
  }

  wait 0.5;
  var_0 delete();
}

agent_and_president_movement() {
  var_0 = [];
  var_0[0] = level.hero_agent_01;
  var_0[1] = level.president;
  level.president maps\_utility::set_forcegoal();
  level.hero_agent_01 maps\_utility::set_forcegoal();
  common_scripts\utility::flag_wait("move_president_to_first_room");
  level.hero_agent_01.disablearrivals = 1;
  level.hero_agent_01.script_pushable = 0;
  var_1 = getnode("agent_bottom_stairs", "targetname");
  level.hero_agent_01 setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_first_room", "targetname");
  level.president setgoalnode(var_2);
  maps\_utility::array_wait(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_second_room_start");
  wait_till_no_enemies_in_dining_room();
  level.hero_agent_01.script_pushable = 1;
  var_1 = getnode("agent_second_room_start", "targetname");
  level.hero_agent_01 setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_second_room_start", "targetname");
  level.president setgoalnode(var_2);
  maps\_utility::array_wait(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_hallway");
  level.hero_agent_01.disablearrivals = 0;
  var_1 = getnode("agent_hallway", "targetname");
  level.hero_agent_01 setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_hallway", "targetname");
  level.president setgoalnode(var_2);
  maps\_utility::array_wait(var_0, "goal");
  common_scripts\utility::flag_wait("move_president_to_comm_room");
  var_1 = getnode("agent_comm_room", "targetname");
  level.hero_agent_01 setgoalnode(var_1);
  wait 1;
  var_2 = getnode("president_comm_room", "targetname");
  level.president setgoalnode(var_2);
  maps\_utility::array_wait(var_0, "goal");
  wait 1;
  common_scripts\utility::flag_set("agent_reached_comm_room");
}

find_daughter_commander_anims() {
  var_0 = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  level.commander maps\_utility::disable_ai_color();
  level.commander maps\_utility::forceuseweapon("ak74u", "primary");
  level.commander.lastweapon = level.commander.weapon;
  var_0 maps\_anim::anim_single_solo(level.commander, "find_daughter_enter");
  common_scripts\utility::flag_set("commander_finished_find_daughter_anim");
  var_0 thread maps\_anim::anim_loop_solo(level.commander, "find_daughter_commander_loop");
}

find_daughter_agent_anims() {
  var_0 = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  level.hero_agent_01 maps\_utility::disable_ai_color();
  level.commander waittillmatch("single anim", "plane_shifts");
  level.hero_agent_01 maps\_anim::anim_single_solo(level.hero_agent_01, "hijack_generic_stumble_stand1");
  var_0 maps\_anim::anim_reach_solo(level.hero_agent_01, "find_daughter_enter");
  var_0 thread maps\_anim::anim_single_solo(level.hero_agent_01, "find_daughter_enter");
  thread maps\_utility::radio_dialogue("hijack_plt_emergency");
  maps\hijack_crash::open_cargo_door();
  common_scripts\utility::flag_set("turn_on_crash_sled_lights");
  var_1 = getnode("hero_agent_crash_node", "targetname");
  level.hero_agent_01 setgoalnode(var_1);
  level.hero_agent_01.disablearrivals = 1;
}

daughter_death() {
  setDvar("ui_deadquote", &"HIJACK_MISSIONFAIL_ALENA");
  thread maps\_utility::missionfailedwrapper();
}

cargo_room_daughter_seen() {
  common_scripts\utility::flag_wait_any("daughter_thrown_left", "daughter_thrown_right");
  level.daughter = maps\_utility::spawn_targetname("find_daughter_pre_crash");
  level.daughter.allowdeath = 1;

  if(isDefined(level.daughter.magic_bullet_shield)) {
    level.daughter maps\_utility::stop_magic_bullet_shield();
  }
  level.daughter.deathfunction = ::daughter_death;
  var_0 = maps\_utility::array_spawn_targetname("cargo_room_terrorists_b");
  thread maps\hijack_code::ai_array_killcount_flag_set(var_0, var_0.size, "all_cargo_room_terrorists_dead");
  var_1 = getEntArray("daughter_triggers", "targetname");
  maps\_utility::array_delete(var_1);
  var_2 = maps\_utility::get_living_ai("daughter_terrorist", "script_noteworthy");
  var_2.animname = "generic";
  var_2.ignoreme = 1;
  var_2.ignoreall = 1;
  var_3 = [];
  var_3[0] = level.daughter;
  var_3[1] = var_2;

  if(common_scripts\utility::flag("daughter_thrown_right")) {
    level.daughter_struct thread maps\_anim::anim_single(var_3, "pre_find_daughter_short");
  } else {
    level.daughter_struct thread maps\_anim::anim_single(var_3, "pre_find_daughter");
  }
  var_2 waittillmatch("single anim", "done_throwing");
  var_2.allowdeath = 1;
  level.daughter waittillmatch("single anim", "end");

  if(isalive(var_2)) {
    var_2.ignoreme = 0;
    var_2.ignoreall = 0;
  }

  level.daughter_struct thread maps\_anim::anim_loop_solo(level.daughter, "daughter_cry_loop");
}

find_daughter_moment() {
  level.daughter_struct = common_scripts\utility::getStruct("cargo_room_anim_struct", "targetname");
  common_scripts\utility::flag_wait("cargo_room_commander_move");
  level.commander.baseaccuracy = 1.0;
  level.daughter_struct maps\_anim::anim_reach_solo(level.commander, "find_daughter_enter");
  common_scripts\utility::flag_wait_all("all_cargo_room_terrorists_dead", "cargo_room_wave_a_dead", "agent_reached_comm_room");
  maps\_audio::aud_send_msg("cargo_room_zone_on");
  var_0 = getnode("agent_pre_daughter_node", "targetname");
  level.hero_agent_01 setgoalnode(var_0);
  level.daughter_struct maps\_anim::anim_reach_solo(level.president, "find_daughter_enter");
  level.daughter_struct notify("stop_loop");
  thread find_daughter_commander_anims();
  thread find_daughter_agent_anims();
  var_1 = [];
  var_1[0] = level.president;
  var_1[1] = level.daughter;
  level.daughter_struct maps\_anim::anim_single(var_1, "find_daughter_enter");
  level.daughter_struct thread maps\_anim::anim_loop(var_1, "post_find_loop");
  common_scripts\utility::flag_set("find_daughter_moment_finished");
  maps\_audio::aud_send_msg("cargo_room_zone_off");
  level waittill("crash_impact");
  level.daughter_struct notify("stop_loop");
}

end_commander_with_daughter_loop() {
  level waittill("planecrash_approaching");
  self notify("stop_loop");
}

stop_combat() {
  level.commander.ignoreme = 1;
  level.hero_agent_01.ignoreme = 1;
}

airplane_cleanup() {
  common_scripts\utility::flag_set("stop_phones");
  level.player.ignoreme = 0;
  level.commander.ignoreme = 0;

  if(isDefined(level.zerog_agent_01)) {
    level.zerog_agent_01 maps\_utility::stop_magic_bullet_shield();
    level.zerog_agent_01.deathfunction = undefined;
    level.zerog_agent_01 delete();
  }

  if(isDefined(level.daughter)) {
    if(isDefined(level.daughter.magic_bullet_shield)) {
      level.daughter maps\_utility::stop_magic_bullet_shield();
    }
    level.daughter delete();
  }

  if(isDefined(level.advisor)) {
    level.advisor maps\_utility::stop_magic_bullet_shield();
    level.advisor delete();
  }

  if(isDefined(level.president)) {
    level.president maps\_utility::stop_magic_bullet_shield();
    level.president.deathfunction = undefined;
    level.president delete();
  }

  common_scripts\utility::flag_set("kill_cargo");
}