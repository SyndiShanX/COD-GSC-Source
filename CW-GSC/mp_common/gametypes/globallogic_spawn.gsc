/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_spawn.gsc
*****************************************************/

#using script_44b0b8420eabacad;
#using script_67ce8e728d8f37ba;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#namespace globallogic_spawn;

function private autoexec __init__system__() {
  system::register(#"globallogic_spawn", &preinit, undefined, undefined, #"gamestate");
}

function private preinit() {
  level.var_b3c4b7b7 = getgametypesetting(#"hash_4bf99a809542e4ea");
  level.spawnsystem.var_3709dc53 = 0;
  level.var_1113eb30 = &mayspawn;
  spawning::add_default_spawnlist("auto_normal");
  callback::add_callback(#"on_end_game", &on_end_game);
  level thread function_621bbb3();
}

function getspawnentitytypes() {
  return level.spawnentitytypes;
}

function getmpspawnpoints() {
  return level.allspawnpoints;
}

function timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && is_false(self.hasspawned)) {
    return 0;
  }

  respawndelay = 0;
  var_c04d33cd = isDefined(self.var_c04d33cd) ? self.var_c04d33cd : 0;
  self.var_c04d33cd = undefined;

  if(is_true(self.hasspawned)) {
    var_28f1fc71 = squad_spawn::function_fd0f3019(self);

    if(var_28f1fc71) {
      if(is_true(self.var_20250438)) {
        return 0;
      }

      if(squad_spawn::function_d072f205()) {
        if(self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe")) {
          return var_28f1fc71;
        }
      }
    }

    result = self[[level.onrespawndelay]]();

    if(isDefined(result)) {
      respawndelay = result;
      var_c04d33cd = 1;
    } else {
      respawndelay = level.playerrespawndelay;
    }

    if(isDefined(level.playerincrementalrespawndelay) && isDefined(self.pers[#"spawns"])) {
      respawndelay += level.playerincrementalrespawndelay * self.pers[#"spawns"];
    }

    if(is_true(self.suicide) && level.suicidespawndelay > 0) {
      respawndelay += level.suicidespawndelay;
    }

    if(is_true(self.teamkilled) && level.teamkilledspawndelay > 0) {
      respawndelay += level.teamkilledspawndelay;
    }

    if(includeteamkilldelay && is_true(self.teamkillpunish)) {
      respawndelay += player::function_821200bb();
    }
  }

  if(is_true(level.spawnsystem.deathcirclerespawn)) {
    return self function_ac5b273c(respawndelay);
  }

  wavebased = level.waverespawndelay > 0;

  if(wavebased && !var_c04d33cd) {
    return self timeuntilwavespawn(respawndelay);
  }

  if(is_true(self.usedresurrect)) {
    return 0;
  }

  return respawndelay;
}

function allteamshaveexisted() {
  foreach(team, _ in level.teams) {
    if(!teams::function_9dd75dad(team)) {
      return false;
    }

    if(level.everexisted[team] > gettime() + 1000) {
      return false;
    }
  }

  return true;
}

function function_c6cf4045() {
  if(level.teambased && level.teamcount <= 2) {
    gamehasstarted = allteamshaveexisted();
  } else {
    gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
  }

  if(gamehasstarted && is_true(level.var_60507c71)) {
    if(!level.ingraceperiod && !self.hasspawned) {
      return false;
    }
  }

  return true;
}

function function_31f04670(team) {
  alive_players = function_a1ef346b(team);

  foreach(player in alive_players) {
    if(player laststand::player_is_in_laststand()) {
      continue;
    }

    return true;
  }

  return false;
}

function mayspawn() {
  if(isDefined(level.mayspawn) && !self[[level.mayspawn]]()) {
    return false;
  }

  if(level.playerqueuedrespawn && !isDefined(self.allowqueuespawn) && !level.ingraceperiod && !spawning::usestartspawns()) {
    return false;
  }

  if(game.state == # "playing" && level.spawnsystem.var_c2cc011f && !function_31f04670(self.team)) {
    return false;
  }

  if(isDefined(level.var_75db41a7) && gettime() >= level.var_75db41a7) {
    return false;
  }

  if(is_true(level.var_5c49de55) && game.var_794ec97[self.team]) {
    return false;
  }

  return globallogic_player::function_38527849() && function_c6cf4045();
}

function function_ac5b273c(minimumwait) {
  earliestspawntime = gettime() + int(minimumwait * 1000);

  if(!isDefined(level.deathcircle.var_d60fd7cd)) {
    return 0;
  }

  return max(float(level.deathcircle.var_d60fd7cd - gettime()) / 1000, 0);
}

function timeuntilwavespawn(minimumwait) {
  earliestspawntime = gettime() + int(minimumwait * 1000);
  lastwavetime = level.lastwave[self.pers[#"team"]];
  wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);

  if(wavedelay == 0) {
    return 0;
  }

  var_a0122c26 = 50;
  var_e0fb0ad5 = var_a0122c26 * (isDefined(self.wavespawnindex) ? self.wavespawnindex : 0);
  elapsed = max(0, earliestspawntime - lastwavetime - var_e0fb0ad5);
  numwavespassedearliestspawntime = elapsed / wavedelay;
  numwaves = ceil(numwavespassedearliestspawntime);
  timeofspawn = lastwavetime + numwaves * wavedelay;

  if(isDefined(self.wavespawnindex)) {
    timeofspawn += var_e0fb0ad5;
  }

  return float(timeofspawn - gettime()) / 1000;
}

function stoppoisoningandflareonspawn() {
  self endon(#"disconnect");
  self.inpoisonarea = 0;
  self.inburnarea = 0;
  self.inflarevisionarea = 0;
  self.ingroundnapalm = 0;
}

function spawnplayerprediction() {
  self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
  plrs = teams::count_players();

  if(is_true(level.var_153e7dad)) {
    return;
  }

  nolivesleft = level.numlives && !self.pers[#"lives"] || level.numteamlives && game.lives[self.team] > 0;

  if(nolivesleft) {
    return;
  }

  while(true) {
    wait 0.5;
    spawning::onspawnplayer(1);
  }
}

function playmatchstartaudio(team) {
  self endon(#"disconnect");

  for(index = 0; index < 5; index++) {
    waitframe(1);
  }

  if(self.pers[#"playedgamemode"] !== 1) {
    if(level.hardcoremode) {
      if(globallogic_utils::function_308e3379()) {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_d04b3734);
      } else {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
      }
    } else if(globallogic_utils::function_308e3379()) {
      self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_f6fda321);
    } else {
      self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
    }

    self.pers[#"playedgamemode"] = 1;
  }

  if(isDefined(self.var_7c7626bc)) {
    self globallogic_audio::leader_dialog_on_player(self.var_7c7626bc, undefined, undefined, undefined, undefined, undefined, undefined, level.var_db91e97c);
    return;
  }

  if(team == game.attackers) {
    self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog, undefined, undefined, undefined, undefined, undefined, undefined, level.var_db91e97c);
    return;
  }

  self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog, undefined, undefined, undefined, undefined, undefined, undefined, level.var_db91e97c);
}

function doinitialspawnmessaging(params) {
  pixbeginevent(#"");

  if(sessionmodeismultiplayergame() && !is_true(self.var_b279086a)) {
    self show();
    self solid();
  }

  if(level.gametype !== "bounty") {
    if(isDefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
      self.pers[#"music"].spawn = 1;
    }
  }

  if(level.splitscreen) {
    if(isDefined(level.playedstartingmusic)) {
      music = undefined;
    } else {
      level.playedstartingmusic = 1;
    }
  }

  self.playleaderdialog = 1;

  if(isDefined(level.leaderdialog)) {
    self thread playmatchstartaudio(self.pers[#"team"]);
  }

  pixendevent();
}

function resetattackersthisspawnlist() {
  self.attackersthisspawn = [];
}

function function_baf09253() {
  if(getdvarint(#"hash_2df1db0190af3691", 0)) {
    self thread spawnplayer();
    return;
  }

  level.spawn_manager.queue[self getentitynumber()] = {
    #player: self, #time: gettime()
  };
  level notify(#"hash_45860a1cc533c675");
}

function private function_b8c4b717() {
  oldest_time = 2147483647;
  var_a9719654 = undefined;

  foreach(var_3d914b8d in level.spawn_manager.queue) {
    if(!isDefined(var_3d914b8d)) {
      continue;
    }

    if(var_3d914b8d.time < oldest_time) {
      oldest_time = var_3d914b8d.time;
      var_a9719654 = var_3d914b8d;
    }
  }

  return var_a9719654;
}

function function_621bbb3() {
  if(!isDefined(level.spawn_manager)) {
    level.spawn_manager = {
      #queue: []
    };
  }

  level.spawn_manager.var_a6e3d71 = 0;
  var_fc6b3d59 = getdvarint(#"hash_1d65ee43ab40a691", 1);
  var_75b515ff = getdvarfloat(#"hash_117d09abf84fb041", float(16) / 1000);

  while(true) {
    if(gamestate::is_game_over()) {
      return;
    }

    currenttime = gettime();

    if(level.spawn_manager.queue.size > 0 && level.spawn_manager.var_a6e3d71 != currenttime) {
      for(var_f16b79a = 0; var_f16b79a < var_fc6b3d59; var_f16b79a++) {
        var_dcdb5d9f = function_b8c4b717();

        if(!isDefined(var_dcdb5d9f)) {
          break;
        }

        arrayremovevalue(level.spawn_manager.queue, var_dcdb5d9f, 1);
        player = var_dcdb5d9f.player;

        if(!isDefined(player)) {
          continue;
        }

        player thread spawnplayer();
        level.spawn_manager.var_a6e3d71 = currenttime;
      }
    }

    level waittilltimeout(var_75b515ff, #"hash_45860a1cc533c675");
  }
}

function spawnplayer() {
  if(getdvarint(#"hash_538d8545b881ef93") > 0) {
    setDvar(#"r_jqprof_capture", 1);
    waitframe(1);
  }

  pixbeginevent(#"");
  self endon(#"disconnect", #"joined_spectators");
  hadspawned = self.hasspawned;
  self player::spawn_player();

  if(globallogic_utils::getroundstartdelay()) {
    self thread globallogic_utils::applyroundstartdelay();
  }

  if(isDefined(self.spawnlightarmor) && self.spawnlightarmor > 0) {
    self thread armor::setlightarmor(self.spawnlightarmor);
  }

  self.nextkillstreakfree = undefined;
  self.deathmachinekills = 0;
  self.var_6fd69072 = undefined;
  self.var_8cb03411 = undefined;
  self.var_93866180 = [];
  self resetattackersthisspawnlist();
  self.diedonvehicle = undefined;

  if(is_false(self.wasaliveatmatchstart)) {
    if(level.ingraceperiod || globallogic_utils::gettimepassed() < int(20 * 1000)) {
      self.wasaliveatmatchstart = 1;
    }
  }

  pixbeginevent(#"");
  self[[level.onspawnplayer]](0);

  if(isDefined(level.playerspawnedcb)) {
    self[[level.playerspawnedcb]]();
  }

  pixendevent();
  pixendevent();
  level thread globallogic::updateteamstatus();
  pixbeginevent(#"");
  self val::nuke("disable_oob");
  self thread stoppoisoningandflareonspawn();
  self.sensorgrenadedata = undefined;
  self.var_342564dd = 0;
  self.var_6a9b15ba = undefined;
  self.var_ec59e88c = undefined;
  self.spawn.var_e8f87696 = undefined;

  if(level.var_b3c4b7b7 === 1) {
    self player_role::clear();
    draft::assign_remaining_players(self);
  }

  role = self player_role::get();
  assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
  assert(player_role::is_valid(role));
  self.pers[#"momentum_at_spawn_or_game_end"] = isDefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;

  if(loadout::function_87bcb1b()) {
    self loadout::function_53b62db1(self.curclass);
  }

  var_e0f216b9 = 1;
  self loadout::give_loadout(self.team, self.curclass, var_e0f216b9);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    specialist = function_b14806c6(role, currentsessionmode());

    if(isDefined(specialist)) {
      self function_6c3348ac(specialist);
    }

    var_be574bd8 = self getcharacterlootid();
    outfitindex = self getcharacteroutfit();
    gender = self getplayergendertype();
    warpaintoutfitindex = self getcharacterwarpaintoutfit();
    var_8fa79650 = self getcharacterwarpaintlootid();
    decallootid = self getcharacterdecallootid();
    var_b3d9cfaa = self function_11d0e790();
    var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

    if(isDefined(var_f8e6b703)) {
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_gender", gender);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_decal_lootid", decallootid);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit_lootid", var_be574bd8);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_lootid", var_8fa79650);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit", outfitindex);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_outfit", warpaintoutfitindex);

      for(i = 0; i < var_b3d9cfaa.size; i++) {
        self match_record::set_stat(#"lives", var_f8e6b703, #"hash_20d6751cb2f9ca09", i, var_b3d9cfaa[i]);
      }
    }
  }

  pixendevent();

  if(is_true(getgametypesetting(#"hash_2966662989c3484c")) && !is_true(level.var_427d6976.var_beb2cb1b)) {
    self function_8a945c0e(1);
    self function_8b8a321a(1);
  }

  self squad_spawn::spawn_player();
  pixbeginevent(#"");

  if(gamestate::is_state(#"pregame")) {
    player::function_a074b96f(1);

    if(sessionmodeismultiplayergame() && !is_true(level.var_b82a5c35)) {
      self notsolid();
    }

    self callback::on_prematch_end(&doinitialspawnmessaging);
  } else {
    player::function_a074b96f(0);
    self enableweapons();

    if(!is_true(hadspawned) && gamestate::is_state(#"playing")) {
      self thread doinitialspawnmessaging();
    }
  }

  if(is_true(level.scoreresetondeath)) {
    self globallogic_score::resetplayermomentumonspawn();
  } else {
    self globallogic_score::function_1ceb2820();
  }

  self.deathtime = 0;
  self.pers[#"deathtime"] = 0;

  if(self hasperk(#"specialty_anteup")) {
    anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);

    if(self.pers[#"momentum_at_spawn_or_game_end"] < anteup_bonus) {
      globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
    }
  }

  if(!isDefined(getDvar(#"scr_showperksonspawn"))) {
    setDvar(#"scr_showperksonspawn", 0);
  }

  if(level.hardcoremode) {
    setDvar(#"scr_showperksonspawn", 0);
  }

  if(getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over()) {
    pixbeginevent(#"");

    if(level.perksenabled == 1) {
      self hud::showperks();
    }

    pixendevent();
  }

  if(isDefined(self.pers[#"momentum"])) {
    self.momentum = self.pers[#"momentum"];
  }

  self setsprintboost(0);
  pixendevent();
  waittillframeend();
  self notify(#"spawned_player");
  callback::callback(#"on_player_spawned");
  self thread player_monitor::monitor();

  print("<dev string:x38>" + self.origin[0] + "<dev string:x3e>" + self.origin[1] + "<dev string:x3e>" + self.origin[2] + "<dev string:x43>");

  setDvar(#"scr_selecting_location", "");

  if(gamestate::is_game_over()) {
    assert(!level.intermission);
    self player::freeze_player_for_round_end();
  }

  self util::set_lighting_state();
}

function on_end_game() {
  self.pers[#"momentum_at_spawn_or_game_end"] = isDefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
}

function spawnspectator(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  in_spawnspectator(origin, angles);
}

function respawn_asspectator(origin, angles) {
  in_spawnspectator(origin, angles);
}

function function_3ee5119e() {
  if(spawning::function_29b859d1()) {
    return;
  }

  if(self.pers[#"team"] != # "spectator" && level.spectatetype == 5 && self.var_ba35b2d2 == # "invalid") {
    spectating::set_permissions();
    var_74578e76 = function_c65231e2(self.squad);
    player = spectating::function_327e6270(var_74578e76, &spectating::function_44d43a69, #"invalid");
    assert(isDefined(player));
    self.var_ba35b2d2 = player.squad;
  }

  if(self.pers[#"team"] != # "spectator" && level.spectatetype == 4 && self.spectatorteam == # "invalid") {
    spectating::set_permissions();
    team_players = getplayers(self.team);
    player = spectating::function_327e6270(team_players, &spectating::spectator_team, #"invalid");
    assert(isDefined(player));

    if(is_true(level.var_db91e97c)) {
      player = spectating::function_836ee9ed(player);
    }

    if(isDefined(player.team)) {
      self.spectatorteam = player.team;
    }
  }
}

function private function_9ead6959() {
  if(self.pers[#"team"] == # "spectator") {
    return true;
  }

  if(level.spectatetype != 5 || level.spectatetype != 4) {
    return true;
  }

  return false;
}

function in_spawnspectator(origin, angles) {
  pixmarker("BEGIN: in_spawnSpectator");
  self player::set_spawn_variables();
  self.sessionstate = "spectator";
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;

  if(self.pers[#"team"] == # "spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }

  if(function_9ead6959()) {
    self.spectatorclient = -1;
    spectating::set_permissions_for_machine();
  }

  function_3ee5119e();
  [[level.onspawnspectator]](origin, angles);
  level thread globallogic::updateteamstatus();
  pixmarker("END: in_spawnSpectator");
}

function forcespawn(time) {
  self endon(#"death", #"disconnect", #"spawned");

  if(!isDefined(time)) {
    time = 60;
  }

  wait time;

  if(is_true(self.hasspawned)) {
    return;
  }

  if(self.pers[#"team"] == # "spectator") {
    return;
  }

  if(!globallogic_utils::isvalidclass(self.pers[#"class"])) {
    self.pers[#"class"] = "CLASS_CUSTOM1";
    self.curclass = self.pers[#"class"];
  }

  if(!self function_8b1a219a()) {
    self globallogic_ui::closemenus();
  }

  self thread[[level.spawnclient]]();
}

function kickifdontspawn() {
  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

  if(self ishost()) {
    return;
  }

  self kickifidontspawninternal();
}

function kickifidontspawninternal() {
  self endon(#"death", #"disconnect", #"spawned");

  while(true) {
    if(!is_true(level.inprematchperiod) && self isstreamerready()) {
      break;
    }

    wait 5;
  }

  waittime = 90;

  if(getdvarstring(#"scr_kick_time") != "") {
    waittime = getdvarfloat(#"scr_kick_time", 0);
  }

  mintime = 45;

  if(getdvarstring(#"scr_kick_mintime") != "") {
    mintime = getdvarfloat(#"scr_kick_mintime", 0);
  }

  starttime = gettime();
  kickwait(waittime);
  timepassed = float(gettime() - starttime) / 1000;

  if(timepassed < waittime - 0.1 && timepassed < mintime) {
    return;
  }

  if(is_true(self.hasspawned)) {
    return;
  }

  if(sessionmodeisprivate()) {
    return;
  }

  if(self.pers[#"team"] == # "spectator") {
    return;
  }

  if(!mayspawn() && self.pers[#"time_played_total"] > 0) {
    return;
  }

  globallogic::gamehistoryplayerkicked();
  kick(self getentitynumber(), "EXE/PLAYERKICKED_NOTSPAWNED");
}

function kickwait(waittime) {
  level endon(#"game_ended");
  hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

function spawninterroundintermission() {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;
  self ghost();
  self globallogic_defaults::default_onspawnintermission();
  self setorigin(self.origin);
  self setplayerangles(self.angles);
  self clientfield::set_to_player("player_dof_settings", 2);
}

function spawnintermission(usedefaultcallback, endgame) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;
  self ghost();

  if(isDefined(usedefaultcallback) && usedefaultcallback) {
    globallogic_defaults::default_onspawnintermission();
  } else {
    [[level.onspawnintermission]](endgame);
  }

  self clientfield::set_to_player("player_dof_settings", 2);
}

function function_886521e2(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;
  self spawn(origin, angles);
  self clientfield::set_to_player("player_dof_settings", 2);
}

function spawnqueuedclientonteam(team) {
  player_to_spawn = undefined;

  for(i = 0; i < level.deadplayers[team].size; i++) {
    player = level.deadplayers[team][i];

    if(player.waitingtospawn) {
      continue;
    }

    player_to_spawn = player;
    break;
  }

  if(isDefined(player_to_spawn)) {
    player_to_spawn.allowqueuespawn = 1;
    player_to_spawn globallogic_ui::closemenus();
    player_to_spawn thread[[level.spawnclient]]();
  }
}

function spawnqueuedclient(dead_player_team, killer) {
  if(!level.playerqueuedrespawn) {
    return;
  }

  util::waittillslowprocessallowed();
  spawn_team = undefined;

  if(isDefined(killer) && isDefined(killer.team) && isDefined(level.teams[killer.team])) {
    spawn_team = killer.team;
  }

  if(isDefined(spawn_team)) {
    spawnqueuedclientonteam(spawn_team);
    return;
  }

  foreach(team, _ in level.teams) {
    if(team == dead_player_team) {
      continue;
    }

    spawnqueuedclientonteam(team);
  }
}

function allteamsnearscorelimit() {
  if(!level.teambased) {
    return false;
  }

  if(level.scorelimit <= 1) {
    return false;
  }

  foreach(team, _ in level.teams) {
    if(!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
      return false;
    }
  }

  return true;
}

function shouldshowrespawnmessage() {
  if(util::waslastround()) {
    return false;
  }

  if(util::isoneround()) {
    return false;
  }

  if(isDefined(level.livesdonotreset) && level.livesdonotreset) {
    return false;
  }

  if(allteamsnearscorelimit()) {
    return false;
  }

  return true;
}

function default_spawnmessage() {
  if(util::getroundsplayed() + 1 < level.roundlimit) {
    hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
  }
}

function showspawnmessage() {
  if(shouldshowrespawnmessage()) {
    self thread[[level.spawnmessage]]();
  }
}

function spawnclient(timealreadypassed) {
  pixbeginevent(#"");
  assert(isDefined(self.team));
  assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));

  if(!self mayspawn() && !is_true(self.usedresurrect)) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self showspawnmessage();
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    pixendevent();
    return;
  }

  if(is_true(self.waitingtospawn)) {
    pixendevent();
    return;
  }

  self.waitingtospawn = 1;
  self.allowqueuespawn = undefined;

  if(!is_true(level.takelivesondeath)) {
    game.lives[self.team]--;
  }

  pixendevent();
  self waitandspawnclient(timealreadypassed);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }
}

function function_1a12c7a1(timeuntilspawn) {
  self endon(#"force_spawn", #"hash_33713849648e651d");
  var_9037cf6c = 0;

  while(var_9037cf6c < timeuntilspawn) {
    util::function_9d5c26a();
    waitframe(1);
    var_9037cf6c += float(function_60d95f53()) / 1000;
  }
}

function waitandspawnclient(timealreadypassed) {
  self endon(#"disconnect", #"end_respawn");
  level endon(#"game_ended");

  if(util::isfirstround()) {
    self namespace_66d6aa44::function_a8f822ee();

    while(self isplayinganimscripted()) {
      waitframe(1);
    }
  } else {
    self namespace_66d6aa44::function_684bad0f();
  }

  spawnedasspectator = 0;
  userespawntime = isDefined(timealreadypassed) ? 1 : 0;

  if(squad_spawn::function_d072f205()) {
    thread squad_spawn::function_5f24fd47(self, userespawntime);
    self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    spawnedasspectator = 1;
  }

  if(!isDefined(timealreadypassed)) {
    timealreadypassed = 0;
  }

  if(is_true(self.teamkillpunish)) {
    var_821200bb = player::function_821200bb();

    if(var_821200bb > timealreadypassed) {
      var_821200bb -= timealreadypassed;
    } else {
      var_821200bb = 0;
    }

    if(var_821200bb > 0) {
      hud_message::setlowermessage(#"mp/friendly_fire_will_not", var_821200bb);
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      spawnedasspectator = 1;
      wait var_821200bb;
    }

    self.teamkillpunish = 0;
  }

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  timeuntilspawn = timeuntilspawn(0);

  if(timeuntilspawn > timealreadypassed) {
    timeuntilspawn -= timealreadypassed;
  } else {
    timeuntilspawn = 0;
  }

  if(level.basegametype == "koth") {
    util::function_5355d311();
  }

  if(timeuntilspawn > 0) {
    var_3ffa560b = squad_spawn::function_d072f205() && self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe");

    if(!var_3ffa560b) {
      if(level.playerqueuedrespawn) {
        hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
      } else if(level.gametype != "fireteam_elimination") {
        hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
      }
    }

    if(!spawnedasspectator) {
      spawnorigin = self.origin + (0, 0, 60);
      spawnangles = self.angles;

      if(isDefined(level.useintermissionpointsonwavespawn) && [[level.useintermissionpointsonwavespawn]]() == 1) {
        spawnpoint = spawning::get_random_intermission_point();

        if(isDefined(spawnpoint)) {
          spawnorigin = spawnpoint.origin;
          spawnangles = spawnpoint.angles;
        }
      }

      self thread respawn_asspectator(spawnorigin, spawnangles);
    }

    spawnedasspectator = 1;
    self notify(#"waitingtospawn", {
      #timeuntilspawn: timeuntilspawn
    });

    while(true) {
      waitstarttime = gettime();

      if(level.basegametype == "koth" && util::function_7f7a77ab()) {
        self function_1a12c7a1(timeuntilspawn);
      } else {
        self waittilltimeout(timeuntilspawn, #"force_spawn", #"hash_33713849648e651d");
      }

      timealreadypassed = float(gettime() - waitstarttime) / 1000 + timealreadypassed;

      if(timealreadypassed >= timeuntilspawn) {
        self.var_c04d33cd = 1;
      }

      var_3ffa560b = squad_spawn::function_d072f205() && self clientfield::get_player_uimodel("hudItems.squadSpawnSquadWipe");
      var_239ada2f = timeuntilspawn(0);

      if(!var_3ffa560b) {
        if(var_239ada2f > timealreadypassed) {
          var_239ada2f -= timealreadypassed;
        } else {
          var_239ada2f = 0;
        }
      }

      if(var_239ada2f <= 0) {
        break;
      }

      timeuntilspawn = var_239ada2f;

      if(!var_3ffa560b) {
        if(level.playerqueuedrespawn) {
          hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
        } else {
          hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
        }

        continue;
      }

      hud_message::clearlowermessage();
    }

    self notify(#"stop_wait_safe_spawn_button");
  } else {
    self notify(#"hash_4651029f46118bc1");
  }

  if(function_b142f8d4()) {
    if(squad_spawn::function_d072f205()) {
      self clientfield::set_player_uimodel("hudItems.squadSpawnRespawnStatus", 1);
      hud_message::clearlowermessage();
      self squad_spawn::function_6a7e8977();
    } else {
      hud_message::setlowermessage(game.strings[#"press_to_spawn"]);
    }

    if(!spawnedasspectator) {
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;
    self waitrespawnorsafespawnbutton();
  }

  self.waitingtospawn = 0;

  if(!squad_spawn::function_d072f205()) {
    self hud_message::clearlowermessage();
  }

  self.wavespawnindex = undefined;
  self.respawntimerstarttime = undefined;
  self.pers[#"spawns"]++;
  self thread[[level.spawnplayer]]();
}

function private function_b142f8d4() {
  if(level.playerforcerespawn) {
    return false;
  }

  if(!self.hasspawned) {
    return false;
  }

  wavebased = level.waverespawndelay > 0;

  if(wavebased && !(isDefined(getgametypesetting(#"hash_2b1f40bc711c41f3")) ? getgametypesetting(#"hash_2b1f40bc711c41f3") : 0)) {
    return false;
  }

  if(self.wantsafespawn) {
    return false;
  }

  if(level.playerqueuedrespawn) {
    return false;
  }

  return true;
}

function waitrespawnorsafespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    if(squad_spawn::function_d072f205()) {
      if(self squad_spawn::function_2ffd5f18()) {
        break;
      }
    } else if(!is_true(self.var_20250438)) {
      if(self useButtonPressed()) {
        break;
      }
    }

    waitframe(1);
  }
}