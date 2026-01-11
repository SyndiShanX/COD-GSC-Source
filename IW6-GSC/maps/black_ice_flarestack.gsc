/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_flarestack.gsc
*****************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_flarestack_scene_start");
  common_scripts\utility::flag_init("flag_flarestack_dialogue_start");
  common_scripts\utility::flag_init("flag_flarestack_end");
  common_scripts\utility::flag_init("flag_flamestack_alarm_light");
  common_scripts\utility::flag_init("flag_flarestack_player_pressed_button");
  common_scripts\utility::flag_init("flag_flarestack_button_active");
  common_scripts\utility::flag_init("flag_flarestack_leave");
}

section_precache() {
  maps\_utility::add_hint_string("hint_flarestack_button_press", &"BLACK_ICE_COMMAND_USE_CONSOLE", ::hint_button_press);
}

hint_button_press() {
  return !common_scripts\utility::flag("hint_flarestack_button_press");
}

section_post_inits() {
  level._flarestack = spawnStruct();
  level._flarestack.scene_struct = common_scripts\utility::getstruct("struct_flarestack_ally1", "targetname");

  if(isDefined(level._flarestack.scene_struct)) {
    level._flarestack.door_in = maps\black_ice_util::setup_door("model_flarestack_inside_door", "flarestack_door_in");
    level._flarestack.scene_struct maps\_anim::anim_first_frame_solo(level._flarestack.door_in, "flarestack_start");
    level._flarestack.door_in.original_origin = level._flarestack.door_in.origin;
    level._flarestack.door_out = maps\black_ice_util::setup_door("model_flarestack_outside_door", "flarestack_door_out", "jnt_door");
    level._flarestack.scene_struct maps\_anim::anim_first_frame_solo(level._flarestack.door_out, "flarestack_exit");

    if(level.start_point != "refinery") {
      thread maps\black_ice_fx::turn_on_flarestack_fx();
      thread maps\black_ice_fx::flarestack_turn_on_console_fx();
    }
  } else
    iprintln("black_ice_flarestack.gsc: Warning - Flarestack scene struct missing (compiled out?)");
}

start() {
  iprintln("Flare Stack");
  maps\black_ice_util::player_start("player_start_flarestack");
  var_0 = ["struct_ally_start_flarestack_01", "struct_ally_start_flarestack_02"];
  level._allies maps\black_ice_util::teleport_allies(var_0);
  common_scripts\utility::flag_set("flag_flarestack_dialogue_start");
}

main() {
  wait 0.05;
  setsaveddvar("r_snowAmbientColor", (0.02, 0.02, 0.03));
  thread event_pressure_buildup();
  thread light_flamestack();
  thread light_hall_light();
  thread light_alarm_lights();
  thread flamestack_godrays();
  thread dialogue();
  thread maps\black_ice_audio::sfx_flare_stack_burn();
  common_scripts\utility::exploder("flamestack_snow");
  common_scripts\utility::exploder("refinery_lights_b");
  thread event_player_turns_key();
  thread event_scan_manager();
  thread event_switch_animation();
  thread allies();
  thread fx_door_open();
  common_scripts\utility::flag_wait("flag_flarestack_end");
  maps\_utility::activate_trigger_with_targetname("trig_refinery_ally_1_start");
  thread maps\black_ice_audio::sfx_exited_flarestack();
  thread maps\black_ice::trains_periph_logic(6.0, 1);
  thread flarestack_door_close();
}

dialogue() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::flag_wait("flag_flarestack_dialogue_enter");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_mrk_pressureregulatorsare");
  common_scripts\utility::flag_wait("flag_flarestack_dialogue_start");
  thread dialogue_foreman();
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_theforeman");
  level notify("notify_dialogue_baker_enter_complete");
  thread dialogue_nag();
  level waittill("notify_flarestack_enemy_on_console");
  wait 4;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_shutitdown");
  level._flarestack.foreman thread dialogue_foreman_line2();
  level waittill("notify_flarestack_baker_pistol_fire");
  wait 1;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_bravoflarestacksoff");
  common_scripts\utility::flag_set("flag_flarestack_leave");
  maps\_utility::smart_radio_dialogue("black_ice_diz_rogerthatalphawereclear");
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_alrightletsheadtopside");
  level._allies[0] thread maps\_utility::smart_dialogue("black_ice_bkr_stayfrostydonot");
  common_scripts\utility::flag_set("flag_flarestack_end");
}

dialogue_foreman() {
  while(!isDefined(level._flarestack.foreman)) {
    wait 0.05;
  }

  level._flarestack.foreman thread dialogue_foreman_line1();
  level._flarestack.foreman thread dialogue_foreman_line3();
}

dialogue_foreman_line1() {
  level waittill("black_ice_saf2_whatareyoudoing");
  level._flarestack.foreman maps\_utility::smart_dialogue("black_ice_saf2_whatareyoudoing");
}

dialogue_foreman_line2() {
  wait 0.7;
  level._flarestack.foreman maps\_utility::smart_dialogue("black_ice_saf2_nononodontdoit");
}

dialogue_foreman_line3() {
  level waittill("black_ice_saf2_shitwhatareyou");
  level._flarestack.foreman maps\_utility::smart_dialogue("black_ice_saf2_shitwhatareyou");
}

dialogue_nag() {
  level endon("flag_flarestack_player_pressed_button");
  level waittill("notify_activate_flarestack_console");
  wait 8;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_gotoconsole");
  wait 8;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_shutdownflare");
  wait 8;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_theconsolenow");
  wait 8;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_consoleandshut");
}

allies() {
  common_scripts\utility::array_call(level._allies, ::pushplayer, 1);
  common_scripts\utility::array_thread(level._allies, maps\black_ice_util::set_forcesuppression, 1);
  level._allies[1] thread allies_hesh_final_position();
  level._allies[0] event_flarestack_enter();
  common_scripts\utility::flag_wait("flag_flarestack_leave");
  level._allies[0] thread allies_baker_flarestack_exit();
  level._allies[0] maps\black_ice_util::set_forcesuppression(0);
}

allies_hesh_final_position() {
  var_0 = getnode("node_flarestack_fuentes_exit", "targetname");
  common_scripts\utility::flag_wait("flag_flarestack_player_pressed_button");
  self setgoalnode(var_0);
}

allies_baker_flarestack_exit() {
  var_0 = level._flarestack.scene_struct;
  var_1 = level._flarestack.door_out;
  self notify("stop_loop");
  var_2 = [self, var_1];
  thread maps\black_ice_audio::sfx_flarestack_door_open();
  var_0 maps\_anim::anim_single(var_2, "flarestack_exit");
  var_1.col_brush connectpaths();
  maps\_utility::enable_ai_color();
  wait 0.2;
  var_3 = getent("brush_flarestack_player_door_blocker", "targetname");
  var_3 moveto(var_3.origin + (0, 0, 1024), 0.05);
}

event_flarestack_enter() {
  var_0 = level._flarestack.scene_struct;
  var_1 = level._flarestack.door_in;
  maps\_utility::activate_trigger_with_targetname("trig_flarestack_ally1_start");
  level waittill("notify_dialogue_baker_enter_complete");
  common_scripts\utility::flag_wait("flag_flarestack_scene_start");
  maps\black_ice_util::ignore_everything();
  var_2 = getent("enemy_flarestack", "targetname") maps\_utility::spawn_ai(1, 1);
  var_2.animname = "flarestack_guy";
  var_2.v.nogun = 1;
  var_2.v.invincible = 1;
  var_2.nodrop = 1;
  level._flarestack.foreman = var_2;
  var_0 maps\_anim::anim_first_frame_solo(var_2, "flarestack_start");
  level._flarestack.flarestack_controller = var_2;
  var_2 maps\_utility::delaythread(2, ::event_flarestack_enter_fail_watcher);
  var_0 maps\_anim::anim_reach_solo(self, "flarestack_start");
  var_1 thread event_flarestack_enter_close_door();
  var_0 thread maps\black_ice_vignette::vignette_single_solo(var_2, "flarestack_start", "flarestack_idle", undefined, "flarestack_end");
  var_0 thread maps\black_ice_vignette::vignette_single_solo(self, "flarestack_start", "flarestack_idle", "flarestack_end");
  var_0 thread maps\_anim::anim_single_solo(var_1, "flarestack_start");
  var_1.col_brush connectpaths();
  thread maps\black_ice_audio::sfx_baker_fight_scene();
  self waittill("msg_vignette_start_anim_done");
  level notify("notify_dialogue_clearance_start");
  level waittill("notify_flare_stack_off");
  maps\black_ice_vignette::vignette_interrupt();
  var_2 maps\black_ice_vignette::vignette_kill();
  level waittill("notify_flarestack_baker_pistol_pullout");
  self playSound("scn_blackice_command_baker_pullout");
  var_3 = maps\_utility::spawn_anim_model("baker_sidearm", self gettagorigin("TAG_INHAND"));
  var_3.angles = self gettagangles("TAG_INHAND");
  var_3 linkto(self, "TAG_INHAND");
  level waittill("notify_flarestack_baker_pistol_fire");
  playFXOnTag(common_scripts\utility::getfx("headshot_blood"), var_3, "tag_flash");
  playFXOnTag(common_scripts\utility::getfx("pistol_shot_smoke"), var_3, "tag_flash");
  common_scripts\utility::exploder("flarestack_headshot");
  var_4 = var_3 gettagorigin("tag_flash");
  var_5 = spawn("script_origin", var_4);
  var_6 = var_4 + anglesToForward(var_3.angles) * 128;
  magicbullet("m9a1", var_4, var_6);
  var_5 playSound("scn_blackice_flarestack_kill");
  var_2 playSound("scn_blackice_command_baker_kill");
  level waittill("notify_flarestack_baker_pistol_putaway");
  var_3 delete();
  var_5 delete();
  self waittill("msg_vignette_interrupt_break_done");
  maps\black_ice_util::cover_left_idle("node_flarestack_baker_exit");
}

event_flarestack_enter_fail_watcher() {
  level endon("flag_flarestack_player_pressed_button");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 != "MOD_IMPACT") {
      break;
    }
  }

  setdvar("ui_deadquote", &"BLACK_ICE_FLARESTACK_FAIL_ENEMY_KILL");
  level.player setclienttriggeraudiozone("blackice_flarestack_fail", 0.1);
  maps\_utility::missionfailedwrapper();
}

event_flarestack_enter_close_door() {
  var_0 = getnode("node_flarestack_ally2_start", "targetname");
  common_scripts\utility::flag_wait("flag_flarestack_player_pressed_button");
  level._allies[1] forceteleport(var_0.origin, var_0.angles);
  self.angles = self.original_angles;
  self.origin = level._flarestack.door_in.original_origin;
  wait 0.05;
  self.col_brush disconnectpaths();
}

event_player_turns_key() {
  thread audio_start_pressure();
  var_0 = common_scripts\utility::getstruct("struct_flarestack_player", "targetname");
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_0 maps\_anim::anim_first_frame_solo(var_1, "turn_off_flare_stack");
  var_1 hide();
  level waittill("notify_activate_flarestack_console");
  maps\black_ice_util::waittill_trigger_activate_looking_at(level._flarestack.console, "hint_flarestack_button_press");
  common_scripts\utility::flag_set("flag_flarestack_player_pressed_button");
  thread maps\black_ice_audio::sfx_use_console();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowmelee(0);
  var_2 = level.player getcurrentweapon();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  var_3 = 0.6;
  level.player playerlinktoblend(var_1, "tag_player", var_3);
  thread util_show_rig_after_blend(var_3, var_1);
  var_0 thread maps\_anim::anim_single_solo(var_1, "turn_off_flare_stack");
  level waittill("notify_player_draw_weapon");
  level.player enableweapons();
  level.player switchtoweaponimmediate(var_2);
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level waittill("notify_player_unlink");
  level.player unlink();
  var_1 delete();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowmelee(1);
}

fx_console_button_light(var_0) {
  playFXOnTag(common_scripts\utility::getfx("console_light_blink"), var_0, "tag_fx_button");
  level waittill("notify_flare_stack_button_press");
  stopFXOnTag(common_scripts\utility::getfx("console_light_blink"), var_0, "tag_fx_button");
  level.player playrumbleonentity("damage_light");
}

util_show_rig_after_blend(var_0, var_1) {
  wait(var_0);
  var_1 show();
}

light_hall_light() {
  var_0 = getEntArray("flarestack_hallway_1", "targetname");
  common_scripts\utility::flag_wait("flag_flarestack_player_pressed_button");

  foreach(var_2 in var_0) {
    var_2 setlightintensity(0.01);
    var_2 setlightradius(12);
  }
}

light_alarm_lights() {
  var_0 = getEntArray("flarestack_light_siren", "targetname");
  var_1 = getEntArray("flarestack_light_siren_off", "targetname");
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = var_5 gettagorigin("TAG_fx_main");
    var_6.angles = var_5 gettagangles("TAG_fx_main");
    var_6 linkto(var_5, "TAG_fx_main");
    var_2[var_3] = var_6;
    var_5 hide();
    var_3++;
  }

  var_8 = getEntArray("flarestack_emergency_1", "targetname");
  level waittill("notify_stop_flare_stack");
  wait 6.0;
  thread maps\black_ice_audio::sfx_start_flarestack_room_siren();

  for(;;) {
    if(common_scripts\utility::flag("flag_flamestack_alarm_light")) {
      foreach(var_5 in var_0) {
      var_5 show();
      }

      foreach(var_5 in var_1) {
      var_5 hide();
      }

      foreach(var_14 in var_2) {
      playFXOnTag(level._effect["flarestack_siren_red"], var_14, "tag_origin");
      }

      foreach(var_5 in var_8) {
      var_5 setlightintensity(2.0);
      }
    }

    wait 1;

    foreach(var_5 in var_0) {
    var_5 hide();
    }

    foreach(var_5 in var_1) {
    var_5 show();
    }

    foreach(var_14 in var_2) {
    stopFXOnTag(level._effect["flarestack_siren_red"], var_14, "tag_origin");
    }

    foreach(var_5 in var_8) {
    var_5 setlightintensity(0.01);
    }

    wait 0.5;
  }
}

audio_start_pressure() {
  level waittill("notify_stop_flare_stack");
  thread maps\black_ice_audio::audio_derrick_explode_logic("start");
  level waittill("notify_flare_stack_button_press");
}

flamestack_godrays() {
  var_0 = getent("origin_flarestack_fx", "targetname");

  if(maps\_utility::is_gen4()) {
    maps\black_ice_util::god_rays_from_world_location(var_0.origin, "flag_flarestack_scene_start", "flag_flarestack_player_pressed_button", "black_ice_flamestack", undefined);
  }
}

light_flamestack() {
  var_0 = getent("flarestack_window_1", "targetname");
  var_0 setlightintensity(2.5);
  common_scripts\utility::flag_wait("flag_flarestack_scene_start");
  var_0 light_flamestack_flicker();
  var_0 setlightintensity(3.0);
  wait 0.1;
  var_0 setlightcolor((0.68, 0.81, 0.82));
  var_0 setlightintensity(0.8);
  maps\_art::sunflare_changes("mudpumps", 0.1);
  maps\_utility::vision_set_fog_changes("black_ice_refinery", 6);
}

light_flamestack_flicker() {
  var_0 = self getlightintensity();
  level endon("flag_flarestack_player_pressed_button");

  for(;;) {
    self setlightintensity(var_0);
    wait 0.07;
    self setlightintensity(var_0 * 0.9);
    wait 0.05;
    self setlightintensity(var_0 * 0.85);
    wait 0.1;
    self setlightintensity(var_0 * 0.9);
    wait 0.05;
    self setlightintensity(var_0);
    wait 0.05;
    self setlightintensity(var_0 * 0.85);
    wait 0.05;
    self setlightintensity(var_0 * 0.75);
    wait 0.075;
    self setlightintensity(var_0 * 0.85);
    wait 0.1;
    self setlightintensity(var_0);
    wait 0.05;
  }
}

event_pressure_buildup() {
  level waittill("notify_flare_stack_off");
  event_pressure_buildup_start();
}

event_pressure_buildup_start(var_0) {
  var_1 = common_scripts\utility::getstruct("struct_rumble_dist", "targetname");
  var_2 = 0.0;

  if(!isDefined(var_0)) {
    var_0 = 9.0;
  }

  var_3 = 0.11;
  var_4 = 0.05;
  var_5 = 1000;
  var_6 = 200;
  var_7 = 3.0;
  var_8 = 0.4;
  var_9 = 0.12;
  var_10 = 0.18;
  var_11 = 0.18;
  var_12 = 0.25;
  var_13 = 0.7;
  var_14 = 1.1;
  var_15 = randomfloatrange(var_8, var_7);
  var_16 = 1.0;
  var_17 = var_0 - level.timestep;

  for(;;) {
    var_18 = distance(level.player.origin, var_1.origin);
    var_2 = maps\black_ice_util::normalize_value(var_6, var_5, var_18);
    var_19 = maps\black_ice_util::factor_value_min_max(var_3, var_4, var_2);
    var_20 = maps\black_ice_util::factor_value_min_max(var_11, var_9, var_2);
    var_21 = maps\black_ice_util::factor_value_min_max(var_12, var_10, var_2);

    if(var_17 > 0) {
      var_16 = maps\black_ice_util::normalize_value(0.0, var_0, var_17);
      var_16 = 1 - var_16;
    } else
      var_16 = 1.0;

    var_19 = var_19 * var_16;
    earthquake(var_19, 0.2, level.player.origin, 128);

    if(var_15 < 0.0) {
      var_15 = randomfloatrange(var_8, var_7);
      var_22 = randomfloatrange(var_13, var_14);
      var_23 = randomfloatrange(var_20, var_21);
      var_23 = var_23 * var_16;
      earthquake(var_23, var_22, level.player.origin, 128);
      thread maps\black_ice_audio::sfx_screenshake();
    }

    if(common_scripts\utility::flag("flag_derrick_exploded")) {
      break;
    }

    wait(level.timestep);
    var_17 = var_17 - level.timestep;
    var_15 = var_15 - level.timestep;
  }
}

fx_door_open() {
  level waittill("notify_flamestack_door_open");
  common_scripts\utility::exploder("flamestack_door_open");
  maps\_utility::stop_exploder("barracks_ambfx");
  maps\_utility::stop_exploder("common_room_ambfx");
}

event_scan_manager() {
  level waittill("notify_flarestack_start_scan");
  thread maps\black_ice_audio::sfx_hand_scan();
  common_scripts\utility::exploder("flamestack_scan_on");
  wait 4.75;
  level notify("notify_activate_flarestack_console");
  level waittill("notify_refinery_explosion_start");
  maps\_utility::stop_exploder("flamestack_scan_on");
}

event_switch_animation() {
  var_0 = getent("flarestack_shutoff_button", "targetname");
  level._flarestack.console = var_0;
  var_0 maps\_utility::assign_animtree("flare_stack_console");
  var_0 maps\_anim::anim_first_frame_solo(var_0, "console_open");
  level waittill("notify_activate_flarestack_console");
  var_0 thread maps\_anim::anim_single_solo(var_0, "console_open");
  wait 1.2;
  thread fx_console_button_light(var_0);
  level waittill("notify_console_flip_switch");
  var_0 thread maps\_anim::anim_single_solo(var_0, "turn_off_flare_stack");
}

fx_flarestack_motion() {
  var_0 = getEntArray("flamestack_anim", "targetname");
  var_1 = getent("flarestack_anim_node", "script_noteworthy");
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();

  foreach(var_4 in var_0) {
  var_4 linkto(var_2);
  }

  wait 0.5;
  var_2 vibrate((1, 0, 0), 0.2, 1.7, 1.0);
  level waittill("flamestack_steam_vent");
  var_2 vibrate((1, 0, 0), 0.5, 1.0, 1.0);
  wait 1.0;
  var_2 vibrate((1, 0, 0), 0.75, 0.7, 0.7);
  wait 0.7;
  var_2 vibrate((1, 0, 0), 0.5, 1.0, 1.0);
  wait 1.0;
  var_2 vibrate((1, 0, 0), 0.25, 1.0, 1.0);
  wait 1.0;
  var_2 vibrate((1, 0, 0), 0.1, 1.0, 1.0);
  wait 1.0;
  var_2 vibrate((1, 0, 0), 0.01, 1.0, 1.0);
}

flarestack_door_close() {
  level waittill("notify_refinery_explosion_start");
  level._flarestack.door_out maps\black_ice_util::close_door();
}