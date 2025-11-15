/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_aircraft.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include common_scripts\utility;

main(model, type, max_turrets, build_bombs, non_default_turret_type) {
  build_template("stuka", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_usa_aircraft_f4ucorsair", "vehicle_usa_aircraft_f4ucorsair");
  build_deathmodel("vehicle_usa_aircraft_pel1_f4ucorsair", "vehicle_usa_aircraft_pel1_f4ucorsair");
  build_deathmodel("vehicle_usa_aircraft_f4ucorsair_dist", "vehicle_usa_aircraft_f4ucorsair_dist");
  build_deathmodel("vehicle_stuka_flying", "vehicle_stuka_flying");
  build_deathmodel("vehicle_p51_mustang", "vehicle_p51_mustang");
  build_deathmodel("vehicle_spitfire_flying", "vehicle_spitfire_flying");
  build_deathmodel("vehicle_rus_airplane_il2", "vehicle_rus_airplane_il2");
  build_deathmodel("vehicle_jap_airplane_rufe_fly", "vehicle_jap_airplane_rufe_fly");
  build_deathmodel("vehicle_brt_aircraft_spitfire", "vehicle_brt_aircraft_spitfire");
  build_deathmodel("weapon_ger_panzershreck_rocket", "weapon_ger_panzershreck_rocket");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(99999, 5000, 15000);
  build_treadfx();
  if(model == "vehicle_stuka_flying" || model == "vehicle_jap_airplane_rufe_fly") {
    build_team("axis");
  } else {
    build_team("allies");
  }
  if(!isDefined(build_bombs) || build_bombs) {
    maps\_planeweapons::build_bomb_explosions(type, 0.5, 2.0, 1024, 768, 400, 25);
    maps\_planeweapons::build_bombs(type, "aircraft_bomb", "explosions/fx_mortarExp_dirt", "mortar_dirt");
  }
  if(isDefined(non_default_turret_type)) {
    turretType = non_default_turret_type;
  } else if(type == "corsair") {
    turretType = "corsair_mg";
  } else {
    turretType = "allied_coaxial_mg";
  }
  turretModel = "weapon_machinegun_tiger";
  if(model == "vehicle_jap_airplane_zero_fly") {
    build_turret(turretType, "tag_flash_gunner1", turretModel, true, undefined, undefined, undefined, undefined, max_turrets);
    build_turret(turretType, "tag_flash_gunner2", turretModel, true, undefined, undefined, undefined, undefined, max_turrets);
  } else {
    build_turret(turretType, "tag_gunLeft", turretModel, true, undefined, undefined, undefined, undefined, max_turrets);
    build_turret(turretType, "tag_gunRight", turretModel, true, undefined, undefined, undefined, undefined, max_turrets);
  }
}

init_local() {
  wait(0.05);
  self thread maps\_mgturret::link_turrets(self.mgturret);
  if(isDefined(self.script_numbombs) && self.script_numbombs > 0) {
    self thread maps\_planeweapons::bomb_init(self.script_numbombs);
  }
}