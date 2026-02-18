/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7a5cff90cf27582c.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace blackseajetskideployprompt;
class cblackseajetskideployprompt: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_26d9350e(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "deployProgress", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("BlackSeaJetskiDeployPrompt");
    cluielem::add_clientfield("deployProgress", 1, 5, "float");
  }
}

function register() {
  elem = new cblackseajetskideployprompt();
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

function function_26d9350e(player, value) {
  [[self]] - > function_26d9350e(player, value);
}