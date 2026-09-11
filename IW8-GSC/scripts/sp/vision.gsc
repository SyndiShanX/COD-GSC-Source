/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vision.gsc
***********************************************/

function init_vision() {
  if(!isDefined(level.visionthermaldefault)) {
    level.visionthermaldefault = "black_bw";
  }

  if(!isDefined(level.visionnakeddefault)) {
    level.visionnakeddefault = "";
  }

  visionsetthermal(level.visionthermaldefault);
  thread init_pain();
  thread clear_snake();
  thread clear_vision();
}

function init_pain() {
  wait 0.2;
  visionsetpain("damage_dead");
}

function set_vision_naked(var_0, var_1) {
  level.visionnakeddefault = var_0;
  visionsetnaked(var_0, var_1);
}

function clear_vision() {
  visionsetnaked(level.visionnakeddefault, 0);
}

function clear_snake() {
  visionsetfadetoblack("", 0);
}