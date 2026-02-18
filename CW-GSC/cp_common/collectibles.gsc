/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\collectibles.gsc
***********************************************/

#using script_6e46300ab1cb7adb;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\ui\prompts;
#namespace collectibles;

function private autoexec __init__system__() {
  system::register(#"collectibles", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.var_4ac1758e = [];
}

function private postinit() {
  function_5a395617();
}

function function_5a395617() {
  var_7bb83649 = [];
  var_bdf7b99d = [];
  var_b6e3d0a = getscriptbundle(#"evidenceboardlist");
  var_8f4db568 = var_b6e3d0a.var_48be729c;

  foreach(var_eeb11904 in var_8f4db568) {
    if(isDefined(var_eeb11904.collectiblelist)) {
      collectibles = var_eeb11904.collectiblelist;

      foreach(k, v in collectibles) {
        collectible = getscriptbundle(v.collectible);

        if(!isDefined(collectible.UnlockType)) {
          collectible.UnlockType = 0;
        }

        collectible.var_430d1d6a = var_eeb11904.var_8ca1d4a;
        collectible.index = k;

        if(collectible.index >= 10) {
          assert(0, "<dev string:x38>" + function_9e72a96(collectible.var_430d1d6a) + "<dev string:x68>" + 10);
        }

        if(!isDefined(var_bdf7b99d[collectible.UnlockType])) {
          var_bdf7b99d[collectible.UnlockType] = [];
        }

        if(collectible.UnlockType == 0) {
          if(!isDefined(var_bdf7b99d[collectible.UnlockType])) {
            var_bdf7b99d[collectible.UnlockType] = [];
          } else if(!isarray(var_bdf7b99d[collectible.UnlockType])) {
            var_bdf7b99d[collectible.UnlockType] = array(var_bdf7b99d[collectible.UnlockType]);
          }

          if(!isinarray(var_bdf7b99d[collectible.UnlockType], collectible)) {
            var_bdf7b99d[collectible.UnlockType][var_bdf7b99d[collectible.UnlockType].size] = collectible;
          }

          continue;
        }

        if(collectible.UnlockType == 1 || collectible.UnlockType == 2) {
          assert(isDefined(collectible.UnlockMap));

          if(!isDefined(var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap])) {
            var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap] = [];
          } else if(!isarray(var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap])) {
            var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap] = array(var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap]);
          }

          if(!isinarray(var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap], collectible)) {
            var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap][var_bdf7b99d[collectible.UnlockType][collectible.UnlockMap].size] = collectible;
          }

          continue;
        }

        if(collectible.UnlockType === 3) {
          assert(isDefined(collectible.var_f3575c58));
          assert(isDefined(collectible.UnlockMap));

          if(collectible.var_f3575c58 > 6) {
            assert(0, "<dev string:x92>" + function_9e72a96(collectible.UnlockMap) + "<dev string:xb9>" + 6);
          }

          if(isDefined(collectible.var_f3575c58) && isDefined(collectible.UnlockMap)) {
            if(!isDefined(var_7bb83649[collectible.var_f3575c58])) {
              var_7bb83649[collectible.var_f3575c58] = collectible;
            } else {
              var_91783c0f = var_7bb83649[collectible.var_f3575c58].name;
              assert(0, "<dev string:xec>" + function_9e72a96(collectible.UnlockMap) + "<dev string:x114>" + collectible.var_f3575c58 + "<dev string:x11e>" + function_9e72a96(collectible.name) + "<dev string:x124>" + function_9e72a96(var_91783c0f));
            }

            if(!isDefined(var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58])) {
              var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58] = [];
            } else if(!isarray(var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58])) {
              var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58] = array(var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58]);
            }

            if(!isinarray(var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58], collectible)) {
              var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58][var_bdf7b99d[collectible.UnlockType][collectible.var_f3575c58].size] = collectible;
            }
          }
        }
      }
    }
  }

  level.var_19cf69db = var_7bb83649;
  level.var_997b5425 = var_bdf7b99d;
}

function function_28bfb57e(mission_name = savegame::function_8136eb5a()) {
  var_1494351b = [];

  foreach(collectible in level.var_19cf69db) {
    if(collectible.UnlockMap == mission_name) {
      if(!isDefined(var_1494351b)) {
        var_1494351b = [];
      } else if(!isarray(var_1494351b)) {
        var_1494351b = array(var_1494351b);
      }

      var_1494351b[var_1494351b.size] = collectible;
    }
  }

  return var_1494351b;
}

function function_293d81b4(UnlockType = 0, key) {
  if(!isDefined(level.var_997b5425[UnlockType])) {
    level.var_997b5425[UnlockType] = [];
  }

  if(isDefined(key)) {
    if(!isDefined(level.var_997b5425[UnlockType][key])) {
      level.var_997b5425[UnlockType][key] = [];
    }

    return level.var_997b5425[UnlockType][key];
  }

  return level.var_997b5425[UnlockType];
}

function function_c57acbc9(var_2a51713, value = 1) {
  assert(isDefined(var_2a51713));
  player = getplayers()[0];
  assert(isPlayer(player));
  player stats::set_stat(#"collectibles", var_2a51713 - 1, value);
  uploadstats(player);
}

function function_ab921f3d(var_2a51713) {
  assert(isDefined(var_2a51713));
  player = getplayers()[0];
  assert(isPlayer(player));

  if(isPlayer(player)) {
    isunlocked = is_true(player stats::get_stat(#"collectibles", var_2a51713 - 1));
    return isunlocked;
  }

  return 0;
}

function function_316c48a3(var_d13a0347, var_28c9f917, var_bfb1faa4 = 1) {
  assert(isDefined(var_d13a0347));
  assert(isDefined(var_28c9f917));
  player = getplayers()[0];
  assert(isPlayer(player));

  if(var_bfb1faa4 == function_1fe63475(var_d13a0347, var_28c9f917)) {
    return;
  }

  player stats::set_stat(#"mapdata", var_d13a0347, #"evidence", var_28c9f917, var_bfb1faa4);
  player stats::set_stat(#"mapdata", var_d13a0347, #"hash_42b984266100b32", var_28c9f917, var_bfb1faa4);
  uploadstats(player);
}

function function_1fe63475(var_d13a0347, var_28c9f917) {
  assert(isDefined(var_d13a0347));
  assert(isDefined(var_28c9f917));
  player = getplayers()[0];
  assert(isPlayer(player));
  isunlocked = is_true(player stats::get_stat(#"mapdata", var_d13a0347, #"evidence", var_28c9f917));
  return isunlocked;
}

function function_ee216b9e(var_d13a0347, var_28c9f917) {
  assert(isDefined(var_d13a0347));
  assert(isDefined(var_28c9f917));
  player = getplayers()[0];
  assert(isPlayer(player));
  isnew = is_true(player stats::get_stat(#"mapdata", var_d13a0347, #"hash_42b984266100b32", var_28c9f917));
  return isnew;
}

function function_55fb73ea(var_d13a0347, var_28c9f917) {
  assert(isDefined(var_d13a0347));
  assert(isDefined(var_28c9f917));
  player = getplayers()[0];
  assert(isPlayer(player));

  if(!function_ee216b9e(var_d13a0347, var_28c9f917)) {
    return;
  }

  player stats::set_stat(#"mapdata", var_d13a0347, #"hash_42b984266100b32", var_28c9f917, 0);
  uploadstats(player);
}

function function_e8d5de2c(mission_name = savegame::function_8136eb5a()) {
  foreach(collectible in level.var_19cf69db) {
    if(collectible.UnlockMap == mission_name) {
      return true;
    }
  }

  return false;
}

function function_9f455dbc() {
  return level.var_19cf69db.size;
}

function function_9f976c54(mission_name = savegame::function_8136eb5a()) {
  var_80fc6600 = 0;

  foreach(collectible in level.var_19cf69db) {
    if(collectible.UnlockMap == mission_name) {
      var_80fc6600++;
    }
  }

  return var_80fc6600;
}

function function_99c4aa1(var_d13a0347) {
  if(!isDefined(var_d13a0347)) {
    return;
  }

  var_80fc6600 = 0;

  foreach(collectible in level.var_19cf69db) {
    if(collectible.var_430d1d6a == var_d13a0347) {
      var_80fc6600++;
    }
  }

  return var_80fc6600;
}

function function_ee839c3b() {
  var_9a849009 = 0;

  foreach(collectible in level.var_19cf69db) {
    if(is_true(function_ab921f3d(collectible.var_f3575c58))) {
      var_9a849009++;
    }
  }

  return var_9a849009;
}

function function_7be39f53(mission_name = savegame::function_8136eb5a()) {
  var_9a849009 = 0;

  foreach(collectible in level.var_19cf69db) {
    if(collectible.UnlockMap == mission_name) {
      if(is_true(function_ab921f3d(collectible.var_f3575c58))) {
        var_9a849009++;
      }
    }
  }

  return var_9a849009;
}

function function_5d5166dd(var_d13a0347) {
  if(!isDefined(var_d13a0347)) {
    return;
  }

  var_9a849009 = 0;

  foreach(collectible in level.var_19cf69db) {
    if(collectible.var_430d1d6a == var_d13a0347) {
      if(is_true(function_ab921f3d(collectible.var_f3575c58))) {
        var_9a849009++;
      }
    }
  }

  return var_9a849009;
}

function function_d06c5a39() {
  self prompts::set_text(#"hash_209c49282fbf4594");
  self prompts::function_309bf7c2(#"hash_1ca962038953ec7a");
}

function function_6cd091d2(var_2a51713, var_c05d6) {
  if(is_true(function_ab921f3d(var_2a51713))) {
    return;
  }

  function_cb8ff1b9(var_2a51713, 1);
  function_5b42ccea();
  collectible = level.var_19cf69db[var_2a51713];
  var_4bf53b01 = collectible.var_34754728;
  var_76e98c1f = collectible.var_444770d3;
  var_2a015e7e = function_5d5166dd(collectible.var_430d1d6a);
  var_f8f020e3 = function_99c4aa1(collectible.var_430d1d6a);
  thread namespace_a43d1663::init(var_4bf53b01, var_76e98c1f, var_2a015e7e, var_f8f020e3, var_c05d6);
}

function private function_cb8ff1b9(var_2a51713, is_unlocked) {
  function_c57acbc9(var_2a51713, is_unlocked);
  collectible = level.var_19cf69db[var_2a51713];
  function_316c48a3(collectible.var_430d1d6a, collectible.index, is_unlocked);
}

function function_5b42ccea() {}

function add_callback(collectible, callback) {
  level.var_4ac1758e[collectible] = callback;
}

function function_606a97af(collectible) {
  return isDefined(level.var_4ac1758e[collectible]);
}

function function_f539a1fa(collectible, params) {
  if(isDefined(level.var_4ac1758e[collectible])) {
    [[level.var_4ac1758e[collectible]]](params);
    return true;
  }

  return false;
}

function function_a66b8474() {
  foreach(id, collectible in level.var_19cf69db) {
    function_cb8ff1b9(id, 0);
  }
}

function function_4e4a7021() {
  foreach(id, collectible in level.var_19cf69db) {
    function_cb8ff1b9(id, 1);
  }
}