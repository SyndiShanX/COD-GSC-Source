/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_gunslinger.gsc
***************************************************/

define_trial_mission_init_func() {
  if(!isDefined(level.trial_missionscript_init_funcs))
    level.trial_missionscript_init_funcs = [];

  level.trial_missionscript_init_funcs["gunslinger"] = ::init;
}

init() {
  analytics_init();
  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  level.trial_alternate_progression = 0;

  if(level.trial["missionID"] == 1021) {
    create_trial_weapon_spawn((1735, 1184.25, 40), (0, 108, -90), "trial_variant_pickup", "outline", "iw8_pi_mike9+trigcust03+stockcust+reflexmini+fastreload+xmagslrg+barlong");
    level.trial_alternate_progression = 1;
    level.accuracy_bonus_factor = 500;
    level.headshot_distance = 5;
    level.flip_time = 0.4;
  } else if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF()) {
    create_trial_weapon_spawn((25.807, -553.161, 301), (180, 225, 90), "trial_variant_pickup", "outline", "iw8_ar_falima+hybrid2+gripang+barshort+pistolgrip01+fastreload");
    level.wavetime = [7000, 8000, 9000, 10000];
    level.sub_civtarget = [2, 2, 2, 3];
    level.accuracy_bonus_factor = 1000;
    level.headshot_distance = 5;
    level.flip_time = 0.4;
  } else if(level.trial["variant"] == "reflex") {
    create_trial_weapon_spawn((1735, 1184.25, 40), (0, 108, -90), "trial_variant_pickup", "outline", "iw8_pi_mike1911+fastreload+trigcust03");
    level.wavetime = [2500, 2500, 4000, 4000];
    level.sub_civtarget = [1, 1, 1, 2];
    level.accuracy_bonus_factor = 500;
    level.headshot_distance = 5;
    level.flip_time = 0.4;
  } else if(level.trial["variant"] == "riffle") {
    create_trial_weapon_spawn((1737, 1180.25, 40), (0, 75, -90), "trial_variant_pickup", "outline", "iw8_sn_sbeta+barlong+comp+laserbalanced+fastreload+acog3");
    level.wavetime = [2500, 2500, 5500, 5500];
    level.sub_civtarget = [1, 1, 1, 2];
    level.accuracy_bonus_factor = 500;
    level.headshot_distance = 5;
    level.flip_time = 0.4;
  } else if(level.trial["variant"] == "infinite") {
    create_trial_weapon_spawn((25.807, -553.161, 301), (180, 225, 90), "trial_variant_pickup", "outline", "iw8_ar_falima+hybrid2+gripang+barshort+pistolgrip01+fastreload");
    level.wavetime = [5000, 6000, 7000, 8000];
    level.sub_civtarget = [2, 2, 2, 3];
    level.accuracy_bonus_factor = 1000;
    level.headshot_distance = 5;
    level.flip_time = 0.4;
  } else if(level.trial["variant"] == "knife") {
    level.wavetime = [2200, 4000, 6500, 7500];
    level.sub_civtarget = [1, 1, 1, 2];
    level.accuracy_bonus_factor = 500;
    level.headshot_distance = 8.5;
    level.flip_time = 0.4;
    thread recharge_equipment_think_init();
    thread give_player_knife_on_respawn();
    thread start_box_set_up();
  } else if(level.trial["variant"] == "memory") {
    create_trial_weapon_spawn((-82, 1250, -195), (0, 180, -90), "trial_variant_pickup", "outline", "iw8_sn_sksierra+fastreload+smags+pistolgrip03+barshort+laserbalanced");
    level.wavetime = [4100, 5100, 6100, 6100];
    level.sub_civtarget = [1, 1, 1, 2];
    level.accuracy_bonus_factor = 500;
    level.headshot_distance = 5;
    level.flip_time = 1.5;
  }

  level.trial_infinite_reserve_ammo = 1;
  _id_E9AC9DC3DAC1BFDC = getEntArray("target_brushmodel", "script_noteworthy");

  foreach(geo in _id_E9AC9DC3DAC1BFDC) {
    geo.targetname = "null";
    geo.target = "null";
  }

  while(!isDefined(level.struct_class_names))
    waitframe();

  level_light();
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  _id_8FE238C01BFF6211 = ["1", "2", "3", "4"];
  _id_E1A927B183310AE6 = ["1", "2", "3", "4"];
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.enemy_targets_headshot = [];
  level.bonus_target = [];
  level.bonus_target_hit = [];
  level.trial_targs = [];
  level.trial_targs_combo = [];

  foreach(_id_A2B11613E4C46ED8 in _id_8FE238C01BFF6211) {
    if(!isDefined(level.trial_targs[_id_A2B11613E4C46ED8]))
      level.trial_targs[_id_A2B11613E4C46ED8] = [];

    foreach(_id_BE66E5030B255FF1 in _id_E1A927B183310AE6) {
      if(!isDefined(level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1]))
        level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1] = [];
    }
  }

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_A2B11613E4C46ED8 = _id_B8E70FF71A02E32D.targetname[4];
    _id_BE66E5030B255FF1 = _id_B8E70FF71A02E32D.targetname[5];
    level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1][level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1].size] = _id_B8E70FF71A02E32D;

    if(_id_A2B11613E4C46ED8 == "4")
      level.trial_targs_combo[level.trial_targs_combo.size] = _id_B8E70FF71A02E32D;
  }

  dialog_init();
  progression();
}

progression() {
  scripts\mp\trials\trial_utility::waittill_player_isDefined();

  foreach(_id_B8E70FF71A02E32D in level.course_targets) {
    _id_B8E70FF71A02E32D.activated = 0;
    _id_B8E70FF71A02E32D thread target_think();
  }

  if(level.trial["variant"] == "knife")
    thread get_bonus_targets();

  hud_init();

  for(;;) {
    trial_score_init();

    if(level.trial["variant"] == "memory")
      thread grenade_effect();

    level.target_waves = 0;
    scripts\mp\trials\trial_utility::trial_ui_set_wave(1, level.trial_targs.size);

    if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF()) {
      level.trial_first_start = 1;
      level notify("course_started");
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
    } else
      course_start_wait();

    thread score_accuracy_think();
    scripts\mp\trials\trial_utility::trial_ui_decrease_tries_remaining();
    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(0);

    if(level.trial_alternate_progression)
      combo_progression();
    else {
      wave_progression();
      thread targets_missed_calculate();
    }

    scripts\mp\trials\trial_utility::trial_ui_retry_disabled(1);
    score_calculate(1);

    foreach(_id_DE88CD14114C1E24 in level.player.primaryinventory)
    level.player setweaponammoclip(_id_DE88CD14114C1E24, weaponclipsize(_id_DE88CD14114C1E24));

    scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
  }
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  _id_881E7D75E23A919A = getEnt("outline", "script_noteworthy");

  if(isDefined(_id_881E7D75E23A919A)) {
    while(!isDefined(_id_881E7D75E23A919A.spawned_weapon))
      waitframe();

    while(isDefined(_id_881E7D75E23A919A.spawned_weapon))
      waitframe();
  } else
    level waittill("start");

  level.trial_first_start = 1;
  level notify("course_started");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

combo_progression() {
  level.trial_combo_died = 0;
  level endon("trial_combo_died");
  level.player playSound("trial_sfx_success");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level.player playSound("trial_sfx_start");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
  level.trial_start_time = gettime();
  thread combo_reset();
  _id_4D0C2D47CDE12B09 = int(level.trial_targs_combo.size * 0.35);
  level.trial_targs_combo randomize_target(_id_4D0C2D47CDE12B09);
  _id_8EAC479E5A89E9BF = 0;
  level._id_E98CB3EF69D63108 = 0;

  for(;;) {
    _id_41A118D1C4995D37 = scripts\engine\utility::array_randomize(level.trial_targs_combo);
    _id_B8E70FF71A02E32D = _id_41A118D1C4995D37[0];

    foreach(_id_B8E70FF71A02E32D in _id_41A118D1C4995D37) {
      if(!_id_B8E70FF71A02E32D.state_up && !_id_B8E70FF71A02E32D.flipping) {
        if(!_id_B8E70FF71A02E32D.iscivilian) {
          _id_B8E70FF71A02E32D.script_speed = randomfloatrange(48, 128);
          _id_8EAC479E5A89E9BF = 1;
          level._id_E98CB3EF69D63108 = min(level._id_E98CB3EF69D63108 + 100, 3000);
        } else if(_id_8EAC479E5A89E9BF == 1) {
          _id_B8E70FF71A02E32D.script_speed = 32;
          _id_8EAC479E5A89E9BF = 0;
        } else
          continue;

        _id_B8E70FF71A02E32D thread _id_549F5862B04F5E4B();
        break;
      }
    }

    if(!_id_B8E70FF71A02E32D.iscivilian)
      wait 1;
  }
}

_id_549F5862B04F5E4B() {
  target_flip("up");
  self endon("flip_down");
  _id_1691B3A22227E990 = gettime();
  life = max(5000 - level._id_E98CB3EF69D63108, 2000);

  while(gettime() < _id_1691B3A22227E990 + life)
    waitframe();

  thread target_flip_down_safe();
}

wave_progression() {
  foreach(_id_AC0E594AC96AA3A8, _id_A2B11613E4C46ED8 in level.trial_targs) {
    hud_inter_round_flow(int(_id_AC0E594AC96AA3A8));
    scripts\mp\trials\trial_utility::trial_ui_set_wave(int(_id_AC0E594AC96AA3A8), level.trial_targs.size);

    foreach(_id_AC0E5C4AC96AAA41, _id_BE66E5030B255FF1 in _id_A2B11613E4C46ED8)
    subwave_progression(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41);
  }
}

subwave_progression(_id_A2B11613E4C46ED8, _id_BE66E5030B255FF1) {
  start_time = gettime();
  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(start_time + level.wavetime[int(_id_A2B11613E4C46ED8) - 1]);

  if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF()) {
    if(int(_id_A2B11613E4C46ED8) == 1 && int(_id_BE66E5030B255FF1) == 1)
      level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1] _id_68A1656276CE4BCF();
    else
      level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1] randomize_target(level.sub_civtarget[int(_id_BE66E5030B255FF1) - 1]);
  } else
    level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1] randomize_target(level.sub_civtarget[int(_id_BE66E5030B255FF1) - 1]);

  foreach(_id_B8E70FF71A02E32D in level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1])
  _id_B8E70FF71A02E32D thread target_flip("up");

  level notify("next_wave");

  while(gettime() < start_time + level.wavetime[int(_id_A2B11613E4C46ED8) - 1])
    waitframe();

  foreach(_id_B8E70FF71A02E32D in level.trial_targs[_id_A2B11613E4C46ED8][_id_BE66E5030B255FF1])
  _id_B8E70FF71A02E32D thread target_flip("down");

  scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(-1);
  wait 2;
}

randomize_target(_id_4D0C2D47CDE12B09) {
  if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF())
    _id_D59668175D173E0A = ["ee_military_shooting_range_plate_02_enemy_wzm_sh_01", "ee_military_shooting_range_plate_02_enemy_wzm_sh_02", "ee_military_shooting_range_plate_02_enemy_wzm_sh_03", "ee_military_shooting_range_plate_02_enemy_wzm_sh_04", "ee_military_shooting_range_plate_02_enemy_wzm_sh_05", "ee_military_shooting_range_plate_02_enemy_wzm_sh_06"];
  else
    _id_D59668175D173E0A = ["ee_military_shooting_range_plate_02_enemy_01", "ee_military_shooting_range_plate_02_enemy_02", "ee_military_shooting_range_plate_02_enemy_03", "ee_military_shooting_range_plate_02_enemy_04", "ee_military_shooting_range_plate_02_enemy_05", "ee_military_shooting_range_plate_02_enemy_06"];

  _id_C95DAC27196563D7 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  _id_234E67D5F725EF04 = scripts\engine\utility::array_randomize(self);

  foreach(_id_AC0E594AC96AA3A8, _id_B8E70FF71A02E32D in _id_234E67D5F725EF04) {
    if(_id_AC0E594AC96AA3A8 < _id_4D0C2D47CDE12B09) {
      _id_0A6C040515A46AB3 = scripts\engine\utility::random(_id_C95DAC27196563D7);
      _id_B8E70FF71A02E32D.plate setModel(_id_0A6C040515A46AB3);
      _id_B8E70FF71A02E32D.iscivilian = 1;
      level.civilian_targets = scripts\engine\utility::array_add(level.civilian_targets, _id_B8E70FF71A02E32D);

      if(_id_4D0C2D47CDE12B09 <= _id_C95DAC27196563D7.size)
        _id_C95DAC27196563D7 = scripts\engine\utility::array_remove(_id_C95DAC27196563D7, _id_0A6C040515A46AB3);
    } else {
      if(_id_D59668175D173E0A.size == 0)
        _id_D59668175D173E0A = ["ee_military_shooting_range_plate_02_enemy_01", "ee_military_shooting_range_plate_02_enemy_02", "ee_military_shooting_range_plate_02_enemy_03", "ee_military_shooting_range_plate_02_enemy_04", "ee_military_shooting_range_plate_02_enemy_05", "ee_military_shooting_range_plate_02_enemy_06"];

      _id_A48C4A84DEA4E80D = scripts\engine\utility::random(_id_D59668175D173E0A);
      _id_B8E70FF71A02E32D.plate setModel(_id_A48C4A84DEA4E80D);
      _id_B8E70FF71A02E32D.iscivilian = 0;
      level.enemy_targets = scripts\engine\utility::array_add(level.enemy_targets, _id_B8E70FF71A02E32D);
      _id_D59668175D173E0A = scripts\engine\utility::array_remove(_id_D59668175D173E0A, _id_A48C4A84DEA4E80D);
    }

    waitframe();
  }
}

_id_68A1656276CE4BCF() {
  _id_A32C066ABF8931AD = self;

  foreach(_id_B8E70FF71A02E32D in _id_A32C066ABF8931AD) {
    if(_id_B8E70FF71A02E32D.plate.model == "ee_military_shooting_range_plate_02_enemy_wzm_sh_03" || _id_B8E70FF71A02E32D.plate.model == "ee_military_shooting_range_plate_02_enemy_wzm_sh_01") {
      _id_B8E70FF71A02E32D.iscivilian = 0;
      level.enemy_targets = scripts\engine\utility::array_add(level.enemy_targets, _id_B8E70FF71A02E32D);
      continue;
    }

    _id_B8E70FF71A02E32D.iscivilian = 1;
    level.civilian_targets = scripts\engine\utility::array_add(level.civilian_targets, _id_B8E70FF71A02E32D);
  }
}

target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(part in self.parts) {
    switch (part.script_noteworthy) {
      case "target_plate_gunslinger":
      case "target_plate":
        self.plate = part;
        break;
      case "target_arm_gunslinger":
      case "target_arm":
        self.arm = part;
        break;
      case "target_base_gunslinger":
      case "target_base":
        self.base = part;
        break;
      case "target_wheels_gunslinger":
      case "target_wheels":
        self.wheels = part;
        break;
      default:
        break;
    }

    part.target = "null";
    part.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  self.state_up = 0;
  self.flipping = 0;
  self.initial_angles = self.angles;
  thread target_damage();
  self.activated = 0;
  waitframe();

  if(issubstr(self.script_noteworthy, "moving"))
    thread moving_target_think();
}

gettargetarray() {
  if(scripts\mp\trials\trial_utility::_id_1D8E53696962A7AF())
    _id_3CA8A977F230716E = ["standard_target_gunslinger", "moving_target_gunslinger"];
  else
    _id_3CA8A977F230716E = ["standard_target", "moving_target"];

  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      ent = spawn("script_origin", struct.origin);
      ent.angles = struct.angles;
      ent.script_gameobjectname = struct.script_gameobjectname;
      ent.script_linkname = struct.script_linkname;
      ent.script_noteworthy = struct.script_noteworthy;
      ent.target = struct.target;
      ent.targetname = struct.targetname;
      ent.script_delay = struct.script_delay;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++)
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

  return scripts\engine\utility::array_combine_multiple(_id_53EE9B445DE3B69B);
}

target_damage() {
  for(;;) {
    self.activated = 0;
    self.hit = 0;
    self.plate waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    self.plate setCanDamage(0);
    self.plate playSound("trial_sfx_target_report_metal");

    if(self.iscivilian) {
      self.hit = 1;
      self.activated = 1;
      level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 0, 1, 0);
      level.player thread scripts\mp\rank::scoreeventpopup("stat_930B4906CF0D62F7");
      self playSound("trial_sfx_buzzer_bad_1");
      score_event_civilian_hit();
    } else {
      self.hit = 1;
      level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 0);
      self.activated = 1;
      thread score_event_target_hit();
      origin = self.plate gettagorigin("tag_head");
      _id_FC0D30947020CD5D = distance(point, origin);
      thread targets_missed_calculate();

      if(_id_FC0D30947020CD5D < level.headshot_distance) {
        level.enemy_targets_headshot = level.enemy_targets_headshot scripts\engine\utility::array_add(level.enemy_targets_headshot, self);
        thread score_event_headshot();
      }
    }

    if(!isDefined(level.targethitsinaframecount))
      level.targethitsinaframecount = 0;

    self.activated = 1;
    level.targethitsinaframecount++;
    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.last_hit_target = self;

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self) {
      if(!level.lasttargethitinaframe.iscivilian && !level.last_hit_target.iscivilian) {
        level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
        thread score_event_collateral(level.targethitsinaframecount);
      }
    }

    firetime = weaponfiretime(objweapon);

    if(firetime > 0.05)
      wait(firetime);
    else
      waittillframeend;

    thread target_flip_down_safe();
    waittillframeend;
    level.targethitsinaframecount = 0;

    if(level.trial_alternate_progression) {
      self waittill("flip_up");
      continue;
    }

    level waittill("course_ended");
  }
}

target_flip_down_safe() {
  while(self.flipping)
    waitframe();

  if(!self.state_up) {
    return;
  }
  thread target_flip("down");
}

target_flip(_id_F1118C1A072B6415) {
  if(_id_F1118C1A072B6415 == "up") {
    if(!level.trial_alternate_progression && isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(self.state_up) {
      return;
    }
    self.state_up = 1;
    sign = 1;
    self.activated = 0;
    self notify("flip_up");
  } else {
    if(!self.state_up) {
      return;
    }
    self.state_up = 0;
    sign = -1;
    self notify("flip_down");
  }

  time = undefined;
  _id_8BC14603A27FA3E7 = undefined;
  _id_CD45F305ACBCAFE6 = undefined;
  _id_0CF39F99B8ECBD0E = undefined;

  switch (self.script_noteworthy) {
    case "moving_target_gunslinger":
    case "standard_target_gunslinger":
    case "moving_target":
    case "standard_target":
      _id_8BC14603A27FA3E7 = 90;
      _id_CD45F305ACBCAFE6 = 180;
      time = 0.15;
      _id_0CF39F99B8ECBD0E = 0.15;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving"))
    waitframe();

  if(_id_F1118C1A072B6415 == "up")
    self playsoundonmovingent("trial_sfx_target_flipup");

  if(self.initial_up[1] != 0)
    self rotateYaw(-1 * self.initial_up[1] * _id_8BC14603A27FA3E7 * sign, time);
  else if(!self.state_up && !istrue(self.hit)) {
    self rotateroll(self.initial_up[2] * _id_CD45F305ACBCAFE6 * sign, _id_0CF39F99B8ECBD0E);
    wait 0.4;
    self.plate setCanDamage(0);
    self rotatepitch(self.initial_up[2] * _id_8BC14603A27FA3E7 * sign, time);
  } else if(!self.state_up && level.lasttargethitinaframe.hit && !level.trial_alternate_progression) {
    self rotatepitch(self.initial_up[2] * _id_8BC14603A27FA3E7 * sign, time);
    self.plate setCanDamage(0);
    level.lasttargethitinaframe.hit = 0;

    if(!level.trial_alternate_progression) {
      level waittill("course_ended");
      wait 6;
      self rotateroll(self.initial_up[2] * _id_CD45F305ACBCAFE6 * sign, _id_0CF39F99B8ECBD0E);
    } else {
      wait(time);
      wait 0.5;
      self.angles = self.initial_angles;
    }
  } else {
    self rotatepitch(self.initial_up[2] * _id_8BC14603A27FA3E7 * sign, time);
    wait(level.flip_time);
    waitframe();
    self rotateroll(self.initial_up[2] * _id_CD45F305ACBCAFE6 * sign, _id_0CF39F99B8ECBD0E);
  }

  if(_id_F1118C1A072B6415 == "down")
    self playsoundonmovingent("trial_sfx_target_flipdown");

  wait(time);
  waitframe();
  self.flipping = 0;
}

moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  thread moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.players[0].origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("trial_sfx_target_move_stop");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
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
  self.dummy thread scripts\engine\utility::play_loop_sound_on_entity("trial_sfx_target_move_loop");
  self.plate playSound("trial_sfx_target_move_start");

  for(;;) {
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
    scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["target_hit"] = 0;
  level.score["civilian_targets_hit"] = 0;
  level.score["accuracy"] = 0;
  level.score["head_shot"] = 0;
  level.score["collateral"] = 0;
  level.score["trickshot"] = 0;
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.enemy_targets_headshot = [];
  level.enemies_missed = level.enemy_targets.size;
  level.enemies_killed = 0;
  level.civs_killed = 0;
  level.shots_fired = 0;
  level.course_accuracy = 0;
  level.headshot = 0;
  level.bonus_targets = 0;
  level.trial_combo = 0;
  level.bonus_targets = 0;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(1, "accuracy", 100 * level.course_accuracy, level.score["accuracy"]);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(2, "head_shot", level.headshot, level.score["head_shot"]);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(3, "civilian_targets_hit", level.civs_killed, -1 * level.score["civilian_targets_hit"]);

  if(level.trial["variant"] == "knife")
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(4, "special_target_hit", level.bonus_targets, 0);

  score_calculate();
}

score_event_target_hit() {
  level.score["target_hit"] = level.score["target_hit"] + 100;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.enemies_killed++;

  if(level.trial_alternate_progression)
    thread combo_reset();

  score_calculate();
}

score_event_civilian_hit() {
  if(!level.civilian_targets.size) {
    return;
  }
  level notify("civ_hit");
  level.civs_killed++;
  level.score["civilian_targets_hit"] = level.score["civilian_targets_hit"] + 200;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(3, "civilian_targets_hit", level.civs_killed, -1 * level.score["civilian_targets_hit"]);
}

score_event_headshot() {
  level endon("course_ended");

  if(!level.enemy_targets.size) {
    return;
  }
  level.player thread scripts\mp\rank::scoreeventpopup("stat_FC56E889052D3823");
  level.player thread scripts\mp\rank::scorepointspopup(50);
  level notify("headshot");
  level.headshot = 0;

  foreach(_id_B8E70FF71A02E32D in level.enemy_targets_headshot)
  level.headshot++;

  level.score["head_shot"] = level.score["head_shot"] + 50;
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(2, "head_shot", level.headshot, 0);
}

score_accuracy_think() {
  level endon("course_ended");
  level.shots_fired = 0;

  for(;;) {
    level.player scripts\engine\utility::waittill_any_3("weapon_fired", "fake_weapon_fired", "grenade_fire");
    level.shots_fired++;
    waitframe();

    if(level.trial["variant"] == "knife")
      level.course_accuracy = (level.enemy_targets.size + level.bonus_target_hit.size - level.enemies_missed) / max(1, level.shots_fired);
    else if(level.trial_alternate_progression)
      level.course_accuracy = level.enemies_killed / max(1, level.shots_fired);
    else
      level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / max(1, level.shots_fired);

    _id_0CA9930310366321 = level.course_accuracy * level.accuracy_bonus_factor;
    level.score["accuracy"] = _id_0CA9930310366321 % 1300;
    scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(1, "accuracy", 100 * level.course_accuracy, level.score["accuracy"]);
  }
}

targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(_id_B8E70FF71A02E32D in level.enemy_targets) {
    if(!_id_B8E70FF71A02E32D.activated)
      level.enemies_missed++;
  }
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
}

score_calculate(_id_9B106ABAC2185216) {
  if(!isDefined(_id_9B106ABAC2185216))
    _id_9B106ABAC2185216 = 0;

  level.score["subtotal"] = level.score["target_hit"] + level.score["head_shot"] + level.score["trickshot"] + level.score["collateral"];
  level.score["before_total"] = level.score["subtotal"] + level.score["accuracy"] - level.score["civilian_targets_hit"];
  level.score["total"] = clamp(level.score["before_total"], 0, 999999);
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(_id_9B106ABAC2185216) {
    scripts\mp\trials\trial_utility::trial_ui_set_secondary_timer(-1);
    wait 1;
    scripts\mp\trials\trial_utility::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      scripts\mp\trials\trial_utility::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["accuracy"] = level.course_accuracy;
      game["trial"]["analytics"]["missed"] = level.enemies_missed;
      game["trial"]["analytics"]["civilians"] = level.civs_killed;
    }

    hud_set_reward_tier(1);
    level notify("course_ended");

    if(istrue(level.trial_special_end))
      wait 5;

    thread scripts\mp\trials\trial_utility::trial_ui_open_results_screen();
  }
}

combo_reset() {
  level notify("combo_reset");
  level endon("combo_reset");

  if(istrue(level.trial_combo_died)) {
    return;
  }
  waitframe();
  _id_DA3CDE9D0D26A76A = combo_duration_calculate();
  level.trial_combo++;
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_duration(_id_DA3CDE9D0D26A76A);
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_combo(max(level.trial_combo, 1));
  _id_15E72E4A04A2E647 = gettime();

  while(gettime() < _id_15E72E4A04A2E647 + _id_DA3CDE9D0D26A76A)
    waitframe();

  wait 0.25;
  level notify("trial_combo_died");
  level.trial_combo_died = 1;
  scripts\mp\trials\trial_utility::trial_ui_set_combo_bar_combo(0);

  foreach(_id_B8E70FF71A02E32D in level.trial_targs_combo)
  _id_B8E70FF71A02E32D thread target_flip_down_safe();
}

combo_duration_calculate() {
  _id_6747992B3D918F29 = gettime() - level.trial_start_time;
  _id_D533BFE71A304271 = int(_id_6747992B3D918F29 / 10);
  _id_66223B9E4FDAB757 = level.civs_killed * 750;
  _id_DA3CDE9D0D26A76A = clamp(7500 - _id_D533BFE71A304271 - _id_66223B9E4FDAB757, 1250, 7500);

  if(level.player isreloading() || level.player getcurrentweaponclipammo() == 0)
    _id_DA3CDE9D0D26A76A = max(_id_DA3CDE9D0D26A76A, 1750);

  return _id_DA3CDE9D0D26A76A;
}

hud_init() {
  level.target_waves = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["trickshot"] = 0;
  scripts\mp\trials\trial_utility::trial_ui_set_subscore(0);
  scripts\mp\trials\trial_utility::trial_ui_set_wave(1, level.trial_targs.size);
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
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  setomnvar("ui_match_start_text", "none");
  level.player playSound("trial_sfx_start");
  scripts\mp\trials\trial_utility::trial_ui_set_wave(int(_id_C5CF558181E12D1F), level.trial_targs.size);
  scripts\mp\trials\trial_utility::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

dialog_init() {
  game["dialog"]["trial_intro"] = "mp_m_speedball_gc3_intro";
  game["dialog"]["trial_intro_short"] = "mp_m_speedball_gc3_intro";
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
  game["dialog"]["good_shot"] = "mp_m_speedball_gc3_good";
  game["dialog"]["course_start"] = "mp_m_speedball_obj_nag_start";
  game["dialog"]["course_nice_shot"] = "mp_m_speedball_obj_nag_nice";
  game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
  game["dialog"]["course_hurry_up"] = "mp_m_speedball_obj_nag_hurry";
  game["dialog"]["trickshot"] = "mp_spear_throw_special";
  thread dialog_wait_think();
  thread dialog_kill_watcher();
  thread dialog_wait_think_civ();
  thread dialog_kill_watcher_civ();
}

create_trial_weapon_spawn(origin, angles, _id_6C462293994EFA73, noteworthy, weapon_name) {
  _id_DE88CD14114C1E24 = spawn("script_origin", origin);

  if(isDefined(angles))
    _id_DE88CD14114C1E24.angles = angles;

  if(isDefined(_id_6C462293994EFA73))
    _id_DE88CD14114C1E24.script_gameobjectname = _id_6C462293994EFA73;
  else
    _id_DE88CD14114C1E24.script_gameobjectname = "trial";

  if(isDefined(noteworthy))
    _id_DE88CD14114C1E24.script_noteworthy = noteworthy;

  _id_DE88CD14114C1E24.targetname = "trial_weapon";
  _id_DE88CD14114C1E24.script_parameters = weapon_name;
  return _id_DE88CD14114C1E24;
}

level_light() {
  level.rifle_lights = getEntArray("rifle", "targetname");
  level.pitcher_lights = getEntArray("pitcher", "targetname");
  wait 0.05;

  if(level.trial["missionID"] == 1002) {
    foreach(light in level.rifle_lights)
    light setlightintensity(1);

    foreach(light in level.pitcher_lights)
    light setlightintensity(0);
  } else {
    foreach(light in level.rifle_lights)
    light setlightintensity(0);

    foreach(light in level.pitcher_lights)
    light setlightintensity(0);
  }
}

analytics_init() {
  level.trial_dlog_func = ::trial_dlog_gunslinger;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["accuracy"] = 0;
    game["trial"]["analytics"]["missed"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
  }
}

trial_dlog_gunslinger() {
  id = level.trial["missionID"];
  tier = getomnvar("ui_trial_reward_tier");
  score = getomnvar("ui_trial_best_score");
  accuracy = float(game["trial"]["analytics"]["accuracy"]);
  _id_58AA9AEA25E648A4 = int(game["trial"]["analytics"]["missed"]);
  civilians = int(game["trial"]["analytics"]["civilians"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_gunslinger", ["id", id, "tier", tier, "score", score, "accuracy", accuracy, "missed", _id_58AA9AEA25E648A4, "civilians", civilians]);
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
    state.progress[slot] = state.progress[slot] + 0.333333;
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

give_player_knife_on_respawn() {
  level waittill("start");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player))
        waitframe();

      slot = "primary";
      level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", slot);
    }

    waitframe();
  }
}

start_box_set_up() {
  interaction = getEnt("grenade_box_knife", "targetname");
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
  level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
  level.player playSound("gren_pickup_frag");
  interaction makeunusable();
}

get_bonus_targets() {
  level.bonus_targets = [];
  level.bonus_target = getEntArray("bonus_target", "targetname");

  if(level.bonus_target.size <= 0) {
    return;
  }
  level.explosion = loadfx("vfx/iw8/prop/scriptables/vfx_ee_food_fruit_watermelon_02_debris.vfx");

  foreach(_id_1E9DBF7306C79B65 in level.bonus_target) {
    _id_1E9DBF7306C79B65.need_respawn = 1;
    _id_1E9DBF7306C79B65 hide();
  }

  for(;;) {
    foreach(_id_1E9DBF7306C79B65 in level.bonus_target) {
      if(istrue(_id_1E9DBF7306C79B65.need_respawn)) {
        _id_1E9DBF7306C79B65.need_respawn = 0;
        _id_69EB696A8EBAD054 = spawn("script_model", _id_1E9DBF7306C79B65.origin);
        _id_69EB696A8EBAD054 setModel(_id_1E9DBF7306C79B65.model);
        _id_69EB696A8EBAD054.angles = _id_1E9DBF7306C79B65.angles;
        _id_69EB696A8EBAD054.script_noteworthy = _id_1E9DBF7306C79B65.script_noteworthy;
        _id_69EB696A8EBAD054.isbonus = 1;
        _id_69EB696A8EBAD054 thread bonus_target_domage(_id_1E9DBF7306C79B65);
        _id_69EB696A8EBAD054 setCanDamage(1);
      }
    }

    level waittill("course_ended");
    wait 5;
  }
}

bonus_target_domage(ref) {
  level endon("target_hit");

  for(;;) {
    self.activated = 0;
    self waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    level.player thread scripts\mp\rank::scorepointspopup(int(self.script_noteworthy));
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("good_shot");
    playFXOnTag(level.explosion, self, "TAG_ORIGIN");
    waitframe();
    self.activated = 1;
    self hide();
    level.bonus_targets++;
    thread bonus_target_score();
    self setCanDamage(0);
    ref.need_respawn = 1;
    self delete();
    return;
  }
}

bonus_target_score() {
  level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
  scripts\mp\trials\trial_utility::trial_ui_set_stat_and_bonus_score(4, "special_target_hit", level.bonus_targets, 0);
  score_calculate();
}

dialog_kill_watcher() {
  level waittill("course_started");

  for(;;) {
    level waittill("headshot");

    if(level.dialog_wait_ready) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "trickshot");
      level.dialog_wait_ready = 0;
    }

    waitframe();
  }
}

dialog_wait_think() {
  level.dialog_wait_ready = 1;

  for(;;) {
    level waittill("headshot");
    wait 7;
    level.dialog_wait_ready = 1;
  }
}

dialog_kill_watcher_civ() {
  level waittill("course_started");

  for(;;) {
    level waittill("civ_hit");

    if(level.dialog_wait_ready_civ) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      level.dialog_wait_ready_civ = 0;
    }

    waitframe();
  }
}

dialog_wait_think_civ() {
  level.dialog_wait_ready_civ = 1;

  for(;;) {
    level waittill("civ_hit");
    wait 7;
    level.dialog_wait_ready_civ = 1;
  }
}

grenade_effect() {
  _id_166D65C282848369 = scripts\engine\utility::getStructArray("grenade_effect", "script_noteworthy");
  index = 1;

  for(;;) {
    level waittill("next_wave");

    foreach(smoke in _id_166D65C282848369) {
      if(smoke.script_index == scripts\engine\utility::string(index)) {
        if(isDefined(smoke.script_delay))
          wait(smoke.script_delay);

        magicgrenademanual("smoke_grenade_mp", smoke.origin, (0, 0, -1), 0.05);
      }
    }

    index++;
  }

  level waittill("course_ended");
  index = 0;
}