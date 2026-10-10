/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_assassination_quest.gsc
**************************************************************/

#using script_16ea1b94f0f381b3;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_assassination_quest;

function getcontractdata(data, questmodifier) {
  if(!isDefined(level.var_7e12f6eb4fcb4ea1)) {
    level.var_7e12f6eb4fcb4ea1 = spawnStruct();
    var_ad60abb5340e959d = getdvarint(@ "hash_364dca8e32d958fa", 0);
    level.var_7e12f6eb4fcb4ea1.time = var_ad60abb5340e959d != 0 ? var_ad60abb5340e959d : function_ea591c2a379e3424("assassination");
    level.var_7e12f6eb4fcb4ea1.minsearchradius = getdvarint(@ "scr_br_asn_min_search_radius", 5000);
    level.var_7e12f6eb4fcb4ea1.searchlimit = getdvarint(@ "hash_c7054640761be2ef", 30000);
    level.var_7e12f6eb4fcb4ea1.searchincrement = getdvarint(@ "hash_34d149dfddecfa91", 5000);
    level.var_7e12f6eb4fcb4ea1.var_fddf856ca727f674 = getdvarint(@ "hash_4caf4c58c978d604", 100000);
    level.var_7e12f6eb4fcb4ea1.circlerangemin = getdvarint(@ "hash_50295a3311ce37ee", 100);
    level.var_7e12f6eb4fcb4ea1.circlerangemax = getdvarint(@ "hash_50064c3311a7d16c", 1000);
    level.var_7e12f6eb4fcb4ea1.var_3bd4a66a02968ecc = getdvarint(@ "scr_br_asn_circle_radius_small", 1500);
    level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6 = getdvarint(@ "hash_dd2f37f5ec580f08", 2000);
    level.var_7e12f6eb4fcb4ea1.var_a3487335038df794 = getdvarint(@ "scr_br_asn_circle_radius_large", 3500);
    level.var_7e12f6eb4fcb4ea1.var_65dd392cafab8111 = getdvarint(@ "hash_5b3f6111a22668cd", 2500);
    level.var_7e12f6eb4fcb4ea1.var_a12a720226632b47 = getdvarint(@ "hash_befde6c410585907", 5000);
    level.var_7e12f6eb4fcb4ea1.var_7ff8f0c0c1a00138 = getdvarint(@ "scr_br_asn_ideal_search_radius", 16000);
    level.var_7e12f6eb4fcb4ea1.var_7be7f4c0bdc1c7b0 = getdvarint(@ "hash_581d50a4690192ae", 1);
    level.var_7e12f6eb4fcb4ea1.var_892526141a627e1 = getdvarint(@ "hash_5746ccd8cb2f6b4f", 1);
    level.var_7e12f6eb4fcb4ea1.pingreward = getdvarint(@ "hash_27b13c5274e3fd4f", 1);
    level.var_7e12f6eb4fcb4ea1.pingorigin = getdvarint(@ "hash_7a8fdce2ac2e873a", 1);
    level.var_7e12f6eb4fcb4ea1.var_ae78e175442df0a9 = getdvarint(@ "hash_e3799281611ec0e4", 1);
    level.var_7e12f6eb4fcb4ea1.pingsize = getdvarint(@ "hash_b51d8dfbac466b49", 5000);
    level.var_7e12f6eb4fcb4ea1.var_9a4f534954b5a162 = getdvarint(@ "hash_97412cd449d400e9", 2);
    level.var_7e12f6eb4fcb4ea1.usecarrier = getdvarint(@ "hash_bb1780e30ec28dd8", 1);
    level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299 = getdvarint(@ "hash_bdcbfd809661e5c", 1);
    level.var_aab4fba7a041b281 = [];
    assert(isDefined(game["<dev string:x1c>"]));

    if(getDvar(@ "ui_gametype", "") != "limbo") {
      game["dialog"]["mission_ass_accept"] = "mssc_grav_mssn";
    }

    game["dialog"]["mission_ass_hunted"] = "mssh_grav_mssn";
    game["dialog"]["mission_ass_success"] = "msss_grav_mssn";
    game["dialog"]["mission_ass_hunted_success"] = "mshs_grav_mssn";
    game["dialog"]["mission_ass_hunted_timed_out"] = "msht_grav_mssn";
    game["dialog"]["mission_ass_hunted_fail"] = "gnrc_grav_msnf";
    game["dialog"]["mission_ass_fail"] = "bnty_grav_msnf";
    data.funcs["onTeamAssigned"] = &function_b946c0db13d4d90e;
    data.basetime = level.var_7e12f6eb4fcb4ea1.time;
  }

  if(isDefined(questmodifier) && questmodifier == "master") {
    if(!isDefined(level.var_cf303d8ee00e8deb)) {
      level.var_cf303d8ee00e8deb = spawnStruct();
      level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51 = getdvarint(@ "hash_bd8bedf943d59eb", 0);
      level.var_cf303d8ee00e8deb.usedistance = getdvarint(@ "hash_fb68cd88f410c9a9", 0);
      var_ad60abb5340e959d = getdvarint(@ "hash_5795d68ef70d9001", 0);
      level.var_cf303d8ee00e8deb.time = var_ad60abb5340e959d != 0 ? var_ad60abb5340e959d : function_ea591c2a379e3424(questmodifier + "_" + "assassination");
    }

    assert(isDefined(game["<dev string:x1c>"]));
    game["dialog"]["mission_master_ass_accept"] = "bggm_grav_mssm";
    game["dialog"]["mission_master_ass_accept_first_person"] = "bggm_grav_msns";
    game["dialog"]["mission_master_ass_hunted"] = "mssh_grav_mssn";
    game["dialog"]["mission_master_ass_success"] = "msss_grav_mssn";
    game["dialog"]["mission_master_ass_hunted_success"] = "mshs_grav_mssn";
    game["dialog"]["mission_master_ass_hunted_timed_out"] = "msht_grav_mssn";
    game["dialog"]["mission_master_ass_hunted_fail"] = "gnrc_grav_msnf";
    game["dialog"]["mission_master_ass_fail"] = "bnty_grav_msnf";
    data.funcs["onTeamAssigned"] = &function_a7284c22710ed3dc;
    data.basetime = level.var_cf303d8ee00e8deb.time;
  }

  data.funcs["onInit"] = &function_6e27ee56573d1441;
  data.funcs["onEnterGulag"] = &function_ca07a6ca5c3c8af5;
  data.funcs["onPlayerRespawn"] = &function_f6755bd234f8e261;
  data.funcs["onPlayerKilled"] = &quest_onplayerkilled;
  data.funcs["onMarkPlayerAsEliminated"] = &function_4f702ea532a7ca6e;
  data.funcs["onPlayerDisconnect"] = &quest_onplayerdisconnect;
  data.funcs["onCancel"] = &quest_oncancel;
  data.funcs["onPlayerTearDown"] = &function_83d3732a571f142a;
  data.funcs["onPlayerAssimilated"] = &function_75b53ad947495f9c;
  data.funcs["onTargetAssimilated"] = &function_da75eeb9ce2e7700;
  data.funcs["onTargetTeamTearDown"] = &function_39d180c28fe14643;
  data.funcs["onTargetTeamAssimilated"] = &function_1a1b4d2219442853;
  data.funcs["onFinishContract"] = &function_68046efe0486e9b;
}

function function_45cad8c5444e638d() {
  if(level.var_7e12f6eb4fcb4ea1.var_7be7f4c0bdc1c7b0 == 0) {
    return false;
  }

  return istrue(self.var_31d13939f28644d4);
}

function function_6e27ee56573d1441() {
  return true;
}

function function_a7284c22710ed3dc() {
  self.questmodifier = "master";
  self.category = self.questmodifier + "_" + "assassination";
  var_86a80a97f4672fc8 = !level.br_circle_disabled && istrue(level.var_2df69b8e552238b6) && istrue(level.br_multi_circle.issplit);

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("master_aq_determineTargetTeam")) {
    self.targetteam = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("master_aq_determineTargetTeam", self.var_d154ac2657c5f44, var_86a80a97f4672fc8);
  } else {
    self.targetteam = function_296cd8d07488f3bc(self.var_d154ac2657c5f44, var_86a80a97f4672fc8);
  }

  if(isDefined(self.targetteam)) {
    self.hunterteam = self.teams[0];
    level.var_aab4fba7a041b281 = array_combine(level.var_aab4fba7a041b281, getteamdata(self.targetteam, "players"));
    function_fb19ef2575c8b7d0(self.targetteam, self.var_d154ac2657c5f44);

    if(!isDefined(self.targetplayer)) {
      self.var_d154ac2657c5f44 scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
      lootspawnpoint = spawnStruct();
      lootspawnpoint.origin = self.var_d154ac2657c5f44.origin;
      lootspawnpoint.angles = self.var_d154ac2657c5f44.angles;
      var_6b5e1783915835c1 = undefined;
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder", var_6b5e1783915835c1);
      scripts\mp\utility\script::demoforcesre("No Valid Player big game bounty target Found for Team: " + self.targetteam);
      endcontract(undefined, undefined, undefined, "NoTarget");
      return;
    }

    function_6b6b6273f8180522("master_Assassination_Br");
    determinetrackingcircleposition(self.targetplayer);
    determinetrackingcirclesize();
    thread function_6ca0a919d228d381();
    thread function_7b16ac880855a705();
    thread function_a9b3b9469a7a2746();
    time = level.var_cf303d8ee00e8deb.time;
    time = function_9b6275085fbcb8f4(time);
    function_5a15174d34f0670c(time, 0);
    thread function_d1967972e47f382a(time);
    updateassassinationhud();
    params = spawnStruct();
    params.excludedplayers = [];
    params.excludedplayers[0] = self.targetplayer;

    if(isDefined(self.var_d154ac2657c5f44)) {
      params.excludedplayers[1] = self.var_d154ac2657c5f44;
    }

    params.stringvar = self.targetplayer.name;
    displayteamsplash(self.targetteam, "br_master_assassination_quest_start_target_team", params);
    displayplayersplash(self.targetplayer, "br_master_assassination_quest_start_target_player");

    if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_master_ass_hunted", self.targetteam, 1, 2);
    }

    [var_765bece0781ff770, var_19400d1b86740a76] = function_ad56d982450c9db2("br_master_assassination_quest_start_hunter_team", "br_master_assassination_quest_start_tablet_finder");
    function_6a5270845ce88f1e(self.hunterteam, var_765bece0781ff770, params);

    if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_master_ass_accept_first_person", self.var_d154ac2657c5f44, 1, undefined, 2, undefined, "dx_br_jpbm_");
      level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("mission_master_ass_accept", self.hunterteam, self.var_d154ac2657c5f44, 1, undefined, 2, undefined, "dx_br_jpbm_");
    }

    if(isDefined(self.var_d154ac2657c5f44)) {
      displayplayersplash(self.var_d154ac2657c5f44, var_19400d1b86740a76, params);
      displaysquadmessagetoteam(self.hunterteam, self.var_d154ac2657c5f44, 6, getquestindex(self.questmodifier + "_" + "assassination"));
    }

    return;
  }

  self.var_d154ac2657c5f44 scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
  lootspawnpoint = spawnStruct();
  lootspawnpoint.origin = self.var_d154ac2657c5f44.origin;
  lootspawnpoint.angles = self.var_d154ac2657c5f44.angles;
  var_6b5e1783915835c1 = undefined;
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health", var_6b5e1783915835c1);
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo", var_6b5e1783915835c1);
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder", var_6b5e1783915835c1);
  endcontract(undefined, undefined, undefined, "NoTarget");
}

function function_ad56d982450c9db2(var_765bece0781ff770, var_19400d1b86740a76) {
  var_fec8b7a457ed3a4f = function_4bcd7c36b22b9bec(var_765bece0781ff770);

  if(var_765bece0781ff770 != var_fec8b7a457ed3a4f) {
    var_765bece0781ff770 = var_fec8b7a457ed3a4f;
    var_19400d1b86740a76 = var_fec8b7a457ed3a4f;
  }

  return [var_765bece0781ff770, var_19400d1b86740a76];
}

function function_b946c0db13d4d90e() {
  self.questmodifier = "";
  self.category = "assassination";
  var_86a80a97f4672fc8 = !level.br_circle_disabled && istrue(level.var_2df69b8e552238b6) && istrue(level.br_multi_circle.issplit);
  self.targetteam = determinetargetteam(self.var_d154ac2657c5f44, var_86a80a97f4672fc8, self.var_3aac45873695d767);

  if(isDefined(self.targetteam)) {
    self.hunterteam = self.teams[0];
    level.var_aab4fba7a041b281 = array_combine(level.var_aab4fba7a041b281, getteamdata(self.targetteam, "players"));
    self.targetplayer = determinetargetplayer(self.targetteam, self.var_d154ac2657c5f44, var_86a80a97f4672fc8, self.var_3aac45873695d767);

    if(!isDefined(self.targetplayer)) {
      self.var_d154ac2657c5f44 scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
      lootspawnpoint = spawnStruct();
      lootspawnpoint.origin = self.var_d154ac2657c5f44.origin;
      lootspawnpoint.angles = self.var_d154ac2657c5f44.angles;
      var_6b5e1783915835c1 = undefined;
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo", var_6b5e1783915835c1);
      lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder", var_6b5e1783915835c1);
      scripts\mp\utility\script::demoforcesre("No Valid Player bounty target Found for Team: " + self.targetteam);
      endcontract(undefined, undefined, undefined, "NoTarget");
      return;
    }

    function_6b6b6273f8180522("Assassination_Br");
    determinetrackingcircleposition(self.targetplayer);
    determinetrackingcirclesize();
    thread function_6ca0a919d228d381();
    thread function_7b16ac880855a705();
    thread function_a9b3b9469a7a2746();
    time = level.var_7e12f6eb4fcb4ea1.time;
    time = function_9b6275085fbcb8f4(time);

    if(isDefined(self.var_3aac45873695d767) && isDefined(self.var_3aac45873695d767.time)) {
      time = self.var_3aac45873695d767.time;
    }

    function_5a15174d34f0670c(time, 0);
    thread function_d1967972e47f382a(time);
    updateassassinationhud();
    function_2529487ea7a39317();

    if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      if(issharedfuncdefined("assassination_quest", "onTeamAssignedDialogOverride")) {
        [[getsharedfunc("assassination_quest", "onTeamAssignedDialogOverride")]](self.targetteam, self.hunterteam);
      } else {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_ass_hunted", self.targetteam, 1, 2);
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_ass_accept", self.hunterteam, 1, 2);
      }
    }

    return;
  }

  self.var_d154ac2657c5f44 scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
  lootspawnpoint = spawnStruct();
  lootspawnpoint.origin = self.var_d154ac2657c5f44.origin;
  lootspawnpoint.angles = self.var_d154ac2657c5f44.angles;
  var_6b5e1783915835c1 = undefined;
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 1, "health", var_6b5e1783915835c1);
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 0, 2, "ammo", var_6b5e1783915835c1);
  lootspawnpoint scripts\mp\gametypes\br_lootcache::chooseandspawnitems(dropstruct, 1, 1, "plunder", var_6b5e1783915835c1);
  endcontract(undefined, undefined, undefined, "NoTarget");
}

function function_2529487ea7a39317() {
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self.targetplayer;

  if(isDefined(self.var_d154ac2657c5f44)) {
    params.excludedplayers[1] = self.var_d154ac2657c5f44;
  }

  params.stringvar = self.targetplayer.name;
  function_6a5270845ce88f1e(self.targetteam, "br_assassination_quest_start_target_team", params);
  function_70eb08dc68820a5a(self.targetplayer, "br_assassination_quest_start_target_player");
  var_765bece0781ff770 = "br_assassination_quest_start_hunter_team";
  var_19400d1b86740a76 = "br_assassination_quest_start_tablet_finder";
  [var_765bece0781ff770, var_19400d1b86740a76] = function_ad56d982450c9db2("br_assassination_quest_start_hunter_team", "br_assassination_quest_start_tablet_finder");
  function_6a5270845ce88f1e(self.hunterteam, var_765bece0781ff770, params);

  if(isDefined(self.var_d154ac2657c5f44)) {
    function_70eb08dc68820a5a(self.var_d154ac2657c5f44, var_19400d1b86740a76, params);
    displaysquadmessagetoteam(self.hunterteam, self.var_d154ac2657c5f44, 6, getquestindex("assassination"));
  }
}

function function_cba960b48c4b1e3c(splashref, contractindex, rewardcash, team, delay, var_42b1e877ab187c6) {
  if(isDefined(self.var_e826485c32ad0d74) && !array_contains(self.var_e826485c32ad0d74, splashref)) {
    return;
  }

  function_878ebcc241b54505(splashref, contractindex, rewardcash, team, delay, var_42b1e877ab187c6);
}

function function_6a5270845ce88f1e(team, splash_key, params, var_42b1e877ab187c6) {
  if(isDefined(self.var_e826485c32ad0d74) && !array_contains(self.var_e826485c32ad0d74, splash_key)) {
    return;
  }

  displayteamsplash(team, splash_key, params, var_42b1e877ab187c6);
}

function function_70eb08dc68820a5a(player, splash_key, params, var_42b1e877ab187c6) {
  if(isDefined(self.var_e826485c32ad0d74) && !array_contains(self.var_e826485c32ad0d74, splash_key)) {
    return;
  }

  displayplayersplash(player, splash_key, params, var_42b1e877ab187c6);
}

function function_ca07a6ca5c3c8af5(player) {
  if(player.team == self.hunterteam) {
    function_d7d113d56ef0ef5b(player);
    return;
  }

  if(player.team == self.targetteam) {
    player hideassassinationtargethud();
  }
}

function function_f6755bd234f8e261(player) {
  if(player.team == self.hunterteam) {
    function_cfd53c8f6878014f(player);
    return;
  }

  if(player.team == self.targetteam) {
    player showassassinationtargethud(self.targetplayer, self.threat_level);
  }
}

function quest_onplayerkilled(attacker, victim) {
  aq_playerremoved(victim);
}

function function_4f702ea532a7ca6e(victim) {
  aq_playerremoved(victim);
}

function quest_onplayerdisconnect(player) {
  aq_playerremoved(player);
}

function aq_playerremoved(player) {
  if(isDefined(player.team) && player.team == self.hunterteam) {
    filter = namespace_1eb3c4e0e28fac71::function_94a8dc26f5353759(player, level.contractmanager.defaultfilter);

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, filter)) {
      params = spawnStruct();
      params.intvar = 0;
      questmodifier = "";

      if(function_2755c7f527cf8d2()) {
        questmodifier = "master_";
      }

      rewards = function_6ddd1eecbe562acf(questmodifier + "assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"])) {
        params.intvar = int(rewards["plunder"]);
        function_cba960b48c4b1e3c("br_" + questmodifier + "assassination_complete_targets_win", function_3d262d56274bd22e(questmodifier + "assassination"), rewards["plunder"], self.targetteam);
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2);
      }

      thread function_ac21667e0f251104(0, undefined, "Killed");
    }
  }
}

function quest_oncancel(team) {
  if(istrue(self.teams[0] == team)) {
    if(getdvarint(@ "hash_339e124f41f186ad", 1) == 1) {
      params = spawnStruct();
      params.intvar = 0;
      questmodifier = "";

      if(function_2755c7f527cf8d2()) {
        questmodifier = "master_";
      }

      rewards = function_6ddd1eecbe562acf(questmodifier + "assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"])) {
        params.intvar = int(rewards["plunder"]);
        function_cba960b48c4b1e3c("br_" + questmodifier + "assassination_complete_targets_win", function_3d262d56274bd22e(questmodifier + "assassination"), rewards["plunder"], self.targetteam);
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2);
      }
    }

    thread function_ac21667e0f251104(0, undefined, "Cancel");
  }
}

function function_83d3732a571f142a(player, oldteam, newteam) {
  if(oldteam == self.teams[0]) {
    player hideassassinationhud(self);

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.hunterteam, level.contractmanager.defaultfilter)) {
      params = spawnStruct();
      params.intvar = 0;
      questmodifier = "";

      if(function_2755c7f527cf8d2()) {
        questmodifier = "master_";
      }

      rewards = function_6ddd1eecbe562acf(questmodifier + "assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"])) {
        params.intvar = int(rewards["plunder"]);
        function_cba960b48c4b1e3c("br_" + questmodifier + "assassination_complete_targets_win", function_3d262d56274bd22e(questmodifier + "assassination"), rewards["plunder"], self.targetteam);
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2);
      }

      thread function_ac21667e0f251104(0, undefined, "Assimilation");
    }
  }
}

function function_75b53ad947495f9c(player, oldteam, newteam) {
  if(!isDefined(self.targetplayer)) {
    return;
  }

  if(self.targetplayer == player) {
    return;
  }

  if(newteam == self.teams[0]) {
    player showassassinationhud(self, self.questmodifier);
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }
}

function function_39d180c28fe14643(player, oldteam, newteam) {
  player hideassassinationtargethud();
}

function function_1a1b4d2219442853(player, oldteam, newteam) {
  player function_70b452a81a4408d6(self.targetplayer, self.threat_level, self);
}

function function_da75eeb9ce2e7700(player, oldteam, newteam) {
  player hideassassinationtargethud();
  rewards = undefined;

  if(self.teams[0] != newteam) {
    questmodifier = "";

    if(function_2755c7f527cf8d2()) {
      questmodifier = "master_";
    }

    rewards = function_6ddd1eecbe562acf(questmodifier + "assassin_target_vanished", self.hunterteam, self.var_d154ac2657c5f44);

    if(isDefined(rewards) && isDefined(rewards["plunder"])) {
      function_cba960b48c4b1e3c("br_" + questmodifier + "assassination_complete_target_vanished", function_3d262d56274bd22e(questmodifier + "assassination"), rewards["plunder"], self.hunterteam);
    }
  }

  thread function_ac21667e0f251104(1, rewards, "WinAssimilation");
}

function function_ac21667e0f251104(success, results, endstate) {
  self notify("task_ended");
  self endon("task_ended");
  level.var_aab4fba7a041b281 = array_remove_array(level.var_aab4fba7a041b281, getteamdata(self.targetteam, "players"));

  if(!scripts\mp\flags::levelflag("game_over")) {
    wait 1;
  }

  if(isDefined(self.var_b9f7738d77206674)) {
    self thread[[self.var_b9f7738d77206674]](success, endstate);
  }

  if(!istrue(self.var_84f5a35016b5f83)) {
    removeallaqui();
  }

  endcontract(ter_op(istrue(success), self.teams[0], undefined), results, undefined, endstate);
}

function function_7b16ac880855a705() {
  questmodifier = "";
  endstate = "Win";

  if(function_2755c7f527cf8d2()) {
    questmodifier = "master_";
  }

  self endon("task_ended");

  if(!level.var_7e12f6eb4fcb4ea1.var_892526141a627e1) {
    level endon("game_ended");
  }

  self.targetplayer waittill("death_or_disconnect");
  finishcontract(self, self.var_d154ac2657c5f44);
}

function function_68046efe0486e9b(contract, instance, team) {
  contractref = "assassination";
  var_e0ba724f5f288ca0 = "mission_ass_success";
  splash = "br_assassination_complete_hunters_win";
  rewardgroup = "assassin_target_killed";
  var_35e7111354d3bd3b = undefined;
  var_a1bd51507da49d94 = undefined;
  endstate = "Win";

  if(function_2755c7f527cf8d2()) {
    contractref = "master_" + "assassination";
    var_e0ba724f5f288ca0 = "mission_master_ass_success";
  }

  var_bcaa72907e20ad94 = contract.targetplayer.lastkilledby;
  var_e104bde511476c4 = isDefined(var_bcaa72907e20ad94) && isPlayer(var_bcaa72907e20ad94) && isDefined(var_bcaa72907e20ad94.team) && var_bcaa72907e20ad94.team == contract.teams[0];

  if(var_e104bde511476c4 || istrue(contract.var_5d004b75a5b3dc33)) {
    if(function_2755c7f527cf8d2()) {
      splash = "br_master_assassination_complete_hunters_win";
      var_35e7111354d3bd3b = "br_master_assassination_target_killed_target_team";
      var_a1bd51507da49d94 = "mission_master_ass_hunted_fail";
      rewardgroup = "master_assassin_target_killed";
    } else {
      var_35e7111354d3bd3b = "br_assassination_target_killed_target_team";
      var_a1bd51507da49d94 = "mission_ass_hunted_fail";

      if(istrue(level.var_7e12f6eb4fcb4ea1.pingreward)) {
        contract thread function_210be3d9455cfb83(var_bcaa72907e20ad94, contract.targetplayer);
      }
    }
  } else {
    endstate = "Vanished";

    if(function_2755c7f527cf8d2()) {
      splash = "br_master_assassination_complete_target_vanished";
      rewardgroup = "master_assassin_target_vanished";
    } else {
      splash = "br_assassination_complete_target_vanished";
      rewardgroup = "assassin_target_vanished";
    }
  }

  splash = function_4bcd7c36b22b9bec(splash);
  hunterteam = contract.hunterteam;
  targetteam = contract.targetteam;

  if(!istrue(contract.var_5d004b75a5b3dc33)) {
    if(isDefined(var_35e7111354d3bd3b)) {
      contract function_6a5270845ce88f1e(targetteam, var_35e7111354d3bd3b);
    }

    if(isDefined(var_a1bd51507da49d94)) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam(var_a1bd51507da49d94, targetteam, 1, 2.5);
    }
  }

  rewards = function_6ddd1eecbe562acf(rewardgroup, hunterteam, contract.var_d154ac2657c5f44, contract);

  if(isDefined(rewards) && isDefined(rewards["plunder"])) {
    function_cba960b48c4b1e3c(splash, function_3d262d56274bd22e(contractref), rewards["plunder"], hunterteam);
  }

  if(getdvarint(@ "hash_827f1bf2224b0d61", 0) == 1) {
    contract.var_d154ac2657c5f44 function_496ed653faacacd2(contract.hunterteam);
  }

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() && !istrue(level.var_7e12f6eb4fcb4ea1.var_2ef19bc785de8e88)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam(var_e0ba724f5f288ca0, hunterteam, 1, 2);
  }

  contract thread function_ac21667e0f251104(1, rewards, endstate);
}

function function_a9b3b9469a7a2746() {
  self endon("task_ended");
  level waittill("game_ended");
  waitframe();
  self notify("task_ended");
}

function function_d1967972e47f382a(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait time;
  params = spawnStruct();
  params.intvar = 0;
  questmodifier = "";

  if(function_2755c7f527cf8d2()) {
    questmodifier = "master_";
  }

  function_6a5270845ce88f1e(self.hunterteam, "br_" + questmodifier + "assassination_timer_expire_hunters_lose", params);
  rewards = function_6ddd1eecbe562acf(questmodifier + "assassin_averted", self.targetteam, self.targetplayer);

  if(isDefined(rewards) && isDefined(rewards["plunder"])) {
    params.intvar = int(rewards["plunder"]);
    function_cba960b48c4b1e3c("br_" + questmodifier + "assassination_timer_expire_targets_win", function_3d262d56274bd22e(questmodifier + "assassination"), rewards["plunder"], self.targetteam);
  }

  if(!istrue(level.var_7e12f6eb4fcb4ea1.var_f025f6a222b945d9)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_" + questmodifier + "ass_fail", self.hunterteam, 1, 2);
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2);
  }

  thread function_ac21667e0f251104(0, undefined, "Time");
}

function function_6ca0a919d228d381() {
  self endon("task_ended");
  level endon("game_ended");

  while(true) {
    determinetrackingcircleposition(self.targetplayer);
    determinetrackingcirclesize();
    updateassassinationthreatlevel(self.targetteam);
    wait 10;
  }
}

function determinetargetteam(player, var_86a80a97f4672fc8, var_3aac45873695d767) {
  if(isDefined(var_3aac45873695d767)) {
    return var_3aac45873695d767.targetteam;
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("aq_determineTargetTeam")) {
    return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("aq_determineTargetTeam", player, var_86a80a97f4672fc8);
  }

  hunterteam = player.team;
  bestteam = undefined;
  teamsize = 0;
  potentialtargets = level.players;
  list1 = level.var_aab4fba7a041b281;
  list2 = getteamdata(hunterteam, "players");
  excludedteams = array_combine_unique(list1, list2);
  search_bounds = 0;
  searchminradius = level.var_7e12f6eb4fcb4ea1.minsearchradius;
  var_3eae2537f543658b = level.var_7e12f6eb4fcb4ea1.var_7ff8f0c0c1a00138;
  searchlimit = level.var_7e12f6eb4fcb4ea1.searchlimit;

  while(!isDefined(bestteam)) {
    search_bounds += level.var_7e12f6eb4fcb4ea1.searchincrement;

    if(search_bounds < var_3eae2537f543658b) {
      potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, searchminradius);
    } else {
      potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, undefined);
    }

    playerlist = [];

    foreach(potentialtarget in potentiallist) {
      if(istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
        continue;
      }

      if(!istrue(potentialtarget.hasbeentracked) && !potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget) && !potentialtarget function_45cad8c5444e638d()) {
        playerlist[playerlist.size] = potentialtarget;
      }
    }

    if(playerlist.size == 0) {
      if(search_bounds > searchlimit) {
        potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, undefined, undefined);

        foreach(potentialtarget in potentiallist) {
          if(istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
            continue;
          }

          if(!potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget)) {
            playerlist[playerlist.size] = potentialtarget;
          }
        }

        if(playerlist.size == 0) {
          return undefined;
        }
      }
    }

    targetteams = [];
    hunterteamsize = 0;
    var_29f6d200784f77b3 = (0, 0, 0);

    foreach(teammate in getteamdata(hunterteam, "players")) {
      if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
        hunterteamsize++;
        var_29f6d200784f77b3 += teammate.origin;
      }
    }

    var_29f6d200784f77b3 /= hunterteamsize;

    foreach(potentialtarget in playerlist) {
      targetteamsize = 0;

      foreach(teammate in getteamdata(potentialtarget.team, "players")) {
        if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
          targetteamsize++;
        }
      }

      if(targetteamsize == 0) {
        continue;
      }

      if(!isDefined(bestteam)) {
        bestteam = potentialtarget.team;
        teamsize = targetteamsize;
        continue;
      }

      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if(brgametype == "plunder" || brgametype == "risk") {
        var_e6a3e80614fbd020 = scripts\mp\gametypes\br_plunder::getteamcarriedplunder(bestteam);
        var_c237b8fc2586f74f = scripts\mp\gametypes\br_plunder::getteamcarriedplunder(potentialtarget.team);

        if(var_c237b8fc2586f74f > level.var_7e12f6eb4fcb4ea1.var_fddf856ca727f674) {
          if(var_c237b8fc2586f74f > var_e6a3e80614fbd020) {
            bestteam = potentialtarget.team;
            teamsize = targetteamsize;
            continue;
          }
        }
      }

      difference = abs(hunterteamsize - teamsize);

      if(difference < abs(hunterteamsize - targetteamsize)) {
        bestteam = potentialtarget.team;
        teamsize = targetteamsize;
        continue;
      } else if(difference > abs(hunterteamsize - targetteamsize)) {
        continue;
      }

      if(teamsize > targetteamsize) {
        bestteam = potentialtarget.team;
        teamsize = targetteamsize;
        continue;
      } else if(teamsize < targetteamsize) {
        continue;
      }

      currentteamcenter = (0, 0, 0);

      foreach(teammate in getteamdata(potentialtarget.team, "players")) {
        if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
          currentteamcenter += teammate.origin;
        }
      }

      currentteamcenter /= targetteamsize;
      var_76e3e3800077282f = (0, 0, 0);

      foreach(teammate in getteamdata(bestteam, "players")) {
        if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
          currentteamcenter += teammate.origin;
        }
      }

      var_76e3e3800077282f /= targetteamsize;

      if(distance2d(var_29f6d200784f77b3, currentteamcenter) < distance2d(var_29f6d200784f77b3, var_76e3e3800077282f)) {
        bestteam = potentialtarget.team;
        teamsize = targetteamsize;
      }
    }
  }

  if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
    logstring("best Team: " + bestteam + " selected by normal bounty as target team with a size of: " + string(teamsize));
  }

  return bestteam;
}

function determinetargetplayer(targetteam, hunter, var_86a80a97f4672fc8, var_3aac45873695d767) {
  if(isDefined(var_3aac45873695d767)) {
    return var_3aac45873695d767.targetplayer;
  }

  var_6864bee22874201b = undefined;
  var_b803ea87ecf23294 = undefined;
  targetplayer = undefined;
  var_29f6d200784f77b3 = (0, 0, 0);
  hunterteamsize = 0;
  var_18a9e17a42f641a4 = 0;

  if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
    logstring("Beginning normal bounty player selection log for target team: " + targetteam);
  }

  foreach(teammate in getteamdata(targetteam, "players")) {
    if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
      logstring("Player: " + teammate.guid + " check started for team: " + targetteam);
    }

    if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
      logstring("Player: " + teammate.guid + " not dead/heading to or in gulag for team: " + targetteam);
      var_29f6d200784f77b3 += teammate.origin;
      hunterteamsize++;

      if(!teammate function_45cad8c5444e638d()) {
        if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
          logstring("Player: " + teammate.guid + " not Recently Respawned for team: " + targetteam);
        }

        var_18a9e17a42f641a4++;
      }
    }
  }

  var_29f6d200784f77b3 /= hunterteamsize;

  foreach(player in getteamdata(targetteam, "players")) {
    if(istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, hunter.origin)) {
      continue;
    }

    if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || !isreallyalive(player)) {
      if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
        logstring("Player: " + player.guid + " Skipped because they are not alive/going to gulag for team: " + targetteam);
      }

      continue;
    }

    if(var_18a9e17a42f641a4 > 0 && player function_45cad8c5444e638d()) {
      if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
        logstring("Player: " + player.guid + " Skipped because they are not alive/going to gulag for team: " + targetteam);
      }

      continue;
    }

    if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      if(is_equal(player.script_noteworthy, "assassination_target")) {
        targetplayer = player;
        break;
      }
    }

    if(!isDefined(targetplayer)) {
      targetplayer = player;
    }

    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

    if(brgametype == "plunder" || brgametype == "risk") {
      playerplunder = player.plundercount;

      if(isDefined(playerplunder)) {
        var_2cc640c4cf5d3e6a = distance2dsquared(hunter.origin, player.origin);

        if(!isDefined(var_b803ea87ecf23294) || var_2cc640c4cf5d3e6a <= var_b803ea87ecf23294) {
          if(!isDefined(var_6864bee22874201b) || playerplunder >= var_6864bee22874201b) {
            var_6864bee22874201b = playerplunder;
            var_b803ea87ecf23294 = var_2cc640c4cf5d3e6a;
            targetplayer = player;
          }
        }
      }

      continue;
    }

    if(distance2d(var_29f6d200784f77b3, player.origin) < distance2d(var_29f6d200784f77b3, targetplayer.origin)) {
      targetplayer = player;
    }
  }

  assert(isDefined(targetplayer));

  foreach(player in getteamdata(targetteam, "players")) {
    player.hasbeentracked = 1;
  }

  if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
    logstring("Player: " + targetplayer.guid + " returned as bounty target for team: " + targetteam);
  }

  return targetplayer;
}

function function_296cd8d07488f3bc(player, var_86a80a97f4672fc8) {
  hunterteam = player.team;
  bestteam = undefined;
  var_bc22171a4e087263 = 0;
  potentialtargets = level.players;
  list1 = level.var_aab4fba7a041b281;
  list2 = getteamdata(hunterteam, "players");
  excludedteams = array_combine_unique(list1, list2);
  search_bounds = 0;
  searchminradius = level.var_7e12f6eb4fcb4ea1.minsearchradius;
  var_3eae2537f543658b = level.var_7e12f6eb4fcb4ea1.var_7ff8f0c0c1a00138;
  searchlimit = level.var_7e12f6eb4fcb4ea1.searchlimit;

  while(!isDefined(bestteam)) {
    playerlist = [];

    if(istrue(level.var_cf303d8ee00e8deb.usedistance)) {
      search_bounds += level.var_7e12f6eb4fcb4ea1.searchincrement;

      if(search_bounds < var_3eae2537f543658b) {
        potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, searchminradius);
      } else {
        potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, undefined);
      }

      foreach(potentialtarget in potentiallist) {
        if(istrue(level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51) && istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
          continue;
        }

        if(!istrue(potentialtarget.var_dde83398de491983) && !potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget) && !potentialtarget function_45cad8c5444e638d()) {
          playerlist[playerlist.size] = potentialtarget;
        }
      }

      if(playerlist.size == 0) {
        if(search_bounds > searchlimit) {
          potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, undefined, undefined);

          foreach(potentialtarget in potentiallist) {
            if(istrue(level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51) && istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
              continue;
            }

            if(!potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget)) {
              playerlist[playerlist.size] = potentialtarget;
            }
          }

          if(playerlist.size == 0) {
            return undefined;
          }
        }
      }
    } else {
      potentiallist = get_array_of_closest(player.origin, potentialtargets, excludedteams, undefined, undefined, undefined);

      foreach(potentialtarget in potentiallist) {
        if(istrue(level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51) && istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
          continue;
        }

        if(!istrue(potentialtarget.var_dde83398de491983) && !potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget)) {
          playerlist[playerlist.size] = potentialtarget;
        }
      }

      if(playerlist.size == 0) {
        foreach(potentialtarget in potentiallist) {
          if(istrue(level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51) && istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, potentialtarget.origin)) {
            continue;
          }

          if(!potentialtarget scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(potentialtarget)) {
            playerlist[playerlist.size] = potentialtarget;
          }
        }

        if(playerlist.size == 0) {
          return undefined;
        }
      }
    }

    targetteams = [];

    foreach(targetplayer in playerlist) {
      targetteams[targetplayer.team] = getvalidplayersinteam(targetplayer.team, level.contractmanager.defaultfilter).size;
    }

    hunterteamsize = 0;
    var_29f6d200784f77b3 = (0, 0, 0);

    foreach(teammate in getteamdata(hunterteam, "players")) {
      if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
        hunterteamsize++;
        var_29f6d200784f77b3 += teammate.origin;
      }
    }

    var_29f6d200784f77b3 /= hunterteamsize;
    bestteam = undefined;
    var_bc22171a4e087263 = -1;
    bestteamkills = -1;
    var_b1809180266425f7 = -1;
    bestteamscore = -1;
    var_e6a3e80614fbd020 = -1;
    var_fad601f27f75ca3 = -1;
    var_d5a25de63bcbee9e = undefined;

    foreach(team, teamsize in targetteams) {
      if(!isDefined(bestteam)) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = gettargetteamkills(team);
        var_b1809180266425f7 = function_ad9233002503b2de(team);
        bestteamscore = gettargetteamscore(team);
        var_e6a3e80614fbd020 = function_be40beb0c9cc8727(team);
      }

      currentteamkills = gettargetteamkills(team);
      currentteamdamage = function_ad9233002503b2de(team);
      currentteamscore = gettargetteamscore(team);
      var_c237b8fc2586f74f = function_be40beb0c9cc8727(team);

      if(currentteamkills < bestteamkills) {
        continue;
      } else if(currentteamkills > bestteamkills) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = currentteamkills;
        var_b1809180266425f7 = currentteamdamage;
        bestteamscore = currentteamscore;
        var_e6a3e80614fbd020 = var_c237b8fc2586f74f;
        continue;
      }

      if(currentteamdamage < var_b1809180266425f7) {
        continue;
      } else if(currentteamdamage > var_b1809180266425f7) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = currentteamkills;
        var_b1809180266425f7 = currentteamdamage;
        bestteamscore = currentteamscore;
        var_e6a3e80614fbd020 = var_c237b8fc2586f74f;
        continue;
      }

      if(currentteamscore < bestteamscore) {
        continue;
      } else if(currentteamscore > bestteamscore) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = currentteamkills;
        var_b1809180266425f7 = currentteamdamage;
        bestteamscore = currentteamscore;
        var_e6a3e80614fbd020 = var_c237b8fc2586f74f;
        continue;
      }

      if(var_c237b8fc2586f74f < var_e6a3e80614fbd020) {
        continue;
      }

      if(var_c237b8fc2586f74f > var_e6a3e80614fbd020) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = currentteamkills;
        var_b1809180266425f7 = currentteamdamage;
        bestteamscore = currentteamscore;
        var_e6a3e80614fbd020 = var_c237b8fc2586f74f;
        continue;
      }

      if(!isDefined(var_d5a25de63bcbee9e)) {
        var_d5a25de63bcbee9e = randomintrange(1, 3);
      }

      if(var_d5a25de63bcbee9e == 1) {
        bestteam = team;
        var_bc22171a4e087263 = teamsize;
        bestteamkills = currentteamkills;
        var_b1809180266425f7 = currentteamdamage;
        bestteamscore = currentteamscore;
        var_e6a3e80614fbd020 = var_c237b8fc2586f74f;
        var_d5a25de63bcbee9e = undefined;
        continue;
      }

      var_d5a25de63bcbee9e = undefined;
    }

    if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
      logstring("best Team: " + bestteam + " selected by big game bounty as target team with a size of: " + string(var_bc22171a4e087263));
    }

    return bestteam;
  }
}

function function_fb19ef2575c8b7d0(targetteam, hunter, var_86a80a97f4672fc8) {
  var_6864bee22874201b = -1;
  bestscore = -1;
  bestdamage = -1;
  bestkills = -1;
  targetplayer = undefined;
  var_4d1ff294040b332a = undefined;
  var_29f6d200784f77b3 = (0, 0, 0);
  hunterteamsize = 0;
  var_18a9e17a42f641a4 = 0;
  logstring("Beginning big game bounty player selection log for target team: " + targetteam);

  foreach(teammate in getteamdata(targetteam, "players")) {
    if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
      logstring("Player: " + teammate.guid + " check started for team: " + targetteam);
    }

    if(!teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(teammate)) {
      if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
        logstring("Player: " + teammate.guid + " not dead/heading to or in gulag for team: " + targetteam);
      }

      var_29f6d200784f77b3 += teammate.origin;
      hunterteamsize++;

      if(!teammate function_45cad8c5444e638d()) {
        if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
          logstring("Player: " + teammate.guid + " not Recently Respawned for team: " + targetteam);
        }

        var_18a9e17a42f641a4++;
      }
    }
  }

  var_29f6d200784f77b3 /= hunterteamsize;

  foreach(player in getteamdata(targetteam, "players")) {
    if(istrue(level.var_cf303d8ee00e8deb.var_fcf04cd13cd9bc51) && istrue(var_86a80a97f4672fc8) && !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(player.origin, hunter.origin)) {
      continue;
    }

    if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || !isreallyalive(player)) {
      if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
        logstring("Player: " + player.guid + " Skipped because they are not alive/going to gulag for team: " + targetteam);
      }

      continue;
    }

    if(var_18a9e17a42f641a4 > 0 && player function_45cad8c5444e638d()) {
      if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
        logstring("Player: " + player.guid + " Skipped because they are recently Spawned: " + targetteam);
      }

      continue;
    }

    if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
      if(is_equal(player.script_noteworthy, "assassination_target")) {
        targetplayer = player;
        break;
      }
    }

    if(!isDefined(targetplayer)) {
      targetplayer = player;
      var_6864bee22874201b = player.plundercount;
      bestscore = player.score;
      bestdamage = player.extrascore3;
      bestkills = player.kills;
    }

    if(player.kills > bestkills) {
      targetplayer = player;
      continue;
    }

    if(player.extrascore3 > bestdamage) {
      targetplayer = player;
      continue;
    }

    if(player.score > bestscore) {
      targetplayer = player;
      continue;
    }

    if(player.plundercount > var_6864bee22874201b) {
      targetplayer = player;
      continue;
    }

    if(!isDefined(var_4d1ff294040b332a)) {
      var_4d1ff294040b332a = randomintrange(1, 3);
    }

    if(var_4d1ff294040b332a == 1) {
      targetplayer = player;
      var_4d1ff294040b332a = undefined;
      continue;
    }

    var_4d1ff294040b332a = undefined;
  }

  assert(isDefined(targetplayer));

  foreach(player in getteamdata(targetteam, "players")) {
    player.var_dde83398de491983 = 1;
  }

  if(istrue(level.var_7e12f6eb4fcb4ea1.var_b98803eb51e32299)) {
    logstring("Player: " + targetplayer.guid + " returned as big game bounty target for team: " + targetteam);
  }

  self.targetplayer = targetplayer;
}

function determinetrackingcircleposition(targetplayer) {
  self.var_570d954fd995e267 = targetplayer.origin;
  search_location = (targetplayer.origin[0], targetplayer.origin[1], level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6);

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    search_location += math::random_vector_2d() * randomfloatrange(level.var_7e12f6eb4fcb4ea1.circlerangemin, level.var_7e12f6eb4fcb4ea1.circlerangemax);
  }

  function_6e148c8da2e4db13(search_location);
}

function determinetrackingcirclesize() {
  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    function_4584ad1c0e2c58ec(level.lootleadermarksize);
    self.threat_level = 2;
    return;
  }

  var_be4fe0ed95a614d2 = function_bb57baa350ae283d([self.hunterteam]);
  var_8e264a7a7f2c12d7 = function_654d23cd5c127447(self.targetteam);

  if(var_8e264a7a7f2c12d7.size > 1) {
    var_f7b3504483bf799f = function_bb57baa350ae283d(var_8e264a7a7f2c12d7);
  } else {
    var_f7b3504483bf799f = var_be4fe0ed95a614d2;
  }

  switch (var_f7b3504483bf799f) {
    case 0:
      self.threat_level = 2;
      break;
    case 1:
      self.threat_level = 1;
      break;
    case 2:
      self.threat_level = 0;
      break;
    default:
      break;
  }

  switch (var_be4fe0ed95a614d2) {
    case 0:
      function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_3bd4a66a02968ecc);
      break;
    case 1:
      function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6);
      break;
    case 2:
      function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_a3487335038df794);
      break;
  }
}

function function_654d23cd5c127447(targetteam) {
  if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"bountyroyale")) {
    if(isDefined(level.pe_bountyroyale) && isDefined(level.pe_bountyroyale.var_a96c1e1bb32b7f6e)) {
      var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[targetteam];

      if(isDefined(var_6b4aa84a795a9e05) && isDefined(var_6b4aa84a795a9e05.var_9cf547d1047108a2)) {
        return var_6b4aa84a795a9e05.var_9cf547d1047108a2;
      }
    }
  }

  return [self.hunterteam];
}

function function_bb57baa350ae283d(var_8e264a7a7f2c12d7) {
  hunterplayers = [];

  foreach(team in var_8e264a7a7f2c12d7) {
    foreach(player in getteamdata(team, "players")) {
      if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && isreallyalive(player)) {
        hunterplayers[hunterplayers.size] = player;
      }
    }
  }

  if(hunterplayers.size == 0) {
    return 2;
  }

  closestdist = undefined;

  foreach(player in hunterplayers) {
    dist = distance2d(player.origin, self.targetplayer.origin);

    if(!isDefined(closestdist) || dist < closestdist) {
      closestdist = dist;
    }
  }

  return function_1386cea959e64462(closestdist);
}

function function_1386cea959e64462(dist) {
  if(dist > level.var_7e12f6eb4fcb4ea1.var_a12a720226632b47) {
    return 2;
  }

  if(dist > level.var_7e12f6eb4fcb4ea1.var_65dd392cafab8111) {
    return 1;
  }

  return 0;
}

function determineobjectivevisibility() {
  foreach(player in getteamdata(self.hunterteam, "players")) {
    isingulag = player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();
    hud_enabled = isDefined(player.aq_hudenabled) && player.aq_hudenabled;

    if(isingulag && hud_enabled) {
      player hideassassinationhud(self);
    }

    if(!isingulag && !hud_enabled) {
      player showassassinationhud(self, self.questmodifier);
    }
  }

  foreach(player in getteamdata(self.targetteam, "players")) {
    isingulag = player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();
    hud_enabled = isDefined(player.aq_targethudenabled) && player.aq_targethudenabled;

    if(isingulag && hud_enabled) {
      player hideassassinationtargethud();
    }

    if(!isingulag && !hud_enabled) {
      player showassassinationtargethud(self.targetplayer, self.threat_level);
    }
  }
}

function getnewtargetplayer(hunter) {
  if(function_2755c7f527cf8d2()) {
    function_fb19ef2575c8b7d0(self.targetteam, hunter);
  } else {
    self.targetplayer = determinetargetplayer(self.targetteam, hunter);
  }

  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationhud();
}

function removeallaqui() {
  foreach(player in getteamdata(self.hunterteam, "players")) {
    player hideassassinationhud(self);
  }

  var_8e264a7a7f2c12d7 = function_654d23cd5c127447(self.targetteam);

  if(var_8e264a7a7f2c12d7.size <= 1) {
    foreach(player in getteamdata(self.targetteam, "players")) {
      player hideassassinationtargethud();
    }
  }

  function_af5604ce591768e1();
}

function function_210be3d9455cfb83(hunter, victim) {
  level endon("game_ended");
  var_b608af6e8d86fe42 = 0;

  if(isDefined(hunter) && hunter namespace_53fc9ddbb516e6e1::function_87072b42853a9c58("specialty_uav_buff")) {
    var_b608af6e8d86fe42 = 1;
  }

  if(isDefined(level.var_39f69f7dfc40a323)) {
    var_ec00e2b85c91da0c = level.var_39f69f7dfc40a323 * level.var_7e12f6eb4fcb4ea1.var_9a4f534954b5a162;
  } else {
    var_ec00e2b85c91da0c = 3000 * level.var_7e12f6eb4fcb4ea1.var_9a4f534954b5a162;
  }

  if(isDefined(level.var_ab2c4542c95656cb)) {
    var_6c3716013ea4f716 = level.var_ab2c4542c95656cb * level.var_7e12f6eb4fcb4ea1.var_9a4f534954b5a162;
  } else {
    var_6c3716013ea4f716 = 3 * level.var_7e12f6eb4fcb4ea1.var_9a4f534954b5a162;
  }

  if(level.var_7e12f6eb4fcb4ea1.usecarrier) {
    radius = int(level.var_7e12f6eb4fcb4ea1.pingsize * ter_op(isDefined(level.var_c0fe6cb6face684e) && var_b608af6e8d86fe42, level.var_c0fe6cb6face684e, 1));
    pingtime = level.var_7e12f6eb4fcb4ea1.var_ae78e175442df0a9 * var_6c3716013ea4f716 * ter_op(isDefined(level.var_1408c77a4f773854) && var_b608af6e8d86fe42, level.var_1408c77a4f773854, 1);
  } else {
    radius = level.var_7e12f6eb4fcb4ea1.pingsize;
    pingtime = level.var_7e12f6eb4fcb4ea1.var_ae78e175442df0a9 * var_6c3716013ea4f716;
  }

  if(isDefined(hunter) && level.var_7e12f6eb4fcb4ea1.pingorigin == 2) {
    pingorigin = hunter.origin;
  } else if(isDefined(victim)) {
    pingorigin = victim.origin;
  } else {
    pingorigin = self.var_570d954fd995e267;
  }

  if(isDefined(pingorigin)) {
    timepassed = 0;

    while(timepassed < pingtime) {
      triggerportableradarpingteam(pingorigin, self.hunterteam, radius, var_ec00e2b85c91da0c);
      wait var_6c3716013ea4f716;
      timepassed += var_6c3716013ea4f716;
    }
  }
}

function gettargetteamkills(targetteam) {
  targetteamkills = 0;

  foreach(targetplayer in level.teamdata[targetteam]["players"]) {
    targetteamkills += targetplayer.kills;
  }

  return targetteamkills;
}

function gettargetteamscore(targetteam) {
  targetteamscore = 0;

  foreach(targetplayer in level.teamdata[targetteam]["players"]) {
    targetteamscore += targetplayer.score;
  }

  return targetteamscore;
}

function function_ad9233002503b2de(targetteam) {
  var_59fe96126224b040 = 0;

  foreach(targetplayer in level.teamdata[targetteam]["players"]) {
    var_59fe96126224b040 += targetplayer.extrascore3;
  }

  return var_59fe96126224b040;
}

function function_be40beb0c9cc8727(targetteam) {
  var_20f9972d73f039b9 = 0;

  foreach(targetplayer in level.teamdata[targetteam]["players"]) {
    if(!isDefined(targetplayer.plundercount)) {
      plunder = 0;
      var_20f9972d73f039b9 += plunder;
      continue;
    }

    var_20f9972d73f039b9 += targetplayer.plundercount;
  }

  return var_20f9972d73f039b9;
}

function function_2755c7f527cf8d2() {
  return isDefined(self.questmodifier) && self.questmodifier == "master";
}

function getplayerkills() {
  if(level.br_leaderbystreak) {
    return self.killsthislife.size;
  }

  return self.kills;
}

function getfilterformodifier(modifier) {
  switch (modifier) {
    case #"hash_b62fe7e71b905a1":
    case #"hash_ee90b669e8938abd":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

function showassassinationhud(instance, questmodifier) {
  self.aq_hudenabled = 1;

  if(isDefined(questmodifier) && questmodifier == "master") {
    uiobjectiveshow(questmodifier + "_" + "assassination");
  } else {
    uiobjectiveshow("assassination");
  }

  instance function_cfd53c8f6878014f(self);
}

function hideassassinationhud(instance) {
  self.aq_hudenabled = 0;
  uiobjectivehide();
  instance function_d7d113d56ef0ef5b(self);
}

function updateassassinationthreatlevel(targetteam) {
  foreach(player in getteamdata(self.targetteam, "players")) {
    player function_19582ba0dbcc0ab0(self.targetplayer, self.threat_level);
  }
}

function showassassinationtargethud(targetplayer, threatlevel) {
  self.aq_targethudenabled = 1;
  function_19582ba0dbcc0ab0(targetplayer, threatlevel);
}

function function_70b452a81a4408d6(targetplayer, threatlevel, task) {
  self.aq_targethudenabled = 1;
  self setclientomnvar("ui_br_assassination_target_timer", task.missiontime);
  function_19582ba0dbcc0ab0(targetplayer, threatlevel);
}

function hideassassinationtargethud() {
  self.aq_targethudenabled = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

function updateassassinationhud() {
  foreach(player in getteamdata(self.hunterteam, "players")) {
    player showassassinationhud(self, self.questmodifier);
    player uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(player in getteamdata(self.targetteam, "players")) {
    player showassassinationtargethud(self.targetplayer, self.threat_level);
    player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);
  }
}

function gametypeoverrideassassinsearchparams() {
  overrideparams = 0;
  gametype = getsubgametype();

  switch (gametype) {
    case #"hash_59b8e9d05b31ff9":
    case #"hash_5e78ea9021845d4a":
    case #"hash_8299694594ab149d":
    case #"hash_83058a20a2b7cb50":
    case #"hash_bfabc434c59611fa":
      overrideparams = 1;
      break;
  }

  return overrideparams;
}

function function_5f352fb76c54705c() {
  if(isDefined(level.var_aab4fba7a041b281)) {
    return 0;
  }

  return array_contains(level.var_aab4fba7a041b281, self);
}