/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_audio.gsc
*****************************************************/

audio_main() {
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("ambient", 0);
  soundsettimescalefactor("weapon", 0);
  soundsettimescalefactor("bulletimpact", 0);
  soundsettimescalefactor("bulletwhizbyin", 0);
  soundsettimescalefactor("bulletwhizbyout", 0);
  soundsettimescalefactor("element", 0);
  soundsettimescalefactor("effects1", 0);
  soundsettimescalefactor("local", 0.5);
  thread sfx_crate_trigger_setup();
  thread sfx_mud_trigger_setup();
  thread sfx_mudslide_trigger_setup();
  thread sfx_create_conveyor_line_emitter();
  thread start_conveyor_line_emitter();
  thread sfx_create_jungle_line_emitter();
  thread sfx_create_truckyard_line_emitter();
  thread start_truckyard_line_emitter();
  thread sfx_create_movingcover2_line_emitters();
  thread start_movingcover2_sfx_loops();

  if(level.start_point == "intro" || level.start_point == "intro_train" || level.start_point == "default" || level.start_point == "factory_ingress")
    thread audio_sfx_truck_idle_loop_start();

  level.rollingloop = "emt_movingcover2_rolling1_loop";
  level.jump_to_amb_alias = undefined;
  thread audio_sfx_factory_distant_loop_start();
  level.factoryrevealambience = spawn("script_origin", (5300, 2500, 500));
  level.factoryrevealambienceemt = spawn("script_origin", (6192, 2592, 500));
  level.factoryrevealambienceemt2 = spawn("script_origin", (6357, 3113, 396));
  thread audio_setup_tank_room_trigger();
}

sfx_rog_reveal_setup() {
  common_scripts\utility::flag_set("trigger_hall");
  var_0 = getent("trigger_audio_hall", "targetname");
  var_0 thread sfx_hall_trigger();
  var_1 = getent("trigger_audio_sat_room", "targetname");
  var_1 thread sfx_sat_trigger();
  level.hallway_rog_mvmt = spawn("script_origin", (7610, -152, 314));
}

sfx_hall_trigger() {
  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("trigger_sat_room")) {
      if(!common_scripts\utility::flag("mix_tunnel_open"))
        common_scripts\utility::flag_set("mix_tunnel_open");

      common_scripts\utility::flag_clear("trigger_sat_room");
      level.player setclienttriggeraudiozone("factory_wh1_tunnel_open_2", 0);
    }

    if(!common_scripts\utility::flag("trigger_hall"))
      common_scripts\utility::flag_set("trigger_hall");

    while(level.player istouching(self))
      wait 0.1;
  }
}

sfx_sat_trigger() {
  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("trigger_hall"))
      common_scripts\utility::flag_clear("trigger_hall");

    if(!common_scripts\utility::flag("trigger_sat_room")) {
      common_scripts\utility::flag_set("trigger_sat_room");

      if(common_scripts\utility::flag("mix_tunnel_open"))
        level.player clearclienttriggeraudiozone(0.7);
    }

    while(level.player istouching(self))
      wait 0.1;
  }
}

sfx_sat_door_mix_open() {
  if(common_scripts\utility::flag("trigger_hall")) {
    common_scripts\utility::flag_set("mix_tunnel_open");
    level.player setclienttriggeraudiozone("factory_wh1_tunnel_open", 1.2);
  }
}

sfx_sat_door_mix_close() {
  if(common_scripts\utility::flag("trigger_hall")) {
    common_scripts\utility::flag_clear("mix_tunnel_open");
    level.player clearclienttriggeraudiozone(1.2);
  }
}

intro_ambience_changes() {
  level.player setclienttriggeraudiozone("factory_fadein", 0);
  thread audio_thunder_play_and_fp_rain();
  thread playthisthing();
  level.player clearclienttriggeraudiozone(5);
}

playthisthing() {
  wait 1;
  level.player playSound("scn_factory_beg_thunder_lr");
}

audio_thunder_play_and_fp_rain() {
  level.rain_loop_2d = spawn("script_origin", (0, 0, 0));
  level.rain_loop_2d playLoopSound("emt_rain_fp");
}

sfx_factory_intro_lightning_loop() {
  wait 0.2;
  self playSound("scn_factory_intro_lightning");
}

audio_setup_tank_room_trigger() {
  common_scripts\utility::flag_init("trigger_tank_room_volume");
  var_0 = getent("intro_to_tankroom", "targetname");
  var_0 thread trigger_tank_room_flag();
}

trigger_tank_room_flag() {
  self waittill("trigger");
  common_scripts\utility::flag_set("trigger_tank_room_volume");
}

audio_flag_inits() {
  common_scripts\utility::flag_init("music_wait_forever");
  common_scripts\utility::flag_init("music_chk_jungle");
  common_scripts\utility::flag_init("music_chk_intro");
  common_scripts\utility::flag_init("music_chk_ingress");
  common_scripts\utility::flag_init("music_chk_powerstealth");
  common_scripts\utility::flag_init("music_chk_ambush");
  common_scripts\utility::flag_init("music_chk_ambush_escape");
  common_scripts\utility::flag_init("music_chk_rooftop");
  common_scripts\utility::flag_init("music_chk_parkinglot");
  common_scripts\utility::flag_init("music_chk_chase");
  common_scripts\utility::flag_init("music_chk_crash");
  common_scripts\utility::flag_init("music_jungle_slide");
  common_scripts\utility::flag_init("music_stealth_intro");
  common_scripts\utility::flag_init("music_factory_reveal");
  common_scripts\utility::flag_init("music_ambush_battle");
  common_scripts\utility::flag_init("music_ambush_battle_ends");
  common_scripts\utility::flag_init("music_chase_start");
  common_scripts\utility::flag_init("music_chase_ending");
  common_scripts\utility::flag_init("sfx_landed_crate");
  common_scripts\utility::flag_init("audio_notrain");
  common_scripts\utility::flag_init("sfx_slowmo_begins");
  common_scripts\utility::flag_init("audio_end_thunder");
  common_scripts\utility::flag_init("trigger_hall");
  common_scripts\utility::flag_init("trigger_sat_room");
  common_scripts\utility::flag_init("mix_tunnel_open");
  common_scripts\utility::flag_init("sfx_dont_play_desk");
  common_scripts\utility::flag_init("end_scene");
  common_scripts\utility::flag_init("final_music_cue_explosion");
}

mission_music() {
  jump_to_music_flag_setup();
  level.special_amb_is_playing = 0;

  if(isDefined(level.jump_to_amb_alias))
    wait 0.01;

  switch (level.start_point) {
    case "default":
    case "intro":
      common_scripts\utility::flag_wait("music_stealth_intro");
    case "powerstealth":
    case "factory_ingress":
    case "intro_train":
      if(getDvar("music_enable") == "1")
        maps\_utility::music_play("mus_factory_powerstealth");

      common_scripts\utility::flag_wait("powerstealth_end");
      maps\_utility::music_stop(30);
      thread audio_start_shuffle_emitter();
    case "greenlight":
    case "weapon_security":
    case "chase":
    case "parking_lot":
    case "rooftop":
    case "ambush_escape":
    case "ambush":
    case "sat_room":
      common_scripts\utility::flag_wait("music_chase_start");
      maps\_utility::music_play("mus_factory_rooftop");
      common_scripts\utility::flag_wait("end_scene");
      wait 0.75;
      maps\_utility::music_crossfade("mus_factory_carchase_stinger", 1.5);
      common_scripts\utility::flag_wait("final_music_cue_explosion");
      maps\_utility::music_play("mus_factory_carchase", 0.1);
    case "face_off":
      common_scripts\utility::flag_wait("music_wait_forever");
  }
}

jump_to_music_flag_setup() {
  level.jump_to_amb_alias = "factory_jungle_ext";

  if(level.start_point == "intro") {
    return;
  }
  level.jump_to_amb_alias = "factory_intro_ext";
  common_scripts\utility::flag_set("music_jungle_slide");

  if(level.start_point == "intro_train") {
    return;
  }
  common_scripts\utility::flag_set("music_stealth_intro");
  common_scripts\utility::flag_set("music_chk_ingress");
  common_scripts\utility::flag_set("audio_end_thunder");

  if(level.start_point == "factory_ingress") {
    return;
  }
  thread audio_start_shuffle_emitter();
  level.jump_to_amb_alias = "factory_powerstealth";
  common_scripts\utility::flag_set("music_factory_reveal");

  if(level.start_point == "powerstealth") {
    return;
  }
  if(level.start_point == "weapon_security") {
    return;
  }
  if(level.start_point == "presat_room") {
    return;
  }
  level.jump_to_amb_alias = "factory_sat_room";

  if(level.start_point == "sat_room") {
    return;
  }
  common_scripts\utility::flag_set("music_chk_ambush");

  if(level.start_point == "ambush") {
    level.jump_to_amb_alias = "factory_wh1_greenlight";
    return;
  }

  if(level.start_point == "greenlight") {
    level.jump_to_amb_alias = "factory_before_tank_room";
    return;
  }

  common_scripts\utility::flag_set("music_ambush_battle");
  common_scripts\utility::flag_set("music_chk_ambush_escape");
  level.jump_to_amb_alias = "factory_office_before_hallway";
  thread sfx_ambush_alarm_sound();

  if(level.start_point == "ambush_escape") {
    return;
  }
  common_scripts\utility::flag_set("music_chk_rooftop");
  level.jump_to_amb_alias = "factory_hallway_bf_rooftop";

  if(level.start_point == "rooftop") {
    return;
  }
  common_scripts\utility::flag_set("music_chase_start");
  common_scripts\utility::flag_set("music_chk_parkinglot");
  level.jump_to_amb_alias = "factory_rooftop_ext";

  if(level.start_point == "parking_lot") {
    return;
  }
  common_scripts\utility::flag_set("music_chk_chase");

  if(level.start_point == "chase") {
    return;
  }
  common_scripts\utility::flag_set("music_chk_crash");

  if(level.start_point == "face_off")
    return;
}

aud_binoculars_foley() {
  self playSound("fly_binoc_foley");
}

aud_binoculars_vision_on() {
  self playSound("fly_binoc_vision_on");
}

aud_binoculars_vision_off() {
  self playSound("fly_binoc_vision_off");
}

aud_binoculars_bg_loop() {
  var_0 = spawn("script_origin", self.origin);
  var_0 playLoopSound("fly_binoc_bg_loop");
  self waittill("stop_binocular_bg_loop_sound");
  var_0 stoploopsound();
  var_0 delete();
}

aud_binoculars_zoom_in() {
  self playSound("fly_binoc_zoom_in");
}

aud_binoculars_zoom_out() {
  self playSound("fly_binoc_zoom_out");
}

aud_binoculars_on_target() {
  wait 0.1;
  self playSound("fly_binoc_scan_positive");
}

aud_binoculars_scan_loop() {
  var_0 = spawn("script_origin", self.origin);
  var_0 playLoopSound("fly_binoc_scan_loop");
  common_scripts\utility::waittill_any("stop_binocular_scan_loop_sound", "stop_binocular_bg_loop_sound");
  var_0 stoploopsound();
  var_0 delete();
}

aud_binoculars_scan_positive() {
  self playSound("fly_binoc_scan_positive");
}

aud_binoculars_scan_negative() {
  self playSound("fly_binoc_scan_negative");
}

sfx_bak_mudslide() {
  wait 0.6;
  common_scripts\utility::play_sound_in_space("scn_factory_mudslide_baker", (1325, 6387, 722));
}

sfx_mudslide_trigger_setup() {
  var_0 = getent("trigger_mudslide_sfx", "targetname");
  var_0 thread sfx_plr_mudslide();
}

sfx_plr_mudslide() {
  self waittill("trigger");
  level.player playSound("scn_factory_mudslide_plr");
}

sfx_crate_trigger_setup() {
  var_0 = getent("trigger_crate_land", "targetname");
  var_0 thread sfx_crate_trigger();
}

sfx_mud_trigger_setup() {
  var_0 = getent("trigger_mud_land", "targetname");
  var_0 thread sfx_mud_trigger();
}

sfx_crate_trigger() {
  self waittill("trigger");
  level.player playSound("scn_factory_intro_land_crate");
  common_scripts\utility::flag_set("sfx_landed_crate");
}

sfx_mud_trigger() {
  self waittill("trigger");

  if(!common_scripts\utility::flag("sfx_landed_crate"))
    level.player playSound("scn_factory_intro_land_ground");
}

sfx_land_crate() {}

sfx_land_ground() {}

sfx_train_sound() {
  wait 0.1;
}

sfx_create_conveyor_line_emitter() {
  level.conveyor_entarray = getEntArray("conveyor_line_emitter_sfx", "targetname");
}

sfx_create_jungle_line_emitter() {
  level.jungle_entarray = getEntArray("jungle_line_emitter_sfx", "targetname");
}

sfx_create_truckyard_line_emitter() {
  level.truckyard_entarray = getEntArray("truckyard_line_emitter_sfx", "targetname");
}

sfx_create_movingcover2_line_emitters() {
  level.movingcover2_entarray = getEntArray("movingcover2_line_emitter_sfx", "targetname");
  level.movingcover2b_entarray = getEntArray("movingcover2b_line_emitter_sfx", "targetname");
}

start_conveyor_line_emitter() {
  common_scripts\utility::flag_wait("music_factory_reveal");
  thread play_linear_sfx_conveyor(level.conveyor_entarray, "emt_conveyor_belt_loop", "music_ambush_battle");
}

start_jungle_line_emitter() {
  common_scripts\utility::flag_wait("music_jungle_slide");
}

start_truckyard_line_emitter() {
  if(!common_scripts\utility::flag("audio_notrain"))
    common_scripts\utility::flag_wait("trig_intro_vignette");

  wait 2;
  thread play_truckyard_pa();
}

play_truckyard_pa() {
  var_0 = spawn("script_origin", (3703, 3790, 346));

  while(!common_scripts\utility::flag("entered_factory_1")) {
    var_0 playSound("emt_factory_truckyard_pa");
    wait 2;

    if(common_scripts\utility::flag("entered_factory_1")) {
      break;
    }

    wait(randomfloatrange(4.0, 6.0));
  }

  wait 5;
  var_0 delete();
}

play_linear_sfx_truckyard(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = 0;

  for(;;) {
    if(common_scripts\utility::flag("entered_factory_1")) {
      break;
    }

    var_3 = pointonsegmentnearesttopoint((3703.7, 3790.7, 346.1), (686.4, 4396.5, 367.1), level.player.origin);
    var_1 moveto(var_3, 0.01);

    if(var_2 == 0) {
      var_1 playLoopSound(var_0);
      var_2 = 1;
    }

    wait 0.1;
  }
}

start_movingcover2_sfx_loops() {
  common_scripts\utility::flag_wait("music_factory_reveal");
}

play_linear_sfx_conveyor(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self endon(var_2);

  var_3 = spawn("script_origin", (0, 0, 0));
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  for(;;) {
    var_7 = 0;
    var_8 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0, undefined, 2);

    foreach(var_10 in var_8) {
      if(var_7 == 0) {
        var_7 = 1;
        var_4 = var_10;
        continue;
      }

      var_5 = var_10;
    }

    var_12 = pointonsegmentnearesttopoint(var_4.origin, var_5.origin, level.player.origin);
    var_3 moveto(var_12, 0.01);

    if(var_6 == 0) {
      var_3 playLoopSound(var_1);
      var_6 = 1;
    }

    wait 0.1;
  }
}

audio_crane_movement_factory_reveal_01(var_0, var_1, var_2) {}

audio_crane_movement_factory_reveal_02(var_0, var_1, var_2) {}

audio_sfx_truck_idle_loop_start() {
  common_scripts\utility::flag_wait("factory_exterior_reveal");
  var_0 = level.intro_truck_cab;
  level.truckidlesfx_intro = spawn("script_origin", var_0.origin + (100, 0, 60));
  level.truckidlesfx_intro linkto(var_0);
  level.truckidlesfx = spawn("script_origin", var_0.origin + (100, 0, 60));
  level.truckidlesfx linkto(var_0);
  common_scripts\utility::flag_wait("music_stealth_intro");

  if(!common_scripts\utility::flag("music_chk_powerstealth"))
    wait 3;

  waittillframeend;
  common_scripts\utility::flag_wait("player_entered_awning");
  wait 1;
}

audio_sfx_truck_in_start() {
  common_scripts\utility::flag_wait("factory_exterior_reveal");
  common_scripts\utility::flag_set("audio_end_thunder");
  level.truckmovesfx = spawn("script_origin", level.intro_truck_cab.origin + (100, 0, 60));
  level.truckmovesfx linkto(level.intro_truck_cab);
  waittillframeend;
  level.truckmovesfx playSound("scn_factory_truckinengine");
}

stop_2d_rain_layer() {
  if(isDefined(level.rain_loop_2d)) {
    wait 0.6;
    level.rain_loop_2d stopsounds();
    wait 0.1;
    level.rain_loop_2d delete();
  }
}

audio_sfx_truck_chatter(var_0, var_1) {
  common_scripts\utility::flag_wait("player_entered_awning");
  self endon("intro_truck_driver_dead");
  var_0[0] endon("death");
  var_0[1] endon("death");
  var_0[2] endon("death");
  level.truckchatter = spawn("script_origin", level.intro_truck_cab.origin + (300, 0, 60));
  level.truckchatter linkto(level.intro_truck_cab);
  waittillframeend;
  var_2 = maps\_utility::get_living_ai("entrance_enemy_02", "script_noteworthy");
  var_3 = maps\_utility::get_living_ai("intro_truck_driver", "script_noteworthy");
  var_4 = maps\_utility::get_living_ai("entrance_enemy_03", "script_noteworthy");
  wait 1;

  if(isDefined(var_2))
    var_2 playSound("factory_vs1_holdon");

  wait 6;

  if(isDefined(var_3))
    var_3 playSound("factory_vs2_heavyload");

  wait 4;

  if(isDefined(var_4))
    var_4 playSound("factory_vs3_expectingyou");

  wait 7.5;

  if(isDefined(var_3))
    var_3 playSound("factory_vs2_seethat");

  wait 5.8;

  if(isDefined(var_4))
    var_4 playSound("factory_vs3_yeahsorry");

  wait 4;

  if(isDefined(var_3))
    var_3 playSound("factory_vs2_secretaccount");

  wait 5;

  if(isDefined(var_4))
    var_4 playSound("factory_vs3_doubleworkload");
}

audio_factory_search_body() {
  wait 0.1;
  level.squad["ALLY_CHARLIE"] playSound("scn_factory_search_body");
}

audio_sfx_factory_distant_loop_start() {
  level.distfactorysfx = spawn("script_origin", (5400, 1900, 0));
  level.constantfactorysfx = spawn("script_origin", (4800, 1800, 0));
  level.distfactorysfx playLoopSound("emt_factory_ominous_lp");
  level.constantfactorysfx playLoopSound("emt_factory_dist_lp");
}

audio_sfx_truck_idle_loop_stop() {}

audio_sfx_alternate_rolling_loop_alias() {
  if(level.rollingloop == "emt_movingcover2_rolling1_loop")
    level.rollingloop = "emt_movingcover2_rolling2_loop";
  else
    level.rollingloop = "emt_movingcover2_rolling1_loop";
}

audio_sfx_car_chase_sequence() {}

audio_car_explode() {
  common_scripts\utility::play_sound_in_space("explo_metal_rand", self.origin);
}

audio_factory_door_open() {
  var_0 = getent("factory_entrance_door", "script_noteworthy");
  var_0 playSound("scn_factory_garage_door_open");
}

audio_factory_unlock_sound() {}

audio_setup_factory_reveal_ambience_triggers() {
  var_0 = getent("swap_to_amb_ext", "targetname");
  var_0 thread audio_factory_ambient_switch_to_ext();
  var_1 = getent("swap_to_amb_int", "targetname");
  var_1 thread audio_factory_ambient_switch_to_int();
}

audio_factory_ambient_switch_to_ext() {
  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("music_factory_reveal")) {
      if(level.special_amb_is_playing == 0) {
        level.factoryrevealambience playLoopSound("emt_factory_int_amb_from_ext");
        level.special_amb_is_playing = 1;
        wait 0.1;
      }
    }

    while(level.player istouching(self))
      wait 0.1;
  }
}

audio_factory_ambient_switch_to_int() {
  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("music_factory_reveal")) {}

    while(level.player istouching(self))
      wait 0.1;
  }
}

audio_start_shuffle_emitter() {}

audio_start_positional_fake_int_amb(var_0) {
  level.factoryrevealambience playLoopSound("emt_factory_int_amb_from_ext");
  level.special_amb_is_playing = 1;
  wait 0.1;

  if(isDefined(var_0)) {
    if(var_0 == "TRUE")
      return;
  }
}

audio_fade_in_int_amb() {
  level notify("positional_ambience_fading_in");
  level endon("positional_ambience_fading_out");
  wait 4.6;
}

audio_fade_out_int_amb() {
  level notify("positional_ambience_fading_out");
  level endon("positional_ambience_fading_in");
  wait 4.6;

  if(level.special_amb_is_playing == 1) {
    level.factoryrevealambience stoploopsound();
    level.special_amb_is_playing = 0;
  }
}

audio_trainpass_chkpt() {
  common_scripts\utility::flag_set("audio_notrain");
}

audio_train_constant_loop() {
  if(!common_scripts\utility::flag("audio_notrain")) {
    level.constanttrainloop1 = spawn("script_origin", (2500, 5200, 375));
    level.constanttrainloop1 playLoopSound("scn_factory_train_constant_01");
    level.constanttrainloop2 = spawn("script_origin", (2100, 5200, 375));
    level.constanttrainloop2 playLoopSound("scn_factory_train_constant_02");
    level.constanttrainloop3 = spawn("script_origin", (1200, 5200, 375));
    level.constanttrainloop3 playLoopSound("scn_factory_train_constant_03");
    common_scripts\utility::flag_wait("player_near_train_kill");
    wait 2.3;
    thread audio_train_last_car_passby();
    wait 1;
    level.player setclienttriggeraudiozone("factory_intro_ext_trains_down", 3);
    wait 3;
    level.constanttrainloop1 stoploopsound();
    level.constanttrainloop2 stoploopsound();
    level.constanttrainloop3 stoploopsound();
    level.constanttrainloop1 delete();
    level.constanttrainloop2 delete();
    level.constanttrainloop3 delete();
    level.player clearclienttriggeraudiozone(0.2);
  }
}

audio_train_last_car_passby() {
  wait 0.6;
  var_0 = spawn("script_origin", (3200, 5200, 375));
  var_0 playSound("scn_factory_train_clacks_final_by");
  var_0 movex(-1500, 6.3, 0, 0);
}

audio_start_train_click_clacks() {
  if(!common_scripts\utility::flag("audio_notrain")) {
    thread audio_train_click_clacks_1();
    thread audio_train_click_clacks_2();
  }
}

audio_train_click_clacks_1() {
  for(;;) {
    if(!common_scripts\utility::flag("player_near_train_kill")) {
      thread audio_train_individual_click_clack("scn_factory_train_clacks_a");
      wait(randomfloatrange(1.05, 1.4));
      continue;
    }

    break;
  }

  thread audio_train_individual_click_clack("scn_factory_train_clacks_a");
  wait 1.4;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_a");
  wait 1.4;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_a");
  wait 1.4;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_a", -500);
  wait 1.4;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_a", -1500);
  wait 1.4;
}

audio_train_click_clacks_2() {
  thread audio_train_clacks_2_last();

  for(;;) {
    if(!common_scripts\utility::flag("player_near_train_kill")) {
      thread audio_train_individual_click_clack("scn_factory_train_clacks_b", 600, 2.5, -1400);
      wait(randomfloatrange(4.5, 6.5));
      continue;
    }

    break;
  }
}

audio_train_clacks_2_last() {
  common_scripts\utility::flag_wait("player_near_train_kill");
  wait 2.5;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_b", 600, 2.5, -1400);
  wait 2;
  thread audio_train_individual_click_clack("scn_factory_train_clacks_b", 300, 2.5, -1400);
}

audio_train_individual_click_clack(var_0, var_1, var_2, var_3) {
  var_4 = 2500;
  var_5 = 0.874;
  var_6 = -900;

  if(isDefined(var_1))
    var_4 = var_4 + var_1;

  if(isDefined(var_2))
    var_5 = var_2;

  if(isDefined(var_3))
    var_6 = var_3;

  var_7 = spawn("script_origin", (var_4, 5200, 375));
  var_7 playSound(var_0, "donewiththissound");
  var_7 movex(var_6, var_5, 0, 0);
  var_7 waittill("donewiththissound");
  wait 0.1;
  var_7 delete();
}

audio_play_unlock_sound() {
  wait 0.3;
  thread sfx_play_security_beep();
  wait 0.3;
  common_scripts\utility::play_sound_in_space("scn_factory_door_security_unlock", (4923, 3366, 300));
}

sfx_play_security_beep() {
  common_scripts\utility::play_sound_in_space("scn_factory_door_security_beep_success", (4729, 3357, 289));
}

audio_powerstealth_gate_unlock() {
  wait 1;
  common_scripts\utility::play_sound_in_space("scn_factory_powerstealth_gate_unlock", (6524, 2859, 396));
}

audio_powerstealth_gate_open() {
  common_scripts\utility::play_sound_in_space("scn_factory_powerstealth_gate_open", (6524, 2859, 396));
}

audio_crate_move(var_0) {
  thread maps\_utility::play_loop_sound_on_tag("emt_factory_rollers", var_0);
}

audio_crate_move_above_door() {
  self playLoopSound("emt_factory_rollers_above_door");
}

audio_distant_train_horn() {
  wait 0.2;
  common_scripts\utility::play_sound_in_space("scn_factory_dist_train_horn", (4923, 3366, 300));
}

audio_player_intro() {
  wait 0.01;
  level.player playSound("scn_factory_intro_player_lr");
}

audio_baker_intro() {
  thread audio_ally_intro_knife_pullout();
  wait 0.65;
  self playSound("scn_factory_intro_baker");
}

audio_plr_intro_knife_pullout() {
  self playSound("scn_factory_intro_plrknife");
}

audio_ally_intro_knife_pullout() {
  wait 14.854;
  self playSound("scn_factory_intro_allyknife");
}

audio_player_intro_jump_kill() {
  level.player playSound("scn_factory_intro_playerjumpkill");
}

audio_ally_intro_jump_kill() {
  wait 2.65;
  self playSound("scn_factory_intro_allyjumpkill");
  common_scripts\utility::flag_set("music_stealth_intro");
  stop_2d_rain_layer();
}

audio_ally_intro_jump_kill_short() {
  wait 0.44;
  self playSound("scn_factory_intro_allyjumpkill");
  common_scripts\utility::flag_set("music_stealth_intro");
  stop_2d_rain_layer();
}

audio_player_train_track_stealth_kill() {
  level.player playSound("scn_factory_player_train_kill");
  thread sfx_hey_vo_line();
  wait 0.316;
  level.player playSound("factory_train_tacks_npc_death");
}

sfx_hey_vo_line() {
  var_0 = spawn("script_origin", (0, 0, 0));
  wait 0.316;
  var_0 playSound("factory_train_tacks_npc_vo");
}

audio_sfx_truck_pull_away_start() {
  if(level.start_point != "factory_ingress") {
    level.truckenginesfx = spawn("script_origin", level.intro_truck_cab.origin);
    level.truckenginesfx linkto(level.intro_truck_cab);
    level.truckenginesfx playSound("scn_factory_truckawayengine");
    wait 9;
    level.truckenginesfx delete();
  }
}

audio_factory_intro_mix() {
  level.player setvolmod("vehicle_npc", 0.4, 1);
  wait 14;
  level.player setvolmod("vehicle_npc", 1, 1);
}

audio_factory_reveal_mix(var_0) {
  if(var_0 == "one") {
    wait 0.2;
    level.player setvolmod("max", 0.45, 1);
    level.player setvolmod("emitter", 0.45, 1);
    level.player setvolmod("element", 0.45, 1);
  } else if(var_0 == "two") {
    level.player setvolmod("max", 0.7, 1);
    level.player setvolmod("emitter", 0.7, 1);
    level.player setvolmod("element", 0.7, 1);
  } else if(var_0 == "three") {
    wait 2;
    level.player setvolmod("max", 1, 1);
    level.player setvolmod("emitter", 1, 1);
    level.player setvolmod("element", 1, 1);
  }
}

audio_factory_wait_for_mix_change() {
  wait 1.5;
  audio_factory_reveal_mix("two");
}

ambush_line_emitter_create() {
  var_0 = [];
  var_0[0] = spawn("script_origin", (4876, -495, 325));
  var_0[1] = spawn("script_origin", (4658, -1873, 352));
  ambush_line_emitter_logic(var_0, "scn_factory_assembly_back_lp", "ambush_escape_spawn_helis");
}

ambush_line_emitter_logic(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self endon(var_2);

  var_3 = spawn("script_origin", (0, 0, 0));
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;

  for(;;) {
    var_7 = 0;
    var_8 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0, undefined, 2);

    foreach(var_10 in var_8) {
      if(var_7 == 0) {
        var_7 = 1;
        var_4 = var_10;
        continue;
      }

      var_5 = var_10;
    }

    var_12 = pointonsegmentnearesttopoint(var_4.origin, var_5.origin, level.player.origin);
    var_3 moveto(var_12, 0.01);

    if(var_6 == 0) {
      var_3 playLoopSound(var_1);
      var_6 = 1;
    }

    wait 0.1;
  }
}

sfx_glass_door_open(var_0) {
  var_0 playSound("scn_factory_glass_door_open");
}

sfx_glass_door_close(var_0) {
  var_0 playSound("scn_factory_glass_door_close");
}

sfx_metal_door_unlock() {
  wait 0.7;
  common_scripts\utility::play_sound_in_space("scn_factory_door_unlock", (8135, -160, 309));
}

sfx_metal_door_open(var_0) {
  var_0 playSound("scn_factory_metal_door_open");
}

sfx_metal_door_close(var_0) {
  var_0 playSound("scn_factory_metal_door_close");
}

sfx_revolving_door_unlock(var_0) {
  wait 0.5;
  var_0 playSound("scn_factory_door_unlock");
}

sfx_revolving_door_open(var_0) {
  var_0 playSound("scn_factory_revolving_door");
}

sfx_sat_room_lights(var_0) {
  self playSound(var_0);
}

sfx_sat_room_panel_railing() {
  self playSound("scn_factory_sat_panel_railing");
}

sfx_sat_room_panel_pry_open() {
  self playSound("scn_factory_sat_panel_pry");
}

sfx_sat_room_panel_pull_panel() {
  level endon("sat_room_player_pulled");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("sat_pull_anim_past_15", "sat_pull_anim_past_45", "sat_pull_anim_past_65");

    switch (var_0) {
      case "sat_pull_anim_past_15":
        level.playing_sat_anim_sound = 1;
        iprintln("Creak");
        wait(randomfloatrange(1.1, 2.75));
        level.playing_sat_anim_sound = 0;
        break;
      case "sat_pull_anim_past_45":
        level.playing_sat_anim_sound = 1;
        iprintln("Stretch");
        wait(randomfloatrange(1.1, 2.75));
        level.playing_sat_anim_sound = 0;
        break;
      case "sat_pull_anim_past_65":
        level.playing_sat_anim_sound = 1;
        iprintln("Pop");
        wait(randomfloatrange(1.1, 2.75));
        level.playing_sat_anim_sound = 0;
        break;
      default:
    }

    wait 0.1;
  }
}

sfx_sat_room_panel_panel_flip() {
  self playSound("scn_factory_sat_panel_flip");
}

sfx_sat_room_panel_hand_off_sfx() {
  wait 4.1;
  self playSound("scn_factory_sat_panel_hand");
}

greenlight_amb_change() {
  level.tankroom_node = spawn("script_origin", (5412, 134, 453));
  level.tankroom_node playLoopSound("scn_factory_greenlight_opening_lp");
  level.tankroom_node scalevolume(0.0, 0.0);
  wait 0.8;
  level.tankroom_node scalevolume(1.0, 1.0);
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("scn_factory_greenlight_opening", (6038, 289, 428));
  common_scripts\utility::flag_wait("trigger_tank_room_volume");
  level.tankroom_node scalevolume(0.0, 2.0);
  wait 2.1;
  level.tankroom_node delete();
}

garage_sfx_reveal() {
  wait 0.1;
  level.garage_node = spawn("script_origin", (5200, 3000, 400));
  level.garage_node playSound("scn_factory_garage_reveal");
  wait 9;
  wait 5;
  wait 15;
  level.garage_node delete();
}

sfx_garage_reveal_crane() {
  wait 0.54;
  level.crane_beam = getent("reveal_crane_org", "targetname");
  level.crane_beam playSound("scn_factory_garage_reveal_crane");
  thread sfx_reveal_mix_down();
  wait 0.1;
  level.reveal_filtered_node stoploopsound("scn_factory_garage_reveal_filtered");
  level.reveal_filtered_node delete();
}

sfx_garage_reveal_filtered() {
  wait 0.1;
  level.reveal_filtered_node = spawn("script_origin", (4937, 3279, 300));
  level.reveal_filtered_node playLoopSound("scn_factory_garage_reveal_filtered");
}

sfx_reveal_mix_down() {}

sfx_rods_move() {
  var_0 = getent("satellite_ROG_05_org", "targetname");
  var_0 playSound("scn_factory_rods_mvmt");
  level.rog_verb = spawn("script_origin", (0, 0, 0));
  level.rog_verb linkto(level.player);
  level.rog_verb playSound("scn_factory_rods_verb_lr");
  thread sfx_rods_hallway_start();
}

sfx_rods_hallway_start() {
  wait 0.1;
  level.hallway_rog_mvmt playSound("scn_factory_rods_hall_mvmt_start");
  wait 0.6;
  level.hallway_rog_mvmt playLoopSound("scn_factory_rods_hall_mvmt");
}

sfx_rods_hallway_stop() {
  if(isDefined(level.hallway_rog_mvmt)) {
    level.hallway_rog_stop = spawn("script_origin", (7610, -150, 316));
    level.hallway_rog_stop playSound("scn_factory_rods_hall_mvmt_end");
    level.hallway_rog_mvmt stoploopsound("scn_factory_rods_hall_mvmt");
    wait 3;
    level.hallway_rog_mvmt delete();
    level.hallway_rog_stop delete();
  }
}

sfx_rods_load() {
  var_0 = getent("satellite_room_rog_holder_org", "targetname");
  var_0 playSound("scn_factory_rods_load");
}

sfx_bridge_lower(var_0) {
  var_0 playSound("scn_factory_bridge_lower");

  if(isDefined(level.moving_platform)) {
    level.moving_platform stopsounds();
    wait 0.1;
    level.moving_platform delete();
  }
}

ambush_start_intro_foley_sfx() {
  level.player playSound("scn_factory_ambush_intro");
  level.factory_ambush_props["factory_ambush_keyboard02"] thread ambush_start_intro_ally_typing_sfx();
  level.factory_ambush_props["factory_ambush_monitor01"] thread ambush_start_intro_computer_sfx();
  level.player thread ambush_start_intro_power_down_sfx();
  wait 0.1;

  if(isDefined(level.keegan_search_desk_sfx)) {
    level.player setclienttriggeraudiozone("factory_wh1_ambush_control_room_2", 0.01);
    wait 1;
    level.keegan_search_desk_sfx stopsounds();
    level.keegan_search_desk_sfx delete();
    wait 2;
    level.player clearclienttriggeraudiozone(0.2);
  } else
    common_scripts\utility::flag_set("sfx_dont_play_desk");
}

ambush_start_intro_computer_sfx() {
  wait 4.3;
  self playSound("scn_factory_ambush_computer");
}

ambush_pre_start_ally1_typing_sfx() {
  wait 8;
  var_0 = spawn("script_origin", (5708, -696, 300));
  var_0 playSound("scn_factory_ambush_ally_typing", "type_1_done");
  var_0 waittill("type_1_done");

  while(!common_scripts\utility::flag("player_used_computer")) {
    var_0 playSound("scn_factory_ambush_ally_typing", "type_1_done_2");
    var_0 waittill("type_1_done_2");
  }

  var_0 stopsounds();
  wait 0.5;
  var_0 delete();
}

ambush_pre_start_ally2_typing_sfx() {
  wait 13.5;
  var_0 = spawn("script_origin", (5820, -753, 300));
  var_0 playSound("scn_factory_ambush_ally_typing", "type_2_done");
  var_0 waittill("type_2_done");

  while(!common_scripts\utility::flag("player_used_computer")) {
    var_0 playSound("scn_factory_ambush_ally_typing", "type_2_done_2");
    var_0 waittill("type_2_done_2");
  }

  var_0 stopsounds();
  wait 0.5;
  var_0 delete();
}

ambush_start_intro_ally_typing_sfx() {
  wait 1.257;
  self playSound("scn_factory_ambush_ally_typing");
}

ambush_start_intro_power_down_sfx() {
  wait 15.467;
  self playSound("scn_factory_ambush_power_down");
}

ambush_battle_start_ambience_change() {
  thread ambush_door_explo_sfx();
  thread ambush_ally_fire_weapon_sfx();
  level.player playSound("scn_factory_ambush_door_breach_lr");
  level.player setclienttriggeraudiozone("factory_wh1_ambush_slomo", 0.01);
  common_scripts\utility::flag_set("sfx_slowmo_begins");
  wait 2.4;
  level.player clearclienttriggeraudiozone(0.2);
}

ambush_door_explo_sfx() {
  thread common_scripts\utility::play_sound_in_space("scn_factory_ambush_explo", (5553, -648, 318));
  wait 0.08;
  thread common_scripts\utility::play_sound_in_space("scn_factory_ambush_explo_hit", (5553, -648, 318));
  wait 0.38;
  thread common_scripts\utility::play_sound_in_space("scn_factory_ambush_explo_debris", (5553, -648, 318));
}

ambush_ally_fire_weapon_sfx() {
  wait 1.7;
  level.squad["ALLY_ALPHA"] playSound("scn_factory_ambush_ally_fire");
}

ambush_start_fx_sounds() {
  common_scripts\utility::play_loopsound_in_space("emt_ambush_fire_lp", (5198, -2361, 294));
  common_scripts\utility::play_loopsound_in_space("emt_ambush_fire_lp", (4728, -2638, 398));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (5193, -2230, 297));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (4924, -2709, 507));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (4040, -2704, 495));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_05", (5263, -1547, 708));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_04", (3601, -2704, 428));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_04", (4058, -2704, 460));
}

sfx_ambush_alarm_sound() {
  wait 0.5;
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_01", (5559, -698, 394));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_01", (5994, -936, 402));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (5873, -466, 369));
  common_scripts\utility::play_loopsound_in_space("emt_ambush_fire_lp", (5198, -2361, 294));
  common_scripts\utility::play_loopsound_in_space("emt_ambush_fire_lp", (4728, -2638, 398));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (5193, -2230, 297));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (4924, -2709, 507));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (4040, -2704, 495));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_05", (5263, -1547, 708));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_05b", (3658, -2102, 507));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_04", (4058, -2704, 460));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_04", (4012, -1443, 428));
  common_scripts\utility::play_loopsound_in_space("emt_factory_ambush_alarm_02", (3931, -1780, 426));
}

ambush_smoke_grenade_explo_sfx() {
  thread common_scripts\utility::play_sound_in_space("scn_factory_ambush_smoke_explo01", (5658, -1255, 280));
  wait 0.4;
  thread common_scripts\utility::play_sound_in_space("scn_factory_ambush_smoke_explo02", (5317, -733, 280));
}

sfx_pa_bursts() {}

sfx_stop_truckchatter() {
  level.truckchatter stopsounds();
}

sfx_rolling_gate_sounds(var_0) {}

sfx_play_stacker_down() {
  common_scripts\utility::delaycall(0.15, ::playsound, "emt_factory_stacker_down");
}

sfx_play_stacker_up() {
  common_scripts\utility::delaycall(0.15, ::playsound, "emt_factory_stacker_up");
}

sfx_end_slomo_sound() {
  level.player playSound("scn_factory_ambush_slomo_end");
}

sfx_play_crash_scene() {
  wait 0.2;
  self playSound("scn_factory_chase_truck_intro");
  level.factory_car_chase_intro_broken_light_post thread sfx_chase_truck_intro_lamp_post();
  thread sfx_chase_truck_intro_spawn_emitters();
  level waittill("semi_stopped");
  level.ally_vehicle_trailer playSound("scn_factory_chase_truck_pullaway");
  wait 0.788;
  level.ally_vehicle_trailer playSound("scn_factory_chase_truck_tires");
  common_scripts\utility::flag_wait("player_mount_vehicle_start");
  level.player playSound("scn_factory_chase_truck_mount");
  wait 1.0;
  level.player setclienttriggeraudiozone("factory_car_chase_ext", 2.0);
  wait 2.5;
  level.player setclienttriggeraudiozone("factory_car_chase_ext_truck_vol_down", 1.0);
}

sfx_chase_truck_intro_spawn_emitters() {
  wait 7.722;
  thread common_scripts\utility::play_loopsound_in_space("emt_factory_chase_fire_lp", (-775, -876, 44));
  thread common_scripts\utility::play_loopsound_in_space("emt_factory_chase_fire_lp", (-957, -890, 116));
  thread common_scripts\utility::play_loopsound_in_space("emt_factory_chase_fire_lp", (-1421, -863, 116));
  thread common_scripts\utility::play_loopsound_in_space("emt_factory_firehydrant_spray_loop", (-734, -891, 44));
}

sfx_play_heartbeat_sound() {
  level.heartbeat_sound = spawn("script_origin", (4800, 1800, 1));
  level.heartbeat_sound playLoopSound("emt_factory_heartbeat_controlroom");
  common_scripts\utility::flag_wait("sfx_slowmo_begins");
  wait 0.1;
  level.heartbeat_sound stopsounds();
  level.heartbeat_sound delete();
}

sfx_explo_after_flashbang() {
  common_scripts\utility::play_sound_in_space("explo_after_flashbang", (5313, -2226, 326));
}

sfx_keegan_desk() {
  if(!common_scripts\utility::flag("sfx_dont_play_desk")) {
    level.keegan_search_desk_sfx = spawn("script_origin", self.origin);
    level.keegan_search_desk_sfx linkto(self);
    level.keegan_search_desk_sfx playSound("scn_factory_keegan_search_desk");
  }
}

sfx_jeep_drive_up_01() {
  self vehicle_turnengineoff();
  common_scripts\utility::play_sound_in_space("scn_factory_chase_enemy_jeep_drive_up", (-1069, -455, 44));
}

sfx_jeep_drive_up_02() {
  self vehicle_turnengineoff();
}

sfx_chase_truck_intro_lamp_post() {
  wait 7.722;
  self playSound("scn_factory_chase_truck_intro_lamp");
}

sfx_tank_drive_up() {
  wait 0.7;
  self vehicle_turnengineoff();
  self playSound("scn_factory_chase_enemy_tank_drive_up");
}

sfx_introkill_splash_player() {
  level.player playSound("warl_towerstab_grab");
  level.player playSound("scn_factory_intro_water_splash");
  level.player playSound("warl_towerstab_slice");
  wait 0.15;
  level.player playSound("scn_factory_intro_water_splash");
  wait 0.17;
  level.player playSound("scn_factory_intro_water_splash");
}

sfx_introkill_splash_baker() {
  level.player playSound("scn_factory_intro_water_splash");
  wait 0.15;
  level.player playSound("scn_factory_intro_water_splash");
  wait 1.27;
  level.player playSound("scn_factory_intro_water_splash");
  wait 0.1;
  level.player playSound("warl_towerstab_slice");
}

sfx_intro_helicopter_and_splash(var_0) {
  var_0 playSound("scn_factory_introhelicopter_pass");
  level.player playSound("scn_factory_intro_water_splash");
}

moving_platform_warning_beeps_sfx(var_0) {
  level.moving_platform = spawn("script_origin", var_0 - (300, 0, -200));
  level.moving_platform linkto(self);
  wait 1.5;
  level.moving_platform playLoopSound("emt_factory_moving_platform_beeps");
}

moving_platform_movement_loop_sfx(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 30;

  var_2 = spawn("script_origin", var_0);
  var_2 linkto(self);
  var_3 = spawn("script_origin", var_0);
  var_3 linkto(self);
  var_4 = spawn("script_origin", var_0);
  var_4 linkto(self);
  var_2 playLoopSound("emt_moving_platform_movement_lp");
  var_3 playLoopSound("emt_moving_platform_movement_close_lp");
  var_2 scalevolume(0.0, 0.01);
  var_3 scalevolume(0.0, 0.01);
  wait 1.5;
  var_2 scalevolume(1.0, 1);
  var_3 scalevolume(1.0, 0.5);
  wait(var_1);
  var_5 = spawn("script_origin", var_3.origin);
  var_5 linkto(self);
  var_5 playSound("emt_factory_moving_platform_stop");
  wait 0.5;
  var_3 stoploopsound();
  var_4 stoploopsound();
  var_2 delete();
  var_3 delete();
}

stealth_kill_throat_stab_sfx() {
  level.player playSound("scn_factory_player_stealth_kill");
  level.player playSound("factory_sitting_desk_npc_vo");
}

stealth_kill_table_left_sfx() {
  if(isDefined(self)) {
    wait 0.16;
    self playSound("scn_factory_stealth_kill_table_left");
  }
}

stealth_kill_table_right_sfx() {
  if(isDefined(self))
    self playSound("scn_factory_stealth_kill_table_right");
}

stealth_kill_table_alert_left_sfx() {
  if(isDefined(self)) {
    wait 0.16;
    self playSound("scn_factory_stealth_kill_table_alert_left");
  }
}

stealth_kill_table_alert_right_sfx() {
  if(isDefined(self))
    self playSound("scn_factory_stealth_kill_table_alert_right");
}

stealth_kill_railing_sfx() {
  if(isalive(self)) {
    self playSound("scn_factory_stealth_kill_railing");
    self waittill("damage");
    self stopsounds();
  }
}

stealth_kill_console_sfx(var_0) {
  if(!isDefined(self.knocked_over))
    self playSound("scn_factory_stealth_kill_console");
}

stealth_kill_console_chair_sfx() {
  self playSound("scn_factory_stealth_kill_console_chair");
}

rooftop_heli_speaker_vo_sfx() {
  self endon("rooftop_spotlight_off");
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  level.sfx_heli_spkr_vo_playing = 1;
  level.heli_speaker_vo_array = [];
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_01", 2.772);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_02", 6.03);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_03", 2.579);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_04", 7.552);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_05", 3.84);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_06", 9.517);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_07", 2.684);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_08", 8.205);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_09", 4.57);
  sfx_factory_heli_spkr_vo_init("emt_heli_speaker_vo_10", 8.737);
  thread rooftop_heli_speaker_vo_watcher(var_0);
  wait 1.0;

  while(level.sfx_heli_spkr_vo_playing) {
    for(var_1 = 0; var_1 < level.heli_speaker_vo_array.size; var_1++) {
      if(level.sfx_heli_spkr_vo_playing == 0) {
        return;
      }
      var_0 playSound(level.heli_speaker_vo_array[var_1].soundalias);
      wait(level.heli_speaker_vo_array[var_1].waittime);
    }

    wait 0.02;
  }
}

sfx_factory_heli_spkr_vo_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.soundalias = var_0;
  var_2.waittime = var_1;
  level.heli_speaker_vo_array[level.heli_speaker_vo_array.size] = var_2;
}

rooftop_heli_speaker_vo_watcher(var_0) {
  self waittill("rooftop_spotlight_off");
  level.sfx_heli_spkr_vo_playing = 0;

  if(isDefined(var_0))
    var_0 thread rooftop_heli_speaker_vo_cleanup(0.1);
}

rooftop_heli_speaker_vo_cleanup(var_0) {
  if(isDefined(self)) {
    self stoploopsound();
    self delete();
  }
}

rooftop_heli_speaker_destroy() {
  wait 0.25;
  self playSound("emt_heli_speaker_vo_shootout");
}

rooftop_heli_engine_sfx() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  self playSound("scn_factory_rooftop_heli_reveal");
  thread rooftop_heli_lights_on();
  thread rooftop_heli_engine_2nd_move_watcher();
  level.player setclienttriggeraudiozonepartial("factory_hallway_bf_rooftop_heli_fadein", "mix");
  thread delete_dist_helicopter();
  wait 6.0;
  level.player setclienttriggeraudiozonepartial("factory_hallway_bf_rooftop_heli_fadein", "mix");
  wait 1.0;
  var_0 playLoopSound("scn_factory_rooftop_heli_idle_lp");
  wait 2.6;
  level.player clearclienttriggeraudiozone(6.0);
  common_scripts\utility::flag_wait("rooftop_heli_depart");
  wait 3.0;
  wait 25;
  var_0 delete();
}

delete_dist_helicopter() {
  wait 4.1;
  level.heli_engine_idle_distant_sfx delete();
}

rooftop_heli_lights_on() {
  wait 1.9;
  self playSound("emt_heli_lights_on");
}

rooftop_heli_engine_2nd_move_watcher() {
  common_scripts\utility::flag_wait("player_near_rooftop_door");
  self playSound("scn_factory_rooftop_heli_move");
}

rooftop_heli_distant_idle_sfx() {
  level.heli_engine_idle_distant_sfx = spawn("script_origin", (3894, -871, 457));
  common_scripts\utility::waitframe();
  level.heli_engine_idle_distant_sfx playLoopSound("scn_factory_rooftop_heli_distant_lp");
}

audio_play_ending_scene() {
  common_scripts\utility::flag_set("end_scene");
  thread set_end_music_cue_flag();
  level.player playSound("scn_factory_end_sequence");
  level.player setclienttriggeraudiozone("factory_car_chase_ext", 3);
}

set_end_music_cue_flag() {
  wait 4.8;
  common_scripts\utility::flag_set("final_music_cue_explosion");
}

sfx_kicking_door_sound() {
  wait 1.6;
  var_0 = spawn("script_origin", (3567, -935, 428));
  var_0 playSound("scn_factory_door_kick_ss");
  var_1 = spawn("script_origin", (3567, -935, 427));
  var_1 playSound("scn_factory_door_kick2_ss");
}

sfx_01_exp(var_0) {
  level.player playSound("scn_factory_end_exp01_lr");
}

sfx_02_exp(var_0) {
  var_1 = spawn("script_origin", (-1205, 108, 270));
  var_1 playSound("scn_factory_end_exp02_lr");
}

sfx_03_exp(var_0) {
  var_1 = spawn("script_origin", (-4656, -1180, 76));
  var_1 playSound("car_explode_factory_far");
}

sfx_04_exp(var_0) {
  var_1 = spawn("script_origin", (-7819, 302, 110));
  var_1 playSound("car_explode_factory_far");
}

sfx_05_exp(var_0) {
  var_1 = spawn("script_origin", (-7806, 1164, 110));
  var_1 playSound("grenade_explode_default_factory_close");
}

sfx_06_exp(var_0) {
  var_1 = spawn("script_origin", (-8320, 1961, 110));
  var_1 playSound("scn_factory_end_exp06_lr");
  var_2 = spawn("script_origin", (-8320, 1961, 110));
  var_2 playSound("scn_factory_end_exp06_debris");
}

sfx_07_exp(var_0) {
  var_1 = spawn("script_origin", (-9876, 1597, 420));
  var_1 playSound("scn_factory_end_exp07_lr");
}

sfx_08_exp(var_0) {
  var_1 = spawn("script_origin", (-15780, 6858, 121));
  var_1 playSound("scn_factory_end_exp08");
}

sfx_09_exp(var_0) {
  var_1 = spawn("script_origin", (-16438, 6621, 237));
  var_1 playSound("car_explode_factory_far");
}

sfx_10_exp(var_0) {
  var_1 = spawn("script_origin", (-17599, 6075, 191));
  wait 0.5;
  var_1 playSound("grenade_explode_default_factory_close");
}

sfx_11_exp(var_0) {
  var_1 = spawn("script_origin", (-19372, 5713, 142));
  var_1 playSound("scn_factory_end_exp11_lr");
  wait 0.3;
  level.ally_vehicle_trailer playSound("scn_factory_end_final_truck");
  level.player setclienttriggeraudiozone("factory_final_truck", 0.1);
}

sfx_car_impact(var_0) {
  var_1 = spawn("script_origin", (-1652, -309, 90));
  var_1 playSound("scn_factory_end_car_impact");
}

sfx_car_squeal(var_0) {
  var_0 playSound("scn_factory_end_car_squeal");
}

sfx_plane01(var_0) {
  var_1 = spawn("script_origin", (-1066, 1413, 1528));
  var_1 playSound("scn_factory_end_plane_01");
  var_1 moveto((-2832, -2288, 1656), 3);
}

sfx_plane02(var_0) {
  var_1 = spawn("script_origin", (-12614, 2954, 1739));
  var_1 playSound("scn_factory_end_plane_02");
  var_1 moveto((-7725, 2438, 1739), 3);
}

sfx_plane03(var_0) {
  var_1 = spawn("script_origin", (-19471, 8723, 1549));
  var_1 playSound("scn_factory_end_plane_02");
  var_1 moveto((-13828, 5489, 2419), 2);
}

sfx_tower_1(var_0) {
  var_1 = spawn("script_origin", (-4984, -814, 749));
  var_1 playSound("scn_factory_end_stack1");
  var_1 moveto((-6488, -1384, 200), 4);
}

sfx_tower_1_imp(var_0) {
  var_1 = spawn("script_origin", (-6488, -1277, 200));
  var_1 playSound("scn_factory_end_stack1_imp_lsrs");
}

sfx_big_tower_debris(var_0) {
  var_1 = spawn("script_origin", (-9978, 1866, 269));
  var_1 playSound("scn_factory_end_stack2");
  var_1 moveto((-14122, 8865, 344), 8);
}

sfx_tower2_imp(var_0) {
  level.player playSound("scn_factory_end_stack2_imp_debris_lr");
}

sfx_tower2(var_0) {
  level.player playSound("scn_factory_end_stack2_imp_lr");
}

sfx_tower2_exp1(var_0) {
  var_1 = spawn("script_origin", (-13103, 7616, 214));
  var_1 playSound("car_explode_factory_far");
}

sfx_tower2_exp2(var_0) {
  var_1 = spawn("script_origin", (-13103, 7616, 214));
  var_1 playSound("car_explode_factory_far");
}

sfx_falling_exp(var_0) {
  var_1 = spawn("script_origin", (-14467, 8467, 175));
  var_1 playSound("car_explode_factory_far");
}

sfx_final_explosions() {
  var_0 = spawn("script_origin", (-19372, 5713, 142));
  wait 0.5;
  var_0 playSound("scn_factory_end_expfinal");
}