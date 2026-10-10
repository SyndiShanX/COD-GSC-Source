/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3bfcbbd02540ce3e.gsc
*************************************************/

#namespace namespace_828929a54ca95811;

function main() {
  level._effect["vfx_museum_waterfall"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall.vfx");
  level._effect["vfx_museum_waterfall_2"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall_2.vfx");
  level._effect["vfx_museum_waterfall_2_short"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall_2_short.vfx");
  level._effect["vfx_museum_waterfall_foam"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall_foam.vfx");
  level._effect["vfx_museum_waterfall_mist"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall_mist.vfx");
  level._effect["vfx_museum_waterfall_top"] = loadfx("vfx/iw9/level/mp_museum/vfx_museum_waterfall_top.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}