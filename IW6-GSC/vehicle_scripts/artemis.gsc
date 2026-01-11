/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\artemis.gsc
***************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("artemis", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_artemis_30", "vehicle_artemis_30_dest");
  var_3 = [];
  var_3["vehicle_artemis_30"] = "fx/explosions/vehicle_explosion_bmp";
  maps\_vehicle::build_deathfx(var_3[var_0], undefined, "exp_armor_vehicle", undefined, undefined, undefined, 0);
  maps\_vehicle::build_mainturret("tag_flash_left", "tag_flash_right");
  maps\_vehicle::build_radiusdamage((0, 0, 53), 512, 300, 20, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims);
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }

  var_0[0].sittag = "tag_gunner";
  var_0[0].idle = % artemis_idle;
  return var_0;
}