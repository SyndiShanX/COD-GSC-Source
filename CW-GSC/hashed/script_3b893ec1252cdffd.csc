/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3b893ec1252cdffd.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_overworld;
class cdoa_overworld: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("DOA_Overworld");
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("DOA_Overworld");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }
}

function register() {
  elem = new cdoa_overworld();
  [[elem]] - > setup_clientfields();

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "doa_overworld"])) {
    level.var_ae746e8f[# "doa_overworld"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "doa_overworld"])) {
    level.var_ae746e8f[# "doa_overworld"] = [];
  } else if(!isarray(level.var_ae746e8f[# "doa_overworld"])) {
    level.var_ae746e8f[# "doa_overworld"] = array(level.var_ae746e8f[# "doa_overworld"]);
  }

  level.var_ae746e8f[# "doa_overworld"][level.var_ae746e8f[# "doa_overworld"].size] = elem;
}

function register_clientside() {
  elem = new cdoa_overworld();
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