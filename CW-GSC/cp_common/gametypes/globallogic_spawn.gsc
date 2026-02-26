/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_spawn.gsc
*****************************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_defaults;
#using scripts\cp_common\gametypes\globallogic_player;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\gametypes\loadout;
#using scripts\cp_common\gametypes\save;
#using scripts\killstreaks\killstreaks_shared;
#namespace globallogic_spawn;

function timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && !self.hasspawned) {
    return 0;
  }

  respawndelay = 0;

  if(is_true(self.hasspawned)) {
    result = self[[level.onrespawndelay]]();

    if(isDefined(result)) {
      respawndelay = result;
    } else if(is_true(self.diedonvehicle) && isDefined(level.var_cf393bff)) {
      self.var_84c0402e = undefined;
      self.bleedout_time = undefined;
      respawndelay = level.var_cf393bff;
    } else if(isDefined(level.var_a4107aed)) {
      respawndelay = level.var_a4107aed;
    } else if(self.team === # "allies" && isDefined(level.var_6e5e9604)) {
      respawndelay = level.var_6e5e9604;
    } else if(self.team === # "axis" && isDefined(level.var_c260c3bd)) {
      respawndelay = level.var_c260c3bd;
    } else {
      respawndelay = level.playerrespawndelay;
    }

    if(isDefined(self.lastspawntime) && isDefined(level.var_1cac200a) && gettime() - self.var_88f8dfe3 <= level.var_1cac200a * 1000) {
      if(!isDefined(self.var_4999cc5d)) {
        self.var_4999cc5d = 0;
      } else {
        self.var_4999cc5d += 1;
      }
    } else {
      self.var_4999cc5d = 0;
    }

    if(isPlayer(self) && !isbot(self) && isDefined(level.var_a164210a)) {
      var_7415756f = level.var_a164210a * self.var_4999cc5d;
      respawndelay += var_7415756f;

      if(isDefined(level.var_a6a26da0) && respawndelay > level.var_a6a26da0) {
        respawndelay = level.var_a6a26da0;
      }

      if(var_7415756f > 0) {
        var_1581b0a8 = isDefined(var_7415756f) ? "" + var_7415756f : "";

        debug2dtext((900, 500, 0), var_1581b0a8 + "<dev string:x38>", (1, 1, 1), 1, (0, 0, 0), 0.5, 1, 80);
      }
    }

    if(is_true(self.suicide) && level.suicidespawndelay > 0) {
      respawndelay += level.suicidespawndelay;
    }

    if(is_true(self.teamkilled) && level.teamkilledspawndelay > 0) {
      respawndelay += level.teamkilledspawndelay;
    }

    if(includeteamkilldelay && is_true(self.teamkillpunish)) {
      respawndelay += globallogic_player::teamkilldelay();
    }

    if(isDefined(self.bleedout_time) && isDefined(self.var_84c0402e)) {
      assert(self.bleedout_time >= 0);
      assert(self.bleedout_time <= self.var_84c0402e);
      respawndelay -= self.var_84c0402e - self.bleedout_time;
    }
  }

  wavebased = level.waverespawndelay > 0;

  if(wavebased) {
    return self timeuntilwavespawn(respawndelay);
  }

  return respawndelay;
}

function allteamshaveexisted() {
  foreach(team, _ in level.teams) {
    if(!level.everexisted[team]) {
      return false;
    }
  }

  return true;
}

function mayspawn() {
  if(isDefined(level.playermayspawn) && !self[[level.playermayspawn]]()) {
    return false;
  }

  if(level.inovertime) {
    return false;
  }

  if(level.playerqueuedrespawn && !isDefined(self.allowqueuespawn) && !level.ingraceperiod && !spawning::usestartspawns()) {
    return false;
  }

  if(is_true(self.var_f68bc076)) {
    return false;
  }

  if(level.numlives) {
    if(level.teambased) {
      gamehasstarted = allteamshaveexisted();
    } else {
      gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
    }

    if(!self.pers[#"lives"]) {
      return false;
    } else if(gamehasstarted) {
      if(!level.ingraceperiod && !self.hasspawned) {
        return false;
      }
    }
  }

  return true;
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
  self.inpoisonarea = 0;
  self.inburnarea = 0;
  self.inflarevisionarea = 0;
  self.ingroundnapalm = 0;
}

function spawnplayerprediction() {
  self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");

  while(true) {
    wait 0.5;
    self[[level.onspawnplayer]](1);
  }
}

function spawnplayer() {
  pixbeginevent(#"");
  self endon(#"disconnect", #"joined_spectators");
  hadspawned = self.hasspawned;
  self player::spawn_player();
  self setcharacterbodytype(0);
  self setcharacteroutfit(0);
  self hud_message::clearlowermessage();
  self.nextkillstreakfree = undefined;
  self.activeuavs = 0;
  self.activecounteruavs = 0;
  self.activesatellites = 0;
  self.deathmachinekills = 0;
  self.diedonvehicle = undefined;
  self.disable_score_events = 1;

  if(is_false(self.wasaliveatmatchstart)) {
    if(level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
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
  globallogic::updateteamstatus();
  self stoppoisoningandflareonspawn();
  self.sensorgrenadedata = undefined;

  if(!isDefined(self.curclass)) {
    waitframe(1);
  }

  pixbeginevent(#"");
  assert(globallogic_utils::isvalidclass(self.curclass) || isbot(self));
  self loadout::setclass(self.curclass);
  var_db3f2906 = self savegame::function_2ee66e93("altPlayerID", undefined);
  var_d4a479a1 = undefined;

  if(isDefined(var_db3f2906)) {
    foreach(var_88ad84f4 in level.players) {
      if(var_88ad84f4 getxuid() === var_db3f2906) {
        var_d4a479a1 = var_88ad84f4;
        break;
      }
    }

    if(!isDefined(var_d4a479a1)) {
      self savegame::set_player_data("altPlayerID", undefined);
    }
  }

  self thread loadout::giveloadout(self.team, self.curclass, var_d4a479a1);

  if(is_true(self.var_c071a13e)) {
    self.var_c071a13e = undefined;
  } else {
    self lui::screen_close_menu();
  }

  if(level.inprematchperiod) {
    self val::set(#"prematch", "ignoreme", 1);
    team = self.pers[#"team"];
  } else {
    self val::reset(#"prematch", "freezecontrols");
    self enableweapons();

    if(!hadspawned && game.state == "playing") {
      team = self.team;
    }
  }

  self val::reset(#"roundend", "freezecontrols");
  self val::reset(#"suicide", "freezecontrols");

  if(!isDefined(getDvar(#"scr_showperksonspawn"))) {
    setDvar(#"scr_showperksonspawn", 0);
  }

  if(level.hardcoremode) {
    setDvar(#"scr_showperksonspawn", 0);
  }

  if(getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "<dev string:x6b>") {
    pixbeginevent(#"");

    if(level.perksenabled == 1) {
      self hud::showperks();
    }

    pixendevent();
  }

  if(isDefined(self.pers[#"momentum"])) {
    self.momentum = self.pers[#"momentum"];
  }

  pixendevent();
  self setnosunshadow();
  waitframe(1);
  self notify(#"spawned_player");

  if(!getdvarint(#"art_review", 0)) {
    self.var_913d3fca = 0;
    self.last_damaged_time = 0;
    self.var_63a30c1 = 0;
    self.var_7e008e0c = 0;
    callback::callback(#"on_player_spawned");

    if(isDefined(self.var_f8271fa3)) {
      self.var_f8271fa3 delete();
      self.var_f8271fa3 = undefined;
    }
  }

  print("<dev string:x8b>" + self.origin[0] + "<dev string:x91>" + self.origin[1] + "<dev string:x91>" + self.origin[2] + "<dev string:x96>");

  setDvar(#"scr_selecting_location", "");
  self thread function_e3b1cd54();
  self util::set_lighting_state();
  self util::set_sun_shadow_split_distance();
  self.firstspawn = 0;
  self.var_88f8dfe3 = gettime();
  self thread util::cleanup_fancycam();
}

function function_e3b1cd54() {
  self notify(#"hash_587f51dc5f621d5d");
  self endon(#"hash_587f51dc5f621d5d", #"disconnect");

  while(true) {
    waitresult = self waittill(#"vehicle_death");

    if(waitresult.vehicle_died) {
      self.diedonvehicle = 1;
      continue;
    }

    self.var_e961196c = 1;
  }
}

function spawnspectator(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self notify(#"spawned_spectator");
  in_spawnspectator(origin, angles);
}

function respawn_asspectator(origin, angles) {
  in_spawnspectator(origin, angles);

  if(isPlayer(self) && !isbot(self) && level.gametype === "pvp") {}
}

function in_spawnspectator(origin, angles) {
  pixmarker("BEGIN: in_spawnSpectator");
  self player::set_spawn_variables();
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  if(self.pers[#"team"] == "spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }

  spectating::set_permissions_for_machine();
  [[level.onspawnspectator]](origin, angles);

  if(level.teambased && !level.splitscreen) {
    self thread spectatorthirdpersonness();
  }

  pixmarker("END: in_spawnSpectator");
}

function spectatorthirdpersonness() {
  self endon(#"disconnect", #"spawned");
  self notify(#"spectator_thirdperson_thread");
  self endon(#"spectator_thirdperson_thread");
  self.spectatingthirdperson = 0;
}

function forcespawn(time) {
  self endon(#"death", #"hash_54543f163347573c", #"spawned");

  if(!isDefined(time)) {
    time = 60;
  }

  wait time;

  if(is_true(self.hasspawned)) {
    return;
  }

  if(self.pers[#"team"] == "spectator") {
    return;
  }

  if(!globallogic_utils::isvalidclass(self.pers[#"class"])) {
    self.pers[#"class"] = "CLASS_CUSTOM1";
    self.curclass = self.pers[#"class"];
  }

  self globallogic_ui::closemenus();
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

  if(self.pers[#"team"] == "spectator") {
    return;
  }

  if(!mayspawn()) {
    return;
  }

  globallogic::gamehistoryplayerkicked();
  kick(self getentitynumber());
}

function kickwait(waittime) {
  level endon(#"game_ended");
}

function spawninterroundintermission() {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  self globallogic_defaults::default_onspawnintermission();
  self setorigin(self.origin);
  self setplayerangles(self.angles);
  self clientfield::set_to_player("player_dof_settings", 2);
}

function spawnintermission(usedefaultcallback) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  if(isDefined(usedefaultcallback) && usedefaultcallback) {
    globallogic_defaults::default_onspawnintermission();
  } else {
    [[level.onspawnintermission]]();
  }

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
  hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
  self thread globallogic_ui::removespawnmessageshortly(3);
}

function showspawnmessage() {
  if(shouldshowrespawnmessage()) {
    self thread[[level.spawnmessage]]();
  }
}

function spawnclient(timealreadypassed) {
  assert(isDefined(self.team));
  assert(globallogic_utils::isvalidclass(self.curclass));

  if(!self mayspawn()) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self showspawnmessage();
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    return;
  }

  if(is_true(self.waitingtospawn)) {
    return;
  }

  self.waitingtospawn = 1;
  self.allowqueuespawn = undefined;
  self waitandspawnclient(timealreadypassed);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }
}

function waitandspawnclient(timealreadypassed) {
  self endon(#"disconnect", #"end_respawn");
  level endon(#"game_ended");

  if(!isDefined(timealreadypassed)) {
    timealreadypassed = 0;
  }

  spawnedasspectator = 0;

  if(is_true(level.var_41cd8311) && is_true(self.var_30a1aeee)) {
    if(isDefined(level.var_31c6ebd4)) {
      self[[level.var_31c6ebd4]]();
    }
  }

  if(is_true(self.teamkillpunish)) {
    teamkilldelay = globallogic_player::teamkilldelay();

    if(teamkilldelay > timealreadypassed) {
      teamkilldelay -= timealreadypassed;
      timealreadypassed = 0;
    } else {
      timealreadypassed -= teamkilldelay;
      teamkilldelay = 0;
    }

    if(teamkilldelay > 0) {
      hud_message::setlowermessage(#"mp/friendly_fire_will_not", teamkilldelay);
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      spawnedasspectator = 1;
      wait teamkilldelay;
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
    timealreadypassed = 0;
  } else {
    timealreadypassed -= timeuntilspawn;
    timeuntilspawn = 0;
  }

  if(timeuntilspawn > 0) {
    if(level.playerqueuedrespawn) {
      hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
    } else {
      hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
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

    if(timeuntilspawn >= 0.3 && !isbot(self)) {
      var_4dff964a = timeuntilspawn - 0.3 - 0.2;
      self thread function_bb88905b(var_4dff964a);
    }

    self waittilltimeout(timeuntilspawn, #"force_spawn");
    self notify(#"stop_wait_safe_spawn_button");
  }

  if(isDefined(level.var_515c3797)) {
    if(isDefined(level.var_84a50edd) && !spawnedasspectator) {
      spawnedasspectator = self[[level.var_84a50edd]]();
    }

    if(!spawnedasspectator) {
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;

    if(!self[[level.var_515c3797]]()) {
      self.waitingtospawn = 0;
      self hud_message::clearlowermessage();
      self.wavespawnindex = undefined;
      self.respawntimerstarttime = undefined;
      return;
    }
  }

  system::function_c11b0642();
  level flag::wait_till("all_players_connected");

  if(level.players.size > 0) {
    if(scene::should_spectate_on_join()) {
      if(!spawnedasspectator) {
        self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      }

      spawnedasspectator = 1;
      scene::wait_until_spectate_on_join_completes();
    }
  }

  wavebased = level.waverespawndelay > 0;

  if(!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn && !spawnedasspectator) {
    hud_message::setlowermessage(game.strings[#"press_to_spawn"]);

    if(!spawnedasspectator) {
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;
    self waitrespawnorsafespawnbutton();
  }

  self.waitingtospawn = 0;
  self hud_message::clearlowermessage();
  self.wavespawnindex = undefined;
  self.respawntimerstarttime = undefined;

  if(is_true(self.var_8fc85657)) {
    self waittill(#"end_killcam");
  }

  self notify(#"hash_4bd20f5c626eb3f0");

  if(isDefined(self.var_ca00be20)) {
    self.var_ca00be20.alpha = 0;
  }

  self.var_30a1aeee = undefined;
  self.var_8fc85657 = undefined;
  self.var_2a0475c3 = undefined;
  self.var_941a2b2b = undefined;
  self.killcamweapon = getweapon(#"none");
  self.var_5ff1f21c = undefined;
  self.var_f9870df6 = undefined;

  if(is_true(level.var_ba2a141)) {
    level waittill(#"forever");
  }

  if(!isDefined(self.firstspawn)) {
    self.firstspawn = 1;
    savegame::checkpoint_save();
  }

  if(!isbot(self)) {
    self function_eb0dd56(2);
  }

  self thread[[level.spawnplayer]]();
}

function function_bb88905b(var_4dff964a) {
  self endon(#"disconnect");

  if(is_true(self.var_bb88905b)) {
    return;
  }

  self.var_bb88905b = 1;
  s_notify = self waittilltimeout(var_4dff964a, #"force_spawn", #"scene");

  if(s_notify._notify == "timeout") {
    lui::screen_fade_out(0.3, (1, 1, 1), "spectate_spawn");
  } else {
    lui::screen_fade_out(0, (1, 1, 1), "spectate_spawn");
  }

  [[level.var_ad332481[#"fullscreenblack"]]] - > close(self);
  [[level.var_ad332481[#"fullscreenblack"]]] - > open(self, 1);

  if(s_notify._notify == "timeout") {
    while(self.sessionstate !== "playing") {
      util::wait_network_frame();
    }

    lui::screen_fade_out(0, (1, 1, 1), "spectate_spawn");
  }

  util::wait_network_frame(2);
  [[level.var_ad332481[#"fullscreenblack"]]] - > close(self);
  util::wait_network_frame(2);
  lui::screen_fade_in(0.3, (1, 1, 1), "spectate_spawn");
  self.var_bb88905b = 0;
}

function waitrespawnorsafespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    if(self useButtonPressed()) {
      break;
    }

    waitframe(1);
  }
}

function waitinspawnqueue() {
  self endon(#"disconnect", #"end_respawn");

  if(!level.ingraceperiod && !spawning::usestartspawns()) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    self waittill(#"queue_respawn");
  }
}

function setthirdperson(value) {
  if(!level.console) {
    return;
  }

  if(!isDefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
    self.spectatingthirdperson = value;

    if(value) {
      self setclientthirdperson(1);
      self clientfield::set_to_player("player_dof_settings", 2);
    } else {
      self setclientthirdperson(0);
      self clientfield::set_to_player("player_dof_settings", 1);
    }

    self resetfov();
  }
}