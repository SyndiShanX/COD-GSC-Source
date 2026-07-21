/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\decoy_grenade.gsc
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
  var_0.firemaxcounts["_encstr_AD07034A38"] = 3;
  var_0.fireintervalmintimes["_encstr_AD07034A38"] = 0.5;
  var_0.fireintervalmaxtimes["_encstr_AD07034A38"] = 2;
  var_0.fireminupimpulse["_encstr_AD07034A38"] = 175;
  var_0.firemaxupimpulse["_encstr_AD07034A38"] = 225;
  var_0.fireminforwardimpulse["_encstr_AD07034A38"] = 55;
  var_0.firemaxforwardimpulse["_encstr_AD07034A38"] = 125;
  var_0.firetypes[var_0.firetypes.size] = "_encstr_BE1904DCDA9D";
  var_0.firetypeweights["_encstr_BE1904DCDA9D"] = 50;
  var_0.firetimes["_encstr_BE1904DCDA9D"] = 0.4;
  var_0.firemaxcounts["_encstr_BE1904DCDA9D"] = 4;
  var_0.fireintervalmintimes["_encstr_BE1904DCDA9D"] = 0.25;
  var_0.fireintervalmaxtimes["_encstr_BE1904DCDA9D"] = 1;
  var_0.fireminupimpulse["_encstr_BE1904DCDA9D"] = 80;
  var_0.firemaxupimpulse["_encstr_BE1904DCDA9D"] = 125;
  var_0.fireminforwardimpulse["_encstr_BE1904DCDA9D"] = 175;
  var_0.firemaxforwardimpulse["_encstr_BE1904DCDA9D"] = 265;
  var_0.firetypes[var_0.firetypes.size] = "_encstr_850707F7E5833355B8";
  var_0.firetypeweights["_encstr_850707F7E5833355B8"] = 15;
  var_0.firetimes["_encstr_850707F7E5833355B8"] = 0.4;
  var_0.firemaxcounts["_encstr_850707F7E5833355B8"] = 2;
  var_0.fireintervalmintimes["_encstr_850707F7E5833355B8"] = 1;
  var_0.fireintervalmaxtimes["_encstr_850707F7E5833355B8"] = 3;
  var_0.fireminupimpulse["_encstr_850707F7E5833355B8"] = 250;
  var_0.firemaxupimpulse["_encstr_850707F7E5833355B8"] = 375;
  var_0.fireminforwardimpulse["_encstr_850707F7E5833355B8"] = 0;
  var_0.firemaxforwardimpulse["_encstr_850707F7E5833355B8"] = 60;
  var_0.light_tank_watchmissileinputchange = getdvarint("_encstr_BAA51A53AE53670FDB10F26B096D4AAF4903CBFDBE98D3558740FA83", 1);
  var_0.light_tank_watchgameend = getdvarint("_encstr_A3661BAB669BAFD703D84A23512502F7F1DB033506C0AB1D4F9852DAD0", 4);
}

decoy_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\mp\utility\print::printgameaction("_encstr_BA8714B5BDC668F7AEF2EACB48CA243536D35087BC0D", var_0.owner);
  var_0.playersdebuffed = [];
  var_0.juggdroplocations = 0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::decoy_empapplied);
  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var_0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  wait 0.4;
  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 thread scripts\mp\damage::monitordamage(19, "_encstr_A2FB098A2035874AB0F358", ::decoy_handlefataldamage, ::decoy_handledamage);
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

  for(;;) {
    decoy_firesequence(var_0);
    wait(randomfloatrange(1.5, 3.5));
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
  scripts\mp\damage::monitordamageend();
  wait(var_0);
  self delete();
}

decoy_firesequence(var_0) {
  var_1 = decoy_getleveldata();
  var_2 = 1 + randomint(var_1.firemaxcounts[var_0]);

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
    self.owner scripts\mp\utility\weapon::_launchgrenade("_encstr_BE8B116725FA28FB5178B2CF85017912618763", self.origin, var_3, 100, 1, self);

  self setCanDamage(1);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_86BD0B20CAC6414813F60386AD", var_0 + "_encstr_88780519B4E495", 0);
  self setscriptablepartstate("_encstr_A5980DD36721C0F0AA1F878BD332C6", var_0 + "_encstr_88780519B4E495", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  decoy_debuffenemiesinrange();
  var_5 = decoy_getleveldata();
  wait(var_5.firetimes[var_0]);
}

decoy_debuffenemiesinrange() {
  var_0 = decoy_getleveldata();
  var_1 = scripts\common\utility::playersincylinder(self.origin, 800);
  var_2 = 0;

  if(getdvarint("_encstr_BEEB1EEB5F08493315C1422B2EEE9331F8D97C4FDFB9CFEFCA39E8D270478F77", 1) == 1) {
    if(scripts\mp\utility\game::unset_relic_grounded())
      var_2 = 1;
  }

  foreach(var_4 in var_1) {
    if(!var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_4))) {
      continue;
    }
    thread decoy_debuffenemy(var_4);

    if(var_2) {
      var_5 = randomintrange(var_0.light_tank_watchmissileinputchange, var_0.light_tank_watchgameend);

      if(var_5 == 1)
        thread jugg_watchherodrop(var_4);
    }

    self.owner scripts\mp\damage::combatrecordtacticalstat("_encstr_8B0E0CAC5CAB4B38FA46566CBDF2");
    self.owner scripts\mp\utility\stats::incpersstat("_encstr_B6960A91CA36F69742D23A37", 1);
  }
}

decoy_debuffenemy(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_87C213C8568D7BF2FA199513EA3399159B56ADCBBE" + var_0 getentitynumber());
  self endon("_encstr_87C213C8568D7BF2FA199513EA3399159B56ADCBBE" + var_0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var_0 getentitynumber()]))
    self.playersdebuffed[var_0 getentitynumber()] = var_0;

  var_2 = var_0 scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AD75063D571AE108", 5);
  self.playersdebuffed[var_0 getentitynumber()] = undefined;

  if(isDefined(var_0.lastkilledby) && var_0.lastkilledby != var_1) {
    if(var_2 == "_encstr_AD75063D571AE108" && scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_1)) {
      if(self.juggdroplocations < 3) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_81820D2AA0DF6CFFA388447DBEE81F");
        self.juggdroplocations++;
      }
    }
  }
}

jugg_watchherodrop(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_1 = self.owner;
  var_2 = self.origin;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_ABC10CC616CDA3D799C2B436ACC8");
  var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_4 = var_2;
  var_5 = var_0 getEye();
  var_6 = physics_raycast(var_4, var_5, var_3, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_6) && var_6.size > 0)
    self notify("_encstr_ABC10CC616CDA3D799C2B436ACC8");

  var_0 playsoundtoplayer("_encstr_B19A1DC007BC400383690E19FE5A496E1EDB70D09B779BDFCB0A080892B2BD", var_0);
  var_0.donotmodifydamage = 1;
  var_0 dodamage(1, var_2, self);
  var_0.donotmodifydamage = undefined;
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
  wait 15;
  thread decoy_destroy();
}

decoy_empapplied(var_0) {
  var_0.victim decoy_givepointsfordestroy(var_0.attacker);
  var_0.victim thread decoy_destroy();
}

decoy_handledamage(var_0) {
  scripts\mp\weapons::equipmenthit(self.owner, var_0.attacker, var_0.objweapon, var_0.meansofdeath);
  return var_0.damage;
}

decoy_handlefataldamage(var_0) {
  decoy_givepointsfordestroy(var_0.attacker, var_0.objweapon);
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

decoy_givepointsfordestroy(var_0, var_1) {
  if(isDefined(var_0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_1);
  }
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