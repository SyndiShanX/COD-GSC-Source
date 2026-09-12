/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops_map.gsc
***********************************************/

function init() {
  if(level.gametype != "tac_ops" && getsubstr(scripts\mp\utility\game::getgametype(), 0, 3) != "to_") {
    return;
  }

  level.tacopsmap = spawnStruct();
  var_0 = level.tacopsmap;
  var_0.mapconfigs = [];
  var_0.activeconfigs = [];
  var_0.globalspawnareas = [];
  var_0.globalspawnareas["allies"] = [];
  var_0.globalspawnareas["axis"] = [];
  setupconfigentities();
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function createmapconfig(var_0, var_1) {
  var_2 = level.tacopsmap;
  var_2.mapconfigs[var_0] = var_1;
  var_1.ref = var_0;
  var_1.spawnareas = [];
  var_1.spawnareas["allies"] = [];
  var_1.spawnareas["axis"] = [];
  var_1.mappositions = [];
  var_1.mappositions["allies"] = [];
  var_1.mappositions["axis"] = [];
  return var_1;
}

function mapconfigexists(var_0) {
  return isDefined(level.tacopsmap) && isDefined(level.tacopsmap.mapconfigs[var_0]);
}

function setactivemapconfig(var_0, var_1) {
  if(!mapconfigexists(var_0)) {
    clearactivemapconfigs();
    return;
  }

  if(isDefined(level.tacopsmap.activeconfigs[var_1]) && level.tacopsmap.mapconfigs[var_0] == level.tacopsmap.activeconfigs[var_1]) {
    return;
  }

  level.tacopsmap.activeconfigs[var_1] = level.tacopsmap.mapconfigs[var_0];
  level notify("tac_ops_map_changed");
}

function getactivemapconfig(var_0) {
  return level.tacopsmap.activeconfigs[self.team];
}

function clearactivemapconfigs() {
  level.tacopsmap.activeconfigs = [];
  level notify("tac_ops_map_cleared");
}

function setteammapposition(var_0, var_1, var_2) {
  if(!mapconfigexists(var_0)) {
    createmapconfig(var_0);
  }

  var_3 = level.tacopsmap.mapconfigs[var_0];
  var_3.mappositions[var_1] = var_2;
}

function initspawnarea(var_0, var_1, var_2) {
  var_3 = tablelookuprownum("mp/tac_ops_map_spawns.csv", 0, var_2);
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_1.anchorentity = var_4;
  var_1.typeid = var_3;
  var_1.typeref = var_2;
  var_1.team = var_0;
  var_1.enabled = 1;

  if(isDefined(var_1.dynamicent)) {
    var_4 linkTo(var_1.dynamicent);
    return;
  }

  if(isDefined(var_1.target)) {
    var_1.areatriggers = getEntArray(var_1.target, "targetname");
    return;
  }
}

function addspawnareatoconfig(var_0, var_1, var_2, var_3) {
  if(!mapconfigexists(var_0)) {
    createmapconfig(var_0);
  }

  var_4 = level.tacopsmap.mapconfigs[var_0];
  initspawnarea(var_1, var_2, var_3);
  var_4.spawnareas[var_1][var_4.spawnareas[var_1].size] = var_2;
}

function addglobalspawnarea(var_0, var_1, var_2, var_3) {
  var_4 = level.tacopsmap;
  initspawnarea(var_1, var_2, var_3);
  var_4.globalspawnareas[var_1][var_0] = var_2;
}

function removeglobalspawnarea(var_0, var_1) {
  level.tacopsmap.globalspawnareas[var_1][var_0] = undefined;
  level notify("tac_ops_map_changed");
}

function refreshplayerspawnareaomnvars() {
  var_0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var_0)) {
    for(var_1 = 0; var_1 < 8; var_1++) {
      self setclientomnvar("ui_tom_spawn_entity_" + var_1, undefined);
      self setclientomnvar("ui_tom_spawn_id_" + var_1, -1);
    }
  }

  var_2 = level.tacopsmap.globalspawnareas[self.team].size;
  var_3 = var_0.spawnareas[self.team].size + var_2;
  var_4 = 0;

  foreach(var_6 in level.tacopsmap.globalspawnareas[self.team]) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_4, var_6.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + var_4, var_6.typeid);
    var_4++;
  }

  for(var_1 = 0; var_1 < var_0.spawnareas[self.team].size; var_1++) {
    var_8 = var_0.spawnareas[self.team][var_1];

    if(istrue(var_8.enabled)) {
      self setclientomnvar("ui_tom_spawn_entity_" + var_4, var_8.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var_4, var_8.typeid);
      var_4++;
    }
  }

  for(var_1 = var_4; var_1 < 8; var_1++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var_1, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var_1, -1);
  }
}

function waitforspawnselection() {
  if(isai(self)) {
    return;
  }

  var_0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var_0)) {
    return;
  }

  waitframe();
  runtacopsmap(var_0);
}

function runtacopsmap(var_0) {
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.5;
  var_1 = spawn("script_model", self getvieworigin());
  var_1 setModel("tag_origin");
  var_1.angles = self getplayerangles();
  self.tacopsmapcameraent = var_1;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_1, "tag_origin", 1);
  movecameratomappos(var_1, var_0.mappositions[self.team].origin, var_0.mappositions[self.team].angles, self);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  refreshplayerspawnareaomnvars();
  self.deathspectatepos = var_0.mappositions[self.team].origin;
  self.deathspectateangles = var_0.mappositions[self.team].angles;
  showteamicons();
  var_2 = var_0;

  for(;;) {
    var_3 = watchendconditions();
    var_4 = 1;

    switch (var_3) {
      case "tac_ops_map_selection_made":
        thread clearselectedareaonspawn();
        thread runslamzoomonspawn();
        var_4 = 1;
        closetacopsmap();
        break;
      case "tac_ops_map_changed":
        self setclientomnvar("ui_tac_ops_map_open", 0);
        var_2 = level.tacopsmap.activeconfigs[self.team];
        movecameratomappos(var_1, var_2.mappositions[self.team].origin, var_2.mappositions[self.team].angles);
        self setclientomnvar("ui_tac_ops_map_open", 1);
        refreshplayerspawnareaomnvars();
        var_4 = 0;
        break;
      case "tac_ops_map_cleared":
        var_4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "spawned_player":
        var_4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "tac_ops_map_game_ended":
        var_4 = 0;
        closetacopsmap();
        stopcamera();
        break;
      default:
        break;
    }

    if(var_4) {
      return;
    }
  }
}

function watchendconditions() {
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  var_0 = scripts\engine\utility::ref_143B7("tac_ops_map_selection_made", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended");
  self notify("tac_ops_end_condition_met");
  return var_0;
}

function endconditionwatcher_selectionmade() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "tac_ops_spawn_area_selected") {
      var_2 = undefined;
      var_3 = level.tacopsmap.activeconfigs[self.team];

      foreach(var_5 in var_3.spawnareas[self.team]) {
        if(var_1 == var_5.anchorentity getentitynumber()) {
          var_2 = var_5;
          break;
        }
      }

      if(!isDefined(var_2)) {
        foreach(var_5 in level.tacopsmap.globalspawnareas[self.team]) {
          if(var_1 == var_5.anchorentity getentitynumber()) {
            var_2 = var_5;
            break;
          }
        }
      }

      self.tacopsmapselectedarea = var_2;
      self notify("tac_ops_map_selection_made");
      break;
    }
  }
}

function endconditionwatcher_gameended() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_GameEnded()");
  self endon("endConditionWatcher_GameEnded()");
  level waittill("game_ended");
  self notify("tac_ops_map_game_ended");
}

function endconditionwatcher_mapcleared() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapCleared()");
  self endon("endConditionWatcher_MapCleared()");
  level waittill("tac_ops_map_cleared");
  self notify("tac_ops_map_cleared");
}

function endconditionwatcher_mapchanged() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_MapChanged()");
  self endon("endConditionWatcher_MapChanged()");
  level waittill("tac_ops_map_changed");
  self notify("tac_ops_map_changed");
}

function showteamicons() {
  if(!isDefined(level.runtacopsshowteamicons)) {
    level.runtacopsshowteamicons = [];
  }

  if(scripts\mp\utility\teams::getteamdata(self.team, "teamCount")) {
    var_0 = 0;
    level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()] = [];

    foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      if(var_2 == self) {
        continue;
      }

      var_3 = var_2.origin;
      var_4 = newclienthudelem(self);
      var_4.x = var_3[0];
      var_4.y = var_3[1];
      var_4.z = var_3[2] + 32;
      var_4.alpha = 1;
      var_4.archived = 0;
      var_4.showinkillcam = 0;

      if(level.splitscreen) {
        var_4 setshader("tacops_spotted_shield_blue", 10, 10);
      } else {
        var_4 setshader("tacops_spotted_shield_blue", 5, 5);
      }

      var_4 setwaypoint(0);
      var_4 settargetEnt(var_2);
      level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()][var_0] = var_4;
      var_0++;
    }

    return;
  }
}

function cleanupteamicons() {
  foreach(var_1 in level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()]) {
    var_1 destroy();
  }

  level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()] = undefined;
}

function closetacopsmap() {
  self setclientomnvar("ui_tac_ops_map_open", 0);
  cleanupteamicons();
}

function stopcamera() {
  self cameraunlink();
  self.tacopsmapcameraent delete();
  self.tacopsmapcameraent = undefined;
  self.isusingtacopsmapcamera = undefined;
}

function clearselectedareaonspawn() {
  self waittill("spawned_player");
  self.tacopsmapselectedarea = undefined;
}

function runslamzoomonspawn() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.tacopsmapcameraent, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.tacopsmapcameraent moveTo(var_0, 0.5);
  self.tacopsmapcameraent rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  stopcamera();
}

function playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0;
  wait 0.4;
  var_0 destroy();
}

function movecameratomappos(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_0, 1, 0.5, 0.5);
  self rotateTo(var_1, 1, 0.5, 0.5);
  thread startoperatorsound();
  wait 1.1;
}

function setupconfigentities() {
  var_0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(var_3 == "to_toblitz") {
      var_3 = "to_blitz";
    }

    createmapconfig(var_3, var_2);
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "to_spawn_area_allies":
          addspawnareatoconfig(var_3, "allies", var_6, var_6.script_noteworthy);
          break;
        case "to_spawn_area_axis":
          addspawnareatoconfig(var_3, "axis", var_6, var_6.script_noteworthy);
          break;
        case "to_allies_camera":
          setteammapposition(var_3, "allies", var_6);
          break;
        case "to_axis_camera":
          setteammapposition(var_3, "axis", var_6);
          break;
      }
    }
  }
}

function setupspawnareas() {
  var_0 = level.tacopsmap;

  foreach(var_2 in var_0.mapconfigs) {
    foreach(var_4 in var_2.spawnareas) {
      foreach(var_6 in var_4) {
        var_6.spawnlist = [];

        foreach(var_8 in level.spawnpoints) {
          foreach(var_10 in var_6.areatriggers) {
            if(ispointinvolume(var_8.origin, var_10)) {
              var_6.spawnlist[var_8.index] = var_8;
              break;
            }
          }
        }
      }
    }
  }
}

function filterspawnpoints(var_0, var_1) {
  if(isDefined(self.tacopsmapselectedarea)) {
    var_2 = [];

    foreach(var_4 in var_0) {
      if(isDefined(self.tacopsmapselectedarea.spawnlist) && isDefined(self.tacopsmapselectedarea.spawnlist[var_4.index])) {
        var_2 = var_4;
      }
    }

    return var_2;
  }

  return var_4;
}

function adddynamicspawnarea(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_1.origin;
  var_4.dynamicent = var_1;
  var_4.script_noteworthy = var_3;
  var_4.areatriggers = [];
  addspawnareatoconfig(var_0, var_2, var_4, var_3);
}

function startoperatorsound() {
  self endon("game_ended");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }

  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var_1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  var_2 = "dx_mpo_" + var_1 + "op_drone_deathchatter";

  if(soundexists(var_2)) {
    var_0 playLoopSound(var_2);
  } else {
    var_0 playLoopSound("dx_mpo_usop_drone_deathchatter");
  }

  self.spawnselectionoperatorsound = 1;
  self waittill("spawned_player");
  self clearsoundsubmix("iw8_mp_spawn_camera");
  var_0 stoploopsound(var_2);
  var_0 delete();
  self.spawnselectionoperatorsound = 0;
}