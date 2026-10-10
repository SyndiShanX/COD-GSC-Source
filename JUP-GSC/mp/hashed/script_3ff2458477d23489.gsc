/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ff2458477d23489.gsc
*************************************************/

#using script_64acb6ce534155b7;
#using script_728ffcee8cbf30ee;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\rank;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_46a48466a348d5e2;

function autoexec main() {
  utility::registersharedfunc("hacker_phone", "get_contract_data", &getcontractdata);
}

function getcontractdata(data) {
  function_2fac9b58d42b2920();
  data.funcs["onInit"] = &function_8c64a4f648288a95;
  data.funcs["onTeamAssigned"] = &function_921a0be9ec330c6a;
  data.funcs["onEnterGulag"] = &function_ca07a6ca5c3c8af5;
  data.funcs["onPlayerRespawn"] = &function_f6755bd234f8e261;
  data.funcs["onPlayerKilled"] = &quest_onplayerkilled;
  data.funcs["onMarkPlayerAsEliminated"] = &function_4f702ea532a7ca6e;
  data.funcs["onPlayerDisconnect"] = &quest_onplayerdisconnect;
  data.funcs["onCancel"] = &quest_oncancel;
  data.funcs["onPlayerTearDown"] = &function_83d3732a571f142a;
  data.funcs["onPlayerAssimilated"] = &function_75b53ad947495f9c;
  data.basetime = level.hackerphone.questmaxtime;
  level.contractmanager.var_3c3c5b819ea01809 = function_6d6af8144a5131f1(level.contractmanager.var_3c3c5b819ea01809, &function_efad6fda2cf7cbf3);
  level.contractmanager.var_5041655a5e1a439e = function_6d6af8144a5131f1(level.contractmanager.var_5041655a5e1a439e, &function_e0d5218265251e5d);
  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_3d221e16860007d5);
}

function function_2fac9b58d42b2920() {
  function_adc3c411e839c811();
  function_89538dc128a24e58();
}

function function_adc3c411e839c811() {
  level.hackerphone = spawnStruct();
  level.hackerphone.enabled = getdvarint(@ "hash_2665e66573a7705c", 1);
  level.hackerphone.questmaxtime = getdvarint(@ "hash_c7d4297bb4f79596", function_ea591c2a379e3424("hacker_phone"));
  level.hackerphone.var_be8a6484aed40352 = getdvarint(@ "hash_9eef987db450c17a", 2);
  level.hackerphone.var_576a3b6b02998159 = getdvarint(@ "hash_c4e08d2fdaab55f3", 75);
  level.hackerphone.var_c669e317f1fd1293 = getdvarint(@ "hash_23fab88c275bec9f", 20);
  level.hackerphone.var_982966060d10f80a = getdvarint(@ "hash_3cf195484e92a076", 200);
  level.hackerphone.var_88f1bf50c2880f31 = getdvarint(@ "hash_630e4b6f3cc13d1e", 0);
  level.hackerphone.var_d6b7c0cb8162cd8e = int(level.hackerphone.var_982966060d10f80a / level.hackerphone.var_c669e317f1fd1293);
  level.hackerphone.var_30f17800e8ec227d = getdvarint(@ "hash_7152a29b5f75e34d", 1);
}

function function_89538dc128a24e58() {
  game["dialog"]["hacker_phone_start"] = "hack_grav_msns_01";
  game["dialog"]["hacker_phone_nag"] = "hack_grav_nag1";
  game["dialog"]["hacker_phone_missing"] = "hack_wzan_mrkl";
  game["dialog"]["hacker_phone_timer_expired"] = "hack_grav_tmxp_01";
  game["dialog"]["hacker_phone_contract_hacked"] = "hack_wzan_cnhc";
  game["dialog"]["hacker_phone_complete"] = "hack_grav_scmh";
}

function function_8c64a4f648288a95() {
  thread function_1f14537e86653ca8();
  return level.hackerphone.enabled;
}

function function_921a0be9ec330c6a() {
  self.category = "hacker_phone";
  teamname = self.teams[0];
  self.var_9f274e85b7bbd87f = 0;
  self.var_cc4cd023f0195d5f = level.hackerphone.var_be8a6484aed40352;
  self.payoutvalue = function_7fa77e2dbbd62db5(teamname);
  self.hackedinstances = [];

  if(!function_5418fefa50b762a6()) {
    function_cd0f560fad2e9cb6("br_hacker_phone_quest_failure", undefined, undefined, "Circle", 1);
    return;
  }

  function_8280acd4058f343b(teamname);
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(!isDefined(player)) {
      continue;
    }

    player.canhackcontracts = 1;
    player setclientomnvar("ui_br_hacker_phone_state", 2);
  }

  splashref = function_4bcd7c36b22b9bec("br_hacker_phone_quest_start_team");
  displayteamsplash(teamname, splashref);
  displaysquadmessagetoteam(teamname, self.var_d154ac2657c5f44, 6, getquestindex("hacker_phone"));
  uiobjectiveshowtoteam("hacker_phone", teamname);
  function_e2aa45e2c6b5dec1(self.var_9f274e85b7bbd87f, level.hackerphone.var_be8a6484aed40352);
  time = function_9b6275085fbcb8f4(level.hackerphone.questmaxtime);
  function_5a15174d34f0670c(time);
  thread function_6410262eccc0ab66(time);
  createquestobjicon("ui_map_icon_obj_hacker", "current", (0, 0, 0));
  objective_removeallfrommask(self.objectiveiconid);
  thread function_425f0abdafad5a76(self.objectiveiconid, teamname);
  function_7155a66b3081eaca(teamname);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("hacker_phone_start", teamname, 1, 1, undefined);
}

function function_8280acd4058f343b(teamname) {
  if(!isDefined(level.teamdata[teamname]["hackerPhonePaymentCountActive"])) {
    level.teamdata[teamname]["hackerPhonePaymentCountActive"] = 0;
  }

  if(!isDefined(level.teamdata[teamname]["hackerPhoneIncreasedPaymentCountActive"])) {
    level.teamdata[teamname]["hackerPhoneIncreasedPaymentCountActive"] = 0;
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
}

function function_7fa77e2dbbd62db5(teamname) {
  var_6cf4d7026c51235b = level.hackerphone.var_576a3b6b02998159;

  if(istrue(level.hackerphone.var_88f1bf50c2880f31)) {
    var_926316044e93f849 = getDvar(@ "hash_779eac48f0f0fa66", "75 70 65 60");
    var_21e6c4eb825d874d = strtok(var_926316044e93f849, " ");
    teamcount = int(min(scripts\mp\utility\teams::getteamcount(teamname), var_21e6c4eb825d874d.size));
    var_6cf4d7026c51235b = var_21e6c4eb825d874d[teamcount - 1];
  }

  if(isDefined(self.tablet)) {
    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getContractPlunderBonus")) {
      bonus = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getContractPlunderBonus", self);

      if(isDefined(bonus) && bonus > 0) {
        bonus /= level.hackerphone.var_d6b7c0cb8162cd8e;
        var_6cf4d7026c51235b += bonus;
      }
    }
  }

  return int(var_6cf4d7026c51235b);
}

function function_7155a66b3081eaca(teamname, useplayer) {
  var_7ca287a82f54e4f6 = self.var_7ca287a82f54e4f6;

  if(isDefined(useplayer)) {
    var_7ca287a82f54e4f6 = useplayer;
  }

  closestcontract = function_6fc3c13ca7d3708(var_7ca287a82f54e4f6, teamname);
  thread function_d9ba30c978790906(closestcontract, teamname);
}

function function_6fc3c13ca7d3708(var_7ca287a82f54e4f6, teamname) {
  sortfrompoint = self.tablet.origin;

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

  foreach(closephone in level.contractmanager.activetablets) {
    if(!isDefined(closephone) || !isDefined(closephone.origin)) {
      continue;
    }

    if(isDefined(closephone.task) && isDefined(closephone.task.type) && isDefined(closephone.task.type.ref) && namespace_6c622b52017c6808::function_42b1b43a7af97c1b(closephone.task.type.ref)) {
      continue;
    }

    var_facf33f7f7ae6bcd[var_facf33f7f7ae6bcd.size] = closephone;
  }

  var_facf33f7f7ae6bcd = sortbydistance(var_facf33f7f7ae6bcd, sortfrompoint);
  var_facf33f7f7ae6bcd = array_remove_array(var_facf33f7f7ae6bcd, self.hackedinstances);

  if(isDefined(var_facf33f7f7ae6bcd) && var_facf33f7f7ae6bcd.size > 0) {
    closestphone = var_facf33f7f7ae6bcd[0];
    function_68c7ee907c012fad(closestphone);
    return closestphone;
  }
}

function function_d9ba30c978790906(var_4a84dd415b837de9, teamname) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("marked_contract_hacked");

  if(!isDefined(var_4a84dd415b837de9)) {
    return;
  }

  self.var_552c9e74f497621f = 0;

  while(!istrue(function_1c6066d91ae79a56())) {
    var_62787ab10cd11954 = 0;

    if(self.var_552c9e74f497621f >= 70) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("hacker_phone_nag", teamname, 1, 0, undefined);
      var_62787ab10cd11954 = 1;
      self.var_552c9e74f497621f = 0;
    }

    if(!isDefined(var_4a84dd415b837de9) || !array_contains(level.contractmanager.activetablets, var_4a84dd415b837de9)) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("hacker_phone_missing", teamname, 1, 0, undefined);
      var_62787ab10cd11954 = 1;
    }

    if(istrue(var_62787ab10cd11954)) {
      var_4a84dd415b837de9 = function_6fc3c13ca7d3708(self.var_7ca287a82f54e4f6, teamname);
    }

    self.var_552c9e74f497621f++;
    wait 1;
  }
}

function function_68c7ee907c012fad(scriptableinstance) {
  if(isDefined(self.var_9aa953016facacc) && self.var_9aa953016facacc == scriptableinstance) {
    return;
  }

  movequestobjicon(scriptableinstance.origin + (0, 0, 25));
  self.var_9aa953016facacc = scriptableinstance;
}

function function_5d0b1fa9645f3c89(pickupent, useplayer) {
  useplayer endon("death_or_disconnect");
  task = namespace_1eb3c4e0e28fac71::function_22239d4cff05d0a1(useplayer.team);

  if(istrue(function_2fdcb6899db87a0f(pickupent.instance, useplayer.team))) {
    useplayer scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  if(istrue(level.hackerphone.var_30f17800e8ec227d)) {
    useplayer scripts\mp\gametypes\dmz_task_utils::function_9be29ad72a155ee1("intel_pickup_phone_alt", 11);
  }

  task function_302cb8661b3c7afa(pickupent, useplayer);
}

function function_2fdcb6899db87a0f(scriptableinstance, teamname) {
  if(isDefined(scriptableinstance.var_5e3cc2521bd27a30)) {
    if(array_contains(scriptableinstance.var_5e3cc2521bd27a30, teamname)) {
      return true;
    }
  }

  return false;
}

function function_247bb9f9abb4c268(scriptableinstance, teamname) {
  if(!isDefined(scriptableinstance.var_5e3cc2521bd27a30)) {
    scriptableinstance.var_5e3cc2521bd27a30 = [];
  }

  scriptableinstance.var_5e3cc2521bd27a30[scriptableinstance.var_5e3cc2521bd27a30.size] = teamname;
  function_34bc4caefcde3120(teamname, scriptableinstance.index);
}

function function_b111c1d13e127b6d(scriptableinstance, teamname) {
  if(isDefined(scriptableinstance.var_5e3cc2521bd27a30) && array_contains(scriptableinstance.var_5e3cc2521bd27a30, teamname)) {
    scriptableinstance.var_5e3cc2521bd27a30 = array_remove(scriptableinstance.var_5e3cc2521bd27a30, teamname);
    function_5bbf368bf1a6b402(teamname, scriptableinstance.index);
  }
}

function function_302cb8661b3c7afa(pickupent, useplayer) {
  if(istrue(function_2fdcb6899db87a0f(pickupent.instance, useplayer.team))) {
    useplayer scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED");
    return;
  }

  task = namespace_1eb3c4e0e28fac71::function_22239d4cff05d0a1(useplayer.team);

  if(!isDefined(task)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  if(task != self) {
    return;
  }

  task function_247bb9f9abb4c268(pickupent.instance, useplayer.team);
  task.hackedinstances[task.hackedinstances.size] = pickupent.instance;
  task.var_9f274e85b7bbd87f++;
  task.var_cc4cd023f0195d5f = level.hackerphone.var_be8a6484aed40352 - task.var_9f274e85b7bbd87f;
  task function_e2aa45e2c6b5dec1(task.var_9f274e85b7bbd87f, level.hackerphone.var_be8a6484aed40352);
  function_4f6916c4e48cc55(pickupent.instance, useplayer);

  if(task.var_9aa953016facacc == pickupent.instance) {
    task notify("marked_contract_hacked");
    task function_7155a66b3081eaca(useplayer.team, useplayer);
  }

  task.var_552c9e74f497621f = 0;
  playersonteam = scripts\mp\utility\teams::getteamdata(useplayer.team, "players");

  foreach(player in playersonteam) {
    xp = scripts\mp\rank::getscoreinfoxp(#"hash_f085eaf302a7e140");
    xpmultiplier = istrue(task.islegendarycontract) ? 1 + level.var_6a82bbe1d7f1fde8.var_d4618ceb0666a783 : 1;
    player thread scripts\mp\utility\points::doscoreevent(#"hash_f085eaf302a7e140", undefined, undefined, xp * xpmultiplier);
  }

  if(istrue(task function_1c6066d91ae79a56())) {
    task function_aa30a0b07502a038(1, "Win");
    return;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("hacker_phone_contract_hacked", useplayer.team, 1, 0.5, undefined);
}

function function_6410262eccc0ab66(time) {
  self endon("task_ended");
  level endon("game_ended");
  thread function_fc63c9695ed174c();
  wait time;
  function_cd0f560fad2e9cb6("br_hacker_phone_quest_timer_expired", "hacker_phone_timer_expired", undefined, "Time");
}

function function_fc63c9695ed174c() {
  self endon("task_ended");
  level endon("game_ended");
  hackablecontracts = level.contractmanager.activetablets;

  while(hackablecontracts.size >= self.var_cc4cd023f0195d5f) {
    hackablecontracts = level.contractmanager.activetablets;
    hackablecontracts = array_remove_array(hackablecontracts, self.hackedinstances);
    wait 1;
  }

  function_cd0f560fad2e9cb6("br_hacker_phone_quest_failure", undefined, undefined, "Circle");
}

function function_ca07a6ca5c3c8af5(player) {
  if(function_42a0806457ea8039(player)) {
    hidequestobjiconfromplayer(player);
  }
}

function function_f6755bd234f8e261(player) {
  if(function_42a0806457ea8039(player)) {
    showquestobjicontoplayer(player);
  }
}

function quest_onplayerkilled(attacker, victim) {
  function_f59b4b0550d4e1e9(victim);
}

function function_4f702ea532a7ca6e(victim) {
  function_f59b4b0550d4e1e9(victim);
}

function quest_onplayerdisconnect(player) {
  function_f59b4b0550d4e1e9(player);
}

function function_f59b4b0550d4e1e9(player) {
  if(player.team == self.teams[0]) {
    filter = namespace_1eb3c4e0e28fac71::function_94a8dc26f5353759(player, level.contractmanager.defaultfilter);

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.teams[0], filter)) {
      function_cd0f560fad2e9cb6(undefined, undefined, undefined, "Killed");
    }
  }
}

function quest_oncancel(team) {
  if(istrue(self.teams[0] == team)) {
    function_cd0f560fad2e9cb6(undefined, undefined, undefined, "Cancel");
  }
}

function function_cd0f560fad2e9cb6(splashref, voiceref, delayoverride, endstate, skipwait) {
  if(isDefined(splashref)) {
    displayteamsplash(self.teams[0], splashref);
  }

  delay = 0;

  if(isDefined(delayoverride)) {
    delay = delayoverride;
  }

  if(isDefined(voiceref)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam(voiceref, self.teams[0], 1, delay, undefined);
  }

  thread function_aa30a0b07502a038(0, endstate, skipwait);
}

function function_1c6066d91ae79a56() {
  if(self.var_9f274e85b7bbd87f >= level.hackerphone.var_be8a6484aed40352) {
    return true;
  }

  return false;
}

function function_aa30a0b07502a038(success, endstate, skipwait) {
  level endon("game_ended");
  self notify("task_ended");
  contractor = self.contractoractive;

  if(!istrue(skipwait)) {
    wait 1;
  }

  teamname = self.teams[0];
  quest_cleanup(teamname);
  endcontract(ter_op(istrue(success), teamname, undefined), undefined, undefined, endstate);

  if(istrue(success)) {
    thread function_4fee9a98dfed4a76(teamname, contractor);
  }
}

function quest_cleanup(teamname) {
  if(checkforactiveobjicon()) {
    deletequestobjicon();
  }

  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(isDefined(player)) {
      player.canhackcontracts = undefined;
      player setclientomnvar("ui_br_hacker_phone_state", 0);
    }
  }

  foreach(taskinstance in self.hackedinstances) {
    function_b111c1d13e127b6d(taskinstance, teamname);
  }
}

function function_4fee9a98dfed4a76(teamname, contractor) {
  level endon("game_ended");
  params = spawnStruct();
  params.intvar = level.hackerphone.var_d6b7c0cb8162cd8e;
  splashref = function_4bcd7c36b22b9bec("br_hacker_phone_quest_complete");
  displayteamsplash(teamname, splashref, params);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("hacker_phone_complete", teamname, 1, 1.5, undefined);
  function_196e12780ecc8e3b(teamname);

  if(!function_aaa32ae55c133b06(teamname)) {
    wait 4;
  }

  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(!isDefined(player)) {
      continue;
    }

    player.var_6c8912ea30b21003 = 1;
  }

  if(istrue(contractor)) {
    thread function_82f010d48e62de(teamname);
    return;
  }

  thread function_305219f2cd4252ce(teamname);
}

function function_aaa32ae55c133b06(teamname) {
  return level.teamdata[teamname]["hackerPhonePaymentCountActive"] > 0;
}

function function_305219f2cd4252ce(teamname) {
  lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_payment_hacker_phone"];
  level.teamdata[teamname]["hackerPhonePaymentCountActive"]++;
  level.teamdata[teamname]["hackerPhonePaymentsRemaining"] = level.hackerphone.var_d6b7c0cb8162cd8e;
  function_bdcfa4ac81dc3472(teamname, lootid);
  thread function_40f8341d00ee8be6(teamname, lootid);
  thread function_d1fe6ac87f940bfb(teamname);
}

function function_cef3152e1a4bfc3f(teamname) {
  level endon("game_ended");
  wait 0.05;

  for(paymentsremaining = level.teamdata[teamname]["hackerPhonePaymentsRemaining"]; paymentsremaining > 0; paymentsremaining--) {
    wait level.hackerphone.var_c669e317f1fd1293;
  }

  level.teamdata[teamname]["hackerPhoneIncreasedPaymentCountActive"]--;
}

function function_82f010d48e62de(teamname) {
  lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_payment_hacker_phone"];
  level.teamdata[teamname]["hackerPhoneIncreasedPaymentCountActive"]++;
  level.teamdata[teamname]["hackerPhonePaymentsRemaining"] = level.hackerphone.var_d6b7c0cb8162cd8e;
  function_bdcfa4ac81dc3472(teamname, lootid);
  thread function_40f8341d00ee8be6(teamname, lootid);
  thread function_cef3152e1a4bfc3f(teamname);
}

function function_d1fe6ac87f940bfb(teamname) {
  level endon("game_ended");
  wait 0.05;

  for(paymentsremaining = level.teamdata[teamname]["hackerPhonePaymentsRemaining"]; paymentsremaining > 0; paymentsremaining--) {
    wait level.hackerphone.var_c669e317f1fd1293;
  }

  level.teamdata[teamname]["hackerPhonePaymentCountActive"]--;
}

function function_40f8341d00ee8be6(teamname, lootid) {
  level notify("monitor_payout_" + teamname);
  level endon("monitor_payout_" + teamname);
  level endon("game_ended");
  thread function_ac7aaafed966dcff(teamname);

  while(level.teamdata[teamname]["hackerPhonePaymentsRemaining"] > 0) {
    wait level.hackerphone.var_c669e317f1fd1293;
    function_bdcfa4ac81dc3472(teamname, lootid);
  }
}

function function_bdcfa4ac81dc3472(teamname, lootid) {
  if(level.teamdata[teamname]["hackerPhonePaymentsRemaining"] > 0) {
    level.teamdata[teamname]["hackerPhonePaymentsRemaining"]--;
  }

  payoutvalue = function_97ff781643ef7daf(teamname);
  var_ec2736524e4a7410 = scripts\mp\utility\teams::getteamdata(teamname, "alivePlayers");

  foreach(player in var_ec2736524e4a7410) {
    if(isDefined(player) && payoutvalue > 0 && istrue(player.var_6c8912ea30b21003) && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      player scripts\mp\gametypes\br_plunder::playerplunderpickup(payoutvalue);

      if(isDefined(lootid)) {
        view_origin = player getvieworigin();
        player setclientomnvar("ui_br_hacker_phone_remaining_payments", level.teamdata[teamname]["hackerPhonePaymentsRemaining"]);
        player scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, payoutvalue);
      }

      if(isDefined(player.var_a4dd02e65175e1e7)) {
        player.var_a4dd02e65175e1e7["totalPayout"] = player.var_a4dd02e65175e1e7["totalPayout"] + payoutvalue * 10;
      }
    }
  }
}

function function_ac7aaafed966dcff(teamname) {
  level endon("monitor_payout_" + teamname);
  level endon("game_ended");
  var_359f2cd3b12bb4cb = scripts\mp\utility\teams::getteamdata(teamname, "players");

  for(paymentsremaining = level.teamdata[teamname]["hackerPhonePaymentsRemaining"]; paymentsremaining > 0; paymentsremaining--) {
    if(paymentsremaining == 3) {
      foreach(player in var_359f2cd3b12bb4cb) {
        if(isDefined(player) && player.team == teamname) {
          displayplayersplash(player, "br_hacker_phone_quest_payment_expiring");
        }
      }
    }

    wait level.hackerphone.var_c669e317f1fd1293;
  }

  function_19f022d240a597b9(teamname, 0);

  foreach(player in var_359f2cd3b12bb4cb) {
    if(isDefined(player) && player.team == teamname) {
      displayplayersplash(player, "br_hacker_phone_quest_payment_expired");
    }
  }

  wait 0.05;

  foreach(player in var_359f2cd3b12bb4cb) {
    if(isDefined(player)) {
      player.var_6c8912ea30b21003 = undefined;
    }
  }
}

function function_97ff781643ef7daf(teamname) {
  var_3e73b041573b529d = level.teamdata[teamname]["hackerPhonePaymentCountActive"] * self.payoutvalue;
  var_37b2a87ef115f1de = 0;

  if(isDefined(level.br_pe_data[%"contractor"])) {
    var_37b2a87ef115f1de = level.teamdata[teamname]["hackerPhoneIncreasedPaymentCountActive"] * self.payoutvalue * level.br_pe_data[%"contractor"].var_46a451f9012bd1c;
  }

  return var_3e73b041573b529d + var_37b2a87ef115f1de;
}

function function_34bc4caefcde3120(teamname, instanceindex) {
  var_c568c261258fb4e0 = level.teamdata[teamname]["hackedContractsData1"].size + level.teamdata[teamname]["hackedContractsData2"].size;
  assertex(var_c568c261258fb4e0 <= level.hackerphone.var_be8a6484aed40352, "<dev string:x1c>");

  if(level.teamdata[teamname]["hackedContractsData1"].size < 2) {
    level.teamdata[teamname]["hackedContractsData1"] = array_add(level.teamdata[teamname]["hackedContractsData1"], instanceindex);
    function_fa76fc991ff22cdb(teamname, level.teamdata[teamname]["hackedContractsData1"], "ui_br_hacked_phones_data1");
    return;
  }

  level.teamdata[teamname]["hackedContractsData2"] = array_add(level.teamdata[teamname]["hackedContractsData2"], instanceindex);
  function_fa76fc991ff22cdb(teamname, level.teamdata[teamname]["hackedContractsData2"], "ui_br_hacked_phones_data2");
}

function function_5bbf368bf1a6b402(teamname, instanceindex) {
  if(array_contains(level.teamdata[teamname]["hackedContractsData1"], instanceindex)) {
    level.teamdata[teamname]["hackedContractsData1"] = array_remove(level.teamdata[teamname]["hackedContractsData1"], instanceindex);
    function_fa76fc991ff22cdb(teamname, level.teamdata[teamname]["hackedContractsData1"], "ui_br_hacked_phones_data1");
    return;
  }

  if(array_contains(level.teamdata[teamname]["hackedContractsData2"], instanceindex)) {
    level.teamdata[teamname]["hackedContractsData2"] = array_remove(level.teamdata[teamname]["hackedContractsData2"], instanceindex);
    function_fa76fc991ff22cdb(teamname, level.teamdata[teamname]["hackedContractsData2"], "ui_br_hacked_phones_data2");
  }
}

function function_a3fcfe7472f9c5db(player, teamname) {
  if(isDefined(level.teamdata[teamname]["hackedContractsData1"])) {
    packedvalue = function_4f0fae2ece09d000(level.teamdata[teamname]["hackedContractsData1"]);
    player setclientomnvar("ui_br_hacked_phones_data1", packedvalue);
  }

  if(isDefined(level.teamdata[teamname]["hackedContractsData2"])) {
    packedvalue = function_4f0fae2ece09d000(level.teamdata[teamname]["hackedContractsData2"]);
    player setclientomnvar("ui_br_hacked_phones_data2", packedvalue);
  }
}

function function_196e12780ecc8e3b(teamname) {
  self.dlogdata = [];
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    if(isDefined(player)) {
      function_8cf0f4e99dcf177b(player, 0, 0, 1);
      player.var_a4dd02e65175e1e7 = [];
      player.var_a4dd02e65175e1e7["tabletIndex"] = self.tablet.index;
      player.var_a4dd02e65175e1e7["totalPayout"] = 0;
      player.var_a4dd02e65175e1e7["payoutValue"] = self.payoutvalue * 10;
      scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&function_a3a8454199eae9cb);
    }
  }

  thread function_c5110ae0cad07145(teamname);
}

function function_19f022d240a597b9(teamname, var_d1c192f65678cca7) {
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");

  foreach(player in playersonteam) {
    function_8cf0f4e99dcf177b(player, var_d1c192f65678cca7, 0, 0);
  }

  self notify("hackerPhoneDlogSent");
}

function function_8cf0f4e99dcf177b(player, var_d1c192f65678cca7, var_f8b7fd6747ad8f77, payoutextended) {
  if(isDefined(player) &isarray(player.var_a4dd02e65175e1e7)) {
    player dlog_recordplayerevent("dlog_event_contract_hacker_phone_payment_phase_completion", ["tablet_index", player.var_a4dd02e65175e1e7["tabletIndex"], "total_payout_value", player.var_a4dd02e65175e1e7["totalPayout"], "cash_per_payout", player.var_a4dd02e65175e1e7["payoutValue"], "stopped_by_match_end", var_d1c192f65678cca7, "stopped_by_disconnect", var_f8b7fd6747ad8f77, "payout_extended", payoutextended]);
    player.var_a4dd02e65175e1e7 = undefined;
  }
}

function function_a3a8454199eae9cb(player) {
  function_8cf0f4e99dcf177b(player, 0, 1, 0);
}

function function_c5110ae0cad07145(teamname) {
  self endon("hackerPhoneDlogSent");
  level waittill("game_ended");
  function_19f022d240a597b9(teamname, 1);
}

function function_fa76fc991ff22cdb(teamname, var_b4a6c7c6c1ec8a4d, var_939613b9f38207b0) {
  playersonteam = scripts\mp\utility\teams::getteamdata(teamname, "players");
  packedvalue = function_4f0fae2ece09d000(var_b4a6c7c6c1ec8a4d);

  foreach(player in playersonteam) {
    player setclientomnvar(var_939613b9f38207b0, packedvalue);
  }
}

function function_4f0fae2ece09d000(var_b4a6c7c6c1ec8a4d) {
  packedvalue = 0;

  for(i = 0; i < var_b4a6c7c6c1ec8a4d.size; i++) {
    packedvalue += var_b4a6c7c6c1ec8a4d[i] << i * 16;
  }

  return packedvalue;
}

function function_4f6916c4e48cc55(closestphone, player) {
  if(function_2fdcb6899db87a0f(closestphone, player.team)) {
    player setclientomnvar("ui_br_hacker_phone_state", 1);
    return;
  }

  if(istrue(player.canhackcontracts)) {
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    return;
  }

  player setclientomnvar("ui_br_hacker_phone_state", 0);

  if(closestphone.tablettype.ref == "hacker_phone") {
    player function_7a1a95a9782f2d03();
  }
}

function function_1f14537e86653ca8() {
  level endon("game_ended");
  level waittill("prematch_fade_done");

  foreach(player in level.players) {
    if(isDefined(player)) {
      player function_7a1a95a9782f2d03();
    }
  }
}

function function_efad6fda2cf7cbf3() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(isDefined(player)) {
      player function_7a1a95a9782f2d03();
    }
  }
}

function function_e0d5218265251e5d() {
  level endon("game_ended");
  level waittill("public_event_contractor_end");

  foreach(player in level.players) {
    if(isDefined(player)) {
      player function_7a1a95a9782f2d03();
    }
  }
}

function function_7a1a95a9782f2d03() {
  var_6cf4d7026c51235b = function_7fa77e2dbbd62db5(self.team);
  var_94fdf3291d472947 = var_6cf4d7026c51235b * level.hackerphone.var_d6b7c0cb8162cd8e;

  if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"contractor")) {
    var_94fdf3291d472947 = var_6cf4d7026c51235b * level.hackerphone.var_d6b7c0cb8162cd8e * level.br_pe_data[%"contractor"].var_46a451f9012bd1c;
  }

  self setclientomnvar("ui_br_hacker_phone_potential_cash_value", var_94fdf3291d472947);
}

function function_3d221e16860007d5(playerassimilated, oldteam, newteam) {
  if(istrue(playerassimilated.var_6c8912ea30b21003)) {
    playerassimilated.var_6c8912ea30b21003 = undefined;
    thread function_7481b64fddcb07ca(playerassimilated);
  }
}

function function_7481b64fddcb07ca(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  wait 1;
  displayplayersplash(player, "br_hacker_phone_quest_payment_expired");
}

function function_83d3732a571f142a(player, oldteam, newteam) {
  player.canhackcontracts = undefined;
  player.var_6c8912ea30b21003 = undefined;
  player setclientomnvar("ui_br_hacker_phone_state", 0);

  if(function_42a0806457ea8039(player)) {
    hidequestobjiconfromplayer(player);
  }

  player setclientomnvar("ui_br_hacked_phones_data1", 0);
  player setclientomnvar("ui_br_hacked_phones_data2", 0);
}

function function_75b53ad947495f9c(player, oldteam, newteam) {
  if(function_42a0806457ea8039(player)) {
    player.canhackcontracts = 1;
    player uiobjectiveshow("hacker_phone");
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
    player setclientomnvar("ui_br_hacker_phone_state", 2);
    player namespace_1eb3c4e0e28fac71::uiobjectivesetparameter(self.var_9f274e85b7bbd87f, level.hackerphone.var_be8a6484aed40352);
    showquestobjicontoplayer(player);
    function_a3fcfe7472f9c5db(player, player.team);
  }
}

function function_5418fefa50b762a6() {
  hackablecontracts = level.contractmanager.activetablets;

  if(hackablecontracts.size < self.var_cc4cd023f0195d5f) {
    return false;
  }

  return true;
}