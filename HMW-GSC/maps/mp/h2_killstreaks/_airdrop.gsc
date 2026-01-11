#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\utility;

/*QUAKED mp_airdrop_point (1.0 0.5 0.0) (-36 -12 0) (36 12 20)
An airdrop can land here.*/

h2_getTeamCrateModel(team) {
  teamName = game[team];

  switch (teamName) {
    case "opfor":
      return "com_plasticcase_arab";

    case "marines":
    case "rangers":
      return "com_plasticcase_rangers";

    case "sas":
    case "tf141":
      return "com_plasticcase_taskforce141";

    case "russian":
      return "com_plasticcase_ussr";

    case "seals":
      return "com_plasticcase_seals";

    case "militia":
      return "com_plasticcase_militia";

    default:
      return "tag_origin";
  }
}

h2_setHeadIcon(showTo, icon, offset, width, height) {
  if(!isDefined(self.entityHeadIcons)) {
    self.entityHeadIcons = [];
  }

  if(!isPlayer(showTo) && showTo == "none") {
    foreach(key, headIcon in self.entityHeadIcons) {
      // TODO: remove and fix properly after ship
      if(isDefined(headIcon)) {
        headIcon destroy();
      }

      self.entityHeadIcons[key] = undefined;
    }

    return;
  }

  if(isPlayer(showTo)) {
    if(isDefined(self.entityHeadIcons[showTo.guid])) {
      self.entityHeadIcons[showTo.guid] destroy();
      self.entityHeadIcons[showTo.guid] = undefined;
    }

    if(icon == "") {
      return;
    }

    // remove from team or we'd have two icons
    if(isDefined(self.entityHeadIcons[showTo.team])) {
      self.entityHeadIcons[showTo.team] destroy();
      self.entityHeadIcons[showTo.team] = undefined;
    }

    headIcon = newClientHudElem(showTo);
    self.entityHeadIcons[showTo.guid] = headIcon;
  } else {
    assert(showTo == "axis" || showTo == "allies");
    assert(level.teamBased);

    if(isDefined(self.entityHeadIcons[showTo])) {
      self.entityHeadIcons[showTo] destroy();
      self.entityHeadIcons[showTo] = undefined;
    }

    if(icon == "") {
      return;
    }

    foreach(key, hudIcon in self.entityHeadIcons) {
      if(key == "axis" || key == "allies") {
        continue;
      }

      player = getPlayerForGuid(key);
      if(player.team == showTo) {
        self.entityHeadIcons[key] destroy();
        self.entityHeadIcons[key] = undefined;
      }
    }

    headIcon = newTeamHudElem(showTo);
    self.entityHeadIcons[showTo] = headIcon;
  }

  if(!isDefined(width) || !isDefined(height)) {
    width = 10;
    height = 10;
  }

  headIcon.archived = true;
  headIcon.x = self.origin[0] + offset[0];
  headIcon.y = self.origin[1] + offset[1];
  headIcon.z = self.origin[2] + offset[2];
  headIcon.alpha = 0.85;
  headIcon setShader(icon, width, height);
  if(isPlayer(showTo)) {
    headIcon setWaypoint(true, true, false);
  }
  else {
    headIcon setWaypoint(true, true, false);
  }

  self thread maps\mp\_entityheadicons::destroyIconsOnDeath();
  if(isPlayer(showTo)) {
    headIcon thread maps\mp\_entityheadicons::destroyOnOwnerDisconnect(showTo);
  }
}

init() {
  precacheVehicle("littlebird_mp");
  precacheModel("com_plasticcase_friendly");
  precacheModel("com_plasticcase_enemy");
  precacheModel("vehicle_little_bird_armed");
  precacheModel("vehicle_ac130_low_mp");
  precacheModel("wpn_h1_grenade_smoke_vm");
  //precacheModel( "sentry_minigun_folded" );

  precacheModel(h2_getTeamCrateModel("allies"));
  precacheModel(h2_getTeamCrateModel("axis"));

  precacheShader(maps\mp\gametypes\_teams::getTeamHudIcon("allies"));
  precacheShader(maps\mp\gametypes\_teams::getTeamHudIcon("axis"));
  precacheShader("waypoint_ammo_friendly");
  precacheShader("cb_compass_objpoint_ammo_friendly");
  precacheShader("cb_compass_objpoint_ammo_enemy");
  precacheMiniMapIcon("compass_objpoint_c130_friendly");
  precacheMiniMapIcon("compass_objpoint_c130_enemy");

  level.airDropCrates = getEntArray("care_package", "targetname");
  level.oldAirDropCrates = getEntArray("airdrop_crate", "targetname");
  level.h2_airdrop_signal_fx = loadfx("fx/smoke/signal_smoke_red_estate");

  if(!level.airDropCrates.size) {
    level.airDropCrates = level.oldAirDropCrates;

    switch (getdvar("mapname")) {
      case "mp_backlot":
      case "mp_bloc":
      case "mp_bog":
      case "mp_bog_summer":
      case "mp_broadcast":
      case "mp_carentan":
      case "mp_cargoship":
      case "mp_citystreets":
      case "mp_convoy":
      case "mp_countdown":
      case "mp_crash":
      case "mp_crash_snow":
      case "mp_creek":
      case "mp_crossfire":
      case "mp_farm":
      case "mp_farm_spring":
      case "mp_killhouse":
      case "mp_overgrown":
      case "mp_pipeline":
      case "mp_shipment":
      case "mp_showdown":
      case "mp_strike":
      case "mp_vacant":
        level.airDropCrateCollision = getent("patchclip_player_32_32_32", "targetname");
        break;
      default:
        if(level.airDropCrates.size) {
          level.airDropCrateCollision = getEnt(level.airDropCrates[0].target, "targetname");
        }

        break;
    }
  } else {
    foreach(crate in level.oldAirDropCrates) {
    crate delete();
    }

    if(level.airDropCrates.size) {
      level.airDropCrateCollision = getEnt(level.airDropCrates[0].target, "targetname");
    }

    level.oldAirDropCrates = getEntArray("airdrop_crate", "targetname");
  }

  if(level.airDropCrates.size) {
    foreach(crate in level.AirDropCrates) {
    crate delete();
    }
  }

  level.killStreakFuncs["airdrop_marker_mp"] = ::tryUseAirdrop;

  //level.killStreakFuncs["airdrop_predator_missile"] = ::tryUseAirdropPredatorMissile;
  //level.killStreakFuncs["airdrop_sentry_minigun"] = ::tryUseAirdropSentryMinigun;
  level.killStreakFuncs["airdrop_mega_marker_mp"] = ::tryUseMegaAirdrop;

  level.littleBirds = 0;
  level.littlebird = [];

  level.crateTypes = [];

  //			Drop Type			Type						Weight		Function					
  addCrateType("airdrop_marker_mp", "ammo", getDvarInt("scr_airdrop_ammo", 17), ::ammoCrateThink);
  addCrateType("airdrop_marker_mp", "radar_mp", getDvarInt("scr_airdrop_uav", 17), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "counter_radar_mp", getDvarInt("scr_airdrop_counter_uav", 15), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "sentry_mp", getDvarInt("scr_airdrop_sentry", 12), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "predator_mp", getDvarInt("scr_airdrop_predator_missile", 12), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "airstrike_mp", getDvarInt("scr_airdrop_precision_airstrike", 11), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "harrier_airstrike_mp", getDvarInt("scr_airdrop_harrier_airstrike", 7), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "helicopter_mp", getDvarInt("scr_airdrop_helicopter", 7), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "pavelow_mp", getDvarInt("scr_airdrop_helicopter_flares", 5), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "stealth_airstrike_mp", getDvarInt("scr_airdrop_stealth_airstrike", 5), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "chopper_gunner_mp", getDvarInt("scr_airdrop_helicopter_minigun", 3), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "ac130_mp", getDvarInt("scr_airdrop_ac130", 3), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "emp_mp", getDvarInt("scr_airdrop_emp", 1), ::killstreakCrateThink);
  addCrateType("airdrop_marker_mp", "nuke_mp", getDvarInt("scr_airdrop_nuke", 0), ::killstreakCrateThink);

  addCrateType("airdrop_mega_marker_mp", "ammo", getDvarInt("scr_airdrop_mega_ammo", 12), ::ammoCrateThink);
  addCrateType("airdrop_mega_marker_mp", "radar_mp", getDvarInt("scr_airdrop_mega_uav", 12), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "counter_radar_mp", getDvarInt("scr_airdrop_mega_counter_uav", 16), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "sentry_mp", getDvarInt("scr_airdrop_mega_sentry", 16), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "predator_mp", getDvarInt("scr_airdrop_mega_predator_missile", 14), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "airstrike_mp", getDvarInt("scr_airdrop_mega_precision_airstrike", 10), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "harrier_airstrike_mp", getDvarInt("scr_airdrop_mega_harrier_airstrike", 5), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "helicopter_mp", getDvarInt("scr_airdrop_mega_helicopter", 5), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "pavelow_mp", getDvarInt("scr_airdrop_mega_helicopter_flares", 3), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "stealth_airstrike_mp", getDvarInt("scr_airdrop_mega_stealth_airstrike", 3), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "chopper_gunner_mp", getDvarInt("scr_airdrop_mega_helicopter_minigun", 2), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "ac130_mp", getDvarInt("scr_airdrop_mega_ac130", 2), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "emp_mp", getDvarInt("scr_airdrop_mega_emp", 0), ::killstreakCrateThink);
  addCrateType("airdrop_mega_marker_mp", "nuke_mp", getDvarInt("scr_airdrop_mega_nuke", 0), ::killstreakCrateThink);

  //addCrateType( "airdrop_sentry_minigun",	"sentry", 			0,			::killstreakCrateThink );

  //addCrateType( "nuke_drop",		"nuke", 					100,		::nukeCrateThink );

  // generate the max weighted value
  foreach(dropType, crateTypes in level.crateTypes) {
    level.crateMaxVal[dropType] = 0;
    foreach(crateType, crateWeight in level.crateTypes[dropType]) {
      if(!crateWeight) {
        continue;
      }

      level.crateMaxVal[dropType] += crateWeight;
      level.crateTypes[dropType][crateType] = level.crateMaxVal[dropType];
    }
  }

  tdmSpawns = getEntArray("mp_tdm_spawn", "classname");
  lowSpawn = undefined;

  foreach(lspawn in tdmSpawns) {
    if(!isDefined(lowSpawn) || lspawn.origin[2] < lowSpawn.origin[2]) {
      lowSpawn = lspawn;
    }
  }
  level.lowSpawn = lowSpawn;
}

addCrateType(dropType, crateType, crateWeight, crateFunc) {
  level.crateTypes[dropType][crateType] = crateWeight;
  level.crateFuncs[dropType][crateType] = crateFunc;
}

getRandomCrateType(dropType) {
  value = randomInt(level.crateMaxVal[dropType]);

  selectedCrateType = undefined;
  foreach(crateType, crateWeight in level.crateTypes[dropType]) {
    if(!crateWeight) {
      continue;
    }

    selectedCrateType = crateType;

    if(crateWeight > value) {
      break;
    }
  }

  return (selectedCrateType);
}

getCrateTypeForDropType(dropType) {
  switch (dropType) {
    //case "airdrop_sentry_minigun":
    //	return "sentry";
    //case "airdrop_predator_missile":
    //	return "predator_missile";
    case "airdrop_marker_mp":
      return getRandomCrateType("airdrop_marker_mp");
    case "airdrop_mega_marker_mp":
      return getRandomCrateType("airdrop_mega_marker_mp");
      //case "nuke_drop":
      //	return "nuke";
    default:
      return getRandomCrateType("airdrop_marker_mp");

  }
}

/**********************************************************
 *		 Helper/Debug functions
***********************************************************/

drawLine(start, end, timeSlice) {
  drawTime = int(timeSlice * 20);
  for(time = 0; time < drawTime; time++) {
    line(start, end, (1, 0, 0), false, 1);
    wait(0.05);
  }
}

/**********************************************************
 *		 Usage functions
***********************************************************/

tryUseAirdropPredatorMissile(lifeId, kID) {
  return (self tryUseAirdrop(lifeId, kID, "airdrop_predator_missile"));
}

tryUseAirdropSentryMinigun(lifeId, kID) {
  return (self tryUseAirdrop(lifeId, kID, "airdrop_sentry_minigun"));
}

tryUseMegaAirdrop(lifeId, kID) {
  return (self tryUseAirdrop(lifeId, kID, "airdrop_mega_marker_mp"));
}

tryUseAirdrop(lifeId, kID, dropType) {
  result = undefined;

  if(!isDefined(dropType)) {
    dropType = "airdrop_marker_mp";
  }

  if(!isDefined(self.pers["kIDs_valid"][kID])) {
    return true;
  }

  if(level.littleBirds >= 3 && dropType != "airdrop_mega_marker_mp") {
    self iprintlnbold(&"LUA_KS_UNAVAILABLE_AIRSPACE");
    return false;
  }

  if(isDefined(level.civilianJetFlyBy)) {
    self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(dropType != "airdrop_mega_marker_mp") {
    level.littleBirds++;
    self thread watchDisconnect();
  }

  result = self beginAirdropViaMarker(lifeId, kID, dropType);

  if((!isDefined(result) || !result) && isDefined(self.pers["kIDs_valid"][kID])) {
    self notify("markerDetermined");

    if(dropType != "airdrop_mega_marker_mp") {
      decrementLittleBirdCount();
    }

    return false;
  }

  if(dropType == "airdrop_mega_marker_mp") {
    thread teamPlayerCardSplash("callout_used_airdrop_mega", self);
  }

  self notify("markerDetermined");
  return true;
}

watchDisconnect() {
  self endon("markerDetermined");

  self waittill("disconnect");
  decrementLittleBirdCount();
  return;
}

/**********************************************************
 *		 Marker functions
***********************************************************/

beginAirdropViaMarker(lifeId, kID, dropType) {
  self endon("death");
  self endon("grenade_fire");
  self.airDropMarker = undefined;

  self thread watchAirDropMarkerUsage(dropType, kID);

  while(self isChangingWeapon()) {
    wait(0.05);
  }

  currentWeapon = self getCurrentWeapon();

  if(isAirdropMarker(currentWeapon)) {
    airdropMarkerWeapon = currentWeapon;
  }
  else {
    airdropMarkerWeapon = undefined;
  }

  while(isAirdropMarker(currentWeapon) /*|| currentWeapon == "none"*/ ) {
    self waittill("weapon_change", currentWeapon);

    if(isAirdropMarker(currentWeapon)) {
      airdropMarkerWeapon = currentWeapon;
    }
  }

  self notify("stopWatchingAirDropMarker");

  if(!isDefined(airdropMarkerWeapon)) {
    return false;
  }

  return (!(self getAmmoCount(airdropMarkerWeapon) && self hasWeapon(airdropMarkerWeapon)));
}

watchAirDropMarkerUsage(dropType, kID) {
  self notify("watchAirDropMarkerUsage");

  self endon("disconnect");
  self endon("watchAirDropMarkerUsage");
  self endon("stopWatchingAirDropMarker");

  level endon("game_ended");

  thread watchAirDropMarker(dropType, kID);

  for(;;) {
    self waittill("grenade_pullback", weaponName);

    if(!isAirdropMarker(weaponName)) {
      continue;
    }

    self _disableUsability();

    self beginAirDropMarkerTracking();
  }
}

watchAirDropMarker(dropType, kID) {
  self notify("watchAirDropMarker");

  self endon("watchAirDropMarker");
  self endon("spawned_player");
  self endon("disconnect");

  level endon("game_ended");

  for(;;) {
    self waittill("grenade_fire", airDropWeapon, weapname);

    if(!isAirdropMarker(weapname)) {
      continue;
    }

    if(!isDefined(self.pers["kIDs_valid"][kID])) {
      airDropWeapon delete();
      continue;
    }

    self.pers["kIDs_valid"][kID] = undefined;

    airDropWeapon thread airdropDetonateOnStuck();

    airDropWeapon.owner = self;
    airDropWeapon.weaponName = weapname;
    self.airDropMarker = airDropWeapon;

    airDropWeapon thread airDropMarkerActivate(dropType);
  }
}

beginAirDropMarkerTracking() {
  self notify("beginAirDropMarkerTracking");
  self endon("beginAirDropMarkerTracking");
  self endon("death");
  self endon("disconnect");

  self waittill_any("grenade_fire", "weapon_change");
  self _enableUsability();
}

airDropMarkerActivate(dropType) {
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");

  owner = self.owner;
  self waittill("explode", position);

  h2_signal_smoke = spawnFX(level.h2_airdrop_signal_fx, position);
  h2_signal_smoke thread maps\mp\_helicopter::deleteAfterTime(3);

  h2_signal_grenade = spawn("script_model", position);
  h2_signal_grenade setModel("wpn_h1_grenade_smoke_vm");
  h2_signal_grenade thread maps\mp\_helicopter::deleteAfterTime(10);

  TriggerFX(h2_signal_smoke);

  if(!isDefined(owner)) {
    return;
  }

  if(owner isEMPed()) {
    return;
  }

  if(dropType != "airdrop_mega_marker_mp") {
    owner maps\mp\_matchdata::logKillstreakEvent(dropType, position);
  }

  wait 0.05;

  if(dropType != "airdrop_mega_marker_mp") {
    level doFlyBy(owner, position, randomFloat(360), dropType);
  }
  else {
    level doC130FlyBy(owner, position, randomFloat(360), dropType);
  }
}

/**********************************************************
 *		 crate functions
***********************************************************/

initAirDropCrate() {
  self.inUse = false;
  self hide();

  if(isDefined(self.target)) {
    self.collision = getEnt(self.target, "targetname");
    self.collision notSolid();
  } else {
    self.collision = undefined;
  }
}

deleteOnOwnerDeath(owner) {
  wait(0.25);
  self linkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));

  owner waittill("death");

  self delete();
}

crateModelTeamUpdater(showForTeam) {
  self endon("death");
  level endon("game_ended");

  self hide();

  foreach(player in level.players) {
    if(player.team == showForTeam) {
      self showToPlayer(player);
    }
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == showForTeam) {
        self showToPlayer(player);
      }
    }
  }
}

createAirDropCrate(owner, dropType, crateType, startPos) {
  dropCrate = spawn("script_model", startPos);

  dropCrate.curProgress = 0;
  dropCrate.useTime = 0;
  dropCrate.useRate = 0;
  dropCrate.team = self.team;

  if(isDefined(owner)) {
    dropCrate.owner = owner;
  }
  else {
    dropCrate.owner = undefined;
  }

  dropCrate.crateType = crateType;
  dropCrate.dropType = dropType;
  dropCrate.targetname = "care_package";

  dropCrate setModel(h2_getTeamCrateModel(dropCrate.team));

  dropCrate.friendlyModel = spawn("script_model", startPos);
  dropCrate.friendlyModel setModel("com_plasticcase_friendly");
  dropCrate.enemyModel = spawn("script_model", startPos);
  dropCrate.enemyModel setModel("com_plasticcase_enemy");

  dropCrate.friendlyModel thread deleteOnOwnerDeath(dropCrate);
  dropCrate.friendlyModel thread crateModelTeamUpdater(dropCrate.team);

  dropCrate.enemyModel thread deleteOnOwnerDeath(dropCrate);
  dropCrate.enemyModel thread crateModelTeamUpdater(level.otherTeam[dropCrate.team]);

  dropCrate.inUse = false;

  if(isDefined(level.airDropCrateCollision)) {
    dropCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
  }

  return dropCrate;
}

crateSetupForUse(hintString, mode, icon) {
  self setCursorHint("HINT_NOICON");
  self setHintString(hintString);
  self makeUsable();
  self.mode = mode;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(curObjID, "invisible", (0, 0, 0));
  objective_position(curObjID, self.origin);
  objective_state(curObjID, "active");
  objective_icon(curObjID, "cb_compass_objpoint_ammo_friendly");
  self.objIdFriendly = curObjID;

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(curObjID, "invisible", (0, 0, 0));
  objective_position(curObjID, self.origin);
  objective_state(curObjID, "active");
  objective_icon(curObjID, "cb_compass_objpoint_ammo_enemy");
  self.objIdEnemy = curObjID;

  if(level.teamBased) {
    objective_team(self.objIdFriendly, self.team);
    objective_team(self.objIdEnemy, level.otherTeam[self.team]);

    self h2_setHeadIcon(self.team, icon, (0, 0, 24), 14, 14);
  } else {
    if(isDefined(self.owner)) {
      self h2_setHeadIcon(self.owner, icon, (0, 0, 24), 14, 14);
      objective_playerteam(self.objIdFriendly, self.owner getentitynumber());
      objective_playerenemyteam(self.objIdEnemy, self.owner getentitynumber());
    } else {
      objective_delete(self.objIdFriendly);
    }
  }
}

checkChange(team) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("joined_team");

    self setUnUsable(team);
    wait .25;
  }
}

setSelfAndEnemyUsable(owner) {
  foreach(player in level.players) {
    if(player != owner && player.team == self.team) {
      self disablePlayerUse(player);
    }
    else {
      self enablePlayerUse(player);
    }
  }

}

setUnUsable(team) {
  foreach(player in level.players) {
    if(team != player.team) {
      self disablePlayerUse(player);
    }
  }
}

dropTheCrate(dropPoint, dropType, lbHeight, dropImmediately, crateOverride, startPos) {
  dropCrate = [];
  self.owner endon("disconnect");

  if(!isDefined(crateOverride)) {
    crateType = getCrateTypeForDropType(dropType);
  }
  else {
    crateType = crateOverride;
  }

  dropCrate = createAirDropCrate(self.owner, dropType, crateType, startPos);

  if(dropType == "airdrop_mega_marker_mp" /*|| dropType == "nuke_drop"*/ ) {
    dropCrate LinkTo(self, "tag_ground", (64, 32, -128), (0, 0, 0));
  }
  else {
    dropCrate LinkTo(self, "tag_ground", (32, 0, 5), (0, 0, 0));
  }

  dropCrate.angles = (0, 0, 0);
  dropCrate show();
  dropSpeed = self.veh_speed;

  self waittill("drop_crate");

  dropCrate Unlink();
  dropCrate PhysicsLaunchServer((0, 0, 0), (0, 0, 0), 1200);
  dropCrate thread physicsWaiter(dropType, crateType);
}

physicsWaiter(dropType, crateType) {
  self waittill("physics_finished");

  self thread[[level.crateFuncs[dropType][crateType]]](dropType);
  level thread dropTimeOut(self, self.owner);

  /*
  if( abs(self.origin[2] - level.lowSpawn.origin[2]) > 3000 )
  {
  if( isDefined( self.objIdFriendly ) ) {
  _objective_delete( self.objIdFriendly );
  }

  if( isDefined( self.objIdEnemy ) ) {
  _objective_delete( self.objIdEnemy );
  }

  self delete();	
  }	
  */
}

//deletes if crate wasnt used after 90 seconds
dropTimeOut(dropCrate, owner) {
  dropCrate endon("death");

  if(dropCrate.dropType == "nuke_drop") {
    return;
  }

  dropCrate maps\mp\h2_killstreaks\_harrier::waitfor_duration_or_notify(90.0);

  while(dropCrate.curProgress != 0) {
    wait 1;
  }

  if(isDefined(dropcrate.objIdFriendly)) {
    _objective_delete(dropcrate.objIdFriendly);
  }

  if(isDefined(dropcrate.objIdEnemy)) {
    _objective_delete(dropcrate.objIdEnemy);
  }

  dropCrate delete();
}

getPathStart(coord, yaw) {
  pathRandomness = 100;
  lbHalfDistance = 15000;

  direction = (0, yaw, 0);

  startPoint = coord + vector_multiply(anglesToForward(direction), -1 * lbHalfDistance);
  startPoint += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);

  return startPoint;
}

getPathEnd(coord, yaw) {
  pathRandomness = 150;
  lbHalfDistance = 15000;

  direction = (0, yaw, 0);

  endPoint = coord + vector_multiply(anglesToForward(direction + (0, 90, 0)), lbHalfDistance);
  endPoint += ((randomfloat(2) - 1) * pathRandomness, (randomfloat(2) - 1) * pathRandomness, 0);

  return endPoint;
}

getFlyHeightOffset(dropSite) {
  lbFlyHeight = 850;

  heightEnt = GetEnt("airstrikeheight", "targetname");

  if(!isDefined(heightEnt)) //old system
  {
    println("NO DEFINED AIRSTRIKE HEIGHT SCRIPT_ORIGIN IN LEVEL");

      if(isDefined(level.airstrikeHeightScale)) {
        if(level.airstrikeHeightScale > 2) {
          lbFlyHeight = 1500;
          return (lbFlyHeight * (level.airStrikeHeightScale));
        }

        return (lbFlyHeight * level.airStrikeHeightScale + 256 + dropSite[2]);
      }
    else {
      return (lbFlyHeight + dropsite[2]);
    }
  } else {
    return heightEnt.origin[2];
  }

}

/**********************************************************
 *		 Helicopter Functions
***********************************************************/

doFlyBy(owner, dropSite, dropYaw, dropType, heightAdjustment) {
  flyHeight = self getFlyHeightOffset(dropSite);
  if(!isDefined(heightAdjustment)) {
    heightAdjustment = 0;
  }

  flyHeight += heightAdjustment;

  if(!isDefined(owner)) {
    return;
  }

  pathGoal = dropSite * (1, 1, 0) + (0, 0, flyHeight);
  pathStart = getPathStart(pathGoal, dropYaw);
  pathEnd = getPathEnd(pathGoal, dropYaw);

  pathGoal = pathGoal + vector_multiply(anglesToForward((0, dropYaw, 0)), -50);

  chopper = heliSetup(owner, pathStart, pathGoal);

  chopper endon("death");

  chopper.dropType = dropType;
  assert(isDefined(chopper));

  chopper setVehGoalPos(pathGoal, 1);

  chopper thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);

  wait(2);

  chopper Vehicle_SetSpeed(75, 40);
  chopper SetYawSpeed(180, 180, 180, .3);

  chopper waittill("goal");
  wait(.10);
  chopper notify("drop_crate");
  chopper setvehgoalpos(pathEnd, 1);
  chopper Vehicle_SetSpeed(300, 75);
  chopper.leaving = true;
  chopper waittill("goal");
  chopper notify("leaving");
  chopper trimActiveBirdList();
  decrementLittleBirdCount();
  chopper notify("delete");
  chopper delete();
}

doMegaFlyBy(owner, dropSite, dropYaw, dropType) {
  level thread doFlyBy(owner, dropSite, dropYaw, dropType);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (128, 128, 0), dropYaw, dropType, 128);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (172, 256, 0), dropYaw, dropType, 256);
  wait(RandomIntRange(1, 2));
  level thread doFlyBy(owner, dropSite + (64, 0, 0), dropYaw, dropType);
}

doC130FlyBy(owner, dropSite, dropYaw, dropType) {
  level endon("shutdownGame_called");

  planeHalfDistance = 24000;
  planeFlySpeed = 2000;
  yaw = vectorToYaw(dropsite - owner.origin);

  direction = (0, yaw, 0);

  flyHeight = self getFlyHeightOffset(dropSite);

  pathStart = dropSite + vector_multiply(anglesToForward(direction), -1 * planeHalfDistance);
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  pathEnd = dropSite + vector_multiply(anglesToForward(direction), planeHalfDistance);
  pathEnd = pathEnd * (1, 1, 0) + (0, 0, flyHeight);

  d = length(pathStart - pathEnd);
  flyTime = (d / planeFlySpeed);

  c130 = c130Setup(owner, pathStart, pathEnd);
  c130.veh_speed = planeFlySpeed;
  c130.dropType = dropType;
  c130 playLoopSound("veh_ac130_dist_loop");

  c130.angles = direction;
  forward = anglesToForward(direction);
  c130 moveTo(pathEnd, flyTime, 0, 0);

  minDist = distance2D(c130.origin, dropSite);
  boomPlayed = false;

  for(;;) {
    dist = distance2D(c130.origin, dropSite);

    // handle missing our target
    if(dist < minDist) {
      minDist = dist;
    }
    else if(dist > minDist) {
      break;
    }

    if(dist < 256) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        c130 playSound("veh_ac130_sonic_boom");
        //c130 thread stopLoopAfter( 0.5 );
        boomPlayed = true;
      }
    }

    wait(.05);
  }

  wait(0.05);
  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);
  wait(0.05);
  c130 notify("drop_crate");
  wait(0.05);

  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, undefined, pathStart);
  wait(0.05);
  c130 notify("drop_crate");

  wait(4);
  c130 delete();
}

dropNuke(dropSite, owner, dropType) {
  level endon("shutdownGame_called");

  planeHalfDistance = 24000;
  planeFlySpeed = 2000;
  yaw = RandomInt(360);

  direction = (0, yaw, 0);

  flyHeight = self getFlyHeightOffset(dropSite);

  pathStart = dropSite + vector_multiply(anglesToForward(direction), -1 * planeHalfDistance);
  pathStart = pathStart * (1, 1, 0) + (0, 0, flyHeight);

  pathEnd = dropSite + vector_multiply(anglesToForward(direction), planeHalfDistance);
  pathEnd = pathEnd * (1, 1, 0) + (0, 0, flyHeight);

  d = length(pathStart - pathEnd);
  flyTime = (d / planeFlySpeed);

  c130 = c130Setup(owner, pathStart, pathEnd);
  c130.veh_speed = planeFlySpeed;
  c130.dropType = dropType;
  c130 playLoopSound("veh_ac130_dist_loop");

  c130.angles = direction;
  forward = anglesToForward(direction);
  c130 moveTo(pathEnd, flyTime, 0, 0);

  // TODO: fix this... it's bad.if we miss our distance (which could happen if plane speed is changed in the future) we stick in this thread forever
  boomPlayed = false;
  minDist = distance2D(c130.origin, dropSite);
  for(;;) {
    dist = distance2D(c130.origin, dropSite);

    // handle missing our target
    if(dist < minDist) {
      minDist = dist;
    }
    else if(dist > minDist) {
      break;
    }

    if(dist < 256) {
      break;
    } else if(dist < 768) {
      earthquake(0.15, 1.5, dropSite, 1500);
      if(!boomPlayed) {
        c130 playSound("veh_ac130_sonic_boom");
        //c130 thread stopLoopAfter( 0.5 );
        boomPlayed = true;
      }
    }

    wait(.05);
  }

  c130 thread dropTheCrate(dropSite, dropType, flyHeight, false, "nuke", pathStart);
  wait(0.05);
  c130 notify("drop_crate");

  wait(4);
  c130 delete();
}

stopLoopAfter(delay) {
  self endon("death");

  wait(delay);
  self stoploopsound();
}

playloopOnEnt(alias) {
  soundOrg = spawn("script_origin", (0, 0, 0));
  soundOrg hide();
  soundOrg endon("death");
  thread delete_on_death(soundOrg);

  soundOrg.origin = self.origin;
  soundOrg.angles = self.angles;
  soundOrg linkto(self);

  soundOrg playLoopSound(alias);

  self waittill("stop sound" + alias);
  soundOrg stoploopsound(alias);
  soundOrg delete();
}

// spawn C130 at a start node and monitors it
c130Setup(owner, pathStart, pathGoal) {
  forward = vectorToAngles(pathGoal - pathStart);
  c130 = spawnplane(owner, "script_model", pathStart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_enemy");
  c130 setModel("vehicle_ac130_low_mp");

  if(!isDefined(c130)) {
    return;
  }

  //chopper playLoopSound( "littlebird_move" );
  c130.owner = owner;
  c130.team = owner.team;
  level.c130 = c130;

  return c130;
}

// spawn helicopter at a start node and monitors it
heliSetup(owner, pathStart, pathGoal) {
  forward = vectorToAngles(pathGoal - pathStart);
  chopper = spawnHelicopter(owner, pathStart, forward, "littlebird_mp", "vehicle_little_bird_armed");

  if(!isDefined(chopper)) {
    return;
  }

  chopper playLoopSound("littlebird_move");

  chopper.health = 500;
  chopper setCanDamage(true);
  chopper.owner = owner;
  chopper.team = owner.team;
  chopper thread heli_existence();
  chopper thread heliDestroyed();
  chopper SetMaxPitchRoll(45, 85);
  chopper Vehicle_SetSpeed(250, 175);
  level.littlebird[level.littlebird.size] = chopper;

  chopper.damageCallback = ::Callback_VehicleDamage;

  return chopper;
}

heli_existence() {
  self waittill_any("crashing", "leaving");
  self trimActiveBirdList();

  self notify("helicopter_gone");
}

Callback_VehicleDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName) {
  if((attacker == self || (isDefined(attacker.pers) && attacker.pers["team"] == self.team)) && (attacker != self.owner || meansOfDeath == "MOD_MELEE")) {
    return;
  }

  attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("");

  if(self.health <= damage) {
    attacker notify("destroyed_killstreak");
  }

  self Vehicle_FinishDamage(inflictor, attacker, damage, dFlags, meansOfDeath, weapon, point, dir, hitLoc, timeOffset, modelIndex, partName);
}

heliDestroyed() {
  self endon("leaving");
  self endon("helicopter_gone");

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self trimActiveBirdList();
  decrementLittleBirdCount();
  self Vehicle_SetSpeed(25, 5);
  self thread lbSpin(RandomIntRange(180, 220));

  wait(RandomFloatRange(.5, 1.5));

  self notify("drop_crate");

  lbExplode();
}

// crash explosion
lbExplode() {
  forward = (self.origin + (0, 0, 1)) - self.origin;
  playFX(level.chopper_fx["explode"]["death"]["cobra"], self.origin, forward);

  // play heli explosion sound
  self playSound("cobra_helicopter_crash");
  self notify("explode");

  self delete();
}

lbSpin(speed) {
  self endon("explode");

  // tail explosion that caused the spinning
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  playFXOnTag(level.chopper_fx["fire"]["trail"]["medium"], self, "tail_rotor_jnt");

  self setyawspeed(speed, speed, speed);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

trimActiveBirdList() {
  for(i = 0; i < level.littlebird.size; i++) {
    if(level.littlebird.size == 1) {
      level.littlebird = [];
    } else if(level.littlebird[i] == self) {
      level.littlebird[i] = level.littlebird[level.littlebird.size - 1];
      level.littlebird[level.littlebird.size - 1] = undefined;
    }
  }
}

/**********************************************************
 *		 crate trigger functions
***********************************************************/

/*
nukeCaptureThink()
{
while( isDefined( self ) )
{
self waittill ( "trigger", player );

if( !player isOnGround() ) {
continue;
}
if( !useHoldThink( player ) ) {
continue;
}
self notify ( "captured", player );
}
}
*/

crateOtherCaptureThink() {
  while(isDefined(self)) {
    self waittill("trigger", player);

    //if( !player isOnGround() )
    //	continue;

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }

    useEnt = self createUseEnt();
    result = useEnt useHoldThink(player);

    if(isDefined(useEnt)) {
      useEnt delete();
    }

    if(!result) {
      continue;
    }

    self notify("captured", player);
  }
}

crateOwnerCaptureThink() {
  while(isDefined(self)) {
    self waittill("trigger", player);

    //if( !player isOnGround() )
    //	continue;

    if(isDefined(self.owner) && player != self.owner) {
      continue;
    }

    if(!useHoldThink(player, 500)) {
      continue;
    }

    self notify("captured", player);
  }
}

killstreakCrateThink(dropType) {
  self endon("death");
  level endon("game_ended");

  crateHint = getCrateHint(self.crateType);

  crateSetupForUse(crateHint, "all", getKillstreakCrateIcon(self.crateType));

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        if(dropType == "airdrop_marker_mp") {
          player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop");
          player thread hijackNotify(self, "airdrop");
        } else {
          player thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop_mega");
          player thread hijackNotify(self, "emergency_airdrop");
        }
      } else {
        self.owner thread maps\mp\gametypes\_rank::giveRankXP("killstreak_giveaway", level.hardpointitems[self.crateType] * 50);

        self.owner thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("airdrop_giveaway", player);
      }
    }

    player playLocalSound("ammo_crate_use");
    player thread maps\mp\gametypes\_hardpoints::giveHardpoint(self.crateType);

    self deleteCrate();
  }
}

getCrateHint(crateType) {
  switch (crateType) {
    case "radar_mp":
      return &"LUA_GRAB_RADAR";

    case "counter_radar_mp":
      return &"LUA_GRAB_COUNTER_RADAR";

    case "sentry_mp":
      return &"LUA_GRAB_SENTRY";

    case "predator_mp":
      return &"LUA_GRAB_PREDATOR";

    case "airstrike_mp":
      return &"LUA_GRAB_AIRSTRIKE";

    case "helicopter_mp":
      return &"LUA_GRAB_HELICOPTER";

    case "harrier_airstrike_mp":
      return &"LUA_GRAB_HARRIER";

    case "pavelow_mp":
      return &"LUA_GRAB_PAVELOW";

    case "stealth_airstrike_mp":
      return &"LUA_GRAB_STEALTH_AIRSTRIKE";

    case "chopper_gunner_mp":
      return &"LUA_GRAB_CHOPPER_GUNNER";

    case "ac130_mp":
      return &"LUA_GRAB_AC130";

    case "emp_mp":
      return &"LUA_GRAB_EMP";

    case "nuke_mp":
      return &"LUA_GRAB_NUKE";

    default:
      return "";
  }
}

/*
nukeCrateThink( dropType )
{
self endon ( "death" );
level endon("game_ended");

crateSetupForUse(&"PLATFORM_CALL_NUKE", "nukeDrop", maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon( self.crateType ) );

self thread nukeCaptureThink();

for( ;; )
{
self waittill ( "captured", player );

player thread [[ level.killstreakFuncs[ self.crateType ] ]]( level.gtnw );
level notify( "nukeCaptured", player );

if( isDefined( level.gtnw ) && level.gtnw ) {
player.capturedNuke = 1;
}

player playLocalSound( "ammo_crate_use" );
self deleteCrate();
}
}

sentryCrateThink( dropType )
{
self endon ( "death" );
level endon("game_ended");

crateSetupForUse( game["strings"]["sentry_hint"], "all", maps\mp\killstreaks\_killstreaks::getKillstreakCrateIcon( self.crateType ) );

self thread crateOtherCaptureThink();
self thread crateOwnerCaptureThink();

for( ;; )
{
self waittill ( "captured", player );

if( isDefined( self.owner ) && player != self.owner )
{
if( !level.teamBased || player.team != self.team )
{
if( isSubStr(dropType, "airdrop_sentry" ) ) {
player thread hijackNotify( self, "sentry" );
}
else {
player thread hijackNotify( self, "emergency_airdrop" );
}
}
else
{
self.owner thread maps\mp\gametypes\_rank::giveRankXP( "killstreak_giveaway", maps\mp\killstreaks\_killstreaks::getStreakCost( "sentry" ) * 50 );
}
}		

player playLocalSound( "ammo_crate_use" );
player thread sentryUseTracker();

self deleteCrate();
}
}
*/

deleteCrate() {
  if(isDefined(self.objIdFriendly)) {
    _objective_delete(self.objIdFriendly);
  }

  if(isDefined(self.objIdEnemy)) {
    _objective_delete(self.objIdEnemy);
  }

  self delete();
}

/*
sentryUseTracker()
{
if( !self maps\mp\killstreaks\_autosentry::giveSentry( "sentry_minigun", lifeId ) ) {
self maps\mp\killstreaks\_killstreaks::giveKillstreak( "sentry" );
}
}
*/

ammoCrateThink(dropType) {
  self endon("death");
  level endon("game_ended");

  self.usedBy = [];

  crateSetupForUse(&"LUA_GRAB_AMMO", "all", "waypoint_ammo_friendly");

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  for(;;) {
    self waittill("captured", player);

    if(isDefined(self.owner) && player != self.owner) {
      if(!level.teamBased || player.team != self.team) {
        if(dropType == "airdrop_marker_mp") {
          player thread hijackNotify(self, "airdrop");
        }
        else {
          player thread hijackNotify(self, "emergency_airdrop");
        }
      }
    }

    player playLocalSound("ammo_crate_use");
    player refillAmmo();
    self deleteCrate();
  }
}

hijackNotify(crate, crateType) {
  self notify("hijacker", crateType, crate.owner);
  crate.owner thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("airdrop_stolen", self);
}

refillAmmo() {
  weaponList = self GetWeaponsListAll();

  if(self _hasPerk("specialty_tacticalinsertion") && self getAmmoCount("flare_mp") < 1) {
    self _setPerk("specialty_tacticalinsertion", 0);
  }

  foreach(weaponName in weaponList) {
    if(isSubStr(weaponName, "grenade")) {
      if(self getAmmoCount(weaponName) >= 1) {
        continue;
      }
    }

    self giveMaxAmmo(weaponName);
  }
}

/**********************************************************
 *		 Capture crate functions
***********************************************************/

useHoldThink(player, useTime) {
  player playerLinkTo(self);
  player playerLinkedOffsetEnable();

  player _disableWeapon();

  self.curProgress = 0;
  self.inUse = true;
  self.useRate = 0;

  if(isDefined(useTime)) {
    self.useTime = useTime;
  }
  else {
    self.useTime = 3000;
  }

  player thread personalUseBar(self);

  result = useHoldThinkLoop(player);
  assert(isDefined(result));

  if(isAlive(player)) {
    player _enableWeapon();
    player unlink();
  }

  if(!isDefined(self)) {
    return false;
  }

  self.inUse = false;
  self.curProgress = 0;

  return (result);
}

personalUseBar(object) {
  self endon("disconnect");

  useBar = createPrimaryProgressBar(-25);
  useBarText = createPrimaryProgressBarText(-25);
  useBarText setText(&"MP_CAPTURING_CRATE");

  lastRate = -1;
  while(isReallyAlive(self) && isDefined(object) && object.inUse && !level.gameEnded) {
    if(lastRate != object.useRate) {
      if(object.curProgress > object.useTime) {
        object.curProgress = object.useTime;
      }

      useBar updateBar(object.curProgress / object.useTime, (1000 / object.useTime) * object.useRate);

      if(!object.useRate) {
        useBar hideElem();
        useBarText hideElem();
      } else {
        useBar showElem();
        useBarText showElem();
      }
    }
    lastRate = object.useRate;
    wait(0.05);
  }

  useBar destroyElem();
  useBarText destroyElem();
}

useHoldThinkLoop(player) {
  while(!level.gameEnded && isDefined(self) && isReallyAlive(player) && player useButtonPressed() && self.curProgress < self.useTime) {
    self.curProgress += (50 * self.useRate);

    if(isDefined(self.objectiveScaler)) {
      self.useRate = 1 * self.objectiveScaler;
    }
    else {
      self.useRate = 1;
    }

    if(self.curProgress >= self.useTime) {
      return (isReallyAlive(player));
    }

    wait 0.05;
  }

  return false;
}

isAirdropMarker(weaponName) {
  switch (weaponName) {
    case "airdrop_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_sentry_marker_mp":
      return true;
    default:
      return false;
  }
}

createUseEnt() {
  useEnt = spawn("script_origin", self.origin);
  useEnt.curProgress = 0;
  useEnt.useTime = 0;
  useEnt.useRate = 3000;
  useEnt.inUse = false;

  useEnt thread deleteUseEnt(self);

  return (useEnt);
}

deleteUseEnt(owner) {
  self endon("death");

  owner waittill("death");

  self delete();
}

airdropDetonateOnStuck() {
  self endon("death");

  self waittill("missile_stuck");

  self detonate();
}

decrementLittleBirdCount() {
  level.littleBirds--;

  level.littleBirds = int(max(level.littleBirds, 0));
}