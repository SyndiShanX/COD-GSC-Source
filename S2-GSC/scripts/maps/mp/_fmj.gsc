/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_fmj.gsc
**************************************/

_id_3D93() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self._id_4B2D = 0;

  for(;;) {
    if(!self._id_4B2D) {
      if(maps\mp\_utility::_hasperk("specialty_bulletpenetration")) {
        maps\mp\_utility::_id_0735("specialty_bulletpenetration");

        if(!maps\mp\_utility::_hasperk("specialty_superbulletpenetration")) {
          maps\mp\_utility::_id_0735("specialty_armorpiercing");
        }
      }

      waitframe();
      continue;
    }

    if(!maps\mp\_utility::_hasperk("specialty_bulletpenetration")) {
      maps\mp\_utility::giveperk("specialty_bulletpenetration");
      maps\mp\_utility::giveperk("specialty_armorpiercing");
    }

    waitframe();
  }
}