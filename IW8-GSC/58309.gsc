/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58309.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["sniper"] = &ref_1343a;
}

function ref_1343a() {
  build_vehicle_drop_off_list();

  if(!isDefined(level.showdebugresult)) {
    level.showdebugresult = 7500;
  }

  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  var_0 = getEntArray("target_brushmodel", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.targetname = "null";
    var_2.target = "null";
  }

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  dialog_init();
  progression();
}

function progression() {
  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  _tablethide::waittill_player_isDefined();

  foreach(var_1 in level.course_targets) {
    var_1.activated = 0;
    thread target_think();
  }

  level.ref_13d45 = getEntArray("trial_flare", "targetname");

  if(isDefined(level.ref_13d45)) {
    scripts\engine\utility::array_thread(level.ref_13d45, &ref_13d7e);
  }

  level.ref_13d7c[1] = getEntArray("wave1", "targetname");
  level.ref_13d7c[2] = getEntArray("wave2", "targetname");
  level.ref_13d7c[3] = getEntArray("wave3", "targetname");
  level.ref_13d7c[4] = getEntArray("wave4", "targetname");
  thread infinite_reserve_ammo_not_revolver();
  level.player scripts\mp\utility\perk::giveperk("specialty_quickswap");
  level.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  hud_init();

  for(;;) {
    trial_score_init();
    score_event_time_remaining(25000, 25000, 25000, 25000);
    level.target_wave = 0;
    _tablethide::trial_ui_set_wave(1, 4);
    course_start_wait();
    _tablethide::ref_13d88();
    _tablethide::ref_13d89(0);
    wave_single_progression(level.ref_13d7c[1], 1);
    wave_single_progression(level.ref_13d7c[2], 2);
    wave_single_progression(level.ref_13d7c[3], 3);
    wave_single_progression(level.ref_13d7c[4], 4);
    score_calculate(1);
    _tablethide::ref_13d89(1);

    foreach(var_7 in level.player.primaryinventory) {
      level.player setweaponammoclip(var_7, weaponclipsize(var_7));
    }

    _tablethide::trial_ui_waittill_retry();
    level notify("trial_retry");
  }
}

function course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }

  var_0 = getEnt("outline", "script_noteworthy");

  while(!isDefined(var_0.spawned_weapon)) {
    waitframe();
  }

  while(isDefined(var_0.spawned_weapon)) {
    waitframe();
  }

  level notify("trial_start");
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

function wave_single_progression(var_0, var_1) {
  hud_inter_round_flow(var_1);
  level notify("new_wave");
  level.target_wave = var_1;
  _tablethide::trial_ui_set_wave(level.target_wave, 4);
  var_2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var_2 + 25000);
  var_3 = 1;

  foreach(var_5 in var_0) {
    thread target_flip(var_5);
  }

  var_7 = 0;

  for(;;) {
    var_8 = 1;

    foreach(var_5 in var_0) {
      if(!var_5.activated && !isDefined(var_5.is_civilian)) {
        var_8 = 0;
      }
    }

    if(gettime() > var_2 + 25000 - level.showdebugresult && istrue(level.ref_13d8f) && !var_7) {
      var_7 = 1;
      thread spawn_fulton_rope_mdl(var_0, 1);
    }

    if(gettime() > var_2 + 25000) {
      break;
    }

    if(!scripts\engine\utility::flag("endwave_audiocountdown_running") && gettime() > var_2 + 25000 - 5000) {
      scripts\engine\utility::flag_set("endwave_audiocountdown_running");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  LOC_0000012b:
    if(istrue(level.ref_13d8f)) {
      thread spawn_fulton_rope_mdl(var_0, 0);
    }

  level notify("wave_ended", var_1);
  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
  var_11 = clamp(var_2 + 25000 - gettime(), 0, 25000);

  foreach(var_5 in var_0) {
    thread target_flip(var_5);
  }

  switch (var_1) {
    case 1:
      score_event_time_remaining(var_11, undefined, undefined, undefined);
      break;
    case 2:
      score_event_time_remaining(undefined, var_11, undefined, undefined);
      break;
    case 3:
      score_event_time_remaining(undefined, undefined, var_11, undefined);
      break;
    case 4:
      score_event_time_remaining(undefined, undefined, undefined, var_11);
      break;
    default:
      break;
  }
}

function spawn_fulton_rope_mdl(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_1) {
      if(!var_3.activated && !isDefined(var_3.is_civilian)) {
        var_3.headicon = deleteheadicon(var_3);
        setheadiconfriendlyimage(var_3.headicon, "icon_navbar_enemy");
        setheadiconsnaptoedges(var_3.headicon, 30000);
        addclienttoheadiconmask(var_3.headicon, 75);
      }

      continue;
    }

    if(!var_3.activated) {
      if(isDefined(var_3.headicon)) {
        setheadiconimage(var_3.headicon);
        var_3.headicon = undefined;
      }
    }
  }
}

function trial_failure_countdown() {
  for(var_0 = 5; var_0 > 0; var_0--) {
    level endon("wave_ended");
    level.player playSound("trial_sfx_failure_countdown");
    wait 1;
  }

  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
}

function target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var_1 in self.parts) {
    switch (var_1.script_noteworthy) {
      case "target_plate":
        self.plate = var_1;

        if(isDefined(self.plate.target)) {
          self.plate.should_break_stealth_immediately = 1;
        }

        break;
      case "target_arm":
        self.arm = var_1;
        break;
      case "target_base":
        self.base = var_1;
        break;
      case "target_wheels":
        self.wheels = var_1;
        break;
      case "target_glint":
        self.see_recently_override = var_1;
        break;
      case "target_smoke":
        self.smoke = var_1;
        break;
      default:
        break;
    }

    var_1.target = "null";
    var_1.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.see_recently_override)) {
    self.see_recently_override linkTo(self);
  }

  if(istrue(self.plate.should_break_stealth_immediately)) {
    self.plate thermaldrawdisable();
  }

  if(isDefined(self.wheels)) {
    self.wheels linkTo(self.base);
  }

  if(isDefined(self.smoke)) {
    self.smoke linkTo(self);
  }

  self.state_up = 0;
  self.flipping = 0;
  thread target_damage();
  self.activated = 0;

  if(issubstr(self.script_noteworthy, "moving")) {
    thread moving_target_think();
  }

  if(issubstr(self.script_noteworthy, "civilian")) {
    self.is_civilian = 1;
    return;
  }
}

function gettargetarray() {
  var_0 = ["standard_target", "moving_target", "civilian_target"];
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = scripts\engine\utility::getStructArray(var_0[var_2], "script_noteworthy");

    if(var_0[var_2] == "civilian_target") {
      if(level.trial["variant"] == "pistol") {
        continue;
      }

      if(var_3[var_2].size > 0) {
        level.show_marker_to_tv_station = 1;
      }
    }

    foreach(var_5 in var_3[var_2]) {
      var_6 = spawn("script_origin", var_5.origin);
      var_6.angles = var_5.angles;
      var_6.script_gameobjectname = var_5.script_gameobjectname;
      var_6.script_linkname = var_5.script_linkname;
      var_6.script_noteworthy = var_5.script_noteworthy;
      var_6.target = var_5.target;
      var_6.targetname = var_5.targetname;
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = getEntArray(var_0[var_2], "script_noteworthy");
  }

  return scripts\engine\utility::array_combine_multiple(var_1);
}

function target_damage() {
  for(;;) {
    self.activated = 0;
    self.plate waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.plate playSound("trial_sfx_target_report_metal");

    if(isDefined(self.smoke)) {
      magicgrenademanual("smoke_grenade_mp", self.smoke.origin, (0, 0, -1), 0.05);
    }

    if(!isDefined(level.targethitsinaframecount)) {
      level.targethitsinaframecount = 0;
    }

    level.targethitsinaframecount++;
    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.player thread _tablethide::ref_13d4b(self.plate, 1, 0, 0);
    level.last_hit_target = self;
    thread target_flip("down");
    self.activated = 1;

    if(isDefined(self.headicon)) {
      setheadiconimage(self.headicon);
      self.headicon = undefined;
    }

    waittillframeend();

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self) {
      thread score_event_collateral(level.targethitsinaframecount);
    }

    if(istrue(self.is_civilian)) {
      level.score["civilian_killed"] = level.score["civilian_killed"] + 100;
      _tablethide::trial_ui_set_stat_and_bonus_score(5, "civilian_targets_hit", level.score["civilian_killed"] / 100, level.score["civilian_killed"] * -1);
      level.player thread scripts\mp\rank::scoreeventpopup("trial_civilian_killed");
      level.player playSound("trial_sfx_buzzer_bad_1");
      waitframe();
      score_calculate();
    } else if(istrue(self.ref_129f7)) {
      thread score_event_target_hit(200);
    } else {
      thread score_event_target_hit(100);
    }

    level.targethitsinaframecount = 0;
    level waittill("course_ended");
  }
}

function target_flip(var_0) {
  if(var_0 == "up") {
    if(isDefined(self.script_delay)) {
      wait self.script_delay;
    }

    self.plate setCanDamage(1);

    if(isDefined(self.see_recently_override)) {
      self.seen_recently_spawner_time = playFXOnTag(scripts\engine\utility::getfx("ambush_sniper_glint"), self.see_recently_override, "tag_origin");
    }

    if(self.state_up) {
      return;
    }

    self.state_up = 1;
    var_1 = 1;
    self.activated = 0;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.see_recently_override)) {
      killfxontag(scripts\engine\utility::getfx("ambush_sniper_glint"), self.see_recently_override, "tag_origin");
    }

    if(!self.state_up) {
      return;
    }

    self.state_up = 0;
    var_1 = -1;
  }

  var_2 = undefined;
  var_3 = undefined;

  switch (self.script_noteworthy) {
    case "civilian_target":
    case "moving_target":
    case "standard_target":
      var_3 = 90;
      var_2 = 0.1;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving")) {
    waitframe();
  }

  if(var_1 == "up") {
    self playsoundonmovingent("trial_sfx_target_flipup");
  }

  if(self.initial_up[1] != 0) {
    self rotateYaw(-1 * self.initial_up[1] * var_3 * var_1, var_2);
  } else {
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
  }

  wait var_2;
  self.flipping = 0;
}

function moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }

  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");

  if(self.mover_ends.size > 2) {
    self.ref_129f7 = 1;
  }

  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed)) {
    self.move_speed = self.script_speed;
  } else {
    self.move_speed = 32;
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  thread moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.players[0].origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
    } else if(!self.flipping && !self.moving && 90 < distance(level.players[0].origin, self.origin) && self.state_up) {
      thread moving_target_mover();
    }

    waitframe();
  }
}

function moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  GscBinSkip4(0x35);
}

function moving_target_reset() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

function target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

function trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    game["trial"]["analytics"]["wave1time"] = 0;
    game["trial"]["analytics"]["wave2time"] = 0;
    game["trial"]["analytics"]["wave3time"] = 0;
    game["trial"]["analytics"]["wave4time"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["target_hit"] = 0;
  level.score["time_remaining_w1"] = 0;
  level.score["time_remaining_w2"] = 0;
  level.score["time_remaining_w3"] = 0;
  level.score["time_remaining_w4"] = 0;
  level.score["collateral"] = 0;
  level.score["civilian_killed"] = 0;

  if(istrue(level.show_marker_to_tv_station)) {
    _tablethide::trial_ui_set_stat_and_bonus_score(5, "civilian_targets_hit", level.score["civilian_killed"], level.score["civilian_killed"]);
  }

  score_calculate();
}

function score_event_target_hit(var_0) {
  level.score["target_hit"] = level.score["target_hit"] + var_0;
  level.player thread scripts\mp\rank::scorepointspopup(var_0);
  waitframe();
  score_calculate();
}

function score_event_collateral(var_0) {
  var_1 = 50 * (var_0 - 1);
  level.score["collateral"] = level.score["collateral"] + var_1;

  switch (var_0) {
    case 3:
      var_2 = "trial_collateral_triple";
      break;
    case 4:
      var_2 = "trial_collateral_quad";
      break;
    default:
      var_2 = "trial_collateral";
      break;
  }

  level.player thread scripts\mp\rank::scoreeventpopup(var_2);
  level.player thread scripts\mp\rank::scorepointspopup(var_2);
  level notify("trial_sniper_collateral");
}

function score_event_time_remaining(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.score["time_remaining_w1"] = scripts\mp\utility\script::limitdecimalplaces(var_0 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(1, "wave_1_time_remaining", var_0, level.score["time_remaining_w1"]);
  }

  if(isDefined(var_1)) {
    level.score["time_remaining_w2"] = scripts\mp\utility\script::limitdecimalplaces(var_1 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(2, "wave_2_time_remaining", var_1, level.score["time_remaining_w2"]);
  }

  if(isDefined(var_2)) {
    level.score["time_remaining_w3"] = scripts\mp\utility\script::limitdecimalplaces(var_2 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(3, "wave_3_time_remaining", var_2, level.score["time_remaining_w3"]);
  }

  if(isDefined(var_3)) {
    level.score["time_remaining_w4"] = scripts\mp\utility\script::limitdecimalplaces(var_3 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(4, "wave_4_time_remaining", var_3, level.score["time_remaining_w4"]);
    return;
  }
}

function score_calculate(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level.score["subtotal"] = level.score["target_hit"] + level.score["collateral"];
  level.score["total"] = level.score["subtotal"] + level.score["time_remaining_w1"] + level.score["time_remaining_w2"] + level.score["time_remaining_w3"] + level.score["time_remaining_w4"] - level.score["civilian_killed"];
  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    wait 1;

    if(level.score["total"] < 0) {
      level.score["total"] = 0;
    }

    _tablethide::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      _tablethide::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["wave1time"] = level.score["time_remaining_w1"];
      game["trial"]["analytics"]["wave2time"] = level.score["time_remaining_w2"];
      game["trial"]["analytics"]["wave3time"] = level.score["time_remaining_w3"];
      game["trial"]["analytics"]["wave4time"] = level.score["time_remaining_w4"];
    }

    hud_set_reward_tier(1);
    level notify("course_ended");

    if(_tablethide::ref_13d4c()) {
      wait 4;
    }

    thread _tablethide::trial_ui_open_results_screen();
    return;
  }
}

function hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_wave(1, 4);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
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

function hud_inter_round_flow(var_0) {
  _tablethide::trial_ui_freeze_secondary_timer(1);
  setomnvar("ui_match_start_text", "wave_" + var_0 + "_start");
  level.player playSound("trial_sfx_success");

  if(istrue(level.ref_13d94) && isDefined(level.ref_13d95) && level.ref_13d95 == var_0) {
    var_1 = scripts\engine\utility::getStruct("trial_wp", "targetname");
    thread ref_13d6b(var_1);
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 10);
  } else {
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  }

  level.player setclientomnvar("ui_match_start_countdown", -1);
  setomnvar("ui_match_start_text", "none");
  level.player playSound("trial_sfx_start");
  level.target_wave = var_0;
  _tablethide::trial_ui_set_wave(level.target_wave, 4);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

function dialog_init() {
  game["dialog"]["trial_intro"] = "kh_sniper_intro";
  game["dialog"]["trial_intro_short"] = "kh_sniper_intro_short";
  game["dialog"]["trial_end_tier_0"] = "kh_sniper_star0";
  game["dialog"]["trial_end_tier_1"] = "kh_sniper_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_sniper_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_sniper_star3";
  game["dialog"]["trial_retry"] = "kh_sniper_retry";
  game["dialog"]["sniper_start"] = "kh_sniper_start";
  game["dialog"]["sniper_search"] = "kh_sniper_search";
  game["dialog"]["sniper_nice_shot"] = "kh_sniper_goodshot";
  game["dialog"]["sniper_hurry_up"] = "kh_sniper_hurryup";
  game["dialog"]["sniper_try_again"] = "kh_sniper_retry";
  game["dialog"]["sniper_nag_bulletdrop"] = "kh_sniper_nag_bulletdrop";
  game["dialog"]["sniper_nag_mount"] = "kh_sniper_nag_mount";
  thread dialog_collateral_watcher();
  thread dialog_missed_shots_watcher();
  thread lgwperifvfx_plumes();
}

function dialog_collateral_watcher() {
  for(;;) {
    level waittill("trial_sniper_collateral");
    level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
    wait 5;
  }
}

function dialog_missed_shots_watcher() {
  var_0 = 1;
  var_1 = 1;

  for(;;) {
    level waittill("new_wave");
    level.shotsmissedcount = 0;

    for(;;) {
      level.player waittill("weapon_fired", var_2, var_3, var_4);
      var_5 = anglesToForward(var_4);
      level.shotsmissedcount++;
      waitframe();

      if(level.shotsmissedcount > 2) {
        if(var_0) {
          var_6 = undefined;
          var_7 = undefined;
          var_8 = undefined;
          var_9 = 360;

          foreach(var_11 in level.ref_13d7c[level.target_wave]) {
            var_12 = var_11.origin + (0, 0, 42);
            var_13 = distance(var_3, var_12);
            var_14 = var_5 * var_13;
            var_15 = vectortoangles(var_12 - var_3);
            var_16 = anglesdelta(var_4, var_15);

            if(var_16 < var_9) {
              var_9 = var_16;
              var_6 = var_11;
              var_7 = var_12;
              var_8 = var_13;
            }
          }

          if(distance(var_3, var_6.origin) >= 4000) {
            var_18 = distance(var_3 + var_5 * var_8, var_7);

            if(var_18 <= 64) {
              level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_nag_bulletdrop");
              var_0 = 0;
              break;
            }
          }
        }

        if( < error > && level.ref_13d52) {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_nag_mount"); <
          error > = 0;
        } else {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_hurry_up");
        }

        break;
      }
    }
  }
}

function lgwperifvfx_plumes() {
  level.ref_13d52 = 1;
  level waittill("new_wave");

  while(level.player playermount() <= 0.5) {
    waitframe();
  }

  level.ref_13d52 = 0;
}

function infinite_reserve_ammo_not_revolver() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getEnt("trial_starting_weapon", "script_noteworthy");
  var_1 = strtok(var_0.script_parameters, "+")[0];

  for(;;) {
    jumpiftrue(isDefined(self.currentprimaryweapon)) LOC_0000003e;
    waitframe();
  }

  for(;;) {
    var_2 = self.currentprimaryweapon;

    if(issubstr(var_2.basename, var_1)) {
      self setweaponammostock(var_2, 0);
    } else {
      self givemaxammo(var_2);
    }

    waitframe();
  }
}

function ref_13d6b(var_0) {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_white_phosphorus_inbound");
  var_1 = [];
  GscBinSkip0(0x2e, 0, spawnStruct());
}

function ref_13d7e() {
  for(;;) {
    level waittill("trial_start");
    wait 3;

    if(isDefined(self.script_noteworthy)) {
      wait float(self.script_noteworthy);
    }

    playFXOnTag(scripts\engine\utility::getfx("trial_flare"), self, "j_top");
    self playSound("gos_firework_scream_sfx");

    if(isDefined(self.script_noteworthy)) {
      var_0 = 3 - float(self.script_noteworthy);
    } else {
      var_0 = 3;
    }

    if(var_0 > 0) {
      wait var_0;
    }

    stopFXOnTag(scripts\engine\utility::getfx("trial_flare"), self, "j_top");
    playFXOnTag(scripts\engine\utility::getfx("trial_thermite"), self, "j_top");
    self playSound("gos_firework_explo_sfx");
    wait 2.25;
    playFXOnTag(scripts\engine\utility::getfx("trial_thermite_end"), self, "j_top");
    stopFXOnTag(scripts\engine\utility::getfx("trial_thermite"), self, "j_top");
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d39;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["wave1time"] = 0;
    game["trial"]["analytics"]["wave2time"] = 0;
    game["trial"]["analytics"]["wave3time"] = 0;
    game["trial"]["analytics"]["wave4time"] = 0;
    return;
  }
}

function ref_13d39() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_score");
  var_3 = int(game["trial"]["analytics"]["wave1time"]);
  var_4 = int(game["trial"]["analytics"]["wave2time"]);
  var_5 = int(game["trial"]["analytics"]["wave3time"]);
  var_6 = int(game["trial"]["analytics"]["wave4time"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_sniper", ["id", var_0, "tier", var_1, "score", var_2, "wave1time", var_3, "wave2time", var_4, "wave3time", var_5, "wave4time", var_6]);
}