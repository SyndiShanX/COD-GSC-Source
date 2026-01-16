/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3172.gsc
*********************************************/

func_9D87(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee) && isDefined(self.melee.var_2FB1);
}

func_D4CD(var_0) {
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
        self.melee.var_2FB1 = 1;
      }

      break;
    }

    wait(0.05);
  }
}

donotetracks_vsplayer(var_0, var_1) {
  for(;;) {
    self waittill(var_1, var_2);
    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    foreach(var_10, var_4 in var_2) {
      switch (var_4) {
        case "end":
          break;

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
            if(isplayer(var_5)) {
              if(isDefined(self.var_B621)) {
                var_7 = distance2dsquared(var_5.origin, self.origin);
              } else {
                var_7 = distancesquared(var_7.origin, self.origin);
              }

              var_8 = 4096;
              if(isDefined(self.var_B5E1)) {
                var_8 = self.var_B5E1;
              }

              if(var_7 <= var_8) {
                var_9 = undefined;
                var_10 = undefined;
                var_11 = undefined;
                var_12 = 20;
                var_13 = 0.45;
                var_14 = 0.35;
                var_15 = isDefined(level.player.var_C337) && level.player.var_C337.var_19;
                if(self.weapon == "none") {
                  var_9 = self.var_12B7F;
                }

                if(self.unittype == "c8") {
                  var_9 = self.var_3507;
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

                level.player func_D0EA(self.origin, var_12);
                earthquake(0.45, 0.35, level.player.origin, 1000);
                level.player playrumbleonentity("damage_heavy");
                if(!var_15) {
                  level.player thread scripts\sp\gameskill::func_2BDB(0.3, 0.25);
                  level.player viewkick(30, self.origin);
                } else {
                  setsaveddvar("player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);
                }
              }
            } else {
              self melee();
            }
          }
          break;

        default:
          scripts\anim\notetracks::handlenotetrack(var_4, var_1);
          break;
      }
    }
  }
}

func_D0EA(var_0, var_1) {
  if(!self isonground()) {
    var_1 = var_1 * 0.1;
  }

  var_2 = vectornormalize(self.origin + (0, 0, 45) - var_0);
  var_3 = var_2 * var_1 * 10;
  self setvelocity(var_3);
}

func_B57F() {
  var_0 = self.melee.target;
  if(isDefined(self.var_B5DD)) {
    self.melee.var_13D8A = 1;
    var_0.melee.var_13D8A = 0;
    return;
  } else if(isDefined(var_0.var_B5DD)) {
    self.melee.var_13D8A = 0;
    var_0.melee.var_13D8A = 1;
    return;
  }

  if(isDefined(self.var_B14F)) {
    self.melee.var_13D8A = 1;
    var_0.melee.var_13D8A = 0;
    return;
  }

  if(isDefined(var_0.var_B14F)) {
    self.melee.var_13D8A = 0;
    var_0.melee.var_13D8A = 1;
    return;
  }

  self.melee.var_13D8A = scripts\engine\utility::cointoss();
  var_0.melee.var_13D8A = !self.melee.var_13D8A;
}

func_B5B6(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee.var_2720)) {
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

  if(isDefined(self.melee.var_2720)) {
    if(isDefined(self.melee.var_3321)) {
      var_4 = scripts\asm\asm::func_232B(var_1, "melee_stop");
      if(var_4) {
        self.melee.var_312C = 1;
      }

      return var_4;
    } else if(isDefined(self.melee.var_11095)) {
      var_5 = scripts\asm\asm::func_233F(var_2, "melee_stop");
      if(!isDefined(var_5)) {
        self.melee.var_3321 = 1;
        return 0;
      } else {
        self.melee.var_312C = 1;
      }
    }

    return 1;
  }

  return 0;
}

func_B5AD(var_0, var_1, var_2) {
  self.melee.bcharge = 1;
  self.melee.var_B5DE = var_0;
  self.melee.var_22E6 = var_1;
  self.melee.var_29B0 = var_2;
}

func_B573(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.bcharge) && self.melee.bcharge;
}

func_B571() {
  self.melee.bcharge = undefined;
}

func_B59A(var_0, var_1, var_2, var_3) {
  if(self.melee.var_13D8A != var_3) {
    return 0;
  }

  return !func_B573();
}

func_B5B8(var_0, var_1, var_2, var_3) {
  return !isai(self.melee.target);
}

func_B59B(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target scripts\asm\asm_bb::bb_getcovernode();
  return var_4.type == var_3;
}

func_38A0(var_0, var_1, var_2, var_3) {}

func_67D6(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;
  if(isplayer(var_4)) {
    return 0;
  }

  if(isDefined(var_4.var_596E) && var_4.var_596E) {
    return 0;
  }

  if(!isDefined(self.melee.var_13D8A) || !isDefined(var_4.melee.var_13D8A)) {
    func_B57F();
  }

  var_5 = var_3[0];
  if(self.melee.var_13D8A != var_5) {
    return 0;
  }

  var_6 = self[[self.var_7191]](var_0, var_2);
  var_7 = func_38A7(var_6);
  if(!var_7) {
    return 0;
  }

  var_8 = var_3[1];
  var_9 = 30;
  var_10 = angleclamp180(self.melee.var_10D6D[1] - self.angles[1]);
  if(abs(var_10) > var_9) {
    return 0;
  }

  if(var_8) {
    var_11 = var_4.angles - (0, var_10 * 0.5, 0);
    var_12 = getstartorigin(var_4.origin, var_11, var_6);
  } else {
    var_12 = self.melee.areanynavvolumesloaded;
    var_11 = self.melee.var_10D6D;
  }

  var_13 = self.origin - var_12;
  var_14 = vectornormalize(var_4.origin - var_12);
  var_15 = vectordot(var_14, var_13);
  if(var_15 > 12) {
    return 0;
  }

  if(var_8) {
    self.melee.var_10D6D = self.angles + (0, var_10 * 0.5, 0);
    var_4.melee.var_10D6D = var_11;
  }

  var_4.melee.var_331C = 1;
  return 1;
}

func_38AA(var_0, var_1, var_2, var_3) {}

func_38AB(var_0, var_1, var_2, var_3) {}

func_38AC(var_0, var_1, var_2, var_3) {}

func_38AD(var_0, var_1, var_2, var_3) {}

func_38A8(var_0, var_1, var_2, var_3) {}

func_38A9(var_0, var_1, var_2, var_3) {}

func_38A7(var_0) {
  var_1 = self.melee.target;
  var_2 = var_1.origin;
  var_3 = self.origin - var_2;
  var_4 = vectortoangles(var_3);
  var_5 = getstartorigin(var_2, var_4, var_0);
  self.melee.areanynavvolumesloaded = var_5;
  self.melee.var_10D6D = getstartangles(var_2, var_4, var_0);
  var_1.melee.var_10E0E = var_4[1];
  return 1;
}

func_38A6(var_0) {}

func_B5D5(var_0, var_1, var_2) {}

func_D4D6(var_0) {
  self endon(var_0 + "_finished");
  self waittill("melee_exit");
  self unlink();
  if(scripts\asm\asm::func_232B(var_0, "melee_interact") && !scripts\asm\asm::func_232B(var_0, "melee_death")) {
    if(isDefined(self.melee.var_9A08)) {
      self.melee.var_112E2 = !scripts\asm\asm::func_232B(var_0, "drop");
    } else {
      self.melee.var_112E2 = 1;
    }
  }

  if(!isDefined(self.melee.var_2BE6)) {
    self.melee.var_2720 = 1;
  }
}

func_B5B7(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.var_112E2);
}

func_B5B9(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.var_312C);
}

func_B5D7(var_0) {
  self endon(var_0 + "_finished");
  self waittill("weapon_dropped", var_1);
  if(isDefined(var_1)) {
    self.melee.var_5D3E = var_1;
  }
}

func_B58E() {
  self.melee = undefined;
  self.var_B647 = undefined;
  self.physics_setgravityragdollscalar = undefined;
}

func_B590(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = getsubstr(var_0, 3);
    self playSound(var_1);
    return;
  }

  switch (var_1) {
    case "sync":
      if(!isDefined(self.melee.var_2720)) {
        if(isDefined(self.melee.target)) {
          if(isalive(self.melee.target)) {
            self linktoblendtotag(self.melee.target, "tag_sync", 1, 1);
          }
        } else if(isDefined(self.melee.var_331C) && isDefined(self.melee.partner)) {
          if(isalive(self.melee.partner)) {
            self linktoblendtotag(self.melee.partner, "tag_sync", 1, 1);
          }
        }
      }
      break;

    case "unsync":
      if(isDefined(self.melee.var_71D3)) {
        self[[self.melee.var_71D3]]();
      } else {
        self unlink();
      }
      break;

    case "melee_interact":
      self.melee.var_112E3 = 1;
      break;

    case "melee_death":
      if(isDefined(self.melee.var_112E2)) {
        return var_1;
      }
      return var_1;

    case "attach_knife":
      self attach("tactical_knife_iw7", "TAG_INHAND", 1);
      self.melee.var_8C04 = 1;
      break;

    case "detach_knife":
      self detach("tactical_knife_iw7", "TAG_INHAND", 1);
      self.melee.var_8C04 = undefined;
      break;

    case "stab":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;

    case "melee_stop":
      break;
  }
}