/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\empty_heli.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("empty_heli", model, type, classname);
  scripts\common\vehicle_build::build_is_helicopter("empty_heli");
}