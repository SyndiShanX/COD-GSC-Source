/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_tiger.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type, no_mantle) {
  build_template("tiger", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_ger_tracked_king_tiger", "vehicle_ger_tracked_king_tiger_d");
  build_deathmodel("vehicle_ger_tracked_king_tiger_winter", "vehicle_ger_tracked_king_tiger_winter");
  build_shoot_shock("tankblast");
  build_shoot_rumble("tank_fire");
  build_exhaust("vehicle/exhaust/fx_exhaust_tiger");
  build_deathfx("vehicle/vexplosion/fx_vexplode_ger_kingtiger", "tag_origin", "explo_metal_rand");

  build_deathquake(0.8, 1.0, 600);
  build_turret("tiger_coaxial_mg", "front_turretgun", "weapon_machinegun_tiger", false);
  build_treadfx(type);
  build_life(999, 500, 1500);
  build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  build_team("axis");
  build_mainturret();
  build_compassicon();
  build_aianims(::setanims, ::set_vehicle_anims);
  build_frontarmor(.33);

  if(!isDefined(no_mantle) || !no_mantle) {
    level thread maps\_tankmantle::build_tank_mantle(model, type);
  }
}
init_local() {
  if(!isDefined(self.script_nomantle) || !self.script_nomantle) {
    self maps\_tankmantle::init();
  }
}
#using_animtree("tank");
set_vehicle_anims(positions) {
  return positions;
}
#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 10; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_guy1";
  positions[1].sittag = "tag_guy2";
  positions[2].sittag = "tag_guy3";
  positions[3].sittag = "tag_guy4";
  positions[4].sittag = "tag_guy5";
  positions[5].sittag = "tag_guy6";
  positions[6].sittag = "tag_guy7";
  positions[7].sittag = "tag_guy8";
  positions[8].sittag = "tag_guy9";
  positions[9].sittag = "tag_guy10";

  return positions;
}