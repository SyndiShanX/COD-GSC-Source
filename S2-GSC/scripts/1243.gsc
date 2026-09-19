/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1243.gsc
**************************************/

_id_52B9() {
  waitframe();
  _id_8A48();
  level._id_7081 = [];
  spawnStruct();
  level._id_7081[0] = spawnStruct();
  level._id_7081[0]._id_9087 = common_scripts\utility::_id_46B5("plate_spawn_left", "targetname");
  level._id_7081[0]._id_7083 = (2000, 0, 1500);
  level._id_7081[1] = spawnStruct();
  level._id_7081[1]._id_9087 = common_scripts\utility::_id_46B5("plate_spawn_mid", "targetname");
  level._id_7081[1]._id_7083 = (2000, 300, 1500);
  level._id_7081[2] = spawnStruct();
  level._id_7081[2]._id_9087 = common_scripts\utility::_id_46B5("plate_spawn_right", "targetname");
  level._id_7081[2]._id_7083 = (2000, 600, 1500);
  level._id_3C40 = _getent("trigger_firing_range", "targetname");

  if(!isDefined(level._id_3C40)) {
    return;
  }
  level._id_3C40 thread _id_0478::_id_9DC3(::_id_37BD, ::_id_38F2);
  level._id_3C3F = common_scripts\utility::_id_46B7("firingrange_spawn", "targetname");
  level._id_4B13 = common_scripts\utility::_id_46B5("fireworks_start", "targetname");
  level._id_4871 = loadfx("vfx/map/mp_hub/hub_grenade_toss_reward_exp");
  level._id_707F = 0;
  level._id_9B6B = 0;
  level.aiphysicstracepassed = [];
  level.aiphysicstracepassed["melon"] = [];
  level.aiphysicstracepassed["tower"] = [];
  level.aiphysicstracepassed["plate"] = [];
  setdvarifuninitialized("hub_complete_sequence_easy", 0);
  setdvarifuninitialized("hub_complete_sequence_medium", 0);
  setdvarifuninitialized("hub_complete_sequence_hard", 0);
  setdvarifuninitialized("hub_start_civ_sequence", 0);
  setdvarifuninitialized("hub_start_plate_sequence", 0);
  setdvarifuninitialized("hub_launch_test_plate", 0);

  if(_func_3AE() == 0) {
    thread _id_63DF("hub_complete_sequence_easy", ::_id_36E9);
    thread _id_63DF("hub_complete_sequence_medium", ::_id_74C5);
    thread _id_63DF("hub_complete_sequence_hard", ::_id_74A7);
    thread _id_63DF("hub_start_civ_sequence", ::_id_4AFF);
    thread _id_63DF("hub_start_plate_sequence", ::_id_5C2C);
    thread _id_63DF("hub_launch_test_plate", ::_id_5C2E);
  }

  while(!isDefined(level._id_4F51))
    wait 1;

  level._id_3C3E = _getent("firing_range_icon", "targetname");
  level._id_3C3E._id_50DA = 1;
  level._id_4F51[level._id_4F51.size] = level._id_3C3E;
  return;
}

_id_63DF(var_0, var_1) {
  level endon("game_ended");

  while(getdvarint(var_0, 0) == 0)
    wait 1;

  if(_func_30D(var_1))
    playFX(var_1, level._id_4B13.origin);
  else
    thread[[var_1]]();

  setDvar(var_0, 0);
  thread _id_63DF(var_0, var_1);
}

_id_37BD(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(_func_3AE() == 1 && self._id_5721 == 1) {
    return;
  }
  if(self getclientomnvar("ui_hub_in_1v1") != 0) {
    return;
  }
  if(level._id_4F50 && isDefined(self._id_9FB4) && self._id_9FB4 < 4) {
    return;
  }
  var_1 = 0;
  self notify("force_cancel_placement");
  self.previousweaponcharmguid = 0;

  if((!_id_04E0::_id_5790(var_1) || self _meth_803D() || self._id_572F) && (!_isonlinegame() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0)) {
    self._id_5721 = 1;
    self setclientomnvar("ui_hub_is_preoccupied", 1);

    if(self._id_56A4) {
      if(isDefined(self._id_155F))
        self._id_155F _id_04E0::_id_1543((0, 0, 80), self);
    }

    _id_04E0::_id_2FA2();
    self _meth_85C8();
    self setclientomnvar("ui_hide_1v1scores", 0);
    self setclientomnvar("ui_hub_in_firingrange", 1);
    self._id_542B = 0;
    var_2 = 0;

    if(isDefined(self._id_3C3D))
      var_2 = self._id_3C3D;

    self._id_3C3D = 0;

    if(isDefined(self._id_572F) && self._id_572F) {
      _id_04CB::_id_A050();
      maps\mp\_utility::_id_05E4();
      maps\mp\_utility::giveperk("specialty_falldamage");
      self takeallweapons();
      maps\mp\_utility::_giveweapon(self._id_8B27);
      thread _id_048A::_id_9BC6();
      self switchtoweaponimmediate(self._id_8B27);

      if(issubstr(self._id_8B27, "shovel")) {
        self setlethalweapon("throwingknife_mp");
        self giveweapon("throwingknife_mp");
      }

      self disableweaponswitch();
      self._id_8B25 = 0;
    } else {
      if(!var_2)
        _id_9A80(1);

      if(isDefined(var_0) && !var_2)
        self._id_294D = maps\mp\gametypes\_class::_id_1E05();

      self freezecontrols(0);
      thread _id_478B(var_2);
      self enableweaponswitch();

      if(_func_367()) {
        thread _id_9824();
        thread targethitsequence();
      }
    }

    thread _id_47A9();

    if(_func_367())
      _id_04E0::_id_7D1D(0);

    if(self._id_572F)
      self allowfire(self getclientomnvar("ui_hub_in_shootout") && self getclientomnvar("ui_hub_shootout_intro_countdown") == 0);
    else
      self allowfire(1);

    self allowprone(1);
    self _meth_85BE(1);
    self _meth_85BF(1);
    self setdemigod(1);
    self setstance("stand");
    self _meth_85B4();
    self lerpfovscale(1.0, 0.0);
  } else if(_id_04E0::_id_5790(var_1) && (!_isonlinegame() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0) && !self._id_5721)
    thread _id_A786();
}

_id_A786() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 0.5;

    if(!_id_04E0::_id_5790()) {
      break;
    }
  }

  _id_37BD();
}

_id_8C70() {
  level endon("game_ended");

  if(!isDefined(level._id_7080)) {
    return;
  }
  level._id_6898 = 0;

  for(;;) {
    level._id_7082 waittill("trigger", var_0);

    if(level._id_6898 >= 10) {
      continue;
    }
    var_1 = spawn("script_model", level._id_7080.origin);
    var_1 setModel("hub_water_basin_enamel_01_white_dirty");
    var_1 setcandamage(1);
    var_1 setdamagecallbackon(1);
    var_1.damagecallback = ::_id_2DD8;
    level._id_6898++;
    var_1 physicslaunchserver(var_1.origin, (4000, 0, 3000));
    var_1 thread _id_2DD0();
  }
}

_id_2F9A() {
  self endon("death");
  self endon("disconnect");
  wait(getdvarfloat("3993", 0.5));
  _id_9A80(0);
}

_id_9A80(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    thread _id_A8FC();
    var_3 = common_scripts\utility::_id_44F5("divisions_bayonet_charge");
    _playfxontagforclients(var_3, self, "j_head", self);
    self _meth_866F(1, 0, 1);
    var_1["intensity"] = 0.3;
    var_1["falloff"] = 1.2;
    var_1["scaleX"] = 1;
    var_1["scaleY"] = 1;
    var_1["squareAspectRatio"] = 0;
    var_1["lerpDuration"] = 0.4;

    if(isDefined(var_1))
      self digitaldistortsetparams(var_1["intensity"], var_1["falloff"], var_1["scaleX"], var_1["scaleY"], var_1["squareAspectRatio"], var_1["lerpDuration"]);
  } else {
    self notify("removeRangeTransitionEffect");
    var_3 = common_scripts\utility::_id_44F5("divisions_bayonet_charge");
    _killfxontagforclient(var_3, self, "j_head", self);

    if(isDefined(level._id_A4B5))
      var_1 = level._id_A4B5;

    if(isDefined(var_1) && !isDefined(var_1["lerpDuration"]))
      var_1["lerpDuration"] = 0.1;

    if(isDefined(var_1))
      self digitaldistortsetparams(var_1["intensity"], var_1["falloff"], var_1["scaleX"], var_1["scaleY"], var_1["squareAspectRatio"], var_1["lerpDuration"]);

    if(isDefined(level._id_6465))
      var_2 = level._id_6465;

    if(isDefined(var_2))
      self _meth_866F(var_2["velocityscaler"], var_2["cameraRotationInfluence"], var_2["cameraTranslationInfluence"]);
    else
      self _meth_866F(0, 0, 0);
  }
}

_id_A8FC() {
  self endon("disconnect");
  self endon("removeRangeTransitionEffect");
  self waittill("death");
  thread _id_9A80(0);
}

_id_38F2(var_0) {
  if(_func_3AE() == 0) {
    if(_id_028D::_id_5855()) {
      self notify("weaponPlantFiringRange");
      waitframe();
    }

    if(isDefined(self._id_5721) && self._id_5721) {
      _id_9A80(1);
      self._id_5721 = 0;
      self setclientomnvar("ui_hub_is_preoccupied", 0);
      self._id_542B = 1;
      self _meth_85C7();
      self setclientomnvar("ui_hide_1v1scores", 1);
      self visionsetnakedforplayer("", 0);
      self._id_294D = maps\mp\gametypes\_class::_id_1E05();
      _id_04E2::_id_A594("custom" + (self._id_294D + 1), 0);
      maps\mp\gametypes\_class::_id_1FA2(common_scripts\utility::_id_46AF());
      _id_04E0::_id_3663();
      self setdemigod(0);

      if(self getstance() == "prone") {
        self allowcrouch(1);
        self setstance("crouch");
      }

      self allowprone(0);
      _id_04E0::_id_7446();
      thread _id_2F9A();

      if(self._id_572F) {
        if(isDefined(self._id_8B24))
          self._id_8B24 thread _id_4B07("win");

        thread _id_4B07("loss", 1, 1);
        self notify("quit_shootout");
      }
    }

    self notify("leftFiringRange");
    self setclientomnvar("ui_hub_in_firingrange", 0);

    if(_func_367())
      _id_04E0::_id_7E4E(0);

    if(_func_367() && isDefined(self._id_1E23) && !self._id_572F) {
      if(self._id_1E23 > 0) {
        _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubTargetsShot"], self._id_1E23, undefined, undefined);
        self._id_1E23 = 0;
      }
    }
  }
}

_id_8A28() {
  level._id_595A = getEntArray("jerry_can_spawn", "targetname");

  if(level._id_595A.size == 0) {
    return;
  }
  foreach(var_1 in level._id_595A)
  _id_9074(var_1.origin);
}

_id_9074(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1.angles = (0, 90, 0);
  var_1 setcandamage(1);
  var_1 setdamagecallbackon(1);
  var_1.damagecallback = ::_id_63A1;
}

_id_8A48() {
  level._id_7AB6 = getEntArray("reactive_swing_target", "targetname");
  level._id_7AB5 = getEntArray("reactive_reset_target", "targetname");
  level._id_7AB3 = getEntArray("flip_target", "targetname");
  level._id_7AB2 = getEntArray("flip_target_reset", "targetname");
  level._id_7AB4 = getEntArray("popup_target", "targetname");
  var_0 = common_scripts\utility::_id_46B5("sequence_area", "targetname");
  level.setmovingplatformtrigger = [];
  level.forcemovingplatformentity = 0;
  level._id_83ED = common_scripts\utility::_id_46B5("sequence_reward_spawn", "targetname");
  var_1 = getEntArray("plate_sequence", "targetname");
  level._id_707E = [];
  level._id_9B6E = [];
  level._id_9B6C = [];
  level._id_9B6C[0] = "blue";
  level._id_7AB1 = getEntArray("reactive_explosive_target", "targetname");
  level._id_6894 = 0;

  foreach(var_3 in level._id_7AB6) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3._id_99F1 = 0;
    var_3.damagecallback = ::_id_63D4;
    var_3._id_4DC9 = 0;
    var_3.angles = (0, 180, 90);

    if(isDefined(var_3._id_0165) && var_3._id_0165 == "tower") {
      var_3._id_8C3A = "blue";
      level._id_9B6E = common_scripts\utility::_id_0F6F(level._id_9B6E, var_3);
      var_3._id_7546 = 3;
    }
  }

  foreach(var_3 in level._id_7AB5) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_63D3;
    var_3._id_4DC9 = 0;
    var_3.health = 99;

    if(isDefined(var_3._id_0165)) {
      if(var_3._id_0165 == "human_no_sequence")
        var_3.angles = (0, 0, 0);
      else
        var_3.angles = (90, 0, 0);
    }

    if(isDefined(var_3._id_0165) && var_3._id_0165 == "tower_right") {
      level._id_9B6C["blue"] = var_3;
      var_3._id_7546 = 5;
      continue;
    }

    if(isDefined(var_3._id_0165) && var_3._id_0165 == "tower_left") {
      level._id_9B6C["orange"] = var_3;
      var_3._id_7546 = 5;
    }
  }

  foreach(var_3 in level._id_7AB2) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_63D1;
    var_3._id_3D77 = [];
    var_8 = _sortbydistance(level._id_7AB3, var_3.origin);

    for(var_9 = 0; var_9 < 3; var_9++)
      var_3._id_3D77[var_9] = var_8[var_9];
  }

  foreach(var_3 in level._id_7AB3) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_63D0;
    var_3._id_4DC9 = 0;
    var_3._id_7584 = "down";
    var_3.angles = (0, 0, 0);
  }

  foreach(var_3 in level._id_7AB4) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_63D2;
    var_3._id_4DC9 = 0;
    var_3.angles = (-90, 0, 0);
    var_3._id_7546 = 2;
  }

  foreach(var_16 in var_1) {
    var_16._id_6C53 = var_16.origin;

    if(int(var_16._id_0165) == 1)
      _id_906D(var_16);
    else
      var_16 movey(250, 0.1);

    if(!isDefined(level._id_707E[int(var_16._id_0165)]))
      level._id_707E[int(var_16._id_0165)] = [];

    level._id_707E[int(var_16._id_0165)] = common_scripts\utility::_id_0F6F(level._id_707E[int(var_16._id_0165)], var_16);
  }

  foreach(var_3 in level._id_7AB1) {
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_638E;
  }

  if(level._id_7AB3.size == 0 || !isDefined(var_0)) {
    return;
  }
  var_8 = _sortbydistance(level._id_7AB3, var_0.origin);

  for(var_9 = 0; var_9 < 6; var_9++)
    level.setmovingplatformtrigger[1][var_9] = var_8[var_9];

  for(var_9 = 9; var_9 < var_8.size; var_9++)
    var_8[var_9]._id_7546 = 4;

  var_8 = _sortbydistance(level._id_7AB6, var_0.origin);

  for(var_9 = 0; var_9 < 5; var_9++) {
    level.setmovingplatformtrigger[2][var_9] = var_8[var_9];
    var_8[var_9]._id_7546 = 2;
  }

  foreach(var_3 in level._id_7AB4)
  level.setmovingplatformtrigger[2] = common_scripts\utility::_id_0F6F(level.setmovingplatformtrigger[2], var_3);

  var_8 = _sortbydistance(level._id_7AB5, var_0.origin);

  for(var_9 = 0; var_9 < 2; var_9++) {
    level.setmovingplatformtrigger[3][var_9] = var_8[var_9];
    level.setmovingplatformtrigger[3][var_9] setcandamage(0);
  }

  var_8[1]._id_7546 = 2;
}

_id_906D(var_0) {
  if(isDefined(var_0)) {
    var_1 = spawn("script_model", var_0.origin - (0, 0, 55));
    var_1 setModel("Hub_range_target_human_01");
    var_1.angles = (0, 0, 0);
    var_1 setcandamage(1);
    var_1 setdamagecallbackon(1);
    var_1.health = 99;
    var_1.damagecallback = ::_id_639A;
    var_1._id_707D = var_0;
    var_0._id_4B11 = var_1;
    var_0._id_4B81 = 1;
    var_1 linkto(var_0);
  }
}

_id_639A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(level._id_4B14))
    level._id_4B14 = 0;

  self.health = self.health - var_2;

  if(self.health > 0) {
    if(isPlayer(var_1)) {
      var_1 _id_04C7::_id_A102("standard_nosound");
      playFX(level._id_AA65, var_6);

      if(isDefined(var_1._id_8B25))
        var_1 thread _id_8B26(self, 1);
    }

    return;
  }

  if(isPlayer(var_1))
    var_1 _id_04C7::_id_A102("killshot_nosound");

  var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
  var_12 = _func_351("mp_hub_allies_frange_wood_shot", undefined, self.origin);
  playFX(level._id_AA66, self.origin);

  if(!isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["plate"], var_1)))
    level.aiphysicstracepassed["plate"][level.aiphysicstracepassed["plate"].size] = var_1;

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self);

  self delete();

  if(!isDefined(self._id_707D)) {
    return;
  }
  self._id_707D._id_4B81 = 0;
  var_13 = 1;

  foreach(var_15 in level._id_707E[int(self._id_707D._id_0165)]) {
    if(var_15._id_4B81) {
      var_13 = 0;
      break;
    }
  }

  if(var_13) {
    foreach(var_15 in level._id_707E[int(self._id_707D._id_0165)])
    var_15 movey(250, 1);

    if(level._id_4B14 == 0)
      level._id_4B14 = gettime() / 1000;

    var_19 = gettime() / 1000 - level._id_4B14;

    if(var_19 > level._id_707E[int(self._id_707D._id_0165)].size * 2.5) {
      var_20 = 1;
      level._id_4B14 = 0;
      level.aiphysicstracepassed["plate"] = [];
    } else if(int(self._id_707D._id_0165) == 4) {
      var_20 = 1;
      level._id_4B14 = 0;
      level._id_707F = 0;
      thread _id_5C2C();
    } else {
      var_20 = int(self._id_707D._id_0165) + 1;
      level._id_4B14 = gettime() / 1000;
    }

    foreach(var_15 in level._id_707E[var_20]) {
      _id_906D(var_15);
      var_15 moveto(var_15._id_6C53, 1);
    }
  }
}

_id_5C2E() {
  var_0 = spawn("script_model", level._id_7081[0]._id_9087.origin + (0, 0, 10));
  var_0 setModel("hub_range_target_clay_01");
  var_0 physicslaunchserver(var_0.origin, level._id_7081[0]._id_7083);
  wait 1.5;
  playFX(level._id_707C, var_0.origin);
  var_0 delete();
}

_id_5C2C(var_0) {
  if(!isDefined(var_0))
    var_0 = 3;

  if(isDefined(level._id_7081) && level._id_7081.size >= var_0)
    _id_5C2B(1);
}

_id_5C2B(var_0) {
  var_1 = common_scripts\utility::array_randomize(level._id_7081);

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = spawn("script_model", var_1[var_2]._id_9087.origin + (0, 0, 10));
    var_3 setModel("hub_range_target_clay_01");
    var_3 setcandamage(1);
    var_3 setdamagecallbackon(1);
    var_3.damagecallback = ::_id_2DD9;
    var_3._id_A985 = var_0;
    var_3 physicslaunchserver(var_3.origin, var_1[var_2]._id_7083);
    var_3 thread _id_2DD0();
  }
}

_id_2DD9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!_func_367()) {
    return;
  }
  if(isPlayer(var_1))
    var_1 _id_04C7::_id_A102("killshot_nosound");

  if(!isDefined(level._id_4B13))
    level._id_4B13 = common_scripts\utility::_id_46B5("fireworks_start", "targetname");

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self, 30);

  if(!isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["plate"], var_1)))
    level.aiphysicstracepassed["plate"][level.aiphysicstracepassed["plate"].size] = var_1;

  if(isDefined(level._id_707C))
    playFX(level._id_707C, self.origin);

  self delete();
  level._id_707F++;

  if(level._id_707F < self._id_A985) {
    return;
  }
  level._id_707F = 0;

  if(self._id_A985 < 3)
    thread _id_5C2B(self._id_A985 + 1);
  else if(_func_3AE() == 0) {
    foreach(var_13 in level.players) {
      if(isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["plate"], var_13))) {
        var_13 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_13 _id_0468::_id_0A20("completedSequence");
        var_13 thread _id_21E4("plate");
        continue;
      }

      var_13 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    thread _id_74A7();
    level.aiphysicstracepassed["plate"] = [];
  }
}

_id_63A1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isPlayer(var_0)) {
    self playSound("mp_hub_jerry_can_explode");

    if(isDefined(level._id_5959))
      playFX(level._id_5959, self.origin);

    self setcandamage(0);
    self setdamagecallbackon(0);
    self physicslaunchclient(self.origin, (0, 0, 200000));
    wait 8;
    thread _id_9074(self.origin);
    self delete();
  }
}

_id_63D4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(gettime() / 1000 < self._id_99F1 + 0.5) {
    return;
  }
  var_12 = _func_351("mp_hub_allies_frange_dist_metal_shot", undefined, self.origin);

  if(isPlayer(var_1)) {
    var_1 _id_04C7::_id_A102("standard_nosound");
    var_1 notify("hitFRTarget");
  }

  self._id_99F1 = gettime() / 1000;
  var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
  var_13 = common_scripts\utility::_id_0F7E(level.setmovingplatformtrigger[2], self);

  if(isDefined(var_13) && self._id_4DC9) {
    return;
  }
  if(self.angles[1] < 90) {
    self rotateto((self.angles[0], 180, self.angles[2]), 0.5);
    self._id_4DC9 = 1;
    self._id_8C3A = "blue";
  } else if(self.angles[1] > 90) {
    self rotateto((self.angles[0], -0.0001, self.angles[2]), 0.5);
    self._id_4DC9 = 0;
    self._id_8C3A = "orange";
  }

  if(level.forcemovingplatformentity && isDefined(var_13))
    _id_21F0(2, var_1);

  if(isDefined(self._id_0165) && self._id_0165 == "tower") {
    var_14 = 1;

    if(level._id_9B6C[0] == "blue") {
      foreach(var_16 in level._id_9B6E) {
        if(var_16._id_8C3A == "blue") {
          var_14 = 0;
          break;
        }
      }

      if(var_14)
        level._id_9B6C[0] = "orange";
    } else {
      foreach(var_16 in level._id_9B6E) {
        if(var_16._id_8C3A == "orange") {
          var_14 = 0;
          break;
        }
      }

      if(var_14)
        level._id_9B6C[0] = "blue";
    }

    if(!isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["tower"], var_1)))
      level.aiphysicstracepassed["tower"][level.aiphysicstracepassed["tower"].size] = var_1;

    if(var_14) {
      level._id_9B6C["orange"] rotateto((0, 0, 0), 0.3);
      level._id_9B6C["orange"] setcandamage(1);
      level._id_9B6C["orange"].health = 99;
      level._id_9B6C["orange"]._id_4DC9 = 0;
      level._id_9B6C["blue"] rotateto((0, 0, 0), 0.3);
      level._id_9B6C["blue"] setcandamage(1);
      level._id_9B6C["blue"].health = 99;
      level._id_9B6C["blue"]._id_4DC9 = 0;
      level._id_9B6F = gettime() / 1000;
      level._id_9B6B = 0;
    }
  }

  if(isPlayer(var_1))
    var_1 notify("hitFRDestroyed", self);

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self);
}

_id_63D3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self.health = self.health - var_2;

  if(self.health > 0) {
    if(isPlayer(var_1)) {
      var_1 _id_04C7::_id_A102("standard_nosound");
      playFX(level._id_AA65, var_6);

      if(isDefined(var_1._id_8B25))
        var_1 thread _id_8B26(self, 1);
    }
  } else {
    if(isPlayer(var_1))
      var_1 _id_04C7::_id_A102("killshot_nosound");

    var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
    var_12 = _func_351("mp_hub_allies_frange_wood_shot", undefined, self.origin);
    self rotateto((90, 0, 0), 0.2);
    self._id_4DC9 = 1;
    self setcandamage(0);

    if(!isDefined(self._id_572E)) {
      if(isDefined(common_scripts\utility::_id_0F7E(level.setmovingplatformtrigger[3], self)))
        self._id_572E = 1;
      else
        self._id_572E = 0;
    }

    if(isPlayer(var_1) && isDefined(var_1._id_8B25))
      var_1 thread _id_8B26(self);

    if(isDefined(self._id_0165)) {
      if(self._id_0165 == "tower_left" || self._id_0165 == "tower_right") {
        level._id_9B6B++;

        if(level._id_9B6B == 2) {
          if(gettime() / 1000 - level._id_9B6F < 5) {
            _id_4AFF();
            return;
          }

          level.aiphysicstracepassed["tower"] = [];
          return;
          return;
        }

        return;
      }

      wait 2;
      self rotateto((0, 0, 0), 0.2);
      self._id_4DC9 = 0;
      self setcandamage(1);
      self.health = 99;
      return;
      return;
    }

    if(self._id_572E) {
      if(level.forcemovingplatformentity)
        _id_21F0(3, var_1);
    }
  }
}

_id_4AFF() {
  level endon("game_ended");

  if(!isDefined(level._id_22FF))
    level._id_22FF = common_scripts\utility::_id_46B5("civ_event_start", "targetname");

  if(!isDefined(level._id_22FD))
    level._id_22FD = common_scripts\utility::_id_46B5("civ_event_end", "targetname");

  if(!isDefined(level._id_22FF) || !isDefined(level._id_22FD)) {
    return;
  }
  level._id_22FE = 0;
  var_0 = randomint(3) + 1;

  switch (var_0) {
    case 1:
      var_1 = (0, -50, -10);
      var_2 = (0, 0, -10);
      var_3 = (0, 50, -10);
      break;
    case 2:
      var_1 = (0, 0, -10);
      var_2 = (0, -50, -10);
      var_3 = (0, 50, -10);
      break;
    case 3:
      var_1 = (0, 50, -10);
      var_2 = (0, -50, -10);
      var_3 = (0, 0, -10);
      break;
    default:
      var_1 = (0, 0, -10);
      var_2 = (0, -50, -10);
      var_3 = (0, 50, -10);
      break;
  }

  var_4 = spawn("script_model", level._id_22FF.origin + var_2);
  var_4.angles = (90, 0, 0);
  var_4 setModel("Hub_range_target_human_01");
  var_4 setcandamage(1);
  var_4 setdamagecallbackon(1);
  var_4._id_4E00 = 1;
  var_4.health = 99;
  var_4.damagecallback = ::_id_636F;
  var_5 = spawn("script_model", level._id_22FF.origin + var_3);
  var_5.angles = (90, 0, 0);
  var_5 setModel("Hub_range_target_human_01");
  var_5 setcandamage(1);
  var_5 setdamagecallbackon(1);
  var_5._id_4E00 = 1;
  var_5.health = 99;
  var_5.damagecallback = ::_id_636F;
  var_6 = spawn("script_model", level._id_22FF.origin + var_1);
  var_6.angles = (90, 0, 0);
  var_6 setModel("hub_range_target_human_03");
  var_6 setcandamage(1);
  var_6 setdamagecallbackon(1);
  var_6._id_4E00 = 0;
  var_6.health = 1;
  var_6.damagecallback = ::_id_636F;
  var_4 thread _id_64D1(level._id_22FD, 3, var_2);
  var_5 thread _id_64D1(level._id_22FD, 3, var_3);
  var_6 thread _id_64D1(level._id_22FD, 3, var_1);
  wait 3.5;

  if(!level._id_22FE && _func_3AE() == 0) {
    foreach(var_8 in level.players) {
      if(isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["tower"], var_8))) {
        var_8 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_8 _id_0468::_id_0A20("completedSequence");
        var_8 thread _id_21E4("tower");
        continue;
      }

      var_8 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    thread _id_74C5();
    level.aiphysicstracepassed["tower"] = [];
  }
}

_id_636F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self.health - var_2;

  if(var_12 > 0) {
    self.health = var_12;

    if(isPlayer(var_1)) {
      var_1 _id_04C7::_id_A102("standard_nosound");
      playFX(level._id_AA65, var_6);

      if(isDefined(var_1._id_8B25))
        var_1 thread _id_8B26(self, 1);
    }

    return;
  }

  if(isPlayer(var_1)) {
    var_1 _id_04C7::_id_A102("killshot_nosound");
    var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
    playFX(level._id_AA66, self.origin);
    var_1 notify("hitFRTarget");
    var_1 notify("hitFRDestroyed", self);
    level.aiphysicstracepassed["tower"][level.aiphysicstracepassed["tower"].size] = var_1;
  }

  if(!self._id_4E00)
    level._id_22FE = 1;

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self);

  self delete();
}

_id_64D1(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  self rotateto((0, self.angles[1], self.angles[2]), 0.5);
  self moveto(var_0.origin + var_2 + (0, 60, -10), var_1);
  wait(var_1);
  self rotateto((90, self.angles[1], self.angles[2]), 0.5);
  wait 0.5;

  if(self._id_4E00)
    level._id_22FE = 1;

  self delete();
}

_id_63D0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _func_351("mp_hub_allies_frange_dist_metal_shot", undefined, self.origin);

  if(isPlayer(var_1)) {
    var_1 _id_04C7::_id_A102("standard_nosound");
    var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
    var_1 notify("hitFRTarget");
    var_1 notify("hitFRDestroyed", self);
  }

  if(isPlayer(var_1) && isDefined(var_1._id_8B25) && self._id_7584 == "down")
    var_1 thread _id_8B26(self);

  var_13 = 0;

  if(self._id_7584 == "down") {
    self setcandamage(0);
    self rotateto((-90, 0, 0), 0.2);
    self._id_4DC9 = 1;
    self._id_7584 = "up";
    var_13 = 1;
  }

  if(!isDefined(self._id_572E)) {
    if(isDefined(common_scripts\utility::_id_0F7E(level.setmovingplatformtrigger[1], self)))
      self._id_572E = 1;
    else
      self._id_572E = 0;
  }

  if(!level.forcemovingplatformentity && self._id_572E) {
    _id_9305();
    self._id_4DC9 = 1;
  }

  if(level.forcemovingplatformentity && isDefined(common_scripts\utility::_id_0F7E(level.setmovingplatformtrigger[1], self)) && var_13)
    _id_21F0(1);
}

_id_63D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _func_351("mp_hub_allies_frange_dist_metal_shot", undefined, self.origin);

  if(isPlayer(var_1))
    var_1 _id_04C7::_id_A102("standard_nosound");

  var_13 = 0;

  foreach(var_15 in self._id_3D77) {
    if(var_15._id_7584 == "up") {
      var_15 setcandamage(1);
      var_15 rotateto((0, 0, 0), 0.2);
      var_15._id_4DC9 = 0;
      var_15._id_7584 = "down";
      var_13++;
    }
  }

  if(var_13 == 3) {
    if(isPlayer(var_1) && isDefined(var_1._id_8B25))
      var_1 thread _id_8B26(self);
  }
}

_id_63D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _func_351("mp_hub_allies_frange_dist_metal_shot", undefined, self.origin);

  if(isPlayer(var_1)) {
    var_1 _id_04C7::_id_A102("standard_nosound");
    var_1 notify("hitFRTarget");
    var_1 thread maps\mp\gametypes\_missions::processchallenge("ch_hq_firingrange");
  }

  if(isPlayer(var_1) && !self._id_4DC9)
    var_1 notify("hitFRDestroyed", self);

  if(isPlayer(var_1) && isDefined(var_1._id_8B25) && !self._id_4DC9)
    var_1 thread _id_8B26(self);

  var_13 = 0;

  if(!self._id_4DC9) {
    self rotateto((-90, 0, 0), 0.2);
    self._id_4DC9 = 1;
    var_13 = 1;
  }

  if(level.forcemovingplatformentity && isDefined(common_scripts\utility::_id_0F7E(level.setmovingplatformtrigger[2], self)) && var_13)
    _id_21F0(2, var_1);
}

_id_638E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_5 == "frag_grenade_mp" || var_5 == "c4_mp" || var_5 == "semtex_mp") {
    var_1 _id_04C7::_id_A102("standard_nosound");

    if(_func_367())
      var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "grenadeBucketHits"], 1, undefined, undefined);

    self playSound("mp_hub_allies_frange_tire_bomb_swtn");

    if(isDefined(level._id_4871))
      playFX(level._id_4871, self.origin);

    var_1 _id_0468::_id_0A20("grenadeTire");
  }

  if(var_5 == "thermite_mp") {
    if(var_4 == "MOD_EXPLOSIVE") {
      var_1 _id_04C7::_id_A102("standard_nosound");

      if(_func_367())
        var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "grenadeBucketHits"], 1, undefined, undefined);

      self playSound("mp_hub_allies_frange_tire_bomb_swtn");

      if(isDefined(level._id_5959))
        playFX(level._id_5959, self.origin);
    }
  }
}

_id_9305() {
  level endon("game_ended");
  level.forcemovingplatformentity = 1;

  foreach(var_1 in level.setmovingplatformtrigger[1])
  var_1._id_4DC9 = 0;
}

_id_63E0() {
  level endon("game_ended");
  level common_scripts\utility::_id_A70A("timeUp", "sequenceComplete");
  level.forcemovingplatformentity = 0;
}

_id_21F0(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    if(!isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["melon"], var_1)))
      level.aiphysicstracepassed["melon"][level.aiphysicstracepassed["melon"].size] = var_1;
  }

  foreach(var_3 in level.setmovingplatformtrigger[var_0]) {
    if(!var_3._id_4DC9)
      return;
  }

  switch (var_0) {
    case 1:
      for(var_5 = 0; var_5 < 5; var_5++) {
        level.setmovingplatformtrigger[2][var_5] rotateto((level.setmovingplatformtrigger[2][var_5].angles[0], -0.0001, level.setmovingplatformtrigger[2][var_5].angles[2]), 0.5);
        level.setmovingplatformtrigger[2][var_5]._id_4DC9 = 0;
      }

      for(var_5 = 5; var_5 < 8; var_5++) {
        level.setmovingplatformtrigger[2][var_5] rotateto((180, 0, 0), 0.2);
        level.setmovingplatformtrigger[2][var_5]._id_4DC9 = 0;
      }

      break;
    case 2:
      foreach(var_3 in level.setmovingplatformtrigger[3]) {
        var_3 rotateto((0, 0, 0), 0.3);
        var_3 setcandamage(1);
        var_3._id_4DC9 = 0;
        var_3.health = 99;
      }

      break;
    case 3:
      var_1 notify("sequenceComplete");
      _id_36E9(var_1);
      break;
  }
}

_id_36E9(var_0) {
  if(_func_3AE() == 1) {
    return;
  }
  thread _id_60FE();

  if(!isDefined(level.melonmodel))
    level.melonmodel = "Hub_range_watermelon_01";

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(level._id_6894 >= 10) {
      break;
    }

    var_2 = spawn("script_model", level._id_83ED.origin);
    var_2 setModel(level.melonmodel);
    var_2 setcandamage(1);
    var_2 setdamagecallbackon(1);
    var_2.damagecallback = ::_id_63B1;
    var_2 physicslaunchserver(var_2.origin, (0, _randomfloat(17500) + 10000, 0));
    level._id_6894++;
  }

  level.forcemovingplatformentity = 0;

  if(_func_367() && isDefined(var_0)) {
    var_0 _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubFRSequencesCompleted"], 1, undefined, undefined);
    var_0 maps\mp\gametypes\_missions::_id_7752("ch_daily_3");

    foreach(var_4 in level.players) {
      if(isDefined(common_scripts\utility::_id_0F7E(level.aiphysicstracepassed["melon"], var_4))) {
        var_4 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_4 _id_0468::_id_0A20("completedSequence");
        var_4 thread _id_21E4("melon");
        continue;
      }

      var_4 iprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    level.aiphysicstracepassed["melon"] = [];
  }
}

_id_60FE() {
  if(level._id_6894 < 10) {
    _id_0380::_id_2889("mp_hub_watermelon_launch", undefined, (1214, 587, 50));
    wait 0.5;
    _id_0380::_id_2889("mp_hub_watermelon_settle", undefined, (1164, 835, 20));
  }
}

_id_63B1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  thread _id_60FD();

  if(isPlayer(var_1))
    var_1 _id_04C7::_id_A102("standard_nosound");

  if(isDefined(level._id_60FF))
    playFX(level._id_60FF, self.origin);

  self setcandamage(0);
  self setdamagecallbackon(0);
  level._id_6894--;

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self, 5);

  self delete();
}

_id_60FD() {
  var_0 = self.origin;
  wait 0.2;
  _id_0380::_id_2889("mp_hub_watermelon_explode", undefined, var_0);
}

_id_21E9(var_0) {
  var_1 = [];

  if(var_0 < 3) {
    for(var_2 = 0; var_2 < 3; var_2++) {
      var_1[var_2] = level._id_7AB7[var_2];

      if(!level._id_7AB7[var_2]._id_4DC9)
        return [];
    }
  } else if(var_0 < 6) {
    for(var_2 = 3; var_2 < 6; var_2++) {
      var_1[var_2] = level._id_7AB7[var_2];

      if(!level._id_7AB7[var_2]._id_4DC9)
        return [];
    }
  } else {
    for(var_2 = 6; var_2 < 9; var_2++) {
      var_1[var_2] = level._id_7AB7[var_2];

      if(!level._id_7AB7[var_2]._id_4DC9)
        return [];
    }
  }

  return var_1;
}

_id_2DD8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(level._id_707C))
    playFX(level._id_707C, self.origin);

  if(isDefined(self._id_0B6D))
    self._id_0B6D delete();

  self delete();
}

_id_2DDB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(level._id_707C))
    playFX(level._id_707C, self.origin);

  if(isPlayer(var_1))
    var_1 _id_04C7::_id_A102("standard_nosound");

  self delete();

  if(!isDefined(self._id_707D)) {
    return;
  }
  self._id_707D._id_4B81 = 0;
  var_12 = 1;

  foreach(var_14 in level._id_707E[int(self._id_707D._id_0165)]) {
    if(var_14._id_4B81) {
      var_12 = 0;
      break;
    }
  }

  if(var_12) {
    foreach(var_14 in level._id_707E[int(self._id_707D._id_0165)])
    var_14 movey(250, 1);

    if(int(self._id_707D._id_0165) == 4) {
      var_18 = 1;

      if(_func_367()) {
        foreach(var_20 in level.players)
        var_20 iprintln(var_1.name, &"HUB_RANGE_SEQUENCE_COMPLETE");

        var_1 maps\mp\gametypes\_missions::_id_7752("ch_daily_3");
      }
    } else
      var_18 = int(self._id_707D._id_0165) + 1;

    foreach(var_14 in level._id_707E[var_18]) {
      _id_906D(var_14);
      var_14 moveto(var_14._id_6C53, 1);
    }
  }

  if(isPlayer(var_1) && isDefined(var_1._id_8B25))
    var_1 thread _id_8B26(self);
}

_id_6378(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1._id_8F10) && var_1._id_8F10 == self)
    return;
}

_id_4AD6(var_0) {
  self endon("upDpadRelease");
  self endon("downDpadRelease");
  level endon("game_ended");

  if(!isDefined(self._id_8F10)) {
    return;
  }
  var_1 = common_scripts\utility::_id_9AAD(common_scripts\utility::_id_7F03(_distance2d(self.origin, self._id_8F10.origin) / 10, 0));

  for(;;) {
    switch (var_0) {
      case "up":
        if(self._id_8F10.origin[0] <= 2850) {
          var_1 = common_scripts\utility::_id_9AAD(common_scripts\utility::_id_7F03(_distance2d(self.origin, self._id_8F10.origin + (50, 0, 0)) / 10, 0));
          self._id_8F10 movex(50, 0.01);
        }

        break;
      case "down":
        if(self._id_8F10.origin[0] >= 1000) {
          var_1 = common_scripts\utility::_id_9AAD(common_scripts\utility::_id_7F03(_distance2d(self.origin, self._id_8F10.origin - (50, 0, 0)) / 10, 0));
          self._id_8F10 movex(-50, 0.01);
        }

        break;
    }

    self._id_8F11 settext("Dist " + var_1);
    wait 0.01;
  }
}

_id_2DD0() {
  self endon("death");
  level endon("game_ended");
  wait 5;

  if(isDefined(self)) {
    if(isDefined(self._id_0B6D))
      self._id_0B6D delete();

    self delete();
  }

  level.aiphysicstracepassed["plate"] = [];
}

_id_21E4(var_0) {
  thread maps\mp\gametypes\_missions::processchallenge("ch_hq_data_sequence_" + var_0);
  var_1 = maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_sequence_melon");
  var_2 = maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_sequence_tower");
  var_3 = maps\mp\gametypes\_hud_util::_id_2097("ch_hq_data_sequence_plate");
  var_4 = var_1 + var_2 + var_3;
  thread maps\mp\gametypes\_missions::processchallenge("ch_hq_sequences", var_4, 1);
}

_id_47A9(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("1v1_ended");

  if(!isDefined(var_0) || var_0)
    thread _id_47AA();

  if(isDefined(var_1) && var_1)
    thread _id_47AB();

  for(;;) {
    var_2 = common_scripts\utility::waittill_any_return("reload", "weapon_change");
    var_3 = self getweaponlistprimaries();

    if(getdvarint("weapon_plant_fire_using_reserve_ammo") == 1 && var_2 == "weapon_change") {
      foreach(var_5 in var_3) {
        if(_id_04CB::_id_574C(var_5)) {
          var_6 = self getweaponammoclip(var_5);
          var_7 = self getweaponammostock(var_5);

          if(var_6 == 0 && var_7 == 0)
            self setweaponammostock(var_5, _weaponstartammo(var_5));
        }
      }

      continue;
    }

    foreach(var_5 in var_3) {
      if(var_5 != "none")
        self setweaponammostock(var_5, _weaponstartammo(var_5) - self getweaponammoclip(var_5));
    }
  }
}

_id_47AA() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");

  for(;;) {
    self waittill("grenade_pullback");
    wait 5;
    var_0 = self getoffhandsecondaryclass();

    if(var_0 != "none")
      self givestartammo(var_0);

    var_1 = self getlethalweapon();

    if(var_1 != "none")
      self givestartammo(var_1);
  }
}

_id_47AB() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");

  for(;;) {
    self waittill("grenade_pullback");
    wait 5;
    var_0 = self getoffhandsecondaryclass();

    if(var_0 != "none")
      self givestartammo(var_0);
  }
}

_id_98C7() {
  if(self getclientomnvar("ui_hub_in_1v1") != 0) {
    return;
  }
  var_0 = undefined;

  foreach(var_2 in level._id_3C3F) {
    var_3 = var_2 _id_04E0::_id_459B(60, 1);

    if(var_3.size == 0) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0))
    var_0 = common_scripts\utility::random(level._id_3C3F);

  self notify("weaponPlantFiringRange");
  waitframe();
  self setstance("stand");
  _id_04E0::_id_8698(var_0.origin);
  self setplayerangles(var_0.angles);
}

_id_21C0() {
  level endon("game_ended");

  if(!self._id_572F)
    thread _id_478B(1);
}

_id_478B(var_0) {
  level endon("game_ended");
  self endon("leftFiringRange");
  self endon("disconnect");

  if(!var_0)
    wait(getdvarfloat("3993", 0.5));

  var_1 = 0;

  if((!_id_04E0::_id_5790(var_1) || self _meth_803D()) && (!_isonlinegame() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0)) {
    _id_9A80(0);
    var_2 = 5;

    if(isDefined(self._id_0079))
      var_2 = self._id_0079;

    self._id_5DEE = undefined;
    _id_04CB::_id_A050();
    self._id_37FC = undefined;
    self._id_69AB = undefined;
    maps\mp\_utility::_id_05E4();
    maps\mp\_utility::giveperk("specialty_falldamage");
    var_3 = self._id_7706;
    var_4 = self.primarypaintjobid;
    var_5 = self.primarycharmguid;
    self._id_7706 = "none";
    self.primarypaintjobid = 0;
    self.primarycharmguid = 0;
    var_6 = self.botgetscriptgoal;
    var_7 = self.secondarypaintjobid;
    var_8 = self.secondarycharmguid;
    self.botgetscriptgoal = "none";
    self.secondarypaintjobid = 0;
    self.secondarycharmguid = 0;
    var_9 = self._id_60FB;
    self._id_60FB = "combatknife_mp";

    if(_func_367())
      _id_04E0::_id_4618();

    for(var_10 = 0; var_10 < 9; var_10++) {
      if(self._id_5DF9[var_10] != 0)
        maps\mp\_utility::_id_47A3(self._id_5DF9[var_10], var_10);
    }

    _id_052D::_id_0F36();

    if(maps\mp\_utility::_hasperk("specialty_randomgun"))
      self._id_7706 = self.curwunderlustgun;

    var_11 = getDvar("4969");
    var_12 = 0;

    if(var_11 != "" || self._id_7706 != var_3 || self.botgetscriptgoal != var_6 || self._id_60FB != var_9 || self.primarypaintjobid != var_4 || self.secondarypaintjobid != var_7 || self.primarycharmguid != var_5 || self.secondarycharmguid != var_8) {
      var_12 = 1;
      self takeallweapons();

      if(var_11 != "") {
        var_13 = getdvarint("4567");
        var_11 = maps\mp\_utility::_id_922B(var_11);
        maps\mp\_utility::_giveweapon(var_11);
        setDvar("4969", "");
        setDvar("4567", 0);

        if(var_13 == 2) {
          if(self._id_7706 != "none")
            maps\mp\_utility::_giveweapon(self._id_7706);

          if(self.botgetscriptgoal != "none")
            maps\mp\_utility::_giveweapon(self.botgetscriptgoal);
        } else if(var_13 == 0) {
          if(self.botgetscriptgoal != "none")
            maps\mp\_utility::_giveweapon(self.botgetscriptgoal);
        } else if(var_13 == 1) {
          if(self._id_7706 != "none")
            maps\mp\_utility::_giveweapon(self._id_7706);
        }

        self switchtoweaponimmediate(var_11);
      } else {
        if(self._id_7706 != "none")
          maps\mp\_utility::_giveweapon(self._id_7706, undefined, self.primarypaintjobid, self.primarycharmguid);

        if(self.botgetscriptgoal != "none")
          maps\mp\_utility::_giveweapon(self.botgetscriptgoal, undefined, self.secondarypaintjobid, self.secondarycharmguid);

        if(self._id_7706 != "none")
          self switchtoweaponimmediate(maps\mp\_utility::_id_922B(self._id_7706));
        else if(self.botgetscriptgoal != "none")
          self switchtoweaponimmediate(maps\mp\_utility::_id_922B(self.botgetscriptgoal));
      }
    }

    if(isDefined(self._id_37FC) && !self._id_572F) {
      if(self._id_37FC != "bouncingbetty_mp" && maps\mp\gametypes\_class::_id_5826(self._id_37FC, 0)) {
        self setlethalweapon(self._id_37FC);
        self giveweapon(self._id_37FC);
      }
    }

    thread _id_048A::_id_9BC6();
    self lerpfovscale(1.0, 0.0);

    if(var_12)
      self waittill("weapon_change");

    self allowmelee(1);

    if(isDefined(self._id_0079) && self._id_7706 != "none")
      thread _id_04CB::setclienttriggeraudiozone(self._id_0079, self._id_7706);

    if(var_0)
      maps\mp\gametypes\_class::_id_1FA2();
  }
}

_id_8B26(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = var_0.origin;
  var_3 = 0;

  if(isDefined(self._id_5C05) && self._id_5C05 == var_0)
    var_3 = 1;
  else if(isDefined(var_0._id_4E00) && !var_0._id_4E00)
    var_3 = 0;
  else if(isDefined(var_1) && _func_30D(var_1))
    var_3 = var_1;
  else {
    self._id_5C05 = var_0;
    var_4 = distance(var_2, level._id_3C40.origin);

    if(var_4 > 2200)
      var_3 = 5;
    else if(var_4 > 1800)
      var_3 = 4;
    else if(var_4 > 1300)
      var_3 = 3;
    else if(var_4 > 800)
      var_3 = 2;
    else
      var_3 = 1;
  }

  self._id_8B25 = self._id_8B25 + var_3;
  self _meth_85EF(&"hub_update_shootout", 3, self._id_8B25, self._id_8B24._id_8B25, var_3);
  self._id_8B24 _meth_85EF(&"hub_update_shootout", 3, self._id_8B24._id_8B25, self._id_8B25, 0);
}

_id_11BD(var_0) {
  var_1 = 0;

  if(_id_04E0::_id_5790(var_1)) {
    return;
  }
  if(var_0 _id_04E0::_id_5790(var_1))
    self iprintln(&"HUB_PLAYER_IS_BUSY", var_0.name);
  else {
    if(isDefined(self._id_8B24)) {
      self iprintln(&"HUB_ALREADY_CH_SHOOTOUT");
      return;
    }

    if(isDefined(var_0._id_8B24)) {
      self iprintln(&"HUB_PLAYER_IS_BUSY", var_0.name);
      return;
    }

    if(getdvarint("spv_hub_firingrange_kswitch", 1) == 1) {
      self iprintln(&"HUB_FIRINGRANGE_UNAVAILABLE");
      return;
    }

    var_2 = _id_778C(var_0);

    if(!isDefined(var_2)) {
      var_2 = 0;
      var_0 setclientomnvar("ui_enterShootout", 0);
      self._id_8B24 = undefined;
      var_0._id_8B24 = undefined;
      self._id_572F = 0;
      var_0._id_572F = 0;
      var_0 _id_04E0::_id_870B(0);
      var_0 freezecontrols(0);
    }

    var_3 = _id_04E0::_id_5790(var_1);
    var_4 = var_0 _id_04E0::_id_5790(var_1);

    if(var_3 || var_4) {
      if(var_3) {
        self iprintln(&"HUB_SHOOTOUT_YOU_BUSY");
        var_0 iprintln(&"HUB_SHOOTOUT_OPPONENT_BUSY");
      } else if(var_4) {
        var_0 iprintln(&"HUB_SHOOTOUT_YOU_BUSY");
        self iprintln(&"HUB_SHOOTOUT_OPPONENT_BUSY");
      }

      self._id_8B24 = undefined;
      var_0._id_8B24 = undefined;
      return;
    }

    if(var_2) {
      self._id_572F = 1;
      var_0._id_572F = 1;
      self._id_7706 = "mp40_mp";
      self _meth_85B4();
      var_0 _meth_85B4();
      _id_04E0::_id_4618();
      self._id_8B27 = _id_04CB::_id_7CCD(self._id_7706);
      var_0._id_8B27 = self._id_8B27;

      if(self._id_5721)
        _id_37BD();

      if(var_0._id_5721)
        var_0 _id_37BD();

      _id_98C7();
      var_0 _id_98C7();
      _id_9306(self, var_0);
      return;
    }

    _id_04DC::_id_8A34(self, "SHOOTOUT_CHALLENGE_INVITE_DECLINED", var_0);
  }
}

checkfordisconnect(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("shootoutTimeLimit");
  self endon("shootoutChoiceMade");
  var_0 common_scripts\utility::_id_A70A("death", "disconnect");
  self freezecontrols(0);
  _id_04E0::_id_870B(0);
}

_id_778C(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("shootoutTimeLimit");
  self endon("death");
  self endon("disconnect");
  self._id_8B24 = var_0;
  var_0._id_8B24 = self;
  var_0 thread checkfordisconnect(self);
  var_0 freezecontrols(1);
  var_0 _id_04E0::_id_870B(1);
  wait 0.5;
  _id_04DC::_id_8A34(var_0, "SHOOTOUT_CHALLENGE", self);
  _id_04DC::_id_8A34(self, "SHOOTOUT_CHALLENGE_INVITE_SENT", var_0);
  var_0 freezecontrols(0);
  var_0 thread _id_04E0::disablefocus(10, "shootoutTimeLimit", ["death", "disconnect", "shootoutChoiceMade"]);

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "enter_shootout") {
      break;
    }
  }

  var_0 notify("shootoutChoiceMade");
  var_0 _id_04E0::_id_870B(0);

  if(var_2 == 1)
    return 1;

  self._id_8B24 = undefined;
  var_0._id_8B24 = undefined;
  return 0;
}

_id_9306(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 endon("disconnect");
  var_0 endon("quit_shootout");
  var_1 endon("quit_shootout");
  var_0 setclientomnvar("ui_hub_shootout_opponent_client_num", var_1 getentitynumber());
  var_1 setclientomnvar("ui_hub_shootout_opponent_client_num", var_0 getentitynumber());
  var_0 setclientomnvar("ui_hub_in_shootout", 1);
  var_1 setclientomnvar("ui_hub_in_shootout", 1);
  var_0 setclientomnvar("ui_hub_shootout_intro_countdown", 5);
  var_1 setclientomnvar("ui_hub_shootout_intro_countdown", 5);
  var_0 _meth_85EF(&"hub_begin_shootout", 0);
  var_1 _meth_85EF(&"hub_begin_shootout", 0);
  var_0 _meth_866C(&"player_interact_notification_end", 0);
  var_0 _meth_866C(&"player_interact_notification_center_end", 0);
  var_0 thread handleshootoutleaveactivity();
  var_1 thread handleshootoutleaveactivity();
  var_0 _id_04E0::_id_7DF8(0, 0, 1, 1, 0);
  var_0 setstance("stand");
  var_1 _id_04E0::_id_7DF8(0, 0, 1, 1, 0);
  var_1 setstance("stand");

  for(var_2 = 4; var_2 > -1; var_2--) {
    wait 1;
    var_0 setclientomnvar("ui_hub_shootout_intro_countdown", var_2);
    var_1 setclientomnvar("ui_hub_shootout_intro_countdown", var_2);
    var_0 _meth_85EF(&"hub_update_shootout_intro", 0);
    var_1 _meth_85EF(&"hub_update_shootout_intro", 0);
  }

  var_0 _id_04E0::_id_A04C();
  var_1 _id_04E0::_id_A04C();
  var_0 allowfire(1);
  var_1 allowfire(1);
  var_3 = 30;
  var_4 = 0;

  for(;;) {
    wait 0.5;
    var_4 = var_4 + 0.5;

    if(!isDefined(var_0._id_8B24) || !isDefined(var_1._id_8B24)) {
      return;
    }
    if(var_4 >= var_3) {
      var_5 = undefined;
      var_6 = undefined;

      if(var_0._id_8B25 > var_1._id_8B25) {
        var_5 = var_0;
        var_6 = var_1;
      } else if(var_1._id_8B25 > var_0._id_8B25) {
        var_5 = var_1;
        var_6 = var_0;
      } else {
        var_0 iprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_TIE", var_1.name);
        var_1 iprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_TIE", var_0.name);
        var_0 thread _id_4B07("tie");
        var_1 thread _id_4B07("tie");
        return;
      }

      var_5 thread _id_4B07("win");
      var_6 thread _id_4B07("loss");

      foreach(var_8 in level.players)
      var_8 iprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_WIN", var_5.name, var_6.name);

      return;
    }
  }
}

_id_300E(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("disconnect");
  var_0 freezecontrols(1);
  var_1 freezecontrols(1);
  var_0 thread _id_04E0::_id_3010("shootoutIntro", &"", "Get more points than your opponent to win", -100, 1.5, 3);
  var_1 thread _id_04E0::_id_3010("shootoutIntro", &"", "Get more points than your opponent to win", -100, 1.5, 3);

  for(var_2 = 5; var_2 > 0; var_2--) {
    var_0 thread _id_04E0::_id_3010("shootoutCountdown" + var_2, &"", var_2 + "...", -70, 1.5, 1);
    var_1 thread _id_04E0::_id_3010("shootoutCountdown" + var_2, &"", var_2 + "...", -70, 1.5, 1);
    wait 1;
  }

  var_0 freezecontrols(0);
  var_1 freezecontrols(0);
}

_id_A179(var_0) {
  var_1 = 180;
  _id_04E0::_id_2835("shootoutTimer", &"", var_0, [0, var_1], 2);
}

_id_282C(var_0) {
  if(!isDefined(var_0) && isDefined(self._id_8B24))
    var_0 = self._id_8B24;

  if(!isDefined(self._id_8B25))
    self._id_8B25 = 0;

  if(!isDefined(var_0._id_8B25))
    var_0._id_8B25 = 0;

  var_1 = 200;
  _id_04E0::_id_2835("playerShootoutScore", &"", self._id_8B25, [-30, var_1], 2);
  _id_04E0::_id_2835("enemyShootoutScore", &"", var_0._id_8B25, [30, var_1], 2);
}

handleshootoutleaveactivity() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_shootout");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "hub_leave_activity") {
      self notify("quit_shootout");

      if(isDefined(self._id_8B24))
        self._id_8B24 thread _id_4B07("win");

      thread _id_4B07("loss", 1);
      return;
    }
  }
}

_id_4B07(var_0, var_1, var_2) {
  self notify("end_shootout");

  if(!self._id_572F) {
    return;
  }
  self._id_572F = 0;

  if(isDefined(var_0)) {
    if(!self._id_8C8F) {
      self _meth_85C7();
      _id_04E0::_id_7446();
      _id_04E0::_id_3663();
      _id_75F3(var_0);
    }

    self._id_8C8F = 0;

    if(isDefined(level._id_2D6D) && (!isDefined(var_1) || !var_1)) {
      if(var_0 == "win") {
        self[[level._id_2D6D]](10);
        _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "numShootoutWins"], 1, undefined, undefined);
        _id_0468::_id_0A26("win", self._id_8B24._id_01D6);
      } else if(var_0 == "loss") {
        self[[level._id_2D6D]](1);
        _id_0468::_id_0A26("lose", self._id_8B24._id_01D6);
      }

      _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "numShootoutChallenges"], 1, undefined, undefined);
      _id_04E0::_id_5E88("fr_shootout", "hq_firing_range_end", 0, ["shootout_guid", "0", "score", self._id_8B25, "winloss", var_0]);
    }
  }

  self setclientomnvar("ui_hub_in_shootout", 0);
  self._id_8B25 = undefined;
  self._id_8B24 = undefined;
  self._id_8B27 = undefined;
  self _meth_85EF(&"hub_end_shootout", 0);

  if((!isDefined(var_2) || !var_2) && self._id_5721)
    _id_37BD();
}

_id_75F3(var_0, var_1) {
  _id_04E0::_id_7DF8(0, 0, 0);
  self setstance("stand");
  wait 1.05;

  if(var_0 == "win") {
    _id_04E0::_id_721A("mp_emote_clap_jump", 1);
    wait 3.46667;
  } else {
    _id_04E0::_id_721A("mp_emote_noway", 1);
    wait 5.36667;
  }

  _id_04E0::_id_A04C();
}

_id_9824() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self._id_1E23 = 0;

  for(;;) {
    self waittill("hitFRTarget");
    self._id_1E23++;
    thread _id_04E0::disablefocus(10, "clearCachedTargets", ["hitFRTarget"]);
    thread _id_A79B();
  }
}

_id_A79B() {
  self endon("hitFRTarget");
  self endon("leftFiringRange");
  self waittill("clearCachedTargets");
  _id_04E0::_id_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubTargetsShot"], self._id_1E23, undefined, undefined);
  self._id_1E23 = 0;
}

_id_74A7() {
  if(_func_3AE() == 1) {
    return;
  }
  _activateclientexploder(1);
  _id_0380::_id_2889("mp_hub_flare_distant", undefined, (3016, 946, 50));
  wait 1.5;
  _activateclientexploder(2);
  _id_0380::_id_2889("mp_hub_flare_medium", undefined, (2572, 921, 50));
  wait 1.5;
  _activateclientexploder(3);
  _id_0380::_id_2889("mp_hub_flare_close", undefined, (1364, 983, 50));
}

_id_74C5() {
  if(_func_3AE() == 1) {
    return;
  }
  for(var_0 = 0; var_0 < 3; var_0++) {
    _id_0380::_id_2889("mp_hub_range_explode_0" + var_0, undefined, (3396, 992, 300));
    _activateclientexploder(4);
    wait 0.25;
    _activateclientexploder(6);
    wait 0.25;
    _activateclientexploder(5);
    _id_0380::_id_2889("mp_hub_range_tail_0" + var_0, undefined, (3396, 992, 300));
    wait 0.25;
  }
}

targethitsequence() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("target_sequence_complete");
  self.sequencetargetshit = 0;
  self.lastsequencetargethittime = 0;

  for(;;) {
    self waittill("hitFRDestroyed", var_0);

    if(isDefined(self.lastsequencetargethit) && self.lastsequencetargethit != var_0 || gettime() > self.lastsequencetargethittime + 500) {
      self.lastsequencetargethit = var_0;
      self.lastsequencetargethittime = gettime();
      self.sequencetargetshit++;
      thread checksequencetimer(10, 10);
    }
  }
}

checksequencetimer(var_0, var_1) {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("target_sequence_complete");

  if(self.sequencetargetshit >= var_1) {
    _id_0468::_id_0A20("targetHit");
    self.sequencetargetshit = 0;
    self notify("target_sequence_complete");
  }

  wait(var_0);
  self.sequencetargetshit--;
}