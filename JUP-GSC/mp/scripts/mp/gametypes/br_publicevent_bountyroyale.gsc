/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_bountyroyale.gsc
*******************************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_assassination_quest;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace br_publicevent_bountyroyale;

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"bountyroyale", &init);
}

function init(eventinfo) {
  if(getdvarint(@ "hash_48dc580a67359380", 1) == 0) {
    return;
  }

  eventinfo.validatefunc = &validatefunc;
  eventinfo.activatefunc = &activatefunc;
  eventinfo.waitfunc = &waitfunc;
  eventinfo.postinitfunc = &postinitfunc;
  eventinfo.deactivatefunc = &function_ce2238c881cf779f;
}

function postinitfunc() {
  level.pe_bountyroyale = spawnStruct();
  level.pe_bountyroyale.var_1d61f5b54c77c3c2 = getdvarint(@ "hash_ea78293276e6f5fc", 1);
  level.pe_bountyroyale.minstarttime = getdvarfloat(@ "hash_e8ff82f5f9cd0948", 60);
  level.pe_bountyroyale.maxstarttime = getdvarfloat(@ "hash_e92378f5f9f56e02", 565);
  level.pe_bountyroyale.eventduration = getdvarint(@ "hash_b99ed95bc7f4bc06", 300);
  level.pe_bountyroyale.var_61ce6ebff1d732ca = getdvarint(@ "hash_5a4f4fdd537647b6", 1) > 0;
  level.pe_bountyroyale.var_74d5da10141b82ce = getdvarint(@ "hash_48dc580a67359380", 1) > 0;
  level.pe_bountyroyale.var_330b0c607f159f0f = getdvarint(@ "hash_ae171a9fd67fa527", 2500);
  level.pe_bountyroyale.var_f1874bf0345ccb11 = getdvarfloat(@ "hash_34fa0ec154827123", 1.5);
  level.pe_bountyroyale.var_b6bb62bb4ae02eb8 = getdvarint(@ "hash_d0cf244a05155e7d", 1) > 0;
  level.pe_bountyroyale.var_a2c18db98e438270 = getdvarint(@ "hash_33acb5858593173", 4000);
  level.pe_bountyroyale.var_d3bdc58877c4ad90 = getdvarint(@ "hash_df967a98af61e5cc", 3);
  function_acc15a6dc2a2e7bd();

  level thread debuginit();
}

function function_acc15a6dc2a2e7bd() {
  game["dialog"]["bountyroyale_announcement"] = "brsc_grav_aaa7";
  game["dialog"]["bountyroyale_explanation"] = "brsc_grav_aaa9";
  game["dialog"]["bountyroyale_explanation_override"] = "brsc_grav_aaa8";
  game["dialog"]["bountyroyale_explanation_cq_exception"] = "brsc_grav_aaa10";
  game["dialog"]["bountyroyale_poached"] = "brsc_grav_aaa11";
  game["dialog"]["bountyroyale_success"] = "brsc_grav_aaa12";
  game["dialog"]["bountyroyale_new_target"] = "brsc_grav_aaa14";
  game["dialog"]["bountyroyale_end"] = "brsc_grav_aaa15";
}

function onteamassigneddialogoverride(targetteam, hunterteam) {
  if(!istrue(level.pe_bountyroyale.var_e4ac12e61bccbfb4)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("bountyroyale_new_target", hunterteam, 1, 2, undefined, "dx_br_brbr_");
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_ass_hunted", targetteam, 1, 2, undefined, "dx_br_brbr_");
  }
}

function validatefunc() {
  return true;
}

function waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  eventstarttime = calculateeventstarttime();
  wait eventstarttime;
}

function calculateeventstarttime() {
  if(level.pe_bountyroyale.maxstarttime > level.pe_bountyroyale.minstarttime) {
    return randomfloatrange(level.pe_bountyroyale.minstarttime, level.pe_bountyroyale.maxstarttime);
  }

  return level.pe_bountyroyale.minstarttime;
}

function function_ca3259387c4ac5a1() {
  eventduration = level.pe_bountyroyale.eventduration;
  buffertime = 10;
  minduration = 30;

  if(isDefined(level.br_circle.circleindex) && level.br_circle.circleindex > -1) {
    var_c51562389cda624f = int(floor(scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7()));
    eventduration = min(eventduration, var_c51562389cda624f - buffertime);
  }

  eventduration = max(eventduration, minduration);
  return eventduration;
}

function activatefunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_bountyroyale_start", "splash_list_br_pe_bountyroyale");
  level thread brleaderdialog("bountyroyale_announcement", 1, undefined, undefined, undefined, undefined, "dx_br_brbr_");
  level.var_c65376f0e1b8e893 = 1;
  level.pe_bountyroyale.var_e4ac12e61bccbfb4 = 1;
  level.var_7e12f6eb4fcb4ea1.var_2ef19bc785de8e88 = 1;
  level.var_7e12f6eb4fcb4ea1.var_f025f6a222b945d9 = 1;
  level.var_b631261462e3ab3c = 1;
  utility::registersharedfunc("assassination_quest", "onTeamAssignedDialogOverride", &onteamassigneddialogoverride);

  if(istrue(level.usegulag)) {
    level callback::add(#"hash_2bdabaeb3b833ac", &onplayerrespawn);
  }

  function_8deef0a616aa7967(function_3de5d12dc8b41598());
  wait 1;
  var_46128c4e78e92809 = function_3de5d12dc8b41598();

  foreach(team in var_46128c4e78e92809) {
    level thread brleaderdialogteam("bountyroyale_explanation", team, 1, undefined, undefined, "dx_br_brbr_");
  }

  if(istrue(level.pe_bountyroyale.var_74d5da10141b82ce)) {
    function_1739cfa5c3d3c5c1();
  }

  wait 2.5;
  function_f022a4cb7d793a8();
  eventduration = function_ca3259387c4ac5a1();
  level.pe_bountyroyale.eventendtime = gettime() + eventduration * 1000;
  level thread starttimer(eventduration, level.pe_bountyroyale.eventendtime);
  function_e04a1636673dddf1();
  level.pe_bountyroyale.var_e4ac12e61bccbfb4 = undefined;
  wait eventduration;
  level thread brleaderdialog("bountyroyale_end", 1, undefined, undefined, undefined, undefined, "dx_br_brbr_");
  scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108(%"bountyroyale");
}

function function_1739cfa5c3d3c5c1() {
  foreach(team, contract in level.contractmanager.var_b6fae9c9655c73bf) {
    if(function_a06bac612f0f146(contract)) {
      level thread brleaderdialogteam("bountyroyale_explanation_cq_exception", team, 1, undefined, undefined, "dx_br_brbr_");
      continue;
    }

    var_a47dc60b683f8e12 = 0;

    if(istrue(level.pe_bountyroyale.var_b6bb62bb4ae02eb8)) {
      contractref = contract.type.ref;

      if(contractref == "assassination" || contractref == "master_assassination") {
        contract.var_5d004b75a5b3dc33 = 1;
      }

      var_a47dc60b683f8e12 = namespace_1eb3c4e0e28fac71::finishcontract(contract, contract.var_d154ac2657c5f44, team);
    }

    if(!var_a47dc60b683f8e12) {
      contract namespace_1eb3c4e0e28fac71::function_31378ee55a2fb527(team);

      if(istrue(level.pe_bountyroyale.var_61ce6ebff1d732ca)) {
        rewards = namespace_1eb3c4e0e28fac71::function_6ddd1eecbe562acf("bounty_royale_cancel_compensation", team, contract.var_d154ac2657c5f44);
      }
    }

    level thread brleaderdialogteam("bountyroyale_explanation_override", team, 1, undefined, undefined, "dx_br_brbr_");
  }
}

function onplayerrespawn(params) {
  player = params.player;

  if(!isDefined(player) || arraycontains(level.pe_bountyroyale.eventdata.var_63f39a17b089760a, player.team)) {
    return;
  }

  newtarget = function_a3076b6364918058(player.team, undefined);

  if(isDefined(newtarget)) {
    function_8e36bd0d4f403330(player.team, newtarget);
    level.pe_bountyroyale.eventdata.var_63f39a17b089760a = function_6d6af8144a5131f1(level.pe_bountyroyale.eventdata.var_63f39a17b089760a, player.team);
  }
}

function function_8deef0a616aa7967(targetteams) {
  if(!isDefined(level.pe_bountyroyale.var_1d9c877cbd2d6dc1)) {
    level.pe_bountyroyale.var_1d9c877cbd2d6dc1 = [];
  }

  foreach(team in targetteams) {
    level.pe_bountyroyale.var_1d9c877cbd2d6dc1[team] = namespace_1eb3c4e0e28fac71::function_e98c0791b051398(team);
    namespace_1eb3c4e0e28fac71::function_2938430ff02a6256(team, 1);
  }
}

function function_f022a4cb7d793a8() {
  if(!isDefined(level.pe_bountyroyale.var_1d9c877cbd2d6dc1)) {
    return;
  }

  foreach(team, shouldforce in level.pe_bountyroyale.var_1d9c877cbd2d6dc1) {
    namespace_1eb3c4e0e28fac71::function_2938430ff02a6256(team, shouldforce);
  }

  level.pe_bountyroyale.var_1d9c877cbd2d6dc1 = [];
}

function function_a06bac612f0f146(contract) {
  return istrue(contract.iselite);
}

function function_e04a1636673dddf1() {
  var_25a9983ace778b7a = function_3de5d12dc8b41598();

  if(var_25a9983ace778b7a.size <= 1) {
    return;
  }

  function_dcf09954e91ac0ed(var_25a9983ace778b7a);
  var_b6970f580273b509 = function_a2ff10734881cdd8(var_25a9983ace778b7a);

  foreach(team, target in var_b6970f580273b509) {
    function_8e36bd0d4f403330(team, target);
  }

  function_bf5778d86600b130(var_b6970f580273b509);
}

function function_dcf09954e91ac0ed(var_25a9983ace778b7a) {
  level.pe_bountyroyale.eventdata = spawnStruct();
  level.pe_bountyroyale.eventdata.var_63f39a17b089760a = var_25a9983ace778b7a;
  level.pe_bountyroyale.var_a96c1e1bb32b7f6e = [];

  foreach(team in var_25a9983ace778b7a) {
    teamdata = spawnStruct();
    teamdata.failcount = 0;
    teamdata.successcount = 0;
    teamdata.var_8d4a699abe2400b0 = undefined;
    teamdata.var_9cf547d1047108a2 = [];
    level.pe_bountyroyale.var_a96c1e1bb32b7f6e[team] = teamdata;
    function_cabf176cb15dcc21(team, 0);
    function_7a552558fb71d098(team, 0);
    function_a4264edac412fc8b(team, 0);
  }
}

function function_8e36bd0d4f403330(team, target) {
  [player] = scripts\mp\utility\teams::getteamdata(team, "players");
  contractdata = level.contractmanager.var_766f9de01948c219["assassination"];
  var_3aac45873695d767 = spawnStruct();
  var_3aac45873695d767.targetteam = target.team;
  var_3aac45873695d767.targetplayer = target;
  var_3aac45873695d767.time = function_75521d805c8cbc9e();
  instance = spawnStruct();
  instance.task = spawnStruct();
  instance.task.type = contractdata;
  instance.task.var_3aac45873695d767 = var_3aac45873695d767;
  instance.task.var_e826485c32ad0d74 = ["br_assassination_timer_expire_hunters_lose"];
  instance.task.var_132f5385c2f23a96 = 1;
  instance.task.var_84f5a35016b5f83 = 1;
  instance.task.var_b9f7738d77206674 = &oncontractend;
  instance.task namespace_1eb3c4e0e28fac71::function_8ad1b4ddc1fd852a(team, player);
  instance.task thread[[contractdata.funcs["onTeamAssigned"]]]();
  var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[target.team];
  var_6b4aa84a795a9e05.var_8d4a699abe2400b0 = target;
  var_6b4aa84a795a9e05.var_9cf547d1047108a2 = function_6d6af8144a5131f1(var_6b4aa84a795a9e05.var_9cf547d1047108a2, team);
  function_7a552558fb71d098(team, 1);
}

function function_3de5d12dc8b41598() {
  var_25a9983ace778b7a = [];

  foreach(team in level.teamnamelist) {
    if(namespace_1eb3c4e0e28fac71::function_7094c7010c5e3827(team)) {
      continue;
    }

    if(function_1c7625817533665d(team)) {
      continue;
    }

    var_25a9983ace778b7a = array_add(var_25a9983ace778b7a, team);
  }

  return var_25a9983ace778b7a;
}

function function_1c7625817533665d(team) {
  alivecount = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(alivecount == 0) {
    return true;
  }

  foreach(player in getteamdata(team, "players")) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(player)) {
      return false;
    }
  }

  return true;
}

function function_75521d805c8cbc9e() {
  remainingms = level.pe_bountyroyale.eventendtime - gettime();
  var_b3cc1bfb924f218c = int(floor(remainingms / 1000));
  return var_b3cc1bfb924f218c;
}

function function_69c091a3d7584cf6(var_25a9983ace778b7a) {
  var_b6970f580273b509 = [];
  var_90f93cf7dfc57d72 = array_randomize(var_25a9983ace778b7a);

  foreach(index, hunterteam in var_90f93cf7dfc57d72) {
    targetindex = index + 1;

    if(targetindex >= var_90f93cf7dfc57d72.size) {
      targetindex = 0;
    }

    targetteam = var_90f93cf7dfc57d72[targetindex];
    var_e7f4a3dc0faa357 = function_9f816528b352540a(targetteam);

    if(var_e7f4a3dc0faa357.size > 0) {
      targetplayer = array_random(var_e7f4a3dc0faa357);
      var_b6970f580273b509[hunterteam] = targetplayer;
    }
  }

  return var_b6970f580273b509;
}

function function_9f816528b352540a(team) {
  players = [];

  if(!isDefined(team)) {
    return players;
  }

  var_a0f249ef16efed90 = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");

  foreach(player in var_a0f249ef16efed90) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(player)) {
      players = array_add(players, player);
    }
  }

  return players;
}

function oncontractend(success, endstate) {
  level endon("game_ended");

  if(function_13c3114bfa3f7606() || !ispubliceventoftypeactive(%"bountyroyale")) {
    function_efed774aa2ac46b9();
  } else {
    namespace_1eb3c4e0e28fac71::function_2938430ff02a6256(self.hunterteam, 1);
  }

  function_3369f2854734b60(endstate);
  wait 2;
  namespace_1eb3c4e0e28fac71::function_2938430ff02a6256(self.hunterteam, 0);
  function_a4264edac412fc8b(self.targetteam, 0);
  function_a4264edac412fc8b(self.hunterteam, 0);
  function_afb6cc0249446efc();

  if(!ispubliceventoftypeactive(%"bountyroyale")) {
    return;
  }

  var_b345568f360b585e = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[self.hunterteam];
  var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[self.targetteam];
  var_6b4aa84a795a9e05.var_9cf547d1047108a2 = array_remove(var_6b4aa84a795a9e05.var_9cf547d1047108a2, self.hunterteam);

  if(var_6b4aa84a795a9e05.var_9cf547d1047108a2.size == 0) {
    var_6b4aa84a795a9e05.var_8d4a699abe2400b0 = undefined;
    function_efed774aa2ac46b9();
  }

  iscompleted = endstate == "Win";
  var_d71235f8fa531de5 = endstate == "Vanished";

  if(iscompleted) {
    var_b345568f360b585e.successcount++;
    function_cabf176cb15dcc21(self.hunterteam, var_b345568f360b585e.successcount);
    level thread brleaderdialogteam("bountyroyale_success", self.hunterteam, 1, undefined, undefined, "dx_br_brbr_");
  } else if(var_d71235f8fa531de5) {
    level thread brleaderdialogteam("bountyroyale_poached", self.hunterteam, 1, undefined, undefined, "dx_br_brbr_");
  }

  if(iscompleted || var_d71235f8fa531de5) {
    var_6b4aa84a795a9e05.failcount++;

    if(function_1c7625817533665d(self.hunterteam)) {
      return;
    }

    if(function_13c3114bfa3f7606()) {
      return;
    }

    lasttarget = self.targetteam;
    newtarget = function_a3076b6364918058(self.hunterteam, lasttarget);

    if(isDefined(newtarget)) {
      function_8e36bd0d4f403330(self.hunterteam, newtarget);
      return;
    }

    function_7a552558fb71d098(self.hunterteam, 0);
    var_4a5a7013bf65599e = level.pe_bountyroyale.eventdata.var_63f39a17b089760a.size;
    assertex(var_4a5a7013bf65599e <= 1, "<dev string:x1c>" + var_4a5a7013bf65599e + "<dev string:x55>" + self.hunterteam + "<dev string:x68>");
  }
}

function function_3369f2854734b60(endstate) {
  switch (endstate) {
    case #"hash_602a0e6cc25d3c99":
      function_a4264edac412fc8b(self.hunterteam, 1);
      function_a4264edac412fc8b(self.targetteam, 4);
      break;
    case #"hash_3b5e333b846150b0":
      function_a4264edac412fc8b(self.targetteam, 3);
      break;
    case #"hash_71c7bd3c3fd26bb":
      function_a4264edac412fc8b(self.hunterteam, 2);
      function_a4264edac412fc8b(self.targetteam, 4);
      break;
    default:
      break;
  }
}

function function_13c3114bfa3f7606() {
  return function_75521d805c8cbc9e() < 5;
}

function function_afb6cc0249446efc() {
  foreach(player in getteamdata(self.hunterteam, "players")) {
    if(!isDefined(player)) {
      continue;
    }

    player scripts\mp\gametypes\br_assassination_quest::hideassassinationhud(self);
  }

  function_af5604ce591768e1();
}

function function_efed774aa2ac46b9() {
  foreach(player in getteamdata(self.targetteam, "players")) {
    if(!isDefined(player)) {
      continue;
    }

    player scripts\mp\gametypes\br_assassination_quest::hideassassinationtargethud();
  }
}

function function_a3076b6364918058(hunterteam, lasttarget) {
  switch (level.pe_bountyroyale.var_1d61f5b54c77c3c2) {
    case 0:
      return function_1a11bf1f128d1147(hunterteam, lasttarget);
    case 1:
      return function_47875c900cc6ea2c(hunterteam, undefined);
    case 2:
      return function_47875c900cc6ea2c(hunterteam, lasttarget);
  }
}

function function_1a11bf1f128d1147(hunterteam, lasttarget) {
  var_29f6d200784f77b3 = function_46eb8dc4be18be53(hunterteam);
  var_df489f5f35b5223c = [];
  toremove = [];
  var_67944f8fecc599fc = level.pe_bountyroyale.var_a2c18db98e438270;
  var_28b9834228e132d = var_67944f8fecc599fc * var_67944f8fecc599fc;

  foreach(team in level.pe_bountyroyale.eventdata.var_63f39a17b089760a) {
    if(team == hunterteam) {
      continue;
    }

    if(team == lasttarget && level.pe_bountyroyale.eventdata.var_63f39a17b089760a.size > 2) {
      continue;
    }

    if(function_1c7625817533665d(team)) {
      toremove = array_add(toremove, team);
      continue;
    }

    teamdata = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[team];

    if(teamdata.var_9cf547d1047108a2.size >= level.pe_bountyroyale.var_d3bdc58877c4ad90) {
      continue;
    }

    squaddata = spawnStruct();
    squaddata.team = team;
    squaddata.center = function_46eb8dc4be18be53(team);
    squaddata.distsquared = distancesquared(var_29f6d200784f77b3, squaddata.center);
    var_bd78011f8dc8aea3 = int(floor(squaddata.distsquared / var_28b9834228e132d));
    squaddata.score = teamdata.successcount - teamdata.failcount;
    squaddata.score -= var_bd78011f8dc8aea3;
    var_df489f5f35b5223c = array_add(var_df489f5f35b5223c, squaddata);
  }

  level.pe_bountyroyale.eventdata.var_63f39a17b089760a = array_exclude(level.pe_bountyroyale.eventdata.var_63f39a17b089760a, toremove);
  bestteam = undefined;

  foreach(squadteam in var_df489f5f35b5223c) {
    if(!isDefined(bestteam) || bestteam.score < squadteam.score) {
      bestteam = squadteam;
    }
  }

  targetteam = bestteam.team;
  target = determinetargetplayer(targetteam);
  return target;
}

function function_47875c900cc6ea2c(hunterteam, lasttarget) {
  var_29f6d200784f77b3 = function_46eb8dc4be18be53(hunterteam);
  toremove = [];
  closestplayer = undefined;
  var_d371cb71ffcd6db0 = 2147483647;

  foreach(team in level.pe_bountyroyale.eventdata.var_63f39a17b089760a) {
    if(team == hunterteam) {
      continue;
    }

    if(isDefined(lasttarget) && team == lasttarget && level.pe_bountyroyale.eventdata.var_63f39a17b089760a.size > 2) {
      continue;
    }

    if(function_1c7625817533665d(team)) {
      toremove = array_add(toremove, team);
      continue;
    }

    var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[team];
    players = [];

    if(isDefined(var_6b4aa84a795a9e05.var_8d4a699abe2400b0)) {
      players[players.size] = var_6b4aa84a795a9e05.var_8d4a699abe2400b0;
    } else {
      players = teams::getteamdata(team, "alivePlayers");
    }

    foreach(player in players) {
      distsquared = distancesquared(var_29f6d200784f77b3, player.origin);

      if(distsquared < var_d371cb71ffcd6db0) {
        var_d371cb71ffcd6db0 = distsquared;
        closestplayer = player;
      }
    }
  }

  level.pe_bountyroyale.eventdata.var_63f39a17b089760a = array_exclude(level.pe_bountyroyale.eventdata.var_63f39a17b089760a, toremove);
  return closestplayer;
}

function determinetargetplayer(targetteam) {
  target = undefined;
  var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[targetteam];

  if(isDefined(var_6b4aa84a795a9e05.var_8d4a699abe2400b0)) {
    target = var_6b4aa84a795a9e05.var_8d4a699abe2400b0;
  } else {
    var_e7f4a3dc0faa357 = scripts\mp\utility\teams::getteamdata(targetteam, "alivePlayers");
    target = array_random(var_e7f4a3dc0faa357);
  }

  return target;
}

function starttimer(eventduration, eventendtime) {
  level endon("game_ended");
  level endon("cancel_public_event");
  setomnvar("ui_publicevent_timer_type", 15);
  setomnvar("ui_publicevent_timer", eventendtime);
  setomnvar("ui_minimap_pulse", 1);
  function_5b6afddc1743e9de(eventduration);
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
}

function function_5b6afddc1743e9de(eventduration) {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_ca02c726ecd84e81 = 5;

  if(eventduration > var_ca02c726ecd84e81) {
    wait eventduration - var_ca02c726ecd84e81;
  } else {
    var_ca02c726ecd84e81 = int(eventduration);
  }

  clockobject = spawn("script_origin", (0, 0, 0));
  clockobject hide();

  for(i = 0; i < var_ca02c726ecd84e81; i++) {
    clockobject playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  clockobject delete();
}

function function_ce2238c881cf779f() {
  thread function_cd5d0ed82eacf32d();
}

function function_cd5d0ed82eacf32d() {
  level thread scripts\mp\gametypes\br_analytics::function_ac421483c1da1cf7(self, level.pe_bountyroyale.var_a96c1e1bb32b7f6e);
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  utility::function_3bd171ed299fd530("assassination_quest", "onTeamAssignedDialogOverride", &onteamassigneddialogoverride);

  foreach(team in level.teamnamelist) {
    namespace_1eb3c4e0e28fac71::function_2938430ff02a6256(team, 0);
    function_7a552558fb71d098(team, 0);
    function_cabf176cb15dcc21(team, 0);
    function_a4264edac412fc8b(team, 0);
  }

  if(istrue(level.usegulag)) {
    level callback::remove(#"hash_2bdabaeb3b833ac", &onplayerrespawn);
  }

  wait 2;
  level.var_c65376f0e1b8e893 = undefined;
  level.var_7e12f6eb4fcb4ea1.var_2ef19bc785de8e88 = undefined;
  level.var_7e12f6eb4fcb4ea1.var_7af3ba71c8b60f17 = undefined;
}

function function_a2ff10734881cdd8(var_25a9983ace778b7a) {
  var_20d4f6638c24feff = function_b717d5faa4195b44(var_25a9983ace778b7a);
  var_b6970f580273b509 = [];

  foreach(cluster in var_20d4f6638c24feff) {
    bounties = function_69c091a3d7584cf6(cluster.teams);
    var_b6970f580273b509 = array_combine_non_integer_indices(var_b6970f580273b509, bounties);
  }

  return var_b6970f580273b509;
}

function function_b717d5faa4195b44(var_25a9983ace778b7a) {
  clusters = [];
  var_5ebc9278733adbfe = [];
  var_c9c8fb22375ec00c = [];
  var_5fd6ab1863ef6405 = [];
  var_2d411758efd4206e = 0;
  var_d40f1857708f6149 = 2 * level.pe_bountyroyale.var_330b0c607f159f0f;

  foreach(team in var_25a9983ace778b7a) {
    var_7c449775cb207295 = function_46eb8dc4be18be53(team);
    var_5fd6ab1863ef6405[team] = var_7c449775cb207295;
    longitude = int(floor(var_7c449775cb207295[0] / var_d40f1857708f6149));
    latitude = int(floor(var_7c449775cb207295[1] / var_d40f1857708f6149));

    if(!isDefined(var_5ebc9278733adbfe[longitude])) {
      var_5ebc9278733adbfe[longitude] = [];
    }

    if(!isDefined(var_5ebc9278733adbfe[longitude][latitude])) {
      cluster = spawnStruct();
      cluster.teams = [team];
      cluster.centroid = var_7c449775cb207295;
      var_5ebc9278733adbfe[longitude][latitude] = cluster;
      clusters[clusters.size] = cluster;
      continue;
    }

    cluster = var_5ebc9278733adbfe[longitude][latitude];
    cluster.teams = array_add(cluster.teams, team);
    cluster.centroid += (var_7c449775cb207295 - cluster.centroid) / cluster.teams.size;
    var_c9c8fb22375ec00c = array_add(var_c9c8fb22375ec00c, cluster);
  }

  var_643fc3561caf0e49 = array_exclude(clusters, var_c9c8fb22375ec00c);
  var_eaa7164d06855f8e = var_643fc3561caf0e49.size;

  thread function_4d4fe2c60744d274(var_643fc3561caf0e49, var_5fd6ab1863ef6405, 1);

  result = function_91497d8b29654b3(clusters, var_643fc3561caf0e49, var_5fd6ab1863ef6405, level.pe_bountyroyale.var_330b0c607f159f0f);

  if(result.var_643fc3561caf0e49.size > 0 && level.pe_bountyroyale.var_f1874bf0345ccb11 > 0) {
    maxradius = level.pe_bountyroyale.var_330b0c607f159f0f * level.pe_bountyroyale.var_f1874bf0345ccb11;
    result = function_91497d8b29654b3(result.clusters, result.var_643fc3561caf0e49, var_5fd6ab1863ef6405, maxradius);
  }

  if(result.var_643fc3561caf0e49.size == 1) {
    result = function_91497d8b29654b3(result.clusters, result.var_643fc3561caf0e49, var_5fd6ab1863ef6405, level.pe_bountyroyale.var_330b0c607f159f0f);
  }

  clusters = result.clusters;
  var_643fc3561caf0e49 = result.var_643fc3561caf0e49;

  if(var_643fc3561caf0e49.size > 0) {
    cluster = spawnStruct();
    cluster.teams = [];
    cluster.centroid = (0, 0, 0);
    var_2d411758efd4206e = 1;

    foreach(var_8823903a5afe09e0 in var_643fc3561caf0e49) {
      cluster.teams = array_add(cluster.teams, var_8823903a5afe09e0.teams[0]);
      cluster.centroid += (var_8823903a5afe09e0.centroid - cluster.centroid) / cluster.teams.size;
      clusters = array_remove(clusters, var_8823903a5afe09e0);
    }

    clusters[clusters.size] = cluster;
  }

  var_2775b7b548638c01 = [];
  teamcount = 0;

  foreach(cluster in clusters) {
    assertex(cluster.teams.size > 1, "<dev string:x6d>");

    foreach(team in cluster.teams) {
      teamcount++;

      if(!isDefined(var_2775b7b548638c01[team])) {
        var_2775b7b548638c01[team] = 1;
        continue;
      }

      assertmsg("<dev string:xa0>" + team + "<dev string:xa9>");
    }
  }

  assertex(teamcount == var_25a9983ace778b7a.size, "<dev string:xd2>");
  thread function_4d4fe2c60744d274(clusters, var_5fd6ab1863ef6405);

  function_fab4e7780ef914f6(clusters, var_eaa7164d06855f8e, var_2d411758efd4206e);
  return clusters;
}

function function_91497d8b29654b3(clusters, var_643fc3561caf0e49, var_5fd6ab1863ef6405, maxdistance) {
  toremove = [];
  var_59cc5922efef9f4 = maxdistance * maxdistance;

  foreach(var_8823903a5afe09e0 in var_643fc3561caf0e49) {
    if(!function_7d52bd0855978b16(var_8823903a5afe09e0)) {
      continue;
    }

    var_187f0b6030e8fa03 = function_1191b2b6c3094237(var_8823903a5afe09e0, clusters);
    var_e29c52feb07735ef = var_8823903a5afe09e0.teams[0];
    var_c88e297a523e96c3 = 0;
    var_58a1ce32127d1047 = var_643fc3561caf0e49.size - toremove.size;

    if(var_58a1ce32127d1047 == 1) {
      var_c88e297a523e96c3 = 1;
    } else {
      squadcenter = var_5fd6ab1863ef6405[var_e29c52feb07735ef];
      var_913e33347180eb86 = var_187f0b6030e8fa03.centroid;
      var_c88e297a523e96c3 = distance2dsquared(var_913e33347180eb86, squadcenter) < var_59cc5922efef9f4;
    }

    if(var_c88e297a523e96c3) {
      var_187f0b6030e8fa03.centroid += (var_8823903a5afe09e0.centroid - var_187f0b6030e8fa03.centroid) / var_187f0b6030e8fa03.teams.size;

      if(function_7d52bd0855978b16(var_187f0b6030e8fa03)) {
        toremove = array_add(toremove, var_187f0b6030e8fa03);
      }

      var_187f0b6030e8fa03.teams = array_add(var_187f0b6030e8fa03.teams, var_e29c52feb07735ef);
      toremove = array_add(toremove, var_8823903a5afe09e0);
      clusters = array_remove(clusters, var_8823903a5afe09e0);
    }
  }

  var_643fc3561caf0e49 = array_exclude(var_643fc3561caf0e49, toremove);
  result = spawnStruct();
  result.clusters = clusters;
  result.var_643fc3561caf0e49 = var_643fc3561caf0e49;
  return result;
}

function function_7d52bd0855978b16(cluster) {
  return cluster.teams.size == 1;
}

function function_1191b2b6c3094237(cluster, clusters) {
  var_fba35377e19e2952 = undefined;
  var_6428c2ccff6452d3 = undefined;

  foreach(var_db23754b75385ee0 in clusters) {
    if(var_db23754b75385ee0 == cluster) {
      continue;
    }

    dist = distance2dsquared(cluster.centroid, var_db23754b75385ee0.centroid);

    if(!isDefined(var_6428c2ccff6452d3) || dist < var_6428c2ccff6452d3) {
      var_6428c2ccff6452d3 = dist;
      var_fba35377e19e2952 = var_db23754b75385ee0;
    }
  }

  return var_fba35377e19e2952;
}

function function_46eb8dc4be18be53(team) {
  teamcenter = (0, 0, 0);
  teamsize = 0;

  foreach(player in getteamdata(team, "players")) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(player)) {
      teamcenter += player.origin;
      teamsize++;
    }
  }

  if(teamsize > 0) {
    teamcenter /= teamsize;
  }

  return teamcenter;
}

function private function_7a552558fb71d098(team, var_1a62267ee21ef3e1) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_pe_bounty_royale_data", 0, 1, var_1a62267ee21ef3e1);
  }
}

function private function_cabf176cb15dcc21(team, var_38db716a3041bec5) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!isDefined(players)) {
      continue;
    }

    player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_pe_bounty_royale_data", 1, 4, var_38db716a3041bec5);
  }
}

function private function_a4264edac412fc8b(team, var_fcb5cf3226c472cf) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  var_d5a72928babca3dd = -1;

  foreach(player in players) {
    if(!isDefined(players)) {
      continue;
    }

    if(var_d5a72928babca3dd == -1) {
      var_56304411906a2d70 = player scripts\cp_mp\utility\omnvar_utility::function_40f3e4aeda0e3f00("ui_br_pe_bounty_royale_data", 5, 4);

      if(var_fcb5cf3226c472cf > 0) {
        var_d5a72928babca3dd = 1 << var_fcb5cf3226c472cf - 1;
        var_d5a72928babca3dd = var_56304411906a2d70 | var_d5a72928babca3dd;
      } else {
        var_d5a72928babca3dd = 0;
      }
    }

    player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_pe_bounty_royale_data", 5, 4, var_d5a72928babca3dd);
  }
}

function function_bf5778d86600b130(var_b6970f580273b509) {
  if(getdvarint(@ "hash_e36b1d2f6f9475cd", 0) == 0) {
    return;
  }

  stats = function_a73bac32e1c800c6(var_b6970f580273b509);
  function_9ea3314bc1ca2fd(stats);
}

function function_a73bac32e1c800c6(var_b6970f580273b509) {
  stats = spawnStruct();
  stats.distances = [];
  stats.var_2ac43ce7db24a85a = [];
  stats.targetteams = [];
  stats.var_7cea366d56a22793 = 0;
  var_d794ee974c5cdbe = level.pe_bountyroyale.var_330b0c607f159f0f * 2;

  foreach(team, target in var_b6970f580273b509) {
    stats.targetteams[team] = target.team;
    stats.var_2ac43ce7db24a85a[target.team] = target;
    teamcenter = function_46eb8dc4be18be53(team);
    dist = distance2d(teamcenter, target.origin);

    if(!isDefined(stats.mindistance) || dist < stats.mindistance) {
      stats.mindistance = dist;
    }

    if(!isDefined(stats.maxdistance) || dist > stats.maxdistance) {
      stats.maxdistance = dist;
    }

    if(dist > var_d794ee974c5cdbe) {
      stats.var_7cea366d56a22793++;
    }

    stats.distances[stats.distances.size] = dist;
  }

  stats.distances = array_sort_with_func(stats.distances, &function_75e57b4ca2e7c32f);
  stats.var_2156a1d633f6b307 = array_average(stats.distances);
  var_49635221073c3e59 = int(floor(stats.distances.size / 2));

  if(stats.distances.size % 2 != 0) {
    stats.var_b11e8e7481941f9c = stats.distances[var_49635221073c3e59];
  } else {
    var_b9c1be3b0cb82965 = stats.distances[var_49635221073c3e59] + stats.distances[var_49635221073c3e59 - 1];
    stats.var_b11e8e7481941f9c = var_b9c1be3b0cb82965 / 2;
  }

  return stats;
}

function private function_75e57b4ca2e7c32f(a, b) {
  return a < b;
}

function function_9ea3314bc1ca2fd(stats, waveindex) {
  logstring("-----------------------------------------------------");
  logstring("Public Event Bounty Royale - Assignation Statistics :");
  logstring("-----------------------------------------------------");
  logstring("----- Nb Bounties distributed: " + stats.targetteams.size);
  targetteams = stats.targetteams;
  logstring("Targets Chains: ");

  while(targetteams.size > 0) {
    var_3ff67a12ccb276b6 = function_5b9a5dd25a426550(targetteams);
    str = function_433e2f02b6fe8619(var_3ff67a12ccb276b6, stats.var_2ac43ce7db24a85a);
    logstring(str);

    foreach(key in var_3ff67a12ccb276b6) {
      targetteams = array_remove_key(targetteams, key);
    }
  }

  logstring("Isolated Targets: " + stats.var_7cea366d56a22793);
  logstring("Minimum distance: " + stats.mindistance);
  logstring("Maximum distance: " + stats.maxdistance);
  logstring("Mediandistance: " + stats.var_b11e8e7481941f9c);
  logstring("Average distance: " + stats.var_2156a1d633f6b307);
  logstring("-----------------------------------------------------");
}

function function_433e2f02b6fe8619(var_3ff67a12ccb276b6, var_2ac43ce7db24a85a) {
  str = "";

  for(i = 0; i < var_3ff67a12ccb276b6.size - 1; i++) {
    if(i == 0) {
      team = var_3ff67a12ccb276b6[i];
      str += team;
    }

    targetteam = var_3ff67a12ccb276b6[i + 1];
    str = str + " --> " + targetteam;
    str = str + " ( " + var_2ac43ce7db24a85a[targetteam].name + " )";
  }

  return str;
}

function function_5b9a5dd25a426550(targetteams) {
  firstteam = array_get_first_item(targetteams);
  var_df445b82bd25c0cd = firstteam;
  var_3ff67a12ccb276b6 = [firstteam];

  for(var_784c96b93f6eba74 = 0; !var_784c96b93f6eba74; var_784c96b93f6eba74 = var_df445b82bd25c0cd == firstteam) {
    if(!isDefined(targetteams[var_df445b82bd25c0cd])) {
      break;
    }

    var_df445b82bd25c0cd = targetteams[var_df445b82bd25c0cd];
    var_3ff67a12ccb276b6[var_3ff67a12ccb276b6.size] = var_df445b82bd25c0cd;
  }

  return var_3ff67a12ccb276b6;
}

function function_fab4e7780ef914f6(clusters, var_eaa7164d06855f8e, var_2778b8bc11fe3036) {
  if(getdvarint(@ "hash_e36b1d2f6f9475cd", 0) == 0) {
    return;
  }

  stats = function_6ced8fdf830b1034(clusters, var_eaa7164d06855f8e, var_2778b8bc11fe3036);
  function_7318a0f9053bacd9(stats);
}

function function_6ced8fdf830b1034(clusters, var_eaa7164d06855f8e, var_2778b8bc11fe3036) {
  stats = spawnStruct();
  stats.var_b497e09f4d314e15 = clusters.size;
  stats.var_2889fc4347ed4940 = 0;

  if(var_2778b8bc11fe3036) {
    var_b2f484f1b7f3ddcd = clusters[clusters.size - 1];
    stats.var_2889fc4347ed4940 = var_b2f484f1b7f3ddcd.teams.size;
  }

  stats.var_3cf0a32fba38f63d = var_eaa7164d06855f8e - stats.var_2889fc4347ed4940;
  var_82e3ea9d06644e3c = [];

  foreach(cluster in clusters) {
    var_82e3ea9d06644e3c[var_82e3ea9d06644e3c.size] = cluster.teams.size;
  }

  stats.var_ce51ec5181bba29 = array_sort_with_func(var_82e3ea9d06644e3c, &function_75e57b4ca2e7c32f);
  stats.var_c68617668faaa75 = array_average(stats.var_ce51ec5181bba29);
  var_49635221073c3e59 = int(floor(stats.var_ce51ec5181bba29.size / 2));

  if(stats.var_ce51ec5181bba29.size % 2 != 0) {
    stats.var_a76e2078b4cb0e2 = stats.var_ce51ec5181bba29[var_49635221073c3e59];
  } else {
    var_b9c1be3b0cb82965 = stats.var_ce51ec5181bba29[var_49635221073c3e59] + stats.var_ce51ec5181bba29[var_49635221073c3e59 - 1];
    stats.var_a76e2078b4cb0e2 = var_b9c1be3b0cb82965 / 2;
  }

  return stats;
}

function function_7318a0f9053bacd9(stats) {
  logstring("-----------------------------------------------------");
  logstring("Public Event Bounty Royale - Clustering Statistics :");
  logstring("-----------------------------------------------------");
  logstring("Isolated Squads Remaining: " + stats.var_2889fc4347ed4940);
  logstring("Isolated Squads Merged with nearby Clusters: " + stats.var_3cf0a32fba38f63d);
  logstring("---------------------");
  arraystr = "[ ";
  index = 0;

  foreach(size in stats.var_ce51ec5181bba29) {
    arraystr += size;

    if(index == stats.var_ce51ec5181bba29.size - 1) {
      arraystr += " ]";
    } else {
      arraystr += ", ";
    }

    index++;
  }

  logstring("Cluster sizes: " + arraystr);
  logstring("MedianCluster Size: " + stats.var_a76e2078b4cb0e2);
  logstring("Average Cluster Size: " + stats.var_c68617668faaa75);
  logstring("-----------------------------------------------------");
}

function function_181b305cacc42fd4() {}

function function_e90e55f9a402be98() {
  var_25a9983ace778b7a = function_3de5d12dc8b41598();

  if(var_25a9983ace778b7a.size <= 1) {
    return;
  }

  var_81bb7c792c1b40d2 = function_69c091a3d7584cf6(var_25a9983ace778b7a);
  logstring("<dev string:x114>");
  function_bf5778d86600b130(var_81bb7c792c1b40d2);
  var_b6970f580273b509 = [];
  level.var_aab4fba7a041b281 = [];

  foreach(team in var_25a9983ace778b7a) {
    hunterplayers = getteamdata(team, "<dev string:x14e>");
    mainplayer = array_random(hunterplayers);
    targetteam = scripts\mp\gametypes\br_assassination_quest::determinetargetteam(mainplayer, 0);

    if(isDefined(targetteam)) {
      var_e7f4a3dc0faa357 = scripts\mp\utility\teams::getteamdata(targetteam, "<dev string:x159>");
      targetplayer = array_random(var_e7f4a3dc0faa357);
      var_b6970f580273b509[team] = targetplayer;
      level.var_aab4fba7a041b281 = array_combine(level.var_aab4fba7a041b281, getteamdata(targetteam, "<dev string:x14e>"));
    }
  }

  logstring("<dev string:x169>");
  function_bf5778d86600b130(var_b6970f580273b509);
  logstring("<dev string:x1a3>");
  var_ae621fbe64621de3 = function_a2ff10734881cdd8(var_25a9983ace778b7a);
  function_bf5778d86600b130(var_ae621fbe64621de3);
}

function function_9c47b0e02f2fb63b() {
  level notify("<dev string:x1dd>");
  var_25a9983ace778b7a = function_3de5d12dc8b41598();

  if(var_25a9983ace778b7a.size <= 1) {
    return;
  }

  interval = 3;
  arraystr = "<dev string:x1ee>";
  iprintln(var_25a9983ace778b7a.size + "<dev string:x1f4>");

  foreach(index, team in var_25a9983ace778b7a) {
    targetorigin = function_a65ee7e93ee569ec(level.player);

    if(!isDefined(targetorigin)) {
      continue;
    }

    function_e1765107c6062def(team, targetorigin);
    arraystr += targetorigin;
    iprintln("<dev string:x20b>" + index + "<dev string:x215>");

    if(index == var_25a9983ace778b7a.size - 1) {
      arraystr += "<dev string:x221>";
      iprintln("<dev string:x226>");
      continue;
    }

    arraystr += "<dev string:x237>";
    wait interval;
  }

  logstring("<dev string:x23d>" + arraystr);
}

function function_a65ee7e93ee569ec(player) {
  start = player getEye();
  dir = anglesToForward(player getplayerangles());
  end = start + 10000 * dir;
  trace = scripts\engine\trace::_bullet_trace(start, end, 1, player);

  if(isDefined(trace["<dev string:x268>"])) {
    return trace["<dev string:x268>"];
  }

  return undefined;
}

function function_e1765107c6062def(team, position) {
  players = scripts\mp\utility\teams::getteamdata(team, "<dev string:x159>");

  foreach(player in players) {
    if(player == level.player) {
      continue;
    }

    player setOrigin(position, 1);
  }

  thread function_8c25d42d610355de(position);
}

function function_2bddf385f85e7c5d(label) {
  var_53d74bcd85781325 = undefined;

  switch (label) {
    case #"hash_e9493e5d95d774aa":
      var_53d74bcd85781325 = [(-1052.69, 10020, 651.875), (-3539.9, 4300.11, 605.372), (727.52, 1998.89, 1199.66), (2277.98, 6429.02, 448.039), (552.215, 8078.68, 837.956)];
      break;
    case #"hash_293711302205da35":
      var_53d74bcd85781325 = [(-159.593, 75.772, 1760), (-2201.92, -355.116, 1125.83), (-3498.79, -5067.24, 667.843), (-1609.7, -6951.33, 712.645), (247.739, -3322.97, 1710), (2033.68, -6202.4, 699.789), (-1820.81, -11595.6, 178.062), (3312.2, -3250.82, 1071.72)];
      break;
    case #"hash_38aa36fd797a4eac":
    default:
      var_53d74bcd85781325 = [(836.468, -5859.08, 693.534), (-225.287, -8624.61, 300), (-1370.39, -7809.29, 400), (2985.37, -6358.27, 955.228), (2373.81, -4321.44, 711.252), (-473.395, -3156.1, 1256.47), (-2716.84, -5003.01, 690.154), (161.867, 7979.81, 839.459), (-1599.72, 7205.77, 879.5), (-1398.86, 9328.75, 1155.79), (1445.23, 6487.11, 579.167), (-2599.62, 5931.11, 879.5), (-4654.95, 545.391, 716.307), (2675.77, 856.257, 784), (2636.01, 1981.71, 485.667), (4174.29, -79.9519, 223.119)];
      break;
  }

  if(!isDefined(var_53d74bcd85781325)) {
    return;
  }

  positionindex = 0;

  foreach(team in level.teamnamelist) {
    if(function_1c7625817533665d(team)) {
      continue;
    }

    position = var_53d74bcd85781325[positionindex];
    function_e1765107c6062def(team, position);
    positionindex++;

    if(positionindex >= var_53d74bcd85781325.size) {
      return;
    }
  }
}

function function_8c25d42d610355de(position) {
  if(getdvarint(@ "hash_abd886dfdd042260", 0) == 0) {
    return;
  }

  level endon("<dev string:x2b4>");
  level endon("<dev string:x1dd>");
  radius = level.pe_bountyroyale.var_330b0c607f159f0f;
  height = (0, 0, 2);
  yellow = (1, 1, 0);
  red = (1, 0, 0);

  while(true) {
    waitframe();
    cylinder(position - height, position + height, radius, yellow, 1, 1);
    sphere(position, 50, red, 0, 1);
  }
}

function function_4d4fe2c60744d274(clusters, var_5fd6ab1863ef6405, redraw) {
  if(getdvarint(@ "hash_abd886dfdd042260", 0) == 0) {
    return;
  }

  if(istrue(redraw)) {
    level notify("<dev string:x1dd>");
  }

  level endon("<dev string:x2b4>");
  level endon("<dev string:x1dd>");
  radius = level.pe_bountyroyale.var_330b0c607f159f0f;
  height = (0, 0, 1);
  orange = (1, 0.7, 0);
  red = (1, 0, 0);
  cyan = (0, 1, 1);

  while(true) {
    foreach(cluster in clusters) {
      position = cluster.centroid;

      if(cluster.teams.size == 1) {
        sphere(position, 100, cyan, 0, 1);
        continue;
      } else {
        sphere(position, 100, orange, 0, 1);
        cylinder(position, position + height, radius, orange, 0, 1);
      }

      foreach(team in cluster.teams) {
        squadcenter = var_5fd6ab1863ef6405[team];
        sphere(squadcenter, 50, red, 0, 1);
        line(position, squadcenter, red);
      }
    }

    waitframe();
  }
}

function debuginit() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x2c2>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x2da>", "<dev string:x2eb>", &function_322fa7dcd1148f78);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_5f7d3196cec2877d);
  thread function_1e10e8848dd2fbf8();
}

function function_1e10e8848dd2fbf8() {
  if(getdvarint(@ "hash_7e63edb898a7cdc6", 0) == 0) {
    return;
  }

  drawheight = 2000;
  var_c99501b545887139 = -20000;
  var_c97113b545601e17 = 20000;

  while(true) {
    for(i = -4; i < 5; i++) {
      factor = level.pe_bountyroyale.var_330b0c607f159f0f * 2 * i;
      begin = (factor, var_c99501b545887139, drawheight);
      end = (factor, var_c97113b545601e17, drawheight);
      line(begin, end, (0, 1, 0));
      begin = (var_c99501b545887139, factor, drawheight);
      end = (var_c97113b545601e17, factor, drawheight);
      line(begin, end, (0, 1, 0));
    }

    waitframe();
  }
}

function function_322fa7dcd1148f78() {
  function_2907d01a7d692108(%"bountyroyale");
  level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98(%"bountyroyale");
}

function function_9c7c4b2892d5b6db(bit) {
  level notify("<dev string:x307>");
  level endon("<dev string:x2b4>");
  level endon("<dev string:x307>");
  team = level.player.team;
  function_a4264edac412fc8b(team, bit);
  wait 3;
  function_a4264edac412fc8b(team, 0);
}

function function_34c076b99e090d44(team) {
  foreach(player in getteamdata(team, "<dev string:x14e>")) {
    if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() || !scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }

    victimname = scripts\mp\gametypes\br_dev::function_5d92949cc218ebdd(player.name);
    scripts\mp\gametypes\br_dev::function_5b5ab8ab53c49d4d(victimname, undefined);
  }
}

function private function_5f7d3196cec2877d(command, args) {
  if(args.size == 0) {
    return;
  }

  if(command != "<dev string:x315>") {
    return;
  }

  command = args[0];

  if(!isDefined(level.player)) {
    return;
  }

  switch (command) {
    case #"hash_9710f96c58beeaaa":
      function_322fa7dcd1148f78();
      break;
    case #"hash_94d1828f12087b7b":
      function_2907d01a7d692108(%"bountyroyale");
      function_1739cfa5c3d3c5c1();
      break;
    case #"hash_bdb14d744104f90f":
      thread function_9c47b0e02f2fb63b();
      break;
    case #"hash_9c2be183fd2f9f7e":
      label = "<dev string:x342>";

      if(isDefined(args[1])) {
        label = args[1];
      }

      function_2bddf385f85e7c5d(label);
      break;
    case #"hash_851b0b40030f9694":
      function_e90e55f9a402be98();
      break;
    case #"hash_213e6f6c1b36e710":
      bit = 0;

      if(isDefined(args[1])) {
        bit = int(args[1]);
      }

      thread function_9c7c4b2892d5b6db(bit);
      break;
    case #"hash_5bb99c2d99b504f6":
      targetteam = level.player.team;
      var_6b4aa84a795a9e05 = level.pe_bountyroyale.var_a96c1e1bb32b7f6e[targetteam];
      var_8e264a7a7f2c12d7 = var_6b4aa84a795a9e05.var_9cf547d1047108a2;

      foreach(team in var_8e264a7a7f2c12d7) {
        if(!isDefined(team)) {
          continue;
        }

        function_34c076b99e090d44(team);
      }

      break;
    default:
      break;
  }
}

# /