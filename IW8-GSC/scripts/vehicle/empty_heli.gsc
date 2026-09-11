/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_heli.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("empty_heli", var0, var1, var2);
  scripts\common\vehicle_build::build_is_helicopter("empty_heli");
}