/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1193c0b83fce13b.gsc
************************************************/

#using script_1174abedbefe9ada;
#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_99b5353ba6130ae4;

function function_80d68c9701e1aea5(data) {
  if(getdvarint(@ "hash_191305ad3d7422a8", 1) <= 0) {
    return;
  }

  function_d21c423660efca45();
  validnodes = [];
  phones = getentitylessscriptablearray("brloot_activity_starter_hacker_phone");

  foreach(phone in phones) {
    if(function_c8b12721d3a6c3fc(phone)) {
      origin = phone.origin;
      poiname = scripts\mp\poi::poi_findpoioriginisin(origin);
      subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(origin, poiname);
      struct = spawnStruct();
      struct.origin = origin;
      struct.poi = poiname;
      validnodes[validnodes.size] = struct;
    }
  }

  function_b713f2d39b34540f(data, &function_565acf1a582df350, validnodes);
}

function function_d21c423660efca45() {
  level.hackerphone = spawnStruct();
  level.hackerphone.var_be8a6484aed40352 = getdvarint(@ "hash_702ebf4ef0c6f88a", 3);
  level.hackerphone.var_576a3b6b02998159 = getdvarint(@ "hash_46511004c7948df", 60);
  level.hackerphone.var_c669e317f1fd1293 = getdvarint(@ "hash_c767586e70f5452f", 20);
  level.hackerphone.var_982966060d10f80a = getdvarint(@ "hash_330cbe811cd82406", 400);
  level.hackerphone.var_88f1bf50c2880f31 = getdvarint(@ "hash_3326ba811fa9de92", 0);
  level.hackerphone.var_d6b7c0cb8162cd8e = int(level.hackerphone.var_982966060d10f80a / level.hackerphone.var_c669e317f1fd1293);
  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_6bdc6f56944dc3aa);
}

function function_a07f7c4c0c4ef8e3() {
  return [];
}

function function_565acf1a582df350(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_7d55c65124970bdb;
  task.funcs["onTeamStart"] = &function_6efa8f1ae457e738;
  task.funcs["onPlayerJoined"] = &function_d151278d57e44ce9;
  task.funcs["onPlayerRemoved"] = &function_4e07eafa1b6b460c;
  task.funcs["onTeamAssigned"] = &function_1e8f1b7f3e56d2fc;
  task.funcs["onCancel"] = &function_43267367654390f3;
  task.ref = "dmz_hacker_phone";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  return task;
}

function function_7d55c65124970bdb() {
  scripts\mp\gametypes\dmz_task_utils::function_c847bfd52c064289(self.node.origin + (0, 0, 25));
}

function function_6efa8f1ae457e738(teamname) {}

function function_d151278d57e44ce9(player) {
  player.canhackcontracts = 1;
  player setclientomnvar("ui_br_hacker_phone_state", 2);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
  player namespace_1eb3c4e0e28fac71::uiobjectivesetparameter(self.var_9f274e85b7bbd87f, level.hackerphone.var_be8a6484aed40352);
  function_4f4334ae28f70353(player, player.team);
}

function function_4e07eafa1b6b460c(player) {
  player.canhackcontracts = undefined;
  player.var_6c8912ea30b21003 = undefined;
  player setclientomnvar("ui_br_hacker_phone_state", 0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);
  player setclientomnvar("ui_br_hacked_phones_data1", 0);
  player setclientomnvar("ui_br_hacked_phones_data2", 0);
}

function function_43267367654390f3(teamname) {
  function_d0f1c9a699a0a2d8(teamname);
  function_688a2acdd7d9d902();
}

function function_1e8f1b7f3e56d2fc(teamname) {
  level endon("game_ended");
  self endon("task_ended");
  self.var_9f274e85b7bbd87f = 0;
  self.var_cc4cd023f0195d5f = level.hackerphone.var_be8a6484aed40352;
  self.payoutvalue = function_2fbb9e83420ca54b(teamname);
  self.hackedinstances = [];

  if(!isDefined(level.teamdata[teamname]["hackerPhonePaymentCountActive"])) {
    level.teamdata[teamname]["hackerPhonePaymentCountActive"] = 0;
  }

  if(!isDefined(level.teamdata[teamname]["hackerPhonePaymentsRemaining"])) {
    level.teamdata[teamname]["hackerPhonePaymentsRemaining"] = 0;
  }

  if(!isDefined(level.teamdata[teamname]["hackedContractsData1"])) {
    level.teamdata[teamname]["hackedContractsData1"] = [];
  }

  if(!isDefined(level.teamdata[teamname]["hackedContractsData2"])) {
    level.teamdata[teamname]["hackedContractsData2"] = [];
  }

  function_851f0ba242e91378(teamname);
  function_70fbb5e0989f9e50(teamname);
  function_1759acfd39bb5edf("dmz_hacker_phone_accept", teamname);
  thread function_527ac84bfbbbad44(teamname);
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(!isDefined(player)) {
      continue;
    }

    player.canhackcontracts = 1;
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    function_64623e2ff7409f39(player, 1);
  }

  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hacker_phone_start", teamname, 2);
}

function private function_688a2acdd7d9d902(teamname) {
  if(isDefined(teamname)) {
    function_d0f1c9a699a0a2d8(teamname);
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hacker_phone_success", teamname, 1.5);
    function_c1fd3441ccfba6f8(teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hacker_phone_complete", playersonteam, undefined, level.hackerphone.var_d6b7c0cb8162cd8e);
    level.teamdata[teamname]["hackerPhonePaymentsRemaining"] = level.hackerphone.var_d6b7c0cb8162cd8e;
    function_8f0f565d34f52633(teamname);
    playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

    foreach(player in playersonteam) {
      if(!isDefined(player)) {
        continue;
      }

      player.var_6c8912ea30b21003 = 1;
    }

    if(!function_7586e893298068d4(teamname)) {
      wait 5.5;
    }

    thread function_fb296d840951ac58(teamname);
  }

  task_ended(teamname);
}

function function_c8b12721d3a6c3fc(node) {
  origin = node.origin;
  poiname = scripts\mp\poi::poi_findpoioriginisin(origin);
  subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(origin, poiname);
  return isDefined(subarea) && !namespace_7789f919216d38a2::function_cdcab1374db7f007(origin) && !namespace_9823ee6035594d67::function_f59f68adc71d49b3(origin) && !scripts\mp\locksandkeys::function_64332f29e2409e55(origin);
}

function function_7586e893298068d4(teamname) {
  return level.teamdata[teamname]["hackerPhonePaymentCountActive"] > 0;
}

function function_d0f1c9a699a0a2d8(teamname) {
  function_629ed367d1393020();
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(isDefined(player)) {
      player.canhackcontracts = undefined;
      player setclientomnvar("ui_br_hacker_phone_state", 0);
    }
  }

  foreach(taskinstance in self.hackedinstances) {
    function_3290c9088f8c4e53(taskinstance, teamname);
  }
}

function function_a232d3c610006843(var_431a56b37aba9942, useplayer) {
  self endon("death_or_disconnect");

  if(istrue(function_8bcccf23da031467(var_431a56b37aba9942.instance, useplayer.team))) {
    useplayer scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  useplayer scripts\mp\gametypes\dmz_task_utils::function_9be29ad72a155ee1("intel_pickup_phone_alt", 11);
  function_5198324ff80596d8(var_431a56b37aba9942, useplayer);
}

function function_5198324ff80596d8(var_431a56b37aba9942, useplayer) {
  if(istrue(function_8bcccf23da031467(var_431a56b37aba9942.instance, useplayer.team))) {
    useplayer scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  task = function_37416c14e9703fb6(useplayer);

  if(!isDefined(task)) {
    return;
  }

  task function_105b8f7ebe0ad130(var_431a56b37aba9942.instance, useplayer.team);
  task.hackedinstances[task.hackedinstances.size] = var_431a56b37aba9942.instance;
  task.var_9f274e85b7bbd87f++;
  task.var_cc4cd023f0195d5f = level.hackerphone.var_be8a6484aed40352 - task.var_9f274e85b7bbd87f;
  task function_70fbb5e0989f9e50(useplayer.team);
  scripts\mp\pmc_missions::function_8706a89fae666d51(useplayer);
  function_604a7fc1fb4b6dfd(var_431a56b37aba9942.instance, useplayer);

  if(task.var_9aa953016facacc == var_431a56b37aba9942.instance) {
    task notify("marked_contract_hacked");
    task function_851f0ba242e91378(useplayer.team, useplayer);
  }

  task.var_552c9e74f497621f = 0;
  playersonteam = scripts\mp\utility\teams::getteamdata(useplayer.team, "players");

  foreach(player in playersonteam) {
    player thread scripts\mp\utility\points::doscoreevent(#"hash_f085eaf302a7e140");
  }

  if(istrue(task function_171503a34d052b4e())) {
    task function_688a2acdd7d9d902(useplayer.team);
    return;
  }

  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hacker_phone_hacked", useplayer.team, 1);
}

function function_171503a34d052b4e() {
  if(self.var_9f274e85b7bbd87f >= level.hackerphone.var_be8a6484aed40352) {
    self notify("reached_hacked_limit");
    return true;
  }

  return false;
}

function function_527ac84bfbbbad44(teamname) {
  self endon("task_ended");
  level endon("game_ended");
  hackablecontracts = level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38;

  while(hackablecontracts.size >= self.var_cc4cd023f0195d5f) {
    hackablecontracts = level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38;
    hackablecontracts = array_remove_array(hackablecontracts, self.hackedinstances);
    wait 1;
  }

  function_43267367654390f3(teamname);
}

function function_105b8f7ebe0ad130(scriptableinstance, teamname) {
  if(!isDefined(scriptableinstance.var_5e3cc2521bd27a30)) {
    scriptableinstance.var_5e3cc2521bd27a30 = [];
  }

  scriptableinstance.var_5e3cc2521bd27a30[scriptableinstance.var_5e3cc2521bd27a30.size] = teamname;
  function_991e730674c3cdd8(teamname, scriptableinstance.index);
}

function function_8bcccf23da031467(scriptableinstance, teamname) {
  if(isDefined(scriptableinstance.var_5e3cc2521bd27a30)) {
    if(array_contains(scriptableinstance.var_5e3cc2521bd27a30, teamname)) {
      return true;
    }
  }

  return false;
}

function function_3290c9088f8c4e53(scriptableinstance, teamname) {
  if(isDefined(scriptableinstance.var_5e3cc2521bd27a30) && array_contains(scriptableinstance.var_5e3cc2521bd27a30, teamname)) {
    scriptableinstance.var_5e3cc2521bd27a30 = array_remove(scriptableinstance.var_5e3cc2521bd27a30, teamname);
    function_72db8368f7ffaafa(teamname, scriptableinstance.index);
  }
}

function function_70fbb5e0989f9e50(teamname) {
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    player namespace_1eb3c4e0e28fac71::uiobjectivesetparameter(self.var_9f274e85b7bbd87f, level.hackerphone.var_be8a6484aed40352);
  }
}

function function_54bb0e15262ac835() {
  if(!isDefined(self.team)) {
    return;
  }

  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_6cf4d7026c51235b = function_2fbb9e83420ca54b(self.team);
  multipliedcash = int(ceil(function_8c5476a01afab741(self, function_da38be107ae836ff(teammates, var_6cf4d7026c51235b))));
  var_94fdf3291d472947 = multipliedcash * level.hackerphone.var_d6b7c0cb8162cd8e;
  self setclientomnvar("ui_br_hacker_phone_potential_cash_value", var_94fdf3291d472947);
}

function function_2fbb9e83420ca54b(teamname) {
  var_6cf4d7026c51235b = level.hackerphone.var_576a3b6b02998159;

  if(istrue(level.hackerphone.var_88f1bf50c2880f31)) {
    var_926316044e93f849 = getDvar(@ "hash_a38ed422cbf98056", "60 45 30 15");
    var_21e6c4eb825d874d = strtok(var_926316044e93f849, " ");
    teamcount = int(min(scripts\mp\utility\teams::getteamcount(teamname), var_21e6c4eb825d874d.size));
    var_6cf4d7026c51235b = var_21e6c4eb825d874d[teamcount - 1];
  }

  return int(var_6cf4d7026c51235b);
}

function function_cfb5d79cfe8c03a9(teamname) {
  return level.teamdata[teamname]["hackerPhonePaymentCountActive"] * self.payoutvalue;
}

function function_fb296d840951ac58(teamname) {
  level endon("game_ended");
  lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_payment_hacker_phone"];
  level.teamdata[teamname]["hackerPhonePaymentCountActive"]++;
  level.teamdata[teamname]["hackerPhonePaymentsRemaining"] = level.hackerphone.var_d6b7c0cb8162cd8e;
  function_53fcf5791ca038a0(teamname, lootid);
  thread function_725c819da2f98664(teamname, lootid);
  thread function_624d73a636eeffed(teamname);
}

function function_725c819da2f98664(teamname, lootid) {
  level notify("monitor_payout_" + teamname);
  level endon("monitor_payout_" + teamname);
  level endon("game_ended");
  thread function_e387a70c3e4e731d(teamname);

  while(level.teamdata[teamname]["hackerPhonePaymentsRemaining"] > 0) {
    wait level.hackerphone.var_c669e317f1fd1293;
    function_53fcf5791ca038a0(teamname, lootid);
  }
}

function function_624d73a636eeffed(teamname) {
  level endon("game_ended");
  wait 0.5;

  for(paymentsremaining = level.teamdata[teamname]["hackerPhonePaymentsRemaining"]; paymentsremaining > 0; paymentsremaining--) {
    wait level.hackerphone.var_c669e317f1fd1293;
  }

  level.teamdata[teamname]["hackerPhonePaymentCountActive"]--;
}

function function_53fcf5791ca038a0(teamname, lootid) {
  if(level.teamdata[teamname]["hackerPhonePaymentsRemaining"] > 0) {
    level.teamdata[teamname]["hackerPhonePaymentsRemaining"]--;
  }

  var_ec2736524e4a7410 = scripts\mp\utility\teams::getteamdata(teamname, "alivePlayers");

  if(!var_ec2736524e4a7410.size) {
    return;
  }

  payoutvalue = function_cfb5d79cfe8c03a9(teamname);
  var_1dd0f3dfb99017d1 = function_da38be107ae836ff(var_ec2736524e4a7410, payoutvalue);

  foreach(player in var_ec2736524e4a7410) {
    if(isDefined(player) && var_1dd0f3dfb99017d1 > 0 && istrue(player.var_6c8912ea30b21003)) {
      multipliedcash = int(ceil(function_8c5476a01afab741(player, var_1dd0f3dfb99017d1)));
      player scripts\mp\gametypes\br_plunder::playerplunderpickup(multipliedcash);

      if(isDefined(lootid)) {
        view_origin = player getvieworigin();
        player setclientomnvar("ui_br_hacker_phone_remaining_payments", level.teamdata[teamname]["hackerPhonePaymentsRemaining"]);
        player scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, multipliedcash);
      }

      if(isDefined(player.var_a4dd02e65175e1e7)) {
        player.var_a4dd02e65175e1e7["totalPayout"] = player.var_a4dd02e65175e1e7["totalPayout"] + multipliedcash * 10;
      }

      scripts\cp_mp\challenges::function_8359cadd253f9604(player, "passive_income_payment", 1);
    }
  }
}

function function_e387a70c3e4e731d(teamname) {
  level endon("monitor_payout_" + teamname);
  level endon("game_ended");
  var_9c231835be3c8312 = scripts\mp\utility\teams::getteamdata(teamname, "players");

  for(paymentsremaining = level.teamdata[teamname]["hackerPhonePaymentsRemaining"]; paymentsremaining > 0; paymentsremaining--) {
    if(paymentsremaining == 3) {
      foreach(player in var_9c231835be3c8312) {
        if(isDefined(player) && player.team == teamname) {
          scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hacker_phone_expiring", [player]);
        }
      }
    }

    wait level.hackerphone.var_c669e317f1fd1293;
  }

  foreach(player in var_9c231835be3c8312) {
    if(isDefined(player) && player.team == teamname) {
      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hacker_phone_expired", [player]);
    }
  }

  wait 0.5;

  foreach(player in var_9c231835be3c8312) {
    if(isDefined(player)) {
      player.var_6c8912ea30b21003 = undefined;
    }
  }

  function_ec032bed730022d1(teamname, 0);
}

function function_604a7fc1fb4b6dfd(closestphone, player) {
  if(function_8bcccf23da031467(closestphone, player.team)) {
    player setclientomnvar("ui_br_hacker_phone_state", 1);
    return;
  }

  if(istrue(player.canhackcontracts)) {
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    return;
  }

  player setclientomnvar("ui_br_hacker_phone_state", 0);

  if(closestphone.activity.type == "hacker_phone") {
    player function_54bb0e15262ac835();
  }
}

function function_991e730674c3cdd8(teamname, instanceindex) {
  var_c568c261258fb4e0 = level.teamdata[teamname]["hackedContractsData1"].size + level.teamdata[teamname]["hackedContractsData2"].size;
  assertex(var_c568c261258fb4e0 <= level.hackerphone.var_be8a6484aed40352, "<dev string:x1c>");

  if(level.teamdata[teamname]["hackedContractsData1"].size < 2) {
    level.teamdata[teamname]["hackedContractsData1"] = array_add(level.teamdata[teamname]["hackedContractsData1"], instanceindex);
    function_1ed7c25eba401809(teamname, level.teamdata[teamname]["hackedContractsData1"], "ui_br_hacked_phones_data1");
    return;
  }

  level.teamdata[teamname]["hackedContractsData2"] = array_add(level.teamdata[teamname]["hackedContractsData2"], instanceindex);
  function_1ed7c25eba401809(teamname, level.teamdata[teamname]["hackedContractsData2"], "ui_br_hacked_phones_data2");
}

function function_72db8368f7ffaafa(teamname, instanceindex) {
  if(array_contains(level.teamdata[teamname]["hackedContractsData1"], instanceindex)) {
    level.teamdata[teamname]["hackedContractsData1"] = array_remove(level.teamdata[teamname]["hackedContractsData1"], instanceindex);
    function_1ed7c25eba401809(teamname, level.teamdata[teamname]["hackedContractsData1"], "ui_br_hacked_phones_data1");
    return;
  }

  if(array_contains(level.teamdata[teamname]["hackedContractsData2"], instanceindex)) {
    level.teamdata[teamname]["hackedContractsData2"] = array_remove(level.teamdata[teamname]["hackedContractsData2"], instanceindex);
    function_1ed7c25eba401809(teamname, level.teamdata[teamname]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

function function_4f4334ae28f70353(player, teamname) {
  if(isDefined(level.teamdata[teamname]["hackedContractsData1"])) {
    packedvalue = function_2f03a84e3419528(level.teamdata[teamname]["hackedContractsData1"]);
    player setclientomnvar("ui_br_hacked_phones_data1", packedvalue);
  }

  if(isDefined(level.teamdata[teamname]["hackedContractsData2"])) {
    packedvalue = function_2f03a84e3419528(level.teamdata[teamname]["hackedContractsData2"]);
    player setclientomnvar("ui_br_hacked_phones_data2", packedvalue);
  }
}

function function_1ed7c25eba401809(teamname, var_b4a6c7c6c1ec8a4d, var_939613b9f38207b0) {
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");
  packedvalue = function_2f03a84e3419528(var_b4a6c7c6c1ec8a4d);

  foreach(player in playersonteam) {
    player setclientomnvar(var_939613b9f38207b0, packedvalue);
  }
}

function function_2f03a84e3419528(var_b4a6c7c6c1ec8a4d) {
  packedvalue = 0;

  for(i = 0; i < var_b4a6c7c6c1ec8a4d.size; i++) {
    packedvalue += var_b4a6c7c6c1ec8a4d[i] << i * 16;
  }

  return packedvalue;
}

function function_5d4530ebfa3da544(player) {
  if(level.teamdata[player.team]["hackerPhonePaymentCountActive"] > 1) {
    return "br_pickup_cash_med_01";
  }

  return "br_pickup_cash_01";
}

function function_851f0ba242e91378(teamname, useplayer) {
  var_7ca287a82f54e4f6 = self.activity.var_7ca287a82f54e4f6;

  if(isDefined(useplayer)) {
    var_7ca287a82f54e4f6 = useplayer;
  }

  closestcontract = function_d81544c3289ce882(var_7ca287a82f54e4f6, teamname);
  thread function_f27b2d13f59d7978(closestcontract, teamname);
}

function function_d81544c3289ce882(var_7ca287a82f54e4f6, teamname) {
  sortfrompoint = self.node.origin;

  if(isDefined(var_7ca287a82f54e4f6)) {
    sortfrompoint = var_7ca287a82f54e4f6.origin;
  } else {
    playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

    foreach(player in playersonteam) {
      if(!isDefined(player)) {
        continue;
      }

      sortfrompoint = player.origin;
      break;
    }
  }

  var_facf33f7f7ae6bcd = [];

  foreach(closephone in level.var_1b7407dffe81e6e8.var_915f0d3c3a61e38) {
    if(!isDefined(closephone) || !isDefined(closephone.origin)) {
      continue;
    }

    var_facf33f7f7ae6bcd[var_facf33f7f7ae6bcd.size] = closephone;
  }

  var_facf33f7f7ae6bcd = sortbydistance(var_facf33f7f7ae6bcd, sortfrompoint);
  var_facf33f7f7ae6bcd = array_remove_array(var_facf33f7f7ae6bcd, self.hackedinstances);

  if(isDefined(var_facf33f7f7ae6bcd) && var_facf33f7f7ae6bcd.size > 0) {
    foreach(phone in var_facf33f7f7ae6bcd) {
      if(function_c8b12721d3a6c3fc(phone)) {
        function_91780adf8743a1d5(phone);
        return phone;
      }
    }
  }
}

function function_f27b2d13f59d7978(var_4a84dd415b837de9, teamname) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("marked_contract_hacked");

  if(!isDefined(var_4a84dd415b837de9)) {
    return;
  }

  haspart = var_4a84dd415b837de9 getscriptablehaspart("brloot_activity_starter");

  if(!haspart) {
    return;
  }

  self.var_552c9e74f497621f = 0;

  while(!istrue(function_171503a34d052b4e())) {
    if(var_4a84dd415b837de9 getscriptablepartstate("brloot_activity_starter") == "hidden" || self.var_552c9e74f497621f >= 90) {
      thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hacker_phone_nag", teamname, 0);
      self.var_552c9e74f497621f = 0;
      var_4a84dd415b837de9 = function_d81544c3289ce882(self.activity.var_7ca287a82f54e4f6, teamname);
    }

    self.var_552c9e74f497621f++;
    wait 1;
  }
}

function function_91780adf8743a1d5(scriptableinstance) {
  if(isDefined(self.var_9aa953016facacc) && self.var_9aa953016facacc == scriptableinstance) {
    return;
  }

  function_cef2ed613a8338be(scriptableinstance.origin + (0, 0, 25));
  self.var_9aa953016facacc = scriptableinstance;
}

function function_8f0f565d34f52633(teamname) {
  self.dlogdata = [];
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(isDefined(player)) {
      function_6ec01dd217d2ff03(player, 0, 0, 1);
      player.var_a4dd02e65175e1e7 = [];
      player.var_a4dd02e65175e1e7["tabletIndex"] = self.tablet.index;
      player.var_a4dd02e65175e1e7["totalPayout"] = 0;
      player.var_a4dd02e65175e1e7["payoutValue"] = self.payoutvalue * 10;
      scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&function_3205795847561be3);
    }
  }

  thread function_89fbd9bb7207a48d(teamname);
}

function function_ec032bed730022d1(teamname, var_d1c192f65678cca7) {
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    function_6ec01dd217d2ff03(player, var_d1c192f65678cca7, 0, 0);
  }

  self notify("hackerPhoneDlogSent");
}

function function_3205795847561be3(player) {
  function_6ec01dd217d2ff03(player, 0, 1, 0);
}

function function_89fbd9bb7207a48d(teamname) {
  level endon("hackerPhoneDlogSent");
  level waittill("game_ended");
  function_ec032bed730022d1(teamname, 1);
}

function function_6ec01dd217d2ff03(player, var_d1c192f65678cca7, var_f8b7fd6747ad8f77, payoutextended) {
  if(isDefined(player) &isarray(player.var_a4dd02e65175e1e7)) {
    player dlog_recordplayerevent("dlog_event_contract_hacker_phone_payment_phase_completion", ["tablet_index", player.var_a4dd02e65175e1e7["tabletIndex"], "total_payout_value", player.var_a4dd02e65175e1e7["totalPayout"], "cash_per_payout", player.var_a4dd02e65175e1e7["payoutValue"], "stopped_by_match_end", var_d1c192f65678cca7, "stopped_by_disconnect", var_f8b7fd6747ad8f77, "payout_extended", payoutextended]);
    player.var_a4dd02e65175e1e7 = undefined;
  }
}

function function_6bdc6f56944dc3aa(playerassimilated, oldteam, newteam) {
  if(istrue(playerassimilated.var_6c8912ea30b21003)) {
    playerassimilated.var_6c8912ea30b21003 = undefined;
    thread function_7113e9264646a968(playerassimilated);
  }
}

function function_7113e9264646a968(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  wait 1;
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_hacker_phone_expired", [player]);
}