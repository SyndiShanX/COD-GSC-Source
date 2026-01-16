/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_mannequin.gsc
**************************************************/

#include scripts\core_common\ai\archetype_mannequin_interface;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\spawner_shared;

#namespace mannequinbehavior;

autoexec init() {
  level.zm_variant_type_max = [];
  level.zm_variant_type_max[#"walk"] = [];
  level.zm_variant_type_max[#"run"] = [];
  level.zm_variant_type_max[#"sprint"] = [];
  level.zm_variant_type_max[#"walk"][#"down"] = 14;
  level.zm_variant_type_max[#"walk"][#"up"] = 16;
  level.zm_variant_type_max[#"run"][#"down"] = 13;
  level.zm_variant_type_max[#"run"][#"up"] = 12;
  level.zm_variant_type_max[#"sprint"][#"down"] = 7;
  level.zm_variant_type_max[#"sprint"][#"up"] = 6;
  spawner::add_archetype_spawn_function(#"mannequin", &zombiebehavior::archetypezombieblackboardinit);
  spawner::add_archetype_spawn_function(#"mannequin", &zombiebehavior::archetypezombiedeathoverrideinit);
  spawner::add_archetype_spawn_function(#"mannequin", &zombie_utility::zombiespawnsetup);
  spawner::add_archetype_spawn_function(#"mannequin", &mannequinspawnsetup);
  mannequininterface::registermannequininterfaceattributes();
  assert(isscriptfunctionptr(&mannequincollisionservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinCollisionService", &mannequincollisionservice);
  assert(isscriptfunctionptr(&mannequinshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinShouldMelee", &mannequinshouldmelee);
}

mannequincollisionservice(entity) {
  if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > 300 * 300) {
    entity collidewithactors(0);
    return;
  }

  entity collidewithactors(1);
}

mannequinspawnsetup(entity) {}

private mannequinshouldmelee(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(distance2dsquared(entity.origin, entity.enemy.origin) > 64 * 64) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > 72) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 45) {
    return false;
  }

  return true;
}