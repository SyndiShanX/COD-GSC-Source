/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_audio.gsc
*****************************************************/

main() {
  common_scripts\utility::flag_init("invader_music_cue");
  common_scripts\utility::flag_init("fade_intro_music");
  common_scripts\utility::flag_init("stop_music_pod_explo");
  common_scripts\utility::flag_init("rcs_is_damaged");
  common_scripts\utility::flag_init("mus_odin_end");
  common_scripts\utility::flag_init("mus_atmosphere");
  common_scripts\utility::flag_init("stop_sat_thrust_loop");
  common_scripts\utility::flag_init("stop_sat_lat_thrust_loop");
  common_scripts\utility::flag_init("escape_door_opened");
  common_scripts\utility::flag_init("auto_door_closed");
  common_scripts\utility::flag_init("stop_scuttle_loop");
  common_scripts\utility::flag_init("begin_scuttle_ramp");
  common_scripts\utility::flag_init("sat_second_expl");
  common_scripts\utility::flag_init("sfx_odin_ending");
  level.play_shake_sound = 0;
  level.play_npc_deaths = 0;

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.space_breathing_enabled = 1;
  }
  else {
    level.space_breathing_enabled = 1;
  }

  level.player thread maps\_space_player::player_space_breathing();
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("effects1", 0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("ambient", 0);
  soundsettimescalefactor("weapon", 0);
  soundsettimescalefactor("bulletimpact", 0);
  soundsettimescalefactor("bulletwhizbyin", 0);
  soundsettimescalefactor("bulletwhizbyout", 0);
  soundsettimescalefactor("norestrict2d", 0);
  thread audio_odin_pressurized_variable();
  level.sfx_plr_grapple_playing = 0;
  level.shaky_moment = 0;
  level.no_impact = 0;
}

audio_odin_pressurized_variable() {
  level.pressurized = 0;
}

audio_set_initial_ambience() {
  wait 0.1;

  if(level.start_point == "odin_intro") {
    level.player setclienttriggeraudiozone("odin_title", 3.0);
  }
  else {
    level.player setclienttriggeraudiozone("odin_intro", 0);
  }

  thread mission_music();

  if(level.start_point == "odin_ally" || level.start_point == "odin_escape" || level.start_point == "odin_spin") {
    wait 1;
    level.player setclienttriggeraudiozone("odin_pressurized", 6);
    level.pressurized = 0;
  } else if(level.start_point == "odin_intro") {
    wait 5;
    level.player clearclienttriggeraudiozone(3);
  }
}

mission_music() {
  switch (level.start_point) {
    case "default":
    case "odin_intro":
      common_scripts\utility::flag_wait("fade_intro_music");
      maps\_utility::music_stop(10);
    case "odin_ally":
      common_scripts\utility::flag_wait("invader_music_cue");
    case "odin_spin":
    case "odin_escape":
      wait 0.5;
      maps\_utility::music_play("mus_odin_invader", 0.1);
      thread sfx_invader_sounds();
      common_scripts\utility::flag_wait("stop_music_pod_explo");
      maps\_utility::music_stop(1);
      common_scripts\utility::flag_wait("mus_odin_end");
      maps\_utility::music_play("mus_odin_end");
    case "odin_spacejump":
    case "odin_end":
    case "odin_satellite":
      maps\_utility::music_play("mus_odin_end");
      common_scripts\utility::flag_wait("mus_atmosphere");
      maps\_utility::music_crossfade("mus_odin_end_atmosphere", 0.5);
      wait 25;
      level.player setclienttriggeraudiozone("odin_end_fadeout", 3);
    default:
  }
}

sfx_player_intro_movement() {
  wait 4.8;
  self playSound("scn_odin_player_intro_movement");
}

sfx_traversal_01() {
  wait 2.3;
  level.player playSound("scn_odin_traversal_01");
}

sfx_traversal_02() {
  wait 0.4;
  level.player playSound("scn_odin_traversal_02");
}

sfx_invader_sounds() {
  wait 3;
  var_0 = spawn("script_origin", (3365, 47471, 48608));
  var_0 playLoopSound("emt_odin_alarm3");
  var_1 = spawn("script_origin", (3281, 47035, 48593));
  var_1 playLoopSound("emt_odin_alarm2");
}

sfx_bg_fighting_line_emitter() {
  wait 10;
  var_0 = spawn("script_origin", (0, 50000, 50000));
  var_1 = 0;

  for(;;) {
    if(common_scripts\utility::flag("saved_ally")) {
      break;
    }

    var_2 = pointonsegmentnearesttopoint((3200, 47190, 48558), (3280, 46530, 48558), level.player.origin);
    var_0 moveto(var_2, 0.01);

    if(var_1 == 0) {
      var_0 playLoopSound("emt_odin_bg_fighting_01_lp");
      var_1 = 1;
    }

    wait 0.1;
  }

  var_0 stoploopsound("emt_odin_bg_fighting_01_lp");
  var_0 delete();
  thread sfx_bg_fighting_emt();
}

sfx_bg_fighting_emt() {
  wait 2;
  level.sfx_bg_fighting = spawn("script_origin", (3178, 46395, -13132));
  level.sfx_bg_fighting playLoopSound("emt_odin_bg_fighting_02_lp");
}

sfx_bg_fighting_stop() {
  wait 1;
  level.player setclienttriggeraudiozone("odin_fighting_fade", 3.5);
  wait 3.5;
  level.sfx_bg_fighting stoploopsound("emt_odin_bg_fighting_02_lp");
  level.sfx_bg_fighting delete();
  wait 1;
  level.player setclienttriggeraudiozone("odin_pressurized", 1);
}

sfx_ally_plr_grapple() {
  level.sfx_player_grapple = spawn("script_origin", self.origin);
  level.sfx_player_grapple linkto(self);
  wait 0.4;
  level.sfx_player_grapple playSound("scn_odin_player_grapple");
  common_scripts\utility::flag_wait("saved_ally");
  wait 0.2;
  level.sfx_player_grapple stopsounds();
}

sfx_ally_plr_grapple_ss() {
  level.sfx_plr_grapple_playing = 1;
  level.grapple = spawn("script_origin", self.origin);
  level.grapple playSound("scn_odin_player_grapple_ss", "grappledone");
  level.grapple waittill("grappledone");
  level.sfx_plr_grapple_playing = 0;
}

sfx_ally_ally_grapple() {
  self playSound("scn_odin_ally_grapple");
}

sfx_ally_plr_grapple_loop_init() {
  if(!isDefined(level.sfx_plr_grapple_lp)) {
    level.sfx_plr_grapple_lp = spawn("script_origin", self.origin);
    level.sfx_plr_grapple_lp linkto(self);
  }

  if(!isDefined(level.sfx_plr_grapple_lt_lp)) {
    level.sfx_plr_grapple_lt_lp = spawn("script_origin", self.origin);
    level.sfx_plr_grapple_lt_lp linkto(self);
    level.sfx_plr_grapple_lt_lp playLoopSound("scn_odin_player_grapple_lt_lp");
  }
}

sfx_ally_plr_grapple_loop() {
  if(level.sfx_plr_grapple_loop_playing == 0) {
    level.sfx_plr_grapple_loop_playing = 1;
    level.sfx_plr_grapple_lp playLoopSound("scn_odin_player_grapple_lp");
    level.sfx_plr_grapple_lt_lp stoploopsound();
  }
}

sfx_ally_plr_grapple_stop() {
  if(level.sfx_plr_grapple_loop_playing == 1) {
    level.sfx_plr_grapple_lt_lp playLoopSound("scn_odin_player_grapple_lt_lp");
    self playSound("scn_odin_player_grapple_stop");
    level.sfx_plr_grapple_lp stoploopsound();
    level.sfx_plr_grapple_loop_playing = 0;
  }
}

sfx_ally_plr_grapple_failed() {
  level.sfx_player_grapple stopsounds();
  level.sfx_plr_grapple_lp stoploopsound();
  level.sfx_plr_grapple_lt_lp stoploopsound();
  self playSound("scn_odin_ally_grapple");
}

sfx_ally_plr_grapple_success() {
  level.player playSound("scn_odin_grapple_shoot_lr");
  level.player setclienttriggeraudiozone("odin_grapple_shoot", 0.15);
  level.sfx_player_grapple stopsounds();
  level.sfx_plr_grapple_lp stoploopsound();
  level.sfx_plr_grapple_lt_lp stoploopsound();
  wait 1.34;
  level.player setclienttriggeraudiozone("odin_pressurized", 1);
}

sfx_distant_explo(var_0) {}

sfx_play_shuttle_crash() {}

sfx_spin_outside_zone() {
  wait 0.6;
  level.player setclienttriggeraudiozone("odin_intro", 17);
}

sfx_odin_decompress() {
  common_scripts\utility::flag_set("stop_music_pod_explo");
  level.player setclienttriggeraudiozone("odin_scuttle_event_2", 1);
  level.pressurized = 0;
  level.space_intense_breathing = 1;
  level.play_npc_deaths = 0;
  wait 2.04;
  level.player setclienttriggeraudiozone("odin_after_scuttle", 1);
  level.space_breathing_enabled = 1;
}

sfx_odin_decompress_explode() {
  level.airlockexplode = spawn("script_origin", (-160, 46398, -15748));
  level.airlockexplode playSound("scn_odin_decompression_explode_ss");
  level.space_intense_breathing = 2;
  level.player setclienttriggeraudiozone("odin_scuttle", 0.3);
  wait 0.3;

  if(isDefined(level.creak_loop_sound)) {
    level.creak_loop_sound stopsounds();
  }

  wait 4.7;
  wait 8;
  level.space_intense_breathing = 1;
}

sfx_pressurize_space() {
  level.player setclienttriggeraudiozone("odin_pressurized", 6);
  level.pressurized = 0;
}

sfx_pressurize_sound() {
  common_scripts\utility::flag_set("fade_intro_music");
  level.player playSound("scn_odin_pressurize_lr_ss");
  wait 3;
  thread sfx_pressurize_space();
  thread sfx_enemy_nodes();
}

sfx_enemy_nodes() {
  level.enemyguys = spawn("script_origin", (2915, 47423, 48552));
  level.enemyguys playLoopSound("scn_odin_enemy_entrance_latches");
  level.enemyguys2 = spawn("script_origin", (3004, 47428, 48635));
  level.enemyguys2 playLoopSound("scn_odin_enemy_entrance_beeps");
}

sfx_odin_spin_explosion(var_0) {
  var_0 playSound("scn_odin_spin_explosion");
}

sfx_odin_rog_dist(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 playSound("scn_odin_ROD_fire_dist");
}

sfx_odin_rog_close(var_0) {
  var_0 playSound("scn_odin_ROD_fire_close");
}

sfx_end_explo(var_0) {
  switch (var_0) {
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    default:
      break;
  }
}

sfx_shaky_camera_moment() {
  level.player playSound("scn_odin_dist_fire_shake_lr");
  var_0 = (1543, 46455, -15729);
  var_1 = (1779, 46378, -15747);
  var_2 = (1282, 46308, -15694);

  if(level.shaky_moment == 0) {
    wait 0.5;
    var_3 = spawn("script_origin", var_1);
    var_3 playSound("scn_odin_dist_fire_shake_mn_03");
    level.shaky_moment = 1;
  } else if(level.shaky_moment == 1) {
    wait 0.5;
    var_3 = spawn("script_origin", var_2);
    var_3 playSound("scn_odin_dist_fire_shake_mn_02");
    level.shaky_moment = 2;
  } else {}
}

sfx_dist_odin_fire() {
  if(!common_scripts\utility::flag("sfx_odin_ending")) {
    if(level.play_shake_sound == 0) {
      thread common_scripts\utility::play_sound_in_space("scn_odin_dist_fire_moment", (108, 44645, -15751));
    }
    else if(level.play_shake_sound == 3) {
      thread common_scripts\utility::play_sound_in_space("scn_odin_dist_fire_moment", (-11686, 46111, -16126));
    }
  }
}

sfx_shuttle_passby(var_0) {
  wait 5.5;
  var_0 playSound("scn_odin_shuttle_pass");
  level.player setclienttriggeraudiozone("odin_title", 1);
}

sfx_shaking_logic() {
  if(!common_scripts\utility::flag("begin_scuttle_ramp")) {
    common_scripts\utility::flag_set("begin_scuttle_ramp");
    level.sound_ramp = 0;
  }

  level.sound_ramp = level.sound_ramp + 1;

  switch (level.sound_ramp) {
    case 1:
      level.player playSound("scn_odin_scuttle_01_lr");
      break;
    case 3:
      level.player playSound("scn_odin_scuttle_02_lr");
      break;
    case 5:
      level.player playSound("scn_odin_scuttle_03_lr");
      break;
    case 7:
      level.player playSound("scn_odin_scuttle_04_lr");
      break;
    case 9:
      level.player playSound("scn_odin_scuttle_05_lr");
      break;
    case 11:
      level.player playSound("scn_odin_scuttle_06_lr");
      level.sound_ramp = 0;
      break;
  }
}

sfx_airlock_door() {
  wait 10.2;
  var_0 = spawn("script_origin", (3842, 47413, 48544));
  var_0 playSound("scn_odin_airlock_door_open", "door_sound");
  var_0 waittill("door_sound");
  var_0 delete();
}

sfx_infiltrator_door() {
  common_scripts\utility::flag_set("invader_music_cue");
  wait 0.4;
  var_0 = spawn("script_origin", (2916, 47423, 48555));
  var_0 playSound("scn_odin_breach_door_open");
  thread sfx_infiltrator_foley_01();
  wait 3;
  var_0 delete();
}

sfx_post_infil_door() {
  var_0 = spawn("script_origin", (3320, 47269, 48555));
  var_0 playSound("scn_odin_post_infil_door_open");
  wait 6;
  var_0 delete();
}

sfx_plr_open_station_door() {
  wait 0.5;
  level.player playSound("scn_odin_station_door_open_plr");
}

sfx_kyra_open_station_door() {
  wait 1.3;
  var_0 = spawn("script_origin", (2149, 46401, -15743));
  var_0 playSound("scn_odin_station_door_open_kyra");
  wait 4;
  var_0 delete();
}

sfx_escape_door_open() {
  if(!common_scripts\utility::flag("escape_door_opened")) {
    common_scripts\utility::flag_set("escape_door_opened");
    var_0 = spawn("script_origin", (3172, 46403, -15743));
    var_0 playSound("scn_odin_auto_door_open");
    wait 3;
    var_0 delete();
    common_scripts\utility::flag_clear("escape_door_opened");
  }
}

sfx_decomp_door() {
  if(!common_scripts\utility::flag("escape_door_opened")) {
    common_scripts\utility::flag_set("escape_door_opened");
    var_0 = spawn("script_origin", (498, 46400, -15743));
    var_0 playSound("scn_odin_scuttle_door_open");
    level.player playSound("scn_odin_decompression_lr_ss");
    thread sfx_odin_decompress();
    wait 3;
    var_0 delete();
    common_scripts\utility::flag_clear("escape_door_opened");
  }
}

sfx_interior_door_open(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  wait(var_1);

  if(isDefined(var_0) && !common_scripts\utility::flag("escape_door_opened")) {
    common_scripts\utility::flag_set("escape_door_opened");
    var_0 playSound("scn_odin_auto_door_open");
    wait 2.3;
    common_scripts\utility::flag_clear("escape_door_opened");
  }
}

sfx_interior_door_close(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  wait(var_1);

  if(isDefined(var_0) && !common_scripts\utility::flag("auto_door_closed")) {
    common_scripts\utility::flag_set("auto_door_closed");

    if(var_0.door_name != "post_infil_auto_door") {
      var_0 playSound("scn_odin_auto_door_close");
    }

    wait 2.2;
    common_scripts\utility::flag_clear("auto_door_closed");
  }
}

sfx_infiltrator_foley_01() {
  wait 0.7;
  var_0 = spawn("script_origin", (2931, 47420, 48560));
  var_0 playSound("scn_odin_enemy_entrance_foley_01");
  thread sfx_infiltrator_foley_02();
  thread sfx_infiltrator_mix();
  wait 5;
  var_0 delete();
}

sfx_infiltrator_foley_02() {
  wait 4.3;
  var_0 = spawn("script_origin", (3193, 47481, 48565));
  var_0 playSound("scn_odin_enemy_entrance_foley_02");
  thread sfx_infiltrator_foley_03();
  wait 9;
  var_0 delete();
}

sfx_infiltrator_foley_03() {
  wait 7.9;
  var_0 = spawn("script_origin", (2931, 47420, 48570));
  var_0 playSound("scn_odin_enemy_entrance_foley_03");
  wait 6;
  var_0 delete();
}

sfx_infiltrator_mix() {
  wait 2;
  level.player setclienttriggeraudiozone("odin_infiltrator", 0.1);
  wait 1;
  level.player setclienttriggeraudiozone("odin_pressurized", 0.3);
}

sfx_kyra_hatch(var_0) {
  wait 3;
  var_0 playSound("scn_odin_hatch_close_kyra");
  var_1 = spawn("script_origin", (3192, 47424, 48553));
  var_1 playSound("scn_odin_hatch_close");
}

sfx_odin_spinup() {
  wait 2;
  var_0 = spawn("script_origin", (3951, 46358, -12977));
  var_0 playSound("emt_odin_on_alarm");
  var_1 = spawn("script_origin", (3217, 46399, -13043));
  var_1 playSound("emt_odin_on_alarm");
  wait 1.5;
  thread emt_scn_move();
  level.player playSound("scn_odin_enemy_lightsoff");
  wait 1.5;
  thread sfx_play_alarms();
}

sfx_play_alarms() {
  var_0 = spawn("script_origin", (3580, 46437, -13022));
  var_0 playLoopSound("emt_odin_alarm");
  var_1 = spawn("script_origin", (2974, 46495, -15687));
  var_1 playLoopSound("emt_odin_alarm");
  var_2 = spawn("script_origin", (2300, 46387, -15698));
  var_2 playLoopSound("emt_odin_alarm");
  var_3 = spawn("script_origin", (1487, 46380, -15710));
  var_3 playLoopSound("emt_odin_alarm");
  var_4 = spawn("script_origin", (861, 46386, -15744));
  var_4 playLoopSound("emt_odin_alarm");
}

emt_scn_move() {
  var_0 = spawn("script_origin", (3217, -46399, -13043));
  var_0 playSound("emt_scn_odin_on");
  var_0 moveto((3951, 46358, -12977), 3);
}

sfx_scuttle_alarm() {
  var_0 = spawn("script_origin", (1308, 46452, -15666));
  var_0 playLoopSound("emt_blackice_flarestack_alarm_03_lp");
}

sfx_spin_emt() {
  wait 2.7;
  var_0 = spawn("script_origin", (-2275, 46574, -16077));
  var_1 = spawn("script_origin", (-2412, 46190, -16000));
  var_2 = spawn("script_origin", (-2341, 46958, -16000));
  var_3 = spawn("script_origin", (-2456, 46570, -15936));
  var_4 = spawn("script_origin", (-1647, 46636, -16000));
  var_5 = spawn("script_origin", (-3067, 46280, -16028));
  var_6 = spawn("script_origin", (-2792, 46730, -16000));
  var_0 playSound("emt_odin_space_spin_01");
  wait 0.2;
  var_4 playSound("emt_odin_space_spin_02");
  wait 4;
  var_2 playSound("emt_odin_space_spin_03", "spin_01");
  var_2 waittill("spin_01");
  var_1 playSound("emt_odin_space_spin_04");
  wait 0.6;
  var_4 playSound("emt_odin_space_spin_05");
  wait 2.3;
  var_0 playSound("emt_odin_space_spin_06", "spin_02");
  var_0 waittill("spin_02");
  var_5 playSound("emt_odin_space_spin_07");
  wait 0.5;
  var_1 playSound("emt_odin_space_spin_08");
  wait 1;
  var_2 playSound("emt_odin_space_spin_09", "spin_03");
  var_2 waittill("spin_03");
  var_6 playSound("emt_odin_space_mtl_creak");
  wait 1;
  var_5 playSound("emt_odin_space_mtl", "spin_04");
  var_5 waittill("spin_04");
  var_5 playSound("emt_odin_space_mtl_creak");
  wait 1;
  var_6 playSound("emt_odin_space_mtl", "spin_05");
  var_6 waittill("spin_05");
  var_5 playSound("emt_odin_space_mtl_creak");
  wait 1;
  var_6 playSound("emt_odin_space_mtl");
}

sfx_sat_approach_plr() {
  level.player playSound("scn_odin_sat_plr_approach_foley");
}

sfx_sat_approach_kyra() {
  level.ally playSound("scn_odin_sat_kyra_approach_foley");
}

sfx_rcs_open() {
  level.player playSound("scn_odin_sat_plr_use");
  level.ally playSound("scn_odin_sat_kyra_use_foley");
}

sfx_rcs_spark(var_0) {
  common_scripts\utility::play_sound_in_space("scn_odin_sat_spark", var_0);
}

sfx_set_ending_flag() {
  if(!common_scripts\utility::flag("sfx_odin_ending")) {
    common_scripts\utility::flag_set("sfx_odin_ending");
  }
}

sfx_rcs_destr(var_0, var_1, var_2) {
  wait(var_2);

  switch (var_1) {
    case 1:
      var_0 playSound("scn_odin_rcs_burst");
      break;
    case 2:
      var_0 playSound("scn_odin_rcs_burst");
      wait 0.1;
      var_0 playSound("scn_odin_rcs_fireball");
      break;
    case 3:
      var_0 playSound("scn_odin_rcs_ignite");
      wait 0.4;
      var_0 playLoopSound("scn_odin_rcs_fire_lp_01");
      break;
    case 4:
      var_0 playSound("scn_odin_rcs_ignite");
      wait 0.3;
      var_0 playSound("scn_odin_rcs_fireball");
      break;
    case 5:
      var_0 playSound("scn_odin_rcs_fireball");
      break;
    default:
      break;
  }
}

sfx_rcs_damage(var_0) {}

sfx_sat_first_explosion() {
  level.player playSound("scn_odin_sat_expl_01_lr");
  var_0 = getent("fx_sat_rcs_damage_1", "script_noteworthy");
  var_0 stoploopsound("scn_odin_rcs_fire_lp_01");
  level.player playSound("scn_odin_sat_plr_expl_foley_01");
  thread sfx_sat_big_fire_lp(var_0);
}

sfx_sat_big_fire_lp(var_0) {
  wait 1.5;
  var_0 playSound("scn_odin_rcs_fireball_dist");
  wait 0.3;
  var_0 playLoopSound("scn_odin_rcs_fire_lp_02");

  while(!common_scripts\utility::flag("sat_second_expl")) {
    wait(randomfloatrange(1.5, 2.7));
    var_0 playSound("scn_odin_rcs_fireball_dist");
  }
}

sfx_sat_second_explosion() {
  common_scripts\utility::flag_set("sat_second_expl");
  level.player playSound("scn_odin_sat_expl_02_lr");
  var_0 = getent("fx_sat_rcs_damage_1", "script_noteworthy");
  var_0 stoploopsound("scn_odin_rcs_fire_lp_02");
  level.player playSound("scn_odin_sat_plr_expl_foley_02");
  wait 3;
  thread sfx_sat_falling();
}

sfx_sat_falling() {
  level.player playSound("scn_odin_sat_falling_lr");
  thread sfx_sat_disintegration();
  wait 2;
  wait 6.85;
  level.player playSound("scn_odin_sat_panel_lsrs");
}

sfx_sat_disintegration() {
  wait 13.3;
  level.player playSound("scn_odin_sat_disintegration_lr");
}

sfx_switch_ambzone_to_end() {
  level.player setclienttriggeraudiozone("odin_end", 1);
}

sfx_close_first_door(var_0) {
  var_0 playSound("scn_odin_first_door_close");
}

sfx_satellite_thruster_loop(var_0) {
  if(common_scripts\utility::flag("decomp_done")) {
    var_1 = var_0 getorigin();
    common_scripts\utility::flag_clear("stop_sat_thrust_loop");
    var_2 = spawn("script_origin", var_1);
    var_2 playLoopSound("scn_odin_sat_thruster_lp", var_2);
    common_scripts\utility::flag_wait("stop_sat_thrust_loop");
    common_scripts\utility::play_sound_in_space("scn_odin_sat_thruster_flareout", var_1);
    wait 0.4;
    var_2 stoploopsound();
    wait 0.2;
    var_2 delete();
  }
}

sfx_satellite_lat_thruster_loop(var_0) {
  if(common_scripts\utility::flag("decomp_done")) {
    var_1 = var_0 getorigin();
    common_scripts\utility::flag_clear("stop_sat_lat_thrust_loop");
    var_2 = spawn("script_origin", var_1);
    var_2 playLoopSound("scn_odin_sat_thruster_lp", var_2);
    common_scripts\utility::flag_wait("stop_sat_lat_thrust_loop");
    common_scripts\utility::play_sound_in_space("scn_odin_sat_thruster_flareout", var_1);
    wait 0.4;
    var_2 stoploopsound();
    wait 0.2;
    var_2 delete();
  }
}

sfx_satellite_thruster_initial_burst(var_0) {
  if(common_scripts\utility::flag("decomp_done")) {
    var_1 = var_0 getorigin();
    common_scripts\utility::play_sound_in_space("scn_odin_sat_thruster_fire", var_1);
  }
}

sfx_odin_enemies() {
  var_0 = spawn("script_origin", (2915, 47423, 48552));
  var_0 playSound("scn_odin_enemy_entrance_door");
  thread sfx_enemies_stop();
}

sfx_enemies_stop() {
  level.player setclienttriggeraudiozone("odin_pressurized_turn_down_enemies", 0.5);
  wait 0.6;
  level.enemyguys stoploopsound();
  level.enemyguys2 stoploopsound();
  wait 0.1;
  level.player setclienttriggeraudiozone("odin_pressurized", 1);
}

sfx_rog_impact() {
  if(level.no_impact == 0) {
    thread common_scripts\utility::play_sound_in_space("scn_odin_ROG_impact_temp", (-10592, 29280, -12464));
  }
}

sfx_scuttle_pre_decomp() {
  wait 5.1;
  level.player setclienttriggeraudiozone("odin_scuttle_event", 3);
  level.player playSound("scn_odin_scuttle_ramp");
  wait 1.5;
  level.no_impact = 1;
  level.creak_loop_sound = spawn("script_origin", self.origin);
  level.creak_loop_sound playSound("scn_odin_scuttle_creak_lr");
  common_scripts\utility::flag_wait("odin_start_spin_decomp_real");
  common_scripts\utility::flag_wait("stop_music_pod_explo");
}

sfx_spin_debris_passby() {
  var_0 = spawn("script_origin", (-2404, 46646, -15904));
  wait 5.3;
  wait 2.16;
  wait 4.51;
  var_0 playSound("scn_odin_spin_debris_03");
  var_0 moveto((-2610, 46210, -15895), 3.5);
  wait 10;
  var_0 delete();
}

sfx_continued_shaking() {
  while(!common_scripts\utility::flag("stop_music_pod_explo")) {
    thread sfx_shaking_logic();
    wait(randomfloatrange(0.8, 2.4));
  }
}

sfx_play_weapon_up() {}

sfx_escape_destruction_fire_puffs() {
  var_0 = spawn("script_origin", (1274.91, 46312.1, -15672.1));
  var_0 playLoopSound("emt_fire_puff_lp");
  var_1 = spawn("script_origin", (2633.08, 46487, -15671.2));
  var_1 playLoopSound("emt_fire_puff_lp");
  var_2 = spawn("script_origin", (1866.58, 46464.8, -15642.9));
  var_2 playLoopSound("emt_fire_puff_lp");
  var_3 = spawn("script_origin", (2390.09, 46473.2, -15826.6));
  var_3 playLoopSound("emt_fire_puff_lp");
  var_4 = spawn("script_origin", (2607.26, 46333.9, -15746.2));
  var_4 playLoopSound("emt_fire_puff_lp");
  var_5 = spawn("script_origin", (1808.79, 46317.1, -15820.9));
  var_5 playLoopSound("emt_fire_puff_lp");
  var_6 = spawn("script_origin", (1369.75, 46487.5, -15816.4));
  var_6 playLoopSound("emt_fire_puff_lp");

  if(maps\_utility::is_gen4()) {
    thread sfx_gen4_fire_puff();
  }

  common_scripts\utility::flag_wait("stop_music_pod_explo");
  var_0 stoploopsound();
  var_1 stoploopsound();
  var_2 stoploopsound();
  var_3 stoploopsound();
  var_4 stoploopsound();
  var_5 stoploopsound();
  var_6 stoploopsound();
  wait 1;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
}

sfx_gen4_fire_puff() {
  var_0 = spawn("script_origin", (788.89, 46515.9, -15763.8));
  var_0 playLoopSound("emt_fire_puff_lp");
  common_scripts\utility::flag_wait("stop_music_pod_explo");
  var_0 stoploopsound();
  var_0 delete();
}

sfx_phantom_door_close() {
  wait 1;
  var_0 = spawn("script_origin", (2605, 46351, -15747));
  var_0 playSound("scn_odin_auto_door_close");
  wait 2;
  var_0 delete();
}