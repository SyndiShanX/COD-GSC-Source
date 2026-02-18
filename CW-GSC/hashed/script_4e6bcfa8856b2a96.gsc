/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4e6bcfa8856b2a96.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace dirtybomb_usebar;
class class_fbe341f: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_4aa46834(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "activatorCount", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("DirtyBomb_UseBar");
    cluielem::add_clientfield("_state", 1, 3, "int");
    cluielem::add_clientfield("progressFrac", 1, 10, "float");
    cluielem::add_clientfield("activatorCount", 1, 3, "int", 0);
  }

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
      return;
    }

    if(#"detonating" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
      return;
    }

    if(#"stopcountdown" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
      return;
    }

    if(#"hash_59e0e869fbae7705" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
      return;
    }

    if(#"hash_b86ebfb5a93f57f" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 4);
      return;
    }

    if(#"hash_4ff55a42344e567e" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 5);
      return;
    }

    if(#"detonatingspymode" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 6);
      return;
    }

    assertmsg("<dev string:x38>");
  }

  function function_f0df5702(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progressFrac", value);
  }
}

function register() {
  elem = new class_fbe341f();
  [[elem]] - > setup_clientfields();
  return elem;
}

function open(player, flags = 0) {
  [[self]] - > open(player, flags);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(player) {
  return [[self]] - > function_7bfd10e6(player);
}

function set_state(player, state_name) {
  [[self]] - > set_state(player, state_name);
}

function function_f0df5702(player, value) {
  [[self]] - > function_f0df5702(player, value);
}

function function_4aa46834(player, value) {
  [[self]] - > function_4aa46834(player, value);
}