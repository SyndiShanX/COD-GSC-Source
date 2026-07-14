/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2a9058c1321cd25d.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_50cece4fabbdcc75;
#using script_5a38602f6a9ab5d4;
#using script_73a03aaf11b641f5;
#using script_77873e194e406c6d;
#using script_f01501ac138f999;
#using scripts\common\system;
#using scripts\engine\utility;
#namespace namespace_ad67514350126f83;

function private autoexec __init__system__() {
  system::register(#"hash_a820d046ebe056be", undefined, &function_b29ac995e73beb10, undefined);
}

function private function_b29ac995e73beb10() {
  utility::registersharedfunc(#"ai_spawn_director", #"activityaiencounterinit", &activityaiencounterinit);
}

function activityaiencounterinit() {
  activity_common::function_cbc923662b03cacb("\x14\x9b{|,\x05\xd9\f9\x86)\xce6", &function_4235a6dbc0791476);
  activity_common::function_cbc923662b03cacb("n\x9b\xad\xd2\x96\xc1\x19}\xcf%\as\x11", &function_4235a6dbc0791476);
  activity_common::function_cbc923662b03cacb("(\xbd%\xa1\x18I\xd2xur\xcb", &function_4235a6dbc0791476);
  activity_common::function_cbc923662b03cacb("\x94\xe6n\x8e\v\xdclYEsd", &function_4235a6dbc0791476);
}

function function_b685152f97b8ccee(requestid, fncallback, userdata) {
  activityinstance = self;
  assert(isDefined(activityinstance.var_e687d62499f0c463[requestid]), "<dev string:x24>" + requestid + "<dev string:x3e>");
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  activityinstance.var_e687d62499f0c463[requestid].readytospawncallback = fncallback;
  activityinstance.var_e687d62499f0c463[requestid].var_487ad260cc9a6d = userdata;
}

function function_2806e1b8b60f377d(requestid, fncallback, userdata) {
  activityinstance = self;
  assert(isDefined(activityinstance.var_e687d62499f0c463[requestid]), "<dev string:x24>" + requestid + "<dev string:x3e>");
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  activityinstance.var_e687d62499f0c463[requestid].spawnedcallback = fncallback;
  activityinstance.var_e687d62499f0c463[requestid].spawnedcallbackuserdata = userdata;
}

function function_ba4374edbc3012e1(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_5849c366a9f3c1d6(requestid, fncallback, userdata);
}

function function_4ced0a770681cecf(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_a4fd12dec593963f(requestid, fncallback, userdata);
}

function function_9b5e6f12112177e8(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_9076e2c9c605a712(requestid, fncallback, userdata);
}

function function_bd6760ae97ee80bd(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_828da040bb6476b9(requestid, fncallback, userdata);
}

function function_edc7fcd8c07c4d5e(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_bdeb645c49b56fc7(requestid, fncallback, userdata);
}

function function_955d5c1801d44cb9(requestid, fncallback, userdata) {
  activityinstance = self;
  assert(isDefined(activityinstance.var_e687d62499f0c463[requestid]), "<dev string:x24>" + requestid + "<dev string:x3e>");
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  activityinstance.var_e687d62499f0c463[requestid].shutdowncallback = fncallback;
  activityinstance.var_e687d62499f0c463[requestid].shutdowncallbackuserdata = userdata;
}

function function_a85fbcbf3ec9facd(requestid, fncallback, userdata) {
  assert(isDefined(fncallback) && isfunction(fncallback), "<dev string:x6b>");
  ai_spawn_director::function_9890804f7e1fabe9(requestid, fncallback, userdata);
}

function function_2ae17d0d11e6f56b(requestid) {
  var_d2eb8aba5c657d96 = level.activities;

  foreach(activityinstance in var_d2eb8aba5c657d96.instances) {
    if(isarray(activityinstance.var_e687d62499f0c463) && isDefined(activityinstance.var_e687d62499f0c463[requestid])) {
      return activityinstance;
    }
  }

  assertmsg("<dev string:xbd>" + requestid + "<dev string:x104>");
  return undefined;
}

function function_c19e48a7ece0f9bd(encounterbundlename, origin, radius, enabled, var_cc464e571ac6f4d1, spawntype, cleanuptype) {
  activityinstance = self;
  spawnimmediately = spawntype == 1;
  requestid = ai_spawn_director::spawn_request(encounterbundlename, origin, radius, enabled, spawnimmediately);

  if(!isDefined(requestid)) {
    assertmsg("<dev string:x15d>" + encounterbundlename + "<dev string:x183>" + activityinstance.type + "<dev string:x1ae>" + activityinstance.varianttag);
    return undefined;
  }

  function_2c0c72cdbf5724c8(requestid, var_cc464e571ac6f4d1, spawntype, cleanuptype);
  return requestid;
}

function function_5e9d0705a1b4daeb(requestid, enabled, var_cc464e571ac6f4d1, spawntype, cleanuptype) {
  activityinstance = self;

  if(!isDefined(requestid)) {
    assertmsg("<dev string:x1bc>" + activityinstance.type + "<dev string:x1ae>" + activityinstance.varianttag);
    return;
  }

  function_2c0c72cdbf5724c8(requestid, var_cc464e571ac6f4d1, spawntype, cleanuptype);

  if(istrue(enabled)) {
    function_fee3bfabdb43ee66(requestid);
  }
}

function function_1530704816ab9b68(targetname) {
  return ai_spawn_director::function_fa74e65cf8af0e10(targetname);
}

function function_cb16b51253990a6c(targetname, enabled, var_cc464e571ac6f4d1, spawntype, cleanuptype) {
  activityinstance = self;
  requestid = activityinstance function_1530704816ab9b68(targetname);

  if(!isDefined(requestid)) {
    assertmsg("<dev string:x204>" + targetname + "<dev string:x183>" + activityinstance.type + "<dev string:x1ae>" + activityinstance.varianttag);
    return undefined;
  }

  activityinstance function_5e9d0705a1b4daeb(requestid, enabled, var_cc464e571ac6f4d1, spawntype, cleanuptype);
  return requestid;
}

function function_fee3bfabdb43ee66(requestid) {
  activityinstance = self;

  if(!(isDefined(requestid) && isDefined(activityinstance.var_e687d62499f0c463[requestid]))) {
    assertmsg("<dev string:x1bc>" + activityinstance.type + "<dev string:x1ae>" + activityinstance.varianttag);
    return;
  }

  function_36fcb84d1ddc8c4(requestid, 1);
}

function function_60bb90a86cdcf2f9(requestid) {
  activityinstance = self;
  encounterrequest = activityinstance.var_e687d62499f0c463[requestid];
  assert(isDefined(encounterrequest), "<dev string:x24>" + requestid + "<dev string:x3e>");
  assert(encounterrequest.readytospawn == 1, "<dev string:x23b>");
  function_954d9d7f9ce9a086(requestid);
}

function function_75fd4872daa68316() {
  activityinstance = self;

  foreach(encounterrequest in activityinstance.var_e687d62499f0c463) {
    function_6d9aad1ccc4d9a2a(activityinstance, requestid, 0);
  }
}

function function_f14c9a2110e93b0c(requestid) {
  activityinstance = self;
  assert(isDefined(activityinstance.var_e687d62499f0c463[requestid]), "<dev string:x24>" + requestid + "<dev string:x3e>");
  function_6d9aad1ccc4d9a2a(activityinstance, requestid, 0);
}

function function_cc672d017ea1d103(cleanuptype) {
  activityinstance = self;

  foreach(encounterrequest in activityinstance.var_e687d62499f0c463) {
    var_6c9eddaef4141c46 = encounterrequest.cleanuptype == 2;
    function_6d9aad1ccc4d9a2a(activityinstance, requestid, var_6c9eddaef4141c46);
  }
}

function function_88491b6b773863d4() {
  activityinstance = self;

  foreach(encounterrequest in activityinstance.var_e687d62499f0c463) {
    var_6c9eddaef4141c46 = encounterrequest.cleanuptype == 2;
    function_6d9aad1ccc4d9a2a(activityinstance, requestid, var_6c9eddaef4141c46);
  }
}

function function_ff13ba1afc12feee(requestid) {
  return isDefined(self.var_e687d62499f0c463[requestid]);
}

function function_f0aa4e4023a65ec9(activityinstance) {
  thread function_2acb7cc9e3fe0253(activityinstance);
}

function function_f4437b9b39ebab00(activityinstance) {
  activityinstance notify("\xbcR){\x1c\xb7\xd2\\;\x99\xd7\xbd7\xdb\xab=,9\x95\xba\xb9;XA\xb9\x93\x811\b\x1b-");

  if(!function_77206a9eacfdbdc4(activityinstance)) {
    var_9c09a8fd5d6aecdb = namespace_7b5dc905a7ea3e0f::function_86b33180e918436d(activityinstance);
    activityinstance function_c9600afe2ced6aa1(1, var_9c09a8fd5d6aecdb);
    function_8fc9ef87088f1b37(activityinstance, 1);
  }
}

function function_77206a9eacfdbdc4(activityinstance) {
  return istrue(activityinstance.var_348b540b4d2ddb78) || !isDefined(activityinstance.var_348b540b4d2ddb78);
}

function private function_8fc9ef87088f1b37(activityinstance, var_348b540b4d2ddb78) {
  activityinstance.var_348b540b4d2ddb78 = istrue(var_348b540b4d2ddb78);

  if(namespace_72e72f5e51e6e4b3::function_72a545c3f4d63582(@ "hash_ca2c42defef1a832")) {
    if(activityinstance.var_348b540b4d2ddb78) {
      namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x2b0>", @ "hash_ca2c42defef1a832", activityinstance);
      return;
    }

    namespace_72e72f5e51e6e4b3::activitynexuslog("<dev string:x303>", @ "hash_ca2c42defef1a832", activityinstance);
  }
}

function private function_2acb7cc9e3fe0253(activityinstance) {
  activityinstance endon("\xbcR){\x1c\xb7\xd2\\;\x99\xd7\xbd7\xdb\xab=,9\x95\xba\xb9;XA\xb9\x93\x811\b\x1b-");
  activityinstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  activitynexussettings = level.activities.activitynexussettings;

  if(namespace_7b5dc905a7ea3e0f::function_be103d7a1345b487(activityinstance) && function_77206a9eacfdbdc4(activityinstance)) {
    activityinstance function_c9600afe2ced6aa1(0, 0);
    function_8fc9ef87088f1b37(activityinstance, 0);
    centercanmove = namespace_59dbf6a1bb28a43f::function_f937ccd8bd60dc6d(activityinstance);

    while(centercanmove) {
      wait getdvarfloat(@ "hash_b1b13b4fc75d3cd7", activitynexussettings.var_6db1e79226b1584);
      activityinstance function_c9600afe2ced6aa1(0, 0);
    }
  }
}

function private function_fd89d9e3a5555274(requestid, activityinstance) {
  encounterrequest = activityinstance.var_e687d62499f0c463[requestid];

  if(isDefined(encounterrequest)) {
    encounterrequest.readytospawn = 1;

    if(encounterrequest.spawntype == 0) {
      activityinstance function_60bb90a86cdcf2f9(requestid);
      function_802ff89978eb83fc(activityinstance, requestid);
    } else if(encounterrequest.spawntype == 1) {
      activityinstance function_60bb90a86cdcf2f9(requestid);
    }

    if(isDefined(encounterrequest.readytospawncallback) && isfunction(encounterrequest.readytospawncallback)) {
      [[encounterrequest.readytospawncallback]](requestid, encounterrequest.var_487ad260cc9a6d);
    }
  }
}

function private function_7efdad8245f3cdd8(requestid, activityinstance, agent, var_ce031d7c20b702e0) {
  encounterrequest = activityinstance.var_e687d62499f0c463[requestid];

  if(isDefined(encounterrequest)) {
    if(isDefined(encounterrequest.spawnedcallback) && isfunction(encounterrequest.spawnedcallback)) {
      [[encounterrequest.spawnedcallback]](requestid, encounterrequest.spawnedcallbackuserdata, agent, var_ce031d7c20b702e0);
    }

    if(encounterrequest.var_4b8b6f2b06d49c5e && isDefined(agent)) {
      activityinstance activity_participation::function_f0553aeacf59b1db(agent);
    }
  }
}

function private function_4235a6dbc0791476(relevantinfostruct) {
  activityinstance = self;
  activitymoment = relevantinfostruct.activitymoment;

  if(activitymoment == "\x14\x9b{|,\x05\xd9\f9\x86)\xce6") {
    function_371c0d874368c0d1(activityinstance);
  }

  if(activitymoment == "(\xbd%\xa1\x18I\xd2xur\xcb") {
    activityinstance function_cc672d017ea1d103(0);
  } else if(activitymoment == "\x94\xe6n\x8e\v\xdclYEsd") {
    activityinstance function_cc672d017ea1d103();
  }

  function_9f48d38e5c752bec(activityinstance, activitymoment);
}

function private function_9f48d38e5c752bec(activityinstance, activitymoment) {
  if(namespace_7b5dc905a7ea3e0f::function_be103d7a1345b487(activityinstance)) {
    if(namespace_7b5dc905a7ea3e0f::function_16c019964dfd7adb(activityinstance) == activitymoment) {
      function_f0aa4e4023a65ec9(activityinstance);
      return;
    }

    if(namespace_7b5dc905a7ea3e0f::function_9bee4ffc7d3c4a4a(activityinstance) == activitymoment || activitymoment == "\x94\xe6n\x8e\v\xdclYEsd") {
      function_f4437b9b39ebab00(activityinstance);
    }
  }
}

function private function_371c0d874368c0d1(activityinstance) {
  foreach(encounterrequest in activityinstance.var_e687d62499f0c463) {
    if(encounterrequest.spawntype == 0) {
      function_60bb90a86cdcf2f9(requestid);
    }
  }
}

function private function_f4c00d64bdc5ea92(requestid, activityinstance, data) {
  encounterrequest = activityinstance.var_e687d62499f0c463[requestid];

  if(isDefined(encounterrequest)) {
    if(isDefined(encounterrequest.shutdowncallback) && isfunction(encounterrequest.shutdowncallback)) {
      [[encounterrequest.shutdowncallback]](requestid, encounterrequest.shutdowncallbackuserdata, data);
    }

    function_6d9aad1ccc4d9a2a(activityinstance, requestid, 0);
  }
}

function private function_2c0c72cdbf5724c8(requestid, var_cc464e571ac6f4d1, spawntype, cleanuptype) {
  activityinstance = self;
  ai_spawn_director::function_b74d3b902e3a0027(requestid, &function_fd89d9e3a5555274, activityinstance);
  ai_spawn_director::function_bb2f9ccaec38220e(requestid, &function_f4c00d64bdc5ea92, activityinstance);
  ai_spawn_director::function_a7384e68e6948e48(requestid, &function_7efdad8245f3cdd8, activityinstance);
  function_e5b985f45bdf2f09(activityinstance, requestid, spawntype, cleanuptype, var_cc464e571ac6f4d1);
}

function private function_e5b985f45bdf2f09(activityinstance, requestid, spawntype, cleanuptype, var_cc464e571ac6f4d1) {
  if(!isDefined(activityinstance.var_e687d62499f0c463[requestid])) {
    activityinstance.var_e687d62499f0c463[requestid] = spawnStruct();
    activityinstance.var_e687d62499f0c463[requestid].spawntype = spawntype;
    activityinstance.var_e687d62499f0c463[requestid].cleanuptype = cleanuptype;
    activityinstance.var_e687d62499f0c463[requestid].var_4b8b6f2b06d49c5e = istrue(var_cc464e571ac6f4d1);
    activityinstance.var_e687d62499f0c463[requestid].readytospawn = 0;

    if(spawntype == 0) {
      namespace_59dbf6a1bb28a43f::function_73ef289466fc32b1(activityinstance, undefined, "\xc3\x93}=nD", "M\xe5\xc0\x1f\x80\xcc\x15\x1e,U:Z\xbd\xc0\xa7\xd1\xb8u\xa0\xae\xd8\xd2\xbd\x1e\x84\xa9\xa0p\xcf\x8b\xb5l|M\xf1\x0f\xc0\xc8+,f\xb9\xb8\x90\xc6\x90\xddx\x80\x05\xa0(\x8a\xb8" + requestid);
      activityinstance.var_e687d62499f0c463[requestid].var_76939d3aa0d137e1 = 1;
    }

    return;
  }

  assertmsg("<dev string:x349>");
}

function private function_6d9aad1ccc4d9a2a(activityinstance, requestid, var_6c9eddaef4141c46) {
  if(isDefined(activityinstance.var_e687d62499f0c463[requestid])) {
    function_802ff89978eb83fc(activityinstance, requestid);

    if(istrue(var_6c9eddaef4141c46)) {
      function_c15aea90f8f85ed1(requestid);
    } else {
      ai_spawn_director::function_9ded1e6b967479e0(requestid, 0);
    }

    activityinstance.var_e687d62499f0c463[requestid] = undefined;
  }
}

function private function_802ff89978eb83fc(activityinstance, requestid) {
  encounterrequest = activityinstance.var_e687d62499f0c463[requestid];

  if(isDefined(encounterrequest)) {
    if(encounterrequest.spawntype == 0 && istrue(encounterrequest.var_76939d3aa0d137e1)) {
      namespace_59dbf6a1bb28a43f::function_742ec2f4a8319b28(activityinstance, undefined, "\xc3\x93}=nD", "h\xc1\xa9\xe4\xc4\xb9i;}\xbdV=|\xd0\x041\x042\xe0L\xb9\xb5\xf8\t;'*z\xe7,\x9f\x16\x8c\xd5I\x97\x88\xbb\xbet\x85\x82" + requestid + "\b\xbb\xc2\xdc\x80\x9d\x93\x16\xcd\xd1e\x8c");
      encounterrequest.var_76939d3aa0d137e1 = 0;
    }
  }
}

function private function_c9600afe2ced6aa1(removeonly, removedelay) {
  function_dfd4d9fd84819c70(#"hash_849107430cbd7871");

  if(namespace_9342d78fcaacff0b::function_a2f5a6979eb10328(self, "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(")) {
    var_bac1e2af6891bd74 = namespace_9342d78fcaacff0b::function_d155afd969a2a226(self, "\xc8\x01\xe2\xf79Go\xc7\xd2\xde\x167\xa8&\xb2nL4\x9c\xa3q\xbe\x9dR(");

    for(var_558a8c134ff20e0a = 0; var_558a8c134ff20e0a < var_bac1e2af6891bd74.size; var_558a8c134ff20e0a++) {
      var_aa43dd3ad93deb33 = var_bac1e2af6891bd74[var_558a8c134ff20e0a];
      center = namespace_9342d78fcaacff0b::function_4e71ca577d4d6ad9(var_aa43dd3ad93deb33);
      radius = namespace_9342d78fcaacff0b::function_49eb13996d2d23ed(var_aa43dd3ad93deb33);
      uniquename = utility::string(self.id) + "\xb8Y=" + utility::string(var_558a8c134ff20e0a);
      function_8f0ed22bc152e4eb(uniquename + self.type, removedelay);

      if(!removeonly) {
        function_49600568b241f00e(uniquename + self.type, center, radius);
      }
    }
  }

  profileendevent();
}