/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_elephant.gsc
***********************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_elephant;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm_aoe;

#namespace zm_ai_elephant;

autoexec main() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"elephant", &function_4c731a08);
}

private registerbehaviorscriptfunctions() {
  animation::add_global_notetrack_handler("arrow_throw", &function_aef0aaa4, 0);
  animation::add_global_notetrack_handler("spear_unhide", &function_882f233, 0);
  animation::add_global_notetrack_handler("spear_hide", &function_e41280fd, 0);
  animation::add_global_notetrack_handler("start_gib", &function_dae74ff5, 0);
}

private function_4c731a08() {
  if(!(isDefined(level.var_c8d8fe54) && level.var_c8d8fe54)) {
    level thread aat::register_immunity("zm_aat_brain_decay", #"elephant", 1, 0, 0);
    level thread aat::register_immunity("zm_aat_frostbite", #"elephant", 1, 0, 0);
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"elephant", 1, 0, 0);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", #"elephant", 1, 0, 0);
    level.var_c8d8fe54 = 1;
  }

  self.ai.var_502d9d0d = &function_502d9d0d;
  self.var_126d7bef = 1;
  self.b_ignore_cleanup = 1;
  aiutility::addaioverridedamagecallback(self, &function_6b086058);
  self.ai.var_64eb729e = &function_9b64dc73;
  level.var_b394f92f = &function_767db9a1;
  function_deb99302();
}

private function_deb99302() {
  if(isDefined(level.var_a92449fa)) {
    return;
  }

  level.var_a92449fa = struct::get_array("spear_throw_pos", "targetname");
  level.var_5feff7d0 = &function_848ff0cc;
  level.var_6efc944c = &function_ad0f2b39;
}

private function_767db9a1(attacker, weapon, boneindex, hitloc, point) {
  var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point);
  damage_scale = var_786d7e06.damage_scale;
  return damage_scale;
}

function_ad0f2b39(aoe) {
  if(isDefined(aoe.userdata)) {
    aoe.userdata.inuse = 0;
  }
}

private function_848ff0cc(elephant, rider) {
  if(isDefined(level.var_a92449fa)) {
    validstructs = [];

    foreach(struct in level.var_a92449fa) {
      if(!isDefined(struct.inuse) || !struct.inuse) {
        distsq = distancesquared(elephant.origin, struct.origin);

        if(distsq > 200 * 200) {
          if(util::within_fov(rider.origin + (0, 0, -40), rider.angles, struct.origin, cos(70))) {
            array::add(validstructs, struct);
          }
        }
      }
    }

    if(validstructs.size) {
      struct = array::random(validstructs);
      struct.inuse = 1;
      return struct;
    }
  }

  return undefined;
}

private function_9b64dc73(enemies, entity) {
  foreach(enemy in enemies) {
    enemy zombie_utility::setup_zombie_knockdown(entity);
    enemy.knockdown_type = "knockdown_stun";
  }
}

private function_502d9d0d(entity, projectile) {
  projectile thread function_d13a21cb(entity, projectile);
}

private function_dae74ff5() {}

private function_e41280fd() {
  if(isDefined(self.var_c8ec4813) && self.var_c8ec4813) {
    self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
    self.var_c8ec4813 = 0;
  }
}

private function_882f233() {
  if(isDefined(self.var_c8ec4813) && !self.var_c8ec4813) {
    self attach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
    self.var_c8ec4813 = 1;
  }
}

private function_aef0aaa4() {
  assert(isDefined(self.ai.spearweapon));
  forwarddir = anglesToForward(self.angles);
  var_a137cb9f = self gettagorigin("tag_weapon_right");

  if(isDefined(self.ai.var_c3f91959)) {
    var_eb549b4f = self.ai.var_c3f91959.origin;
    projectile = magicbullet(self.ai.spearweapon, var_a137cb9f, var_eb549b4f, self.ai.elephant);
  } else if(isDefined(self.ai.elephant.favoriteenemy)) {
    var_eb549b4f = self.ai.elephant.favoriteenemy.origin;
    projectile = magicbullet(self.ai.spearweapon, var_a137cb9f, var_eb549b4f, self.ai.elephant, self.ai.elephant.favoriteenemy);
  } else {
    return;
  }

  var_e15d8b1f = 2;

  if(self.ai.elephant.ai.var_112ec817 == #"hash_8e170ae91588f20") {
    var_e15d8b1f = 3;
  }

  projectile thread function_7d162bd0(projectile, var_e15d8b1f, self.ai.var_c3f91959);
  projectile thread function_61d12301(projectile);
  projectile thread watch_for_death(projectile);

  if(self.var_c8ec4813) {
    self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
    self.var_c8ec4813 = 0;
  }
}

function_7b10e526(index, multival, target) {
  normal = vectornormalize(target.origin - self.origin);
  pitch = randomfloatrange(15, 30);
  var_a978e158 = randomfloatrange(-10, 10);
  yaw = -180 + 360 / multival * index + var_a978e158;
  angles = (pitch * -1, yaw, 0);
  dir = anglesToForward(angles);
  c = vectorcross(normal, dir);
  f = vectorcross(c, normal);
  theta = 90 - pitch;
  dir = normal * cos(theta) + f * sin(theta);
  dir = vectornormalize(dir);
  return dir;
}

private function_d13a21cb(entity, projectile) {
  projectile endon(#"death");
  landpos = entity.var_f6ea2286;

  if(!isDefined(landpos)) {
    landpos = entity.favoriteenemy.origin;
  }

  projectile clientfield::set("towers_boss_head_proj_explosion_fx_cf", 1);
  enemyorigin = landpos;
  physicsexplosionsphere(projectile.origin, 1000, 300, 400);

  recordsphere(enemyorigin, 15, (0, 0, 0), "<dev string:x38>");

    for(i = 0; i < 5; i++) {
      randomdistance = randomintrange(120, 360);
      var_a978e158 = randomfloatrange(-10, 10);
      yaw = -180 + 72 * i + var_a978e158;
      angles = (0, yaw, 0);
      dir = anglesToForward(angles) * randomdistance;
      var_c6b637a5 = landpos + dir;

      recordsphere(var_c6b637a5, 15, (1, 0.5, 0), "<dev string:x38>");

        launchvelocity = vectornormalize(var_c6b637a5 - projectile.origin) * 1400;
      grenade = entity magicmissile(entity.ai.var_a05929e4, projectile.origin, launchvelocity);
      grenade thread function_7d162bd0(grenade);
    }

  projectile clientfield::set("towers_boss_head_proj_fx_cf", 0);
  wait 0.1;
  projectile delete();
}

private function_7d162bd0(projectile, var_e15d8b1f, var_c3f91959) {
  projectile endon(#"spear_death");
  result = projectile waittill(#"projectile_impact_explode");

  if(!(isDefined(projectile.isdamaged) && projectile.isdamaged)) {
    if(isDefined(result.position)) {
      id = 1;
      var_f34f8a95 = "zm_aoe_spear";

      if(isDefined(var_e15d8b1f)) {
        id = var_e15d8b1f;

        switch (var_e15d8b1f) {
          case 2:
            var_f34f8a95 = "zm_aoe_spear_small";
            break;
          case 3:
            var_f34f8a95 = "zm_aoe_spear_big";
            break;
        }
      }

      if(isDefined(function_9cc082d2(result.position, 30))) {
        if(isDefined(var_c3f91959)) {
          aoe = zm_aoe::function_371b4147(id, var_f34f8a95, groundtrace(result.position + (0, 0, 8), result.position + (0, 0, -100000), 0, projectile)[#"position"], var_c3f91959);
        } else {
          aoe = zm_aoe::function_371b4147(id, var_f34f8a95, groundtrace(result.position + (0, 0, 8), result.position + (0, 0, -100000), 0, projectile)[#"position"]);
        }
      }

      zombiesarray = getaiarchetypearray(#"zombie");
      zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"catalyst"), 0, 0);
      zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"tiger"), 0, 0);
      zombiesarray = array::filter(zombiesarray, 0, &function_5ae551a6, projectile);
      function_9b64dc73(zombiesarray, projectile);
      physicsexplosionsphere(result.position, 200, 100, 2);
    }
  }
}

private function_5ae551a6(enemy, projectile) {
  if(isDefined(enemy.knockdown) && enemy.knockdown) {
    return false;
  }

  if(!isDefined(projectile)) {
    return false;
  }

  if(gibserverutils::isgibbed(enemy, 384)) {
    return false;
  }

  if(distancesquared(enemy.origin, projectile.origin) > 250 * 250) {
    return false;
  }

  return true;
}

private function_61d12301(projectile) {
  projectile endon(#"death");
  result = projectile waittill(#"damage");
  projectile.isdamaged = 1;
}

private watch_for_death(projectile) {
  projectile waittill(#"death");
  waittillframeend();
  projectile notify(#"spear_death");
}

function_6b086058(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(attacker) && attacker.team === self.team) {
    return 0;
  }

  if(isDefined(attacker) && !isplayer(attacker)) {
    return 0;
  }

  self.var_265cb589 = 1;
  var_88cb1bf9 = archetypeelephant::function_498f147(self, point, boneindex);

  if(!isDefined(var_88cb1bf9)) {
    if(isDefined(dir)) {
      playFX("maps/zm_towers/fx8_boss_dmg_flesh", point, dir * -1);
    }

    attacker playhitmarker(undefined, 1, undefined, 0);
    var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex);
    return (damage * var_786d7e06.damage_scale);
  }

  if(self.ai.var_112ec817 == #"hash_8e173ae91589439") {
    var_dd54fdb1 = namespace_81245006::function_37e3f011(self, "tag_carriage_ws_le");

    if(isDefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 1) {
      var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, var_88cb1bf9, undefined, undefined, var_dd54fdb1);
      damage *= var_786d7e06.damage_scale;
      archetypeelephant::function_e864f0da(self, damage, attacker, point, dir, var_88cb1bf9);
      return 0;
    }

    attacker playhitmarker(undefined, 1, undefined, 0);
    var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex);
    return (damage * var_786d7e06.damage_scale);
  } else if(self.ai.var_112ec817 == #"hash_8e170ae91588f20") {
    var_dd54fdb1 = namespace_81245006::function_37e3f011(self, "tag_head_ws");

    if(isDefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 1) {
      if(attacker hasperk(#"specialty_mod_awareness")) {
        damage *= 1.1;
        damage = int(damage);
      }

      attacker playhitmarker(undefined, 5, undefined, 1, 0);
      var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, var_88cb1bf9, undefined, undefined, var_dd54fdb1);
      damage *= var_786d7e06.damage_scale;
      namespace_81245006::damageweakpoint(var_dd54fdb1, damage);
      playFX("maps/zm_towers/fx8_boss_dmg_weakspot_organ", point, dir * -1);

      iprintlnbold("<dev string:x41>" + var_dd54fdb1.health);

        if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3) {

          iprintlnbold("<dev string:x57>");

        }

      return 0;
    }

    attacker playhitmarker(undefined, 1, undefined, 0);
    var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex);
    return (damage * var_786d7e06.damage_scale);
  }

  attacker playhitmarker(undefined, 1, undefined, 0);
  var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex);
  return damage * var_786d7e06.damage_scale;
}