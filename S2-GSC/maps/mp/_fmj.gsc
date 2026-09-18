/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_fmj.gsc
*********************************************/

func_3D93() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.var_4B2D = 0;
  for(;;) {
    if(!self.var_4B2D) {
      if(maps\mp\_utility::_hasperk("specialty_bulletpenetration")) {
        maps\mp\_utility::func_735("specialty_bulletpenetration");
        if(!maps\mp\_utility::_hasperk("specialty_superbulletpenetration")) {
          maps\mp\_utility::func_735("specialty_armorpiercing");
        }
      }

      wait 0.05;
      continue;
    }

    if(!maps\mp\_utility::_hasperk("specialty_bulletpenetration")) {
      maps\mp\_utility::giveperk("specialty_bulletpenetration");
      maps\mp\_utility::giveperk("specialty_armorpiercing");
    }

    wait 0.05;
  }
}