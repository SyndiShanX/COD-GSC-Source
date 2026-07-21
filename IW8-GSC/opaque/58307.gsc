/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58307.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_8E4708C12DE8D834AC27"] = ::init;
}

init() {
  build_vehicle_drop_off_list();
  level._effect["_encstr_83D610ECBE3B362DFDFA60D0F113FD09972C"] = loadfx("_encstr_BEF7324D3B2330E0C7B85668D2F740D66A8FC1CF860BF0E0ED073861F82FA804D30F795577E221A03F5FE379654970CD4E03C5C9");
  level._effect["_encstr_B2F30E4B1FF071B902077141CF9B75F0"] = loadfx("_encstr_93313B1BB1433EDC30E1C7CD49CAA30363C93233F01D47D248B5FCCD31A26B8B13A62BAB807F43CAC18FE1DE1178F327B1989292CBD863873015F6DE01");
  level._effect["_encstr_B4831043111887127B07636B0F14BBF5A8B8"] = loadfx("_encstr_99533D83D1D83782B4797F4F11709BA28899BD4A60D03F6B85EDBB672928C3EEA8A63392C0C0C4B3F0D7B75309201B1F70C86F9CDBD9979B359BA35A455CB3");
  dialog_init();
  weapon_xp_iw8_sn_awhiskey();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_targets = getEntArray("_encstr_A22E0CD07B8D56FA8E0B93EC2B3A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.movers = getEntArray("_encstr_979206BB0FC3706E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_11DB8 = scripts\engine\utility::getStructArray("_encstr_8D6A0CDAEDECCA93EBCDD12C39D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.lights = getEntArray("_encstr_B8950DD12C9CCE5947BEC6B47686E8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _tablethide::waittill_player_isDefined();
  thread player_init();
  thread _id_12160();
  thread script_gameobjetname();
  thread _id_12A8F();
  thread _id_1378E();
  thread set_chopper_search_speed();
  thread player_monitor_death();

  foreach(var_1 in level.course_targets) {
    var_1.linked = 0;
    var_1 thread target_think();
  }

  foreach(var_4 in level.lights)
  var_4 thread whistling();

  foreach(var_7 in level.movers)
  var_7 thread _id_11DB1();

  hud_init();
  _id_128BD();
}

_id_128BD() {
  level waittill("_encstr_99AD06D3A5B1538B");

  for(;;) {
    trial_score_init();
    level.target_wave = 0;
    course_start_wait();
    _tablethide::_id_13D88();
    _tablethide::_id_13D89(0);
    wave_single_progression(level.targets, 1);
    score_calculate(1);
    _tablethide::_id_13D89(1);
    _tablethide::trial_ui_waittill_retry();
    level notify("_encstr_85F206A6C7DB7DBA");
    level.player freezecontrols(0);

    foreach(var_1 in level.lights)
    var_1 weaponusagecheck(0, 1);

    foreach(var_4 in level.course_targets)
    var_4 thread target_think();
  }
}

_id_1378E() {
  var_0 = getEnt("_encstr_BD7D0C1C33C5559F3A7F2F912510", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 setHintString(&"_encstr_BA1A23BD935F841417387748FF3F18C1191FD20B60C711092107D1EEFB85319C16A0DE19FD");
  var_0 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(120);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 makeusable();
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  level notify("_encstr_99AD06D3A5B1538B");
  level.player scripts\mp\equipment::giveequipment("_encstr_8BBB0B9D41E718D9E922D8582A", "_encstr_BA7F0830B3A7859B60B0");
  level.player playSound("_encstr_AC7E11C0DBA7DDEECB79A6AA5DF3D685CA7248");
  var_0 makeunusable();
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D");
  wait 1;
}

wave_single_progression(var_0, var_1) {
  hud_inter_round_flow(var_1);
  level notify("_encstr_8C6C0995D867872FA92BBD");
  level.target_wave = var_1;
  var_2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var_2 + 60000);
  var_3 = 1;

  while(isalive(level.player)) {
    if(gettime() > var_2 + 60000) {
      break;
    }

    if(!scripts\engine\utility::flag("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3") && gettime() > var_2 + 60000 - 5000) {
      scripts\engine\utility::flag_set("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  level notify("_encstr_916D0BFF4B38D7122550E2FA39");
  level.player thread set_actualstarttime();
  scripts\engine\utility::flag_clear("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
  var_4 = clamp(var_2 + 60000 - gettime(), 0, 60000);
}

player_init() {
  while(!isalive(level.player))
    waitframe();

  var_0 = "_encstr_BED80D7C9C59D95BF870DBDFA9F018";
  level.player giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
}

set_actualstarttime() {
  level endon("_encstr_85F206A6C7DB7DBA");
  wait 0.5;

  for(;;) {
    self.gastakenweaponobj = self getheldoffhand();

    if(isDefined(self.gastakenweaponobj)) {
      var_0 = scripts\mp\equipment::getequipmentreffromweapon(self.gastakenweaponobj);

      if(isDefined(var_0) && scripts\mp\equipment::hasequipment(var_0)) {
        self.gastakenweaponammo = scripts\mp\equipment::getequipmentammo(var_0);
        self takeweapon(self.gastakenweaponobj);
        waitframe();
        level.player scripts\mp\equipment::giveequipment("_encstr_8BBB0B9D41E718D9E922D8582A", "_encstr_BA7F0830B3A7859B60B0");
        level.player freezecontrols(1);
      }
    }

    waitframe();
  }
}

trial_failure_countdown() {
  for(var_0 = 5; var_0 > 0; var_0--) {
    level endon("_encstr_916D0BFF4B38D7122550E2FA39");
    level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
    wait 1;
  }

  scripts\engine\utility::flag_clear("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
}

target_think() {
  level endon("_encstr_916D0BFF4B38D7122550E2FA39");
  level.player endon("_encstr_84670547C3E9F4");
  self endon("_encstr_A92C09EB4323AA7301A0D3");

  for(;;) {
    self.activated = 0;
    level waittill("_encstr_8C6C0995D867872FA92BBD");

    if(isDefined(level.trial["_encstr_B6A208B3C2275AC2B9E8"])) {
      if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_979206BB0FC3706E") {
        if(isDefined(self.script_parameters) && isDefined(self.light)) {
          wait(20.0 * (int(self.script_parameters) - 1));
          thread _id_13B6D();
        }
      }
    }

    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.activated = 1;

    for(;;) {
      level.player waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0);

      if(!self.activated) {
        break;
      }

      thread _id_13A5C(var_0);
    }
  }
}

_id_13B6D() {
  self endon("_encstr_A9090A79DFB844FB97A3627A");
  wait 15.0;

  if(self.activated) {
    var_0 = 0.25;

    for(var_1 = 0; var_1 < 8.0; var_1++) {
      self.light weaponusagecheck(1);
      wait(var_0);
      self.light weaponusagecheck(0, 1);
      wait(var_0);
    }
  }

  waitframe();
  self.activated = 0;
  waitframe();
  self notify("_encstr_A92C09EB4323AA7301A0D3");
}

whistling() {
  var_0 = sortbydistance(level.course_targets, self.origin);

  if(isDefined(self.target)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(isDefined(var_0[var_1].target)) {
        if(var_0[var_1].target == self.target && var_0[var_1].linked == 0) {
          var_0[var_1].linked = 1;
          self.heli_starts_clear = var_0[var_1];
          break;
        }
      }
    }
  } else {
    if(distance(var_0[0].origin, self.origin) >= 150) {
      weaponusagecheck(0);
      return;
    }

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(var_0[var_1].linked == 0) {
        var_0[var_1].linked = 1;
        self.heli_starts_clear = var_0[var_1];
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

whizby_onplayerconnect() {
  weaponusagecheck(0, 1);

  for(;;) {
    level waittill("_encstr_8C6C0995D867872FA92BBD");

    while(!self.heli_starts_clear.activated)
      waitframe();

    weaponusagecheck(1);
    whistletimer();
  }
}

whistletimer() {
  level endon("_encstr_916D0BFF4B38D7122550E2FA39");
  level.player endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!self.heli_starts_clear.activated) {
      weaponusagecheck(0);
      break;
    }

    waitframe();
  }
}

weaponusagecheck(var_0, var_1) {
  if(istrue(self.playerzombiejumpstop)) {
    killfxontag(scripts\engine\utility::getfx("_encstr_B4831043111887127B07636B0F14BBF5A8B8"), self, "_encstr_AF44347BAD49FB7FE725415DA0683BADA3EF56B0C3D691B01A1332E3E3A2DF90EC20EAD16A1152B169BF2210C51E9F6BC8BA62D16272");
    self.playerzombiejumpstop = 0;
  }

  if(istrue(self.playerzombiepowerstartcooldown)) {
    killfxontag(scripts\engine\utility::getfx("_encstr_B2F30E4B1FF071B902077141CF9B75F0"), self, "_encstr_AA0A326E3A0B1DD2B7732C27977DD14E16B49BBC0B39C8BEE69676CDC21BAF1B2DEC34E8E6BEC089FA2759917DE6E08C98B01B1B");
    self.playerzombiepowerstartcooldown = 0;
  }

  waitframe();

  if(istrue(var_1))
    self setModel("_encstr_846F326ED158E8D2ED9B2C272F7D8E39B0B473F285278CAF6EA5D9B9B01BBE36D2D90D8E37F51889D7E61C3298C236B1AFBD3366");
  else {
    waitframe();

    if(var_0) {
      self setModel("_encstr_AF44347BAD49FB7FE725415DA0683BADA3EF56B0C3D691B01A1332E3E3A2DF90EC20EAD16A1152B169BF2210C51E9F6BC8BA62D16272");
      self.playerzombiejumpstop = 1;
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("_encstr_B4831043111887127B07636B0F14BBF5A8B8"), self, "_encstr_AF44347BAD49FB7FE725415DA0683BADA3EF56B0C3D691B01A1332E3E3A2DF90EC20EAD16A1152B169BF2210C51E9F6BC8BA62D16272");
      return;
    }

    self setModel("_encstr_AA0A326E3A0B1DD2B7732C27977DD14E16B49BBC0B39C8BEE69676CDC21BAF1B2DEC34E8E6BEC089FA2759917DE6E08C98B01B1B");
    self.playerzombiepowerstartcooldown = 1;
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("_encstr_B2F30E4B1FF071B902077141CF9B75F0"), self, "_encstr_AA0A326E3A0B1DD2B7732C27977DD14E16B49BBC0B39C8BEE69676CDC21BAF1B2DEC34E8E6BEC089FA2759917DE6E08C98B01B1B");
  }
}

_id_13A5C(var_0) {
  level endon("_encstr_92640BE052DA87E183076BD304");

  while(isDefined(var_0)) {
    if(!isDefined(self.script_targettype)) {
      if(self istouching(var_0)) {
        self.activated = 0;
        var_0.spawn_infil_lbravo = 1;
        self notify("_encstr_A9090A79DFB844FB97A3627A");
        thread score_event_target_hit(self.script_noteworthy, self);

        if(isDefined(self.light))
          level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
        else {
          level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A5AF0A4B1B1833FAFE9187E3");
          level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] + int(self.script_noteworthy);
        }

        level notify("_encstr_92640BE052DA87E183076BD304");
        break;
      }
    } else if(distancesquared(var_0.origin, self.origin) < 361) {
      self.activated = 0;
      var_0.spawn_infil_lbravo = 1;
      self notify("_encstr_A9090A79DFB844FB97A3627A");
      thread score_event_target_hit(self.script_noteworthy, self);

      if(!isDefined(self.script_targettype))
        level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
      else {
        level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A5AF0A4B1B1833FAFE9187E3");
        level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] + int(self.script_noteworthy);
      }

      level notify("_encstr_92640BE052DA87E183076BD304");
      break;
    }

    waitframe();
  }
}

_id_11DB1() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level._id_11DB8, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "_encstr_A16007A921A23B85E3");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  for(;;) {
    level waittill("_encstr_8C6C0995D867872FA92BBD");
    _id_11DB2();
  }
}

_id_11DB2() {
  for(;;) {
    var_0 = self.mover_ends[self.moveforward];
    var_1 = distance(self.origin, var_0.origin);
    var_2 = var_1 / self.move_speed;
    var_2 = clamp(var_2, 0.05, 9999);
    var_3 = 0.5;
    self moveTo(var_0.origin, var_2, var_3, var_3);
    wait(var_2);
    self.moveforward = !self.moveforward;
  }
}

trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["_encstr_AF9B051E1D0B0C"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
    level.score_initialized_once = 1;
  }

  level.trial_fail_alt = 0;
  level.score["_encstr_BE7D0633C08849E2"] = 0;
  level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
  level.score["_encstr_92640BE052DA87E183076BD304"] = 0;
  level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"] = 0;
  level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"] = 0;
  level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"] = 0;
  level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"] = 0;
  level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = 0;
  level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = 0;
  score_calculate();
}

score_event_target_hit(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 100;

  if(int(var_0) >= 300 && isDefined(var_1.light) && level.light_tank_initdamage) {
    level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545");
    level.light_tank_initdamage = 0;
    level notify("_encstr_B2DA070A5F8BAB87AF");
  }

  if(isDefined(self.script_targettype) && level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_979206BB0FC3706E") {
    if(isDefined(self.script_parameters))
      var_0 = int(var_0) - int(self.script_parameters);
  }

  if(!isDefined(self.script_targettype))
    level.score["_encstr_92640BE052DA87E183076BD304"] = level.score["_encstr_92640BE052DA87E183076BD304"] + int(var_0);

  level.player thread scripts\mp\rank::scorepointspopup(int(var_0));
  waitframe();
  score_calculate();
}

score_calculate(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.score["_encstr_AAAC09701B829B88093F5B"] = level.score["_encstr_92640BE052DA87E183076BD304"];
  level.score["_encstr_BE7D0633C08849E2"] = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"];
  _tablethide::trial_ui_set_subscore(level.score["_encstr_BE7D0633C08849E2"]);
  hud_set_reward_tier();

  if(var_0) {
    wait 1;

    if(istrue(level.trial_fail_alt)) {
      level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
      level.score["_encstr_BE7D0633C08849E2"] = 0;
      level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = 0;
      level.trial_fail_alt = 0;
    }

    _tablethide::trial_ui_set_stat_and_bonus_score(1, "_encstr_995313C213307B82BFD17F2B33DEAAB5605EBCCC0B", 0, level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"]);
    _tablethide::trial_ui_set_secondary_timer(-1);
    _tablethide::trial_ui_set_main_score(level.score["_encstr_BE7D0633C08849E2"]);

    if(level.score["_encstr_AF9B051E1D0B0C"] < level.score["_encstr_BE7D0633C08849E2"]) {
      level.score["_encstr_AF9B051E1D0B0C"] = level.score["_encstr_BE7D0633C08849E2"];
      _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A1900FDA05DB637941300AA2D0676CD7D3"] = level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"];
    }

    hud_set_reward_tier(1);
    level notify("_encstr_B8D80D131723B292AB2759B2975BA0");
    thread _tablethide::trial_ui_open_results_screen();
    level waittill("_encstr_93EF1C7B3880D17207869F126D39AB8BEE88AFFB68F906894F9FE74D5DC1");
    _tablethide::trial_ui_set_subscore(level.score["_encstr_AAAC09701B829B88093F5B"]);
  }
}

hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"] = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
}

hud_set_reward_tier(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    var_1 = level.score["_encstr_AF9B051E1D0B0C"];
  else
    var_1 = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_A5AF0A4B1B1833FAFE9187E3"];

  if(var_1 >= level.trial["_encstr_966C066BF011B2F7"])
    var_2 = 3;
  else if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
    var_3 = level.trial["_encstr_966C066BF011B2F7"] - level.trial["_encstr_876C06B1FF0A66F2"];
    var_4 = var_1 - level.trial["_encstr_876C06B1FF0A66F2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
    var_3 = level.trial["_encstr_876C06B1FF0A66F2"] - level.trial["_encstr_816C069599555DA7"];
    var_4 = var_1 - level.trial["_encstr_816C069599555DA7"];
    var_2 = 1 + var_4 / var_3;
  } else
    var_2 = var_1 / level.trial["_encstr_816C069599555DA7"];

  if(var_0) {
    _tablethide::trial_ui_set_reward_tier(var_2);

    if(var_1 >= level.trial["_encstr_966C066BF011B2F7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_6]);
      return;
    }

    if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
      var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_6]);
      return;
    }

    var_5 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_6 = randomint(var_5);
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_6]);
    return;
    return;
    return;
  } else
    _tablethide::trial_ui_set_reward_tier_preview(var_2);
}

hud_inter_round_flow(var_0) {
  _tablethide::trial_ui_freeze_secondary_timer(1);
  level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  level.target_wave = var_0;
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1");
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_821F0F67281F7393A7472371C14ACB0A2F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_A22715C59361EB933D4B4B07A3501B2238DEFA0CE86094";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_869D1341EA0117E38D6748295FAE39179F5245DFC2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_91C8135B0EAF6E83ACC29CAFB2CD917D26CDD1584E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_BA2A135B83D79B0EB22C4EAF2B37197D916E8E85E4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_8B0E13AD1CFA9B382B1627EB95DC8CFACCE68E85E4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_AD0110D643FACDCD2D1C5939BEC956D19CE5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81960D633820CB5FE501C3ABE83DD3"] = "_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81600E3A28A8908AEE6F07577B9692F0"] = "_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545"] = "_encstr_92E81168DA9750F7825F05574FDA32E94874B3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B781032D823F39DB3F9ABC7886B49C9A36F"] = "_encstr_AFE8116B07F5E607CA0B93FABD31D47D9BB076";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82D311B99B96C1594EAFA3272FAFC23B8596E6"] = "_encstr_8201126773C987BB41022658F0E60A3F75E327AB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5AF0A4B1B1833FAFE9187E3"] = "_encstr_A39B17C39B89B2189A9ED0EE50BA65B01FF7EB21522B921A33";
  thread light_tank_monitordriverturretprojectilefire();
  thread dialog_missed_shots_watcher();
}

light_tank_monitordriverturretprojectilefire() {
  level.light_tank_initdamage = 1;

  for(;;) {
    level waittill("_encstr_B2DA070A5F8BAB87AF");
    wait 10;
    level.light_tank_initdamage = 1;
  }
}

dialog_missed_shots_watcher() {
  level._id_11C48 = 0;

  for(;;) {
    level waittill("_encstr_8C6C0995D867872FA92BBD");
    level._id_132BB = 3;
    level_use_carepackage();
  }
}

level_use_carepackage() {
  level endon("_encstr_916D0BFF4B38D7122550E2FA39");

  for(;;) {
    level.player waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0);
    var_0.spawn_infil_lbravo = 0;
    thread level_spawnplayer(var_0);
  }
}

level_spawnplayer(var_0) {
  var_1 = 0;

  while(isDefined(var_0)) {
    var_1 = var_0.spawn_infil_lbravo;
    waitframe();
  }

  if(!var_1) {
    level._id_11C48++;

    if(level._id_11C48 >= level._id_132BB) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9B781032D823F39DB3F9ABC7886B49C9A36F");
      level._id_11C48 = 0;
      level._id_132BB++;
    }
  } else
    level._id_11C48 = 0;
}

_id_12160() {
  var_0 = getEnt("_encstr_BD7D0C1C33C5559F3A7F2F912510", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!isalive(level.player))
    waitframe();

  var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_0, level.player, "_encstr_8294137D0BA3CC0AA05BF7539DDB7234B1103347A0", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  level waittill("_encstr_99AD06D3A5B1538B");
  scripts\mp\utility\outline::outlinedisable(var_1, var_0);
}

set_chopper_search_speed() {
  for(;;) {
    level.player waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0);
    playFXOnTag(scripts\engine\utility::getfx("_encstr_83D610ECBE3B362DFDFA60D0F113FD09972C"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }
}

_id_12A90(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1]))
    var_2.progress[var_1] = 0;

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(var_4 < var_5)
    var_2.progress[var_1] = var_2.progress[var_1] + 0.166667;
  else
    var_2.progress[var_1] = 0;

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
  }
}

_id_12A8F() {
  while(!isalive(level.player))
    waitframe();

  for(;;) {
    while(isalive(level.player)) {
      _id_12A91(level.player);
      wait 0.1;
    }

    waitframe();
  }
}

_id_12A91(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  _id_12A90(var_0, "_encstr_BA7F0830B3A7859B60B0");
  _id_12A90(var_0, "_encstr_AC8F0AE74163F85AAA380AD8");
  _id_12A92(var_0);
}

_id_12A92(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["_encstr_BA7F0830B3A7859B60B0"]))
      var_1 = var_4.progress["_encstr_BA7F0830B3A7859B60B0"];

    if(isDefined(var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"]))
      var_2 = var_4.progress["_encstr_AC8F0AE74163F85AAA380AD8"];

    foreach(var_7, var_6 in var_4.recharged) {
      if(var_7 == "_encstr_BA7F0830B3A7859B60B0") {
        var_3 = var_3 + 1;
        var_0 playlocalsound("_encstr_B229132D8BA1C2F7DEE3824AE8202BFF1011B18C17");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }

      if(var_7 == "_encstr_AC8F0AE74163F85AAA380AD8") {
        var_3 = var_3 + 2;
        var_0 playlocalsound("_encstr_871E14BB5357CB959B58BF8748F65C22877504B6CF49");
        var_0 scripts\mp\utility\stats::incpersstat("_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D", 1);
      }
    }
  }

  var_0 setclientomnvar("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", var_1);
  var_0 setclientomnvar("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", var_2);
  var_0 setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", var_3);
}

script_gameobjetname() {
  level waittill("_encstr_99AD06D3A5B1538B");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player))
        waitframe();

      var_0 = "_encstr_BA7F0830B3A7859B60B0";
      level.player scripts\mp\equipment::giveequipment("_encstr_8BBB0B9D41E718D9E922D8582A", var_0);
    }

    waitframe();
  }
}

weapon_xp_iw8_sn_awhiskey() {
  level._id_12D3A = getEntArray("_encstr_965306392D3336B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12382 = getEntArray("_encstr_8E4708C12DE8D834AC27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 0.05;

  if(level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"] == 801 || 802) {
    foreach(var_1 in level._id_12D3A)
    var_1 setlightintensity(0);

    foreach(var_1 in level._id_12382)
    var_1 setlightintensity(5);
  } else {
    foreach(var_1 in level._id_12D3A)
    var_1 setlightintensity(0);

    foreach(var_1 in level._id_12382)
    var_1 setlightintensity(0);
  }
}

player_monitor_death() {
  for(;;) {
    level waittill("_encstr_8C6C0995D867872FA92BBD");
    level.player waittill("_encstr_AD75063D571AE108");
    level.trial_fail_alt = 1;
    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 1);
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D37;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A1900FDA05DB637941300AA2D0676CD7D3"] = 0;
  }
}

_id_13D37() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A1900FDA05DB637941300AA2D0676CD7D3"]);
  level.player dlog_recordplayerevent("_encstr_A60322E8F8C0F7AF17E8D78B73E9E96B13707089307A30B205DFD1AFC7335819C72BFB6E", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_82FB06EB26785BD7", var_2, "_encstr_AC2F09B9E095B1B4C2C6CD", var_3]);
}