/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreak_weapons.gsc
*************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\weapons\weapons;
#namespace killstreak_weapons;

function init() {
  callback::on_spawned(&on_player_spawned);
  setDvar(#"scr_heldkillstreak_penalty", 0);
}

function on_player_spawned() {
  self endon(#"disconnect");
  self.firedkillstreakweapon = 0;
  self.usingkillstreakheldweapon = undefined;

  if(!util::isfirstround() && !util::isoneround()) {
    if(level.roundstartkillstreakdelay > float(globallogic_utils::gettimepassed()) / 1000) {
      self thread function_d75d084a();
    }
  }
}

function function_d75d084a() {
  self endon(#"death");

  while(true) {
    currentweapon = self getcurrentweapon();
    waitresult = self waittill(#"weapon_change");
    newweapon = waitresult.weapon;

    if(level.roundstartkillstreakdelay < float(globallogic_utils::gettimepassed()) / 1000) {
      return;
    }

    if(!killstreaks::is_killstreak_weapon(newweapon)) {
      wait 0.5;
      continue;
    }

    killstreak = killstreaks::get_killstreak_for_weapon(newweapon);

    if(killstreaks::is_delayable_killstreak(killstreak) && newweapon.iscarriedkillstreak) {
      timeleft = int(level.roundstartkillstreakdelay - float(globallogic_utils::gettimepassed()) / 1000);

      if(!timeleft) {
        timeleft = 1;
      }

      self iprintlnbold(#"hash_55a79f95e07a10bc", " " + timeleft + " ", #"hash_79a58948c3b976f5");
      self switchtoweapon(currentweapon);
      wait 0.5;
    }
  }
}

function function_82ea8e15(hardpointtype) {
  if(!isDefined(hardpointtype)) {
    return false;
  }

  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    self switchtoweapon(self.lastdroppableweapon);
    return false;
  }

  currentweapon = self getcurrentweapon();
  killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);

  if(killstreakweapon == level.weaponnone) {
    return false;
  }

  level weapons::add_limited_weapon(killstreakweapon, self, 3);

  if(issubstr(hardpointtype, "inventory")) {
    isfrominventory = 1;
  } else {
    isfrominventory = 0;
  }

  currentammo = self getammocount(killstreakweapon);

  if((hardpointtype == "minigun" || hardpointtype == "inventory_minigun") && !is_true(self.minigunstart) || (hardpointtype == "m32" || hardpointtype == "inventory_m32") && !is_true(self.m32start)) {
    if(hardpointtype == "minigun" || hardpointtype == "inventory_minigun") {
      self.minigunstart = 1;
    } else {
      self.m32start = 1;
    }

    self killstreak_dialog::play_killstreak_start_dialog(hardpointtype, self.team, 1);
    self stats::function_e24eec31(killstreakweapon, #"used", 1);
    level thread popups::displayteammessagetoall(level.killstreaks[hardpointtype].script_bundle.var_667c638e, self);
    self.pers[#"held_killstreak_clip_count"][killstreakweapon] = killstreakweapon.clipsize < currentammo ? killstreakweapon.clipsize : currentammo;

    if(isfrominventory == 0) {
      if(self.pers[#"killstreak_quantity"][killstreakweapon] > 0) {
        self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = killstreakweapon.maxammo;
      }

      self killstreaks::function_fa6e0467(killstreakweapon);
    }
  }

  if(hardpointtype == "minigun" || hardpointtype == "inventory_minigun") {
    if(!is_true(self.minigunactive)) {
      killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);

      if(hardpointtype == "inventory_minigun") {
        killstreak_id = self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
      }

      self.minigunid = killstreak_id;
      self.minigunactive = 1;
    } else {
      killstreak_id = self.minigunid;
    }
  } else if(!is_true(self.m32active)) {
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);

    if(hardpointtype == "inventory_m32") {
      killstreak_id = self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
    }

    self.m32id = killstreak_id;
    self.m32active = 1;
  } else {
    killstreak_id = self.m32id;
  }

  assert(killstreak_id != -1);
  self.firedkillstreakweapon = 0;
  self setblockweaponpickup(killstreakweapon, 1);

  if(isfrominventory) {
    self setweaponammoclip(killstreakweapon, self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
    self setweaponammostock(killstreakweapon, self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1] - self.pers[#"held_killstreak_clip_count"][killstreakweapon]);
  }

  notifystring = "killstreakWeapon_" + killstreakweapon.name;
  self notify(notifystring);
  self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
  self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);
  self thread watchkillstreakroundchange(isfrominventory, killstreak_id);
  self thread watchplayerdeath(killstreakweapon);

  if(isfrominventory) {
    self thread watchkillstreakremoval(hardpointtype, killstreak_id);
  }

  self.usingkillstreakheldweapon = 1;
  return false;
}

function usekillstreakweaponfromcrate(hardpointtype) {
  if(!isDefined(hardpointtype)) {
    return false;
  }

  killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);

  if(killstreakweapon == level.weaponnone) {
    return false;
  }

  self.firedkillstreakweapon = 0;
  self setblockweaponpickup(killstreakweapon, 1);
  killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
  assert(killstreak_id != -1);

  if(issubstr(hardpointtype, "inventory")) {
    isfrominventory = 1;
  } else {
    isfrominventory = 0;
  }

  self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
  self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);

  if(isfrominventory) {
    self thread watchkillstreakremoval(hardpointtype, killstreak_id);
  }

  self.usingkillstreakheldweapon = 1;
  return true;
}

function watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory) {
  self endon(#"death");
  noneweapon = getweapon(#"none");
  minigunweapon = getweapon(#"minigun");
  miniguninventoryweapon = getweapon(#"inventory_minigun");

  while(true) {
    currentweapon = self getcurrentweapon();
    waitresult = self waittill(#"weapon_change");
    newweapon = waitresult.weapon;

    if(level.infinalkillcam) {
      continue;
    }

    if(newweapon == noneweapon) {
      continue;
    }

    currentammo = self getammocount(killstreakweapon);
    currentammoinclip = self getweaponammoclip(killstreakweapon);

    if(isfrominventory && currentammo > 0) {
      killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);

      if(isDefined(killstreakindex)) {
        self.pers[#"killstreak_ammo_count"][killstreakindex] = currentammo;
        self.pers[#"held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;
      }
    }

    if(killstreaks::is_killstreak_weapon(newweapon) && !newweapon.iscarriedkillstreak) {
      continue;
    }

    if(newweapon.isgameplayweapon) {
      continue;
    }

    if(newweapon == self.lastnonkillstreakweapon && newweapon.iscarriedkillstreak) {
      continue;
    }

    killstreakid = killstreaks::get_top_killstreak_unique_id();
    self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = currentammo;
    self.pers[#"held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;

    if(killstreak_id != -1) {
      self notify(#"killstreak_weapon_switch");
    }

    self.firedkillstreakweapon = 0;
    self.usingkillstreakheldweapon = undefined;
    waittillframeend();

    if(currentammo == 0 || self.pers[#"killstreak_quantity"][killstreakweapon] > 0 || isfrominventory && isDefined(killstreakid) && killstreakid != killstreak_id) {
      killstreakrules::killstreakstop(killstreaks::get_killstreak_for_weapon(killstreakweapon), self.team, killstreak_id);

      if(killstreakweapon == miniguninventoryweapon || killstreakweapon == minigunweapon) {
        self.minigunstart = 0;
        self.minigunactive = 0;
      } else {
        self.m32start = 0;
        self.m32active = 0;
      }

      if(self.pers[#"killstreak_quantity"][killstreakweapon] > 0) {
        self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = killstreakweapon.maxammo;
        self loadout::function_3ba6ee5d(killstreakweapon, self.pers[#"held_killstreak_ammo_count"][killstreakweapon]);
        self.pers[#"killstreak_quantity"][killstreakweapon]--;
      }
    }

    if(isfrominventory && currentammo == 0) {
      self takeweapon(killstreakweapon);
      self killstreaks::remove_used_killstreak(killstreaks::get_killstreak_for_weapon(killstreakweapon), killstreak_id);
      self killstreaks::activate_next();
    }

    break;
  }
}

function watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory) {
  self endon(#"disconnect", #"killstreak_weapon_switch");

  if(killstreak_id == -1) {
    return;
  }

  oldteam = self.team;
  self waittill(#"death");
  penalty = getdvarfloat(#"scr_heldkillstreak_penalty", 0.5);
  maxammo = killstreakweapon.maxammo;
  currentammo = self getammocount(killstreakweapon);
  currentammoinclip = self getweaponammoclip(killstreakweapon);

  if(self.pers[#"killstreak_quantity"].size == 0) {
    currentammo = 0;
    currentammoinclip = 0;
  }

  maxclipsize = killstreakweapon.clipsize;
  newammo = int(currentammo - maxammo * penalty);
  killstreakid = killstreaks::get_top_killstreak_unique_id();

  if(self.lastnonkillstreakweapon == killstreakweapon) {
    if(newammo < 0) {
      self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = 0;
      self.pers[#"held_killstreak_clip_count"][killstreakweapon] = 0;
    } else {
      self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = newammo;
      self.pers[#"held_killstreak_clip_count"][killstreakweapon] = maxclipsize <= newammo ? maxclipsize : newammo;
    }
  }

  self.usingkillstreakheldweapon = 0;
  killstreaktype = killstreaks::get_killstreak_for_weapon(killstreakweapon);

  if(newammo <= 0 || self.pers[#"killstreak_quantity"][killstreakweapon] > 0 || isfrominventory && isDefined(killstreakid) && killstreakid != killstreak_id) {
    killstreakrules::killstreakstop(killstreaktype, oldteam, killstreak_id);

    if(killstreaktype == "minigun" || killstreaktype == "inventory_minigun") {
      self.minigunstart = 0;
      self.minigunactive = 0;
    } else {
      self.m32start = 0;
      self.m32active = 0;
    }

    if(isDefined(self.pers[#"killstreak_quantity"][killstreakweapon]) && self.pers[#"killstreak_quantity"][killstreakweapon] > 0) {
      self.pers[#"held_killstreak_ammo_count"][killstreakweapon] = maxammo;
      self.pers[#"held_killstreak_clip_count"][killstreakweapon] = maxclipsize;
      self killstreaks::function_fa6e0467(killstreakweapon);
      self.pers[#"killstreak_quantity"][killstreakweapon]--;
    }
  }

  if(isfrominventory && newammo <= 0) {
    self takeweapon(killstreakweapon);
    self killstreaks::remove_used_killstreak(killstreaktype, killstreak_id);
    self killstreaks::activate_next();
    return;
  }

  if(isfrominventory) {
    killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);

    if(isDefined(killstreakindex)) {
      self.pers[#"killstreak_ammo_count"][killstreakindex] = self.pers[#"held_killstreak_ammo_count"][killstreakweapon];
    }
  }
}

function watchplayerdeath(killstreakweapon) {
  self endon(#"disconnect");
  endonweaponstring = "killstreakWeapon_" + killstreakweapon.name;
  self endon(endonweaponstring);
  self waittill(#"death");
  currentammo = self getammocount(killstreakweapon);
  self.pers[#"held_killstreak_clip_count"][killstreakweapon] = killstreakweapon.clipsize <= currentammo ? killstreakweapon.clipsize : currentammo;
}

function watchkillstreakremoval(killstreaktype, killstreak_id) {
  self endon(#"disconnect", #"death", #"killstreak_weapon_switch");
  waitresult = self waittill(#"oldest_killstreak_removed");
  removedkillstreaktype = waitresult.type;
  removed_id = waitresult.id;

  if(killstreaktype == removedkillstreaktype && killstreak_id == removed_id) {
    removedkillstreakweapon = killstreaks::get_killstreak_weapon(removedkillstreaktype);

    if(removedkillstreakweapon.name == "inventory_minigun") {
      self.minigunstart = 0;
      self.minigunactive = 0;
      return;
    }

    self.m32start = 0;
    self.m32active = 0;
  }
}

function watchkillstreakroundchange(isfrominventory, killstreak_id) {
  self endon(#"disconnect", #"death", #"killstreak_weapon_switch");
  self waittill(#"round_ended");
  currentweapon = self getcurrentweapon();

  if(!currentweapon.iscarriedkillstreak) {
    return;
  }

  currentammo = self getammocount(currentweapon);
  maxclipsize = currentweapon.clipsize;

  if(isfrominventory && currentammo > 0) {
    killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);

    if(isDefined(killstreakindex)) {
      self.pers[#"killstreak_ammo_count"][killstreakindex] = currentammo;
      self.pers[#"held_killstreak_clip_count"][currentweapon] = maxclipsize <= currentammo ? maxclipsize : currentammo;
    }

    return;
  }

  self.pers[#"held_killstreak_ammo_count"][currentweapon] = currentammo;
  self.pers[#"held_killstreak_clip_count"][currentweapon] = maxclipsize <= currentammo ? maxclipsize : currentammo;
}

function checkifswitchableweapon(currentweapon, newweapon, killstreakweapon, currentkillstreakid) {
  switchableweapon = 1;
  topkillstreak = killstreaks::get_top_killstreak();
  killstreakid = killstreaks::get_top_killstreak_unique_id();

  if(!isDefined(killstreakid)) {
    killstreakid = -1;
  }

  if(self hasweapon(killstreakweapon) && !self getammocount(killstreakweapon)) {
    switchableweapon = 1;
  } else if(self.firedkillstreakweapon && newweapon == killstreakweapon && currentweapon.iscarriedkillstreak) {
    switchableweapon = 1;
  } else if(newweapon.isequipment) {
    switchableweapon = 1;
  } else if(isDefined(level.grenade_array[newweapon])) {
    switchableweapon = 0;
  } else if(newweapon.iscarriedkillstreak && currentweapon.iscarriedkillstreak && (!isDefined(currentkillstreakid) || currentkillstreakid != killstreakid)) {
    switchableweapon = 1;
  } else if(killstreaks::is_killstreak_weapon(newweapon)) {
    switchableweapon = 0;
  } else if(newweapon.isgameplayweapon) {
    switchableweapon = 0;
  } else if(self.firedkillstreakweapon) {
    switchableweapon = 1;
  } else if(self.lastnonkillstreakweapon == killstreakweapon) {
    switchableweapon = 0;
  } else if(isDefined(topkillstreak) && topkillstreak == killstreakweapon && currentkillstreakid == killstreakid) {
    switchableweapon = 0;
  }

  return switchableweapon;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isDefined(self.pers[#"held_killstreak_ammo_count"])) {
    return;
  }

  var_e3daecef = getarraykeys(self.pers[#"held_killstreak_ammo_count"]);

  foreach(deathanimduration in var_e3daecef) {
    if(!isDefined(deathanimduration)) {
      continue;
    }

    ammocount = self.pers[#"held_killstreak_ammo_count"][deathanimduration];
    killstreaktype = killstreaks::get_killstreak_for_weapon(deathanimduration);
    bundle = level.killstreaks[killstreaktype].script_bundle;

    if(bundle.var_6f079d9a === 1 && deathanimduration.maxammo == ammocount && ammocount > 0) {
      continue;
    }

    ammoondeath = ammocount;
    var_c1265b8d = isDefined(bundle.var_d88d50b8) ? bundle.var_d88d50b8 : 0;
    var_9a1bcbe = int(floor(deathanimduration.maxammo * var_c1265b8d / 100));

    if(ammocount < var_9a1bcbe) {
      ammocount = 0;
    } else {
      var_3e7b9084 = isDefined(bundle.var_877cedde) ? bundle.var_877cedde : 0;
      var_6deff896 = int(floor(deathanimduration.maxammo * var_3e7b9084 / 100));
      ammocount -= var_6deff896;
    }

    if(ammocount < 0) {
      ammocount = 0;
    }

    self.pers[#"held_killstreak_ammo_count"][deathanimduration] = ammocount;

    if(ammoondeath > 0 && ammocount == 0) {
      if(deathanimduration.var_6f41c2a9) {
        self killstreaks::remove_used_killstreak(killstreaktype);
      }

      if(!self killstreaks::function_55e3fed6(killstreaktype)) {
        if(isDefined(level.var_1d971504) && self.currentweapon != deathanimduration) {
          [[level.var_1d971504]](psoffsettime, self, deathanimduration);
        }

        killstreakslot = killstreaks::function_a2c375bb(killstreaktype);

        if(isDefined(killstreakslot)) {
          self function_6bf621ea(#"hash_2e64558432f8b5b2", 2, self getentitynumber(), killstreakslot);
        }

        self thread function_11a9ad5(killstreaktype, deathanimduration);
      }
    }
  }
}

function function_11a9ad5(killstreaktype, weapon) {
  self killstreaks::function_ea21be29(killstreaktype, weapon, 1);
}