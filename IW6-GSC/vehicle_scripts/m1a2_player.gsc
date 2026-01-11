/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\m1a2_player.gsc
*******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("m1a2", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_m1a2_abrams_iw6", "vehicle_m1a2_abrams_iw6_dmg", 0.25);
  maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vehicle/vfx_big_tank_explosion", "tag_deathfx", "exp_armor_vehicle", undefined, undefined, undefined, 0, undefined, undefined, undefined, 10);
  maps\_vehicle::build_drive( % abrams_movement, % abrams_movement_backwards, 10);
  maps\_vehicle::build_exhaust("fx/distortion/abrams_exhaust");
  maps\_vehicle::build_deckdust("fx/dust/abrams_deck_dust");
  maps\_vehicle::build_team("allies");

  if(issubstr(var_2, "_minigunonly")) {
    maps\_vehicle::build_turret("minigun_m1a1", "tag_turret_mg_r", "weapon_m1a1_minigun", undefined, "sentry", undefined, 0, 0);
  }
  else {
    if(issubstr(var_2, "_turret")) {
      maps\_vehicle::build_turret("m1a1_coaxial_mg", "tag_barrel", "vehicle_m1a1_abrams_PKT_Coaxial_MG", undefined, undefined, undefined, 0, 0, (6, -13.5, 8));
      maps\_vehicle::build_turret("minigun_m1a1_fast", "tag_turret_mg_r", "weapon_mk47_turret", undefined, "sentry", undefined, 0, 0);
      maps\_vehicle::build_mainturret();
    }

    if(!issubstr(var_2, "_noturrets")) {
      maps\_vehicle::build_turret("m1a1_coaxial_mg", "tag_barrel", "vehicle_m1a1_abrams_PKT_Coaxial_MG_inv", undefined, undefined, undefined, 0, 0, (6, -13.5, 8));
      maps\_vehicle::build_mainturret();
    }
  }

  if(!issubstr(var_2, "_viewmodel")) {
    maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/tread_sand_satfarm");
  }
  else {
    maps\_vehicle::build_treadfx();
  }

  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_frontarmor(1);
}

init_local() {
  waittillframeend;

  foreach(var_1 in self.riders) {
  var_1 thread maps\_utility::magic_bullet_shield(1);
  }
}

set_vehicle_anims(var_0) {
  var_1 = 0;
  var_0[var_1].vehicle_turret_fire = % abrams_loader_shell;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];
  var_1 = 0;
  var_2 = spawnStruct();
  var_2.idle = % abrams_loader_load;
  var_2.turret_fire = % abrams_loader_load;
  var_2.turret_fire_tag = "tag_guy1";
  var_2.sittag = "tag_guy1";
  var_0[var_1] = var_2;
  var_1 = 1;
  var_2 = spawnStruct();
  var_2.idle = % hamburg_tank_driver_afterfall_loop;
  var_2.sittag = "tag_guy0";
  var_0[var_1] = var_2;
  var_1 = 2;
  var_2 = spawnStruct();
  var_2.mgturret = 0;
  var_2.sittag = "tag_turret_mg_r";
  var_2.sittag_offset = (0, 0, -40);
  var_0[var_1] = var_2;
  return var_0;
}