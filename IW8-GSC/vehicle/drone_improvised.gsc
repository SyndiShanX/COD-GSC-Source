/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\drone_improvised.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("drone_improvised", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_ind_air_bombing_drone");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/aerial_explosion_hind_chernobyl", "tag_origin", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx");
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims);
  scripts\common\vehicle_build::build_is_helicopter("drone_improvised");
}

init_local() {
  self.script_badplace = 0;
}

setanims() {}

set_vehicle_anims(var_0) {}

unload_groups() {}