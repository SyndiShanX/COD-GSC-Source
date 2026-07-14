/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_50cece4fabbdcc75.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_31805e8ef07bfa53;
#using script_4a2005cdcbf64b88;
#using script_4e1f1a7ef824ddd5;
#using script_569138730a0a130f;
#using script_73a03aaf11b641f5;
#using script_77873e194e406c6d;
#using script_f01501ac138f999;
#using scripts\common\conditional_container;
#using scripts\common\player_broadcasting;
#using scripts\engine\utility;
#namespace activity_participation;

function function_c7d57aecb2c3723d() {
  activitynexussettings = level.activities.activitynexussettings;
  var_6a45bdf8be8d4e17 = getdvarfloat(@ "hash_e19c52a408e0765d", activitynexussettings.var_f8bf2767df27c69d);
  var_b9e4276d07045eaf = getdvarfloat(@ "hash_fad3c5e3b27f4e7e", activitynexussettings.var_a0944dbff3cf09bd);
  var_fe1bc6ff815cd9c2 = getdvarfloat(@ "hash_d01337f1fb1a133", activitynexussettings.var_35839661060a507c);
  var_f05b6bcc06eb373d = getdvarfloat(@ "hash_9c8124fab915f0eb", activitynexussettings.var_3d07f85f76ebb3f3);
  namespace_9342d78fcaacff0b::function_46f0c8703af5a965(0, &function_341a4544c6ec1a5e, &function_d80c0a3d4d303984, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95", var_6a45bdf8be8d4e17);
  namespace_9342d78fcaacff0b::function_46f0c8703af5a965(1, &function_db7fe7415eb675be, &function_bccdd39d7b9587f4, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82", var_b9e4276d07045eaf);
  namespace_9342d78fcaacff0b::function_46f0c8703af5a965(2, &function_3ac2b590a978046d, &function_be7365cf6080a15f, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad", var_fe1bc6ff815cd9c2);

  if(istrue(activitynexussettings.var_42587ba75f9f7eb)) {
    namespace_9342d78fcaacff0b::function_46f0c8703af5a965(3, &function_f806055ce67b6f3e, &function_c589824253f9d0ce, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!", var_f05b6bcc06eb373d);
  }
}

function function_b2405ee028bc9654(activityinstance) {
  activityinstance.participationconditions = spawnStruct();
  activityinstance.participationconditions conditional_container::function_e235be9fe32422e8();
  conditional_container::addcondition(activityinstance.participationconditions, &function_f497c34b2b32567f, [activityinstance, namespace_7b5dc905a7ea3e0f::getmaxplayercount(activityinstance)], undefined, "=\xbf1\xc7\xd1B\xdeH.\x16\xcd\x10-\xab`\xf0\x89\xa9\xae\x9c\x85\xbaaOI=\xa3\xd0\xfd\xa1O6\x90\x1e\x98\xee\bWU\x99\x80");
  conditional_container::addcondition(activityinstance.participationconditions, &function_c1aeca2e80b39fd4, [activityinstance], undefined, "r\xf7\x88\x96\x8be\x81]>\xa8\xd0\xb8\xb5\xdc\xe6\n\x04\x1a\ae\xc3\xc9\x9dPM\xb7\x94y");
  conditional_container::addcondition(activityinstance.participationconditions, &function_86f624d7403c3387, [activityinstance], undefined, "\x16\xa4\xd9\xe3\xa9\x11\xe7g*gr\x99<I\xb2\x0e\x9c8\xcb\xa4i\xd2ub'\xc6sQd8\xb2.\x8a\xa0\xf1\x8c\xb1r\xc1\x02sa\xde\xb1\x1c(\x90\x84,\xf2(4Yr\xfa\xa3a\xfb");

  if(namespace_7b5dc905a7ea3e0f::function_ae56f032ad9177f4(activityinstance)) {
    conditional_container::addcondition(activityinstance.participationconditions, &function_5f67d30ab4cd9eb6, [activityinstance, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95"], undefined, "<8\xd9\xf1H\xf8\xad\x92B\xb5\x9e\xd8\x9d\xf3\x80\xb5\xdd\xb9\x99I\xe2O\xf7\xf2\xe8\xbe\xd4\xa8\xa5\xf9\xa8%&Z A\x10F\xcd");
  }

  if(namespace_7b5dc905a7ea3e0f::function_7522bc12a8539615(activityinstance)) {
    conditional_container::addcondition(activityinstance.participationconditions, &function_624a63e5f91350ed, [activityinstance], undefined, "\x17\xcf\xd3/\xdaC\xf3\xf5\xd5\xb22B\xfe\x98\x1fT\xa5\x1b\xc5N\xbbc&\xd5\xf7t\xf2\xc3n%O\x10\xa4\xef\xcdnj&gU\xa6%\x03\x12\x9eQ\v\x86\xd4\x0e\x85NzR\xe5\xe0\x16fc\x02\xba\x8a\x9f$0\x0e\xd3o\xd2&\xb5\xf6\xe1\xe7\x06");
  }

  if(namespace_7b5dc905a7ea3e0f::function_653c923491d1ab8c(activityinstance)) {
    conditional_container::addcondition(activityinstance.participationconditions, &function_811447e230ab57ad, [activityinstance], undefined, "\xa5\xfe9\x14+\x7f\xe2\x854\xca8\xc7\x863\xa9\xf2\xfc\xc1\x11x\xf8L\xb3\xc6A\xac\x02(\x1bL\xae\xa8\x8a\"\xa9\xf5\x05\x86\x18\xfe\xd6p\xe3\x1e\x9aR9h\xa3\xf5s,y\x9f\xf0\xa1d");
  }

  if(namespace_7b5dc905a7ea3e0f::function_c179dc3eb1dee9f0(activityinstance)) {
    conditional_container::addcondition(activityinstance.participationconditions, &namespace_37b952684c0bbb5::function_498d303b601ec15f, [activityinstance], undefined, "\xde\xce\x15\x94\r\xb1\xd7\x8fY\xeb\x90\x11:\xc5\xbd9\xd4[\xb9\xeb\x9f\xf8\"\xbc/du\x9c\xa8C\a[!\xd3\x9a\x82:3\x98\xd6\x1a\xbf\xe3\x19X.\xdc(\f\x15\x12\xc6\x19\x90>\xcc0 \xb1\xf7%9\x0e\x18\xc0\x99\x86\xf4\x84~\x8cD\x182KH\xdb\xe4\xbb");
  }

  activitynexussettings = level.activities.activitynexussettings;

  if(istrue(activitynexussettings.var_42587ba75f9f7eb) && namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!")) {
    var_e26c75bd3ec607a = namespace_9342d78fcaacff0b::function_501d514afe3347(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!");

    if(var_e26c75bd3ec607a.size == 0) {
      namespace_59dbf6a1bb28a43f::function_64ede69dff6ba1ee(activityinstance, 1);
    }
  }

  if(namespace_7b5dc905a7ea3e0f::function_cdcd003e29297cbd(activityinstance, 0)) {
    function_d63495501c01318(activityinstance);
  }
}

function function_ea0b89936d9c8e9b(activityinstance) {
  if(namespace_7b5dc905a7ea3e0f::function_5c77bda56fe385e2(activityinstance)) {
    activityjoininteracts = activity_common::function_2ece6c60562ab130(8, [activityinstance], 0);
    activity_common::function_2ece6c60562ab130(7, [activityinstance, activityjoininteracts], 0);
  }
}

function function_cd96ccb96ce934e0(activityinstance, playerlist) {
  if(!isarray(playerlist) && isPlayer(playerlist)) {
    playerlist = [playerlist];
  } else if(!isarray(playerlist)) {
    assertmsg("<dev string:x24>");
    return;
  }

  var_d9dd55fbfaa7d504 = [];

  foreach(player in playerlist) {
    var_a0973df158d28bbc = function_8affb3892c86c88f(activityinstance, player);

    if(var_a0973df158d28bbc) {
      function_a99afa74dc1e4437(player, activityinstance);
      var_d9dd55fbfaa7d504[var_d9dd55fbfaa7d504.size] = player;
    }
  }

  if(var_d9dd55fbfaa7d504.size > 0) {
    relevantinfostruct = spawnStruct();
    relevantinfostruct.playerlist = var_d9dd55fbfaa7d504;
    namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "OO\x11h\xc0\xfc\xec\x1d\x9b\xedC", relevantinfostruct);

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x9a>", @ "hash_39bc09a8c55a7875", activityinstance, var_d9dd55fbfaa7d504);
  }
}

function function_53545468aace1532(activityinstance) {
  currentplayerparticipants = activityinstance.playerparticipants;
  function_cd96ccb96ce934e0(activityinstance, currentplayerparticipants);
}

function activityinstanceisfull(activityinstance) {
  return activityinstance.playerparticipants.size == namespace_7b5dc905a7ea3e0f::getmaxplayercount(activityinstance);
}

function function_9457dc2f26fe5857(player, varianttag) {
  var_1b9f16f7d49be9a1 = function_79fe72713d47a8d2(player);

  foreach(instanceinfostruct in var_1b9f16f7d49be9a1) {
    activityinstance = level.activities.instances[instanceid];

    if(activityinstance.varianttag == varianttag) {
      return true;
    }
  }

  return false;
}

function function_11eaa03f4f50d476(player) {
  var_1b9f16f7d49be9a1 = function_79fe72713d47a8d2(player);
  return var_1b9f16f7d49be9a1.size > 0;
}

function function_8affb3892c86c88f(activityinstance, player) {
  foundplayer = utility::array_find(activityinstance.playerparticipants, player);

  var_1b9f16f7d49be9a1 = function_79fe72713d47a8d2(player);
  foundinstanceid = var_1b9f16f7d49be9a1[activityinstance.id];

  if(isDefined(foundplayer) && !isDefined(foundinstanceid) || !isDefined(foundplayer) && isDefined(foundinstanceid)) {
    assertmsg("<dev string:xb4>");
  }

  if(isDefined(foundplayer)) {
    return true;
  }

  return false;
}

function function_f497c34b2b32567f(player, params) {
  assert(params.size == 2 && isDefined(params[0]), "<dev string:x113>");
  activityinstance = params[0];
  maxplayercount = params[1];
  instanceisfull = activityinstance.playerparticipants.size == maxplayercount;
  return !instanceisfull;
}

function function_5f67d30ab4cd9eb6(player, params) {
  assert(params.size == 2 && isDefined(params[0]) && isstring(params[1]), "<dev string:x113>");
  activityinstance = params[0];
  spatialzonename = params[1];

  if(!namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, spatialzonename)) {
    return 0;
  }

  var_2374d2a453dd30a8 = namespace_9342d78fcaacff0b::function_58f7e353fe6bde02(player, activityinstance, spatialzonename);
  return var_2374d2a453dd30a8;
}

function function_86f624d7403c3387(player, params) {
  assert(params.size == 1 && isDefined(params[0]), "<dev string:x113>");
  activityinstance = params[0];
  var_83a0fe5b4caf5dc0 = function_8affb3892c86c88f(activityinstance, player);
  return !var_83a0fe5b4caf5dc0;
}

function function_c1aeca2e80b39fd4(player, params) {
  assert(params.size == 1 && isDefined(params[0]), "<dev string:x113>");
  activityinstance = params[0];
  activitycurrentstate = activityinstance.state;

  if(activitycurrentstate == "\xa2\xb9\x19\x95d" || activitycurrentstate == "@Z'\v\x9eS\xce") {
    return false;
  }

  return true;
}

function function_624a63e5f91350ed(player, params) {
  assert(params.size == 1 && isDefined(params[0]), "<dev string:x113>");
  activityinstance = params[0];
  var_d58e9198be9fcab8 = function_9457dc2f26fe5857(player, activityinstance.varianttag);
  return !var_d58e9198be9fcab8;
}

function function_811447e230ab57ad(player, params) {
  return !function_11eaa03f4f50d476(player);
}

function function_d72c4caab34c1963(player, params) {
  return function_11eaa03f4f50d476(player);
}

function function_79fe72713d47a8d2(player) {
  var_aef1a83105e246b9 = namespace_37b952684c0bbb5::function_79f72c7180693dbf(player);
  return var_aef1a83105e246b9.var_aaad885ef05f0b04;
}

function private function_32320bee0a8c8be5(activityinstance, player) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  return isDefined(activityinstance.var_b154b83bb4c4016c[playerguid]);
}

function private function_cb47945f468e3421(activityinstance, player, firsttimeinzone) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  activityinstance.var_b154b83bb4c4016c[playerguid] = 1;
  relevantinfostruct = spawnStruct();
  relevantinfostruct.playerlist = [player];
  relevantinfostruct.firsttimeinzone = firsttimeinzone;
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\x05c\v^\xb2NTs\x1d\xacr\xca2(\xddX\xe4\xcas+ns\xb4\xed\x9b\x95", relevantinfostruct);
}

function private function_d21850176981ca23(activityinstance, player) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  activityinstance.var_b154b83bb4c4016c[playerguid] = undefined;
  relevantinfostruct = spawnStruct();
  relevantinfostruct.playerlist = [player];
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "O\xa1\x7f\xe6\xea\x0f\xf4\x97\xa6w\x1d(\xe6\xcem\x17\xa4y\xf1\xe6\xcee\xfb\xab\x18", relevantinfostruct);
}

function private function_341a4544c6ec1a5e() {
  var_d2eb8aba5c657d96 = level.activities;
  var_b824dd3c4b979d3a = var_d2eb8aba5c657d96.awakeinstances;
  var_60b4bbc62447db6e = [];

  foreach(instance in var_b824dd3c4b979d3a) {
    if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(instance, "\xa0\xdda\x9c\x95\xb9\x95\xdcs}K\xb7\xb9\x95")) {
      var_60b4bbc62447db6e[var_60b4bbc62447db6e.size] = instance;
    }
  }

  return var_60b4bbc62447db6e;
}

function private function_d80c0a3d4d303984(var_33811f0dcf8cbb6f) {
  activityinstance = self;
  spatialzonename = var_33811f0dcf8cbb6f.zonename;
  player = var_33811f0dcf8cbb6f.player;
  playerinzone = var_33811f0dcf8cbb6f.enteredzone;
  firsttimeinzone = var_33811f0dcf8cbb6f.firsttimeinzone;
  assert(namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance), "<dev string:x167>");
  assert(spatialzonename == "<dev string:x1be>", "<dev string:x1d0>");
  assert(isPlayer(player), "<dev string:x22d>");
  activitydefinition = namespace_7b5dc905a7ea3e0f::function_e2fc5d3b23f01ac5(activityinstance);

  if(playerinzone) {
    if(!function_32320bee0a8c8be5(activityinstance, player)) {
      function_cb47945f468e3421(activityinstance, player, firsttimeinzone);
    }

    return;
  }

  if(function_32320bee0a8c8be5(activityinstance, player)) {
    function_d21850176981ca23(activityinstance, player);
  }
}

function private function_a99afa74dc1e4437(player, activityinstance) {
  activityinstance.playerparticipants = arrayremove(activityinstance.playerparticipants, player);
  function_85e09431c3ced921(player, activityinstance);

  if(namespace_37b952684c0bbb5::function_babc4710523fb780(player, activityinstance)) {
    namespace_37b952684c0bbb5::function_6711c381a1686925(player);
  } else {
    namespace_37b952684c0bbb5::function_7845e2b0442da4c9(player, activityinstance);
  }

  namespace_37b952684c0bbb5::function_b53177e9d0bdd271(player);
  activityinstance notify("v\xf2\xbd\r*\xb7A=J.\xb3", player);
}

function private function_96e0bf517b20343(player, activityinstance, playerjoinreason) {
  var_dda479d8cd352517 = spawnStruct();
  var_dda479d8cd352517.var_a609a5a1b83d4ad7 = 0;
  var_dda479d8cd352517.joinreason = playerjoinreason;
  var_dda479d8cd352517.var_e5c7bd570a1db9e2 = 0;
  var_dda479d8cd352517.instanceid = activityinstance.id;
  return var_dda479d8cd352517;
}

function private function_450fe7772d33cecd(player, activityinstance, playerjoinreason) {
  var_dda479d8cd352517 = function_96e0bf517b20343(player, activityinstance, playerjoinreason);
  var_aef1a83105e246b9 = namespace_37b952684c0bbb5::function_79f72c7180693dbf(player);
  var_aef1a83105e246b9.var_aaad885ef05f0b04[activityinstance.id] = var_dda479d8cd352517;
}

function private function_85e09431c3ced921(player, activityinstance) {
  var_aef1a83105e246b9 = namespace_37b952684c0bbb5::function_79f72c7180693dbf(player);

  if(isDefined(var_aef1a83105e246b9.var_aaad885ef05f0b04[activityinstance.id])) {
    var_aef1a83105e246b9.var_aaad885ef05f0b04[activityinstance.id] = undefined;
  }
}

function function_77c68947e5872fe5() {}

function function_9104dfe03a55a17(activityinstance, playerlist, playerjoinreason = "\x98\x81G\n68\x06\x01\x9d\xd1Q\xdcd\x85\xfa\x02\xe2") {
  if(!isarray(playerlist) && isPlayer(playerlist)) {
    playerlist = [playerlist];
  } else if(!isarray(playerlist)) {
    assertmsg("<dev string:x270>");
    return false;
  }

  var_bda58b2778abcd13 = function_79ea0b2e1ebdec01();

  foreach(player in playerlist) {
    function_ba7b4d3b346d0fd8(var_bda58b2778abcd13, activityinstance, player, playerjoinreason);
  }

  if(var_bda58b2778abcd13.var_a1377db78d49bd29.size > 0) {
    relevantinfostruct = spawnStruct();
    relevantinfostruct.playerlist = var_bda58b2778abcd13.var_a1377db78d49bd29;
    relevantinfostruct.playerjoinreason = playerjoinreason;
    namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "W\xbd\xdec\xf4x\xff\xd76\xfb", relevantinfostruct);

    if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_39bc09a8c55a7875")) {
      foreach(player in var_bda58b2778abcd13.var_a1377db78d49bd29) {
        playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
        joinreason = var_bda58b2778abcd13.var_f8b56824198c5bd8[playerguid];
        namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x2e5>" + joinreason, @ "hash_39bc09a8c55a7875", activityinstance, [player]);
      }
    }

  }

  foreach(player in playerlist) {
    if(!function_8affb3892c86c88f(activityinstance, player)) {
      namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x30e>", @ "hash_39bc09a8c55a7875", activityinstance, playerlist);

      return false;
    }
  }

  return true;
}

function function_6f5790139d95d44d(activityinstance) {
  if(!namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "<dev string:x35f>")) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x376>", @ "hash_39bc09a8c55a7875", activityinstance, undefined, 2);
  }

  activityinstance.var_3c0e60e9cb67f6f7 = 1;
}

function function_af34fe79395a6626(activityinstance) {
  activityinstance.var_3c0e60e9cb67f6f7 = 0;
  namespace_9342d78fcaacff0b::function_26732f46a05cc793(activityinstance, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82");
}

function function_ba8c8d437e61ee56(activityinstance) {
  return istrue(activityinstance.var_3c0e60e9cb67f6f7);
}

function function_d63495501c01318(activityinstance) {
  if(!namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "<dev string:x40f>")) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x429>", @ "hash_39bc09a8c55a7875", activityinstance, undefined, 2);
  }

  activityinstance.var_965315d5e3d4f86 = 1;
}

function function_64f1024c67894db7(activityinstance) {
  activityinstance.var_965315d5e3d4f86 = 0;
  namespace_9342d78fcaacff0b::function_26732f46a05cc793(activityinstance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad");
}

function function_499672a431609857(activityinstance) {
  return istrue(activityinstance.var_965315d5e3d4f86);
}

function function_46b002f5d82470b3(activityinstance) {
  activityjoininteracts = level.activities.var_222f418ee6bda53d[activityinstance.id] ?? [];

  if(isarray(activityjoininteracts) && activityjoininteracts.size > 0) {
    relevantinfostruct = {
      #playerlist: level.players ?? level.player
    };
    relevantinfostruct.joininteracts[activityinstance.id] = activityjoininteracts;
    function_d64a823052f1ea8b(relevantinfostruct);
  }
}

function function_d64a823052f1ea8b(relevantinfostruct) {
  activitynexussettings = level.activities.activitynexussettings;
  var_85893776b640b042 = getdvarfloat(@ "hash_556de73f87d68d35", activitynexussettings.var_c11ff22bbe2e4b90);
  var_222f418ee6bda53d = relevantinfostruct.joininteracts ?? level.activities.var_222f418ee6bda53d;
  relevantinfostruct thread utility::function_40167ba6ee5e9c37(var_222f418ee6bda53d, &function_8e03fe570e9110f6, undefined, undefined, var_85893776b640b042, 0);
}

function function_8541b9726c7b8189(relevantparameters) {
  activityinstance = relevantparameters[0];
  interactscriptables = relevantparameters[1];

  foreach(interactscriptable in interactscriptables) {
    interactscriptable.var_ff3af361fe69cde9 = {
      #joincallbackfunction: undefined, #var_41df5824c4f6cd83: 0, #activityinstance: activityinstance
    };
  }

  activity_scriptables::function_4ce9e4679dd6f585(activityinstance, interactscriptables);
}

function function_4f3ab0aa90f90c32(interactscriptable, var_74538242f7259332, callbackfunction) {
  activityinstance = self;

  if(isDefined(interactscriptable)) {
    interactscriptable.var_ff3af361fe69cde9 = {
      #joincallbackfunction: callbackfunction, #var_41df5824c4f6cd83: istrue(var_74538242f7259332), #activityinstance: activityinstance
    };
    activity_scriptables::function_4ce9e4679dd6f585(activityinstance, interactscriptable);
    return;
  }

  assertmsg("<dev string:x4b8>" + activityinstance.varianttag + "<dev string:x4ed>");
}

function function_6f5e5fd2292fd207(relevantparameters) {
  var_84e4ab0ac5bfe722 = [];
  activityinstance = relevantparameters[0];
  activityvariantname = activityinstance.varianttag;
  activitydefinition = activityinstance namespace_7b5dc905a7ea3e0f::function_e2fc5d3b23f01ac5();
  scriptableasset = namespace_7b5dc905a7ea3e0f::function_c69faaa88b7628a4(activitydefinition);

  for(variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname); isDefined(variantscriptstructinfo); variantscriptstructinfo = undefined) {
    variantstruct = variantscriptstructinfo.variantstruct;
    linkedstructs = variantscriptstructinfo.linkedstructs;

    foreach(linkedstruct in linkedstructs) {
      var_970f243937a038cc = linkedstruct.targetname === "Zf\xb0O{qS\x95?\x8c\x97\x14%\xb2/\xf8\xddE\xb9L=\v}\x97i\x8b\xfe.\x81\xa8";

      if(var_970f243937a038cc) {
        joininteractscriptable = spawnscriptable(scriptableasset, linkedstruct.origin, linkedstruct.angles);
        var_84e4ab0ac5bfe722[var_84e4ab0ac5bfe722.size] = joininteractscriptable;
      }
    }

    parentactivityvariantname = variantstruct.parent;

    if(isstring(parentactivityvariantname)) {
      variantscriptstructinfo = activity_common::function_d4c38791b19a0631(parentactivityvariantname);
      continue;
    }
  }

  return var_84e4ab0ac5bfe722;
}

function function_f0553aeacf59b1db(enttodamage, callbackfunction) {
  function_33458e997a19861f([enttodamage], callbackfunction);
}

function function_33458e997a19861f(entstodamage, callbackfunction) {
  foreach(ent in entstodamage) {
    thread function_f099f36156946d99(self, ent, callbackfunction);
    thread function_d8b45ceffd7f496a(self, ent, callbackfunction);
  }
}

function function_b5fc8c8d490c4cee(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance) && isDefined(instance.var_ff3af361fe69cde9)) {
    var_e5c018a2a0bf951b = instance.var_ff3af361fe69cde9.activityinstance;

    if(istrue(instance.var_ff3af361fe69cde9.var_41df5824c4f6cd83) && activityinstanceisfull(var_e5c018a2a0bf951b)) {
      varianttag = instance.var_ff3af361fe69cde9.activityinstance.varianttag;
      var_e5c018a2a0bf951b = activity_common::function_8dd743a740eceb88(varianttag);
    }

    if(isDefined(var_e5c018a2a0bf951b) && !function_8affb3892c86c88f(var_e5c018a2a0bf951b, player)) {
      playedjoined = function_9104dfe03a55a17(var_e5c018a2a0bf951b, player, "4\n+\bJ#si\xf0c\x0f\\\xc9\x10~\xd8\xb4\"&\xfc");

      if(playedjoined && isDefined(instance.var_ff3af361fe69cde9.joincallbackfunction)) {
        var_e5c018a2a0bf951b[[instance.var_ff3af361fe69cde9.joincallbackfunction]](var_e5c018a2a0bf951b, instance, player);
      }
    }
  }
}

function private function_1bfda922d7023efd(activityinstance, player, playerjoinreason) {
  var_538a0b9f70c22551 = activityinstance.playerparticipants.size >= namespace_7b5dc905a7ea3e0f::getminplayercount(activityinstance);
  var_365e163e7b7e4fbb = activityinstanceisfull(activityinstance);
  activityinstance.playerparticipants[activityinstance.playerparticipants.size] = player;
  function_450fe7772d33cecd(player, activityinstance, playerjoinreason);
  namespace_37b952684c0bbb5::function_b53177e9d0bdd271(player);
  activityinstance notify("\xf2f\x1b(\xd5\xa2}\xab(\x90\x89\v\xc6", player);
  namespace_59dbf6a1bb28a43f::function_64ede69dff6ba1ee(activityinstance, 0);

  if(activityinstanceisfull(activityinstance) && !var_365e163e7b7e4fbb) {
    activityinstance notify("\xe4U\x11\xa5\xd9\x1f\xb4\x19U!KS!\xbc\xf3\xfc\x02m\x9f\x94S2\x96\x89c\xf4\x0e1");
    return;
  }

  if(activityinstance.playerparticipants.size >= namespace_7b5dc905a7ea3e0f::getminplayercount(activityinstance) && !var_538a0b9f70c22551) {
    if(namespace_59dbf6a1bb28a43f::function_7bb0764c0a7ee082(activityinstance, "\xaa\xec\xa1\v\xa4\xdd\r\v\x0e)\xff\xc2\xbfnT\xeb\xed@T\r\x1f\v\x1c\x16.\xc2i\x86\x83q\a\xc1\xe1\x0f\xec\x91")) {
      namespace_59dbf6a1bb28a43f::function_30a12e4e4ff02ec8(activityinstance, "\xaa\xec\xa1\v\xa4\xdd\r\v\x0e)\xff\xc2\xbfnT\xeb\xed@T\r\x1f\v\x1c\x16.\xc2i\x86\x83q\a\xc1\xe1\x0f\xec\x91", "\xe3~m\xa9\xe02\brw\x8d7\xf4\xb5hS\x01\xc1\x16k\xa4\xadU8Dr4\x16\xe8N\xf8\x12q!N\xec\xc5\xe5");
    }

    activityinstance notify("\xf1\x99\x18\x05\x98\\9+\x19\x9a\xa8\x0f\xce5P\xe9Y\xcam\x11\x9d~\xf9|\xbd\x9aHY");
  }
}

function private function_bccdd39d7b9587f4(var_33811f0dcf8cbb6f) {
  activityinstance = self;
  spatialzonename = var_33811f0dcf8cbb6f.zonename;
  player = var_33811f0dcf8cbb6f.player;
  playerinzone = var_33811f0dcf8cbb6f.enteredzone;
  assert(namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance), "<dev string:x167>");
  assert(spatialzonename == "<dev string:x35f>", "<dev string:x507>");
  assert(isPlayer(player), "<dev string:x22d>");

  if(playerinzone) {
    function_9104dfe03a55a17(activityinstance, player, "\x82\x93\xa7\xb8}jx\x8f\xefq>4\x95\xfbWs\x11\xf7\x17\xb1Y");
  }
}

function private function_be7365cf6080a15f(var_33811f0dcf8cbb6f) {
  activityinstance = self;
  spatialzonename = var_33811f0dcf8cbb6f.zonename;
  player = var_33811f0dcf8cbb6f.player;
  playerinzone = var_33811f0dcf8cbb6f.enteredzone;
  assert(namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance), "<dev string:x167>");
  assert(spatialzonename == "<dev string:x40f>", "<dev string:x569>");
  assert(isPlayer(player), "<dev string:x22d>");

  if(!playerinzone && function_499672a431609857(activityinstance)) {
    function_72ea4ca73cc078d(activityinstance, player);
  }
}

function private function_db7fe7415eb675be() {
  var_d2eb8aba5c657d96 = level.activities;
  var_b824dd3c4b979d3a = var_d2eb8aba5c657d96.awakeinstances;
  var_2e7939062215c7f6 = [];

  foreach(instance in var_b824dd3c4b979d3a) {
    var_56e1e5b080c21df5 = instance.playerparticipants.size;
    var_4f4934ff539a085d = namespace_7b5dc905a7ea3e0f::getmaxplayercount(instance);

    if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(instance, "\xc7=\x8d\xdaq\x05\xa1\x80d8\x16\xb0\xe8\x13\xd2\xd0\xb9^\x82") && function_ba8c8d437e61ee56(instance) && var_56e1e5b080c21df5 < var_4f4934ff539a085d) {
      var_2e7939062215c7f6[var_2e7939062215c7f6.size] = instance;
    }
  }

  return var_2e7939062215c7f6;
}

function private function_3ac2b590a978046d() {
  var_d2eb8aba5c657d96 = level.activities;
  var_b824dd3c4b979d3a = var_d2eb8aba5c657d96.awakeinstances;
  var_cac984915fd1679f = [];

  foreach(instance in var_b824dd3c4b979d3a) {
    var_56e1e5b080c21df5 = instance.playerparticipants.size;

    if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(instance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad") && function_499672a431609857(instance) && var_56e1e5b080c21df5 > 0) {
      var_cac984915fd1679f[var_cac984915fd1679f.size] = instance;
    }
  }

  return var_cac984915fd1679f;
}

function private function_f806055ce67b6f3e() {
  var_d2eb8aba5c657d96 = level.activities;
  return var_d2eb8aba5c657d96.var_c4e34647ad777d79;
}

function private function_c589824253f9d0ce(var_33811f0dcf8cbb6f) {
  activityinstance = self;
  spatialzonename = var_33811f0dcf8cbb6f.zonename;
  player = var_33811f0dcf8cbb6f.player;
  playerinzone = var_33811f0dcf8cbb6f.enteredzone;
  var_d3d20534b62b4ba6 = [[var_33811f0dcf8cbb6f.var_ba782b7c5f72c30d]](var_33811f0dcf8cbb6f);
  assert(namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance), "<dev string:x167>");
  assert(spatialzonename == "<dev string:x5ce>", "<dev string:x5e2>");
  assert(isPlayer(player), "<dev string:x22d>");

  if(playerinzone) {
    namespace_59dbf6a1bb28a43f::function_64ede69dff6ba1ee(activityinstance, 0);
    return;
  }

  if(var_d3d20534b62b4ba6.size == 0 && activityinstance.playerparticipants.size == 0) {
    namespace_59dbf6a1bb28a43f::function_64ede69dff6ba1ee(activityinstance, 1);
  }
}

function private function_f099f36156946d99(activityinstance, ent, callbackfunction) {
  ent endon("\x1e\xfd\xd1\xa2\a");
  activityinstance endon("\x85ct\x96\x9d-:\xf2\xaf\x957dV\x8c");
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    ent waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    function_3287ec932145997c(activityinstance, ent, attacker, callbackfunction);
    waitframe();
  }
}

function private function_d8b45ceffd7f496a(activityinstance, ent, callbackfunction) {
  activityinstance endon("\x85ct\x96\x9d-:\xf2\xaf\x957dV\x8c");
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  ent waittill("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath);
  function_3287ec932145997c(activityinstance, ent, attacker, callbackfunction);
}

function private function_3287ec932145997c(activityinstance, attacked, attacker, callbackfunction) {
  if(isDefined(attacker) && isPlayer(attacker) && !function_8affb3892c86c88f(activityinstance, attacker)) {
    playerjoined = function_9104dfe03a55a17(activityinstance, attacker, "n\x02\xce\x1a[,\x19\xacg\xc0\x11\xcfd~\xba\xf3?.");

    if(playerjoined && isDefined(callbackfunction)) {
      [[callbackfunction]](activityinstance, attacked, attacker);
    }
  }
}

function private function_8e03fe570e9110f6(var_af4a4e4f7948862e, activityinstanceid) {
  playerlist = self.playerlist;

  foreach(player in playerlist) {
    if(isPlayer(player) && var_af4a4e4f7948862e.size > 0 && namespace_59dbf6a1bb28a43f::isactivityinstance(var_af4a4e4f7948862e[0].associatedactivityinstance)) {
      activityinstance = var_af4a4e4f7948862e[0].associatedactivityinstance;
      playerparticipationconditions = activityinstance.participationconditions;
      var_1e2ae78ba0e80b18 = conditional_container::function_ac8003c33335a40f(playerparticipationconditions, player);

      foreach(activityjoininteract in var_af4a4e4f7948862e) {
        if(isDefined(activityjoininteract)) {
          if(istrue(var_1e2ae78ba0e80b18)) {
            activityjoininteract enablescriptableplayeruse(player);
            continue;
          }

          activityjoininteract disablescriptableplayeruse(player);
        }
      }
    }
  }
}

function private function_79ea0b2e1ebdec01() {
  var_bda58b2778abcd13 = spawnStruct();
  var_bda58b2778abcd13.var_a1377db78d49bd29 = [];
  var_bda58b2778abcd13.var_f8b56824198c5bd8 = [];
  return var_bda58b2778abcd13;
}

function private function_ba7b4d3b346d0fd8(var_bda58b2778abcd13, activityinstance, player, playerjoinreason = "\x98\x81G\n68\x06\x01\x9d\xd1Q\xdcd\x85\xfa\x02\xe2", var_b4d448098308ff51 = 1) {
  var_2b58f9e92da9d191 = conditional_container::function_842ec868071aa01(activityinstance.participationconditions, player);

  if(var_2b58f9e92da9d191.var_7e345f8f7da0e7f) {
    function_1bfda922d7023efd(activityinstance, player, playerjoinreason);
    playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
    var_bda58b2778abcd13.var_a1377db78d49bd29[var_bda58b2778abcd13.var_a1377db78d49bd29.size] = player;
    var_bda58b2778abcd13.var_f8b56824198c5bd8[playerguid] = playerjoinreason;

    if(var_b4d448098308ff51) {
      activitydefinition = activityinstance namespace_7b5dc905a7ea3e0f::function_e2fc5d3b23f01ac5();
      var_7589af34df2cc3cf = namespace_7b5dc905a7ea3e0f::function_2bf68c0249646099(activitydefinition);

      if(var_7589af34df2cc3cf) {
        var_dadf389f50104f5 = namespace_37b952684c0bbb5::function_e8bf648cc92f890a(player);

        foreach(playersquadgroupmember in var_dadf389f50104f5) {
          if(player != playersquadgroupmember && !function_8affb3892c86c88f(activityinstance, playersquadgroupmember)) {
            function_ba7b4d3b346d0fd8(var_bda58b2778abcd13, activityinstance, playersquadgroupmember, "\xb4\x18y[\x8a\xec\xe0\x94\xa8\xab\x06\x8cLc\xfd\xa8a", 0);
          }
        }
      }
    }

    return;
  }

  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_39bc09a8c55a7875")) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x641>" + var_2b58f9e92da9d191.var_fee0db179ee578bb, @ "hash_39bc09a8c55a7875", activityinstance, [player]);
  }
}

function function_f81f737fbc6462a6() {}

function function_b3a7e569f8bbdb4d(activityinstance, playerlist, var_d45aea9aaec67b33 = 1, var_eb38f3407fc29499 = 0) {
  if(var_eb38f3407fc29499) {
    foreach(player in playerlist) {
      function_3c6efb80af8bae9a(activityinstance, player);
    }
  }

  function_db9f8c27a19142f2(activityinstance, playerlist, var_d45aea9aaec67b33);
}

function function_8ef13db61a93e631(activityinstance, player) {
  var_dadf389f50104f5 = namespace_37b952684c0bbb5::function_e8bf648cc92f890a(player);
  var_eb38f3407fc29499 = 0;
  function_b3a7e569f8bbdb4d(activityinstance, var_dadf389f50104f5, undefined, var_eb38f3407fc29499);
}

function function_3c6efb80af8bae9a(activityinstance, player, var_d45aea9aaec67b33 = 1, var_22fc0e339af3202c) {
  var_eb38f3407fc29499 = 0;
  abandontriggercomplete = 0;

  if(!namespace_37b952684c0bbb5::function_4a5de9d7a4dc0aaa(player, activityinstance)) {
    namespace_37b952684c0bbb5::function_e939c6c01e8713c7(player, activityinstance);

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x6ab>", @ "hash_39bc09a8c55a7875", activityinstance, [player]);

    var_92b51f8a230ac48d = activityinstance function_3e6ccca113a3a2e6(activityinstance, player, var_d45aea9aaec67b33, var_22fc0e339af3202c);
    namespace_37b952684c0bbb5::function_b994ea8054b06764(player, activityinstance);

    if(istrue(var_92b51f8a230ac48d)) {
      abandontriggercomplete = 1;
    }
  }

  if(abandontriggercomplete) {
    function_db9f8c27a19142f2(activityinstance, [player], var_d45aea9aaec67b33);
  }
}

function function_eac0583a696a029e(activityinstance, player, abandontriggertype, var_22fc0e339af3202c) {
  activitydefinition = activityinstance namespace_7b5dc905a7ea3e0f::function_e2fc5d3b23f01ac5();
  var_f0b9f723742a805a = namespace_7b5dc905a7ea3e0f::function_644fd4af8d9cc127(activitydefinition, abandontriggertype);
  var_d507f95a8be65654 = namespace_7b5dc905a7ea3e0f::function_7df855ef2ada1d3c(activitydefinition, abandontriggertype);

  if(istrue(var_d507f95a8be65654)) {
    function_3c6efb80af8bae9a(activityinstance, player, var_f0b9f723742a805a, var_22fc0e339af3202c);
    return;
  }

  function_b3a7e569f8bbdb4d(activityinstance, [player], var_f0b9f723742a805a);
}

function private function_72ea4ca73cc078d(activityinstance, player) {
  var_29f2375265c7654e = function_8affb3892c86c88f(activityinstance, player);

  if(var_29f2375265c7654e) {
    var_a50a2365131279fa = spawnStruct();
    var_a50a2365131279fa conditional_container::function_e235be9fe32422e8();
    conditional_container::addcondition(var_a50a2365131279fa, &function_5f67d30ab4cd9eb6, [activityinstance, "(\xd4\xd3\r\xeb\xfd\x1a\b\x9dN\x9dF\x1f\xcd\xf0_\xb5/\x82\x17\x9d\xad"]);
    function_eac0583a696a029e(activityinstance, player, 0, var_a50a2365131279fa);
  }
}

function private function_1652595b955a7077(player, broadcastinstances) {
  player_broadcasting::function_5f83660de1065dc(player, broadcastinstances);

  if(!isDefined(level.var_55e3c6982c284449)) {
    level.var_55e3c6982c284449 = [];
  }

  if(isDefined(level.var_55e3c6982c284449["\x1bNV\xb0\x8e+"]) && namespace_37b952684c0bbb5::function_babc4710523fb780(player, self)) {
    self[[level.var_55e3c6982c284449["\x1bNV\xb0\x8e+"]]](player);
  }
}

function private function_1c69004bb38a6b88(player, var_827d5f569a1ce2a7) {
  if(isDefined(level.var_55e3c6982c284449["\xeb\x8fq\xaa\xb4i"]) && namespace_37b952684c0bbb5::function_babc4710523fb780(player, self)) {
    self[[level.var_55e3c6982c284449["\xeb\x8fq\xaa\xb4i"]]](player, var_827d5f569a1ce2a7);
  }
}

function private function_f86587ab6fc00255(player, broadcastinstances) {
  player_broadcasting::function_ae1c9688d4af6d10(player, broadcastinstances);

  if(isDefined(level.var_55e3c6982c284449["\xc0Z'\v\x9eS\xce"])) {
    relevantinfostruct = spawnStruct();
    relevantinfostruct.playerlist = [player];
    self[[level.var_55e3c6982c284449["\xc0Z'\v\x9eS\xce"]]](relevantinfostruct);
  }
}

function private function_3e6ccca113a3a2e6(activityinstance, player, var_f0b9f723742a805a, var_22fc0e339af3202c) {
  activityinstance endon("\x85ct\x96\x9d-:\xf2\xaf\x957dV\x8c");
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  broadcastinstances = undefined;
  var_92b51f8a230ac48d = 0;

  if(var_f0b9f723742a805a) {
    broadcastinstances = activityinstance namespace_59b081b19a436abb::function_745842809500734("fM\xef\xdf\x86\xc3\xa6\x87a\xb8\bv\x91\x17]\xaf\xd4\x8b");
    activityinstance function_1652595b955a7077(player, broadcastinstances);
  }

  var_3dc500d2cc3d170d = gettime();
  activitynexussettings = level.activities.activitynexussettings;
  var_20a9d39b5ab3e460 = activitynexussettings.var_3581f45f2eb74fce;

  while(true) {
    var_5cddad9708503a49 = gettime();
    var_827d5f569a1ce2a7 = (var_5cddad9708503a49 - var_3dc500d2cc3d170d) / 1000;
    var_6db855fc41dd4adc = 0;

    if(isDefined(var_22fc0e339af3202c) && var_22fc0e339af3202c conditional_container::function_c8c41d427db6c4ef()) {
      var_6db855fc41dd4adc = conditional_container::function_ac8003c33335a40f(var_22fc0e339af3202c, player);
    }

    if(var_6db855fc41dd4adc) {
      break;
    } else if(var_827d5f569a1ce2a7 >= var_20a9d39b5ab3e460) {
      namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x6dd>", @ "hash_39bc09a8c55a7875", activityinstance, [player]);

      var_92b51f8a230ac48d = 1;
      break;
    } else if(var_f0b9f723742a805a) {
      activityinstance function_1c69004bb38a6b88(player, var_827d5f569a1ce2a7);
    }

    waitframe();
  }

  if(var_f0b9f723742a805a) {
    activityinstance function_f86587ab6fc00255(player, broadcastinstances);
  }

  return var_92b51f8a230ac48d;
}

function private function_db9f8c27a19142f2(activityinstance, playerlist, var_d45aea9aaec67b33) {
  if(var_d45aea9aaec67b33) {
    activityinstance namespace_606113cb7b23f701::function_456ea35b858c52a1("\x1f\xc5\x82x\x93\xd1V\xc5\xad`\xb7W[\xe2~Q\x95c\x03}\xff\xdaDI\x8c", playerlist);
  }

  function_cd96ccb96ce934e0(activityinstance, playerlist);
  relevantinfostruct = spawnStruct();
  relevantinfostruct.playerlist = playerlist;
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\xaf\x19f\x93\xc1\xcbU/AA\x89\x869", relevantinfostruct);
}

function function_8fdc368fbe72317d() {}

function function_97e334200c36968b(player) {
  var_e9a1684ec90d2a82 = spawnStruct();
  var_e9a1684ec90d2a82.var_b9708ce64283674 = 1;
  var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79 = [];
  var_e9a1684ec90d2a82.var_a3b31be32fd9b13c = [];
  var_952b087207f6c610 = function_79fe72713d47a8d2(player);

  foreach(activityinfostruct in var_952b087207f6c610) {
    activityinstance = level.activities.instances[activityinstanceid];
    activityinstancecategory = activityinstance.category;
    var_e9a1684ec90d2a82 function_35e0bcab41429e73(activityinstance, activityinstancecategory);

    if(namespace_7b5dc905a7ea3e0f::function_c179dc3eb1dee9f0(activityinstance)) {
      var_e9a1684ec90d2a82 function_31a15f1db373e8c0(activityinstance, activityinstancecategory);
    }
  }

  return var_e9a1684ec90d2a82;
}

function function_b9708ce64283674(var_f19324bad6cf2556) {
  return isstruct(var_f19324bad6cf2556) && istrue(var_f19324bad6cf2556.var_b9708ce64283674);
}

function function_bdef902a9599dbc3(activityinstancecategory) {
  var_e9a1684ec90d2a82 = self;
  assert(function_b9708ce64283674(var_e9a1684ec90d2a82), "<dev string:x728>");

  if(isDefined(var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory])) {
    var_4710226bef719a9d = var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory].size;
    return (var_4710226bef719a9d > 0);
  }

  return false;
}

function function_7e508747fa926980(activityinstancecategory) {
  var_e9a1684ec90d2a82 = self;
  assert(function_b9708ce64283674(var_e9a1684ec90d2a82), "<dev string:x728>");

  if(isDefined(var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory])) {
    var_4710226bef719a9d = var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory].size;
    return (var_4710226bef719a9d > 0);
  }

  return false;
}

function private function_35e0bcab41429e73(activityinstance, activityinstancecategory) {
  var_e9a1684ec90d2a82 = self;
  assert(function_b9708ce64283674(var_e9a1684ec90d2a82), "<dev string:x728>");

  if(!isDefined(var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory])) {
    var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory] = [];
  }

  var_82713fd094edcf87 = var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory].size;
  var_e9a1684ec90d2a82.var_1e7ac4cbf90e3f79[activityinstancecategory][var_82713fd094edcf87] = activityinstance;
}

function private function_31a15f1db373e8c0(activityinstance, activityinstancecategory) {
  var_e9a1684ec90d2a82 = self;
  assert(function_b9708ce64283674(var_e9a1684ec90d2a82), "<dev string:x728>");

  if(!isDefined(var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory])) {
    var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory] = [];
  }

  var_82713fd094edcf87 = var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory].size;
  var_e9a1684ec90d2a82.var_a3b31be32fd9b13c[activityinstancecategory][var_82713fd094edcf87] = activityinstance;
}