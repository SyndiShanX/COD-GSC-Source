/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_77ef69f7e5e9416b.gsc
*************************************************/

#using script_25c7a5935190c3f0;
#using script_64acb6ce534155b7;
#using script_728ffcee8cbf30ee;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\dev;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_lootchopper;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\teams;
#namespace namespace_a42d57d98410ffa8;

function autoexec main() {
  utility::registersharedfunc("elite_chopper", "get_contract_data", &getcontractdata);
}

function getcontractdata(data) {
  quest_init();
  data.funcs["onInit"] = &function_e05bdb2a6122fe4a;
  data.funcs["onTeamAssigned"] = &function_89e3fc49199d2019;
  data.funcs["onCancel"] = &task_oncancel;
  data.funcs["onPlayerTearDown"] = &function_30ff47cffe7fca99;
  data.funcs["onPlayerAssimilated"] = &function_e16cc4efa3a21aad;
  data.funcs["onEliteTearDown"] = &function_63f50da280099f3f;
  data.funcs["onPlayerRespawn"] = &namespace_2d7f47b19ccdb41d::function_dcf3929e77fe1de9;
}

function quest_init() {
  function_adc3c411e839c811();
  function_63ede2e37ad0a069();
  function_89538dc128a24e58();

  function_5dee7155086e9ada();
}

function function_adc3c411e839c811() {
  level.var_a42d57d98410ffa8 = spawnStruct();
  level.var_a42d57d98410ffa8.enabled = getdvarint(@ "hash_c328e9c6d2fbc848", 1);
  level.var_a42d57d98410ffa8.time = getdvarint(@ "hash_a6da41eda5e7570a", 240);
  level.var_a42d57d98410ffa8.chopperhealth = getdvarint(@ "hash_cbe277634708ac85", 3000);
  level.var_a42d57d98410ffa8.splashenabled = getdvarint(@ "hash_65f03a19129db21a", 0);
  level.var_a42d57d98410ffa8.empdamage = getdvarint(@ "hash_fe02b74d320eecf9", 750);
}

function function_63ede2e37ad0a069() {
  namespace_7921f301da16c1ba::init();
  level.var_a83a4e71446bfef7 = 1;
  utility::registersharedfunc("br_elitechopper", "eliteChopper_onCrateUse", &function_a1ea17b3a2931b82);
  utility::registersharedfunc("loot_chopper", "explode", &function_b23ee16dc2a2e1ac);
}

function function_89538dc128a24e58() {
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_elite_chopper_heli_arrive"] = "cqsh_grav_c2st";
  game["dialog"]["mission_elite_chopper_heli_destroy"] = "cqsh_grav_c2cl";
  game["dialog"]["mission_elite_chopper_heli_depart"] = "srcs_grav_sshp";
}

function function_5dee7155086e9ada() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x26>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x48>", "<dev string:x63>", &function_1c35bcf919ecbf37);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x7a>", "<dev string:x8c>", &function_3f460c87ff0d374);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:xa3>", "<dev string:xb3>", &function_d9f3e7f2b05c8ed9);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:xcb>", "<dev string:xda>", &function_5c2f254d18707855);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_8d032f436b816d9d(success) {
  self notify("task_ended");
  self.ended = 1;
  thread function_8af2a0d1c41847e3();
  wait 1;
  endcontract(ter_op(istrue(success), self.teams[0], undefined));
}

function function_e05bdb2a6122fe4a() {
  if(!level.var_a42d57d98410ffa8.enabled) {
    return false;
  }

  return true;
}

function function_89e3fc49199d2019() {
  self.category = "elite_chopper";
  teamname = self.teams[0];
  function_c28cf680f4d0d4dc(teamname);
  function_b76f3380abd30d8e();
}

function function_30ff47cffe7fca99(player, oldteam, newteam) {
  if(oldteam == self.teams[0]) {
    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(oldteam, level.contractmanager.defaultfilter)) {
      thread task_oncancel(oldteam);
      return;
    }

    player uiobjectivehide();
    objective_removeclientfrommask(self.objectiveiconid, player);
  }
}

function function_e16cc4efa3a21aad(player, oldteam, newteam) {
  if(!isDefined(self.vehicle)) {
    return;
  }

  if(newteam == self.teams[0]) {
    objective_addclienttomask(self.objectiveiconid, player);
    player uiobjectiveshow("elite_chopper");
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }
}

function task_oncancel(team) {
  if(istrue(self.teams[0] == team)) {
    thread function_8d032f436b816d9d(0);
  }
}

function function_c28cf680f4d0d4dc(team) {
  uiobjectiveshowtoteam("elite_chopper", team);

  if(level.var_a42d57d98410ffa8.splashenabled) {
    displayteamsplash(team, "br_elite_chopper_start");
  }

  displaysquadmessagetoteam(team, self.var_d154ac2657c5f44, 6, getquestindex("elite_chopper"));
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_elite_chopper_heli_arrive", self.teams[0], undefined, 2);
}

function function_b76f3380abd30d8e() {
  function_e2674314764bdf3();
}

function function_e2674314764bdf3() {
  circlecenter = undefined;
  circleradius = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    circlecenter = scripts\mp\gametypes\br_circle::getnextsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getnextsafecircleradius();
  }

  circleinfo = scripts\mp\gametypes\br_lootchopper::lootchopper_initcircleinfo(circlecenter, circleradius);
  spawnzones = function_a74aae7b461714e1(circleinfo);
  var_35039a9883ab69d2 = getdvarint(@ "hash_ca56ccb8d0de7869", 8000);
  patrolzone = spawnzones[randomint(spawnzones.size)];
  newchopper = scripts\mp\gametypes\br_lootchopper::lootchopper_spawn(patrolzone, "veh9_mil_air_heli_hind_nophysics_br", "veh9_mil_air_heli_hind_nuke_weapons", "chopper_support_turret_elite");

  if(isDefined(newchopper)) {
    newchopper.lootfunc = &task_dropcrate;
    newchopper.gettargetfunc = &function_915ba9b028110d40;
    newchopper.var_aa6fe6af4cbbdd47 = &function_eaba3c7180d49bdc;
    newchopper.health = level.var_a42d57d98410ffa8.chopperhealth;
    newchopper.maxhealth = level.var_a42d57d98410ffa8.chopperhealth;
    scripts\mp\objidpoolmanager::update_objective_icon(newchopper.objectiveiconid, "ui_mp_br_mapmenu_icon_elite_chopper");
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(newchopper.objectiveiconid, &"VEHICLES/NUCLEAR_CHOPPER");
    scripts\mp\objidpoolmanager::update_objective_setbackground(newchopper.objectiveiconid, 1);
    scripts\mp\objidpoolmanager::function_846c2acd91309cd8(newchopper.objectiveiconid, 246, 192, 72);
    newchopper.scriptedobjid = newchopper.objectiveiconid;
    self.objectiveiconid = newchopper.objectiveiconid;
    newchopper vehicleunpingable(1);
    thread function_b012a5a56983477(newchopper);
    newchopper.task = self;
    self.chopper = newchopper;
    return;
  }

  logstring("br_elite_chopper_quest::task_spawnChopper - no chopper was spawned!");

  if(getdvarint(@ "hash_3e40b4675d05b5b1", 1)) {
    cratestruct = spawnStruct();
    cratestruct.origin = (circlecenter[0], circlecenter[1], 10000);
    cratestruct.task = self;
    cratestruct task_dropcrate();
  }
}

function function_a74aae7b461714e1(circleinfo) {
  var_8bc6e10ea09fe64 = [];
  var_a43491919a0d6a88 = scripts\mp\gametypes\br_lootchopper::lootchopper_getspawnlocations(circleinfo);

  if(var_a43491919a0d6a88.size == 0) {
    chopperspawn = spawnStruct();
    chopperspawn.origin = circleinfo.center;
    var_a43491919a0d6a88[0] = chopperspawn;
  }

  foreach(spawnzone in var_a43491919a0d6a88) {
    spawnzone.origin *= (1, 1, 0);
    spawnzone.origin = scripts\mp\gametypes\br::getoffsetspawnoriginmultitrace(spawnzone.origin, (0, 0, 10000));
    var_8bc6e10ea09fe64[var_8bc6e10ea09fe64.size] = spawnzone;
  }

  return var_8bc6e10ea09fe64;
}

function function_915ba9b028110d40() {
  targets = [];

  foreach(info in level.arrow.teaminfo) {
    players = scripts\mp\utility\teams::getteamdata(info.targetteam, "players");

    foreach(player in players) {
      targets[targets.size] = player;
    }
  }

  return targets;
}

function function_eaba3c7180d49bdc(damagedata) {
  attacker = damagedata.attacker;
  self dodamage(level.var_a42d57d98410ffa8.empdamage, attacker.origin, attacker, attacker, "MOD_EXPLOSIVE", attacker.currentprimaryweapon);
}

function function_b23ee16dc2a2e1ac(damagedata, immediate) {
  attacker = damagedata.attacker;
  self dodamage(self.maxhealth, attacker.origin, attacker, attacker, "MOD_EXPLOSIVE", undefined);
}

function task_dropcrate() {
  chopper = self;
  droplocation = scripts\mp\gametypes\br_lootchopper::lootchopper_finddroplocation(chopper.origin + (0, 0, 500));
  crate = scripts\cp_mp\killstreaks\airdrop::function_4671cbee65d1615d(chopper.origin, droplocation);

  if(isDefined(crate)) {
    task = chopper.task;
    crate.task = task;
    task.crate = crate;
  }
}

function function_a1ea17b3a2931b82(player) {
  task = self.task;
  task notify("task_ended");
  task endcontract(task.teams[0]);
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropinfo = spawnStruct();
  dropinfo.origin = self.origin + (0, 0, 10);
  dropinfo.angles = self.angles;
  dropinfo.itemsdropped = 0;
  items = getscriptcachecontents("br_elite_chopper_crate");

  if(isDefined(items)) {
    pickupents = dropinfo scripts\mp\gametypes\br_lootcache::lootspawnitemlist(dropstruct, items, 0, player);
  }

  team = self.task.teams[0];
  element = namespace_6c622b52017c6808::function_f517a8eefb0eb61a(team);
  namespace_6c622b52017c6808::function_cc25131864fa213c(team, dropinfo.origin, dropinfo.angles, element, dropstruct);
}

function function_b012a5a56983477(newchopper) {
  level endon("game_ended");
  self endon("task_ended");
  newchopper waittill("death");

  if(level.var_a42d57d98410ffa8.splashenabled) {
    displayteamsplash(self.teams[0], "br_elite_chopper_end");
  }

  uiobjectiveshowtoteam("elite_chopper_loot", self.teams[0]);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_elite_chopper_heli_destroy", self.teams[0], undefined, 8.5);
}

function function_8af2a0d1c41847e3() {
  if(checkforactiveobjicon()) {
    deletequestobjicon();
    self.objectiveiconid = undefined;
  }

  if(isDefined(self.chopper)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_elite_chopper_heli_depart", self.teams[0], 1, 2, undefined);
  }
}

function function_63f50da280099f3f(team) {
  task = self;

  if(isDefined(task.chopper)) {
    task.chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_leave();
  }

  if(isDefined(task.crate)) {
    task.crate scripts\cp_mp\killstreaks\airdrop::destroycrate(1);
  }
}

function function_d9f3e7f2b05c8ed9() {
  function_e2674314764bdf3();
}

function function_5c2f254d18707855() {
  cratestruct = spawnStruct();
  cratestruct.origin = (level.player.origin[0], level.player.origin[1], 10000);
  cratestruct.task = spawnStruct();
  cratestruct.task.iselite = 1;
  cratestruct.task.type = spawnStruct();
  cratestruct.task.type.ref = "<dev string:xee>";
  cratestruct.task.type.index = 0;
  cratestruct.task.teams[0] = level.player.team;
  level.contractmanager.var_b6fae9c9655c73bf[level.player.team] = 1;
  level.var_81e77c935dfefd11.teaminstances[level.player.team] = spawnStruct();
  level.var_81e77c935dfefd11.teaminstances[level.player.team].index = 2;
  level.var_81e77c935dfefd11.teaminstances[level.player.team].startertask = spawnStruct();
  level.var_81e77c935dfefd11.teaminstances[level.player.team].len = 3;
  level.var_81e77c935dfefd11.teaminstances[level.player.team].ref = "<dev string:xff>";
  level.arrow.teaminfo[level.player.team] = spawnStruct();
  level.arrow.teaminfo[level.player.team].targetteam = level.player.team;
  level.arrow.teaminfo[level.player.team].state = 2;
  level.arrow.teaminfo[level.player.team].firstpickups = 0;
  level.arrow.teaminfo[level.player.team].var_876be3bc4df3a81d = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x108>"] = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x10f>"] = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x116>"] = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x11d>"] = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x124>"] = 0;
  level.arrow.teaminfo[level.player.team].var_8dfd9e71543b605b["<dev string:x12b>"] = 0;
  cratestruct task_dropcrate();
}

function function_1c35bcf919ecbf37() {
  host = scripts\mp\dev::devfindhost();
  println("<dev string:x132>");
  println("<dev string:x156>");
  println("<dev string:x176>" + level.var_a42d57d98410ffa8.enabled);
  println("<dev string:x199>" + level.var_a42d57d98410ffa8.time);
  println("<dev string:x1bc>" + level.var_a42d57d98410ffa8.chopperhealth);
  println("<dev string:x132>");
}

function function_3f460c87ff0d374() {
  setDvar(@ "hash_fbd8d42235a256d6", 1);
}

# /