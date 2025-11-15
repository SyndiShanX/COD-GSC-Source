/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreak_bundles.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace killstreak_bundles;

function register_killstreak_bundle(killstreaktype) {
  level.killstreakbundle[killstreaktype] = struct::get_script_bundle("killstreak", "killstreak_" + killstreaktype);
  level.killstreakbundle["inventory_" + killstreaktype] = level.killstreakbundle[killstreaktype];
  level.killstreakmaxhealthfunction = & get_max_health;
  assert(isDefined(level.killstreakbundle[killstreaktype]));
}

function get_bundle(killstreak) {
  if(killstreak.archetype === "raps") {
    return level.killstreakbundle["raps_drone"];
  }
  return level.killstreakbundle[killstreak.killstreaktype];
}

function get_hack_timeout() {
  killstreak = self;
  bundle = get_bundle(killstreak);
  return bundle.kshacktimeout;
}

function get_hack_protection() {
  killstreak = self;
  hackedprotection = 0;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshackprotection)) {
    hackedprotection = bundle.kshackprotection;
  }
  return hackedprotection;
}

function get_hack_tool_inner_time() {
  killstreak = self;
  hacktoolinnertime = 10000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktoolinnertime)) {
    hacktoolinnertime = bundle.kshacktoolinnertime;
  }
  return hacktoolinnertime;
}

function get_hack_tool_outer_time() {
  killstreak = self;
  hacktooloutertime = 10000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktooloutertime)) {
    hacktooloutertime = bundle.kshacktooloutertime;
  }
  return hacktooloutertime;
}

function get_hack_tool_inner_radius() {
  killstreak = self;
  hackedtoolinnerradius = 10000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktoolinnerradius)) {
    hackedtoolinnerradius = bundle.kshacktoolinnerradius;
  }
  return hackedtoolinnerradius;
}

function get_hack_tool_outer_radius() {
  killstreak = self;
  hackedtoolouterradius = 10000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktoolouterradius)) {
    hackedtoolouterradius = bundle.kshacktoolouterradius;
  }
  return hackedtoolouterradius;
}

function get_lost_line_of_sight_limit_msec() {
  killstreak = self;
  hackedtoollostlineofsightlimitms = 1000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktoollostlineofsightlimitms)) {
    hackedtoollostlineofsightlimitms = bundle.kshacktoollostlineofsightlimitms;
  }
  return hackedtoollostlineofsightlimitms;
}

function get_hack_tool_no_line_of_sight_time() {
  killstreak = self;
  hacktoolnolineofsighttime = 1000;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshacktoolnolineofsighttime)) {
    hacktoolnolineofsighttime = bundle.kshacktoolnolineofsighttime;
  }
  return hacktoolnolineofsighttime;
}

function get_hack_scoreevent() {
  killstreak = self;
  hackedscoreevent = undefined;
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshackscoreevent)) {
    hackedscoreevent = bundle.kshackscoreevent;
  }
  return hackedscoreevent;
}

function get_hack_fx() {
  killstreak = self;
  hackfx = "";
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshackfx)) {
    hackfx = bundle.kshackfx;
  }
  return hackfx;
}

function get_hack_loop_fx() {
  killstreak = self;
  hackloopfx = "";
  bundle = get_bundle(killstreak);
  if(isDefined(bundle.kshackloopfx)) {
    hackloopfx = bundle.kshackloopfx;
  }
  return hackloopfx;
}

function get_max_health(killstreaktype) {
  bundle = level.killstreakbundle[killstreaktype];
  return bundle.kshealth;
}

function get_low_health(killstreaktype) {
  bundle = level.killstreakbundle[killstreaktype];
  return bundle.kslowhealth;
}

function get_hacked_health(killstreaktype) {
  bundle = level.killstreakbundle[killstreaktype];
  return bundle.kshackedhealth;
}

function get_shots_to_kill(weapon, meansofdeath, bundle) {
  shotstokill = undefined;
  switch (weapon.rootweapon.name) {
    case "remote_missile_missile": {
      shotstokill = bundle.ksremote_missile_missile;
      break;
    }
    case "hero_annihilator": {
      shotstokill = bundle.kshero_annihilator;
      break;
    }
    case "hero_armblade": {
      shotstokill = bundle.kshero_armblade;
      break;
    }
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4": {
      if(meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
        shotstokill = bundle.kshero_bowlauncher;
      } else {
        shotstokill = -1;
      }
      break;
    }
    case "hero_gravityspikes": {
      shotstokill = bundle.kshero_gravityspikes;
      break;
    }
    case "hero_lightninggun": {
      shotstokill = bundle.kshero_lightninggun;
      break;
    }
    case "hero_minigun":
    case "hero_minigun_body3": {
      shotstokill = bundle.kshero_minigun;
      break;
    }
    case "hero_pineapplegun": {
      shotstokill = bundle.kshero_pineapplegun;
      break;
    }
    case "hero_firefly_swarm": {
      shotstokill = (isDefined(bundle.kshero_firefly_swarm) ? bundle.kshero_firefly_swarm : 0) * 4;
      break;
    }
    case "dart_blade":
    case "dart_turret": {
      shotstokill = bundle.ksdartstokill;
      break;
    }
    case "gadget_heat_wave": {
      shotstokill = bundle.kshero_heatwave;
      break;
    }
  }
  return true;
}

function get_emp_grenade_damage(killstreaktype, maxhealth) {
  emp_weapon_damage = undefined;
  if(isDefined(level.killstreakbundle[killstreaktype])) {
    bundle = level.killstreakbundle[killstreaktype];
    empgrenadestokill = (isDefined(bundle.ksempgrenadestokill) ? bundle.ksempgrenadestokill : 0);
    if(empgrenadestokill == 0) {} else {
      if(empgrenadestokill > 0) {
        emp_weapon_damage = (maxhealth / empgrenadestokill) + 1;
      } else {
        emp_weapon_damage = 0;
      }
    }
  }
  return emp_weapon_damage;
}

function get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
  weapon_damage = undefined;
  if(isDefined(level.killstreakbundle[killstreaktype])) {
    bundle = level.killstreakbundle[killstreaktype];
    if(isDefined(weapon)) {
      shotstokill = get_shots_to_kill(weapon, type, bundle);
      if(shotstokill == 0) {} else {
        if(shotstokill > 0) {
          if(isDefined(chargeshotlevel) && chargeshotlevel > 0) {
            shotstokill = shotstokill / chargeshotlevel;
          }
          weapon_damage = (maxhealth / shotstokill) + 1;
        } else {
          weapon_damage = 0;
        }
      }
    }
    if(!isDefined(weapon_damage)) {
      if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_HEAD_SHOT") {
        hasarmorpiercing = isDefined(attacker) && isplayer(attacker) && attacker hasperk("specialty_armorpiercing");
        clipstokill = (isDefined(bundle.ksclipstokill) ? bundle.ksclipstokill : 0);
        if(clipstokill == -1) {
          weapon_damage = 0;
        } else if(hasarmorpiercing && self.aitype !== "spawner_bo3_robot_grunt_assault_mp_escort") {
          weapon_damage = damage + (int(damage * level.cac_armorpiercing_data));
        }
        if(weapon.weapclass == "spread") {
          ksshotgunmultiplier = (isDefined(bundle.ksshotgunmultiplier) ? bundle.ksshotgunmultiplier : 1);
          if(ksshotgunmultiplier == 0) {} else if(ksshotgunmultiplier > 0) {
            weapon_damage = (isDefined(weapon_damage) ? weapon_damage : damage) * ksshotgunmultiplier;
          }
        }
      } else {
        if(type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE" && (!isDefined(weapon.isempkillstreak) || !weapon.isempkillstreak) && weapon.statindex != level.weaponpistolenergy.statindex && weapon.statindex != level.weaponspecialcrossbow.statindex && weapon.statindex != level.weaponsmgnailgun.statindex && weapon.statindex != level.weaponbouncingbetty.statindex) {
          if(weapon.statindex == level.weaponshotgunenergy.statindex) {
            shotgunenergytokill = (isDefined(bundle.ksshotgunenergytokill) ? bundle.ksshotgunenergytokill : 0);
            if(shotgunenergytokill == 0) {} else {
              if(shotgunenergytokill > 0) {
                weapon_damage = (maxhealth / shotgunenergytokill) + 1;
              } else {
                weapon_damage = 0;
              }
            }
          } else {
            rocketstokill = (isDefined(bundle.ksrocketstokill) ? bundle.ksrocketstokill : 0);
            if(rocketstokill == 0) {} else {
              if(rocketstokill > 0) {
                if(weapon.rootweapon.name == "launcher_multi") {
                  rocketstokill = rocketstokill * 2;
                }
                weapon_damage = (maxhealth / rocketstokill) + 1;
              } else {
                weapon_damage = 0;
              }
            }
          }
        } else {
          if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && (!isDefined(weapon.isempkillstreak) || !weapon.isempkillstreak)) {
            grenadedamagemultiplier = (isDefined(bundle.ksgrenadedamagemultiplier) ? bundle.ksgrenadedamagemultiplier : 0);
            if(grenadedamagemultiplier == 0) {} else {
              if(grenadedamagemultiplier > 0) {
                weapon_damage = damage * grenadedamagemultiplier;
              } else {
                weapon_damage = 0;
              }
            }
          } else {
            if(type == "MOD_MELEE_WEAPON_BUTT" || type == "MOD_MELEE") {
              ksmeleedamagemultiplier = (isDefined(bundle.ksmeleedamagemultiplier) ? bundle.ksmeleedamagemultiplier : 0);
              if(ksmeleedamagemultiplier == 0) {} else {
                if(ksmeleedamagemultiplier > 0) {
                  weapon_damage = damage * ksmeleedamagemultiplier;
                } else {
                  weapon_damage = 0;
                }
              }
            } else if(type == "MOD_PROJECTILE_SPLASH") {
              ksprojectilespashmultiplier = (isDefined(bundle.ksprojectilespashmultiplier) ? bundle.ksprojectilespashmultiplier : 0);
              if(ksprojectilespashmultiplier == 0) {} else {
                if(ksprojectilespashmultiplier > 0) {
                  weapon_damage = damage * ksprojectilespashmultiplier;
                } else {
                  weapon_damage = 0;
                }
              }
            }
          }
        }
      }
    }
  }
  return weapon_damage;
}