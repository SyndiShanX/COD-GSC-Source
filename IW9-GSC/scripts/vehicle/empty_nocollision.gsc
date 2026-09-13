/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_nocollision.gsc
*************************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template(type, model, undefined, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(90000);
  scripts\common\vehicle_build::build_is_airplane();
}

init_local() {
  self.disable_wash = 1;
  self hideallparts();
}