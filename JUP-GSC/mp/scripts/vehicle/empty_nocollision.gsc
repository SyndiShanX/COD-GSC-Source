/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_nocollision.gsc
*************************************************/

#using scripts\common\vehicle_build;
#namespace empty_nocollision;

function main(model, type, classname) {
  build_template(type, model, undefined, classname);
  build_localinit(&init_local);
  build_life(90000);
  build_is_airplane();
}

function init_local() {
  self.disable_wash = 1;
  self hideallparts();
}