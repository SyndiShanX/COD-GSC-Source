/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_28713158f599d530.gsc
***********************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["tdm"] = ::init;
}

init() {
  analytics_init();
  level.bot_funcs["player_spawned_gamemode"] = ::_id_B1F5606E58998B8D;

  if(!isDefined(game["trial"]))
    game["trial"] = [];

  if(!isDefined(game["trial"]["best_reward"]))
    game["trial"]["best_reward"] = 0;

  if(!isDefined(game["trial"]["tries_remaining"]))
    game["trial"]["tries_remaining"] = level.trial["attempts"];

  level.mapname = level.trial["zone"];
  level.enemies = [];
  level.enemiesactivenb = 0;
  level.enemiestotal = 10;
  level.enemieskilled = 0;
  level.totaltimeelapsed = 0;
  level.attempttier = 0;
  level.maxtimelimit = 59999900;
  level scripts\engine\utility::flag_init("trial_start_zone_entered");
  level scripts\engine\utility::flag_init("trial_countdown");
  level scripts\engine\utility::flag_init("trial_starting");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_ready_for_endscreen");
  level scripts\engine\utility::flag_init("trial_player_death");
  precachemodel("tag_origin");
  precachemodel("player128x128x8");
  precachemodel("box_wooden_grenade_02_green");
  precachemodel("head_al_qatala_3_ar");
  precachemodel("head_al_qatala_desert_05");
  precachemodel("head_al_qatala_desert_08");
  precachemodel("head_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02");
  precachemodel("body_al_qatala_desert_03");
  precachemodel("body_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02_b");
  thread hud_init();
  thread dialog_init();
  level.battlechatterenabled = 0;

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.allnodes = getallnodes();
  level.modeupdateloadoutclass = ::_id_57EAAF9E9FA19094;
  _id_66815653A1D324DF();
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isbot(self)) {
    if(!isbot(attacker)) {
      level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 1);
      level.enemieskilled++;
    }

    self playSound("trial_sfx_enemy_death");
    level notify("enemy_killed");
    level.enemies = scripts\engine\utility::array_removedead(level.enemies);
  } else {
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
    level.player thread _id_559FA700C7051D37();
  }
}

_id_B1F5606E58998B8D() {
  level.enemies[level.enemies.size] = self;
}

hud_init() {
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(game["trial"]["best_reward"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  level.player setclientomnvar("ui_match_in_progress", 1);
}

hud_objectives() {
  scripts\mp\trials\trial_utility::trial_ui_set_objective_icon_index(0);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);

  while(!isDefined(level.player))
    wait 0.05;

  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);

  while(level.enemieskilled < level.enemiestotal) {
    scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
    wait 0.05;
  }

  scripts\mp\trials\trial_utility::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  level notify("stop_timer");
  level scripts\engine\utility::flag_set("trial_completed");
}

hud_timer() {
  level endon("max_time_limit_reached");
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
  level.player playSound("trial_sfx_start");
  starttime = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    time = gettime() - starttime;
    level.totaltimeelapsed = int(time);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.totaltimeelapsed);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.totaltimeelapsed);
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    time = gettime() - starttime;
    level.totaltimeelapsed = int(time);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.totaltimeelapsed);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.totaltimeelapsed);

    if(game["trial"]["best_time"] <= 0 || time < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = time;
      hud_besttime_update();
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
    }
  } else {
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
  }

  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
}

hud_reward_tiers_tracking() {
  self endon("stop_timer");
  _id_72408207126E9282 = [];
  _id_72408207126E9282[0] = undefined;
  _id_72408207126E9282[1] = level.trial["tier1"];
  _id_72408207126E9282[2] = level.trial["tier2"];
  _id_72408207126E9282[3] = level.trial["tier3"];

  for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    level.attempttier = _id_AC0E594AC96AA3A8;
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(_id_AC0E594AC96AA3A8);

    if(isDefined(_id_72408207126E9282[_id_AC0E594AC96AA3A8])) {
      while(level.totaltimeelapsed < _id_72408207126E9282[_id_AC0E594AC96AA3A8] - 5000)
        wait 0.05;

      for(t = 5; t > 0; t--) {
        level.player playSound("trial_sfx_failure_countdown");
        wait 1;
      }

      level.player playSound("trial_sfx_failure");
    }
  }

  while(level.totaltimeelapsed < level.maxtimelimit)
    wait 0.05;

  level notify("max_time_limit_reached");
  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
  scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.maxtimelimit);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.maxtimelimit);
}

hud_attempt_over(_id_9B106ABAC2185216) {
  if(!istrue(_id_9B106ABAC2185216))
    level scripts\engine\utility::flag_wait("trial_completed");

  setDvar("scr_death_scene_time", 1.75);
  level.player freezecontrols(1);

  if(!scripts\engine\utility::flag("trial_player_death")) {
    _id_A691794C4E79B4C4 = game["trial"]["best_reward"];

    if(level.attempttier > _id_A691794C4E79B4C4) {
      game["trial"]["best_reward"] = level.attempttier;
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(level.attempttier);
    }

    if(level.attempttier >= 2) {
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    } else if(level.attempttier >= 1) {
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
    } else {
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
    level.player clearsoundsubmix("deaths_door_mp");
    level.player playSound("trial_sfx_failure");
    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    setomnvar("ui_trial_failed", 1);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 1);
    wait 1;
  }

  scripts\engine\utility::array_call(level.enemies, ::despawnagent);
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  level scripts\engine\utility::flag_wait("trial_ready_for_endscreen");
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  level.trial_restarting = 1;
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  _id_467003532BDC5C8A = game["trial"]["tries_remaining"];

  if(_id_467003532BDC5C8A > 0) {
    level notify("game_cleanup");
    level notify("restarting");
    game["state"] = "playing";
    scripts\mp\trials\trial_utility::trial_restart();
  } else {}
}

hud_besttime_update() {
  besttime = game["trial"]["best_time"];
  _id_A691794C4E79B4C4 = game["trial"]["best_reward"];
  scripts\mp\trials\trial_utility::trial_ui_set_best_time(besttime);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(_id_A691794C4E79B4C4);
}

dialog_init() {
  game["dialog"]["trial_intro"] = "kh_clear_intro";
  game["dialog"]["trial_intro_short"] = "kh_clear_intro_short";
  game["dialog"]["trial_end_tier_0"] = "kh_clear_star0_fail";
  game["dialog"]["trial_end_tier_0_alt"] = "kh_clear_star0_death";
  game["dialog"]["trial_end_tier_1"] = "kh_clear_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_clear_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_clear_star3";
  game["dialog"]["trial_retry"] = "kh_clear_retry";
  game["dialog"]["clear_start"] = "kh_clear_start";
  game["dialog"]["clear_search"] = "kh_clear_search";
  game["dialog"]["clear_good_kill"] = "kh_clear_goodkill";
  thread dialog_killstreak_acknowledgement();
  thread dialog_push_forward();
  scripts\engine\utility::flag_wait("trial_starting");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_start");
}

dialog_push_forward() {
  level endon("trial_completed");
  _id_AC0E594AC96AA3A8 = 0;
  _id_2FF1800EF77605AA = 0;
  scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    wait 1;
    _id_25509B00C1324512 = level.enemieskilled != _id_2FF1800EF77605AA;

    if(_id_25509B00C1324512 == 0 && level.enemies.size > 0) {
      _id_8F42EE0350D4B14C = sortbydistance(level.enemies, level.player.origin);

      if(distance2d(_id_8F42EE0350D4B14C[0].origin, level.player.origin) > 900)
        _id_AC0E594AC96AA3A8++;
    } else {
      _id_AC0E594AC96AA3A8 = 0;
      _id_2FF1800EF77605AA = level.enemieskilled;
    }

    if(_id_AC0E594AC96AA3A8 > 4) {
      _id_AC0E594AC96AA3A8 = 0;
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_search");
      wait 5;
    }
  }
}

dialog_killstreak_acknowledgement() {
  _id_153FDEE861E0F06F = 0;
  lastkilltime = 0;
  cooldowntime = 0;
  _id_D2D3E5CD5D40CB75 = 8000;
  level waittill("enemy_killed");
  _id_153FDEE861E0F06F++;
  lastkilltime = gettime();

  for(;;) {
    level waittill("enemy_killed");
    time = gettime();
    _id_4573A8725DD3748E = time - lastkilltime;

    if(_id_4573A8725DD3748E < 2600) {
      if(_id_153FDEE861E0F06F < 3)
        _id_153FDEE861E0F06F++;
    } else if(_id_4573A8725DD3748E < 4000) {} else if(_id_153FDEE861E0F06F > 0)
      _id_153FDEE861E0F06F--;

    if(_id_153FDEE861E0F06F > 2 && time > cooldowntime) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_good_kill");
      cooldowntime = time + _id_D2D3E5CD5D40CB75;
      _id_153FDEE861E0F06F = _id_153FDEE861E0F06F - 2;
    }

    lastkilltime = time;
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_clear;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["weapon1"] = "DNF";
    game["trial"]["analytics"]["weapon2"] = "DNF";
  }
}

trial_dlog_clear() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  time = getomnvar("ui_trial_best_time");
  _id_A7756ABFED842C14 = "" + game["trial"]["analytics"]["weapon1"];
  _id_A7756DBFED8432AD = "" + game["trial"]["analytics"]["weapon2"];
  level.player dlog_recordplayerevent("dlog_event_trial_complete_clear", ["id", id, "tier", tier, "time", time, "weapon1", _id_A7756ABFED842C14, "weapon2", _id_A7756DBFED8432AD]);
}

_id_66815653A1D324DF() {
  setDvar("scr_war_teamcount", 2);
  setDvar("scr_war_teamsize", 0);
  setDvar("scr_war_squadsize", 4);
  setDvar("scr_war_numlives", 0);
  setDvar("scr_war_playerrespawndelay", 0);
  setDvar("scr_war_waverespawndelay", 0);
  setDvar("scr_war_promode", 0);
  setDvar("scr_war_timelimit", 600);
  setDvar("scr_war_scorelimit", 75);
  setDvar("scr_war_roundlimit", 1);
  setDvar("scr_war_winlimit", 0);
  setDvar("scr_war_roundswitch", 1);
  setDvar("scr_war_pointsperkill", 1);
  setDvar("scr_war_pointsperdeath", 0);
  setDvar("scr_war_pointsheadshotbonus", 0);
  setDvar("scr_war_dogtags", 0);
  setDvar("scr_war_codcasterenabled", 1);
  setDvar("dvar_8E9AD03281DFA5E8", 1);
  setDvar("dvar_7BC0BAF0C6BD1146", 1);
  setDvar("dvar_AEC2327D01410BD9", 1);
  _id_DC5361A955493964();
  [[level.onstartgametype]]();
  level.enemyteam = scripts\engine\utility::get_enemy_team(level.player.team);
  level thread scripts\mp\bots\bots::spawn_bots(3, "allies", undefined, undefined, "spawned_enemies", "recruit");
  level thread scripts\mp\bots\bots::spawn_bots(4, "axis", undefined, undefined, "spawned_enemies", "recruit");
}

_id_DC5361A955493964() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  level.gametype = "war";
  _id_C3F8F987F81C24E8 = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = _id_67FE8662FD265E92::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_67FE8662FD265E92::updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = _id_67FE8662FD265E92::onstartgametype;
  level.getspawnpoint = _id_67FE8662FD265E92::getspawnpoint;
  level.onnormaldeath = _id_67FE8662FD265E92::onnormaldeath;
  level.modeonspawnplayer = _id_67FE8662FD265E92::onspawnplayer;
  level.onplayerconnect = _id_7EED363A9B249F1C::onplayerconnect;
  level.onplayerkilled = ::onplayerkilled;
  game["dialog"]["gametype"] = "gametype_tdm";
  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
  level.testtdmanywhere = getdvarint("dvar_157F06AFF3C1F357", 0);
  level.tdmanywhere_dropheight = getdvarfloat("dvar_0C692D2A11DD6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat("dvar_631C58033F43C2DC", 2048);
  level.tdmanywhere_distoffset = getdvarfloat("dvar_F314048C87AE28AA", 4092);

  if(istrue(level.testtdmanywhere))
    scripts\cp_mp\parachute::initparachutedvars();

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = _id_67FE8662FD265E92::shouldgamelobbyremainintact;
}

_id_57EAAF9E9FA19094(struct) {
  if(struct.loadoutarchetype == "none")
    struct.loadoutarchetype = "archetype_assault";
}

_id_559FA700C7051D37() {
  while(!scripts\mp\utility\player::isinkillcam())
    wait 0.1;

  self notify("abort_killcam");
  self.cancelkillcam = 1;
}