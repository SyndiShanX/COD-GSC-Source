/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_intro.gsc
*****************************************************/

section_precache() {
  precacheitem("factory_knife");
  precachemodel("Viewmodel_knife_iw6");
  precachemodel("com_flashlight_on");
  precachemodel("shipping_frame_50cal");
  precachemodel("shipping_frame_crates");
  precachemodel("shipping_frame_minigun");
  precachemodel("vld_playing_card_deck");
  precachemodel("cnd_cellphone_01_on");
  precachemodel("com_folding_chair");
  precachemodel("weapon_p226");
  precachemodel("fac_ambush_desk_search_chair");
  precachemodel("trash_cup_tall2");
  precachestring(&"FACTORY_HINT_THERMAL");
  precacherumble("tank_rumble");
  precacherumble("slide_loop");
}

section_flag_init() {
  common_scripts\utility::flag_init("player_ready_for_drop_kill");
  common_scripts\utility::flag_init("introkill_weapon_switched");
  common_scripts\utility::flag_init("factory_introkill_jungle");
  common_scripts\utility::flag_init("playerkill_at_start_ledge");
  common_scripts\utility::flag_init("playerkill_jump_from_ledge");
  common_scripts\utility::flag_init("playerkill_R3_Pressed");
  common_scripts\utility::flag_init("player_starts_moving");
  common_scripts\utility::flag_init("intro_drop_kill_done");
  common_scripts\utility::flag_init("approaching_reveal");
  common_scripts\utility::flag_init("intro_start_slide");
  common_scripts\utility::flag_init("ally_start_sliding");
  common_scripts\utility::flag_init("ally_done_sliding");
  common_scripts\utility::flag_init("ally_at_first_reveal");
  common_scripts\utility::flag_init("infil_water_splash");
  common_scripts\utility::flag_init("player_at_first_reveal");
  common_scripts\utility::flag_init("factory_exterior_reveal");
  common_scripts\utility::flag_init("factory_exterior_reveal_between_trains");
  common_scripts\utility::flag_init("factory_exterior_approach_infil");
  common_scripts\utility::flag_init("intro_infil_done");
  common_scripts\utility::flag_init("kill_train");
  common_scripts\utility::flag_init("player_exited_train");
  common_scripts\utility::flag_init("player_exited_mission_warning");
  common_scripts\utility::flag_init("player_exited_mission");
  common_scripts\utility::flag_init("trig_intro_vignette");
  common_scripts\utility::flag_init("player_ready_for_train_kill");
  common_scripts\utility::flag_init("trainyard_kill_sequence_used");
  common_scripts\utility::flag_init("trainyard_enemy_alerted");
  common_scripts\utility::flag_init("trainyard_enemy_dead");
  common_scripts\utility::flag_init("intro_checkpoint_done");
  common_scripts\utility::flag_init("factory_entrance_setup");
  common_scripts\utility::flag_init("factory_entrance_start");
  common_scripts\utility::flag_init("intro_truck_driver_dead");
  common_scripts\utility::flag_init("truck_kill_timed_out");
  common_scripts\utility::flag_init("player_entered_awning");
  common_scripts\utility::flag_init("factory_entrance_reveal");
  common_scripts\utility::flag_init("all_allies_at_entrance");
  common_scripts\utility::flag_init("truck_kills_done");
  common_scripts\utility::flag_init("start_search");
  common_scripts\utility::flag_init("outer_perim_cleared");
  common_scripts\utility::flag_init("card_swiped");
  common_scripts\utility::flag_init("first_door_guard_shot");
  common_scripts\utility::flag_init("enter_factory");
  common_scripts\utility::flag_init("entered_factory_1");
  common_scripts\utility::flag_init("ingress_dialogue_kickoff");
  common_scripts\utility::flag_init("entered_conveyor");
  common_scripts\utility::flag_init("ready_to_stab_neck");
  common_scripts\utility::flag_init("throat_stab_train");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("train_stab_hint", &"SCRIPT_PLATFORM_OILRIG_HINT_STEALTH_KILL", ::hint_train_stab_should_break);
  maps\_utility::add_hint_string("drop_kill_hint", &"FACTORY_DROP_KILL_HINT", ::hint_drop_kill_should_break);
}

hint_drop_kill_should_break() {
  if(common_scripts\utility::flag("playerkill_jump_from_ledge") || !common_scripts\utility::flag("player_ready_for_drop_kill")) {
    return 1;
  }

  return 0;
}

hint_train_stab_should_break() {
  if(common_scripts\utility::flag("trainyard_kill_sequence_used") || !common_scripts\utility::flag("player_ready_for_train_kill") || common_scripts\utility::flag("trainyard_enemy_dead")) {
    return 1;
  }

  return 0;
}

intro_start() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_pain();
  }

  thread maps\_art::disable_ssao_over_time(0.1);
  level.player disableweapons();
  level.player disableweaponpickup();
  level.player takeweapon("flash_grenade");
  level.player takeweapon("fraggrenade");
  setsaveddvar("cg_footsteps", 0);
  common_scripts\utility::flag_clear("trig_intro_vignette");
  common_scripts\utility::flag_clear("kill_train");
  thread intro_truck_setup();
  maps\_utility::battlechatter_off();
}

intro() {
  maps\factory_util::squad_add_ally("ALLY_ECHO", "ally_echo", "ally_echo");
  level.squad["ALLY_ECHO"].ignoreall = 1;
  thread intro_infil();
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("ammoCounterHide", 1);
  thread intro_animated_chopper();
  thread factory_reveal_activity();
  thread maps\factory_fx::fx_intro_rain();
  thread handle_player_leaving_mission();
  common_scripts\utility::flag_wait("intro_infil_done");
}

intro_infil() {
  maps\_friendlyfire::turnoff();
  var_0 = getent("PLAYERkill_start_teleport", "targetname");
  level.squad["ALLY_ALPHA"] thread ally_knife();
  thread loop_train(2.38, 8000, 30.0);
  thread maps\_weather::rainhard(10);
  thread maps\factory_audio::audio_factory_intro_mix();
  thread maps\factory_audio::audio_player_intro();
  level.player freezecontrols(1);
  level.player.ignoreme = 1;
  thread plant_reaction_rain();

  foreach(var_2 in level.squad) {
    var_2 maps\_utility::disable_ai_color();
    var_2.ignoreall = 1;
  }

  thread intro_ally_wait_then_slide();
  level.player thread maps\factory_fx::splash_on_player("player_entered_awning");
  wait 5.5;
  level.squad["ALLY_BRAVO"] thread maps\_utility::smart_radio_dialogue("factory_kgn_jericho11and12");
  wait 2.5;
  thread maps\factory_util::god_rays_intro();
  thread maps\factory_fx::rain_on_actor(level.squad["ALLY_ALPHA"], "player_at_first_reveal", 0.1);
  var_4 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
  var_4 maps\_anim::anim_first_frame_solo(level.squad["ALLY_ALPHA"], "factory_intro_jungle_drop_ally01");
  var_5 = getent("startkill_enemy2", "targetname");
  var_5 maps\_utility::add_spawn_function(::start_enemy_enemy_logic, "introkill_enemy2", "stop_loop2", "factory_intro_jungle_drop_opfor02", "factory_intro_jungle_drop_opfor02_loop");
  level.infil_dropkill_player_enemy = var_5 maps\_utility::spawn_ai();
  var_5 = getent("startkill_enemy1", "targetname");
  var_5 maps\_utility::add_spawn_function(::start_enemy_enemy_logic, "introkill_enemy1", "stop_loop1", "factory_intro_jungle_drop_opfor01", "factory_intro_jungle_drop_opfor01_loop", "factory_intro_jungle_drop_kill_opfor01");
  level.infil_dropkill_ally_enemy = var_5 maps\_utility::spawn_ai();
  common_scripts\utility::flag_set("factory_introkill_jungle");
  thread maps\factory_anim::factory_introkill_jungle_player();
  level.player setwatersheeting(1, 3.75);
  thread water_splash_player();
  maps\_utility::player_speed_percent(0, 0.1);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player allowstand(0);
  level.player allowprone(0);
  thread lightning_flashes();
  thread introkill_enemy_vo();
  thread check_for_infil_kill();
  common_scripts\utility::exploder("intro_hero_rain");
  common_scripts\utility::flag_wait("factory_introkill_jungle");
  wait 1.05;
  thread maps\_utility::player_speed_percent(20, 10);
  level.squad["ALLY_ALPHA"] infil_creep_up(var_4);
  level.squad["ALLY_ALPHA"] intro_infil_part2(var_4);
}

infil_creep_up(var_0) {
  level endon("playerkill_jump_from_ledge");
  thread maps\factory_audio::audio_baker_intro();
  var_0 maps\_anim::anim_single_solo(self, "factory_intro_jungle_drop_ally01");

  if(!common_scripts\utility::flag("playerkill_jump_from_ledge")) {
    var_0 thread maps\_anim::anim_loop_solo(self, "factory_intro_jungle_drop_ally01_loop01", "stop_loop01");
  }
}

lightning_flashes() {
  var_0 = (-20, 60, 0);
  setsaveddvar("sm_sunSampleSizeNear", 0.025);
  thread maps\factory_fx::lightning_flash(var_0, 3, 0);
  wait 2.7;
  var_1 = getent("lightning_flash_01", "script_noteworthy");
  maps\factory_fx::lightning_flash(var_0, randomintrange(2, 4), 1);
  wait 1.0;
  maps\factory_fx::lightning_flash(var_0, randomintrange(4, 6), 0);
  wait 0.6;
  thread maps\factory_fx::lightning_flash(var_0, 3);
  wait 1.8;
  var_1 = getent("lightning_flash_02", "script_noteworthy");
  thread maps\factory_fx::lightning_flash_primary(var_1, randomintrange(3, 5));
  setsaveddvar("sm_sunSampleSizeNear", 0.25);

  while(!common_scripts\utility::flag("lgt_playerkill_jumpdown")) {
    level.player thread maps\factory_audio::sfx_factory_intro_lightning_loop();
    maps\factory_fx::lightning_flash(var_0, randomintrange(2, 4));
    wait(randomfloatrange(0.3, 3.6));
  }

  wait 0.2;

  for(var_2 = 0; var_2 < randomintrange(2, 4); var_2++) {
    level.player thread maps\factory_audio::sfx_factory_intro_lightning_loop();
    thread maps\factory_fx::lightning_flash(var_0, randomintrange(3, 5), 4);
    wait(randomfloatrange(0.4, 4.3));
  }

  wait 1.0;
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  wait 1.0;
  maps\_utility::delaythread(0.7, maps\_weather::lightningthink, maps\factory_fx::lightning_normal, maps\factory_fx::lightning_flash);
}

player_movement_reset() {
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  setsaveddvar("cg_footsteps", 1);

  if(common_scripts\utility::flag("playerkill_R3_Pressed")) {
    common_scripts\utility::flag_wait("intro_drop_kill_done");
  }

  maps\_utility::player_speed_percent(70);
  level.player allowjump(1);
  level.player allowstand(1);
  level.player allowprone(1);
  level.player allowsprint(1);
}

intro_infil_part2(var_0) {
  thread intro_infil_part2_dialog();
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  maps\_friendlyfire::turnbackon();
  var_0 notify("stop_loop01");

  if(common_scripts\utility::flag("playerkill_R3_Pressed")) {
    level.player thread maps\factory_audio::audio_player_intro_jump_kill();
    wait 0.1;
    common_scripts\utility::flag_set("lgt_playerkill_jumpdown");
  }

  thread player_movement_reset();
  common_scripts\utility::flag_wait("intro_start_slide");
  thread maps\_art::enable_ssao_over_time(2.0);
  level.player thread slide_orient_player();
  common_scripts\utility::flag_set("lgt_intro_reveal");
  common_scripts\utility::flag_set("music_jungle_slide");
  common_scripts\utility::flag_set("kill_train");
  var_1 = getnode("ALLY_BRAVO_wallhopstart_teleport", "targetname");
  level.squad["ALLY_BRAVO"] maps\_utility::teleport_ai(var_1);
  var_1 = getnode("ALLY_CHARLIE_wallhopstart_teleport", "targetname");
  level.squad["ALLY_CHARLIE"] maps\_utility::teleport_ai(var_1);
  var_1 = getnode("ALLY_ECHO_wallhopstart_teleport", "targetname");
  level.squad["ALLY_ECHO"] maps\_utility::teleport_ai(var_1);
  thread intro_allied_entrance();
  common_scripts\utility::flag_wait("intro_end_slide");

  if(!common_scripts\utility::flag("ally_start_sliding")) {
    thread ally_slide_now();
  }

  level.player setmovespeedscale(1.0);
  common_scripts\utility::flag_wait("player_near_train_kill");
  common_scripts\utility::flag_set("intro_infil_done");
}

slide_orient_player() {
  self enableslowaim();
  self playrumblelooponentity("slide_loop");
  self.slidemodel.slidevelocity = self.slidemodel.slidevelocity * 0.25;

  while(!common_scripts\utility::flag("intro_end_slide")) {
    var_0 = self getplayerangles();

    if(var_0[1] > -60) {
      self setplayerangles((var_0[0], var_0[1] - 5, var_0[2]));
    } else if(var_0[1] < -120) {
      self setplayerangles((var_0[0], var_0[1] + 5, var_0[2]));
    }

    var_1 = length(self.slidemodel.slidevelocity);

    if(var_1 > 100) {
      self.slidemodel.slidevelocity = self.slidemodel.slidevelocity * 0.9;
    }

    wait 0.05;
  }

  self stoprumble("slide_loop");
  self disableslowaim();
}

intro_infil_part2_dialog() {
  level endon("intro_infil_done");
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  maps\_utility::radio_dialogue_stop();
  wait 7.9;
  thread maps\_utility::smart_dialogue("factory_mrk_theyredowncreeper11");
  thread maps\factory_audio::audio_distant_train_horn();
  wait 5.0;
  maps\_utility::smart_dialogue("factory_mrk_housemainwehave");
  maps\_utility::smart_radio_dialogue("factory_hqr_rogerjerichomoveto");

  if(!common_scripts\utility::flag("approaching_reveal")) {
    maps\_utility::smart_dialogue("factory_mrk_copythatapproachingentry");
  }

  common_scripts\utility::flag_wait("approaching_reveal");

  if(!common_scripts\utility::flag("player_at_first_reveal")) {
    maps\_utility::smart_dialogue("factory_mrk_jerichoatentrya");
  }

  maps\_utility::smart_radio_dialogue("factory_kgn_creeperatentryb");
  common_scripts\utility::flag_wait("player_at_first_reveal");

  if(!common_scripts\utility::flag("intro_end_slide")) {
    maps\_utility::smart_dialogue("factory_mrk_copymovingregroupfifty");
  }

  common_scripts\utility::flag_wait("intro_end_slide");
  maps\_utility::smart_dialogue("factory_mrk_weseeyoucreeper");
}

ally_introkill_knife_anim() {
  level endon("playerkill_jump_from_ledge");
  var_0 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
  var_0 maps\_anim::anim_single_solo(self, "factory_intro_jungle_drop_ally01_ptr02");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_intro_jungle_drop_ally01_loop02", "stop_loop02");
}

ally_knife() {
  self attach("Viewmodel_knife_iw6", "tag_inhand", 1);
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  level waittill("del_knife");
  self detach("Viewmodel_knife_iw6", "tag_inhand", 1);
}

introkill_enemy_vo() {
  level endon("playerkill_jump_from_ledge");
  wait 4;
  level.infil_dropkill_player_enemy playSound("factory_vz4_wearealmostdone");
  wait 3;
  level.infil_dropkill_ally_enemy playSound("factory_vz5_howmuchlongerdo");
  wait 3;
  level.infil_dropkill_player_enemy playSound("factory_vz4_wehaveabout2");
  wait 3;
  level.infil_dropkill_ally_enemy playSound("factory_vz5_thatsnottoobad");
  wait 3;
  level.infil_dropkill_player_enemy playSound("factory_vz4_alrightletscheckthe");
  wait 3;
  level.infil_dropkill_ally_enemy playSound("factory_vz5_dontgetaheadof");
  wait 3;
  level.infil_dropkill_player_enemy playSound("factory_vz4_idontneeda");
  wait 3;
  level.infil_dropkill_ally_enemy playSound("factory_vz5_whatever");
  wait 3;
}

check_for_infil_kill() {
  level.player endon("death");
  level endon("intro_infil_done");
  level.player notifyonplayercommand("drop_kill", "+attack");
  level.player notifyonplayercommand("drop_kill", "+melee");
  level.player notifyonplayercommand("drop_kill", "+melee_breath");
  level.player notifyonplayercommand("drop_kill", "+melee_zoom");
  thread check_for_player_fall();
  thread check_player_ready_for_drop_kill();
  wait 2;

  for(;;) {
    level.player waittill("drop_kill");

    if(common_scripts\utility::flag("player_ready_for_drop_kill")) {
      common_scripts\utility::flag_set("playerkill_R3_Pressed");
      common_scripts\utility::flag_set("playerkill_jump_from_ledge");
      common_scripts\utility::flag_set("playerkill_at_start_ledge");
      maps\_utility::stop_exploder("intro_hero_rain");
      thread introkill_player_splash();
      level.player.in_stab_animation = 1;
      var_0 = player_start_stabbing();
      var_1 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
      var_2 = [];
      var_2[0] = var_0;
      var_2[1] = level.infil_dropkill_player_enemy;
      var_1 thread maps\_anim::anim_first_frame(var_2, "factory_intro_jungle_drop_kill_player");
      level.infil_dropkill_ally_enemy stopsounds();
      level.infil_dropkill_ally_enemy thread maps\_utility::smart_dialogue("factory_sp1_enlamadre");
      var_3 = 0.15;
      level.player playerlinktoblend(var_0, "tag_player", var_3, 0.25, 0.25);
      wait(var_3);
      var_4 = 15;
      level.player playerlinktodelta(var_0, "tag_player", 1, var_4, var_4, var_4, var_4, 1);
      var_0 show();
      var_0 attach("weapon_parabolic_knife", "tag_weapon_right", 1);
      level.infil_dropkill_player_enemy stopsounds();
      level.infil_dropkill_player_enemy maps\_utility::delaythread(1, ::flashlight_drop_detail);
      var_1 notify("stop_loop2");
      var_1 maps\_anim::anim_single(var_2, "factory_intro_jungle_drop_kill_player");
      level.infil_dropkill_player_enemy maps\_vignette_util::vignette_actor_kill();
      level.infil_dropkill_player_enemy dropweapon(level.infil_dropkill_player_enemy.weapon, "right", 0);
      level.infil_dropkill_player_enemy maps\_utility::gun_remove();
      var_0 detach("weapon_parabolic_knife", "tag_weapon_right", 1);
      level.player unlink();
      var_0 delete();
      level.player.in_stab_animation = undefined;
      wait 0.8;
      common_scripts\utility::flag_clear("introkill_weapon_switched");
      player_done_stabbing();
      common_scripts\utility::flag_set("intro_drop_kill_done");
      return;
    }

    wait 0.02;
  }
}

check_player_ready_for_drop_kill() {
  for(;;) {
    if(maps\_utility::player_looking_at(level.infil_dropkill_player_enemy.origin, 0.9) && common_scripts\utility::flag("playerkill_at_start_ledge") && !common_scripts\utility::flag("playerkill_jump_from_ledge")) {
      common_scripts\utility::flag_set("player_ready_for_drop_kill");
      maps\_utility::display_hint("drop_kill_hint");
      level.player allowmelee(0);
    } else {
      common_scripts\utility::flag_clear("player_ready_for_drop_kill");
      level.player allowmelee(1);

      if(common_scripts\utility::flag("playerkill_jump_from_ledge")) {
        break;
      }
    }

    wait 0.01;
  }
}

check_for_player_fall() {
  level.player endon("death");
  level endon("intro_infil_done");
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  wait 0.5;

  if(!common_scripts\utility::flag("playerkill_R3_Pressed")) {
    common_scripts\utility::flag_clear("introkill_weapon_switched");
    level.player enableweaponswitch();

    while(isalive(level.infil_dropkill_player_enemy)) {
      wait 0.1;
    }

    wait 0.1;
    thread maps\factory_fx::fx_intro_kill_player_jump_stab(level.infil_dropkill_player_enemy);
  } else {
    while(isDefined(level.player.in_stab_animation)) {
      wait 0.1;
    }
  }

  setsaveddvar("compass", 1);
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("ammoCounterHide", 0);
  common_scripts\utility::flag_set("lgt_playerkill_jumpdown");
  level.infil_dropkill_player_enemy waittill("death");
  common_scripts\utility::flag_set("intro_drop_kill_done");

  if(level.player getcurrentweapon() == "factory_knife") {
    level.player switchtoweapon(level.default_weapon);
  }

  level.player takeweapon("factory_knife");
  level.player enableweaponpickup();
  level.squad["ALLY_ALPHA"].ignoreall = 1;
  wait 3;
  maps\_utility::autosave_by_name("intro_kill_done");
}

player_start_stabbing() {
  level.player hideviewmodel();
  level.player.active_anim = 1;
  level.old_weapon = level.player getcurrentweapon();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player freezecontrols(1);
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_0 hide();
  return var_0;
}

player_done_stabbing() {
  level.player.active_anim = 0;
  level.player takeweapon("factory_knife");
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player switchtoweapon(level.old_weapon);
  level.player enableoffhandweapons();
  level.player showviewmodel();
  level.player allowmelee(1);
  level.player freezecontrols(0);
  level.player allowcrouch(1);
  level.player maps\_player_stats::register_kill(undefined, "melee");
}

introkill_player_splash() {
  var_0 = (45, 45, 0);
  thread maps\factory_fx::lightning_flash(var_0, 4);
  wait 1.05;
  wait 0.33;
  common_scripts\utility::exploder("intro_kill_splash_01");
  level.player playrumbleonentity("artillery_rumble");
  wait 0.97;
  var_0 = (45, 45, 0);
  thread maps\factory_fx::lightning_flash(var_0, 4);
}

introkill_ally_splash() {
  wait 3.05;
  wait 0.23;
  common_scripts\utility::exploder("intro_kill_splash_02");
  wait 0.95;
  common_scripts\utility::exploder("intro_kill_splash_02a");
  wait 0.52;
  var_0 = (45, 45, 0);
  thread maps\factory_fx::lightning_flash(var_0, 4);
}

start_enemy_enemy_logic(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  thread maps\factory_fx::rain_on_actor(self, "player_at_first_reveal", 0.1);
  self.animname = var_0;
  self.script_grenades = 0;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.allowdeath = 1;
  self.health = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;

  if(!isDefined(var_4)) {
    maps\factory_powerstealth::attach_flashlight(1, undefined, 1);
  }

  if(isDefined(var_4)) {
    thread introkill_ally_enemy_killcheck();
  } else {
    thread introkill_player_enemy_killcheck();
  }

  var_5 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
  maps\_utility::delaythread(0.5, maps\_anim::anim_set_rate_single, self, var_2, 0.6);

  if(!isDefined(var_4)) {
    maps\_utility::delaythread(6.1, maps\_anim::anim_set_rate_single, self, var_2, 1.2);
  } else {
    maps\_utility::delaythread(8.1, maps\_anim::anim_set_rate_single, self, var_2, 1.6);
  }

  maps\_utility::delaythread(10, maps\_anim::anim_set_rate_single, self, var_2, 1);
  thread start_enemy_anims(var_5, var_2, var_3, var_1);
  self waittill("stop_animating");
  var_5 notify(var_1);
  self stopanimscripted();
}

start_enemy_anims(var_0, var_1, var_2, var_3) {
  level endon("playerkill_jump_from_ledge");
  self endon("stop_animating");
  var_0 maps\_anim::anim_single_solo(self, var_1);
  var_0 maps\_anim::anim_loop_solo(self, var_2, var_3);
}

introkill_ally_enemy_killcheck() {
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  level.infil_dropkill_ally_enemy.health = 1000;
  thread introkill_ally_splash();
  var_0 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
  var_0 notify("stop_loop02");
  level.squad["ALLY_ALPHA"] stopanimscripted();
  var_0 notify("stop_loop");

  if(common_scripts\utility::flag("playerkill_R3_Pressed")) {
    level.squad["ALLY_ALPHA"] thread maps\factory_audio::audio_ally_intro_jump_kill();
    var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "factory_intro_jungle_drop_kill_ally01");
    var_0 maps\_anim::anim_single_solo(level.infil_dropkill_ally_enemy, "factory_intro_jungle_drop_kill_opfor01");
  } else {
    level.squad["ALLY_ALPHA"] thread maps\factory_audio::audio_ally_intro_jump_kill_short();
    var_0 thread maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "factory_intro_jungle_drop_kill_short_ally01");
    var_0 maps\_anim::anim_single_solo(level.infil_dropkill_ally_enemy, "factory_intro_jungle_drop_kill_short_opfor01");
  }

  level.infil_dropkill_ally_enemy maps\_vignette_util::vignette_actor_kill();
  level.infil_dropkill_ally_enemy dropweapon(level.infil_dropkill_ally_enemy.weapon, "right", 0);
  level.infil_dropkill_ally_enemy maps\_utility::gun_remove();
}

introkill_player_enemy_killcheck() {
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");

  if(!common_scripts\utility::flag("playerkill_R3_Pressed")) {
    var_0 = common_scripts\utility::getstruct("drop_kill_node", "script_noteworthy");
    wait 0.5;
    var_0 notify("stop_loop2");
    waittillframeend;
    level.infil_dropkill_player_enemy thread flashlight_drop_detail();
    level.infil_dropkill_player_enemy stopanimscripted();
    level.infil_dropkill_player_enemy.ignoreall = 0;
    level.infil_dropkill_player_enemy.ignoreme = 0;
    level.infil_dropkill_player_enemy.attackeraccuracy = 10000;
    level.player.ignoreme = 0;
    level.infil_dropkill_player_enemy.favoriteenemy = level.player;
    level.infil_dropkill_player_enemy.see_player = 1;
    level.infil_dropkill_player_enemy getenemyinfo(level.player);
    level.squad["ALLY_ALPHA"].ignoreall = 0;
    level.squad["ALLY_ALPHA"].favoriteenemy = level.infil_dropkill_player_enemy;
  }
}

water_splash_player() {
  level endon("intro_truck_driver_dead");

  for(;;) {
    if(common_scripts\utility::flag("infil_water_splash")) {
      level.player setwatersheeting(1, 1.75);
      level.player maps\_utility::dirteffect(level.player.origin);
      wait(randomfloatrange(0.2, 0.5));
    }

    wait 0.5;
  }
}

plant_reaction_rain() {
  level endon("music_jungle_slide");

  for(;;) {
    thread maps\factory_fx::fx_set_wind(randomfloatrange(0.5, 1.5), randomfloatrange(0.5, 1.5), 1.8, randomfloatrange(1.2, 1.9));
    wait(randomfloatrange(0.8, 1.5));
    thread maps\factory_fx::fx_set_wind(level.defaultreactivewind["strength"], level.defaultreactivewind["amplitudeScale"], level.defaultreactivewind["frequencyScale"], 3.0);
    wait(randomfloatrange(8.5, 15.5));
  }
}

intro_ally_wait_then_slide() {
  level endon("ally_start_sliding");
  common_scripts\utility::flag_wait("playerkill_jump_from_ledge");
  level.squad["ALLY_ALPHA"] setlookatentity();
  common_scripts\utility::flag_set("lgt_playerkill_done");

  while(isalive(level.infil_dropkill_player_enemy)) {
    wait 0.1;
  }

  level.squad["ALLY_ALPHA"] maps\_utility::set_generic_run_anim("crouch_fastwalk_F");
  level.squad["ALLY_ALPHA"].goalradius = 8;
  var_0 = getnode("ALLY_ALPHA_Start_Alt_01", "targetname");
  level.squad["ALLY_ALPHA"] setgoalnode(var_0);
  common_scripts\utility::flag_wait("player_starts_moving");
  level.squad["ALLY_ALPHA"] maps\_utility::enable_cqbwalk();
  var_0 = getnode("factory_slide_node", "targetname");
  level.squad["ALLY_ALPHA"] setgoalnode(var_0);
  common_scripts\utility::flag_set("ally_at_first_reveal");
  level.squad["ALLY_ALPHA"] waittill("goal");
  common_scripts\utility::flag_wait("player_at_first_reveal");
  thread ally_slide_now();
}

ally_slide_now() {
  thread maps\factory_fx::rain_on_actor(level.squad["ALLY_ALPHA"], "player_entered_awning", 0.1);
  thread maps\factory_fx::rain_on_actor(level.squad["ALLY_BRAVO"], "player_entered_awning", 0.1);
  thread maps\factory_fx::rain_on_actor(level.squad["ALLY_CHARLIE"], "player_entered_awning", 0.1);
  var_0 = common_scripts\utility::getstruct("factory_baker_slidestart", "script_noteworthy");
  level.squad["ALLY_ALPHA"] setgoalpos(level.squad["ALLY_ALPHA"].origin);
  level.squad["ALLY_ALPHA"] maps\_utility::clear_run_anim();
  level.squad["ALLY_ALPHA"] maps\_utility::disable_sprint();
  var_0 notify("stop_loop");
  waittillframeend;
  thread maps\factory_audio::sfx_bak_mudslide();
  common_scripts\utility::flag_set("ally_start_sliding");
  var_0 maps\_anim::anim_single_solo(level.squad["ALLY_ALPHA"], "factory_intro_jungle_slide_baker_exit");
  level.squad["ALLY_ALPHA"] maps\_utility::enable_ai_color_dontmove();
  self.disableplayeradsloscheck = 1;
  common_scripts\utility::flag_wait("intro_end_slide");
  maps\_utility::enable_ai_color();
  maps\factory_util::safe_trigger_by_targetname("intro_infil_train_kill_staging");
  common_scripts\utility::flag_set("ally_done_sliding");
  thread maps\factory_util::god_rays_trainyard();
}

intro_allied_entrance() {
  level.squad["ALLY_BRAVO"] thread intro_allied_entrance_bravo();
  level.squad["ALLY_CHARLIE"] thread intro_allied_entrance_charlie();
  level.squad["ALLY_ECHO"] thread intro_allied_entrance_echo();
}

intro_allied_entrance_bravo() {
  level endon("player_entered_awning");
  var_0 = common_scripts\utility::getstruct("factory_infil_wallhop_03", "script_noteworthy");
  var_0 maps\_anim::anim_first_frame_solo(self, "factory_intro_jungle_wallhop");
  common_scripts\utility::flag_wait("player_near_train_kill");
  var_0 maps\_anim::anim_single_solo(self, "factory_intro_jungle_wallhop");
  self setgoalnode(getnode("ALLY_BRAVO_wallhop_teleport", "targetname"));
  self.goalradius = 8;
  self waittill("goal");
  maps\_utility::enable_ai_color();
}

intro_allied_entrance_charlie() {
  level endon("player_entered_awning");
  var_0 = common_scripts\utility::getstruct("factory_infil_wallhop_01", "script_noteworthy");
  var_0 maps\_anim::anim_first_frame_solo(self, "factory_intro_jungle_wallhop");
  var_0 maps\_anim::anim_single_solo(self, "factory_intro_jungle_wallhop");
  maps\_utility::enable_ai_color();
  maps\factory_util::safe_trigger_by_targetname("sca_train_kill_charlie_position");
}

intro_allied_entrance_echo() {
  self endon("death");
  level endon("player_entered_awning");
  var_0 = common_scripts\utility::getstruct("factory_infil_wallhop_02", "script_noteworthy");
  var_0 maps\_anim::anim_first_frame_solo(self, "factory_intro_jungle_wallhop");
  common_scripts\utility::flag_wait("player_near_train_kill");
  var_0 maps\_anim::anim_single_solo(self, "factory_intro_jungle_wallhop");
  self setgoalnode(getnode("ALLY_ECHO_wallhop_teleport", "targetname"));
  self.goalradius = 8;
  self waittill("goal");
  maps\_utility::enable_ai_color();
}

loop_train(var_0, var_1, var_2) {
  var_3 = "player_near_train_kill";
  thread maps\factory_audio::audio_train_constant_loop();
  thread maps\factory_audio::audio_start_train_click_clacks();
  var_4 = [];
  var_4[0] = getent("train_reveal_01_org", "targetname");
  var_4[1] = getent("train_reveal_02_org", "targetname");
  var_4[2] = getent("train_reveal_03_org", "targetname");
  var_4[3] = getent("train_reveal_04_org", "targetname");
  var_4[4] = getent("train_reveal_05_org", "targetname");
  var_4[5] = getent("train_reveal_06_org", "targetname");
  var_4[6] = getent("train_reveal_07_org", "targetname");
  var_4[7] = getent("train_reveal_08_org", "targetname");
  var_4[8] = getent("train_reveal_09_org", "targetname");
  var_4[9] = getent("train_reveal_10_org", "targetname");
  var_4[10] = getent("train_reveal_11_org", "targetname");
  var_4[11] = getent("train_reveal_12_org", "targetname");
  var_4[12] = getent("train_reveal_13_org", "targetname");
  thread train_car_rumble_generator(var_4);
  var_5 = var_4[0];

  foreach(var_7 in var_4) {
    thread set_up_train_car(var_7, var_5, var_1, var_2, var_3);
  }

  foreach(var_7 in var_4) {
    var_7 notify("go");
    wait(var_0);
  }

  common_scripts\utility::flag_wait("intro_checkpoint_done");
  var_11 = getEntArray("fac_intro_trains", "script_noteworthy");

  foreach(var_13 in var_11) {
    if(isDefined(var_13)) {
      var_13 delete();
    }
  }
}

set_up_train_car(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0.target, "targetname");

  foreach(var_7 in var_5) {
    if(var_7.classname == "trigger_hurt") {
      var_7 enablelinkto();
    }

    var_7 linkto(var_0);
  }

  var_0 moveto(var_1.origin, 0.1, 0, 0);
  var_0 waittill("go");
  var_0 thread loop_train_car(var_2, var_3, 0.1, var_4);
}

train_car_rumble_generator(var_0) {
  level endon("factory_exterior_reveal_between_trains");
  var_1 = 350;

  for(;;) {
    var_2 = common_scripts\utility::getclosest(level.player.origin, var_0, var_1);

    if(isDefined(var_2)) {
      var_2 playrumblelooponentity("tank_rumble");
    }

    wait 1;
  }
}

loop_train_car(var_0, var_1, var_2, var_3) {
  self endon("death");
  maps\_utility::ent_flag_init("deleteable");
  maps\_utility::ent_flag_set("deleteable");
  thread check_train_car_for_stopping(var_3);
  self movez(11.0, 0.1, 0, 0);
  self waittill("movedone");

  for(;;) {
    self movex(0.0 - var_0, var_1);
    self waittill("movedone");

    if(common_scripts\utility::flag(var_3)) {
      break;
    }

    self movez(-250, 0.1);
    self waittill("movedone");

    if(common_scripts\utility::flag(var_3)) {
      break;
    }

    maps\_utility::ent_flag_clear("deleteable");
    self movex(var_0, var_2);
    self waittill("movedone");

    if(common_scripts\utility::flag(var_3)) {
      break;
    }

    maps\_utility::ent_flag_set("deleteable");
    self movez(250, 0.1);
    self waittill("movedone");

    if(common_scripts\utility::flag(var_3)) {
      break;
    }
  }
}

check_train_car_for_stopping(var_0) {
  self endon("death");
  common_scripts\utility::flag_wait(var_0);
  maps\_utility::ent_flag_wait("deleteable");

  if(self.origin[0] < 4100) {
    self waittill("movedone");
    self movex(-8000, 30);
    self waittill("movedone");
  }

  if(self.origin[0] > 4100) {
    self movex(8000, 0.1);
    self waittill("movedone");
  }

  self notify("stop_wiggle");
}

wiggle_train_car() {
  level endon("entered_factory_1");
  self endon("death");
  self endon("stop_wiggle");

  for(;;) {
    self rotateto((0, 0, randomfloatrange(0.8, 2.5)), randomfloatrange(0.3, 1.2));
    wait(randomfloatrange(0.3, 1.5));
    self rotateto((0, 0, randomfloatrange(0.8, 2.5) * -1), randomfloatrange(0.3, 1.2));
    wait(randomfloatrange(0.3, 1.5));
  }
}

#using_animtree("generic_human");

factory_reveal_activity() {
  level.drone_anims["axis"]["stand"]["run"] = % patrol_bored_patrolwalk;
  var_0 = getEntArray("intro_reveal_pmcs", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::intro_reveal_pmc_think);
  }

  var_4 = getEntArray("reveal_vehicles", "targetname");

  foreach(var_2 in var_4) {
    var_2 maps\_utility::add_spawn_function(::reveal_vehicles_think_veh);
  }

  var_7 = getEntArray("intro_reveal_vehicle_pmcs", "targetname");

  foreach(var_2 in var_7) {
    var_2 maps\_utility::add_spawn_function(::reveal_vehicles_think_pmc);
  }
}

reveal_vehicles_think_veh() {
  self.ignoreall = 1;
  thread detect_player_shot();
  playFXOnTag(level._effect["iveco_headlight_l_night"], self, "TAG_HEADLIGHT_LEFT");
  playFXOnTag(level._effect["iveco_headlight_r_night"], self, "TAG_HEADLIGHT_RIGHT");
  playFXOnTag(level._effect["car_taillight_btr80_eye"], self, "TAG_BRAKELIGHT_LEFT");
  playFXOnTag(level._effect["car_taillight_btr80_eye"], self, "TAG_BRAKELIGHT_RIGHT");
}

reveal_vehicles_think_pmc() {
  self.ignoreall = 1;
  thread detect_player_shot();
}

intro_reveal_pmc_think() {
  self endon("death");
  self.patrol_walk = ["walk_gun_unwary", "patrol_bored_patrolwalk", "patrol_bored_patrolwalk_twitch"];
  self.patrol_idle = ["patrol_idle_stretch", "patrol_idle_smoke", "patrol_idle_checkphone"];
  maps\_utility::set_generic_run_anim("walk_gun_unwary");
  thread detect_player_shot();
  common_scripts\utility::flag_wait("player_exited_train");
  self delete();
}

detect_player_shot() {
  level endon("entered_factory_1");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", &"FACTORY_FAIL_ALERTED_ENEMY");
      maps\_utility::missionfailedwrapper();
    }
  }
}

intro_animated_chopper() {
  var_0 = getent("trig_intro_ally_moveto_reveal", "targetname");
  var_0 waittill("trigger");
  level thread maps\factory_anim::intro_chopper();
  thread maps\factory_fx::fx_set_wind(4.0, 3.5, 1.8, 1);
  common_scripts\utility::exploder("intro_helicopter_debris");
  playFXOnTag(level._effect["factory_intro_helicopter_raindrops"], level.screenrain, "tag_origin");
  wait 1.2;
  level.player playrumbleonentity("artillery_rumble");
  wait 1.0;
  thread maps\factory_fx::fx_set_wind(2.0, 2.0, 1.0, 1);
  wait 2.2;
  thread maps\factory_fx::fx_set_wind(level.defaultreactivewind["strength"], level.defaultreactivewind["amplitudeScale"], level.defaultreactivewind["frequencyScale"], 3.0);
}

intro_animated_chopper_spotlight() {
  self endon("death");
  vehicle_scripts\_attack_heli::heli_default_target_setup();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_heli_spotlight_target");
  self setturrettargetent(var_0);
  self.targetdefault = var_0;
}

intro_train_start() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_pain();
  }

  level.player switchtoweapon(level.default_weapon);
  level.player takeweapon("flash_grenade");
  level.player takeweapon("fraggrenade");
  maps\_utility::player_speed_percent(70);
  thread intro_truck_setup();
  common_scripts\utility::flag_clear("trig_intro_vignette");
  common_scripts\utility::flag_clear("kill_train");
  thread maps\factory_audio::audio_trainpass_chkpt();
  thread maps\factory_util::god_rays_trainyard();
  var_3 = getnode("ALLY_ALPHA_fence_infil_teleport", "targetname");
  level.squad["ALLY_ALPHA"] maps\_utility::teleport_ai(var_3);
  level.squad["ALLY_ALPHA"] maps\_utility::enable_ai_color();
  maps\factory_util::squad_add_ally("ALLY_ECHO", "ally_echo", "ally_echo");
  level.squad["ALLY_ECHO"].ignoreall = 1;
  thread intro_allied_entrance();
  level.player thread maps\factory_fx::splash_on_player("player_entered_awning");
  thread handle_player_leaving_mission();
  maps\_utility::battlechatter_off();
  thread maps\_weather::rainhard(1);
  thread maps\factory_fx::fx_intro_rain();
}

intro_train() {
  foreach(var_1 in level.squad) {
    var_1.ignoreall = 1;
  }

  level.cosine["70"] = cos(70);
  level.goodfriendlydistancefromplayersquared = 62500;
  thread intro_train_pass();
  thread maps\factory_audio::sfx_train_sound();
  common_scripts\utility::flag_wait_any("intro_checkpoint_done", "player_entered_awning");
}

intro_train_pass() {
  thread maps\factory_fx::lgt_intro_train_light();
  wait 0.3;
  maps\_utility::radio_dialogue_stop();

  if(!common_scripts\utility::flag("trainyard_enemy_dead")) {
    level.squad["ALLY_ALPHA"] thread maps\_utility::smart_radio_dialogue("factory_bkr_twoapproaching");
  }

  wait 0.7;
  var_0 = getent("infil_kill", "targetname");
  var_0 maps\_utility::add_spawn_function(::trainyard_enemy_logic);
  level.train_kill = var_0 maps\_utility::spawn_ai();
  thread factory_entrance_setup();
  thread intro_kill_vignette();

  if(!common_scripts\utility::flag("trainyard_enemy_dead")) {
    level.squad["ALLY_ALPHA"] thread maps\_utility::smart_radio_dialogue("factory_bkr_gotthem");
  }

  thread train_kill_ally_second_pos(level.train_kill);
  thread intro_scene();
  common_scripts\utility::flag_wait("trainyard_enemy_dead");

  if(common_scripts\utility::flag("trainyard_kill_sequence_used")) {
    wait 1.0;
  }

  maps\_utility::radio_dialogue_stop();
  wait 0.5;
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_letsmove");

  foreach(var_2 in level.squad) {
    var_2 maps\_utility::disable_cqbwalk();
  }

  level.player.ignoreme = 0;
  wait 1.0;
  thread delta_splitup();
  level.squad["ALLY_ALPHA"] maps\_utility::smart_radio_dialogue("factory_mrk_oldboyandpickpeeloff");
  level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_radio_dialogue("factory_diz_wereonit");
  wait 2.0;
  maps\_utility::radio_dialogue_stop();
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_everyoneelseweremoving");
  common_scripts\utility::flag_wait("factory_exterior_reveal_between_trains");
  common_scripts\utility::flag_wait("factory_exterior_approach_infil");
  wait 3.1;

  if(!common_scripts\utility::flag("player_entered_awning")) {
    level.squad["ALLY_BRAVO"] thread maps\_utility::smart_dialogue("factory_bkr_throughhere");
  }

  thread factory_entrance_dialogue_management();
}

train_kill_ally_second_pos(var_0) {
  var_0 endon("death");
  level endon("trainyard_kill_sequence_used");
  level endon("trainyard_enemy_alerted");
  wait 4;
  maps\factory_util::safe_trigger_by_targetname("sca_train_kill_second_pos");
  wait 4;
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_radio_dialogue("factory_bkr_rookonyou");
  wait 4;
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_takehim");
}

trainyard_enemy_logic() {
  level endon("trainyard_enemy_alerted");
  self endon("death");
  thread maps\factory_fx::rain_on_actor(self, "trainyard_enemy_alerted", 0.1);
  self.animname = "trainyard_enemy";
  self.script_grenades = 0;
  self.allowdeath = 1;
  self.health = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  maps\factory_powerstealth::attach_flashlight(1, undefined, 1);
  var_0 = common_scripts\utility::getstruct("opfor_trainyard_walk", "script_noteworthy");
  thread trainyard_enemy_breakout_early();
  thread trainyard_enemy_logic_wait_too_long();
  trainyard_enemy_logic_start(var_0);
  thread trainyard_enemy_logic_dialogue();
  thread trainyard_enemy_logic_wait(var_0);
  var_0 maps\_anim::anim_loop_solo(self, "factory_opfor_trainyard_patrol_loop", "stop_loop");
}

trainyard_enemy_breakout_early() {
  level endon("trainyard_kill_sequence_used");
  level endon("trainyard_enemy_alerted");
  self endon("death");
  thread wait_for_waking_event();

  for(;;) {
    if(self cansee(level.player)) {
      break;
    }

    wait 0.1;
  }

  trainyard_enemy_wake_up();
}

trainyard_enemy_wake_up() {
  thread maps\_utility::smart_dialogue("factory_sp1_enlamadre");
  level.player allowmelee(1);
  var_0 = common_scripts\utility::getstruct("opfor_trainyard_walk", "script_noteworthy");
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.favoriteenemy = level.player;
  level.player.ignoreme = 0;
  self getenemyinfo(level.player);
  self.aggressivemode = 1;
  self.attackeraccuracy = 10000;
  var_0 notify("stop_loop");
  self stopanimscripted();
  thread flashlight_drop_detail();
  common_scripts\utility::flag_set("trainyard_enemy_alerted");
}

wait_for_waking_event() {
  self endon("death");
  self endon("flashbang");
  self endon("guy_waking_up");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("explode");
  self addaieventlistener("projectile_impact");

  for(;;) {
    self waittill("ai_event", var_0);

    if(var_0 == "gunshot" || var_0 == "bulletwhizby" || var_0 == "explode" || common_scripts\utility::flag_set("player_past_train_enemy")) {
      trainyard_enemy_wake_up();
      return;
    }
  }
}

trainyard_enemy_logic_start(var_0) {
  self endon("death");
  level endon("trainyard_enemy_alerted");
  maps\_utility::delaythread(0.1, maps\_anim::anim_set_rate_single, self, "factory_opfor_trainyard_patrol_enter", 1.5);
  maps\_utility::delaythread(1.0, maps\_anim::anim_set_rate_single, self, "factory_opfor_trainyard_patrol_enter", 1.1);
  maps\_utility::delaythread(4.9, maps\_anim::anim_set_rate_single, self, "factory_opfor_trainyard_patrol_enter", 1.5);
  var_0 maps\_anim::anim_single_solo(self, "factory_opfor_trainyard_patrol_enter");
  level notify("trainyard_enemy_in_position");
}

trainyard_enemy_logic_dialogue() {
  self endon("death");
  level endon("trainyard_kill_sequence_used");
  level endon("trainyard_enemy_alerted");
  wait 4;

  if(isalive(self)) {
    thread maps\_utility::smart_dialogue("factory_vs2_rogerpatrol");
  }
}

trainyard_enemy_logic_wait_too_long() {
  self endon("death");
  common_scripts\utility::flag_wait_or_timeout("trainyard_enemy_alerted", 18);

  if(common_scripts\utility::flag("trainyard_enemy_alerted")) {
    level.squad["ALLY_ALPHA"].ignoreall = 0;
    level.squad["ALLY_ALPHA"].favoriteenemy = self;
  } else {
    level.squad["ALLY_ALPHA"] maps\_utility::enable_cqbwalk();
    level.squad["ALLY_ALPHA"] setgoalnode(getnode("ALLY_ALPHA_post_kill_node", "targetname"));
    level.squad["ALLY_ALPHA"].goalradius = 64;
    level.squad["ALLY_ALPHA"] waittill("goal");
    level.squad["ALLY_ALPHA"] maps\_utility::cqb_aim(self);
    wait 0.6;

    if(isalive(self) && level.player.active_anim == 0) {
      var_0 = level.squad["ALLY_ALPHA"] gettagorigin("tag_flash");
      var_1 = self getshootatpos();
      level.squad["ALLY_ALPHA"] safe_magic_bullet(var_0, var_1);
      self kill();
    }
  }
}

trainyard_enemy_logic_wait(var_0) {
  self endon("death");
  level.player notifyonplayercommand("stab", "+melee");
  level.player notifyonplayercommand("stab", "+melee_breath");
  level.player notifyonplayercommand("stab", "+melee_zoom");
  thread check_player_ready_for_train_kill();
  common_scripts\utility::flag_wait("trig_intro_vignette");
  maps\_utility::smart_dialogue("factory_vs3_movingtoloadingdocks");
  thread maps\_utility::smart_dialogue("factory_vs2_copythat");
  common_scripts\utility::flag_wait("player_exited_train");

  while(!common_scripts\utility::flag("trainyard_enemy_alerted")) {
    level.player waittill("stab");

    if(common_scripts\utility::flag("player_ready_for_train_kill") && isalive(self)) {
      level.player.in_stab_animation = 1;
      var_1 = player_start_stabbing();
      level.player setstance("stand");
      level.player allowcrouch(0);
      var_2 = common_scripts\utility::getstruct("opfor_trainyard_walk", "script_noteworthy");
      var_3 = [];
      var_3[0] = var_1;
      var_3[1] = self;
      thread maps\factory_audio::audio_player_train_track_stealth_kill();
      var_2 maps\_anim::anim_first_frame(var_3, "factory_opfor_trainyard_melee_death");
      var_4 = 0.15;
      level.player playerlinktoblend(var_1, "tag_player", var_4, 0.25, 0.25);
      wait(var_4);
      level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
      var_1 show();
      common_scripts\utility::flag_set("trainyard_kill_sequence_used");
      maps\_utility::radio_dialogue_stop();
      var_1 attach("weapon_parabolic_knife", "tag_weapon_right", 1);
      thread flashlight_drop_detail();
      maps\_utility::delaythread(0.5, maps\factory_fx::fx_intro_kill_ally_stab, self);
      maps\_utility::delaythread(2.5, maps\factory_fx::fx_intro_kill_ally_stab, self);
      var_2 maps\_anim::anim_single(var_3, "factory_opfor_trainyard_melee_death");
      self dropweapon(self.weapon, "right", 0);
      maps\_utility::gun_remove();
      var_1 detach("weapon_parabolic_knife", "tag_weapon_right", 1);
      level.player unlink();
      var_1 delete();
      level.player.in_stab_animation = undefined;
      player_done_stabbing();
      maps\_vignette_util::vignette_actor_kill();
      return;
    }

    wait 0.01;
  }
}

check_player_ready_for_train_kill() {
  level endon("trainyard_kill_sequence_used");

  while(!common_scripts\utility::flag("trainyard_enemy_dead")) {
    if(level.player.origin[0] < self.origin[0] && level.player.origin[0] > self.origin[0] - 150 && level.player.origin[1] < self.origin[1] + 35 && level.player.origin[1] > self.origin[1] - 35 && level.player.angles[1] < 20 && level.player.angles[1] > -20) {
      common_scripts\utility::flag_set("player_ready_for_train_kill");
      maps\_utility::display_hint("train_stab_hint");
      level.player allowmelee(0);
    } else {
      common_scripts\utility::flag_clear("player_ready_for_train_kill");
      level.player allowmelee(1);
    }

    wait 0.01;
  }

  level.player allowmelee(1);
}

flashlight_drop_detail() {
  maps\factory_powerstealth::detach_flashlight();
  wait 1.5;
  maps\factory_powerstealth::flashlight_light(0);
}

intro_ally_moveout() {
  common_scripts\utility::flag_wait("trig_intro_vignette");
  thread intro_ally_charlie_train_rollout();
  common_scripts\utility::flag_wait("trainyard_enemy_dead");

  foreach(var_1 in level.squad) {
    var_1 maps\_utility::enable_ai_color();
  }
}

intro_ally_charlie_train_rollout() {
  var_0 = common_scripts\utility::getstruct("factory_intro", "script_noteworthy");
  level.squad["ALLY_CHARLIE"].a.pose = "crouch";
  var_0 maps\_anim::anim_first_frame_solo(level.squad["ALLY_CHARLIE"], "factory_intro_ally03");
  common_scripts\utility::flag_wait("trainyard_enemy_dead");

  if(common_scripts\utility::flag("trainyard_kill_sequence_used")) {
    wait 1.0;
  }

  var_0 maps\_anim::anim_single_solo(level.squad["ALLY_CHARLIE"], "factory_intro_ally03");
  waittillframeend;
  level.squad["ALLY_CHARLIE"] stopanimscripted();
  level.squad["ALLY_CHARLIE"] maps\_utility::enable_ai_color();
  level.squad["ALLY_CHARLIE"] maps\_utility::disable_cqbwalk();
  maps\factory_util::safe_trigger_by_targetname("sca_post_rollout_charlie");
}

intro_kill_vignette() {
  level.squad["ALLY_ALPHA"] notify("intro_kill_sequence_start");
  waittillframeend;
  thread intro_ally_moveout();
  common_scripts\utility::flag_wait("player_exited_train");

  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_cqbwalk();
  }

  level.squad["ALLY_BRAVO"] stopanimscripted();
  level.squad["ALLY_ECHO"] stopanimscripted();
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "ALLY_BRAVO_intro_teleport");
  maps\factory_util::actor_teleport(level.squad["ALLY_ECHO"], "ALLY_ECHO_intro_teleport");
  common_scripts\utility::flag_wait_all("trainyard_enemy_dead", "trig_intro_vignette");
  level.squad["ALLY_ALPHA"] pushplayer(1);
  level.squad["ALLY_CHARLIE"] pushplayer(1);
  level.squad["ALLY_ALPHA"].disableplayeradsloscheck = 0;

  foreach(var_4 in level.squad) {
    var_4 maps\_utility::enable_ai_color();
  }

  maps\factory_util::safe_trigger_by_targetname("intro_allies_first_moveout");
}

kill_trainyard_enemy(var_0) {
  var_0.allowdeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  level.squad["ALLY_BRAVO"] shootblank();
  var_0 kill(level.squad["ALLY_BRAVO"].origin, level.squad["ALLY_BRAVO"]);
}

intro_scene() {
  common_scripts\utility::flag_wait("player_exited_train");
  common_scripts\utility::flag_wait("factory_exterior_reveal");

  if(!common_scripts\utility::flag("trainyard_enemy_dead")) {
    kill_trainyard_enemy(level.train_kill);
  }

  level.squad["ALLY_ALPHA"] maps\_utility::disable_cqbwalk();
  level.squad["ALLY_BRAVO"] maps\_utility::disable_cqbwalk();
  level.squad["ALLY_CHARLIE"] maps\_utility::disable_cqbwalk();
  maps\factory_util::safe_trigger_by_targetname("intro_allies_leave_trains");
  common_scripts\utility::flag_wait("factory_exterior_reveal_between_trains");
  wait 1;
  thread maps\factory_util::god_rays_factory_awning();
  maps\factory_util::safe_trigger_by_targetname("intro_allies_past_trains1");
  common_scripts\utility::flag_wait("factory_exterior_approach_infil");
  wait 0.1;
  maps\factory_util::safe_trigger_by_targetname("intro_allies_past_trains2");
  wait 3.1;
  level.squad["ALLY_BRAVO"] maps\_utility::enable_cqbwalk();
  level.squad["ALLY_CHARLIE"] maps\_utility::enable_cqbwalk();
  common_scripts\utility::flag_wait("intro_checkpoint_done");
  level.squad["ALLY_ALPHA"] pushplayer(0);
  level.squad["ALLY_CHARLIE"] pushplayer(0);
}

intro_scene_tweak_ally_runs() {
  level endon("factory_exterior_reveal_between_trains");
  level.squad["ALLY_BRAVO"] maps\_utility::enable_cqbwalk();
  wait 3.5;
  level.squad["ALLY_BRAVO"] maps\_utility::disable_cqbwalk();
  wait 3.8;
  level.squad["ALLY_BRAVO"] maps\_utility::enable_cqbwalk();
  wait 0.8;
  level.squad["ALLY_CHARLIE"] maps\_utility::enable_cqbwalk();
}

delta_splitup() {
  level endon("intro_truck_driver_dead");
  level endon("truck_kill_timed_out");
  level endon("deleting_echo");
  thread buddy_boost_echo();
  var_0 = getent("vol_delete_squad_splinter", "targetname");

  while(!level.squad["ALLY_ECHO"] istouching(var_0)) {
    wait 0.1;
  }

  thread delete_squad_splinter();
  common_scripts\utility::flag_wait("factory_exterior_reveal");
  common_scripts\utility::flag_wait("intro_checkpoint_done");
}

buddy_boost_echo() {
  level endon("deleting_echo");
  level.squad["ALLY_ECHO"] maps\factory_rooftop::ally_vignette_traversal("engine_jump_ally02", "factory_engine_jump_ally02");
  maps\factory_util::safe_trigger_by_targetname("squad_splitup");
}

delete_squad_splinter() {
  var_0 = level.squad["ALLY_ALPHA"];
  var_1 = level.squad["ALLY_BRAVO"];
  var_2 = level.squad["ALLY_CHARLIE"];
  var_3 = level.squad["ALLY_ECHO"];
  level.squad = undefined;
  level.squad["ALLY_ALPHA"] = var_0;
  level.squad["ALLY_BRAVO"] = var_1;
  level.squad["ALLY_CHARLIE"] = var_2;
  level notify("deleting_echo");

  if(isDefined(level.squad["ALLY_ECHO"])) {
    level.squad["ALLY_ECHO"] delete();
  }
}

handle_player_leaving_mission() {
  level endon("railgun_reveal_setup");
  thread check_for_player_leaving();
  common_scripts\utility::flag_wait("player_exited_mission_warning");
  var_0 = ["factory_mrk_adamwhatreyoudoing", "factory_mrk_adamgetbackon", "factory_mrk_adamgetbackhere"];
  level.squad["ALLY_ALPHA"] thread maps\factory_util::nag_line_generator(undefined, "player_came_back");

  while(common_scripts\utility::flag("player_exited_mission_warning")) {
    wait 0.1;
  }

  level notify("player_came_back");
  thread handle_player_leaving_mission();
}

check_for_player_leaving() {
  level endon("railgun_reveal_setup");
  common_scripts\utility::flag_wait("player_exited_mission");
  level notify("new_quote_string");
  setdvar("ui_deadquote", &"FACTORY_FAIL_ABANDONED");
  maps\_utility::missionfailedwrapper();
}

intro_truck_setup() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("factory_truck_cab_spawner");
  var_0.animname = "het_cab";
  level.intro_truck_cab = var_0;
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("factory_truck_trailer_spawner");
  var_1.animname = "het_trailer";
  var_2 = spawn("script_model", (4740, 3712, 552));
  var_2 setModel("tag_origin");
  var_1 maps\_vehicle::vehicle_lights_on("running");
  var_0 maps\_vehicle::vehicle_lights_on("running");
  common_scripts\utility::flag_wait("factory_exterior_reveal");
  thread maps\factory_audio::audio_sfx_truck_pull_away_start();
  var_0 startpath();
  var_1 startpath();
  var_3 = getent("truck_sequence_node", "script_noteworthy");
  var_4 = getent("intro_truck_driver", "script_noteworthy");
  var_5 = var_4 maps\_utility::spawn_ai();
  var_5 linkto(var_3);
  var_5.ignoreall = 1;
  var_5 allowedstances("stand");
  var_5.animname = "enemy";
  var_5.noragdoll = 1;
  var_5.deathanim = % factory_truck_driver_death;
  var_5 thread handle_driver_death();
  var_6 = getEntArray("intro_pmcs", "targetname");
  thread maps\factory_audio::audio_sfx_truck_chatter(var_6, var_0);
  var_3 thread factory_truck_entrance(var_0, var_1, var_5);
  var_5 thread maps\factory_powerstealth::ps_check_for_player_damage();
  var_5 thread intro_truck_failsafe();
  common_scripts\utility::flag_wait("entered_factory_1");
}

handle_driver_death() {
  self endon("entered_factory_1");
  self waittill("damage", var_0, var_1);
  self linkto(level.intro_truck_cab);
}

factory_truck_entrance(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait("factory_entrance_reveal");
  level.intro_truck_cab = maps\_vehicle::spawn_vehicle_from_targetname("factory_truck_cab_spawner");
  level.intro_truck_trailer = maps\_vehicle::spawn_vehicle_from_targetname("factory_truck_trailer_spawner");
  level.intro_truck_cab.animname = "het_cab";
  level.intro_truck_trailer.animname = "het_trailer";
  level.intro_truck_cab maps\_vehicle::vehicle_lights_on("running");
  level.intro_truck_trailer maps\_vehicle::vehicle_lights_on("running");
  var_0 delete();
  var_1 delete();
  thread maps\factory_audio::audio_sfx_truck_in_start();
  thread maps\_anim::anim_single_solo(var_2, "factory_truck_driver_loop");
  level.intro_truck_cab notify("suspend_drive_anims");
  level.intro_truck_trailer notify("suspend_drive_anims");
  var_3 = getvehiclenode("truck_entrance_path_end", "targetname");
  var_4 = [];
  var_4[0] = level.intro_truck_cab;
  var_4[1] = level.intro_truck_trailer;
  thread maps\_anim::anim_single(var_4, "factory_truck_entrance");
}

factory_ingress_start() {
  foreach(var_1 in level.squad) {
    var_1 maps\_utility::disable_bulletwhizbyreaction();
    var_1 maps\_utility::disable_pain();
  }

  level.player switchtoweapon(level.default_weapon);
  level.player takeweapon("flash_grenade");
  level.player takeweapon("fraggrenade");
  common_scripts\utility::flag_set("intro_checkpoint_done");
  common_scripts\utility::flag_set("player_entered_awning");
  maps\factory_powerstealth::teleport_squad("factory_ingress", "deltaecho");
  common_scripts\utility::flag_set("trainyard_enemy_dead");
  maps\_utility::player_speed_percent(70);
  thread factory_entrance_setup();
  thread handle_player_leaving_mission();
  thread factory_entrance_dialogue_management();
  maps\_utility::battlechatter_off();
  thread intro_truck_setup();
  common_scripts\utility::flag_set("factory_exterior_reveal");
  var_3 = getent("sca_trainyard_exit", "targetname");
  var_3 common_scripts\utility::trigger_off();
}

factory_ingress() {
  thread factory_entrance_reveal();
  thread maps\factory_powerstealth::conveyor_crate_setup();
  thread maps\_weather::rainmedium(0);
  level.cosine["70"] = cos(70);
  level.goodfriendlydistancefromplayersquared = 62500;

  foreach(var_1 in level.squad) {
    var_1.ignoreall = 1;
  }

  var_3 = maps\_utility::get_living_ai_array("intro_pmcs", "targetname");

  foreach(var_5 in var_3) {
    var_5.ignoreall = 1;
  }

  common_scripts\utility::flag_set("factory_entrance_setup");

  foreach(var_5 in level.squad) {
    var_5 maps\_utility::enable_cqbwalk();
    var_5 maps\_utility::disable_sprint();
    var_5.accuracy = 100;
  }

  common_scripts\utility::flag_wait("enter_factory");
  thread maps\_weather::rainnone(5);
}

factory_entrance_setup() {
  var_0 = getEntArray("intro_pmcs", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3.ignoreall = 1;
    var_3 thread maps\factory_powerstealth::ps_check_for_player_damage();
  }

  thread maps\factory_fx::fx_show_hide("intro_cardreader_lock", "intro_cardreader_unlock");
  maps\_utility::stop_exploder("intro_cardreader_unlock");
  common_scripts\utility::exploder("intro_cardreader_lock");
}

entrance_first_kill() {
  maps\factory_util::safe_trigger_by_targetname("move_from_entrance_kill");
}

factory_entrance_enc() {
  var_0 = maps\_utility::get_living_ai("entrance_enemy_03", "script_noteworthy");
  level.squad["ALLY_ALPHA"].favoriteenemy = var_0;
  var_1 = maps\_utility::get_living_ai("entrance_enemy_02", "script_noteworthy");
  level.squad["ALLY_BRAVO"].favoriteenemy = var_1;
  var_2 = maps\_utility::get_living_ai("entrance_enemy_01", "script_noteworthy");
  level.squad["ALLY_CHARLIE"].favoriteenemy = var_2;

  foreach(var_4 in level.squad) {
    var_4.disableplayeradsloscheck = 1;
    var_4 pushplayer(1);
  }

  var_6 = [var_0, var_1, var_2];
  thread handle_player_exposing(var_6);
  thread setup_factory_entrance_enc(var_6);
  level.squad["ALLY_BRAVO"] thread bravo_ingress_detail();
  level.squad["ALLY_CHARLIE"] thread charlie_ingress_detail();
  level.squad["ALLY_ALPHA"] thread strafe_entrance();
  thread detect_allies_at_entrance();
  common_scripts\utility::flag_wait_all("factory_entrance_reveal");
  wait 0.5;
  level thread set_flag_on_player_action("intro_truck_driver_dead");
  level thread truck_kill_timeout();
  common_scripts\utility::flag_wait("intro_truck_driver_dead");

  if(!common_scripts\utility::flag("all_allies_at_entrance")) {
    level notify("stealth_broken");
  }

  foreach(var_4 in var_6) {
    var_4 stopsounds();
  }

  eliminate_all_targets(var_6);
  common_scripts\utility::flag_set("truck_kills_done");
  maps\_utility::battlechatter_off("axis");
  wait 1.2;
  level.squad["ALLY_ALPHA"] thread alpha_post_truck_sequence();
  wait 1;
  level.squad["ALLY_CHARLIE"] thread charlie_search_body(var_1);
  wait 2.0;
  thread maps\factory_powerstealth::factory_entrance_reveal_animate_pieces();
  wait 2.0;
  common_scripts\utility::flag_wait("outer_perim_cleared");
  common_scripts\utility::flag_wait("card_swiped");
  thread maps\factory_fx::fx_intro_cardreader_unlock();
  wait 0.15;
  thread maps\factory_util::god_rays_factory_open();
  thread open_factory_door();
  thread maps\factory_audio::audio_factory_door_open();
  thread factory_ingress_dialogue();
  common_scripts\utility::flag_set("music_factory_reveal");
  factory_door_kill();
  maps\factory_util::safe_trigger_by_targetname("sca_stairway_post");
  waittillframeend;
  level.squad["ALLY_ALPHA"] thread alpha_ingress_go();
  level.squad["ALLY_BRAVO"] thread bravo_ingress_go();
  common_scripts\utility::flag_set("outer_perim_cleared");

  foreach(var_4 in level.squad) {
    var_4.ignoreall = 1;
    var_4.disableplayeradsloscheck = 0;
    var_4 pushplayer(0);
  }
}

eliminate_all_targets(var_0) {
  level endon("entered_factory_1");

  if(isDefined(level.squad["ALLY_ECHO"])) {
    delete_squad_splinter();
  }

  level.truck_kills = 0;
  level.ai_friendlyfireblockduration = getdvarfloat("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);

  foreach(var_2 in level.squad) {
    var_2 thread eliminate_my_target();
    wait 0.25;
  }

  while(level.truck_kills < 3) {
    wait 0.1;
  }

  setsaveddvar("ai_friendlyFireBlockDuration", level.ai_friendlyfireblockduration);
}

eliminate_my_target() {
  self endon("death");
  maps\_utility::disable_pain();
  detect_ally_at_entrance();

  if(isalive(self.favoriteenemy)) {
    if(isDefined(self.favoriteenemy.dead)) {
      level.truck_kills = level.truck_kills + 1;
      maps\_utility::enable_pain();
      return;
    }

    var_0 = self gettagorigin("tag_flash");
    var_1 = self.favoriteenemy getshootatpos();
    thread fire_on_target(self.favoriteenemy, var_0, var_1);
    wait 0.05;

    if(self.favoriteenemy.script_noteworthy != "entrance_enemy_02") {
      self.favoriteenemy kill();
    } else {
      self.favoriteenemy dodamage(1, (0, 0, 0));
    }

    self.favoriteenemy dropweapon(self.favoriteenemy.weapon, "right", 0);
    self.favoriteenemy maps\_utility::gun_remove();
  }

  level.truck_kills = level.truck_kills + 1;
  maps\_utility::enable_pain();
}

detect_ally_at_entrance() {
  var_0 = getent("vol_entrance_squad_count", "script_noteworthy");

  while(!self istouching(var_0)) {
    wait 0.1;
  }
}

fire_on_target(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 <= randomintrange(2, 3); var_3++) {
    safe_magic_bullet(var_1, var_2);
    wait 0.0769;
  }
}

detect_allies_at_entrance() {
  level endon("truck_kills_done");
  var_0 = getent("vol_entrance_squad_count", "script_noteworthy");

  for(;;) {
    var_1 = var_0 maps\_utility::get_ai_touching_volume("allies");

    if(var_1.size > 2) {
      break;
    }

    wait 0.15;
  }

  common_scripts\utility::flag_set("all_allies_at_entrance");
}

truck_kill_timeout() {
  level endon("intro_truck_driver_dead");
  common_scripts\utility::flag_wait_or_timeout("intro_truck_driver_dead", 12.5);
  common_scripts\utility::flag_set("truck_kill_timed_out");
  wait 1.5;
  common_scripts\utility::flag_set("intro_truck_driver_dead");
}

alpha_post_truck_sequence() {
  level endon("entered_factory_1");
  level.squad["ALLY_BRAVO"] thread bravo_post_truck_sequence();
  var_0 = getnode("alpha_after_truck_kill", "script_noteworthy");
  self setgoalnode(var_0);
  self waittill("goal");
  self allowedstances("crouch", "prone");
  common_scripts\utility::flag_wait("start_search");
  wait 5.5;
  self allowedstances("crouch", "prone", "stand");
  self.goalradius = 64;
  self.disablearrivals = 1;
  var_0 = getnode("alpha_path_to_dock", "script_noteworthy");
  maps\_utility::follow_path(var_0);
  maps\factory_util::safe_trigger_by_targetname("allies_factory_entrance");
  self waittill("goal");
  self.disablearrivals = 0;
  self.disableexits = 0;
}

bravo_post_truck_sequence() {
  level endon("entered_factory_1");
  wait 0.5;
  self.goalradius = 8;
  var_0 = getnode("bravo_truck_search_1st_pos", "script_noteworthy");
  self setgoalnode(var_0);
  self waittill("goal");
  wait 3.0;
}

factory_door_kill() {
  var_0 = getent("factory_door_kill_stationary", "script_noteworthy");
  var_1 = getent("factory_door_kill_mobile", "script_noteworthy");
  var_0 maps\_utility::add_spawn_function(::factory_door_guard_stationary);
  var_1 maps\_utility::add_spawn_function(::factory_door_guard_mobile);
  var_2 = var_0 maps\_utility::spawn_ai(1);
  var_3 = var_1 maps\_utility::spawn_ai(1);
  var_4 = getent("agv_fac_entry_right", "targetname");
  var_4 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  var_4 maps\_vehicle::spawn_vehicle_and_gopath();
  thread forklift_far();
  thread forklift_lifting();
  thread forklift_parking();
  wait 1.45;
  level.squad["ALLY_BRAVO"] thread maps\_utility::smart_dialogue("factory_kgn_twoahead");
  common_scripts\utility::flag_wait_or_timeout("first_door_guard_shot", 2);

  if(!common_scripts\utility::flag("first_door_guard_shot")) {
    level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_dropem");
  }

  wait 0.4;

  if(isalive(var_2)) {
    level.squad["ALLY_BRAVO"] shootblank();
    level.squad["ALLY_BRAVO"] safe_magic_bullet(level.squad["ALLY_BRAVO"] gettagorigin("tag_flash"), var_2 getshootatpos());
    var_2 kill();
  }

  wait 0.25;

  if(isalive(var_3)) {
    level.squad["ALLY_ALPHA"] shootblank();
    level.squad["ALLY_ALPHA"] safe_magic_bullet(level.squad["ALLY_ALPHA"] gettagorigin("tag_flash"), var_3 getshootatpos());
    var_3 kill();
  }

  wait 0.5;
  level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_dialogue("factory_hsh_cleartomove");
  common_scripts\utility::flag_set("enter_factory");
}

forklift_far() {
  var_0 = getent("agv_fac_entry_far_crate", "targetname");
  var_1 = getent("col_agv_fac_entry_far_crate", "targetname");
  var_2 = getent("agv_fac_entry_far", "targetname");
  var_2 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
  var_0.angles = var_3.angles;
  var_0 linkto(var_3);
  var_1 linkto(var_3);
}

forklift_lifting() {
  var_0 = getent("agv_fac_entry_far_lifting", "targetname");
  var_1 = getent("col_agv_fac_entry_far_lifting", "targetname");
  var_2 = getent("agv_fac_entry_lifting", "targetname");
  var_2 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
  var_0.angles = var_3.angles;
  var_0 linkto(var_3);
  var_1 linkto(var_3);
}

forklift_parking() {
  var_0 = getent("agv_fac_entry_parking", "targetname");
  var_0 maps\_utility::add_spawn_function(maps\factory_util::forklift_run_over_monitor);
  var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
}

safe_magic_bullet(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = bulletTrace(var_0, var_1, 1);
  var_5 = 0;

  foreach(var_7 in level.squad) {
    if(isDefined(var_4["entity"]) && var_4["entity"] == var_7) {
      var_5 = 1;
    }
  }

  if(isDefined(var_4["entity"]) && var_4["entity"] == level.player || var_5 == 1) {
    var_3 = 1;
  }

  if(isDefined(var_4["fraction"]) < 0.8) {
    var_3 = 1;
  }

  playFXOnTag(common_scripts\utility::getfx("silencer_flash"), self, "tag_flash");

  if(var_3) {
    var_9 = vectortoangles(var_1 - var_0);
    var_10 = anglesToForward(var_9);
    var_0 = var_1 + var_10 * -10;
  }

  self shootblank();

  if(isDefined(var_2)) {
    magicbullet(var_2, var_0, var_1);
  } else {
    magicbullet(self.weapon, var_0, var_1);
  }
}

factory_door_guard_stationary() {
  self endon("entered_factory_1");
  thread factory_door_guard_player_spotted();
  thread maps\factory_powerstealth::ps_check_for_player_damage();
  self.animname = "enemy";
  self.ignoreall = 1;
  self.allowdeath = 1;
  self.health = 1;
  var_0 = getent("factory_door_kill_stationary_node", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "factory_truck_enemy02_loop");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_truck_enemy02_loop", "stop_loop");
  self waittill("damage", var_1, var_2);
  common_scripts\utility::flag_set("first_door_guard_shot");
  var_0 notify("stop_loop");
  wait 0.2;
  var_3 = maps\_utility::get_living_ai("factory_door_kill_mobile", "script_noteworthy");

  if(isDefined(var_3)) {
    var_3 maps\_anim::anim_single_solo(var_3, "patrol_bored_walk_2_scared_idle_turn_r_90");
  }
}

factory_door_guard_mobile() {
  self endon("entered_factory_1");
  thread factory_door_guard_player_spotted();
  thread maps\factory_powerstealth::ps_check_for_player_damage();
  self.animname = "enemy";
  self.ignoreall = 1;
  self.allowdeath = 1;
  self.health = 1;
  var_0 = getent("factory_door_kill_mobile_node", "targetname");
  thread maps\_anim::anim_single_solo(self, "factory_truck_enemy01_enter");
  self waittill("damage", var_1, var_2);
  common_scripts\utility::flag_set("first_door_guard_shot");
  wait 0.2;
  var_3 = maps\_utility::get_living_ai("factory_door_kill_stationary", "script_noteworthy");

  if(isDefined(var_3)) {
    var_3 maps\_anim::anim_single_solo(var_3, "scared_idle_turn_l_90");
  }
}

factory_door_guard_player_spotted() {
  self endon("death");
  var_0 = getent("factory_door_kill_stationary_node", "targetname");
  common_scripts\utility::flag_wait("entered_factory_1");
  wait(randomfloatrange(0, 0.25));

  if(!isalive(self)) {
    return;
  }
  var_0 notify("stop_loop");
  self stopanimscripted();
  level.player.ignoreme = 0;
  self.ignoreall = 0;
  self getenemyinfo(level.player);
  self.favoriteenemy = level.player;
  self setgoalentity(level.player);
}

strafe_entrance() {
  level endon("truck_kills_done");
  self.goalradius = 64;
  var_0 = getnode("alpha_after_first_kill", "script_noteworthy");
  var_1 = getnode("alpha_truck_path", "script_noteworthy");
  self.maxfaceenemydist = 1024;
  maps\_utility::follow_path(var_1);
  self.moveplaybackrate = 0.5;
  self setgoalnode(var_0);
  self.moveplaybackrate = 1.0;
}

charlie_search_body(var_0) {
  level endon("entered_factory_1");
  self pushplayer(1);
  var_1 = getent("truck_sequence_node_alt", "script_noteworthy");
  var_0.animname = "enemy";
  self.goalradius = 8;
  var_1 maps\_anim::anim_reach_solo(self, "factory_truck_ally02_search");
  common_scripts\utility::flag_set("start_search");
  var_1 thread maps\_anim::anim_single_solo(self, "factory_truck_ally02_search");
  thread maps\factory_audio::audio_factory_search_body();
  wait 2.0;
  common_scripts\utility::exploder("body_roll_dust");
  wait 1.5;
  thread maps\_utility::smart_dialogue("factory_rgs_gotone");
  var_2 = getent("security_card", "targetname");
  var_2.origin = level.squad["ALLY_CHARLIE"] gettagorigin("tag_inhand");
  var_2 linkto(level.squad["ALLY_CHARLIE"], "tag_inhand", (0.6, 0, 1), (-50, 0, 0));
  self.goalradius = 8;
  thread charlie_ingress_go();
  wait 1.7;
  var_2 delete();
}

bravo_ingress_detail() {
  common_scripts\utility::flag_wait("factory_entrance_reveal");
  self setgoalnode(getnode("bravo_truck_kill_node", "script_noteworthy"));
}

charlie_ingress_detail() {
  level endon("intro_truck_driver_dead");
  common_scripts\utility::flag_wait("factory_entrance_reveal");

  for(;;) {
    if(maps\_utility::players_within_distance(48, getnode("fac_ent_charlie_node", "targetname").origin)) {
      self.goalradius = 8;
      var_0 = getnode("fac_ent_stand_forklift_org", "targetname");
      self setgoalnode(var_0);
      break;
    }

    wait 1.0;
  }
}

handle_player_exposing(var_0) {
  level endon("truck_kills_done");
  common_scripts\utility::flag_wait_any("player_scene_interrupt", "intro_truck_driver_dead");
  level.player.ignoreme = 0;
  maps\_utility::battlechatter_on("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2.ignoreall = 0;
      var_2.favoriteenemy = level.player;

      if(var_2.team == "axis") {
        var_2 stopanimscripted();
      }

      var_2 setgoalpos(var_2.origin);
      var_2 maps\_utility::cqb_aim(level.player);
    }
  }

  var_4 = getent("truck_sequence_node_alt", "script_noteworthy");
  var_4 thread maps\_anim::anim_single_solo(level.clipboard, "factory_truck_enemy02_death");
  wait 1.0;
  maps\_utility::battlechatter_off();
  common_scripts\utility::flag_set("intro_truck_driver_dead");
  wait 1.0;
}

setup_factory_entrance_enc(var_0) {
  level endon("intro_truck_driver_dead");
  var_0[0] endon("death");
  var_0[1] endon("death");
  var_0[2] endon("death");
  common_scripts\utility::flag_wait("factory_entrance_reveal");
  var_0[0] thread ingress_enc_think_enemy01();
  var_0[1] thread ingress_enc_think_enemy02();
  var_0[2] thread ingress_enc_think_enemy03();
}

ingress_enc_think_enemy01() {
  self endon("death");
  level endon("entered_factory_1");
  self.allowdeath = 1;
  self.noragdoll = 1;
  self.animname = "enemy";
  self.fixednode = 1;
  var_0 = getent("truck_sequence_node", "script_noteworthy");
  var_0 maps\_anim::anim_single_solo(self, "factory_truck_enemy01");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_truck_enemy01_loop", "stop_loop");
}

ingress_enc_enemy01_kill(var_0) {
  self waittill("damage", var_1, var_2);

  if(common_scripts\utility::flag("truck_kill_timed_out")) {
    wait 1.0;
  }
}

ingress_enc_think_enemy02() {
  self endon("death");
  level endon("entered_factory_1");
  self.health = 999;
  self.allowdeath = 1;
  self.a.nodeath = 1;
  self.ignoreme = 1;
  self.animname = "enemy";
  maps\_utility::magic_bullet_shield();
  maps\_utility::disable_surprise();
  self.fixednode = 1;
  self.dontmelee = 1;
  self.delete_on_death = 0;
  level.clipboard = maps\_utility::spawn_anim_model("factory_intro_clipboard");
  var_0 = [];
  var_0[0] = self;
  var_0[1] = level.clipboard;
  var_1 = getent("truck_sequence_node_alt", "script_noteworthy");
  thread ingress_enc_enemy02_kill(var_0, var_1);
  var_1 thread maps\_anim::anim_single(var_0, "factory_truck_enemy02");
  wait 0.05;
  var_1 maps\_anim::anim_set_time(var_0, "factory_truck_enemy02", 0.1);
}

ingress_enc_enemy02_kill(var_0, var_1) {
  self endon("death");
  self waittill("damage", var_2, var_3);
  self.team = "neutral";
  self.no_pain_sound = 1;
  self.allowdeath = 0;
  self.allowpain = 0;
  self.diequietly = 1;
  self.nocorpsedelete = 1;
  self.dead = 1;
  self setcontents(0);
  var_1 thread maps\_anim::anim_single_solo(self, "factory_truck_enemy02_death");

  if(common_scripts\utility::flag("truck_kill_timed_out")) {
    var_1 thread maps\_anim::anim_single_solo(level.clipboard, "factory_truck_enemy02_death");
  }

  wait 2;
  wait(getanimlength(maps\_utility::getanim("factory_truck_enemy02_death")) - 2);
  var_1 maps\_anim::anim_first_frame_solo(self, "factory_truck_enemy02_death_searched");
  common_scripts\utility::flag_wait("start_search");
  var_1 maps\_anim::anim_single_solo(self, "factory_truck_enemy02_death_searched");
  maps\_utility::stop_magic_bullet_shield();
  maps\factory_anim::kill_no_react();
}

wait_for_damage_or_flag(var_0) {
  self endon("death");

  while(!common_scripts\utility::flag(var_0)) {
    common_scripts\utility::waittill_notify_or_timeout_return("damage", 0.1);
  }
}

ingress_enc_think_enemy03() {
  self endon("death");
  level endon("entered_factory_1");
  self.allowdeath = 1;
  self.animname = "enemy";
  self.fixednode = 1;
  var_0 = getent("truck_sequence_node", "script_noteworthy");
  var_0 maps\_anim::anim_single_solo(self, "factory_truck_enemy03");
  var_0 thread maps\_anim::anim_loop_solo(self, "factory_truck_enemy03_loop", "stop_loop");
}

intro_truck_failsafe() {
  level endon("entered_factory_1");
  common_scripts\utility::flag_wait("intro_truck_driver_dead");

  if(isalive(self)) {
    self stopanimscripted();
    level.squad["ALLY_ALPHA"] shootblank();
    level.squad["ALLY_ALPHA"] safe_magic_bullet(level.squad["ALLY_ALPHA"] gettagorigin("tag_flash"), self getshootatpos());
    self kill();
  }
}

open_factory_door() {
  var_0 = getent("factory_entrance_door", "script_noteworthy");
  var_0 movez(184, 8, 1, 3);
  common_scripts\utility::exploder("door_open");
  thread maps\factory_audio::sfx_garage_reveal_crane();
  wait 4;
  var_0 connectpaths();
  common_scripts\utility::flag_wait("exited_conveyor");
  var_0 movez(-184, 5, 1, 1);
  var_0 disconnectpaths();
}

factory_entrance_reveal() {
  common_scripts\utility::flag_wait("player_entered_awning");
  thread maps\factory_audio::sfx_garage_reveal_filtered();
  entrance_first_kill();
  factory_entrance_enc();
  common_scripts\utility::flag_wait("outer_perim_cleared");
  common_scripts\utility::flag_wait("entered_factory_1");
}

factory_ingress_dialogue() {
  level endon("entered_conveyor");
  common_scripts\utility::flag_wait("entered_factory_1");
  wait 0.5;
  thread maps\factory_audio::audio_factory_reveal_mix("one");
  wait 0.5;
  thread maps\factory_audio::audio_factory_wait_for_mix_change();
  common_scripts\utility::flag_wait("ingress_dialogue_kickoff");
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_keepyoureyesout");
  wait 0.5;
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_oldboyhowarethose");
  maps\_utility::smart_radio_dialogue("factory_oby_merrickeyesonyour");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_mrk_wellmakeourown");
}

charlie_ingress_go() {
  level endon("powerstealth_end");
  self notify("stop_adjust_movement_speed");
  self.goalradius = 8;
  var_0 = getnode("factory_ingress_node_ally01", "script_noteworthy");
  var_0 maps\_anim::anim_reach_and_approach_solo(self, "factory_allies_enter_factory_ally_01", undefined);
  self setgoalnode(var_0);
  common_scripts\utility::flag_wait("outer_perim_cleared");
  thread maps\factory_audio::audio_play_unlock_sound();
  common_scripts\utility::flag_set("card_swiped");
  common_scripts\utility::flag_wait("enter_factory");
  maps\_utility::disable_cqbwalk();
  var_0 = getnode("charlie_anim1", "targetname");
  self.goalradius = 16;
  var_0 maps\_anim::anim_reach_solo(self, "combatwalk_F_spin");
  common_scripts\utility::flag_set("ingress_dialogue_kickoff");

  if(!common_scripts\utility::flag("entered_loading_area")) {
    var_0 maps\_anim::anim_single_solo(self, "combatwalk_F_spin");
    self setgoalpos(self.origin);
  }

  self setgoalnode(getnode("charlie_anim1_end", "targetname"));
  maps\_utility::enable_ai_color();
  self waittill("goal");
  self.moveplaybackrate = 1.0;
  self notify("stop_adjust_movement_speed");
  maps\factory_util::safe_trigger_by_targetname("sca_powerstealth_regroup");
}

bravo_ingress_go() {
  level endon("exited_conveyor");
  self notify("stop_adjust_movement_speed");
  self.goalradius = 8;
  maps\_utility::disable_cqbwalk();
  var_0 = getnode("stairway_post_bravo", "targetname");
  self setgoalnode(var_0);
  self waittill("goal");
  common_scripts\utility::flag_wait("ps_begin");
  self.moveplaybackrate = 1.0;
  self notify("stop_adjust_movement_speed");
}

alpha_ingress_go() {
  level endon("exited_conveyor");
  self notify("stop_adjust_movement_speed");
  self.goalradius = 128;
  maps\_utility::disable_cqbwalk();
  manage_ally_cqb();
  self setgoalnode(getnode("alpha_ingress_path2", "script_noteworthy"));
  self waittill("goal");
  self notify("stop_adjust_movement_speed");
}

manage_ally_cqb() {
  self endon("stop_cqb_management");
  var_0 = getent("vol_ps_staircase", "targetname");

  while(self istouching(var_0)) {
    maps\_utility::enable_cqbwalk();
    self.moveplaybackrate = 1.0;
    self notify("stop_adjust_movement_speed");
    wait 0.5;
  }

  maps\_utility::disable_cqbwalk();
  self notify("stop_cqb_management");
}

factory_entrance_dialogue_management() {
  level endon("entered_factory_1");
  common_scripts\utility::flag_wait("player_entered_awning");

  if(!common_scripts\utility::flag("intro_truck_driver_dead") && !common_scripts\utility::flag("player_scene_interrupt")) {
    level.squad["ALLY_ALPHA"] maps\_utility::radio_dialogue("factory_bkr_targetsahead");
  }

  common_scripts\utility::flag_wait("factory_entrance_reveal");
  common_scripts\utility::flag_wait_any("all_allies_at_entrance", "intro_truck_driver_dead", "player_scene_interrupt");

  if(!common_scripts\utility::flag("intro_truck_driver_dead") && !common_scripts\utility::flag("truck_kill_timed_out")) {
    thread maps\_utility::smart_radio_dialogue("factory_bkr_getatarget");
    thread factory_entrance_nag_line();
  }

  common_scripts\utility::flag_wait_any("intro_truck_driver_dead", "truck_kill_timed_out", "player_scene_interrupt");

  if(common_scripts\utility::flag("truck_kill_timed_out")) {
    level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_dropem");
    level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_donthaveallday");
    wait 1.5;
  }

  if(common_scripts\utility::flag("player_scene_interrupt")) {
    level notify("stealth_broken");
    maps\_utility::smart_radio_dialogue("factory_mrk_adamwhatreyoudoing");
  }

  common_scripts\utility::flag_wait("truck_kills_done");
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_allclearheshgrab");
  wait 3;
  level.squad["ALLY_BRAVO"] thread maps\_utility::smart_dialogue("factory_kgn_coverleft");
  common_scripts\utility::flag_wait("start_search");
  level.squad["ALLY_CHARLIE"] thread maps\_utility::smart_dialogue("factory_hsh_grabbinghissecuritybadge");
  wait 4.5;
  level.squad["ALLY_ALPHA"] thread maps\_utility::smart_dialogue("factory_mrk_onthedoor");
  common_scripts\utility::flag_wait("card_swiped");
  maps\_utility::smart_radio_dialogue("factory_rgs_opening");
  common_scripts\utility::flag_wait("outer_perim_cleared");
}

factory_entrance_nag_line() {
  level endon("intro_truck_driver_dead");
  level endon("player_scene_interrupt");
  level endon("truck_kill_timed_out");
  wait 7;
  thread maps\_utility::smart_radio_dialogue("factory_bkr_taketheshot");
}

train_cleanup() {
  var_0 = getEntArray("fac_intro_trains", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

set_flag_on_player_action(var_0, var_1, var_2) {
  level notify("kill_action_flag");
  level endon("kill_action_flag");
  level endon(var_0);

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  for(;;) {
    var_3 = level.player common_scripts\utility::waittill_any_return("weapon_fired", "fraggrenade", "flash_grenade", "smoke_grenade_american");

    if(!isDefined(var_3)) {
      break;
    }

    if(var_3 == "weapon_fired") {
      break;
    }

    if(var_3 == "fraggrenade" && isDefined(var_2)) {
      break;
    }

    if(var_3 == "flash_grenade" && isDefined(var_1)) {
      break;
    }
  }

  common_scripts\utility::flag_set(var_0);
}