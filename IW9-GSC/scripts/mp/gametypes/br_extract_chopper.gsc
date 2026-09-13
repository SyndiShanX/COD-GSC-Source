/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_chopper.gsc
*******************************************************/

spawnextractchopper(zone, _id_EF9046BE372B8AD6, onhelikilled, _id_0C65D01EC565399B) {
  _id_26A6F862062E4340 = zone.origin;
  _id_6E7C70B904418DAA = _id_26A6F862062E4340;
  direction = (0, 0, 0);
  _id_5ED27D0675C3B6EB = 24000;
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2];
  streakname = "jackal";
  _id_BEAB222529512A99 = level.mapcenter - zone.origin;
  _id_BEAB222529512A99 = (_id_BEAB222529512A99[0], _id_BEAB222529512A99[1], 0);
  _id_8BEF6F25C0930F60 = vectorNormalize(_id_BEAB222529512A99);
  _id_0F5849136E133A8B = _id_8BEF6F25C0930F60 * -10000 + (0, 0, 1) * _id_76AB620FD7CC70BD;
  _id_5A87F16696CFAF4D = (_id_26A6F862062E4340[0], _id_26A6F862062E4340[1], _id_76AB620FD7CC70BD);
  streakinfo = fakestreakinfo();
  _id_BF2637570246C7BB = spawn("trigger_radius", _id_26A6F862062E4340, 0, 90, 128);
  _id_BF2637570246C7BB.angles = (0, 0, 0);
  _id_BF2637570246C7BB.team = self.team;
  _id_BF2637570246C7BB.ownerteam = self.team;
  _id_BF2637570246C7BB.visibleteam = "any";
  _id_BF2637570246C7BB.offset3d = (0, 0, 16);
  _id_BF2637570246C7BB.location = _id_26A6F862062E4340;
  _id_8D39AE40EC801616 = beginlittlebird(0, _id_0F5849136E133A8B, _id_5A87F16696CFAF4D, streakinfo, _id_BF2637570246C7BB, _id_EF9046BE372B8AD6, self.team, _id_0C65D01EC565399B);
  _id_8D39AE40EC801616.onhelikilled = onhelikilled;
  _id_8D39AE40EC801616.zone = zone;
  return _id_8D39AE40EC801616;
}

fakestreakinfo() {
  streakinfo = spawnStruct();
  streakinfo.available = 1;
  streakinfo.firednotify = "offhand_fired";
  streakinfo.isgimme = 1;
  streakinfo.kid = 5;
  streakinfo.lifeid = 0;
  streakinfo.madeavailabletime = gettime();
  streakinfo.scriptuseagetype = "gesture_script_weapon";
  streakinfo.streakname = "jackal";
  streakinfo.streaksetupinfo = undefined;
  streakinfo.variantid = -1;
  streakinfo.weaponname = "ks_gesture_generic_mp";
  streakinfo.objweapon = makeweapon(streakinfo.weaponname);
  return streakinfo;
}

beginlittlebird(lifeid, startpoint, endpoint, streakinfo, lz, _id_EF9046BE372B8AD6, team, _id_0C65D01EC565399B) {
  marker = undefined;

  if(isDefined(lz)) {
    marker = lz.marker;

    if(!isDefined(marker)) {
      marker = spawnStruct();

      if(isDefined(_id_EF9046BE372B8AD6))
        marker.location = _id_EF9046BE372B8AD6;
      else if(isDefined(lz.location))
        marker.location = lz.location;
      else
        marker.location = lz.trigger.origin;

      marker.angles = (0, 0, 0);
      marker.string = "equip_deploy_succeeded";
      marker.visual = spawn("script_model", marker.location);
      marker.visual setModel("ks_marker_mp");
      marker.visual setotherent(self);
    }

    if(!isDefined(marker.location)) {
      self notify("cancel_littlebird");
      return 0;
    }
  }

  self notify("called_in_littlebird");
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");

  if(isDefined(_id_5FA1E1697A302583))
    _id_1DC672CFE0F0128E = _id_5FA1E1697A302583.origin[2] + 500;
  else
    _id_1DC672CFE0F0128E = 1300;

  if(isDefined(marker) && isDefined(marker.location))
    endpoint = marker.location;

  endpoint = endpoint * (1, 1, 0);
  pathgoal = endpoint + (0, 0, _id_1DC672CFE0F0128E);
  _id_8D39AE40EC801616 = spawnlittlebird(lifeid, self, startpoint, pathgoal, streakinfo, lz);
  _id_8D39AE40EC801616.lz = lz;
  _id_8D39AE40EC801616.pathgoal = pathgoal;
  thread monitorarriveoverdestination(_id_8D39AE40EC801616, marker, team, _id_0C65D01EC565399B);
  return _id_8D39AE40EC801616;
}

spawnlittlebird(lifeid, owner, pathstart, pathgoal, streakinfo, lz) {
  forward = vectortoangles(pathgoal - pathstart);

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    numflares = 99;
    maxhealth = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    numflares = 99;
    maxhealth = 99999;
  } else {
    numflares = 1;
    maxhealth = 10000;
  }

  _id_1ABFBB19B71BCCF8 = "veh9_mil_air_heli_medium";
  jackal = spawnhelicopter(owner, pathstart, forward, "lbravo_infil_mp", _id_1ABFBB19B71BCCF8);

  if(!isDefined(jackal)) {
    return;
  }
  if(isDefined(lz))
    jackal.lz = lz;

  jackal thread handledestroydamage();
  jackal.damagecallback = ::callback_vehicledamage;
  jackal.speed = 50;
  jackal.accel = 125;
  jackal.health = maxhealth;
  jackal.maxhealth = jackal.health;
  jackal.team = owner.team;
  jackal.owner = owner;
  jackal setCanDamage(1);
  jackal.defendloc = pathgoal;
  jackal.lifeid = lifeid;
  jackal.jackal = 1;
  jackal.streakinfo = streakinfo;
  jackal.streakname = streakinfo.streakname;
  jackal.streakinfo = streakinfo;
  jackal.flaresreservecount = numflares;
  jackal scripts\mp\utility\killstreak::addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  jackal setmaxpitchroll(0, 90);
  jackal vehicle_setspeed(jackal.speed, jackal.accel);
  jackal sethoverparams(50, 100, 50);
  jackal setturningability(0.05);
  jackal setyawspeed(45, 25, 25, 0.5);
  jackal setotherent(owner);
  jackal.useobj = spawn("script_model", jackal gettagorigin("tag_origin"));
  jackal.useobj linkTo(jackal, "tag_origin");

  if(!isDefined(level.jackals))
    level.jackals = [];

  level.jackals[level.jackals.size] = jackal;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  jackal thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  jackal thread littlebirddestroyed();
  jackal thread delay_jackal_arrive_sfx();
  return jackal;
}

delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

delayjackalloopsfx(_id_74B5B12BB6514385, alias) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_74B5B12BB6514385);
  self playLoopSound(alias);
}

littlebirddestroyed() {
  self endon("jackal_gone");
  owner = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread littlebirdcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz))
    self.lz notify("extraction_destroyed");

  littlebirdexplode();
}

littlebirdexplode() {
  self playSound("dropship_explode_mp");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self.lz))
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");

  wait 0.35;
  thread littlebirddelete();
}

littlebirddelete() {
  scripts\mp\utility\print::printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.cannon))
    self.cannon delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  foreach(loc in level.carepackagedropnodes)
  loc.free = undefined;

  self delete();
}

littlebirdcrash(speed) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

handledestroydamage() {
  self endon("death");
  self endon("leaving");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health) {
      if(isDefined(self.onhelikilled))
        [[self.onhelikilled]](self.team);

      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
    }
  }
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, _id_44E290FB31B85206, getcompleteweaponname(objweapon));

  if(self.health <= damage) {
    if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner))
      scripts\mp\damage::onkillstreakkilled("jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
  }

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

monitorarriveoverdestination(_id_2D5132FBC622EF42, marker, team, _id_0C65D01EC565399B) {
  _id_2D5132FBC622EF42 endon("death");
  _id_2D5132FBC622EF42 endon("leaving");
  _id_2D5132FBC622EF42 setvehgoalpos(_id_2D5132FBC622EF42.pathgoal, 1);
  _id_2D5132FBC622EF42 thread changemaxpitchrollwhenclosetogoal(_id_2D5132FBC622EF42.pathgoal);
  _id_2D5132FBC622EF42 waittill("goal");
  _id_2D5132FBC622EF42 thread watchgameendleave();

  if(isDefined(_id_0C65D01EC565399B)) {
    _id_9FEE259DD0243A42 = _id_2D5132FBC622EF42.speed;
    _id_D99757891D1ED279 = _id_2D5132FBC622EF42.accel;
  } else {
    _id_9FEE259DD0243A42 = _id_2D5132FBC622EF42.speed / 4;
    _id_D99757891D1ED279 = _id_2D5132FBC622EF42.accel / 6;
  }

  _id_2D5132FBC622EF42 vehicle_setspeed(_id_9FEE259DD0243A42, _id_D99757891D1ED279);
  _id_2D5132FBC622EF42 littlebirddescendtoextraction(marker.location, _id_2D5132FBC622EF42.zone, team);
}

littlebirdleave() {
  self endon("death");
  _id_CDDC894CCDF6DE54 = self.speed;
  _id_AF4A339E05408E87 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  _id_F751B396E9B232E6 = int(self.speed / 14);
  _id_A001268025A19C55 = int(self.accel / 16);

  if(isDefined(_id_CDDC894CCDF6DE54))
    _id_F751B396E9B232E6 = _id_CDDC894CCDF6DE54;

  if(isDefined(_id_AF4A339E05408E87))
    _id_A001268025A19C55 = _id_AF4A339E05408E87;

  self vehicle_setspeed(_id_F751B396E9B232E6, _id_A001268025A19C55);
  pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  pathgoal = pathgoal + (0, 0, 1000);
  self setvehgoalpos(pathgoal, 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self waittill("goal");
  _id_8B79D0E3AD3FB617 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(_id_8B79D0E3AD3FB617, 1);
  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");

  if(scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict")
    littlebirddelete();
}

getpathend() {
  _id_CE2E2CFD0619F6CA = 150;
  _id_90783CCFB7B260FB = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * _id_90783CCFB7B260FB;
  return endpoint;
}

littlebirddescendtoextraction(location, zone, team) {
  descend(location, zone);

  if(scripts\mp\utility\game::getgametype() != "vip" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict" && scripts\mp\utility\game::getgametype() != "btm") {
    zone.teamsextracting = scripts\engine\utility::array_remove(zone.teamsextracting, team + self._id_0FF97225579DE16A);
    thread littlebirdleave();
  }
}

descend(location, zone) {
  self endon("bugOut");
  _id_6C53D859D582A421 = undefined;
  _id_0FCFB56E6D8CC156 = location[0];
  _id_0FCFB66E6D8CC389 = location[1];
  _id_7504C8791E34DC73 = tracegroundheight(_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, 20);
  _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_7504C8791E34DC73);

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    _id_7504C8791E34DC73 = tracegroundheight(_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, 5, 1);
    _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_7504C8791E34DC73 + 200);
  }

  self clearlookatent();
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  self waittill("goal");

  if(scripts\mp\utility\game::getgametype() == "vip")
    self notify("esc_littlebird_arrive");
  else if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    _id_7504C8791E34DC73 = tracegroundheight(_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, undefined, 1);
    _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_7504C8791E34DC73 + 120);
    self setvehgoalpos(_id_6C53D859D582A421, 1);
    self notify("esc_littlebird_arrive");
    self waittill("goal");
    self vehicle_setspeed(self.speed / 3, self.accel / 4);
  } else if(scripts\mp\utility\game::getgametype() == "btm")
    self notify("esc_littlebird_arrive");
}

tracegroundheight(x, y, _id_00AE14C5A8B1B582, _id_FFA2F7672C0C1531) {
  _id_DC8BB6300463CF1E = 30;
  _id_E7A7D619F927D791 = tracegroundpoint(x, y, _id_FFA2F7672C0C1531);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;

  if(isDefined(_id_00AE14C5A8B1B582))
    _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);

  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(x, y, _id_FFA2F7672C0C1531) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2] + 2000;
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates)
    ignorelist[ignorelist.size] = crate;
  }

  _id_8BC8BDB284860E7E = 256;

  if(isDefined(_id_FFA2F7672C0C1531))
    _id_E96577032A7740FC = scripts\engine\trace::ray_trace((x, y, _id_E531AFBE1391F499), (x, y, z), ignorelist, undefined, undefined, 1);
  else
    _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), 256, ignorelist, undefined, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

changemaxpitchrollwhenclosetogoal(pathgoal) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, pathgoal) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

abortextractpickup() {
  thread littlebirdleave();
}