/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_empambush\sa_empambush_lighting.gsc
******************************************************************/

main() {
  _id_ACB8();
  thread _id_1346E();
  thread _id_1346F();
  thread _id_13470();
}

_id_ACB8() {
  scripts\engine\utility::flag_init("set_visionset_interior_enter");
  scripts\engine\utility::flag_init("set_visionset_interior_exit");
  scripts\engine\utility::flag_init("set_visionset_interior_transition");
}

_id_1346E() {
  level endon("death");
  level endon("nextmission");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_interior_enter");
    scripts\engine\utility::flag_clear("set_visionset_interior_exit");
    scripts\engine\utility::flag_clear("set_visionset_interior_transition");
    setsaveddvar("sm_sunSampleSizeNear", 0.65);
    visionsetalternate(2, 5);
    wait 0.05;
  }
}

_id_1346F() {
  level endon("death");
  level endon("nextmission");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_interior_exit");
    scripts\engine\utility::flag_clear("set_visionset_interior_enter");
    scripts\engine\utility::flag_clear("set_visionset_interior_transition");
    setsaveddvar("sm_sunSampleSizeNear", 0.25);
    visionsetalternate(3, 5);
    wait 0.05;
  }
}

_id_13470() {
  level endon("death");
  level endon("nextmission");

  for(;;) {
    scripts\engine\utility::flag_wait("set_visionset_interior_transition");
    scripts\engine\utility::flag_clear("set_visionset_interior_exit");
    scripts\engine\utility::flag_clear("set_visionset_interior_enter");
    setsaveddvar("sm_sunSampleSizeNear", 0.65);
    visionsetalternate(1, 5);
    wait 0.05;
  }
}