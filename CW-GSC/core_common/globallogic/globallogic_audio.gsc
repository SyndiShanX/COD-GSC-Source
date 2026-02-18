/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_audio.gsc
*********************************************************/

#using script_396f7d71538c9677;
#using script_3d703ef87a841fe4;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace globallogic_audio;

function private autoexec __init__system__() {
  system::register(#"globallogic_audio", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread function_dd5d8f8e();
}

function function_dd5d8f8e() {
  if(!isDefined(game.musicset)) {
    game.musicset = randomintrange(1, 6);

    if(game.musicset <= 9) {
      game.musicset = "0" + game.musicset;
    }

    game.musicset = "_" + game.musicset;
  }
}

function function_6e084fd3(var_37ecca7, taacombundle) {
  bundlename = undefined;

  switch (var_37ecca7) {
    case # "tank_robot":
      bundlename = taacombundle.aitankdialogbundle;
      break;
    case # "chopper_gunner":
    case # "inventory_chopper_gunner":
      bundlename = taacombundle.var_3f45482e;
      break;
    case # "counteruav":
      bundlename = taacombundle.counteruavdialogbundle;
      break;
    case # "dart":
      bundlename = taacombundle.dartdialogbundle;
      break;
    case # "sig_lmg":
      bundlename = taacombundle.var_4129b7a;
      break;
    case # "drone_squadron":
      bundlename = taacombundle.var_69a9ca12;
      break;
    case # "sig_bow_flame":
      bundlename = taacombundle.var_82cefc8c;
      break;
    case # "hero_flamethrower":
      bundlename = taacombundle.var_43bcc95e;
      break;
    case # "ac130":
    case # "inventory_ac130":
      bundlename = taacombundle.var_71693229;
      break;
    case # "hero_pineapplegun":
      bundlename = taacombundle.var_dcfac86e;
      break;
    case # "helicopter_comlink":
    case # "inventory_helicopter_comlink":
      bundlename = taacombundle.helicopterdialogbundle;
      break;
    case # "inventory_helicopter_guard":
    case # "helicopter_guard":
      bundlename = taacombundle.var_7275c81d;
      break;
    case # "hero_annihilator":
      bundlename = taacombundle.var_679bf19;
      break;
    case # "dog":
      bundlename = taacombundle.var_f68cebf2;
      break;
    case # "hoverjet":
    case # "inventory_hoverjet":
      bundlename = taacombundle.var_c96adb95;
      break;
    case # "overwatch_helicopter":
    case # "inventory_overwatch_helicopter":
      bundlename = taacombundle.overwatchhelicopterdialogbundle;
      break;
    case # "overwatch_helicopter_snipers":
      bundlename = taacombundle.var_4062b33e;
      break;
    case # "planemortar":
      bundlename = taacombundle.planemortardialogbundle;
      break;
    case # "recon_car":
      bundlename = taacombundle.rcbombdialogbundle;
      break;
    case # "recon_plane":
    case # "inventory_recon_plane":
      bundlename = taacombundle.var_5b8e4a97;
      break;
    case # "inventory_remote_missile":
    case # "remote_missile":
      bundlename = taacombundle.remotemissiledialogbundle;
      break;
    case # "straferun":
    case # "inventory_straferun":
      bundlename = taacombundle.straferundialogbundle;
      break;
    case # "supply_drop":
      bundlename = taacombundle.supplydropdialogbundle;
      break;
    case # "swat_team":
      bundlename = taacombundle.var_d93fd150;
      break;
    case # "uav":
      bundlename = taacombundle.uavdialogbundle;
      break;
    case # "ultimate_turret":
    case # "inventory_ultimate_turret":
      bundlename = taacombundle.ultturretdialogbundle;
      break;
    case # "hash_49d514608adc6a24":
    case # "jetfighter":
      bundlename = taacombundle.var_2f6e3044;
      break;
    case # "napalm_strike_zm":
    case # "napalm_strike":
    case # "inventory_napalm_strike":
      bundlename = taacombundle.var_3ab478cf;
      break;
    case # "weapon_armor":
    case # "hash_6bf7a941e385e178":
      bundlename = taacombundle.var_17e0a105;
      break;
    case # "nuke":
    case # "inventory_nuke":
      bundlename = taacombundle.var_6e8d651b;
      break;
    default:
      break;
  }

  if(!isDefined(bundlename)) {
    return;
  }

  killstreakbundle = getscriptbundle(bundlename);
  return killstreakbundle;
}

function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey, var_2888cc9d, var_826b3c1a) {
  level.leaderdialog = spawnStruct();
  level.leaderdialog.startgamedialog = startgamedialogkey;
  level.leaderdialog.var_f6fda321 = var_2888cc9d;
  level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
  level.leaderdialog.var_d04b3734 = var_826b3c1a;
  level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
  level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

function function_ac2cb1bc() {
  foreach(player in level.players) {
    player.leaderdialogqueue = [];
  }
}

function flush_dialog() {
  foreach(player in level.players) {
    player flush_dialog_on_player();
  }
}

function flush_dialog_on_player() {
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

function flush_killstreak_dialog_on_player(killstreakid) {
  if(!isDefined(killstreakid) || !isDefined(self.killstreakdialogqueue)) {
    return;
  }

  for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
    if(killstreakid === self.killstreakdialogqueue[i].killstreakid) {
      arrayremoveindex(self.killstreakdialogqueue, i);
    }
  }
}

function function_fd32b1bd(killstreaktype) {
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

function flush_objective_dialog(objectivekey) {
  foreach(player in level.players) {
    player flush_objective_dialog_on_player(objectivekey);
  }
}

function flush_objective_dialog_on_player(objectivekey) {
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

function flush_leader_dialog_key(dialogkey) {
  foreach(player in level.players) {
    player flush_leader_dialog_key_on_player(dialogkey);
  }
}

function flush_leader_dialog_key_on_player(dialogkey) {
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

function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
  self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, undefined, soundevent, var_8a6b001a, weapon, priority);
}

function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex, soundevent, var_8a6b001a, weapon, priority) {
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

function wait_for_player_dialog() {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  while(self.playingdialog) {
    wait 0.5;
  }

  if(!isDefined(self)) {
    return;
  }

  self thread play_next_killstreak_dialog();
}

function play_next_killstreak_dialog() {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  if(self.killstreakdialogqueue.size == 0) {
    self.currentkillstreakdialog = undefined;
    return;
  }

  if(isDefined(self.var_9c1a4644)) {
    taacombundle = getscriptbundle(self.var_9c1a4644);
  } else if(isDefined(self.pers[level.var_bc01f047])) {
    taacombundle = getscriptbundle(self.pers[level.var_bc01f047]);
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
          killstreakbundle = getscriptbundle(pilotarray[nextdialog.pilotindex]);

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
    function_d9079fc1(dialogalias, "<dev string:x38>");

    self playlocalsound(dialogalias);
    waittime += battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
  }

  self.currentkillstreakdialog = nextdialog;
  self thread wait_next_killstreak_dialog(waittime);
}

function wait_next_killstreak_dialog(waittime) {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");
  wait waittime;

  if(!isDefined(self)) {
    return;
  }

  self thread play_next_killstreak_dialog();
}

function function_30f16f29(soundevent, var_8a6b001a, weapon) {
  if(isDefined(var_8a6b001a) && isalive(var_8a6b001a)) {
    var_8a6b001a playsoundevent(soundevent, weapon, self);
  }
}

function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004) {
  assert(isDefined(skipteam));

  foreach(team, _ in level.teams) {
    if(team != skipteam) {
      leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004);
    }
  }
}

function function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey, dialogalias, skippable, var_6ad14004) {
  assert(isDefined(players));

  foreach(player in players) {
    player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, undefined, dialogalias, skippable, var_6ad14004);
  }
}

function function_248fc9f7(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004) {
  assert(isDefined(excludelist));
  assert(isDefined(level.players));
  players = isDefined(team) ? getplayers(team) : level.players;
  players = array::exclude(players, excludelist);
  function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004);
}

function function_b4319f8e(dialogkey, team, exclude, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004) {
  assert(isDefined(exclude));
  assert(isDefined(level.players));
  players = isDefined(team) ? getplayers(team) : level.players;
  arrayremovevalue(players, exclude);
  function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004);
}

function leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey, skippable, var_6ad14004) {
  if(is_true(level.is_survival)) {
    if(isDefined(dialogkey)) {
      if(issubstr(dialogkey, "Response")) {
        return;
      }
    }
  }

  players = getplayers(team);
  function_61e17de0(dialogkey, players, objectivekey, killstreakid, dialogbufferkey, undefined, skippable, var_6ad14004);
}

function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog, dialogalias, skippable, var_6ad14004) {
  if(!isDefined(dialogkey)) {
    return;
  }

  if(!level.allowannouncer) {
    return;
  }

  if(!is_true(self.playleaderdialog) && !is_true(introdialog)) {
    return;
  }

  if(skippable === 1 && isDefined(self.currentleaderdialog)) {
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
  newitem.var_6ad14004 = var_6ad14004;

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

  self thread play_next_leader_dialog(dialogalias);
}

function play_next_leader_dialog(dialogalias) {
  self endon(#"disconnect", #"flush_dialog");
  level endon(#"game_ended");

  if(self.leaderdialogqueue.size == 0) {
    self.currentleaderdialog = undefined;
    self notify(#"hash_73f839d8939452ad");
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
  } else if(dialogkey === "gameDraw") {
    self playsoundevent(12);
  } else if(dialogkey === "gameLost") {
    self playsoundevent(13);
  } else if(dialogkey === "gameWon") {
    if(isDefined(level.var_21d88451)) {
      self playlocalsound(level.var_21d88451);
    } else {
      self playsoundevent(14);
    }
  } else {
    if(!isDefined(dialogalias)) {
      dialogalias = self get_commander_dialog_alias(dialogkey, nextdialog.var_6ad14004);
    }

    if(!isDefined(dialogalias)) {
      self thread play_next_leader_dialog();
      return;
    }

    function_d9079fc1(dialogalias, "<dev string:x4d>");

    self playlocalsound(dialogalias);
  }

  nextdialog.playtime = gettime();
  self.currentleaderdialog = nextdialog;

  if(is_true(level.var_28ebc1e8)) {
    if(isDefined(level.var_9a1b7fdf)) {
      dialogbuffer = self[[level.var_9a1b7fdf]](dialogalias, dialogkey);
    } else {
      dialogbuffer = float(max(isDefined(soundgetplaybacktime(dialogalias)) ? soundgetplaybacktime(dialogalias) : 500, 500)) / 1000;
    }
  } else {
    dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
  }

  self thread wait_next_leader_dialog(dialogbuffer);
}

function wait_next_leader_dialog(dialogbuffer) {
  self endon(#"disconnect", #"flush_dialog");
  wait dialogbuffer;

  if(isDefined(self)) {
    self thread play_next_leader_dialog();
  }
}

function dialogkey_priority(dialogkey) {
  switch (dialogkey) {
    case # "enemydronestrikemultiple":
    case # "enemyplanemortarmultiple":
    case # "enemyaitank":
    case # "enemydronestrike":
    case # "enemymicrowaveturretmultiple":
    case # "enemydart":
    case # "enemydartmultiple":
    case # "enemyremotemissile":
    case # "enemyplanemortar":
    case # "enemycombatrobotmultiple":
    case # "enemyrcbombmultiple":
    case # "enemyremotemissilemultiple":
    case # "enemyrapsmultiple":
    case # "enemyhelicoptergunner":
    case # "enemyrcbomb":
    case # "enemycombatrobot":
    case # "enemyhelicopter":
    case # "enemyturret":
    case # "enemyturretmultiple":
    case # "enemyhelicoptergunnermultiple":
    case # "enemyraps":
    case # "enemyplanemortarused":
    case # "enemyhelicoptermultiple":
    case # "enemymicrowaveturret":
    case # "enemyaitankmultiple":
      return 1;
    case # "roundencouragelastplayer":
    case # "gamelosing":
    case # "nearwinning":
    case # "gameleadlost":
    case # "nearlosing":
    case # "neardrawing":
    case # "gameleadtaken":
    case # "gamewinning":
      return 1;
    case # "upltheyuplink":
    case # "uplorders":
    case # "sfgrobotneedreboot":
    case # "domfriendlysecuredall":
    case # "hubsonline":
    case # "sfgstarttow":
    case # "sfgtheyreturn":
    case # "sfgrobotunderfire":
    case # "kothonline":
    case # "bombfriendlytaken":
    case # "ctffriendlyflagcaptured":
    case # "sfgrobotrebootedtowdefender":
    case # "hubmoved":
    case # "sfgrobotrebootedtowattacker":
    case # "uplweuplinkremote":
    case # "bombplanted":
    case # "uplreset":
    case # "sfgrobotrebooteddefender":
    case # "ctfenemyflagdropped":
    case # "sfgrobotunderfireneutral":
    case # "ctffriendlyflagdropped":
    case # "upltheydrop":
    case # "domenemyhasc":
    case # "kothcontested":
    case # "ctfenemyflagtaken":
    case # "domenemyhasb":
    case # "uplwedrop":
    case # "uplweuplink":
    case # "hubsoffline":
    case # "domenemysecureda":
    case # "domenemysecuredb":
    case # "domenemysecuredc":
    case # "domenemyhasa":
    case # "upltransferred":
    case # "sfgstarthrdefend":
    case # "upltheyuplinkremote":
    case # "ctfenemyflagreturned":
    case # "bombenemytaken":
    case # "uplwetake":
    case # "sfgstarthrattack":
    case # "sfgrobotclosedefender":
    case # "kothsecured":
    case # "sfgwereturn":
    case # "hubsmoved":
    case # "sfgstartattack":
    case # "ctfenemyflagcaptured":
    case # "sfgrobotdisabledattacker":
    case # "sfgrobotrebootedattacker":
    case # "hubonline":
    case # "sfgstartdefend":
    case # "ctffriendlyflagreturned":
    case # "ctffriendlyflagtaken":
    case # "upltheytake":
    case # "sfgrobotcloseattacker":
    case # "bombdefused":
    case # "huboffline":
    case # "domenemysecuringc":
    case # "sfgrobotdisableddefender":
    case # "domfriendlysecuredc":
    case # "domfriendlysecuredb":
    case # "domfriendlysecureda":
    case # "domenemysecuringb":
    case # "domenemysecuringa":
    case # "kothcaptured":
    case # "kothlocated":
    case # "kothlost":
    case # "bombfriendlydropped":
    case # "domfriendlysecuringb":
    case # "domfriendlysecuringc":
    case # "domfriendlysecuringa":
      return 1;
  }

  return undefined;
}

function play_equipment_destroyed_on_player() {
  self play_taacom_dialog("equipmentDestroyed");
}

function play_equipment_hacked_on_player() {
  self play_taacom_dialog("equipmentHacked");
}

function get_commander_dialog_alias(dialogkey, var_6ad14004) {
  if(!isDefined(self.pers[level.var_7ee6af9f])) {
    return undefined;
  }

  commanderbundle = getscriptbundle(self.pers[level.var_7ee6af9f]);
  return get_dialog_bundle_alias(commanderbundle, dialogkey, var_6ad14004);
}

function get_dialog_bundle_alias(dialogbundle, dialogkey, var_6ad14004) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  if(ishash(dialogkey)) {
    if(isDefined(level.var_3727097e)) {
      dialogalias = self[[level.var_3727097e]](dialogbundle, dialogkey);
    } else {
      iprintlnbold("<dev string:x62>" + function_9e72a96(dialogkey) + "<dev string:x77>");
    }
  } else {
    dialogalias = dialogbundle.(dialogkey);
  }

  if(!isDefined(dialogalias)) {
    return;
  }

  if(!ishash(dialogalias)) {
    if(var_6ad14004 === 1) {
      faction = teams::function_20cfd8b5(self.pers[# "team"]);
      var_2e00736a = faction.var_ce1913bd;

      if(isDefined(var_2e00736a)) {
        dialogalias = var_2e00736a + dialogalias;
      }
    }

    voiceprefix = dialogbundle.("voiceprefix");

    if(isDefined(level.var_beb69c9)) {
      voiceprefix = self[[level.var_beb69c9]](dialogkey, voiceprefix);
    }

    if(isDefined(voiceprefix)) {
      dialogalias = voiceprefix + dialogalias;
    }
  }

  return dialogalias;
}

function function_2523d20f(dialogkey) {
  if(!isDefined(self.pers[level.var_7ee6af9f])) {
    return undefined;
  }

  commanderbundle = getscriptbundle(self.pers[level.var_7ee6af9f]);
  return function_f554c1ad(commanderbundle, dialogkey);
}

function function_f554c1ad(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  dialogkey += "SpeakerBundle";

  if(ishash(dialogkey)) {
    if(isDefined(level.var_9f234058)) {
      var_3a0f7868 = self[[level.var_9f234058]](dialogbundle, dialogkey);
    } else {
      iprintlnbold("<dev string:x62>" + function_9e72a96(dialogkey) + "<dev string:x130>");
    }
  } else {
    var_3a0f7868 = dialogbundle.(dialogkey);
  }

  return var_3a0f7868;
}

function function_14964eb8(dialogkey) {
  if(!isDefined(self.pers[level.var_7ee6af9f])) {
    return undefined;
  }

  commanderbundle = getscriptbundle(self.pers[level.var_7ee6af9f]);
  return function_ec14f55(commanderbundle, dialogkey);
}

function function_ec14f55(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  dialogkey += "_soundLengthOverride";

  if(ishash(dialogkey)) {
    if(isDefined(level.var_695f6028)) {
      var_d042255d = self[[level.var_695f6028]](dialogbundle, dialogkey);
    } else {
      iprintlnbold("<dev string:x62>" + function_9e72a96(dialogkey) + "<dev string:x1eb>");
    }
  } else {
    var_d042255d = dialogbundle.(dialogkey);
  }

  return var_d042255d;
}

function is_team_winning(checkteam) {
  score = game.stat[# "teamscores"][checkteam];

  foreach(team, _ in level.teams) {
    if(team != checkteam) {
      if(game.stat[# "teamscores"][team] >= score) {
        return false;
      }
    }
  }

  return true;
}

function function_abf21f69(alias, players) {
  foreach(player in players) {
    player playlocalsound(alias);
  }
}

function play_2d_on_team(alias, team) {
  function_abf21f69(alias, getplayers(team));
}

function on_end_game() {
  level util::clientnotify("pm");
  level waittill(#"sfade");
  level util::clientnotify("pmf");
}

function set_music_on_team(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
  assert(isDefined(level.players));

  foreach(player in level.players) {
    if(team == "both") {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
      continue;
    }

    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team) {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
    }
  }
}

function function_89fe8163(state, team = "both", wait_time = 0, save_state = 0, return_state = 0) {
  assert(isDefined(level.players));

  foreach(player in level.players) {
    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] != team) {
      player thread set_music_on_player(state, wait_time, save_state, return_state);
    }
  }
}

function set_music_on_player(state, wait_time, save_state, return_state = 0) {
  self endon(#"disconnect");
  assert(isPlayer(self));

  if(!isDefined(save_state)) {
    return;
  }

  if(!isDefined(game.musicset)) {
    return;
  }

  if(is_true(level.is_survival)) {
    return;
  }

  if(is_true(level.var_3a701785)) {
    return;
  }

  if(is_true(level.var_97902f80)) {
    if(game.state === # "playing") {
      return;
    }
  }

  music::setmusicstate(save_state + game.musicset, self, return_state);
}

function set_music_global(state, wait_time, save_state, return_state = 0) {
  if(!isDefined(save_state)) {
    return;
  }

  if(!isDefined(game.musicset)) {
    return;
  }

  if(is_true(level.is_survival)) {
    return;
  }

  if(is_true(level.var_3a701785)) {
    return;
  }

  if(is_true(level.var_97902f80)) {
    if(game.state === # "playing") {
      return;
    }
  }

  music::setmusicstate(save_state + game.musicset, undefined, return_state);
}

function function_85818e24(var_9c1ed9ea, team) {}

function function_c246758e(str_state, n_delay = 0) {
  assert(isPlayer(self));

  if(!isDefined(str_state)) {
    return;
  }

  if(game.state != # "playing") {
    return;
  }

  music::setmusicstate(str_state, self, n_delay);
}

function function_6fbfba95(str_state, n_delay = 0) {
  self notify("30f6ae0e1f12b849");
  self endon("30f6ae0e1f12b849");

  if(!isDefined(str_state)) {
    return;
  }

  if(game.state != # "playing") {
    return;
  }

  if(n_delay) {
    wait n_delay;
  }

  music::setmusicstate(str_state);
}

function function_6daffa93(weapon, var_f3ab6571) {
  if(!isDefined(weapon)) {
    return;
  }

  switch (weapon.name) {
    case # "ability_smart_cover":
      taacomdialog = "smartCoverWeaponDestroyedFriendly";
      break;
    case # "gadget_jammer":
      taacomdialog = "jammerWeaponDestroyedFriendly";
      break;
    case # "gadget_supplypod":
      taacomdialog = "supplyPodWeaponDestroyedFriendly";
      break;
    case # "land_mine":
      taacomdialog = "landmineWeaponDestroyedFriendly";
      break;
    case # "listening_device":
      taacomdialog = "listenWeaponDestroyedFriendly";
      break;
    case # "missile_turret":
      taacomdialog = "missileTurretWeaponDestroyedFriendly";
      break;
    case # "tear_gas":
      taacomdialog = "tearGasWeaponDestroyedFriendly";
      break;
    case # "trophy_system":
      taacomdialog = "trophyWeaponDestroyedFriendly";
      break;
  }

  if(isDefined(taacomdialog)) {
    if(is_true(var_f3ab6571)) {
      taacomdialog += "Multiple";
    }

    play_taacom_dialog(taacomdialog);
  }
}

function function_a2cde53d(weapon, var_f3ab6571) {
  if(!isDefined(weapon)) {
    return;
  }

  switch (weapon.name) {
    case # "ability_smart_cover":
      taacomdialog = "smartCoverHacked";
      break;
    case # "gadget_jammer":
      taacomdialog = "jammerHacked";
      break;
    case # "gadget_supplypod":
      taacomdialog = "supplyPodHacked";
      break;
    case # "land_mine":
      taacomdialog = "landmineHacked";
      break;
    case # "listening_device":
      taacomdialog = "listenHacked";
      break;
    case # "missile_turret":
      taacomdialog = "missileTurretHacked";
      break;
    case # "tear_gas":
      taacomdialog = "tearGasHacked";
      break;
    case # "trophy_system":
      taacomdialog = "trophyHacked";
      break;
  }

  if(isDefined(taacomdialog)) {
    if(is_true(var_f3ab6571)) {
      taacomdialog += "Multiple";
    }

    play_taacom_dialog(taacomdialog);
  }
}

function function_4fb91bc7(weapon, var_df17fa82, var_53c10ed8) {
  if(!isDefined(weapon) || !isDefined(var_df17fa82) || !isPlayer(var_df17fa82) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  switch (weapon.name) {
    case # "eq_emp_grenade":
      taacomdialog = "jammerWeaponHacked";
      break;
    case # "eq_tripwire":
      taacomdialog = "meshMineWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case # "eq_seeker_mine":
      taacomdialog = "seekerMineWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case # "eq_sensor":
      taacomdialog = "sensorDartHacked";
      var_b3fe42a9 = 1;
      break;
    case # "ability_smart_cover":
    case # "gadget_smart_cover":
      taacomdialog = "smartCoverHacked";
      var_b3fe42a9 = 1;
      break;
    case # "gadget_spawnbeacon":
      taacomdialog = "spawnBeaconHacked";
      break;
    case # "gadget_supplypod":
      taacomdialog = "supplyPodHacked";
      var_b3fe42a9 = 1;
      break;
    case # "trophy_system":
      taacomdialog = "trophyWeaponHacked";
      var_b3fe42a9 = 1;
      break;
    case # "ac130":
    case # "inventory_ac130":
      taacomdialog = "ac130Hacked";
      break;
    case # "inventory_chopper_gunner":
    case # "chopper_gunner":
      taacomdialog = "chopperGunnerHacked";
      break;
    case # "inventory_tank_robot":
    case # "tank_robot":
    case # "ai_tank_marker":
      taacomdialog = "aiTankHacked";
      var_b3fe42a9 = 1;
      break;
    case # "cobra_20mm_comlink":
    case # "helicopter_comlink":
    case # "inventory_helicopter_comlink":
      taacomdialog = "attackChopperHacked";
      break;
    case # "inventory_helicopter_guard":
    case # "helicopter_guard":
      taacomdialog = "heavyAttackChopperHacked";
      break;
    case # "counteruav":
      taacomdialog = "cuavHacked";
      var_b3fe42a9 = 1;
      break;
    case # "dart":
    case # "inventory_dart":
      taacomdialog = "dartHacked";
      break;
    case # "inventory_drone_squadron":
    case # "drone_squadron":
      taacomdialog = "droneSquadHacked";
      var_b3fe42a9 = 1;
      break;
    case # "hoverjet":
    case # "inventory_hoverjet":
      taacomdialog = "hoverJetHacked";
      break;
    case # "recon_car":
    case # "inventory_recon_car":
      taacomdialog = "reconCarHacked";
      break;
    case # "recon_plane":
    case # "inventory_recon_plane":
      taacomdialog = "reconPlaneHacked";
      break;
    case # "remote_missile":
    case # "inventory_remote_missile":
      taacomdialog = "hellstormHacked";
      break;
    case # "inventory_planemortar":
    case # "planemortar":
      taacomdialog = "lightningStrikeHacked";
      break;
    case # "overwatch_helicopter":
    case # "inventory_overwatch_helicopter":
      taacomdialog = "overwatchHelicopterHacked";
      break;
    case # "straferun":
    case # "inventory_straferun":
      taacomdialog = "strafeRunHacked";
      break;
    case # "supplydrop":
      taacomdialog = "supplyDropHacked";
      var_b3fe42a9 = 1;
      break;
    case # "uav":
      taacomdialog = "uavHacked";
      var_b3fe42a9 = 1;
      break;
    case # "inventory_ultimate_turret":
    case # "ultimate_turret":
      taacomdialog = "sentryHacked";
      var_b3fe42a9 = 1;
      break;
  }

  if(!isDefined(taacomdialog)) {
    return;
  }

  if((isDefined(self.var_d6422943) ? self.var_d6422943 : 0) > gettime()) {
    self thread play_taacom_dialog(taacomdialog);
    return;
  }

  if(var_b3fe42a9 === 1) {
    if(var_53c10ed8 === 1) {
      self thread play_taacom_dialog(taacomdialog, undefined, undefined, 5, var_df17fa82, weapon);
    } else {
      self thread play_taacom_dialog(taacomdialog, undefined, undefined, 3, var_df17fa82, weapon);
    }
  } else {
    self thread play_taacom_dialog(taacomdialog, undefined, undefined, 4, var_df17fa82);
  }

  self.var_d6422943 = gettime() + int(battlechatter::mpdialog_value("taacomHackedReplyCooldownSec", 0) * 1000);
}

function function_d9079fc1(str_alias, var_3cd9c84b) {
  var_a1f778fa = isdedicated() && function_541e02d0(str_alias) || soundexists(str_alias);

  if(getdvarint(#"debug_vo", 0)) {
    if(!var_a1f778fa) {
      var_2dbe34fe = "<dev string:x2a8>" + "<dev string:x2b6>" + function_9e72a96(str_alias) + "<dev string:x2c7>";
      iprintlnbold(var_2dbe34fe);
      println(var_2dbe34fe);
    }
  }

  if(var_a1f778fa) {
    if(getdvarint(#"debug_vo", 0)) {
      iprintlnbold(var_3cd9c84b + function_9e72a96(str_alias));
      println(var_3cd9c84b + function_9e72a96(str_alias));
    }
  }
}