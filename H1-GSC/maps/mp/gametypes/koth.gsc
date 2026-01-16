/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\koth.gsc
********************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [
      [level.initializematchrules]
    ]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 30);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 300);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.teambased = 1;
  level.classicgamemode = 1;
  level.doprematch = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;

  level.hqautodestroytime = getdvarint("scr_koth_autodestroytime", 60);
  level.hqspawntime = getdvarint("scr_koth_spawntime", 0);
  level.capturetime = getdvarint("scr_koth_captureTime", 20);
  level.destroytime = getdvarint("scr_koth_destroyTime", 10);
  level.delayplayer = getdvarint("scr_koth_delayPlayer", 0);
  level.spawndelay = level.hqautodestroytime;
  level.hqclassicmode = getdvarint("scr_koth_classicMode", 1);
  level.captureinsteadofdestroy = !level.hqclassicmode;
  level.iconoffset = (0, 0, 32);
  level.timerdisplay = [];
  level.onrespawndelay = ::getrespawndelay;
  game["dialog"]["gametype"] = "headquarters";
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_koth_autodestroytime", getmatchrulesdata("hqData", "HQLifetime"));
  setdynamicdvar("scr_koth_spawntime", getmatchrulesdata("hqData", "HQActivateDelay"));
  setdynamicdvar("scr_koth_classicMode", getmatchrulesdata("hqData", "HQClassicMode"));
  setdynamicdvar("scr_koth_roundswitch", 1);
  maps\mp\_utility::registerroundswitchdvar("koth", 1, 0, 9);
  setdynamicdvar("scr_koth_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("koth", 1);
  setdynamicdvar("scr_koth_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("koth", 1);
  setdynamicdvar("scr_koth_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("koth", 0);
  setdynamicdvar("scr_koth_capturetime", 20);
  setdynamicdvar("scr_koth_destroytime", 10);
  setdynamicdvar("scr_koth_delayPlayer", 0);
  setdynamicdvar("scr_koth_spawnDelay", 60);
}

updateobjectivehintmessages(var_0, var_1) {
  game["strings"]["objective_hint_allies"] = level.objectivehint[var_0].str;
  game["strings"]["objective_hint_axis"] = level.objectivehint[var_1].str;

  for (var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isdefined(var_3.pers["team"]) && var_3.pers["team"] != "spectator") {
      var_4 = maps\mp\_utility::getobjectivehinttext(var_3.pers["team"]);
      var_3 thread maps\mp\gametypes\_hud_message::hintmessage(var_4);
    }
  }
}

getrespawndelay() {
  maps\mp\_utility::clearlowermessage("hq_respawn");

  if(!isdefined(level.radioobject))
    return undefined;

  var_0 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();

  if(self.pers["team"] == var_0) {
    if(!isdefined(level.hqdestroytime))
      return undefined;

    if(level.spawndelay == 0)
      return undefined;

    var_1 = (level.hqdestroytime - gettime()) / 1000;
    var_1 = var_1 + 1.0;

    if(level.spawndelay >= level.hqautodestroytime) {
      if(level.hqclassicmode)
        maps\mp\_utility::setlowermessage("hq_respawn", & "MP_WAITING_FOR_HQ", undefined, 10);
      else
        maps\mp\_utility::setlowermessage("hq_respawn", & "MP_WAITING_FOR_HQ_CAPTURE", undefined, 10);

      self setclientomnvar("ui_hide_spawn_timer", 1);
    }

    if(!isalive(self))
      self.forcespawnnearteammates = 1;

    if(level.delayplayer)
      return min(level.spawndelay, var_1);
    else {
      self.respawntimerstarttime = undefined;
      return int(var_1) % level.spawndelay;
    }
  }
}

hintstruct(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.str = var_0;
  var_2.index = var_1;
  return var_2;
}

onstartgametype() {
  maps\mp\_utility::setobjectivetext("allies", & "OBJECTIVES_KOTH");
  maps\mp\_utility::setobjectivetext("axis", & "OBJECTIVES_KOTH");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_KOTH");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_KOTH");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", & "OBJECTIVES_KOTH_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", & "OBJECTIVES_KOTH_SCORE");
  }

  level.objectivehint["prepare"] = hintstruct(&"MP_CONTROL_HQ", 0);
  level.objectivehint["capture"] = hintstruct(&"MP_CAPTURE_HQ", 1);
  level.objectivehint["destroy"] = hintstruct(&"MP_DESTROY_HQ", 2);
  level.objectivehint["defend"] = hintstruct(&"MP_DEFEND_HQ", 3);

  if(!level.hqclassicmode)
    level.objectivehint["destroy"] = level.objectivehint["capture"];

  if(level.hqspawntime)
    updateobjectivehintmessages("prepare", "prepare");
  else
    updateobjectivehintmessages("capture", "capture");

  setclientnamemode("auto_change");
  initspawns();
  var_0[0] = "hq";
  maps\mp\gametypes\_gameobjects::main(var_0);
  thread setupradios();
  thread hqmainloop();
  thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawn_all = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");

  if(!level.spawn_all.size) {
    maps\mp\gametypes\_callbacksetup::abortlevel();
    return;
  }
}

timerdisplayshow(var_0, var_1, var_2) {
  if(isdefined(var_1))
    level.timerdisplay["allies"] = var_1;

  if(isdefined(var_2))
    level.timerdisplay["axis"] = var_2;

  if(isdefined(var_0))
    setomnvar("ui_bomb_timer_endtime", var_0);

  foreach(var_4 in level.players)
  var_4 timerdisplaytoplayer();
}

timerdisplayhide() {
  level.timerdisplay["allies"] = undefined;
  level.timerdisplay["axis"] = undefined;
  setomnvar("ui_bomb_timer_endtime", 0);

  foreach(var_1 in level.players)
  var_1 timerdisplaytoplayer();
}

timerdisplaytoplayer() {
  var_0 = level.timerdisplay[self.team];

  if(!isdefined(var_0))
    var_0 = "none";

  var_1["none"] = 0;
  var_1["spawning"] = 1;
  var_1["despawning"] = 2;
  var_1["reinforcements"] = 3;
  var_2 = var_1[var_0];
  self setclientomnvar("ui_hud_message_index", var_2);
}

hqmainloop() {
  level endon("game_ended");
  level.hqrevealtime = -100000;
  maps\mp\_utility::gameflagwait("prematch_done");
  wait 5;
  thread hidetimerdisplayongameend();
  var_0 = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(var_0, "invisible", (0, 0, 0));

  for (;;) {
    var_1 = pickradiotospawn();
    var_1 makeradioactive();
    maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
    maps\mp\_utility::leaderdialog("hq_located");
    var_2 = var_1.gameobject;
    level.radioobject = var_2;
    var_2 makeradiovisible();
    var_1.visible = 1;
    level.hqrevealtime = gettime();

    if(level.hqspawntime) {
      var_3 = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_next_hq", var_1.origin + level.iconoffset, "all", "waypoint_targetneutral");
      var_3 setwaypoint(1, 1);
      objective_position(var_0, var_1.trigorigin);
      objective_icon(var_0, "waypoint_targetneutral");
      objective_state(var_0, "active");
      updateobjectivehintmessages("prepare", "prepare");
      timerdisplayshow(gettime() + 1000 * level.hqspawntime, "spawning", "spawning");
      wait(level.hqspawntime);
      maps\mp\gametypes\_objpoints::deleteobjpoint(var_3);
      objective_state(var_0, "invisible");
    }

    timerdisplayhide();
    waittillframeend;
    maps\mp\_utility::leaderdialog("hq_online");
    updateobjectivehintmessages("capture", "capture");
    maps\mp\_utility::playsoundonplayers("mp_killstreak_radar");
    var_2 maps\mp\gametypes\_gameobjects::allowuse("any");
    var_2 maps\mp\gametypes\_gameobjects::setusetime(level.capturetime);
    var_2 maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_HQ");
    var_2 updateicons();
    var_2 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    var_2.onuse = ::onradiocapture;
    var_2.onbeginuse = ::onbeginuse;
    var_2.onenduse = ::onenduse;
    var_2.onnumtouchingchanged = ::onnumtouchingchanged;
    var_2.nousebar = 1;
    var_2.contesteduiprogress = 1;
    var_2.id = "kothZone";
    level waittill("hq_captured");
    var_4 = var_2 maps\mp\gametypes\_gameobjects::getownerteam();
    var_5 = maps\mp\_utility::getotherteam(var_4);

    if(level.hqautodestroytime)
      thread destroyhqaftertime(level.hqautodestroytime);
    else
      level.hqdestroyedbytimer = 0;

    for (;;) {
      var_4 = var_2 maps\mp\gametypes\_gameobjects::getownerteam();
      var_5 = maps\mp\_utility::getotherteam(var_4);

      if(var_4 == "allies")
        updateobjectivehintmessages("defend", "destroy");
      else
        updateobjectivehintmessages("destroy", "defend");

      var_2 maps\mp\gametypes\_gameobjects::allowuse("enemy");
      var_2 updateicons();

      if(level.hqclassicmode)
        var_2 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DESTROYING_HQ");

      var_2.onuse = ::onradiodestroy;

      if(level.hqautodestroytime) {
        var_6 = "despawning";

        if(level.hqclassicmode)
          var_6 = "reinforcements";

        var_7 = "despawning";

        if(var_4 == "allies")
          timerdisplayshow(level.hqdestroytime, var_6, var_7);
        else
          timerdisplayshow(level.hqdestroytime, var_7, var_6);
      }

      level waittill("hq_destroyed");
      timerdisplayhide();

      if(level.hqclassicmode || level.hqdestroyedbytimer) {
        break;
      }

      thread forcespawnteam(var_4);
      var_2 maps\mp\gametypes\_gameobjects::setownerteam(maps\mp\_utility::getotherteam(var_4));
    }

    level notify("hq_reset");
    var_2 maps\mp\gametypes\_gameobjects::allowuse("none");
    var_2 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    var_2 makeradioinvisible();
    var_1.visible = 0;
    var_1 makeradioinactive();
    level.radioobject = undefined;
    thread forcespawnteam(var_4);
    wait 6.0;
  }
}

updateicons() {
  if(!isdefined(self.trigger)) {
    return;
  }
  var_0 = "waypoint_captureneutral";
  var_1 = "waypoint_captureneutral";
  var_2 = "waypoint_captureneutral";

  if(self.numtouching["axis"] && self.numtouching["allies"]) {
    var_0 = "waypoint_contested";
    var_1 = "waypoint_contested";
    var_2 = "waypoint_contested";
  } else if(self.ownerteam == "neutral") {
    if(self.numtouching["axis"] || self.numtouching["allies"]) {
      var_0 = "waypoint_losing";
      var_1 = "waypoint_taking";

      if(self.numtouching["allies"])
        var_2 = "waypoint_esports_koth_taking_blue";
      else
        var_2 = "waypoint_esports_koth_taking_red";
    } else {
      var_0 = "waypoint_captureneutral";
      var_1 = "waypoint_captureneutral";
      var_2 = "waypoint_captureneutral";
    }
  } else if(self.numtouching[maps\mp\_utility::getotherteam(self.ownerteam)]) {
    var_0 = "waypoint_losing";
    var_1 = "waypoint_taking";

    if(self.ownerteam == "allies")
      var_2 = "waypoint_esports_koth_losing_blue";
    else
      var_2 = "waypoint_esports_koth_losing_red";
  } else {
    var_0 = "waypoint_defend";
    var_1 = "waypoint_capture";

    if(self.ownerteam == "allies")
      var_2 = "waypoint_esports_koth_taken_blue";
    else
      var_2 = "waypoint_esports_koth_taken_red";
  }

  maps\mp\gametypes\_gameobjects::set2dicon("friendly", var_0);
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", var_0);
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", var_1);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", var_1);
  maps\mp\_utility::setmlgicons(self, var_2);
}

hidetimerdisplayongameend(var_0) {
  level waittill("game_ended");
  timerdisplayhide();
}

forcespawnteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.pers["team"] == var_0) {
      var_2 maps\mp\_utility::clearlowermessage("hq_respawn");

      if(!isalive(var_2))
        var_2.forcespawnnearteammates = 1;

      var_2 notify("force_spawn");
    }
  }
}

onbeginuse(var_0) {
  updateicons();
}

onenduse(var_0, var_1, var_2) {
  updateicons();
}

onnumtouchingchanged(var_0, var_1, var_2) {
  updateicons();
}

onradiocapture(var_0) {
  var_1 = var_0.pers["team"];

  foreach(var_3 in self.touchlist[var_1]) {
    var_4 = var_3.player;
    var_4 maps\mp\_events::hqcaptureevent();
  }

  var_6 = maps\mp\gametypes\_gameobjects::getownerteam();
  maps\mp\gametypes\_gameobjects::setownerteam(var_1);

  if(level.hqclassicmode)
    maps\mp\gametypes\_gameobjects::setusetime(level.destroytime);

  var_7 = "axis";

  if(var_1 == "axis")
    var_7 = "allies";

  maps\mp\_utility::leaderdialog("hq_secured", var_1);
  maps\mp\_utility::leaderdialog("hq_enemy_captured", var_7);
  thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken", var_1);
  thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost", var_7);
  level thread awardhqpoints(var_1);
  var_0 notify("objective", "captured");
  level notify("hq_captured");
}

onradiodestroy(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = "axis";

  if(var_1 == "axis")
    var_2 = "allies";

  foreach(var_4 in self.touchlist[var_1]) {
    var_5 = var_4.player;

    if(!level.hqclassicmode) {
      var_5 maps\mp\_events::hqcaptureevent();
      continue;
    }

    var_5 maps\mp\_events::hqdestroyevent();
  }

  if(!level.hqclassicmode) {
    maps\mp\_utility::leaderdialog("hq_secured", var_1);
    maps\mp\_utility::leaderdialog("hq_enemy_captured", var_2);
  } else {
    maps\mp\_utility::leaderdialog("hq_secured", var_1);
    maps\mp\_utility::leaderdialog("hq_enemy_destroyed", var_2);
  }

  thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken", var_1);
  thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost", var_2);
  level notify("hq_destroyed");

  if(!level.hqclassicmode)
    level thread awardhqpoints(var_1);
}

destroyhqaftertime(var_0) {
  level endon("game_ended");
  level endon("hq_reset");
  level.hqdestroytime = gettime() + var_0 * 1000;
  level.hqdestroyedbytimer = 0;
  wait(var_0);
  level.hqdestroyedbytimer = 1;
  maps\mp\_utility::leaderdialog("hq_offline");
  level notify("hq_destroyed");
}

awardhqpoints(var_0) {
  level endon("game_ended");
  level endon("hq_destroyed");
  level notify("awardHQPointsRunning");
  level endon("awardHQPointsRunning");
  var_1 = 12;
  var_2 = 5;
  var_3 = 5;
  var_4 = 5;
  var_5 = 5;
  var_6 = 0;

  while (!level.gameended) {
    maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_0, var_4);
    var_6++;
    wait(var_5);
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

getspawnpoint() {
  var_0 = undefined;

  if(isdefined(level.radioobject)) {
    var_1 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning()) {
      if(self.pers["team"] == var_1)
        var_0 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all, level.radioobject.nearspawns);
      else if(level.spawndelay >= level.hqautodestroytime && gettime() > level.hqrevealtime + 10000)
        var_0 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all);
      else
        var_0 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all, level.radioobject.outerspawns);
    } else if(self.pers["team"] == var_1) {
      var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.radioobject.nearspawns);
      var_3 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);

      if(var_2 == var_3)
        var_0 = var_2;
      else
        var_0 = var_3;
    } else {
      var_2 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.radioobject.outerspawns);
      var_3 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);

      if(var_2 == var_3)
        var_0 = var_2;
      else
        var_0 = var_3;
    }
  }

  if(!isdefined(var_0))
    var_0 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);

  return var_0;
}

onspawnplayer() {
  maps\mp\_utility::clearlowermessage("hq_respawn");
  self.forcespawnnearteammates = undefined;
  timerdisplaytoplayer();
  self setclientomnvar("ui_hide_spawn_timer", 0);
}

setupradios() {
  var_0 = [];
  var_1 = getentarray("hq_hardpoint", "targetname");

  if(var_1.size < 2)
    var_0[var_0.size] = "There are not at least 2 entities with targetname \"radio\"";

  var_2 = getentarray("radiotrigger", "targetname");

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = 0;
    var_5 = var_1[var_3];
    var_5.trig = undefined;

    for (var_6 = 0; var_6 < var_2.size; var_6++) {
      if(var_5 istouching(var_2[var_6])) {
        if(isdefined(var_5.trig)) {
          var_0[var_0.size] = "Radio at " + var_5.origin + " is touching more than one \"radiotrigger\" trigger";
          var_4 = 1;
          break;
        }

        var_5.trig = var_2[var_6];
        break;
      }
    }

    if(!isdefined(var_5.trig)) {
      if(!var_4) {
        var_0[var_0.size] = "Radio at " + var_5.origin + " is not inside any \"radiotrigger\" trigger";
        continue;
      }
    }

    var_5.trigorigin = var_5.trig.origin;
    var_7 = [];
    var_7[0] = var_5;
    var_8 = getentarray(var_5.target, "targetname");

    for (var_6 = 0; var_6 < var_8.size; var_6++)
      var_7[var_7.size] = var_8[var_6];

    var_5.visuals = var_7;
    var_5 makeradioinvisible();
    var_5.visible = 0;
  }

  if(var_0.size > 0) {
    for (var_3 = 0; var_3 < var_0.size; var_3++) {

    }

    common_scripts\utility::error("Map errors. See above");
    maps\mp\gametypes\_callbacksetup::abortlevel();
  } else {
    level.radios = var_1;
    level.prevradio = undefined;
    level.prevradio2 = undefined;
  }
}

makeradiovisible() {
  maps\mp\gametypes\_gameobjects::setmodelvisibility(1);

  for (var_0 = 0; var_0 < self.visuals.size; var_0++) {
    if(self.visuals[var_0].classname == "script_brushmodel")
      self.visuals[var_0] disconnectpaths();
  }
}

makeradioinvisible() {
  maps\mp\gametypes\_gameobjects::setmodelvisibility(0);

  for (var_0 = 0; var_0 < self.visuals.size; var_0++) {
    if(self.visuals[var_0].classname == "script_brushmodel")
      self.visuals[var_0] connectpaths();
  }
}

makeradioactive() {
  self.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral", self.trig, self.visuals, self.origin - self.trigorigin + level.iconoffset);
  self.gameobject makeradioinvisible();
  self.visible = 0;
  self.trig.useobj = self.gameobject;
  setupnearbyspawns();
}

makeradioinactive() {
  self.gameobject maps\mp\gametypes\_gameobjects::deleteuseobject();
  self.gameobject = undefined;
}

setupnearbyspawns() {
  var_0 = level.spawn_all;

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].distsq = distancesquared(var_0[var_1].origin, self.origin);

  for (var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for (var_3 = var_1 - 1; var_3 >= 0 && var_2.distsq < var_0[var_3].distsq; var_3--)
      var_0[var_3 + 1] = var_0[var_3];

    var_0[var_3 + 1] = var_2;
  }

  var_4 = [];
  var_5 = [];
  var_6 = var_0.size / 3;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_1 <= var_6 || var_0[var_1].distsq <= 490000)
      var_4[var_4.size] = var_0[var_1];

    if(var_1 > var_6 || var_0[var_1].distsq > 1000000) {
      if(var_5.size < 10 || var_0[var_1].distsq < 2250000)
        var_5[var_5.size] = var_0[var_1];
    }
  }

  self.gameobject.nearspawns = var_4;
  self.gameobject.outerspawns = var_5;
}

pickradiotospawn() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3.dist = 0;

    if(var_3.team == "allies") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(!var_0.size || !var_1.size) {
    for (var_5 = level.radios[randomint(level.radios.size)]; isdefined(level.prevradio) && var_5 == level.prevradio; var_5 = level.radios[randomint(level.radios.size)]) {

    }

    level.prevradio2 = level.prevradio;
    level.prevradio = var_5;
    return var_5;
  }

  for (var_6 = 0; var_6 < var_0.size; var_6++) {
    for (var_7 = var_6 + 1; var_7 < var_0.size; var_7++) {
      var_8 = distancesquared(var_0[var_6].origin, var_0[var_7].origin);
      var_0[var_6].dist = var_0[var_6].dist + var_8;
      var_0[var_7].dist = var_0[var_7].dist + var_8;
    }
  }

  for (var_6 = 0; var_6 < var_1.size; var_6++) {
    for (var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6].dist = var_1[var_6].dist + var_8;
      var_1[var_7].dist = var_1[var_7].dist + var_8;
    }
  }

  var_9 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["allies"] = var_9.origin;
  var_9 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3.dist < var_9.dist)
      var_9 = var_3;
  }

  var_12["axis"] = var_1[0].origin;
  var_15 = undefined;
  var_16 = undefined;

  for (var_6 = 0; var_6 < level.radios.size; var_6++) {
    var_5 = level.radios[var_6];
    var_17 = abs(distance(var_5.origin, var_12["allies"]) - distance(var_5.origin, var_12["axis"]));

    if(isdefined(level.prevradio) && var_5 == level.prevradio) {
      continue;
    }
    if(isdefined(level.prevradio2) && var_5 == level.prevradio2) {
      if(level.radios.size > 2)
        continue;
      else
        var_17 = var_17 + 512;
    }

    if(!isdefined(var_16) || var_17 < var_16) {
      var_16 = var_17;
      var_15 = var_5;
    }
  }

  level.prevradio2 = level.prevradio;
  level.prevradio = var_15;
  return var_15;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;

  if(!isplayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::isfriendlyfire(var_10, var_1)) {
    return;
  }
  if(var_1 == var_10) {
    return;
  }
  if(isdefined(var_4) && maps\mp\_utility::iskillstreakweapon(var_4)) {
    return;
  }
  if(!isdefined(level.radioobject)) {
    return;
  }
  var_11 = level.radioobject maps\mp\gametypes\_gameobjects::getclaimteam();

  if(var_1 istouching(level.radioobject.trigger)) {
    if(var_11 == var_1.team && !level.radioobject.stalemate) {
      var_1 thread maps\mp\_events::killwhilecapture(var_10, var_9);
      return;
    }
  }

  var_12 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();

  if(var_10 istouching(level.radioobject.trigger)) {
    if(var_12 == var_1.team)
      var_1 thread maps\mp\_events::defendobjectiveevent(var_10, var_9);
  }
}