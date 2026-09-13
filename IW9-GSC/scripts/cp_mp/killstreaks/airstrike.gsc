/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airstrike.gsc
***************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "init")]]();

  level._effect["airstrike_tracer"] = loadfx("vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "airstrike_params"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "airstrike_params")]]();

  init_airstrike_flyby_anims();
  init_airstrike_vo();
  _id_BF6596A9C196414C();
  level.activeairstrikes = [];
  level.airstrikecount = 0;
  level._id_4C913E393222C2E1 = getdvarint("dvar_B17A1F9F7D5C5B0D", 0);
  level._id_53A094CF14067B7D = getdvarint("dvar_7017001214D170B1", 0);
  level._id_9FC34B4B891723F8 = getdvarint("dvar_39459995DF574C02", 1000);
  level._id_605EAAC73A2853D3 = getdvarint("dvar_77900C1535C539F5", 1);
  level._id_480D0E884A4F8E2A = getdvarint("dvar_20F5D09C276DA17C", 0);
  level._id_B8200908FD2377D3 = getdvarint("dvar_F6C1CAC5DA2B9DFB", 0);
}

#using_animtree("script_model");

init_airstrike_flyby_anims() {
  level.scr_animtree["precision_airstrike"] = #animtree;
  level.scr_anim["precision_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["precision_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
  level.scr_animtree["multi_airstrike"] = #animtree;
  level.scr_anim["multi_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["multi_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
  level.scr_animtree["fuel_airstrike"] = #animtree;
  level.scr_anim["fuel_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["fuel_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
}

init_airstrike_vo() {
  game["dialog"]["precision_airstrike_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["precision_airstrike_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["precision_airstrike_miss_target"] = "killstreak_remote_operator_miss_target";
  game["dialog"]["fuel_airstrike_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["fuel_airstrike_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["fuel_airstrike_miss_target"] = "killstreak_remote_operator_miss_target";
}

_id_BF6596A9C196414C() {
  level._id_2EEC46C88075849B = "airstrike_placement";
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910(level._id_2EEC46C88075849B, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers"]);
}

_id_85C69E41428AFC7B(_id_79710492B71B9E81, _id_ABD90CC9F0E9501C) {
  if(_id_79710492B71B9E81 == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME") {
    _id_AEA16E6A3159CBDA = undefined;

    foreach(_id_75C01AA76F669A21 in level.activeairstrikes) {
      _id_8DD9F2EB8215A139 = int(max(1, _id_75C01AA76F669A21._id_7BF1255A3715A632 + _id_75C01AA76F669A21._id_05AB9EA557C8B0A4 - gettime()));

      if(!isDefined(_id_AEA16E6A3159CBDA) || _id_8DD9F2EB8215A139 < _id_AEA16E6A3159CBDA)
        _id_AEA16E6A3159CBDA = _id_8DD9F2EB8215A139;
    }

    return int(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_AEA16E6A3159CBDA)) + 1;
  } else if(_id_79710492B71B9E81 == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME") {
    _id_AEA16E6A3159CBDA = undefined;

    foreach(_id_75C01AA76F669A21 in level.activeairstrikes) {
      _id_4F0FC1C36324AFFB = _id_035C596EE06DC6DA();

      if(distance2dsquared(_id_75C01AA76F669A21.origin, _id_ABD90CC9F0E9501C) <= _id_4F0FC1C36324AFFB) {
        _id_8DD9F2EB8215A139 = int(max(1, _id_75C01AA76F669A21._id_7BF1255A3715A632 + _id_75C01AA76F669A21._id_05AB9EA557C8B0A4 - gettime()));

        if(!isDefined(_id_AEA16E6A3159CBDA) || _id_8DD9F2EB8215A139 < _id_AEA16E6A3159CBDA)
          _id_AEA16E6A3159CBDA = _id_8DD9F2EB8215A139;
      }
    }

    return int(scripts\engine\utility::_id_C89ED1840C8D0F0F(_id_AEA16E6A3159CBDA)) + 1;
  }
}

weapongivenairstrike(streakinfo) {
  _id_AF510588B70F5695 = getdvarint("dvar_7DAED56D10A79690", 2);
  _id_79710492B71B9E81 = airstrike_canbeused(self.origin);

  if(_id_79710492B71B9E81 != "success") {
    if(istrue(level._id_B8200908FD2377D3)) {
      _id_80B642A0F8C9659D = _id_85C69E41428AFC7B(_id_79710492B71B9E81, self.origin);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81, _id_80B642A0F8C9659D);
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81);

    return 0;
  }

  if(streakinfo.streakname == "multi_airstrike") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]](0, 1, "long_arrow", undefined, streakinfo);
  } else if(streakinfo.streakname == "fuel_airstrike") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]](undefined, undefined, undefined, undefined, streakinfo);
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_using_airstrike", 1);

  return 1;
}

weaponswitchendedairstrike(streakinfo, _id_41BF9BF4918115AC) {
  _id_AF510588B70F5695 = getdvarint("dvar_7DAED56D10A79690", 2);

  if(istrue(_id_41BF9BF4918115AC)) {
    if(streakinfo.streakname == "precision_airstrike") {
      if(_id_AF510588B70F5695 == 1)
        self laseron();
      else if(_id_AF510588B70F5695 == 2)
        thread airstrike_watchforads(streakinfo);
    }
  }
}

weaponfiredairstrike(streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_using_airstrike", 0);

  if(!isDefined(streakinfo.targetoverride)) {
    _id_0B21E2E887C161B9 = airstrike_getownerlookatpos(self);
    _id_79710492B71B9E81 = airstrike_canbeused(_id_0B21E2E887C161B9);

    if(_id_79710492B71B9E81 != "success") {
      if(istrue(level._id_B8200908FD2377D3)) {
        _id_80B642A0F8C9659D = _id_85C69E41428AFC7B(_id_79710492B71B9E81, _id_0B21E2E887C161B9);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81, _id_80B642A0F8C9659D);
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81);

      return "continue";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");

    return "continue";
  }

  return "success";
}

tryuseairstrike(streakname) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(streakname, self);
  return tryuseairstrikefromstruct(streakinfo);
}

tryuseairstrikefromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = undefined;
  deployweaponobj = level.airstrikesettings[streakinfo.streakname].deployweaponobj;
  _id_8B8AAE1E320EF000 = "";

  switch (streakinfo.streakname) {
    case "precision_airstrike":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && isDefined(self.kstargetlocation)) {
          streakinfo.targetoverride = self.kstargetlocation;
          self.kstargetlocation = undefined;
        }
      }

      if(isDefined(streakinfo.targetoverride)) {
        _id_9CF1D5B97D062B8A = weaponfiredairstrike(streakinfo, undefined, undefined);
        _id_9B1DEB5E9D32BBE3 = _id_9CF1D5B97D062B8A == "success";
      } else {
        if(isDefined(level._id_2EEC46C88075849B))
          streakinfo._id_FB58A31C756DB4CC = level._id_2EEC46C88075849B;

        _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, deployweaponobj, "weapon_fired", ::weapongivenairstrike, ::weaponswitchendedairstrike, ::weaponfiredairstrike);
      }

      _id_8B8AAE1E320EF000 = "precisionAirStrikeUsed";
      break;
    case "multi_airstrike":
    case "fuel_airstrike":
      _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, ::weapongivenairstrike, ::weaponswitchendedairstrike);
      _id_8B8AAE1E320EF000 = "fuelAirStrikeUsed";
      break;
  }

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      self setclientomnvar("ui_using_airstrike", 0);

    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  _id_79710492B71B9E81 = selectairstrikelocation(streakinfo);

  if(!istrue(_id_79710492B71B9E81))
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "munitionUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "munitionUsed")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doOnActionScoreEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doOnActionScoreEvent")]](2, _id_8B8AAE1E320EF000);

  return 1;
}

selectairstrikelocation(streakinfo) {
  _id_0B21E2E887C161B9 = (0, 0, 0);
  mappointinfo = undefined;
  _id_97195D51C4C2B14E = undefined;
  _id_EDC5BB5A4B3DD2FF = undefined;
  _id_42C1C130FD550100 = spawn("script_origin", self.origin);
  _id_F7B6CC6C062A7A43 = "used_" + streakinfo.streakname;

  if(streakinfo.streakname == "precision_airstrike") {
    if(isDefined(streakinfo.targetoverride))
      _id_0B21E2E887C161B9 = streakinfo.targetoverride;
    else
      _id_0B21E2E887C161B9 = airstrike_getownerlookatpos(self, 1);
  } else if(streakinfo.streakname == "multi_airstrike") {
    _id_E44616B849D8AF48 = 3;
    _id_EDC5BB5A4B3DD2FF = 1;
    _id_3B64EB40368C1450::set("select_airstrike_location", "weapon_switch", 0);
    self setsoundsubmix("mp_killstreak_overlay");
    mappointinfo = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint"))
      mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](streakinfo, _id_E44616B849D8AF48, 1);

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("select_airstrike_location");
  } else if(streakinfo.streakname == "fuel_airstrike") {
    _id_E44616B849D8AF48 = 3;
    _id_3B64EB40368C1450::set("select_airstrike_location", "weapon_switch", 0);
    self setsoundsubmix("mp_killstreak_overlay");
    mappointinfo = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint"))
      mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](streakinfo, _id_E44616B849D8AF48);

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("select_airstrike_location");
  }

  if(isDefined(mappointinfo)) {
    foreach(info in mappointinfo) {
      _id_79710492B71B9E81 = airstrike_canbeused(info.location);

      if(_id_79710492B71B9E81 != "success") {
        if(istrue(level._id_B8200908FD2377D3)) {
          _id_80B642A0F8C9659D = _id_85C69E41428AFC7B(_id_79710492B71B9E81, info.location);

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81, _id_80B642A0F8C9659D);
        } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81);

        return 0;
      }
    }

    thread finishmapselectairstrikeusage(mappointinfo, _id_EDC5BB5A4B3DD2FF, _id_0B21E2E887C161B9, _id_97195D51C4C2B14E, streakinfo);
    self clearsoundsubmix("mp_killstreak_overlay");
  } else if(!isDefined(mappointinfo) && (streakinfo.streakname == "multi_airstrike" || streakinfo.streakname == "fuel_airstrike")) {
    if(isDefined(_id_42C1C130FD550100)) {
      _id_42C1C130FD550100 stoploopsound("");
      _id_42C1C130FD550100 delete();
    }

    self clearsoundsubmix("mp_killstreak_overlay");
    return 0;
  } else if(streakinfo.streakname == "precision_airstrike")
    thread finishstandardairstrikeusage(_id_0B21E2E887C161B9, _id_97195D51C4C2B14E, streakinfo);

  if(isDefined(_id_42C1C130FD550100)) {
    _id_42C1C130FD550100 stoploopsound("");
    _id_42C1C130FD550100 delete();
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](_id_F7B6CC6C062A7A43, self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, _id_0B21E2E887C161B9);

  if(level._id_605EAAC73A2853D3)
    scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(self, self.team, level._id_9FC34B4B891723F8, streakinfo.streakname, _id_0B21E2E887C161B9);

  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, _id_52A5BE2E2F91D710);
  return 1;
}

_id_B340BCAC3E4DDA9B(_id_9C3226425EE277DA, mappointinfo) {
  return mappointinfo.size > 1 && _id_9C3226425EE277DA < mappointinfo.size - 1;
}

_id_CA2EFE3DA5D8399D(mappointinfo) {
  _id_C4D1CA5117F9E7EB = [];
  _id_07BA2C5F32045574 = 0;

  foreach(_id_9C3226425EE277DA, _id_470C049A636DB53D in mappointinfo) {
    if(_id_B340BCAC3E4DDA9B(_id_9C3226425EE277DA, mappointinfo)) {
      _id_95582C569DF51F7B = randomfloatrange(0.8, 1.0);
      _id_07BA2C5F32045574 = _id_07BA2C5F32045574 + _id_95582C569DF51F7B;
      _id_C4D1CA5117F9E7EB[_id_9C3226425EE277DA] = _id_95582C569DF51F7B;
    }
  }

  return [_id_07BA2C5F32045574, _id_C4D1CA5117F9E7EB];
}

finishmapselectairstrikeusage(mappointinfo, _id_EDC5BB5A4B3DD2FF, _id_0B21E2E887C161B9, _id_97195D51C4C2B14E, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
  _id_4C4796C182975686 = getanimlength(animname);
  _id_7225662D8217D65A = scripts\engine\utility::get_notetrack_time(animname, "attack");
  _id_B333EE8FEA365230 = _id_4C4796C182975686 - 5;
  [_id_07BA2C5F32045574, _id_C4D1CA5117F9E7EB] = _id_CA2EFE3DA5D8399D(mappointinfo);
  airstrikeid = airstrike_addactivestrike(self.origin, self, _id_B333EE8FEA365230 + _id_07BA2C5F32045574);
  thread airstrike_watchkills(streakinfo, _id_7225662D8217D65A * 2, airstrikeid);
  thread watchairstrikeowner(airstrikeid);
  thread airstrike_watchgameend(streakinfo, airstrikeid);

  foreach(_id_9C3226425EE277DA, _id_470C049A636DB53D in mappointinfo) {
    _id_0B21E2E887C161B9 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = self.angles[1];

    if(istrue(_id_EDC5BB5A4B3DD2FF))
      _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;

    finishairstrikeusage(_id_0B21E2E887C161B9, _id_A4521BB88F4EB389, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid);

    if(_id_B340BCAC3E4DDA9B(_id_9C3226425EE277DA, mappointinfo))
      wait(_id_C4D1CA5117F9E7EB[_id_9C3226425EE277DA]);
  }

  level thread _id_7893C28CFBF65865(self, airstrikeid, _id_B333EE8FEA365230);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_4C4796C182975686);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, self);

  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

finishstandardairstrikeusage(location, _id_97195D51C4C2B14E, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
  _id_4C4796C182975686 = getanimlength(animname);
  _id_7225662D8217D65A = scripts\engine\utility::get_notetrack_time(animname, "attack");
  _id_B333EE8FEA365230 = _id_4C4796C182975686 - 5;
  airstrikeid = airstrike_addactivestrike(location, self, _id_B333EE8FEA365230);
  thread airstrike_watchkills(streakinfo, _id_7225662D8217D65A * 2, airstrikeid);
  thread watchairstrikeowner(airstrikeid);
  thread airstrike_watchgameend(streakinfo, airstrikeid);
  finishairstrikeusage(location, undefined, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid);
  level thread _id_7893C28CFBF65865(self, airstrikeid, _id_B333EE8FEA365230);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_4C4796C182975686);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, self);

  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

finishairstrikeusage(location, _id_A4521BB88F4EB389, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid) {
  self notify("used");
  self notify("airstrike_used");
  doairstrike(location, _id_A4521BB88F4EB389, self, self.pers["team"], _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid);
}

doairstrike(origin, yaw, owner, team, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid) {
  level thread callstrike(owner, origin, yaw, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid);
}

watchairstrikeowner(airstrikeid) {
  self endon("airstrike_finished_" + airstrikeid);
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("disconnect", "joined_team");
  airstrike_removeactivestrike(self, airstrikeid);
}

callstrike(owner, _id_6E7C70B904418DAA, yaw, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid) {
  _id_361663D437DB22F5 = 0;
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  _id_5ED27D0675C3B6EB = 24000;
  _id_23122E7B902F2EA9 = 6500;
  _id_76AB620FD7CC70BD = 2500;
  _id_361663D437DB22F5 = 1500;

  if(isDefined(_id_5FA1E1697A302583))
    _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2];

  localeid = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(localeid) && localeid == "locale_6")
    _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + 500;

  if(level.mapname == "mp_br_mechanics" || scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() || scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::isdonetskmap())
    _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + 2500;

  _id_361663D437DB22F5 = getexplodedistance(_id_76AB620FD7CC70BD);
  direction = undefined;
  _id_505331AD630BBC6B = undefined;

  if(isDefined(yaw))
    direction = (0, yaw, 0);
  else {
    direction = callstrike_findoptimaldirection(owner, _id_6E7C70B904418DAA, _id_76AB620FD7CC70BD, _id_5ED27D0675C3B6EB);
    _id_505331AD630BBC6B = 1;
  }

  flightpath = getflightpath(_id_6E7C70B904418DAA, direction, _id_5ED27D0675C3B6EB, _id_5FA1E1697A302583, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_361663D437DB22F5, streakinfo.streakname, _id_505331AD630BBC6B);

  if(streakinfo.streakname == "precision_airstrike") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++) {
      _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + randomintrange(200, 300);
      level thread doplanestrike(_id_6E7C70B904418DAA, flightpath["startPoint"], flightpath["endPoint"], _id_76AB620FD7CC70BD, _id_97195D51C4C2B14E, streakinfo, animname, owner, airstrikeid);
      wait 3;
    }
  } else
    level thread doplanestrike(_id_6E7C70B904418DAA, flightpath["startPoint"], flightpath["endPoint"], _id_76AB620FD7CC70BD, _id_97195D51C4C2B14E, streakinfo, animname, owner, airstrikeid);
}

callstrike_findoptimaldirection(owner, _id_6E7C70B904418DAA, _id_76AB620FD7CC70BD, _id_5ED27D0675C3B6EB) {
  _id_D77253C873D2B420 = anglesToForward(owner getplayerangles());
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(_id_6E7C70B904418DAA - _id_D77253C873D2B420 * 30, _id_6E7C70B904418DAA + _id_D77253C873D2B420 * 1000, undefined, contents);
  _id_6E7C70B904418DAA = trace["position"] + trace["normal"] * 20;
  targetpos = _id_6E7C70B904418DAA;
  _id_359711DD322783EC = _id_76AB620FD7CC70BD;
  _id_558047C7AC5A2D65 = anglesToForward(owner.angles);
  _id_3C5A1B26C6973C2A = anglestoright(owner.angles);
  _id_3AE184241DC44588 = 0;
  _id_F74F18C717B149E2 = [targetpos + _id_558047C7AC5A2D65 * 100, targetpos - _id_558047C7AC5A2D65 * 100, targetpos + _id_3C5A1B26C6973C2A * 100, targetpos - _id_3C5A1B26C6973C2A * 100, targetpos + (_id_558047C7AC5A2D65 + _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_3C5A1B26C6973C2A - _id_558047C7AC5A2D65) * 100, targetpos + (-1 * _id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100];

  if(level._id_4C913E393222C2E1)
    _id_D9323F93B3960E7C = vectorNormalize(_id_F74F18C717B149E2[2] - targetpos);
  else
    _id_D9323F93B3960E7C = vectorNormalize(_id_F74F18C717B149E2[0] - targetpos);

  _id_E3B1338D5BD4399F = 0;
  _id_601DA10886B0DA3D = 0;
  _id_671B9CB2B0E5D795 = getdvarint("dvar_B44B9052042186A2", 0);

  foreach(_id_F9567F37DB523F7A in _id_F74F18C717B149E2) {
    _id_7A7426E42E674E40 = vectorNormalize(_id_F9567F37DB523F7A - targetpos);
    _id_C45BBEB56DF09B5D = targetpos * (1, 1, 0) + (0, 0, _id_359711DD322783EC);
    _id_32A961DAC02545B0 = _id_C45BBEB56DF09B5D - _id_7A7426E42E674E40 * _id_5ED27D0675C3B6EB;
    _id_19189FD85D8A2C19 = _id_C45BBEB56DF09B5D + _id_7A7426E42E674E40 * _id_5ED27D0675C3B6EB;
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace_passed(_id_32A961DAC02545B0, _id_19189FD85D8A2C19, undefined, contents);

    if(!istrue(_id_1F0571D36D0DF95B)) {
      continue;
    }
    _id_48384E792726B96A = _id_C45BBEB56DF09B5D - _id_7A7426E42E674E40 * int(_id_5ED27D0675C3B6EB / 3);
    _id_E313995ECAD6ABBC = [targetpos, targetpos - _id_7A7426E42E674E40 * 512, targetpos - _id_7A7426E42E674E40 * 256, targetpos + _id_7A7426E42E674E40 * 256, targetpos + _id_7A7426E42E674E40 * 512];
    _id_F0C12707E0CBB8D9 = 0;

    foreach(_id_27AC9F99FC2E7A9B in _id_E313995ECAD6ABBC) {
      results = scripts\engine\trace::ray_trace(_id_48384E792726B96A, _id_27AC9F99FC2E7A9B, undefined, contents);
      _id_1F0571D36D0DF95B = results["fraction"] == 1;

      if(level._id_53A094CF14067B7D) {
        if(results["fraction"] > _id_601DA10886B0DA3D) {
          _id_D9323F93B3960E7C = _id_7A7426E42E674E40;
          _id_601DA10886B0DA3D = results["fraction"];
        }
      }

      if(!istrue(_id_1F0571D36D0DF95B)) {
        wait 0.05;
        continue;
      }

      _id_F0C12707E0CBB8D9++;
      wait 0.05;
    }

    if(_id_F0C12707E0CBB8D9 > _id_E3B1338D5BD4399F) {
      _id_D9323F93B3960E7C = _id_7A7426E42E674E40;
      _id_E3B1338D5BD4399F = _id_F0C12707E0CBB8D9;

      if(_id_F0C12707E0CBB8D9 >= 3) {
        break;
      }
    }
  }

  return _id_D9323F93B3960E7C;
}

doplanestrike(targetsite, _id_6D29E82378E59E76, _id_98255165B50D8173, _id_76AB620FD7CC70BD, _id_97195D51C4C2B14E, streakinfo, animname, owner, airstrikeid) {
  if(!isDefined(owner)) {
    return;
  }
  owner endon("disconnect");
  level endon("game_ended");
  config = level.airstrikesettings[streakinfo.streakname];
  _id_4C4796C182975686 = getanimlength(animname);
  _id_7B00721E9D1EF2A0 = scripts\engine\utility::get_notetrack_time(animname, "attack");
  _id_3A69E5FC82079CE3 = targetsite * (1, 1, 0) + (0, 0, _id_76AB620FD7CC70BD);
  _id_7789CDA8C1E3128E = vectortoangles(_id_98255165B50D8173 - _id_6D29E82378E59E76);
  planemodel = config.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) && isDefined(config.modelbasealt))
    planemodel = config.modelbasealt;

  plane = spawn("script_model", _id_3A69E5FC82079CE3);
  plane setModel(planemodel);
  plane.angles = _id_7789CDA8C1E3128E;
  plane.flightdir = anglesToForward(_id_7789CDA8C1E3128E);
  plane.flightheight = _id_76AB620FD7CC70BD;
  plane.owner = owner;
  plane.team = owner.team;
  plane.lifeid = streakinfo.lifeid;
  plane.streakinfo = streakinfo;
  plane.airstrikeid = airstrikeid;
  plane setotherent(owner);
  plane scriptmoveroutline();
  plane scriptmoverthermal();
  plane scriptmoverplane();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    plane[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
    _id_CD37CE775909957B = spawnStruct();
    _id_CD37CE775909957B.plane = plane;
    _id_CD37CE775909957B.targetsite = targetsite;
    owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_airstrike", _id_CD37CE775909957B);
  }

  _id_9604A2586B0A302C = "hud_icon_minimap_killstreak_airstrike";

  if(streakinfo.streakname == "fuel_airstrike")
    _id_9604A2586B0A302C = "hud_icon_minimap_killstreak_fuel_airstrike";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    plane.minimapid = plane[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](_id_9604A2586B0A302C, plane.team, undefined, 1, 1);

  _id_FAFBDA0EBA9C0AAB = _id_7B00721E9D1EF2A0 - 0.75;
  _id_3A20F9101E50025F = 0.05;
  _id_3A020E101E2DDEAD = _id_FAFBDA0EBA9C0AAB;
  _id_7C39D972E849C204 = 8.596;

  if(streakinfo.streakname == "fuel_airstrike")
    _id_FAFBDA0EBA9C0AAB = _id_7B00721E9D1EF2A0 + 1;

  _id_E4D26F59DB05025A = config._id_C80E3EA2A37A7182;

  if(!isDefined(_id_E4D26F59DB05025A))
    _id_E4D26F59DB05025A = "ks_airstrike_mp";

  plane thread airstrike_delayplayscriptable(0.05);
  level thread airstrike_playplaneattackfx(plane, _id_FAFBDA0EBA9C0AAB, streakinfo);
  level airstrike_playflyfx(plane, _id_E4D26F59DB05025A, _id_6D29E82378E59E76, anglesToForward(_id_7789CDA8C1E3128E), _id_3A20F9101E50025F, _id_3A020E101E2DDEAD, _id_7C39D972E849C204, _id_4C4796C182975686, streakinfo);
  plane.bulletpoint = spawn("script_model", plane.origin);
  plane.bulletpoint setModel("ks_airstrike_target_mp");
  plane.bulletpoint setentityowner(owner);
  plane.bulletpoint.weapon_name = "artillery_mp";
  plane.bulletpoint.streakinfo = streakinfo;
  plane.bulletpoint.angles = plane.angles;
  plane.bulletpoint dontinterpolate();
  plane.animname = streakinfo.streakname;
  plane scripts\common\anim::setanimtree();
  plane.scenenode = spawn("script_model", _id_3A69E5FC82079CE3);
  plane.scenenode.angles = plane.angles;
  plane.scenenode setModel("tag_origin");

  if(streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "multi_airstrike")
    level thread callstrike_precisionbulleteffect(plane, _id_FAFBDA0EBA9C0AAB, _id_4C4796C182975686, targetsite, owner, streakinfo);
  else if(streakinfo.streakname == "fuel_airstrike")
    level thread _id_C592AAB59A13CF01(plane, _id_FAFBDA0EBA9C0AAB, _id_4C4796C182975686, targetsite, owner);

  plane.scenenode scripts\common\anim::anim_single_solo(plane, "airstrike_flyby");

  if(isDefined(plane.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
  }

  plane notify("delete");

  if(isDefined(plane.turrettarget))
    plane.turrettarget delete();

  if(isDefined(plane.bulletpoint)) {
    plane.bulletpoint delete();

    if(isDefined(plane.bulletpoint.killcament))
      plane.bulletpoint.killcament delete();
  }

  if(isDefined(plane.scenenode))
    plane.scenenode delete();

  if(isDefined(plane))
    plane delete();
}

airstrike_playplaneattackfx(plane, _id_FAFBDA0EBA9C0AAB, streakinfo) {
  plane endon("death");
  level endon("game_ended");

  if(streakinfo.streakname == "fuel_airstrike") {
    return;
  }
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_FAFBDA0EBA9C0AAB);
  playsoundatpos(plane.origin, "ks_a10_fire_dist_crack");
  plane setscriptablepartstate("fire", "on", 0);
  plane waittill("fire_finished");
  plane setscriptablepartstate("fire", "off", 0);
}

airstrike_playflyfx(plane, _id_E4D26F59DB05025A, _id_3A69E5FC82079CE3, _id_7789CDA8C1E3128E, _id_3A20F9101E50025F, _id_3A020E101E2DDEAD, _id_7C39D972E849C204, _id_A9B4B258C1167B50, streakinfo) {
  _id_109329E170318954 = spawn("script_model", _id_3A69E5FC82079CE3);
  _id_109329E170318954 setModel(_id_E4D26F59DB05025A);
  _id_109329E170318954 dontinterpolate();
  _id_109329E170318954 thread airstrike_playapproachfx(_id_3A20F9101E50025F);
  _id_109329E170318954 thread airstrike_playflybyfx(_id_3A020E101E2DDEAD);
  _id_109329E170318954 thread airstrike_playflyoutfx(_id_7C39D972E849C204);
  _id_109329E170318954 thread airstrike_handleflyoutfxdeath(_id_A9B4B258C1167B50);
  _id_109329E170318954 thread airstrike_movewithplane(plane);
  return _id_109329E170318954;
}

airstrike_playapproachfx(_id_777FC9701BBD592B) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_777FC9701BBD592B);
  self setscriptablepartstate("approach", "on", 0);
}

airstrike_playflybyfx(_id_3A020E101E2DDEAD) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_3A020E101E2DDEAD);
  self setscriptablepartstate("flyby", "on", 0);
}

airstrike_playflyoutfx(_id_7C39D972E849C204) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_7C39D972E849C204);
  self setscriptablepartstate("flyout", "on", 0);
}

airstrike_handleflyoutfxdeath(_id_B5D8ACE604FC4B78) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_B5D8ACE604FC4B78 + 10);
  self delete();
}

airstrike_movewithplane(plane) {
  self endon("death");
  level endon("game_ended");

  while(isDefined(plane)) {
    self.origin = plane.origin;
    wait 0.05;
  }
}

airstrike_watchkills(streakinfo, _id_C12C14029CC05ACA, airstrikeid) {
  self endon("disconnect");
  self notify("airstrike_watch_kills");
  self endon("airstrike_watch_kills");
  _id_48ECD34FC60598FE = "airstrike_finished_" + airstrikeid;
  self.airstrikekillcount = 0;
  self._id_9A5AED1448C04687 = 0;
  childthread airstrike_watchkillscount(_id_48ECD34FC60598FE);
  childthread _id_9FC9871A8C03A9DE(_id_48ECD34FC60598FE);
  scripts\engine\utility::waittill_any_timeout_no_endon_death_1(_id_C12C14029CC05ACA, _id_48ECD34FC60598FE);
  _id_C7B4E8E0E05261E8 = isDefined(self.airstrikekillcount) && self.airstrikekillcount >= 1;
  _id_F27F3532AF695AF4 = isDefined(self._id_9A5AED1448C04687) && self._id_9A5AED1448C04687 >= 1;

  if(_id_C7B4E8E0E05261E8 || _id_F27F3532AF695AF4)
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_hit_target", 1);
  else
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_miss_target", 1);

  self._id_9A5AED1448C04687 = undefined;
}

airstrike_watchkillscount(_id_374D7614ECBD032A) {
  self endon(_id_374D7614ECBD032A);

  for(;;) {
    self waittill("update_rapid_kill_buffered", recentkillcount, _id_366B0ECC2F28AEAD);

    if(isDefined(_id_366B0ECC2F28AEAD) && (_id_366B0ECC2F28AEAD == "artillery_mp" || _id_366B0ECC2F28AEAD == "fuelstrike_proj_mp"))
      self.airstrikekillcount++;
  }
}

_id_9FC9871A8C03A9DE(_id_374D7614ECBD032A) {
  self endon(_id_374D7614ECBD032A);

  for(;;) {
    self waittill("update_rapid_agent_kill_buffered", recentkillcount, _id_366B0ECC2F28AEAD);

    if(isDefined(_id_366B0ECC2F28AEAD) && (_id_366B0ECC2F28AEAD == "artillery_mp" || _id_366B0ECC2F28AEAD == "fuelstrike_proj_mp"))
      self.airstrikekillcount++;
  }
}

testsoundplacement(_id_109329E170318954) {
  _id_109329E170318954 endon("death");

  for(;;)
    wait 0.05;
}

callstrike_precisionbulleteffect(plane, launchtime, _id_1F57BFCFB8AE4433, damagepos, owner, streakinfo) {
  plane endon("death");
  _id_7A05F5CEED8AB610 = plane.flightdir;
  _id_205F7A849FBB6B3D = damagepos + (0, 0, plane.flightheight + 750);
  _id_7440286A44028FBA = _id_205F7A849FBB6B3D - _id_7A05F5CEED8AB610 * 15000;
  _id_29893615DE503CF5 = _id_205F7A849FBB6B3D - _id_7A05F5CEED8AB610 * 500;
  _id_315162F2D4F72593 = _id_205F7A849FBB6B3D;
  _id_FE74BC2CC14DFD90 = 0;
  _id_B829B1C5B718ADF9 = randomintrange(3, 9);
  _id_9CB35D6FDE2C8BEA = randomintrange(_id_B829B1C5B718ADF9 + 1, 16);
  strafe = [_id_FE74BC2CC14DFD90, _id_B829B1C5B718ADF9, _id_9CB35D6FDE2C8BEA];
  _id_19FAB534E407A4D2 = 0;
  killcament = spawn("script_model", _id_7440286A44028FBA);
  killcament thread airstrike_killcammove(launchtime - 3, _id_29893615DE503CF5, _id_315162F2D4F72593);
  plane.bulletpoint.killcament = killcament;
  _id_C6CDA7219900396F = [damagepos - _id_7A05F5CEED8AB610 * 512, damagepos - _id_7A05F5CEED8AB610 * 256, damagepos, damagepos + _id_7A05F5CEED8AB610 * 256, damagepos + _id_7A05F5CEED8AB610 * 512];

  if(level._id_480D0E884A4F8E2A) {
    foreach(targetpos in _id_C6CDA7219900396F)
    scripts\cp_mp\utility\killstreak_utility::_id_F772994FA2FB7FFC(owner, owner.team, level._id_9FC34B4B891723F8, streakinfo.streakname, targetpos);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(launchtime);

  if(!isDefined(owner)) {
    return;
  }
  repeat = 5;
  _id_2E3BC21C15E7AB6C = (0, 0, 0);
  _id_65F0F595C2A4DD40 = _id_2E3BC21C15E7AB6C;
  _id_5A0E75A355CBDADF = 0;
  _id_07A48A62D24267EB = 0;

  foreach(targetpos in _id_C6CDA7219900396F) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](targetpos, 512, 512, owner.team, 5, owner, 1);
  }

  _id_7CCE0455543AEC8E = damagepos[2] + plane.flightheight * 3;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < repeat; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(owner)) {
      break;
    }

    _id_D040415A59F1322A = -50;
    _id_D0634B5A5A178FE0 = 150;

    while(_id_5A0E75A355CBDADF < _id_07A48A62D24267EB + 4) {
      _id_22468A5A678250BB = callstrike_getrandomshotoffset(_id_D040415A59F1322A, _id_D0634B5A5A178FE0, _id_C6CDA7219900396F[_id_AC0E594AC96AA3A8], plane.angles);
      _id_AC2B0D64FD58EFD4 = plane gettagorigin("tag_turret_fx") * (1, 1, 0) + (0, 0, _id_7CCE0455543AEC8E) + _id_7A05F5CEED8AB610 * 1000;
      _id_6A2843F01A3C04B1 = vectorNormalize(_id_22468A5A678250BB - _id_AC2B0D64FD58EFD4);
      _id_AB6A541AA9A6450D = _id_22468A5A678250BB + _id_6A2843F01A3C04B1 * 30000;
      _id_9DAE63DFFC7FD8F9 = scripts\engine\trace::ray_trace(_id_AC2B0D64FD58EFD4, _id_AB6A541AA9A6450D, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      _id_6D5DCB89F6BAA8FE = _id_9DAE63DFFC7FD8F9["position"];
      _id_06F511097D430526 = _id_9DAE63DFFC7FD8F9["normal"];
      _id_E734E756BB8F91C9 = _id_6D5DCB89F6BAA8FE + _id_06F511097D430526 * 10;
      _id_09B9958E5C64D5B3 = vectorNormalize(_id_6D5DCB89F6BAA8FE - plane gettagorigin("tag_turret_fx"));
      _id_88F727764ADFE9A4 = vectorcross(_id_09B9958E5C64D5B3, (0, 0, 1));
      _id_6721411B32EC4A63 = vectorcross(_id_88F727764ADFE9A4, _id_09B9958E5C64D5B3);
      plane thread callstrike_playmultitracerfx(scripts\engine\utility::getfx("airstrike_tracer"), _id_E734E756BB8F91C9, _id_09B9958E5C64D5B3, _id_6721411B32EC4A63);

      if(getdvarint("redeploy_ascenders_enabled", 0)) {
        if(isDefined(_id_9DAE63DFFC7FD8F9["hittype"]) && _id_9DAE63DFFC7FD8F9["hittype"] == "hittype_world" && _id_9DAE63DFFC7FD8F9["position"][2] > 3000) {
          _id_320408384DD779EA = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("redeploy_drone", "get_closest_redeploy_drone"))
            _id_320408384DD779EA = [[scripts\cp_mp\utility\script_utility::getsharedfunc("redeploy_drone", "get_closest_redeploy_drone")]](_id_9DAE63DFFC7FD8F9["position"]);

          if(isDefined(_id_320408384DD779EA) && distancesquared(_id_9DAE63DFFC7FD8F9["position"], _id_320408384DD779EA.origin) < squared(150)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("redeploy_drone", "precision_airstrike_death"))
              _id_320408384DD779EA thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("redeploy_drone", "precision_airstrike_death")]](owner);
          }
        }

        if(isDefined(_id_9DAE63DFFC7FD8F9["hittype"]) && _id_9DAE63DFFC7FD8F9["hittype"] == "hittype_entity" && isDefined(_id_9DAE63DFFC7FD8F9["entity"]) && isDefined(_id_9DAE63DFFC7FD8F9["entity"].model) && (_id_9DAE63DFFC7FD8F9["entity"].model == "veh9_mil_air_drone_redeploy_relocate" || _id_9DAE63DFFC7FD8F9["entity"].model == "veh9_mil_air_drone_redeploy_relocate_hack")) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("redeploy_drone", "precision_airstrike_death"))
            _id_9DAE63DFFC7FD8F9["entity"] thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("redeploy_drone", "precision_airstrike_death")]](owner);
        }
      }

      plane.bulletpoint thread moveanddamagepoint(_id_5A0E75A355CBDADF + 1, _id_E734E756BB8F91C9);

      if(_id_19FAB534E407A4D2 < strafe.size && _id_5A0E75A355CBDADF == strafe[_id_19FAB534E407A4D2]) {
        plane.bulletpoint thread _id_406248674A952273(_id_19FAB534E407A4D2 + 1, _id_E734E756BB8F91C9);
        _id_19FAB534E407A4D2++;
      }

      _id_65F0F595C2A4DD40 = _id_6D5DCB89F6BAA8FE;
      _id_5A0E75A355CBDADF++;
      plane.bulletpoint.streakinfo.shots_fired++;
      _id_D040415A59F1322A = _id_D040415A59F1322A + 20;
      _id_D0634B5A5A178FE0 = _id_D0634B5A5A178FE0 + 40;
      _id_7CCE0455543AEC8E = _id_7CCE0455543AEC8E - 200;

      if(_id_7CCE0455543AEC8E < plane.flightheight)
        _id_7CCE0455543AEC8E = plane.flightheight;

      wait 0.05;
    }

    _id_07A48A62D24267EB = _id_5A0E75A355CBDADF;
  }

  plane notify("fire_finished");
}

callstrike_getrandomshotoffset(_id_6C88C3B05E813428, _id_84D0C5C148DA4A7A, originalpos, _id_6F680EE249F67B0D) {
  _id_6F680EE249F67B0D = _id_6F680EE249F67B0D * (0, 1, 0);
  _id_4B52F031A2CBEF8E = anglesToForward(_id_6F680EE249F67B0D);
  _id_D8BB89F41AE3D919 = anglestoright(_id_6F680EE249F67B0D);
  _id_A0A41BA05E16FFE6 = randomintrange(_id_6C88C3B05E813428, _id_84D0C5C148DA4A7A);
  _id_9E5D403038E4C071 = randomint(80) - 40;
  _id_5B91512983A7DBAE = _id_4B52F031A2CBEF8E * cos(_id_9E5D403038E4C071) * _id_A0A41BA05E16FFE6;
  return originalpos + _id_5B91512983A7DBAE + _id_D8BB89F41AE3D919 * sin(_id_9E5D403038E4C071) * _id_A0A41BA05E16FFE6;
}

callstrike_playmultitracerfx(_id_0B9D4C98AAF1F4AE, _id_B68850986D4C6C13, _id_09B9958E5C64D5B3, _id_6721411B32EC4A63) {
  self endon("death");
  _id_4648B75503218E34 = 0;
  _id_684FC496FBBEE4D5 = 3;

  while(_id_4648B75503218E34 < _id_684FC496FBBEE4D5) {
    _id_6A77F98DC80D2333 = randomintrange(25, 50);
    _id_6A77F88DC80D2100 = randomintrange(25, 50);
    playFX(_id_0B9D4C98AAF1F4AE, _id_B68850986D4C6C13 + (_id_6A77F98DC80D2333, _id_6A77F88DC80D2100, 0), _id_09B9958E5C64D5B3, _id_6721411B32EC4A63);
    _id_4648B75503218E34++;
    wait 0.05;
  }
}

moveanddamagepoint(index, _id_2E3BC21C15E7AB6C) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = _id_2E3BC21C15E7AB6C;
  self setscriptablepartstate("explode" + index, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + index, "neutral", 0);
}

_id_406248674A952273(index, _id_2E3BC21C15E7AB6C) {
  self endon("death");
  self.origin = _id_2E3BC21C15E7AB6C;
  self setscriptablepartstate("strafe" + index, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("strafe" + index, "off", 0);
}

_id_C592AAB59A13CF01(plane, launchtime, _id_1F57BFCFB8AE4433, damagepos, owner) {
  plane endon("death");
  _id_7A05F5CEED8AB610 = plane.flightdir;
  _id_205F7A849FBB6B3D = damagepos + (0, 0, plane.flightheight + 750);
  _id_7440286A44028FBA = _id_205F7A849FBB6B3D - _id_7A05F5CEED8AB610 * 15000;
  _id_29893615DE503CF5 = _id_205F7A849FBB6B3D - _id_7A05F5CEED8AB610 * 1000;
  _id_315162F2D4F72593 = _id_205F7A849FBB6B3D - _id_7A05F5CEED8AB610 * 500;
  killcament = spawn("script_model", _id_7440286A44028FBA);
  killcament thread airstrike_killcammove(launchtime - 3, _id_29893615DE503CF5, _id_315162F2D4F72593);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(launchtime);

  if(!isDefined(owner)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](damagepos, 650, 650, owner.team, _id_1F57BFCFB8AE4433, owner, 1);

  _id_785F5B52F245A2B6 = damagepos + (0, 0, 2500);
  _id_BD794EEF2B14C4B3 = damagepos - (0, 0, 10000);
  _id_3B8C153F4D5D7F16 = scripts\engine\trace::ray_trace(_id_785F5B52F245A2B6, _id_BD794EEF2B14C4B3, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  _id_604B31EFA39E3F47 = _id_3B8C153F4D5D7F16["position"];
  _id_2C0B75362BF153C5 = _id_3B8C153F4D5D7F16["normal"];
  _id_4E79F74D11612F28 = _id_604B31EFA39E3F47 + _id_2C0B75362BF153C5 * 10;
  _id_C6188DA3AD302049 = _id_4E79F74D11612F28 + (0, 0, 800);
  _id_6033A7638FE1342F = spawn("script_model", _id_C6188DA3AD302049);
  _id_6033A7638FE1342F.angles = plane.angles;
  _id_6033A7638FE1342F.streakinfo = plane.streakinfo;
  _id_6033A7638FE1342F setModel("ks_fuelstrike_mp");
  _id_6033A7638FE1342F setentityowner(owner);
  _id_6033A7638FE1342F.killcament = killcament;
  _id_F9F79F4923D00E6E = spawn("script_model", _id_4E79F74D11612F28);
  _id_F9F79F4923D00E6E.angles = plane.angles;
  _id_F9F79F4923D00E6E.streakinfo = plane.streakinfo;
  _id_F9F79F4923D00E6E setModel("ks_fuelstrike_mp");
  _id_F9F79F4923D00E6E setentityowner(owner);
  _id_F9F79F4923D00E6E.killcament = killcament;
  _id_F9F79F4923D00E6E setscriptablepartstate("releaseVFX", "on", 0);
  _id_6033A7638FE1342F setscriptablepartstate("releaseSFX", "on", 0);
  wait 1.3;
  _id_F9F79F4923D00E6E setscriptablepartstate("explode", "on", 0);
  _id_B9D5783A4F34EFBC = [_id_6033A7638FE1342F, _id_F9F79F4923D00E6E];
  _id_33F031D062A32623 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 1, 0);
  _id_3BD841437DFAA8D7 = _id_15D7E8B275B8B57B(_id_4E79F74D11612F28, 750, owner, _id_C6188DA3AD302049, _id_B9D5783A4F34EFBC, _id_33F031D062A32623);
  _id_60EFAA64227A4B55 = _id_2A75473DDD0FB33F(_id_4E79F74D11612F28, 750, owner, _id_C6188DA3AD302049, _id_B9D5783A4F34EFBC, _id_33F031D062A32623);
  _id_A7340CCD3AD168F9 = makeweapon("fuelstrike_proj_mp");
  _id_F7F7BAC8E05E89D1 = 0.8;
  plane thread _id_E5A6AAAA22532637(_id_6033A7638FE1342F, _id_F9F79F4923D00E6E, _id_F7F7BAC8E05E89D1);

  foreach(enemy in _id_3BD841437DFAA8D7) {
    enemy thread _id_3C8DFE97AC9AD7C7(owner, _id_F7F7BAC8E05E89D1, _id_6033A7638FE1342F, _id_F9F79F4923D00E6E, _id_A7340CCD3AD168F9);
    enemy thread _id_94E9B969D9359F43(500, _id_F9F79F4923D00E6E.origin, owner, _id_F9F79F4923D00E6E, "MOD_EXPLOSIVE", _id_A7340CCD3AD168F9, _id_F7F7BAC8E05E89D1);
  }

  foreach(vehicle in _id_60EFAA64227A4B55)
  vehicle thread _id_94E9B969D9359F43(1000, _id_F9F79F4923D00E6E.origin, owner, _id_F9F79F4923D00E6E, "MOD_EXPLOSIVE", _id_A7340CCD3AD168F9, _id_F7F7BAC8E05E89D1);

  level thread delaydeletefxents(_id_6033A7638FE1342F, _id_F9F79F4923D00E6E);
}

delaydeletefxents(_id_19E3C5251A5F46FA, _id_837D24B1C8E8EF79) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  _id_19E3C5251A5F46FA setscriptablepartstate("releaseSFX", "off", 0);
  _id_837D24B1C8E8EF79 setscriptablepartstate("releaseVFX", "off", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(_id_19E3C5251A5F46FA))
    _id_19E3C5251A5F46FA delete();

  if(isDefined(_id_837D24B1C8E8EF79)) {
    if(isDefined(_id_837D24B1C8E8EF79.killcament))
      _id_837D24B1C8E8EF79.killcament delete();

    _id_837D24B1C8E8EF79 delete();
  }
}

getflightpath(_id_6E7C70B904418DAA, direction, _id_5ED27D0675C3B6EB, _id_5FA1E1697A302583, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_361663D437DB22F5, streakname, _id_505331AD630BBC6B) {
  _id_4B3BE3F25771456A = undefined;

  if(istrue(_id_505331AD630BBC6B))
    _id_4B3BE3F25771456A = direction;
  else
    _id_4B3BE3F25771456A = anglesToForward(direction);

  startpoint = _id_6E7C70B904418DAA + _id_4B3BE3F25771456A * (-1 * _id_5ED27D0675C3B6EB);

  if(isDefined(_id_5FA1E1697A302583))
    startpoint = startpoint * (1, 1, 0);

  startpoint = startpoint + (0, 0, _id_76AB620FD7CC70BD);
  endpoint = _id_6E7C70B904418DAA + _id_4B3BE3F25771456A * _id_5ED27D0675C3B6EB;

  if(isDefined(_id_5FA1E1697A302583))
    endpoint = endpoint * (1, 1, 0);

  endpoint = endpoint + (0, 0, _id_76AB620FD7CC70BD);
  _id_AC0E564AC96A9D0F = length(startpoint - endpoint);
  flytime = _id_AC0E564AC96A9D0F / _id_23122E7B902F2EA9;
  _id_AC0E564AC96A9D0F = abs(_id_AC0E564AC96A9D0F / 2 + _id_361663D437DB22F5);
  _id_DDBD1863315930DC = _id_AC0E564AC96A9D0F / _id_23122E7B902F2EA9;
  flightpath["startPoint"] = startpoint;
  flightpath["endPoint"] = endpoint;
  flightpath["bombTime"] = _id_DDBD1863315930DC;
  flightpath["flyTime"] = flytime;
  flightpath["directionAngles"] = _id_4B3BE3F25771456A;
  return flightpath;
}

getexplodedistance(height) {
  _id_E5DC9ECDAD877027 = 850;
  _id_17BCA7AB954CC95F = 1500;
  _id_3369989E4AAB456A = _id_E5DC9ECDAD877027 / height;
  _id_1003B817E555135A = _id_3369989E4AAB456A * _id_17BCA7AB954CC95F;
  return _id_1003B817E555135A;
}

airstrike_getownerlookatpos(owner, _id_BD5B999689421CC7) {
  _id_C56207BDA09B3A36 = ["physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  _id_22C4300CE1D248E8 = owner getvieworigin();
  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner scripts\cp_mp\utility\killstreak_utility::playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignoreents, contentoverride);
  endpos = trace["position"];

  if(trace["hittype"] == "hittype_none")
    endpos = undefined;

  return endpos;
}

airstrike_watchforads(streakinfo, _id_A6B4DBDD89BBBB24) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  _id_0E7CA95FE87CCFD0 = spawn("script_model", self.origin);
  _id_0E7CA95FE87CCFD0 setModel("ks_airstrike_marker_mp");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID"))
    _id_0E7CA95FE87CCFD0.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);

  _id_0E7CA95FE87CCFD0 setotherent(self);
  _id_0E7CA95FE87CCFD0 dontinterpolate();
  _id_0E7CA95FE87CCFD0 hide();
  _id_A465314411EA4812 = "icon_waypoint_airstrike";

  if(isDefined(_id_A6B4DBDD89BBBB24))
    _id_A465314411EA4812 = _id_A6B4DBDD89BBBB24;

  _id_0E7CA95FE87CCFD0 airstrike_setmarkerobjective(_id_0E7CA95FE87CCFD0.objidnum, _id_A465314411EA4812, self, 50);
  _id_0E7CA95FE87CCFD0 thread airstrike_watchownerdisown(self);
  _id_0E7CA95FE87CCFD0 thread airstrike_watchdeployended(self);
  _id_0E7CA95FE87CCFD0 thread airstrike_watchdeployweaponchange(self);
  _id_0E7CA95FE87CCFD0.updatemarker = 0;
  _id_3B64EB40368C1450::set("ads_watcher", "fire", 0);

  for(;;) {
    if(scripts\cp_mp\emp_debuff::is_empd() && istrue(_id_0E7CA95FE87CCFD0.updatemarker)) {
      _id_3B64EB40368C1450::set("ads_watcher", "fire", 0);
      _id_0E7CA95FE87CCFD0 hide();
      _id_0E7CA95FE87CCFD0 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      _id_0E7CA95FE87CCFD0.updatemarker = 0;
    }

    playerads = self playerads();

    if(playerads == 1 && !istrue(_id_0E7CA95FE87CCFD0.updatemarker)) {
      if(!scripts\cp_mp\emp_debuff::is_empd()) {
        _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ads_watcher");
        _id_0E7CA95FE87CCFD0 show();
        _id_0E7CA95FE87CCFD0 setscriptablepartstate("marker_scope", "on", 0);
        _id_0E7CA95FE87CCFD0 thread airstrike_updatemarkerpos(self);
        _id_0E7CA95FE87CCFD0.updatemarker = 1;
      }
    } else if(playerads < 1 && istrue(_id_0E7CA95FE87CCFD0.updatemarker)) {
      _id_3B64EB40368C1450::set("ads_watcher", "fire", 0);
      _id_0E7CA95FE87CCFD0 hide();
      _id_0E7CA95FE87CCFD0 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      _id_0E7CA95FE87CCFD0.updatemarker = 0;
    }

    waitframe();
  }
}

airstrike_setmarkerobjective(objid, icon, owner, offset) {
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

  objective_state(objid, "done");
}

airstrike_updatemarkerpos(owner) {
  self endon("death");
  owner endon("deploy_cancelled");
  owner endon("deploy_fired");
  owner endon("stop_update_marker");
  owner endon("death_or_disconnect");
  _id_AED614516C33F816 = 0;
  owner setclientomnvar("ui_spotter_scope_danger", 0);

  for(;;) {
    _id_206991A4F6971FD8 = airstrike_getownerlookatpos(owner);
    _id_81954D580B24281B = -1;
    _id_E4F34F3A01C6FFF2 = -1;
    _id_689A1188271A0BE5 = -1;

    if(isDefined(_id_206991A4F6971FD8)) {
      self.origin = _id_206991A4F6971FD8;
      _id_81954D580B24281B = int(self.origin[0]);
      _id_E4F34F3A01C6FFF2 = int(self.origin[1]);
      _id_689A1188271A0BE5 = int(self.origin[2]);
    }

    owner setclientomnvar("ui_gunship_coord3_posx", _id_81954D580B24281B);
    owner setclientomnvar("ui_gunship_coord3_posy", _id_E4F34F3A01C6FFF2);
    owner setclientomnvar("ui_gunship_coord3_posz", _id_689A1188271A0BE5);

    if(isDefined(_id_206991A4F6971FD8)) {
      if(!istrue(_id_AED614516C33F816) && distance2dsquared(owner.origin, _id_206991A4F6971FD8) <= 1638400) {
        owner setclientomnvar("ui_spotter_scope_danger", 1);
        _id_AED614516C33F816 = 1;
      } else if(istrue(_id_AED614516C33F816) && distance2dsquared(owner.origin, _id_206991A4F6971FD8) > 1638400) {
        owner setclientomnvar("ui_spotter_scope_danger", 0);
        _id_AED614516C33F816 = 0;
      }
    }

    waitframe();
  }
}

airstrike_watchownerdisown(owner) {
  self endon("death");
  level endon("game_ended");
  owner waittill("death_or_disconnect");
  airstrike_removemarker();
}

airstrike_watchdeployended(owner) {
  owner endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  _id_9B1DEB5E9D32BBE3 = owner scripts\engine\utility::waittill_any_return_2("cancel_fire", "successful_fire");

  if(isDefined(_id_9B1DEB5E9D32BBE3) && _id_9B1DEB5E9D32BBE3 == "successful_fire") {
    owner notify("deploy_fired");
    self setscriptablepartstate("marker_scope", "off", 0);
    _id_95DA95F2E9954514 = anglesToForward(owner getplayerangles());
    _id_22C4300CE1D248E8 = self.origin - _id_95DA95F2E9954514 * 500;
    _id_98C6610C2907BA2B = self.origin + _id_95DA95F2E9954514 * 20;
    trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, self);
    _id_5E8EDE0EF6D7F3AB = trace["normal"];
    self.angles = generateaxisanglesfromupvector(_id_5E8EDE0EF6D7F3AB, self.angles);
    self setscriptablepartstate("marker_placed", "on", 0);
    objective_state(self.objidnum, "current");
    thread airstrike_removemarker(7);
  } else {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      owner setclientomnvar("ui_using_airstrike", 0);

    owner notify("deploy_cancelled");

    if(!owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]())
      owner _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ads_watcher");

    airstrike_removemarker();
  }
}

airstrike_watchdeployweaponchange(owner) {
  owner endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  _id_8ACEF5C729BD9628 = owner getcurrentweapon();

  for(;;) {
    if(owner getcurrentweapon() != _id_8ACEF5C729BD9628) {
      break;
    }

    waitframe();
  }

  owner notify("cancel_fire");
}

airstrike_removemarker(_id_74B5B12BB6514385) {
  if(isDefined(_id_74B5B12BB6514385)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  }

  if(isDefined(self.objidnum)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
  }

  self delete();
}

airstrike_delayplayscriptable(_id_74B5B12BB6514385) {
  self endon("death");
  level endon("game_ended");
  wait(_id_74B5B12BB6514385);
  self setscriptablepartstate("bodyfx", "on", 0);
}

airstrike_killcammove(_id_74B5B12BB6514385, _id_29893615DE503CF5, _id_315162F2D4F72593) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self moveTo(_id_29893615DE503CF5, 4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.95);
  self moveTo(_id_315162F2D4F72593, 5);
}

airstrike_watchgameend(streakinfo, airstrikeid) {
  self endon("airstrike_finished_" + airstrikeid);
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

airstrike_addactivestrike(origin, owner, _id_80B642A0F8C9659D) {
  level.airstrikecount++;
  _id_E2F8F2AE67B84927 = spawnStruct();
  _id_E2F8F2AE67B84927.origin = origin;
  _id_E2F8F2AE67B84927.owner = owner;

  if(isPlayer(owner))
    id = owner getxuid();
  else
    id = abs(owner.origin[0]);

  _id_E2F8F2AE67B84927.id = id + "_" + level.airstrikecount;
  _id_E2F8F2AE67B84927._id_7BF1255A3715A632 = gettime();
  _id_E2F8F2AE67B84927._id_05AB9EA557C8B0A4 = _id_80B642A0F8C9659D * 1000;
  level.activeairstrikes[_id_E2F8F2AE67B84927.id] = _id_E2F8F2AE67B84927;
  return _id_E2F8F2AE67B84927.id;
}

airstrike_removeactivestrike(owner, _id_4D39391D6EF2BB65) {
  level.activeairstrikes = scripts\engine\utility::array_remove_index(level.activeairstrikes, _id_4D39391D6EF2BB65, 1);

  if(isDefined(owner))
    owner notify("airstrike_finished_" + _id_4D39391D6EF2BB65);
}

_id_7893C28CFBF65865(owner, airstrikeid, _id_74B5B12BB6514385) {
  level endon("game_ended");
  wait(_id_74B5B12BB6514385);
  airstrike_removeactivestrike(owner, airstrikeid);
}

_id_035C596EE06DC6DA() {
  _id_4F0FC1C36324AFFB = 625000000;
  return _id_4F0FC1C36324AFFB;
}

airstrike_canbeused(_id_ABD90CC9F0E9501C) {
  _id_79710492B71B9E81 = "success";
  _id_4F0FC1C36324AFFB = _id_035C596EE06DC6DA();

  if(isDefined(_id_ABD90CC9F0E9501C)) {
    if(level.activeairstrikes.size > 0) {
      _id_28F0D2AD91EE22DC = 1;
      _id_D937D9FBFEED2E24 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

      if(_id_D937D9FBFEED2E24)
        _id_28F0D2AD91EE22DC = 3;

      if(level.activeairstrikes.size >= _id_28F0D2AD91EE22DC) {
        if(istrue(level._id_B8200908FD2377D3))
          _id_79710492B71B9E81 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME";
        else
          _id_79710492B71B9E81 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED";
      } else {
        foreach(_id_D97D35B4ADFA29F9 in level.activeairstrikes) {
          if(distance2dsquared(_id_D97D35B4ADFA29F9.origin, _id_ABD90CC9F0E9501C) <= _id_4F0FC1C36324AFFB) {
            if(istrue(level._id_B8200908FD2377D3)) {
              _id_79710492B71B9E81 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME";
              continue;
            }

            _id_79710492B71B9E81 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA";
          }
        }
      }
    }
  } else
    _id_79710492B71B9E81 = "KILLSTREAKS/INVALID_POINT";

  return _id_79710492B71B9E81;
}

callprecisionairstrikeonlocation(location) {
  player = self;
  streakinfo = spawnStruct();
  streakinfo.streakname = "precision_airstrike";
  streakinfo.owner = player;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  yaw = undefined;
  _id_97195D51C4C2B14E = undefined;
  animname = % mp_alfa10_flyin;
  airstrikeid = undefined;
  level thread callstrike(player, location, yaw, _id_97195D51C4C2B14E, streakinfo, animname, airstrikeid);
}

_id_15D7E8B275B8B57B(_id_2E3BC21C15E7AB6C, _id_380FCFDAE182FA24, _id_78836748D345CD08, tracestart, _id_B9D5783A4F34EFBC, _id_33F031D062A32623) {
  _id_F1C102CD6FD079FB = scripts\common\utility::_id_2D7FD59D039FA69B(_id_2E3BC21C15E7AB6C, _id_380FCFDAE182FA24);
  _id_37D7886608227391 = [];

  foreach(target in _id_F1C102CD6FD079FB) {
    if(!isDefined(target)) {
      continue;
    }
    targetteam = undefined;

    if(isPlayer(target)) {
      if(!target scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      targetteam = target.pers["team"];

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam"))
          targetteam = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](target);
      }
    } else if(isagent(target)) {
      if(!isalive(target)) {
        continue;
      }
      if(isDefined(target.agent_type) && issubstr(target.agent_type, "civilian")) {
        continue;
      }
      targetteam = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(target, "team");
    }

    if(isDefined(_id_78836748D345CD08)) {
      if(level.teambased) {
        if(isDefined(_id_78836748D345CD08.team) && isDefined(targetteam) && targetteam == _id_78836748D345CD08.team && target != _id_78836748D345CD08)
          continue;
      }
    }

    canseetarget = scripts\engine\trace::ray_trace_passed(tracestart, target gettagorigin("j_head"), _id_B9D5783A4F34EFBC, _id_33F031D062A32623);

    if(istrue(canseetarget))
      _id_37D7886608227391[_id_37D7886608227391.size] = target;
  }

  return _id_37D7886608227391;
}

_id_2A75473DDD0FB33F(_id_2E3BC21C15E7AB6C, _id_380FCFDAE182FA24, _id_78836748D345CD08, tracestart, _id_B9D5783A4F34EFBC, _id_33F031D062A32623) {
  _id_F1C102CD6FD079FB = vehicle_getarrayinradius(_id_2E3BC21C15E7AB6C, _id_380FCFDAE182FA24, _id_380FCFDAE182FA24);
  _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_B9D5783A4F34EFBC, _id_F1C102CD6FD079FB);
  _id_25F1F048B9011AD4 = [];

  foreach(target in _id_F1C102CD6FD079FB) {
    if(!isDefined(target)) {
      continue;
    }
    if(level.teambased && isDefined(target.team) && target.team == _id_78836748D345CD08.team) {
      continue;
    }
    canseetarget = scripts\engine\trace::ray_trace_passed(tracestart, target.origin, _id_B9D5783A4F34EFBC, _id_33F031D062A32623);

    if(istrue(canseetarget))
      _id_25F1F048B9011AD4[_id_25F1F048B9011AD4.size] = target;
  }

  return _id_25F1F048B9011AD4;
}

_id_E5A6AAAA22532637(_id_6033A7638FE1342F, _id_F9F79F4923D00E6E, _id_F7F7BAC8E05E89D1) {
  self endon("death");
  _id_56F0277B0ED98101 = 0.5;
  _id_FF85637831346339 = 0.3;
  _id_FF624F78310DEF85 = 0.15;
  _id_FF625578310DFCB7 = 0.08;
  _id_31BFD6CEFEC15DC7 = 350;
  _id_31E2EACEFEE7D17B = 900;
  _id_31E2E4CEFEE7C449 = 3500;
  wait(_id_F7F7BAC8E05E89D1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](_id_F9F79F4923D00E6E.origin, _id_56F0277B0ED98101, _id_FF85637831346339, _id_FF624F78310DEF85, _id_FF625578310DFCB7, _id_31BFD6CEFEC15DC7, _id_31E2EACEFEE7D17B, _id_31E2E4CEFEE7C449);
}

_id_3C8DFE97AC9AD7C7(owner, _id_F7F7BAC8E05E89D1, _id_6033A7638FE1342F, _id_F9F79F4923D00E6E, _id_A7340CCD3AD168F9) {
  self endon("disconnect");
  scripts\cp_mp\utility\shellshock_utility::_shellshock("bomb_stun_mp", "stun", 5, 0);
  thread _id_94E9B969D9359F43(1, _id_6033A7638FE1342F.origin, owner, _id_6033A7638FE1342F, "MOD_EXPLOSIVE", _id_A7340CCD3AD168F9);

  if(isbot(self) || isagent(self)) {
    return;
  }
  self setscriptablepartstate("airBombVfx", "embers", 0);
  wait(_id_F7F7BAC8E05E89D1 - 0.1);
  self setscriptablepartstate("airBombVfx", "explode", 0);
  thread _id_57107489D8BA1A87("airBombVfx");
}

_id_94E9B969D9359F43(_id_C4C191BEFB977DB0, damageorigin, attacker, inflictor, meansofdeath, weapon, _id_F7F7BAC8E05E89D1) {
  self endon("death_or_disconnect");

  if(isDefined(_id_F7F7BAC8E05E89D1) && _id_F7F7BAC8E05E89D1 > 0)
    wait(_id_F7F7BAC8E05E89D1);

  self dodamage(_id_C4C191BEFB977DB0, damageorigin, attacker, inflictor, meansofdeath, weapon);
}

_id_57107489D8BA1A87(partname) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_timeout_1(3, "spawned_player");
  self setscriptablepartstate(partname, "off", 0);
}