/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\killstreak_utility.gsc
********************************************************/

createstreakinfo(streakname, owner) {
  streakinfo = spawnStruct();
  streakinfo.streakname = streakname;
  streakinfo.owner = owner;

  if(isDefined(owner)) {
    streakinfo.id = getuniquekillstreakid(owner);
    streakinfo.lifeid = owner getcurrentplayerlifeidforkillstreak();
  } else {
    streakinfo.id = 0;
    streakinfo.lifeid = 0;
  }

  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData"))
    streakinfo = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](streakinfo, streakname);

  if(scripts\common\utility::ismp()) {
    streakindex = level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakname];

    if(!isDefined(streakindex))
      streakindex = -1;

    streakinfo.streakindex = streakindex;
  }

  return streakinfo;
}

_id_CFC5E3633EF950FD(damagestate, _id_C4C191BEFB977DB0, _id_D3CBDF6DF967D53B) {
  if(!isDefined(self._id_A7CFE37C95FB9196)) {
    self._id_A7CFE37C95FB9196 = [];
    self.currentdamagestate = 0;
  }

  if(scripts\engine\utility::array_contains_key(self._id_A7CFE37C95FB9196, damagestate)) {
    return;
  }
  self._id_A7CFE37C95FB9196[damagestate] = spawnStruct();
  self._id_A7CFE37C95FB9196[damagestate]._id_C4C191BEFB977DB0 = _id_C4C191BEFB977DB0;
  self._id_A7CFE37C95FB9196[damagestate]._id_D3CBDF6DF967D53B = _id_D3CBDF6DF967D53B;
}

_id_DB9562064A4DD635(currenthealth) {
  damagestate = undefined;
  _id_9AE1415763BD6518 = undefined;
  _id_149DFE048BADBF65 = undefined;
  states = self._id_A7CFE37C95FB9196;

  if(isDefined(states)) {
    if(currenthealth <= states[3]._id_C4C191BEFB977DB0) {
      if(self.currentdamagestate != 3)
        damagestate = 3;
    } else if(currenthealth <= states[2]._id_C4C191BEFB977DB0) {
      if(self.currentdamagestate != 2)
        damagestate = 2;
    } else if(currenthealth <= states[1]._id_C4C191BEFB977DB0) {
      if(self.currentdamagestate != 1)
        damagestate = 1;
    }
  }

  if(isDefined(damagestate)) {
    if(isDefined(self.owner) && istrue(self.ispiloted))
      self.owner setclientomnvar("ui_killstreak_damage_state", damagestate);

    self[[states[damagestate]._id_D3CBDF6DF967D53B]]();
    self.currentdamagestate = damagestate;
  }

  if(isDefined(self.owner) && istrue(self.ispiloted))
    self.owner setclientomnvar("ui_killstreak_health", currenthealth / self.maxhealth);
}

getuniquekillstreakid(player) {
  if(!isDefined(player.pers["nextKillstreakID"]))
    player.pers["nextKillstreakID"] = 0;

  uniqueid = player.pers["nextKillstreakID"];
  player.pers["nextKillstreakID"]++;
  return uniqueid;
}

getcurrentplayerlifeidforkillstreak() {
  if(!isDefined(self.pers) || !isDefined(self.pers["deaths"]))
    return 0;

  return self.pers["deaths"];
}

getkillstreaklifeid(streakname) {
  _id_16EFCF27E6EFCBE8 = undefined;

  for(_id_87C06A6FBF20E489 = 1; _id_87C06A6FBF20E489 <= 3; _id_87C06A6FBF20E489++) {
    _id_3A14CF5127D18576 = self.streakdata.streaks[_id_87C06A6FBF20E489];

    if(isDefined(_id_3A14CF5127D18576) && _id_3A14CF5127D18576.streakname == streakname) {
      _id_16EFCF27E6EFCBE8 = _id_3A14CF5127D18576;
      break;
    }
  }

  if(isDefined(_id_16EFCF27E6EFCBE8))
    return _id_16EFCF27E6EFCBE8.lifeid;

  return undefined;
}

registervisibilityomnvarforkillstreak(streakname, _id_3E99C59055B3DE67, _id_5C9DDCF56D36F133) {
  if(!isDefined(level.killstreak_visbilityomnvarlist))
    level.killstreak_visbilityomnvarlist = [];

  if(isDefined(level.killstreak_visbilityomnvarlist[streakname]) && isDefined(level.killstreak_visbilityomnvarlist[streakname][_id_3E99C59055B3DE67])) {
    return;
  }
  _id_E5636E6C071107E3 = 0;

  foreach(_id_6AA208D035887BB8 in level.killstreak_visbilityomnvarlist) {
    foreach(_id_FECB32B716CBA349 in _id_6AA208D035887BB8) {
      if(_id_5C9DDCF56D36F133 == _id_FECB32B716CBA349) {
        _id_E5636E6C071107E3 = 1;
        break;
      }
    }

    if(istrue(_id_E5636E6C071107E3))
      return;
  }

  level.killstreak_visbilityomnvarlist[streakname][_id_3E99C59055B3DE67] = _id_5C9DDCF56D36F133;
}

_setvisibiilityomnvarforkillstreak(streakname, _id_B677BBE2241C4E3F) {
  _id_5C9DDCF56D36F133 = undefined;

  if(_id_B677BBE2241C4E3F == "off")
    _id_5C9DDCF56D36F133 = 0;
  else
    _id_5C9DDCF56D36F133 = level.killstreak_visbilityomnvarlist[streakname][_id_B677BBE2241C4E3F];

  self setclientomnvar("ui_killstreak_controls", _id_5C9DDCF56D36F133);
}

killstreakcanbeusedatroundstart(streakname) {
  switch (streakname) {
    case "weapondrop":
    case "counter_uav":
    case "dronedrop":
    case "tacticalCamera":
    case "directional_uav":
    case "radar_drone_overwatch":
    case "scrambler_drone_guard":
    case "uav":
      return 1;
    default:
      return 0;
  }
}

_id_CE1A9C6C9043809F(streakname) {
  return getkillstreakindex(streakname) != -1;
}

getkillstreakindex(streakname) {
  streakindex = level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakname];

  if(!isDefined(streakindex))
    return -1;

  return streakindex;
}

isridekillstreak(streakname) {
  switch (streakname) {
    case "gunship":
    case "cruise_predator":
    case "chopper_gunner":
    case "pac_sentry":
    case "assault_drone":
    case "radar_drone_recon":
      return 1;
    default:
      return 0;
  }
}

ismapselectkillstreak(streakname) {
  switch (streakname) {
    case "multi_airstrike":
    case "white_phosphorus":
    case "hover_jet":
    case "fuel_airstrike":
    case "nuke_multi":
    case "auto_drone":
    case "nuke":
      return 1;
    default:
      return 0;
  }
}

_id_3C5423F8416220DE(streakname) {
  switch (streakname) {
    case "sentry_gun":
    case "manual_turret":
      return 1;
    default:
      return 0;
  }
}

_id_D57FB9ABF76F9515(streakname) {
  switch (streakname) {
    case "airdrop_multiple":
    case "airdrop":
    case "directional_uav":
    case "scrambler_drone_guard":
    case "uav":
    case "toma_strike":
    case "precision_airstrike":
    case "cluster_spike":
    case "airdrop_escort":
    case "juggernaut":
      return 1;
    default:
      return 0;
  }
}

_id_0708853C5D755F72() {
  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    return "killstreaklist:killstreak_list_t10_mp";
  else if(getdvarint("mgl", 0) > 0)
    return "killstreaklist:killstreak_list_mgl_mp";

  return "killstreaklist:killstreak_list_iw9_mp";
}

isremotekillstreaktabletweapon(weaponname) {
  _id_CD5C5AC9105AB0D7 = 0;

  switch (weaponname) {
    case "ks_remote_gunship_mp":
    case "ks_remote_device_mp":
      _id_CD5C5AC9105AB0D7 = 1;
      break;
  }

  return _id_CD5C5AC9105AB0D7;
}

starttabletscreen(streakname, _id_EFC34E190209C88D, _id_A6B5EEB69FA71F8D) {
  _id_BECD2B16F168C845 = _id_B6FDA02E36D883D8(streakname);

  if(!isDefined(_id_BECD2B16F168C845)) {
    return;
  }
  thread _id_7B5CA7323DE6426E(_id_BECD2B16F168C845.omnvar, _id_BECD2B16F168C845.index);

  if(!istrue(_id_A6B5EEB69FA71F8D))
    thread tabletdofset(_id_EFC34E190209C88D);
}

stoptabletscreen(streakname, _id_00375181444841AD, _id_BFD205538A66591A) {
  _id_BECD2B16F168C845 = _id_B6FDA02E36D883D8(streakname);

  if(!isDefined(_id_BECD2B16F168C845)) {
    return;
  }
  if(istrue(_id_BFD205538A66591A))
    _id_D88996AA85EB88BF();

  thread _id_7B5CA7323DE6426E(_id_BECD2B16F168C845.omnvar, -1, _id_00375181444841AD);
  thread tabletdofset(_id_00375181444841AD, 1);
}

_id_7B5CA7323DE6426E(omnvar, _id_CABC886D846DD979, _id_CD42AF66561FAD0D) {
  self endon("disconnect");
  self notify("omnvar_set_tablet");
  self endon("omnvar_set_tablet");

  if(isDefined(_id_CD42AF66561FAD0D) && _id_CD42AF66561FAD0D > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_CD42AF66561FAD0D);

  self setclientomnvar(omnvar, _id_CABC886D846DD979);
}

_id_B6FDA02E36D883D8(streakname) {
  if(!isDefined(streakname)) {
    return;
  }
  _id_24134A74FFE1614B = level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakname];
  _id_66ACF4D59DF5FE5E = "ui_remote_control_sequence";

  if(!isDefined(_id_24134A74FFE1614B)) {
    _id_24134A74FFE1614B = level.superglobals.staticsuperdata[streakname].id;
    _id_66ACF4D59DF5FE5E = "ui_super_tablet_sequence";

    if(!isDefined(_id_24134A74FFE1614B))
      return;
  }

  tabletinfo = spawnStruct();
  tabletinfo.index = _id_24134A74FFE1614B;
  tabletinfo.omnvar = _id_66ACF4D59DF5FE5E;
  return tabletinfo;
}

tabletdofset(_id_524D5D1E26C664C5, _id_F764FF5DE97D58D2) {
  self endon("disconnect");
  self notify("dof_set_tablet");
  self endon("dof_set_tablet");

  if(isDefined(_id_524D5D1E26C664C5) && _id_524D5D1E26C664C5 > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_524D5D1E26C664C5);

  if(istrue(_id_F764FF5DE97D58D2))
    _id_178AA80B91F36BF4();
  else
    _id_D88996AA85EB88BF();
}

_id_D88996AA85EB88BF() {
  self enablephysicaldepthoffieldscripting();
  self setphysicaldepthoffield(0.125, 0);
  self setphysicalviewmodeldepthoffield(30, 256);
}

_id_178AA80B91F36BF4() {
  self disablephysicaldepthoffieldscripting();
}

_id_36E63B8636445465(streakname) {
  streakindex = level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakname];
  self setclientomnvar("ui_remote_control_sequence", streakindex);
  thread _id_894DBA22489FC8DF();
}

_id_894DBA22489FC8DF() {
  self endon("disconnect");
  level endon("game_ended");
  animlength = 1;
  scripts\engine\utility::waittill_any_timeout_1(animlength, "death");
  _id_C914F562171B9817();
}

_id_C914F562171B9817() {
  self setclientomnvar("ui_remote_control_sequence", -1);
}

_id_836A81868136192D(streakname, _id_E25F9B0DE2CC7B81, scorepopup, vodestroyed, destroyedsplash, _id_8DFC256103CCE53E, _id_191284E2E2837328, _id_BACC6DD14316758C, _id_7DA88D9C69433487, deathcallback) {
  if(isDefined(_id_8DFC256103CCE53E))
    [[_id_8DFC256103CCE53E]](streakname);

  if(isDefined(_id_191284E2E2837328))
    [[_id_191284E2E2837328]](streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    _id_E25F9B0DE2CC7B81[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakname, scorepopup, vodestroyed, destroyedsplash);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback"))
    _id_E25F9B0DE2CC7B81[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakname, _id_BACC6DD14316758C);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback"))
    _id_E25F9B0DE2CC7B81[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakname, _id_7DA88D9C69433487);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback"))
    _id_E25F9B0DE2CC7B81[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakname, deathcallback);
}

killstreak_savenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }
  if(self isnightvisionon()) {
    self.pers["useNVG"] = 1;
    self.pers["killstreak_forcedNVGOff"] = 1;
    self nightvisionviewoff(1);
  } else {
    self.pers["useNVG"] = 0;
    self.pers["killstreak_forcedNVGOff"] = 0;
  }
}

killstreak_restorenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }
  if(istrue(self.pers["useNVG"])) {
    self nightvisionviewon(1);
    self.pers["killstreak_forcedNVGOff"] = 0;
  }
}

_id_C0B0A582FF9E4D57(_id_0AE77C9542367530, _id_EE006CF398BCD8FD, _id_E3C85F91F65E524E, _id_C8FE6E3CA9715960) {
  if(!isDefined(level._id_E64BAD01DED4573A))
    level._id_E64BAD01DED4573A = [];
  else if(isDefined(level._id_E64BAD01DED4573A[_id_0AE77C9542367530])) {
    return;
  }
  _id_91AAFF4F33C3AF2F = spawnStruct();
  _id_91AAFF4F33C3AF2F.name = _id_0AE77C9542367530;
  _id_91AAFF4F33C3AF2F.type = _id_A8F5C03158446D60(_id_0AE77C9542367530);

  if(!isDefined(_id_EE006CF398BCD8FD))
    _id_EE006CF398BCD8FD = 0;

  _id_91AAFF4F33C3AF2F._id_EE006CF398BCD8FD = _id_EE006CF398BCD8FD;

  if(!isDefined(_id_E3C85F91F65E524E))
    _id_E3C85F91F65E524E = 0;

  _id_91AAFF4F33C3AF2F._id_E3C85F91F65E524E = _id_E3C85F91F65E524E;

  if(!isDefined(_id_C8FE6E3CA9715960))
    _id_C8FE6E3CA9715960 = 0;

  _id_91AAFF4F33C3AF2F._id_C8FE6E3CA9715960 = _id_C8FE6E3CA9715960;
  level._id_E64BAD01DED4573A[_id_0AE77C9542367530] = _id_91AAFF4F33C3AF2F;
}

_id_A8F5C03158446D60(_id_0AE77C9542367530) {
  _id_E2FDCC34A6C1FAB4 = undefined;

  if(issubstr(_id_0AE77C9542367530, "thermal"))
    _id_E2FDCC34A6C1FAB4 = "thermal";
  else if(issubstr(_id_0AE77C9542367530, "color"))
    _id_E2FDCC34A6C1FAB4 = "color";

  return _id_E2FDCC34A6C1FAB4;
}

_id_26D001518CF98785(_id_0AE77C9542367530) {
  if(_id_0AE77C9542367530 == "") {
    self visionsetthermalforplayer("");
    self visionsetkillstreakforplayer("");
  } else {
    _id_91AAFF4F33C3AF2F = _id_3DE44EB7CDDE2614(_id_0AE77C9542367530);

    if(!isDefined(_id_91AAFF4F33C3AF2F)) {
      return;
    }
    _id_EE006CF398BCD8FD = _id_91AAFF4F33C3AF2F._id_EE006CF398BCD8FD;

    if(isDefined(_id_91AAFF4F33C3AF2F.type) && _id_91AAFF4F33C3AF2F.type == "thermal")
      self visionsetthermalforplayer(_id_0AE77C9542367530, _id_EE006CF398BCD8FD);
    else
      self visionsetkillstreakforplayer(_id_0AE77C9542367530, _id_EE006CF398BCD8FD);
  }
}

_id_58707DDFDD9744FA(_id_0AE77C9542367530) {
  _id_91AAFF4F33C3AF2F = _id_3DE44EB7CDDE2614(_id_0AE77C9542367530);

  if(!isDefined(_id_91AAFF4F33C3AF2F)) {
    return;
  }
  thread _id_DB59C6309201E96B(_id_91AAFF4F33C3AF2F);
}

_id_C144DE677D9B9175(_id_0AE77C9542367530, _id_7FB54361D482EAEE) {
  _id_F8A4E2FB1E692DD3 = _id_A8F5C03158446D60(_id_0AE77C9542367530);

  if(!isDefined(_id_7FB54361D482EAEE))
    _id_7FB54361D482EAEE = "light";

  _id_626861338E8CFB84 = "killstreak_" + _id_F8A4E2FB1E692DD3 + "_" + _id_7FB54361D482EAEE + "_damage";
  _id_58707DDFDD9744FA(_id_626861338E8CFB84);
}

_id_DB59C6309201E96B(_id_91AAFF4F33C3AF2F) {
  self endon("disconnect");
  self notify("playing_killstreak_subvision");
  self endon("playing_killstreak_subvision");
  _id_0AE77C9542367530 = _id_91AAFF4F33C3AF2F.name;
  _id_EE006CF398BCD8FD = _id_91AAFF4F33C3AF2F._id_EE006CF398BCD8FD;
  _id_E3C85F91F65E524E = _id_91AAFF4F33C3AF2F._id_E3C85F91F65E524E;
  _id_C8FE6E3CA9715960 = _id_91AAFF4F33C3AF2F._id_C8FE6E3CA9715960;
  self visionsetfadetoblackforplayer(_id_0AE77C9542367530, _id_EE006CF398BCD8FD);
  result = scripts\engine\utility::waittill_any_timeout_1(_id_E3C85F91F65E524E, "returning_killstreak_player");

  if(!isDefined(result) || result != "timeout")
    _id_C8FE6E3CA9715960 = 0;

  self visionsetfadetoblackforplayer("", _id_C8FE6E3CA9715960);
}

_id_3DE44EB7CDDE2614(_id_0AE77C9542367530) {
  if(!isDefined(level._id_E64BAD01DED4573A) || !isDefined(level._id_E64BAD01DED4573A[_id_0AE77C9542367530]))
    return undefined;

  return level._id_E64BAD01DED4573A[_id_0AE77C9542367530];
}

_id_86FF095469A70CD2() {
  _id_A45B81B69AA779EB = self.owner;

  if(istrue(self.oob)) {
    _id_A45B81B69AA779EB setclientomnvar("ui_out_of_bounds_type", 0);
    _id_A45B81B69AA779EB setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

_id_A91EBB0263D086F3() {
  _id_754414B883A90065 = self.owner;
  _id_4A3CC04781D25C6F = undefined;
  oobtimeleft = undefined;

  if(isDefined(self.oob) && isDefined(self.oobendtime) && isDefined(self._id_4A3CC04781D25C6F)) {
    _id_4A3CC04781D25C6F = self._id_4A3CC04781D25C6F;
    oobtimeleft = int(max(0, self.oobendtime - gettime()));
    oobtimeleft = int(gettime() + oobtimeleft);
  }

  if(istrue(_id_4A3CC04781D25C6F) && isDefined(oobtimeleft)) {
    _id_754414B883A90065 setclientomnvar("ui_out_of_bounds_type", _id_4A3CC04781D25C6F);
    _id_754414B883A90065 setclientomnvar("ui_out_of_bounds_countdown", oobtimeleft);
  }
}

_id_44E0BD95B98288AB() {
  _id_093B54405FDA960C = "killstreak_thermal";

  if(isDefined(level.mapname) && (issubstr(level.mapname, "mp_shipment") || issubstr(level.mapname, "mp_skerries")))
    _id_093B54405FDA960C = "killstreak_thermal_fog";

  return _id_093B54405FDA960C;
}

_id_5A9772411551E56E(streakname, _id_BE776CA84BC2EB95) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  ent = self;

  if(isDefined(self.owner))
    ent = self.owner;

  if(!isDefined(streakname))
    streakname = "chopper_gunner";

  if(isPlayer(ent)) {
    _id_DA8CEC9BCE12F9CB = ent.pers["team"];

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam"))
        _id_DA8CEC9BCE12F9CB = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](ent);
    }

    _id_9E06D56DF7F6385F = "mp";
    _id_8406C878F4FC7DDA = "mp_killstreak";
    _id_127D392E2057F2B0 = streakname;
    dialog = streakname + "_static_crash";
    eventref = game["dialog"][dialog];

    if(!isDefined(eventref)) {
      game["dialog"][dialog] = "killstreak_remote_operator_static";
      eventref = "killstreak_remote_operator_static";
    }

    _id_77ED885C718B50AC = streakname;

    if(isDefined(_id_BE776CA84BC2EB95))
      _id_77ED885C718B50AC = streakname + "_" + _id_BE776CA84BC2EB95;

    _id_817B24CC21EDE559 = _id_C1309EE7D6ECC444(_id_77ED885C718B50AC, _id_DA8CEC9BCE12F9CB);

    if(!isDefined(_id_817B24CC21EDE559)) {
      return;
    }
    _id_0AD0891EF68549E7 = scripts\cp_mp\utility\dialog_utility::_id_B847C6A9CA912337(_id_9E06D56DF7F6385F, _id_8406C878F4FC7DDA, _id_127D392E2057F2B0, _id_817B24CC21EDE559, eventref);
    _id_0AD0891EF68549E7 = tolower(_id_0AD0891EF68549E7);
    ent queuedialogforplayer(_id_0AD0891EF68549E7, dialog, 1);
  }
}

playkillstreakoperatordialog(streakname, dialog, _id_DB68EEDA63AF9504, _id_74B5B12BB6514385, _id_BE776CA84BC2EB95) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  _id_8E40F8E8DCC635A6 = undefined;

  if(isPlayer(self))
    _id_8E40F8E8DCC635A6 = self;
  else if(isDefined(self.owner))
    _id_8E40F8E8DCC635A6 = self.owner;

  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0) {
    _id_8E40F8E8DCC635A6 endon("disconnect");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  }

  if(isDefined(_id_8E40F8E8DCC635A6)) {
    if(istrue(_id_8E40F8E8DCC635A6._id_30DC7DFD9BE2A276)) {
      return;
    }
    if(!isDefined(_id_8E40F8E8DCC635A6.currentkillstreakopvo) || istrue(_id_DB68EEDA63AF9504)) {
      _id_DA8CEC9BCE12F9CB = _id_8E40F8E8DCC635A6.pers["team"];

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam"))
          _id_DA8CEC9BCE12F9CB = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](_id_8E40F8E8DCC635A6);
      }

      _id_9E06D56DF7F6385F = "mp";
      _id_8406C878F4FC7DDA = _id_BBB77DC4E14DCFCC(streakname);
      _id_127D392E2057F2B0 = streakname;
      eventref = game["dialog"][dialog];
      _id_817B24CC21EDE559 = streakname;

      if(isDefined(_id_BE776CA84BC2EB95))
        _id_817B24CC21EDE559 = streakname + "_" + _id_BE776CA84BC2EB95;

      _id_817B24CC21EDE559 = _id_C1309EE7D6ECC444(_id_817B24CC21EDE559, _id_DA8CEC9BCE12F9CB);

      if(!isDefined(_id_817B24CC21EDE559)) {
        return;
      }
      _id_0AD0891EF68549E7 = scripts\cp_mp\utility\dialog_utility::_id_B847C6A9CA912337(_id_9E06D56DF7F6385F, _id_8406C878F4FC7DDA, _id_127D392E2057F2B0, _id_817B24CC21EDE559, eventref);
      _id_0AD0891EF68549E7 = tolower(_id_0AD0891EF68549E7);
      _id_8E40F8E8DCC635A6 queuedialogforplayer(_id_0AD0891EF68549E7, dialog, 1);
      _id_8E40F8E8DCC635A6.currentkillstreakopvo = dialog;
      _id_8E40F8E8DCC635A6 thread clearstoredkillstreakoperatordialog(5);
    }
  }
}

_id_B700E27DF756BAFB(team) {
  _id_04FDF99C19DE6454 = isDefined(team) && scripts\engine\utility::array_contains(level.teamnamelist, team);

  if(!istrue(_id_04FDF99C19DE6454)) {
    return;
  }
  _id_45B199A5B0C05E80 = "SpecGru";

  if(team == "axis")
    _id_45B199A5B0C05E80 = "KorTac";

  return _id_45B199A5B0C05E80;
}

_id_C1309EE7D6ECC444(_id_77ED885C718B50AC, _id_DA8CEC9BCE12F9CB) {
  _id_5EC35B0D0E09922D = _id_B700E27DF756BAFB(_id_DA8CEC9BCE12F9CB);

  if(!isDefined(_id_5EC35B0D0E09922D)) {
    return;
  }
  _id_702E4071A6BA1825 = undefined;

  switch (_id_77ED885C718B50AC) {
    case "uav_bigmap":
    case "directional_uav":
    case "scrambler_drone_guard":
    case "uav":
      _id_702E4071A6BA1825 = "UAV Operator";
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "hover_jet":
    case "cruise_predator":
    case "nuke_multi":
    case "airdrop_escort":
    case "juggernaut":
      _id_702E4071A6BA1825 = "Helo Pilot";
      break;
    case "pac_sentry":
    case "assault_drone":
      _id_702E4071A6BA1825 = "Drone Pilot";
      break;
    case "precision_airstrike":
    case "fuel_airstrike":
    case "auto_drone":
      _id_702E4071A6BA1825 = "Airstrike Pilot";
      break;
    case "chopper_gunner_pilot":
      _id_702E4071A6BA1825 = "Chopper Pilot";
      break;
    case "chopper_gunner":
      _id_702E4071A6BA1825 = "Chopper Gunner";
      break;
    case "gunship_pilot":
      _id_702E4071A6BA1825 = "Gunship Pilot";
      break;
    case "gunship_nav":
      _id_702E4071A6BA1825 = "Gunship Nav";
      break;
    case "gunship":
      _id_702E4071A6BA1825 = "Gunship Sensor";
      break;
    case "toma_strike":
      _id_702E4071A6BA1825 = "Mortar Gunner";
      break;
  }

  _id_D5C2E956CFEEEA74 = undefined;

  if(isDefined(_id_702E4071A6BA1825))
    _id_D5C2E956CFEEEA74 = _id_5EC35B0D0E09922D + " " + _id_702E4071A6BA1825;

  return _id_D5C2E956CFEEEA74;
}

_id_08959C1606F65E65(streakname, dialog, _id_7805DB19F72B3753) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  if(istrue(level.showingfinalkillcam)) {
    return;
  }
  if(isDefined(level.gulag) && istrue(level.gulag._id_7D2261A38E79508D) && (isDefined(self) && (istrue(self.jailed) || istrue(self.gulagarena) || istrue(self.gulag)))) {
    return;
  }
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  _id_33BD3E1DA831F24B = self;

  if(!isPlayer(self)) {
    if(isDefined(self.owner))
      _id_33BD3E1DA831F24B = self.owner;
    else
      return;
  }

  if(isDefined(_id_33BD3E1DA831F24B)) {
    if(istrue(_id_33BD3E1DA831F24B._id_30DC7DFD9BE2A276)) {
      return;
    }
    _id_DA8CEC9BCE12F9CB = _id_33BD3E1DA831F24B.pers["team"];

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam"))
        _id_DA8CEC9BCE12F9CB = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](_id_33BD3E1DA831F24B);
    }

    _id_9E06D56DF7F6385F = "mp";
    _id_8406C878F4FC7DDA = _id_BBB77DC4E14DCFCC(streakname);
    _id_127D392E2057F2B0 = streakname;
    eventref = game["dialog"][dialog];
    _id_817B24CC21EDE559 = scripts\cp_mp\utility\dialog_utility::_id_D3C62D251D2AF8E6(_id_DA8CEC9BCE12F9CB);

    if(!isDefined(_id_817B24CC21EDE559)) {
      return;
    }
    _id_0AD0891EF68549E7 = scripts\cp_mp\utility\dialog_utility::_id_B847C6A9CA912337(_id_9E06D56DF7F6385F, _id_8406C878F4FC7DDA, _id_127D392E2057F2B0, _id_817B24CC21EDE559, eventref);
    _id_0AD0891EF68549E7 = tolower(_id_0AD0891EF68549E7);
    group = undefined;

    if(_func_D03495FE6418377B(dialog)) {
      group = "killstreak_earned";
      dialog = _func_0F28FD66285FA2C9(dialog);
    }

    if(isDefined(_id_7805DB19F72B3753))
      _id_33BD3E1DA831F24B queuedialogforplayer(_id_7805DB19F72B3753, dialog, 2, group);
    else
      _id_33BD3E1DA831F24B queuedialogforplayer(_id_0AD0891EF68549E7, dialog, 2, group);
  }
}

_id_BBB77DC4E14DCFCC(streakname) {
  _id_8406C878F4FC7DDA = "mp_killstreak";

  if(streakname == "radar_drone_recon")
    _id_8406C878F4FC7DDA = "mp_fieldupgrade";

  return _id_8406C878F4FC7DDA;
}

clearstoredkillstreakoperatordialog(_id_74B5B12BB6514385) {
  self endon("disconnect");
  self notify("clear_stored_dialog");
  self endon("clear_stored_dialog");
  wait(_id_74B5B12BB6514385);

  if(isDefined(self.currentkillstreakopvo))
    self.currentkillstreakopvo = undefined;
}

playkillstreakusedialog(streakname) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  _id_8E40F8E8DCC635A6 = undefined;

  if(isPlayer(self))
    _id_8E40F8E8DCC635A6 = self;
  else if(isDefined(self.owner))
    _id_8E40F8E8DCC635A6 = self.owner;

  _id_18F54C6EA626767C = _id_8E40F8E8DCC635A6.pers["team"];

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[streakname])) {
      if(isDefined(level.killstreakactivatedtime[streakname][_id_18F54C6EA626767C])) {
        if(gettime() < level.killstreakactivatedtime[streakname][_id_18F54C6EA626767C])
          return;
      }
    }

    if(isDefined(level.killstreakactivatedtime[streakname]))
      level.killstreakactivatedtime[streakname][_id_18F54C6EA626767C] = gettime() + 10000;
  }

  _id_21D6D994B0F4FAF1 = [_id_8E40F8E8DCC635A6];
  _id_FB21D338E5D7B128 = level.players;

  if(level.teambased) {
    _id_391F9E326C32FA8A = _id_8E40F8E8DCC635A6 getothersplitscreenplayer();

    if(isDefined(_id_391F9E326C32FA8A))
      _id_21D6D994B0F4FAF1[_id_21D6D994B0F4FAF1.size] = _id_391F9E326C32FA8A;

    _id_CD8547BF474AB0C4 = canplaykillstreakdialog(streakname, 1);
    _id_53934037D8EFC459 = canplaykillstreakdialog(streakname);

    if(istrue(_id_CD8547BF474AB0C4)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
        _id_FB21D338E5D7B128 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_18F54C6EA626767C, "players");

      foreach(player in _id_FB21D338E5D7B128) {
        if(scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player)) {
          _id_21D6D994B0F4FAF1 = scripts\engine\utility::array_remove(_id_21D6D994B0F4FAF1, player);
          continue;
        }

        player _id_08959C1606F65E65(streakname, streakname + "_teamleader_friendly_inbound");
      }
    }

    if(istrue(_id_53934037D8EFC459)) {
      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(_id_F90358454413407F == _id_18F54C6EA626767C) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
          _id_FB21D338E5D7B128 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_F90358454413407F, "players");

        foreach(player in _id_FB21D338E5D7B128) {
          if(isDefined(_id_21D6D994B0F4FAF1) && scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player)) {
            _id_21D6D994B0F4FAF1 = scripts\engine\utility::array_remove(_id_21D6D994B0F4FAF1, player);
            continue;
          }

          player _id_08959C1606F65E65(streakname, streakname + "_teamleader_enemy_inbound");
        }
      }

      return;
    }
  } else {
    foreach(player in _id_FB21D338E5D7B128) {
      if(scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player)) {
        continue;
      }
      player _id_08959C1606F65E65(streakname, streakname + "_teamleader_enemy_inbound");
    }
  }
}

canplaykillstreakdialog(streakname, _id_3E2EF879EE8848E2) {
  _id_BFF1E3C9BA212857 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(istrue(_id_3E2EF879EE8848E2)) {
      switch (streakname) {
        case "airdrop":
        case "sentry_gun":
        case "assault_drone":
        case "cluster_spike":
          _id_BFF1E3C9BA212857 = 0;
          break;
      }
    } else {
      switch (streakname) {
        case "airdrop":
        case "directional_uav":
        case "scrambler_drone_guard":
        case "uav":
        case "toma_strike":
        case "precision_airstrike":
        case "sentry_gun":
        case "assault_drone":
        case "cluster_spike":
        case "radar_drone_recon":
          _id_BFF1E3C9BA212857 = 0;
          break;
      }
    }
  } else if(scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892()) {
    if(istrue(_id_3E2EF879EE8848E2)) {
      switch (streakname) {
        case "airdrop":
        case "sentry_gun":
        case "assault_drone":
        case "cluster_spike":
          _id_BFF1E3C9BA212857 = 0;
          break;
      }
    } else {
      switch (streakname) {
        case "airdrop":
        case "assault_drone":
        case "cluster_spike":
        case "auto_drone":
        case "radar_drone_recon":
          _id_BFF1E3C9BA212857 = 0;
          break;
      }
    }
  } else if(istrue(_id_3E2EF879EE8848E2))
    _id_BFF1E3C9BA212857 = 1;
  else {
    switch (streakname) {
      case "auto_drone":
        _id_BFF1E3C9BA212857 = 0;
        break;
    }
  }

  return _id_BFF1E3C9BA212857;
}

getkillstreakdialogcooldown() {
  return 10;
}

_id_F772994FA2FB7FFC(owner, ownerteam, range, streakname, location) {
  if(!isDefined(streakname)) {
    return;
  }
  _id_817C84503EDEAD03 = _id_7813D0917A42FB04(streakname);

  if(!_id_817C84503EDEAD03) {
    return;
  }
  _id_06E7B34FC3E0F199 = 0;

  if(streakname == "uav" || streakname == "directional_uav")
    _id_06E7B34FC3E0F199 = 1;

  playersinrange = _id_C1236C65472EE948(owner, ownerteam, location, range, _id_06E7B34FC3E0F199, streakname);

  foreach(player in playersinrange)
  _id_7ABEC5FF1C445E2B(player, streakname);
}

_id_7813D0917A42FB04(streakname) {
  _id_817C84503EDEAD03 = 0;
  _id_D937D9FBFEED2E24 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
  _id_490DC70D342B04A2 = scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892();

  if(_id_D937D9FBFEED2E24) {
    switch (streakname) {
      case "missile_silo":
      case "directional_uav":
      case "scrambler_drone_guard":
      case "uav":
      case "toma_strike":
      case "precision_airstrike":
      case "sentry_gun":
      case "assault_drone":
      case "cluster_spike":
      case "radar_drone_recon":
        _id_817C84503EDEAD03 = 1;
        break;
    }
  } else if(_id_490DC70D342B04A2) {
    switch (streakname) {
      case "assault_drone":
      case "cluster_spike":
      case "radar_drone_recon":
        _id_817C84503EDEAD03 = 1;
        break;
    }
  }

  return _id_817C84503EDEAD03;
}

_id_7ABEC5FF1C445E2B(player, streakname) {
  _id_D937D9FBFEED2E24 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();
  _id_490DC70D342B04A2 = scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892();

  if(_id_D937D9FBFEED2E24) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayer"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayer")]](player, streakname);
  } else
    _id_7585EEDA84603D89(player, streakname);
}

_id_7585EEDA84603D89(player, _id_1022173EA86A7090, _id_7805DB19F72B3753) {
  _id_BEB9E876857446FC = 1;

  if(isDefined(level._id_5A81CD5A6AE1C552) && isDefined(level._id_ED3BBED90E848793)) {
    if(isDefined(level._id_ED3BBED90E848793[_id_1022173EA86A7090]) && isDefined(level._id_ED3BBED90E848793[_id_1022173EA86A7090][player.guid]) && gettime() < level._id_ED3BBED90E848793[_id_1022173EA86A7090][player.guid])
      _id_BEB9E876857446FC = 0;
    else
      level._id_ED3BBED90E848793[_id_1022173EA86A7090][player.guid] = gettime() + level._id_5A81CD5A6AE1C552 * 1000;
  }

  if(istrue(_id_BEB9E876857446FC) && isDefined(_id_1022173EA86A7090) && _id_CE1A9C6C9043809F(_id_1022173EA86A7090)) {
    player _id_08959C1606F65E65(_id_1022173EA86A7090, _id_1022173EA86A7090 + "_teamleader_enemy_inbound", _id_7805DB19F72B3753);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "onKillstreakDanger"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "onKillstreakDanger")]](player, _id_1022173EA86A7090);
  }
}

_id_055A9C42F477B156(streakname) {
  if(!isDefined(streakname))
    return 0;

  if(!istrue(level._id_6E488F8EA3D98872))
    return 0;

  if(streakname == "toma_strike" || streakname == "precision_airstrike")
    return 1;

  return 0;
}

_id_C1236C65472EE948(owner, ownerteam, location, range, _id_06E7B34FC3E0F199, streakname) {
  _id_4F152AD6A2C5331F = [];
  _id_926ED5F85FDB6B34 = [];

  if(!isDefined(range))
    range = 5000;

  if(isDefined(owner)) {
    if(!_id_055A9C42F477B156(streakname))
      _id_926ED5F85FDB6B34 = [owner];

    if(level.teambased) {
      if(_id_055A9C42F477B156(streakname)) {
        _id_926ED5F85FDB6B34 = [];

        foreach(player in level.teamdata[ownerteam]["players"]) {
          if(player != owner)
            _id_926ED5F85FDB6B34[_id_926ED5F85FDB6B34.size] = player;
        }
      } else
        _id_926ED5F85FDB6B34 = level.teamdata[ownerteam]["players"];
    }

    if(!isDefined(location))
      location = owner.origin;

    if(istrue(_id_06E7B34FC3E0F199)) {
      foreach(player in _id_926ED5F85FDB6B34) {
        _id_0399DEAD7DB0F7AB = _id_7FBDE10147E5B269(player.origin, range, _id_926ED5F85FDB6B34, _id_4F152AD6A2C5331F);
        _id_4F152AD6A2C5331F = scripts\engine\utility::array_combine(_id_4F152AD6A2C5331F, _id_0399DEAD7DB0F7AB);
      }
    } else
      _id_4F152AD6A2C5331F = _id_7FBDE10147E5B269(location, range, _id_926ED5F85FDB6B34);
  } else {
    if(!isDefined(location))
      return _id_4F152AD6A2C5331F;

    _id_4F152AD6A2C5331F = _id_7FBDE10147E5B269(location, range);
  }

  return _id_4F152AD6A2C5331F;
}

_id_7FBDE10147E5B269(location, range, _id_926ED5F85FDB6B34, _id_3BFCC99E8967473F) {
  _id_37D7886608227391 = [];
  _id_E7C0FFD00E9CFE51 = scripts\common\utility::playersincylinder(location, range, _id_926ED5F85FDB6B34);

  foreach(_id_AA74D78F1A2354AE in _id_E7C0FFD00E9CFE51) {
    if(!isDefined(_id_AA74D78F1A2354AE) || isbot(_id_AA74D78F1A2354AE) || isagent(_id_AA74D78F1A2354AE) || !_id_AA74D78F1A2354AE scripts\cp_mp\utility\player_utility::_isalive() || _id_AA74D78F1A2354AE scripts\cp_mp\utility\player_utility::_isalive() && istrue(_id_AA74D78F1A2354AE.gulag)) {
      continue;
    }
    if(_id_F62830C98EE6A880(_id_AA74D78F1A2354AE, _id_3BFCC99E8967473F)) {
      continue;
    }
    _id_37D7886608227391[_id_37D7886608227391.size] = _id_AA74D78F1A2354AE;
  }

  return _id_37D7886608227391;
}

_id_F62830C98EE6A880(_id_AA74D78F1A2354AE, _id_3BFCC99E8967473F) {
  if(!isDefined(_id_3BFCC99E8967473F) || _id_3BFCC99E8967473F.size == 0)
    return 0;

  _id_084021BC9DBE22E9 = 0;

  foreach(_id_FFFCB11A16D147F6 in _id_3BFCC99E8967473F) {
    if(isDefined(_id_FFFCB11A16D147F6) && _id_FFFCB11A16D147F6 == _id_AA74D78F1A2354AE) {
      _id_084021BC9DBE22E9 = 1;
      break;
    }
  }

  return _id_084021BC9DBE22E9;
}

killstreak_createdangerzone(location, radius, height, timeout, owner, team) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }
  killstreak_destroydangerzone();
  dangerzoneid = undefined;

  if(isDefined(owner) && isDefined(team))
    dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](location, radius, height, team, timeout, owner, 1);
  else if(isDefined(team))
    dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](location, radius, height, team, timeout, undefined, 1);
  else
    dangerzoneid = killstreak_spawnuniversaldangerzone(location, radius, height, timeout);

  self.dangerzoneid = dangerzoneid;
  return dangerzoneid;
}

killstreak_spawnuniversaldangerzone(location, radius, height, timeout) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }
  dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](location, radius, height, undefined, timeout, level.players[randomint(level.players.size)], 1);
  self.dangerzoneid = dangerzoneid;
  return dangerzoneid;
}

killstreak_destroydangerzone(dangerzoneid) {
  if(!isDefined(dangerzoneid) && !isDefined(self.dangerzoneid)) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    return;
  }
  if(!isDefined(dangerzoneid))
    dangerzoneid = self.dangerzoneid;

  if(isDefined(dangerzoneid) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](dangerzoneid))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](dangerzoneid);

  self.dangerzoneid = undefined;
}

_id_B68537EEBDC298F1(_id_7B59B41B01684053, iconname, owner, zoffset, lifetime, scriptablename) {
  _id_49C86A2F36F739A0 = spawn("script_model", _id_7B59B41B01684053);
  _id_49C86A2F36F739A0.icon = iconname;
  _id_49C86A2F36F739A0.owner = owner;

  if(!isDefined(zoffset))
    zoffset = 50;

  _id_49C86A2F36F739A0.zoffset = zoffset;

  if(!isDefined(lifetime))
    lifetime = 5;

  _id_49C86A2F36F739A0.lifetime = lifetime;
  modelname = "tag_origin";

  if(isDefined(scriptablename)) {
    modelname = scriptablename;
    _id_49C86A2F36F739A0.scriptable = scriptablename;
  }

  _id_49C86A2F36F739A0 setModel(modelname);
  _id_49C86A2F36F739A0 setotherent(owner);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID"))
    _id_49C86A2F36F739A0.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);

  _id_49C86A2F36F739A0 _id_F834E6B9FB11E9C0(_id_49C86A2F36F739A0.objidnum);
  _id_49C86A2F36F739A0 thread _id_A6801238F6A7B430();
}

_id_F834E6B9FB11E9C0(objid) {
  icon = self.icon;
  owner = self.owner;
  zoffset = self.zoffset;
  objective_icon(objid, icon);
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, owner);
  objective_onentity(objid, self);
  objective_setzoffset(objid, zoffset);
  objective_setplayintro(objid, 0);
  objective_setplayoutro(objid, 0);
  objective_setbackground(objid, 1);

  if(level.teambased)
    objective_setownerteam(objid, owner.team);
  else
    objective_setownerclient(objid, owner);

  objective_state(objid, "current");
}

_id_A6801238F6A7B430() {
  self endon("death");
  lifetime = self.lifetime;

  if(isDefined(self.scriptable))
    self setscriptablepartstate("target", "on", 0);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);

    self delete();
  }
}

streakcanseetarget(startpos, endpos, ignorelist) {
  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(startpos, endpos, ignorelist, contents))
    _id_027B697504D9397D = 1;

  return _id_027B697504D9397D;
}

_id_999FE3838D6B6F8C(_id_CDBB4A9588ABEF59, startingangles, _id_4D5392D9A61722C2, _id_90006566B6C97518) {
  _id_FDA870B32AB92C1F = (0, startingangles[1], 0);
  _id_546C919E9A86216B = anglesToForward(_id_FDA870B32AB92C1F);
  _id_CA8604D07949E4EC = anglestoright(_id_FDA870B32AB92C1F);
  contents = scripts\engine\trace::create_default_contents(1);

  if(!isDefined(_id_90006566B6C97518))
    _id_90006566B6C97518 = 15000;

  _id_F74F18C717B149E2 = [_id_CDBB4A9588ABEF59 - _id_546C919E9A86216B * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + _id_546C919E9A86216B * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + _id_CA8604D07949E4EC * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 - _id_CA8604D07949E4EC * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + (_id_546C919E9A86216B + _id_CA8604D07949E4EC) * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + (_id_546C919E9A86216B - _id_CA8604D07949E4EC) * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + (_id_CA8604D07949E4EC - _id_546C919E9A86216B) * _id_90006566B6C97518, _id_CDBB4A9588ABEF59 + (-1 * _id_546C919E9A86216B - _id_CA8604D07949E4EC) * _id_90006566B6C97518];

  if(!isDefined(_id_4D5392D9A61722C2))
    _id_4D5392D9A61722C2 = 512;

  flightpath = spawnStruct();
  flightpath.start = _id_CDBB4A9588ABEF59;
  flightpath.end = undefined;
  flightpath.angles = undefined;

  foreach(_id_F9567F37DB523F7A in _id_F74F18C717B149E2) {
    _id_7A7426E42E674E40 = vectorNormalize(_id_F9567F37DB523F7A - _id_CDBB4A9588ABEF59);
    _id_D0A37479B866D030 = _id_CDBB4A9588ABEF59 + _id_7A7426E42E674E40 * _id_90006566B6C97518;
    _id_1F0571D36D0DF95B = scripts\engine\trace::sphere_trace(_id_CDBB4A9588ABEF59, _id_D0A37479B866D030, _id_4D5392D9A61722C2, undefined, contents);

    if(isDefined(_id_1F0571D36D0DF95B) && isDefined(_id_1F0571D36D0DF95B["hittype"]) && _id_1F0571D36D0DF95B["hittype"] != "hittype_none") {
      _id_5FF285F0D96242C7 = _id_1F0571D36D0DF95B["position"];
      _id_5F6A36F9C4145EE6 = _id_90006566B6C97518 * 0.75;
      _id_85E2353AE8A81B3A = _id_5F6A36F9C4145EE6 * _id_5F6A36F9C4145EE6;

      if(distance2dsquared(_id_CDBB4A9588ABEF59, _id_5FF285F0D96242C7) >= _id_85E2353AE8A81B3A) {
        _id_FDA870B32AB92C1F = vectortoangles(_id_F9567F37DB523F7A - _id_CDBB4A9588ABEF59);
        _id_68FD30DB511477F5 = anglesToForward(_id_FDA870B32AB92C1F);
        _id_ABAD2D1E0B91C9BA = distance2d(_id_F9567F37DB523F7A, _id_5FF285F0D96242C7);
        flightpath.end = _id_F9567F37DB523F7A - _id_68FD30DB511477F5 * _id_ABAD2D1E0B91C9BA;
        flightpath.angles = _id_FDA870B32AB92C1F;
        break;
      }

      continue;
    } else {}

    flightpath.end = _id_F9567F37DB523F7A;
    flightpath.angles = vectortoangles(_id_F9567F37DB523F7A - _id_CDBB4A9588ABEF59);
    break;
  }

  return flightpath;
}

_id_E68434BDB941ED1E(streakname, _id_9CBBC426BE64A21A, hintstring, _id_13C7DF650C45A90B, _id_EFE526BF6A23D275) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(!isDefined(_id_9CBBC426BE64A21A._id_C112B4AEAF6CE9AE)) {
    _id_9CBBC426BE64A21A._id_C112B4AEAF6CE9AE = [];
    level thread _id_5180E13C7EF6E8E2(_id_9CBBC426BE64A21A);
  }

  if(!isDefined(_id_BA2553E1D254532E(streakname, _id_9CBBC426BE64A21A))) {
    useobj = spawn("script_model", self.origin);
    useobj setModel("tag_origin");
    useobj linkTo(self, _id_08E620817AF96D5E(streakname), (0, 0, 0), (0, 0, 0));
    useobj.owner = _id_9CBBC426BE64A21A;
    useobj.streakname = streakname;
    useobj._id_83B25E20C32FD3E9 = 0;
    useobj._id_539C2DCC0A467746 = self;
    useobj._id_59F4B576F611FB4A = 0;
    useobj._id_89530BA56809EC76 = 0;

    if(istrue(_id_13C7DF650C45A90B))
      useobj._id_89530BA56809EC76 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority"))
      useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](_id_9CBBC426BE64A21A, hintstring, 360, 360, 65535, 65535, 1, 1, _id_EFE526BF6A23D275);

    _id_9CBBC426BE64A21A._id_C112B4AEAF6CE9AE[streakname] = useobj;
    _id_6ADA614D8209AFB0(useobj);
    level thread _id_8B29AE6AD84B5BF2(useobj);
    level thread _id_CDEDDFF1537455F5(useobj);
    self.useobj = useobj;
  }
}

_id_5180E13C7EF6E8E2(owner) {
  owner endon("disconnect");
  level endon("game_ended");
  _id_A0A13709B751BA26 = getdvarint("dvar_C2417142804C1C76", 0);

  if(!istrue(_id_A0A13709B751BA26)) {
    return;
  }
  for(;;) {
    _id_99CD5E83081CF893 = owner._id_C112B4AEAF6CE9AE;
    _id_2E6169DDEF8528BC = undefined;
    _id_FDB9974A1CCCE54C = undefined;

    foreach(useobj in _id_99CD5E83081CF893) {
      if(isDefined(useobj)) {
        if(_id_D21CBD391E26DC69(useobj)) {
          if(!isDefined(_id_FDB9974A1CCCE54C)) {
            _id_FDB9974A1CCCE54C = distance2dsquared(useobj.origin, owner getvieworigin());
            _id_2E6169DDEF8528BC = useobj;
            continue;
          }

          _id_1003B817E555135A = distance2dsquared(useobj.origin, owner getvieworigin());

          if(_id_1003B817E555135A < _id_FDB9974A1CCCE54C) {
            _id_FDB9974A1CCCE54C = _id_1003B817E555135A;
            _id_2E6169DDEF8528BC = useobj;
          }
        }
      }
    }

    if(isDefined(_id_2E6169DDEF8528BC)) {
      if(!_id_C2917D8B2264D8AC(_id_2E6169DDEF8528BC))
        _id_6ADA614D8209AFB0(_id_2E6169DDEF8528BC, 1);
    }

    wait 0.05;
  }
}

_id_6ADA614D8209AFB0(useobj, _id_16D22807118BCEDB) {
  if(isDefined(useobj)) {
    owner = useobj.owner;

    if(isDefined(owner)) {
      _id_8119AFAC7789EF49(owner);

      if(owner _id_098B53A7358927D9::_id_C4D8558FC1592CD6()) {
        _id_AD1BD6904A1E2EE6 = _id_E36773E138B55C8D(owner);

        if(isDefined(_id_AD1BD6904A1E2EE6)) {
          _id_AD1BD6904A1E2EE6._id_59F4B576F611FB4A = 0;
          _id_AD1BD6904A1E2EE6 notify("clear_suspended_use_object");
        }

        if(!istrue(useobj._id_89530BA56809EC76)) {
          _id_3F55C1FB553A4775(owner, useobj);
          return;
        }

        _id_7D36B03E034C2AB1(useobj, _id_16D22807118BCEDB);
        return;
      } else if(istrue(owner.inlaststand)) {
        _id_AD1BD6904A1E2EE6 = _id_E36773E138B55C8D(owner);

        if(isDefined(_id_AD1BD6904A1E2EE6)) {
          _id_AD1BD6904A1E2EE6._id_59F4B576F611FB4A = 0;
          _id_AD1BD6904A1E2EE6 notify("clear_suspended_use_object");
        }

        _id_3F55C1FB553A4775(owner, useobj);
      } else
        _id_7D36B03E034C2AB1(useobj, _id_16D22807118BCEDB);
    }
  }
}

_id_8119AFAC7789EF49(owner) {
  _id_DDB5066D38BA2842 = _id_BB606C9E5540FD7C(owner);

  if(isDefined(_id_DDB5066D38BA2842))
    _id_D41C2BEEB4EF154E(_id_DDB5066D38BA2842);
}

_id_7D36B03E034C2AB1(useobj, _id_16D22807118BCEDB) {
  useobj enableplayeruse(useobj.owner);
  useobj._id_83B25E20C32FD3E9 = 1;

  if(istrue(_id_16D22807118BCEDB))
    useobj notify("useObj_start_highlight");
}

_id_D41C2BEEB4EF154E(useobj) {
  useobj disableplayeruse(useobj.owner);
  useobj._id_83B25E20C32FD3E9 = 0;
}

_id_3F55C1FB553A4775(owner, _id_80578339C2D89FE5) {
  if(!isDefined(owner) || !isPlayer(owner)) {
    return;
  }
  level thread _id_E01C5830AF200D33(owner, _id_80578339C2D89FE5);
}

_id_E01C5830AF200D33(owner, _id_80578339C2D89FE5) {
  level endon("game_ended");
  _id_DDB5066D38BA2842 = _id_BB606C9E5540FD7C(owner);

  if(isDefined(_id_80578339C2D89FE5))
    _id_DDB5066D38BA2842 = _id_80578339C2D89FE5;

  if(isDefined(_id_DDB5066D38BA2842)) {
    if(istrue(_id_DDB5066D38BA2842._id_89530BA56809EC76) && owner _id_098B53A7358927D9::_id_C4D8558FC1592CD6()) {
      return;
    }
    owner endon("disconnect");
    _id_DDB5066D38BA2842 notify("start_suspended_use_object");
    _id_DDB5066D38BA2842 endon("start_suspended_use_object");
    _id_DDB5066D38BA2842 endon("clear_suspended_use_object");
    _id_DDB5066D38BA2842 endon("death");
    _id_DDB5066D38BA2842._id_59F4B576F611FB4A = 1;
    _id_D41C2BEEB4EF154E(_id_DDB5066D38BA2842);
    _id_DDB5066D38BA2842 waittill("restore_global_use_object");
    _id_7D36B03E034C2AB1(_id_DDB5066D38BA2842);
  }
}

_id_17576A4CDCD447A7(owner) {
  _id_ED247742B7C53A61 = _id_E36773E138B55C8D(owner);

  if(isDefined(_id_ED247742B7C53A61)) {
    _id_ED247742B7C53A61._id_59F4B576F611FB4A = 0;
    _id_ED247742B7C53A61 notify("restore_global_use_object");
  }
}

_id_8B29AE6AD84B5BF2(useobj) {
  useobj endon("death");
  _id_A0A13709B751BA26 = getdvarint("dvar_C2417142804C1C76", 0);

  if(!istrue(_id_A0A13709B751BA26)) {
    return;
  }
  _id_2619F56748F3BE6E = "outline_nodepth_useobj_";
  _id_C4DAA28FF838E59C(useobj, _id_2619F56748F3BE6E + "default");

  for(;;) {
    result = useobj scripts\engine\utility::waittill_any_return_2("useObj_start_highlight", "useObj_stop_highlight");

    if(result == "useObj_start_highlight") {
      useobj._id_E4922FFBE92EB2DA = 1;
      _id_C4DAA28FF838E59C(useobj, _id_2619F56748F3BE6E + "highlight");
      level childthread _id_93CAFEC896797C8C(useobj);
      continue;
    }

    useobj._id_E4922FFBE92EB2DA = 0;
    _id_C4DAA28FF838E59C(useobj, _id_2619F56748F3BE6E + "default");
  }
}

_id_C4DAA28FF838E59C(useobj, _id_4430B08D5A2D47BF) {
  _id_904BACE0562C3A7B(useobj);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer"))
    useobj.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](useobj._id_539C2DCC0A467746, useobj.owner, _id_4430B08D5A2D47BF, "killstreak");
}

_id_904BACE0562C3A7B(useobj) {
  if(isDefined(useobj.outlineid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](useobj.outlineid, useobj._id_539C2DCC0A467746);
  }
}

_id_93CAFEC896797C8C(useobj) {
  while(_id_D21CBD391E26DC69(useobj))
    waitframe();

  useobj notify("useObj_stop_highlight");
}

_id_D21CBD391E26DC69(useobj) {
  return useobj.owner worldpointinreticle_circle(useobj.origin, 80, 200);
}

_id_C2917D8B2264D8AC(useobj) {
  return istrue(useobj._id_E4922FFBE92EB2DA);
}

_id_CDEDDFF1537455F5(useobj) {
  level endon("game_ended");
  result = useobj._id_539C2DCC0A467746 scripts\engine\utility::waittill_any_return_4("death", "explode", "leaving", "crashing");

  if(isDefined(useobj.owner)) {
    _id_904BACE0562C3A7B(useobj);
    useobj.owner._id_C112B4AEAF6CE9AE = scripts\engine\utility::array_remove_index(useobj.owner._id_C112B4AEAF6CE9AE, useobj.streakname, 1);

    if(_id_926AEEDDAAA0E670(useobj)) {
      _id_34CA454BBEC477F1 = useobj.owner._id_C112B4AEAF6CE9AE;

      if(_id_34CA454BBEC477F1.size > 0) {
        _id_4B77DD2F3608E421 = undefined;

        foreach(_id_43A69F6A01195D68 in _id_34CA454BBEC477F1) {
          if(isDefined(_id_43A69F6A01195D68)) {
            _id_4B77DD2F3608E421 = _id_43A69F6A01195D68;
            break;
          }
        }

        if(isDefined(_id_4B77DD2F3608E421))
          _id_6ADA614D8209AFB0(_id_4B77DD2F3608E421);
      }
    } else
      _id_D41C2BEEB4EF154E(useobj);
  }

  if(isDefined(useobj))
    useobj delete();
}

_id_BA2553E1D254532E(streakname, owner) {
  if(!isDefined(owner) || !isDefined(owner._id_C112B4AEAF6CE9AE))
    return undefined;

  useobject = undefined;

  if(isDefined(owner._id_C112B4AEAF6CE9AE[streakname]))
    useobject = owner._id_C112B4AEAF6CE9AE[streakname];

  return useobject;
}

_id_BB606C9E5540FD7C(owner) {
  if(!isDefined(owner) || !isDefined(owner._id_C112B4AEAF6CE9AE))
    return undefined;

  _id_0DF5AF15B843B92F = undefined;

  foreach(useobj in owner._id_C112B4AEAF6CE9AE) {
    if(istrue(useobj._id_83B25E20C32FD3E9)) {
      _id_0DF5AF15B843B92F = useobj;
      break;
    }
  }

  return _id_0DF5AF15B843B92F;
}

_id_E36773E138B55C8D(owner) {
  if(!isDefined(owner) || !isDefined(owner._id_C112B4AEAF6CE9AE))
    return undefined;

  _id_AD1BD6904A1E2EE6 = undefined;

  foreach(useobj in owner._id_C112B4AEAF6CE9AE) {
    if(istrue(useobj._id_59F4B576F611FB4A)) {
      _id_AD1BD6904A1E2EE6 = useobj;
      break;
    }
  }

  return _id_AD1BD6904A1E2EE6;
}

_id_926AEEDDAAA0E670(useobj) {
  return istrue(useobj._id_83B25E20C32FD3E9);
}

_id_08E620817AF96D5E(streakname) {
  _id_54100CA480291B0C = "tag_origin";

  switch (streakname) {
    case "hover_jet":
    case "pac_sentry":
      _id_54100CA480291B0C = "tag_body";
      break;
  }

  return _id_54100CA480291B0C;
}

_id_13276A05F9B52006(streakname) {
  return level._id_0B23156D776B1D85._id_2150DA9328528BB9[streakname];
}

_id_D13D2A81214FBFB8(_id_7EB265BCED9CC450, _id_A6CEB04E31F575E0) {
  self endon("disconnect");

  if(istrue(_id_A6CEB04E31F575E0)) {
    thread _id_AF095E506DE21F93();
    wait 0.05;
  }

  if(!isDefined(_id_7EB265BCED9CC450))
    _id_7EB265BCED9CC450 = "80_instant_noscale";

  self lerpfovbypreset(_id_7EB265BCED9CC450);
}

_id_AF095E506DE21F93() {
  self endon("disconnect");
  self notify("unset_fov_scalefactor");
  self endon("unset_fov_scalefactor");
  self lerpfovscalefactor(0.0, 0.0);
  level waittill("start_game_ended");
  _id_8B676F496920E2AB();
}

_id_8B676F496920E2AB() {
  self notify("unset_fov_scalefactor");
  thread _id_D13D2A81214FBFB8("default");
  self lerpfovscalefactor(1.0, 0.0);
}

_id_EE93617532D8A679(vehicle, owner, cleanupfunc, _id_246614EA27A2E126, _id_2E71B592D8FBF3AA) {
  if(!isDefined(vehicle)) {
    return;
  }
  vehicle _meth_BCB138D52B53D94D(0);

  if(istrue(_id_2E71B592D8FBF3AA)) {
    return;
  }
  if(isDefined(owner))
    owner endon("disconnect");

  vehicle endon("death");
  vehicle endon("explode");
  level endon("game_ended");

  if(!isDefined(cleanupfunc)) {
    return;
  }
  _id_3098BBCD22D0E052 = spawnStruct();
  _id_3098BBCD22D0E052.cleanupfunc = cleanupfunc;
  _id_3098BBCD22D0E052._id_2EFC43F3F9071BC7 = ::_id_37BA16DA99BC142A;
  _id_3098BBCD22D0E052._id_1ADC2EA2615FDB8D = istrue(_id_246614EA27A2E126);
  vehicle._id_3098BBCD22D0E052 = _id_3098BBCD22D0E052;
}

_id_37BA16DA99BC142A(_id_401C3A2E68AAB0FD) {
  self endon("death");
  self endon("explode");
  level endon("game_ended");

  if(istrue(self._id_54DB093819E08A57)) {
    return;
  }
  self._id_54DB093819E08A57 = 1;
  _id_B1E2DC0593D7CA82 = self._id_3098BBCD22D0E052;

  if(istrue(self.iscrashing) || istrue(self.isleaving))
    self thread[[_id_B1E2DC0593D7CA82.cleanupfunc]]();
  else {
    if(!istrue(_id_B1E2DC0593D7CA82._id_1ADC2EA2615FDB8D)) {
      return;
    }
    result = _id_F503427294D91F80(self, 500);

    if(!istrue(result))
      self thread[[_id_B1E2DC0593D7CA82.cleanupfunc]]();
  }
}

_id_F503427294D91F80(vehicle, _id_7DF47E090AF4FFB9) {
  vehicle endon("death");
  vehicle endon("explode");
  vehicle endon("leaving");
  vehicle endon("crashing");
  level endon("game_ended");
  _id_6F3A90A6B2B8799D = vehicle.origin;
  forward = anglesToForward(vehicle.angles);
  right = anglestoright(vehicle.angles);
  up = anglestoup(vehicle.angles);
  contents = scripts\engine\trace::create_default_contents(1);
  ignore = vehicle;
  _id_1AF7B0AD468A64CB = [_id_6F3A90A6B2B8799D + forward * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D - forward * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + right * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D - right * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + up * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D - up * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + 0.707 * (forward + right) * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + 0.707 * (forward - right) * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + 0.707 * (right - forward) * _id_7DF47E090AF4FFB9, _id_6F3A90A6B2B8799D + 0.707 * (-1 * forward - right) * _id_7DF47E090AF4FFB9];
  _id_62538CB75DB14E85 = 0;

  foreach(_id_42C3DDAAE2ED9962 in _id_1AF7B0AD468A64CB) {
    if(scripts\engine\trace::sphere_trace_passed(_id_6F3A90A6B2B8799D, _id_42C3DDAAE2ED9962, 300, ignore, contents)) {
      vehicle vehicle_teleport(_id_42C3DDAAE2ED9962, vehicle.angles);
      _id_62538CB75DB14E85 = 1;
      break;
    }

    wait 0.05;
  }

  return _id_62538CB75DB14E85;
}

teamhasuav(team) {
  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_F90358454413407F == team) {
      continue;
    }
    if(isDefined(level.uavmodels) && isDefined(level.uavmodels[_id_F90358454413407F]) && level.uavmodels[_id_F90358454413407F].size > 0) {
      foreach(uav in level.uavmodels[_id_F90358454413407F]) {
        if(!isDefined(uav)) {
          continue;
        }
        if(uav.uavtype == "counter_uav")
          return 0;
      }
    }
  }

  if(isDefined(level.uavmodels) && isDefined(level.uavmodels[team]) && level.uavmodels[team].size > 0) {
    foreach(uav in level.uavmodels[team]) {
      if(!isDefined(uav)) {
        continue;
      }
      if(uav.uavtype == "uav" || uav.uavtype == "directional_uav")
        return 1;
    }
  }

  return 0;
}

teamhasuav_ignorecuav(team) {
  if(isDefined(level.uavmodels) && isDefined(level.uavmodels[team]) && level.uavmodels[team].size > 0) {
    foreach(uav in level.uavmodels[team]) {
      if(!isDefined(uav)) {
        continue;
      }
      if(uav.uavtype == "uav" || uav.uavtype == "directional_uav")
        return 1;
    }
  }

  return 0;
}

enemyhascuav(team) {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(drone in level.supportdrones) {
      if(level.teambased && drone.team == team) {
        continue;
      }
      if(drone.helperdronetype == "scrambler_drone_guard")
        return 1;
    }
  }

  return 0;
}

isuavactiveforteam(team) {
  if(!isDefined(level.uavmodels))
    return 0;

  if(!isDefined(level.uavmodels[team]))
    return 0;

  return level.uavmodels[team].size > 0;
}

getkillstreakdeployweapon(streakname) {
  _id_8881166E57766E3A = undefined;

  switch (streakname) {
    case "airdrop_multiple":
    case "airdrop":
    case "airdrop_escort":
      _id_8881166E57766E3A = "deploy_airdrop_mp";
      break;
    case "assault_suit":
    case "juggernaut":
      _id_8881166E57766E3A = "deploy_juggernaut_mp";
      break;
    case "assault_drone":
      if(scripts\common\utility::iscp()) {
        _id_8881166E57766E3A = "ks_assault_drone_cp";
        break;
      }

      _id_8881166E57766E3A = "ks_assault_drone_mp";
      break;
    case "radar_drone_overwatch":
    case "chopper_support":
    case "bradley":
      _id_8881166E57766E3A = "ks_gesture_generic_mp";
      break;
    case "directional_uav":
    case "scrambler_drone_guard":
    case "uav":
      _id_8881166E57766E3A = "ks_gesture_phone_mp";
      break;
    case "toma_strike":
      _id_8881166E57766E3A = "iw9_laser_large_ir_mp";
      break;
    case "precision_airstrike":
      _id_8881166E57766E3A = "iw9_spotter_scope_mp";
      break;
    case "gunship":
    case "cruise_predator":
    case "chopper_gunner":
    case "pac_sentry":
      _id_8881166E57766E3A = "ks_remote_device_mp";
      break;
    case "white_phosphorus":
    case "hover_jet":
    case "fuel_airstrike":
    case "auto_drone":
      _id_8881166E57766E3A = "ks_remote_map_mp";
      break;
    case "manual_turret":
      _id_8881166E57766E3A = "deploy_manual_turret_mp";
      break;
    case "sentry_gun":
      _id_8881166E57766E3A = "deploy_sentry_mp";
      break;
    case "nuke":
      _id_8881166E57766E3A = "ks_remote_nuke_mp";
      break;
  }

  return _id_8881166E57766E3A;
}

iskillstreakdeployweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else {
    weaponname = _id_2669878CF5A1B6BC::_id_072376783A92BE46(weapon);

    if(!isDefined(weaponname))
      weaponname = weapon;
  }

  _id_1880D2298E9E948A = 0;

  switch (weaponname) {
    case "ks_gesture_phone_mp":
    case "deploy_manual_turret_mp":
    case "ks_remote_nuke_mp":
    case "ks_assault_drone_cp":
    case "ks_assault_drone_mp":
    case "ks_gesture_generic_mp":
    case "ks_remote_device_mp":
    case "ks_remote_map_mp":
    case "deploy_juggernaut_mp":
    case "iw9_laser_large_ir_mp":
    case "deploy_airdrop_mp":
    case "iw9_spotter_scope_mp":
    case "deploy_sentry_mp":
      _id_1880D2298E9E948A = 1;
      break;
  }

  return _id_1880D2298E9E948A;
}

_id_6C58C6FDCC87E387(weaponobj) {
  _id_EFA92DCC03A312B9 = 0;

  if(!isDefined(weaponobj) || !isDefined(weaponobj.basename))
    return _id_EFA92DCC03A312B9;

  switch (weaponobj.basename) {
    case "ks_remote_device_mp":
      _id_EFA92DCC03A312B9 = 1;
      break;
  }

  return _id_EFA92DCC03A312B9;
}

_id_9DEB86C4684340E1(weaponobj) {
  _id_D707A33007A42777 = 0;

  if(!isDefined(weaponobj) || !isDefined(weaponobj.basename))
    return _id_D707A33007A42777;

  switch (weaponobj.basename) {
    case "ks_remote_map_mp":
      _id_D707A33007A42777 = 1;
      break;
  }

  return _id_D707A33007A42777;
}

_id_3FFC7FD85F5754E9(weaponobj) {
  _id_FFB48D5F685A491B = 0;

  if(!isDefined(weaponobj) || !isDefined(weaponobj.basename))
    return _id_FFB48D5F685A491B;

  switch (weaponobj.basename) {
    case "ks_assault_drone_cp":
    case "ks_assault_drone_mp":
    case "ks_remote_drone_mp":
      _id_FFB48D5F685A491B = 1;
      break;
  }

  return _id_FFB48D5F685A491B;
}

_id_92AB1470F48812C2(weaponobj) {
  _id_70167DE558C1C864 = 0;

  if(!isDefined(weaponobj) || !isDefined(weaponobj.basename))
    return _id_70167DE558C1C864;

  switch (weaponobj.basename) {
    case "ks_gesture_phone_mp":
    case "ks_gesture_generic_mp":
      _id_70167DE558C1C864 = 1;
      break;
  }

  return _id_70167DE558C1C864;
}

getkillstreakgameweapons(streakname) {
  _id_010008C3679D9645 = [];

  switch (streakname) {
    case "juggernaut":
      _id_010008C3679D9645 = ["iw9_minigunksjugg_mp", "iw9_minigunksjugg_reload_mp"];

      if(scripts\common\utility::iscp()) {
        _id_7BB3AB2F0254B425 = "iw9_lm_dblmg2_cp";
        _id_010008C3679D9645 = scripts\engine\utility::array_add(_id_010008C3679D9645, _id_7BB3AB2F0254B425);
      }

      break;
    case "manual_turret":
      _id_010008C3679D9645 = ["manual_turret_mp"];
      break;
    case "sentry_gun":
      _id_010008C3679D9645 = ["sentry_turret_mp"];
      break;
  }

  return _id_010008C3679D9645;
}

getnumactivekillstreakperteam(team, _id_3B3D45FBC518A5A8) {
  _id_815BC3B6C43677E1 = 0;

  foreach(_id_D7EEA22A14A52FD0 in _id_3B3D45FBC518A5A8) {
    if(_id_D7EEA22A14A52FD0.team == team)
      _id_815BC3B6C43677E1++;
  }

  return _id_815BC3B6C43677E1;
}

getkillstreakairstrikeheightent() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    return scripts\cp_mp\utility\game_utility::getlocaleent("airstrikeheight");

  _id_237503F7F9EE10EF = getEntArray("airstrikeheight", "targetname");

  if(_id_237503F7F9EE10EF.size > 1) {}

  return _id_237503F7F9EE10EF[0];
}

_id_3F76336D7D0B7587(weaponref) {
  _id_BFF2A7822F594386 = 1.0;

  if(isDefined(weaponref)) {
    weaponname = undefined;

    if(isweapon(weaponref))
      weaponname = weaponref.basename;
    else {
      weaponname = _id_2669878CF5A1B6BC::_id_072376783A92BE46(weaponref);

      if(!isDefined(weaponname))
        weaponname = weaponref;
    }

    switch (weaponname) {
      case "deploy_sentry_mp":
        _id_BFF2A7822F594386 = 0.78;
        break;
      case "cluster_spike_mp":
        _id_BFF2A7822F594386 = 0.87;
        break;
      case "deploy_airdrop_mp":
        _id_BFF2A7822F594386 = 0.91;
        break;
    }
  }

  return _id_BFF2A7822F594386;
}

restorekillstreakplayerangles(player) {
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  restorepitch = 0;
  _id_3091AADA55546BFE = 0;
  wait 0.05;
  _id_7500EC3E41C123AB = player getplayerangles();
  _id_ACA8796E2DFC14C8 = _id_7500EC3E41C123AB[1];

  if(isDefined(player.restoreangles) && !scripts\cp_mp\utility\player_utility::_id_F8789F15330DE751(player))
    _id_ACA8796E2DFC14C8 = player.restoreangles[1];

  player setplayerangles((restorepitch, _id_ACA8796E2DFC14C8, _id_3091AADA55546BFE));
}

recordkillstreakendstats(streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onKillStreakEnd")) {
    _id_16EFCF27E6EFCBE8 = streakinfo.mpstreaksysteminfo;

    if(isDefined(_id_16EFCF27E6EFCBE8)) {
      name = _id_16EFCF27E6EFCBE8.streakname;
      _id_77F3CA6D2F0AAE12 = streakinfo.kills;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onKillStreakEnd")]](name, _id_77F3CA6D2F0AAE12);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "killStreakExpired")) {
    _id_16EFCF27E6EFCBE8 = streakinfo.mpstreaksysteminfo;

    if(isDefined(_id_16EFCF27E6EFCBE8)) {
      lifeid = _id_16EFCF27E6EFCBE8.streakmatchlifeid;
      _id_D8061F26B5ECA018 = _id_16EFCF27E6EFCBE8.streakname;
      pickedup = _id_16EFCF27E6EFCBE8.isgimme;
      _id_FF9358B3AC96C7AB = gettime();
      _id_1925D24D0AE333E6 = self.origin;
      expiredbydeath = istrue(streakinfo.expiredbydeath);
      shotsfired = streakinfo.shots_fired;
      _id_8F52823E77ACA0D3 = streakinfo.hits;
      _id_F5FF9A2F5217B3EC = streakinfo.kills;
      _id_7E6DBB913989CF29 = streakinfo.score;
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "killStreakExpired")]](self, lifeid, _id_D8061F26B5ECA018, pickedup, _id_FF9358B3AC96C7AB, _id_1925D24D0AE333E6, expiredbydeath, shotsfired, _id_8F52823E77ACA0D3, _id_F5FF9A2F5217B3EC, _id_7E6DBB913989CF29);
    }
  }
}

playerkillstreakgetownerlookatignoreents() {
  ignoreents = undefined;

  if(isDefined(self.vehicle))
    ignoreents = [self.vehicle];
  else {
    groundent = self getgroundentity();

    if(isDefined(groundent) && isDefined(groundent.classname) && groundent.classname == "script_vehicle")
      ignoreents = [groundent];
  }

  return ignoreents;
}

movingplatform_playerlink(player) {
  if(getdvarint("dvar_82CE3832AC5EFA6D", 0) == 0) {
    return;
  }
  _id_A2731E6D9AF15254 = player getmovingplatformparent();

  if(isDefined(_id_A2731E6D9AF15254) && _id_63BDC8C411A85475(_id_A2731E6D9AF15254)) {
    player playerlinkTo(_id_A2731E6D9AF15254);
    player playerlinkedoffsetenable();
    player.movingplatforment = _id_A2731E6D9AF15254;
  }
}

_id_63BDC8C411A85475(_id_A2731E6D9AF15254) {
  if(scripts\cp_mp\utility\train_utility::is_moving_platform_train(_id_A2731E6D9AF15254))
    return 1;

  if(scripts\common\elevator::_id_0D9D18DAB18EBDED(_id_A2731E6D9AF15254))
    return 1;

  if(isarray(level._id_A3810B14039A0E7D)) {
    foreach(callback in level._id_A3810B14039A0E7D) {
      if([[callback]](_id_A2731E6D9AF15254))
        return 1;
    }
  }

  return 0;
}

_id_3C5C5D86EF14420E(_id_A2731E6D9AF15254) {
  if(scripts\cp_mp\utility\train_utility::is_moving_platform_train(_id_A2731E6D9AF15254))
    return 1;

  if(scripts\common\elevator::_id_0D9D18DAB18EBDED(_id_A2731E6D9AF15254))
    return 1;

  if(isarray(level._id_6B5EFF480D2F1FAC)) {
    foreach(callback in level._id_6B5EFF480D2F1FAC) {
      if([[callback]](_id_A2731E6D9AF15254))
        return 1;
    }
  }

  return 0;
}

movingplatform_playerunlink(player) {
  if(isDefined(player.movingplatforment)) {
    player.movingplatforment = undefined;
    player unlink();
  }
}

_id_6DB9B45F6855DEE1(callback) {
  if(!isarray(level._id_A3810B14039A0E7D))
    level._id_A3810B14039A0E7D = [];

  level._id_A3810B14039A0E7D[level._id_A3810B14039A0E7D.size] = callback;
}

_id_2C70BFB1B580E8E0(callback) {
  if(!isarray(level._id_6B5EFF480D2F1FAC))
    level._id_6B5EFF480D2F1FAC = [];

  level._id_6B5EFF480D2F1FAC[level._id_6B5EFF480D2F1FAC.size] = callback;
}