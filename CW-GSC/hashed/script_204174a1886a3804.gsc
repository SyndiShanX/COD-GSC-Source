/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_204174a1886a3804.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace incursion_infiltrationtitlecards;
class class_7c3faeda: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("Incursion_InfiltrationTitleCards");
    cluielem::add_clientfield("_state", 1, 4, "int");
    cluielem::add_clientfield("SelectedInfiltration", 1, 3, "int");
  }

  function set_state(player, state_name) {
    if(#"defaultstate" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
      return;
    }

    if(#"hash_1c7fa28cf1485078" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
      return;
    }

    if(#"hash_41af72ac3698f06f" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
      return;
    }

    if(#"hash_5b1f56f3d27d25f0" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
      return;
    }

    if(#"hash_249ee0339eddec66" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 4);
      return;
    }

    if(#"hash_55a524ad199904e9" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 5);
      return;
    }

    if(#"hash_37b2af92df0bfd42" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 6);
      return;
    }

    if(#"hash_30029804cf01e828" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 7);
      return;
    }

    if(#"hash_386af01523f194e5" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 8);
      return;
    }

    if(#"hash_c5a40437efffe76" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 9);
      return;
    }

    if(#"hash_88bd3835c23cdbc" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 10);
      return;
    }

    if(#"hash_55e75da288d110d4" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 11);
      return;
    }

    if(#"hash_3eb38ea38a92fe35" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 12);
      return;
    }

    if(#"hash_79efd6a9d00cac13" == state_name) {
      player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 13);
      return;
    }

    assertmsg("<dev string:x38>");
  }

  function function_ee0c7ef6(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "SelectedInfiltration", value);
  }
}

function register() {
  elem = new class_7c3faeda();
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

function function_ee0c7ef6(player, value) {
  [[self]] - > function_ee0c7ef6(player, value);
}