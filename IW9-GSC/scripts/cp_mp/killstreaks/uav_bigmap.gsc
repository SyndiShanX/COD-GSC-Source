/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\uav_bigmap.gsc
****************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav_bigmap", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav_bigmap", "init")]]();

  _id_F2B595D060C7B8D1();
  _id_8FCBC948E54837E1();
}

_id_F2B595D060C7B8D1() {
  game["dialog"]["uav_bigmap_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["uav_bigmap_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["uav_bigmap_destroyed"] = "killstreak_remote_operator_crash";
}

_id_8FCBC948E54837E1() {
  level._id_1A92F34363247D37 = [];

  foreach(_id_2E79AA0FBCDB8210 in level.teamnamelist)
  level._id_1A92F34363247D37[_id_2E79AA0FBCDB8210] = [];

  level thread _id_123F8DA350E72770();
}

_id_123F8DA350E72770() {
  level endon("game_ended");

  for(;;) {
    currenttime = gettime();

    foreach(_id_FABF84450735DD93, _id_8B462903A1F84F9C in level._id_1A92F34363247D37) {
      if(level._id_1A92F34363247D37[_id_FABF84450735DD93].size > 0) {
        _id_8506BA4041FBE9BB = 0;

        for(_id_AC0E594AC96AA3A8 = level._id_1A92F34363247D37[_id_FABF84450735DD93].size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
          _id_9DF9B10A1D4123BA = level._id_1A92F34363247D37[_id_FABF84450735DD93][_id_AC0E594AC96AA3A8];

          if(!isDefined(_id_9DF9B10A1D4123BA)) {
            continue;
          }
          _id_94016B8397435CE3 = 0;

          for(index = _id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB.size - 1; index >= 0; index--) {
            if(_id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB[index] + _id_9DF9B10A1D4123BA.duration * 1000 < currenttime) {
              _id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB[index] = undefined;
              _id_9DF9B10A1D4123BA.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("uav", "uav_leave", 1);

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
                [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - UAV", _id_9DF9B10A1D4123BA.owner);

              _id_94016B8397435CE3 = 1;
            }
          }

          if(_id_94016B8397435CE3)
            _id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB = scripts\engine\utility::array_removeundefined(_id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB);

          if(_id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB.size == 0) {
            level._id_1A92F34363247D37[_id_FABF84450735DD93][_id_AC0E594AC96AA3A8] = undefined;
            _id_8506BA4041FBE9BB = 1;
            continue;
          }

          if(!(isalive(_id_9DF9B10A1D4123BA.owner) && !isDefined(_id_9DF9B10A1D4123BA.owner.fauxdead) && !istrue(_id_9DF9B10A1D4123BA.owner.delayedspawnedplayernotify) && !istrue(_id_9DF9B10A1D4123BA.owner._id_C4C8B91E0B16AA5E))) {
            level._id_1A92F34363247D37[_id_FABF84450735DD93][_id_AC0E594AC96AA3A8] = undefined;
            _id_8506BA4041FBE9BB = 1;
            continue;
          }
        }

        if(_id_8506BA4041FBE9BB)
          level._id_1A92F34363247D37[_id_FABF84450735DD93] = scripts\engine\utility::array_removeundefined(level._id_1A92F34363247D37[_id_FABF84450735DD93]);

        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level._id_1A92F34363247D37[_id_FABF84450735DD93].size; _id_AC0E5C4AC96AAA41++) {
          _id_9DF9B10A1D4123BA = level._id_1A92F34363247D37[_id_FABF84450735DD93][_id_AC0E5C4AC96AAA41];
          _id_EB42C9A48FE362F2 = _id_9DF9B10A1D4123BA._id_51BEE3F5B3B4E4AB.size;

          if(_id_9DF9B10A1D4123BA._id_8B226FA0A4438980 + _id_9DF9B10A1D4123BA._id_A2A010CA62B6691E * 1000 / _id_EB42C9A48FE362F2 < currenttime)
            _id_D1444DD5B0F1EBAC(_id_9DF9B10A1D4123BA);
        }
      }
    }

    waitframe();
  }
}

_id_E5931B9F76ED6CDA(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("uav", self.origin);

  _id_E24C416C5028BCCC(self, streakinfo);
  return 1;
}

_id_E24C416C5028BCCC(owner, streakinfo) {
  if(!isDefined(level._id_1A92F34363247D37))
    level thread init();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doOnActionScoreEvent"))
    owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doOnActionScoreEvent")]](2, "uavUsed");

  _id_EF41235A89500AD8 = level.uavsettings["uav"].teamsplash;
  _id_274A2749EF16EE1F = streakinfo.streakname;
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog") && !istrue(streakinfo._id_02495B93AC241A91)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](owner, _id_274A2749EF16EE1F);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(owner, owner.team, 15000, _id_274A2749EF16EE1F);
  owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(_id_274A2749EF16EE1F, _id_274A2749EF16EE1F + "_use", 1, _id_52A5BE2E2F91D710);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](_id_EF41235A89500AD8, owner);

  _id_45AED8FD3D63E0DB = _id_4B696648ABF2A7CD(owner.team);

  if(_id_45AED8FD3D63E0DB + 1 >= getdvarint("dvar_306F1F0806522199", 3)) {
    if(_id_03713808120900A4(owner)) {
      _id_0B9A6E42F8062D9E(owner.team);
      return;
    }
  }

  _id_13AAAB0EE500428D = _id_D8F7D7425EE3435B(owner);

  if(isDefined(_id_13AAAB0EE500428D))
    _id_13AAAB0EE500428D._id_51BEE3F5B3B4E4AB[_id_13AAAB0EE500428D._id_51BEE3F5B3B4E4AB.size] = gettime();
  else
    _id_B26DF19671891830(owner, streakinfo);
}

_id_4B696648ABF2A7CD(team) {
  _id_EB42C9A48FE362F2 = 0;

  if(isDefined(level._id_1A92F34363247D37[team])) {
    foreach(struct in level._id_1A92F34363247D37[team])
    _id_EB42C9A48FE362F2 = _id_EB42C9A48FE362F2 + struct._id_51BEE3F5B3B4E4AB.size;
  }

  return _id_EB42C9A48FE362F2;
}

_id_0B9A6E42F8062D9E(team) {
  if(isDefined(level._id_1A92F34363247D37[team])) {
    for(index = level._id_1A92F34363247D37[team].size - 1; index >= 0; index--)
      level._id_1A92F34363247D37[team][index] = undefined;
  }
}

_id_03713808120900A4(owner) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("directional_uav", owner);
  streakinfo.skipequippedstreakcheck = 1;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  return owner scripts\cp_mp\killstreaks\uav::_id_D64C0D6BE4DBBAAF(streakinfo.streakname, streakinfo);
}

_id_D8F7D7425EE3435B(player) {
  _id_13AAAB0EE500428D = undefined;

  if(isDefined(level._id_1A92F34363247D37[player.team])) {
    foreach(struct in level._id_1A92F34363247D37[player.team]) {
      if(struct.owner == player) {
        _id_13AAAB0EE500428D = struct;
        break;
      }
    }
  }

  return _id_13AAAB0EE500428D;
}

_id_B26DF19671891830(owner, streakinfo) {
  duration = getdvarfloat("dvar_2C4AA32449462D6E", 25);
  _id_5888FE9DAC2D7D8E = getdvarfloat("scr_uav_bigmap_sweep_duration", 2);
  _id_A2A010CA62B6691E = getdvarfloat("scr_uav_bigmap_sweep_interval", 4);
  radius = getdvarint("scr_uav_bigmap_sweep_radius", 12000);

  if(owner scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch")) {
    _id_5888FE9DAC2D7D8E = _id_5888FE9DAC2D7D8E * 0.5;
    _id_A2A010CA62B6691E = _id_A2A010CA62B6691E * 0.5;
  }

  _id_9DF9B10A1D4123BA = _id_C1F0080375451D78(owner, radius, duration, _id_5888FE9DAC2D7D8E, _id_A2A010CA62B6691E, streakinfo);
  _id_48B2B4D259D7D51D(_id_9DF9B10A1D4123BA);
}

_id_48B2B4D259D7D51D(_id_9DF9B10A1D4123BA) {
  if(!isDefined(level._id_1A92F34363247D37[_id_9DF9B10A1D4123BA.team]))
    level._id_1A92F34363247D37[_id_9DF9B10A1D4123BA.team] = [];

  level._id_1A92F34363247D37[_id_9DF9B10A1D4123BA.team][level._id_1A92F34363247D37[_id_9DF9B10A1D4123BA.team].size] = _id_9DF9B10A1D4123BA;
}

_id_C1F0080375451D78(owner, radius, duration, _id_5888FE9DAC2D7D8E, _id_A2A010CA62B6691E, streakinfo) {
  _id_8C0551592E3B775B = spawnStruct();
  _id_8C0551592E3B775B._id_51BEE3F5B3B4E4AB = [];
  _id_8C0551592E3B775B._id_51BEE3F5B3B4E4AB[0] = gettime();
  _id_8C0551592E3B775B.owner = owner;
  _id_8C0551592E3B775B.team = owner.team;
  _id_8C0551592E3B775B._id_8B226FA0A4438980 = 0;
  _id_8C0551592E3B775B.radius = radius;
  _id_8C0551592E3B775B._id_5888FE9DAC2D7D8E = _id_5888FE9DAC2D7D8E;
  _id_8C0551592E3B775B._id_A2A010CA62B6691E = _id_A2A010CA62B6691E;
  _id_8C0551592E3B775B.duration = duration;
  _id_8C0551592E3B775B.streakinfo = streakinfo;
  return _id_8C0551592E3B775B;
}

_id_D1444DD5B0F1EBAC(_id_9DF9B10A1D4123BA) {
  if(level.teambased)
    triggerportableradarpingteam(_id_9DF9B10A1D4123BA.owner.origin, _id_9DF9B10A1D4123BA.team, _id_9DF9B10A1D4123BA.radius, int(_id_9DF9B10A1D4123BA._id_5888FE9DAC2D7D8E * 1000));
  else
    triggerportableradarping(_id_9DF9B10A1D4123BA.owner.origin, _id_9DF9B10A1D4123BA.owner, _id_9DF9B10A1D4123BA.radius, int(_id_9DF9B10A1D4123BA._id_5888FE9DAC2D7D8E * 1000));

  _id_9DF9B10A1D4123BA._id_8B226FA0A4438980 = gettime();
}