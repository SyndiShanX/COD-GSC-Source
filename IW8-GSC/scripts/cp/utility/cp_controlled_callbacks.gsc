/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_controlled_callbacks.gsc
**********************************************************/

function ref_12ec3(var0) {
  var1 = getdvarint("scr_br_aa_turret_flak_explosion_inner_radius", 500);
  var2 = getdvarint("scr_br_aa_turret_flak_explosion_outer_radius", 1000);
  var3 = getdvarint("scr_br_aa_turret_flak_vehicle_damage_bonus_min", 100);
  var4 = getdvarint("scr_br_aa_turret_flak_vehicle_damage_bonus_max", 200);
  var5 = getdvarint("scr_br_aa_turret_flak_aircraft_damage_bonus_additive_min", 100);
  var6 = getdvarint("scr_br_aa_turret_flak_aircraft_damage_bonus_additive_max", 200);
  var7 = getdvarint("scr_br_aa_turret_flak_ai_agent_damage_bonus_additive_min", 25);
  var8 = getdvarint("scr_br_aa_turret_flak_ai_agent_damage_bonus_additive_max", 50);
  var9 = getdvarint("scr_br_aa_turret_flak_projectile_speed", 550);
  var10 = getdvarfloat("scr_br_aa_turret_flak_projectile_lifetime", 2);
  var11 = getdvarfloat("scr_br_aa_turret_flak_projectile_lifetime_std", 1);
  var12 = getdvarfloat("scr_br_aa_turret_flak_projectile_speed_ballistic_scalar", 35);
  var13 = var9 * var10 * var11 * var12;
  var14 = var13 * 0.5;
  var15 = getdvarfloat("scr_br_aa_turret_flak_min_damage_scalar", 0.5);
  var16 = self;
  var17 = var0.attacker;
  var18 = var0.damage;
  var19 = var0.point;
  var20 = distance(var19, var17.origin);
  var21 = 1;

  if(var20 > var14) {
    var21 = var15 + (1 - var15) * (1 - (var20 - var14) / (var13 - var14));
  }

  var22 = 0;
  var23 = distance(var16.origin, var19);

  if(var23 <= var1) {
    if(var16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var22 = var4;

      if(isDefined(var16.vehiclename)) {
        switch (var16.vehiclename) {
          case "veh_bt":
          case "veh_a10fd":
          case "little_bird":
            var22 += var6;
            break;
        }
      }
    } else if(isai(var16)) {
      var22 += var8;
    }
  } else {
    var24 = (var23 - var1) / (var2 - var1);
    var22 = var24 * (var4 - var3) + var3;

    if(var16 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(isDefined(var16.vehiclename)) {
        switch (var16.vehiclename) {
          case "veh_bt":
          case "veh_a10fd":
          case "little_bird":
            var22 += var24 * (var6 - var5) + var5;
            break;
        }
      }
    } else if(isai(var16)) {
      var22 += var24 * (var8 - var7) + var7;
    }
  }

  var22 *= var21;
  return int(var18 + var22);
}