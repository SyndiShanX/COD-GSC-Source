/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1aae2eb1ef28b239.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_31805e8ef07bfa53;
#using script_3e31016b9c11a616;
#using script_4a2005cdcbf64b88;
#using script_50cece4fabbdcc75;
#using script_569138730a0a130f;
#using script_6852b85528e74b9b;
#using script_6d60a2f06878900a;
#using script_73a03aaf11b641f5;
#using script_77873e194e406c6d;
#using script_b90e9249b83faa5;
#using script_f01501ac138f999;
#using scripts\common\data_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_59dbf6a1bb28a43f;

function function_99aa753d2ffc3bc9() {
  activity_common::function_cbc923662b03cacb("W\xbd\xdec\xf4x\xff\xd76\xfb", &function_77b6adbbb514551a);
  activity_common::function_cbc923662b03cacb("OO\x11h\xc0\xfc\xec\x1d\x9b\xedC", &function_2b335e1a151c79ca);
  activity_common::function_cbc923662b03cacb("\xaf\x19f\x93\xc1\xcbU/AA\x89\x869", &function_9a9f046b095555cd);
  activity_common::function_cbc923662b03cacb("n\x9b\xad\xd2\x96\xc1\x19}\xcf%\as\x11", &function_440ae2cd115469e2);
  activity_common::function_cbc923662b03cacb("\x14\x9b{|,\x05\xd9\f9\x86)\xce6", &function_440ae2cd115469e2);
  activity_common::function_cbc923662b03cacb("\x94\xe6n\x8e\v\xdclYEsd", &function_440ae2cd115469e2);
  activity_common::function_cbc923662b03cacb("(\xbd%\xa1\x18I\xd2xur\xcb", &function_440ae2cd115469e2);
  activity_common::function_cbc923662b03cacb("W\xbd\xdec\xf4x\xff\xd76\xfb", &activity_participation::function_d64a823052f1ea8b);
  activity_common::function_cbc923662b03cacb("OO\x11h\xc0\xfc\xec\x1d\x9b\xedC", &activity_participation::function_d64a823052f1ea8b);
}

function createactivityinstance(activitytype, varianttag, originpoint, additionalspawndatastruct) {
  if(!isDefined(level.activities.types[activitytype])) {
    assertmsg("<dev string:x24>" + varianttag + "<dev string:x37>" + activitytype + "<dev string:x53>");
    activity_common::registeractivitytype(activitytype, undefined);
  }

  if(!isDefined(level.activities.definitions[varianttag])) {
    namespace_7b5dc905a7ea3e0f::function_2e6ca705d9ae7f12([varianttag]);

    if(!isDefined(level.activities.definitions[varianttag])) {
      assertmsg("<dev string:xa9>" + varianttag);
      return;
    }
  }

  activitydefinition = level.activities.definitions[varianttag];
  activitycategory = namespace_7b5dc905a7ea3e0f::function_3269948ea31c7332(activitydefinition);
  newactivityinstance = function_62064e3e76678043(varianttag, activitytype, activitycategory, additionalspawndatastruct);
  activitynexussettings = level.activities.activitynexussettings;

  if(istrue(activitynexussettings.var_25738be6071c5d35) && istrue(activitydefinition.var_ec8683e4f9e8ae3a)) {
    if(isfunction(activitydefinition.var_373357e98a75852d)) {
      struct = spawnStruct();
      [[activitydefinition.var_373357e98a75852d]](varianttag, struct, varianttag);
      activitydefinition.var_ec8683e4f9e8ae3a = 0;
    }
  }

  activity_common::connectactivityinstance(newactivityinstance);
  activity_common::function_2ece6c60562ab130(1, [newactivityinstance, originpoint], 0);
  return newactivityinstance;
}

function function_2c8c6d8454e09226(activityinstance) {
  thread function_c7b8c63d629c6105(activityinstance, "\xc3\x93}=nD");
}

function function_58fe028e9ce25da0(activityinstance) {
  function_f34fc08401360a90(activityinstance, "@Z'\v\x9eS\xce");
}

function function_87293aa31a08ee75(activityinstance) {
  function_f34fc08401360a90(activityinstance, "\xc3\x93}=nD");
}

function setupinstance(relevantparameters) {
  activityinstance = relevantparameters[0];
  originpointoverride = relevantparameters[1];
  activityinstance endon("\x85ct\x96\x9d-:\xf2\xaf\x957dV\x8c");
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  function_daa7d9d852640757(activityinstance, originpointoverride);
  waitframe();
  activity_common::runactivityfunction(activityinstance, 0);
  waitframe();
  function_5a5f0f5e54d7306(activityinstance);
}

function endactivity(activityinstance, activitysuccess) {
  currentactivitystate = activityinstance.state;

  if(currentactivitystate != "\xc3\x93}=nD") {
    assertmsg("<dev string:xf1>" + currentactivitystate);
    return;
  }

  if(activitysuccess) {
    function_6da2c6c0237f132c(activityinstance);
  } else {
    function_d358f68841f9ca31(activityinstance);
  }

  level thread function_1ee3bf424b183e93(activityinstance);
}

function function_b4d8d495f2e20735(activityinstance, var_87d6b8ba8bc7cfc, relevantinfostruct) {
  if(!isDefined(relevantinfostruct)) {
    relevantinfostruct = spawnStruct();
  }

  if(!isDefined(relevantinfostruct.playerlist)) {
    relevantinfostruct.playerlist = activityinstance.playerparticipants;
  }

  relevantinfostruct.var_87d6b8ba8bc7cfc = var_87d6b8ba8bc7cfc;
  activityinstance namespace_606113cb7b23f701::function_456ea35b858c52a1(var_87d6b8ba8bc7cfc, relevantinfostruct.playerlist);
  activityinstance namespace_606113cb7b23f701::function_7a722b783624554b(var_87d6b8ba8bc7cfc);
  activity_rewards::function_8922b6d404080fbf(activityinstance, "\x97\xe7\xd3\v%\a\x9d*\xd7\x92\xdeY?\xdf", var_87d6b8ba8bc7cfc, relevantinfostruct.rewardstructoverride);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x14c>" + var_87d6b8ba8bc7cfc, @ "hash_22e4e38cab273e93", activityinstance, relevantinfostruct.playerlist);
}

function announceactivitymoment(activityinstance, activitymoment, relevantinfostruct) {
  if(!isDefined(relevantinfostruct)) {
    relevantinfostruct = spawnStruct();
  }

  if(!isDefined(relevantinfostruct.playerlist)) {
    relevantinfostruct.playerlist = activityinstance.playerparticipants;
  }

  relevantinfostruct.activitymoment = activitymoment;
  activityinstance namespace_606113cb7b23f701::function_c0fdeb0e546292f6(activitymoment, relevantinfostruct.playerlist);
  activityinstance namespace_606113cb7b23f701::function_bd7be4b2391074e4(activitymoment);
  namespace_4d9bab4515d9688d::function_163f8d985c0396a2(activityinstance, activitymoment);
  activity_scriptables::function_a4982ac9a822db4f(activityinstance, activitymoment);
  activity_rewards::function_8922b6d404080fbf(activityinstance, activitymoment, undefined, relevantinfostruct.rewardstructoverride);
  activityinstance activity_common::function_1d7710238d53922e(activitymoment, relevantinfostruct);
  activityinstance notify(activitymoment);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x168>" + activitymoment, @ "hash_22e4e38cab273e93", activityinstance, relevantinfostruct.playerlist);
}

function getinstanceid(activityinstance) {
  return activityinstance.id;
}

function getactivitystate(activityinstance) {
  return activityinstance.state;
}

function function_2b8ae5285dcc7793(activityinstance) {
  return activityinstance.playerparticipants.size;
}

function getactivityvariantname(activityinstance) {
  return activityinstance.varianttag;
}

function getactivitytype(activityinstance) {
  return activityinstance.type;
}

function getactivitycategory(activityinstance) {
  return activityinstance.category;
}

function function_4502ab041f3d0f21(activityinstance) {
  currentactivitystate = activityinstance.state;
  var_a97155689140c061 = currentactivitystate == "\xa2\xb9\x19\x95d" || currentactivitystate == "@Z'\v\x9eS\xce";
  return var_a97155689140c061 && istrue(activityinstance.successfullycompleted);
}

function function_619adbf70ff4ab5a(activityinstance, transitionstate) {
  var_6011116aa7443d71 = function_97ecef5a80fb93f0(activityinstance, transitionstate);
  return var_6011116aa7443d71 == 0;
}

function private function_97ecef5a80fb93f0(activityinstance, transitionstate) {
  fromstate = activityinstance.state;
  blockercount = 0;

  if(isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate])) {
    if(isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate][transitionstate])) {
      blockercount += activityinstance.var_b2be716fd0a99a4e[fromstate][transitionstate];
    }

    if(isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate]["s \x83"])) {
      blockercount += activityinstance.var_b2be716fd0a99a4e[fromstate]["s \x83"];
    }
  }

  if(isDefined(activityinstance.var_b2be716fd0a99a4e["s \x83"]) && isDefined(activityinstance.var_b2be716fd0a99a4e["s \x83"][transitionstate])) {
    blockercount += activityinstance.var_b2be716fd0a99a4e["s \x83"][transitionstate];
  }

  return blockercount;
}

function isactivityinstance(possibleactivityinstance) {
  return isstruct(possibleactivityinstance) && istrue(possibleactivityinstance.isactivityinstance);
}

function function_fe81b6493d094e5(activityinstance, omnvar) {
  if(!activityinstance data_tracker::function_fb39513920c37852(omnvar)) {
    assertmsg("<dev string:x17d>" + omnvar + "<dev string:x18d>");
    return undefined;
  }

  var_587bb26df4a186a3 = activityinstance data_tracker::getdatavalue(omnvar);
  return var_587bb26df4a186a3[0];
}

function function_bf543ede9abbdc82(activityinstance, omnvar) {
  if(!activityinstance data_tracker::function_fb39513920c37852(omnvar)) {
    assertmsg("<dev string:x17d>" + omnvar + "<dev string:x1d2>");
    return undefined;
  }

  var_587bb26df4a186a3 = activityinstance data_tracker::getdatavalue(omnvar);
  return var_587bb26df4a186a3[1];
}

function function_f937ccd8bd60dc6d(activityinstance) {
  activitytype = activityinstance.type;
  centerpointactivityfunction = activity_common::getactivityfunction(activitytype, 4);
  var_c612d99ad7390914 = &function_56ea198b94fb1dd1;

  if(isDefined(centerpointactivityfunction) && centerpointactivityfunction != var_c612d99ad7390914) {
    return true;
  }

  return false;
}

function function_c1c44508d7539941(activityinstance) {
  assert(isactivityinstance(activityinstance), "<dev string:x21d>");
  centerpoint = undefined;
  activitytype = activityinstance.type;

  if(activity_common::function_f04a771049752e35(activitytype, 4)) {
    centerpoint = activity_common::runactivityfunction(activityinstance, 4);
  }

  if(!isDefined(centerpoint) && isDefined(activityinstance.var_10d2dad0426d7512)) {
    centerpoint = activityinstance.var_10d2dad0426d7512;
  }

  if(!isDefined(centerpoint)) {
    centerpoint = activityinstance function_56ea198b94fb1dd1();
  }

  assert(isDefined(centerpoint), "<dev string:x274>");
  activityinstance.var_10d2dad0426d7512 = centerpoint;
  return centerpoint;
}

function function_56f5bf56ef8f957d(activityinstance) {
  return activityinstance.additionalspawndata;
}

function function_7bb0764c0a7ee082(activityinstance, uniquenamestring) {
  var_5d63a6e346c4d51c = activityinstance.var_7fe5869b6c4bff4b[uniquenamestring];
  return isDefined(var_5d63a6e346c4d51c);
}

function function_a06518ac224c282(activityinstance, var_bfb547f1c1d3de29 = 0) {
  var_eabfa5796407318a = [];
  activityvariantname = activityinstance.varianttag;

  for(variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname); isDefined(variantscriptstructinfo); variantscriptstructinfo = undefined) {
    var_eabfa5796407318a = utility::array_combine(var_eabfa5796407318a, variantscriptstructinfo.linkedstructs);

    if(istrue(var_bfb547f1c1d3de29) && isstring(variantscriptstructinfo.variantstruct.parent)) {
      activityvariantname = variantscriptstructinfo.variantstruct.parent;
      variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname);
      continue;
    }
  }

  return var_eabfa5796407318a;
}

function function_c241ea050bc001f4(activityinstance) {
  var_ebe55e0c784ce2bc = [];
  activityvariantname = activityinstance.varianttag;

  for(variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname); isDefined(variantscriptstructinfo); variantscriptstructinfo = undefined) {
    if(isstring(variantscriptstructinfo.variantstruct.parent)) {
      activityvariantname = variantscriptstructinfo.variantstruct.parent;
      variantscriptstructinfo = activity_common::function_d4c38791b19a0631(activityvariantname);
      var_ebe55e0c784ce2bc[var_ebe55e0c784ce2bc.size] = variantscriptstructinfo.variantstruct;
      continue;
    }
  }

  return var_ebe55e0c784ce2bc;
}

function function_a884ccfb56ab3058(activityinstance, newpriorityscore) {
  assert(newpriorityscore >= 1 && newpriorityscore <= 10, "<dev string:x31d>");
  activityinstance.var_efead8c9cb49b822 = newpriorityscore;
}

function function_2e432e61398d49e5(activityinstance, scoreoffset) {
  newpriorityscore = activityinstance.var_efead8c9cb49b822;
  newpriorityscore += scoreoffset;
  activityinstance.var_efead8c9cb49b822 = int(clamp(newpriorityscore, 1, 10));
}

function function_4020a4dc8fa4ab5e(activityinstance, var_a53627351f4f6034) {
  activityinstance.var_e9bbb2164fce18fc = utility::function_e86d2ca144f6bde8(activityinstance.var_e9bbb2164fce18fc, var_a53627351f4f6034);

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x34f>", @ "hash_22e4e38cab273e93", activityinstance, activityinstance.var_e9bbb2164fce18fc);
}

function function_73ef289466fc32b1(activityinstance, fromstate, tostate, reasonstring = undefined) {
  fromstate = fromstate ?? activityinstance.state;
  function_43429241c72fb6f8(activityinstance, fromstate, tostate, undefined, reasonstring);
}

function function_4dd55a3a7d36cb21(activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined) {
  if(isDefined(activityinstance.var_7fe5869b6c4bff4b[uniquenamestring])) {
    assertmsg("<dev string:x37f>" + uniquenamestring + "<dev string:x3b3>" + activityinstance.varianttag);
    return;
  }

  fromstate = fromstate ?? activityinstance.state;
  function_43429241c72fb6f8(activityinstance, fromstate, tostate, uniquenamestring, reasonstring);
}

function function_742ec2f4a8319b28(activityinstance, fromstate, tostate, reasonstring = undefined) {
  fromstate = fromstate ?? activityinstance.state;

  if(isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate]) && isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate][tostate])) {
    activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] = max(activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] - 1, 0);
    activityinstance notify(":\xf7dOl\x91\xb6\xa4\xb9)\xce\xa2\xca]\xbd\x13\xd0\xef\xae\xa9\x1e\xc3\x01L\x04\\\x8a\xc5 \x11\xfc7\xca\x7f\xc9\xca!\xd3\xdep\x8c");
    function_a7be6c48ff71a931(activityinstance, 0, fromstate, tostate, undefined, reasonstring);
  }
}

function function_30a12e4e4ff02ec8(activityinstance, uniquenamestring, reasonstring = undefined) {
  var_5d63a6e346c4d51c = activityinstance.var_7fe5869b6c4bff4b[uniquenamestring];

  if(isDefined(var_5d63a6e346c4d51c)) {
    fromstate = var_5d63a6e346c4d51c.fromstate;
    tostate = var_5d63a6e346c4d51c.tostate;
    activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] = max(activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] - 1, 0);
    activityinstance.var_7fe5869b6c4bff4b[uniquenamestring] = undefined;
    activityinstance notify(":\xf7dOl\x91\xb6\xa4\xb9)\xce\xa2\xca]\xbd\x13\xd0\xef\xae\xa9\x1e\xc3\x01L\x04\\\x8a\xc5 \x11\xfc7\xca\x7f\xc9\xca!\xd3\xdep\x8c");
    function_a7be6c48ff71a931(activityinstance, 0, fromstate, tostate, uniquenamestring, reasonstring);
    return;
  }

  assertmsg("<dev string:x3d8>" + uniquenamestring + "<dev string:x40b>" + activityinstance.varianttag + "<dev string:x421>");
}

function function_7652cee04789e607(activityinstance, omnvar, value, resetvalue) {
  var_c0f2890edbda44ca = activityinstance data_tracker::function_fb39513920c37852(omnvar);

  if(var_c0f2890edbda44ca) {
    activityinstance data_tracker::updatedata(omnvar, [value, resetvalue]);
    return;
  }

  activityinstance data_tracker::adddata(omnvar, "\xf3~B\xad\x02", [value, resetvalue]);
  activityinstance.var_3370c74026090bf4[activityinstance.var_3370c74026090bf4.size] = omnvar;
}

function function_64ede69dff6ba1ee(activityinstance, var_719b90890c877693) {
  if(istrue(activityinstance.var_5c5a5daba1ab602f.var_5cf8f4220f45ec3c)) {
    var_d1b1a07d69eec3a0 = activityinstance.var_719b90890c877693;
    activityinstance.var_719b90890c877693 = var_719b90890c877693;

    if(istrue(var_719b90890c877693) && !var_d1b1a07d69eec3a0) {
      announceactivitymoment(activityinstance, "H\xd42.\r>=\a\xe5M\xf4\x06\x9c\xf9\xb8b:\xb8\xb0\xc4o\xe1\x95\xe8v\xa8");
      return;
    }

    if(var_d1b1a07d69eec3a0) {
      announceactivitymoment(activityinstance, "\xa3\xf1\x03\xf2l\xd4\xc6\x8fe\x03\xc3%\afT\x82,c%\x8d\x94\xd6\f\xab(\x0e");
    }
  }
}

function function_27802dae6e2c93fd() {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x454>", @ "hash_22e4e38cab273e93", self, undefined, 2);

  function_2c8c6d8454e09226(self);
}

function function_7a40ca327ba849e5() {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x4b1>", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_3cb4475857b12c1() {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x50e>", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_55e2a232e07726a2() {
  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x569>", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_56ea198b94fb1dd1() {
  activityinstance = self;

  if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO")) {
    var_be90d538cde3b347 = namespace_9342d78fcaacff0b::function_d155afd969a2a226(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO");
    assert(var_be90d538cde3b347.size == 1, "<dev string:x5c8>");
    var_7a4a9feba2fe3b70 = var_be90d538cde3b347[0];
    return namespace_9342d78fcaacff0b::function_4e71ca577d4d6ad9(var_7a4a9feba2fe3b70);
  }

  if(isDefined(activityinstance.var_732d8d02ff827041)) {
    return activityinstance.var_732d8d02ff827041;
  }

  namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x61b>", @ "hash_22e4e38cab273e93", activityinstance, undefined, 3);

  return (0, 0, 0);
}

function private function_62064e3e76678043(varianttag, activitytype, category, additionalspawndatastruct) {
  if(isDefined(additionalspawndatastruct)) {
    assert(isstruct(additionalspawndatastruct), "<dev string:x66d>");
  } else {
    additionalspawndatastruct = {};
  }

  newactivityinstance = spawnStruct();
  newactivityinstance.varianttag = varianttag;
  newactivityinstance.id = activity_common::getuniqueinstanceid();
  newactivityinstance.type = activitytype;
  newactivityinstance.category = category ?? "\f+x5";
  newactivityinstance.additionalspawndata = additionalspawndatastruct;
  newactivityinstance.successfullycompleted = 0;
  newactivityinstance.score = 0;
  newactivityinstance.var_10d2dad0426d7512 = undefined;
  newactivityinstance.var_bdf6bca21b27c614 = undefined;
  newactivityinstance.var_efead8c9cb49b822 = undefined;
  newactivityinstance.state = "\xcf!f\x94\xa0@\xc1";
  newactivityinstance.previousstate = undefined;
  newactivityinstance.isactivityinstance = 1;
  newactivityinstance.var_719b90890c877693 = 0;
  newactivityinstance.var_5c5a5daba1ab602f = spawnStruct();
  newactivityinstance.var_7fe5869b6c4bff4b = [];
  newactivityinstance.var_b2be716fd0a99a4e = [];
  newactivityinstance.playerparticipants = [];
  newactivityinstance.var_e9bbb2164fce18fc = [];
  newactivityinstance.var_b154b83bb4c4016c = [];
  newactivityinstance.activebroadcasts = [];
  newactivityinstance.objectivemarkers = [];
  newactivityinstance.var_e687d62499f0c463 = [];
  newactivityinstance.var_a324b9679c13e3e2 = [];
  newactivityinstance.var_3370c74026090bf4 = [];
  newactivityinstance.var_387a685a1fac02e9 = undefined;
  namespace_9342d78fcaacff0b::function_8e5a4cfaa06f6dd2(newactivityinstance);
  data_tracker::function_821298354fb37251(newactivityinstance);
  newactivityinstance data_tracker::adddatastring("\xb7\x189DTWy\xd8\xa1{j\xdd\xd3\x1b\x06\x96", activitytype);
  newactivityinstance data_tracker::adddatastring("\xc7\x83/G_\x11\xe1\x96\xd8wK\x8a\xfe7\xd1\xb68u\xf7", varianttag);
  newactivityinstance data_tracker::addcallback(&namespace_606113cb7b23f701::function_a338afe338efd1e2);
  return newactivityinstance;
}

function private function_20b1b0abc0c82319(activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined) {
  if(!function_7bb0764c0a7ee082(activityinstance, uniquenamestring)) {
    function_4dd55a3a7d36cb21(activityinstance, fromstate, tostate, uniquenamestring, reasonstring);
  }
}

function private function_43429241c72fb6f8(activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined) {
  if(isDefined(uniquenamestring)) {
    activityinstance.var_7fe5869b6c4bff4b[uniquenamestring] = {
      #tostate: tostate, #fromstate: fromstate
    };
  }

  if(!isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate])) {
    activityinstance.var_b2be716fd0a99a4e[fromstate] = [];
  }

  if(!isDefined(activityinstance.var_b2be716fd0a99a4e[fromstate][tostate])) {
    activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] = int(0);
  }

  activityinstance.var_b2be716fd0a99a4e[fromstate][tostate] += 1;
  function_a7be6c48ff71a931(activityinstance, 1, fromstate, tostate, uniquenamestring, reasonstring);
}

function private function_6e9462b477086072(activityinstance, uniquenamestring, reasonstring = undefined) {
  if(function_7bb0764c0a7ee082(activityinstance, uniquenamestring)) {
    function_30a12e4e4ff02ec8(activityinstance, uniquenamestring, reasonstring);
  }
}

function private function_daa7d9d852640757(activityinstance, originpointoverride) {
  activityinstance.var_732d8d02ff827041 = originpointoverride;
  namespace_7b5dc905a7ea3e0f::function_a4e7db016016846b(activityinstance);

  if(isDefined(originpointoverride)) {
    if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO")) {
      namespace_9342d78fcaacff0b::function_ad5d8806fb714e21(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO");
    }

    namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(activityinstance, "\x8b\xef\xf6\x04Pn\xf7\xde\x89\xaft\xda\x0f\x19\xe0\xdc\x1b\xeeO", originpointoverride);
  }

  activitynexussettings = level.activities.activitynexussettings;

  if(istrue(activitynexussettings.var_42587ba75f9f7eb) && !namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!")) {
    activity_common::function_9c3896bd08c52ae8(activityinstance, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!");
  }

  function_7e59f83a9f6a1a36(activityinstance);
  activityinstance.var_efead8c9cb49b822 = namespace_7b5dc905a7ea3e0f::function_2c4568c15eb8e794(activityinstance);
  activityinstance namespace_30f3ea5d3d3c7b6c::function_6fab2e7402cb70db();
  activity_participation::function_b2405ee028bc9654(activityinstance);
  function_73ef289466fc32b1(activityinstance, "s \x83", "\xc3\x93}=nD", "\x81!\x0e\xe0\x80c>\xf9|\x03\x19\xed\x9a\x93V\xc7-\x8e9\xb7;\x12\xe0\x88\xa4\x9b\xc6\xa5\xc3A*\aV\xaf\x9f?\xbd\xc0>\xe8\xf5\xe6/\x17\xa9\\\x97,\x95");
}

function private function_5a5f0f5e54d7306(activityinstance) {
  function_99557328272d6a35(activityinstance, "\xb1\x88\xc2*");
  announceactivitymoment(activityinstance, "n\x9b\xad\xd2\x96\xc1\x19}\xcf%\as\x11");
  activity_participation::function_ea0b89936d9c8e9b(activityinstance);
  function_742ec2f4a8319b28(activityinstance, "s \x83", "\xc3\x93}=nD", "\xaem\xdb\xb2\x04\x1a\x86yp\"PDd\x80?{M\x9f\xd5\xf9W\x10\\\x10\xa9%0/W\xbeg\x9f\xfa4)UY\x89");
}

function private function_11dafed451725b64(activityinstance) {
  announceactivitymoment(activityinstance, "\x94\xe6n\x8e\v\xdclYEsd");
  activity_common::runactivityfunction(activityinstance, 3);
  activity_scriptables::activityscriptablecleanup(activityinstance);
  function_8d0487de8b0841ff(activityinstance);

  if(isDefined(level.activities.nexusoverrides[4])) {
    activity_common::function_2ece6c60562ab130(4, [activityinstance], 1);
  }

  if(activityinstance.playerparticipants.size > 0) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x698>", @ "hash_22e4e38cab273e93", activityinstance, activityinstance.playerparticipants, 2);

    activity_participation::function_53545468aace1532(activityinstance);
  }

  activity_common::function_8186d519c4482354(activityinstance);
  activity_common::disconnectactivityinstance(activityinstance);
  activityinstance notify("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
}

function private function_7af573bd60bde2ba(activityinstance) {
  activityinstance endon("\x93`\x8b\x03\xf8\\^\xa08Y\x8d\xdd\xd9K\xa5\xeb");
  announceactivitymoment(activityinstance, "\x14\x9b{|,\x05\xd9\f9\x86)\xce6");

  foreach(player in activityinstance.playerparticipants) {
    function_100aa61ca2b3d04b(activityinstance, player);
  }

  if(isDefined(level.activities.nexusoverrides[2])) {
    activity_common::function_2ece6c60562ab130(2, [activityinstance], 1);
  }

  activity_common::runactivityfunction(activityinstance, 1);
}

function private function_3bae58f2cb776e3a(activityinstance) {
  announceactivitymoment(activityinstance, "(\xbd%\xa1\x18I\xd2xur\xcb");
  activity_common::runactivityfunction(activityinstance, 2);
  function_744b45aa8c7465b1(activityinstance);

  if(isDefined(level.activities.nexusoverrides[3])) {
    activity_common::function_2ece6c60562ab130(3, [activityinstance], 1);
  }

  activityinstance notify("\x85ct\x96\x9d-:\xf2\xaf\x957dV\x8c");
  waitframe();
  thread function_c7b8c63d629c6105(activityinstance, "@Z'\v\x9eS\xce");
}

function private function_6da2c6c0237f132c(activityinstance) {
  foreach(player in activityinstance.playerparticipants) {
    function_4020a4dc8fa4ab5e(activityinstance, player);
  }

  activityinstance.successfullycompleted = 1;
  announceactivitymoment(activityinstance, "\xf2\xd0w\xcbg\xf7@\\BA>q\xbf\xd9\xec");
  activityinstance notify("|\xca\xf2\x9d\x97\xaf[%\xb0\xa3\r\xa3\x12\x8d\xe3h.\xd4");
}

function private function_d358f68841f9ca31(activityinstance) {
  announceactivitymoment(activityinstance, "\xc54k\xe4%\xf2\x14\xc4X;\xc6\xdc\xf1\xf5M");
  activityinstance notify("\x12w\xe3\x80{\\\xd3\xb1\xb1\x9a\x0f\x13[\xd8\xf3");
}

function private function_1ee3bf424b183e93(activityinstance) {
  waitframe();
  thread function_c7b8c63d629c6105(activityinstance, "\xa2\xb9\x19\x95d");
}

function private function_744b45aa8c7465b1(activityinstance) {
  activityinstance namespace_699ccc66e99185fb::function_ccea0ef4fae043ef();
  activityinstance namespace_4d9bab4515d9688d::function_57dc2c730e5f773();

  if(activity_participation::function_ba8c8d437e61ee56(activityinstance)) {
    activity_participation::function_af34fe79395a6626(activityinstance);
  }

  activity_participation::function_53545468aace1532(activityinstance);
}

function private function_b934b004f1d0e2a9(activityinstance, var_28af4c6b339ea5c4) {
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  fromstate = var_28af4c6b339ea5c4.fromstate;
  tostate = var_28af4c6b339ea5c4.tostate;
  uniquename = var_28af4c6b339ea5c4.uniquename;
  timedelay = var_28af4c6b339ea5c4.timedelay;
  function_20b1b0abc0c82319(activityinstance, fromstate, tostate, uniquename, "jP\x11\x82\x18dU\x83\xf9\x82\x1b\xd6R\xb1" + timedelay + "\n\xdc2C\x88\xf53\xde\xc3\xe1\x84G]W\xd9\xb0\x02\xf4\x90\xcd\x92\xe2\xfa\xf2\xde\x11.\xfd");
  wait timedelay;
  function_6e9462b477086072(activityinstance, uniquename, "\xcb^7U" + timedelay + " \xb8\x04\x13i!?\x18ElmmQ<2c\xb7=\r\x19gZmuL\xda");
}

function private function_f34fc08401360a90(activityinstance, nextactivitystate) {
  currentactivitystate = activityinstance.state;

  if(nextactivitystate == "\xc3\x93}=nD" && currentactivitystate == "\xb1\x88\xc2*") {
    function_99557328272d6a35(activityinstance, nextactivitystate);
    function_7af573bd60bde2ba(activityinstance);
    return;
  }

  if(nextactivitystate == "\xa2\xb9\x19\x95d" && currentactivitystate == "\xc3\x93}=nD") {
    function_99557328272d6a35(activityinstance, nextactivitystate);
    thread function_3bae58f2cb776e3a(activityinstance);
    return;
  }

  if(nextactivitystate == "@Z'\v\x9eS\xce" && currentactivitystate != "@Z'\v\x9eS\xce") {
    function_99557328272d6a35(activityinstance, nextactivitystate);

    if(currentactivitystate == "\xc3\x93}=nD" || currentactivitystate == "\xb1\x88\xc2*") {
      function_744b45aa8c7465b1(activityinstance);
    }

    function_11dafed451725b64(activityinstance);
  }
}

function private function_c7b8c63d629c6105(activityinstance, transitionstate) {
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");

  while(!function_619adbf70ff4ab5a(activityinstance, transitionstate)) {
    activityinstance waittill(":\xf7dOl\x91\xb6\xa4\xb9)\xce\xa2\xca]\xbd\x13\xd0\xef\xae\xa9\x1e\xc3\x01L\x04\\\x8a\xc5 \x11\xfc7\xca\x7f\xc9\xca!\xd3\xdep\x8c");
  }

  function_f34fc08401360a90(activityinstance, transitionstate);
}

function private function_59ed9a73034d1e55(activityinstance, fromstate) {
  var_19d6942f47ac8b83 = namespace_7b5dc905a7ea3e0f::function_2499423a8a5868f1(activityinstance, fromstate);

  foreach(var_28af4c6b339ea5c4 in var_19d6942f47ac8b83) {
    if(var_28af4c6b339ea5c4.uniquename == "\x82cX\xcbY\x93\xe6\x01]-\x1d\x86K\x9b\x02\xd2\xdb\xb9V\x02H\xb1{\x1b\xb6\xca'") {
      tostate = var_28af4c6b339ea5c4.tostate;
      thread function_70d491a469e89605(activityinstance, var_28af4c6b339ea5c4, 1);
      continue;
    }

    if(var_28af4c6b339ea5c4.uniquename == "\x14\xc6\xc2\x97eNs\b\xa7u:\xcd\xd2\x19\xac\x10\xd2\xbd\xb9\xac\x01B\xc6o6\xd6Vr") {
      tostate = var_28af4c6b339ea5c4.tostate;
      thread function_70d491a469e89605(activityinstance, var_28af4c6b339ea5c4, 0);
      continue;
    }

    if(var_28af4c6b339ea5c4.uniquename == "\xaa\xec\xa1\v\xa4\xdd\r\v\x0e)\xff\xc2\xbfnT\xeb\xed@T\r\x1f\v\x1c\x16.\xc2i\x86\x83q\a\xc1\xe1\x0f\xec\x91") {
      function_20b1b0abc0c82319(activityinstance, var_28af4c6b339ea5c4.fromstate, var_28af4c6b339ea5c4.tostate, "\xaa\xec\xa1\v\xa4\xdd\r\v\x0e)\xff\xc2\xbfnT\xeb\xed@T\r\x1f\v\x1c\x16.\xc2i\x86\x83q\a\xc1\xe1\x0f\xec\x91", "#0\xdd\xed\x8f!r\a\xe9\x80\xdd\x1f\x82\xa8\r&\x04&\xc6?^\x18u\xd0\tn\r\xec\xf6\xef8\xacu\x89\xb2e\xc7\xa6\x13\x82\x89");
      continue;
    }

    if(var_28af4c6b339ea5c4.uniquename == "lu;\xb0<\xc1<\"0R\x9a\xf8\r\xdf7!\xc7\xda") {
      thread function_b934b004f1d0e2a9(activityinstance, var_28af4c6b339ea5c4);
    }
  }
}

function private function_77b6adbbb514551a(relevantinfostruct) {
  playerlist = relevantinfostruct.playerlist;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      function_100aa61ca2b3d04b(self, player);
    }
  }
}

function private function_2b335e1a151c79ca(relevantinfostruct) {
  playerlist = relevantinfostruct.playerlist;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      function_659d39b053e2379b(self, player);
    }
  }
}

function private function_9a9f046b095555cd(relevantinfostruct) {
  activityinstance = self;

  if(activityinstance.playerparticipants.size == 0 && namespace_7b5dc905a7ea3e0f::function_55562bba8ab39b02(activityinstance)) {
    activitystate = activityinstance.state;

    if(activitystate != "\xa2\xb9\x19\x95d" && namespace_7b5dc905a7ea3e0f::function_b6af53d8e1851fa4(activityinstance)) {
      function_59ed9a73034d1e55(activityinstance, "\xa2\xb9\x19\x95d");
    }

    waitframe();
    function_c7b8c63d629c6105(activityinstance, "@Z'\v\x9eS\xce");
  }
}

function private function_100aa61ca2b3d04b(activityinstance, player) {
  currentstate = activityinstance.state;

  if(currentstate == "\xc3\x93}=nD") {
    if(namespace_7b5dc905a7ea3e0f::function_fae78aedd860c0e7(activityinstance)) {
      player utility::function_f6b3199f100d0682(1);
    }

    if(namespace_7b5dc905a7ea3e0f::function_d85f647ad03a40b1(activityinstance)) {
      player utility::function_2887ccea94a016ec(1);
    }
  }
}

function private function_659d39b053e2379b(activityinstance, player) {
  currentstate = activityinstance.state;

  if(currentstate == "\xc3\x93}=nD" || currentstate == "\xa2\xb9\x19\x95d") {
    if(namespace_7b5dc905a7ea3e0f::function_fae78aedd860c0e7(activityinstance)) {
      player utility::function_f6b3199f100d0682(0);
    }

    if(namespace_7b5dc905a7ea3e0f::function_d85f647ad03a40b1(activityinstance)) {
      player utility::function_2887ccea94a016ec(0);
    }
  }

  if(currentstate == "\xa2\xb9\x19\x95d") {
    namespace_37b952684c0bbb5::function_e6f3a8c65d608a47(player, self);
  }
}

function private function_99557328272d6a35(activityinstance, activityinstancestate) {
  if(activityinstancestate == "\xcf!f\x94\xa0@\xc1") {
    assertmsg("<dev string:x77b>");
    return;
  }

  currentactivitystate = activityinstance.state;
  activityinstance.previousstate = currentactivitystate;
  activityinstance.state = activityinstancestate;

  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_f972c083ecfc0669")) {
    logstring = "<dev string:x837>" + currentactivitystate + "<dev string:x861>" + activityinstancestate + "<dev string:x86a>";
    namespace_72e72f5e51e6e4b3::activitynexuslog(logstring, @ "hash_f972c083ecfc0669", activityinstance);
  }

  if(activityinstancestate != "@Z'\v\x9eS\xce") {
    function_59ed9a73034d1e55(activityinstance, activityinstancestate);
  }
}

function private function_a7be6c48ff71a931(activityinstance, beingadded, fromstate, tostate, uniquenamestring, reasonstring) {
  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_f972c083ecfc0669")) {
    blockercount = activityinstance.var_b2be716fd0a99a4e[fromstate][tostate];
    uniquenamestring = isDefined(uniquenamestring) ? "<dev string:x86f>" + uniquenamestring : "<dev string:x880>";
    logprefix = istrue(beingadded) ? "<dev string:x884>" : "<dev string:x8a8>";
    logmiddle = uniquenamestring + "<dev string:x8ce>" + blockercount + "<dev string:x8e3>" + fromstate + "<dev string:x861>" + tostate + "<dev string:x913>";
    logsuffix = (isDefined(reasonstring) && isstring(reasonstring) ? "<dev string:x944>" + reasonstring : "<dev string:x880>") + "<dev string:x86a>";
    namespace_72e72f5e51e6e4b3::activitynexuslog(logprefix + logmiddle + logsuffix, @ "hash_f972c083ecfc0669", activityinstance);
    blockercount = function_97ecef5a80fb93f0(activityinstance, tostate);
    currentactivitystate = activityinstance.state;
    logstring = "<dev string:x969>" + blockercount + "<dev string:x97c>" + tostate + "<dev string:x9ae>";
    namespace_72e72f5e51e6e4b3::activitynexuslog(logstring, @ "hash_f972c083ecfc0669", activityinstance);
  }
}

function private function_70d491a469e89605(activityinstance, var_28af4c6b339ea5c4, playersdesired) {
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  loggingdvar = @ "hash_22e4e38cab273e93";
  loggingreasonstring = "\x10A\xca\xf4f\xd5D\"\x97Q\x1c\xe6\xf3\xd8\xd7\x9f\xa4y\xa3\x1d\x0f\xfd\xcf\xff\th[\x81n<Sc\x9eFx\x16cO";

  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(loggingdvar)) {
    if(istrue(playersdesired)) {
      loggingreasonstring = "N=\xb9\x10\x97\x87\x01K\x97u\x1c\x9f,\x13\xe0\x9c\x1e\x89<a\aDjv|F\x9co\x8f%\xda\xb6";
    } else {
      loggingreasonstring = "\xff \xed\xbd\b\xfe\xec\xbc\xa54A\xec\x94\xac\xe2a\r\x996\x97\xf3\xb9\xdaI\xdf\xd4\xbc\xf67\x9ch\xf4I\xab";
    }
  }

  fromstate = var_28af4c6b339ea5c4.fromstate;
  tostate = var_28af4c6b339ea5c4.tostate;
  uniquename = var_28af4c6b339ea5c4.uniquename;
  zoneinfostruct = var_28af4c6b339ea5c4.zoneinfostruct;
  var_65f146d8ebaf973b = uniquename + fromstate + tostate;
  function_20b1b0abc0c82319(activityinstance, fromstate, tostate, var_65f146d8ebaf973b, loggingreasonstring);

  if(!namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(activityinstance, var_65f146d8ebaf973b)) {
    namespace_7b5dc905a7ea3e0f::function_443bf722a7d22510(activityinstance, var_65f146d8ebaf973b, zoneinfostruct);
  }

  while(true) {
    if(!activityinstance.var_719b90890c877693) {
      playersinradius = namespace_9342d78fcaacff0b::function_501d514afe3347(activityinstance, var_65f146d8ebaf973b);

      if(isDefined(playersinradius) && playersinradius.size > 0 && playersdesired) {
        break;
      } else if((!isDefined(playersinradius) || playersinradius.size == 0) && !playersdesired) {
        break;
      }
    }

    wait 1.5;
  }

  loggingreasonstring = "g%\xbe\xbd\x1b\xe0\xec\x16\xa4P\xc3\xce9\x91\xc2\xf9W\xc9\xbf\f\x10 \xef\x85\x96@\x80\x82\xac\xc7\xc9y\xd43\xc7\x12\f\x83\x03\xcf?\x91";

  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(loggingdvar)) {
    if(istrue(playersdesired)) {
      loggingreasonstring = "\a\\\xb7\x1a\xf3\xa2sJX{?1\xb07\xef\xb7\x80\xad_\xa3\xc5H";
    } else {
      loggingreasonstring = "\xeby\xd5aV\xa0r.\x1a\xd8\xb5\xcd\xb5J\x96/\x88|n\x80\x03g\xfe\x01\x8e\xd8@5\xf0-8";
    }
  }

  function_6e9462b477086072(activityinstance, var_65f146d8ebaf973b, loggingreasonstring);
}

function private function_440ae2cd115469e2(relevantinfostruct) {
  activityinstance = self;
  activitydefinition = activityinstance namespace_7b5dc905a7ea3e0f::function_e2fc5d3b23f01ac5();
  activationmoment = namespace_7b5dc905a7ea3e0f::function_f5d8690ade75cb8a(activitydefinition);
  deactivationmoment = namespace_7b5dc905a7ea3e0f::function_57355d5ef27c993f(activitydefinition);

  if(!activity_participation::function_ba8c8d437e61ee56(activityinstance)) {
    if(isDefined(activationmoment) && activationmoment == relevantinfostruct.activitymoment) {
      activity_participation::function_6f5790139d95d44d(activityinstance);
    }

    return;
  }

  if(isDefined(deactivationmoment) && deactivationmoment == relevantinfostruct.activitymoment) {
    activity_participation::function_af34fe79395a6626(activityinstance);
  }
}

function private function_8d0487de8b0841ff(activityinstance) {
  spatialzonenames = namespace_9342d78fcaacff0b::function_6767d8780e93f549(activityinstance);

  foreach(spatialzonename in spatialzonenames) {
    namespace_9342d78fcaacff0b::function_26732f46a05cc793(activityinstance, spatialzonename);
  }
}

function private function_7e59f83a9f6a1a36(activityinstance) {
  namespace_606113cb7b23f701::function_4fb0d88fb39268a7(activityinstance);
  var_39fe1588b9336792 = activityinstance.var_5c5a5daba1ab602f;
  var_39fe1588b9336792.var_30acbef8a0a778f3 = istrue(activityinstance.var_5c5a5daba1ab602f.var_30acbef8a0a778f3);
  var_39fe1588b9336792.var_5cf8f4220f45ec3c = namespace_7b5dc905a7ea3e0f::function_8a9095c5f92d736(activityinstance);
}