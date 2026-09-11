/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_jugg.gsc
***********************************************/

function decoy_init() {
  level.decoygrenades = [];
  var0 = spawnStruct();
  level.decoygrenadedata = var0;
  var0.firetypes = [];
  var0.firetypeweights = [];
  var0.firetimes = [];
  var0.firemaxcounts = [];
  var0.fireintervalmintimes = [];
  var0.fireintervalmaxtimes = [];
  var0.fireminupimpulse = [];
  var0.firemaxupimpulse = [];
  var0.fireminforwardimpulse = [];
  var0.firemaxforwardimpulse = [];
  var0.firetypes[var0.firetypes.size] = "ar";
  var0.firetypeweights["ar"] = 35;
  var0.firetimes["ar"] = 0.4;
  var0.firemaxcounts["ar"] = 0;
  var0.fireintervalmintimes["ar"] = 0.5;
  var0.fireintervalmaxtimes["ar"] = 2;
  var0.fireminupimpulse["ar"] = 175;
  var0.firemaxupimpulse["ar"] = 225;
  var0.fireminforwardimpulse["ar"] = 55;
  var0.firemaxforwardimpulse["ar"] = 125;
  var0.firetypes[var0.firetypes.size] = "smg";
  var0.firetypeweights["smg"] = 50;
  var0.firetimes["smg"] = 0.4;
  var0.firemaxcounts["smg"] = 0;
  var0.fireintervalmintimes["smg"] = 0.25;
  var0.fireintervalmaxtimes["smg"] = 1;
  var0.fireminupimpulse["smg"] = 80;
  var0.firemaxupimpulse["smg"] = 125;
  var0.fireminforwardimpulse["smg"] = 175;
  var0.firemaxforwardimpulse["smg"] = 265;
  var0.firetypes[var0.firetypes.size] = "sniper";
  var0.firetypeweights["sniper"] = 15;
  var0.firetimes["sniper"] = 0.4;
  var0.firemaxcounts["sniper"] = 0;
  var0.fireintervalmintimes["sniper"] = 1;
  var0.fireintervalmaxtimes["sniper"] = 3;
  var0.fireminupimpulse["sniper"] = 250;
  var0.firemaxupimpulse["sniper"] = 375;
  var0.fireminforwardimpulse["sniper"] = 0;
  var0.firemaxforwardimpulse["sniper"] = 60;

  if(!threatbiasgroupexists("axis")) {
    createthreatbiasgroup("axis");
  }

  createthreatbiasgroup("decoy_grenade");
  createthreatbiasgroup("decoy_grenade_ignore");
  setignoremegroup("decoy_grenade", "decoy_grenade_ignore");
}

function decoy_used(var0) {
  var0 endon("death");
  var0.set_car_collision = self.name;
  var0.playersdebuffed = [];
  var0.juggdroplocations = 0;
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&decoy_empapplied);
  var0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var0);
  thread scripts\cp\cp_weapon::monitordisownedgrenade(self, var0);
  wait 0.4;
  var0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var0 thread scripts\cp\cp_weapon::monitordamage(19, "hitequip", &decoy_handlefataldamage, &decoy_handledamage);
  thread decoy_monitorposition();
  wait 0.6;
  var1 = gettime() + 5000;
  var2 = gettime();
  var3 = 3;

  while(gettime() < var1) {
    if(gettime() >= var2) {
      var2 = gettime() + 200;

      if(decoy_isonground(var0)) {
        var3--;
      } else {
        var3 = 3;
      }
    }

    wait 0.2;
  }

  LOC_000000d2:
    thread decoy_monitorfuse();
  thread decoy_activated();
}

function decoy_activated() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  var0 = decoy_getfiretype();
  level notify("grenade_exploded_during_stealth", self, "decoy_grenade_mp", self.set_car_collision);

  for(;;) {
    decoy_firesequence(var0);
    wait randomfloatrange(0.5, 1.5);
  }
}

function decoy_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread decoy_delete(0.1);
}

function decoy_delete(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  self notify("death");
  self.exploding = 1;
  decoy_removefromgloballist(self getentitynumber());
  wait var0;
  self delete();
}

function decoy_firesequence(var0) {
  var1 = decoy_getleveldata();
  var2 = 1;

  if(var1.firemaxcounts[var0] > 0) {
    var2 += randomint(var1.firemaxcounts[var0]);
  }

  for(;;) {
    var2--;
    decoy_fireevent(var0);

    if(var2 == 0) {
      break;
    }

    wait randomfloatrange(var1.fireintervalmintimes[var0], var1.fireintervalmaxtimes[var0]);
  }
}

function decoy_fireevent(var0) {
  var1 = decoy_getvelocity();
  var2 = decoy_getfireeventangles(var1);
  var3 = decoy_getfireeventimpulse(var1, var0, var2);
  var4 = self.owner getheldoffhand();

  if(!isDefined(var4) || var4.basename != "frag_grenade_mp") {
    self.owner scripts\cp\utility::_launchgrenade("decoy_grenade_mp", self.origin, var3, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", var0 + "Fire", 0);
  self setscriptablepartstate("weaponSounds", var0 + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  scripts\cp\utility::make_entity_sentient_cp(self.team);
  self setthreatbiasgroup("decoy_grenade");
  decoy_debuffenemiesinrange();
  var5 = decoy_getleveldata();
  wait var5.firetimes[var0];
}

function decoy_debuffenemiesinrange() {
  var0 = scripts\common\utility::playersincylinder(self.origin, 800);

  foreach(var2 in var0) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var2))) {
      continue;
    }

    thread decoy_debuffenemy(var2);
  }

  var4 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");

  foreach(var6 in var4) {
    if(!isalive(var6)) {
      continue;
    }

    if(distance2dsquared(var6.origin, self.origin) > 640000) {
      continue;
    }

    if(var6 scripts\cp\cp_modular_spawning::is_specified_unittype("suicidebomber")) {
      juggcanusecrate(var6);
      continue;
    }

    if(jugg_watchearlyexit(var6)) {
      juggcanusecrate(var6);
      continue;
    }

    if(jugg_watchammo(var6)) {
      juggcanusecrate(var6);
      continue;
    }

    thread decoy_debuffenemy(var6);
  }
}

function jugg_watchearlyexit(var0) {
  var1 = 1.5;

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(var0 seerecently(level.players[var2], var1)) {
      return true;
    }
  }

  return false;
}

function jugg_watchammo(var0) {
  foreach(var2 in level.players) {
    if(jugg_watchfordoors(var0, var2)) {
      return true;
    }
  }

  return false;
}

function jugg_watchfordoors(var0, var1) {
  var2 = var0 cansee(var1);

  if(var2) {
    var3 = sighttracepassed(var0 getEye(), var1 getEye(), 0, var0, 1);

    if(!var3) {
      return false;
    }

    var4 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var0 getEye(), var1 getEye(), var0, var4)) {
      return false;
    }

    return true;
  }

  return false;
}

function juggcanusecrate(var0) {
  var0 setthreatbiasgroup("decoy_grenade_ignore");
}

function jugg_watchforfire(var0) {
  var1 = var0 getthreatbiasgroup();

  if(var1 == "decoy_grenade_ignore") {
    var0 setthreatbiasgroup("axis");
    return;
  }
}

function decoy_debuffenemy(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = self.owner;
  var1 endon("disconnect");
  self notify("decoy_debuffEnemy_" + var0 getentitynumber());
  self endon("decoy_debuffEnemy_" + var0 getentitynumber());
  self endon("decoy_stopTracking_" + var0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var0 getentitynumber()])) {
    self.playersdebuffed[var0 getentitynumber()] = var0;
    thread jugg_watchforremovejugg(level, self, var0);
    jugg_watchforfire(var0);
  }

  var2 = "";
  var0 waittill("death");
  waitframe();

  if(isDefined(self)) {
    self.playersdebuffed[var0 getentitynumber()] = undefined;
  }

  if(isDefined(var0.attackers)) {
    foreach(var4 in var0.attackers) {
      jugg_watchmanualreload(var4, var0, var1);
    }

    return;
  }

  if(isDefined(var0.attacker)) {
    jugg_watchmanualreload(var0.attacker, var0, var1);
    return;
  }
}

function jugg_watchforremovejugg(var0, var1, var2) {
  level endon("game_ended");
  var1 endon("death");
  var0 endon("death");
  var1.chopper_playfx = var0;
  wait var2;
  var0 notify("decoy_stopTracking_" + var1 getentitynumber());
}

function jugg_watchmanualreload(var0, var1, var2) {
  if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var0))) {
    return;
  }

  if(var0 == var2) {
    return;
  }

  var3 = var1.team;

  if(!isDefined(var1.team) && isDefined(var1.agentteam)) {
    var3 = var1.agentteam;
  }

  if(isDefined(var3) && isDefined(var2.team) && var3 != var2.team) {
    if(self.juggdroplocations < 3) {
      var2 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist_decoy");
      var2 thread scripts\mp\mp_agent_damage::killeventtextpopup("assist_decoy");
      self.juggdroplocations++;
      return;
    }

    return;
  }
}

function decoy_monitorposition() {
  self endon("death");

  for(;;) {
    var0 = self.origin;
    waitframe();
    self.oldposition = var0;
  }
}

function decoy_monitorfuse() {
  self endon("death");
  wait 7;
  thread decoy_destroy();
}

function decoy_empapplied(var0) {
  decoy_givepointsfordestroy(var0.victim, var0.attacker);
  thread decoy_destroy();
}

function decoy_handledamage(var0) {
  return var0.damage;
}

function decoy_handlefataldamage(var0) {
  decoy_givepointsfordestroy(var0.attacker);
  thread decoy_destroy();
}

function decoy_getfiretype() {
  var1 = 0;
  var2 = [];
  var3 = decoy_getleveldata();

  for(var4 = 0; var4 < var3.firetypes.size; var4++) {
    var5 = var3.firetypes[var4];
    var1 += var3.firetypeweights[var5];
    var2 = var1;
  }

  var6 = randomint(var1);

  for(var4 = 0; var4 < var2.size; var4++) {
    if(var6 < var2[var4]) {
      return var3.firetypes[var4];
    }
  }

  return undefined;
}

function decoy_getvelocity() {
  if(!isDefined(self.oldposition)) {
    return undefined;
  }

  return (self.origin - self.oldposition) / level.framedurationseconds;
}

function decoy_getfireeventangles(var0) {
  var1 = undefined;

  if(!isDefined(var0)) {
    var1 = (0, randomint(360), 0);
  } else if(var0 * (1, 1, 0) == (0, 0, 0)) {
    var1 = (0, randomint(360), 0);
  } else if(randomint(100) < 20) {
    var1 = (0, randomint(360), 0);
  } else {
    var1 = vectortoangles(var0 * (1, 1, 0));
    var2 = angleclamp180(var1[1]);
    var2 += angleclamp(-30 + randomint(61));
    var1 = (var1[0], var2, var1[2]);
  }

  return var1;
}

function decoy_getfireeventimpulse(var0, var1, var2) {
  var3 = decoy_getleveldata();
  var4 = var0;
  var4 += anglestoup(var2) * randomfloatrange(var3.fireminupimpulse[var1], var3.firemaxupimpulse[var1]);
  var4 += anglesToForward(var2) * randomfloatrange(var3.fireminforwardimpulse[var1], var3.firemaxforwardimpulse[var1]);
  return var4;
}

function decoy_isonground() {
  var0 = decoy_getvelocity();

  if(!isDefined(var0) || abs(var0[2]) <= 200) {
    if(decoy_isongroundraycastonly()) {
      return true;
    }
  }

  return false;
}

function decoy_isongroundraycastonly() {
  var0 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  var1 = self.origin + (0, 0, 1);
  var2 = var1 + (0, 0, -5);
  var3 = physics_raycast(var1, var2, var0, self, 0, "physicsquery_closest", 1);

  if(isDefined(var3) && var3.size > 0) {
    return true;
  }

  return false;
}

function decoy_givepointsfordestroy(var0) {
  if(isDefined(var0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");
    return;
  }
}

function decoy_addtogloballist(var0) {
  level.decoygrenades[var0 getentitynumber()] = var0;
}

function decoy_removefromgloballist(var0) {
  level.decoygrenades[var0] = undefined;
}

function decoy_getleveldata() {
  return level.decoygrenadedata;
}