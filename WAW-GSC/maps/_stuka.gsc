/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stuka.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include common_scripts\utility;

main(model, type) {
  build_template("stuka", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_stuka_flying", "vehicle_stuka_flying");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(99999, 5000, 15000);
  build_team("axis");
  maps\_planeweapons::build_bomb_explosions(level.vttype, 0.5, 2.0, 1024, 768, 400, 25);
  maps\_planeweapons::build_bombs(level.vttype, "aircraft_bomb", "explosions/fx_mortarExp_dirt", "artillery_explosion");

  turretType = "stuka_mg";
  turretModel = "weapon_machinegun_tiger";
  build_turret(turretType, "tag_gunLeft", turretModel, true);
  build_turret(turretType, "tag_gunRight", turretModel, true);
}
init_local() {
  wait(0.05);
  self thread maps\_mgturret::link_turrets(self.mgturret);

  if(isDefined(self.script_numbombs) && self.script_numbombs > 0) {
    self thread maps\_planeweapons::bomb_init(self.script_numbombs);
  }
}