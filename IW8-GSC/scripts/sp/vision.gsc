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

function set_vision_naked(var0, var1) {
  level.visionnakeddefault = var0;
  visionsetnaked(var0, var1);
}

function clear_vision() {
  visionsetnaked(level.visionnakeddefault, 0);
}

function clear_snake() {
  visionsetfadetoblack("", 0);
}