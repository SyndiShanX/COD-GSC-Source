/**************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_unstoppable_force.gsc
**************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_achievements;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_gadget_unstoppable_force;

function init() {}

function main() {
  cybercom_gadget::registerability(1, 32, 1);
  level.cybercom.unstoppable_force = spawnStruct();
  level.cybercom.unstoppable_force._is_flickering = & _is_flickering;
  level.cybercom.unstoppable_force._on_flicker = & _on_flicker;
  level.cybercom.unstoppable_force._on_give = & _on_give;
  level.cybercom.unstoppable_force._on_take = & _on_take;
  level.cybercom.unstoppable_force._on_connect = & _on_connect;
  level.cybercom.unstoppable_force._on = & _on;
  level.cybercom.unstoppable_force._off = & _off;
  level.cybercom.unstoppable_force._is_primed = & _is_primed;
  level.cybercom.unstoppable_force.weapon = getweapon("gadget_unstoppable_force");
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self.cybercom.is_primed = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self disableoffhandweapons();
  self disableweaponcycling();
  achievements::function_386309ce(self);
  self.cybercom.is_primed = undefined;
  self notify(weapon.name + "_fired");
  level notify(weapon.name + "_fired");
  self thread function_875f1595(slot, weapon);
  if(isplayer(self)) {
    itemindex = getitemindexfromref("cybercom_unstoppableforce");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function _off(slot, weapon) {
  self clientfield::set_to_player("unstoppableforce_state", 0);
  self notify("unstoppable_watch_collisions");
  self notify("hash_1f17ce9a");
  self playSound("gdt_unstoppable_stop");
  self gadgetpowerset(slot, 0);
  self enableoffhandweapons();
  self enableweaponcycling();
}

function private function_1852a14f(slot, weapon) {
  self endon("weapon_melee_juke");
  wait(0.5);
  self gadgetpowerchange(slot, -100);
}

function private function_6c3ee126(slot, weapon) {
  self endon("disconnect");
  self endon("hash_1f17ce9a");
  self waittill("weapon_melee_juke_end");
  self gadgetpowerset(slot, 0);
}

function private function_98296a6a(slot, weapon) {
  self endon("death");
  self endon("disconnect");
  self waittill("weapon_juke_end_requested", endreason);
  if(endreason == 2) {
    earthquake(1, 0.75, self.origin, 100);
    self playrumbleonentity("riotshield_impact");
    self playSound("gdt_unstoppable_hit_wall");
  }
}

function _is_primed(slot, weapon) {}

function private function_875f1595(slot, weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("hash_1f17ce9a");
  self clientfield::set_to_player("unstoppableforce_state", 1);
  wait(0.05);
  if(self isswitchingweapons()) {
    self waittill("weapon_change_complete");
  }
  self thread watch_collisions(weapon);
  self thread function_6c3ee126(slot, weapon);
  self thread function_98296a6a(slot, weapon);
  self thread function_1852a14f(slot, weapon);
  self queuemeleeactionstate();
}

function private _is_good_target(target) {
  if(!isDefined(target)) {
    return false;
  }
  if(!isalive(target)) {
    return false;
  }
  if(target cybercom::cybercom_aicheckoptout("cybercom_unstoppableforce")) {
    return false;
  }
  if(!(isDefined(target.takedamage) && target.takedamage)) {
    return false;
  }
  if(isactor(target)) {
    if(target isinscriptedstate() && (!(isDefined(target.is_disabled) && target.is_disabled))) {
      if(!target cybercom::function_421746e0()) {
        return false;
      }
    }
  }
  if(!(isDefined(target.allowdeath) && target.allowdeath)) {
    return false;
  }
  if(isDefined(target.blockingpain) && target.blockingpain) {
    return false;
  }
  if(isactor(target) && target cybercom::function_78525729() != "stand" && target cybercom::function_78525729() != "crouch") {
    return false;
  }
  return true;
}

function private _get_valid_targets() {
  enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
  valid = [];
  foreach(mf in enemies) {
    if(!_is_good_target(mf)) {
      continue;
    }
    valid[valid.size] = mf;
  }
  return valid;
}

function private function_40b93b78() {
  self stopjukemove();
  self notify("unstoppable_watch_collisions");
}

function private function_649c2f65(enemy, weapon) {
  if(enemy cybercom::islinked()) {
    enemy unlink();
  }
  enemy notify("hash_f8c5dd60", weapon, self);
  if(enemy.scriptvehicletype == "quadtank" || enemy.scriptvehicletype == "siegebot") {
    enemy dodamage(getdvarint("scr_unstoppable_heavy_vehicle_damage", 300), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
    self function_40b93b78();
  } else {
    if(enemy.scriptvehicletype == "raps" || enemy.scriptvehicletype == "wasp") {
      enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
    } else {
      if(enemy.scriptvehicletype == "amws") {
        enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
        self function_40b93b78();
      } else if(enemy.scriptvehicletype == "") {
        if(enemy.archetype == "turret") {
          enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
          self function_40b93b78();
        }
      }
    }
  }
}

function hit_enemy(guy, weapon) {
  if(guy cybercom::islinked()) {
    guy unlink();
  }
  guy notify("hash_f8c5dd60", weapon, self);
  if(guy.archetype == "warlord") {
    if(isDefined(guy.is_disabled) && guy.is_disabled) {
      guy dodamage(guy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.var_bf0de5fb, -1, 1);
    } else {
      guy dodamage(getdvarint("scr_unstoppable_warlord_damage", 40), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
    }
  } else {
    if(guy.archetype == "human_riotshield") {
      guy dodamage(guy.health, self.origin, self, self, "none", "MOD_IMPACT", 0, weapon, -1, 1);
      guy notify("bhtn_action_notify", "reactBodyBlow");
    } else {
      guy function_b4852552(self);
    }
  }
  if(guy.archetype == "robot") {
    self playSound("gdt_unstoppable_hit_bot");
  } else {
    self playSound("gdt_unstoppable_hit_human");
  }
}

function watch_collisions(weapon) {
  self notify("unstoppable_watch_collisions");
  self endon("unstoppable_watch_collisions");
  self endon("death");
  self endon("disconnect");
  while(true) {
    enemies = function_518996b3();
    hit = 0;
    foreach(guy in enemies) {
      hit++;
      if(isvehicle(guy)) {
        self playSound("gdt_unstoppable_hit_veh");
        self function_649c2f65(guy, weapon);
        continue;
      }
      self hit_enemy(guy, weapon);
    }
    if(hit) {
      earthquake(1, 0.75, self.origin, 100);
      self playrumbleonentity("damage_heavy");
    }
    wait(0.05);
  }
}

function function_518996b3() {
  enemies = _get_valid_targets();
  view_pos = self.origin;
  validtargets = array::get_all_closest(view_pos, enemies, undefined, undefined, 120);
  if(!isDefined(validtargets)) {
    return;
  }
  forward = anglesToForward(self getplayerangles());
  up = anglestoup(self getplayerangles());
  segment_start = view_pos + (36 * forward);
  segment_end = segment_start + ((120 - 36) * forward);
  fling_force = getdvarint("scr_unstoppable_fling_force", 175);
  fling_force_vlo = fling_force * 0.5;
  fling_force_vhi = fling_force * 0.6;
  enemies = [];
  for(i = 0; i < validtargets.size; i++) {
    if(!isDefined(validtargets[i]) || !isalive(validtargets[i])) {
      continue;
    }
    test_origin = validtargets[i] getcentroid();
    radial_origin = pointonsegmentnearesttopoint(segment_start, segment_end, test_origin);
    lateral = test_origin - radial_origin;
    if(abs(lateral[2]) > 72) {
      continue;
    }
    lateral = (lateral[0], lateral[1], 0);
    len = length(lateral);
    if(len > 36) {
      continue;
    }
    lateral = (lateral[0], lateral[1], 0);
    validtargets[i].fling_vec = (fling_force * forward) + (randomfloatrange(fling_force_vlo, fling_force_vhi) * up);
    enemies[enemies.size] = validtargets[i];
  }
  return enemies;
}

function function_b4852552(player) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self dodamage(self.health, player.origin, player, player, "", "MOD_IMPACT");
  if(isDefined(self.fling_vec)) {
    self startragdoll(1);
    self launchragdoll(self.fling_vec);
  }
}