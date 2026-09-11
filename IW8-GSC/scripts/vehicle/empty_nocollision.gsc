/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_nocollision.gsc
*************************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template(var1, var0, undefined, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_life(90000);
  scripts\common\vehicle_build::build_is_airplane();
}

function init_local() {
  self.disable_wash = 1;
  self hideallparts();
}