/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58308.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["race"] = &ref_129a2;
}

function ref_129a2() {
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  build_vehicle_drop_off_list();

  if(isDefined(level.ref_13d5b)) {
    level.ref_13d5a = level.ref_13d5b;
  } else {
    level.ref_13d5a = 3;
  }

  level.ref_13d90 = scripts\engine\utility::getStruct("StrucSpawnATV", "targetname");

  if(!isDefined(level.ref_13d90)) {
    level.ref_13d90 = scripts\engine\utility::getStruct("trial_vehicle_spawn", "targetname");
  }

  if(isDefined(level.ref_13d90.script_noteworthy)) {
    switch (level.ref_13d90.script_noteworthy) {
      case "little_bird":
        level.ref_13d5c = 1;
        level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird", level.ref_13d90);
        level.watchforbrsquadleadershift = 0.25;
        level.watchforcarrierdisconnect = 0.25;
        thread playerzombieprestream();
        break;
      case "tac_rover":
      default:
        level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", level.ref_13d90);
        break;
    }
  } else {
    level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", level.ref_13d90);
  }

  level.ref_13e8e = getEntArray("shield", "targetname");
  level.get_weapon_in_power_slot = getEntArray("center", "targetname");
  level.ref_12dce = getEntArray("rpg", "targetname");

  if(level.ref_12dce.size > 0) {
    if(!isDefined(level.ref_13d63)) {
      ref_13d62();
    }

    foreach(var1 in level.ref_12dce) {
      thread ref_119d9();
      thread ref_132b1();

      if(istrue(level.ref_13d5c)) {
        thread ref_13d44();
      }
    }
  }

  level.ref_12abf = getEntArray("gate_hide", "targetname");
  level.module_wait_for_level_flag = getEntArray("dyn_gate", "targetname");

  foreach(var4 in level.module_wait_for_level_flag) {
    thread module_wait_for_level_flag_set_and_clear();
  }

  level.course_triggers = getEntArray("progression", "targetname");
  level.in_world_scriptables_visible = getEntArray("progressionfire", "targetname");

  if(game["trial"]["tries_remaining"] < level.trial["attempts"]) {
    level.ref_13d69 = level.check_for_early_impact;
  }

  scripts\engine\utility::getstructarray_delete("atv_spawn", "targetname");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_in_progress");
  level scripts\engine\utility::flag_init("trial_player_death");
  level scripts\engine\utility::flag_init("trial_start");
  level scripts\engine\utility::flag_init("player_not_on_vehicle");
  level scripts\engine\utility::flag_init("gate_flares_0");
  thread ref_13eef();
  thread ref_13d48();

  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3) {
    wait 11;
  }

  thread dialog_init();
  thread ref_1299f();
  thread player_is_faux_dead();
  thread player_monitor_death();
  thread ref_137ee();
  thread ref_12479();
  ref_142a9();
  var6 = getEntArray("traficcone", "targetname");

  foreach(var8 in var6) {
    var8 notsolid();
  }

  level.ref_13d3b = [];
  _tablethide::waittill_player_isDefined();
  waitframe();
  level.ref_13d91 = scripts\mp\utility\outline::outlineenableforplayer(level.check_for_early_impact, level.player, "outline_trial_item", "level_script");

  if(istrue(level.ref_13d2f)) {
    var10 = getEntArray("OutOfBounds", "targetname");

    foreach(var12 in var10) {
      var12 scripts\engine\utility::trigger_off();
    }
  }

  thread ref_1299d();

  foreach(var15 in level.ref_13d3b) {
    thread make_use_prompt();
  }

  setomnvar("ui_trial_objective_total", level.ref_13d3b.size);
  level.nosuspensemusic = 1;

  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");
    wait 8;
    return;
  }
}

function ref_13d48() {
  if(issubstr(level.trial["zone"], "_gw") && game["trial"]["tries_remaining"] == 3) {
    while(!isalive(level.player)) {
      waitframe();
    }

    wait 1;
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
    var0 = newhudelem();
    var0.x = 0;
    var0.y = 0;
    var0 setshader("black", 640, 480);
    var0.alignx = "left";
    var0.aligny = "top";
    var0.sort = 1;
    var0.horzalign = "fullscreen";
    var0.vertalign = "fullscreen";
    var0.foreground = 1;
    var0.alpha = 1;
    wait 22;
    var0.alpha = 1;
    var0 fadeovertime(4);
    var0.alpha = 0;
    level.player freezecontrols(0);
    level.player freezelookcontrols(0);
    return;
  }
}

function ref_137ee() {
  var0 = getEnt("StartWaypoint", "targetname");
  _tablethide::waittill_player_isDefined();

  while(!isDefined(level.player.vehicle)) {
    waitframe();
  }

  level scripts\engine\utility::flag_set("trial_start");
  scripts\mp\utility\outline::outlinedisable(level.ref_13d91, level.check_for_early_impact);
  _tablethide::ref_13d88();

  if(!istrue(level.ref_13d5c)) {
    level.player allowmovement(0);
    level.player freezecontrols(1);
    wait 1.5;
  }

  level.ref_13d4a = var0.origin;
  level.ref_13d49 = thread ref_13563();
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 3);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level scripts\engine\utility::flag_set("gate_flares_0");
  level.player playSound("trial_sfx_start");
  setmusicstate("");

  if(!istrue(level.ref_13d5c)) {
    level.player allowmovement(1);
    level.player freezecontrols(0);
  }

  level scripts\engine\utility::flag_set("trial_in_progress");
  thread light_tank_addgunnerdamagemod();
  thread ref_14189();
  _tablethide::ref_13d89(0);
  hud_timer();
}

function ref_1299f() {
  level endon("trial_completed");
  level.waitingtoplayreviveanimation = [];
  level.ref_13d4a = (0, 0, 0);
  level.ref_11f81 = (0, 0, 0);
  level scripts\engine\utility::flag_wait("trial_start");
  var0 = getEnt("StartCheckpoint", "targetname");
  level.initlocs_test = var0;
  var0 waittill("trigger");

  if(isDefined(level.initlocs_test.playerzombiegasthink)) {
    level.player playSound("trial_sfx_success");
    stopFXOnTag(scripts\engine\utility::getfx("circle"), level.initlocs_test.playerzombiegasthink, "tag_origin");
    level.initlocs_test.playerzombiegasthink delete();
  }

  if(isDefined(level.ref_13d22)) {
    level.ref_13d22--;
  }

  var1 = getEnt(level.initlocs_test.target, "targetname");
  level.ref_13d4a = var1.origin;
  level.ref_11f81 = var1.origin;

  if(isDefined(level.ref_13d49)) {
    level.ref_13d49 moveTo(level.ref_13d4a, 0.5, 0.1, 0.3);
  }

  var2 = thread ref_135a8();
  level.player setclientomnvar("ui_edge_glow_trials", 255);
  level.player scripts\engine\utility::delaycall(0.5, &setclientomnvar, "ui_edge_glow_trials", 0);

  for(;;) {
    var1 waittill("trigger");

    if(isDefined(level.ref_13d22)) {
      level.ref_13d22--;
    }

    level.getquestrewardbuildgroupref++;
    level.ref_13b9a = 0;
    level.ref_13b9c = 6;
    level.initlocs_test = var1;

    if(isDefined(level.initlocs_test.playerzombiegasthink)) {
      stopFXOnTag(scripts\engine\utility::getfx("circle"), level.initlocs_test.playerzombiegasthink, "tag_origin");
      level.initlocs_test.playerzombiegasthink delete();
    }

    if(isDefined(level.initlocs_test.script_noteworthy) && level.waiting_for_tactical_restock == level.ref_13d5a) {
      if(level.initlocs_test.script_noteworthy == "end") {
        var1 = getEnt(level.initlocs_test.script_noteworthy, "targetname");
      }
    } else {
      var1 = getEnt(level.initlocs_test.target, "targetname");
    }

    level.player notify("newcheckpoint");
    level.player setclientomnvar("ui_edge_glow_trials", 255);
    level.player scripts\engine\utility::delaycall(0.5, &setclientomnvar, "ui_edge_glow_trials", 0);

    if(level.initlocs_test.targetname == "StartCheckpoint" || level.initlocs_test.targetname == "end" || level.initlocs_test.targetname == "lap" && level.waiting_for_tactical_restock < level.ref_13d5a) {
      level.ref_13d4e = gettime() - gettime() % 100 - level.ref_137c9;
      level.waitingtoplayreviveanimation = scripts\engine\utility::array_add(level.waitingtoplayreviveanimation, level.ref_13d4e);

      if(level.waiting_for_tactical_restock >= level.ref_13d5a) {
        if(level.ref_13d5a == 1) {
          _tablethide::trial_ui_set_stat_and_bonus_time(level.waiting_for_tactical_restock, "lap_" + level.waiting_for_tactical_restock + "_time", level.waitingtoplayreviveanimation[level.waiting_for_tactical_restock - 1], 0);
        }

        level.player.vehicle vehicle_turnengineoff();
        level scripts\engine\utility::flag_set("trial_completed");
      } else {
        level.ref_137c9 = gettime() - gettime() % 100;
        _tablethide::trial_ui_set_stat_and_bonus_time(level.waiting_for_tactical_restock, "lap_" + level.waiting_for_tactical_restock + "_time", level.waitingtoplayreviveanimation[level.waiting_for_tactical_restock - 1], 0);
        level.player playSound("trial_sfx_start");
        setmusicstate("");
        level.waiting_for_tactical_restock++;
        var3 = "trial_lap_" + level.waiting_for_tactical_restock;
        _tablethide::ref_13d8d(level.waiting_for_tactical_restock, level.ref_13d5a);
        ref_142a9();

        if(level.waiting_for_tactical_restock == level.ref_13d5a) {
          var3 = "trial_lap_final";
          var4 = ["race_final_lap", "race_one_lap"];
          level.player scripts\mp\utility\dialog::leaderdialogonplayer(scripts\engine\utility::random(var4));
        }

        if(level.ref_13d4e <= (level.trial["tier3"] + level.dogtags.size / 2 * 1000) / level.ref_13d5a) {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_good_lap");
        } else if(level.ref_13d4e >= (level.trial["tier1"] + level.dogtags.size * 1000) / level.ref_13d5a) {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_bad_lap");
        }

        level.player thread scripts\mp\hud_message::showsplash(var3);
        level.make_fly_struct = 0;
      }
    } else {
      level.player playSound("trial_sfx_success");
    }

    level.ref_13d4a = var1.origin;
    level.ref_11f81 = var1.origin;
    level.ref_13d49 moveTo(level.ref_13d4a, 0.5, 0.1, 0.3);
    thread ref_135a8();
  }
}

function player_is_faux_dead() {
  var0 = getEntArray("gate_flare", "targetname");

  if(isDefined(var0[0]) && var0[0].model == "misc_wm_flarestick") {
    var1 = "j_cap";
  } else {
    var1 = "TAG_FIRE_FX";
  }

  foreach(var3 in var1) {
    var4 = var3 gettagangles(var1);
    var5 = var3 gettagorigin(var1);
    var6 = spawn("script_model", var5);
    var6.angles = var4;
    var6 linkTo(var3, var1, (1, 0, 0), (90, 0, 0));
    var6 setModel("tag_origin");
    var7 = spawn("script_model", var5);
    var7.angles = var4;
    var7 linkTo(var3, var1, (0, 0, -1.75), (0, 180, 0));
    var7 setModel("tag_origin");
    scripts\engine\utility::flag_init("gate_flares_" + var3.script_noteworthy);
    thread pointinsquarewidth(var3.script_noteworthy, var6, var7);
  }
}

function pointinsquarewidth(var0, var1, var2) {
  level endon("trial_completed");

  for(;;) {
    scripts\engine\utility::flag_wait("gate_flares_" + var0);
    playFXOnTag(level.ref_142a5, var1, "TAG_ORIGIN");
    playFXOnTag(level.ref_14297, var2, "TAG_ORIGIN");

    while(scripts\engine\utility::flag("gate_flares_" + var0)) {
      waitframe();
    }

    stopFXOnTag(level.ref_142a5, var1, "TAG_ORIGIN");
    stopFXOnTag(level.ref_14297, var2, "TAG_ORIGIN");
  }
}

function ref_12479() {
  level scripts\engine\utility::flag_wait("trial_completed");
  thread _tablethide::ref_13d8a(0);
  level.player allowmovement(0);
  level.player freezecontrols(1);
  level notify("stop_timer");

  if(!scripts\engine\utility::flag("trial_player_death")) {
    if(level.ref_13d5a == 0) {}

    for(var0 = 2; var0 <= level.ref_13d5a; var0++) {
      _tablethide::trial_ui_set_stat_and_bonus_time(var0, "lap_" + var0 + "_time", level.waitingtoplayreviveanimation[var0 - 1], 0);
    }

    if(level.ref_13d3b.size > 0) {
      _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13d5a + 1, "dogtag_collected", level.make_exhaust_affect_players, level.ref_13b6a * -1);

      if(level.make_exhaust_affect_players == level.ref_13d3b.size) {
        _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13d5a + 2, "all_dogtag_collected", 0, -5000);
        level.intel_use_logic -= 5000;
      }
    }

    scripts\engine\utility::delaythread(3, &_tablethide::trial_ui_set_subtime, level.intel_spawn_listener);
    _tablethide::trial_ui_set_main_time(level.intel_use_logic);

    if(level.intel_use_logic <= level.trial["tier3"]) {
      level.reward_tier = 3;
    } else if(level.intel_use_logic <= level.trial["tier2"]) {
      level.reward_tier = 2;
    } else if(level.intel_use_logic <= level.trial["tier1"]) {
      level.reward_tier = 1;
    } else {
      level.reward_tier = 0;
    }

    var1 = game["trial"]["best_reward"];

    if(level.reward_tier > var1) {
      game["trial"]["best_reward"] = level.reward_tier;
      _tablethide::trial_ui_set_reward_tier(level.reward_tier);
    }

    var2 = game["trial"]["best_time"];

    if(game["trial"]["best_time"] <= 0 || level.intel_use_logic < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = level.intel_use_logic;
      hud_besttime_update();
      game["trial"]["analytics"]["best_lap1"] = level.waitingtoplayreviveanimation[0];

      if(isDefined(level.waitingtoplayreviveanimation[1])) {
        game["trial"]["analytics"]["best_lap2"] = level.waitingtoplayreviveanimation[1];
      }

      if(isDefined(level.waitingtoplayreviveanimation[2])) {
        game["trial"]["analytics"]["best_lap3"] = level.waitingtoplayreviveanimation[2];
      }
    }

    if(level.reward_tier == 3) {
      var3 = game["music"]["trials_win_high"].size;
      var4 = randomint(var3);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var4]);
    } else if(level.reward_tier == 2) {
      var3 = game["music"]["trials_win_mid"].size;
      var4 = randomint(var3);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var4]);
    } else if(level.reward_tier == 1) {
      var3 = game["music"]["trials_win_low"].size;
      var4 = randomint(var3);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var4]);
    } else {
      var3 = game["music"]["trials_loss"].size;
      var4 = randomint(var3);
      level.player setplayermusicstate(game["music"]["trials_loss"][var4]);
    }
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
    setomnvar("ui_trial_failed", 1);

    if(level.ref_13d3b.size > 0) {
      _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13d5a + 1, "dogtag_collected", 0, 0);
    }

    level.player playSound("trial_sfx_failure");
    var3 = game["music"]["trials_loss"].size;
    var4 = randomint(var3);
    level.player setplayermusicstate(game["music"]["trials_loss"][var4]);
    level.ref_13d6a = 1;
    var5 = 1.25;
    hud_fade_to_black(var5);
    wait var5;

    if(isDefined(level.check_for_early_impact)) {
      level.check_for_early_impact delete();
    }
  }

  waitframe();
  _tablethide::trial_ui_open_results_screen();
  level.ref_13d60 = 1;
  _tablethide::trial_ui_waittill_retry();
  var6 = game["trial"]["tries_remaining"];

  if(var6 > 0) {
    _tablethide::ref_13d5e();
    return;
  }
}

function player_monitor_death() {
  _tablethide::waittill_player_isDefined();
  level.player waittill("death");
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  scripts\engine\utility::flag_set("trial_player_death");
  scripts\engine\utility::flag_set("trial_completed");
}

function ref_13eef() {
  if(!isDefined(game["trial"]["best_reward"])) {
    game["trial"]["best_reward"] = 0;
  }

  if(isDefined(level.ref_13d3a)) {
    var0 = level.ref_13d3a;
  } else {
    var0 = "dogtag_spawn";
  }

  level.waiting_for_tactical_restock = 1;
  level.make_exhaust_affect_players = 0;
  level.make_fly_struct = 0;
  level.dogtags = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  level.ref_13b6a = 0;
  level.getquestrewardbuildgroupref = 1;
  _tablethide::ref_13d8d(level.waiting_for_tactical_restock, level.ref_13d5a);
  _tablethide::trial_ui_set_subtime(0);
  _tablethide::trial_ui_set_reward_tier_preview(3);
  thread check_for_at_set_final_wave();
  thread hud_besttime_update();
  thread hud_reward_tiers_tracking();
  thread spawn_speed();
  thread spawn_size();
}

function hud_timer() {
  level endon("trial_completed");
  level.intel_spawn_listener = 0;
  level.intel_use_logic = 0;
  level.ref_137c9 = gettime() - gettime() % 100;

  for(;;) {
    var0 = gettime() - gettime() % 100;
    waitframe();

    while(!scripts\engine\utility::flag("trial_completed")) {
      level.intel_spawn_listener = gettime() - gettime() % 100 - var0;
      level.intel_use_logic = level.intel_spawn_listener - level.ref_13b6a;

      if(level.intel_use_logic < 0) {
        _tablethide::trial_ui_set_subtime(0);
      } else {
        _tablethide::trial_ui_set_subtime(level.intel_use_logic);
      }

      waitframe();
    }
  }

  waitframe();
}

function spawn_size() {
  for(var0 = 1; var0 <= level.ref_13d5a; var0++) {
    _tablethide::trial_ui_set_stat_and_bonus_time(var0, "lap_" + var0 + "_time", 0, 0);
  }

  if(level.dogtags.size > 0) {
    _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13d5a + 1, "dogtag_collected", level.make_exhaust_affect_players, level.ref_13b6a * -1);
    return;
  }
}

function spawn_speed() {
  self endon("stop_timer");

  while(!isDefined(level.intel_use_logic)) {
    waitframe();
  }

  for(;;) {
    if(level.intel_use_logic > level.trial["tier3"] - 5000 && level.intel_use_logic < level.trial["tier3"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    if(level.intel_use_logic > level.trial["tier2"] - 5000 && level.intel_use_logic < level.trial["tier2"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    if(level.intel_use_logic > level.trial["tier1"] - 5000 && level.intel_use_logic < level.trial["tier1"]) {
      level.player playSound("trial_sfx_failure_countdown");
      wait 1;
      continue;
    }

    waitframe();
  }
}

function hud_reward_tiers_tracking() {
  self endon("stop_timer");
  self waittill("trial_in_progress");
  var0 = 5;
  var1 = [];
  var1[0] = undefined;
  GscBinSkip0(0x2e, 1, level.trial["tier1"]);
}

function hud_besttime_update() {
  var0 = game["trial"]["best_time"];
  var1 = game["trial"]["best_reward"];
  _tablethide::trial_ui_set_best_time(var0);
  _tablethide::trial_ui_set_reward_tier(var1);
}

function hud_fade_to_black(var0, var1) {
  var2 = newhudelem();
  var2.x = 0;
  var2.y = 0;
  var2 setshader("black", 640, 480);
  var2.alignx = "left";
  var2.aligny = "top";
  var2.sort = 1;
  var2.horzalign = "fullscreen";
  var2.vertalign = "fullscreen";
  var2.foreground = 1;

  if(istrue(var1)) {
    var2.alpha = 1;
    var2 fadeovertime(var0);
    var2.alpha = 0;
    return;
  }

  var2.alpha = 0;
  var2 fadeovertime(var0);
  var2.alpha = 1;
}

function ref_13563() {
  var0 = spawn("script_model", level.ref_13d4a);
  var0 setModel("tag_origin");
  level.ref_14537 = deleteheadicon(var0);
  setheadiconfriendlyimage(level.ref_14537, "icon_waypoint_marker");
  setheadiconzoffset(level.ref_14537, 1);
  setheadiconsnaptoedges(level.ref_14537, 0);
  setheadicondrawthroughgeo(level.ref_14537, 1);
  setheadiconmaxdistance(level.ref_14537, 0);
  addclienttoheadiconmask(level.ref_14537, -50);
  return var0;
}

function ref_135a8() {
  if(!isDefined(level.ref_1453a)) {
    level.ref_1453a = scripts\mp\objidpoolmanager::requestobjectiveid(10);
  }

  objective_state(level.ref_1453a, "active");
  objective_position(level.ref_1453a, level.ref_11f81);
  objective_setplayintro(level.ref_1453a, 0);
  objective_icon(level.ref_1453a, "icon_waypoint_marker");
  objective_setbackground(level.ref_1453a, 1);
  objective_setfadedisabled(level.ref_1453a, 0);
  objective_setshowoncompass(level.ref_1453a, 1);
  objective_setminimapiconsize(level.ref_1453a, "icon_regular");
  objective_setshowdistance(level.ref_1453a, 0);
  objective_ping(level.ref_1453a);
  objective_setownerteam(level.ref_1453a, level.player.team);
  level scripts\engine\utility::flag_wait("trial_completed");
  objective_delete(level.ref_1453a);
}

function dialog_init() {
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

function light_tank_addgunnerdamagemod() {
  level endon("trial_completed");
  level.ref_13b9a = 0;
  level.ref_13b9c = 6;

  for(;;) {
    while(level.ref_13b9a < level.ref_13b9c) {
      wait 1;
      level.ref_13b9a++;
    }

    if(isDefined(level.player.vehicle)) {
      if(randomint(100) < 30) {
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_move_to_next_checkpoint");
      } else {
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("race_speed_it_up");
      }

      level.ref_13b9c += 3;
    }

    level.ref_13b9a = 0;
    waitframe();
  }
}

function ref_14189() {
  level endon("trial_completed");

  for(;;) {
    thread _tablethide::ref_13d8a(0);

    while(isDefined(level.player.vehicle)) {
      waitframe();
    }

    thread _tablethide::ref_13d8a(1);
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("race_use_atv");

    while(!isDefined(level.player.vehicle)) {
      waitframe();
    }
  }
}

function molotov_can_cast_this_frame() {
  if(self.target == "show") {
    self hide();
  }

  while(!isDefined(level.getquestrewardbuildgroupref)) {
    waitframe();
  }

  for(;;) {
    if(level.getquestrewardbuildgroupref == float(self.script_noteworthy)) {
      switch (self.target) {
        case "show":
          self show();
          break;
        case "hide":
          self hide();
          break;
        default:
          break;
      }

      return;
    }

    waitframe();
  }
}

function check_for_at_set_final_wave() {
  level endon("trial_completed");
  _tablethide::waittill_player_isDefined();

  for(;;) {
    var0 = scripts\mp\utility\outline::outlineenableforplayer(level.check_for_early_impact, level.player, "outline_trial_vehicle", "level_script");

    while(!isDefined(level.player.vehicle)) {
      waitframe();
    }

    scripts\mp\utility\outline::outlinedisable(var0, level.check_for_early_impact);

    while(isDefined(level.player.vehicle)) {
      waitframe();
    }

    waitframe();
  }
}

function ref_1299d() {
  foreach(var1 in level.dogtags) {
    thread ref_135bb(var1, var1);
  }
}

function ref_135bb(var0, var1) {
  var2 = 14;
  var3 = (0, 0, 0);
  var4 = var0.angles;

  if(var0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var4 = var0 getworldupreferenceangles();
    var3 = anglestoup(var4);

    if(var3[2] < 0) {
      var2 = -14;
    }
  }

  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
}

function make_use_prompt() {
  level endon("trial_completed");
  self endon("willdelete");
  var0 = getEnt(self.victim.targetname, "target");

  while(isDefined(self)) {
    scripts\mp\gameobjects::disableobject();
    self.visuals[0] hide();
    level scripts\engine\utility::flag_wait("trial_start");

    if(int(self.visuals[0].waiting_to_connect) == 1 && var0.targetname == "StartCheckpoint" && level.getquestrewardbuildgroupref == 1) {
      scripts\mp\gameobjects::enableobject();
      self.visuals[0] show();
    }

    var0 waittill("trigger");

    if(int(self.visuals[0].waiting_to_connect) == level.waiting_for_tactical_restock && var0.targetname == level.initlocs_test.targetname) {
      var1 = distance(self.visuals[0].origin, level.player.origin);
      var2 = var1 / 10000;
      self.visuals[0] scripts\engine\utility::delaycall(var2, &show);
      scripts\engine\utility::delaythread(var2, &scripts\mp\gameobjects::enableobject);
      playsoundatpos(self.visuals[0].origin, "mp_killconfirm_tags_drop");
      waitframe();
      level.player waittill("newcheckpoint");
      waitframe();
    }
  }
}

function module_wait_for_level_flag_set_and_clear() {
  var0 = scripts\engine\utility::getclosest(self.origin, getEntArray("col1", "targetname"), 250);
  var1 = scripts\engine\utility::getclosest(self.origin, getEntArray("col2", "targetname"), 250);
  var2 = scripts\engine\utility::getclosest(self.origin, level.ref_12abf, 100);

  if(isDefined(var1)) {
    var1 notsolid();
  }

  var3 = var2.angles;
  var2 hide();

  while(!isDefined(level.getquestrewardbuildgroupref)) {
    waitframe();
  }

  var4 = float(self.script_noteworthy);

  while(level.getquestrewardbuildgroupref < var4) {
    waitframe();
  }

  self rotateTo(var3, 2);
  wait 2;
  var2 show();
  self hide();

  if(isDefined(var0)) {
    var0 notsolid();

    if(isDefined(var1)) {
      var1 solid();
      return;
    }

    return;
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d38;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_lap1"] = 0;
    game["trial"]["analytics"]["best_lap2"] = 0;
    game["trial"]["analytics"]["best_lap3"] = 0;
    return;
  }
}

function ref_13d38() {
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_time");
  var3 = int(game["trial"]["analytics"]["best_lap1"]);
  var4 = int(game["trial"]["analytics"]["best_lap2"]);
  var5 = int(game["trial"]["analytics"]["best_lap3"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_race", ["id", var0, "tier", var1, "time", var2, "lap1", var3, "lap2", var4, "lap3", var5]);
}

function ref_142a9() {
  foreach(var1 in level.course_triggers) {
    thread ref_13422();
  }

  foreach(var1 in level.in_world_scriptables_visible) {
    thread onteamproximitysteppedfar();
  }
}

function ref_13422() {
  if(isDefined(level.course_triggers)) {
    foreach(var1 in level.course_triggers) {
      thread ref_13daf();
    }

    return;
  }
}

function ref_13daf() {
  level waittill("trial_start");
  self waittill("trigger");
  var0 = scripts\engine\utility::getStructArray("trigger_smoke_origin", "script_noteworthy");
  var1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var2 = scripts\engine\utility::array_intersection(var0, var1);

  foreach(var4 in var2) {
    if(isDefined(var4.script_parameters)) {
      wait float(var4.script_parameters);
    }

    magicgrenademanual("smoke_grenade_mp", var4.origin, (0, 0, -0.25), 0.05);
  }
}

function onteamproximitysteppedfar() {
  if(isDefined(level.in_world_scriptables_visible)) {
    level.explosion = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");

    foreach(var1 in level.in_world_scriptables_visible) {
      thread ref_13da4();
    }

    return;
  }
}

function ref_13da4() {
  self waittill("trigger");
  var0 = getEntArray("trigger_explosion_origin", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setModel("tag_origin");
    playFXOnTag(level.explosion, var2, "TAG_ORIGIN");
    level.player playSound("iw8_cruise_missile_exp");
  }
}

function playerzombieprestream() {
  level endon("trial_completed");
  wait 2;
  level scripts\engine\utility::flag_wait("trial_start");
  var0 = getEnt("StartCheckpoint", "targetname");
  level.ref_13d22 = 0;

  for(;;) {
    while(level.ref_13d22 > 3) {
      waitframe();
    }

    var1 = spawn("script_model", var0.origin);
    var1 setModel("tag_origin");
    var1.angles = var0.angles;
    var1 rotateby((0, 90, 0), 0.1);
    wait 1;
    var0.playerzombiegasthink = var1;
    playFXOnTag(scripts\engine\utility::getfx("circle"), var1, "tag_origin");

    if(isDefined(var0.script_noteworthy)) {
      if(var0.script_noteworthy == "end" && level.waiting_for_tactical_restock == level.ref_13d5a) {
        var2 = getEnt(var0.script_noteworthy, "targetname");
        var1 = spawn("script_model", var2.origin);
        var1 setModel("tag_origin");
        var1.angles = var2.angles;
        var1 rotateby((90, 0, 0), 0.1);
        wait 1;
        playFXOnTag(scripts\engine\utility::getfx("circle"), var1, "tag_origin");
        break;
      }
    }

    waitframe();
    var0 = getEnt(var0.target, "targetname");
    level.ref_13d22++;
  }
}

function ref_119d9() {
  level endon("trial_completed");
  self.choppersupport_watchleash = self.angles;
  self.ref_132a7 = scripts\engine\utility::getclosest(self.origin, level.ref_13e8e, 250);
  self.center = scripts\engine\utility::getclosest(self.origin, level.get_weapon_in_power_slot, 250);

  if(isDefined(self.ref_132a7)) {
    self.ref_132a7 linkTo(self);
  }

  if(isDefined(self.center)) {
    self.center linkTo(self);
  }

  for(;;) {
    if(isDefined(level.check_for_early_impact)) {
      if(distance(level.check_for_early_impact.origin, self.origin) < level.ref_13d63.ref_12dc8 * 2) {
        var0 = level.check_for_early_impact.origin[0] - self.origin[0];
        var1 = level.check_for_early_impact.origin[1] - self.origin[1];
        var2 = level.check_for_early_impact.origin[2] - self.origin[2];
        var3 = var0 * var0;
        var4 = var1 * var1;
        var5 = var2 * var2;
        var6 = sqrt(var3 + var4);
        var7 = var0 / var6;
        var8 = acos(var7);
        var9 = sqrt(var3 + var5);
        var10 = var0 / var9;
        var11 = acos(var10);

        if(var11 > level.ref_13d63.ref_12380) {
          var11 = level.ref_13d63.ref_12380;
        }

        if(var1 < 0) {
          self rotateTo((self.choppersupport_watchleash[0], -1 * var8, self.choppersupport_watchleash[2]), 0.1);
        } else {
          self rotateTo((self.choppersupport_watchleash[0], var8, self.choppersupport_watchleash[2]), 0.1);
        }

        waitframe();
        self.ref_11e57 = self.angles;

        if(var2 > 0) {
          self rotateTo((-1 * var11, self.ref_11e57[1], self.ref_11e57[2]), 0.1);
        }
      }
    }

    waitframe();
  }
}

function ref_13d44() {
  level endon("trial_completed");

  while(!isDefined(level.check_for_early_impact) || !isDefined(level.player)) {
    waitframe();
  }

  for(;;) {
    self.ref_14196 = 0;
    level.player waittill("shoot_flare");
    self.ref_14196 = 1;
    wait 4;
  }
}

function ref_13d43() {
  self endon("death");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player waittill("shoot_flare");
  self detonate();
}

function ref_132b1() {
  level endon("trial_completed");
  level waittill("trial_start");

  if(!istrue(level.ref_13d63.spawn_assault2_extras)) {
    self.ref_13e70 = deleteheadicon(self);
    setheadiconfriendlyimage(self.ref_13e70, level.ref_13d63.showclosingmessage);
    setheadiconsnaptoedges(self.ref_13e70, level.ref_13d63.showdangercircle);
    addclienttoheadiconmask(self.ref_13e70, level.ref_13d63.showdiscountsplash);
  }

  if(istrue(level.ref_13d63.laser)) {
    self laseron();
    self.laser_on = 1;
  }

  for(;;) {
    if(isDefined(level.check_for_early_impact)) {
      if(distance(level.check_for_early_impact.origin, self.origin) <= level.ref_13d63.ref_12dc8) {
        if(istrue(self.ref_14196)) {
          wait 1;
          continue;
        }

        var0 = magicbullet(level.ref_13d63.fixupscriptableorigin, self gettagorigin(level.ref_13d63.ref_13a23) + level.ref_13d63.ref_132b9, level.check_for_early_impact.origin);

        if(istrue(level.ref_13d5c)) {
          thread ref_13d43();
        }

        self hidepart("tag_rocket");
        wait level.ref_13d63.playanim_vehicleturret * 0.5;
        self showpart("tag_rocket");
        wait level.ref_13d63.playanim_vehicleturret * 0.5;
      }
    }

    waitframe();
  }
}

function ref_13d62(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  level.ref_13d63 = spawnStruct();

  if(isDefined(var0)) {
    level.ref_13d63.playanim_vehicleturret = var0;
  } else {
    level.ref_13d63.playanim_vehicleturret = 2.5;
  }

  if(isDefined(var9)) {
    level.ref_13d63.ref_12380 = var9;
  } else {
    level.ref_13d63.ref_12380 = 35;
  }

  if(isDefined(var2)) {
    level.ref_13d63.ref_12dc8 = var2;
  } else {
    level.ref_13d63.ref_12dc8 = 2500;
  }

  if(isDefined(var6)) {
    level.ref_13d63.spawn_assault2_extras = var6;
  } else {
    level.ref_13d63.spawn_assault2_extras = 0;
  }

  if(isDefined(var3)) {
    level.ref_13d63.showdangercircle = var3;
  } else {
    level.ref_13d63.showdangercircle = 4500;
  }

  if(isDefined(var4)) {
    level.ref_13d63.showdiscountsplash = var4;
  } else {
    level.ref_13d63.showdiscountsplash = 40;
  }

  if(isDefined(var5)) {
    level.ref_13d63.showclosingmessage = var5;
  } else {
    level.ref_13d63.showclosingmessage = "icon_navbar_enemy";
  }

  if(isDefined(var7)) {
    level.ref_13d63.ref_13a23 = var7;
  } else {
    level.ref_13d63.ref_13a23 = "tag_silencer";
  }

  if(isDefined(var8)) {
    level.ref_13d63.ref_132b9 = var8;
  } else {
    level.ref_13d63.ref_132b9 = (30, 0, 10);
  }

  if(isDefined(var1)) {
    level.ref_13d63.fixupscriptableorigin = var1;
  } else {
    level.ref_13d63.fixupscriptableorigin = "iw8_la_rpapa7_mp";
  }

  if(isDefined(var10)) {
    level.ref_13d63.laser = var10;
    return;
  }

  level.ref_13d63.laser = 1;
}