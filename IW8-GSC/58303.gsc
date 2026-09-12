/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58303.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13D51)) {
    level.ref_13D51 = [];
  }

  level.ref_13D51["arm_course"] = &init;
}

function init() {
  _tablethide::trial_ui_set_subscore(0);
  dialog_init();
  setDvar("scr_game_matchstarttime", 1);
  setDvar("scr_localeID", -1);
  level.ref_13D73 = &ref_12F00;
  level.ref_13D71 = &ref_12EFF;
  level.ref_13D76 = &ref_12F02;
  level.ref_13D7A = &ref_13A60;
  level.ref_13D7B = &ref_13A5B;
  level.ref_13D84 = &ref_12F05;
  level.ref_13D85 = &turret_think;
  level.civilian_targets = [];
  level.enemy_targets = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = _stop_spawn_modules::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.ref_13D92 = scripts\engine\utility::getStructArray("trial_atv_spawn", "targetname");
  ref_12F06();
  build_vehicle_drop_off_list();
  set_wave_num();

  foreach(var_1 in level.ref_13D92) {
    thread ref_1418E();
  }

  foreach(var_4 in level.course_triggers) {
    var_4 thread _stop_spawn_modules::ref_13D82();
  }

  foreach(var_4 in level.course_targets) {
    var_4 thread _stop_spawn_modules::ref_13D79();
  }

  level.ref_13A94 = 1;
  thread ref_124D9();
  thread progression();
}

function set_wave_num() {
  scripts\mp\gametypes\arm::seticonnames();

  if(level.trial["team"] == "allies") {
    level.ref_13D56 = "axis";
    level.startingfobnames_allies = [];
    level.startingfobnames_axis = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_neutral = [];
  } else {
    level.ref_13D56 = "allies";
    level.startingfobnames_allies = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
    level.startingfobnames_axis = [];
    level.startingfobnames_neutral = [];
  }

  level.gw_objstruct = spawnStruct();
  scripts\mp\gametypes\arm::setupobjectives();

  if(level.trial["team"] == "allies") {
    var_0 = level.gw_objstruct.startingfobs_axis;
  } else {
    var_0 = level.gw_objstruct.startingfobs_allies;
  }

  level.allfobs = [];
  level.bridge_one_death_func = [];

  foreach(var_2 in var_0) {
    thread playerfadeobjdelete();
  }

  thread audio_enablepa();
}

function playerfadeobjdelete() {
  level.allfobs[level.allfobs.size] = self;
  level.bridge_one_death_func[level.bridge_one_death_func.size] = self.trigger;
  self.trigger.playerexitsafearea = self;
  self.activated = 0;

  while(!istrue(level.ref_13A94)) {
    waitframe();
  }

  self.targets = getEntArray("fob_target" + self.trigger.objkey, "targetname");

  foreach(var_1 in self.targets) {
    if(istrue(var_1.is_civilian)) {
      self.targets = scripts\engine\utility::array_remove(self.targets, var_1);
    }
  }

  if(self.targets.size == 0) {
    return;
  }

  self.objective = scripts\mp\gameobjects::createobjidobject(self.trigger.origin, "neutral", (0, 0, 100), undefined, "any");
  var_3 = "waypoint_capture" + self.trigger.objkey;
  scripts\mp\objidpoolmanager::update_objective_icon(self.objective.objidnum, scripts\mp\gameobjects::getwaypointshader(var_3));
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objective.objidnum, scripts\mp\gameobjects::getwaypointbackgroundtype(var_3));
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.ref_13D56);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 1);

  for(;;) {
    if(isDefined(level.ref_13D21) && self == level.ref_13D21) {
      objective_state(self.objective.objidnum, "invisible");
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objective.objidnum, 0);
    } else {
      objective_state(self.objective.objidnum, "current");
    }

    var_4 = 0;

    foreach(var_1 in self.targets) {
      if(var_1.activated && !istrue(var_1.is_civilian)) {
        scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 1);
        var_4++;
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(self.objective.objidnum, var_4 / self.targets.size);

    if(var_4 >= self.targets.size) {
      break;
    }

    waitframe();
  }

  self.activated = 1;
  scripts\mp\objidpoolmanager::objective_show_progress(self.objective.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objective.objidnum, level.trial["team"]);
  wait 1;
  ref_12F01();
}

function audio_enablepa() {
  level waittill("course_started");

  for(;;) {
    var_0 = scripts\engine\utility::getclosest(level.player.origin, level.enemy_targets, 1000);

    if(isDefined(var_0)) {
      level.ref_13D21 = var_0.playerexitsafearea;
    } else {
      level.ref_13D21 = undefined;
    }

    waitframe();
  }
}

function ref_13A5B() {
  for(;;) {
    if(!self.activated && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
      var_0 = scripts\mp\gameobjects::createobjidobject(self.origin, level.ref_13D56, (0, 0, 0), undefined, "any");
      objective_state(var_0.objidnum, "active");
      objective_setplayintro(var_0.objidnum, 0);

      if(!istrue(self.is_civilian)) {
        objective_icon(var_0.objidnum, "icon_minimap_enemy");
      }

      objective_setbackground(var_0.objidnum, 1);
      objective_setfadedisabled(var_0.objidnum, 0);
      objective_setshowoncompass(var_0.objidnum, 1);
      objective_setminimapiconsize(var_0.objidnum, "icon_regular");
      objective_setshowdistance(var_0.objidnum, 0);
      objective_setownerteam(var_0.objidnum, level.ref_13D56);

      if(!istrue(self.is_civilian)) {
        thread ref_13A66();
      }

      while(!self.activated && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
        waitframe();
      }

      scripts\mp\objidpoolmanager::returnobjectiveid(var_0.objidnum);
    }

    waitframe();
  }
}

function ref_13A66() {
  self notify("pity_timer_reset");
  self endon("pity_timer_reset");
  self.ref_12383 = gettime() + 40000;

  while(gettime() < self.ref_12383) {
    waitframe();
  }

  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "outlinefill_nodepth_white", "level_script");

  while(!self.activated && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var_0, self.plate);
}

function ref_13A60() {
  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.targetname = "fob_target" + var_0.objkey;
  self.playerexitsafearea = var_0.playerexitsafearea;
}

function ref_13E6A() {
  while(!isDefined(level.bridge_one_death_func)) {
    waitframe();
  }

  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);
  self.playerexitsafearea = var_0.playerexitsafearea;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
  self turretfiredisable();

  for(;;) {
    if(isalive(self) && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.minimapid);

      if(isDefined(level.ref_13D3D)) {
        self turretfireenable();
      }

      while(isalive(self) && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
        waitframe();
      }

      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.minimapid);
      self turretfiredisable();
    }

    waitframe();
  }
}

function ref_1418E() {
  level waittill("course_started");
  var_0 = scripts\engine\utility::getclosest(self.origin, level.bridge_one_death_func, 4096);

  while(!var_0.playerexitsafearea.activated) {
    waitframe();
  }

  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", self);
  var_1.playerexitsafearea = var_0.playerexitsafearea;
  thread ref_141FE();
}

function progression() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player)) {
    waitframe();
  }

  var_0 = gettime();

  while(gettime() > var_0 + 8000 && !level.player isonground()) {
    waitframe();
  }

  _tablethide::trial_ui_freeze_secondary_timer(1);
  var_1 = gettime() + 180000 + 500;
  _tablethide::trial_ui_set_secondary_timer(-1);

  while(!level.player isonground()) {
    waitframe();
  }

  level notify("course_started");
  level.ref_13D3D = gettime() + 180000;
  _tablethide::trial_ui_set_secondary_timer(level.ref_13D3D);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player playSound("trial_sfx_start");
  level.ref_13D6A = 1;
  thread ref_12CBC();
  thread ref_1246C();
  _tablethide::ref_13D88();
  _tablethide::ref_13D89(0);
  ref_143C7();
  score_event_time_remaining();
}

function ref_124D9() {
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

function ref_143C7() {
  level.player_died_during_course = 1;
  level.player endon("death");

  while(isalive(level.player)) {
    var_0 = 1;
    var_1 = 1;

    foreach(var_3 in level.enemy_targets) {
      if(!var_3.activated) {
        var_0 = 0;
      }
    }

    if(gettime() < level.ref_13D3D) {
      var_1 = 0;
    }

    if(var_0 || var_1) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

function ref_12CBC() {
  _tablethide::trial_ui_waittill_retry();
  _tablethide::ref_13D5E();
}

function turret_think() {
  thread ref_13E75();
  thread ref_13E6A();
  thread ref_13E69();
}

function ref_13E75() {
  self endon("death");

  for(;;) {
    self waittill("bullet_fired");
    var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outlinefill_nodepth_red", "level_script");

    while(isalive(self) && isDefined(level.ref_13D21) && self.playerexitsafearea == level.ref_13D21) {
      waitframe();
    }

    scripts\mp\utility\outline::outlinedisable(var_0, self);
    waitframe();
  }
}

function ref_13E69() {
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

function ref_141FE() {
  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "outline_nodepth_cyan", "level_script");
  var_1 = 0;

  for(;;) {
    var_2 = distance(level.player.origin, self.origin);

    foreach(var_4 in level.allfobs) {
      if(var_4 == self.playerexitsafearea) {
        continue;
      }

      if(distance(level.player.origin, var_4.trigger.origin) < var_2) {
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      break;
    }

    if(isDefined(level.player.vehicle)) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

function ref_1246C() {
  var_0 = scripts\engine\utility::array_removeundefined(level.ammorestocklocs);

  for(;;) {
    for(;;) {
      var_1 = 0;
      var_2 = level.player getweaponslistprimaries();

      foreach(var_4 in var_2) {
        if(level.player getweaponammostock(var_4) < weaponclipsize(var_4)) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      waitframe();
    }

    var_6 = scripts\engine\utility::getclosest(level.player.origin, var_0, 1000);

    if(isDefined(var_6)) {
      var_7 = getEntArray(var_6.target, "targetname");
      var_8 = undefined;

      foreach(var_10 in var_7) {
        if(var_10.classname == "script_model") {
          var_8 = var_10;
          break;
        }
      }

      var_12 = scripts\mp\utility\outline::outlineenableforplayer(var_8, level.player, "outline_nodepth_cyan", "level_script");

      for(;;) {
        var_13 = 0;
        var_14 = scripts\engine\utility::getclosest(level.player.origin, var_0, 1000);

        if(!isDefined(var_14) || var_14 != var_6) {
          break;
        }

        var_2 = level.player getweaponslistprimaries();

        foreach(var_4 in var_2) {
          if(level.player getweaponammostock(var_4) >= weaponclipsize(var_4)) {
            var_13 = 1;
            break;
          }
        }

        if(var_13) {
          break;
        }

        waitframe();
      }

      scripts\mp\utility\outline::outlinedisable(var_12, var_8);
    }

    waitframe();
  }
}

function ref_12F06() {
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
  level.ref_13D80 = 180000;
  level.ref_13D3E = 0;
  level.ref_13D2B = 0;
  level.ref_13D46 = 0;
  level.ref_13D86 = 0;
  score_calculate();
}

function score_calculate(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level.score["subtotal"] = level.score["enemies_killed"] + level.score["headshot"] + level.score["fobs_cleared"] + level.score["turrets_killed"];
  level.score["total"] = level.score["subtotal"] + level.score["civilians_killed"] + level.score["time_remaining"];

  if(istrue(level.ref_13022)) {
    ref_12F0B(var_0);
  } else {
    thread ref_12F0B(var_0);
  }

  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    _tablethide::ref_13D89(1);
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

function ref_12F0B(var_0) {
  level notify("stat_rows_generate");
  level endon("stat_rows_generate");

  while(!istrue(level.ref_13022)) {
    waitframe();
  }

  var_1 = 1;
  _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "targets_killed_no_ratio", level.ref_13D3E, 0);
  var_1++;

  if(level.ref_13D65.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "turrets_destroyed", level.ref_13D86, 0);
    var_1++;
  }

  if(level.civilian_targets.size) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "civilian_targets_hit", level.ref_13D2B, level.score["civilians_killed"]);
    var_1++;
  }

  _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "fobs_cleared", level.ref_13D46, 0);
  var_1++;

  if(var_0 && !level.player_died_during_course) {
    _tablethide::trial_ui_set_stat_and_bonus_score(var_1, "time_remaining", level.ref_13D80, level.score["time_remaining"]);
    return;
  }
}

function hud_set_reward_tier(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    var_1 = level.score["best"];
  } else {
    var_1 = level.score["subtotal"];
  }

  if(var_1 >= level.trial["tier3"]) {
    var_2 = 3;
  } else if(var_2 >= level.trial["tier2"]) {
    var_3 = level.trial["tier3"] - level.trial["tier2"];
    var_4 = var_2 - level.trial["tier2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_2 >= level.trial["tier1"]) {
    var_3 = level.trial["tier2"] - level.trial["tier1"];
    var_4 = var_2 - level.trial["tier1"];
    var_2 = 1 + var_4 / var_3;
  } else {
    var_2 /= level.trial["tier1"];
  }

  if(var_2) {
    _tablethide::trial_ui_set_reward_tier(var_2);

    if(var_2 >= level.trial["tier3"]) {
      var_5 = game["music"]["trials_win_high"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var_6]);
      return;
    }

    if(var_5 >= level.trial["tier2"]) {
      var_5 = game["music"]["trials_win_mid"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var_6]);
      return;
    }

    if(var_5 >= level.trial["tier1"]) {
      var_5 = game["music"]["trials_win_low"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var_6]);
      return;
    }

    var_5 = game["music"]["trials_loss"].size;
    var_6 = randomint(var_5);
    level.player setplayermusicstate(game["music"]["trials_loss"][var_6]);
    return;
  }

  _tablethide::trial_ui_set_reward_tier_preview(var_6);
}

function ref_12F00() {
  level.score["enemies_killed"] = level.score["enemies_killed"] + 50;
  level.ref_13D3E++;
  level.player thread scripts\mp\rank::scorepointspopup(50);
  waitframe();
  score_calculate();
}

function ref_12EFF() {
  level.score["civilians_killed"] = level.score["civilians_killed"] + -500;
  level.ref_13D2B++;
  level.player playSound("trial_sfx_buzzer_bad_1");
  waitframe();
  score_calculate();
}

function ref_12F02() {
  level.score["headshot"] = level.score["headshot"] + 25;
  level.player thread scripts\mp\rank::scorepointspopup(25);
  waitframe();
  score_calculate();
}

function ref_12F01() {
  level.score["fobs_cleared"] = level.score["fobs_cleared"] + 1000;
  level.ref_13D46++;
  level.player thread scripts\mp\rank::scorepointspopup(1000);
  level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
  waitframe();
  score_calculate();
}

function score_event_time_remaining() {
  _tablethide::trial_ui_freeze_secondary_timer(1);

  if(!level.player_died_during_course) {
    var_0 = level.ref_13D3D - gettime();
    level.ref_13D80 = clamp(var_0, 0, pow(2, 31) - 2);
    level.score["time_remaining"] = scripts\mp\utility\script::limitdecimalplaces(level.ref_13D80 / 1000, 1) * 10;
  }

  waitframe();
  score_calculate(1);
}

function ref_12F05() {
  level.score["turrets_killed"] = level.score["turrets_killed"] + 100;
  level.ref_13D86++;
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
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 5000;

  for(;;) {
    if(level.score["civilians_killed"] < level.score["civilians_killed"] && gettime() > var_3 + var_4) {
      level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      var_5 = gettime();
    } else if(level.score["enemies_killed"] > level.score["enemies_killed"] + 1 && gettime() > var_2 + var_4) {
      level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
      var_5 = gettime();
    }

    var_1 = level.score["civilians_killed"];
    var_0 = level.score["enemies_killed"];
    waitframe();
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13D32 = &ref_13D30;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["kills"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
    game["trial"]["analytics"]["turrets"] = 0;
    game["trial"]["analytics"]["fobs"] = 0;
    return;
  }
}

function ref_13D30() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_score");
  var_3 = int(game["trial"]["analytics"]["kills"]);
  var_4 = int(game["trial"]["analytics"]["civilians"]);
  var_5 = int(game["trial"]["analytics"]["turrets"]);
  var_6 = int(game["trial"]["analytics"]["fobs"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_arm_course", ["id", var_0, "tier", var_1, "score", var_2, "kills", var_3, "civilians", var_4, "turrets", var_5, "fobs", var_6]);
}