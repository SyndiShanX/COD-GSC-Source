/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\vision.gsc
***********************************************/

#namespace vision;

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

function set_vision_naked(var_c2d8bcafdbdac268, blendtime) {
  level.visionnakeddefault = var_c2d8bcafdbdac268;
  visionsetnaked(var_c2d8bcafdbdac268, blendtime);
}

function clear_vision() {
  visionsetnaked(level.visionnakeddefault, 0);
}

function clear_snake() {
  visionsetfadetoblack("", 0);
}