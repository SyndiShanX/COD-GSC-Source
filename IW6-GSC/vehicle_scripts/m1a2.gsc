/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\m1a2.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("m1a2", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_m1a2_abrams_iw6", "vehicle_m1a2_abrams_iw6_dmg");
  maps\_vehicle::build_drive( % m1a2_abrams_driving_idle_forward, % m1a2_abrams_driving_idle_backward, 10);
  maps\_vehicle::build_exhaust("fx/distortion/abrams_exhaust");
  maps\_vehicle::build_deckdust("fx/dust/abrams_deck_dust");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_m1a2_end", "tag_deathfx", "exp_armor_vehicle", undefined, undefined, undefined, 0, undefined, undefined, undefined, 10);

  if(!issubstr(var_2, "_nocoax"))
    maps\_vehicle::build_turret("dshk_gaz", "tag_coax_mg", "vehicle_m1a2_abrams_remote_gun", undefined, "auto_nonai", 0.0, 0, 0);

  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 900, 1, 1);
  maps\_vehicle::build_shoot_shock("tankblast");
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_frontarmor(0.33);
}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 11; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].getout_delete = 1;
  return var_0;
}