/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_557089630e09eb03.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace onslaught_hud;
class class_b6739d61: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_1c28d7c2(localclientnum, value) {
    set_data(localclientnum, "showBossAlert", value);
  }

  function function_2a0b1f84(localclientnum, value) {
    set_data(localclientnum, "score3Points", value);
  }

  function register_clientside() {
    cluielem::register_clientside("onslaught_hud");
  }

  function function_71fd1345(localclientnum, value) {
    set_data(localclientnum, "showLottoLoadouts", value);
  }

  function setup_clientfields(var_ef8933e3, var_61963aa5, var_964ac54, var_a584bc49, var_52a170c, var_4e7bf429, var_9a88505e, var_e805c474, var_f1a2774e, var_c22b2a20) {
    cluielem::setup_clientfields("onslaught_hud");
    cluielem::function_dcb34c80("string", "bossAlertText", 1);
    cluielem::function_dcb34c80("string", "objective2Text", 1);
    cluielem::add_clientfield("score3Points", 1, 8, "int", var_a584bc49);
    cluielem::function_dcb34c80("string", "objectiveText", 1);
    cluielem::add_clientfield("showEndScore", 1, 1, "int", var_52a170c);
    cluielem::add_clientfield("showScore", 1, 1, "int", var_4e7bf429);
    cluielem::add_clientfield("showObjective", 1, 1, "int", var_9a88505e);
    cluielem::add_clientfield("showBossAlert", 1, 1, "int", var_e805c474);
    cluielem::add_clientfield("showObjective2", 1, 1, "int", var_f1a2774e);
    cluielem::add_clientfield("showLottoLoadouts", 1, 2, "int", var_c22b2a20);
  }

  function function_9b5f8a75(localclientnum, value) {
    set_data(localclientnum, "showEndScore", value);
  }

  function function_9c1c0811(localclientnum, value) {
    set_data(localclientnum, "objective2Text", value);
  }

  function function_b73d2d7c(localclientnum, value) {
    set_data(localclientnum, "bossAlertText", value);
  }

  function function_d0a02472(localclientnum, value) {
    set_data(localclientnum, "showObjective", value);
  }

  function function_d6b5fdc4(localclientnum, value) {
    set_data(localclientnum, "showObjective2", value);
  }

  function function_da96c24e(localclientnum, value) {
    set_data(localclientnum, "showScore", value);
  }

  function set_objectivetext(localclientnum, value) {
    set_data(localclientnum, "objectiveText", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "bossAlertText", #"");
    set_data(localclientnum, "objective2Text", #"");
    set_data(localclientnum, "score3Points", 0);
    set_data(localclientnum, "objectiveText", #"");
    set_data(localclientnum, "showEndScore", 0);
    set_data(localclientnum, "showScore", 0);
    set_data(localclientnum, "showObjective", 0);
    set_data(localclientnum, "showBossAlert", 0);
    set_data(localclientnum, "showObjective2", 0);
    set_data(localclientnum, "showLottoLoadouts", 0);
  }
}

function register(var_ef8933e3, var_61963aa5, var_964ac54, var_a584bc49, var_52a170c, var_4e7bf429, var_9a88505e, var_e805c474, var_f1a2774e, var_c22b2a20) {
  elem = new class_b6739d61();
  [[elem]] - > setup_clientfields(var_ef8933e3, var_61963aa5, var_964ac54, var_a584bc49, var_52a170c, var_4e7bf429, var_9a88505e, var_e805c474, var_f1a2774e, var_c22b2a20);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "onslaught_hud"])) {
    level.var_ae746e8f[# "onslaught_hud"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "onslaught_hud"])) {
    level.var_ae746e8f[# "onslaught_hud"] = [];
  } else if(!isarray(level.var_ae746e8f[# "onslaught_hud"])) {
    level.var_ae746e8f[# "onslaught_hud"] = array(level.var_ae746e8f[# "onslaught_hud"]);
  }

  level.var_ae746e8f[# "onslaught_hud"][level.var_ae746e8f[# "onslaught_hud"].size] = elem;
}

function register_clientside() {
  elem = new class_b6739d61();
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

function function_b73d2d7c(localclientnum, value) {
  [[self]] - > function_b73d2d7c(localclientnum, value);
}

function function_9c1c0811(localclientnum, value) {
  [[self]] - > function_9c1c0811(localclientnum, value);
}

function function_2a0b1f84(localclientnum, value) {
  [[self]] - > function_2a0b1f84(localclientnum, value);
}

function set_objectivetext(localclientnum, value) {
  [[self]] - > set_objectivetext(localclientnum, value);
}

function function_9b5f8a75(localclientnum, value) {
  [[self]] - > function_9b5f8a75(localclientnum, value);
}

function function_da96c24e(localclientnum, value) {
  [[self]] - > function_da96c24e(localclientnum, value);
}

function function_d0a02472(localclientnum, value) {
  [[self]] - > function_d0a02472(localclientnum, value);
}

function function_1c28d7c2(localclientnum, value) {
  [[self]] - > function_1c28d7c2(localclientnum, value);
}

function function_d6b5fdc4(localclientnum, value) {
  [[self]] - > function_d6b5fdc4(localclientnum, value);
}

function function_71fd1345(localclientnum, value) {
  [[self]] - > function_71fd1345(localclientnum, value);
}