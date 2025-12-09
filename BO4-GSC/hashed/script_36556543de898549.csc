/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_36556543de898549.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace seeker_mine_prompt;

class cseeker_mine_prompt: cluielem {
  function set_promptstate(localclientnum, value) {
    set_data(localclientnum, "promptState", value);
  }

  function set_progress(localclientnum, value) {
    set_data(localclientnum, "progress", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "seeker_mine_prompt");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "progress", 0);
    set_data(localclientnum, "promptState", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, progresscallback, var_19c23f0b) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("progress", 1, 5, "float", progresscallback);
    cluielem::add_clientfield("promptState", 1, 2, "int", var_19c23f0b);
  }

}

register(uid, progresscallback, var_19c23f0b) {
  elem = new cseeker_mine_prompt();
  [[elem]] - > setup_clientfields(uid, progresscallback, var_19c23f0b);
  return elem;
}

register_clientside(uid) {
  elem = new cseeker_mine_prompt();
  [[elem]] - > register_clientside(uid);
  return elem;
}

open(player) {
  [[self]] - > open(player);
}

close(player) {
  [[self]] - > close(player);
}

is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

set_progress(localclientnum, value) {
  [[self]] - > set_progress(localclientnum, value);
}

set_promptstate(localclientnum, value) {
  [[self]] - > set_promptstate(localclientnum, value);
}