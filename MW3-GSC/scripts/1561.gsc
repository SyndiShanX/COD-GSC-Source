/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1561.gsc
**************************************/

_id_3D06() {
  level._effect["chopper_boss_light_smoke"] = loadfx("smoke/smoke_trail_white_heli");
  level._effect["chopper_boss_heavy_smoke"] = loadfx("smoke/smoke_trail_black_heli");
}

_id_3D07(var_0, var_1) {
  level._id_3D08 = common_scripts\utility::getstructarray(var_1, var_0);

  foreach(var_3 in level._id_3D08) {
    var_3.neighbors = var_3 maps\_utility::_id_2051();

    foreach(var_5 in level._id_3D08) {
      if(var_3 == var_5) {
        continue;
      }
      if(!maps\_utility::_id_0AD1(var_3.neighbors, var_5) && maps\_utility::_id_0AD1(var_5 maps\_utility::_id_2051(), var_3)) {
        var_3.neighbors[var_3.neighbors.size] = var_5;
      }
    }
  }
}

_id_3D09(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = strtok(var_1, " ");

    foreach(var_4 in var_2) {}
    self endon(var_4);
  }

  var_6 = strtok(var_0, " ");

  switch (var_6.size) {
    case 1:
      self waittill(var_6[0]);
      break;
    case 2:
      common_scripts\utility::waittill_either(var_6[0], var_6[1]);
      break;
    case 3:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2]);
      break;
    case 4:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2], var_6[3]);
      break;
    default:
      break;
  }

  self._id_3D0A._id_3D0B = undefined;
}

_id_3D0C(var_0) {
  self endon("death");
  self endon("deathspin");
  level endon("special_op_terminated");
  self._id_3D0A = var_0;
  self._id_3D0A._id_3D0B = 1;
  _id_3D10();
  thread _id_3D12();
  thread _id_3D11();
  var_1 = 0;

  for(;;) {
    self._id_3D0D = undefined;
    var_2 = isDefined(self._id_3D0E) && self._id_3D0E || var_1;

    while(isDefined(level._id_3D0F) && level._id_3D0F == 1) {
      wait 0.05;
    }
    var_3 = _id_3D1E(var_2);

    if(isDefined(var_3) && self._id_3D0A != var_3) {
      if(isDefined(self._id_3D0D)) {
        self setlookatent(self._id_3D0D);
      } else {
        var_4 = maps\_utility::_id_0AE9(self.origin, level.players);

        if(isDefined(var_4)) {
          self setlookatent(var_4);
        }
      }

      self._id_3D0E = undefined;
      thread _id_3D21(var_3);
      self waittill("reached_dynamic_path_end");
    }

    if(isDefined(self._id_3D0D)) {
      var_1 = _id_3D18(self._id_3D0D);
    }
    wait 0.1;
  }
}

_id_3D10() {
  maps\_vehicle::_id_2A3D();
  _id_3D22();
  maps\_utility::_id_2837();
  self.mgturret[1] unlink();
  self.mgturret[1] delete();
  var_0 = self.mgturret[0];
  var_0 unlink();
  var_0 linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_0 setleftarc(45);
  var_0 setrightarc(45);
  var_0 settoparc(45);
  var_0 setbottomarc(55);
  var_0 setdefaultdroppitch(-10);
  self.mgturret = [];
  self.mgturret[self.mgturret.size] = var_0;
}

_id_3D11() {
  self waittill("death", var_0);

  if(!isDefined(self)) {
    return;
  }
  if(maps\_utility::_id_12DC()) {
    playFX(level._effect["money"], self.origin + (0, 0, -32));
  }
}

_id_3D12() {
  self endon("death");
  self endon("deathspin");
  var_0 = self.health - self._id_163B;
  var_1 = 0;

  for(;;) {
    var_2 = self.health - self._id_163B;

    if(var_2 <= var_0 * 0.5) {
      if(var_1 == 1) {
        var_1 = 2;
        self._id_3D0E = 1;
      }

      playFXOnTag(common_scripts\utility::getfx("chopper_boss_heavy_smoke"), self, "tag_engine");
    } else if(var_2 <= var_0 * 0.75) {
      if(var_1 == 0) {
        var_1 = 1;
        self._id_3D0E = 1;
      }

      playFXOnTag(common_scripts\utility::getfx("chopper_boss_light_smoke"), self, "tag_engine");
    }

    wait 0.05;
  }
}

_id_3D14(var_0, var_1) {
  var_2 = self.mgturret[0].origin[2] - self.origin[2];
  return bullettracepassed(var_0 + (0, 0, var_2), var_1, 0, self);
}

_id_3D15(var_0) {
  var_1 = distance2d(self.origin, var_0);
  var_2 = 384;

  if(isDefined(level._id_3D16)) {
    var_2 = level._id_3D16;
  }
  return var_1 >= var_2 && var_1 <= 3072;
}

_id_3D17(var_0) {
  if(isDefined(var_0)) {
    self._id_3D0D = var_0;
  }
}

_id_3D18(var_0) {
  self endon("deathspin");
  self endon("death");
  var_1 = 0;

  if(isDefined(var_0) && !isDefined(var_0._id_3D19) && _id_3D15(var_0.origin)) {
    thread _id_3D1A(self._id_3D0D);
    self setlookatent(var_0);
    var_2 = _id_3D1B(var_0, 5.0);

    if(isDefined(var_0)) {
      if(isDefined(var_2) && var_2) {
        _id_3D1C(var_0);
        var_1 = 1;
      }
    }

    self notify("chopper_done_shooting");
  }

  return var_1;
}

_id_3D1A(var_0) {
  var_0._id_3D19 = 1;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_shooting");

  if(isDefined(var_0)) {
    var_0._id_3D19 = undefined;
  }
}

_id_3D1B(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  var_0 endon("death");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = gettime() + var_1 * 1000;
  }
  while(isDefined(var_0)) {
    if(maps\_utility::_id_26AB(self.origin, self.angles, var_0.origin, 0.0)) {
      return 1;
    }
    if(isDefined(var_2) && gettime() >= var_2) {
      return 0;
    }
    wait 0.25;
  }
}

_id_3D1C(var_0) {
  self endon("deathspin");
  self endon("death");
  var_0 endon("death");
  var_1 = 20;

  foreach(var_3 in self.mgturret) {
    if(isai(var_0)) {
      var_3 settargetentity(var_0, var_0 getEye() - var_0.origin);
    } else if(isPlayer(var_0)) {
      if(maps\_utility::_id_1A43(var_0)) {
        var_1 = 60;
        var_3 settargetentity(var_0);
      } else {
        var_3 settargetentity(var_0, var_0 getEye() - var_0.origin);
      }
    } else {
      var_3 settargetentity(var_0, (0, 0, 32));
    }
    var_3 startbarrelspin();
  }

  wait 2.0;
  var_5 = weaponfiretime("minigun_littlebird_spinnup");
  var_6 = 0;

  for(var_7 = 0; var_7 < var_1; var_7++) {
    self.mgturret[var_6] shootturret();
    var_6++;

    if(var_6 >= self.mgturret.size) {
      var_6 = 0;
    }
    wait(var_5 + 0.05);
  }

  wait 1.0;

  foreach(var_3 in self.mgturret) {}
  var_3 stopbarrelspin();
}

_id_3D1D() {
  level._id_3D0F = 1;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_targeting");
  level._id_3D0F = undefined;
}

_id_3D1E(var_0) {
  self endon("death");
  var_1 = self._id_3D0A.neighbors;

  if(!isDefined(var_0) || var_0 == 0) {
    var_1[var_1.size] = self._id_3D0A;
  }
  thread _id_3D1D();
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!maps\_utility::_id_1A43(var_4) && (!isDefined(var_4.ignoreme) || var_4.ignoreme == 0)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = getaiarray("allies");

  foreach(var_8 in var_6) {
    if(!isDefined(var_8.ignoreme) || var_8.ignoreme == 0) {
      var_2[var_2.size] = var_8;
    }
  }

  if(isDefined(level._id_3C67)) {
    foreach(var_11 in level._id_3C67) {
      if(!isDefined(var_11.ignoreme) || var_11.ignoreme == 0) {
        var_2[var_2.size] = var_11;
      }
    }
  }

  if(!var_2.size) {
    foreach(var_4 in level.players) {
      if(!maps\_utility::_id_1A75(var_4) && (!isDefined(var_4.ignoreme) || var_4.ignoreme == 0)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  var_15 = [];
  var_16 = 0;

  foreach(var_18 in var_1) {
    if(var_18 != self._id_3D0A && isDefined(var_18._id_3D0B)) {
      continue;
    }
    var_18._id_3D0D = undefined;
    var_18._id_3D1F = undefined;
    var_19 = undefined;

    foreach(var_21 in var_2) {
      if(!isDefined(var_21)) {
        continue;
      }
      if(var_18 _id_3D15(var_21.origin) == 0) {
        continue;
      }
      var_22 = var_21.origin + (0, 0, 64);

      if(isai(var_21) || isPlayer(var_21)) {
        var_22 = var_21 getEye();
      }
      if(_id_3D14(var_18.origin, var_22)) {
        if(!isDefined(var_18._id_3D0D)) {
          var_15[var_15.size] = var_18;
          var_18._id_3D0D = var_21;
          var_19 = distance2d(var_18.origin, var_21.origin);
        } else {
          var_23 = distance2d(var_18.origin, var_21.origin);

          if(var_23 < var_19) {
            var_18._id_3D0D = var_21;
            var_19 = var_23;
          }
        }
      }

      var_16++;

      if(var_16 >= 4) {
        wait 0.05;
        var_16 = 0;
      }
    }
  }

  if(var_15.size) {
    var_26 = [];

    foreach(var_18 in var_15) {
      if(isDefined(var_18._id_3D0D)) {
        var_26[var_26.size] = var_18;
      }
    }

    var_15 = var_26;
  }

  if(!var_15.size) {
    foreach(var_18 in var_1) {
      if(var_18 != self._id_3D0A && isDefined(var_18._id_3D0B)) {
        continue;
      }
      var_30 = undefined;

      foreach(var_21 in var_2) {
        if(!isDefined(var_21)) {
          continue;
        }
        if(!isDefined(var_30)) {
          var_30 = var_21;
          var_18._id_3D1F = distance2d(var_18.origin, var_21.origin);
          continue;
        }

        var_32 = distance2d(var_18.origin, var_21.origin);

        if(var_32 < var_18._id_3D1F) {
          var_30 = var_21;
          var_18._id_3D1F = var_32;
        }
      }

      if(isDefined(var_18._id_3D1F)) {
        var_15[var_15.size] = var_18;
      }
    }
  } else {
    foreach(var_18 in var_15) {}
    var_18._id_3D1F = distance2d(var_18._id_3D0D.origin, var_18.origin);
  }

  var_37 = _id_060F::_id_3B69(var_15, ::_id_3D20);
  var_38 = undefined;
  var_39 = 0;

  foreach(var_18 in var_37) {
    var_41 = 384;

    if(isDefined(level._id_3D16)) {
      var_41 = level._id_3D16;
    }
    if(var_18._id_3D1F >= var_41 && var_18._id_3D1F <= 3072) {
      var_38 = var_18;
      var_39 = 1;
      break;
    }
  }

  if(!isDefined(var_38) && var_37.size) {
    var_38 = var_37[0];
  }
  if(isDefined(var_38) && isDefined(var_38._id_3D0D)) {
    _id_3D17(var_38._id_3D0D);
  }
  self notify("chopper_done_targeting");

  if(isDefined(var_38) && var_38 != self._id_3D0A) {
    return var_38;
  } else {
    return undefined;
  }
}

_id_3D20() {
  return self._id_3D1F;
}

_id_3D21(var_0) {
  self._id_3D0A._id_3D0B = undefined;
  self._id_3D0A = var_0;
  self._id_3D0A._id_3D0B = 1;
  thread maps\_vehicle::_id_26A1(var_0);
}

_id_3D22() {
  self makeentitysentient("axis", 1);
  self.attackeraccuracy = 6;
  self.maxvisibledist = 3072;
  self.threatbias = 10000;
}