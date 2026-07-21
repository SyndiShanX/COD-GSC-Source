/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_cctv.gsc
***********************************************/

embassy_cctv_precache() {
  scripts\engine\sp\utility::add_hint_string("ambo_direct_hint", &"EMBASSY/DIRECT_STACY", scripts\sp\maps\embassy\embassy_util.gsc::ambo_direct_hint_check);
  scripts\engine\sp\utility::add_hint_string("camera_change_hint", &"EMBASSY/CAMERA_HINT", scripts\sp\maps\embassy\embassy_util.gsc::camera_change_hint_check);
  level.exit_node = undefined;
  level.player_struct = spawnStruct();
  level.player_struct.animname = "Kyle";
  level.player_struct.name = "Kyle";
  level.camera_number = undefined;
  precacheshader("ui_bomber_drone_overlay");
}

embassy_cctv_init() {}

cctv_spot_light_limit() {
  scripts\engine\utility::flag_wait("load_finished");
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  scripts\engine\utility::flag_wait("cctv_end");
  setsaveddvar("MROOOROPKL", 6);
  setsaveddvar("LTQMSPKRKO", 6);
}

embassy_cctv_fx() {}

embassy_cctv_flags() {
  scripts\engine\utility::flag_init("ambo_office_open");
  scripts\engine\utility::flag_init("player_controls_enabled");
  scripts\engine\utility::flag_init("fax_alert");
  scripts\engine\utility::flag_init("exit_guard_03");
  scripts\engine\utility::flag_init("chair_pushed");
  scripts\engine\utility::flag_init("game_saving_cctv");
  scripts\engine\utility::flag_init("ambo_hot");
  scripts\engine\utility::flag_init("first_cam_change");
  scripts\engine\utility::flag_init("cctv_end");
  scripts\engine\utility::flag_init("start_cam");
  scripts\engine\utility::flag_init("stacy_animating");
  scripts\engine\utility::flag_init("stacy_animating_to_node");
  scripts\engine\utility::flag_init("survivior_escapes");
  scripts\engine\utility::flag_init("ambo_seated");
  scripts\engine\utility::flag_init("ambo_ignored");
  scripts\engine\utility::flag_init("final_patrol_go");
  scripts\engine\utility::flag_init("post_beating_save");
  scripts\engine\utility::flag_init("player_zoomed");
  scripts\engine\utility::flag_init("exit_distraction");
  scripts\engine\utility::flag_init("rescue_allowed");
  scripts\engine\utility::flag_init("distraction_enabled");
  scripts\engine\utility::flag_init("ambo_keycard_retreieved");
  scripts\engine\utility::flag_init("start_office_exited");
  scripts\engine\utility::flag_init("intro_dialogue_setup_done");
  scripts\engine\utility::flag_init("desk_reveal");
  scripts\engine\utility::flag_init("cctv_final_patrol_go");
}

cctv_camera_look_speed(var_0) {
  if(var_0) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self enableslowaim(0.75, 0.4);
      self capturnrate(0, 0);
    } else
      self disableslowaim();
  } else {
    self disableslowaim();
    self capturnrate(0, 0);
  }
}

security_cam_01_start() {}

security_cam_01_main() {
  thread objective_manager();
  thread cctv_camera_overlay();
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.15, 0.05);
  thread cctv_spot_light_limit();
  scripts\engine\utility::exploder("cctv_amb_vfx");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  thread dialogue_decks_init();
  camera_controller_init();
  stacy_spawn();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
  thread dialogue_cctv_intro();
  thread scene_opening();
  thread scene_bookcase();
  thread scene_table_beating();
  thread scene_room_beating();
  thread scene_wounded();
  thread scene_wall_kill();
  thread stacy_nav_blockers();
  thread stacy_hasnt_moved_check();
  thread audio_cctv_mix();
  thread stacy_bad_zone_attack();
  thread stacy_run_away_watcher();
  level.cell_phone = getEnt("cellphone", "targetname");
  var_1 = getEnt("chair_start", "targetname");
  level.cell_phone scripts\engine\sp\utility::assign_animtree("phone_start");
  var_1 scripts\engine\sp\utility::assign_animtree("chair_start");
  level.cell_phone notsolid();
  var_2 = [level.cell_phone, level.stacy, var_1];
  var_3 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var_4 = spawnStruct();
  var_4.origin = var_3.origin;
  var_4 scripts\common\anim::anim_first_frame(var_2, "office_start");
  thread scripts\sp\maps\embassy\embassy_util.gsc::focusflag();
  thread mission_failed();
  scripts\engine\utility::trigger_off("stop_patroller_trigger", "targetname");
  level.landmark = "none";
  thread cctv_fade_in();
  thread cctv_save_points();
  thread tense_music();
  thread aq_chatter();
  level.player setOrigin(level.cams[0].origin);
  level.player setplayerangles((level.cams[0].angles[0], level.cams[0].angles[1], 0));
  level.player playerlinktodelta(level.cams[0], "tag_origin", 1, 0, 0, 0, 0, 0);
  scripts\engine\utility::flag_wait("player_controls_enabled");
  level.player lerpviewangleclamp(1.0, 0.25, 0.25, 360, 360, 60, 50);
  level.player cctv_camera_look_speed(1);
  wait 9;
  thread dialogue_cctv_intro_gameplay();
  var_4 thread scripts\common\anim::anim_single(var_2, "office_start");
  level.stacy waittillmatch("single anim", "end");
  var_2 = [level.stacy];
  var_4 thread scripts\common\anim::anim_loop(var_2, "office_start_idle", "stop_loop");
  var_2 = [level.cell_phone, level.stacy];
  level.cell_phone linkTo(level.stacy, "tag_accessory_right");
  level.stacy allowedstances("crouch");
  level.stacy scripts\engine\sp\utility::set_goal_radius(20);
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  level.stacy.name = "Stacy";
  scripts\engine\sp\utility::autosave_now();
  ally_nodes_init();
  scripts\engine\sp\utility::display_hint("ambo_direct_hint");
  level.stacy.animstruct = var_4;
  level.stacy waittill("new_position");
  scripts\engine\utility::flag_set("stacy_animating");
  var_4 notify("stop_loop");
  var_2 = [level.stacy];
  var_4 thread scripts\common\anim::anim_single(var_2, "office_get_card");
  level.stacy waittillmatch("single anim", "end");
  var_4 thread scripts\common\anim::anim_loop(var_2, "office_get_card_idle");
  scripts\engine\utility::flag_clear("stacy_animating");
  thread securitycam_slow_look();
  scripts\engine\sp\utility::display_hint("camera_change_hint");
  camera_interacts_init();
  scripts\engine\utility::flag_wait("first_cam_change");
  level.ambassador_rock = undefined;
  scripts\engine\utility::flag_set("ambo_office_open");
  level.stacy waittill("new_position");
  var_4 notify("stop_loop");
  var_2 = [level.stacy];

  if(scripts\engine\utility::flag("stacy_animating_to_node") && !scripts\engine\utility::flag("start_office_exited")) {
    office_exit_scene(var_4);
    level.stacy stopanimScripted();
  } else {
    var_4 thread scripts\common\anim::anim_single(var_2, "office_exit");
    wait 3;
  }

  scripts\engine\utility::flag_set("start_office_exited");
  scripts\engine\utility::flag_set("ambo_keycard_retreieved");
  level.stacy stopanimScripted();
  var_4 notify("stop_loop");
}

stacy_run_away_watcher() {
  level.stacy endon("death");
  scripts\engine\utility::flag_wait("ambo_hot");
  waitframe();
  self notify("stop_going_to_node");
  level.stacy scripts\engine\sp\utility::set_goal_radius(32);
  level.stacy scripts\common\ai::disable_arrivals();
  level.stacy setgoalpos((-6542, -129, -551));
}

stacy_hasnt_moved_check() {
  level waittill("wounded_dialogue_finished");

  while(!scripts\engine\utility::flag("cctv_end")) {
    level.stacy waittill("goal");
    stacy_moving_watcher();
  }
}

stacy_moving_watcher() {
  level.stacy endon("new_position");
  level.stacy endon("death");
  level endon("cctv_end");
  level endon("player_pushed_focus");
  wait 20;

  if(!level.stacy.moving)
    level.player thread scripts\sp\player::focus_display_hint(undefined, 5);
}

audio_cctv_mix() {
  level.player setclienttriggeraudiozone("embassy_cctv_cam", 0.1);
  level.player setsoundsubmix("embassy_cctv_filter", 0.1);
}

security_cam_bink_main() {
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\engine\utility::exploder("cctv_amb_vfx");
  camera_controller_init();
  level.player playerlinkTo(level.cams[0], "tag_origin", 1, 0, 0, 0, 0, 0);
  level.cam_org = scripts\engine\utility::spawn_tag_origin(level.cams[0].origin, level.cams[0].angles);
  level.player playerlinktodelta(level.cams[0], "tag_origin", 1, 360, 360, 60, 50, 0);
  level.player setplayerangles((level.cams[0].angles[0], level.cams[0].angles[1], 0));
  level.player cctv_camera_look_speed(1);
  thread cctv_opening_scene_bink();
  level waittill("forever");
}

cctv_camera_overlay() {
  self.overlay = newclienthudelem(level.player);
  self.overlay.sort = 0;
  self.overlay.foreground = 0;
  self.overlay.lowresbackground = 1;
  self.overlay.horzalign = "fullscreen";
  self.overlay.vertalign = "fullscreen";
  self.overlay.alpha = 1;
  self.overlay.enablehudlighting = 1;
  self.overlay setshader("ui_bomber_drone_overlay", 640, 480);
  scripts\engine\utility::flag_wait("cctv_end");
  self.overlay destroy();
}

stacy_nav_blockers() {
  var_0 = getEntArray("stacy_nav_blockers", "targetname");

  foreach(var_2 in var_0)
  createnavbadplacebyent(var_2, "neutral", "allies");
}

office_exit_scene(var_0) {
  var_1 = [level.stacy];
  level endon("skip_cabinet_arrival");
  var_0 thread scripts\common\anim::anim_single(var_1, "office_exit");
  scripts\engine\utility::flag_set("start_office_exited");
  thread new_position_while_animating_watcher();
  level.stacy waittillmatch("single anim", "end");
  level notify("kill_animating_watcher");
  var_0 thread scripts\common\anim::anim_loop(var_1, "office_exit_idle", "stop_loop");
  level.stacy waittill("new_position");
  level.stacy thread scripts\common\anim::anim_single_solo(level.stacy, "hallway_exit");
  wait 1.0;
  level.stacy stopanimScripted();
}

new_position_while_animating_watcher() {
  level endon("kill_animating_watcher");
  waitframe();
  level.stacy waittill("new_position");
  level.stacy setgoalpos(level.stacy.origin);
  level notify("skip_cabinet_arrival");
}

mission_failed() {
  level endon("survivior_escapes");
  scripts\engine\utility::flag_wait("ambo_hot");
  level.stacy scripts\engine\utility::waittill_any_timeout(10, "death");
  wait 0.5;
  scripts\sp\player_death::set_custom_death_quote(53);
  level.player kill();
}

dialogue_cctv_intro() {
  wait 2.65;
  level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_cctv_01_intro_30");
  wait 8;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say("dx_vom_kyle_cctv_01_intro_60");
  wait 1.5;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_70");
  wait 0.45;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_cctv_01_intro_80");
}

dialogue_cctv_intro_gameplay() {
  wait 8.5;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_01_intro_90");
  wait 0.5;
  level.stacy thread scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_100");
  wait 1;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_110");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_120");
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::flag_set, "intro_dialogue_setup_done");
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_01_intro_140");
  level.stacy waittill("new_position");
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_kyle_cctv_01_intro_190");
  wait 5.5;
  var_0 = pre_cam_change_dialogue();

  if(istrue(var_0))
    level.stacy waittill("new_position");

  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_270");
}

pre_cam_change_dialogue() {
  thread mus_cctv();

  if(scripts\engine\utility::flag("first_cam_change"))
    return 1;

  level.stacy endon("new_position");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_200");

  if(scripts\engine\utility::flag("first_cam_change"))
    return 1;

  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_210");

  if(scripts\engine\utility::flag("first_cam_change"))
    return 1;

  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_220");

  if(scripts\engine\utility::flag("first_cam_change"))
    return 1;

  level.has_said_cam_switch = 1;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_250");
  return 1;
}

check_end_bookcase_dialogue(var_0) {
  while(distance2dsquared(level.player.origin, var_0.origin) < 500000)
    waitframe();

  level notify("end_bookcase_dialogue");
}

mus_cctv() {
  scripts\engine\utility::flag_wait("first_cam_change");
  setmusicstate("mx_embassy_cctv");
}

dialogue_bookcase_scene(var_0, var_1, var_2) {
  level endon("ambo_hot");
  level waittillmatch("finished_cam_switch", 3);
  level endon("end_bookcase_dialogue");
  thread check_end_bookcase_dialogue(var_0);
  thread say_on_see_butcher(var_0);
  wait 1;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_10");
  wait 0.3;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_20");
  wait 1.8;
  var_2 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_30");
  wait 0.6;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_40");
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_50");
  wait 1.15;
  var_2 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_60");
  wait 0.8;
  var_2 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_70");
  wait 0.6;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_80");
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_90");
  wait 0.7;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_100");
  wait 1.6;
  var_2 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_110");
  wait 0.7;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_120");
  var_2 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_130");
  wait 1.2;
  var_0 scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_140");
  level notify("reset_stacy_nag_delay");
  wait 1;
  level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_stac_cctv_post_intro_office_80");
}

say_on_see_butcher(var_0) {
  level endon("cam_switch");
  scripts\sp\maps\embassy\embassy_util.gsc::wait_lookat(var_0, 300, "j_head", 0.1);
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_cctv_post_intro_interrogation1_00");
}

caught_dialogue() {
  scripts\engine\utility::flag_wait("ambo_hot");
  wait 0.2;
  level.stacy thread scripts\engine\utility::call_on_notify_no_endon_death("damage", ::stopsounds);
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_caught_10");
  wait 1.65;

  if(randomintrange(0, 100) < 80) {
    return;
  }
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_post_intro_office_190");
}

dialogue_decks_init() {
  thread caught_dialogue();

  if(!isDefined(level.cctv_vo))
    level.cctv_vo = spawnStruct();

  var_0 = ["dx_vom_kyle_cctv_02_exit_150", "dx_vom_kyle_cctv_02_exit_164"];
  level.cctv_vo.use_distraction = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_stac_cctv_02_wounded_40";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_150";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_280";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_150";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_160";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_170";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_180";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_220";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_181";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_182";
  level.cctv_vo.stacy_confirmations = scripts\engine\sp\utility::create_deck(var_0);
  level.cctv_vo.stacy_should_confirm = scripts\engine\sp\utility::create_deck([0, 0, 1]);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_160";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_170";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_180";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_230";
  var_0[var_0.size] = "dx_vom_stac_cctv_01_intro_240";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_50";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_60";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_70";
  var_0[var_0.size] = "dx_vom_stac_cctv_post_intro_office_200";
  level.cctv_vo.stacy_nags = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_viewchange_10", "dx_vom_kyle_cctv_02_viewchange_20", "dx_vom_kyle_cctv_02_viewchange_30", "dx_vom_kyle_cctv_02_viewchange_40"];
  level.cctv_vo.viewchange = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_10";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_20";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_30";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_40";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_50";
  level.cctv_vo.commands["generic"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_60";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_70";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_80";
  var_0[var_0.size] = "dx_vom_kyle_cctv_post_intro_office_10";
  var_0[var_0.size] = "dx_vom_kyle_cctv_post_intro_office_340";
  level.cctv_vo.commands["door"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_90", "dx_vom_kyle_cctv_02_command_100", "dx_vom_kyle_cctv_02_command_110", "dx_vom_kyle_cctv_02_wounded_20"];
  level.cctv_vo.commands["corner"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_120", "dx_vom_kyle_cctv_02_command_130", "dx_vom_kyle_cctv_02_command_140"];
  level.cctv_vo.commands["cart"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_150", "dx_vom_kyle_cctv_02_command_160", "dx_vom_kyle_cctv_02_command_170", "dx_vom_kyle_cctv_02_exit_170"];
  level.cctv_vo.commands["cubicle"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_180";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_190";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_200";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_exit_30";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_exit_40";
  level.cctv_vo.commands["cubicle_other"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_210", "dx_vom_kyle_cctv_02_command_220", "dx_vom_kyle_cctv_02_command_230"];
  level.cctv_vo.commands["desk"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_240", "dx_vom_kyle_cctv_02_command_250", "dx_vom_kyle_cctv_02_command_260"];
  level.cctv_vo.commands["shelf"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_exit_70", "dx_vom_kyle_cctv_02_exit_80", "dx_vom_kyle_cctv_02_exit_140", "dx_vom_kyle_cctv_post_intro_office_240"];
  level.cctv_vo.commands["copier"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_exit_161", "dx_vom_kyle_cctv_02_exit_162", "dx_vom_kyle_cctv_02_exit_163"];
  level.cctv_vo.commands["shredder"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_kyle_cctv_02_command_270", "dx_vom_kyle_cctv_02_command_280", "dx_vom_kyle_cctv_02_command_290"];
  level.cctv_vo.commands["back"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_300";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_310";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_320";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_330";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_340";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_350";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_360";
  var_0[var_0.size] = "dx_vom_kyle_cctv_02_command_370";
  level.cctv_vo.commands["wait"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_post_intro_office_145";
  var_0[var_0.size] = level.cctv_vo.commands["desk"];
  var_0[var_0.size] = level.cctv_vo.commands["desk"];
  var_0[var_0.size] = level.cctv_vo.commands["desk"];
  level.cctv_vo.commands["inside"] = scripts\engine\sp\utility::create_deck(var_0);
  level.cctv_vo.commands["otherside"] = scripts\engine\sp\utility::create_deck(["dx_vom_kyle_cctv_post_intro_office_147", "dx_vom_kyle_cctv_post_intro_office_320", "dx_vom_kyle_cctv_post_intro_office_330"]);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_kyle_cctv_post_intro_office_146";
  var_0[var_0.size] = level.cctv_vo.commands["otherside"];
  var_0[var_0.size] = level.cctv_vo.commands["otherside"];
  var_0[var_0.size] = level.cctv_vo.commands["otherside"];
  level.cctv_vo.commands["outside"] = scripts\engine\sp\utility::create_deck(var_0);
}

dialogue_cam_change() {
  level endon("ambo_hot");
  level.stacy endon("death");

  if(level.stacy iswaitingonsound())
    return;
}

dialogue_cctv_nodes(var_0) {
  if(scripts\engine\utility::flag("ambo_hot")) {
    return;
  }
  level endon("ambo_hot");
  level.stacy endon("death");
  var_1 = undefined;

  if(isDefined(level.stacy.goalnode) && isDefined(level.stacy.goalnode.script_namenumber))
    var_1 = strtok(level.stacy.goalnode.script_namenumber, "_");

  var_2 = get_line_from_landmark(var_0, var_1);

  if(isDefined(var_2)) {
    if(isstring(var_2))
      level.cctv_vo.last_line = var_2;
    else if(scripts\engine\sp\utility::is_deck(var_2))
      level.cctv_vo.last_line = var_2 scripts\engine\sp\utility::deck_draw();
    else {}

    level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(level.cctv_vo.last_line, 1, 0.5);
  }

  if(!scripts\engine\utility::flag("first_cam_change") || isDefined(var_1) && var_1[0] == "hallway") {
    return;
  }
  if(level.cctv_vo.stacy_should_confirm scripts\engine\sp\utility::deck_draw())
    level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(level.cctv_vo.stacy_confirmations scripts\engine\sp\utility::deck_draw(), 0, 0.5);
}

get_line_from_landmark(var_0, var_1) {
  level.has_said_cam_switch = 0;

  if(!isDefined(var_0))
    return level.cctv_vo.commands["generic"];

  var_2 = var_0;
  var_0 = strtok(var_0, "_");
  var_3 = self;
  level thread stacy_direction_nags();

  if(isDefined(var_0) && var_0[0] == "exit")
    level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_cctv_02_exit_180", 1);
  else {
    if(isDefined(var_2) && var_2 == "cubical_9_copier")
      return level.cctv_vo.commands["shredder"];

    if(isDefined(level.stacy.previous_node) && level.stacy.previous_node == var_3)
      return level.cctv_vo.commands["back"];
    else if(isDefined(var_2) && var_2 == "cart_door" && !istrue(level.cctv_vo.said_cart)) {
      level.cctv_vo.said_cart = 1;
      return "dx_vom_kyle_cctv_post_intro_office_40";
    } else if(isDefined(var_2) && var_2 == "corner_1" && !istrue(level.cctv_vo.said_pillar)) {
      level.cctv_vo.said_pillar = 1;
      return "dx_vom_kyle_cctv_post_intro_office_141";
    } else if(isDefined(var_2) && var_2 == "shelf_1_cart" && !istrue(level.cctv_vo.said_shelf)) {
      level.cctv_vo.said_shelf = 1;
      return "dx_vom_kyle_cctv_post_intro_office_140";
    } else if(var_2 == "hallway_exit" && isDefined(var_1) && var_1[0] == "hallway" && !istrue(level.cctv_vo.said_around_corner_hallway)) {
      level.cctv_vo.said_around_corner_hallway = 1;
      return "dx_vom_kyle_cctv_post_intro_office_144";
    } else if(var_0[0] == "hallway" && isDefined(var_1) && var_1[0] == "hallway" && !istrue(level.cctv_vo.said_cont_hallway)) {
      level.cctv_vo.said_cont_hallway = 1;
      return "dx_vom_kyle_cctv_post_intro_office_143";
    } else if(var_2 == "hallway_corner" && isDefined(var_1) && var_1[0] == "hallway" && !istrue(level.cctv_vo.said_hallway_corner)) {
      level.cctv_vo.said_hallway_corner = 1;
      return "dx_vom_kyle_cctv_post_intro_office_310";
    } else if(isDefined(var_2) && var_2 == "desk_1_body" && !istrue(level.cctv_vo.said_body))
      return "dx_vom_kyle_cctv_post_intro_office_120";

    if(isDefined(var_2) && var_2 == "cubicle_9_copier")
      return level.cctv_vo.commands["shredder"];

    if(isDefined(var_1) && are_part_of_same_landmark(var_0, var_1) && var_0[0] == "desk") {
      if(var_2 == "desk_1_cart")
        return level.cctv_vo.commands["cart"];

      if(var_2 == "desk_1_inside")
        return "dx_vom_kyle_cctv_post_intro_office_145";

      return "dx_vom_kyle_cctv_post_intro_office_250";
    } else if(var_0[0] == "desk")
      return "dx_vom_kyle_cctv_post_intro_office_230";
    else if(isDefined(var_0) && var_0[0] == "hallway" && (!isDefined(var_1) || var_1[0] != "hallway"))
      return "dx_vom_kyle_cctv_post_intro_office_260";
    else if(isDefined(var_0) && var_0[0] == "whiteboard" && (!isDefined(var_1) || var_1[0] != "whiteboard"))
      return "dx_vom_kyle_cctv_02_exit_60";
    else if(isDefined(var_0) && var_0[0] == "chair" && (!isDefined(var_1) || var_1[0] != "chair"))
      return "dx_vom_kyle_cctv_post_intro_office_148";

    if(var_0[0] == "shelf" && isDefined(var_1) && var_1[0] == "shelf") {
      if(are_part_of_same_landmark(var_0, var_1))
        return "dx_vom_kyle_cctv_post_intro_office_142";
      else
        return level.cctv_vo.commands["cubicle_other"];
    }

    if(var_0[0] == "cubicle" && isDefined(var_1) && var_1[0] == "cubicle") {
      if(are_part_of_same_landmark(var_0, var_1)) {
        if(var_1[2] == "inside") {
          if(level.cctv_vo.commands["outside"] scripts\engine\sp\utility::deck_is_empty())
            level.cctv_vo.commands["outside"] scripts\sp\maps\embassy\embassy_util.gsc::array_deck_shuffle();

          return level.cctv_vo.commands["outside"] scripts\engine\sp\utility::deck_draw();
        } else if(var_0[2] == "outside")
          return level.cctv_vo.commands["otherside"] scripts\engine\sp\utility::deck_draw();
        else {
          if(level.cctv_vo.commands["inside"] scripts\engine\sp\utility::deck_is_empty())
            level.cctv_vo.commands["inside"] scripts\sp\maps\embassy\embassy_util.gsc::array_deck_shuffle();

          return level.cctv_vo.commands["inside"] scripts\engine\sp\utility::deck_draw();
        }
      } else
        return level.cctv_vo.commands["cubicle_other"];
    } else if(isDefined(var_1) && var_0[0] == var_1[0])
      return "dx_vom_kyle_cctv_post_intro_office_110";

    if(!isDefined(level.cctv_vo.commands[var_0[0]]))
      return level.cctv_vo.commands["generic"];
  }
}

are_part_of_same_landmark(var_0, var_1) {
  var_2 = isDefined(var_0) && isDefined(var_1);
  var_3 = scripts\engine\utility::is_equal(var_0[0], var_1[0]);
  var_4 = !isDefined(var_0[1]) && !isDefined(var_1[1]);
  var_4 = var_4 || scripts\engine\utility::is_equal(var_0[1], var_1[1]);
  return var_2 && var_3 && var_4;
}

stacy_direction_nags() {
  level.stacy endon("new_position");
  level.stacy endon("stop_nags");
  level.stacy endon("death");
  level endon("ambo_hot");
  level.stacy waittill("start_move");
  level.stacy waittill("goal");

  if(!isDefined(level.stacy.nag_time_delay))
    level.stacy.nag_time_delay = 6;

  if(!isDefined(level.stacy.variability))
    level.stacy.variability = 2;

  level.stacy.nag_time_delay = max(level.stacy.nag_time_delay - 2, 6);
  level.stacy.variability = max(level.stacy.variability - 1, 2);
  wait 1;

  for(;;) {
    while(!istrue(wait_stacy_nag_time(level.stacy.nag_time_delay, level.stacy.variability))) {
      continue;
    }
    level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(level.cctv_vo.stacy_nags scripts\engine\sp\utility::deck_draw(), 0);
    level.stacy.nag_time_delay = min(level.stacy.nag_time_delay + 3, 20);
    level.stacy.variability = min(level.stacy.variability + 1, 6);
  }
}

wait_stacy_nag_time(var_0, var_1) {
  level endon("reset_stacy_nag_delay");
  wait(randomfloatrange(var_0 - var_1, var_0 + var_1));
  return 1;
}

dialogue_wounded_scene() {
  level.has_said_cam_switch = 1;
  level.stacy endon("new_position");
  level.stacy endon("death");
  level.stacy notify("stop_nags");
  wait 0.9;
  level.stacy stopsounds();
  waitframe();
  level.player scripts\engine\utility::delaythread(1.5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_kyle_cctv_02_wounded_110");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_wounded_50");
  scripts\engine\utility::delaythread(3.0, scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_cvm2_cctv_02_wounded_130");
  level.player scripts\engine\utility::delaythread(0.5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_kyle_cctv_02_wounded_70");
  level.stacy scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_stac_cctv_02_wounded_80");
  level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_cvm2_cctv_02_wounded_90");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_wounded_100");
  level.player thread scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_02_wounded_120");
  wait 0.5;
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_wounded_150");
  wait 1.5;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_02_wounded_160");
  wait 4;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_02_wounded_170");
  wait 2.5;
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_wounded_200");
  level notify("wounded_dialogue_auto_save");
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_02_wounded_210");
  level notify("wounded_dialogue_finished");
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_02_wounded_180");
}

dialogue_cctv_cell_phone() {
  level.stacy endon("death");
  wait 1;
  level thread scripts\engine\utility::add_dialogue_line("Kyle", "There's a man in a hawaiian shirt in the conference room. He's dead.", "green");
  wait 3;
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "Oh, no, it's Peter...", "purple");
  wait 2;
  level thread scripts\engine\utility::add_dialogue_line("Kyle", "Call his cell phone, Stacy. Can you do that for me?", "green");
  wait 1;
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "Ok..", "purple");
}

dialogue_cctv_first_room_exit() {
  level endon("exit_guard_03");
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "There's a fighter guarding the exit.", "purple");
  wait 1;
  level thread scripts\engine\utility::add_dialogue_line("Kyle", "We'll need to distract him.", "green");
  wait 10;
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "There's a phone in the office next to him...", "purple");
}

cctv_fade_in() {
  level.player freezecontrols(1);
  var_0 = undefined;
  wait 1.0;
  scripts\engine\utility::flag_set("player_controls_enabled");
  level.player freezecontrols(0);
}

securitycam_slow_look() {
  while(!scripts\engine\utility::flag("cctv_end")) {
    wait 1;
    level.player cctv_camera_look_speed(1);
    waitframe();
  }

  level.player cctv_camera_look_speed(0);
}

security_cam_01_catchup() {
  scripts\engine\utility::flag_set("ambo_office_open");
  scripts\engine\utility::flag_set("chair_pushed");
  scripts\engine\utility::flag_set("first_cam_change");
  scripts\engine\utility::flag_set("intro_dialogue_setup_done");
}

security_cam_01_post_intro_start() {
  thread cctv_camera_overlay();
  thread cctv_spot_light_limit();
  thread dialogue_decks_init();
  thread audio_cctv_mix();
  thread stacy_hasnt_moved_check();
  level.landmark = "none";
  scripts\engine\utility::flag_set("ambo_office_open");
  scripts\engine\utility::flag_set("save_office_exit");
  scripts\engine\utility::flag_set("ambo_keycard_retreieved");
  scripts\engine\utility::flag_set("first_cam_change");
  scripts\engine\utility::flag_set("desk_reveal");
  stacy_spawn();
  thread objective_manager();
  ally_nodes_init();
  camera_controller_init();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
  thread aq_chatter();
  thread start_point_vision_set();
  thread mission_failed();
  thread stacy_nav_blockers();
  thread cctv_save_points();
  thread tense_music();
  scripts\engine\sp\utility::set_start_location("ambo_start_01_post_intro", [level.player, level.stacy]);
  camera_interacts_init();
  level.player playerlinktodelta(level.cams[2], "tag_origin", 1, 360, 360, 60, 50, 0);
  level.player setplayerangles((level.cams[2].angles[0], level.cams[5].angles[1], 0));
  level notify("display_ambo_hint");
  waitframe();
  level.player cctv_camera_look_speed(1);
  thread securitycam_slow_look();
  thread scripts\sp\maps\embassy\embassy_util.gsc::focusflag();
  thread scene_bookcase();
  thread scene_table_beating();
  thread scene_room_beating();
  thread scene_wounded();
  thread scene_wall_kill();
  level notify("drag done");
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.15, 0.05);
}

security_cam_01_post_intro_main() {}

security_cam_01_post_intro_catchup() {
  scripts\engine\utility::flag_set("first_cam_change");
}

security_cam_02_start() {
  thread cctv_camera_overlay();
  thread dialogue_decks_init();
  thread cctv_spot_light_limit();
  level.landmark = "none";
  scripts\engine\utility::flag_set("ambo_office_open");
  scripts\engine\utility::flag_set("save_part_2_start");
  scripts\engine\utility::flag_set("ambo_keycard_retreieved");
  stacy_spawn();
  thread objective_manager();
  ally_nodes_init();
  camera_controller_init();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
  thread start_point_vision_set();
  thread audio_cctv_mix();
  thread aq_chatter();
  thread cctv_save_points();
  thread tense_music();
  thread mission_failed();
  scripts\engine\sp\utility::set_start_location("ambo_start_02", [level.player, level.stacy]);
  camera_interacts_init();
  level.player playerlinktodelta(level.cams[5], "tag_origin", 1, 360, 360, 60, 50, 0);
  level.player setplayerangles((level.cams[5].angles[0], level.cams[5].angles[1], 0));
  level notify("display_ambo_hint");
  waitframe();
  level.player cctv_camera_look_speed(1);
  thread securitycam_slow_look();
  thread scripts\sp\maps\embassy\embassy_util.gsc::focusflag();
  level notify("drag done");
  thread scene_bookcase();
  thread scene_table_beating();
  thread scene_room_beating();
  thread scene_wounded();
  thread scene_wall_kill();
  thread stacy_hasnt_moved_check();
  scripts\engine\utility::flag_set("first_cam_change");
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.15, 0.05);
}

security_cam_02_main() {
  thread camera_nav_obstacle();
  thread left_path_nav_obstacle();
  scripts\engine\utility::flag_wait("patrol_to_exit");
  thread cctv_part_3_fail_trig();
  thread distraction_structs();
  thread distraction_dialogue();
  var_0 = getEnt("end_game_volume", "targetname");

  while(!level.stacy istouching(var_0))
    waitframe();

  scripts\engine\utility::flag_set("cctv_final_patrol_go");
  scripts\engine\utility::flag_wait("distraction_enabled");
  level.stacy scripts\engine\utility::set_movement_speed(140);
  scripts\engine\sp\utility::trigger_wait("ambo_exit_trigger_03", "targetname");
  level notify("nuke_nodes");

  if(scripts\engine\utility::flag("ambo_hot"))
    level waittill("forever");

  level.stacy waittill("goal");
  level.stacy.ignoreme = 1;
  scripts\engine\utility::flag_set("survivior_escapes");
  var_1 = getEnt("rescue_trigger", "targetname");
  var_2 = createnavbadplacebyent(var_1, "axis");
  var_3 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var_3, ::ally_nodes_interact_remove);
  thread camera_interacts_remover();
  level.stacy scripts\common\ai::magic_bullet_shield();
  thread escape_dialogue();
  level.player scripts\engine\utility::delaycall(0.6, ::playsound, "emb_doorunlock_beep_2d");
  level.player scripts\engine\utility::delaycall(0.75, ::playsound, "emb_doorunlock_clickandbuzz_2d");
  level.player scripts\engine\utility::delaycall(0.95, ::playsound, "emb_cctv_027_end_door_open");
  level.stacy scripts\common\anim::anim_single_solo(level.stacy, "card_swipe");
  level.friendlies = scripts\engine\sp\utility::array_spawn_targetname("civ_rescuers", 1);
  level.stacy.swipe = 1;
  var_4 = getEnt("exit_door", "targetname");
  var_4 rotateYaw(-90, 1);
  wait 0.5;

  foreach(var_6 in level.friendlies) {
    var_6 scripts\engine\utility::set_movement_speed(120);
    var_6 scripts\engine\sp\utility::set_ignoresuppression(1);
    var_6.ignoreme = 0;
    var_6 scripts\engine\sp\utility::set_maxfaceenemydist(2000);
    var_6.ignoreall = 0;
    var_6.attackeraccuracy = 0;
    var_6 scripts\common\ai::magic_bullet_shield();
    var_6 allowedstances("stand", "crouch");
    var_6 getenemyinfo(level.exit_guard);
    var_6 enableavoidance(0, 0);

    if(scripts\engine\utility::is_equal(var_6.model, "body_hero_farah")) {
      var_6.name = "Farah";
      continue;
    }

    var_6.name = "Captain Price";
  }

  var_8 = getEnt("ambo_exit_trigger_03", "targetname");
  var_9 = getEnt("end_game_exit_volume", "targetname");
  level notify("get_her_out");
  wait 2;
  level notify("holy_shit");
  level.stacy setgoalvolumeauto(var_9);
  wait 4;

  foreach(var_6 in level.friendlies) {
    if(scripts\engine\utility::is_equal(var_6.model, "body_hero_farah"))
      var_6 setgoalvolumeauto(var_9);
  }

  wait 1;
  level notify("get back");

  foreach(var_6 in level.friendlies)
  var_6 setgoalvolumeauto(var_9);

  wait 3;
  level notify("we_got_her");
  wait 1;
  setomnvar("ui_cctv_active", 0);

  foreach(var_15 in level.stacy_bad_places)
  destroynavobstacle(var_15);

  level.player cctv_camera_look_speed(0);
  var_17 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_17 fadeovertime(0.1);
  var_17.alpha = 1;
  wait 1.0;
  level.player modifybasefov(65, 0.05);
  var_18 = getaiarray("axis", "allies", "neutral");

  foreach(var_6 in var_18) {
    if(isDefined(var_6.magic_bullet_shield))
      var_6 scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\utility::array_delete(var_18);
  level.player lerpfovscalefactor(1, 0);
  level.player enableweapons();
  level.player showlegsandshadow();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player.ignoreme = 0;
  level.player unlink();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.0, 1);
  scripts\engine\utility::flag_set("cctv_end");
  destroynavobstacle(var_2);

  foreach(var_22 in level.distraction_icons) {
    if(isDefined(var_22))
      setheadiconimage(var_22);
  }

  visionsetnaked("", 0);
  thread fade_up(var_17);
}

fade_up(var_0) {
  wait 0.25;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
}

camera_nav_obstacle() {
  var_0 = spawnStruct();
  var_0.origin = (-6011, -1797, -700);
  var_1 = createnavbadplacebybounds(var_0.origin, (25, 25, 100), (0, 0, 0));
  scripts\engine\utility::flag_wait("cctv_end");
  destroynavobstacle(var_1);
}

left_path_nav_obstacle() {
  level endon("cctv_end");
  level.stacy endon("death");
  var_0 = getEnt("left_path_trigger", "targetname");
  var_0.vol = var_0 scripts\engine\utility::get_target_ent();

  for(;;) {
    scripts\engine\sp\utility::trigger_wait_targetname("left_path_trigger");
    var_1 = createnavbadplacebyent(var_0.vol, "allies", "neutral");

    while(level.stacy istouching(var_0))
      waitframe();

    wait 1;
    destroynavobstacle(var_1);
  }
}

left_path_avoidance() {}

cctv_part_3_fail_trig() {
  scripts\engine\sp\utility::trigger_wait_targetname("cctv_part_3_fail_trig");
  scripts\engine\utility::flag_set("ambo_hot");
  var_0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_0, ::enemy_engages_ambo);
}

distraction_dialogue() {
  level endon("ambo_hot");
  scripts\engine\utility::flag_wait("exit_dialogue");
  level.stacy notify("stop_nags");
  level.has_said_cam_switch = 1;
  var_0 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var_0, ::ally_nodes_interact_remove);
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_cctv_02_exit_100", 1, 2);
  level.stacy thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_stac_cctv_02_exit_130", 1);
  wait 0.55;
  thread ally_nodes_init();
}

escape_dialogue() {
  level endon("ambo_hot");
  setmusicstate("");
  level.has_said_cam_switch = 1;
  level.stacy notify("stop_nags");
  level waittill("get_her_out");
  level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_escape_garage_10");
  level waittill("holy_shit");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_stac_escape_garage_20");
  level thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_cctv_02_exit_190", 1);
  level waittill("we_got_her");
  level scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_cctv_02_exit_200");
  level.cctv_vo = undefined;
}

distraction_structs() {
  level.distraction_icons = [];
  var_0 = getEntArray("distraction_triggers", "targetname");
  scripts\engine\utility::array_thread(var_0, ::distraction_triggers_logic);
}

distraction_triggers_logic() {
  self endon("walked_away");
  self.struct = scripts\engine\utility::get_target_ent();
  var_0 = scripts\engine\utility::spawn_tag_origin(self.struct.origin, self.struct.angles);
  var_1 = &"EMBASSY/CCTV_POWER";
  var_2 = 800;
  var_3 = 800;
  var_4 = "icon_electronic_interact";
  self.fx_struct = scripts\engine\utility::get_target_ent();
  thread distraction_fx();
  var_5 = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_5, "icon_electronic_interact");
  setheadiconzoffset(var_5, 1);
  setheadiconsnaptoedges(var_5, 500);
  setheadiconmaxdistance(var_5, 1);
  addclienttoheadiconmask(var_5, -20);
  level.distraction_icons[level.distraction_icons.size] = var_5;
  self waittill("trigger");
  level.distraction_icons = scripts\engine\utility::array_remove(level.distraction_icons, var_5);
  setheadiconimage(var_5);
  thread remove_distraction_interact();
  thread remove_distraction_interact_on_end();
  self.struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, -20), var_1, 70, var_2, var_3, 1, 0, 0, var_4, "duration_none", undefined, undefined, 50);
  self.struct waittill("trigger");

  if(scripts\engine\utility::is_equal(self.struct.targetname, "shredder")) {
    var_6 = getEnt("stacy_nav_blockers_end", "targetname");
    createnavbadplacebyent(var_6, "allies", "neutral");
  }

  level notify("reset_stacy_nag_delay");
  level.player thread scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(level.cctv_vo.use_distraction scripts\engine\sp\utility::deck_draw(), 1);
  wait 0.65;
  wait 0.1;
  scripts\engine\utility::flag_set("distraction_enabled");
  scripts\engine\utility::flag_set("exit_distraction");
}

icon_death_watcher(var_0) {
  level endon("cctv_end");
  level.stacy waittill("death");
  wait 0.1;

  if(isDefined(var_0))
    setheadiconimage(var_0);
}

distraction_fx() {
  var_0 = scripts\engine\utility::getStruct("distraction_shredder_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("distraction_printer_struct", "targetname");

  if(scripts\engine\utility::is_equal(self.fx_struct.targetname, "shredder")) {
    self.fx_tag = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
    playFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper"), self.fx_tag, "tag_origin");
    self.struct waittill("trigger");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper"), self.fx_tag, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper_shreding"), self.fx_tag, "tag_origin");
    level.player playSound("emb_cctv_shredder_activate");
  } else if(scripts\engine\utility::is_equal(self.fx_struct.targetname, "copier_01")) {
    self.fx_tag = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
    self.struct waittill("trigger");
    playFXOnTag(scripts\engine\utility::getfx("vfx_copier_scan"), self.fx_tag, "tag_origin");
    level.player playSound("emb_cctv_copier_activate");
  }

  scripts\engine\utility::flag_wait("cctv_end");
  self.fx_tag delete();
}

remove_distraction_interact() {
  level.stacy endon("death");
  level endon("distraction_enabled");

  while(level.stacy istouching(self))
    waitframe();

  self notify("walked_away");
  waitframe();
  self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread distraction_triggers_logic();
}

remove_distraction_interact_on_end() {
  scripts\engine\utility::flag_wait("distraction_enabled");
  self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
}

security_cam_02_catchup() {
  scripts\engine\utility::flag_set("first_cam_change");
}

start_point_vision_set() {
  wait 0.2;
  visionsetnaked("embassy_cctv_01", 0);
}

aq_chatter() {}

tense_music() {}

stacy_spawn() {
  level.stacy = scripts\engine\sp\utility::spawn_targetname("ambo", 1);
  level.stacy.ignoreall = 1;
  level.stacy.ignoreme = 1;
  level.stacy.goalradius = 20;
  level.stacy.maxhealth = 1;
  level.stacy.noragdoll = 1;
  level.stacy setgoalpos(level.stacy.origin);
  level.stacy scripts\common\ai::gun_remove();
  level.stacy scripts\engine\utility::ent_flag_init("prone");
  level.stacy allowedstances("crouch");
  level.stacy scripts\engine\utility::set_movement_speed(120);
  level.stacy scripts\engine\utility::set_cautious_navigation(0);
  level.stacy.prone = 0;
  level.stacy.bt.cannotmelee = 1;
  level.stacy.animname = "stacy";
  level.stacy.anim_struct = undefined;
  level.stacy.dontavoidplayer = 1;
  level.stacy.allowdeath = 1;
  level.stacy.name = "";
  level.stacy.team = "allies";
  level.stacy_spotted = 0;
  level.stacy._blackboard.civstate = "cctv";
  level.stacy.badzone = 0;
  level.stacy enableavoidance(0, 0);
  level.stacy.anim_struct = level.stacy;
  level.stacy.moving = 0;
  thread ambo_badplaces();
  thread focus_ambo_finder();
  thread stacy_movement_watcher();
}

stacy_movement_watcher() {
  level endon("heroes_at_exit");
  thread stacy_idle_watcher();

  while(!scripts\engine\utility::flag("cctv_end")) {
    level.stacy scripts\engine\utility::waittill_any("cctv_exit", "cctv_exit_cover_left", "cctv_exit_cover_right", "goal_changed");
    level.stacy.moving = 1;
    level.phone_sfx = spawn("script_origin", level.stacy.origin);
    level.phone_sfx linkTo(level.stacy);
    level.phone_sfx thread scripts\engine\sp\utility::sound_fade_in("emb_cctv_mvmt_cell_handling_lp", 1.0, 1.1, 1);
    level.stacy waittill("goal");
    level.stacy.moving = 0;
    wait 0.3;
    level.phone_sfx thread scripts\engine\sp\utility::sound_fade_and_delete(0.5, 1);
  }
}

stacy_idle_watcher() {
  level endon("heroes_at_exit");
  scripts\engine\utility::flag_wait("ambo_keycard_retreieved");
  level.scripted_stacy_idle = 0;

  while(!scripts\engine\utility::flag("cctv_end")) {
    if(isDefined(level.stacy) && !level.stacy.moving && !level.scripted_stacy_idle) {
      level.phone_sfx_idle = spawn("script_origin", level.stacy.origin);
      level.phone_sfx_idle linkTo(level.stacy);
      level.phone_sfx_idle thread scripts\engine\sp\utility::sound_fade_in("emb_cctv_mvmt_cell_handling_lp_idle", 1.0, 1.1, 1);

      while(isDefined(level.stacy) && isDefined(level.stacy.moving) && !level.stacy.moving)
        waitframe();

      wait 0.3;
      level.phone_sfx_idle thread scripts\engine\sp\utility::sound_fade_and_delete(0.5, 1);
    }

    waitframe();
  }
}

ambo_badplaces() {
  level.stacy_bad_places = [];
  var_0 = scripts\engine\utility::getStructArray("nav_excluser_struct", "targetname");

  foreach(var_2 in var_0)
  level.stacy_bad_places[level.stacy_bad_places.size] = createnavbadplacebybounds(var_2.origin, (10, 40, 20), (0, 0, 0), "allies");
}

ambo_anim_hack() {
  wait 1;
  level.stacy.animname = "survivor";
}

focus_ambo_finder() {
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  scripts\engine\sp\utility::hudoutline_add_channel("cctv", 100, ::hudoutline_cctv_settings);
  level.stacy endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_any("cam_switch", "player_pushed_focus");
    wait 0.1;
    wait 0.1;
  }
}

outline_ping() {
  level.stacy scripts\engine\sp\utility::hudoutline_disable("cctv");
  setsaveddvar("NSNOLMTLLL", "1 1 1 1");
  level endon("player_pushed_focus");
  level endon("cam_switch");
  level.stacy scripts\engine\sp\utility::hudoutline_enable_new("outline_nodepth_red", "cctv");
  var_0 = 1;
  var_1 = 1;
  wait 2;
  var_2 = 0.05;
  var_3 = int(var_1 / var_2);

  while(var_3) {
    setsaveddvar("NSNOLMTLLL", "1 1 1 " + scripts\engine\utility::string(var_0));
    var_0 = var_0 - var_2;
    var_3--;
    wait(var_2);
  }

  level.stacy scripts\engine\sp\utility::hudoutline_disable("cctv");
  setsaveddvar("NSNOLMTLLL", "1 1 1 0");
}

cctv_save_points() {
  level endon("ambo_hot");

  if(!scripts\engine\utility::flag("save_part_2_start")) {
    scripts\engine\utility::flag_wait("save_office_exit");
    scripts\engine\sp\utility::autosave_now();
    scripts\engine\utility::flag_wait("save_library");
    scripts\engine\sp\utility::autosave_now();
    scripts\engine\utility::flag_wait_any("save_library_desk", "save_part_2_start");

    while(level.stacy.moving)
      waitframe();

    if(!scripts\engine\utility::flag("hallway_patrol_01"))
      scripts\engine\sp\utility::autosave_now();

    if(!scripts\engine\utility::flag("save_part_2_start")) {
      scripts\engine\utility::flag_wait("save_part_2_start");
      scripts\engine\sp\utility::autosave_now();
    }
  }

  scripts\engine\utility::flag_wait_any("save_cubicles", "rescue_allowed");

  if(getdvarint("scr_emb_cctv_caught", 1)) {
    var_0 = getaiarray("axis");
    scripts\engine\utility::array_thread(var_0, ::enemy_engages_ambo);
    return;
  }

  if(scripts\engine\utility::flag("save_cubicles"))
    scripts\engine\sp\utility::autosave_now();

  scripts\engine\utility::flag_wait_any("exit_dialogue", "rescue_allowed");

  if(scripts\engine\utility::flag("exit_dialogue"))
    scripts\engine\sp\utility::autosave_now();

  scripts\engine\utility::flag_wait("rescue_allowed");
}

hudoutline_cctv_settings() {
  var_0 = [];
  var_0["MKOQSSQKLL"] = 1.8;
  var_0["LRMPROLMKN"] = "1 1 1 0.8";
  var_0["NTOSKSTKQQ"] = "1 1 1 0.8";
  var_0["NSNOLMTLLL"] = "1 1 1 1";
  var_0["LSRTPRNOLS"] = "1 1 1 0.8";
  var_0["LNNOSQKRTP"] = "1 1 1 0.8";
  var_0["RKSQOKQNK"] = 1;
  return var_0;
}

kitchen_enter_init() {
  var_0 = getEnt("kitchen_door", "targetname");
  var_0.clip = var_0 scripts\engine\utility::get_target_ent();
  var_0.clip linkTo(var_0);
  var_0.clip connectpaths();
  var_0 thread kitchen_door_disconnect_paths();
  scripts\engine\sp\utility::trigger_wait("kitchen_door_trig", "targetname");
  var_0 rotateYaw(-90, 0.5);
  wait 0.5;
  var_0 rotateYaw(90, 1.5);
  var_0.clip disconnectPaths();
}

kitchen_door_disconnect_paths() {
  scripts\engine\utility::flag_wait("rescue_allowed");
  self.clip disconnectPaths();
}

ally_nodes_init() {
  var_0 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var_0, ::ally_nodes_interact);
}

ally_nodes_interact() {
  var_0 = 2;
  var_1 = 525;
  var_2 = 525;
  var_3 = 15;
  var_4 = 40;
  var_5 = 50;

  if(isDefined(self.script_parameters))
    var_3 = int(self.script_parameters);

  var_6 = undefined;
  var_7 = "";
  var_8 = "+attack";

  if(scripts\engine\utility::is_equal(self.script_namenumber, "exit")) {
    var_0 = 40;
    var_1 = 800;
    var_7 = &"EMBASSY/CCTV_DOOR";
    level.exit_node = self;
  }

  if(scripts\engine\utility::is_equal(self.script_namenumber, "hallway"))
    var_1 = 700;

  if(scripts\engine\utility::is_equal(self.script_namenumber, "door")) {
    var_1 = 400;
    var_2 = 400;
  }

  level endon("nuke_nodes");
  self endon("cctv_end");
  level.stacy endon("death");
  var_9 = scripts\engine\utility::getStruct("floor_03_struct", "targetname");
  self.struct = spawnStruct();
  self.struct.origin = (self.origin[0], self.origin[1], var_9.origin[2] + var_0);
  self.struct.angles = self.angles;
  self.struct.radius = 64;
  self.alt_node = undefined;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy != "ambo_office")
    scripts\engine\utility::flag_wait("ambo_office_open");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ambo_office")
    var_4 = 90;

  if(isDefined(self.script_namenumber) && self.script_namenumber == "corner_2") {
    while(!isDefined(level.camera_number))
      waitframe();

    while(level.camera_number != 10)
      waitframe();

    var_1 = 400;
    var_2 = 400;
  }

  if(isDefined(self.script_namenumber) && self.script_namenumber == "cubicle_4_inside")
    var_3 = 20;

  for(;;) {
    if(scripts\engine\utility::flag("final_patrol_go_1"))
      scripts\engine\utility::flag_waitopen("final_patrol_go_1");

    self.struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, var_3), var_7, var_4, var_2, var_1, 0, 0, 0, var_6, "duration_none", var_8, undefined, var_5);
    self.struct waittill("trigger");
    level.player playSound("emb_cctv_ui_move_select");
    level endon("final_patrol_go_1");
    level.stacy scripts\engine\sp\utility::set_goal_radius(20);
    level.stacy notify("ambo_stop_loop");

    if(!scripts\engine\utility::flag("chair_pushed"))
      scripts\engine\utility::flag_set("chair_pushed");

    level.stacy notify("new_position");

    if(!scripts\engine\utility::flag("start_office_exited") && scripts\engine\utility::is_equal(self.script_namenumber, "start_exit") && !scripts\engine\utility::flag("stacy_animating_to_node")) {
      scripts\engine\utility::flag_set("stacy_animating_to_node");
      level.stacy waittill("new_position");
      wait 3;
      continue;
    }

    thread dialogue_cctv_nodes(self.script_namenumber);
    wait 0.1;
    level.stacy notify("ambo_stop_loop");

    if(scripts\engine\utility::flag("ambo_seated"))
      scripts\engine\utility::flag_waitopen("ambo_seated");

    if(scripts\engine\utility::flag("stacy_animating"))
      scripts\engine\utility::flag_waitopen("stacy_animating");

    var_10 = self;

    if(scripts\engine\utility::is_equal(self.script_namenumber, "kitchen"))
      var_10 = getnode("kitchen_node", "script_noteworthy");

    var_11 = distance(level.stacy.origin, var_10.origin);

    if((!scripts\engine\utility::flag("ambo_hot") || scripts\engine\utility::flag("survivior_escapes")) && var_11 < 1000) {
      level.stacy scripts\engine\sp\utility::set_goal_radius(5);

      if(scripts\engine\utility::flag("survivior_escapes")) {
        level.stacy allowedstances("stand");
        level.stacy scripts\common\utility::demeanor_override("sprint");
      }

      if(!scripts\engine\utility::flag("distraction_enabled"))
        wait 0.5;

      level.stacy.previous_node = level.stacy.goalnode;
      level.stacy setgoalnode(var_10);
    }

    level.stacy.anim_struct = self.struct;

    if(scripts\engine\utility::flag("final_patrol_go_1")) {
      break;
    }

    if(var_11 < 1000)
      level.stacy waittill("new_position");

    if(var_11 > 1000) {
      wait 1;

      if(!isDefined(level.cctv_vo))
        level.cctv_vo = spawnStruct();

      if(!isDefined(level.cctv_vo.too_far)) {
        var_12 = ["dx_vom_stac_cctv_02_fastpass_20", "dx_vom_stac_cctv_02_fastpass_30"];
        level.cctv_vo.too_far = scripts\engine\sp\utility::create_deck(var_12);
      }

      level.stacy scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter(level.cctv_vo.too_far scripts\engine\sp\utility::deck_draw(), 1, 1);
    }

    wait 3;
  }
}

ally_nodes_interact_remove() {
  if(isDefined(self.struct))
    self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
}

chair_rotate() {
  var_0 = getEnt("push_chair", "targetname");
  var_0 rotateYaw(-40, 1, 0, 0.25);
  wait 1;
  var_0 rotateYaw(-20, 1, 0, 0.25);
}

ally_nodes_interact_recall() {
  level.stacy waittill("new_position");
  wait 0.25;
  thread ally_nodes_interact();
}

camera_controller_init() {
  thread vision_set_init();
  level.player disableweapons();
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player.ignoreme = 1;
  var_0 = spawnStruct();
  var_1 = getEnt("cam_01", "script_noteworthy");
  var_1.angles = (180, 0, 0);
  var_0.origin = (-6968, -383, -530);
  var_0.angles = (30, 51, 0);
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1.origin = (var_0.origin[0], var_0.origin[1], -463);
  var_0.mod = var_1;
  var_0.test = [30, 51, 0];
  var_2 = spawnStruct();
  var_3 = getEnt("cam_02", "script_noteworthy");
  var_2.origin = (-6988, -43, -530);
  var_2.angles = (35, 322, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_3.origin = (var_2.origin[0], var_2.origin[1], -463);
  var_3.angles = (180, var_2.angles[1] + 20, 0);
  var_2.mod = var_3;
  var_4 = spawnStruct();
  var_5 = getEnt("cam_03", "script_noteworthy");
  var_4.origin = (-6310, -53, -530);
  var_4.angles = (28, 186, 0);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
  var_5.origin = (var_4.origin[0], var_4.origin[1], -463);
  var_5.angles = (180, var_4.angles[1], 0);
  var_4.mod = var_5;
  var_4.wall_kill_reveal = 1;
  var_6 = spawnStruct();
  var_7 = getEnt("cam_04", "script_noteworthy");
  var_6.origin = (-6000, -500, -530);
  var_6.offset = (-5080, -500, -530);
  var_6.angles = (34, 134, 0);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
  var_7.origin = (var_6.origin[0], var_6.origin[1], -463);
  var_7.angles = (180, 0, 0);
  var_6.mod = var_7;
  var_6.crawl_node_reveal = 1;
  var_8 = spawnStruct();
  var_9 = getEnt("cam_12", "script_noteworthy");
  var_8.origin = (-6038, -772, -530);
  var_8.angles = (36, 100, 0);
  var_8 = scripts\engine\utility::spawn_tag_origin(var_8.origin, var_8.angles);
  var_9.origin = (var_8.origin[0], var_8.origin[1], -463);
  var_9.angles = (180, 0, 0);
  var_8.mod = var_9;
  var_10 = spawnStruct();
  var_11 = getEnt("cam_05", "script_noteworthy");
  var_10.origin = (-7050, -940, -530);
  var_10.angles = (31, -4, 0);
  var_10 = scripts\engine\utility::spawn_tag_origin(var_10.origin, var_10.angles);
  var_11.origin = (var_10.origin[0], var_10.origin[1], -463);
  var_11.angles = (180, 0, 0);
  var_10.mod = var_11;
  var_12 = spawnStruct();
  var_12.origin = (-7058, -1490, -530);
  var_12.angles = (24, 55.8, 0);
  var_12 = scripts\engine\utility::spawn_tag_origin(var_12.origin, var_12.angles);
  var_13 = getEnt("cam_06", "script_noteworthy");
  var_13.origin = (var_12.origin[0], var_12.origin[1], -463);
  var_13.angles = (180, 0, 0);
  var_12.mod = var_13;
  var_14 = spawnStruct();
  var_14.origin = (-6472, -1285, -530);
  var_14.angles = (30, -115, 0);
  var_14 = scripts\engine\utility::spawn_tag_origin(var_14.origin, var_14.angles);
  var_15 = getEnt("cam_08", "script_noteworthy");
  var_15.origin = (var_14.origin[0], var_14.origin[1], -463);
  var_15.angles = (180, 0, 0);
  var_14.mod = var_15;
  var_16 = spawnStruct();
  var_16.origin = (-6002, -1320, -530);
  var_16.angles = (34, -132, 0);
  var_16 = scripts\engine\utility::spawn_tag_origin(var_16.origin, var_16.angles);
  var_17 = getEnt("cam_09", "script_noteworthy");
  var_17.origin = (var_16.origin[0], var_16.origin[1], -463);
  var_17.angles = (180, 0, 0);
  var_16.mod = var_17;
  var_18 = spawnStruct();
  var_18.origin = (-6011, -1777, -530);
  var_18.angles = (30, -105, 0);
  var_18 = scripts\engine\utility::spawn_tag_origin(var_18.origin, var_18.angles);
  var_19 = getEnt("cam_10", "script_noteworthy");
  var_19.origin = (var_18.origin[0], var_18.origin[1], -463);
  var_19.angles = (180, 0, 0);
  var_18.mod = var_19;
  var_20 = spawnStruct();
  var_20.origin = (-6446, -995, -530);
  var_20.angles = (30, 50, 0);
  var_20 = scripts\engine\utility::spawn_tag_origin(var_20.origin, var_20.angles);
  var_21 = getEnt("cam_11", "script_noteworthy");
  var_21.origin = (var_20.origin[0], var_20.origin[1], -463);
  var_21.angles = (180, 0, 0);
  var_20.mod = var_21;
  level.cams = [var_0, var_2, var_4, var_6, var_8, var_10, var_12, var_14, var_16, var_18, var_20];
  level.active_feed = level.cams;
  level.player modifybasefov(90, 0.05);
  level.previous_cam = level.cams[0];
  level.previous_cam.mod hide();

  if(scripts\engine\utility::flag("ambo_office_open"))
    level.previous_cam = level.cams[2];

  if(scripts\engine\utility::flag("save_part_2_start"))
    level.previous_cam = level.cams[5];

  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", 0);
}

vision_set_init() {
  wait 0.5;
  visionsetnaked("embassy_cctv_01", 0.25);
}

change_camera() {
  scripts\engine\utility::flag_set("first_cam_change");
  level notify("cam_switch");
  dialogue_cam_change();
  scripts\engine\utility::flag_clear("player_pushed_focus");
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  level.player setclientomnvar("ui_hide_hud", 1);
  wait 0.2;

  foreach(var_3, var_2 in level.cams) {
    if(var_2 == self)
      level.camera_number = var_3;
  }

  setomnvar("ui_cctv_camera_index", level.camera_number);
  level.previous_cam.last_angles = level.player getplayerangles();
  self.mod hide();
  level.previous_cam.mod show();
  level.player unlink();
  level.player dontinterpolate();
  level.player setOrigin(self.origin);
  level.player playerlinktodelta(self, "tag_origin", 1, 360, 360, 40, 50, 0);
  level.player thread cctv_camera_look_speed(1);

  if(isDefined(self.last_angles))
    level.player setplayerangles(self.last_angles);
  else
    level.player setplayerangles((self.angles[0], self.angles[1], 0));

  level.player modifybasefov(90, 0.05);
  wait 0.05;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
  waitframe();
  level.previous_cam = self;
  wait 0.1;
  level.player setclientomnvar("ui_hide_hud", 0);

  if(!scripts\engine\utility::flag("desk_reveal")) {
    foreach(var_2 in level.cams) {
      if(var_2 == self && scripts\engine\utility::is_equal(self.wall_kill_reveal, 1))
        scripts\engine\utility::flag_set("desk_reveal");
    }
  }

  level notify("finished_cam_switch", level.camera_number);
}

player_input_watcher() {
  level.player endon("death");

  for(;;) {
    thread player_camera_moving_logic();
    wait 0.05;
  }
}

player_camera_moving_logic() {
  var_0 = level.player getnormalizedcameramovement();
  var_1 = level.player getnormalizedmovement();
  cam_angle_change(var_0);
}

cam_angle_change(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0.1;
}

camera_interacts_init() {
  var_0 = getEntArray("security_cam", "targetname");
  scripts\engine\utility::array_thread(level.cams, ::camera_interacts_watcher);
}

camera_interacts_remover() {
  scripts\engine\utility::array_thread(level.cams, ::camera_interacts_remove);
}

camera_interacts_watcher() {
  var_0 = 1500;
  level endon("survivior_escapes");
  level endon("ambo_hot");

  for(;;) {
    if(!scripts\engine\utility::flag("start_cam")) {
      if(self == level.cams[3] && scripts\sp\starts::is_after_start("cctv_01"))
        level.previous_cam = level.cams[3];

      if(self == level.cams[5] && scripts\sp\starts::is_after_start("cctv_post_intro"))
        level.previous_cam = level.cams[5];

      level.previous_cam.mod hide();
      scripts\engine\utility::flag_set("start_cam");
      level waittill("cam_switch");
    }

    if(self == level.cams[10] || self == level.cams[9] || self == level.cams[8])
      var_0 = 800;

    self.icon = deleteheadicon(self.mod);
    setheadiconfriendlyimage(self.icon, "icon_camera_indicator");
    setheadiconzoffset(self.icon, 0);
    setheadiconsnaptoedges(self.icon, var_0);
    setheadiconmaxdistance(self.icon, 300);
    addclienttoheadiconmask(self.icon, -30);
    var_1 = "+weapnext";

    if(!level.player getlocalplayerprofiledata("gpadEnabled"))
      var_1 = "+activate";

    thread mission_failed_icon_cleanup();
    self.mod scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 30), "", 40, 200, var_0, 0, 0, 0, undefined, "duration_none", var_1, undefined, 30);
    self.mod waittill("trigger");
    level.player playSound("emb_cctv_ui_camera_select");

    if(isDefined(self.icon))
      setheadiconimage(self.icon);

    change_camera();
    level waittill("cam_switch");
    wait 1.0;
  }
}

camera_interacts_remove() {
  if(isDefined(self.mod))
    self.mod scripts\sp\player\cursor_hint::remove_cursor_hint();
}

mission_failed_icon_cleanup() {
  self.mod endon("trigger");
  scripts\engine\utility::flag_wait("ambo_hot");

  if(isDefined(self.icon))
    setheadiconimage(self.icon);
}

cam_switcher(var_0) {
  level notify("cctv_switching_cam");
  var_1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_2 = undefined;
  var_1 fadeovertime(0.05);
  var_1.alpha = 1;
  wait 0.1;

  if(var_0 == "switch_cam_forward") {
    var_2 = level.active_cam_id + 1;

    if(var_2 >= level.active_feed.size)
      var_2 = 0;
  } else if(var_0 == "switch_cam_backward") {
    var_2 = level.active_cam_id - 1;

    if(var_2 < 0)
      var_2 = level.active_feed.size - 1;
  }

  level.active_feed[level.active_cam_id].last_angles = level.player getplayerangles();
  level.active_cam_id = var_2;
  level.cams[level.active_cam_id] thread change_camera();
  var_1 fadeovertime(0.1);
  var_1.alpha = 0;
}

cam_switcher_fade_out() {
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_1 = undefined;
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.5;
  self hide();
  wait 0.1;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0;
}

active_camera() {
  return level.active_feed[level.active_cam_id];
}

camera_enemy_behavior() {
  self allowedstances("stand");
  self.grenadeammo = 0;
  self.temp_ignore = 0;
  scripts\common\ai::magic_bullet_shield(1);
  self.fovcosine = 0.7;
  self.dontavoidplayer = 1;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "patrolling")) {
    self.fovcosine = 0.65;
    scripts\common\utility::demeanor_override("alert");
    scripts\engine\utility::set_movement_speed(120);

    if(scripts\engine\utility::is_equal(self.script_parameters, "patrol_end_04"))
      self.fovcosine = 0.7;

    if(scripts\engine\utility::is_equal(self.script_parameters, "patrol_puzzle_01")) {
      self.fovcosine = 0.5;
      scripts\engine\utility::set_movement_speed(150);
    }
  }

  waitframe();
  wait 6;
  thread ambo_caught_logic();
  thread end_game_logic();
}

ambo_caught_logic() {
  level endon("survivior_escapes");
  level endon("rescue_allowed");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "table_beating_enemy")) {
    return;
  }
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "table_beating_enemy"))
    scripts\engine\sp\utility::trigger_wait_targetname("cctv_part_3_save_trig");

  if(scripts\engine\utility::is_equal(self.targetname, "patrol_01")) {
    return;
  }
  var_0 = getEnt("hiding_spot_chair", "targetname");
  var_1 = getEnt("stacy_butcher_bad_zone", "targetname");

  while(!level.stacy_spotted && isDefined(self) && !scripts\engine\utility::flag("survivior_escapes")) {
    if(!scripts\engine\utility::flag("ambo_office_open")) {
      waitframe();
      continue;
    }

    if(getdvarint("scr_emb_cctv_safe", 1)) {
      return;
    }
    if(isDefined(level.stacy)) {
      if(!level.stacy scripts\engine\utility::ent_flag("prone")) {
        var_2 = distance(self.origin, level.stacy.origin);
        var_3 = 600;
        var_4 = 200;

        if(!scripts\engine\utility::flag("distraction_enabled")) {
          if(!level.stacy istouching(var_1) && self.temp_ignore == 0 && self cansee(level.stacy) && var_2 < var_3 && !scripts\engine\utility::flag("game_saving_cctv") && !level.stacy istouching(var_0)) {
            if(var_2 < var_4)
              wait 0.25;
            else
              wait 0.5;
          }
        }

        if(level.stacy istouching(var_1))
          level.stacy.badzone = 1;

        if(self.temp_ignore == 0 && self cansee(level.stacy) && var_2 < var_3 && !scripts\engine\utility::flag("game_saving_cctv") && !level.stacy istouching(var_0)) {
          self.fovcosine = 0.001;
          level.stacy_spotted = 1;
          scripts\engine\utility::flag_set("ambo_hot");
          thread enemy_engages_ambo(1);
          var_5 = getaiarray("axis");
          var_5 = scripts\engine\utility::array_remove(var_5, self);
          wait 1.9;
          scripts\engine\utility::array_thread(var_5, ::enemy_engages_ambo);
        }
      }
    }

    wait 0.1;
  }

  if(scripts\engine\utility::flag("survivior_escapes"))
    return;
}

end_game_logic() {
  level.stacy endon("death");
  self endon("death");
  scripts\engine\utility::flag_wait("survivior_escapes");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "butcher")) {
    return;
  }
  while(!istrue(level.stacy.swipe))
    waitframe();

  self clearpath();
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\sp\utility::set_moveplaybackrate(1);
  self stopanimScripted();
  scripts\common\ai::stop_magic_bullet_shield();
  self.ignoreall = 0;
  self.health = 75;
  self.attackeraccuracy = 3;
  self.baseaccuracy = 0.01;
  self.fovcosine = 0.1;
  scripts\engine\utility::set_movement_speed(250);
  scripts\engine\sp\utility::set_goal_radius(600);

  if(self == level.exit_guard)
    scripts\engine\utility::set_movement_speed(100);

  self setgoalentity(level.friendlies[0]);
}

poke_out_guy_loop() {
  self endon("death");
  var_0 = scripts\engine\utility::getanim("scavenge_idle_03");
  var_1 = var_0[0];
  var_2 = getanimlength(var_1);
  thread scripts\common\anim::anim_loop_solo(self, "scavenge_idle_03", "stop_poke_out_loop");
  waitframe();
  self setanimrate(var_1, 0.9);
}

scene_bookcase() {
  var_0 = getEnt("butcher", "script_noteworthy");
  var_0.animname = "aq_cctv_bookcase_01";
  var_0.name = "^1The Butcher";
  var_0.team = "axis";
  var_0.callsign = "^1Jamal Rahar";
  var_0.fovcosine = 0.99619;
  var_0 setlookattext(var_0.name, &"");
  var_1 = getEnt("hostage_taker", "script_noteworthy");
  var_1.animname = "aq_cctv_bookcase_02";
  var_1.fovcosine = 0.8;
  var_2 = scripts\engine\utility::getStruct("bookcase_beating", "targetname");
  var_2.angles = var_2.angles + (0, -90, 0);
  var_3 = scripts\engine\sp\utility::spawn_targetname("bookcase_victim", 1);
  var_3.animname = "bookcase_victim";
  var_3.ignoreme = 1;
  var_4 = [var_0, var_3, var_1];
  thread bookcase_break_out(var_3, var_0);
  var_2 thread scripts\common\anim::anim_loop_solo(var_3, "bookcase_beating_idle_start", "stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "bookcase_beating_idle_start", "stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(var_0, "bookcase_beating_idle_start", "stop_loop");
  scripts\engine\utility::flag_wait("first_cam_change");
  level waittill("cam_switch");
  waitframe();
  level waittill("cam_switch");
  wait 0.1;
  var_2 notify("stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(var_3, "bookcase_beating", "stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "bookcase_beating", "stop_loop");
  var_2 thread scripts\common\anim::anim_loop_solo(var_0, "bookcase_beating", "stop_loop");
  waitframe();
  var_4 = [var_3, var_1, var_0];
  scripts\engine\utility::array_thread(var_4, ::bookcase_beating_timing);
  thread dialogue_bookcase_scene(var_0, var_1, var_3);
  scripts\engine\utility::flag_wait("survivior_escapes");
  var_3 delete();
}

bookcase_break_out(var_0, var_1) {
  level endon("cctv_end");
  level waittill("ambo_hot");
  var_0.allowdeath = 1;
  var_0.forceragdollimmediate = 1;
  var_0 kill();
  var_1 stopanimScripted();
}

bookcase_beating_timing() {
  var_0 = scripts\engine\utility::getanim("bookcase_beating");
  var_1 = var_0[0];
  self setanimtime(var_1, 0.55);
}

scene_glass_killer() {}

bookcase_anim_speed() {
  var_0 = scripts\engine\utility::getanim("bookcase_beating");
  var_1 = var_0[0];
  self setanimrate(var_1, 1.1);
}

scene_table_beating() {
  waitframe();
  var_0 = getEnt("table_beating_enemy", "script_noteworthy");
  var_0.animname = "aq_cctv";
  var_1 = getspawner("table_beating_enemy", "script_noteworthy");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_0.fovcosine = 0.97;
  var_2 thread scripts\common\anim::anim_loop_solo(var_0, "est_search_desk_terry_idle", "stop_loop");
}

scene_opening() {
  level endon("ambo_hot");
  var_0 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 0);
  var_1.angles = var_0.angles;
  var_1.angles = var_1.angles + (0, 90, 0);
  var_2 = getEnt("alley_drag", "script_noteworthy");
  var_2.animname = "aq_cctv";
  var_3 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var_2 scripts\anim\shared.gsc::forceuseweapon(var_3, "primary");
  var_4 = getspawner("cctv_victim_alley_drag_ambo", "targetname");
  var_5 = var_4 scripts\engine\sp\utility::spawn_ai(1);
  var_5.animname = "ambo";
  var_5.team = "allies";
  var_5.name = "Ambassador Harris";
  var_5 scripts\common\ai::magic_bullet_shield();
  var_5.ignoreme = 1;
  level.ambassador_rock = var_5;
  var_6 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("runner_01", "script_noteworthy"));
  var_6.animname = "runner_01";
  var_6 setModel("body_civ_embassy_office_worker_male_1_1");
  var_7 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("runner_02", "script_noteworthy"));
  var_7.animname = "runner_02";
  var_7 setModel("body_civ_embassy_office_worker_female_2_1");
  var_8 = [var_6, var_7];
  var_1 thread scripts\common\anim::anim_first_frame(var_8, "ambo_kill_scene");
  var_9 = [var_2, var_5, var_6, var_7];
  var_1 thread scripts\common\anim::anim_loop_solo(var_5, "ambo_kill_scene_idle", "stop_loop");
  waitframe();
  var_10 = cinematicgettimeinmsec() / 1000;
  var_11 = var_5 scripts\engine\utility::getanim("ambo_kill_scene_idle")[0];
  var_12 = getanimlength(var_11);
  var_13 = var_10 / var_12;
  var_14 = var_13 - int(var_13);
  var_5 setanimtime(var_11, var_14);
  scripts\engine\utility::flag_wait("player_controls_enabled");
  var_1 notify("stop_loop");
  var_2 scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::smart_dialogue_generic, "dx_vom_aq1_cctv_02_caught_50");
  var_1 thread scripts\common\anim::anim_single(var_9, "ambo_kill_scene");
  var_1 thread ambo_last_frame(var_5);
  var_15 = [var_2, var_6, var_7];
  thread break_glass();
  scripts\engine\utility::delaythread(5, scripts\engine\utility::exploder, "cctv_blood_1");
  scripts\engine\utility::array_thread(var_15, ::opening_actors_to_idle, var_1);
  scripts\engine\utility::flag_wait("first_cam_change");
  var_16 = getEnt("hallway_killing_door", "targetname");
  var_15 = [var_2, var_6, var_7, var_16];
  var_16 scripts\engine\sp\utility::assign_animtree("cctv_hallway_door");
  var_1.origin = var_0.origin + (0, 0, 0);
  var_1 thread scripts\common\anim::anim_single(var_15, "hallway_kill_scene");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::exploder, "cctv_blood_2");
  scripts\engine\utility::delaythread(18, scripts\engine\utility::exploder, "cctv_blood_3");
  scripts\engine\utility::flag_wait("survivior_escapes");
  var_5 scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\utility::array_delete(var_9);
}

ambo_last_frame(var_0) {
  var_0 waittillmatch("single anim", "end");
  thread scripts\common\anim::anim_last_frame_solo(var_0, "ambo_kill_scene");
  level.stacy waittill("new_position");
  thread scripts\common\anim::anim_single_solo(var_0, "office_get_card");
  var_0 waittillmatch("single anim", "end");
  scripts\common\anim::anim_last_frame_solo(var_0, "office_get_card");
}

break_glass() {
  wait 4.2;
  var_0 = getglass("cctv_glass_window");
  destroyglass(var_0);
  wait 0.3;
  scripts\engine\utility::exploder("cctv_glass_break");
  var_0 = getglass("cctv_glass_door");
  destroyglass(var_0);
}

cctv_opening_scene_bink() {
  level endon("ambo_hot");
  var_0 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 0);
  var_1.angles = var_0.angles;
  var_1.angles = var_1.angles + (0, 90, 0);
  var_2 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("cctv_victim_alley_drag_ambo", "targetname"));
  var_2 notsolid();
  var_2.animname = "ambo";
  var_3 = [var_2];
  var_1 thread scripts\common\anim::anim_loop_solo(var_2, "ambo_kill_scene_idle");
}

opening_actors_to_idle(var_0) {
  self waittillmatch("single anim", "end");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "alley_drag")) {
    scripts\engine\utility::flag_wait("first_cam_change");
    self setgoalpos(self.origin);
  }

  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "hallway_kill_scene");
}

scene_room_beating() {
  level endon("ambo_hot");
  var_0 = undefined;
  var_1 = getEntArray("room_beating", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_3.targetname == "patrol_03")
      var_0 = var_3;
  }

  var_0 thread room_beating_patrol_bp();
  var_0.animname = "aq_cctv";
  var_0 endon("death");
  var_5 = scripts\engine\utility::getStruct("rummage_struct_desk_05", "targetname");
  var_6 = scripts\engine\utility::getStruct("room_beating_scene_02", "targetname");
  var_7 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("cctv_victim_room_beating_civ", "targetname"));
  var_7.animname = "cctv_victim";
  var_7 notsolid();
  var_1 = [var_0, var_7];
  var_6 thread scripts\common\anim::anim_first_frame(var_1, "room_beating_scene");
  var_0.temp_ignore = 1;
  camera_and_flag_watcher();

  if(scripts\engine\utility::flag("final_patrol_go_1"))
    wait 1;

  wait 0.25;
  var_6 thread scripts\common\anim::anim_single(var_1, "room_beating_scene");
  var_0 waittillmatch("single anim", "end");
  level.exit_guard = var_0;
  var_0 enableavoidance(0, 0);
  var_0 scripts\engine\sp\utility::set_goal_radius(20);
  var_0 scripts\common\utility::demeanor_override("alert");
  var_8 = var_0 scripts\engine\utility::get_target_ent();
  var_0 setgoalnode(var_8);
  var_0.temp_ignore = 0;
  scripts\engine\utility::flag_wait("patrol_to_exit");
  var_0.target = undefined;
  var_0 notify("reached_path_end");
  var_9 = getnodearray("exit_guard_node", "targetname");
  var_9 = sortbydistance(var_9, var_0.origin);
  var_0 thread scripts\sp\spawner::go_to_node(var_9[0]);
  var_0 setgoalnode(var_9[0]);
  waitframe();
  var_0 waittill("goal");
  var_0 scripts\common\utility::demeanor_override("patrol");
  scripts\engine\utility::flag_wait("distraction_enabled");
  wait 0.5;
  var_0.fovcosine = 0.4;
  var_0 scripts\common\utility::demeanor_override("combat");
  var_0 scripts\engine\sp\utility::set_goal_radius(10);
  var_0 scripts\engine\utility::set_movement_speed(80);
  var_0 clearpath();
  var_10 = getnodearray("investigate_node", "targetname");
  var_10 = sortbydistance(var_10, level.stacy.origin);
  var_0 setgoalnode(var_10[0]);
  var_0 waittill("goal");
  var_0 thread stacy_distance_watcher();
  var_0.allowdeath = 1;
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "lookaround_05");
  var_0 thread distracted_breakout();
  wait 10;
  var_0 setgoalpos(level.stacy.origin);
}

room_beating_patrol_bp() {
  level endon("patrol_to_exit");
  scripts\engine\utility::flag_wait("final_patrol_go_1");
  var_0 = getEnt("left_path_trigger", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_2 = getEnt("end_game_volume", "targetname");
  var_3 = 0;
  var_4 = undefined;

  for(;;) {
    var_5 = self.angles[1];

    if(self istouching(var_2) && (self.origin[1] > -1900 && self.angles[1] < 120) || self.angles[1] > 120 && self.origin[1] > -1600) {
      if(!var_3) {
        var_4 = createnavobstaclebyent(var_1, "allies", "neutral");
        var_3 = 1;
      }
    } else if(var_3) {
      destroynavobstacle(var_4);
      var_3 = 0;
    }

    wait 0.2;
  }
}

camera_and_flag_watcher() {
  level endon("final_patrol_go_1");

  while(!isDefined(level.camera_number))
    waitframe();

  while(level.camera_number != 7)
    waitframe();
}

distracted_breakout() {
  self endon("death");
  scripts\engine\utility::flag_wait("survivior_escapes");
  self.ignoreall = 0;

  while(!istrue(level.stacy.swipe))
    waitframe();

  wait 1;
  self getenemyinfo(level.friendlies[0]);
  self clearpath();
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\sp\utility::set_moveplaybackrate(1);
  self stopanimScripted();
  self.ignoreall = 0;
  self.health = 75;
  self.attackeraccuracy = 3;
  self.baseaccuracy = 0.01;
  self.fovcosine = 0.5;
  scripts\engine\utility::set_movement_speed(240);
  scripts\engine\sp\utility::set_goal_radius(100);

  if(self == level.exit_guard)
    scripts\engine\utility::set_movement_speed(100);

  self setgoalentity(level.friendlies[0]);
}

stacy_distance_watcher() {
  level endon("cctv_end");
  level endon("survivior_escapes");
  level.stacy endon("death");

  while(50 < distance(self.origin, level.stacy.origin))
    waitframe();

  scripts\engine\utility::flag_set("ambo_hot");
  thread enemy_engages_ambo(1);
}

scene_wounded() {
  if(getdvarint("scr_emb_cctv_caught", 1)) {
    iprintln("ignored");
    return;
  }

  var_0 = scripts\engine\utility::getStruct("cctv_wounded_struct", "targetname");
  var_0.origin = var_0.origin + (0, 0, -3);
  var_1 = getspawner("bookcase_victim", "targetname");
  var_1.count = 2;
  var_2 = undefined;
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3) {
    if(scripts\engine\utility::is_equal(var_5.script_parameters, "patrol_end_01"))
      var_2 = var_5;
  }

  var_7 = var_2 scripts\engine\utility::get_target_ent();
  var_2.lastnode = var_7 scripts\engine\sp\utility::get_last_ent_in_chain("pathnode");
  var_8 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var_2 scripts\anim\shared.gsc::forceuseweapon(var_8, "primary");
  var_2 clearpath();
  var_2.animname = "aq_cctv";
  var_9 = var_2 scripts\engine\utility::getanim("wounded_start");
  var_10 = getstartorigin(var_0.origin, var_0.angles, var_9);
  var_11 = getstartangles(var_0.origin, var_0.angles, var_9);
  var_2 forceteleport(var_10, var_11);
  waitframe();
  var_2 stopanimScripted();
  var_2 setgoalpos(var_2.origin);
  var_12 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("wounded_victim", "targetname"));
  var_12.targetname = "wounded_victim";
  var_12.animname = "wounded_victim";
  var_12.ignoreme = 1;
  var_0 thread scripts\common\anim::anim_loop_solo(var_12, "wounded_start_idle", "stop_loop");
  var_13 = [var_2, var_12, level.stacy];
  scripts\engine\utility::flag_wait("final_patrol_go_1");
  level.scripted_stacy_idle = 1;
  level thread dialogue_wounded_scene();
  var_14 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var_14, ::ally_nodes_interact_remove);
  var_0 scripts\sp\anim::anim_reach_solo(level.stacy, "wounded_start");
  var_0 notify("stop_loop");
  var_0 thread scripts\common\anim::anim_single(var_13, "wounded_start");
  var_2 thread wounded_aq_to_patrol();
  scripts\engine\utility::delaythread(13, scripts\engine\utility::exploder, "cctv_blood_6");
  level.stacy waittillmatch("single anim", "end");
  level.stacy scripts\engine\sp\utility::set_goal_pos(level.stacy.origin);
  level.stacy clearpath();
  var_0 thread scripts\common\anim::anim_loop_solo(level.stacy, "wounded_end_idle", "stop_loop");
  scripts\engine\utility::flag_clear("final_patrol_go_1");
  var_12 notsolid();
  level waittill("wounded_dialogue_auto_save");
  scripts\engine\sp\utility::autosave_by_name("wounded_complete");
  level waittill("wounded_dialogue_finished");
  thread ally_nodes_init();
  level.scripted_stacy_idle = 0;
  level.stacy waittill("new_position");
  var_0 notify("stop_loop");
  level.stacy thread scripts\common\anim::anim_single_solo(level.stacy, "wounded_exit");
  wait 1.2;
  level.stacy stopanimScripted();
}

wounded_aq_to_patrol() {
  self waittillmatch("single anim", "end");
  self notify("stop_going_to_node");
  self setgoalpos((-6830, -948, -592));
  scripts\common\utility::demeanor_override("patrol");
}

scene_wall_kill() {
  var_0 = getEnt("wall_killer", "script_noteworthy");
  var_0.animname = "aq_cctv";
  var_1 = getnode("final_patrol_node", "targetname");
  var_0 scripts\common\utility::demeanor_override("alert");
  var_0 scripts\engine\utility::set_movement_speed(150);
  var_0 forceteleport(var_1.origin, var_1.angles);
  var_0 setgoalpos(var_0.origin);
  var_0 scripts\engine\sp\utility::set_goal_radius(50);
  var_1 = getnode("final_patrol_node", "targetname");
  var_0 scripts\sp\spawner::go_to_node(var_1);
  var_0 setgoalnode(var_1);
  var_0 enableavoidance(0, 0);
  var_0 scripts\engine\sp\utility::disable_surprise();
}

temporary_ignore(var_0) {
  wait(var_0);
  self.temp_ignore = 1;
}

patrol_one_go() {
  var_0 = getEnt("beatdown_trigger", "targetname");
  var_0 scripts\engine\utility::waittill_any_timeout(5, "trigger");
}

enemy_engages_ambo(var_0) {
  level.stacy endon("death");

  if(level.stacy.badzone) {
    if(scripts\engine\utility::is_equal(self.script_noteworthy, "butcher") || scripts\engine\utility::is_equal(self.script_noteworthy, "hostage_taker"))
      return;
  }

  self.target = undefined;
  thread stop_seeking();
  self.fovcosine = 0.001;
  self allowedstances("stand", "crouch");
  self clearpath();
  self setgoalpos(self.origin);
  self notify("stop_going_to_node");
  waitframe();
  self setgoalpos(self.origin);

  if(isalive(level.stacy))
    self getenemyinfo(level.stacy);

  scripts\common\utility::demeanor_override("combat");
  self cleargoalvolume();
  self clearpath();
  self stopanimScripted();

  if(level.stacy.badzone)
    level notify("badzone");

  var_1 = ["dx_vom_aq1_cctv_02_caught_20", "dx_vom_aq1_cctv_02_caught_30", "dx_vom_aq1_cctv_02_caught_40", "dx_vom_aq1_cctv_02_caught_50"];

  if(isDefined(var_0))
    thread scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var_1));

  level.stacy.ignoreme = 0;

  if(isalive(level.stacy)) {
    self.suppress_uselastenemysightpos = 1;
    self.dontgiveuponsuppression = 1;
    self.forcesuppressai = 1;
    thread last_sight_updater();
    scripts\engine\utility::set_movement_speed(120);
    self.baseaccuracy = 1000;
    scripts\engine\sp\utility::set_goal_radius(100);
    self setgoalentity(level.stacy);
    scripts\engine\sp\utility::set_favoriteenemy(level.stacy);
    scripts\engine\sp\utility::set_ignoresuppression(1);
    level.stacy waittill("death");
    self.ignoreall = 1;
    scripts\common\utility::demeanor_override("patrol");
    scripts\engine\utility::set_movement_speed(80);
  }
}

stacy_bad_zone_attack() {
  level endon("cctv_end");
  level waittill("badzone");
  level.stacy.ignoreme = 0;
  wait 0.1;
  var_0 = [];
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "butcher") || scripts\engine\utility::is_equal(var_3.script_noteworthy, "hostage_taker"))
      var_0[var_0.size] = var_3;
  }

  var_5 = getnodearray("stacy_butcher_bad_zone_nodes", "targetname");

  foreach(var_3 in var_0) {
    if(isalive(level.stacy))
      var_3 getenemyinfo(level.stacy);

    var_3 scripts\common\utility::demeanor_override("combat");
    var_3 cleargoalvolume();
    var_3.ignoreall = 0;
    var_3 clearpath();
    var_3 stopanimScripted();
    var_3.target = undefined;
    var_3 thread stop_seeking();
    var_3.fovcosine = 0.001;
    var_3 allowedstances("stand", "crouch");
    var_3 notify("stop_going_to_node");
    waitframe();
    var_3 setgoalpos(var_3.origin);
    var_3 thread scripts\engine\sp\utility::set_favoriteenemy(level.stacy);
    var_3 thread scripts\engine\utility::set_movement_speed(120);
    var_3 thread scripts\engine\sp\utility::set_goal_radius(16);
    var_3.baseaccuracy = 1000;
    var_3.fovcosine = cos(89);
    var_7 = sortbydistance(var_5, var_3.origin)[0];
    var_3 setgoalpos(var_7.origin);
    var_5 = scripts\engine\utility::array_remove(var_5, var_7);
  }
}

stop_seeking() {
  level.stacy waittill("death");
  self setgoalpos(self.origin);
}

last_sight_updater() {
  level.stacy endon("death");

  for(;;) {
    self.lastenemysightpos = level.stacy.origin;
    waitframe();
  }
}

amb_info_updater() {
  level.stacy endon("death");

  for(;;) {
    self getenemyinfo(level.stacy);
    waitframe();
  }
}

objective_manager() {
  scripts\engine\sp\objectives::objective_add("direct_ambassador", "current", undefined, &"EMBASSY/OBJ_DSC_AMBASSADOR");
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  scripts\engine\sp\objectives::objective_remove("direct_ambassador");
  scripts\engine\sp\objectives::objective_add("escort", "current", level.stacy.origin + (0, 0, 50), undefined, "Stacy");
  scripts\engine\sp\objectives::objective_set_on_entity("escort", "Stacy", level.stacy);
  var_0 = scripts\engine\sp\objectives::_objective_getindexforname("escort");
  objective_setzoffset(var_0, 72);
  scripts\engine\sp\objectives::objective_add("escape", "current", (-7019, -1119, -535), &"EMBASSY/OBJ_SAFETY_GUIDE");
  scripts\engine\utility::flag_wait("save_part_2_start");
  scripts\engine\sp\objectives::objective_update("escape", "current", (-6157, -2237, -530), &"EMBASSY/OBJ_SAFETY_GUIDE");
  scripts\engine\utility::flag_wait("cctv_end");
  scripts\engine\sp\objectives::objective_remove("escort");
  scripts\engine\sp\objectives::objective_remove("escape");
}

cctv_outro_bink_start() {}

cctv_outro_bink_main() {
  visionsetnaked("embassy_cctv_01", 0);
  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", 13);
  var_0 = scripts\engine\utility::getStruct("cctv_outro_bink_cam", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1.origin = var_1.origin + (0, 0, -67);
  level.player playerlinktoabsolute(var_1);
  level.player disableweapons();
  level.player hidelegsandshadow();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_price();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_farah();
  scripts\sp\maps\embassy\embassy_util.gsc::spawn_stacy();
  var_2 = scripts\engine\sp\utility::spawn_anim_model("garage_enter_door");
  var_3 = scripts\engine\sp\utility::spawn_anim_model("keycard");
  var_4 = getEntArray("cctv_bink_outro_hidden_door", "targetname");

  foreach(var_6 in var_4)
  var_6 hide();

  var_8 = [level.price, level.stacy, level.farah, var_2, var_3];
  var_9 = scripts\engine\utility::getStruct("ap_cctv_outro_bink", "targetname");

  for(;;) {
    thread scripts\sp\maps\embassy\embassy_util.gsc::swap_card_reader("cctv_bink_outro_card_reader");
    level thread scripts\engine\sp\utility::notify_delay("card_reader_swap", 5);
    var_9 scripts\common\anim::anim_single(var_8, "gar_meetup_enter");
    waitframe();
  }
}

cctv_outro_bink_catchup() {}

display_all_node_names() {
  for(;;) {
    foreach(var_1 in getallnodes()) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(isDefined(var_1.script_namenumber)) {}
    }

    waitframe();
  }
}