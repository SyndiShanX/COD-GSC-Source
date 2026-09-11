/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly.gsc
*****************************************************/

function main() {
  scripts\sp\maps\piccadilly\gen\piccadilly_art::main();
  scripts\sp\maps\piccadilly\piccadilly_fx::main();
  scripts\sp\maps\piccadilly\piccadilly_anim::main();
  scripts\sp\maps\piccadilly\piccadilly_precache::main();
  scripts\sp\maps\piccadilly\piccadilly_lighting::main();
  scripts\sp\maps\piccadilly\piccadilly_lighting::setup_lighting();
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
  scripts\engine\sp\utility::add_start("infil", &scripts\sp\maps\piccadilly\piccadilly_infil::start, "", &scripts\sp\maps\piccadilly\piccadilly_infil::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_infil::catchup);
  scripts\engine\sp\utility::add_start("infil_car1", &scripts\sp\maps\piccadilly\piccadilly_infil::infil_car1_start, "", &scripts\sp\maps\piccadilly\piccadilly_infil::infil_car1_main, undefined, &scripts\sp\maps\piccadilly\piccadilly_infil::infil_car1_catchup);
  scripts\engine\sp\utility::add_start("post_bomb", &scripts\sp\maps\piccadilly\piccadilly_infil::post_bomb_start, "", &scripts\sp\maps\piccadilly\piccadilly_infil::post_bomb_main, undefined, &scripts\sp\maps\piccadilly\piccadilly_infil::post_bomb_catchup);
  scripts\engine\sp\utility::add_start("combat", &scripts\sp\maps\piccadilly\piccadilly_combat::start, "", &scripts\sp\maps\piccadilly\piccadilly_combat::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_combat::catchup);
  scripts\engine\sp\utility::add_start("Lillywhites", &scripts\sp\maps\piccadilly\piccadilly_combat::start_lillywhites, "", &scripts\sp\maps\piccadilly\piccadilly_combat::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_combat::catchup);
  scripts\engine\sp\utility::add_start("Right Underground", &scripts\sp\maps\piccadilly\piccadilly_combat::start_right_underground, "", &scripts\sp\maps\piccadilly\piccadilly_combat::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_combat::catchup);
  scripts\engine\sp\utility::add_start("Sting", &scripts\sp\maps\piccadilly\piccadilly_combat::start_sting, "", &scripts\sp\maps\piccadilly\piccadilly_combat::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_combat::catchup);
  scripts\engine\sp\utility::add_start("Sting Rear", &scripts\sp\maps\piccadilly\piccadilly_combat::start_sting_rear, "", &scripts\sp\maps\piccadilly\piccadilly_combat::main, undefined, &scripts\sp\maps\piccadilly\piccadilly_combat::catchup);
  scripts\engine\sp\utility::add_start("price_intro", &scripts\sp\maps\piccadilly\piccadilly_gap::price_spec_start, "", &scripts\sp\maps\piccadilly\piccadilly_gap::price_spec_main, undefined, &scripts\sp\maps\piccadilly\piccadilly_gap::price_spec_catchup);
  scripts\engine\sp\utility::add_start("move_to_balcony", &scripts\sp\maps\piccadilly\piccadilly_gap::to_balcony_start, "", &scripts\sp\maps\piccadilly\piccadilly_gap::to_balcony_main, undefined, &scripts\sp\maps\piccadilly\piccadilly_gap::to_balcony_catchup);
  scripts\engine\sp\utility::add_start("hostage", &scripts\sp\maps\piccadilly\piccadilly_gap::balcony_hostage_intro_start, "", &scripts\sp\maps\piccadilly\piccadilly_gap::balcony_hostage_intro_main, undefined, &scripts\sp\maps\piccadilly\piccadilly_gap::balcony_hostage_intro_catchup);
  scripts\engine\sp\utility::add_start("e3_audio", &e3_audio_demo_start, "", &e3_audio_demo);
  scripts\engine\sp\utility::set_default_start("infil");
  scripts\engine\sp\utility::offhandprecache(["frag"]);
  thread intro_screen();
  precachemodel("body_al_qatala_urban_ar_variants_2_1");
  precachemodel("head_sc_m_yurteri_civ_beard");
  precachemodel("hat_sc_m_yurteri_civ_beanie");
  scripts\sp\load::main();
  level.cos60 = cos(60);
  thread scripts\sp\maps\piccadilly\piccadilly_ambient::init_script_car_collision();
  level thread scripts\sp\maps\piccadilly\piccadilly_civs::civ_init();
  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("MKNNNONLSK", 4);
  init_precache();
  init_flags();
  level.gotachievement = 1;
  level.player.animname = "player";
  level thread scripts\sp\maps\piccadilly\piccadilly_util::piccadilly_weapons();
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
  level thread scripts\sp\maps\piccadilly\piccadilly_util::raindrop_fx_manager();
  scripts\sp\maps\piccadilly\piccadilly_infil::infil_init();
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), &scripts\engine\sp\utility::hide_entity);
  scripts\engine\utility::array_thread(getEntArray("gap_hidden", "targetname"), &scripts\engine\sp\utility::hide_entity);
  scripts\engine\sp\utility::flagwaitthread("music_transition", &scripts\sp\maps\piccadilly\piccadilly_util::music_transition);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", &global_civ_spawn_func);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &inventoryweapon);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &makeallies);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &inventoryweapon);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &maketerrorists);
  level.spawned_suicide_bombers = 0;
  level.max_suicide_bombers = 2;
  level.suicide_bombers_alive = 0;
  scripts\engine\sp\utility::array_spawn_function_noteworthy("suicide_bomber", &suicide_bomber_count);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("breadcrumb_guy", &scripts\sp\maps\piccadilly\piccadilly_util::open_goalradius_on_player_sight);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("civ_killer", &scripts\sp\maps\piccadilly\piccadilly_util::kill_civs_til_player_sees_me);
  scripts\engine\sp\utility::array_spawn_function_targetname("enemies_start", &scripts\sp\maps\piccadilly\piccadilly_util::kill_civs_til_player_sees_me);
  scripts\engine\sp\utility::array_spawn_function_targetname("subway_right_wave1", &scripts\sp\maps\piccadilly\piccadilly_combat::right_kill_squad_logic);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("chase_player", &scripts\sp\maps\piccadilly\piccadilly_combat::close_in_on_far_player);
  thread hide_combat_stuff();
  thread hide_clip_stuff();
  thread montior_player_fov();
  scripts\engine\utility::flag_set("init_done");
  thread always_on_exploders();
  level.special_autosavecondition = &piccadilly_cansave;
  wait 0.2;
  thread ingame_cinematic_loop();
  thread display_ai();
  setdvarifuninitialized("scr_price_movement", 0);

  if(getdvarint("SMNRNLNRN")) {
    return;
  }

  thread gameplay_asset_adjustments();
  thread car_alarm_manager();
  thread scripts\sp\maps\piccadilly\piccadilly_util::track_player_weapon_fire_time();
  getEnt("price_vehicle", "targetname") hide();
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

function init_precache() {
  scripts\sp\maps\piccadilly\piccadilly_ambient::precache();
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

function init_flags() {
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
  scripts\sp\maps\piccadilly\piccadilly_gap::gap_flags();
}

function intro_screen() {
  scripts\engine\sp\utility::intro_screen_custom_func(&intro_screen_delay);
}

function intro_screen_delay() {
  intro_screen_wait();
  scripts\sp\introscreen::introscreen(1);
}

function intro_screen_wait() {
  level endon("intro_skipped");
  wait 15.5;
}

function hide_combat_stuff() {
  var0 = getEntArray("show_scriptables", "script_noteworthy");
  scripts\engine\utility::array_thread(var0, &trigger_show_scriptables);
  scripts\engine\utility::flag_wait("scriptables_ready");
  var1 = getscriptablearray("obj_frontline_cover", "targetname");
  thread hide_scriptables_til_flag(var1, "stop_storefront_drones");
}

function hide_clip_stuff() {
  var0 = getEnt("temp_car_clip", "targetname");
  var1 = getEnt("temp_car_clip2", "targetname");
  var2 = getEnt("temp_car_clip3", "targetname");
  var3 = getEnt("temp_car_clip4", "targetname");
  var4 = getEnt("temp_car_clip5", "targetname");

  if(scripts\sp\starts::is_after_start("infil")) {
    var0 delete();
    var1 delete();
    var2 delete();
    var3 delete();
    var4 delete();
    return;
  }

  scripts\engine\utility::flag_wait("boots_on_the_ground");
  var0 scripts\engine\utility::delaycall(1.3, &delete);
  var1 scripts\engine\utility::delaycall(2.3, &delete);
  var2 scripts\engine\utility::delaycall(3.4, &delete);
  var3 scripts\engine\utility::delaycall(5.6, &delete);
  var4 scripts\engine\utility::delaycall(8.7, &delete);
}

function break_glass_on_traverse() {
  self endon("death");
  self waittill("traverse_begin");
  var0 = self getnegotiationstartnode();

  if(!isDefined(var0.script_noteworthy)) {
    return;
  }

  var1 = getglass(var0.script_noteworthy);

  if(!isDefined(var1)) {
    return;
  }

  if(isglassdestroyed(var1)) {
    return;
  }

  var2 = self getnegotiationendnode();
  var3 = scripts\engine\trace::ray_trace(var0.origin + (0, 0, 30), var2.origin + (0, 0, 20), self, undefined, 1, 1);
  var4 = var3["position"];

  while(distance2dsquared(var4, self.origin) > 2500) {
    waitframe();
  }

  if(!isglassdestroyed(var1)) {
    destroyglass(var1);
    return;
  }
}

function trigger_show_scriptables() {
  if(scripts\sp\starts::is_after_start("hostage")) {
    return;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray(self.target, "targetname");
  var1 = scripts\engine\sp\utility::get_average_origin(var0);

  foreach(var3 in var0) {
    var3 hide();
  }

  scripts\engine\utility::flag_wait("stop_storefront_drones");

  foreach(var3 in var0) {
    var3 show();
  }

  self delete();
}

function hide_scriptables_til_flag(var0, var1) {
  foreach(var3 in var0) {
    var3 hide();
  }

  scripts\engine\utility::flag_wait(var1);

  foreach(var3 in var0) {
    var3 show();
  }
}

function record_player_shoottime() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");
    level.player.lastweaponfiredtime = gettime();
  }
}

function always_on_exploders() {
  scripts\engine\utility::exploder("traffic_lights_intro");
  scripts\engine\utility::exploder("rain_amb");
  scripts\engine\utility::exploder("traffic_lights_02");
  scripts\engine\utility::exploder("fx_spotlights");
}

function gameplay_asset_adjustments() {
  var0 = getEnt("big_screen", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  var1 = getEnt("car_crash_node_clip", "targetname");
  var1 scripts\engine\utility::delaythread(0.1, &connect_and_delete);
  var2 = getEnt("leftside_crash_clip", "targetname");
  var2 scripts\engine\utility::delaythread(0.1, &connect_and_delete);
  var3 = getglassarray("sniper_glass");

  if(isDefined(var3)) {
    foreach(var5 in var3) {
      destroyglass(var5);
    }

    return;
  }
}

function e3_audio_demo_start() {
  scripts\sp\starts::start_nogame();
  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("MKNNNONLSK", 4);
  scripts\engine\utility::noself_delaycall(0.15, &cinematicingameloop, "pic_screens_02", 1);
  scripts\engine\utility::exploder("traffic_lights_02");
  scripts\engine\utility::exploder("spec");
  level.player setshadowmodel("default_character_shadow");
  level.player setviewmodel("viewhands_kyle_sas_urban");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");

  foreach(var1 in getEntArray("trigger_multiple_unlock", "classname")) {
    var1 delete();
  }

  foreach(var1 in getEntArray("trigger_multiple_spawn", "classname")) {
    var1 delete();
  }
}

function e3_audio_demo() {
  level.player setOrigin((-2042.41, -1102.64, -100.75));
  level.player setplayerangles((0, 47, 0));
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level waittill("forever");
}

function infinite_ammo() {
  level.player endon("death");

  for(;;) {
    level.player givemaxammo("frag");
    var0 = level.player getcurrentweapon();

    if(!nullweapon(var0)) {
      level.player givemaxammo(var0);
    }

    wait 3;
  }
}

function car_alarm_manager() {
  while(!isDefined(level.alarmcars)) {
    wait 0.1;
  }

  while(!isDefined(level.alarmcars.cars)) {
    wait 0.1;
  }

  wait 1;
  thread car_lights();

  foreach(var1 in level.alarmcars.cars) {
    var1 notify("stop_alarm");
  }
}

function car_lights() {
  foreach(var1 in level.rockablecars.cars) {
    if(isDefined(var1.animname)) {
      continue;
    }

    if(var1 getscriptableparthasstate("lights_controller", "on_nolight")) {
      var1 setscriptablepartstate("lights_controller", "on_nolight");
      continue;
    }

    if(var1 getscriptablehaspart("lights_controller")) {
      var1 setscriptablepartstate("lights_controller", "on");
    }
  }
}

function suicide_bomber_count() {
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
    var0 = getEntArray("right_underground_bomber_trig", "script_noteworthy");

    if(var0.size) {
      scripts\engine\utility::array_call(var0, &delete);
    }
  }

  createnavrepulsor("bomber " + self getentitynumber(), 0, self, 350, 1, "allies");
}

function record_suicide_bomber_death_or_deleted() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::autosave_by_name, "suicide_death");
  level.suicide_bombers_alive--;
}

function connect_and_delete() {
  self connectpaths();
  self delete();
}

function piccadilly_cansave() {
  if(istrue(level.suicide_bombers_alive)) {
    return false;
  }

  return true;
}

function global_civ_spawn_func() {
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
  thread scripts\sp\maps\piccadilly\piccadilly_util::acievement_monitor();

  if(isDefined(self.script_team)) {
    self.team = self.script_team;
  }

  var0 = ["run"];
  self.run_anim_alias = var0[randomint(var0.size)];
  thread scripts\sp\friendlyfire::friendly_fire_think(self);

  if(isai(self)) {
    scripts\asm\asm_bb::bb_setcivilianstate("panic");
    scripts\engine\utility::set_movement_speed(scripts\sp\maps\piccadilly\piccadilly_util::get_random_civilian_speed());
    self.pathenemyfightdist = 0;
  }

  if(!isai(self) && !istrue(self.script_fakeactor) && !isDefined(self.anim_getrootfunc)) {
    self.anim_getrootfunc = &get_anim_model_root;
    return;
  }
}

function vo_civ_chatter() {
  self endon("death");
  self endon("damage");
  level.player endon("death");
  self endon("stop_chatter");

  if(!isDefined(level.vo_chatter)) {
    return;
  }

  level.vo_chatter endon("terminate_chatter");
  scripts\engine\utility::call_on_notify("damage", &stopsounds);
  var0 = squared(300);
  var1 = squared(400);
  var2 = scripts\sp\maps\piccadilly\piccadilly_util::get_gender();

  if(!isDefined(level.vo_civchatter)) {
    init_civchater_vo();
  }

  var3 = 10;
  var4 = 60;
  jumpiffalse(var2 == "female") LOC_00000081;
  var3 = 15;
  var4 = 80;

  for(;;) {
    var5 = self.origin;
    var6 = randomfloatrange(0.1, 0.3);
    wait var6;

    if(distance2dsquared(self.origin, var5) / var6 < 1000) {
      continue;
    }

    var7 = level.vo_civchatter.wait_times.items[level.vo_civchatter.wait_times.index];

    if(!scripts\engine\utility::time_has_passed(level.vo_civchatter.last_said, var7)) {
      continue;
    }

    var8 = level.player.origin + anglesToForward(level.player.angles) * 60;
    var9 = distance2dsquared(var8, self.origin);

    if(var9 > randomfloatrange(var0, var1)) {
      continue;
    }

    var10 = int(var9 / var1 * (var4 - var3) + var3);

    if(randomintrange(0, var10) != 0 || istrue(self.dontchatter)) {
      continue;
    }

    var11 = level.vo_civchatter.decks[var2] scripts\engine\sp\utility::deck_draw();
    scripts\engine\utility::delaythread(1.5, &vo_ally_warn_me);
    scripts\sp\maps\piccadilly\piccadilly_util::say(var11);
    level.vo_civchatter.last_said = gettime();
    level.vo_civchatter.wait_times scripts\engine\sp\utility::deck_draw();
    level.vo_civchatter.wait_times scripts\engine\sp\utility::refill_if_empty();
  }
}

function init_help_responses() {
  if(isDefined(self.helpresponses)) {
    return;
  }

  if(!isai(self) || self.asmname == "civilian") {
    return;
  }

  var0 = [];
  self.helpresponses = var0;

  if(scripts\engine\utility::is_equal(self.animname, "sas1")) {
    GscBinSkip0(0x2e, var0.size, "dx_vom_s151_combat_civs_10");
  }

  if(scripts\engine\utility::is_equal(self.animname, "sas2") || scripts\engine\utility::is_equal(self.animname, "sas3")) {
    GscBinSkip0(0x2e, var0.size, "dx_vom_s152_combat_civs_50");
  }

  if(scripts\sp\maps\piccadilly\piccadilly_util::is_police()) {
    if(!isDefined(level.vo_chatter) || !isDefined(level.vo_chatter.police_helpresponses)) {
      init_police_helpresponses();
    }

    self.helpresponses = level.vo_chatter.police_helpresponses[scripts\engine\utility::cointoss()];
  }
}

function init_police_helpresponses() {
  if(!isDefined(level.vo_chatter)) {
    scripts\sp\maps\piccadilly\piccadilly_util::init_chatter();
  }

  level.vo_chatter.police_helpresponses = [];
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uk53_combat_civs_90");
}

function vo_ally_warn_me() {
  var0 = find_ally_to_respond();

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.helpresponses)) {
    init_help_responses(var0);
  }

  var0 thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter(var0.helpresponses scripts\engine\sp\utility::deck_draw(), 0, 3);
}

function find_ally_to_respond() {
  var0 = getaiarrayinradius(level.player.origin, 500, "allies");

  if(var0.size) {
    var0 = sortbydistance(var0, level.player.origin);

    foreach(var2 in var0) {
      if(var2.asmname == "civilian" || var2 isinscriptedstate()) {
        continue;
      }

      if(sighttracepassed(var2 getEye(), self.origin + (0, 0, 65), 0, self, var2)) {
        return var2;
      }
    }
  }

  return undefined;
}

function vo_civ_death() {
  self waittill("death", var0);

  if(!isDefined(var0) || var0 != level.player) {
    return;
  }

  if(!isDefined(level.vo_civkill)) {
    init_civkill_vo();
  }

  wait 0.8;

  if(level.vo_civkill scripts\engine\sp\utility::deck_is_empty()) {
    level.vo_civkill scripts\sp\maps\piccadilly\piccadilly_util::array_deck_shuffle();
  }

  if(isDefined(level.vo_civkill.last_said) && !scripts\engine\utility::time_has_passed(level.vo_civkill.last_said, 2)) {
    return;
  }

  scripts\sp\maps\piccadilly\piccadilly_util::say_line_on_closest_ally(level.vo_civkill scripts\engine\sp\utility::deck_draw());
  level.vo_civkill.last_said = gettime();
}

function init_civchater_vo() {
  level.vo_civchatter = spawnStruct();
  level.vo_civchatter.decks = [];
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_cvf1_post_bomb_civ_shooters_20");
}

function init_civkill_vo() {
  var0 = ["dx_vom_uk53_post_bomb_civkill_10", "dx_vom_uk52_post_bomb_civkill_50", "dx_vom_s151_post_bomb_civkill_90", "dx_vom_s152_post_bomb_civkill_140"];
  var1 = ["dx_vom_uk53_post_bomb_civkill_20", "dx_vom_uk52_post_bomb_civkill_60", "dx_vom_s151_post_bomb_civkill_100", "dx_vom_s152_post_bomb_civkill_150"];
  var2 = ["dx_vom_uk53_post_bomb_civkill_30", "dx_vom_uk52_post_bomb_civkill_70", "dx_vom_s151_post_bomb_civkill_110", "dx_vom_s152_post_bomb_civkill_160"];
  var3 = ["dx_vom_uk53_post_bomb_civkill_40", "dx_vom_uk52_post_bomb_civkill_80", "dx_vom_s151_post_bomb_civkill_120", "dx_vom_s152_post_bomb_civkill_170"];
  level.vo_civkill = scripts\engine\sp\utility::create_deck([var0, var1, var2, var3], 0);
  level.vo_civkill.autoshuffle = 1;
}

function makeallies() {
  thread break_glass_on_traverse();
  self.maxfaceenemydist = 200;
  self.maxfacenewenemydist = 200;

  if(isai(self)) {
    setdvarifuninitialized("OLLLOORPLR", 170);

    if(self.unittype == "civilian") {
      var0 = getdvarint("LSKTNKPTRT", 200);
      var1 = getdvarint("MNMNLKRRQP", 240);

      if(var1 <= var0) {
        var1 = var0 + 1;
      }

      scripts\engine\utility::set_movement_speed(randomintrange(var0, var1));
      return;
    }

    var0 = getdvarfloat("NNSQQNONNT", 0.94);
    var1 = getdvarfloat("NNSQQNONNT", 1.11);

    if(var1 <= var0) {
      var1 = var0 + 0.01;
    }

    self.speedscalemult = randomfloatrange(var0, var1);
    scripts\common\utility::clear_movement_speed();
    return;
  }
}

function maketerrorists() {
  thread break_glass_on_traverse();
  thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  self.maxfaceenemydist = 0;
  self.maxfacenewenemydist = 0;
  self.aggressiveblindfire = 1;
  self.grenadeammo = 0;

  if(isai(self)) {
    if(!istrue(self.casualkiller)) {
      var0 = getdvarfloat("NSPNRRQRLN", 0.91);
      var1 = getdvarfloat("NOPOKQNMR", 1.06);
      self.speedscalemult = randomfloatrange(var0, var1);
      self.allowspeedupwhencombathot = 0;
      scripts\common\ai::set_rebel(1);
      return;
    }

    return;
  }
}

function print_screen_pos_from_center() {
  self endon("death");

  for(;;) {
    var0 = level.player worldpointtoscreenpos(self gettagorigin("j_spinelower"), getdvarint("MRNKTKLLKP"));

    if(isDefined(var0)) {
      var1 = length2d(var0);
    }

    waitframe();
  }
}

function inventoryweapon() {
  if(self.behaviortreeasset == "civilian") {
    thread global_civ_spawn_func();
    return;
  }

  if(!isDefined(level.loaded_weapons)) {
    level.loaded_weapons = [];
  }

  if(isDefined(self) && !scripts\engine\utility::is_equal(self.weapon.basename, "none") && !scripts\engine\utility::array_contains(level.loaded_weapons, self.weapon.basename)) {
    level.loaded_weapons[level.loaded_weapons.size] = self.weapon.basename;
  }

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "keep_pistol")) {
    return;
  }

  if(self.team == "axis" && !nullweapon(self.weapon) && strtok(self.weapon.basename, "_")[1] != "sn") {
    self.disablepistol = 1;
    return;
  }
}

function ingame_cinematic_loop() {
  scripts\engine\utility::flag_wait("intro_bink_done");
  setsaveddvar("MMRNLMPPLT", "0");
  scripts\engine\utility::noself_delaycall(0.15, &cinematicingameloop, "pic_screens_02", 1);
  wait 0.15;
  scripts\engine\utility::exploder("screens_glow");
}

function display_ai() {
  var0 = (1, 1, 0);
  var1 = (0, 1, 0);
  var2 = (1, 0, 0);
  var3 = ["axis", "allies", "team3", "neutral", "total"];

  for(;;) {
    var4 = 30;

    foreach(var6 in var3) {
      if(var6 == "total") {
        var7 = getaiarray().size;
      } else {
        var7 = getaiarray(var6).size;
      }

      if(var7 < 9) {
        var8 = var1;
      } else if(var7 < 25) {
        var8 = var0;
      } else {
        var8 = var2;
      }

      var4 += 15;
    }

    waitframe();
  }
}

#using_animtree("");

function open_bus_doors() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("combat_bus", "script_noteworthy");

  foreach(var2 in var0) {
    var2 useanimtree(#animtree);
    var2 setanim($piccadilly_london_bus_combat_doors_open);
  }
}

function montior_player_fov() {
  level.player endon("death");

  for(;;) {
    level.player.currentfov = get_current_fov();

    if(getdvarint("scr_show_player_fov")) {
      iprintln("Player FOV: " + level.player.currentfov);
    }

    wait 0.15;
  }
}

function get_current_fov() {
  var0 = level.player getcurrentweapon();

  if(nullweapon(var0) || level.player playerads() < 0.5) {
    return getdvarint("MRNKTKLLKP");
  }

  var1 = undefined;
  var2 = 0;

  if(isDefined(var0.scope)) {
    var1 = var0.scope[0];
  }

  var3 = weaponclass(var0);

  if(!isDefined(var1) || var1 == "i" || var3 == "rocketlauncher" || var3 == "grenade") {
    var2 = 1;
  }

  if(var2) {
    return get_weapon_base_ads_fov(var0);
  }

  return get_weapon_scope_fov(var0);
}

function get_weapon_base_ads_fov(var0) {
  var1 = weaponclass(var0);

  switch (var1) {
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

function get_weapon_scope_fov(var0) {
  var1 = var0.scope;

  if(weaponclass(var0) == "sniper") {
    if(issubstr(var1, "aco")) {
      return 50;
    } else if(issubstr(var1, "e_alph")) {
      return 12;
    } else if(issubstr(var1, "e_hd") || issubstr(var1, "e_awh") || issubstr(var1, "e_ind") || issubstr(var1, "e_del")) {
      return 15;
    } else {
      return 23;
    }
  }

  if(issubstr(var1, "aco")) {
    return 29;
  }

  if(issubstr(var1, "hal")) {
    return 40;
  }

  if(issubstr(var1, "ref")) {
    return get_weapon_base_ads_fov(var0);
  }
}

#using_animtree("generic_human");

function get_anim_model_root() {
  return % body;
}