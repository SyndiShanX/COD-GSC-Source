/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\gunbench_adjustiments.gsc
***************************************************/

lui_update_gunbench() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
  }
}

gunbench_startup() {
  level.primaryammo = getent("ammo_box_primary", "targetname");

  if(isDefined(level.primaryammo)) {
    level.primaryammo hide();
  }

  level.secondaryammo = getent("ammo_box_secondary", "targetname");

  if(isDefined(level.secondaryammo)) {
    level.secondaryammo hide();
  }
}