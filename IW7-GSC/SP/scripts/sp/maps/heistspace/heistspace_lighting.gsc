/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_lighting.gsc
**************************************************************/

main() {
  thread _id_1121F();
  thread _id_3B0A();
  thread _id_3B0C();
  thread _id_3B0B();
  thread _id_13472();
  thread _id_13473();
  thread _id_13474();
  thread _id_13475();
  thread _id_13476();
  thread _id_13477();
  thread _id_13478();
  thread _id_13479();
  thread _id_1347A();
  thread _id_1347B();
  thread _id_1347C();
}

_id_1121F() {
  scripts\engine\utility::flag_wait("sunflare_position_02");
  setsunflareposition((10.54, 83.51, 0));
  scripts\engine\utility::flag_wait("sunflare_position_03");
  setsunflareposition((21.36, 13.36, 0));
}

_id_3B0A() {
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "1");
  setsaveddvar("sm_sunCascadeSizeMultiplier2", "1");
}

_id_3B0C() {
  scripts\engine\utility::flag_wait("set_vision_heistspace_int_ordinance");
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "3");
}

_id_3B0B() {
  scripts\engine\utility::flag_wait("player_entering_jackal");
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "1");
}

_id_13472() {
  scripts\engine\utility::flag_wait("set_vision_heistspace_int_bridge");
  visionsetalternate(0, 0.2);
}

_id_13473() {
  scripts\engine\utility::flag_wait("set_vision_heistspace_int_a");
  visionsetalternate(1, 3);
}

_id_13474() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_b");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_navroom_a");
    visionsetalternate(1, 8);
    wait 0.05;
  }
}

_id_13475() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_navroom_a");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_b");
    visionsetalternate(2, 8);
    wait 0.05;
  }
}

_id_13476() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_navroom_b");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_dest_hallway_a");
    visionsetalternate(2, 2);
    wait 0.05;
  }
}

_id_13477() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_dest_hallway_a");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_navroom_b");
    visionsetalternate(3, 2);
    wait 0.05;
  }
}

_id_13478() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_dest_hallway_b");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_dest_hallway_02_a");
    visionsetalternate(3, 2);
    wait 0.05;
  }
}

_id_13479() {
  level endon("death");
  level endon("set_vision_heistspace_int_ordinance");

  for(;;) {
    scripts\engine\utility::flag_wait("set_vision_heistspace_int_dest_hallway_02_a");
    scripts\engine\utility::flag_clear("set_vision_heistspace_int_dest_hallway_b");
    visionsetalternate(4, 2);
    wait 0.05;
  }
}

_id_1347A() {
  scripts\engine\utility::flag_wait("set_vision_heistspace_int_ordinance");
  visionsetalternate(5, 0.5);
}

_id_1347B() {
  scripts\engine\utility::flag_wait("set_vision_heistspace_zerog");
  visionsetalternate(6, 6);
}

_id_1347C() {
  scripts\engine\utility::flag_wait("player_entering_jackal");
  visionsetalternate(7, 0.5);
}