/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\dronehive.gsc
************************************************/

init() {
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(_id_F17F773B25D8C46A in level.dronemissilespawnarray)
  _id_F17F773B25D8C46A.targetent = getEnt(_id_F17F773B25D8C46A.target, "targetname");
}

weapongivendronehive(streakinfo) {
  return 1;
}

tryusedronehive(streakinfo) {
  return usedronehive(self, streakinfo.lifeid, streakinfo);
}

usedronehive(player, lifeid, streakinfo) {
  if(isDefined(self.underwater) && self.underwater)
    return 0;

  result = player scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo);

  if(!result)
    return 0;

  player _id_3B64EB40368C1450::set("use_drone_hive", "weapon_switch", 0);
  level thread monitordisownkillstreaks(player);
  level thread monitorgameend(player);
  level thread monitorobjectivecamera(player);
  level thread rundronehive(player, lifeid, streakinfo.streakname, streakinfo);
  return 1;
}

watchhostmigrationstartedinit(player) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      player thermalvisionon();
      continue;
    }

    player setclientomnvar("ui_predator_missile", 2);
  }
}

watchhostmigrationfinishedinit(player) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      player setclientomnvar("ui_predator_missile", 1);
      player setclientomnvar("ui_predator_missiles_left", self.missilesleft);
      continue;
    }

    player setclientomnvar("ui_predator_missile", 2);
  }
}

watchclosetogoal(player) {
  player endon("disconnect");
  level endon("game_ended");
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, contentoverride);

    if(isDefined(trace["position"]) && distancesquared(self.origin, trace["position"]) < 5000) {
      break;
    }

    waitframe();
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

rundronehive(player, lifeid, streakname, streakinfo) {
  player endon("disconnect");
  level endon("game_ended");
  _id_EF41235A89500AD8 = "used_drone_hive";
  _id_89653D637E0A2A78 = "drone_hive_projectile_mp";
  _id_D8FACE27A0D9305D = "switch_blade_child_mp";
  level thread scripts\mp\hud_util::teamplayercardsplash(_id_EF41235A89500AD8, player);
  player notifyonplayercommand("missileTargetSet", "+attack");
  player notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  _id_9911424A16B85E14 = getbestmissilespawnpoint(player, level.dronemissilespawnarray);
  startpos = _id_9911424A16B85E14.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  targetpos = _id_9911424A16B85E14.targetent.origin;
  rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(_id_89653D637E0A2A78), startpos, targetpos, player);
  rocket setCanDamage(1);
  rocket disablemissileboosting();
  rocket setmissileminimapvisible(1);
  rocket.team = player.team;
  rocket.lifeid = lifeid;
  rocket.type = "remote";
  rocket.owner = player;
  rocket.entitynumber = rocket getentitynumber();
  rocket.streakinfo = streakinfo;
  rocket.weapon_name = "drone_hive_projectile_mp";
  level.rockets[rocket.entitynumber] = rocket;
  level.remotemissileinprogress = 1;
  level thread monitordeath(rocket, 1);
  level thread monitorboost(rocket);
  missileeyes(player, rocket);
  player setclientomnvar("ui_predator_missile", 1);
  rocket thread watchhostmigrationstartedinit(player);
  rocket thread watchhostmigrationfinishedinit(player);
  rocket thread scripts\mp\utility\killstreak::watchsupertrophynotify(player);
  player scripts\common\utility::trycall(level.matchdata_logkillstreakevent, streakname, rocket.origin);
  _id_C8CC9E14CBC6C616 = 0;
  rocket.missilesleft = 2;
  reloadtime = 2;
  player setclientomnvar("ui_predator_missiles_left", rocket.missilesleft);

  for(;;) {
    result = rocket scripts\engine\utility::waittill_any_return_2("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(result == "death") {
      break;
    }

    if(!isDefined(rocket)) {
      break;
    }

    if(istrue(rocket.unlimitedammo)) {
      if(istrue(rocket.lasttimefired)) {
        if(gettime() < rocket.lasttimefired + reloadtime * 1000 && _id_C8CC9E14CBC6C616 == 0)
          continue;
      }

      level thread firerapidmissiles(rocket, _id_C8CC9E14CBC6C616, streakinfo, _id_D8FACE27A0D9305D);
      _id_C8CC9E14CBC6C616++;
      rocket.lasttimefired = gettime();
      rocket.missilesleft = 2 - _id_C8CC9E14CBC6C616;
      _id_5C9DDCF56D36F133 = rocket.missilesleft;

      if(rocket.missilesleft == 0)
        _id_5C9DDCF56D36F133 = -1;

      player setclientomnvar("ui_predator_missiles_left", _id_5C9DDCF56D36F133);

      if(_id_C8CC9E14CBC6C616 == 2) {
        _id_C8CC9E14CBC6C616 = 0;
        rocket.missilesleft = 2;
        player thread resetmissiles(rocket, reloadtime);
      }

      continue;
    }

    if(_id_C8CC9E14CBC6C616 < 2) {
      if(!istrue(rocket.singlefire)) {
        level thread spawnswitchblade(rocket, _id_C8CC9E14CBC6C616, streakinfo, _id_D8FACE27A0D9305D);
        _id_C8CC9E14CBC6C616++;
        rocket.missilesleft = 2 - _id_C8CC9E14CBC6C616;
        player setclientomnvar("ui_predator_missiles_left", rocket.missilesleft);

        if(_id_C8CC9E14CBC6C616 == 2)
          rocket enablemissileboosting();
      }
    }
  }

  level thread returnplayer(player);
  scripts\mp\utility\print::printgameaction("killstreak ended - drone_hive", player);
}

firerapidmissiles(rocket, _id_C8CC9E14CBC6C616, streakinfo, _id_D8FACE27A0D9305D) {
  _id_4888F4F947A820EE = _id_C8CC9E14CBC6C616;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
    level thread spawnswitchblade(rocket, _id_4888F4F947A820EE, streakinfo, _id_D8FACE27A0D9305D);
    _id_4888F4F947A820EE++;

    if(_id_4888F4F947A820EE > 1)
      _id_4888F4F947A820EE = 0;

    wait 0.1;
  }
}

resetmissiles(rocket, reloadtime) {
  rocket endon("death");
  self endon("disconnect");
  wait(reloadtime);
  self setclientomnvar("ui_predator_missiles_left", rocket.missilesleft);
}

monitorlockedtarget() {
  level endon("game_ended");
  self endon("death");
  enemytargets = [];
  _id_6F500807B0D7B1DA = [];

  for(;;) {
    _id_9C999503835471DF = [];
    enemytargets = scripts\mp\utility\killstreak::getenemytargets();

    foreach(_id_B8E70FF71A02E32D in enemytargets) {
      _id_DEF090ECBC180B02 = self.owner worldpointinreticle_circle(_id_B8E70FF71A02E32D.origin, 65, 90);

      if(_id_DEF090ECBC180B02) {
        self.owner thread scripts\mp\utility\debug::drawline(self.origin, _id_B8E70FF71A02E32D.origin, 10, (0, 0, 1));
        _id_9C999503835471DF[_id_9C999503835471DF.size] = _id_B8E70FF71A02E32D;
      }
    }

    if(_id_9C999503835471DF.size) {
      _id_6F500807B0D7B1DA = sortbydistance(_id_9C999503835471DF, self.origin);
      self.lasttargetlocked = _id_6F500807B0D7B1DA[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

spawnswitchblade(rocket, _id_CCFD286D34B473A0, streakinfo, _id_D8FACE27A0D9305D) {
  rocket.owner playlocalsound("ammo_crate_use", undefined, undefined, 1);
  _id_A66FD1B124C32F51 = rocket gettagangles("tag_origin");
  _id_68FD30DB511477F5 = anglesToForward(_id_A66FD1B124C32F51);
  rightdir = anglestoright(_id_A66FD1B124C32F51);
  _id_AD3758FD3576AE97 = (100, 100, 100);
  targetoffset = (15000, 15000, 15000);

  if(_id_CCFD286D34B473A0)
    _id_AD3758FD3576AE97 = _id_AD3758FD3576AE97 * -1;

  result = scripts\engine\trace::_bullet_trace(rocket.origin, rocket.origin + _id_68FD30DB511477F5 * targetoffset, 0, rocket);
  targetoffset = targetoffset * result["fraction"];
  _id_81AA7E8BC8F8C030 = rocket.origin + rightdir * _id_AD3758FD3576AE97;
  _id_7B59B41B01684053 = rocket.origin + _id_68FD30DB511477F5 * targetoffset;
  missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(_id_D8FACE27A0D9305D), _id_81AA7E8BC8F8C030, _id_7B59B41B01684053, rocket.owner);
  _id_1F027877F9775AB8 = rocket getclosesttargetinview(rocket.owner, _id_7B59B41B01684053);

  if(isDefined(_id_1F027877F9775AB8))
    missile missile_settargetEnt(_id_1F027877F9775AB8);

  missile setCanDamage(1);
  missile setmissileminimapvisible(1);
  missile.team = rocket.team;
  missile.lifeid = rocket.lifeid;
  missile.type = rocket.type;
  missile.owner = rocket.owner;
  missile.entitynumber = missile getentitynumber();
  missile.streakinfo = streakinfo;
  missile.weapon_name = "switch_blade_child_mp";
  level.rockets[missile.entitynumber] = missile;
  level thread monitordeath(missile, 0);
}

getclosesttargetinview(owner, _id_7B59B41B01684053) {
  targets = scripts\mp\utility\killstreak::getenemytargets(owner);
  _id_1E79B4675C5AA7F9 = undefined;
  _id_BD41FC0707ADDF42 = undefined;

  foreach(_id_B8E70FF71A02E32D in targets) {
    if(!isDefined(_id_B8E70FF71A02E32D) || !scripts\mp\utility\player::isreallyalive(_id_B8E70FF71A02E32D)) {
      continue;
    }
    if(istrue(_id_B8E70FF71A02E32D.trinityrocketlocked)) {
      continue;
    }
    _id_AA9E155F5AB291BE = distance2dsquared(_id_B8E70FF71A02E32D.origin, _id_7B59B41B01684053);

    if(_id_AA9E155F5AB291BE < 262144 && istrue(canseetarget(_id_B8E70FF71A02E32D))) {
      if(!isDefined(_id_BD41FC0707ADDF42) || _id_AA9E155F5AB291BE < _id_BD41FC0707ADDF42) {
        _id_1E79B4675C5AA7F9 = _id_B8E70FF71A02E32D;
        _id_BD41FC0707ADDF42 = _id_AA9E155F5AB291BE;
      }
    }
  }

  if(isDefined(_id_1E79B4675C5AA7F9)) {
    _id_1E79B4675C5AA7F9.trinityrocketlocked = 1;
    _id_1E79B4675C5AA7F9 thread watchtarget();
  }

  return _id_1E79B4675C5AA7F9;
}

canseetarget(target) {
  _id_027B697504D9397D = 0;
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contentoverride)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

watchtarget() {
  self endon("disconnect");
  self waittill("death");
  self.trinityrocketlocked = undefined;
}

looptriggeredeffect(effect, missile) {
  missile endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(effect);
    wait 0.25;
  }
}

getnextmissilespawnindex(_id_A7F6D4BE6B657D86) {
  index = _id_A7F6D4BE6B657D86 + 1;

  if(index == level.dronemissilespawnarray.size)
    index = 0;

  return index;
}

monitorboost(rocket) {
  rocket endon("death");

  for(;;) {
    rocket.owner waittill("missileTargetSet");
    rocket notify("missileTargetSet");
  }
}

getbestmissilespawnpoint(owner, _id_123255877BC63BBB) {
  _id_45A9094092727403 = [];

  foreach(player in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player.team == owner.team) {
      continue;
    }
    if(player.team == "spectator") {
      continue;
    }
    _id_45A9094092727403[_id_45A9094092727403.size] = player;
  }

  if(!_id_45A9094092727403.size)
    return _id_123255877BC63BBB[randomint(_id_123255877BC63BBB.size)];

  _id_4EB0036DF55013DE = scripts\engine\utility::array_randomize(_id_123255877BC63BBB);
  _id_1A2450B2561E9908 = _id_4EB0036DF55013DE[0];

  foreach(_id_F17F773B25D8C46A in _id_4EB0036DF55013DE) {
    _id_F17F773B25D8C46A.sightedenemies = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_45A9094092727403.size; _id_AC0E594AC96AA3A8++) {
      enemy = _id_45A9094092727403[_id_AC0E594AC96AA3A8];

      if(!scripts\mp\utility\player::isreallyalive(enemy)) {
        _id_45A9094092727403[_id_AC0E594AC96AA3A8] = _id_45A9094092727403[_id_45A9094092727403.size - 1];
        _id_45A9094092727403[_id_45A9094092727403.size - 1] = undefined;
        _id_AC0E594AC96AA3A8--;
        continue;
      }

      if(scripts\engine\trace::_bullet_trace_passed(enemy.origin + (0, 0, 32), _id_F17F773B25D8C46A.origin, 0, enemy)) {
        _id_F17F773B25D8C46A.sightedenemies = _id_F17F773B25D8C46A.sightedenemies + 1;
        return _id_F17F773B25D8C46A;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(_id_F17F773B25D8C46A.sightedenemies == _id_45A9094092727403.size)
      return _id_F17F773B25D8C46A;

    if(_id_F17F773B25D8C46A.sightedenemies > _id_1A2450B2561E9908.sightedenemies)
      _id_1A2450B2561E9908 = _id_F17F773B25D8C46A;
  }

  return _id_1A2450B2561E9908;
}

missileeyes(player, rocket) {
  _id_74B5B12BB6514385 = 0.5;
  player scripts\mp\utility\player::_freezecontrols(1);
  player cameralinkTo(rocket, "tag_origin");
  player controlslinkTo(rocket);
  player thermalvisionon();
  player setclientomnvar("ui_killstreak_health", 1);
  player setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  level thread unfreezecontrols(player, _id_74B5B12BB6514385);
}

unfreezecontrols(player, _id_74B5B12BB6514385, _id_AC0E594AC96AA3A8) {
  player endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_74B5B12BB6514385 - 0.35);
  player scripts\mp\utility\player::_freezecontrols(0);
}

monitordisownkillstreaks(player) {
  player endon("disconnect");
  player endon("end_kill_streak");
  player childthread monitorownerstatus("joined_team");
  player childthread monitorownerstatus("joined_spectators");
}

monitorownerstatus(_id_70687E0CC558A009) {
  self waittill(_id_70687E0CC558A009);
  level thread returnplayer(self);
}

monitorgameend(player) {
  player endon("disconnect");
  player endon("end_kill_streak");
  level waittill("game_ended");
  gameended = 1;
  level thread returnplayer(player, 0, gameended);
}

monitorobjectivecamera(player) {
  player endon("end_kill_streak");
  player endon("disconnect");
  level waittill("objective_cam");
  level thread returnplayer(player, 1);
}

monitordeath(_id_D7EEA22A14A52FD0, _id_561C9D45D1C37EAC) {
  _id_D7EEA22A14A52FD0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(_id_D7EEA22A14A52FD0.targeffect))
    _id_D7EEA22A14A52FD0.targeffect delete();

  if(isDefined(_id_D7EEA22A14A52FD0.entitynumber))
    level.rockets[_id_D7EEA22A14A52FD0.entitynumber] = undefined;

  if(_id_561C9D45D1C37EAC)
    level.remotemissileinprogress = undefined;
}

returnplayer(player, _id_5E0065A1DC2434B6, gameended) {
  if(!isDefined(player)) {
    return;
  }
  if(!istrue(gameended))
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");

  player setclientomnvar("ui_predator_missile", 2);
  player notify("end_kill_streak");
  player thermalvisionoff();
  player controlsunlink();
  player cameraunlink();
  player setclientomnvar("ui_predator_missile", 0);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("use_drone_hive");
}

watchgastrigger(_id_4084C95C19C7937A, weaponname) {
  self endon("death");

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    if(level.teambased && ent.team == _id_4084C95C19C7937A.team && ent != _id_4084C95C19C7937A) {
      continue;
    }
    if(istrue(ent.gettinggassed)) {
      continue;
    }
    thread applygasdamageovertime(_id_4084C95C19C7937A, weaponname, ent);
  }
}

applygasdamageovertime(_id_4084C95C19C7937A, _id_902492553F7C3DAF, victim) {
  victim endon("disconnect");
  victim.gettinggassed = 1;

  while(victim istouching(self)) {
    victim dodamage(20, self.origin, _id_4084C95C19C7937A, self, "MOD_EXPLOSIVE", _id_902492553F7C3DAF);
    result = scripts\engine\utility::waittill_any_timeout_1(0.5, "death");

    if(result == "death") {
      break;
    }
  }

  if(istrue(victim.gettinggassed))
    victim.gettinggassed = undefined;
}