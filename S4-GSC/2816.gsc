/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2816.gsc
*************************************************/

main() {
  _id_D864();

  if(self._id_4CEE == "guard_dog") {
    _id_D879();
    thread _id_10BC2();
    thread _id_10A86();
    thread _id_10AD9();
  } else if(self._id_4CEE == "attack_dog")
    _id_D84A();

  thread _id_F108();
  thread _id_10BC3();
  thread _id_10BC6();
  thread _id_107F7();
  thread _id_10819();
}

_id_D864() {
  self._id_2596 = 0;
  self._id_ADAB = 20736;
  self._id_9D97 = 16384;
  self._id_1DF5 = 25 + self._id_0359;
  self._id_1DF7 = 202500;
  self._id_109F4 = 302500;
  self._id_109FB = 96.0;
  self._id_1DFC = 54;
  self._id_1DFD = -64;
  self._id_AD9F = 2250000;
  self._id_4CC7 = 2250000;
  self._id_8CC9 = 1000000;
  self._id_BB8D = 60;
  self._id_9F2E = 50;
  self._id_5E7A = 0;
  self._id_022A = 1;
  self._id_015B = "walk";
  self._id_A246 = 1.0;
  self._id_5775 = 1.0;
  self._id_5253 = 1;
  self._id_1DFA = "idle";
  self._id_A262 = "idle";
  self._id_24F3 = 0;
  self._id_F220 = 0;
  self._id_91D7 = 0;
  self._id_003F = 1;
  self._id_0201 = 24;
  self._id_0281 = 1;
  self._id_2429 = 1;
  self.perks = [];
  self._id_AFF8 = [];
  self.spawndangerzone = undefined;
}

_id_D879() {
  self._id_1DF7 = 261121;
  self._id_1439 = 501264;
  self._id_109F4 = 819025;
  self._id_BDC2 = 20736;
  self._id_9F2F = self._id_0359;
  self._id_1350 = "escort";
  self._id_BDC3 = undefined;
  self._id_BDC1 = undefined;
  self._id_5E7C = 0;
  self._id_0229 = 1;
  _id_0015::_id_D132(250);
  scripts\mp\utility\perk::_id_6FC2("specialty_melee_resist_finisher");
}

_id_D84A() {
  self._id_1350 = "attack";
  self._id_5E7C = 0;
}

init() {
  self._id_189F = spawnStruct();
  self._id_189F._id_AAC4 = [];
  self._id_189F._id_AAC4["idle"] = _id_0AFD::main;
  self._id_189F._id_AAC4["move"] = _id_0AFF::main;
  self._id_189F._id_AAC4["traverse"] = _id_0B01::main;
  self._id_189F._id_AAC4["melee"] = _id_0AFE::main;
  self._id_189F._id_AADC = [];
  self._id_189F._id_AADC["idle"] = _id_0AFD::_id_0191;
  self._id_189F._id_AADC["move"] = _id_0AFF::_id_0191;
  self._id_189F._id_AADC["melee"] = _id_0AFE::_id_0191;
  self._id_189F._id_AADC["traverse"] = _id_0B01::_id_0191;
  self._id_10A93 = ::_id_10A92;
  self._id_13E7 = "idle";
  self._id_0359 = 15;
  self.height = 40;
}

_id_AAC5(var_0, var_1) {
  self notify("killanimscript");

  if(!isDefined(self._id_189F._id_AAC4[var_1])) {
    return;
  }
  if(var_0 == var_1 && var_1 != "traverse") {
    return;
  }
  if(isDefined(self._id_189F._id_AADC[var_0])) {
    self[[self._id_189F._id_AADC[var_0]]]();
  }

  _id_5771(self._id_13E7);
  self._id_13E7 = var_1;
  _id_54CC(var_1);
  self[[self._id_189F._id_AAC4[var_1]]]();
}

_id_F108() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner)) {
    self endon("owner_disconnect");
    thread _id_485E(self.owner);
  }

  self thread[[self._id_10A93]]();
  thread _id_A10F();
  createspawndangerzone();

  for(;;) {
    if(self._id_0281) {
      var_0 = getdvarint("#x319955e851d38876", 0) == 1;
      var_1 = self _meth_841A(var_0);
      _id_08F1::setdoortoopen(var_1);
    }

    switch (self._id_13E7) {
      case "idle":
        _id_FC8B();
        break;
      case "move":
        _id_FCCA();
        break;
      case "melee":
        _id_FCC5();
        break;
    }

    wait 0.05;
  }
}

_id_4978(var_0) {
  if(isDefined(self._id_012F) && var_0 != self._id_012F) {
    return 0;
  }

  if(!isDefined(self._id_9031) || !isDefined(self._id_9030)) {
    return 0;
  }

  if(distance2dsquared(var_0.origin, self._id_9031) > 4) {
    return 0;
  }

  if(self._id_2542) {
    return 1;
  }

  if(distancesquared(self.origin, self._id_9030) > 4096 && gettime() - self._id_9032 > 2000) {
    return 0;
  }

  return 1;
}

_id_4977() {
  if(isDefined(self._id_9012) && isDefined(self._id_9011) && distance2dsquared(self._id_012F.origin, self._id_9012) < 4 && distancesquared(self.origin, self._id_9011) < 2500) {
    return 1;
  }

  if(_id_109D1(0)) {
    return 1;
  }

  return 0;
}

_id_54CC(var_0) {
  _id_5771(self._id_13E7);
  self._id_13E7 = var_0;

  switch (var_0) {
    case "idle":
      self._id_A262 = "idle";
      self._id_24F3 = 0;
      break;
    case "move":
      self._id_A262 = "follow";
      break;
    case "melee":
      break;
    default:
      break;
  }
}

_id_5771(var_0) {
  switch (var_0) {
    case "move":
      self._id_ADAA = undefined;
      break;
    default:
      break;
  }
}

createspawndangerzone() {
  var_0 = getdvarint("#x3413f9e72e067ca20", 0) == 1;

  if(!var_0) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self.spawndangerzone = _id_0817::_id_1135(self.origin, 100, 100, self.owner.team, undefined, self.owner, 0, self, 1, 1);

  if(isDefined(self.spawndangerzone)) {
    _id_0817::influencepoint_linktoent(self.spawndangerzone, self);
  }
}

_id_FC8B() {
  _id_FCCD();
}

_id_FCCA() {
  _id_FCCD();
}

_id_FCC5() {
  self _meth_8326(self.origin);
}

_id_FCCD() {
  if(self._id_2596) {
    return;
  }
  self._id_BC4F = self._id_A262;
  var_0 = undefined;
  var_1 = 0;
  var_2 = 0;
  var_3 = 500;

  if(self._id_24F3 && gettime() - self._id_8F96 < var_3) {
    self._id_A262 = "follow";
    var_1 = 1;
  } else
    self._id_A262 = _id_6B6A();

  if(self._id_A262 == "pursuit") {
    self._id_0229 = 0;
    var_0 = _id_06E0::_id_68E7(self._id_0192);
    var_4 = 0;

    if(isDefined(self._id_8F96) && gettime() - self._id_8F96 < 1000) {
      if(distance2dsquared(var_0, self._id_8F94) < 16) {
        var_4 = 1;
      } else if(isDefined(self._id_8F95) && self._id_8F95 == "pursuit" && distance2dsquared(self._id_8F97, self._id_0192.origin) < 16) {
        var_4 = 1;
      }
    }

    if(var_4) {
      self._id_A262 = "follow";
      var_2 = 1;
    } else if(_id_109D1(1)) {
      self._id_A262 = "follow";
      var_2 = 1;
    } else if(_id_4978(self._id_0192)) {
      self._id_A262 = "follow";
      var_2 = 1;
    }
  }

  _id_D643(var_2);

  if(self._id_A262 == "follow") {
    if(self.owner.sessionstate == "spectator") {
      return;
    }
    if(gettime() - self._id_F220 < 500) {
      var_1 = 1;
    }

    if(self._id_1350 == "escort" || self._id_1350 == "attack") {
      var_5 = self.owner getstance();

      if(!isDefined(self.owner._id_BC63) && isDefined(self.owner)) {
        self.owner._id_BC63 = var_5;
      }

      var_6 = !isDefined(self._id_ADAA) || distance2dsquared(self._id_ADAA, self.owner.origin) > 20736;

      if(var_6) {
        self._id_ADAA = self.owner.origin;
      }

      var_7 = distance2dsquared(self.origin, self.owner.origin);
      var_8 = var_7 < self._id_ADAB;

      if(var_1 || !var_8 || var_6 || self._id_BC4F != "idle" && self._id_BC4F != self._id_A262) {
        self _meth_8326(_id_5B03());
        self.owner._id_BC63 = var_5;
      }
    } else if(self._id_1350 == "protect") {
      var_9 = !isDefined(self._id_BDC3) && isDefined(self._id_BDC1) || distance2dsquared(self._id_BDC3, self._id_BDC1) > 2500;

      if(var_9) {
        self._id_BDC3 = self._id_BDC1;
      }

      var_10 = distance2dsquared(self.origin, self._id_BDC1);

      if(var_1 || var_10 > self._id_BDC2 || var_9 || self._id_BC4F != "idle" && self._id_BC4F != self._id_A262) {
        self _meth_8326(self._id_BDC1);
      }
    }

    self._id_012F = undefined;
    self._id_015B = _id_6A51(self._id_015B);
    self._id_2297 = 1;
  } else if(self._id_A262 == "pursuit") {
    self._id_012F = self._id_0192;
    self._id_015B = "sprint";
    self._id_2297 = 0;
  }

  _id_D510(self._id_015B);
}

_id_6B6A(var_0) {
  if(isDefined(self._id_0192)) {
    if(isDefined(self._id_01BD) && self._id_0192 == self._id_01BD) {
      return "pursuit";
    }

    if(abs(self.origin[2] - self._id_0192.origin[2]) < self._id_109FB && distance2dsquared(self._id_0192.origin, self.origin) < self._id_1DF7) {
      return "pursuit";
    }

    if(isDefined(self._id_012F) && self._id_012F == self._id_0192) {
      if(distance2dsquared(self._id_012F.origin, self.origin) < self._id_8CC9) {
        return "pursuit";
      }
    }
  }

  return "follow";
}

_id_D643(var_0) {
  if(var_0) {
    if(!isDefined(self._id_9031)) {
      self._id_9031 = self._id_0192.origin;
      self._id_9030 = self.origin;
      var_1 = _id_06E0::_id_5056(self._id_0192.origin);
      self._id_2542 = !isDefined(var_1);
      self._id_9032 = gettime();
    }
  } else {
    self._id_9031 = undefined;
    self._id_9030 = undefined;
    self._id_2542 = undefined;
    self._id_9032 = undefined;
  }
}

_id_107F7() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path", var_0);
    self._id_24F3 = 1;
    self._id_8F96 = gettime();
    self._id_8F94 = var_0;
    self._id_8F95 = self._id_A262;

    if(self._id_A262 == "follow" && isDefined(self.owner)) {
      self._id_8F97 = self.owner.origin;
      continue;
    }

    if(self._id_A262 == "pursuit" && isDefined(self._id_0192)) {
      self._id_8F97 = self._id_0192.origin;
    }
  }
}

_id_10819() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("path_set");
    self._id_24F3 = 0;
  }
}

_id_6A52(var_0) {
  return var_0;
}

_id_6A51(var_0) {
  if(!isDefined(var_0)) {
    return "walk";
  }

  var_1 = self _meth_87E3();
  var_2 = distancesquared(var_1, self.origin);

  switch (var_0) {
    case "sprint":
      return scripts\engine\utility::ter_op(var_2 < 160000, "run", "sprint");
    case "run":
      if(var_2 < 40000) {
        return "trot";
      } else if(var_2 > 160000) {
        return "sprint";
      } else {
        return "run";
      }
    case "trot":
      if(var_2 < 2500) {
        return "walk";
      } else if(var_2 > 40000) {
        return "sprint";
      } else {
        return "trot";
      }
    case "walk":
      return scripts\engine\utility::ter_op(var_2 > 2500, "trot", "walk");
    default:
      return "walk";
  }

  return var_0;
}

_id_D510(var_0) {
  if(istrue(self._id_91D7)) {
    return;
  }
  var_1 = self _meth_8644();
  var_2 = var_1;
  var_3 = distancesquared(self _meth_87E3(), self.origin);

  switch (var_0) {
    case "sprint":
      if(self._id_A262 == "pursuit" || var_3 > 250000) {
        var_2 = 300;
      } else {
        var_4 = (var_3 - 160000) / 90000;
        var_2 = scripts\engine\math::_id_91A9(241, 300, var_4);
      }

      break;
    case "run":
      var_4 = (var_3 - 40000) / 120000;
      var_2 = scripts\engine\math::_id_91A9(107, 240, var_4);
      break;
    case "trot":
      var_4 = (var_3 - 2500) / 37500;
      var_2 = scripts\engine\math::_id_91A9(56, 106, var_4);
      break;
    case "walk":
      var_4 = var_3 / 2500;
      var_2 = scripts\engine\math::_id_91A9(0, 55, var_4);
      break;
    default:
      break;
  }

  var_2 = clamp(var_2, 0, 300);
  thread _id_91D4(var_1, var_2);
}

_id_91D4(var_0, var_1) {
  self._id_91D7 = 1;
  var_2 = 0;

  while(var_2 <= 0.5) {
    var_2 = var_2 + 0.05;
    var_3 = scripts\engine\math::_id_91A9(var_0, var_1, min(1, var_2 / 0.5));
    self _meth_85E2(var_3);
    wait 0.05;
  }

  self._id_91D7 = 0;
  return;
}

isvalidtargetfordog(var_0) {
  return isPlayer(var_0) || isagent(var_0);
}

_id_10AD9() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = 0;

    if(isDefined(self._id_01BD)) {
      var_0 = distancesquared(self.owner.origin, self._id_01BD.origin) < self._id_AD9F || distancesquared(self.origin, self._id_01BD.origin) < self._id_4CC7;
    } else {
      foreach(var_2 in level.characters) {
        if(!isvalidtargetfordog(var_2)) {
          continue;
        }
        var_3 = isalive(var_2);
        var_4 = var_2 == self.owner;
        var_5 = var_2.team == self.team;
        var_6 = var_2 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget");

        if(!var_3 || var_4 || var_5 || var_6) {
          waitframe();
          continue;
        }

        var_7 = distancesquared(self.origin, var_2.origin);

        if(var_7 < self._id_1DF7) {
          self._id_5E7C = 0;
          var_0 = 1;
        } else if(var_7 < self._id_1439) {
          self._id_5E7C = _id_109CB();
          var_0 = 1;
        } else if(var_7 < self._id_109F4) {
          self._id_5E7C = 0;
          var_0 = 1;
        }

        if(var_0) {
          self._id_0229 = 0;
          break;
        }
      }
    }

    if(!var_0) {
      self._id_5E7C = 0;
      self._id_0229 = 1;
    }

    wait 0.05;
  }
}

_id_8B17(var_0) {
  var_1 = var_0[2] - self.origin[2];
  return var_1 <= self._id_1DFC && var_1 >= self._id_1DFD;
}

_id_109D1(var_0) {
  if(!isDefined(self._id_012F)) {
    return 0;
  }

  return !_id_8B17(self._id_012F.origin) && distance2dsquared(self.origin, self._id_012F.origin) < self._id_9D97 * 0.75 * 0.75 && (!var_0 || self _meth_8006(self._id_012F));
}

_id_C0AF() {
  if(!isDefined(self._id_012F)) {
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(self._id_012F)) {
    return 0;
  }

  if(self._id_13E7 == "traverse") {
    return 0;
  }

  if(distance2dsquared(self.origin, self._id_012F.origin) > self._id_9D97) {
    return 0;
  }

  if(!_id_8B17(self._id_012F.origin)) {
    return 0;
  }

  return 1;
}

_id_109CD() {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(istrue(self._id_5E7C)) {
    return 0;
  }

  if(abs(self.origin[2] - self._id_0192.origin[2]) <= self._id_109FB || self _meth_8006(self._id_0192)) {
    var_0 = distance2dsquared(self.origin, self._id_0192.origin);

    if(var_0 < self._id_109F4) {
      return 1;
    }
  }

  return 0;
}

_id_109CB() {
  var_0 = distancesquared(self _meth_87E3(), self.origin) < 576;
  var_1 = self._id_1350 == "escort";
  var_2 = distancesquared(self.owner.origin, self.origin) > 160000;
  var_3 = var_1 && var_2;

  if(var_0 && !var_3) {
    self._id_222B = undefined;
    return 1;
  }

  return 0;
}

_id_4094(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

_id_5B03() {
  var_0 = self.origin;
  var_1 = self.owner.origin;
  var_2 = distance2dsquared(var_0, var_1);
  var_3 = var_2 < self._id_ADAB;
  var_4 = length(self.owner getvelocity());
  var_5 = vectornormalize(self.origin - self.owner.origin);

  if(var_3) {
    return self _meth_87E3();
  } else {
    if(istrue(self._id_5E7C) && _id_109CB()) {
      return self _meth_87E3();
    }

    if(var_4 > 100) {
      var_6 = var_1 + var_5 * 25;
      return var_6;
    }
  }

  var_7 = _func_0080(self.owner.origin);

  if(!isDefined(var_7)) {
    self notify("displayPathErrorMessageOwner");
    return self.origin;
  }

  var_8 = _func_00A6(var_7);
  var_9 = 5;
  var_10 = 15;
  var_11 = -15;
  var_12 = gettime() - self._id_F220 < 5000;
  var_13 = 0;
  var_14 = undefined;
  var_15 = anglesToForward(self.owner.angles);
  var_15 = (var_15[0], var_15[1], 0);
  var_15 = vectornormalize(var_15);
  var_8[var_8.size] = var_7;

  foreach(var_17 in var_8) {
    var_18 = 0;
    var_19 = var_17.origin - self.owner.origin;
    var_20 = length(var_19);

    if(var_20 >= self._id_BB8D) {
      var_18 = var_18 + var_9;
    } else if(var_20 < self._id_9F2E) {
      var_21 = 1 - (self._id_9F2E - var_20) / self._id_9F2E;
      var_18 = var_18 + var_9 * var_21 * var_21;
    } else
      var_18 = var_18 + var_9 * var_20 / self._id_BB8D;

    if(var_20 == 0) {
      var_20 = 1;
    }

    var_19 = var_19 / var_20;
    var_22 = _id_4094(var_19, var_15);
    var_23 = _id_4094(var_5, var_15);

    if(var_22 * var_23 > 0) {
      var_18 = var_18 + var_10;
    }

    if(var_12) {
      var_24 = vectordot(self._id_42F4, var_19);
      var_18 = var_18 + var_24 * var_11;
    }

    if(var_18 > var_13) {
      var_13 = var_18;
      var_14 = var_17;
    }
  }

  if(!isDefined(var_14)) {
    return self.origin;
  }

  var_26 = var_14.origin - self.owner.origin;
  var_27 = length(var_26);

  if(var_27 > self._id_BB8D) {
    var_28 = var_7.origin - self.owner.origin;

    if(vectordot(var_28, var_26 / var_27) < 0) {
      var_6 = var_14.origin;
    } else {
      var_29 = vectornormalize(var_14.origin - var_7.origin);
      var_6 = var_7.origin + var_29 * self._id_BB8D;
    }
  } else
    var_6 = var_14.origin;

  var_6 = _id_06E0::_id_5056(var_6);

  if(!isDefined(var_6)) {
    return self.origin;
  }

  if(self._id_24F3 && distance2dsquared(var_6, self._id_8F94) < 4) {
    return self.origin;
  }

  return var_6;
}

_id_485E(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_2("disconnect", "joined_team");
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self notify("killanimscript");

  if(isDefined(self._id_189F._id_AADC[self._id_13E7])) {
    self[[self._id_189F._id_AADC[self._id_13E7]]]();
  }

  self suicide();
}

_id_10A92() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(self._id_13E7 == "melee") {
      if(self._id_1DFA != "melee") {
        self._id_1DFA = "melee";
        _id_D6D3(undefined);
      }
    } else if(self._id_A262 == "pursuit") {
      if(self._id_1DFA != "attacking") {
        self._id_1DFA = "attacking";
        _id_D6D3("bark", "attacking");
      }
    } else if(self._id_1DFA != "warning") {
      if(istrue(self._id_5E7C)) {
        self._id_1DFA = "warning";
        _id_D6D3("bark", "warning");
      } else if(_id_109CD()) {
        self._id_1DFA = "warning";
        _id_D6D3("growl", "warning");
      } else {
        self._id_1DFA = self._id_13E7;
        _id_D6D3("pant");
      }
    } else if(istrue(self._id_5E7C)) {
      if(!isDefined(self._id_222B)) {
        _id_D6D3("bark", self._id_1DFA);
      }
    } else if(!_id_109CD()) {
      self._id_1DFA = self._id_13E7;
      _id_D6D3("pant");
    }

    wait 0.05;
  }
}

_id_D6D3(var_0, var_1) {
  if(!isDefined(var_0)) {
    self._id_E06A = undefined;
    self notify("end_dog_sound");
    return;
  }

  if(!isDefined(self._id_E06A) || self._id_E06A != var_0) {
    self notify("end_dog_sound");
    self._id_E06A = var_0;

    if(var_0 == "bark") {
      thread _id_B366(var_1);
    } else if(var_0 == "growl") {
      thread _id_B84B(var_1);
    } else if(var_0 == "pant") {
      thread _id_B8B5();
    } else {}
  }
}

_id_B366(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(!isDefined(self._id_222B)) {
    self._id_222B = 1;
    thread _id_10A97(var_0);
  }
}

_id_10A97(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(var_0 == "warning") {
    wait 3;
  } else {
    wait(randomintrange(4, 8));
  }

  _id_C604();
}

_id_C604() {
  self._id_222B = undefined;
  _id_D6D3(undefined);
}

_id_B84B(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self._id_8FE3) && gettime() - self._id_8FE3 < 3000) {
    wait 3;
  }

  for(;;) {
    self._id_8FE3 = gettime();
    wait(randomintrange(3, 5));
  }
}

_id_B8B5(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_dog_sound");

  if(isDefined(self._id_9025) && gettime() - self._id_9025 < 3000) {
    wait 3;
  }

  for(;;) {
    self._id_9025 = gettime();

    if(self._id_015B == "run" || self._id_015B == "sprint") {
      wait(randomintrange(3, 5));
      continue;
    }

    wait(randomintrange(4, 6));
  }
}

_id_10A87() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    var_0 = self.owner;
  } else {
    var_0 = level.players[0];
  }

  if(isai(var_0)) {
    return;
  }
  var_1 = &"KILLSTREAKS_HINTS/GUARD_DOG_PROTECT";

  if(self._id_1350 == "protect") {
    var_1 = &"KILLSTREAKS_HINTS/GUARD_DOG_RETURN";
  }

  self._id_FE90 = spawn("script_model", self.origin);
  self._id_FE90 setModel("tag_origin");
  self._id_FE90 scripts\mp\utility\killstreak::_id_D5D2(var_0, var_1, 360, 360, 30000, 30000, 2);
  self._id_FE90 linkto(self);
  self._id_FE90 waittill("trigger", var_0);
  self._id_FE90 disableplayeruse(var_0);
  self._id_FE90 delete();
  return 1;
}

_id_10A86() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = _id_10A87();

    if(isDefined(var_0) && var_0) {
      if(!isDefined(self._id_1350)) {
        self._id_1350 = "escort";
        _id_3972();
      } else if(self._id_1350 == "escort") {
        _id_D68A();

        if(self._id_BDC1 == self.origin) {
          _id_3972();
        } else {
          self._id_1350 = "protect";
          level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_protect");
        }
      } else {
        self._id_1350 = "escort";
        _id_3972();
        self _meth_8326(_id_5B03());
        level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_escort");
      }

      self._id_5E7C = 0;
    }
  }
}

_id_10BC2() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("damage", var_0, var_1);

    if(isvalidtargetfordog(var_1) && var_1 != self.owner) {
      if(self._id_1DFA == "attacking") {
        continue;
      }
      if(distancesquared(self.owner.origin, self.origin) > self._id_AD9F) {
        continue;
      }
      if(distancesquared(self.owner.origin, var_1.origin) > self._id_AD9F) {
        continue;
      }
      if(!isDefined(self._id_01BD)) {
        _id_D55D(var_1);
      }
    }
  }
}

_id_10BC3() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("death");

    switch (level.gametype) {
      case "sd":
        _id_09EF::_id_8D71();
        return;
      case "sr":
        var_0 = level scripts\engine\utility::_id_10897("sr_player_eliminated", "sr_player_respawned");

        if(isDefined(var_0) && var_0 == "sr_player_eliminated") {
          _id_09EF::_id_8D71();
        }

        return;
    }

    if(self._id_4CEE == "guard_dog" && isDefined(self.owner._id_026E) && isalive(self.owner._id_026E) && isvalidtargetfordog(self.owner._id_026E)) {
      _id_D55D(self.owner._id_026E);
    }
  }
}

_id_10BC6() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    var_0 = self.owner scripts\engine\utility::_id_1089F("joined_team", "joined_spectators");

    if(isDefined(var_0) && (var_0 == "joined_team" || var_0 == "joined_spectators")) {
      _id_09EF::_id_8D71();
    }
  }
}

_id_10AE6() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self._id_01BD scripts\engine\utility::_id_108A7(10, "death_or_disconnect");
  self._id_01BD = undefined;
  self._id_0229 = 1;
  self._id_5E7A = 0;
}

_id_AA9A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self._id_F220 = gettime();

  if(isDefined(self.owner)) {
    self._id_42F4 = vectornormalize(self.origin - self.owner.origin);
  }
}

_id_DBA5(var_0, var_1, var_2) {
  if(isDefined(var_1) && weaponclass(var_1) == "sniper") {
    return 1;
  }

  if(isDefined(var_2) && _func_010F(var_2) && var_0 >= 10) {
    return 1;
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    return 1;
  }

  return 0;
}

_id_A10F() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self.owner) {
      continue;
    }
    switch (self._id_13E7) {
      case "idle":
        _id_0AFD::_id_AAF0();
        break;
      case "move":
        _id_0AFF::_id_AAF0();
        break;
    }
  }
}

_id_D55D(var_0) {
  self._id_01BD = var_0;
  self._id_5E7A = 1;
  self._id_5E7C = 0;
  self._id_0229 = 0;
  thread _id_10AE6();
}

_id_D68A() {
  if(isDefined(self.owner) && isPlayer(self.owner)) {
    var_0 = self.owner;
  } else {
    var_0 = level.players[0];
  }

  if(isai(var_0)) {
    return;
  }
  if(isDefined(self._id_AD50)) {
    self._id_BDC1 = self._id_AD50;
    self._id_AD50 = undefined;
    self notify("enddebugdrawprotectpos");
  } else {
    var_1 = var_0 getplayerangles();
    var_2 = var_0 getEye();
    var_3 = anglesToForward(var_1);
    var_4 = var_2 + var_3 * 2048;
    var_5 = self _meth_8008(var_2, var_4, 1, 2, 1, 1);

    if(var_5["fraction"] < 1) {
      var_6 = var_5["normal"];
      var_7 = var_5["position"];

      if(var_6[2] > 0.707) {
        var_8 = _id_06E0::_id_5056(var_7);

        if(isDefined(var_8)) {
          var_9 = _func_0080(var_8);

          if(isDefined(var_9)) {
            self._id_BDC1 = var_8;
            var_7 = var_8;
            return;
          }

          self notify("displayPathErrorMessageTarget");
          self._id_BDC1 = self.origin;
          return;
          return;
        }

        self notify("displayPathErrorMessageTarget");
        self._id_BDC1 = self.origin;
        return;
        return;
      }

      self notify("displayPathErrorMessageTarget");
      self._id_BDC1 = self.origin;
      return;
      return;
    }

    self._id_BDC1 = self.origin;
    self notify("enddebugdrawprotectpos");
  }
}

_id_3972() {
  self._id_BDC3 = undefined;
  self._id_BDC1 = undefined;
}