/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3172.gsc
**************************************/

_id_9D87(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee) && isDefined(self.melee._id_2FB1);
}

_id_D4CD(var_0) {
  self endon(var_0 + "_finished");
  var_1 = 4900;
  var_2 = scripts\asm\asm_bb::bb_getmeleetarget();

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distancesquared(self.origin, var_2.origin);

    if(var_3 <= var_1) {
      if(isDefined(self.melee)) {
        self.melee._id_2FB1 = 1;
      }

      break;
    }

    wait 0.05;
  }
}

donotetracks_vsplayer(var_0, var_1) {
  for(;;) {
    self waittill(var_1, var_2);

    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    foreach(var_4 in var_2) {
      switch (var_4) {
        case "end":
          return;
        case "stop":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();

          if(!isDefined(var_5)) {
            return;
          }
          if(!isalive(var_5)) {
            return;
          }
          if(!isDefined(self.enemy) || self.enemy != var_5) {
            return;
          }
          var_6 = distancesquared(var_5.origin, self.origin);

          if(var_6 > 4096) {
            return;
          }
          break;
        case "fire":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();

          if(!isDefined(var_5)) {
            return;
          }
          if(isalive(var_5)) {
            if(isPlayer(var_5)) {
              if(isDefined(self._id_B621)) {
                var_7 = distance2dsquared(var_5.origin, self.origin);
              } else {
                var_7 = distancesquared(var_5.origin, self.origin);
              }

              var_8 = 4096;

              if(isDefined(self._id_B5E1)) {
                var_8 = self._id_B5E1;
              }

              if(var_7 <= var_8) {
                var_9 = undefined;
                var_10 = undefined;
                var_11 = undefined;
                var_12 = 20;
                var_13 = 0.45;
                var_14 = 0.35;
                var_15 = isDefined(level.player._id_C337) && level.player._id_C337.active;

                if(self.weapon == "none") {
                  var_9 = self._id_12B7F;
                }

                if(self.unittype == "c8") {
                  var_9 = self._id_3507;
                  var_10 = 24;
                  var_11 = 24;
                  self playSound("c8_melee_shield_swing");
                }

                if(var_15) {
                  var_12 = 10;
                  var_13 = 0.7;
                  var_14 = 0.5;
                  setsaveddvar("player_meleeDamageMultiplier", 0.05);
                }

                self melee(undefined, var_9, sqrt(var_8), var_10, var_11);

                if(var_15 && self.unittype == "soldier") {
                  self playSound("ai_melee_vs_shield");
                }

                if(isDefined(self.unittype) && self.unittype == "c6") {
                  self playSound("c6_punch_impact_plr");
                } else if(isDefined(self.unittype) && self.unittype == "c8") {
                  self playSound("c8_melee_shield_impact");
                }

                level.player _id_D0EA(self.origin, var_12);
                earthquake(0.45, 0.35, level.player.origin, 1000);
                level.player playRumbleOnEntity("damage_heavy");

                if(!var_15) {
                  level.player thread scripts\sp\gameskill::_id_2BDB(0.3, 0.25);
                  level.player viewkick(30, self.origin);
                } else
                  setsaveddvar("player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);
              }
            } else
              self melee();
          }

          break;
        default:
          scripts\anim\notetracks::handlenotetrack(var_4, var_1);
      }
    }
  }
}

_id_D0EA(var_0, var_1) {
  if(!self isonground()) {
    var_1 = var_1 * 0.1;
  }

  var_2 = vectorNormalize(self.origin + (0, 0, 45) - var_0);
  var_3 = var_2 * var_1 * 10;
  self setvelocity(var_3);
}

_id_B57F() {
  var_0 = self.melee.target;

  if(isDefined(self._id_B5DD)) {
    self.melee._id_13D8A = 1;
    var_0.melee._id_13D8A = 0;
    return;
  } else if(isDefined(var_0._id_B5DD)) {
    self.melee._id_13D8A = 0;
    var_0.melee._id_13D8A = 1;
    return;
  }

  if(isDefined(self._id_B14F)) {
    self.melee._id_13D8A = 1;
    var_0.melee._id_13D8A = 0;
  } else if(isDefined(var_0._id_B14F)) {
    self.melee._id_13D8A = 0;
    var_0.melee._id_13D8A = 1;
  } else {
    self.melee._id_13D8A = scripts\engine\utility::cointoss();
    var_0.melee._id_13D8A = !self.melee._id_13D8A;
  }
}

_id_B5B6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee._id_2720)) {
    return 1;
  }

  if(!isDefined(self.melee.target)) {
    return 1;
  }

  if(!isalive(self.melee.target)) {
    return 1;
  }

  if(isDefined(self.melee.target.dontmelee) && self.melee.target.dontmelee) {
    return 1;
  }

  return 0;
}

melee_shouldabort(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee._id_2720)) {
    if(isDefined(self.melee._id_3321)) {
      var_4 = scripts\asm\asm::_id_232B(var_1, "melee_stop");

      if(var_4) {
        self.melee._id_312C = 1;
      }

      return var_4;
    } else if(isDefined(self.melee._id_11095)) {
      var_5 = scripts\asm\asm::_id_233F(var_1, "melee_stop");

      if(!isDefined(var_5)) {
        self.melee._id_3321 = 1;
        return 0;
      } else
        self.melee._id_312C = 1;
    }

    return 1;
  }

  return 0;
}

_id_B5AD(var_0, var_1, var_2) {
  self.melee.bcharge = 1;
  self.melee._id_B5DE = var_0;
  self.melee._id_22E6 = var_1;
  self.melee._id_29B0 = var_2;
}

_id_B573(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.bcharge) && self.melee.bcharge;
}

_id_B571() {
  self.melee.bcharge = undefined;
}

_id_B59A(var_0, var_1, var_2, var_3) {
  if(self.melee._id_13D8A != var_3) {
    return 0;
  }

  return !_id_B573();
}

_id_B5B8(var_0, var_1, var_2, var_3) {
  return !isai(self.melee.target);
}

_id_B59B(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target scripts\asm\asm_bb::bb_getcovernode();
  return var_4.type == var_3;
}

_id_38A0(var_0, var_1, var_2, var_3) {}

_id_67D6(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;

  if(isPlayer(var_4)) {
    return 0;
  }

  if(isDefined(var_4._id_596E) && var_4._id_596E) {
    return 0;
  }

  if(!isDefined(self.melee._id_13D8A) || !isDefined(var_4.melee._id_13D8A)) {
    _id_B57F();
  }

  var_5 = var_3[0];

  if(self.melee._id_13D8A != var_5) {
    return 0;
  }

  var_6 = self[[self._id_7191]](var_0, var_2);
  var_7 = _id_38A7(var_6);

  if(!var_7) {
    return 0;
  }

  var_8 = var_3[1];
  var_9 = 30;
  var_10 = angleclamp180(self.melee._id_10D6D[1] - self.angles[1]);

  if(abs(var_10) > var_9) {
    return 0;
  }

  if(var_8) {
    var_11 = var_4.angles - (0, var_10 * 0.5, 0);
    var_12 = getstartorigin(var_4.origin, var_11, var_6);
  } else {
    var_12 = self.melee.startpos;
    var_11 = self.melee._id_10D6D;
  }

  var_13 = self.origin - var_12;
  var_14 = vectorNormalize(var_4.origin - var_12);
  var_15 = vectordot(var_14, var_13);

  if(var_15 > 12) {
    return 0;
  }

  if(var_8) {
    self.melee._id_10D6D = self.angles + (0, var_10 * 0.5, 0);
    var_4.melee._id_10D6D = var_11;
  }

  var_4.melee._id_331C = 1;
  return 1;
}

_id_38AA(var_0, var_1, var_2, var_3) {}

_id_38AB(var_0, var_1, var_2, var_3) {}

_id_38AC(var_0, var_1, var_2, var_3) {}

_id_38AD(var_0, var_1, var_2, var_3) {}

_id_38A8(var_0, var_1, var_2, var_3) {}

_id_38A9(var_0, var_1, var_2, var_3) {}

_id_38A7(var_0) {
  var_1 = self.melee.target;
  var_2 = var_1.origin;
  var_3 = self.origin - var_2;
  var_4 = vectortoangles(var_3);
  var_5 = getstartorigin(var_2, var_4, var_0);
  self.melee.startpos = var_5;
  self.melee._id_10D6D = getstartangles(var_2, var_4, var_0);
  var_1.melee._id_10E0E = var_4[1];
  return 1;
}

_id_38A6(var_0) {}

_id_B5D5(var_0, var_1, var_2) {}

_id_D4D6(var_0) {
  self endon(var_0 + "_finished");
  self waittill("melee_exit");
  self unlink();

  if(scripts\asm\asm::_id_232B(var_0, "melee_interact") && !scripts\asm\asm::_id_232B(var_0, "melee_death")) {
    if(isDefined(self.melee._id_9A08)) {
      self.melee._id_112E2 = !scripts\asm\asm::_id_232B(var_0, "drop");
    } else {
      self.melee._id_112E2 = 1;
    }
  }

  if(!isDefined(self.melee._id_2BE6)) {
    self.melee._id_2720 = 1;
  }
}

_id_B5B7(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee._id_112E2);
}

_id_B5B9(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee._id_312C);
}

_id_B5D7(var_0) {
  self endon(var_0 + "_finished");
  self waittill("weapon_dropped", var_1);

  if(isDefined(var_1)) {
    self.melee._id_5D3E = var_1;
  }
}

_id_B58E() {
  self.melee = undefined;
  self._id_B647 = undefined;
  self.syncedmeleetarget = undefined;
}

_id_B590(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = getsubstr(var_0, 3);
    self playSound(var_1);
    return;
  }

  switch (var_0) {
    case "sync":
      if(!isDefined(self.melee._id_2720)) {
        if(isDefined(self.melee.target)) {
          if(isalive(self.melee.target)) {
            self _meth_81E1(self.melee.target, "tag_sync", 1, 1);
          }
        } else if(isDefined(self.melee._id_331C) && isDefined(self.melee.partner)) {
          if(isalive(self.melee.partner)) {
            self _meth_81E1(self.melee.partner, "tag_sync", 1, 1);
          }
        }
      }

      break;
    case "unsync":
      if(isDefined(self.melee._id_71D3)) {
        self[[self.melee._id_71D3]]();
      } else {
        self unlink();
      }

      break;
    case "melee_interact":
      self.melee._id_112E3 = 1;
      break;
    case "melee_death":
      if(isDefined(self.melee._id_112E2)) {
        return var_0;
      }

      return var_0;
    case "attach_knife":
      self attach("tactical_knife_iw7", "TAG_INHAND", 1);
      self.melee._id_8C04 = 1;
      break;
    case "detach_knife":
      self detach("tactical_knife_iw7", "TAG_INHAND", 1);
      self.melee._id_8C04 = undefined;
      break;
    case "stab":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;
    case "melee_stop":
      break;
  }
}