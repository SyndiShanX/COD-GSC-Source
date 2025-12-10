/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_bb;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_tactical_rig_emergencyreserve;
#using scripts\cp\gametypes\_save;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom;

function wait_to_load() {
  level flagsys::wait_till("load_main_complete");
  level thread cybercom_dev::cybercom_setupdevgui();
  setdvar("scr_max_simLocks", 5);
}

function vehicle_init_cybercom(vehicle) {
  if(isDefined(vehicle.archetype)) {
    vehicle.var_9147087d = [];
    switch (vehicle.archetype) {
      case "hunter": {
        vehicle.nocybercom = 1;
        break;
      }
      case "quadtank": {
        vehicle cybercom_aioptout("cybercom_surge");
        vehicle cybercom_aioptout("cybercom_servoshortout");
        vehicle cybercom_aioptout("cybercom_systemoverload");
        vehicle cybercom_aioptout("cybercom_smokescreen");
        vehicle cybercom_aioptout("cybercom_immolate");
        vehicle.var_9147087d["cybercom_hijack"] = getdvarint("scr_hacktime_quadtank", 11);
        vehicle.var_9147087d["cybercom_iffoverride"] = getdvarint("scr_hacktime_quadtank", 11);
        vehicle.var_6c8af4c4 = 0;
        vehicle.var_ced13b2f = 1;
        break;
      }
      case "siegebot": {
        vehicle cybercom_aioptout("cybercom_surge");
        vehicle cybercom_aioptout("cybercom_servoshortout");
        vehicle cybercom_aioptout("cybercom_smokescreen");
        vehicle cybercom_aioptout("cybercom_immolate");
        vehicle.var_9147087d["cybercom_hijack"] = getdvarint("scr_hacktime_siegebot", 9);
        vehicle.var_9147087d["cybercom_iffoverride"] = getdvarint("scr_hacktime_siegebot", 9);
        vehicle.var_6c8af4c4 = 0;
        vehicle.var_ced13b2f = 1;
        break;
      }
      case "glaive":
      case "parasite": {
        vehicle.nocybercom = 1;
      }
      default: {
        break;
      }
    }
  }
}

function function_79bafe1d(vehicle) {
  vehicle clientfield::set("cybercom_shortout", 0);
  vehicle clientfield::set("cybercom_surge", 0);
}

function function_fabadf47(vehicle, issystemup) {
  if(issystemup) {
    vehicle.var_f40d252c = 1;
  } else {
    vehicle.var_d3f57f67 = undefined;
    vehicle.var_f40d252c = undefined;
  }
}

function getcybercomflags() {
  self.cybercom.flags.tacrigs = self getcybercomrigs();
  self populatecybercomunlocks();
  self.cybercom.flags.type = self getcybercomactivetype();
  self.cybercom.flags.abilities = [];
  self.cybercom.flags.upgrades = [];
  for(i = 0; i <= 2; i++) {
    self.cybercom.flags.abilities[i] = self getcybercomabilities(i);
    self.cybercom.flags.upgrades[i] = self getcybercomupgrades(i);
  }
}

function updatecybercomflags() {
  self getcybercomflags();
  self.cybercom.ccom_abilities = self cybercom_gadget::getavailableabilities();
  self.cybercom.menu = "AbilityWheel";
  self.pers["cybercom_flags"] = self.cybercom.flags;
}

function setcybercomflags() {
  self setcybercomrigsflags(self.cybercom.flags.tacrigs);
  self setcybercomactivetype(self.cybercom.flags.type);
  for(i = 0; i <= 2; i++) {
    self setcybercomabilityflags(self.cybercom.flags.abilities[i], i);
    self setcybercomupgradeflags(self.cybercom.flags.upgrades[i], i);
  }
}

function setabilitiesbyflags(flags) {
  if(isDefined(flags)) {
    self.cybercom.flags = flags;
  }
  self setcybercomflags();
  self updatecybercomflags();
  foreach(ability in self.cybercom.ccom_abilities) {
    status = self hascybercomability(ability.name);
    if(status == 0) {
      continue;
    }
    self cybercom_gadget::meleeabilitygiven(ability, status == 2);
  }
  foreach(ability in level._cybercom_rig_ability) {
    status = self hascybercomrig(ability.name);
    if(status == 0) {
      continue;
    }
    self cybercom_tacrig::rigabilitygiven(ability.name, status == 2);
  }
}

function function_cc812e3b(var_632e4fca) {
  itemindex = getitemindexfromref(var_632e4fca + "_pro");
  if(itemindex != -1) {
    return self isitempurchased(itemindex);
  }
  return 0;
}

function function_8b088b97(cybercore_type) {
  debugmsg("CYBERCORE: " + cybercore_type);
  abilities = cybercom_gadget::getabilitiesfortype(cybercore_type);
  foreach(ability in abilities) {
    itemindex = getitemindexfromref(ability.name);
    if(self isitempurchased(itemindex)) {
      upgraded = self function_cc812e3b(ability.name);
      self setcybercomability(ability.name, upgraded);
      debugmsg((ability.name + " UPGRADED: ") + upgraded);
      continue;
    }
    debugmsg(ability.name + " NOT INSTALLED");
  }
}

function function_1e4531c7(var_e4230c26) {
  switch (var_e4230c26) {
    case 0: {
      self cybercom_gadget::meleeabilitygiven(cybercom_gadget::getabilitybyname("cybercom_ravagecore"));
      break;
    }
    case 1: {
      self cybercom_gadget::meleeabilitygiven(cybercom_gadget::getabilitybyname("cybercom_rapidstrike"));
      break;
    }
    case 2: {
      self cybercom_gadget::meleeabilitygiven(cybercom_gadget::getabilitybyname("cybercom_es_strike"));
      break;
    }
  }
}

function function_1adaa876(var_e4230c26, var_f4132a83) {
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  var_d66f8a9e = int(self getdstat("PlayerStatsList", "LAST_CYBERCOM_EQUIPPED", "statValue"));
  var_2324b7c = var_d66f8a9e &(1024 - 1);
  var_768ee804 = var_d66f8a9e >> 10;
  self function_1e4531c7(var_e4230c26);
  if(isDefined(var_f4132a83) && var_f4132a83 && var_2324b7c > 99 && var_2324b7c < 142) {
    var_cac3be21 = tablelookup("gamedata/stats/cp/cp_statstable.csv", 0, var_2324b7c, 4);
    var_b5725157 = cybercom_gadget::getabilitybyname(var_cac3be21);
    if(self hascybercomability(var_b5725157.name)) {
      if(var_e4230c26 == var_b5725157.type || self function_6e0bf068() || (isDefined(self.cybercoreselectmenudisabled) && self.cybercoreselectmenudisabled == 1)) {
        self setcybercomactivetype(var_b5725157.type);
        self.var_768ee804 = var_768ee804;
        self cybercom_gadget::equipability(var_b5725157.name, 0);
        self setcontrolleruimodelvalue("AbilityWheel.Selected" + (var_b5725157.type + 1), self.var_768ee804);
        return;
      }
    }
  }
  self clientfield::set_to_player("resetAbilityWheel", 1);
  self setcybercomactivetype(var_e4230c26);
  abilities = cybercom_gadget::getabilitiesfortype(var_e4230c26);
  abilityindex = 1;
  foreach(ability in abilities) {
    if(self hascybercomability(ability.name)) {
      self.var_768ee804 = abilityindex;
      self cybercom_gadget::equipability(ability.name, 0);
      self setcontrolleruimodelvalue("AbilityWheel.Selected" + (ability.type + 1), abilityindex);
      return;
    }
    abilityindex++;
  }
}

function function_6e0bf068() {
  return (self.cur_ranknum + 1) >= 20 || (isDefined(self.var_8201758a) && (isDefined(self.var_8201758a) && self.var_8201758a));
}

function function_674d724c(class_num_for_global_weapons, var_f4132a83, var_f69e782a = 1) {
  self endon("death_or_disconnect");
  if(!isDefined(self.cybercoreselectmenudisabled) || self.cybercoreselectmenudisabled != 1) {
    for(cybercore_type = 0; cybercore_type <= 2; cybercore_type++) {
      self function_8b088b97(cybercore_type);
    }
  }
  var_d1833846["cybercore_control"] = 0;
  var_d1833846["cybercore_martial"] = 1;
  var_d1833846["cybercore_chaos"] = 2;
  var_fb135494 = self getloadoutitemref(0, "cybercore");
  if(var_fb135494 != "weapon_null" && var_fb135494 != "weapon_null_cp" && isDefined(var_d1833846[var_fb135494])) {
    self function_1adaa876(var_d1833846[var_fb135494], var_f4132a83);
    self updatecybercomflags();
  }
  if(var_f69e782a) {
    ret = self util::waittill_any_timeout(7, "loadout_changed");
    if(ret != "timeout") {
      function_674d724c(class_num_for_global_weapons, var_f4132a83, 0);
    }
  }
}

function function_4b8ac464(class_num, class_num_for_global_weapons, var_f4132a83, altplayer) {
  self clearcybercomability();
  rig1 = self getloadoutitemref(class_num, "cybercom_tacrig1");
  rig2 = self getloadoutitemref(class_num, "cybercom_tacrig2");
  if(isDefined(altplayer)) {
    rig1 = altplayer getloadoutitemref(class_num, "cybercom_tacrig1");
    rig2 = altplayer getloadoutitemref(class_num, "cybercom_tacrig2");
  }
  if(strendswith(rig1, "_pro")) {
    rig1 = getsubstr(rig1, 0, rig1.size - 4);
    rig1_upgraded = 1;
  } else {
    rig1_upgraded = 0;
  }
  if(strendswith(rig2, "_pro")) {
    rig2 = getsubstr(rig2, 0, rig2.size - 4);
    rig2_upgraded = 1;
  } else {
    rig2_upgraded = 0;
  }
  if(isDefined(self.var_8201758a) && self.var_8201758a) {
    rig1_upgraded = 1;
    rig2_upgraded = 1;
  } else if(class_num < 5) {
    rig1_upgraded = self function_cc812e3b(rig1);
    rig2_upgraded = self function_cc812e3b(rig2);
    if(isDefined(altplayer)) {
      rig1_upgraded = altplayer function_cc812e3b(rig1);
      rig2_upgraded = altplayer function_cc812e3b(rig2);
    }
  }
  self cybercom_tacrig::takeallrigabilities();
  if(!self flag::exists("in_training_sim") || !self flag::get("in_training_sim")) {
    saved_rig1 = self savegame::get_player_data("saved_rig1", undefined);
    if(isDefined(saved_rig1)) {
      rig1 = saved_rig1;
      rig1_upgraded = self savegame::get_player_data("saved_rig1_upgraded", undefined);
      rig2 = self savegame::get_player_data("saved_rig2", undefined);
      rig2_upgraded = self savegame::get_player_data("saved_rig2_upgraded", undefined);
      assert(isDefined(rig1_upgraded));
    }
  }
  self cybercom_tacrig::giverigability(rig1, rig1_upgraded, 0, 0);
  self cybercom_tacrig::giverigability(rig2, rig2_upgraded, 1, 0);
  if(!self flag::exists("in_training_sim") || !self flag::get("in_training_sim")) {
    self savegame::set_player_data("saved_rig1", rig1);
    self savegame::set_player_data("saved_rig1_upgraded", rig1_upgraded);
    self savegame::set_player_data("saved_rig2", rig2);
    self savegame::set_player_data("saved_rig2_upgraded", rig2_upgraded);
  }
  debugmsg((("RIG1: " + rig1) + " UPGRADED:") + rig1_upgraded);
  debugmsg((("RIG2: " + rig2) + " UPGRADED:") + rig2_upgraded);
  self thread function_674d724c(class_num_for_global_weapons, var_f4132a83);
}

function weaponlockwatcher(slot, weapon, maxlocks) {
  self endon("disconnect");
  self endon("death");
  self cybercom_initentityfields();
  if(!isDefined(self.cybercom.lock_targets)) {
    self.cybercom.lock_targets = [];
  }
  locks = (isDefined(maxlocks) ? maxlocks : getdvarint("scr_max_simLocks"));
  assert(locks <= 5, "");
  self thread function_17fea3ed(slot, weapon, locks);
  self thread function_d4f9f451(slot, weapon);
  self thread function_348de0be(slot, weapon);
}

function function_348de0be(slot, weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("weaponendlockwatcher");
  self endon("ccom_stop_lock_on");
  self notify("hash_348de0be");
  self endon("hash_348de0be");
  if(!isDefined(self.cybercom.var_46483c8f)) {
    return;
  }
  if(self.cybercom.var_46483c8f & 1) {
    self thread function_86113d72("weapon_change");
  }
  if(self.cybercom.var_46483c8f & 2) {
    self thread function_86113d72("reload");
  }
  if(self.cybercom.var_46483c8f & 4) {
    self thread function_86113d72("weapon_fired");
  }
  if(self.cybercom.var_46483c8f & 8) {
    self thread function_86113d72("weapon_melee");
    self thread function_86113d72("melee_end");
  }
  if(self.cybercom.var_46483c8f & 16) {
    self thread function_86113d72("weapon_ads");
  }
  if(self.cybercom.var_46483c8f & 32) {
    self thread function_86113d72("damage");
  }
  self waittill("hash_3b3a12de", reason);
  self function_29bf9dee(undefined, 8);
  self gadgetdeactivate(slot, weapon, 1);
}

function function_86113d72(note) {
  self endon("ccom_stop_lock_on");
  self endon("hash_3b3a12de");
  self waittill(note);
  self notify("hash_3b3a12de", note);
}

function function_d4f9f451(slot, weapon) {
  self notify("hash_d4f9f451");
  self endon("hash_d4f9f451");
  self endon("disconnect");
  self endon("death");
  self endon("weaponendlockwatcher");
  self endon("ccom_stop_lock_on");
  while(true) {
    for(i = 0; i < self.cybercom.lock_targets.size; i++) {
      if(!isDefined(self.cybercom.lock_targets[i].target)) {
        continue;
      }
      if(!isDefined(self.cybercom.lock_targets[i].target.lockon_owner) || self.cybercom.lock_targets[i].target.lockon_owner != self) {
        continue;
      }
      if(isDefined(self.cybercom.lock_targets[i].target.var_1e1a5e6f) && self.cybercom.lock_targets[i].target.var_1e1a5e6f != 1) {
        continue;
      }
      if(isDefined(self.cybercom.var_73d069a7)) {
        function_c5b2f654(self);
        [
          [self.cybercom.var_73d069a7]
        ](slot, weapon);
        return;
      }
    }
    wait(0.05);
  }
}

function weaponendlockwatcher(weapon) {
  self function_a3e55896(weapon);
  waittillframeend();
  weapon_lock_clearslots(1);
  self function_f5799ee1();
  self notify("ccom_stop_lock_on");
}

function function_f5c296aa(weapon) {
  self notify("weaponendlockwatcher");
  self endon("weaponendlockwatcher");
  self endon("ccom_stop_lock_on");
  self waittill("gadget_forced_off", slot, var_188a4cc0);
  if(weapon == var_188a4cc0) {
    self weaponendlockwatcher(weapon);
  } else {
    self thread function_f5c296aa(weapon);
  }
}

function private _lock_fired_watcher(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("ccom_stop_lock_on");
  event = self util::waittill_any_return(weapon.name + "_fired");
  level notify("ccom_lock_fired", self, weapon);
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target)) {
      item.target notify("ccom_lock_fired", self, weapon);
      if(isDefined(item.target.lockon_owner) && item.target.lockon_owner == self) {
        item.target.lockon_owner = undefined;
      }
    }
  }
  self weaponendlockwatcher(weapon);
}

function private _lock_sighttest(target, var_b3464abe = 1) {
  eyepos = self getEye();
  if(!isDefined(target)) {
    return 0;
  }
  if(!isalive(target)) {
    return 0;
  }
  if(target isragdoll()) {
    return 0;
  }
  if(!isDefined(target.cybercom)) {
    target.cybercom = spawnStruct();
  }
  if(!isDefined(target.cybercom.var_8d2f4636)) {
    target.cybercom.var_8d2f4636 = [];
  }
  pos = target getshootatpos();
  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if(passed) {
      target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
      return 1;
    }
  }
  pos = target getcentroid();
  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if(passed) {
      target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
      return 1;
    }
  }
  if(var_b3464abe) {
    mins = target getmins();
    maxs = target getmaxs();
    var_d11e725f = (maxs[2] - mins[2]) / 4;
    for(i = 0; i <= 4; i++) {
      pos = target.origin + (0, 0, var_d11e725f * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
      if(passed) {
        target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
        return 1;
      }
      pos = target.origin + (mins[0], mins[1], var_d11e725f * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
      if(passed) {
        target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
        return 1;
      }
      pos = target.origin + (maxs[0], maxs[1], var_d11e725f * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
      if(passed) {
        target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
        return 1;
      }
    }
    var_cb365fdc = target.cybercom.var_8d2f4636[self getentitynumber()];
    if(isDefined(var_cb365fdc) && (var_cb365fdc + getdvarint("scr_los_latency", 3000)) > gettime()) {
      trace = bulletTrace(eyepos, pos, 0, target);
      distsq = distancesquared(pos, trace["position"]);
      if(distsq <= (getdvarint("scr_cached_dist_threshhold", 315 * 315))) {
        return 2;
      }
      return 0;
    }
  }
  return 0;
}

function targetisvalid(target, weapon, lockreq = 1) {
  result = 1;
  if(!isDefined(target)) {
    return 0;
  }
  if(!isalive(target)) {
    return 0;
  }
  if(target isragdoll()) {
    return 0;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    return 0;
  }
  if(!(isDefined(target.takedamage) && target.takedamage)) {
    return 0;
  }
  if(isDefined(target._ai_melee_opponent)) {
    return 0;
  }
  if(isactor(target) && (!target isonground() || isDefined(target.traversestartnode))) {
    return 0;
  }
  if(isDefined(target.cybercomtargetstatusoverride)) {
    if(target.cybercomtargetstatusoverride == 0) {
      return 0;
    }
  } else {
    if(isDefined(target.magic_bullet_shield) && target.magic_bullet_shield) {
      return 0;
    }
    if(isactor(target) && target isinscriptedstate()) {
      if(isDefined(self.rider_info)) {
        if(isDefined(self.rider_info.position) && issubstr(self.rider_info.position, "gunner")) {
          return 1;
        }
      }
    }
    if(isDefined(target.allowdeath) && !target.allowdeath) {
      return 0;
    }
  }
  if(lockreq && isDefined(self.cybercom) && isDefined(self.cybercom.targetlockrequirementcb)) {
    result = self[[self.cybercom.targetlockrequirementcb]](target);
  }
  if(result && isDefined(level.var_732e9c7d)) {
    result = result &[[level.var_732e9c7d]](self, target, weapon);
  }
  if(isDefined(target.var_fb7ce72a)) {
    temp_result = target[[target.var_fb7ce72a]](self, weapon);
    if(isDefined(temp_result)) {
      return temp_result;
    }
  }
  return result;
}

function weapon_lock_meetsrangerequirement(target, maxrange, weapon) {
  if(isDefined(target.var_fb7ce72a)) {
    var_a3ded052 = target[[target.var_fb7ce72a]](self, weapon);
    if(isDefined(var_a3ded052)) {
      return var_a3ded052;
    }
  }
  if(isDefined(maxrange)) {
    distancesqr = distancesquared(target.origin, self.origin);
    if(distancesqr > (maxrange * maxrange)) {
      return 0;
    }
  }
  return 1;
}

function weapon_lock_meetsrequirement(target, radius, weapon, maxrange) {
  result = 1;
  if(isDefined(target.var_fb7ce72a)) {
    var_a3ded052 = target[[target.var_fb7ce72a]](self, weapon);
    if(isDefined(var_a3ded052)) {
      return var_a3ded052;
    }
  }
  isvalid = self targetisvalid(target, weapon);
  if(!(isDefined(isvalid) && isvalid)) {
    self function_29bf9dee(target, 1);
    return 0;
  }
  if(isDefined(maxrange)) {
    distancesqr = distancesquared(target.origin, self.origin);
    if(distancesqr > (maxrange * maxrange)) {
      self function_29bf9dee(target, 3);
      return 0;
    }
  }
  var_edc325e = self _lock_sighttest(target);
  if(var_edc325e == 0) {
    self function_29bf9dee(target, 5);
    return 0;
  }
  if(var_edc325e == 2) {
    radius = radius * 2;
  }
  if(isDefined(radius)) {
    distsq = distancesquared(self.origin, target.origin);
    if(distsq > (144 * 144)) {
      result = target_isincircle(target, self, 65, radius);
    }
  }
  if(result == 0) {
    self function_29bf9dee(target, 1);
  }
  return result;
}

function targetinsertionsortcompare(a, b) {
  if(a.dot < b.dot) {
    return -1;
  }
  if(a.dot > b.dot) {
    return 1;
  }
  return 0;
}

function function_18d9de78(target) {
  if(isDefined(target.lockon_owner) && target.lockon_owner == self) {
    function_c5b2f654(self);
    target.var_6c8af4c4 = gettime() - target.var_9d876bed;
    target thread function_5ad57748();
    target.var_9d876bed = undefined;
    target.var_87aa3c26 = gettime() + 150;
    target.lockon_owner = undefined;
    target.var_9d876bed = undefined;
    target.var_1e1a5e6f = undefined;
    self notify("hash_9641f650");
    self notify("ccom_lost_lock", target);
  }
}

function weapon_lock_clearslot(slot, note, clearprogress) {
  if(isDefined(self.cybercom.lock_targets[slot])) {
    item = self.cybercom.lock_targets[slot];
    if(isDefined(item.target)) {
      if(isDefined(note)) {
        item.target notify(note);
      }
      self weaponlocknoclearance(0, item.lockslot);
      self weaponlockremoveslot(item.lockslot);
      if(isDefined(clearprogress) && clearprogress) {
        self function_18d9de78(item.target);
      }
      item.target = undefined;
    }
  }
}

function private _weapon_lock_targetwatchfordeath(player) {
  self endon("ccom_lost_lock");
  self notify("_weapon_lock_targetwatchfordeath");
  self endon("_weapon_lock_targetwatchfordeath");
  slot = player weapon_lock_alreadylocked(self);
  self util::waittill_any("death", "ccom_lock_fired", "ccom_lock_aborted_unique");
  player weaponlocknoclearance(0, slot);
  player weaponlockremoveslot(slot);
}

function weapon_lock_settargettoslot(slot, target, maxrange, weapon) {
  if(slot == -1 || slot >= getdvarint("scr_max_simLocks")) {
    return;
  }
  if(isDefined(target.var_87aa3c26) && gettime() < target.var_87aa3c26) {
    return;
  }
  if(isDefined(self.cybercom.lock_targets[slot])) {
    self weapon_lock_clearslot(slot, "ccom_lost_lock");
    newitem = self.cybercom.lock_targets[slot];
    newitem.target = target;
  } else {
    newitem = spawnStruct();
    newitem.target = target;
    newitem.lockslot = slot;
    self.cybercom.lock_targets[slot] = newitem;
  }
  if(isDefined(newitem.target)) {
    if(isDefined(newitem.target.var_9147087d) && isDefined(newitem.target.var_9147087d[self.cybercom.lastequipped.name])) {
      if(!isDefined(newitem.target.lockon_owner)) {
        newitem.target.var_9d876bed = gettime() - newitem.target.var_6c8af4c4;
        newitem.target.lockon_owner = self;
        newitem.target notify("hash_1bf7ef5");
        var_9df7c303 = newitem.target.var_6c8af4c4 / (newitem.target.var_9147087d[self.cybercom.lastequipped.name] * 1000);
        function_eae88e7f(self, newitem.target.var_9147087d[self.cybercom.lastequipped.name], var_9df7c303);
        level thread function_9641f650(self);
      }
      if(isDefined(newitem.target.lockon_owner) && newitem.target.lockon_owner == self) {
        newitem.target.var_1e1a5e6f = math::clamp((gettime() - newitem.target.var_9d876bed) / (newitem.target.var_9147087d[self.cybercom.lastequipped.name] * 1000), 0, 1);
      }
    }
    self weaponlockstart(newitem.target, newitem.lockslot);
    newitem.inrange = 1;
    if(!self weapon_lock_meetsrangerequirement(newitem.target, maxrange, weapon)) {
      newitem.inrange = 0;
      self weaponlocknoclearance(1, slot);
    }
    if(isDefined(newitem.target.var_1e1a5e6f)) {
      if(newitem.target.lockon_owner == self) {
        if(newitem.target.var_1e1a5e6f != 1) {
          newitem.inrange = 2;
          self weaponlocknoclearance(1, slot);
        }
      } else {
        newitem.inrange = 0;
        self weaponlocknoclearance(1, slot);
      }
    }
    if(newitem.inrange == 1) {
      function_c5b2f654(self);
      self weaponlocknoclearance(0, slot);
      self weaponlockfinalize(newitem.target, newitem.lockslot);
      newitem.target notify("ccom_locked_on", self);
      level notify("ccom_locked_on", newitem.target, self);
    } else {
      newitem.target notify("ccom_lock_being_targeted", self);
      level notify("ccom_lock_being_targeted", newitem.target, self);
    }
    newitem.target thread _weapon_lock_targetwatchfordeath(self);
  }
}

function function_eae88e7f(hacker, duration, startratio) {
  val = duration & 31;
  if(startratio > 0) {
    cur = math::clamp(startratio, 0, 1);
    offset = (int(cur * 128)) << 5;
    val = val + offset;
  }
  hacker clientfield::set_to_player("hacking_progress", val);
  hacker clientfield::set_to_player("sndCCHacking", 1);
}

function function_c5b2f654(hacker) {
  if(isDefined(hacker)) {
    hacker clientfield::set_to_player("hacking_progress", 0);
    hacker clientfield::set_to_player("sndCCHacking", 0);
  }
}

function function_9641f650(hacker) {
  hacker endon("disconnect");
  hacker notify("hash_9641f650");
  hacker endon("hash_9641f650");
  hacker util::waittill_any("death", "ccom_lockOnProgress_Cleared", "ccom_lost_lock", "ccom_locked_on");
  function_c5b2f654(hacker);
}

function weapon_lock_alreadylocked(target) {
  for(i = 0; i < self.cybercom.lock_targets.size; i++) {
    if(!isDefined(self.cybercom.lock_targets[i].target)) {
      continue;
    }
    if(self.cybercom.lock_targets[i].target == target) {
      return i;
    }
  }
  return -1;
}

function weapon_lock_getlockedontargets() {
  targets = [];
  for(i = 0; i < self.cybercom.lock_targets.size; i++) {
    if(!isDefined(self.cybercom.lock_targets[i].target)) {
      continue;
    }
    targets[targets.size] = self.cybercom.lock_targets[i].target;
  }
  return targets;
}

function weapon_lock_getslot(target, force = 0) {
  if(self.cybercom.lock_targets.size < getdvarint("scr_max_simLocks")) {
    return self.cybercom.lock_targets.size;
  }
  alreadyinslot = self weapon_lock_alreadylocked(target);
  if(alreadyinslot != -1) {
    return alreadyinslot;
  }
  slot = -1;
  playerforward = anglesToForward(self getplayerangles());
  dots = [];
  for(i = 0; i < self.cybercom.lock_targets.size; i++) {
    locktarget = self.cybercom.lock_targets[i].target;
    if(!isDefined(locktarget)) {
      return i;
    }
    newitem = spawnStruct();
    newitem.dot = vectordot(playerforward, vectornormalize(locktarget.origin - self.origin));
    var_f72b478f = (isDefined(self.cybercom.var_f72b478f) ? self.cybercom.var_f72b478f : 0.83);
    if(newitem.dot > var_f72b478f) {
      newitem.target = locktarget;
      array::insertion_sort(dots, &targetinsertionsortcompare, newitem);
    }
  }
  newitem = spawnStruct();
  newitem.dot = vectordot(playerforward, vectornormalize(target.origin - self.origin));
  newitem.target = target;
  array::insertion_sort(dots, &targetinsertionsortcompare, newitem);
  worsttarget = dots[dots.size - 1].target;
  if(!force && worsttarget == target) {
    return -1;
  }
  return self weapon_lock_alreadylocked(worsttarget);
}

function weapon_lock_clearslots(clearprogress = 0) {
  if(isDefined(self.cybercom) && isDefined(self.cybercom.lock_targets)) {
    for(i = 0; i < self.cybercom.lock_targets.size; i++) {
      self weapon_lock_clearslot(i, undefined, clearprogress);
    }
  }
  self weaponlockremoveslot(-1);
  self.cybercom.lock_targets = [];
}

function function_b5f4e597(weapon) {
  self endon("disconnect");
  self notify("hash_b5f4e597");
  self endon("hash_b5f4e597");
  if(weapon.requirelockontofire) {
    maxrange = 1500;
    if(isDefined(weapon.lockonmaxrange)) {
      maxrange = weapon.lockonmaxrange;
    }
    maxrangesqr = maxrange * maxrange;
  } else {
    maxrangesqr = 0;
  }
  var_6f023b72 = 0;
  while(self hasweapon(weapon)) {
    if(maxrangesqr > 0) {
      if(isDefined(self.cybercom.targetlockcb)) {
        enemies = self[[self.cybercom.targetlockcb]](weapon);
      } else {
        enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
      }
      foreach(enemy in enemies) {
        distsq = distancesquared(self.origin, enemy.origin);
        if(distsq > maxrangesqr) {
          continue;
        }
        var_b766574c = self.cybercom.var_b766574c;
        var_42d20903 = self.cybercom.var_42d20903;
        if(!targetisvalid(enemy, weapon)) {
          self.cybercom.var_b766574c = var_b766574c;
          self.cybercom.var_42d20903 = var_42d20903;
          continue;
        }
        var_6f023b72 = 1;
        break;
      }
    } else {
      var_6f023b72 = 1;
    }
    self clientfield::set_player_uimodel("playerAbilities.inRange", var_6f023b72);
    wait(0.05);
  }
  var_6f023b72 = 0;
  self clientfield::set_player_uimodel("playerAbilities.inRange", var_6f023b72);
}

function function_5ad57748() {
  self endon("death");
  self notify("hash_5ad57748");
  self endon("hash_5ad57748");
  self endon("hash_1bf7ef5");
  var_82361971 = int((getdvarfloat("scr_hacktime_decay_rate", 0.25) / 20) * 1000);
  while(self.var_6c8af4c4 > 0) {
    wait(0.05);
    self.var_6c8af4c4 = self.var_6c8af4c4 - var_82361971;
    if(self.var_6c8af4c4 < 0) {
      self.var_6c8af4c4 = 0;
    }
  }
}

function function_f5799ee1() {
  if(!isDefined(self.cybercom.var_4eb8cd67) || self.cybercom.var_4eb8cd67.size == 0) {
    return;
  }
  var_4eb8cd67 = [];
  foreach(target in self.cybercom.var_4eb8cd67) {
    if(!isDefined(target)) {
      continue;
    }
    found = 0;
    if(self.cybercom.lock_targets.size) {
      foreach(var_9ddde835 in self.cybercom.lock_targets) {
        if(!isDefined(var_9ddde835.target)) {
          continue;
        }
        if(var_9ddde835.target == target) {
          found = 1;
          break;
        }
      }
    }
    if(!found) {
      target notify("ccom_lost_lock", self);
      level notify("ccom_lost_lock", target, self);
      self function_18d9de78(target);
      continue;
    }
    var_4eb8cd67[var_4eb8cd67.size] = target;
  }
  self.cybercom.var_4eb8cd67 = var_4eb8cd67;
}

function function_17fea3ed(slot, weapon, maxtargets) {
  self notify("ccom_stop_lock_on");
  self endon("ccom_stop_lock_on");
  self endon("weapon_change");
  self endon("disconnect");
  self endon("death");
  radius = (isDefined(self.cybercom.var_23d4a73a) ? self.cybercom.var_23d4a73a : 130);
  if(!isDefined(maxtargets)) {
    maxtargets = 3;
  }
  self thread _lock_fired_watcher(weapon);
  self thread function_f5c296aa(weapon);
  if(maxtargets < 1) {
    maxtargets = 1;
  }
  if(maxtargets > 5) {
    maxtargets = 5;
  }
  maxrange = 1500;
  if(isDefined(weapon.lockonmaxrange)) {
    maxrange = weapon.lockonmaxrange;
  }
  validtargets = [];
  dots = [];
  while(self hasweapon(weapon)) {
    wait(0.05);
    self function_f5799ee1();
    self weapon_lock_clearslots();
    self.cybercom.var_b766574c = 0;
    if(isDefined(self.cybercom.targetlockcb)) {
      enemies = self[[self.cybercom.targetlockcb]](weapon);
    } else {
      enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    }
    if(enemies.size == 0) {
      self function_29bf9dee(undefined, 1);
    }
    var_ab2554ab = [];
    playerforward = anglesToForward(self getplayerangles());
    var_6f14dd02 = self gettagorigin("tag_aim");
    foreach(enemy in enemies) {
      center = enemy getcentroid();
      dirtotarget = vectornormalize(center - var_6f14dd02);
      enemy.var_4ddba9ea = vectordot(dirtotarget, playerforward);
      if(isDefined(enemy.var_fb7ce72a)) {
        result = enemy[[enemy.var_fb7ce72a]](self, weapon);
        if(isDefined(result) && result) {
          var_ab2554ab[var_ab2554ab.size] = enemy;
          continue;
        }
      }
      var_f72b478f = (isDefined(self.cybercom.var_f72b478f) ? self.cybercom.var_f72b478f : 0.83);
      if(enemy.var_4ddba9ea > var_f72b478f) {
        var_ab2554ab[var_ab2554ab.size] = enemy;
      }
    }
    if(var_ab2554ab.size == 0) {
      self function_29bf9dee(undefined, 1);
      continue;
    }
    validtargets = [];
    potentialtargets = [];
    foreach(enemy in var_ab2554ab) {
      if(!isDefined(enemy)) {
        continue;
      }
      if(!self weapon_lock_meetsrequirement(enemy, radius, weapon, maxrange)) {
        continue;
      }
      validtargets[validtargets.size] = enemy;
    }
    var_304647c9 = dots.size;
    dots = [];
    foreach(target in validtargets) {
      newitem = spawnStruct();
      newitem.dot = target.var_4ddba9ea;
      newitem.target = target;
      array::insertion_sort(dots, &targetinsertionsortcompare, newitem);
    }
    if(dots.size) {
      i = 0;
      foreach(item in dots) {
        i++;
        if(i > maxtargets) {
          break;
        }
        if(isDefined(item.target)) {
          if(isDefined(item.target.var_ced13b2f) && item.target.var_ced13b2f && self weapon_lock_alreadylocked(item.target) == -1) {
            foreach(other in self.cybercom.var_4eb8cd67) {
              if(other == item.target) {
                continue;
              }
              if(isDefined(other.var_ced13b2f) && other.var_ced13b2f) {
                item.target = undefined;
                break;
              }
            }
          }
          if(!isDefined(item.target)) {
            continue;
          }
          if(self weapon_lock_alreadylocked(item.target) != -1) {
            continue;
          }
          slot = self weapon_lock_getslot(item.target);
          if(slot == -1) {
            continue;
          }
          if(!isinarray(self.cybercom.var_4eb8cd67, item.target)) {
            self.cybercom.var_4eb8cd67[self.cybercom.var_4eb8cd67.size] = item.target;
          }
          self weapon_lock_settargettoslot(slot, item.target, maxrange, weapon);
        }
      }
      self playrumbleonentity("damage_light");
    }
  }
  self notify("ccom_stop_lock_on");
}

function draworiginforever() {
  self endon("death");
  for(;;) {
    debug_arrow(self.origin, self.angles);
    wait(0.05);
  }
}

function debug_arrow(org, ang, opcolor) {
  forward = anglesToForward(ang);
  forwardfar = vectorscale(forward, 50);
  forwardclose = vectorscale(forward, 50 * 0.8);
  right = anglestoright(ang);
  leftdraw = vectorscale(right, 50 * -0.2);
  rightdraw = vectorscale(right, 50 * 0.2);
  up = anglestoup(ang);
  right = vectorscale(right, 50);
  up = vectorscale(up, 50);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);
  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }
  line(org, org + forwardfar, red, 0.9);
  line(org + forwardfar, (org + forwardclose) + rightdraw, red, 0.9);
  line(org + forwardfar, (org + forwardclose) + leftdraw, red, 0.9);
  line(org, org + right, blue, 0.9);
  line(org, org + up, green, 0.9);
}

function debug_circle(origin, radius, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }
  frames = int(20 * seconds);
  circle(origin, radius, color, 0, 1, frames);
}

function getclosestto(origin, entarray, max) {
  if(!isDefined(entarray)) {
    return;
  }
  if(entarray.size == 0) {
    return;
  }
  arraysortclosest(entarray, origin, 1, 0, (isDefined(max) ? max : 2048));
  return entarray[0];
}

function cybercom_aioptoutgetflag(name) {
  ability = cybercom_gadget::getabilitybyname(name);
  if(isDefined(ability)) {
    shift = 8 * ability.type;
    return ability.flag << shift;
  }
  if(isDefined(level._cybercom_rig_ability[name])) {
    return 1 << (24 + level._cybercom_rig_ability[name].type);
  }
}

function function_58c312f2() {
  if(!isDefined(self)) {
    return;
  }
  self cybercom_initentityfields();
  foreach(ability in level.cybercom.abilities) {
    if(!isDefined(ability)) {
      continue;
    }
    flag = cybercom_aioptoutgetflag(ability.name);
    if(isDefined(flag)) {
      self.cybercom.optoutflags = self.cybercom.optoutflags | flag;
    }
  }
}

function cybercom_aioptout(name) {
  if(!isDefined(self)) {
    return;
  }
  flag = cybercom_aioptoutgetflag(name);
  if(!isDefined(flag)) {
    return;
  }
  self cybercom_initentityfields();
  self.cybercom.optoutflags = self.cybercom.optoutflags | flag;
}

function cybercom_aiclearoptout(name) {
  if(!isDefined(self)) {
    return;
  }
  self cybercom_initentityfields();
  flag = cybercom_aioptoutgetflag(name);
  if(!isDefined(flag)) {
    return;
  }
  self.cybercom.optoutflags = self.cybercom.optoutflags &(~flag);
}

function cybercom_aicheckoptout(name) {
  if(!isDefined(self)) {
    return false;
  }
  if(isDefined(self.nocybercom) && self.nocybercom) {
    return true;
  }
  self cybercom_initentityfields();
  flag = cybercom_aioptoutgetflag(name);
  if(!isDefined(flag)) {
    return false;
  }
  if(self.cybercom.optoutflags &flag) {
    return true;
  }
  return false;
}

function cybercom_initentityfields() {
  if(!isDefined(self.cybercom)) {
    self.cybercom = spawnStruct();
  }
  if(!isDefined(self.cybercom.optoutflags)) {
    self.cybercom.optoutflags = 0;
  }
}

function notifymeonmatchend(note, animname) {
  self endon(note);
  self endon("death");
  self waittillmatch(animname);
  self notify(note, "end");
}

function stopanimscriptedonnotify(note, animname, kill = 0, attacker, weapon) {
  self notify(("stopOnNotify" + note) + animname);
  self endon(("stopOnNotify" + note) + animname);
  if(isDefined(animname)) {
    self thread notifymeonmatchend(("stopOnNotify" + note) + animname, animname);
  }
  self util::waittill_any_return(note, "death");
  if(isDefined(self) && self isinscriptedstate()) {
    self stopanimscripted(0.3);
  }
  if(isalive(self) && (isDefined(kill) && kill)) {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
  }
}

function function_421746e0() {
  if(isDefined(self.allowdeath)) {
    if(self.allowdeath == 0) {
      return false;
    }
  }
  if(isDefined(self.var_770a8906) && self.var_770a8906) {
    return true;
  }
  if(isDefined(self.rider_info)) {
    return true;
  }
  if(isDefined(self.archetype) && self.archetype == "robot" && !function_76e3026d(self)) {
    return true;
  }
  if(isactor(self) && !self isonground()) {
    return true;
  }
  return false;
}

function islinked() {
  return isDefined(self getlinkedent());
}

function function_8257bcb3(context, max = 2) {
  if(!isDefined(self.cybercom.variants)) {
    self.cybercom.variants = [];
  }
  if(isDefined(self.cybercom.variants[context])) {
    self.cybercom.variants[context] = undefined;
  }
  self.cybercom.variants[context] = spawnStruct();
  self.cybercom.variants[context].var_9689b47c = 0;
  self.cybercom.variants[context].var_51b4aeb8 = max;
}

function getanimationvariant(context) {
  if(!isDefined(self.cybercom) || !isDefined(self.cybercom.variants) || !isDefined(self.cybercom.variants[context])) {
    return "";
  }
  cur = self.cybercom.variants[context].var_9689b47c;
  self.cybercom.variants[context].var_9689b47c++;
  if(self.cybercom.variants[context].var_9689b47c > self.cybercom.variants[context].var_51b4aeb8) {
    self.cybercom.variants[context].var_9689b47c = 0;
  }
  if(cur == 0) {
    return "";
  }
  return "_" + cur;
}

function debug_box(origin, mins, maxs, yaw = 0, frames = 20, color = (1, 0, 0)) {
  box(origin, mins, maxs, yaw, color, 1, 0, frames);
}

function debug_sphere(origin, radius, color = (1, 0, 0), alpha = 0.1, timeframes = 1) {
  sides = int(10 * (1 + (int(radius) % 100)));
  sphere(origin, radius, color, alpha, 1, sides, timeframes);
}

function notifymeinnsec(note, seconds) {
  self endon(note);
  self endon("death");
  wait(seconds);
  self notify(note);
}

function notifymeonnote(note, waitnote) {
  self endon(note);
  self endon("death");
  self waittill(waitnote);
  self notify(note);
}

function deleteentonnote(note, ent) {
  ent endon("death");
  self waittill(note);
  if(isDefined(ent)) {
    ent delete();
  }
}

function cybercom_armpulse(e_pulse_type) {
  clientfield::increment("cyber_arm_pulse", e_pulse_type);
}

function function_78525729() {
  assert(isactor(self), "");
  return blackboard::getblackboardattribute(self, "_stance");
}

function function_5e3d3aa() {
  assert(isactor(self), "");
  stance = self function_78525729();
  if(stance == "stand") {
    return "stn";
  }
  if(stance == "crouch") {
    return "crc";
  }
  return "";
}

function debugmsg(txt) {
  println("" + txt);
}

function function_76e3026d(entity) {
  if(isDefined(entity.missinglegs) && entity.missinglegs) {
    return false;
  }
  if(isDefined(entity.iscrawler) && entity.iscrawler) {
    return false;
  }
  return true;
}

function function_c3c6aff4(slot, weapon, var_ecc9d566, endnote) {
  self endon("death");
  self endon(endnote);
  self waittill(var_ecc9d566);
  self gadgetdeactivate(slot, weapon);
}

function function_adc40f11(weapon, fired) {
  if(fired) {
    self notify(weapon.name + "_fired");
    level notify(weapon.name + "_fired");
    self notify("hash_81c0052c", weapon);
    bb::logcybercomevent(self, "fired", weapon);
    self gadgettargetresult(1);
  } else {
    self gadgettargetresult(0);
    self notify("hash_2bc5d416", weapon);
  }
}

function function_a3e55896(weapon) {
  if(self.cybercom.var_b766574c != 0 && (self.cybercom.lock_targets.size == 0 || self.cybercom.var_b766574c == 8)) {
    if(self.cybercom.var_b766574c == 2 && isDefined(self.cybercom.var_42d20903)) {
      var_edc325e = self _lock_sighttest(self.cybercom.var_42d20903, 0);
      if(var_edc325e == 0) {
        self.cybercom.var_b766574c = 1;
      }
    }
    switch (self.cybercom.var_b766574c) {
      case 2: {
        self settargetwrongtypehint(weapon);
        break;
      }
      case 3: {
        self settargetoorhint(weapon);
        break;
      }
      case 4: {
        self settargetalreadyinusehint(weapon);
        break;
      }
      case 1: {
        self setnotargetshint(weapon);
        break;
      }
      case 5: {
        self setnolosontargetshint(weapon);
        break;
      }
      case 6: {
        self setdisabledtargethint(weapon);
        break;
      }
      case 7: {
        self settargetalreadytargetedhint(weapon);
        break;
      }
      case 8: {
        self settargetingabortedhint(weapon);
        break;
      }
    }
    level notify("hash_dce473f9", self, self.cybercom.var_b766574c);
    self notify("hash_dce473f9", self.cybercom.var_b766574c);
    self.cybercom.var_b766574c = 0;
  }
}

function function_29bf9dee(var_42d20903, var_b766574c, var_10853dc3 = 1, priority = 1) {
  if(!isplayer(self) || !isDefined(self.cybercom)) {
    return;
  }
  if(var_10853dc3 && (!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed))) {
    return;
  }
  if(!(isDefined(self.cybercom.var_8967863e) && self.cybercom.var_8967863e)) {
    return;
  }
  if(priority) {
    if(var_b766574c > self.cybercom.var_b766574c) {
      self.cybercom.var_b766574c = var_b766574c;
      self.cybercom.var_42d20903 = var_42d20903;
    }
  } else {
    self.cybercom.var_b766574c = var_b766574c;
    self.cybercom.var_42d20903 = var_42d20903;
  }
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function function_5ad6b98d(eattacker, eplayer, idamage) {
  if(!isplayer(eplayer) || !isDefined(eattacker) || !isDefined(eattacker.aitype)) {
    return idamage;
  }
  if(!isDefined(eplayer.cybercom.var_5e76d31b) || !eplayer.cybercom.var_5e76d31b) {
    return idamage;
  }
  var_31dd08f5 = level.var_e4e6dd84[eattacker.aitype];
  if(!isDefined(var_31dd08f5)) {
    var_31dd08f5 = level.var_e4e6dd84["default"];
  }
  damage_scale = 1;
  distancetoplayer = distance(eattacker.origin, eplayer.origin);
  if(distancetoplayer < 750) {
    damage_scale = var_31dd08f5.var_974cd16f;
  } else {
    if(distancetoplayer < 1500) {
      damage_scale = var_31dd08f5.var_e909f6f0;
    } else {
      damage_scale = var_31dd08f5.var_3d1b9c0c;
    }
  }
  return idamage * damage_scale;
}

function function_1be27df7() {
  if(isDefined(self.currentweapon) && (self.currentweapon == getweapon("gadget_unstoppable_force") || self.currentweapon == getweapon("gadget_unstoppable_force_upgraded"))) {
    return true;
  }
  return false;
}