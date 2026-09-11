/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops_map.gsc
***********************************************/

function init() {
  if(level.gametype != "tac_ops" && getsubstr(scripts\mp\utility\game::getgametype(), 0, 3) != "to_") {
    return;
  }

  level.tacopsmap = spawnStruct();
  var0 = level.tacopsmap;
  var0.mapconfigs = [];
  var0.activeconfigs = [];
  var0.globalspawnareas = [];
  var0.globalspawnareas["allies"] = [];
  var0.globalspawnareas["axis"] = [];
  setupconfigentities();
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function createmapconfig(var0, var1) {
  var2 = level.tacopsmap;
  var2.mapconfigs[var0] = var1;
  var1.ref = var0;
  var1.spawnareas = [];
  var1.spawnareas["allies"] = [];
  var1.spawnareas["axis"] = [];
  var1.mappositions = [];
  var1.mappositions["allies"] = [];
  var1.mappositions["axis"] = [];
  return var1;
}

function mapconfigexists(var0) {
  return isDefined(level.tacopsmap) && isDefined(level.tacopsmap.mapconfigs[var0]);
}

function setactivemapconfig(var0, var1) {
  if(!mapconfigexists(var0)) {
    clearactivemapconfigs();
    return;
  }

  if(isDefined(level.tacopsmap.activeconfigs[var1]) && level.tacopsmap.mapconfigs[var0] == level.tacopsmap.activeconfigs[var1]) {
    return;
  }

  level.tacopsmap.activeconfigs[var1] = level.tacopsmap.mapconfigs[var0];
  level notify("tac_ops_map_changed");
}

function getactivemapconfig(var0) {
  return level.tacopsmap.activeconfigs[self.team];
}

function clearactivemapconfigs() {
  level.tacopsmap.activeconfigs = [];
  level notify("tac_ops_map_cleared");
}

function setteammapposition(var0, var1, var2) {
  if(!mapconfigexists(var0)) {
    createmapconfig(var0);
  }

  var3 = level.tacopsmap.mapconfigs[var0];
  var3.mappositions[var1] = var2;
}

function initspawnarea(var0, var1, var2) {
  var3 = tablelookuprownum("mp/tac_ops_map_spawns.csv", 0, var2);
  var4 = spawn("script_model", var1.origin);
  var4 setModel("tag_origin");
  var1.anchorentity = var4;
  var1.typeid = var3;
  var1.typeref = var2;
  var1.team = var0;
  var1.enabled = 1;

  if(isDefined(var1.dynamicent)) {
    var4 linkTo(var1.dynamicent);
    return;
  }

  if(isDefined(var1.target)) {
    var1.areatriggers = getEntArray(var1.target, "targetname");
    return;
  }
}

function addspawnareatoconfig(var0, var1, var2, var3) {
  if(!mapconfigexists(var0)) {
    createmapconfig(var0);
  }

  var4 = level.tacopsmap.mapconfigs[var0];
  initspawnarea(var1, var2, var3);
  var4.spawnareas[var1][var4.spawnareas[var1].size] = var2;
}

function addglobalspawnarea(var0, var1, var2, var3) {
  var4 = level.tacopsmap;
  initspawnarea(var1, var2, var3);
  var4.globalspawnareas[var1][var0] = var2;
}

function removeglobalspawnarea(var0, var1) {
  level.tacopsmap.globalspawnareas[var1][var0] = undefined;
  level notify("tac_ops_map_changed");
}

function refreshplayerspawnareaomnvars() {
  var0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var0)) {
    for(var1 = 0; var1 < 8; var1++) {
      self setclientomnvar("ui_tom_spawn_entity_" + var1, undefined);
      self setclientomnvar("ui_tom_spawn_id_" + var1, -1);
    }
  }

  var2 = level.tacopsmap.globalspawnareas[self.team].size;
  var3 = var0.spawnareas[self.team].size + var2;
  var4 = 0;

  foreach(var6 in level.tacopsmap.globalspawnareas[self.team]) {
    self setclientomnvar("ui_tom_spawn_entity_" + var4, var6.anchorentity);
    self setclientomnvar("ui_tom_spawn_id_" + var4, var6.typeid);
    var4++;
  }

  for(var1 = 0; var1 < var0.spawnareas[self.team].size; var1++) {
    var8 = var0.spawnareas[self.team][var1];

    if(istrue(var8.enabled)) {
      self setclientomnvar("ui_tom_spawn_entity_" + var4, var8.anchorentity);
      self setclientomnvar("ui_tom_spawn_id_" + var4, var8.typeid);
      var4++;
    }
  }

  for(var1 = var4; var1 < 8; var1++) {
    self setclientomnvar("ui_tom_spawn_entity_" + var1, undefined);
    self setclientomnvar("ui_tom_spawn_id_" + var1, -1);
  }
}

function waitforspawnselection() {
  if(isai(self)) {
    return;
  }

  var0 = level.tacopsmap.activeconfigs[self.team];

  if(!isDefined(var0)) {
    return;
  }

  waitframe();
  runtacopsmap(var0);
}

function runtacopsmap(var0) {
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  if(isDefined(self.lastdeathangles)) {
    self setplayerangles(self.lastdeathangles);
  }

  wait 0.5;
  var1 = spawn("script_model", self getvieworigin());
  var1 setModel("tag_origin");
  var1.angles = self getplayerangles();
  self.tacopsmapcameraent = var1;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var1, "tag_origin", 1);
  movecameratomappos(var1, var0.mappositions[self.team].origin, var0.mappositions[self.team].angles, self);
  self setclientomnvar("ui_tac_ops_map_open", 1);
  refreshplayerspawnareaomnvars();
  self.deathspectatepos = var0.mappositions[self.team].origin;
  self.deathspectateangles = var0.mappositions[self.team].angles;
  showteamicons();
  var2 = var0;

  for(;;) {
    var3 = watchendconditions();
    var4 = 1;

    switch (var3) {
      case "tac_ops_map_selection_made":
        thread clearselectedareaonspawn();
        thread runslamzoomonspawn();
        var4 = 1;
        closetacopsmap();
        break;
      case "tac_ops_map_changed":
        self setclientomnvar("ui_tac_ops_map_open", 0);
        var2 = level.tacopsmap.activeconfigs[self.team];
        movecameratomappos(var1, var2.mappositions[self.team].origin, var2.mappositions[self.team].angles);
        self setclientomnvar("ui_tac_ops_map_open", 1);
        refreshplayerspawnareaomnvars();
        var4 = 0;
        break;
      case "tac_ops_map_cleared":
        var4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "spawned_player":
        var4 = 1;
        closetacopsmap();
        stopcamera();
        break;
      case "tac_ops_map_game_ended":
        var4 = 0;
        closetacopsmap();
        stopcamera();
        break;
      default:
        break;
    }

    if(var4) {
      return;
    }
  }
}

function watchendconditions() {
  thread endconditionwatcher_gameended();
  thread endconditionwatcher_selectionmade();
  thread endconditionwatcher_mapcleared();
  thread endconditionwatcher_mapchanged();
  var0 = scripts\engine\utility::ref_143b7("tac_ops_map_selection_made", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended");
  self notify("tac_ops_end_condition_met");
  return var0;
}

function endconditionwatcher_selectionmade() {
  self endon("tac_ops_end_condition_met");
  self notify("endConditionWatcher_SelectionMade()");
  self endon("endConditionWatcher_SelectionMade()");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "tac_ops_spawn_area_selected") {
      var2 = undefined;
      var3 = level.tacopsmap.activeconfigs[self.team];

      foreach(var5 in var3.spawnareas[self.team]) {
        if(var1 == var5.anchorentity getentitynumber()) {
          var2 = var5;
          break;
        }
      }

      if(!isDefined(var2)) {
        foreach(var5 in level.tacopsmap.globalspawnareas[self.team]) {
          if(var1 == var5.anchorentity getentitynumber()) {
            var2 = var5;
            break;
          }
        }
      }

      self.tacopsmapselectedarea = var2;
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
    var0 = 0;
    level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()] = [];

    foreach(var2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      if(var2 == self) {
        continue;
      }

      var3 = var2.origin;
      var4 = newclienthudelem(self);
      var4.x = var3[0];
      var4.y = var3[1];
      var4.z = var3[2] + 32;
      var4.alpha = 1;
      var4.archived = 0;
      var4.showinkillcam = 0;

      if(level.splitscreen) {
        var4 setshader("tacops_spotted_shield_blue", 10, 10);
      } else {
        var4 setshader("tacops_spotted_shield_blue", 5, 5);
      }

      var4 setwaypoint(0);
      var4 settargetEnt(var2);
      level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()][var0] = var4;
      var0++;
    }

    return;
  }
}

function cleanupteamicons() {
  foreach(var1 in level.runtacopsshowteamicons[scripts\mp\utility\player::getuniqueid()]) {
    var1 destroy();
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
  var0 = self getEye();
  var1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(self.tacopsmapcameraent, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self.tacopsmapcameraent moveTo(var0, 0.5);
  self.tacopsmapcameraent rotateTo(var1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("playing");
  stopcamera();
}

function playslamzoomflash() {
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0 setshader("white", 640, 480);
  var0 fadeovertime(0.4);
  var0.alpha = 0;
  wait 0.4;
  var0 destroy();
}

function movecameratomappos(var0, var1, var2) {
  var3 = 1;
  var4 = 1;
  self moveTo(var0, 1, 0.5, 0.5);
  self rotateTo(var1, 1, 0.5, 0.5);
  thread startoperatorsound();
  wait 1.1;
}

function setupconfigentities() {
  var0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;

    if(var3 == "to_toblitz") {
      var3 = "to_blitz";
    }

    createmapconfig(var3, var2);
    var4 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    foreach(var6 in var4) {
      switch (var6.script_label) {
        case "to_spawn_area_allies":
          addspawnareatoconfig(var3, "allies", var6, var6.script_noteworthy);
          break;
        case "to_spawn_area_axis":
          addspawnareatoconfig(var3, "axis", var6, var6.script_noteworthy);
          break;
        case "to_allies_camera":
          setteammapposition(var3, "allies", var6);
          break;
        case "to_axis_camera":
          setteammapposition(var3, "axis", var6);
          break;
      }
    }
  }
}

function setupspawnareas() {
  var0 = level.tacopsmap;

  foreach(var2 in var0.mapconfigs) {
    foreach(var4 in var2.spawnareas) {
      foreach(var6 in var4) {
        var6.spawnlist = [];

        foreach(var8 in level.spawnpoints) {
          foreach(var10 in var6.areatriggers) {
            if(ispointinvolume(var8.origin, var10)) {
              var6.spawnlist[var8.index] = var8;
              break;
            }
          }
        }
      }
    }
  }
}

function filterspawnpoints(var0, var1) {
  if(isDefined(self.tacopsmapselectedarea)) {
    var2 = [];

    foreach(var4 in var0) {
      if(isDefined(self.tacopsmapselectedarea.spawnlist) && isDefined(self.tacopsmapselectedarea.spawnlist[var4.index])) {
        var2 = var4;
      }
    }

    return var2;
  }

  return var4;
}

function adddynamicspawnarea(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.origin = var1.origin;
  var4.dynamicent = var1;
  var4.script_noteworthy = var3;
  var4.areatriggers = [];
  addspawnareatoconfig(var0, var2, var4, var3);
}

function startoperatorsound() {
  self endon("game_ended");

  if(istrue(self.spawnselectionoperatorsound)) {
    return;
  }

  var0 = spawn("script_origin", (0, 0, 0));
  var0 showonlytoplayer(self);
  self setsoundsubmix("iw8_mp_spawn_camera");
  var1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  var2 = "dx_mpo_" + var1 + "op_drone_deathchatter";

  if(soundexists(var2)) {
    var0 playLoopSound(var2);
  } else {
    var0 playLoopSound("dx_mpo_usop_drone_deathchatter");
  }

  self.spawnselectionoperatorsound = 1;
  self waittill("spawned_player");
  self clearsoundsubmix("iw8_mp_spawn_camera");
  var0 stoploopsound(var2);
  var0 delete();
  self.spawnselectionoperatorsound = 0;
}