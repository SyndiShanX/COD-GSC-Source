#include common_scripts\utility;
#include maps\mp\_utility;
#include scripts\utility;

h2_nukeCountdown() {
  level.nukeCountdownTimer = maps\mp\gametypes\_hud_util::createServerTimer("hudbig", 0.6);
  level.nukeCountdownTimer maps\mp\gametypes\_hud_util::setPoint("TOP LEFT", "TOP LEFT", 150, 23);
  level.nukeCountdownTimer.hidewheninmenu = true;
  level.nukeCountdownTimer.archived = false;
  level.nukeCountdownTimer.glowColor = (0, 0, 0);
  level.nukeCountdownTimer.glowAlpha = 0.1;
  level.nukeCountdownTimer setTenthsTimer(level.nukeTimer);
  level.nukeCountdownTimer.sort = 1001;

  level.nukeCountdownIcon = maps\mp\gametypes\_hud_util::createServerIcon("dpad_killstreak_nuke", 50, 50);
  level.nukeCountdownIcon maps\mp\gametypes\_hud_util::setPoint("TOP LEFT", "TOP LEFT", 145, 5);
  level.nukeCountdownIcon.hidewheninmenu = true;
  level.nukeCountdownIcon.archived = false;
  level.nukeCountdownIcon.sort = 1000;
}

init() {
  //precacheItem( "nuke_mp" );
  //precacheLocationSelector( "map_nuke_selector" );
  precacheShader("dpad_killstreak_nuke");

  level._effect["nuke_player"] = loadfx("fx/explosions/nuke_explosion");
  level._effect["nuke_flash"] = loadfx("fx/explosions/nuke_flash");
  level._effect["nuke_aftermath"] = loadfx("fx/explosions/nuke_smoke_fill");

  game["strings"]["nuclear_strike"] = &"MP_TACTICAL_NUKE"; // is Manticore right now from AW

  level.killstreakFuncs["nuke_mp"] = ::tryUseNuke;

  setDvarIfUninitialized("scr_nukeTimer", 10);
  setDvarIfUninitialized("scr_nukeCancelMode", 0);

  level.nukeTimer = getDvarInt("scr_nukeTimer");
  level.cancelMode = getDvarInt("scr_nukeCancelMode");

  setDevDvarIfUninitialized("scr_nukeDistance", 5000);
  setDevDvarIfUninitialized("scr_nukeEndsGame", true);
  setDevDvarIfUninitialized("scr_nukeDebugPosition", false);
}

tryUseNuke(lifeId, allowCancel) {
  if(isDefined(level.nukeIncoming)) {
    self iprintlnbold(&"LUA_KS_UNAVAILABLE_NUKE");
    return false;
  }

  if(self isUsingRemote() && (!isDefined(level.gtnw) || !level.gtnw))
    return false;

  if(!isDefined(allowCancel))
    allowCancel = true;

  self thread doNuke(allowCancel);
  self notify("used_nuke");

  return true;
}

delaythread_nuke(delay, func) {
  level endon("nuke_cancelled");

  wait(delay);

  thread[[func]]();
}

doNuke(allowCancel) {
  level endon("nuke_cancelled");

  level.nukeInfo = spawnStruct();
  level.nukeInfo.player = self;
  level.nukeInfo.team = self.pers["team"];
  level.nukeinfo.xpscalar = 1;

  level.nukeIncoming = true;

  maps\mp\gametypes\_gamelogic::pauseTimer();
  level.timeLimitOverride = true;
  setGameEndTime(int(gettime() + (level.nukeTimer * 1000)));

  h2_nukeCountdown();

  if(level.teambased) {
    thread teamPlayerCardSplash("callout_used_nuke", self, self.team);
    /*
    players = level.players;

    foreach( player in level.players )
    {
    playerteam = player.pers["team"];
    if( isDefined( playerteam ) )
    {
    if( playerteam == self.pers["team"] )
    player iprintln(&"MP_TACTICAL_NUKE_CALLED", self );
    }
    }
    */
  } else {
    if(!level.hardcoreMode)
      self iprintlnbold(&"LUA_KS_TNUKE");
  }

  level thread delaythread_nuke((level.nukeTimer - 3.3), ::nukeSoundIncoming);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSoundExplosion);
  level thread delaythread_nuke(level.nukeTimer, ::nukeSlowMo);
  level thread delaythread_nuke(level.nukeTimer, ::nukeEffects);
  level thread delaythread_nuke((level.nukeTimer + 0.25), ::nukeVision);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeDeath);
  level thread delaythread_nuke((level.nukeTimer + 1.5), ::nukeEarthquake);
  level thread nukeAftermathEffect();

  if(level.cancelMode && allowCancel)
    level thread cancelNukeOnDeath(self);

  // leaks if lots of nukes are called due to endon above.
  clockObject = spawn("script_origin", (0, 0, 0));
  clockObject hide();

  while(!isDefined(level.nukeDetonated)) {
    clockObject playSound("h2_nuke_timer");
    wait(1.0);
  }
}

cancelNukeOnDeath(player) {
  player waittill_any("death", "disconnect");

  if(isDefined(player) && level.cancelMode == 2)
    player thread maps\mp\h2_killstreaks\_emp::h2_EMP_Use(0, 0);

  maps\mp\gametypes\_gamelogic::resumeTimer();
  level.timeLimitOverride = false;

  level.nukeCountdownTimer destroy();
  level.nukeCountdownIcon destroy();

  level notify("nuke_cancelled");
}

nukeSoundIncoming() {
  level endon("nuke_cancelled");

  foreach(player in level.players)
  player playlocalsound("nuke_incoming");
}

nukeSoundExplosion() {
  level endon("nuke_cancelled");

  foreach(player in level.players) {
    player playlocalsound("nuke_explosion");
    player playlocalsound("nuke_wave");
  }
}

nukeEffects() {
  level endon("nuke_cancelled");

  level.nukeCountdownTimer destroy();
  level.nukeCountdownIcon destroy();

  setGameEndTime(0);

  level.nukeDetonated = true;
  level maps\mp\h2_killstreaks\_emp::destroyActiveVehicles(level.nukeInfo.player);

  foreach(player in level.players) {
    playerForward = anglesToForward(player.angles);
    playerForward = (playerForward[0], playerForward[1], 0);
    playerForward = VectorNormalize(playerForward);

    nukeDistance = 5000;
    nukeDistance = getDvarInt("scr_nukeDistance");

    nukeEnt = spawn("script_model", player.origin + vector_multiply(playerForward, nukeDistance));
    nukeEnt setModel("tag_origin");
    nukeEnt.angles = (0, (player.angles[1] + 180), 90);

    if(getDvarInt("scr_nukeDebugPosition")) {
      lineTop = (nukeEnt.origin[0], nukeEnt.origin[1], (nukeEnt.origin[2] + 500));
      thread draw_line_for_time(nukeEnt.origin, lineTop, (1, 0, 0), 10);
    }

    nukeEnt thread nukeEffect(player);
    player.nuked = true;
  }
}

nukeEffect(player) {
  level endon("nuke_cancelled");

  player endon("disconnect");

  waitframe();
  PlayFXOnTagForClients(level._effect["nuke_flash"], self, "tag_origin", player);
}

nukeAftermathEffect() {
  level endon("nuke_cancelled");

  level waittill("spawning_intermission");

  afermathEnt = getEntArray("mp_global_intermission", "classname");
  afermathEnt = afermathEnt[0];
  up = anglestoup(afermathEnt.angles);
  right = anglestoright(afermathEnt.angles);

  playFX(level._effect["nuke_aftermath"], afermathEnt.origin, up, right);
}

nukeSlowMo() {
  level endon("nuke_cancelled");

  foreach(player in level.players) {
    if(isReallyAlive(player))
      earthquake(0.6, 10, player.origin, 1000);
  }

  //SetSlowMotion( <startTimescale>, <endTimescale>, <deltaTime> )
  setSlowMotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  setSlowMotion(0.25, 1, 2.0);
}

nukeVision() {
  level endon("nuke_cancelled");

  level.nukeVisionInProgress = true;
  _visionsetnaked("", 0);
  visionSetPostApply("airlift_nuke_flash", 3);

  level waittill("nuke_death");

  _visionsetnaked("", 0);
  visionSetPostApply("mpnuke_aftermath", 5);
  wait 5;
  level.nukeVisionInProgress = undefined;
}

nukeDeath() {
  level endon("nuke_cancelled");

  level notify("nuke_death");

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  AmbientStop(1);

  foreach(player in level.players) {
    if(isAlive(player))
      player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(level.nukeInfo.player, level.nukeInfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0);
  }

  level.postRoundTime = 10;

  nukeEndsGame = true;

  if(level.teamBased)
    thread maps\mp\gametypes\_gamelogic::endGame(level.nukeInfo.team, game["strings"]["nuclear_strike"], true);
  else {
    if(isDefined(level.nukeInfo.player))
      thread maps\mp\gametypes\_gamelogic::endGame(level.nukeInfo.player, game["strings"]["nuclear_strike"], true);
    else
      thread maps\mp\gametypes\_gamelogic::endGame(level.nukeInfo, game["strings"]["nuclear_strike"], true);
  }
}

nukeEarthquake() {
  level endon("nuke_cancelled");

  level waittill("nuke_death");

  // TODO: need to get a different position to call this on
  //earthquake( 0.6, 10, nukepos, 100000 );

  //foreach( player in level.players )
  //player PlayRumbleOnEntity( "damage_heavy" );
}

waitForNukeCancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

endSelectionOn(waitfor) {
  self endon("stop_location_selection");
  self waittill(waitfor);
  self thread stopNukeLocationSelection((waitfor == "disconnect"));
}

endSelectionOnGameEnd() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  self thread stopNukeLocationSelection(false);
}

stopNukeLocationSelection(disconnected) {
  if(!disconnected) {
    self setblurforplayer(0, 0.3);
    self endLocationSelection();
    self.selectingLocation = undefined;
  }
  self notify("stop_location_selection");
}