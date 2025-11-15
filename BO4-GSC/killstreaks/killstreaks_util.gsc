/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreaks_util.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\util_shared;

#namespace killstreaks;

switch_to_last_non_killstreak_weapon(immediate, awayfromball, gameended) {
  ball = getweapon(#"ball");

  if(isDefined(ball) && self hasweapon(ball) && !(isDefined(awayfromball) && awayfromball)) {
    self switchtoweaponimmediate(ball);
    self disableweaponcycling();
    self disableoffhandweapons();
  } else if(isDefined(self.laststand) && self.laststand) {
    if(isDefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
      self switchtoweapon(self.laststandpistol);
    }
  } else if(isDefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon) && self getcurrentweapon() != self.lastnonkillstreakweapon) {
    if(ability_util::is_hero_weapon(self.lastnonkillstreakweapon)) {
      if(self.lastnonkillstreakweapon.gadget_heroversion_2_0) {
        if(self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0) {
          slot = self gadgetgetslot(self.lastnonkillstreakweapon);

          if(self util::gadget_is_in_use(slot)) {
            return self switchtoweapon(self.lastnonkillstreakweapon);
          } else {
            return 1;
          }
        }
      } else if(self getammocount(self.lastnonkillstreakweapon) > 0) {
        return self switchtoweapon(self.lastnonkillstreakweapon);
      }

      if(isDefined(awayfromball) && awayfromball && isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        self switchtoweapon(self.lastdroppableweapon);
      } else {
        self switchtoweapon();
      }

      return 1;
    } else if(isDefined(immediate) && immediate) {
      self switchtoweaponimmediate(self.lastnonkillstreakweapon, isDefined(gameended) && gameended);
    } else {
      self switchtoweapon(self.lastnonkillstreakweapon);
    }
  } else if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon) && self getcurrentweapon() != self.lastdroppableweapon) {
    self switchtoweapon(self.lastdroppableweapon);
  } else {
    return 0;
  }

  return 1;
}

hasuav(team_or_entnum) {
  if(!isDefined(level.activeuavs)) {
    return true;
  }

  return level.activeuavs[team_or_entnum] > 0;
}

hassatellite(team_or_entnum) {
  if(!isDefined(level.activesatellites)) {
    return true;
  }

  return level.activesatellites[team_or_entnum] > 0;
}

function_f479a2ff(weapon) {
  if(isDefined(level.var_3ff1b984) && isDefined(level.var_3ff1b984[weapon])) {
    return true;
  }

  return false;
}

function_e3a30c69(weapon) {
  assert(isDefined(isDefined(level.killstreakweapons[weapon])));
  killstreak = level.killstreaks[level.killstreakweapons[weapon]];
  return isDefined(killstreak.script_bundle.var_a82b593f) ? killstreak.script_bundle.var_a82b593f : 0;
}

is_killstreak_weapon(weapon) {
  if(weapon == level.weaponnone || weapon.notkillstreak) {
    return false;
  }

  if(weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
    return true;
  }

  return false;
}

get_killstreak_weapon(killstreak) {
  if(!isDefined(killstreak)) {
    return level.weaponnone;
  }

  assert(isDefined(level.killstreaks[killstreak]));
  return level.killstreaks[killstreak].weapon;
}

is_weapon_associated_with_killstreak(weapon) {
  return isDefined(level.killstreakweapons) && isDefined(level.killstreakweapons[weapon]);
}