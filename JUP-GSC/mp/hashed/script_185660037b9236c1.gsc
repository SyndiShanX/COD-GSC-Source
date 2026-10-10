/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_185660037b9236c1.gsc
*************************************************/

#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_2707474774db34b;
#using script_3ab210ea917601e7;
#using script_3ac7886f9e4eceef;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_4d39bd4c621e7680;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_5815a7cb4d944542;
#using script_5d8202968463a21d;
#using script_6617e2f2bb62b52b;
#using script_6cf3c7c08335321b;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using scripts\common\data_tracker;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace namespace_4fda5d7358015a06;

function function_c71c80e21eeb98b0() {
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_9a40bf3502fe45f);
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_d3d9ead84b5ad147);
  function_8b5b2a3392fc7e2a("PlayerAbandon", &function_236c3a4a9216f248);
  function_8b5b2a3392fc7e2a("InstanceBegin", &function_7a00a458019b00d3);
  function_8b5b2a3392fc7e2a("ActivityBegin", &function_7a00a458019b00d3);
  function_8b5b2a3392fc7e2a("InstanceEnd", &function_7a00a458019b00d3);
  function_8b5b2a3392fc7e2a("ActivityEnd", &function_7a00a458019b00d3);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_d58bbda1de18e318);
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_d58bbda1de18e318);
}

function function_67f4d8928c638abb(activitytype, varianttag, originpoint, var_9334fa52c33d9f6e) {
  if(!function_34d878874ef424(varianttag)) {
    function_98e66628b697874f([varianttag]);

    if(!function_34d878874ef424(varianttag)) {
      assertmsg("<dev string:x1c>" + varianttag);
      return;
    }
  }

  activitydefinition = level.activities.definitions[varianttag];
  activitycategory = function_5caf0b462f4d7243(activitydefinition);
  var_c4f9b0bf67170f6f = function_6cf69755ac283f1e(varianttag, activitytype, activitycategory, var_9334fa52c33d9f6e);
  function_6d0db4a1a5cc2157(var_c4f9b0bf67170f6f);
  function_f541e4e4edaa8e99(1, [var_c4f9b0bf67170f6f, originpoint], 0);
  return var_c4f9b0bf67170f6f;
}

function function_b6fc2c96b463c007(activityinstance) {
  thread function_f020477c47b9be94(activityinstance, "ActiveState");
}

function function_4bc22996edea81f1(activityinstance) {
  function_f509fac14c3cdb1d(activityinstance, "CleanupState");
}

function function_556db65cfad56c7c(activityinstance) {
  function_f509fac14c3cdb1d(activityinstance, "ActiveState");
}

function setupinstance(relevantparameters) {
  activityinstance = relevantparameters[0];
  var_838185e7a405fe33 = relevantparameters[1];
  activityinstance endon("activity_ended");
  activityinstance endon("instance_destroyed");
  function_1e3f083d84bd04e(activityinstance, var_838185e7a405fe33);
  waitframe();
  function_104adc18c0d699c3(activityinstance, 0);
  waitframe();
  function_84f0d4362b882db3(activityinstance);
}

function endactivity(activityinstance, activitysuccess) {
  var_ef64095e6090cac4 = function_73bd348a2ec322cf(activityinstance);

  if(var_ef64095e6090cac4 != "ActiveState") {
    assertmsg("<dev string:x64>" + var_ef64095e6090cac4);
    return;
  }

  if(activitysuccess) {
    function_e56283e3cbfa05ad(activityinstance);
  } else {
    function_27251a5a24d92d28(activityinstance);
  }

  level thread function_c4ea67b937f27c4a(activityinstance);
}

function function_ce906635a152d2d0(activityinstance, var_8436ec5bdd7c457d, var_6f8af5eb76deac21) {
  if(!isDefined(var_6f8af5eb76deac21)) {
    var_6f8af5eb76deac21 = spawnStruct();
  }

  if(!isDefined(var_6f8af5eb76deac21.playerlist)) {
    var_6f8af5eb76deac21.playerlist = activityinstance.var_6c29f2fdb0054bbe;
  }

  var_6f8af5eb76deac21.var_8436ec5bdd7c457d = var_8436ec5bdd7c457d;
  activityinstance function_1281c7fff9456e18(var_8436ec5bdd7c457d, var_6f8af5eb76deac21.playerlist);
  activityinstance function_ca585715158d49fa(var_8436ec5bdd7c457d);
  function_49f447d3531edf7e(activityinstance, "ActivationName", var_8436ec5bdd7c457d, var_6f8af5eb76deac21.var_e0a0dc78cd0e70f3, var_6f8af5eb76deac21.var_44fadde66021a763);
  activitynexuslog("Custom Activity Moment: " + var_8436ec5bdd7c457d, @ "hash_22e4e38cab273e93", activityinstance, var_6f8af5eb76deac21.playerlist);
}

function function_735ee8e9d0f1b00b(activityinstance, activitymoment, var_6f8af5eb76deac21) {
  if(!isDefined(var_6f8af5eb76deac21)) {
    var_6f8af5eb76deac21 = spawnStruct();
  }

  if(!isDefined(var_6f8af5eb76deac21.playerlist)) {
    var_6f8af5eb76deac21.playerlist = activityinstance.var_6c29f2fdb0054bbe;
  }

  var_6f8af5eb76deac21.activitymoment = activitymoment;
  activityinstance function_484f9658b565df53(activitymoment, var_6f8af5eb76deac21.playerlist);
  activityinstance function_8350a7df2508a779(activitymoment);
  function_47a5129abc55bd53(activityinstance, activitymoment);
  namespace_779ebc650a9ef856::function_dfe0a21d9848315e(activityinstance, activitymoment);
  function_49f447d3531edf7e(activityinstance, activitymoment, undefined, var_6f8af5eb76deac21.var_e0a0dc78cd0e70f3, var_6f8af5eb76deac21.var_44fadde66021a763);
  activityinstance function_42ab09fd1c5bf443(activitymoment, var_6f8af5eb76deac21);
  activityinstance notify(activitymoment);
  activitynexuslog("Activity Moment: " + activitymoment, @ "hash_22e4e38cab273e93", activityinstance, var_6f8af5eb76deac21.playerlist);
}

function function_f0f498aed6f8fa5d(activityinstance) {
  return activityinstance.id;
}

function function_73bd348a2ec322cf(activityinstance) {
  return activityinstance.state;
}

function function_42a842295fe70a62(activityinstance) {
  return activityinstance.var_6c29f2fdb0054bbe.size;
}

function function_a4748b32a824c79c(activityinstance) {
  return activityinstance.varianttag;
}

function function_de53ed8e35d0ed7a(activityinstance) {
  return activityinstance.type;
}

function function_511be8bcaede8b52(activityinstance) {
  return activityinstance.category;
}

function function_dd58016ab8a9a3e0(activityinstance) {
  return activityinstance.var_34d9cc6234f0bf2e;
}

function function_40d5384184be8e3c(activityinstance) {
  return activityinstance.var_17a2361aa0beabb2;
}

function function_e931f3b80616c348(activityinstance) {
  return activityinstance.participationconditions;
}

function function_2dabe17056c2563f(activityinstance) {
  return activityinstance.var_c083bd8353c655c1;
}

function function_bdd22095c4312f34(activityinstance) {
  var_ef64095e6090cac4 = function_73bd348a2ec322cf(activityinstance);
  var_3c43be955417f9f8 = var_ef64095e6090cac4 == "EndedState" || var_ef64095e6090cac4 == "CleanupState";
  return var_3c43be955417f9f8 && istrue(activityinstance.var_8b79601f5cca1fa9);
}

function function_6daf2e19ef224d27(activityinstance, transitionstate) {
  if(!isDefined(activityinstance.var_9a577a7ebc413d46[transitionstate]) || activityinstance.var_9a577a7ebc413d46[transitionstate] == 0) {
    return true;
  }

  return false;
}

function isactivityinstance(var_3737fa2f2fc68a50) {
  return isstruct(var_3737fa2f2fc68a50) && istrue(var_3737fa2f2fc68a50.isactivityinstance);
}

function function_b1e0c431ac8df0ed(activityinstance) {
  return activityinstance.var_14a8920a25d8a7a1;
}

function function_297dc42ebf4f3b04(activityinstance, omnvar) {
  if(!activityinstance function_6a26856f16c6a207(omnvar)) {
    assertmsg("<dev string:xbf>" + omnvar + "<dev string:xcf>");
    return undefined;
  }

  var_f6c1c21bd8e20e52 = activityinstance function_e989e3f023f50368(omnvar);
  return var_f6c1c21bd8e20e52[0];
}

function function_402e97e252bb33ff(activityinstance, omnvar) {
  if(!activityinstance function_6a26856f16c6a207(omnvar)) {
    assertmsg("<dev string:xbf>" + omnvar + "<dev string:x114>");
    return undefined;
  }

  var_f6c1c21bd8e20e52 = activityinstance function_e989e3f023f50368(omnvar);
  return var_f6c1c21bd8e20e52[1];
}

function function_73354d36b8ec6cb8(activityinstance) {
  activitytype = function_de53ed8e35d0ed7a(activityinstance);
  var_37bed97b2b3d92ab = function_811a0fab09c793ce(activitytype, 4);
  var_d041598dbdb3fddd = &function_dfea1c389f5d4f78;

  if(isDefined(var_37bed97b2b3d92ab) && var_37bed97b2b3d92ab != var_d041598dbdb3fddd) {
    return true;
  }

  return false;
}

function function_8988a4c89289d7f4(activityinstance) {
  assertex(isactivityinstance(activityinstance), "<dev string:x15f>");
  centerpoint = undefined;
  activitytype = function_de53ed8e35d0ed7a(activityinstance);

  if(function_538af8a5b8170d0c(activitytype, 4)) {
    centerpoint = function_104adc18c0d699c3(activityinstance, 4);
  }

  if(!isDefined(centerpoint) && isDefined(activityinstance.var_35ee2a06aa1f8973)) {
    centerpoint = activityinstance.var_35ee2a06aa1f8973;
  }

  if(!isDefined(centerpoint)) {
    centerpoint = activityinstance function_dfea1c389f5d4f78();
  }

  assertex(isDefined(centerpoint), "<dev string:x1b6>");
  activityinstance.var_35ee2a06aa1f8973 = centerpoint;
  return centerpoint;
}

function function_be6214edfe52a31(activityinstance) {
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);
  return var_ee373e1060f9863f.var_404ec7a436f43edf;
}

function function_4481ee309bf2c75c(activityinstance) {
  return activityinstance.additionalspawndata;
}

function function_cdea2ef0bf179c63(activityinstance) {
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);
  return istrue(var_ee373e1060f9863f.var_821230cb7573c0ae);
}

function function_c88d7a6286056b09(activityinstance) {
  return istrue(activityinstance.var_a9eaa93599f7c5c6);
}

function function_5e6325794597e387(activityinstance) {
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);
  return istrue(var_ee373e1060f9863f.var_9cc81390bae90155);
}

function function_d079465d310f745b(activityinstance, var_d1593f8a858fd13d) {
  activityinstance.var_c083bd8353c655c1 = function_6d6af8144a5131f1(activityinstance.var_c083bd8353c655c1, var_d1593f8a858fd13d);
  activitynexuslog("List of Players Who Deserve Rewards Updated.", @ "hash_22e4e38cab273e93", activityinstance, activityinstance.var_c083bd8353c655c1);
}

function function_dca86aca511288f4(activityinstance, transitionstate, reasonstring) {
  if(!isDefined(activityinstance.var_9a577a7ebc413d46[transitionstate])) {
    activityinstance.var_9a577a7ebc413d46[transitionstate] = 0;
  }

  activityinstance.var_9a577a7ebc413d46[transitionstate] += 1;
  var_fab326681eaecf8f = @ "hash_22e4e38cab273e93";

  if(function_2a1e9879f71ab677(var_fab326681eaecf8f)) {
    blockercount = activityinstance.var_9a577a7ebc413d46[transitionstate];
    logprefix = "State Transition Blocker Added. There are now: " + blockercount + " blockers for this state: " + transitionstate + ".";
    logsuffix = (isDefined(reasonstring) && isstring(reasonstring) ? " Reason for additional blocker: " + reasonstring : "") + ".";
    activitynexuslog(logprefix + logsuffix, var_fab326681eaecf8f, activityinstance);
  }
}

function function_20e36ec9e5802d01(activityinstance, transitionstate, reasonstring) {
  if(isDefined(activityinstance.var_9a577a7ebc413d46[transitionstate])) {
    activityinstance.var_9a577a7ebc413d46[transitionstate] = max(activityinstance.var_9a577a7ebc413d46[transitionstate] - 1, 0);
    activityinstance notify("activity_state_transition_blocker_removed");
  }

  var_fab326681eaecf8f = @ "hash_22e4e38cab273e93";

  if(function_2a1e9879f71ab677(var_fab326681eaecf8f)) {
    blockercount = activityinstance.var_9a577a7ebc413d46[transitionstate];
    logprefix = "State Transition Blocker Removed. There are now: " + blockercount + " blockers for this state: " + transitionstate + ".";
    logsuffix = (isDefined(reasonstring) && isstring(reasonstring) ? " Reason for blocker removal: " + reasonstring : "") + ".";
    activitynexuslog(logprefix + logsuffix, var_fab326681eaecf8f, activityinstance);
  }
}

function function_62b3e2a4e6e15396(activityinstance, var_915dd3ba12be1864, var_4d81c61149496fc4) {
  var_31bde88d6f43cbbf = array_find(activityinstance.var_17a2361aa0beabb2, var_915dd3ba12be1864);
  var_894f71c9809e1a81 = !isDefined(var_31bde88d6f43cbbf);

  if(var_894f71c9809e1a81) {
    activityinstance.var_17a2361aa0beabb2[activityinstance.var_17a2361aa0beabb2.size] = var_915dd3ba12be1864;

    if(istrue(var_4d81c61149496fc4)) {
      namespace_779ebc650a9ef856::function_5b71b730bfefd36a(activityinstance, var_915dd3ba12be1864, "ActivityEnd");
    }
  }
}

function function_26857d3de8354d4e(activityinstance, omnvar, value, resetvalue) {
  var_3bc5bab0e50c10e3 = activityinstance function_6a26856f16c6a207(omnvar);

  if(var_3bc5bab0e50c10e3) {
    activityinstance updatedata(omnvar, [value, resetvalue]);
    return;
  }

  activityinstance adddata(omnvar, "Array", [value, resetvalue]);
  activityinstance.var_14a8920a25d8a7a1[activityinstance.var_14a8920a25d8a7a1.size] = omnvar;
}

function function_e81ff3302ce5788b(activityinstance, var_a9eaa93599f7c5c6) {
  if(function_5e6325794597e387(activityinstance)) {
    var_950f481eaeeab025 = activityinstance.var_a9eaa93599f7c5c6;
    activityinstance.var_a9eaa93599f7c5c6 = var_a9eaa93599f7c5c6;

    if(istrue(var_a9eaa93599f7c5c6) && !var_950f481eaeeab025) {
      function_735ee8e9d0f1b00b(activityinstance, "ActivityStartedHibernation");
      return;
    }

    if(var_950f481eaeeab025) {
      function_735ee8e9d0f1b00b(activityinstance, "ActivityStoppedHibernating");
    }
  }
}

function function_ff180ac87df3d300() {
  activitynexuslog("No Setup Override Function found for activity. Running the default implementation instead", @ "hash_22e4e38cab273e93", self, undefined, 2);
  function_b6fc2c96b463c007(self);
}

function function_a0a0f0090c79260() {
  activitynexuslog("No Begin Override Function found for activity. Running the default implementation instead", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_7cbe9a82eb78ca2c() {
  activitynexuslog("No End Override Function found for activity. Running the default implementation instead", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_10752dbaaf34420f() {
  activitynexuslog("No Destroy Override Function found for activity. Running the default implementation instead", @ "hash_22e4e38cab273e93", self, undefined, 2);
}

function function_dfea1c389f5d4f78() {
  activityinstance = self;

  if(function_1888d1b2aeeda25(activityinstance, "Center_Spatial_Zone")) {
    var_845887ec9fc736c6 = function_5bbdc39a533d9d57(activityinstance, "Center_Spatial_Zone");
    assertex(var_845887ec9fc736c6.size == 1, "<dev string:x25f>");
    var_3cfa85dd68696451 = var_845887ec9fc736c6[0];
    return function_37c1f31d2434f628(var_3cfa85dd68696451);
  }

  activitynexuslog("No Valid Override for activity Get Center function. Returning (0,0,0) instead.", @ "hash_22e4e38cab273e93", activityinstance, undefined, 3);
  return (0, 0, 0);
}

function function_ccb42947700f2741() {
  additionalspawndata = spawnStruct();
  additionalspawndata.var_8695e1278af3995e = 1;
  return additionalspawndata;
}

function function_33a37cdc6d192d24(var_9f362f8b6fe8fe53) {
  return isstruct(var_9f362f8b6fe8fe53) && istrue(var_9f362f8b6fe8fe53.var_8695e1278af3995e);
}

function private function_6cf69755ac283f1e(varianttag, activitytype, category, var_9334fa52c33d9f6e) {
  if(isDefined(var_9334fa52c33d9f6e)) {
    assertex(function_33a37cdc6d192d24(var_9334fa52c33d9f6e), "<dev string:x2b2>");
  } else {
    var_9334fa52c33d9f6e = function_ccb42947700f2741();
  }

  var_c4f9b0bf67170f6f = spawnStruct();
  var_c4f9b0bf67170f6f.varianttag = varianttag;
  var_c4f9b0bf67170f6f.id = function_43f81a2fd15f456();
  var_c4f9b0bf67170f6f.type = activitytype;
  var_c4f9b0bf67170f6f.category = default_to(category, "None");
  var_c4f9b0bf67170f6f.additionalspawndata = var_9334fa52c33d9f6e;
  var_c4f9b0bf67170f6f.var_8b79601f5cca1fa9 = 0;
  var_c4f9b0bf67170f6f.score = 0;
  var_c4f9b0bf67170f6f.var_35ee2a06aa1f8973 = undefined;
  var_c4f9b0bf67170f6f.var_d953047f1b4c7c9 = undefined;
  var_c4f9b0bf67170f6f.state = "IdleState";
  var_c4f9b0bf67170f6f.isactivityinstance = 1;
  var_c4f9b0bf67170f6f.var_a9eaa93599f7c5c6 = 0;
  var_c4f9b0bf67170f6f.var_34d9cc6234f0bf2e = spawnStruct();
  var_c4f9b0bf67170f6f.var_9a577a7ebc413d46 = [];
  var_c4f9b0bf67170f6f.var_6c29f2fdb0054bbe = [];
  var_c4f9b0bf67170f6f.var_c083bd8353c655c1 = [];
  var_c4f9b0bf67170f6f.var_47187a65a8fb783d = [];
  var_c4f9b0bf67170f6f.var_40b691c0a6852f73 = [];
  var_c4f9b0bf67170f6f.objectivemarkers = [];
  var_c4f9b0bf67170f6f.var_21f1863c6d44d936 = [];
  var_c4f9b0bf67170f6f.var_67c56bf0b03688bf = [];
  var_c4f9b0bf67170f6f.var_17a2361aa0beabb2 = [];
  var_c4f9b0bf67170f6f.var_14a8920a25d8a7a1 = [];
  var_c4f9b0bf67170f6f.var_9767f7738e477df8 = undefined;
  function_99a59990b4652967(var_c4f9b0bf67170f6f);
  scripts\common\data_tracker::function_4d1de11b1a5630ec(var_c4f9b0bf67170f6f);
  var_c4f9b0bf67170f6f scripts\common\data_tracker::addcallback(&function_6fe8aa8dfb9111eb);
  return var_c4f9b0bf67170f6f;
}

function private function_1e3f083d84bd04e(activityinstance, var_838185e7a405fe33) {
  function_290cf2ed36c04f4e(activityinstance);

  if(isDefined(var_838185e7a405fe33)) {
    if(function_1888d1b2aeeda25(activityinstance, "Center_Spatial_Zone")) {
      function_99ea7dc018941548(activityinstance, "Center_Spatial_Zone");
    }

    function_51ad14107ca158fb(activityinstance, "Center_Spatial_Zone", var_838185e7a405fe33);
  }

  if(!function_1888d1b2aeeda25(activityinstance, "Hibernation_Zone")) {
    function_8288c27883885909(activityinstance, "Hibernation_Zone");
  }

  function_bca93bc1f7ac851b(activityinstance);
  activityinstance function_25599e7b57187fba();
  function_4bae1139db07af24(activityinstance, "IdleState", "ActiveState");
  function_60e8ae157274f8a1(activityinstance);
  function_dca86aca511288f4(activityinstance, "ActiveState", "Waiting for initial Instance setup to be complete");
}

function private function_84f0d4362b882db3(activityinstance) {
  function_735ee8e9d0f1b00b(activityinstance, "InstanceBegin");
  function_c990ea1181ca3c72(activityinstance);
  function_20e36ec9e5802d01(activityinstance, "ActiveState", "Initial Instance setup is now complete");
}

function private function_352e2e45216e21e5(activityinstance) {
  function_735ee8e9d0f1b00b(activityinstance, "InstanceEnd");
  function_104adc18c0d699c3(activityinstance, 3);
  namespace_779ebc650a9ef856::function_d81c572daff63cf9(activityinstance);
  activityinstance function_a26e39e03a0d6739();
  function_b648a3057ae14ace(activityinstance);

  if(function_71d38726159c3f12(4)) {
    function_f541e4e4edaa8e99(4, [activityinstance], 1);
  }

  if(activityinstance.var_6c29f2fdb0054bbe.size > 0) {
    activitynexuslog("Activity is about to be destroyed but still has participating players. This may be an issue if the activity has already gone through its 'End' state transition since no players are supposed to be participating at that time.", @ "hash_22e4e38cab273e93", activityinstance, activityinstance.var_6c29f2fdb0054bbe, 2);
    function_887918ed2a888e8f(activityinstance);
  }

  function_d958ed0ac4ceaa91(activityinstance);
  activityinstance notify("instance_destroyed");
}

function private function_ebb378f45bd03af(activityinstance) {
  activityinstance endon("activity_started");
  function_735ee8e9d0f1b00b(activityinstance, "ActivityBegin");
  function_8e34ea43151530e4(activityinstance);

  foreach(player in activityinstance.var_6c29f2fdb0054bbe) {
    function_8269fc90973cf0f2(activityinstance, player);
  }

  if(function_71d38726159c3f12(2)) {
    function_f541e4e4edaa8e99(2, [activityinstance], 1);
  }

  function_104adc18c0d699c3(activityinstance, 1);
}

function private function_cea8c4728964c967(activityinstance) {
  function_735ee8e9d0f1b00b(activityinstance, "ActivityEnd");
  function_104adc18c0d699c3(activityinstance, 2);
  function_9e707430c4d9a988(activityinstance);

  if(function_71d38726159c3f12(3)) {
    function_f541e4e4edaa8e99(3, [activityinstance], 1);
  }

  activityinstance notify("activity_ended");
  waitframe();
  thread function_f020477c47b9be94(activityinstance, "CleanupState");
}

function private function_e56283e3cbfa05ad(activityinstance) {
  foreach(player in activityinstance.var_6c29f2fdb0054bbe) {
    function_d079465d310f745b(activityinstance, player);
  }

  activityinstance.var_8b79601f5cca1fa9 = 1;
  function_735ee8e9d0f1b00b(activityinstance, "ActivitySuccess");
  activityinstance notify("activity_succeeded");
}

function private function_27251a5a24d92d28(activityinstance) {
  function_735ee8e9d0f1b00b(activityinstance, "ActivityFailure");
  activityinstance notify("activity_failed");
}

function private function_c4ea67b937f27c4a(activityinstance) {
  waitframe();
  thread function_f020477c47b9be94(activityinstance, "EndedState");
}

function private function_9e707430c4d9a988(activityinstance) {
  activityinstance function_f3a73e1c537a55ae();
  activityinstance function_1c5d0098478465a();
  activityinstance function_f21a2c921f86f5a2(0);

  if(function_94e9b15c2db8c147(activityinstance)) {
    function_a0df260910df9e83(activityinstance);
  }

  function_887918ed2a888e8f(activityinstance);
}

function private function_c60416581033254c(activityinstance, activitystate, delaytime) {
  activityinstance endon("instance_destroyed");
  function_dca86aca511288f4(activityinstance, activitystate, "Waiting for a " + delaytime + " second time delay to elapse");
  wait delaytime;
  function_20e36ec9e5802d01(activityinstance, activitystate, "The " + delaytime + " second time delay is over");
}

function private function_8e34ea43151530e4(activityinstance) {
  foreach(requestid, encounterrequest in activityinstance.var_21f1863c6d44d936) {
    if(encounterrequest.spawntype == 0) {
      function_55caa7ecdad1659c(requestid);
    }
  }
}

function private function_f509fac14c3cdb1d(activityinstance, var_27aead966092b192) {
  var_ef64095e6090cac4 = function_73bd348a2ec322cf(activityinstance);

  if(var_27aead966092b192 == "ActiveState" && var_ef64095e6090cac4 == "IdleState") {
    function_9f615e48fce63bf8(activityinstance, var_27aead966092b192);
    function_ebb378f45bd03af(activityinstance);
    return;
  }

  if(var_27aead966092b192 == "EndedState" && var_ef64095e6090cac4 == "ActiveState") {
    function_9f615e48fce63bf8(activityinstance, var_27aead966092b192);
    function_4bae1139db07af24(activityinstance, "EndedState", "CleanupState");
    thread function_cea8c4728964c967(activityinstance);
    return;
  }

  if(var_27aead966092b192 == "CleanupState" && var_ef64095e6090cac4 != "CleanupState") {
    function_9f615e48fce63bf8(activityinstance, var_27aead966092b192);

    if(var_ef64095e6090cac4 == "ActiveState" || var_ef64095e6090cac4 == "IdleState") {
      function_9e707430c4d9a988(activityinstance);
    }

    function_352e2e45216e21e5(activityinstance);
  }
}

function private function_f020477c47b9be94(activityinstance, transitionstate) {
  activityinstance endon("instance_destroyed");

  while(!function_6daf2e19ef224d27(activityinstance, transitionstate)) {
    activityinstance waittill("activity_state_transition_blocker_removed");
  }

  function_f509fac14c3cdb1d(activityinstance, transitionstate);
}

function private function_4bae1139db07af24(activityinstance, startstate, endstate) {
  if(function_59244b295f5978b9(activityinstance, startstate, endstate)) {
    var_338c7fad3423f1f0 = function_1acdcfcf43076114(activityinstance, startstate, endstate);
    thread function_4eb3542e564b1ddc(activityinstance, endstate, 1, var_338c7fad3423f1f0);
  }

  if(function_94f74d26e2e01494(activityinstance, startstate, endstate)) {
    radii = function_1eb80c239023070b(activityinstance, startstate, endstate);
    thread function_4eb3542e564b1ddc(activityinstance, endstate, 0, radii);
  }

  if(function_df5092441b879128(activityinstance, startstate, endstate)) {
    if(function_e3a6cc803541a75f(activityinstance) > 0) {
      function_dca86aca511288f4(activityinstance, endstate, "Waiting until minimum player count is met");
    }
  }

  if(function_64245919df413a31(activityinstance, startstate, endstate)) {
    delaytime = function_c4f6cd7b881d2e90(activityinstance, startstate, endstate);
    thread function_c60416581033254c(activityinstance, endstate, delaytime);
  }
}

function private function_9a40bf3502fe45f(var_6f8af5eb76deac21) {
  playerlist = var_6f8af5eb76deac21.playerlist;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      function_8269fc90973cf0f2(self, player);
    }
  }
}

function private function_d3d9ead84b5ad147(var_6f8af5eb76deac21) {
  playerlist = var_6f8af5eb76deac21.playerlist;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      function_bbf4d209e6b59a36(self, player);
    }
  }
}

function private function_236c3a4a9216f248(var_6f8af5eb76deac21) {
  activityinstance = self;

  if(activityinstance.var_6c29f2fdb0054bbe.size == 0 && function_190ef47c1d23a8cb(activityinstance)) {
    activitystate = function_73bd348a2ec322cf(activityinstance);

    if(activitystate != "EndedState" && function_32b26700c8790a55(activityinstance)) {
      function_4bae1139db07af24(activityinstance, "EndedState", "CleanupState");
    }

    waitframe();
    function_f020477c47b9be94(activityinstance, "CleanupState");
  }
}

function private function_8269fc90973cf0f2(activityinstance, player) {
  currentstate = function_73bd348a2ec322cf(activityinstance);

  if(currentstate == "ActiveState") {
    if(function_13d30c9eb7e77d36(activityinstance)) {
      player function_f2c3ee9fded6a3df(1);
    }

    if(function_aa25447f55e47fd0(activityinstance)) {
      player function_cb6c6cd4245c5551(1);
    }

    if(function_11a119965a805599(activityinstance)) {
      player function_aea2aa66a0043475();
    }

    if(function_d9004f88db27af5e(activityinstance)) {
      scriptbundleloadout = function_e8ef53cbeb6ab7e(activityinstance);
      loadout = function_32d0db3e4198e55d(scriptbundleloadout);
      player function_76e32a123417cd84(loadout);
    }
  }
}

function private function_bbf4d209e6b59a36(activityinstance, player) {
  currentstate = function_73bd348a2ec322cf(activityinstance);

  if(currentstate == "ActiveState" || currentstate == "EndedState") {
    if(function_13d30c9eb7e77d36(activityinstance)) {
      player function_f2c3ee9fded6a3df(0);
    }

    if(function_aa25447f55e47fd0(activityinstance)) {
      player function_cb6c6cd4245c5551(0);
    }

    if(function_11a119965a805599(activityinstance)) {
      player restoreplayerloadout();
    }
  }

  if(currentstate == "EndedState") {
    function_1015815db0b598c2(player, self);
  }
}

function private function_9f615e48fce63bf8(activityinstance, var_37a95d32873b1ccc) {
  activityinstance.state = var_37a95d32873b1ccc;
}

function private function_4eb3542e564b1ddc(activityinstance, activitystate, playersdesired, spatialzonename) {
  activityinstance endon("instance_destroyed");
  var_fab326681eaecf8f = @ "hash_22e4e38cab273e93";
  var_8d52f62e5d1ea317 = "Waiting until Player Proximity Changes";

  if(function_2a1e9879f71ab677(var_fab326681eaecf8f)) {
    if(istrue(playersdesired)) {
      var_8d52f62e5d1ea317 = "Waiting until Players are nearby";
    } else {
      var_8d52f62e5d1ea317 = "Waiting until Players are far away";
    }
  }

  function_dca86aca511288f4(activityinstance, activitystate, var_8d52f62e5d1ea317);

  while(true) {
    playersinradius = namespace_8480efeffcd6e233::function_7ec62d1550b9897e(activityinstance, spatialzonename);

    if(isDefined(playersinradius) && playersinradius.size > 0 && playersdesired) {
      break;
    } else if((!isDefined(playersinradius) || playersinradius.size == 0) && !playersdesired) {
      break;
    }

    wait 1;
  }

  var_8d52f62e5d1ea317 = "Player Proximity Has Appropriately Changed";

  if(function_2a1e9879f71ab677(var_fab326681eaecf8f)) {
    if(istrue(playersdesired)) {
      var_8d52f62e5d1ea317 = "Players are now nearby";
    } else {
      var_8d52f62e5d1ea317 = "Players are now far enough away";
    }
  }

  function_20e36ec9e5802d01(activityinstance, activitystate, var_8d52f62e5d1ea317);
}

function private function_7a00a458019b00d3(var_6f8af5eb76deac21) {
  activityinstance = self;
  activitydefinition = activityinstance function_4188e118731a30f4();
  var_a84449a9bd492279 = function_4c263c3baccae8b(activitydefinition);
  var_7c0025e4cf44b11a = function_7e5077b9bfb018e2(activitydefinition);

  if(!function_94e9b15c2db8c147(activityinstance)) {
    if(isDefined(var_a84449a9bd492279) && var_a84449a9bd492279 == var_6f8af5eb76deac21.activitymoment) {
      function_3e33031646de23b0(activityinstance);
    }

    return;
  }

  if(isDefined(var_7c0025e4cf44b11a) && var_7c0025e4cf44b11a == var_6f8af5eb76deac21.activitymoment) {
    function_a0df260910df9e83(activityinstance);
  }
}

function private function_b648a3057ae14ace(activityinstance) {
  var_f0c94f7891c2887f = namespace_8480efeffcd6e233::function_803a3ef29d1b6598(activityinstance);

  foreach(spatialzonename in var_f0c94f7891c2887f) {
    namespace_8480efeffcd6e233::function_d829ceb32b15c66a(activityinstance, spatialzonename);
  }
}

function private function_bca93bc1f7ac851b(activityinstance) {
  function_caf8f45b7e3b78a2(activityinstance);
  var_ee373e1060f9863f = function_dd58016ab8a9a3e0(activityinstance);
  var_ee373e1060f9863f.var_404ec7a436f43edf = function_ede8352b065f482c(activityinstance);
  var_ee373e1060f9863f.var_821230cb7573c0ae = function_403cb24e07b176b0(activityinstance);
  var_ee373e1060f9863f.var_9cc81390bae90155 = function_602655b21cbe7767(activityinstance);
}