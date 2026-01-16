/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_ravage_core.gsc
********************************************************/

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
#using scripts\shared\ai\systems\destructible_character;
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
#namespace namespace_9cc756f9;

function init() {}

function main() {
  cybercom_gadget::registerability(0, 16);
  level.cybercom.ravage_core = spawnstruct();
  level.cybercom.ravage_core._is_flickering = & _is_flickering;
  level.cybercom.ravage_core._on_flicker = & _on_flicker;
  level.cybercom.ravage_core._on_give = & _on_give;
  level.cybercom.ravage_core._on_take = & _on_take;
  level.cybercom.ravage_core._on_connect = & _on_connect;
  level.cybercom.ravage_core._on = & _on;
  level.cybercom.ravage_core._off = & _off;
  level.cybercom.ravage_core.weapon = getweapon("gadget_ravage_core");
  callback::on_spawned( & on_player_spawned);
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
  while (true) {
    level waittill("ravage_core", target, attacker, damage, weapon, hitorigin);
    self notify("ravage_core", target, damage, weapon);
    destructserverutils::destructhitlocpieces(target, "torso_upper");
    self notify(weapon.name + "_fired");
    level notify(weapon.name + "_fired");
    target hidepart("j_chest_door");
    target thread _corpsewatcher();
    target ai::set_behavior_attribute("robot_lights", 1);
    attacker thread challenges::function_96ed590f("cybercom_uses_control");
    if(isplayer(self)) {
      itemindex = getitemindexfromref("cybercom_ravagecore");
      if(isdefined(itemindex)) {
        self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
        self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
      }
    }
    self waittill("grenade_fire");
    self notify("hash_65afc94f");
  }
}

function private _corpsewatcher() {
  self waittill("actor_corpse", corpse);
  if(isdefined(corpse)) {
    corpse hidepart("j_chest_door");
  }
}