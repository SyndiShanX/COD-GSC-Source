/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_breach.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");

main() {
  level._effect["_breach_doorbreach_detpack"] = loadfx("explosions/exp_pack_doorbreach");
  level._effect["_breach_doorbreach_kick"] = loadfx("explosions/grenadeExp_wood");
  level.scr_sound["breach_wooden_door"] = "detpack_explo_main";
  level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
  flag_init("begin_the_breach");
}

breach_think(aBreachers, sBreachType, sHintString, bSpawnHostiles, bPlayDefaultFx, bShoot) {
  self endon("breach_abort");
  if(isDefined(bShoot) && (bShoot == false)) {
    anim.fire_notetrack_functions["scripted"] = ::breach_fire_straight;
  }
  self.flashthrown = false;
  self.closestAI = undefined;
  self.animEnt = undefined;
  self.breached = false;
  self.breachers = 0;
  self.breachersReady = false;
  self.singleBreacher = false;
  self.readyToBreach = false;
  self.AIareInTheRoom = false;
  self.aboutToBeBreached = false;
  self.cleared = false;
  self.hasDoor = true;
  self.hasFlashbangs = false;
  self.hostilesSpawned = false;
  assertEx((aBreachers.size <= 2), "You cannot send more than 2 AI to perform a breach");
  assertEx((isDefined(self.targetname)), "Room volume must have a targetname to use the breach fuctions");
  aVolumes = getEntArray(self.targetname, "targetname");
  assertEx((aVolumes.size == 1), "There are multiple room volumes with the same targetname: " + self.targetname);
  sRoomName = self.targetname;
  self.sBadplaceName = "badplace_" + sRoomName;
  self.badplace = getent("badplace_" + sRoomName, "targetname");
  if(isDefined(self.badplace)) {
    assertEx((self.badplace.classname == "script_origin"), "The badplace entity for volume " + self.targetname + " needs to be a script_origin");
  }
  self.breachtrigger = getent("trigger_" + sRoomName, "targetname");
  if(!isDefined(bPlayDefaultFx)) {
    bPlayDefaultFx = true;
  }
  if(isDefined(self.breachtrigger)) {
    switch (self.breachtrigger.classname) {
      case "trigger_use":
        assertEx((isDefined(sHintString)), "You need to pass a hintstring to the function 'breach_think' for the trigger_use " + self.breachtrigger.targetname);
        self.triggerHintString = sHintString;
        break;
      case "trigger_use_touch":
        assertEx((isDefined(sHintString)), "You need to pass a hintstring to the function 'breach_think' for the trigger_use " + self.breachtrigger.targetname);
        self.triggerHintString = sHintString;
        break;
      case "trigger_radius":
        break;
      case "trigger_multiple":
        break;
      default:
        assertmsg("entity with targetname '" + self.breachtrigger.targetname + "' must be a trigger_multiple, trigger_radius,trigger_use or trigger_use_touch");
        break;
    }
  }
  switch (sBreachType) {
    case "explosive_breach_left":
      break;
    case "shotgunhinges_breach_left":
      break;
    case "flash_breach_no_door_right":
      self.hasDoor = false;
      self.hasFlashbangs = true;
      break;
    default:
      assertmsg(sBreachType + " is not a valid breachType");
      break;
  }
  if(self.hasDoor == true) {
    self.eDoor = getent(self.script_linkto, "script_linkname");
    assertEx((isDefined(self.eDoor)), "Explosive breach room volume " + self.targetname + " needs to scriptLinkto a single door");
    if(self.eDoor.classname == "script_model") {
      self.animEnt = spawn("script_origin", self.eDoor.origin);
      self.animEnt.angles = self.eDoor.angles;
    } else if(self.eDoor.classname == "script_brushmodel") {
      self.animEnt = getent(self.eDoor.target, "targetname");
      assertEx((isDefined(self.animEnt)), "Room volume " + self.targetname + " needs it's script_brushmodel door door to target a script_origin in the lower right hand corner of the door frame. Make this script_origin point in towards the room being breached.");
      assertEx((self.animEnt.classname == "script_origin"), "Room volume " + self.targetname + " needs it's script_brushmodel door door to target a script_origin in the lower right hand corner of the door frame. Make this script_origin point in towards the room being breached.");
      self.eDoor.vector = anglesToForward(self.animEnt.angles);
    }
    self.eExploderOrigin = getent(self.eDoor.script_linkto, "script_linkname");
    assertex(isDefined(self.eExploderOrigin), "A script_brushmodel/script_model door needs to script_linkTo an exploder (script_origin) to play particles when opened. Targetname:" + self.targetname);
    assertEx((self.eExploderOrigin.classname == "script_origin"), "The exploder for this room volume needs to be a script_origin: " + self.targetname);
    self.iExploderNum = self.eExploderOrigin.script_exploder;
    assertEx((isDefined(self.iExploderNum)), "There is no exploder number in the key 'script_exploder' for volume " + self.targetname);
  } else if(self.hasDoor == false) {
    self.animEnt = getent(self.script_linkto, "script_linkname");
    assertEx((isDefined(self.animEnt)), "If there is no door to be breached, you must have the room volume scriptLinkTo a script_origin instead where the AI will play their idle and enter anims.");
  }
  if(self.hasFlashbangs == true) {
    self.grenadeOrigin = getent("flashthrow_" + sRoomName, "targetname");
    assertEx((isDefined(self.grenadeOrigin)), "Breaches that have AI throwing flashbangs need a script origin in the center of the door frame with a targetname of: flashthrow_" + sRoomName);
    self.grenadeDest = getent(self.grenadeOrigin.target, "targetname");
    assertEx((isDefined(self.grenadeDest)), "script_origin 'flashthrow_" + sRoomName + "' needs to target another script_origin where you want the flashbang to be thrown to");
  }
  self thread breach_abort(aBreachers);
  self thread breach_cleanup(aBreachers);
  self thread breach_play_fx(sBreachType, bPlayDefaultFx);
  iFirstBreachers = 0;
  for(i = 0; i < aBreachers.size; i++) {
    if(isDefined(aBreachers[i].firstBreacher)) {
      iFirstBreachers++;
      self.closestAI = aBreachers[i];
    }
  }
  if(iFirstBreachers > 0) {
    assertEx(iFirstBreachers == 1, ".firstBreacher property has been set on " + iFirstBreachers + " AI. Max is one AI ");
  } else {
    self.closestAI = getClosest(self.animEnt.origin, aBreachers);
  }
  if(aBreachers.size == 1) {
    self.singleBreacher = true;
  }
  for(i = 0; i < aBreachers.size; i++) {
    aBreachers[i] thread breacher_think(self, sBreachType, bShoot);
  }
  while(self.breachers < aBreachers.size) {
    wait(0.05);
  }
  self notify("ready_to_breach");
  self.readyToBreach = true;
  if(isDefined(self.breachtrigger)) {
    self.breachtrigger thread breach_trigger_think(self);
    self waittill("execute_the_breach");
  } else {
    self notify("execute_the_breach");
  }
  flag_set("begin_the_breach");
  self.aboutToBeBreached = true;
  if(isDefined(bSpawnHostiles) && (bSpawnHostiles == true)) {
    spawners = getEntArray("hostiles_" + sRoomName, "targetname");
    assertEx((isDefined(spawners)), "Could not find spawners with targetname of hostiles_" + sRoomName + " for room volume " + self.targetname);
    self waittill("spawn_hostiles");
    spawnBreachHostiles(spawners);
    self.hostilesSpawned = true;
  }
  if(isDefined(self.badplace)) {
    badplace_cylinder(self.sBadplaceName, -1, self.badplace.origin, self.badplace.radius, 200, "axis");
  }
  ai = getaiarray("axis");
  aHostiles = [];
  for(i = 0; i < ai.size; i++) {
    if(ai[i] isTouching(self)) {
      aHostiles[aHostiles.size] = ai[i];
    }
  }
  if(aHostiles.size > 0) {
    array_thread(aHostiles, ::breach_enemies_stunned, self);
  }
  while(!self.AIareInTheRoom) {
    wait(0.05);
  }
  self notify("breach_complete");
  if(!aHostiles.size) {
    return;
  }
  while(!self.cleared) {
    wait(0.05);
    for(i = 0; i < aHostiles.size; i++) {
      if(!isalive(aHostiles[i])) {
        aHostiles = array_remove(aHostiles, aHostiles[i]);
      }
      if(aHostiles.size == 0) {
        self.cleared = true;
      }
    }
  }
}

breach_dont_fire() {
  while(self.breaching == true) {
    self waittillmatch("single anim", "fire");
    self.a.lastShootTime = gettime();
  }
}

breacher_think(eVolume, sBreachType, bShoot) {
  self.breaching = true;
  self.breachDoNotFire = undefined;
  if(!isDefined(bShoot)) {
    bShoot = true;
  }
  self pushplayer(true);
  self thread give_infinite_ammo();
  eVolume endon("breach_abort");
  self.ender = "stop_idle_" + self getentitynumber();
  AInumber = undefined;
  sAnimStart = undefined;
  sAnimIdle = undefined;
  sAnimBreach = undefined;
  sAnimFlash = undefined;
  if(self == eVolume.closestAI) {
    AInumber = "01";
  } else {
    AInumber = "02";
  }
  if((eVolume.singleBreacher == true) && (sBreachType == "explosive_breach_left")) {
    AInumber = "02";
  }
  switch (sBreachType) {
    case "explosive_breach_left":
      if((isDefined(self.usebreachapproach)) && (self.usebreachapproach == false)) {
        sAnimStart = "detcord_stack_left_start_no_approach_" + AInumber;
      } else {
        sAnimStart = "detcord_stack_left_start_" + AInumber;
      }
      sAnimIdle = "detcord_stack_leftidle_" + AInumber;
      sAnimBreach = "detcord_stack_leftbreach_" + AInumber;
      break;
    case "shotgunhinges_breach_left":
      sAnimStart = "shotgunhinges_breach_left_stack_start_" + AInumber;
      sAnimIdle = "shotgunhinges_breach_left_stack_idle_" + AInumber;
      sAnimBreach = "shotgunhinges_breach_left_stack_breach_" + AInumber;
      break;
    case "flash_breach_no_door_right":
      if(eVolume.singleBreacher == true) {
        sAnimStart = "flash_stack_right_start_single";
        sAnimIdle = "flash_stack_right_idle_single";
        sAnimBreach = "flash_stack_right_breach_single";
        sAnimFlash = "flash_stack_right_flash_single";
      } else {
        sAnimStart = "flash_stack_right_start_" + AInumber;
        sAnimIdle = "flash_stack_right_idle_" + AInumber;
        sAnimBreach = "flash_stack_right_breach_" + AInumber;
        sAnimFlash = "flash_stack_right_flash_" + AInumber;
      }
      break;
    default:
      assertmsg(sBreachType + " is not a valid breachType");
      break;
  }
  self breach_set_goaladius(64);
  eVolume.animEnt anim_generic_reach(self, sAnimStart);
  eVolume.animEnt anim_generic(self, sAnimStart);
  eVolume.animEnt thread anim_generic_loop(self, sAnimIdle, undefined, self.ender);
  self.setGoalPos = self.origin;
  eVolume.breachers++;
  eVolume waittill("execute_the_breach");
  if((!eVolume.flashthrown) && (isDefined(sAnimFlash))) {
    eVolume.animEnt notify(self.ender);
    eVolume.animEnt thread anim_generic(self, sAnimFlash);
    wait(1);
    if((AInumber == "02") || (eVolume.singleBreacher == true)) {
      sHandTag = "J_Mid_LE_1";
      self attach("projectile_m84_flashbang_grenade", sHandTag);
      oldGrenadeWeapon = self.grenadeWeapon;
      self.grenadeWeapon = "flash_grenade";
      self.grenadeAmmo++;
      if(AInumber == "02") {
        self waittillmatch("single anim", "grenade_throw");
      }
      if((eVolume.singleBreacher == true) && (AInumber == "01")) {
        self waittillmatch("single anim", "fire");
      }
      self magicgrenade(eVolume.grenadeOrigin.origin, eVolume.grenadeDest.origin, level.iFlashFuse);
      self detach("projectile_m84_flashbang_grenade", sHandTag);
      self.grenadeWeapon = oldGrenadeWeapon;
      self.grenadeAmmo = 0;
    }
    self waittillmatch("single anim", "end");
    eVolume.animEnt thread anim_generic_loop(self, sAnimIdle, undefined, self.ender);
    wait(.1);
  }
  eVolume.animEnt notify(self.ender);
  if(bShoot == false) {
    self.breachDoNotFire = true;
  }
  eVolume.animEnt thread anim_generic(self, sAnimBreach);
  if(sBreachType == "explosive_breach_left") {
    if(AInumber == "02") {
      self thread detcord_logic(eVolume);
      self waittillmatch("single anim", "pull fuse");
      wait(1);
      eVolume notify("spawn_hostiles");
      eVolume notify("detpack_about_to_blow");
      self waittillmatch("single anim", "explosion");
      eVolume notify("detpack_detonated");
      eVolume.breached = true;
      eVolume.eDoor thread door_open("explosive", eVolume);
      eVolume notify("play_breach_fx");
    }
  } else if(sBreachType == "shotgunhinges_breach_left") {
    if(AInumber == "01") {
      eVolume notify("spawn_hostiles");
      self waittillmatch("single anim", "kick");
      eVolume.eDoor thread door_open("shotgun", eVolume);
      eVolume notify("play_breach_fx");
    }
  } else if(sBreachType == "flash_breach_no_door_right") {}
  self waittillmatch("single anim", "end");
  self notify("breach_complete");
  if(bShoot == false) {
    self.breachDoNotFire = undefined;
  }
  if(isDefined(level.friendly_breach_thread)) {
    self thread[[level.friendly_breach_thread]](eVolume);
  }
  eVolume.AIareInTheRoom = true;
  self pushplayer(false);
  self breach_reset_animname();
  while(!eVolume.cleared) {
    wait(0.05);
  }
  self.breaching = false;
}

breach_fire_straight() {
  if(isDefined(self.breachDoNotFire)) {
    return;
  }
  animscripts\shared::fire_straight();
}

detcord_logic(eVolume) {
  self thread sound_effect_play(eVolume);
  self waittillmatch("single anim", "attach prop right");
  sHandTag = "TAG_INHAND";
  self attach("weapon_detcord", sHandTag);
  self waittillmatch("single anim", "detach prop right");
  org_hand = self gettagorigin(sHandTag);
  angles_hand = self gettagangles(sHandTag);
  self detach("weapon_detcord", sHandTag);
  model_detcord = spawn("script_model", org_hand);
  model_detcord setModel("weapon_detcord");
  model_detcord.angles = angles_hand;
  eVolume waittill("detpack_detonated");
  radiusdamage(model_detcord.origin, 64, 50, 25);
  model_detcord delete();
}

sound_effect_play(eVolume) {
  self waittillmatch("single anim", "sound effect");
  thread play_sound_in_space("detpack_plant_arming", eVolume.animEnt.origin);
}

breach_enemies_stunned(eRoomVolume) {
  assert(0);
  self endon("death");
  eRoomVolume endon("breach_aborted");
  eRoomVolume waittill("detpack_detonated");
  if(distance(self.origin, eRoomVolume.animEnt.origin) <= level.detpackStunRadius) {
    level.stunnedAnimNumber++;
    if(level.stunnedAnimNumber > 2) {
      level.stunnedAnimNumber = 1;
    }
    sStunnedAnim = "exposed_flashbang_v" + level.stunnedAnimNumber;
    self.allowdeath = true;
    self anim_generic_custom_animmode(self, "gravity", sStunnedAnim);
    self breach_reset_animname();
  }
}

breach_trigger_think(eRoomVolume) {
  eRoomVolume endon("execute_the_breach");
  eRoomVolume endon("breach_aborted");
  self thread breach_trigger_cleanup(eRoomVolume);
  if((self.classname == "trigger_use") || (self.classname == "trigger_use_touch")) {
    self setHintString(eRoomVolume.triggerHintString);
    if(isDefined(eRoomVolume.eDoor)) {
      eRoomVolume.eBreachmodel = spawn("script_model", eRoomVolume.eDoor.origin);
      eRoomVolume.eBreachmodel.angles = eRoomVolume.eDoor.angles;
      eRoomVolume.eBreachmodel setModel(level.door_objmodel);
    }
  }
  self waittill("trigger");
  eRoomVolume notify("execute_the_breach");
}

breach_trigger_cleanup(eRoomVolume) {
  eRoomVolume waittill("execute_the_breach");
  self trigger_off();
  if(isDefined(eRoomVolume.eBreachmodel)) {
    eRoomVolume.eBreachmodel delete();
  }
}

breach_abort(aBreachers) {
  self endon("breach_complete");
  self waittill("breach_abort");
  self.cleared = true;
  self thread breach_cleanup(aBreachers);
}

breach_cleanup(aBreachers) {
  while(!self.cleared) {
    wait(0.05);
  }
  if(isDefined(self.badplace)) {
    badplace_delete(self.sBadplaceName);
  }
  while(!self.cleared) {
    wait(0.05);
  }
  array_thread(aBreachers, ::breach_AI_reset, self);
}

breach_AI_reset(eVolume) {
  self endon("death");
  self breach_reset_animname();
  self breach_reset_goaladius();
  eVolume.animEnt notify(self.ender);
  self notify("stop_infinite_ammo");
  self pushplayer(false);
}

breach_play_fx(sBreachType, bPlayDefaultFx) {
  self endon("breach_aborted");
  self endon("breach_complete");
  switch (sBreachType) {
    case "explosive_breach_left":
      self waittill("play_breach_fx");
      exploder(self.iExploderNum);
      thread play_sound_in_space(level.scr_sound["breach_wooden_door"], self.eExploderOrigin.origin);
      if(bPlayDefaultFx) {
        playFX(level._effect["_breach_doorbreach_detpack"], self.eExploderOrigin.origin, anglesToForward(self.eExploderOrigin.angles));
      }
      break;
    case "shotgunhinges_breach_left":
      self waittill("play_breach_fx");
      exploder(self.iExploderNum);
      if(bPlayDefaultFx) {
        playFX(level._effect["_breach_doorbreach_kick"], self.eExploderOrigin.origin, anglesToForward(self.eExploderOrigin.angles));
      }
      break;
    case "flash_breach_no_door_right":
      break;
    default:
      assertmsg(sBreachType + " is not a valid breachType");
      break;
  }
}

spawnHostile(eEntToSpawn) {
  spawnedGuy = eEntToSpawn dospawn();
  spawn_failed(spawnedGuy);
  assert(isDefined(spawnedGuy));
  return spawnedGuy;
}

spawnBreachHostiles(arrayToSpawn) {
  assertEx((arrayToSpawn.size > 0), "The array passed to spawnBreachHostiles function is empty");
  spawnedGuys = [];
  for(i = 0; i < arrayToSpawn.size; i++) {
    guy = spawnHostile(arrayToSpawn[i]);
    spawnedGuys[spawnedGuys.size] = guy;
  }
  assertEx((arrayToSpawn.size == spawnedGuys.size), "Not all guys were spawned successfully from spawnBreachHostiles");
  return spawnedGuys;
}

give_infinite_ammo() {
  self endon("death");
  self endon("stop_infinite_ammo");
  while(true) {
    self.bulletsInClip = weaponClipSize(self.weapon);
    wait(.5);
  }
}

door_open(sType, eVolume, bPlaySound) {
  if(!isDefined(bPlaySound)) {
    bPlaySound = true;
  }
  if(bPlaysound == true) {
    self playSound(level.scr_sound["breach_wood_door_kick"]);
  }
  switch (sType) {
    case "explosive":
      self thread door_fall_over(eVolume.animEnt);
      self door_connectpaths();
      self playSound(level.scr_sound["breach_wooden_door"]);
      earthquake(0.4, 1, self.origin, 1000);
      radiusdamage(self.origin, 56, level.maxDetpackDamage, level.minDetpackDamage);
      break;
    case "shotgun":
      self thread door_fall_over(eVolume.animEnt);
      self door_connectpaths();
      self playSound(level.scr_sound["breach_wooden_door"]);
      break;
  }
}

door_connectpaths() {
  if(self.classname == "script_brushmodel") {
    self connectpaths();
  } else {
    blocker = getent(self.target, "targetname");
    assertex(isDefined(blocker), "A script_model door needs to target a script_brushmodel that blocks the door.");
    blocker hide();
    blocker notsolid();
    blocker connectpaths();
  }
}

door_fall_over(animEnt) {
  assert(isDefined(animEnt));
  vector = undefined;
  if(self.classname == "script_model") {
    vector = anglesToForward(self.angles);
  } else if(self.classname == "script_brushmodel") {
    vector = self.vector;
  } else {
    assertmsg("door needs to be either a script_model or a script_brushmodel");
  }
  dist = (vector[0] * 20, vector[1] * 20, vector[2] * 20);
  self moveto(self.origin + dist, .5, 0, .5);
  rotationDummy = spawn("script_origin", (0, 0, 0));
  rotationDummy.angles = animEnt.angles;
  rotationDummy.origin = (self.origin[0], self.origin[1], animEnt.origin[2]);
  self linkTo(rotationDummy);
  rotationDummy rotatepitch(90, 0.45, 0.40);
  wait 0.45;
  rotationDummy rotatepitch(-4, 0.2, 0, 0.2);
  wait 0.2;
  rotationDummy rotatepitch(4, 0.15, 0.15);
  wait 0.15;
  self unlink();
  rotationDummy delete();
}

breach_set_goaladius(fRadius) {
  if(!isDefined(self.old_goalradius)) {
    self.old_goalradius = self.goalradius;
  }
  self.goalradius = fRadius;
}

breach_reset_goaladius() {
  if(isDefined(self.old_goalradius)) {
    self.goalradius = self.old_goalradius;
  }
  self.old_goalradius = undefined;
}

breach_set_animname(animname) {
  if(!isDefined(self.old_animname)) {
    self.old_animname = self.animname;
  }
  self.animname = animname;
}

breach_reset_animname() {
  if(isDefined(self.old_animname)) {
    self.animname = self.old_animname;
  }
  self.old_animname = undefined;
}