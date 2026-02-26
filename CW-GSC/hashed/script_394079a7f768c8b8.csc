/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_394079a7f768c8b8.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace pitch_and_yaw_meters;
class class_98cc868d: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("pitch_and_yaw_meters");
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("pitch_and_yaw_meters");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }
}

function register() {
  elem = new class_98cc868d();
  [[elem]] - > setup_clientfields();

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
    level.var_ae746e8f[#"pitch_and_yaw_meters"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
    level.var_ae746e8f[#"pitch_and_yaw_meters"] = [];
  } else if(!isarray(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
    level.var_ae746e8f[#"pitch_and_yaw_meters"] = array(level.var_ae746e8f[#"pitch_and_yaw_meters"]);
  }

  level.var_ae746e8f[#"pitch_and_yaw_meters"][level.var_ae746e8f[#"pitch_and_yaw_meters"].size] = elem;
}

function register_clientside() {
  elem = new class_98cc868d();
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