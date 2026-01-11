/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ash_falling.gsc
*****************************************************/

ash_fall(var_0) {
  self notify("ash_change");

  if(var_0 > 0) {
    thread ash_fall_thread(var_0);
  }
}

ash_fall_thread(var_0) {
  self endon("ash_change");

  for(;;) {
    if(maps\_utility::is_coop()) {
      playfxontagforclients(level._effect["ash"], self, "tag_origin", self);
    }
    else {
      playFX(level._effect["ash"], self.origin);
    }

    wait(0.3 / var_0);
  }
}

ash_init() {
  setsaveddvar("r_outdoorfeather", "32");
  level._effect["ash_nowind"] = loadfx("vfx/ambient/atmospheric/vfx_ash_fall_onplayer");
  level._effect["ash"] = level._effect["ash_nowind"];
}