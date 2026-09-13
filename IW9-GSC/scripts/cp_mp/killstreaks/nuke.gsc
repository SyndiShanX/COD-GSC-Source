/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\nuke.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "init")]]();

  level.nuke_expl_struct = scripts\cp_mp\utility\game_utility::getlocalestruct("nuke_expl_pos");
  level _id_C406CDE778937505();
  level _id_AE8A4B0E2C6B7396();
  level _id_AF7B6584A27AF59F();
}

_id_C406CDE778937505() {
  game["dialog"]["nuke_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["nuke_multi_use"] = "killstreak_remote_operator_request_response";
}

_id_AE8A4B0E2C6B7396() {}

_id_AF7B6584A27AF59F() {
  level.nukeinfo = spawnStruct();
}

tryusenuke(_id_EA8AB1373211E7E6, _id_66CDEDD14979A988) {
  _id_5BB8BCC61BC76D46 = "nuke";

  if(isDefined(_id_EA8AB1373211E7E6))
    _id_5BB8BCC61BC76D46 = _id_EA8AB1373211E7E6;

  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(_id_5BB8BCC61BC76D46, self);
  return tryusenukefromstruct(streakinfo, _id_66CDEDD14979A988);
}

tryusenukefromstruct(streakinfo, _id_66CDEDD14979A988) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  _id_B87822B980D6E763 = scripts\engine\utility::ter_op(isDefined(streakinfo._id_B87822B980D6E763), streakinfo._id_B87822B980D6E763, undefined);
  _id_EB9CBD43BAEAE1C6 = undefined;
  _id_3DABFA23BEF362B5 = scripts\engine\utility::ter_op(isDefined(streakinfo._id_3DABFA23BEF362B5), streakinfo._id_3DABFA23BEF362B5, undefined);

  if(!isDefined(level.nukeinfo._id_9DCCABA98B643CAD)) {
    level.nukeinfo._id_9DCCABA98B643CAD = 1;
    level.nukeinfo.player = self;
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NUKE_ALREADY_INBOUND");

    return 0;
  }

  if(streakinfo.streakname == "nuke_select_location") {
    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845("iw9_spotter_scope_mp"), "weapon_fired", ::weapongivennuke, ::weaponswitchendednuke, ::weaponfirednuke);
    _id_EB9CBD43BAEAE1C6 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);
    _id_3DABFA23BEF362B5 = 25;
    _id_D44B7B1A5D0E8F39 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getOtherTeam"))
      _id_D44B7B1A5D0E8F39 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getOtherTeam")]](streakinfo.owner.team);

    if(isDefined(_id_D44B7B1A5D0E8F39))
      level thread nuke_warnenemiesnukeincoming(_id_D44B7B1A5D0E8F39[0]);
  } else if(!istrue(level.mercywintriggered))
    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, undefined, undefined, undefined, undefined, "ks_remote_nuke_mp", 0);
  else
    _id_9B1DEB5E9D32BBE3 = 1;

  if(!istrue(_id_9B1DEB5E9D32BBE3) || level.gameended) {
    level.nukeinfo._id_9DCCABA98B643CAD = undefined;
    level.nukeinfo.player = undefined;
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      level.nukeinfo._id_9DCCABA98B643CAD = undefined;
      level.nukeinfo.player = undefined;
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  thread nuke_start(streakinfo, 0, undefined, _id_EB9CBD43BAEAE1C6, _id_B87822B980D6E763, _id_3DABFA23BEF362B5, _id_66CDEDD14979A988);

  if(streakinfo.streakname != "nuke_select_location" && !istrue(level.mercywintriggered))
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "nuke", self.origin);

  return 1;
}

weapongivennuke(streakinfo) {
  return 1;
}

weaponswitchendednuke(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(streakinfo, "splash_icon_nuke");
}

weaponfirednuke(streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780) {
  _id_0B21E2E887C161B9 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos(self);

  if(!isDefined(_id_0B21E2E887C161B9)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");

    return "continue";
  }

  return "success";
}

nuke_delaythread(delay, func, owner, streakinfo) {
  level endon("nuke_cancelled");

  if(isDefined(delay)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](delay);
  }

  level thread[[func]](owner, streakinfo);
}

nuke_start(streakinfo, _id_3A565847D875F3EC, _id_EDBE27B2D5F1E060, _id_92AADDAD0FCB1FA8, _id_B87822B980D6E763, _id_3DABFA23BEF362B5, weaponoverride) {
  level endon("nuke_cancelled");
  level notify("used_nuke");
  self notify("used_nuke");
  streakinfo notify("killstreak_finished_with_deploy_weapon", 1);
  nukeinfo = spawnStruct();
  nukeinfo.team = self.pers["team"];
  nukeinfo._id_3A565847D875F3EC = istrue(_id_3A565847D875F3EC);
  nukeinfo.cancelled = undefined;
  nukeinfo._id_AD590A75663898F3 = undefined;
  nukeinfo._id_F30E30BC8F212949 = undefined;
  nukeinfo._id_A8FB915F46A518D9 = 0;
  nukeinfo._id_6D77C28B2DBED93D = 0;
  nukeinfo.nuketype = streakinfo.streakname;
  nukeinfo.streakinfo = streakinfo;
  nukeinfo._id_9DCCABA98B643CAD = 1;

  if(isPlayer(self))
    nukeinfo.player = self;

  nukegoalpoint = _id_B913FA4052092442(nukeinfo.nuketype, _id_92AADDAD0FCB1FA8);
  _id_FFB179778403BED7 = _id_5E29F303004C9602(nukeinfo.nuketype, nukegoalpoint, _id_EDBE27B2D5F1E060);
  _id_D7EA0C53E00A2519 = _id_4EB440A17165AEEE(nukeinfo.nuketype, 6, _id_B87822B980D6E763);
  _id_FC0FFDF77AEEC040 = _id_0CD3712661B44DFB(nukeinfo.nuketype, 10, _id_3DABFA23BEF362B5);
  _id_C9D3F58C83D60D18 = _id_E6E5495E21E67613(nukeinfo.nuketype, weaponoverride);

  if(!isDefined(nukeinfo._id_FC7BD6576D8C85BE)) {
    nukeinfo._id_FC7BD6576D8C85BE = spawn("script_origin", _id_FFB179778403BED7 + (0, 0, 100));
    nukeinfo._id_FC7BD6576D8C85BE dontinterpolate();
    nukeinfo._id_FC7BD6576D8C85BE hide();
  } else
    nukeinfo._id_FC7BD6576D8C85BE.origin = _id_FFB179778403BED7 + (0, 0, 100);

  nukeinfo._id_B0D1C69E44F250EC = _id_FFB179778403BED7;
  nukeinfo._id_76A498119F4D69BC = nukegoalpoint;
  nukeinfo._id_51BEE2F5B3B4E278 = _id_D7EA0C53E00A2519;
  nukeinfo._id_C6773756ACF950FD = _id_FC0FFDF77AEEC040;
  nukeinfo._id_6EA387E8DFA3CCCD = _id_D7EA0C53E00A2519 + _id_FC0FFDF77AEEC040;
  nukeinfo.weapon = _id_C9D3F58C83D60D18;
  nukeinfo.inflictor = spawn("script_model", nukegoalpoint + (0, 0, 5000));
  nukeinfo.inflictor setModel("tag_origin");
  nukeinfo.inflictor.team = nukeinfo.team;
  nukeinfo.inflictor.owner = self;
  nukeinfo.inflictor.streakinfo = streakinfo;
  level.nukeinfo = nukeinfo;
  level thread nuke_startlaunchsequence(self, streakinfo);

  if(nukeinfo.nuketype == "nuke_multi") {
    level thread nuke_delaythread(nukeinfo._id_51BEE2F5B3B4E278, ::_id_2F5646D1EF5C8B81, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_51BEE2F5B3B4E278, ::_id_E361A03E34D52440, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_51BEE2F5B3B4E278, ::_id_36FB604B46A1514A, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_51BEE2F5B3B4E278, ::_id_ACB30EFB36C7F230, self, streakinfo);
  } else {
    if(isDefined(streakinfo.nuketype) && streakinfo.nuketype == "nuke_select_location")
      level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD, ::nuke_createradiationzone, self, streakinfo);

    level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD, ::nuke_slowmo, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD, ::nuke_explosion, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD, ::nuke_earthquake, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD + 0.075, ::nuke_vision, self, streakinfo);
    level thread nuke_delaythread(nukeinfo._id_6EA387E8DFA3CCCD + 5, ::nuke_death, self, streakinfo);
  }

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "addTeamRankXPMultiplier"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "addTeamRankXPMultiplier")]](2, level.nukeinfo.team, "nuke");

  if(level.nukeinfo._id_3A565847D875F3EC)
    level thread nuke_watchownerdisconnect(nukeinfo.player);
}

nuke_watchownerdisconnect(owner) {
  if(!istrue(level.nukeinfo._id_6D77C28B2DBED93D)) {
    soundsettimescalefactorfromtable("nuke");
    level.nukeinfo._id_6D77C28B2DBED93D = 1;
  }

  level endon("game_ended");
  owner waittill("disconnect");
  nuke_cancel();
}

nuke_cancel() {
  level.nukeinfo.cancelled = 1;
  level.nukeinfo._id_9DCCABA98B643CAD = undefined;
  level.nukeinfo.player = undefined;
  nuke_cleartimer();
  setslowmotion(1, 1, 0);
  level notify("nuke_cancelled");
}

nuke_starttimer(_id_42F65B4B53C1F5D4) {
  level endon("nuke_cancelled");

  if(_id_42F65B4B53C1F5D4 <= 1) {
    return;
  }
  if(istrue(level.mercywintriggered))
    setomnvar("ui_nuke_timer_type", 2);
  else
    setomnvar("ui_nuke_timer_type", 0);

  setomnvar("ui_nuke_countdown_active", 1);

  if(isDefined(level.nukeinfo.player))
    setomnvar("ui_nuke_player_id", level.nukeinfo.player getentitynumber());

  level thread nuke_updateuitimers(_id_42F65B4B53C1F5D4);
  _id_4D699CF255438B85 = _id_42F65B4B53C1F5D4;
  _id_4301659E40735D70 = 0;
  _id_8A02211E4FF9CB79 = 0;
  level.nukeinfo._id_FC7BD6576D8C85BE playSound("iw9_mgb_splash");

  while(_id_4D699CF255438B85 > 0) {
    if(_id_4D699CF255438B85 <= 10) {
      if(isDefined(level.nukeinfo.missile) && !istrue(_id_4301659E40735D70)) {
        level thread nuke_startmissileflightaudio();
        _id_4301659E40735D70 = 1;
      }
    }

    if(_id_4D699CF255438B85 <= 4.9) {
      if(isDefined(level.nukeinfo.missile) && !istrue(_id_8A02211E4FF9CB79))
        _id_8A02211E4FF9CB79 = 1;
    }

    wait 1.0;
    _id_4D699CF255438B85--;
  }
}

nuke_startmissileflightaudio() {
  level.nukeinfo.missile endon("death");
  level endon("game_ended");
  wait 7.0;
}

nuke_cleartimer() {
  setomnvar("ui_nuke_countdown_active", -1);
}

nuke_startlaunchsequence(owner, streakinfo) {
  nuketype = level.nukeinfo.nuketype;
  _id_D7EA0C53E00A2519 = level.nukeinfo._id_51BEE2F5B3B4E278;
  _id_FC0FFDF77AEEC040 = level.nukeinfo._id_C6773756ACF950FD;
  _id_81C12FE9C2D29FA7 = level.nukeinfo._id_6EA387E8DFA3CCCD;
  _id_3EB0E5F5F61F0A10 = level.nukeinfo._id_B0D1C69E44F250EC;
  _id_45292519459D6838 = level.nukeinfo._id_76A498119F4D69BC;
  _id_C9D3F58C83D60D18 = level.nukeinfo.weapon;
  _id_22E6BB02F93C20D1 = nuketype == "nuke_multi";
  _id_A3C021E65FF921DC = nuketype == "nuke_select_location";
  level thread nuke_startprelaunchalarm(_id_D7EA0C53E00A2519, streakinfo, owner);

  if(_id_22E6BB02F93C20D1)
    level thread _id_74F04922F32F9F6C(_id_3EB0E5F5F61F0A10, _id_45292519459D6838, _id_81C12FE9C2D29FA7, streakinfo, owner);

  if(isPlayer(owner) && owner ispcplayer())
    owner setclientomnvar("nVidiaHighlights_events", 15);

  if(!istrue(_id_A3C021E65FF921DC)) {
    gametype = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
      gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    _id_AA0023821E2DEE76 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "stopTheClock"))
      _id_AA0023821E2DEE76 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "stopTheClock")]](gametype);

    if(isDefined(_id_AA0023821E2DEE76)) {
      _id_9152DD383AF6E9C2 = getdvarfloat(_id_AA0023821E2DEE76, 0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "setOverTimeLimitDvar"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "setOverTimeLimitDvar")]](_id_9152DD383AF6E9C2);
    }

    level.dontendonscore = 1;

    foreach(player in level.players) {
      if(isDefined(player)) {
        player notify("abort_killcam");
        player.cancelkillcam = 1;
      }
    }

    level thread nuke_abortkillcamonspawn();
    level.disablespawncamera = 1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](_id_D7EA0C53E00A2519);

  level thread nuke_starttimer(_id_FC0FFDF77AEEC040);

  if(istrue(_id_22E6BB02F93C20D1))
    level thread _id_03EB69E3DEEBB567(owner, streakinfo, _id_45292519459D6838, _id_FC0FFDF77AEEC040, _id_C9D3F58C83D60D18);
  else
    level thread nuke_launchmissile(owner, streakinfo, _id_3EB0E5F5F61F0A10, _id_45292519459D6838, _id_FC0FFDF77AEEC040, _id_C9D3F58C83D60D18);
}

nuke_startprelaunchalarm(_id_B807A7599E6F56DC, streakinfo, owner) {
  level endon("game_ended");

  if(istrue(streakinfo._id_93DBD6174CA50E88)) {
    return;
  }
  _id_1D2E95F090749D20 = 0;

  if(isDefined(streakinfo) && isDefined(owner))
    owner thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, 1);

  while(_id_B807A7599E6F56DC > 0) {
    if(isDefined(level.nukeinfo._id_FC7BD6576D8C85BE) && !istrue(_id_1D2E95F090749D20)) {
      level.nukeinfo._id_FC7BD6576D8C85BE playSound("iw9_mgb_siren");
      _id_1D2E95F090749D20 = 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](2);

    _id_B807A7599E6F56DC = _id_B807A7599E6F56DC - 2;
  }
}

_id_74F04922F32F9F6C(_id_5F4190C47572964F, _id_EF2E38E51568075B, _id_81C12FE9C2D29FA7, streakinfo, owner) {
  level endon("game_ended");
  drone = spawn("script_model", _id_5F4190C47572964F);
  drone setModel("veh9_mil_air_large_drone_mp");
  drone setCanDamage(0);
  drone.angles = vectortoangles((_id_EF2E38E51568075B[0], _id_EF2E38E51568075B[1], 0) - (_id_5F4190C47572964F[0], _id_5F4190C47572964F[1], 0));
  drone setscriptablepartstate("engine", "on", 0);
  drone moveTo(_id_5F4190C47572964F + anglesToForward(drone.angles) * 5000, _id_81C12FE9C2D29FA7);
  level.nukeinfo.drone = drone;
}

_id_03EB69E3DEEBB567(owner, streakinfo, _id_45292519459D6838, _id_42F65B4B53C1F5D4, _id_C9D3F58C83D60D18) {
  level endon("game_ended");

  if(isDefined(owner) && isPlayer(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_nuke_multi", owner);
  }

  level.nukeinfo.bombs = [];
  drone = level.nukeinfo.drone;
  _id_A780020E8099CAB2 = (0, 0, -1 * getdvarint("bg_gravity", 800));
  _id_95046B2FB0C1D7A0 = [_id_45292519459D6838 - anglesToForward(drone.angles) * 2500, _id_45292519459D6838 - anglesToForward(drone.angles) * 1000, _id_45292519459D6838 + anglesToForward(drone.angles) * 1000, _id_45292519459D6838 + anglesToForward(drone.angles) * 2500, _id_45292519459D6838];
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1);
  _id_76044267DB696016 = 500;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    _id_2054934DA4FD5851 = 0;
    _id_94E49A1D99BFD258 = _id_AC0E594AC96AA3A8 + 1;

    if(_id_94E49A1D99BFD258 == 5)
      _id_2054934DA4FD5851 = 1;

    _id_9EA4FAF9F08CB80D = drone.origin - (0, 0, 100) + anglesToForward(drone.angles) * 500;
    _id_3EB0E5F5F61F0A10 = _id_9EA4FAF9F08CB80D + anglestoright(drone.angles) * _id_76044267DB696016;
    _id_236EE72FF767D96D = _id_95046B2FB0C1D7A0[_id_AC0E594AC96AA3A8];

    if(!istrue(_id_2054934DA4FD5851)) {
      _id_A0A41BA05E16FFE6 = randomintrange(1000, 2500);
      _id_9E5D403038E4C071 = randomint(360);
      x = _id_95046B2FB0C1D7A0[_id_AC0E594AC96AA3A8][0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
      y = _id_95046B2FB0C1D7A0[_id_AC0E594AC96AA3A8][1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
      z = _id_95046B2FB0C1D7A0[_id_AC0E594AC96AA3A8][2];
      _id_236EE72FF767D96D = (x, y, z);
    }

    _id_3B8C153F4D5D7F16 = scripts\engine\trace::ray_trace(_id_3EB0E5F5F61F0A10, _id_236EE72FF767D96D, drone, _id_FBCABD62B8F66EB8);
    _id_A25BEB2B2566B9C4 = _id_236EE72FF767D96D;

    if(isDefined(_id_3B8C153F4D5D7F16) && isDefined(_id_3B8C153F4D5D7F16["hittype"] != "hittype_none"))
      _id_A25BEB2B2566B9C4 = _id_3B8C153F4D5D7F16["position"];

    _id_10AFA5659C39462F = (_id_A25BEB2B2566B9C4 - 0.5 * _id_A780020E8099CAB2 * squared(_id_42F65B4B53C1F5D4) - _id_3EB0E5F5F61F0A10) / _id_42F65B4B53C1F5D4;
    bomb = magicgrenademanual(_id_C9D3F58C83D60D18, _id_3EB0E5F5F61F0A10, _id_10AFA5659C39462F, _id_42F65B4B53C1F5D4);
    bomb setscriptablepartstate("launch_bomb_source", "on", 0);
    bomb setscriptablepartstate("launch", "on", 0);

    if(istrue(_id_2054934DA4FD5851))
      level notify("nuke_last_bomb_launch");

    level thread _id_610C4D047FAFD311(bomb, streakinfo, _id_42F65B4B53C1F5D4, _id_2054934DA4FD5851);
    level.nukeinfo.bombs[level.nukeinfo.bombs.size] = bomb;
    wait(randomfloatrange(0.5, 1));
    _id_76044267DB696016 = _id_76044267DB696016 - 250;
  }
}

_id_610C4D047FAFD311(bomb, streakinfo, _id_42F65B4B53C1F5D4, _id_2054934DA4FD5851) {
  if(istrue(_id_2054934DA4FD5851)) {
    wait(_id_42F65B4B53C1F5D4 - 2.8);
    bomb setscriptablepartstate("last_bomb_sfx", "on", 0);
    wait 2.8;
  } else
    wait(_id_42F65B4B53C1F5D4);

  position = bomb.origin;
  _id_56F0277B0ED98101 = 3;
  _id_FF85637831346339 = 0.3;
  _id_FF624F78310DEF85 = 0.15;
  _id_FF625578310DFCB7 = 0.1;
  _id_31BFD6CEFEC15DC7 = 1500;
  _id_31E2EACEFEE7D17B = 5000;
  _id_31E2E4CEFEE7C449 = 10000;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](position, _id_56F0277B0ED98101, _id_FF85637831346339, _id_FF624F78310DEF85, _id_FF625578310DFCB7, _id_31BFD6CEFEC15DC7, _id_31E2EACEFEE7D17B, _id_31E2E4CEFEE7C449, undefined, 1, 1);

  bombowner = level.nukeinfo.player;
  _id_8C517B9F2DDB52B3 = 3000;
  _id_D0712DBCA713335F = nuke_cankilleverything();

  if(istrue(_id_2054934DA4FD5851)) {
    level notify("nuke_last_bomb_impact");
    nuke_cleartimer();
    level.nukeinfo._id_AD590A75663898F3 = 1;
    level notify("nuke_detonated");
    thread scripts\engine\utility::play_loopsound_in_space("iw9_mgb_post_fire", bomb.origin);

    if(!istrue(level.mercywintriggered)) {
      if(isDefined(level.nukeinfo.player) && isDefined(streakinfo))
        level.nukeinfo.player scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
    }
  }

  bomb detonate();
}

_id_9E9A2FDC07DCDD72(bomb, _id_42F65B4B53C1F5D4) {
  bomb endon("death");
  bomb endon("explode");
  _id_BF96B95F2DF1D8BC = 0;
  _id_8A02211E4FF9CB79 = 0;

  for(;;) {
    if(_id_BF96B95F2DF1D8BC >= 8) {
      break;
    }

    _id_BF96B95F2DF1D8BC = _id_BF96B95F2DF1D8BC + 0.05;
    wait 0.05;
  }
}

_id_44B8D70A3D3CA307(owner, position, _id_8C517B9F2DDB52B3) {
  _id_32D90540FA4C9FC3 = _id_8C517B9F2DDB52B3 * _id_8C517B9F2DDB52B3;
  _id_705CC2040029EDB7 = owner;
  _id_C9D3F58C83D60D18 = makeweapon(level.nukeinfo.weapon);
  _id_B8FA26A3F6B83CEC = scripts\common\utility::_id_2D7FD59D039FA69B(position, _id_8C517B9F2DDB52B3);

  foreach(_id_7DC3241E7F3C6B24 in _id_B8FA26A3F6B83CEC) {
    if(!isDefined(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_7DC3241E7F3C6B24)) {
        _id_7DC3241E7F3C6B24.nuked = 1;

        if(level.teambased) {
          if(isDefined(owner) && _id_7DC3241E7F3C6B24.team == owner.team || !isDefined(owner))
            _id_705CC2040029EDB7 = _id_7DC3241E7F3C6B24;
        } else if(!isDefined(owner))
          _id_705CC2040029EDB7 = _id_7DC3241E7F3C6B24;

        _id_7DC3241E7F3C6B24 dodamage(999999, level.nukeinfo.inflictor.origin, _id_705CC2040029EDB7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", _id_C9D3F58C83D60D18, "none");
      }
    }
  }

  killstreaklist = level.activekillstreaks;
  _id_BD572A35F03CED5B = undefined;

  if(isDefined(level.vehicle) && isDefined(level.vehicle.interact) && isDefined(level.vehicle.interact.vehicles))
    _id_BD572A35F03CED5B = level.vehicle.interact.vehicles;

  _id_A1A3722FB9707783 = [[level.getactiveequipmentarray]]();
  _id_34CA454BBEC477F1 = [];

  if(isDefined(killstreaklist))
    _id_34CA454BBEC477F1 = scripts\engine\utility::array_combine_unique(_id_34CA454BBEC477F1, killstreaklist);

  if(isDefined(_id_BD572A35F03CED5B))
    _id_34CA454BBEC477F1 = scripts\engine\utility::array_combine_unique(_id_34CA454BBEC477F1, _id_BD572A35F03CED5B);

  if(isDefined(_id_A1A3722FB9707783))
    _id_34CA454BBEC477F1 = scripts\engine\utility::array_combine_unique(_id_34CA454BBEC477F1, _id_A1A3722FB9707783);

  foreach(object in _id_34CA454BBEC477F1) {
    if(!isDefined(object)) {
      continue;
    }
    if(distancesquared(object.origin, position) > _id_32D90540FA4C9FC3) {
      continue;
    }
    if(object scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(object.streakinfo)) {
      object._id_A8F4BB03B366AA80 = 1;
      object scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
      continue;
    }

    object dodamage(99999, level.nukeinfo.inflictor.origin, _id_705CC2040029EDB7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", _id_C9D3F58C83D60D18, "none");
  }
}

nuke_launchmissile(owner, streakinfo, _id_3EB0E5F5F61F0A10, _id_45292519459D6838, _id_42F65B4B53C1F5D4, _id_C9D3F58C83D60D18) {
  level endon("game_ended");

  if(isDefined(owner) && isPlayer(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_nuke", owner);
  }

  _id_A780020E8099CAB2 = (0, 0, -1 * getdvarint("bg_gravity", 800));
  _id_10AFA5659C39462F = (_id_45292519459D6838 - 0.5 * _id_A780020E8099CAB2 * squared(_id_42F65B4B53C1F5D4) - _id_3EB0E5F5F61F0A10) / _id_42F65B4B53C1F5D4;
  level.nukeinfo.missile = magicgrenademanual(_id_C9D3F58C83D60D18, _id_3EB0E5F5F61F0A10, _id_10AFA5659C39462F, _id_42F65B4B53C1F5D4);
  level.nukeinfo.missile setscriptablepartstate("launch", "on", 0);
}

nuke_findunobstructedfiringinfo(_id_8DD61E2F04DC2C58, _id_C85514760EFF92A9, _id_CF90F734F1C34521) {
  nukeinfo = spawnStruct();
  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  _id_7B669BDCC35FD6FA = -2000;
  _id_7B8A85DCC3882150 = 2000;
  _id_A780020E8099CAB2 = (0, 0, -1 * getdvarint("bg_gravity", 800));

  for(;;) {
    _id_BE819573448D27BC = _id_8DD61E2F04DC2C58;
    _id_969BF3922A5AA40B = _id_BE819573448D27BC + (0, 0, 5000);

    if(scripts\engine\trace::ray_trace_passed(_id_BE819573448D27BC, _id_969BF3922A5AA40B, undefined, _id_1BFA180C6FDD09DD)) {
      _id_10AFA5659C39462F = (_id_C85514760EFF92A9 - 0.5 * _id_A780020E8099CAB2 * squared(_id_CF90F734F1C34521) - _id_BE819573448D27BC) / _id_CF90F734F1C34521;
      nukeinfo.sourcepos = _id_BE819573448D27BC;
      nukeinfo.goalpos = _id_C85514760EFF92A9;
      nukeinfo.initvelocity = _id_10AFA5659C39462F;
      break;
    }

    _id_BE819573448D27BC = _id_BE819573448D27BC + anglestoright(self.angles) * randomintrange(_id_7B669BDCC35FD6FA, _id_7B8A85DCC3882150);
    _id_7B669BDCC35FD6FA = int(_id_7B669BDCC35FD6FA * 1.3);
    _id_7B8A85DCC3882150 = int(_id_7B8A85DCC3882150 * 1.3);
    waitframe();
  }

  return nukeinfo;
}

nuke_explosion(owner, streakinfo) {
  level endon("nuke_cancelled");
  nuke_cleartimer();
  level.nukeinfo._id_AD590A75663898F3 = 1;
  level notify("nuke_detonated");

  if(istrue(streakinfo._id_FC46647C49FA8A11)) {
    return;
  }
  if(isDefined(level.nukeinfo.missile)) {
    level.nukeinfo.missile setscriptablepartstate("launch", "off", 0);
    level.nukeinfo.missile delete();
  }

  _id_B19D10A33613EF12 = spawn("script_model", level.nukeinfo._id_76A498119F4D69BC);
  _id_B19D10A33613EF12 setModel("ks_nuke_mp");
  _id_B19D10A33613EF12 setscriptablepartstate("explode", "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete"))
    _id_B19D10A33613EF12 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](50);

  thread nuke_startexplosionaudio(level.nukeinfo._id_76A498119F4D69BC);

  if(level.nukeinfo.nuketype != "nuke_select_location") {
    foreach(_id_7DC3241E7F3C6B24 in level.characters) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](_id_7DC3241E7F3C6B24, nuke_cankilleverything())) {
        if(isPlayer(_id_7DC3241E7F3C6B24)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_7DC3241E7F3C6B24))
              _id_7DC3241E7F3C6B24 thread nuke_startnukedeathfx();
          }
        }
      }
    }
  } else {
    foreach(_id_7DC3241E7F3C6B24 in level.characters) {
      if(isPlayer(_id_7DC3241E7F3C6B24) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_7DC3241E7F3C6B24))
        _id_7DC3241E7F3C6B24 thread nuke_startnukedeathfx_chooselocationversion();
    }
  }
}

nuke_startexplosionaudio(_id_408F3E834E201526) {
  foreach(player in level.players)
  player setsoundsubmix("mp_killstreak_nuke", 6);
}

nuke_slowmo(owner, streakinfo) {
  if(level.nukeinfo.nuketype == "nuke_select_location") {
    return;
  }
  level endon("nuke_cancelled");

  if(istrue(streakinfo._id_E723BC4541254543)) {
    return;
  }
  setnuketimescalefactor();
  level waittill("nuke_death");
  setslowmotion(1, 0.25, 0.1);
}

setnuketimescalefactor() {
  if(!istrue(level.nukeinfo._id_6D77C28B2DBED93D)) {
    soundsettimescalefactorfromtable("nuke");
    level.nukeinfo._id_6D77C28B2DBED93D = 1;
  }
}

nuke_dof(owner, streakinfo) {
  level endon("nuke_cancelled");

  foreach(player in level.players)
  player thread nuke_adjustexplosiondof();
}

nuke_adjustexplosiondof() {
  self endon("disconnect");
  self setphysicaldepthoffield(2.0, 1500);
}

nuke_vision(owner, streakinfo) {
  level endon("nuke_cancelled");
  level.nukeinfo._id_A8FB915F46A518D9 = 1;

  if(istrue(streakinfo._id_9ED60D0D51F90D76)) {
    return;
  }
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("r_materialbloomhqscriptmasterenable", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](0.5);

  level notify("nuke_aftermath_post_started");
  level thread nuke_fadeflashvision(1, 2);
  level waittill("nuke_death");
  level thread nuke_updatevisiononhostmigration();
  level nuke_setaftermathvision(5);
  wait 1.0;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_world_fade", 1.0);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.25);
  }

  level.nukeinfo._id_A8FB915F46A518D9 = 0;
}

nuke_fadeflashvision(_id_A327466DF35C5C88, _id_9D7A33CA9811C391) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](_id_A327466DF35C5C88);

  visionsetnaked("", _id_9D7A33CA9811C391);
}

nuke_death(owner, streakinfo) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level notify("nuke_death");
  winner = level.nukeinfo.player;

  if(level.teambased)
    winner = level.nukeinfo.inflictor.team;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitTillHostMigrationDone")]]();

  _id_CFC1A4C269CFFB70 = nuke_cankilleverything();

  if(isDefined(level.nukeinfo.player)) {
    if(level.nukeinfo.nuketype != "nuke_select_location") {
      foreach(_id_7DC3241E7F3C6B24 in level.characters) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "cankill")]](_id_7DC3241E7F3C6B24, _id_CFC1A4C269CFFB70)) {
          if(isPlayer(_id_7DC3241E7F3C6B24)) {
            _id_7DC3241E7F3C6B24.nuked = 1;

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
              if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_7DC3241E7F3C6B24)) {
                if(!istrue(_id_7DC3241E7F3C6B24.safefromnuke)) {
                  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "killPlayerWithAttacker"))
                    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "killPlayerWithAttacker")]](_id_7DC3241E7F3C6B24);
                }
              }
            }
          }
        }
      }

      if(istrue(_id_CFC1A4C269CFFB70)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]]();
      } else if(!istrue(level.blocknukekills)) {
        _id_B0C33D224B825287 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams"))
          _id_B0C33D224B825287 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](level.nukeinfo.inflictor.team);

        foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "destroyActiveObjects"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "destroyActiveObjects")]](_id_F90358454413407F);
        }
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - nuke", level.nukeinfo.player);
    } else {
      foreach(_id_7DC3241E7F3C6B24 in level.characters) {
        _id_62644FCD8A72B2E8 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone"))
          _id_62644FCD8A72B2E8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](_id_7DC3241E7F3C6B24, level.nukeinfo._id_76A498119F4D69BC, 25000000);

        if(_id_62644FCD8A72B2E8) {
          _id_7DC3241E7F3C6B24.nuked = 1;

          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_7DC3241E7F3C6B24)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "killPlayer"))
              [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "killPlayer")]](_id_7DC3241E7F3C6B24);
          }
        }
      }
    }

    if(!istrue(level.mercywintriggered)) {
      if(isDefined(level.nukeinfo.player) && isDefined(streakinfo))
        level.nukeinfo.player scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
    }
  }

  if(istrue(_id_CFC1A4C269CFFB70)) {
    while(istrue(level.nukeinfo._id_A8FB915F46A518D9))
      waitframe();

    level.nukeinfo._id_F30E30BC8F212949 = 1;
    level thread nuke_delayendgame(0, winner);
  }
}

_id_2F5646D1EF5C8B81(owner, streakinfo) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level waittill("nuke_last_bomb_launch");
  _id_5B4471E9EFDE87C3 = level.nukeinfo._id_C6773756ACF950FD;
  visionsetfadetoblack("nuke_global_flash", _id_5B4471E9EFDE87C3 * 1.75);

  foreach(player in level.players)
  player setsoundsubmix("mp_killstreak_nuke", 6);
}

_id_36FB604B46A1514A(owner, streakinfo) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level waittill("nuke_last_bomb_impact");

  foreach(player in level.players)
  player scripts\cp_mp\utility\player_utility::_freezecontrols(1);

  _id_E6E629829270E1FA();
  wait 0.05;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 3);
  }

  level notify("nuke_bomb_slam_white_finished");
}

_id_E361A03E34D52440(owner, streakinfo) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  _id_5B4471E9EFDE87C3 = level.nukeinfo._id_C6773756ACF950FD;
  _id_D15EA961076C2A0F = _id_5B4471E9EFDE87C3 / 3;
  _id_895E3BF2DB2F84FB = ["far", "mid", "near"];

  for(_id_535B30B922B731E1 = 0; _id_535B30B922B731E1 < _id_895E3BF2DB2F84FB.size; _id_535B30B922B731E1++) {
    _id_F4FA9D362463D738 = "player_mgb_shake_" + _id_895E3BF2DB2F84FB[_id_535B30B922B731E1] + "_mp";

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player notify("nuke_bomb_next_stage");

      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        level thread _id_F903C3E8AABFC042(player, _id_F4FA9D362463D738, "spawned_player");
        continue;
      }

      if(player scripts\cp_mp\utility\player_utility::isusingremote()) {
        level thread _id_F903C3E8AABFC042(player, _id_F4FA9D362463D738, "stopped_using_remote");
        continue;
      }

      scripts\cp_mp\utility\player_utility::_id_F7348E400B4A608D(player, _id_F4FA9D362463D738, 0, 1);
    }

    wait(_id_D15EA961076C2A0F);
  }
}

_id_F903C3E8AABFC042(player, _id_F4FA9D362463D738, _id_4063CDC9B79E33F2) {
  player endon("death_or_disconnect");
  player endon("nuke_bomb_next_stage");
  player endon("nuke_bomb_delayed_earthquake");
  level endon("game_ended");
  player waittill(_id_4063CDC9B79E33F2);
  scripts\cp_mp\utility\player_utility::_id_F7348E400B4A608D(player, _id_F4FA9D362463D738, 0, 1);
  player notify("nuke_bomb_delayed_earthquake");
}

_id_ACB30EFB36C7F230(owner, streakinfo) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level waittill("nuke_bomb_slam_white_finished");

  if(getdvarint("dvar_D5FD9067CAFB06B9") == 1) {
    return;
  }
  level notify("nuke_end_game");
  winner = level.nukeinfo.player;

  if(level.teambased)
    winner = level.nukeinfo.inflictor.team;

  level.nukeinfo._id_F30E30BC8F212949 = 1;
  level thread nuke_delayendgame(10, winner, 1);
}

nuke_delayendgame(_id_74B5B12BB6514385, winner, _id_7DB0FFA183F91058, _id_3A4C75A01773062C) {
  level endon("game_ended");

  if(istrue(_id_7DB0FFA183F91058))
    level thread _id_54A492AEF8FD981F(_id_3A4C75A01773062C);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "delayEndGame"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "delayEndGame")]](_id_74B5B12BB6514385, winner);
}

_id_54A492AEF8FD981F(_id_74B5B12BB6514385) {
  level endon("game_ended");

  if(isDefined(_id_74B5B12BB6514385))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  level notify("play_nuke_bnk");
  setomnvarforallclients("post_game_state", 12);

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(player, 0, 1);
  }
}

nuke_earthquake(owner, streakinfo) {
  level endon("nuke_cancelled");
  _id_9798C7AA7C0A8A06 = level.nukeinfo._id_76A498119F4D69BC;
  earthquake(0.4, 1.5, _id_9798C7AA7C0A8A06, 100000);
  level thread nuke_playshockwaveearthquake(streakinfo);
  level waittill("nuke_death");

  if(level.nukeinfo.nuketype == "nuke_select_location")
    earthquake(0.3, 1, _id_9798C7AA7C0A8A06, 100000);
  else
    earthquake(0.7, 3, _id_9798C7AA7C0A8A06, 100000);

  foreach(player in level.players)
  player playRumbleOnEntity("damage_heavy");
}

nuke_playshockwaveearthquake(streakinfo) {
  level endon("nuke_cancelled");
  level endon("nuke_death");
  _id_09B5BA1713B6DB4D = 0.01;
  _id_9798C7AA7C0A8A06 = level.nukeinfo._id_76A498119F4D69BC;

  for(;;) {
    earthquake(_id_09B5BA1713B6DB4D, 0.05, _id_9798C7AA7C0A8A06, 100000);
    wait 0.05;
    _id_09B5BA1713B6DB4D = _id_09B5BA1713B6DB4D + 0.0015;

    if(_id_09B5BA1713B6DB4D >= 0.3)
      _id_09B5BA1713B6DB4D = 0.3;
  }
}

onplayerspawned() {
  if(isDefined(level.nukeinfo._id_AD590A75663898F3))
    thread nuke_setvisionforplayer(0, 0);
}

nuke_setvisionforplayer(_id_74B5B12BB6514385, _id_B18D3429CF88F29F) {
  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0)
    wait(_id_74B5B12BB6514385);

  self visionsetnakedforplayer("nuke_global_aftermath", _id_B18D3429CF88F29F);
}

nuke_updateuitimers(_id_42F65B4B53C1F5D4) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  _id_EF2F4DE95E92EEC7 = _id_42F65B4B53C1F5D4 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", _id_EF2F4DE95E92EEC7);
  level waittill("host_migration_begin");
  _id_3B5803E733581858 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitTillHostMigrationDone"))
    _id_3B5803E733581858 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]]();

  if(_id_3B5803E733581858 > 0)
    setomnvar("ui_nuke_end_milliseconds", _id_EF2F4DE95E92EEC7 + _id_3B5803E733581858);
}

nuke_updatevisiononhostmigration() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    level nuke_setaftermathvision(0);
  }
}

nuke_setaftermathvision(_id_B18D3429CF88F29F) {
  _id_4307F31ED4B7C2A2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "shouldNukeEndGame"))
    _id_4307F31ED4B7C2A2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "shouldNukeEndGame")]]();

  if(!_id_4307F31ED4B7C2A2) {
    return;
  }
  _id_E6E629829270E1FA();
}

_id_E6E629829270E1FA() {
  if(getdvarint("dvar_D5FD9067CAFB06B9") != 1)
    setomnvarforallclients("post_game_state", 11);

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1);
    player setclienttriggeraudiozonepartialwithfade("nuke_killstreak", 2, "ambient", "ambient_events");
  }
}

nuke_startnukedeathfx() {
  self endon("disconnect");

  if(!istrue(self.safefromnuke)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](1, "nuke_active");
  }

  thread nuke_playrollingdeathfx(3.25);
  level waittill("nuke_death");

  if(isDefined(self.burnfxenabled) && self.burnfxenabled > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](1, "nuke_active");
  }

  _id_367958FE652704C6 = 0;

  if(_id_367958FE652704C6)
    return;
}

nuke_startnukedeathfx_chooselocationversion() {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](1, "nuke_active");

  thread nuke_playrollingdeathfx(3.25);
  level waittill("nuke_death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](1, "nuke_active");
}

nuke_playrollingdeathfx(_id_74B5B12BB6514385) {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "hostmigration_waitLongDurationWithPause"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "hostmigration_waitLongDurationWithPause")]](_id_74B5B12BB6514385);

  if(!scripts\cp_mp\utility\player_utility::isusingremote())
    self visionsetnakedforplayer("nuke_deathblur", 4);

  _id_65DFD5B2EA1F9B40 = self.origin;
  _id_7CEEEA837B3CD54A = level.nukeinfo._id_76A498119F4D69BC;
  _id_74AF035D1495D131 = _id_65DFD5B2EA1F9B40;
  _id_212532A53935EAC7 = "nuke_rolling_death";
  playFX(scripts\engine\utility::getfx(_id_212532A53935EAC7), _id_65DFD5B2EA1F9B40, _id_7CEEEA837B3CD54A - _id_74AF035D1495D131, undefined, self);
}

nuke_atomizebody() {
  self endon("disconnect");
  loc[0][0]["org"] = self gettagorigin("j_spineupper");
  loc[0][0]["angles"] = self gettagangles("j_spineupper");
  loc[0][1]["org"] = self gettagorigin("j_spinelower");
  loc[0][1]["angles"] = self gettagangles("j_spinelower");
  loc[0][2]["org"] = self gettagorigin("j_head");
  loc[0][2]["angles"] = self gettagangles("j_head");
  loc[1][0]["org"] = self gettagorigin("j_knee_ri");
  loc[1][0]["angles"] = self gettagangles("j_knee_ri");
  loc[1][1]["org"] = self gettagorigin("j_knee_le");
  loc[1][1]["angles"] = self gettagangles("j_knee_le");
  loc[1][2]["org"] = self gettagorigin("j_elbow_ri");
  loc[1][2]["angles"] = self gettagangles("j_elbow_ri");
  loc[1][3]["org"] = self gettagorigin("j_elbow_le");
  loc[1][3]["angles"] = self gettagangles("j_elbow_le");
  loc[2][0]["org"] = self gettagorigin("j_ankle_le");
  loc[2][0]["angles"] = self gettagangles("j_ankle_le");
  loc[2][1]["org"] = self gettagorigin("j_ankle_ri");
  loc[2][1]["angles"] = self gettagangles("j_ankle_ri");
  loc[2][2]["org"] = self gettagorigin("j_wrist_le");
  loc[2][2]["angles"] = self gettagangles("j_wrist_le");
  loc[2][3]["org"] = self gettagorigin("j_wrist_ri");
  loc[2][3]["angles"] = self gettagangles("j_wrist_ri");
  self.body hide();
  _id_65DFD5B2EA1F9B40 = self.body.origin;
  _id_632C8E583FC9AEA9 = level.nukeinfo.inflictor.origin * (1, 1, 0);
  _id_74AF035D1495D131 = _id_65DFD5B2EA1F9B40 * (1, 1, 0);
  _id_212532A53935EAC7 = "nuke_atomize_body";
  playFX(scripts\engine\utility::getfx(_id_212532A53935EAC7), _id_65DFD5B2EA1F9B40, _id_632C8E583FC9AEA9 - _id_74AF035D1495D131);
}

nuke_cankilleverything() {
  _id_CFC1A4C269CFFB70 = 1;

  if(getdvarint("dvar_D5FD9067CAFB06B9") == 1)
    return 0;

  return _id_CFC1A4C269CFFB70;
}

nuke_createradiationzone(owner, streakinfo) {
  if(!scripts\common\utility::iscp()) {
    if(0) {
      wait 10;
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), (0, 0, 0));
      nuke_registerradzone((0, 0, 0));

      if(!isDefined(level.nukedangerzones))
        level.nukedangerzones = [];

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](level.nukeinfo._id_76A498119F4D69BC - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](level.nukeinfo._id_76A498119F4D69BC - (0, 0, 1000), 5000, 15000, "allies", 4000);
    } else {
      streakinfo.sealevelorigin = (level.nukeinfo._id_76A498119F4D69BC[0], level.nukeinfo._id_76A498119F4D69BC[1], scripts\cp_mp\parachute::getc130sealevel());
      playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), streakinfo.sealevelorigin);
      nuke_registerradzone(streakinfo.sealevelorigin);

      if(!isDefined(level.nukedangerzones))
        level.nukedangerzones = [];

      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](level.nukeinfo._id_76A498119F4D69BC - (0, 0, 1000), 5000, 15000, "axis", 4000);
      level.nukedangerzones[level.nukedangerzones.size] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](level.nukeinfo._id_76A498119F4D69BC - (0, 0, 1000), 5000, 15000, "allies", 4000);
    }
  }

  thread nuke_finalizelocationnuke(owner);
}

nuke_registerradzone(origin) {
  if(!isDefined(level.radzones)) {
    level.radzones = [];
    level thread nuke_radzones_think();
  }

  level.radzones[level.radzones.size] = origin;
}

nuke_removeradzone(_id_B8D14E966AC9D9B8) {
  level.radzones = scripts\engine\utility::array_remove(level.radzones, _id_B8D14E966AC9D9B8);
}

nuke_radzones_think() {
  level endon("game_ended");
  damagetick = 10;

  for(;;) {
    foreach(player in level.players) {
      player.inradzone = 0;

      foreach(_id_456B8F0EA933D0E5 in level.radzones) {
        _id_62644FCD8A72B2E8 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone"))
          _id_62644FCD8A72B2E8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](player, _id_456B8F0EA933D0E5, 25000000);

        if(_id_62644FCD8A72B2E8) {
          if(istrue(player.gasmaskequipped))
            player scripts\cp_mp\gasmask::processdamage(damagetick);
          else {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint"))
              player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_HURT", 2);

            player dodamage(damagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT");
          }

          player.inradzone = 1;
          break;
        }
      }

      if(player.inradzone) {
        continue;
      }
      foreach(_id_456B8F0EA933D0E5 in level.radzones) {
        _id_62644FCD8A72B2E8 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("nuke", "isPlayerInRadZone"))
          _id_62644FCD8A72B2E8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("nuke", "isPlayerInRadZone")]](player, _id_456B8F0EA933D0E5, 36000000);

        if(_id_62644FCD8A72B2E8) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint"))
            player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_RADIATION_WARNING", 2);

          break;
        }
      }
    }

    wait 1;
  }
}

nuke_warnenemiesnukeincoming(_id_9464D7D05C5CA6B5) {
  level endon("nuke_death");

  for(;;) {
    foreach(player in level.players) {
      if(player.team == _id_9464D7D05C5CA6B5) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "tutorialPrint"))
          player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "tutorialPrint")]]("MP/NUKE_SELECT_LAUNCH_DETECTED", 2);
      }
    }

    wait 1;
  }
}

nuke_finalizelocationnuke(owner) {
  wait 20;

  if(istrue(owner.hasnukeselectks))
    owner.hasnukeselectks = 0;

  if(isDefined(owner.killcountthislife))
    owner.killcountthislife = 0;

  visionsetnaked("", 1);
}

nuke_abortkillcamonspawn() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(isDefined(player)) {
      player notify("abort_killcam");
      player.cancelkillcam = 1;
    }
  }
}

_id_B913FA4052092442(nuketype, _id_D3AF29B5DBD3AC10) {
  _id_76A498119F4D69BC = self.origin + anglesToForward(self.angles) * 15000;

  if(isDefined(level.nuke_expl_struct))
    _id_76A498119F4D69BC = level.nuke_expl_struct.origin;

  if(nuketype == "nuke_multi") {
    _id_76A498119F4D69BC = level.mapcenter;

    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm") {
        if(isDefined(level.hqmidpoint))
          _id_76A498119F4D69BC = level.hqmidpoint;
      }
    }
  }

  if(isDefined(_id_D3AF29B5DBD3AC10))
    _id_76A498119F4D69BC = _id_D3AF29B5DBD3AC10;

  return _id_76A498119F4D69BC;
}

_id_5E29F303004C9602(nuketype, _id_76A498119F4D69BC, _id_EDBE27B2D5F1E060) {
  _id_B0D1C69E44F250EC = _id_76A498119F4D69BC + (0, 0, 30000) + anglesToForward(self.angles) * 30000;

  if(nuketype == "nuke_multi")
    _id_B0D1C69E44F250EC = _id_76A498119F4D69BC + (0, 0, 15000) + anglesToForward(self.angles) * 15000;
  else if(isDefined(level.nuke_expl_struct)) {
    _id_48A3E962B69604AC = vectorNormalize((_id_76A498119F4D69BC[0], _id_76A498119F4D69BC[1], 0) - (self.origin[0], self.origin[1], 0));
    _id_B0D1C69E44F250EC = _id_76A498119F4D69BC + _id_48A3E962B69604AC * 15000;
    _id_B0D1C69E44F250EC = _id_B0D1C69E44F250EC + (0, 0, 30000) + _id_48A3E962B69604AC * 5000;
  } else if(nuketype != "nuke_select_location") {}

  if(isDefined(_id_EDBE27B2D5F1E060))
    _id_FFB179778403BED7 = _id_EDBE27B2D5F1E060;

  return _id_B0D1C69E44F250EC;
}

_id_4EB440A17165AEEE(nuketype, starttime, _id_4F5531954A808B12) {
  _id_51BEE2F5B3B4E278 = starttime;

  if(istrue(level.mercywintriggered))
    _id_51BEE2F5B3B4E278 = 0.7;

  if(isDefined(_id_4F5531954A808B12))
    _id_51BEE2F5B3B4E278 = _id_4F5531954A808B12;

  return _id_51BEE2F5B3B4E278;
}

_id_0CD3712661B44DFB(nuketype, _id_5B4471E9EFDE87C3, _id_3DABFA23BEF362B5) {
  _id_960E367A86646A43 = _id_5B4471E9EFDE87C3;

  if(isDefined(_id_3DABFA23BEF362B5))
    _id_960E367A86646A43 = _id_3DABFA23BEF362B5;

  return _id_960E367A86646A43;
}

_id_E6E5495E21E67613(nuketype, weaponoverride) {
  baseweapon = "nuke_mp";

  if(nuketype == "nuke_multi")
    baseweapon = "nuke_multi_mp";

  if(isDefined(weaponoverride))
    baseweapon = weaponoverride;

  return baseweapon;
}