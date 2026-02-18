/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7198e82f67d7691.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace evidence_board_mission_preview;
class class_fb1bfa12: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_10415bce(localclientnum, value) {
    set_data(localclientnum, "lvlDescriptionShort", value);
  }

  function function_275127c2(localclientnum, value) {
    set_data(localclientnum, "lvlDescriptionLong", value);
  }

  function function_3d5ae5d4(localclientnum, value) {
    set_data(localclientnum, "lvlProgress", value);
  }

  function function_57d3362b(localclientnum, value) {
    set_data(localclientnum, "activeState", value);
  }

  function register_clientside() {
    cluielem::register_clientside("evidence_board_mission_preview");
  }

  function setup_clientfields(var_5a7b4b38, var_ce679737, var_21c9fb3e, var_370e913b, var_4682a952, var_72328549, var_8c8b5d16) {
    cluielem::setup_clientfields("evidence_board_mission_preview");
    cluielem::add_clientfield("entNum", 1, 10, "int", var_370e913b);
    cluielem::add_clientfield("activeState", 1, 2, "int", var_4682a952);
    cluielem::add_clientfield("lvlYear", 1, 11, "int", var_72328549);
    cluielem::function_dcb34c80("string", "lvlName", 1);
    cluielem::function_dcb34c80("string", "lvlDescriptionShort", 1);
    cluielem::function_dcb34c80("string", "lvlDescriptionLong", 1);
    cluielem::add_clientfield("lvlProgress", 1, 4, "float", var_8c8b5d16);
  }

  function function_c063a71c(localclientnum, value) {
    set_data(localclientnum, "lvlName", value);
  }

  function function_c2c6a8c3(localclientnum, value) {
    set_data(localclientnum, "lvlYear", value);
  }

  function set_entnum(localclientnum, value) {
    set_data(localclientnum, "entNum", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "entNum", 0);
    set_data(localclientnum, "activeState", 0);
    set_data(localclientnum, "lvlYear", 0);
    set_data(localclientnum, "lvlName", #"");
    set_data(localclientnum, "lvlDescriptionShort", #"");
    set_data(localclientnum, "lvlDescriptionLong", #"");
    set_data(localclientnum, "lvlProgress", 0);
  }
}

function register(var_5a7b4b38, var_ce679737, var_21c9fb3e, var_370e913b, var_4682a952, var_72328549, var_8c8b5d16) {
  elem = new class_fb1bfa12();
  [[elem]] - > setup_clientfields(var_5a7b4b38, var_ce679737, var_21c9fb3e, var_370e913b, var_4682a952, var_72328549, var_8c8b5d16);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "evidence_board_mission_preview"])) {
    level.var_ae746e8f[# "evidence_board_mission_preview"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "evidence_board_mission_preview"])) {
    level.var_ae746e8f[# "evidence_board_mission_preview"] = [];
  } else if(!isarray(level.var_ae746e8f[# "evidence_board_mission_preview"])) {
    level.var_ae746e8f[# "evidence_board_mission_preview"] = array(level.var_ae746e8f[# "evidence_board_mission_preview"]);
  }

  level.var_ae746e8f[# "evidence_board_mission_preview"][level.var_ae746e8f[# "evidence_board_mission_preview"].size] = elem;
}

function register_clientside() {
  elem = new class_fb1bfa12();
  [[elem]] - > register_clientside();
  return elem;
}

function open(player) {
  [[self]] - > open(player);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

function set_entnum(localclientnum, value) {
  [[self]] - > set_entnum(localclientnum, value);
}

function function_57d3362b(localclientnum, value) {
  [[self]] - > function_57d3362b(localclientnum, value);
}

function function_c2c6a8c3(localclientnum, value) {
  [[self]] - > function_c2c6a8c3(localclientnum, value);
}

function function_c063a71c(localclientnum, value) {
  [[self]] - > function_c063a71c(localclientnum, value);
}

function function_10415bce(localclientnum, value) {
  [[self]] - > function_10415bce(localclientnum, value);
}

function function_275127c2(localclientnum, value) {
  [[self]] - > function_275127c2(localclientnum, value);
}

function function_3d5ae5d4(localclientnum, value) {
  [[self]] - > function_3d5ae5d4(localclientnum, value);
}