/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\vision.gsc
***********************************************/

init_vision() {
  if(!isDefined(level.visionthermaldefault))
    level.visionthermaldefault = "black_bw";

  if(!isDefined(level.visionnakeddefault))
    level.visionnakeddefault = "";

  visionsetthermal(level.visionthermaldefault);
  thread init_pain();
  thread clear_snake();
  thread clear_vision();
}

init_pain() {
  wait 0.2;
  visionsetpain("damage_dead");
}

set_vision_naked(var_0, var_1) {
  level.visionnakeddefault = var_0;
  visionsetnaked(var_0, var_1);
}

clear_vision() {
  visionsetnaked(level.visionnakeddefault, 0.0);
}

clear_snake() {
  visionsetfadetoblack("", 0.0);
}