/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_669cea9418ec7fe2.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace zm_corrupted_health_bar;
class class_c982469d: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("zm_corrupted_health_bar");
  }

  function function_74adcd8a(localclientnum, value) {
    set_data(localclientnum, "armor_vis", value);
  }

  function setup_clientfields(healthcallback, var_4ec2b207, var_ed81ff07) {
    cluielem::setup_clientfields("zm_corrupted_health_bar");
    cluielem::add_clientfield("health", 4000, 7, "float", healthcallback);
    cluielem::add_clientfield("armor", 4000, 7, "float", var_4ec2b207);
    cluielem::add_clientfield("armor_vis", 4000, 1, "int", var_ed81ff07);
  }

  function set_armor(localclientnum, value) {
    set_data(localclientnum, "armor", value);
  }

  function set_health(localclientnum, value) {
    set_data(localclientnum, "health", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "health", 0);
    set_data(localclientnum, "armor", 0);
    set_data(localclientnum, "armor_vis", 0);
  }
}

function register(healthcallback, var_4ec2b207, var_ed81ff07) {
  elem = new class_c982469d();
  [[elem]] - > setup_clientfields(healthcallback, var_4ec2b207, var_ed81ff07);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "zm_corrupted_health_bar"])) {
    level.var_ae746e8f[# "zm_corrupted_health_bar"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "zm_corrupted_health_bar"])) {
    level.var_ae746e8f[# "zm_corrupted_health_bar"] = [];
  } else if(!isarray(level.var_ae746e8f[# "zm_corrupted_health_bar"])) {
    level.var_ae746e8f[# "zm_corrupted_health_bar"] = array(level.var_ae746e8f[# "zm_corrupted_health_bar"]);
  }

  level.var_ae746e8f[# "zm_corrupted_health_bar"][level.var_ae746e8f[# "zm_corrupted_health_bar"].size] = elem;
}

function register_clientside() {
  elem = new class_c982469d();
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

function set_health(localclientnum, value) {
  [[self]] - > set_health(localclientnum, value);
}

function set_armor(localclientnum, value) {
  [[self]] - > set_armor(localclientnum, value);
}

function function_74adcd8a(localclientnum, value) {
  [[self]] - > function_74adcd8a(localclientnum, value);
}