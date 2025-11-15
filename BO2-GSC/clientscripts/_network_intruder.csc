/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_network_intruder.csc
***********************************************/

#include clientscripts\_fx;

init(localclientnum) {
  level._effect["networkintruder_enemy_light"] = loadfx("misc/fx_equip_light_red");
  level._effect["networkintruder_friendly_light"] = loadfx("misc/fx_equip_light_green");
}

spawned(localclientnum) {
  self thread clientscripts\_fx::blinky_light(localclientnum, "tag_light", level._effect["networkintruder_friendly_light"]);
}