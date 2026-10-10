/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ab210ea917601e7.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_2707474774db34b;
#using script_3ac7886f9e4eceef;
#using script_41387eecc35b88bf;
#using script_54f6d121e91434f8;
#using script_570f992e202c79b4;
#using script_6617e2f2bb62b52b;
#using script_7956d56c4922bd1;
#using scripts\common\data_tracker;
#using scripts\common\devgui;
#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace namespace_a93e7904fe28c5c4;

function function_9c328f2f2bc853e6(var_d3f89f07fe3fa0ab) {
  var_d3f89f07fe3fa0ab.var_57c2b110e4deb587 = function_63555ee8e5fb64fc(8);
  var_d3f89f07fe3fa0ab.var_9060ae63d8f02700 = [];
  var_d3f89f07fe3fa0ab.var_9060ae63d8f02700["TitleSplash"] = "Delay";
}

function function_caf8f45b7e3b78a2(activityinstance) {
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);

  if(!isDefined(var_ee373e1060f9863f.var_bf8dc9b4e4603f8d)) {
    var_ee373e1060f9863f.var_bf8dc9b4e4603f8d = [];
  }

  var_f565df3793c12460 = function_42a790b5e4c0dd36(activityinstance);
  var_ec5849fb65eb261a = function_c795f9c21a9bc8();
  var_ec5849fb65eb261a = array_add(var_ec5849fb65eb261a, "ActivationName");

  foreach(activitymoment in var_ec5849fb65eb261a) {
    var_8325119ddf1616e0 = var_f565df3793c12460.var_38b0dd2cea06c40b[activitymoment];

    if(isDefined(var_8325119ddf1616e0) && var_8325119ddf1616e0.size > 0) {
      var_ee373e1060f9863f.var_bf8dc9b4e4603f8d[activitymoment] = 1;
    }
  }
}

function function_85f01c1d56e32f7c(activityinstance, var_a84449a9bd492279) {
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);

  if(!isDefined(var_ee373e1060f9863f.var_bf8dc9b4e4603f8d)) {
    return undefined;
  }

  return istrue(var_ee373e1060f9863f.var_bf8dc9b4e4603f8d[var_a84449a9bd492279]);
}

function function_6fe8aa8dfb9111eb(activityinstance, dataobject) {
  uniquename = function_71667164a3e75714(dataobject);

  foreach(var_cecb6f8a13d4084d in activityinstance.var_40b691c0a6852f73) {
    if(function_d20c7983c54fc98a(var_cecb6f8a13d4084d, uniquename)) {
      updatebroadcast(var_cecb6f8a13d4084d);
    }
  }
}

function function_947973be56e0dbb2(playerlist) {
  activitynexuslog("Persistent and Tracker broadcasts reactivated for players.", @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  foreach(broadcast in self.var_40b691c0a6852f73) {
    if(function_75002b8400884f8(broadcast)) {
      function_4cd1243025855075(playerlist, broadcast);
    }
  }
}

function function_2e44f2eaf470e806(broadcastinstance) {
  function_4cd1243025855075(self.var_6c29f2fdb0054bbe, broadcastinstance);
}

function function_3f3bc21a4bec7c33(broadcastinstance) {
  assertmsg("<dev string:x1c>");
}

function broadcast(broadcastinstance, playerlist) {
  activitynexuslog("Broadcast Activated for Activity: " + function_872fb49b377327fe(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  switch (broadcastinstance function_c9dd0ad4f024db96()) {
    case #"hash_f29608411835dbd2":
      function_2e44f2eaf470e806(broadcastinstance);
      break;
    case #"hash_fad3c75d039713f1":
      function_790e679b0f2d121e(playerlist[0], broadcastinstance);
      break;
    case #"hash_f81f6f6ee4ce49a2":
      centerpoint = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);
      var_ab5375b03260c7 = function_45575393a3d8e399(broadcastinstance);
      function_4cd1243025855075(var_ab5375b03260c7, broadcastinstance);
      break;
    case #"hash_81b1b8581bbc387":
      function_3f3bc21a4bec7c33(broadcastinstance);
      break;
    case #"hash_edac25dbcb316612":
      function_9bce3b7a2f2ae1e(broadcastinstance);
      break;
    case #"hash_129fc9ef498f13cc":
    default:
      function_4cd1243025855075(playerlist, broadcastinstance);
      break;
  }

  if(function_32cce566a03b93e9(broadcastinstance)) {
    function_bec053dce018ba34(broadcastinstance);
  }
}

function function_484f9658b565df53(var_a84449a9bd492279, playerlist) {
  activitynexuslog("Activated all broadcasts with Activation Moment: " + var_a84449a9bd492279, @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  if(var_a84449a9bd492279 == "ActivationName") {
    assertmsg("<dev string:x64>");
    return;
  }

  var_4fb0bb8290e39fb3 = function_b4f81cd2bdc5602e(var_a84449a9bd492279);

  foreach(broadcastinstance in var_4fb0bb8290e39fb3) {
    if(!isDefined(playerlist)) {
      playerlist = self.var_6c29f2fdb0054bbe;
    }

    broadcast(broadcastinstance, playerlist);
  }
}

function function_9d4772170bc34a3c(uniquename, playerlist) {
  activitynexuslog("Activated all broadcasts with Unique Name: " + uniquename, @ "hash_3b38e79d9ffe7e9f", self, playerlist);
  activityinstance = self;
  var_4fb0bb8290e39fb3 = [];
  var_c1bf8d848d376cf2 = function_709eb291cbeeb02(activityinstance, uniquename);

  if(isDefined(var_c1bf8d848d376cf2)) {
    var_4fb0bb8290e39fb3 = [var_c1bf8d848d376cf2];
  }

  function_58c9b87625671005(var_4fb0bb8290e39fb3, uniquename, undefined, 0);
}

function function_bcdc9fefc04fa6a(uniquename, playerlist) {
  activitynexuslog("Hide all broadcasts with Unique Name: " + uniquename, @ "hash_3b38e79d9ffe7e9f", self, playerlist);
  activityinstance = self;
  var_4fb0bb8290e39fb3 = [];
  var_c1bf8d848d376cf2 = function_709eb291cbeeb02(activityinstance, uniquename);

  if(isDefined(var_c1bf8d848d376cf2)) {
    var_4fb0bb8290e39fb3 = [var_c1bf8d848d376cf2];
  }

  function_58c9b87625671005(var_4fb0bb8290e39fb3, uniquename, undefined, 1);
}

function function_cdd79617f81a46d2(uniquename) {
  activitynexuslog("Removed all broadcasts with Unique Name: " + uniquename + uniquename, @ "hash_3b38e79d9ffe7e9f", self);
  activityinstance = self;
  var_4fb0bb8290e39fb3 = [];
  var_c1bf8d848d376cf2 = function_709eb291cbeeb02(activityinstance, uniquename);

  if(isDefined(var_c1bf8d848d376cf2)) {
    var_4fb0bb8290e39fb3 = [var_c1bf8d848d376cf2];
  }

  function_58c9b87625671005(var_4fb0bb8290e39fb3, uniquename, undefined, 2);
}

function function_1281c7fff9456e18(activationname, playerlist) {
  activitynexuslog("Activated all broadcasts with Activation Name: " + activationname, @ "hash_3b38e79d9ffe7e9f", self, playerlist);
  var_4fb0bb8290e39fb3 = function_e38f1d6d5a208fe1(activationname);
  function_58c9b87625671005(var_4fb0bb8290e39fb3, activationname, playerlist, 0);
}

function function_f2a618a7ad2f558d(activationname, playerlist) {
  activitynexuslog("Hide all broadcasts with Activation Name: " + activationname, @ "hash_3b38e79d9ffe7e9f", self, playerlist);
  var_4fb0bb8290e39fb3 = function_e38f1d6d5a208fe1(activationname);
  function_58c9b87625671005(var_4fb0bb8290e39fb3, activationname, playerlist, 1);
}

function function_8350a7df2508a779(activitymoment) {
  activitynexuslog("Deactivated Active broadcasts with Deactivation Moment: " + activitymoment, @ "hash_3b38e79d9ffe7e9f", self);

  if(activitymoment == "ActivationName") {
    assertmsg("<dev string:x64>");
    return;
  }

  foreach(broadcastinstance in self.var_40b691c0a6852f73) {
    var_7c0025e4cf44b11a = broadcastinstance function_6a312795248d0f1c();

    if(isDefined(var_7c0025e4cf44b11a) && var_7c0025e4cf44b11a == activitymoment) {
      function_13fbc3d3854d009a(broadcastinstance);
      function_91f301cdf6b88253(broadcastinstance);
    }
  }
}

function function_ca585715158d49fa(deactivationname) {
  activitynexuslog("Deactivated Active Broadcasts with Deactivation name: " + deactivationname, @ "hash_3b38e79d9ffe7e9f", self);

  foreach(broadcastinstance in self.var_40b691c0a6852f73) {
    var_7c0025e4cf44b11a = broadcastinstance function_6a312795248d0f1c();
    name = broadcastinstance function_a3b4a80d61094f63();
    var_32b29279371d24a2 = isDefined(var_7c0025e4cf44b11a) && var_7c0025e4cf44b11a == "ActivationName";
    var_3c7b34c332071a5e = isDefined(name) && name == deactivationname;

    if(var_32b29279371d24a2 && var_3c7b34c332071a5e) {
      function_13fbc3d3854d009a(broadcastinstance);
      function_91f301cdf6b88253(broadcastinstance);
    }
  }
}

function function_94050b71cb4ef1ca(playerlist) {
  activitynexuslog("Hide all active persistent and tracker broadcasts.", @ "hash_3b38e79d9ffe7e9f", self, playerlist);

  foreach(var_c1bf8d848d376cf2 in self.var_40b691c0a6852f73) {
    function_dacc8aa0d16e4487(playerlist, var_c1bf8d848d376cf2);
  }
}

function function_a558693f33df78c7(broadcastuniqueid) {
  activebroadcast = undefined;

  if(isDefined(self.var_40b691c0a6852f73[broadcastuniqueid])) {
    activebroadcast = self.var_40b691c0a6852f73[broadcastuniqueid];
  }

  return activebroadcast;
}

function function_d7c3ce8df52d35c9(broadcasttype) {
  var_d3f89f07fe3fa0ab = function_efe441752cd7303d();

  if(isDefined(var_d3f89f07fe3fa0ab.var_9060ae63d8f02700[broadcasttype])) {
    return var_d3f89f07fe3fa0ab.var_9060ae63d8f02700[broadcasttype];
  }

  return "None";
}

function function_195ff27978a91a68(activityinstance, var_b917dfe737d8414f, var_afb5c037a8f13bd5, var_57bae934aff55b69) {
  var_427e912941ad805f = spawnStruct();
  var_427e912941ad805f function_a1f71337a6844055();
  function_fd7a0d7af53408c9(var_427e912941ad805f, activityinstance, var_b917dfe737d8414f, var_afb5c037a8f13bd5, var_57bae934aff55b69);
  return var_427e912941ad805f;
}

function function_fd7a0d7af53408c9(var_d9915f8020fff325, activityinstance, var_b917dfe737d8414f, var_afb5c037a8f13bd5, var_57bae934aff55b69, var_6457b48cd688f2ed) {
  var_b917dfe737d8414f = default_to(var_b917dfe737d8414f, 1);
  var_afb5c037a8f13bd5 = default_to(var_afb5c037a8f13bd5, 0);
  var_57bae934aff55b69 = default_to(var_57bae934aff55b69, 1);
  var_6457b48cd688f2ed = default_to(var_6457b48cd688f2ed, 1);
  addcondition(var_d9915f8020fff325, &function_388f018d407adc40, []);

  if(istrue(var_afb5c037a8f13bd5)) {
    addcondition(var_d9915f8020fff325, &function_d4959a754e2acb72, [activityinstance]);
  }

  if(istrue(var_b917dfe737d8414f)) {
    addcondition(var_d9915f8020fff325, &function_d49dc10646971d24, [activityinstance]);
  }

  if(istrue(var_57bae934aff55b69)) {
    addcondition(var_d9915f8020fff325, &function_3b6f0ac301030549, []);
  }

  if(istrue(var_b917dfe737d8414f)) {
    addcondition(var_d9915f8020fff325, &function_bc33f8483c604d9b, [var_d9915f8020fff325, activityinstance]);
  }

  if(function_71d38726159c3f12(13)) {
    function_f541e4e4edaa8e99(13, [var_d9915f8020fff325, activityinstance], 0);
  }
}

function private function_58c9b87625671005(var_4fb0bb8290e39fb3, activationname, playerlist, var_35498449056da93d) {
  if(!isDefined(playerlist)) {
    playerlist = self.var_6c29f2fdb0054bbe;
  }

  foreach(var_c1bf8d848d376cf2 in var_4fb0bb8290e39fb3) {
    if(var_35498449056da93d == 0) {
      broadcast(var_c1bf8d848d376cf2, playerlist);
      continue;
    }

    if(var_35498449056da93d == 1) {
      function_dacc8aa0d16e4487(playerlist, var_c1bf8d848d376cf2);
      continue;
    }

    if(var_35498449056da93d == 2) {
      function_dacc8aa0d16e4487(playerlist, var_c1bf8d848d376cf2);
      function_91f301cdf6b88253(var_c1bf8d848d376cf2);
    }
  }
}

function private function_bec053dce018ba34(broadcastinstance) {
  activitynexuslog("Persistent broadcast is active and stored in activity instance data." + function_872fb49b377327fe(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self);
  uniqueid = broadcastinstance function_cf54c2c8650d9688();
  self.var_40b691c0a6852f73[uniqueid] = broadcastinstance;
}

function private function_91f301cdf6b88253(broadcastinstance) {
  activitynexuslog("Persistent broadcast is inactive and removed from activity instance data." + function_872fb49b377327fe(broadcastinstance), @ "hash_3b38e79d9ffe7e9f", self);
  uniqueid = broadcastinstance function_cf54c2c8650d9688();
  self.var_40b691c0a6852f73[uniqueid] = undefined;
}

function private function_1bb667dce8ec20d2(activationname) {
  var_c9f561285d1c4859 = [];

  foreach(var_cecb6f8a13d4084d in self.var_40b691c0a6852f73) {
    var_f3c55aafff2be133 = var_cecb6f8a13d4084d function_27486f42d37da990();

    if(isDefined(var_f3c55aafff2be133) && var_f3c55aafff2be133 == activationname) {
      var_c9f561285d1c4859[var_c9f561285d1c4859.size] = var_cecb6f8a13d4084d;
    }
  }

  return var_c9f561285d1c4859;
}

function private function_872fb49b377327fe(broadcastinstance) {
  var_b110b538c0af62cd = " broadcast: type: " + broadcastinstance function_54ad2295d6995862() + " unique id: " + broadcastinstance function_cf54c2c8650d9688() + " destination: " + broadcastinstance function_c9dd0ad4f024db96();
  return var_b110b538c0af62cd;
}

function function_ff72cf17a0a5fac() {
  function_6e7290c8ee4f558b("<dev string:xdd>");
  function_b23a59dfb4ca49a1("<dev string:x10e>", "<dev string:x143>" + "<dev string:x155>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x16b>", "<dev string:x143>" + "<dev string:x19e>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x1ad>", "<dev string:x143>" + "<dev string:x1e2>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x1f3>", "<dev string:x143>" + "<dev string:x226>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x235>", "<dev string:x143>" + "<dev string:x26c>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x27f>", "<dev string:x143>" + "<dev string:x2b6>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x2c9>", "<dev string:x143>" + "<dev string:x2fb>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x309>", "<dev string:x143>" + "<dev string:x33c>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_b23a59dfb4ca49a1("<dev string:x34b>", "<dev string:x143>" + "<dev string:x38e>" + "<dev string:x166>", &function_7ee522f2b2a96bbc);
  function_fe953f000498048f();
}

function private function_7ee522f2b2a96bbc(params) {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer) && isPlayer(hostplayer) && isDefined(hostplayer.activities.var_6346961d07f668fe)) {
    id = hostplayer.activities.var_6346961d07f668fe;
    instance = function_1f3e343912ae15c5(id);
    moment = params[0];

    if(moment == "<dev string:x2fb>" || moment == "<dev string:x33c>" || moment == "<dev string:x38e>") {
      instance function_484f9658b565df53(moment, [hostplayer]);
      return;
    }

    instance function_484f9658b565df53(moment, instance.var_6c29f2fdb0054bbe);
  }
}

# /