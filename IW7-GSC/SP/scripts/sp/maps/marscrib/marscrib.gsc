/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\marscrib.gsc
*************************************************/

main() {
  scripts\sp\utility::_id_116CB("marscrib");
  scripts\sp\utility::_id_F343("staging_area");
  scripts\sp\utility::_id_1749("staging_area", scripts\sp\maps\marscrib\marscrib_staging::_id_10D30, "Staging Area", scripts\sp\maps\marscrib\marscrib_staging::_id_B237, ["marscrib_tr"]);
  scripts\sp\utility::_id_1749("enter_dropship", scripts\sp\maps\marscrib\marscrib_takeoff::_id_10C22, "Enter Dropship", scripts\sp\maps\marscrib\marscrib_takeoff::_id_B1C5, ["marscrib_tr"]);
  scripts\sp\utility::_id_1749("takeoff", scripts\sp\maps\marscrib\marscrib_takeoff::_id_10D40, "Takeoff", scripts\sp\maps\marscrib\marscrib_takeoff::_id_B23C, ["marscrib_tr"]);
  _id_D83F();
  scripts\sp\load::main();
  _id_D704();
}

_id_D83F() {
  scripts\sp\maps\marscrib\gen\marscrib_art::main();
  scripts\sp\maps\marscrib\marscrib_fx::main();
  scripts\sp\maps\marscrib\marscrib_precache::main();
  scripts\sp\maps\marscrib\marscrib_anim::main();
  scripts\sp\maps\marscrib\marscrib_staging::_id_10B48();
  _id_0F2F::_id_1355F();
  _id_9809();
  scripts\sp\utility::_id_1263F("marscrib_tr");
}

_id_9809() {
  scripts\sp\maps\marscrib\marscrib_staging::_id_10B47();
  scripts\sp\maps\marscrib\marscrib_takeoff::_id_6E6F();
}

_id_D704() {
  setsaveddvar("r_umbraMinObjectContribution", 10);
  setsaveddvar("sm_sunSampleSizeNear", 0.75);
  setsaveddvar("r_sdfShadowPenumbra", 0.2);
  setsaveddvar("r_spotlightEntityShadows", 1);
  _id_0EE8::_id_2252(undefined, level._id_EC85["player_rig"]["player_armory_use"]);
  scripts\engine\utility::array_call(getEntArray("locker_object", "script_noteworthy"), ::hide);
  thread _id_570F();
}

_id_570F() {
  var_0 = [];
  var_0[0] = (50264, -80296, -14583);
  var_0[1] = (52194, -83446, -13968);
  var_0[2] = (53593, -86606, -13462);
  var_0[3] = (54129, -89256, -13261);
  var_0[4] = (54077, -92637, -13072);
  var_0[5] = (49553, -100891, -8327);
  var_0[6] = (55791, -99469, -9133);
  var_0[7] = (45892, -109934, -4869);

  for(;;) {
    var_1 = randomintrange(0, 7);
    var_2 = randomintrange(0, 4);

    if(var_2 == 0)
      playworldsound("marscrib_distant_destruction_crumble", var_0[var_1]);
    else if(var_2 == 1)
      playworldsound("marscrib_distant_destruction_explo", var_0[var_1]);
    else if(var_2 == 2)
      playworldsound("marscrib_distant_destruction_metal", var_0[var_1]);
    else if(var_2 == 3)
      playworldsound("marscrib_distant_destruction_metal_groans", var_0[var_1]);

    wait(randomintrange(4, 10));
  }
}