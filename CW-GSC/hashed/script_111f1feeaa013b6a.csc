/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_111f1feeaa013b6a.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace bountyhunterbuy;
class cbountyhunterbuy: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("BountyHunterBuy");
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("BountyHunterBuy");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }
}

function register() {
  elem = new cbountyhunterbuy();
  [[elem]] - > setup_clientfields();

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"bountyhunterbuy"])) {
    level.var_ae746e8f[#"bountyhunterbuy"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"bountyhunterbuy"])) {
    level.var_ae746e8f[#"bountyhunterbuy"] = [];
  } else if(!isarray(level.var_ae746e8f[#"bountyhunterbuy"])) {
    level.var_ae746e8f[#"bountyhunterbuy"] = array(level.var_ae746e8f[#"bountyhunterbuy"]);
  }

  level.var_ae746e8f[#"bountyhunterbuy"][level.var_ae746e8f[#"bountyhunterbuy"].size] = elem;
}

function register_clientside() {
  elem = new cbountyhunterbuy();
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