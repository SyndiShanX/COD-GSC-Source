/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\t90ms.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("t90ms", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);

  if(var_2 == "script_vehicle_t90ms_sand") {
    maps\_vehicle::build_deathmodel("vehicle_t90ms_tank_iw6", "vehicle_t90ms_tank_d_noturret_iw6", 0.25);
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vehicle/vfx_big_tank_explosion", "tag_deathfx", "exp_armor_vehicle", undefined, undefined, undefined, 0);
  } else {
    maps\_vehicle::build_deathmodel(var_0, "vehicle_t90ms_tank_destroyed_iw6");
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_t90ms_end", "tag_deathfx", "exp_armor_vehicle", undefined, undefined, undefined, 0);
  }

  maps\_vehicle::build_shoot_shock("tankblast");
  maps\_vehicle::build_drive( % t90ms_driving_idle_forward, % t90ms_driving_idle_forward, 10);

  if(!issubstr(var_2, "sand")) {
    maps\_vehicle::build_turret("t90_turret2", "tag_turret2", "vehicle_t90_PKT_Coaxial_MG");
  }

  if(issubstr(var_2, "_turret_flood")) {
    maps\_vehicle::build_turret("dshk_gaz_flood", "TAG_MACHINE_GUN", "vehicle_t90ms_tank_iw6_remote_gun", 1028, "auto_ai", 0.2, 20, -14);
  } else if(issubstr(var_2, "_turret")) {
    maps\_vehicle::build_turret("dshk_gaz", "TAG_MACHINE_GUN", "vehicle_t90ms_tank_iw6_remote_gun", 1028, "auto_ai", 0.2, 20, -14);
  }

  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_frontarmor(0.33);
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[0].sittag = "tag_turret_hatch";
  var_0[0].sittag_offset = (0, 0, -16);
  var_0[0].bhasgunwhileriding = 0;
  var_0[0].idle = % gaz_turret_idle;
  var_0[0].mgturret = 1;
  return var_0;
}