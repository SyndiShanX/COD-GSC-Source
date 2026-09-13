/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\white_phosphorus_cp.gsc
**********************************************************/

init_cp() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "startMapSelectSequence", ::white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getSelectMapPointOverride", ::white_phosphorus_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getPayloadLifetimeOverride", ::_id_46E7F98E192FBDC0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "getWpSpawnTypeOverride", ::_id_8C037649DF6E0DBB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("white_phosphorus", "fullMapCoverageOverride", ::_id_EDF70F6C660533E4);
}

white_phosphorus_startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3, _id_3922786267CCC2A8) {
  scripts\cp\cp_mapselect::startmapselectsequence(_id_FB5BCF10CCC2C5DF, _id_EDC5BB5A4B3DD2FF, _id_7426E996C9EB34D3);
}

white_phosphorus_getmapselectpoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF) {
  return scripts\cp\cp_mapselect::getselectmappoint(streakinfo, _id_CDCE0F8BE900C487, _id_EDC5BB5A4B3DD2FF);
}

_id_46E7F98E192FBDC0() {
  return 666;
}

_id_8C037649DF6E0DBB() {
  return 0;
}

_id_EDF70F6C660533E4() {
  return 0;
}

_id_FDD632F9B632A879(mappointinfo) {
  foreach(_id_47B05A700340406E, _id_470C049A636DB53D in mappointinfo) {
    _id_0B21E2E887C161B9 = _id_470C049A636DB53D.location;
    _id_A4521BB88F4EB389 = _id_470C049A636DB53D.angles;
    streakinfo = _id_470C049A636DB53D.streakinfo;
    owner = _id_470C049A636DB53D.owner;
    owner _id_265F3028E0EAAF1A(_id_0B21E2E887C161B9, _id_A4521BB88F4EB389, streakinfo);

    if(mappointinfo.size > 1 && _id_47B05A700340406E < mappointinfo.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

_id_094C8D7F1EF06C92(_id_0C29D6830464CAD8, _id_373A9C97CC32A2F9, streakinfo) {
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
  self linkTo(plane);
  plane.owner = self;
  plane.team = "axis";
  plane.streakinfo = streakinfo;
  plane.speed = _id_23122E7B902F2EA9;
  planemodel = "veh8_mil_air_suniform25";
  plane setModel(planemodel);
  minimapid = undefined;
  _id_68E354FCEB08D97B = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    _id_68E354FCEB08D97B = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");

  if(isDefined(_id_68E354FCEB08D97B)) {
    minimapid = plane[[_id_68E354FCEB08D97B]]("icon_minimap_wp", plane.team, 1, 1, 1);
    plane.minimapid = minimapid;
  }

  return plane;
}

_id_265F3028E0EAAF1A(_id_76A22C18960F72AF, _id_AE3D7191A8C7CBA9, streakinfo) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  _id_83C2AB15F0A8B72C = _id_094C8D7F1EF06C92(_id_76A22C18960F72AF, _id_AE3D7191A8C7CBA9, streakinfo);

  if(!isDefined(_id_83C2AB15F0A8B72C))
    return 0;

  _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_watchplanedisowned();
  _id_83C2AB15F0A8B72C thread scripts\cp_mp\killstreaks\white_phosphorus::wp_deliverpayloads(streakinfo);
}