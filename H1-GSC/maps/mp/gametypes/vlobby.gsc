/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\vlobby.gsc
****************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  level.rankedmatch = 0;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  level.classold = level.class;
  level.class = ::menuclass;
  game["menu_team"] = "main";
  game["menu_class_allies"] = "main";
  game["menu_class_axis"] = "main";
  game["menu_changeclass_allies"] = "main";
  game["menu_changeclass_axis"] = "main";
  game["menu_changeclass"] = "menu_cac_assault";
  game["allies"] = "sentinel_vl";
  game["axis"] = "atlas";
}

menuclass(var_0) {
  level.ingraceperiod = 1;
  self.hasdonecombat = 0;
  [[level.classold]](var_0);
}

onstartgametype() {
  setclientnamemode("auto_change");

  if(!isdefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("allies", & "OBJECTIVES_WAR");
  maps\mp\_utility::setobjectivehinttext("axis", & "OBJECTIVES_WAR");
  init_spawns();
  var_0[0] = level.gametype;
  maps\mp\gametypes\_gameobjects::main(var_0);
  level.prematchperiod = 0;
  level.prematchperiodend = 0;
}

init_spawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint(var_0) {
  if(!isdefined(var_0)) {
    var_0 = 0;

    for (var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] == self) {
        var_0 = var_1;
        break;
      }
    }
  }

  var_2 = getentarray("player_pos", "targetname");
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(var_3.script_noteworthy == "" + var_0) {
      break;
    }
  }

  if(!isdefined(var_3))
    var_3 = var_2[0];

  self.avatar_spawnpoint = var_3;
  return var_3;
}

onspawnplayer() {
  if(isdefined(level.vl_onspawnplayer))
    self[[level.vl_onspawnplayer]]();
}