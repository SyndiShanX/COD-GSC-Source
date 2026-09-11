/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58307.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["pitcher"] = &init;
}

function init() {
  build_vehicle_drop_off_list();
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_grenade.vfx");
  level._effect["vfx_light_red"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_window_light_red.vfx");
  level._effect["vfx_light_green"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_window_light_green.vfx");
  dialog_init();
  weapon_xp_iw8_sn_awhiskey();

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.course_targets = getEntArray("hole_target", "targetname");
  level.movers = getEntArray("mover", "targetname");
  level.ref_11db8 = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.lights = getEntArray("target_light", "targetname");
  _tablethide::waittill_player_isDefined();
  thread player_init();
  thread ref_12160();
  thread script_gameobjetname();
  thread ref_12a8f();
  thread ref_1378e();
  thread set_chopper_search_speed();
  thread player_monitor_death();

  foreach(var1 in level.course_targets) {
    var1.linked = 0;
    thread target_think();
  }

  foreach(var4 in level.lights) {
    thread whistling();
  }

  foreach(var7 in level.movers) {
    thread ref_11db1();
  }

  hud_init();
  ref_128bd();
}

function ref_128bd() {
  level waittill("start");

  for(;;) {
    trial_score_init();
    level.target_wave = 0;
    course_start_wait();
    _tablethide::ref_13d88();
    _tablethide::ref_13d89(0);
    wave_single_progression(level.targets, 1);
    score_calculate(1);
    _tablethide::ref_13d89(1);
    _tablethide::trial_ui_waittill_retry();
    level notify("retry");
    level.player freezecontrols(0);

    foreach(var1 in level.lights) {
      weaponusagecheck(var1, 0, 1);
    }

    foreach(var4 in level.course_targets) {
      thread target_think();
    }
  }
}

function ref_1378e() {
  var0 = getEnt("grenade_box", "targetname");
  var0 setHintString(&"MP_INGAME_ONLY/PRESS_TO_START_GAME");
  var0 setCursorHint("hint_button");
  var0 sethintdisplayrange(200);
  var0 sethintdisplayfov(65);
  var0 setuserange(72);
  var0 setusefov(120);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_short");
  var0 makeusable();
  var0 waittill("trigger");
  level notify("start");
  level.player scripts\mp\equipment::giveequipment("equip_frag", "primary");
  level.player playSound("gren_pickup_frag");
  var0 makeunusable();
}

function course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }

  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

function wave_single_progression(var0, var1) {
  hud_inter_round_flow(var1);
  level notify("new_wave");
  level.target_wave = var1;
  var2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var2 + 60000);
  var3 = 1;

  while(isalive(level.player)) {
    if(gettime() > var2 + 60000) {
      break;
    }

    if(!scripts\engine\utility::flag("endwave_audiocountdown_running") && gettime() > var2 + 60000 - 5000) {
      scripts\engine\utility::flag_set("endwave_audiocountdown_running");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  level notify("wave ended");
  thread set_actualstarttime();
  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
  var4 = clamp(var2 + 60000 - gettime(), 0, 60000);
}

function player_init() {
  while(!isalive(level.player)) {
    waitframe();
  }

  var0 = "iw8_knife_mp";
  level.player giveweapon("iw8_fists_mp");
  level.player giveweapon(var0);
  level.player switchtoweapon(var0);
}

function set_actualstarttime() {
  level endon("retry");
  wait 0.5;

  for(;;) {
    self.gastakenweaponobj = self getheldoffhand();

    if(isDefined(self.gastakenweaponobj)) {
      var0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

      if(isDefined(var0) && scripts\mp\equipment::hasequipment(var0)) {
        self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(var0);
        self takeweapon(self.gastakenweaponobj);
        waitframe();
        level.player scripts\mp\equipment::giveequipment("equip_frag", "primary");
        level.player freezecontrols(1);
      }
    }

    waitframe();
  }
}

function trial_failure_countdown() {
  for(var0 = 5; var0 > 0; var0--) {
    level endon("wave ended");
    level.player playSound("trial_sfx_failure_countdown");
    wait 1;
  }

  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
}

function target_think() {
  level endon("wave ended");
  level.player endon("dead");
  self endon("times up");

  for(;;) {
    self.activated = 0;
    level waittill("new_wave");

    if(isDefined(level.trial["variant"])) {
      if(level.trial["variant"] == "mover") {
        if(isDefined(self.script_parameters) && isDefined(self.light)) {
          wait 20 * (int(self.script_parameters) - 1);
          thread ref_13b6d();
        }
      }
    }

    if(isDefined(self.script_delay)) {
      wait self.script_delay;
    }

    self.activated = 1;

    for(;;) {
      level.player waittill("grenade_fire", var0);

      if(!self.activated) {
        break;
      }

      thread ref_13a5c(var0);
    }
  }
}

function ref_13b6d() {
  self endon("activated");
  wait 15;

  if(self.activated) {
    var0 = 0.25;

    for(var1 = 0; var1 < 8; var1++) {
      weaponusagecheck(self.light, 1);
      wait var0;
      weaponusagecheck(self.light, 0, 1);
      wait var0;
    }
  }

  waitframe();
  self.activated = 0;
  waitframe();
  self notify("times up");
}

function whistling() {
  var0 = sortbydistance(level.course_targets, self.origin);

  if(isDefined(self.target)) {
    for(var1 = 0; var1 < var0.size; var1++) {
      if(isDefined(var0[var1].target)) {
        if(var0[var1].target == self.target && var0[var1].linked == 0) {
          var0[var1].linked = 1;
          self.heli_starts_clear = var0[var1];
          break;
        }
      }
    }
  } else {
    if(distance(var1[0].origin, self.origin) >= 150) {
      weaponusagecheck(0);
      return;
    }

    for(var1 = 0; var1 < var1.size; var1++) {
      if(var1[var1].linked == 0) {
        var1[var1].linked = 1;
        self.heli_starts_clear = var1[var1];
        break;
      }
    }
  }

  if(!isDefined(self.heli_starts_clear)) {
    weaponusagecheck(0);
    return;
  }

  self.heli_starts_clear.light = self;
  thread whizby_onplayerconnect();
}

function whizby_onplayerconnect() {
  weaponusagecheck(0, 1);

  for(;;) {
    level waittill("new_wave");

    while(!self.heli_starts_clear.activated) {
      waitframe();
    }

    weaponusagecheck(1);
    whistletimer();
  }
}

function whistletimer() {
  level endon("wave ended");
  level.player endon("death");

  for(;;) {
    if(!self.heli_starts_clear.activated) {
      weaponusagecheck(0);
      break;
    }

    waitframe();
  }
}

function weaponusagecheck(var0, var1) {
  if(istrue(self.playerzombiejumpstop)) {
    killfxontag(scripts\engine\utility::getfx("vfx_light_green"), self, "stationary_trainyard_signal_lights_01_green_spdball");
    self.playerzombiejumpstop = 0;
  }

  if(istrue(self.playerzombiepowerstartcooldown)) {
    killfxontag(scripts\engine\utility::getfx("vfx_light_red"), self, "stationary_trainyard_signal_lights_01_red_spdball");
    self.playerzombiepowerstartcooldown = 0;
  }

  waitframe();

  if(istrue(var1)) {
    self setModel("stationary_trainyard_signal_lights_01_spdball_off");
    return;
  }

  waitframe();

  if(var0) {
    self setModel("stationary_trainyard_signal_lights_01_green_spdball");
    self.playerzombiejumpstop = 1;
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("vfx_light_green"), self, "stationary_trainyard_signal_lights_01_green_spdball");
    return;
  }

  self setModel("stationary_trainyard_signal_lights_01_red_spdball");
  self.playerzombiepowerstartcooldown = 1;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_light_red"), self, "stationary_trainyard_signal_lights_01_red_spdball");
}

function ref_13a5c(var0) {
  level endon("target_hit");

  while(isDefined(var0)) {
    if(!isDefined(self.script_targettype)) {
      if(self istouching(var0)) {
        self.activated = 0;
        var0.spawn_infil_lbravo = 1;
        self notify("activated");
        thread score_event_target_hit(self.script_noteworthy, self);

        if(isDefined(self.light)) {
          level.player playSound("trial_sfx_success");
        } else {
          level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("trickshot");
          level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
        }

        level notify("target_hit");
        break;
      }
    } else if(distancesquared(var0.origin, self.origin) < 361) {
      self.activated = 0;
      var0.spawn_infil_lbravo = 1;
      self notify("activated");
      thread score_event_target_hit(self.script_noteworthy, self);

      if(!isDefined(self.script_targettype)) {
        level.player playSound("trial_sfx_success");
      } else {
        level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("trickshot");
        level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
      }

      level notify("target_hit");
      break;
    }

    waitframe();
  }
}

function ref_11db1() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.ref_11db8, 32);

  if(!isDefined(self.mover)) {
    return;
  }

  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;

  if(isDefined(self.script_speed)) {
    self.move_speed = self.script_speed;
  } else {
    self.move_speed = 32;
  }

  for(;;) {
    level waittill("new_wave");
    ref_11db2();
  }
}

function ref_11db2() {
  for(;;) {
    var0 = self.mover_ends[self.moveforward];
    var1 = distance(self.origin, var0.origin);
    var2 = var1 / self.move_speed;
    var2 = clamp(var2, 0.05, 9999);
    var3 = 0.5;
    self moveTo(var0.origin, var2, var3, var3);
    wait var2;
    self.moveforward = !self.moveforward;
  }
}

function trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.trial_fail_alt = 0;
  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["target_hit"] = 0;
  level.score["time_remaining_w1"] = 0;
  level.score["time_remaining_w2"] = 0;
  level.score["time_remaining_w3"] = 0;
  level.score["time_remaining_w4"] = 0;
  level.score["collateral"] = 0;
  level.score["trickshot"] = 0;
  score_calculate();
}

function score_event_target_hit(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 100;
  }

  if(int(var0) >= 300 && isDefined(var1.light) && level.light_tank_initdamage) {
    level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
    level.light_tank_initdamage = 0;
    level notify("dialog");
  }

  if(isDefined(self.script_targettype) && level.trial["variant"] == "mover") {
    if(isDefined(self.script_parameters)) {
      var0 = int(var0) - int(self.script_parameters);
    }
  }

  if(!isDefined(self.script_targettype)) {
    level.score["target_hit"] = level.score["target_hit"] + int(var0);
  }

  level.player thread scripts\mp\rank::scorepointspopup(int(var0));
  waitframe();
  score_calculate();
}

function score_calculate(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  level.score["subtotal"] = level.score["target_hit"];
  level.score["total"] = level.score["subtotal"] + level.score["trickshot"];
  _tablethide::trial_ui_set_subscore(level.score["total"]);
  hud_set_reward_tier();

  if(var0) {
    wait 1;

    if(istrue(level.trial_fail_alt)) {
      level.score["subtotal"] = 0;
      level.score["total"] = 0;
      level.score["trickshot"] = 0;
      level.trial_fail_alt = 0;
    }

    _tablethide::trial_ui_set_stat_and_bonus_score(1, "special_target_hit", 0, level.score["trickshot"]);
    _tablethide::trial_ui_set_secondary_timer(-1);
    _tablethide::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      _tablethide::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["best_trickshot"] = level.score["trickshot"];
    }

    hud_set_reward_tier(1);
    level notify("course_ended");
    thread _tablethide::trial_ui_open_results_screen();
    level waittill("trial_results_screen_opened");
    _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
    return;
  }
}

function hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["trickshot"] = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
}

function hud_set_reward_tier(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0) {
    var1 = level.score["best"];
  } else {
    var1 = level.score["subtotal"] + level.score["trickshot"];
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

function hud_inter_round_flow(var0) {
  _tablethide::trial_ui_freeze_secondary_timer(1);
  level.player playSound("trial_sfx_success");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level.player playSound("trial_sfx_start");
  level.target_wave = var0;
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

function dialog_init() {
  game["dialog"]["trial_intro"] = "mp_spear_intro";
  game["dialog"]["trial_intro_short"] = "mp_spear_intro_short";
  game["dialog"]["trial_end_tier_0"] = "mp_spear_end_0star";
  game["dialog"]["trial_end_tier_1"] = "mp_spear_end_1star";
  game["dialog"]["trial_end_tier_2"] = "mp_spear_end_2star";
  game["dialog"]["trial_end_tier_3"] = "mp_spear_end_3star";
  game["dialog"]["trial_retry"] = "kh_sniper_retry";
  game["dialog"]["sniper_start"] = "kh_sniper_start";
  game["dialog"]["sniper_search"] = "kh_sniper_search";
  game["dialog"]["sniper_nice_shot"] = "mp_spear_obj_hit";
  game["dialog"]["sniper_hurry_up"] = "mp_spear_obj_nag";
  game["dialog"]["sniper_try_again"] = "mp_spear_obj_miss";
  game["dialog"]["trickshot"] = "mp_spear_throw_special";
  thread light_tank_monitordriverturretprojectilefire();
  thread dialog_missed_shots_watcher();
}

function light_tank_monitordriverturretprojectilefire() {
  level.light_tank_initdamage = 1;

  for(;;) {
    level waittill("dialog");
    wait 10;
    level.light_tank_initdamage = 1;
  }
}

function dialog_missed_shots_watcher() {
  level.ref_11c48 = 0;

  for(;;) {
    level waittill("new_wave");
    level.ref_132bb = 3;
    level_use_carepackage();
  }
}

function level_use_carepackage() {
  level endon("wave ended");

  for(;;) {
    level.player waittill("grenade_fire", var0);
    var0.spawn_infil_lbravo = 0;
    thread level_spawnplayer(var0);
  }
}

function level_spawnplayer(var0) {
  var1 = 0;

  while(isDefined(var0)) {
    var1 = var0.spawn_infil_lbravo;
    waitframe();
  }

  if(!var1) {
    level.ref_11c48++;

    if(level.ref_11c48 >= level.ref_132bb) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_hurry_up");
      level.ref_11c48 = 0;
      level.ref_132bb++;
      return;
    }

    return;
  }

  level.ref_11c48 = 0;
}

function ref_12160() {
  var0 = getEnt("grenade_box", "targetname");

  while(!isalive(level.player)) {
    waitframe();
  }

  var1 = scripts\mp\utility\outline::outlineenableforplayer(var0, level.player, "outline_trial_item", "level_script");
  level waittill("start");
  scripts\mp\utility\outline::outlinedisable(var1, var0);
}

function set_chopper_search_speed() {
  for(;;) {
    level.player waittill("grenade_fire", var0);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), var0, "tag_origin");
  }
}

function ref_12a90(var0, var1) {
  var2 = var0.rechargeequipmentstate;

  if(!isDefined(var2.progress[var1])) {
    var2.progress[var1] = 0;
  }

  var2.recharged[var1] = undefined;
  var3 = var0 scripts\mp\equipment::getcurrentequipment(var1);

  if(!isDefined(var3)) {
    return;
  }

  var4 = var0 scripts\mp\equipment::getequipmentammo(var3);
  var5 = var0 scripts\mp\equipment::getequipmentmaxammo(var3);
  var6 = var0 scripts\mp\equipment::getequipmentstartammo(var3);

  if(var4 < var5) {
    var2.progress[var1] += 0.166667;
  } else {
    var2.progress[var1] = 0;
  }

  if(var2.progress[var1] >= 1) {
    var0 scripts\mp\equipment::incrementequipmentslotammo(var1, 1);
    var2.progress[var1] = 0;
    var2.recharged[var1] = 1;
    return;
  }
}

function ref_12a8f() {
  while(!isalive(level.player)) {
    waitframe();
  }

  for(;;) {
    while(isalive(level.player)) {
      ref_12a91(level.player);
      wait 0.1;
    }

    waitframe();
  }
}

function ref_12a91(var0) {
  if(!isDefined(var0.rechargeequipmentstate)) {
    var0.rechargeequipmentstate = spawnStruct();
    var0.rechargeequipmentstate.progress = [];
    var0.rechargeequipmentstate.recharged = [];
  }

  ref_12a90(var0, "primary");
  ref_12a90(var0, "secondary");
  ref_12a92(var0);
}

function ref_12a92(var0) {
  var1 = 0;
  var2 = 0;
  var3 = -1;

  if(isDefined(var0) && isDefined(var0.rechargeequipmentstate)) {
    var0 scripts\mp\utility\stats::initpersstat("restockCount");
    var4 = var0.rechargeequipmentstate;

    if(isDefined(var4.progress["primary"])) {
      var1 = var4.progress["primary"];
    }

    if(isDefined(var4.progress["secondary"])) {
      var2 = var4.progress["secondary"];
    }

    foreach(var6 in var4.recharged) {
      if(var7 == "primary") {
        var3 += 1;
        var0 playlocalsound("ui_restock_lethals");
        var0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(var7 == "secondary") {
        var3 += 2;
        var0 playlocalsound("ui_restock_tactical");
        var0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  var0 setclientomnvar("ui_lethal_recharge_progress", var1);
  var0 setclientomnvar("ui_tactical_recharge_progress", var2);
  var0 setclientomnvar("ui_recharge_notify", var3);
}

function script_gameobjetname() {
  level waittill("start");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player)) {
        waitframe();
      }

      var0 = "primary";
      level.player scripts\mp\equipment::giveequipment("equip_frag", var0);
    }

    waitframe();
  }
}

function weapon_xp_iw8_sn_awhiskey() {
  level.ref_12d3a = getEntArray("rifle", "targetname");
  level.ref_12382 = getEntArray("pitcher", "targetname");
  wait 0.05;
  jumpiffalse(level.trial["missionID"] == 801 || true) LOC_0000009c;

  foreach(var1 in level.ref_12d3a) {
    var1 setlightintensity(0);
  }

  foreach(var1 in level.ref_12382) {
    var1 setlightintensity(5);
  }

  return;
}

function player_monitor_death() {
  for(;;) {
    level waittill("new_wave");
    level.player waittill("death");
    level.trial_fail_alt = 1;
    setomnvar("ui_trial_failed", 1);
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d37;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_trickshot"] = 0;
    return;
  }
}

function ref_13d37() {
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_score");
  var3 = int(game["trial"]["analytics"]["best_trickshot"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_pitcher", ["id", var0, "tier", var1, "score", var2, "specials", var3]);
}