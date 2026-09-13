/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\white_phosphorus.gsc
**********************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "init")]]();

  level.activewpzones = [];
  level.activewpinnerzones = [];
  level.white_phosphorus_damage_area = getEnt("white_phosphorus_damage", "targetname");
}

weapongivenwp(streakinfo) {
  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "startMapSelectSequence"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "startMapSelectSequence")]](0, 1, "long_arrow");

  return 1;
}

tryusewp() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", self);
  return tryusewpfromstruct(streakinfo);
}

tryusewpfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  deployweaponobj = makeweapon("ks_remote_map_mp");
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, ::weapongivenwp);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  mappointinfo = wp_getmapselectioninfo(streakinfo, 1, 1);

  if(!isDefined(mappointinfo))
    return 0;

  thread wp_startdeploy(mappointinfo, streakinfo);
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("white_phosphorus", "use_" + streakinfo.streakname, 1, _id_52A5BE2E2F91D710);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);

  return 1;
}

wp_getmapselectioninfo(streakinfo, _id_9857725B52CCE14B, _id_EDC5BB5A4B3DD2FF) {
  _id_3B64EB40368C1450::set("map_selection", "weapon_switch", 0);
  self setsoundsubmix("mp_killstreak_overlay");
  mappointinfo = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getSelectMapPoint"))
    mappointinfo = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "getSelectMapPoint")]](streakinfo, _id_9857725B52CCE14B, _id_EDC5BB5A4B3DD2FF);

  if(!isDefined(mappointinfo)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("map_selection");
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("map_selection");
  self clearsoundsubmix("mp_killstreak_overlay");
  return mappointinfo;
}

wp_startdeploy(mappointinfo, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");

    return 0;
  }

  level.wpinprogress = 1;

  foreach(_id_47B05A700340406E, _id_470C049A636DB53D in mappointinfo) {
    _id_0B21E2E887C161B9 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;
    wp_finishdeployment(_id_0B21E2E887C161B9, _id_A4521BB88F4EB389, streakinfo);

    if(mappointinfo.size > 1 && _id_47B05A700340406E < mappointinfo.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

wp_finishdeployment(_id_76A22C18960F72AF, _id_AE3D7191A8C7CBA9, streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread wp_watchdisownaction("disconnect");
  thread wp_watchdisownaction("joined_team");
  thread wp_watchdisownaction("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  _id_83C2AB15F0A8B72C = wp_createplane(_id_76A22C18960F72AF, _id_AE3D7191A8C7CBA9, streakinfo);

  if(!isDefined(_id_83C2AB15F0A8B72C))
    return 0;

  _id_83C2AB15F0A8B72C thread wp_watchplanedisowned();
  _id_83C2AB15F0A8B72C thread wp_deliverpayloads(streakinfo);
}

wp_createplane(_id_0C29D6830464CAD8, _id_373A9C97CC32A2F9, streakinfo) {
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  _id_5ED27D0675C3B6EB = 28000;
  _id_23122E7B902F2EA9 = 5000;
  _id_76AB620FD7CC70BD = 2500;
  _id_361663D437DB22F5 = 1500;
  _id_22DC3A1E20682BB6 = (0, _id_373A9C97CC32A2F9, 0);

  if(!isDefined(_id_5FA1E1697A302583))
    _id_76AB620FD7CC70BD = _id_76AB620FD7CC70BD + 3000;
  else {
    _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2] + 3000;
    _id_361663D437DB22F5 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(_id_76AB620FD7CC70BD);
  }

  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(_id_0C29D6830464CAD8, _id_22DC3A1E20682BB6, _id_5ED27D0675C3B6EB, _id_5FA1E1697A302583, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_361663D437DB22F5);
  plane = spawn("script_model", flightpath["startPoint"]);
  plane.angles = _id_22DC3A1E20682BB6;
  plane.flightpath = flightpath;
  plane.owner = self;
  plane.team = self.team;
  plane.streakinfo = streakinfo;
  plane.speed = _id_23122E7B902F2EA9;
  planemodel = "veh9_mil_air_suniform25_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self))
    planemodel = "veh9_mil_air_suniform25_mp";

  plane setModel(planemodel);
  minimapid = undefined;
  _id_68E354FCEB08D97B = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    _id_68E354FCEB08D97B = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");

  if(isDefined(_id_68E354FCEB08D97B)) {
    minimapid = plane[[_id_68E354FCEB08D97B]]("icon_minimap_wp", plane.team, 1, 1, 1);
    plane.minimapid = minimapid;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    plane[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](plane.streakinfo.streakname, "Killstreak_Air", self);

  return plane;
}

wp_watchdisownaction(action, _id_83C2AB15F0A8B72C) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(action);
  level.wpinprogress = undefined;
  level notify("white_phosphorus_end");
}

wp_watchplanedisowned() {
  self endon("death");
  level waittill("white_phosphorus_end");
  wp_removeplane(self);
}

wp_watchforsmokedisowned() {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(wp_isactivewpzone("smoke", self))
    level wp_removefromactivewplist("smoke", self);
  else {
    _id_58A24E382101896D = 0;

    if(_id_58A24E382101896D)
      self freescriptable();
    else
      self delete();
  }
}

wp_watchforflaredisowned(_id_4E01B7D6147E61A0) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament))
    self.killcament delete();

  if(wp_isactivewpzone("inner", self))
    level wp_removefromactivewplist("inner", self, _id_4E01B7D6147E61A0, 1);

  self notify("stop_wp_status_effect");
  _id_58A24E382101896D = 0;

  if(_id_58A24E382101896D)
    self freescriptable();
  else
    self delete();
}

wp_deliverpayloads(streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  _id_C12314B8B47F7C35 = self.flightpath["startPoint"];
  _id_0BEA66D09411DB20 = self.flightpath["endPoint"];
  flighttime = self.flightpath["flyTime"];
  _id_924D800BE62C4E51 = _id_C12314B8B47F7C35 + anglesToForward(self.angles) * 12500;
  _id_AAD5BB2395B29D70 = _id_0BEA66D09411DB20 - anglesToForward(self.angles) * 12500;
  _id_C2DEFFE4ABA8FA7C = length(_id_924D800BE62C4E51 - _id_AAD5BB2395B29D70);
  _id_30A3F1579CA0253A = 30;
  self.owner thread wp_watchend(streakinfo, _id_30A3F1579CA0253A);
  self.owner thread wp_watchgameend(streakinfo);
  self moveTo(_id_0BEA66D09411DB20, flighttime);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(_id_0BEA66D09411DB20, flighttime);
  _id_E9727E658CA8DFD2 = 3;
  wp_handlepayloadtyperelease(::wp_fireairburst, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 4000, _id_E9727E658CA8DFD2, 1);
  wp_handlepayloadtyperelease(::wp_firesmoke, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 4000, 3, 1);
  wp_handlepayloadtyperelease(::wp_fireflaregroup, _id_C12314B8B47F7C35, _id_924D800BE62C4E51, _id_C2DEFFE4ABA8FA7C, _id_30A3F1579CA0253A, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flighttime);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  wp_removeplane(self);
}

wp_watchend(streakinfo, _id_30A3F1579CA0253A) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_30A3F1579CA0253A);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

wp_watchgameend(streakinfo) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

wp_enterpayloadaudio() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
  self playsoundonmovingent("iw8_mp_white_phos_su25_flyby");
}

wp_exitpayloadaudio(_id_0BEA66D09411DB20, flighttime) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(flighttime);
  playsoundatpos(_id_0BEA66D09411DB20, "iw8_mp_white_phos_su25_exit");
}

wp_watchunsuccessfulzones(_id_EB34677262FED134) {
  level endon("wp_zone_succeeded");
  level endon("game_ended");

  for(_id_CF6D87D10FA26355 = 0; _id_CF6D87D10FA26355 < _id_EB34677262FED134; _id_CF6D87D10FA26355++)
    level waittill("wp_zone_failed");

  level.wpinprogress = undefined;
}

wp_handlepayloadtyperelease(_id_FAB341CDE0F5A8A4, _id_3E69F8D86497745D, _id_EC975DF40AFFB201, _id_985ED30DFF21F18C, _id_30A3F1579CA0253A, _id_624C6F581E3A3784, _id_F5C59BE7BAF53B36, _id_3C6798C87677A9C3) {
  _id_BEBE0D78A71DB256 = int(_id_985ED30DFF21F18C / _id_624C6F581E3A3784);
  _id_D0BB190B577957F4 = 0;

  if(!isDefined(_id_F5C59BE7BAF53B36))
    _id_F5C59BE7BAF53B36 = _id_BEBE0D78A71DB256;
  else {
    _id_2DBC68179E13EA9E = _id_BEBE0D78A71DB256 - _id_F5C59BE7BAF53B36;
    _id_D0BB190B577957F4 = int(_id_2DBC68179E13EA9E / 2);
  }

  if(isDefined(_id_3C6798C87677A9C3))
    _id_D0BB190B577957F4 = _id_D0BB190B577957F4 + _id_3C6798C87677A9C3;

  _id_67B9AB39704D906E = anglesToForward(self.angles);
  _id_6622BF241E83CB33 = _id_EC975DF40AFFB201;
  _id_B75CA07CCC1468B5 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BEBE0D78A71DB256; _id_AC0E594AC96AA3A8++) {
    _id_B540FEDD1D9812F4 = length(_id_3E69F8D86497745D - _id_6622BF241E83CB33) / self.speed;

    if(_id_AC0E594AC96AA3A8 < _id_D0BB190B577957F4) {
      _id_6622BF241E83CB33 = _id_6622BF241E83CB33 + _id_67B9AB39704D906E * _id_624C6F581E3A3784;
      continue;
    }

    _id_5E4B11A3DBE28124 = _id_6622BF241E83CB33 - (0, 0, 2000);

    if(_id_FAB341CDE0F5A8A4 == ::wp_fireflaregroup) {
      killcament = spawn("script_model", _id_3E69F8D86497745D + (0, 0, 1500));
      killcament thread wp_movekillcam(_id_B540FEDD1D9812F4, _id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_30A3F1579CA0253A);
      self thread[[_id_FAB341CDE0F5A8A4]](_id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_B540FEDD1D9812F4, killcament);
    } else if(_id_FAB341CDE0F5A8A4 == ::wp_firesmoke)
      self thread[[_id_FAB341CDE0F5A8A4]](_id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_B540FEDD1D9812F4, _id_AC0E594AC96AA3A8);
    else
      self thread[[_id_FAB341CDE0F5A8A4]](_id_5E4B11A3DBE28124, _id_67B9AB39704D906E, _id_B540FEDD1D9812F4);

    _id_6622BF241E83CB33 = _id_6622BF241E83CB33 + _id_67B9AB39704D906E * _id_624C6F581E3A3784;
    _id_B75CA07CCC1468B5++;

    if(_id_B75CA07CCC1468B5 == _id_F5C59BE7BAF53B36) {
      break;
    }
  }
}

wp_movekillcam(movetime, endpos, _id_0D3DC97C59992D51, _id_30A3F1579CA0253A) {
  self endon("death");
  endpos = endpos - _id_0D3DC97C59992D51 * 3500;
  _id_1F67F5E7A912EE6D = endpos - _id_0D3DC97C59992D51 * 1000;
  self moveTo(endpos, movetime + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(movetime + 2);
  self moveTo(_id_1F67F5E7A912EE6D, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_30A3F1579CA0253A);
  self delete();
}

wp_testpayloads(_id_90128D0639A1315D, _id_211FC11F4C8566F5, _id_C64748F70E85140D) {
  self endon("death");
}

wp_fireairburst(_id_2D7A2733C414E4DF, _id_DB855E6AE67F1A7F, _id_854BDDFCC12BBC97) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  _id_089C07A70B638FDD = _id_2D7A2733C414E4DF - _id_DB855E6AE67F1A7F * 3000;
  _id_1FC06BF514F2782A = _id_2D7A2733C414E4DF - _id_DB855E6AE67F1A7F * 2000;
  _id_30A3F1579CA0253A = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_854BDDFCC12BBC97);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), _id_089C07A70B638FDD, _id_DB855E6AE67F1A7F);
  playsoundatpos(_id_1FC06BF514F2782A, "iw8_mp_white_phos_midair_explo");
}

wp_firesmoke(_id_1EF6E5290287FB69, _id_29C782C334F31FF1, _id_BA62A61666563104, _id_3624CE7E27390368) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self.playersininitialsmokerange))
    self.playersininitialsmokerange = [];

  if(!isDefined(self.playersoutsideinitialsmokerange))
    self.playersoutsideinitialsmokerange = [];

  _id_D1E8F547BE452B54 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype != "arm" && level.gametype != "conflict")
    _id_D1E8F547BE452B54 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "fullMapCoverageOverride"))
    _id_D1E8F547BE452B54 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "fullMapCoverageOverride")]]();

  _id_9F48DDEBDB600442 = scripts\engine\trace::ray_trace(_id_1EF6E5290287FB69, _id_1EF6E5290287FB69 - (0, 0, 10000));
  _id_34D5E8B89A1586D3 = _id_9F48DDEBDB600442["position"];
  _id_30A3F1579CA0253A = 30;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getPayloadLifetimeOverride"))
    _id_30A3F1579CA0253A = [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "getPayloadLifetimeOverride")]]();

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_BA62A61666563104);
  _id_58A24E382101896D = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getWpSpawnType"))
    _id_58A24E382101896D = [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "getWpSpawnTypeOverride")]]();

  if(_id_58A24E382101896D)
    _id_6B5D366F98BA252B = spawnscriptable("ks_white_phosphorus_mp_p", _id_34D5E8B89A1586D3, self.angles);
  else {
    _id_6B5D366F98BA252B = spawn("script_model", _id_34D5E8B89A1586D3);
    _id_6B5D366F98BA252B setModel("ks_white_phosphorus_mp");
    _id_6B5D366F98BA252B setentityowner(self.owner);
  }

  _id_6B5D366F98BA252B.team = self.team;
  _id_6B5D366F98BA252B.owner = self.owner;
  _id_6B5D366F98BA252B.streakinfo = self.streakinfo;
  _id_6B5D366F98BA252B thread wp_watchforsmokedisowned();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  level thread wp_playimpactsound(_id_6B5D366F98BA252B);

  if(istrue(_id_D1E8F547BE452B54)) {
    _id_F43A453571B50E3D = isDefined(_id_3624CE7E27390368) && _id_3624CE7E27390368 == 3;

    if(istrue(_id_F43A453571B50E3D)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self.playersininitialsmokerange = scripts\common\utility::playersincylinder(_id_34D5E8B89A1586D3, 2000);
      self.playersoutsideinitialsmokerange = scripts\engine\utility::array_difference(level.players, self.playersininitialsmokerange);
      _id_6B5D366F98BA252B thread wp_watchdisorienteffect(2000, self.playersininitialsmokerange, self.playersoutsideinitialsmokerange);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isnightmap())
      _id_6B5D366F98BA252B setscriptablepartstate("smoke_night", "on", 0);
    else
      _id_6B5D366F98BA252B setscriptablepartstate("smoke", "on", 0);

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    _id_6B5D366F98BA252B thread wp_watchdisorienteffect(2000, _id_D1E8F547BE452B54);
  }

  level wp_addtoactivewplist("smoke", _id_6B5D366F98BA252B);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_30A3F1579CA0253A);
  level wp_removefromactivewplist("smoke", _id_6B5D366F98BA252B);
}

wp_fireflaregroup(_id_CCB4BC85E1F59F16, _id_47AAE5E47F9B546C, _id_CF7BC521EC91E2B3, killcament) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  _id_A97F1D7E9A99E8F6 = self.owner;
  _id_59A0861125FDCD0A = self.team;
  _id_D2DDC5D6AB4565E2 = self.angles;
  _id_9F48DDEBDB600442 = scripts\engine\trace::ray_trace(_id_CCB4BC85E1F59F16, _id_CCB4BC85E1F59F16 - (0, 0, 10000), self, undefined, 1, 1);
  _id_34D5E8B89A1586D3 = _id_9F48DDEBDB600442["position"];
  _id_86D82C4A83032A88 = _id_9F48DDEBDB600442["surfacetype"];
  _id_FECF0CCF76F88985 = isDefined(level.white_phosphorus_damage_area);

  if(istrue(_id_FECF0CCF76F88985)) {
    level.white_phosphorus_damage_area dontinterpolate();
    level.white_phosphorus_damage_area.owner = _id_A97F1D7E9A99E8F6;
    level.white_phosphorus_damage_area.team = _id_59A0861125FDCD0A;
    level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
  }

  _id_30A3F1579CA0253A = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_CF7BC521EC91E2B3);
  _id_F03E9D02C0FF2C99 = wp_getflarepositions(_id_CCB4BC85E1F59F16, _id_34D5E8B89A1586D3, 4, int(250.0));

  foreach(struct in _id_F03E9D02C0FF2C99) {
    _id_58A24E382101896D = 0;

    if(_id_58A24E382101896D)
      flare = spawnscriptable("ks_white_phosphorus_mp_p", struct.flareorigin, _id_D2DDC5D6AB4565E2);
    else {
      flare = spawn("script_model", struct.flareorigin);
      flare setModel("ks_white_phosphorus_mp");
      flare setentityowner(_id_A97F1D7E9A99E8F6);
      flare.angles = _id_D2DDC5D6AB4565E2;
    }

    flare.owner = _id_A97F1D7E9A99E8F6;
    flare.team = _id_59A0861125FDCD0A;
    flare.streakinfo = self.streakinfo;
    flare.struct = struct;
    flare.weapon_name = "white_phosphorus_proj_mp";
    flare.killcament = killcament;
    flare thread wp_watchforflaredisowned("burn");
    flare thread wp_projwatchimpact(_id_30A3F1579CA0253A, "burn", _id_86D82C4A83032A88);
    wait(randomfloatrange(0.1, 0.4));
  }

  if(istrue(_id_FECF0CCF76F88985))
    level.white_phosphorus_damage_area.origin = (0, 0, 50000);
}

wp_getflarepositions(_id_3EB0E5F5F61F0A10, _id_70A67134926DE6DC, _id_0DB715BCDE296BEC, _id_FCDCC201CE6E652E) {
  _id_60E5D173CFB587A8 = [];
  _id_6F680EE249F67B0D = self.angles * (0, 1, 0);
  _id_4B52F031A2CBEF8E = anglesToForward(_id_6F680EE249F67B0D);
  _id_D8BB89F41AE3D919 = anglestoright(_id_6F680EE249F67B0D);
  contents = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(contents);
  _id_7BA409015D76660F = -2000;
  _id_BCA221BD88841350 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0DB715BCDE296BEC; _id_AC0E594AC96AA3A8++) {
    _id_5B91512983A7DBAE = _id_4B52F031A2CBEF8E * _id_7BA409015D76660F + _id_D8BB89F41AE3D919 * _id_BCA221BD88841350;
    _id_11C8174CF2C79029 = _id_70A67134926DE6DC + _id_4B52F031A2CBEF8E * _id_7BA409015D76660F;
    _id_A18D8B24190A4AD7 = _id_70A67134926DE6DC + _id_5B91512983A7DBAE;
    _id_CEDE89DE9D142B28 = scripts\engine\trace::ray_trace(_id_A18D8B24190A4AD7 + (0, 0, _id_3EB0E5F5F61F0A10[2]), _id_A18D8B24190A4AD7 - (0, 0, 10000), level.characters, contentoverride);
    flareorigin = _id_CEDE89DE9D142B28["position"];
    damageorigin = _id_70A67134926DE6DC * (1, 1, 0) + (0, 0, flareorigin[2]) + _id_4B52F031A2CBEF8E * _id_7BA409015D76660F;
    _id_5D9FF3E35698CEB7 = spawnStruct();
    _id_5D9FF3E35698CEB7.damageorigin = damageorigin;
    _id_5D9FF3E35698CEB7.flareorigin = flareorigin;
    _id_60E5D173CFB587A8[_id_60E5D173CFB587A8.size] = _id_5D9FF3E35698CEB7;
    _id_7BA409015D76660F = _id_7BA409015D76660F + 500;
    _id_BCA221BD88841350 = randomintrange(-750, 750);
  }

  return _id_60E5D173CFB587A8;
}

wp_projwatchimpact(_id_30A3F1579CA0253A, _id_4E01B7D6147E61A0, _id_86D82C4A83032A88) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self.projimpacted = 1;
  level wp_addtoactivewplist("inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(_id_86D82C4A83032A88) && _id_86D82C4A83032A88 == "surftype_water")
    self setscriptablepartstate("flare_death_water", "on", 0);
  else
    self setscriptablepartstate("flare", "on", 0);

  _id_420DC592A2640A78 = self.struct.damageorigin + (0, 0, 10);

  if(isDefined(self.owner))
    self radiusdamage(_id_420DC592A2640A78, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");

  if(isDefined(_id_86D82C4A83032A88) && _id_86D82C4A83032A88 != "surftype_water") {
    if(isDefined(_id_4E01B7D6147E61A0)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(_id_4E01B7D6147E61A0 == "burn")
        thread wp_watchburneffect(300);
      else
        thread wp_watchblindeffect(300);

      if(!scripts\common\utility::iscp()) {
        scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(self.origin, 300, 300, _id_30A3F1579CA0253A, self.owner, self.team);
        thread wp_deletedangerzoneondeath();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_30A3F1579CA0253A);
    level wp_removefromactivewplist("inner", self, _id_4E01B7D6147E61A0, 1);
    self notify("stop_wp_status_effect");
    self setscriptablepartstate("flare", "off", 0);
    self setscriptablepartstate("flare_death", "on", 0);
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  thread wp_delayzonedelete(15);
}

wp_deletedangerzoneondeath() {
  level endon("game_ended");
  dangerzoneid = self.dangerzoneid;
  self waittill("death");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone(dangerzoneid);
}

wp_delayzonedelete(_id_3702CBA57F844507) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  _id_58A24E382101896D = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_3702CBA57F844507);

  if(_id_58A24E382101896D)
    self freescriptable();
  else
    self delete();
}

wp_watchdisorienteffect(_id_2064C9035E8FDDD4, _id_73798C47BD1E4E64, _id_1F86B15FAEB68186) {
  self endon("death");
  self.playersindisorientradius = [];

  if(isDefined(_id_73798C47BD1E4E64) && isDefined(_id_1F86B15FAEB68186)) {
    thread wp_delaydisorientplayersinrange(0.15, 2000, _id_73798C47BD1E4E64);
    thread wp_delaydisorientplayersinrange(0.25, undefined, _id_1F86B15FAEB68186);
  } else {
    for(;;) {
      _id_9EAB05D07992EB78 = scripts\common\utility::playersincylinder(self.origin, _id_2064C9035E8FDDD4);
      _id_75837944482F9ECE = scripts\engine\utility::array_difference(level.players, _id_9EAB05D07992EB78);

      foreach(player in _id_9EAB05D07992EB78) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(!wp_isinwpzone("smoke", player, self))
          wp_addplayertostatusradiuslist("smoke", player);

        if(!istrue(player.wpdisorient))
          player thread wp_startdisorientplayer(self);
      }

      foreach(player in _id_75837944482F9ECE) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(istrue(player.wpdisorient) && wp_isinwpzone("smoke", player, self))
          player thread wp_stopdisorientplayer(self);
      }

      waitframe();
    }
  }
}

wp_getplayerswithinrange(_id_FE16F116477F0084, range) {
  playersinrange = [];

  foreach(player in _id_FE16F116477F0084) {
    if(distance2dsquared(self.origin, player.origin) <= range * range)
      playersinrange[playersinrange.size] = player;
  }

  return playersinrange;
}

wp_delaydisorientplayersinrange(_id_74B5B12BB6514385, range, _id_D64F8BEE3F6893E3) {
  self endon("death");

  if(isDefined(_id_74B5B12BB6514385) && _id_74B5B12BB6514385 > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  _id_F1C102CD6FD079FB = _id_D64F8BEE3F6893E3;

  if(isDefined(range) && range > 0)
    _id_F1C102CD6FD079FB = wp_getplayerswithinrange(_id_D64F8BEE3F6893E3, range);

  foreach(player in _id_F1C102CD6FD079FB) {
    if(player scripts\cp_mp\utility\player_utility::_isalive()) {
      wp_addplayertostatusradiuslist("smoke", player);

      if(!istrue(player.wpdisorient))
        player thread wp_startdisorientplayer(self);
    }

    player thread wp_startdisorientplayeronspawn(self);
  }
}

wp_watchburneffect(_id_5D889FD269DFB5CA) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, player.origin) <= _id_5D889FD269DFB5CA && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpburning))
          player thread wp_startburnplayer(self, self.owner);

        continue;
      }

      if(istrue(player.wpburning) && wp_isinwpzone("inner", player, self))
        player wp_stopburnplayer(self);
    }

    waitframe();
  }
}

wp_watchblindeffect(_id_36F2E76BC9E35AC6) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, player.origin) <= _id_36F2E76BC9E35AC6 && scripts\engine\trace::ray_trace_passed(player getEye(), self.origin + (0, 0, 30), player)) {
        if(!istrue(player.wpblinding))
          player wp_startblindplayer(self);

        continue;
      }

      if(istrue(player.wpblinding) && wp_isinwpzone("inner", player, self))
        player wp_stopblindplayer(self);
    }

    waitframe();
  }
}

wp_addtoactivewplist(type, _id_FA00AB9D021CD558) {
  if(type == "smoke")
    level.activewpzones[level.activewpzones.size] = _id_FA00AB9D021CD558;
  else
    level.activewpinnerzones[level.activewpinnerzones.size] = _id_FA00AB9D021CD558;
}

wp_isactivewpzone(type, _id_D0EDAB7A45B12083) {
  _id_EC4BAE72ADF2BC39 = 0;

  if(type == "smoke") {
    foreach(zone in level.activewpzones) {
      if(zone == _id_D0EDAB7A45B12083) {
        _id_EC4BAE72ADF2BC39 = 1;
        break;
      }
    }
  } else {
    foreach(zone in level.activewpinnerzones) {
      if(zone == _id_D0EDAB7A45B12083) {
        _id_EC4BAE72ADF2BC39 = 1;
        break;
      }
    }
  }

  return _id_EC4BAE72ADF2BC39;
}

wp_removefromactivewplist(type, _id_E259CF0D8DCFA751, _id_CC9D6AB1BDF32FC0, _id_662EFE6105E9F585) {
  if(!isDefined(_id_E259CF0D8DCFA751)) {
    return;
  }
  _id_E5DAB4F107F3A279 = [];

  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(_id_B16682794BB72308 == _id_E259CF0D8DCFA751) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = _id_B16682794BB72308;
    }

    level.activewpzones = _id_E5DAB4F107F3A279;

    if(isDefined(_id_E259CF0D8DCFA751.playersindisorientradius)) {
      foreach(player in _id_E259CF0D8DCFA751.playersindisorientradius) {
        if(isDefined(player) && !wp_isinanywpzone("smoke", player))
          player thread wp_stopdisorientplayer(_id_E259CF0D8DCFA751);
      }
    }

    if(level.activewpzones.size <= 0)
      level.wpinprogress = undefined;
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(_id_B16682794BB72308 == _id_E259CF0D8DCFA751) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = _id_B16682794BB72308;
    }

    level.activewpinnerzones = _id_E5DAB4F107F3A279;

    if(isDefined(_id_E259CF0D8DCFA751.playersininnerradius)) {
      foreach(player in _id_E259CF0D8DCFA751.playersininnerradius) {
        if(isDefined(player) && !wp_isinanywpzone("inner", player)) {
          if(_id_CC9D6AB1BDF32FC0 == "burn") {
            player thread wp_stopburnplayer(_id_E259CF0D8DCFA751);
            continue;
          }

          player thread wp_stopblindplayer(_id_E259CF0D8DCFA751);
        }
      }
    }
  }

  if(istrue(_id_662EFE6105E9F585)) {
    return;
  }
  _id_58A24E382101896D = 0;

  if(_id_58A24E382101896D)
    _id_E259CF0D8DCFA751 freescriptable();
  else
    _id_E259CF0D8DCFA751 delete();
}

wp_isinanywpzone(type, _id_C4B81997F0120A97) {
  _id_83EBB8884BB96F82 = 0;

  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308)) {
        _id_83EBB8884BB96F82 = 1;
        break;
      }
    }
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308)) {
        _id_83EBB8884BB96F82 = 1;
        break;
      }
    }
  }

  return _id_83EBB8884BB96F82;
}

wp_isinwpzone(type, _id_C4B81997F0120A97, _id_B16682794BB72308) {
  isinzone = 0;
  _id_2B3D4F72CF8EF276 = undefined;

  if(type == "smoke")
    _id_2B3D4F72CF8EF276 = _id_B16682794BB72308.playersindisorientradius;
  else
    _id_2B3D4F72CF8EF276 = _id_B16682794BB72308.playersininnerradius;

  if(isDefined(_id_2B3D4F72CF8EF276)) {
    foreach(player in _id_2B3D4F72CF8EF276) {
      if(player == _id_C4B81997F0120A97) {
        isinzone = 1;
        break;
      }
    }
  }

  return isinzone;
}

wp_addplayertostatusradiuslist(type, _id_E69B22A24070EC44) {
  if(type == "smoke")
    self.playersindisorientradius[self.playersindisorientradius.size] = _id_E69B22A24070EC44;
  else
    self.playersininnerradius[self.playersininnerradius.size] = _id_E69B22A24070EC44;
}

wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD) {
  if(type == "smoke") {
    _id_E5DAB4F107F3A279 = [];

    foreach(player in self.playersindisorientradius) {
      if(player == _id_9D90C26327E3EACD) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = player;
    }

    self.playersindisorientradius = _id_E5DAB4F107F3A279;
  } else {
    _id_E5DAB4F107F3A279 = [];

    foreach(player in self.playersininnerradius) {
      if(player == _id_9D90C26327E3EACD) {
        continue;
      }
      _id_E5DAB4F107F3A279[_id_E5DAB4F107F3A279.size] = player;
    }

    self.playersininnerradius = _id_E5DAB4F107F3A279;
  }
}

wp_removeplayerfromallstatusradiuslists(type, _id_9D90C26327E3EACD) {
  if(type == "smoke") {
    foreach(_id_B16682794BB72308 in level.activewpzones) {
      if(wp_isinwpzone(type, _id_9D90C26327E3EACD, _id_B16682794BB72308))
        _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD);
    }
  } else {
    foreach(_id_B16682794BB72308 in level.activewpinnerzones) {
      if(wp_isinwpzone(type, _id_9D90C26327E3EACD, _id_B16682794BB72308))
        _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist(type, _id_9D90C26327E3EACD);
    }
  }
}

wp_startdisorientplayeronspawn(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    _id_B16682794BB72308 wp_addplayertostatusradiuslist("smoke", self);
    thread wp_startdisorientplayer(_id_B16682794BB72308);
  }
}

wp_startdisorientplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self.wpdisorient = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing")
    waitframe();

  thread wp_stopdisorientonplayerdeath(_id_B16682794BB72308);
  thread wp_monitorsmokevisionset(_id_B16682794BB72308);
  playfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == _id_B16682794BB72308.team || self == _id_B16682794BB72308.owner) {
    _id_13E20722A28D1047 = 1;

    if(istrue(_id_13E20722A28D1047))
      return;
  }

  self.wphealthblock = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");

  if(self.health > 10) {
    _id_FEAB9FA3A5844D2D = wp_gethealthdebuffamount();
    wp_degenhealth(_id_FEAB9FA3A5844D2D, _id_B16682794BB72308);
  }

  if(!wp_hasresistperk())
    enableloopingcoughaudio();
}

wp_degenhealth(_id_C3770DC539016800, _id_B16682794BB72308) {
  if(istrue(self.gasmaskequipped)) {
    return;
  }
  if(!isDefined(self.wphealthblock)) {
    self.wphealthblock = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  self dodamage(_id_C3770DC539016800, self.origin, _id_B16682794BB72308.owner, _id_B16682794BB72308, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
}

wp_startdofshiftforplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self.wpdisorient))
    wait(randomfloatrange(1, 3));
}

wp_stopdisorientonplayerdeath(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  wp_stopdisorientplayer(_id_B16682794BB72308, 1);
}

wp_stopdisorientplayer(_id_B16682794BB72308, _id_FB8011C41299D291) {
  level endon("game_ended");

  if(istrue(_id_FB8011C41299D291))
    level wp_removeplayerfromallstatusradiuslists("smoke", self);
  else
    _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("smoke", self);

  if(!wp_isinanywpzone("smoke", self) || istrue(_id_FB8011C41299D291)) {
    if(istrue(self.wpdisorient)) {
      self.wpdisorient = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive())
        self visionsetnakedforplayer("", 2);

      stopfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self.wphealthblock)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_block_health_regen");

        self.wphealthblock = undefined;
      }

      disableloopingcoughaudio();
      self notify("stop_disorient");
    }
  }
}

wp_startburnplayer(_id_B16682794BB72308, attacker) {
  _id_B16682794BB72308 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == _id_B16682794BB72308.team && self != _id_B16682794BB72308.owner) {
    _id_13E20722A28D1047 = 1;

    if(istrue(_id_13E20722A28D1047))
      return;
  }

  _id_B16682794BB72308 wp_addplayertostatusradiuslist("inner", self);
  self.wpburning = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](undefined, "wp_active");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", ::wp_playcorpsetableburningfx);

  thread wp_stopstatuseffectondeath(_id_B16682794BB72308);
  damage = 10;

  for(;;) {
    if(self.health <= damage)
      self notify("stop_degen");

    self dodamage(damage, self.origin, attacker, _id_B16682794BB72308, "MOD_FIRE", _id_B16682794BB72308.weapon_name);
    wait 0.5;
    damage++;

    if(damage >= 20)
      damage = 20;

    self.lastburntime = gettime();
  }
}

wp_stopburnplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    self notify("stop_wp_burn");
  }
}

wp_startblindplayer(_id_B16682794BB72308) {
  if(level.teambased && self.team == _id_B16682794BB72308.team || self == _id_B16682794BB72308.owner) {
    _id_13E20722A28D1047 = 1;

    if(istrue(_id_13E20722A28D1047))
      return;
  }

  _id_B16682794BB72308 wp_addplayertostatusradiuslist("inner", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(_id_B16682794BB72308);
  self visionsetnakedforplayer("wp_flare", 1);
}

wp_stopblindplayer(_id_B16682794BB72308) {
  _id_B16682794BB72308 wp_removeplayerfromstatusradiuslist("inner", self);

  if(!wp_isinanywpzone("inner", self))
    wp_resetstatuseffect();
}

wp_stopstatuseffectondeath(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  wp_resetstatuseffect(1);
}

wp_resetstatuseffect(_id_2E501FC7D257CE57) {
  if(istrue(self.wpburning)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](undefined, "wp_active");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("white_phosphorus_burning");
    }

    self.wpburning = undefined;
  }

  if(istrue(self.wpblinding)) {
    self.wpblinding = undefined;

    if(wp_isinanywpzone("smoke", self))
      self visionsetnakedforplayer(wp_getsmokevisionset(), 1);
    else
      self visionsetnakedforplayer("", 1);
  }

  if(istrue(_id_2E501FC7D257CE57))
    level wp_removeplayerfromallstatusradiuslists("inner", self);
}

wp_removeplane(plane) {
  if(isDefined(plane.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);

    plane.minimapid = undefined;
  }

  plane delete();
}

wp_getsmokevisionset() {
  _id_6D2B74CDE33B53F3 = "wp_smoke";
  _id_ED475FCA5FF8E567 = "wp_smoke_night";
  _id_AA76958057A61022 = _id_6D2B74CDE33B53F3;

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    _id_AA76958057A61022 = _id_ED475FCA5FF8E567;

  return _id_AA76958057A61022;
}

wp_monitorsmokevisionset(_id_B16682794BB72308) {
  _id_B16682794BB72308 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  _id_98E6B3F49203EB6C = undefined;

  for(;;) {
    if(istrue(self.wpdisorient)) {
      _id_878793DF599F2F06 = wp_getsmokevisionset();

      if(!isDefined(_id_98E6B3F49203EB6C) || _id_878793DF599F2F06 != _id_98E6B3F49203EB6C) {
        _id_98E6B3F49203EB6C = _id_878793DF599F2F06;
        self visionsetnakedforplayer(_id_878793DF599F2F06, 2);
      }
    }

    waitframe();
  }
}

wp_gethealthdebuffamount() {
  _id_FEAB9FA3A5844D2D = 50;

  if(wp_hasresistperk())
    _id_FEAB9FA3A5844D2D = _id_FEAB9FA3A5844D2D * 0.5;

  _id_A51512C2048AB572 = self.health;
  _id_D6C240915742C3A9 = _id_A51512C2048AB572 - _id_FEAB9FA3A5844D2D;

  if(_id_D6C240915742C3A9 < 10)
    _id_FEAB9FA3A5844D2D = _id_FEAB9FA3A5844D2D - (10 - _id_D6C240915742C3A9);

  return _id_FEAB9FA3A5844D2D;
}

wp_playcorpsetableburningfx(_id_3741EA5B9FB53EC3) {
  _id_3741EA5B9FB53EC3 setscriptablepartstate("wp_burning", "flareUp", 0);
}

wp_hasresistperk() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_tac_resist"]);
}

enableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio))
    self.loopingcoughaudio = 0;

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1)
    thread startloopingcoughaudio();
}

disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }
  self.loopingcoughaudio--;

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
  }
}

startloopingcoughaudio() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  for(;;) {
    waittime = randomfloatrange(5, 7);

    if(!loopingcoughaudioissupressed()) {
      soundalias = "generic_cough_3_enemy_1";

      if(self.team == "allies") {
        if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
          _id_BF9336BF707FA7CA = game["dialogue"]["allies_female_cough"].size;
          _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
          soundalias = game["dialogue"]["allies_female_cough"][_id_D337CAA5F4D5A1BF];
        } else {
          _id_BF9336BF707FA7CA = game["dialogue"]["allies_male_cough"].size;
          _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
          soundalias = game["dialogue"]["allies_male_cough"][_id_D337CAA5F4D5A1BF];
        }
      } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
        _id_BF9336BF707FA7CA = game["dialogue"]["axis_female_cough"].size;
        _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
        soundalias = game["dialogue"]["axis_female_cough"][_id_D337CAA5F4D5A1BF];
      } else {
        _id_BF9336BF707FA7CA = game["dialogue"]["axis_male_cough"].size;
        _id_D337CAA5F4D5A1BF = randomint(_id_BF9336BF707FA7CA);
        soundalias = game["dialogue"]["axis_male_cough"][_id_D337CAA5F4D5A1BF];
      }

      if(!isai(self))
        self playsoundtoplayer("gas_player_cough", self, self);

      self playsoundonmovingent(soundalias);
    }

    wait(waittime);
  }
}

stoploopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
}

enableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression))
    self.loopingcoughaudiosupression = 0;

  self.loopingcoughaudiosupression++;
}

disableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    return;
  }
  self.loopingcoughaudiosupression--;
}

loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

clearloopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
  self.loopingcoughaudio = undefined;
  self.loopingcoughaudiosupression = undefined;
}

wp_playimpactsound(_id_6B5D366F98BA252B) {
  _id_6B5D366F98BA252B setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  _id_6B5D366F98BA252B setscriptablepartstate("impact_center", "off", 0);
}