/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_24946c036cb2f7b2.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_24946c036cb2f7b2;
#using script_24f248b33b79e48d;
#using script_3ab210ea917601e7;
#using script_54f6d121e91434f8;
#using script_6617e2f2bb62b52b;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\loot;
#namespace namespace_c3cbdb17ee537af1;

function function_cb146e445d78e9ee() {
  self.var_741c4f3150e30c83 = function_195ff27978a91a68(self, 1, 0, 0);
}

function function_a7679b1e7a48f91(activationname, players, var_c3b480c3f8207bab) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return 0;
  }

  var_d4464743d0edff8c = function_a6dfaa6e79adbc09(activationname);

  if(!isDefined(var_d4464743d0edff8c)) {
    return;
  }

  if(isDefined(var_d4464743d0edff8c.delay)) {
    wait var_d4464743d0edff8c.delay;
  }

  return function_5b45cad5c8f016ab(var_d4464743d0edff8c.ref, players, 0, var_c3b480c3f8207bab);
}

function function_43007b614b2eb884(activationname, players, cooldownseconds) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return 0;
  }

  var_d4464743d0edff8c = function_a6dfaa6e79adbc09(activationname);

  if(!isDefined(var_d4464743d0edff8c)) {
    return;
  }

  if(isDefined(var_d4464743d0edff8c.delay)) {
    wait var_d4464743d0edff8c.delay;
  }

  var_1d1eecf1ed7cbdb0 = namespace_9718b9a169c3ead0::function_d52f11eff492795d(players[0], 1);

  if(!isDefined(var_1d1eecf1ed7cbdb0)) {
    return;
  }

  var_1d1eecf1ed7cbdb0 = var_d4464743d0edff8c.ref + var_1d1eecf1ed7cbdb0;
  function_7175613cab6db0dc(var_1d1eecf1ed7cbdb0, var_d4464743d0edff8c.ref, players, cooldownseconds);
}

function function_5b45cad5c8f016ab(eventref, players, includedeadplayers, var_c3b480c3f8207bab) {
  var_2787b644956f87d9 = function_73e12b91e73e2977(players);

  if(var_2787b644956f87d9.size == 0) {
    return 0;
  }

  return scripts\cp_mp\overlord::playevent(eventref, var_2787b644956f87d9, 0, includedeadplayers, var_c3b480c3f8207bab);
}

function function_90db3e7d7b085484(var_1d1eecf1ed7cbdb0, eventref, players) {
  var_2787b644956f87d9 = function_73e12b91e73e2977(players);

  if(var_2787b644956f87d9.size == 0) {
    return 0;
  }

  return scripts\cp_mp\overlord::function_9b411de07c46bddc(eventref, var_2787b644956f87d9, 0, var_1d1eecf1ed7cbdb0);
}

function function_7175613cab6db0dc(var_1d1eecf1ed7cbdb0, eventref, players, cooldownseconds) {
  if(!isDefined(self.var_11ac05ea8fa7826d)) {
    self.var_11ac05ea8fa7826d = [];
  }

  currenttime = gettime();
  var_73ddaf989477e28c = self.var_11ac05ea8fa7826d[var_1d1eecf1ed7cbdb0];

  if(isDefined(var_73ddaf989477e28c) && var_73ddaf989477e28c + cooldownseconds * 1000 > currenttime) {
    return;
  }

  if(function_5b45cad5c8f016ab(eventref, players)) {
    self.var_11ac05ea8fa7826d[var_1d1eecf1ed7cbdb0] = currenttime;
  }
}

function private function_a6dfaa6e79adbc09(activationname) {
  if(!isDefined(activationname)) {
    return undefined;
  }

  var_4fb0bb8290e39fb3 = function_e38f1d6d5a208fe1(activationname);
  assertex(var_4fb0bb8290e39fb3.size == 1, "<dev string:x1c>" + activationname + "<dev string:x70>");
  broadcastdata = var_4fb0bb8290e39fb3[0] function_7437a8d48556e45e();
  assertex(broadcastdata.size == 1, "<dev string:x81>" + activationname + "<dev string:x70>");
  var_a0df226025d98d74 = spawnStruct();
  var_a0df226025d98d74.ref = function_84ac089886facee5(broadcastdata[0]);
  var_a0df226025d98d74.delay = function_ffbb8d6b4076cfa7(broadcastdata[0]);
  var_a0df226025d98d74.isconversation = function_63b7c6f0e6f2a9f7(broadcastdata[0]);
  var_a0df226025d98d74.var_a992c85bbf2c3bd6 = function_63b7c6f0e6f2a9f7(broadcastdata[0]);
  return var_a0df226025d98d74;
}

function private function_73e12b91e73e2977(players) {
  var_2787b644956f87d9 = [];

  if(isDefined(self.var_741c4f3150e30c83) && isDefined(players) && isarray(players)) {
    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!function_93587d5ba6247f36(self.var_741c4f3150e30c83, player)) {
        continue;
      }

      var_2787b644956f87d9[var_2787b644956f87d9.size] = player;
    }
  }

  return var_2787b644956f87d9;
}

function function_d52f11eff492795d(player, var_45e792783f2a92ab, var_81c927dcd9cba1f9) {
  key = undefined;

  if(isDefined(player)) {
    if(istrue(var_45e792783f2a92ab)) {
      if(isDefined(player.team) && isDefined(player.sessionsquadid)) {
        key = "team:" + player.team + "id:" + player.sessionsquadid;
      }
    } else if(isDefined(player.guid)) {
      key = "playerguid:" + player.guid;
    }
  }

  if(isDefined(key) && istrue(var_81c927dcd9cba1f9) && isDefined(self)) {
    activityid = namespace_4fda5d7358015a06::function_f0f498aed6f8fa5d(self);

    if(isDefined(activityid)) {
      key = "activityid:" + activityid + key;
    }
  }

  return key;
}

function function_1abf09c903e6c16b(players, lootref) {
  if(!isDefined(players) || !isarray(players) || players.size == 0) {
    return false;
  }

  if(!isDefined(lootref)) {
    return false;
  }

  lootid = scripts\cp_mp\utility\loot::getlootidfromref(lootref);

  if(!isDefined(lootid)) {
    return false;
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    backpackindex = player scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(lootid);

    if(backpackindex != -1) {
      return true;
    }
  }

  return false;
}