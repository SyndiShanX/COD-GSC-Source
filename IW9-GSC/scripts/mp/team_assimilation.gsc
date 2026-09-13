/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\team_assimilation.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "requestNearbyTeamChange", ::_id_452C678D0120E4B4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "resolveAssimRequest", ::_id_838403168B5AC877);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "isWaitingForAssimResponse", ::_id_4335A8EB2D259C81);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "isEnabled", ::_id_6934349B7823D888);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "disablePlayer", ::_id_BB4125D6847AF349);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "enablePlayer", ::_id_59CF08630DD70540);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "isPlayersAssimDisabled", ::_id_9F1145C4CCE86B2C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "permanentlyDisableAssim", ::_id_BFD417BD39BD685D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "registerTeamAssimilateCallback", ::_id_F3D757808130BAC4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "canAssimilate", ::_id_28AE41A833E83C3F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "canTeamAssimilate", ::_id_7DFA4473A3663C96);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "assimilatePlayer", ::_id_5822C1EC52C77E6E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "shouldAutoAcceptTeamSwitch", ::_id_E2AED369E0BAC150);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "getMaxAssimilationTeamSize", ::_id_17339FA510BD6380);
  scripts\cp_mp\utility\script_utility::registersharedfunc("teamAssim", "sendDirectAssimRequest", ::_id_01D6C7047EF737F2);
}

_id_F3D757808130BAC4(callback) {
  if(!isDefined(level._id_6B08D5E6B7943575))
    level._id_6B08D5E6B7943575 = [];

  level._id_6B08D5E6B7943575[level._id_6B08D5E6B7943575.size] = callback;
}

_id_80139212A4C66A94(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(level._id_6B08D5E6B7943575)) {
    return;
  }
  foreach(callback in level._id_6B08D5E6B7943575)[[callback]](player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
}

_id_6934349B7823D888() {
  if(!isDefined(level._id_CC0D5A1E8A904E5C))
    level._id_CC0D5A1E8A904E5C = getdvarint("dvar_AF509AC21EC3BD6A", 0);

  return level._id_CC0D5A1E8A904E5C;
}

_id_9F3B05F2EA701548() {
  if(!isDefined(level._id_F759B9E710865CE3))
    level._id_F759B9E710865CE3 = getdvarint("dvar_1D0D8806C4170519", 0);

  return level._id_F759B9E710865CE3;
}

_id_17339FA510BD6380() {
  if(!isDefined(level._id_5F92F1F4D7FAF5A0))
    level._id_5F92F1F4D7FAF5A0 = getdvarint("dvar_CF23E6B4C2AE4E63", level.maxteamsize);

  return level._id_5F92F1F4D7FAF5A0;
}

_id_82ACA4B8517CF46A() {
  if(!isDefined(level._id_414EA35A258152F2))
    level._id_414EA35A258152F2 = getdvarint("dvar_A530E29A7E6E465F", 10);

  return level._id_414EA35A258152F2;
}

_id_47E8570F3B3F9F83() {
  if(!isDefined(level._id_E69E9946B0C86B5B))
    level._id_E69E9946B0C86B5B = getdvarint("dvar_2295FD2D3DD21F90", 20);

  return level._id_E69E9946B0C86B5B;
}

_id_EF81E6FD30058E1B() {
  if(!isDefined(level._id_2CDB5739576268C2))
    level._id_2CDB5739576268C2 = getdvarint("dvar_B030F536FDD71EFB", 1);

  return level._id_2CDB5739576268C2;
}

_id_75A3D83D6F553A46() {
  if(!isDefined(level._id_C650833CE57CE717))
    level._id_C650833CE57CE717 = getdvarint("dvar_F1801DD0C0E36AB6", 5);

  return level._id_C650833CE57CE717;
}

_id_F258CA1FD3C63122() {
  if(!isDefined(level._id_4466EC3279C26727))
    level._id_4466EC3279C26727 = getdvarint("dvar_BB74D762EC936B6D", 1000);

  return level._id_4466EC3279C26727;
}

_id_7DFA4473A3663C96(team) {
  if(!_id_6934349B7823D888())
    return 0;

  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_0774C9CA5D1D6221 = players.size;
  return _id_0774C9CA5D1D6221 < _id_17339FA510BD6380();
}

_id_28AE41A833E83C3F(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_E80F1EB2C1910AD4, _id_4ADE2291346E1240) {
  if(!isDefined(_id_3B96D5666000C2E0) || !isDefined(_id_784C8ADA1184FF89))
    return 0;

  if(_id_9F1145C4CCE86B2C(_id_E80F1EB2C1910AD4)) {
    _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_DISABLED");
    return 0;
  }

  if(_id_9F1145C4CCE86B2C(_id_3B96D5666000C2E0) || _id_9F1145C4CCE86B2C(_id_784C8ADA1184FF89)) {
    _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_DISABLED_ENEMY");
    return 0;
  }

  _id_1672C24528714D7D = _id_784C8ADA1184FF89.team;

  if(_id_1672C24528714D7D == _id_3B96D5666000C2E0.team)
    return 0;

  if(!_id_04AAECA4295A600D(_id_1672C24528714D7D, _id_3B96D5666000C2E0, _id_E80F1EB2C1910AD4, _id_4ADE2291346E1240))
    return 0;

  return 1;
}

_id_4335A8EB2D259C81(player) {
  return isDefined(player._id_7F1423DF13BBB144);
}

_id_E2AED369E0BAC150() {
  if(!isDefined(level._id_9CC2A7F8358ECB3B))
    level._id_9CC2A7F8358ECB3B = getdvarint("dvar_A267FF0E64F57760", 0);

  return level._id_9CC2A7F8358ECB3B;
}

_id_04AAECA4295A600D(_id_1672C24528714D7D, _id_3B96D5666000C2E0, _id_E80F1EB2C1910AD4, _id_72CE9FA792FD31A1) {
  if(_id_9F3B05F2EA701548() && !istrue(_id_3B96D5666000C2E0.inlaststand)) {
    if(!istrue(_id_72CE9FA792FD31A1))
      _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_NOT_DOWNED");

    return 0;
  } else if(!_id_7DFA4473A3663C96(_id_1672C24528714D7D)) {
    if(!istrue(_id_72CE9FA792FD31A1))
      _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");

    return 0;
  } else if(_id_3B96D5666000C2E0 scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    if(!istrue(_id_72CE9FA792FD31A1))
      _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_IN_VEHICLE");

    return 0;
  } else if(isDefined(level._id_C83AA9DBC3654AFA) && (isDefined(level._id_2C6B8985DB118349) && ![[level._id_2C6B8985DB118349]](_id_3B96D5666000C2E0, _id_1672C24528714D7D))) {
    if(!istrue(_id_72CE9FA792FD31A1))
      _id_E80F1EB2C1910AD4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_ELITE_CONTRACT");

    return 0;
  }

  return 1;
}

_id_BB4125D6847AF349(player, _id_3170CA906B2241A6) {
  if(!isDefined(player._id_CD20B5C89CA5F5D0))
    player._id_CD20B5C89CA5F5D0 = [];

  _id_5631C1E8DE9DA238 = _id_9F1145C4CCE86B2C(player);
  player._id_CD20B5C89CA5F5D0[_id_3170CA906B2241A6] = 1;
  _id_52F051D04C06AF73 = _id_9F1145C4CCE86B2C(player);

  if(_id_52F051D04C06AF73 && !_id_5631C1E8DE9DA238)
    player setclientomnvar("ui_assimilation_disabled", 1);
}

_id_59CF08630DD70540(player, _id_3170CA906B2241A6) {
  if(!isDefined(player._id_CD20B5C89CA5F5D0))
    player._id_CD20B5C89CA5F5D0 = [];

  _id_5631C1E8DE9DA238 = _id_9F1145C4CCE86B2C(player);
  player._id_CD20B5C89CA5F5D0[_id_3170CA906B2241A6] = undefined;
  _id_52F051D04C06AF73 = _id_9F1145C4CCE86B2C(player);

  if(!_id_52F051D04C06AF73 && _id_5631C1E8DE9DA238)
    player setclientomnvar("ui_assimilation_disabled", 0);
}

_id_9F1145C4CCE86B2C(player) {
  return istrue(level._id_ED844DB90CB6D370) || isDefined(player._id_CD20B5C89CA5F5D0) && player._id_CD20B5C89CA5F5D0.size;
}

_id_BFD417BD39BD685D() {
  if(istrue(level._id_ED844DB90CB6D370)) {
    return;
  }
  foreach(player in level.players)
  _id_BB4125D6847AF349(player, "permanent");

  level._id_ED844DB90CB6D370 = 1;
}

_id_A84BF6C8FF064511(targetplayer) {
  targetplayer._id_7F1423DF13BBB144 = undefined;
  targetplayer._id_4F8AFA3693E318D4 = undefined;
  targetplayer._id_312490CD130C9914 = undefined;
  targetplayer setclientomnvar("ui_assimilation_clientnum", -1);
}

_id_E81936C3B6775F2B(player) {
  if(_id_9F1145C4CCE86B2C(player)) {
    if(player scripts\mp\laststand::_id_A2DD7D8143656503(player))
      player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/BLOCKED_BY_INTERROGATE");

    return 0;
  } else if(player scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_IN_VEHICLE");
    return 0;
  }

  return 1;
}

_id_0B530AA511CAC761(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("assimilation_resolved");
  timeout = _id_47E8570F3B3F9F83();
  wait(timeout);
  _id_A84BF6C8FF064511(player);
}

_id_E5DBB2B054D0CABD(player, _id_E9D6E314BAEDB056) {
  level endon("game_ended");
  player endon("disconnect");
  _id_6B108FDA10E6B6A8 = _id_75A3D83D6F553A46();
  player._id_FEE2CCC62E5CC50D = _id_E9D6E314BAEDB056;
  wait(_id_6B108FDA10E6B6A8);
  player._id_FEE2CCC62E5CC50D = undefined;
}

_id_452C678D0120E4B4(player, _id_99BCF6BDF31A0E49) {
  if(!_id_E81936C3B6775F2B(player))
    return 0;

  if(!_id_99BCF6BDF31A0E49 && !_id_7DFA4473A3663C96(player.team)) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showBrDMZSplash")) {
    if(_id_99BCF6BDF31A0E49)
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_used_join_on_target", [player]);
    else
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_used", [player]);
  }

  _id_7FF3973C2AD05964 = _id_F258CA1FD3C63122();
  _id_E965BCE0774276B4 = scripts\mp\utility\player::getplayersinradius(player.origin, _id_7FF3973C2AD05964);
  _id_3D290D914E1249A0 = [];
  _id_E4FC35B9446269CF = _id_EF81E6FD30058E1B();

  foreach(targetplayer in _id_E965BCE0774276B4) {
    success = _id_01D6C7047EF737F2(player, targetplayer, _id_99BCF6BDF31A0E49, _id_E4FC35B9446269CF);

    if(istrue(success))
      _id_3D290D914E1249A0[_id_3D290D914E1249A0.size] = targetplayer;
  }

  if(!_id_99BCF6BDF31A0E49)
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_request_you_join_me", [player]);

  if(_id_3D290D914E1249A0.size > 0) {
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_request_nearby", _id_3D290D914E1249A0);
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onRequestTeamAssimilate", player, _id_3D290D914E1249A0);
  }
}

_id_838403168B5AC877(player, _id_E3F7965361B1E757) {
  _id_3B96D5666000C2E0 = scripts\engine\utility::ter_op(istrue(player._id_4F8AFA3693E318D4), player._id_7F1423DF13BBB144, player);
  _id_784C8ADA1184FF89 = scripts\engine\utility::ter_op(istrue(player._id_4F8AFA3693E318D4), player, player._id_7F1423DF13BBB144);

  if(!_id_28AE41A833E83C3F(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, player, 0)) {
    player setclientomnvar("ui_assimilation_clientnum", -1);
    return;
  }

  if(_id_E3F7965361B1E757) {
    _id_5822C1EC52C77E6E(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, 0);
    _id_1E4A61DB11011446::updateplayerandteamcountui();
  } else if(player._id_4F8AFA3693E318D4) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_denied_join_on_target", [player._id_7F1423DF13BBB144]);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_you_denied_join_on_target", [player]);
  } else {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_denied", [player._id_7F1423DF13BBB144], undefined, player getentitynumber());
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_you_denied", [player]);
  }

  _id_A84BF6C8FF064511(player);
  player notify("assimilation_resolved");
}

_id_9AD90F0A744225A8(team) {
  _id_7273312620004BC3 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(_id_B2810E8D06E0A042 in _id_7273312620004BC3) {
    if(isDefined(_id_B2810E8D06E0A042)) {
      _id_B2810E8D06E0A042 notify("refresh_revives");
      plundercount = _id_B2810E8D06E0A042.plundercount;
      data = _id_6AFF3948CF4CCA03::createplayerplundereventdata();
      data.setplunderifunchanged = 1;
      _id_B2810E8D06E0A042 _id_6AFF3948CF4CCA03::playersetplundercount(plundercount, data);
    }

    _id_B2810E8D06E0A042 thread _id_07C40FA80892A721::_id_CF547D762189DEAA();
  }

  if(_id_7273312620004BC3.size > 0)
    _id_7273312620004BC3[0] _id_0A34750D17473C49::updateplayereliminatedomnvar("assimilation");
}

_id_5822C1EC52C77E6E(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_B215274F1A3EB134) {
  _id_8A04AA0E0755E7E3 = _id_3B96D5666000C2E0.team;
  _id_EB06B338608EF354 = _id_784C8ADA1184FF89.team;
  _id_43B043539F9C3CCF = _id_784C8ADA1184FF89._id_0FF97225579DE16A;
  _id_67D0631AD9027F83 = !istrue(_id_B215274F1A3EB134);
  _id_BD0B3FA85D4E5899 = [];

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(_id_8A04AA0E0755E7E3, "players")) {
    if(isDefined(_id_B2810E8D06E0A042) && _id_3B96D5666000C2E0 != _id_B2810E8D06E0A042)
      _id_BD0B3FA85D4E5899[_id_BD0B3FA85D4E5899.size] = _id_B2810E8D06E0A042;
  }

  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_request_response_leaving_team", _id_BD0B3FA85D4E5899);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showBrDMZSplash")) {
    if(_id_67D0631AD9027F83)
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("player_team_switched", [_id_3B96D5666000C2E0]);

    players = scripts\mp\utility\teams::getteamdata(_id_EB06B338608EF354, "players");
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("player_joined_team", players, undefined, _id_3B96D5666000C2E0 getentitynumber());
    players = scripts\mp\utility\teams::getteamdata(_id_8A04AA0E0755E7E3, "players");

    if(scripts\engine\utility::array_contains(players, _id_3B96D5666000C2E0))
      players = scripts\engine\utility::array_remove(players, _id_3B96D5666000C2E0);

    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("player_left_team", players, undefined, _id_3B96D5666000C2E0 getentitynumber());
  }

  _id_3B96D5666000C2E0 thread scripts\mp\menus::addtoteam(_id_EB06B338608EF354, undefined, _id_67D0631AD9027F83, 1);
  _id_3B96D5666000C2E0 thread _id_76CC264B397DB9CB::setsquad(_id_EB06B338608EF354, _id_43B043539F9C3CCF);
  _id_3B96D5666000C2E0 thread _id_E5DBB2B054D0CABD(_id_3B96D5666000C2E0, _id_8A04AA0E0755E7E3);
  _id_3B96D5666000C2E0 scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();
  _id_9AD90F0A744225A8(_id_EB06B338608EF354);
  _id_9AD90F0A744225A8(_id_8A04AA0E0755E7E3);
  _id_80139212A4C66A94(_id_3B96D5666000C2E0, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
  _id_3B96D5666000C2E0 _id_6401EE62BFBFF899(_id_8A04AA0E0755E7E3, _id_EB06B338608EF354);
}

_id_01D6C7047EF737F2(_id_E65D25126EF3331B, targetplayer, _id_99BCF6BDF31A0E49, _id_E4FC35B9446269CF) {
  if(targetplayer == _id_E65D25126EF3331B || targetplayer.team == _id_E65D25126EF3331B.team || !isPlayer(targetplayer) || _id_9F1145C4CCE86B2C(targetplayer))
    return 0;

  _id_1672C24528714D7D = scripts\engine\utility::ter_op(_id_99BCF6BDF31A0E49, targetplayer.team, _id_E65D25126EF3331B.team);
  _id_3B96D5666000C2E0 = scripts\engine\utility::ter_op(_id_99BCF6BDF31A0E49, _id_E65D25126EF3331B, targetplayer);

  if(!_id_04AAECA4295A600D(_id_1672C24528714D7D, _id_3B96D5666000C2E0, _id_E65D25126EF3331B, 1))
    return 0;

  if(_id_E4FC35B9446269CF) {
    _id_9001DA663C7CDFEC = vectorNormalize(targetplayer.origin - self.origin);
    _id_9913FD1FFEA99C33 = vectordot(anglesToForward(self.angles), _id_9001DA663C7CDFEC);

    if(_id_9913FD1FFEA99C33 < 0)
      return 0;
  }

  targetplayer setclientomnvar("ui_assimilation_clientnum", _id_E65D25126EF3331B getentitynumber());
  targetplayer setclientomnvar("ui_assimilation_join_on_target", _id_99BCF6BDF31A0E49);
  targetplayer._id_7F1423DF13BBB144 = _id_E65D25126EF3331B;
  targetplayer thread _id_0B530AA511CAC761(targetplayer);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showBrDMZSplash")) {
    _id_C2D8959D0CCC0ADB = _id_82ACA4B8517CF46A();

    if(!isDefined(targetplayer._id_312490CD130C9914) || targetplayer._id_312490CD130C9914 + _id_C2D8959D0CCC0ADB > gettime() || targetplayer._id_4F8AFA3693E318D4 != _id_99BCF6BDF31A0E49) {
      if(_id_99BCF6BDF31A0E49)
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_requested_join_on_target", [targetplayer], undefined, _id_E65D25126EF3331B getentitynumber());
      else
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_requested", [targetplayer], undefined, _id_E65D25126EF3331B getentitynumber());

      targetplayer._id_312490CD130C9914 = gettime();
    }
  }

  targetplayer._id_4F8AFA3693E318D4 = _id_99BCF6BDF31A0E49;

  if(_id_E2AED369E0BAC150())
    _id_838403168B5AC877(targetplayer, 1);

  return 1;
}

_id_6401EE62BFBFF899(_id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player = self;

  if(!isDefined(player)) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_xuid";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player getxuid();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_entity_num";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player getentitynumber();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "old_team";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8A04AA0E0755E7E3;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "old_team_alive_teammates";

  if(isDefined(level.teamdata[_id_8A04AA0E0755E7E3]["alivePlayers"]))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = level.teamdata[_id_8A04AA0E0755E7E3]["alivePlayers"].size;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = -1;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "new_team";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_EB06B338608EF354;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "new_team_alive_teammates";

  if(isDefined(level.teamdata[_id_EB06B338608EF354]["alivePlayers"]))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = level.teamdata[_id_EB06B338608EF354]["alivePlayers"].size;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = -1;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "last_assimilation_request_time";

  if(isDefined(player._id_312490CD130C9914))
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player._id_312490CD130C9914;
  else
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = -1;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "game_time";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(gettime() / 1000);
  player dlog_recordplayerevent("dlog_event_team_assimilation", _id_EC6A81EAC0E4DC61);
}