/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\ability_power.gsc
***********************************************/

#using scripts\abilities\ability_gadgets;
#using scripts\abilities\ability_util;
#namespace ability_power;

function cpower_print(slot, str) {
  color = "<dev string:x38>";
  toprint = color + "<dev string:x3e>" + str;
  weaponname = "<dev string:x52>";

  if(isDefined(self._gadgets_player[slot])) {
    weaponname = self._gadgets_player[slot].name;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold(toprint);
    return;
  }

  println(self.playername + "<dev string:x5a>" + weaponname + "<dev string:x5a>" + toprint);
}

function power_is_hero_ability(gadget) {
  return gadget.gadget_type != 0;
}

function function_9d78823f(gadget, weapon) {
  if(!isDefined(level.var_d0b212bd)) {
    level.var_d0b212bd = [];
  }

  level.var_d0b212bd[weapon] = gadget;
}

function is_weapon_or_variant_same_as_gadget(weapon, gadget) {
  if(weapon == gadget) {
    return true;
  }

  if(isDefined(level.var_d0b212bd)) {
    if(level.var_d0b212bd[weapon] === gadget) {
      return true;
    }
  }

  return false;
}

function power_gain_event_score(event, eattacker, score, weapon) {
  if(!isPlayer(self)) {
    return;
  }

  if(score <= 0) {
    return;
  }

  if(self.gadgetthiefactive === 1) {
    return;
  }

  var_f1ee6456 = 1;

  var_f1ee6456 *= getdvarfloat(#"hash_eae9a8ee387705d", 1);

  if(!isDefined(level.var_607bc6e7)) {
    level.var_607bc6e7 = getgametypesetting(#"scoreheropowergainfactor");

    if(level.var_73e51905 === 1) {
      var_d2260acb = getdvarfloat(#"hash_1cfb84145f54fa01", 0.59);

      if(var_d2260acb > 0) {
        level.var_607bc6e7 = var_d2260acb;
      }
    }
  }

  gametypefactor = level.var_607bc6e7;
  perkfactor = 1;

  if(self hasperk(#"specialty_overcharge")) {
    perkfactor = getdvarfloat(#"gadgetpoweroverchargeperkscorefactor", 0);
  }

  var_ec6ee937 = score * gametypefactor * perkfactor * var_f1ee6456;

  if(var_ec6ee937 <= 0) {
    return;
  }

  var_18fc605 = getdvarint(#"hash_74d01f2fd0317f08", 0) || isDefined(weapon) && weapon.var_f23e9d19;

  for(slot = 0; slot < 3; slot++) {
    gadget = self._gadgets_player[slot];

    if(isDefined(gadget)) {
      ignoreself = gadget.gadget_powergainscoreignoreself;
      var_503ccf9e = isDefined(weapon) && is_weapon_or_variant_same_as_gadget(weapon, gadget);

      if(ignoreself && var_503ccf9e || var_18fc605 && !var_503ccf9e) {
        continue;
      }

      ignorewhenactive = gadget.gadget_powergainscoreignorewhenactive;

      if(ignorewhenactive && self gadgetisactive(slot)) {
        continue;
      }

      scorefactor = gadget.gadget_powergainscorefactor;

      if(scorefactor > 0) {
        gaintoadd = scorefactor * var_ec6ee937;
        self power_gain_event(slot, eattacker, gaintoadd, "score");
      }
    }
  }
}

function power_gain_event_damage_actor(eattacker) {
  basegain = 0;

  if(basegain > 0) {
    for(slot = 0; slot < 3; slot++) {
      if(isDefined(self._gadgets_player[slot])) {
        self power_gain_event(slot, eattacker, basegain, "damaged actor");
      }
    }
  }
}

function power_gain_event_killed_actor(eattacker, meansofdeath) {
  basegain = 5;

  for(slot = 0; slot < 3; slot++) {
    if(isDefined(self._gadgets_player[slot])) {
      if(self._gadgets_player[slot].gadget_powerreplenishfactor > 0) {
        gaintoadd = basegain * self._gadgets_player[slot].gadget_powerreplenishfactor;

        if(gaintoadd > 0) {
          source = "killed actor";
          self power_gain_event(slot, meansofdeath, gaintoadd, source);
        }
      }
    }
  }
}

function power_gain_event(slot, eattacker, val, source) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  powertoadd = val;

  if(abs(powertoadd) > 0.0001) {
    maxscore = self._gadgets_player[eattacker].var_1e89f40;

    if(maxscore && 0 < powertoadd) {
      if(powertoadd + self.var_aec4af05[eattacker] > maxscore) {
        powertoadd = maxscore - self.var_aec4af05[eattacker];

        if(0 >= powertoadd) {
          return;
        }
      }
    }

    powerleft = self gadgetpowerchange(eattacker, powertoadd);

    if(0 < powertoadd) {
      self.var_aec4af05[eattacker] += powertoadd;
    }

    self cpower_print(eattacker, "<dev string:x60>" + powertoadd + "<dev string:x6d>" + source + "<dev string:x7b>" + powerleft);
  }
}

function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  if(!isDefined(self._gadgets_player)) {
    return;
  }

  baseloss = idamage;

  for(slot = 0; slot < 3; slot++) {
    if(isDefined(self._gadgets_player[slot])) {
      if(self gadgetisactive(slot)) {
        powerloss = baseloss * self._gadgets_player[slot].gadget_poweronlossondamage;

        if(powerloss > 0) {
          self power_loss_event(slot, smeansofdeath, powerloss, "took damage with power on");
        }

        if(self._gadgets_player[slot].gadget_flickerondamage > 0) {
          self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickerondamage);
        }

        continue;
      }

      powerloss = baseloss * self._gadgets_player[slot].gadget_powerofflossondamage;

      if(powerloss > 0) {
        self power_loss_event(slot, smeansofdeath, powerloss, "took damage");
      }
    }
  }
}

function power_loss_event(slot, eattacker, val, source) {
  powertoremove = val * -1;

  if(powertoremove > 0.1 || powertoremove < -0.1) {
    powerleft = self gadgetpowerchange(eattacker, powertoremove);

    self cpower_print(eattacker, "<dev string:x8d>" + powertoremove + "<dev string:x6d>" + source + "<dev string:x7b>" + powerleft);
  }
}

function power_drain_completely(slot) {
  powerleft = self gadgetpowerchange(slot, 0);
  powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

function ismovingpowerloss() {
  velocity = self getvelocity();
  speedsq = lengthsquared(velocity);
  return speedsq > self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed;
}

function power_consume_timer_think(slot, weapon) {
  self endon(#"death");

  if(!isDefined(self._gadgets_player)) {
    return;
  }

  time = gettime();

  while(true) {
    wait 0.1;

    if(!isDefined(self._gadgets_player[weapon])) {
      return;
    }

    if(!self gadgetisactive(weapon)) {
      return;
    }

    currenttime = gettime();
    interval = currenttime - time;
    time = currenttime;
    powerconsumpted = 0;

    if(self isonground()) {
      if(self._gadgets_player[weapon].gadget_powersprintloss > 0 && self issprinting()) {
        powerconsumpted += 1 * float(interval) / 1000 * self._gadgets_player[weapon].gadget_powersprintloss;
      } else if(self._gadgets_player[weapon].gadget_powermoveloss && self ismovingpowerloss()) {
        powerconsumpted += 1 * float(interval) / 1000 * self._gadgets_player[weapon].gadget_powermoveloss;
      }
    }

    if(powerconsumpted > 0.1) {
      self power_loss_event(weapon, self, powerconsumpted, "consume");

      if(self._gadgets_player[weapon].gadget_flickeronpowerloss > 0) {
        self ability_gadgets::setflickering(weapon, self._gadgets_player[weapon].gadget_flickeronpowerloss);
      }
    }
  }
}