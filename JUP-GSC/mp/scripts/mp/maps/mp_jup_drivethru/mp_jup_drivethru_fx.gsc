/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_drivethru\mp_jup_drivethru_fx.gsc
***********************************************************************/

#namespace mp_jup_drivethru_fx;

function main() {
  level._effect["carousel_confetti"] = loadfx("vfx/jup/level/mp_jup_drivethru/vfx_drivethru_duck_confetti.vfx");
  level._effect["roof_confetti"] = loadfx("vfx/jup/level/mp_jup_drivethru/vfx_drivethru_duck_confetti_up.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}