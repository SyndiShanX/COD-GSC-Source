/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly.gsc
***********************************************/

main() {
  scripts\sp\maps\piccadilly\gen\piccadilly_art.gsc::main();
  scripts\sp\maps\piccadilly\piccadilly_fx.gsc::main();
  scripts\sp\maps\piccadilly\piccadilly_anim.gsc::main();
  scripts\sp\maps\piccadilly\piccadilly_precache.gsc::main();
  scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::main();
  scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::setup_lighting();
  scripts\sp\fakeactor::fakeactor_spawner_init();
  setDvar("pic_intro", 1);
  setdvarifuninitialized("scr_turret_ai_animation_hack", 1);
  setdvarifuninitialized("scr_turret_fire_hack", 1);
  setdvarifuninitialized("scr_picc_ai_debug", 0);
  setdvarifuninitialized("scr_charge_player", 1);
  setdvarifuninitialized("scr_instafail_debug", 0);
  setdvarifuninitialized("scr_show_player_fov", 0);
  setdvarifuninitialized("scr_debug_achievement", 0);
  setsaveddvar("NPNOOMMTPK", 400);
  setsaveddvar("LOMSNQRPQN", 150);
  setsaveddvar("LQPTMLQPPN", 1);
  setsaveddvar("LTMPKRLLNM", 3700);
  setsaveddvar("OLPNKQKKTT", 3000);
  setsaveddvar("MMLNNQSTTL", 10);
  scripts\engine\sp\utility::add_start("infil", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::start, "", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_infil.gsc::catchup);
  scripts\engine\sp\utility::add_start("infil_car1", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::infil_car1_start, "", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::infil_car1_main, undefined, scripts\sp\maps\piccadilly\piccadilly_infil.gsc::infil_car1_catchup);
  scripts\engine\sp\utility::add_start("post_bomb", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::post_bomb_start, "", scripts\sp\maps\piccadilly\piccadilly_infil.gsc::post_bomb_main, undefined, scripts\sp\maps\piccadilly\piccadilly_infil.gsc::post_bomb_catchup);
  scripts\engine\sp\utility::add_start("combat", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::start, "", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_combat.gsc::catchup);
  scripts\engine\sp\utility::add_start("Lillywhites", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::start_lillywhites, "", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_combat.gsc::catchup);
  scripts\engine\sp\utility::add_start("Right Underground", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::start_right_underground, "", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_combat.gsc::catchup);
  scripts\engine\sp\utility::add_start("Sting", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::start_sting, "", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_combat.gsc::catchup);
  scripts\engine\sp\utility::add_start("Sting Rear", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::start_sting_rear, "", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::main, undefined, scripts\sp\maps\piccadilly\piccadilly_combat.gsc::catchup);
  scripts\engine\sp\utility::add_start("price_intro", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::price_spec_start, "", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::price_spec_main, undefined, scripts\sp\maps\piccadilly\piccadilly_gap.gsc::price_spec_catchup);
  scripts\engine\sp\utility::add_start("move_to_balcony", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::to_balcony_start, "", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::to_balcony_main, undefined, scripts\sp\maps\piccadilly\piccadilly_gap.gsc::to_balcony_catchup);
  scripts\engine\sp\utility::add_start("hostage", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::balcony_hostage_intro_start, "", scripts\sp\maps\piccadilly\piccadilly_gap.gsc::balcony_hostage_intro_main, undefined, scripts\sp\maps\piccadilly\piccadilly_gap.gsc::balcony_hostage_intro_catchup);
  scripts\engine\sp\utility::add_start("e3_audio", ::e3_audio_demo_start, "", ::e3_audio_demo);
  scripts\engine\sp\utility::set_default_start("infil");
  scripts\engine\sp\utility::offhandprecache(["frag"]);
  thread intro_screen();
  precachemodel("body_al_qatala_urban_ar_variants_2_1");
  precachemodel("head_sc_m_yurteri_civ_beard");
  precachemodel("hat_sc_m_yurteri_civ_beanie");
  scripts\sp\load::main();
  level.cos60 = cos(60);
  thread scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::init_script_car_collision();
  level thread scripts\sp\maps\piccadilly\piccadilly_civs.gsc::civ_init();
  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("MKNNNONLSK", 4);
  init_precache();
  init_flags();
  level.gotachievement = 1;
  level.player.animname = "player";
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::piccadilly_weapons();
  createthreatbiasgroup("kill_civs");
  createthreatbiasgroup("civilians");
  setthreatbias("kill_civs", "civilians", 9999999);
  setthreatbias("civilians", "kill_civs", 9999999);
  setignoremegroup("allies", "kill_civs");
  setignoremegroup("civilians", "axis");
  createthreatbiasgroup("sniper");
  createthreatbiasgroup("sniper_target");
  setthreatbias("sniper", "civilians", 999999);
  setthreatbias("sniper", "sniper_target", 999999);
  setignoremegroup("allies", "sniper");
  createthreatbiasgroup("player_focus");
  setthreatbias("axis", "player_focus", 999999);
  setthreatbias("sniper", "player_focus", 999999);
  level thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::raindrop_fx_manager();
  scripts\sp\maps\piccadilly\piccadilly_infil.gsc::infil_init();
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(getEntArray("gap_hidden", "targetname"), scripts\engine\sp\utility::hide_entity);
  scripts\engine\sp\utility::flagwaitthread("music_transition", scripts\sp\maps\piccadilly\piccadilly_util.gsc::music_transition);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", ::global_civ_spawn_func);
  scripts\engine\sp\utility::add_global_spawn_function("allies", ::inventoryweapon);
  scripts\engine\sp\utility::add_global_spawn_function("allies", ::makeallies);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::inventoryweapon);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::maketerrorists);
  level.spawned_suicide_bombers = 0;
  level.max_suicide_bombers = 2;
  level.suicide_bombers_alive = 0;
  scripts\engine\sp\utility::array_spawn_function_noteworthy("suicide_bomber", ::suicide_bomber_count);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("breadcrumb_guy", scripts\sp\maps\piccadilly\piccadilly_util.gsc::open_goalradius_on_player_sight);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("civ_killer", scripts\sp\maps\piccadilly\piccadilly_util.gsc::kill_civs_til_player_sees_me);
  scripts\engine\sp\utility::array_spawn_function_targetname("enemies_start", scripts\sp\maps\piccadilly\piccadilly_util.gsc::kill_civs_til_player_sees_me);
  scripts\engine\sp\utility::array_spawn_function_targetname("subway_right_wave1", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::right_kill_squad_logic);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("chase_player", scripts\sp\maps\piccadilly\piccadilly_combat.gsc::close_in_on_far_player);
  thread hide_combat_stuff();
  thread hide_clip_stuff();
  thread montior_player_fov();
  scripts\engine\utility::flag_set("init_done");
  thread always_on_exploders();
  level.special_autosavecondition = ::piccadilly_cansave;
  wait 0.2;
  thread ingame_cinematic_loop();
  thread display_ai();
  setdvarifuninitialized("scr_price_movement", 0);

  if(getdvarint("SMNRNLNRN")) {
    return;
  }
  thread gameplay_asset_adjustments();
  thread car_alarm_manager();
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::track_player_weapon_fire_time();
  getEnt("price_vehicle", "targetname") hide();
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

init_precache() {
  scripts\sp\maps\piccadilly\piccadilly_ambient.gsc::precache();
  precachemodel("police_london_high_vis_1");
  precachemodel("viewhands_fullbody_kyle_sas_urban");
  precachemodel("burntbody_male");
  precachemodel("viewhands_kyle_sas_urban");
  precachemodel("body_sas_urban_ar_rain");
  precachemodel("veh8_civ_lnd_victor40_police");
  precachemodel("veh8_civ_lnd_walfa_black");
  precacheitem("iw8_la_rpapa7");
  precachemodel("head_hero_price");
  precachemodel("hat_hero_price_boonie_withStrap");
  precachemodel("hat_hero_price_undercover_beanie");
  precachemodel("body_civ_london_male_bombvest");
  precachemodel("head_sc_m_johnson");
  precachemodel("hat_prisoner_hood");
  precachemodel("weapon_wm_me_soscar_knife");
  precachestring(&"PICCADILLY/ROE_FAIL");
  precachestring(&"STPETERSBURG/LEAVE_MISSION_AREA");
  precachestring(&"PICCADILLY/MOVE_DEBRIS");
}

init_flags() {
  scripts\engine\utility::flag_init("do_crash_van");
  scripts\engine\utility::flag_init("carroll_left_finished");
  scripts\engine\utility::flag_init("ally_setup_done");
  scripts\engine\utility::flag_init("init_done");
  scripts\engine\utility::flag_init("stop_civ_spawns");
  scripts\engine\utility::flag_init("gap_approach");
  scripts\engine\utility::flag_init("lb_exit");
  scripts\engine\utility::flag_init("spawn_gap_bomber");
  scripts\engine\utility::flag_init("car_jumper_done");
  scripts\engine\utility::flag_init("gap_bomber_dead");
  scripts\engine\utility::flag_init("spec_converge");
  scripts\engine\utility::flag_init("stop_far_cars");
  scripts\engine\utility::flag_init("stop_far_civs");
  scripts\engine\utility::flag_init("bus_rescue_over");
  scripts\engine\utility::flag_init("sting_window_guys_displace");
  scripts\engine\utility::flag_init("cancel_sting_rescue");
  scripts\engine\utility::flag_init("player_entered_reading_place");
  scripts\engine\utility::flag_init("snipers_engaged");
  scripts\engine\utility::flag_init("shooting_close_to_player");
  scripts\sp\maps\piccadilly\piccadilly_gap.gsc::gap_flags();
}

intro_screen() {
  scripts\engine\sp\utility::intro_screen_custom_func(::intro_screen_delay);
}

intro_screen_delay() {
  intro_screen_wait();
  scripts\sp\introscreen::introscreen(1);
}

intro_screen_wait() {
  level endon("intro_skipped");
  wait 15.5;
}

hide_combat_stuff() {
  var_0 = getEntArray("show_scriptables", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::trigger_show_scriptables);
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_1 = getscriptablearray("obj_frontline_cover", "targetname");
  thread hide_scriptables_til_flag(var_1, "stop_storefront_drones");
}

hide_clip_stuff() {
  var_0 = getEnt("temp_car_clip", "targetname");
  var_1 = getEnt("temp_car_clip2", "targetname");
  var_2 = getEnt("temp_car_clip3", "targetname");
  var_3 = getEnt("temp_car_clip4", "targetname");
  var_4 = getEnt("temp_car_clip5", "targetname");

  if(scripts\sp\starts::is_after_start("infil")) {
    var_0 delete();
    var_1 delete();
    var_2 delete();
    var_3 delete();
    var_4 delete();
  } else {
    scripts\engine\utility::flag_wait("boots_on_the_ground");
    var_0 scripts\engine\utility::delaycall(1.3, ::delete);
    var_1 scripts\engine\utility::delaycall(2.3, ::delete);
    var_2 scripts\engine\utility::delaycall(3.4, ::delete);
    var_3 scripts\engine\utility::delaycall(5.6, ::delete);
    var_4 scripts\engine\utility::delaycall(8.7, ::delete);
  }
}

break_glass_on_traverse() {
  self endon("death");
  self waittill("traverse_begin");
  var_0 = self getnegotiationstartnode();

  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  var_1 = getglass(var_0.script_noteworthy);

  if(!isDefined(var_1)) {
    return;
  }
  if(isglassdestroyed(var_1)) {
    return;
  }
  var_2 = self getnegotiationendnode();
  var_3 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 30), var_2.origin + (0, 0, 20), self, undefined, 1, 1);
  var_4 = var_3["position"];

  while(distance2dsquared(var_4, self.origin) > 2500)
    waitframe();

  if(!isglassdestroyed(var_1))
    destroyglass(var_1);
}

trigger_show_scriptables() {
  if(scripts\sp\starts::is_after_start("hostage")) {
    return;
  }
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray(self.target, "targetname");
  var_1 = scripts\engine\sp\utility::get_average_origin(var_0);

  foreach(var_3 in var_0)
  var_3 hide();

  scripts\engine\utility::flag_wait("stop_storefront_drones");

  foreach(var_3 in var_0)
  var_3 show();

  self delete();
}

hide_scriptables_til_flag(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3 hide();

  scripts\engine\utility::flag_wait(var_1);

  foreach(var_3 in var_0)
  var_3 show();
}

record_player_shoottime() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player.lastweaponfiredtime = gettime();
  }
}

always_on_exploders() {
  scripts\engine\utility::exploder("traffic_lights_intro");
  scripts\engine\utility::exploder("rain_amb");
  scripts\engine\utility::exploder("traffic_lights_02");
  scripts\engine\utility::exploder("fx_spotlights");
}

gameplay_asset_adjustments() {
  var_0 = getEnt("big_screen", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEnt("car_crash_node_clip", "targetname");
  var_1 scripts\engine\utility::delaythread(0.1, ::connect_and_delete);
  var_2 = getEnt("leftside_crash_clip", "targetname");
  var_2 scripts\engine\utility::delaythread(0.1, ::connect_and_delete);
  var_3 = getglassarray("sniper_glass");

  if(isDefined(var_3)) {
    foreach(var_5 in var_3)
    destroyglass(var_5);
  } else {}
}

e3_audio_demo_start() {
  scripts\sp\starts::start_nogame();
  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("MKNNNONLSK", 4);
  scripts\engine\utility::noself_delaycall(0.15, ::cinematicingameloop, "pic_screens_02", 1);
  scripts\engine\utility::exploder("traffic_lights_02");
  scripts\engine\utility::exploder("spec");
  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");

  foreach(var_1 in getEntArray("trigger_multiple_unlock", "classname"))
  var_1 delete();

  foreach(var_1 in getEntArray("trigger_multiple_spawn", "classname"))
  var_1 delete();
}

e3_audio_demo() {
  level.player setOrigin((-2042.41, -1102.64, -100.75));
  level.player setplayerangles((0, 47, 0));
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level waittill("forever");
}

infinite_ammo() {
  level.player endon("death");

  for(;;) {
    level.player givemaxammo("frag");
    var_0 = level.player getcurrentweapon();

    if(!nullweapon(var_0))
      level.player givemaxammo(var_0);

    wait 3;
  }
}

car_alarm_manager() {
  while(!isDefined(level.alarmcars))
    wait 0.1;

  while(!isDefined(level.alarmcars.cars))
    wait 0.1;

  wait 1;
  thread car_lights();

  foreach(var_1 in level.alarmcars.cars)
  var_1 notify("stop_alarm");
}

car_lights() {
  foreach(var_1 in level.rockablecars.cars) {
    if(isDefined(var_1.animname)) {
      continue;
    }
    if(var_1 getscriptableparthasstate("lights_controller", "on_nolight")) {
      var_1 setscriptablepartstate("lights_controller", "on_nolight");
      continue;
    }

    if(var_1 getscriptablehaspart("lights_controller"))
      var_1 setscriptablepartstate("lights_controller", "on");
  }
}

suicide_bomber_count() {
  if(level.spawned_suicide_bombers >= level.max_suicide_bombers) {
    if(!scripts\engine\utility::is_equal(self.targetname, "gap_bomber")) {
      self stopsounds();
      waitframe();
      self delete();
      return;
    }
  }

  self.attackeraccuracy = 0;
  thread record_suicide_bomber_death_or_deleted();
  level.suicide_bombers_alive++;
  level.spawned_suicide_bombers++;

  if(level.spawned_suicide_bombers == level.max_suicide_bombers) {
    var_0 = getEntArray("right_underground_bomber_trig", "script_noteworthy");

    if(var_0.size)
      scripts\engine\utility::array_call(var_0, ::delete);
  }

  createnavrepulsor("bomber " + self getentitynumber(), 0, self, 350, 1, "allies");
}

record_suicide_bomber_death_or_deleted() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::autosave_by_name, "suicide_death");
  level.suicide_bombers_alive--;
}

connect_and_delete() {
  self connectpaths();
  self delete();
}

piccadilly_cansave() {
  if(istrue(level.suicide_bombers_alive))
    return 0;

  return 1;
}

global_civ_spawn_func() {
  if(!scripts\engine\utility::flag("car2_detonation")) {
    return;
  }
  if(isDefined(self.global_spawn_func)) {
    return;
  }
  self.global_spawn_func = 1;
  self.dontmelee = 1;
  self.dontmeleeme = 1;
  self.doavoidanceblocking = 0;
  self.dosharpturnspeedscaling = 0;
  self.script_pushable = 0;
  self.fakeactor_face_anim = 1;
  self.ignoresuppression = 1;
  thread vo_civ_death();
  thread vo_civ_chatter();
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::acievement_monitor();

  if(isDefined(self.script_team))
    self.team = self.script_team;

  var_0 = ["run"];
  self.run_anim_alias = var_0[randomint(var_0.size)];
  thread scripts\sp\friendlyfire::friendly_fire_think(self);

  if(isai(self)) {
    scripts\asm\asm_bb::bb_setcivilianstate("panic");
    scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_random_civilian_speed());
    self.pathenemyfightdist = 0;
  }

  if(!isai(self) && !istrue(self.script_fakeactor) && !isDefined(self.anim_getrootfunc))
    self.anim_getrootfunc = ::get_anim_model_root;
}

vo_civ_chatter() {
  self endon("death");
  self endon("damage");
  level.player endon("death");
  self endon("stop_chatter");

  if(!isDefined(level.vo_chatter)) {
    return;
  }
  level.vo_chatter endon("terminate_chatter");
  scripts\engine\utility::call_on_notify("damage", ::stopsounds);
  var_0 = squared(300);
  var_1 = squared(400);
  var_2 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::get_gender();

  if(!isDefined(level.vo_civchatter))
    init_civchater_vo();

  var_3 = 10;
  var_4 = 60;

  if(var_2 == "female") {
    var_3 = 15;
    var_4 = 80;
  }

  for(;;) {
    var_5 = self.origin;
    var_6 = randomfloatrange(0.1, 0.3);
    wait(var_6);

    if(distance2dsquared(self.origin, var_5) / var_6 < 1000) {
      continue;
    }
    var_7 = level.vo_civchatter.wait_times.items[level.vo_civchatter.wait_times.index];

    if(!scripts\engine\utility::time_has_passed(level.vo_civchatter.last_said, var_7)) {
      continue;
    }
    var_8 = level.player.origin + anglesToForward(level.player.angles) * 60;
    var_9 = distance2dsquared(var_8, self.origin);

    if(var_9 > randomfloatrange(var_0, var_1)) {
      continue;
    }
    var_10 = int(var_9 / var_1 * (var_4 - var_3) + var_3);

    if(randomintrange(0, var_10) != 0 || istrue(self.dontchatter)) {
      continue;
    }
    var_11 = level.vo_civchatter.decks[var_2] scripts\engine\sp\utility::deck_draw();
    scripts\engine\utility::delaythread(1.5, ::vo_ally_warn_me);
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::say(var_11);
    level.vo_civchatter.last_said = gettime();
    level.vo_civchatter.wait_times scripts\engine\sp\utility::deck_draw();
    level.vo_civchatter.wait_times scripts\engine\sp\utility::refill_if_empty();
  }
}

init_help_responses() {
  if(isDefined(self.helpresponses)) {
    return;
  }
  if(!isai(self) || self.asmname == "civilian") {
    return;
  }
  var_0 = [];
  self.helpresponses = var_0;

  if(scripts\engine\utility::is_equal(self.animname, "sas1")) {
    var_0[var_0.size] = "dx_vom_s151_combat_civs_10";
    var_0[var_0.size] = "dx_vom_s151_combat_civs_20";
    var_0[var_0.size] = "dx_vom_s151_combat_civs_30";
    var_0[var_0.size] = "dx_vom_s151_combat_civs_40";
    self.helpresponses = scripts\engine\sp\utility::create_deck(var_0);
  } else if(scripts\engine\utility::is_equal(self.animname, "sas2") || scripts\engine\utility::is_equal(self.animname, "sas3")) {
    var_0[var_0.size] = "dx_vom_s152_combat_civs_50";
    var_0[var_0.size] = "dx_vom_s152_combat_civs_60";
    var_0[var_0.size] = "dx_vom_s152_combat_civs_70";
    var_0[var_0.size] = "dx_vom_s152_combat_civs_80";
    self.helpresponses = scripts\engine\sp\utility::create_deck(var_0);
  } else if(scripts\sp\maps\piccadilly\piccadilly_util.gsc::is_police()) {
    if(!isDefined(level.vo_chatter) || !isDefined(level.vo_chatter.police_helpresponses))
      init_police_helpresponses();

    self.helpresponses = level.vo_chatter.police_helpresponses[scripts\engine\utility::cointoss()];
  }
}

init_police_helpresponses() {
  if(!isDefined(level.vo_chatter))
    scripts\sp\maps\piccadilly\piccadilly_util.gsc::init_chatter();

  level.vo_chatter.police_helpresponses = [];
  var_0 = [];
  var_0[var_0.size] = "dx_vom_uk53_combat_civs_90";
  var_0[var_0.size] = "dx_vom_uk53_combat_civs_100";
  var_0[var_0.size] = "dx_vom_uk53_combat_civs_110";
  var_0[var_0.size] = "dx_vom_uk53_combat_civs_120";
  level.vo_chatter.police_helpresponses[0] = scripts\engine\sp\utility::create_deck(var_0);
  var_0[var_0.size] = "dx_vom_uk54_combat_civs_130";
  var_0[var_0.size] = "dx_vom_uk54_combat_civs_140";
  var_0[var_0.size] = "dx_vom_uk54_combat_civs_150";
  var_0[var_0.size] = "dx_vom_uk54_combat_civs_160";
  level.vo_chatter.police_helpresponses[1] = scripts\engine\sp\utility::create_deck(var_0);
}

vo_ally_warn_me() {
  var_0 = find_ally_to_respond();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.helpresponses))
    var_0 init_help_responses();

  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_as_chatter(var_0.helpresponses scripts\engine\sp\utility::deck_draw(), 0, 3);
}

find_ally_to_respond() {
  var_0 = getaiarrayinradius(level.player.origin, 500, "allies");

  if(var_0.size) {
    var_0 = sortbydistance(var_0, level.player.origin);

    foreach(var_2 in var_0) {
      if(var_2.asmname == "civilian" || var_2 isinscriptedstate()) {
        continue;
      }
      if(sighttracepassed(var_2 getEye(), self.origin + (0, 0, 65), 0, self, var_2))
        return var_2;
    }
  }

  return undefined;
}

vo_civ_death() {
  self waittill("death", var_0);

  if(!isDefined(var_0) || var_0 != level.player) {
    return;
  }
  if(!isDefined(level.vo_civkill))
    init_civkill_vo();

  wait 0.8;

  if(level.vo_civkill scripts\engine\sp\utility::deck_is_empty())
    level.vo_civkill scripts\sp\maps\piccadilly\piccadilly_util.gsc::array_deck_shuffle();

  if(isDefined(level.vo_civkill.last_said) && !scripts\engine\utility::time_has_passed(level.vo_civkill.last_said, 2)) {
    return;
  }
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::say_line_on_closest_ally(level.vo_civkill scripts\engine\sp\utility::deck_draw());
  level.vo_civkill.last_said = gettime();
}

init_civchater_vo() {
  level.vo_civchatter = spawnStruct();
  level.vo_civchatter.decks = [];
  var_0 = [];
  var_0[var_0.size] = "dx_vom_cvf1_post_bomb_civ_shooters_20";
  var_0[var_0.size] = "dx_vom_cvf1_post_bomb_civ_shooters_50";
  var_0[var_0.size] = "dx_vom_cvf1_post_bomb_civ_danger_20";
  var_0[var_0.size] = "dx_vom_cvf1_post_bomb_civ_danger_50";
  level.vo_civchatter.decks["female"] = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_cvm1_post_bomb_civ_shooters_10";
  var_0[var_0.size] = "dx_vom_cvm1_post_bomb_civ_shooters_40";
  var_0[var_0.size] = "dx_vom_cvm1_post_bomb_civ_danger_10";
  var_0[var_0.size] = "dx_vom_cvm1_post_bomb_civ_danger_40";
  var_0[var_0.size] = "dx_vom_cvm2_post_bomb_civ_shooters_30";
  var_0[var_0.size] = "dx_vom_cvm2_post_bomb_civ_shooters_60";
  var_0[var_0.size] = "dx_vom_cvm2_post_bomb_civ_danger_30";
  var_0[var_0.size] = "dx_vom_cvm2_post_bomb_civ_danger_60";
  level.vo_civchatter.decks["male"] = scripts\engine\sp\utility::create_deck(var_0);
  level.vo_civchatter.wait_times = scripts\engine\sp\utility::create_deck([0.3, 0.7, 3.3, 6.7]);
  level.vo_civchatter.last_said = gettime();
}

init_civkill_vo() {
  var_0 = ["dx_vom_uk53_post_bomb_civkill_10", "dx_vom_uk52_post_bomb_civkill_50", "dx_vom_s151_post_bomb_civkill_90", "dx_vom_s152_post_bomb_civkill_140"];
  var_1 = ["dx_vom_uk53_post_bomb_civkill_20", "dx_vom_uk52_post_bomb_civkill_60", "dx_vom_s151_post_bomb_civkill_100", "dx_vom_s152_post_bomb_civkill_150"];
  var_2 = ["dx_vom_uk53_post_bomb_civkill_30", "dx_vom_uk52_post_bomb_civkill_70", "dx_vom_s151_post_bomb_civkill_110", "dx_vom_s152_post_bomb_civkill_160"];
  var_3 = ["dx_vom_uk53_post_bomb_civkill_40", "dx_vom_uk52_post_bomb_civkill_80", "dx_vom_s151_post_bomb_civkill_120", "dx_vom_s152_post_bomb_civkill_170"];
  level.vo_civkill = scripts\engine\sp\utility::create_deck([var_0, var_1, var_2, var_3], 0);
  level.vo_civkill.autoshuffle = 1;
}

makeallies() {
  thread break_glass_on_traverse();
  self.maxfaceenemydist = 200;
  self.maxfacenewenemydist = 200;

  if(isai(self)) {
    setdvarifuninitialized("OLLLOORPLR", 170.0);

    if(self.unittype == "civilian") {
      var_0 = getdvarint("LSKTNKPTRT", 200);
      var_1 = getdvarint("MNMNLKRRQP", 240);

      if(var_1 <= var_0)
        var_1 = var_0 + 1;

      scripts\engine\utility::set_movement_speed(randomintrange(var_0, var_1));
    } else {
      var_0 = getdvarfloat("NNSQQNONNT", 0.94);
      var_1 = getdvarfloat("NNSQQNONNT", 1.11);

      if(var_1 <= var_0)
        var_1 = var_0 + 0.01;

      self.speedscalemult = randomfloatrange(var_0, var_1);
      scripts\common\utility::clear_movement_speed();
    }
  }
}

maketerrorists() {
  thread break_glass_on_traverse();
  thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::shadow_manager();
  self.maxfaceenemydist = 0;
  self.maxfacenewenemydist = 0;
  self.aggressiveblindfire = 1;
  self.grenadeammo = 0;

  if(isai(self)) {
    if(!istrue(self.casualkiller)) {
      var_0 = getdvarfloat("NSPNRRQRLN", 0.91);
      var_1 = getdvarfloat("NOPOKQNMR", 1.06);
      self.speedscalemult = randomfloatrange(var_0, var_1);
      self.allowspeedupwhencombathot = 0;
      scripts\common\ai::set_rebel(1);
    }
  }
}

print_screen_pos_from_center() {
  self endon("death");

  for(;;) {
    var_0 = level.player worldpointtoscreenpos(self gettagorigin("j_spinelower"), getdvarint("MRNKTKLLKP"));

    if(isDefined(var_0))
      var_1 = length2d(var_0);

    waitframe();
  }
}

inventoryweapon() {
  if(self.behaviortreeasset == "civilian") {
    thread global_civ_spawn_func();
    return;
  }

  if(!isDefined(level.loaded_weapons))
    level.loaded_weapons = [];

  if(isDefined(self) && !scripts\engine\utility::is_equal(self.weapon.basename, "none") && !scripts\engine\utility::array_contains(level.loaded_weapons, self.weapon.basename))
    level.loaded_weapons[level.loaded_weapons.size] = self.weapon.basename;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "keep_pistol")) {
    return;
  }
  if(self.team == "axis" && !nullweapon(self.weapon) && strtok(self.weapon.basename, "_")[1] != "sn")
    self.disablepistol = 1;
}

ingame_cinematic_loop() {
  scripts\engine\utility::flag_wait("intro_bink_done");
  setsaveddvar("MMRNLMPPLT", "0");
  scripts\engine\utility::noself_delaycall(0.15, ::cinematicingameloop, "pic_screens_02", 1);
  wait 0.15;
  scripts\engine\utility::exploder("screens_glow");
}

display_ai() {
  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);
  var_3 = ["axis", "allies", "team3", "neutral", "total"];

  for(;;) {
    var_4 = 30;

    foreach(var_6 in var_3) {
      if(var_6 == "total")
        var_7 = getaiarray().size;
      else
        var_7 = getaiarray(var_6).size;

      if(var_7 < 9)
        var_8 = var_1;
      else if(var_7 < 25)
        var_8 = var_0;
      else
        var_8 = var_2;

      var_4 = var_4 + 15;
    }

    waitframe();
  }
}

#using_animtree("scriptables");

open_bus_doors() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("combat_bus", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 useanimtree(#animtree);
    var_2 setanim(%piccadilly_london_bus_combat_doors_open);
  }
}

montior_player_fov() {
  level.player endon("death");

  for(;;) {
    level.player.currentfov = get_current_fov();

    if(getdvarint("scr_show_player_fov"))
      iprintln("Player FOV: " + level.player.currentfov);

    wait 0.15;
  }
}

get_current_fov() {
  var_0 = level.player getcurrentweapon();

  if(nullweapon(var_0) || level.player playerads() < 0.5)
    return getdvarint("MRNKTKLLKP");

  var_1 = undefined;
  var_2 = 0;

  if(isDefined(var_0.scope))
    var_1 = var_0.scope[0];

  var_3 = weaponclass(var_0);

  if(!isDefined(var_1) || var_1 == "i" || var_3 == "rocketlauncher" || var_3 == "grenade")
    var_2 = 1;

  if(var_2)
    return get_weapon_base_ads_fov(var_0);
  else
    return get_weapon_scope_fov(var_0);
}

get_weapon_base_ads_fov(var_0) {
  var_1 = weaponclass(var_0);

  switch (var_1) {
    case "mg":
    case "rifle":
      return 50;
    case "spread":
      return 58;
    case "pistol":
      return 60;
    case "grenade":
    case "rocketlauncher":
    case "smg":
      return 55;
    case "sniper":
      return 50;
    default:
      return getdvarint("MRNKTKLLKP");
  }
}

get_weapon_scope_fov(var_0) {
  var_1 = var_0.scope;

  if(weaponclass(var_0) == "sniper") {
    if(issubstr(var_1, "aco"))
      return 50;
    else if(issubstr(var_1, "e_alph"))
      return 12;
    else if(issubstr(var_1, "e_hd") || issubstr(var_1, "e_awh") || issubstr(var_1, "e_ind") || issubstr(var_1, "e_del"))
      return 15;
    else
      return 23;
  }

  if(issubstr(var_1, "aco"))
    return 29;

  if(issubstr(var_1, "hal"))
    return 40;

  if(issubstr(var_1, "ref"))
    return get_weapon_base_ads_fov(var_0);
}

#using_animtree("generic_human");

get_anim_model_root() {
  return % body;
}