/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_callbackglobal.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;

init() {
  level.splitscreen = isSplitScreen();
  level.xenon = (getDvar("xenonGame") == "true");
  level.ps3 = (getDvar("ps3Game") == "true");
  level.wii = (getDvar("wiiGame") == "true");
  level.onlineGame = getDvarInt("onlinegame");
  level.systemLink = getDvarInt("systemlink");
  level.console = (level.xenon || level.ps3 || level.wii);

  PrecacheMenu("briefing");

  level.rankedMatch = (level.onlineGame

  );

  if(getdvarint("scr_forcerankedmatch") == 1) {
    level.rankedMatch = true;
  }
}

SetupCallbacks() {
  level.otherPlayersSpectate = false;

  level.spawnPlayer = ::spawnPlayer;
  level.spawnClient = ::spawnClient;
  level.spawnSpectator = ::spawnSpectator;
  level.spawnIntermission = ::spawnIntermission;

  level.onSpawnPlayer = ::default_onSpawnPlayer;
  level.onPostSpawnPlayer = ::default_onPostSpawnPlayer;
  level.onSpawnSpectator = ::default_onSpawnSpectator;
  level.onSpawnIntermission = ::default_onSpawnIntermission;

  level.onStartGameType = ::blank;
  level.onPlayerConnect = ::blank;
  level.onPlayerDisconnect = ::blank;
  level.onPlayerDamage = ::blank;
  level.onPlayerKilled = ::blank;
  level.onPlayerWeaponSwap = ::blank;

  level.loadout = ::menuLoadout;
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}
Callback_CurveNotify(string, curveId, nodeIndex) {
  level notify(string, curveId, nodeIndex);
}

Callback_StartGameType() {}

BriefInvulnerability() {
  self endon("disconnect");

  self EnableInvulnerability();

  println("****EnableInvulnerability****");

  wait(3);

  self DisableInvulnerability();

  println("****DisableInvulnerability****");
}

Callback_SaveRestored() {
  println("****Coop CodeCallback_SaveRestored****");

  players = get_players();
  level.debug_player = players[0];

  num = 0;

  if(isDefined(level._save_pos)) {
    num = level._save_trig_ent;
  }

  for(i = 0; i < 4; i++) {
    player = players[i];
    if(isDefined(player)) {
      player thread BriefInvulnerability();
      player thread maps\_quotes::main();

      if(isDefined(player.savedVisionSet)) {
        player VisionSetNaked(player.savedVisionSet, 0.1);
      }

      dvarName = "player" + player GetEntityNumber() + "downs";
      player.downs = getdvarint(dvarName);

      maps\_challenges_coop::doMissionCallback("checkpointLoaded", player);
    }
  }

  maps\_collectibles::onSaveRestored();

  maps\_challenges_coop::onSaveRestored();

  level thread maps\_arcademode::arcadeMode_checkpoint_restore();

  level thread maps\_collectibles_game::collectibles_checkpoint_restore();
}

Player_BreadCrumb_Reset(position, angles) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  level.playerPrevOrigin0 = position;
  level.playerPrevOrigin1 = position;

  if(!isDefined(level._player_breadcrumbs)) {
    level._player_breadcrumbs = [];

    for(i = 0; i < 4; i++) {
      level._player_breadcrumbs[i] = [];

      for(j = 0; j < 4; j++) {
        level._player_breadcrumbs[i][j] = spawnStruct();
      }
    }

  }

  for(i = 0; i < 4; i++) {
    for(j = 0; j < 4; j++) {
      level._player_breadcrumbs[i][j].pos = position;
      level._player_breadcrumbs[i][j].ang = angles;
    }
  }

}

Player_BreadCrumb_Update() {
  self endon("disconnect");
  drop_distance = 70;
  right = anglestoright(self.angles) * drop_distance;
  level.playerPrevOrigin0 = self.origin + right;
  level.playerPrevOrigin1 = self.origin - right;

  if(!isDefined(level._player_breadcrumbs)) {
    Player_BreadCrumb_Reset(self.origin, self.angles);
  }

  num = self GetEntityNumber();

  while(1) {
    wait 1;
    dist_squared = distancesquared(self.origin, level.playerPrevOrigin0);
    if(dist_squared > 500 * 500) {
      right = anglestoright(self.angles) * drop_distance;
      level.playerPrevOrigin0 = self.origin + right;
      level.playerPrevOrigin1 = self.origin - right;
    } else if(dist_squared > drop_distance * drop_distance) {
      level.playerPrevOrigin1 = level.playerPrevOrigin0;
      level.playerPrevOrigin0 = self.origin;
    }

    dist_squared = distancesquared(self.origin, level._player_breadcrumbs[num][0].pos);

    dropBreadcrumbs = true;

    if(isDefined(level.flag) && isDefined(level.flag["drop_breadcrumbs"])) {
      if(!flag("drop_breadcrumbs")) {
        dropBreadcrumbs = false;
      }
    }

    if(dropBreadcrumbs && (dist_squared > drop_distance * drop_distance)) {
      for(i = 2; i >= 0; i--) {
        level._player_breadcrumbs[num][i + 1].pos = level._player_breadcrumbs[num][i].pos;
        level._player_breadcrumbs[num][i + 1].ang = level._player_breadcrumbs[num][i].ang;
      }

      level._player_breadcrumbs[num][0].pos = PlayerPhysicsTrace(self.origin, self.origin + (0, 0, -1000));
      level._player_breadcrumbs[num][0].ang = self.angles;
    }
  }
}

SetPlayerSpawnPos() {
  players = get_players();
  player = players[0];

  if(!isDefined(level._player_breadcrumbs)) {
    spawnpoints = getEntArray("info_player_deathmatch", "classname");

    if(player.origin == (0, 0, 0) && isDefined(spawnpoints) && spawnpoints.size > 0) {
      Player_BreadCrumb_Reset(spawnpoints[0].origin, spawnpoints[0].angles);
    } else {
      Player_BreadCrumb_Reset(player.origin, player.angles);
    }
  }

  too_close = 30;
  spawn_pos = level._player_breadcrumbs[0][0].pos;
  dist_squared = distancesquared(player.origin, spawn_pos);

  if(dist_squared > 500 * 500) {
    if(player.origin != (0, 0, 0)) {
      spawn_pos = player.origin + (0, 30, 0);
    }
  } else if(dist_squared < too_close * too_close) {
    spawn_pos = level._player_breadcrumbs[0][1].pos;
  }

  spawn_angles = vectornormalize(player.origin - spawn_pos);
  spawn_angles = vectorToAngles(spawn_angles);

  if(!playerpositionvalid(spawn_pos)) {
    spawn_pos = player.origin;
    spawn_angles = player.angles;
  }
}

Callback_PlayerConnect() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: Callback_PlayerConnect()\n");
  }

  thread first_player_connect();

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: Callback_PlayerConnect() - START WAIT begin and waittillframeend\n");
  }

  self waittill("begin");
  self reset_clientdvars();
  waittillframeend;

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: Callback_PlayerConnect() - STOP WAIT begin and waittillframeend\n");
  }

  level notify("connected", self);

  self thread maps\_load::player_special_death_hint();

  info_player_spawn = getEntArray("info_player_deathmatch", "classname");

  if(isDefined(info_player_spawn) && info_player_spawn.size > 0) {
    players = get_players();
    if(isDefined(players) && (players.size != 0)) // || players[0] == self ) )
    {
      if(players[0] == self) {
        println("2:Setting player origin to info_player_start " + info_player_spawn[0].origin);
        self setOrigin(info_player_spawn[0].origin);
        self setPlayerAngles(info_player_spawn[0].angles);
        self thread Player_BreadCrumb_Update();
      } else {
        println("Callback_PlayerConnect:Setting player origin near host position " + players[0].origin);
        self SetPlayerSpawnPos();
        self thread Player_BreadCrumb_Update();
      }
    } else {
      println("Callback_PlayerConnect:Setting player origin to info_player_start " + info_player_spawn[0].origin);
      self setOrigin(info_player_spawn[0].origin);
      self setPlayerAngles(info_player_spawn[0].angles);
      self thread Player_BreadCrumb_Update();
    }
  }

  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }

  if(!isDefined(self.flag["player_has_red_flashing_overlay"])) {
    self player_flag_init("player_has_red_flashing_overlay");
    self player_flag_init("player_is_invulnerable");
  }

  if(!isDefined(self.flag["loadout_given"])) {
    self player_flag_init("loadout_given");
  }

  self player_flag_clear("loadout_given");

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    waittillframeend;

    self thread spawnPlayer();
    return;
  }

  if(!isDefined(level.spawnClient)) {
    waittillframeend;

    self thread spawnPlayer();
    return;
  }

  self setClientDvar("ui_allow_loadoutchange", "1");

  self thread[[level.spawnClient]]();

  dvarName = "player" + self GetEntityNumber() + "downs";
  setDvar(dvarName, self.downs);

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: Callback_PlayerConnect() - COMPLETE\n");
  }
}

reset_clientdvars() {
  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
    return;
  }

  self SetClientDvars("compass", "1", "hud_showStance", "1", "cg_thirdPerson", "0", "cg_fov", "65", "cg_thirdPersonAngle", "0", "ammoCounterHide", "0", "miniscoreboardhide", "0", "ui_hud_hardcore", "0", "credits_active", "0");

  self AllowSpectateTeam("allies", false);
  self AllowSpectateTeam("axis", false);
  self AllowSpectateTeam("freelook", false);
  self AllowSpectateTeam("none", false);
}

Callback_PlayerDisconnect() {}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(isDefined(level.overridePlayerDamage)) {
    self[[level.overridePlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && (!isDefined(level.friendlyexplosivedamage) || !level.friendlyexplosivedamage)) {
    if(self != eAttacker) {
      return;
    } else if(sMeansOfDeath != "MOD_GRENADE_SPLASH" &&
      sMeansOfDeath != "MOD_GRENADE" &&
      sMeansOfDeath != "MOD_EXPLOSIVE" &&
      sMeansOfDeath != "MOD_PROJECTILE" &&
      sMeansOfDeath != "MOD_PROJECTILE_SPLASH" &&
      sMeansOfDeath != "MOD_BURNED") {
      return;
    }
  }

  self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
}

finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime);
}

Callback_RevivePlayer() {
  self endon("disconnect");
  self RevivePlayer();
}

Callback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self endon("disconnect");
  [[maps\_laststand::PlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  self thread[[level.onPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);

  self.downs++;
  dvarName = "player" + self GetEntityNumber() + "downs";
  setDvar(dvarName, self.downs);

  if(isDefined(level.player_killed_shellshock)) {
    self ShellShock(level.player_killed_shellshock, 3);
  } else {
    self ShellShock("death", 3);
  }

  self PlayLocalSound("mx_death");
  self PlayLocalSound("mx_death_rear");

  self setmovespeedscale(1.0);
  self.ignoreme = false;

  self notify("killed_player");

  wait(1);

  if(isDefined(level.overridePlayerKilled)) {
    self[[level.overridePlayerKilled]]();
  }

  if(get_players().size > 1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i])) {
        players[i] thread maps\_quotes::displayMissionFailed();
        if(!isAlive(players[i])) {
          players[i] thread maps\_quotes::displayPlayerDead();
          println("Player #" + i + " is dead");
        } else {
          players[i] thread maps\_quotes::displayTeammateDead(self);
          println("Player #" + i + " is alive");
        }
      }
    }
    missionfailed();
    return;
  }

  if(!isDefined(level.spawnClient)) {
    waittillframeend;
    self spawn(self.origin, self.angles);
    return;
  }
}
spawnClient() {
  self endon("disconnect");
  self endon("end_respawn");

  println("*************************spawnClient****");

  self unlink();

  if(isDefined(self.spectate_cam)) {
    self.spectate_cam delete();
  }

  if(level.otherPlayersSpectate) {
    self thread[[level.spawnSpectator]]();
  } else {
    self thread[[level.spawnPlayer]]();
  }
}

spawnPlayer(spawnOnHost) {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");

  synchronize_players();

  setSpawnVariables();

  self.sessionstate = "playing";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  self.maxhealth = self.health;
  self.shellshocked = false;
  self.inWater = false;
  self.friendlydamage = undefined;
  self.hasSpawned = true;
  self.spawnTime = getTime();
  self.afk = false;

  println("*************************spawnPlayer****");
  self detachAll();

  if(isDefined(level.custom_spawnPlayer)) {
    self[[level.custom_spawnPlayer]]();
    return;
  }

  if(isDefined(level.onSpawnPlayer)) {
    self[[level.onSpawnPlayer]]();
  }

  wait_for_first_player();

  if(isDefined(spawnOnHost)) {
    self spawn(get_players()[0].origin, get_players()[0].angles);
    self SetPlayerSpawnPos();
  } else {
    self spawn(self.origin, self.angles);
  }

  if(isDefined(level.onPostSpawnPlayer)) {
    self[[level.onPostSpawnPlayer]]();
  }

  if(isDefined(level.onPlayerWeaponSwap)) {
    self thread[[level.onPlayerWeaponSwap]]();
  }

  self maps\_introscreen::introscreen_player_connect();

  waittillframeend;

  if(self != get_players()[0]) {
    wait(0.5);
  }

  self notify("spawned_player");
}

synchronize_players() {
  if(!isDefined(level.flag) || !isDefined(level.flag["all_players_connected"])) {
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");
    println("^1****ERROR: You must call _load::main() if you don't want bad coop things to happen!****");
    return;
  }

  if(GetNumConnectedPlayers() == GetNumExpectedPlayers()) {
    return;
  }

  if(flag("all_players_connected")) {
    return;
  }

  background = undefined;

  if(level.onlineGame || level.systemLink) {
    self OpenMenu("briefing");
  } else {
    background = NewHudElem();
    background.x = 0;
    background.y = 0;
    background.horzAlign = "fullscreen";
    background.vertAlign = "fullscreen";
    background.foreground = true;
    background SetShader("black", 640, 480);
  }

  flag_wait("all_players_connected");

  if(level.onlineGame || level.systemLink) {
    players = get_players();

    for(i = 0; i < players.size; i++) {
      players[i] CloseMenu();
    }
  } else {
    assert(isDefined(background));
    background Destroy();
  }
}

spawnSpectator() {
  self endon("disconnect");
  self endon("spawned_spectator");
  self notify("spawned");
  self notify("end_respawn");

  setSpawnVariables();

  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  if(isDefined(level.otherPlayersSpectateClient)) {
    self.spectatorclient = level.otherPlayersSpectateClient getEntityNumber();
  }

  self setClientDvars("cg_thirdPerson", 0);
  self setSpectatePermissions();

  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  self.maxhealth = self.health;
  self.shellshocked = false;
  self.inWater = false;
  self.friendlydamage = undefined;
  self.hasSpawned = true;
  self.spawnTime = getTime();
  self.afk = false;

  println("*************************spawnSpectator***");
  self detachAll();

  if(isDefined(level.onSpawnSpectator)) {
    self[[level.onSpawnSpectator]]();
  }

  self spawn(self.origin, self.angles);

  waittillframeend;

  flag_wait("all_players_connected");

  self notify("spawned_spectator");
}

setSpectatePermissions() {
  self AllowSpectateTeam("allies", true);
  self AllowSpectateTeam("axis", false);
  self AllowSpectateTeam("freelook", false);
  self AllowSpectateTeam("none", false);
}

spawnIntermission() {
  self notify("spawned");
  self notify("end_respawn");

  self setSpawnVariables();

  self freezeControls(false);

  self setClientDvar("cg_everyoneHearsEveryone", "1");

  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;

  [[level.onSpawnIntermission]]();
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

default_onSpawnPlayer() {}

default_onPostSpawnPlayer() {}

default_onSpawnSpectator() {}

default_onSpawnIntermission() {
  spawnpointname = "info_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");

  if(spawnpoints.size < 1) {
    println("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
    return;
  }

  spawnpoint = spawnpoints[RandomInt(spawnpoints.size)];
  if(isDefined(spawnpoint)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
  }
}

first_player_connect() {
  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: first_player_connect()\n");
  }

  waittillframeend;

  if(isDefined(self)) {
    level notify("connecting", self);

    players = get_players();
    if(isDefined(players) && (players.size == 0 || players[0] == self)) {
      level notify("connecting_first_player", self);
      self waittill("spawned_player");

      waittillframeend;

      level notify("first_player_ready", self);
    }
  }

  if(getdebugdvar("replay_debug") == "1") {
    println("File: _callbackglobal.gsc. Function: first_player_connect() - COMPLETE\n");
  }
}

menuLoadout(response) {
  println("*************************************** " + response);

  if(response != "back") {
    self.pers["class"] = response;
  }

  self thread[[level.spawnClient]]();
}

setSpawnVariables() {
  resetTimeout();

  self StopShellshock();
  self StopRumble("damage_heavy");
}