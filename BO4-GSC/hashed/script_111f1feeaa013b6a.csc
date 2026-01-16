/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_111f1feeaa013b6a.csc
***********************************************/

#include scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

class cbountyhunterbuy: cluielem {

  function open(localclientnum) {
    cluielem::open(localclientnum, #"bountyhunterbuy");
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
  }

}

register(uid) {
  elem = new cbountyhunterbuy();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

register_clientside(uid) {
  elem = new cbountyhunterbuy();
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