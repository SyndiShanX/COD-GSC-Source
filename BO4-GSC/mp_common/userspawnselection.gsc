/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\userspawnselection.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic_spawn;

#namespace userspawnselection;

autoexec __init__system__() {
  system::register(#"userspawnselection", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.spawnselect)) {
    level.spawnselect = spawnStruct();
  }

  level.spawnselect.vox_plr_1_revive_down_2 = [];
  level.spawnselect.lastchosenplayerspawns = [];
  level.spawnselectenabled = getgametypesetting(#"spawnselectenabled");
  level.usespawngroups = getgametypesetting(#"usespawngroups");
  level.spawngroups = [];
  level.next_spawn_group_index = 0;
  level.playerspawnedfromspawnbeacon = &function_a316ca82;
  level.registeravailablespawnbeacon = &registeravailablespawnbeacon;
  level.var_13edf38c = &removespawnbeacon;
  level.spawnselect_timelimit_ms = getdvarint(#"spawnselect_timelimit_ms", 10000);

  if(isspawnselectenabled()) {
    callback::on_start_gametype(&on_start_gametype);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_spawned(&onplayerspawned);
    spawning::function_754c78a6(&function_259770ba);
    level.var_b8622956 = &filter_spawnpoints;
  }

  registerclientfields();
}

function_127864f2(player) {
  foreach(spawnbeacon in level.spawnselect.vox_plr_1_revive_down_2) {
    if(player == spawnbeacon.owner) {
      return true;
    }
  }

  return false;
}

function_93076e1d() {
  if(!isDefined(level.spawnselect)) {
    level.spawnselect = spawnStruct();
  }

  level.spawnselect.var_d302b268 = 1;
}

function_a316ca82(player) {
  spawnbeacon = player getspawnbeaconplayerspawnedfrom();

  if(isDefined(spawnbeacon)) {
    return true;
  }

  return false;
}

onplayerspawned() {
  closespawnselect();

  if(!isDefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
    return;
  }

  if(level.spawnselect.lastchosenplayerspawns[self.clientid] == -2) {
    level.spawnselect.lastchosenplayerspawns[self.clientid] = -1;
  }
}

registeravailablespawnbeacon(spawnbeaconid, spawnbeacon) {
  assert(!isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawnbeaconid]));
  level.spawnselect.vox_plr_1_revive_down_2[spawnbeaconid] = spawnbeacon;
}

removespawnbeacon(spawnbeaconid) {
  if(!isDefined(spawnbeaconid) || !isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawnbeaconid])) {
    return;
  }

  spawnbeacon = level.spawnselect.vox_plr_1_revive_down_2[spawnbeaconid];

  if(isDefined(spawnbeacon) && isDefined(spawnbeacon.spawnlist)) {
    clearspawnpoints(spawnbeacon.spawnlist);
  }

  level.spawnselect.vox_plr_1_revive_down_2[spawnbeaconid] = undefined;
}

isspawnselectenabled() {
  return level.spawnselectenabled;
}

getspawngroup(index) {
  return level.spawngroups[index];
}

getspawngroupbyname(target) {
  retunrarr = [];

  foreach(spawngroup in level.spawngroups) {
    if(spawngroup.target == target) {
      array::add(retunrarr, spawngroup);
    }
  }

  return retunrarr;
}

getspawngroupsforzone(zoneindex) {
  returnarray = [];

  foreach(spawngroup in level.spawngroups) {
    if(spawngroup.script_zoneindex == zoneindex) {
      array::add(returnarray, spawngroup);
    }
  }

  return returnarray;
}

getspawngroupwithscriptnoteworthy(script_noteworthy) {
  returnarray = [];

  foreach(spawngroup in level.spawngroups) {
    if(isDefined(spawngroup.script_noteworthy) && spawngroup.script_noteworthy == script_noteworthy) {
      array::add(returnarray, spawngroup);
    }
  }

  return returnarray;
}

changeusability(isusable) {
  usestatusmodel = getclientfieldprefix(self.uiindex) + "useStatus";
  self.ison = isusable;
  level clientfield::set_world_uimodel(usestatusmodel, isusable);
}

changevisibility(isvisible) {
  visstatusmodel = getclientfieldprefix(self.uiindex) + "visStatus";
  level clientfield::set_world_uimodel(visstatusmodel, isvisible);
}

changeteam(teamname) {
  teamclientfieldindex = getteamclientfieldvalue(teamname);
  teammodel = getclientfieldprefix(self.uiindex) + "team";
  level clientfield::set_world_uimodel(teammodel, teamclientfieldindex);
  enablespawnpointlist(self.spawnlist, util::getteammask(teamname));
}

setspawngroupsenabled() {
  if(!isDefined(level.spawngroups)) {
    return;
  }

  foreach(spawngroup in level.spawngroups) {
    spawngroup changeusability(1);
    spawngroup changevisibility(1);
  }
}

canplayerusespawngroup(spawngroupindex) {
  return true;
}

setspawngroupforplayer(selectedspawngroupindex) {
  level.spawnselect.lastchosenplayerspawns[self.clientid] = selectedspawngroupindex;
}

getspawnbeaconplayerspawnedfrom() {
  player = self;

  if(level.spawnselectenabled !== 1 && level.var_6cd68fbe === 1) {
    return player.var_583f6cce;
  }

  if(isDefined(player.var_583f6cce) && strstartswith(level.gametype, "sd")) {
    return player.var_583f6cce;
  }

  if(!isDefined(level.spawnselect.lastchosenplayerspawns[player.clientid])) {
    return undefined;
  }

  spawbeaconid = level.spawnselect.lastchosenplayerspawns[player.clientid];

  if(spawbeaconid == -1 || spawbeaconid == -2) {
    return undefined;
  }

  if(!isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid])) {
    return undefined;
  }

  if(isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].var_34d7dddd) && level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].var_34d7dddd) {
    return undefined;
  }

  return level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid];
}

fillspawnlists() {
  foreach(spawngroup in level.spawngroups) {
    spawngroup setupspawnlistforspawngroup(spawngroup.target, spawngroup.spawnlist, util::get_team_mapping(spawngroup.script_team));
  }
}

clearcacheforplayer() {
  if(!isDefined(self) || !isDefined(self.clientid)) {
    return;
  }

  if(isDefined(level.spawnselect.lastchosenplayerspawns) && isDefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
    level.spawnselect.lastchosenplayerspawns[self.clientid] = undefined;
  }
}

clearcacheforallplayers() {
  level.spawnselect.lastchosenplayerspawns = [];
}

getlastchosenspawngroupforplayer() {
  if(!isDefined(level.spawnselect.lastchosenplayerspawns[self.clientid])) {
    return undefined;
  }

  if(level.spawnselect.lastchosenplayerspawns[self.clientid] == -2) {
    return undefined;
  }

  lastchosenid = level.spawnselect.lastchosenplayerspawns[self.clientid];

  if(!isDefined(level.spawngroups[lastchosenid])) {
    return undefined;
  }

  return level.spawngroups[lastchosenid];
}

onroundchange() {
  clearcacheforallplayers();
  supressspawnselectionmenuforallplayers();
  closespawnselectionmenuforallplayers();
}

function_5cd68e00() {
  player = self;
  level.spawnselect.lastchosenplayerspawns[player.clientid] = -2;
}

supressspawnselectionmenuforallplayers() {
  level.showspawnselectionmenu = [];
}

shouldshowspawnselectionmenu() {
  isbot = isbot(self);
  var_1367cd2a = (isDefined(level.spawnselect.lastchosenplayerspawns[self.clientid]) ? level.spawnselect.lastchosenplayerspawns[self.clientid] : -1) == -2;
  gameended = gamestate::is_game_over();
  nolives = level.numteamlives > 0 && game.lives[self.team] < 0;
  var_d302b268 = (isDefined(level.spawnselect.var_d302b268) ? level.spawnselect.var_d302b268 : 0) && function_127864f2(self);
  return !isbot && !var_1367cd2a && !level.infinalkillcam && !gameended && !nolives || var_d302b268;
}

activatespawnselectionmenu() {
  level.showspawnselectionmenu[self.clientid] = 1;
}

openspawnselect() {
  if(isDefined(level.var_582f7d48) && level.var_582f7d48) {
    while(isDefined(level.var_582f7d48) && level.var_582f7d48) {
      waitframe(1);
    }
  }

  self clientfield::set_player_uimodel("hudItems.showSpawnSelect", 1);
  level notify(#"hash_4c1be11f1e312a36");
}

closespawnselect() {
  self clientfield::set_player_uimodel("hudItems.showSpawnSelect", 0);
  level notify(#"hash_48b4c5f856407d62");
}

function_fed7687f() {
  return self clientfield::get_player_uimodel("hudItems.showSpawnSelect") == 1;
}

closespawnselectionmenuforallplayers() {
  players = getplayers();

  foreach(player in players) {
    player closespawnselect();
  }
}

function_b55c5868() {
  self endon(#"disconnect", #"end_respawn");
  self openspawnselect();
  self thread watchforselectiontimeout();
}

waitforspawnselection() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    waitresult = self waittill(#"menuresponse");
    menu = waitresult.menu;
    response = waitresult.response;

    if(response == "SpawnRegionFocus") {
      waitframe(1);
      continue;
    }

    var_ff3ca6eb = 0;

    if(isDefined(level.var_2fa4efc2)) {
      var_ff3ca6eb = [
        [level.var_2fa4efc2]
      ](waitresult);
    }

    if(menu == "SpawnSelect" && !var_ff3ca6eb) {
      if(isplayer(self)) {
        self setspawngroupforplayer(waitresult.intpayload);

        if(!level.infinalkillcam) {
          self killcam::function_875fc588();
        }

        self closespawnselect();
        self.var_eca4c67f = 0;
      }

      return;
    }

    waitframe(1);
  }

  self closespawnselect();
}

watchforselectiontimeout() {
  self endon(#"disconnect", #"end_respawn");
  self.spawnselect_start_time = gettime();

  while(true) {
    if(level.spawnselect_timelimit_ms - gettime() - self.spawnselect_start_time <= 0) {
      self luinotifyevent(#"force_spawn_selection");
      return;
    }

    wait 0.1;
  }
}

private on_player_disconnect() {
  self clearcacheforplayer();
}

filter_spawnpoints(spawnpoints) {
  e_player = self;

  if(!isDefined(level.spawnselect.lastchosenplayerspawns[e_player.clientid])) {
    return undefined;
  }

  spawbeaconid = level.spawnselect.lastchosenplayerspawns[e_player.clientid];

  if(spawbeaconid == -1) {
    return undefined;
  }

  if(spawbeaconid == -2) {
    return undefined;
  }

  if(!isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid])) {

    print("<dev string:x38>");

      level.spawnselect.lastchosenplayerspawns[e_player.clientid] = -1;
    return undefined;
  }

  assert(e_player getteam() == level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].team);

  if(e_player getteam() != level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].team) {
    return undefined;
  }

  assert(isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawns) && level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawns.size > 0);
  e_player.var_7007b746 = 1;
  return level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawns;
}

private function_259770ba(e_player) {
  if(!isDefined(level.spawnselect.lastchosenplayerspawns[e_player.clientid]) || level.usestartspawns) {
    return undefined;
  }

  spawbeaconid = level.spawnselect.lastchosenplayerspawns[e_player.clientid];

  if(spawbeaconid == -1) {
    return undefined;
  }

  if(spawbeaconid == -2) {
    return undefined;
  }

  if(!isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid])) {

    print("<dev string:x38>");

      level.spawnselect.lastchosenplayerspawns[e_player.clientid] = -1;
    return undefined;
  }

  if(e_player getteam() != level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].team) {

    println("<dev string:x97>");
    println("<dev string:xe0>" + spawbeaconid + "<dev string:xff>");
    println("<dev string:x103>" + e_player.team + "<dev string:xff>");

    for(index = 0; index < level.spawnselect.vox_plr_1_revive_down_2.size; index++) {
      if(!isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid])) {
        continue;
      }

      println("<dev string:x116>" + index + "<dev string:xff>");
      println("<dev string:x124>" + level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].objectiveid + "<dev string:xff>");
      println("<dev string:x135>" + level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].team + "<dev string:xff>");

      if(isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].owner.playername)) {
        println("<dev string:x13e>" + level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].owner.playername + "<dev string:xff>");
      }

      println("<dev string:x14f>");
    }

    println("<dev string:x165>" + level.numgametypereservedobjectives + "<dev string:xff>");
    println("<dev string:x17e>" + level.releasedobjectives.size + "<dev string:xff>");
    println("<dev string:x19b>");

    foreach(objid in level.releasedobjectives) {
      println(objid + "<dev string:xff>");
    }

    println("<dev string:x1b7>");

    foreach(objid in level.spawnbeaconsettings.var_e7571ff1) {
      println(objid + "<dev string:xff>");
    }

    println("<dev string:x1d6>");

      assert(e_player.team == level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].team);
    return undefined;
  }

  assert(isDefined(level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawns) && level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawns.size > 0);
  return level.spawnselect.vox_plr_1_revive_down_2[spawbeaconid].spawnlist;
}

private getclientfieldprefix(id) {
  return "spawngroupStatus." + id + ".";
}

private registerclientfields() {
  for(index = 0; index < 20; index++) {
    basename = getclientfieldprefix(index);
    clientfield::register("worlduimodel", basename + "visStatus", 1, 1, "int");
    clientfield::register("worlduimodel", basename + "useStatus", 1, 1, "int");
    clientfield::register("worlduimodel", basename + "team", 1, 2, "int");
  }

  clientfield::register("clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.killcamActive", 1, 1, "int");
  clientfield::register("worlduimodel", "hideautospawnoption", 1, 1, "int");
}

waitandenablespawngroups() {
  util::wait_network_frame(1);
  setspawngroupsenabled();
}

function_4f78b01d(shoulddisable) {
  level clientfield::set_world_uimodel("hideautospawnoption", shoulddisable);
}

on_start_gametype() {
  spawngroups = getEntArray("spawn_group_marker", "classname");

  if(!isDefined(spawngroups) || spawngroups.size == 0) {
    return;
  }

  if(level.usespawngroups) {
    spawngroupssorted = arraysort(spawngroups, (0, 0, 0), 1);

    foreach(spawngroup in spawngroupssorted) {
      if(!globallogic_spawn::function_d3d4ff67(spawngroup)) {
        continue;
      }

      setupspawngroup(spawngroup);
    }
  }

  waitandenablespawngroups();

  if(isspawnselectenabled()) {}
}

private setupspawnlistforspawngroup(spawngroupkey, spawnlistname, team) {
  rawspawns = struct::get_array(spawngroupkey, "groupname");

  if(!isDefined(rawspawns)) {
    return;
  }

  self.spawns = [];
  var_38345be7 = 0;
  var_496cfe58 = 0;
  var_12de913c = 0;
  var_3cc38ddd = 0;

  foreach(spawn in rawspawns) {
    if(!globallogic_spawn::function_d3d4ff67(spawn)) {
      continue;
    }

    if(!isDefined(spawn.enabled)) {
      spawn.enabled = -1;
    }

    array::add(self.spawns, spawn);
    var_38345be7 += spawn.origin[0];
    var_496cfe58 += spawn.origin[1];
    var_12de913c += spawn.origin[2];
    var_3cc38ddd++;
  }

  var_b5d9fb3a = undefined;

  if(var_3cc38ddd > 0) {
    var_b5d9fb3a = (var_38345be7 / var_3cc38ddd, var_496cfe58 / var_3cc38ddd, var_12de913c / var_3cc38ddd);
  }

  addspawnpoints(team, self.spawns, spawnlistname);
  return var_b5d9fb3a;
}

private setupspawngroup(spawngroup) {
  spawngroup.objectiveid = gameobjects::get_next_obj_id();

  if(level.teambased && isDefined(game.switchedsides) && game.switchedsides) {
    spawngroup.team = util::getotherteam(spawngroup.script_team);
  } else {
    spawngroup.team = spawngroup.script_team;
  }

  var_b5d9fb3a = spawngroup setupspawnlistforspawngroup(spawngroup.target, spawngroup.spawnlist, spawngroup.team);
  objectivename = spawngroup.script_objective;
  objective_add(spawngroup.objectiveid, "active", var_b5d9fb3a, objectivename);
  objective_setteam(spawngroup.objectiveid, spawngroup.team);
  level.spawnselect.vox_plr_1_revive_down_2[spawngroup.objectiveid] = spawngroup;
  spawngroup.var_34d7dddd = 1;
}

getteamclientfieldvalue(team) {
  if(!isDefined(team)) {
    return 0;
  }

  teamname = util::get_team_mapping(team);

  if(team == #"allies") {
    return 1;
  } else if(team == #"axis") {
    return 2;
  } else if(team == #"neutral") {
    return 3;
  }

  return 0;
}