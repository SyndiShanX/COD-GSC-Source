/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_208955cb4d2c8fb3.gsc
*************************************************/

#using script_41387eecc35b88bf;
#using script_42adcce5878f583;
#using script_7956d56c4922bd1;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\stealth\utility;
#namespace namespace_87d75ea764a6d2fd;

function function_56e8f78ce1511d35(warlordtype, callbackfunction, userdata) {
  assertex(isDefined(level.ob.warlordcallbacks["<dev string:x1c>"]), "<dev string:x35>");
  level.ob.warlordcallbacks["WarlordInitialization"][warlordtype] = spawnStruct();
  level.ob.warlordcallbacks["WarlordInitialization"][warlordtype].callbackfunction = callbackfunction;
  level.ob.warlordcallbacks["WarlordInitialization"][warlordtype].userdata = userdata;
}

function function_32d58ef031f811e5(warlordtype, callbackfunction, userdata) {
  assertex(isDefined(level.ob.warlordcallbacks["<dev string:x6d>"]), "<dev string:x35>");
  level.ob.warlordcallbacks["WarlordEnterCombat"][warlordtype] = spawnStruct();
  level.ob.warlordcallbacks["WarlordEnterCombat"][warlordtype].callbackfunction = callbackfunction;
  level.ob.warlordcallbacks["WarlordEnterCombat"][warlordtype].userdata = userdata;
}

function function_dbfada6bda9049b3(warlordtype, callbackfunction, userdata) {
  assertex(isDefined(level.ob.warlordcallbacks["<dev string:x83>"]), "<dev string:x35>");
  level.ob.warlordcallbacks["BodyguardInitialization"][warlordtype] = spawnStruct();
  level.ob.warlordcallbacks["BodyguardInitialization"][warlordtype].callbackfunction = callbackfunction;
  level.ob.warlordcallbacks["BodyguardInitialization"][warlordtype].userdata = userdata;
}

function function_ca19e36a62160d1b() {
  var_462bad107655e7af = getdvarint(@ "hash_bd0a763d48b336f5", 0);

  if(var_462bad107655e7af > 0 && isDefined(level.ob) && isDefined(level.ob.var_d7935410e738bfb5) && level.ob.var_d7935410e738bfb5.size > 1 && var_462bad107655e7af < level.ob.var_d7935410e738bfb5.size) {
    warlordweights = [];
    warlordweights["WARLORD_CHEMIST"] = getdvarint(@ "hash_352fcc571f69c906", 25);
    warlordweights["WARLORD_ALLFORONE"] = getdvarint(@ "hash_713abd88cba7893b", 25);
    warlordweights["WARLORD_MAESTRO"] = getdvarint(@ "hash_10e4b47f5b5e87e4", 25);
    warlordweights["WARLORD_RAINMAKER"] = getdvarint(@ "hash_1f18592b11c92795", 25);
    level.ob.var_2d47f6a46e7f1d8c = [];
    var_dde4e2ad15f13f79 = [];

    foreach(warlord in level.ob.var_d7935410e738bfb5) {
      if(warlordweights[warlord] >= 100) {
        var_dde4e2ad15f13f79[var_dde4e2ad15f13f79.size] = warlord;
      }
    }

    foreach(var_b509a6a9e16880b4 in var_dde4e2ad15f13f79) {
      function_cfa04404b9d2785f(var_b509a6a9e16880b4);
    }

    if(level.ob.var_d7935410e738bfb5.size <= var_462bad107655e7af) {
      assertmsg("<dev string:x9e>" + var_462bad107655e7af + "<dev string:xf7>");
      return;
    }

    for(i = 0; i < var_462bad107655e7af; i++) {
      var_ea7b8497480fbe00 = [];

      foreach(warlord in level.ob.var_d7935410e738bfb5) {
        var_ea7b8497480fbe00[var_ea7b8497480fbe00.size] = warlordweights[warlord];
      }

      var_743226b7979f16a3 = scripts\engine\utility::random_weighted(level.ob.var_d7935410e738bfb5, var_ea7b8497480fbe00);

      if(isDefined(var_743226b7979f16a3)) {
        function_cfa04404b9d2785f(var_743226b7979f16a3);
        continue;
      }

      assertmsg("<dev string:x141>" + var_462bad107655e7af + "<dev string:x184>");
      return;
    }

    scripts\engine\utility::registersharedfunc("warlords", "warlordIsDisabled", &function_38b20d4656daf802);
    logstring("ob_warlord_utility::init_warlord_randomization Warlords enabled: " + level.ob.var_2d47f6a46e7f1d8c.size);

    foreach(warlordenabled in level.ob.var_2d47f6a46e7f1d8c) {
      logstring("ob_warlord_utility::init_warlord_randomization : " + warlordenabled);
    }

    return;
  }

  println("<dev string:x1f2>");
}

function private function_cfa04404b9d2785f(var_1cbab0f95b6dd9cc) {
  level.ob.var_2d47f6a46e7f1d8c[level.ob.var_2d47f6a46e7f1d8c.size] = var_1cbab0f95b6dd9cc;
  level.ob.var_d7935410e738bfb5 = scripts\engine\utility::array_remove(level.ob.var_d7935410e738bfb5, var_1cbab0f95b6dd9cc);
}

function private function_38b20d4656daf802(var_6a9c4405c9014215) {
  if(isDefined(level.ob) && isDefined(level.ob.var_2d47f6a46e7f1d8c)) {
    return !array_contains(level.ob.var_2d47f6a46e7f1d8c, var_6a9c4405c9014215);
  }

  return false;
}

function setup_data(warlordtype, var_6a9c4405c9014215) {
  if(!isDefined(level.ob)) {
    level.ob = spawnStruct();
  }

  if(!isDefined(level.ob.var_d7935410e738bfb5)) {
    level.ob.var_d7935410e738bfb5 = [];
  }

  if(isDefined(var_6a9c4405c9014215)) {
    level.ob.var_d7935410e738bfb5[level.ob.var_d7935410e738bfb5.size] = var_6a9c4405c9014215;
  }

  thread function_c4ee5a14998ec4f0();
  function_b2957529a40f9419();
  level.ob.var_ebde11a65d618ef6 = utility::default_to(level.ob.var_ebde11a65d618ef6, []);
  level.ob.warlordparameters = utility::default_to(level.ob.warlordparameters, []);
  var_9414c7e6e6b170eb = getscriptbundlenames("obwarlord");

  foreach(var_eda9f5416ee74e1a in var_9414c7e6e6b170eb) {
    var_2837ba0ad9d0ca86 = getscriptbundle(var_eda9f5416ee74e1a);
    level.ob.var_df2a406396977cd[warlordtype] = var_2837ba0ad9d0ca86.headiconparameters;

    if(var_2837ba0ad9d0ca86.warlordparameters.size > 0) {
      warlordparameters = var_2837ba0ad9d0ca86.warlordparameters[0].variant_object;
      var_416e692d602bff30 = function_f159c10d5cf8f0b4(warlordparameters.goalvolumetargetname, "targetname");

      if(isDefined(var_416e692d602bff30) && var_416e692d602bff30.size > 0) {
        warlordparameters.goalvolume = var_416e692d602bff30[0];
      }

      if(isDefined(warlordparameters) && warlordparameters.warlordtype == warlordtype) {
        foreach(var_d7cf3fcb6f576be8 in var_2837ba0ad9d0ca86.var_562cca092966b4b5) {
          level.ob.var_ebde11a65d618ef6["actor_" + var_d7cf3fcb6f576be8.var_fff6b84dc56a9504] = warlordtype;
        }

        level.ob.warlordparameters[warlordtype] = warlordparameters;
        return;
      }
    }
  }

  assertmsg("<dev string:x27a>" + warlordtype + "<dev string:x2b8>");
}

function function_9acf953fd6bf2e46(warlordtype) {
  return level.ob.warlordparameters[warlordtype];
}

function function_b14ea143c425c696(agent) {
  if(!isDefined(agent) || !agent.isactive) {
    return undefined;
  }

  if(!isDefined(agent.ob) || !isDefined(agent.ob.warlorddata)) {
    assertmsg("<dev string:x2e2>");
    return undefined;
  }

  return agent.ob.warlorddata;
}

function function_621b23491ba1db4d() {
  var_54d38f1df370976a = undefined;

  if(isDefined(level.ob) && isDefined(level.ob.var_7dd4780d4e4bff4d)) {
    level.var_870b859eb5d3ef5d = [];

    foreach(activewarlord in level.ob.var_7dd4780d4e4bff4d) {
      var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(activewarlord);

      if(isDefined(var_d1c7613187e69022) && activewarlord.state == "ActiveState") {
        struct = spawnStruct();
        struct.key = var_d1c7613187e69022.var_9a002d7b10d97a7d;
        struct.warlordintel = var_d1c7613187e69022.var_826c99bbea28d245;
        level.var_870b859eb5d3ef5d = array_add(level.var_870b859eb5d3ef5d, struct);
      }
    }

    if(level.var_870b859eb5d3ef5d.size == 0) {
      var_54d38f1df370976a = spawnStruct();
      warlord = array_random(level.ob.var_7dd4780d4e4bff4d);
      var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(warlord);
      var_54d38f1df370976a.keyitemid = "ob_jup_item_key_" + var_d1c7613187e69022.var_9a002d7b10d97a7d;
      var_54d38f1df370976a.intelstring = var_d1c7613187e69022.var_826c99bbea28d245;
    }

    if(level.var_870b859eb5d3ef5d.size > 0) {
      randomindex = randomint(level.var_870b859eb5d3ef5d.size);
      var_54d38f1df370976a = spawnStruct();
      var_54d38f1df370976a.keyitemid = "ob_jup_item_key_" + level.var_870b859eb5d3ef5d[randomindex].key;
      var_54d38f1df370976a.intelstring = level.var_870b859eb5d3ef5d[randomindex].warlordintel;
    }
  }

  return var_54d38f1df370976a;
}

function function_ce3f50617905370d(var_65ba113a139d5326) {
  var_2189bfeed28cbb65 = undefined;

  if(isint(var_65ba113a139d5326)) {
    var_2189bfeed28cbb65 = var_65ba113a139d5326;
  } else if(isent(var_65ba113a139d5326)) {
    var_2189bfeed28cbb65 = var_65ba113a139d5326.ob.var_2189bfeed28cbb65;
  }

  if(isDefined(var_2189bfeed28cbb65)) {
    return level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65];
  }
}

function get_warlord(var_65ba113a139d5326) {
  var_3ecf047d758de560 = function_ce3f50617905370d(var_65ba113a139d5326);

  if(isDefined(var_3ecf047d758de560)) {
    return var_3ecf047d758de560.warlord;
  }
}

function function_69383e2ee4241972(var_65ba113a139d5326) {
  var_3ecf047d758de560 = function_ce3f50617905370d(var_65ba113a139d5326);

  if(isDefined(var_3ecf047d758de560)) {
    return var_3ecf047d758de560.bodyguards;
  }
}

function function_6d423bc682d6dc86(agent) {
  if(!isDefined(agent) || !isDefined(agent.ob) || !isDefined(agent.ob.warlordtype)) {
    return undefined;
  }

  return agent.ob.warlordtype;
}

function function_7161f6d8c69ce57(agenttype) {
  if(!isDefined(level.ob.var_ebde11a65d618ef6)) {
    return undefined;
  }

  return level.ob.var_ebde11a65d618ef6[agenttype];
}

function private function_df91d839bf1c0d15(requestid, var_2189bfeed28cbb65, var_9f82bb66fd374ef5) {
  requestdata = function_9a39e23c3c52c2af(requestid);

  foreach(ai in requestdata.ai) {
    if(isDefined(function_6d423bc682d6dc86(ai))) {
      continue;
    }

    ai function_b0f5bec38374c8cc(var_2189bfeed28cbb65);
  }
}

function private function_81d8f6b92521b89e(requestid, var_2189bfeed28cbb65) {
  var_3ecf047d758de560 = function_ce3f50617905370d(var_2189bfeed28cbb65);
  assertex(!isDefined(var_3ecf047d758de560.warlord), "<dev string:x327>");
  level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65] = undefined;
}

function function_f0c948dd48051d6d(event) {
  if(!isDefined(function_6d423bc682d6dc86(self))) {
    return;
  }

  waittill_any_4("stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush");
  function_bc95e76bb035cbb0("WarlordEnterCombat", self.ob.warlordtype);
}

function function_b0f5bec38374c8cc(var_2189bfeed28cbb65) {
  if(!isDefined(var_2189bfeed28cbb65)) {
    return;
  }

  if(!isDefined(self.ob)) {
    self.ob = spawnStruct();
  }

  self.ob.var_2189bfeed28cbb65 = var_2189bfeed28cbb65;
  var_3ecf047d758de560 = function_ce3f50617905370d(var_2189bfeed28cbb65);
  var_3ecf047d758de560.bodyguards = utility::array_add(var_3ecf047d758de560.bodyguards, self);
  function_8d7a31347e728957(var_3ecf047d758de560.warlordtype);
  function_bc95e76bb035cbb0("BodyguardInitialization", var_3ecf047d758de560.warlordtype);
  thread function_20bb31768283f2e1();
}

function function_395c3a00db83ba6(incomingdamage, smeansofdeath, objweapon) {
  var_1c3120f83fe70574 = getdvarint(@ "hash_41316bd57deea9ac", 625);
  damagemodifier = 1;
  iskillstreakweapon = 0;

  if(isDefined(objweapon)) {
    if(scripts\cp_mp\weapon::iswonderweapon(objweapon)) {
      damagemodifier = 1 - getdvarfloat(@ "hash_31b253892ec07512", 0.9);
    } else if(scripts\cp_mp\weapon::iskillstreakweapon(objweapon)) {
      iskillstreakweapon = 1;
      damagemodifier = 1 - getdvarfloat(@ "hash_867db2aabbc3871e", 0.3);
    } else {
      weaponref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

      if(isDefined(weaponref) && scripts\mp\equipment::isequipmentlethal(weaponref)) {
        damagemodifier = 1 - getdvarfloat(@ "hash_9583ada22eae941a", 0.6);
      }
    }
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_IMPACT") {
    damagemodifier *= 1 - getdvarfloat(@ "hash_92c73e8a555ee04e", 0.9);
  }

  incomingdamage *= damagemodifier;

  if(!iskillstreakweapon && isDefined(incomingdamage)) {
    incomingdamage = min(incomingdamage, var_1c3120f83fe70574);
  }

  return incomingdamage;
}

function private function_20bb31768283f2e1() {
  level endon("game_ended");
  var_2189bfeed28cbb65 = self.ob.var_2189bfeed28cbb65;
  var_3ecf047d758de560 = level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65];
  assertex(isDefined(var_3ecf047d758de560), "<dev string:x364>");
  self waittill("death");

  if(isDefined(var_3ecf047d758de560.warlord)) {
    var_3ecf047d758de560.warlord notify("bodyguard_death", self);
  }

  var_3ecf047d758de560.bodyguards = utility::array_remove(var_3ecf047d758de560.bodyguards, self);
}

function private function_6e131d8eb584fab1() {
  level endon("game_ended");
  var_2189bfeed28cbb65 = self.ob.var_2189bfeed28cbb65;
  var_3ecf047d758de560 = level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65];
  warlordheadicon = level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65].warlord.ob.headicon;
  assertex(isDefined(var_3ecf047d758de560), "<dev string:x364>");
  self waittill("death");

  if(isDefined(warlordheadicon)) {
    deleteheadicon(warlordheadicon);
  }

  var_3ecf047d758de560.warlord = undefined;
}

function private function_bc95e76bb035cbb0(callbacktype, warlordtype) {
  callbackstruct = function_79194a4c41782a44(callbacktype, warlordtype);

  if(isDefined(callbackstruct)) {
    self thread[[callbackstruct.callbackfunction]](self, callbackstruct.userdata);
  }
}

function private function_c4ee5a14998ec4f0() {
  utility::flag_wait("ai_spawn_director_initialized");
  ai_spawn_director::function_e4a440552e4cf1f4(&function_ed169893cf4e3c8b);
}

function private function_b2957529a40f9419() {
  level.ob.warlordcallbacks = utility::default_to(level.ob.warlordcallbacks, []);
  level.ob.warlordcallbacks["WarlordInitialization"] = utility::default_to(level.ob.warlordcallbacks["WarlordInitialization"], []);
  level.ob.warlordcallbacks["WarlordEnterCombat"] = utility::default_to(level.ob.warlordcallbacks["WarlordEnterCombat"], []);
  level.ob.warlordcallbacks["BodyguardInitialization"] = utility::default_to(level.ob.warlordcallbacks["BodyguardInitialization"], []);
}

function private function_79194a4c41782a44(var_fcf4ab9f684cfb9a, warlordtype) {
  if(isDefined(level.ob.warlordcallbacks[var_fcf4ab9f684cfb9a]) && isDefined(level.ob.warlordcallbacks[var_fcf4ab9f684cfb9a][warlordtype])) {
    return level.ob.warlordcallbacks[var_fcf4ab9f684cfb9a][warlordtype];
  }
}

function private function_ed169893cf4e3c8b(agent, requestid, data) {
  if(issubstr(agent.agent_type, "warlord")) {
    function_8834b75a040f482c(agent, requestid);
  }
}

function private function_8834b75a040f482c(agent, requestid) {
  warlordtype = function_7161f6d8c69ce57(agent.agent_type);

  if(isDefined(warlordtype)) {
    if(!isDefined(level.ob.var_3ecf047d758de560)) {
      level.ob.var_3ecf047d758de560 = [];
      level.ob.var_a00fdfa764345acc = 0;
    }

    if(!isDefined(agent.ob)) {
      agent.ob = spawnStruct();
    }

    level.ob.var_a00fdfa764345acc++;
    var_2189bfeed28cbb65 = level.ob.var_a00fdfa764345acc;
    var_3ecf047d758de560 = spawnStruct();
    var_3ecf047d758de560.warlordtype = warlordtype;
    var_3ecf047d758de560.bodyguards = [];
    var_3ecf047d758de560.activityinstance = function_8ba4c11453487949(agent.origin, level.ob.var_7dd4780d4e4bff4d);
    var_3ecf047d758de560.warlord = agent;
    agent function_23ff99f593753aa2();
    level.ob.var_3ecf047d758de560[var_2189bfeed28cbb65] = var_3ecf047d758de560;
    agent.ob.warlordtype = warlordtype;
    agent.ob.warlorddata = spawnStruct();
    agent.ob.var_2189bfeed28cbb65 = var_2189bfeed28cbb65;
    agent function_8d7a31347e728957(warlordtype);
    agent.ob.headicon = createheadicon(agent);

    if(agent.ob.headicon >= 0) {
      setheadiconimage(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].image);
      setheadicondrawthroughgeo(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].var_40323b3869b1dbf4);
      setheadiconzoffset(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].zoffset);
      setheadiconmaxdistance(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].maxdistance);
      function_a0889a73efaeafd3(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].var_ade54a80646b269e);
      function_272322fc1191dc50(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].fadeincenter);
      function_51044b10b2b673df(agent.ob.headicon, level.ob.var_df2a406396977cd[warlordtype].worldiconsize);
    }

    ai_spawn_director::function_f81b7c3f18ef98be(requestid, &function_df91d839bf1c0d15, var_2189bfeed28cbb65);
    ai_spawn_director::function_3248cab79849207(requestid, &function_81d8f6b92521b89e, var_2189bfeed28cbb65);
    agent function_bc95e76bb035cbb0("WarlordInitialization", warlordtype);
    agent thread _start_combat_chatter(warlordtype);
    agent utility::ent_flag_wait("stealth_enabled");
    agent thread function_f0c948dd48051d6d();
    agent function_6e131d8eb584fab1();
  }
}

function private function_23ff99f593753aa2() {
  self.allowpain = 0;
  self.var_274d3a7704e351ef = 1;
  self.var_9aa77ab756fdca82 = 10000;
  self.var_43e2ad424676b8d4 = 500;
  self.var_cbd87a0bc497b778 = 1;
  self.var_98add129a7ecb962 = 0;
  self.baseaccuracy = 1.3;
  self.disablereload = 1;
  self.var_4ebe755e0a0a430e = 0;
  self.suppressionthreshold = 0.4;
  self.suppressiondecrement = 0.25;
  self.disable_blindfire = 1;
  self.dontmelee = 1;
  self.var_4268b42fc89d0be9 = 0.03;
  self.var_8a783f4c73c2ae91 = 4e-05;
  self.spawned_timestamp = gettime();
  self disableexecutionvictim();
}

function private function_8d7a31347e728957(warlordtype) {
  goalvolume = level.ob.warlordparameters[warlordtype].goalvolume;

  if(isDefined(goalvolume)) {
    self setgoalvolumeauto(goalvolume);
  }
}

function private _start_combat_chatter(warlordtype) {
  if(!namespace_dc53a27a8db8e6bf::function_9488f02028f9f413(warlordtype)) {
    return;
  }

  warlordparams = level.ob.warlordparameters[warlordtype];

  if(!isDefined(warlordparams)) {
    return;
  }

  level endon("game_ended");
  self endon("death");
  ent_flag_wait("warlord_start_combat_chatter");
  var_5379fa309aea3b97 = default_to(warlordparams.var_3dd45e9c06d5584, 120);
  tauntscooldown = default_to(warlordparams.var_41ecd282cbd8319a, 160);
  var_8550aa5109d8fb4a = default_to(warlordparams.var_651c4bb853d4df1f, 180);
  thread namespace_dc53a27a8db8e6bf::function_70d2561024bc73f4(warlordtype, var_5379fa309aea3b97, tauntscooldown, var_8550aa5109d8fb4a);
}