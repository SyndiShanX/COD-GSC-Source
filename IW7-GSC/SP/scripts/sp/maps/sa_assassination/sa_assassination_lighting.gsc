/**************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_lighting.gsc
**************************************************************************/

main() {
  thread _id_1345D();
  thread _id_13458();
  thread _id_13459();
  thread _id_1345E();
  thread _id_1345B();
  thread _id_1347E();
}

_id_E985() {
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
}

_id_1345D() {
  level.player endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_server");
    scripts\engine\utility::flag_clear("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_exfil");
    scripts\engine\utility::flag_clear("visionset_under");
    visionsetalternate(5, 4);
    wait 0.05;
  }
}

_id_1345E() {
  level endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_server");
    scripts\engine\utility::flag_clear("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_exfil");
    scripts\engine\utility::flag_clear("visionset_under");
    visionsetalternate(2, 4);
    wait 0.05;
  }
}

_id_13459() {
  level endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_server");
    scripts\engine\utility::flag_clear("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_exfil");
    scripts\engine\utility::flag_clear("visionset_under");
    visionsetalternate(3, 4);
    wait 0.05;
  }
}

_id_13458() {
  level endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_server");
    scripts\engine\utility::flag_clear("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_exfil");
    scripts\engine\utility::flag_clear("visionset_under");
    visionsetalternate(6, 4);
    wait 0.05;
  }
}

_id_1345B() {
  level endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_exfil");
    scripts\engine\utility::flag_clear("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_server");
    scripts\engine\utility::flag_clear("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_under");
    visionsetalternate(0, 4);
    wait 0.05;
  }
}

_id_1347E() {
  level endon("death");
  level._id_E99E["exfil_door"] endon("trigger");

  for(;;) {
    scripts\engine\utility::flag_wait("visionset_under");
    scripts\engine\utility::flag_clear("visionset_interior");
    scripts\engine\utility::flag_clear("visionset_server");
    scripts\engine\utility::flag_clear("visionset_conference");
    scripts\engine\utility::flag_clear("visionset_assist");
    scripts\engine\utility::flag_clear("visionset_exfil");
    visionsetalternate(4, 4);
    wait 0.05;
  }
}

_id_1345C() {
  visionsetalternate(1, 4);
}