/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_truck_gaz63.gsc
**************************************/

#include maps\_vehicle;
#include maps\_utility;
#include common_scripts\utility;

main(model, type) {
  if(self.vehicletype == "truck_gaz63_player_single50_physics")
    build_aianims(::set_50cal_gunner_anims, ::set_50cal_vehicle_anims);
  else if(self.vehicletype == "truck_gaz63_player_single50" || self.vehicletype == "truck_gaz63_player_single50_nodeath")
    build_aianims(::set_gunner_anims, ::set_gunner_vehicle_anims);
  else if(self.vehicletype == "truck_gaz63_player_single50_bulletdamage")
    build_aianims(::set_gunner_anims, ::set_gunner_vehicle_anims);
  else
    build_aianims(::setanims, ::set_vehicle_anims);

  build_unload_groups(::unload_groups);

  if(issubstr(self.vehicletype, "_low"))
    self thread attach_truck_bed_low();
  else
    self thread attach_truck_bed();

  self thread turret_sound_init();
}

turret_sound_init() {
  self.sound_org = spawn("script_origin", self.origin);
  self.sound_org linkto(self);

  switch (self.vehicletype) {
    case "truck_gaz63_quad50":
      self.sound_org.soundalias = "wpn_gaz_quad50_turret_loop_npc";
      break;
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_player_single50_physics":
    case "truck_gaz63_single50":
      self.sound_org.soundalias = "wpn_gaz_single50_turret_loop_npc";
      break;
    default:
      self.sound_org.soundalias = "wpn_gaz_quad50_turret_loop_npc";
      break;
  }

  self.sound_org.flux = "wpn_gaz_quad50_flux_npc_l";
  self waittill("death");
  self.sound_org delete();
}

attach_truck_bed() {
  bed_base = "t5_veh_gaz66_flatbed";
  bed_dead = "t5_veh_gaz66_flatbed_dead";

  switch (self.vehicletype) {
    case "truck_gaz63_canvas":
      self attach(bed_base, "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_canvas_camorack":
      self attach("t5_veh_gaz66_troops", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_flatbed":
    case "truck_gaz63_flatbed_camorack":
      self attach(bed_base, "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_tanker":
      self attach("t5_veh_gaz66_tanker", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_troops":
    case "truck_gaz63_troops_bulletdamage":
    case "truck_gaz63_troops_camorack":
      self attach("t5_veh_gaz66_troops", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_camorack":
      self attach("t5_veh_truck_gaz63_camo_rack", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_quad50":
      self attach("t5_veh_gaz66_quad50");
      break;
    case "truck_gaz63_single50":
      self attach("t5_veh_gaz66_single50");
      break;
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_player_single50_nodeath":
      self attach(bed_base, "tag_origin_animate_jnt");
      self attach("t5_veh_gunner_turret_enemy_50cal", "tag_gunner_attach");
      break;
    case "truck_gaz63_player_single50_physics":
      self attach(bed_base, "tag_origin_animate_jnt");
      self attach("t5_veh_gunner_turret_enemy_50cal", "tag_gunner_attach");
      break;
    default:
      break;
  }

  self waittill("death");

  if(!isDefined(self) || !isDefined(self.vehicletype)) {
    return;
  }
  switch (self.vehicletype) {
    case "truck_gaz63_canvas_camorack":
      self detach("t5_veh_gaz66_troops", "tag_origin_animate_jnt");
      self detach("t5_veh_gaz66_canvas", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_troops_dead", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas_dead", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_canvas":
      self detach(bed_base, "tag_origin_animate_jnt");
      self detach("t5_veh_gaz66_canvas", "tag_origin_animate_jnt");
      self attach(bed_dead, "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas_dead", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_flatbed":
    case "truck_gaz63_flatbed_camorack":
      self detach(bed_base, "tag_origin_animate_jnt");
      self attach(bed_dead, "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_tanker":
      self detach("t5_veh_gaz66_tanker", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_tanker_dead", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_troops":
    case "truck_gaz63_troops_bulletdamage":
    case "truck_gaz63_troops_camorack":
      self detach("t5_veh_gaz66_troops", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_troops_dead", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_camorack":
      break;
    case "truck_gaz63_quad50":
      self detach("t5_veh_gaz66_quad50");
      self attach("t5_veh_gaz66_quad50_dead");
      break;
    case "truck_gaz63_single50":
      self detach("t5_veh_gaz66_single50");
      self attach("t5_veh_gaz66_single50_dead");
      break;
    case "truck_gaz63_player_single50":
    case "truck_gaz63_player_single50_bulletdamage":
    case "truck_gaz63_player_single50_physics":
      self detach(bed_base, "tag_origin_animate_jnt");
      self detach("t5_veh_gunner_turret_enemy_50cal", "tag_gunner_attach");
      self attach(bed_dead, "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_player_single50_nodeath":
      break;
    default:
      break;
  }
}

attach_truck_bed_low() {
  bed_base = "t5_veh_gaz66_flatbed_low";
  bed_dead = "t5_veh_gaz66_flatbed_dead_low";

  switch (self.vehicletype) {
    case "truck_gaz63_canvas_low":
      self attach(bed_base, "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_flatbed_low":
      self attach(bed_base, "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_tanker_low":
      self attach("t5_veh_gaz66_tanker_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_troops_low":
      self attach("t5_veh_gaz66_troops_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_camorack_low":
      self attach("t5_veh_truck_gaz63_camo_rack_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_quad50_low":
    case "truck_gaz63_quad50_low_no_deathmodel":
      self attach("t5_veh_gaz66_quad50_low");
      break;
    case "truck_gaz63_single50_low":
      self attach("t5_veh_gaz66_single50_low");
      break;
    default:
      break;
  }

  self waittill("death");

  if(!isDefined(self) || !isDefined(self.vehicletype)) {
    return;
  }
  switch (self.vehicletype) {
    case "truck_gaz63_canvas_low":
      self detach(bed_base, "tag_origin_animate_jnt");
      self detach("t5_veh_gaz66_canvas_low", "tag_origin_animate_jnt");
      self attach(bed_dead, "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_canvas_dead_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_flatbed_low":
      self detach(bed_base, "tag_origin_animate_jnt");
      self attach(bed_dead, "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_tanker_low":
      self detach("t5_veh_gaz66_tanker_low", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_tanker_dead_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_troops_low":
      self detach("t5_veh_gaz66_troops_low", "tag_origin_animate_jnt");
      self attach("t5_veh_gaz66_troops_dead_low", "tag_origin_animate_jnt");
      break;
    case "truck_gaz63_camorack_low":
      break;
    case "truck_gaz63_quad50_low":
      self detach("t5_veh_gaz66_quad50_low");
      self attach("t5_veh_gaz66_quad50_dead_low");
      break;
    case "truck_gaz63_single50_low":
      self detach("t5_veh_gaz66_single50_low");
      self attach("t5_veh_gaz66_single50_dead_low");
      break;
    default:
      break;
  }
}

#using_animtree("vehicles");

set_vehicle_anims(positions) {
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy6";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy8";
  positions[6].sittag = "tag_guy5";
  positions[7].sittag = "tag_guy2";
  positions[8].sittag = "tag_guy7";
  positions[9].sittag = "tag_guy4";
  positions[0].vehicle_getoutanim_clear = 0;
  positions[1].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getinanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getinanim = % v_gaz63_passenger_door_open;
  positions[0].vehicle_getoutanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getoutanim = % v_gaz63_passenger_door_open;
  return positions;
}

set_gunner_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

set_gunner_anims() {
  positions = [];

  for(i = 0; i < 3; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_gunner1";
  positions[2].vehiclegunner = 1;
  positions[2].idle = % ai_50cal_gunner_aim;
  positions[2].aimup = % ai_50cal_gunner_aim_up;
  positions[2].aimdown = % ai_50cal_gunner_aim_down;
  return positions;
}

#using_animtree("vehicles");

set_50cal_vehicle_anims(positions) {
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_gunner1";
  positions[0].vehicle_getoutanim_clear = 0;
  positions[1].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getinanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getinanim = % v_gaz63_passenger_door_open;
  positions[0].vehicle_getoutanim = % v_gaz63_driver_door_open;
  positions[1].vehicle_getoutanim = % v_gaz63_passenger_door_open;
  return positions;
}

#using_animtree("generic_human");

set_50cal_gunner_anims() {
  positions = [];

  for(i = 0; i < 3; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_gunner1";
  positions[2].vehiclegunner = 1;
  positions[2].idle = % ai_50cal_gunner_aim;
  positions[2].aimup = % ai_50cal_gunner_aim_up;
  positions[2].aimdown = % ai_50cal_gunner_aim_down;
  positions[0].getout = % crew_truck_driver_climbout;
  positions[1].getout = % crew_truck_passenger_climbout;
  positions[2].getout = % crew_truck_guy1_climbout;
  positions[0].getout_combat = % crew_gaz63_driver_jump_out;
  positions[1].getout_combat = % crew_gaz63_passenger_climbout_fast;
  positions[2].getout_combat = % crew_truck_guy1_climbout_fast;
  positions[0].idle = % crew_truck_driver_sit_idle;
  positions[1].idle = % crew_gaz63_passenger_sit_idle;
  return positions;
}

setanims() {
  positions = [];

  for(i = 0; i < 10; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy6";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy8";
  positions[6].sittag = "tag_guy5";
  positions[7].sittag = "tag_guy2";
  positions[8].sittag = "tag_guy7";
  positions[9].sittag = "tag_guy4";
  positions[0].getout = % crew_truck_driver_climbout;
  positions[1].getout = % crew_truck_passenger_climbout;
  positions[2].getout = % crew_truck_guy1_climbout;
  positions[3].getout = % crew_truck_guy6_climbout;
  positions[4].getout = % crew_truck_guy3_climbout;
  positions[5].getout = % crew_truck_guy8_climbout;
  positions[6].getout = % crew_truck_guy5_climbout;
  positions[7].getout = % crew_truck_guy2_climbout;
  positions[8].getout = % crew_truck_guy7_climbout;
  positions[9].getout = % crew_truck_guy4_climbout;
  positions[0].getout_combat = % crew_gaz63_driver_jump_out;
  positions[1].getout_combat = % crew_gaz63_passenger_climbout_fast;
  positions[2].getout_combat = % crew_truck_guy1_climbout_fast;
  positions[3].getout_combat = % crew_truck_guy6_climbout_fast;
  positions[4].getout_combat = % crew_truck_guy3_climbout;
  positions[5].getout_combat = % crew_truck_guy8_climbout;
  positions[6].getout_combat = % crew_truck_guy5_climbout_fast;
  positions[7].getout_combat = % crew_truck_guy2_climbout_fast;
  positions[8].getout_combat = % crew_truck_guy7_climbout;
  positions[9].getout_combat = % crew_truck_guy4_climbout;
  positions[0].idle = % crew_truck_driver_sit_idle;
  positions[1].idle = % crew_gaz63_passenger_sit_idle;
  positions[2].idle = % crew_truck_guy1_sit_idle;
  positions[3].idle = % crew_truck_guy6_sit_idle;
  positions[4].idle = % crew_truck_guy3_sit_idle;
  positions[5].idle = % crew_truck_guy8_sit_idle;
  positions[6].idle = % crew_truck_guy5_sit_idle;
  positions[7].idle = % crew_truck_guy2_sit_idle;
  positions[8].idle = % crew_truck_guy7_sit_idle;
  positions[9].idle = % crew_truck_guy4_sit_idle;
  positions[2].explosion_death = % death_explosion_forward13;
  positions[3].explosion_death = % death_explosion_left11;
  positions[4].explosion_death = % death_explosion_left11;
  positions[5].explosion_death = % death_explosion_back13;
  positions[6].explosion_death = % death_explosion_forward13;
  positions[7].explosion_death = % death_explosion_right13;
  positions[8].explosion_death = % death_explosion_right13;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  unload_groups["passengers"] = [];
  unload_groups["rear_passengers"] = [];
  unload_groups["driver"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;
  unload_groups[group][unload_groups[group].size] = 8;
  unload_groups[group][unload_groups[group].size] = 9;
  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;
  unload_groups[group][unload_groups[group].size] = 8;
  unload_groups[group][unload_groups[group].size] = 9;
  group = "rear_passengers";
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;
  unload_groups[group][unload_groups[group].size] = 8;
  unload_groups[group][unload_groups[group].size] = 9;
  group = "driver";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups["default"] = unload_groups["passengers"];
  return unload_groups;
}