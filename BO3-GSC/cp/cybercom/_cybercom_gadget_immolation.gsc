/*******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_immolation.gsc
*******************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
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
#using scripts\shared\vehicle_ai_shared;
#using_animtree("generic");
#namespace cybercom_gadget_immolation;

function init() {}

function main() {
  cybercom_gadget::registerability(2, 4);
  level.cybercom.immolation = spawnStruct();
  level.cybercom.immolation._is_flickering = &_is_flickering;
  level.cybercom.immolation._on_flicker = &_on_flicker;
  level.cybercom.immolation._on_give = &_on_give;
  level.cybercom.immolation._on_take = &_on_take;
  level.cybercom.immolation._on_connect = &_on_connect;
  level.cybercom.immolation._on = &_on;
  level.cybercom.immolation._off = &_off;
  level.cybercom.immolation._is_primed = &_is_primed;
  level.cybercom.immolation.grenadelocs = array("j_shoulder_le_rot", "j_elbow_le_rot", "j_shoulder_ri_rot", "j_elbow_ri_rot", "j_hip_le", "j_knee_le", "j_hip_ri", "j_knee_ri", "j_head", "j_mainroot");
  level.cybercom.immolation.grenadetypes = array("frag_grenade_notrail", "emp_grenade");
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = getdvarint("scr_immolation_count", 1);
  if(self hascybercomability("cybercom_immolation") == 2) {
    self.cybercom.var_110c156a = getdvarint("scr_immolation_upgraded_count", 1);
  }
  self.cybercom.targetlockcb = &_get_valid_targets;
  self.cybercom.targetlockrequirementcb = &_lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self thread _activate_immolation(slot, weapon);
  self _off(slot, weapon);
}

function _off(slot, weapon) {
  self thread cybercom::weaponendlockwatcher(weapon);
  self.cybercom.is_primed = undefined;
  self notify("hash_c74ed649");
}

function _is_primed(slot, weapon) {
  if(!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed)) {
    assert(self.cybercom.activecybercomweapon == weapon);
    self notify("hash_9cefb9d9");
    self thread cybercom::weaponlockwatcher(slot, weapon, self.cybercom.var_110c156a);
    self.cybercom.is_primed = 1;
  }
}

function private _lock_requirement(target) {
  if(target cybercom::cybercom_aicheckoptout("cybercom_immolation")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isDefined(target.hijacked) && target.hijacked) {
    self cybercom::function_29bf9dee(target, 4);
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  if(!isDefined(target.archetype)) {
    return false;
  }
  if(isvehicle(target) && !target _validimmolatevehicle()) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(!isactor(target) && !isvehicle(target)) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isactor(target) && (target.archetype != "robot" && target.archetype != "human" && target.archetype != "human_riotshield")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(target.archetype == "human" || target.archetype == "human_riotshield" && isplayer(self)) {
    if(!self hascybercomability("cybercom_immolation") == 2) {
      self cybercom::function_29bf9dee(target, 2);
      return false;
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

function private _activate_immolation(slot, weapon) {
  upgraded = self hascybercomability("cybercom_immolation") == 2;
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        self thread challenges::function_96ed590f("cybercom_uses_chaos");
        item.target.immolate_origin = item.target.origin;
        item.target thread _immolate(self, upgraded, 0, weapon);
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
    itemindex = getitemindexfromref("cybercom_immolation");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function private _validimmolatevehicle() {
  if(!isDefined(self.vehicletype)) {
    return false;
  }
  if(issubstr(self.vehicletype, "amws")) {
    return true;
  }
  if(issubstr(self.vehicletype, "wasp")) {
    return true;
  }
  if(issubstr(self.vehicletype, "raps")) {
    return true;
  }
  return false;
}

function private _immolatevehicle(attacker, upgraded, immediate = 0) {
  assert(self _validimmolatevehicle());
  self clientfield::set("cybercom_immolate", 1);
  self.is_disabled = 1;
  if(!immediate) {
    wait(randomfloatrange(0, 0.75));
  }
  self thread vehicle_ai::immolate(attacker);
}

function private _immolate(attacker, upgraded, immediate = 0, weapon) {
  self notify("hash_f8c5dd60", weapon, attacker);
  if(self cybercom::function_421746e0()) {
    if(isvehicle(self)) {
      self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
      return;
    }
    immediate = 1;
  }
  if(isvehicle(self)) {
    self thread _immolatevehicle(attacker, upgraded);
  } else {
    if(self.archetype == "robot") {
      self thread _immolaterobot(attacker, upgraded, immediate);
    } else if(self.archetype == "human" || self.archetype == "human_riotshield") {
      self thread _immolatehuman(attacker, upgraded, immediate);
    }
  }
}

function _immolategrenadedetonationwatch(tag, count, attacker, weapon) {
  msg = self util::waittill_any_timeout(3, "death", "explode", "damage");
  if(isDefined(self.grenade_prop)) {
    self.grenade_prop delete();
  }
  self stopsound("gdt_immolation_human_countdown");
  attacker thread _detonate_grenades(self, 100, count);
  if(isalive(self)) {
    self stopanimscripted();
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
  }
}

function _immolatehuman(attacker, upgraded, immediate = 0) {
  self endon("death");
  weapon = getweapon("gadget_immolation");
  self clientfield::set("cybercom_immolate", 1);
  if(immediate) {
    self.ignoreall = 1;
    self clientfield::set("arch_actor_fire_fx", 1);
    self thread _corpsewatcher();
    util::wait_network_frame();
    self thread _immolategrenadedetonationwatch("tag_weapon_chest", undefined, attacker, weapon);
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
    return;
  }
  wait(randomfloatrange(0.1, 0.75));
  if(!attacker cybercom::targetisvalid(self, weapon, 0)) {
    return;
  }
  self.is_disabled = 1;
  self.ignoreall = 1;
  tag = undefined;
  numgrenades = undefined;
  if(self.archetype != "human_riotshield" && self cybercom::function_78525729() == "stand" && randomint(100) < getdvarint("scr_immolation_specialanimchance", 15)) {
    self notify("bhtn_action_notify", "reactImmolationLong");
    self thread _immolategrenadedetonationwatch("tag_inhand", 1, attacker, weapon);
    self animscripted("immo_anim", self.origin, self.angles, "ai_base_rifle_stn_exposed_immolate_explode_midthrow");
    self thread cybercom::stopanimscriptedonnotify("damage_pain", "immo_anim", 1, attacker, weapon);
    self waittillmatch("immo_anim");
    self.grenade_prop = spawn("script_model", self gettagorigin("tag_inhand"));
    self.grenade_prop setModel("wpn_t7_grenade_frag_world");
    self.grenade_prop enablelinkto();
    self.grenade_prop linkto(self, "tag_inhand");
    playFXOnTag("light/fx_ability_light_chest_immolation", self.grenade_prop, "tag_origin");
    self waittillmatch("immo_anim");
    self stopsound("gdt_immolation_human_countdown");
    self notify("explode", "explode", "grenade_right");
  } else {
    self notify("bhtn_action_notify", "reactImmolation");
    self dodamage(5, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    playFXOnTag("light/fx_ability_light_chest_immolation", self, "tag_weapon_chest");
    self thread function_f8956516();
    self thread _immolategrenadedetonationwatch("tag_weapon_chest", undefined, attacker, weapon);
  }
}

function function_f8956516() {
  self endon("death");
  self waittillmatch("bhtn_action_terminate");
  self stopsound("gdt_immolation_human_countdown");
  self notify("explode", "specialpain");
}

function _immolaterobot(attacker, upgraded, immediate = 0) {
  self endon("death");
  if(!immediate) {
    wait(randomfloatrange(0.1, 0.75));
  }
  weapon = getweapon("gadget_immolation");
  if(!attacker cybercom::targetisvalid(self, weapon, 0)) {
    return;
  }
  self.is_disabled = 1;
  if(isDefined(self.iscrawler) && self.iscrawler || !cybercom::function_76e3026d(self)) {
    self playSound("wpn_incendiary_explode");
    physicsexplosionsphere(self.origin, 200, 32, 2);
    self immolate_nearby(attacker, upgraded);
    origin = self.origin;
    self dodamage(self.health, self.origin, (isDefined(attacker) ? attacker : undefined), (isDefined(attacker) ? attacker : undefined), "none", "MOD_BURNED", 0, weapon, -1, 1);
    wait(0.1);
    radiusdamage(origin, getdvarint("scr_immolation_outer_radius", 235), 500, 30, (isDefined(attacker) ? attacker : undefined), "MOD_EXPLOSIVE", weapon);
    return;
  }
  self clientfield::set("arch_actor_fire_fx", 1);
  self clientfield::set("cybercom_immolate", 1);
  self thread _corpsewatcher();
  self.ignoreall = 1;
  type = self cybercom::function_5e3d3aa();
  self.ignoreall = 1;
  variant = "_" + randomint(3);
  if(variant == "_0") {
    variant = "";
  }
  var_a30bdd5a = getdvarfloat("scr_immolation_death_delay", 0.87) + randomfloatrange(0, 0.2);
  var_ebfa18e1 = gettime() + (var_a30bdd5a * 1000);
  self dodamage(5, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
  while(gettime() < var_ebfa18e1) {
    wait(0.1);
  }
  self clientfield::set("cybercom_immolate", 2);
  self immolate_nearby(attacker, upgraded);
  level notify("hash_f90d73d4", upgraded);
  attacker notify("hash_f90d73d4");
  util::wait_network_frame();
  origin = self.origin;
  self dodamage(self.health, self.origin, (isDefined(attacker) ? attacker : undefined), (isDefined(attacker) ? attacker : undefined), "none", "MOD_BURNED", 0, weapon, -1, 1);
  radiusdamage(origin, getdvarint("scr_immolation_outer_radius", 235), 500, 30, (isDefined(attacker) ? attacker : undefined), "MOD_EXPLOSIVE", weapon);
}

function private _corpsewatcher() {
  archetype = self.archetype;
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("arch_actor_fire_fx", 2);
}

function private _detonate_grenades(guy, chance = getdvarint("scr_immolation_gchance", 100), numextradetonations = randomint(getdvarint("scr_immolation_gcount", 3)) + 1) {
  self endon("disconnect");
  loc = guy _get_grenade_spawn_loc();
  grenade = self magicgrenadetype(getweapon("frag_grenade_notrail"), loc, (0, 0, 0), 0);
  while(numextradetonations && isDefined(self) && isDefined(guy)) {
    wait(randomfloatrange(getdvarfloat("scr_immolation_grenade_wait_timeMIN", 0.3), getdvarfloat("scr_immolation_grenade_wait_timeMAX", 0.9)));
    numextradetonations--;
    if(randomint(100) > chance) {
      continue;
    }
    gtype = level.cybercom.immolation.grenadetypes[randomint(level.cybercom.immolation.grenadetypes.size)];
    if(isDefined(guy)) {
      loc = guy _get_grenade_spawn_loc();
      if(!isDefined(loc)) {
        loc = guy.origin + vectorscale((0, 0, 1), 50);
      }
    }
    if(isDefined(loc)) {
      grenade = self magicgrenadetype(getweapon(gtype), loc, (0, 0, 0), 0.05);
      grenade thread waitforexplode();
    }
  }
}

function waitforexplode() {
  self util::waittill_any_timeout(3, "death", "detonated");
  if(isDefined(self)) {
    self delete();
  }
}

function private _detonate_grenades_inrange(player, rangemax) {
  weapon = getweapon("gadget_immolation");
  enemies = arraycombine(getaispeciesarray("axis", "robot"), getaispeciesarray("team3", "robot"), 0, 0);
  closetargets = arraysortclosest(enemies, self.origin, enemies.size, 0, rangemax);
  foreach(guy in closetargets) {
    if(player cybercom::targetisvalid(guy, weapon)) {
      if(isDefined(guy.grenades_detonated) && guy.grenades_detonated) {
        continue;
      }
      guy.grenades_detonated = 1;
      player thread _detonate_grenades(guy);
    }
  }
}

function immolate_nearby(attacker, upgraded) {
  weapon = getweapon("gadget_immolation");
  targets = _get_valid_targets();
  var_5b8b9202 = 0;
  closetargets = arraysortclosest(targets, self.origin, 666, 0, getdvarint("scr_immolation_radius", 150));
  foreach(guy in closetargets) {
    if(guy == self) {
      continue;
    }
    if(isDefined(attacker.var_a691a602)) {
      if(attacker.var_a691a602 >= 2) {
        break;
      }
    }
    if(attacker cybercom::targetisvalid(guy, weapon)) {
      if(!isDefined(attacker.var_a691a602)) {
        attacker thread function_4f174738();
      } else {
        attacker.var_a691a602++;
      }
      if(isvehicle(guy)) {
        continue;
      }
      guy thread _immolate(attacker, upgraded, 1, weapon);
    }
  }
}

function private _get_grenade_spawn_loc() {
  if(isDefined(self.archetype) && self.archetype == "human") {
    return self gettagorigin("tag_weapon_chest");
  }
  tag = level.cybercom.immolation.grenadelocs[randomint(level.cybercom.immolation.grenadelocs.size)];
  return self gettagorigin(tag);
}

function ai_activateimmolate(target, var_9bc2efcb = 1, upgraded) {
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
  weapon = getweapon("gadget_immolation");
  foreach(guy in validtargets) {
    if(!self cybercom::targetisvalid(guy, weapon)) {
      continue;
    }
    guy thread _immolate(self, upgraded, 0, getweapon("gadget_immolation"));
    wait(0.05);
  }
}

function function_4f174738() {
  self endon("death");
  self.var_a691a602 = 0;
  wait(2);
  self.var_a691a602 = undefined;
}