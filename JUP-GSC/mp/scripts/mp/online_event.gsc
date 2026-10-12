/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\online_event.gsc
***********************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace online_event;

function init() {
  if(scripts\cp_mp\utility\game_utility::ismagellanmode() && scripts\mp\utility\game::matchmakinggame()) {
    level.var_3392f98172a332d7 = 1;
  }
}

function function_3392f98172a332d7() {
  return istrue(level.var_3392f98172a332d7);
}

function function_abd8520a1b77ab7b(var_5ea5f0acd4fd6e5f) {
  var_e6d96e0e82e3743a = undefined;

  switch (var_5ea5f0acd4fd6e5f) {
    case #"hash_417c605750c7baa5":
    case #"hash_4ca1dc2e1b0de0d3":
      var_e6d96e0e82e3743a = 0;
      break;
    case #"hash_19ba8d41970911ad":
      var_e6d96e0e82e3743a = 1;
      break;
  }

  return var_e6d96e0e82e3743a;
}

function function_a23861c0f0635cf4(var_5ea5f0acd4fd6e5f) {
  if(isbot(self)) {
    return;
  }

  var_e6d96e0e82e3743a = function_abd8520a1b77ab7b(var_5ea5f0acd4fd6e5f);

  if(!isDefined(var_e6d96e0e82e3743a)) {
    return;
  }

  var_cc2e917291cc4a13 = self function_50f9d8900c83dc40();
  droprate = self function_9de349505d658eff(var_cc2e917291cc4a13, var_e6d96e0e82e3743a);

  if(droprate == 0) {
    return;
  }

  if(droprate < randomfloat(1)) {
    return;
  }

  edgeitemlist = self function_3993c643d423122a(var_cc2e917291cc4a13);
  edgeitemlist = function_9d27ef5aadbfaf3b(edgeitemlist);

  if(edgeitemlist.size == 0) {
    return;
  }

  totalrate = 0;

  for(index = 0; index < edgeitemlist.size; index++) {
    totalrate += edgeitemlist[index].weight;
  }

  randomrate = randomint(totalrate);
  edgeitem = 0;

  for(index = 0; index < edgeitemlist.size; index++) {
    randomrate -= edgeitemlist[index].weight;

    if(randomrate <= 0) {
      edgeitem = edgeitemlist[index].id;
      break;
    }
  }

  if(edgeitem == 0) {
    return;
  }

  aeeventname = #"hash_3971fbf1d7a8c855";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  params = [function_d6f771aedba70ce7(aeeventname, #"hash_311cc95400ed6a7f"), edgeitem, function_d6f771aedba70ce7(aeeventname, #"hash_81c8086c749c4bb9"), 1];

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
  }

  if(!isDefined(self.var_52e352f8923ed6f9)) {
    self.var_52e352f8923ed6f9 = [];
  }

  self.var_52e352f8923ed6f9[self.var_52e352f8923ed6f9.size] = edgeitem;
  self setclientomnvar("ui_edge_item_gain", edgeitem);
  waitframe();
  self setclientomnvar("ui_edge_item_gain", 0);
}

function function_9d27ef5aadbfaf3b(edgeitemlist) {
  ownedlist = self function_da5d6f8b4926cb90();
  var_6c2ac9eaf9d1b5d3 = [];

  for(index = 0; index < edgeitemlist.size; index++) {
    if(isDefined(ownedlist) && array_contains(ownedlist, edgeitemlist[index].id)) {
      continue;
    }

    if(isDefined(self.var_52e352f8923ed6f9) && array_contains(self.var_52e352f8923ed6f9, edgeitemlist[index].id)) {
      continue;
    }

    var_6c2ac9eaf9d1b5d3[var_6c2ac9eaf9d1b5d3.size] = edgeitemlist[index];
  }

  return var_6c2ac9eaf9d1b5d3;
}