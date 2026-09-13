/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\toma_strike.gsc
*****************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "init")]]();

  level.toma_strikes = [];
  level._id_2512ECDB67F24156 = 0;
  level._id_EB94E9CCD3DA6B2E = getdvarint("scr_toma_strike_notify_time", 0);
  init_toma_strike_vo();
  _id_F690E3AC50D71008();
}

init_toma_strike_vo() {
  game["dialog"]["toma_strike_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["toma_strike_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["toma_strike_miss_target"] = "killstreak_remote_operator_miss_target";
}

_id_F690E3AC50D71008() {
  level._id_D05191E44C57D2F7 = "toma_strike_placement";
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910(level._id_D05191E44C57D2F7, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers"]);
}

trytomastriketriggered(streakinfo) {
  streakname = streakinfo.streakname;
  _id_DB99A5290E2A0CD0 = getdvarint("dvar_1EB5365BDAD13B78", 0);
  return 1;
}

gettimeremaining() {
  _id_AEA16E6A3159CBDA = undefined;

  foreach(_id_D9F03CE835EE985B in level.toma_strikes) {
    _id_8DD9F2EB8215A139 = int(max(1, _id_D9F03CE835EE985B._id_7BF1255A3715A632 + _id_D9F03CE835EE985B._id_FC1E1636B43C53ED * 1000 - gettime()));

    if(!isDefined(_id_AEA16E6A3159CBDA) || _id_8DD9F2EB8215A139 < _id_AEA16E6A3159CBDA)
      _id_AEA16E6A3159CBDA = _id_8DD9F2EB8215A139;
  }

  return int(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_AEA16E6A3159CBDA)) + 1;
}

weapongiventomastrike(streakinfo) {
  if(isDefined(level.toma_strikes) && level.toma_strikes.size >= 2) {
    if(istrue(level._id_EB94E9CCD3DA6B2E)) {
      _id_80B642A0F8C9659D = gettimeremaining();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME", _id_80B642A0F8C9659D);
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_using_clusterstrike", 1);

  return 1;
}

weaponfiredtomastrike(streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780) {
  if(!isDefined(streakinfo.targetoverride)) {
    _id_0B21E2E887C161B9 = tomastrike_getownerlookat(self);

    if(!isDefined(_id_0B21E2E887C161B9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");

      return "continue";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");

    return "continue";
  }

  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("toma_strike", "toma_strike_use", 1, _id_52A5BE2E2F91D710);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_using_clusterstrike", 0);

  return "success";
}

tryusetomastrike() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", self);
  return tryusetomastrikefromstruct(streakinfo);
}

tryusetomastrikefromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_DB99A5290E2A0CD0 = getdvarint("dvar_1EB5365BDAD13B78", 0);
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

  if(_id_E005D4B70D6F2611)
    _id_DB99A5290E2A0CD0 = 1;

  if(_id_DB99A5290E2A0CD0 == 1 && isDefined(self.kstargetlocation)) {
    streakinfo.targetoverride = self.kstargetlocation;
    self.kstargetlocation = undefined;
    _id_9CF1D5B97D062B8A = weaponfiredtomastrike(streakinfo, undefined, undefined);

    if(_id_9CF1D5B97D062B8A != "success")
      return 0;
  } else {
    if(isDefined(level._id_D05191E44C57D2F7))
      streakinfo._id_FB58A31C756DB4CC = level._id_D05191E44C57D2F7;

    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, makeweapon("iw9_laser_large_ir_mp"), "weapon_fired", ::weapongiventomastrike, undefined, ::weaponfiredtomastrike);

    if(!istrue(_id_9B1DEB5E9D32BBE3)) {
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        self setclientomnvar("ui_using_clusterstrike", 0);

      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_toma_strike", self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);

  starttomastrike(_id_DB99A5290E2A0CD0, streakinfo);
  return 1;
}

starttomastrike(_id_EBFC9454321CB5C3, streakinfo) {
  _id_667382A9BCAB1E3F = _id_D46771D03C3E46FA();
  _id_E744D4EDAFED7523(_id_667382A9BCAB1E3F, _id_EBFC9454321CB5C3);
  thread tomastrike_watchgameend(_id_667382A9BCAB1E3F, streakinfo);
  thread _id_817D8B8F6D28B2B7(_id_667382A9BCAB1E3F, streakinfo);
  thread _id_BB7E41C7F2AFB421(_id_667382A9BCAB1E3F);
  thread tomastrike_attacktarget(_id_EBFC9454321CB5C3, undefined, undefined, streakinfo, _id_667382A9BCAB1E3F);
  streakinfo notify("killstreak_finished_with_deploy_weapon");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "munitionUsed")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doOnActionScoreEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doOnActionScoreEvent")]](2, "tomaStrikeUsed");
}

tomastrike_getownerlookat(owner) {
  _id_C56207BDA09B3A36 = ["physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_22C4300CE1D248E8 = owner getvieworigin();

  if(owner _meth_C1092F42B6BBE490())
    _id_22C4300CE1D248E8 = owner _meth_842574CE5FCD5B52();

  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignoreents, contentoverride);
  endpos = undefined;

  if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none")
    endpos = trace["position"];

  return endpos;
}

_id_D46771D03C3E46FA() {
  level._id_2512ECDB67F24156++;
  return self getxuid() + "_" + level._id_2512ECDB67F24156;
}

tomastrike_watchgameend(_id_667382A9BCAB1E3F, streakinfo) {
  level endon("toma_strike_clean_up_" + _id_667382A9BCAB1E3F);
  level waittill("game_ended");

  if(isDefined(self))
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

_id_817D8B8F6D28B2B7(_id_667382A9BCAB1E3F, streakinfo) {
  level endon("game_ended");
  level thread _id_9BDB853BE512D3ED("disconnect", _id_667382A9BCAB1E3F, self);
  level thread _id_9BDB853BE512D3ED("toma_strike_finished_" + _id_667382A9BCAB1E3F, _id_667382A9BCAB1E3F);
  level waittill("toma_strike_clean_up_" + _id_667382A9BCAB1E3F);

  if(isDefined(self))
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);

  level.toma_strikes[_id_667382A9BCAB1E3F] = undefined;
}

_id_9BDB853BE512D3ED(_id_BF4A0ADF8E2321FE, _id_667382A9BCAB1E3F, player) {
  level endon("toma_strike_clean_up_" + _id_667382A9BCAB1E3F);
  _id_C586EC36655FD62F = level;

  if(isDefined(player))
    _id_C586EC36655FD62F = player;

  _id_C586EC36655FD62F waittill(_id_BF4A0ADF8E2321FE);
  level notify("toma_strike_clean_up_" + _id_667382A9BCAB1E3F);
}

_id_BB7E41C7F2AFB421(_id_667382A9BCAB1E3F) {
  level endon("game_ended");
  self notify("toma_strike_watch_kills");
  self endon("toma_strike_watch_kills");
  self._id_EFFDA3765A5CAF17 = 0;
  childthread _id_44FFB652B0E5C138(_id_667382A9BCAB1E3F);
  childthread _id_9B8A16F9169AC8B2(_id_667382A9BCAB1E3F);
  level waittill("toma_strike_finished_" + _id_667382A9BCAB1E3F);

  if(isDefined(self)) {
    if(self._id_EFFDA3765A5CAF17 >= 1)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("toma_strike", "toma_strike_hit_target", 1);
    else
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("toma_strike", "toma_strike_miss_target", 1);
  }
}

_id_44FFB652B0E5C138(_id_667382A9BCAB1E3F) {
  level endon("toma_strike_finished_" + _id_667382A9BCAB1E3F);

  while(isDefined(self)) {
    self waittill("update_rapid_kill_buffered", recentkillcount, _id_366B0ECC2F28AEAD);

    if(isDefined(_id_366B0ECC2F28AEAD) && _id_366B0ECC2F28AEAD == "toma_proj_mp")
      self._id_EFFDA3765A5CAF17++;
  }
}

_id_9B8A16F9169AC8B2(_id_667382A9BCAB1E3F) {
  level endon("toma_strike_finished_" + _id_667382A9BCAB1E3F);

  while(isDefined(self)) {
    self waittill("update_rapid_agent_kill_buffered", recentkillcount, _id_366B0ECC2F28AEAD);

    if(isDefined(_id_366B0ECC2F28AEAD) && _id_366B0ECC2F28AEAD == "toma_proj_mp")
      self._id_EFFDA3765A5CAF17++;
  }
}

_id_E744D4EDAFED7523(_id_667382A9BCAB1E3F, _id_EBFC9454321CB5C3) {
  level.toma_strikes[_id_667382A9BCAB1E3F] = spawnStruct();
  level.toma_strikes[_id_667382A9BCAB1E3F]._id_7BF1255A3715A632 = gettime();
  level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED = 2;
  level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A = [];
  _id_18CC836DF8B49E94 = getdvarint("dvar_604652367665C1E0", 1);
  _id_90B839CE7FA33C5F = 4;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_90B839CE7FA33C5F = 3;

  if(_id_18CC836DF8B49E94 == 1) {
    level.toma_strikes[_id_667382A9BCAB1E3F].wavedelay = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_90B839CE7FA33C5F; _id_AC0E594AC96AA3A8++) {
      level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A[_id_AC0E594AC96AA3A8] = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 4; _id_AC0E5C4AC96AAA41++) {
        _id_0CF1441229A2390C = randomfloatrange(0.5, 0.75);
        level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED = level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED + _id_0CF1441229A2390C;
        level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A[_id_AC0E594AC96AA3A8][_id_AC0E5C4AC96AAA41] = _id_0CF1441229A2390C;
      }

      _id_0CF1441229A2390C = randomfloatrange(3.25, 4.0);
      level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED = level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED + _id_0CF1441229A2390C;
      level.toma_strikes[_id_667382A9BCAB1E3F].wavedelay[_id_AC0E594AC96AA3A8] = _id_0CF1441229A2390C;
    }
  } else {
    [_id_D52EB0B612B4AAA2, radius] = _id_19051844BA5D9143(_id_EBFC9454321CB5C3);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D52EB0B612B4AAA2; _id_AC0E594AC96AA3A8++) {
      _id_0CF1441229A2390C = randomfloatrange(1.35, 2.5);
      level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED = level.toma_strikes[_id_667382A9BCAB1E3F]._id_FC1E1636B43C53ED + _id_0CF1441229A2390C;
      level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A[_id_AC0E594AC96AA3A8] = _id_0CF1441229A2390C;
    }
  }
}

_id_0F05AFCD1F818600(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_2942061B33337051) {
  return level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A[_id_2942061B33337051];
}

_id_DB43C64D90389BEC(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_2648B8FC988ECD74, _id_2942061B33337051) {
  return level.toma_strikes[_id_667382A9BCAB1E3F]._id_0D1DEFCDABEBFB1A[_id_2648B8FC988ECD74][_id_2942061B33337051];
}

_id_2A08E4B3BE6F5721(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_2648B8FC988ECD74) {
  return level.toma_strikes[_id_667382A9BCAB1E3F].wavedelay[_id_2648B8FC988ECD74];
}

_id_19051844BA5D9143(_id_EBFC9454321CB5C3) {
  _id_D52EB0B612B4AAA2 = 6;
  radius = 450;

  if(_id_EBFC9454321CB5C3 == 1) {
    _id_D52EB0B612B4AAA2 = 6;
    radius = 900;
  }

  return [_id_D52EB0B612B4AAA2, radius];
}

tomastrike_attacktarget(_id_EBFC9454321CB5C3, vehicle, marker, streakinfo, _id_667382A9BCAB1E3F) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  streakinfo.shots_fired++;
  _id_0CB6109DF81EF0DC = self.origin + (0, 0, 5000) - anglesToForward(self.angles) * 5000;
  _id_773A048A6C827187 = anglestoright(self.angles);
  _id_4D8559E1E8D5FF3D = undefined;

  if(isDefined(marker)) {
    if(isvector(marker))
      _id_4D8559E1E8D5FF3D = marker;
    else
      _id_4D8559E1E8D5FF3D = marker.origin;
  } else {
    if(_id_EBFC9454321CB5C3 == 1 && isDefined(streakinfo.targetoverride))
      _id_4D8559E1E8D5FF3D = streakinfo.targetoverride;
    else
      _id_4D8559E1E8D5FF3D = tomastrike_getownerlookat(self);

    marker = spawn("script_model", _id_4D8559E1E8D5FF3D);
    marker setModel("ks_toma_strike_marker_mp");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID"))
      marker.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);

    marker.icon = "icon_waypoint_clusterstrike";
    marker setotherent(self);
    marker toma_strike_setmarkerobjective(marker.objidnum, marker.icon, self, 50);
    marker thread toma_strike_handlemarkerscriptable();
  }

  if(_id_EBFC9454321CB5C3 == 1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
      _id_CD37CE775909957B = spawnStruct();
      _id_CD37CE775909957B.streakinfo = streakinfo;
      _id_CD37CE775909957B.targetsite = _id_4D8559E1E8D5FF3D;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_tomahawk", _id_CD37CE775909957B);
    }
  }

  [_id_D52EB0B612B4AAA2, radius] = _id_19051844BA5D9143(_id_EBFC9454321CB5C3);
  scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self, self.team, radius + 300, streakinfo.streakname, _id_4D8559E1E8D5FF3D);
  _id_74B5B12BB6514385 = 2;
  _id_D77253C873D2B420 = anglesToForward(self getplayerangles());
  _id_558047C7AC5A2D65 = anglesToForward(self.angles);
  _id_3C5A1B26C6973C2A = anglestoright(self.angles);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  _id_18CC836DF8B49E94 = getdvarint("dvar_604652367665C1E0", 1);
  _id_90B839CE7FA33C5F = 4;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_90B839CE7FA33C5F = 3;

  if(_id_18CC836DF8B49E94 == 1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_90B839CE7FA33C5F; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 4; _id_AC0E5C4AC96AAA41++) {
        _id_FA378E997A33A137 = findunobstructedfiringinfo(_id_4D8559E1E8D5FF3D, radius, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
        thread tomastrike_firestrike(_id_EBFC9454321CB5C3, _id_FA378E997A33A137, streakinfo);
        _id_0CF1441229A2390C = _id_DB43C64D90389BEC(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41);
        wait(_id_0CF1441229A2390C);
      }

      _id_0CF1441229A2390C = _id_2A08E4B3BE6F5721(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_AC0E594AC96AA3A8);
      wait(_id_0CF1441229A2390C);
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D52EB0B612B4AAA2; _id_AC0E594AC96AA3A8++) {
      _id_FA378E997A33A137 = findunobstructedfiringinfo(_id_4D8559E1E8D5FF3D, radius, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
      thread tomastrike_firestrike(_id_EBFC9454321CB5C3, _id_FA378E997A33A137, streakinfo);
      _id_0CF1441229A2390C = _id_0F05AFCD1F818600(_id_667382A9BCAB1E3F, _id_18CC836DF8B49E94, _id_AC0E594AC96AA3A8);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_0CF1441229A2390C);
    }
  }

  level notify("toma_strike_finished_" + _id_667382A9BCAB1E3F);
}

findunobstructedfiringinfo(_id_27C77D35F1DE2019, _id_A0EDD3F59D938FB1, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A) {
  gravity = getdvarint("bg_gravity", 800);

  if(getdvarint("bg_bristotallynormal", 0))
    gravity = getdvarfloat("dvar_02F4CF62DF1AF9A6", 125);

  _id_FA378E997A33A137 = spawnStruct();
  _id_0CB6109DF81EF0DC = tomastrike_findoptimallaunchpos(_id_27C77D35F1DE2019, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A);
  _id_A78CD67F5364240C = vectorNormalize(_id_27C77D35F1DE2019 - (_id_0CB6109DF81EF0DC[0], _id_0CB6109DF81EF0DC[1], 0));
  _id_1F0FF6559C9092D0 = tomastrike_getrandombombingpoint(_id_27C77D35F1DE2019, _id_A0EDD3F59D938FB1, _id_A78CD67F5364240C);
  _id_DEA0D8BACEEBF59B = (0, 0, -1 * gravity);
  _id_556B5972DBD50CF4 = (_id_1F0FF6559C9092D0.point - 0.5 * _id_DEA0D8BACEEBF59B * squared(4) - _id_0CB6109DF81EF0DC) / 4;
  _id_00F69EFD87385E55 = _id_0CB6109DF81EF0DC + _id_556B5972DBD50CF4 * 3.925 + 0.5 * _id_DEA0D8BACEEBF59B * squared(3.925);
  _id_FA378E997A33A137.sourcepos = _id_0CB6109DF81EF0DC;
  _id_FA378E997A33A137.entityhit = _id_1F0FF6559C9092D0.entityhit;
  _id_FA378E997A33A137.entityhittype = _id_1F0FF6559C9092D0.entityhittype;
  _id_FA378E997A33A137.goalpos = _id_1F0FF6559C9092D0.point;
  _id_FA378E997A33A137.preexplpos = _id_00F69EFD87385E55;
  _id_FA378E997A33A137.initvelocity = _id_556B5972DBD50CF4;
  return _id_FA378E997A33A137;
}

delayscriptablechangethread(_id_74B5B12BB6514385) {
  self.owner endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_timeout_1(_id_74B5B12BB6514385, "stop_marker_guide");
  self setscriptablepartstate("target", "off", 0);
  self delete();
}

tomastrike_screeninterference(_id_33CD555BF93321AD, _id_115D3395A67619BF) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");

  if(isDefined(_id_6D5A295AE3C46554)) {
    _id_6D5A295AE3C46554 visionsetthermalforplayer(_id_115D3395A67619BF);

    if(isDefined(_id_33CD555BF93321AD)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_33CD555BF93321AD);
      _id_6D5A295AE3C46554 visionsetthermalforplayer(self.currentvisionset);
    }
  }
}

tomastrike_getrandombombingpoint(_id_27C77D35F1DE2019, _id_A0EDD3F59D938FB1, _id_A78CD67F5364240C) {
  _id_A0A41BA05E16FFE6 = randomint(_id_A0EDD3F59D938FB1);
  _id_9E5D403038E4C071 = randomint(360);
  x = _id_27C77D35F1DE2019[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
  y = _id_27C77D35F1DE2019[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
  z = _id_27C77D35F1DE2019[2];
  point = (x, y, z);

  if(isDefined(_id_A78CD67F5364240C))
    point = point - _id_A78CD67F5364240C * 100;

  _id_7CCE0455543AEC8E = 10000;

  if(isDefined(level.toma_strike_trace_offset))
    _id_7CCE0455543AEC8E = level.toma_strike_trace_offset;

  _id_470C049A636DB53D = spawnStruct();
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(point + (0, 0, _id_7CCE0455543AEC8E), point - (0, 0, _id_7CCE0455543AEC8E), undefined, contents);

  if(isDefined(trace["entity"])) {
    entity = trace["entity"];
    _id_470C049A636DB53D.entityhit = entity;

    if(tomastrike_isflyingvehicle(entity) || tomastrike_isflyingkillstreak(entity))
      _id_470C049A636DB53D.entityhittype = "flying";
  }

  if(isDefined(trace["position"]))
    point = trace["position"];

  _id_470C049A636DB53D.point = point;
  return _id_470C049A636DB53D;
}

tomastrike_isflyingvehicle(entity) {
  return entity scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue(entity scripts\cp_mp\vehicles\vehicle::vehiclecanfly());
}

tomastrike_isflyingkillstreak(entity) {
  return isDefined(entity.streakinfo) && isDefined(entity.sentientpool) && entity.sentientpool == "Killstreak_Air";
}

tomastrike_firestrike(_id_EBFC9454321CB5C3, _id_FA378E997A33A137, streakinfo, vehicle) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(vehicle)) {
    self earthquakeforplayer(0.35, 1, vehicle.origin, 1000);
    self playlocalsound("weap_cluster_fire");
  }

  missile = magicgrenademanual("toma_proj_mp", _id_FA378E997A33A137.sourcepos, _id_FA378E997A33A137.initvelocity, 6, self);
  missile forcenetfieldhighlod(1);
  _id_D9855D8E772A9061 = getdvarint("dvar_2CFBF02C634789EA", 1);

  if(_id_D9855D8E772A9061 == 0)
    missile setmissileminimapvisible(1);
  else {
    minimapid = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
      minimapid = missile[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_mortar_strike", self.team, undefined, 1, 1);

    missile.minimapid = minimapid;
  }

  missile setentityowner(self);
  missile setotherent(self);
  missile.owner = self;
  missile.streakinfo = streakinfo;
  killcament = spawn("script_model", _id_FA378E997A33A137.sourcepos);
  killcament linkTo(missile, "tag_origin", (10, 0, 10), (0, 0, 0));
  missile.killcament = killcament;
  missile.explodeent = spawn("script_model", missile.origin);
  missile.explodeent setModel("ks_toma_strike_missile_mp");
  missile.explodeent linkTo(missile);
  missile.explodeent dontinterpolate();
  missile.explodeent setentityowner(self);
  missile.explodeent.killcament = killcament;

  if(!istrue(self._id_C0AA24316813868F) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](_id_FA378E997A33A137.goalpos, 512, 300, self.team, 6, self, 1);

  missile setscriptablepartstate("launch", "active", 0);
  missile setscriptablepartstate("trail", "active", 0);
  missile thread toma_strike_watch_owner();
  _id_18CC836DF8B49E94 = getdvarint("dvar_604652367665C1E0", 1);
  _id_63160BEF0A2103D3 = 3.5;
  _id_29893615DE503CF5 = _id_FA378E997A33A137.preexplpos;

  if(_id_18CC836DF8B49E94 != 1)
    missile thread toma_strike_watch_airexplosion(_id_FA378E997A33A137.preexplpos, _id_FA378E997A33A137.entityhit, _id_FA378E997A33A137.entityhittype, 3.925);
  else
    missile thread toma_strike_watch_airexplosion(undefined, undefined, undefined, 5);

  missile thread toma_strike_watch_stuck(_id_18CC836DF8B49E94, vectortoangles(_id_FA378E997A33A137.initvelocity), gettime(), _id_FA378E997A33A137.initvelocity);
  missile.killcament thread toma_strike_move_killcam(_id_63160BEF0A2103D3, _id_29893615DE503CF5);
}

_id_6153B8A392D10771(_id_39EE47D1EA1F5617, _id_63D5339E498E6F77, stuckto, owner, starttime, streakinfo) {
  level endon("game_ended");
  self.exploding = 1;
  _id_DCC903D262B29994 = toma_strike_create_explosion(_id_39EE47D1EA1F5617, _id_63D5339E498E6F77, stuckto, owner, starttime, streakinfo);
  _id_DCC903D262B29994.killcament = self.killcament;
  _id_98DC829402C94023 = "explode_large";

  if(istrue(self._id_4F31AAE63FCDC12E))
    _id_98DC829402C94023 = _id_98DC829402C94023 + "_water";

  _id_DCC903D262B29994 setscriptablepartstate(_id_98DC829402C94023, "active", 0);

  if(isDefined(self.explodeent))
    self.explodeent delete();

  self delete();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(_id_DCC903D262B29994)) {
    if(isDefined(_id_DCC903D262B29994.killcament))
      _id_DCC903D262B29994.killcament delete();

    _id_DCC903D262B29994 delete();
  }
}

_id_441A028592C3CA77(_id_8E46DE7D6785B0D8) {
  self endon("death");
  self.exploding = 1;
  self.explodeent unlink();
  self.explodeent.origin = _id_8E46DE7D6785B0D8;
  self.explodeent setscriptablepartstate("explode", "active", 0);
  thread toma_strike_delay_hide();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(self.explodeent))
    self.explodeent delete();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  self delete();
}

toma_strike_delay_hide() {
  self endon("death");
  wait 0.05;
  self setscriptablepartstate("visibility", "hide", 0);
}

toma_strike_watch_owner() {
  self endon("death");
  self endon("missile_dest_succeed");
  owner = self.owner;
  owner waittill("disconnect");

  if(isDefined(self.killcament))
    self.killcament delete();

  self setmissileminimapvisible(0);
  thread _id_441A028592C3CA77(self.origin);
  self notify("missile_dest_failed");
}

toma_strike_watch_airexplosion(_id_8E46DE7D6785B0D8, entityhit, entityhittype, _id_43B2A9D31E4F271B) {
  self endon("death");
  self endon("missile_dest_failed");
  self endon("missile_dest_succeed");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_43B2A9D31E4F271B);
  self setmissileminimapvisible(0);

  if(!isDefined(_id_8E46DE7D6785B0D8))
    _id_8E46DE7D6785B0D8 = self.origin;

  thread _id_441A028592C3CA77(_id_8E46DE7D6785B0D8);

  if(isDefined(entityhit) && isDefined(entityhittype) && entityhittype == "flying")
    entityhit dodamage(500, _id_8E46DE7D6785B0D8, self.owner, self, "MOD_EXPLOSIVE", makeweapon("toma_proj_mp"));
}

toma_strike_move_killcam(_id_B0CE2D9BBD8D8FAE, endpos) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_B0CE2D9BBD8D8FAE);
  self unlink();
  self moveTo(endpos, 5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

toma_strike_watch_stuck(_id_18CC836DF8B49E94, _id_6951CF1F43BC8EBE, _id_8011CFFB839E8243, _id_7331D469160F6A41) {
  self endon("death");
  self endon("missile_dest_failed");
  stuckto = _id_7EF768A282337B03();
  _id_D9855D8E772A9061 = getdvarint("dvar_2CFBF02C634789EA", 1);

  if(_id_D9855D8E772A9061 == 0)
    self setmissileminimapvisible(0);
  else
    self setmissileminimapvisible(1);

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  if(_id_18CC836DF8B49E94 != 1 && gettime() - _id_8011CFFB839E8243 < 3925.0) {
    thread _id_441A028592C3CA77(self.origin);
    self notify("missile_dest_failed");
    return;
  }

  wait 0.05;
  _id_53705575ED27C4D7 = -1 * getdvarint("bg_gravity", 800);
  _id_42F65B4B53C1F5D4 = (gettime() - _id_8011CFFB839E8243) / 1000;
  _id_CEAB23E7A7E95404 = _id_7331D469160F6A41 + (0, 0, _id_53705575ED27C4D7 * _id_42F65B4B53C1F5D4);

  if(isDefined(stuckto) && isPlayer(stuckto))
    toma_strike_stuck_player(_id_18CC836DF8B49E94, self, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);
  else
    toma_strike_stuck(_id_18CC836DF8B49E94, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);

  self notify("missile_dest_succeed");
}

_id_7EF768A282337B03() {
  self endon("death");
  self endon("missile_dest_failed");
  impactinfo = scripts\cp_mp\killstreaks\cruise_predator::cruisepredator_waittillexplode("missile_stuck", "missile_water_impact");
  stuckto = undefined;

  if(isDefined(impactinfo)) {
    if(impactinfo.msg == "missile_stuck")
      stuckto = impactinfo.param1;
    else if(impactinfo.msg == "missile_water_impact")
      self._id_4F31AAE63FCDC12E = 1;
  }

  return stuckto;
}

toma_strike_stuck(_id_18CC836DF8B49E94, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  angles = undefined;
  forward = vectorNormalize(_id_CEAB23E7A7E95404);
  up = anglestoup(self.angles);
  right = anglestoright(_id_6951CF1F43BC8EBE);

  if(istrue(self._id_4F31AAE63FCDC12E))
    up = (0, 0, 1);

  if(abs(vectordot(forward, up)) >= 0.9848)
    angles = toma_strike_rebuild_angles_up_right(up, right);
  else
    angles = toma_strike_rebuild_angles_up_forward(up, forward);

  self.angles = angles;

  if(_id_18CC836DF8B49E94 == 1)
    thread _id_6153B8A392D10771(self.origin, angles, stuckto, self.owner, gettime(), self.streakinfo);
  else
    thread toma_strike_launch_cluster(self, self.origin, angles, stuckto, gettime());
}

toma_strike_stuck_player(_id_18CC836DF8B49E94, grenade, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  _id_CEAB23E7A7E95404 = _id_CEAB23E7A7E95404 * (0, 0, 1);
  caststart = grenade.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    castend = _id_E021C2744CC7ED68[0]["position"];
    _id_A95D04F8F906E839 = _id_E021C2744CC7ED68[0]["normal"];
    _id_8D3DD4E0CA9BB1C0 = _id_E021C2744CC7ED68[0]["entity"];
    castend = castend - _id_A95D04F8F906E839 * 1;
    _id_53705575ED27C4D7 = -1 * getdvarint("bg_gravity", 800);
    _id_AC0E564AC96A9D0F = vectordot(castend - caststart, castdir);
    t = sqrt(2 * _id_AC0E564AC96A9D0F / (-1 * _id_53705575ED27C4D7));
    up = _id_A95D04F8F906E839;
    right = anglestoright(_id_6951CF1F43BC8EBE);
    _id_4B65413211AF7033 = toma_strike_rebuild_angles_up_right(up, right);

    if(_id_18CC836DF8B49E94 == 1)
      thread _id_6153B8A392D10771(self.origin, _id_4B65413211AF7033, stuckto, self.owner, gettime(), self.streakinfo);
    else
      thread toma_strike_launch_cluster(grenade, castend, _id_4B65413211AF7033, _id_8D3DD4E0CA9BB1C0, gettime() + t * 1000);
  }
}

toma_strike_launch_cluster(grenade, _id_183BDCC9E630D8DD, _id_4B65413211AF7033, _id_3AE043BBB7B2FDF0, impacttime) {
  owner = grenade.owner;
  killcament = grenade.killcament;
  _id_DA984FE90CC9723C = anglestoup(_id_4B65413211AF7033);
  caststart = _id_183BDCC9E630D8DD + _id_DA984FE90CC9723C * 1;
  castend = caststart + _id_DA984FE90CC9723C * 25;
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    castend = _id_E021C2744CC7ED68[0]["position"] - _id_DA984FE90CC9723C * 1;

  _id_A862BFA81AEE2A1B = castend;
  shareddata = toma_strike_get_shared_data(owner, grenade.streakinfo, impacttime, killcament);
  castdata = toma_strike_get_cast_data();
  _id_8D01E03C5C561B39 = toma_strike_create_branch(shareddata, castdata, undefined, _id_A862BFA81AEE2A1B, _id_4B65413211AF7033, _id_3AE043BBB7B2FDF0, 0, undefined, undefined);
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  _id_8D01E03C5C561B39.killcament = killcament;
  forward = anglesToForward(_id_4B65413211AF7033);
  right = anglestoright(_id_4B65413211AF7033);
  up = anglestoup(_id_4B65413211AF7033);
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, 30);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  castdata = toma_strike_get_cast_data();
  _id_8D01E03C5C561B39 = toma_strike_create_branch(shareddata, castdata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, undefined, undefined);
  _id_8D01E03C5C561B39.killcament = killcament;
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  _id_17F0969AB028C296 = rotatepointaroundvector(up, forward, -30);
  _id_87F08DF736795F51 = vectorNormalize(vectorcross(_id_17F0969AB028C296, up));
  _id_B644A203C149F9AC = vectorcross(_id_87F08DF736795F51, forward);
  _id_106F27F1BC233C55 = axistoangles(_id_17F0969AB028C296, _id_87F08DF736795F51, _id_B644A203C149F9AC);
  castdata = toma_strike_get_cast_data();
  _id_8D01E03C5C561B39 = toma_strike_create_branch(shareddata, castdata, undefined, _id_A862BFA81AEE2A1B, _id_106F27F1BC233C55, _id_3AE043BBB7B2FDF0, 0, undefined, undefined);
  _id_8D01E03C5C561B39.killcament = killcament;
  shareddata.branches[shareddata.branches.size] = _id_8D01E03C5C561B39;
  shareddata toma_strike_shared_data_register_cast();

  foreach(_id_8D01E03C5C561B39 in shareddata.branches)
  _id_8D01E03C5C561B39 thread toma_strike_start_branch();
}

toma_strike_start_branch() {
  killcament = self.killcament;

  if(!isDefined(self.preventstarttime))
    self.preventstarttime = gettime();

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata toma_strike_shared_data_is_complete()) {
      _id_A368D1AFBDCF65DD = toma_strike_branch_create_explosion(self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo);
      _id_A368D1AFBDCF65DD.killcament = killcament;
      _id_A368D1AFBDCF65DD thread toma_strike_start_explosion();
      self.iscomplete = 1;
      self.shareddata toma_strike_shared_data_is_complete(1);
    }
  } else {
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;

    for(;;) {
      if(self.shareddata toma_strike_shared_data_is_complete()) {
        break;
      }

      if(toma_strike_branch_is_complete()) {
        break;
      }

      if(!self.shareddata toma_strike_shared_data_can_cast_this_frame()) {
        waitframe();
        continue;
      }

      if(self.casttype == 0) {
        firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;

        if(isDefined(firstforwardmodanglesfunc)) {
          self.castangles = [[firstforwardmodanglesfunc]](self.castangles);
          self.castdata.firstforwardmodanglesfunc = undefined;
        }
      }

      self.castdir = toma_strike_get_cast_dir(self.castangles, self.casttype);
      self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist(self.casttype, self.castdata);
      _id_10CFD730AD727443 = undefined;
      _id_488AE8E1536D02B3 = undefined;
      _id_A95D04F8F906E839 = undefined;
      _id_8D3DD4E0CA9BB1C0 = undefined;
      _id_D27F9A12A82F66E3 = undefined;
      _id_E021C2744CC7ED68 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        _id_10CFD730AD727443 = 1;
        _id_488AE8E1536D02B3 = _id_E021C2744CC7ED68[0]["position"];
        _id_A95D04F8F906E839 = _id_E021C2744CC7ED68[0]["normal"];
        _id_8D3DD4E0CA9BB1C0 = _id_E021C2744CC7ED68[0]["entity"];
      }

      switch (self.casttype) {
        case 0:
          if(istrue(_id_10CFD730AD727443)) {
            toma_strike_branch_register_cast(self.casttype, 0, _id_488AE8E1536D02B3);
            _id_BB5CF2286A5C3135 = 1;

            if(isDefined(self.castdata.firstforwarddist)) {
              _id_D0914E2FC24E75F8 = _id_488AE8E1536D02B3 - self.caststart;
              _id_64B62CB5DC1E7AF6 = vectordot(_id_D0914E2FC24E75F8, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - _id_64B62CB5DC1E7AF6;

              if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist)
                _id_BB5CF2286A5C3135 = 0;
              else
                self.castdata.firstforwarddist = undefined;
            }

            _id_D27F9A12A82F66E3 = toma_strike_rebuild_angles_up_right(_id_A95D04F8F906E839, anglestoright(self.castangles));

            if(_id_BB5CF2286A5C3135) {
              _id_A368D1AFBDCF65DD = toma_strike_branch_create_explosion(_id_488AE8E1536D02B3, _id_D27F9A12A82F66E3, _id_8D3DD4E0CA9BB1C0, self.shareddata.streakinfo);
              _id_A368D1AFBDCF65DD.killcament = killcament;
              _id_A368D1AFBDCF65DD thread toma_strike_start_explosion();
            }

            self.casttype = 2;
            self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
            self.castangles = _id_D27F9A12A82F66E3;
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);

            if(isDefined(self.castdata.firstforwarddist)) {
              _id_D0914E2FC24E75F8 = self.castend - self.caststart;
              _id_64B62CB5DC1E7AF6 = vectordot(_id_D0914E2FC24E75F8, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - _id_64B62CB5DC1E7AF6;

              if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist)
                self.castdata.firstforwarddist = undefined;
            }

            self.casttype = 1;
            self.caststart = self.castend;
          }

          break;
        case 1:
          if(istrue(_id_10CFD730AD727443)) {
            _id_D27F9A12A82F66E3 = toma_strike_rebuild_angles_up_right(_id_A95D04F8F906E839, anglestoright(self.castangles));
            _id_A368D1AFBDCF65DD = toma_strike_branch_create_explosion(_id_488AE8E1536D02B3, _id_D27F9A12A82F66E3, _id_8D3DD4E0CA9BB1C0, self.shareddata.streakinfo);
            _id_A368D1AFBDCF65DD.killcament = killcament;
            _id_A368D1AFBDCF65DD thread toma_strike_start_explosion();
            _id_970F97CB88D6B89E = vectordot(anglestoup(self.castangles), _id_A95D04F8F906E839);

            if(_id_970F97CB88D6B89E < 0.9848) {
              toma_strike_branch_register_cast(self.casttype, 2, _id_488AE8E1536D02B3);
              self.casttype = 2;
              self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
              self.castangles = _id_D27F9A12A82F66E3;
            } else {
              toma_strike_branch_register_cast(self.casttype, 1, _id_488AE8E1536D02B3);
              self.casttype = 0;
            }
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);
            self.caststart = self.castend;
          }

          break;
        case 2:
          if(istrue(_id_10CFD730AD727443)) {
            toma_strike_branch_register_cast(self.casttype, 3, _id_488AE8E1536D02B3);
            self.casttype = 0;
            self.caststart = _id_488AE8E1536D02B3 + _id_A95D04F8F906E839 * 1;
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);
            self.casttype = 0;
          }

          break;
      }

      waittillframeend;
    }

    self.iscomplete = 1;
    self.shareddata toma_strike_shared_data_is_complete(1);
    self.shareddata.branches = [];
  }
}

toma_strike_branch_create_explosion(origin, angles, stuckto, streakinfo) {
  _id_CE2C16A20E62AB88 = 50;

  if(1)
    _id_CE2C16A20E62AB88 = randomintrange(50, 350);

  starttime = self.preventstarttime + _id_CE2C16A20E62AB88;
  ent = toma_strike_create_explosion(origin + anglestoup(angles), angles, stuckto, self.shareddata.owner, starttime, streakinfo);
  self.preventstarttime = starttime;
  self.ents[self.ents.size] = ent;
  self.shareddata toma_strike_shared_data_register_ent();
  return ent;
}

toma_strike_create_explosion(origin, angles, stuckto, owner, starttime, streakinfo) {
  ent = spawn("script_model", origin);
  ent.angles = angles;
  ent.stuckto = stuckto;
  ent.owner = owner;
  ent.starttime = starttime;
  ent.streakinfo = streakinfo;
  ent setModel("ks_toma_strike_cluster_mp");
  ent setotherent(owner);
  ent setentityowner(owner);

  if(isDefined(stuckto))
    ent linkTo(stuckto);

  return ent;
}

toma_strike_start_explosion() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto))
    self.stuckto endon("death");

  while(gettime() < self.starttime)
    waitframe();

  thread toma_strike_explosion_end();
}

toma_strike_explosion_end() {
  self setscriptablepartstate("explode", "active", 0);
  wait 1;
  self delete();
}

toma_strike_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

toma_strike_shared_data_register_ent() {
  self.entstotal++;
}

toma_strike_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

toma_strike_shared_data_is_complete(_id_AF8745E2185687A8) {
  iscomplete = 0;

  if(self.caststotal >= 60)
    iscomplete = 1;
  else if(self.entstotal >= 20)
    iscomplete = 1;
  else if(istrue(_id_AF8745E2185687A8)) {
    _id_3CE5D6EB962629FA = 1;

    foreach(_id_8D01E03C5C561B39 in self.branches) {
      if(!_id_8D01E03C5C561B39 toma_strike_branch_is_complete()) {
        _id_3CE5D6EB962629FA = 0;
        break;
      }
    }

    if(_id_3CE5D6EB962629FA)
      iscomplete = 1;
  }

  if(iscomplete)
    self.iscomplete = 1;

  return iscomplete;
}

toma_strike_branch_register_cast(casttype, _id_8E87EBE279CDFCFB, _id_8A7FE8798602A3D1) {
  self.shareddata toma_strike_shared_data_register_cast();
  self.casts++;

  if(isDefined(_id_8E87EBE279CDFCFB)) {
    if(_id_8E87EBE279CDFCFB == 0 || _id_8E87EBE279CDFCFB == 1 || _id_8E87EBE279CDFCFB == 2)
      self.castfails = 0;
  } else if(casttype == 1)
    self.castfails++;
}

toma_strike_branch_is_complete(_id_AF8745E2185687A8) {
  iscomplete = 0;
  _id_3CE5D6EB962629FA = undefined;

  if(self.shareddata toma_strike_shared_data_is_complete())
    iscomplete = 1;
  else if(isDefined(self.castdata) && self.castfails >= self.castdata.maxfails)
    iscomplete = 1;
  else if(isDefined(self.castdata) && self.casts >= self.castdata.maxcasts)
    iscomplete = 1;
  else if(isDefined(self.castdata) && self.ents.size >= self.castdata.maxents)
    iscomplete = 1;
  else if(istrue(_id_AF8745E2185687A8)) {
    _id_3CE5D6EB962629FA = 1;

    foreach(_id_8D01E03C5C561B39 in self.branches) {
      if(!_id_8D01E03C5C561B39 toma_strike_branch_is_complete()) {
        _id_3CE5D6EB962629FA = 0;
        break;
      }
    }

    if(_id_3CE5D6EB962629FA)
      iscomplete = 1;
  }

  if(iscomplete && !istrue(self.iscomplete)) {
    oncompletedfunc = self.oncompletedfunc;

    if(isDefined(oncompletedfunc))
      self[[oncompletedfunc]]();

    if(istrue(_id_3CE5D6EB962629FA)) {
      iscomplete = 0;

      foreach(_id_8D01E03C5C561B39 in self.branches) {
        if(!_id_8D01E03C5C561B39 toma_strike_branch_is_complete()) {
          _id_3CE5D6EB962629FA = 0;
          break;
        }
      }

      if(_id_3CE5D6EB962629FA)
        iscomplete = 1;
    }
  }

  if(iscomplete)
    self.iscomplete = 1;

  return iscomplete;
}

toma_strike_create_branch(shareddata, castdata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc) {
  _id_8D01E03C5C561B39 = spawnStruct();
  _id_8D01E03C5C561B39.shareddata = shareddata;
  _id_8D01E03C5C561B39.castdata = castdata;
  _id_8D01E03C5C561B39.startingorigin = startingorigin;
  _id_8D01E03C5C561B39.startingangles = startingangles;
  _id_8D01E03C5C561B39.startingstuckto = startingstuckto;
  _id_8D01E03C5C561B39.startingcasttype = startingcasttype;
  _id_8D01E03C5C561B39.oncompletedfunc = oncompletedfunc;
  _id_8D01E03C5C561B39.ents = [];
  _id_8D01E03C5C561B39.branches = [];
  _id_8D01E03C5C561B39.hitpositions = [];
  _id_8D01E03C5C561B39.hittypes = [];
  _id_8D01E03C5C561B39.casts = 0;
  _id_8D01E03C5C561B39.castfails = 0;
  _id_8D01E03C5C561B39.preventstarttime = preventstarttime;
  return _id_8D01E03C5C561B39;
}

toma_strike_get_shared_data(owner, streakinfo, impacttime, killcament) {
  shareddata = spawnStruct();
  shareddata.owner = owner;
  shareddata.team = owner.team;
  shareddata.streakinfo = streakinfo;
  shareddata.impacttime = impacttime;
  shareddata.branches = [];
  shareddata.entstotal = 0;
  shareddata.caststotal = 0;
  shareddata.caststhisframe = 0;
  shareddata.frametimestamp = gettime();
  shareddata.castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  return shareddata;
}

toma_strike_get_cast_data() {
  castdata = spawnStruct();
  castdata.distforward = 125;
  castdata.distdown = 50;
  castdata.distup = 25;
  castdata.maxcasts = 12;
  castdata.maxfails = 3;
  castdata.maxents = 4;
  return castdata;
}

toma_strike_get_cast_dir(angles, casttype) {
  switch (casttype) {
    case 0:
      return anglesToForward(angles);
    case 1:
      return -1 * anglestoup(angles);
    case 2:
      return anglestoup(angles);
  }

  return undefined;
}

toma_strike_get_cast_dist(casttype, castdata) {
  switch (casttype) {
    case 0:
      if(isDefined(castdata.firstforwarddist))
        return castdata.firstforwarddist;
      else
        return castdata.distforward;
    case 1:
      return castdata.distdown;
    case 2:
      return castdata.distup;
  }

  return undefined;
}

toma_strike_rebuild_angles_up_right(up, right) {
  forward = vectorNormalize(vectorcross(up, right));
  right = vectorcross(forward, up);
  return axistoangles(forward, right, up);
}

toma_strike_rebuild_angles_up_forward(up, forward) {
  right = vectorNormalize(vectorcross(forward, up));
  forward = vectorcross(up, right);
  return axistoangles(forward, right, up);
}

toma_strike_setmarkerobjective(objid, icon, owner, offset) {
  objective_icon(objid, icon);
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, owner);
  objective_onentity(objid, self);
  objective_setzoffset(objid, offset);
  objective_setplayintro(objid, 0);
  objective_setplayoutro(objid, 0);
  objective_setbackground(objid, 1);

  if(level.teambased)
    objective_setownerteam(objid, owner.team);
  else
    objective_setownerclient(objid, owner);

  objective_state(objid, "current");
}

toma_strike_handlemarkerscriptable() {
  self endon("death");
  self setscriptablepartstate("target", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);

    self delete();
  }
}

tomastrike_findoptimallaunchpos(_id_4D8559E1E8D5FF3D, _id_D77253C873D2B420, _id_558047C7AC5A2D65, _id_3C5A1B26C6973C2A) {
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(_id_4D8559E1E8D5FF3D - _id_D77253C873D2B420 * 30, _id_4D8559E1E8D5FF3D + _id_D77253C873D2B420 * 1000, undefined, contents);
  _id_6E7C70B904418DAA = trace["position"] + trace["normal"] * 20;
  targetpos = _id_6E7C70B904418DAA;
  _id_359711DD322783EC = 5000;
  _id_950BC1815E708CB6 = 5000;
  _id_F74F18C717B149E2 = [targetpos + _id_558047C7AC5A2D65 * 100, targetpos - _id_558047C7AC5A2D65 * 100, targetpos + _id_3C5A1B26C6973C2A * 100, targetpos - _id_3C5A1B26C6973C2A * 100, targetpos + (_id_558047C7AC5A2D65 + _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_3C5A1B26C6973C2A - _id_558047C7AC5A2D65) * 100, targetpos + (-1 * _id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100];
  _id_4B92DA7C3F7930E4 = vectorNormalize(_id_F74F18C717B149E2[0] - targetpos);
  _id_899EEF3A2F55B6A6 = targetpos + (0, 0, _id_359711DD322783EC) - _id_4B92DA7C3F7930E4 * _id_950BC1815E708CB6;

  foreach(_id_F9567F37DB523F7A in _id_F74F18C717B149E2) {
    direction = vectorNormalize(_id_F9567F37DB523F7A - targetpos);
    _id_14B9B15CCD581542 = targetpos + (0, 0, _id_359711DD322783EC) - direction * _id_950BC1815E708CB6;
    _id_27AC9F99FC2E7A9B = targetpos;
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace_passed(_id_14B9B15CCD581542, _id_27AC9F99FC2E7A9B, undefined, contents);

    if(!istrue(_id_1F0571D36D0DF95B)) {
      continue;
    }
    _id_899EEF3A2F55B6A6 = _id_14B9B15CCD581542;
    break;
  }

  return _id_899EEF3A2F55B6A6;
}