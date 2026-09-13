/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_race.gsc
***********************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["race"] = ::race_init;
}

race_init() {
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  analytics_init();

  if(isDefined(level.trial_race_lap_total_override))
    level.trial_race_lap_total = level.trial_race_lap_total_override;
  else
    level.trial_race_lap_total = 3;

  level.trial_vehicle = scripts\engine\utility::getStruct("StrucSpawnATV", "targetname");

  if(!isDefined(level.trial_vehicle))
    level.trial_vehicle = scripts\engine\utility::getStruct("trial_vehicle_spawn", "targetname");

  if(isDefined(level.trial_vehicle.script_noteworthy)) {
    switch (level.trial_vehicle.script_noteworthy) {
      case "little_bird":
        level.trial_race_uses_heli = 1;
        level.atv_vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", level.trial_vehicle);
        level.lb_dmg_factor_main_rotor = 0.25;
        level.lb_dmg_factor_tail_rotor = 0.25;
        thread fxrings();
        break;
      case "tac_rover":
      default:
        level.atv_vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", level.trial_vehicle);
        break;
    }
  } else
    level.atv_vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", level.trial_vehicle);

  level.turrets_shields = getEntArray("shield", "targetname");
  level.centers = getEntArray("center", "targetname");
  level.rpgs = getEntArray("rpg", "targetname");

  if(level.rpgs.size > 0) {
    if(!isDefined(level.trial_rpg_settings))
      trial_rpg_init();

    foreach(_id_CB50110314060044 in level.rpgs) {
      _id_CB50110314060044 thread look_at_heli();
      _id_CB50110314060044 thread shoot_vehicle();

      if(istrue(level.trial_race_uses_heli))
        _id_CB50110314060044 thread trial_flare_watcher();
    }
  }

  level.ref_angle_doors = getEntArray("gate_hide", "targetname");
  level.dyn_door = getEntArray("dyn_gate", "targetname");

  foreach(door in level.dyn_door)
  door thread dynamic_door();

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_triggers_expl = getEntArray("progressionfire", "targetname");

  if(game["trial"]["tries_remaining"] < level.trial["attempts"])
    level.trial_spawn_vehicle = level.atv_vehicle;

  scripts\engine\utility::getstructarray_delete("atv_spawn", "targetname");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_in_progress");
  level scripts\engine\utility::flag_init("trial_player_death");
  level scripts\engine\utility::flag_init("trial_start");
  level scripts\engine\utility::flag_init("player_not_on_vehicle");
  level scripts\engine\utility::flag_init("gate_flares_0");
  thread ui_init();
  thread _id_22E5186EA561820D();

  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3)
    wait 11;

  thread dialog_init();
  thread race_flow();
  thread flare_setup();
  thread player_monitor_death();
  thread start_race_countdown();
  thread player_complete_trial();
  vfx_start();
  _id_B05144A4605B1217 = getEntArray("traficcone", "targetname");

  foreach(_id_1954DA95E3FAB4FE in _id_B05144A4605B1217)
  _id_1954DA95E3FAB4FE notsolid();

  level.trial_dogtags = [];
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  waitframe();
  level.trial_vehicle_outline_id = scripts\mp\utility\outline::outlineenableforplayer(level.atv_vehicle, level.player, "outline_trial_item", "level_script");

  if(istrue(level.trial_delete_out_of_bounds)) {
    _id_C2D4A285B08DF7E7 = getEntArray("OutOfBounds", "targetname");

    foreach(trig in _id_C2D4A285B08DF7E7)
    trig scripts\engine\utility::trigger_off();
  }

  thread race_dogtag_init();

  foreach(dogtag in level.trial_dogtags)
  dogtag thread dogtag_visibility_watcher();

  setomnvar("ui_trial_objective_total", level.trial_dogtags.size);
  level.nosuspensemusic = 1;

  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");
    wait 8;
  }
}

_id_22E5186EA561820D() {
  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3) {
    while(!isalive(level.player))
      waitframe();

    wait 1;
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 0);
    wait 18;
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 4);
    level.player freezecontrols(0);
    level.player freezelookcontrols(0);
  }
}

start_race_countdown() {
  _id_CB5DCAB29FF1328C = getEnt("StartWaypoint", "targetname");
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  while(!isDefined(level.player.vehicle))
    waitframe();

  level scripts\engine\utility::flag_set("trial_start");
  scripts\mp\utility\outline::outlinedisable(level.trial_vehicle_outline_id, level.atv_vehicle);
  scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();

  if(!istrue(level.trial_race_uses_heli)) {
    level.player allowmovement(0);
    level.player freezecontrols(1);
    wait 1.5;
  }

  level.trial_headicon_origin = _id_CB5DCAB29FF1328C.origin;
  level.trial_headicon = thread spawn_headicon();
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 3);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level scripts\engine\utility::flag_set("gate_flares_0");
  level.player playSound("trial_sfx_start");
  setmusicstate("");

  if(!istrue(level.trial_race_uses_heli)) {
    level.player allowmovement(1);
    level.player freezecontrols(0);
  }

  level scripts\engine\utility::flag_set("trial_in_progress");
  thread dialog_reachnextcheckpoint();
  thread vehicle_dismount_watcher();
  scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
  hud_timer();
}

race_flow() {
  level endon("trial_completed");
  level.laps_data = [];
  level.trial_headicon_origin = (0, 0, 0);
  level.objective_origin = (0, 0, 0);
  level scripts\engine\utility::flag_wait("trial_start");
  start_trigger = getEnt("StartCheckpoint", "targetname");
  level.current_trigger = start_trigger;
  start_trigger waittill("trigger");

  if(isDefined(level.current_trigger.fx_obj)) {
    level.player playSound("trial_sfx_success");
    stopFXOnTag(scripts\engine\utility::getfx("circle"), level.current_trigger.fx_obj, "tag_origin");
    level.current_trigger.fx_obj delete();
  }

  if(isDefined(level.trial_active_ring))
    level.trial_active_ring--;

  _id_DCE63F20663B7DBF = getEnt(level.current_trigger.target, "targetname");
  level.trial_headicon_origin = _id_DCE63F20663B7DBF.origin;
  level.objective_origin = _id_DCE63F20663B7DBF.origin;

  if(isDefined(level.trial_headicon))
    level.trial_headicon moveTo(level.trial_headicon_origin, 0.5, 0.1, 0.3);

  objective = thread spawn_objective();
  level.player setclientomnvar("ui_edge_glow_trials", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "ui_edge_glow_trials", 0);

  for(;;) {
    _id_DCE63F20663B7DBF waittill("trigger");

    if(isDefined(level.trial_active_ring))
      level.trial_active_ring--;

    level.checkpoints_count++;
    level.timetonextcheckpoint = 0;
    level.timevotrigger = 6;
    level.current_trigger = _id_DCE63F20663B7DBF;

    if(isDefined(level.current_trigger.fx_obj)) {
      stopFXOnTag(scripts\engine\utility::getfx("circle"), level.current_trigger.fx_obj, "tag_origin");
      level.current_trigger.fx_obj delete();
    }

    if(isDefined(level.current_trigger.script_noteworthy) && level.lap == level.trial_race_lap_total) {
      if(level.current_trigger.script_noteworthy == "end")
        _id_DCE63F20663B7DBF = getEnt(level.current_trigger.script_noteworthy, "targetname");
    } else
      _id_DCE63F20663B7DBF = getEnt(level.current_trigger.target, "targetname");

    level.player notify("newcheckpoint");
    level.player setclientomnvar("ui_edge_glow_trials", 255);
    level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "ui_edge_glow_trials", 0);

    if(level.current_trigger.targetname == "StartCheckpoint" || level.current_trigger.targetname == "end" || level.current_trigger.targetname == "lap" && level.lap < level.trial_race_lap_total) {
      level.trial_lap_time = gettime() - gettime() % 100 - level.start_lap_time;
      level.laps_data = scripts\engine\utility::array_add(level.laps_data, level.trial_lap_time);

      if(level.lap >= level.trial_race_lap_total) {
        if(level.trial_race_lap_total == 1)
          scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.lap, "lap_" + level.lap + "_time", level.laps_data[level.lap - 1], 0);

        level.player.vehicle vehicle_turnengineoff();
        level scripts\engine\utility::flag_set("trial_completed");
      } else {
        level.start_lap_time = gettime() - gettime() % 100;
        scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.lap, "lap_" + level.lap + "_time", level.laps_data[level.lap - 1], 0);
        level.player playSound("trial_sfx_start");
        setmusicstate("");
        level.lap++;
        _id_FBA2316A919DD362 = "trial_lap_" + level.lap;
        scripts\mp\trials\trial_utility::trial_ui_set_lap(level.lap, level.trial_race_lap_total);
        vfx_start();

        if(level.lap == level.trial_race_lap_total) {
          _id_FBA2316A919DD362 = "trial_lap_final";
          _id_9B67B38673209C18 = ["race_final_lap", "race_one_lap"];
          level.player scripts\mp\utility\dialog::leaderdialogonplayer(scripts\engine\utility::random(_id_9B67B38673209C18));
        }

        if(level.trial_lap_time <= (level.trial["tier3"] + level.dogtags.size / 2 * 1000) / level.trial_race_lap_total)
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_good_lap");
        else if(level.trial_lap_time >= (level.trial["tier1"] + level.dogtags.size * 1000) / level.trial_race_lap_total)
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_bad_lap");

        level.player thread scripts\mp\hud_message::showsplash(_id_FBA2316A919DD362);
        level.dogtag_collected_lap = 0;
      }
    } else
      level.player playSound("trial_sfx_success");

    level.trial_headicon_origin = _id_DCE63F20663B7DBF.origin;
    level.objective_origin = _id_DCE63F20663B7DBF.origin;
    level.trial_headicon moveTo(level.trial_headicon_origin, 0.5, 0.1, 0.3);
    thread spawn_objective();
  }
}

flare_setup() {
  _id_D7FB0DE57168CDBC = getEntArray("gate_flare", "targetname");

  if(isDefined(_id_D7FB0DE57168CDBC[0]) && _id_D7FB0DE57168CDBC[0].model == "misc_wm_flarestick")
    _id_A1EE390A5A253236 = "j_cap";
  else
    _id_A1EE390A5A253236 = "TAG_FIRE_FX";

  foreach(flare in _id_D7FB0DE57168CDBC) {
    _id_031FA81AA99E5DE3 = flare gettagangles(_id_A1EE390A5A253236);
    flareorigin = flare gettagorigin(_id_A1EE390A5A253236);
    _id_704767B45ABC90FB = spawn("script_model", flareorigin);
    _id_704767B45ABC90FB.angles = _id_031FA81AA99E5DE3;
    _id_704767B45ABC90FB linkTo(flare, _id_A1EE390A5A253236, (1, 0, 0), (90, 0, 0));
    _id_704767B45ABC90FB setModel("tag_origin");
    _id_8E53204EAD72C30D = spawn("script_model", flareorigin);
    _id_8E53204EAD72C30D.angles = _id_031FA81AA99E5DE3;
    _id_8E53204EAD72C30D linkTo(flare, _id_A1EE390A5A253236, (0, 0, -1.75), (0, 180, 0));
    _id_8E53204EAD72C30D setModel("tag_origin");
    scripts\engine\utility::flag_init("gate_flares_" + flare.script_noteworthy);
    thread gate_flares_think(flare.script_noteworthy, _id_704767B45ABC90FB, _id_8E53204EAD72C30D);
  }
}

gate_flares_think(index, _id_73017BCF3B24134E, _id_B59E17EBB21A1A00) {
  level endon("trial_completed");

  for(;;) {
    scripts\engine\utility::flag_wait("gate_flares_" + index);
    playFXOnTag(level.vfx_smoke, _id_73017BCF3B24134E, "TAG_ORIGIN");
    playFXOnTag(level.vfx_flare, _id_B59E17EBB21A1A00, "TAG_ORIGIN");

    while(scripts\engine\utility::flag("gate_flares_" + index))
      waitframe();

    stopFXOnTag(level.vfx_smoke, _id_73017BCF3B24134E, "TAG_ORIGIN");
    stopFXOnTag(level.vfx_flare, _id_B59E17EBB21A1A00, "TAG_ORIGIN");
  }
}

player_complete_trial() {
  level scripts\engine\utility::flag_wait("trial_completed");
  thread scripts\mp\trials\trial_utility::trial_ui_return_to_vehicle(0);
  level.player allowmovement(0);
  level.player freezecontrols(1);
  level notify("stop_timer");

  if(!scripts\engine\utility::flag("trial_player_death")) {
    if(level.trial_race_lap_total == 0) {}

    for(index = 2; index <= level.trial_race_lap_total; index++)
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(index, "lap_" + index + "_time", level.laps_data[index - 1], 0);

    if(level.trial_dogtags.size > 0) {
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_race_lap_total + 1, "dogtag_collected", level.dogtag_collected, level.time_reduction_bonus * -1);

      if(level.dogtag_collected == level.trial_dogtags.size) {
        scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_race_lap_total + 2, "all_dogtag_collected", 0, -5000);
        level.currenttime_bonus = level.currenttime_bonus - 5000;
      }
    }

    scripts\engine\utility::delaythread(3, scripts\mp\trials\trial_utility::trial_ui_set_subtime, level.currenttime);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(level.currenttime_bonus);

    if(level.currenttime_bonus <= level.trial["tier3"])
      level.reward_tier = 3;
    else if(level.currenttime_bonus <= level.trial["tier2"])
      level.reward_tier = 2;
    else if(level.currenttime_bonus <= level.trial["tier1"])
      level.reward_tier = 1;
    else
      level.reward_tier = 0;

    _id_A691794C4E79B4C4 = game["trial"]["best_reward"];

    if(level.reward_tier > _id_A691794C4E79B4C4) {
      game["trial"]["best_reward"] = level.reward_tier;
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(level.reward_tier);
    }

    besttime = game["trial"]["best_time"];

    if(game["trial"]["best_time"] <= 0 || level.currenttime_bonus < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = level.currenttime_bonus;
      hud_besttime_update();
      game["trial"]["analytics"]["best_lap1"] = level.laps_data[0];

      if(isDefined(level.laps_data[1]))
        game["trial"]["analytics"]["best_lap2"] = level.laps_data[1];

      if(isDefined(level.laps_data[2]))
        game["trial"]["analytics"]["best_lap3"] = level.laps_data[2];
    }

    if(level.reward_tier == 3) {
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
    } else if(level.reward_tier == 2) {
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
    } else if(level.reward_tier == 1) {
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
    } else {
      _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    }
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
    scripts\mp\trials\trial_utility::trial_ui_set_main_time(0);
    scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
    setomnvar("ui_trial_failed", 1);

    if(level.trial_dogtags.size > 0)
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_race_lap_total + 1, "dogtag_collected", 0, 0);

    level.player playSound("trial_sfx_failure");
    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    level.trial_spawn_wait = 1;
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 1.25);

    if(isDefined(level.atv_vehicle))
      level.atv_vehicle delete();
  }

  waitframe();
  scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  level.trial_restarting = 1;
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  _id_467003532BDC5C8A = game["trial"]["tries_remaining"];

  if(_id_467003532BDC5C8A > 0)
    scripts\mp\trials\trial_utility::trial_restart();
}

player_monitor_death() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  level.player waittill("death");
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  scripts\engine\utility::flag_set("trial_player_death");
  scripts\engine\utility::flag_set("trial_completed");
}

ui_init() {
  if(!isDefined(game["trial"]["best_reward"]))
    game["trial"]["best_reward"] = 0;

  if(isDefined(level.trial_dogtag_setup))
    _id_532977768C9016D3 = level.trial_dogtag_setup;
  else
    _id_532977768C9016D3 = "dogtag_spawn";

  level.lap = 1;
  level.dogtag_collected = 0;
  level.dogtag_collected_lap = 0;
  level.dogtags = scripts\engine\utility::getStructArray(_id_532977768C9016D3, "script_noteworthy");
  level.time_reduction_bonus = 0;
  level.checkpoints_count = 1;
  scripts\mp\trials\trial_utility::trial_ui_set_lap(level.lap, level.trial_race_lap_total);
  scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);
  thread atv_outline();
  thread hud_besttime_update();
  thread hud_reward_tiers_tracking();
  thread hud_timer_reward_tiers();
  thread hud_lap_scoreboard();
}

hud_timer() {
  level endon("trial_completed");
  level.currenttime = 0;
  level.currenttime_bonus = 0;
  level.start_lap_time = gettime() - gettime() % 100;

  for(;;) {
    starttime = gettime() - gettime() % 100;
    waitframe();

    while(!scripts\engine\utility::flag("trial_completed")) {
      level.currenttime = gettime() - gettime() % 100 - starttime;
      level.currenttime_bonus = level.currenttime - level.time_reduction_bonus;

      if(level.currenttime_bonus < 0)
        scripts\mp\trials\trial_utility::trial_ui_set_subtime(0);
      else
        scripts\mp\trials\trial_utility::trial_ui_set_subtime(level.currenttime_bonus);

      waitframe();
    }
  }

  waitframe();
}

hud_lap_scoreboard() {
  for(index = 1; index <= level.trial_race_lap_total; index++)
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(index, "lap_" + index + "_time", 0, 0);

  if(level.dogtags.size > 0)
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_race_lap_total + 1, "dogtag_collected", level.dogtag_collected, level.time_reduction_bonus * -1);
}

hud_timer_reward_tiers() {
  self endon("stop_timer");

  while(!isDefined(level.currenttime_bonus))
    waitframe();

  for(;;) {
    if(level.currenttime_bonus > level.trial["tier3"] - 5000 && level.currenttime_bonus < level.trial["tier3"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    if(level.currenttime_bonus > level.trial["tier2"] - 5000 && level.currenttime_bonus < level.trial["tier2"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    if(level.currenttime_bonus > level.trial["tier1"] - 5000 && level.currenttime_bonus < level.trial["tier1"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    waitframe();
  }
}

hud_reward_tiers_tracking() {
  self endon("stop_timer");
  self waittill("trial_in_progress");
  _id_D91A079BD02B46F7 = 5;
  _id_72408207126E9282 = [];
  _id_72408207126E9282[0] = undefined;
  _id_72408207126E9282[1] = level.trial["tier1"];
  _id_72408207126E9282[2] = level.trial["tier2"];
  _id_72408207126E9282[3] = level.trial["tier3"];
  level.reward_tier = 3;

  for(;;) {
    _id_EB54B63FA5690F56 = level.reward_tier;

    if(level.currenttime_bonus <= level.trial["tier3"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(3);
      level.reward_tier = 3;
    } else if(level.currenttime_bonus <= level.trial["tier2"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(2);
      level.reward_tier = 2;
    } else if(level.currenttime_bonus <= level.trial["tier1"]) {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(1);
      level.reward_tier = 1;
    } else {
      scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
      level.reward_tier = 0;
    }

    if(level.reward_tier < _id_EB54B63FA5690F56)
      level.player playSound("trial_sfx_failure");

    waitframe();
  }
}

hud_besttime_update() {
  besttime = game["trial"]["best_time"];
  _id_A691794C4E79B4C4 = game["trial"]["best_reward"];
  scripts\mp\trials\trial_utility::trial_ui_set_best_time(besttime);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(_id_A691794C4E79B4C4);
}

spawn_headicon() {
  _id_0DA71A94C8A5A77E = spawn("script_model", level.trial_headicon_origin);
  _id_0DA71A94C8A5A77E setModel("tag_origin");
  level.waypoint_icon = createheadicon(_id_0DA71A94C8A5A77E);
  setheadiconimage(level.waypoint_icon, "icon_waypoint_marker");
  setheadicondrawthroughgeo(level.waypoint_icon, 1);
  setheadiconmaxdistance(level.waypoint_icon, 0);
  setheadiconsnaptoedges(level.waypoint_icon, 1);
  setheadiconnaturaldistance(level.waypoint_icon, 0);
  setheadiconzoffset(level.waypoint_icon, -50);
  return _id_0DA71A94C8A5A77E;
}

spawn_objective() {
  if(!isDefined(level.waypointid))
    level.waypointid = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  objective_state(level.waypointid, "active");
  objective_position(level.waypointid, level.objective_origin);
  objective_setplayintro(level.waypointid, 0);
  objective_icon(level.waypointid, "icon_waypoint_marker");
  objective_setbackground(level.waypointid, 1);
  objective_setfadedisabled(level.waypointid, 0);
  objective_setshowoncompass(level.waypointid, 1);
  objective_setminimapiconsize(level.waypointid, "icon_regular");
  objective_setshowdistance(level.waypointid, 0);
  objective_ping(level.waypointid);
  objective_setownerteam(level.waypointid, level.player.team);
  level scripts\engine\utility::flag_wait("trial_completed");
  objective_delete(level.waypointid);
}

dialog_init() {
  game["dialog"]["trial_intro"] = "mp_petrograd_race_intro";
  game["dialog"]["trial_intro_short"] = "mp_petrograd_race_intro_s";
  game["dialog"]["trial_end_tier_0"] = "mp_petrograd_race_0star";
  game["dialog"]["trial_end_tier_0_alt"] = "mp_petrograd_obj_fail";
  game["dialog"]["trial_end_tier_1"] = "mp_petrograd_race_1star";
  game["dialog"]["trial_end_tier_2"] = "mp_petrograd_race_2star";
  game["dialog"]["trial_end_tier_3"] = "mp_petrograd_race_3star";
  game["dialog"]["trial_retry"] = "mp_petrograd_race_intro_s";
  game["dialog"]["fil_hurry_up"] = "mp_petrograd_obj_nag_hurry";
  game["dialog"]["race_move_to_next_checkpoint"] = "mp_petrograd_race_checkpoint";
  game["dialog"]["race_final_lap"] = "mp_petrograd_race_finallap";
  game["dialog"]["race_one_lap"] = "mp_petrograd_race_oneturn";
  game["dialog"]["race_use_atv"] = "mp_petrograd_race_useatv";
  game["dialog"]["race_good_lap"] = "mp_petrograd_race_boost";
  game["dialog"]["race_bad_lap"] = "mp_petrograd_race_front";
  game["dialog"]["race_speed_it_up"] = "mp_petrograd_race_nag";
  scripts\engine\utility::flag_wait("trial_completed");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_start");
}

dialog_reachnextcheckpoint() {
  level endon("trial_completed");
  level.timetonextcheckpoint = 0;
  level.timevotrigger = 6;

  for(;;) {
    while(level.timetonextcheckpoint < level.timevotrigger) {
      wait 1;
      level.timetonextcheckpoint++;
    }

    if(isDefined(level.player.vehicle)) {
      if(randomint(100) < 30)
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_move_to_next_checkpoint");
      else
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_speed_it_up");

      level.timevotrigger = level.timevotrigger + 3;
    }

    level.timetonextcheckpoint = 0;
    waitframe();
  }
}

vehicle_dismount_watcher() {
  level endon("trial_completed");

  for(;;) {
    thread scripts\mp\trials\trial_utility::trial_ui_return_to_vehicle(0);

    while(isDefined(level.player.vehicle))
      waitframe();

    thread scripts\mp\trials\trial_utility::trial_ui_return_to_vehicle(1);
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("race_use_atv");

    while(!isDefined(level.player.vehicle))
      waitframe();
  }
}

atv_outline() {
  level endon("trial_completed");
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  for(;;) {
    _id_EDC14110330AD917 = scripts\mp\utility\outline::outlineenableforplayer(level.atv_vehicle, level.player, "outline_trial_vehicle", "level_script");

    while(!isDefined(level.player.vehicle))
      waitframe();

    scripts\mp\utility\outline::outlinedisable(_id_EDC14110330AD917, level.atv_vehicle);

    while(isDefined(level.player.vehicle))
      waitframe();

    waitframe();
  }
}

race_dogtag_init() {
  foreach(_id_3A482D3FD8FAFCAB in level.dogtags)
  _id_3A482D3FD8FAFCAB thread spawn_race_dogtags(_id_3A482D3FD8FAFCAB, level.player);
}

spawn_race_dogtags(victim, attacker) {
  tagoffset = 14;
  upangles = (0, 0, 0);
  _id_650440C6A1642E7E = victim.angles;

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    _id_650440C6A1642E7E = victim getworldupreferenceangles();
    upangles = anglestoup(_id_650440C6A1642E7E);

    if(upangles[2] < 0)
      tagoffset = -14;
  }

  visuals[0] = spawn("script_model", (0, 0, 0));
  visuals[0] setModel("military_dogtags_iw8_orange");
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

  if(victim scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(upangles[2] < 0)
      visuals[0].angles = _id_650440C6A1642E7E;
  }

  useteam = "any";
  dogtag = scripts\mp\gameobjects::createuseobject(level.player.team, trigger, visuals, (0, 0, 16));
  dogtag.victim = victim;
  dogtag.victimteam = level.player.team;
  _id_99F61E2EEA65ECE9 = victim.script_parameters;
  pos = victim.origin + (0, 0, tagoffset);
  dogtag.trigger.origin = pos;
  dogtag.visuals[0].origin = pos;
  dogtag.visuals[0].lap_index = _id_99F61E2EEA65ECE9;
  dogtag.attacker = attacker;
  dogtag.attackerteam = attacker.team;
  dogtag.ownerteam = scripts\engine\utility::get_enemy_team(level.player.team);

  if(isDefined(dogtag.objidnum)) {
    if(dogtag.objidnum != -1) {
      objid = dogtag.objidnum;
      scripts\mp\objidpoolmanager::update_objective_position(objid, victim.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(dogtag.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(dogtag.objidnum, 0);
      dogtag scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
    }
  }

  dogtag.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  level.trial_dogtags = scripts\engine\utility::array_add(level.trial_dogtags, dogtag);
  trigger waittill("trigger");
  dogtag notify("willdelete");
  level.dogtag_collected++;
  level.dogtag_collected_lap++;
  level.player thread scripts\mp\rank::scoreeventpopup("stat_8567CA81F8C59D3C");
  level.time_reduction_bonus = 1000 * level.dogtag_collected;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_time(level.trial_race_lap_total + 1, "dogtag_collected", level.dogtag_collected, level.time_reduction_bonus * -1);
  level.player playSound("mp_killconfirm_tags_pickup");
  dogtag thread scripts\mp\gameobjects::deleteuseobject();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < dogtag.visuals.size; _id_AC0E594AC96AA3A8++)
    dogtag.visuals[_id_AC0E594AC96AA3A8] delete();
}

dogtag_visibility_watcher() {
  level endon("trial_completed");
  self endon("willdelete");
  trigger = getEnt(self.victim.targetname, "target");

  while(isDefined(self)) {
    scripts\mp\gameobjects::disableobject();
    self.visuals[0] hide();
    level scripts\engine\utility::flag_wait("trial_start");

    if(int(self.visuals[0].lap_index) == 1 && trigger.targetname == "StartCheckpoint" && level.checkpoints_count == 1) {
      scripts\mp\gameobjects::enableobject();
      self.visuals[0] show();
    }

    trigger waittill("trigger");

    if(int(self.visuals[0].lap_index) == level.lap && trigger.targetname == level.current_trigger.targetname) {
      dist = distance(self.visuals[0].origin, level.player.origin);
      _id_E6932C067E0B2E71 = dist / 10000;
      self.visuals[0] scripts\engine\utility::delaycall(_id_E6932C067E0B2E71, ::show);
      scripts\engine\utility::delaythread(_id_E6932C067E0B2E71, scripts\mp\gameobjects::enableobject);
      playsoundatpos(self.visuals[0].origin, "mp_killconfirm_tags_drop");
      waitframe();
      level.player waittill("newcheckpoint");
      waitframe();
    }
  }
}

dynamic_door() {
  _id_E3041715DACB5541 = getEntArray("barrier_col", "targetname");
  _id_A76E3522EFFFA57A = getEntArray("barrier_col_hide", "targetname");
  _id_DDBB56AE221F53F7 = scripts\engine\utility::getclosest(self.origin, level.ref_angle_doors, 100);
  _id_25075ECD06FB88B1 = sortbydistance(_id_E3041715DACB5541, self.origin);
  _id_F0FF756D1267B42A = sortbydistance(_id_A76E3522EFFFA57A, _id_DDBB56AE221F53F7.origin);

  if(isDefined(_id_E3041715DACB5541)) {
    _id_F0FF756D1267B42A[0] notsolid();
    _id_F0FF756D1267B42A[1] notsolid();
  }

  _id_BC2FF14F617E1433 = _id_DDBB56AE221F53F7.angles;
  _id_DDBB56AE221F53F7 hide();

  while(!isDefined(level.checkpoints_count))
    waitframe();

  _id_1B13BBBC6D9A3CA3 = float(self.script_noteworthy);

  while(level.checkpoints_count < _id_1B13BBBC6D9A3CA3)
    waitframe();

  self rotateTo(_id_BC2FF14F617E1433, 2);
  wait 2;
  _id_DDBB56AE221F53F7 show();
  self hide();

  if(isDefined(_id_E3041715DACB5541)) {
    _id_25075ECD06FB88B1[0] notsolid();
    _id_25075ECD06FB88B1[1] notsolid();
    _id_F0FF756D1267B42A[0] solid();
    _id_F0FF756D1267B42A[1] solid();
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_race;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_lap1"] = 0;
    game["trial"]["analytics"]["best_lap2"] = 0;
    game["trial"]["analytics"]["best_lap3"] = 0;
  }
}

trial_dlog_race() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  time = getomnvar("ui_trial_best_time");
  _id_7705882B2C247055 = int(game["trial"]["analytics"]["best_lap1"]);
  _id_7705852B2C2469BC = int(game["trial"]["analytics"]["best_lap2"]);
  _id_7705862B2C246BEF = int(game["trial"]["analytics"]["best_lap3"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_race", ["id", id, "tier", tier, "time", time, "lap1", _id_7705882B2C247055, "lap2", _id_7705852B2C2469BC, "lap3", _id_7705862B2C246BEF]);
}

vfx_start() {
  foreach(_id_B8E70FF71A02E32D in level.course_triggers)
  _id_B8E70FF71A02E32D thread smoke_init();

  foreach(_id_B8E70FF71A02E32D in level.course_triggers_expl)
  _id_B8E70FF71A02E32D thread explosion_init();
}

smoke_init() {
  if(isDefined(level.course_triggers)) {
    foreach(trig in level.course_triggers)
    trig thread trigger_smoke_grenades();
  }
}

trigger_smoke_grenades() {
  self waittill("trigger");
  _id_CE126B8C53B9993F = scripts\engine\utility::getStructArray("trigger_smoke_origin", "script_noteworthy");
  _id_837178326DAF8AB5 = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_00B8C613BAC2D72F = scripts\engine\utility::array_intersection(_id_CE126B8C53B9993F, _id_837178326DAF8AB5);

  foreach(struct in _id_00B8C613BAC2D72F) {
    if(isDefined(struct.script_parameters))
      wait(float(struct.script_parameters));

    magicgrenademanual("smoke_grenade_mp", struct.origin, (0, 0, -0.25), 0.05);
  }
}

explosion_init() {
  if(isDefined(level.course_triggers_expl)) {
    level.explosion = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");

    foreach(trig in level.course_triggers_expl)
    trig thread trigger_explosion_grenades();
  }
}

trigger_explosion_grenades() {
  self waittill("trigger");
  _id_A2FE890F31036AF9 = getEntArray("trigger_explosion_origin", "script_noteworthy");

  foreach(_id_9FF7615509D153A8 in _id_A2FE890F31036AF9) {
    _id_9FF7615509D153A8 setModel("tag_origin");
    playFXOnTag(level.explosion, _id_9FF7615509D153A8, "TAG_ORIGIN");
    level.player playSound("iw8_cruise_missile_exp");
  }
}

fxrings() {
  level endon("trial_completed");
  wait 2;
  level scripts\engine\utility::flag_wait("trial_start");
  trigger = getEnt("StartCheckpoint", "targetname");
  level.trial_active_ring = 0;

  for(;;) {
    while(level.trial_active_ring > 3)
      waitframe();

    _id_E681932897D7F299 = spawn("script_model", trigger.origin);
    _id_E681932897D7F299 setModel("tag_origin");
    _id_E681932897D7F299.angles = trigger.angles;
    _id_E681932897D7F299 rotateby((0, 90, 0), 0.1);
    wait 1;
    trigger.fx_obj = _id_E681932897D7F299;
    playFXOnTag(scripts\engine\utility::getfx("circle"), _id_E681932897D7F299, "tag_origin");

    if(isDefined(trigger.script_noteworthy)) {
      if(trigger.script_noteworthy == "end" && level.lap == level.trial_race_lap_total) {
        _id_2E87C4E6838DF655 = getEnt(trigger.script_noteworthy, "targetname");
        _id_E681932897D7F299 = spawn("script_model", _id_2E87C4E6838DF655.origin);
        _id_E681932897D7F299 setModel("tag_origin");
        _id_E681932897D7F299.angles = _id_2E87C4E6838DF655.angles;
        _id_E681932897D7F299 rotateby((90, 0, 0), 0.1);
        wait 1;
        playFXOnTag(scripts\engine\utility::getfx("circle"), _id_E681932897D7F299, "tag_origin");
        break;
      }
    }

    waitframe();
    trigger = getEnt(trigger.target, "targetname");
    level.trial_active_ring++;
  }
}

look_at_heli() {
  level endon("trial_completed");
  self.base_angles = self.angles;
  self.shield = scripts\engine\utility::getclosest(self.origin, level.turrets_shields, 250);
  self.center = scripts\engine\utility::getclosest(self.origin, level.centers, 250);

  if(isDefined(self.shield))
    self.shield linkTo(self);

  if(isDefined(self.center))
    self.center linkTo(self);

  for(;;) {
    if(isDefined(level.atv_vehicle)) {
      if(distance(level.atv_vehicle.origin, self.origin) < level.trial_rpg_settings.rpg_max_range * 2) {
        x = level.atv_vehicle.origin[0] - self.origin[0];
        y = level.atv_vehicle.origin[1] - self.origin[1];
        z = level.atv_vehicle.origin[2] - self.origin[2];
        _id_0498454C3DF56C4D = x * x;
        _id_0498444C3DF56A1A = y * y;
        _id_0498434C3DF567E7 = z * z;
        _id_A7F942F0EBE8048F = sqrt(_id_0498454C3DF56C4D + _id_0498444C3DF56A1A);
        _id_149B4D3795D29142 = x / _id_A7F942F0EBE8048F;
        _id_96CC1618573AD3CC = acos(_id_149B4D3795D29142);
        _id_A7F943F0EBE806C2 = sqrt(_id_0498454C3DF56C4D + _id_0498434C3DF567E7);
        _id_149B4C3795D28F0F = x / _id_A7F943F0EBE806C2;
        _id_1F9A21FAFDCC408D = acos(_id_149B4C3795D28F0F);

        if(_id_1F9A21FAFDCC408D > level.trial_rpg_settings.pitch_max_angles)
          _id_1F9A21FAFDCC408D = level.trial_rpg_settings.pitch_max_angles;

        if(y < 0)
          self rotateTo((self.base_angles[0], -1 * _id_96CC1618573AD3CC, self.base_angles[2]), 0.1);
        else
          self rotateTo((self.base_angles[0], _id_96CC1618573AD3CC, self.base_angles[2]), 0.1);

        waitframe();
        self.new_angles = self.angles;

        if(z > 0)
          self rotateTo((-1 * _id_1F9A21FAFDCC408D, self.new_angles[1], self.new_angles[2]), 0.1);
      }
    }

    waitframe();
  }
}

trial_flare_watcher() {
  level endon("trial_completed");

  while(!isDefined(level.atv_vehicle) || !isDefined(level.player))
    waitframe();

  for(;;) {
    self.vehicle_has_flare = 0;
    level.player waittill("shoot_flare");
    self.vehicle_has_flare = 1;
    wait 4;
  }
}

trial_flare_destruct_missile() {
  self endon("death");

  while(!isDefined(level.player))
    waitframe();

  level.player waittill("shoot_flare");
  self detonate();
}

shoot_vehicle() {
  level endon("trial_completed");
  level waittill("trial_start");

  if(!istrue(level.trial_rpg_settings.hide_headicon)) {
    self.turret_headicon = createheadicon(self);
    setheadiconimage(self.turret_headicon, level.trial_rpg_settings.headicon_image);
    setheadiconmaxdistance(self.turret_headicon, level.trial_rpg_settings.headicon_range);
    setheadiconzoffset(self.turret_headicon, level.trial_rpg_settings.headicon_z_offset);
  }

  if(istrue(level.trial_rpg_settings.laser)) {
    self laseron();
    self.laser_on = 1;
  }

  for(;;) {
    if(isDefined(level.atv_vehicle)) {
      if(distance(level.atv_vehicle.origin, self.origin) <= level.trial_rpg_settings.rpg_max_range) {
        if(istrue(self.vehicle_has_flare)) {
          wait 1;
          continue;
        }

        missile = magicbullet(level.trial_rpg_settings.bullet, self gettagorigin(level.trial_rpg_settings.tag_to_shoot_from) + level.trial_rpg_settings.shot_start_offset, level.atv_vehicle.origin);

        if(istrue(level.trial_race_uses_heli))
          missile thread trial_flare_destruct_missile();

        self hidepart("tag_rocket");
        wait(level.trial_rpg_settings.fire_rate * 0.5);
        self showpart("tag_rocket");
        wait(level.trial_rpg_settings.fire_rate * 0.5);
      }
    }

    waitframe();
  }
}

trial_rpg_init(fire_rate, bullet, _id_7AE36A6C856293AB, headicon_range, headicon_z_offset, headicon_image, hide_headicon, tag_to_shoot_from, shot_start_offset, _id_EB9B1C94C4A70BC5, _id_8C3AB0C404DF0C22) {
  level.trial_rpg_settings = spawnStruct();

  if(isDefined(fire_rate))
    level.trial_rpg_settings.fire_rate = fire_rate;
  else
    level.trial_rpg_settings.fire_rate = 2.5;

  if(isDefined(_id_EB9B1C94C4A70BC5))
    level.trial_rpg_settings.pitch_max_angles = _id_EB9B1C94C4A70BC5;
  else
    level.trial_rpg_settings.pitch_max_angles = 35;

  if(isDefined(_id_7AE36A6C856293AB))
    level.trial_rpg_settings.rpg_max_range = _id_7AE36A6C856293AB;
  else
    level.trial_rpg_settings.rpg_max_range = 2500;

  if(isDefined(hide_headicon))
    level.trial_rpg_settings.hide_headicon = hide_headicon;
  else
    level.trial_rpg_settings.hide_headicon = 0;

  if(isDefined(headicon_range))
    level.trial_rpg_settings.headicon_range = headicon_range;
  else
    level.trial_rpg_settings.headicon_range = 4500;

  if(isDefined(headicon_z_offset))
    level.trial_rpg_settings.headicon_z_offset = headicon_z_offset;
  else
    level.trial_rpg_settings.headicon_z_offset = 40;

  if(isDefined(headicon_image))
    level.trial_rpg_settings.headicon_image = headicon_image;
  else
    level.trial_rpg_settings.headicon_image = "icon_navbar_enemy";

  if(isDefined(tag_to_shoot_from))
    level.trial_rpg_settings.tag_to_shoot_from = tag_to_shoot_from;
  else
    level.trial_rpg_settings.tag_to_shoot_from = "tag_silencer";

  if(isDefined(shot_start_offset))
    level.trial_rpg_settings.shot_start_offset = shot_start_offset;
  else
    level.trial_rpg_settings.shot_start_offset = (30, 0, 10);

  if(isDefined(bullet))
    level.trial_rpg_settings.bullet = bullet;
  else
    level.trial_rpg_settings.bullet = "iw8_la_rpapa7_mp";

  if(isDefined(_id_8C3AB0C404DF0C22))
    level.trial_rpg_settings.laser = _id_8C3AB0C404DF0C22;
  else
    level.trial_rpg_settings.laser = 1;
}