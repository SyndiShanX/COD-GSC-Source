/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6f74c67411fcab41.gsc
*************************************************/

#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\mp\killstreaks\killstreaks;
#namespace namespace_de169b8ad93c38b5;

function function_e1a78f7ca6c76a52() {
  function_900f562c61c6a5d6("killstreak", &use_killstreak, &function_a6c2c08d6694cda3, &can_use_killstreak, &function_d6029511a9d0984, &function_5ef81282e50397e);

  if(!isDefined(level.var_a9afa220306e1f68)) {
    level.var_a9afa220306e1f68 = inventory_isenabled();
  }

  level.deathretainstreaks = 1;
}

function use_killstreak(itembundle, item) {
  if(iskillstreakavailable()) {
    if(function_e1a7409f30e3c964()) {
      self notify("potential_killstreak_deployment_finish", "weapon_change");
    }

    if(istrue(item.var_4ec444a18e7fc2c0)) {
      [var_2814cca693e6ef2d, quantity] = function_d6029511a9d0984();
      items_dropitem(var_2814cca693e6ef2d, quantity);
    }

    removekillstreak(1);
  }

  awardkillstreak(itembundle.ref, "other", undefined, undefined, undefined, 1);
  return item.count - 1;
}

function can_use_killstreak(itembundle, item, autouse, allowswap) {
  if(isDefined(self.triggeringstreak) || istrue(self.enabledequipdeployvfx) || function_e1a7409f30e3c964()) {
    return false;
  }

  if(iskillstreakavailable()) {
    [var_2814cca693e6ef2d, quantity] = function_d6029511a9d0984();

    if(!isDefined(var_2814cca693e6ef2d)) {
      assertmsg("<dev string:x1c>");
      return false;
    }

    if(itembundle.ref == var_2814cca693e6ef2d.ref) {
      return false;
    }
  }

  return true;
}

function function_a6c2c08d6694cda3(itembundle, item, autouse, allowswap) {
  if(isDefined(self.triggeringstreak) || istrue(self.enabledequipdeployvfx) || function_e1a7409f30e3c964()) {
    return 0;
  }

  if(iskillstreakavailable()) {
    return 0;
  }

  return 1;
}

function function_d6029511a9d0984() {
  itembundle = undefined;
  quantity = 0;

  if(isDefined(self.streakdata) && isDefined(self.streakdata.streaks)) {
    if(iskillstreakavailable()) {
      killstreakref = self.streakdata.streaks[1].streakname;

      if(!isDefined(killstreakref)) {
        return [itembundle, quantity];
      }

      killstreakbundlename = function_61d960957fcf3ca0(killstreakref);

      if(isDefined(killstreakbundlename)) {
        itembundle = getscriptbundle("itemspawnentry:" + killstreakbundlename);
        quantity = 1;
      }
    }
  }

  return [itembundle, quantity];
}

function function_5ef81282e50397e() {
  removekillstreak(1);
  updatekillstreakuislot(1);
}

function iskillstreakavailable() {
  streakitem = self.streakdata.streaks[1];

  if(isDefined(streakitem) && isDefined(streakitem.streakname) && streakitem.available == 1) {
    return 1;
  }

  return 0;
}

function function_e1a7409f30e3c964() {
  return scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self.currentweapon);
}