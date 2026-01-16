/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_audio.gsc
*****************************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\music_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\round;

#namespace globallogic_audio;

autoexec __init__system__() {
  system::register(#"globallogic_audio", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  level.playleaderdialogonplayer = &leader_dialog_on_player;
  level.var_57e2bc08 = &leader_dialog;
  level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
  level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
  setdvar(#"hash_2fd9eb199c2ef1cf", 0.4);
}

init() {
  game.music[#"defeat"] = "mus_defeat";
  game.music[#"victory_spectator"] = "mus_defeat";
  game.music[#"winning"] = "mus_time_running_out_winning";
  game.music[#"losing"] = "mus_time_running_out_losing";
  game.music[#"match_end"] = "mus_match_end";
  game.music[#"victory_tie"] = "mus_defeat";
  game.music[#"spawn_short"] = "SPAWN_SHORT";
  game.music[#"suspense"] = [];
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_01";
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_02";
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_03";
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_04";
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_05";
  game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_06";
  level callback::function_d8abfc3d(#"on_end_game", &on_end_game);
  level.multipledialogkeys = [];
  level.multipledialogkeys[#"enemyaitank"] = "enemyAiTankMultiple";
  level.multipledialogkeys[#"enemysupplydrop"] = "enemySupplyDropMultiple";
  level.multipledialogkeys[#"enemycombatrobot"] = "enemyCombatRobotMultiple";
  level.multipledialogkeys[#"enemycounteruav"] = "enemyCounterUavMultiple";
  level.multipledialogkeys[#"enemydart"] = "enemyDartMultiple";
  level.multipledialogkeys[#"enemyemp"] = "enemyEmpMultiple";
  level.multipledialogkeys[#"enemymicrowaveturret"] = "enemyMicrowaveTurretMultiple";
  level.multipledialogkeys[#"enemyrcbomb"] = "enemyRcBombMultiple";
  level.multipledialogkeys[#"enemyplanemortar"] = "enemyPlaneMortarMultiple";
  level.multipledialogkeys[#"enemyhelicoptergunner"] = "enemyHelicopterGunnerMultiple";
  level.multipledialogkeys[#"enemyraps"] = "enemyRapsMultiple";
  level.multipledialogkeys[#"enemydronestrike"] = "enemyDroneStrikeMultiple";
  level.multipledialogkeys[#"enemyturret"] = "enemyTurretMultiple";
  level.multipledialogkeys[#"enemyhelicopter"] = "enemyHelicopterMultiple";
  level.multipledialogkeys[#"enemyuav"] = "enemyUavMultiple";
  level.multipledialogkeys[#"enemysatellite"] = "enemySatelliteMultiple";
  level.multipledialogkeys[#"friendlyaitank"] = "";
  level.multipledialogkeys[#"friendlysupplydrop"] = "";
  level.multipledialogkeys[#"friendlycombatrobot"] = "";
  level.multipledialogkeys[#"friendlycounteruav"] = "";
  level.multipledialogkeys[#"friendlydart"] = "";
  level.multipledialogkeys[#"friendlyemp"] = "";
  level.multipledialogkeys[#"friendlymicrowaveturret"] = "";
  level.multipledialogkeys[#"friendlyrcbomb"] = "";
  level.multipledialogkeys[#"friendlyplanemortar"] = "";
  level.multipledialogkeys[#"friendlyhelicoptergunner"] = "";
  level.multipledialogkeys[#"friendlyraps"] = "";
  level.multipledialogkeys[#"friendlydronestrike"] = "";
  level.multipledialogkeys[#"friendlyturret"] = "";
  level.multipledialogkeys[#"friendlyhelicopter"] = "";
  level.multipledialogkeys[#"friendlyuav"] = "";
  level.multipledialogkeys[#"friendlysatellite"] = "";
}

function_6e084fd3(var_37ecca7, taacombundle) {
  bundlename = undefined;

  switch (var_37ecca7) {
    case #"tank_robot":
      bundlename = taacombundle.aitankdialogbundle;
      break;
    case #"counteruav":
      bundlename = taacombundle.counteruavdialogbundle;
      break;
    case #"dart":
      bundlename = taacombundle.dartdialogbundle;
      break;
    case #"drone_squadron":
      bundlename = taacombundle.var_69a9ca12;
      break;
    case #"ac130":
      bundlename = taacombundle.var_71693229;
      break;
    case #"helicopter_comlink":
      bundlename = taacombundle.helicopterdialogbundle;
      break;
    case #"overwatch_helicopter":
      bundlename = taacombundle.overwatchhelicopterdialogbundle;
      break;
    case #"overwatch_helicopter_snipers":
      bundlename = taacombundle.var_4062b33e;
      break;
    case #"planemortar":
      bundlename = taacombundle.planemortardialogbundle;
      break;
    case #"recon_car":
      bundlename = taacombundle.rcbombdialogbundle;
      break;
    case #"remote_missile":
      bundlename = taacombundle.remotemissiledialogbundle;
      break;
    case #"straferun":
      bundlename = taacombundle.straferundialogbundle;
      break;
    case #"supply_drop":
      bundlename = taacombundle.supplydropdialogbundle;
      break;
    case #"swat_team":
      bundlename = taacombundle.var_d93fd150;
      break;
    case #"uav":
      bundlename = taacombundle.uavdialogbundle;
      break;
    case #"ultimate_turret":
      bundlename = taacombundle.ultturretdialogbundle;
      break;
    default:
      break;
  }

  if(!isDefined(bundlename)) {
    return;
  }

  killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", bundlename);
  return killstreakbundle;
}

set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey, var_2888cc9d, var_826b3c1a) {
  level.leaderdialog = spawnStruct();
  level.leaderdialog.startgamedialog = startgamedialogkey;
  level.leaderdialog.var_f6fda321 = var_2888cc9d;
  level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
  level.leaderdialog.var_d04b3734 = var_826b3c1a;
  level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
  level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

function_5e0a6842() {
  leader_dialog("roundSwitchSides");
}

function_dfd17bd3() {
  leader_dialog("roundHalftime");
}

announce_round_winner(delay) {
  if(delay > 0) {
    wait delay;
  }

  winner = round::get_winner();

  if(!isDefined(winner) || isplayer(winner)) {
    return;
  }

  if(isDefined(level.teams[winner])) {
    if(level.gametype === "bounty" && round::function_3624d032() === 1) {
      leader_dialog("bountyRoundEncourageWon", winner);
      leader_dialog_for_other_teams("bountyRoundEncourageLost", winner);
    } else {
      leader_dialog("roundEncourageWon", winner);
      leader_dialog_for_other_teams("roundEncourageLost", winner);
    }

    return;
  }

  foreach(team, _ in level.teams) {
    thread sound::play_on_players("mus_round_draw" + "_" + level.teampostfix[team]);
  }

  leader_dialog("roundDraw");
}

announce_game_winner(outcome) {
  wait battlechatter::mpdialog_value("announceWinnerDelay", 0);

  if(level.teambased) {
    if(outcome::get_flag(outcome, "tie") || !match::function_c10174e7()) {
      leader_dialog("gameDraw");
      return;
    }

    leader_dialog("gameWon", outcome::get_winner(outcome));
    leader_dialog_for_other_teams("gameLost", outcome::get_winner(outcome));
  }
}

function_57678746(outcome) {}

function_6374b97e(tie) {
  if(tie) {
    self set_music_on_player("matchDraw");
    return;
  }

  if(match::function_a2b53e17(self)) {
    self set_music_on_player("matchWin");
    return;
  }

  if(!level.splitscreen) {
    self set_music_on_player("matchLose");
  }
}

flush_dialog() {
  foreach(player in level.players) {
    player flush_dialog_on_player();
  }
}

flush_dialog_on_player() {
  if(!isDefined(self.leaderdialogqueue)) {
    self.leaderdialogqueue = [];
  }

  self.currentleaderdialog = undefined;

  if(!isDefined(self.killstreakdialogqueue)) {
    self.killstreakdialogqueue = [];
  }

  self.scorestreakdialogplaying = 0;
  self notify(#"flush_dialog");
}

flush_killstreak_dialog_on_player(killstreakid) {
  if(!isDefined(killstreakid) || !isDefined(self.killstreakdialogqueue)) {
    return;
  }

  for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
    if(killstreakid === self.killstreakdialogqueue[i].killstreakid) {
      arrayremoveindex(self.killstreakdialogqueue, i);
    }
  }
}

function_fd32b1bd(killstreaktype) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(killstreaktype) || !isDefined(self.killstreakdialogqueue)) {
    return;
  }

  for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
    if(killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
      arrayremoveindex(self.killstreakdialogqueue, i);
    }
  }
}

flush_objective_dialog(objectivekey) {
  foreach(player in level.players) {
    player flush_objective_dialog_on_player(objectivekey);
  }
}

flush_objective_dialog_on_player(objectivekey) {
  if(!isDefined(objectivekey) || !isDefined(self.leaderdialogqueue)) {
    return;
  }

  for(i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
    if(objectivekey === self.leaderdialogqueue[i].objectivekey) {
      arrayremoveindex(self.leaderdialogqueue, i);
      break;
    }
  }
}

flush_leader_dialog_key(dialogkey) {
  foreach(player in level.players) {
    player flush_leader_dialog_key_on_player(dialogkey);
  }
}

flush_leader_dialog_key_on_player(dialogkey) {
  if(!isDefined(dialogkey)) {
    return;
  }

  if(!isDefined(self.leaderdialogqueue)) {
    return;
  }

  for(i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
    if(dialogkey === self.leaderdialogqueue[i].dialogkey) {
      arrayremoveindex(self.leaderdialogqueue, i);
    }
  }
}

play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
  self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, undefined, soundevent, var_8a6b001a, weapon, priority);
}

killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex, soundevent, var_8a6b001a, weapon, priority) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.killstreakdialogqueue)) {
    return;
  }

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
  newdialog.soundevent = soundevent;
  newdialog.var_8a6b001a = var_8a6b001a;
  newdialog.weapon = weapon;

  if(priority === 1) {
    arrayinsert(self.killstreakdialogqueue, newdialog, 0);
  } else {
    self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
  }

  if(self.killstreakdialogqueue.size > 1 || isDefined(self.currentkillstreakdialog)) {
    return;
  }

  if(self.playingdialog === 1 && dialogkey == "arrive") {
    self thread wait_for_player_dialog();
    return;
  }

  self thread play_next_killstreak_dialog();
}

wait_for_player_dialog() {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  while(self.playingdialog) {
    wait 0.5;
  }

  self thread play_next_killstreak_dialog();
}

play_next_killstreak_dialog() {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  if(self.killstreakdialogqueue.size == 0) {
    self.currentkillstreakdialog = undefined;
    return;
  }

  if(isDefined(self.pers[#"mptaacom"])) {
    taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers[#"mptaacom"]);
  } else {
    self.killstreakdialogqueue = [];
    self.currentkillstreakdialog = undefined;
    return;
  }

  for(dialogalias = undefined; !isDefined(dialogalias) && self.killstreakdialogqueue.size > 0; dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey)) {
    nextdialog = self.killstreakdialogqueue[0];
    arrayremoveindex(self.killstreakdialogqueue, 0);

    if(isDefined(nextdialog.killstreaktype)) {
      if(isDefined(nextdialog.pilotindex)) {
        pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];

        if(isDefined(pilotarray) && nextdialog.pilotindex < pilotarray.size) {
          killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", pilotarray[nextdialog.pilotindex]);

          if(isDefined(killstreakbundle)) {
            dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
          }
        }
      } else if(isDefined(nextdialog.killstreaktype)) {
        killstreakbundle = function_6e084fd3(nextdialog.killstreaktype, taacombundle);

        if(isDefined(killstreakbundle)) {
          dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
        }
      }

      continue;
    }
  }

  if(!isDefined(dialogalias)) {
    self.currentkillstreakdialog = undefined;
    return;
  }

  waittime = 0;

  if(isDefined(nextdialog.soundevent) && isDefined(nextdialog.var_8a6b001a) && isalive(nextdialog.var_8a6b001a)) {
    waittime += battlechatter::mpdialog_value("taacomHackAndReplyDialogBuffer", 0);
    self thread function_30f16f29(nextdialog.soundevent, nextdialog.var_8a6b001a, nextdialog.weapon);
  } else {
    self playlocalsound(dialogalias);
    waittime += battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
  }

  self.currentkillstreakdialog = nextdialog;
  self thread wait_next_killstreak_dialog(waittime);
}

wait_next_killstreak_dialog(waittime) {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");
  wait waittime;
  self thread play_next_killstreak_dialog();
}

function_30f16f29(soundevent, var_8a6b001a, weapon) {
  if(isDefined(var_8a6b001a) && isalive(var_8a6b001a)) {
    var_8a6b001a playsoundevent(soundevent, weapon, self);
  }
}

leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
  assert(isDefined(skipteam));

  foreach(team, _ in level.teams) {
    if(team != skipteam) {
      leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
    }
  }
}

leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
  assert(isDefined(level.players));

  foreach(player in level.players) {
    if(!isDefined(player.pers[#"team"])) {
      continue;
    }

    if(isDefined(team) && team != player.pers[#"team"]) {
      continue;
    }

    if(isDefined(excludelist) && globallogic_utils::isexcluded(player, excludelist)) {
      continue;
    }

    player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey);
  }
}

leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog) {
  if(!isDefined(dialogkey)) {
    return;
  }

  if(!level.allowannouncer) {
    return;
  }

  if(!(isDefined(self.playleaderdialog) && self.playleaderdialog) && !(isDefined(introdialog) && introdialog)) {
    return;
  }

  self flush_objective_dialog_on_player(objectivekey);

  if(!isDefined(self.leaderdialogqueue)) {
    self.leaderdialogqueue = [];
  }

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

play_next_leader_dialog() {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  if(!isDefined(self.leaderdialogqueue) || self.leaderdialogqueue.size == 0) {
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
    } else if(triggeredcount > 1 || nextdialog.playmultiple === 1) {
      if(isDefined(level.multipledialogkeys[dialogkey])) {
        dialogkey = level.multipledialogkeys[dialogkey];
      }
    }
  }

  if(dialogkey === "gamePlayerKicked") {
    self playsoundevent(2);
  } else {
    dialogalias = self get_commander_dialog_alias(dialogkey);

    if(!isDefined(dialogalias)) {
      self thread play_next_leader_dialog();
      return;
    }

    self playlocalsound(dialogalias);
  }

  nextdialog.playtime = gettime();
  self.currentleaderdialog = nextdialog;
  dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
  self thread wait_next_leader_dialog(dialogbuffer);
}

wait_next_leader_dialog(dialogbuffer) {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");
  wait dialogbuffer;
  self thread play_next_leader_dialog();
}

dialogkey_priority(dialogkey) {
  switch (dialogkey) {
    case #"enemydronestrikemultiple":
    case #"enemyplanemortarmultiple":
    case #"enemyaitank":
    case #"enemydronestrike":
    case #"enemymicrowaveturretmultiple":
    case #"enemydart":
    case #"enemydartmultiple":
    case #"enemyremotemissile":
    case #"enemyplanemortar":
    case #"enemycombatrobotmultiple":
    case #"enemyrcbombmultiple":
    case #"enemyremotemissilemultiple":
    case #"enemyrapsmultiple":
    case #"enemyhelicoptergunner":
    case #"enemyrcbomb":
    case #"enemycombatrobot":
    case #"enemyhelicopter":
    case #"enemyturret":
    case #"enemyturretmultiple":
    case #"enemyhelicoptergunnermultiple":
    case #"enemyraps":
    case #"enemyplanemortarused":
    case #"enemyhelicoptermultiple":
    case #"enemymicrowaveturret":
    case #"enemyaitankmultiple":
      return 1;
    case #"roundencouragelastplayer":
    case #"gamelosing":
    case #"nearwinning":
    case #"gameleadlost":
    case #"nearlosing":
    case #"neardrawing":
    case #"gameleadtaken":
    case #"gamewinning":
      return 1;
    case #"upltheyuplink":
    case #"uplorders":
    case #"sfgrobotneedreboot":
    case #"domfriendlysecuredall":
    case #"hubsonline":
    case #"sfgstarttow":
    case #"sfgtheyreturn":
    case #"sfgrobotunderfire":
    case #"kothonline":
    case #"bombfriendlytaken":
    case #"ctffriendlyflagcaptured":
    case #"sfgrobotrebootedtowdefender":
    case #"hubmoved":
    case #"sfgrobotrebootedtowattacker":
    case #"uplweuplinkremote":
    case #"bombplanted":
    case #"uplreset":
    case #"sfgrobotrebooteddefender":
    case #"ctfenemyflagdropped":
    case #"sfgrobotunderfireneutral":
    case #"ctffriendlyflagdropped":
    case #"upltheydrop":
    case #"domenemyhasc":
    case #"kothcontested":
    case #"ctfenemyflagtaken":
    case #"domenemyhasb":
    case #"uplwedrop":
    case #"uplweuplink":
    case #"hubsoffline":
    case #"domenemysecureda":
    case #"domenemysecuredb":
    case #"domenemysecuredc":
    case #"domenemyhasa":
    case #"upltransferred":
    case #"sfgstarthrdefend":
    case #"upltheyuplinkremote":
    case #"ctfenemyflagreturned":
    case #"bombenemytaken":
    case #"uplwetake":
    case #"sfgstarthrattack":
    case #"sfgrobotclosedefender":
    case #"kothsecured":
    case #"sfgwereturn":
    case #"hubsmoved":
    case #"sfgstartattack":
    case #"ctfenemyflagcaptured":
    case #"sfgrobotdisabledattacker":
    case #"sfgrobotrebootedattacker":
    case #"hubonline":
    case #"sfgstartdefend":
    case #"ctffriendlyflagreturned":
    case #"ctffriendlyflagtaken":
    case #"upltheytake":
    case #"sfgrobotcloseattacker":
    case #"bombdefused":
    case #"huboffline":
    case #"domenemysecuringc":
    case #"sfgrobotdisableddefender":
    case #"domfriendlysecuredc":
    case #"domfriendlysecuredb":
    case #"domfriendlysecureda":
    case #"domenemysecuringb":
    case #"domenemysecuringa":
    case #"kothcaptured":
    case #"kothlocated":
    case #"kothlost":
    case #"bombfriendlydropped":
    case #"domfriendlysecuringb":
    case #"domfriendlysecuringc":
    case #"domfriendlysecuringa":
      return 1;
  }

  return undefined;
}

play_equipment_destroyed_on_player() {
  self play_taacom_dialog("equipmentDestroyed");
}

play_equipment_hacked_on_player() {
  self play_taacom_dialog("equipmentHacked");
}

get_commander_dialog_alias(dialogkey) {
  if(!isDefined(self.pers[#"mpcommander"])) {
    return undefined;
  }

  commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers[#"mpcommander"]);
  return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  dialogalias = dialogbundle.(dialogkey);

  if(!isDefined(dialogalias)) {
    return;
  }

  voiceprefix = dialogbundle.("voiceprefix");

  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }

  return dialogalias;
}

is_team_winning(checkteam) {
  score = game.stat[#"teamscores"][checkteam];

  foreach(team, _ in level.teams) {
    if(team != checkteam) {
      if(game.stat[#"teamscores"][team] >= score) {
        return false;
      }
    }
  }

  return true;
}

announce_team_is_winning() {
  foreach(team, _ in level.teams) {
    if(is_team_winning(team)) {
      leader_dialog("gameWinning", team);
      leader_dialog_for_other_teams("gameLosing", team);
      return true;
    }
  }

  return false;
}

play_2d_on_team(alias, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player playlocalsound(alias);
    }
  }
}

get_round_switch_dialog(switchtype) {
  switch (switchtype) {
    case 2:
      return "roundHalftime";
    case 4:
      return "roundOvertime";
    default:
      return "roundSwitchSides";
  }
}

on_end_game() {
  level util::clientnotify("pm");
  level waittill(#"sfade");
  level util::clientnotify("pmf");
}

announcercontroller() {
  level endon(#"game_ended");
  level waittill(#"match_ending_soon");

  if(util::islastround() || util::isoneround()) {
    if(level.teambased) {
      if(!announce_team_is_winning()) {
        leader_dialog("min_draw");
      }
    }

    level waittill(#"match_ending_very_soon");

    foreach(team, _ in level.teams) {
      leader_dialog("roundTimeWarning", team, undefined, undefined);
    }

    return;
  }

  level waittill(#"match_ending_vox");
  leader_dialog("roundTimeWarning");
}

sndmusicfunctions() {
  level thread sndmusictimesout();
  level thread sndmusichalfway();
  level thread sndmusictimelimitwatcher();
  level thread sndmusicunlock();
}

sndmusicsetrandomizer() {
  if(isDefined(level.var_30783ca9)) {
    level thread[[level.var_30783ca9]]();
    return;
  }

  if(game.roundsplayed == 0) {
    game.musicset = randomintrange(1, 8);

    if(game.musicset <= 9) {
      game.musicset = "0" + game.musicset;
    }

    game.musicset = "_" + game.musicset;
  }
}

sndmusicunlock() {
  level waittill(#"game_ended");
  unlockname = undefined;

  switch (game.musicset) {
    case #"_01":
      unlockname = "mus_dystopia_intro";
      break;
    case #"_02":
      unlockname = "mus_filter_intro";
      break;
    case #"_03":
      unlockname = "mus_immersion_intro";
      break;
    case #"_04":
      unlockname = "mus_ruin_intro";
      break;
    case #"_05":
      unlockname = "mus_cod_bites_intro";
      break;
  }

  if(isDefined(unlockname)) {
    level thread audio::unlockfrontendmusic(unlockname);
  }
}

sndmusictimesout() {
  level endon(#"game_ended", #"musicendingoverride");
  level waittill(#"match_ending_very_soon");

  if(isDefined(level.gametype) && level.gametype == "sd") {
    level thread set_music_on_team("timeOutQuiet");
    return;
  }

  level thread set_music_on_team("timeOut");
}

sndmusichalfway() {
  level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon");
  level waittill(#"sndmusichalfway");
  level thread set_music_on_team("underscore");
}

sndmusictimelimitwatcher() {
  level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon", #"sndmusichalfway");

  if(!isDefined(level.timelimit) || level.timelimit == 0) {
    return;
  }

  halfway = level.timelimit * 60 * 0.5;

  while(true) {
    timeleft = float(globallogic_utils::gettimeremaining()) / 1000;

    if(timeleft <= halfway) {
      level notify(#"sndmusichalfway");
      return;
    }

    wait 2;
  }
}

set_music_on_team(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
  assert(isDefined(level.players));

  foreach(player in level.players) {
    if(team == "both") {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
      continue;
    }

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
    }
  }
}

set_music_on_player(state, wait_time = 0, save_state = 0, return_state = 0) {
  self endon(#"disconnect");
  assert(isplayer(self));

  if(!isDefined(state)) {
    return;
  }

  if(!isDefined(game.musicset)) {
    return;
  }

  if(sessionmodeiswarzonegame()) {
    return;
  }

  if(isDefined(level.var_903e2252) && level.var_903e2252) {
    return;
  }

  music::setmusicstate(state + game.musicset, self);
}

set_music_global(state, wait_time = 0, save_state = 0, return_state = 0) {
  if(!isDefined(state)) {
    return;
  }

  if(!isDefined(game.musicset)) {
    return;
  }

  if(isDefined(level.var_903e2252) && level.var_903e2252) {
    return;
  }

  if(sessionmodeiswarzonegame()) {
    return;
  }

  music::setmusicstate(state + game.musicset);
}

function_85818e24(var_9c1ed9ea, team) {
  if(!isDefined(game.musicset)) {
    return;
  }

  if(!isDefined(var_9c1ed9ea)) {
    return;
  }

  if(isDefined(team)) {
    foreach(player in level.players) {
      if(!isDefined(player.pers[#"team"])) {
        continue;
      }

      if(isDefined(team) && team != player.pers[#"team"]) {
        continue;
      }

      music::setmusicstate(var_9c1ed9ea + game.musicset, player);
    }

    return;
  }

  music::setmusicstate(var_9c1ed9ea + game.musicset);
}