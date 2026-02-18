/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_34e9dd62fc371077.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace onslaught_hud;
class class_b6739d61: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_1c28d7c2(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showBossAlert", value);
  }

  function function_2a0b1f84(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score3Points", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function function_71fd1345(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showLottoLoadouts", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("onslaught_hud");
    cluielem::function_dcb34c80("string", "bossAlertText", 1);
    cluielem::function_dcb34c80("string", "objective2Text", 1);
    cluielem::add_clientfield("score3Points", 1, 8, "int");
    cluielem::function_dcb34c80("string", "objectiveText", 1);
    cluielem::add_clientfield("showEndScore", 1, 1, "int");
    cluielem::add_clientfield("showScore", 1, 1, "int");
    cluielem::add_clientfield("showObjective", 1, 1, "int");
    cluielem::add_clientfield("showBossAlert", 1, 1, "int");
    cluielem::add_clientfield("showObjective2", 1, 1, "int");
    cluielem::add_clientfield("showLottoLoadouts", 1, 2, "int");
  }

  function function_9b5f8a75(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showEndScore", value);
  }

  function function_9c1c0811(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objective2Text", value);
  }

  function function_b73d2d7c(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bossAlertText", value);
  }

  function function_d0a02472(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showObjective", value);
  }

  function function_d6b5fdc4(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showObjective2", value);
  }

  function function_da96c24e(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showScore", value);
  }

  function set_objectivetext(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objectiveText", value);
  }
}

function register() {
  elem = new class_b6739d61();
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

function function_b73d2d7c(player, value) {
  [[self]] - > function_b73d2d7c(player, value);
}

function function_9c1c0811(player, value) {
  [[self]] - > function_9c1c0811(player, value);
}

function function_2a0b1f84(player, value) {
  [[self]] - > function_2a0b1f84(player, value);
}

function set_objectivetext(player, value) {
  [[self]] - > set_objectivetext(player, value);
}

function function_9b5f8a75(player, value) {
  [[self]] - > function_9b5f8a75(player, value);
}

function function_da96c24e(player, value) {
  [[self]] - > function_da96c24e(player, value);
}

function function_d0a02472(player, value) {
  [[self]] - > function_d0a02472(player, value);
}

function function_1c28d7c2(player, value) {
  [[self]] - > function_1c28d7c2(player, value);
}

function function_d6b5fdc4(player, value) {
  [[self]] - > function_d6b5fdc4(player, value);
}

function function_71fd1345(player, value) {
  [[self]] - > function_71fd1345(player, value);
}