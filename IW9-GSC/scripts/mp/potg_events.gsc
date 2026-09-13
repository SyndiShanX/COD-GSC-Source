/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\potg_events.gsc
***********************************************/

init() {
  if(!level.potgenabled) {
    return;
  }
  level.potgglobals.eventdata = spawnStruct();
  _id_584994FAB4A8712B = level.potgglobals.eventdata;
  _id_584994FAB4A8712B.lastkillearner = undefined;
  _id_584994FAB4A8712B.lastkilltime = undefined;

  if(level.teambased) {
    _id_584994FAB4A8712B.lastteamkillearners = [];
    _id_584994FAB4A8712B.lastteamkilltimes = [];
  }
}

onpotgrecordingstopped() {
  clearshotgroup();
}

getentityeventdata() {
  _id_7B24B5E5D5D725A5 = scripts\mp\potg::getentitypotgdata(self);

  if(!isDefined(_id_7B24B5E5D5D725A5)) {
    return;
  }
  if(!isDefined(_id_7B24B5E5D5D725A5.trackingdata))
    _id_7B24B5E5D5D725A5.trackingdata = createentityeventdata();

  return _id_7B24B5E5D5D725A5.trackingdata;
}

createentityeventdata() {
  eventdata = spawnStruct();
  eventdata.shotgroupactive = 0;
  eventdata._id_1031746BC29117FA = 0;
  eventdata.shotgroupcount = 0;
  eventdata.shotgroupaccuracy = 0;
  eventdata.shotgrouplastcount = 0;
  eventdata.shotgrouplastaccuracy = 0;
  return eventdata;
}

onroundended(winner) {
  _id_584994FAB4A8712B = level.potgglobals.eventdata;
  handlefinalkill(winner);
}

handlefinalkill(winner) {
  if(!isDefined(winner)) {
    return;
  }
  _id_584994FAB4A8712B = level.potgglobals.eventdata;
  _id_028D85525CE4F472 = undefined;
  lastkilltime = undefined;

  if(level.teambased) {
    if(isDefined(_id_584994FAB4A8712B.lastteamkillearners[winner])) {
      _id_028D85525CE4F472 = _id_584994FAB4A8712B.lastteamkillearners[winner];
      lastkilltime = _id_584994FAB4A8712B.lastteamkilltimes[winner];
    } else {
      _id_028D85525CE4F472 = _id_584994FAB4A8712B.lastkillearner;
      lastkilltime = _id_584994FAB4A8712B.lastkilltime;
    }
  } else {
    _id_028D85525CE4F472 = _id_584994FAB4A8712B.lastkillearner;
    lastkilltime = _id_584994FAB4A8712B.lastkilltime;
  }

  if(isDefined(_id_028D85525CE4F472) && isDefined(lastkilltime))
    _id_028D85525CE4F472 scripts\mp\potg::processevent("final_kill", lastkilltime);
}

onplayerdamaged(attacker, victim, meansofdeath) {
  if(!level.potgenabled) {
    return;
  }
  if(scripts\common\utility::getdamagetype(meansofdeath) == "splash" && !victim scripts\mp\utility\game::isspawnprotected())
    victim scripts\mp\potg::processevent("hit_by_explosive");
}

onplayerkilled(attacker, inflictor, victim, meansofdeath, objweapon, psoffsettime) {
  if(!level.potgenabled) {
    return;
  }
  _id_584994FAB4A8712B = level.potgglobals.eventdata;
  _id_6B7BEE46F2C6DA28 = gettime();

  if(!isPlayer(attacker)) {
    return;
  }
  _id_DAF40A5B49F4EFBE = attacker getentityeventdata();
  _id_E7287DE05F58684B = victim getentityeventdata();
  _id_39AE7F14DDEE9A9A = attacker calckillmultiplier(attacker);
  _id_CD1741940A0A773B = meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE";
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1);
  _id_AA517194E54F048B = physics_raycast(attacker getEye(), victim getEye(), contents, undefined, 0, "physicsquery_closest", 1);
  _id_5CB7CACB05744D6B = isDefined(_id_AA517194E54F048B) && _id_AA517194E54F048B.size > 0;
  _id_19F55C21C87989F8 = scripts\engine\utility::within_fov(attacker getEye(), attacker getplayerangles(), victim.origin, cos(80));
  _id_1C6D69ECD5B91598 = objweapon.basename == "iw8_la_juliet_mp";
  _id_252206C84AE187F0 = (_id_1C6D69ECD5B91598 || _id_CD1741940A0A773B) && (!_id_19F55C21C87989F8 || _id_5CB7CACB05744D6B);

  if(!_id_252206C84AE187F0)
    attacker scripts\mp\potg::processevent("kill", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(isDefined(self.prevlastkilltime) && isDefined(attacker.lastspawntime)) {
    if(attacker.lastspawntime < self.prevlastkilltime) {
      _id_72D7FEA8136633DA = _id_6B7BEE46F2C6DA28 - self.prevlastkilltime;

      if(_id_72D7FEA8136633DA < 1800) {
        _id_EA52B3CDC0991CDC = 1.0 - _id_72D7FEA8136633DA / 1800;
        attacker scripts\mp\potg::processevent("kill_rate_bonus", self.prevlastkilltime, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_EA52B3CDC0991CDC);
      }
    }
  }

  attacker handlekillmodifiers(attacker, meansofdeath, objweapon, victim, _id_39AE7F14DDEE9A9A, psoffsettime);

  if(meansofdeath == "MOD_PROJECTILE_SPLASH" && !_id_1C6D69ECD5B91598)
    attacker scripts\mp\potg::processevent("missile_splash_kill", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(scripts\common\utility::getdamagetype(meansofdeath) == "splash") {
    if(scripts\mp\utility\game::gettimepassed() <= 12000 && randomintrange(0, 2) == 0)
      attacker scripts\mp\potg::processevent("round_start_grenade");
  }

  if(istrue(attacker.modifiers["bullet_damage"]) && victim scripts\mp\equipment\molotov::molotov_is_burning())
    attacker scripts\mp\potg::processevent("victim_on_fire", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(attacker scripts\mp\equipment\molotov::molotov_is_burning())
    attacker scripts\mp\potg::processevent("kill_while_on_fire", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(istrue(attacker.modifiers["airborne"])) {
    _id_DAF40A5B49F4EFBE.lastinairkilltime = _id_6B7BEE46F2C6DA28;
    _id_DAF40A5B49F4EFBE.inairsincelastkill = 1;
    attacker thread watchforpostkilllanding();
  }

  if(isDefined(attacker.lastdooropentime) && _id_6B7BEE46F2C6DA28 - attacker.lastdooropentime < 3500)
    attacker scripts\mp\potg::processevent("open_door_before_kill", attacker.lastdooropentime, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(isDefined(attacker.attackerdata) && attacker.attackerdata.size > 3)
    attacker scripts\mp\potg::processevent("outnumbered", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  if(isDefined(_id_E7287DE05F58684B.lastteabagtime) && _id_6B7BEE46F2C6DA28 - _id_E7287DE05F58684B.lastteabagtime < 1000 && randomintrange(0, 2) == 0)
    attacker scripts\mp\potg::processevent("kill_teabagger", _id_E7287DE05F58684B.lastteabagtime, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

  attacker handleequipmentkills(attacker, inflictor, victim, meansofdeath, objweapon, _id_39AE7F14DDEE9A9A);
  attacker handlemeleekills(attacker, inflictor, victim, meansofdeath, objweapon, _id_39AE7F14DDEE9A9A, psoffsettime);

  if(_id_DAF40A5B49F4EFBE.shotgroupactive) {
    if(_id_DAF40A5B49F4EFBE.shotgroupaccuracy >= 0.9)
      attacker scripts\mp\potg::processevent("accuracy_good", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
    else if(_id_DAF40A5B49F4EFBE.shotgroupaccuracy <= 0.075)
      attacker scripts\mp\potg::processevent("accuracy_very_bad", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
    else if(_id_DAF40A5B49F4EFBE.shotgroupaccuracy <= 0.15)
      attacker scripts\mp\potg::processevent("accuracy_bad", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
  }

  if(level.teambased) {
    _id_584994FAB4A8712B.lastteamkillearners[attacker.team] = attacker;
    _id_584994FAB4A8712B.lastteamkilltimes[attacker.team] = _id_6B7BEE46F2C6DA28;
  }

  _id_584994FAB4A8712B.lastkillearner = attacker;
  _id_584994FAB4A8712B.lastkilltime = _id_6B7BEE46F2C6DA28;
}

calckillmultiplier(attacker) {
  _id_39AE7F14DDEE9A9A = 1.0;

  if(!istrue(attacker.modifiers["victim_in_standard_view"]))
    _id_39AE7F14DDEE9A9A = _id_39AE7F14DDEE9A9A * 0.15;

  return _id_39AE7F14DDEE9A9A;
}

handlemeleekills(attacker, inflictor, victim, meansofdeath, objweapon, _id_39AE7F14DDEE9A9A, psoffsettime) {
  if(meansofdeath == "MOD_MELEE") {
    if(isDefined(attacker.lastspawntime)) {
      _id_769CDFC64F9F34E4 = isDefined(attacker.lastshotfiredtime) && attacker.lastshotfiredtime >= attacker.lastspawntime;

      if(!_id_769CDFC64F9F34E4)
        attacker scripts\mp\potg::processevent("no_shots_fired_kill", undefined, undefined, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
    }
  }
}

handleequipmentkills(attacker, inflictor, victim, meansofdeath, objweapon, _id_39AE7F14DDEE9A9A) {
  if(isDefined(inflictor) && istrue(inflictor.isequipment)) {
    isthrowingknife = scripts\mp\utility\weapon::isthrowingknife(objweapon);

    if(isDefined(inflictor.spawnpos)) {
      _id_93358D664321F69B = distancesquared(inflictor.spawnpos, inflictor.origin);

      if(isthrowingknife) {
        if(_id_93358D664321F69B >= 640000)
          attacker scripts\mp\potg::processevent("long_throwing_knife");
        else
          attacker scripts\mp\potg::processevent("throwing_knife");
      } else if(_id_93358D664321F69B >= 1440000)
        attacker scripts\mp\potg::processevent("long_grenade_throw");
    }

    if(scripts\mp\utility\game::gettimepassed() <= 12000) {
      if(isthrowingknife && level.mapname != "mp_shipment")
        attacker scripts\mp\potg::processevent("round_start_throwing_knife");
    }
  }
}

handlekillmodifiers(attacker, meansofdeath, objweapon, victim, _id_39AE7F14DDEE9A9A, psoffsettime) {
  _id_6B7BEE46F2C6DA28 = gettime();
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);

  foreach(modifier, _id_50BF9FEE6DD7779C in attacker.modifiers) {
    switch (modifier) {
      case "backstab":
        if(meansofdeath == "MOD_MELEE")
          attacker scripts\mp\potg::processevent("backstab", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      case "pointblank":
        if(_id_CF4209C200F8BBF4 == "weapon_sniper")
          attacker scripts\mp\potg::processevent("pointblank_sniper", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
        else
          attacker scripts\mp\potg::processevent("pointblank", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      case "airborne":
        if(isDefined(attacker.modifiers["ads"])) {
          if(_id_CF4209C200F8BBF4 == "weapon_sniper")
            attacker scripts\mp\potg::processevent("airborne_ads_sniper_kill", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
          else
            attacker scripts\mp\potg::processevent("airborne_ads_kill", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
        }

        break;
      case "victim_airborne":
        if(_id_CF4209C200F8BBF4 == "weapon_sniper")
          attacker scripts\mp\potg::processevent("victim_airborne_sniper", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);
        else
          attacker scripts\mp\potg::processevent("victim_airborne", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      case "longshot":
        if(!isDefined(attacker.modifiers["very_longshot"]))
          attacker scripts\mp\potg::processevent("longshot", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      case "last_bullet_kill":
        if(_id_CF4209C200F8BBF4 != "weapon_sniper" && _id_CF4209C200F8BBF4 != "weapon_projectile")
          attacker scripts\mp\potg::processevent("last_bullet_kill", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      case "victim_sprinting":
        if(_id_CF4209C200F8BBF4 == "weapon_sniper")
          attacker scripts\mp\potg::processevent("victim_sprinting_sniper", _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
      default:
        if(scripts\mp\potg::eventtable_isevent(modifier))
          attacker scripts\mp\potg::processevent(modifier, _id_6B7BEE46F2C6DA28, _id_6B7BEE46F2C6DA28, psoffsettime, undefined, _id_39AE7F14DDEE9A9A);

        break;
    }
  }
}

collateral(attacker, numkills) {
  if(!level.potgenabled) {
    return;
  }
  if(numkills == 2)
    attacker scripts\mp\potg::processevent("collateral");
  else if(numkills == 3)
    attacker scripts\mp\potg::processevent("triple_collateral");
  else
    attacker scripts\mp\potg::processevent("multi_collateral");
}

shotguncollateral(attacker, numkills) {
  if(!level.potgenabled) {
    return;
  }
  if(numkills == 2)
    attacker scripts\mp\potg::processevent("shotgun_collateral");
  else
    attacker scripts\mp\potg::processevent("shotgun_multi_collateral");
}

quadfeed(player, starttime, endtime) {
  if(!level.potgenabled) {
    return;
  }
  player scripts\mp\potg::processevent("quad_feed", starttime, endtime);
}

processeventforwitnesses(_id_5DB1449568089A93, _id_CDC5DD6C28C9709D, eventref, starttime, endtime) {
  _id_6C56B73C06C78AC2 = scripts\common\utility::playersnear(_id_5DB1449568089A93, 1000);

  foreach(player in _id_6C56B73C06C78AC2) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    _id_2C6AFBFA1BD5794F = _id_5DB1449568089A93 - player getEye();
    _id_20AF753DED3657E1 = anglesToForward(player getplayerangles());

    if(vectordot(_id_2C6AFBFA1BD5794F, _id_20AF753DED3657E1) < 0) {
      continue;
    }
    player scripts\mp\potg::processevent(eventref, starttime, endtime);
  }
}

watchforpostkilllanding() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  eventdata = getentityeventdata();

  for(;;) {
    if(self isonground()) {
      eventdata.inairsincelastkill = 0;
      break;
    }

    waitframe();
  }
}

predatormissileimpact(_id_25DE37BAEC255643) {
  if(!level.potgenabled) {
    return;
  }
  processeventforwitnesses(_id_25DE37BAEC255643, 1000000, "witness_predator_impact");
}

largevehicleexplosion(_id_408F3E834E201526) {
  if(!level.potgenabled) {
    return;
  }
  processeventforwitnesses(_id_408F3E834E201526, 640000, "witness_vehicle_explode");
}

vehiclekilled(damagedata) {
  if(!level.potgenabled) {
    return;
  }
  if(!isDefined(damagedata.attacker) || !isPlayer(damagedata.attacker)) {
    return;
  }
  damagedata.attacker scripts\mp\potg::processevent("vehicle_destroyed");
}

missilewhizby(player) {
  if(!level.potgenabled) {
    return;
  }
  player scripts\mp\potg::processevent("witness_missile_whizby");
}

bombdefused(_id_34E4B26FEE2CFD2B, _id_8F8DC78C3242728B, _id_C148DFE3DD8379C8) {
  if(!level.potgenabled) {
    return;
  }
  if(_id_C148DFE3DD8379C8)
    _id_34E4B26FEE2CFD2B scripts\mp\potg::processevent("ninja_defuse");
  else if(_id_8F8DC78C3242728B)
    _id_34E4B26FEE2CFD2B scripts\mp\potg::processevent("last_alive_defuse");
  else
    _id_34E4B26FEE2CFD2B scripts\mp\potg::processevent("defuse");
}

revivedplayer(reviver, _id_22F7E3F7E360775B) {
  if(!level.potgenabled) {
    return;
  }
  reviver scripts\mp\potg::processevent("revived_ally");
}

playerworlddeath(attacker, meansofdeath) {
  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();

  if(istrue(eventdata.inairsincelastkill))
    attacker scripts\mp\potg::processevent("fall_to_death_kill", eventdata.lastinairkilltime, gettime());
}

doorused(player, _id_6CB6920473D33EE3) {
  if(!level.potgenabled) {
    return;
  }
  if(!_id_6CB6920473D33EE3 && isDefined(player.lastkilltime) && gettime() - player.lastkilltime < 2000)
    player scripts\mp\potg::processevent("closed_door_after_kill");
}

playerstancechanged(_id_1830F76E65542F4D) {
  if(!level.potgenabled || !(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")) {
    return;
  }
  eventdata = getentityeventdata();
  _id_6B7BEE46F2C6DA28 = gettime();

  if(_id_1830F76E65542F4D == "crouch") {
    scripts\mp\potg::processevent("recent_crouch");

    if(isDefined(self.lastkillvictimpos)) {
      if(distancesquared(self.lastkillvictimpos, self.origin) < 40000) {
        _id_D9398283A059703C = _id_6B7BEE46F2C6DA28 - self.laststancetimes["crouch"];

        if(_id_D9398283A059703C < 750) {
          _id_418766AF38DD0ED1 = isDefined(self.lastspawntime) && (isDefined(eventdata.lastteabagtime) && self.lastspawntime < eventdata.lastteabagtime);

          if(!_id_418766AF38DD0ED1)
            scripts\mp\potg::processevent("teabag");

          if(!isDefined(eventdata.lastteabagtime) || _id_6B7BEE46F2C6DA28 - eventdata.lastteabagtime > 5000) {
            if(!isDefined(self.pers["teaBags"]))
              self.pers["teaBags"] = 0;

            self.pers["teaBags"]++;
            scripts\cp_mp\pet_watch::addteabagcharge();
          }

          eventdata.lastteabagtime = _id_6B7BEE46F2C6DA28;
        }
      }
    }
  } else if(_id_1830F76E65542F4D == "prone")
    scripts\mp\potg::processevent("recent_prone");
}

shothit() {
  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();
  updateshotgroup(1);
}

shotmissed(_id_C1480A81B0387196, _id_7EB0CCF010359357) {
  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();
  updateshotgroup(0, _id_C1480A81B0387196, _id_7EB0CCF010359357);
}

updateshotgroup(_id_85F10A087BBD102F, _id_C1480A81B0387196, _id_7EB0CCF010359357) {
  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();

  if(!isDefined(_id_C1480A81B0387196))
    _id_C1480A81B0387196 = 1;

  if(!isDefined(_id_7EB0CCF010359357)) {
    if(_id_85F10A087BBD102F)
      _id_7EB0CCF010359357 = 1;
    else
      _id_7EB0CCF010359357 = 0;
  }

  eventdata._id_1031746BC29117FA = eventdata._id_1031746BC29117FA + _id_7EB0CCF010359357;
  eventdata.shotgroupcount = eventdata.shotgroupcount + _id_C1480A81B0387196;
  eventdata.shotgroupaccuracy = eventdata._id_1031746BC29117FA / eventdata.shotgroupcount;
  thread shotgroupendwatcher();
}

shotgroupendwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearShotGroup");
  self notify("shotGroupEndWatcher()");
  self endon("shotGroupEndWatcher()");

  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();
  eventdata.shotgroupactive = 1;
  wait 2.0;
  clearshotgroup();
}

clearshotgroup() {
  if(!level.potgenabled) {
    return;
  }
  eventdata = getentityeventdata();
  eventdata.shotgroupactive = 0;
  eventdata.shotgrouplastcount = eventdata.shotgroupcount;
  eventdata.shotgrouplastaccuracy = eventdata.shotgroupaccuracy;
  eventdata._id_1031746BC29117FA = 0;
  eventdata.shotgroupcount = 0;
  eventdata.shotgroupaccuracy = 0;
  self notify("clearShotGroup");
}

grenadethrownevent(_id_4918B66CEBC7FBE7) {
  if(!level.potgenabled) {
    return;
  }
  if(_id_4918B66CEBC7FBE7)
    scripts\mp\potg::processevent("recent_lethal");
  else
    scripts\mp\potg::processevent("recent_tactical");
}

crouch() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("recent_crouch");
}

jump() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("recent_jump");
}

prone() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("recent_prone");
}

slide() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("recent_slide");
}

mantle() {
  if(!level.potgenabled) {
    return;
  }
  scripts\mp\potg::processevent("recent_mantle");
}