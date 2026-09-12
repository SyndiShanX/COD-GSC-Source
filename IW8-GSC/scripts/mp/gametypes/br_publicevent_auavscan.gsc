/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_auavscan.gsc
************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("scr_br_pe_auavscan_weight", 0);
  var_0.ref_140CF = &ref_140CF;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.ref_14382 = &ref_14382;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11B78 = getdvarint("scr_br_pe_auavscan_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("auavscan", "20 20151510101010");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("auavscan");
  scripts\mp\gametypes\br_publicevents::ref_12B35(10, var_0);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function postinitfunc() {
  game["dialog"]["pe_auavscan_announcement"] = "public_events_ocscn_name";
  game["dialog"]["pe_auavscan_scan_imminent"] = "public_events_scan_imminent";
  game["dialog"]["pe_auavscan_scan_now"] = "public_events_scan_now";
  game["dialog"]["pe_auavscan_scan_end"] = "public_events_scan_end";
  game["dialog"]["pe_auavscan_stay_prone"] = "public_events_ocscn_stay_prone";
  game["dialog"]["pe_auavscan_spotted"] = "public_events_ocscn_spotted";
  game["dialog"]["pe_auavscan_scan_complete"] = "public_events_scan_complete";
  game["dialog"]["pe_auavscan_enemy_exposed"] = "public_events_ocscn_enemy_exposed";
  game["music"]["pe_auavscan_music_spotted"] = ["operation_scan_spotted_01", "operation_scan_spotted_02"];
  game["music"]["pe_auavscan_music_not_spotted"] = ["operation_scan_not_spotted_01", "operation_scan_not_spotted_02"];
  level.auavscanpostinitdone = 1;
}

function ref_140CF() {
  return true;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function forest_combat() {
  var_0 = getdvarfloat("scr_br_pe_auavscan_starttime_min", 60);
  var_1 = getdvarfloat("scr_br_pe_auavscan_starttime_max", 565);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function attackerswaittime() {
  level endon("game_ended");

  if(!istrue(level.auavscanpostinitdone) || !isDefined(game["dialog"]["pe_auavscan_scan_now"])) {
    var_0 = getdvarfloat("scr_br_pe_auavscan_weight", -1);

    if(var_0 < 0) {
      var_0 = "unset";
    }

    var_1 = 0;
    scripts\mp\utility\script::laststand_dogtags("auavscan being activated without dialog data, event dvar weight [" + var_0 + "], default weight [" + var_1 + "], postInitFunc ran [" + istrue(level.auavscanpostinitdone) + "]");
    return;
  }

  delayeventtominstarttime();
  level.pe_auavscan_spotted_players = [];
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_auavscan_incoming");
  scripts\mp\gametypes\br_public::brleaderdialog("pe_auavscan_announcement");
  wait 3.5;
  thread scananticipation();
}

function delayeventtominstarttime() {
  if(isDefined(level.starttimefrommatchstart)) {
    var_0 = getdvarfloat("scr_br_pe_auavscan_starttime_min", 60) * 1000 + level.starttimefrommatchstart;

    if(var_0 > gettime()) {
      var_1 = (var_0 - gettime()) / 1000;
      wait var_1;
      return;
    }

    return;
  }
}

function scananticipation() {
  level endon("game_ended");
  var_0 = getdvarfloat("scr_br_pe_auavscan_anticipation_duration", 12.5);
  var_1 = getdvarfloat("scr_br_pe_auavscan_radar_duration", 20);
  var_2 = getdvarfloat("scr_br_pe_auavscan_prone_duration", 5);
  var_3 = gettime() + var_0 * 1000;
  thread setupclocktick(var_0);
  thread scripts\mp\gametypes\br_public::brleaderdialog("pe_auavscan_scan_imminent");
  setomnvar("ui_publicevent_timer_type", 6);
  setomnvar("ui_publicevent_timer", var_3);
  setomnvar("ui_publicevent_minimap_pulse", 1);
  thread warnstandingplayers(var_0);
  thread excludeunavailableplayers(var_0);

  if(isDefined(var_0)) {
    wait var_0;
  }

  var_4 = gettime() + var_2 * 1000;
  setomnvar("ui_publicevent_timer_type", 10);
  setomnvar("ui_publicevent_timer", var_4);

  foreach(var_6 in level.players) {
    if(!istrue(isplayeravailableforevent(var_6))) {
      continue;
    }

    var_6.aliveduringauavscan = 1;
    thread radaractive();

    if(var_6 getstance() == "prone") {
      thread scanactive(var_6);
      continue;
    }

    thread spottedbyauavscan();
  }

  manageauavscanend(var_2, var_1);
}

function scanactive(var_0) {
  level endon("game_ended");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("pe_auavscan_stay_prone", self, 1, 0);
  thread playscanbink("pe_auavscan_timer", 1);
  thread watchplayerdetection(var_0);
  thread watchweaponfired(var_0);
  self setclientomnvar("ui_publicevent_auavscan_spotted", 0);
}

function radaractive() {
  level endon("game_ended");
  self playsoundtoplayer("ui_operation_scan_active_lr", self);
  setauavradar();
}

function manageauavscanend(var_0, var_1) {
  wait var_0;
  scanend();

  if(level.pe_auavscan_spotted_players.size == 0) {
    thread scripts\mp\gametypes\br_public::brleaderdialog("pe_auavscan_scan_complete");
    radarend();
    return;
  }

  wait var_1;
  thread scripts\mp\gametypes\br_public::brleaderdialog("pe_auavscan_scan_end");
  radarend();
}

function scanend() {
  level notify("public_event_auavscan_prone_phase_ended");
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  var_0 = level.players.size;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      var_0--;
      continue;
    }

    if(istrue(var_2.isexcludedfromauavscan)) {
      var_0--;
    }

    playerscanend(var_2);
  }

  branalytics_pe_auavscan(var_0, level.pe_auavscan_spotted_players.size);
}

function playerscanend() {
  if(!istrue(self.spottedbyauavscan)) {
    self notify("pe_auavscan_player_unspotted");

    if(isalive(self) && !istrue(scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) && istrue(self.aliveduringauavscan)) {
      thread scripts\mp\utility\points::giveunifiedpoints("br_pe_auavscan_unspotted");
      var_0 = game["music"]["pe_auavscan_music_not_spotted"].size;
      var_1 = randomint(var_0);
      self setplayermusicstate(game["music"]["pe_auavscan_music_not_spotted"][var_1]);
    }
  }

  if(!istrue(self.isexcludedfromauavscan) && level.pe_auavscan_spotted_players.size > 0) {
    var_2 = undefined;

    foreach(var_4 in level.pe_auavscan_spotted_players) {
      if(var_4.team != self.team) {
        var_2 = 1;
        break;
      }
    }

    if(istrue(var_2)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("pe_auavscan_enemy_exposed", self, 1, 0);
      return;
    }

    return;
  }
}

function radarend() {
  level.pe_auavscan_active = undefined;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    playerradarend(var_1);
  }
}

function playerradarend() {
  self notify("pe_auavscan_end");
  self startragdollfromvehiclehit(0);
  self setplayeradvanceduavdot(0);
  self sethidenameplate(0);
  self.spottedbyauavscan = undefined;
  self.aliveduringauavscan = undefined;
  self.isexcludedfromauavscan = undefined;
  self setclientomnvar("ui_publicevent_auavscan_spotted", 0);
  resetradar();
}

function watchplayerdetection(var_0) {
  level endon("game_ended");
  level endon("public_event_auavscan_prone_phase_ended");
  self endon("death_or_disconnect");
  self startragdollfromvehiclehit(1);
  self sethidenameplate(0);

  while(var_0 > gettime()) {
    if(self getstance() != "prone") {
      thread spottedbyauavscan();
      break;
    }

    waitframe();
  }
}

function watchweaponfired(var_0) {
  level endon("game_ended");
  level endon("public_event_auavscan_prone_phase_ended");
  self endon("pe_auavscan_player_spotted");
  self endon("death_or_disconnect");

  while(var_0 > gettime()) {
    self waittill("weapon_fired", var_1);

    if(istrue(self.spottedbyauavscan)) {
      break;
    }

    if(scripts\mp\class::vehicle_checkpiggybackexploit(var_1)) {
      continue;
    }

    self startragdollfromvehiclehit(0);
    self setplayeradvanceduavdot(1);
    wait 5;
    self setplayeradvanceduavdot(0);
    self startragdollfromvehiclehit(!istrue(self.spottedbyauavscan));
  }
}

function onplayerspawned() {
  if(istrue(level.pe_auavscan_active)) {
    excludeplayer();
    resetradar();
    self startragdollfromvehiclehit(1);
    self sethidenameplate(0);
    self setplayeradvanceduavdot(0);
    self.spottedbyauavscan = undefined;
    self.aliveduringauavscan = undefined;
    return;
  }
}

function warnstandingplayers(var_0) {
  level endon("game_ended");
  var_1 = getdvarfloat("scr_br_pe_auavscan_warning_time", 3);

  if(isDefined(var_0) && var_0 >= var_1) {
    var_2 = var_0 - var_1;
    wait var_2;

    foreach(var_4 in level.players) {
      if(!istrue(isplayeravailableforevent(var_4)) || var_4 getstance() == "prone") {
        continue;
      }

      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("pe_auavscan_scan_now", var_4, 1, 0);
    }

    return;
  }
}

function excludeunavailableplayers(var_0) {
  level endon("game_ended");
  var_1 = getdvarfloat("scr_br_pe_auavscan_exclude_respawn_threshold", 5);

  if(isDefined(var_0) && var_0 >= var_1) {
    var_2 = var_0 - var_1;
    wait var_2;
  }

  level.pe_auavscan_active = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isalive(var_4) && !var_4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      continue;
    }

    excludeplayer(var_4);
  }
}

function excludeplayer() {
  self.isexcludedfromauavscan = 1;
  self setclientomnvar("ui_publicevent_auavscan_spotted", -1);
}

function isplayeravailableforevent() {
  return isDefined(self) && isalive(self) && !scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() && !istrue(self.isexcludedfromauavscan);
}

function spottedbyauavscan() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("pe_auavscan_player_spotted");
  level.pe_auavscan_spotted_players[level.pe_auavscan_spotted_players.size] = self;
  self.spottedbyauavscan = 1;
  self setclientomnvar("ui_publicevent_auavscan_spotted", 1);
  scripts\mp\hud_message::showsplash("br_pe_auavscan_spotted");
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("pe_auavscan_spotted", self);
  self setplayeradvanceduavdot(0);
  self startragdollfromvehiclehit(0);
  self sethidenameplate(1);
  thread spottedmarkflash();
  wait 0.25;
  thread playscanbink("pe_auavscan_spotted", 1);
  var_0 = game["music"]["pe_auavscan_music_spotted"].size;
  var_1 = randomint(var_0);
  self setplayermusicstate(game["music"]["pe_auavscan_music_spotted"][var_1]);
  self playsoundtoplayer("sfx_occupation_scan_spotted_flash", self);
}

function spottedmarkflash() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!istrue(self.iszombie)) {
    self visionsetnakedforplayer("pe_auavscan_flash", 0.075);
    wait 0.1;
    scripts\mp\utility\player::restorebasevisionset(2.5);
    return;
  }
}

function playscanbink(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_br_bink_overlay_state", 14);
  level.advanceduavbinkisplaying = 1;
  thread watchdronereconuse();

  if(istrue(var_1)) {
    self stopcinematicforplayer(var_0);
  } else {
    self preloadcinematicforplayer(var_0);
  }

  scripts\engine\utility::ref_143A7("pe_auavscan_end", "pe_auavscan_player_spotted", "pe_auavscan_player_unspotted", "death_or_disconnect");
  self skydive_cutparachuteoff();
  self setclientomnvar("ui_br_bink_overlay_state", 0);
  level.advanceduavbinkisplaying = 0;
}

function watchdronereconuse() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("pe_auavscan_end");
  self endon("pe_auavscan_player_spotted");
  self endon("pe_auavscan_player_unspotted");

  while(level.advanceduavbinkisplaying) {
    var_0 = self calloutmarkerping_entityzoffset("ui_rcd_controls") > 0;

    if(!var_0) {
      var_1 = 0;

      while(var_1 == 0) {
        self waittill("omnvar_ui_rcd_changed", var_1);
      }
    }

    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self waittillmatch("omnvar_ui_rcd_changed", 0);

    if(istrue(level.advanceduavbinkisplaying)) {
      self setclientomnvar("ui_br_bink_overlay_state", 14);
    }
  }
}

function setauavradar() {
  var_0 = level.ref_13ED9;
  var_1 = "constant_radar";
  var_2 = 1;
  var_3 = 1;
  attackerregenammo(var_1, var_0, var_2, var_3);
  self.hasradar = 1;
}

function resetradar() {
  var_0 = 1;
  var_1 = "normal_radar";
  var_2 = 0;
  var_3 = undefined;
  attackerregenammo(var_1, var_0, var_2, var_3);
  self.hasradar = 0;
}

function attackerregenammo(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  level.radarmode[self.guid] = var_0;
  self.radarstrength = var_4;
  level.activeuavs[self.guid + "_radarStrength"] = var_4;
  level.activeadvanceduavs[self.guid] = var_2;
  self.ref_133E9 = var_3;
  level.audio_heli_end_fade_out = level.teamnamelist.size;
  scripts\cp_mp\killstreaks\uav::updateplayersuavstatus();
}

function setupclocktick(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 13) {
    wait var_0 - 13;
  }

  var_1 playSound("sfx_occupation_pre_scan_timer");
  wait 13;
  var_1 delete();
}

function branalytics_pe_auavscan(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = "available_players_count";
  var_2[var_2.size] = var_0;
  var_2[var_2.size] = "spotted_players_count";
  var_2[var_2.size] = var_1;
  getentitylessscriptablearray("dlog_event_br_pe_auavscan", var_2);
}