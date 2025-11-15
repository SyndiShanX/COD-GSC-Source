/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_bundles.gsc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\weapons_shared;

#namespace killstreak_bundles;

register_killstreak_bundle(type) {
  level.killstreakbundle[type] = struct::get_script_bundle("killstreak", "killstreak_" + type);
  level.killstreakbundle["inventory_" + type] = level.killstreakbundle[type];
  level.killstreakmaxhealthfunction = &get_max_health;
  assert(isDefined(level.killstreakbundle[type]));
}

register_bundle(type, bundle) {
  level.killstreakbundle[type] = bundle;
  level.killstreakmaxhealthfunction = &get_max_health;
  assert(isDefined(level.killstreakbundle[type]));
}

get_bundle(killstreak) {
  if(killstreak.archetype === "raps") {
    return level.killstreakbundle[#"raps_drone"];
  }

  if(killstreak.killstreaktype === "drone_squadron" && sessionmodeiscampaigngame()) {
    return level.killstreakbundle["drone_squadron" + "_cp"];
  }

  return level.killstreakbundle[killstreak.killstreaktype];
}

spawned(bundle) {
  self.var_22a05c26 = bundle;
}

function_48e9536e() {
  return self.var_22a05c26;
}

get_hack_timeout() {
  return get_bundle(self).kshacktimeout;
}

get_hack_protection() {
  return isDefined(get_bundle(self).kshackprotection) ? get_bundle(self).kshackprotection : 0;
}

get_hack_tool_inner_time() {
  return isDefined(get_bundle(self).kshacktoolinnertime) ? get_bundle(self).kshacktoolinnertime : 10000;
}

get_hack_tool_outer_time() {
  return isDefined(get_bundle(self).kshacktooloutertime) ? get_bundle(self).kshacktooloutertime : 10000;
}

get_hack_tool_inner_radius() {
  return isDefined(get_bundle(self).kshacktoolinnerradius) ? get_bundle(self).kshacktoolinnerradius : 10000;
}

get_hack_tool_outer_radius() {
  return isDefined(get_bundle(self).kshacktoolouterradius) ? get_bundle(self).kshacktoolouterradius : 10000;
}

get_lost_line_of_sight_limit_msec() {
  return isDefined(get_bundle(self).kshacktoollostlineofsightlimitms) ? get_bundle(self).kshacktoollostlineofsightlimitms : 1000;
}

get_hack_tool_no_line_of_sight_time() {
  return isDefined(get_bundle(self).kshacktoolnolineofsighttime) ? get_bundle(self).kshacktoolnolineofsighttime : 1000;
}

get_hack_scoreevent() {
  return isDefined(get_bundle(self).kshackscoreevent) ? get_bundle(self).kshackscoreevent : undefined;
}

get_hack_fx() {
  return isDefined(get_bundle(self).kshackfx) ? get_bundle(self).kshackfx : "";
}

get_hack_loop_fx() {
  return isDefined(get_bundle(self).kshackloopfx) ? get_bundle(self).kshackloopfx : "";
}

get_max_health(killstreaktype) {
  return level.killstreakbundle[killstreaktype].kshealth;
}

get_low_health(killstreaktype) {
  return level.killstreakbundle[killstreaktype].kslowhealth;
}

get_hacked_health(killstreaktype) {
  return level.killstreakbundle[killstreaktype].kshackedhealth;
}

get_shots_to_kill(weapon, meansofdeath, bundle) {
  shotstokill = undefined;
  baseweapon = weapons::getbaseweapon(weapon);

  if(baseweapon === level.weaponflechette && weaponhasattachment(weapon, "uber")) {
    if(bundle.kstype === "swat_team" || bundle.kstype === "overwatch_helicopter") {
      if(isactor(self)) {
        shotstokill = bundle.var_3020f1b2;
      } else {
        shotstokill = bundle.var_5682dc25;
      }
    } else {
      shotstokill = bundle.var_3020f1b2;
    }

    return (isDefined(shotstokill) ? shotstokill : 0);
  }

  if(baseweapon === level.weaponspecialcrossbow) {
    if(bundle.kstype === "swat_team" || bundle.kstype === "overwatch_helicopter") {
      if(isactor(self)) {
        shotstokill = bundle.var_1de74ef1;
      } else {
        shotstokill = bundle.var_63c68981;
      }
    } else {
      shotstokill = bundle.var_1de74ef1;
    }

    return (isDefined(shotstokill) ? shotstokill : 0);
  }

  switch (weapon.rootweapon.name) {
    case #"remote_missile_missile":
      shotstokill = bundle.ksremote_missile_missile;
      break;
    case #"hero_annihilator":
      shotstokill = bundle.kshero_annihilator;
      break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"sig_bow_quickshot3":
    case #"sig_bow_quickshot2":
    case #"sig_bow_quickshot5":
    case #"sig_bow_quickshot4":
    case #"sig_bow_quickshot":
    case #"hero_bowlauncher":
      if(meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE_SPLASH") {
        shotstokill = bundle.kshero_bowlauncher;
      } else {
        shotstokill = -1;
      }

      break;
    case #"eq_gravityslam":
      shotstokill = bundle.kshero_gravityspikes;
      break;
    case #"shock_rifle":
      shotstokill = bundle.var_4be7d629;
      break;
    case #"hero_minigun":
      shotstokill = bundle.kshero_minigun;
      break;
    case #"hero_pineapple_grenade":
    case #"hero_pineapplegun":
      shotstokill = bundle.kshero_pineapplegun;
      break;
    case #"hero_firefly_swarm":
      shotstokill = (isDefined(bundle.kshero_firefly_swarm) ? bundle.kshero_firefly_swarm : 0) * 4;
      break;
    case #"dart_blade":
    case #"dart_turret":
      shotstokill = bundle.ksdartstokill;
      break;
    case #"recon_car":
      shotstokill = bundle.var_8eca21ba;
      break;
    case #"ability_dog":
      shotstokill = bundle.var_a758f9e6;
      break;
    case #"planemortar":
      shotstokill = bundle.var_843b7bd3;
      break;
    case #"gadget_heat_wave":
      shotstokill = bundle.kshero_heatwave;
      break;
    case #"hero_flamethrower":
      if(isDefined(bundle.var_2db988a0) && bundle.var_2db988a0) {
        shotstokill = 1;
      } else {
        shotstokill = bundle.var_2e48926e;
      }

      break;
    case #"eq_concertina_wire":
      if(isDefined(bundle.var_ab14c65a) && bundle.var_ab14c65a) {
        shotstokill = 1;
      }

      break;
    case #"ability_smart_cover":
      if(isDefined(bundle.var_4de0b9db) && bundle.var_4de0b9db) {
        shotstokill = 1;
      } else {
        shotstokill = bundle.var_9efbc14a;
      }

      break;
    case #"hash_17df39d53492b0bf":
      shotstokill = bundle.var_605815a6;
      break;
    case #"hash_7b24d0d0d2823bca":
      shotstokill = bundle.var_50c51e5;
      break;
    case #"ac130_chaingun":
      shotstokill = bundle.var_676a4c7;
      break;
    case #"eq_tripwire":
      shotstokill = bundle.var_8f65bc5d;
      break;
    case #"hatchet":
      shotstokill = bundle.var_8ca2602b;
      break;
    case #"eq_emp_grenade":
      shotstokill = bundle.ksempgrenadestokill;
      break;
    case #"sig_blade":
      shotstokill = bundle.var_5789ac76;
      break;
  }

  return isDefined(shotstokill) ? shotstokill : 0;
}

get_emp_grenade_damage(killstreaktype, maxhealth) {
  emp_weapon_damage = undefined;

  if(isDefined(level.killstreakbundle[killstreaktype])) {
    bundle = level.killstreakbundle[killstreaktype];
    empgrenadestokill = isDefined(bundle.ksempgrenadestokill) ? bundle.ksempgrenadestokill : 0;

    if(empgrenadestokill == 0) {} else if(empgrenadestokill > 0) {
      emp_weapon_damage = maxhealth / empgrenadestokill + 1;
    } else {
      emp_weapon_damage = 0;
    }
  }

  return emp_weapon_damage;
}

function_daad16b8(maxhealth, weapon_damage, var_8cef04) {
  var_8cef04 = isDefined(var_8cef04) ? var_8cef04 : 0;

  if(var_8cef04 == 0) {} else if(var_8cef04 > 0) {
    weapon_damage = maxhealth / var_8cef04 + 1;
  } else {
    weapon_damage = 0;
  }

  return weapon_damage;
}

function_14bd8ba5(damage, damage_multiplier) {
  damage_multiplier = isDefined(damage_multiplier) ? damage_multiplier : 0;

  if(damage_multiplier == 0) {
    return undefined;
  } else if(damage_multiplier > 0) {
    return (damage * damage_multiplier);
  }

  return 0;
}

function_6bacfedc(weapon, levelweapon) {
  return isDefined(levelweapon) && weapon.statname == levelweapon.statname && levelweapon.statname != level.weaponnone.statname;
}

function_90509610(weapon, levelweapon) {
  return isDefined(levelweapon) && weapon.name == levelweapon.name && levelweapon.statname != level.weaponnone.statname;
}

get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
  weapon_damage = undefined;

  if(isDefined(level.killstreakbundle[killstreaktype])) {
    bundle = level.killstreakbundle[killstreaktype];
    weapon_damage = function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel);
  }

  return weapon_damage;
}

function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
  weapon_damage = undefined;

  if(isDefined(bundle)) {
    if(isDefined(weapon)) {
      shotstokill = get_shots_to_kill(weapon, type, bundle);

      if(shotstokill == 0) {} else if(shotstokill > 0) {
        if(isDefined(chargeshotlevel) && chargeshotlevel > 0) {
          shotstokill /= chargeshotlevel;
        }

        weapon_damage = maxhealth / shotstokill + 1;
      } else {
        weapon_damage = 0;
      }
    }

    if(!isDefined(weapon_damage)) {
      if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_HEAD_SHOT") {
        hasarmorpiercing = isDefined(attacker) && isplayer(attacker) && attacker hasperk(#"specialty_armorpiercing");
        clipstokill = isDefined(bundle.ksclipstokill) ? bundle.ksclipstokill : 0;

        if(clipstokill == -1) {
          weapon_damage = 0;
        } else if(hasarmorpiercing && self.aitype !== "spawner_bo3_robot_grunt_assault_mp_escort") {
          weapon_damage = damage + int(damage * level.cac_armorpiercing_data);
        }

        if(weapon.weapclass == "spread") {
          ksshotgunmultiplier = isDefined(bundle.ksshotgunmultiplier) ? bundle.ksshotgunmultiplier : 1;

          if(ksshotgunmultiplier == 0) {} else if(ksshotgunmultiplier > 0) {
            weapon_damage = (isDefined(weapon_damage) ? weapon_damage : damage) * ksshotgunmultiplier;
          }
        }
      } else if(type == "MOD_IMPACT" && isDefined(level.shockrifleweapon) && function_6bacfedc(weapon, level.shockrifleweapon)) {
        var_108f064f = isDefined(bundle.var_4be7d629) ? bundle.var_4be7d629 : 0;

        if(var_108f064f == 0) {} else if(var_108f064f > 0) {
          weapon_damage = maxhealth / var_108f064f + 1;
        } else {
          weapon_damage = 0;
        }
      } else if((type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE_SPLASH" && bundle.var_38de4989 === 1) && (!isDefined(weapon.isempkillstreak) || !weapon.isempkillstreak) && (!isDefined(level.weaponpistolenergy) || weapon.statname != level.weaponpistolenergy.statname || level.weaponpistolenergy.statname == level.weaponnone.statname) && (!isDefined(level.weaponspecialcrossbow) || weapon.statname != level.weaponspecialcrossbow.statname || level.weaponspecialcrossbow.statname == level.weaponnone.statname) && weapon.rootweapon.name != #"trophy_system") {
        if(function_6bacfedc(weapon, level.weaponshotgunenergy)) {
          weapon_damage = function_daad16b8(maxhealth, weapon_damage, bundle.ksshotgunenergytokill);
        } else {
          rocketstokill = isDefined(bundle.ksrocketstokill) ? bundle.ksrocketstokill : 0;

          if(level.competitivesettingsenabled && isDefined(bundle.var_b744074b) && bundle.var_b744074b != 0) {
            rocketstokill = bundle.var_b744074b;
          }

          if(rocketstokill == 0) {} else if(rocketstokill > 0) {
            if(weapon.rootweapon.name == "launcher_multi") {
              rocketstokill *= 2;
            }

            weapon_damage = maxhealth / rocketstokill + 1;
          } else {
            weapon_damage = 0;
          }
        }
      } else if((type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") && (!isDefined(weapon.isempkillstreak) || !weapon.isempkillstreak)) {
        weapon_damage = function_14bd8ba5(damage, bundle.ksgrenadedamagemultiplier);
      } else if(type == "MOD_MELEE_WEAPON_BUTT" || type == "MOD_MELEE") {
        weapon_damage = function_14bd8ba5(damage, bundle.ksmeleedamagemultiplier);
      } else if(type == "MOD_PROJECTILE_SPLASH") {
        weapon_damage = function_14bd8ba5(damage, bundle.ksprojectilespashmultiplier);
      }
    }
  }

  return weapon_damage;
}