/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_58b1eca22500284f.gsc
*************************************************/

#using script_342e51952b63e594;
#using scripts\common\utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\stationary_notes;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#namespace namespace_bf5795f2ab4f8798;

function function_88fbe091ebbda87c() {
  if(getdvarint(@ "hash_f8b075119c563072", 1) == 0) {
    return;
  }

  level.bbshop = spawnStruct();
  level.bbshop.speakingpriority = 0;
  level.bbshop.var_7039e552e73d25a1 = undefined;
  level.bbshop.var_48c882aea7e3896f = -1;

  if(level.mapname == "mp_ai_firefight") {
    level.bbshop.speakerorigin = (1716, 1566, 200);
    level.bbshop.speakereyeorigin = (1716, 1566, 200);
  } else if(level.mapname == "mp_biobunker") {
    level.bbshop.speakerorigin = (-9085, 11650, 1695);
    level.bbshop.speakereyeorigin = (-9085, 11681, 1695);
  }

  level.bbshop.var_35b62437221af0e5 = spawnscriptable("dmz_biobunker_shopkeeper_voice", level.bbshop.speakerorigin, (0, 0, 0));
  level.bbshop.var_4e6e1a3a72bd88d2 = getStructArray("shoppingListLoc", "targetname");
  level.bbshop.var_e57f4a6f7e313e90 = undefined;

  if(getdvarint(@ "hash_fbeb3e3edce37b14", 0)) {
    level.bbshop.var_e57f4a6f7e313e90 = getStructArray("shoppingListDebugItem", "targetname");
  }

  level.bbshop.var_3fa3e4e3abb61e4d = [];
  level.bbshop.playerscansee = [];
  level.bbshop.playerslost = [];
  level thread function_5b927062b844e007();
  level thread function_9dfc2bb48a54cd50();
  level thread function_68613df3dd9c24a1();
  level thread function_c17cfc74e781a94a();
}

function function_c17cfc74e781a94a() {
  level endon("game_ended");
  interval = 0.1;
  timewaited = 0;

  while(true) {
    linespoken = 0;
    combataround = function_a8501c6fe24440eb();

    if(istrue(combataround)) {
      linespoken = function_d6c06e62befcf33f("CombatAround", 3);

      if(istrue(linespoken)) {
        timewaited = 0;
      }
    }

    if(!istrue(linespoken)) {
      player = function_dea6a60b8e33598f(level.bbshop.speakerorigin);

      if(isDefined(player)) {
        linespoken = function_dd677378528c056f(player);

        if(istrue(linespoken)) {
          timewaited = 0;
        }
      }
    }

    if(!istrue(linespoken) && timewaited > 7) {
      linespoken = function_d6c06e62befcf33f("RandomIdle", 1);

      if(istrue(linespoken)) {
        timewaited = 0;
      }
    }

    wait interval;
    timewaited += interval;
  }
}

function function_d89d7e1fa23f3cee() {
  level.bbshop.var_35b62437221af0e5 setscriptablepartstate("speaker", "off");
  waitframe();
}

function function_f3756f0695358fe3() {
  level endon("game_ended");
  level.bbshop.var_35b62437221af0e5 notify("speaking_priority_reset");
  level.bbshop.var_35b62437221af0e5 endon("speaking_priority_reset");
  wait 8;
  level.bbshop.speakingpriority = 0;
}

function function_dd677378528c056f(player) {
  if(!isDefined(player)) {
    return;
  }

  if(array_contains(level.bbshop.var_3fa3e4e3abb61e4d, player) && array_contains(level.bbshop.playerslost, player)) {
    level.bbshop.playerslost = array_remove(level.bbshop.playerslost, player);
    return function_d6c06e62befcf33f("PlayersApproachAgain", 2);
  }

  if(!array_contains(level.bbshop.var_3fa3e4e3abb61e4d, player)) {
    level.bbshop.var_3fa3e4e3abb61e4d[level.bbshop.var_3fa3e4e3abb61e4d.size] = player;
    return function_d6c06e62befcf33f("ApproachFirstTime", 2);
  }
}

function function_dea6a60b8e33598f(origin) {
  players = scripts\mp\utility\player::getplayersinradius(level.bbshop.speakerorigin, 512);
  heighttolerance = 256;
  filteredplayers = [];

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }

    if(abs(player.origin[2] - level.bbshop.speakerorigin[0] < heighttolerance)) {
      filteredplayers[filteredplayers.size] = player;
    }
  }

  players = sortbydistance(filteredplayers, level.bbshop.speakerorigin);
  playerscansee = [];

  foreach(player in players) {
    canseeplayer = sighttracepassed(level.bbshop.speakereyeorigin, player getEye(), 0, undefined);

    if(canseeplayer) {
      playerscansee[playerscansee.size] = player;
      continue;
    }

    if(array_contains(level.bbshop.playerscansee, player)) {
      level.bbshop.playerslost[level.bbshop.playerslost.size] = player;
    }
  }

  level.bbshop.playerscansee = playerscansee;
  return playerscansee[0];
}

function function_a8501c6fe24440eb() {
  if(isDefined(level.radiation) && istrue(level.radiation.spreading)) {
    if(distance2d(level.bbshop.speakerorigin, level.radiation.origin) - level.radiation.radius < 1500) {
      return false;
    }
  }

  var_e3fda941919216d6 = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(level.bbshop.speakerorigin, 768);

  foreach(ent in var_e3fda941919216d6) {
    if(!isDefined(ent)) {
      continue;
    }

    if(isalive(ent)) {
      if(isPlayer(ent)) {
        if(ent scripts\mp\utility\player::isincombat() || istrue(ent.inlaststand)) {
          return true;
        }

        continue;
      }

      if(isagent(ent)) {
        if(!istrue(ent.stealth_enabled)) {
          if(isDefined(ent.enemy)) {
            return true;
          }

          continue;
        }

        if(ent[[ent.fnisinstealthcombat]]()) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_9dfc2bb48a54cd50() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  waitframe();

  foreach(buystation in level.br_armory_kiosk.scriptables) {
    if(isDefined(buystation.var_5ea299587b551f9f) && buystation.var_5ea299587b551f9f == "dmz_biobunker") {
      level.bbshop.buystation = buystation;
    }
  }

  level thread function_d49ef0c9db01ce16();
}

function function_d49ef0c9db01ce16() {
  level endon("game_ended");

  while(true) {
    state = level.bbshop.buystation getscriptablepartstate("br_plunder_box");

    if(state == "opening" || state == "open") {
      break;
    }

    waitframe();
  }

  function_d6c06e62befcf33f("PlayerOpenFreeBuyStation", 3);
  var_ad62e88241ed114d = level.bbshop.buystation.playersusing.size;

  while(true) {
    if(level.bbshop.buystation.playersusing.size > var_ad62e88241ed114d) {
      function_d6c06e62befcf33f("PlayerOpenFreeBuyStation", 2);
    }

    var_ad62e88241ed114d = level.bbshop.buystation.playersusing.size;
    wait 1;
  }
}

function function_68613df3dd9c24a1() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  waitframe();

  foreach(buystation in level.br_armory_kiosk.scriptables) {
    if(isDefined(buystation.var_5ea299587b551f9f) && buystation.var_5ea299587b551f9f == "dmz_biobunker_high_tier") {
      level.bbshop.rewardstation = buystation;

      if(isDefined(level.bbshop.rewardstation.centerbottom)) {
        level.bbshop.rewardstation.centerbottom += (0, 0, -2.5);
      }

      buystation.var_8b199355950fb72 = 1;
      namespace_25c7d0f5cb1e4346::function_45eefc63956143ed(buystation, "barter_recipe_list_iw9_biobunker_shopkeeper");
    }
  }

  scripts\mp\gametypes\br_armory_kiosk::kiosk_lock(level.bbshop.rewardstation);
  level thread function_36186f6bc0210d19();
}

function function_36186f6bc0210d19() {
  level endon("game_ended");
  var_e78f7f72026b2759 = 0;

  while(true) {
    state = level.bbshop.rewardstation getscriptablepartstate("br_plunder_box");

    if(state == "opening" || state == "open") {
      break;
    }

    if(isDefined(level.bbshop.rewardstation.var_8d6dbcf5443a11f0) && level.bbshop.rewardstation.var_8d6dbcf5443a11f0 > var_e78f7f72026b2759) {
      function_d6c06e62befcf33f("UseLockedRewardStation", 3);
      var_e78f7f72026b2759 = level.bbshop.rewardstation.var_8d6dbcf5443a11f0;
    }

    waitframe();
  }

  function_d6c06e62befcf33f("UseUnlockedRewardStation", 4);
  var_ad62e88241ed114d = level.bbshop.rewardstation.playersusing.size;

  while(true) {
    if(level.bbshop.rewardstation.playersusing.size > var_ad62e88241ed114d) {
      function_d6c06e62befcf33f("UseUnlockedRewardStation", 2);
    }

    var_ad62e88241ed114d = level.bbshop.rewardstation.playersusing.size;
    wait 1;
  }
}

function function_2693581ed81d3cdb() {
  scripts\mp\gametypes\br_armory_kiosk::kiosk_unlock(level.bbshop.rewardstation);
}

function function_5b927062b844e007() {
  puzzleoptions = [];

  if(getdvarint(@ "hash_dd86e03ec61b9dd6", 0)) {
    puzzleoptions["test"] = ["equip_frag", "equip_smoke"];
  } else {
    puzzleoptions["bb_shopkeeper_list_01"] = ["brloot_valuable_bunker_notes_common", "brloot_valuable_bunker_server_tape_uncommon", "brloot_valuable_bunker_board_common"];
    puzzleoptions["bb_shopkeeper_list_02"] = ["brloot_valuable_bunker_notes_uncommon", "brloot_valuable_bunker_server_tape_common", "brloot_valuable_bunker_chlorine"];
    puzzleoptions["bb_shopkeeper_list_03"] = ["brloot_valuable_bunker_formaldehyde", "brloot_valuable_bunker_acetic_acid", "brloot_valuable_bunker_server_tape_uncommon"];
    puzzleoptions["bb_shopkeeper_list_04"] = ["brloot_valuable_bunker_notes_rare", "brloot_valuable_bunker_server_tape_rare"];
    puzzleoptions["bb_shopkeeper_list_05"] = ["brloot_valuable_bunker_sulfuric_acid", "brloot_valuable_bunker_notes_uncommon"];
    puzzleoptions["bb_shopkeeper_list_06"] = ["brloot_valuable_bunker_notes_epic", "brloot_valuable_bunker_board_uncommon"];
    puzzleoptions["bb_shopkeeper_list_07"] = ["brloot_valuable_bunker_board_epic", "brloot_valuable_bunker_notes_rare"];
  }

  var_a1165e9078bc3654 = getarraykeys(puzzleoptions);
  var_e22d4969cb9f2bfe = random(var_a1165e9078bc3654);
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  scripts\mp\stationary_notes::function_466d1fc9a557d7c9("bb_shoppingListLoc", var_e22d4969cb9f2bfe);
  waitframe();

  foreach(deaddrop in level.deaddrops) {
    if(isDefined(deaddrop.type) && deaddrop.type == "dmz_dead_drop_transaction_drawer") {
      level.bbshop.deaddrop = deaddrop;
    }
  }

  level.bbshop.deaddrop.requiredloot = puzzleoptions[var_e22d4969cb9f2bfe];

  if(isDefined(level.bbshop.var_e57f4a6f7e313e90)) {
    function_53cb4b428d14444e();
  }

  function_471c5970300e0cb0(["brloot_valuable_sealion_luckycat", "brloot_valuable_sealion_dogbank"], &scripts\mp\pmc_missions::function_38d565bd866ced0e);
  function_471c5970300e0cb0(["brloot_valuable_liquor"], &scripts\mp\pmc_missions::function_c543832fab9303cb);
  function_471c5970300e0cb0(["brloot_valuable_rare_dogbank"], &scripts\mp\pmc_missions::function_f3f7cf5aa591a391);
  level.bbshop.deaddrop.playersused = [];
  level.bbshop.deaddrop.var_465361013186aa4c = [];
  level.bbshop.deaddrop.var_2cc2b26893d5a8b6 = [];
  level.bbshop.deaddrop.var_50657bcf5bb1ed14 = &function_400a665f959f1c4;
  level.bbshop.deaddrop.var_7ff4adf1a6c36a48 = &function_c7ea55d0e15707e6;
}

function function_400a665f959f1c4(player) {
  if(!array_contains(level.bbshop.deaddrop.playersused, player)) {
    level.bbshop.deaddrop.playersused[level.bbshop.deaddrop.playersused.size] = player;
    function_d6c06e62befcf33f("PlayerUseBoxFirstTime", 4);
    return;
  }

  function_d6c06e62befcf33f("PlayersUseGeneral", 3);
}

function function_471c5970300e0cb0(itemlist, callback) {
  if(!isDefined(level.bbshop.deaddrop.var_2084ab8d06fc75f3)) {
    level.bbshop.deaddrop.var_2084ab8d06fc75f3 = [];
  }

  var_5de46adbb510f463 = level.bbshop.deaddrop.var_2084ab8d06fc75f3.size;
  level.bbshop.deaddrop.var_2084ab8d06fc75f3[var_5de46adbb510f463] = spawnStruct();
  level.bbshop.deaddrop.var_2084ab8d06fc75f3[var_5de46adbb510f463].list = itemlist;
  level.bbshop.deaddrop.var_2084ab8d06fc75f3[var_5de46adbb510f463].callback = callback;
  level.bbshop.deaddrop.var_2084ab8d06fc75f3[var_5de46adbb510f463].completedteams = [];
}

function function_cdd53bcf36c9dfe4(item) {
  foreach(itemset in level.bbshop.deaddrop.var_2084ab8d06fc75f3) {
    if(array_contains(itemset.list, item)) {
      return true;
    }
  }

  return false;
}

function function_d7dcff7d37237950(player, deaddrop) {
  foreach(itemset in level.bbshop.deaddrop.var_2084ab8d06fc75f3) {
    if(function_338f5de6d3ecb78b(player.team, itemset.list) && !array_contains(itemset.completedteams, player.team)) {
      [[itemset.callback]](player, deaddrop);
      itemset.completedteams[itemset.completedteams.size] = player.team;
    }
  }
}

function function_1f4431c20da8b(team, items) {
  var_1a6d3b0183f59962 = [];

  foreach(item in items) {
    var_1a6d3b0183f59962[item] = 0;
  }

  return var_1a6d3b0183f59962;
}

function function_2667078cd7d32e65(team, array) {
  foreach(var_57734db0da4fb01b in array[team]) {
    if(!var_57734db0da4fb01b) {
      return false;
    }
  }

  return true;
}

function function_338f5de6d3ecb78b(team, array) {
  if(!isDefined(level.bbshop.deaddrop.var_2cc2b26893d5a8b6) || !isDefined(level.bbshop.deaddrop.var_2cc2b26893d5a8b6[team])) {
    return false;
  }

  foreach(item in array) {
    if(!istrue(level.bbshop.deaddrop.var_2cc2b26893d5a8b6[team][item])) {
      return false;
    }
  }

  return true;
}

function function_c7ea55d0e15707e6(var_e1cf43f3ae9d77e7, player) {
  var_45161b0cc87eaced = 0;

  foreach(struct in var_e1cf43f3ae9d77e7) {
    if(struct.lootid != 0) {
      var_45161b0cc87eaced = 1;
      break;
    }
  }

  if(!var_45161b0cc87eaced) {
    return;
  }

  if(!level.bbshop.rewardstation.locked) {
    function_d6c06e62befcf33f("DepositGeneral", 2);
  }

  if(!isDefined(level.bbshop.deaddrop.var_465361013186aa4c[player.team])) {
    level.bbshop.deaddrop.var_465361013186aa4c[player.team] = function_1f4431c20da8b(player.team, level.bbshop.deaddrop.requiredloot);
  }

  if(!isDefined(level.bbshop.deaddrop.var_2cc2b26893d5a8b6[player.team])) {
    level.bbshop.deaddrop.var_2cc2b26893d5a8b6[player.team] = [];
  }

  var_b7a23086776412ad = 0;
  var_b3a9e27fff924c96 = 0;
  pmcchallengeid = scripts\mp\pmc_missions::function_16ae6d8b5f25f31b("trade_keycode");
  var_aadfb8482b27ea43 = scripts\mp\pmc_missions::function_c5e0bac8f123cc88(player.team, pmcchallengeid);

  foreach(item in var_e1cf43f3ae9d77e7) {
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(item.lootid);

    if(array_contains(level.bbshop.deaddrop.requiredloot, ref)) {
      if(!level.bbshop.deaddrop.var_465361013186aa4c[player.team][ref]) {
        level.bbshop.deaddrop.var_465361013186aa4c[player.team][ref] = 1;
        var_b7a23086776412ad = 1;
      } else {
        var_b3a9e27fff924c96 = 1;
      }
    }

    if(function_cdd53bcf36c9dfe4(ref)) {
      level.bbshop.deaddrop.var_2cc2b26893d5a8b6[player.team][ref] = 1;
    }
  }

  var_5ae592d099951346 = function_2667078cd7d32e65(player.team, level.bbshop.deaddrop.var_465361013186aa4c);
  function_d7dcff7d37237950(player, level.bbshop.deaddrop);

  if(var_5ae592d099951346 || var_b7a23086776412ad || var_b3a9e27fff924c96) {
    scripts\mp\pmc_missions::function_93ab9968bf96e2b0(player);
  }

  if(var_5ae592d099951346) {
    function_d6c06e62befcf33f("DepositRewardStationUnlockComplete", 4);
    function_2693581ed81d3cdb();
    return;
  }

  if(var_b7a23086776412ad) {
    function_d6c06e62befcf33f("DepositRewardStationUnlockPartial", 2);
    return;
  }

  if(var_b3a9e27fff924c96) {
    function_d6c06e62befcf33f("DepositRewardStationUnlockRepeat", 2);
    return;
  }

  function_d6c06e62befcf33f("DepositGeneral", 2);
}

function function_a5a6e50f5442f0fe(var_49dcce316989a19c) {
  if(!isDefined(var_49dcce316989a19c)) {
    return;
  }

  foreach(loc in level.bbshop.var_4e6e1a3a72bd88d2) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(loc.origin, loc.angles + (90, 0, 0));
    scripts\mp\gametypes\br_pickups::spawnpickup(var_49dcce316989a19c, dropinfo);
  }
}

function function_53cb4b428d14444e() {
  foreach(loc in level.bbshop.var_e57f4a6f7e313e90) {
    offset = (0, 0, 0);

    if(issubstr(loc.lootitemname, "note")) {
      offset = (90, 0, 0);
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(loc.origin, loc.angles + offset);
    scripts\mp\gametypes\br_pickups::spawnpickup(loc.lootitemname, dropinfo);
  }
}

function function_d6c06e62befcf33f(var_c7b61f413ad4ec68, priority, delaymin, delaymax) {
  return level.bbshop.var_35b62437221af0e5 function_2477cc89494291a1(level.bbshop.var_35b62437221af0e5, var_c7b61f413ad4ec68, priority, delaymin, delaymax);
}

function private function_2477cc89494291a1(speaker, var_c7b61f413ad4ec68, priority, delaymin, delaymax) {
  if(!isDefined(delaymin)) {
    delaymin = 0.05;
  }

  if(!isDefined(delaymax)) {
    delaymax = 0.07;
  }

  if(!isDefined(priority)) {
    priority = 1;
  }

  if(level.bbshop.speakingpriority > priority) {
    return;
  }

  if(isDefined(level.bbshop.var_7039e552e73d25a1) && level.bbshop.var_7039e552e73d25a1 == var_c7b61f413ad4ec68 && level.bbshop.var_48c882aea7e3896f + 8000 >= gettime()) {
    return;
  }

  wait randomfloatrange(delaymin, delaymax);
  function_d89d7e1fa23f3cee();

  if(false) {
    printtoscreen2d(250, 250, "<dev string:x1c>" + var_c7b61f413ad4ec68, (0, 0, 0), 2, 60);
  }

  level.bbshop.speakingpriority = priority;
  level.bbshop.var_48c882aea7e3896f = gettime();
  level.bbshop.var_7039e552e73d25a1 = var_c7b61f413ad4ec68;
  speaker setscriptablepartstate("speaker", var_c7b61f413ad4ec68);
  speaker thread function_f3756f0695358fe3();
  return 1;
}

function function_3136e267cbf2a63c(buystation, playersused) {
  foreach(player in buystation.playersusing) {
    if(!array_contains(playersused, player)) {
      return true;
    }
  }

  return false;
}

function function_a06bc7f3d6e3cb4b() {
  speaker = spawnscriptable("dmz_biobunker_shopkeeper_voice", (1716, 1566, 200), (0, 0, 0));

  while(true) {
    speaker setscriptablepartstate("speaker", "RandomIdle");
    wait 0.2;
    speaker setscriptablepartstate("speaker", "off");
    wait 0.2;
  }
}