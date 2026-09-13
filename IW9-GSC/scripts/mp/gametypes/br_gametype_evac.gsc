/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_evac.gsc
*****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "evac") {
    return;
  }
  init();
}

init() {
  _id_362C58E8BB39BCDA::enablefeature("circleSnapToNavMesh");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimer", ::circletimer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  level.brgametype.firstteam = "tie";
  thread initpostmain();
}

initpostmain() {
  waittillframeend;
  thread setupmission();
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
  scripts\mp\hud_message::showsplash("br_gametype_evac_welcome");
}

setupmission() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.brgametype.helicircleindex = getdvarint("dvar_9F7241C3802E23E7", 5);
  level.brgametype.heliextractarrivewait = getdvarint("dvar_D18FD2563AC77406", 120);
  level.brgametype.heliextractwait = getdvarint("dvar_25BA23925BF6103C", 120);
  level.brgametype.timertexthud = createhudelem(&"MP_BR_INGAME/EVAC_START", level.brgametype.helicircleindex, "CENTER", "CENTER", 0, -180);
  thread setuphelilandingposition();
}

setuphelilandingposition(_id_45525F095E4D26F5) {
  _id_E6284E7BBAE9B201 = 20;
  _id_D809DF5FD4884122 = 300;
  _id_155FB37500F4FF9A = 1;
  _id_152D7EA6D1B58114 = 3;
  _id_E36A2A98267F50F1 = 0;
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  center = level.br_level.br_circlecenters[level.brgametype.helicircleindex];
  radius = level.br_level.br_circleradii[level.brgametype.helicircleindex];
  position = center;
  _id_3231A4CAF7D88E84 = radius * radius;
  _id_39468A593C931CFF = radius - 150;
  _id_0E8D49D458AEBF28 = _id_39468A593C931CFF * _id_39468A593C931CFF;
  _id_64E07DA2D424D0CE = -1;
  _id_501BD92562FE237F = -1;
  _id_8A5EB99C7675C864 = -1;
  _id_A3D02971A6456EBB = center;
  _id_CC8BDBA3EC456499 = 0;
  _id_556B31282ABCB132 = 0;
  _id_31C17968C4ABA482 = 0;
  _id_31C17A68C4ABA6B5 = 0;
  offset = (0, 0, 0);
  _id_17ADD9E21FF7EBFD = 0;

  while(_id_556B31282ABCB132 < _id_39468A593C931CFF) {
    position = position + offset;
    start = (position[0], position[1], _id_5FA1E1697A302583.origin[2]);
    _id_5B86C92F122ECB50 = distance2dsquared(start, center);

    if(_id_5B86C92F122ECB50 < _id_0E8D49D458AEBF28) {
      _id_17ADD9E21FF7EBFD++;
      _id_AA5A7071F7A4C106 = tracegroundpoint(start, 150);
      _id_DD2E7AB8315807B2 = getclosestpointonnavmesh(_id_AA5A7071F7A4C106);
      _id_4573A8725DD3748E = abs(_id_AA5A7071F7A4C106[2] - _id_DD2E7AB8315807B2[2]);
      _id_72FDE5447014F573 = distance2dsquared(_id_AA5A7071F7A4C106, _id_DD2E7AB8315807B2);

      if(_id_72FDE5447014F573 < _id_155FB37500F4FF9A && _id_4573A8725DD3748E <= _id_E6284E7BBAE9B201 && !_id_E36A2A98267F50F1) {
        level.brgametype.helilandingorigin = _id_AA5A7071F7A4C106;
        return;
      } else {
        weight = _id_72FDE5447014F573 * _id_4573A8725DD3748E;

        if(_id_64E07DA2D424D0CE == -1 || _id_64E07DA2D424D0CE > 0 && weight < _id_64E07DA2D424D0CE || _id_64E07DA2D424D0CE == 0 && _id_4573A8725DD3748E < _id_8A5EB99C7675C864) {
          _id_64E07DA2D424D0CE = weight;
          _id_A3D02971A6456EBB = _id_AA5A7071F7A4C106;
          _id_501BD92562FE237F = _id_72FDE5447014F573;
          _id_8A5EB99C7675C864 = _id_4573A8725DD3748E;
        }
      }
    }

    if(_id_CC8BDBA3EC456499 == 0) {
      _id_CC8BDBA3EC456499++;
      _id_31C17968C4ABA482++;
    } else if(_id_31C17A68C4ABA6B5 == _id_CC8BDBA3EC456499) {
      _id_CC8BDBA3EC456499++;
      _id_31C17968C4ABA482 = 1;
      _id_31C17A68C4ABA6B5 = 1;
      sign = scripts\engine\utility::ter_op(_id_CC8BDBA3EC456499 % 2, -1, 1);
      offset = (sign * _id_D809DF5FD4884122, 0, 0);
    } else if(_id_31C17968C4ABA482 == _id_CC8BDBA3EC456499) {
      _id_31C17A68C4ABA6B5++;
      sign = scripts\engine\utility::ter_op(_id_CC8BDBA3EC456499 % 2, -1, 1);
      offset = (0, sign * _id_D809DF5FD4884122, 0);
    } else
      _id_31C17968C4ABA482++;

    if(_id_CC8BDBA3EC456499 % 2 == 1)
      _id_556B31282ABCB132 = (_id_CC8BDBA3EC456499 + 1) / 2 * _id_D809DF5FD4884122;

    if(_id_17ADD9E21FF7EBFD >= _id_152D7EA6D1B58114) {
      _id_17ADD9E21FF7EBFD = 0;
      waitframe();
    }
  }

  level.brgametype.helilandingorigin = _id_A3D02971A6456EBB;
}

circletimer(circleindex) {
  if(circleindex < level.brgametype.helicircleindex)
    return 0;

  if(circleindex == level.brgametype.helicircleindex)
    runheliextraction(circleindex);

  return 1;
}

setupmissionwidget() {
  _id_2F55781AF96F22F9 = _id_64ACB6CE534155B7::getquesttableindex("gt_evac");

  foreach(player in level.players)
  player _id_64ACB6CE534155B7::setquestindexomnvar(_id_2F55781AF96F22F9);
}

teamextractedvictory(team, heli) {
  level endon("game_ended");
  level.brgametype.firstteam = team;
  _id_5BAB271917698DC4::setteamasextracted(team);
  heli notify("missionComplete");
  scripts\mp\outofbounds::enableoobimmunity(self);
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

runheliextraction(circleindex) {
  if(isDefined(circleindex))
    _id_67708F418B1FAC79::shutdowngulag("circle_index", circleindex);

  level thread _id_2CEDCC356F1B9FC8::brbroadcastplayercardsplash("br_gametype_evac_incoming");
  _id_3ACF1C0EBAF602F2::cancelallmissions();
  _id_3ACF1C0EBAF602F2::disablealltablets();
  thread setupmissionwidget();
  makeextractionobjective();
  vfxent = createextractvfx(level.brgametype.helilandingorigin);
  _id_76AB620FD7CC70BD = getheliflyheight();
  _id_5800F27BE7E247A5 = (level.brgametype.helilandingorigin[0], level.brgametype.helilandingorigin[1], _id_76AB620FD7CC70BD);
  groundz = tracegroundheight(_id_5800F27BE7E247A5);
  _id_625180CE8D2F8F77 = _id_5800F27BE7E247A5[2] - groundz;
  flytime = calculatehelitimetoarrive(_id_625180CE8D2F8F77);
  _id_5301EBED8D610FDB = level.brgametype.heliextractarrivewait + flytime;
  _id_DB5C0D19D6861757 = _id_5301EBED8D610FDB + level.brgametype.heliextractwait;
  level.br_circle.dangercircleui.origin = _id_2695A20D4011076D::getdangercircleorigin() + (0, 0, _id_2695A20D4011076D::getdangercircleradius());
  _id_2695A20D4011076D::setstaticuicircles(_id_DB5C0D19D6861757, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
  setomnvar("ui_hardpoint_timer", gettime() + int(_id_DB5C0D19D6861757 * 1000));
  thread setuphelitimer(_id_5301EBED8D610FDB, level.brgametype.heliextractwait);
  wait(level.brgametype.heliextractarrivewait);
  heli = spawnextractchopper(level.brgametype.helilandingorigin);
  heli.vfxent = vfxent;
  heli.flytime = flytime;
  heli.groundz = groundz;
  thread extractthink(heli);
}

setuphelitimer(_id_5301EBED8D610FDB, waittime) {
  level endon("game_ended");
  level.brgametype.timertexthud destroy();
  level.brgametype.timertexthud = createhudelem(&"MP_BR_INGAME/EVAC_ARRIVE", undefined, "CENTER", "CENTER", 0, -180);
  timerhud = scripts\mp\hud_util::createservertimer("default", 1.5);
  timerhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -162);
  timerhud settimer(_id_5301EBED8D610FDB);
  wait(_id_5301EBED8D610FDB);
  level.brgametype.timertexthud.label = &"MP_BR_INGAME/EVAC_WAIT";
  timerhud settimer(waittime);
  wait(waittime);
  level.brgametype.timertexthud destroy();
  timerhud destroy();
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
  _id_372B658AEA9D2487.alpha = 1;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label))
    _id_372B658AEA9D2487.label = label;

  if(isDefined(value))
    _id_372B658AEA9D2487 setvalue(value);

  if(isDefined(color))
    _id_372B658AEA9D2487.color = color;

  return _id_372B658AEA9D2487;
}

makeextractionobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.brgametype.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", level.brgametype.helilandingorigin, "ui_mp_br_mapmenu_icon_helipad");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.brgametype.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", level.brgametype.helilandingorigin + (0, 0, 30), "ui_mp_br_mapmenu_legend_littlebird");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
  }
}

extractthink(heli) {
  heli setvehgoalpos(heli.pathgoal, 1);
  heli settargetyaw(heli.goalyaw);
  heli waittill("goal");
  heli thread helidisapateextractvfx();
  heli helidescend(heli.endpoint, heli.groundz);
  scripts\mp\objidpoolmanager::update_objective_setbackground(level.brgametype.objectiveiconid, 4);
  level thread _id_2CEDCC356F1B9FC8::brbroadcastplayercardsplash("br_gametype_evac_arrived");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_arrive", heli.team, 1);
  heli helicleanupextract(0);
  heli heliextractwait();
  heli heliusecleanup();
  heli thread helileave();
  brendgame();
}

getheliflyheight() {
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  _id_76AB620FD7CC70BD = _id_5FA1E1697A302583.origin[2] - 300;
  return _id_76AB620FD7CC70BD;
}

spawnextractchopper(position) {
  _id_26A6F862062E4340 = position;
  _id_76AB620FD7CC70BD = getheliflyheight();
  _id_0C2C23AB40723A8D = (_id_26A6F862062E4340[0], _id_26A6F862062E4340[1], _id_76AB620FD7CC70BD);
  angles = (0, randomfloat(360), 0);
  _id_16CEDB94FAF4D596 = _id_0C2C23AB40723A8D + -1 * anglesToForward(angles) * 30000;
  exitposition = _id_0C2C23AB40723A8D + anglesToForward(angles) * 30000;
  _id_8640B7DC127433F1 = level.players[randomint(level.players.size)];
  heli = _id_8640B7DC127433F1 spawnheli(_id_8640B7DC127433F1, _id_16CEDB94FAF4D596, _id_0C2C23AB40723A8D, exitposition);
  return heli;
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

heliextractwait() {
  usable = spawn("script_model", level.brgametype.helilandingorigin + (0, 0, 20));
  usable setModel("tag_origin");
  usable makeusable();
  usable setCursorHint("HINT_NOICON");
  usable setuseholdduration("duration_short");
  usable sethintrequiresholding(1);
  usable setuserange(230);
  usable setHintString(&"MP_BR_INGAME/EXTRACT");
  self.usable = usable;
  thread helithink(usable);
  wait(level.brgametype.heliextractwait);
}

helithink(usable) {
  self endon("death");
  usable endon("death");

  for(;;) {
    usable waittill("trigger", player);
    player playlocalsound("br_plunder_atm_deposit_gtr");
    heliusecleanup();
    teamextractedvictory(player.team, self);
    brendgame();
    return;
  }
}

heliusecleanup() {
  if(isDefined(self.usable)) {
    self.usable depotmakeunsabletoall();
    self.usable = undefined;
  }
}

depotmakeunsabletoall() {
  self makeunusable();

  if(isDefined(level.brgametype.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.brgametype.objectiveiconid);
    scripts\mp\objidpoolmanager::returnobjectiveid(level.brgametype.objectiveiconid);
  }
}

createextractvfx(position) {
  vfxent = spawn("script_model", position);
  vfxent setModel("scr_smoke_grenade");
  vfxent.angles = (0, 90, 90);
  vfxent playLoopSound("smoke_carepackage_smoke_lp");
  vfxent setscriptablepartstate("smoke", "on");
  return vfxent;
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
  heli.health = 9999;
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
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(50, 100, 50);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  heli thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  return heli;
}

helicleanup() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();
}

helidelete() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {}

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
  _id_DC8BB6300463CF1E = 190;
  _id_AA5A7071F7A4C106 = tracegroundpoint(start, 150);
  _id_E7A7D619F927D791 = _id_AA5A7071F7A4C106[2];
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(start, radius, ignorelist) {
  _id_379FF849B3CDA7D7 = -99999;
  end = (start[0], start[1], _id_379FF849B3CDA7D7);
  contents = physics_createcontents(["physicscontents_playerclip", "physicscontents_missileclip", "physicscontents_vehicleclip"]);
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