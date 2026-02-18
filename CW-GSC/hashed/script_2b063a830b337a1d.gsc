/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2b063a830b337a1d.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace evidence_board_mission_preview;
class class_fb1bfa12: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_10415bce(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "lvlDescriptionShort", value);
  }

  function function_275127c2(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "lvlDescriptionLong", value);
  }

  function function_3d5ae5d4(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "lvlProgress", value);
  }

  function function_57d3362b(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "activeState", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("evidence_board_mission_preview");
    cluielem::add_clientfield("entNum", 1, 10, "int");
    cluielem::add_clientfield("activeState", 1, 2, "int");
    cluielem::add_clientfield("lvlYear", 1, 11, "int");
    cluielem::function_dcb34c80("string", "lvlName", 1);
    cluielem::function_dcb34c80("string", "lvlDescriptionShort", 1);
    cluielem::function_dcb34c80("string", "lvlDescriptionLong", 1);
    cluielem::add_clientfield("lvlProgress", 1, 4, "float");
  }

  function function_c063a71c(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "lvlName", value);
  }

  function function_c2c6a8c3(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "lvlYear", value);
  }

  function set_entnum(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entNum", value);
  }
}

function function_326329cb(player, var_ba420c60) {
  function_c063a71c(player, var_ba420c60.levelname);
}

function register() {
  elem = new class_fb1bfa12();
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

function set_entnum(player, value) {
  [[self]] - > set_entnum(player, value);
}

function function_57d3362b(player, value) {
  [[self]] - > function_57d3362b(player, value);
}

function function_c2c6a8c3(player, value) {
  [[self]] - > function_c2c6a8c3(player, value);
}

function function_c063a71c(player, value) {
  [[self]] - > function_c063a71c(player, value);
}

function function_10415bce(player, value) {
  [[self]] - > function_10415bce(player, value);
}

function function_275127c2(player, value) {
  [[self]] - > function_275127c2(player, value);
}

function function_3d5ae5d4(player, value) {
  [[self]] - > function_3d5ae5d4(player, value);
}