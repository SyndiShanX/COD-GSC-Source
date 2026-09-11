/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\embassy\embassy_cctv.gsc
****************************************************/

function embassy_cctv_precache() {
  scripts\engine\sp\utility::add_hint_string("ambo_direct_hint", &"EMBASSY/DIRECT_STACY", &scripts\sp\maps\embassy\embassy_util::ambo_direct_hint_check);
  scripts\engine\sp\utility::add_hint_string("camera_change_hint", &"EMBASSY/CAMERA_HINT", &scripts\sp\maps\embassy\embassy_util::camera_change_hint_check);
  level.exit_node = undefined;
  level.player_struct = spawnStruct();
  level.player_struct.animname = "Kyle";
  level.player_struct.name = "Kyle";
  level.camera_number = undefined;
  precacheshader("ui_bomber_drone_overlay");
}

function embassy_cctv_init() {}

function cctv_spot_light_limit() {
  scripts\engine\utility::flag_wait("load_finished");
  setsaveddvar("MROOOROPKL", 8);
  setsaveddvar("LTQMSPKRKO", 8);
  scripts\engine\utility::flag_wait("cctv_end");
  setsaveddvar("MROOOROPKL", 6);
  setsaveddvar("LTQMSPKRKO", 6);
}

function embassy_cctv_fx() {}

function embassy_cctv_flags() {
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

function cctv_camera_look_speed(var0) {
  if(var0) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self enableslowaim(0.75, 0.4);
      self capturnrate(0, 0);
      return;
    }

    self disableslowaim();
    return;
  }

  self disableslowaim();
  self capturnrate(0, 0);
}

function security_cam_01_start() {}

function security_cam_01_main() {
  thread objective_manager();
  thread cctv_camera_overlay();
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.15, 0.05);
  thread cctv_spot_light_limit();
  scripts\engine\utility::exploder("cctv_amb_vfx");
  thread scripts\engine\sp\utility::battlechatter_off("axis");
  thread dialogue_decks_init();
  camera_controller_init();
  stacy_spawn();
  var0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
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
  var1 = getEnt("chair_start", "targetname");
  level.cell_phone scripts\engine\sp\utility::assign_animtree("phone_start");
  var1 scripts\engine\sp\utility::assign_animtree("chair_start");
  level.cell_phone notsolid();
  var2 = [level.cell_phone, level.stacy, var1];
  var3 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var4 = spawnStruct();
  var4.origin = var3.origin;
  var4 scripts\common\anim::anim_first_frame(var2, "office_start");
  thread scripts\sp\maps\embassy\embassy_util::focusflag();
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
  level.player lerpviewangleclamp(1, 0.25, 0.25, 360, 360, 60, 50);
  cctv_camera_look_speed(level.player, 1);
  wait 9;
  thread dialogue_cctv_intro_gameplay();
  var4 thread scripts\common\anim::anim_single(var2, "office_start");
  level.stacy waittillmatch("single anim", "end");
  var2 = [level.stacy];
  var4 thread scripts\common\anim::anim_loop(var2, "office_start_idle", "stop_loop");
  var2 = [level.cell_phone, level.stacy];
  level.cell_phone linkTo(level.stacy, "tag_accessory_right");
  level.stacy allowedstances("crouch");
  level.stacy scripts\engine\sp\utility::set_goal_radius(20);
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  level.stacy.name = "Stacy";
  scripts\engine\sp\utility::autosave_now();
  ally_nodes_init();
  scripts\engine\sp\utility::display_hint("ambo_direct_hint");
  level.stacy.animstruct = var4;
  level.stacy waittill("new_position");
  scripts\engine\utility::flag_set("stacy_animating");
  var4 notify("stop_loop");
  var2 = [level.stacy];
  var4 thread scripts\common\anim::anim_single(var2, "office_get_card");
  level.stacy waittillmatch("single anim", "end");
  var4 thread scripts\common\anim::anim_loop(var2, "office_get_card_idle");
  scripts\engine\utility::flag_clear("stacy_animating");
  thread securitycam_slow_look();
  scripts\engine\sp\utility::display_hint("camera_change_hint");
  camera_interacts_init();
  scripts\engine\utility::flag_wait("first_cam_change");
  level.ambassador_rock = undefined;
  scripts\engine\utility::flag_set("ambo_office_open");
  level.stacy waittill("new_position");
  var4 notify("stop_loop");
  var2 = [level.stacy];

  if(scripts\engine\utility::flag("stacy_animating_to_node") && !scripts\engine\utility::flag("start_office_exited")) {
    office_exit_scene(var4);
    level.stacy stopanimScripted();
  } else {
    var4 thread scripts\common\anim::anim_single(var2, "office_exit");
    wait 3;
  }

  scripts\engine\utility::flag_set("start_office_exited");
  scripts\engine\utility::flag_set("ambo_keycard_retreieved");
  level.stacy stopanimScripted();
  var4 notify("stop_loop");
}

function stacy_run_away_watcher() {
  level.stacy endon("death");
  scripts\engine\utility::flag_wait("ambo_hot");
  waitframe();
  self notify("stop_going_to_node");
  level.stacy scripts\engine\sp\utility::set_goal_radius(32);
  level.stacy scripts\common\ai::disable_arrivals();
  level.stacy setgoalpos((-6542, -129, -551));
}

function stacy_hasnt_moved_check() {
  level waittill("wounded_dialogue_finished");

  while(!scripts\engine\utility::flag("cctv_end")) {
    level.stacy waittill("goal");
    stacy_moving_watcher();
  }
}

function stacy_moving_watcher() {
  level.stacy endon("new_position");
  level.stacy endon("death");
  level endon("cctv_end");
  level endon("player_pushed_focus");
  wait 20;

  if(!level.stacy.moving) {
    level.player thread scripts\sp\player::focus_display_hint(undefined, 5);
    return;
  }
}

function audio_cctv_mix() {
  level.player setclienttriggeraudiozone("embassy_cctv_cam", 0.1);
  level.player setsoundsubmix("embassy_cctv_filter", 0.1);
}

function security_cam_bink_main() {
  scripts\sp\maps\embassy\embassy_util::spawn_price();
  scripts\engine\utility::exploder("cctv_amb_vfx");
  camera_controller_init();
  level.player playerlinkTo(level.cams[0], "tag_origin", 1, 0, 0, 0, 0, 0);
  level.cam_org = scripts\engine\utility::spawn_tag_origin(level.cams[0].origin, level.cams[0].angles);
  level.player playerlinktodelta(level.cams[0], "tag_origin", 1, 360, 360, 60, 50, 0);
  level.player setplayerangles((level.cams[0].angles[0], level.cams[0].angles[1], 0));
  cctv_camera_look_speed(level.player, 1);
  thread cctv_opening_scene_bink();
  level waittill("forever");
}

function cctv_camera_overlay() {
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

function stacy_nav_blockers() {
  var0 = getEntArray("stacy_nav_blockers", "targetname");

  foreach(var2 in var0) {
    createnavbadplacebyent(var2, "neutral", "allies");
  }
}

function office_exit_scene(var0) {
  var1 = [level.stacy];
  level endon("skip_cabinet_arrival");
  var0 thread scripts\common\anim::anim_single(var1, "office_exit");
  scripts\engine\utility::flag_set("start_office_exited");
  thread new_position_while_animating_watcher();
  level.stacy waittillmatch("single anim", "end");
  level notify("kill_animating_watcher");
  var0 thread scripts\common\anim::anim_loop(var1, "office_exit_idle", "stop_loop");
  level.stacy waittill("new_position");
  level.stacy thread scripts\common\anim::anim_single_solo(level.stacy, "hallway_exit");
  wait 1;
  level.stacy stopanimScripted();
}

function new_position_while_animating_watcher() {
  level endon("kill_animating_watcher");
  waitframe();
  level.stacy waittill("new_position");
  level.stacy setgoalpos(level.stacy.origin);
  level notify("skip_cabinet_arrival");
}

function mission_failed() {
  level endon("survivior_escapes");
  scripts\engine\utility::flag_wait("ambo_hot");
  level.stacy scripts\engine\utility::waittill_any_timeout(10, "death");
  wait 0.5;
  scripts\sp\player_death::set_custom_death_quote(53);
  level.player kill();
}

function dialogue_cctv_intro() {
  wait 2.65;
  level.player thread scripts\sp\maps\embassy\embassy_util::say("dx_vom_kyle_cctv_01_intro_30");
  wait 8;
  level.player scripts\sp\maps\embassy\embassy_util::say("dx_vom_kyle_cctv_01_intro_60");
  wait 1.5;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_70");
  wait 0.45;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_cctv_01_intro_80");
}

function dialogue_cctv_intro_gameplay() {
  wait 8.5;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_01_intro_90");
  wait 0.5;
  level.stacy thread scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_100");
  wait 1;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_110");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_120");
  scripts\engine\utility::delaythread(0.5, &scripts\engine\utility::flag_set, "intro_dialogue_setup_done");
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_01_intro_140");
  level.stacy waittill("new_position");
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_kyle_cctv_01_intro_190");
  wait 5.5;
  var0 = pre_cam_change_dialogue();

  if(istrue(var0)) {
    level.stacy waittill("new_position");
  }

  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_270");
}

function pre_cam_change_dialogue() {
  thread mus_cctv();

  if(scripts\engine\utility::flag("first_cam_change")) {
    return true;
  }

  level.stacy endon("new_position");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_200");

  if(scripts\engine\utility::flag("first_cam_change")) {
    return true;
  }

  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_210");

  if(scripts\engine\utility::flag("first_cam_change")) {
    return true;
  }

  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_01_intro_220");

  if(scripts\engine\utility::flag("first_cam_change")) {
    return true;
  }

  level.has_said_cam_switch = 1;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_cctv_01_intro_250");
  return true;
}

function check_end_bookcase_dialogue(var0) {
  while(distance2dsquared(level.player.origin, var0.origin) < 500000) {
    waitframe();
  }

  level notify("end_bookcase_dialogue");
}

function mus_cctv() {
  scripts\engine\utility::flag_wait("first_cam_change");
  setmusicstate("mx_embassy_cctv");
}

function dialogue_bookcase_scene(var0, var1, var2) {
  level endon("ambo_hot");
  level waittillmatch("finished_cam_switch", 3);
  level endon("end_bookcase_dialogue");
  thread check_end_bookcase_dialogue(var0);
  thread say_on_see_butcher(var0);
  wait 1;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_10");
  wait 0.3;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_20");
  wait 1.8;
  var2 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_30");
  wait 0.6;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_40");
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_50");
  wait 1.15;
  var2 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_60");
  wait 0.8;
  var2 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_70");
  wait 0.6;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_80");
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_90");
  wait 0.7;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_100");
  wait 1.6;
  var2 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_110");
  wait 0.7;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_120");
  var2 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_cvm1_cctv_post_intro_interrogation1_130");
  wait 1.2;
  var0 scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_enf_cctv_post_intro_interrogation1_140");
  level notify("reset_stacy_nag_delay");
  wait 1;
  level.stacy scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_stac_cctv_post_intro_office_80");
}

function say_on_see_butcher(var0) {
  level endon("cam_switch");
  scripts\sp\maps\embassy\embassy_util::wait_lookat(var0, 300, "j_head", 0.1);
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_cctv_post_intro_interrogation1_00");
}

function caught_dialogue() {
  scripts\engine\utility::flag_wait("ambo_hot");
  wait 0.2;
  level.stacy thread scripts\engine\utility::call_on_notify_no_endon_death("damage", &stopsounds);
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_caught_10");
  wait 1.65;

  if(randomintrange(0, 100) < 80) {
    return;
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_cctv_post_intro_office_190");
}

function dialogue_decks_init() {
  thread caught_dialogue();

  if(!isDefined(level.cctv_vo)) {
    level.cctv_vo = spawnStruct();
  }

  var0 = ["dx_vom_kyle_cctv_02_exit_150", "dx_vom_kyle_cctv_02_exit_164"];
  level.cctv_vo.use_distraction = scripts\engine\sp\utility::create_deck(var0);
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_stac_cctv_02_wounded_40");
}

function dialogue_cam_change() {
  level endon("ambo_hot");
  level.stacy endon("death");

  if(level.stacy iswaitingonsound()) {
    return;
  }
}

function dialogue_cctv_nodes(var0) {
  if(scripts\engine\utility::flag("ambo_hot")) {
    return;
  }

  level endon("ambo_hot");
  level.stacy endon("death");
  var1 = undefined;

  if(isDefined(level.stacy.goalnode) && isDefined(level.stacy.goalnode.script_namenumber)) {
    var1 = strtok(level.stacy.goalnode.script_namenumber, "_");
  }

  var2 = get_line_from_landmark(var0, var1);

  if(isDefined(var2)) {
    if(isstring(var2)) {
      level.cctv_vo.last_line = var2;
    } else if(scripts\engine\sp\utility::is_deck(var2)) {
      level.cctv_vo.last_line = var2 scripts\engine\sp\utility::deck_draw();
    }

    level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter(level.cctv_vo.last_line, 1, 0.5);
  }

  if(!scripts\engine\utility::flag("first_cam_change") || isDefined(var1) && var1[0] == "hallway") {
    return;
  }

  if(level.cctv_vo.stacy_should_confirm scripts\engine\sp\utility::deck_draw()) {
    level.stacy scripts\sp\maps\embassy\embassy_util::say_as_chatter(level.cctv_vo.stacy_confirmations scripts\engine\sp\utility::deck_draw(), 0, 0.5);
    return;
  }
}

function get_line_from_landmark(var0, var1) {
  level.has_said_cam_switch = 0;

  if(!isDefined(var0)) {
    return level.cctv_vo.commands["generic"];
  }

  var2 = var0;
  var0 = strtok(var0, "_");
  var3 = self;
  thread stacy_direction_nags();

  if(isDefined(var0) && var0[0] == "exit") {
    level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_cctv_02_exit_180", 1);
    return;
  }

  if(isDefined(var2) && var2 == "cubical_9_copier") {
    return level.cctv_vo.commands["shredder"];
  }

  if(isDefined(level.stacy.previous_node) && level.stacy.previous_node == var3) {
    return level.cctv_vo.commands["back"];
  } else if(isDefined(var2) && var2 == "cart_door" && !istrue(level.cctv_vo.said_cart)) {
    level.cctv_vo.said_cart = 1;
    return "dx_vom_kyle_cctv_post_intro_office_40";
  } else if(isDefined(var2) && var2 == "corner_1" && !istrue(level.cctv_vo.said_pillar)) {
    level.cctv_vo.said_pillar = 1;
    return "dx_vom_kyle_cctv_post_intro_office_141";
  } else if(isDefined(var2) && var2 == "shelf_1_cart" && !istrue(level.cctv_vo.said_shelf)) {
    level.cctv_vo.said_shelf = 1;
    return "dx_vom_kyle_cctv_post_intro_office_140";
  } else if(var2 == "hallway_exit" && isDefined(var1) && var1[0] == "hallway" && !istrue(level.cctv_vo.said_around_corner_hallway)) {
    level.cctv_vo.said_around_corner_hallway = 1;
    return "dx_vom_kyle_cctv_post_intro_office_144";
  } else if(var0[0] == "hallway" && isDefined(var1) && var1[0] == "hallway" && !istrue(level.cctv_vo.said_cont_hallway)) {
    level.cctv_vo.said_cont_hallway = 1;
    return "dx_vom_kyle_cctv_post_intro_office_143";
  } else if(var2 == "hallway_corner" && isDefined(var1) && var1[0] == "hallway" && !istrue(level.cctv_vo.said_hallway_corner)) {
    level.cctv_vo.said_hallway_corner = 1;
    return "dx_vom_kyle_cctv_post_intro_office_310";
  } else if(isDefined(var2) && var2 == "desk_1_body" && !istrue(level.cctv_vo.said_body)) {
    return "dx_vom_kyle_cctv_post_intro_office_120";
  }

  if(isDefined(var2) && var2 == "cubicle_9_copier") {
    return level.cctv_vo.commands["shredder"];
  }

  if(isDefined(var1) && are_part_of_same_landmark(var0, var1) && var0[0] == "desk") {
    if(var2 == "desk_1_cart") {
      return level.cctv_vo.commands["cart"];
    }

    if(var2 == "desk_1_inside") {
      return "dx_vom_kyle_cctv_post_intro_office_145";
    }

    return "dx_vom_kyle_cctv_post_intro_office_250";
  } else if(var0[0] == "desk") {
    return "dx_vom_kyle_cctv_post_intro_office_230";
  } else if(isDefined(var0) && var0[0] == "hallway" && (!isDefined(var1) || var1[0] != "hallway")) {
    return "dx_vom_kyle_cctv_post_intro_office_260";
  } else if(isDefined(var0) && var0[0] == "whiteboard" && (!isDefined(var1) || var1[0] != "whiteboard")) {
    return "dx_vom_kyle_cctv_02_exit_60";
  } else if(isDefined(var0) && var0[0] == "chair" && (!isDefined(var1) || var1[0] != "chair")) {
    return "dx_vom_kyle_cctv_post_intro_office_148";
  }

  if(var0[0] == "shelf" && isDefined(var1) && var1[0] == "shelf") {
    if(are_part_of_same_landmark(var0, var1)) {
      return "dx_vom_kyle_cctv_post_intro_office_142";
    } else {
      return level.cctv_vo.commands["cubicle_other"];
    }
  }

  if(var0[0] == "cubicle" && isDefined(var1) && var1[0] == "cubicle") {
    if(are_part_of_same_landmark(var0, var1)) {
      if(var1[2] == "inside") {
        if(level.cctv_vo.commands["outside"] scripts\engine\sp\utility::deck_is_empty()) {
          level.cctv_vo.commands["outside"] scripts\sp\maps\embassy\embassy_util::array_deck_shuffle();
        }

        return level.cctv_vo.commands["outside"] scripts\engine\sp\utility::deck_draw();
      } else if(var0[2] == "outside") {
        return level.cctv_vo.commands["otherside"] scripts\engine\sp\utility::deck_draw();
      } else {
        if(level.cctv_vo.commands["inside"] scripts\engine\sp\utility::deck_is_empty()) {
          level.cctv_vo.commands["inside"] scripts\sp\maps\embassy\embassy_util::array_deck_shuffle();
        }

        return level.cctv_vo.commands["inside"] scripts\engine\sp\utility::deck_draw();
      }
    } else {
      return level.cctv_vo.commands["cubicle_other"];
    }
  } else if(isDefined(var1) && var0[0] == var1[0]) {
    return "dx_vom_kyle_cctv_post_intro_office_110";
  }

  if(!isDefined(level.cctv_vo.commands[var0[0]])) {
    return level.cctv_vo.commands["generic"];
  }

  return level.cctv_vo.commands[var0[0]];
}

function are_part_of_same_landmark(var0, var1) {
  var2 = isDefined(var0) && isDefined(var1);
  var3 = scripts\engine\utility::is_equal(var0[0], var1[0]);
  var4 = !isDefined(var0[1]) && !isDefined(var1[1]);
  var4 = var4 || scripts\engine\utility::is_equal(var0[1], var1[1]);
  return var2 && var3 && var4;
}

function stacy_direction_nags() {
  level.stacy endon("new_position");
  level.stacy endon("stop_nags");
  level.stacy endon("death");
  level endon("ambo_hot");
  level.stacy waittill("start_move");
  level.stacy waittill("goal");

  if(!isDefined(level.stacy.nag_time_delay)) {
    level.stacy.nag_time_delay = 6;
  }

  if(!isDefined(level.stacy.variability)) {
    level.stacy.variability = 2;
  }

  level.stacy.nag_time_delay = max(level.stacy.nag_time_delay - 2, 6);
  level.stacy.variability = max(level.stacy.variability - 1, 2);
  wait 1;

  for(;;) {
    while(!istrue(wait_stacy_nag_time(level.stacy.nag_time_delay, level.stacy.variability))) {}

    level.stacy scripts\sp\maps\embassy\embassy_util::say_as_chatter(level.cctv_vo.stacy_nags scripts\engine\sp\utility::deck_draw(), 0);
    level.stacy.nag_time_delay = min(level.stacy.nag_time_delay + 3, 20);
    level.stacy.variability = min(level.stacy.variability + 1, 6);
  }
}

function wait_stacy_nag_time(var0, var1) {
  level endon("reset_stacy_nag_delay");
  wait randomfloatrange(var0 - var1, var0 + var1);
  return true;
}

function dialogue_wounded_scene() {
  level.has_said_cam_switch = 1;
  level.stacy endon("new_position");
  level.stacy endon("death");
  level.stacy notify("stop_nags");
  wait 0.9;
  level.stacy stopsounds();
  waitframe();
  level.player scripts\engine\utility::delaythread(1.5, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_kyle_cctv_02_wounded_110");
  level.stacy scripts\engine\sp\utility::smart_dialogue("dx_vom_stac_cctv_02_wounded_50");
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_cvm2_cctv_02_wounded_130");
  level.player scripts\engine\utility::delaythread(0.5, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_kyle_cctv_02_wounded_70");
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

function dialogue_cctv_cell_phone() {
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

function dialogue_cctv_first_room_exit() {
  level endon("exit_guard_03");
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "There's a fighter guarding the exit.", "purple");
  wait 1;
  level thread scripts\engine\utility::add_dialogue_line("Kyle", "We'll need to distract him.", "green");
  wait 10;
  level thread scripts\engine\utility::add_dialogue_line("Stacy", "There's a phone in the office next to him...", "purple");
}

function cctv_fade_in() {
  level.player freezecontrols(1);
  var0 = undefined;
  wait 1;
  scripts\engine\utility::flag_set("player_controls_enabled");
  level.player freezecontrols(0);
}

function securitycam_slow_look() {
  while(!scripts\engine\utility::flag("cctv_end")) {
    wait 1;
    cctv_camera_look_speed(level.player, 1);
    waitframe();
  }

  cctv_camera_look_speed(level.player, 0);
}

function security_cam_01_catchup() {
  scripts\engine\utility::flag_set("ambo_office_open");
  scripts\engine\utility::flag_set("chair_pushed");
  scripts\engine\utility::flag_set("first_cam_change");
  scripts\engine\utility::flag_set("intro_dialogue_setup_done");
}

function security_cam_01_post_intro_start() {
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
  var0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
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
  cctv_camera_look_speed(level.player, 1);
  thread securitycam_slow_look();
  thread scripts\sp\maps\embassy\embassy_util::focusflag();
  thread scene_bookcase();
  thread scene_table_beating();
  thread scene_room_beating();
  thread scene_wounded();
  thread scene_wall_kill();
  level notify("drag done");
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.15, 0.05);
}

function security_cam_01_post_intro_main() {}

function security_cam_01_post_intro_catchup() {
  scripts\engine\utility::flag_set("first_cam_change");
}

function security_cam_02_start() {
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
  var0 = scripts\engine\sp\utility::array_spawn_targetname("patrol_03", 1);
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
  cctv_camera_look_speed(level.player, 1);
  thread securitycam_slow_look();
  thread scripts\sp\maps\embassy\embassy_util::focusflag();
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

function security_cam_02_main() {
  thread camera_nav_obstacle();
  thread left_path_nav_obstacle();
  scripts\engine\utility::flag_wait("patrol_to_exit");
  thread cctv_part_3_fail_trig();
  thread distraction_structs();
  thread distraction_dialogue();
  var0 = getEnt("end_game_volume", "targetname");

  while(!level.stacy istouching(var0)) {
    waitframe();
  }

  scripts\engine\utility::flag_set("cctv_final_patrol_go");
  scripts\engine\utility::flag_wait("distraction_enabled");
  level.stacy scripts\engine\utility::set_movement_speed(140);
  scripts\engine\sp\utility::trigger_wait("ambo_exit_trigger_03", "targetname");
  level notify("nuke_nodes");

  if(scripts\engine\utility::flag("ambo_hot")) {
    level waittill("forever");
  }

  level.stacy waittill("goal");
  level.stacy.ignoreme = 1;
  scripts\engine\utility::flag_set("survivior_escapes");
  var1 = getEnt("rescue_trigger", "targetname");
  var2 = createnavbadplacebyent(var1, "axis");
  var3 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var3, &ally_nodes_interact_remove);
  thread camera_interacts_remover();
  level.stacy scripts\common\ai::magic_bullet_shield();
  thread escape_dialogue();
  level.player scripts\engine\utility::delaycall(0.6, &playsound, "emb_doorunlock_beep_2d");
  level.player scripts\engine\utility::delaycall(0.75, &playsound, "emb_doorunlock_clickandbuzz_2d");
  level.player scripts\engine\utility::delaycall(0.95, &playsound, "emb_cctv_027_end_door_open");
  level.stacy scripts\common\anim::anim_single_solo(level.stacy, "card_swipe");
  level.friendlies = scripts\engine\sp\utility::array_spawn_targetname("civ_rescuers", 1);
  level.stacy.swipe = 1;
  var4 = getEnt("exit_door", "targetname");
  var4 rotateYaw(-90, 1);
  wait 0.5;

  foreach(var6 in level.friendlies) {
    var6 scripts\engine\utility::set_movement_speed(120);
    var6 scripts\engine\sp\utility::set_ignoresuppression(1);
    var6.ignoreme = 0;
    var6 scripts\engine\sp\utility::set_maxfaceenemydist(2000);
    var6.ignoreall = 0;
    var6.attackeraccuracy = 0;
    var6 scripts\common\ai::magic_bullet_shield();
    var6 allowedstances("stand", "crouch");
    var6 getenemyinfo(level.exit_guard);
    var6 enableavoidance(0, 0);

    if(scripts\engine\utility::is_equal(var6.model, "body_hero_farah")) {
      var6.name = "Farah";
      continue;
    }

    var6.name = "Captain Price";
  }

  var8 = getEnt("ambo_exit_trigger_03", "targetname");
  var9 = getEnt("end_game_exit_volume", "targetname");
  level notify("get_her_out");
  wait 2;
  level notify("holy_shit");
  level.stacy setgoalvolumeauto(var9);
  wait 4;

  foreach(var6 in level.friendlies) {
    if(scripts\engine\utility::is_equal(var6.model, "body_hero_farah")) {
      var6 setgoalvolumeauto(var9);
    }
  }

  wait 1;
  level notify("get back");

  foreach(var6 in level.friendlies) {
    var6 setgoalvolumeauto(var9);
  }

  wait 3;
  level notify("we_got_her");
  wait 1;
  setomnvar("ui_cctv_active", 0);

  foreach(var15 in level.stacy_bad_places) {
    destroynavobstacle(var15);
  }

  cctv_camera_look_speed(level.player, 0);
  var17 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var17 fadeovertime(0.1);
  var17.alpha = 1;
  wait 1;
  level.player modifybasefov(65, 0.05);
  var18 = getaiarray("axis", "allies", "neutral");

  foreach(var6 in var18) {
    if(isDefined(var6.magic_bullet_shield)) {
      var6 scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  scripts\engine\utility::array_delete(var18);
  level.player lerpfovscalefactor(1, 0);
  level.player enableweapons();
  level.player showlegsandshadow();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player.ignoreme = 0;
  level.player unlink();
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, 1);
  scripts\engine\utility::flag_set("cctv_end");
  destroynavobstacle(var2);

  foreach(var22 in level.distraction_icons) {
    if(isDefined(var22)) {
      setheadiconimage(var22);
    }
  }

  visionsetnaked("", 0);
  thread fade_up(var17);
}

function fade_up(var0) {
  wait 0.25;
  var0 fadeovertime(0.1);
  var0.alpha = 0;
}

function camera_nav_obstacle() {
  var0 = spawnStruct();
  var0.origin = (-6011, -1797, -700);
  var1 = createnavbadplacebybounds(var0.origin, (25, 25, 100), (0, 0, 0));
  scripts\engine\utility::flag_wait("cctv_end");
  destroynavobstacle(var1);
}

function left_path_nav_obstacle() {
  level endon("cctv_end");
  level.stacy endon("death");
  var0 = getEnt("left_path_trigger", "targetname");
  var0.vol = var0 scripts\engine\utility::get_target_ent();

  for(;;) {
    scripts\engine\sp\utility::trigger_wait_targetname("left_path_trigger");
    var1 = createnavbadplacebyent(var0.vol, "allies", "neutral");

    while(level.stacy istouching(var0)) {
      waitframe();
    }

    wait 1;
    destroynavobstacle(var1);
  }
}

function left_path_avoidance() {}

function cctv_part_3_fail_trig() {
  scripts\engine\sp\utility::trigger_wait_targetname("cctv_part_3_fail_trig");
  scripts\engine\utility::flag_set("ambo_hot");
  var0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var0, &enemy_engages_ambo);
}

function distraction_dialogue() {
  level endon("ambo_hot");
  scripts\engine\utility::flag_wait("exit_dialogue");
  level.stacy notify("stop_nags");
  level.has_said_cam_switch = 1;
  var0 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var0, &ally_nodes_interact_remove);
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_kyle_cctv_02_exit_100", 1, 2);
  level.stacy thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_stac_cctv_02_exit_130", 1);
  wait 0.55;
  thread ally_nodes_init();
}

function escape_dialogue() {
  level endon("ambo_hot");
  setmusicstate("");
  level.has_said_cam_switch = 1;
  level.stacy notify("stop_nags");
  level waittill("get_her_out");
  level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_escape_garage_10");
  level waittill("holy_shit");
  level.player scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_stac_escape_garage_20");
  level thread scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_cctv_02_exit_190", 1);
  level waittill("we_got_her");
  level scripts\sp\maps\embassy\embassy_util::say_as_chatter("dx_vom_pri_cctv_02_exit_200");
  level.cctv_vo = undefined;
}

function distraction_structs() {
  level.distraction_icons = [];
  var0 = getEntArray("distraction_triggers", "targetname");
  scripts\engine\utility::array_thread(var0, &distraction_triggers_logic);
}

function distraction_triggers_logic() {
  self endon("walked_away");
  self.struct = scripts\engine\utility::get_target_ent();
  var0 = scripts\engine\utility::spawn_tag_origin(self.struct.origin, self.struct.angles);
  var1 = &"EMBASSY/CCTV_POWER";
  var2 = 800;
  var3 = 800;
  var4 = "icon_electronic_interact";
  self.fx_struct = scripts\engine\utility::get_target_ent();
  thread distraction_fx();
  var5 = deleteheadicon(var0);
  setheadiconfriendlyimage(var5, "icon_electronic_interact");
  setheadiconzoffset(var5, 1);
  setheadiconsnaptoedges(var5, 500);
  setheadiconmaxdistance(var5, 1);
  addclienttoheadiconmask(var5, -20);
  level.distraction_icons[level.distraction_icons.size] = var5;
  self waittill("trigger");
  level.distraction_icons = scripts\engine\utility::array_remove(level.distraction_icons, var5);
  setheadiconimage(var5);
  thread remove_distraction_interact();
  thread remove_distraction_interact_on_end();
  self.struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, -20), var1, 70, var2, var3, 1, 0, 0, var4, "duration_none", undefined, undefined, 50);
  self.struct waittill("trigger");

  if(scripts\engine\utility::is_equal(self.struct.targetname, "shredder")) {
    var6 = getEnt("stacy_nav_blockers_end", "targetname");
    createnavbadplacebyent(var6, "allies", "neutral");
  }

  level notify("reset_stacy_nag_delay");
  level.player thread scripts\sp\maps\embassy\embassy_util::say_as_chatter(level.cctv_vo.use_distraction scripts\engine\sp\utility::deck_draw(), 1);
  wait 0.65;
  wait 0.1;
  scripts\engine\utility::flag_set("distraction_enabled");
  scripts\engine\utility::flag_set("exit_distraction");
}

function icon_death_watcher(var0) {
  level endon("cctv_end");
  level.stacy waittill("death");
  wait 0.1;

  if(isDefined(var0)) {
    setheadiconimage(var0);
    return;
  }
}

function distraction_fx() {
  var0 = scripts\engine\utility::getStruct("distraction_shredder_struct", "targetname");
  var1 = scripts\engine\utility::getStruct("distraction_printer_struct", "targetname");

  if(scripts\engine\utility::is_equal(self.fx_struct.targetname, "shredder")) {
    self.fx_tag = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
    playFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper"), self.fx_tag, "tag_origin");
    self.struct waittill("trigger");
    stopFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper"), self.fx_tag, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_un_office_paper_shredder_01_paper_shreding"), self.fx_tag, "tag_origin");
    level.player playSound("emb_cctv_shredder_activate");
  } else if(scripts\engine\utility::is_equal(self.fx_struct.targetname, "copier_01")) {
    self.fx_tag = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
    self.struct waittill("trigger");
    playFXOnTag(scripts\engine\utility::getfx("vfx_copier_scan"), self.fx_tag, "tag_origin");
    level.player playSound("emb_cctv_copier_activate");
  }

  scripts\engine\utility::flag_wait("cctv_end");
  self.fx_tag delete();
}

function remove_distraction_interact() {
  level.stacy endon("death");
  level endon("distraction_enabled");

  while(level.stacy istouching(self)) {
    waitframe();
  }

  self notify("walked_away");
  waitframe();
  self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread distraction_triggers_logic();
}

function remove_distraction_interact_on_end() {
  scripts\engine\utility::flag_wait("distraction_enabled");
  self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function security_cam_02_catchup() {
  scripts\engine\utility::flag_set("first_cam_change");
}

function start_point_vision_set() {
  wait 0.2;
  visionsetnaked("embassy_cctv_01", 0);
}

function aq_chatter() {}

function tense_music() {}

function stacy_spawn() {
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

function stacy_movement_watcher() {
  level endon("heroes_at_exit");
  thread stacy_idle_watcher();

  while(!scripts\engine\utility::flag("cctv_end")) {
    level.stacy scripts\engine\utility::waittill_any("cctv_exit", "cctv_exit_cover_left", "cctv_exit_cover_right", "goal_changed");
    level.stacy.moving = 1;
    level.phone_sfx = spawn("script_origin", level.stacy.origin);
    level.phone_sfx linkTo(level.stacy);
    level.phone_sfx thread scripts\engine\sp\utility::sound_fade_in("emb_cctv_mvmt_cell_handling_lp", 1, 1.1, 1);
    level.stacy waittill("goal");
    level.stacy.moving = 0;
    wait 0.3;
    level.phone_sfx thread scripts\engine\sp\utility::sound_fade_and_delete(0.5, 1);
  }
}

function stacy_idle_watcher() {
  level endon("heroes_at_exit");
  scripts\engine\utility::flag_wait("ambo_keycard_retreieved");
  level.scripted_stacy_idle = 0;

  while(!scripts\engine\utility::flag("cctv_end")) {
    if(isDefined(level.stacy) && !level.stacy.moving && !level.scripted_stacy_idle) {
      level.phone_sfx_idle = spawn("script_origin", level.stacy.origin);
      level.phone_sfx_idle linkTo(level.stacy);
      level.phone_sfx_idle thread scripts\engine\sp\utility::sound_fade_in("emb_cctv_mvmt_cell_handling_lp_idle", 1, 1.1, 1);

      while(isDefined(level.stacy) && isDefined(level.stacy.moving) && !level.stacy.moving) {
        waitframe();
      }

      wait 0.3;
      level.phone_sfx_idle thread scripts\engine\sp\utility::sound_fade_and_delete(0.5, 1);
    }

    waitframe();
  }
}

function ambo_badplaces() {
  level.stacy_bad_places = [];
  var0 = scripts\engine\utility::getStructArray("nav_excluser_struct", "targetname");

  foreach(var2 in var0) {
    level.stacy_bad_places[level.stacy_bad_places.size] = createnavbadplacebybounds(var2.origin, (10, 40, 20), (0, 0, 0), "allies");
  }
}

function ambo_anim_hack() {
  wait 1;
  level.stacy.animname = "survivor";
}

function focus_ambo_finder() {
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  scripts\engine\sp\utility::hudoutline_add_channel("cctv", 100, &hudoutline_cctv_settings);
  level.stacy endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_any("cam_switch", "player_pushed_focus");
    wait 0.1;
    wait 0.1;
  }
}

function outline_ping() {
  level.stacy scripts\engine\sp\utility::hudoutline_disable("cctv");
  setsaveddvar("NSNOLMTLLL", "1 1 1 1");
  level endon("player_pushed_focus");
  level endon("cam_switch");
  level.stacy scripts\engine\sp\utility::hudoutline_enable_new("outline_nodepth_red", "cctv");
  var0 = 1;
  var1 = 1;
  wait 2;
  var2 = 0.05;
  var3 = int(var1 / var2);

  while(var3) {
    setsaveddvar("NSNOLMTLLL", "1 1 1 " + scripts\engine\utility::string(var0));
    var0 -= var2;
    var3--;
    wait var2;
  }

  level.stacy scripts\engine\sp\utility::hudoutline_disable("cctv");
  setsaveddvar("NSNOLMTLLL", "1 1 1 0");
}

function cctv_save_points() {
  level endon("ambo_hot");

  if(!scripts\engine\utility::flag("save_part_2_start")) {
    scripts\engine\utility::flag_wait("save_office_exit");
    scripts\engine\sp\utility::autosave_now();
    scripts\engine\utility::flag_wait("save_library");
    scripts\engine\sp\utility::autosave_now();
    scripts\engine\utility::flag_wait_any("save_library_desk", "save_part_2_start");

    while(level.stacy.moving) {
      waitframe();
    }

    if(!scripts\engine\utility::flag("hallway_patrol_01")) {
      scripts\engine\sp\utility::autosave_now();
    }

    if(!scripts\engine\utility::flag("save_part_2_start")) {
      scripts\engine\utility::flag_wait("save_part_2_start");
      scripts\engine\sp\utility::autosave_now();
    }
  }

  scripts\engine\utility::flag_wait_any("save_cubicles", "rescue_allowed");

  if(getdvarint("scr_emb_cctv_caught", 1)) {
    var0 = getaiarray("axis");
    scripts\engine\utility::array_thread(var0, &enemy_engages_ambo);
    return;
  }

  if(scripts\engine\utility::flag("save_cubicles")) {
    scripts\engine\sp\utility::autosave_now();
  }

  scripts\engine\utility::flag_wait_any("exit_dialogue", "rescue_allowed");

  if(scripts\engine\utility::flag("exit_dialogue")) {
    scripts\engine\sp\utility::autosave_now();
  }

  scripts\engine\utility::flag_wait("rescue_allowed");
}

function hudoutline_cctv_settings() {
  var0 = [];
  GscBinSkip0(0x2e, "MKOQSSQKLL", 1.8);
}

function kitchen_enter_init() {
  var0 = getEnt("kitchen_door", "targetname");
  var0.clip = var0 scripts\engine\utility::get_target_ent();
  var0.clip linkTo(var0);
  var0.clip connectpaths();
  thread kitchen_door_disconnect_paths();
  scripts\engine\sp\utility::trigger_wait("kitchen_door_trig", "targetname");
  var0 rotateYaw(-90, 0.5);
  wait 0.5;
  var0 rotateYaw(90, 1.5);
  var0.clip disconnectPaths();
}

function kitchen_door_disconnect_paths() {
  scripts\engine\utility::flag_wait("rescue_allowed");
  self.clip disconnectPaths();
}

function ally_nodes_init() {
  var0 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var0, &ally_nodes_interact);
}

function ally_nodes_interact() {
  var0 = 2;
  var1 = 525;
  var2 = 525;
  var3 = 15;
  var4 = 40;
  var5 = 50;

  if(isDefined(self.script_parameters)) {
    var3 = int(self.script_parameters);
  }

  var6 = undefined;
  var7 = "";
  var8 = "+attack";

  if(scripts\engine\utility::is_equal(self.script_namenumber, "exit")) {
    var0 = 40;
    var1 = 800;
    var7 = &"EMBASSY/CCTV_DOOR";
    level.exit_node = self;
  }

  if(scripts\engine\utility::is_equal(self.script_namenumber, "hallway")) {
    var1 = 700;
  }

  if(scripts\engine\utility::is_equal(self.script_namenumber, "door")) {
    var1 = 400;
    var2 = 400;
  }

  level endon("nuke_nodes");
  self endon("cctv_end");
  level.stacy endon("death");
  var9 = scripts\engine\utility::getStruct("floor_03_struct", "targetname");
  self.struct = spawnStruct();
  self.struct.origin = (self.origin[0], self.origin[1], var9.origin[2] + var0);
  self.struct.angles = self.angles;
  self.struct.radius = 64;
  self.alt_node = undefined;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy != "ambo_office") {
    scripts\engine\utility::flag_wait("ambo_office_open");
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ambo_office") {
    var4 = 90;
  }

  if(isDefined(self.script_namenumber) && self.script_namenumber == "corner_2") {
    while(!isDefined(level.camera_number)) {
      waitframe();
    }

    while(level.camera_number != 10) {
      waitframe();
    }

    var1 = 400;
    var2 = 400;
  }

  jumpiffalse(isDefined(self.script_namenumber) && self.script_namenumber == "cubicle_4_inside") LOC_000001af;
  var3 = 20;

  for(;;) {
    if(scripts\engine\utility::flag("final_patrol_go_1")) {
      scripts\engine\utility::flag_waitopen("final_patrol_go_1");
    }

    self.struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, var3), var7, var4, var2, var1, 0, 0, 0, var6, "duration_none", var8, undefined, var5);
    self.struct waittill("trigger");
    level.player playSound("emb_cctv_ui_move_select");
    level endon("final_patrol_go_1");
    level.stacy scripts\engine\sp\utility::set_goal_radius(20);
    level.stacy notify("ambo_stop_loop");

    if(!scripts\engine\utility::flag("chair_pushed")) {
      scripts\engine\utility::flag_set("chair_pushed");
    }

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

    if(scripts\engine\utility::flag("ambo_seated")) {
      scripts\engine\utility::flag_waitopen("ambo_seated");
    }

    if(scripts\engine\utility::flag("stacy_animating")) {
      scripts\engine\utility::flag_waitopen("stacy_animating");
    }

    var10 = self;

    if(scripts\engine\utility::is_equal(self.script_namenumber, "kitchen")) {
      var10 = getnode("kitchen_node", "script_noteworthy");
    }

    var11 = distance(level.stacy.origin, var10.origin);

    if((!scripts\engine\utility::flag("ambo_hot") || scripts\engine\utility::flag("survivior_escapes")) && var11 < 1000) {
      level.stacy scripts\engine\sp\utility::set_goal_radius(5);

      if(scripts\engine\utility::flag("survivior_escapes")) {
        level.stacy allowedstances("stand");
        level.stacy scripts\common\utility::demeanor_override("sprint");
      }

      if(!scripts\engine\utility::flag("distraction_enabled")) {
        wait 0.5;
      }

      level.stacy.previous_node = level.stacy.goalnode;
      level.stacy setgoalnode(var10);
    }

    level.stacy.anim_struct = self.struct;

    if(scripts\engine\utility::flag("final_patrol_go_1")) {
      break;
    }

    if(var11 < 1000) {
      level.stacy waittill("new_position");
    }

    if(var11 > 1000) {
      wait 1;

      if(!isDefined(level.cctv_vo)) {
        level.cctv_vo = spawnStruct();
      }

      if(!isDefined(level.cctv_vo.too_far)) {
        var12 = ["dx_vom_stac_cctv_02_fastpass_20", "dx_vom_stac_cctv_02_fastpass_30"];
        level.cctv_vo.too_far = scripts\engine\sp\utility::create_deck(var12);
      }

      level.stacy scripts\sp\maps\embassy\embassy_util::say_as_chatter(level.cctv_vo.too_far scripts\engine\sp\utility::deck_draw(), 1, 1);
    }

    wait 3;
  }
}

function ally_nodes_interact_remove() {
  if(isDefined(self.struct)) {
    self.struct scripts\sp\player\cursor_hint::remove_cursor_hint();
    return;
  }
}

function chair_rotate() {
  var0 = getEnt("push_chair", "targetname");
  var0 rotateYaw(-40, 1, 0, 0.25);
  wait 1;
  var0 rotateYaw(-20, 1, 0, 0.25);
}

function ally_nodes_interact_recall() {
  level.stacy waittill("new_position");
  wait 0.25;
  thread ally_nodes_interact();
}

function camera_controller_init() {
  thread vision_set_init();
  level.player disableweapons();
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player.ignoreme = 1;
  var0 = spawnStruct();
  var1 = getEnt("cam_01", "script_noteworthy");
  var1.angles = (180, 0, 0);
  var0.origin = (-6968, -383, -530);
  var0.angles = (30, 51, 0);
  var0 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var1.origin = (var0.origin[0], var0.origin[1], -463);
  var0.mod = var1;
  var0.test = [30, 51, 0];
  var2 = spawnStruct();
  var3 = getEnt("cam_02", "script_noteworthy");
  var2.origin = (-6988, -43, -530);
  var2.angles = (35, 322, 0);
  var2 = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
  var3.origin = (var2.origin[0], var2.origin[1], -463);
  var3.angles = (180, var2.angles[1] + 20, 0);
  var2.mod = var3;
  var4 = spawnStruct();
  var5 = getEnt("cam_03", "script_noteworthy");
  var4.origin = (-6310, -53, -530);
  var4.angles = (28, 186, 0);
  var4 = scripts\engine\utility::spawn_tag_origin(var4.origin, var4.angles);
  var5.origin = (var4.origin[0], var4.origin[1], -463);
  var5.angles = (180, var4.angles[1], 0);
  var4.mod = var5;
  var4.wall_kill_reveal = 1;
  var6 = spawnStruct();
  var7 = getEnt("cam_04", "script_noteworthy");
  var6.origin = (-6000, -500, -530);
  var6.offset = (-5080, -500, -530);
  var6.angles = (34, 134, 0);
  var6 = scripts\engine\utility::spawn_tag_origin(var6.origin, var6.angles);
  var7.origin = (var6.origin[0], var6.origin[1], -463);
  var7.angles = (180, 0, 0);
  var6.mod = var7;
  var6.crawl_node_reveal = 1;
  var8 = spawnStruct();
  var9 = getEnt("cam_12", "script_noteworthy");
  var8.origin = (-6038, -772, -530);
  var8.angles = (36, 100, 0);
  var8 = scripts\engine\utility::spawn_tag_origin(var8.origin, var8.angles);
  var9.origin = (var8.origin[0], var8.origin[1], -463);
  var9.angles = (180, 0, 0);
  var8.mod = var9;
  var10 = spawnStruct();
  var11 = getEnt("cam_05", "script_noteworthy");
  var10.origin = (-7050, -940, -530);
  var10.angles = (31, -4, 0);
  var10 = scripts\engine\utility::spawn_tag_origin(var10.origin, var10.angles);
  var11.origin = (var10.origin[0], var10.origin[1], -463);
  var11.angles = (180, 0, 0);
  var10.mod = var11;
  var12 = spawnStruct();
  var12.origin = (-7058, -1490, -530);
  var12.angles = (24, 55.8, 0);
  var12 = scripts\engine\utility::spawn_tag_origin(var12.origin, var12.angles);
  var13 = getEnt("cam_06", "script_noteworthy");
  var13.origin = (var12.origin[0], var12.origin[1], -463);
  var13.angles = (180, 0, 0);
  var12.mod = var13;
  var14 = spawnStruct();
  var14.origin = (-6472, -1285, -530);
  var14.angles = (30, -115, 0);
  var14 = scripts\engine\utility::spawn_tag_origin(var14.origin, var14.angles);
  var15 = getEnt("cam_08", "script_noteworthy");
  var15.origin = (var14.origin[0], var14.origin[1], -463);
  var15.angles = (180, 0, 0);
  var14.mod = var15;
  var16 = spawnStruct();
  var16.origin = (-6002, -1320, -530);
  var16.angles = (34, -132, 0);
  var16 = scripts\engine\utility::spawn_tag_origin(var16.origin, var16.angles);
  var17 = getEnt("cam_09", "script_noteworthy");
  var17.origin = (var16.origin[0], var16.origin[1], -463);
  var17.angles = (180, 0, 0);
  var16.mod = var17;
  var18 = spawnStruct();
  var18.origin = (-6011, -1777, -530);
  var18.angles = (30, -105, 0);
  var18 = scripts\engine\utility::spawn_tag_origin(var18.origin, var18.angles);
  var19 = getEnt("cam_10", "script_noteworthy");
  var19.origin = (var18.origin[0], var18.origin[1], -463);
  var19.angles = (180, 0, 0);
  var18.mod = var19;
  var20 = spawnStruct();
  var20.origin = (-6446, -995, -530);
  var20.angles = (30, 50, 0);
  var20 = scripts\engine\utility::spawn_tag_origin(var20.origin, var20.angles);
  var21 = getEnt("cam_11", "script_noteworthy");
  var21.origin = (var20.origin[0], var20.origin[1], -463);
  var21.angles = (180, 0, 0);
  var20.mod = var21;
  level.cams = [var0, var2, var4, var6, var8, var10, var12, var14, var16, var18, var20];
  level.active_feed = level.cams;
  level.player modifybasefov(90, 0.05);
  level.previous_cam = level.cams[0];
  level.previous_cam.mod hide();

  if(scripts\engine\utility::flag("ambo_office_open")) {
    level.previous_cam = level.cams[2];
  }

  if(scripts\engine\utility::flag("save_part_2_start")) {
    level.previous_cam = level.cams[5];
  }

  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", 0);
}

function vision_set_init() {
  wait 0.5;
  visionsetnaked("embassy_cctv_01", 0.25);
}

function change_camera() {
  scripts\engine\utility::flag_set("first_cam_change");
  level notify("cam_switch");
  dialogue_cam_change();
  scripts\engine\utility::flag_clear("player_pushed_focus");
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(0.05);
  var0.alpha = 1;
  level.player setclientomnvar("ui_hide_hud", 1);
  wait 0.2;

  foreach(var2 in level.cams) {
    if(var2 == self) {
      level.camera_number = var3;
    }
  }

  setomnvar("ui_cctv_camera_index", level.camera_number);
  level.previous_cam.last_angles = level.player getplayerangles();
  self.mod hide();
  level.previous_cam.mod show();
  level.player unlink();
  level.player dontinterpolate();
  level.player setOrigin(self.origin);
  level.player playerlinktodelta(self, "tag_origin", 1, 360, 360, 40, 50, 0);
  thread cctv_camera_look_speed(level.player);

  if(isDefined(self.last_angles)) {
    level.player setplayerangles(self.last_angles);
  } else {
    level.player setplayerangles((self.angles[0], self.angles[1], 0));
  }

  level.player modifybasefov(90, 0.05);
  wait 0.05;
  var0 fadeovertime(0.1);
  var0.alpha = 0;
  waitframe();
  level.previous_cam = self;
  wait 0.1;
  level.player setclientomnvar("ui_hide_hud", 0);

  if(!scripts\engine\utility::flag("desk_reveal")) {
    foreach(var2 in level.cams) {
      if(var2 == self && scripts\engine\utility::is_equal(self.wall_kill_reveal, 1)) {
        scripts\engine\utility::flag_set("desk_reveal");
      }
    }
  }

  level notify("finished_cam_switch", level.camera_number);
}

function player_input_watcher() {
  level.player endon("death");

  for(;;) {
    thread player_camera_moving_logic();
    wait 0.05;
  }
}

function player_camera_moving_logic() {
  var0 = level.player getnormalizedcameramovement();
  var1 = level.player getnormalizedmovement();
  cam_angle_change(var0);
}

function cam_angle_change(var0) {
  var1 = 0;
  var2 = 0;
  var3 = 0.1;
}

function camera_interacts_init() {
  var0 = getEntArray("security_cam", "targetname");
  scripts\engine\utility::array_thread(level.cams, &camera_interacts_watcher);
}

function camera_interacts_remover() {
  scripts\engine\utility::array_thread(level.cams, &camera_interacts_remove);
}

function camera_interacts_watcher() {
  var0 = 1500;
  level endon("survivior_escapes");
  level endon("ambo_hot");

  for(;;) {
    if(!scripts\engine\utility::flag("start_cam")) {
      if(self == level.cams[3] && scripts\sp\starts::is_after_start("cctv_01")) {
        level.previous_cam = level.cams[3];
      }

      if(self == level.cams[5] && scripts\sp\starts::is_after_start("cctv_post_intro")) {
        level.previous_cam = level.cams[5];
      }

      level.previous_cam.mod hide();
      scripts\engine\utility::flag_set("start_cam");
      level waittill("cam_switch");
    }

    if(self == level.cams[10] || self == level.cams[9] || self == level.cams[8]) {
      var0 = 800;
    }

    self.icon = deleteheadicon(self.mod);
    setheadiconfriendlyimage(self.icon, "icon_camera_indicator");
    setheadiconzoffset(self.icon, 0);
    setheadiconsnaptoedges(self.icon, var0);
    setheadiconmaxdistance(self.icon, 300);
    addclienttoheadiconmask(self.icon, -30);
    var1 = "+weapnext";

    if(!level.player getlocalplayerprofiledata("gpadEnabled")) {
      var1 = "+activate";
    }

    thread mission_failed_icon_cleanup();
    self.mod scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 30), "", 40, 200, var0, 0, 0, 0, undefined, "duration_none", var1, undefined, 30);
    self.mod waittill("trigger");
    level.player playSound("emb_cctv_ui_camera_select");

    if(isDefined(self.icon)) {
      setheadiconimage(self.icon);
    }

    change_camera();
    level waittill("cam_switch");
    wait 1;
  }
}

function camera_interacts_remove() {
  if(isDefined(self.mod)) {
    self.mod scripts\sp\player\cursor_hint::remove_cursor_hint();
    return;
  }
}

function mission_failed_icon_cleanup() {
  self.mod endon("trigger");
  scripts\engine\utility::flag_wait("ambo_hot");

  if(isDefined(self.icon)) {
    setheadiconimage(self.icon);
    return;
  }
}

function cam_switcher(var0) {
  level notify("cctv_switching_cam");
  var1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var2 = undefined;
  var1 fadeovertime(0.05);
  var1.alpha = 1;
  wait 0.1;

  if(var0 == "switch_cam_forward") {
    var2 = level.active_cam_id + 1;

    if(var2 >= level.active_feed.size) {
      var2 = 0;
    }
  } else if(var0 == "switch_cam_backward") {
    var2 = level.active_cam_id - 1;

    if(var2 < 0) {
      var2 = level.active_feed.size - 1;
    }
  }

  level.active_feed[level.active_cam_id].last_angles = level.player getplayerangles();
  level.active_cam_id = var2;
  thread change_camera();
  var1 fadeovertime(0.1);
  var1.alpha = 0;
}

function cam_switcher_fade_out() {
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var1 = undefined;
  var0 fadeovertime(0.05);
  var0.alpha = 1;
  wait 0.5;
  self hide();
  wait 0.1;
  var0 fadeovertime(0.2);
  var0.alpha = 0;
}

function active_camera() {
  return level.active_feed[level.active_cam_id];
}

function camera_enemy_behavior() {
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

    if(scripts\engine\utility::is_equal(self.script_parameters, "patrol_end_04")) {
      self.fovcosine = 0.7;
    }

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

function ambo_caught_logic() {
  level endon("survivior_escapes");
  level endon("rescue_allowed");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "table_beating_enemy")) {
    return;
  }

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "table_beating_enemy")) {
    scripts\engine\sp\utility::trigger_wait_targetname("cctv_part_3_save_trig");
  }

  if(scripts\engine\utility::is_equal(self.targetname, "patrol_01")) {
    return;
  }

  var0 = getEnt("hiding_spot_chair", "targetname");
  var1 = getEnt("stacy_butcher_bad_zone", "targetname");

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
        var2 = distance(self.origin, level.stacy.origin);
        var3 = 600;
        var4 = 200;

        if(!scripts\engine\utility::flag("distraction_enabled")) {
          if(!level.stacy istouching(var1) && self.temp_ignore == 0 && self cansee(level.stacy) && var2 < var3 && !scripts\engine\utility::flag("game_saving_cctv") && !level.stacy istouching(var0)) {
            if(var2 < var4) {
              wait 0.25;
            } else {
              wait 0.5;
            }
          }
        }

        if(level.stacy istouching(var1)) {
          level.stacy.badzone = 1;
        }

        if(self.temp_ignore == 0 && self cansee(level.stacy) && var2 < var3 && !scripts\engine\utility::flag("game_saving_cctv") && !level.stacy istouching(var0)) {
          self.fovcosine = 0.001;
          level.stacy_spotted = 1;
          scripts\engine\utility::flag_set("ambo_hot");
          thread enemy_engages_ambo(1);
          var5 = getaiarray("axis");
          var5 = scripts\engine\utility::array_remove(var5, self);
          wait 1.9;
          scripts\engine\utility::array_thread(var5, &enemy_engages_ambo);
        }
      }
    }

    wait 0.1;
  }

  if(scripts\engine\utility::flag("survivior_escapes")) {
    return;
  }
}

function end_game_logic() {
  level.stacy endon("death");
  self endon("death");
  scripts\engine\utility::flag_wait("survivior_escapes");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "butcher")) {
    return;
  }

  while(!istrue(level.stacy.swipe)) {
    waitframe();
  }

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

  if(self == level.exit_guard) {
    scripts\engine\utility::set_movement_speed(100);
  }

  self setgoalentity(level.friendlies[0]);
}

function poke_out_guy_loop() {
  self endon("death");
  var0 = scripts\engine\utility::getanim("scavenge_idle_03");
  var1 = var0[0];
  var2 = getanimlength(var1);
  thread scripts\common\anim::anim_loop_solo(self, "scavenge_idle_03", "stop_poke_out_loop");
  waitframe();
  self setanimrate(var1, 0.9);
}

function scene_bookcase() {
  var0 = getEnt("butcher", "script_noteworthy");
  var0.animname = "aq_cctv_bookcase_01";
  var0.name = "^1The Butcher";
  var0.team = "axis";
  var0.callsign = "^1Jamal Rahar";
  var0.fovcosine = 0.99619;
  var0 setlookattext(var0.name, &"");
  var1 = getEnt("hostage_taker", "script_noteworthy");
  var1.animname = "aq_cctv_bookcase_02";
  var1.fovcosine = 0.8;
  var2 = scripts\engine\utility::getStruct("bookcase_beating", "targetname");
  var2.angles += (0, -90, 0);
  var3 = scripts\engine\sp\utility::spawn_targetname("bookcase_victim", 1);
  var3.animname = "bookcase_victim";
  var3.ignoreme = 1;
  var4 = [var0, var3, var1];
  thread bookcase_break_out(var3, var0);
  var2 thread scripts\common\anim::anim_loop_solo(var3, "bookcase_beating_idle_start", "stop_loop");
  var2 thread scripts\common\anim::anim_loop_solo(var1, "bookcase_beating_idle_start", "stop_loop");
  var2 thread scripts\common\anim::anim_loop_solo(var0, "bookcase_beating_idle_start", "stop_loop");
  scripts\engine\utility::flag_wait("first_cam_change");
  level waittill("cam_switch");
  waitframe();
  level waittill("cam_switch");
  wait 0.1;
  var2 notify("stop_loop");
  var2 thread scripts\common\anim::anim_loop_solo(var3, "bookcase_beating", "stop_loop");
  var2 thread scripts\common\anim::anim_loop_solo(var1, "bookcase_beating", "stop_loop");
  var2 thread scripts\common\anim::anim_loop_solo(var0, "bookcase_beating", "stop_loop");
  waitframe();
  var4 = [var3, var1, var0];
  scripts\engine\utility::array_thread(var4, &bookcase_beating_timing);
  thread dialogue_bookcase_scene(var0, var1, var3);
  scripts\engine\utility::flag_wait("survivior_escapes");
  var3 delete();
}

function bookcase_break_out(var0, var1) {
  level endon("cctv_end");
  level waittill("ambo_hot");
  var0.allowdeath = 1;
  var0.forceragdollimmediate = 1;
  var0 kill();
  var1 stopanimScripted();
}

function bookcase_beating_timing() {
  var0 = scripts\engine\utility::getanim("bookcase_beating");
  var1 = var0[0];
  self setanimtime(var1, 0.55);
}

function scene_glass_killer() {}

function bookcase_anim_speed() {
  var0 = scripts\engine\utility::getanim("bookcase_beating");
  var1 = var0[0];
  self setanimrate(var1, 1.1);
}

function scene_table_beating() {
  waitframe();
  var0 = getEnt("table_beating_enemy", "script_noteworthy");
  var0.animname = "aq_cctv";
  var1 = getspawner("table_beating_enemy", "script_noteworthy");
  var2 = spawnStruct();
  var2.origin = var1.origin;
  var2.angles = var1.angles;
  var0.fovcosine = 0.97;
  var2 thread scripts\common\anim::anim_loop_solo(var0, "est_search_desk_terry_idle", "stop_loop");
}

function scene_opening() {
  level endon("ambo_hot");
  var0 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 0);
  var1.angles = var0.angles;
  var1.angles += (0, 90, 0);
  var2 = getEnt("alley_drag", "script_noteworthy");
  var2.animname = "aq_cctv";
  var3 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var2 scripts\anim\shared::forceuseweapon(var3, "primary");
  var4 = getspawner("cctv_victim_alley_drag_ambo", "targetname");
  var5 = var4 scripts\engine\sp\utility::spawn_ai(1);
  var5.animname = "ambo";
  var5.team = "allies";
  var5.name = "Ambassador Harris";
  var5 scripts\common\ai::magic_bullet_shield();
  var5.ignoreme = 1;
  level.ambassador_rock = var5;
  var6 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("runner_01", "script_noteworthy"));
  var6.animname = "runner_01";
  var6 setModel("body_civ_embassy_office_worker_male_1_1");
  var7 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("runner_02", "script_noteworthy"));
  var7.animname = "runner_02";
  var7 setModel("body_civ_embassy_office_worker_female_2_1");
  var8 = [var6, var7];
  var1 thread scripts\common\anim::anim_first_frame(var8, "ambo_kill_scene");
  var9 = [var2, var5, var6, var7];
  var1 thread scripts\common\anim::anim_loop_solo(var5, "ambo_kill_scene_idle", "stop_loop");
  waitframe();
  var10 = cinematicgettimeinmsec() / 1000;
  var11 = var5 scripts\engine\utility::getanim("ambo_kill_scene_idle")[0];
  var12 = getanimlength(var11);
  var13 = var10 / var12;
  var14 = var13 - int(var13);
  var5 setanimtime(var11, var14);
  scripts\engine\utility::flag_wait("player_controls_enabled");
  var1 notify("stop_loop");
  var2 scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::smart_dialogue_generic, "dx_vom_aq1_cctv_02_caught_50");
  var1 thread scripts\common\anim::anim_single(var9, "ambo_kill_scene");
  thread ambo_last_frame(var1);
  var15 = [var2, var6, var7];
  thread break_glass();
  scripts\engine\utility::delaythread(5, &scripts\engine\utility::exploder, "cctv_blood_1");
  scripts\engine\utility::array_thread(var15, &opening_actors_to_idle, var1);
  scripts\engine\utility::flag_wait("first_cam_change");
  var16 = getEnt("hallway_killing_door", "targetname");
  var15 = [var2, var6, var7, var16];
  var16 scripts\engine\sp\utility::assign_animtree("cctv_hallway_door");
  var1.origin = var0.origin + (0, 0, 0);
  var1 thread scripts\common\anim::anim_single(var15, "hallway_kill_scene");
  scripts\engine\utility::delaythread(4, &scripts\engine\utility::exploder, "cctv_blood_2");
  scripts\engine\utility::delaythread(18, &scripts\engine\utility::exploder, "cctv_blood_3");
  scripts\engine\utility::flag_wait("survivior_escapes");
  var5 scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\utility::array_delete(var9);
}

function ambo_last_frame(var0) {
  var0 waittillmatch("single anim", "end");
  thread scripts\common\anim::anim_last_frame_solo(var0, "ambo_kill_scene");
  level.stacy waittill("new_position");
  thread scripts\common\anim::anim_single_solo(var0, "office_get_card");
  var0 waittillmatch("single anim", "end");
  scripts\common\anim::anim_last_frame_solo(var0, "office_get_card");
}

function break_glass() {
  wait 4.2;
  var0 = getglass("cctv_glass_window");
  destroyglass(var0);
  wait 0.3;
  scripts\engine\utility::exploder("cctv_glass_break");
  var0 = getglass("cctv_glass_door");
  destroyglass(var0);
}

function cctv_opening_scene_bink() {
  level endon("ambo_hot");
  var0 = scripts\engine\utility::getStruct("drag_scene_02", "targetname");
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 0);
  var1.angles = var0.angles;
  var1.angles += (0, 90, 0);
  var2 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("cctv_victim_alley_drag_ambo", "targetname"));
  var2 notsolid();
  var2.animname = "ambo";
  var3 = [var2];
  var1 thread scripts\common\anim::anim_loop_solo(var2, "ambo_kill_scene_idle");
}

function opening_actors_to_idle(var0) {
  self waittillmatch("single anim", "end");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "alley_drag")) {
    scripts\engine\utility::flag_wait("first_cam_change");
    self setgoalpos(self.origin);
  }

  var0 thread scripts\common\anim::anim_first_frame_solo(self, "hallway_kill_scene");
}

function scene_room_beating() {
  level endon("ambo_hot");
  var0 = undefined;
  var1 = getEntArray("room_beating", "script_noteworthy");

  foreach(var3 in var1) {
    if(var3.targetname == "patrol_03") {
      var0 = var3;
    }
  }

  thread room_beating_patrol_bp();
  var0.animname = "aq_cctv";
  var0 endon("death");
  var5 = scripts\engine\utility::getStruct("rummage_struct_desk_05", "targetname");
  var6 = scripts\engine\utility::getStruct("room_beating_scene_02", "targetname");
  var7 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("cctv_victim_room_beating_civ", "targetname"));
  var7.animname = "cctv_victim";
  var7 notsolid();
  var1 = [var0, var7];
  var6 thread scripts\common\anim::anim_first_frame(var1, "room_beating_scene");
  var0.temp_ignore = 1;
  camera_and_flag_watcher();

  if(scripts\engine\utility::flag("final_patrol_go_1")) {
    wait 1;
  }

  wait 0.25;
  var6 thread scripts\common\anim::anim_single(var1, "room_beating_scene");
  var0 waittillmatch("single anim", "end");
  level.exit_guard = var0;
  var0 enableavoidance(0, 0);
  var0 scripts\engine\sp\utility::set_goal_radius(20);
  var0 scripts\common\utility::demeanor_override("alert");
  var8 = var0 scripts\engine\utility::get_target_ent();
  var0 setgoalnode(var8);
  var0.temp_ignore = 0;
  scripts\engine\utility::flag_wait("patrol_to_exit");
  var0.target = undefined;
  var0 notify("reached_path_end");
  var9 = getnodearray("exit_guard_node", "targetname");
  var9 = sortbydistance(var9, var0.origin);
  var0 thread scripts\sp\spawner::go_to_node(var9[0]);
  var0 setgoalnode(var9[0]);
  waitframe();
  var0 waittill("goal");
  var0 scripts\common\utility::demeanor_override("patrol");
  scripts\engine\utility::flag_wait("distraction_enabled");
  wait 0.5;
  var0.fovcosine = 0.4;
  var0 scripts\common\utility::demeanor_override("combat");
  var0 scripts\engine\sp\utility::set_goal_radius(10);
  var0 scripts\engine\utility::set_movement_speed(80);
  var0 clearpath();
  var10 = getnodearray("investigate_node", "targetname");
  var10 = sortbydistance(var10, level.stacy.origin);
  var0 setgoalnode(var10[0]);
  var0 waittill("goal");
  thread stacy_distance_watcher();
  var0.allowdeath = 1;
  var0 thread scripts\common\anim::anim_single_solo(var0, "lookaround_05");
  thread distracted_breakout();
  wait 10;
  var0 setgoalpos(level.stacy.origin);
}

function room_beating_patrol_bp() {
  level endon("patrol_to_exit");
  scripts\engine\utility::flag_wait("final_patrol_go_1");
  var0 = getEnt("left_path_trigger", "targetname");
  var1 = var0 scripts\engine\utility::get_target_ent();
  var2 = getEnt("end_game_volume", "targetname");
  var3 = 0;
  var4 = undefined;

  for(;;) {
    var5 = self.angles[1];

    if(self istouching(var2) && self.origin[1] > -1900 && self.angles[1] < 120 || self.angles[1] > 120 && self.origin[1] > -1600) {
      if(!var3) {
        var4 = createnavobstaclebyent(var1, "allies", "neutral");
        var3 = 1;
      }
    } else if(var3) {
      destroynavobstacle(var4);
      var3 = 0;
    }

    wait 0.2;
  }
}

function camera_and_flag_watcher() {
  level endon("final_patrol_go_1");

  while(!isDefined(level.camera_number)) {
    waitframe();
  }

  while(level.camera_number != 7) {
    waitframe();
  }
}

function distracted_breakout() {
  self endon("death");
  scripts\engine\utility::flag_wait("survivior_escapes");
  self.ignoreall = 0;

  while(!istrue(level.stacy.swipe)) {
    waitframe();
  }

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

  if(self == level.exit_guard) {
    scripts\engine\utility::set_movement_speed(100);
  }

  self setgoalentity(level.friendlies[0]);
}

function stacy_distance_watcher() {
  level endon("cctv_end");
  level endon("survivior_escapes");
  level.stacy endon("death");

  while(50 < distance(self.origin, level.stacy.origin)) {
    waitframe();
  }

  scripts\engine\utility::flag_set("ambo_hot");
  thread enemy_engages_ambo(1);
}

function scene_wounded() {
  if(getdvarint("scr_emb_cctv_caught", 1)) {
    iprintln("ignored");
    return;
  }

  var0 = scripts\engine\utility::getStruct("cctv_wounded_struct", "targetname");
  var0.origin += (0, 0, -3);
  var1 = getspawner("bookcase_victim", "targetname");
  var1.count = 2;
  var2 = undefined;
  var3 = getaiarray("axis");

  foreach(var5 in var3) {
    if(scripts\engine\utility::is_equal(var5.script_parameters, "patrol_end_01")) {
      var2 = var5;
    }
  }

  var7 = var2 scripts\engine\utility::get_target_ent();
  var2.lastnode = var7 scripts\engine\sp\utility::get_last_ent_in_chain("pathnode");
  var8 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var2 scripts\anim\shared::forceuseweapon(var8, "primary");
  var2 clearpath();
  var2.animname = "aq_cctv";
  var9 = var2 scripts\engine\utility::getanim("wounded_start");
  var10 = getstartorigin(var0.origin, var0.angles, var9);
  var11 = getstartangles(var0.origin, var0.angles, var9);
  var2 forceteleport(var10, var11);
  waitframe();
  var2 stopanimScripted();
  var2 setgoalpos(var2.origin);
  var12 = scripts\engine\sp\utility::bodyonlyspawn(getspawner("wounded_victim", "targetname"));
  var12.targetname = "wounded_victim";
  var12.animname = "wounded_victim";
  var12.ignoreme = 1;
  var0 thread scripts\common\anim::anim_loop_solo(var12, "wounded_start_idle", "stop_loop");
  var13 = [var2, var12, level.stacy];
  scripts\engine\utility::flag_wait("final_patrol_go_1");
  level.scripted_stacy_idle = 1;
  thread dialogue_wounded_scene();
  var14 = getnodearray("ally_nodes", "targetname");
  scripts\engine\utility::array_thread(var14, &ally_nodes_interact_remove);
  var0 scripts\sp\anim::anim_reach_solo(level.stacy, "wounded_start");
  var0 notify("stop_loop");
  var0 thread scripts\common\anim::anim_single(var13, "wounded_start");
  thread wounded_aq_to_patrol();
  scripts\engine\utility::delaythread(13, &scripts\engine\utility::exploder, "cctv_blood_6");
  level.stacy waittillmatch("single anim", "end");
  level.stacy scripts\engine\sp\utility::set_goal_pos(level.stacy.origin);
  level.stacy clearpath();
  var0 thread scripts\common\anim::anim_loop_solo(level.stacy, "wounded_end_idle", "stop_loop");
  scripts\engine\utility::flag_clear("final_patrol_go_1");
  var12 notsolid();
  level waittill("wounded_dialogue_auto_save");
  scripts\engine\sp\utility::autosave_by_name("wounded_complete");
  level waittill("wounded_dialogue_finished");
  thread ally_nodes_init();
  level.scripted_stacy_idle = 0;
  level.stacy waittill("new_position");
  var0 notify("stop_loop");
  level.stacy thread scripts\common\anim::anim_single_solo(level.stacy, "wounded_exit");
  wait 1.2;
  level.stacy stopanimScripted();
}

function wounded_aq_to_patrol() {
  self waittillmatch("single anim", "end");
  self notify("stop_going_to_node");
  self setgoalpos((-6830, -948, -592));
  scripts\common\utility::demeanor_override("patrol");
}

function scene_wall_kill() {
  var0 = getEnt("wall_killer", "script_noteworthy");
  var0.animname = "aq_cctv";
  var1 = getnode("final_patrol_node", "targetname");
  var0 scripts\common\utility::demeanor_override("alert");
  var0 scripts\engine\utility::set_movement_speed(150);
  var0 forceteleport(var1.origin, var1.angles);
  var0 setgoalpos(var0.origin);
  var0 scripts\engine\sp\utility::set_goal_radius(50);
  var1 = getnode("final_patrol_node", "targetname");
  var0 scripts\sp\spawner::go_to_node(var1);
  var0 setgoalnode(var1);
  var0 enableavoidance(0, 0);
  var0 scripts\engine\sp\utility::disable_surprise();
}

function temporary_ignore(var0) {
  wait var0;
  self.temp_ignore = 1;
}

function patrol_one_go() {
  var0 = getEnt("beatdown_trigger", "targetname");
  var0 scripts\engine\utility::waittill_any_timeout(5, "trigger");
}

function enemy_engages_ambo(var0) {
  level.stacy endon("death");

  if(level.stacy.badzone) {
    if(scripts\engine\utility::is_equal(self.script_noteworthy, "butcher") || scripts\engine\utility::is_equal(self.script_noteworthy, "hostage_taker")) {
      return;
    }
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

  if(isalive(level.stacy)) {
    self getenemyinfo(level.stacy);
  }

  scripts\common\utility::demeanor_override("combat");
  self cleargoalvolume();
  self clearpath();
  self stopanimScripted();

  if(level.stacy.badzone) {
    level notify("badzone");
  }

  var1 = ["dx_vom_aq1_cctv_02_caught_20", "dx_vom_aq1_cctv_02_caught_30", "dx_vom_aq1_cctv_02_caught_40", "dx_vom_aq1_cctv_02_caught_50"];

  if(isDefined(var0)) {
    thread scripts\engine\sp\utility::smart_dialogue_generic(scripts\engine\utility::random(var1));
  }

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
    return;
  }
}

function stacy_bad_zone_attack() {
  level endon("cctv_end");
  level waittill("badzone");
  level.stacy.ignoreme = 0;
  wait 0.1;
  var0 = [];
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "butcher") || scripts\engine\utility::is_equal(var3.script_noteworthy, "hostage_taker")) {
      var0 = var3;
    }
  }

  var5 = getnodearray("stacy_butcher_bad_zone_nodes", "targetname");

  foreach(var3 in var0) {
    if(isalive(level.stacy)) {
      var3 getenemyinfo(level.stacy);
    }

    var3 scripts\common\utility::demeanor_override("combat");
    var3 cleargoalvolume();
    var3.ignoreall = 0;
    var3 clearpath();
    var3 stopanimScripted();
    var3.target = undefined;
    thread stop_seeking();
    var3.fovcosine = 0.001;
    var3 allowedstances("stand", "crouch");
    var3 notify("stop_going_to_node");
    waitframe();
    var3 setgoalpos(var3.origin);
    var3 thread scripts\engine\sp\utility::set_favoriteenemy(level.stacy);
    var3 thread scripts\engine\utility::set_movement_speed(120);
    var3 thread scripts\engine\sp\utility::set_goal_radius(16);
    var3.baseaccuracy = 1000;
    var3.fovcosine = cos(89);
    var7 = sortbydistance(var5, var3.origin)[0];
    var3 setgoalpos(var7.origin);
    var5 = scripts\engine\utility::array_remove(var5, var7);
  }
}

function stop_seeking() {
  level.stacy waittill("death");
  self setgoalpos(self.origin);
}

function last_sight_updater() {
  level.stacy endon("death");

  for(;;) {
    self.lastenemysightpos = level.stacy.origin;
    waitframe();
  }
}

function amb_info_updater() {
  level.stacy endon("death");

  for(;;) {
    self getenemyinfo(level.stacy);
    waitframe();
  }
}

function objective_manager() {
  scripts\engine\sp\objectives::objective_add("direct_ambassador", "current", undefined, &"EMBASSY/OBJ_DSC_AMBASSADOR");
  scripts\engine\utility::flag_wait("intro_dialogue_setup_done");
  scripts\engine\sp\objectives::objective_remove("direct_ambassador");
  scripts\engine\sp\objectives::objective_add("escort", "current", level.stacy.origin + (0, 0, 50), undefined, "Stacy");
  scripts\engine\sp\objectives::objective_set_on_entity("escort", "Stacy", level.stacy);
  var0 = scripts\engine\sp\objectives::_objective_getindexforname("escort");
  objective_setzoffset(var0, 72);
  scripts\engine\sp\objectives::objective_add("escape", "current", (-7019, -1119, -535), &"EMBASSY/OBJ_SAFETY_GUIDE");
  scripts\engine\utility::flag_wait("save_part_2_start");
  scripts\engine\sp\objectives::objective_update("escape", "current", (-6157, -2237, -530), &"EMBASSY/OBJ_SAFETY_GUIDE");
  scripts\engine\utility::flag_wait("cctv_end");
  scripts\engine\sp\objectives::objective_remove("escort");
  scripts\engine\sp\objectives::objective_remove("escape");
}

function cctv_outro_bink_start() {}

function cctv_outro_bink_main() {
  visionsetnaked("embassy_cctv_01", 0);
  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", 13);
  var0 = scripts\engine\utility::getStruct("cctv_outro_bink_cam", "targetname");
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var1.origin += (0, 0, -67);
  level.player playerlinktoabsolute(var1);
  level.player disableweapons();
  level.player hidelegsandshadow();
  scripts\sp\maps\embassy\embassy_util::spawn_price();
  scripts\sp\maps\embassy\embassy_util::spawn_farah();
  scripts\sp\maps\embassy\embassy_util::spawn_stacy();
  var2 = scripts\engine\sp\utility::spawn_anim_model("garage_enter_door");
  var3 = scripts\engine\sp\utility::spawn_anim_model("keycard");
  var4 = getEntArray("cctv_bink_outro_hidden_door", "targetname");

  foreach(var6 in var4) {
    var6 hide();
  }

  var8 = [level.price, level.stacy, level.farah, var2, var3];
  var9 = scripts\engine\utility::getStruct("ap_cctv_outro_bink", "targetname");

  for(;;) {
    thread scripts\sp\maps\embassy\embassy_util::swap_card_reader("cctv_bink_outro_card_reader");
    level thread scripts\engine\sp\utility::notify_delay("card_reader_swap", 5);
    var9 scripts\common\anim::anim_single(var8, "gar_meetup_enter");
    waitframe();
  }
}

function cctv_outro_bink_catchup() {}

function display_all_node_names() {
  for(;;) {
    foreach(var1 in getallnodes()) {
      if(!isDefined(var1)) {
        continue;
      }

      if(isDefined(var1.script_namenumber)) {}
    }

    waitframe();
  }
}