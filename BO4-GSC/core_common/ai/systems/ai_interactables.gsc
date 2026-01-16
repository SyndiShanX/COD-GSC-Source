/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\ai_interactables.gsc
*******************************************************/

#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace aiinteractables;

autoexec __init__system__() {
  system::register(#"ai_interactables", &__init__, undefined, undefined);
}

__init__() {
  assert(isscriptfunctionptr(&function_64d25a18));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57181cf80bd4059f", &function_64d25a18);
  assert(isscriptfunctionptr(&function_64d25a18));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_57181cf80bd4059f", &function_64d25a18);
  assert(isscriptfunctionptr(&function_b4bc7751));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ef372b4649a577e", &function_b4bc7751);
  thread function_2f0f1b62();
}

private function_2f0f1b62() {
  nodes = getallnodes();

  foreach(node in nodes) {
    if(isDefined(node.interact_node) && node.interact_node && isDefined(node.target)) {
      if(isDefined(node.var_71c87324) && node.var_71c87324) {
        continue;
      }

      var_54d06303 = struct::get(node.target);

      if(isDefined(var_54d06303)) {
        var_54d06303 scene::init();
      }
    }
  }
}

function_64d25a18(entity) {
  if(entity.archetype !== #"human") {
    return false;
  }

  if(!isDefined(entity.node)) {
    return false;
  }

  if(!iscovernode(entity.node)) {
    return false;
  }

  if(!entity isatcovernode()) {
    return false;
  }

  if(!(isDefined(entity.node.interact_node) && entity.node.interact_node)) {
    return false;
  }

  if(isDefined(entity.node.var_31c05612)) {
    return false;
  }

  return true;
}

private function_b4bc7751(entity) {
  assert(!(isDefined(entity.node.var_31c05612) && entity.node.var_31c05612));

  if(isDefined(entity.node.target)) {
    entity pathmode("move delayed", 8);
    entity.node.var_31c05612 = 1;
    var_54d06303 = struct::get(entity.node.target);
    var_54d06303 scene::play(entity);
    var_54d06303 notify(#"hash_4d2293524fe1c94c", {
      #ai_interactable: entity
    });

    if(isalive(entity)) {
      entity notify(#"hash_4d2293524fe1c94c", {
        #var_bad0e17c: var_54d06303, 
        #var_c17a3b30: entity.node
      });
    }
  }
}