/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1e49ab90e3dd5bb8.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace blackseajetskideployprompt;
class cblackseajetskideployprompt: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_26d9350e(localclientnum, value) {
    set_data(localclientnum, "deployProgress", value);
  }

  function register_clientside() {
    cluielem::register_clientside("BlackSeaJetskiDeployPrompt");
  }

  function setup_clientfields(var_8c9ddf96) {
    cluielem::setup_clientfields("BlackSeaJetskiDeployPrompt");
    cluielem::add_clientfield("deployProgress", 1, 5, "float", var_8c9ddf96);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "deployProgress", 0);
  }
}

function register(var_8c9ddf96) {
  elem = new cblackseajetskideployprompt();
  [[elem]] - > setup_clientfields(var_8c9ddf96);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
    level.var_ae746e8f[#"blackseajetskideployprompt"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
    level.var_ae746e8f[#"blackseajetskideployprompt"] = [];
  } else if(!isarray(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
    level.var_ae746e8f[#"blackseajetskideployprompt"] = array(level.var_ae746e8f[#"blackseajetskideployprompt"]);
  }

  level.var_ae746e8f[#"blackseajetskideployprompt"][level.var_ae746e8f[#"blackseajetskideployprompt"].size] = elem;
}

function register_clientside() {
  elem = new cblackseajetskideployprompt();
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

function function_26d9350e(localclientnum, value) {
  [[self]] - > function_26d9350e(localclientnum, value);
}