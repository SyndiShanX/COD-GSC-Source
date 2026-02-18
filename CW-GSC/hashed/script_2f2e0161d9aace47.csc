/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2f2e0161d9aace47.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_gold_align_satellite_hud;
class class_eaf2482a: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("zm_gold_align_satellite_hud");
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("zm_gold_align_satellite_hud");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }
}

function register() {
  elem = new class_eaf2482a();
  [[elem]] - > setup_clientfields();

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "zm_gold_align_satellite_hud"])) {
    level.var_ae746e8f[# "zm_gold_align_satellite_hud"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "zm_gold_align_satellite_hud"])) {
    level.var_ae746e8f[# "zm_gold_align_satellite_hud"] = [];
  } else if(!isarray(level.var_ae746e8f[# "zm_gold_align_satellite_hud"])) {
    level.var_ae746e8f[# "zm_gold_align_satellite_hud"] = array(level.var_ae746e8f[# "zm_gold_align_satellite_hud"]);
  }

  level.var_ae746e8f[# "zm_gold_align_satellite_hud"][level.var_ae746e8f[# "zm_gold_align_satellite_hud"].size] = elem;
}

function register_clientside() {
  elem = new class_eaf2482a();
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