/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_sniper.gsc
***********************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  if(isDefined(level.trial["triggeredTrialName"]))
    level.trial_missionscript_init_funcs["sniper"] = ::_id_954C82822929117F;
  else
    level.trial_missionscript_init_funcs["sniper"] = ::sniper_init;
}

sniper_init() {
  analytics_init();

  if(!isDefined(level.headicon_time_left))
    level.headicon_time_left = 7500;

  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  _id_E9AC9DC3DAC1BFDC = getEntArray("target_brushmodel", "script_noteworthy");

  foreach(geo in _id_E9AC9DC3DAC1BFDC) {
    geo.targetname = "null";
    geo.target = "null";
  }

  while(!isDefined(level.struct_class_names))
    waitframe();

  dialog_init();
  progression();
}

_id_954C82822929117F(_id_0B8B9E9EFD754D14) {
  analytics_init();

  if(!isDefined(level.headicon_time_left))
    level.headicon_time_left = 7500;

  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  _id_E9AC9DC3DAC1BFDC = getEntArray("target_brushmodel", "script_noteworthy");

  foreach(geo in _id_E9AC9DC3DAC1BFDC) {
    geo.targetname = "null";
    geo.target = "null";
  }

  while(!isDefined(level.struct_class_names))
    waitframe();

  dialog_init();
  _id_4471DC3B999A3ACD(_id_0B8B9E9EFD754D14);
}

progression() {
  level.course_triggers = getEntArray("progression", "targetname");
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_B8E70FF71A02E32D.activated = 0;
    _id_B8E70FF71A02E32D thread target_think();
  }

  level.trial_flares = getEntArray("trial_flare", "targetname");

  if(isDefined(level.trial_flares))
    scripts\engine\utility::array_thread(level.trial_flares, ::trial_thermite_watcher);

  level.trial_targs[1] = getEntArray("wave1", "targetname");
  level.trial_targs[2] = getEntArray("wave2", "targetname");
  level.trial_targs[3] = getEntArray("wave3", "targetname");
  level.trial_targs[4] = getEntArray("wave4", "targetname");
  level.player thread infinite_reserve_ammo_not_revolver();
  level.player scripts\mp\utility\perk::giveperk("specialty_quickswap");
  level.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  hud_init();

  for(;;) {
    trial_score_init();
    score_event_time_remaining(25000, 25000, 25000, 25000);
    level.target_wave = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_wave(1, 4);
    course_start_wait();
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
    wave_single_progression(level.trial_targs[1], 1);
    wave_single_progression(level.trial_targs[2], 2);
    wave_single_progression(level.trial_targs[3], 3);
    wave_single_progression(level.trial_targs[4], 4);
    score_calculate(1);
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);

    foreach(_id_DE88CD14114C1E24 in level.player.primaryinventory)
    level.player setweaponammoclip(_id_DE88CD14114C1E24, weaponclipsize(_id_DE88CD14114C1E24));

    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
    level notify("trial_retry");
  }
}

_id_4471DC3B999A3ACD(_id_0B8B9E9EFD754D14) {
  level.course_targets = _id_A3AD0950541E4A94(_id_0B8B9E9EFD754D14);
  level.movers = scripts\mp\trials\trial_utility::_id_BB06080B145E3C85(_id_0B8B9E9EFD754D14);
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_B8E70FF71A02E32D.activated = 0;
    _id_B8E70FF71A02E32D thread target_think();

    if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF()) {
      parts = getEntArray(_id_B8E70FF71A02E32D.script_linkname, "script_linkto");
      parts = scripts\engine\utility::array_remove(parts, _id_B8E70FF71A02E32D);

      foreach(part in parts)
      part setCanDamage(0);
    }
  }

  level.trial_flares = getEntArray("trial_flare", "targetname");

  if(isDefined(level.trial_flares))
    scripts\engine\utility::array_thread(level.trial_flares, ::trial_thermite_watcher);

  level.trial_targs[1] = _id_1A0946696656AAE3(1, _id_0B8B9E9EFD754D14);
  level.trial_targs[2] = _id_1A0946696656AAE3(2, _id_0B8B9E9EFD754D14);
  level.trial_targs[3] = _id_1A0946696656AAE3(3, _id_0B8B9E9EFD754D14);
  level.trial_targs[4] = _id_1A0946696656AAE3(4, _id_0B8B9E9EFD754D14);
  level.player scripts\mp\utility\perk::giveperk("specialty_quickswap");
  level.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  hud_init();

  for(;;) {
    trial_score_init();
    score_event_time_remaining(25000, 25000, 25000, 25000);
    level.target_wave = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_wave(1, 4);
    _id_7AC0F6E3DA4B43E4(_id_0B8B9E9EFD754D14);
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);
    wave_single_progression(level.trial_targs[1], 1);
    wave_single_progression(level.trial_targs[2], 2);
    wave_single_progression(level.trial_targs[3], 3);
    wave_single_progression(level.trial_targs[4], 4);
    score_calculate(1);
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);

    foreach(_id_DE88CD14114C1E24 in level.player.primaryinventory)
    level.player setweaponammoclip(_id_DE88CD14114C1E24, weaponclipsize(_id_DE88CD14114C1E24));

    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
    level notify("trial_retry");
  }
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  _id_881E7D75E23A919A = getEnt("outline", "script_noteworthy");

  while(!isDefined(_id_881E7D75E23A919A.spawned_weapon))
    waitframe();

  while(isDefined(_id_881E7D75E23A919A.spawned_weapon))
    waitframe();

  level notify("trial_start");
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

_id_7AC0F6E3DA4B43E4(_id_0B8B9E9EFD754D14) {
  if(istrue(level.trial_first_start)) {
    return;
  }
  level notify("trial_start");
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

wave_single_progression(_id_A70B7A6E345A07BA, _id_A2B11613E4C46ED8) {
  hud_inter_round_flow(_id_A2B11613E4C46ED8);
  level notify("new_wave");
  level.target_wave = _id_A2B11613E4C46ED8;
  scripts\mp\trials\trial_utility::trial_ui_set_wave(level.target_wave, 4);
  start_time = gettime();
  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(start_time + 25000);
  _id_7B7C074E22703334 = 1;

  foreach(_id_B8E70FF71A02E32D in _id_A70B7A6E345A07BA)
  _id_B8E70FF71A02E32D thread target_flip("up");

  _id_21A7F6CCA7D3CC82 = 0;

  for(;;) {
    _id_2FB79D99876506A7 = 1;

    foreach(_id_B8E70FF71A02E32D in _id_A70B7A6E345A07BA) {
      if(!_id_B8E70FF71A02E32D.activated && !isDefined(_id_B8E70FF71A02E32D.is_civilian))
        _id_2FB79D99876506A7 = 0;
    }

    if(_id_2FB79D99876506A7) {
      break;
    }

    if(gettime() > start_time + 25000 - level.headicon_time_left && istrue(level.trial_use_headicon) && !_id_21A7F6CCA7D3CC82) {
      _id_21A7F6CCA7D3CC82 = 1;
      thread hint_target_think(_id_A70B7A6E345A07BA, 1);
    }

    if(gettime() > start_time + 25000) {
      break;
    }

    if(!scripts\engine\utility::flag("endwave_audiocountdown_running") && gettime() > start_time + 25000 - 5000) {
      scripts\engine\utility::flag_set("endwave_audiocountdown_running");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  if(istrue(level.trial_use_headicon))
    thread hint_target_think(_id_A70B7A6E345A07BA, 0);

  level notify("wave_ended", _id_A2B11613E4C46ED8);
  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
  _id_ADCB7CA63AD93F7F = clamp(start_time + 25000 - gettime(), 0, 25000);

  foreach(_id_B8E70FF71A02E32D in _id_A70B7A6E345A07BA)
  _id_B8E70FF71A02E32D thread target_flip("down");

  switch (_id_A2B11613E4C46ED8) {
    case 1:
      score_event_time_remaining(_id_ADCB7CA63AD93F7F, undefined, undefined, undefined);
      break;
    case 2:
      score_event_time_remaining(undefined, _id_ADCB7CA63AD93F7F, undefined, undefined);
      break;
    case 3:
      score_event_time_remaining(undefined, undefined, _id_ADCB7CA63AD93F7F, undefined);
      break;
    case 4:
      score_event_time_remaining(undefined, undefined, undefined, _id_ADCB7CA63AD93F7F);
      break;
    default:
      break;
  }
}

hint_target_think(_id_A70B7A6E345A07BA, _id_7CAE93055DAE77EC) {
  foreach(_id_B8E70FF71A02E32D in _id_A70B7A6E345A07BA) {
    if(_id_7CAE93055DAE77EC) {
      if(!_id_B8E70FF71A02E32D.activated && !isDefined(_id_B8E70FF71A02E32D.is_civilian)) {
        _id_B8E70FF71A02E32D.headicon = createheadicon(_id_B8E70FF71A02E32D);
        setheadiconimage(_id_B8E70FF71A02E32D.headicon, "icon_navbar_enemy");
        setheadiconmaxdistance(_id_B8E70FF71A02E32D.headicon, 30000);
        setheadiconzoffset(_id_B8E70FF71A02E32D.headicon, 75);
      }

      continue;
    }

    if(!_id_B8E70FF71A02E32D.activated) {
      if(isDefined(_id_B8E70FF71A02E32D.headicon)) {
        deleteheadicon(_id_B8E70FF71A02E32D.headicon);
        _id_B8E70FF71A02E32D.headicon = undefined;
      }
    }
  }
}

trial_failure_countdown() {
  for(t = 5; t > 0; t--) {
    level endon("wave_ended");
    level.player playSound("trial_sfx_failure_countdown");
    wait 1;
  }

  scripts\engine\utility::flag_clear("endwave_audiocountdown_running");
}

target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(part in self.parts) {
    switch (part.script_noteworthy) {
      case "target_plate":
        self.plate = part;

        if(isDefined(self.plate.target))
          self.plate.has_termal = 1;

        break;
      case "target_arm":
        self.arm = part;
        break;
      case "target_base":
        self.base = part;
        break;
      case "target_wheels":
        self.wheels = part;
        break;
      case "target_glint":
        self.glint = part;
        break;
      case "target_smoke":
        self.smoke = part;
        break;
      default:
        break;
    }

    part.target = "null";
    part.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.glint))
    self.glint linkTo(self);

  if(istrue(self.plate.has_termal))
    self.plate thermaldrawdisable();

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  if(isDefined(self.smoke))
    self.smoke linkTo(self);

  self.state_up = 0;
  self.flipping = 0;
  thread target_damage();
  self.activated = 0;

  if(issubstr(self.script_noteworthy, "moving"))
    thread moving_target_think();

  if(issubstr(self.script_noteworthy, "civilian"))
    self.is_civilian = 1;
}

gettargetarray() {
  _id_3CA8A977F230716E = ["standard_target", "moving_target", "civilian_target"];
  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    if(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8] == "civilian_target") {
      if(level.trial["variant"] == "pistol") {
        continue;
      }
      if(_id_15684233DC41D60A[_id_AC0E594AC96AA3A8].size > 0)
        level.have_civilian = 1;
    }

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      ent = spawn("script_origin", struct.origin);
      ent.angles = struct.angles;
      ent.script_gameobjectname = struct.script_gameobjectname;
      ent.script_linkname = struct.script_linkname;
      ent.script_noteworthy = struct.script_noteworthy;
      ent.target = struct.target;
      ent.targetname = struct.targetname;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++)
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

  return scripts\engine\utility::array_combine_multiple(_id_53EE9B445DE3B69B);
}

_id_A3AD0950541E4A94(_id_0B8B9E9EFD754D14) {
  _id_3CA8A977F230716E = ["standard_target", "moving_target", "civilian_target"];
  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    if(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8] == "civilian_target") {
      if(level.trial["variant"] == "pistol") {
        continue;
      }
      if(_id_15684233DC41D60A[_id_AC0E594AC96AA3A8].size > 0)
        level.have_civilian = 1;
    }

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      if(isDefined(struct.script_gameobjectname) && struct.script_gameobjectname == _id_0B8B9E9EFD754D14) {
        ent = spawn("script_origin", struct.origin);
        ent.angles = struct.angles;
        ent.script_gameobjectname = struct.script_gameobjectname;
        ent.script_linkname = struct.script_linkname;
        ent.script_noteworthy = struct.script_noteworthy;
        ent.target = struct.target;
        ent.targetname = struct.targetname;
      }
    }
  }

  _id_A1864B18C79196EE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(_id_E9B06E032AC9E578 in _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8]) {
      if(isDefined(_id_E9B06E032AC9E578.script_gameobjectname) && _id_E9B06E032AC9E578.script_gameobjectname == _id_0B8B9E9EFD754D14)
        _id_A1864B18C79196EE[_id_A1864B18C79196EE.size] = _id_E9B06E032AC9E578;
    }
  }

  return _id_A1864B18C79196EE;
}

_id_1A0946696656AAE3(_id_DCFF5961635938A9, _id_0B8B9E9EFD754D14) {
  _id_A1864B18C79196EE = [];
  _id_8C821E668CBEF366 = [];

  switch (_id_DCFF5961635938A9) {
    case 1:
      _id_8C821E668CBEF366 = getEntArray("wave1", "targetname");
      break;
    case 2:
      _id_8C821E668CBEF366 = getEntArray("wave2", "targetname");
      break;
    case 3:
      _id_8C821E668CBEF366 = getEntArray("wave3", "targetname");
      break;
    case 4:
      _id_8C821E668CBEF366 = getEntArray("wave4", "targetname");
      break;
  }

  foreach(_id_E9B06E032AC9E578 in _id_8C821E668CBEF366) {
    if(isDefined(_id_E9B06E032AC9E578.script_gameobjectname) && _id_E9B06E032AC9E578.script_gameobjectname == _id_0B8B9E9EFD754D14)
      _id_A1864B18C79196EE[_id_A1864B18C79196EE.size] = _id_E9B06E032AC9E578;
  }

  return _id_A1864B18C79196EE;
}

target_damage() {
  for(;;) {
    self.activated = 0;
    self.plate waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    self.plate playSound("trial_sfx_target_report_metal");

    if(isDefined(self.smoke))
      magicgrenademanual("smoke_grenade_mp", self.smoke.origin, (0, 0, -1), 0.05);

    if(!isDefined(level.targethitsinaframecount))
      level.targethitsinaframecount = 0;

    level.targethitsinaframecount++;
    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self.plate, 1, 0, 0);
    level.last_hit_target = self;
    thread target_flip("down");
    self.activated = 1;

    if(isDefined(self.headicon)) {
      deleteheadicon(self.headicon);
      self.headicon = undefined;
    }

    waittillframeend;

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self)
      thread score_event_collateral(level.targethitsinaframecount);

    if(istrue(self.is_civilian)) {
      level.score["civilian_killed"] = level.score["civilian_killed"] + 100;
      scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(5, "civilian_targets_hit", level.score["civilian_killed"] / 100, level.score["civilian_killed"] * -1);
      level.player thread scripts\mp\rank::scoreeventpopup("stat_930B4906CF0D62F7");
      level.player playSound("trial_sfx_buzzer_bad_1");
      waitframe();
      score_calculate();
    } else if(istrue(self.random_end))
      thread score_event_target_hit(200);
    else
      thread score_event_target_hit(100);

    level.targethitsinaframecount = 0;
    level waittill("course_ended");
  }
}

target_flip(_id_F1118C1A072B6415) {
  if(_id_F1118C1A072B6415 == "up") {
    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(isDefined(self.glint))
      self.glintfx = playFXOnTag(scripts\engine\utility::getfx("ambush_sniper_glint"), self.glint, "tag_origin");

    if(self.state_up) {
      return;
    }
    self.state_up = 1;
    sign = 1;
    self.activated = 0;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.glint))
      killfxontag(scripts\engine\utility::getfx("ambush_sniper_glint"), self.glint, "tag_origin");

    if(!self.state_up) {
      return;
    }
    self.state_up = 0;
    sign = -1;
  }

  time = undefined;
  _id_8BC14603A27FA3E7 = undefined;

  switch (self.script_noteworthy) {
    case "moving_target":
    case "civilian_target":
    case "standard_target":
      _id_8BC14603A27FA3E7 = 90;
      time = 0.1;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving"))
    waitframe();

  if(_id_F1118C1A072B6415 == "up")
    self playsoundonmovingent("trial_sfx_target_flipup");

  if(self.initial_up[1] != 0 && abs(self.initial_up[1]) > 0.5)
    self rotateYaw(-1 * self.initial_up[1] * _id_8BC14603A27FA3E7 * sign, time);
  else if(self.initial_up[0] != 0 && abs(self.initial_up[0]) > 0.5)
    self rotateYaw(self.initial_up[0] * _id_8BC14603A27FA3E7 * sign, time);
  else
    self rotatepitch(self.initial_up[2] * _id_8BC14603A27FA3E7 * sign, time);

  wait(time);
  self.flipping = 0;
}

moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");

  if(self.mover_ends.size > 2)
    self.random_end = 1;

  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  while(!isalive(level.player))
    waitframe();

  thread moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.players[0].origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
    } else if(!self.flipping && !self.moving && 90 < distance(level.players[0].origin, self.origin) && self.state_up)
      thread moving_target_mover();

    waitframe();
  }
}

moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  childthread target_follow_dummy();

  for(;;) {
    if(istrue(self.random_end))
      _id_6B8A3F291F2D537E = scripts\engine\utility::random(self.mover_ends);
    else
      _id_6B8A3F291F2D537E = self.mover_ends[self.moveforward];

    dist = distance(self.dummy.origin, _id_6B8A3F291F2D537E.origin);
    time = dist / self.move_speed;
    time = clamp(time, 0.05, 9999);
    accel = 0.5;
    accel = clamp(accel, 0, time / 2);
    self.dummy moveTo(_id_6B8A3F291F2D537E.origin, time, accel, accel);
    wait(time);
    self.moveforward = !self.moveforward;
  }
}

moving_target_reset() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    game["trial"]["analytics"]["wave1time"] = 0;
    game["trial"]["analytics"]["wave2time"] = 0;
    game["trial"]["analytics"]["wave3time"] = 0;
    game["trial"]["analytics"]["wave4time"] = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
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

  if(istrue(level.have_civilian))
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(5, "civilian_targets_hit", level.score["civilian_killed"], level.score["civilian_killed"]);

  score_calculate();
}

score_event_target_hit(target_score) {
  level.score["target_hit"] = level.score["target_hit"] + target_score;
  level.player thread scripts\mp\rank::scorepointspopup(target_score);
  waitframe();
  score_calculate();
}

score_event_collateral(_id_8BBC2903A2793B49) {
  _id_B27E4E078E176E81 = 50 * (_id_8BBC2903A2793B49 - 1);
  level.score["collateral"] = level.score["collateral"] + _id_B27E4E078E176E81;

  switch (_id_8BBC2903A2793B49) {
    case 3:
      _id_655E8F8E75379DAE = "trial_collateral_triple";
      break;
    case 4:
      _id_655E8F8E75379DAE = "trial_collateral_quad";
      break;
    default:
      _id_655E8F8E75379DAE = "trial_collateral";
      break;
  }

  level.player thread scripts\mp\rank::scoreeventpopup(_id_655E8F8E75379DAE);
  level.player thread scripts\mp\rank::scorepointspopup(_id_B27E4E078E176E81);
  level notify("trial_sniper_collateral");
}

score_event_time_remaining(_id_8FE276C01BFFEA6B, _id_8FE277C01BFFEC9E, _id_8FE278C01BFFEED1, _id_8FE279C01BFFF104) {
  if(isDefined(_id_8FE276C01BFFEA6B)) {
    level.score["time_remaining_w1"] = scripts\mp\utility\script::limitdecimalplaces(_id_8FE276C01BFFEA6B / 1000, 1) * 10;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(1, "wave_1_time_remaining", _id_8FE276C01BFFEA6B, level.score["time_remaining_w1"]);
  }

  if(isDefined(_id_8FE277C01BFFEC9E)) {
    level.score["time_remaining_w2"] = scripts\mp\utility\script::limitdecimalplaces(_id_8FE277C01BFFEC9E / 1000, 1) * 10;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(2, "wave_2_time_remaining", _id_8FE277C01BFFEC9E, level.score["time_remaining_w2"]);
  }

  if(isDefined(_id_8FE278C01BFFEED1)) {
    level.score["time_remaining_w3"] = scripts\mp\utility\script::limitdecimalplaces(_id_8FE278C01BFFEED1 / 1000, 1) * 10;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(3, "wave_3_time_remaining", _id_8FE278C01BFFEED1, level.score["time_remaining_w3"]);
  }

  if(isDefined(_id_8FE279C01BFFF104)) {
    level.score["time_remaining_w4"] = scripts\mp\utility\script::limitdecimalplaces(_id_8FE279C01BFFF104 / 1000, 1) * 10;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(4, "wave_4_time_remaining", _id_8FE279C01BFFF104, level.score["time_remaining_w4"]);
  }
}

score_calculate(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  level.score["subtotal"] = level.score["target_hit"] + level.score["collateral"];
  level.score["total"] = level.score["subtotal"] + level.score["time_remaining_w1"] + level.score["time_remaining_w2"] + level.score["time_remaining_w3"] + level.score["time_remaining_w4"] - level.score["civilian_killed"];
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(-1);
    wait 1;

    if(level.score["total"] < 0)
      level.score["total"] = 0;

    scripts\mp\trials\trial_utility::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["wave1time"] = level.score["time_remaining_w1"];
      game["trial"]["analytics"]["wave2time"] = level.score["time_remaining_w2"];
      game["trial"]["analytics"]["wave3time"] = level.score["time_remaining_w3"];
      game["trial"]["analytics"]["wave4time"] = level.score["time_remaining_w4"];
    }

    hud_set_reward_tier(1);
    level notify("course_ended");

    if(scripts\mp\trials\trial_utility::trial_is_event())
      wait 4;

    thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  }
}

hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(0);
  scripts\mp\trials\trial_utility::trial_ui_set_wave(1, 4);
  scripts\mp\trials\trial_utility::trial_ui_set_reward_tier_preview(0);
  scripts\mp\trials\trial_utility::trial_ui_set_objective_icon_index(1);
}

hud_set_reward_tier(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  if(_id_9B106ABAC2185216)
    score = level.score["best"];
  else
    score = level.score["subtotal"];

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
  setomnvar("ui_match_start_text", "wave_" + _id_C5CF558181E12D1F + "_start");
  level.player playSound("trial_sfx_success");

  if(istrue(level.trial_white_phosphorus) && isDefined(level.trial_white_phosphorus_activate) && level.trial_white_phosphorus_activate == _id_C5CF558181E12D1F) {
    _id_EEA2E04619F1C737 = scripts\engine\utility::getStruct("trial_wp", "targetname");
    thread trial_spawn_wp(_id_EEA2E04619F1C737);
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 10);
  } else if(isDefined(level.trial["triggeredTrialName"]) && _id_C5CF558181E12D1F == 1)
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 0);
  else
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);

  level.player setclientomnvar("ui_match_start_countdown", -1);
  setomnvar("ui_match_start_text", "none");
  level.player playSound("trial_sfx_start");
  level.target_wave = _id_C5CF558181E12D1F;
  scripts\mp\trials\trial_utility::trial_ui_set_wave(level.target_wave, 4);
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

dialog_init() {
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
  thread dialog_mount_nag_watcher();
}

dialog_collateral_watcher() {
  for(;;) {
    level waittill("trial_sniper_collateral");
    level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
    wait 5;
  }
}

dialog_missed_shots_watcher() {
  _id_321D3ECA96EF155D = 1;
  _id_25C40BEA73FA0B20 = 1;

  for(;;) {
    level waittill("new_wave");
    level.shotsmissedcount = 0;

    for(;;) {
      level.player waittill("weapon_fired", _id_97282C14346A7FCF, _id_41B5F78FDDAAD23F, _id_7F51BB920D03D261);
      _id_62E0C3ED163E5B8A = anglesToForward(_id_7F51BB920D03D261);
      level.shotsmissedcount++;
      waitframe();

      if(level.shotsmissedcount > 2) {
        if(_id_321D3ECA96EF155D) {
          _id_114AB88507847C50 = undefined;
          _id_8624CAE3C5209AEC = undefined;
          _id_EB785C749968FCD1 = undefined;
          _id_5590D1B33367F2C5 = 360;

          foreach(_id_B8E70FF71A02E32D in level.trial_targs[level.target_wave]) {
            _id_A2BE1458D5F6797B = _id_B8E70FF71A02E32D.origin + (0, 0, 42);
            dist = distance(_id_41B5F78FDDAAD23F, _id_A2BE1458D5F6797B);
            _id_4B01E6DB3ABF9DDB = _id_62E0C3ED163E5B8A * dist;
            _id_7B3CD02C327EF639 = vectortoangles(_id_A2BE1458D5F6797B - _id_41B5F78FDDAAD23F);
            _id_1E789833BB30706F = anglesdelta(_id_7F51BB920D03D261, _id_7B3CD02C327EF639);

            if(_id_1E789833BB30706F < _id_5590D1B33367F2C5) {
              _id_5590D1B33367F2C5 = _id_1E789833BB30706F;
              _id_114AB88507847C50 = _id_B8E70FF71A02E32D;
              _id_8624CAE3C5209AEC = _id_A2BE1458D5F6797B;
              _id_EB785C749968FCD1 = dist;
            }
          }

          if(distance(_id_41B5F78FDDAAD23F, _id_114AB88507847C50.origin) >= 4000) {
            _id_4CBCADDBE471ECB1 = distance(_id_41B5F78FDDAAD23F + _id_62E0C3ED163E5B8A * _id_EB785C749968FCD1, _id_8624CAE3C5209AEC);

            if(_id_4CBCADDBE471ECB1 <= 64) {
              level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_nag_bulletdrop");
              _id_321D3ECA96EF155D = 0;
              break;
            }
          }
        }

        if(_id_25C40BEA73FA0B20 && level.trial_mount_nag) {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_nag_mount");
          _id_25C40BEA73FA0B20 = 0;
        } else
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("sniper_hurry_up");

        break;
      }
    }
  }
}

dialog_mount_nag_watcher() {
  level.trial_mount_nag = 1;
  level waittill("new_wave");

  while(level.player playermount() <= 0.5)
    waitframe();

  level.trial_mount_nag = 0;
}

infinite_reserve_ammo_not_revolver() {
  level endon("game_ended");
  self endon("disconnect");
  starting_weapon = getEnt("trial_starting_weapon", "script_noteworthy");
  _id_B2303E8D317B6E8D = strtok(starting_weapon.script_parameters, "+")[0];

  while(!isDefined(self.currentprimaryweapon))
    waitframe();

  for(;;) {
    _id_72BE6C8F945BEA7A = self.currentprimaryweapon;

    if(issubstr(_id_72BE6C8F945BEA7A.basename, _id_B2303E8D317B6E8D))
      self setweaponammostock(_id_72BE6C8F945BEA7A, 0);
    else
      self givemaxammo(_id_72BE6C8F945BEA7A);

    waitframe();
  }
}

trial_spawn_wp(struct) {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_white_phosphorus_inbound");
  mappointinfo = [];
  mappointinfo[0] = spawnStruct();
  mappointinfo[0].angles = struct.angles[1];
  mappointinfo[0].location = struct.origin;
  mappointinfo[0].string = "confirm_location";
  streakinfo = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", level.player);
  streakinfo.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(streakinfo.streakname);
  streakinfo.mpstreaksysteminfo.activatedtime = gettime();
  level.wpinprogress = 1;

  foreach(_id_47B05A700340406E, _id_470C049A636DB53D in mappointinfo) {
    _id_0B21E2E887C161B9 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("disconnect");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("joined_team");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchdisownaction("joined_spectator");
    _id_83C2AB15F0A8B72C = level.player scripts\cp_mp\killstreaks\white_phosphorus::wp_createplane(_id_0B21E2E887C161B9, _id_A4521BB88F4EB389, streakinfo);

    if(!isDefined(_id_83C2AB15F0A8B72C))
      return 0;

    objective_delete(_id_83C2AB15F0A8B72C.minimapid);
    _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchplanedisowned();
    _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_deliverpayloads(streakinfo);

    if(mappointinfo.size > 1 && _id_47B05A700340406E < mappointinfo.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

trial_thermite_watcher() {
  for(;;) {
    level waittill("trial_start");
    wait 3;

    if(isDefined(self.script_noteworthy))
      wait(float(self.script_noteworthy));

    playFXOnTag(scripts\engine\utility::getfx("trial_flare"), self, "j_top");
    self playSound("gos_firework_scream_sfx");

    if(isDefined(self.script_noteworthy))
      _id_7A4D89B99942D23C = 3 - float(self.script_noteworthy);
    else
      _id_7A4D89B99942D23C = 3;

    if(_id_7A4D89B99942D23C > 0)
      wait(_id_7A4D89B99942D23C);

    stopFXOnTag(scripts\engine\utility::getfx("trial_flare"), self, "j_top");
    playFXOnTag(scripts\engine\utility::getfx("trial_thermite"), self, "j_top");
    self playSound("gos_firework_explo_sfx");
    wait 2.25;
    playFXOnTag(scripts\engine\utility::getfx("trial_thermite_end"), self, "j_top");
    stopFXOnTag(scripts\engine\utility::getfx("trial_thermite"), self, "j_top");
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_sniper;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["wave1time"] = 0;
    game["trial"]["analytics"]["wave2time"] = 0;
    game["trial"]["analytics"]["wave3time"] = 0;
    game["trial"]["analytics"]["wave4time"] = 0;
  }
}

trial_dlog_sniper() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  score = getomnvar("ui_trial_best_score");
  _id_BC84B4FC4F48CD42 = int(game["trial"]["analytics"]["wave1time"]);
  _id_C310375492C67537 = int(game["trial"]["analytics"]["wave2time"]);
  _id_FDEC10C9F9C9AC28 = int(game["trial"]["analytics"]["wave3time"]);
  _id_4C8CCB203F51C945 = int(game["trial"]["analytics"]["wave4time"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_sniper", ["id", id, "tier", tier, "score", score, "wave1time", _id_BC84B4FC4F48CD42, "wave2time", _id_C310375492C67537, "wave3time", _id_FDEC10C9F9C9AC28, "wave4time", _id_4C8CCB203F51C945]);
}