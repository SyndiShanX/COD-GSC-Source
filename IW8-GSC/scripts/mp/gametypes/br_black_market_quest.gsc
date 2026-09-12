/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_black_market_quest.gsc
**********************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("black_market", 1);

  if(!var_0) {
    return;
  }

  level.black_market_quest = spawnStruct();
  init_dvars();
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("black_market", &on_remove_quest_instance);
  scripts\mp\gametypes\br_quest_util::registeronplayerkilled("black_market", &ref_11FF1);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("black_market", &on_player_disconnect);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("black_market", &on_enter_gulag);
  scripts\mp\gametypes\br_quest_util::ref_12B30("black_market", &on_respawn);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("black_market", &on_circle_tick);
  scripts\mp\gametypes\br_quest_util::ref_1297C("black_market", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("black_market", &on_timer_expired);
  thread contract_cleanup_watcher();
  game["dialog"]["mission_blm_accept"] = "mission_mission_gen_accept";
  game["dialog"]["mission_blm_dropnotify"] = "blkmrkt_contract_contract_start";
  game["dialog"]["mission_blm_success"] = "blkmrkt_contract_contract_complete";
  game["dialog"]["mission_blm_fail"] = "blkmrkt_contract_contract_fail";
  game["dialog"]["mission_blm_timer_warn"] = "blkmrkt_contract_timer_remaining";
  game["dialog"]["mission_blm_kiosk_nearby"] = "blkmrkt_contract_buy_station_proximity";
  scripts\engine\scriptable::ref_12F5B("br_black_market_kiosk", &kiosk_on_use);
  scripts\mp\utility\sound::besttime("br_event_black_market");
}

function init_dvars() {
  level.black_market_quest.i_quest_time = getdvarint("scr_br_black_market_quest_time", 120);
  level.black_market_quest.i_circle_index_to_hide = getdvarint("scr_br_black_market_circle_index_to_hide", 4);
  level.black_market_quest.f_quest_circle_delay = getdvarfloat("scr_br_black_market_quest_circle_delay", 1.5);
  level.black_market_quest.i_drop_notify_radius = getdvarint("scr_br_black_market_drop_notify_radius", 10000);
  level.black_market_quest.i_kiosk_destroy_timeout = getdvarint("scr_br_black_market_kiosk_destroy_timeout", 120);
  level.black_market_quest.i_quest_circle_start_radius = getdvarint("scr_br_black_market_quest_circle_start_radius", 4000);
  level.black_market_quest.i_quest_circle_end_radius = getdvarint("scr_br_black_market_quest_circle_end_radius", 500);
  level.black_market_quest.i_quest_circle_steps = getdvarint("scr_br_black_market_quest_circle_steps", 3);
  level.black_market_quest.i_audio_ping_interval = getdvarfloat("scr_br_black_market_audio_ping_interval", 2);
  level.black_market_quest.f_audio_echo_min_interval = getdvarfloat("scr_br_black_market_audio_echo_min_interval", 0.1);
  level.black_market_quest.f_audio_echo_max_interval = getdvarfloat("scr_br_black_market_audio_echo_max_interval", 0.9);
  level.black_market_quest.f_audio_echo_min_range = getdvarfloat("scr_br_black_market_audio_echo_min_range", 100);
  level.black_market_quest.f_audio_echo_max_range = getdvarfloat("scr_br_black_market_audio_echo_max_range", 5000);
  level.black_market_quest.i_kiosk_activation_radius = getdvarint("scr_br_black_market_kiosk_activation_radius", 250);
  level.black_market_quest.b_audio_ping_enabled = getdvarint("scr_br_black_market_audio_ping_enabled", 1);
  level.black_market_quest.b_circle_shrinking_enabled = getdvarint("scr_br_black_market_circle_shrinking_enabled", 1);
  level.black_market_quest.i_max_spawn_distance_sqr = squared(getdvarint("scr_br_black_market_max_spawn_distance", 10000));
  level.black_market_quest.i_min_spawn_distance_sqr = squared(getdvarint("scr_br_black_market_min_spawn_distance", 4000));
  level.black_market_quest.i_kiosk_max_lifetime = level.black_market_quest.i_quest_time + level.black_market_quest.i_kiosk_destroy_timeout;
}

function is_enabled() {
  return scripts\mp\gametypes\br_quest_util::upload_station_players_manager("black_market", 1);
}

function __quest_state() {}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("black_market", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_1.semtex_stuckplayer = self;
  var_1.team = self.team;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  hud_setup_visibility(var_1);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297D(level.black_market_quest.i_quest_time, 4);
  thread play_time_warning_dialog(var_1);
  scripts\mp\gametypes\br_quest_util::addquestinstance("black_market", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("black_market", self, self.team);
  var_2 = spawnStruct();
  var_2.excludedplayers = [];
  var_2.excludedplayers[0] = var_1.semtex_stuckplayer;
  var_2.ogangles = [];
  var_2.ogangles[0] = var_1.team;
  var_2.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("black_market", scripts\mp\gametypes\br_quest_util::ringing(self.team));
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1.team, "br_black_market_start_team", var_2);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_1.semtex_stuckplayer, "br_black_market_start_tablet_finder", var_2);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_blm_accept", var_1.team, var_1.semtex_stuckplayer, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_blm_accept", var_1.semtex_stuckplayer, 1, 0.5);
  thread kiosk_spawn();
}

function handle_fail_quest(var_0) {
  switch (var_0) {
    case 2:
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_black_market_circle_failure");
      break;
    case 1:
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_black_market_timer_expired");
      break;
    default:
      scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_black_market_failure");
      break;
  }

  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_blm_fail", self.team, 1, 1);

  if(isDefined(self.kiosk)) {
    kiosk_destroy(self.kiosk);
    return;
  }
}

function complete_quest() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::getquestindex("black_market");
  var_3 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("black_market"));
  var_4 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(self.semtex_stuckplayer);
  var_0.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_2, var_1, var_3, undefined, var_4);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_black_market_complete", var_0);
  level thread scripts\mp\gametypes\br_public::dmztutdropcash("mission_blm_success", self.team, self.semtex_stuckplayer, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("mission_blm_success", self.semtex_stuckplayer, 1, 0, 0.5);
  self.kiosk setscriptablepartstate("br_black_market_kiosk", "opening");
  thread kiosk_destroy_after_delay();
  self.kiosk.quest = undefined;

  foreach(var_6 in level.players) {
    self.kiosk enablescriptableplayeruse(var_6);
  }

  self.ref_12D2D = undefined;
  self.ref_12D2E = self.semtex_stuckplayer.origin;
  self.ref_12D2B = self.semtex_stuckplayer.angles;
  self.result = "success";
  thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function kiosk_distance_watcher() {
  level endon("game_ended");
  self endon("marked_to_remove");
  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1 = squared(level.black_market_quest.i_kiosk_activation_radius);
  var_2 = squared(level.black_market_quest.i_quest_circle_start_radius);

  for(;;) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4) || !isalive(var_4)) {
        continue;
      }

      var_5 = distancesquared(var_4.origin, self.kiosk.origin);

      if(var_5 < var_1) {
        var_6 = var_4 getEye();
        var_7 = self.kiosk.origin + (0, 0, 32);
        var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
        var_9 = [self.kiosk, var_4];
        var_10 = physics_raycast(var_6, var_7, var_8, var_9, 0, "physicsquery_closest", 1);

        if(!(isDefined(var_10) && var_10.size > 0)) {
          show_kiosk();
          complete_quest();
        }

        waitframe();
      }
    }

    if(!self.kiosk_found && level.black_market_quest.b_circle_shrinking_enabled) {
      var_12 = var_2;

      foreach(var_4 in var_0) {
        var_12 = min(distance2dsquared(var_4.origin, self.v_next_circle), var_12);
      }

      if(var_12 < self.i_next_circle_distance) {
        quest_circle_tick();
      }
    }

    wait 1;
  }
}

function show_kiosk() {
  if(self.kiosk_found) {
    return;
  }

  self.kiosk_found = 1;
  self notify("kiosk_found");
  thread quest_circle_animate([self.i_circle_step - 1], self.kiosk.origin, 2, 1);
  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_2 in var_0) {
    var_2 playlocalsound("br_black_market_chest_discovered");
  }

  objective_state(self.ref_11F64, "current");
  objective_setshowoncompass(self.ref_11F64, 0);
  playencryptedcinematicforall(self.ref_11F64, 0);
  function_0442(self.ref_11F64, 0);
  objective_setshowdistance(self.ref_11F64, 1);
}

function play_time_warning_dialog(var_0) {
  level endon("game_ended");
  self endon("marked_to_remove");
  var_1 = max(level.black_market_quest.i_quest_time - var_0, 0);
  wait var_1;
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_blm_timer_warn", self.team, 1, 1);
}

function contract_cleanup_watcher() {
  level endon("game_ended");

  for(;;) {
    level waittill("br_circle_set", var_0);

    if(var_0 >= level.black_market_quest.i_circle_index_to_hide) {
      var_1 = getlootscriptablearrayinradius(scripts\mp\gametypes\br_quest_util::removepatchablecollision_delayed("black_market"));

      foreach(var_3 in var_1) {
        var_3.invalidforreplace = 1;
        scripts\mp\gametypes\br_pickups::ref_11A21(var_3);
      }
    }
  }
}

function __hud() {}

function hud_setup_visibility() {
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(scripts\mp\utility\teams::getteamdata(self.team, "players"));

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("black_market");
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  }
}

function hud_show_to_player(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("black_market");
}

function hud_hide_from_player(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function hud_delete() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    hud_hide_from_player(var_1);
  }
}

function __event_handlers() {}

function on_remove_quest_instance() {
  hud_delete();
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.ref_11F64);

  if(isDefined(self.mapcircle)) {
    scripts\mp\gametypes\br_quest_util::lastdirtyscore();
  }

  if(isDefined(self.obj_icon_mover)) {
    self.obj_icon_mover delete();
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_11FF1(var_0, var_1) {
  on_player_removed(var_1, var_0);
}

function on_player_disconnect(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("black_market", self.team).playerlist = var_1;

    if(isDefined(self.kiosk) && var_1.size) {
      self.kiosk setotherent(var_1[0]);
    }

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
    }
  }

  on_player_removed(var_0);
}

function on_enter_gulag(var_0) {
  hud_hide_from_player(var_0);
  scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_0);
}

function on_respawn(var_0) {
  if(var_0.team == self.team) {
    hud_show_to_player(var_0);
    scripts\mp\gametypes\br_quest_util::ref_1336A(var_0);
    start_player_threads(var_0);
    return;
  }
}

function on_player_removed(var_0, var_1) {}

function on_timer_expired() {
  handle_fail_quest(1);
}

function on_circle_tick(var_0, var_1) {
  if(scripts\mp\gametypes\br_circle::getsafecircleradius() > 0) {
    var_2 = squared(scripts\mp\gametypes\br_circle::getdangercircleradius());

    if(!isDefined(self.lastcircletick)) {
      self.lastcircletick = -1;
    }

    var_3 = gettime();

    if(self.lastcircletick == var_3) {
      return;
    }

    self.lastcircletick = var_3;

    if(isDefined(self.kiosk)) {
      var_4 = distance2dsquared(self.kiosk.origin, var_0);

      if(var_4 > var_2) {
        handle_fail_quest(2);
        self.result = "fail";
        scripts\mp\gametypes\br_quest_util::removequestinstance();
        return;
      }

      return;
    }

    return;
  }
}

function __drop_logic() {}

function find_kiosk_spawn_location(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in level.black_market_quest.wait_display_pavelow_boss_health_bar) {
    if(!istrue(var_5.available) || !scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_5.origin, 1, level.black_market_quest.i_quest_time)) {
      continue;
    }

    var_6 = distance2dsquared(var_0, var_5.origin);

    if(!isDefined(var_2) || var_6 > var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }

    if(var_6 >= level.black_market_quest.i_min_spawn_distance_sqr && var_6 <= level.black_market_quest.i_max_spawn_distance_sqr) {
      var_1 = var_5;
    }
  }

  if(var_1.size > 0) {
    var_8 = randomint(var_1.size);
    return var_1[var_8];
  }

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

function __kiosk_logic() {}

function kiosk_spawn() {
  var_0 = undefined;
  var_1 = find_kiosk_spawn_location(self.semtex_stuckplayer.origin);

  if(!isDefined(var_1)) {
    waitframe();
    self.result = "no_locale";
    thread scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }

  var_1.available = 0;
  var_0 = spawn("script_model", var_1.origin);
  var_0.angles = var_1.angles;
  var_0 setModel("x2_mercenary_buy_station_rig_skeleton");
  var_0 setscriptablepartstate("br_black_market_kiosk", "visible", 0);
  var_0.isblackmarketkiosk = 1;
  var_0.loot_point = var_1;
  var_0.visible = 1;
  var_0.quest = self;
  self.kiosk = var_0;
  self.kiosk_found = 0;
  self.kiosk setotherent(self.semtex_stuckplayer);

  foreach(var_3 in level.players) {
    if(var_3.team != self.team) {
      var_0 disablescriptableplayeruse(var_3);
    }
  }

  var_5 = spawnStruct();
  var_5.excludedplayers = [];
  var_5.excludedplayers[0] = self.semtex_stuckplayer;
  var_5.ogangles = [];
  var_5.ogangles[0] = self.team;
  scripts\mp\gametypes\br_quest_util::look_at_heli("br_black_market_crate_drop", var_1.origin, level.black_market_quest.i_drop_notify_radius, level.questinfo.defaultfilter, var_5);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_blm_dropnotify", self.team, 1, 1);
  wait level.black_market_quest.f_quest_circle_delay;
  quest_circle_setup(var_1.origin);
  var_6 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_3 in var_6) {
    scripts\mp\gametypes\br_quest_util::ref_1336A(var_3);
    start_player_threads(var_3);
  }

  thread kiosk_distance_watcher();
}

function kiosk_on_use(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0.entity)) {
    return;
  }

  if(isDefined(var_0.entity.quest)) {
    show_kiosk(var_0.entity.quest);
    complete_quest(var_0.entity.quest);
  }

  thread run_black_market_purchase_menu(var_3);
}

function kiosk_destroy_after_delay() {
  level endon("game_ended");
  self endon("death");
  wait level.black_market_quest.i_kiosk_destroy_timeout;
  kiosk_destroy();
}

function kiosk_destroy() {
  self.loot_point.available = 1;
  playFX(scripts\engine\utility::getfx("vfx_br3_pbs_dmg"), self.origin);
  playsoundatpos(self.origin, "mp_equip_destroyed");
  self delete();
}

function run_black_market_purchase_menu(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1.delay_kick_inactive_player = var_0;
  var_1 setclientomnvar("ui_br_purchase_file_override", 8);
  var_1 setclientomnvar("ui_br_purchase_killstreak_response", 0);
  var_1 setclientomnvar("ui_br_open_purchase_killstreak", 1);
  var_1.armorykioskpurchaseallowed = 1;
  scripts\mp\gametypes\br_analytics::destructable_car(var_1, "menu_open");
  var_1 thread scripts\mp\gametypes\br_armory_kiosk::apc_target_enemies(var_0);
  var_1 setsoundsubmix("iw8_br_plunder_kiosk_menu");
}

function __kiosk_location() {}

function ref_12AE8(var_0, var_1) {
  if(!isDefined(level.black_market_quest.wait_display_pavelow_boss_health_bar)) {
    level.black_market_quest.wait_display_pavelow_boss_health_bar = [];
  }

  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2.available = 1;
  level.black_market_quest.wait_display_pavelow_boss_health_bar[level.black_market_quest.wait_display_pavelow_boss_health_bar.size] = var_2;
}

function __player_logic() {}

function start_player_threads(var_0) {
  if(self.kiosk_found) {
    return;
  }

  if(level.black_market_quest.b_audio_ping_enabled) {
    thread player_start_audio_ping(var_0);
    return;
  }
}

function player_start_audio_ping(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 endon("marked_to_remove");
  var_0 endon("kiosk_found");
  var_1 = squared(level.black_market_quest.f_audio_echo_min_range);
  var_2 = squared(level.black_market_quest.f_audio_echo_max_range);
  var_3 = var_0.kiosk.origin;

  for(;;) {
    var_4 = distance2dsquared(self.origin, var_3);

    if(var_4 <= var_2) {
      self playlocalsound("br_black_market_ping_plr");
      var_5 = scripts\engine\math::remap(var_4, var_1, var_2, level.black_market_quest.f_audio_echo_min_interval, level.black_market_quest.f_audio_echo_max_interval);
      wait var_5;
      self playlocalsound("br_black_market_echo_plr");
      wait level.black_market_quest.i_audio_ping_interval - var_5;
      continue;
    }

    wait level.black_market_quest.i_audio_ping_interval;
  }
}

function __quest_circle_logic() {}

function quest_circle_setup(var_0) {
  var_1 = var_0 + scripts\engine\math::random_vector_2d() * randomfloatrange(0, level.black_market_quest.i_quest_circle_start_radius * 0.9);
  var_2 = (var_1[0], var_1[1], level.black_market_quest.i_quest_circle_start_radius);
  scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 0, 0, var_2);
  self.a_circles = [];
  var_3 = self.guard_spawners - self.kiosk.origin;
  var_4 = level.black_market_quest.i_quest_circle_end_radius / level.black_market_quest.i_quest_circle_start_radius;
  var_5 = self.kiosk.origin + var_3 * var_4;
  var_5 = (var_5[0], var_5[1], level.black_market_quest.i_quest_circle_end_radius);
  var_6 = 1 / level.black_market_quest.i_quest_circle_steps;

  for(var_7 = 0; var_7 <= level.black_market_quest.i_quest_circle_steps; var_7++) {
    self.a_circles[var_7] = vectorlerp(self.guard_spawners, var_5, var_6 * var_7);
  }

  self.i_circle_step = 0;
  self.v_next_circle = self.a_circles[1];
  self.i_next_circle_distance = squared(self.v_next_circle[2]);
  var_8 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_8 > -1) {
    self.obj_icon_mover = spawn("script_model", self.semtex_stuckplayer.origin);
    objective_onentity(var_8, self.obj_icon_mover);
    objective_state(var_8, "active");
    objective_setplayintro(var_8, 1);
    objective_setshowoncompass(var_8, 1);
    objective_setshowdistance(var_8, 0);
    playencryptedcinematicforall(var_8, 1);
    getscriptcachecontents(var_8, 0.5, 0.7);
    objective_icon(var_8, "ui_mp_br_mapmenu_icon_blackmarket_objective");
    objective_setbackground(var_8, 1);
    objective_addteamtomask(var_8, self.team);
    objective_setzoffset(var_8, 32);
    function_0442(var_8, 1);
    self.ref_11F64 = var_8;
  }

  thread quest_circle_animate(self.semtex_stuckplayer.origin, self.a_circles[0], 2);
}

function quest_circle_tick() {
  self.i_circle_step++;

  if(self.i_circle_step + 1 < self.a_circles.size) {
    thread quest_circle_animate(self.i_circle_step - 1], self.i_circle_step], 2);
self.v_next_circle = self.i_circle_step + 1];
self.i_next_circle_distance = squared(self.v_next_circle[2]);

if(self.i_circle_step == self.a_circles.size - 2) {
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_blm_kiosk_nearby", self.team, 1, 1);
  return;
}

return;
}

show_kiosk();
}

function quest_circle_animate(var_0, var_1, var_2, var_3) {
  self notify("stop_circle_anim");
  level endon("game_ended");
  self endon("marked_to_remove");
  self endon("stop_circle_anim");
  var_4 = var_2 * 1000;
  var_5 = gettime() + var_4;
  var_6 = 0;
  self.obj_icon_mover moveTo((var_1[0], var_1[1], self.kiosk.origin[2]), var_2);

  while(var_6 < 1) {
    var_6 = 1 - (var_5 - gettime()) / var_4;
    var_7 = vectorlerp(var_0, var_1, var_6);
    var_8 = var_7;

    if(istrue(var_3)) {
      var_8 = (var_7[0], var_7[1], scripts\engine\math::lerp(var_0[2], 0, var_6));
    }

    scripts\mp\gametypes\br_quest_util::ref_11DAE(var_8);
    waitframe();
  }
}

function __kiosk() {}

function redacted_weapon_purchase(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
    var_0 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
  }

  if(istrue(var_5)) {
    var_0 scripts\mp\gametypes\br_pickups::minsteps(var_1, var_3, var_4, var_5);
    return true;
  }

  var_6 = spawnStruct();
  var_6.scriptablename = var_1;
  var_6.origin = var_0.origin + (0, 0, 12);
  var_6.count = 0;
  var_6.maxcount = level.br_pickups.maxcounts[var_6.scriptablename];
  var_6.stackable = level.br_pickups.stackable[var_6.scriptablename];
  var_6.impulsefx = 0;

  if(isDefined(var_3)) {
    var_6.count = var_3;
  }

  if(!var_6.count && isDefined(level.br_pickups.counts[var_6.scriptablename])) {
    var_6.count = level.br_pickups.counts[var_6.scriptablename];
  }

  var_7 = var_0 scripts\mp\gametypes\br_pickups::cantakepickup(var_6);

  if(var_7 == 1) {
    thread redacted_weapon_give_ammo_on_pickup();
    var_0 scripts\mp\gametypes\br_pickups::onusecompleted(var_6, var_2, undefined, var_4);
    return true;
  }

  return false;
}

function redacted_weapon_give_ammo_on_pickup() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("pickedupweapon", var_0, var_1);

  switch (var_1.basename) {
    case "s4_mg_mgolf42_mp":
    case "s4_mr_moscar_mp":
    case "s4_sh_bromeo5_mp":
    case "s4_sm_owhiskey_mp":
    case "s4_ar_asierra44_mp":
      self givemaxammo(var_1);
      break;
    case "iw8_lm_dblmg_mp":
      self setweaponammoclip(var_1, weaponclipsize(var_1));
      level thread _luidecision::getsquadspawnlocations(self, var_1, weaponclipsize(var_1));
      break;
  }
}