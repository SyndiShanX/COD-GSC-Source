/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\alien_goon\alien_jump.gsc
*************************************************/

setjumpattackanimstates(var_0, var_1) {
  var_1._id_A7C6 = "attack_leap_swipe";
  var_1._id_A7C4 = scripts\anim\notetracks_mp::getrandomanimentry("attack_leap_swipe");
}

choosejumpattackarrival(var_0, var_1) {
  var_2 = 0.707;

  if(isDefined(self.curmeleetarget) && isalive(self.curmeleetarget)) {
    var_3 = vectorNormalize(self.curmeleetarget.origin - var_0._id_A843);
    var_4 = anglesToForward(var_0._id_630B);
    var_5 = vectordot(var_3, var_4);

    if(var_5 > var_2) {
      return;
    }
    var_6 = anglestoright(var_0._id_630B);
    var_7 = vectordot(var_3, var_6);

    if(var_7 > var_2) {
      var_1._id_A7C6 = "attack_leap_swipe_right";
      var_1._id_A7C4 = scripts\anim\notetracks_mp::getrandomanimentry("attack_leap_swipe_right");
    } else if(var_7 < var_2 * -1) {
      var_1._id_A7C6 = "attack_leap_swipe_left";
      var_1._id_A7C4 = scripts\anim\notetracks_mp::getrandomanimentry("attack_leap_swipe_left");
    }
  }
}

jumpattack(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_71CD = ::setjumpattackanimstates;
  var_3._id_71BB = ::choosejumpattackarrival;
  self._id_B59D = 1;
  _id_A4C3(var_0, var_1, self.origin, self.angles, var_2, self.curmeleetarget.angles, undefined, var_3);
  self._id_B59D = 0;
}

_id_A4C3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self _meth_827F();
  _id_A4E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  _id_A4DA(var_9, var_5);
}

_id_A4DA(var_0, var_1) {
  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1.0, 1.0);
  }

  self _meth_8288(var_0);
  self scragentsetphysicsmode("gravity");
  self.oriented = 0;
  self.ignoreme = 0;
}

_id_A4E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  self._id_11B2F = 0;
  var_9 = spawnStruct();
  var_10 = _id_7F2B(var_2, var_3, var_4, var_5, var_6);
  _id_7F28(var_10, var_9);

  if(isDefined(var_7) && isDefined(var_7._id_71CD)) {
    self[[var_7._id_71CD]](var_10, var_9);
  }

  var_11 = _id_7F2F(var_2, var_3, var_4);
  self scragentsetphysicsmode("noclip");
  self orientmode("face angle abs", var_11);
  var_12 = 0;
  var_13 = self getanimentry(var_9._id_AAA5, var_9._id_AAA4);
  var_14 = self getanimentry(var_9._id_A7C6, var_9._id_A7C4);
  var_15 = getnotetracktimes(var_14, "finish");

  if(var_15.size > 0) {
    var_16 = var_15[0] * getanimlength(var_14);
  } else {
    var_16 = getanimlength(var_14);
  }

  var_17 = var_16 / var_9._id_CEE4;
  var_18 = floor(var_17 * 20.0);
  var_19 = var_18 / 20.0 / var_17;
  var_20 = getnotetracktimes(var_14, "stop_teleport");

  if(var_20.size > 0) {
    var_21 = var_20[0] * var_17;
    var_22 = ceil(var_21 * 20.0);
    var_23 = var_22 / 20.0 / var_17;
    var_24 = getmovedelta(var_14, var_23, var_19);
  } else {
    var_21 = 0.8 * var_17;
    var_22 = ceil(var_21 * 20.0);
    var_23 = var_22 / 20.0 / var_17;
    var_24 = getmovedelta(var_14, var_23, var_19);
  }

  var_5 = _id_7F29(var_2, var_4, var_5);
  var_25 = rotatevector(var_24, var_5);
  var_26 = var_4 - var_25;
  self _meth_8281("anim deltas");
  self playsoundonmovingent(_id_7A62());

  if(animhasnotetrack(var_13, "start_teleport")) {
    scripts\anim\notetracks_mp::_id_CED2(var_9._id_AAA5, var_9._id_AAA4, var_9._id_CEE4, "jump_launch", "start_teleport");
  } else {
    scripts\anim\notetracks_mp::_id_CED1(var_9._id_AAA5, var_9._id_AAA4, var_9._id_CE9E, 0.5 * getanimlength(var_13) / var_9._id_CEE4);
  }

  var_27 = gettime();
  var_12 = self _meth_827D(self.origin, var_26, var_10._id_A4EB);
  self._id_11B2F = 1;
  self notify("jump_launching");
  var_28 = self _meth_827F();
  thread _id_A4E9(var_10, var_5, var_28, var_12);
  scripts\anim\notetracks_mp::_id_1384C("jump_launch", "end");
  var_29 = (gettime() - var_27) / 1000;

  if(scripts\engine\utility::is_true(self.bteleporting)) {
    if(level.totalphantomsjumping < level.totalphantomsallowedtojump) {
      level.totalphantomsjumping++;
      thread play_teleport_start();
      self.bteleporting = 0;
    } else
      self.bteleporting = 0;
  }

  var_30 = var_12 - var_29 - var_21;

  if(var_30 > 0) {
    scripts\anim\notetracks_mp::_id_CED1(var_9._id_93B3, var_9._id_93B2, var_9._id_CEE4, var_30);
  }

  if(isDefined(var_7) && isDefined(var_7._id_71BB)) {
    self[[var_7._id_71BB]](var_10, var_9);
  }

  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self setanimstate(var_9._id_A7C6, var_9._id_A7C4, 0.2);
  } else {
    self setanimstate(var_9._id_A7C6, var_9._id_A7C4, var_9._id_CEE4);
  }

  var_31 = scripts\asm\asm::_id_2341(var_0, var_1);
  thread handlejumpnotetracks("jump_land", "end", var_9._id_A7C6, var_9._id_A7C4, var_31);
  self waittill("traverse_complete");
  self._id_11B2F = 0;

  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1.0, 0.0);
  }

  self _meth_8288(20.2832);
  self _meth_8281("anim deltas");
  self orientmode("face angle abs", var_5);
  scripts\anim\notetracks_mp::_id_1384C("jump_land", "end");

  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self scragentsetanimscale(0.2, 0.2);
  } else {
    self scragentsetanimscale(1.0, 1.0);
  }

  self setOrigin(var_4, 0);
}

play_teleport_start() {
  self setscriptablepartstate("teleport_fx", "teleport_start");
  scripts\engine\utility::waitframe();
  self setethereal(1);
}

handlejumpnotetracks(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_2 + "_finished");
  scripts\anim\notetracks_mp::_id_1384C(var_0, var_1, var_2, var_3, var_4);
}

_id_A4E9(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = (0, 0, 1);
  var_5 = 0.85;
  var_6 = scripts\cp\utility::is_normal_upright(var_0._id_10E05);
  var_7 = scripts\cp\utility::is_normal_upright(var_0._id_6397);

  if(var_6 && !var_7) {
    var_8 = 0.5;
    var_9 = 1.0;
  } else if(!var_6 && var_7) {
    var_8 = 0.0;
    var_9 = 0.5;
  } else {
    var_8 = 0.0;
    var_9 = 1.0;
  }

  var_10 = var_9 - var_8;

  if(var_8 > 0) {
    wait(var_3 * var_8);
  }

  var_11 = 1.0;

  if(distancesquared(self.angles, var_1) > var_11) {
    var_12 = anglesdelta(self.angles, var_1);
    var_13 = var_12 / (var_3 * var_10);
    var_13 = var_13 * 3.14159 / 180.0;
    var_13 = var_13 / 20;
    self _meth_8288(var_13);
  }

  self orientmode("face angle abs", var_1);
}

_id_7F2B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_6 = var_2 - var_0;
  var_7 = var_6 * (1, 1, 0);
  var_7 = vectorNormalize(var_7);
  var_5._id_AAB4 = var_0 + var_7 * level._id_1BBA._id_A4E6;
  var_5._id_A843 = var_2;
  var_5._id_A4F8 = var_5._id_A843 - var_5._id_AAB4;
  var_5._id_A4F7 = var_5._id_A4F8 * (1, 1, 0);
  var_5._id_A4DC = length(var_5._id_A4F7);
  var_5._id_A4DB = var_5._id_A4F7 / var_5._id_A4DC;

  if(isDefined(var_4)) {
    var_5._id_A844 = var_4 - var_2;
  } else if(isDefined(self.curmeleetarget)) {
    var_5._id_A844 = self.curmeleetarget.origin - var_2;
  } else {
    var_5._id_A844 = anglesToForward(self.angles);
  }

  var_5._id_10D6D = _id_7F27(var_5._id_A4F8, anglestoup(var_1));
  var_5._id_630B = _id_7F27(var_5._id_A4F8, anglestoup(var_3));
  var_5._id_10E05 = anglestoup(var_5._id_10D6D);
  var_5._id_6397 = anglestoup(var_5._id_630B);
  _id_7F30(var_5);
  return var_5;
}

_id_DA68(var_0, var_1) {
  var_2 = vectordot(var_0, var_1);
  var_3 = var_0 - var_1 * var_2;
  return var_3;
}

_id_7F27(var_0, var_1) {
  var_2 = _id_DA68(var_0, var_1);
  var_3 = vectorcross(var_2, var_1);
  var_4 = axistoangles(var_2, var_3, var_1);
  return var_4;
}

_id_7F30(var_0) {
  var_1 = var_0._id_A4DC;
  var_2 = var_0._id_A4F8[2];
  var_3 = !scripts\cp\utility::is_normal_upright(var_0._id_6397);
  var_4 = _id_7F2A(var_3);
  var_5 = 1.01;
  var_6 = trajectorycalculateminimumvelocity(var_0._id_AAB4, var_0._id_A843, var_4);
  var_7 = _id_7F2E(var_3);
  var_8 = var_6 * var_5 * var_7;
  var_9 = trajectorycalculateexitangle(var_8, var_4, var_1, var_2);
  var_10 = cos(var_9);
  var_0._id_A4ED = var_0._id_A4DC / (var_8 * var_10);
  var_11 = var_4 * (0, 0, -1);
  var_0.launchvelocity2d = trajectorycalculateinitialvelocity(var_0._id_AAB4, var_0._id_A843, var_11, var_0._id_A4ED);
  var_0.launchvelocity = var_0.launchvelocity2d * (1, 1, 0);
  var_0._id_A4EB = length(var_0.launchvelocity);
}

_id_7F2E(var_0) {
  if(isDefined(self._id_B59D) && self._id_B59D) {
    return level._id_1B74;
  } else if(var_0) {
    return getdvarfloat("agent_jumpWallSpeed");
  } else {
    return getdvarfloat("agent_jumpSpeed");
  }
}

_id_7F2A(var_0) {
  if(isDefined(self._id_B59D) && self._id_B59D) {
    return level._id_1B73;
  } else if(var_0) {
    return getdvarfloat("agent_jumpWallGravity");
  } else {
    return getdvarfloat("agent_jumpGravity");
  }
}

_id_7F2D(var_0, var_1) {
  var_2 = self getanimentry(var_1._id_AAA5, var_1._id_AAA4);
  var_3 = self getanimentry(var_1._id_93B3, var_1._id_93B2);
  var_4 = self getanimentry(var_1._id_A7C6, var_1._id_A7C4);
  var_5 = getanimlength(var_2);
  var_6 = var_5 * 0.5;
  var_7 = getnotetracktimes(var_2, "start_teleport");

  if(isDefined(var_7) && var_7.size > 0) {
    var_6 = var_5 - var_7[0] * var_5;
  }

  var_8 = getanimlength(var_4);
  var_9 = var_8 * 0.5;
  var_10 = getnotetracktimes(var_4, "stop_teleport");

  if(isDefined(var_10) && var_10.size > 0) {
    var_9 = var_10[0] * var_8;
  }

  var_11 = getanimlength(var_3);
  var_12 = ceil(var_0._id_A4ED * 20.0);
  var_13 = var_12 / 20.0;
  var_14 = var_11 + var_6 + var_9;
  var_15 = var_14 / var_13;
  var_16 = var_11 / var_15 + 0.1;
  var_17 = var_11 / var_16;
  return var_17;
}

_id_7F28(var_0, var_1) {
  var_1._id_AAA5 = _id_7F64(var_0);
  var_1._id_AAA4 = _id_7F63(var_0, var_1._id_AAA5);
  var_1._id_A7C6 = getlaserstartpoint(var_0);
  var_1._id_A7C4 = getlaserdirection(var_0, var_1._id_A7C6);
  var_1._id_93B3 = _id_7F17(var_0, var_1._id_AAA5, var_1._id_A7C6);
  var_1._id_93B2 = _id_7F16(var_0, var_1._id_AAA5, var_1._id_A7C6);
  var_1._id_CEE4 = _id_7F2D(var_0, var_1);
}

_id_7F2F(var_0, var_1, var_2) {
  var_3 = anglestoup(var_1);
  var_4 = vectorNormalize(var_2 - var_0);

  if(vectordot(var_3, var_4) > 0.98) {
    var_4 = (0, 0, 1);
  }

  var_5 = vectorcross(var_3, var_4);
  var_4 = vectorcross(var_5, var_3);
  return axistoangles(var_4, -1 * var_5, var_3);
}

_id_7F64(var_0) {
  var_1 = 20;
  var_2 = cos(90 - var_1);
  var_3 = vectorNormalize(var_0._id_A4F8);
  var_4 = vectordot(var_3, var_0._id_10E05);

  if(abs(var_4) <= var_2) {
    return "jump_launch_level";
  } else if(var_4 > 0) {
    return "jump_launch_up";
  } else if(var_4 < 0) {
    return "jump_launch_down";
  }
}

_id_7F63(var_0, var_1) {
  var_2 = vectorNormalize(var_0.launchvelocity2d);
  var_2 = rotatevector(var_2, var_0._id_10D6D);
  var_3 = self getanimentrycount(var_1);
  var_4 = 0;
  var_5 = vectordot(level._id_1BBA._id_A4E5[var_1][var_4], var_2);

  for(var_6 = 1; var_6 < var_3; var_6++) {
    var_7 = vectordot(level._id_1BBA._id_A4E5[var_1][var_6], var_2);

    if(var_7 > var_5) {
      var_4 = var_6;
      var_5 = var_7;
    }
  }

  return var_4;
}

_id_7F17(var_0, var_1, var_2) {
  return "jump_in_air";
}

_id_7F16(var_0, var_1, var_2) {
  return level._id_1BBA._id_93B2[var_1][var_2];
}

_id_7F29(var_0, var_1, var_2) {
  var_3 = anglestoup(var_2);
  var_4 = vectorNormalize(var_1 - var_0);

  if(vectordot(var_3, var_4) > 0.98) {
    var_4 = (0, 0, 1);
  }

  var_5 = vectorcross(var_3, var_4);
  var_4 = vectorcross(var_5, var_3);
  return axistoangles(var_4, -1 * var_5, var_3);
}

getlaserstartpoint(var_0) {
  var_1 = length(var_0._id_A4F8);
  var_2 = 0.342;

  if(!scripts\cp\utility::is_normal_upright(var_0._id_6397)) {
    var_3 = (0, 0, 1);
    var_4 = vectordot(var_0._id_A4F8, var_3) / var_1;

    if(var_4 > var_2) {
      return "jump_land_sidewall_low";
    } else {
      return "jump_land_sidewall_high";
    }
  }

  var_4 = vectordot(var_0._id_A4F8, var_0._id_6397) / var_1;

  if(var_4 > var_2) {
    return "jump_land_down";
  } else if(var_4 < var_2 * -1) {
    return "jump_land_up";
  } else {
    return "jump_land_level";
  }
}

getlaserdirection(var_0, var_1) {
  var_2 = _id_DA68(var_0._id_A4F8, var_0._id_6397);
  var_3 = _id_DA68(var_0._id_A844, var_0._id_6397);
  var_4 = var_2 - var_3;
  var_5 = vectorcross(var_3, var_0._id_6397);
  var_6 = vectorNormalize(_id_DA68(var_5, var_0._id_6397)) * 100;
  var_7 = vectordot(var_2 * -1, var_6);
  var_8 = length(var_2);
  var_9 = length(var_3);
  var_10 = length(var_4);
  var_11 = 0.001;

  if(var_8 < var_11 || var_9 < var_11) {
    return 1;
  }

  var_12 = (var_8 * var_8 + var_9 * var_9 - var_10 * var_10) / (2 * var_8 * var_9);

  if(var_12 <= -1) {
    return 6;
  } else if(var_12 >= 1) {
    return 1;
  } else {
    var_13 = acos(var_12);

    if(var_7 > 0) {
      if(0 <= var_13 && var_13 < 22.5) {
        return 1;
      } else if(22.5 <= var_13 && var_13 < 67.5) {
        return 2;
      } else if(67.5 <= var_13 && var_13 < 112.5) {
        return 4;
      } else if(112.5 <= var_13 && var_13 < 157.5) {
        return 7;
      } else {
        return 6;
      }
    } else if(0 <= var_13 && var_13 < 22.5)
      return 1;
    else if(22.5 <= var_13 && var_13 < 67.5) {
      return 0;
    } else if(67.5 <= var_13 && var_13 < 112.5) {
      return 3;
    } else if(112.5 <= var_13 && var_13 < 157.5) {
      return 5;
    } else {
      return 6;
    }
  }
}

_id_A4EA(var_0, var_1) {}

_id_D4A2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("killanimscript");
  self endon("jump_finished");

  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self setanimstate(var_0, var_1, 0.2);
  } else {
    self setanimstate(var_0, var_1, 1.0);
  }

  var_4 = scripts\engine\utility::waittill_any_return("jump_pain", "traverse_complete");

  if(var_4 == "traverse_complete") {
    return;
  }
  var_5 = var_2 - gettime() * 0.001;

  if(var_5 > 0) {
    var_6 = 2.0;
    var_7 = _id_7F2C(var_3);
    var_8 = self getanimentry(var_7, var_1);
    var_9 = getanimlength(var_8);
    var_10 = min(var_6, var_9 / var_5);

    if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
      self setanimstate(var_7, var_1, 0.2);
    } else {
      self setanimstate(var_7, var_1, var_10);
    }
  }

  self waittill("traverse_complete");
}

_id_7F2C(var_0) {
  return "jump_pain_idle_" + var_0;
}

_id_7F11(var_0) {
  return "jump_impact_pain_" + var_0;
}

_id_7A62() {
  return "alien_jump";
}