/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\trial_jugg.gsc
***********************************************/

decoy_init() {
  level.decoygrenades = [];
  var_0 = spawnStruct();
  level.decoygrenadedata = var_0;
  var_0.firetypes = [];
  var_0.firetypeweights = [];
  var_0.firetimes = [];
  var_0.firemaxcounts = [];
  var_0.fireintervalmintimes = [];
  var_0.fireintervalmaxtimes = [];
  var_0.fireminupimpulse = [];
  var_0.firemaxupimpulse = [];
  var_0.fireminforwardimpulse = [];
  var_0.firemaxforwardimpulse = [];
  var_0.firetypes[var_0.firetypes.size] = "_encstr_AD07034A38";
  var_0.firetypeweights["_encstr_AD07034A38"] = 35;
  var_0.firetimes["_encstr_AD07034A38"] = 0.4;
  var_0.firemaxcounts["_encstr_AD07034A38"] = 0;
  var_0.fireintervalmintimes["_encstr_AD07034A38"] = 0.5;
  var_0.fireintervalmaxtimes["_encstr_AD07034A38"] = 2;
  var_0.fireminupimpulse["_encstr_AD07034A38"] = 175;
  var_0.firemaxupimpulse["_encstr_AD07034A38"] = 225;
  var_0.fireminforwardimpulse["_encstr_AD07034A38"] = 55;
  var_0.firemaxforwardimpulse["_encstr_AD07034A38"] = 125;
  var_0.firetypes[var_0.firetypes.size] = "_encstr_BE1904DCDA9D";
  var_0.firetypeweights["_encstr_BE1904DCDA9D"] = 50;
  var_0.firetimes["_encstr_BE1904DCDA9D"] = 0.4;
  var_0.firemaxcounts["_encstr_BE1904DCDA9D"] = 0;
  var_0.fireintervalmintimes["_encstr_BE1904DCDA9D"] = 0.25;
  var_0.fireintervalmaxtimes["_encstr_BE1904DCDA9D"] = 1;
  var_0.fireminupimpulse["_encstr_BE1904DCDA9D"] = 80;
  var_0.firemaxupimpulse["_encstr_BE1904DCDA9D"] = 125;
  var_0.fireminforwardimpulse["_encstr_BE1904DCDA9D"] = 175;
  var_0.firemaxforwardimpulse["_encstr_BE1904DCDA9D"] = 265;
  var_0.firetypes[var_0.firetypes.size] = "_encstr_850707F7E5833355B8";
  var_0.firetypeweights["_encstr_850707F7E5833355B8"] = 15;
  var_0.firetimes["_encstr_850707F7E5833355B8"] = 0.4;
  var_0.firemaxcounts["_encstr_850707F7E5833355B8"] = 0;
  var_0.fireintervalmintimes["_encstr_850707F7E5833355B8"] = 1;
  var_0.fireintervalmaxtimes["_encstr_850707F7E5833355B8"] = 3;
  var_0.fireminupimpulse["_encstr_850707F7E5833355B8"] = 250;
  var_0.firemaxupimpulse["_encstr_850707F7E5833355B8"] = 375;
  var_0.fireminforwardimpulse["_encstr_850707F7E5833355B8"] = 0;
  var_0.firemaxforwardimpulse["_encstr_850707F7E5833355B8"] = 60;

  if(!threatbiasgroupexists("_encstr_8E8405EA382B2A"))
    createthreatbiasgroup("_encstr_8E8405EA382B2A");

  createthreatbiasgroup("_encstr_AA680E3B80C1DF23070C5A97E023AA9D");
  createthreatbiasgroup("_encstr_82371509A566C00BCFDAEB31720F4D58B13187E5478A28");
  setignoremegroup("_encstr_AA680E3B80C1DF23070C5A97E023AA9D", "_encstr_82371509A566C00BCFDAEB31720F4D58B13187E5478A28");
}

decoy_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.set_car_collision = self.name;
  var_0.playersdebuffed = [];
  var_0.juggdroplocations = 0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::decoy_empapplied);
  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var_0);
  thread scripts\cp\cp_weapon::monitordisownedgrenade(self, var_0);
  wait 0.4;
  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 thread scripts\cp\cp_weapon::monitordamage(19, "_encstr_A2FB098A2035874AB0F358", ::decoy_handlefataldamage, ::decoy_handledamage);
  var_0 thread decoy_monitorposition();
  wait 0.6;
  var_1 = gettime() + 5000;
  var_2 = gettime();
  var_3 = 3;

  while(gettime() < var_1) {
    if(gettime() >= var_2) {
      var_2 = gettime() + 200.0;

      if(var_0 decoy_isonground()) {
        var_3--;

        if(var_3 == 0) {
          break;
        }
      } else
        var_3 = 3;
    }

    wait 0.2;
  }

  var_0 thread decoy_monitorfuse();
  var_0 thread decoy_activated();
}

decoy_activated() {
  self endon("_encstr_AD75063D571AE108");
  self setotherent(self.owner);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 = decoy_getfiretype();
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self, "_encstr_BE8B116725FA28FB5178B2CF85017912618763", self.set_car_collision);

  for(;;) {
    decoy_firesequence(var_0);
    wait(randomfloatrange(0.5, 1.5));
  }
}

decoy_destroy() {
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  thread decoy_delete(0.1);
}

decoy_delete(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self notify("_encstr_AD75063D571AE108");
  self.exploding = 1;
  decoy_removefromgloballist(self getentitynumber());
  wait(var_0);
  self delete();
}

decoy_firesequence(var_0) {
  var_1 = decoy_getleveldata();
  var_2 = 1;

  if(var_1.firemaxcounts[var_0] > 0)
    var_2 = var_2 + randomint(var_1.firemaxcounts[var_0]);

  for(;;) {
    var_2--;
    decoy_fireevent(var_0);

    if(var_2 == 0) {
      break;
    }

    wait(randomfloatrange(var_1.fireintervalmintimes[var_0], var_1.fireintervalmaxtimes[var_0]));
  }
}

decoy_fireevent(var_0) {
  var_1 = decoy_getvelocity();
  var_2 = decoy_getfireeventangles(var_1);
  var_3 = decoy_getfireeventimpulse(var_1, var_0, var_2);
  var_4 = self.owner getheldoffhand();

  if(!isDefined(var_4) || var_4.basename != "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B")
    self.owner scripts\cp\utility::_launchgrenade("_encstr_BE8B116725FA28FB5178B2CF85017912618763", self.origin, var_3, 100, 1, self);

  self setCanDamage(1);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_86BD0B20CAC6414813F60386AD", var_0 + "_encstr_88780519B4E495", 0);
  self setscriptablepartstate("_encstr_A5980DD36721C0F0AA1F878BD332C6", var_0 + "_encstr_88780519B4E495", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  scripts\cp\utility::make_entity_sentient_cp(self.team);
  self setthreatbiasgroup("_encstr_AA680E3B80C1DF23070C5A97E023AA9D");
  decoy_debuffenemiesinrange();
  var_5 = decoy_getleveldata();
  wait(var_5.firetimes[var_0]);
}

decoy_debuffenemiesinrange() {
  var_0 = scripts\common\utility::playersincylinder(self.origin, 800);

  foreach(var_2 in var_0) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_2))) {
      continue;
    }
    thread decoy_debuffenemy(var_2);
  }

  var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");

  foreach(var_6 in var_4) {
    if(!isalive(var_6)) {
      continue;
    }
    if(distance2dsquared(var_6.origin, self.origin) > 640000) {
      continue;
    }
    if(var_6 scripts\cp\cp_modular_spawning::is_specified_unittype("_encstr_8EF60E63FBE3D70440A312175B98CF6B")) {
      juggcanusecrate(var_6);
      continue;
    }

    if(jugg_watchearlyexit(var_6)) {
      juggcanusecrate(var_6);
      continue;
    }

    if(jugg_watchammo(var_6)) {
      juggcanusecrate(var_6);
      continue;
    }

    thread decoy_debuffenemy(var_6);
  }
}

jugg_watchearlyexit(var_0) {
  var_1 = 1.5;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(var_0 seerecently(level.players[var_2], var_1))
      return 1;
  }

  return 0;
}

jugg_watchammo(var_0) {
  foreach(var_2 in level.players) {
    if(jugg_watchfordoors(var_0, var_2))
      return 1;
  }

  return 0;
}

jugg_watchfordoors(var_0, var_1) {
  var_2 = var_0 cansee(var_1);

  if(var_2) {
    var_3 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, 1);

    if(!var_3)
      return 0;

    var_4 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_4))
      return 0;

    return 1;
  }

  return 0;
}

juggcanusecrate(var_0) {
  var_0 setthreatbiasgroup("_encstr_82371509A566C00BCFDAEB31720F4D58B13187E5478A28");
}

jugg_watchforfire(var_0) {
  var_1 = var_0 getthreatbiasgroup();

  if(var_1 == "_encstr_82371509A566C00BCFDAEB31720F4D58B13187E5478A28")
    var_0 setthreatbiasgroup("_encstr_8E8405EA382B2A");
}

decoy_debuffenemy(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_87C213C8568D7BF2FA199513EA3399159B56ADCBBE" + var_0 getentitynumber());
  self endon("_encstr_87C213C8568D7BF2FA199513EA3399159B56ADCBBE" + var_0 getentitynumber());
  self endon("_encstr_A9CC1432566CBDF2BEDC3A7B07A84E161BD6B4CDECFA" + var_0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var_0 getentitynumber()])) {
    self.playersdebuffed[var_0 getentitynumber()] = var_0;
    level thread jugg_watchforremovejugg(self, var_0, 10);
    jugg_watchforfire(var_0);
  }

  var_2 = "_encstr_B40101";
  var_0 waittill("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(self))
    self.playersdebuffed[var_0 getentitynumber()] = undefined;

  if(isDefined(var_0.attackers)) {
    foreach(var_4 in var_0.attackers)
    jugg_watchmanualreload(var_4, var_0, var_1);
  } else if(isDefined(var_0.attacker))
    jugg_watchmanualreload(var_0.attacker, var_0, var_1);
}

jugg_watchforremovejugg(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1.chopper_playfx = var_0;
  wait(var_2);
  var_0 notify("_encstr_A9CC1432566CBDF2BEDC3A7B07A84E161BD6B4CDECFA" + var_1 getentitynumber());
}

jugg_watchmanualreload(var_0, var_1, var_2) {
  if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var_0))) {
    return;
  }
  if(var_0 == var_2) {
    return;
  }
  var_3 = var_1.team;

  if(!isDefined(var_1.team) && isDefined(var_1.agentteam))
    var_3 = var_1.agentteam;

  if(isDefined(var_3) && isDefined(var_2.team) && var_3 != var_2.team) {
    if(self.juggdroplocations < 3) {
      var_2 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_81820D2AA0DF6CFFA388447DBEE81F");
      var_2 thread scripts\mp\mp_agent_damage::killeventtextpopup("_encstr_81820D2AA0DF6CFFA388447DBEE81F");
      self.juggdroplocations++;
    }
  }
}

decoy_monitorposition() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = self.origin;
    waitframe();
    self.oldposition = var_0;
  }
}

decoy_monitorfuse() {
  self endon("_encstr_AD75063D571AE108");
  wait 7;
  thread decoy_destroy();
}

decoy_empapplied(var_0) {
  var_0.victim decoy_givepointsfordestroy(var_0.attacker);
  var_0.victim thread decoy_destroy();
}

decoy_handledamage(var_0) {
  return var_0.damage;
}

decoy_handlefataldamage(var_0) {
  decoy_givepointsfordestroy(var_0.attacker);
  thread decoy_destroy();
}

decoy_getfiretype() {
  var_1 = 0;
  var_2 = [];
  var_3 = decoy_getleveldata();

  for(var_4 = 0; var_4 < var_3.firetypes.size; var_4++) {
    var_5 = var_3.firetypes[var_4];
    var_1 = var_1 + var_3.firetypeweights[var_5];
    var_2[var_4] = var_1;
  }

  var_6 = randomint(var_1);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_6 < var_2[var_4])
      return var_3.firetypes[var_4];
  }

  return undefined;
}

decoy_getvelocity() {
  if(!isDefined(self.oldposition))
    return undefined;

  return (self.origin - self.oldposition) / level.framedurationseconds;
}

decoy_getfireeventangles(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    var_1 = (0, randomint(360), 0);
  else if(var_0 * (1, 1, 0) == (0, 0, 0))
    var_1 = (0, randomint(360), 0);
  else if(randomint(100) < 20)
    var_1 = (0, randomint(360), 0);
  else {
    var_1 = vectortoangles(var_0 * (1, 1, 0));
    var_2 = angleclamp180(var_1[1]);
    var_2 = var_2 + angleclamp(-30.0 + randomint(61));
    var_1 = (var_1[0], var_2, var_1[2]);
  }

  return var_1;
}

decoy_getfireeventimpulse(var_0, var_1, var_2) {
  var_3 = decoy_getleveldata();
  var_4 = var_0;
  var_4 = var_4 + anglestoup(var_2) * randomfloatrange(var_3.fireminupimpulse[var_1], var_3.firemaxupimpulse[var_1]);
  var_4 = var_4 + anglesToForward(var_2) * randomfloatrange(var_3.fireminforwardimpulse[var_1], var_3.firemaxforwardimpulse[var_1]);
  return var_4;
}

decoy_isonground() {
  var_0 = decoy_getvelocity();

  if(!isDefined(var_0) || abs(var_0[2]) <= 200) {
    if(decoy_isongroundraycastonly())
      return 1;
  }

  return 0;
}

decoy_isongroundraycastonly() {
  var_0 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  var_1 = self.origin + (0, 0, 1);
  var_2 = var_1 + (0, 0, -5);
  var_3 = physics_raycast(var_1, var_2, var_0, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_3) && var_3.size > 0)
    return 1;

  return 0;
}

decoy_givepointsfordestroy(var_0) {
  if(isDefined(var_0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0)))
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
}

decoy_addtogloballist(var_0) {
  level.decoygrenades[var_0 getentitynumber()] = var_0;
}

decoy_removefromgloballist(var_0) {
  level.decoygrenades[var_0] = undefined;
}

decoy_getleveldata() {
  return level.decoygrenadedata;
}