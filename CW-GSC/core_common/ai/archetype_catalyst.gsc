/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_catalyst.gsc
*************************************************/

#using scripts\core_common\ai\archetype_catalyst_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\spawner_shared;
#namespace archetypecatalyst;

function autoexec main() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"catalyst", &function_728127b);
  spawner::add_archetype_spawn_function(#"catalyst", &function_5608540a);
  catalystinterface::registercatalystinterfaceattributes();
}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&iscatalyst));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"iscatalyst", &iscatalyst);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@catalyst", &function_720a0584, undefined, undefined);
}

function iscatalyst(entity) {
  return self.archetype === # "catalyst";
}

function function_5608540a() {
  self.zombie_move_speed = "walk";
  var_9d3ec6f = [];
  var_9d3ec6f[#"catalyst_corrosive"] = 1;
  var_9d3ec6f[#"catalyst_electric"] = 3;
  var_9d3ec6f[#"catalyst_plasma"] = 2;
  var_9d3ec6f[#"catalyst_water"] = 4;

  if(isDefined(self.subarchetype) && isDefined(var_9d3ec6f[self.subarchetype])) {
    function_27c82a36(self, var_9d3ec6f[self.subarchetype]);
  }
}

function private function_728127b() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_dc16721f;
}

function function_27c82a36(entity, catalyst_type) {
  entity function_b7e4069(catalyst_type);

  if(isDefined(level.var_f6d5bd0c)) {
    if(level.var_f6d5bd0c[0].size > 0) {
      foreach(spawn_func in level.var_f6d5bd0c[0]) {
        entity[[spawn_func]]();
      }
    }

    if(level.var_f6d5bd0c[catalyst_type].size > 0) {
      foreach(spawn_func in level.var_f6d5bd0c[catalyst_type]) {
        entity[[spawn_func]]();
      }
    }
  }

  return entity;
}

function function_84c6177b(spawner, catalyst_type, location) {
  spawner.script_forcespawn = 1;
  entity = zombie_utility::spawn_zombie(spawner, undefined, location);

  if(!isDefined(entity)) {
    return;
  }

  if(isDefined(entity.catalyst_type)) {
    return;
  }

  entity = function_27c82a36(entity, catalyst_type);

  if(!isDefined(location.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = location.angles;
  }

  entity forceteleport(location.origin, angles);
  return entity;
}

function private function_b7e4069(catalyst_type) {
  self.catalyst_type = catalyst_type;
}

function private function_dc16721f(entity) {
  entity.__blackboard = undefined;
  entity function_728127b();
}

function function_8f9b9d24(catalyst_type, func) {
  if(!isDefined(level.var_f6d5bd0c)) {
    level.var_f6d5bd0c = [];
    level.var_f6d5bd0c[0] = [];
    level.var_f6d5bd0c[1] = [];
    level.var_f6d5bd0c[3] = [];
    level.var_f6d5bd0c[2] = [];
    level.var_f6d5bd0c[4] = [];
  }

  if(isDefined(level.var_f6d5bd0c[catalyst_type])) {
    level.var_f6d5bd0c[catalyst_type][level.var_f6d5bd0c[catalyst_type].size] = func;
  }
}

function function_720a0584(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration orientmode("face angle", mocompduration.angles[1]);
  mocompduration animmode("normal");

  if(isDefined(mocompduration.traverseendnode)) {
    print3d(mocompduration.traversestartnode.origin, "<dev string:x38>", (1, 0, 0), 1, 1, 60);
    print3d(mocompduration.traverseendnode.origin, "<dev string:x38>", (0, 1, 0), 1, 1, 60);
    line(mocompduration.traversestartnode.origin, mocompduration.traverseendnode.origin, (0, 1, 0), 1, 0, 60);

    mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
  }
}