/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_hangar_intro.gsc
****************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_hangar_start");
  common_scripts\utility::flag_init("flag_hangar_door_open");
  common_scripts\utility::flag_init("flag_hangar_screen_smash");
  common_scripts\utility::flag_init("flag_rooftop_queue_tunnel");
  common_scripts\utility::flag_init("flag_breach_final_tracks");
  common_scripts\utility::flag_init("flag_hangar_intro_done");
  common_scripts\utility::flag_init("flag_bridge_rog");
  common_scripts\utility::flag_init("flag_hangar_end");
}

section_precache() {
  precachemodel("head_fed_army_f");
  precachemodel("head_fed_basic_a");
}

section_post_inits() {
  var_0 = getent("player_start_hangar", "targetname");

  if(isDefined(var_0)) {
    level._hangar = spawnStruct();
    level._hangar.player_start = var_0;
    level._hangar.ally_start = getent("ally1_start_hangar", "targetname");
    var_1 = getent("origin_hangar_intro", "targetname");
    var_2 = getEntArray("model_hangar_pip_screen_broken", "targetname");
    common_scripts\utility::array_thread(var_2, maps\skyway_util::hidenoshow);
    var_3 = maps\skyway_util::setup_door("model_hangar_door", "hangar_door");
    var_1 maps\_anim::anim_first_frame_solo(var_3, "hangar_intro");
    var_3.original_pos = common_scripts\utility::spawn_tag_origin();
    var_3.original_pos.origin = var_3.origin;
    var_3.original_pos.angles = var_3.angles;
    var_3.original_pos maps\skyway_util::linktotrain("train_hangar");
    var_4 = getent("brush_hangar_ally_wedge", "targetname");
    var_5 = getent("origin_hangar_ally_wedge_trigger", "targetname");
    var_5.col = getent(var_5.target, "targetname");
    var_5.col linkto(var_5);
    level._hangar.intro_node = var_1;
    level._hangar.intro_door = var_3;
    level._hangar.intro_tv_broken = var_2;
    level._hangar.intro_wedge = var_4;
    level._hangar.intro_wedge_trigger = var_5;
  }
}

start() {
  common_scripts\utility::flag_set("flag_hangar_start");
  maps\skyway_util::player_start(level._hangar.player_start);
  level._allies[0] forceteleport(level._hangar.ally_start.origin, level._hangar.ally_start.angles);
  level._allies[0] maps\_utility::set_force_color("r");
}

main() {
  if(level.credits_only) {
    level.player allowcrouch(0);
    level.player allowprone(0);
    level.player takeallweapons();
    level.player disableweapons();
    level.player freezecontrols(1);
    maps\_hud_util::fade_out(0);
    setsaveddvar("hud_showStance", "0");
    setsaveddvar("compass", "0");
    setsaveddvar("ammoCounterHide", "1");
    setsaveddvar("g_friendlyNameDist", 0);
    setsaveddvar("ui_hidemap", 1);
    level.player setclienttriggeraudiozone("skyway_credits", 0.5);
    maps\skyway_endbeach::end_credits();
    changelevel("", 0);
  }

  common_scripts\utility::flag_set("flag_hangar_start");
  common_scripts\utility::array_call(level._train.cars["train_hangar"].trigs, ::setmovingplatformtrigger);
  thread track_support();
  thread hangar_door_opens();
  thread skyway_sunsample();
  thread dialogue();
  thread maps\skyway_util::ambient_airbursts();
  thread maps\skyway_util::flag_wait_func("flag_hangar_door_open", common_scripts\utility::flag_set, "flag_hangar_end");
  getent("intelligence_item", "targetname") thread maps\skyway_util::waittill_notify_func("end_trigger_thread", ::delete_intel);
  maps\skyway_util::setup_player_for_animated_sequence(1, 0);

  if(!isDefined(level.debug_no_move) || !level.debug_no_move) {
    common_scripts\utility::flag_wait("sw_introscreen_complete");
  }

  thread maps\skyway_audio::skyway_intro_sfx();
  thread event_intro();
  thread event_sat_1_rog_hit();
  thread event_jet_flyby();
  thread maps\skyway_fx::fx_create_sunflare_source();
  thread maps\skyway_fx::fx_intro_amb();
  thread cleanup_hangar();
  common_scripts\utility::flag_wait("flag_hangar_end");
}

event_intro() {
  var_0 = level._hangar.intro_node;
  var_1 = level._allies[0];
  var_2 = level._hangar.intro_door;
  var_3 = level.player_rig;
  thread event_intro_tv_pip();
  level thread maps\skyway_util::waittill_notify_flag_set("nt_punch_monitor", "flag_hangar_screen_smash");
  level thread maps\skyway_util::waittill_notify_flag_set("nt_open_door", "flag_hangar_door_open");
  var_4[0] = build_human_model("enemy_hangar_1", "head_fed_army_f");
  var_4[1] = build_human_model("enemy_hangar_2", "head_fed_basic_a");
  var_3._enemy = var_4[0];
  wait 0.1;
  var_0 thread event_intro_player_anims(var_3);
  var_5 = common_scripts\utility::array_combine([var_2, var_3], var_4);
  var_1 linkto(var_0);
  common_scripts\utility::array_call(var_5, ::linkto, var_0);
  var_3 thread maps\skyway_util::start_nt_rumbles();
  level.player setclienttriggeraudiozone("skyway_train_int", 0.5);
  var_0 thread maps\skyway_vignette::vignette_single(var_5, "hangar_intro");
  var_0 maps\_anim::anim_single_solo(var_1, "hangar_intro");
  common_scripts\utility::flag_set("flag_hangar_intro_done");
  var_2.col_brush connectpaths();
  var_1 unlink();
  var_1 maps\_utility::enable_ai_color();
  var_1 pushplayer(1);
  var_1 maps\_utility::delaythread(8, maps\skyway_util::set_twitch, 0);
}

origin_mover(var_0) {
  self endon("death");

  for(;;) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

player_push() {
  var_0 = 10;
  level._hangar.intro_wedge delete();
  level._hangar.intro_wedge_trigger thread origin_mover(level._ally);

  while(!common_scripts\utility::flag("flag_hangar_door_open")) {
    common_scripts\utility::flag_wait("flag_player_push");

    while(common_scripts\utility::flag("flag_player_push") && !common_scripts\utility::flag("flag_hangar_door_open")) {
      player_push_impulse(anglesToForward(level._train.cars["train_hangar"].body.angles) * var_0);
      wait 0.05;
    }

    level.player pushplayervector((0, 0, 0));
  }

  wait 0.2;
  level._hangar.intro_wedge_trigger.col unlink();
  level._hangar.intro_wedge_trigger delete();
}

player_push_impulse(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  var_2 = var_1;

  while(var_2 > 0.0) {
    var_3 = clamp(var_2 / var_1, 0, 1);
    var_4 = var_0 * var_3;
    level.player pushplayervector(var_4);
    var_2 = var_2 - 0.05;
    wait 0.05;
  }
}

event_intro_tv_pip() {
  var_0 = common_scripts\utility::getstruct("struct_hangar_pip", "targetname");
  var_1 = level._boss;
  var_2 = maps\_utility::spawn_anim_model("hangar_pip_camera");
  var_3 = level._hangar.intro_tv_broken;
  var_4 = getent("actor_hangar_enemy_pip", "targetname");
  var_4 maps\_utility::add_spawn_function(::spawnfunc_intro);
  var_5 = var_4 maps\_utility::spawn_ai(1);
  var_6 = [var_1, var_2, var_5];
  var_6 maps\skyway_util_ai::ignore_everything();
  var_0 thread maps\_anim::anim_single(var_6, "hangar_intro");
  level.pip = level.player newpip();
  level.pip.x = 0;
  level.pip.y = 0;
  level.pip.width = 128;
  level.pip.height = 96;
  level.pip.freecamera = 1;
  level.pip.fov = 30;
  level.pip.enableshadows = 1;
  level.pip.origin = var_2.origin;
  level.pip.entity = var_2;
  level.pip.tag = "tag_origin";
  level.pip.visionsetnaked = "skyway_pip";
  level.pip.rendertotexture = 1;
  level.pip.enable = 1;
  var_7 = getent("origin_hangar_tv_static", "targetname");
  var_8 = var_7 common_scripts\utility::spawn_tag_origin();
  var_8 linkto(var_7);
  playFXOnTag(common_scripts\utility::getfx("pip_static"), var_8, "tag_origin");
  common_scripts\utility::flag_wait("flag_hangar_screen_smash");
  thread maps\_art::dof_disable_script(3);
  common_scripts\utility::array_thread(var_3, maps\skyway_util::shownoshow);
  thread player_push();
  level.pip.enable = 0;
  level.pip.entity = undefined;
  level.pip.camera = undefined;
  level.pip = undefined;
  var_2 delete();
  var_5 delete();
  var_8 delete();
  var_7 delete();
}

fx_blood_splatter() {
  var_0 = getent("origin_hangar_bloodsplatter", "targetname");
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 linkto(var_0);
  wait 2;
  playFXOnTag(common_scripts\utility::getfx("bloodsplatter_wall"), var_1, "tag_origin");
  wait 100;
}

spawnfunc_intro() {
  self.animname = self.script_parameters;

  if(issubstr(self.animname, "1")) {
    level._hangar.player_enemy = self;
  }

  self.v.invincible = 1;
  self.v.silent_script_death = 1;
  self.v.death_on_end = 1;
}

event_intro_player_anims(var_0) {
  var_0 waittill("msg_vignette_state_start");
  wait 0.05;
  maps\_anim::anim_set_rate([var_0, var_0._enemy], "hangar_intro", 1.0);
  level waittill("notify_draw_weapon");
  level.player enableweapons();
  var_0 waittill("msg_vignette_end");
  maps\skyway_util::player_animated_sequence_cleanup();
}

hangar_door_opens() {
  var_0 = getent("trig_hangar_inside", "targetname");
  common_scripts\utility::flag_wait("flag_hangar_door_open");

  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_set("wind_1");
  }
}

dialogue() {
  var_0 = level._allies[0];
  level waittill("notify_start_intro");
  wait 1;

  if(!isDefined(level.debug_no_move) || !level.debug_no_move) {
    common_scripts\utility::flag_wait("sw_introscreen_complete");
  }

  common_scripts\utility::flag_wait("flag_hangar_screen_smash");
  maps\_utility::radio_dialogue_stop();
  common_scripts\utility::flag_wait("flag_hangar_rog_hit");
}

event_sat_1_rog_hit() {
  var_0 = level._sat.satellites;
  var_1 = level._train.cars["train_sat_1"].body;
  var_2 = [];

  for(var_3 = 0; var_3 < 1; var_3++) {
    var_2[var_3] = getent("model_rog_hit_ref_" + (var_3 + 1), "targetname");
  }

  thread maps\skyway_util::waittill_nt(level._allies[0] maps\_utility::getanim("hangar_intro"), "open_door", -0.5, "flag_hangar_rog_hit");
  common_scripts\utility::flag_wait("flag_hangar_rog_hit");
  var_4 = 1.5;
  var_5 = [0.35, 0.3, 0.22];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    thread maps\_utility::delaythread(var_3 * var_4, ::event_sat_1_rog_impact, var_2[var_3], var_5[var_3]);
  }
}

event_sat_1_rog_impact(var_0, var_1) {
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), var_0, "tag_explode_base");
  var_0 thread maps\skyway_audio::sfx_rog_sat_impact("tag_explode");
  wait 4.0;
  playFXOnTag(common_scripts\utility::getfx("vfx_rog_impact_temp_01"), var_0, "tag_shockwave");
  thread maps\skyway_fx::fx_playerview_fieryflash_01();
  thread maps\skyway_util::rog_flash(0.5, 0.5, 1);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.5, 0.0, 0.3, 0.0, 6.0, "notify_rog_rumble");
  level.player playrumbleonentity("damage_heavy");
  thread maps\skyway_util::player_wind_bump(0.2, 0.0, 2.0, 0.9);
  thread maps\skyway_util::train_quake(0.7, 0.8, level.player.origin, 2000);
  wait 1.5;
  common_scripts\utility::exploder("intro_rog_hit_shockwave_01");
}

event_jet_flyby() {
  common_scripts\utility::flag_wait("flag_hangar_door_open");
  wait 3.2;
  thread maps\skyway_util::jet_flyover(level._train.cars["train_hangar"].body, "hang_flyby", "jet_contrail", "jet_contrail", "jet_contrail", 1);
}

track_support() {
  level endon("notify_hangar_stop_track_support");
  var_0 = getent("origin_hangar_track_support_1", "targetname");
  var_1 = getent("origin_hangar_track_support_2", "targetname");
  var_2 = getent("model_hangar_track_support", "targetname");

  while(!common_scripts\utility::flag("flag_hangar_door_open")) {
    var_2 hide();
    var_2.origin = var_0.origin;
    wait 0.05;
    var_2 show();
    var_2 moveto(var_1.origin, 1);
    wait 3;
  }

  var_2 delete();
}

skyway_sunsample() {
  setsaveddvar("sm_sunSampleSizeNear", 0.1);
  common_scripts\utility::flag_wait("flag_hangar_door_open");
  wait 2;
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  common_scripts\utility::flag_wait("flag_loco_enter");
  wait 0.5;
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  common_scripts\utility::flag_wait("flag_end_swim_end");
  setsaveddvar("sm_sunSampleSizeNear", 0.1);
}

delete_intel() {
  self delete();
}

cleanup_hangar() {
  common_scripts\utility::flag_wait("flag_sat1_noticket");
  common_scripts\utility::flag_wait("flag_hangar_intro_done");
  wait 0.5;

  while(issubstr(level.player.car, "hangar")) {
    wait 0.05;
  }

  var_0 = level._hangar.intro_door;
  var_0 linkto(var_0.original_pos, "tag_origin", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level._train.cars["train_hangar"].other_linked_parts["script_model"]) {
    if(issubstr(var_2.model, "cargo") || issubstr(var_2.model, "stacker") || issubstr(var_2.model, "lynx") || issubstr(var_2.model, "tool_cabinet")) {
      var_2 delete();
    }
  }
}

build_human_model(var_0, var_1, var_2) {
  var_3 = maps\_utility::spawn_anim_model(var_0);
  var_3 attach(var_1);
  return var_3;
}