/*****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_electrostatic_strike.gsc
*****************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_gadget_system_overload;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_gadget_electrostatic_strike;

function init() {}

function main() {
  cybercom_gadget::registerability(2, 2);
  level._effect["es_effect_human"] = "electric/fx_ability_elec_strike_short_human";
  level._effect["es_effect_warlord"] = "electric/fx_ability_elec_strike_short_warlord";
  level._effect["es_effect_robot"] = "electric/fx_ability_elec_strike_short_robot";
  level._effect["es_effect_wasp"] = "electric/fx_ability_elec_strike_short_wasp";
  level._effect["es_effect_generic"] = "electric/fx_ability_elec_strike_generic";
  level._effect["es_contact"] = "electric/fx_ability_elec_strike_impact";
  level._effect["es_arc"] = "electric/fx_ability_elec_strike_trail";
  level.cybercom.electro_strike = spawnStruct();
  level.cybercom.electro_strike._is_flickering = &_is_flickering;
  level.cybercom.electro_strike._on_flicker = &_on_flicker;
  level.cybercom.electro_strike._on_give = &_on_give;
  level.cybercom.electro_strike._on_take = &_on_take;
  level.cybercom.electro_strike._on_connect = &_on_connect;
  level.cybercom.electro_strike._on = &_on;
  level.cybercom.electro_strike._off = &_off;
  level.cybercom.electro_strike.human_weapon = getweapon("gadget_es_strike");
  level.cybercom.electro_strike.var_bf0de5fb = getweapon("gadget_es_strike");
  level.cybercom.electro_strike.robot_weapon = getweapon("gadget_es_strike");
  level.cybercom.electro_strike.var_f492f9d5 = getweapon("emp_grenade");
  level.cybercom.electro_strike.vehicle_weapon = getweapon("emp_grenade");
  level.cybercom.electro_strike.other_weapon = getweapon("emp_grenade");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self thread function_677ed44f(weapon);
}

function _on_take(slot, weapon) {
  self notify("hash_343d4580");
}

function _on_connect() {}

function _on(slot, weapon) {}

function _off(slot, weapon) {}

function function_677ed44f(weapon) {
  self notify("hash_677ed44f");
  self endon("hash_677ed44f");
  self endon("hash_343d4580");
  self endon("disconnect");
  while(true) {
    level waittill("hash_63acb616", target, attacker, damage, weapon, hitorigin);
    wait(0.05);
    if(isDefined(target)) {
      if(target cybercom::cybercom_aicheckoptout("cybercom_es_strike")) {
        continue;
      }
      if(!isalive(target)) {
        continue;
      }
      self notify(weapon.name + "_fired");
      level notify(weapon.name + "_fired");
      self thread challenges::function_96ed590f("cybercom_uses_control");
      status = self hascybercomability("cybercom_es_strike", 1);
      upgraded = status == 2;
      target notify("hash_f8c5dd60", weapon, attacker);
      target thread electrostaticcontact(attacker, attacker, upgraded, hitorigin);
      target thread electrostaticarc(attacker, upgraded);
      if(isDefined(target.archetype) && target.archetype == "human") {
        target clientfield::set("arch_actor_char", 1);
        target thread function_71a4f1d5();
      }
      if(isPlayer(self)) {
        itemindex = getitemindexfromref("cybercom_es_strike");
        if(isDefined(itemindex)) {
          self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
      }
    }
  }
}

function function_71a4f1d5() {
  self waittill("actor_corpse", corpse);
  corpse clientfield::set("arch_actor_fire_fx", 3);
}

function ai_activateelectrostaticstrike(upgraded = 0) {
  self thread aielectrostatickillmonitor((upgraded ? 2 : 1));
}

function aielectrostatickillmonitor(statusoverride) {
  if(isPlayer(self)) {
    self endon("disconnect");
  } else {
    self endon("death");
  }
  self notify("electro_static_monitor_kill");
  self endon("electro_static_monitor_kill");
  while(true) {
    level waittill("hash_63acb616", target, attacker, damage, weapon, hitorigin);
    wait(0.05);
    if(isDefined(target)) {
      target notify("hash_f8c5dd60", weapon, attacker);
      upgraded = statusoverride == 2;
      target thread electrostaticcontact(attacker, attacker, upgraded, hitorigin);
      target thread electrostaticarc(attacker, upgraded);
    }
  }
}

function function_4830484e(attacker) {
  if(!isDefined(self)) {
    return false;
  }
  if(self cybercom::cybercom_aicheckoptout("cybercom_es_strike")) {
    return false;
  }
  if(!isalive(self)) {
    return false;
  }
  if(isDefined(self._ai_melee_opponent)) {
    return false;
  }
  if(!isDefined(self.archetype)) {
    return false;
  }
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    return false;
  }
  if(isDefined(self._ai_melee_opponent)) {
    return false;
  }
  if(self.team == attacker.team) {
    return false;
  }
  return true;
}

function electrostaticcontact(attacker, source, upgraded = 0, contactpoint, secondary = 0) {
  if(!self function_4830484e(attacker)) {
    return;
  }
  if(!isDefined(source)) {
    source = attacker;
  }
  if(!isDefined(attacker)) {
    return;
  }
  if(isDefined(contactpoint)) {
    playFX(level._effect["es_contact"], contactpoint);
  }
  if(isDefined(self.archetype)) {
    switch (self.archetype) {
      case "human": {
        self clientfield::set("arch_actor_char", 1);
        self thread function_71a4f1d5();
      }
      case "human_riotshield":
      case "zombie": {
        fx = level._effect["es_effect_human"];
        tag = "j_spine4";
        break;
      }
      case "robot": {
        fx = level._effect["es_effect_robot"];
        tag = "j_spine4";
        break;
      }
      case "wasp": {
        fx = level._effect["es_effect_wasp"];
        tag = "tag_body";
        break;
      }
      case "warlord": {
        fx = level._effect["es_effect_warlord"];
        tag = "j_spine4";
        break;
      }
      default: {
        fx = level._effect["es_effect_generic"];
        tag = "tag_body";
        break;
      }
    }
  } else {
    fx = level._effect["es_effect_generic"];
    tag = "tag_body";
  }
  if(!isDefined(self gettagorigin(tag))) {
    tag = "tag_origin";
  }
  playFXOnTag(fx, self, tag);
  if(self cybercom::function_421746e0()) {
    self kill(self.origin, attacker);
    return;
  }
  if(self.archetype == "human" || self.archetype == "zombie" || self.archetype == "human_riotshield" || self.archetype == "direwolf") {
    if(isDefined(self.voiceprefix) && isDefined(self.bcvoicenumber)) {
      self thread battlechatter::do_sound((self.voiceprefix + self.bcvoicenumber) + "_exert_electrocution", 1);
    }
    self dodamage(self.health, source.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.electro_strike.human_weapon, -1, 1);
  } else {
    if(self.archetype == "warlord") {
      self dodamage(getdvarint("scr_es_upgraded_damage", 80), self.origin, (isDefined(attacker) ? attacker : undefined), undefined, undefined, "MOD_UNKNOWN", 0, level.cybercom.electro_strike.var_bf0de5fb, -1, 1);
    } else {
      if(self.archetype == "robot") {
        self ai::set_behavior_attribute("can_gib", 0);
        if(isDefined(secondary) && secondary) {
          self dodamage(getdvarint("scr_es_damage", 5), source.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_MELEE", 512, level.cybercom.electro_strike.var_f492f9d5, -1, 1);
        } else {
          self dodamage(self.health, source.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.electro_strike.robot_weapon, -1, 1);
        }
        self ai::set_behavior_attribute("robot_lights", 1);
        if(!(isDefined(self.is_disabled) && self.is_disabled) && isalive(self)) {
          self thread cybercom_gadget_system_overload::system_overload(attacker, undefined, undefined, 0);
        }
        wait(2.5);
        if(isDefined(self)) {
          self ai::set_behavior_attribute("robot_lights", 2);
        }
      } else {
        if(isvehicle(self)) {
          self dodamage(getdvarint("scr_es_damage", 5), source.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_GRENADE", 0, level.cybercom.electro_strike.vehicle_weapon);
          self playSound("gdt_cybercore_amws_shutdown");
        } else {
          self dodamage(getdvarint("scr_es_damage", 5), source.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.electro_strike.other_weapon);
        }
      }
    }
  }
}

function electrostaticarc(player, upgraded) {
  self endon("death");
  if(!upgraded) {
    return;
  }
  wait(0.05);
  electro_strike_arc_range = getdvarint("scr_es_arc_range", 72);
  if(upgraded) {
    electro_strike_arc_range = getdvarint("scr_es_upgraded_arc_range", 128);
  }
  distsq = electro_strike_arc_range * electro_strike_arc_range;
  enemies = [];
  prospects = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
  potential_enemies = util::get_array_of_closest(self.origin, prospects);
  foreach(enemy in potential_enemies) {
    if(!isDefined(enemy)) {
      continue;
    }
    if(enemy == self) {
      continue;
    }
    if(isDefined(enemy.is_disabled) && enemy.is_disabled) {
      continue;
    }
    if(isDefined(enemy.missinglegs) && enemy.missinglegs || (isDefined(enemy.iscrawler) && enemy.iscrawler)) {
      continue;
    }
    if(!enemy function_4830484e(player)) {
      continue;
    }
    if(distancesquared(self.origin, enemy.origin) > distsq) {
      continue;
    }
    if(!bullettracepassed(self.origin, enemy.origin + vectorscale((0, 0, 1), 50), 0, undefined)) {
      continue;
    }
    enemies[enemies.size] = enemy;
  }
  i = 0;
  foreach(guy in enemies) {
    player thread challenges::function_96ed590f("cybercom_uses_esdamage");
    self thread _electrodischargearcdmg(guy, player, upgraded);
    i++;
    if(i >= getdvarint("scr_es_max_arcs", 4)) {
      break;
    }
  }
}

function private _electrodischargearcdmg(target, player, upgraded) {
  if(!isDefined(self) || !isDefined(target)) {
    return;
  }
  origin = self.origin + vectorscale((0, 0, 1), 40);
  target_origin = target.origin + vectorscale((0, 0, 1), 40);
  fxorg = spawn("script_model", origin);
  fxorg setModel("tag_origin");
  fx = playFXOnTag(level._effect["es_arc"], fxorg, "tag_origin");
  fxorg playSound("gdt_electro_bounce");
  fxorg moveto(target_origin, 0.25);
  fxorg util::waittill_any_timeout(1, "movedone");
  fxorg delete();
  target thread electrostaticcontact(player, self, upgraded, undefined, 1);
}