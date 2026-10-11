/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_713ccfa3a01d4d19.gsc
*************************************************/

#using script_2b85a88a1d543a;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#namespace namespace_b925592dfbd5676e;

function function_15ec8dc28147b1b7(dvar, var_dc26843157970ecf, var_69a1727953025cb0, dvardefault) {
  name = getDvar(dvar, dvardefault);

  if(name == "") {
    iprintln("<dev string:x1c>" + getxhashsourcename(dvar) + "<dev string:x41>");

    return;
  }

  bundlename = hashcat(%"hash_62f18fdac9f4e251", name);
  bundle = getscriptbundle(bundlename);

  if(!isDefined(bundle)) {
    iprintln("<dev string:x51>" + getxhashsourcename(dvar) + "<dev string:x80>" + name + "<dev string:x87>");

    return;
  }

  scriptid = bundle.scriptid;
  assert(!isDefined(level.secondaryvictory.missions[scriptid]));
  mission = spawnStruct();
  mission.var_dc26843157970ecf = var_dc26843157970ecf;
  mission.var_69a1727953025cb0 = var_69a1727953025cb0;
  mission.bundle = bundle;
  level.secondaryvictory.missions[scriptid] = mission;
}

function registermission(name, init, getplayervalue) {
  if(!namespace_3460310ddf4d9cfa::init()) {
    return;
  }

  if(!isDefined(level.secondaryvictory.missions[name])) {
    return;
  }

  mission = level.secondaryvictory.missions[name];
  mission.init = init;
  mission.getplayervalue = getplayervalue;
}

function function_6ab248769a99d7e7() {
  foreach(mission in level.secondaryvictory.missions) {
    if(isDefined(mission.init)) {
      bundle = mission.bundle;
      total = function_59a210af4334879b(bundle.total);
      xpbonus = function_59a210af4334879b(bundle.xpbonus);
      mission.total = total;
      mission.xpbonus = xpbonus;
      level[[mission.var_69a1727953025cb0]](total);
      self[[mission.init]](bundle, total, xpbonus);
    }
  }
}

function function_59a210af4334879b(valuearray) {
  maxteamsize = level.maxteamsize;
  value = undefined;
  teamsize = 0;

  foreach(entry in valuearray) {
    if(entry.teamsize <= maxteamsize && entry.teamsize > teamsize) {
      value = entry.value;
      teamsize = entry.teamsize;
    }
  }

  assert(isDefined(value));
  return value;
}

function initteamdata() {
  foreach(team in getarraykeys(level.teamdata)) {
    if(team == "free" || team == "spectator" || team == "civilian") {
      continue;
    }

    if(isDefined(level.teamdata[team]["svData"])) {
      continue;
    }

    level.teamdata[team]["svData"] = newteamdata();
  }

  function_6ab248769a99d7e7();

  foreach(team in getarraykeys(level.teamdata)) {
    if(!isDefined(level.teamdata[team]["svData"])) {
      continue;
    }

    function_f7714705f9eb220a(team);
  }
}

function function_fdd037317409179e(player) {
  var_394aebba88e4e8c2 = spawnStruct();
  var_394aebba88e4e8c2.achieved = 0;
  var_394aebba88e4e8c2.inprogress = 0;
  var_394aebba88e4e8c2.team = player.team;
  var_394aebba88e4e8c2.name = player.team;
  var_394aebba88e4e8c2.player = player;
  var_394aebba88e4e8c2.trigger = undefined;
  var_394aebba88e4e8c2.var_86909aea6009b811 = undefined;
  var_394aebba88e4e8c2.var_97b85e39841505 = undefined;
  var_394aebba88e4e8c2.var_241735be4107a4fa = 0;
  return var_394aebba88e4e8c2;
}

function newteamdata() {
  td = spawnStruct();
  td.points = [];
  td.awarded = 0;
  td.var_394aebba88e4e8c2 = undefined;
  return td;
}

function getteamdata(team) {
  assert(isDefined(team));
  assert(isDefined(level.teamdata[team]["<dev string:x96>"]));
  return level.teamdata[team]["svData"];
}

function function_f7714705f9eb220a(team) {
  foreach(mission in getarraykeys(level.secondaryvictory.missions)) {
    function_d19de726f751683d(mission, team);
  }
}

function function_d19de726f751683d(mission, team) {
  td = getteamdata(team);
  value = function_7dded3913cebc59e(team, mission);

  if(istrue(td.awarded)) {
    return;
  }

  td.points[mission] = value;
  function_c9c2b5e426ae6ad2(mission, team, value);
}

function function_7dded3913cebc59e(team, mission) {
  missiondata = level.secondaryvictory.missions[mission];
  players = getteamplayers(team);
  value = 0;

  foreach(player in players) {
    value += player[[missiondata.getplayervalue]]();
  }

  return value;
}

function private function_c9c2b5e426ae6ad2(mission, team, value) {
  missiondata = level.secondaryvictory.missions[mission];
  players = getteamplayers(team);

  foreach(player in players) {
    player[[missiondata.var_dc26843157970ecf]](value);
  }
}

function getteamplayers(team) {
  return level.teamdata[team]["players"];
}

function function_160e85c84dcd9d28() {
  var_394aebba88e4e8c2 = self;
  assert(isDefined(var_394aebba88e4e8c2.team));
  assert(!isDefined(var_394aebba88e4e8c2.var_97b85e39841505));
  assert(!isDefined(var_394aebba88e4e8c2.var_86909aea6009b811));

  iprintln("<dev string:xa0>");

  var_394aebba88e4e8c2.var_97b85e39841505 = scripts\mp\hud_util::createservertimer("default", 1.5, var_394aebba88e4e8c2.team);
  var_394aebba88e4e8c2.var_97b85e39841505 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -162);
  var_394aebba88e4e8c2.var_86909aea6009b811 = createhudelem(undefined, undefined, "CENTER", "CENTER", 0, -180, undefined, var_394aebba88e4e8c2.team);
}

function starttimer(label, time) {
  var_394aebba88e4e8c2 = self;

  iprintln("<dev string:xcc>");

  var_394aebba88e4e8c2.var_97b85e39841505 settimer(time);
  var_394aebba88e4e8c2.var_86909aea6009b811.label = label;
}

function cleartimer() {
  var_394aebba88e4e8c2 = self;

  iprintln("<dev string:xf5>");

  var_394aebba88e4e8c2.var_97b85e39841505 reset();
  var_394aebba88e4e8c2.var_86909aea6009b811 reset();
}

function destroyhudelements() {
  var_394aebba88e4e8c2 = self;

  if(isDefined(var_394aebba88e4e8c2.var_97b85e39841505)) {
    var_394aebba88e4e8c2.var_97b85e39841505 destroy();
    var_394aebba88e4e8c2.var_97b85e39841505 = undefined;
  }

  if(isDefined(var_394aebba88e4e8c2.var_86909aea6009b811)) {
    var_394aebba88e4e8c2.var_86909aea6009b811 destroy();
    var_394aebba88e4e8c2.var_86909aea6009b811 = undefined;
  }
}

function createhudelem(label, value, point, relativepoint, xoffset, yoffset, color, team) {
  fontscale = 1.5;

  if(isDefined(team)) {
    fontelem = newteamhudelem(team);
  } else {
    fontelem = newhudelem();
  }

  fontelem.elemtype = "font";
  fontelem.font = "default";
  fontelem.fontscale = fontscale;
  fontelem.basefontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem scripts\mp\hud_util::setparent(level.uiparent);
  fontelem.hidden = 0;
  fontelem.alpha = 1;
  fontelem scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label)) {
    fontelem.label = label;
  }

  if(isDefined(value)) {
    fontelem setvalue(value);
  }

  if(isDefined(color)) {
    fontelem.color = color;
  }

  return fontelem;
}

function function_74cdb6b6565f33a3(timer) {
  player = self;
  assert(isPlayer(player));

  if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    var_3754da1f96fbaa7e = ter_op(timer > 0, 1, 0);
    player setclientomnvar("ui_is_exfil_countdown", var_3754da1f96fbaa7e);
    player setclientomnvar("ui_match_start_countdown", timer);
  }
}

function function_f3830638ad346e8e(splashref) {
  if(!isDefined(splashref) || splashref == "") {
    return;
  }

  thread scripts\mp\hud_message::showsplash(splashref);
}

function function_92993664746f4afa(team, splashref) {
  if(!isDefined(splashref) || splashref == "") {
    return;
  }

  foreach(teammember in level.teamdata[team]["players"]) {
    teammember thread scripts\mp\hud_message::showsplash(splashref);
  }
}

function safewait(time) {
  if(isDefined(time) && time > 0) {
    wait time;
  }
}

function function_6a694b8e45c2ca3c(dialog, team, delay) {
  scripts\mp\gametypes\br_public::brleaderdialogteam(dialog, team, undefined, delay, undefined, "dx_br_jpbm_");
}

function function_3f39c7ace07c243() {
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname];
  dlog_recordevent("dlog_event_br_secondary_victory_init", kvps);
}

function function_a10e1586d7ecf252(price, inventorycount) {
  player = self;
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "price", int(price), "inventory", inventorycount, "x", player.origin[0], "y", player.origin[1], "z", player.origin[2], "team_name", player.team];
  self dlog_recordplayerevent("dlog_event_br_secondary_victory_player_purchase", kvps);
}

function function_a9b4c3bb4abb4a01(failure_reason, position) {
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "reason", int(failure_reason), "x", position[0], "y", position[1], "z", position[2]];
  self dlog_recordplayerevent("dlog_event_br_secondary_victory_failure", kvps);
}

function function_4c04d9675ebe2f9f(team_name, team_size, position, avg_dist, chopper_time) {
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", team_name, "team_size", team_size, "x", position[0], "y", position[1], "z", position[2], "avg_dist", avg_dist, "chopper_time", float(chopper_time)];
  dlog_recordevent("dlog_event_br_secondary_victory_sequence_start", kvps);
}

function function_810f4a04a9253967(dist2d) {
  player = self;
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", player.team, "x", player.origin[0], "y", player.origin[1], "z", player.origin[2], "distance", dist2d];
  self dlog_recordplayerevent("dlog_event_br_secondary_victory_player_start", kvps);
}

function function_b1c6ce7b2edc4ec2(position, team_name, team_count, fullyextracted, exfil_count, has_weapon_case, endingid) {
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", team_name, "team_count", team_count, "fully_extracted", fullyextracted, "exfil_count", exfil_count, "has_weapon_case", has_weapon_case, "ending_id", endingid, "x", position[0], "y", position[1], "z", position[2]];
  dlog_recordevent("dlog_event_br_secondary_victory_sequence_end", kvps);
}

function function_f35d9659b8af4887(chopper_team, has_weapon_case, endingid, position) {
  player = self;
  kvps = ["playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", player.team, "chopper_team", chopper_team, "has_weapon_case", has_weapon_case, "ending_id", endingid, "x", position[0], "y", position[1], "z", position[2]];
  self dlog_recordplayerevent("dlog_event_br_secondary_victory_player_exfil", kvps);
}

function private getcircleindex() {
  circleindex = -1;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    circleindex = level.br_circle.circleindex;
  }

  return circleindex;
}

function function_751af1123571e361(team) {
  fullyextracted = 1;
  players = level.teamdata[team]["players"];

  foreach(player in players) {
    if(!istrue(player.extracted)) {
      fullyextracted = 0;
      break;
    }
  }

  return fullyextracted;
}

function function_1324ed2d881d301f() {
  index = level.secondaryvictory.var_ddb244800e3f1329;
  count = level.secondaryvictory.scriptbundle.var_8396ddb130a38012;
  index = (index + 1) % count;
  level.secondaryvictory.var_ddb244800e3f1329 = index;
}

function function_89db4cf4358b1915(value) {
  assert(isDefined(value) && (value == 0 || value == 1));
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 0, 1, value);
}

function function_3049b4b9d7489dca(value) {
  assert(isDefined(value) && (value == 0 || value == 1));
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 1, 1, value);
}

function function_7d3329c47fbe47f1(value) {
  assert(isDefined(value) && (value == 0 || value == 1));
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 2, 1, value);
}

function function_906084f03cbe16da(value) {
  assert(isDefined(value) && (value == 0 || value == 1));
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 3, 1, value);
}

function function_cae7fc3d806ab9ce(value) {
  assert(isDefined(value) && 0 <= value && value <= 10230);
  assert(value % 10 == 0);
  assert(value / 10 == int(value / 10));
  value = int(value / 10);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 4, 10, value);
}

function function_358c488f5ac3aff0(value) {
  assert(isDefined(value) && 0 <= value && value <= 31);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 14, 5, value);
}

function function_4e4db1d859b3ecf9(value) {
  assert(isDefined(value) && 0 <= value && value <= 15);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 19, 4, value);
}

function function_ab628f99a7598153(value) {
  assert(isDefined(value) && 0 <= value && value <= 15);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 23, 4, value);
}

function function_8f67cca8eec50569(value) {
  assert(isDefined(value) && 0 <= value && value <= 15);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_sv_game1", 27, 4, value);
}

function function_e89fc0ef7d6123d9(value) {
  assert(isDefined(value));
  setomnvar("ui_br_sv_game2", value);
}

function function_15e5e77836d740c2(value) {
  assert(isDefined(value));
  setomnvar("ui_br_sv_game3", value);
}

function function_10da62a5050109ed(value) {
  assert(isDefined(value) && 0 <= value && value <= 31);
  player = self;
  player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_sv_client1", 0, 5, value);
}

function function_b878acdc34c32bd(value) {
  assert(isDefined(value));
  player = self;
  player setclientomnvar("ui_br_sv_client2", value);
}

function function_677a58693f27bb60(value) {
  assert(isDefined(value));
  player = self;
  player setclientomnvar("ui_br_sv_client3", value);
}