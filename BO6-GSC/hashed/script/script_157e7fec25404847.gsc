/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_157e7fec25404847.gsc
*****************************************************/

#using script_1aae2eb1ef28b239;
#using script_1f139695c61f1549;
#using script_31805e8ef07bfa53;
#using script_50cece4fabbdcc75;
#using script_569138730a0a130f;
#using script_570f992e202c79b4;
#using script_69192f0994851b83;
#using script_6d60a2f06878900a;
#using script_73a03aaf11b641f5;
#using script_77873e194e406c6d;
#using script_f01501ac138f999;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\system;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace activity_common;

function private autoexec __init__system__() {
  system::register(#"activity_common", undefined, &function_96c13831f651af89, undefined);
}

function private function_96c13831f651af89() {
  level thread function_1040a5831d48bda7();
}

function private function_1040a5831d48bda7() {
  if(isDefined(level.gametypebundle.activitynexussettings)) {
    function_4a9438883689776();
  }
}

function function_4a9438883689776() {
  if(utility::flag("2\xedV\xb2\xeb\xa9L\xf8u\xcc-\x88\xb2\x97\xc2p\xb1OF>.\xaf\b\xbe\xb5\b\xe9\xcf")) {
    return;
  }

  level.activities = function_1a50f1b96e3c2f58();
  namespace_59dbf6a1bb28a43f::function_99aa753d2ffc3bc9();
  namespace_37b952684c0bbb5::function_6dd785648a55b707(level.activities);
  namespace_606113cb7b23f701::function_134663eb84773a73(level.activities);
  namespace_72e72f5e51e6e4b3::function_355e281ae0dc5a13(level.activities);
  level thread function_8abd82227437995b();
  function_b2a343aefa54c6de();
  function_a322f61b8485707f();
  function_cdfab614f8ef7514(1, &namespace_59dbf6a1bb28a43f::setupinstance);
  function_cdfab614f8ef7514(8, &activity_participation::function_6f5e5fd2292fd207);
  function_cdfab614f8ef7514(7, &activity_participation::function_8541b9726c7b8189);
  scriptable::scriptable_addusedcallback(&activity_participation::function_b5fc8c8d490c4cee);
  function_cbc923662b03cacb("H\xd42.\r>=\a\xe5M\xf4\x06\x9c\xf9\xb8b:\xb8\xb0\xc4o\xe1\x95\xe8v\xa8", &function_333ef4e88da3f14e);
  function_cbc923662b03cacb("\xa3\xf1\x03\xf2l\xd4\xc6\x8fe\x03\xc3%\afT\x82,c%\x8d\x94\xd6\f\xab(\x0e", &function_333ef4e88da3f14e);
  function_cbc923662b03cacb("W\xbd\xdec\xf4x\xff\xd76\xfb", &function_7764344aedd036b7);
  function_cbc923662b03cacb("OO\x11h\xc0\xfc\xec\x1d\x9b\xedC", &function_7764344aedd036b7);
  level callback::add("\\\x1c\x9e\xad/\xa7\xdd\xc3?B\x04\x1f\xb1CP\xb3\xcag\xdf\xa7\xc9]\xc6\xda@\xdf\xcdZtAu\xa9\xc8\xb7\xab\xc2\xbb", &function_b862b6b1ab529038);

  namespace_265c578c971c82f5::function_212a87b701fdbc69();

  utility::flag_set("2\xedV\xb2\xeb\xa9L\xf8u\xcc-\x88\xb2\x97\xc2p\xb1OF>.\xaf\b\xbe\xb5\b\xe9\xcf");
}

function registeractivitytype(activitytype, initfunction = undefined) {
  if(!utility::flag("2\xedV\xb2\xeb\xa9L\xf8u\xcc-\x88\xb2\x97\xc2p\xb1OF>.\xaf\b\xbe\xb5\b\xe9\xcf")) {
    return;
  }

  if(!isDefined(level.activities.types[activitytype]) && function_3a5049f83190a608(activitytype)) {
    level.activities.types[activitytype] = spawnStruct();
    activitytypestruct = level.activities.types[activitytype];
    activitytypestruct.shareddata = {};
    activitytypestruct.commonfunctions = [];
    activitytypestruct.commonfunctions[0] = function_ae274f2045bad268(0);
    activitytypestruct.commonfunctions[1] = function_ae274f2045bad268(1);
    activitytypestruct.commonfunctions[2] = function_ae274f2045bad268(2);
    activitytypestruct.commonfunctions[3] = function_ae274f2045bad268(3);
    activitytypestruct.commonfunctions[4] = function_ae274f2045bad268(4);
    activitytypestruct.commonfunctions[6] = function_ae274f2045bad268(6);

    if(isDefined(level.activities.nexusoverrides[0])) {
      function_2ece6c60562ab130(0, [activitytype], 0);
    }

    activitytypestruct function_feb03c26b678f26d();

    if(isDefined(initfunction) && isfunction(initfunction)) {
      [[initfunction]]();
    } else {
      namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x24>" + activitytype, @ "hash_72a413c7683cfc8d");
    }

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x71>" + activitytype + "<dev string:x84>", @ "hash_72a413c7683cfc8d");
  }
}

function function_81b6897a9babcd3(nexusoverridetype, overridefunction) {
  if(isDefined(nexusoverridetype) && isDefined(overridefunction) && isfunction(overridefunction)) {
    level.activities.nexusoverrides[nexusoverridetype] = overridefunction;
    return;
  }

  assertmsg("<dev string:xc2>");
}

function function_90fc2d6a1c5660f0(activitytype, activityfunctiontype, overridefunction) {
  activitytypestruct = level.activities.types[activitytype];
  assert(isDefined(activitytypestruct), "<dev string:x112>");
  activitytypestruct.commonfunctions[activityfunctiontype] = overridefunction;
}

function function_a3f075ba295adccb(var_aa12a35f3dd537d9) {
  if(!utility::flag("2\xedV\xb2\xeb\xa9L\xf8u\xcc-\x88\xb2\x97\xc2p\xb1OF>.\xaf\b\xbe\xb5\b\xe9\xcf")) {
    return;
  }

  level.activities.var_a0bd3e0a4a59438b[level.activities.var_a0bd3e0a4a59438b.size] = {
    #var_aa12a35f3dd537d9: var_aa12a35f3dd537d9
  };
}

function function_a322f61b8485707f() {
  level thread function_2ebddd092c48eba1();
}

function function_d4c38791b19a0631(activityvariantname) {
  var_d2eb8aba5c657d96 = level.activities;

  if(isDefined(var_d2eb8aba5c657d96.var_135a3840c5a5907c[activityvariantname])) {
    return var_d2eb8aba5c657d96.var_135a3840c5a5907c[activityvariantname];
  }

  return undefined;
}

function runactivityfunction(activityinstance, activityfunctiontype, relevantinfostruct) {
  activitytype = activityinstance.type;
  assert(isDefined(level.activities.types[activitytype]), "<dev string:x171>");
  activityfunction = getactivityfunction(activitytype, activityfunctiontype);
  assert(isDefined(activityfunction), "<dev string:x1cb>");

  if(function_eb38b312e745ec43(activityfunctiontype)) {
    if(isDefined(relevantinfostruct)) {
      return activityinstance[[activityfunction]](relevantinfostruct);
    } else {
      return activityinstance[[activityfunction]]();
    }
  }

  activityinstance thread function_9f12ea00b7a319ca(activityinstance, activityfunction, relevantinfostruct);
}

function getactivityfunction(activitytype, activityfunctiontype) {
  assert(isDefined(level.activities.types[activitytype]), "<dev string:x171>");
  activitytypestruct = level.activities.types[activitytype];
  return activitytypestruct.commonfunctions[activityfunctiontype];
}

function function_1800400bc3277cf2(activitytype) {
  assert(isDefined(level.activities.types[activitytype]), "<dev string:x242>");
  activitytypestruct = level.activities.types[activitytype];
  return activitytypestruct.shareddata;
}

function function_ae274f2045bad268(activityfunctiontype) {
  return level.activities.defaultfunctions[activityfunctiontype];
}

function function_1d6b5b57d24b0bde() {
  return level.activities.var_a3e46480a2988b91;
}

function function_e2a88f5f71c982cf() {
  var_52ec82a2ccfc22f2 = function_1d6b5b57d24b0bde();
  return var_52ec82a2ccfc22f2.var_8e7660673aa05497;
}

function function_5cd62eb0de217a5f(activitycategory) {
  var_52ec82a2ccfc22f2 = function_1d6b5b57d24b0bde();
  return var_52ec82a2ccfc22f2.var_9c558c836d872eba[activitycategory];
}

function function_cbc923662b03cacb(activitymoment, callbackfunction, activitytype) {
  callbackcontainer = level.activities;

  if(isDefined(activitytype)) {
    assert(isDefined(level.activities.types[activitytype]), "<dev string:x28a>");
    callbackcontainer = level.activities.types[activitytype];
  }

  assert(isDefined(callbackcontainer.activitymomentcallbacks), "<dev string:x2d5>");

  if(!isDefined(callbackcontainer.activitymomentcallbacks[activitymoment])) {
    callbackcontainer.activitymomentcallbacks[activitymoment] = [];
  }

  callbackarraysize = callbackcontainer.activitymomentcallbacks[activitymoment].size;
  callbackcontainer.activitymomentcallbacks[activitymoment][callbackarraysize] = callbackfunction;
}

function function_1d7710238d53922e(activitymoment, relevantinfostruct) {
  function_faf0b9ea41f6e60d(level.activities, activitymoment, relevantinfostruct);
  activitytype = self.type;
  function_faf0b9ea41f6e60d(level.activities.types[activitytype], activitymoment, relevantinfostruct);
  callback::callback(activitymoment, relevantinfostruct);
}

function getactivityinstance(instanceid) {
  activityinstance = level.activities.instances[instanceid];

  if(!isDefined(activityinstance)) {
    assertmsg("<dev string:x31f>");
  }

  return activityinstance;
}

function isactivityenabled(activitycategory, activitytype, activityvariantname) {
  return function_f7480d67b8766a80(activitycategory) && function_3a5049f83190a608(activitytype) && function_aa676e5e8ffa3493(activityvariantname);
}

function function_f7480d67b8766a80(activitycategory) {
  var_d2eb8aba5c657d96 = level.activities;

  if(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_7f9faf8ec41bd72a.inclusionrule === "u#\x8f\xcb\xc4m\xe4X\x98J\xba1\xbaV\xea\x06_\x11g\xaf\xc3") {
    return istrue(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_7f9faf8ec41bd72a.categorymap[activitycategory]);
  }

  return !isDefined(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_7f9faf8ec41bd72a.categorymap[activitycategory]);
}

function function_3a5049f83190a608(activitytype) {
  var_d2eb8aba5c657d96 = level.activities;

  if(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_1a35f240d7f3df2a.inclusionrule === "u#\x8f\xcb\xc4m\xe4X\x98J\xba1\xbaV\xea\x06_\x11g\xaf\xc3") {
    return istrue(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_1a35f240d7f3df2a.typemap[activitytype]);
  }

  return !isDefined(var_d2eb8aba5c657d96.var_c3909c58959e6d53.var_1a35f240d7f3df2a.typemap[activitytype]);
}

function function_aa676e5e8ffa3493(activityvariantname) {
  var_d2eb8aba5c657d96 = level.activities;

  if(var_d2eb8aba5c657d96.var_c3909c58959e6d53.enabledvariantstruct.inclusionrule === "u#\x8f\xcb\xc4m\xe4X\x98J\xba1\xbaV\xea\x06_\x11g\xaf\xc3") {
    return istrue(var_d2eb8aba5c657d96.var_c3909c58959e6d53.enabledvariantstruct.variantmap[activityvariantname]);
  }

  return !isDefined(var_d2eb8aba5c657d96.var_c3909c58959e6d53.enabledvariantstruct.variantmap[activityvariantname]);
}

function function_4bc9962886502a7e(activityinstance) {
  if(isDefined(activityinstance) && namespace_59dbf6a1bb28a43f::isactivityinstance(activityinstance)) {
    instanceid = activityinstance.id;
    var_56fe2b76e53dc95 = level.activities.instances[instanceid];
    return (isDefined(var_56fe2b76e53dc95) && var_56fe2b76e53dc95 == activityinstance);
  }

  return false;
}

function function_833543059414d77c() {
  return level.activities.instances;
}

function function_8dd743a740eceb88(varianttag) {
  foreach(activityinstance in level.activities.instances) {
    if(isDefined(activityinstance)) {
      if(activityinstance.varianttag == varianttag && !activity_participation::activityinstanceisfull(activityinstance)) {
        return activityinstance;
      }
    }
  }

  iprintln("<dev string:x355>");

  return undefined;
}

function function_a3a39b3c2b27bcdc(point, var_42805d8fdee4e72, conditionalcontainer) {
  closestinstance = undefined;
  closestdistance = undefined;

  if(!isDefined(var_42805d8fdee4e72)) {
    var_42805d8fdee4e72 = level.activities.instances;
  }

  foreach(activityinstance in var_42805d8fdee4e72) {
    var_4999a646b7933ca7 = !isDefined(conditionalcontainer) || conditional_container::function_ac8003c33335a40f(conditionalcontainer, activityinstance);

    if(var_4999a646b7933ca7) {
      distancesq = distancesquared(point, namespace_59dbf6a1bb28a43f::function_c1c44508d7539941(activityinstance));

      if(!(isDefined(closestinstance) && isDefined(closestdistance)) || distancesq < closestdistance) {
        closestdistance = distancesq;
        closestinstance = activityinstance;
      }
    }
  }

  return closestinstance;
}

function connectactivityinstance(activityinstance) {
  instid = activityinstance.id;
  level.activities.instances[instid] = activityinstance;
  level.activities.awakeinstances[instid] = activityinstance;

  if(namespace_7b5dc905a7ea3e0f::function_8a9095c5f92d736(activityinstance)) {
    level.activities.var_c4e34647ad777d79[instid] = activityinstance;
  }
}

function disconnectactivityinstance(activityinstance) {
  instid = activityinstance.id;
  level.activities.var_d834fee78ba968ba[level.activities.var_d834fee78ba968ba.size] = instid;
  level.activities.instances[instid] = undefined;
  level.activities.awakeinstances[instid] = undefined;
  level.activities.var_c4e34647ad777d79[instid] = undefined;
}

function getuniqueinstanceid() {
  if(level.activities.var_d834fee78ba968ba.size > 0) {
    id = level.activities.var_d834fee78ba968ba[0];
    level.activities.var_d834fee78ba968ba = arrayremove(level.activities.var_d834fee78ba968ba, id);
    return id;
  } else {
    id = level.activities.var_c98be89f66b3e1e0;
    level.activities.var_c98be89f66b3e1e0++;
  }

  return id;
}

function function_f04a771049752e35(activitytype, activityfunctiontype) {
  defaultactivityfunction = function_ae274f2045bad268(activityfunctiontype);
  currentactivityfunction = getactivityfunction(activitytype, activityfunctiontype);

  if(!isDefined(currentactivityfunction) || defaultactivityfunction == currentactivityfunction) {
    return false;
  }

  return true;
}

function function_c00c85d2cb72fee7(nexusoverridetype) {
  return isDefined(level.activities.nexusoverrides[nexusoverridetype]);
}

function function_2ece6c60562ab130(nexusoverridetype, relevantparameters, shouldthread) {
  if(isDefined(level.activities.nexusoverrides[nexusoverridetype]) && isfunction(level.activities.nexusoverrides[nexusoverridetype])) {
    if(istrue(shouldthread)) {
      return self thread[[level.activities.nexusoverrides[nexusoverridetype]]](relevantparameters);
    } else {
      return [[level.activities.nexusoverrides[nexusoverridetype]]](relevantparameters);
    }

    return;
  }

  assertmsg("<dev string:x395>");
}

function function_9c3896bd08c52ae8(spatialzonecontainer, spatialzonename) {
  if(isDefined(level.activities.nexusoverrides[12])) {
    function_2ece6c60562ab130(12, [spatialzonecontainer, spatialzonename]);
    return;
  }

  if(spatialzonename == "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!") {
    activitynexussettings = level.activities.activitynexussettings;
    var_ff503f80dd478a5e = activitynexussettings.var_ce13d1c16ecfd616[0].variant_object;

    if(isDefined(var_ff503f80dd478a5e)) {
      namespace_7b5dc905a7ea3e0f::function_443bf722a7d22510(spatialzonecontainer, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!", var_ff503f80dd478a5e);
    } else {
      var_7526486ee5deb158 = 10000;
      namespace_9342d78fcaacff0b::function_d98dd1246d42a25e(spatialzonecontainer, "\x8f/\x117>.\xa1\xf9\xf5<\xeb\x7fUmO!", undefined, var_7526486ee5deb158);
    }

    if(namespace_59dbf6a1bb28a43f::isactivityinstance(spatialzonecontainer)) {
      activityinstance = spatialzonecontainer;
      namespace_9342d78fcaacff0b::function_7ade4e318cc0a207(activityinstance, spatialzonename, &namespace_59dbf6a1bb28a43f::function_c1c44508d7539941, [activityinstance]);
    }

    return;
  }

  assert("<dev string:x3e0>" + spatialzonename + "<dev string:x415>");
}

function function_116071a5270d02cb(joininteracts, associatedactivityinstance) {
  instanceid = associatedactivityinstance.id;
  var_d2eb8aba5c657d96 = level.activities;

  if(!isarray(joininteracts)) {
    joininteracts = [joininteracts];
  }

  if(isDefined(var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid])) {
    foreach(joininteract in joininteracts) {
      joininteractkey = utility::array_find(var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid], joininteract);

      if(isDefined(joininteractkey)) {
        activityinstance = level.activities.instances[instanceid];
        activityvariantname = activityinstance.varianttag;
        activitytype = activityinstance.type;
        assert("<dev string:x46a>" + activitytype + "<dev string:x4e8>" + activityvariantname);
        return;
      }
    }
  }

  foreach(joininteract in joininteracts) {
    joininteract.associatedactivityinstance = associatedactivityinstance;

    if(!isDefined(var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid])) {
      var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid] = [];
    }

    var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid][var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid].size] = joininteract;
  }
}

function function_8186d519c4482354(associatedactivityinstance) {
  instanceid = associatedactivityinstance.id;
  var_d2eb8aba5c657d96 = level.activities;
  activityjoininteracts = var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid];

  if(isDefined(activityjoininteracts)) {
    foreach(activityjoininteract in activityjoininteracts) {
      if(isDefined(activityjoininteract)) {
        activityjoininteract.associatedactivityinstance = associatedactivityinstance;
        activityjoininteract.associatedactivityinstance = undefined;
      }
    }

    var_d2eb8aba5c657d96.var_222f418ee6bda53d[instanceid] = undefined;
  }
}

function private function_1a50f1b96e3c2f58() {
  var_49da155944ad2ad3 = spawnStruct();
  var_49da155944ad2ad3.types = [];
  var_49da155944ad2ad3.definitions = [];
  var_49da155944ad2ad3.instances = [];
  var_49da155944ad2ad3.var_222f418ee6bda53d = [];
  var_49da155944ad2ad3.nexusoverrides = [];
  var_49da155944ad2ad3.defaultfunctions = [];
  var_49da155944ad2ad3.awakeinstances = [];
  var_49da155944ad2ad3.var_c4e34647ad777d79 = [];
  var_49da155944ad2ad3.var_a0bd3e0a4a59438b = [];
  var_49da155944ad2ad3.var_c98be89f66b3e1e0 = 0;
  var_49da155944ad2ad3.var_d834fee78ba968ba = [];

  if(isDefined(level.gametypebundle.activitynexussettings)) {
    activitynexussettings = getscriptbundle(level.gametypebundle.activitynexussettings);
  }

  if(!isDefined(activitynexussettings)) {
    activitynexussettings = getscriptbundle("\xd1\"\xd2\xae\xe2\n\x1c\x19\xd5\x87\x13\xd7\xc0x\xc7yp\x82\xfe\xb0\x13\x98jS\xdb\x94\xf3I\x82;\xaa\xcc\xe8\x9daN%{bB\xf87\x18\xbc\x9c\xf2\xb8\xfe\x1eW\xa9");
  }

  var_49da155944ad2ad3.activitynexussettings = activitynexussettings;
  var_49da155944ad2ad3.var_a3e46480a2988b91 = function_2e0bf7ada8a8d088();
  var_49da155944ad2ad3.var_30a589f82d9a8555 = namespace_98284635f20f4696::function_76d178aa5df68fe1(activitynexussettings.activitydefinitioncachesize);
  var_49da155944ad2ad3.var_ca45771bdb7140b2 = [];
  var_49da155944ad2ad3.defaultfunctions[0] = &namespace_59dbf6a1bb28a43f::function_27802dae6e2c93fd;
  var_49da155944ad2ad3.defaultfunctions[1] = &namespace_59dbf6a1bb28a43f::function_7a40ca327ba849e5;
  var_49da155944ad2ad3.defaultfunctions[2] = &namespace_59dbf6a1bb28a43f::function_3cb4475857b12c1;
  var_49da155944ad2ad3.defaultfunctions[3] = &namespace_59dbf6a1bb28a43f::function_55e2a232e07726a2;
  var_49da155944ad2ad3.defaultfunctions[4] = &namespace_59dbf6a1bb28a43f::function_56ea198b94fb1dd1;
  var_49da155944ad2ad3.defaultfunctions[5] = &activity_rewards::function_22869ba492bd758;
  var_49da155944ad2ad3.defaultfunctions[6] = &activity_rewards::getrewardgroups;
  var_49da155944ad2ad3.var_135a3840c5a5907c = [];
  var_49da155944ad2ad3.activitymoments = ["n\x9b\xad\xd2\x96\xc1\x19}\xcf%\as\x11", "\x94\xe6n\x8e\v\xdclYEsd", "\x14\x9b{|,\x05\xd9\f9\x86)\xce6", "(\xbd%\xa1\x18I\xd2xur\xcb", "\xf2\xd0w\xcbg\xf7@\\BA>q\xbf\xd9\xec", "\xc54k\xe4%\xf2\x14\xc4X;\xc6\xdc\xf1\xf5M", "W\xbd\xdec\xf4x\xff\xd76\xfb", "OO\x11h\xc0\xfc\xec\x1d\x9b\xedC", "\xaf\x19f\x93\xc1\xcbU/AA\x89\x869", "(l\v\xe5\xac\x9c%Vf\xb7l]\xe6Y2O\xdc\x14\x8d:\xd2gZt\x97", "\x05c\v^\xb2NTs\x1d\xacr\xca2(\xddX\xe4\xcas+ns\xb4\xed\x9b\x95", "O\xa1\x7f\xe6\xea\x0f\xf4\x97\xa6w\x1d(\xe6\xcem\x17\xa4y\xf1\xe6\xcee\xfb\xab\x18", "H\xd42.\r>=\a\xe5M\xf4\x06\x9c\xf9\xb8b:\xb8\xb0\xc4o\xe1\x95\xe8v\xa8", "\xa3\xf1\x03\xf2l\xd4\xc6\x8fe\x03\xc3%\afT\x82,c%\x8d\x94\xd6\f\xab(\x0e"];
  var_49da155944ad2ad3 function_feb03c26b678f26d();
  var_49da155944ad2ad3.var_c3909c58959e6d53 = function_902d6a0cd0f8aea8(var_49da155944ad2ad3.activitynexussettings);
  return var_49da155944ad2ad3;
}

function private function_2ebddd092c48eba1() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  var_d2eb8aba5c657d96 = level.activities;

  if(istrue(var_d2eb8aba5c657d96.var_78c763c0a85ba602)) {
    return;
  }

  var_d2eb8aba5c657d96.var_78c763c0a85ba602 = 1;

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  variantscriptstructs = utility::getStructArray("\x80\xfeu\xdc\x83\xb3\xb3n\xecr{\xe3\x1d\xc6<\xf1\x84\xe8\xe4L\x82b", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  variantscriptstructs = utility::array_combine(variantscriptstructs, utility::getStructArray("\x80\xfeu\xdc\x83\xb3\xb3n\xecr{\xe3\x1d\xc6<\xf1\x84\xe8\xe4L\x82b", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*"));
  var_d2eb8aba5c657d96.var_135a3840c5a5907c = [];

  foreach(variantscriptstruct in variantscriptstructs) {
    if(isDefined(variantscriptstruct.name) && variantscriptstruct.name != "") {
      if(isDefined(var_d2eb8aba5c657d96.var_135a3840c5a5907c[variantscriptstruct.name])) {
        continue;
      }

      linkedstructs = variantscriptstruct utility::get_linked_structs();
      var_d2eb8aba5c657d96.var_135a3840c5a5907c[variantscriptstruct.name] = {
        #linkedstructs: variantscriptstruct utility::get_linked_structs(), #variantstruct: variantscriptstruct
      };
    }
  }

  if(isDefined(var_d2eb8aba5c657d96.var_135a3840c5a5907c)) {
    foreach(variantscriptstructinfo in var_d2eb8aba5c657d96.var_135a3840c5a5907c) {
      level.var_958029290f313b7e = [];
      variantstruct = variantscriptstructinfo.variantstruct;
      var_990135b09c2429ce = activityvariantname;

      while(isDefined(variantstruct)) {
        if(isDefined(level.var_958029290f313b7e[var_990135b09c2429ce])) {
          assertmsg("<dev string:x4ef>" + var_990135b09c2429ce + "<dev string:x531>" + variantstruct.parentvariant + "<dev string:x54c>" + var_990135b09c2429ce + "<dev string:x56b>");
          break;
        }

        level.var_958029290f313b7e[var_990135b09c2429ce] = 1;

        if(isstring(variantstruct.parentvariant)) {
          var_990135b09c2429ce = variantstruct.parentvariant;
          variantscriptstructinfo = var_d2eb8aba5c657d96.var_135a3840c5a5907c[var_990135b09c2429ce];
          variantstruct = variantscriptstructinfo.variantstruct;
          continue;
        }

        variantstruct = undefined;
      }
    }
  }

  var_d2eb8aba5c657d96.var_78c763c0a85ba602 = 0;
}

function private function_902d6a0cd0f8aea8(activitynexussettings) {
  var_c3909c58959e6d53 = {
    #enabledvariantstruct: {
      #variantmap: [], #inclusionrule: "\x90\xe3c\xfb\x8d\xdbD\x01\x01I\x17FoG\x8d\xe7\xe9\xe3\xd4zF\x17"}, #var_1a35f240d7f3df2a: {
      #typemap: [], #inclusionrule: "\x90\xe3c\xfb\x8d\xdbD\x01\x01I\x17FoG\x8d\xe7\xe9\xe3\xd4zF\x17"}, #var_7f9faf8ec41bd72a: {
      #categorymap: [], #inclusionrule: "\x90\xe3c\xfb\x8d\xdbD\x01\x01I\x17FoG\x8d\xe7\xe9\xe3\xd4zF\x17"}
  };

  if(isDefined(activitynexussettings)) {
    var_c3909c58959e6d53.var_7f9faf8ec41bd72a.inclusionrule = activitynexussettings.var_2ddc029e5854bab4.inclusionrule;
    var_c3909c58959e6d53.var_1a35f240d7f3df2a.inclusionrule = activitynexussettings.var_6308a7b81ceadb6c.inclusionrule;
    var_c3909c58959e6d53.enabledvariantstruct.inclusionrule = activitynexussettings.var_63d93179115ad415.inclusionrule;

    foreach(var_bddff4dc91f53507 in activitynexussettings.var_2ddc029e5854bab4.var_79907845b54c7763) {
      var_c3909c58959e6d53.var_7f9faf8ec41bd72a.categorymap[var_bddff4dc91f53507.value] = 1;
    }

    foreach(var_30eb8e287641adfb in activitynexussettings.var_6308a7b81ceadb6c.toggledactivitytypes) {
      var_c3909c58959e6d53.var_1a35f240d7f3df2a.typemap[var_30eb8e287641adfb.value] = 1;
    }

    foreach(toggledvariantstruct in activitynexussettings.var_63d93179115ad415.var_2cbfb1256e6ee9e1) {
      var_c3909c58959e6d53.enabledvariantstruct.variantmap[toggledvariantstruct.value] = 1;
    }
  } else {
    assertmsg("<dev string:x597>");
  }

  return var_c3909c58959e6d53;
}

function private function_2e0bf7ada8a8d088() {
  var_a3e46480a2988b91 = spawnStruct();
  var_a3e46480a2988b91.var_8e7660673aa05497 = [];
  var_a3e46480a2988b91.var_9c558c836d872eba = [];
  var_a3e46480a2988b91.var_e2623359e66f941a = [];
  var_a3e46480a2988b91.var_10cef71f74c57142 = [];
  return var_a3e46480a2988b91;
}

function private function_b2a343aefa54c6de() {
  var_a3e46480a2988b91 = function_1d6b5b57d24b0bde();
  function_df1bd585cd60ed35(var_a3e46480a2988b91);
  function_cafdea165c648f3a(var_a3e46480a2988b91);
}

function private function_df1bd585cd60ed35(var_a3e46480a2988b91) {
  bundlenames = getscriptbundlenames("z\x12\xf4\x13p\f~\n\x89v\t\xe8\r\xb6\x1f\xcb\xc5\x7f\xe2\xa2v\x19\xb3");

  foreach(var_4b699f4df2cbb1a1 in bundlenames) {
    var_6010bea1f962d13e = getscriptbundle(var_4b699f4df2cbb1a1);

    if(isDefined(var_6010bea1f962d13e)) {
      var_c347fea8885e914b = isDefined(var_6010bea1f962d13e.playerbroadcasts) && var_6010bea1f962d13e.playerbroadcasts.size > 0;
      var_dacec1a03db19dc4 = isDefined(var_6010bea1f962d13e.sharingoptions) && var_6010bea1f962d13e.sharingoptions.size > 0;

      if(var_c347fea8885e914b && var_dacec1a03db19dc4) {
        broadcastsharingoptions = var_6010bea1f962d13e.sharingoptions[0].variant_object;

        if(istrue(broadcastsharingoptions.var_964d8d42fd9a417f)) {
          foreach(playerbroadcast in var_6010bea1f962d13e.playerbroadcasts) {
            var_a3e46480a2988b91.var_8e7660673aa05497[var_a3e46480a2988b91.var_8e7660673aa05497.size] = playerbroadcast;
          }

          continue;
        }

        if(istrue(broadcastsharingoptions.var_7086d68ff9908ff) && isDefined(broadcastsharingoptions.activitycategory)) {
          var_e4e7cf3b165e665d = broadcastsharingoptions.activitycategory;
          assert(var_e4e7cf3b165e665d != "<dev string:x62f>", "<dev string:x637>");

          if(!isDefined(var_a3e46480a2988b91.var_9c558c836d872eba[var_e4e7cf3b165e665d])) {
            var_a3e46480a2988b91.var_9c558c836d872eba[var_e4e7cf3b165e665d] = [];
          }

          foreach(playerbroadcast in var_6010bea1f962d13e.playerbroadcasts) {
            var_d7c83946c44290b0 = var_a3e46480a2988b91.var_9c558c836d872eba[var_e4e7cf3b165e665d].size;
            var_a3e46480a2988b91.var_9c558c836d872eba[var_e4e7cf3b165e665d][var_d7c83946c44290b0] = playerbroadcast;
          }
        }
      }
    }
  }
}

function private function_cafdea165c648f3a(var_a3e46480a2988b91) {
  bundlenames = getscriptbundlenames("FL\x9c\x16\x01\x03\xdcs#\xe31!T\xa5\xd4");

  foreach(bundlename in bundlenames) {
    bundle = getscriptbundle(bundlename);
    function_a255a38d1dcbf8aa(var_a3e46480a2988b91, bundle);
  }
}

function private function_a255a38d1dcbf8aa(var_a3e46480a2988b91, var_bc12eabd6490940d) {
  sharingtype = namespace_17a8c82d9ef726fc::function_7c8eec7a6f89aa68(var_bc12eabd6490940d);

  if(!isDefined(sharingtype) || sharingtype == "+\xfc\xe5\xe0FJ\x91\t\xbd\xfe\x9a\x80#\xcfQ\xd3;M\xf8\x12\xc8\f\xd5") {
    return;
  }

  var_e919bf1a2d44dc23 = namespace_17a8c82d9ef726fc::function_63cc93d3c1bc09c0(var_bc12eabd6490940d);

  if(!isDefined(var_e919bf1a2d44dc23) || var_e919bf1a2d44dc23.size == 0) {
    return;
  }

  switch (sharingtype) {
    case #"hash_5e3671de7b9f5a2a":
      function_cf656eb6388954e4(var_a3e46480a2988b91, var_e919bf1a2d44dc23);
      return;
    case #"hash_31d6baffebed40ac":
      categorytype = namespace_17a8c82d9ef726fc::function_1f0b92b970e0bc2a(var_bc12eabd6490940d);
      function_8730e12ab9b18555(var_a3e46480a2988b91, categorytype, var_e919bf1a2d44dc23);
      return;
    default:
      assertmsg("<dev string:x6c3>" + sharingtype);
      return;
  }
}

function private function_cf656eb6388954e4(var_a3e46480a2988b91, var_e919bf1a2d44dc23) {
  foreach(var_81c60b51713d80e9 in var_e919bf1a2d44dc23) {
    var_a3e46480a2988b91.var_e2623359e66f941a[var_a3e46480a2988b91.var_e2623359e66f941a.size] = var_81c60b51713d80e9;
  }
}

function private function_8730e12ab9b18555(var_a3e46480a2988b91, categorytype, var_e919bf1a2d44dc23) {
  assert(isDefined(categorytype));
  assert(categorytype != "<dev string:x62f>", "<dev string:x6f3>");

  if(!isDefined(var_a3e46480a2988b91.var_10cef71f74c57142[categorytype])) {
    var_a3e46480a2988b91.var_10cef71f74c57142[categorytype] = [];
  }

  foreach(var_81c60b51713d80e9 in var_e919bf1a2d44dc23) {
    size = var_a3e46480a2988b91.var_10cef71f74c57142[categorytype].size;
    var_a3e46480a2988b91.var_10cef71f74c57142[categorytype][size] = var_81c60b51713d80e9;
  }
}

function private function_cdfab614f8ef7514(nexusoverridetype, function) {
  if(!isDefined(level.activities.nexusoverrides[nexusoverridetype])) {
    function_81b6897a9babcd3(nexusoverridetype, function);
  }
}

function private function_eb38b312e745ec43(activityfunctiontype) {
  var_d71cfc73fc58b350 = [4, 5, 6, 7];
  return arraycontains(var_d71cfc73fc58b350, activityfunctiontype);
}

function private function_9f12ea00b7a319ca(activityinstance, overridefunction, relevantinfostruct) {
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");

  if(isDefined(overridefunction) && isfunction(overridefunction)) {
    if(isDefined(relevantinfostruct)) {
      activityinstance[[overridefunction]](relevantinfostruct);
    } else {
      activityinstance[[overridefunction]]();
    }

    return;
  }

  assertmsg("<dev string:x78b>");
}

function private function_faf0b9ea41f6e60d(activitymomentcallbackcontainer, activitymoment, relevantinfostruct) {
  var_3ba096a9e1f7f697 = isDefined(activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment]) && activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment].size > 0;

  if(var_3ba096a9e1f7f697) {
    foreach(callback in activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment]) {
      self thread[[callback]](relevantinfostruct);
    }
  }
}

function private function_feb03c26b678f26d() {
  self.activitymomentcallbacks = [];
}

function private function_333ef4e88da3f14e(relevantinfostruct) {
  activityinstance = self;
  instid = activityinstance.id;

  if(relevantinfostruct.activitymoment == "H\xd42.\r>=\a\xe5M\xf4\x06\x9c\xf9\xb8b:\xb8\xb0\xc4o\xe1\x95\xe8v\xa8") {
    level.activities.awakeinstances[instid] = undefined;
    return;
  }

  if(relevantinfostruct.activitymoment == "\xa3\xf1\x03\xf2l\xd4\xc6\x8fe\x03\xc3%\afT\x82,c%\x8d\x94\xd6\f\xab(\x0e") {
    level.activities.awakeinstances[instid] = activityinstance;
  }
}

function private function_7764344aedd036b7(relevantinfostruct) {
  activityinstance = self;
  instid = activityinstance.id;
  activitystate = activityinstance.state;
  var_7c6afe681cd9d596 = activitystate == "\xa2\xb9\x19\x95d" || activitystate == "@Z'\v\x9eS\xce";

  if(activityinstance.playerparticipants.size == 0 && !var_7c6afe681cd9d596) {
    level.activities.var_c4e34647ad777d79[instid] = activityinstance;
    return;
  }

  level.activities.var_c4e34647ad777d79[instid] = undefined;
}

function private function_8abd82227437995b() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(!utility::flag("<dev string:x7c5>")) {
    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x7e6>", @ "hash_4a93c7546965668");
  }

  utility::flag_wait("\xb3\xa2\xd5\x7f\x9c\xef~`\xe6\xe1S\xa8\x88\xa2\aS\xc5ohnP98\f\xd0\x91\x17\xdb\x88");
  utility::callsharedfunc(#"ai_spawn_director", #"activityaiencounterinit");
}

function private function_b862b6b1ab529038(params) {
  namespace_7b5dc905a7ea3e0f::function_946dc3008e92ada();
}

function private function_b127cae4ae2daa88() {
  assert(isDefined(level));
  var_3f6028300a0f986b = 1;
}