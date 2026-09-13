/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\player.gsc
***********************************************/

getstancecenter() {
  if(self getstance() == "crouch")
    center = self.origin + (0, 0, 24);
  else if(self getstance() == "prone")
    center = self.origin + (0, 0, 10);
  else
    center = self.origin + (0, 0, 32);

  return center;
}

getstancetop(_id_2EEA482C1A2F43A9) {
  _id_6497396FB64EA3B9 = self getstance();

  if(isDefined(_id_2EEA482C1A2F43A9))
    _id_6497396FB64EA3B9 = _id_2EEA482C1A2F43A9;

  if(_id_6497396FB64EA3B9 == "crouch")
    top = self.origin + (0, 0, 48);
  else if(_id_6497396FB64EA3B9 == "prone")
    top = self.origin + (0, 0, 20);
  else
    top = self.origin + (0, 0, 64);

  return top;
}

isreallyalive(player) {
  return isalive(player) && !isDefined(player.fauxdead) && !istrue(player.delayedspawnedplayernotify) && !istrue(player._id_C4C8B91E0B16AA5E);
}

isinlaststand(player) {
  return istrue(player.inlaststand);
}

_id_AD443BBCDCF37B85(player) {
  return isDefined(player) && isreallyalive(player) && !isinlaststand(player);
}

isarchetype(type) {
  return isDefined(self.loadoutarchetype) && type == self.loadoutarchetype;
}

isplayerads() {
  return self playerads() > 0.5;
}

setthirdpersondof(_id_E60552DD6ABCC4AA) {
  if(_id_E60552DD6ABCC4AA)
    setdof_thirdperson();
  else
    setdof_default();
}

updatesessionstate(sessionstate, statusicon) {
  _id_A217588641BB68AA = sessionstate;

  if(istrue(self._id_C4C8B91E0B16AA5E)) {
    if(self.sessionstate == "playing_but_spectating" && (sessionstate == "dead" || sessionstate == "spectator")) {
      printspawnmessage("player::updateSessionState() didn't not update because we are in liveRagdoll");
      return;
    }

    if(sessionstate == "playing_but_spectating") {
      _id_A217588641BB68AA = "spectator";

      if(getdvarint("killswitch_cyberrevivedeathcamenabled", 1) == 0)
        thread _id_FDFF38028C016239();
    }
  }

  switch (sessionstate) {
    case "intermission":
    case "playing":
      statusicon = "";
      break;
    case "spectator":
    case "dead":
      if(istrue(level.doingbroshot))
        statusicon = "";
      else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable))
          statusicon = "hud_status_dogtag";
        else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "hud_status_revive_or")
            statusicon = "hud_status_revive_or";
          else
            statusicon = "hud_status_revive_wh";
        } else
          statusicon = "hud_status_dead";
      } else
        statusicon = "hud_status_dead";

      break;
  }

  if(!isDefined(statusicon))
    statusicon = "";

  self.sessionstate = sessionstate;
  self.statusicon = statusicon;
  self setclientomnvar("ui_session_state", _id_A217588641BB68AA);
  printspawnmessage("player::updateSessionState() " + sessionstate);
}

getteamarray(team, _id_DCC07FCC8A9BEB59) {
  _id_5A9CFC3686B1FD8D = [];

  if(!isDefined(_id_DCC07FCC8A9BEB59) || _id_DCC07FCC8A9BEB59) {
    foreach(player in level.characters) {
      if(isDefined(player.team) && player.team == team)
        _id_5A9CFC3686B1FD8D[_id_5A9CFC3686B1FD8D.size] = player;
    }
  } else {
    foreach(player in level.players) {
      if(isDefined(player.team) && player.team == team)
        _id_5A9CFC3686B1FD8D[_id_5A9CFC3686B1FD8D.size] = player;
    }
  }

  return _id_5A9CFC3686B1FD8D;
}

get_players_watching(_id_CC5C77BB957E98B6, _id_F76A004F9481F43B) {
  if(!isDefined(_id_CC5C77BB957E98B6))
    _id_CC5C77BB957E98B6 = 0;

  if(!isDefined(_id_F76A004F9481F43B))
    _id_F76A004F9481F43B = 0;

  _id_ADE4ED7FADBA8194 = self getentitynumber();
  _id_FE0EB2C2C884F27B = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    _id_7BEC920EEA9088E7 = 0;

    if(!_id_F76A004F9481F43B) {
      if(isDefined(player.team) && (player.team == "spectator" || player.team == "codcaster" || player.sessionstate == "spectator")) {
        _id_13C5603D4BEEA2FC = player getspectatingplayer();

        if(isDefined(_id_13C5603D4BEEA2FC) && _id_13C5603D4BEEA2FC == self)
          _id_7BEC920EEA9088E7 = 1;
      }

      if(player.forcespectatorclient == _id_ADE4ED7FADBA8194)
        _id_7BEC920EEA9088E7 = 1;
    }

    if(!_id_CC5C77BB957E98B6) {
      if(player.killcamentity == _id_ADE4ED7FADBA8194)
        _id_7BEC920EEA9088E7 = 1;
    }

    if(_id_7BEC920EEA9088E7)
      _id_FE0EB2C2C884F27B[_id_FE0EB2C2C884F27B.size] = player;
  }

  return _id_FE0EB2C2C884F27B;
}

set_visionset_for_watching_players(_id_204BD93152055BA6, _id_98B0A8EC6EEFF568, _id_E0D7F346BD955CDC, _id_FC0B50F08DA38B65, _id_CC5C77BB957E98B6, _id_F76A004F9481F43B) {
  _id_FE0EB2C2C884F27B = get_players_watching(_id_CC5C77BB957E98B6, _id_F76A004F9481F43B);

  foreach(player in _id_FE0EB2C2C884F27B) {
    player notify("changing_watching_visionset");

    if(isDefined(_id_FC0B50F08DA38B65) && _id_FC0B50F08DA38B65)
      player visionsetmissilecamforplayer(_id_204BD93152055BA6, _id_98B0A8EC6EEFF568);
    else
      player visionsetnakedforplayer(_id_204BD93152055BA6, _id_98B0A8EC6EEFF568);

    if(_id_204BD93152055BA6 != "" && isDefined(_id_E0D7F346BD955CDC)) {
      player thread reset_visionset_on_team_change(self, _id_98B0A8EC6EEFF568 + _id_E0D7F346BD955CDC);
      player thread reset_visionset_on_disconnect(self);

      if(player isinkillcam())
        player thread reset_visionset_on_spawn();
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0.0);
}

reset_visionset_on_team_change(_id_D6263EBE22D2BEE2, _id_E4B1EE6125B0D25B) {
  self endon("changing_watching_visionset");
  _id_F139A82799F5B68E = gettime();
  _id_388AED5DC0074606 = self.team;

  while(gettime() - _id_F139A82799F5B68E < _id_E4B1EE6125B0D25B * 1000) {
    if(self.team != _id_388AED5DC0074606 || !scripts\engine\utility::array_contains(_id_D6263EBE22D2BEE2 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

reset_visionset_on_disconnect(_id_2907DF9A672DE3D6) {
  self endon("changing_watching_visionset");
  _id_2907DF9A672DE3D6 waittill("disconnect");
  self visionsetnakedforplayer("", 0.0);
}

restorebasevisionset(_id_F69BA8D7B96E8326) {
  if(istrue(level.wpinprogress)) {
    return;
  }
  if(isDefined(self._id_054E863EBAD3E233))
    self visionsetnakedforplayer(self._id_054E863EBAD3E233, _id_F69BA8D7B96E8326);
  else
    self visionsetnakedforplayer("", _id_F69BA8D7B96E8326);
}

init_visionsetnight() {
  visionsetnight("iw9_mp_nvg_base_color");
}

overridevisionsetnightforlevel(_id_F3C168134A5DDAE7) {
  visionsetnight(_id_F3C168134A5DDAE7);
}

getuniqueid() {
  if(!isDefined(self))
    return undefined;

  if(isDefined(self.pers["guid"]))
    return self.pers["guid"];

  _id_14EF0ACE56787531 = self getguid();

  if(_id_14EF0ACE56787531 == "0000000000000000") {
    if(isDefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    _id_14EF0ACE56787531 = "script" + level.guidgen;
  }

  self.pers["guid"] = _id_14EF0ACE56787531;
  return self.pers["guid"];
}

getplayersinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A) {
  if(radius <= 0)
    return [];

  _id_2649564EBA242B56 = undefined;

  if(isDefined(_id_24EE99FA6D091C2A)) {
    if(isarray(_id_24EE99FA6D091C2A))
      _id_2649564EBA242B56 = _id_24EE99FA6D091C2A;
    else
      _id_2649564EBA242B56 = [_id_24EE99FA6D091C2A];
  }

  results = physics_querypoint(origin, radius, physics_createcontents(["physicscontents_characterproxy"]), _id_2649564EBA242B56, "physicsquery_all");
  _id_815AAE0BD650B698 = [];

  if(!isDefined(_id_BEB392BBB338D308)) {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e))
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e) && isDefined(e.team) && e.team == _id_BEB392BBB338D308)
        _id_815AAE0BD650B698[_id_815AAE0BD650B698.size] = e;
    }
  }

  return _id_815AAE0BD650B698;
}

getplayersinradiusview(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A) {
  _id_305F0639560A5707 = [];
  _id_E965BCE0774276B4 = getplayersinradius(origin, radius, _id_BEB392BBB338D308, _id_24EE99FA6D091C2A);

  foreach(player in _id_E965BCE0774276B4) {
    _id_EAB3E7369809E8CC = undefined;
    _id_D895C679F6A927E5 = [player gettagorigin("j_head"), player gettagorigin("j_mainroot"), player gettagorigin("tag_origin")];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
      if(!scripts\engine\trace::ray_trace_passed(origin, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }
      if(!isDefined(_id_EAB3E7369809E8CC)) {
        _id_305F0639560A5707[_id_305F0639560A5707.size] = spawnStruct();
        _id_305F0639560A5707[_id_305F0639560A5707.size - 1].player = player;
        _id_305F0639560A5707[_id_305F0639560A5707.size - 1].visiblelocations = [];
        _id_EAB3E7369809E8CC = 1;
      }

      _id_305F0639560A5707[_id_305F0639560A5707.size - 1].visiblelocations[_id_305F0639560A5707[_id_305F0639560A5707.size - 1].visiblelocations.size] = _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8];
    }
  }

  return _id_305F0639560A5707;
}

isfriendly(_id_DA8CEC9BCE12F9CB, _id_C4B81997F0120A97) {
  if(!level.teambased)
    return 0;

  if(!isPlayer(_id_C4B81997F0120A97) && !isDefined(_id_C4B81997F0120A97.team))
    return 0;

  if(_id_DA8CEC9BCE12F9CB != _id_C4B81997F0120A97.team)
    return 0;

  return 1;
}

_enablecollisionnotifies(_id_E3108E412AFB3811) {
  if(!isDefined(self.enabledcollisionnotifies))
    self.enabledcollisionnotifies = 0;

  if(_id_E3108E412AFB3811) {
    if(self.enabledcollisionnotifies == 0)
      self enablecollisionnotifies(1);

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1)
      self enablecollisionnotifies(0);

    self.enabledcollisionnotifies--;
  }
}

allow_dodge(_id_E3108E412AFB3811) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }
  if(_id_E3108E412AFB3811) {
    if(!isDefined(self.disableddodge))
      self.disableddodge = 0;

    self.disableddodge--;

    if(!self.disableddodge)
      self allowdodge(1);
  } else {
    if(!isDefined(self.disableddodge))
      self.disableddodge = 0;

    self.disableddodge++;
    self allowdodge(0);
  }
}

isplayerproxyagent(ent, player) {
  _id_873068C8552B41EC = 0;

  if(isagent(ent) && isDefined(ent.agent_type) && ent.agent_type == "playerProxy") {
    if(ent.owner == player)
      _id_873068C8552B41EC = 1;
  }

  return _id_873068C8552B41EC;
}

enableragdollzerog(_id_8B461603A1F825D3, scale) {
  if(_id_8B461603A1F825D3) {
    physics_setgravityragdollscalar(scale);
    level.ragdollzerog = 1;
  } else {
    physics_setgravityragdollscalar(1.0);
    level.ragdollzerog = undefined;
  }
}

isragdollzerog() {
  return istrue(level.ragdollzerog);
}

_visionsetnaked(_id_FC0043E95242D5CB, time) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isai(player)) {
      continue;
    }
    player visionsetnakedforplayer(_id_FC0043E95242D5CB, time);
  }

  return;
}

_id_0D93211A15C000CD(victim, attacker, _id_D198B30DC157C5CD, contentoverride) {
  _id_AD4D55FD441C70BD = undefined;

  if(isDefined(victim.origin))
    _id_AD4D55FD441C70BD = victim.origin;
  else if(isDefined(victim.lastdeathpos))
    _id_AD4D55FD441C70BD = victim.lastdeathpos;

  if(!isDefined(_id_AD4D55FD441C70BD)) {
    logstring("Undefined deathPos for death ragdoll 3rd person camera.");
    return undefined;
  }

  _id_9F18D28AD3FBB53D = undefined;

  if(!isDefined(attacker) || victim == attacker) {
    _id_90B08876A946FDF5 = anglesToForward(victim.angles);
    _id_90B08876A946FDF5 = _func_767CEA82B001F645(_id_90B08876A946FDF5);
    _id_9F18D28AD3FBB53D = [victim];
  } else {
    _id_90B08876A946FDF5 = vectorNormalize(_id_AD4D55FD441C70BD - attacker.origin);
    _id_9F18D28AD3FBB53D = [victim, attacker];
  }

  baseangles = generateaxisanglesfromforwardvector(_id_90B08876A946FDF5, (0, 0, 1));
  _id_AC59002AA0721741 = 200;
  _id_EFF05A57CE34E3EA = 30;
  _id_519305604D8E28E4 = 360 / _id_EFF05A57CE34E3EA;
  _id_6095EFE86105E553 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_519305604D8E28E4; _id_AC0E594AC96AA3A8++) {
    _id_58F17FBB36DC3C08 = anglesToForward(baseangles + (0, _id_EFF05A57CE34E3EA * _id_AC0E594AC96AA3A8, 0));
    _id_81AA7E8BC8F8C030 = _id_AD4D55FD441C70BD + (0, 0, 12);
    _id_F37EF469027DCFA1 = _id_AD4D55FD441C70BD + _id_58F17FBB36DC3C08 * _id_AC59002AA0721741 + (0, 0, 150);
    trace = scripts\engine\trace::sphere_trace(_id_81AA7E8BC8F8C030, _id_F37EF469027DCFA1, 2, _id_9F18D28AD3FBB53D, contentoverride);

    if(isDefined(trace) && trace["fraction"] > 0.99) {
      _id_6095EFE86105E553[_id_6095EFE86105E553.size] = trace["position"];

      if(!istrue(_id_D198B30DC157C5CD)) {
        break;
      }
    }
  }

  _id_12B614F64A9BA025 = undefined;

  if(_id_6095EFE86105E553.size > 0)
    _id_12B614F64A9BA025 = _id_6095EFE86105E553[0];
  else
    _id_12B614F64A9BA025 = _id_AD4D55FD441C70BD + anglesToForward(baseangles) * 50 + (0, 0, 80);

  _id_50A4E909A80B4AAE = vectorNormalize(_id_AD4D55FD441C70BD - _id_12B614F64A9BA025);
  _id_379DE5A38F0E582A = spawnStruct();
  _id_379DE5A38F0E582A.origin = _id_12B614F64A9BA025;
  _id_379DE5A38F0E582A.angles = vectortoangles(_id_50A4E909A80B4AAE);
  _id_379DE5A38F0E582A.distance = _id_AC59002AA0721741;
  _id_379DE5A38F0E582A._id_6095EFE86105E553 = _id_6095EFE86105E553;
  return _id_379DE5A38F0E582A;
}

_id_FDFF38028C016239() {
  self endon("disconnect");
  _id_A92E3D2FF7AF10C9 = _id_6D606D81EA9AB50B(0, 0);
  self._id_7C813E50FF75BE27 = undefined;
  wait(getdvarfloat("scr_death_scene_time", 1.75));
  scripts\mp\killcam::_id_7A8A04D15AD052D5();
  self allowspectateteam(self.team, 1);
  self cameraunlink();
  _id_A92E3D2FF7AF10C9 delete();
}

_id_6D606D81EA9AB50B(_id_81AA39B3E585CD66, _id_D198B30DC157C5CD, contentoverride) {
  if(!isDefined(_id_81AA39B3E585CD66))
    _id_81AA39B3E585CD66 = 0;

  _id_379DE5A38F0E582A = _id_0D93211A15C000CD(self, self.attacker, _id_D198B30DC157C5CD, contentoverride);

  if(!isDefined(_id_379DE5A38F0E582A))
    return undefined;

  _id_A92E3D2FF7AF10C9 = spawn("script_model", _id_379DE5A38F0E582A.origin);
  _id_A92E3D2FF7AF10C9 setModel("tag_origin");
  _id_A92E3D2FF7AF10C9.angles = _id_379DE5A38F0E582A.angles;
  _id_A92E3D2FF7AF10C9.data = _id_379DE5A38F0E582A;
  playermover = self getmovingplatformparent();

  if(isDefined(playermover))
    _id_A92E3D2FF7AF10C9 linkTo(playermover);

  self allowspectateallteams(0);
  self cameralinkTo(_id_A92E3D2FF7AF10C9, "tag_origin", 1, _id_81AA39B3E585CD66);
  return _id_A92E3D2FF7AF10C9;
}

hidehudenable() {
  if(!isDefined(self.ui_hudhidden))
    self.hidehudenabled = 0;

  if(self.hidehudenabled == 0)
    self setclientomnvar("ui_hide_hud", 1);

  self.hidehudenabled++;
}

hidehuddisable() {
  if(self.hidehudenabled == 1)
    self setclientomnvar("ui_hide_hud", 0);

  self.hidehudenabled--;
}

hidehudclear() {
  self.hidehudenabled = undefined;
  self setclientomnvar("ui_hide_hud", 0);
}

hideminimap(_id_CB4F608693686CB0) {
  if(alwaysshowminimap() && !istrue(_id_CB4F608693686CB0)) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  _id_5546BBD6B68A186D = self.minimapstatetracker;
  self.minimapstatetracker--;

  if(self.minimapstatetracker < 0)
    self.minimapstatetracker = 0;

  if(istrue(_id_CB4F608693686CB0) || self.minimapstatetracker == 0 && _id_5546BBD6B68A186D > self.minimapstatetracker) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(_id_CB4F608693686CB0))
      self.minimapstatetracker = 0;
  }
}

showminimap() {
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  _id_5546BBD6B68A186D = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && _id_5546BBD6B68A186D < self.minimapstatetracker)
    self setclientomnvar("ui_hide_minimap", 0);
}

alwaysshowminimap() {
  return istrue(level.minimaponbydefault);
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

getlowestclientnum(players, _id_E1FEA15FF7126A10) {
  _id_F08BC22AABB76CC0 = undefined;

  foreach(player in players) {
    if(player.team != "spectator" && player.team != "codcaster" && (!_id_E1FEA15FF7126A10 || player scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(_id_F08BC22AABB76CC0) || player getentitynumber() < _id_F08BC22AABB76CC0)
        _id_F08BC22AABB76CC0 = player getentitynumber();
    }
  }

  return _id_F08BC22AABB76CC0;
}

setusingremote(_id_7B0C72F7301EB1C4) {
  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = _id_7B0C72F7301EB1C4;

  if(scripts\mp\equipment\nvg::_id_258C5E445C8B7F80())
    _id_3B64EB40368C1450::set("usingRemote", "nvg", 0);

  _id_3B64EB40368C1450::set("usingRemote", "vehicle_use", 0);
  _id_3B64EB40368C1450::set("usingRemote", "crate_use", 0);
  _id_3B64EB40368C1450::set("usingRemote", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("usingRemote", "ads", 0);
  _id_3B64EB40368C1450::set("usingRemote", "ascender_use", 0);
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
  scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
}

getremotename() {
  return self.usingremote;
}

clearusingremote(_id_2C111F02D48E2671) {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("usingRemote");
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isDefined(_id_2C111F02D48E2671))
    _freezecontrols(0, undefined, "usingRemote");

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

_freezecontrols(frozen, _id_F8048727716242B0, debug) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
    self.pers["controllerFreezeDebug"] = [];
  }

  if(frozen)
    self.pers["controllerFreezeStack"]++;
  else if(istrue(_id_F8048727716242B0))
    self.pers["controllerFreezeStack"] = 0;
  else
    self.pers["controllerFreezeStack"]--;

  if(isDefined(debug)) {
    if(getdvarint("dvar_FC8A67F104CC90A6", 0))
      logstring("IW9-676465: Player " + self.name + " called _freezeControls( " + frozen + ", " + istrue(_id_F8048727716242B0) + ", \"" + debug + "\" )");

    if(frozen) {
      if(!isDefined(self.pers["controllerFreezeDebug"][debug]))
        self.pers["controllerFreezeDebug"][debug] = 0;

      self.pers["controllerFreezeDebug"][debug]++;
    } else if(istrue(_id_F8048727716242B0))
      self.pers["controllerFreezeDebug"] = [];
    else if(!isDefined(self.pers["controllerFreezeDebug"][debug]) || self.pers["controllerFreezeDebug"][debug] == 0) {} else {
      self.pers["controllerFreezeDebug"][debug]--;

      if(self.pers["controllerFreezeDebug"][debug] == 0)
        self.pers["controllerFreezeDebug"][debug] = undefined;
    }
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
  } else {
    self freezecontrols(1);
    self.controlsfrozen = 1;
  }
}

_id_5471A04FAAD16A00() {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
    self.pers["controllerFreezeDebug"] = [];
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
  } else {
    self freezecontrols(1);
    self.controlsfrozen = 1;

    if(getdvarint("dvar_FC8A67F104CC90A6", 0)) {
      _id_D1D0A8A55841E44C = "";

      if(isDefined(self.pers["controllerFreezeDebug"])) {
        foreach(context, _id_E08B864F74E95717 in self.pers["controllerFreezeDebug"])
        _id_D1D0A8A55841E44C = _id_D1D0A8A55841E44C + (context + "=" + _id_E08B864F74E95717 + " | ");
      }

      logstring("IW9-676465: Player " + self.name + " was frozen after a _refreshFreezeControls(). Freeze Debug Stack: " + _id_D1D0A8A55841E44C);
    }
  }
}

_id_8213D31F7A3C32E2() {
  _id_CD87B28B548D9F4A = 0;

  if(isDefined(self.pers["controllerFreezeStack"]))
    _id_CD87B28B548D9F4A = self.pers["controllerFreezeStack"];

  if(_id_CD87B28B548D9F4A <= 0) {
    return;
  }
  _id_D1D0A8A55841E44C = "";

  if(isDefined(self.pers["controllerFreezeDebug"])) {
    foreach(context, _id_E08B864F74E95717 in self.pers["controllerFreezeDebug"])
    _id_D1D0A8A55841E44C = _id_D1D0A8A55841E44C + (context + "=" + _id_E08B864F74E95717 + " | ");
  }
}

_freezelookcontrols(frozen, _id_F8048727716242B0) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerLookFreezeStack"]))
    self.pers["controllerLookFreezeStack"] = 0;

  if(frozen)
    self.pers["controllerLookFreezeStack"]++;
  else if(istrue(_id_F8048727716242B0))
    self.pers["controllerLookFreezeStack"] = 0;
  else
    self.pers["controllerLookFreezeStack"]--;

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self.lookcontrolsfrozen = 0;
  } else {
    self freezelookcontrols(1);
    self.lookcontrolsfrozen = 1;
  }
}

getplayerforguid(guid) {
  foreach(player in level.players) {
    if(player.guid == guid)
      return player;
  }

  return undefined;
}

set_temp_energy_restore_rate(_id_A693D55954AF1208, _id_9A4C48942AA8C4D1, time, _id_4E846C387C082C5E) {
  _id_4C1E617DEAA58718 = self energy_getrestorerate(_id_A693D55954AF1208);
  self.temprateset = 1;
  self energy_setrestorerate(_id_A693D55954AF1208, _id_9A4C48942AA8C4D1);

  if(!isDefined(_id_4E846C387C082C5E) || !_id_4E846C387C082C5E)
    wait(time);
  else {
    _id_F91D73BCC743D785 = self energy_getmax(_id_A693D55954AF1208);

    for(;;) {
      if(self energy_getenergy(_id_A693D55954AF1208) >= _id_F91D73BCC743D785) {
        break;
      }

      waitframe();
    }
  }

  self energy_setrestorerate(_id_A693D55954AF1208, _id_4C1E617DEAA58718);
  self.temprateset = 0;
}

set_temp_energy_rest_time(_id_A693D55954AF1208, tempresttime, time, _id_4E846C387C082C5E) {
  _id_25C4D960831FD0A1 = self energy_getresttimems(_id_A693D55954AF1208);
  self.tempresttime = 1;
  self energy_setresttimems(_id_A693D55954AF1208, tempresttime);

  if(!isDefined(_id_4E846C387C082C5E) || !_id_4E846C387C082C5E)
    wait(time);
  else {
    _id_F91D73BCC743D785 = self energy_getmax(_id_A693D55954AF1208);

    for(;;) {
      if(self energy_getenergy(_id_A693D55954AF1208) >= _id_F91D73BCC743D785) {
        break;
      }

      waitframe();
    }
  }

  self energy_setresttimems(_id_A693D55954AF1208, _id_25C4D960831FD0A1);
  self.tempresttime = 0;
}

_enableignoreme() {
  if(!isDefined(self.enabledignoreme))
    self.enabledignoreme = 0;

  if(self.enabledignoreme == 0)
    self.ignoreme = 1;

  self.enabledignoreme++;
}

_disableignoreme() {
  if(self.enabledignoreme == 1)
    self.ignoreme = 0;

  self.enabledignoreme--;
}

_resetenableignoreme() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

watchbuttonPressed(key, commanddown, commandup, _id_833370DF65011BAB) {
  if(!isDefined(self.buttonspressed))
    self.buttonspressed = [];

  if(!isDefined(self.buttonspressed[key])) {
    struct = spawnStruct();
    struct.player = self;
    struct.key = key;
    struct.commanddown = commanddown;
    struct.commandup = commandup;
    struct.notifydown = key + "_buttonDown";
    struct.notifyup = key + "_buttonUp";
    struct.pressed = istrue(_id_833370DF65011BAB);
    self.buttonspressed[key] = struct;
    struct thread watchbuttonpressedinternal();
  }
}

getbuttonPressed(key) {
  if(!isDefined(self.buttonspressed))
    return 0;

  if(!isDefined(self.buttonspressed[key]))
    return 0;

  return self.buttonspressed[key].pressed;
}

watchbuttonpressedend(key) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[key]) {
    return;
  }
  self.buttonspressed[key] notify("watchButtonPressedEnd");
  self.buttonspressed[key] = undefined;
}

watchbuttonpressedinternal() {
  self.player endon("disconnect");
  self endon("watchButtonPressedEnd");

  for(;;) {
    self.down = 0;
    self.up = 0;
    childthread watchbuttondown();
    childthread watchbuttonup();
    self waittill("start_race");
    waittillframeend;
    self notify("end_race");

    if(self.down && self.up) {
      continue;
    }
    if(self.down) {
      self.pressed = 1;
      continue;
    }

    self.pressed = 0;
  }
}

watchbuttondown() {
  self endon("end_race");
  self.player notifyonplayercommand(self.notifydown, self.commanddown);
  self.player waittill(self.notifydown);
  self.down = 1;
  self notify("start_race");
}

watchbuttonup() {
  self endon("end_race");
  self.player notifyonplayercommand(self.notifyup, self.commandup);
  self.player waittill(self.notifyup);
  self.up = 1;
  self notify("start_race");
}

watchbuttonpressendondisconnect() {
  self endon("watchButtonPressedEnd");
  self.player waittill("disconnect");
  self notify("watchButtonPressedEnd");
}

_setdof_internal(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur) {
  if(1) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  _id_E0AF59BA48C8CB09 = max(_id_E0AF59BA48C8CB09, 0.0);
  _id_FF6B46DA0D04E078 = clamp(_id_FF6B46DA0D04E078, 1.0, 9994.0);
  _id_2FE3DC2F1289D072 = clamp(_id_2FE3DC2F1289D072, 2.0, 9998.0);
  _id_7A6976D1E774FE57 = clamp(_id_7A6976D1E774FE57, 3.0, 9999);

  if(_id_2FE3DC2F1289D072 > 9994.0)
    farblur = 0.0;
}

setdof_dynamic() {
  self endon("death_or_disconnect");
  setdof_default();

  if(isai(self)) {
    return;
  }
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_8D727BC70842A709 = ["physicscontents_characterproxy"];
  _id_30D537EA3164E799 = physics_createcontents(_id_8D727BC70842A709);
  _id_1C1624BD5CBDD4D2 = 1;
  _id_6E047C983826AE33 = 1;
  _id_2E3C1D928388C537 = cos(27);
  _id_A906BE9CEA201732 = 1;
  _id_641EF3FC1EF694A5 = 0;
  _id_03206C3880F4B4D7 = [];
  _id_03206C3880F4B4D7["geo"] = spawnStruct();
  _id_03206C3880F4B4D7["geo"].nearstartfactor = getdvarfloat("dof_nearstart_geo", 0.01);
  _id_03206C3880F4B4D7["geo"].nearendfactor = getdvarfloat("dof_nearend_geo", 0.95);
  _id_03206C3880F4B4D7["geo"].farstartfactor = getdvarfloat("dvar_03207700A54CD601", 1.5);
  _id_03206C3880F4B4D7["geo"].farendfactor = getdvarfloat("dof_farend_geo", 2.5);
  _id_03206C3880F4B4D7["geo"].nearblur = getdvarfloat("dof_nearblur_geo", 3.9);
  _id_03206C3880F4B4D7["geo"].farblur = getdvarfloat("dof_farblur_geo", 2.25);
  _id_03206C3880F4B4D7["interest"] = spawnStruct();
  _id_03206C3880F4B4D7["interest"].nearstartfactor = getdvarfloat("dof_nearstart", 0.01);
  _id_03206C3880F4B4D7["interest"].nearendfactor = getdvarfloat("dof_nearend", 0.95);
  _id_03206C3880F4B4D7["interest"].farstartfactor = getdvarfloat("dof_farstart", 1.5);
  _id_03206C3880F4B4D7["interest"].farendfactor = getdvarfloat("dof_farend", 2.5);
  _id_03206C3880F4B4D7["interest"].nearblur = getdvarfloat("dof_nearblur", 7.0);
  _id_03206C3880F4B4D7["interest"].farblur = getdvarfloat("dof_farblur", 3.5);

  for(;;) {
    waitframe();
    _id_6AC13F02FE0DAD34 = "geo";

    if(istrue(self.usingcustomdof)) {
      continue;
    }
    _id_A519A2A30C26B6DA = self playerads() > 0.9;

    if(_id_A906BE9CEA201732 && !_id_A519A2A30C26B6DA) {
      if(_id_641EF3FC1EF694A5) {
        _id_641EF3FC1EF694A5 = 0;
        _setdof_internal(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    startpos = self getEye();
    _id_8C57EF0D95A6EE0C = self getplayerangles();
    fwd = anglesToForward(_id_8C57EF0D95A6EE0C);
    _id_1AC96A06E64C75CD = -1;
    _id_021E7AA9E2BE9A6B = undefined;
    _id_E9B6E58B68F0E45E = undefined;
    _id_752873F0EA3F37F9 = undefined;
    _id_30E65BD6257F2186 = undefined;

    if(_id_1C1624BD5CBDD4D2) {
      _id_445ACA8C2C95592E = 0;

      foreach(enemy in level.players) {
        if(!scripts\cp_mp\utility\player_utility::playersareenemies(self, enemy)) {
          continue;
        }
        if(!enemy scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        _id_D59ED0E8C57E2DEF = enemy getEye();
        _id_D7DF12F0EC1C913A = vectordot(fwd, vectorNormalize(_id_D59ED0E8C57E2DEF - startpos));

        if(_id_D7DF12F0EC1C913A < _id_2E3C1D928388C537) {
          continue;
        }
        dist = distance(startpos, _id_D59ED0E8C57E2DEF);

        if(!isDefined(_id_021E7AA9E2BE9A6B) || dist < _id_021E7AA9E2BE9A6B) {
          if(enemy sightconetrace(startpos, self) > 0)
            _id_021E7AA9E2BE9A6B = dist;
        }

        if(!isDefined(_id_E9B6E58B68F0E45E) || dist > _id_E9B6E58B68F0E45E) {
          if(enemy sightconetrace(startpos, self) > 0)
            _id_E9B6E58B68F0E45E = dist;
        }
      }
    }

    endpos = startpos + fwd * 10000;
    trace = scripts\engine\trace::sphere_trace(startpos, endpos, 0.1, self, contentoverride, 0);
    _id_30E65BD6257F2186 = distance(startpos, trace["position"]);
    _id_8C685A74E876C0FD = scripts\engine\trace::sphere_trace(startpos, endpos, 20.0, self, _id_30D537EA3164E799, 0);
    _id_8B39D5984DA1DC7F = _id_8C685A74E876C0FD["entity"];
    _id_850A0D10678DE336 = isDefined(_id_8B39D5984DA1DC7F) && isPlayer(_id_8B39D5984DA1DC7F) && scripts\cp_mp\utility\player_utility::playersareenemies(self, _id_8B39D5984DA1DC7F);
    _id_59131F90F8665FAE = _id_850A0D10678DE336 && _id_8B39D5984DA1DC7F sightconetrace(startpos, self) > 0;

    if(!isDefined(_id_021E7AA9E2BE9A6B) || _id_30E65BD6257F2186 < _id_021E7AA9E2BE9A6B)
      _id_021E7AA9E2BE9A6B = _id_30E65BD6257F2186;

    if(!isDefined(_id_E9B6E58B68F0E45E) || _id_30E65BD6257F2186 > _id_E9B6E58B68F0E45E)
      _id_E9B6E58B68F0E45E = _id_30E65BD6257F2186;

    _id_641EF3FC1EF694A5 = 1;
    _id_81EC67164BE866BD = max(abs(_id_021E7AA9E2BE9A6B - _id_E9B6E58B68F0E45E) * 0.5, 300.0);
    _id_E0AF59BA48C8CB09 = 0.0;
    _id_FF6B46DA0D04E078 = max(_id_021E7AA9E2BE9A6B - 50.0, 1.0);
    _id_2FE3DC2F1289D072 = _id_E9B6E58B68F0E45E + 50.0;
    _id_7A6976D1E774FE57 = _id_2FE3DC2F1289D072 + _id_81EC67164BE866BD;
    nearblur = scripts\engine\utility::ter_op(_id_59131F90F8665FAE, 6.0, 4.0);
    farblur = scripts\engine\utility::ter_op(_id_59131F90F8665FAE, 2.5, 1.25);
    _setdof_internal(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur);
  }
}

setdof_killer() {
  self endon("disconnect");
  self.usingcustomdof = 1;
  setdof_killer_update();
  setdof_default();
}

setdof_killer_update() {
  self endon("disconnect");
  self endon("death_delay_finished");
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_844B0A6CCABE8587 = vectorNormalize(self.origin - self.lastkilledby.origin);
  startpos = self.origin + (0, 0, 42);
  endpos = startpos + _id_844B0A6CCABE8587 * 120.0;
  trace = scripts\engine\trace::sphere_trace(startpos, endpos, 2.0, self, contentoverride, 0);
  _id_A5ED8689CA0DDDBB = trace["position"];

  while(istrue(self.usingcustomdof)) {
    if(!isDefined(self.lastkilledby)) {
      break;
    }

    _id_1AC96A06E64C75CD = distance(_id_A5ED8689CA0DDDBB, self.lastkilledby.origin);
    _id_E0AF59BA48C8CB09 = 0.0;
    _id_FF6B46DA0D04E078 = max(_id_1AC96A06E64C75CD - 12.0, 1.0);
    _id_2FE3DC2F1289D072 = _id_1AC96A06E64C75CD + 12.0;
    _id_7A6976D1E774FE57 = _id_2FE3DC2F1289D072 + 50.0;
    nearblur = 8.0;
    farblur = 4.5;
    _setdof_internal(_id_E0AF59BA48C8CB09, _id_FF6B46DA0D04E078, _id_2FE3DC2F1289D072, _id_7A6976D1E774FE57, nearblur, farblur);
    waitframe();
  }
}

setdof_default() {
  self.usingcustomdof = 0;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_spectator() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 0, 512, 512, 4, 0);
}

setdof_infil() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 128, 512, 4000, 6, 1.8);
}

setdof_apache() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisethird() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 7, 3.5);
}

setdof_cruisefirst() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_tank() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 120, 1000, 6500, 7, 3.5);
}

setdof_thirdperson() {
  self.usingcustomdof = 1;
  _setdof_internal(0, 110, 512, 4096, 6, 1.8);
}

setdof_gunship() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 1000, 7, 0);
}

setdof_gunship_zoom() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 6500, 10, 5);
}

setdof_scrambler_strength_1() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 1000, 5000, 4, 3.5);
}

setdof_scrambler_strength_2() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 800, 4000, 4.5, 3.5);
}

setdof_scrambler_strength_3() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 600, 3000, 5, 3.5);
}

setdof_scrambler_strength_4() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 500, 2000, 5.5, 3.5);
}

setdof_scrambler_strength_5() {
  self.usingcustomdof = 1;
  _setdof_internal(10, 80, 400, 1000, 6, 3.5);
}

clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.archiveusepotg = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  thread _id_C5A5B36868D0A68E();
}

_id_C5A5B36868D0A68E() {
  self endon("disconnect");
  self notify("reset_killcam_player");
  self endon("reset_killcam_player");
  wait 0.05;
  restorepitch = 0;
  _id_3091AADA55546BFE = 0;
  _id_7500EC3E41C123AB = self getplayerangles();
  _id_ACA8796E2DFC14C8 = _id_7500EC3E41C123AB[1];
  self setplayerangles((restorepitch, _id_ACA8796E2DFC14C8, _id_3091AADA55546BFE));
}

isinkillcam() {
  if(isai(self))
    return 0;

  if(self.spectatekillcam) {
    if(self.forcespectatorclient == -1 && self.killcamentity == -1)
      return 0;
  }

  return self.spectatekillcam;
}

waittillrecoveredhealth(time, interval) {
  self endon("death_or_disconnect");
  _id_19B16D351AFFA487 = 0;

  if(!isDefined(interval))
    interval = 0.05;

  if(!isDefined(time))
    time = 0;

  for(;;) {
    if(self.health != self.maxhealth)
      _id_19B16D351AFFA487 = 0;
    else
      _id_19B16D351AFFA487 = _id_19B16D351AFFA487 + interval;

    wait(interval);

    if(self.health == self.maxhealth && _id_19B16D351AFFA487 >= time) {
      break;
    }
  }

  return;
}

_setsuit(suit) {
  if(isDefined(self.suit) && self.suit == suit) {
    return;
  }
  self setsuit(suit);
  self.suit = suit;
  _id_0CBB0697DE4C5728::_id_7C62C6C14ABA289B();
}

setwind(value, _id_5734778D7F1B6E6F) {
  if(!self isscriptable() || !self getscriptablehaspart("wind") || !isreallyalive(self)) {
    return;
  }
  self.manualoverridewindmaterial = _id_5734778D7F1B6E6F;
  self setscriptablepartstate("wind", value, 0);
}

printspawnmessage(message) {
  if(getdvarint("dvar_DA3B86849F785E06", 0) == 1) {
    if(isDefined(self.forcedspawncameraref)) {}

    if(isDefined(self.spawncameraent))
      return;
  }
}

_id_8B23D28B1D38CB39(category, duration) {
  if(!isPlayer(self)) {
    return;
  }
  _id_4E01B7D6147E61A0 = undefined;

  switch (category) {
    case "flash":
      _id_4E01B7D6147E61A0 = 0;
      break;
    case "stun":
      _id_4E01B7D6147E61A0 = 2;
      break;
    case "gas":
      _id_4E01B7D6147E61A0 = 3;
      break;
    case "fire":
      _id_4E01B7D6147E61A0 = 1;
      break;
    case "phosphorous":
      _id_4E01B7D6147E61A0 = 4;
      break;
    case "shock":
      _id_4E01B7D6147E61A0 = 5;
      break;
  }

  if(isDefined(_id_4E01B7D6147E61A0)) {
    _id_C8E256020171797A = 0;

    if(_id_4E01B7D6147E61A0 != 1 && _id_4E01B7D6147E61A0 != 4 && _id_4E01B7D6147E61A0 != 5)
      _id_C8E256020171797A = scripts\mp\utility\perk::_hasperk("specialty_tac_resist");

    if(duration != -1)
      duration = int(duration * 1000);

    self _meth_98A42C6D882AAE10(_id_4E01B7D6147E61A0, duration, gettime() + duration, _id_C8E256020171797A);
  }
}

isincombat() {
  isshooting = 0;

  if(isDefined(self.lastshotfiredtime)) {
    _id_32D023E8D6030EE3 = 0;

    if(!weaponisauto(self.currentprimaryweapon)) {
      _id_C34A63B63E5E6854 = self _meth_0C26A2350F081DC6(self.currentprimaryweapon);
      _id_32D023E8D6030EE3 = _id_C34A63B63E5E6854 + max(getdvarint("dvar_F6ED71D9C8BDB8C9", 0), 150);
    } else
      _id_32D023E8D6030EE3 = getdvarint("dvar_F6ED71D9C8BDB8C9", 0);

    currenttime = gettime();
    isshooting = self.lastshotfiredtime + _id_32D023E8D6030EE3 >= currenttime;
  }

  return isshooting || self ismeleeing() || self isthrowinggrenade() || _id_9612D351D714EFB1();
}

_id_9612D351D714EFB1() {
  _id_9612D351D714EFB1 = 0;

  if(isDefined(self.attackers)) {
    currenttime = gettime();
    _id_FBA4E93698C9C865 = 0;
    _id_9C1C82123F62E38C = getdvarint("dvar_20E694002FCD35CC", 2000);

    foreach(guid, attacker in self.attackers) {
      _id_FBA4E93698C9C865 = currenttime - self.attackerdata[guid].lasttimedamaged;
      _id_9612D351D714EFB1 = isDefined(attacker) && _id_FBA4E93698C9C865 < _id_9C1C82123F62E38C;

      if(_id_9612D351D714EFB1) {
        break;
      }
    }
  }

  return _id_9612D351D714EFB1;
}

setbeingrevivedinternal(_id_14DD46408EFEF0F3) {
  self.beingrevived = _id_14DD46408EFEF0F3;
  self setbeingrevived(_id_14DD46408EFEF0F3);
}

getbeingrevivedinternal() {
  return istrue(self.beingrevived) || istrue(self.isselfreviving);
}

_id_D80EBBF694920C5F(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, _id_AE934C3C1D8B44FF, _id_A5B5522433CA23BC) {
  thread _id_BCE0309BEB222741(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, 0, undefined, _id_AE934C3C1D8B44FF, 0, undefined, _id_A5B5522433CA23BC);
}

_id_BBF44D52CA2820CD(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_A5B5522433CA23BC) {
  thread _id_BCE0309BEB222741(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, 0, undefined, _id_A5B5522433CA23BC);
}

_id_4B6858706980B154(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, _id_AE934C3C1D8B44FF, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC) {
  thread _id_BCE0309BEB222741(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, 0, undefined, _id_AE934C3C1D8B44FF, 1, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC);
}

_id_BCE0309BEB222741(notifyname, _id_143CC6207A1D82FD, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_BA7E8AD2868EF874, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_CBDFE397AE48520E, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC) {
  level endon("game_ended");
  self endon("disconnect");
  thread _id_EA10736811B65B12(notifyname, _id_BA7E8AD2868EF874);
  _id_3FD755A4695815A9 = scripts\engine\utility::ter_op(isDefined(_id_3FD755A4695815A9), _id_3FD755A4695815A9, self);
  _id_F61019386E1B1034 = scripts\engine\utility::ter_op(isDefined(_id_F61019386E1B1034), _id_F61019386E1B1034, 0);
  _id_AE934C3C1D8B44FF = scripts\engine\utility::ter_op(isDefined(_id_AE934C3C1D8B44FF), _id_AE934C3C1D8B44FF, "any");
  _id_CBDFE397AE48520E = scripts\engine\utility::ter_op(isDefined(_id_CBDFE397AE48520E), _id_CBDFE397AE48520E, 0);
  _id_5BBF4DEFC70826D0 = scripts\engine\utility::ter_op(isDefined(_id_5BBF4DEFC70826D0), _id_5BBF4DEFC70826D0, 0);
  _id_A5B5522433CA23BC = scripts\engine\utility::ter_op(isDefined(_id_A5B5522433CA23BC), _id_A5B5522433CA23BC, 0);

  if(isbot(self) && !_id_A5B5522433CA23BC) {
    return;
  }
  _id_489E7E15F93639D9 = "+" + _id_143CC6207A1D82FD;
  _id_F8F485E1AA3CBC93 = "-" + _id_143CC6207A1D82FD;
  _id_2753B81FC59D0999 = notifyname + "_press";
  _id_3CF1BEE5C30F7DFF = notifyname + "_release";
  _id_93C853099FDFBB57 = _id_CBDFE397AE48520E || _id_F61019386E1B1034 > 0;

  if(!isbot(self)) {
    self notifyonplayercommand(_id_2753B81FC59D0999, _id_489E7E15F93639D9);

    if(_id_93C853099FDFBB57)
      self notifyonplayercommand(_id_3CF1BEE5C30F7DFF, _id_F8F485E1AA3CBC93);
  }

  _id_22E92F7D1F36F97B(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_CBDFE397AE48520E, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC);

  if(isDefined(_id_52273A4095C18970))
    self thread[[_id_52273A4095C18970]](_id_3FD755A4695815A9, 0, 0);

  if(!isbot(self)) {
    self notifyonplayercommandremove(_id_2753B81FC59D0999, _id_489E7E15F93639D9);

    if(_id_93C853099FDFBB57)
      self notifyonplayercommandremove(_id_3CF1BEE5C30F7DFF, _id_F8F485E1AA3CBC93);
  }
}

_id_EFC7B5130B976314(player) {
  if(isDefined(level.lootleaders) && scripts\engine\utility::array_contains(level.lootleaders, player)) {
    if(isDefined(player.attached_bag)) {
      stopFXOnTag(level._effect["vfx_br_cashLeaderBag"], player, "j_bag_left");
      modelname = "accessory_money_bag_large_closed_player";

      if(istrue(level._id_267425F35B39ABA4))
        modelname = "accessory_money_bag_large_closed_player_plunder";

      player hidepart("j_bag_left", modelname);
    }
  }

  if((scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && isDefined(player.attached_bag)) {
    player._id_7AF7C88D975503AD = player.attached_bag;
    player _id_4480C6CE37B2BDF3::_id_6D569066AC5F3DF0();
  }

  if(scripts\mp\utility\game::getsubgametype() == "bigctf") {
    player._id_80A77EC6EBDFFE2B = player.carryflag;
    player _id_39A8B103D9252A73::detachflag();
  }

  player _id_3B64EB40368C1450::set("hideAttachedModels", "hide_operator_backpack", 1);
  player _id_3B64EB40368C1450::set("hideAttachedModels", "show_operator_pet", 0);
}

_id_AFFAEFA6EA1B971D(player) {
  if(isDefined(level.lootleaders) && scripts\engine\utility::array_contains(level.lootleaders, player)) {
    if(isDefined(player.attached_bag)) {
      modelname = "accessory_money_bag_large_closed_player";

      if(istrue(level._id_267425F35B39ABA4))
        modelname = "accessory_money_bag_large_closed_player_plunder";

      player showpart("j_bag_left", modelname);
      playFXOnTag(level._effect["vfx_br_cashLeaderBag"], player, "j_bag_left");
    }
  }

  if((scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && !isDefined(player.attached_bag))
    player _id_4480C6CE37B2BDF3::_id_0C3F3FCEEDDDA6F6(scripts\engine\utility::_id_53C4C53197386572(player._id_7AF7C88D975503AD, "parts_backpack_inventory_small"));

  if(scripts\mp\utility\game::getsubgametype() == "bigctf") {
    if(isDefined(player._id_80A77EC6EBDFFE2B) && isDefined(player.carryobject)) {
      otherteam = scripts\mp\utility\game::getotherteam(player.pers["team"])[0];
      player attach(player._id_80A77EC6EBDFFE2B, "tag_stowed_back3", 1);
      player.carryflag = level.carryflag[otherteam];
      player._id_80A77EC6EBDFFE2B = undefined;
    }
  }

  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("hideAttachedModels");
}

_id_EA10736811B65B12(notifyname, _id_BA7E8AD2868EF874) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_BA7E8AD2868EF874);
  self notify(notifyname + "_endon");
}

_id_22E92F7D1F36F97B(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_CBDFE397AE48520E, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(notifyname + "_endon");

  for(;;)
    _id_147C3508C4FF17A0(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_CBDFE397AE48520E, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC);
}

_id_147C3508C4FF17A0(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_CBDFE397AE48520E, _id_5BBF4DEFC70826D0, _id_A5B5522433CA23BC) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(notifyname + "_endon");

  if(_id_F61019386E1B1034 == 0)
    self endon(notifyname + "_release");

  _id_F4E88A8CAF5D63FF(notifyname, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_A5B5522433CA23BC);

  if(_id_CBDFE397AE48520E)
    _id_F295850252D7414A(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_5BBF4DEFC70826D0);
  else
    self thread[[_id_0E86DE67BF72081C]](_id_3FD755A4695815A9);
}

_id_F4E88A8CAF5D63FF(notifyname, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970, _id_AE934C3C1D8B44FF, _id_A5B5522433CA23BC) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(notifyname + "_endon");
  _id_563C6B7BAAF043FA = _id_F61019386E1B1034 == 0;
  _id_3F6FD9C606674A97 = isbot(self) && _id_A5B5522433CA23BC;
  _id_69DC428918A98193 = 0;

  while(!_id_69DC428918A98193) {
    if(_id_563C6B7BAAF043FA) {
      if(!_id_3F6FD9C606674A97)
        self waittill(notifyname + "_press");
      else
        waitframe();

      _id_69DC428918A98193 = 1;
    } else {
      if(!_id_3F6FD9C606674A97)
        self waittill(notifyname + "_press");
      else
        waitframe();

      thread _id_53979F2AB653D2DD(notifyname, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970);
      msg = scripts\engine\utility::waittill_notify_or_timeout_return(notifyname + "_release", _id_F61019386E1B1034);
      _id_69DC428918A98193 = msg == "timeout";
    }

    if(_id_69DC428918A98193 && _id_AE934C3C1D8B44FF != "any" && !_id_3F6FD9C606674A97) {
      if(_id_AE934C3C1D8B44FF == "gamepad_only")
        _id_69DC428918A98193 = self usinggamepad();
      else if(_id_AE934C3C1D8B44FF == "kbm_only")
        _id_69DC428918A98193 = !self usinggamepad();
    }

    if(!_id_69DC428918A98193 && isDefined(_id_52273A4095C18970))
      self thread[[_id_52273A4095C18970]](_id_3FD755A4695815A9, 0, 0);
  }
}

_id_53979F2AB653D2DD(notifyname, _id_3FD755A4695815A9, _id_F61019386E1B1034, _id_52273A4095C18970) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(notifyname + "_endon");
  self endon(notifyname + "_release");

  if(!isDefined(_id_52273A4095C18970)) {
    return;
  }
  progress = 0;
  _id_4C727180836420D8 = _id_F61019386E1B1034 * 1000;

  while(progress < _id_4C727180836420D8) {
    waitframe();
    progress = progress + level.frameduration;

    if(progress < _id_4C727180836420D8)
      self thread[[_id_52273A4095C18970]](_id_3FD755A4695815A9, progress, 0);
  }

  self thread[[_id_52273A4095C18970]](_id_3FD755A4695815A9, progress, 1);
}

_id_F295850252D7414A(notifyname, _id_0E86DE67BF72081C, _id_3FD755A4695815A9, _id_5BBF4DEFC70826D0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(notifyname + "_release");
  self endon(notifyname + "_endon");

  for(;;) {
    self thread[[_id_0E86DE67BF72081C]](_id_3FD755A4695815A9);

    if(_id_5BBF4DEFC70826D0 > 0) {
      wait(_id_5BBF4DEFC70826D0);
      continue;
    }

    waitframe();
  }
}