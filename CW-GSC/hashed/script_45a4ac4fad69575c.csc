/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_45a4ac4fad69575c.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_keytrade;
class class_fd95a9c: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_3ae8b40f(localclientnum, value) {
    set_data(localclientnum, "confirmBtn", value);
  }

  function register_clientside() {
    cluielem::register_clientside("DOA_KeyTrade");
  }

  function function_8a6595db(localclientnum, value) {
    set_data(localclientnum, "textBoxHint", value);
  }

  function setup_clientfields(var_909954a3, var_66f4eb53) {
    cluielem::setup_clientfields("DOA_KeyTrade");
    cluielem::function_dcb34c80("string", "textBoxHint", 1);
    cluielem::function_dcb34c80("string", "confirmBtn", 1);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "textBoxHint", #"");
    set_data(localclientnum, "confirmBtn", #"");
  }
}

function register(var_909954a3, var_66f4eb53) {
  elem = new class_fd95a9c();
  [[elem]] - > setup_clientfields(var_909954a3, var_66f4eb53);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"doa_keytrade"])) {
    level.var_ae746e8f[#"doa_keytrade"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"doa_keytrade"])) {
    level.var_ae746e8f[#"doa_keytrade"] = [];
  } else if(!isarray(level.var_ae746e8f[#"doa_keytrade"])) {
    level.var_ae746e8f[#"doa_keytrade"] = array(level.var_ae746e8f[#"doa_keytrade"]);
  }

  level.var_ae746e8f[#"doa_keytrade"][level.var_ae746e8f[#"doa_keytrade"].size] = elem;
}

function register_clientside() {
  elem = new class_fd95a9c();
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

function function_8a6595db(localclientnum, value) {
  [[self]] - > function_8a6595db(localclientnum, value);
}

function function_3ae8b40f(localclientnum, value) {
  [[self]] - > function_3ae8b40f(localclientnum, value);
}