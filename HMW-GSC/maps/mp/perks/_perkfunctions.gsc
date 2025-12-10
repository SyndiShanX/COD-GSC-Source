#include scripts\utility;

h2_setTacticalInsertion() {
  self maps\mp\_utility::_giveWeapon("flare_mp", 0);
  self giveStartAmmo("flare_mp");

  self thread monitorTIUse();
}

h2_unsetTacticalInsertion() {
  self notify("end_monitorTIUse");
}

clearPreviousTISpawnpoint() {
  self common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self.setSpawnpoint))
    self deleteTI(self.setSpawnpoint);
}

updateTISpawnPosition() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");

  while(maps\mp\_utility::isReallyAlive(self)) {
    if(self isValidTISpawnPosition())
      self.TISpawnPosition = self.origin;

    wait(0.05);
  }
}

isValidTISpawnPosition() {
  if(Canspawn(self.origin) && self IsOnGround())
    return true;
  else
    return false;
}

monitorTIUse() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");

  self thread updateTISpawnPosition();
  self thread clearPreviousTISpawnpoint();

  for(;;) {
    self waittill("grenade_fire", lightstick, weapName);

    if(weapName != "flare_mp") {
      continue;
    }
    lightstick delete();

    if(isDefined(self.setSpawnPoint))
      self deleteTI(self.setSpawnPoint);

    if(!isDefined(self.TISpawnPosition)) {
      continue;
    }
    if(self maps\mp\_utility::touchingBadTrigger()) {
      continue;
    }
    TIGroundPosition = playerPhysicsTrace(self.TISpawnPosition + (0, 0, 16), self.TISpawnPosition - (0, 0, 2048)) + (0, 0, 1);

    glowStick = spawn("script_model", TIGroundPosition);
    glowStick.angles = self.angles;
    glowStick.team = self.team;
    glowStick.enemyTrigger = spawn("script_origin", TIGroundPosition);
    glowStick thread GlowStickSetupAndWaitForDeath(self);
    glowStick.playerSpawnPos = self.TISpawnPosition;
    glowStick.notti = true;

    glowStick thread maps\mp\gametypes\_weapons::createBombSquadModel("weapon_light_stick_tactical_bombsquad", "tag_fire_fx", self);

    self.setSpawnPoint = glowStick;
    self thread tactical_respawn();
    return;
  }
}

tactical_respawn() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_tactical_respawn");

  self notify("tactical_respawn");
  self endon("tactical_respawn");

  self waittill("spawned_player");
  self playSound("h2_tactical_spawn");
}

GlowStickSetupAndWaitForDeath(owner) {
  self setModel(level.spawnGlowModel["enemy"]);
  if(level.teamBased)
    self maps\mp\_entityheadIcons::setTeamHeadIcon(self.team, (0, 0, 20));
  else
    self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, 20));

  self thread GlowStickDamageListener(owner);
  self thread GlowStickEnemyUseListener(owner);
  self thread GlowStickUseListener(owner);
  self thread GlowStickTeamUpdater(level.otherTeam[self.team], level.spawnGlow["enemy"], owner);

  dummyGlowStick = spawn("script_model", self.origin + (0, 0, 0));
  dummyGlowStick.angles = self.angles;
  dummyGlowStick setModel(level.spawnGlowModel["friendly"]);
  dummyGlowStick setContents(0);
  dummyGlowStick thread GlowStickTeamUpdater(self.team, level.spawnGlow["friendly"], owner);

  dummyGlowStick playLoopSound("emt_road_flare_burn");

  self waittill("death");

  dummyGlowStick stopLoopSound();
  dummyGlowStick delete();
}

GlowStickTeamUpdater(showForTeam, showEffect, owner) {
  self endon("death");
  level endon("game_ended");

  // PlayFXOnTag fails if run on the same frame the parent entity was created
  wait(0.05);

  //playFXOnTag( showEffect, self, "TAG_FX" );
  angles = self getTagAngles("tag_fire_fx");
  fxEnt = SpawnFx(showEffect, self getTagOrigin("tag_fire_fx"), anglesToForward(angles), anglesToUp(angles));

  if(showEffect == level.spawnGlow["friendly"])
    self thread h2_glowstick_fx(fxEnt);
  else
    TriggerFx(fxEnt);

  self thread deleteOnDeath(fxEnt);

  for(;;) {
    self hide();
    fxEnt hide();
    foreach(player in level.players) {
      if(player.team == showForTeam && level.teamBased) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      } else if(!level.teamBased && player == owner && showEffect == level.spawnGlow["friendly"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      } else if(!level.teamBased && player != owner && showEffect == level.spawnGlow["enemy"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      }
    }

    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

h2_glowstick_fx(fxEnt) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    TriggerFX(fxEnt);
    wait 10;
  }
}

deleteOnDeath(ent) {
  self waittill("death");
  if(isDefined(ent))
    ent delete();
}

GlowStickDamageListener(owner) {
  self endon("death");
  level endon("game_ended");

  self setCanDamage(true);
  // use large health to work around teamkilling issue
  self.health = 5000;

  for(;;) {
    self waittill("damage", amount, attacker);

    if(level.teambased && isDefined(owner) && attacker != owner && (isDefined(attacker.team) && attacker.team == self.team)) {
      self.health += amount;
      continue;
    }

    if(self.health < (5000 - 20)) {
      if(isDefined(owner) && attacker != owner) {
        attacker notify("destroyed_insertion", owner);
        attacker notify("destroyed_explosive"); // count towards SitRep Pro challenge
        owner thread maps\mp\_utility::leaderDialogOnPlayer("ti_destroyed");
        owner thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("flare_destroyed", attacker);
      }

      attacker thread deleteTI(self);
    }
  }
}

GlowStickUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PICKUP_TI");

  self thread updateEnemyUse(owner);

  for(;;) {
    self waittill("trigger", player);

    player playSound("chemlight_pu");
    player thread h2_setTacticalInsertion();
    player thread deleteTI(self);
  }
}

updateEnemyUse(owner) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self maps\mp\_utility::setSelfUsable(owner);
    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

deleteTI(TI) {
  self notify("cancel_tactical_respawn");

  if(isDefined(TI.enemyTrigger))
    TI.enemyTrigger Delete();

  spot = TI.origin;
  spotAngles = TI.angles;

  TI Delete();

  dummyGlowStick = spawn("script_model", spot);
  dummyGlowStick.angles = spotAngles;
  dummyGlowStick setModel(level.spawnGlowModel["friendly"]);

  dummyGlowStick setContents(0);
  thread dummyGlowStickDelete(dummyGlowStick);
}

dummyGlowStickDelete(stick) {
  wait(2.5);
  stick Delete();
}

GlowStickEnemyUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self.enemyTrigger setCursorHint("HINT_NOICON");
  self.enemyTrigger setHintString(&"LUA_SMASH_FLARE");
  self.enemyTrigger maps\mp\_utility::makeEnemyUsable(owner);

  for(;;) {
    self.enemyTrigger waittill("trigger", player);

    player notify("destroyed_insertion", owner);
    player notify("destroyed_explosive"); // count towards SitRep Pro challenge

    //playFX( level.spawnGlowSplat, self.origin);		

    if(isDefined(owner) && player != owner)
      owner thread maps\mp\_utility::leaderDialogOnPlayer("ti_destroyed");

    player thread deleteTI(self);
  }
}

setmartyr() {
  self waittill("death");
  magicgrenademanual("h1_fraggrenade_mp", self.origin + (0.0, 0.0, 5.0), (0.0, 0.0, 0.0), 2, self, 2);
}

setCombatHigh() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_combathigh");
  level endon("end_game");

  self.damageBlockedTotal = 0;

  if(level.splitscreen) {
    yOffset = 56;
    iconSize = 21; // 32/1.5
  } else {
    yOffset = 112;
    iconSize = 32;
  }

  self.combatHighOverlay = newClientHudElem(self);
  self.combatHighOverlay.x = 0;
  self.combatHighOverlay.y = 0;
  self.combatHighOverlay.alignX = "left";
  self.combatHighOverlay.alignY = "top";
  self.combatHighOverlay.horzAlign = "fullscreen";
  self.combatHighOverlay.vertAlign = "fullscreen";
  self.combatHighOverlay setshader("combathigh_overlay", 640, 480);
  self.combatHighOverlay.sort = -10;
  self.combatHighOverlay.archived = true;

  self.combatHighTimer = self maps\mp\gametypes\_hud_util::createTimer("default", 0.8);
  self.combatHighTimer maps\mp\gametypes\_hud_util::setPoint("CENTER", "CENTER", 0, yOffset);
  self.combatHighTimer setTimer(10.0);
  self.combatHighTimer.color = (.8, .8, 0);
  self.combatHighTimer.archived = false;
  self.combatHighTimer.foreground = true;

  self.combatHighIcon = self maps\mp\gametypes\_hud_util::createIcon("specialty_painkiller", iconSize, iconSize);
  self.combatHighIcon.alpha = 0;
  self.combatHighIcon maps\mp\gametypes\_hud_util::setParent(self.combatHighTimer);
  self.combatHighIcon maps\mp\gametypes\_hud_util::setPoint("BOTTOM", "TOP");
  self.combatHighIcon.archived = true;
  self.combatHighIcon.sort = 1;
  self.combatHighIcon.foreground = true;

  self.combatHighOverlay.alpha = 0.0;
  self.combatHighOverlay fadeOverTime(1.0);
  self.combatHighIcon fadeOverTime(1.0);
  self.combatHighOverlay.alpha = 1.0;
  self.combatHighIcon.alpha = 0.85;

  self thread unsetCombatHighOnDeath();

  wait(8);

  self.combatHighIcon fadeOverTime(2.0);
  self.combatHighIcon.alpha = 0.0;

  self.combatHighOverlay fadeOverTime(2.0);
  self.combatHighOverlay.alpha = 0.0;

  self.combatHighTimer fadeOverTime(2.0);
  self.combatHighTimer.alpha = 0.0;

  wait(2);
  self.damageBlockedTotal = undefined;

  self maps\mp\_utility::_unsetPerk("specialty_combathigh");
}

unsetCombatHighOnDeath() {
  self endon("disconnect");
  self endon("unset_combathigh");

  self waittill("death");

  self thread maps\mp\_utility::_unsetPerk("specialty_combathigh");
}

unsetCombatHigh() {
  self notify("unset_combathigh");
  self.combatHighOverlay destroy();
  self.combatHighIcon destroy();
  self.combatHighTimer destroy();
}

setcrouchmovement() {
  thread crouchstatelistener();
  crouchmovementsetspeed();
}

crouchstatelistener() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetCrouchMovement");
  level endon("game_ended");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  for(;;) {
    common_scripts\utility::waittill_any("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    crouchmovementsetspeed();
  }
}

crouchmovementsetspeed() {}

unsetcrouchmovement() {}

setpersonaluav() {
  var_0 = spawn("script_model", self.origin);
  var_0.team = self.team;
  var_0 makeportableradar(self);
  self.personalradar = var_0;
  thread radarmover(var_0);
}

radarmover(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("personal_uav_remove");
  self endon("personal_uav_removed");

  for(;;) {
    var_0 moveto(self.origin, 0.05);
    wait 0.05;
  }
}

unsetpersonaluav() {
  if(isDefined(self.personalradar)) {
    self notify("personal_uav_removed");
    level maps\mp\gametypes\_portable_radar::deleteportableradar(self.personalradar);
    self.personalradar = undefined;
  }
}

setoverkillpro() {
}

unsetoverkillpro() {
}

setempimmune() {
}

unsetempimmune() {
}

setautospot() {
  autospotadswatcher();
  autospotdeathwatcher();
}

autospotdeathwatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self autospotoverlayoff();
}

unsetautospot() {
  self notify("endAutoSpotAdsWatcher");
  self autospotoverlayoff();
}

autospotadswatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    var_1 = self playerads();

    if(var_1 < 1 && var_0) {
      var_0 = 0;
      self autospotoverlayoff();
    }

    if(var_1 < 1 && !var_0) {
      continue;
    }
    if(var_1 == 1 && !var_0) {
      var_0 = 1;
      self autospotoverlayon();
    }
  }
}

setregenspeed() {
}

unsetregenspeed() {
}

setsharpfocus() {
  self setviewkickscale(0.5);
}

unsetsharpfocus() {
  self setviewkickscale(1);
}

setdoubleload() {
  self endon("death");
  self endon("disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self getweaponslist("primary");

    foreach(var_2 in var_0) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = weaponclipsize(var_2);
      var_5 = var_4 - var_3;
      var_6 = self getweaponammostock(var_2);

      if(var_3 != var_4 && var_6 > 0) {
        if(var_3 + var_6 >= var_4) {
          self setweaponammoclip(var_2, var_4);
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammoclip(var_2, var_3 + var_6);

        if(var_6 - var_5 > 0) {
          self setweaponammostock(var_2, var_6 - var_5);
          continue;
        }

        self setweaponammostock(var_2, 0);
      }
    }
  }
}

unsetdoubleload() {
  self notify("endDoubleLoad");
}

setmarksman(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0))
    var_0 = 10;
  else
    var_0 = int(var_0) * 2;

  maps\mp\_utility::setrecoilscale(var_0);
  self.recoilscale = var_0;
}

unsetmarksman() {
  maps\mp\_utility::setrecoilscale(0);
  self.recoilscale = 0;
}

setstunresistance(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0))
    self.stunscaler = 0.5;
  else
    self.stunscaler = int(var_0) / 10;
}

unsetstunresistance() {
  self.stunscaler = 1;
}

setsteadyaimpro() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self setaimspreadmovementscale(0.5);
}

unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1.0);
}

perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._useperkenabled = undefined;
}

setrearview() {
}

unsetrearview() {
  self notify("end_perkUseTracker");
}

setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }
  self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "";
  self _visionsetnakedforplayer("end_game", 5);
  thread endgamedeath(7);
  self.hasdonecombat = 1;
}

unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  maps\mp\_utility::revertvisionsetforplayer();

  if(!isDefined(self.endgametimer)) {
    return;
  }
  self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
  self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

endgamedeath(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait(var_0 + 1);
  maps\mp\_utility::_suicide();
}

stancestatelistener() {}

jumpstatelistener() {}

unsetsiege() {}

setsaboteur() {
  self.objectivescaler = 2;
}

unsetsaboteur() {
  self.objectivescaler = 1;
}

setlightweight() {
  self.moveSpeedScaler = maps\mp\_utility::lightweightscalar();
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
}

unsetlightweight() {
  self.moveSpeedScaler = 1;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
}

setblackbox() {
  self.killstreakscaler = 1.5;
}

unsetblackbox() {
  self.killstreakscaler = 1;
}

setsteelnerves() {
  maps\mp\_utility::giveperk("specialty_bulletaccuracy", 1);
  maps\mp\_utility::giveperk("specialty_holdbreath", 0);
}

unsetsteelnerves() {
  maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
  maps\mp\_utility::_unsetperk("specialty_holdbreath");
}

setdelaymine() {
}

unsetdelaymine() {
}

setlocaljammer() {
  if(!maps\mp\_utility::isemped())
    self MakeScrambler();
}

unsetlocaljammer() {
  self ClearScrambler();
}

setthermal() {
  self thermalvisionon();
}

unsetthermal() {
  self thermalvisionoff();
}

setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

onemanarmyweaponchangetracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  if(!maps\mp\_utility::gameFlag("prematch_done")) {
    maps\mp\_utility::gameFlagWait("prematch_done");

    last_weapon = self getcurrentweapon();
    if(last_weapon == "onemanarmy_mp")
      thread selectonemanarmyclass();
  } else {
    last_weapon = "";
  }

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0 != "onemanarmy_mp") {
      if(last_weapon == "onemanarmy_mp") {
        self notify("selectonemanarmyclass");
      }

      last_weapon = var_0;
      continue;
    }

    last_weapon = var_0;
    thread selectonemanarmyclass();
  }
}

selectonemanarmyclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self notify("selectonemanarmyclass");
  self endon("selectonemanarmyclass");

  thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(2);
  thread closeomamenuondeath();

  self notifyonplayercommand("oma_movement", "+forward");
  self notifyonplayercommand("oma_movement", "+back");
  self notifyonplayercommand("oma_movement", "+moveright");
  self notifyonplayercommand("oma_movement", "+moveleft");

  info = spawnStruct();

  self waitfor_lui_or_movement(info);

  self notifyonplayercommandremove("oma_movement", "+forward");
  self notifyonplayercommandremove("oma_movement", "+back");
  self notifyonplayercommandremove("oma_movement", "+moveright");
  self notifyonplayercommandremove("oma_movement", "+moveleft");

  var_0 = info.var_0;
  var_1 = info.var_1;

  if(!isDefined(var_1) || var_0 != "class_select" || maps\mp\_utility::isusingremote()) {
    if(self getcurrentweapon() == "onemanarmy_mp") {
      common_scripts\utility::_disableweaponswitch();
      common_scripts\utility::_disableoffhandweapons();
      common_scripts\utility::_disableusability();
      self switchtoweapon(common_scripts\utility::getlastweapon());
      self waittill("weapon_change");
      print("weapon change happened. remove blastshield?");
      common_scripts\utility::_enableweaponswitch();
      common_scripts\utility::_enableoffhandweapons();
      common_scripts\utility::_enableusability();
    }

    return;
  }

  thread giveonemanarmyclass(var_1);
}

waitfor_lui_or_movement(info) {
  self endon("oma_movement");

  self waittill("luinotifyserver", var_0, var_1);

  info.var_0 = var_0;
  info.var_1 = var_1;
}

closeomamenuondeath() {
  self endon("luinotifyserver");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  common_scripts\utility::_enableweaponswitch();
  common_scripts\utility::_enableoffhandweapons();
  common_scripts\utility::_enableusability();
  thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
  self notifyonplayercommandremove("oma_movement", "+forward");
  self notifyonplayercommandremove("oma_movement", "+back");
  self notifyonplayercommandremove("oma_movement", "+moveright");
  self notifyonplayercommandremove("oma_movement", "+moveleft");
}

giveonemanarmyclass(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(maps\mp\_utility::_hasperk("specialty_omaquickchange")) {
    duration = 3.0;
    self playlocalsound("foly_onemanarmy_bag3_plr");
    self playsoundtoteam("foly_onemanarmy_bag3_npc", "allies", self);
    self playsoundtoteam("foly_onemanarmy_bag3_npc", "axis", self);
  } else {
    duration = 6.0;
    self playlocalsound("foly_onemanarmy_bag6_plr");
    self playsoundtoteam("foly_onemanarmy_bag6_npc", "allies", self);
    self playsoundtoteam("foly_onemanarmy_bag6_npc", "axis", self);
  }

  thread omausebar(duration);

  common_scripts\utility::_disableweapon();
  common_scripts\utility::_disableoffhandweapons();
  common_scripts\utility::_disableusability();
  wait(duration);
  common_scripts\utility::_enableweapon();
  common_scripts\utility::_enableoffhandweapons();
  common_scripts\utility::_enableusability();

  classNum = var_0 + 1;
  classIndex = maps\mp\gametypes\_menus::getclasschoice(classNum);

  self.omaclasschanged = 1;
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;

  maps\mp\gametypes\_class::clearcopycatloadout();
  maps\mp\gametypes\_class::cac_setlastclassindex(classNum);
  maps\mp\gametypes\_class::cac_setlastgrouplocation(getdvarint("xblive_privatematch"));
  maps\mp\gametypes\_class::setclass(classIndex);
  maps\mp\gametypes\_class::giveloadout(self.pers["team"], classIndex, undefined, 0);

  if(!isDefined(self.spawnplayergivingloadout)) {
    maps\mp\gametypes\_class::applyloadout();
    maps\mp\gametypes\_hardpoints::giveownedhardpointitem(true);
  }

  self setweaponammoclip(weaponaltweaponname(self.primaryweapon), 0);
  self setweaponammostock(weaponaltweaponname(self.primaryweapon), 0);

  if(isDefined(self.carryflag))
    self attach(self.carryflag, "J_spine4", 1);

  self notify("changed_kit");
  level notify("changed_kit");
}

omausebar(duration) {
  self endon("disconnect");
  var_1 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0, -25);
  var_2 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0, -25);
  var_2 settext(&"MPUI_CHANGING_KIT");
  var_1 maps\mp\gametypes\_hud_util::updatebar(0, 1 / duration);

  for(var_3 = 0; var_3 < duration && isalive(self) && !level.gameended; var_3 += 0.05)
    wait 0.05;

  var_1 maps\mp\gametypes\_hud_util::destroyelem();
  var_2 maps\mp\gametypes\_hud_util::destroyelem();
}

setblastshield() {
  self thread blastshieldUseTracker();
  self setweaponhudiconoverride("primaryoffhand", "h2_blastshield");
  self.stunscaler = 0;
}

unsetblastshield() {
  self notify("remove_blastshield");
  self notify("end_perkUseTracker");
  self.blastShielded = undefined;
  self setweaponhudiconoverride("primaryoffhand", "none");
  self.stunscaler = undefined;
}

blastshieldusetracker() {
  self endon("death");
  self endon("disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");

  for(;;) {
    self waittill("empty_offhand");

    if(!common_scripts\utility::isoffhandweaponenabled()) {
      continue;
    }
    if(!isDefined(self.blastShielded)) {
      self.blastShielded = true;
      self _visionsetnakedforplayer("black_bw", 0.15);
      wait(0.15);
      self thread blastshield_overlay();
      self _visionsetnakedforplayer("", 0);
      self playSoundToPlayer("item_blast_shield_on", self);
    } else {
      self.blastShielded = undefined;
      self _visionsetnakedforplayer("black_bw", 0.15);
      wait(0.15);
      self notify("remove_blastshield");
      self _visionsetnakedforplayer("", 0);
      self playSoundToPlayer("item_blast_shield_off", self);
    }
  }
}

blastshield_overlay() {
  self endon("disconnect");

  self notify("blastshield_overlay");
  self endon("blastshield_overlay");

  overlay = newClientHudElem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay SetShader("ballistic_overlay", 640, 480);
  overlay.sort = -10;
  overlay.archived = true;

  common_scripts\utility::waittill_any_ents(level, "game_ended", self, "death", self, "remove_blastshield");

  overlay destroy();
}

setfreefall() {
}

unsetfreefall() {
}

setpainted(var_0) {
  if(isplayer(self)) {
    if(isDefined(var_0.specialty_paint_time) && !maps\mp\_utility::_hasperk("specialty_coldblooded")) {
      self.painted = 1;
      self setperk("specialty_radararrow", 1, 0);
      thread unsetpainted(var_0.specialty_paint_time);
      thread watchpainteddeath();
    }
  }
}

watchpainteddeath() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("unsetPainted");
  self waittill("death");
  self.painted = 0;
}

unsetpainted(var_0) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self.painted = 0;
  self unsetperk("specialty_radararrow", 1);
  self notify("unsetPainted");
}

ispainted() {
  return isDefined(self.painted) && self.painted;
}

setrefillgrenades() {
  if(isDefined(self.primarygrenade))
    self givemaxammo(self.primarygrenade);

  if(isDefined(self.secondarygrenade))
    self givemaxammo(self.secondarygrenade);
}

setfinalstand() {
  maps\mp\_utility::giveperk("specialty_pistoldeath", 0);
}

unsetfinalstand() {
  maps\mp\_utility::_unsetperk("specialty_pistoldeath");
}

setuav() {
}

unsetuav() {
}

setstoppingpower() {}

watchstoppingpowerkill() {}

unsetstoppingpower() {}

setjuiced(var_0, var_1, var_2) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("end_game");
  self.isjuiced = 1;

  if(!isDefined(var_0))
    var_0 = 1.25;

  if(level.splitscreen) {
    var_3 = 56;
    var_4 = 21;
  } else {
    var_3 = 80;
    var_4 = 32;
  }

  if(!isDefined(var_1))
    var_1 = 7;

  if(!isDefined(var_2) || var_2 == 1) {
    self.juicedtimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall", 1.0);
    self.juicedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, var_3);
    self.juicedtimer settimer(var_1);
    self.juicedtimer.color = (0.8, 0.8, 0.0);
    self.juicedtimer.archived = 0;
    self.juicedtimer.foreground = 1;
    self.juicedicon = maps\mp\gametypes\_hud_util::createicon(level.specialty_juiced_icon, var_4, var_4);
    self.juicedicon.alpha = 0;
    self.juicedicon maps\mp\gametypes\_hud_util::setparent(self.juicedtimer);
    self.juicedicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "TOP");
    self.juicedicon.archived = 1;
    self.juicedicon.sort = 1;
    self.juicedicon.foreground = 1;
    self.juicedicon fadeovertime(1.0);
    self.juicedicon.alpha = 0.85;
  }

  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  wait(var_1 - 2);

  if(isDefined(self.juicedicon)) {
    self.juicedicon fadeovertime(2.0);
    self.juicedicon.alpha = 0.0;
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer fadeovertime(2.0);
    self.juicedtimer.alpha = 0.0;
  }

  wait 2;
  self unsetjuiced();
}

unsetjuiced() {
  if(isDefined(self.juicedicon))
    self.juicedicon destroy();

  if(isDefined(self.juicedtimer))
    self.juicedtimer destroy();

  self.isjuiced = undefined;
  self notify("unset_juiced");
}

unsetjuicedonride() {
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("game_ended");

  for(;;) {
    wait 0.05;

    if(maps\mp\_utility::isusingremote()) {
      self thread unsetjuiced();
      break;
    }
  }
}

unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  common_scripts\utility::waittill_any("death", "faux_spawn");
  self thread unsetjuiced();
}

setlightarmorhp(var_0) {
  if(isDefined(var_0)) {
    self.lightarmorhp = var_0;

    if(isplayer(self) && isDefined(self.maxlightarmorhp) && self.maxlightarmorhp > 0) {
      var_1 = clamp(self.lightarmorhp / self.maxlightarmorhp, 0, 1);
      self setclientomnvar("ui_light_armor_percent", var_1);
    }
  } else {
    self.lightarmorhp = undefined;
    self.maxlightarmorhp = undefined;
    self setclientomnvar("ui_light_armor_percent", 0);
  }
}

setlightarmor(var_0) {
  self notify("give_light_armor");

  if(isDefined(self.lightarmorhp))
    unsetlightarmor();

  thread removelightarmorondeath();
  thread removelightarmoronmatchend();

  if(isDefined(var_0))
    self.maxlightarmorhp = var_0;
  else
    self.maxlightarmorhp = 150;

  setlightarmorhp(self.maxlightarmorhp);
}

removelightarmorondeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");
  self waittill("death");
  unsetlightarmor();
}

unsetlightarmor() {
  setlightarmorhp(undefined);
  self notify("remove_light_armor");
}

removelightarmoronmatchend() {
  self endon("disconnect");
  self endon("remove_light_armor");
  level common_scripts\utility::waittill_any("round_end_finished", "game_ended");
  thread unsetlightarmor();
}

haslightarmor() {
  return isDefined(self.lightarmorhp) && self.lightarmorhp > 0;
}