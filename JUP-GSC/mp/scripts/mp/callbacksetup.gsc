/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callbacksetup.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\vehicle;
#namespace callbacksetup;

function codecallback_startgametype() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    level waittill("eternity");
  }

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

function codecallback_playeractive() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");

  if(isDefined(level.callbackplayeractive)) {
    [[level.callbackplayeractive]]();
  }
}

function codecallback_playerconnect() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
  callback::callback("player_connect");
}

function codecallback_playerdisconnect(reason) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self.isdisconnecting = 1;
  var_f325fe524d4336b = self function_3b6bbfec65cc4ee3();

  if(var_f325fe524d4336b) {
    isplayerreloading = self isreloading();

    if(isplayerreloading) {
      telemetrydata = spawnStruct();
      telemetrydata.player = self;
      telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
      telemetrydata.cancelreason = "DISCONNECT";
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_reload_cancel", telemetrydata);
    }
  }

  [[level.callbackplayerdisconnect]](reason);
  callback::callback("player_disconnect");
}

function codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);
  }

  [[level.callbackplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1);
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

function codecallback_playerimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon);
  }

  [[level.callbackplayerimpaled]](eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b);
}

function function_352bf03b62b5e7d3(eattacker, objweapon, vdir, magnitude, shitloc) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon);
  }

  [[level.var_189d24c2bbeed3f5]](eattacker, objweapon, vdir, magnitude, shitloc, 0);
}

function codecallback_playerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](objweapon, einflictor);
  }

  [[level.callbackplayerkilled]](einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
}

function codecallback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(partname);
  attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(attachtagname);

  if(isDefined(self.nullownerdamagefunc)) {
    nulldamage = [[self.nullownerdamagefunc]](attacker);

    if(isDefined(nulldamage) && nulldamage) {
      return;
    }
  }

  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, inflictor);
  }

  if(isDefined(self.var_e913079a5ffda56d)) {
    damage = getmodifieddamageusingdamagetuning(attacker, objweapon, meansofdeath, damage, self.maxhealth, self.var_e913079a5ffda56d);
  }

  if(isDefined(self.damagecallback)) {
    self[[self.damagecallback]](inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
    return;
  }

  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback) && isDefined(self.vehiclename)) {
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
    return;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname);
}

function codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(self.perks) && (isDefined(self.perks["specialty_pistoldeath"]) || isDefined(self.perks["specialty_survivor"]))) {
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

function function_99f3c84cf3b7ceb8() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    level waittill("eternity");
  }

  self endon("disconnect");
  [[level.var_42d9b617bbca6a42]]();
}

function function_dbf77b841cfb8d59(reason) {
  self notify("disconnectmayrejoin");
  [[level.var_935c97aa3757676f]](reason);
}

function function_c305fc8bed32b81e(achievementid, progressdata) {
  [[level.var_cda3af1f73639c7c]](achievementid, progressdata);
}

function function_493bb22764bc865() {
  if(!isDefined(level.autopilot)) {
    return 0;
  }

  assert(isDefined(level.autopilot.var_f189ca4555aa689e));
  return [[level.autopilot.var_f189ca4555aa689e]]();
}

function function_216b4c739c8bf413() {
  [[level.autopilot.var_c214b782db6525f]]();
}

function function_c45c947888c3a913() {
  [[level.autopilot.var_205cb63b80da5b]]();
}

function abortlevel() {
  println("<dev string:x1c>");
  level.callbackstartgametype = &callbackvoid;
  level.callbackplayeractive = &callbackvoid;
  level.callbackplayerconnect = &callbackvoid;
  level.callbackplayerdisconnect = &callbackvoid;
  level.callbackplayerdamage = &callbackvoid;
  level.callbackplayerimpaled = &callbackvoid;
  level.var_189d24c2bbeed3f5 = &callbackvoid;
  level.callbackplayerkilled = &callbackvoid;
  level.callbackplayerlaststand = &callbackvoid;
  level.callbackplayermigrated = &callbackvoid;
  level.callbackhostmigration = &callbackvoid;
  level.var_42d9b617bbca6a42 = &callbackvoid;
  level.var_935c97aa3757676f = &callbackvoid;
  setDvar(@ "g_gametype", "dm");
  exitlevel(0);
}

function callbackvoid() {}