/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\decoy_grenade.gsc
**************************************************/

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
  var0.firemaxcounts["ar"] = 3;
  var0.fireintervalmintimes["ar"] = 0.5;
  var0.fireintervalmaxtimes["ar"] = 2;
  var0.fireminupimpulse["ar"] = 175;
  var0.firemaxupimpulse["ar"] = 225;
  var0.fireminforwardimpulse["ar"] = 55;
  var0.firemaxforwardimpulse["ar"] = 125;
  var0.firetypes[var0.firetypes.size] = "smg";
  var0.firetypeweights["smg"] = 50;
  var0.firetimes["smg"] = 0.4;
  var0.firemaxcounts["smg"] = 4;
  var0.fireintervalmintimes["smg"] = 0.25;
  var0.fireintervalmaxtimes["smg"] = 1;
  var0.fireminupimpulse["smg"] = 80;
  var0.firemaxupimpulse["smg"] = 125;
  var0.fireminforwardimpulse["smg"] = 175;
  var0.firemaxforwardimpulse["smg"] = 265;
  var0.firetypes[var0.firetypes.size] = "sniper";
  var0.firetypeweights["sniper"] = 15;
  var0.firetimes["sniper"] = 0.4;
  var0.firemaxcounts["sniper"] = 2;
  var0.fireintervalmintimes["sniper"] = 1;
  var0.fireintervalmaxtimes["sniper"] = 3;
  var0.fireminupimpulse["sniper"] = 250;
  var0.firemaxupimpulse["sniper"] = 375;
  var0.fireminforwardimpulse["sniper"] = 0;
  var0.firemaxforwardimpulse["sniper"] = 60;
  var0.light_tank_watchmissileinputchange = getdvarint("scr_decoy_BR_diceroll_low", 1);
  var0.light_tank_watchgameend = getdvarint("scr_decoy_BR_diceroll_high", 4);
}

function decoy_used(var0) {
  var0 endon("death");
  scripts\mp\utility\print::printgameaction("decoy grenade spawn", var0.owner);
  var0.playersdebuffed = [];
  var0.juggdroplocations = 0;
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&decoy_empapplied);
  var0 scripts\cp_mp\emp_debuff::allow_emp(0);
  decoy_addtogloballist(var0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);
  wait 0.4;
  var0 scripts\cp_mp\emp_debuff::allow_emp(1);
  var0 thread scripts\mp\damage::monitordamage(19, "hitequip", &decoy_handlefataldamage, &decoy_handledamage);
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

  LOC_000000d7:
    thread decoy_monitorfuse();
  thread decoy_activated();
}

function decoy_activated() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  var0 = decoy_getfiretype();

  for(;;) {
    decoy_firesequence(var0);
    wait randomfloatrange(1.5, 3.5);
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
  scripts\mp\damage::monitordamageend();
  wait var0;
  self delete();
}

function decoy_firesequence(var0) {
  var1 = decoy_getleveldata();
  var2 = 1 + randomint(var1.firemaxcounts[var0]);

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
    self.owner scripts\mp\utility\weapon::_launchgrenade("decoy_grenade_mp", self.origin, var3, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", var0 + "Fire", 0);
  self setscriptablepartstate("weaponSounds", var0 + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  decoy_debuffenemiesinrange();
  var5 = decoy_getleveldata();
  wait var5.firetimes[var0];
}

function decoy_debuffenemiesinrange() {
  var0 = decoy_getleveldata();
  var1 = scripts\common\utility::playersincylinder(self.origin, 800);
  var2 = 0;

  if(getdvarint("scr_decoy_BR_allow_fakeDamage", 1) == 1) {
    if(scripts\mp\utility\game::unset_relic_grounded()) {
      var2 = 1;
    }
  }

  foreach(var4 in var1) {
    if(!var4 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var4))) {
      continue;
    }

    thread decoy_debuffenemy(var4);

    if(var2) {
      var5 = randomintrange(var0.light_tank_watchmissileinputchange, var0.light_tank_watchgameend);

      if(var5 == 1) {
        thread jugg_watchherodrop(var4);
      }
    }

    self.owner scripts\mp\damage::combatrecordtacticalstat("equip_decoy");
    self.owner scripts\mp\utility\stats::incpersstat("decoyHits", 1);
  }
}

function decoy_debuffenemy(var0) {
  var0 endon("disconnect");
  self endon("death");
  var1 = self.owner;
  var1 endon("disconnect");
  self notify("decoy_debuffEnemy_" + var0 getentitynumber());
  self endon("decoy_debuffEnemy_" + var0 getentitynumber());

  if(!isDefined(self.playersdebuffed[var0 getentitynumber()])) {
    self.playersdebuffed[var0 getentitynumber()] = var0;
  }

  var2 = var0 scripts\engine\utility::waittill_notify_or_timeout_return("death", 5);
  self.playersdebuffed[var0 getentitynumber()] = undefined;

  if(isDefined(var0.lastkilledby) && var0.lastkilledby != var1) {
    if(var2 == "death" && scripts\cp_mp\utility\player_utility::playersareenemies(var0, var1)) {
      if(self.juggdroplocations < 3) {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("assist_decoy");
        self.juggdroplocations++;
        return;
      }

      return;
    }

    return;
  }
}

function jugg_watchherodrop(var0) {
  var0 endon("disconnect");
  self endon("death");
  var1 = self.owner;
  var2 = self.origin;
  var1 endon("disconnect");
  self endon("cast_failed");
  var3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var4 = var2;
  var5 = var0 getEye();
  var6 = physics_raycast(var4, var5, var3, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var6) && var6.size > 0) {
    self notify("cast_failed");
  }

  var0 playsoundtoplayer("bullet_small_flesh_torso_plr", var0);
  var0.donotmodifydamage = 1;
  var0 dodamage(1, var2, self);
  var0.donotmodifydamage = undefined;
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
  wait 15;
  thread decoy_destroy();
}

function decoy_empapplied(var0) {
  decoy_givepointsfordestroy(var0.victim, var0.attacker);
  thread decoy_destroy();
}

function decoy_handledamage(var0) {
  scripts\mp\weapons::equipmenthit(self.owner, var0.attacker, var0.objweapon, var0.meansofdeath);
  return var0.damage;
}

function decoy_handlefataldamage(var0) {
  decoy_givepointsfordestroy(var0.attacker, var0.objweapon);
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

function decoy_givepointsfordestroy(var0, var1) {
  if(isDefined(var0) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");
    var0 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var1);
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