/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58305.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["gun"] = &init;
}

function init() {
  level.ref_13d7b = &spawn_first_leads_early;
  level.ref_13d71 = &civvies_killed_calculate;
  level.ref_13d73 = &targets_missed_calculate;
  level.ref_13d81 = &ref_13daf;
  build_vehicle_drop_off_list();
  dialog_init();

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = _stop_spawn_modules::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.start_area_fx = loadfx("vfx/iw8_mp/trials/speedball/vfx_trials_imp_clay.vfx");

  foreach(var_1 in level.course_triggers) {
    var_1 thread _stop_spawn_modules::ref_13d82();
  }

  foreach(var_1 in level.course_targets) {
    var_1 thread _stop_spawn_modules::ref_13d79();
  }

  thread game_start();
  thread game_end();
  var_8 = getEntArray("trial_ammocrate", "targetname");
  scripts\engine\utility::array_thread(var_8, &brplayerkilledspawn);
  level.ref_13d85 = &ref_13e6d;

  while(!istrue(level.ref_13022)) {
    waitframe();
  }

  foreach(var_10 in level.ref_13d65) {
    var_10 setCanDamage(0);
  }
}

function game_start() {
  thread ref_1382b();
  var_0 = getEntArray("start", "script_noteworthy");

  for(;;) {
    level.ref_13d6a = 0;
    _tablethide::trial_ui_set_subtime(0);
    level.ref_13d6f = 1;
    _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13d6f, "accuracy", 0, 0);
    level.ref_13d6f++;

    if(level.trial["missionScript"] != "gun_nonlinear") {
      level.ref_13a88 = level.ref_13d6f;
      level.ref_13d6f++;
      _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13a88, "enemy_targets_hit_ratio", 0, 0);
    }

    if(level.civilian_targets.size) {
      level.hacking_vo = level.ref_13d6f;
      level.ref_13d6f++;
      _tablethide::trial_ui_set_stat_and_bonus_time(level.hacking_vo, "civilian_targets_hit", 0, 0);
    }

    _tablethide::trial_ui_set_objective_progress(0, level.enemy_targets.size);
    _tablethide::trial_ui_set_reward_tier_preview(3);

    for(;;) {
      var_1 = 0;

      foreach(var_3 in var_0) {
        if(var_3.activated) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      waitframe();
    }

    level notify("course_started");

    foreach(var_6 in level.ref_13d65) {
      var_6 setCanDamage(1);
    }

    level.player playSound("trial_sfx_start");
    thread tierfailure_countdown_think();
    _tablethide::ref_13d88();
    _tablethide::ref_13d89(0);
    level.ref_13d6a = 1;
    thread accuracy_think();
    thread time_think();
    _tablethide::trial_ui_waittill_retry();
  }
}

function game_end() {
  if(game["trial"]["best_time"] == -1) {
    level.player_best_time = 0;
  } else {
    level.player_best_time = game["trial"]["best_time"];
  }

  var_0 = getEnt("end", "script_noteworthy");

  for(;;) {
    level waittill("course_started");

    switch (level.trial["missionScript"]) {
      case "gun":
        waittill_trigger_activated_or_player_death(var_0);
        break;
      case "gun_nonlinear":
        ref_143a3();
        thread ref_12cbc();
        break;
      default:
        break;
    }

    level notify("course_ended");
    _tablethide::ref_13d89(1);

    if(!level.player_died_during_course && (!level.player_best_time || level.player_best_time > level.trial_main_time)) {
      level.player_best_time = level.trial_main_time;
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
      game["trial"]["analytics"]["accuracy"] = level.course_accuracy;
      game["trial"]["analytics"]["missed"] = level.enemies_missed;
      game["trial"]["analytics"]["civilians"] = level.civs_killed;
    }

    level.score["total"] = level.trial_main_time;
    level.player_best_time -= level.player_best_time % 100;
    _tablethide::trial_ui_set_best_time(level.player_best_time);

    if(level.player_best_time == 0 || level.player_best_time > level.trial["tier1"]) {
      _tablethide::trial_ui_set_reward_tier(0);
      var_1 = game["music"]["trials_loss"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_loss"][var_2]);
    } else if(level.player_best_time <= level.trial["tier3"]) {
      _tablethide::trial_ui_set_reward_tier(3);
      var_1 = game["music"]["trials_win_high"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var_2]);
    } else if(level.player_best_time <= level.trial["tier2"]) {
      _tablethide::trial_ui_set_reward_tier(2);
      var_1 = game["music"]["trials_win_mid"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var_2]);
    } else {
      _tablethide::trial_ui_set_reward_tier(1);
      var_1 = game["music"]["trials_win_low"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var_2]);
    }

    foreach(var_4 in level.course_triggers) {
      var_4.activated = 0;
    }

    foreach(var_7 in level.course_targets) {
      var_7.activated = 0;
      var_7 thread _stop_spawn_modules::ref_13d74("down");
    }

    setomnvar("ui_trial_failed", 0);

    if(level.player_died_during_course) {
      setomnvar("ui_trial_failed", 1);
      var_1 = game["music"]["trials_loss"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_loss"][var_2]);
      level.player stoplocalsound("deaths_door_in");
      level.player clearsoundsubmix("deaths_door_mp");
      thread ref_12cbc();
    }

    if(istrue(level.ref_13d6c)) {
      wait 3;
    }

    _tablethide::trial_ui_open_results_screen();
  }
}

function waittill_trigger_activated_or_player_death() {
  level.player_died_during_course = 1;
  level.player endon("death");

  while(!self.activated) {
    waitframe();
  }

  level.player_died_during_course = 0;
}

function ref_143a3() {
  level.player_died_during_course = 1;
  level.player endon("death");

  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.enemy_targets) {
      if(!var_2.activated) {
        var_0 = 0;
      }
    }

    if(var_0) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

function ref_12cbc() {
  level.ref_13d60 = 1;
  _tablethide::trial_ui_waittill_retry();
  _tablethide::ref_13d5e();
}

function ref_1382b() {
  var_0 = scripts\engine\utility::getStruct("gun_course_start_icon", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_2 = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_2, "icon_waypoint_marker");
  setheadiconzoffset(var_2, 1);
  setheadiconsnaptoedges(var_2, 0);
  setheadicondrawthroughgeo(var_2, 1);
  _tablethide::waittill_player_isDefined();

  for(;;) {
    addteamtoheadiconmask(var_2, level.player);
    level waittill("course_started");
    removeteamfromheadiconmask(var_2, level.player);
    _tablethide::trial_ui_waittill_retry();
  }
}

function spawn_first_leads_early() {
  if(self.is_civilian || level.trial["missionScript"] != "gun_nonlinear") {
    return;
  }

  while(!isDefined(level.enemies_killed)) {
    waitframe();
  }

  while(level.enemies_killed < level.enemy_targets.size - 10) {
    waitframe();
  }

  while(level.trial_subtime <= level.trial["tier2"]) {
    waitframe();
  }

  scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "outlinefill_trial_target_nodepth", "level_script");
}

function ref_13daf() {
  if(!isDefined(self.target)) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("trigger_smoke_origin", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_2 = scripts\engine\utility::array_intersection(var_0, var_1);

  foreach(var_4 in var_2) {
    magicgrenademanual("smoke_grenade_mp", var_4.origin, (0, 0, -1), 0.05);
  }
}

function time_think() {
  level endon("course_ended");
  level.start_time = gettime();
  level.civs_killed = 0;
  level.enemies_killed = 0;
  level.enemies_missed = level.enemy_targets.size;
  level.civ_time_penalty = 0;
  level.missed_time_penalty = 0;
  level.trial_accuracy_bonus = 0;
  targets_missed_calculate();
  civvies_killed_calculate(1);
  _tablethide::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  for(;;) {
    time_calculate();
    waitframe();
  }
}

function civvies_killed_calculate(var_0) {
  if(!level.civilian_targets.size) {
    return;
  }

  level.civs_killed = 0;

  foreach(var_2 in level.civilian_targets) {
    if(var_2.activated) {
      level.civs_killed++;
    }
  }

  level.civ_time_penalty = level.civs_killed * 5000;
  _tablethide::trial_ui_set_stat_and_bonus_time(level.hacking_vo, "civilian_targets_hit", level.civs_killed, level.civ_time_penalty);

  if(!istrue(var_0)) {
    level.player thread scripts\mp\rank::scoreeventpopup("trial_civilian_killed");
    self playSound("trial_sfx_buzzer_bad_1");
    return;
  }
}

function targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(var_1 in level.enemy_targets) {
    if(!var_1.activated) {
      level.enemies_missed++;
    }
  }

  level.enemies_killed = level.enemy_targets.size - level.enemies_missed;
  level.missed_time_penalty = level.enemies_missed * 5000;
  _tablethide::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  if(level.trial["missionScript"] != "gun_nonlinear") {
    _tablethide::trial_ui_set_stat_and_bonus_time(level.ref_13a88, "enemy_targets_hit_ratio", level.enemy_targets.size - level.enemies_missed, level.missed_time_penalty);
    return;
  }
}

function time_calculate() {
  level.trial_subtime = gettime() - level.start_time;
  level.trial_main_time = level.trial_subtime + level.civ_time_penalty + level.missed_time_penalty + level.trial_accuracy_bonus;
  _tablethide::trial_ui_set_subtime(level.trial_subtime);
  _tablethide::trial_ui_set_main_time(level.trial_main_time);

  if(!isDefined(level.reward_tier)) {
    level.reward_tier = 3;
  }

  var_0 = level.reward_tier;

  if(level.trial_subtime <= level.trial["tier3"]) {
    _tablethide::trial_ui_set_reward_tier_preview(3);
    level.reward_tier = 3;
  } else if(level.trial_subtime <= level.trial["tier2"]) {
    _tablethide::trial_ui_set_reward_tier_preview(2);
    level.reward_tier = 2;
  } else if(level.trial_subtime <= level.trial["tier1"]) {
    _tablethide::trial_ui_set_reward_tier_preview(1);
    level.reward_tier = 1;
  } else {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.reward_tier = 0;
  }

  if(level.reward_tier < var_0) {
    level.player playSound("trial_sfx_failure");
    return;
  }
}

function tierfailure_countdown_think(var_0, var_1) {
  self endon("course_ended");
  var_2 = [];
  var_2[0] = undefined;
  GscBinSkip0(0x2e, 1, level.trial["tier1"] / 1000);
}

function accuracy_think() {
  level endon("course_ended");
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "accuracy", 0, 0);
  level.shots_fired = 0;
  level.course_accuracy = 0;

  for(;;) {
    level.player scripts\engine\utility::ref_143a5("weapon_fired", "fake_weapon_fired");
    level.shots_fired++;
    var_0 = level.player getcurrentweapon();
    var_1 = weaponfiretime(var_0);

    if(isDefined(var_1)) {
      if(var_1 > 0.05) {
        wait var_1;
      }
    }

    waitframe();
    level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / clamp(level.shots_fired, 1, 99999);
    var_2 = -1 * level.course_accuracy * 5000;
    level.trial_accuracy_bonus = var_2 - var_2 % 100;
    _tablethide::trial_ui_set_stat_and_bonus_time(1, "accuracy", 100 * level.course_accuracy, level.trial_accuracy_bonus);
  }
}

function dialog_init() {
  if(level.trial["missionScript"] != "gun_nonlinear") {
    game["dialog"]["trial_intro"] = "kh_guncourse_intro";
    game["dialog"]["trial_intro_short"] = "kh_guncourse_intro_short";
    game["dialog"]["trial_end_tier_0"] = "kh_guncourse_star0";
    game["dialog"]["trial_end_tier_1"] = "kh_guncourse_star1";
    game["dialog"]["trial_end_tier_2"] = "kh_guncourse_star2";
    game["dialog"]["trial_end_tier_3"] = "kh_guncourse_star3";
    game["dialog"]["trial_retry"] = "kh_guncourse_retry";
    game["dialog"]["course_start"] = "kh_guncourse_start";
    game["dialog"]["course_nice_shot"] = "kh_guncourse_goodshot";
    game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
    game["dialog"]["course_hurry_up"] = "kh_guncourse_hurryup";
  } else {
    game["dialog"]["trial_intro"] = "mp_m_speedball_intro";
    game["dialog"]["trial_intro_short"] = "mp_m_speedball_intro_short";
    game["dialog"]["trial_end_tier_0"] = "mp_m_speedball_end_0star";
    game["dialog"]["trial_end_tier_1"] = "mp_m_speedball_end_1star";
    game["dialog"]["trial_end_tier_2"] = "mp_m_speedball_end_2star";
    game["dialog"]["trial_end_tier_3"] = "mp_m_speedball_end_3star";
    game["dialog"]["trial_retry"] = "mp_m_speedball_obj_fail";
    game["dialog"]["course_start"] = "mp_m_speedball_obj_nag_start";
    game["dialog"]["course_nice_shot"] = "mp_m_speedball_obj_nag_nice";
    game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
    game["dialog"]["course_hurry_up"] = "mp_m_speedball_obj_nag_hurry";
  }

  thread dialog_hurry_up_watcher();
  thread dialog_kill_watcher();
}

function dialog_hurry_up_watcher() {
  for(;;) {
    level waittill("trigger_activated");
    thread dialog_hurry_up_thread();
  }
}

function dialog_hurry_up_thread() {
  level endon("trigger_activated");
  level endon("course_ended");
  wait 9;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("course_hurry_up");
}

function dialog_kill_watcher() {
  level waittill("course_started");
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 5000;

  for(;;) {
    if(level.civs_killed > var_1 && gettime() > var_3 + var_4) {
      level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      var_3 = gettime();
    } else if(level.enemies_killed > var_0 + 1 && gettime() > var_2 + var_4) {
      level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_nice_shot");
      var_2 = gettime();
    }

    var_1 = level.civs_killed;
    var_0 = level.enemies_killed;
    waitframe();
  }
}

function brplayerkilledspawn() {
  self.headicon = deleteheadicon(self);
  setheadiconfriendlyimage(self.headicon, "cp_crate_icon_ammo");
  setheadiconmaxdistance(self.headicon, 800);
  addclienttoheadiconmask(self.headicon, 50);
  var_0 = spawn("script_model", self.origin);
  var_0 linkTo(self, "tag_origin", (0, 0, 50), (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 setHintString(&"MP_INGAME_ONLY/REFILL_AMMO");
  var_0 setCursorHint("hint_button");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(80);
  var_0 setusefov(120);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");

  for(;;) {
    var_0 makeusable();
    var_0 waittill("trigger");
    var_1 = level.player getcurrentweapon();
    var_2 = level.player getcurrentweaponclipammo();
    level.player setweaponammoclip(var_1, var_2);

    if(level.trial["variant"] == "pickup") {
      var_3 = level.player getweaponammostock(var_1) + 1;
      var_4 = 1;
    } else {
      var_3 = weaponclipsize(var_1) - var_2;
      var_4 = 5;
    }

    level.player setweaponammostock(var_1, var_3);
    var_0 makeunusable();
    setheadiconteam(self.headicon);
    wait var_4;
    hideheadiconfromplayersinmask(self.headicon);
  }
}

function ref_13e6d() {
  self endon("death");
  level waittill("course_started");
  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "spotter_target_killstreak", "level_script");
  thread ref_13e6c();

  while(isalive(self)) {
    waitframe();
  }

  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

function ref_13e6c() {
  self endon("death");
  level waittill("course_ended");

  if(isalive(self)) {
    self notify("death");
    return;
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d33;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["weapon1"] = "DNF";
    game["trial"]["analytics"]["weapon2"] = "DNF";
    game["trial"]["analytics"]["accuracy"] = 0;
    game["trial"]["analytics"]["missed"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
    return;
  }
}

function ref_13d33() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_time");
  var_3 = "" + game["trial"]["analytics"]["weapon1"];
  var_4 = "" + game["trial"]["analytics"]["weapon2"];
  var_5 = float(game["trial"]["analytics"]["accuracy"]);
  var_6 = int(game["trial"]["analytics"]["missed"]);
  var_7 = int(game["trial"]["analytics"]["civilians"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_gun", ["id", var_0, "tier", var_1, "time", var_2, "weapon1", var_3, "weapon2", var_4, "accuracy", var_5, "missed", var_6, "civilians", var_7]);
}