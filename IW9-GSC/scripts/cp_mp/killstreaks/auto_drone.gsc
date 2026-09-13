/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\auto_drone.gsc
****************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("auto_drone", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("auto_drone", "init")]]();

  level _id_2E0E05B9E6DFBA79();
  level _id_1C0EE59726585F9F();
  level _id_54DC2EFC97E278C6();
  level _id_5CDA69C520D4B9C3();
  level _id_5D215EC521236402();
}

_id_0235F27CAFF15C65(streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "startMapSelectSequence"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "startMapSelectSequence")]](0, 1, "long_arrow", undefined, streakinfo);

  return 1;
}

_id_2E0E05B9E6DFBA79() {
  level._id_5F028B2553FB392D = [];
  level._id_D8C0162B0F87CB2C = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level._id_5F2F53346BF55271[_id_FABF84450735DD93] = 0;
}

_id_1C0EE59726585F9F() {}

_id_54DC2EFC97E278C6() {}

_id_5CDA69C520D4B9C3() {
  game["dialog"]["auto_drone_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["auto_drone_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["auto_drone_miss_target"] = "killstreak_remote_operator_miss_target";
}

_id_5D215EC521236402() {}

_id_F5488EBDAE28A1D8() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("auto_drone", self);
  return _id_987A0AB2646445E1(streakinfo);
}

_id_987A0AB2646445E1(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  team = self.team;
  level._id_D8C0162B0F87CB2C++;
  _id_1396F6A995578BE4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    _id_1396F6A995578BE4 = 2;

  if(level._id_5F028B2553FB392D.size >= _id_1396F6A995578BE4 || level._id_5F028B2553FB392D.size + level._id_D8C0162B0F87CB2C > _id_1396F6A995578BE4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

    level._id_D8C0162B0F87CB2C--;
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    _id_BB1CD2DA42608A26 = 1;
    level._id_5F2F53346BF55271[team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(team, level._id_5F028B2553FB392D) + level._id_5F2F53346BF55271[team] > _id_BB1CD2DA42608A26) {
      level._id_D8C0162B0F87CB2C--;
      level._id_5F2F53346BF55271[team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      return 0;
    }
  }

  result = _id_A39B5CB878CC28CD(streakinfo);
  level._id_D8C0162B0F87CB2C--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level._id_5F2F53346BF55271[team]--;

  return result;
}

_id_A39B5CB878CC28CD(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("ks_remote_map_mp"), 1, ::_id_0235F27CAFF15C65);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  mappointinfo = undefined;
  self playlocalsound("iw9_ks_tablet_ui_screen_plr");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint")) {
    mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 1, 1);
    self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  }

  if(!isDefined(mappointinfo))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  level thread _id_589F29FDE91A654A(self, streakinfo, mappointinfo);
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("auto_drone", "auto_drone_use", 1, _id_52A5BE2E2F91D710);
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "auto_drone", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_auto_drone", self, self.team);

  return 1;
}

_id_589F29FDE91A654A(player, streakinfo, mappointinfo) {
  level endon("game_ended");
  player notify("auto_drone_used");
  _id_AE87376418450660 = mappointinfo;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AE87376418450660.size; _id_AC0E594AC96AA3A8++) {
    _id_A24A061A7076376C = _id_6FE4E482E9C736B9(player, streakinfo, _id_AE87376418450660[_id_AC0E594AC96AA3A8], 1);
    _id_A24A061A7076376C thread _id_7056DA117386CF8B();
    _id_A24A061A7076376C thread _id_DABE5E1812AC0003();
    _id_A24A061A7076376C thread _id_5072D07167C0AE44();
    _id_A24A061A7076376C thread _id_E01FF9FBB932EE1A();
    _id_A24A061A7076376C thread _id_71FC6FC4F15927A8();
    _id_A24A061A7076376C thread _id_7CD9F49E2A56EA1E();
  }
}

_id_6FE4E482E9C736B9(owner, streakinfo, _id_E53AB3056AF949C7, nonvehicle) {
  level endon("game_ended");
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  _id_40D0FC358B957A0F = 36000;
  _id_46B3D7CBD1251291 = 3000;
  _id_3AE18FE8CC908B35 = 200;
  _id_9C39DCE599026A69 = 1500;
  _id_505331AD630BBC6B = 0;

  if(isDefined(_id_5FA1E1697A302583))
    _id_46B3D7CBD1251291 = _id_5FA1E1697A302583.origin[2] + 500;

  _id_04579697F9F42001 = _id_E53AB3056AF949C7.location;
  _id_49DBE0A87DB806D4 = (0, _id_E53AB3056AF949C7.angles, 0);
  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(_id_04579697F9F42001, _id_49DBE0A87DB806D4, _id_40D0FC358B957A0F, _id_5FA1E1697A302583, _id_46B3D7CBD1251291, _id_3AE18FE8CC908B35, _id_9C39DCE599026A69, streakinfo.streakname, _id_505331AD630BBC6B);
  pathstart = flightpath["startPoint"];
  pathgoal = flightpath["endPoint"];
  _id_7622A5AD898BDBD1 = _id_49DBE0A87DB806D4;
  _id_A24A061A7076376C = spawn("script_model", pathstart);
  _id_A24A061A7076376C setModel("veh9_mil_air_stealth_bomber_mp");
  _id_A24A061A7076376C.speed = _id_3AE18FE8CC908B35;
  _id_A24A061A7076376C.accel = 100;
  _id_A24A061A7076376C.angles = _id_7622A5AD898BDBD1;
  _id_A24A061A7076376C.team = owner.team;
  _id_A24A061A7076376C.owner = owner;
  _id_A24A061A7076376C.streakinfo = streakinfo;
  _id_A24A061A7076376C.streakname = streakinfo.streakname;
  _id_A24A061A7076376C.currentdamagestate = 0;
  _id_A24A061A7076376C.flyheight = _id_46B3D7CBD1251291;
  _id_A24A061A7076376C.pers["team"] = _id_A24A061A7076376C.team;
  _id_A24A061A7076376C.flightdir = flightpath["directionAngles"];
  _id_A24A061A7076376C._id_862801AAB153104C = _id_3AE18FE8CC908B35 * 17.6;
  _id_A24A061A7076376C._id_6F43003B25B91499 = pathstart;
  _id_A24A061A7076376C._id_AC01C3B7BBCBC871 = pathstart + anglesToForward(_id_A24A061A7076376C.angles) * int(_id_40D0FC358B957A0F * 0.67);
  _id_A24A061A7076376C._id_9C6AA2AD962CCAE2 = pathgoal - anglesToForward(_id_A24A061A7076376C.angles) * int(_id_40D0FC358B957A0F * 0.67);
  _id_A24A061A7076376C._id_5118088B7D149D56 = pathgoal;
  _id_A24A061A7076376C._id_40D811C99BD7AC07 = length(_id_A24A061A7076376C._id_AC01C3B7BBCBC871 - _id_A24A061A7076376C._id_9C6AA2AD962CCAE2);
  _id_A24A061A7076376C.flighttime = length(_id_A24A061A7076376C._id_6F43003B25B91499 - _id_A24A061A7076376C._id_5118088B7D149D56) / _id_A24A061A7076376C._id_862801AAB153104C;
  _id_A24A061A7076376C._id_602736E29283719A = length(_id_A24A061A7076376C._id_6F43003B25B91499 - _id_A24A061A7076376C._id_AC01C3B7BBCBC871) / _id_A24A061A7076376C._id_862801AAB153104C;
  _id_A24A061A7076376C._id_049D6B84E9061EA2 = length(_id_A24A061A7076376C._id_6F43003B25B91499 - _id_A24A061A7076376C._id_9C6AA2AD962CCAE2) / _id_A24A061A7076376C._id_862801AAB153104C;
  _id_A24A061A7076376C._id_C588C0602C9A3B4D = 500 / _id_A24A061A7076376C._id_862801AAB153104C;
  _id_A24A061A7076376C._id_BEBE0D78A71DB256 = int(_id_A24A061A7076376C._id_40D811C99BD7AC07 / 500);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("auto_drone", "attachXRays"))
    _id_A24A061A7076376C = [[scripts\cp_mp\utility\script_utility::getsharedfunc("auto_drone", "attachXRays")]](_id_A24A061A7076376C);

  killcament = spawn("script_model", _id_A24A061A7076376C.origin);
  killcament linkTo(_id_A24A061A7076376C, "tag_origin", (-100, 0, -100), (0, 0, 0));
  _id_A24A061A7076376C.killcament = killcament;
  minimapid = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    minimapid = _id_A24A061A7076376C[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_drone_auto", _id_A24A061A7076376C.team, 1, 1, 1, "icon_large");

  _id_A24A061A7076376C.minimapid = minimapid;
  _id_A24A061A7076376C._id_3BBC88450857EEA8 = [];
  _id_A24A061A7076376C._id_3BBC88450857EEA8["target_line_left"] = [];
  _id_A24A061A7076376C._id_3BBC88450857EEA8["target_line_right"] = [];
  _id_A24A061A7076376C._id_C6DFE23F0091751B = [];
  _id_A24A061A7076376C._id_C6DFE23F0091751B["target_line_left"] = [];
  _id_A24A061A7076376C._id_C6DFE23F0091751B["target_line_right"] = [];
  _id_A24A061A7076376C._id_BE765C862617C601 = _id_E53AB3056AF949C7.location;
  _id_A24A061A7076376C setscriptablepartstate("contrails", "on", 0);
  _id_A24A061A7076376C setscriptablepartstate("lights", "on", 0);
  level._id_5F028B2553FB392D[level._id_5F028B2553FB392D.size] = _id_A24A061A7076376C;
  return _id_A24A061A7076376C;
}

_id_75693AE9C1B5327F(_id_4FAC8B8CE36E09F1) {
  self notify("cleaning_up");
  self.streakinfo.expiredbydeath = istrue(_id_4FAC8B8CE36E09F1);

  if(isDefined(self.owner)) {
    if(!istrue(self.recordedgameendstats))
      self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  if(isDefined(self._id_C6DFE23F0091751B)) {
    foreach(ent in self._id_C6DFE23F0091751B["target_line_left"]) {
      if(isDefined(ent))
        ent delete();
    }

    foreach(ent in self._id_C6DFE23F0091751B["target_line_right"]) {
      if(isDefined(ent))
        ent delete();
    }
  }

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);

    self.minimapid = undefined;
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  level._id_5F028B2553FB392D = scripts\engine\utility::array_remove(level._id_5F028B2553FB392D, self);
  self delete();
}

_id_7056DA117386CF8B() {
  self endon("death");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

_id_DABE5E1812AC0003() {
  self endon("death");
  self endon("cleaning_up");
  self.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self._id_B5629F125E88FE86 = 1;

  if(isDefined(self._id_51FC4D05ABD22E9D))
    self._id_51FC4D05ABD22E9D delete();

  self setscriptablepartstate("release", "neutral", 0);
  self setscriptablepartstate("contrails", "off", 0);
  self setscriptablepartstate("lights", "off", 0);
  self notify("autodrone_flight_finished");
  self notify("autodrone_volley_finished");
}

_id_313EEDA8B560E440(player, _id_82FD3EE8FBACE30E, _id_6D87867F43E1D612, _id_5991F0E5DA9F9BD5) {
  self endon("death");
  _id_6D87867F43E1D612 endon("death");
  _id_6D87867F43E1D612 endon("crashing");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      break;
    }

    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6B40B4C28ABE0A05 < 4000 && _id_6D87867F43E1D612.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](_id_6D87867F43E1D612);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx"))
        _id_6D87867F43E1D612 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]("jet_flares", _id_5991F0E5DA9F9BD5);

      newtarget = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy"))
        newtarget = _id_6D87867F43E1D612[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

_id_71FC6FC4F15927A8() {
  self endon("death");
  level endon("game_ended");
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  _id_EDC8EB6FF8689DDE = self.flighttime;
  _id_DDFE084A5F844081 = self._id_049D6B84E9061EA2;
  _id_9A725E0702370E63 = _id_EDC8EB6FF8689DDE - _id_DDFE084A5F844081;
  plane = self;
  _id_E4D26F59DB05025A = "ks_auto_drone_mp";
  _id_3A69E5FC82079CE3 = self._id_6F43003B25B91499;
  _id_7789CDA8C1E3128E = self.angles;
  _id_3A20F9101E50025F = 0.05;
  _id_3A020E101E2DDEAD = self._id_602736E29283719A;
  _id_7C39D972E849C204 = _id_DDFE084A5F844081;
  _id_A9B4B258C1167B50 = _id_EDC8EB6FF8689DDE;
  self._id_51FC4D05ABD22E9D = level scripts\cp_mp\killstreaks\airstrike::airstrike_playflyfx(plane, _id_E4D26F59DB05025A, _id_3A69E5FC82079CE3, _id_7789CDA8C1E3128E, _id_3A20F9101E50025F, _id_3A020E101E2DDEAD, _id_7C39D972E849C204, _id_A9B4B258C1167B50, self.streakinfo);
  self moveTo(self._id_5118088B7D149D56, _id_EDC8EB6FF8689DDE);
  wait(_id_DDFE084A5F844081);
  self.isleaving = 1;
  wait(_id_9A725E0702370E63);
  self hide();
  self._id_B5629F125E88FE86 = 1;
  self notify("autodrone_flight_finished");
}

_id_7CD9F49E2A56EA1E() {
  self endon("death");
  self endon("autodrone_flight_finished");
  level endon("game_ended");
  _id_ED404DB23F89E299 = 0.15;
  _id_ED1D39B23F636EE5 = 0.075;
  _id_ED1D3FB23F637C17 = 0.0075;
  duration = 0.05;
  source = self.origin;
  _id_31141C7D0222BBE6 = 10000;
  _id_A90593F8A59C9972 = 15000;
  _id_7982BE2C5F81CF6C = 50000;

  for(;;) {
    _func_E45E5FD94EC4AF36(_id_ED404DB23F89E299, _id_ED1D39B23F636EE5, _id_ED1D3FB23F637C17, duration, source, _id_31141C7D0222BBE6, _id_A90593F8A59C9972, _id_7982BE2C5F81CF6C);
    wait 0.05;
  }
}

_id_5072D07167C0AE44() {
  self endon("death");
  level endon("game_ended");
  self.owner endon("disconnect");
  self._id_776781805DE7309D = 0;
  childthread _id_85AF195B469D31C5();
  childthread _id_7507CE6B3DB8BBC6();
  self waittill("autodrone_volley_finished");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(self._id_776781805DE7309D >= 1)
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("auto_drone", "auto_drone_hit_target");
  else
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("auto_drone", "auto_drone_miss_target");
}

_id_85AF195B469D31C5() {
  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(_id_57A633080C56F0AB(weaponname))
      self._id_776781805DE7309D++;
  }
}

_id_7507CE6B3DB8BBC6() {
  for(;;) {
    self.owner waittill("update_rapid_agent_kill_buffered", _id_E4C6376813E5A077, weaponname);

    if(_id_57A633080C56F0AB(weaponname))
      self._id_776781805DE7309D++;
  }
}

_id_57A633080C56F0AB(weaponname) {
  return isDefined(weaponname) && weaponname == "auto_drone_proj_mp";
}

_id_E01FF9FBB932EE1A() {
  self endon("death");
  self endon("autodrone_volley_finished");
  level endon("game_ended");
  thread _id_83C774EC24AEA7BA();
  _id_3C89FEDB7C78518C = self._id_602736E29283719A;
  wait(_id_3C89FEDB7C78518C);
  self setscriptablepartstate("release", "active", 0);
  childthread _id_FDEF1908AB475A22("target_line_left");
  childthread _id_FDEF1908AB475A22("target_line_right");
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0, 0, 0);
  _id_4D9AA2D7B6011B59 = "none";
  _id_FFD02AB6FCA99256 = 1;
  _id_3EB0E5F5F61F0A10 = self.origin;
  _id_6951CF1F43BC8EBE = self.angles;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_BEBE0D78A71DB256; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 2; _id_AC0E5C4AC96AAA41++) {
      if(_id_AC0E5C4AC96AAA41 == 1)
        _id_4D9AA2D7B6011B59 = "target_line_right";
      else
        _id_4D9AA2D7B6011B59 = "target_line_left";

      targetpos = _id_3ABD38166387D794(_id_4D9AA2D7B6011B59, contentoverride, _id_3EB0E5F5F61F0A10);

      if(isDefined(targetpos)) {
        thread _id_C94461E02CFE0BB9(_id_4D9AA2D7B6011B59, targetpos, _id_FFD02AB6FCA99256);
        _id_FFD02AB6FCA99256++;

        if(_id_FFD02AB6FCA99256 > 25)
          _id_FFD02AB6FCA99256 = 1;
      }
    }

    wait(self._id_C588C0602C9A3B4D);
    _id_3EB0E5F5F61F0A10 = _id_3EB0E5F5F61F0A10 + anglesToForward(_id_6951CF1F43BC8EBE) * 500;
  }

  self setscriptablepartstate("release", "neutral", 0);
  _id_0464ED851FBD2E05();
  self notify("autodrone_volley_finished");
}

_id_3ABD38166387D794(_id_4D9AA2D7B6011B59, contentoverride, _id_51C1B45046E1647C) {
  if(!isDefined(_id_51C1B45046E1647C))
    _id_51C1B45046E1647C = self.origin;

  _id_6951CF1F43BC8EBE = self.angles;
  _id_00A8B7FFAF6FA18F = undefined;

  switch (_id_4D9AA2D7B6011B59) {
    case "target_line_left":
      _id_00A8B7FFAF6FA18F = _id_51C1B45046E1647C - anglestoright(_id_6951CF1F43BC8EBE) * 300;
      break;
    case "target_line_right":
      _id_00A8B7FFAF6FA18F = _id_51C1B45046E1647C + anglestoright(_id_6951CF1F43BC8EBE) * 300;
      break;
    default:
      _id_00A8B7FFAF6FA18F = _id_51C1B45046E1647C;
      break;
  }

  if(isDefined(_id_00A8B7FFAF6FA18F)) {
    _id_3EB0E5F5F61F0A10 = _id_4864B3EE27853E8F(_id_00A8B7FFAF6FA18F, 300);
    _id_785F5B52F245A2B6 = _id_3EB0E5F5F61F0A10;
    _id_BD794EEF2B14C4B3 = _id_3EB0E5F5F61F0A10 - (0, 0, 50000);
    _id_3B8C153F4D5D7F16 = scripts\engine\trace::ray_trace(_id_785F5B52F245A2B6, _id_BD794EEF2B14C4B3, undefined, contentoverride);
    _id_199D077025BADC44 = undefined;

    if(_id_3B8C153F4D5D7F16["hittype"] != "hittype_none")
      _id_199D077025BADC44 = _id_3B8C153F4D5D7F16["position"];

    return _id_199D077025BADC44;
  }

  return undefined;
}

_id_4864B3EE27853E8F(_id_00A8B7FFAF6FA18F, _id_4D3C88C7CDA33338) {
  _id_A0A41BA05E16FFE6 = randomint(_id_4D3C88C7CDA33338);
  _id_9E5D403038E4C071 = randomint(360);
  x = _id_00A8B7FFAF6FA18F[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
  y = _id_00A8B7FFAF6FA18F[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
  z = _id_00A8B7FFAF6FA18F[2];
  point = (x, y, z);
  return point;
}

_id_C94461E02CFE0BB9(_id_4D9AA2D7B6011B59, _id_7B59B41B01684053, _id_FFD02AB6FCA99256) {
  _id_FEB32E136C3564D0(_id_4D9AA2D7B6011B59, _id_FFD02AB6FCA99256, _id_7B59B41B01684053, 1.0, 3.0);
}

_id_FEB32E136C3564D0(firetype, _id_BFC89A008CF7365B, _id_45B16F7F8BC51616, _id_FBA952950358557D, _id_4FF0C3309F484B95) {
  if(!isDefined(_id_4FF0C3309F484B95))
    _id_4FF0C3309F484B95 = 0;

  _id_EFFCC3654E4D3279 = spawnStruct();
  _id_EFFCC3654E4D3279._id_8A46C62F0A756DD3 = "explode_" + _id_BFC89A008CF7365B;
  _id_EFFCC3654E4D3279.location = _id_45B16F7F8BC51616;
  _id_EFFCC3654E4D3279.duration = _id_FBA952950358557D;
  _id_EFFCC3654E4D3279.starttime = gettime() + _id_4FF0C3309F484B95 * 1000;
  self._id_3BBC88450857EEA8[firetype][self._id_3BBC88450857EEA8[firetype].size] = _id_EFFCC3654E4D3279;
}

_id_FDEF1908AB475A22(firetype) {
  currentindex = 0;

  for(;;) {
    if(self._id_3BBC88450857EEA8[firetype].size < currentindex + 1) {
      waitframe();
      continue;
    }

    _id_81B2EF5A08652E95 = self._id_3BBC88450857EEA8[firetype][currentindex];
    _id_A6584937BC27F804 = _id_81B2EF5A08652E95._id_8A46C62F0A756DD3;
    _id_45B16F7F8BC51616 = _id_81B2EF5A08652E95.location;
    _id_FBA952950358557D = _id_81B2EF5A08652E95.duration;
    _id_A28E260AEDAD587E = _id_81B2EF5A08652E95.starttime;

    while(gettime() < _id_A28E260AEDAD587E)
      waitframe();

    _id_EC425EC41730E90A = _id_4D86E5FCC67998A4(firetype);

    if(!isDefined(_id_EC425EC41730E90A)) {
      waitframe();
      continue;
    }

    _id_EC425EC41730E90A.inuse = 1;
    _id_EC425EC41730E90A.origin = _id_45B16F7F8BC51616;
    waitframe();
    _id_EC425EC41730E90A childthread _id_AFB3D7504A849066(_id_A6584937BC27F804, _id_FBA952950358557D);
    currentindex++;
  }
}

_id_AFB3D7504A849066(_id_8A46C62F0A756DD3, _id_FBA952950358557D) {
  self setscriptablepartstate(_id_8A46C62F0A756DD3, "active", 0);
  wait(_id_FBA952950358557D);
  self setscriptablepartstate(_id_8A46C62F0A756DD3, "neutral", 0);
  self.inuse = 0;
}

_id_83C774EC24AEA7BA() {
  level endon("game_ended");
  self waittill("autodrone_volley_finished");

  for(;;) {
    if(istrue(self._id_B5629F125E88FE86)) {
      break;
    }

    waitframe();
  }

  _id_75693AE9C1B5327F();
}

_id_0464ED851FBD2E05() {
  level endon("game_ended");
  _id_302F633427D41AFC = 1;

  for(;;) {
    _id_302F633427D41AFC = 1;

    foreach(_id_205E3B3B6FC640EA in self._id_C6DFE23F0091751B) {
      foreach(_id_EC425EC41730E90A in _id_205E3B3B6FC640EA) {
        if(istrue(_id_EC425EC41730E90A.inuse)) {
          _id_302F633427D41AFC = 0;
          break;
        }
      }

      if(!istrue(_id_302F633427D41AFC)) {
        break;
      }
    }

    if(!istrue(_id_302F633427D41AFC)) {
      waitframe();
      continue;
    }

    break;
  }
}

_id_4D86E5FCC67998A4(firetype) {
  if(!isDefined(self.owner)) {
    return;
  }
  _id_EC425EC41730E90A = undefined;
  _id_2AB78FE309D9B0EA = "ks_auto_drone_target_mp";

  if(self._id_C6DFE23F0091751B[firetype].size == 0)
    _id_EC425EC41730E90A = _id_762E969612131DA2(firetype, _id_2AB78FE309D9B0EA);
  else {
    _id_2E3BC563C04CE992 = self._id_C6DFE23F0091751B[firetype];

    foreach(ent in _id_2E3BC563C04CE992) {
      if(!istrue(ent.inuse)) {
        _id_EC425EC41730E90A = ent;
        break;
      }
    }

    if(!isDefined(_id_EC425EC41730E90A) && _id_2E3BC563C04CE992.size < 10)
      _id_EC425EC41730E90A = _id_762E969612131DA2(firetype, _id_2AB78FE309D9B0EA);
  }

  return _id_EC425EC41730E90A;
}

_id_762E969612131DA2(firetype, _id_2AB78FE309D9B0EA) {
  _id_EC425EC41730E90A = spawn("script_model", self.origin);
  _id_EC425EC41730E90A.inuse = 0;
  _id_EC425EC41730E90A.streakinfo = self.streakinfo;
  _id_EC425EC41730E90A.weapon_name = "auto_drone_proj_mp";
  _id_EC425EC41730E90A.killcament = self.killcament;
  _id_EC425EC41730E90A setModel(_id_2AB78FE309D9B0EA);
  _id_EC425EC41730E90A dontinterpolate();
  _id_EC425EC41730E90A setentityowner(self.owner);
  self._id_C6DFE23F0091751B[firetype][self._id_C6DFE23F0091751B[firetype].size] = _id_EC425EC41730E90A;
  return _id_EC425EC41730E90A;
}