/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace codcasterclientmatchdata;

function function_5281975e60eac3a(var_127743befe53da2e) {
  if(!isDefined(self.var_a8f9789edd592f29)) {
    self.var_a8f9789edd592f29 = [];
  }

  if(!isDefined(self.var_a8f9789edd592f29[var_127743befe53da2e])) {
    self.var_a8f9789edd592f29[var_127743befe53da2e] = 0;
  }
}

function function_cc33f4ece5dca487(var_127743befe53da2e, index) {
  if(!isDefined(self.var_a8f9789edd592f29)) {
    self.var_a8f9789edd592f29 = [];
  }

  if(!isDefined(self.var_a8f9789edd592f29[var_127743befe53da2e])) {
    self.var_a8f9789edd592f29[var_127743befe53da2e] = [];
  }

  if(!isDefined(self.var_a8f9789edd592f29[var_127743befe53da2e][index])) {
    self.var_a8f9789edd592f29[var_127743befe53da2e][index] = 0;
  }
}

function function_b899bce95b7d6a94(var_cf76a3550b35080c) {
  if(!isDefined(self.var_e41d482461d4594f)) {
    self.var_e41d482461d4594f = [];
  }

  if(!isDefined(self.var_e41d482461d4594f[var_cf76a3550b35080c])) {
    self.var_e41d482461d4594f[var_cf76a3550b35080c] = 0;
  }
}

function function_d16498b27251da56(var_127743befe53da2e, increment) {
  function_5281975e60eac3a(var_127743befe53da2e);
  self.var_a8f9789edd592f29[var_127743befe53da2e] += increment;
  function_7ee466e81b1afc12(var_127743befe53da2e, self.var_a8f9789edd592f29[var_127743befe53da2e]);
}

function function_48544e365f4f5648(var_cf76a3550b35080c, increment) {
  function_b899bce95b7d6a94(var_cf76a3550b35080c);
  function_f8b808cd6473e6cc(var_cf76a3550b35080c, self.var_e41d482461d4594f[var_cf76a3550b35080c] + increment);
}

function function_7ee466e81b1afc12(var_127743befe53da2e, value) {
  if(!isPlayer(self)) {
    return;
  }

  function_5281975e60eac3a(var_127743befe53da2e);
  self.var_a8f9789edd592f29[var_127743befe53da2e] = value;
  self function_ac1512504ba75f25(var_127743befe53da2e, value);
}

function function_6807ed320b73be7f(var_127743befe53da2e, index, value) {
  if(!isPlayer(self)) {
    return;
  }

  function_cc33f4ece5dca487(var_127743befe53da2e, index);
  self.var_a8f9789edd592f29[var_127743befe53da2e][index] = value;
  self function_ac1512504ba75f25(var_127743befe53da2e, value, index);
}

function function_f8b808cd6473e6cc(var_cf76a3550b35080c, value) {
  if(!isPlayer(self)) {
    return;
  }

  function_b899bce95b7d6a94(var_cf76a3550b35080c);

  if(self.var_e41d482461d4594f[var_cf76a3550b35080c] != value) {
    self.var_e41d482461d4594f[var_cf76a3550b35080c] = value;
    self function_d743ebe29c5a6e7f(var_cf76a3550b35080c, value);
  }
}

function function_815fee43d577e1b6(var_127743befe53da2e) {
  function_5281975e60eac3a(var_127743befe53da2e);
  return self.var_a8f9789edd592f29[var_127743befe53da2e];
}

function function_a08fea26a49145a8(var_cf76a3550b35080c) {
  function_b899bce95b7d6a94(var_cf76a3550b35080c);
  return self.var_e41d482461d4594f[var_cf76a3550b35080c];
}

function function_aef8a28143d1f9ad(var_9138ab59ff517f7b) {
  if(!isDefined(self.var_1a34ed8eb5c6e9c)) {
    self.var_1a34ed8eb5c6e9c = [];
  }

  if(!isDefined(self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b])) {
    self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b] = 0;
  }
}

function function_1882f80b14421089(var_9138ab59ff517f7b, increment) {
  function_aef8a28143d1f9ad(var_9138ab59ff517f7b);
  self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b] += increment;
  function_5a82c337b996baa5(var_9138ab59ff517f7b, self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b]);
}

function function_5a82c337b996baa5(var_9138ab59ff517f7b, value) {
  if(!isPlayer(self)) {
    return;
  }

  function_aef8a28143d1f9ad(var_9138ab59ff517f7b);
  self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b] = value;
  function_ad829fab97971b4b(var_9138ab59ff517f7b);
}

function function_e42724fbfacff469(var_9138ab59ff517f7b) {
  function_aef8a28143d1f9ad(var_9138ab59ff517f7b);
  return self.var_1a34ed8eb5c6e9c[var_9138ab59ff517f7b];
}

function function_ad829fab97971b4b(var_9138ab59ff517f7b) {
  if(var_9138ab59ff517f7b == 0 || var_9138ab59ff517f7b == 1) {
    function_7ee466e81b1afc12(0, function_1b32a33893becbcf());
    return;
  }

  if(var_9138ab59ff517f7b == 6) {
    consecutivekills = self.var_1a34ed8eb5c6e9c[6];
    function_7ee466e81b1afc12(6, consecutivekills);
    var_51538fe8520e4052 = function_815fee43d577e1b6(7);

    if(consecutivekills > var_51538fe8520e4052) {
      function_7ee466e81b1afc12(7, consecutivekills);
    }

    return;
  }

  if(var_9138ab59ff517f7b == 3) {
    var_128ce76c9c22e1bc = self.var_1a34ed8eb5c6e9c[3];
    function_f8b808cd6473e6cc(13, function_d1f982e1e54336ec(var_128ce76c9c22e1bc));
    function_f8b808cd6473e6cc(14, function_d6a8339d07d64d73(var_128ce76c9c22e1bc));
    function_f8b808cd6473e6cc(1, dividestats(function_a08fea26a49145a8(0), var_128ce76c9c22e1bc));
    return;
  }

  if(var_9138ab59ff517f7b == 4) {
    var_b39bb65d413613b6 = self.var_1a34ed8eb5c6e9c[4];
    function_f8b808cd6473e6cc(5, function_d1f982e1e54336ec(var_b39bb65d413613b6));
    function_f8b808cd6473e6cc(6, function_d6a8339d07d64d73(var_b39bb65d413613b6));
    return;
  }

  if(var_9138ab59ff517f7b == 5) {
    if(function_726f071c1f349dd4()) {
      function_48544e365f4f5648(12, 1);
    }

    return;
  }
}

function function_726f071c1f349dd4() {
  function_b899bce95b7d6a94(12);
  return floor(self.var_1a34ed8eb5c6e9c[5]) > self.var_e41d482461d4594f[12];
}

function function_1b32a33893becbcf() {
  if(!isDefined(self.var_1a34ed8eb5c6e9c) || !isDefined(self.var_1a34ed8eb5c6e9c[0]) || !isDefined(self.var_1a34ed8eb5c6e9c[1])) {
    return 0;
  }

  shots = self.var_1a34ed8eb5c6e9c[0];

  if(shots <= 0) {
    return 0;
  }

  hits = self.var_1a34ed8eb5c6e9c[1];
  return hits / shots;
}

function function_d1f982e1e54336ec(var_3436f757aee9ef90) {
  return dividestats(self.pers["kills"], var_3436f757aee9ef90);
}

function function_d6a8339d07d64d73(var_3436f757aee9ef90) {
  return dividestats(function_815fee43d577e1b6(1), var_3436f757aee9ef90);
}

function dividestats(stat, denominator) {
  if(!isDefined(stat) || !isDefined(denominator) || denominator <= 0) {
    return 0;
  }

  return stat / denominator;
}

function function_2e28105e6500a144(player) {
  if(!isDefined(player)) {
    return;
  }

  logstring(player.name + ": ");
  debugstring = "\t\tcodcasterClientStats: ";

  if(isDefined(player.var_a8f9789edd592f29)) {
    foreach(index, value in player.var_a8f9789edd592f29) {
      if(!isarray(value)) {
        debugstring += value + "~ [" + index + "]" + " / ";
        continue;
      }

      foreach(i, indexedvalue in value) {
        debugstring += indexedvalue + ",";
      }

      debugstring += "~ [" + index + "]" + " / ";
    }
  }

  logstring(debugstring);
  debugstring = "\t\tlocalCodcasterClientStat: ";

  if(isDefined(player.var_1a34ed8eb5c6e9c)) {
    foreach(index, value in player.var_1a34ed8eb5c6e9c) {
      if(!isarray(value)) {
        debugstring += value + "~ [" + index + "]" + " / ";
        continue;
      }

      foreach(i, indexedvalue in value) {
        debugstring += indexedvalue + ",";
      }

      debugstring += "~ [" + index + "]" + " / ";
    }
  }

  logstring(debugstring);
  debugstring = "\t\tcodcasterGametypeClientStats: ";

  if(isDefined(player.var_e41d482461d4594f)) {
    foreach(index, value in player.var_e41d482461d4594f) {
      if(!isarray(value)) {
        debugstring += value + "~ [" + index + "]" + " / ";
        continue;
      }

      foreach(indexedvalue in value) {
        debugstring += indexedvalue + ",";
      }

      debugstring += "~ [" + index + "]" + " / ";
    }
  }

  logstring(debugstring);
}

function function_edba1ee7c2375a5() {
  game["codcasterClientStatsSaveBetweenRounds"] = [];
  game["localCodcasterClientStatsSaveBetweenRounds"] = [];
  game["codcasterGametypeClientStatsSaveBetweenRounds"] = [];

  foreach(player in level.players) {
    if(getdvarint(@ "hash_b0b065fcee59b58d", 0) == 1) {
      function_2e28105e6500a144(player);
    }

    game["codcasterClientStatsSaveBetweenRounds"][player.guid] = player.var_a8f9789edd592f29;
    game["localCodcasterClientStatsSaveBetweenRounds"][player.guid] = player.var_1a34ed8eb5c6e9c;
    game["codcasterGametypeClientStatsSaveBetweenRounds"][player.guid] = player.var_e41d482461d4594f;
  }
}

function function_9b229b18b0750bad() {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(game["codcasterClientStatsSaveBetweenRounds"]) || !isDefined(game["localCodcasterClientStatsSaveBetweenRounds"])) {
    return;
  }

  if(isDefined(game["codcasterClientStatsSaveBetweenRounds"][self.guid])) {
    self.var_a8f9789edd592f29 = game["codcasterClientStatsSaveBetweenRounds"][self.guid];
  } else {
    self.var_a8f9789edd592f29 = [];
  }

  if(isDefined(game["localCodcasterClientStatsSaveBetweenRounds"][self.guid])) {
    self.var_1a34ed8eb5c6e9c = game["localCodcasterClientStatsSaveBetweenRounds"][self.guid];
  } else {
    self.var_1a34ed8eb5c6e9c = [];
  }

  if(isDefined(game["codcasterGametypeClientStatsSaveBetweenRounds"][self.guid])) {
    self.var_e41d482461d4594f = game["codcasterGametypeClientStatsSaveBetweenRounds"][self.guid];
  } else {
    self.var_e41d482461d4594f = [];
  }

  if(getdvarint(@ "hash_b0b065fcee59b58d", 0) == 1) {
    logstring("=========================== retrieveCodcasterClientStats ==============================");
    function_2e28105e6500a144(self);
  }

  foreach(statid, statvalue in self.var_a8f9789edd592f29) {
    if(!isarray(self.var_a8f9789edd592f29[statid])) {
      function_7ee466e81b1afc12(statid, statvalue);
      continue;
    }

    foreach(index, value in self.var_a8f9789edd592f29[statid]) {
      function_6807ed320b73be7f(statid, index, value);
    }
  }

  foreach(statid, statvalue in self.var_e41d482461d4594f) {
    self function_d743ebe29c5a6e7f(statid, statvalue);
  }
}

function function_ee3acf6a8baa2ff8(killtime, attacker, victim) {
  if(!isDefined(level.var_b33b6a18519b1bbe)) {
    level.var_b33b6a18519b1bbe = [];
  }

  if(isDefined(victim) && isDefined(attacker)) {
    if(attacker.team != victim.team) {
      var_c7169d94937c6c29 = 0;
      liveremaining = scripts\mp\utility\teams::getteamdata(victim.team, "livesCount");

      switch (level.gametype) {
        case #"hash_a1313b745c17c07e":
          var_c7169d94937c6c29 = scripts\mp\utility\teams::getteamdata(victim.team, "livesCount") == 0 && scripts\mp\utility\teams::getfriendlyplayers(victim.team, 1).size == 0;
          break;
        case #"hash_aac44b0b52bacb8e":
        case #"hash_fa50b0f6bd82e972":
          var_c7169d94937c6c29 = scripts\mp\utility\teams::getteamdata(victim.team, "aliveCount") == 0;
          break;
        default:
          var_c7169d94937c6c29 = 0;
          break;
      }

      if(var_c7169d94937c6c29) {
        if(isDefined(attacker.pers["inapplicableTradedKills"]) && isDefined(victim.pers["inapplicableTradedDeaths"])) {
          attacker scripts\mp\utility\stats::incpersstat("inapplicableTradedKills", 1);
          victim scripts\mp\utility\stats::incpersstat("inapplicableTradedDeaths", 1);
        }
      } else {
        if(isDefined(victim.pers["untradedDeaths"])) {
          victim scripts\mp\utility\stats::incpersstat("untradedDeaths", 1);
        }

        attacker function_d16498b27251da56(5, 1);
      }

      newentry = [];
      newentry["killtime"] = killtime;
      newentry["attacker"] = attacker;
      newentry["victim"] = victim;

      while(self.var_b33b6a18519b1bbe.size > 0 && killtime - self.var_b33b6a18519b1bbe[0]["killtime"] > 5000) {
        self.var_b33b6a18519b1bbe = array_remove_index(self.var_b33b6a18519b1bbe, 0, 0);
      }

      for(entryindex = self.var_b33b6a18519b1bbe.size - 1; entryindex >= 0; entryindex--) {
        entry = self.var_b33b6a18519b1bbe[entryindex];

        if(isDefined(entry) && isDefined(entry["attacker"]) && isDefined(entry["victim"])) {
          if(entry["attacker"] == victim) {
            if(victim.lastkilledplayer == entry["victim"]) {
              if(isDefined(entry["attacker"].pers["tradedKills"]) && isDefined(entry["victim"].pers["untradedDeaths"]) && isDefined(entry["victim"].pers["tradedDeaths"])) {
                entry["attacker"] function_d16498b27251da56(5, -1);
                entry["victim"] function_d16498b27251da56(9, 1);
                entry["attacker"] scripts\mp\utility\stats::incpersstat("tradedKills", 1);
                entry["victim"] scripts\mp\utility\stats::incpersstat("untradedDeaths", -1);
                entry["victim"] scripts\mp\utility\stats::incpersstat("tradedDeaths", 1);
              }
            }

            self.var_b33b6a18519b1bbe = array_remove_index(self.var_b33b6a18519b1bbe, entryindex, 0);
          }
        }
      }

      self.var_b33b6a18519b1bbe[self.var_b33b6a18519b1bbe.size] = newentry;
      return;
    }

    if(isDefined(victim.pers["untradedDeaths"])) {
      victim scripts\mp\utility\stats::incpersstat("untradedDeaths", 1);
    }
  }
}

function function_6f792f70ffe4cd4d(attacker, victim) {
  level function_ee3acf6a8baa2ff8(gettime(), attacker, victim);
}

function function_94c8f3722d550646() {
  if(isDefined(level.var_bb581bb447e5a6a6)) {
    return;
  }

  isroundbasedgamemode = isroundbased();

  foreach(player in level.players) {
    if(isroundbasedgamemode) {
      player scripts\mp\codcasterclientmatchdata::function_1882f80b14421089(4, 1);
      continue;
    }

    player scripts\mp\codcasterclientmatchdata::function_1882f80b14421089(3, 1);
  }

  level.var_bb581bb447e5a6a6 = 1;
}