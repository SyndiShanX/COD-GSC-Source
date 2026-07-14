/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_569138730a0a130f.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_31805e8ef07bfa53;
#using script_4e1f1a7ef824ddd5;
#using script_50cece4fabbdcc75;
#using script_570f992e202c79b4;
#using script_69192f0994851b83;
#using script_77873e194e406c6d;
#using script_cf99d60d77d12eb;
#using script_f01501ac138f999;
#using scripts\common\conditional_container;
#using scripts\common\data_tracker;
#using scripts\common\devgui;
#using scripts\common\player_broadcasting;
#namespace namespace_606113cb7b23f701;

function function_134663eb84773a73(var_d2eb8aba5c657d96) {
  activitynexussettings = level.activities.activitynexussettings;
  var_d2eb8aba5c657d96.var_f64d5c67db3bc1ae = namespace_98284635f20f4696::function_76d178aa5df68fe1(activitynexussettings.var_cde4840400c62a99);
  var_d2eb8aba5c657d96.var_a3159e74ca5718f5 = [];
  var_d2eb8aba5c657d96.var_a3159e74ca5718f5["\xe9\xa4#\xa3\x01\x8a\x88X\x03$r"] = "K\xd3\x9by\xa3";
  player_broadcasting::function_ebe5e369860d93f6();
  player_broadcasting::function_b316d063f57a67f3("k\xc1\x85.#\xfad\xd60\xd0", &namespace_654eea393c3f72dd::function_e036cc81bda82998);
  player_broadcasting::function_b316d063f57a67f3("\x9a\xd1\x93\xb4\x9bv\x92+3\xb2\xe4e\xdccV", &namespace_654eea393c3f72dd::function_a7ff66580a7a774d);
  player_broadcasting::function_b316d063f57a67f3("\xce'\x18{\xf6\x9d", &namespace_654eea393c3f72dd::function_8940a3f1045a83fd);
}

function function_4fb0d88fb39268a7(activityinstance) {
  var_39fe1588b9336792 = activityinstance.var_5c5a5daba1ab602f;

  if(!isDefined(var_39fe1588b9336792.var_5f6cf2344ea3811c)) {
    var_39fe1588b9336792.var_5f6cf2344ea3811c = [];
  }

  var_40df77b7bf9c2521 = namespace_7b5dc905a7ea3e0f::function_e516262c61529d3b(activityinstance);
  var_a696fa955c795aef = level.activities.activitymoments;
  var_a696fa955c795aef[var_a696fa955c795aef.size] = "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf";

  foreach(activitymoment in var_a696fa955c795aef) {
    var_de1268f9a1cbdc05 = var_40df77b7bf9c2521.var_b697c59ea7cd5e7a[activitymoment];

    if(isDefined(var_de1268f9a1cbdc05) && var_de1268f9a1cbdc05.size > 0) {
      var_39fe1588b9336792.var_5f6cf2344ea3811c[activitymoment] = 1;
    }
  }
}

function function_591fcf2786538e49(activityinstance, activationmoment) {
  var_39fe1588b9336792 = activityinstance.var_5c5a5daba1ab602f;

  if(!isDefined(var_39fe1588b9336792.var_5f6cf2344ea3811c)) {
    return undefined;
  }

  return istrue(var_39fe1588b9336792.var_5f6cf2344ea3811c[activationmoment]);
}

function function_a338afe338efd1e2(activityinstance, dataobject) {
  uniquename = data_tracker::function_cea19ed755e885d1(dataobject);

  foreach(activebroadcastinstance in activityinstance.activebroadcasts) {
    if(namespace_59b081b19a436abb::function_9c2ff2e93fc54c93(activebroadcastinstance, uniquename)) {
      player_broadcasting::updatebroadcast(activebroadcastinstance);
    }
  }
}

function function_b6a212878f1730f3(playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>", @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  foreach(broadcast in self.activebroadcasts) {
    if(namespace_59b081b19a436abb::function_7ad7d3e8f5155f0d(broadcast)) {
      player_broadcasting::broadcasttoplayers(playerlist, broadcast);
    }
  }
}

function function_f16bf0a4de5ee6a3(broadcastinstance) {
  player_broadcasting::broadcasttoplayers(self.playerparticipants, broadcastinstance);
}

function broadcast(broadcastinstance, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x62>" + function_ab64a2737ced14a3(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  switch (broadcastinstance namespace_59b081b19a436abb::getbroadcastdestination()) {
    case #"hash_f29608411835dbd2":
      function_f16bf0a4de5ee6a3(broadcastinstance);
      break;
    case #"hash_fad3c75d039713f1":
      var_ee848ce8030c9efc = namespace_37b952684c0bbb5::function_e8bf648cc92f890a(playerlist[0]);
      player_broadcasting::broadcasttoplayers(var_ee848ce8030c9efc, broadcastinstance);
      break;
    case #"hash_f81f6f6ee4ce49a2":
      centerpoint = namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(self);
      var_2e261ac9f1a1fbda = namespace_59b081b19a436abb::function_7227738ad0add070(broadcastinstance);
      player_broadcasting::broadcasttoplayers(var_2e261ac9f1a1fbda, broadcastinstance);
      break;
    case #"hash_edac25dbcb316612":
      player_broadcasting::function_1db5bc1596f94873(broadcastinstance);
      break;
    case #"hash_ce0097f935cd75a8":
    default:
      player_broadcasting::broadcasttoplayers(playerlist, broadcastinstance);
      break;
  }

  if(namespace_59b081b19a436abb::function_64eaaafd454ed5c8(broadcastinstance)) {
    function_9882481e879802d9(broadcastinstance);
  }
}

function function_c0fdeb0e546292f6(activationmoment, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x88>" + activationmoment, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  if(activationmoment == "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf") {
    assertmsg("<dev string:xbd>");
    return;
  }

  broadcastinstancestructs = namespace_59b081b19a436abb::function_7c97484464e11e5f(activationmoment);

  foreach(broadcastinstance in broadcastinstancestructs) {
    if(!isDefined(playerlist)) {
      playerlist = self.playerparticipants;
    }

    broadcast(broadcastinstance, playerlist);
  }
}

function function_81895ae5aa01089d(uniquename, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x136>" + uniquename, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  activityinstance = self;
  broadcastinstancestructs = [];
  broadcastinstancestruct = namespace_59b081b19a436abb::function_cf7e2214a4e953a7(activityinstance, uniquename);

  if(isDefined(broadcastinstancestruct)) {
    broadcastinstancestructs = [broadcastinstancestruct];
  }

  function_20348a0a91111a7c(broadcastinstancestructs, uniquename, undefined, 0);
}

function function_ec81ed27168067f(uniquename, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x165>" + uniquename, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  activityinstance = self;
  broadcastinstancestructs = [];
  broadcastinstancestruct = namespace_59b081b19a436abb::function_cf7e2214a4e953a7(activityinstance, uniquename);

  if(isDefined(broadcastinstancestruct)) {
    broadcastinstancestructs = [broadcastinstancestruct];
  }

  function_20348a0a91111a7c(broadcastinstancestructs, uniquename, undefined, 1);
}

function function_4df0f3500d040513(uniquename) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x18f>" + uniquename + uniquename, @ "hash_3b38e79d9ffe7e9f", self);

  activityinstance = self;
  broadcastinstancestructs = [];
  broadcastinstancestruct = namespace_59b081b19a436abb::function_cf7e2214a4e953a7(activityinstance, uniquename);

  if(isDefined(broadcastinstancestruct)) {
    broadcastinstancestructs = [broadcastinstancestruct];
  }

  function_20348a0a91111a7c(broadcastinstancestructs, uniquename, undefined, 2);
}

function function_456ea35b858c52a1(activationname, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x1bc>" + activationname, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  broadcastinstancestructs = namespace_59b081b19a436abb::function_745842809500734(activationname);
  function_20348a0a91111a7c(broadcastinstancestructs, activationname, playerlist, 0);
}

function function_e2b246aea05de78(activationname, playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x1ef>" + activationname, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  broadcastinstancestructs = namespace_59b081b19a436abb::function_745842809500734(activationname);
  function_20348a0a91111a7c(broadcastinstancestructs, activationname, playerlist, 1);
}

function function_bd7be4b2391074e4(activitymoment) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x21d>" + activitymoment, @ "hash_3b38e79d9ffe7e9f", self);

  if(activitymoment == "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf") {
    assertmsg("<dev string:xbd>");
    return;
  }

  foreach(broadcastinstance in self.activebroadcasts) {
    deactivationmoment = broadcastinstance namespace_59b081b19a436abb::function_17e937c71acd5689();

    if(isDefined(deactivationmoment) && deactivationmoment == activitymoment) {
      player_broadcasting::function_46b7385da4a5b6cb(broadcastinstance);
      function_7ffc1147f7bde57a(broadcastinstance);
    }
  }
}

function function_7a722b783624554b(deactivationname) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x259>" + deactivationname, @ "hash_3b38e79d9ffe7e9f", self);

  foreach(broadcastinstance in self.activebroadcasts) {
    deactivationmoment = broadcastinstance namespace_59b081b19a436abb::function_17e937c71acd5689();
    name = broadcastinstance namespace_59b081b19a436abb::getdeactivationname();
    var_aee2c43bdf80e55b = isDefined(deactivationmoment) && deactivationmoment == "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf";
    deactivationnamematches = isDefined(name) && name == deactivationname;

    if(var_aee2c43bdf80e55b && deactivationnamematches) {
      player_broadcasting::function_46b7385da4a5b6cb(broadcastinstance);
      function_7ffc1147f7bde57a(broadcastinstance);
    }
  }
}

function function_903b20a9e9fa5e5f(playerlist) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x293>", @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  foreach(broadcastinstancestruct in self.activebroadcasts) {
    player_broadcasting::function_9e4fbd57e6f5cc6a(playerlist, broadcastinstancestruct);
  }
}

function getactivebroadcastinstance(broadcastuniqueid) {
  activebroadcast = undefined;

  if(isDefined(self.activebroadcasts[broadcastuniqueid])) {
    activebroadcast = self.activebroadcasts[broadcastuniqueid];
  }

  return activebroadcast;
}

function function_9284aafeae1d887c(broadcasttype) {
  var_d2eb8aba5c657d96 = level.activities;

  if(isDefined(var_d2eb8aba5c657d96.var_a3159e74ca5718f5[broadcasttype])) {
    return var_d2eb8aba5c657d96.var_a3159e74ca5718f5[broadcasttype];
  }

  return "\f+x5";
}

function function_c3d2ccc391f88e61(activityinstance, var_8d4f90cc962a4c9a, var_35e7a5f8ba3f10c4, var_7e96114525ef6e98) {
  var_9fb66fa0a4f4bbc2 = spawnStruct();
  var_9fb66fa0a4f4bbc2 conditional_container::function_e235be9fe32422e8();
  function_54796bc78139c23c(var_9fb66fa0a4f4bbc2, activityinstance, var_8d4f90cc962a4c9a, var_35e7a5f8ba3f10c4, var_7e96114525ef6e98);
  return var_9fb66fa0a4f4bbc2;
}

function function_54796bc78139c23c(var_d50971a00bef61c0, activityinstance, var_8d4f90cc962a4c9a = 1, var_35e7a5f8ba3f10c4 = 0, var_7e96114525ef6e98 = 1) {
  conditional_container::addcondition(var_d50971a00bef61c0, &namespace_37b952684c0bbb5::function_4632cd7a37598d79, []);

  if(istrue(var_35e7a5f8ba3f10c4)) {
    conditional_container::addcondition(var_d50971a00bef61c0, &activity_participation::function_86f624d7403c3387, [activityinstance]);
  }

  if(istrue(var_8d4f90cc962a4c9a)) {
    conditional_container::addcondition(var_d50971a00bef61c0, &namespace_37b952684c0bbb5::function_a96ddc512f30d9e5, [activityinstance]);
  }

  if(istrue(var_7e96114525ef6e98)) {
    conditional_container::addcondition(var_d50971a00bef61c0, &namespace_37b952684c0bbb5::function_f23a3aa391e6b908, []);
  }

  if(isDefined(level.activities.nexusoverrides[13])) {
    activity_common::function_2ece6c60562ab130(13, [var_d50971a00bef61c0, activityinstance], 0);
  }
}

function private function_20348a0a91111a7c(broadcastinstancestructs, activationname, playerlist, var_287e70635665d358) {
  if(!isDefined(playerlist)) {
    playerlist = self.playerparticipants;
  }

  foreach(broadcastinstancestruct in broadcastinstancestructs) {
    if(var_287e70635665d358 == 0) {
      broadcast(broadcastinstancestruct, playerlist);
      continue;
    }

    if(var_287e70635665d358 == 1) {
      player_broadcasting::function_9e4fbd57e6f5cc6a(playerlist, broadcastinstancestruct);
      continue;
    }

    if(var_287e70635665d358 == 2) {
      player_broadcasting::function_9e4fbd57e6f5cc6a(playerlist, broadcastinstancestruct);
      function_7ffc1147f7bde57a(broadcastinstancestruct);
    }
  }
}

function private function_9882481e879802d9(broadcastinstance) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x2c9>" + function_ab64a2737ced14a3(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self);

  uniqueid = broadcastinstance player_broadcasting::getbroadcastuniqueid();
  self.activebroadcasts[uniqueid] = broadcastinstance;
}

function private function_7ffc1147f7bde57a(broadcastinstance) {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x311>" + function_ab64a2737ced14a3(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self);

  uniqueid = broadcastinstance player_broadcasting::getbroadcastuniqueid();
  self.activebroadcasts[uniqueid] = undefined;
}

function private function_56800116cbcb26bf(activationname) {
  var_3882cb505e7fcda8 = [];

  foreach(activebroadcastinstance in self.activebroadcasts) {
    broadcastactivationname = activebroadcastinstance namespace_59b081b19a436abb::getactivationname();

    if(isDefined(broadcastactivationname) && broadcastactivationname == activationname) {
      var_3882cb505e7fcda8[var_3882cb505e7fcda8.size] = activebroadcastinstance;
    }
  }

  return var_3882cb505e7fcda8;
}

function private function_ab64a2737ced14a3(broadcastinstance) {
  broadcastinfostring = "\b& 9\xde\x16F\xd8\x16s\x8e\x8e\x01t/\x1c\xac\xa3 " + broadcastinstance player_broadcasting::getbroadcasttype() + "@Eb\xe8i\xb5f&ogz(" + broadcastinstance player_broadcasting::getbroadcastuniqueid() + "\xd4\xf4\xba+\xfaLV\x19\x9b\xa6\x92\xf9\x02r" + broadcastinstance namespace_59b081b19a436abb::getbroadcastdestination();
  return broadcastinfostring;
}

function function_498f8fd6502247cd() {
  var_dbcd872624d6de5f = namespace_265c578c971c82f5::function_7a5a72c9a4717349();
  devgui::function_fc97f67ff432e7de(var_dbcd872624d6de5f + "<dev string:x35e>");
  devgui::function_3ee29fdc6a8bf10("<dev string:x38f>", "<dev string:x3c4>" + "<dev string:x3d6>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x3ec>", "<dev string:x3c4>" + "<dev string:x41f>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x42e>", "<dev string:x3c4>" + "<dev string:x463>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x474>", "<dev string:x3c4>" + "<dev string:x4a7>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x4b6>", "<dev string:x3c4>" + "<dev string:x4ed>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x500>", "<dev string:x3c4>" + "<dev string:x537>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x54a>", "<dev string:x3c4>" + "<dev string:x57c>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x58a>", "<dev string:x3c4>" + "<dev string:x5bd>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_3ee29fdc6a8bf10("<dev string:x5cc>", "<dev string:x3c4>" + "<dev string:x60f>" + "<dev string:x3e7>", &function_42f906381c0915b5);
  devgui::function_9c2be2438708a992();
}

function private function_42f906381c0915b5(params) {
  hostplayer = undefined;

  if(isDefined(level.players)) {
    hostplayer = level.players[0];
  } else {
    hostplayer = level.player;
  }

  if(isDefined(hostplayer) && isPlayer(hostplayer) && isDefined(hostplayer.activities.focusedactivityid)) {
    id = hostplayer.activities.focusedactivityid;
    instance = level.activities.instances[id];
    moment = params[0];

    if(moment == "<dev string:x57c>" || moment == "<dev string:x5bd>" || moment == "<dev string:x60f>") {
      instance function_c0fdeb0e546292f6(moment, [hostplayer]);
      return;
    }

    instance function_c0fdeb0e546292f6(moment, instance.playerparticipants);
  }
}

# /