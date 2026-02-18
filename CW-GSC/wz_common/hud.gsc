/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\hud.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\wz_common\util;
#namespace hud;

function function_9b9cecdf() {
  clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", 1, 7, "int");
  clientfield::register_clientuimodel("hudItems.alivePlayerCount", 1, 7, "int", 1);
  clientfield::register_clientuimodel("hudItems.aliveTeammateCount", 1, 7, "int", 0);
  clientfield::register_clientuimodel("hudItems.spectatorsCount", 1, 7, "int", 1);
  clientfield::register_clientuimodel("hudItems.playerKills", 1, 7, "int", 0);
  clientfield::register_clientuimodel("hudItems.playerCleanUps", 1, 7, "int", 0);
  clientfield::register_clientuimodel("presence.modeparam", 1, 7, "int", 1);
  clientfield::register_clientuimodel("hudItems.armorType", 1, 2, "int", 0);
  clientfield::register_clientuimodel("hudItems.streamerLoadFraction", 1, 5, "float", 1);
  clientfield::register_clientuimodel("hudItems.wzLoadFinished", 1, 1, "int", 1);
  clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", 1, 1, "int", 0);
  clientfield::register_clientuimodel("hudItems.playerLivesRemaining", 7000, 4, "int", 1);
  clientfield::register_clientuimodel("hudItems.playerLivesRemainingPredicted", 7000, 4, "int", 0);
  clientfield::register_clientuimodel("hudItems.playerCanRedeploy", 7000, 1, "int");
  clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int");
  clientfield::function_5b7d846d("hudItems.warzone.collapse", 7000, 21, "int");
  clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", 7000, 21, "int");
  clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", 1, 3, "int");
  clientfield::function_5b7d846d("hudItems.warzone.collapseCount", 1, 3, "int");
  clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", 1, 3, "int");
  clientfield::register_clientuimodel("hudItems.skydiveAltimeterVisible", 1, 1, "int");
  clientfield::function_5b7d846d("hudItems.skydiveAltimeterHeight", 1, 16, "int");
  clientfield::function_5b7d846d("hudItems.skydiveAltimeterSeaHeight", 1, 16, "int");
  callback::on_spawned(&on_player_spawned);
}

function private on_player_spawned() {
  wait 0.5;

  if(!isPlayer(self)) {
    return;
  }

  self function_ed40d523();
}

function function_2f66bc37() {
  assert(isPlayer(self));
  actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
  self setactionslot(3, actionslot3);
  actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
  self setactionslot(4, actionslot4);
}

function function_cb4b48d5(var_80427091 = 1) {
  assert(isPlayer(self));

  if(var_80427091) {
    self setactionslot(3, "");
  }

  self setactionslot(4, "");
}

function function_22df4165() {
  level.var_22df4165 = 1;
}

function function_5db32126() {
  while(true) {
    waitframe(1);

    if(is_true(level.var_22df4165)) {
      function_e91890a7();
    }
  }
}

function private function_ed40d523() {
  player = self;
  aliveteammates = 0;
  teammembers = getplayers(player.team);

  foreach(member in teammembers) {
    if(isalive(member)) {
      aliveteammates++;
    }
  }

  player clientfield::set_player_uimodel("hudItems.aliveTeammateCount", aliveteammates);
}

function function_e91890a7() {
  if(!is_true(level.var_22df4165)) {
    return;
  }

  util::waittillslowprocessallowed();
  player_counts = util::function_de15dc32();
  players = getplayers();

  foreach(player in players) {
    aliveplayercount = player_counts.alive;
    player clientfield::set_player_uimodel("presence.modeparam", aliveplayercount);
    player clientfield::set_player_uimodel("hudItems.alivePlayerCount", aliveplayercount);
    player function_ed40d523();
  }

  level.var_22df4165 = undefined;
}

function event_handler[enter_vehicle] codecallback_entervehicle(eventstruct) {
  if(isPlayer(self)) {
    self function_cb4b48d5(0);
  }
}

function event_handler[exit_vehicle] codecallback_exitvehicle(eventstruct) {
  if(isPlayer(self)) {
    self function_2f66bc37();
  }
}

function event_handler[freefall] function_5019e563(eventstruct) {}

function event_handler[parachute] function_87b05fa3(eventstruct) {}