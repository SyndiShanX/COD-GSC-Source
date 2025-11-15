/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_audio.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\music_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace globallogic_audio;

function autoexec __init__sytem__() {
  system::register("globallogic_audio", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  level.playleaderdialogonplayer = & leader_dialog_on_player;
  level.playequipmentdestroyedonplayer = & play_equipment_destroyed_on_player;
  level.playequipmenthackedonplayer = & play_equipment_hacked_on_player;
}

function init() {
  game["music"]["defeat"] = "mus_defeat";
  game["music"]["victory_spectator"] = "mus_defeat";
  game["music"]["winning"] = "mus_time_running_out_winning";
  game["music"]["losing"] = "mus_time_running_out_losing";
  game["music"]["match_end"] = "mus_match_end";
  game["music"]["victory_tie"] = "mus_defeat";
  game["music"]["spawn_short"] = "SPAWN_SHORT";
  game["music"]["suspense"] = [];
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_01";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_02";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_03";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_04";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_05";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_06";
  level thread post_match_snapshot_watcher();
  level.multipledialogkeys = [];
  level.multipledialogkeys["enemyAiTank"] = "enemyAiTankMultiple";
  level.multipledialogkeys["enemySupplyDrop"] = "enemySupplyDropMultiple";
  level.multipledialogkeys["enemyCombatRobot"] = "enemyCombatRobotMultiple";
  level.multipledialogkeys["enemyCounterUav"] = "enemyCounterUavMultiple";
  level.multipledialogkeys["enemyDart"] = "enemyDartMultiple";
  level.multipledialogkeys["enemyEmp"] = "enemyEmpMultiple";
  level.multipledialogkeys["enemySentinel"] = "enemySentinelMultiple";
  level.multipledialogkeys["enemyMicrowaveTurret"] = "enemyMicrowaveTurretMultiple";
  level.multipledialogkeys["enemyRcBomb"] = "enemyRcBombMultiple";
  level.multipledialogkeys["enemyPlaneMortar"] = "enemyPlaneMortarMultiple";
  level.multipledialogkeys["enemyHelicopterGunner"] = "enemyHelicopterGunnerMultiple";
  level.multipledialogkeys["enemyRaps"] = "enemyRapsMultiple";
  level.multipledialogkeys["enemyDroneStrike"] = "enemyDroneStrikeMultiple";
  level.multipledialogkeys["enemyTurret"] = "enemyTurretMultiple";
  level.multipledialogkeys["enemyHelicopter"] = "enemyHelicopterMultiple";
  level.multipledialogkeys["enemyUav"] = "enemyUavMultiple";
  level.multipledialogkeys["enemySatellite"] = "enemySatelliteMultiple";
  level.multipledialogkeys["friendlyAiTank"] = "";
  level.multipledialogkeys["friendlySupplyDrop"] = "";
  level.multipledialogkeys["friendlyCombatRobot"] = "";
  level.multipledialogkeys["friendlyCounterUav"] = "";
  level.multipledialogkeys["friendlyDart"] = "";
  level.multipledialogkeys["friendlyEmp"] = "";
  level.multipledialogkeys["friendlySentinel"] = "";
  level.multipledialogkeys["friendlyMicrowaveTurret"] = "";
  level.multipledialogkeys["friendlyRcBomb"] = "";
  level.multipledialogkeys["friendlyPlaneMortar"] = "";
  level.multipledialogkeys["friendlyHelicopterGunner"] = "";
  level.multipledialogkeys["friendlyRaps"] = "";
  level.multipledialogkeys["friendlyDroneStrike"] = "";
  level.multipledialogkeys["friendlyTurret"] = "";
  level.multipledialogkeys["friendlyHelicopter"] = "";
  level.multipledialogkeys["friendlyUav"] = "";
  level.multipledialogkeys["friendlySatellite"] = "";
}

function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey) {
  level.leaderdialog = spawnStruct();
  level.leaderdialog.startgamedialog = startgamedialogkey;
  level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
  level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
  level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

function announce_round_winner(winner, delay) {
  if(delay > 0) {
    wait(delay);
  }
  if(!isDefined(winner) || isplayer(winner)) {
    return;
  }
  if(isDefined(level.teams[winner])) {
    leader_dialog("roundEncourageWon", winner);
    leader_dialog_for_other_teams("roundEncourageLost", winner);
  } else {
    foreach(team in level.teams) {
      thread sound::play_on_players(("mus_round_draw" + "_") + level.teampostfix[team]);
    }
    leader_dialog("roundDraw");
  }
}

function announce_game_winner(winner) {
  if(level.gametype == "fr") {
    return;
  }
  wait(battlechatter::mpdialog_value("announceWinnerDelay", 0));
  if(level.teambased) {
    if(isDefined(level.teams[winner])) {
      leader_dialog("gameWon", winner);
      leader_dialog_for_other_teams("gameLost", winner);
    } else {
      leader_dialog("gameDraw");
    }
    wait(battlechatter::mpdialog_value("commanderDialogBuffer", 0));
  }
  battlechatter::game_end_vox(winner);
}

function flush_dialog() {
  foreach(player in level.players) {
    player flush_dialog_on_player();
  }
}

function flush_dialog_on_player() {
  self.leaderdialogqueue = [];
  self.currentleaderdialog = undefined;
  self.killstreakdialogqueue = [];
  self.scorestreakdialogplaying = 0;
  self notify("flush_dialog");
}

function flush_killstreak_dialog_on_player(killstreakid) {
  if(!isDefined(killstreakid)) {
    return;
  }
  for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
    if(killstreakid === self.killstreakdialogqueue[i].killstreakid) {
      arrayremoveindex(self.killstreakdialogqueue, i);
    }
  }
}

function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
  if(!isDefined(dialogkey) || !isDefined(killstreaktype)) {
    return;
  }
  if(isDefined(self.currentkillstreakdialog)) {
    if(dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
      return true;
    }
  }
  for(i = 0; i < self.killstreakdialogqueue.size; i++) {
    if(dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
      return true;
    }
  }
  return false;
}

function flush_objective_dialog(objectivekey) {
  foreach(player in level.players) {
    player flush_objective_dialog_on_player(objectivekey);
  }
}

function flush_objective_dialog_on_player(objectivekey) {
  if(!isDefined(objectivekey)) {
    return;
  }
  for(i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
    if(objectivekey === self.leaderdialogqueue[i].objectivekey) {
      arrayremoveindex(self.leaderdialogqueue, i);
      break;
    }
  }
}

function flush_leader_dialog_key(dialogkey) {
  foreach(player in level.players) {
    player flush_leader_dialog_key_on_player(dialogkey);
  }
}

function flush_leader_dialog_key_on_player(dialogkey) {
  if(!isDefined(dialogkey)) {
    return;
  }
  for(i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
    if(dialogkey === self.leaderdialogqueue[i].dialogkey) {
      arrayremoveindex(self.leaderdialogqueue, i);
    }
  }
}

function play_taacom_dialog(dialogkey, killstreaktype, killstreakid) {
  self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid);
}

function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex) {
  if(!isDefined(dialogkey)) {
    return;
  }
  if(!level.allowannouncer) {
    return;
  }
  if(level.gameended) {
    return;
  }
  newdialog = spawnStruct();
  newdialog.dialogkey = dialogkey;
  newdialog.killstreaktype = killstreaktype;
  newdialog.pilotindex = pilotindex;
  newdialog.killstreakid = killstreakid;
  self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
  if(self.killstreakdialogqueue.size > 1 || isDefined(self.currentkillstreakdialog)) {
    return;
  }
  if(self.playingdialog === 1 && dialogkey == "arrive") {
    self thread wait_for_player_dialog();
  } else {
    self thread play_next_killstreak_dialog();
  }
}

function wait_for_player_dialog() {
  self endon("disconnect");
  self endon("flush_dialog");
  level endon("game_ended");
  while(self.playingdialog) {
    wait(0.5);
  }
  self thread play_next_killstreak_dialog();
}

function play_next_killstreak_dialog() {
  self endon("disconnect");
  self endon("flush_dialog");
  level endon("game_ended");
  if(self.killstreakdialogqueue.size == 0) {
    self.currentkillstreakdialog = undefined;
    return;
  }
  nextdialog = self.killstreakdialogqueue[0];
  arrayremoveindex(self.killstreakdialogqueue, 0);
  if(isDefined(self.pers["mptaacom"])) {
    taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers["mptaacom"]);
  }
  if(isDefined(taacombundle)) {
    if(isDefined(nextdialog.killstreaktype)) {
      if(isDefined(nextdialog.pilotindex)) {
        pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];
        if(isDefined(pilotarray) && nextdialog.pilotindex < pilotarray.size) {
          killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", pilotarray[nextdialog.pilotindex]);
          if(isDefined(killstreakbundle)) {
            dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
          }
        }
      } else if(isDefined(level.killstreaks[nextdialog.killstreaktype])) {
        bundlename = getstructfield(taacombundle, level.killstreaks[nextdialog.killstreaktype].taacomdialogbundlekey);
        if(isDefined(bundlename)) {
          killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", bundlename);
          if(isDefined(killstreakbundle)) {
            dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
          }
        }
      }
    } else {
      dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey);
    }
  }
  if(!isDefined(dialogalias)) {
    self play_next_killstreak_dialog();
    return;
  }
  self playlocalsound(dialogalias);
  self.currentkillstreakdialog = nextdialog;
  self thread wait_next_killstreak_dialog();
}

function wait_next_killstreak_dialog() {
  self endon("disconnect");
  self endon("flush_dialog");
  level endon("game_ended");
  wait(battlechatter::mpdialog_value("killstreakDialogBuffer", 0));
  self thread play_next_killstreak_dialog();
}

function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
  assert(isDefined(skipteam));
  foreach(team in level.teams) {
    if(team != skipteam) {
      leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
    }
  }
}

function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
  assert(isDefined(level.players));
  foreach(player in level.players) {
    if(!isDefined(player.pers["team"])) {
      continue;
    }
    if(isDefined(team) && team != player.pers["team"]) {
      continue;
    }
    if(isDefined(excludelist) && globallogic_utils::isexcluded(player, excludelist)) {
      continue;
    }
    player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey);
  }
}

function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog) {
  if(!isDefined(dialogkey)) {
    return;
  }
  if(!level.allowannouncer) {
    return;
  }
  if(!(isDefined(self.playleaderdialog) && self.playleaderdialog) && (!(isDefined(introdialog) && introdialog))) {
    return;
  }
  self flush_objective_dialog_on_player(objectivekey);
  if(self.leaderdialogqueue.size == 0 && isDefined(self.currentleaderdialog) && isDefined(objectivekey) && self.currentleaderdialog.objectivekey === objectivekey && self.currentleaderdialog.dialogkey == dialogkey) {
    return;
  }
  if(isDefined(killstreakid)) {
    foreach(item in self.leaderdialogqueue) {
      if(item.dialogkey == dialogkey) {
        item.killstreakids[item.killstreakids.size] = killstreakid;
        return;
      }
    }
    if(self.leaderdialogqueue.size == 0 && isDefined(self.currentleaderdialog) && self.currentleaderdialog.dialogkey == dialogkey) {
      if(self.currentleaderdialog.playmultiple === 1) {
        return;
      }
      playmultiple = 1;
    }
  }
  newitem = spawnStruct();
  newitem.priority = dialogkey_priority(dialogkey);
  newitem.dialogkey = dialogkey;
  newitem.multipledialogkey = level.multipledialogkeys[dialogkey];
  newitem.playmultiple = playmultiple;
  newitem.objectivekey = objectivekey;
  if(isDefined(killstreakid)) {
    newitem.killstreakids = [];
    newitem.killstreakids[0] = killstreakid;
  }
  newitem.dialogbufferkey = dialogbufferkey;
  iteminserted = 0;
  if(isDefined(newitem.priority)) {
    for(i = 0; i < self.leaderdialogqueue.size; i++) {
      if(isDefined(self.leaderdialogqueue[i].priority) && self.leaderdialogqueue[i].priority <= newitem.priority) {
        continue;
      }
      arrayinsert(self.leaderdialogqueue, newitem, i);
      iteminserted = 1;
      break;
    }
  }
  if(!iteminserted) {
    self.leaderdialogqueue[self.leaderdialogqueue.size] = newitem;
  }
  if(isDefined(self.currentleaderdialog)) {
    return;
  }
  self thread play_next_leader_dialog();
}

function play_next_leader_dialog() {
  self endon("disconnect");
  self endon("flush_dialog");
  level endon("game_ended");
  if(self.leaderdialogqueue.size == 0) {
    self.currentleaderdialog = undefined;
    return;
  }
  nextdialog = self.leaderdialogqueue[0];
  arrayremoveindex(self.leaderdialogqueue, 0);
  dialogkey = nextdialog.dialogkey;
  if(isDefined(nextdialog.killstreakids)) {
    triggeredcount = 0;
    foreach(killstreakid in nextdialog.killstreakids) {
      if(isDefined(level.killstreaks_triggered[killstreakid])) {
        triggeredcount++;
      }
    }
    if(triggeredcount == 0) {
      self thread play_next_leader_dialog();
      return;
    }
    if(triggeredcount > 1 || nextdialog.playmultiple === 1) {
      if(isDefined(level.multipledialogkeys[dialogkey])) {
        dialogkey = level.multipledialogkeys[dialogkey];
      }
    }
  }
  dialogalias = self get_commander_dialog_alias(dialogkey);
  if(!isDefined(dialogalias)) {
    self thread play_next_leader_dialog();
    return;
  }
  self playlocalsound(dialogalias);
  nextdialog.playtime = gettime();
  self.currentleaderdialog = nextdialog;
  dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
  self thread wait_next_leader_dialog(dialogbuffer);
}

function wait_next_leader_dialog(dialogbuffer) {
  self endon("disconnect");
  self endon("flush_dialog");
  level endon("game_ended");
  wait(dialogbuffer);
  self thread play_next_leader_dialog();
}

function dialogkey_priority(dialogkey) {
  switch (dialogkey) {
    case "enemyAiTank":
    case "enemyAiTankMultiple":
    case "enemyCombatRobot":
    case "enemyCombatRobotMultiple":
    case "enemyDart":
    case "enemyDartMultiple":
    case "enemyDroneStrike":
    case "enemyDroneStrikeMultiple":
    case "enemyHelicopter":
    case "enemyHelicopterGunner":
    case "enemyHelicopterGunnerMultiple":
    case "enemyHelicopterMultiple":
    case "enemyMicrowaveTurret":
    case "enemyMicrowaveTurretMultiple":
    case "enemyPlaneMortar":
    case "enemyPlaneMortarMultiple":
    case "enemyPlaneMortarUsed":
    case "enemyRaps":
    case "enemyRapsMultiple":
    case "enemyRcBomb":
    case "enemyRcBombMultiple":
    case "enemyRemoteMissile":
    case "enemyRemoteMissileMultiple":
    case "enemySentinel":
    case "enemySentinelMultiple":
    case "enemyTurret":
    case "enemyTurretMultiple": {
      return 1;
    }
    case "gameLeadLost":
    case "gameLeadTaken":
    case "gameLosing":
    case "gameWinning":
    case "nearDrawing":
    case "nearLosing":
    case "nearWinning":
    case "roundEncourageLastPlayer": {
      return 1;
    }
    case "bombDefused":
    case "bombEnemyTaken":
    case "bombFriendlyDropped":
    case "bombFriendlyTaken":
    case "bombPlanted":
    case "ctfEnemyFlagCaptured":
    case "ctfEnemyFlagDropped":
    case "ctfEnemyFlagReturned":
    case "ctfEnemyFlagTaken":
    case "ctfFriendlyFlagCaptured":
    case "ctfFriendlyFlagDropped":
    case "ctfFriendlyFlagReturned":
    case "ctfFriendlyFlagTaken":
    case "domEnemyHasA":
    case "domEnemyHasB":
    case "domEnemyHasC":
    case "domEnemySecuredA":
    case "domEnemySecuredB":
    case "domEnemySecuredC":
    case "domEnemySecuringA":
    case "domEnemySecuringB":
    case "domEnemySecuringC":
    case "domFriendlySecuredA":
    case "domFriendlySecuredAll":
    case "domFriendlySecuredB":
    case "domFriendlySecuredC":
    case "domFriendlySecuringA":
    case "domFriendlySecuringB":
    case "domFriendlySecuringC":
    case "hubMoved":
    case "hubOffline":
    case "hubOnline":
    case "hubsMoved":
    case "hubsOffline":
    case "hubsOnline":
    case "kothCaptured":
    case "kothContested":
    case "kothLocated":
    case "kothLost":
    case "kothOnline":
    case "kothSecured":
    case "sfgRobotCloseAttacker":
    case "sfgRobotCloseDefender":
    case "sfgRobotDisabledAttacker":
    case "sfgRobotDisabledDefender":
    case "sfgRobotNeedReboot":
    case "sfgRobotRebootedAttacker":
    case "sfgRobotRebootedDefender":
    case "sfgRobotRebootedTowAttacker":
    case "sfgRobotRebootedTowDefender":
    case "sfgRobotUnderFire":
    case "sfgRobotUnderFireNeutral":
    case "sfgStartAttack":
    case "sfgStartDefend":
    case "sfgStartHrAttack":
    case "sfgStartHrDefend":
    case "sfgStartTow":
    case "sfgTheyReturn":
    case "sfgWeReturn":
    case "uplOrders":
    case "uplReset":
    case "uplTheyDrop":
    case "uplTheyTake":
    case "uplTheyUplink":
    case "uplTheyUplinkRemote":
    case "uplTransferred":
    case "uplWeDrop":
    case "uplWeTake":
    case "uplWeUplink":
    case "uplWeUplinkRemote": {
      return 1;
    }
  }
  return undefined;
}

function play_equipment_destroyed_on_player() {
  self play_taacom_dialog("equipmentDestroyed");
}

function play_equipment_hacked_on_player() {
  self play_taacom_dialog("equipmentHacked");
}

function get_commander_dialog_alias(dialogkey) {
  if(!isDefined(self.pers["mpcommander"])) {
    return undefined;
  }
  commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers["mpcommander"]);
  return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

function get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }
  dialogalias = getstructfield(dialogbundle, dialogkey);
  if(!isDefined(dialogalias)) {
    return;
  }
  voiceprefix = getstructfield(dialogbundle, "voiceprefix");
  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }
  return dialogalias;
}

function is_team_winning(checkteam) {
  score = game["teamScores"][checkteam];
  foreach(team in level.teams) {
    if(team != checkteam) {
      if(game["teamScores"][team] >= score) {
        return false;
      }
    }
  }
  return true;
}

function announce_team_is_winning() {
  foreach(team in level.teams) {
    if(is_team_winning(team)) {
      leader_dialog("gameWinning", team);
      leader_dialog_for_other_teams("gameLosing", team);
      return true;
    }
  }
  return false;
}

function play_2d_on_team(alias, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player playlocalsound(alias);
    }
  }
}

function get_round_switch_dialog(switchtype) {
  switch (switchtype) {
    case "halftime": {
      return "roundHalftime";
    }
    case "overtime": {
      return "roundOvertime";
    }
    default: {
      return "roundSwitchSides";
    }
  }
}

function post_match_snapshot_watcher() {
  level waittill("game_ended");
  level util::clientnotify("pm");
  level waittill("sfade");
  level util::clientnotify("pmf");
}

function announcercontroller() {
  level endon("game_ended");
  level waittill("match_ending_soon");
  if(util::islastround() || util::isoneround()) {
    if(level.teambased) {
      if(!announce_team_is_winning()) {
        leader_dialog("min_draw");
      }
    }
    level waittill("match_ending_very_soon");
    foreach(team in level.teams) {
      leader_dialog("roundTimeWarning", team, undefined, undefined);
    }
  } else {
    level waittill("match_ending_vox");
    leader_dialog("roundTimeWarning");
  }
}

function sndmusicfunctions() {
  level thread sndmusictimesout();
  level thread sndmusichalfway();
  level thread sndmusictimelimitwatcher();
  level thread sndmusicunlock();
}

function sndmusicsetrandomizer() {
  if(game["roundsplayed"] == 0) {
    game["musicSet"] = randomintrange(1, 8);
    if(game["musicSet"] <= 9) {
      game["musicSet"] = "0" + game["musicSet"];
    }
    game["musicSet"] = "_" + game["musicSet"];
    if(isDefined(level.freerun) && level.freerun) {
      game["musicSet"] = "";
    }
  }
}

function sndmusicunlock() {
  level waittill("game_ended");
  unlockname = undefined;
  switch (game["musicSet"]) {
    case "_01": {
      unlockname = "mus_dystopia_intro";
      break;
    }
    case "_02": {
      unlockname = "mus_filter_intro";
      break;
    }
    case "_03": {
      unlockname = "mus_immersion_intro";
      break;
    }
    case "_04": {
      unlockname = "mus_ruin_intro";
      break;
    }
    case "_05": {
      unlockname = "mus_cod_bites_intro";
      break;
    }
  }
  if(isDefined(unlockname)) {
    level thread audio::unlockfrontendmusic(unlockname);
  }
}

function sndmusictimesout() {
  level endon("game_ended");
  level endon("musicendingoverride");
  level waittill("match_ending_very_soon");
  if(isDefined(level.gametype) && (level.gametype == "sd" || level.gametype == "prop")) {
    level thread set_music_on_team("timeOutQuiet");
  } else {
    level thread set_music_on_team("timeOut");
  }
}

function sndmusichalfway() {
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("match_ending_very_soon");
  level waittill("sndmusichalfway");
  level thread set_music_on_team("underscore");
}

function sndmusictimelimitwatcher() {
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("match_ending_very_soon");
  level endon("sndmusichalfway");
  if(!isDefined(level.timelimit) || level.timelimit == 0) {
    return;
  }
  halfway = (level.timelimit * 60) * 0.5;
  while(true) {
    timeleft = globallogic_utils::gettimeremaining() / 1000;
    if(timeleft <= halfway) {
      level notify("sndmusichalfway");
      return;
    }
    wait(2);
  }
}

function set_music_on_team(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
  assert(isDefined(level.players));
  foreach(player in level.players) {
    if(team == "both") {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
      continue;
    }
    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
    }
  }
}

function set_music_on_player(state, wait_time = 0, save_state = 0, return_state = 0) {
  self endon("disconnect");
  assert(isplayer(self));
  if(!isDefined(state)) {
    return;
  }
  if(!isDefined(game["musicSet"])) {
    return;
  }
  music::setmusicstate(state + game["musicSet"], self);
}

function set_music_global(state, wait_time = 0, save_state = 0, return_state = 0) {
  if(!isDefined(state)) {
    return;
  }
  if(!isDefined(game["musicSet"])) {
    return;
  }
  music::setmusicstate(state + game["musicSet"]);
}