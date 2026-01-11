/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_rcbomb.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  PreCacheModel("t5_veh_rcbomb_allies");
  PreCacheModel("t5_veh_rcbomb_axis");
  PrecacheVehicle("rc_car_medium_mp");
  PreCacheRumble("rcbomb_engine_stutter");
  PreCacheRumble("rcbomb_slide");
  loadTreadFx("dust");
  loadTreadFx("concrete");
  loadTreadFx("snow");
  loadfx("weapon/grenade/fx_spark_disabled_rc_car");
  loadfx("vehicle/light/fx_rcbomb_blinky_light");
  loadfx("vehicle/light/fx_rcbomb_solid_light");
  loadfx("vehicle/light/fx_rcbomb_light_green_os");
  loadfx("vehicle/light/fx_rcbomb_light_red_os");
  maps\mp\_treadfx::preloadtreadfx("rc_car_medium_mp");
  level._effect["rcbombexplosion"] = loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
  car_size = GetDvar(#"scr_rcbomb_car_size");
  if(car_size == "") {
    SetDvar("scr_rcbomb_car_size", "1");
  }
  if(GetDvar(#"scr_rcbomb_fadeIn_delay") == "") {
    SetDvar("scr_rcbomb_fadeIn_delay", "0.25");
  }
  if(GetDvar(#"scr_rcbomb_fadeIn_timeIn") == "") {
    SetDvar("scr_rcbomb_fadeIn_timeIn", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_fadeIn_timeBlack") == "") {
    SetDvar("scr_rcbomb_fadeIn_timeBlack", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_fadeIn_timeOut") == "") {
    SetDvar("scr_rcbomb_fadeIn_timeOut", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_fadeOut_delay") == "") {
    SetDvar("scr_rcbomb_fadeOut_delay", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_fadeOut_timeIn") == "") {
    SetDvar("scr_rcbomb_fadeOut_timeIn", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_fadeOut_timeBlack") == "") {
    SetDvar("scr_rcbomb_fadeOut_timeBlack", "0.25");
  }
  if(GetDvar(#"scr_rcbomb_fadeOut_timeOut") == "") {
    SetDvar("scr_rcbomb_fadeOut_timeOut", "0.5");
  }
  if(GetDvar(#"scr_rcbomb_notimeout") == "") {
    SetDvar("scr_rcbomb_notimeout", "0");
  }
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowrcbomb")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("rcbomb_mp", "rcbomb_mp", "killstreak_rcbomb", "rcbomb_used", ::useKillstreakRCBomb);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("rcbomb_mp", &"KILLSTREAK_EARNED_RCBOMB", &"KILLSTREAK_RCBOMB_NOT_AVAILABLE", &"KILLSTREAK_RCBOMB_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("rcbomb_mp", "mpl_killstreak_rcbomb", "kls_rcbomb_used", "", "kls_rcbomb_enemy", "", "kls_rcbomb_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("rcbomb_mp", "scr_givercbomb");
    maps\mp\gametypes\_hardpoints::allowKillstreakAssists("rcbomb_mp", true);
  }
  level thread trigger_monitor_init();
}
loadTreadFx(type) {
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type);
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_drift");
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_peel");
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_first_person");
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_reverse");
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_trail");
  loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_slow");
}
useKillstreakRCBomb(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false) {
    return false;
  }
  if(!self IsOnGround()) {
    self iPrintLnBold(&"KILLSTREAK_RCBOMB_NOT_PLACABLE");
    return false;
  }
  placement = self.rcbombPlacement;
  if(!isDefined(placement)) {
    placement = maps\mp\_rcbomb::getRCBombPlacement();
  }
  if(!isDefined(placement)) {
    self iPrintLnBold(&"KILLSTREAK_RCBOMB_NOT_PLACABLE");
    return false;
  }
  self thread maps\mp\gametypes\_hud::fadeToBlackForXSec(GetDvarFloat(#"scr_rcbomb_fadeIn_delay"), GetDvarFloat(#"scr_rcbomb_fadeIn_timeIn"), GetDvarFloat(#"scr_rcbomb_fadeIn_timeBlack"), GetDvarFloat(#"scr_rcbomb_fadeIn_timeOut"));
  ret = self useRCBomb(placement);
  if(!isDefined(ret) && level.gameEnded) {
    ret = true;
  }
  else if(!isDefined(ret)) {
    ret = false;
  }
  return ret;
}
spawnRCBomb(placement, team) {
  car_size = GetDvar(#"scr_rcbomb_car_size");
  model = "t5_veh_rcbomb_allies";
  enemymodel = "t5_veh_rcbomb_axis";
  death_model = "t5_veh_rcbomb_allies";
  car = "rc_car_medium_mp";
  vehicle = SpawnVehicle(
    model,
    "rcbomb",
    car,
    placement.origin,
    placement.angles);
  vehicle MakeVehicleUnusable();
  vehicle.death_model = death_model;
  vehicle.allowFriendlyFireDamageOverride = ::RCCarAllowFriendlyFireDamage;
  vehicle setEnemyModel(enemymodel);
  vehicle SetOwner(self);
  vehicle SetVehicleTeam(team);
  vehicle.team = team;
  maps\mp\_treadfx::loadtreadfx(vehicle);
  vehicle maps\mp\gametypes\_spawning::create_rcbomb_influencers(team);
  return vehicle;
}
getRCBombPlacement() {
  return calculateSpawnOrigin(self.origin, self.angles);
}
givePlayerControlOfRCBomb() {
  self endon("disconnect");
  level endon("game_ended");
  self thread maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("rcbomb_mp", self.team);
  self maps\mp\gametypes\_persistence::statAdd("RCBOMB_USED", 1, false);
  level.globalKillstreaksCalled++;
  self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_rcbomb", 1, "used");
  xpAmount = maps\mp\gametypes\_hardpoints::getXPAmountForKillstreak("rcbomb_mp");
  self thread maps\mp\gametypes\_rank::giveRankXP("medal", xpAmount);
  self freeze_player_controls(false);
  self.rcbomb usevehicle(self, 0);
  self thread playerDisconnectWaiter(self.rcbomb);
  self thread carDetonateWaiter(self.rcbomb);
  self thread exitCarWaiter(self.rcbomb);
  self thread GameEndWatcher(self.rcbomb);
  self thread changeTeamWaiter(self.rcbomb);
  self.rcbomb thread maps\mp\_flashgrenades::monitorRCBombFlash();
  self thread carTimer(self.rcbomb);
  self waittill("rcbomb_done");
}
useRCBomb(placement) {
  self endon("disconnect");
  level endon("game_ended");
  hardpointtype = "rcbomb_mp";
  maps\mp\gametypes\_globallogic_utils::WaitTillSlowProcessAllowed();
  if(!isDefined(self) || !isAlive(self) || (self IsRemoteControlling())) {
    IPrintLnBold("EXITING");
    return false;
  }
  if(!isDefined(self.rcbomb)) {
    self.rcbomb = self spawnRCBomb(placement, self.team);
    self.rcbomb thread carCleanupWaiter(self.rcbomb);
    self.rcbomb.team = self.team;
    if(!isDefined(self.rcbomb)) {
      return false;
    }
    self maps\mp\gametypes\_weaponobjects::addWeaponObjectToWatcher("rcbomb", self.rcbomb);
  }
  if(self maps\mp\_killstreakrules::killstreakStart(hardpointtype, self.team, undefined, false) == false) {
    return false;
  }
  self.enteringVehicle = true;
  self thread updateKillstreakOnDisconnect();
  self thread updateKillstreakOnDeletion(self.team);
  self freeze_player_controls(true);
  wait(0.9);
  if(!isDefined(self) || !IsAlive(self) || !isDefined(self.rcbomb)) {
    if(isDefined(self)) {
      self.enteringVehicle = false;
      self notify("weapon_object_destroyed");
    }
    return false;
  }
  self thread givePlayerControlOfRCBomb();
  self.rcbomb thread watchForScramblers();
  self.killstreak_waitamount = 30000;
  self.enteringVehicle = false;
  self StopShellshock();
  if(isDefined(level.killstreaks[hardpointType]) && isDefined(level.killstreaks[hardpointType].inboundtext)) {
    level thread maps\mp\_popups::DisplayKillstreakTeamMessageToAll(hardpointType, self);
  }
  self updateRulesOnEnd();
  return true;
}
watchForScramblers() {
  self endon("death");
  while(true) {
    scrambled = self GetClientFlag(level.const_flag_stunned);
    shouldScramble = false;
    players = level.players;
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i]) || !isDefined(players[i].scrambler)) {
        continue;
      }
      player = players[i];
      scrambler = player.scrambler;
      if(level.teambased && self.team == player.team) {
        continue;
      }
      if(!level.teambased && self.owner == player) {
        continue;
      }
      if(DistanceSquared(scrambler.origin, self.origin) < level.scramblerInnerRadiusSq) {
        shouldScramble = true;
        break;
      }
    }
    if(shouldScramble == true && scrambled == false) {
      self SetClientFlag(level.const_flag_stunned);
    } else if(shouldScramble == false && scrambled == true) {
      self ClearClientFlag(level.const_flag_stunned);
    }
    wait_delay = RandomFloatRange(0.25, 0.5);
    wait(wait_delay);
  }
}
updateRulesOnEnd() {
  team = self.rcbomb.team;
  self endon("disconnect");
  self waittill("rcbomb_done");
  maps\mp\_killstreakrules::killstreakStop("rcbomb_mp", team);
}
updateKillstreakOnDisconnect() {
  team = self.rcbomb.team;
  self endon("rcbomb_done");
  self waittill("disconnect");
  maps\mp\_killstreakrules::killstreakStop("rcbomb_mp", team);
}
updateKillstreakOnDeletion(team) {
  self endon("disconnect");
  self endon("rcbomb_done");
  self waittill("weapon_object_destroyed");
  maps\mp\_killstreakrules::killstreakStop("rcbomb_mp", team);
  if(isDefined(self.rcbomb)) {
    self.rcbomb delete();
  }
}
carDetonateWaiter(vehicle) {
  self endon("disconnect");
  vehicle endon("death");
  watcher = maps\mp\gametypes\_weaponobjects::getWeaponObjectWatcher("rcbomb");
  if(isDefined(level.disableRCBombTrigger) && level.disableRCBombTrigger) {
    watcher.disableDetonation = true;
  }
  while((!isDefined(vehicle.forceDetonation) || !vehicle.forceDetonation) && ((!self attackbuttonpressed()) || (isDefined(level.disableRCBombTrigger) && level.disableRCBombTrigger))) {
    wait 0.05;
  }
  watcher.disableDetonation = false;
  watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(vehicle, 0);
  self thread maps\mp\gametypes\_hud::fadeToBlackForXSec(GetDvarFloat(#"scr_rcbomb_fadeOut_delay"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeIn"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeBlack"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeOut"));
}
playerDisconnectWaiter(vehicle) {
  vehicle endon("death");
  self endon("rcbomb_done");
  self waittill("disconnect");
  vehicle Delete();
}
GameEndWatcher(vehicle) {
  vehicle endon("death");
  self endon("rcbomb_done");
  level waittill("game_ended");
  watcher = maps\mp\gametypes\_weaponobjects::getWeaponObjectWatcher("rcbomb");
  watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(vehicle, 0);
  self thread maps\mp\gametypes\_hud::fadeToBlackForXSec(GetDvarFloat(#"scr_rcbomb_fadeOut_delay"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeIn"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeBlack"), GetDvarFloat(#"scr_rcbomb_fadeOut_timeOut"));
}
exitCarWaiter(vehicle) {
  self endon("disconnect");
  self waittill("exit_vehicle");
  self notify("rcbomb_done");
}
changeTeamWaiter(vehicle) {
  self endon("disconnect");
  self endon("rcbomb_done");
  vehicle endon("death");
  self waittill_either("joined_team", "joined_spectators");
  vehicle.owner Unlink();
  vehicle Delete();
}
carDeathWaiter(vehicle) {
  self endon("disconnect");
  self endon("rcbomb_done");
  self waittill("death");
  maps\mp\gametypes\_hardpoints::removeUsedKillstreak("rcbomb_mp");
  self notify("rcbomb_done");
}
carCleanupWaiter(vehicle) {
  self endon("disconnect");
  self waittill("death");
  self.rcbomb = undefined;
}
carTimer(vehicle) {
  self endon("disconnect");
  vehicle endon("death");
  if(getDvarIntDefault(#"scr_rcbomb_notimeout", 0)) {
    return;
  }
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(20);
  vehicle SetClientFlag(level.const_flag_countdown);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(6);
  vehicle SetClientFlag(level.const_flag_timeout);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(4);
  watcher = maps\mp\gametypes\_weaponobjects::getWeaponObjectWatcher("rcbomb");
  watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(vehicle, 0);
}
detonateIfTouchingSphere(origin, radius) {
  if(DistanceSquared(self.origin, origin) < radius * radius) {
    self rcbomb_force_explode();
  }
}
detonateAllIfTouchingSphere(origin, radius) {
  rcbombs = getEntArray("rcbomb", "targetname");
  for(index = 0; index < rcbombs.size; index++) {
    rcbombs[index] detonateIfTouchingSphere(origin, radius);
  }
}
blowup(attacker) {
  self.owner endon("disconnect");
  self endon("death");
  explosionOrigin = self.origin;
  explosionAngles = self.angles;
  if(!isDefined(attacker)) {
    attacker = self.owner;
  }
  origin = self.origin + (0, 0, 10);
  radius = 256;
  min_damage = 25;
  max_damage = 350;
  self radiusDamage(origin, radius, max_damage, min_damage, attacker, "MOD_EXPLOSIVE", "rcbomb_mp");
  PhysicsExplosionSphere(origin, radius, radius, 1, max_damage, min_damage);
  maps\mp\gametypes\_shellshock::rcbomb_earthquake(origin);
  playsoundatposition("mpl_sab_exp_suitcase_bomb_main", self.origin);
  playFX(level._effect["rcbombexplosion"], explosionOrigin, (0, randomfloat(360), 0));
  self setModel(self.death_model);
  self Hide();
  if(attacker != self.owner) {
    value = maps\mp\gametypes\_rank::getScoreInfoValue("rcbombdestroy");
    attacker thread maps\mp\gametypes\_rank::giveRankXP("rcbombdestroy", value);
    attacker maps\mp\_medals::destroyerRCBomb();
    attacker maps\mp\_properks::destroyedKillstreak();
    if(isDefined(attacker.weaponUsedToDamage)) {
      weapon = attacker.weaponUsedToDamage;
      weaponStatName = "destroyed";
      switch (weapon) {
        case "auto_tow_mp":
        case "tow_turret_mp":
        case "tow_turret_drop_mp":
          weaponStatName = "kills";
          break;
      }
      attacker maps\mp\gametypes\_globallogic_score::setWeaponStat(weapon, 1, weaponStatName);
      level.globalKillstreaksDestroyed++;
      attacker maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_rcbomb", 1, "destroyed");
    }
  }
  wait(1);
  if(isDefined(self.neverDelete) && self.neverDelete) {
    return;
  }
  self.owner Unlink();
  self.owner.killstreak_waitamount = undefined;
  self Delete();
}
RCCarAllowFriendlyFireDamage(eInflictor, eAttacker, sMeansOfDeath, sWeapon) {
  if(isDefined(eAttacker) && eAttacker == self.owner) {
    return true;
  }
  if(isDefined(eInflictor) && eInflictor islinkedto(self)) {
    return true;
  }
  return false;
}
getPlacementStartHeight() {
  startheight = 50;
  switch (self GetStance()) {
    case "crouch":
      startheight = 30;
      break;
    case "prone":
      startheight = 15;
      break;
  }
  return startheight;
}
calculateSpawnOrigin(origin, angles) {
  distance_from_player = 70;
  startheight = getPlacementStartHeight();
  mins = (-5, -5, 0);
  maxs = (5, 5, 10);
  startPoints = [];
  startAngles = [];
  wheelCounts = [];
  testCheck = [];
  largestCount = 0;
  largestCountIndex = 0;
  testangles = [];
  testangles[0] = (0, 0, 0);
  testangles[1] = (0, 20, 0);
  testangles[2] = (0, -20, 0);
  testangles[3] = (0, 45, 0);
  testangles[4] = (0, -45, 0);
  heightoffset = 5;
  for(i = 0; i < testangles.size; i++) {
    startAngles[i] = (0, angles[1], 0);
    startPoint = origin + vector_scale(anglesToForward(startAngles[i] + testangles[i]), distance_from_player);
    endPoint = startPoint - (0, 0, 100);
    startPoint = startPoint + (0, 0, startheight);
    mask = level.PhysicsTraceMaskPhysics | level.PhysicsTraceMaskVehicle;
    trace = physicstrace(startPoint, endPoint, mins, maxs, self, mask);
    if(isDefined(trace["entity"]) && IsPlayer(trace["entity"])) {
      continue;
    }
    startPoints[i] = trace["position"] + (0, 0, heightoffset);
    wheelCounts[i] = testWheelLocations(startPoints[i], startAngles[i], heightoffset);
    if(positionWouldTelefrag(startPoints[i])) {
      continue;
    }
    if(largestCount < wheelCounts[i]) {
      largestCount = wheelCounts[i];
      largestCountIndex = i;
    }
    testCheck[i] = false;
    if(wheelCounts[i] >= 3) {
      testCheck[i] = true;
      if(testSpawnOrigin(startPoints[i], startAngles[i])) {
        placement = spawnStruct();
        placement.origin = startPoints[i];
        placement.angles = startAngles[i];
        return placement;
      }
    }
  }
  for(i = 0; i < testangles.size; i++) {
    if(!testCheck[i]) {
      if(wheelCounts[i] >= 2) {
        if(testSpawnOrigin(startPoints[i], startAngles[i])) {
          placement = spawnStruct();
          placement.origin = startPoints[i];
          placement.angles = startAngles[i];
          return placement;
        }
      }
    }
  }
  return undefined;
}
testWheelLocations(origin, angles, heightoffset) {
  forward = 13;
  side = 10;
  wheels = [];
  wheels[0] = (forward, side, 0);
  wheels[1] = (forward, -1 * side, 0);
  wheels[2] = (-1 * forward, -1 * side, 0);
  wheels[3] = (-1 * forward, side, 0);
  height = 5;
  touchCount = 0;
  yawangles = (0, angles[1], 0);
  for(i = 0; i < 4; i++) {
    wheel = RotatePoint(wheels[i], yawangles);
    startPoint = origin + wheel;
    endPoint = startPoint + (0, 0, (-1 * height) - heightoffset);
    startPoint = startPoint + (0, 0, height - heightoffset);
    trace = bulletTrace(startPoint, endPoint, false, self);
    if(trace["fraction"] < 1) {
      touchCount++;
      rcbomb_debug_line(startPoint, endPoint, (1, 0, 0));
    } else {
      rcbomb_debug_line(startPoint, endPoint, (0, 0, 1));
    }
  }
  return touchCount;
}
testSpawnOrigin(origin, angles) {
  liftedorigin = origin + (0, 0, 5);
  size = 12;
  height = 15;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  absmins = liftedorigin + mins;
  absmaxs = liftedorigin + maxs;
  if(BoundsWouldTelefrag(absmins, absmaxs)) {
    rcbomb_debug_box(liftedorigin, mins, maxs, (1, 0, 0));
    return false;
  } else {
    rcbomb_debug_box(liftedorigin, mins, maxs, (0, 0, 1));
  }
  startheight = getPlacementStartHeight();
  mask = level.PhysicsTraceMaskPhysics | level.PhysicsTraceMaskVehicle | level.PhysicsTraceMaskWater;
  trace = physicstrace(liftedorigin, (origin + (0, 0, 1)), mins, maxs, self, mask);
  if(trace["fraction"] < 1) {
    rcbomb_debug_box(trace["position"], mins, maxs, (1, 0, 0));
    return false;
  } else {
    rcbomb_debug_box((origin + (0, 0, 1)), mins, maxs, (0, 1, 0));
  }
  size = 2.5;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  sweeptrace = physicstrace((self.origin + (0, 0, startheight)), liftedorigin, mins, maxs, self, mask);
  if(sweeptrace["fraction"] < 1) {
    rcbomb_debug_box(sweeptrace["position"], mins, maxs, (1, 0, 0));
    return false;
  }
  return true;
}
trigger_monitor_init() {
  hurt_triggers = getEntArray("trigger_hurt", "classname");
  spread_array_thread(hurt_triggers, ::trigger_monitor);
}
trigger_monitor() {
  while(1) {
    self waittill("trigger", ent);
    if(isDefined(ent.targetname) && ent.targetname == "rcbomb") {
      ent rcbomb_force_explode();
    }
    wait .1;
  }
}
rcbomb_force_explode() {
  self endon("death");
  assert(self.targetname == "rcbomb");
  while(!isDefined(self getseatoccupant(0))) {
    wait(0.1);
  }
  self DoDamage(10, self.origin + (0, 0, 10), self.owner, self.owner, 0, "MOD_EXPLOSIVE");
}
rcbomb_debug_box(origin, mins, maxs, color) {}
rcbomb_debug_line(start, end, color) {}