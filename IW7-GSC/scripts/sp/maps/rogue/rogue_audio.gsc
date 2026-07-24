/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\rogue_audio.gsc
*************************************************/

main() {
  _id_25AC();
}

_id_25AC() {
  scripts\engine\utility::flag_init("sfx_sun_start");
  scripts\engine\utility::flag_init("sfx_night");
}

_id_25FB() {
  if(scripts\engine\utility::flag("sfx_night") || !scripts\engine\utility::flag("sfx_sun_start")) {
    scripts\engine\utility::flag_clear("sfx_night");

    if(!scripts\engine\utility::flag("sfx_sun_start")) {
      scripts\engine\utility::flag_set("sfx_sun_start");
    }

    level.player playSound("scn_asteroid_trans_day");
    level.player _meth_82C0("rogue_asteroid_day", 4);
  }
}

_id_25FC() {
  if(!scripts\engine\utility::flag("sfx_night")) {
    scripts\engine\utility::flag_set("sfx_night");
    level.player playSound("scn_asteroid_trans_night");
    level.player _meth_82C0("rogue_asteroid_night", 4);
  }
}