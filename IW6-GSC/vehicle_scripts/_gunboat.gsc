/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_gunboat.gsc
****************************************/

main(var_0, var_1, var_2) {
  fx();
  maps\_vehicle::build_template("gunboat", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathfx("vfx/gameplay/vehicles/gunboat/vfx_exp_gunboat", "tag_death_fx", undefined, undefined, undefined, undefined, 0, 1, undefined, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_turret("dshk_gunboat", "tag_turret", "weapon_dshk");
}

fx() {
  level._effect["gunboat_wake"] = loadfx("vfx/gameplay/vehicles/gunboat/vfx_wake_gunboat");
}

init_local() {
  thread wake_fx();
}

wake_fx() {
  playFXOnTag(common_scripts\utility::getfx("gunboat_wake"), self, "j_bodymid");
  self waittill("death");

  if(isDefined(self))
    stopFXOnTag(common_scripts\utility::getfx("gunboat_wake"), self, "j_bodymid");
}