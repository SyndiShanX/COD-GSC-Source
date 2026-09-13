/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\callbacksetup.gsc
***********************************************/

codecallback_startgametype() {
  if(getDvar("r_reflectionprobegenerate") == "1")
    level waittill("eternity");

  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

codecallback_playeractive() {
  if(getDvar("r_reflectionprobegenerate") == "1")
    level waittill("eternity");

  self endon("disconnect");

  if(isDefined(level.callbackplayeractive))
    [[level.callbackplayeractive]]();
}

codecallback_playerconnect() {
  if(getDvar("r_reflectionprobegenerate") == "1")
    level waittill("eternity");

  self endon("disconnect");
  [[level.callbackplayerconnect]]();
  _id_4C770A9A4AD7659C::callback("player_connect");
}

codecallback_playerdisconnect(_id_401C3A2E68AAB0FD) {
  self notify("disconnect");
  self notify("death_or_disconnect");
  self.isdisconnecting = 1;
  _id_0F325FE524D4336B = self _meth_3B6BBFEC65CC4EE3();

  if(_id_0F325FE524D4336B) {
    _id_16C2D930984F2FEF = self isreloading();

    if(_id_16C2D930984F2FEF) {
      _id_5814D27874B48E54 = spawnStruct();
      _id_5814D27874B48E54.player = self;
      _id_5814D27874B48E54._id_C739BA1EB6635B73 = getsystemtimeinmicroseconds();
      _id_5814D27874B48E54._id_C198F7CA473378FB = "DISCONNECT";
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_reload_cancel", _id_5814D27874B48E54);
    }
  }

  [[level.callbackplayerdisconnect]](_id_401C3A2E68AAB0FD);
  _id_4C770A9A4AD7659C::callback("player_disconnect");
}

codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc))
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);

  [[level.callbackplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, _id_D7BC24CD73DFC712, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, _id_B0FC59FF15058522, _id_BE4285B26ED99AB1);
}

codecallback_playerfinishweaponchange(_id_492B944276064F63, _id_82533969B4683DE4) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](_id_492B944276064F63);
    [[level.weaponmapfunc]](_id_82533969B4683DE4);
  }

  if(isDefined(level.callbackfinishweaponchange))
    [[level.callbackfinishweaponchange]](_id_82533969B4683DE4, _id_492B944276064F63, _id_82533969B4683DE4.isalternate, _id_492B944276064F63.isalternate);
}

codecallback_playerimpaled(eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](objweapon);

  [[level.callbackplayerimpaled]](eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
}

codecallback_playerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](objweapon, einflictor);

  [[level.callbackplayerkilled]](einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
}

codecallback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  partname = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(partname);
  _id_799F234362ADB813 = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(_id_799F234362ADB813);

  if(isDefined(self.nullownerdamagefunc)) {
    _id_4111ACFB7F567D31 = [[self.nullownerdamagefunc]](attacker);

    if(isDefined(_id_4111ACFB7F567D31) && _id_4111ACFB7F567D31)
      return;
  }

  if(isDefined(level.weaponmapfunc))
    objweapon = [[level.weaponmapfunc]](objweapon, inflictor);

  if(isDefined(self.damagecallback))
    self[[self.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
  else if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback) && isDefined(self.vehiclename))
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
  else
    self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname);
}

codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");

  if(isDefined(self.perks) && (isDefined(self.perks["specialty_pistoldeath"]) || isDefined(self.perks["specialty_survivor"]))) {
    if(isDefined(level.weaponmapfunc))
      [[level.weaponmapfunc]](objweapon, einflictor);

    return [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
  } else {
    if(isDefined(eattacker) && isDefined(eattacker.team))
      level notify("down_enemy_laststand_" + eattacker.team, eattacker, self);

    return 0;
  }
}

codecallback_spawnpointsprecalc(team) {
  if(isDefined(level.callbackspawnpointprecalc))
    [[level.callbackspawnpointprecalc]](team);
}

codecallback_spawnpointscore(player, spawnpoint, team) {
  if(isDefined(level.callbackspawnpointscore))
    return player[[level.callbackspawnpointscore]](spawnpoint, team);

  return 0.0;
}

codecallback_spawnpointcritscore(player, spawnpoint, team) {
  result = "primary";

  if(isDefined(level.callbackspawnpointcritscore))
    result = player[[level.callbackspawnpointcritscore]](spawnpoint, team);

  if(result == "primary")
    return 100.0;
  else if(result == "secondary")
    return 50.0;

  return 0.0;
}

codecallback_playermigrated() {
  self endon("disconnect");
  [[level.callbackplayermigrated]]();
}

codecallback_hostmigration() {
  [[level.callbackhostmigration]]();
}

_id_99F3C84CF3B7CEB8() {
  if(getDvar("r_reflectionprobegenerate") == "1")
    level waittill("eternity");

  self endon("disconnect");
  [[level._id_42D9B617BBCA6A42]]();
}

_id_DBF77B841CFB8D59(_id_401C3A2E68AAB0FD) {
  self notify("disconnectmayrejoin");
  [[level._id_935C97AA3757676F]](_id_401C3A2E68AAB0FD);
}

_id_C305FC8BED32B81E(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  [[level._id_CDA3AF1F73639C7C]](_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A);
}

_id_0493BB22764BC865() {
  if(!isDefined(level._id_F162A4362B2B7718))
    return 0;

  return [[level._id_F162A4362B2B7718._id_F189CA4555AA689E]]();
}

_id_216B4C739C8BF413() {
  [[level._id_F162A4362B2B7718._id_0C214B782DB6525F]]();
}

_id_C45C947888C3A913() {
  [[level._id_F162A4362B2B7718._id_00205CB63B80DA5B]]();
}

setupdamageflags() {
  level.idflags_radius = 1;
  level.idflags_no_armor = 2;
  level.idflags_no_knockback = 4;
  level.idflags_penetration = 8;
  level.idflags_stun = 16;
  level.idflags_shield_explosive_impact = 32;
  level.idflags_shield_explosive_impact_huge = 64;
  level.idflags_shield_explosive_splash = 128;
  level.idflags_ricochet = 256;
  level.idflags_br_armor_hit = 512;
  level.idflags_br_armor_break = 1024;
  level.idflags_source_left_hand = 2048;
  level.idflags_no_dismemberment = 4096;
  level.idflags_hyper_burst_round = 8192;
  level.idflags_penetration_player_only = 16384;
  level._id_81A140202A2F4D30 = 32768;
  level.idflags_no_team_protection = 65536;
  level.idflags_no_protection = 131072;
  level.idflags_passthru = 262144;
}

abortlevel() {
  level.callbackstartgametype = ::callbackvoid;
  level.callbackplayeractive = ::callbackvoid;
  level.callbackplayerconnect = ::callbackvoid;
  level.callbackplayerdisconnect = ::callbackvoid;
  level.callbackplayerdamage = ::callbackvoid;
  level.callbackplayerimpaled = ::callbackvoid;
  level.callbackplayerkilled = ::callbackvoid;
  level.callbackplayerlaststand = ::callbackvoid;
  level.callbackplayermigrated = ::callbackvoid;
  level.callbackhostmigration = ::callbackvoid;
  level._id_42D9B617BBCA6A42 = ::callbackvoid;
  level._id_935C97AA3757676F = ::callbackvoid;
  setDvar("g_gametype", "dm");
  exitlevel(0);
}

callbackvoid() {}