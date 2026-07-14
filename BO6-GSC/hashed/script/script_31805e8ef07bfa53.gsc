/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_31805e8ef07bfa53.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_50cece4fabbdcc75;
#using script_569138730a0a130f;
#using script_6852b85528e74b9b;
#using script_77873e194e406c6d;
#using script_f01501ac138f999;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\omnvar_utility;
#using scripts\engine\utility;
#namespace namespace_37b952684c0bbb5;

function function_6dd785648a55b707(var_d2eb8aba5c657d96) {
  var_14a148a3d7713983 = utility::getsharedfunc(#"activity_participation", #"hash_bd9fe8041a91dd60");

  if(!isDefined(var_14a148a3d7713983)) {
    var_14a148a3d7713983 = &activity_participation::function_c7d57aecb2c3723d;
  }

  [[var_14a148a3d7713983]]();
  callback::add(#"player_connect", &function_7bc04bea7f6afc7c);
  callback::add(#"player_death", &function_b1b9b69c51a28c6d);
  var_d2eb8aba5c657d96.playerfocusconditions = spawnStruct();
  var_d2eb8aba5c657d96.playerfocusconditions conditional_container::function_e235be9fe32422e8();
  conditional_container::addcondition(var_d2eb8aba5c657d96.playerfocusconditions, &activity_participation::function_d72c4caab34c1963, []);
  playerfocuscountdowntimer = var_d2eb8aba5c657d96.activitynexussettings.playerfocuscountdowntimer;
  conditional_container::addcondition(var_d2eb8aba5c657d96.playerfocusconditions, &function_7a8a60d9e2052202, [playerfocuscountdowntimer]);
  level thread function_5dac50fda035f933();
}

function function_e8bf648cc92f890a(player) {
  var_533c135eee7bcdd1 = utility::getsharedfunc(#"hash_bfef14c27a599b88", #"hash_5d319eff2d9589f");

  if(isDefined(var_533c135eee7bcdd1)) {
    return utility::callsharedfunc(#"hash_bfef14c27a599b88", #"hash_5d319eff2d9589f", player);
  }

  return [player];
}

function function_b108b8882de745c6(player) {
  if(!function_9a4f6173fe3fe2be(player)) {
    player.activities = function_3a43f3a856337c1d();
  }
}

function function_9a4f6173fe3fe2be(player) {
  return isDefined(player.activities);
}

function function_79f72c7180693dbf(player) {
  if(!function_9a4f6173fe3fe2be(player)) {
    function_b108b8882de745c6(player);
  }

  return player.activities;
}

function function_5dac50fda035f933() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  var_3b9ca637e477309d = spawnStruct();
  var_ba9d907c75829030 = level.activities.playerfocusconditions;
  var_3b9ca637e477309d.var_ba9d907c75829030 = var_ba9d907c75829030;
  activitynexussettings = level.activities.activitynexussettings;
  var_a73bbfda33504b93 = activitynexussettings.var_a73bbfda33504b93;

  while(!isDefined(level.players) && !isarray(level.players)) {
    waitframe();
  }

  while(true) {
    var_a1196f031fda9b46 = gettime();
    var_3b9ca637e477309d utility::function_40167ba6ee5e9c37(level.players, &function_5554a39426f12323, &utility::function_31e6a9eee1305ef, undefined, var_a73bbfda33504b93, 0);
    var_12a9e8bbaa30f2dd = gettime();

    if(var_a1196f031fda9b46 == var_12a9e8bbaa30f2dd) {
      waitframe();
    }
  }
}

function function_9974d27ceeccd390(player) {
  closestid = undefined;
  closestdistance = undefined;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);

  foreach(instanceid, activityinfostruct in var_952b087207f6c610) {
    activityinstance = level.activities.instances[instanceid];
    playerdistancesq = distancesquared(player.origin, namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(self));

    if(!(isDefined(closestid) && isDefined(closestdistance)) || playerdistancesq < closestdistance) {
      closestdistance = playerdistancesq;
      closestid = instanceid;
    }
  }

  if(isDefined(closestid)) {
    return level.activities.instances[closestid];
  }

  return undefined;
}

function function_f470cd2a8621c71d(player, var_6da7a0abb80101a2) {
  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_15cad8df54bccf1e")) {
    var_fcb45744314d324c = function_bfa2d92c8914b8e8(player);

    if(isDefined(var_fcb45744314d324c)) {
      logtext = "<dev string:x24>" + namespace_72e72f5e51e6e4b3::function_38d95e6ab839aae5(var_fcb45744314d324c) + "<dev string:x4f>" + namespace_72e72f5e51e6e4b3::function_38d95e6ab839aae5(var_6da7a0abb80101a2);
      namespace_72e72f5e51e6e4b3::activitynexuslog(logtext, @ "hash_15cad8df54bccf1e", undefined, [player]);
    }
  }

  function_6711c381a1686925(player);
  var_e0cd88418db50883 = var_6da7a0abb80101a2.id;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  var_e29719b554a81ff3 = var_952b087207f6c610[var_e0cd88418db50883];
  var_fc82cbb0749142b8 = istrue(var_e29719b554a81ff3.var_e5c7bd570a1db9e2);
  player function_adaa8b0eac908cf4(var_6da7a0abb80101a2);

  if(var_fc82cbb0749142b8) {
    relevantinfostruct = spawnStruct();
    relevantinfostruct.playerlist = [player];
    namespace_59dbf6a1bb28a43f::announceactivitymoment(var_6da7a0abb80101a2, "(l\v\xe5\xac\x9c%Vf\xb7l]\xe6Y2O\xdc\x14\x8d:\xd2gZt\x97", relevantinfostruct);
  }

  function_7e07246ee6d435d(player, var_6da7a0abb80101a2);
}

function function_b53177e9d0bdd271(player) {
  var_d60fc1c36226cf1e = function_22c48563f6ed4f5c(player);

  if(isDefined(var_d60fc1c36226cf1e)) {
    var_ed8dc801d7582219 = var_d60fc1c36226cf1e.id;
    var_d56b089c4ddfc232 = player function_dc119e5d47146b8e();

    if(!isDefined(var_d56b089c4ddfc232) || var_ed8dc801d7582219 != var_d56b089c4ddfc232) {
      function_f470cd2a8621c71d(player, var_d60fc1c36226cf1e);
    }
  }
}

function function_67d75c59b6893c56(player) {
  var_c8c053854d6fd998 = player function_dc119e5d47146b8e();
  return isDefined(var_c8c053854d6fd998);
}

function function_babc4710523fb780(player, activityinstance) {
  var_c8c053854d6fd998 = player function_dc119e5d47146b8e();

  if(!isDefined(var_c8c053854d6fd998) || var_c8c053854d6fd998 != activityinstance.id) {
    return false;
  }

  return true;
}

function function_918f599e252fe078(player, activitytype) {
  var_d56b089c4ddfc232 = player function_dc119e5d47146b8e();

  if(isDefined(var_d56b089c4ddfc232)) {
    currentfocusedactivity = level.activities.instances[var_d56b089c4ddfc232];

    if(isDefined(currentfocusedactivity) && currentfocusedactivity.type == activitytype) {
      return true;
    }
  }

  return false;
}

function function_6711c381a1686925(player) {
  oldinstance = function_bfa2d92c8914b8e8(player);

  if(isDefined(oldinstance)) {
    function_7845e2b0442da4c9(player, oldinstance);
  }

  player function_273848cc4a399da2(undefined);
}

function function_cd49461e4b7bd875(player, activityinstance) {
  if(isDefined(level.activities.nexusoverrides[6])) {
    return activity_common::function_2ece6c60562ab130(6, [activityinstance, player], 0);
  }

  return function_d938acd69fdcecb1(player, activityinstance);
}

function function_7845e2b0442da4c9(player, activityinstance) {
  activityinstance namespace_4d9bab4515d9688d::function_7d26df810be11dc7(player);
  activityinstance namespace_606113cb7b23f701::function_903b20a9e9fa5e5f([player]);
  function_45d2782b07eae7f2(player, activityinstance);
}

function function_7e07246ee6d435d(player, activityinstance) {
  activityinstance namespace_606113cb7b23f701::function_b6a212878f1730f3([player]);
  activityinstance namespace_4d9bab4515d9688d::function_395ba731c6c50f92(player);
  function_2ddc2c6526f22a4c(player, activityinstance);
}

function function_fe85a02bc49dedd8(player) {
  var_aef1a83105e246b9 = function_79f72c7180693dbf(player);
  return var_aef1a83105e246b9.completedactivities;
}

function function_bfa2d92c8914b8e8(player) {
  focusedactivityid = player function_dc119e5d47146b8e();

  if(isDefined(focusedactivityid)) {
    return level.activities.instances[focusedactivityid];
  }

  return undefined;
}

function function_e6f3a8c65d608a47(player, activityinstance) {
  completedactivityinfo = spawnStruct();
  var_aef1a83105e246b9 = function_79f72c7180693dbf(player);
  var_aef1a83105e246b9.completedactivities[var_aef1a83105e246b9.completedactivities.size] = completedactivityinfo;
  completedactivityinfo.success = namespace_59dbf6a1bb28a43f::function_4502ab041f3d0f21(activityinstance);
  completedactivityinfo.activitytype = activityinstance.type;
  completedactivityinfo.varianttag = activityinstance.varianttag;
}

function function_e4d28975b0857640(player, params) {
  assert(params.size == 1 && isDefined(params[0]), "<dev string:x5e>");
  activityinstance = params[0];
  var_9032f5c1a568f1c0 = function_babc4710523fb780(player, activityinstance);
  return var_9032f5c1a568f1c0;
}

function function_a96ddc512f30d9e5(player, params) {
  assert(params.size == 1 && isDefined(params[0]), "<dev string:x5e>");
  activityinstance = params[0];
  var_9032f5c1a568f1c0 = function_babc4710523fb780(player, activityinstance);
  var_aa8813999f311796 = isDefined(player function_dc119e5d47146b8e());
  return var_9032f5c1a568f1c0 || !var_aa8813999f311796;
}

function function_7a8a60d9e2052202(player, params) {
  assert(isarray(params) && params.size == 1 && isnumber(params[0]), "<dev string:xc4>");
  playerfocuscountdowntimer = params[0];
  var_3c439203e37f104e = player function_b421d22e8a46cd97();
  var_91f64a343b6e77ae = !isDefined(var_3c439203e37f104e) || var_3c439203e37f104e > playerfocuscountdowntimer;
  return var_91f64a343b6e77ae;
}

function function_f23a3aa391e6b908(player, params) {
  var_b9bcf0c66ec8ba8b = isDefined(player.var_4c9d716e3e1e4c4e);
  return !var_b9bcf0c66ec8ba8b;
}

function function_4632cd7a37598d79(player, params) {
  return isDefined(player) && isPlayer(player);
}

function function_4a5de9d7a4dc0aaa(player, activityinstance) {
  instanceid = activityinstance.id;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  activityinfostruct = var_952b087207f6c610[instanceid];

  if(isDefined(activityinfostruct)) {
    return istrue(activityinfostruct.var_a609a5a1b83d4ad7);
  }

  return false;
}

function function_e939c6c01e8713c7(player, activityinstance) {
  instanceid = activityinstance.id;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  activityinfostruct = var_952b087207f6c610[instanceid];

  if(isDefined(activityinfostruct)) {
    activityinfostruct.var_a609a5a1b83d4ad7 = 1;
  }
}

function function_b994ea8054b06764(player, activityinstance) {
  instanceid = activityinstance.id;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  activityinfostruct = var_952b087207f6c610[instanceid];

  if(isDefined(activityinfostruct)) {
    activityinfostruct.var_a609a5a1b83d4ad7 = 0;
  }
}

function function_cfdab119f8322d17(players, activityinstance, omnvar, value, resetvalue) {
  if(!isDefined(value)) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x11c>" + omnvar + "<dev string:x146>", @ "hash_22e4e38cab273e93", activityinstance, players);

    return;
  }

  foreach(player in players) {
    player omnvar_utility::setcachedclientomnvar(omnvar, value);
  }

  namespace_59dbf6a1bb28a43f::function_7652cee04789e607(activityinstance, omnvar, value, resetvalue);
}

function function_609cbb73763ad600(player, activityinstance, omnvar, value, resetvalue) {
  if(!isDefined(value)) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x11c>" + omnvar + "<dev string:x146>", @ "hash_22e4e38cab273e93", activityinstance, [player]);

    return;
  }

  player omnvar_utility::setcachedclientomnvar(omnvar, value);
  namespace_59dbf6a1bb28a43f::function_7652cee04789e607(activityinstance, omnvar, value, resetvalue);
}

function function_2ddc2c6526f22a4c(player, activityinstance) {
  var_3370c74026090bf4 = activityinstance.var_3370c74026090bf4;

  foreach(var_dceb131680577ab9 in var_3370c74026090bf4) {
    storedomnvarvalue = namespace_59dbf6a1bb28a43f::function_fe81b6493d094e5(activityinstance, var_dceb131680577ab9);
    player omnvar_utility::setcachedclientomnvar(var_dceb131680577ab9, storedomnvarvalue);
  }
}

function function_45d2782b07eae7f2(player, activityinstance) {
  var_3370c74026090bf4 = activityinstance.var_3370c74026090bf4;

  foreach(var_dceb131680577ab9 in var_3370c74026090bf4) {
    var_265fe54b1faf12b4 = namespace_59dbf6a1bb28a43f::function_bf543ede9abbdc82(activityinstance, var_dceb131680577ab9);

    if(isDefined(var_265fe54b1faf12b4)) {
      player omnvar_utility::setcachedclientomnvar(var_dceb131680577ab9, var_265fe54b1faf12b4);
    }
  }
}

function function_498d303b601ec15f(player, params) {
  assert(isDefined(params) && params.size == 1, "<dev string:x164>");
  activityinstance = params[0];
  activityinstancecategory = activityinstance.category;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);

  foreach(var_abb33c8ae065c51d in var_952b087207f6c610) {
    var_10b5a0ceb8f89f96 = level.activities.instances[instanceid];
    var_e1d6fbd67cf57e12 = var_10b5a0ceb8f89f96.category;

    if(var_e1d6fbd67cf57e12 == activityinstancecategory) {
      return false;
    }
  }

  return true;
}

function private function_3a43f3a856337c1d() {
  playeractivitydata = spawnStruct();
  playeractivitydata.var_aaad885ef05f0b04 = [];
  playeractivitydata.completedactivities = [];
  playeractivitydata.focusedactivityid = undefined;
  playeractivitydata.var_ce9a0d39b81d225e = undefined;
  return playeractivitydata;
}

function private function_7bc04bea7f6afc7c(params) {
  function_b108b8882de745c6(self);
  callback::add(#"player_spawned", &_onplayerspawned);
  callback::add(#"player_disconnect", &function_5d5ee49e6df85c00);
}

function private function_b1b9b69c51a28c6d(params) {
  player = self;
  activityinstancestoend = [];
  var_1b9f16f7d49be9a1 = activity_participation::function_79fe72713d47a8d2(player);

  foreach(instanceinfostruct in var_1b9f16f7d49be9a1) {
    activityinstance = level.activities.instances[instanceid];

    if(isDefined(activityinstance)) {
      activityinstance notify("\x85l\x8ei\x9d\xd2\x1d\xbc\xd7\x0e\xc6\x16/Y9_#\xb4e\xc8", player);

      if(namespace_7b5dc905a7ea3e0f::function_d34bce97eb9105ec(activityinstance)) {
        activityinstancestoend[activityinstancestoend.size] = activityinstance;
      }
    }
  }

  foreach(activityinstance in activityinstancestoend) {
    activity_participation::function_eac0583a696a029e(activityinstance, player, 1);
  }
}

function private _onplayerspawned(params) {
  player = self;

  if(isDefined(level.activities.nexusoverrides[5])) {
    activity_common::function_2ece6c60562ab130(5, [player], 1);
  }
}

function private function_5d5ee49e6df85c00(params) {
  player = self;

  if(!isDefined(player)) {
    foreach(instance in level.activities.instances) {
      instance.playerparticipants = utility::array_removeundefined(instance.playerparticipants);
    }

    return;
  }

  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);

  foreach(activityinfostruct in var_952b087207f6c610) {
    activityinstance = level.activities.instances[instanceid];
    activity_participation::function_cd96ccb96ce934e0(activityinstance, player);
  }
}

function private function_dc119e5d47146b8e() {
  var_aef1a83105e246b9 = function_79f72c7180693dbf(self);
  return var_aef1a83105e246b9.focusedactivityid;
}

function private function_b421d22e8a46cd97() {
  var_aef1a83105e246b9 = function_79f72c7180693dbf(self);

  if(!isDefined(var_aef1a83105e246b9.var_ce9a0d39b81d225e)) {
    return undefined;
  }

  currenttimeinseconds = gettime() / 1000;
  return currenttimeinseconds - var_aef1a83105e246b9.var_ce9a0d39b81d225e;
}

function private function_adaa8b0eac908cf4(activityinstance) {
  player = self;
  instanceid = activityinstance.id;
  player function_273848cc4a399da2(instanceid);
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  focusedactivityinfostruct = var_952b087207f6c610[instanceid];

  if(isDefined(focusedactivityinfostruct)) {
    focusedactivityinfostruct.var_e5c7bd570a1db9e2 = 1;
  }
}

function private function_273848cc4a399da2(id) {
  var_aef1a83105e246b9 = function_79f72c7180693dbf(self);
  var_aef1a83105e246b9.focusedactivityid = id;
  var_aef1a83105e246b9.var_ce9a0d39b81d225e = gettime() / 1000;
}

function private function_22c48563f6ed4f5c(player) {
  var_9ff8c372449b04ff = -1;
  var_bab028a1eed0ba04 = [];
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);

  foreach(activityinfostruct in var_952b087207f6c610) {
    var_87e3bb641beaa573 = level.activities.instances[instanceid];
    var_92925a131d0922d1 = function_cd49461e4b7bd875(player, var_87e3bb641beaa573);

    if(var_92925a131d0922d1 > var_9ff8c372449b04ff) {
      var_9ff8c372449b04ff = var_92925a131d0922d1;
      var_bab028a1eed0ba04 = [var_87e3bb641beaa573];
      continue;
    }

    if(var_92925a131d0922d1 == var_9ff8c372449b04ff) {
      var_bab028a1eed0ba04[var_bab028a1eed0ba04.size] = var_87e3bb641beaa573;
    }
  }

  var_2ae8a10f43df54f = undefined;

  if(var_bab028a1eed0ba04.size == 1) {
    var_2ae8a10f43df54f = var_bab028a1eed0ba04[0];
  } else if(var_bab028a1eed0ba04.size > 1) {
    var_2ae8a10f43df54f = activity_common::function_a3a39b3c2b27bcdc(player.origin, var_bab028a1eed0ba04);
  }

  return var_2ae8a10f43df54f;
}

function private function_d938acd69fdcecb1(player, activityinstance) {
  var_569803f8168f8e60 = 10;
  var_84ada9133e6fbc0d = 1;
  var_47149e0bb38b868e = 0;
  var_9fea08d60d01d093 = activityinstance.var_efead8c9cb49b822;
  var_47149e0bb38b868e += var_9fea08d60d01d093 * var_569803f8168f8e60;
  var_79937bc519b58243 = activityinstance.id;
  var_952b087207f6c610 = activity_participation::function_79fe72713d47a8d2(player);
  var_2d54df52a38bad7f = 0;
  var_4427b75f30aa04e7 = var_952b087207f6c610[var_79937bc519b58243];

  if(isDefined(var_4427b75f30aa04e7)) {
    playerjoinreason = var_4427b75f30aa04e7.joinreason;

    if(playerjoinreason == "4\n+\bJ#si\xf0c\x0f\\\xc9\x10~\xd8\xb4\"&\xfc" || playerjoinreason == "\x98\x81G\n68\x06\x01\x9d\xd1Q\xdcd\x85\xfa\x02\xe2") {
      var_2d54df52a38bad7f = 10;
    } else if(playerjoinreason == "n\x02\xce\x1a[,\x19\xacg\xc0\x11\xcfd~\xba\xf3?." || playerjoinreason == "\xb4\x18y[\x8a\xec\xe0\x94\xa8\xab\x06\x8cLc\xfd\xa8a") {
      var_2d54df52a38bad7f = 6;
    } else if(playerjoinreason == "\x82\x93\xa7\xb8}jx\x8f\xefq>4\x95\xfbWs\x11\xf7\x17\xb1Y") {
      var_2d54df52a38bad7f = 4;
    } else {
      var_2d54df52a38bad7f = 5;
    }
  }

  var_47149e0bb38b868e += var_2d54df52a38bad7f * var_84ada9133e6fbc0d;
  return var_47149e0bb38b868e;
}

function private function_5554a39426f12323(player, playerarraykey) {
  var_3b9ca637e477309d = self;

  if(conditional_container::function_ac8003c33335a40f(var_3b9ca637e477309d.var_ba9d907c75829030, player)) {
    function_b53177e9d0bdd271(player);
  }
}