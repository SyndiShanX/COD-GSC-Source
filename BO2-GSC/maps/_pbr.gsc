/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_pbr.gsc
**************************************/

#include maps\_vehicle;
#include maps\_utility;

init() {
  vehicle_add_main_callback("boat_pbr_medium", ::main);
  vehicle_add_main_callback("boat_pbr_medium_breakable", ::main_breakable);
  vehicle_add_main_callback("boat_patrol_nva", ::patrol_main);
  vehicle_add_main_callback("boat_patrol_nva_river", ::patrol_main);
  precache_wake_fx();
}

main(model, type) {
  build_aianims(::setanims, ::set_vehicle_anims);
  self thread update_wake_fx("med");
}

main_breakable(model, type) {
  build_aianims(::setanims, ::set_vehicle_anims);
  self thread update_wake_fx("med");
  self thread update_damage_states();
}

patrol_main(model, type) {
  build_aianims(::patrol_setanim, ::set_patrol_vehicle_anims);
  self thread update_wake_fx("sml");
}

#using_animtree("vehicles");

set_vehicle_anims(positions) {
  positions[0].vehicle_idle = % v_crew_gunboat_front_gun_aim;
  positions[0].vehicle_aimdown = % v_crew_gunboat_front_gun_aim_down;
  positions[0].vehicle_aimup = % v_crew_gunboat_front_gun_aim_up;
  positions[0].vehicle_fire = % v_crew_gunboat_front_gun_fire;
  positions[0].vehicle_firedown = % v_crew_gunboat_front_gun_fire_down;
  positions[0].vehicle_fireup = % v_crew_gunboat_front_gun_fire_up;
  positions[1].vehicle_idle = % v_crew_gunboat_rear_gun_aim;
  positions[1].vehicle_aimdown = % v_crew_gunboat_rear_gun_aim_down;
  positions[1].vehicle_aimup = % v_crew_gunboat_rear_gun_aim_up;
  positions[1].vehicle_fire = % v_crew_gunboat_rear_gun_fire;
  positions[1].vehicle_firedown = % v_crew_gunboat_rear_gun_fire_down;
  positions[1].vehicle_fireup = % v_crew_gunboat_rear_gun_fire_up;
  return positions;
}

set_patrol_vehicle_anims(positions) {
  positions[0].vehicle_idle = % v_crew_gunboatsm_front_gun_aim;
  positions[0].vehicle_aimdown = % v_crew_gunboatsm_front_gun_aim_down;
  positions[0].vehicle_aimup = % v_crew_gunboatsm_front_gun_aim_up;
  positions[0].vehicle_fire = % v_crew_gunboatsm_front_gun_fire;
  positions[0].vehicle_firedown = % v_crew_gunboatsm_front_gun_fire_down;
  positions[0].vehicle_fireup = % v_crew_gunboatsm_front_gun_fire_up;
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  positions[0] = spawnstruct();
  positions[0].sittag = "tag_gunner1";
  positions[0].vehiclegunner = 1;
  positions[0].idle = % ai_crew_gunboat_front_gunner_aim;
  positions[0].aimup = % ai_crew_gunboat_front_gunner_aim_up;
  positions[0].aimdown = % ai_crew_gunboat_front_gunner_aim_down;
  positions[0].fire = % ai_crew_gunboat_front_gunner_fire;
  positions[0].fireup = % ai_crew_gunboat_front_gunner_fire_up;
  positions[0].firedown = % ai_crew_gunboat_front_gunner_fire_down;
  positions[0].death = % ai_crew_gunboat_front_gunner_death_front;
  positions[0].explosion_death = % ai_crew_gunboat_front_gunner_death_front;
  positions[1] = spawnstruct();
  positions[1].sittag = "tag_gunner2";
  positions[1].vehiclegunner = 2;
  positions[1].idle = % ai_crew_gunboat_rear_gunner_aim;
  positions[1].aimup = % ai_crew_gunboat_rear_gunner_aim_up;
  positions[1].aimdown = % ai_crew_gunboat_rear_gunner_aim_down;
  positions[1].fire = % ai_crew_gunboat_rear_gunner_fire;
  positions[1].fireup = % ai_crew_gunboat_rear_gunner_fire_up;
  positions[1].firedown = % ai_crew_gunboat_rear_gunner_fire_down;
  positions[1].death = % ai_crew_gunboat_rear_gunner_death_right;
  positions[1].explosion_death = % ai_crew_gunboat_rear_gunner_death_right;
  return positions;
}

patrol_setanim() {
  positions = [];
  positions[0] = spawnstruct();
  positions[0].sittag = "tag_gunner1";
  positions[0].vehiclegunner = 1;
  positions[0].idle = % ai_crew_gunboatsm_front_gunner_aim;
  positions[0].aimdown = % ai_crew_gunboatsm_front_gunner_aim_down;
  positions[0].aimup = % ai_crew_gunboatsm_front_gunner_aim_up;
  positions[0].fire = % ai_crew_gunboatsm_front_gunner_fire;
  positions[0].firedown = % ai_crew_gunboatsm_front_gunner_fire_down;
  positions[0].fireup = % ai_crew_gunboatsm_front_gunner_fire_up;
  positions[0].death = % ai_crew_gunboat_front_gunner_death_front;
  positions[0].explosion_death = % ai_crew_gunboat_front_gunner_death_front;
  return positions;
}

update_damage_states() {
  self endon("death");
  self setmodel("veh_t6_sea_gunboat_medium_damaged");
  self.front_piece_damage_level = 0;
  self attach("veh_t6_sea_gunboat_medium_wheelhouse_dmg" + self.front_piece_damage_level, "tag_wheel_house");
  self.rear_piece_damage_level = 0;
  self attach("veh_t6_sea_gunboat_medium_rear_dmg" + self.rear_piece_damage_level, "tag_rear");

  while(true) {
    self waittill("damage", damage, attacker, dir, point, mod, model, modelattachtag, part);

    if(!isDefined(self)) {
      return;
    }
    if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE" || mod == "MOD_IMPACT") {
      delta = point - self.origin;
      fwd = anglestoforward(self.angles);
      dot = vectordot(delta, fwd);

      if(dot > 0) {
        self detach("veh_t6_sea_gunboat_medium_wheelhouse_dmg" + self.front_piece_damage_level, "tag_wheel_house");
        self.front_piece_damage_level = self.front_piece_damage_level + 1;
        self.front_piece_damage_level = min(self.front_piece_damage_level, 2);
        self attach("veh_t6_sea_gunboat_medium_wheelhouse_dmg" + self.front_piece_damage_level, "tag_wheel_house");
      } else {
        self detach("veh_t6_sea_gunboat_medium_rear_dmg" + self.rear_piece_damage_level, "tag_rear");
        self.rear_piece_damage_level = self.rear_piece_damage_level + 1;
        self.rear_piece_damage_level = min(self.rear_piece_damage_level, 2);
        self attach("veh_t6_sea_gunboat_medium_rear_dmg" + self.rear_piece_damage_level, "tag_rear");
      }
    }
  }
}

precache_wake_fx() {
  level._effect["pbr_wake_med_churn_1"] = loadfx("vehicle/water/fx_wake_pbr_med_churn_1");
  level._effect["pbr_wake_med_churn_2"] = loadfx("vehicle/water/fx_wake_pbr_med_churn_2");
  level._effect["pbr_wake_med_churn_3"] = loadfx("vehicle/water/fx_wake_pbr_med_churn_3");
  level._effect["pbr_wake_sml_churn_1"] = loadfx("vehicle/water/fx_wake_pbr_sml_churn_1");
  level._effect["pbr_wake_sml_churn_2"] = loadfx("vehicle/water/fx_wake_pbr_sml_churn_2");
  level._effect["pbr_wake_sml_churn_3"] = loadfx("vehicle/water/fx_wake_pbr_sml_churn_3");
  level.boat_wake_speeds = [];
  level.boat_wake_speed[0] = 0.1;
  level.boat_wake_speed[1] = 0.5;
  level.boat_wake_speed[2] = 1.0;
}

update_wake_fx(str_size) {
  self endon("death");
  self veh_toggle_tread_fx(0);

  while(true) {
    speed = self getspeed();
    max_speed = self getmaxspeed();
    speed_pct = speed / max_speed;
    origin = self gettagorigin("tag_wake");
    z = getwaterheight(origin);
    origin = (origin[0], origin[1], z);
    angles = self.angles;
    angles = (0, angles[1], angles[2]);
    angles = (angles[0], angles[1], 0);

    if(speed_pct > 0.0 && speed_pct <= level.boat_wake_speed[0])
      playfx(level._effect["pbr_wake_" + str_size + "_churn_1"], origin, anglestoforward(angles) * -1);
    else if(level.boat_wake_speed[0] > 0.0 && speed_pct <= level.boat_wake_speed[1])
      playfx(level._effect["pbr_wake_" + str_size + "_churn_2"], origin, anglestoforward(angles) * -1);
    else if(level.boat_wake_speed[1] > 0.0 && speed_pct <= level.boat_wake_speed[2])
      playfx(level._effect["pbr_wake_" + str_size + "_churn_3"], origin, anglestoforward(angles) * -1);

    wait 0.1;
  }
}