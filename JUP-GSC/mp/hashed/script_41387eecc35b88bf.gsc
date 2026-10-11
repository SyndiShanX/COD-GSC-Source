/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_41387eecc35b88bf.gsc
*************************************************/

#using script_17dc47fb18ded931;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_3ab210ea917601e7;
#using script_3ac7886f9e4eceef;
#using script_4386d9962a41afc1;
#using script_54f6d121e91434f8;
#using script_570f992e202c79b4;
#using script_5815a7cb4d944542;
#using script_5d8202968463a21d;
#using script_6ab44ed36fd7016b;
#using script_6cf3c7c08335321b;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace activity_common;

function function_89929df8c53338f7() {
  if(isDefined(level.activities)) {
    return;
  }

  level.activities = function_7549ff50f90523c9();
  function_c71c80e21eeb98b0();
  function_c993d376e8f10816(level.activities);
  function_9c328f2f2bc853e6(level.activities);
  function_8dd9dcec6a76bffa(level.activities);
  function_32e7e3d48cd4aec3();
  function_dbdf04ed40266c5(1, &setupinstance);
  function_dbdf04ed40266c5(8, &function_7945819e2d7fc956);
  function_dbdf04ed40266c5(7, &function_38b174f96132d2b4);
  scripts\engine\scriptable::scriptable_addusedcallback(&function_daec7b884974dd17);
  function_8b5b2a3392fc7e2a("ActivityStartedHibernation", &function_7b88d59f853b6833);
  function_8b5b2a3392fc7e2a("ActivityStoppedHibernating", &function_7b88d59f853b6833);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_52a69420197eee1e);
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_52a69420197eee1e);

  namespace_bcc754285d90ffd9::function_b6f69d3336218238();
}

function registeractivitytype(activitytype, initfunction) {
  if(!isDefined(level.activities.types[activitytype])) {
    level.activities.types[activitytype] = spawnStruct();
    activitytypestruct = level.activities.types[activitytype];
    activitytypestruct.commonfunctions = [];
    activitytypestruct.commonfunctions[0] = function_35c9943414b3e6ed(0);
    activitytypestruct.commonfunctions[1] = function_35c9943414b3e6ed(1);
    activitytypestruct.commonfunctions[2] = function_35c9943414b3e6ed(2);
    activitytypestruct.commonfunctions[3] = function_35c9943414b3e6ed(3);
    activitytypestruct.commonfunctions[4] = function_35c9943414b3e6ed(4);
    activitytypestruct.commonfunctions[6] = function_35c9943414b3e6ed(6);
    activitytypestruct.commonfunctions[8] = function_35c9943414b3e6ed(8);

    if(function_71d38726159c3f12(0)) {
      function_f541e4e4edaa8e99(0, [activitytype], 0);
    }

    activitytypestruct function_a1df1f29568a9e00();

    if(isDefined(initfunction) && isfunction(initfunction)) {
      [[initfunction]]();
      return;
    }

    assertmsg("<dev string:x1c>" + activitytype);
  }
}

function function_86f446036c3c25a3(associatedscriptbundlename, var_3b094ac967cc591) {
  if(!function_34d878874ef424(var_3b094ac967cc591)) {
    activityvariantdefinition = spawnStruct();
    activityvariantdefinition.isactivitydefinition = 1;
    activityvariantdefinition.associatedscriptbundlename = associatedscriptbundlename;

    if(!isDefined(level.activities.var_5357362cdc826253[associatedscriptbundlename])) {
      var_92b48cef37e16a18 = function_f6fcb473df19105c(activityvariantdefinition);
      level.activities.var_5357362cdc826253[associatedscriptbundlename] = var_92b48cef37e16a18.customproperties;
    }

    level.activities.definitions[var_3b094ac967cc591] = activityvariantdefinition;
  }

  return level.activities.definitions[var_3b094ac967cc591];
}

function function_edb2f945bfe8e85e(nexusoverridetype, overridefunction) {
  if(isDefined(nexusoverridetype) && isDefined(overridefunction) && isfunction(overridefunction)) {
    level.activities.nexusoverrides[nexusoverridetype] = overridefunction;
    return;
  }

  assertmsg("<dev string:x72>");
}

function function_89384091f7a2dbd(activitytype, activityfunctiontype, overridefunction) {
  activitytypestruct = level.activities.types[activitytype];
  assertex(isDefined(activitytypestruct), "<dev string:xc2>");
  activitytypestruct.commonfunctions[activityfunctiontype] = overridefunction;
}

function runactivityfunction(activityinstance, activityfunctiontype, relevantinfostruct) {
  activitytype = getactivitytype(activityinstance);
  assertex(isDefined(level.activities.types[activitytype]), "<dev string:x121>");
  activityfunction = getactivityfunction(activitytype, activityfunctiontype);
  assertex(isDefined(activityfunction), "<dev string:x17b>");

  if(function_9b97c3ae49015fc6(activityfunctiontype)) {
    if(isDefined(relevantinfostruct)) {
      return activityinstance[[activityfunction]](relevantinfostruct);
    } else {
      return activityinstance[[activityfunction]]();
    }
  }

  activityinstance thread function_d9c449df6f5a5dd3(activityinstance, activityfunction, relevantinfostruct);
}

function getactivityfunction(activitytype, activityfunctiontype) {
  assertex(isDefined(level.activities.types[activitytype]), "<dev string:x121>");
  activitytypestruct = level.activities.types[activitytype];
  return activitytypestruct.commonfunctions[activityfunctiontype];
}

function function_efe441752cd7303d() {
  return level.activities;
}

function function_c795f9c21a9bc8() {
  return level.activities.activitymoments;
}

function function_35c9943414b3e6ed(activityfunctiontype) {
  return level.activities.defaultfunctions[activityfunctiontype];
}

function function_8e6b7fc389a5a9b3() {
  return level.activities.var_95a5b3673c07cc00;
}

function function_8ad3316a4c90145e() {
  var_cb660804b150adc3 = function_8e6b7fc389a5a9b3();
  return var_cb660804b150adc3.var_98b653a321a7b68a;
}

function function_f96946a72c233e56(activitycategory) {
  var_cb660804b150adc3 = function_8e6b7fc389a5a9b3();
  return var_cb660804b150adc3.var_cc3816954252444b[activitycategory];
}

function function_8b5b2a3392fc7e2a(activitymoment, callbackfunction, activitytype) {
  callbackcontainer = level.activities;

  if(isDefined(activitytype)) {
    assertex(isDefined(level.activities.types[activitytype]), "<dev string:x1f2>");
    callbackcontainer = level.activities.types[activitytype];
  }

  assertex(isDefined(callbackcontainer.activitymomentcallbacks), "<dev string:x23d>");

  if(!isDefined(callbackcontainer.activitymomentcallbacks[activitymoment])) {
    callbackcontainer.activitymomentcallbacks[activitymoment] = [];
  }

  callbackarraysize = callbackcontainer.activitymomentcallbacks[activitymoment].size;
  callbackcontainer.activitymomentcallbacks[activitymoment][callbackarraysize] = callbackfunction;
}

function function_42ab09fd1c5bf443(activitymoment, relevantinfostruct) {
  function_38f500f64a70b3c8(level.activities, activitymoment, relevantinfostruct);
  activitytype = getactivitytype(self);
  function_38f500f64a70b3c8(level.activities.types[activitytype], activitymoment, relevantinfostruct);
  callback::callback(activitymoment, relevantinfostruct);
}

function function_34d878874ef424(varianttag) {
  activitydefinition = level.activities.definitions[varianttag];
  return isDefined(activitydefinition);
}

function getactivityinstance(instanceid) {
  activityinstance = level.activities.instances[instanceid];

  if(!isDefined(activityinstance)) {
    assertmsg("<dev string:x287>");
  }

  return activityinstance;
}

function function_ac8de2bae6931ae3(activityinstance) {
  if(isDefined(activityinstance) && isactivityinstance(activityinstance)) {
    instanceid = getinstanceid(activityinstance);
    var_8a040e43339bcd9c = level.activities.instances[instanceid];
    return (isDefined(var_8a040e43339bcd9c) && var_8a040e43339bcd9c == activityinstance);
  }

  return false;
}

function function_385b578f25b2e1f1() {
  return level.activities.instances;
}

function function_ebcfa8f0cbb5cbf1(varianttag) {
  foreach(activityinstance in level.activities.instances) {
    if(isDefined(activityinstance)) {
      if(activityinstance.varianttag == varianttag && !activityinstanceisfull(activityinstance)) {
        return activityinstance;
      }
    }
  }

  iprintln("<dev string:x2bd>");

  return undefined;
}

function function_8ba4c11453487949(point, var_67020853b5b45a1b, conditionalcontainer) {
  closestinstance = undefined;
  closestdistance = undefined;
  var_67020853b5b45a1b = default_to(var_67020853b5b45a1b, level.activities.instances);

  foreach(activityinstance in var_67020853b5b45a1b) {
    var_c6581e6d07e94306 = !isDefined(conditionalcontainer) || function_93587d5ba6247f36(conditionalcontainer, activityinstance);

    if(var_c6581e6d07e94306) {
      distancesq = distancesquared(point, namespace_68dc261109a9503f::function_8988a4c89289d7f4(activityinstance));

      if(!isDefined(closestinstance) || !isDefined(closestdistance) || distancesq < closestdistance) {
        closestdistance = distancesq;
        closestinstance = activityinstance;
      }
    }
  }

  return closestinstance;
}

function function_9a6951feddd3cd17(var_8deb605bbab4c5b2) {
  assertex(isDefined(level.activities.var_fc24547823253662[var_8deb605bbab4c5b2]), "<dev string:x2fd>");
  return level.activities.var_fc24547823253662[var_8deb605bbab4c5b2];
}

function connectactivityinstance(activityinstance) {
  instid = getinstanceid(activityinstance);
  level.activities.instances[instid] = activityinstance;
  level.activities.awakeinstances[instid] = activityinstance;

  if(function_602655b21cbe7767(activityinstance)) {
    level.activities.var_dde04de762f05a54[instid] = activityinstance;
  }
}

function disconnectactivityinstance(activityinstance) {
  instid = getinstanceid(activityinstance);
  level.activities.var_da5e5d845600111b[level.activities.var_da5e5d845600111b.size] = instid;
  level.activities.instances[instid] = undefined;
  level.activities.awakeinstances[instid] = undefined;
  level.activities.var_dde04de762f05a54[instid] = undefined;
}

function function_a5424c44da084d6e() {
  return level.activities.playerfocusconditions;
}

function getuniqueinstanceid() {
  if(level.activities.var_da5e5d845600111b.size > 0) {
    id = level.activities.var_da5e5d845600111b[0];
    level.activities.var_da5e5d845600111b = array_remove(level.activities.var_da5e5d845600111b, id);
    return id;
  } else {
    id = level.activities.var_44b0386160008fd1;
    level.activities.var_44b0386160008fd1++;
  }

  return id;
}

function function_538af8a5b8170d0c(activitytype, activityfunctiontype) {
  defaultactivityfunction = function_35c9943414b3e6ed(activityfunctiontype);
  currentactivityfunction = getactivityfunction(activitytype, activityfunctiontype);

  if(!isDefined(currentactivityfunction) || defaultactivityfunction == currentactivityfunction) {
    return false;
  }

  return true;
}

function function_71d38726159c3f12(nexusoverridetype) {
  return isDefined(level.activities.nexusoverrides[nexusoverridetype]);
}

function function_f541e4e4edaa8e99(nexusoverridetype, relevantparameters, shouldthread) {
  if(isDefined(level.activities.nexusoverrides[nexusoverridetype]) && isfunction(level.activities.nexusoverrides[nexusoverridetype])) {
    if(istrue(shouldthread)) {
      return self thread[[level.activities.nexusoverrides[nexusoverridetype]]](relevantparameters);
    } else {
      return [[level.activities.nexusoverrides[nexusoverridetype]]](relevantparameters);
    }

    return;
  }

  assertmsg("<dev string:x31e>");
}

function function_8288c27883885909(spatialzonecontainer, spatialzonename) {
  if(function_71d38726159c3f12(12)) {
    function_f541e4e4edaa8e99(12, [spatialzonecontainer, spatialzonename]);
    return;
  }

  if(spatialzonename == "Hibernation_Zone") {
    var_df7744c202bfe48d = getdvarint(@ "hash_6e5431373c266ed7", 10000);
    function_51ad14107ca158fb(spatialzonecontainer, "Hibernation_Zone", undefined, var_df7744c202bfe48d);

    if(isactivityinstance(spatialzonecontainer)) {
      activityinstance = spatialzonecontainer;
      function_79e69463947d9e86(activityinstance, spatialzonename, &function_8988a4c89289d7f4, [activityinstance]);
    }

    return;
  }

  assertex("<dev string:x369>" + spatialzonename + "<dev string:x39e>");
}

function private function_7549ff50f90523c9() {
  var_8f1b31034e6330fe = spawnStruct();
  var_8f1b31034e6330fe.types = [];
  var_8f1b31034e6330fe.definitions = [];
  var_8f1b31034e6330fe.instances = [];
  var_8f1b31034e6330fe.nexusoverrides = [];
  var_8f1b31034e6330fe.defaultfunctions = [];
  var_8f1b31034e6330fe.awakeinstances = [];
  var_8f1b31034e6330fe.var_dde04de762f05a54 = [];
  var_8f1b31034e6330fe.var_44b0386160008fd1 = 0;
  var_8f1b31034e6330fe.var_da5e5d845600111b = [];
  var_8f1b31034e6330fe.var_95a5b3673c07cc00 = function_8afa6d518fce0c31();
  var_8f1b31034e6330fe.var_387cbfd0e4364cec = function_63555ee8e5fb64fc(13);
  var_8f1b31034e6330fe.var_5357362cdc826253 = [];
  var_8f1b31034e6330fe.var_fc24547823253662 = [];
  var_8f1b31034e6330fe.var_fc24547823253662["Near"] = 1000;
  var_8f1b31034e6330fe.var_fc24547823253662["Mid"] = 2200;
  var_8f1b31034e6330fe.var_fc24547823253662["Far"] = 10000;
  var_8f1b31034e6330fe.defaultfunctions[0] = &function_ff180ac87df3d300;
  var_8f1b31034e6330fe.defaultfunctions[1] = &function_a0a0f0090c79260;
  var_8f1b31034e6330fe.defaultfunctions[2] = &function_7cbe9a82eb78ca2c;
  var_8f1b31034e6330fe.defaultfunctions[3] = &function_10752dbaaf34420f;
  var_8f1b31034e6330fe.defaultfunctions[4] = &function_dfea1c389f5d4f78;
  var_8f1b31034e6330fe.defaultfunctions[6] = &activity_rewards::getrewardgroups;
  var_8f1b31034e6330fe.defaultfunctions[8] = &function_2d4b61447e3a46b0;
  var_8f1b31034e6330fe.activitymoments = ["InstanceBegin", "InstanceEnd", "ActivityBegin", "ActivityEnd", "ActivitySuccess", "ActivityFailure", "PlayerJoin", "PlayerLeave", "PlayerAbandon", "PlayerRefocusedOnActivity", "PlayerEnteredAwarenessZone", "PlayerExitedAwarenessZone", "ActivityStartedHibernation", "ActivityStoppedHibernating", "RewardsSpawned"];
  var_8f1b31034e6330fe function_a1df1f29568a9e00();
  return var_8f1b31034e6330fe;
}

function private function_8afa6d518fce0c31() {
  var_95a5b3673c07cc00 = spawnStruct();
  var_95a5b3673c07cc00.var_98b653a321a7b68a = [];
  var_95a5b3673c07cc00.var_cc3816954252444b = [];
  var_95a5b3673c07cc00.var_f86621f26a29c23 = [];
  var_95a5b3673c07cc00.var_c75eef4add685c33 = [];
  return var_95a5b3673c07cc00;
}

function private function_32e7e3d48cd4aec3() {
  var_95a5b3673c07cc00 = function_8e6b7fc389a5a9b3();
  function_af55a41660207bbc(var_95a5b3673c07cc00);
  function_4ed58a73c2ce41ab(var_95a5b3673c07cc00);
}

function private function_af55a41660207bbc(var_95a5b3673c07cc00) {
  bundlenames = getscriptbundlenames("activityplayerbroadcast");

  foreach(var_6ea03325be11baa0 in bundlenames) {
    var_35ab718ef0636efb = getscriptbundle(var_6ea03325be11baa0);

    if(isDefined(var_35ab718ef0636efb)) {
      var_3bfa54c1785e4e4e = isDefined(var_35ab718ef0636efb.playerbroadcasts) && var_35ab718ef0636efb.playerbroadcasts.size > 0;
      var_88aaf009d452257d = isDefined(var_35ab718ef0636efb.sharingoptions) && var_35ab718ef0636efb.sharingoptions.size > 0;

      if(var_3bfa54c1785e4e4e && var_88aaf009d452257d) {
        broadcastsharingoptions = var_35ab718ef0636efb.sharingoptions[0].variant_object;

        if(istrue(broadcastsharingoptions.var_74af9703f56e96e)) {
          foreach(playerbroadcast in var_35ab718ef0636efb.playerbroadcasts) {
            var_95a5b3673c07cc00.var_98b653a321a7b68a[var_95a5b3673c07cc00.var_98b653a321a7b68a.size] = playerbroadcast;
          }

          continue;
        }

        if(istrue(broadcastsharingoptions.var_8fce79a777b2ac76) && isDefined(broadcastsharingoptions.activitycategory)) {
          var_3443ff296e009618 = broadcastsharingoptions.activitycategory;
          assertex(var_3443ff296e009618 != "<dev string:x3f3>", "<dev string:x3fb>");

          if(!isDefined(var_95a5b3673c07cc00.var_cc3816954252444b[var_3443ff296e009618])) {
            var_95a5b3673c07cc00.var_cc3816954252444b[var_3443ff296e009618] = [];
          }

          foreach(playerbroadcast in var_35ab718ef0636efb.playerbroadcasts) {
            var_fe4798ea52c4c5e9 = var_95a5b3673c07cc00.var_cc3816954252444b[var_3443ff296e009618].size;
            var_95a5b3673c07cc00.var_cc3816954252444b[var_3443ff296e009618][var_fe4798ea52c4c5e9] = playerbroadcast;
          }
        }
      }
    }
  }
}

function private function_4ed58a73c2ce41ab(var_95a5b3673c07cc00) {
  bundlenames = getscriptbundlenames("activityrewards");

  foreach(bundlename in bundlenames) {
    bundle = getscriptbundle(bundlename);
    function_15cb7fa5c8bd7af(var_95a5b3673c07cc00, bundle);
  }
}

function private function_15cb7fa5c8bd7af(var_95a5b3673c07cc00, var_2903e6c44924f6ec) {
  sharingtype = namespace_e81b1392df0afa31::function_58747b8d28c68355(var_2903e6c44924f6ec);

  if(!isDefined(sharingtype) || sharingtype == "DontShareWithActivities") {
    return;
  }

  var_a345cb4944cee5b2 = namespace_e81b1392df0afa31::function_956d43b7266a97d9(var_2903e6c44924f6ec);

  if(!isDefined(var_a345cb4944cee5b2) || var_a345cb4944cee5b2.size == 0) {
    return;
  }

  switch (sharingtype) {
    case #"hash_5e3671de7b9f5a2a":
      function_92dcb4f9cb079209(var_95a5b3673c07cc00, var_a345cb4944cee5b2);
      return;
    case #"hash_31d6baffebed40ac":
      categorytype = namespace_e81b1392df0afa31::function_1a30bd41682cb81f(var_2903e6c44924f6ec);
      function_984ca6c5fcea2278(var_95a5b3673c07cc00, categorytype, var_a345cb4944cee5b2);
      return;
    default:
      assertmsg("<dev string:x487>" + sharingtype);
      return;
  }
}

function private function_92dcb4f9cb079209(var_95a5b3673c07cc00, var_a345cb4944cee5b2) {
  foreach(var_e981cd0e1539bc38 in var_a345cb4944cee5b2) {
    var_95a5b3673c07cc00.var_f86621f26a29c23[var_95a5b3673c07cc00.var_f86621f26a29c23.size] = var_e981cd0e1539bc38;
  }
}

function private function_984ca6c5fcea2278(var_95a5b3673c07cc00, categorytype, var_a345cb4944cee5b2) {
  assert(isDefined(categorytype));
  assertex(categorytype != "<dev string:x3f3>", "<dev string:x4b7>");

  if(!isDefined(var_95a5b3673c07cc00.var_c75eef4add685c33[categorytype])) {
    var_95a5b3673c07cc00.var_c75eef4add685c33[categorytype] = [];
  }

  foreach(var_e981cd0e1539bc38 in var_a345cb4944cee5b2) {
    size = var_95a5b3673c07cc00.var_c75eef4add685c33[categorytype].size;
    var_95a5b3673c07cc00.var_c75eef4add685c33[categorytype][size] = var_e981cd0e1539bc38;
  }
}

function private function_dbdf04ed40266c5(nexusoverridetype, function) {
  if(!function_71d38726159c3f12(nexusoverridetype)) {
    function_edb2f945bfe8e85e(nexusoverridetype, function);
  }
}

function private function_9b97c3ae49015fc6(activityfunctiontype) {
  var_97fa13ca6fe97871 = [4, 5, 6, 7, 8];
  return array_contains(var_97fa13ca6fe97871, activityfunctiontype);
}

function private function_d9c449df6f5a5dd3(activityinstance, overridefunction, relevantinfostruct) {
  activityinstance endon("instance_destroyed");

  if(isDefined(overridefunction) && isfunction(overridefunction)) {
    if(isDefined(relevantinfostruct)) {
      activityinstance[[overridefunction]](relevantinfostruct);
    } else {
      activityinstance[[overridefunction]]();
    }

    return;
  }

  assertmsg("<dev string:x54f>");
}

function private function_38f500f64a70b3c8(activitymomentcallbackcontainer, activitymoment, relevantinfostruct) {
  var_72e1d54d0776d39e = isDefined(activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment]) && activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment].size > 0;

  if(var_72e1d54d0776d39e) {
    foreach(callback in activitymomentcallbackcontainer.activitymomentcallbacks[activitymoment]) {
      self thread[[callback]](relevantinfostruct);
    }
  }
}

function private function_a1df1f29568a9e00() {
  self.activitymomentcallbacks = [];
}

function private function_7b88d59f853b6833(relevantinfostruct) {
  activityinstance = self;
  instid = getinstanceid(activityinstance);

  if(relevantinfostruct.activitymoment == "ActivityStartedHibernation") {
    level.activities.awakeinstances[instid] = undefined;
    return;
  }

  if(relevantinfostruct.activitymoment == "ActivityStoppedHibernating") {
    level.activities.awakeinstances[instid] = activityinstance;
  }
}

function private function_52a69420197eee1e(relevantinfostruct) {
  activityinstance = self;
  instid = getinstanceid(activityinstance);

  if(activityinstance.playerparticipants.size == 0) {
    level.activities.var_dde04de762f05a54[instid] = activityinstance;
    return;
  }

  level.activities.var_dde04de762f05a54[instid] = undefined;
}