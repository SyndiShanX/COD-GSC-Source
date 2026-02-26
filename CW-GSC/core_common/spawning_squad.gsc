/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawning_squad.gsc
***********************************************/

#using script_306215d6cfd5f1f4;
#using script_396f7d71538c9677;
#using script_44b0b8420eabacad;
#using script_5ee699b0aaf564c4;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectate_view;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#namespace squad_spawn;

function private autoexec __init__system__() {
  system::register(#"squad_spawning", &init, undefined, undefined, undefined);
}

function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
  spawningplayer = self;
  menu = eventstruct.menu;
  response = eventstruct.response;
  targetclientnum = eventstruct.intpayload;

  if(!isDefined(menu)) {
    menu = "";
  }

  if(!isDefined(response)) {
    response = "";
  }

  if(!isDefined(targetclientnum)) {
    targetclientnum = 0;
  }

  if(menu == "Hud_NavigableUI") {
    if(self.sessionstate === "playing") {
      return;
    }

    if(response == "spectatePlayer") {
      var_26c5324a = getentbynum(targetclientnum);
      self.var_a271f211 = targetclientnum;

      if(isalive(var_26c5324a)) {
        spawningplayer spectating::function_26c5324a(var_26c5324a);
      }

      return;
    }

    if(response == "spectateObjective") {
      spawningplayer namespace_99c84a33::function_99c84a33(targetclientnum);
      return;
    }

    if(response == "spawnOnPlayer") {
      spawningplayer.spawn.var_e8f87696 = 0;
      spawningplayer.spawn.response = "spawnOnPlayer";
      spawningplayer.var_d690fc0b = getentbynum(targetclientnum);
      return;
    }

    if(response == "spawnOnObjective") {
      spawningplayer.spawn.var_e8f87696 = 0;
      spawningplayer.spawn.response = "spawnOnObjective";
      spawningplayer.var_612ad92b = targetclientnum;
      return;
    }

    if(response == "autoSpawn") {
      spawningplayer.spawn.var_e8f87696 = 0;
      spawningplayer.spawn.response = "autoSpawn";
    }
  }
}

function init() {
  level.var_d0252074 = isDefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0;

  if(!function_d072f205()) {
    return;
  }

  match_record::set_stat(#"hash_405bc5b0e581dd5e", 1);
  level.var_d2f7a339 = getgametypesetting(#"hash_361f7fe066281093");
  level.var_1c15a724 = getgametypesetting(#"hash_4dd37bf6da89131");
  level.var_8bace951 = getgametypesetting(#"hash_655d904d5995891f");

  if(!isDefined(level.var_f0257219)) {
    level.var_f0257219 = 0;
  }

  if(!isDefined(level.var_97b04ad0)) {
    level.var_97b04ad0 = (-4, -4, -4);
  }

  if(!isDefined(level.var_1dc6484c)) {
    level.var_1dc6484c = (4, 4, 4);
  }

  if(!isDefined(level.var_64a19c03)) {
    level.var_64a19c03 = 4;
  }

  if(!isDefined(level.var_4f091b08)) {
    level.var_4f091b08 = (-4, -4, -4);
  }

  if(!isDefined(level.var_7d121ad7)) {
    level.var_7d121ad7 = (4, 4, 4);
  }

  if(!isDefined(level.var_10f21cf8)) {
    level.var_10f21cf8 = [];
  }

  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::add_callback(#"squad_wiped", &function_e86729f);
  scoreevents::registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
  setDvar(#"hash_301150d9ff502ccc", 0);
  setDvar(#"hash_3b0f87edc15cba8b", 1);
  level.onspawnplayer = &on_spawn_player;

  if(function_d072f205()) {
    level thread function_bae8dea9();
  }

  if(isDefined(level.var_d1455682.squadspawnsettings)) {
    var_393bca70 = getscriptbundle(level.var_d1455682.squadspawnsettings);
  }

  setDvar(#"hash_4de24bfd1d2e60e2", getsetting("maxEnemyInfluence", 0, var_393bca70));
  setDvar(#"hash_3950aff61b5eb579", getsetting("maxFriendlyInfluence", 0, var_393bca70));
  setDvar(#"hash_448da75ac3058f88", getsetting("maxTargetPlayerInfluence", 0, var_393bca70));
  setDvar(#"hash_64315367e45f68ed", getsetting("minDistanceFromEnemyPlayer", 0, var_393bca70));
  setDvar(#"hash_4c4f79641bd0a4a8", getsetting("maxPlayerInfluencerDistance", 0, var_393bca70));
  setDvar(#"hash_11e4c0fa5ecb0ca8", getsetting("minDistanceFromTargetPlayer", 0, var_393bca70));
  setDvar(#"hash_b5fdc515c12876e", getsetting("maxDistanceFromTargetPlayer", 0, var_393bca70));
  var_8f11cf88 = getsetting("minDistanceFromEnemyPlayer", 0, var_393bca70);
  level.var_9b9900e6 = var_8f11cf88 * var_8f11cf88;
  var_a73479b4 = getsetting("maxPlayerInfluencerDistance", 0, var_393bca70);
  level.var_d6cbe602 = var_a73479b4 * var_a73479b4;
  setupclientfields();
}

function getsetting(fieldname, defaultvalue, var_393bca70) {
  if(!isDefined(var_393bca70) && !isDefined(level.var_d1455682.squadspawnsettings)) {
    return defaultvalue;
  }

  if(!isDefined(var_393bca70)) {
    var_393bca70 = getscriptbundle(level.var_d1455682.squadspawnsettings);
  }

  if(isDefined(var_393bca70) && isDefined(var_393bca70.(fieldname))) {
    return var_393bca70.(fieldname);
  }

  return defaultvalue;
}

function private setupclientfields() {
  clientfield::register_clientuimodel("hudItems.squadSpawnOnStatus", 1, 3, "int");
  clientfield::register_clientuimodel("hudItems.squadSpawnActive", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.squadSpawnRespawnStatus", 1, 2, "int");
  clientfield::register_clientuimodel("hudItems.squadSpawnViewType", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.squadAutoSpawnPromptActive", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.squadSpawnSquadWipe", 1, 1, "int");
}

function function_941bd62f() {
  if(isDefined(self.devguilockspawn) && self.devguilockspawn) {
    return {
      #origin: self.resurrect_origin, #angles: self.resurrect_angles
    };
  }

  if(!isDefined(self.spawn.response)) {} else if(self.spawn.response === "spawnOnPlayer") {
    spawn = function_154cf7ca(self);
  } else if(self.spawn.response === "spawnOnObjective") {
    spawn = function_9de15087(self);
  } else if(self.spawn.response === "autoSpawn" && !getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
    function_279d5c68(self.team, 0);
    spawn = getspawnpoint(self);
  } else if(getgametypesetting(#"hash_5d65f5abcdad24fe") && self.spawn.var_e8f87696 < gettime()) {
    if(self.spawn.response === "spawnOnObjective") {
      spawn = getspawnpoint(self);
    }
  } else if(isDefined(level.var_b8da6142) && [[level.var_b8da6142]](self)) {
    if(!function_154cf7ca(self)) {
      spawn = getspawnpoint(self);
    }
  } else {
    squadmates = function_c65231e2(self.squad);

    if(squadmates.size <= 1) {
      spawn = getspawnpoint(self);
    }
  }

  return spawn;
}

function function_841e08f9(player) {
  if(!isDefined(level.inprematchperiod) || level.inprematchperiod) {
    return false;
  }

  if(player_insertion::function_6660c1f() && !is_true(player.var_7689a9b2)) {
    return false;
  }

  if(!getgametypesetting(#"hash_1e71b5ce1cd845b3")) {
    return false;
  }

  if(is_true(player.var_20250438)) {
    return true;
  }

  if(!isDefined(player.spawn.response) || player.spawn.response == "autoSpawn") {
    return true;
  }

  if(is_true(player.var_59baee6)) {
    player.var_59baee6 = undefined;
    return true;
  }

  return false;
}

function on_spawn_player(predictedspawn = 0) {
  spawn = self function_941bd62f();

  if(!isDefined(spawn) || !isDefined(spawn.origin)) {
    spawn = spawning::function_89116a1e(predictedspawn);
  }

  self.spawn.var_e8f87696 = undefined;

  if(predictedspawn) {
    self spawning::function_e1a7c3d9(spawn.origin, spawn.angles);
  } else {
    self.lastspawntime = gettime();

    if(function_841e08f9(self)) {
      self thread namespace_aaddef5a::function_96d350e9(spawn);
      self.spawn.var_a9914487 = 3;
    } else {
      self spawn(spawn.origin, spawn.angles);
      influencers::create_player_spawn_influencers(spawn.origin);

      if(!function_61e7d9a8(self)) {
        if(isDefined(self.spawn.response) && self.spawn.response == "spawnOnPlayer") {
          self.spawn.var_a9914487 = 1;
        } else {
          self.spawn.var_a9914487 = 0;
        }
      }
    }

    self.respawntimerstarttime = undefined;
    self.spawn.userespawntime = undefined;
  }

  self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 0);
  self.spawn.var_4db23b = function_e5b0d177(self);
  self.var_20250438 = undefined;
  return spawn;
}

function function_e5b0d177(player) {
  squadmates = function_a1cff525(player.squad);

  foreach(squadmate in squadmates) {
    if(squadmate.var_83de62a2 == 0) {
      return true;
    }
  }

  return false;
}

function spawn_player() {
  if(!function_d072f205()) {
    return;
  }

  if(function_61e7d9a8(self)) {
    spawninvehicle(self);
  }

  if(self.sessionstate == "dead" && self spectate_view::function_500047aa(1)) {
    self ghost();
    self notsolid();
    self val::set(#"spawning_squad", "freezecontrols", 1);
    self val::set(#"spawning_squad", "disablegadgets", 1);
    self endon(#"death", #"disconnect");
    wait 1.25 - float(function_60d95f53()) / 1000;
    self show();
    self solid();
    self val::reset(#"spawning_squad", "freezecontrols");
    self val::reset(#"spawning_squad", "disablegadgets");
  }

  function_bb63189b(self);
}

function function_a0bd2fd6(enabled) {
  if(!function_d072f205()) {
    return;
  }

  if(enabled) {
    self clientfield::set_player_uimodel("hudItems.squadSpawnViewType", 1);
    return;
  }

  self clientfield::set_player_uimodel("hudItems.squadSpawnViewType", 0);
}

function function_279d5c68(team, enabled) {
  team_players = getplayers(enabled);

  foreach(team_player in team_players) {
    team_player function_e2ec8e07(0);
  }
}

function function_e2ec8e07(enabled) {
  if(function_d072f205()) {
    self clientfield::set_player_uimodel("hudItems.squadAutoSpawnPromptActive", enabled ? 1 : 0);
  }
}

function function_8c7462a6(enabled) {
  self clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
  self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", enabled ? 0 : 1);
}

function function_3aa3c147(squad, enabled) {
  foreach(squadplayer in function_c65231e2(squad)) {
    squadplayer clientfield::set_player_uimodel("hudItems.squadSpawnSquadWipe", enabled ? 1 : 0);
  }
}

function function_5f976259() {
  self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 1);
  self setclientuivisibilityflag("hud_visible", 0);
}

function function_c953ceb() {
  self clientfield::set_player_uimodel("hudItems.squadSpawnActive", 0);
  self setclientuivisibilityflag("hud_visible", 1);
}

function function_bb63189b(player) {
  player.spawn.var_8791b6ff = undefined;
  player.spawn.var_276f15f0 = undefined;
  player function_c953ceb();
}

function function_5f24fd47(player, userespawntime) {
  userespawntime.spawn.var_e8f87696 = undefined;
  userespawntime function_5f976259();

  if(userespawntime spectate_view::function_500047aa(1)) {
    userespawntime spectate_view::function_86df9236();
    return;
  }

  userespawntime spectate_view::function_888901cb();
}

function onplayerdamaged(player, attacker) {
  if(!function_d072f205()) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  if(player isinvehicle()) {
    return;
  }

  var_ecbf2401 = attacker getentitynumber();

  if(isDefined(player.var_cc060afa[var_ecbf2401]) && player.var_cc060afa[var_ecbf2401] > gettime()) {
    return;
  }

  damagearea = spawnStruct();
  damagearea.createdtime = gettime();
  damagearea.attacker = attacker;
  damagearea.origin = player.origin;
  level.var_10f21cf8[level.var_10f21cf8.size] = damagearea;
  player.var_cc060afa[var_ecbf2401] = 500 + gettime();
}

function private function_5e178d15(damagearea) {
  if(damagearea.createdtime + getsetting("damageAreaLifetimeMS", 0) < gettime()) {
    return true;
  }

  if(!isDefined(damagearea.attacker)) {
    return true;
  }

  if(isDefined(damagearea.attacker.deathtime)) {
    if(damagearea.createdtime < damagearea.attacker.deathtime) {
      return true;
    }
  }

  return false;
}

function function_33d9297() {
  for(index = level.var_10f21cf8.size - 1; index >= 0; index--) {
    if(function_5e178d15(level.var_10f21cf8[index])) {
      arrayremoveindex(level.var_10f21cf8, index, 0);
    }
  }
}

function function_ef8e6bd1(player) {
  damagearearadius = getsetting("damageAreaRadius", 0);
  radiussq = damagearearadius * damagearearadius;

  if(!isDefined(player.var_b7d9b739) || player.var_b7d9b739 < gettime()) {
    player.var_b7d9b739 = gettime() + 250;
    player.var_e72b96de = 0;

    foreach(damagearea in level.var_10f21cf8) {
      if(distancesquared(player.origin, damagearea.origin) < radiussq) {
        player.var_e72b96de = 1;
      }
    }
  }

  return player.var_e72b96de;
}

function function_6a7e8977() {
  self.spawn.var_e8f87696 = gettime() + int((isDefined(getgametypesetting(#"hash_c8636144ad47ac9")) ? getgametypesetting(#"hash_c8636144ad47ac9") : 0) * 1000);
}

function function_250e04e5() {
  self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 1);
}

function function_44c6679() {
  self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 3);
}

function private function_61f1a8b6(player) {
  var_4e655dbe = function_bfb027d2(player);

  if(player.var_83de62a2 != var_4e655dbe) {
    timesincelastupdate = gettime() - (isDefined(player.var_b30b9f4a) ? player.var_b30b9f4a : 0);

    if(var_4e655dbe != 1 || timesincelastupdate > 200) {
      player.var_83de62a2 = var_4e655dbe;
      player.var_b30b9f4a = gettime();
    }
  }
}

function private function_6d9e5aa2() {
  foreach(player in level.players) {
    if(isDefined(player.var_a271f211)) {
      if(level.numlives && !player.pers[#"lives"]) {
        player clientfield::set_player_uimodel("hudItems.squadSpawnOnStatus", 6);
        continue;
      }

      spectatedplayer = getentbynum(player.var_a271f211);

      if(isDefined(spectatedplayer) && spectatedplayer.squad === player.squad) {
        player clientfield::set_player_uimodel("hudItems.squadSpawnOnStatus", player.var_83de62a2);
        player predictspawnpoint(spectatedplayer.origin);
      }
    }
  }
}

function function_2ffd5f18() {
  if(is_true(self.var_312f13e0)) {
    return false;
  } else if(is_true(self.var_20250438)) {
    return true;
  } else if(self.spawn.response === "spawnOnPlayer") {
    return true;
  } else if(self.spawn.response === "spawnOnObjective") {
    return true;
  } else if(self.spawn.response === "autoSpawn") {
    return true;
  } else if(level.var_f0257219 && self.spawn.var_e8f87696 < gettime()) {
    return true;
  } else if(getgametypesetting(#"hash_5d65f5abcdad24fe") && self.spawn.var_e8f87696 < gettime()) {
    return true;
  } else if(isDefined(level.var_b8da6142) && [[level.var_b8da6142]](self)) {
    return true;
  }

  return false;
}

function private updateplayers() {
  profilestart();

  foreach(player in level.players) {
    function_61f1a8b6(player);
  }

  profilestop();
}

function private function_bae8dea9() {
  level endon(#"game_ended");

  while(true) {
    waitframe(1);

    if(!isDefined(level.players)) {
      continue;
    }

    updateplayers();
    function_6d9e5aa2();
    function_33d9297();
  }
}

function private function_426b6bde(origin, reason) {
  data = {
    #pos_x: origin[0], #pos_y: origin[1], #pos_z: origin[2], #reason: reason
  };
  function_92d1707f(#"hash_7f298b21a2012331", data);
}

function function_154cf7ca(player) {
  if(player.spawn.response === "spawnOnPlayer" && isDefined(player.var_d690fc0b)) {
    targetplayer = player.var_d690fc0b;
    player.var_d690fc0b = undefined;
  }

  if(!isDefined(targetplayer)) {
    targetplayer = function_c4505fb0(player);
  }

  if(!isDefined(targetplayer)) {
    return undefined;
  }

  spawn = function_e402b74e(player, targetplayer);

  if(!isDefined(spawn)) {
    return undefined;
  }

  scoreevents::processscoreevent(#"hash_1c4cca7457aefbb9", player, undefined, undefined);
  squadmates = function_a1cff525(self.squad);

  if(squadmates.size == 1) {
    scoreevents::processscoreevent(#"hash_6d563fdc029e8394", targetplayer, player, undefined);
  } else {
    scoreevents::processscoreevent(#"squad_spawn", targetplayer, player, undefined);
  }

  if((isDefined(targetplayer.var_23adeae5) ? targetplayer.var_23adeae5 : 0) < gettime()) {
    player battlechatter::play_dialog("spawnedSquad", 1);
    targetplayer.var_23adeae5 = gettime() + int(battlechatter::mpdialog_value("squadSpawnCooldown", 5) * 1000);
  }

  return spawn;
}

function function_9de15087(player) {
  if(player.spawn.response === "spawnOnObjective" && isDefined(player.var_612ad92b)) {
    targetposition = function_cc3ada06(player.var_612ad92b);
    player.var_612ad92b = undefined;
  }

  if(!isDefined(targetposition)) {
    return undefined;
  }

  spawn = function_70c0ae61(player, targetposition);
  return spawn;
}

function private spawnplayer(player) {
  timepassed = undefined;

  if(isDefined(player.respawntimerstarttime) && is_true(player.spawn.userespawntime)) {
    timepassed = float(gettime() - player.respawntimerstarttime) / 1000;
  }

  player thread[[level.spawnclient]](timepassed);
  player.respawntimerstarttime = undefined;
  player.spawn.userespawntime = undefined;
}

function private function_c4505fb0(spawningplayer) {
  if(isDefined(spawningplayer.currentspectatingclient)) {
    spectatingplayer = getentbynum(spawningplayer.currentspectatingclient);

    if(isDefined(spectatingplayer) && spectatingplayer.squad === spawningplayer.squad && function_714da39d(spectatingplayer)) {
      return spectatingplayer;
    }
  }

  return undefined;
}

function filter_spawn_points(targetplayer, &points) {
  if(points.size <= 0) {
    return points;
  }

  validpoints = [];

  for(index = 0; index < points.size; index++) {
    if(!oob::function_1a0f9f54(points[index])) {
      validpoints[validpoints.size] = points[index];
    }
  }

  if(isDefined(level.var_38743886)) {
    validpoints = [[level.var_38743886]](targetplayer, validpoints);
    assert(isarray(validpoints));
  }

  return validpoints;
}

function private function_e1997588(targetplayer, &points) {
  nearbyplayers = targetplayer getenemiesinradius(targetplayer.origin, 7500);

  if(nearbyplayers.size <= 0) {
    return points;
  }

  if(points.size <= 0) {
    return points;
  }

  validpoints = [];

  for(pointindex = 0; pointindex < points.size; pointindex++) {
    point = points[pointindex];
    canbeseen = 0;

    for(playerindex = 0; playerindex < nearbyplayers.size; playerindex++) {
      if(sighttracepassed(nearbyplayers[playerindex].origin + (0, 0, 72), point + (0, 0, 72), 0, undefined)) {
        canbeseen = 1;
        break;
      }
    }

    if(!canbeseen) {
      validpoints[validpoints.size] = point;
    }
  }

  if(validpoints.size <= 0) {
    validpoints[validpoints.size] = points[0];
  }

  return validpoints;
}

function private function_32843fc9(startpoint, endpoint) {
  for(index = 0; index < 7; index++) {
    groundtrace = groundtrace(startpoint, endpoint, 0, undefined, 0);

    if(groundtrace[#"fraction"] <= 0 || groundtrace[#"startsolid"]) {
      if(startpoint[2] > endpoint[2]) {
        startpoint += (0, 0, 64);
      } else {
        endpoint += (0, 0, 64);
      }

      continue;
    }

    break;
  }

  return groundtrace;
}

function function_e402b74e(spawningplayer, targetplayer) {
  if(!isDefined(targetplayer) || !isPlayer(targetplayer)) {
    function_426b6bde((0, 0, 0), #"invalid_target");
    return undefined;
  }

  var_6cff872f = 0;

  if(targetplayer isinvehicle() && !targetplayer isremotecontrolling()) {
    vehicle = targetplayer getvehicleoccupied();
    vehicleseat = function_f099b0f1(vehicle);

    if(isDefined(vehicleseat)) {
      spawningplayer.spawn.var_cb738111 = 1;
      spawningplayer.spawn.vehicleseat = vehicleseat;
      var_6cff872f = 1;
    } else {
      function_426b6bde(targetplayer.origin, #"hash_769d88fed1062d92");
    }
  }

  if(!var_6cff872f) {
    var_6b26b855 = util::get_start_time();
    var_1fd07d84 = function_6cb4953e(targetplayer, 50);
    var_1fd07d84 = filter_spawn_points(targetplayer, var_1fd07d84);
    var_8b889046 = var_1fd07d84[0];
    util::note_elapsed_time(var_6b26b855, "squad spawn point");

    if(!isDefined(var_8b889046)) {
      function_426b6bde(targetplayer.origin, #"not_found");
      var_8b889046 = function_d66eb9cd(targetplayer.origin, targetplayer.angles);

      if(!isDefined(var_8b889046)) {
        return undefined;
      }
    }

    groundtrace = function_32843fc9(var_8b889046 + (0, 0, 64), var_8b889046 - (0, 0, 64));

    if(groundtrace[#"fraction"] < 1) {
      var_8b889046 = groundtrace[#"position"];
    }

    spawningplayer.spawn.var_cb738111 = 0;
    spawningplayer.spawn.var_276f15f0 = var_8b889046;
  }

  spawningplayer.spawn.var_8791b6ff = targetplayer;
  spawn_point = getspawnpoint(self);

  if(!isDefined(spawn_point)) {
    return undefined;
  }

  trace = physicstrace(spawn_point.origin + (0, 0, 30), spawn_point.origin - (0, 0, 1000), (0, 0, 0), (0, 0, 0), self, 32);

  if(trace[#"fraction"] == 1) {
    function_426b6bde(spawn_point.origin, #"underground");
  }

  return spawn_point;
}

function function_70c0ae61(spawningplayer, objectiveposition) {
  if(!isDefined(objectiveposition)) {
    function_426b6bde((0, 0, 0), #"invalid_target");
    return undefined;
  }

  shortestdist = undefined;
  nearestplayer = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || player == spawningplayer) {
      continue;
    }

    dist = distance2dsquared(player.origin, objectiveposition);

    if(!isDefined(shortestdist) || shortestdist > dist) {
      shortestdist = dist;
      nearestplayer = player;
    }
  }

  var_d8544733 = nearestplayer.origin - objectiveposition;
  var_d8544733 = (var_d8544733[0], var_d8544733[1], 0);

  if(nearestplayer.team === spawningplayer.team) {
    var_d8544733 *= -1;
  }

  angles = vectortoangles(var_d8544733);
  var_6b26b855 = util::get_start_time();
  var_1fd07d84 = function_13bd8561(objectiveposition, angles, spawningplayer.team, 50);
  var_1fd07d84 = filter_spawn_points(undefined, var_1fd07d84);
  var_8b889046 = var_1fd07d84[0];
  util::note_elapsed_time(var_6b26b855, "squad spawn point");

  if(!isDefined(var_8b889046)) {
    function_426b6bde(objectiveposition, #"not_found");
    var_8b889046 = objectiveposition;
    spawningplayer.var_59baee6 = 1;
  }

  groundtrace = function_32843fc9(var_8b889046 + (0, 0, 64), var_8b889046 - (0, 0, 64));

  if(groundtrace[#"fraction"] < 1) {
    var_8b889046 = groundtrace[#"position"];
  }

  spawningplayer.spawn.var_cb738111 = 0;
  spawningplayer.spawn.var_276f15f0 = var_8b889046;
  spawn_point = spawnStruct();
  spawn_point.origin = var_8b889046;
  spawn_point.angles = function_d95ba61f(var_8b889046, angles, objectiveposition);

  if(!isDefined(spawn_point)) {
    return undefined;
  }

  trace = physicstrace(spawn_point.origin + (0, 0, 30), spawn_point.origin - (0, 0, 1000), (0, 0, 0), (0, 0, 0), self, 32);

  if(trace[#"fraction"] == 1) {
    function_426b6bde(spawn_point.origin, #"underground");
  }

  return spawn_point;
}

function function_d66eb9cd(targetorigin, targetangles) {
  forward = anglesToForward(targetangles);
  backward = forward * -1;
  right = anglestoright(targetangles);
  left = right * -1;
  var_e1cf0006 = [96, 144];
  angles = [backward, right, left, forward];
  var_27b2878f = undefined;

  for(distanceindex = 0; distanceindex < var_e1cf0006.size; distanceindex++) {
    offsetdistance = var_e1cf0006[distanceindex];

    for(angleindex = 0; angleindex < angles.size; angleindex++) {
      angle = angles[angleindex];
      position = targetorigin + angle * offsetdistance;
      pointinfo = function_9cc082d2(position, 4000);

      if(!isDefined(pointinfo)) {
        continue;
      }

      navmeshposition = pointinfo[#"point"];
      trace = function_32843fc9(navmeshposition + (0, 0, 500), navmeshposition - (0, 0, 500));

      if(trace[#"fraction"] == 1) {
        continue;
      }

      if(!isDefined(var_27b2878f)) {
        var_27b2878f = trace[#"position"];
      }

      if(sighttracepassed(var_27b2878f + (0, 0, 72), targetorigin + (0, 0, 72), 0, undefined)) {
        return var_27b2878f;
      }
    }
  }

  return var_27b2878f;
}

function function_403f2d91(spawningplayer) {
  if(!isDefined(spawningplayer.spawn.var_8791b6ff)) {
    return false;
  }

  return true;
}

function function_d072f205() {
  return currentsessionmode() != 4 && level.var_d0252074 && !util::is_frontend_map();
}

function function_d95ba61f(origin, angles, var_92d9ac4b) {
  var_6e8e0d1a = var_92d9ac4b + (0, 0, 72) - origin;
  var_5bc46b67 = lengthsquared(var_6e8e0d1a);
  var_b8a577cc = vectornormalize(var_6e8e0d1a);
  forward = var_b8a577cc;
  var_8792667 = (0, 0, 1);

  if(var_5bc46b67 <= sqr(700)) {
    if(sighttracepassed(origin + (0, 0, 72), var_92d9ac4b + (0, 0, 72), 0, undefined)) {
      trace = function_32843fc9(origin + (0, 0, 72), origin - (0, 0, 72));

      if(trace[#"fraction"] != 1) {
        var_8792667 = trace[#"normal"];
      }

      return axistoangles(var_6e8e0d1a, var_8792667);
    }
  }

  if(getDvar(#"hash_734f370c46f37dab", 1)) {
    var_8788f2da = axistoangles(forward, var_8792667);
  } else {
    var_8788f2da = angles;
  }

  tracestart = origin + (0, 0, 72);
  forwardpoint = tracestart + forward * 200;
  var_a5a53f73 = physicstrace(tracestart, forwardpoint);

  if(var_a5a53f73[#"fraction"] == 1) {
    return var_8788f2da;
  } else {
    bestangles = var_8788f2da;
    var_3360e6f8 = var_a5a53f73[#"fraction"];
  }

  rightdir = rotatepointaroundaxis(forward, (0, 0, 1), 90);
  rightpoint = tracestart + rightdir * 200;
  var_3bb4bb28 = physicstrace(tracestart, rightpoint);

  if(var_3bb4bb28[#"fraction"] == 1) {
    return axistoangles(rightdir, anglestoup(var_8788f2da));
  } else if(var_3bb4bb28[#"fraction"] > var_3360e6f8) {
    bestangles = axistoangles(rightdir, anglestoup(var_8788f2da));
    var_3360e6f8 = var_3bb4bb28[#"fraction"];
  }

  leftdir = rightdir * -1;
  leftpoint = tracestart + leftdir * 200;
  var_eea13cc2 = physicstrace(tracestart, leftpoint);

  if(var_eea13cc2[#"fraction"] == 1) {
    return axistoangles(leftdir, anglestoup(var_8788f2da));
  } else if(var_eea13cc2[#"fraction"] > var_3360e6f8) {
    bestangles = axistoangles(leftdir, anglestoup(var_8788f2da));
    var_3360e6f8 = var_eea13cc2[#"fraction"];
  }

  var_cf041923 = forward * -1;
  var_13ef855 = tracestart + var_cf041923 * 200;
  var_ef688df7 = physicstrace(tracestart, var_13ef855);

  if(var_ef688df7[#"fraction"] == 1) {
    return axistoangles(var_cf041923, anglestoup(var_8788f2da));
  } else if(var_ef688df7[#"fraction"] > var_3360e6f8) {
    bestangles = axistoangles(var_cf041923, anglestoup(var_8788f2da));
    var_3360e6f8 = var_ef688df7[#"fraction"];
  }

  return bestangles;
}

function getspawnpoint(spawningplayer) {
  if(!isDefined(spawningplayer.spawn.var_276f15f0) || !isDefined(spawningplayer.spawn.var_8791b6ff)) {
    return undefined;
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawningplayer.spawn.var_276f15f0;
  spawnpoint.angles = function_d95ba61f(spawnpoint.origin, spawningplayer.spawn.var_8791b6ff.angles, spawningplayer.spawn.var_8791b6ff.origin);
  return spawnpoint;
}

function function_fd0f3019(player) {
  if(!isPlayer(player)) {
    return 0;
  }

  var_72ea2bd8 = function_c65231e2(player.squad);

  switch (var_72ea2bd8.size) {
    case 1:
      return (isDefined(getgametypesetting(#"hash_3e76ce42036815cc")) ? getgametypesetting(#"hash_3e76ce42036815cc") : 0);
    case 2:
      return (isDefined(getgametypesetting(#"hash_115a3410d9dbf98d")) ? getgametypesetting(#"hash_115a3410d9dbf98d") : 0);
    case 3:
      return (isDefined(getgametypesetting(#"hash_129fca5e3a00477f")) ? getgametypesetting(#"hash_129fca5e3a00477f") : 0);
    case 4:
      return (isDefined(getgametypesetting(#"hash_527f80b77f20b8c8")) ? getgametypesetting(#"hash_527f80b77f20b8c8") : 0);
  }

  return 0;
}

function function_714da39d(player) {
  return function_bfb027d2(player) == 0;
}

function function_bfb027d2(player) {
  if(!isalive(player)) {
    return 3;
  }

  if(player inlaststand()) {
    return 4;
  }

  if(player isinfreefall()) {
    return 7;
  }

  if(player isparachuting()) {
    return 7;
  }

  if(player ishidden()) {
    return 6;
  }

  if((isDefined(player.var_e03e3ae5) ? player.var_e03e3ae5 : 0) + int((isDefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime() && isDefined(player.var_4a755632)) {
    foreach(var_49604bcb in player.var_4a755632) {
      if(!isDefined(var_49604bcb.lastdamagedtime)) {
        continue;
      }

      if(!isDefined(var_49604bcb.entity)) {
        continue;
      }

      if(var_49604bcb.lastdamagedtime + int((isDefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime() && var_49604bcb.lastdamagedtime > (isDefined(var_49604bcb.entity.deathtime) ? var_49604bcb.entity.deathtime : 0)) {
        return 2;
      }
    }
  }

  if(is_true(player.lastdamagewasfromenemy) && (isDefined(player.var_e2e8198f) ? player.var_e2e8198f : 0) + int((isDefined(getgametypesetting(#"hash_2596f9e3d6e26ac9")) ? getgametypesetting(#"hash_2596f9e3d6e26ac9") : 0) * 1000) > gettime()) {
    return 2;
  }

  if(player laststand::player_is_in_laststand()) {
    return 4;
  }

  if(player isinvehicle() && !player isremotecontrolling()) {
    vehicle = player getvehicleoccupied();

    if(isDefined(vehicle)) {
      vehicleseat = function_f099b0f1(vehicle);

      if(!isDefined(vehicleseat)) {
        return 5;
      }
    }
  }

  if(player function_b4813488() || player isziplining()) {
    return 6;
  }

  if((isDefined(player.var_12db485c) ? player.var_12db485c : 0) < gettime()) {
    player.var_708884c0 = gettime() + randomintrange(100, 400);
    enemies = player getenemiesinradius(player.origin, isDefined(getgametypesetting(#"hash_718b497c5205e74b")) ? getgametypesetting(#"hash_718b497c5205e74b") : 0);

    if(enemies.size > 0) {
      return 1;
    }
  }

  if(function_ef8e6bd1(player)) {
    return 2;
  }

  return 0;
}

function function_f099b0f1(vehicle) {
  if(!isvehicle(vehicle)) {
    return undefined;
  }

  if(!vehicle isvehicleusable()) {
    return undefined;
  }

  for(seatindex = 0; seatindex < 11; seatindex++) {
    if(!vehicle function_dcef0ba1(seatindex)) {
      continue;
    }

    if(!vehicle function_154190ec(seatindex)) {
      continue;
    }

    var_3693c73b = vehicle function_defc91b2(seatindex);

    if(!isDefined(var_3693c73b) || var_3693c73b < 0) {
      continue;
    }

    if(vehicle isvehicleseatoccupied(seatindex)) {
      continue;
    }

    return seatindex;
  }

  return undefined;
}

function function_61e7d9a8(player) {
  return isDefined(player.spawn.var_cb738111) && player.spawn.var_cb738111 == 1;
}

function spawninvehicle(player) {
  targetplayer = player.spawn.var_8791b6ff;

  if(!isDefined(targetplayer)) {
    return;
  }

  if(!targetplayer isinvehicle()) {
    return;
  }

  vehicle = targetplayer getvehicleoccupied();

  if(!isDefined(vehicle)) {
    return;
  }

  if(vehicle isvehicleseatoccupied(player.spawn.vehicleseat)) {
    return;
  }

  vehicle::function_bc2025e(player);
  vehicle usevehicle(player, player.spawn.vehicleseat);
  player.spawn.var_a9914487 = 2;
}

function on_player_spawned() {
  if(!function_d072f205()) {
    return;
  }

  function_279d5c68(self.team, 0);

  if(is_true(level.droppedtagrespawn)) {
    self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 2);
  }

  self.var_a271f211 = undefined;
  self.var_cc060afa = [];
}

function function_e86729f(params) {
  if(is_true(level.var_5c49de55) && game.var_794ec97[self.team]) {
    return;
  }

  level endon(#"game_ended");
  squad = params.squad;

  foreach(squadplayer in function_c65231e2(squad)) {
    squadplayer function_8c7462a6(1);
    squadplayer.var_312f13e0 = 1;
    squadplayer notify(#"hash_33713849648e651d");
  }

  var_67899abe = function_fd0f3019(function_c65231e2(squad)[0]);
  wait var_67899abe;

  foreach(squadplayer in function_c65231e2(squad)) {
    squadplayer function_8c7462a6(0);
    squadplayer.var_312f13e0 = 0;
    squadplayer.var_20250438 = 1;
    squadplayer notify(#"hash_33713849648e651d");
  }
}

function function_9e0c4479() {
  var_72ea2bd8 = function_c65231e2(self.squad);
  aliveplayers = function_a1cff525(self.squad);

  if(aliveplayers.size == 0 && var_72ea2bd8.size > 1) {
    return true;
  }

  return false;
}

function on_player_connect() {
  if(level.var_d2f7a339 && self.team != # "spectator") {
    self spectate_view::function_86df9236();
    return;
  }

  self spectate_view::function_888901cb();
}

function scoreeventplayerkill(data) {
  victim = data.victim;

  if(!isDefined(victim)) {
    return;
  }

  attacker = data.attacker;

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }

  time = data.time;
  attacker.lastkilltime = time;

  if(isDefined(victim.lastkilltime) && victim.lastkilltime > time - int(10 * 1000)) {
    if(isDefined(victim.lastkilledplayer) && victim.lastkilledplayer.squad == attacker.squad && attacker != victim.lastkilledplayer) {
      scoreevents::processscoreevent("squad_avenged_member", attacker, victim);
    }
  }

  if(isDefined(victim.damagedplayers) && isDefined(attacker.clientid)) {
    foreach(var_abe8cf31, var_87de3b91 in victim.damagedplayers) {
      if(var_abe8cf31 === attacker.clientid) {
        continue;
      }

      if(!isDefined(var_87de3b91.entity)) {
        continue;
      }

      if(attacker.squad != var_87de3b91.entity.squad) {
        continue;
      }

      if(time - var_87de3b91.time < int(5 * 1000)) {
        scoreevents::processscoreevent("squad_member_saved", attacker, victim);
      }
    }
  }
}