/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx.gsc
*******************************************************************/

#namespace mp_jup_subbase_fx;

function main() {
  level._effect["vfx_rhib_infil_splashes"] = loadfx("vfx/iw9/infil/vfx_rhib_infil_splashes.vfx");
  level._effect["vfx_farm_sunflare"] = loadfx("vfx/jup/level/mp_jup_subbase/vfx_subbase_sunflare.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}