/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\vehicle\empty_heli.gsc
***********************************************/

#using scripts\common\vehicle_build;
#namespace empty_heli;

function main(model, type, classname) {
  build_template("empty_heli", model, type, classname);
  build_is_helicopter("empty_heli");
}