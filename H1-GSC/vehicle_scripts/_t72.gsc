/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_t72.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("t72", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_t72_tank", "vehicle_t72_tank_d_body", 0.5);
  maps\_vehicle::build_deathmodel("vehicle_t72_tank_low", "vehicle_t72_tank_d_body", 0.5);
  maps\_vehicle::build_deathmodel("vehicle_t72_tank_woodland", "vehicle_t72_tank_d_woodland_body", 0);
  maps\_vehicle::build_shoot_shock("tankblast");
  maps\_vehicle::build_drive( % abrams_movement, % abrams_movement_backwards, 10);
  maps\_vehicle::build_deathfx("fx\explosions\vehicle_explosion_t72", "tag_deathfx", "exp_armor_vehicle", undefined, undefined, undefined, 0);
  maps\_vehicle::build_deathfx("fx\fire\firelp_large_pm", "tag_deathfx", "fire_metal_medium", undefined, undefined, 1, 0);
  maps\_vehicle::build_turret("t72_turret2", "tag_turret2", "vehicle_t72_tank_pkt_coaxial_mg");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_frontarmor(0.33);
}

init_local() {}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 11; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].getout_delete = 1;
  return var_0;
}