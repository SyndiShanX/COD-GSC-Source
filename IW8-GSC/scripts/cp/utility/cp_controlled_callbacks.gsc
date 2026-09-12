/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_controlled_callbacks.gsc
**********************************************************/

function ref_12EC3(var_0) {
  var_1 = getdvarint("scr_br_aa_turret_flak_explosion_inner_radius", 500);
  var_2 = getdvarint("scr_br_aa_turret_flak_explosion_outer_radius", 1000);
  var_3 = getdvarint("scr_br_aa_turret_flak_vehicle_damage_bonus_min", 100);
  var_4 = getdvarint("scr_br_aa_turret_flak_vehicle_damage_bonus_max", 200);
  var_5 = getdvarint("scr_br_aa_turret_flak_aircraft_damage_bonus_additive_min", 100);
  var_6 = getdvarint("scr_br_aa_turret_flak_aircraft_damage_bonus_additive_max", 200);
  var_7 = getdvarint("scr_br_aa_turret_flak_ai_agent_damage_bonus_additive_min", 25);
  var_8 = getdvarint("scr_br_aa_turret_flak_ai_agent_damage_bonus_additive_max", 50);
  var_9 = getdvarint("scr_br_aa_turret_flak_projectile_speed", 550);
  var_10 = getdvarfloat("scr_br_aa_turret_flak_projectile_lifetime", 2);
  var_11 = getdvarfloat("scr_br_aa_turret_flak_projectile_lifetime_std", 1);
  var_12 = getdvarfloat("scr_br_aa_turret_flak_projectile_speed_ballistic_scalar", 35);
  var_13 = var_9 * var_10 * var_11 * var_12;
  var_14 = var_13 * 0.5;
  var_15 = getdvarfloat("scr_br_aa_turret_flak_min_damage_scalar", 0.5);
  var_16 = self;
  var_17 = var_0.attacker;
  var_18 = var_0.damage;
  var_19 = var_0.point;
  var_20 = distance(var_19, var_17.origin);
  var_21 = 1;

  if(var_20 > var_14) {
    var_21 = var_15 + (1 - var_15) * (1 - (var_20 - var_14) / (var_13 - var_14));
  }

  var_22 = 0;
  var_23 = distance(var_16.origin, var_19);

  if(var_23 <= var_1) {
    if(var_16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_22 = var_4;

      if(isDefined(var_16.vehiclename)) {
        switch (var_16.vehiclename) {
          case "veh_bt":
          case "veh_a10fd":
          case "little_bird":
            var_22 += var_6;
            break;
        }
      }
    } else if(isai(var_16)) {
      var_22 += var_8;
    }
  } else {
    var_24 = (var_23 - var_1) / (var_2 - var_1);
    var_22 = var_24 * (var_4 - var_3) + var_3;

    if(var_16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(isDefined(var_16.vehiclename)) {
        switch (var_16.vehiclename) {
          case "veh_bt":
          case "veh_a10fd":
          case "little_bird":
            var_22 += var_24 * (var_6 - var_5) + var_5;
            break;
        }
      }
    } else if(isai(var_16)) {
      var_22 += var_24 * (var_8 - var_7) + var_7;
    }
  }

  var_22 *= var_21;
  return int(var_18 + var_22);
}