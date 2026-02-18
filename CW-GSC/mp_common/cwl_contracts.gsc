/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\cwl_contracts.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\util;
#namespace contracts;

function private autoexec __init__system__() {
  system::register(#"cwl_contracts", &preinit, undefined, &finalize_init, undefined);
}

function private preinit() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }

  init_player_contract_events();
}

function private finalize_init() {
  callback::on_connect(&on_player_connect);

  if(can_process_contracts()) {
    challenges::registerchallengescallback("gameEnd", &function_a4c8ce2a);
    globallogic_score::registercontractwinevent(&contract_win);
    register_player_contract_event(#"score", &on_player_score, 2);
    register_player_contract_event(#"ekia", &on_ekia, 2);
    register_player_contract_event(#"objective_ekia", &on_objective_ekia);
    register_player_contract_event(#"damagedone", &on_damagedone, 1);
    level.var_79a93566 = &function_902ef0de;
    level.var_c3e2bb05 = 2;
    function_7364a587();

    thread devgui_setup();
  }
}

function function_7364a587() {
  level.var_9d6b3096 = [];
  level.var_9d6b3096[# "hash_35a6541d081acef5"] = spawnStruct();
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"] = spawnStruct();
  level.var_9d6b3096[# "sd_cdl"] = spawnStruct();
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_9dd75c18 = 3000;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_9dd75c18 = 2500;
  level.var_9d6b3096[# "sd_cdl"].var_9dd75c18 = 500;
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_9a5a8dcf = 4000;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_9a5a8dcf = 3000;
  level.var_9d6b3096[# "sd_cdl"].var_9a5a8dcf = 1000;
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_f703cb6c = 20;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_f703cb6c = 15;
  level.var_9d6b3096[# "sd_cdl"].var_f703cb6c = 4;
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_39027dc7 = 30;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_39027dc7 = 25;
  level.var_9d6b3096[# "sd_cdl"].var_39027dc7 = 7;
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_81bbb381 = 3500;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_81bbb381 = 3000;
  level.var_9d6b3096[# "sd_cdl"].var_81bbb381 = 750;
  level.var_9d6b3096[# "hash_35a6541d081acef5"].var_9037b57b = 15;
  level.var_9d6b3096[# "hash_594c4ab1d31aa150"].var_9037b57b = 10;
  level.var_9d6b3096[# "sd_cdl"].var_9037b57b = 1;
}

function on_player_connect() {
  if(can_process_contracts()) {
    self setup_player_contracts(3, &function_1fd13839);
  }
}

function can_process_contracts() {
  if(getdvarint(#"contracts_enabled", 0) == 0) {
    return 0;
  }

  if(getdvarint(#"hash_332424e6c4a080d8", 1) == 0) {
    return 0;
  }

  if(!sessionmodeismultiplayergame()) {
    return 0;
  }

  if(level.var_73e51905 !== 1) {
    return 0;
  }

  if(level.arenamatch !== 1) {
    return 0;
  }

  return challenges::canprocesschallenges();
}

function on_player_score(new_score, delta_score) {
  gametype = level.gametype;

  if(!isDefined(level.var_9d6b3096[gametype])) {
    return;
  }

  player = self;
  old_score = new_score - delta_score;
  target_value = level.var_9d6b3096[gametype].var_9dd75c18;

  if(old_score < target_value) {
    if(new_score >= target_value) {
      player function_ccf82192(#"contract_wl_score_per_mode");

      switch (gametype) {
        case # "hash_35a6541d081acef5":
          player function_ccf82192(#"hash_ae762b8f099ea78");
          break;
        case # "hash_594c4ab1d31aa150":
          player function_ccf82192(#"hash_7f6444fe885ce68c");
          break;
        case # "sd_cdl":
          player function_ccf82192(#"hash_6eae617e00faf9d1");
          break;
      }
    }

    return;
  }

  var_2c74fba6 = level.var_9d6b3096[gametype].var_9a5a8dcf;

  if(old_score < var_2c74fba6 && new_score >= var_2c74fba6) {
    player function_ccf82192(#"hash_1075c38287814aa0");
  }
}

function on_ekia(weapon, victim) {
  gametype = level.gametype;

  if(!isDefined(level.var_9d6b3096[gametype])) {
    return;
  }

  player = self;
  var_350027d1 = player.pers[# "ekia"];

  if(var_350027d1 == level.var_9d6b3096[gametype].var_f703cb6c) {
    player function_ccf82192(#"hash_1d1b3fe36f24b6ac");

    switch (level.gametype) {
      case # "hash_35a6541d081acef5":
        player function_ccf82192(#"hash_5094a25541df9380");
        break;
      case # "hash_594c4ab1d31aa150":
        player function_ccf82192(#"hash_4a7745c3b4819d04");
        break;
      case # "sd_cdl":
        player function_ccf82192(#"hash_2783d4c96f09717");
        break;
    }

    return;
  }

  if(var_350027d1 == level.var_9d6b3096[gametype].var_39027dc7) {
    player function_ccf82192(#"hash_63e1c91ddca36b58");
  }
}

function on_objective_ekia() {
  gametype = level.gametype;

  if(!isDefined(level.var_9d6b3096[gametype])) {
    return;
  }

  player = self;
  objective_ekia = player.pers[# "objectiveekia"] + 1;

  if(objective_ekia == level.var_9d6b3096[gametype].var_9037b57b) {
    player function_ccf82192(#"hash_518ce6f8a5567a08");

    switch (level.gametype) {
      case # "hash_35a6541d081acef5":
        player function_ccf82192(#"hash_2b23579cbf8999f4");
        break;
      case # "hash_594c4ab1d31aa150":
        player function_ccf82192(#"hash_7182bb77d8974488");
        break;
      case # "sd_cdl":
        player function_ccf82192(#"hash_501faf9b8da2fcc7");
        break;
    }
  }
}

function on_damagedone(damagedone) {
  player = self;

  if(player is_contract_active(#"hash_783240d7e11018c9")) {
    gametype = level.gametype;

    if(!isDefined(level.var_9d6b3096[gametype])) {
      return;
    }

    var_2e0944a3 = self.pers[# "damagedone"];
    var_5f607191 = var_2e0944a3 - damagedone;
    target_value = level.var_9d6b3096[gametype].var_81bbb381;

    if(var_5f607191 < target_value && var_2e0944a3 >= target_value) {
      player function_ccf82192(#"hash_783240d7e11018c9");

      switch (level.gametype) {
        case # "hash_35a6541d081acef5":
          player function_ccf82192(#"hash_41263195cd7fa7f");
          break;
        case # "hash_594c4ab1d31aa150":
          player function_ccf82192(#"hash_5579ada75c110186");
          break;
        case # "sd_cdl":
          player function_ccf82192(#"hash_693d0b4e9c956a4");
          break;
      }
    }
  }
}

function function_ccf82192(var_38280f2f, delta = 1) {
  if(self is_contract_active(var_38280f2f)) {
    self function_902ef0de(var_38280f2f, delta);
  }
}

function private function_902ef0de(var_38280f2f, delta) {
  if(getdvarint(#"scr_contract_debug_multiplier", 0) > 0) {
    delta *= getdvarint(#"scr_contract_debug_multiplier", 1);
  }

  if(delta <= 0) {
    return;
  }

  target_value = self.pers[# "contracts"][var_38280f2f].target_value;
  old_progress = isDefined(self.pers[# "contracts"][var_38280f2f].current_value) ? self.pers[# "contracts"][var_38280f2f].current_value : self.pers[# "contracts"][var_38280f2f].var_59cb904f;

  if(old_progress == target_value) {
    return;
  }

  new_progress = int(old_progress + delta);

  if(new_progress > target_value) {
    new_progress = target_value;
  }

  if(new_progress != old_progress) {
    self.pers[# "contracts"][var_38280f2f].current_value = new_progress;

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
    }
  }

  if(old_progress < target_value && target_value <= new_progress) {
    var_9d12108c = isDefined(self.team) && isDefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0;
    self.pers[# "contracts"][var_38280f2f].var_be5bf249 = self stats::get_stat_global(#"time_played_total") - self.pers[# "hash_5651f00c6c1790a4"] + var_9d12108c;

    if(isDefined(level.contract_ids[var_38280f2f])) {
      self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
    }
  }

  if(getdvarint(#"scr_contract_debug", 0) > 0) {
    iprintln(function_9e72a96(var_38280f2f) + "<dev string:x38>" + new_progress + "<dev string:x47>" + target_value);

    if(old_progress < target_value && target_value <= new_progress) {
      iprintln(function_9e72a96(var_38280f2f) + "<dev string:x4c>");
    }
  }

}

function function_1fd13839(slot) {
  return function_d17bcd3c(slot);
}

function function_a4c8ce2a(data) {
  if(!isDefined(data)) {
    return;
  }

  player = data.player;

  if(!isPlayer(player)) {
    return;
  }

  player function_ccf82192(#"contract_wl_play_games");

  switch (level.gametype) {
    case # "hash_35a6541d081acef5":
      player function_ccf82192(#"hash_c3dd6c976fd6da0");
      break;
    case # "hash_594c4ab1d31aa150":
      player function_ccf82192(#"hash_59ddf56a06fffa34");
      break;
    case # "sd_cdl":
      player function_ccf82192(#"hash_41aad2f69ccae443");
      break;
  }

  team = player.team;

  if(isDefined(level.placement[team]) && player.score > 0) {
    last_check = min(level.placement.size, 3);

    for(i = 0; i < last_check; i++) {
      if(level.placement[team][i] == player) {
        player increment_contract(#"contract_wl_top_3_team");
        break;
      }
    }
  }

  arenaslot = arenagetslot();
  var_67d27328 = player stats::get_stat(#"arenastats", arenaslot, #"leagueplaystats", #"hash_36cd820c1ff6c16b");

  if(var_67d27328 > 0) {
    player increment_contract(#"hash_35e52e40ab6d1223", var_67d27328);
    player increment_contract(#"hash_421c3b5196a40f99", var_67d27328);
  }

  player function_78083139();
}

function contract_win(winner) {
  winner function_ccf82192(#"hash_4e903e32da421b17");
  winner function_ccf82192(#"hash_2809e14b0f3b4c5e");

  switch (level.gametype) {
    case # "hash_35a6541d081acef5":
      winner function_ccf82192(#"hash_7ad97dfb4e13dcf5");
      break;
    case # "hash_594c4ab1d31aa150":
      winner function_ccf82192(#"hash_1d7c20fdd4a3cef1");
      break;
    case # "sd_cdl":
      winner function_ccf82192(#"hash_70bec139292fe3e2");
      break;
  }

  var_283195f2 = winner stats::get_stat_global(#"hash_56a0e77eea02664d");

  if(var_283195f2 > 0) {
    if(var_283195f2 % 4 == 0) {
      winner function_ccf82192(#"contract_wl_win_streak_hard");
    }

    if(var_283195f2 % 2 == 0) {
      winner function_ccf82192(#"hash_4a14b348f01ad76d");
    }
  }
}

function devgui_setup() {
  devgui_base = "<dev string:x6e>";
  wait 3;
  function_e07e542b(devgui_base, undefined);
  function_17a92a99(devgui_base);
  function_7f05e018(devgui_base);
  function_bdc473ef(devgui_base);
  function_936f8390(devgui_base);
  function_2e9917ec(devgui_base);
  function_295a8005(devgui_base);
}

function function_17a92a99(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x83>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:xd5>", var_c8d599b5 + "<dev string:xf2>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x11b>", var_c8d599b5 + "<dev string:x137>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x15f>", var_c8d599b5 + "<dev string:x182>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x19c>", var_c8d599b5 + "<dev string:x1b1>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x1d2>", var_c8d599b5 + "<dev string:x1f2>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x217>", var_c8d599b5 + "<dev string:x237>");
}

function function_7f05e018(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x25c>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x272>", var_c8d599b5 + "<dev string:x27a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x28e>", var_c8d599b5 + "<dev string:x29c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x2b6>", var_c8d599b5 + "<dev string:x2c7>");
}

function function_bdc473ef(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x2e8>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x300>", var_c8d599b5 + "<dev string:x32c>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x350>", var_c8d599b5 + "<dev string:x36e>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x38c>", var_c8d599b5 + "<dev string:x3c2>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x3e1>", var_c8d599b5 + "<dev string:x417>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x43d>", var_c8d599b5 + "<dev string:x47d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x4ad>", var_c8d599b5 + "<dev string:x4ea>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x512>", var_c8d599b5 + "<dev string:x545>");
}

function function_936f8390(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x565>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x57b>", var_c8d599b5 + "<dev string:x5a5>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x5c7>", var_c8d599b5 + "<dev string:x5e3>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x5ff>", var_c8d599b5 + "<dev string:x633>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x650>", var_c8d599b5 + "<dev string:x682>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x6a6>", var_c8d599b5 + "<dev string:x6e4>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x712>", var_c8d599b5 + "<dev string:x74b>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x775>", var_c8d599b5 + "<dev string:x7a6>");
}

function function_2e9917ec(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:x7c4>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:x7e5>", var_c8d599b5 + "<dev string:x81a>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x83b>", var_c8d599b5 + "<dev string:x862>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x87d>", var_c8d599b5 + "<dev string:x8bb>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x8d7>", var_c8d599b5 + "<dev string:x913>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x936>", var_c8d599b5 + "<dev string:x97d>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:x9aa>", var_c8d599b5 + "<dev string:x9eb>");
  util::function_3f749abc(var_78a6fb52 + "<dev string:xa18>", var_c8d599b5 + "<dev string:xa53>");
}

function function_ef925b75(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:xa70>";
  var_c8d599b5 = "<dev string:x98>";
}

function function_295a8005(var_1d89ece6) {
  var_78a6fb52 = var_1d89ece6 + "<dev string:xa88>";
  var_c8d599b5 = "<dev string:x98>";
  util::function_3f749abc(var_78a6fb52 + "<dev string:xa9b>", var_c8d599b5 + "<dev string:xaad>");
}