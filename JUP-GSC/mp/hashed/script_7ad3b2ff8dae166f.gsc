/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7ad3b2ff8dae166f.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace namespace_e422f53ac4bc98a4;

function autoexec main() {
  level.var_b8057c65baf0784a = spawnStruct();
  level.var_b8057c65baf0784a.init = &function_a114d6863af2f149;
  level.var_b8057c65baf0784a.var_d9f305202f6f3913 = &function_784a9a0ec8d203b9;
  level callback::add("killstreak_can_trigger", &function_3fbc4888ac56a);
  level callback::add("killstreak_finish_use", &function_b5001bf4e9beeb3e);
  level callback::add("killstreak_trigger_failed", &function_b5001bf4e9beeb3e);
}

function function_a114d6863af2f149() {
  if(!isDefined(level.gamemodebundle.var_671c47a45645026c)) {
    return;
  }

  var_e4fea1d5467252b4 = getscriptbundle(level.gamemodebundle.var_671c47a45645026c);
  level.var_e422f53ac4bc98a4 = {
    #match: {
      #deployables: []
    }, #teams: [], #rules: []
  };

  foreach(rulegroup in var_e4fea1d5467252b4.var_8fd13818a31a01ba) {
    foreach(rule in rulegroup.rulelist) {
      assertex(!isDefined(level.var_e422f53ac4bc98a4.rules[rule.name]), "<dev string:x1c>");

      if(rule.type == #"hash_4af11b8034b04aea") {
        level.var_e422f53ac4bc98a4.rules[rule.name] = rule;

        if(isDefined(rule.var_2c1ee79078c7bc2a.permatch) && isDefined(rule.var_2c1ee79078c7bc2a.perteam)) {
          assert(rule.var_2c1ee79078c7bc2a.perteam <= rule.var_2c1ee79078c7bc2a.permatch, "<dev string:x42>");
        }

        if(isDefined(rule.var_2c1ee79078c7bc2a.permatch) && isDefined(rule.var_2c1ee79078c7bc2a.perplayer)) {
          assert(rule.var_2c1ee79078c7bc2a.perplayer <= rule.var_2c1ee79078c7bc2a.permatch, "<dev string:x85>");
        }

        if(isDefined(rule.var_2c1ee79078c7bc2a.perteam) && isDefined(rule.var_2c1ee79078c7bc2a.perplayer)) {
          assert(rule.var_2c1ee79078c7bc2a.perplayer <= rule.var_2c1ee79078c7bc2a.perteam, "<dev string:xca>");
        }

        continue;
      }

      assertmsg("<dev string:x10e>");
    }
  }

  level.var_63121fffa39a5238 = 1;
}

function function_784a9a0ec8d203b9(bundle) {
  if(!istrue(level.var_63121fffa39a5238)) {
    return;
  }

  if(isDefined(bundle.var_e422f53ac4bc98a4)) {
    foreach(rule in bundle.var_e422f53ac4bc98a4) {
      assertex(isDefined(level.var_e422f53ac4bc98a4.rules[rule.name]), "<dev string:x132>");
    }
  }
}

function private function_3fbc4888ac56a(params) {
  if(!istrue(level.var_63121fffa39a5238)) {
    params.var_ea46784be09b48e0 = 1;
    return;
  }

  player = params.player;
  id = params.bundle.var_19fb085453713468;
  var_dc472c6c6f75536c = params.bundle.var_e422f53ac4bc98a4;
  params.var_ea46784be09b48e0 = function_de91481004edba65(player, id, var_dc472c6c6f75536c);
}

function private function_de91481004edba65(player, id, var_dc472c6c6f75536c) {
  if(!isDefined(var_dc472c6c6f75536c)) {
    return true;
  }

  if(!isDefined(player.var_e422f53ac4bc98a4)) {
    player.var_e422f53ac4bc98a4 = {
      #deployables: []
    };
  }

  if(!isDefined(player.var_e422f53ac4bc98a4.deployables[id])) {
    player.var_e422f53ac4bc98a4.deployables[id] = {
      #counts: []
    };
  }

  if(!isDefined(level.var_e422f53ac4bc98a4.teams[player.team])) {
    level.var_e422f53ac4bc98a4.teams[player.team] = {
      #deployables: []
    };
  }

  if(!isDefined(level.var_e422f53ac4bc98a4.teams[player.team].deployables[id])) {
    level.var_e422f53ac4bc98a4.teams[player.team].deployables[id] = {
      #counts: []
    };
  }

  if(!isDefined(level.var_e422f53ac4bc98a4.match.deployables[id])) {
    level.var_e422f53ac4bc98a4.match.deployables[id] = {
      #counts: []
    };
  }

  errormsg = istrue(level.var_e422f53ac4bc98a4.rules[var_dc472c6c6f75536c[0].name].var_8ff5c508700ace25) ? "KILLSTREAKS/AIR_SPACE_TOO_CROWDED" : "KILLSTREAKS/TOO_MANY_KILLSTREAK";

  if(!function_d56747948459c017(player, id, var_dc472c6c6f75536c)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]](errormsg);
    }

    return false;
  }

  function_4b4a7fc5dbb7f51f(player, id, var_dc472c6c6f75536c);
  return true;
}

function private function_d56747948459c017(player, id, var_dc472c6c6f75536c) {
  foreach(ruleref in var_dc472c6c6f75536c) {
    rule = level.var_e422f53ac4bc98a4.rules[ruleref.name];

    if(rule.type == #"hash_4af11b8034b04aea") {
      if(!isDefined(player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name])) {
        player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      if(!isDefined(level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name])) {
        level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      if(!isDefined(level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name])) {
        level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      playercount = player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name];
      teamcount = level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name];
      matchcount = level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name];

      if(!function_d0a009b77b2abfeb(rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount)) {
        return false;
      }
    }
  }

  return true;
}

function private function_4b4a7fc5dbb7f51f(player, id, var_dc472c6c6f75536c) {
  foreach(ruleref in var_dc472c6c6f75536c) {
    rule = level.var_e422f53ac4bc98a4.rules[ruleref.name];

    if(rule.type == #"hash_4af11b8034b04aea") {
      if(!isDefined(player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name])) {
        player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      if(!isDefined(level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name])) {
        level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      if(!isDefined(level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name])) {
        level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name] = {
          #count: undefined
        };
      }

      playercount = player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name];
      teamcount = level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name];
      matchcount = level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name];
      function_82da19a6031f4815(rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount);
    }
  }
}

function private function_b5001bf4e9beeb3e(params) {
  if(!istrue(level.var_63121fffa39a5238)) {
    return;
  }

  streakinfo = params.streakinfo;
  owner = streakinfo.owner;
  bundle = level.streakglobals.streakbundles[streakinfo.streakname];
  function_f918710cd8320f22(owner, bundle.var_19fb085453713468, bundle.var_e422f53ac4bc98a4);
}

function private function_f918710cd8320f22(player, id, var_dc472c6c6f75536c) {
  if(isDefined(var_dc472c6c6f75536c) && isDefined(player.var_e422f53ac4bc98a4)) {
    foreach(ruleref in var_dc472c6c6f75536c) {
      rule = level.var_e422f53ac4bc98a4.rules[ruleref.name];

      if(rule.type == #"hash_4af11b8034b04aea") {
        if(!isDefined(player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name])) {
          player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name] = {
            #count: undefined
          };
        }

        if(!isDefined(level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name])) {
          level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name] = {
            #count: undefined
          };
        }

        if(!isDefined(level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name])) {
          level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name] = {
            #count: undefined
          };
        }

        playercount = player.var_e422f53ac4bc98a4.deployables[id].counts[ruleref.name];
        teamcount = level.var_e422f53ac4bc98a4.teams[player.team].deployables[id].counts[ruleref.name];
        matchcount = level.var_e422f53ac4bc98a4.match.deployables[id].counts[ruleref.name];
        function_153a5eceee7d579c(rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount);
      }
    }
  }
}

function private function_d0a009b77b2abfeb(var_2c1ee79078c7bc2a, playercount, teamcount, matchcount) {
  if(isDefined(var_2c1ee79078c7bc2a.perplayer) && isDefined(playercount.count) && playercount.count >= var_2c1ee79078c7bc2a.perplayer) {
    return false;
  }

  if(isDefined(var_2c1ee79078c7bc2a.perteam) && isDefined(teamcount.count) && teamcount.count >= var_2c1ee79078c7bc2a.perteam) {
    return false;
  }

  if(isDefined(var_2c1ee79078c7bc2a.permatch) && isDefined(matchcount.count) && matchcount.count >= var_2c1ee79078c7bc2a.permatch) {
    return false;
  }

  return true;
}

function private function_82da19a6031f4815(var_2c1ee79078c7bc2a, playercount, teamcount, matchcount) {
  var_590c6775f1b37399 = isDefined(playercount.count) ? playercount.count + 1 : 1;
  var_4630a356021ae421 = isDefined(teamcount.count) ? teamcount.count + 1 : 1;
  var_185a1d050b79f38b = isDefined(matchcount.count) ? matchcount.count + 1 : 1;
  playercount.count = isDefined(var_2c1ee79078c7bc2a.perplayer) ? var_590c6775f1b37399 : undefined;
  teamcount.count = isDefined(var_2c1ee79078c7bc2a.perteam) ? var_4630a356021ae421 : undefined;
  matchcount.count = isDefined(var_2c1ee79078c7bc2a.permatch) ? var_185a1d050b79f38b : undefined;
}

function private function_153a5eceee7d579c(var_2c1ee79078c7bc2a, playercount, teamcount, matchcount) {
  if(isDefined(var_2c1ee79078c7bc2a.perplayer)) {
    assertex(playercount.count > 0, "<dev string:x153>");
    playercount.count -= 1;

    if(playercount.count == 0) {
      playercount.count = undefined;
    }
  }

  if(isDefined(var_2c1ee79078c7bc2a.perteam)) {
    assertex(teamcount.count > 0, "<dev string:x196>");
    teamcount.count -= 1;

    if(teamcount.count == 0) {
      teamcount.count = undefined;
    }
  }

  if(isDefined(var_2c1ee79078c7bc2a.permatch)) {
    assertex(matchcount.count > 0, "<dev string:x1d7>");
    matchcount.count -= 1;

    if(matchcount.count == 0) {
      matchcount.count = undefined;
    }
  }
}