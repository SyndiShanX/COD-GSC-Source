/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_camera.gsc
***************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("camera", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_camera");
}

init_local() {}