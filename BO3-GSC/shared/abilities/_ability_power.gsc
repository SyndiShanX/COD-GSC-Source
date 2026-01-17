/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\_ability_power.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_gadgets;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#namespace ability_power;

function autoexec __init__sytem__() {
  system::register("ability_power", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_connect(&on_player_connect);
}

function cpower_print(slot, str) {
  color = "";
  toprint = (color + "") + str;
  weaponname = "";
  if(isDefined(self._gadgets_player[slot])) {
    weaponname = self._gadgets_player[slot].name;
  }
  if(getdvarint("") > 0) {
    self iprintlnbold(toprint);
  } else {
    println((((self.playername + "") + weaponname) + "") + toprint);
  }
}

function on_player_connect() {}

function power_is_hero_ability(gadget) {
  return gadget.gadget_type != 0;
}

function is_weapon_or_variant_same_as_gadget(weapon, gadget) {
  if(weapon == gadget) {
    return true;
  }
  if(isDefined(level.weaponlightninggun) && gadget == level.weaponlightninggun) {
    if(isDefined(level.weaponlightninggunarc) && weapon == level.weaponlightninggunarc) {
      return true;
    }
  }
  return false;
}

function power_gain_event_score(eattacker, score, weapon, hero_restricted) {
  if(score > 0) {
    for(slot = 0; slot < 3; slot++) {
      gadget = self._gadgets_player[slot];
      if(isDefined(gadget)) {
        ignoreself = gadget.gadget_powergainscoreignoreself;
        if(isDefined(weapon) && ignoreself && is_weapon_or_variant_same_as_gadget(weapon, gadget)) {
          continue;
        }
        ignorewhenactive = gadget.gadget_powergainscoreignorewhenactive;
        if(ignorewhenactive && self gadgetisactive(slot)) {
          continue;
        }
        if(isDefined(hero_restricted) && hero_restricted && power_is_hero_ability(gadget)) {
          continue;
        }
        scorefactor = gadget.gadget_powergainscorefactor;
        if(isDefined(self.gadgetthiefactive) && self.gadgetthiefactive == 1) {
          continue;
        }
        gametypefactor = getgametypesetting("scoreHeroPowerGainFactor");
        perkfactor = 1;
        if(self hasperk("specialty_overcharge")) {
          perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
        }
        if(scorefactor > 0 && gametypefactor > 0) {
          gaintoadd = ((score * scorefactor) * gametypefactor) * perkfactor;
          self power_gain_event(slot, eattacker, gaintoadd, "score");
        }
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
      if(meansofdeath == "MOD_MELEE_ASSASSINATE" && self ability_util::gadget_is_camo_suit_on()) {
        if(self._gadgets_player[slot].gadget_powertakedowngain > 0) {
          source = "assassinate actor";
          self power_gain_event(slot, eattacker, self._gadgets_player[slot].gadget_powertakedowngain, source);
        }
      }
      if(self._gadgets_player[slot].gadget_powerreplenishfactor > 0) {
        gaintoadd = basegain * self._gadgets_player[slot].gadget_powerreplenishfactor;
        if(gaintoadd > 0) {
          source = "killed actor";
          self power_gain_event(slot, eattacker, gaintoadd, source);
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
  if(powertoadd > 0.1 || powertoadd < -0.1) {
    powerleft = self gadgetpowerchange(slot, powertoadd);
    self cpower_print(slot, (((("" + powertoadd) + "") + source) + "") + powerleft);
  }
}

function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  baseloss = idamage;
  for(slot = 0; slot < 3; slot++) {
    if(isDefined(self._gadgets_player[slot])) {
      if(self gadgetisactive(slot)) {
        powerloss = baseloss * self._gadgets_player[slot].gadget_poweronlossondamage;
        if(powerloss > 0) {
          self power_loss_event(slot, eattacker, powerloss, "took damage with power on");
        }
        if(self._gadgets_player[slot].gadget_flickerondamage > 0) {
          self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickerondamage);
        }
        continue;
      }
      powerloss = baseloss * self._gadgets_player[slot].gadget_powerofflossondamage;
      if(powerloss > 0) {
        self power_loss_event(slot, eattacker, powerloss, "took damage");
      }
    }
  }
}

function power_loss_event(slot, eattacker, val, source) {
  powertoremove = val * -1;
  if(powertoremove > 0.1 || powertoremove < -0.1) {
    powerleft = self gadgetpowerchange(slot, powertoremove);
    self cpower_print(slot, (((("" + powertoremove) + "") + source) + "") + powerleft);
  }
}

function power_drain_completely(slot) {
  powerleft = self gadgetpowerchange(slot, 0);
  powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

function ismovingpowerloss() {
  velocity = self getvelocity();
  speedsq = lengthsquared(velocity);
  return speedsq > (self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed);
}

function power_consume_timer_think(slot, weapon) {
  self endon("disconnect");
  self endon("death");
  time = gettime();
  while(true) {
    wait(0.1);
    if(!isDefined(self._gadgets_player[slot])) {
      return;
    }
    if(!self gadgetisactive(slot)) {
      return;
    }
    currenttime = gettime();
    interval = currenttime - time;
    time = currenttime;
    powerconsumpted = 0;
    if(self isonground()) {
      if(self._gadgets_player[slot].gadget_powersprintloss > 0 && self issprinting()) {
        powerconsumpted = powerconsumpted + (((1 * interval) / 1000) * self._gadgets_player[slot].gadget_powersprintloss);
      } else if(self._gadgets_player[slot].gadget_powermoveloss && self ismovingpowerloss()) {
        powerconsumpted = powerconsumpted + (((1 * interval) / 1000) * self._gadgets_player[slot].gadget_powermoveloss);
      }
    }
    if(powerconsumpted > 0.1) {
      self power_loss_event(slot, self, powerconsumpted, "consume");
      if(self._gadgets_player[slot].gadget_flickeronpowerloss > 0) {
        self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickeronpowerloss);
      }
    }
  }
}