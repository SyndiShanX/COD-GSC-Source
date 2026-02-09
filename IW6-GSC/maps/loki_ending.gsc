/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_ending.gsc
*****************************************************/

section_

section_

section_flag_inits() {
  common_scripts\utility::flag_init("ending_start");
  common_scripts\utility::flag_init("player_flipped_switch");
  common_scripts\utility::flag_init("final_rog_fired");
  common_scripts\utility::flag_init("player_flipped_switch_anim_done");
  common_scripts\utility::flag_init("ending_init_done");
  common_scripts\utility::flag_init("wait_for_return_node");
  common_scripts\utility::flag_init("ally_has_moved");
  common_scripts\utility::flag_init("ending_checkpoint_start");
  common_scripts\utility::flag_init("ending_bink_ready");
  common_scripts\utility::flag_init("bink_no_longer_fullscreen");
  common_scripts\utility::flag_init("DEBUG_dont_fail");
  common_scripts\utility::flag_init("failed_to_fire");
}

ending_start() {
  common_scripts\utility::flag_set("ending_checkpoint_start");
  setsaveddvar("cg_cinematicFullScreen", "1");
  setsaveddvar("cg_cinematicCanPause", "1");
  maps\loki_util::player_move_to_checkpoint_start("rog");
  maps\loki_util::spawn_allies();
  thread maps\loki_fx::loki_ending_lighting();
  thread maps\loki_audio::audio_set_ending_ambience();

  foreach(var_1 in level.allies)
  var_1 maps\_utility::disable_ai_color();

  thread maps\loki_space_breach::set_flags_on_input();

  if(!isDefined(level.center1))
    maps\loki_space_breach::get_center(1);

  if(!isDefined(level.center2))
    maps\loki_space_breach::get_center(2);

  var_3 = spawn("script_origin", level.center1.origin);
  common_scripts\utility::waitframe();
  var_3.origin = var_3.origin + (-65, 15, 20);
  var_3.angles = level.center1.angles;
  maps\loki_space_breach::create_rog_controls();
  level thread ending_bink_display();
  common_scripts\utility::flag_set("ROG_exit");
  maps\loki_rog::show_hide_all_static(0);
}

ending() {
  if(common_scripts\utility::flag("ending_checkpoint_start"))
    ending_init();

  ending_sequence();
}

ending_sequence() {
  thread maps\loki_audio::audio_set_ending_ambience();
  thread maps\loki_audio::sfx_ending_bink_connecting();
  common_scripts\utility::flag_set("ending_start");

  if(common_scripts\utility::flag("ending_checkpoint_start")) {
    get_player_ready_to_look_at_screen();
    level thread maps\loki_space_breach::rotate_control_room_top(level.controlroom_top_1, level.breach_anim_node.origin);
  }

  thread maps\loki_fx::loki_ending_lighting();
  level.space_breathing_enabled = 1;
  level.player disableweapons();
  level thread ending_autosave();
  thread maps\loki_audio::sfx_wait_to_play_ending_sound();
  var_0 = level.player_rig;
  common_scripts\utility::flag_set("ending_init_done");
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 25, 50, 60, 15, 1);
  wait 0.1;
  stopallrumbles();

  if(common_scripts\utility::flag("ending_checkpoint_start"))
    level thread ending_ally_anims();

  level thread ending_dialogue_new();
  level thread fire_final_rod();
  end_level();
}

ending_init() {
  if(!isDefined(level.player_rig))
    level.player_rig = create_player_rig();

  while(!isDefined(level.player_rig))
    common_scripts\utility::waitframe();

  if(!isDefined(level.breach_anim_node))
    maps\loki_space_breach::create_anim_node();

  while(!isDefined(level.breach_anim_node))
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_wait("ending_bink_ready");
}

get_player_ready_to_look_at_screen() {
  ending_init();
  var_0 = [];
  var_0["player_rig"] = level.player_rig;
  level.breach_anim_node thread maps\_anim::anim_loop(var_0, "breach_rog_controls_wait_loop");
  common_scripts\utility::flag_wait("ROG_exit");
  common_scripts\utility::waitframe();
  var_1 = 0;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  common_scripts\utility::flag_wait("bink_no_longer_fullscreen");
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 25, 50, 60, 15, 1);
}

ending_fadeup() {
  var_0 = 0.0;
  var_1 = 3.0;
  var_2 = 1.5;
  level thread maps\loki_rog::black_fade(var_0, var_1, var_2);
  wait(var_2);
}

ending_fade_out() {
  var_0 = 0.0;
  var_1 = 10.0;
  var_2 = 0.0;
  level thread maps\loki_rog::black_fade(var_0, var_1, var_2);
  wait(var_0 + 1);
}

create_player_rig() {
  if(!isDefined(level.center1))
    maps\loki_space_breach::get_center(1);

  if(!isDefined(level.center2))
    maps\loki_space_breach::get_center(2);

  var_0 = spawn("script_origin", level.center1.origin);
  var_0.angles = level.center1.angles;
  var_0.origin = var_0.origin + (-65, 15, 20);
  var_1 = maps\_utility::spawn_anim_model("player_rig", var_0.origin);
  return var_1;
}

ending_ally_anims() {
  if(!isDefined(level.breach_anim_node))
    maps\loki_space_breach::create_anim_node();

  while(!isDefined(level.breach_anim_node))
    common_scripts\utility::waitframe();

  level.allies[0] stopanimscripted();
  level.allies[1] stopanimscripted();
  level.breach_anim_node notify("stop_loop");
  common_scripts\utility::waitframe();
  var_0 = [];
  var_0["ally_1"] = level.allies[1];
  level.breach_anim_node thread maps\_anim::anim_loop(var_0, "rog_intro");
  var_0 = [];
  var_0["ally_0"] = level.allies[0];
  level.breach_anim_node maps\_anim::anim_first_frame(var_0, "end");

  if(!common_scripts\utility::flag("ending_checkpoint_start"))
    wait 4.5;

  thread maps\loki_audio::sfx_loki_npc_monitor_foley(level.allies[0]);
  common_scripts\utility::waitframe();
  level.breach_anim_node maps\_anim::anim_single(var_0, "end");
  common_scripts\utility::flag_set("ally_has_moved");
  level.breach_anim_node maps\_anim::anim_loop(var_0, "end_loop");
}

ending_bink_display() {
  setsaveddvar("cg_cinematicCanPause", "0");
  setsaveddvar("cg_cinematicFullScreen", "0");
  stopcinematicingame();
  common_scripts\utility::waitframe();
  maps\loki_util::loki_autosave_now();
  maps\loki_rog::show_hide_all_static(0);
  cinematicingamesync("loki_ending_train");
  wait 0.2;
  pausecinematicingame(1);
  common_scripts\utility::flag_set("ending_bink_ready");
  common_scripts\utility::flag_wait("ROG_exit");

  if(common_scripts\utility::flag("ending_checkpoint_start"))
    level thread maps\loki_rog::static_flash(2);

  wait 0.2;
  setsaveddvar("cg_cinematicFullScreen", "1");
  pausecinematicingame(0);
  common_scripts\utility::waitframe();
  common_scripts\utility::waitframe();
  maps\loki_rog::show_hide_all_static(0);
  wait 1.25;
  setsaveddvar("cg_cinematicFullScreen", "0");
  setsaveddvar("cg_cinematicCanPause", "0");
  maps\loki_rog::show_hide_all_static(0);
  thread maps\loki_audio::sfx_ending_bink();
  common_scripts\utility::flag_set("bink_no_longer_fullscreen");
  level waittill("player_flipped_switch_anim_done");
  maps\loki_rog::show_hide_all_static(1);
  stopcinematicingame();
  cinematicingameloopresident("loki_rog_intro_launching_missiles");

  while(!iscinematicplaying())
    wait 0.1;

  common_scripts\utility::waitframe();
  common_scripts\utility::waitframe();
  maps\loki_rog::show_hide_all_static(0);
}

ending_autosave() {
  common_scripts\utility::flag_wait("bink_no_longer_fullscreen");
}

ending_dialogue_new() {
  common_scripts\utility::flag_wait("ending_start");
  common_scripts\utility::flag_wait("ending_init_done");
  thread maps\_utility::smart_radio_dialogue("loki_mrk_icarusactualdoyou");
  level.allies[0] maps\_utility::waittill_notetrack_or_damage("vo_loki_gs3_affirmativecommand");
  var_0 = lookupsoundlength("loki_gs3_affirmativecommand");
  wait(var_0 / 1000);
  thread maps\_utility::smart_radio_dialogue("loki_mrk_belaypreviousordertarget_2");
  level.allies[0] maps\_utility::waittill_notetrack_or_damage("vo_loki_gs3_wearestillreading");
  var_0 = lookupsoundlength("loki_gs3_wearestillreading");
  wait(var_0 / 1000);
  thread maps\loki_audio::sfx_loki_ending_charging_start();
  thread maps\_utility::smart_radio_dialogue("loki_mrk_confirmedfireonthe");
  level.allies[0] maps\_utility::waittill_notetrack_or_damage("vo_loki_gs3_targetingconfirmedcommand_2");
  var_0 = lookupsoundlength("loki_gs3_targetingconfirmedcommand_2");
  wait(var_0 / 1000);
  level thread start_end_fail_timer(15);
  level notify("waiting_for_player_to_fire");
  var_1 = ["loki_us3_thompsonfireforeffect", "loki_us3_thompsonthesatsare", "loki_us3_firenow"];
  level.allies[0] thread maps\loki_space_breach::play_nag_after_delay(4.0, var_1, "player_flipped_switch", 1);
  maps\loki_util::waittill_fire_trigger_activate("press_to_fire", 1, "failed_to_fire");
  var_2 = getent("rog_terminal", "targetname");
  common_scripts\utility::flag_set("player_flipped_switch");
  level.allies[0] notify("stop nags");
}

player_anim_fire_rog() {
  var_0 = [];
  var_0["player_rig"] = level.player_rig;
  level.breach_anim_node maps\_anim::anim_single(var_0, "end_button_push");
}

fire_hint_button_press() {
  return !common_scripts\utility::flag("press_to_fire");
}

fire_final_rod() {
  common_scripts\utility::flag_wait("player_flipped_switch");
  thread player_anim_fire_rog();
  wait 3.75;
  common_scripts\utility::flag_set("player_flipped_switch_anim_done");
  common_scripts\utility::flag_set("final_rog_fired");
}

fire_rods() {
  var_0 = getEntArray("pretarget_rog_sats", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = "tag_rogfx_01";
    playFXOnTag(common_scripts\utility::getfx("loki_rog_trail_close_2_emit"), var_2, var_3);
  }
}

start_end_fail_timer(var_0) {
  if(!common_scripts\utility::flag("DEBUG_dont_fail")) {
    wait(var_0 - 1);

    if(!common_scripts\utility::flag("player_flipped_switch")) {
      common_scripts\utility::flag_set("failed_to_fire");
      thread maps\loki_audio::sfx_laptop_ending_fail();
      maps\loki_rog::show_hide_all_static(1);
      wait 1.0;
      setDvar("ui_deadquote", &"LOKI_ENDING_FAIL");
      level thread maps\_utility::missionfailedwrapper();
    }
  }
}

end_level() {
  common_scripts\utility::flag_wait("final_rog_fired");
  thread ending_fade_out();
  wait 0.1;
  setsaveddvar("hud_drawhud", 0);
  wait 1.9;
  maps\_utility::nextmission();
}