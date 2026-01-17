/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_mannequin.gsc
*************************************************/

#using scripts\shared\ai\archetype_mannequin_interface;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\spawner_shared;
#namespace mannequinbehavior;

function autoexec init() {
  level.zm_variant_type_max = [];
  level.zm_variant_type_max["walk"] = [];
  level.zm_variant_type_max["run"] = [];
  level.zm_variant_type_max["sprint"] = [];
  level.zm_variant_type_max["walk"]["down"] = 14;
  level.zm_variant_type_max["walk"]["up"] = 16;
  level.zm_variant_type_max["run"]["down"] = 13;
  level.zm_variant_type_max["run"]["up"] = 12;
  level.zm_variant_type_max["sprint"]["down"] = 7;
  level.zm_variant_type_max["sprint"]["up"] = 6;
  spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombieblackboardinit);
  spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombiedeathoverrideinit);
  spawner::add_archetype_spawn_function("mannequin", &zombie_utility::zombiespawnsetup);
  spawner::add_archetype_spawn_function("mannequin", &mannequinspawnsetup);
  mannequininterface::registermannequininterfaceattributes();
  behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinCollisionService", &mannequincollisionservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinShouldMelee", &mannequinshouldmelee);
}

function mannequincollisionservice(entity) {
  if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > (300 * 300)) {
    entity pushactors(0);
  } else {
    entity pushactors(1);
  }
}

function mannequinspawnsetup(entity) {}

function private mannequinshouldmelee(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }
  if(isDefined(entity.marked_for_death)) {
    return false;
  }
  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }
  if(distance2dsquared(entity.origin, entity.enemy.origin) > (64 * 64)) {
    return false;
  }
  if((abs(entity.origin[2] - entity.enemy.origin[2])) > 72) {
    return false;
  }
  yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
  if(abs(yawtoenemy) > 45) {
    return false;
  }
  return true;
}