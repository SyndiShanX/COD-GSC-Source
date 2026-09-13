/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_extraction.gsc
***********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "extract") {
    return;
  }
  init();
}

init() {
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("circle");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("littleBirdSpawns");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");
  _id_362C58E8BB39BCDA::disablefeature("kiosk");
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", 120);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("postPlunder", ::playerpostsetplunder);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isValidSpectateTarget", ::isvalidspectatetarget);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
  level.brgametype.maxextractions = getdvarint("dvar_B6A790D232323E81", 5);
  level.brgametype.numextractions = 0;
  level.brgametype.firstteam = "tie";
  thread initpostmain();
}

initpostmain() {
  waittillframeend;
  scripts\mp\flags::gameflaginit("collect_done", 0);
  scripts\mp\flags::gameflaginit("helipad_wait_done", 0);
  level.modemayconsiderplayerdead = ::brmayconsiderplayerdead;
  thread setupmission();
  thread setupextractionsites();
  thread setupteamplunderhud();
  thread setupextractnumhud();
  thread setuptimelimit();
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_extract_welcome");
}

spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

getdropbagdelay() {}

brmayconsiderplayerdead(player) {
  if(!spawnhandled(player))
    return 1;

  player thread playerrespawn();
  return 1;
}

playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");
  _id_80365E25F6E3BEFD = 1.0;
  wait(_id_80365E25F6E3BEFD);
  _id_30839284ADD41CED = getdvarint("dvar_5639A8F49B94DACB", 20);

  if(_id_30839284ADD41CED > 0) {
    _id_9F83FCC7A160F4E6 = 70;
    _id_ECF4E1D902A24C73 = 30;
    _id_3DF4BEDD0C10E4FD = 4;
    _id_FFA1576A392BCEEC = -4;
    scripts\mp\playerlogic::respawn_asspectator(self.origin, self.angles);
    _id_885448F843AA6AA3 = scripts\mp\hud_util::createfontstring("hudsmall", 1.0);
    _id_885448F843AA6AA3 scripts\mp\hud_util::setpoint("RIGHT", "CENTER", _id_ECF4E1D902A24C73 + _id_FFA1576A392BCEEC, _id_9F83FCC7A160F4E6);
    _id_885448F843AA6AA3.label = &"MP/WAITING_TO_SPAWN";
    _id_32E699637BC9C0BB = scripts\mp\hud_util::createtimer("hudsmall", 1.0);
    _id_32E699637BC9C0BB scripts\mp\hud_util::setpoint("LEFT", "CENTER", _id_ECF4E1D902A24C73 + _id_3DF4BEDD0C10E4FD, _id_9F83FCC7A160F4E6);
    _id_32E699637BC9C0BB settimer(_id_30839284ADD41CED);
    scripts\engine\utility::waittill_notify_or_timeout("teamExtractedSpawnSpectate", _id_30839284ADD41CED);
    _id_32E699637BC9C0BB destroy();
    _id_885448F843AA6AA3 destroy();
  }

  if(_id_5BAB271917698DC4::isteamextracted(self.team)) {
    return;
  }
  _id_B59F471C2C064E56 = 1.0;
  thread _id_5BAB271917698DC4::fadeoutin(_id_B59F471C2C064E56);
  wait(_id_B59F471C2C064E56);

  if(_id_5BAB271917698DC4::isteamextracted(self.team)) {
    return;
  }
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  thread _id_5BAB271917698DC4::triggerrespawnoverlay(4);
  _id_67708F418B1FAC79::gulagwinnerrespawn(1);
}

playershouldrespawn(data) {
  return 1;
}

isvalidspectatetarget(player) {
  return !_id_5BAB271917698DC4::isteamextracted(player.team);
}

setupmission() {
  level.brgametype.extractposition = getextractionposition();
  thread makeextractionobjective();
}

getextractionposition() {
  _id_4BF102A2E23C6C84 = 2500;
  centerpt = level.br_level.br_mapcenter;
  _id_D8235976EA87D0D2 = (0, randomfloatrange(0, 360), 0);
  pathdir = anglesToForward(_id_D8235976EA87D0D2);
  _id_5619B7BBC3745888 = level.br_level.br_circleradii[0] * 2;
  endpt = centerpt + pathdir * _id_5619B7BBC3745888;
  endpt = _id_45B2B4A889E633FA::snappointtooutofboundstriggertrace(centerpt, endpt);
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  start = (endpt[0], endpt[1], _id_5FA1E1697A302583.origin[2]);
  _id_AA5A7071F7A4C106 = tracegroundpoint(start);
  endpt = _id_AA5A7071F7A4C106 + (0, 0, _id_4BF102A2E23C6C84);
  return endpt;
}

makeextractionobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.brgametype.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", level.brgametype.extractposition, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  }
}

setupmissionwidget() {
  scripts\mp\flags::gameflagwait("prematch_done");
  xp = getcurrentxp();
  _id_2F55781AF96F22F9 = _id_64ACB6CE534155B7::getquesttableindex("gt_extract_1");

  foreach(player in level.players) {
    player _id_64ACB6CE534155B7::setquestindexomnvar(_id_2F55781AF96F22F9);
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(xp);
  }
}

getcurrentxp() {
  xp = getdvarint("dvar_911E056FAB287A06", 5000);
  _id_01483BA069EB69DB = getdvarint("dvar_728F3C5D729A3F2D", 2000);
  _id_3AF7B46CFD065EBD = getdvarint("dvar_802CC155C089E133", 200);

  if(_id_01483BA069EB69DB > 0)
    xp = int(max(_id_01483BA069EB69DB, xp - level.brgametype.numextractions * _id_3AF7B46CFD065EBD));

  return xp;
}

showextractionobjectivetoteam(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.brgametype.objectiveiconid, player);
}

hideextractionobjectivefromteam(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.brgametype.objectiveiconid, player);
}

helidrivablethink() {
  self endon("death");
  self endon("missionComplete");
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = objectiveiconid;
  thread helidrivabledeathall();

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", (0, 0, 0), "ui_mp_br_mapmenu_legend_littlebird");
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveiconid, 100);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  }

  for(;;) {
    while(self.occupants.size == 0 || !isDefined(self.ownerteam))
      waitframe();

    team = self.ownerteam;
    showextractionobjectivetoteam(team);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(objectiveiconid, team);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
    thread helidrivablemission(self.ownerteam);
    thread helidrivabledeath(self.ownerteam);

    while(self.occupants.size > 0)
      waitframe();

    hideextractionobjectivefromteam(team);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(objectiveiconid, undefined);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
    self notify("heliDrivableSwitchTeams");
  }
}

helidrivabledeathall() {
  level endon("game_ended");
  self endon("missionComplete");
  self waittill("death");
  thread drophelicrate(self);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

helidrivablemission(team) {
  level endon("game_ended");
  self endon("death");
  self endon("heliDrivableSwitchTeams");
  _id_51019BAF172A636C = 90000;

  for(;;) {
    distsq = distance2dsquared(self.origin, level.brgametype.extractposition);

    if(distsq < _id_51019BAF172A636C) {
      if(level.brgametype.numextractions == 0)
        level.brgametype.firstteam = team;

      teamextractedvictory(team, self);

      if(level.brgametype.maxextractions > 0 && level.brgametype.numextractions >= level.brgametype.maxextractions)
        thread brendgame();

      break;
    }

    waitframe();
  }
}

helidrivabledeath(team) {
  level endon("game_ended");
  self endon("heliDrivableSwitchTeams");
  self waittill("death");
  hideextractionobjectivefromteam(team);
}

doteamextractedupdate() {
  level.brgametype.numextractions++;
  level.brgametype.hudextractnum setvalue(level.brgametype.numextractions);
  level.brgametype.hudextractnum thread huddopulse();
  level.brgametype.hudextractmax thread huddopulse();
  cost = getcost();
  level.brgametype.hudcost setvalue(cost * 10);

  foreach(_id_F90358454413407F, teamdata in level.teamdata) {
    if(isDefined(teamdata["teamCount"]) && teamdata["teamCount"] > 0)
      updateteamplunderhud(_id_F90358454413407F);
  }

  xp = getcurrentxp();

  foreach(player in level.players) {
    if(!_id_5BAB271917698DC4::isteamextracted(player.team)) {
      player thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      player _id_64ACB6CE534155B7::uiobjectivesetparameter(xp);
    }
  }
}

teamextractedvictory(team, heli) {
  level endon("game_ended");
  _id_5BAB271917698DC4::setteamasextracted(team);
  scripts\mp\outofbounds::enableoobimmunity(self);
  hideextractionobjectivefromteam(team);

  if(isDefined(heli)) {
    heli notify("missionComplete");
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(heli.objectiveiconid);
    scripts\mp\objidpoolmanager::returnobjectiveid(heli.objectiveiconid);
  }

  _id_2CEDCC356F1B9FC8::brleaderdialogteam("team_victory", team);
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player _id_1E4A61DB11011446::calculatebrbonusxp(1);
    player _id_64ACB6CE534155B7::uiobjectivehide();
    player setclientomnvar("post_game_state", 9);
    player setclientomnvar("ui_br_end_game_splash_type", 1);
    scripts\mp\outofbounds::enableoobimmunity(player);
    player.spawnprotection = 1;
  }

  doteamextractedupdate();
  thread teamextractedspawnspectate(team, heli);
}

teamextractedspawnspectate(team, heli) {
  wait 2;
  data = spawnStruct();

  if(isDefined(heli))
    data.origin = heli.origin;
  else
    data.origin = (0, 0, 0);

  data.angles = (0, 0, 0);
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    player setclientomnvar("post_game_state", 0);
    player setclientomnvar("ui_br_end_game_splash_type", -1);
    player notify("teamExtractedSpawnSpectate");
    player thread _id_6489FCDFE6FA2E36::spawnspectator(data, 1, 1);
  }

  if(isDefined(heli))
    heli delete();
}

brendgame() {
  wait 1.5;
  handleendgamesplash();
  scripts\mp\gamelogic::endgame_regularmp(level.brgametype.firstteam, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

handleendgamesplash() {
  foreach(player in level.players) {
    if(!_id_5BAB271917698DC4::isteamextracted(player.team))
      player setclientomnvar("post_game_state", 2);
  }
}

setuptimelimit() {
  level endon("game_ended");
  _id_B0FCA93213E625C7 = 120;
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled))
    level waittill("br_ready_to_jump");

  waitframe();
  _id_ABF148B8B3FE55C6 = createhudelem(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  _id_ABF148B8B3FE55C6.alpha = 1;
  timerhud = scripts\mp\hud_util::createservertimer("default", 1.5);
  timerhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  _id_D7DAA4EEE8E4BD3C = getdvarint("dvar_A718BF7355E667A3", 180);

  if(_id_D7DAA4EEE8E4BD3C > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_D7DAA4EEE8E4BD3C * 1000));
    timerhud settimer(_id_D7DAA4EEE8E4BD3C);
    wait(_id_D7DAA4EEE8E4BD3C);
  }

  scripts\mp\flags::gameflagset("collect_done");
  _id_532C835E523EF572 = getdvarint("dvar_9FD551B851144F28", 180);

  if(_id_532C835E523EF572 > 0) {
    _id_ABF148B8B3FE55C6.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    _id_ABF148B8B3FE55C6 thread huddopulse();
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_532C835E523EF572 * 1000));
    timerhud settimer(_id_532C835E523EF572);
    wait(_id_532C835E523EF572);
  }

  scripts\mp\flags::gameflagset("helipad_wait_done");
  _id_F8DD42F6BC48954B = getdvarint("dvar_DB683ED24A430594", 840);
  _id_ABF148B8B3FE55C6.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  _id_ABF148B8B3FE55C6 thread huddopulse();
  setomnvar("ui_hardpoint_timer", gettime() + int(_id_F8DD42F6BC48954B * 1000));
  timerhud settimer(_id_F8DD42F6BC48954B);
  _id_0098EE5131DA5693 = max(_id_F8DD42F6BC48954B - _id_B0FCA93213E625C7, 0);
  wait(_id_0098EE5131DA5693);
  _id_8DD9F2EB8215A139 = max(_id_F8DD42F6BC48954B - _id_0098EE5131DA5693, 0);
  timerhud.color = (1, 0, 0);
  timerhud thread huddopulse();
  thread clocksounds(_id_8DD9F2EB8215A139);
  wait(_id_8DD9F2EB8215A139);
  timerhud destroy();
  thread brendgame();
}

clocksounds(_id_8DD9F2EB8215A139) {
  level endon("game_ended");

  if(!isDefined(_id_8DD9F2EB8215A139)) {
    return;
  }
  while(_id_8DD9F2EB8215A139 > 0) {
    dosound = 0;
    _id_14CCD6E81FCE3BD4 = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);

    if(_id_8DD9F2EB8215A139 > 60 && _id_8DD9F2EB8215A139 % 10 == 0 || _id_8DD9F2EB8215A139 <= 60 && _id_8DD9F2EB8215A139 > 30 && _id_8DD9F2EB8215A139 % 2 == 0 || _id_8DD9F2EB8215A139 <= 30)
      dosound = 1;

    if(dosound) {
      foreach(player in level.players)
      player playlocalsound(_id_14CCD6E81FCE3BD4);
    }

    _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - 1;
    wait 1;
  }
}

setupextractnumhud() {
  _id_388F7C8FBB90400D = -120;
  _id_D1F0E5189F1576D0 = -170;
  _id_B4C134E149B2E70B = 2;
  _id_D2C8C88F6FF982FA = -2;
  level.brgametype.hudextractnum = createhudelem(&"MP_BR_INGAME/EXTRACT_NUM", 0, "RIGHT", "CENTER", _id_388F7C8FBB90400D + _id_D2C8C88F6FF982FA, _id_D1F0E5189F1576D0, (0, 1, 0));
  level.brgametype.hudextractmax = createhudelem(&"MP_BR_INGAME/EXTRACT_MAX", level.brgametype.maxextractions, "LEFT", "CENTER", _id_388F7C8FBB90400D + _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0, (0, 1, 0));
  scripts\mp\flags::gameflagwait("helipad_wait_done");
  level.brgametype.hudextractnum.alpha = 1;

  if(level.brgametype.maxextractions > 0)
    level.brgametype.hudextractmax.alpha = 1;
}

setupteamplunderhud() {
  _id_D1F0E5189F1576D0 = 145;
  _id_A1CA4DAA7621C02F = 20;
  _id_B4C134E149B2E70B = -3;
  _id_D2C8C88F6FF982FA = 3;
  cost = getcost();
  level.brgametype.hudcoststring = createhudelem(&"MP_BR_INGAME/EXTRACT_COST_TEXT", undefined, "LEFT", "CENTER", _id_D2C8C88F6FF982FA, _id_D1F0E5189F1576D0);
  level.brgametype.hudcost = createhudelem(&"MP_BR_INGAME/EXTRACT_COST", cost * 10, "LEFT", "CENTER", _id_D2C8C88F6FF982FA, _id_D1F0E5189F1576D0 + _id_A1CA4DAA7621C02F);
  level.brgametype.hudplunderstring = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0);

  foreach(team in level.teamnamelist) {
    _id_6CBD49DBEF63E930 = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0 + _id_A1CA4DAA7621C02F, (1, 0, 0), team);
    setteamplunderhud(team, _id_6CBD49DBEF63E930);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled))
    level waittill("br_ready_to_jump");

  level.brgametype.hudcoststring.alpha = 1;
  level.brgametype.hudcost.alpha = 1;
  level.brgametype.hudplunderstring.alpha = 1;

  foreach(team in level.teamnamelist) {
    _id_6CBD49DBEF63E930 = getteamplunderhud(team);
    _id_6CBD49DBEF63E930.alpha = 1;
  }
}

setteamplunderhud(team, _id_94480E1669B7FF0D) {
  level.teamdata[team]["hudPlunder"] = _id_94480E1669B7FF0D;
  _id_94480E1669B7FF0D.plundercount = 0;
  _id_94480E1669B7FF0D.plundercountroll = 0;
}

getteamplunderhud(team) {
  return level.teamdata[team]["hudPlunder"];
}

createhudelem(label, value, point, relativepoint, xoffset, yoffset, color, team) {
  fontscale = 1.5;

  if(isDefined(team))
    _id_372B658AEA9D2487 = newteamhudelem(team);
  else
    _id_372B658AEA9D2487 = newhudelem();

  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = "default";
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.alpha = 0;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label))
    _id_372B658AEA9D2487.label = label;

  if(isDefined(value))
    _id_372B658AEA9D2487 setvalue(value);

  if(isDefined(color))
    _id_372B658AEA9D2487.color = color;

  return _id_372B658AEA9D2487;
}

getteamplunder(team) {
  plundercount = 0;
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player.plundercount))
      plundercount = plundercount + player.plundercount;

    if(isDefined(player.plunderbanked))
      plundercount = plundercount + player.plunderbanked;
  }

  return plundercount;
}

playerpostsetplunder(data) {
  plundercount = getteamplunder(self.team);
  _id_6CBD49DBEF63E930 = getteamplunderhud(self.team);
  _id_6CBD49DBEF63E930.plundercount = plundercount;
  thread dohudplunderroll(_id_6CBD49DBEF63E930, self.team);
}

dohudplunderroll(_id_6CBD49DBEF63E930, team) {
  _id_6CBD49DBEF63E930 notify("doHudPlunderRoll");
  _id_6CBD49DBEF63E930 endon("doHudPlunderRoll");
  _id_954D3E623B8A228F = 2.0;
  target = _id_6CBD49DBEF63E930.plundercount * 10;
  _id_4573A8725DD3748E = target - _id_6CBD49DBEF63E930.plundercountroll;
  sign = scripts\engine\utility::sign(_id_4573A8725DD3748E);
  _id_B749E3228EC71E90 = _id_4573A8725DD3748E / _id_954D3E623B8A228F;
  _id_585AAE66E20728C4 = int(_id_B749E3228EC71E90 * level.framedurationseconds);

  if(_id_585AAE66E20728C4 == 0) {
    return;
  }
  dohudplunderrollsound(sign, team);
  cost = getcost() * 10;
  _id_0185DD83D3835DE3 = sign > 0 && _id_6CBD49DBEF63E930.plundercountroll > cost;
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  while(_id_6CBD49DBEF63E930.plundercountroll != target) {
    if(!_id_0185DD83D3835DE3 && (sign > 0 && _id_6CBD49DBEF63E930.plundercountroll + _id_585AAE66E20728C4 >= cost)) {
      _id_0185DD83D3835DE3 = 1;

      foreach(player in _id_6D5ED003AF1F9612)
      player playlocalsound("br_plunder_atm_deposit_gtr");

      _id_6CBD49DBEF63E930.color = (0, 1, 0);
      thread dohudplunderpulse(team);
    }

    if(sign < 0 && _id_6CBD49DBEF63E930.plundercountroll < cost && _id_6CBD49DBEF63E930.color != (1, 0, 0))
      _id_6CBD49DBEF63E930.color = (1, 0, 0);

    _id_6CBD49DBEF63E930.plundercountroll = _id_6CBD49DBEF63E930.plundercountroll + _id_585AAE66E20728C4;

    if(sign > 0 && _id_6CBD49DBEF63E930.plundercountroll > target || sign < 0 && _id_6CBD49DBEF63E930.plundercountroll < target)
      _id_6CBD49DBEF63E930.plundercountroll = target;

    _id_6CBD49DBEF63E930 setvalue(_id_6CBD49DBEF63E930.plundercountroll);
    wait(level.framedurationseconds);
  }

  foreach(player in _id_6D5ED003AF1F9612) {
    player.hudplunderstart = undefined;
    player stoplocalsound("br_plunder_atm_use");
  }
}

updateteamplunderhud(team) {
  _id_6CBD49DBEF63E930 = getteamplunderhud(team);
  plundercount = getteamplunder(team);
  cost = getcost();

  if(plundercount >= cost && _id_6CBD49DBEF63E930.color != (0, 1, 0)) {
    _id_6CBD49DBEF63E930.color = (0, 1, 0);
    _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

    foreach(player in _id_6D5ED003AF1F9612)
    player playlocalsound("br_plunder_atm_deposit_gtr");
  }
}

dohudplunderrollsound(sign, team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(sign > 0) {
      if(isDefined(player.hudplunderstart)) {
        duration = gettime() - player.hudplunderstart;

        if(duration <= 6000) {
          break;
        }
      }

      player.hudplunderstart = gettime();

      if(isalive(player))
        player playlocalsound("br_plunder_atm_use");

      continue;
    }

    player.hudplunderstart = undefined;
    player stoplocalsound("br_plunder_atm_use");
  }
}

playerdropplunderondeath(dropstruct, attacker) {
  _id_6AEE9C9054F09ED5 = int(self.plundercount * 0.5);
  _id_B64F283113C99581 = self.plundercount - _id_6AEE9C9054F09ED5;

  if(_id_B64F283113C99581 <= 0)
    _id_B64F283113C99581 = 1;

  self.plundercountondeath = _id_6AEE9C9054F09ED5;
  _id_6AFF3948CF4CCA03::playersetplundercount(_id_6AEE9C9054F09ED5);
  dropplunderbyrarity(_id_B64F283113C99581, dropstruct);
  return 1;
}

dropplunderbyrarity(amount, dropstruct) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_E05413A53B5D9167 = [];
  _id_E3232613C46AEB6B = [];
  _id_EE9DE3C34A771918 = 0;

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] = int(amount / level.br_plunder.quantity[_id_AC0E594AC96AA3A8]);
    _id_EE9DE3C34A771918 = _id_EE9DE3C34A771918 + _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8];

    if(amount <= 0) {
      break;
    } else
      amount = amount - _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] * level.br_plunder.quantity[_id_AC0E594AC96AA3A8];
  }

  for(_id_F90D0E006A1F717B = level.br_plunder.quantity.size - 1; _id_F90D0E006A1F717B >= 0; _id_F90D0E006A1F717B--) {
    if(!isDefined(_id_E3232613C46AEB6B[_id_F90D0E006A1F717B])) {
      continue;
    }
    for(_id_3793828403C6873E = 0; _id_3793828403C6873E < _id_E3232613C46AEB6B[_id_F90D0E006A1F717B]; _id_3793828403C6873E++) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      pickupent = _id_7E52B56769FA7774::spawnpickup(level.br_plunder.names[_id_F90D0E006A1F717B], _id_CB4FAD49263E20C4, level.br_plunder.quantity[_id_F90D0E006A1F717B], 1);
      _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld(level.br_plunder.names[_id_F90D0E006A1F717B], 1);

      if(isDefined(pickupent)) {
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = pickupent;

        if(_id_6AFF3948CF4CCA03::inplunderlivelobby())
          level.br_plunder_ents[level.br_plunder_ents.size] = pickupent;
      }
    }
  }

  level.br_plunder.plunder_items_dropped = level.br_plunder.plunder_items_dropped + _id_EE9DE3C34A771918;
  level.br_plunder.plunder_value_dropped = level.br_plunder.plunder_value_dropped + amount;
  level thread _id_6AFF3948CF4CCA03::dropplundersounds(self.origin, _id_E05413A53B5D9167.size);
  return _id_E05413A53B5D9167;
}

setupextractionsites() {
  level.brgametype.sites = getextractionsites();

  foreach(site in level.brgametype.sites)
  site setscriptablepartstate(site.type, site.disabledstate);

  scripts\mp\flags::gameflagwait("prematch_done");
  level.brgametype.maxnumsites = getdvarint("dvar_07785B8AAA2BC58F", 8);
  level.brgametype.scalesitesbyteams = getdvarfloat("dvar_50C01DA1BEB57CA3", 0.16);

  if(level.brgametype.scalesitesbyteams > 0) {
    _id_652F47620AC4713F = scripts\mp\teams::_id_14A6F65E85694C21();
    level.brgametype.maxnumsites = int(ceil(level.brgametype.scalesitesbyteams * _id_652F47620AC4713F));
  }

  if(level.brgametype.sites.size < level.brgametype.maxnumsites)
    level.brgametype.maxnumsites = level.brgametype.sites.size;
  else
    level.brgametype.sites = scripts\engine\utility::array_sort_with_func(level.brgametype.sites, ::sortsitesbydistance);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype.sites.size; _id_AC0E594AC96AA3A8++) {
    site = level.brgametype.sites[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 >= level.brgametype.maxnumsites)
      site setscriptablepartstate(site.type, "hidden");
  }

  scripts\mp\flags::gameflagwait("collect_done");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype.sites.size; _id_AC0E594AC96AA3A8++) {
    site = level.brgametype.sites[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 < level.brgametype.maxnumsites)
      site setscriptablepartstate(site.type, site.visible2state);
  }

  scripts\mp\flags::gameflagwait("helipad_wait_done");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype.sites.size; _id_AC0E594AC96AA3A8++) {
    site = level.brgametype.sites[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 < level.brgametype.maxnumsites)
      site setscriptablepartstate(site.type, site.activestate);
  }

  scripts\engine\scriptable::scriptable_addusedcallback(::siteused);
}

sortsitesbydistance(_id_6AF78C02631A8641, _id_6AF78902631A7FA8) {
  return distancesquared(_id_6AF78C02631A8641.origin, level.br_level.br_mapcenter) < distancesquared(_id_6AF78902631A7FA8.origin, level.br_level.br_mapcenter);
}

getextractionsites() {
  _id_6F1B16A6B8446C60 = getentitylessscriptablearray("plunder_extraction_01", "targetname");
  _id_6F1B19A6B84472F9 = getentitylessscriptablearray("plunder_extraction_02", "targetname");

  if(_id_6F1B16A6B8446C60.size > 0 || _id_6F1B19A6B84472F9.size > 0) {
    sites = scripts\engine\utility::array_combine(_id_6F1B16A6B8446C60, _id_6F1B19A6B84472F9);

    foreach(site in sites) {
      site.activestate = "active2";
      site.disabledstate = "visible";
      site.visible2state = "visible2";
    }

    return sites;
  } else {
    sites = getentitylessscriptablearray("plunder_extraction", "targetname");

    foreach(site in sites) {
      site.activestate = "visible";
      site.disabledstate = "hidden";
      site.visible2state = "visible";
    }

    return sites;
  }
}

getcost() {
  cost = getdvarint("dvar_5CB48FB038EC819F", 300);
  _id_611124CFC2779BF2 = getdvarint("dvar_02C2D8AE182CF1FC", 40);
  _id_43765697D8FC262D = getdvarint("dvar_27A4ECC9AA9F8224", 20);

  if(_id_611124CFC2779BF2 > 0)
    cost = int(max(_id_611124CFC2779BF2, cost - level.brgametype.numextractions * _id_43765697D8FC262D));

  return cost;
}

playertakeextractionplunder(amount) {
  if(self.plundercount < amount)
    amount = self.plundercount;

  if(!isDefined(self.plunderforextract))
    self.plunderforextract = 0;

  self.plunderforextract = self.plunderforextract + amount;
  _id_6AFF3948CF4CCA03::playersetplundercount(self.plundercount - amount);
  return amount;
}

teamclearextractplunder(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  player.plunderforextract = 0;
}

teamrefundplunder(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player.plunderforextract)) {
      player.plunderforextract = 0;
      player iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

taketeamplunder(team) {
  cost = getcost();
  _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];
  _id_9A96096BD3DB45FA = int(cost / _id_BCE4EFC75EB01319);
  _id_6D5ED003AF1F9612 = level.teamdata[team]["alivePlayers"];

  foreach(player in _id_6D5ED003AF1F9612) {
    amount = player playertakeextractionplunder(_id_9A96096BD3DB45FA);
    cost = cost - amount;
  }

  if(cost > 0) {
    foreach(player in _id_6D5ED003AF1F9612) {
      amount = player playertakeextractionplunder(cost);
      cost = cost - amount;

      if(cost <= 0) {
        break;
      }
    }
  }
}

siteused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance) || !isDefined(player)) {
    return;
  }
  if(part == "brloot_plunder_extraction_site_01" || part == "brloot_plunder_extraction_site_02" || part == "brloot_plunder_extraction_site") {
    count = getteamplunder(player.team);
    cost = getcost();

    if(count < cost) {
      thread dohudplunderpulse(player.team);
      player playlocalsound("br_pickup_deny");
      return;
    }

    taketeamplunder(player.team);
    _id_6D5ED003AF1F9612 = level.teamdata[player.team]["players"];

    foreach(player in _id_6D5ED003AF1F9612)
    player playlocalsound("br_plunder_atm_deposit_gtr");

    if(part == "brloot_plunder_extraction_site_01" || part == "brloot_plunder_extraction_site_02" || part == "brloot_plunder_extraction_site")
      thread siteusedinternal(instance, part, state, player);
  }
}

dohudplunderpulse(team) {
  _id_6CBD49DBEF63E930 = getteamplunderhud(team);
  _id_6CBD49DBEF63E930 huddopulse();
}

huddopulse() {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 4;
  self.pulsing = 1;
  _id_B96028986997E29C = self.fontscale;
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_5F2809F4E8852C13;
  wait(_id_CC2C2F3EAC3C7BD2);
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_B96028986997E29C;
  self.pulsing = undefined;
}

siteusedinternal(instance, part, state, player) {
  instance setscriptablepartstate(instance.type, "inuse2");
  _id_01230EA36A300368 = getgroundposition(instance.origin, 1) + (0, 0, 2);
  thread doextractionevent(instance, player, _id_01230EA36A300368);
}

doextractionevent(instance, player, _id_01230EA36A300368) {
  heli = player playerspawnextractchopper(_id_01230EA36A300368);

  if(isDefined(heli)) {
    spawndata = spawnStruct();
    spawndata.origin = _id_01230EA36A300368;
    spawndata.angles = heli.angles;
    spawndata.spawntype = "GAME_MODE";
    _id_EE8DA5624236DC89 = spawnStruct();
    helidrivable = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);

    if(isDefined(helidrivable)) {
      heli.site = instance;
      heli.helidrivable = helidrivable;
      helidrivable hide();
      heli helicreateextractvfx(_id_01230EA36A300368);
      thread extractplunder(heli);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_requested", player.team, 1);
      level thread _id_2CEDCC356F1B9FC8::brbroadcastplayercardsplash("br_gametype_extract_heli_incoming");
      return;
    }
  }

  player playerdenyextraction(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

  if(isDefined(instance))
    instance setscriptablepartstate(instance.type, instance.activestate);

  waitframe();

  if(isDefined(heli))
    heli delete();
}

heliextract_used(grenade) {
  self endon("death");
  self endon("disconnect");
  _id_06B62DB6EEC868E2 = grenade.weapon_object;
  grenade waittill("explode", position);

  if(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle())
    playerdenyextraction(_id_06B62DB6EEC868E2, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
  else {
    heli = playerspawnextractchopper(position);

    if(isDefined(heli)) {
      heli helicreateextractvfx(position);
      thread extractplunder(heli);
      return;
    }

    playerdenyextraction(_id_06B62DB6EEC868E2, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
  }
}

playerdenyextraction(_id_06B62DB6EEC868E2, _id_734564FF3D4FD467) {
  self iprintlnbold(_id_734564FF3D4FD467);
  self playlocalsound("br_pickup_deny");

  if(isDefined(_id_06B62DB6EEC868E2)) {
    ammo = self getweaponammoclip(_id_06B62DB6EEC868E2);
    self setweaponammoclip(_id_06B62DB6EEC868E2, ammo + 1);
  }
}

playerspawnextractchopper(position) {
  _id_26A6F862062E4340 = position;
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2] - 300;
  _id_0C2C23AB40723A8D = (_id_26A6F862062E4340[0], _id_26A6F862062E4340[1], _id_76AB620FD7CC70BD);
  angles = (0, randomfloat(360), 0);
  _id_16CEDB94FAF4D596 = _id_0C2C23AB40723A8D + -1 * anglesToForward(angles) * 30000;
  exitposition = _id_0C2C23AB40723A8D + anglesToForward(angles) * 30000;
  heli = spawnheli(self, _id_16CEDB94FAF4D596, _id_0C2C23AB40723A8D, exitposition);
  return heli;
}

drophelicrate(heli) {
  crate = spawn("script_model", heli.origin);
  crate setModel("military_skyhook_backpack");
  _id_D917428537562C1F = heli.origin;
  end = (_id_D917428537562C1F[0], _id_D917428537562C1F[1], -12000);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  trace = scripts\engine\trace::ray_trace(_id_D917428537562C1F, end, heli, contents);
  _id_01230EA36A300368 = trace["position"];
  dist = _id_D917428537562C1F[2] - _id_01230EA36A300368[2];

  if(dist > 0) {
    time = sqrt(2 * dist / 800);
    crate moveTo(_id_01230EA36A300368, time, time, 0);
    wait(time);
  }

  crate.origin = _id_01230EA36A300368;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact_ground"), _id_01230EA36A300368);
  crate cratedropplunder();
  crate delete();
}

cratedropplunder() {
  amount = getcost();
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_6AFF3948CF4CCA03::dropplunderbyrarity(amount, dropstruct);
}

calculatehelitimetoflysec(_id_C45865D4C48493C1, _id_88125F10D2B34AA3, _id_B2BDD90249635576) {
  _id_3D0EC1C05F1E1001 = _id_C45865D4C48493C1 * 0.0000157828;
  a = 0.5 * _id_B2BDD90249635576;
  b = _id_88125F10D2B34AA3;
  c = -1 * _id_3D0EC1C05F1E1001;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / (2 * a);
  flytime = flytime * 3600;
  flytime = flytime + 1.5;
  return flytime;
}

calculatehelitimetoarrive(_id_625180CE8D2F8F77) {
  _id_5301EBED8D610FDB = calculatehelitimetoflysec(30000, 100, 125);
  _id_EB0FAE3483A10D88 = calculatehelitimetoflysec(_id_625180CE8D2F8F77, 25.0, 31.25);
  totaltime = _id_5301EBED8D610FDB + _id_EB0FAE3483A10D88;
  return totaltime;
}

helisetteamextractionhud(state, _id_80B642A0F8C9659D) {
  _id_754110404C0D574F = gettime() + int(_id_80B642A0F8C9659D * 1000);
  _id_A6AB8D0FDA441DC2 = level.teamdata[self.team]["alivePlayers"];

  foreach(player in _id_A6AB8D0FDA441DC2) {
    player setclientomnvar("ui_br_plunder_extract_state", state);
    player setclientomnvar("ui_br_timed_feature_end_time", _id_754110404C0D574F);
  }
}

extractplunder(heli) {
  heli endon("death");
  heli endon("leaving");
  heli setvehgoalpos(heli.pathgoal, 1);
  heli settargetyaw(heli.goalyaw);
  groundz = heli tracegroundheight(heli.pathgoal);
  _id_625180CE8D2F8F77 = heli.pathgoal[2] - groundz;
  heli.flytime = calculatehelitimetoarrive(_id_625180CE8D2F8F77);
  heli helisetteamextractionhud(1, heli.flytime);
  heli waittill("goal");
  heli thread heliwatchgameendleave();
  heli thread helidisapateextractvfx();
  heli helidescend(heli.endpoint, groundz);
  level thread _id_2CEDCC356F1B9FC8::brbroadcastplayercardsplash("br_gametype_extract_heli_arrived");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_arrive", heli.team, 1);
  heli helicleanupextract(0);
  thread swaphelifordrivable(heli);
}

swaphelifordrivable(heli) {
  team = heli.team;
  site = heli.site;
  teamclearextractplunder(team);
  heli notify("swapped");
  helidrivable = heli.helidrivable;
  helidrivable.origin = heli.origin;
  helidrivable.angles = heli.angles;
  helidrivable show();
  heli delete();

  if(isDefined(site)) {
    helidrivable thread helidrivableenablesiteonflyaway(site);
    helidrivable thread helidrivableenablesiteondeath(site);
  }

  helidrivable thread helidrivablethink();
}

helidrivableenablesiteonflyaway(site) {
  level endon("game_ended");
  self endon("death");
  site endon("siteEnabled");
  _id_1CF7D97F7146E1F1 = 90000;

  for(;;) {
    distsq = distance2dsquared(self.origin, site.origin);

    if(distsq > _id_1CF7D97F7146E1F1) {
      break;
    }

    waitframe();
  }

  site setscriptablepartstate(site.type, site.activestate);
  site notify("siteEnabled");
}

helidrivableenablesiteondeath(site) {
  level endon("game_ended");
  site endon("siteEnabled");
  self waittill("death");
  site setscriptablepartstate(site.type, site.activestate);
}

helimakedepotwait() {
  self.isdepot = 1;
  self.usable = self.crate;
  usable = self.usable;
  usable makeusable();
  usable setCursorHint("HINT_NOICON");
  usable setuseholdduration("duration_medium");
  usable sethintrequiresholding(1);
  usable setuserange(230);
  usable setHintString(&"MP/BR_USE_PLUNDER_CACHE");
  _id_BDF913FBADCCE9A7 = level.br_depots.size;
  level.br_depots[_id_BDF913FBADCCE9A7] = usable;

  foreach(player in level.players) {
    if(!isDefined(player))
      continue;
  }

  thread helicleanupdepotonleaving();
  thread helidepotthink(usable);
  helisetteamextractionhud(2, 30);
  wait 30;
  self.isdepot = 0;
  heliusecleanup();
}

helidepotthink(usable) {
  self endon("death");
  usable endon("death");

  for(;;) {
    usable waittill("trigger", player);
    player playlocalsound("br_plunder_atm_deposit_gtr");
    helistoreplunder(player);
  }
}

helistoreplunder(player) {
  if(!isDefined(self.plunder))
    self.plunder = [];

  plundercount = player.plundercount;
  player _id_715028F54BAD19A1::branalytics_plunder_placed_into_extraction(player, "little_bird", self.origin, plundercount);
  _id_072F9C1E3DE407DC = 0;

  if(isDefined(self.plunder)) {
    foreach(_id_F936137416E0A530 in self.plunder) {
      if(isDefined(_id_F936137416E0A530.player) && _id_F936137416E0A530.player == player) {
        _id_F936137416E0A530.plundercount = _id_F936137416E0A530.plundercount + plundercount;
        _id_072F9C1E3DE407DC = 1;
        break;
      }
    }
  }

  if(!_id_072F9C1E3DE407DC) {
    _id_F936137416E0A530 = spawnStruct();
    _id_F936137416E0A530.player = player;
    _id_F936137416E0A530.team = player.team;
    _id_F936137416E0A530.plundercount = plundercount;
    self.plunder[self.plunder.size] = _id_F936137416E0A530;
  }
}

helibankplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_success", self.team, 1);
  _id_A8EEB94DCC610B78 = 0;
  _id_235F1174E9FAA6D2 = 0;

  foreach(item in self.plunder) {
    _id_A8EEB94DCC610B78 = _id_A8EEB94DCC610B78 + item.plundercount;

    if(item.player.team != self.team)
      _id_235F1174E9FAA6D2 = 1;
  }

  _id_715028F54BAD19A1::branalytics_plunder_extraction_success(self.plunder.size, _id_A8EEB94DCC610B78, "little_bird", _id_235F1174E9FAA6D2, self.endpoint);
  level.br_plunder.extraction_helicoptor_total_plunder = level.br_plunder.extraction_helicoptor_total_plunder + _id_A8EEB94DCC610B78;
  level.br_plunder.extraction_helicoptor_num_completed++;
}

heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
  }
}

helicleanupdepotonleaving(usable) {
  self.usable endon("death");
  scripts\engine\utility::waittill_either("leaving", "death");
  heliusecleanup();
}

helicreateextractvfx(position) {
  self.vfxent = spawn("script_model", position);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

helicleanupextract(_id_7158BFC28B4BEA09) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(_id_7158BFC28B4BEA09) && isDefined(self.site))
    self.site setscriptablepartstate(self.site.type, self.site.activestate);
}

helidisapateextractvfx() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }
  wait 5;
  self.vfxent endon("death");
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

spawnheli(owner, pathstart, pathgoal, pathexit) {
  angles = vectortoangles(pathgoal - pathstart);
  _id_87CEF10BF5729579 = 1;
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable");

  if(!isDefined(heli)) {
    return;
  }
  endpoint = pathgoal * (1, 1, 0);
  heli.damagecallback = ::callback_vehicledamage;
  heli.speed = 100;
  heli.accel = 125;
  heli.health = 1000;
  heli.maxhealth = heli.health;
  heli.team = owner.team;
  heli.owner = owner;
  heli.defendloc = pathgoal;
  heli.lifeid = 0;
  heli.flaresreservecount = _id_87CEF10BF5729579;
  heli.pathgoal = pathgoal;
  heli.pathexit = pathexit;
  heli.endpoint = endpoint;
  heli.goalyaw = angles[1];
  heli.vehiclename = "magma_plunder_chopper";
  heli setCanDamage(1);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(50, 100, 50);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  heli thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  heli thread handledestroydamage();
  heli thread helidestroyed();
  return heli;
}

helidestroyed() {
  self endon("heli_gone");
  self endon("swapped");
  owner = self.owner;
  team = self.team;
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  teamrefundplunder(team);
  helicleanup();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread helicrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  heliexplode(attacker);
}

helicleanup() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();
}

heliexplode(attacker) {
  _id_240A4F3D560753FF = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(_id_240A4F3D560753FF, 256, 140, 70, attacker, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), _id_240A4F3D560753FF, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(_id_240A4F3D560753FF, "veh_chopper_support_crash");
  earthquake(0.4, 800, _id_240A4F3D560753FF, 0.7);
  playrumbleonposition("grenade_rumble", _id_240A4F3D560753FF);
  physicsexplosionsphere(_id_240A4F3D560753FF, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread _id_1E4A61DB11011446::teamsplashbr("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  helicleanupextract(1);
  helidelete();
}

helidelete() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

helicrash(speed) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health) {
      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
      helicleanupextract(1);
    }
  }
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

helileave() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.goalyaw);
  helisetteamextractionhud(3, self.flytime);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.pathexit, 1);
  self settargetyaw(self.goalyaw);
  self waittill("goal");
  self stoploopsound();
  helibankplunder();
  helisetteamextractionhud(0, 0);
  self notify("heli_gone");
  helidelete();
}

helidescend(location, groundz) {
  self endon("death");
  _id_0FCFB56E6D8CC156 = location[0];
  _id_0FCFB66E6D8CC389 = location[1];
  _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, groundz);
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  self settargetyaw(self.goalyaw);
  self vehicle_setspeed(25.0, 31.25);
  thread helidestroyvehiclestouchnotify();
  thread helidestroyvehiclestouchtrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

helidestroyvehiclestouchnotify() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", vehicle);

    if(isDefined(vehicle) && vehicle entisalivevehicle())
      vehicle dodamage(vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH");
  }
}

helidestroyvehiclestouchtrace() {
  self endon("leaving");
  self endon("death");
  radius = 70;
  _id_7CFE8395A8CF5836 = -80;
  forward = 150;
  _id_63E26D5A86AC531C = 25;
  back = -100;

  for(;;) {
    vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(vehicles.size <= 1) {
      wait 0.5;
      continue;
    }

    _id_7346EB0E818B60C5 = scripts\engine\trace::create_vehicle_contents();
    dir = anglesToForward(self.angles);
    origin = self.origin + dir * getdvarfloat("test_f", forward) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_m", _id_63E26D5A86AC531C) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_b", back) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

tracegroundheight(start) {
  _id_DC8BB6300463CF1E = 125;
  _id_AA5A7071F7A4C106 = tracegroundpoint(start, 100, [self]);
  _id_E7A7D619F927D791 = _id_AA5A7071F7A4C106[2];
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(start, radius, ignorelist) {
  _id_379FF849B3CDA7D7 = -99999;
  end = (start[0], start[1], _id_379FF849B3CDA7D7);
  contents = scripts\engine\trace::create_world_contents();
  _id_E96577032A7740FC = undefined;

  if(isDefined(radius))
    _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(start, end, radius, ignorelist, contents);
  else
    _id_E96577032A7740FC = scripts\engine\trace::ray_trace(start, end, ignorelist, contents);

  return _id_E96577032A7740FC["position"];
}

heliwatchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread helileave();
}