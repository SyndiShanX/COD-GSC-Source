/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player.gsc
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
    center = self.origin + (0, 0, 48);
  else if(_id_6497396FB64EA3B9 == "prone")
    center = self.origin + (0, 0, 20);
  else
    center = self.origin + (0, 0, 64);

  return center;
}

isreallyalive(player) {
  return isalive(player) && !isDefined(player.fauxdead) && !istrue(self.delayedspawnedplayernotify);
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
  self setclientomnvar("ui_session_state", sessionstate);
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
      if(isDefined(player.team) && (player.team == "spectator" || player.sessionstate == "spectator")) {
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
  self visionsetnakedforplayer("", _id_F69BA8D7B96E8326);
}

init_visionsetnight() {
  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride))
    visionsetnight(level.nvgvisionsetoverride);
  else
    visionsetnight("nvg_base_mp");
}

overridevisionsetnightforlevel(_id_F3C168134A5DDAE7) {
  visionsetnight(_id_F3C168134A5DDAE7);
  level.nvgvisionsetoverride = _id_F3C168134A5DDAE7;
}

resetvisionsetnighttodefault() {
  level.nvgvisionsetoverride = undefined;
  visionsetnight("nvg_base_mp");
}

isenemy(other) {
  if(level.teambased)
    return other.team != self.team;
  else if(isDefined(other.owner))
    return other.owner != self;
  else
    return other != self;
}

getuniqueid() {
  if(!isDefined(self.pers))
    self.pers = [];

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

allow_gesture(_id_E3108E412AFB3811, tag) {
  if(!isDefined(tag))
    tag = "allow_gesture";

  if(!_id_E3108E412AFB3811)
    _id_3B64EB40368C1450::set(tag, "gesture", 0);
  else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00(tag);
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
  if(scripts\cp\utility::is_minimap_forcedisabled()) {
    return;
  }
  if(!isDefined(self.minimapstatetracker))
    self.minimapstatetracker = 0;

  _id_5546BBD6B68A186D = self.minimapstatetracker;
  self.minimapstatetracker++;

  if(self.minimapstatetracker == 1 && _id_5546BBD6B68A186D < self.minimapstatetracker)
    self setclientomnvar("ui_hide_minimap", 0);
}

alwaysshowminimap() {
  return istrue(level.minimaponbydefault) || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.gametype == "brm";
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

getlowestclientnum(players, _id_E1FEA15FF7126A10) {
  _id_F08BC22AABB76CC0 = undefined;

  foreach(player in players) {
    if(player.team != "spectator" && (!_id_E1FEA15FF7126A10 || player scripts\cp_mp\utility\player_utility::_isalive())) {
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
  _id_3B64EB40368C1450::set("using_remote", "vehicle_use", 0);
  _id_3B64EB40368C1450::set("using_remote", "crate_use", 0);
  _id_3B64EB40368C1450::set("using_remote", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("using_remote", "ads", 0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

getremotename() {
  return self.usingremote;
}

clearusingremote(_id_2C111F02D48E2671) {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("using_remote");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isDefined(_id_2C111F02D48E2671))
    _freezecontrols(0);

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

isusingremote() {
  return isDefined(self.usingremote);
}

_freezecontrols(frozen, _id_F8048727716242B0) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"]))
    self.pers["controllerFreezeStack"] = 0;

  if(frozen)
    self.pers["controllerFreezeStack"]++;
  else if(istrue(_id_F8048727716242B0))
    self.pers["controllerFreezeStack"] = 0;
  else
    self.pers["controllerFreezeStack"]--;

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self.controlsfrozen = 0;
  } else {
    self freezecontrols(1);
    self.controlsfrozen = 1;
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

earthquake_for_client(_id_46A291E8D3338AD9, _id_CC2CAA1CDDC1E026) {
  if(!isDefined(self.eq))
    init_earthquake_for_client();

  if(!isDefined(_id_CC2CAA1CDDC1E026))
    _id_CC2CAA1CDDC1E026 = 0;

  partname = undefined;

  if(_id_CC2CAA1CDDC1E026)
    partname = level.eqforclient.partnamesview[_id_46A291E8D3338AD9];
  else
    partname = level.eqforclient.partnames[_id_46A291E8D3338AD9];

  curstate = self.eq.curstates[partname];
  statename = "active" + curstate;
  self setscriptablepartstate(partname, statename, 0);
  curstate++;

  if(curstate > 4)
    curstate = scripts\engine\utility::mod(curstate, 4);

  self.eq.curstates[partname] = curstate;
}

clear_earthquake_for_client() {
  if(!isDefined(self.eq)) {
    return;
  }
  if(!isDefined(level.eqforclient))
    init_earthquake();

  foreach(partname in level.eqforclient.partnames)
  self setscriptablepartstate(partname, "neutral", 0);

  foreach(partname in level.eqforclient.partnamesview)
  self setscriptablepartstate(partname, "neutral", 0);

  self.eq = undefined;
}

rumble_for_client(_id_46A291E8D3338AD9, _id_CC2CAA1CDDC1E026) {
  if(!isDefined(self.rumb))
    init_rumble_for_client();

  if(!isDefined(_id_CC2CAA1CDDC1E026))
    _id_CC2CAA1CDDC1E026 = 0;

  partname = undefined;

  if(_id_CC2CAA1CDDC1E026)
    partname = level.rumbforclient.partnamesview[_id_46A291E8D3338AD9];
  else
    partname = level.rumbforclient.partnames[_id_46A291E8D3338AD9];

  curstate = self.rumb.curstates[partname];
  statename = "active" + curstate;
  self setscriptablepartstate(partname, statename, 0);
  curstate++;

  if(curstate > 4)
    curstate = scripts\engine\utility::mod(curstate, 4);

  self.rumb.curstates[partname] = curstate;
}

clear_rumble_for_client() {
  if(!isDefined(self.rumb)) {
    return;
  }
  foreach(partname in level.rumbforclient.partnames)
  self setscriptablepartstate(partname, "neutral", 0);

  foreach(partname in level.rumbforclient.partnamesview)
  self setscriptablepartstate(partname, "neutral", 0);

  self.rumb = undefined;
}

init_earthquake() {
  level.eqforclient = spawnStruct();
  partnames = [];
  _id_4E578E99AED19B32 = "shakeeq";

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    partnames[_id_AC0E594AC96AA3A8] = _id_4E578E99AED19B32 + _id_AC0E594AC96AA3A8;

  level.eqforclient.partnames = partnames;
  partnames = [];
  _id_4E578E99AED19B32 = "shakeeqview";

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    partnames[_id_AC0E594AC96AA3A8] = _id_4E578E99AED19B32 + _id_AC0E594AC96AA3A8;

  level.eqforclient.partnamesview = partnames;
}

init_earthquake_for_client() {
  if(!isDefined(level.eqforclient))
    init_earthquake();

  self.eq = spawnStruct();
  curstates = [];

  foreach(partname in level.eqforclient.partnames)
  curstates[partname] = 1;

  foreach(partname in level.eqforclient.partnamesview)
  curstates[partname] = 1;

  self.eq.curstates = curstates;
}

init_rumble() {
  level.rumbforclient = spawnStruct();
  partnames = [];
  _id_4E578E99AED19B32 = "shakerumb";

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    partnames[_id_AC0E594AC96AA3A8] = _id_4E578E99AED19B32 + _id_AC0E594AC96AA3A8;

  level.rumbforclient.partnames = partnames;
  partnames = [];
  _id_4E578E99AED19B32 = "shakerumbview";

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++)
    partnames[_id_AC0E594AC96AA3A8] = _id_4E578E99AED19B32 + _id_AC0E594AC96AA3A8;

  level.rumbforclient.partnamesview = partnames;
}

init_rumble_for_client() {
  if(!isDefined(level.rumbforclient))
    init_rumble();

  self.rumb = spawnStruct();
  curstates = [];

  foreach(partname in level.rumbforclient.partnames)
  curstates[partname] = 1;

  foreach(partname in level.rumbforclient.partnamesview)
  curstates[partname] = 1;

  self.rumb.curstates = curstates;
}

teleport_player(object) {
  self setOrigin(object.origin);

  if(isDefined(object.angles))
    self setplayerangles(object.angles);
}

_id_678EED0AF59B69EB(_id_410DBF9EB4F2AE43, _id_EA8199F09C110522, _id_21C40030C467A5F6, _id_247FFBB0EA77EDF7) {
  if(_id_EA8199F09C110522) {
    _id_DD54D673ACB97122 = (0.15, 0.7, 0.7);
    _id_DD31E073AC933F68 = (0.7, 0.4, 0.4);
    _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(0, _id_21C40030C467A5F6, _id_410DBF9EB4F2AE43);
  } else {
    _id_DD54D673ACB97122 = (0.1, 0.1, 0.1);
    _id_DD31E073AC933F68 = (0.1, 0.5, 0.5);
    _id_CCBBA16287668F0A = scripts\engine\math::normalize_value(_id_21C40030C467A5F6, _id_247FFBB0EA77EDF7, _id_410DBF9EB4F2AE43);
  }

  color = scripts\engine\math::factor_value(_id_DD31E073AC933F68, _id_DD54D673ACB97122, _id_CCBBA16287668F0A);
  return color;
}

_id_8196EA3BC8D5538A() {
  if(isDefined(level._id_0FD357ADEA109F55))
    self thread[[level._id_0FD357ADEA109F55]]();
}