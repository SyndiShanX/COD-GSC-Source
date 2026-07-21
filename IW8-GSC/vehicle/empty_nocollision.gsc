/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\empty_nocollision.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template(var_1, var_0, undefined, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(90000);
  scripts\common\vehicle_build::build_is_airplane();
}

init_local() {
  self.disable_wash = 1;
  self hideallparts();
}