#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include scripts\utility;
#define H2_AC130_HEALTH 1000
#define H2_AC130_NUMBER_OF_FLARES 2
#define H2_AC130_TIMEOUT 40
#define H2_AC130_CINEMATIC 0

init() {
  create_dvar("scr_ac130_timeout", H2_AC130_TIMEOUT);

  level.ac130InUse = false;

  precacheModel("vehicle_ac130_coop");

  //precacheItem("ac130_25mm_mp");
  //precacheItem("ac130_40mm_mp");
  //precacheItem("ac130_105mm_mp");

  PrecacheMiniMapIcon("h2_objpoint_ac130_friendly");
  PrecacheMiniMapIcon("h2_objpoint_ac130_enemy");

  precacheShader("h2_ac130_overlay_105mm");
  precacheShader("h2_ac130_overlay_40mm");
  precacheShader("h2_ac130_overlay_25mm");

  level._effect["h2_ac130_flare"] = loadfx("fx/misc/flares_cobra");

  level.killStreakFuncs["ac130_mp"] = ::tryUseAC130;
}

tryUseAC130(lifeID) {
  if(level.ac130InUse) {
    self iprintlnbold( & "LUA_KS_UNAVAILABLE_AIRSPACE");
    return false;
  }

  if(self isusingremote()) {
    return false;
  }

  level.ac130InUse = true;
  self setusingremote("ac130");
  result = self maps\mp\h2_killstreaks\_common::initRideKillstreak();
  if(result != "success") {
    if(result != "disconnect") {
      self clearusingremote();
    }

    level.ac130InUse = false;
    return false;
  }

  self thread start_h2_ac130(lifeID);

  return true;
}

start_h2_ac130(lifeID) {
  self endon("disconnect");
  self endon("leave_ac130");

  thread teamPlayerCardSplash("callout_used_ac130", self);

  self.ac130LifeID = lifeID;
  level.ac130player = self;

  angle = randomInt(360);
  radiusOffset = randomInt(2000) + 5000;

  xOffset = cos(angle) * radiusOffset;
  yOffset = sin(angle) * radiusOffset;
  zOffset = 3000;

  angleVector = vectorNormalize((xOffset, yOffset, zOffset));
  angleVector = vector_multiply(angleVector, 6000);

  ac130 = spawn("script_model", level.UAVRig.origin + angleVector);
  ac130.angles = (0, angle, 0);
  ac130 setModel("vehicle_ac130_coop");
  ac130 setCanDamage(true);
  ac130.numFlares = H2_AC130_NUMBER_OF_FLARES;
  ac130.owner = self;
  ac130.team = self.team;
  ac130.lifeId = lifeId;
  ac130 playLoopSound("h2_veh_ac130_ext_dist");
  ac130.lifeSpan = getDvarInt("scr_ac130_timeout");
  ac130 thread ac130_damage_tracker();
  ac130 thread handleIncomingStinger();
  ac130 thread playAC130Effects();

  level.ac130 = ac130;
  level.ac130.planemodel = ac130;

  self _visionsetnakedforplayer("black_bw", 0);
  self _visionsetnakedforplayer("", 1);

  if(self getCurrentWeapon() != "ac130_mp" || self isSwitchingWeapon()) //force switching back to the laptop to keep the FOV
    self setSpawnWeapon("ac130_mp");

  self _disableWeaponSwitch();

  if(getDvarInt("camera_thirdPerson"))
    self setThirdPersonDOF(false);

  self thread exitAC130OnEntNotify(level.ac130, "death");
  self thread exitAC130OnEntNotify(level, "game_ended");
  self thread exitAC130OnEntNotify(self, "disconnect");
  self thread exitAC130OnEntNotify(self, "spawned");
  self thread exitAC130OnEntNotify(self, "joined_team");
  self thread exitAC130OnEntNotify(self, "ac130_timeout");

  ac130.playerView = spawn("script_model", ac130 localToWorldCoords((-600, 0, 50)));
  ac130.playerView setModel("tag_origin");
  ac130.playerView.angles = ac130.angles;

  if(H2_AC130_CINEMATIC) {
    ac130 hide();
    ac130 showToPlayer(self);
    self playerLinkWeaponviewToDelta(ac130.playerView, "tag_player", 1.0, 0, 0, 0, 0, true);

    wait 0.5;

    ac130.playerView moveTo(ac130 localToWorldCoords((0, 500, 50)), 2);
    ac130.playerView rotateTo(ac130.angles + (0, -90, 0), 2);

    wait 2;

    ac130.playerView moveTo(ac130 localToWorldCoords((0, 0, 50)), 1);

    wait 1;

    self _visionsetnakedforplayer("end_game2", 0);
    self _visionsetnakedforplayer("", 1);
    self unlink();

    ac130 show();
  }

  ac130 linkTo(level.UAVRig, "tag_origin", angleVector, (0, angle, 0));
  ac130.playerView linkTo(ac130, "tag_origin", (0, 0, 0), (0, 180, 0));

  wait 0.05;

  loopNode = level.heli_loop_nodes[randomInt(level.heli_loop_nodes.size)];

  self PlayerLinkWeaponviewToDelta(ac130.playerView, "tag_player", 1.0, 90, 90, 0, 60);
  self setPlayerAngles((0, vectorToAngles(loopNode.origin - ac130.origin)[1], 0));
  self playLoopSound("h2_veh_ac130_ext_dist");
  self setClientOmnvar("ui_ac130_enabled", 1);
  self thread customOverlay();
  self thread monitorLargeFire("ac130_105mm_mp");
  self thread monitorSmallFire("ac130_40mm_mp");
  self thread monitorSmallFire("ac130_25mm_mp");
  self thread ac130_25mm_sound();
  self thread monitorWeaponSwitch();
  self thread ac130Reload();
  self thread maps\mp\h2_killstreaks\_common::thermalVision(self, "leave_ac130");
  //self thread weaponLockThink( ac130 );

  ac130.plane = spawnPlane(self, "script_model", level.UAVRig getTagOrigin("tag_origin"), "h2_objpoint_ac130_friendly", "h2_objpoint_ac130_enemy");
  ac130.plane setModel("tag_origin");
  ac130.plane setContents(0);
  ac130.plane linkTo(ac130, "tag_origin", (0, 0, 0), (0, -90, 0));

  if(isBot(self))
    self thread scripts\mp\bot_patches::bot_remote_use(ac130);

  self ThermalVisionFOFOverlayOn();

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(ac130.lifeSpan - 1);
  self notify("ac130_timeout");
}

weaponLockThink(ac130) {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  for(;;) {
    eyePos = ac130.playerView.origin; //self getEye() doesn't work well with remote killstreaks in h1
    trace = bulletTrace(eyePos, eyePos + (anglesToForward(self getPlayerAngles()) * 100000), 1, self);

    targetListLOS = [];
    targetListNoLOS = [];
    foreach(player in level.players) {
      if(!isAlive(player))
        continue;

      if(level.teamBased && player.team == self.team)
        continue;

      if(player == self)
        continue;

      if(player _hasPerk("specialty_radarimmune"))
        continue;

      if(isDefined(player.spawntime) && (getTime() - player.spawntime) / 1000 <= 5)
        continue;

      player.remoteHeliLOS = true;
      if(!bulletTracePassed(eyePos, player.origin + (0, 0, 32), false, ac130)) {
        //if( distance( player.origin, trace["position"] ) > 256 )
        //	continue;

        targetListNoLOS[targetListNoLOS.size] = player;
      } else {
        targetListLOS[targetListLOS.size] = player;
      }
    }

    targetsInReticle = [];

    /*
    foreach ( target in targetList )
    {
    insideReticle = self WorldPointInReticle_Circle( target.origin, 65, 1200 );

    if( !insideReticle )
    continue;

    targetsInReticle[targetsInReticle.size] = target;
    }
    */

    targetsInReticle = targetListLOS;
    foreach(target in targetListNoLos) {
      targetListLOS[targetListLOS.size] = target;
    }

    if(targetsInReticle.size != 0) {
      sortedTargets = SortByDistance(targetsInReticle, trace["position"]);

      if(distance(sortedTargets[0].origin, trace["position"]) < 384 && sortedTargets[0] DamageConeTrace(trace["position"])) {
        self weaponLockFinalize(sortedTargets[0]);
        maps\mp\_helicopter::heliDialog("locked");
      } else {
        self weaponLockStart(sortedTargets[0]);
        maps\mp\_helicopter::heliDialog("tracking");
      }
    } else {
      self weaponLockFree();
    }

    wait(0.05);
  }
}

playAC130Effects() {
  self endon("death");

  wait 1;

  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_top");
}

handleIncomingStinger() {
  level endon("game_ended");
  self notify("handleIncomingStinger");
  self endon("handleIncomingStinger");
  self endon("leaving");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", player, missile, lockTarget);

    if(!isDefined(lockTarget) || (lockTarget != level.ac130.planeModel))
      continue;

    missile thread stingerProximityDetonate(player, player.team);
  }
}

stingerProximityDetonate(player, missileTeam) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level.ac130player))
    level.ac130player playLocalSound("missile_incoming");

  level.ac130.incomingMissile = true;

  missileTarget = level.ac130;

  self Missile_SetTargetEnt(missileTarget);

  didSeatbelts = false;
  minDist = distance(self.origin, missileTarget GetPointInBounds(0, 0, 0));

  for(;;) {
    center = missileTarget GetPointInBounds(0, 0, 0);

    curDist = distance(self.origin, center);

    if(!isDefined(level.ac130player)) {
      self Missile_SetTargetPos(level.ac130.origin + (0, 0, 100000));
      return;
    }

    if(curDist < 3000 && missileTarget == level.ac130 && level.ac130.numFlares > 0) {
      level.ac130.numFlares--;

      missileTarget thread flare_effect();
      newTarget = maps\mp\_helicopter::deployFlares();

      self Missile_SetTargetEnt(newTarget);
      missileTarget = newTarget;

      if(isDefined(level.ac130player))
        level.ac130player stopLocalSound("missile_incoming");
    }

    if(curDist < minDist) {
      speedPerFrame = (minDist - curDist) * 20;
      eta = (curDist / speedPerFrame);

      if(eta < 1.5 && !didSeatbelts && missileTarget == level.ac130) {
        if(isDefined(level.ac130player))
          level.ac130player playLocalSound("fasten_seatbelts");

        didSeatbelts = true;
      }

      minDist = curDist;
    }

    if(curDist > minDist) {
      if(curDist > 1536)
        return;

      if(isDefined(level.ac130player)) {
        level.ac130player stopLocalSound("missile_incoming");

        if(level.ac130player.team != missileTeam)
          radiusDamage(self.origin, 1000, 1000, 1000, player);
      }

      self hide();

      wait(0.05);
      self delete();
    }

    wait(0.05);
  }
}

flare_effect() {
  self endon("death");
  self playSound("ac130_flare_burst");

  for(i = 0; i < 10; i++) {
    if(!isDefined(self))
      return;

    playFXOnTag(level._effect["h2_ac130_flare"], self, "tag_flash_flares");
    wait(0.15);
  }
}

customOverlay() {
  self endon("disconnect");

  overlay = self createIcon("h2_ac130_overlay_105mm", 640, 400);
  overlay setPoint("MIDDLE", "CENTER", 0, 0);
  overlay.hidewheninmenu = true;
  overlay.archived = true;
  overlay.alpha = 1;

  reloadText = self createFontString("default", 1.5);
  reloadText setText( & "LUA_AC130_RELOADING");
  reloadText setPoint("CENTER", "CENTER", 0, 150);
  reloadText.alpha = 0;

  self.ac130Overlay = overlay;
  self.ac130ReloadText = reloadText;

  self waittill("leave_ac130");

  overlay destroy();
  reloadText destroy();
}

monitorLargeFire(type) {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  self notifyOnPlayerCommand("ac130_large_fire", "+attack");

  for(;;) {
    self waittill("ac130_large_fire");

    if(self.ac130Weapon != type)
      continue;

    wait 0.05;

    origin = level.ac130.playerView.origin;
    position = bulletTrace(origin, vector_multiply(anglesToForward(self getPlayerAngles()), 1000000), 0, self)["position"];

    self playLocalSound("ac130_105mm_fire");

    missile = MagicBullet(self.ac130Weapon, origin, position, self);
    missile.lifeID = self.ac130LifeID;
    //missile Missile_SetFlightmodeDirect();

    Earthquake(0.2, 1, origin, 1000);

    self notify("ac130_reload");

    self.ac130Reloading[type] = 1;

    wait 5;

    self.ac130Reloading[type] = 0;
  }
}

monitorSmallFire(type) {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  ammo = weaponClipSize(type);

  for(;;) {
    wait 0.05;

    while(!self attackButtonPressed())
      wait 0.05;

    if(self.ac130Weapon != type)
      continue;

    origin = level.ac130.playerView.origin;
    position = bulletTrace(origin, vector_multiply(anglesToForward(self getPlayerAngles()), 1000000), 0, self)["position"];

    if(type == "ac130_40mm_mp") {
      missile = MagicBullet(self.ac130Weapon, origin, position, self);
      missile.lifeID = self.ac130LifeID;
      //missile Missile_SetFlightmodeDirect();

      self playLocalSound("ac130_40mm_fire");
      Earthquake(0.125, 0.5, origin, 1000);
    } else {
      level.ac130 RadiusDamage(position, 40, 50, 40, self, "MOD_EXPLOSIVE", type);

      playFX(level.h2_chopper_fire_fx, position);
      Earthquake(0.05, 0.5, origin, 1000);
    }

    wait(weaponFireTime(type));

    ammo--;

    if(ammo <= 0) {
      self notify("ac130_reload");

      self.ac130Reloading[type] = 1;

      wait 2;

      self.ac130Reloading[type] = 0;

      ammo = weaponClipSize(type);
    }
  }
}

ac130_25mm_sound() {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  soundEnt = spawn("script_model", level.ac130.playerView.origin);
  soundEnt.angles = level.ac130.playerView.angles;
  soundEnt setModel("tag_origin");
  soundEnt setContents(0);
  soundEnt hide();
  soundEnt showToPlayer(self);
  soundEnt linkTo(level.ac130.playerView);

  level.ac130.soundEnt = soundEnt;

  for(;;) {
    if(self attackButtonPressed() && self.ac130Weapon == "ac130_25mm_mp" && !self.ac130Reloading["ac130_25mm_mp"])
      soundEnt playLoopSound("ac130_25mm_fire");
    else
      soundEnt stopLoopSound();

    wait 0.05;
  }
}

ac130Reload() {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  self.ac130Reloading["ac130_105mm_mp"] = 0;
  self.ac130Reloading["ac130_40mm_mp"] = 0;
  self.ac130Reloading["ac130_25mm_mp"] = 0;

  for(;;) {
    waittillframeend;

    self.ac130ReloadText.alpha = 0;

    if(self.ac130Reloading[self.ac130Weapon]) {
      result = self reloadPopup();

      if(!isDefined(result))
        continue;
    }

    self.ac130ReloadText.alpha = 0;

    self waittill_any("ac130_weapon_switch", "ac130_reload");
  }
}

reloadPopup() {
  while(self.ac130Reloading[self.ac130Weapon]) {
    self.ac130ReloadText fadeovertime(0.2);
    self.ac130ReloadText.alpha = 1;

    wait 0.2;

    self.ac130ReloadText fadeovertime(0.2);
    self.ac130ReloadText.alpha = 0.2;

    wait 0.2;
  }

  return 1;
}

monitorWeaponSwitch() {
  self endon("disconnect");
  self endon("leave_ac130");
  level endon("game_ended");

  self notifyOnPlayerCommand("ac130_weapon_switch", "weapnext");

  for(;;) {
    self.ac130Weapon = "ac130_105mm_mp";
    self.ac130Overlay setShader("h2_ac130_overlay_105mm", 640, 400);
    self setclientomnvar("fov_scale", 1.2);
    self setclientomnvar("ui_ac130_weapon", 1);

    self waittill("ac130_weapon_switch");

    self.ac130Weapon = "ac130_40mm_mp";
    self.ac130Overlay setShader("h2_ac130_overlay_40mm", 640, 400);
    self setclientomnvar("fov_scale", 0.8);
    self setclientomnvar("ui_ac130_weapon", 2);

    self waittill("ac130_weapon_switch");

    self.ac130Weapon = "ac130_25mm_mp";
    self.ac130Overlay setShader("h2_ac130_overlay_25mm", 640, 400);
    self setclientomnvar("fov_scale", 0.5);
    self setclientomnvar("ui_ac130_weapon", 3);

    self waittill("ac130_weapon_switch");
  }
}

exitAC130OnEntNotify(ent, waitfor) {
  self endon("leave_ac130");
  ent waittill(waitfor);

  if(waitfor != "death")
    level.ac130 thread fly_away();

  level.ac130InUse = false;
  level.ac130player = undefined;

  if(isDefined(level.ac130.playerView))
    level.ac130.playerView delete();

  if(isDefined(level.ac130.plane))
    level.ac130.plane delete();

  if(isDefined(level.ac130.soundEnt))
    level.ac130.soundEnt delete();

  self thread exitAC130(waitfor == "disconnect");
}

exitAC130(disconnected) {
  self notify("leave_ac130");

  if(!disconnected) {
    self unlink();
    self clearUsingRemote();
    self setClientOmnvar("ui_ac130_enabled", 0);
    self _enableWeaponSwitch();
    self stopLoopSound();
    self setclientomnvar("fov_scale", 1);

    self thread maps\mp\h2_killstreaks\_common::takeKillstreakWeapons();

    if(getDvarInt("camera_thirdPerson"))
      self setThirdPersonDOF(true);

    self ThermalVisionOff();
    self ThermalVisionFOFOverlayOff();

    self _visionsetnakedforplayer("black_bw", 0);
    self _visionsetnakedforplayer("", 1);
  }
}

fly_away() {
  self endon("death");

  self unlink();
  self.isLeaving = true;
  self notify("leaving");

  destPoint = self.origin + (anglesToForward(self.angles + (0, -90, 0)) * 20000);
  self moveTo(destPoint, 40);

  self waittill("movedone");
  self delete();
}

ac130_damage_tracker() {
  self endon("death");
  level endon("game_ended");

  self.health = 999999; // keep it from dying anywhere in code
  self.maxhealth = H2_AC130_HEALTH; // this is the health we'll check
  self.damageTaken = 0; // how much damage has it taken

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, sMeansOfDeath, modelName, tagName, partName, iDFlags, sWeapon);

    if(sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_EXPLOSIVE_BULLET")
      continue;

    if(isDefined(self.owner) && attacker == self.owner)
      continue;

    if(!maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, attacker))
      continue;

    if(isDefined(iDFlags) && (iDFlags & level.iDFLAGS_PENETRATION))
      self.wasDamagedFromBulletPenetration = true;

    self.wasDamaged = true;

    modifiedDamage = damage;

    if(IsPlayer(attacker))
      attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("ac130");

    if(isDefined(sWeapon)) {
      switch (sWeapon) {
        case "stinger_mp":
        case "javelin_mp":
        case "at4_mp":
          self.largeProjectileDamage = true;
          modifiedDamage = self.maxHealth + 1;
          break;
        default:
          break;
      }
    }

    self.damageTaken += modifiedDamage;

    if(self.damageTaken >= self.maxHealth) {
      self.alreadyDead = true;

      if(isPlayer(attacker)) {
        thread teamplayercardsplash("destroyed_ac130", attacker);

        attacker notify("destroyed_killstreak", sWeapon);
        attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 50, sWeapon, sMeansOfDeath);

        thread maps\mp\gametypes\_missions::vehicleKilled(self.owner, self, undefined, attacker, damage, sMeansOfDeath, sWeapon);

        attacker thread maps\mp\gametypes\_rank::giveRankXP("kill", 100);
      }

      self thread ac130Crash();
      self notify("death");

      return;
    }
  }
}

ac130Crash() {
  playFX(level.uav_fx["explode"], self.origin);

  self delete();
}