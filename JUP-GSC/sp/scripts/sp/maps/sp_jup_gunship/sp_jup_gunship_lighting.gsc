/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_lighting.gsc
**********************************************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace sp_jup_gunship_lighting;

function main() {
  utility::registersharedfunc("gunship_sp", "introDofStart", &function_7c002c199b5b00df);
  utility::registersharedfunc("gunship_sp", "introDofEnd", &function_e71c2f0a026baf4a);
  utility::registersharedfunc("gunship_sp", "introStartLighting", &function_6308b70a035f1d38);
  utility::registersharedfunc("gunship_sp", "introEndLighting", &function_ff594bb5e7381989);
  post_load_precache(&function_bf161307a213ad69);
}

function function_bf161307a213ad69() {}

function function_6308b70a035f1d38() {
  wait 0.5;
  setsundirection(anglesToForward((-16, -156, 0)));
}

function function_7c002c199b5b00df() {
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(1.5, 325, 15, 50);
}

function function_e71c2f0a026baf4a() {
  level.player disablephysicaldepthoffieldscripting();
}

function function_ff594bb5e7381989() {
  wait 0.5;
  resetsundirection();
}

function function_82fbd9a01aa6f773() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0) {
    return;
  }

  capture_models = getEntArray("lighting_capture_model", "targetname");

  foreach(cm in capture_models) {
    cm hide();
  }
}