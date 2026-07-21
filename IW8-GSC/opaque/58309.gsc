/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58309.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_850707F7E5833355B8"] = ::_id_1343A;
}

_id_1343A() {
  build_vehicle_drop_off_list();

  if(!isDefined(level.showdebugresult))
    level.showdebugresult = 7500;

  scripts\engine\utility::flag_init("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
  var_0 = getEntArray("_encstr_A13C12A3C2E4B39547FA31C9D5CD1AD6F6232BC6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_2.targetname = "_encstr_A3BA05E0735C50";
    var_2.target = "_encstr_A3BA05E0735C50";
  }

  while(!isDefined(level.struct_class_names))
    waitframe();

  dialog_init();
  progression();
}

progression() {
  level.course_triggers = getEntArray("_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("_encstr_8D6A0CDAEDECCA93EBCDD12C39D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  _tablethide::waittill_player_isDefined();

  foreach(var_1 in level.course_targets) {
    var_1.activated = 0;
    var_1 thread target_think();
  }

  level._id_13D45 = getEntArray("_encstr_A2690CA383FC6B20CFDE8977A24F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_13D45))
    scripts\engine\utility::array_thread(level._id_13D45, ::_id_13D7E);

  level._id_13D7C[1] = getEntArray("_encstr_A14C06B34A83E5DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D7C[2] = getEntArray("_encstr_A74C0667D3A04FD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D7C[3] = getEntArray("_encstr_AB4C066FB87BDD8F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D7C[4] = getEntArray("_encstr_AC4C06479053C5E7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player thread infinite_reserve_ammo_not_revolver();
  level.player scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  level.player scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  hud_init();

  for(;;) {
    trial_score_init();
    score_event_time_remaining(25000, 25000, 25000, 25000);
    level.target_wave = 0;
    _tablethide::trial_ui_set_wave(1, 4);
    course_start_wait();
    _tablethide::_id_13D88();
    _tablethide::_id_13D89(0);
    wave_single_progression(level._id_13D7C[1], 1);
    wave_single_progression(level._id_13D7C[2], 2);
    wave_single_progression(level._id_13D7C[3], 3);
    wave_single_progression(level._id_13D7C[4], 4);
    score_calculate(1);
    _tablethide::_id_13D89(1);

    foreach(var_7 in level.player.primaryinventory)
    level.player setweaponammoclip(var_7, weaponclipsize(var_7));

    _tablethide::trial_ui_waittill_retry();
    level notify("_encstr_AAC30CB5E0384E6BD74B5D8BBBF8");
  }
}

course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }
  var_0 = getEnt("_encstr_8D360838D3CB51A8EEEF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  while(!isDefined(var_0.spawned_weapon))
    waitframe();

  while(isDefined(var_0.spawned_weapon))
    waitframe();

  level notify("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  level.trial_first_start = 1;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D");
  wait 1;
}

wave_single_progression(var_0, var_1) {
  hud_inter_round_flow(var_1);
  level notify("_encstr_8C6C0995D867872FA92BBD");
  level.target_wave = var_1;
  _tablethide::trial_ui_set_wave(level.target_wave, 4);
  var_2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var_2 + 25000);
  var_3 = 1;

  foreach(var_5 in var_0)
  var_5 thread target_flip("_encstr_87070365F7");

  var_7 = 0;

  for(;;) {
    var_8 = 1;

    foreach(var_5 in var_0) {
      if(!var_5.activated && !isDefined(var_5.is_civilian))
        var_8 = 0;
    }

    if(var_8) {
      break;
    }

    if(gettime() > var_2 + 25000 - level.showdebugresult && istrue(level._id_13D8F) && !var_7) {
      var_7 = 1;
      thread spawn_fulton_rope_mdl(var_0, 1);
    }

    if(gettime() > var_2 + 25000) {
      break;
    }

    if(!scripts\engine\utility::flag("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3") && gettime() > var_2 + 25000 - 5000) {
      scripts\engine\utility::flag_set("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
      thread trial_failure_countdown();
    }

    waitframe();
  }

  if(istrue(level._id_13D8F))
    thread spawn_fulton_rope_mdl(var_0, 0);

  level notify("_encstr_A94C0B770B9DB27D2B37C85691", var_1);
  scripts\engine\utility::flag_clear("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
  var_11 = clamp(var_2 + 25000 - gettime(), 0, 25000);

  foreach(var_5 in var_0)
  var_5 thread target_flip("_encstr_9767056D0FBFA8");

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

spawn_fulton_rope_mdl(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_1) {
      if(!var_3.activated && !isDefined(var_3.is_civilian)) {
        var_3.headicon = deleteheadicon(var_3);
        setheadiconfriendlyimage(var_3.headicon, "_encstr_96321214C71FF589CDD31BCE79D3311565109703");
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

trial_failure_countdown() {
  for(var_0 = 5; var_0 > 0; var_0--) {
    level endon("_encstr_A94C0B770B9DB27D2B37C85691");
    level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
    wait 1;
  }

  scripts\engine\utility::flag_clear("_encstr_B21E1FB27391EEB09DACF5C2BA19D2F61BEDD5CDD191F6BBE6BEE457CDB95A37B3");
}

target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "_encstr_818E0EB98D4EA5078ED7C64B37B6E8ED");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var_1 in self.parts) {
    switch (var_1.script_noteworthy) {
      case "_encstr_AB270DF4CF33E72F9991639A58A167":
        self.plate = var_1;

        if(isDefined(self.plate.target))
          self.plate.should_break_stealth_immediately = 1;

        break;
      case "_encstr_81640BFBC970878AED6F4F0B63":
        self.arm = var_1;
        break;
      case "_encstr_970D0C6907A334A0E441D18972DD":
        self.base = var_1;
        break;
      case "_encstr_B4D60E3A164EB3B2E8EBBB432B958DCD":
        self.wheels = var_1;
        break;
      case "_encstr_AC160DCC7B286757FD26A21AC8D82B":
        self.see_recently_override = var_1;
        break;
      case "_encstr_AA4C0D744FB367AF1911D30AA81FE7":
        self.smoke = var_1;
        break;
      default:
        break;
    }

    var_1.target = "_encstr_A3BA05E0735C50";
    var_1.targetname = "_encstr_A3BA05E0735C50";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.see_recently_override))
    self.see_recently_override linkTo(self);

  if(istrue(self.plate.should_break_stealth_immediately))
    self.plate thermaldrawdisable();

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  if(isDefined(self.smoke))
    self.smoke linkTo(self);

  self.state_up = 0;
  self.flipping = 0;
  thread target_damage();
  self.activated = 0;

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    thread moving_target_think();

  if(issubstr(self.script_noteworthy, "_encstr_83E8094727E333E8F9CE50"))
    self.is_civilian = 1;
}

gettargetarray() {
  var_0 = ["_encstr_ADEA101F347937E09B80F4F15B67A091577B", "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B", "_encstr_A16E1043ABD3BF0DC30BE209502B424F698D"];
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3[var_2] = scripts\engine\utility::getStructArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(var_0[var_2] == "_encstr_A16E1043ABD3BF0DC30BE209502B424F698D") {
      if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_8D940738966ED1DB8D") {
        continue;
      }
      if(var_3[var_2].size > 0)
        level.show_marker_to_tv_station = 1;
    }

    foreach(var_5 in var_3[var_2]) {
      var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_5.origin);
      var_6.angles = var_5.angles;
      var_6.script_gameobjectname = var_5.script_gameobjectname;
      var_6.script_linkname = var_5.script_linkname;
      var_6.script_noteworthy = var_5.script_noteworthy;
      var_6.target = var_5.target;
      var_6.targetname = var_5.targetname;
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = getEntArray(var_0[var_2], "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  return scripts\engine\utility::array_combine_multiple(var_1);
}

target_damage() {
  for(;;) {
    self.activated = 0;
    self.plate waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.plate playSound("_encstr_A6441EE8E45A2C8DFACD33E1BEA3169CB356A37DC92B1CED9CE8D7D6ACD1C28D");

    if(isDefined(self.smoke))
      magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", self.smoke.origin, (0, 0, -1), 0.05);

    if(!isDefined(level.targethitsinaframecount))
      level.targethitsinaframecount = 0;

    level.targethitsinaframecount++;
    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.player thread _tablethide::_id_13D4B(self.plate, 1, 0, 0);
    level.last_hit_target = self;
    thread target_flip("_encstr_9767056D0FBFA8");
    self.activated = 1;

    if(isDefined(self.headicon)) {
      setheadiconimage(self.headicon);
      self.headicon = undefined;
    }

    waittillframeend;

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self)
      thread score_event_collateral(level.targethitsinaframecount);

    if(istrue(self.is_civilian)) {
      level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"] = level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"] + 100;
      _tablethide::trial_ui_set_stat_and_bonus_score(5, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"] / 100, level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"] * -1);
      level.player thread scripts\mp\rank::scoreeventpopup("_encstr_850616EBDD83225CD149448B206091FAE86F6F1779B92A0C");
      level.player playSound("_encstr_9B2017BDC63A5785BED74D9A778A753260F5CBEF2BF1D2F81B");
      waitframe();
      score_calculate();
    } else if(istrue(self._id_129F7))
      thread score_event_target_hit(200);
    else
      thread score_event_target_hit(100);

    level.targethitsinaframecount = 0;
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
  }
}

target_flip(var_0) {
  if(var_0 == "_encstr_87070365F7") {
    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(isDefined(self.see_recently_override))
      self.seen_recently_spawner_time = playFXOnTag(scripts\engine\utility::getfx("_encstr_95411458AD89AB37D0FADCE65AE0B2E4BE3B36A5378E"), self.see_recently_override, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    if(self.state_up) {
      return;
    }
    self.state_up = 1;
    var_1 = 1;
    self.activated = 0;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.see_recently_override))
      killfxontag(scripts\engine\utility::getfx("_encstr_95411458AD89AB37D0FADCE65AE0B2E4BE3B36A5378E"), self.see_recently_override, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    if(!self.state_up) {
      return;
    }
    self.state_up = 0;
    var_1 = -1;
  }

  var_2 = undefined;
  var_3 = undefined;

  switch (self.script_noteworthy) {
    case "_encstr_A16E1043ABD3BF0DC30BE209502B424F698D":
    case "_encstr_BDED0E55B8FD8276F1D9FBB7A8A9351B":
    case "_encstr_ADEA101F347937E09B80F4F15B67A091577B":
      var_3 = 90;
      var_2 = 0.1;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "_encstr_ACC107AD988D31CD07"))
    waitframe();

  if(var_0 == "_encstr_87070365F7")
    self playsoundonmovingent("_encstr_AB551805A2AAFBB86FE710D86F7CD115928FFD183F5253632D83");

  if(self.initial_up[1] != 0)
    self rotateYaw(-1 * self.initial_up[1] * var_3 * var_1, var_2);
  else
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);

  wait(var_2);
  self.flipping = 0;
}

moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "_encstr_A16007A921A23B85E3");

  if(self.mover_ends.size > 2)
    self._id_129F7 = 1;

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
      self notify("_encstr_A1C40C9E5C97238F6DCAF04BB287");
      self.moving = 0;
      self.dummy delete();
    } else if(!self.flipping && !self.moving && 90 < distance(level.players[0].origin, self.origin) && self.state_up)
      thread moving_target_mover();

    waitframe();
  }
}

moving_target_mover() {
  self endon("_encstr_A1C40C9E5C97238F6DCAF04BB287");
  self.moving = 1;
  self.dummy = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  childthread target_follow_dummy();

  for(;;) {
    if(istrue(self._id_129F7))
      var_0 = scripts\engine\utility::random(self.mover_ends);
    else
      var_0 = self.mover_ends[self.moveforward];

    var_1 = distance(self.dummy.origin, var_0.origin);
    var_2 = var_1 / self.move_speed;
    var_2 = clamp(var_2, 0.05, 9999);
    var_3 = 0.5;
    var_3 = clamp(var_3, 0, var_2 / 2);
    self.dummy moveTo(var_0.origin, var_2, var_3, var_3);
    wait(var_2);
    self.moveforward = !self.moveforward;
  }
}

moving_target_reset() {
  for(;;) {
    level waittill("_encstr_93EF1C7B3880D17207869F126D39AB8BEE88AFFB68F906894F9FE74D5DC1");
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
    level.score["_encstr_AF9B051E1D0B0C"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_BA1B0A87570D8FFB71BAF74A"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A3B10A83EF8D325AE338CF17"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1780A3077A37AEF2B44E8DD"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_85D50ABF22C3BD6A69412B5D"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
    level.score_initialized_once = 1;
  }

  level.score["_encstr_BE7D0633C08849E2"] = 0;
  level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
  level.score["_encstr_92640BE052DA87E183076BD304"] = 0;
  level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"] = 0;
  level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"] = 0;
  level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"] = 0;
  level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"] = 0;
  level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = 0;
  level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"] = 0;

  if(istrue(level.show_marker_to_tv_station))
    _tablethide::trial_ui_set_stat_and_bonus_score(5, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"], level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"]);

  score_calculate();
}

score_event_target_hit(var_0) {
  level.score["_encstr_92640BE052DA87E183076BD304"] = level.score["_encstr_92640BE052DA87E183076BD304"] + var_0;
  level.player thread scripts\mp\rank::scorepointspopup(var_0);
  waitframe();
  score_calculate();
}

score_event_collateral(var_0) {
  var_1 = 50 * (var_0 - 1);
  level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"] + var_1;

  switch (var_0) {
    case 3:
      var_2 = "_encstr_8C27181B13EBE77D91B717EC5198833F8EE912117B3EBF322093";
      break;
    case 4:
      var_2 = "_encstr_8ADB16A3C9B42CD8AF36DB8D362CD1CA93168DAFE2BA0B91";
      break;
    default:
      var_2 = "_encstr_88DC11600BA99161417610A98D9A69D91ADF28";
      break;
  }

  level.player thread scripts\mp\rank::scoreeventpopup(var_2);
  level.player thread scripts\mp\rank::scorepointspopup(var_1);
  level notify("_encstr_8893184727D20B1B7DCDB9B41CAC93BE1BB7D863C2E82B4E58B1");
}

score_event_time_remaining(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"] = scripts\mp\utility\script::limitdecimalplaces(var_0 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(1, "_encstr_AAD516EEC29DACAF98D7E85A5BCAD7C9B25BB096B9A5B9CE", var_0, level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"]);
  }

  if(isDefined(var_1)) {
    level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"] = scripts\mp\utility\script::limitdecimalplaces(var_1 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(2, "_encstr_84A41663D6E6B838BFDF41630F9260488DAD2938BD5138EC", var_1, level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"]);
  }

  if(isDefined(var_2)) {
    level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"] = scripts\mp\utility\script::limitdecimalplaces(var_2 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(3, "_encstr_A1501683360658D84FFF61432FF2AF28AD8DC9D89D71588C", var_2, level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"]);
  }

  if(isDefined(var_3)) {
    level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"] = scripts\mp\utility\script::limitdecimalplaces(var_3 / 1000, 1) * 10;
    _tablethide::trial_ui_set_stat_and_bonus_score(4, "_encstr_8381160BF960B539DD7F6B17732D61FA50C00614F0607672", var_3, level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"]);
  }
}

score_calculate(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.score["_encstr_AAAC09701B829B88093F5B"] = level.score["_encstr_92640BE052DA87E183076BD304"] + level.score["_encstr_B49B0B6CDEC68DC28EAC4E168D"];
  level.score["_encstr_BE7D0633C08849E2"] = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"] + level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"] + level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"] + level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"] - level.score["_encstr_ACE6101E42334AF00330389E03FFE2D1C5D4"];
  _tablethide::trial_ui_set_subscore(level.score["_encstr_AAAC09701B829B88093F5B"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    wait 1;

    if(level.score["_encstr_BE7D0633C08849E2"] < 0)
      level.score["_encstr_BE7D0633C08849E2"] = 0;

    _tablethide::trial_ui_set_main_score(level.score["_encstr_BE7D0633C08849E2"]);

    if(level.score["_encstr_AF9B051E1D0B0C"] < level.score["_encstr_BE7D0633C08849E2"]) {
      level.score["_encstr_AF9B051E1D0B0C"] = level.score["_encstr_BE7D0633C08849E2"];
      _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_BA1B0A87570D8FFB71BAF74A"] = level.score["_encstr_A21D12472DAD2BFAE4CAD6B04BCDD2CDCEEBEE26"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A3B10A83EF8D325AE338CF17"] = level.score["_encstr_B61D123A4BB659BE9356B60B96B99673B3BEEE91"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1780A3077A37AEF2B44E8DD"] = level.score["_encstr_B41D12A3A56BCAFAC9596B8596E65A9BD9D7EE66"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_85D50ABF22C3BD6A69412B5D"] = level.score["_encstr_A91D1229A9E590187BFA08B10233CB73BF07A751"];
    }

    hud_set_reward_tier(1);
    level notify("_encstr_B8D80D131723B292AB2759B2975BA0");

    if(_tablethide::_id_13D4C())
      wait 4;

    thread _tablethide::trial_ui_open_results_screen();
  }
}

hud_init() {
  level.target_wave = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_wave(1, 4);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
}

hud_set_reward_tier(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    var_1 = level.score["_encstr_AF9B051E1D0B0C"];
  else
    var_1 = level.score["_encstr_AAAC09701B829B88093F5B"];

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
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_A24C06879F945FA6" + var_0 + "_encstr_B4810709B378B9F3F5");
  level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");

  if(istrue(level._id_13D94) && isDefined(level._id_13D95) && level._id_13D95 == var_0) {
    var_1 = scripts\engine\utility::getStruct("_encstr_A753092332D9B881491F29", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    thread _id_13D6B(var_1);
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 10);
  } else
    scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);

  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_8BBA05185F8B99");
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  level.target_wave = var_0;
  _tablethide::trial_ui_set_wave(level.target_wave, 4);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1");
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_9AA810D60DF537B94B07CA9CAFD2CDA3397B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_A72F16B5A1F56E37960EB293D7A59B8EE4BDD79B1AED9347";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_97BC10B586FADCB95AC1594EFA373A5827C0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_ADBC10E0C06953EE04B8A1DB51C3712A631F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_81BC10D2681703AD2C7BA818614241990BE2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_AABC1008D281BF90C718DD4EDF471B63328F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_AD0110D643FACDCD2D1C5939BEC956D19CE5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81960D633820CB5FE501C3ABE83DD3"] = "_encstr_8DBC10D60DF5E6CD9683B293D737D1B0271D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81600E3A28A8908AEE6F07577B9692F0"] = "_encstr_A37311B686FA9BE62D38CA93D7372B85E46CA1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545"] = "_encstr_BABD13D6A1D79BCD968359C9AF3BDEDEC89B0DED1D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B781032D823F39DB3F9ABC7886B49C9A36F"] = "_encstr_921B12C7D8A14B152260B55A07029BA8DBE3D34A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82D311B99B96C1594EAFA3272FAFC23B8596E6"] = "_encstr_AD0110D643FACDCD2D1C5939BEC956D19CE5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99AC16D3A8B05BCF7571626A48D7C687C8014D6C35BB5FD2"] = "_encstr_B809195488E9908804F2F563F115E3D7A74D9D1DCAE73BF25AB8D7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC77118BDAF90B7132C6DB11244115A07F38D4"] = "_encstr_9A7314B51A7DDCB9B4839527F5DCC2D9AF6BDBD5738E";
  thread dialog_collateral_watcher();
  thread dialog_missed_shots_watcher();
  thread lgwperifvfx_plumes();
}

dialog_collateral_watcher() {
  for(;;) {
    level waittill("_encstr_8893184727D20B1B7DCDB9B41CAC93BE1BB7D863C2E82B4E58B1");
    level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_8F7B114E6D6211419A9FA89847A55E4F1A5545");
    wait 5;
  }
}

dialog_missed_shots_watcher() {
  var_0 = 1;
  var_1 = 1;

  for(;;) {
    level waittill("_encstr_8C6C0995D867872FA92BBD");
    level.shotsmissedcount = 0;

    for(;;) {
      level.player waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_2, var_3, var_4);
      var_5 = anglesToForward(var_4);
      level.shotsmissedcount++;
      waitframe();

      if(level.shotsmissedcount > 2) {
        if(var_0) {
          var_6 = undefined;
          var_7 = undefined;
          var_8 = undefined;
          var_9 = 360;

          foreach(var_11 in level._id_13D7C[level.target_wave]) {
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
              level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_99AC16D3A8B05BCF7571626A48D7C687C8014D6C35BB5FD2");
              var_0 = 0;
              break;
            }
          }
        }

        if(var_1 && level._id_13D52) {
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AC77118BDAF90B7132C6DB11244115A07F38D4");
          var_1 = 0;
        } else
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9B781032D823F39DB3F9ABC7886B49C9A36F");

        break;
      }
    }
  }
}

lgwperifvfx_plumes() {
  level._id_13D52 = 1;
  level waittill("_encstr_8C6C0995D867872FA92BBD");

  while(level.player playermount() <= 0.5)
    waitframe();

  level._id_13D52 = 0;
}

infinite_reserve_ammo_not_revolver() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = getEnt("_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = strtok(var_0.script_parameters, "_encstr_BE4C0295")[0];

  while(!isDefined(self.currentprimaryweapon))
    waitframe();

  for(;;) {
    var_2 = self.currentprimaryweapon;

    if(issubstr(var_2.basename, var_1))
      self setweaponammostock(var_2, 0);
    else
      self givemaxammo(var_2);

    waitframe();
  }
}

_id_13D6B(var_0) {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_84A8206730D045F2DB80EB24F3B90A377BC02F6F30C8B7CBEBAEF91C68BD62C5CDC8");
  var_1 = [];
  var_1[0] = spawnStruct();
  var_1[0].angles = var_0.angles[1];
  var_1[0].location = var_0.origin;
  var_1[0].string = "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773";
  var_2 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", level.player);
  var_2.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_2.streakname);
  var_2.mpstreaksysteminfo.attackerisinflictor = gettime();
  level.wpinprogress = 1;

  foreach(var_8, var_4 in var_1) {
    var_5 = var_4.location;
    var_6 = var_4.angles;
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_8D820B49520F0EC02DDE6367EC");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_81170C244F9CBDE72C01BB99A298");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_923011E397F3A22518DEF23AB1087CEAD53F1B");
    var_7 = level.player scripts\cp_mp\killstreaks\white_phosphorus::wp_createplane(var_5, var_6, var_2);

    if(!isDefined(var_7))
      return 0;

    objective_delete(var_7.minimapid);
    var_7 thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145EA();
    var_7 thread scripts\cp_mp\killstreaks\white_phosphorus::wp_deliverpayloads(var_2);

    if(var_1.size > 1 && var_8 < var_1.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

_id_13D7E() {
  for(;;) {
    level waittill("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
    wait 3;

    if(isDefined(self.script_noteworthy))
      wait(float(self.script_noteworthy));

    playFXOnTag(scripts\engine\utility::getfx("_encstr_A2690CA383FC6B20CFDE8977A24F"), self, "_encstr_91080625AFF390DF");
    self playSound("_encstr_B4BF18ECDBE6AF99D2C9B2BBB7395BFA9BD8272BC2ADFA37CCE1");

    if(isDefined(self.script_noteworthy))
      var_0 = 3 - float(self.script_noteworthy);
    else
      var_0 = 3;

    if(var_0 > 0)
      wait(var_0);

    stopFXOnTag(scripts\engine\utility::getfx("_encstr_A2690CA383FC6B20CFDE8977A24F"), self, "_encstr_91080625AFF390DF");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_93BC0F0B03FBD74DA18968159DE8D44B15"), self, "_encstr_91080625AFF390DF");
    self playSound("_encstr_84891787C7AEE176404BA72BED70B3390D4163235FC06B2EF0");
    wait 2.25;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_88D6138E27B416D8D78E34AC4EB6D21D95D72B3723"), self, "_encstr_91080625AFF390DF");
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_93BC0F0B03FBD74DA18968159DE8D44B15"), self, "_encstr_91080625AFF390DF");
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D39;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_BA1B0A87570D8FFB71BAF74A"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A3B10A83EF8D325AE338CF17"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1780A3077A37AEF2B44E8DD"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_85D50ABF22C3BD6A69412B5D"] = 0;
  }
}

_id_13D39() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_BA1B0A87570D8FFB71BAF74A"]);
  var_4 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A3B10A83EF8D325AE338CF17"]);
  var_5 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1780A3077A37AEF2B44E8DD"]);
  var_6 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_85D50ABF22C3BD6A69412B5D"]);
  level.player dlog_recordplayerevent("_encstr_BAAA21F96D1740D0D2535B4573598D50B9866016D64F587F9AE7616BC7E3D840581F2B", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_82FB06EB26785BD7", var_2, "_encstr_BA1B0A87570D8FFB71BAF74A", var_3, "_encstr_A3B10A83EF8D325AE338CF17", var_4, "_encstr_B1780A3077A37AEF2B44E8DD", var_5, "_encstr_85D50ABF22C3BD6A69412B5D", var_6]);
}