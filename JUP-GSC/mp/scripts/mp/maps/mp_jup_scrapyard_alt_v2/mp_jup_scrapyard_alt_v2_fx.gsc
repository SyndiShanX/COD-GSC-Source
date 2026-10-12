/**********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_scrapyard_alt_v2\mp_jup_scrapyard_alt_v2_fx.gsc
**********************************************************************************/

#namespace mp_jup_scrapyard_alt_v2_fx;

function main() {
  level._effect["vfx_scrap_trash_flies_alt"] = loadfx("vfx/jup/level/mp_jup_scrap_alt/vfx_scrap_trash_flies_alt.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}