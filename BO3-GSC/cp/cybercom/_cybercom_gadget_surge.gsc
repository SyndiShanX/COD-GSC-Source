/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_surge.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_gadget_system_overload;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace cybercom_gadget_surge;

function init() {}

function main() {
  cybercom_gadget::registerability(0, 8);
  level.cybercom.surge = spawnStruct();
  level.cybercom.surge._is_flickering = & _is_flickering;
  level.cybercom.surge._on_flicker = & _on_flicker;
  level.cybercom.surge._on_give = & _on_give;
  level.cybercom.surge._on_take = & _on_take;
  level.cybercom.surge._on_connect = & _on_connect;
  level.cybercom.surge._on = & _on;
  level.cybercom.surge._off = & _off;
  level.cybercom.surge._is_primed = & _is_primed;
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = getdvarint("scr_surge_target_count", 1);
  self.cybercom.targetlockcb = & _get_valid_targets;
  self.cybercom.targetlockrequirementcb = & _lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self thread _activate_surge(slot, weapon);
  self _off(slot, weapon);
}

function _off(slot, weapon) {
  self thread cybercom::weaponendlockwatcher(weapon);
  self.cybercom.is_primed = undefined;
}

function _is_primed(slot, weapon) {
  if(!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed)) {
    assert(self.cybercom.activecybercomweapon == weapon);
    self thread cybercom::weaponlockwatcher(slot, weapon, getdvarint("scr_surge_target_count", 1));
    self.cybercom.is_primed = 1;
  }
}

function private _lock_requirement(target, secondary = 0) {
  if(target cybercom::cybercom_aicheckoptout("cybercom_surge")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  if(isactor(target) && target cybercom::function_78525729() != "stand" && target cybercom::function_78525729() != "crouch") {
    return false;
  }
  if(isactor(target) && target.archetype != "robot") {
    if(target.archetype == "human" && (isDefined(secondary) && secondary)) {} else {
      self cybercom::function_29bf9dee(target, 2);
      return false;
    }
  }
  if(!isactor(target) && !isvehicle(target)) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isvehicle(target)) {
    if(!isDefined(target.archetype)) {
      self cybercom::function_29bf9dee(target, 2);
      return false;
    }
    switch (target.archetype) {
      case "amws":
      case "pamws":
      case "raps":
      case "turret":
      case "wasp": {
        break;
      }
      default: {
        self cybercom::function_29bf9dee(target, 2);
        return false;
      }
    }
  }
  if(isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
    return false;
  }
  return true;
}

function private _get_valid_targets(weapon) {
  return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

function private _activate_surge(slot, weapon) {
  upgraded = self hascybercomability("cybercom_surge") == 2;
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        self thread challenges::function_96ed590f("cybercom_uses_control");
        item.target thread _surge(upgraded, 0, self, weapon);
        fired++;
        continue;
      }
      if(item.inrange == 2) {
        aborted++;
      }
    }
  }
  if(aborted && !fired) {
    self.cybercom.lock_targets = [];
    self cybercom::function_29bf9dee(undefined, 1, 0);
  }
  cybercom::function_adc40f11(weapon, fired);
  if(fired && isplayer(self)) {
    itemindex = getitemindexfromref("cybercom_surge");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function private _surge_vehicle(upgraded = 0, secondary = 0, attacker) {
  self endon("death");
  self.ignoreall = 1;
  self clientfield::set("cybercom_surge", (upgraded ? 2 : 1));
  if(!upgraded) {
    radiusdamage(self.origin, 128, 300, 100, self, "MOD_EXPLOSIVE");
    if(isalive(self)) {
      self kill();
    }
  } else {
    if(self.archetype == "turret") {
      radiusdamage(self.origin, 128, 300, 100, self, "MOD_EXPLOSIVE");
      if(isalive(self)) {
        self kill();
      }
      return;
    }
    self notify("surge", attacker);
  }
}

function private _surge(upgraded = 0, secondary = 0, attacker, weapon) {
  self endon("death");
  self notify("hash_f8c5dd60", weapon, attacker);
  weapon = getweapon("gadget_surge");
  if(isvehicle(self)) {
    self thread _surge_vehicle(upgraded, secondary, attacker);
    return;
  }
  self.ignoreall = 1;
  self.is_disabled = 1;
  self.health = self.maxhealth;
  if(self.archetype == "human" || self ai::get_behavior_attribute("rogue_control") != "level_3") {
    self clientfield::set("cybercom_surge", (upgraded ? 2 : 1));
  }
  if(self cybercom::function_421746e0() || self.archetype == "human") {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
    return;
  }
  self function_e4f42bf7(attacker, weapon, getdvarfloat("scr_surge_react_time", 0.45));
  self clearforcedgoal();
  self useposition(self.origin);
  if(upgraded) {
    self clientfield::set("cybercom_setiffname", 2);
    self ai::set_behavior_attribute("rogue_allow_pregib", 0);
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    self ai::set_behavior_attribute("rogue_control", "level_3");
    self.team = "allies";
    self clientfield::set("robot_mind_control", 0);
    self clientfield::set("robot_lights", 3);
    self.tokubetsukogekita = 1;
    self.goalradius = 32;
    comrades = _get_valid_targets();
    arrayremovevalue(comrades, self);
    target = self _tryfindpathtobest(comrades);
    if(isDefined(target)) {
      self thread function_a405f422();
      self thread function_b8a5c1a6();
      while(isDefined(target) && (!(isDefined(self.var_b92dd31d) && self.var_b92dd31d))) {
        self useposition(getclosestpointonnavmesh(target.origin, 200));
        wait(0.05);
      }
    }
  }
  self thread function_2a105d32(attacker);
}

function function_e4f42bf7(attacker, weapon, var_a360d6f5) {
  self endon("hash_147d6ee");
  self endon("death");
  self thread function_c1b2cc5a(var_a360d6f5);
  self dodamage(2, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
  self waittillmatch("bhtn_action_terminate");
  self notify("hash_a738dd0", "specialpain");
}

function function_c1b2cc5a(var_a360d6f5) {
  self endon("hash_a738dd0");
  self endon("death");
  wait(var_a360d6f5);
  self notify("hash_147d6ee");
}

function function_b8a5c1a6(attacker) {
  self endon("hash_2a105d32");
  self waittill("death");
  self thread function_2a105d32(attacker);
}

function private function_a405f422() {
  self endon("death");
  starttime = gettime();
  while(true) {
    if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) <= (self.goalradius * self.goalradius)) {
      break;
    }
    if(((gettime() - starttime) / 1000) >= getdvarint("scr_surge_seek_time", 8)) {
      break;
    }
    wait(0.05);
  }
  self.var_b92dd31d = 1;
}

function private function_d007b404(upgraded, enemy, attacker) {
  self endon("death");
  enemy endon("death");
  traveltime = (distancesquared(enemy.origin, self.origin) / (128 * 128)) * getdvarfloat("scr_surge_arc_travel_time", 0.05);
  self thread _electrodischargearcfx(enemy, traveltime);
  wait(traveltime);
  if(isvehicle(enemy)) {
    enemy thread _surge_vehicle(upgraded, 1, attacker);
  } else {
    enemy thread _surge(upgraded, 1, attacker);
  }
}

function private function_3e26e5ce(upgraded, attacker) {
  self endon("death");
  enemies = self function_3e621fd5(self.origin + vectorscale((0, 0, 1), 50), getdvarint("scr_surge_radius", 220), getdvarint("scr_surge_count", 4));
  foreach(enemy in enemies) {
    if(enemy == self) {
      continue;
    }
    self thread function_d007b404(upgraded, enemy, attacker);
  }
}

function private function_2a105d32(attacker) {
  self notify("hash_2a105d32");
  self endon("hash_2a105d32");
  origin = self.origin;
  self clientfield::set("robot_mind_control_explosion", 1);
  enemies = function_3e621fd5(origin, getdvarint("scr_surge_blowradius", 128), getdvarint("scr_surge_count", 4));
  foreach(guy in enemies) {
    if(guy.archetype == "human") {
      guy dodamage(guy.health, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_EXPLOSIVE", 0, getweapon("frag_grenade"), -1, 1);
    } else {
      guy dodamage(5, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
    }
    if(isDefined(attacker) && isplayer(attacker)) {
      attacker challenges::function_96ed590f("cybercom_uses_esdamage");
    }
  }
  if(isDefined(attacker)) {
    radiusdamage(origin + vectorscale((0, 0, 1), 40), getdvarint("scr_surge_blowradius", 128), getdvarint("scr_surge_blowmaxdmg", 90), getdvarint("scr_surge_blowmindmg", 32), attacker, "MOD_GRENADE_SPLASH", getweapon("emp_grenade"));
  }
  wait(0.2);
  if(isalive(self)) {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined));
    self startragdoll();
  }
}

function private function_3e621fd5(origin, distance, max) {
  weapon = getweapon("gadget_surge");
  distance_squared = distance * distance;
  enemies = [];
  potential_enemies = util::get_array_of_closest(origin, _get_valid_targets());
  foreach(enemy in potential_enemies) {
    if(!isDefined(enemy)) {
      continue;
    }
    if(distancesquared(origin, enemy.origin) > distance_squared) {
      continue;
    }
    if(!cybercom::targetisvalid(enemy, weapon, 0)) {
      continue;
    }
    if(!_lock_requirement(enemy, 1)) {
      continue;
    }
    if(isDefined(enemy.hit_by_electro_discharge) && enemy.hit_by_electro_discharge) {
      continue;
    }
    if(!bullettracepassed(origin, enemy.origin + vectorscale((0, 0, 1), 50), 0, self)) {
      continue;
    }
    enemies[enemies.size] = enemy;
    if(isDefined(max)) {
      if(enemies.size >= max) {
        break;
      }
    }
  }
  return enemies;
}

function private _electrodischargearcfx(target, traveltime) {
  if(!isDefined(self) || !isDefined(target)) {
    return;
  }
  origin = self.origin + vectorscale((0, 0, 1), 40);
  if(isDefined(self.archetype) && self.archetype == "robot") {
    origin = self gettagorigin("J_SpineUpper");
  }
  fxorg = spawn("script_model", origin);
  fxorg setModel("tag_origin");
  fxorg clientfield::set("cybercom_surge", 1);
  tag = (isvehicle(target) ? "tag_origin" : "J_SpineUpper");
  fxorg thread function_d09562d9(target, traveltime, tag);
  wait(traveltime);
  wait(0.25);
  fxorg delete();
}

function private function_d09562d9(target, time, tag) {
  self endon("disconnect");
  self endon("death");
  self notify("hash_d09562d9");
  self endon("hash_d09562d9");
  if(!isDefined(target)) {
    return;
  }
  if(!isDefined(tag)) {
    tag = "tag_origin";
  }
  if(time <= 0) {
    time = 1;
  }
  dest = target gettagorigin(tag);
  if(!isDefined(dest)) {
    dest = target.origin;
  }
  intervals = int(time / 0.05);
  while(isDefined(target) && intervals > 0) {
    dist = distance(self.origin, dest);
    step = dist / intervals;
    v_to_target = (vectornormalize(dest - self.origin)) * step;
    intervals--;
    self moveto(self.origin + v_to_target, 0.05);
    self waittill("movedone");
    dest = target gettagorigin(tag);
  }
}

function ai_activatesurge(target, var_9bc2efcb = 1, upgraded = 0) {
  if(!isDefined(target)) {
    return;
  }
  if(self.archetype != "human") {
    return;
  }
  validtargets = [];
  if(isarray(target)) {
    foreach(guy in target) {
      if(!_lock_requirement(guy)) {
        continue;
      }
      validtargets[validtargets.size] = guy;
    }
  } else {
    if(!_lock_requirement(target)) {
      return;
    }
    validtargets[validtargets.size] = target;
  }
  if(isDefined(var_9bc2efcb) && var_9bc2efcb) {
    type = self cybercom::function_5e3d3aa();
    self orientmode("face default");
    self animscripted("ai_cybercom_anim", self.origin, self.angles, ("ai_base_rifle_" + type) + "_exposed_cybercom_activate");
    self waittillmatch("ai_cybercom_anim");
  }
  weapon = getweapon("gadget_surge");
  foreach(guy in validtargets) {
    if(!cybercom::targetisvalid(guy, weapon)) {
      continue;
    }
    guy thread _surge(self, upgraded);
    wait(0.05);
  }
}

function private _tryfindpathtobest( & enemies, maxattempts = 3) {
  while(maxattempts > 0 && enemies.size > 0) {
    maxattempts--;
    closest = arraygetclosest(self.origin, enemies);
    if(!isDefined(closest)) {
      return;
    }
    pathsuccess = 0;
    queryresult = positionquery_source_navigation(closest.origin, 0, 128, 128, 20, self);
    if(queryresult.data.size > 0) {
      pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
    }
    if(!pathsuccess) {
      arrayremovevalue(enemies, closest, 0);
      closest = undefined;
      continue;
    } else {
      return closest;
    }
  }
}