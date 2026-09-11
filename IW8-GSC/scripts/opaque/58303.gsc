/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58303.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["arm_course"] = &init;
}

function init() {
  _tablethide::trial_ui_set_subscore(0);
  dialog_init();
  setDvar("scr_game_matchstarttime", 1);
  setDvar("scr_localeID", -1);
  level.ref_13d73 = &ref_12f00;
  level.ref_13d71 = &ref_12eff;
  level.ref_13d76 = &ref_12f02;
  level.ref_13d7a = &ref_13a60;
  level.ref_13d7b = &ref_13a5b;
  level.ref_13d84 = &ref_12f05;
  level.ref_13d85 = &turret_think;
  level.civilian_targets = [];
  level.enemy_targets = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = _stop_spawn_modules::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.ref_13d92 = scripts\engine\utility::getStructArray("trial_atv_spawn", "targetname");
  ref_12f06();
  build_vehicle_drop_off_list();
  set_wave_num();

  foreach(var1 in level.ref_13d92) {
    thread ref_1418e();
  }

  foreach(var4 in level.course_triggers) {
    var4 thread _stop_spawn_modules::ref_13d82();
  }

  foreach(var4 in level.course_targets) {
    var4 thread _stop_spawn_modules::ref_13d79();
  }

  level.ref_13a94 = 1;
  thread ref_124d9();
  thread progression();
}

function set_wave_num() {
  scripts\mp\gametypes\arm::seticonnames();

  if(level.trial["team"] == "allies") {
    level.ref_13d56 = "axis";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_neutral = [];
  } else {
    level.ref_13d56 = "allies";
    level.startingfobnames_allies = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [];
  }

  level.gw_objstruct = spawnStruct();
  scripts\mp\gametypes\arm::setupobjectives();

  if(level.trial["team"] == "allies") {
    var0 = level.gw_objstruct.startingfobs_axis;
  } else {
    var0 = level.gw_objstruct.startingfobs_allies;
  }

  level.allfobs = [];
  level.bridge_one_death_func = [];

  foreach(var2 in var0) {
    thread playerfadeobjdelete();
  }

  thread audio_enablepa();
}

function playerfadeobjdelete() {
  level.allfobs[level.allfobs.size] = self;
  level.bridge_one_death_func[level.bridge_one_death_func.size] = self.trigger;
  self.trigger.playerexitsafearea = self;
  self.activated = 0;

  while(!istrue(level.ref_13a94)) {
    waitframe();
  }

  self.targets = getEntArray("fob_target" + self.trigger.objkey, "targetname");

  foreach(var1 in self.targets) {
    if(istrue(var1.is_civilian)) {
      self.targets = scripts\engine\utility::array_remove(self.targets, var1);
    }
  }

  if(self.targets.size == 0) {
    return;
  }

  self.objective = scripts\mp\gameobjects::createobjidobject(self.trigger.origin, "neutral", (0, 0, 100), undefined, "any");
  var3 = "waypoint_capture" + self.trigger.objkey;
  scripts\mp\objidpoolmanager::update_objective_icon(self.objective.objidnum, scripts\mp\gameobjects::getwaypointshader(var3));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objective.objidnum, scripts\mp\gameobjects::getwaypointbackgroundtype(var3));
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.ref_13d56);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 1);

  for(;;) {
    if(isDefined(level.ref_13d21) && self == level.ref_13d21) {
      objective_state(self.objective.objidnum, "invisible");
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 0);
    } else {
      objective_state(self.objective.objidnum, "current");
    }

    var4 = 0;

    foreach(var1 in self.targets) {
      if(var1.activated && !istrue(var1.is_civilian)) {
        scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 1);
        var4++;
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(self.objective.objidnum, var4 / self.targets.size);

    if(var4 >= self.targets.size) {
      break;
    }

    waitframe();
  }

  self.activated = 1;
  scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.trial["team"]);
  wait 1;
  ref_12f01();
}

function audio_enablepa() {
  level waittill("course_started");

  for(;;) {
    var0 = scripts\engine\utility::getclosest(level.player.origin, level.enemy_targets, 1000);

    if(isDefined(var0)) {
      level.ref_13d21 = var0.playerexitsafearea;
    } else {
      level.ref_13d21 = undefined;
    }

    waitframe();
  }
}

function ref_13a5b() {
  for(;;) {
    if(!self.activated && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
      var0 = scripts\mp\gameobjects::createobjidobject(self.origin, level.ref_13d56, (0, 0, 0), undefined, "any");
      objective_state(var0.objidnum, "active");
      objective_setplayintro(var0.objidnum, 0);

      if(!istrue(self.is_civilian)) {
        objective_icon(var0.objidnum, "icon_minimap_enemy");
      }

      objective_setbackground(var0.objidnum, 1);
      objective_setfadedisabled(var0.objidnum, 0);
      objective_setshowoncompass(var0.objidnum, 1);
      objective_setminimapiconsize(var0.objidnum, "icon_regular");
      objective_setshowdistance(var0.objidnum, 0);
      objective_setownerteam(var0.objidnum, level.ref_13d56);

      if(!istrue(self.is_civilian)) {
        thread ref_13a66();
      }

      while(!self.activated && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
        waitframe();
      }

      scripts\mp\objidpoolmanager::returnobjectiveid(var0.objidnum);
    }

    waitframe();
  }
}

function ref_13a66() {
  self notify("pity_timer_reset");
  self endon("pity_timer_reset");
  self.ref_12383 = gettime() + 40000;

  while(gettime() < self.ref_12383) {
    waitframe();
  }

  var0 = scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "outlinefill_nodepth_white", "level_script");

  while(!self.activated && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var0, self.plate);
}

function ref_13a60() {
  var0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.targetname = "fob_target" + var0.objkey;
  self.playerexitsafearea = var0.playerexitsafearea;
}

function ref_13e6a() {
  while(!isDefined(level.bridge_one_death_func)) {
    waitframe();
  }

  var0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.playerexitsafearea = var0.playerexitsafearea;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
  self turretfiredisable();

  for(;;) {
    if(isalive(self) && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.minimapid);

      if(isDefined(level.ref_13d3d)) {
        self turretfireenable();
      }

      while(isalive(self) && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
        waitframe();
      }

      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
      self turretfiredisable();
    }

    waitframe();
  }
}

function ref_1418e() {
  level waittill("course_started");
  var0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);

  while(!var0.playerexitsafearea.activated) {
    waitframe();
  }

  var1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", self);
  var1.playerexitsafearea = var0.playerexitsafearea;
  thread ref_141fe();
}

function progression() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player)) {
    waitframe();
  }

  var0 = gettime();

  while(gettime() > var0 + 8000 && !level.player isonground()) {
    waitframe();
  }

  _tablethide::trial_ui_freeze_secondary_timer(1);
  var1 = gettime() + 180000 + 500;
  _tablethide::trial_ui_set_secondary_timer(-1);

  while(!level.player isonground()) {
    waitframe();
  }

  level notify("course_started");
  level.ref_13d3d = gettime() + 180000;
  _tablethide::trial_ui_set_secondary_timer(level.ref_13d3d);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player playSound("trial_sfx_start");
  level.ref_13d6a = 1;
  thread ref_12cbc();
  thread ref_1246c();
  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  ref_143c7();
  score_event_time_remaining();
}

function ref_124d9() {
  _tablethide::waittill_player_isDefined();
  scripts\mp\outofbounds::enableoobimmunity(level.player);

  while(!isalive(level.player)) {
    waitframe();
  }

  while(!level.player isskydiving()) {
    level.player skydive_beginfreefall();
    waitframe();
  }

  while(level.player scripts\mp\outofbounds::istouchingoobtrigger()) {
    waitframe();
  }

  level.player skydive_deployparachute();
  scripts\mp\outofbounds::disableoobimmunity(level.player);
  level.player skydive_cutautodeployon();
  level.player getclientomnvar();

  while(!level.player isparachuting()) {
    waitframe();
  }

  while(!level.player isonground()) {
    waitframe();
  }
}

function ref_143c7() {
  level.player_died_during_course = 1;
  level.player endon("death");

  while(isalive(level.player)) {
    var0 = 1;
    var1 = 1;

    foreach(var3 in level.enemy_targets) {
      if(!var3.activated) {
        var0 = 0;
      }
    }

    if(gettime() < level.ref_13d3d) {
      var1 = 0;
    }

    if(var0 || var1) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

function ref_12cbc() {
  _tablethide::trial_ui_waittill_retry();
  _tablethide::ref_13d5e();
}

function turret_think() {
  thread ref_13e75();
  thread ref_13e6a();
  thread ref_13e69();
}

function ref_13e75() {
  self endon("death");

  for(;;) {
    self waittill("bullet_fired");
    var0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outlinefill_nodepth_red", "level_script");

    while(isalive(self) && isDefined(level.ref_13d21) && self.playerexitsafearea == level.ref_13d21) {
      waitframe();
    }

    scripts\mp\utility\outline::outlinedisable(var0, self);
    waitframe();
  }
}

function ref_13e69() {
  self endon("death");

  while(!isDefined(self.playerexitsafearea)) {
    waitframe();
  }

  while(!self.playerexitsafearea.activated) {
    waitframe();
  }

  while(isalive(self)) {
    self dodamage(99999, self.origin);
    waitframe();
  }
}

function ref_141fe() {
  var0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outline_nodepth_cyan", "level_script");
  var1 = 0;

  for(;;) {
    var2 = distance(level.player.origin, self.origin);

    foreach(var4 in level.allfobs) {
      if(var4 == self.playerexitsafearea) {
        continue;
      }

      if(distance(level.player.origin, var4.trigger.origin) < var2) {
        var1 = 1;
        break;
      }
    }

    if(var1) {
      break;
    }

    if(isDefined(level.player.vehicle)) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var0, self);
}

function ref_1246c() {
  var0 = scripts\engine\utility::array_removeundefined(level.ammorestocklocs);

  for(;;) {
    for(;;) {
      var1 = 0;
      var2 = level.player getweaponslistprimaries();

      foreach(var4 in var2) {
        if(level.player getweaponammostock(var4) < weaponclipsize(var4)) {
          var1 = 1;
          break;
        }
      }

      if(var1) {
        break;
      }

      waitframe();
    }

    var6 = scripts\engine\utility::getclosest(level.player.origin, var0, 1000);

    if(isDefined(var6)) {
      var7 = getEntArray(var6.target, "targetname");
      var8 = undefined;

      foreach(var10 in var7) {
        if(var10.classname == "script_model") {
          var8 = var10;
          break;
        }
      }

      var12 = scripts\mp\utility\outline::outlineenableforplayer(var8, level.player, "outline_nodepth_cyan", "level_script");

      for(;;) {
        var13 = 0;
        var14 = scripts\engine\utility::getclosest(level.player.origin, var0, 1000);

        if(!isDefined(var14) || var14 != var6) {
          break;
        }

        var2 = level.player getweaponslistprimaries();

        foreach(var4 in var2) {
          if(level.player getweaponammostock(var4) >= weaponclipsize(var4)) {
            var13 = 1;
            break;
          }
        }

        if(var13) {
          break;
        }

        waitframe();
      }

      scripts\mp\utility\outline::outlinedisable(var12, var8);
    }

    waitframe();
  }
}

function ref_12f06() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["time_remaining"] = 0;
  level.score["enemies_killed"] = 0;
  level.score["civilians_killed"] = 0;
  level.score["headshot"] = 0;
  level.score["fobs_cleared"] = 0;
  level.score["turrets_killed"] = 0;
  level.ref_13d80 = 180000;
  level.ref_13d3e = 0;
  level.ref_13d2b = 0;
  level.ref_13d46 = 0;
  level.ref_13d86 = 0;
  score_calculate();
}

function score_calculate(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  level.score["subtotal"] = level.score["enemies_killed"] + level.score["headshot"] + level.score["fobs_cleared"] + level.score["turrets_killed"];
  level.score["total"] = level.score["subtotal"] + level.score["civilians_killed"] + level.score["time_remaining"];

  if(istrue(level.ref_13022)) {
    ref_12f0b(var0);
  } else {
    thread ref_12f0b(var0);
  }

  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    _tablethide::ref_13d89(1);
    wait 1;

    if(level.score["total"] < 0) {
      level.score["total"] = 0;
    }

    _tablethide::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      _tablethide::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["kills"] = level.score["enemies_killed"];
      game["trial"]["analytics"]["civilians"] = level.score["civilians_killed"];
      game["trial"]["analytics"]["turrets"] = level.score["turrets_killed"];
      game["trial"]["analytics"]["fobs"] = level.score["fobs_cleared"];
    }

    hud_set_reward_tier(1);
    thread _tablethide::trial_ui_open_results_screen();
    return;
  }
}

function ref_12f0b(var0) {
  level notify("stat_rows_generate");
  level endon("stat_rows_generate");

  while(!istrue(level.ref_13022)) {
    waitframe();
  }

  var1 = 1;
  _tablethide::trial_ui_set_stat_and_bonus_score(var1, "targets_killed_no_ratio", level.ref_13d3e, 0);
  var1++;

  if(level.ref_13d65.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var1, "turrets_destroyed", level.ref_13d86, 0);
    var1++;
  }

  if(level.civilian_targets.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var1, "civilian_targets_hit", level.ref_13d2b, level.score["civilians_killed"]);
    var1++;
  }

  _tablethide::trial_ui_set_stat_and_bonus_score(var1, "fobs_cleared", level.ref_13d46, 0);
  var1++;

  if(var0 && !level.player_died_during_course) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var1, "time_remaining", level.ref_13d80, level.score["time_remaining"]);
    return;
  }
}

function hud_set_reward_tier(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0) {
    var1 = level.score["best"];
  } else {
    var1 = level.score["subtotal"];
  }

  if(var1 >= level.trial["tier3"]) {
    var2 = 3;
  } else if(var2 >= level.trial["tier2"]) {
    var3 = level.trial["tier3"] - level.trial["tier2"];
    var4 = var2 - level.trial["tier2"];
    var2 = 2 + var4 / var3;
  } else if(var2 >= level.trial["tier1"]) {
    var3 = level.trial["tier2"] - level.trial["tier1"];
    var4 = var2 - level.trial["tier1"];
    var2 = 1 + var4 / var3;
  } else {
    var2 /= level.trial["tier1"];
  }

  if(var2) {
    _tablethide::trial_ui_set_reward_tier(var2);

    if(var2 >= level.trial["tier3"]) {
      var5 = game["music"]["trials_win_high"].size;
      var6 = randomint(var5);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var6]);
      return;
    }

    if(var5 >= level.trial["tier2"]) {
      var5 = game["music"]["trials_win_mid"].size;
      var6 = randomint(var5);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var6]);
      return;
    }

    if(var5 >= level.trial["tier1"]) {
      var5 = game["music"]["trials_win_low"].size;
      var6 = randomint(var5);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var6]);
      return;
    }

    var5 = game["music"]["trials_loss"].size;
    var6 = randomint(var5);
    level.player setplayermusicstate(game["music"]["trials_loss"][var6]);
    return;
  }

  _tablethide::trial_ui_set_reward_tier_preview(var6);
}

function ref_12f00() {
  level.score["enemies_killed"] = level.score["enemies_killed"] + 50;
  level.ref_13d3e++;
  level.player thread scripts\mp\rank::scorepointspopup(50);
  waitframe();
  score_calculate();
}

function ref_12eff() {
  level.score["civilians_killed"] = level.score["civilians_killed"] + -500;
  level.ref_13d2b++;
  level.player playSound("trial_sfx_buzzer_bad_1");
  waitframe();
  score_calculate();
}

function ref_12f02() {
  level.score["headshot"] = level.score["headshot"] + 25;
  level.player thread scripts\mp\rank::scorepointspopup(25);
  waitframe();
  score_calculate();
}

function ref_12f01() {
  level.score["fobs_cleared"] = level.score["fobs_cleared"] + 1000;
  level.ref_13d46++;
  level.player thread scripts\mp\rank::scorepointspopup(1000);
  level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
  waitframe();
  score_calculate();
}

function score_event_time_remaining() {
  _tablethide::trial_ui_freeze_secondary_timer(1);

  if(!level.player_died_during_course) {
    var0 = level.ref_13d3d - gettime();
    level.ref_13d80 = clamp(var0, 0, pow(2, 31) - 2);
    level.score["time_remaining"] = scripts\mp\utility\script::limitdecimalplaces(level.ref_13d80 / 1000, 1) * 10;
  }

  waitframe();
  score_calculate(1);
}

function ref_12f05() {
  level.score["turrets_killed"] = level.score["turrets_killed"] + 100;
  level.ref_13d86++;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
  waitframe();
  score_calculate();
}

function dialog_init() {
  game["dialog"]["trial_intro"] = "kh_guncourse_intro_alt";
  game["dialog"]["trial_intro_short"] = "kh_guncourse_intro_short_alt";
  game["dialog"]["trial_end_tier_0"] = "kh_guncourse_star0";
  game["dialog"]["trial_end_tier_1"] = "kh_guncourse_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_guncourse_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_guncourse_star3";
  game["dialog"]["trial_retry"] = "kh_guncourse_retry";
  game["dialog"]["course_start"] = "kh_guncourse_start";
  game["dialog"]["course_nice_shot"] = "kh_guncourse_goodshot";
  game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
  game["dialog"]["course_hurry_up"] = "kh_guncourse_hurryup";
  thread dialog_kill_watcher();
}

function dialog_kill_watcher() {
  level waittill("course_started");
  var0 = 0;
  var1 = 0;
  var2 = gettime();
  var3 = gettime();
  var4 = 5000;

  for(;;) {
    if(level.score["civilians_killed"] < level.score["civilians_killed"] && gettime() > var3 + var4) {
      level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      var5 = gettime();
    } else if(level.score["enemies_killed"] > level.score["enemies_killed"] + 1 && gettime() > var2 + var4) {
      level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
      var5 = gettime();
    }

    var1 = level.score["civilians_killed"];
    var0 = level.score["enemies_killed"];
    waitframe();
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d30;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["kills"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
    game["trial"]["analytics"]["turrets"] = 0;
    game["trial"]["analytics"]["fobs"] = 0;
    return;
  }
}

function ref_13d30() {
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_score");
  var3 = int(game["trial"]["analytics"]["kills"]);
  var4 = int(game["trial"]["analytics"]["civilians"]);
  var5 = int(game["trial"]["analytics"]["turrets"]);
  var6 = int(game["trial"]["analytics"]["fobs"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_arm_course", ["id", var0, "tier", var1, "score", var2, "kills", var3, "civilians", var4, "turrets", var5, "fobs", var6]);
}