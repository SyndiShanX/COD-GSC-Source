/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_pitcher.gsc
***********************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["pitcher"] = ::init;
}

init() {
  analytics_init();
  level._effect["vfx_flare_trail"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_grenade.vfx");
  level._effect["vfx_light_red"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_window_light_red.vfx");
  level._effect["vfx_light_green"] = loadfx("vfx/iw8_mp/trials/t_reflex/vfx_trials_window_light_green.vfx");
  dialog_init();
  level_light();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_targets = getEntArray("hole_target", "targetname");
  level.movers = getEntArray("mover", "targetname");
  level.movers_ref = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  level.lights = getEntArray("target_light", "targetname");
  scripts\mp\trials\trial_utility::waittill_player_isDefined();
  thread player_init();
  thread outline_grenade_box();
  thread give_player_grenade_on_respawn();
  thread recharge_equipment_think_init();
  thread start_box_set_up();
  thread grenade_trail_modifier();
  thread player_monitor_death();

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_B8E70FF71A02E32D.linked = 0;
    _id_B8E70FF71A02E32D thread target_think();
  }

  foreach(light in level.lights)
  light thread light_target_init();

  foreach(mover in level.movers)
  mover thread mover_init();

  hud_init();
  progression_update();
}

progression_update() {
  level waittill("start");

  for(;;) {
    trial_score_init();
    level.target_wave = 0;
    course_start_wait();
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
    wave_single_progression(level.targets, 1);
    score_calculate(1);
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);
    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
    level notify("retry");
    level.player freezecontrols(0);

    foreach(light in level.lights)
    light light_switch(0, 1);

    foreach(_id_B8E70FF71A02E32D in level.course_targets)
    _id_B8E70FF71A02E32D thread target_think();
  }
}

start_box_set_up() {
  interaction = getEnt("grenade_box", "targetname");
  interaction makeusable();
  interaction setHintString(&"MP_INGAME_ONLY/PRESS_TO_START_GAME");
  interaction setCursorHint("hint_button");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(65);
  interaction setuserange(72);
  interaction setusefov(120);
  interaction sethintonobstruction("show");
  interaction setuseholdduration("duration_short");
  interaction waittill("trigger");
  level notify("start");
  level.player scripts\mp\equipment::giveequipment("equip_frag", "primary");
  level.player playSound("gren_pickup_frag");
  interaction makeunusable();
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

wave_single_progression(_id_A70B7A6E345A07BA, _id_A2B11613E4C46ED8) {
  hud_inter_round_flow(_id_A2B11613E4C46ED8);
  level notify("new_wave");
  level.target_wave = _id_A2B11613E4C46ED8;
  start_time = gettime();
  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(start_time + 60000);
  _id_7B7C074E22703334 = 1;

  while(isalive(level.player)) {
    if(gettime() > start_time + 60000) {
      break;
    }

    if(!scripts\engine\utility::flag("endwave_audiocountdown_running") && gettime() > start_time + 60000 - 5000) {
      scripts\engine\utility::flag_set("endwave_audiocountdown_running");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  level notify("wave ended");
  level.player thread grenade_menu_kill();
  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
  _id_ADCB7CA63AD93F7F = clamp(start_time + 60000 - gettime(), 0, 60000);
}

player_init() {
  while(!isalive(level.player))
    waitframe();

  _id_C094DB262CE4DFA0 = "iw8_knife_mp";
  level.player giveweapon("iw9_me_fists_mp");
  level.player giveweapon(_id_C094DB262CE4DFA0);
  level.player switchtoweapon(_id_C094DB262CE4DFA0);
}

grenade_menu_kill() {
  level endon("retry");
  wait 0.5;

  for(;;) {
    self.gastakenweaponobj = self getheldoffhand();

    if(isDefined(self.gastakenweaponobj)) {
      equipmentref = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

      if(isDefined(equipmentref) && scripts\mp\equipment::hasequipment(equipmentref)) {
        self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(equipmentref);
        self takeweapon(self.gastakenweaponobj);
        waitframe();
        level.player scripts\mp\equipment::giveequipment("equip_frag", "primary");
        level.player freezecontrols(1);
      }
    }

    waitframe();
  }
}

trial_failure_countdown() {
  for(t = 5; t > 0; t--) {
    level endon("wave ended");
    level.player playSound("trial_sfx_failure_countdown");
    wait 1;
  }

  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
}

target_think() {
  level endon("wave ended");
  level.player endon("dead");
  self endon("times up");

  for(;;) {
    self.activated = 0;
    level waittill("new_wave");

    if(isDefined(level.trial["variant"])) {
      if(level.trial["variant"] == "mover") {
        if(isDefined(self.script_parameters) && isDefined(self.light)) {
          wait(20.0 * (int(self.script_parameters) - 1));
          thread time_watcher();
        }
      }
    }

    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.activated = 1;

    for(;;) {
      level.player waittill("grenade_fire", grenade);

      if(!self.activated) {
        break;
      }

      thread target_check_grenade(grenade);
    }
  }
}

time_watcher() {
  self endon("activated");
  wait 15.0;

  if(self.activated) {
    _id_B0C18169A8786FCE = 0.25;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8.0; _id_AC0E594AC96AA3A8++) {
      self.light light_switch(1);
      wait(_id_B0C18169A8786FCE);
      self.light light_switch(0, 1);
      wait(_id_B0C18169A8786FCE);
    }
  }

  waitframe();
  self.activated = 0;
  waitframe();
  self notify("times up");
}

light_target_init() {
  _id_26ADA541DF1EDC8E = sortbydistance(level.course_targets, self.origin);

  if(isDefined(self.target)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_26ADA541DF1EDC8E.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].target)) {
        if(_id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].target == self.target && _id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].linked == 0) {
          _id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].linked = 1;
          self.closest_target = _id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8];
          break;
        }
      }
    }
  } else {
    if(distance(_id_26ADA541DF1EDC8E[0].origin, self.origin) >= 150) {
      light_switch(0);
      return;
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_26ADA541DF1EDC8E.size; _id_AC0E594AC96AA3A8++) {
      if(_id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].linked == 0) {
        _id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8].linked = 1;
        self.closest_target = _id_26ADA541DF1EDC8E[_id_AC0E594AC96AA3A8];
        break;
      }
    }
  }

  if(!isDefined(self.closest_target)) {
    light_switch(0);
    return;
  }

  self.closest_target.light = self;
  thread light_target_update();
}

light_target_update() {
  light_switch(0, 1);

  for(;;) {
    level waittill("new_wave");

    while(!self.closest_target.activated)
      waitframe();

    light_switch(1);
    light_target_desactivate_check();
  }
}

light_target_desactivate_check() {
  level endon("wave ended");
  level.player endon("death");

  for(;;) {
    if(!self.closest_target.activated) {
      light_switch(0);
      break;
    }

    waitframe();
  }
}

light_switch(on, _id_ECF0313EA0210ABD) {
  if(istrue(self.fxgreen)) {
    killfxontag(scripts\engine\utility::getfx("vfx_light_green"), self, "stationary_trainyard_signal_lights_01_green_spdball");
    self.fxgreen = 0;
  }

  if(istrue(self.fxred)) {
    killfxontag(scripts\engine\utility::getfx("vfx_light_red"), self, "stationary_trainyard_signal_lights_01_red_spdball");
    self.fxred = 0;
  }

  waitframe();

  if(istrue(_id_ECF0313EA0210ABD))
    self setModel("stationary_trainyard_signal_lights_01_spdball_off");
  else {
    waitframe();

    if(on) {
      self setModel("stationary_trainyard_signal_lights_01_green_spdball");
      self.fxgreen = 1;
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("vfx_light_green"), self, "stationary_trainyard_signal_lights_01_green_spdball");
      return;
    }

    self setModel("stationary_trainyard_signal_lights_01_red_spdball");
    self.fxred = 1;
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("vfx_light_red"), self, "stationary_trainyard_signal_lights_01_red_spdball");
  }
}

target_check_grenade(grenade) {
  level endon("target_hit");

  while(isDefined(grenade)) {
    if(!isDefined(self.script_targettype)) {
      if(self istouching(grenade)) {
        self.activated = 0;
        grenade.hit = 1;
        self notify("activated");
        thread score_event_target_hit(self.script_noteworthy, self);

        if(isDefined(self.light))
          level.player playSound("trial_sfx_success");
        else {
          level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("trickshot");
          level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
        }

        level notify("target_hit");
        break;
      }
    } else if(distancesquared(grenade.origin, self.origin) < 361) {
      self.activated = 0;
      grenade.hit = 1;
      self notify("activated");
      thread score_event_target_hit(self.script_noteworthy, self);

      if(!isDefined(self.script_targettype))
        level.player playSound("trial_sfx_success");
      else {
        level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("trickshot");
        level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
      }

      level notify("target_hit");
      break;
    }

    waitframe();
  }
}

mover_init() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers_ref, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  for(;;) {
    level waittill("new_wave");
    mover_update();
  }
}

mover_update() {
  for(;;) {
    _id_6B8A3F291F2D537E = self.mover_ends[self.moveforward];
    dist = distance(self.origin, _id_6B8A3F291F2D537E.origin);
    time = dist / self.move_speed;
    time = clamp(time, 0.05, 9999);
    accel = 0.5;
    self moveTo(_id_6B8A3F291F2D537E.origin, time, accel, accel);
    wait(time);
    self.moveforward = !self.moveforward;
  }
}

trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
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

score_event_target_hit(target_score, _id_B796D497E2879B76) {
  if(!isDefined(target_score))
    target_score = 100;

  if(int(target_score) >= 300 && isDefined(_id_B796D497E2879B76.light) && level.dialog_wait_ready) {
    level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
    level.dialog_wait_ready = 0;
    level notify("dialog");
  }

  if(isDefined(self.script_targettype) && level.trial["variant"] == "mover") {
    if(isDefined(self.script_parameters))
      target_score = int(target_score) - int(self.script_parameters);
  }

  if(!isDefined(self.script_targettype))
    level.score["target_hit"] = level.score["target_hit"] + int(target_score);

  level.player thread scripts\mp\rank::scorepointspopup(int(target_score));
  waitframe();
  score_calculate();
}

score_calculate(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  level.score["subtotal"] = level.score["target_hit"];
  level.score["total"] = level.score["subtotal"] + level.score["trickshot"];
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["total"]);
  hud_set_reward_tier();

  if(_id_9B106ABAC2185216) {
    wait 1;

    if(istrue(level.trial_fail_alt)) {
      level.score["subtotal"] = 0;
      level.score["total"] = 0;
      level.score["trickshot"] = 0;
      level.trial_fail_alt = 0;
    }

    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(1, "special_target_hit", 0, level.score["trickshot"]);
    scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(-1);
    scripts\mp\trials\trial_utility::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["best_trickshot"] = level.score["trickshot"];
    }

    hud_set_reward_tier(1);
    level notify("course_ended");
    thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
    level waittill("trial_results_screen_opened");
    scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["subtotal"]);
  }
}

hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["trickshot"] = 0;
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(0);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_icon_index(1);
}

hud_set_reward_tier(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  if(_id_9B106ABAC2185216)
    score = level.score["best"];
  else
    score = level.score["subtotal"] + level.score["trickshot"];

  if(score >= level.trial["tier3"])
    reward_tier = 3;
  else if(score >= level.trial["tier2"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier3"] - level.trial["tier2"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier2"];
    reward_tier = 2 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else if(score >= level.trial["tier1"]) {
    _id_35E5BF7121C0BEB8 = level.trial["tier2"] - level.trial["tier1"];
    _id_0FC98BF0FDE7BAE9 = score - level.trial["tier1"];
    reward_tier = 1 + _id_0FC98BF0FDE7BAE9 / _id_35E5BF7121C0BEB8;
  } else
    reward_tier = score / level.trial["tier1"];

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier(reward_tier);

    if(score >= level.trial["tier3"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_high"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_high"][_id_DCC499C9734611F8]);
      return;
    }

    if(score >= level.trial["tier2"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_mid"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][_id_DCC499C9734611F8]);
      return;
    }

    if(score >= level.trial["tier1"]) {
      _id_17C8D9E220164807 = game["music"]["trials_win_low"].size;
      _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
      level.player setplayermusicstate(game["music"]["trials_win_low"][_id_DCC499C9734611F8]);
      return;
    }

    _id_17C8D9E220164807 = game["music"]["trials_loss"].size;
    _id_DCC499C9734611F8 = randomint(_id_17C8D9E220164807);
    level.player setplayermusicstate(game["music"]["trials_loss"][_id_DCC499C9734611F8]);
    return;
    return;
    return;
  } else
    scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(reward_tier);
}

hud_inter_round_flow(_id_C5CF558181E12D1F) {
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(1);
  level.player playSound("trial_sfx_success");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level.player playSound("trial_sfx_start");
  level.target_wave = _id_C5CF558181E12D1F;
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

dialog_init() {
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
  thread dialog_wait_think();
  thread dialog_missed_shots_watcher();
}

dialog_wait_think() {
  level.dialog_wait_ready = 1;

  for(;;) {
    level waittill("dialog");
    wait 10;
    level.dialog_wait_ready = 1;
  }
}

dialog_missed_shots_watcher() {
  level.missed_shots = 0;

  for(;;) {
    level waittill("new_wave");
    level.shot_to_miss_for_dialog = 3;
    dialog_grenade_update();
  }
}

dialog_grenade_update() {
  level endon("wave ended");

  for(;;) {
    level.player waittill("grenade_fire", grenade);
    grenade.hit = 0;
    thread dialog_grenade_missed(grenade);
  }
}

dialog_grenade_missed(grenade) {
  _id_C5ECDCB9601AE940 = 0;

  while(isDefined(grenade)) {
    _id_C5ECDCB9601AE940 = grenade.hit;
    waitframe();
  }

  if(!_id_C5ECDCB9601AE940) {
    level.missed_shots++;

    if(level.missed_shots >= level.shot_to_miss_for_dialog) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_hurry_up");
      level.missed_shots = 0;
      level.shot_to_miss_for_dialog++;
    }
  } else
    level.missed_shots = 0;
}

outline_grenade_box() {
  _id_588A78285FB3AE3F = getEnt("grenade_box", "targetname");

  while(!isalive(level.player))
    waitframe();

  _id_EDC14110330AD917 = scripts\mp\utility\outline::outlineenableforplayer(_id_588A78285FB3AE3F, level.player, "outline_trial_item", "level_script");
  level waittill("start");
  scripts\mp\utility\outline::outlinedisable(_id_EDC14110330AD917, _id_588A78285FB3AE3F);
}

grenade_trail_modifier() {
  for(;;) {
    level.player waittill("grenade_fire", grenade);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flare_trail"), grenade, "tag_origin");
  }
}

recharge_equipment_update_slot(player, slot) {
  state = player.rechargeequipmentstate;

  if(!isDefined(state.progress[slot]))
    state.progress[slot] = 0;

  state.recharged[slot] = undefined;
  equipment = player scripts\mp\equipment::getcurrentequipment(slot);

  if(!isDefined(equipment)) {
    return;
  }
  ammo = player scripts\mp\equipment::getequipmentammo(equipment);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipment);
  startammo = player scripts\mp\equipment::getequipmentstartammo(equipment);

  if(ammo < ammomax)
    state.progress[slot] = state.progress[slot] + 0.166667;
  else
    state.progress[slot] = 0;

  if(state.progress[slot] >= 1) {
    player scripts\mp\equipment::incrementequipmentslotammo(slot, 1);
    state.progress[slot] = 0;
    state.recharged[slot] = 1;
  }
}

recharge_equipment_think_init() {
  while(!isalive(level.player))
    waitframe();

  for(;;) {
    while(isalive(level.player)) {
      recharge_equipment_update_state(level.player);
      wait 0.1;
    }

    waitframe();
  }
}

recharge_equipment_update_state(player) {
  if(!isDefined(player.rechargeequipmentstate)) {
    player.rechargeequipmentstate = spawnStruct();
    player.rechargeequipmentstate.progress = [];
    player.rechargeequipmentstate.recharged = [];
  }

  recharge_equipment_update_slot(player, "primary");
  recharge_equipment_update_slot(player, "secondary");
  recharge_equipment_update_ui(player);
}

recharge_equipment_update_ui(player) {
  _id_EA6C6F327A8C9B68 = 0;
  _id_A26D8AB03F8D1BCB = 0;
  _id_7732B71EB53C0AF1 = -1;

  if(isDefined(player) && isDefined(player.rechargeequipmentstate)) {
    player scripts\mp\utility\stats::initpersstat("restockCount");
    state = player.rechargeequipmentstate;

    if(isDefined(state.progress["primary"]))
      _id_EA6C6F327A8C9B68 = state.progress["primary"];

    if(isDefined(state.progress["secondary"]))
      _id_A26D8AB03F8D1BCB = state.progress["secondary"];

    foreach(slot, _ in state.recharged) {
      if(slot == "primary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 1;
        player playlocalsound("ui_restock_lethals");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(slot == "secondary") {
        _id_7732B71EB53C0AF1 = _id_7732B71EB53C0AF1 + 2;
        player playlocalsound("ui_restock_tactical");
        player scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  player setclientomnvar("ui_lethal_recharge_progress", _id_EA6C6F327A8C9B68);
  player setclientomnvar("ui_tactical_recharge_progress", _id_A26D8AB03F8D1BCB);
  player setclientomnvar("ui_recharge_notify", _id_7732B71EB53C0AF1);
}

give_player_grenade_on_respawn() {
  level waittill("start");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player))
        waitframe();

      slot = "primary";
      level.player scripts\mp\equipment::giveequipment("equip_frag", slot);
    }

    waitframe();
  }
}

level_light() {
  level.rifle_lights = getEntArray("rifle", "targetname");
  level.pitcher_lights = getEntArray("pitcher", "targetname");
  wait 0.05;

  if(level.trial["missionID"] == 801 || 802) {
    foreach(light in level.rifle_lights)
    light setlightintensity(0);

    foreach(light in level.pitcher_lights)
    light setlightintensity(5);
  } else {
    foreach(light in level.rifle_lights)
    light setlightintensity(0);

    foreach(light in level.pitcher_lights)
    light setlightintensity(0);
  }
}

player_monitor_death() {
  for(;;) {
    level waittill("new_wave");
    level.player waittill("death");
    level.trial_fail_alt = 1;
    setomnvar("ui_trial_failed", 1);
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_pitcher;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_trickshot"] = 0;
  }
}

trial_dlog_pitcher() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  score = getomnvar("ui_trial_best_score");
  _id_3B2D10C22DF01E55 = int(game["trial"]["analytics"]["best_trickshot"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_pitcher", ["id", id, "tier", tier, "score", score, "specials", _id_3B2D10C22DF01E55]);
}