/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\uav.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "init")]]();

  level thread _id_83BBD4AAD5A34B6B();
  level _id_AC005E67449BFDF8();
  level _id_D4FC9B64FFEC9E4E();
  level thread onplayerconnect();
  level thread _id_F1CA81DA4F9F32D8();
}

_id_83BBD4AAD5A34B6B() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("onStartGameTypeFinished");

  if(isDefined(level.mapcenter))
    level.uavrotationorigin = level.mapcenter;
  else
    level.uavrotationorigin = (0, 0, 0);
}

_id_AC005E67449BFDF8() {
  level.uavworstid = getuavstrengthmin();
  level.uavbestid = getuavstrengthmax();
  level.uavdirectionalid = getuavstrengthlevelshowenemydirectional();
  level.uavnoneid = getuavstrengthlevelneutral();
  level.uavfastsweepid = getuavstrengthlevelshowenemyfastsweep();

  if(level.teambased) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
      level.radarmode[level.teamnamelist[_id_AC0E594AC96AA3A8]] = "normal_radar";
      level.activeuavs[level.teamnamelist[_id_AC0E594AC96AA3A8]] = 0;
      level.activecounteruavs[level.teamnamelist[_id_AC0E594AC96AA3A8]] = 0;
      level.activeadvanceduavs[level.teamnamelist[_id_AC0E594AC96AA3A8]] = 0;
      level.uavmodels[level.teamnamelist[_id_AC0E594AC96AA3A8]] = [];

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        level._id_48C4EDF71E075321[level.teamnamelist[_id_AC0E594AC96AA3A8]] = 0;
    }
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.activecounteruavs = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      level._id_48C4EDF71E075321 = [];
  }

  level._id_5A26E5543A6559C8 = [];
  level.totalactiveuavs = 0;
  level.totalactivecounteruavs = 0;
  level.activeadvanceduavcount = 0;
}

_id_D4FC9B64FFEC9E4E() {
  game["dialog"]["uav_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["uav_leave"] = "killstreak_remote_operator_leave";
  game["dialog"]["uav_destroyed"] = "killstreak_remote_operator_crash";
  game["dialog"]["directional_uav_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["directional_uav_leave"] = "killstreak_remote_operator_leave";
}

onplayerconnect() {
  _id_F0D1EB8B608ECB81 = getuavstrengthlevelneutral();

  for(;;) {
    level waittill("connected", player);
    level.activeuavs[player.guid] = 0;
    level.activeuavs[player.guid + "_radarStrength"] = _id_F0D1EB8B608ECB81;
    level.activecounteruavs[player.guid] = 0;
    level.radarmode[player.guid] = "normal_radar";
    player.radarstrength = _id_F0D1EB8B608ECB81;
  }
}

onplayerspawned() {
  level notify("uav_update");
}

_id_F1CA81DA4F9F32D8() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      foreach(_id_F90358454413407F in level.teamnamelist)
      _id_6F87F9454A77DF16(_id_F90358454413407F);

      continue;
    }

    _id_F9CAA46AA98B7C6B();
  }
}

tryuseuav(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryuseuavfromstruct(streakinfo);
}

tryuseuavfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(streakinfo.streakname == "uav" && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getdvarint("dvar_970BE8DB72985238", 0))
    return _id_509A782DD5B89CF1::_id_E5931B9F76ED6CDA(streakinfo);

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_300A4922BAA10548 = 0;

  if(level.teambased && isDefined(level.teamdata) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["activeSupplySweeps"])) {
    _id_4E2B4A3E39B84D99 = level.teamdata[self.team]["activeSupplySweeps"].size;
    _id_300A4922BAA10548 = _id_4E2B4A3E39B84D99 > 0;
  }

  if(_id_300A4922BAA10548) {
    _id_79710492B71B9E81 = "KILLSTREAKS/SUPPLY_SWEEP_IN_PROGRESS";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81);

    return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  _id_79710492B71B9E81 = _id_D64C0D6BE4DBBAAF(streakinfo.streakname, streakinfo);
  return istrue(_id_79710492B71B9E81);
}

_id_D64C0D6BE4DBBAAF(uavtype, streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](uavtype, self.origin);

  team = self.pers["team"];
  usetime = level.uavsettings[uavtype].timeout;
  _id_DA662696203DC431 = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_DA662696203DC431 = 1;

  _id_CD35C837EB616223 = _id_277684F0F74AC8CF(self, uavtype, streakinfo, _id_DA662696203DC431);

  if(!istrue(_id_CD35C837EB616223)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    return 0;
  }

  _id_FDF77B17C3813DFA = "uavUsed";

  switch (uavtype) {
    case "directional_uav":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(player in level.players) {
          if(player.pers["team"] == team)
            player.radarshowenemydirection = 1;
        }
      }

      _id_FDF77B17C3813DFA = "directionalUavUsed";
      break;
    case "counter_uav":
      _id_FDF77B17C3813DFA = "counterUavUsed";
    default:
      if(level.teambased)
        radarstrength = _id_5EC24D236512FD7A(team);

      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doOnActionScoreEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doOnActionScoreEvent")]](2, _id_FDF77B17C3813DFA);

  return 1;
}

_id_8E9A430C17DDCD55(uavtype) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  if(uavtype != "uav")
    return 0;

  index = undefined;

  if(level.teambased) {
    index = self.team;

    if(istrue(level._id_7C5A2787ED20AC77))
      index = self.team + self.squadindex;
  } else
    index = self.guid;

  _id_F19F07F386CD9119 = level.activeadvanceduavs[index];

  if(isDefined(_id_F19F07F386CD9119) && _id_F19F07F386CD9119 > 0)
    return 0;

  _id_A23BE9FD896CB2CA = level.activeuavs[index];
  _id_990D56BDA9BCDF66 = _id_933DF49E9A291165(_id_A23BE9FD896CB2CA, 0, 0);
  _id_A49C3DFD3126E1EE = getuavstrengthlevelshowenemydirectional();
  return _id_990D56BDA9BCDF66 >= _id_A49C3DFD3126E1EE;
}

_id_277684F0F74AC8CF(owner, uavtype, streakinfo, _id_DA662696203DC431) {
  team = owner.team;
  _id_51C1B45046E1647C = level.uavrotationorigin;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm") {
      if(isDefined(level.hqmidpoint))
        _id_51C1B45046E1647C = level.hqmidpoint;
    } else
      _id_51C1B45046E1647C = owner.origin;
  }

  _id_A561E2B774105AD0 = _id_36F7C24094D12C70(_id_51C1B45046E1647C, owner, uavtype, streakinfo, _id_DA662696203DC431);

  if(!isDefined(_id_A561E2B774105AD0))
    return 0;

  _id_A561E2B774105AD0 thread _id_FD8473DB50408AA8();
  return 1;
}

_id_36F7C24094D12C70(_id_51C1B45046E1647C, owner, uavtype, streakinfo, _id_DA662696203DC431, _id_9B3DD3233F6F68A2) {
  _id_A561E2B774105AD0 = undefined;
  _id_88D3D00BF003F331 = undefined;

  if(istrue(_id_DA662696203DC431)) {
    _id_A561E2B774105AD0 = spawnStruct();
    _id_A561E2B774105AD0.damagetaken = 0;
  } else {
    _id_A561E2B774105AD0 = spawn("script_model", _id_51C1B45046E1647C + (0, 0, 5000));
    _id_88D3D00BF003F331 = _id_A561E2B774105AD0 _id_0972967E0C0A0FA8(uavtype, _id_51C1B45046E1647C);

    if(!isDefined(_id_88D3D00BF003F331)) {
      _id_A561E2B774105AD0 delete();
      return undefined;
    }
  }

  model = level.uavsettings[uavtype].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) && isDefined(level.uavsettings[uavtype].modelbasealt))
    model = level.uavsettings[uavtype].modelbasealt;

  maxhealth = level.uavsettings[uavtype].maxhealth;
  _id_EF41235A89500AD8 = level.uavsettings[uavtype].teamsplash;

  if(isent(_id_A561E2B774105AD0))
    _id_A561E2B774105AD0 setModel(model);

  _id_A561E2B774105AD0.team = owner.team;
  _id_A561E2B774105AD0.owner = owner;
  _id_A561E2B774105AD0.timetoadd = 0;
  _id_A561E2B774105AD0.uavtype = uavtype;
  _id_A561E2B774105AD0.health = level.uavsettings[uavtype].health;
  _id_A561E2B774105AD0.maxhealth = maxhealth;
  _id_A561E2B774105AD0.currenthealth = maxhealth;
  _id_A561E2B774105AD0.streakinfo = streakinfo;
  _id_A561E2B774105AD0 thread _id_C926982FF07FDEA5();
  _id_A561E2B774105AD0 thread _id_D45F5CF5BFCE96DF();
  _id_A561E2B774105AD0 thread _id_E58C525D5D3A7482();
  _id_A561E2B774105AD0 thread _id_0225E3594843D2AC(uavtype, _id_9B3DD3233F6F68A2, owner);
  _id_A561E2B774105AD0 thread _id_709BAFCC745FA088();

  if(isent(_id_A561E2B774105AD0)) {
    _id_A561E2B774105AD0 setotherent(owner);
    _id_A561E2B774105AD0 scriptmoveroutline();
    _id_A561E2B774105AD0 scriptmoverthermal();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "attachXRays"))
      _id_A561E2B774105AD0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "attachXRays")]](_id_A561E2B774105AD0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
      _id_A561E2B774105AD0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](uavtype, "Killstreak_Air", owner);

    _id_A561E2B774105AD0 thread _id_2129B5EE9273A536();
    _id_A561E2B774105AD0 thread _id_F53DE0E99CB013E8();
    _id_A561E2B774105AD0 thread _id_4E53BA93EC09B58C();
    _id_A561E2B774105AD0 thread _id_F54B6539DC6A4A1C();
    _id_A561E2B774105AD0 setscriptablepartstate("lights", "on", 0);

    if(_id_A561E2B774105AD0.uavtype == "counter_uav")
      _id_A561E2B774105AD0 setscriptablepartstate("rotors", "on", 0);

    zoffset = randomintrange(6000, 6500);

    if(_id_A561E2B774105AD0.uavtype == "counter_uav")
      zoffset = randomintrange(2000, 2500);
    else if(_id_A561E2B774105AD0.uavtype == "directional_uav")
      zoffset = randomintrange(30000, 31000);

    if(issubstr(level.mapname, "mp_catedral"))
      zoffset = zoffset + 5000;

    angle = randomint(360);
    _id_927A3CFE858B4605 = randomint(1000);

    if(_id_A561E2B774105AD0.uavtype == "counter_uav")
      _id_927A3CFE858B4605 = randomintrange(300, 550);
    else if(_id_A561E2B774105AD0.uavtype == "directional_uav")
      _id_927A3CFE858B4605 = randomintrange(20000, 22000);

    _id_0234183E65CC4B94 = _id_927A3CFE858B4605 + 4000;
    xoffset = cos(angle) * _id_0234183E65CC4B94;
    yoffset = sin(angle) * _id_0234183E65CC4B94;
    _id_DE9C77C124D1FFAB = vectorNormalize((xoffset, yoffset, zoffset));
    _id_DE9C77C124D1FFAB = _id_DE9C77C124D1FFAB * zoffset;
    _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

    if(_id_E005D4B70D6F2611) {
      _id_D00AF7864022039C = (0, 0, 3000);
      _id_DE9C77C124D1FFAB = _id_DE9C77C124D1FFAB + _id_D00AF7864022039C;
    }

    _id_A561E2B774105AD0 linkTo(_id_88D3D00BF003F331, "tag_origin", _id_DE9C77C124D1FFAB, (0, angle - 90, 0));
    _id_A561E2B774105AD0 thread _id_48E2105AFD534B62();
    _id_A561E2B774105AD0 scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(1, _id_A561E2B774105AD0.maxhealth * 0.75, ::_id_1C832B851CA3A96A);
    _id_A561E2B774105AD0 scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(2, _id_A561E2B774105AD0.maxhealth * 0.5, ::_id_4DB3B85258DA27BF);
    _id_A561E2B774105AD0 scripts\cp_mp\utility\killstreak_utility::_id_CFC5E3633EF950FD(3, _id_A561E2B774105AD0.maxhealth * 0.25, ::_id_AECE0522AF7087EF);
  }

  _id_A561E2B774105AD0[[level.uavsettings[uavtype].addfunc]]();

  if(uavtype == "uav" || uavtype == "directional_uav") {
    _id_A561E2B774105AD0 _id_0172C4412DDE1696(1);
    _id_A561E2B774105AD0 thread _id_E9A20F47C6B49BD7();
  }

  if(isDefined(level.activeuavs[_id_A561E2B774105AD0.team]) && level.activeuavs[_id_A561E2B774105AD0.team] > 0) {
    if(isent(_id_A561E2B774105AD0)) {
      foreach(uav in level.uavmodels[_id_A561E2B774105AD0.team]) {
        if(uav == _id_A561E2B774105AD0) {
          continue;
        }
        if(isDefined(uav.timetoadd))
          uav.timetoadd = uav.timetoadd + 5;
      }
    } else
      _id_A561E2B774105AD0.timetoadd = 5 * (level.activeuavs[_id_A561E2B774105AD0.team] - 1);
  }

  _id_274A2749EF16EE1F = streakinfo.streakname;

  if(owner _id_8E9A430C17DDCD55(uavtype))
    _id_274A2749EF16EE1F = "directional_uav";

  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](owner, _id_274A2749EF16EE1F);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(owner, _id_A561E2B774105AD0.team, 15000, _id_274A2749EF16EE1F);
  owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(_id_274A2749EF16EE1F, _id_274A2749EF16EE1F + "_use", 1, _id_52A5BE2E2F91D710);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](_id_EF41235A89500AD8, owner);

  level notify("uav_update");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level notify("uav_started", owner);

  return _id_A561E2B774105AD0;
}

_id_FD8473DB50408AA8(_id_D0BDCA2F09736813) {
  level endon("game_ended");
  uavtype = self.uavtype;
  _id_CDC9BEE1ECFE4526 = self.owner;
  _id_33EB8BE565CA82FA = self.team;
  result = scripts\engine\utility::waittill_any_return_2("explode", "timeout");

  if(isDefined(result) && result == "timeout") {
    if(isent(self)) {
      self unlink();
      self.destpoint = self.origin + anglesToForward(self.angles) * 50000;
      self moveTo(self.destpoint, 50);
    }

    if(isDefined(_id_CDC9BEE1ECFE4526) && !istrue(level.gameended))
      _id_CDC9BEE1ECFE4526 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.uavtype, self.uavtype + "_leave", 1);

    scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", 3);

    if(isDefined(self) && self.damagetaken < self.maxhealth) {
      self notify("leaving");
      self.isleaving = 1;

      if(isent(self))
        self moveTo(self.destpoint, 15);

      scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", 4 + self.timetoadd);

      if(isDefined(self) && self.damagetaken < self.maxhealth)
        self.leftplayspace = 1;
    }
  }

  if(isDefined(self)) {
    if(isDefined(_id_CDC9BEE1ECFE4526))
      _id_CDC9BEE1ECFE4526 notify("uav_finished");

    if(uavtype == "uav" || uavtype == "directional_uav")
      _id_0172C4412DDE1696(level.minimaponbydefault);

    self[[level.uavsettings[uavtype].removefunc]]();

    if(isDefined(level.killstreakfinishusefunc) && !istrue(_id_D0BDCA2F09736813))
      level thread[[level.killstreakfinishusefunc]](self.streakinfo);

    if(isDefined(self.enemyobjid)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.enemyobjid);

      self notify("uav_deleteObjective");
    }

    self.streakinfo.expiredbydeath = !istrue(self.leftplayspace);

    if(!istrue(self.recordedgameendstats) && isDefined(_id_CDC9BEE1ECFE4526))
      _id_CDC9BEE1ECFE4526 scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

    if(isent(self))
      thread _id_E2FCE5A833321770();
    else
      self notify("death");
  }

  if(uavtype == "directional_uav") {
    if(isDefined(_id_CDC9BEE1ECFE4526) && !(_id_CDC9BEE1ECFE4526 scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch") || _id_CDC9BEE1ECFE4526 scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_comms")))
      _id_CDC9BEE1ECFE4526.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(player in level.players) {
        if(isDefined(player) && player.pers["team"] == _id_33EB8BE565CA82FA && !(player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch") || player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_comms")))
          player.radarshowenemydirection = 0;
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + uavtype, _id_CDC9BEE1ECFE4526);

  level notify("uav_update");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level notify("uav_finished", _id_CDC9BEE1ECFE4526);
}

_id_E2FCE5A833321770() {
  level endon("game_ended");
  wait 1;

  if(isDefined(self))
    self delete();
}

_id_C926982FF07FDEA5() {
  self endon("death");
  self endon("explode");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (isDefined(self.uavtype) && self.uavtype != "directional_uav"))
    self.owner scripts\engine\utility::waittill_any_2("death_or_disconnect", "joined_team");
  else
    self.owner scripts\engine\utility::waittill_any_2("disconnect", "joined_team");

  if(isent(self)) {
    self setscriptablepartstate("explode", "on", 0);
    self.damagetaken = self.maxhealth;
  }

  self notify("explode");
}

_id_D45F5CF5BFCE96DF() {
  self endon("death");
  self endon("explode");

  for(;;) {
    level waittill("host_migration_end");

    if(level.teambased) {
      foreach(_id_F90358454413407F in level.teamnamelist) {
        _id_EF13FD352AC5AFE6 = _id_5EC24D236512FD7A(_id_F90358454413407F);
        _id_484D86CE003C2526(_id_F90358454413407F, _id_EF13FD352AC5AFE6);
      }
    }
  }
}

_id_48E2105AFD534B62() {
  self endon("death");
  self endon("explode");

  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "uav_update");
    self hide();

    foreach(player in level.players) {
      if(level.teambased) {
        if(player.team != self.team)
          self showtoplayer(player);

        continue;
      }

      if(isDefined(self.owner) && player == self.owner) {
        continue;
      }
      self showtoplayer(player);
    }
  }
}

_id_2129B5EE9273A536() {
  self endon("death");
  self endon("explode");
  level endon("game_ended");
  self setCanDamage(1);
  self.damagetaken = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    _id_1FAA3D3DEC8D49BD = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "mapWeapon"))
      objweapon = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "mapWeapon")]](objweapon, inflictor);

    if(!isPlayer(attacker)) {
      if(!isDefined(self))
        return;
    } else {
      if(self.uavtype == "directional_uav" && (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET")) {
        continue;
      }
      if(isDefined(idflags) && idflags &level.idflags_penetration)
        self.wasdamagedfrombulletpenetration = 1;

      if(isDefined(idflags) && idflags &level.idflags_ricochet)
        self.wasdamagedfrombulletricochet = 1;

      self.wasdamaged = 1;
      _id_702BFC08FABD86CB = damage;

      if(isPlayer(attacker)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
          attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }

      _id_CB15FA5174E71840 = 1;
      _id_BE7C04516C5D9CCD = 1;
      _id_CA960A517459FE15 = 1;
      _id_8ACEB016BAAF67AF = 0;
      _id_64103C6B531D18F0 = 3;

      if(self.uavtype == "counter_uav") {
        _id_CB15FA5174E71840 = 1;
        _id_BE7C04516C5D9CCD = 2;
        _id_CA960A517459FE15 = 3;
        _id_8ACEB016BAAF67AF = 0;
        _id_64103C6B531D18F0 = 0;
      } else if(self.uavtype == "directional_uav") {
        _id_CB15FA5174E71840 = 5;
        _id_BE7C04516C5D9CCD = 6;
        _id_CA960A517459FE15 = 7;
        _id_8ACEB016BAAF67AF = 0;
        _id_64103C6B531D18F0 = 0;
      }

      if(isDefined(objweapon)) {
        if(istrue(_id_1FAA3D3DEC8D49BD))
          _id_702BFC08FABD86CB = damage;
        else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage"))
          _id_702BFC08FABD86CB = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, meansofdeath, _id_702BFC08FABD86CB, self.maxhealth, _id_CB15FA5174E71840, _id_BE7C04516C5D9CCD, _id_CA960A517459FE15, _id_8ACEB016BAAF67AF, _id_64103C6B531D18F0);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, meansofdeath, _id_702BFC08FABD86CB);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, getcompleteweaponname(objweapon));
      }

      self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
      self.currenthealth = self.currenthealth - _id_702BFC08FABD86CB;
      scripts\cp_mp\utility\killstreak_utility::_id_DB9562064A4DD635(self.currenthealth);

      if(self.damagetaken >= self.maxhealth) {
        if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
          _id_75B67453A730BB0D = level.uavsettings[self.uavtype].calloutdestroyed;
          _id_F444E68339293717 = "destroyed_" + self.uavtype;

          if(self.uavtype == "uav") {
            _id_F444E68339293717 = undefined;
            self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(self.uavtype, self.uavtype + "_destroyed", 1);
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.uavtype, attacker, objweapon, meansofdeath, damage, "destroyed_" + self.uavtype, _id_F444E68339293717, _id_75B67453A730BB0D, 1);

          if(isDefined(self.uavremotemarkedby) && self.uavremotemarkedby != attacker) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "remoteUAV_processTaggedAssist"))
              self.uavremotemarkedby thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "remoteUAV_processTaggedAssist")]]();
          }
        }

        self setscriptablepartstate("explode", "on", 0);
        self notify("explode");
        return;
      }
    }
  }
}

_id_1C832B851CA3A96A() {
  self setscriptablepartstate("body_damage_light", "on");
}

_id_4DB3B85258DA27BF() {
  self setscriptablepartstate("body_damage_medium", "on");
}

_id_AECE0522AF7087EF() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

_id_709BAFCC745FA088() {
  foreach(player in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_uav")) {
      return;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(!player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_expanded_minimap"))
        continue;
    }

    if(player.team == self.team) {
      continue;
    }
    thread _id_DC407442ACEAE01E(player);
  }
}

_id_DC407442ACEAE01E(_id_F52AA56CB91E736F) {
  level endon("game_ended");
  _id_F52AA56CB91E736F endon("disconnect");
  triggeroneoffradarsweep(_id_F52AA56CB91E736F);
  self waittill("death");
  triggeroneoffradarsweep(_id_F52AA56CB91E736F);
}

_id_5EC24D236512FD7A(team) {
  _id_5EE2D763A5B87E48 = getdvarint("scr_game_forceuav", 0);

  if(_id_5EE2D763A5B87E48)
    return _id_5EE2D763A5B87E48;
  else {
    activeuavs = level.activeuavs[team];
    _id_6F923CE59F2DBA50 = level.activeadvanceduavs[team];
    activecounteruavs = level.totalactivecounteruavs - level.activecounteruavs[team];
    return _id_933DF49E9A291165(activeuavs, _id_6F923CE59F2DBA50, activecounteruavs);
  }
}

_id_933DF49E9A291165(activeuavs, _id_6F923CE59F2DBA50, activecounteruavs) {
  _id_4FD7F4084E7FE2C8 = getuavstrengthmin();
  _id_4FFBEA084EA84782 = getuavstrengthmax();

  if(_id_6F923CE59F2DBA50)
    activeuavs = _id_4FFBEA084EA84782 - getuavstrengthlevelneutral();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && activecounteruavs > 0)
      radarstrength = _id_4FD7F4084E7FE2C8;
    else
      radarstrength = int(clamp(activeuavs + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemydirectional()));
  } else if(activecounteruavs > 0)
    radarstrength = _id_4FD7F4084E7FE2C8;
  else if(_id_6F923CE59F2DBA50 > 0)
    radarstrength = _id_4FFBEA084EA84782;
  else
    radarstrength = int(clamp(activeuavs + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));

  radarstrength = int(clamp(radarstrength, _id_4FD7F4084E7FE2C8, _id_4FFBEA084EA84782));
  return radarstrength;
}

_id_484D86CE003C2526(team, override) {
  _id_6F87F9454A77DF16(team, override);
}

_id_6F87F9454A77DF16(team, override) {
  if(isDefined(override))
    radarstrength = override;
  else
    radarstrength = _id_5EC24D236512FD7A(team);

  radarstrength = int(max(min(radarstrength, level.uavbestid), level.uavworstid));
  isradarblocked = radarstrength == level.uavworstid;
  hasradar = !isradarblocked;
  radarshowenemydirection = radarstrength >= level.uavdirectionalid;
  _id_70D48B6B51FF2964 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && level._id_48C4EDF71E075321[team];
  _id_F4A77AACC0EB8555 = !isradarblocked;
  _id_8E614CB0C3C1E3BC = radarstrength >= level.uavbestid || radarshowenemydirection || radarstrength == 1;

  if(radarstrength == level.uavnoneid) {
    radarmode = "normal_radar";
    hasradar = 0;
  } else if(_id_8E614CB0C3C1E3BC)
    radarmode = "constant_radar";
  else if(radarstrength == level.uavfastsweepid || _id_70D48B6B51FF2964 && getdvarint("dvar_61964E46CAB20802", 1) == 1)
    radarmode = "fast_radar";
  else
    radarmode = "normal_radar";

  players = level.players;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
    players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](team, "players");

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(istrue(player.insidecuavbunker)) {
      continue;
    }
    if(istrue(player.skipuavupdate)) {
      continue;
    }
    player.radarstrength = radarstrength;
    player.isradarblocked = isradarblocked;
    player.hasradar = hasradar;
    player.radarshowenemydirection = radarshowenemydirection;
    player.radarmode = radarmode;
    player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(_id_70D48B6B51FF2964 || player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_comms") || player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch"))
        player.radarshowenemydirection = 1;

      continue;
    }

    if(player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch") || player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_comms"))
      player.radarshowenemydirection = 1;
  }
}

_id_F9CAA46AA98B7C6B() {
  foreach(player in level.players) {
    if(istrue(player.insidecuavbunker)) {
      continue;
    }
    radarstrength = level.activeuavs[player.guid + "_radarStrength"];
    _id_9983D3ABA5D16152 = level.totalactivecounteruavs - level.activecounteruavs[player.guid];

    if(_id_9983D3ABA5D16152 > 0)
      radarstrength = level.uavworstid;

    radarstrength = int(max(min(radarstrength, level.uavbestid), level.uavworstid));
    player.radarstrength = radarstrength;
    _id_2D585091F9C4E974 = player.team == "spectator" || player.team == "codcaster" || player.team == "free";

    if(radarstrength <= level.uavnoneid || _id_2D585091F9C4E974) {
      player.hasradar = 0;
      player.radarshowenemydirection = 0;
      player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

      if(isDefined(player.radarmode) && player.radarmode == "constant_radar" && player.radarstrength != 1)
        player.radarmode = "normal_radar";

      continue;
    }

    if(radarstrength >= level.uavfastsweepid)
      player.radarmode = "fast_radar";
    else if(radarstrength == 1)
      player.radarmode = "constant_radar";
    else
      player.radarmode = "normal_radar";

    player.radarshowenemydirection = radarstrength >= level.uavdirectionalid;

    if(istrue(player.radarshowenemydirection))
      player.radarmode = "constant_radar";

    player.hasradar = 1;
    player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

    if(player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_overwatch") || player scripts\cp_mp\utility\player_utility::_id_EBA2F2E094684B8F("specialty_pc_comms"))
      player.radarshowenemydirection = 1;
  }
}

_id_F53DE0E99CB013E8() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");

  for(;;) {
    level waittill("stinger_fired", player, missile, _id_D1636A91C31CF68F);

    if(!isDefined(_id_D1636A91C31CF68F) || _id_D1636A91C31CF68F != self) {
      continue;
    }
    missile thread _id_247294E52128E3E7(_id_D1636A91C31CF68F, player);
  }
}

_id_4E53BA93EC09B58C() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

_id_E58C525D5D3A7482() {
  self endon("death");
  self endon("explode");
  self.owner endon("uav_finished");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

_id_0225E3594843D2AC(uavtype, _id_9B3DD3233F6F68A2, owner) {
  duration = level.uavsettings[uavtype].timeout;

  if(isDefined(_id_9B3DD3233F6F68A2))
    duration = _id_9B3DD3233F6F68A2;
  else if(isDefined(owner) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk") && owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_pc_comms"))
    duration = duration * getdvarfloat("dvar_E2990A1622A30B28", 1.3);

  self endon("death");
  self endon("explode");
  wait(duration);
  self notify("timeout");
}

_id_247294E52128E3E7(targetent, player) {
  self endon("death");
  _id_636C8575D7A7768B = distance(self.origin, targetent getpointinbounds(0, 0, 0));
  _id_EF16D44ED8107344 = targetent getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(targetent))
      center = _id_EF16D44ED8107344;
    else
      center = targetent getpointinbounds(0, 0, 0);

    _id_EF16D44ED8107344 = center;
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < _id_636C8575D7A7768B)
      _id_636C8575D7A7768B = _id_6B40B4C28ABE0A05;

    if(_id_6B40B4C28ABE0A05 > _id_636C8575D7A7768B) {
      if(_id_6B40B4C28ABE0A05 > 1536) {
        return;
      }
      radiusdamage(self.origin, 1536, 600, 600, player, "MOD_EXPLOSIVE", "iw9_la_gromeo_mp");
      self hide();
      self notify("deleted");
      waitframe();
      self delete();
      player notify("killstreak_destroyed");
    }

    waitframe();
  }
}

_id_A4D3120487C90203() {
  level.totalactiveuavs++;

  if(level.teambased) {
    level.activeuavs[self.team]++;

    if(_id_456CD43A5602EAAB()) {
      level._id_48C4EDF71E075321[self.team]++;
      self._id_90A35439909226CE = 1;
    }

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]++;
      level.activeadvanceduavcount++;
    }
  } else {
    level.activeuavs[self.owner.guid]++;
    level.activeuavs[self.owner.guid + "_radarStrength"]++;

    if(_id_456CD43A5602EAAB()) {
      level._id_48C4EDF71E075321[self.owner.guid] = scripts\engine\utility::_id_53C4C53197386572(level._id_48C4EDF71E075321[self.owner.guid], 0) + 1;
      self._id_90A35439909226CE = 1;
    }

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + 2;

      if(!isDefined(level.activeadvanceduavs[self.owner.guid]))
        level.activeadvanceduavs[self.owner.guid] = 0;

      level.activeadvanceduavs[self.owner.guid]++;
      level.activeadvanceduavcount++;
    }
  }
}

_id_24D8B56676D4D3D1() {
  if(level.teambased)
    level.activecounteruavs[self.team]++;
  else
    level.activecounteruavs[self.owner.guid]++;

  level.totalactivecounteruavs++;
}

_id_0B5950FBC92DB2FA() {
  if(level.teambased) {
    level.activeuavs[self.team]--;
    level.totalactiveuavs--;

    if(istrue(self._id_90A35439909226CE))
      level._id_48C4EDF71E075321[self.team]--;

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]--;
      level.activeadvanceduavcount--;
    }
  } else if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.totalactiveuavs--;
    level.activeuavs[self.owner.guid + "_radarStrength"]--;

    if(istrue(self._id_90A35439909226CE))
      level._id_48C4EDF71E075321[self.owner.guid]--;

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - 2;
      level.activeadvanceduavs[self.owner.guid]--;
      level.activeadvanceduavcount--;
    }
  }
}

_id_E02B5390559E651A() {
  if(level.teambased)
    level.activecounteruavs[self.team]--;
  else if(isDefined(self.owner))
    level.activecounteruavs[self.owner.guid]--;

  level.totalactivecounteruavs--;
}

_id_456CD43A5602EAAB() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(self.owner) && isPlayer(self.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_overwatch"))
        return 1;
    }
  }

  return 0;
}

_id_0972967E0C0A0FA8(uavtype, _id_51C1B45046E1647C) {
  uavrig = undefined;

  if(!scripts\cp_mp\utility\game_utility::islargemap()) {
    foreach(rig in level._id_5A26E5543A6559C8) {
      if(uavtype == rig.uavtype) {
        uavrig = rig;
        break;
      }
    }
  } else if(isDefined(level._id_5A26E5543A6559C8) && level._id_5A26E5543A6559C8.size >= 30)
    return undefined;

  if(!isDefined(uavrig)) {
    uavrig = spawn("script_model", _id_51C1B45046E1647C);
    uavrig setModel("tag_origin");
    uavrig.angles = (0, 115, 0);
    uavrig.uavtype = uavtype;
    uavrig hide();
    _id_CC5BC42930ABBC4F = 70;

    switch (uavtype) {
      case "counter_uav":
        _id_CC5BC42930ABBC4F = 125;
        break;
      case "directional_uav":
        _id_CC5BC42930ABBC4F = 200;
        break;
      case "default":
        break;
    }

    level._id_5A26E5543A6559C8[level._id_5A26E5543A6559C8.size] = uavrig;
    uavrig thread _id_71499194AF9A18FB(_id_CC5BC42930ABBC4F);

    if(scripts\cp_mp\utility\game_utility::islargemap())
      uavrig thread _id_0F30469ACA36707F(self);
    else
      uavrig thread _id_6D00913D6F8C862E();
  }

  return uavrig;
}

_id_71499194AF9A18FB(_id_CC5BC42930ABBC4F) {
  self endon("death");

  for(;;) {
    self rotateYaw(-360, _id_CC5BC42930ABBC4F);
    wait(_id_CC5BC42930ABBC4F);
  }
}

_id_0F30469ACA36707F(ent) {
  self endon("death");
  ent scripts\engine\utility::waittill_any_3("leaving", "explode", "death");
  level._id_5A26E5543A6559C8 = scripts\engine\utility::array_remove(level._id_5A26E5543A6559C8, self);
  self delete();
}

_id_6D00913D6F8C862E() {
  self endon("death");
  level waittill("game_ended");
  level._id_5A26E5543A6559C8 = scripts\engine\utility::array_remove(level._id_5A26E5543A6559C8, self);
  self delete();
}

_id_F54B6539DC6A4A1C() {
  self.owner endon("disconnect");
  self endon("uav_deleteObjective");
  self endon("death");

  switch (self.uavtype) {
    case "uav":
      _id_30F120A1EFC1DCBE = "hud_icon_minimap_killstreak_uav";
      break;
    case "counter_uav":
      _id_30F120A1EFC1DCBE = "hud_icon_minimap_killstreak_cuav";
      break;
    case "directional_uav":
      _id_30F120A1EFC1DCBE = "hud_icon_minimap_killstreak_auav";
      break;
    default:
      _id_30F120A1EFC1DCBE = "hud_icon_minimap_killstreak_uav";
  }

  _id_68E354FCEB08D97B = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    _id_68E354FCEB08D97B = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjectiveEngineer");

  if(isDefined(_id_68E354FCEB08D97B))
    self.enemyobjid = self[[_id_68E354FCEB08D97B]](_id_30F120A1EFC1DCBE, 1, 1);

  _id_67C48E4D4E56AFEC = 0;

  for(;;) {
    _id_D12A341B40354143 = level.players.size;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      if(_id_67C48E4D4E56AFEC >= level.players.size)
        _id_67C48E4D4E56AFEC = 0;

      player = level.players[_id_67C48E4D4E56AFEC];
      _id_67C48E4D4E56AFEC++;

      if(!isDefined(player)) {
        continue;
      }
      if(self.enemyobjid != -1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, player);
            continue;
          }

          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.enemyobjid, player);
        }
      }
    }

    waitframe();
  }
}

_id_0172C4412DDE1696(_id_3865C2769DE404EC) {
  index = undefined;

  if(level.teambased)
    index = self.team;
  else
    index = self.owner.guid;

  foreach(player in level.players) {
    if(isai(player)) {
      continue;
    }
    if(level.teambased && self.team != player.team) {
      continue;
    }
    if(!level.teambased && self.owner != player) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(istrue(_id_3865C2769DE404EC)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }
}

_id_E9A20F47C6B49BD7() {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  level endon("game_ended");

  if(istrue(level.istacops)) {
    return;
  }
  for(;;) {
    level waittill("player_spawned", player);

    if(isai(player)) {
      continue;
    }
    if(level.teambased && self.team != player.team) {
      continue;
    }
    if(!level.teambased && self.owner != player) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

    player.showuavminimaponspawn = 1;
  }
}

_id_C11936B9C6C3A076(player, waittime) {
  if(isDefined(waittime))
    wait(waittime);

  _id_4AB6BD0A2EF31735 = getdvarint("scr_game_forceuav");
  _id_2DBCBBE66AA95FAF = "normal_radar";
  _id_D4BA376A6B70977D = 1;
  activeadvanceduavs = 0;

  switch (_id_4AB6BD0A2EF31735) {
    case 1:
      _id_2DBCBBE66AA95FAF = "constant_radar";
      break;
    case 3:
      _id_2DBCBBE66AA95FAF = "normal_radar";
      break;
    case 5:
      _id_2DBCBBE66AA95FAF = "fast_radar";
      _id_D4BA376A6B70977D = 2;
      break;
    case 6:
      _id_2DBCBBE66AA95FAF = "constant_radar";
      activeadvanceduavs = 1;
      break;
    default:
      break;
  }

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      level.radarmode[_id_F90358454413407F] = _id_2DBCBBE66AA95FAF;
      level.activeuavs[_id_F90358454413407F] = _id_D4BA376A6B70977D;
      level.activeadvanceduavs[_id_F90358454413407F] = activeadvanceduavs;
      level.activeadvanceduavcount = level.teamnamelist.size;
      _id_484D86CE003C2526(_id_F90358454413407F, _id_4AB6BD0A2EF31735);
    }
  } else {
    _id_D4BA376A6B70977D = _id_4AB6BD0A2EF31735;
    level.radarmode[player.guid] = _id_2DBCBBE66AA95FAF;
    player.radarstrength = _id_D4BA376A6B70977D;
    level.activeuavs[player.guid + "_radarStrength"] = _id_D4BA376A6B70977D;
    level.activeadvanceduavs[player.guid] = activeadvanceduavs;
    level.activeadvanceduavcount = level.teamnamelist.size;
    _id_F9CAA46AA98B7C6B();
  }
}