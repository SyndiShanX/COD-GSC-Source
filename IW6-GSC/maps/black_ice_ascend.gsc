/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_ascend.gsc
*****************************************************/

start() {
  iprintln("Ascend");
  maps\black_ice_util::player_start("player_start_ascend");
  maps\_utility::vision_set_fog_changes("black_ice_catwalks", 0);

  if(level._allies.size < 2)
    level maps\black_ice_util::spawn_allies();

  common_scripts\utility::array_thread(level._allies, maps\_utility::set_ignoresuppression, 1);
  var_0 = getent("vignette_alpha_team_rigascend", "script_noteworthy");

  if(level._bravo.size < 2)
    level maps\black_ice_util::spawn_bravo();

  var_1 = common_scripts\utility::getstruct("vignette_beta_rig_ascend", "script_noteworthy");
  var_2 = getnode("bc_node_ascend_ally1", "targetname");
  level._allies[0] forceteleport(var_2.origin, var_2.angles);
  level._allies[0] thread maps\_utility::follow_path(var_2);
  var_2 = getnode("bc_node_ascend_ally2", "targetname");
  level._allies[1] forceteleport(var_2.origin, var_2.angles);
  level._allies[1] thread maps\_utility::follow_path(var_2);
  var_2 = getnode("bc_node_ascend_bravo1", "targetname");
  level._bravo[1] forceteleport(var_2.origin, var_2.angles);
  level._bravo[1] thread maps\_utility::follow_path(var_2);
  var_2 = getnode("bc_node_ascend_bravo2", "targetname");
  level._bravo[0] forceteleport(var_2.origin, var_2.angles);
  level._bravo[0] thread maps\_utility::follow_path(var_2);
  level.launchers_attached = 0;
  level.ascend_waiting = 1;
  common_scripts\utility::flag_set("bc_flag_spots_close");
  thread maps\black_ice_camp::fake_spot("cw_spotlight_2", "cw_spot_2_org");
  thread maps\black_ice_camp::fake_spot("cw_spotlight_3", "cw_spot_3_org");
  thread maps\black_ice_camp::ascend_snow_fx();
  thread hanging_cargo_motion();
  thread maps\black_ice_audio::sfx_distant_oil_rig();
}

main() {
  level.ascend_launch_pos = common_scripts\utility::getstruct("ascend_launch_pos", "script_noteworthy");

  if(!isDefined(level.ascend_anim_node))
    level.ascend_anim_node = getent("vignette_alpha_team_rigascend", "script_noteworthy");

  level.bravo_ascend_anim_node = common_scripts\utility::getstruct("vignette_beta_rig_ascend", "script_noteworthy");
  level.bravo_ascend_anim_node.origin = level.ascend_anim_node.origin;
  level.bravo_ascend_anim_node.angles = level.ascend_anim_node.angles;
  level.player_ascend_anim_node = getent("vignette_alpha_player_rigascend", "script_noteworthy");
  level.sfx_ascend_check = "stop";
  level.sfx_ascend_node = spawn("script_origin", (1414, 3969, 4069));
  init_ascend_vars();
  thread start_catwalk_snow();
  thread ascend_dialog();
  thread keegan_kill_dialog();
  thread ascend_vision_sets();
  thread ascend_logic();
}

ascend_vision_sets() {
  common_scripts\utility::flag_wait("flag_ascend_start");
  maps\_utility::stop_exploder("basecamp_lights");
  maps\_utility::vision_set_fog_changes("black_ice_catwalks", 7);
}

section_flag_inits() {
  common_scripts\utility::flag_init("flag_ascend_triggered");
  common_scripts\utility::flag_init("flag_ascend_start");
  common_scripts\utility::flag_init("flag_ascend_bravo_go");
  common_scripts\utility::flag_init("flag_player_ascending");
  common_scripts\utility::flag_init("flag_bravo_ascend_complete");
  common_scripts\utility::flag_init("flag_alpha_ascend_complete");
  common_scripts\utility::flag_init("flag_ascend_end");
  common_scripts\utility::flag_init("flag_player_line_launched");
  common_scripts\utility::flag_init("flag_dialog_dontstop");
  common_scripts\utility::flag_init("flag_dialog_weaponsfree");
}

section_precache() {
  maps\_utility::add_hint_string("hint_ascend_init", &"BLACK_ICE_ASCEND_INIT", ::hint_ascend_init_func);
  maps\_utility::add_hint_string("hint_ascend_launch", &"BLACK_ICE_ASCEND_LAUNCH", ::hint_ascend_func);
  maps\_utility::add_hint_string("hint_ascend", &"BLACK_ICE_ASCEND_ASCEND", ::hint_ascend_func);
  precachemodel("black_ice_rope_prop");
  precachemodel("black_ice_rope_prop_obj");
}

ally_setup() {}

player_setup(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 60;

  maps\black_ice_util::setup_player_for_animated_sequence(1, var_0, var_1, var_2, 0, undefined);
}

play_falling_enemy() {
  var_0 = level.ascend_anim_node common_scripts\utility::spawn_tag_origin();
  level.ascend_enemy = maps\_vignette_util::vignette_actor_spawn("ascend_enemy", "opfor");
  level.ascend_enemy linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 maps\_anim::anim_single_solo(level.ascend_enemy, "alpha_rig_ascend");
  var_0 maps\_anim::anim_last_frame_solo(level.ascend_enemy, "alpha_rig_ascend");
  common_scripts\utility::flag_wait("flag_ascend_end");
  level.ascend_enemy unlink();
  level.ascend_enemy maps\_utility::stop_magic_bullet_shield();
  level.ascend_enemy kill();
  var_0 delete();
}

props_setup() {
  level.ascend_launcher = maps\_utility::spawn_anim_model("ascend_launcher");
  level.ascend_ascender = maps\_utility::spawn_anim_model("ascend_ascender");
  level.ascend_hook = maps\_utility::spawn_anim_model("ascend_hook");
  level.ascend_hook_ally1 = maps\_utility::spawn_anim_model("ascend_hook_ally1");
  level.ascend_hook_ally2 = maps\_utility::spawn_anim_model("ascend_hook_ally2");
  level.ascend_hook_ally3 = maps\_utility::spawn_anim_model("ascend_hook_ally3");
  level.ascend_hook_ally4 = maps\_utility::spawn_anim_model("ascend_hook_ally4");
  level.ascend_launcher hide();
  level.ascend_ascender hide();
  level.ascend_hook hide();
  level.ascend_hook_ally1 hide();
  level.ascend_hook_ally2 hide();
  level.ascend_hook_ally3 hide();
  level.ascend_hook_ally4 hide();

  if(!isDefined(level.ally1_ascend_launcher)) {
    level.ally1_ascend_launcher = maps\_utility::spawn_anim_model("ally1_ascend_launcher");
    level.ally2_ascend_launcher = maps\_utility::spawn_anim_model("ally2_ascend_launcher");
  }

  level.ally1_ascend_ascender = maps\_utility::spawn_anim_model("ally1_ascend_ascender");
  level.ally2_ascend_ascender = maps\_utility::spawn_anim_model("ally2_ascend_ascender");
  level.ally1_ascend_ascender hide();
  level.ally2_ascend_ascender hide();
  level.ascend_rope1 = maps\_utility::spawn_anim_model("ascend_rope1");
  level.ascend_rope2 = maps\_utility::spawn_anim_model("ascend_rope2");
  level.ascend_rope3 = maps\_utility::spawn_anim_model("ascend_rope3");
  level.ascend_rope1 hide();
  level.ascend_rope2 hide();
  level.ascend_rope3 hide();

  if(!isDefined(level.bravo1_ascend_launcher)) {
    level.bravo1_ascend_launcher = maps\_utility::spawn_anim_model("bravo1_ascend_launcher");
    level.bravo2_ascend_launcher = maps\_utility::spawn_anim_model("bravo2_ascend_launcher");
  }

  if(!isDefined(level.bravo1_ascend_ascender)) {
    level.bravo1_ascend_ascender = maps\_utility::spawn_anim_model("bravo1_ascend_ascender");
    level.bravo2_ascend_ascender = maps\_utility::spawn_anim_model("bravo2_ascend_ascender");
    level.bravo1_ascend_ascender hide();
    level.bravo2_ascend_ascender hide();
  }

  if(!isDefined(level.bravo_ascend_rope1)) {
    level.bravo_ascend_rope1 = maps\_utility::spawn_anim_model("bravo_ascend_rope1");
    level.bravo_ascend_rope2 = maps\_utility::spawn_anim_model("bravo_ascend_rope2");
    level.bravo_ascend_rope1 hide();
    level.bravo_ascend_rope2 hide();
  }
}

init_ascend_vars() {
  level.ascend_anims_rate = 1.0;
  level.allow_player_ascend_move = 0;
  level.ascend_current_rate = 0.0;
  level.bravo_curr_rate = level.ascend_anims_rate;
  level.alpha_curr_rate = level.ascend_anims_rate;
}

start_catwalk_snow() {
  level waittill("notify_start_catwalks_snow");
  maps\_utility::stop_exploder("basecamp_lights");
  common_scripts\utility::exploder("catwalks_snow");
  wait 1.0;
  common_scripts\utility::exploder("catwalks_lights");
  wait 15.0;
  maps\_utility::stop_exploder("ascend_snow_huge");
}

ascend_dialog() {
  level waittill("notify_ascend_linesout");
  thread dialog_linesout();
  level waittill("notify_ascend_dialog_splitoff");
  wait 1.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_rogersdiazyouarebravo");
  maps\_utility::smart_radio_dialogue("blackice_diz_atthetop");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_rookfuentesstickwithme");

  if(!common_scripts\utility::flag("flag_player_ascending"))
    level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_yourmarkrook");

  common_scripts\utility::flag_wait("flag_player_ascending");
  wait 0.8;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_steponedisablethe");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_steptwooverloadthe");

  if(!common_scripts\utility::flag("flag_dialog_weaponsfree")) {
    if(!common_scripts\utility::flag("flag_dialog_dontstop")) {
      common_scripts\utility::flag_wait("flag_dialog_dontstop");
      level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_inrange");
    }

    common_scripts\utility::flag_wait("flag_dialog_weaponsfree");
  }

  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_getreadyweaponsfree");
}

keegan_kill_dialog() {
  level waittill("notify_ascend_dialog5");
  level._allies[1] thread maps\_utility::smart_dialogue("blackice_fnt_aboveyou");
  level waittill("notify_ascend_dialog6");
  thread maps\_utility::smart_radio_dialogue_overlap("blackice_grn_grunt");
  level waittill("notify_ascend_dialog7");
  thread maps\_utility::smart_radio_dialogue_interrupt("blackice_grn_bravosup");
}

dialog_linesout() {
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_linesuphere");
  wait 0.8;

  if(!common_scripts\utility::flag("flag_player_line_launched"))
    maps\_utility::smart_radio_dialogue("blackice_diz_lineout");

  wait 3.0;

  if(!common_scripts\utility::flag("flag_player_line_launched"))
    level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_ropeup");
}

runin_to_ascend(var_0, var_1) {
  level endon("camp_end_runin_to_ascend");
  self.old_moveplaybackrate = self.moveplaybackrate;
  thread maps\_utility::set_moveplaybackrate(randomfloatrange(1.16, 1.2), 0.5);
  var_0 maps\_anim::anim_reach_solo(self, "ascend_runin");
  self detach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
  self.launcher show();
  var_2 = [];
  var_2[0] = self;
  var_2[1] = self.launcher;
  var_0 maps\_anim::anim_single(var_2, "ascend_runin");
  level.ascend_anim_node thread maps\_anim::anim_loop(var_2, "ascend_waiting", "stop_loop");

  if(isDefined(var_1))
    common_scripts\utility::flag_set(var_1);
}

ascend_logic() {
  level.player endon("death");
  ally_setup();
  props_setup();
  thread bravo_ascend();
  var_0 = [];
  var_0["ally1"] = level._allies[0];
  var_0["ally2"] = level._allies[1];
  var_0["ally1_ascend_launcher"] = level.ally1_ascend_launcher;
  var_0["ally2_ascend_launcher"] = level.ally2_ascend_launcher;

  if(isDefined(level.launchers_attached) && level.launchers_attached) {
    level._allies[0] detach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
    level._allies[1] detach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
    level.launchers_attached = 0;
  }

  if(isDefined(level.ascend_waiting) && level.ascend_waiting)
    level.ascend_anim_node thread maps\_anim::anim_loop(var_0, "ascend_waiting", "stop_loop");

  maps\black_ice_util::waittill_trigger_activate_looking_at(level.ascend_launch_pos, "hint_ascend_init", 150, undefined, undefined, 5, "flag_ascend_ready");
  level.ascend_launch_pos = undefined;
  common_scripts\utility::flag_set("flag_ascend_triggered");
  level notify("camp_end_runin_to_ascend");
  maps\black_ice_swim::destroy_persistent_ice_breach_props();
  var_0["ascend_rope2"] = level.ascend_rope2;
  var_0["ascend_rope3"] = level.ascend_rope3;
  level.ascend_rope2 show();
  level.ascend_rope3 show();
  level.ascend_anim_node notify("stop_loop");
  level.ascend_anim_node thread maps\_anim::anim_reach(level._allies, "alpha_rope_shoot");
  level.ascend_anim_node thread maps\_anim::anim_single(var_0, "alpha_rope_shoot");
  var_1 = 1.0;
  maps\black_ice_util::player_animated_sequence_restrictions();
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2.origin = level.player.origin;
  var_2.angles = level.player.angles;
  var_2 hide();
  level.player_ascend_anim_node thread maps\_anim::anim_single_solo(var_2, "alpha_rig_ascend_aim");
  level.player playerlinktoblend(var_2, "tag_player", var_1);
  var_2 thread wait_and_unhide_ascend_aim_assets(var_1);
  maps\_utility::delaythread(2.0, common_scripts\utility::flag_set, "flag_bravo_ascend_ready");
  thread maps\black_ice_audio::sfx_blackice_rig_start_ss();
  level.player_legs = maps\_utility::spawn_anim_model("player_legs_ascend");
  var_3["player_legs"] = level.player_legs;
  var_3["ascend_rope1"] = level.ascend_rope1;
  var_3["ascend_ascender"] = level.ascend_ascender;
  level.ascend_rope1 show();
  level notify("notify_ascend_linesout");
  level.ascend_launcher.origin = level.player.origin;
  level.ascend_launcher.angles = level.player.angles;
  level.player_ascend_anim_node maps\_anim::anim_single_solo(level.ascend_launcher, "alpha_rig_ascend_aim");
  level.player unlink();
  player_setup(0.01, var_2.origin, var_2.angles);
  var_2 delete();
  var_3["player_rig"] = level.player_rig;
  var_4 = maps\_utility::spawn_anim_model("ascend_launcher");
  var_4.origin = level.ascend_launcher.origin;
  var_4.angles = level.ascend_launcher.angles;
  level.ascend_launcher delete();
  level.ascend_launcher = var_4;
  level.player_rig setanim(level.scr_anim["player_rig"]["alpha_rig_ascend_aim_loop"][0], 1, 0, 1);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["alpha_rig_ascend_aim_loop"][0], 1, 0, 1);

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    level.player enablemousesteer(1);

  level.player_rig thread ascend_aim_logic();
  maps\_anim::anim_set_rate(var_0, "alpha_rope_shoot", 0.0);
  maps\_utility::display_hint_timeout("hint_ascend_launch");
  thread maps\black_ice::flarestack_swap();
  var_5 = 2000;
  var_6 = gettime();

  while(!level.player attackbuttonpressed()) {
    if(!isDefined(level._allies[0].line_shot) || !level._allies[0].line_shot) {
      if(gettime() - var_6 > var_5) {
        thread maps\black_ice_audio::sfx_blackice_rig_start3_ss();
        maps\_anim::anim_set_rate(var_0, "alpha_rope_shoot", 1.0);
        level._allies[0].line_shot = 1;
      }
    } else if(!isDefined(level._allies[0].waiting) || !level._allies[0].waiting) {
      if(level._allies[0] maps\black_ice_util::check_anim_time("ally1", "alpha_rope_shoot", 1.0)) {
        var_0["ally1_ascend_ascender"] = level.ally1_ascend_ascender;
        var_0["ally2_ascend_ascender"] = level.ally2_ascend_ascender;
        level.ally1_ascend_ascender show();
        level.ally2_ascend_ascender show();
        level.ascend_anim_node thread maps\_anim::anim_loop(var_0, "alpha_hand_rope", "stop_loop");
        level._allies[0].waiting = 1;
      }
    }

    wait(level.timestep);
  }

  level notify("ascend_rope_launched");
  common_scripts\utility::flag_set("flag_player_line_launched");

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    level.player enablemousesteer(0);

  setthreatbias("axis", "player", -256);

  if(!isDefined(level._allies[0].line_shot) || !level._allies[0].line_shot) {
    thread maps\black_ice_audio::sfx_blackice_rig_start3_ss();
    maps\_anim::anim_set_rate(var_0, "alpha_rope_shoot", 1.0);
  }

  level.ascend_ascender show();
  level.player_ascend_anim_node notify("stop_loop");
  level.player_rig setanim(level.scr_anim["player_rig"]["alpha_rig_ascend_aim_loop"][0], 0, 0, 1);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["alpha_rig_ascend_aim_loop"][0], 0, 0, 1);
  level.player_ascend_anim_node thread maps\_anim::anim_single(var_3, "alpha_rig_ascend_linkup");
  level.player_ascend_anim_node thread maps\_anim::anim_single_solo(level.ascend_launcher, "alpha_rig_ascend_linkup");
  level notify("notify_ascend_dialog_splitoff");

  for(;;) {
    if(!isDefined(level._allies[0].waiting) || !level._allies[0].waiting) {
      if(level._allies[0] maps\black_ice_util::check_anim_time("ally1", "alpha_rope_shoot", 1.0)) {
        var_0["ally1_ascend_ascender"] = level.ally1_ascend_ascender;
        var_0["ally2_ascend_ascender"] = level.ally2_ascend_ascender;
        level.ally1_ascend_ascender show();
        level.ally2_ascend_ascender show();
        level.ascend_anim_node thread maps\_anim::anim_loop(var_0, "alpha_hand_rope", "stop_loop");
        level._allies[0].waiting = 1;
      }
    }

    if(!isDefined(level.player.waiting) || !level.player.waiting) {
      if(level.player_rig maps\black_ice_util::check_anim_time("player_rig", "alpha_rig_ascend_linkup", 1.0)) {
        maps\_utility::delaythread(5, common_scripts\utility::flag_set, "flag_ascend_start");
        level.player_ascend_anim_node thread maps\_anim::anim_loop(var_3, "alpha_rig_ascend_groundidle", "stop_loop");
        level.player.waiting = 1;
      }
    }

    if(isDefined(level._allies[0].waiting) && level._allies[0].waiting && isDefined(level.player.waiting) && level.player.waiting) {
      level.player.waiting = undefined;
      break;
    }

    wait(level.timestep);
  }

  var_7 = 0.3;
  level.player lerpviewangleclamp(var_7, 0, 0, 60, 60, 60, 60);
  calculate_bravo_rubberband_base();
  maps\_utility::display_hint("hint_ascend");

  while(!level.player attackbuttonpressed())
    wait(level.timestep);

  common_scripts\utility::flag_set("flag_player_ascending");
  level.player_ascend_anim_node notify("stop_loop");
  level.ascend_anim_node notify("stop_loop");

  foreach(var_9 in var_3)
  var_9 linkto(level.player_ascend_anim_node);

  thread maps\black_ice_audio::sfx_rig_ascend_logic("go");
  level.player lerpviewangleclamp(var_7, 0, 0, 0, 0, 0, 0);
  wait(var_7);
  level.player_ascend_anim_node thread maps\_anim::anim_single(var_3, "alpha_rig_ascend");
  var_11 = [];
  var_11["ascend_hook_ally1"] = level.ascend_hook_ally1;
  var_11["ascend_hook_ally2"] = level.ascend_hook_ally2;
  var_11["ascend_hook_ally3"] = level.ascend_hook_ally3;
  var_11["ascend_hook_ally4"] = level.ascend_hook_ally4;
  level.player_ascend_anim_node thread maps\_anim::anim_single_solo(level.ascend_hook, "ascend_hook");
  level.ascend_anim_node thread maps\_anim::anim_single(var_11, "ascend_hook");
  level.ascend_hook show();
  level.ascend_hook_ally1 show();
  level.ascend_hook_ally2 show();
  level.ascend_hook_ally3 show();
  level.ascend_hook_ally4 show();
  level.ascend_state = "ascend";
  level.ascend_state_transition = 0;
  level.start_ascend_time = gettime();
  thread ascend_mechanics(var_3);
  level.player.ignoreme = 1;
  thread alpha_ascend_rubberband(var_0);
  thread alpha_ascend_rubberband_cleanup(var_0);
  maps\_utility::delaythread(0.05, ::post_ascend_cleanup);
  var_12 = getent("vignette_alpha_team_rigascend", "script_noteworthy");
  var_12 maps\_anim::anim_single(var_0, "alpha_rig_ascend");
  level notify("notify_alpha_ascend_complete");
  common_scripts\utility::flag_set("flag_alpha_ascend_complete");
  level._allies[0] stopanimscripted();
  level._allies[1] stopanimscripted();
}

ascend_aim_logic() {
  level endon("ascend_rope_launched");
  level.static_damping_factor = -7.2;
  level.kinetic_damping_factor = -1.2;
  level.accel_factor = 14.0;
  level.max_velocity = 2.4;
  self.up_velocity = 0.0;
  self.down_velocity = 0.0;
  self.left_velocity = 0.0;
  self.right_velocity = 0.0;
  self.up_weight = 0.0;
  self.down_weight = 0.0;
  self.left_weight = 0.0;
  self.right_weight = 0.0;
  self setanim(level.scr_anim["player_rig"]["rigascend_aim_left_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig"]["rigascend_aim_right_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig"]["rigascend_aim_up_parent"], 0, 0);
  self setanim(level.scr_anim["player_rig"]["rigascend_aim_down_parent"], 0, 0);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["ascender_aim_left_parent"], 0, 0);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["ascender_aim_right_parent"], 0, 0);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["ascender_aim_up_parent"], 0, 0);
  level.ascend_launcher setanim(level.scr_anim["ascend_launcher"]["ascender_aim_down_parent"], 0, 0);
  thread ascend_aim_logic_cleanup();

  for(;;) {
    ascend_aim_lerp_anims();
    wait(level.timestep);
  }
}

ascend_aim_lerp_anims() {
  level endon("ascend_rope_launched");
  var_0 = level.player getnormalizedcameramovement();

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    var_0 = (var_0[0], var_0[1] * -1, var_0[2]);

  var_1 = common_scripts\utility::ter_op(var_0[0] > 0.1, 1, 0);
  var_2 = common_scripts\utility::ter_op(var_0[0] < -0.1, 1, 0);
  var_3 = common_scripts\utility::ter_op(var_0[1] < -0.1, 1, 0);
  var_4 = common_scripts\utility::ter_op(var_0[1] > 0.1, 1, 0);
  var_5 = common_scripts\utility::ter_op(self.up_weight > 0.0, 1, 0);
  var_6 = common_scripts\utility::ter_op(self.down_weight > 0.0, 1, 0);
  var_7 = common_scripts\utility::ter_op(self.left_weight > 0.0, 1, 0);
  var_8 = common_scripts\utility::ter_op(self.right_weight > 0.0, 1, 0);
  var_9 = 0.0;
  var_10 = 0.0;
  var_11 = 0.0;
  var_12 = 0.0;

  if(var_1) {
    if(!var_6)
      var_9 = var_0[0];
    else
      var_10 = -1.0 * var_0[0];
  } else if(var_2) {
    if(!var_5)
      var_10 = -1.0 * var_0[0];
    else
      var_9 = var_0[0];
  }

  if(var_3) {
    if(!var_8)
      var_11 = -1.0 * var_0[1];
    else
      var_12 = var_0[1];
  } else if(var_4) {
    if(!var_7)
      var_12 = var_0[1];
    else
      var_11 = -1.0 * var_0[1];
  }

  self.up_velocity = self.up_velocity + var_9 * level.accel_factor * level.timestep;
  self.down_velocity = self.down_velocity + var_10 * level.accel_factor * level.timestep;
  self.left_velocity = self.left_velocity + var_11 * level.accel_factor * level.timestep;
  self.right_velocity = self.right_velocity + var_12 * level.accel_factor * level.timestep;
  self.up_velocity = common_scripts\utility::ter_op(self.up_velocity > level.max_velocity, level.max_velocity, self.up_velocity);
  self.up_velocity = common_scripts\utility::ter_op(self.up_velocity < -1 * level.max_velocity, -1 * level.max_velocity, self.up_velocity);
  self.down_velocity = common_scripts\utility::ter_op(self.down_velocity > level.max_velocity, level.max_velocity, self.down_velocity);
  self.down_velocity = common_scripts\utility::ter_op(self.down_velocity < -1 * level.max_velocity, -1 * level.max_velocity, self.down_velocity);
  self.left_velocity = common_scripts\utility::ter_op(self.left_velocity > level.max_velocity, level.max_velocity, self.left_velocity);
  self.left_velocity = common_scripts\utility::ter_op(self.left_velocity < -1 * level.max_velocity, -1 * level.max_velocity, self.left_velocity);
  self.right_velocity = common_scripts\utility::ter_op(self.right_velocity > level.max_velocity, level.max_velocity, self.right_velocity);
  self.right_velocity = common_scripts\utility::ter_op(self.right_velocity < -1 * level.max_velocity, -1 * level.max_velocity, self.right_velocity);

  if(!(var_1 || var_2 || var_3 || var_4))
    var_13 = level.static_damping_factor;
  else
    var_13 = level.kinetic_damping_factor;

  self.up_velocity = self.up_velocity + var_13 * self.up_velocity * level.timestep;
  self.down_velocity = self.down_velocity + var_13 * self.down_velocity * level.timestep;
  self.left_velocity = self.left_velocity + var_13 * self.left_velocity * level.timestep;
  self.right_velocity = self.right_velocity + var_13 * self.right_velocity * level.timestep;
  self.up_weight = self.up_weight + self.up_velocity * level.timestep;
  self.down_weight = self.down_weight + self.down_velocity * level.timestep;
  self.left_weight = self.left_weight + self.left_velocity * level.timestep;
  self.right_weight = self.right_weight + self.right_velocity * level.timestep;

  if(self.up_weight < 0.0) {
    self.down_weight = -1.0 * self.up_weight;
    self.up_weight = 0.0;
    self.down_velocity = -1.0 * self.up_velocity;
    self.up_velocity = 0.0;
  } else if(self.down_weight < 0.0) {
    self.up_weight = -1.0 * self.down_weight;
    self.down_weight = 0.0;
    self.up_velocity = -1.0 * self.down_velocity;
    self.down_velocity = 0.0;
  }

  if(self.left_weight < 0.0) {
    self.right_weight = -1.0 * self.left_weight;
    self.left_weight = 0.0;
    self.right_velocity = -1.0 * self.left_velocity;
    self.left_velocity = 0.0;
  } else if(self.right_weight < 0.0) {
    self.left_weight = -1.0 * self.right_weight;
    self.right_weight = 0.0;
    self.left_velocity = -1.0 * self.right_velocity;
    self.right_velocity = 0.0;
  }

  self.left_weight = common_scripts\utility::ter_op(self.left_weight > 1.0, 1.0, self.left_weight);
  self.right_weight = common_scripts\utility::ter_op(self.right_weight > 1.0, 1.0, self.right_weight);
  self.up_weight = common_scripts\utility::ter_op(self.up_weight > 1.0, 1.0, self.up_weight);
  self.down_weight = common_scripts\utility::ter_op(self.down_weight > 1.0, 1.0, self.down_weight);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_left"], 1, 0);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_right"], 1, 0);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_up"], 1, 0);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_down"], 1, 0);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_left_parent"], self.left_weight, level.timestep);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_right_parent"], self.right_weight, level.timestep);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_up_parent"], self.up_weight, level.timestep);
  self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_down_parent"], self.down_weight, level.timestep);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_left"], 1, 0);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_right"], 1, 0);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_up"], 1, 0);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_down"], 1, 0);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_left_parent"], self.left_weight, level.timestep);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_right_parent"], self.right_weight, level.timestep);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_up_parent"], self.up_weight, level.timestep);
  level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_down_parent"], self.down_weight, level.timestep);
}

ascend_aim_logic_cleanup() {
  level waittill("ascend_rope_launched");
  thread maps\black_ice_audio::sfx_blackice_rig_start2_ss();
  var_0 = 0.2;
  var_1 = gettime();
  level.player lerpviewangleclamp(var_0, 0, 0, 0, 0, 0, 0);
  var_2 = self.left_weight / (var_0 / level.timestep);
  var_3 = self.right_weight / (var_0 / level.timestep);
  var_4 = self.up_weight / (var_0 / level.timestep);
  var_5 = self.down_weight / (var_0 / level.timestep);

  while(gettime() - var_1 < var_0 * 1000) {
    self.left_weight = self.left_weight - var_2;
    self.right_weight = self.right_weight - var_3;
    self.up_weight = self.up_weight - var_4;
    self.down_weight = self.down_weight - var_5;
    self.left_weight = common_scripts\utility::ter_op(self.left_weight < 0.0, 0.0, self.left_weight);
    self.right_weight = common_scripts\utility::ter_op(self.right_weight < 0.0, 0.0, self.right_weight);
    self.up_weight = common_scripts\utility::ter_op(self.up_weight < 0.0, 0.0, self.up_weight);
    self.down_weight = common_scripts\utility::ter_op(self.down_weight < 0.0, 0.0, self.down_weight);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_left"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_right"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_up"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_down"], 1, 0);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_left_parent"], self.left_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_right_parent"], self.right_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_up_parent"], self.up_weight, level.timestep);
    self setanimlimited(level.scr_anim["player_rig"]["rigascend_aim_down_parent"], self.down_weight, level.timestep);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_left"], 1, 0);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_right"], 1, 0);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_up"], 1, 0);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_down"], 1, 0);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_left_parent"], self.left_weight, level.timestep);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_right_parent"], self.right_weight, level.timestep);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_up_parent"], self.up_weight, level.timestep);
    level.ascend_launcher setanimlimited(level.scr_anim["ascend_launcher"]["ascender_aim_down_parent"], self.down_weight, level.timestep);
    wait(level.timestep);
  }
}

wait_and_unhide_ascend_aim_assets(var_0) {
  wait(var_0);
  self show();
  level.ascend_launcher show();
}

player_ramp_up_wind() {
  level endon("notify_end_ascend_pendulum");
  var_0 = 0.0;
  var_1 = 0.0;
  var_2 = 0.0;
  var_2 = level.player_rig getanimtime(level.scr_anim["player_rig"]["alpha_rig_ascend"]);
  var_3 = 0.0;
  var_4 = [];
  var_4 = getnotetracktimes(level.scr_anim["player_rig"]["alpha_rig_ascend"], "max_wind");
  var_3 = var_4[0];
  var_5 = 0.2;
  var_6 = 1.0;

  for(;;) {
    var_1 = level.player_rig getanimtime(level.scr_anim["player_rig"]["alpha_rig_ascend"]);
    var_0 = maps\black_ice_util::normalize_value(var_2, var_3, var_1);
    var_0 = maps\black_ice_util::factor_value_min_max(var_5, var_6, var_0);
    level.player_rig setanimlimited(level.scr_anim["player_rig"]["rigascend_noise_parent"], var_0, 0.1);
    wait(level.timestep);
  }
}

alpha_ascend_rubberband(var_0) {
  level endon("notify_ascend_rubberband_alpha_stop");
  level waittill("notify_ascend_rubberband_alpha_start");
  var_1 = 0.1;
  var_2 = level.ascend_anims_rate;
  var_3 = 0.1;

  for(;;) {
    var_4 = maps\black_ice_util::factor_value_min_max(var_1, var_2, level.ascend_current_rate);
    level.alpha_curr_rate = level.alpha_curr_rate + (var_4 - level.alpha_curr_rate) * var_3;
    maps\_anim::anim_set_rate(var_0, "alpha_rig_ascend", level.alpha_curr_rate);
    wait(level.timestep);
  }
}

alpha_ascend_rubberband_cleanup(var_0) {
  level endon("notify_alpha_ascend_complete");
  level waittill("notify_ascend_rubberband_alpha_stop");
  var_1 = 0.1;

  for(;;) {
    if(level.alpha_curr_rate < level.ascend_anims_rate) {
      level.alpha_curr_rate = level.alpha_curr_rate + (level.ascend_anims_rate - level.alpha_curr_rate) * var_1;
      maps\_anim::anim_set_rate(var_0, "alpha_rig_ascend", level.alpha_curr_rate);
    }

    wait(level.timestep);
  }
}

bravo_ascend() {
  var_0 = [];
  var_0["bravo1"] = level._bravo[0];
  var_0["bravo2"] = level._bravo[1];
  var_0["bravo1_ascend_launcher"] = level.bravo1_ascend_launcher;
  var_0["bravo2_ascend_launcher"] = level.bravo2_ascend_launcher;

  if(isDefined(level.launchers_attached) && level.launchers_attached) {
    level._bravo[0] detach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
    level._bravo[1] detach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
    level.launchers_attached = 0;
  }

  if(isDefined(level.ascend_waiting) && level.ascend_waiting)
    level.bravo_ascend_anim_node thread maps\_anim::anim_loop(var_0, "ascend_waiting", "stop_loop");

  while(!common_scripts\utility::flag("flag_ascend_triggered"))
    wait(level.timestep);

  var_1 = gettime() / 1000.0;

  if(!common_scripts\utility::flag("flag_ascend_ready_bravo_0") || !common_scripts\utility::flag("flag_ascend_ready_bravo_1"))
    common_scripts\utility::flag_wait("flag_bravo_ascend_ready");

  var_1 = clamp(gettime() / 1000.0 - var_1, 0.0, 3.0);
  level.bravo_ascend_anim_node notify("stop_loop");
  var_0["bravo_ascend_rope1"] = level.bravo_ascend_rope1;
  var_0["bravo_ascend_rope2"] = level.bravo_ascend_rope2;
  level.bravo_ascend_rope1 show();
  level.bravo_ascend_rope2 show();
  var_2 = getanimlength(var_0["bravo1"] maps\_utility::getanim("bravo_rope_shoot"));
  var_3 = var_2 - var_1;

  foreach(var_5 in var_0) {
    level.bravo_ascend_anim_node thread maps\_anim::anim_single_solo(var_5, "bravo_rope_shoot");
    var_5 setanimtime(var_5 maps\_utility::getanim("bravo_rope_shoot"), var_1 / var_2);
  }

  wait(var_3);
  level.bravo_ascend_anim_node thread maps\_anim::anim_loop(var_0, "bravo_rope_idle", "stop_loop");

  while(!common_scripts\utility::flag("flag_ascend_bravo_go"))
    wait(level.timestep);

  level.bravo_ascend_anim_node notify("stop_loop");
  common_scripts\utility::array_thread(level._bravo, maps\_utility::set_ignoreme, 1);
  common_scripts\utility::array_thread(level._bravo, maps\_utility::disable_surprise);
  thread play_falling_enemy();
  var_0["bravo1_ascend_ascender"] = level.bravo1_ascend_ascender;
  var_0["bravo2_ascend_ascender"] = level.bravo2_ascend_ascender;
  level.bravo1_ascend_ascender show();
  level.bravo2_ascend_ascender show();
  thread bravo_ascend_rubberband(var_0);
  thread bravo_ascend_rubberband_cleanup(var_0);
  level.bravo_ascend_anim_node maps\_anim::anim_single(var_0, "bravo_rig_ascend");
  level notify("notify_bravo_ascend_complete");
  common_scripts\utility::flag_set("flag_bravo_ascend_complete");
}

calculate_bravo_rubberband_base() {
  level.bravo_ascend_rubberband_base = level._bravo[1] getanimtime(level.scr_anim["bravo2"]["bravo_rig_ascend"]);
  level notify("notify_ascend_rubberband_bravo_start");
}

bravo_ascend_rubberband(var_0) {
  level endon("notify_ascend_rubberband_bravo_stop");
  level waittill("notify_ascend_rubberband_bravo_start");
  var_1 = 0.75;
  var_2 = level.ascend_anims_rate;
  var_3 = 0.0;
  var_4 = 0.06;
  var_5 = 0.1;

  for(;;) {
    var_6 = level._bravo[1] getanimtime(level.scr_anim["bravo2"]["bravo_rig_ascend"]);
    var_7 = 0;

    if(common_scripts\utility::flag("flag_player_ascending"))
      var_7 = level.player_rig getanimtime(level.scr_anim["player_rig"]["alpha_rig_ascend"]);

    var_8 = var_6 - var_7 - level.bravo_ascend_rubberband_base;
    var_9 = maps\black_ice_util::normalize_value(var_3, var_4, var_8);
    var_10 = maps\black_ice_util::factor_value_min_max(var_1, var_2, 1.0 - var_9);
    level.bravo_curr_rate = level.bravo_curr_rate + (var_10 - level.bravo_curr_rate) * var_5;
    maps\_anim::anim_set_rate(var_0, "bravo_rig_ascend", level.bravo_curr_rate);
    maps\_anim::anim_set_rate_single(level.ascend_enemy, "alpha_rig_ascend", level.bravo_curr_rate);
    wait(level.timestep);
  }
}

bravo_ascend_rubberband_cleanup(var_0) {
  level endon("notify_bravo_ascend_complete");
  level waittill("notify_ascend_rubberband_bravo_stop");
  var_1 = 0.1;

  for(;;) {
    level.bravo_curr_rate = level.bravo_curr_rate + (level.ascend_anims_rate - level.bravo_curr_rate) * var_1;
    maps\_anim::anim_set_rate(var_0, "bravo_rig_ascend", level.bravo_curr_rate);

    if(isDefined(level.ascend_enemy))
      maps\_anim::anim_set_rate_single(level.ascend_enemy, "alpha_rig_ascend", level.bravo_curr_rate);

    wait(level.timestep);
  }
}

ascend_mechanics(var_0) {
  thread ascend_pendulum(level.player_ascend_anim_node, 1.25, 0.0, 1.5, undefined, "notify_end_ascend_pendulum");
  var_1 = 0.0;
  var_2 = 0.1;

  while(!common_scripts\utility::flag("flag_ascend_end")) {
    if(level.allow_player_ascend_move == 0) {
      maps\_anim::anim_set_rate(var_0, "alpha_rig_ascend", 1.0);
      level.ascend_current_rate = 1.0;
      var_1 = 1.0;
      wait(level.timestep);
      continue;
    }

    switch (level.ascend_state) {
      case "idle":
        if(level.ascend_state_transition)
          ascend_idle_state_transition();

        ascend_idle_state();
        break;
      case "ascend":
        if(level.ascend_state_transition)
          ascend_ascend_state_transition();

        ascend_ascend_state();
        break;
      case "stop":
        if(level.ascend_state_transition)
          ascend_stop_state_transition();

        ascend_stop_state();
        break;
    }

    var_1 = var_1 + (level.ascend_target_rate - var_1) * var_2;
    maps\_anim::anim_set_rate(var_0, "alpha_rig_ascend", var_1);
    level.ascend_current_rate = var_1;
    wait(level.timestep);
  }
}

ascend_idle_state_transition() {
  level.ascend_state_transition = 0;
  level.ascend_target_rate = 0.0;
}

ascend_idle_state() {
  if(level.player attackbuttonpressed()) {
    level.ascend_state = "ascend";
    level.ascend_state_transition = 1;
  }
}

ascend_ascend_state_transition() {
  level.ascend_state_transition = 0;
  level.start_ascend_time = gettime();
  level.ascend_target_rate = level.ascend_anims_rate;
  common_scripts\utility::flag_set("flag_player_ascending");
  level.player_rig setanimrestart(level.scr_anim["player_rig"]["rig_ascend_start"]);
  level.player_legs setanimrestart(level.scr_anim["player_legs_ascend"]["rig_ascend_start"]);
  thread maps\black_ice_audio::sfx_rig_ascend_logic("go");
}

ascend_ascend_state() {
  var_0 = 500;

  if(gettime() - level.start_ascend_time > var_0) {
    if(!level.player attackbuttonpressed()) {
      level.ascend_state = "stop";
      level.ascend_state_transition = 1;
    }
  }

  if(!common_scripts\utility::flag("flag_bravo_ascend_complete")) {
    var_1 = 3.0;
    level.ascend_target_rate = level.ascend_anims_rate + (level.ascend_anims_rate - level.bravo_curr_rate) / var_1;
  } else
    level.ascend_target_rate = level.ascend_anims_rate;
}

ascend_stop_state_transition() {
  level.ascend_state_transition = 0;
  level.stop_ascend_time = gettime();
  level.ascend_target_rate = 0.0;
  common_scripts\utility::flag_clear("flag_player_ascending");
  level.player_rig setanimrestart(level.scr_anim["player_rig"]["rig_ascend_stop"]);
  level.player_legs setanimrestart(level.scr_anim["player_legs_ascend"]["rig_ascend_stop"]);
  thread maps\black_ice_audio::sfx_rig_ascend_logic("stop");
}

ascend_stop_state() {
  var_0 = 500;

  if(gettime() - level.stop_ascend_time > var_0) {
    level.ascend_state = "idle";
    level.ascend_state_transition = 1;
  }
}

ascend_pendulum(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5))
    level endon(var_5);

  var_6 = var_0.angles[0];
  var_7 = var_0.angles[1];
  var_8 = var_0.angles[2];
  var_9 = 0.0;
  var_10 = 0.0;
  var_11 = 0.0;
  var_12 = 0.015;
  var_13 = 385.73;
  var_14 = 1240.0;
  var_15 = 300.0;
  var_16 = 100.0;
  var_17 = var_16 / 360.0;
  var_18 = 0.0;
  var_19 = var_15;
  var_20 = 0.0;
  var_21 = 0.0;
  var_22 = 0.0;

  if(isDefined(var_4) && var_4 > 0.0) {
    var_19 = var_4;
    var_20 = sqrt(var_13 / var_19);
    var_21 = var_17 * var_20;
    var_22 = 1.0 / var_21;
  }

  while(!common_scripts\utility::flag_exist("flag_common_breach") || !common_scripts\utility::flag("flag_common_breach")) {
    if(!isDefined(var_4)) {
      var_23 = level.player_rig getanimtime(level.scr_anim["player_rig"]["alpha_rig_ascend"]);
      var_19 = (1.0 - var_23) * var_14;

      if(var_19 < var_15)
        var_19 = var_15;

      var_20 = sqrt(var_13 / var_19);
      var_21 = var_17 * var_20;
      var_22 = 1.0 / var_21;
    }

    if(var_18 > var_22)
      var_18 = var_18 - var_22;

    var_24 = var_20 * var_18 * var_16;
    var_9 = var_9 + (var_1 - var_9) * var_12;
    var_25 = var_9 * sin(var_24 + 90);
    var_10 = var_10 + (var_2 - var_10) * var_12;
    var_26 = var_10 * sin(var_24 + 90);
    var_11 = var_11 + (var_3 - var_11) * var_12;
    var_27 = var_11 * sin(var_24);
    var_0.angles = (var_6 + var_25, var_7 + var_26, var_8 + var_27);
    var_18 = var_18 + level.timestep;
    wait(level.timestep);
  }

  var_0 notify("notify_pendular_motion_complete");
}

hanging_cargo_motion() {
  var_0 = 3;
  thread maps\black_ice_audio::sfx_cargo_sway();
  var_1 = spawn("script_model", (-1449, 3698, 1490));

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = getent("hanging_cargo_node_" + var_2, "script_noteworthy");
    var_4 = getEntArray("hanging_cargo_" + var_2, "targetname");
    var_5 = 0.0;

    if(var_4.size) {
      var_6 = 0.0;

      for(var_7 = 0; var_7 < var_4.size; var_7++) {
        var_4[var_7] linkto(var_3);

        if(isDefined(var_4[var_7].target)) {
          var_8 = getent(var_4[var_7].target, "targetname");
          var_8 linkto(var_4[var_7]);
        }

        var_6 = var_6 + var_4[var_7].origin[2];

        if(var_2 == 2)
          var_4[var_7] retargetscriptmodellighting(var_1);
      }

      var_6 = var_6 / var_4.size;
      var_9 = (var_4[0].origin[0], var_4[0].origin[1], var_6);
      var_5 = length(var_3.origin - var_9);
    }

    thread ascend_pendulum(var_3, randomfloatrange(0.975, 1.275), randomfloatrange(4.0, 6.0), randomfloatrange(0.3, 0.6), var_5);
    thread hanging_cargo_cleanup(var_3, var_4);

    if(isDefined(var_3.targetname) && var_3.targetname == "hanging_cargo_ascend")
      thread hanging_cargo_ascension(var_3);
  }
}

hanging_cargo_ascension(var_0) {
  common_scripts\utility::flag_wait("flag_mid_start");
  var_1 = var_0.origin + (0, 0, 1000);
  var_2 = 30.0;
  var_0 moveto(var_1, var_2, 1.0, 0.0);
  thread maps\black_ice_audio::sfx_cargo_lift(var_0);
  wait(var_2 / 2.0);
  thread maps\black_ice_audio::sfx_cargo_hatch();
  var_3 = 5.0;
  var_4 = getent("left_cargo_elevator_door_1", "targetname");
  var_5 = getent("left_cargo_elevator_door_2", "targetname");
  var_4 moveto(var_4.origin + (0, 226, 0), var_3, 0.0, 0.0);
  var_5 moveto(var_5.origin + (0, -226, 0), var_3, 0.0, 0.0);
}

hanging_cargo_cleanup(var_0, var_1) {
  var_0 waittill("notify_pendular_motion_complete");

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] delete();

  var_0 delete();
}

post_ascend_cleanup() {
  while(!level.player_rig maps\black_ice_util::check_anim_time("player_rig", "alpha_rig_ascend", 1.0))
    wait(level.timestep);

  while(!common_scripts\utility::flag("flag_alpha_ascend_complete") || !common_scripts\utility::flag("flag_bravo_ascend_complete"))
    wait(level.timestep);

  common_scripts\utility::flag_set("sfx_ascend_done");
  common_scripts\utility::flag_set("flag_ascend_end");
  maps\_utility::stop_exploder("basecamp_snow");
  maps\black_ice_util::player_animated_sequence_cleanup();
  level.ascend_anim_node = undefined;
  level.bravo_ascend_anim_node = undefined;
  level.player_ascend_anim_node = undefined;
  level.player_legs delete();
  level.player_legs = undefined;
  level.allow_player_ascend_move = undefined;
  level.ascend_current_rate = undefined;
  level.bravo_curr_rate = undefined;
  level.alpha_curr_rate = undefined;
}

hint_ascend_init_func() {
  return !common_scripts\utility::flag("hint_ascend_init");
}

hint_ascend_func() {
  return common_scripts\utility::ter_op(level.player attackbuttonpressed(), 1, 0);
}

notetrack_fire_shake(var_0) {
  earthquake(0.4, 0.5, level.player.origin, 2048);
  level.player playrumbleonentity("pistol_fire");
}

notetrack_takeoff(var_0) {
  earthquake(0.3, 1.0, level.player.origin, 2048);
  level.player playrumbleonentity("grenade_rumble");
}

notetrack_shake_start(var_0) {}

notetrack_shake_stop(var_0) {}

ascend_mblur_changes() {
  common_scripts\utility::flag_wait("flag_player_ascending");

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", 0);
    setsaveddvar("r_mbCameraRotationInfluence", 0.07);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.15);
    setsaveddvar("r_mbModelVelocityScalar", 0.09);
    setsaveddvar("r_mbStaticVelocityScalar", 0.03);
    setsaveddvar("r_mbViewModelEnable", 1);
    setsaveddvar("r_mbViewModelVelocityScalar", 0.004);
  }

  common_scripts\utility::flag_wait("flag_ascend_end");

  if(maps\_utility::is_gen4())
    maps\black_ice::set_default_mb_values();
}