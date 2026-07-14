/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_6d60a2f06878900a.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_1f139695c61f1549;
#using script_2838bf44b7dbfea;
#using script_4db4e7f305ce5a21;
#using script_68283b3e4663b14f;
#using script_f01501ac138f999;
#using scripts\engine\utility;
#namespace activity_rewards;

function function_8922b6d404080fbf(activityinstance, activitymoment, var_87d6b8ba8bc7cfc, rewardstructoverride) {
  assert(isDefined(activitymoment));
  assert(isDefined(activityinstance));
  var_e0ac5f547de50093 = function_3bef4e21556ba94e(activityinstance, activitymoment, var_87d6b8ba8bc7cfc);
  assert(isDefined(var_e0ac5f547de50093));

  foreach(var_2c51db6714cb3bea in var_e0ac5f547de50093) {
    var_ddaa3fb303aecb1f = namespace_4c2df310039c1ff0::function_2cc420853a7d4592(var_2c51db6714cb3bea);
    function_69a508b128aaae94(activityinstance, var_ddaa3fb303aecb1f, rewardstructoverride);
  }
}

function function_69a508b128aaae94(activityinstance, var_ddaa3fb303aecb1f, rewardstructoverride) {
  rewardcachesettings = namespace_4c2df310039c1ff0::function_6375b543e2a6d47(var_ddaa3fb303aecb1f);
  rewardcachebehaviorsettings = namespace_4c2df310039c1ff0::function_d30573585239b6f5(var_ddaa3fb303aecb1f);
  playerrewardgroups = function_a667b07637db4d8a(activityinstance, var_ddaa3fb303aecb1f);
  rewardspawnlocation = rewardstructoverride ?? function_634fa3df070ff7f4(activityinstance, var_ddaa3fb303aecb1f);
  openlootablecontainerfunction = &function_f38b87dc1aef620;
  lootfunction = &function_1f06a7e12c067046;
  lootfunctionargs = function_a537ff2c58c08d1e(activityinstance);
  onitemtakenfunction = undefined;
  var_8a52800ec1ca832a = undefined;
  var_54b9879211025bcc = spawnStruct();
  thread function_49117fb61bb256ae(activityinstance, var_54b9879211025bcc);
  managed_reward_cache::function_a46929d7049f2611(rewardcachesettings, rewardcachebehaviorsettings, playerrewardgroups, rewardspawnlocation, openlootablecontainerfunction, lootfunction, lootfunctionargs, onitemtakenfunction, var_8a52800ec1ca832a, var_54b9879211025bcc);
}

function function_f63acbbd4f4f2cff(activityinstance, rewardgrouptype, perplayerloot) {
  relevantinfostruct = spawnStruct();
  relevantinfostruct.rewardgrouptype = rewardgrouptype;
  relevantinfostruct.perplayerloot = perplayerloot;
  return activity_common::runactivityfunction(activityinstance, 6, relevantinfostruct);
}

function function_a667b07637db4d8a(activityinstance, var_ddaa3fb303aecb1f) {
  rewardgrouptype = namespace_4c2df310039c1ff0::getrewardgrouptype(var_ddaa3fb303aecb1f);
  perplayerloot = namespace_4c2df310039c1ff0::getperplayerloot(var_ddaa3fb303aecb1f);
  return function_f63acbbd4f4f2cff(activityinstance, rewardgrouptype, perplayerloot);
}

function function_12df33974be83b2c(activityinstance, rewardspawnlocationtype) {
  relevantinfostruct = spawnStruct();
  relevantinfostruct.rewardspawnlocationtype = rewardspawnlocationtype;
  activitytype = activityinstance.type;

  if(activity_common::getactivityfunction(activitytype, 5) == activity_common::function_ae274f2045bad268(5)) {
    var_d06b2898cf42936e = activity_common::runactivityfunction(activityinstance, 5, relevantinfostruct);
  } else {
    var_d06b2898cf42936e = activity_common::runactivityfunction(activityinstance, 5);
  }

  if(isDefined(var_d06b2898cf42936e)) {
    if(!isarray(var_d06b2898cf42936e)) {
      var_d06b2898cf42936e = [var_d06b2898cf42936e];
    }

    assert(isDefined(var_d06b2898cf42936e[0].origin), "<dev string:x24>");
    assert(isDefined(var_d06b2898cf42936e[0].angles), "<dev string:x7f>");
    return var_d06b2898cf42936e[0];
  }

  assertmsg("<dev string:xda>");
  return undefined;
}

function function_634fa3df070ff7f4(activityinstance, var_ddaa3fb303aecb1f) {
  rewardspawnlocationtype = namespace_4c2df310039c1ff0::function_15ac8069ace3615d(var_ddaa3fb303aecb1f);
  return function_12df33974be83b2c(activityinstance, rewardspawnlocationtype);
}

function function_f38b87dc1aef620(argstruct) {
  activity_common::function_2ece6c60562ab130(9, argstruct, 0);
}

function function_22869ba492bd758(relevantinfostruct) {
  origin = namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(self);
  return namespace_25b52ebe6ab1a0c8::function_3301625bce265892(origin, (0, 0, 0), undefined, undefined, undefined, undefined);
}

function private function_1f06a7e12c067046(lootfunctionargs) {
  assert(isstruct(lootfunctionargs) && isDefined(lootfunctionargs.activity_instance));
  activityinstance = lootfunctionargs.activity_instance;
  relevantinfostruct = lootfunctionargs;
  return activity_common::runactivityfunction(activityinstance, 7, relevantinfostruct);
}

function getrewardgroups(relevantinfostruct) {
  assert(isDefined(relevantinfostruct), "<dev string:x1ad>");
  activityinstance = self;
  rewardgrouptype = relevantinfostruct.rewardgrouptype;
  perplayerloot = relevantinfostruct.perplayerloot;
  assert(isDefined(rewardgrouptype));
  assert(isDefined(perplayerloot));
  rewardgroups = function_11a8a37b112ac30c(activityinstance, rewardgrouptype);

  if(istrue(perplayerloot)) {
    return function_9da4f4429ccbc49f(rewardgroups);
  }

  return rewardgroups;
}

function private function_9da4f4429ccbc49f(rewardgroups) {
  perplayerrewardgroups = [];

  foreach(rewardgroup in rewardgroups) {
    foreach(player in rewardgroup) {
      perplayerrewardgroups[perplayerrewardgroups.size] = [player];
    }
  }

  return perplayerrewardgroups;
}

function private function_11a8a37b112ac30c(activityinstance, rewardgrouptype) {
  var_e9bbb2164fce18fc = activityinstance.var_e9bbb2164fce18fc;
  playerrewardgroups = [];

  switch (rewardgrouptype) {
    case #"hash_172e3a33f45b462e":
      assert(isDefined(var_e9bbb2164fce18fc));
      playerrewardgroups = [var_e9bbb2164fce18fc];
      break;
    case #"hash_89ee46feec0f25b9":
      assertmsg("<dev string:x237>");
      break;
    default:
      assertmsg("<dev string:x2c1>" + rewardgrouptype + "<dev string:x2d5>");
      break;
  }

  return playerrewardgroups;
}

function function_2af2fb22b8c5145f(activityinstance, activitymoment, var_87d6b8ba8bc7cfc) {
  var_a209ed8c84499497 = function_3bef4e21556ba94e(activityinstance, activitymoment, var_87d6b8ba8bc7cfc);
  return isDefined(var_a209ed8c84499497) && var_a209ed8c84499497.size > 0;
}

function private function_3bef4e21556ba94e(activityinstance, activitymoment, var_87d6b8ba8bc7cfc) {
  if(!isDefined(activityinstance.var_24f4c53254b34132)) {
    function_cccbed6002549b93(activityinstance);
  }

  mapkey = function_63fa4fb39dfeaa32(activitymoment, var_87d6b8ba8bc7cfc);
  var_a209ed8c84499497 = activityinstance.var_24f4c53254b34132[mapkey];
  return isDefined(var_a209ed8c84499497) ? var_a209ed8c84499497 : [];
}

function private function_63fa4fb39dfeaa32(activitymoment, var_87d6b8ba8bc7cfc) {
  return isDefined(var_87d6b8ba8bc7cfc) ? activitymoment + var_87d6b8ba8bc7cfc : activitymoment;
}

function private function_cccbed6002549b93(activityinstance) {
  if(!isDefined(activityinstance.var_387a685a1fac02e9)) {
    activityinstance.var_24f4c53254b34132 = [];
  }

  var_be7938bdbc64acf6 = function_5f762746b0510611(activityinstance);

  foreach(bundlestruct in var_be7938bdbc64acf6) {
    cacheactivitymoment = namespace_2c51db6714cb3bea::function_8cc696a7ebfd1f54(bundlestruct);
    cacheactivationname = namespace_2c51db6714cb3bea::function_6ec422928b339542(bundlestruct);
    mapkey = function_63fa4fb39dfeaa32(cacheactivitymoment, cacheactivationname);

    if(!isDefined(activityinstance.var_24f4c53254b34132[mapkey])) {
      activityinstance.var_24f4c53254b34132[mapkey] = [];
    }

    numelements = activityinstance.var_24f4c53254b34132[mapkey].size;
    activityinstance.var_24f4c53254b34132[mapkey][numelements] = bundlestruct;
  }
}

function private function_5f762746b0510611(activityinstance) {
  var_a3e46480a2988b91 = activity_common::function_1d6b5b57d24b0bde();
  var_9368bd4f7d3299ce = var_a3e46480a2988b91.var_e2623359e66f941a;
  activitycategory = activityinstance.category;
  var_1bbadd5413017c95 = var_a3e46480a2988b91.var_10cef71f74c57142;
  var_f66d4c5c4dba02f0 = var_1bbadd5413017c95[activitycategory];
  var_156b9e6b697ae435 = namespace_7b5dc905a7ea3e0f::function_a21bf9df37710597(activityinstance);
  var_c0fb8443e15448da = utility::array_combine(var_9368bd4f7d3299ce, var_f66d4c5c4dba02f0, var_156b9e6b697ae435);
  return var_c0fb8443e15448da;
}

function private function_a537ff2c58c08d1e(activityinstance) {
  lootfunctionargs = spawnStruct();
  lootfunctionargs.activity_instance = activityinstance;
  lootfunctionargs.reward_group = undefined;
  return lootfunctionargs;
}

function private function_49117fb61bb256ae(activityinstance, var_54b9879211025bcc) {
  namespace_59dbf6a1bb28a43f::function_4dd55a3a7d36cb21(activityinstance, "s \x83", "@Z'\v\x9eS\xce", "\xa5o-\xbeJ\x01`\xb8\xf9\xaf\x95\x9c\xfcW\xc1\xcd\xce\xa3", "R\xa2W\xa0)D@\xa1\n\x1aH\xa8 \xd4\x14\xa0\xab9\x01\xa6*\x14\x94*");
  var_54b9879211025bcc waittill("\x8a\xc6\xa7\x17o\xc5U\x1c\x8c=\xfbY\xa7\xe9`\xd8\xc3t\x19\bG\x83v\xef\xf9\xfaF\x1d\xc1UR");
  namespace_59dbf6a1bb28a43f::function_30a12e4e4ff02ec8(activityinstance, "\xa5o-\xbeJ\x01`\xb8\xf9\xaf\x95\x9c\xfcW\xc1\xcd\xce\xa3", "w\xaab,\x06\xa9\xc3jm\x87\x1b\x9a+\xab\x82n:$\xb3\xaa\x11\x8b\x84");
}