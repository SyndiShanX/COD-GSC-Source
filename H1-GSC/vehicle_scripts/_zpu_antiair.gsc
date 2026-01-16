/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_zpu_antiair.gsc
********************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("zpu_antiair", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_zpu4", "vehicle_zpu4_burn");
  maps\_vehicle::build_deathmodel("vehicle_zpu4_low", "vehicle_zpu4_burn");
  maps\_vehicle::build_deathmodel("vehicle_zpu4_nowheels", "vehicle_zpu4_nowheels_burn");
  var_3 = [];
  var_3["vehicle_zpu4"] = "fx\explosions\large_vehicle_explosion";
  var_3["vehicle_zpu4_low"] = "fx\explosions\large_vehicle_explosion";
  var_3["vehicle_zpu4_nowheels"] = "fx\explosions\large_vehicle_explosion";
  maps\_vehicle::build_deathfx(var_3[var_0], undefined, "exp_armor_vehicle", undefined, undefined, undefined, 0);
  maps\_vehicle::build_mainturret("tag_flash", "tag_flash2", "tag_flash1", "tag_flash3");
  maps\_vehicle::build_radiusdamage((0, 0, 53), 512, 300, 20, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_turret_fire = % zpu_gun_fire_a;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[0].idle = % zpu_gunner_fire_a;
  return var_0;
}