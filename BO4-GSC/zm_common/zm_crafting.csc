/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_crafting.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_progress;
#include scripts\zm_common\zm_utility;

#namespace zm_crafting;

autoexec __init__system__() {
  system::register(#"zm_crafting", &__init__, &__main__, undefined);
}

__init__() {
  level.var_5df2581a = [];
  level.crafting_components = [];
}

__main__() {
  function_60a6c623();
}

function_60a6c623() {
  foundries = getscriptbundles("craftfoundry");

  foreach(foundry in foundries) {
    setup_craftfoundry(foundry);
  }
}

setup_craftfoundry(craftfoundry) {
  if(isDefined(craftfoundry)) {
    if(!(isDefined(craftfoundry.loaded) && craftfoundry.loaded)) {
      craftfoundry.loaded = 1;
      craftfoundry.blueprints = [];

      switch (craftfoundry.blueprintcount) {
        case 8:
          craftfoundry.blueprints[7] = function_b18074d0(craftfoundry.blueprint08);
        case 7:
          craftfoundry.blueprints[6] = function_b18074d0(craftfoundry.blueprint07);
        case 6:
          craftfoundry.blueprints[5] = function_b18074d0(craftfoundry.blueprint06);
        case 5:
          craftfoundry.blueprints[4] = function_b18074d0(craftfoundry.blueprint05);
        case 4:
          craftfoundry.blueprints[3] = function_b18074d0(craftfoundry.blueprint04);
        case 3:
          craftfoundry.blueprints[2] = function_b18074d0(craftfoundry.blueprint03);
        case 2:
          craftfoundry.blueprints[1] = function_b18074d0(craftfoundry.blueprint02);
        case 1:
          craftfoundry.blueprints[0] = function_b18074d0(craftfoundry.blueprint01);
          break;
      }
    }
  }
}

function_b18074d0(name) {
  blueprint = getscriptbundle(name);

  if(isDefined(blueprint)) {
    if(!(isDefined(blueprint.loaded) && blueprint.loaded)) {
      blueprint.loaded = 1;
      blueprint.name = name;
      blueprint.components = [];

      switch (blueprint.componentcount) {
        case 8:
          blueprint.components[7] = get_component(blueprint.var_f4d434cb);
        case 7:
          blueprint.components[6] = get_component(blueprint.component07);
        case 6:
          blueprint.components[5] = get_component(blueprint.registerperk_packa_seepainterminate);
        case 5:
          blueprint.components[4] = get_component(blueprint.component05);
        case 4:
          blueprint.components[3] = get_component(blueprint.component04);
        case 3:
          blueprint.components[2] = get_component(blueprint.component03);
        case 2:
          blueprint.components[1] = get_component(blueprint.component02);
        case 1:
          blueprint.components[0] = get_component(blueprint.component01);
          break;
      }

      blueprint.var_54a97edd = get_component(blueprint.result);
      level.var_5df2581a[name] = blueprint;

      if(!isDefined(blueprint.var_4dbc4aee)) {
        blueprint.var_4dbc4aee = "ERROR: Missing Prompt String";
      }
    }
  } else {
    assertmsg("<dev string:x38>" + name);
  }

  return blueprint;
}

get_component(component) {
  if(!isDefined(level.crafting_components[component.name])) {
    level.crafting_components[component.name] = component;
  }

  return level.crafting_components[component.name];
}