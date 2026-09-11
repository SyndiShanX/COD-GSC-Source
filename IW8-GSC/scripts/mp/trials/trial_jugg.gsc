/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_jugg.gsc
***********************************************/

function decoy_init() {
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
  var_0.firetypes[var_0.firetypes.size] = "ar";
  var_0.firetypeweights["ar"] = 35;
  var_0.firetimes["ar"] = 0.4;
  var_0.firemaxcounts["ar"] = 0;
  var_0.fireintervalmintimes["ar"] = 0.5;
  var_0.fireintervalmaxtimes["ar"] = 2;
  var_0.fireminupimpulse["ar"] = 175;
  var_0.firemaxupimpulse["ar"] = 225;
  var_0.fireminforwardimpulse["ar"] = 55;
  var_0.firemaxforwardimpulse["ar"] = 125;
  var_0.firetypes[var_0.firetypes.size] = "smg";
  var_0.firetypeweights["smg"] = 50;
  var_0.firetimes["smg"] = 0.4;
  var_0.firemaxcounts["smg"] = 0;
  var_0.fireintervalmintimes["smg"] = 0.25;
  var_0.fireintervalmaxtimes["smg"] = 1;
  var_0.fireminupimpulse["smg"] = 80;
  var_0.firemaxupimpulse["smg"] = 125;
  var_0.fireminforwardimpulse["smg"] = 175;
  var_0.firemaxforwardimpulse["smg"] = 265;
  var_0.firetypes[var_0.firetypes.size] = "sniper";
  var_0.firetypeweights["sniper"] = 15;
  var_0.firetimes["sniper"] = 0.4;
  var_0.firemaxcounts["sniper"] = 0;
  var_0.fireintervalmintimes["sniper"] = 1;
  var_0.fireintervalmaxtimes["sniper"] = 3;
  var_0.fireminupimpulse["sniper"] = 250;
  var_0.firemaxupimpulse["sniper"] = 375;
  var_0.fireminforwardimpulse["sniper"] = 0;
  var_0.firemaxforwardimpulse["sniper"] = 60;

  if(!threatbiasgroupexists("axis")) {
    createthreatbiasgroup("axis");
  }

  createthreatbiasgroup("decoy_grenade");
  createthreatbiasgroup("decoy_grenade_ignore");
  setignoremegroup("decoy_grenade", "decoy_grenade_ignore");
}

function decoy_used(var_0) {
  var_0 endon("death");
  var_0.set_car_collision = self.name;
  var_0.playersdebuffed = [];
  var_0.juggdroplocations = 0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&decoy_empapplied);
  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var_0);
  thread scripts\cp\cp_weapon::monitordisownedgrenade(self, var_0);
  wait 0.4;
  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 thread scripts\cp\cp_weapon::monitordamage(19, "hitequip", &decoy_handlefataldamage, &decoy_handledamage);
  thread decoy_monitorposition();
  wait 0.6;
  var_1 = gettime() + 5000;
  var_2 = gettime();
  var_3 = 3;

  while(gettime() < var_1) {
    if(gettime() >= var_2) {
      var_2 = gettime() + 200;

      if(decoy_isonground(var_0)) {
        var_3--;
      } else {
        var_3 = 3;
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
  var_0 = decoy_getfiretype();
  level notify("grenade_exploded_during_stealth", self, "decoy_grenade_mp", self.set_car_collision);

  for(;;) {
    decoy_firesequence(var_0);
    wait randomfloatrange(0.5, 1.5);
  }
}

function decoy_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread decoy_delete(0.1);
}

function decoy_delete(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self notify("death");
  self.exploding = 1;
  decoy_removefromgloballist(self getentitynumber());
  wait var_0;
  self delete();
}

function decoy_firesequence(var_0) {
  var_1 = decoy_getleveldata();
  var_2 = 1;

  if(var_1.firemaxcounts[var_0] > 0) {
    var_2 += randomint(var_1.firemaxcounts[var_0]);
  }

  for(;;) {
    var_2--;
    decoy_fireevent(var_0);

    if(var_2 == 0) {
      break;
    }

    wait randomfloatrange(var_1.fireintervalmintimes[var_0], var_1.fireintervalmaxtimes[var_0]);
  }
}

function decoy_fireevent(var_0) {
  var_1 = decoy_getvelocity();
  var_2 = decoy_getfireeventangles(var_1);
  var_3 = decoy_getfireeventimpulse(var_1, var_0, var_2);
  var_4 = self.owner getheldoffhand();

  if(!isDefined(var_4) || var_4.basename != "frag_grenade_mp") {
    self.owner scripts\cp\utility::_launchgrenade("decoy_grenade_mp", self.origin, var_3, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", var_0 + "Fire", 0);
  self setscriptablepartstate("weaponSounds", var_0 + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  scripts\cp\utility::make_entity_sentient_cp(self.team);
  self setthreatbiasgroup("decoy_grenade");
  decoy_debuffenemiesinrange();
  var_5 = decoy_getleveldata();
  wait var_5.firetimes[var_0];
}

function decoy_debuffenemiesinrange() {
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

  var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");

  foreach(var_6 in var_4) {
    if(!isalive(var_6)) {
      continue;
    }

    if(distance2dsquared(var_6.origin, self.origin) > 640000) {
      continue;
    }

    if(var_6 scripts\cp\cp_modular_spawning::is_specified_unittype("suicidebomber")) {
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

function jugg_watchearlyexit(var_0) {
  var_1 = 1.5;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(var_0 seerecently(level.players[var_2], var_1)) {
      return true;
    }
  }

  return false;
}

function jugg_watchammo(var_0) {
  foreach(var_2 in level.players) {
    if(jugg_watchfordoors(var_0, var_2)) {
      return true;
    }
  }

  return false;
}

function jugg_watchfordoors(var_0, var_1) {
  var_2 = var_0 cansee(var_1);

  if(var_2) {
    var_3 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, 1);

    if(!var_3) {
      return false;
    }

    var_4 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_4)) {
      return false;
    }

    return true;
  }

  return false;
}

function juggcanusecrate(var_0) {
  var_0 setthreatbiasgroup("decoy_grenade_ignore");
}

function jugg_watchforfire(var_0) {
  var_1 = var_0 getthreatbiasgroup();

  if(var_1 == "decoy_grenade_ignore") {
    var_0 setthreatbiasgroup("axis");
    return;
  }
}

function decoy_debuffenemy(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = self.owner;
  var_1 endon("disconnect");
  self notify("decoy_debuffEnemy_" + var_0 getentitynumber());
  self endon("decoy_debuffEnemy_" + var_0 getentitynumber());
  self endon("decoy_stopTracking_" + var_0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var_0 getentitynumber()])) {
    self.playersdebuffed[var_0 getentitynumber()] = var_0;
    thread jugg_watchforremovejugg(level, self, var_0);
    jugg_watchforfire(var_0);
  }

  var_2 = "";
  var_0 waittill("death");
  waitframe();

  if(isDefined(self)) {
    self.playersdebuffed[var_0 getentitynumber()] = undefined;
  }

  if(isDefined(var_0.attackers)) {
    foreach(var_4 in var_0.attackers) {
      jugg_watchmanualreload(var_4, var_0, var_1);
    }

    return;
  }

  if(isDefined(var_0.attacker)) {
    jugg_watchmanualreload(var_0.attacker, var_0, var_1);
    return;
  }
}

function jugg_watchforremovejugg(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("death");
  var_0 endon("death");
  var_1.chopper_playfx = var_0;
  wait var_2;
  var_0 notify("decoy_stopTracking_" + var_1 getentitynumber());
}

function jugg_watchmanualreload(var_0, var_1, var_2) {
  if(!isDefined(scripts\cp\cp_agent_damage::_validateattacker(var_0))) {
    return;
  }

  if(var_0 == var_2) {
    return;
  }

  var_3 = var_1.team;

  if(!isDefined(var_1.team) && isDefined(var_1.agentteam)) {
    var_3 = var_1.agentteam;
  }

  if(isDefined(var_3) && isDefined(var_2.team) && var_3 != var_2.team) {
    if(self.juggdroplocations < 3) {
      var_2 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist_decoy");
      var_2 thread scripts\mp\mp_agent_damage::killeventtextpopup("assist_decoy");
      self.juggdroplocations++;
      return;
    }

    return;
  }
}

function decoy_monitorposition() {
  self endon("death");

  for(;;) {
    var_0 = self.origin;
    waitframe();
    self.oldposition = var_0;
  }
}

function decoy_monitorfuse() {
  self endon("death");
  wait 7;
  thread decoy_destroy();
}

function decoy_empapplied(var_0) {
  decoy_givepointsfordestroy(var_0.victim, var_0.attacker);
  thread decoy_destroy();
}

function decoy_handledamage(var_0) {
  return var_0.damage;
}

function decoy_handlefataldamage(var_0) {
  decoy_givepointsfordestroy(var_0.attacker);
  thread decoy_destroy();
}

function decoy_getfiretype() {
  var_1 = 0;
  var_2 = [];
  var_3 = decoy_getleveldata();

  for(var_4 = 0; var_4 < var_3.firetypes.size; var_4++) {
    var_5 = var_3.firetypes[var_4];
    var_1 += var_3.firetypeweights[var_5];
    var_2 = var_1;
  }

  var_6 = randomint(var_1);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_6 < var_2[var_4]) {
      return var_3.firetypes[var_4];
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

function decoy_getfireeventangles(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    var_1 = (0, randomint(360), 0);
  } else if(var_0 * (1, 1, 0) == (0, 0, 0)) {
    var_1 = (0, randomint(360), 0);
  } else if(randomint(100) < 20) {
    var_1 = (0, randomint(360), 0);
  } else {
    var_1 = vectortoangles(var_0 * (1, 1, 0));
    var_2 = angleclamp180(var_1[1]);
    var_2 += angleclamp(-30 + randomint(61));
    var_1 = (var_1[0], var_2, var_1[2]);
  }

  return var_1;
}

function decoy_getfireeventimpulse(var_0, var_1, var_2) {
  var_3 = decoy_getleveldata();
  var_4 = var_0;
  var_4 += anglestoup(var_2) * randomfloatrange(var_3.fireminupimpulse[var_1], var_3.firemaxupimpulse[var_1]);
  var_4 += anglesToForward(var_2) * randomfloatrange(var_3.fireminforwardimpulse[var_1], var_3.firemaxforwardimpulse[var_1]);
  return var_4;
}

function decoy_isonground() {
  var_0 = decoy_getvelocity();

  if(!isDefined(var_0) || abs(var_0[2]) <= 200) {
    if(decoy_isongroundraycastonly()) {
      return true;
    }
  }

  return false;
}

function decoy_isongroundraycastonly() {
  var_0 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  var_1 = self.origin + (0, 0, 1);
  var_2 = var_1 + (0, 0, -5);
  var_3 = physics_raycast(var_1, var_2, var_0, self, 0, "physicsquery_closest", 1);

  if(isDefined(var_3) && var_3.size > 0) {
    return true;
  }

  return false;
}

function decoy_givepointsfordestroy(var_0) {
  if(isDefined(var_0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    return;
  }
}

function decoy_addtogloballist(var_0) {
  level.decoygrenades[var_0 getentitynumber()] = var_0;
}

function decoy_removefromgloballist(var_0) {
  level.decoygrenades[var_0] = undefined;
}

function decoy_getleveldata() {
  return level.decoygrenadedata;
}