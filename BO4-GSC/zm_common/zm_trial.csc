/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_trial.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial;

autoexec __init__system__() {
  system::register(#"zm_trial", &__init__, undefined, undefined);
}

__init__() {
  if(!is_trial_mode()) {
    return;
  }

  level.var_c556bb2e = [];
  function_4dbf2663();
}

function_d02ffd(name) {
  foreach(var_6d87ac05 in level.var_c556bb2e) {
    if(var_6d87ac05.name == name) {
      return var_6d87ac05;
    }
  }

  return undefined;
}

function_ce2fdd3b(index) {
  if(isDefined(level.var_c556bb2e) && isDefined(level.var_c556bb2e[index])) {
    return level.var_c556bb2e[index];
  }

  return undefined;
}

is_trial_mode() {
  return zm_utility::is_trials();
}

register_challenge(name, var_c5dd8620, var_bbcdbff5) {
  if(!isDefined(level.var_75e93a54)) {
    level.var_75e93a54 = [];
  }

  assert(!isDefined(level.var_75e93a54[name]));
  info = {
    #name: name, 
    #var_c5dd8620: var_c5dd8620, 
    #var_bbcdbff5: var_bbcdbff5
  };
  level.var_75e93a54[name] = info;
}

function_a36e8c38(name) {
  if(is_trial_mode() && isDefined(level.var_1420e3f6)) {
    foreach(active_challenge in level.var_1420e3f6.challenges) {
      if(active_challenge.name == name) {
        return active_challenge;
      }
    }
  }

  return undefined;
}

private function_4dbf2663() {
  var_3b363b7a = getgametypesetting(#"zmtrialsvariant");

  if(isDefined(var_3b363b7a) && var_3b363b7a > 0) {
    table = hash("gamedata/tables/zm/" + util::get_map_name() + "_trials_variant_" + var_3b363b7a + ".csv");
  } else {
    table = hash("gamedata/tables/zm/" + util::get_map_name() + "_trials.csv");
  }

  column_count = tablelookupcolumncount(table);
  var_e1617d73 = tablelookuprowcount(table);
  row = 0;

  while(row < var_e1617d73) {
    var_189d26ca = tablelookupcolumnforrow(table, row, 1);
    assert(!isDefined(function_d02ffd(var_189d26ca)));
    var_6d87ac05 = {
      #name: var_189d26ca, 
      #rounds: [], 
      #index: level.var_c556bb2e.size
    };
    level.var_c556bb2e[level.var_c556bb2e.size] = var_6d87ac05;

    do {
      row++;
      round = tablelookupcolumnforrow(table, row, 0);

      if(row < var_e1617d73 && round != 0) {
        round_index = round - 1;

        if(!isDefined(var_6d87ac05.rounds[round_index])) {
          var_6d87ac05.rounds[round_index] = {};
          round_info = var_6d87ac05.rounds[round_index];
          round_info.name = tablelookupcolumnforrow(table, row, 1);
          round_info.round = round;
          round_info.name_str = tablelookupcolumnforrow(table, row, 2);
          round_info.desc_str = tablelookupcolumnforrow(table, row, 3);
          round_info.challenges = [];
        }

        assert(isDefined(var_6d87ac05.rounds[round_index]));
        round_info = var_6d87ac05.rounds[round_index];
        challenge_name = tablelookupcolumnforrow(table, row, 5);
        var_10a28798 = [];
        array::add(round_info.challenges, {
          #name: challenge_name, 
          #row: row, 
          #params: var_10a28798
        });

        for(i = 0; i < 8; i++) {
          param = tablelookupcolumnforrow(table, row, 6 + i);

          if(isDefined(param) && param != #"") {
            var_10a28798[var_10a28798.size] = param;
          }
        }
      }
    }
    while(row < var_e1617d73 && round != 0);
  }

  level.var_6d87ac05 = level.var_c556bb2e[0];
}