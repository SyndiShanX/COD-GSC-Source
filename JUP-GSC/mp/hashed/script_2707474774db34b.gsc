/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2707474774db34b.gsc
************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_3ab210ea917601e7;
#using script_3ac7886f9e4eceef;
#using script_41387eecc35b88bf;
#using script_4fdefae8b7bcdf73;
#using script_54f6d121e91434f8;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_553c3c813ee2de54;

function function_c993d376e8f10816(var_d3f89f07fe3fa0ab) {
  function_84ac3d5c82b5ba3c();
  callback::add("player_connect", &function_e5594507f84bc271);
  callback::add("player_death", &function_f0ab0b7c533f4200);
  var_d3f89f07fe3fa0ab.playerfocusconditions = spawnStruct();
  var_d3f89f07fe3fa0ab.playerfocusconditions function_a1f71337a6844055();
  addcondition(var_d3f89f07fe3fa0ab.playerfocusconditions, &function_935c3f2efd9c2a4a, []);
  addcondition(var_d3f89f07fe3fa0ab.playerfocusconditions, &function_2febe1d03af425f7, []);
  level thread function_dfae5859962924f2();
}

function function_1f99e5a11b5e285b(player) {
  if(!function_6152021549f1836b(player)) {
    player.activities = function_fb0ef9f4034927f8();
  }
}

function function_6152021549f1836b(player) {
  return isDefined(player.activities);
}

function function_5cc2fd3d10cbab56(player) {
  if(!function_6152021549f1836b(player)) {
    function_1f99e5a11b5e285b(player);
  }

  return player.activities;
}

function function_dfae5859962924f2() {
  level endon("game_ended");
  var_84136076a28f85b4 = spawnStruct();
  var_186eafd5a207b951 = function_a5424c44da084d6e();
  var_84136076a28f85b4.var_186eafd5a207b951 = var_186eafd5a207b951;

  while(!isDefined(level.players) && !isarray(level.players)) {
    waitframe();
  }

  while(true) {
    var_be685114ee68c2f3 = gettime();
    var_84136076a28f85b4 function_ec65095e6f342856(level.players, &function_512997cf3f5c2f8a, &function_ef2b4cd10b36a1ae, undefined, 2, 0);
    var_de12597002155e64 = gettime();

    if(var_be685114ee68c2f3 == var_de12597002155e64) {
      waitframe();
    }
  }
}

function function_dacf6dd70b828aad(player) {
  closestid = undefined;
  closestdistance = undefined;
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);

  foreach(instanceid, activityinfostruct in var_32a6f9b3d487152d) {
    activityinstance = getactivityinstance(instanceid);
    playerdistancesq = distancesquared(player.origin, namespace_68dc261109a9503f::function_8988a4c89289d7f4(self));

    if(!isDefined(closestid) || !isDefined(closestdistance) || playerdistancesq < closestdistance) {
      closestdistance = playerdistancesq;
      closestid = instanceid;
    }
  }

  if(isDefined(closestid)) {
    return getactivityinstance(closestid);
  }

  return undefined;
}

function function_51c944aa48d1ce48(player, var_4224a1fc6427bcc7) {
  if(function_2a1e9879f71ab677(@ "hash_15cad8df54bccf1e")) {
    var_9aa1dc750ab65865 = function_deb5a4d2a7bda5e9(player);

    if(isDefined(var_9aa1dc750ab65865)) {
      logtext = "Player Switched their Focus away from: " + function_68e0a0bea0dd792c(var_9aa1dc750ab65865) + " and onto: " + function_68e0a0bea0dd792c(var_4224a1fc6427bcc7);
      activitynexuslog(logtext, @ "hash_15cad8df54bccf1e", undefined, [player]);
    }
  }

  function_7a68246baec59148(player);
  var_871df5c434cefb0a = getinstanceid(var_4224a1fc6427bcc7);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  var_a5e113e92237f95a = var_32a6f9b3d487152d[var_871df5c434cefb0a];
  var_f06fa9ff431c0089 = istrue(var_a5e113e92237f95a.var_ab4cdd1bcafb1dff);
  player function_6fefd7e95fdfcc89(var_4224a1fc6427bcc7);

  if(var_f06fa9ff431c0089) {
    relevantinfostruct = spawnStruct();
    relevantinfostruct.playerlist = [player];
    announceactivitymoment(var_4224a1fc6427bcc7, "PlayerRefocusedOnActivity", relevantinfostruct);
  }

  function_261533bdcfe64be0(player, var_4224a1fc6427bcc7);
}

function function_d10ee44b55e7d8d4(player) {
  var_21fe41e9dbb5c0fb = function_71e9ad7d057fc10d(player);

  if(isDefined(var_21fe41e9dbb5c0fb)) {
    var_3c214072a74a856c = getinstanceid(var_21fe41e9dbb5c0fb);
    var_69605a92b368f137 = player function_b9a4c528a6fd77cf();

    if(!isDefined(var_69605a92b368f137) || var_3c214072a74a856c != var_69605a92b368f137) {
      function_51c944aa48d1ce48(player, var_21fe41e9dbb5c0fb);
    }
  }
}

function function_3e82ebe92b9fa877(player) {
  var_1c69f70de3a758f1 = player function_b9a4c528a6fd77cf();
  return isDefined(var_1c69f70de3a758f1);
}

function function_9a5bdd69b1e544f9(player, activityinstance) {
  var_1c69f70de3a758f1 = player function_b9a4c528a6fd77cf();

  if(!isDefined(var_1c69f70de3a758f1) || var_1c69f70de3a758f1 != activityinstance.id) {
    return false;
  }

  return true;
}

function function_bfda021631854371(player, activitytype) {
  var_69605a92b368f137 = player function_b9a4c528a6fd77cf();

  if(isDefined(var_69605a92b368f137)) {
    currentfocusedactivity = getactivityinstance(var_69605a92b368f137);

    if(isDefined(currentfocusedactivity) && getactivitytype(currentfocusedactivity) == activitytype) {
      return true;
    }
  }

  return false;
}

function function_7a68246baec59148(player) {
  oldinstance = function_deb5a4d2a7bda5e9(player);

  if(isDefined(oldinstance)) {
    function_575933e868e5c6e8(player, oldinstance);
  }

  player function_69f5f64b2f31e8c3(undefined);
}

function function_47e109e0d8027d54(player, activityinstance) {
  if(function_71d38726159c3f12(6)) {
    return function_f541e4e4edaa8e99(6, [activityinstance, player], 0);
  }

  return function_ff52316e5fb7e838(player, activityinstance);
}

function function_575933e868e5c6e8(player, activityinstance) {
  activityinstance function_2d38888e45d6a28a(player);
  activityinstance function_94050b71cb4ef1ca([player]);
  function_4f871ff9eb56f17(player, activityinstance);
}

function function_261533bdcfe64be0(player, activityinstance) {
  activityinstance function_947973be56e0dbb2([player]);
  activityinstance function_451ffc1b7133042f(player);
  function_39cdb60af8e36365(player, activityinstance);
}

function function_1c121cfcda39970d(player) {
  var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(player);
  return var_3900d8bea91376b4.completedactivities;
}

function function_deb5a4d2a7bda5e9(player) {
  focusedactivityid = player function_b9a4c528a6fd77cf();

  if(isDefined(focusedactivityid)) {
    return getactivityinstance(focusedactivityid);
  }

  return undefined;
}

function function_1015815db0b598c2(player, activityinstance) {
  completedactivityinfo = spawnStruct();
  var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(player);
  var_3900d8bea91376b4.completedactivities[var_3900d8bea91376b4.completedactivities.size] = completedactivityinfo;
  completedactivityinfo.success = function_bdd22095c4312f34(activityinstance);
  completedactivityinfo.activitytype = getactivitytype(activityinstance);
  completedactivityinfo.varianttag = function_a4748b32a824c79c(activityinstance);
}

function function_973730f0a5275485(player, params) {
  assertex(params.size == 1 && isDefined(params[0]), "<dev string:x1c>");
  activityinstance = params[0];
  var_1206ca5d90319311 = function_9a5bdd69b1e544f9(player, activityinstance);
  return var_1206ca5d90319311;
}

function function_d49dc10646971d24(player, params) {
  assertex(params.size == 1 && isDefined(params[0]), "<dev string:x1c>");
  activityinstance = params[0];
  var_1206ca5d90319311 = function_9a5bdd69b1e544f9(player, activityinstance);
  var_2cfbf3c881517abf = isDefined(player function_b9a4c528a6fd77cf());
  return var_1206ca5d90319311 || !var_2cfbf3c881517abf;
}

function function_2febe1d03af425f7(player, params) {
  var_3c2942567059c7bb = player function_1622a54acd6019d6();
  var_5529eb88d67ca2df = !isDefined(var_3c2942567059c7bb) || var_3c2942567059c7bb > 10;
  return var_5529eb88d67ca2df;
}

function function_3b6f0ac301030549(player, params) {
  var_1eeab92b9ab50bde = isDefined(player.var_2fa5b49969def47);
  return !var_1eeab92b9ab50bde;
}

function function_388f018d407adc40(player, params) {
  return isDefined(player) && isPlayer(player);
}

function function_bc33f8483c604d9b(player, params) {
  assertex(params.size == 2 && isDefined(params[0]) && isDefined(params[1]), "<dev string:x1c>");
  conditionalcontainer = params[0];
  activityinstance = params[1];

  if(!isDefined(conditionalcontainer.broadcastdefinition)) {
    return true;
  }

  activationmoment = namespace_c47da9d4c2db4f0d::function_c24185c47d989c1a(conditionalcontainer.broadcastdefinition);

  if(activationmoment != "PlayerJoin") {
    return true;
  }

  lastassimedplayer = undefined;

  if(scripts\cp_mp\utility\squad_utility::issquadmode() && scripts\cp_mp\squads::function_be6ce63a202791c5(player.team, player.sessionsquadid, "lastAssimedPlayer")) {
    lastassimedplayer = scripts\cp_mp\squads::getsquaddata(player.team, player.sessionsquadid, "lastAssimedPlayer");
  } else if(scripts\mp\utility\teams::function_ef7cf07ba921200e(player.team, "lastAssimedPlayer")) {
    lastassimedplayer = scripts\mp\utility\teams::getteamdata(player.team, "lastAssimedPlayer");
  }

  if(!isDefined(lastassimedplayer)) {
    return true;
  }

  return player == lastassimedplayer;
}

function function_7b4d0a8fdbbf4193(player, activityinstance) {
  instanceid = getinstanceid(activityinstance);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  activityinfostruct = var_32a6f9b3d487152d[instanceid];

  if(isDefined(activityinfostruct)) {
    return istrue(activityinfostruct.var_2cbce2fd25a1eac2);
  }

  return false;
}

function function_d5c655d706be5a5a(player, activityinstance) {
  instanceid = getinstanceid(activityinstance);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  activityinfostruct = var_32a6f9b3d487152d[instanceid];

  if(isDefined(activityinfostruct)) {
    activityinfostruct.var_2cbce2fd25a1eac2 = 1;
  }
}

function function_15b9cdad6fea7395(player, activityinstance) {
  instanceid = getinstanceid(activityinstance);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  activityinfostruct = var_32a6f9b3d487152d[instanceid];

  if(isDefined(activityinfostruct)) {
    activityinfostruct.var_2cbce2fd25a1eac2 = 0;
  }
}

function function_5ce919b476495152(players, activityinstance, omnvar, value, resetvalue) {
  if(!isDefined(value)) {
    activitynexuslog("Could not set given value for Omnvar: " + omnvar + " because it was undefined.", @ "hash_22e4e38cab273e93", activityinstance, players);
    return;
  }

  foreach(player in players) {
    player setclientomnvar(omnvar, value);
  }

  function_26857d3de8354d4e(activityinstance, omnvar, value, resetvalue);
}

function function_94b6d84e134ecb15(player, activityinstance, omnvar, value, resetvalue) {
  if(!isDefined(value)) {
    activitynexuslog("Could not set given value for Omnvar: " + omnvar + " because it was undefined.", @ "hash_22e4e38cab273e93", activityinstance, [player]);
    return;
  }

  player setclientomnvar(omnvar, value);
  function_26857d3de8354d4e(activityinstance, omnvar, value, resetvalue);
}

function function_39cdb60af8e36365(player, activityinstance) {
  var_14a8920a25d8a7a1 = function_b1e0c431ac8df0ed(activityinstance);

  foreach(var_3b070ee0304422a8 in var_14a8920a25d8a7a1) {
    storedomnvarvalue = function_297dc42ebf4f3b04(activityinstance, var_3b070ee0304422a8);
    player setclientomnvar(var_3b070ee0304422a8, storedomnvarvalue);
  }
}

function function_4f871ff9eb56f17(player, activityinstance) {
  var_14a8920a25d8a7a1 = function_b1e0c431ac8df0ed(activityinstance);

  foreach(var_3b070ee0304422a8 in var_14a8920a25d8a7a1) {
    var_40f26b8193ffeb5d = function_402e97e252bb33ff(activityinstance, var_3b070ee0304422a8);

    if(isDefined(var_40f26b8193ffeb5d)) {
      player setclientomnvar(var_3b070ee0304422a8, var_40f26b8193ffeb5d);
    }
  }
}

function function_34e215db7fc6d16a(player, params) {
  assertex(isDefined(params) && params.size == 1, "<dev string:x82>");
  activityinstance = params[0];
  activityinstancecategory = getactivitycategory(activityinstance);
  var_32a6f9b3d487152d = namespace_d886885225a713a7::function_553a690e1064cf0b(player);

  foreach(instanceid, var_b2941d08f576eb6c in var_32a6f9b3d487152d) {
    var_33571bfdb08594f7 = getactivityinstance(instanceid);
    var_4c8d9ff06133bc6b = getactivitycategory(var_33571bfdb08594f7);

    if(var_4c8d9ff06133bc6b == activityinstancecategory) {
      return false;
    }
  }

  return true;
}

function private function_fb0ef9f4034927f8() {
  playeractivitydata = spawnStruct();
  playeractivitydata.var_6ff9941006fb29cd = [];
  playeractivitydata.completedactivities = [];
  playeractivitydata.focusedactivityid = undefined;
  playeractivitydata.var_45bef2a1bc42602b = undefined;
  return playeractivitydata;
}

function private function_e5594507f84bc271(params) {
  function_1f99e5a11b5e285b(self);
  callback::add("player_spawned", &_onplayerspawned);
  callback::add("player_disconnect", &function_db04e6dd6940b0a5);
}

function private function_f0ab0b7c533f4200(params) {
  player = self;
  activityinstancestoend = [];
  var_9d0a2cc88b985e38 = function_553a690e1064cf0b(player);

  foreach(instanceid, instanceinfostruct in var_9d0a2cc88b985e38) {
    activityinstance = getactivityinstance(instanceid);

    if(isDefined(activityinstance)) {
      activityinstance notify("activity_player_died", player);

      if(function_b5ec1b2b98c9a315(activityinstance)) {
        activityinstancestoend[activityinstancestoend.size] = activityinstance;
      }
    }
  }

  foreach(activityinstance in activityinstancestoend) {
    function_1c93e1762d4bf23f(activityinstance, player, 1);
  }
}

function private _onplayerspawned(params) {
  player = self;

  if(function_71d38726159c3f12(5)) {
    function_f541e4e4edaa8e99(5, [player], 1);
  }
}

function private function_db04e6dd6940b0a5(params) {
  player = self;

  if(!isDefined(player)) {
    foreach(instance in level.activities.instances) {
      instance.playerparticipants = array_removeundefined(instance.playerparticipants);
    }

    return;
  }

  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);

  foreach(instanceid, activityinfostruct in var_32a6f9b3d487152d) {
    activityinstance = getactivityinstance(instanceid);
    function_91c9ad377a3c4725(activityinstance, player);
  }
}

function private function_b9a4c528a6fd77cf() {
  var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(self);
  return var_3900d8bea91376b4.focusedactivityid;
}

function private function_1622a54acd6019d6() {
  var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(self);

  if(!isDefined(var_3900d8bea91376b4.var_45bef2a1bc42602b)) {
    return undefined;
  }

  currenttimeinseconds = gettime() / 1000;
  return currenttimeinseconds - var_3900d8bea91376b4.var_45bef2a1bc42602b;
}

function private function_6fefd7e95fdfcc89(activityinstance) {
  player = self;
  instanceid = getinstanceid(activityinstance);
  player function_69f5f64b2f31e8c3(instanceid);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  focusedactivityinfostruct = var_32a6f9b3d487152d[instanceid];

  if(isDefined(focusedactivityinfostruct)) {
    focusedactivityinfostruct.var_ab4cdd1bcafb1dff = 1;
  }
}

function private function_69f5f64b2f31e8c3(id) {
  var_3900d8bea91376b4 = function_5cc2fd3d10cbab56(self);
  var_3900d8bea91376b4.focusedactivityid = id;
  var_3900d8bea91376b4.var_45bef2a1bc42602b = gettime() / 1000;
}

function private function_71e9ad7d057fc10d(player) {
  var_df6a30597937d862 = -1;
  var_37fc436c2767d2b5 = [];
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);

  foreach(instanceid, activityinfostruct in var_32a6f9b3d487152d) {
    var_73ed98ca917d666e = getactivityinstance(instanceid);
    var_a80610c132c32138 = function_47e109e0d8027d54(player, var_73ed98ca917d666e);

    if(var_a80610c132c32138 > var_df6a30597937d862) {
      var_df6a30597937d862 = var_a80610c132c32138;
      var_37fc436c2767d2b5 = [var_73ed98ca917d666e];
      continue;
    }

    if(var_a80610c132c32138 == var_df6a30597937d862) {
      var_37fc436c2767d2b5[var_37fc436c2767d2b5.size] = var_73ed98ca917d666e;
    }
  }

  var_e0814ddbe2fc8bca = undefined;

  if(var_37fc436c2767d2b5.size == 1) {
    var_e0814ddbe2fc8bca = var_37fc436c2767d2b5[0];
  } else if(var_37fc436c2767d2b5.size > 1) {
    var_e0814ddbe2fc8bca = function_8ba4c11453487949(player.origin, var_37fc436c2767d2b5);
  }

  return var_e0814ddbe2fc8bca;
}

function private function_ff52316e5fb7e838(player, activityinstance) {
  var_2327fcafae4f8a11 = 10;
  var_80ec1eb113d8b75c = 1;
  var_21072c8308b3cf6f = 0;
  var_7f2ac638edd9ec8e = function_be6214edfe52a31(activityinstance);
  var_21072c8308b3cf6f += var_7f2ac638edd9ec8e * var_2327fcafae4f8a11;
  var_88d02cafbb45b3f2 = getinstanceid(activityinstance);
  var_32a6f9b3d487152d = function_553a690e1064cf0b(player);
  var_ae40dfab935a458e = 0;
  var_12124d18c675f4aa = var_32a6f9b3d487152d[var_88d02cafbb45b3f2];

  if(isDefined(var_12124d18c675f4aa)) {
    playerjoinreason = var_12124d18c675f4aa.joinreason;

    if(playerjoinreason == "PlayerJoinedInteract" || playerjoinreason == "PlayerJoinedOther") {
      var_ae40dfab935a458e = 10;
    } else if(playerjoinreason == "PlayerJoinedDamage" || playerjoinreason == "PlayerJoinedSquad") {
      var_ae40dfab935a458e = 6;
    } else if(playerjoinreason == "PlayerJoinedProximity") {
      var_ae40dfab935a458e = 4;
    } else {
      var_ae40dfab935a458e = 5;
    }
  }

  var_21072c8308b3cf6f += var_ae40dfab935a458e * var_80ec1eb113d8b75c;
  return var_21072c8308b3cf6f;
}

function private function_512997cf3f5c2f8a(player) {
  var_84136076a28f85b4 = self;

  if(function_93587d5ba6247f36(var_84136076a28f85b4.var_186eafd5a207b951, player)) {
    function_d10ee44b55e7d8d4(player);
  }
}