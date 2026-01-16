/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_boat_pbr.gsc
**************************************/

#include maps\_vehicle;

main(model, type) {
  build_aianims(::setanims, ::set_vehicle_anims);
  self thread attach_boat_equipment();
}

attach_boat_equipment() {
  if(self.vehicletype == "boat_pbr") {
    boat_cage = "t5_veh_boat_pbr_set01_friendly";
    waterbox = "t5_veh_boat_pbr_waterbox";
    self Attach(boat_cage, "tag_origin_animate");
    self Attach(waterbox, "tag_origin_animate");
  } else {
    boat_cage = "t5_veh_boat_pbr_set01";
    boat_deco = "t5_veh_boat_pbr_stuff";
    self Attach(boat_cage, "tag_origin_animate");
    self Attach(boat_deco, "tag_origin_animate");
  }
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  positions[0] = spawnstruct();
  positions[0].sittag = "tag_gunner_turret1";
  positions[0].vehiclegunner = 1;
  positions[0].idle = % ai_boat_pbr_gunner_aim;
  positions[0].aimup = % ai_boat_pbr_gunner_aim_up;
  positions[0].aimdown = % ai_boat_pbr_gunner_aim_down;
  return positions;
}