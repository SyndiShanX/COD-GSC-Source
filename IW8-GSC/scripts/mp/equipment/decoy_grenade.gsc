/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\decoy_grenade.gsc
**************************************************/

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
  var_0.firemaxcounts["ar"] = 3;
  var_0.fireintervalmintimes["ar"] = 0.5;
  var_0.fireintervalmaxtimes["ar"] = 2;
  var_0.fireminupimpulse["ar"] = 175;
  var_0.firemaxupimpulse["ar"] = 225;
  var_0.fireminforwardimpulse["ar"] = 55;
  var_0.firemaxforwardimpulse["ar"] = 125;
  var_0.firetypes[var_0.firetypes.size] = "smg";
  var_0.firetypeweights["smg"] = 50;
  var_0.firetimes["smg"] = 0.4;
  var_0.firemaxcounts["smg"] = 4;
  var_0.fireintervalmintimes["smg"] = 0.25;
  var_0.fireintervalmaxtimes["smg"] = 1;
  var_0.fireminupimpulse["smg"] = 80;
  var_0.firemaxupimpulse["smg"] = 125;
  var_0.fireminforwardimpulse["smg"] = 175;
  var_0.firemaxforwardimpulse["smg"] = 265;
  var_0.firetypes[var_0.firetypes.size] = "sniper";
  var_0.firetypeweights["sniper"] = 15;
  var_0.firetimes["sniper"] = 0.4;
  var_0.firemaxcounts["sniper"] = 2;
  var_0.fireintervalmintimes["sniper"] = 1;
  var_0.fireintervalmaxtimes["sniper"] = 3;
  var_0.fireminupimpulse["sniper"] = 250;
  var_0.firemaxupimpulse["sniper"] = 375;
  var_0.fireminforwardimpulse["sniper"] = 0;
  var_0.firemaxforwardimpulse["sniper"] = 60;
  var_0.light_tank_watchmissileinputchange = getdvarint("scr_decoy_BR_diceroll_low", 1);
  var_0.light_tank_watchgameend = getdvarint("scr_decoy_BR_diceroll_high", 4);
}

function decoy_used(var_0) {
  var_0 endon("death");
  scripts\mp\utility\print::printgameaction("decoy grenade spawn", var_0.owner);
  var_0.playersdebuffed = [];
  var_0.juggdroplocations = 0;
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&decoy_empapplied);
  var_0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var_0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  wait 0.4;
  var_0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var_0 thread scripts\mp\damage::monitordamage(19, "hitequip", &decoy_handlefataldamage, &decoy_handledamage);
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

  LOC_000000d7:
    thread decoy_monitorfuse();
  thread decoy_activated();
}

function decoy_activated() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  var_0 = decoy_getfiretype();

  for(;;) {
    decoy_firesequence(var_0);
    wait randomfloatrange(1.5, 3.5);
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
  scripts\mp\damage::monitordamageend();
  wait var_0;
  self delete();
}

function decoy_firesequence(var_0) {
  var_1 = decoy_getleveldata();
  var_2 = 1 + randomint(var_1.firemaxcounts[var_0]);

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
    self.owner scripts\mp\utility\weapon::_launchgrenade("decoy_grenade_mp", self.origin, var_3, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", var_0 + "Fire", 0);
  self setscriptablepartstate("weaponSounds", var_0 + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  decoy_debuffenemiesinrange();
  var_5 = decoy_getleveldata();
  wait var_5.firetimes[var_0];
}

function decoy_debuffenemiesinrange() {
  var_0 = decoy_getleveldata();
  var_1 = scripts\common\utility::playersincylinder(self.origin, 800);
  var_2 = 0;

  if(getdvarint("scr_decoy_BR_allow_fakeDamage", 1) == 1) {
    if(scripts\mp\utility\game::unset_relic_grounded()) {
      var_2 = 1;
    }
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

      if(var_5 == 1) {
        thread jugg_watchherodrop(var_4);
      }
    }

    self.owner scripts\mp\damage::combatrecordtacticalstat("equip_decoy");
    self.owner scripts\mp\utility\stats::incpersstat("decoyHits", 1);
  }
}

function decoy_debuffenemy(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  var_1 = self.owner;
  var_1 endon("disconnect");
  self notify("decoy_debuffEnemy_" + var_0 getentitynumber());
  self endon("decoy_debuffEnemy_" + var_0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var_0 getentitynumber()])) {
    self.playersdebuffed[var_0 getentitynumber()] = var_0;
  }

  var_2 = var_0 scripts\engine\utility::waittill_notify_or_timeout_return("death", 5);
  self.playersdebuffed[var_0 getentitynumber()] = undefined;

  if(isDefined(var_0.lastkilledby) && var_0.lastkilledby != var_1) {
    if(var_2 == "death" && scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_1)) {
      if(self.juggdroplocations < 3) {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("assist_decoy");
        self.juggdroplocations++;
        return;
      }

      return;
    }

    return;
  }
}

function jugg_watchherodrop(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  var_1 = self.owner;
  var_2 = self.origin;
  var_1 endon("disconnect");
  self endon("cast_failed");
  var_3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_4 = var_2;
  var_5 = var_0 getEye();
  var_6 = physics_raycast(var_4, var_5, var_3, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_6) && var_6.size > 0) {
    self notify("cast_failed");
  }

  var_0 playsoundtoplayer("bullet_small_flesh_torso_plr", var_0);
  var_0.donotmodifydamage = 1;
  var_0 dodamage(1, var_2, self);
  var_0.donotmodifydamage = undefined;
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
  wait 15;
  thread decoy_destroy();
}

function decoy_empapplied(var_0) {
  decoy_givepointsfordestroy(var_0.victim, var_0.attacker);
  thread decoy_destroy();
}

function decoy_handledamage(var_0) {
  scripts\mp\weapons::equipmenthit(self.owner, var_0.attacker, var_0.objweapon, var_0.meansofdeath);
  return var_0.damage;
}

function decoy_handlefataldamage(var_0) {
  decoy_givepointsfordestroy(var_0.attacker, var_0.objweapon);
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

function decoy_givepointsfordestroy(var_0, var_1) {
  if(isDefined(var_0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_1);
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