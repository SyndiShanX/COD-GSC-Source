/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\callbacksetup.gsc
****************************************/

#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\telemetry_utils;
#using scripts\common\vehicle;
#namespace callbacksetup;

function codecallback_startgametype() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

function codecallback_playeractive() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    level waittill("eternity");
  }

  self endon("disconnect");

  if(isDefined(level.callbackplayeractive)) {
    [[level.callbackplayeractive]]();
  }
}

function codecallback_playerconnect() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
  callback::callback(#"player_connect");
}

function codecallback_playerdisconnect(reason) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self.isdisconnecting = 1;
  var_46d8c510a04d7126 = self function_c9980b59cc6aa434();

  if(var_46d8c510a04d7126) {
    isplayerreloading = self isreloading();

    if(isplayerreloading) {
      telemetrydata = spawnStruct();
      telemetrydata.player = self;
      telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
      telemetrydata.cancelreason = "DISCONNECT";
      telemetry_utils::function_af2d366f9522f76f("callback_on_reload_cancel", telemetrydata);
    }
  }

  [[level.callbackplayerdisconnect]](reason);
  callback::callback(#"player_disconnect");
}

function function_88983266715d6fb4(objweapon) {
  self endon("disconnect");
  self[[level.var_c6a23d27f33a948c]](objweapon);
}

function codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, var_6e998899533df3cf, willknockdown) {
  self endon("disconnect");
  profilestart();

  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);
  }

  [[level.callbackplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, var_6e998899533df3cf, willknockdown);
  profilestop();
}

function codecallback_playerdamagescore(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage) {
  self endon("disconnect");
  return [[level.callbackplayerdamagescore]](einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage);
}

function codecallback_playerdamageeffects(idamage, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc) {
  self endon("disconnect");
  [[level.callbackplayerdamageeffects]](idamage, undefined, eattacker, evictim, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc);
}

function codecallback_playerfinishweaponchange(objoldweapon, objnewweapon) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objoldweapon);
    [[level.weaponmapfunc]](objnewweapon);
  }

  if(isDefined(level.callbackfinishweaponchange)) {
    [[level.callbackfinishweaponchange]](objnewweapon, objoldweapon, objnewweapon.isalternate, objoldweapon.isalternate);
  }
}

function codecallback_playerimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon);
  }

  [[level.callbackplayerimpaled]](eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100);
}

function function_2730c29ebd22f69e(eattacker, objweapon, vdir, magnitude, shitloc) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon);
  }

  [[level.var_8f62eac141f8bdb6]](eattacker, objweapon, vdir, magnitude, shitloc, 0);
}

function codecallback_playerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon, einflictor);
  }

  [[level.callbackplayerkilled]](einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
}

function codecallback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  partname = vehicle::function_d88b357b027cbaed(partname);
  attachtagname = vehicle::function_d88b357b027cbaed(attachtagname);

  if(isDefined(self.nullownerdamagefunc)) {
    nulldamage = [[self.nullownerdamagefunc]](attacker);

    if(isDefined(nulldamage) && nulldamage) {
      return;
    }
  }

  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, inflictor);
  }

  if(isDefined(self.var_20cb8f4e47f3353e)) {
    damage = damage_tuning::getmodifieddamageusingdamagetuning(attacker, objweapon, meansofdeath, damage, self.maxhealth, self.var_20cb8f4e47f3353e, {
      #iskillstreak: self.iskillstreak, #inflictor: inflictor
    });
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
    return;
  }

  if(isDefined(level.vehicles.damagecallback) && isDefined(level.vehicles) && isDefined(self.vehiclename)) {
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
    return;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname);
}

function codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(self.perks["specialty_pistoldeath"]) || isDefined(self.perks["specialty_survivor"]) || level.var_28e3415171f7169b) {
    if(isDefined(level.weaponmapfunc)) {
      [[level.weaponmapfunc]](objweapon, einflictor);
    }

    return [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
  }

  if(isDefined(eattacker) && isDefined(eattacker.team)) {
    level notify("down_enemy_laststand_" + eattacker.team, eattacker, self);
  }

  return 0;
}

function codecallback_spawnpointsprecalc(team) {
  if(isDefined(level.callbackspawnpointprecalc)) {
    [[level.callbackspawnpointprecalc]](team);
  }
}

function codecallback_spawnpointscore(player, spawnpoint, team) {
  if(isDefined(level.callbackspawnpointscore)) {
    return player[[level.callbackspawnpointscore]](spawnpoint, team);
  }

  return 0;
}

function codecallback_spawnpointcritscore(player, spawnpoint, team) {
  result = "primary";

  if(isDefined(level.callbackspawnpointcritscore)) {
    result = player[[level.callbackspawnpointcritscore]](spawnpoint, team);
  }

  if(result == "primary") {
    return 100;
  } else if(result == "secondary") {
    return 50;
  }

  return 0;
}

function codecallback_playermigrated() {
  self endon("disconnect");
  [[level.callbackplayermigrated]]();
}

function codecallback_hostmigration() {
  [[level.callbackhostmigration]]();
}

function codecallback_playerconnectrejoin() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.var_4524771918fe585f]]();
}

function function_4b77b0a7af0613e(reason) {
  self notify("disconnectmayrejoin");
  [[level.var_880cfcfec57ca836]](reason);
}

function function_9e329f71be2400fd(achievementid, progressdata) {
  [[level.var_16eab40d8f2ae445]](achievementid, progressdata);
}

function function_42c350929ba6a5e6() {
  if(!isDefined(level.autopilot)) {
    return 0;
  }

  assert(isDefined(level.autopilot.var_c4f4308cd814658d));
  return [[level.autopilot.var_c4f4308cd814658d]]();
}

function function_1c91f56cd6f6c996() {
  [[level.autopilot.var_3564d4561f8e39f6]]();
}

function function_b31ed5f182c7b8() {
  [[level.autopilot.var_94abf03bbaf9fe40]]();
}

function abortlevel() {
  println("<dev string:x24>");
  level.callbackstartgametype = &callbackvoid;
  level.callbackplayeractive = &callbackvoid;
  level.callbackplayerconnect = &callbackvoid;
  level.callbackplayerdisconnect = &callbackvoid;
  level.callbackplayerdamage = &callbackvoid;
  level.callbackplayerimpaled = &callbackvoid;
  level.var_8f62eac141f8bdb6 = &callbackvoid;
  level.callbackplayerkilled = &callbackvoid;
  level.callbackplayerlaststand = &callbackvoid;
  level.callbackplayermigrated = &callbackvoid;
  level.callbackhostmigration = &callbackvoid;
  level.var_4524771918fe585f = &callbackvoid;
  level.var_880cfcfec57ca836 = &callbackvoid;
  level.gametype = undefined;
  exitlevel(0);
}

function callbackvoid() {}