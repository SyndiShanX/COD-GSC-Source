/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx.gsc
*********************************************************************/

#namespace mp_jup_elevated_fx;

function main() {
  level._effect["vfx_elevated_train_01"] = loadfx("vfx/jup/level/mp_jup_elevated/vfx_elevated_train_01.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}