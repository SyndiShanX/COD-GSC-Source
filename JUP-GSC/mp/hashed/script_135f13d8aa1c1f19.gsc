/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_135f13d8aa1c1f19.gsc
*************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\utility\teams;
#namespace quest_chain;

function private autoexec __init__system__() {
  system::register(#"quest_chain", undefined, undefined, &post_main);
}

function post_main() {
  if(!isDefined(level.brgametype)) {
    return;
  }

  if(getdvarint(@ "hash_82bde055b11e6698", 0) || !getdvarint(@ "hash_33dfb5a00b144fa9", 1)) {
    return;
  }

  level thread initinternal();
}

function initinternal() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  initleveldata();
  setupcallbacks();
  function_b92559336d4290b3();
}

function initleveldata() {
  assertex(!isDefined(level.var_81e77c935dfefd11), "<dev string:x1c>");
  level.var_81e77c935dfefd11 = spawnStruct();
  level.var_81e77c935dfefd11.var_c25435bfa70e9a13 = [];
  level.var_81e77c935dfefd11.activechains = [];
  level.var_81e77c935dfefd11.teaminstances = [];
  level.var_81e77c935dfefd11.waittime = getdvarfloat(@ "hash_9170c7bf6eebab04", 5);
  level.var_81e77c935dfefd11.var_e9dd7fb12175053e = getdvarint(@ "hash_9f9977b7c37ebb8f", 1);
}

function setupcallbacks() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("contractStart", &oncontractstart);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("contractEnd", &oncontractend);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("giveQuestRewardGroup", &function_d75b66b46e0f7273);
}

function function_b92559336d4290b3() {
  assertex(isDefined(level.var_81e77c935dfefd11), "<dev string:x4c>");

  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  var_9c40921d9034f99b = getdvarint(@ "hash_27fa6ed1a82a8436", 4);

  switch (var_9c40921d9034f99b) {
    case 6:
      registerquestchain("elite", ["vip", "vip", "vip"], 0);
      break;
    case 5:
      registerquestchain("elite", ["elite_resurgence", "elite_resurgence", "elite_resurgence"], 0);
      break;
    case 4:
      registerquestchain("elite", ["elite_geiger", "safecracker", "elite_chopper"], 0);
      break;
    case 3:
      registerquestchain("elite", ["elite_chopper", "elite_geiger", "safecracker"], 0);
      break;
    case 2:
      registerquestchain("elite", ["safecracker", "elite_geiger", "elite_chopper"], 0);
      break;
    case 1:
      registerquestchain("elite", ["safecracker", "vip", "elite_chopper"], 0);
      break;
    default:
      registerquestchain("elite", ["scavenger", "vip", "intel"], 0);
      break;
  }
}

function registerquestchain(var_aae4896d02056ac3, var_56f390f17fee5add, flags) {
  assertex(isDefined(level.var_81e77c935dfefd11), "<dev string:x4c>");

  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  level.var_81e77c935dfefd11.var_c25435bfa70e9a13[var_aae4896d02056ac3] = var_56f390f17fee5add;
}

function function_8fb6c06939b794d7(var_aae4896d02056ac3, var_2d9fd7df778267bb, var_f9ef42f2b5483a4f, var_9ded4c314cb8356d, var_645d7335913d50bb, var_aba46302334934ac, var_8f125b44d04fac42) {
  assertex(isDefined(level.var_81e77c935dfefd11), "<dev string:x4c>");

  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  task = self.task;

  if(!isDefined(task)) {
    return;
  }

  array = level.var_81e77c935dfefd11.var_c25435bfa70e9a13[var_aae4896d02056ac3];
  task.questchain = spawnStruct();
  task.questchain.ref = var_aae4896d02056ac3;
  task.questchain.index = -1;
  task.questchain.len = array.size;
  task.questchain.dropcount = 0;
  task.questchain.var_3ecdcdbc9f0b5fe0 = var_2d9fd7df778267bb;
  task.questchain.var_ce5b38ccbacff64 = var_f9ef42f2b5483a4f;
  task.questchain.var_d6a940bdd49c18ca = var_9ded4c314cb8356d;
  task.questchain.var_cede041f1b6728e0 = var_645d7335913d50bb;
  task.questchain.var_d75b66b46e0f7273 = var_aba46302334934ac;
  task.questchain.var_6091d72afc11f381 = var_8f125b44d04fac42;
  task.questchain.startertask = task;
}

function oncontractstart(task, team) {
  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  if(function_15130df1ddac6787(task)) {
    level thread function_95241846d4382372(task, team);
  }
}

function oncontractend(task, team, success) {
  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  if(function_73689348205a9057(team)) {
    questchain = level.var_81e77c935dfefd11.teaminstances[team];

    if(task == questchain.startertask) {
      level thread function_9f181ae293d9b65f(task, team, success);
      return;
    }

    level thread function_e447c95f657d5325(task, team, success);
  }
}

function function_9f181ae293d9b65f(task, team, success) {
  function_26f3066ca0cd1957(task, team, success);
  questchain = function_c6ec58a3c19cd74d(team);
  assertex(isDefined(questchain), "<dev string:x77>");

  if(isDefined(questchain.var_6091d72afc11f381) && isfunction(questchain.var_6091d72afc11f381)) {
    task[[questchain.var_6091d72afc11f381]](team, success);
  }

  level.var_81e77c935dfefd11.activechains = array_remove(level.var_81e77c935dfefd11.activechains, questchain);
  level.var_81e77c935dfefd11.teaminstances[team] = undefined;
}

function function_e447c95f657d5325(task, team, success) {
  level endon("game_ended");
  questchain = function_c6ec58a3c19cd74d(team);
  assertex(isDefined(questchain), "<dev string:xc0>");

  if(istrue(success)) {
    if(level.var_81e77c935dfefd11.var_e9dd7fb12175053e) {
      questchain.var_e9405cee0a584dea = 1;
      questchain waittill("reward_pickup", reward);
      questchain.var_e9405cee0a584dea = undefined;
      function_3dd1a630275d19af(team);
    }
  }

  level.contractmanager.var_b6fae9c9655c73bf[team] = undefined;
  level.contractmanager.currenttasks = array_remove(level.contractmanager.currenttasks, task);

  if(istrue(success) && questchain.index < questchain.len - 1) {
    function_ee4cd3ba8fd7b953(task, team);
    return;
  }

  function_26f3066ca0cd1957(task, team, success);
}

function function_d75b66b46e0f7273(group, team, rewardorigin, rewardangles, rewardscriptable, players) {
  if(!isDefined(level.var_81e77c935dfefd11)) {
    return;
  }

  if(function_73689348205a9057(team)) {
    questchain = function_c6ec58a3c19cd74d(team);
    var_56f390f17fee5add = level.var_81e77c935dfefd11.var_c25435bfa70e9a13[questchain.ref];
    contractref = var_56f390f17fee5add[questchain.index];
    contractbundle = function_99b5f579a15f808d(contractref);
    groupref = contractbundle.rewardgroup;

    if(isDefined(group) && isDefined(groupref) && group == groupref && isDefined(questchain.var_d75b66b46e0f7273) && isfunction(questchain.var_d75b66b46e0f7273)) {
      [[questchain.var_d75b66b46e0f7273]](team, rewardorigin, rewardangles);
    }
  }
}

function function_95241846d4382372(task, team) {
  level endon("game_ended");
  questchain = task.questchain;
  assertex(isDefined(questchain), "<dev string:x100>");

  if(!isDefined(questchain)) {
    return;
  }

  level.var_81e77c935dfefd11.activechains[level.var_81e77c935dfefd11.activechains.size] = questchain;
  level.var_81e77c935dfefd11.teaminstances[team] = questchain;

  if(isDefined(questchain.var_3ecdcdbc9f0b5fe0) && isfunction(questchain.var_3ecdcdbc9f0b5fe0)) {
    task[[questchain.var_3ecdcdbc9f0b5fe0]](team);
  }

  if(istrue(task.var_36847cfbae9581) || questchain.index >= questchain.len - 1) {
    return;
  }

  if(level.var_81e77c935dfefd11.waittime > 0) {
    wait level.var_81e77c935dfefd11.waittime;
  }

  level.contractmanager.var_b6fae9c9655c73bf[team] = undefined;
  level.contractmanager.currenttasks = array_remove(level.contractmanager.currenttasks, task);
  function_ee4cd3ba8fd7b953(task, team);
}

function function_ee4cd3ba8fd7b953(task, team) {
  questchain = function_c6ec58a3c19cd74d(team);
  assertex(isDefined(questchain), "<dev string:x141>");

  if(!isDefined(questchain)) {
    return;
  }

  questchain.index++;
  var_56f390f17fee5add = level.var_81e77c935dfefd11.var_c25435bfa70e9a13[questchain.ref];
  contractref = var_56f390f17fee5add[questchain.index];
  teammates = getteamdata(team, "players");
  player = undefined;

  foreach(teammate in teammates) {
    if(!isDefined(player)) {
      player = teammate;
    }

    if(isalive(teammate) && !isbot(teammate)) {
      player = teammate;
      break;
    }
  }

  if(isDefined(questchain.var_ce5b38ccbacff64) && isfunction(questchain.var_ce5b38ccbacff64)) {
    task[[questchain.var_ce5b38ccbacff64]](team);
  }

  player function_438f067da7cbe893(contractref, task.payload);
  task.payload = undefined;
}

function function_26f3066ca0cd1957(task, team, success) {
  questchain = function_c6ec58a3c19cd74d(team);
  assertex(isDefined(questchain), "<dev string:x181>");

  if(!isDefined(questchain)) {
    return;
  }

  questchain.complete = 1;
  questchain.success = success;

  if(isDefined(questchain.var_d6a940bdd49c18ca) && isfunction(questchain.var_d6a940bdd49c18ca)) {
    task[[questchain.var_d6a940bdd49c18ca]](team, success);
  }

  if(istrue(success) && isDefined(questchain.startertask)) {
    level.contractmanager.var_b6fae9c9655c73bf[team] = questchain.startertask;
    level.contractmanager.currenttasks[level.contractmanager.currenttasks.size] = questchain.startertask;

    if(isDefined(questchain.startertask.category)) {
      questindex = namespace_1eb3c4e0e28fac71::getquesttableindex(questchain.startertask.category);
      namespace_1eb3c4e0e28fac71::setquestindexteamomnvar(team, questindex);
    }
  }
}

function function_3dd1a630275d19af(team) {
  if(level.var_81e77c935dfefd11.waittime <= 0) {
    return;
  }

  task = self;
  questchain = function_c6ec58a3c19cd74d(team);
  assertex(isDefined(questchain), "<dev string:x1bc>");

  if(!isDefined(questchain)) {
    return;
  }

  level endon("game_ended");

  if(isDefined(questchain.var_cede041f1b6728e0) && isfunction(questchain.var_cede041f1b6728e0)) {
    task[[questchain.var_cede041f1b6728e0]](team);
  }
}

function function_25b927ee0e8f37eb(var_aae4896d02056ac3) {
  task = self.task;

  if(!isDefined(task) || !isDefined(task.questchain)) {
    return;
  }

  task.questchain.tablets = [];
  var_56f390f17fee5add = level.var_81e77c935dfefd11.var_c25435bfa70e9a13[var_aae4896d02056ac3];
  nexttablet = undefined;
  prevtablet = undefined;

  for(i = 0; i < var_56f390f17fee5add.size; i++) {
    contractref = var_56f390f17fee5add[i];
  }
}

function function_438f067da7cbe893(contractref, payload) {
  player = self;
  iselite = 1;
  tablet = namespace_1eb3c4e0e28fac71::function_fe5d4d0a6a530b1e(contractref, player.origin, player.angles, iselite);
  tablet.task.payload = payload;
  player namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(tablet);
}

function function_73689348205a9057(team) {
  return isDefined(level.var_81e77c935dfefd11.teaminstances[team]);
}

function function_15130df1ddac6787(task) {
  return isDefined(task.questchain);
}

function function_c6ec58a3c19cd74d(team) {
  return level.var_81e77c935dfefd11.teaminstances[team];
}