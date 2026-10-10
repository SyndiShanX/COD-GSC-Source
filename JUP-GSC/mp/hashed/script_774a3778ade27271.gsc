/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_774a3778ade27271.gsc
*************************************************/

#using script_135f13d8aa1c1f19;
#using script_261e315c49e5e4ef;
#using script_64acb6ce534155b7;
#using script_728ffcee8cbf30ee;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\dev;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\teams;
#namespace namespace_5b571ef9950b8a9e;

function autoexec main() {
  utility::registersharedfunc("elite_resurgence", "get_contract_data", &getcontractdata);
  utility::registersharedfunc("elite_arrow_resurgence", "get_contract_data", &namespace_6c622b52017c6808::getcontractdata);
}

function getcontractdata(data) {
  quest_init();
  data.funcs["onInit"] = &function_e05bdb2a6122fe4a;
  data.funcs["onTeamAssigned"] = &function_89e3fc49199d2019;
  data.funcs["onCancel"] = &task_oncancel;
  data.funcs["onPlayerTearDown"] = &function_30ff47cffe7fca99;
  data.funcs["onPlayerAssimilated"] = &function_e16cc4efa3a21aad;
  data.funcs["onPlayerKilled"] = &task_onplayerkilled;
  data.funcs["onEliteTearDown"] = &function_63f50da280099f3f;
  data.funcs["getOnEliteDropQuestPayload"] = &function_2601f6b6db6b0e60;
  data.funcs["onPlayerRespawn"] = &namespace_2d7f47b19ccdb41d::function_dcf3929e77fe1de9;
  scripts\engine\utility::registersharedfunc("eliteArrow", "getBombsiteScriptable", &function_e7799b3ad0d7b9fd);
}

function function_e7799b3ad0d7b9fd() {
  gametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(gametype == "resurgence" && level.arrow.elementorder[0] == "ber" && level.arrow.elementorder[1] == "nep" && level.arrow.elementorder[2] == "tri") {
    return "brloot_elite_arrow_bombsite_resurgence";
  }

  return undefined;
}

function quest_init() {
  function_adc3c411e839c811();
  function_63ede2e37ad0a069();
  function_89538dc128a24e58();

  function_5dee7155086e9ada();
}

function function_adc3c411e839c811() {
  level.var_5b571ef9950b8a9e = spawnStruct();
  level.var_5b571ef9950b8a9e.enabled = getdvarint(@ "hash_84f986c445eddc92", 1);
  level.var_5b571ef9950b8a9e.splashenabled = getdvarint(@ "hash_bd51e15ac642c7ac", 0);
  level.var_5b571ef9950b8a9e.var_ca3030ba010b4931 = getdvarint(@ "hash_ef181ed4a0003ccb", 1);
  level.var_5b571ef9950b8a9e.var_85713cd02f5c4052 = getdvarfloat(@ "hash_c08eafc166c9f3f0", 0.9);
  level.var_5b571ef9950b8a9e.var_b7c8a04fbbf0d563 = getdvarint(@ "hash_9883680b3d43a62", 30);
  level.var_5b571ef9950b8a9e.lootcache = 0;
  function_6bc368988ece01a8();
}

function function_6bc368988ece01a8() {
  level.var_5b571ef9950b8a9e.time = getdvarint(@ "hash_e79dedeff3865070", function_ea591c2a379e3424("elite_resurgence"));
  times = [];
  times[times.size] = getdvarint(hashcat(@ "hash_e79dedeff3865070", "_solos"), 260);
  times[times.size] = getdvarint(hashcat(@ "hash_e79dedeff3865070", "_duos"), 390);
  times[times.size] = getdvarint(hashcat(@ "hash_e79dedeff3865070", "_trios"), 485);
  times[times.size] = getdvarint(hashcat(@ "hash_e79dedeff3865070", "_quads"), 605);
  level.var_5b571ef9950b8a9e.times = times;
}

function function_63ede2e37ad0a069() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onResurgenceScoreworthyModifier", &function_c2e05bfedcc7179b);
  scripts\common\callbacks::add("br_supply_drops_init", &function_86eb339b3311543b);
  function_80f90963ddf8341c();
}

function function_89538dc128a24e58() {
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["arrow_first_timer"] = "recq_grav_q1ta";
  game["dialog"]["arrow_generic_timer"] = "recq_grav_cqgt";
}

function function_86eb339b3311543b(params) {
  dropstruct = scripts\mp\gametypes\br_supply_drops_common::function_69b2e5235bfb7998("br_elite_resurgence_element_drop", "ks_airdrop_crate_br");
  dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_elite_resurgence_element_drop", "planeDropRun", &namespace_f51c41a139e03299::function_4583dcd65450a629);
  dropstruct scripts\mp\gametypes\br_supply_drops_common::function_80e49e34fc8d70b8("br_elite_resurgence_element_drop", "spawnDropCrate", &task_dropcrate);
  dropstruct function_3719308fbf3bd1db();
}

function function_3719308fbf3bd1db() {
  dropstruct = self;
  dropstruct.var_2e0d8ba0a46ce1b1 = 1;
  dropstruct.var_3077f6d3d97bb34b = getdvarint(@ "hash_703ddc426e89229a", 1000);
  dropstruct.var_3c3ed534c61a56e4 = getdvarint(@ "hash_5424b1706e3a3b09", 100);
  dropstruct.var_9612b650d147f458 = getdvarint(@ "hash_fd2c28af75368793", 200);
  dropstruct.var_81986b2d8e843970 = getdvarint(@ "hash_8e6c23761a0d2d56", level.var_5d2af95280a3cf58 * level.var_5d2af95280a3cf58 + 1);
  dropstruct.initialmove = 0;
  dropstruct.spawnsmoke = 0;
  dropstruct.var_30daf66a65a215e7 = 1;
}

function function_5dee7155086e9ada() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x26>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4b>", "<dev string:x66>", &function_1c35bcf919ecbf37);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x7d>", "<dev string:x8f>", &function_3f460c87ff0d374);
  scripts\common\devgui::function_fe953f000498048f();
}

function quest_settimer(timerpaused) {
  newvalue = self.var_8b96f28b4b926851 + 1;

  if(istrue(timerpaused) && !istrue(self.var_7f9b5c8a7bb44c10)) {
    newvalue += 4194304;
  }

  self.var_7f9b5c8a7bb44c10 = undefined;

  if(isDefined(self.var_d40dec94520dda24)) {
    eventid = scripts\mp\rank::function_1e00d01d19fde519(self.var_d40dec94520dda24);
    isscriptbundlesplash = 0;

    if(!isDefined(eventid) || eventid < 0) {
      eventid = getscoreinfocategory(self.var_d40dec94520dda24, #"hash_edd89bb2cc2d506");
    } else {
      isscriptbundlesplash = 1;
    }

    newvalue += (isscriptbundlesplash << 10) + (eventid << 11);
  }

  teamplayers = teams::getteamdata(self.teams[0], "players");

  foreach(player in teamplayers) {
    player setclientomnvar("ui_elite_resurgence_timer", newvalue);
  }

  self.var_330ac03bfd4f17cc = undefined;
  self.var_d40dec94520dda24 = undefined;
}

function function_8d032f436b816d9d(success) {
  self notify("task_ended");
  self.ended = 1;
  thread function_8af2a0d1c41847e3();
  wait 1;
  endcontract(istrue(success) ? self.teams[0] : undefined);
}

function function_e05bdb2a6122fe4a() {
  if(!level.var_5b571ef9950b8a9e.enabled) {
    return false;
  }

  return true;
}

function function_89e3fc49199d2019() {
  self.category = "elite_resurgence";
  teamname = self.teams[0];
  function_c28cf680f4d0d4dc(teamname);
  function_b76f3380abd30d8e();

  if(isDefined(self.payload) && self.payload.type == "elite_resurgence" && isDefined(self.payload.var_8b96f28b4b926851)) {
    time = self.payload.var_8b96f28b4b926851;
    self.payload.var_8b96f28b4b926851 = undefined;
  } else {
    time = function_82579ba57b257de0(teamname);
    time = function_9b6275085fbcb8f4(time);
  }

  self.var_8b96f28b4b926851 = time;
  function_10af3c34cb23710f();
  quest_settimer();
  thread function_aee8d19f56916dd7();
}

function function_82579ba57b257de0(teamname) {
  if(isDefined(level.var_5b571ef9950b8a9e.times)) {
    players = getteamdata(teamname, "players");
    var_e0bbe74095e09884 = int(clamp(players.size - 1, 0, level.var_5b571ef9950b8a9e.times.size));
    time = level.var_5b571ef9950b8a9e.times[var_e0bbe74095e09884];

    if(isDefined(time) && time > 0) {
      return time;
    }
  }

  return level.var_5b571ef9950b8a9e.time;
}

function function_30ff47cffe7fca99(player, oldteam, newteam) {
  if(oldteam == self.teams[0]) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(oldteam, level.contractmanager.defaultfilter)) {
      thread task_oncancel(oldteam);
      return;
    }

    player uiobjectivehide();

    if(isDefined(self.objectiveiconid)) {
      objective_removeclientfrommask(self.objectiveiconid, player);
    }
  }
}

function function_e16cc4efa3a21aad(player, oldteam, newteam) {
  if(!isDefined(self.vehicle)) {
    return;
  }

  if(newteam == self.teams[0]) {
    objective_addclienttomask(self.objectiveiconid, player);
    player uiobjectiveshow("elite_resurgence");
  }
}

function task_oncancel(team) {
  if(istrue(self.teams[0] == team)) {
    thread function_8d032f436b816d9d(0);
  }
}

function function_c28cf680f4d0d4dc(team) {
  if(level.var_5b571ef9950b8a9e.splashenabled) {
    displayteamsplash(team, "br_elite_resurgence_start");
  }

  displaysquadmessagetoteam(team, self.var_d154ac2657c5f44, 6, getquestindex("elite_resurgence"));
}

function function_b76f3380abd30d8e() {}

function function_75719462a6e4937f() {}

function task_onplayerkilled(attacker, victim) {
  team = victim.team;

  if(team == self.teams[0]) {
    penalty = victim scripts\mp\gametypes\br_gametype_resurgence::getrespawndelay();
    penalty *= level.var_5b571ef9950b8a9e.var_ca3030ba010b4931;
    self.var_8b96f28b4b926851 += penalty;
    self.var_7f9b5c8a7bb44c10 = 1;
    playercount = scripts\mp\utility\teams::getteamdata(team, "teamCount");
    alivecount = scripts\mp\utility\teams::getteamdata(team, "aliveCount");
    var_ca7fce2f16d8d108 = playercount == 1 ? playercount == alivecount : playercount == alivecount + 1;
    self.var_1c936f76cb45c26b = var_ca7fce2f16d8d108 ? penalty : self.var_1c936f76cb45c26b + penalty;

    if(var_ca7fce2f16d8d108 && !function_94b58e83cf516837(team)) {
      self.var_e68564659cd968ef = gettime();
    }
  }
}

function function_63f50da280099f3f(team) {
  if(isDefined(self.crate)) {
    self.crate function_7bb18b32417b36ca();
    self.crate setscriptablepartstate(#"capture", #"fade", 0);
    self.crate setscriptablepartstate(#"visibility", #"hide", 0);
  }
}

function function_2601f6b6db6b0e60() {
  payload = spawnStruct();
  payload.type = "elite_resurgence";
  payload.time = int(max(namespace_6c622b52017c6808::function_d47c61711c9c094c(), 2));

  if(!istrue(self.var_279c65c589aab601)) {
    timer = self.var_8b96f28b4b926851;

    if(isDefined(self.var_e68564659cd968ef)) {
      timer -= gettime() - self.var_e68564659cd968ef;
    }

    timer -= self.var_1c936f76cb45c26b;
    payload.var_8b96f28b4b926851 = int(max(timer, 5));
  }

  return payload;
}

function function_aee8d19f56916dd7() {
  level endon("game_ended");
  team = self.teams[0];
  teaminfo = level.arrow.teaminfo[team];
  teaminfo endon("on_end");

  for(var_7bad97b69c3e29dd = 0; self.var_8b96f28b4b926851 > 0; var_7bad97b69c3e29dd = !var_7bad97b69c3e29dd) {
    wait 0.5;
    timerpaused = 1;
    function_10af3c34cb23710f();

    if(function_94b58e83cf516837(self.teams[0])) {
      timerpaused = 0;

      if(self.var_8b96f28b4b926851 > 0 && istrue(var_7bad97b69c3e29dd)) {
        self.var_8b96f28b4b926851 -= 1;
      }
    }

    quest_settimer(timerpaused);
  }

  function_aa9b266dda4f7272();
}

function function_10af3c34cb23710f() {
  team = self.teams[0];

  if(function_94b58e83cf516837(team)) {
    uiobjectiveshowtoteam("elite_resurgence", team);
    return;
  }

  uiobjectiveshowtoteam("elite_resurgence_loot", team);
}

function function_94b58e83cf516837(team) {
  teaminfo = level.arrow.teaminfo[team];
  return teaminfo namespace_6c622b52017c6808::function_6085101092321954();
}

function function_aa9b266dda4f7272() {
  if(istrue(self.var_111844fa2d5f6b02)) {
    return;
  }

  self.var_111844fa2d5f6b02 = 1;
  self.activeteam = self.teams[0];
  uiobjectiveshowtoteam("elite_resurgence_loot", self.activeteam);
  spawnorigin = function_9cab914019e4dbba(self.activeteam);
  plane = scripts\mp\gametypes\br_supply_drops_common::function_1a01863a6ec2ad05(spawnorigin, "br_elite_resurgence_element_drop");
  plane.task = self;
}

function function_c2e05bfedcc7179b(player, modifierstruct) {
  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }

  if(!namespace_b11d742e70949af1::function_73689348205a9057(player.team)) {
    return;
  }

  task = level.contractmanager.var_b6fae9c9655c73bf[player.team];

  if(!isDefined(task)) {
    return;
  }

  if(task.category != "elite_resurgence") {
    return;
  }

  if(!function_94b58e83cf516837(player.team)) {
    return;
  }

  task.var_8b96f28b4b926851 = int(max(0, task.var_8b96f28b4b926851 - modifierstruct.delaymodifier));

  if(isDefined(modifierstruct.event) && (!isDefined(task.var_330ac03bfd4f17cc) || modifierstruct.delaymodifier < task.var_330ac03bfd4f17cc)) {
    task.var_d40dec94520dda24 = modifierstruct.event;
    task.var_330ac03bfd4f17cc = modifierstruct.delaymodifier;
  }
}

function task_dropcrate(dropend, dropstruct) {
  team = self.task.teams[0];

  if(!namespace_6c622b52017c6808::function_2eac770cf8006e0b(team)) {
    return;
  }

  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "br_elite_resurgence_element_drop", self.origin, (0, randomfloat(360), 0), dropend);
  crate function_76c2bb391052b49d(dropend);
  crate.task = self.task;
  self.task.crate = crate;

  if(isDefined(crate.task.activeteam)) {
    function_c94f59f543708f7d(crate.task.activeteam);
  }

  return crate;
}

function function_76c2bb391052b49d(destination) {
  crate = self;

  if(!isDefined(crate)) {
    return;
  }

  crate.skipminimapicon = 1;
  crate.smokesignal = spawn("script_model", destination);
  crate.smokesignal setModel("ks_airdrop_crate_br");
  crate.smokesignal setscriptablepartstate(#"smoke_signal", #"hash_681713bdddb46d8e", 0);
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", crate.origin, "ui_mp_br_mapmenu_icon_elite_chopper_crate");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
    scripts\mp\objidpoolmanager::update_objective_onentity(objid, crate);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, &"MP/BR_CRATE_ELITE");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
    scripts\mp\objidpoolmanager::function_98ba077848896a3(objid, 1);
    scripts\mp\objidpoolmanager::function_f21e9b2e78de984b(objid, 10000, 10500);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
    scripts\mp\objidpoolmanager::function_bf66c6833e867284(objid, 15);
    crate.scriptedobjid = objid;
  }
}

function function_c94f59f543708f7d(team) {
  teaminfo = level.arrow.teaminfo[team];
  dialog = teaminfo.firstpickups > 0 ? "arrow_generic_timer" : "arrow_first_timer";
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam(dialog, team);
}

function function_9cab914019e4dbba(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");
  droppos = (0, 0, 0);

  if(players.size > 0) {
    foreach(player in players) {
      droppos += player.origin;
    }

    droppos /= players.size;
  }

  safepos = scripts\mp\gametypes\br_circle::function_177e9958fce17793(droppos, level.var_5b571ef9950b8a9e.var_85713cd02f5c4052, level.var_5b571ef9950b8a9e.var_b7c8a04fbbf0d563, 1);

  if(isDefined(safepos)) {
    droppos = safepos;
  }

  droplocation = function_ba5504c9ef2acc0(droppos + (0, 0, 500));
  return droppos;
}

function function_ba5504c9ef2acc0(starttrace) {
  droplocation = undefined;
  endtrace = starttrace - (0, 0, 20000);
  var_404ee298808e4e1b = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, undefined, var_404ee298808e4e1b);

  if(isDefined(trace) && trace["hittype"] != "hittype_none") {
    droplocation = trace["position"];
  }

  return droplocation;
}

function function_a1ea17b3a2931b82(player) {
  team = self.task.teams[0];

  if(!namespace_6c622b52017c6808::function_2eac770cf8006e0b(team)) {
    return;
  }

  task = self.task;
  task.var_279c65c589aab601 = 1;
  task notify("task_ended");
  task endcontract(team);
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropinfo = spawnStruct();
  dropinfo.origin = self.origin;
  dropinfo.angles = self.angles;
  dropinfo.itemsdropped = 0;
  items = getscriptcachecontents("br_elite_resurgence_crate", level.var_5b571ef9950b8a9e.lootcache);

  if(isDefined(items)) {
    pickupents = dropinfo scripts\mp\gametypes\br_lootcache::lootspawnitemlist(dropstruct, items, 1, player);
  }

  level.var_5b571ef9950b8a9e.lootcache = (level.var_5b571ef9950b8a9e.lootcache + 1) % 10;
  element = namespace_6c622b52017c6808::function_f517a8eefb0eb61a(team);
  namespace_6c622b52017c6808::function_cc25131864fa213c(team, dropinfo.origin, dropinfo.angles, element, dropstruct);
}

function function_8af2a0d1c41847e3() {
  if(checkforactiveobjicon()) {
    deletequestobjicon();
    self.objectiveiconid = undefined;
  }
}

function function_80f90963ddf8341c() {
  leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata("br_elite_resurgence_element_drop");
  leveldata.capturestring = &"MP/BR_CRATE_ELITE";
  leveldata.basemodel = "military_carepackage_01_elite_chopper";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = 600;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &function_71bbbcba8da1ccbc;
  leveldata.capturecallback = &function_17236ea7aa75d43b;
  leveldata.destroycallback = &function_3b0a58fc8512cd37;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
}

function function_71bbbcba8da1ccbc(isfirstactivation) {}

function function_17236ea7aa75d43b(player) {
  function_a1ea17b3a2931b82(player);
  function_7bb18b32417b36ca();
}

function function_3b0a58fc8512cd37(immediate) {
  function_7bb18b32417b36ca();
}

function function_7bb18b32417b36ca() {
  if(isDefined(self.scriptedobjid)) {
    objective_delete(self.scriptedobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.scriptedobjid);
    self.scriptedobjid = undefined;
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }
}

function function_ccd9c8a4c38baaff(position, destination) {
  crate = dropcrate(undefined, undefined, "br_elite_resurgence_element_drop", position, (0, randomfloat(360), 0), destination);
  crate function_76c2bb391052b49d(destination);
  return crate;
}

function function_1c35bcf919ecbf37() {
  host = scripts\mp\dev::devfindhost();
  println("<dev string:xa6>");
  println("<dev string:xca>");
  println("<dev string:xed>" + level.var_5b571ef9950b8a9e.enabled);
  println("<dev string:xa6>");
}

function function_3f460c87ff0d374() {
  setDvar(@ "hash_ecb5e1553c7d66d2", 1);
}

# /