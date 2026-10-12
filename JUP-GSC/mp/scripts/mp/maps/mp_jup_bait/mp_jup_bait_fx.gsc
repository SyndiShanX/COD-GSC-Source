/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_bait\mp_jup_bait_fx.gsc
**********************************************************/

#namespace mp_jup_bait_fx;

function main() {
  level._effect["small_duck_explode"] = loadfx("vfx/jup/level/mp_jup_bait/vfx_bait_duck_pop.vfx");
  level._effect["small_duck_spawn"] = loadfx("vfx/jup/level/mp_jup_bait/vfx_bait_duck_hi.vfx");
  level._effect["big_duck_spawn"] = loadfx("vfx/jup/level/mp_jup_bait/vfx_bait_duck_pop.vfx");
  level._effect["small_duck_timeout"] = loadfx("vfx/jup/level/mp_jup_bait/vfx_bait_duck_bye.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}