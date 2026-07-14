/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\vision.gsc
**************************************/

#namespace vision;

function init_vision() {
  if(!isDefined(level.visionthermaldefault)) {
    level.visionthermaldefault = "X\x815\x95\xed,\x02R";
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
  [[level.sharedfuncs[#"fullscreenfx"][#"setpain"]]]({
    #postfxbundlename: undefined, #visionsetname: "\x9e=^/\x01\xaa\x1e\x8d\xa7\xc2\x1e"});
}

function set_vision_naked(var_739c14ef3a4e8535, blendtime) {
  level.visionnakeddefault = var_739c14ef3a4e8535;
  visionsetnaked(var_739c14ef3a4e8535, blendtime);
}

function clear_vision() {
  visionsetnaked(level.visionnakeddefault, 0);
}

function clear_snake() {
  visionsetfadetoblack("", 0);
}