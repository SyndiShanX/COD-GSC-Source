/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shared.gsc
*****************************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include common_scripts\utility;
#using_animtree("generic_human");

placeWeaponOn(weapon, position) {
  assert(AIHasWeapon(weapon));
  self notify("weapon_position_change");
  curPosition = self.weaponInfo[weapon].position;
  assert(curPosition == "none" || self.a.weaponPos[curPosition] == weapon);
  if(position != "none" && self.a.weaponPos[position] == weapon) {
    return;
  }
  self detachAllWeaponModels();
  if(curPosition != "none") {
    self detachWeapon(weapon);
  }
  if(position == "none") {
    self updateAttachedWeaponModels();
    return;
  }
  if(self.a.weaponPos[position] != "none") {
    self detachWeapon(self.a.weaponPos[position]);
  }
  if(position == "left" || position == "right") {
    self attachWeapon(weapon, position);
    self.weapon = weapon;
    self.aimThresholdYaw = 10;
    self.aimThresholdPitch = 20;
    if(weaponIsGasWeapon(self.weapon)) {
      self.aimThresholdYaw = 25;
      self.aimThresholdPitch = 25;
    }
  } else {
    self attachWeapon(weapon, position);
  }
  self updateAttachedWeaponModels();
  assert(self.a.weaponPos["left"] == "none" || self.a.weaponPos["right"] == "none");
}

detachWeapon(weapon) {
  self.a.weaponPos[self.weaponInfo[weapon].position] = "none";
  self.weaponInfo[weapon].position = "none";
}

attachWeapon(weapon, position) {
  self.weaponInfo[weapon].position = position;
  self.a.weaponPos[position] = weapon;
}

detachAllWeaponModels() {
  positions = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  for(index = 0; index < positions.size; index++) {
    weapon = self.a.weaponPos[positions[index]];
    if(weapon == "none") {
      continue;
    }
    if(self.weapon == "none") {
      continue;
    }
    self detach(getWeaponModel(weapon), getTagForPos(positions[index]));
  }
}

updateAttachedWeaponModels() {
  positions = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  for(index = 0; index < positions.size; index++) {
    weapon = self.a.weaponPos[positions[index]];
    if(weapon == "none") {
      continue;
    }
    self attach(getWeaponModel(weapon), getTagForPos(positions[index]));
    if(self.weaponInfo[weapon].useClip && !self.weaponInfo[weapon].hasClip) {
      self hidepart("tag_clip");
    }
  }
}

getTagForPos(position) {
  switch (position) {
    case "chest":
      return "tag_weapon_chest";
    case "back":
      return "tag_stowed_back";
    case "left":
      return "tag_weapon_left";
    case "right":
      return "tag_weapon_right";
    case "hand":
      return "tag_inhand";
    default:
      assertMsg("unknown weapon placement position: " + position);
      break;
  }
}

DropAIWeapon() {
  if(self.weapon == "none") {
    return;
  }
  if(maps\_collectibles::has_collectible("collectible_dead_hands")) {
    return;
  }
  position = self.weaponInfo[self.weapon].position;
  if(getdvarint("scr_physWeaponDrop") != 0) {
    self dropPhysWeapon();
    self.weapon = "none";
    return;
  }
  if(self.dropWeapon) {
    dropWeaponName = self.weapon;
    if(issubstr(tolower(self.weapon), "rpg")) {
      dropWeaponName = "rpg_player";
    }
    self DropWeapon(dropWeaponName, position, 0);
  }
  if(isDefined(self.weapon) && self.weapon != "none") {
    animscripts\shared::placeWeaponOn(self.weapon, "none");
    self.weapon = "none";
  }
}

DropAllAIWeapons() {
  if(!self.dropweapon) {
    if(self.weapon != "none") {
      animscripts\shared::placeWeaponOn(self.weapon, "none");
      self.weapon = "none";
    }
    return;
  }
  positions = [];
  positions[positions.size] = "left";
  positions[positions.size] = "right";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";
  self detachAllWeaponModels();
  if(maps\_collectibles::has_collectible("collectible_dead_hands")) {
    self.weapon = "none";
    return;
  }
  for(index = 0; index < positions.size; index++) {
    weapon = self.a.weaponPos[positions[index]];
    if(weapon == "none") {
      continue;
    }
    self.weaponInfo[weapon].position = "none";
    self.a.weaponPos[positions[index]] = "none";
    if(getdvarint("scr_physWeaponDrop") != 0) {
      self dropPhysWeapon(positions[index]);
    } else {
      self DropWeapon(weapon, positions[index], 0);
    }
  }
  self.weapon = "none";
}

dropPhysWeapon(pos) {
  if(maps\_collectibles::has_collectible("collectible_dead_hands")) {
    return;
  }
  tagName = self getTagForPos(pos);
  tagOrigin = self getTagOrigin(tagName);
  tagAngles = self getTagAngles(tagName);
  physWeapon = spawn("script_model", tagOrigin);
  physWeapon.angles = tagAngles;
  physWeapon setModel(getWeaponModel(self.a.weaponPos[pos]));
  physWeapon thread addPhysWeapon();
  animscripts\shared::placeWeaponOn(self.a.weaponPos[pos], "none");
  physWeapon physicsLaunch(tagOrigin + (randomFloat(6), randomFloat(6), randomFloat(6)), (randomFloat(500) - 250, randomFloat(500) - 250, randomFloat(50)));
}

addPhysWeapon() {
  self thread deleteAtLimit();
}

deleteAtLimit() {
  wait 30.0;
  self delete();
}

LookAtEntity(lookTargetEntity, lookDuration, lookSpeed, eyesOnly, interruptOthers) {
  return;
}

LookAtPosition(lookTargetPos, lookDuration, lookSpeed, eyesOnly, interruptOthers) {
  assertEX(isAI(self), "Can only call this function on an AI character");
  assertEX(self.a.targetLookInitilized == true, "LookAtPosition called on AI that lookThread was not called on");
  assertEX((lookSpeed == "casual") || (lookSpeed == "alert"), "lookSpeed must be casual or alert");
  if(!isDefined(interruptOthers) || (interruptOthers == "interrupt others") || (GetTime() > self.a.lookEndTime)) {
    self.a.lookTargetPos = lookTargetPos;
    self.a.lookEndTime = GetTime() + (lookDuration * 1000);
    if(lookSpeed == "casual") {
      self.a.lookTargetSpeed = 800;
    }
    else {
      self.a.lookTargetSpeed = 1600;
    }
    if(isDefined(eyesOnly) && (eyesOnly == "eyes only")) {
      self notify("eyes look now");
    } else {
      self notify("look now");
    }
  }
}

LookAtStop() {
  assertEX(isAI(self), "Can only call this function on an AI character");
  assertEX(self.a.targetLookInitilized == true, "LookAtStop called on AI that lookThread was not called on");
  animscripts\look::finishLookAt();
}

LookAtAnimations(leftanim, rightanim) {
  self.a.LookAnimationLeft = leftanim;
  self.a.LookAnimationRight = rightanim;
}

showNoteTrack(note) {
  if(getdebugdvar("scr_shownotetracks") != "on" && getdebugdvarint("scr_shownotetracks") != self getentnum()) {
    return;
  }
  self endon("death");
  anim.showNotetrackSpeed = 30;
  anim.showNotetrackDuration = 30;
  if(!isDefined(self.a.shownotetrackoffset)) {
    thisoffset = 0;
    self.a.shownotetrackoffset = 10;
    self thread reduceShowNotetrackOffset();
  } else {
    thisoffset = self.a.shownotetrackoffset;
    self.a.shownotetrackoffset += 10;
  }
  duration = anim.showNotetrackDuration + int(20.0 * thisoffset / anim.showNotetrackSpeed);
  color = (.5, .75, 1);
  if(note == "end" || note == "finish") {
    color = (.25, .4, .5);
  }
  else if(note == "undefined") {
    color = (1, .5, .5);
  }
  for(i = 0; i < duration; i++) {
    if(duration - i <= anim.showNotetrackDuration) {
      amnt = 1.0 * (i - (duration - anim.showNotetrackDuration)) / anim.showNotetrackDuration;
    }
    else {
      amnt = 0.0;
    }
    time = 1.0 * i / 20;
    alpha = 1.0 - amnt * amnt;
    pos = self getEye() + (0, 0, 20 + anim.showNotetrackSpeed * time - thisoffset);
    print3d(pos, note, color, alpha);
    wait .05;
  }
}

reduceShowNotetrackOffset() {
  self endon("death");
  while(self.a.shownotetrackoffset > 0) {
    wait .05;
    self.a.shownotetrackoffset -= anim.showNotetrackSpeed * .05;
  }
  self.a.shownotetrackoffset = undefined;
}

HandleDogSoundNoteTracks(note) {
  if(GetDvar("zombiemode") == "1") {
    prefix = getsubstr(note, 0, 5);
    if(prefix != "sound") {
      return false;
    }
    return true;
  }
  if(note == "sound_dogstep_run_default" || issubstr(note, "dogstep")) {
    self playSound("dogstep_run_default");
    return true;
  }
  prefix = getsubstr(note, 0, 5);
  if(prefix != "sound") {
    return false;
  }
  alias = "anml" + getsubstr(note, 5);
  if(isalive(self)) {
    self thread play_sound_on_tag_endon_death(alias, "tag_eye");
  }
  else {
    self thread play_sound_in_space(alias, self gettagorigin("tag_eye"));
  }
  return true;
}
growling() {
  return isDefined(self.script_growl);
}

registerNoteTracks() {
  anim.notetracks["anim_pose = \"stand\""] = ::noteTrackPoseStand;
  anim.notetracks["anim_pose = \"crouch\""] = ::noteTrackPoseCrouch;
  anim.notetracks["anim_pose = \"prone\""] = ::noteTrackPoseProne;
  anim.notetracks["anim_pose = \"crawl\""] = ::noteTrackPoseCrawl;
  anim.notetracks["anim_pose = \"back\""] = ::noteTrackPoseBack;
  anim.notetracks["anim_movement = \"stop\""] = ::noteTrackMovementStop;
  anim.notetracks["anim_movement = \"walk\""] = ::noteTrackMovementWalk;
  anim.notetracks["anim_movement = \"run\""] = ::noteTrackMovementRun;
  anim.notetracks["anim_aiming = 1"] = ::noteTrackAlertnessAiming;
  anim.notetracks["anim_aiming = 0"] = ::noteTrackAlertnessAlert;
  anim.notetracks["anim_alertness = causal"] = ::noteTrackAlertnessCasual;
  anim.notetracks["anim_alertness = alert"] = ::noteTrackAlertnessAlert;
  anim.notetracks["anim_alertness = aiming"] = ::noteTrackAlertnessAiming;
  anim.notetracks["gunhand = (gunhand)_left"] = ::noteTrackGunhand;
  anim.notetracks["anim_gunhand = \"left\""] = ::noteTrackGunhand;
  anim.notetracks["anim_gunhand = \"leftright\""] = ::noteTrackGunhand;
  anim.notetracks["gunhand = (gunhand)_right"] = ::noteTrackGunhand;
  anim.notetracks["anim_gunhand = \"right\""] = ::noteTrackGunhand;
  anim.notetracks["anim_gunhand = \"none\""] = ::noteTrackGunhand;
  anim.notetracks["gun drop"] = ::noteTrackGunDrop;
  anim.notetracks["dropgun"] = ::noteTrackGunDrop;
  anim.notetracks["gun_2_chest"] = ::noteTrackGunToChest;
  anim.notetracks["gun_2_back"] = ::noteTrackGunToBack;
  anim.notetracks["pistol_pickup"] = ::noteTrackPistolPickup;
  anim.notetracks["pistol_putaway"] = ::noteTrackPistolPutaway;
  anim.notetracks["drop clip"] = ::noteTrackDropClip;
  anim.notetracks["refill clip"] = ::noteTrackRefillClip;
  anim.notetracks["reload done"] = ::noteTrackRefillClip;
  anim.notetracks["load_shell"] = ::noteTrackLoadShell;
  anim.notetracks["pistol_rechamber"] = ::noteTrackPistolRechamber;
  anim.notetracks["gravity on"] = ::noteTrackGravity;
  anim.notetracks["gravity off"] = ::noteTrackGravity;
  anim.notetracks["bodyfall large"] = ::noteTrackBodyFall;
  anim.notetracks["bodyfall small"] = ::noteTrackBodyFall;
  anim.notetracks["footstep"] = ::noteTrackFootStep;
  anim.notetracks["step"] = ::noteTrackFootStep;
  anim.notetracks["footstep_right_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_right_small"] = ::noteTrackFootStep;
  anim.notetracks["footstep_left_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_left_small"] = ::noteTrackFootStep;
  anim.notetracks["footscrape"] = ::noteTrackFootScrape;
  anim.notetracks["land"] = ::noteTrackLand;
  anim.notetracks["start_ragdoll"] = ::noteTrackStartRagdoll;
  anim.notetracks["fire"] = ::noteTrackFire;
  anim.notetracks["fire_spray"] = ::noteTrackFireSpray;
}

noteTrackFire(note, flagName) {
  if(!isSentient(self)) {
    return;
  }
  if(isDefined(anim.fire_notetrack_functions[self.a.script])) {
    thread[[anim.fire_notetrack_functions[self.a.script]]]();
  }
  else {
    thread[[animscripts\shared::shootNotetrack]]();
  }
}

noteTrackStopAnim(note, flagName) {}
noteTrackStartRagdoll(note, flagName) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  self unlink();
  self startRagdoll();
}

noteTrackMovementStop(note, flagName) {
  if(issentient(self)) {
    self.a.movement = "stop";
  }
}

noteTrackMovementWalk(note, flagName) {
  if(issentient(self)) {
    self.a.movement = "walk";
  }
}

noteTrackMovementRun(note, flagName) {
  if(issentient(self)) {
    self.a.movement = "run";
  }
}

noteTrackAlertnessAiming(note, flagName) {
  if(issentient(self)) {
    self.a.alertness = "aiming";
  }
}

noteTrackAlertnessCasual(note, flagName) {
  if(issentient(self)) {
    self.a.alertness = "casual";
  }
}

noteTrackAlertnessAlert(note, flagName) {
  if(issentient(self)) {
    self.a.alertness = "alert";
  }
}

noteTrackPoseStand(note, flagName) {
  if(self.a.pose == "prone") {
    self OrientMode("face default");
    self ExitProneWrapper(1.0);
  }
  self.a.pose = "stand";
  self notify("entered_pose" + "stand");
}

noteTrackPoseCrouch(note, flagName) {
  if(self.a.pose == "prone") {
    self OrientMode("face default");
    self ExitProneWrapper(1.0);
  }
  self.a.pose = "crouch";
  self notify("entered_pose" + "crouch");
  if(self.a.crouchPain) {
    self.a.crouchPain = false;
    self.health = 150;
  }
}

noteTrackPoseProne(note, flagName) {
  self setProneAnimNodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  self EnterProneWrapper(1.0);
  self.a.pose = "prone";
  self notify("entered_pose" + "prone");
}

noteTrackPoseCrawl(note, flagName) {
  self setProneAnimNodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  self EnterProneWrapper(1.0);
  self.a.pose = "prone";
  self notify("entered_pose" + "prone");
}

noteTrackPoseBack(note, flagName) {
  if(self.a.pose == "prone") {
    self ExitProneWrapper(1.0);
  }
  self.a.pose = "back";
  self notify("entered_pose" + "back");
  self.a.movement = "stop";
}

noteTrackGunHand(note, flagName) {
  if(isSubStr(note, "leftright")) {
    animscripts\shared::placeWeaponOn(self.weapon, "left");
    self thread placeWeaponOnRightOnInterrupt();
  } else if(isSubStr(note, "left")) {
    animscripts\shared::placeWeaponOn(self.weapon, "left");
    self notify("placed_weapon_on_left");
  } else if(isSubStr(note, "right")) {
    animscripts\shared::placeWeaponOn(self.weapon, "right");
    self notify("placed_weapon_on_right");
  } else if(isSubStr(note, "none"))
    animscripts\shared::placeWeaponOn(self.weapon, "none");
}

placeWeaponOnRightOnInterrupt() {
  self endon("death");
  self endon("placed_weapon_on_right");
  self waittill("killanimscript");
  if(AIHasWeapon(self.weapon)) {
    animscripts\shared::placeWeaponOn(self.weapon, "right");
  }
}

noteTrackGunDrop(note, flagName) {
  self animscripts\shared::DropAIWeapon();
  if(self.weapon == self.primaryweapon) {
    self.weapon = self.secondaryweapon;
  }
  else if(self.weapon == self.secondaryweapon) {
    self.weapon = self.primaryweapon;
  }
  self.lastWeapon = self.weapon;
}

noteTrackGunToChest(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "chest");
}

noteTrackGunToBack(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "back");
  self.weapon = self getPreferredWeapon();
  self.bulletsInClip = weaponClipSize(self.weapon);
}

noteTrackPistolPickup(note, flagName) {
  animscripts\shared::placeWeaponOn(self.sidearm, "right");
  self.bulletsInClip = weaponClipSize(self.weapon);
  self notify("weapon_switch_done");
}

noteTrackPistolPutaway(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "none");
  self.weapon = self getPreferredWeapon();
  self.bulletsInClip = weaponClipSize(self.weapon);
}

noteTrackDropClip(note, flagName) {
  self thread handleDropClip(flagName);
}

noteTrackRefillClip(note, flagName) {
  if(weaponClass(self.weapon) == "rocketlauncher") {
    self showRocket();
  }
  self animscripts\weaponList::RefillClip();
}

noteTrackLoadShell(note, flagName) {
  self playSound("weap_reload_shotgun_loop_npc");
}

noteTrackPistolRechamber(note, flagName) {
  self playSound("weap_reload_pistol_chamber_npc");
}

noteTrackGravity(note, flagName) {
  if(isSubStr(note, "on")) {
    self animMode("gravity");
  }
  else if(isSubStr(note, "off")) {
    self animMode("nogravity");
  }
}

noteTrackBodyFall(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  }
  else {
    groundType = "dirt";
  }
  if(isSubStr(note, "large")) {
    self playSound("bodyfall_" + groundType + "_large");
  }
  else if(isSubStr(note, "small")) {
    self playSound("bodyfall_" + groundType + "_small");
  }
}

noteTrackFootStep(note, flagName) {
  if(isSubStr(note, "left")) {
    playFootStep("J_Ball_LE");
  }
  else {
    playFootStep("J_BALL_RI");
  }
  if(!level.clientScripts) {
    self playSound("gear_rattle_run");
  }
}

noteTrackFootScrape(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  }
  else {
    groundType = "dirt";
  }
  self playSound("step_scrape_" + groundType);
}

noteTrackLand(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  }
  else {
    groundType = "dirt";
  }
  self playSound("land_" + groundType);
}

HandleNoteTrack(note, flagName, customFunction, var1) {
  self thread showNoteTrack(note);
  if(isAI(self) && self.type == "dog") {
    if(HandleDogSoundNoteTracks(note)) {
  }
      return;
    }
  notetrackFunc = anim.notetracks[note];
  if(isDefined(notetrackFunc)) {
    return [[notetrackFunc]](note, flagName);
  }
  switch (note) {
    case "end":
    case "finish":
    case "undefined":
      if(isAI(self) && self.a.pose == "back") {}
      return note;
    case "swish small":
      self thread play_sound_in_space("gear_rattle_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      self thread play_sound_in_space("gear_rattle_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "rechamber":
      if(self usingShotgun()) {
        self playSound("weap_reload_shotgun_pump_npc");
      }
      break;
    case "no death":
      self.a.nodeath = true;
      break;
    case "no pain":
      self.allowpain = false;
      break;
    case "allow pain":
      self.allowpain = true;
      break;
    case "anim_melee = right":
    case "anim_melee = \"right\"":
      self.a.meleeState = "right";
      break;
    case "anim_melee = left":
    case "anim_melee = \"left\"":
      self.a.meleeState = "left";
      break;
    case "weapon_retrieve":
      break;
    case "swap taghelmet to tagleft":
      if(isDefined(self.hatModel)) {
        if(isDefined(self.helmetSideModel)) {
          self detach(self.helmetSideModel, "TAG_HELMETSIDE");
          self.helmetSideModel = undefined;
        }
        self detach(self.hatModel, "");
        self attach(self.hatModel, "TAG_WEAPON_LEFT");
        self.hatModel = undefined;
      }
      break;
    case "stop anim":
      anim_stopanimscripted();
      return note;
    default:
      if(isDefined(customFunction)) {
        if(!isDefined(var1)) {
          return [
            [customFunction]
          ](note);
        } else {
          return [
            [customFunction]
          ](note, var1);
        }
      }
      break;
  }
}

DoNoteTracks(flagName, customFunction, debugIdentifier, var1) {
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    val = self HandleNoteTrack(note, flagName, customFunction, var1);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksIntercept(flagName, interceptFunction, debugIdentifier) {
  assert(isDefined(interceptFunction));
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    intercepted = [[interceptFunction]](note);
    if(isDefined(intercepted) && intercepted) {
      continue;
    }
    val = self HandleNoteTrack(note, flagName);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksPostCallback(flagName, postFunction) {
  assert(isDefined(postFunction));
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    val = self HandleNoteTrack(note, flagName);
    [[postFunction]](note);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksForever(flagName, killString, customFunction, debugIdentifier) {
  DoNoteTracksForeverProc(::DoNoteTracks, flagName, killString, customFunction, debugIdentifier);
}

DoNoteTracksForeverIntercept(flagName, killString, interceptFunction, debugIdentifier) {
  DoNoteTracksForeverProc(::DoNoteTracksIntercept, flagName, killString, interceptFunction, debugIdentifier);
}

DoNoteTracksForeverProc(notetracksFunc, flagName, killString, customFunction, debugIdentifier) {
  if(isDefined(killString)) {
    self endon(killString);
  }
  self endon("killanimscript");
  if(!isDefined(debugIdentifier)) {
    debugIdentifier = "undefined";
  }
  for(;;) {
    time = GetTime();
    returnedNote = [[notetracksFunc]](flagName, customFunction, debugIdentifier);
    timetaken = GetTime() - time;
    if(timetaken < 0.05) {
      time = GetTime();
      returnedNote = [
        [notetracksFunc]
      ](flagName, customFunction, debugIdentifier);
      timetaken = GetTime() - time;
      if(timetaken < 0.05) {
        println(GetTime() + " " + debugIdentifier + " animscripts\shared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagName + ", returned " + returnedNote + ".");
        wait(0.05 - timetaken);
      }
    }
  }
}

DoNoteTracksForTime(time, flagName, customFunction, debugIdentifier) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForever, time, flagName, customFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeIntercept(time, flagName, interceptFunction, debugIdentifier) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForeverIntercept, time, flagName, interceptFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeProc(doNoteTracksForeverFunc, time, flagName, customFunction, debugIdentifier, ent) {
  ent endon("stop_notetracks");
  [[doNoteTracksForeverFunc]](flagName, undefined, customFunction, debugIdentifier);
}

doNoteTracksForTimeEndNotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

playFootStep(foot) {
  if(!level.clientScripts) {
    if(!isAI(self)) {
      self playSound("step_run_dirt");
      return;
    }
  }
  groundType = undefined;
  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastGroundtype)) {
      if(!level.clientScripts) {
        self playSound("step_run_dirt");
      }
      return;
    }
    groundtype = self.lastGroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastGroundtype = self.groundType;
  }
  if(!level.clientScripts) {
    self playSound("step_run_" + groundType);
  }
  [[anim.optionalStepEffectFunction]](foot, groundType);
}

playFootStepEffect(foot, groundType) {
  if(level.clientScripts) {
    return;
  }
  for(i = 0; i < anim.optionalStepEffects.size; i++) {
    if(isDefined(self.fire_footsteps) && self.fire_footsteps) {
      groundType = "fire";
    }
    if(groundType != anim.optionalStepEffects[i]) {
      continue;
    }
    org = self gettagorigin(foot);
    playFX(level._effect["step_" + anim.optionalStepEffects[i]], org, org + (0, 0, 100));
    return;
  }
}

shootNotetrack() {
  waittillframeend;
  now = gettime();
  if(now > self.a.lastShootTime) {
    self.a.lastShootTime = now;
    self shootEnemyWrapper();
    self decrementBulletsInClip();
    if(weaponClass(self.weapon) == "rocketlauncher") {
      self.a.rockets--;
    }
  }
}

fire_straight() {
  if(self.a.weaponPos["right"] == "none" && self.a.weaponPos["left"] == "none") {
    return;
  }
  if(isDefined(self.dontShootStraight)) {
    shootNotetrack();
    return;
  }
  weaporig = self gettagorigin("tag_weapon");
  dir = anglesToForward(self gettagangles("tag_weapon"));
  pos = weaporig + vectorScale(dir, 1000);
  self.a.lastShootTime = gettime();
  self shoot(1, pos);
  self decrementBulletsInClip();
}

noteTrackFireSpray(note, flagName) {
  if(self.a.weaponPos["right"] == "none") {
    return;
  }
  weaporig = self gettagorigin("tag_weapon");
  dir = anglesToForward(self gettagangles("tag_weapon"));
  hitenemy = false;
  if(issentient(self.enemy) && isalive(self.enemy) && self canShoot(self.enemy getShootAtPos())) {
    enemydir = vectornormalize(self.enemy getEye() - weaporig);
    if(vectordot(dir, enemydir) > cos(10)) {
      hitenemy = true;
    }
  }
  if(hitenemy) {
    self shootEnemyWrapper();
  } else {
    dir += ((randomfloat(2) - 1) * .1, (randomfloat(2) - 1) * .1, (randomfloat(2) - 1) * .1);
    pos = weaporig + vectorScale(dir, 1000);
    self shootPosWrapper(pos);
  }
  self decrementBulletsInClip();
}

getPredictedAimYawToShootEntOrPos(time) {
  if(!isDefined(self.shootEnt)) {
    if(!isDefined(self.shootPos)) {
      return 0;
    }
    return getAimYawToPoint(self.shootPos);
  }
  predictedPos = self.shootEnt.origin + vectorScale(self.shootEntVelocity, time);
  return getAimYawToPoint(predictedPos);
}

getAimYawToShootEntOrPos() {
  if(!isDefined(self.shootEnt)) {
    if(!isDefined(self.shootPos)) {
      return 0;
    }
    return getAimYawToPoint(self.shootPos);
  }
  return getAimYawToPoint(self.shootEnt getShootAtPos());
}

getAimPitchToShootEntOrPos() {
  pitch = getPitchToShootEntOrPos();
  if(self.a.script == "cover_crouch" && isDefined(self.a.coverMode) && self.a.coverMode == "lean") {
    pitch -= anim.coverCrouchLeanPitch;
  }
  return pitch;
}

getPitchToShootEntOrPos() {
  if(!isDefined(self.shootEnt)) {
    if(!isDefined(self.shootPos)) {
      return 0;
    }
    return animscripts\combat_utility::getPitchToSpot(self.shootPos);
  }
  return animscripts\combat_utility::getPitchToSpot(self.shootEnt getShootAtPos());
}

getAimYawToPoint(point) {
  yaw = GetYawToSpot(point);
  dist = distance(self.origin, point);
  if(dist > 3) {
    angleFudge = asin(-3 / dist);
    yaw += angleFudge;
  }
  yaw = AngleClamp180(yaw);
  return yaw;
}

trackShootEntOrPos() {
  self endon("killanimscript");
  self endon("stop tracking");
  self endon("melee");
  if(self is_zombie()) {
    return;
  }
  trackLoop( % aim_2, % aim_4, % aim_6, % aim_8);
}

trackLoop(aim2, aim4, aim6, aim8) {
  players = GetPlayers();
  deltaChangePerFrame = 5;
  aimBlendTime = .05;
  prevYawDelta = 0;
  prevPitchDelta = 0;
  maxYawDeltaChange = 5;
  maxPitchDeltaChange = 5;
  pitchAdd = 0;
  yawAdd = 0;
  if(self.type == "dog") {
    doMaxAngleCheck = false;
    self.shootEnt = self.enemy;
  } else {
    doMaxAngleCheck = true;
    if(self.a.script == "cover_crouch" && isDefined(self.a.coverMode) && self.a.coverMode == "lean") {
      pitchAdd = -1 * anim.coverCrouchLeanPitch;
    }
    if((self.a.script == "cover_left" || self.a.script == "cover_right") && isDefined(self.a.cornerMode) && self.a.cornerMode == "lean") {
      yawAdd = self.coverNode.angles[1] - self.angles[1];
    }
  }
  yawDelta = 0;
  pitchDelta = 0;
  firstFrame = true;
  for(;;) {
    incrAnimAimWeight();
    selfShootAtPos = (self.origin[0], self.origin[1], self geteyeapprox()[2]);
    shootPos = self.shootPos;
    if(isDefined(self.shootEnt)) {
      shootPos = self.shootEnt getShootAtPos();
    }
    if(!isDefined(shootPos) && self animscripts\cqb::shouldCQB()) {
      selfForward = anglesToForward(self.angles);
      if(isDefined(self.cqb_target)) {
        shootPos = self.cqb_target getShootAtPos();
        dir = shootPos - selfShootAtPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir))) {
          shootPos = undefined;
        }
      }
      if(!isDefined(shootPos) && isDefined(self.cqb_point_of_interest)) {
        shootPos = self.cqb_point_of_interest;
        dir = shootPos - selfShootAtPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir))) {
          shootPos = undefined;
        }
      }
    }
    if(!isDefined(shootPos)) {
      assert(!isDefined(self.shootEnt));
      if(isDefined(self.node) && self.node.type == "Guard" && distanceSquared(self.origin, self.node.origin) < 16) {
        yawDelta = AngleClamp180(self.angles[1] - self.node.angles[1]);
        pitchDelta = 0;
      } else {
        likelyEnemyDir = self getAnglesToLikelyEnemyPath();
        if(isDefined(likelyEnemyDir)) {
          yawDelta = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
          pitchDelta = AngleClamp180(360 - likelyEnemyDir[0]);
        } else {
          yawDelta = 0;
          pitchDelta = 0;
        }
      }
    } else {
      vectorToShootPos = shootPos - selfShootAtPos;
      anglesToShootPos = vectorToAngles(vectorToShootPos);
      pitchDelta = 360 - anglesToShootPos[0];
      pitchDelta = AngleClamp180(pitchDelta + pitchAdd);
      yawDelta = self.angles[1] - anglesToShootPos[1];
      yawDelta = AngleClamp180(yawDelta + yawAdd);
    }
    if(doMaxAngleCheck && (abs(yawDelta) > 60 || abs(pitchDelta) > 60)) {
      yawDelta = 0;
      pitchDelta = 0;
    } else {
      if(yawDelta > self.rightAimLimit) {
        yawDelta = self.rightAimLimit;
      }
      else if(yawDelta < self.leftAimLimit) {
        yawDelta = self.leftAimLimit;
      }
      if(pitchDelta > self.upAimLimit) {
        pitchDelta = self.upAimLimit;
      }
      else if(pitchDelta < self.downAimLimit) {
        pitchDelta = self.downAimLimit;
      }
    }
    if(firstFrame) {
      firstFrame = false;
    } else {
      yawDeltaChange = yawDelta - prevYawDelta;
      if(abs(yawDeltaChange) > maxYawDeltaChange) {
        yawDelta = prevYawDelta + maxYawDeltaChange * sign(yawDeltaChange);
      }
      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(abs(pitchDeltaChange) > maxPitchDeltaChange) {
        pitchDelta = prevPitchDelta + maxPitchDeltaChange * sign(pitchDeltaChange);
      }
    }
    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;
    if(yawDelta > 0) {
      assert(yawDelta <= self.rightAimLimit);
      weight = yawDelta / self.rightAimLimit * self.a.aimweight;
      self setAnimLimited(aim4, 0, aimBlendTime);
      self setAnimLimited(aim6, weight, aimBlendTime);
    } else if(yawDelta < 0) {
      assert(yawDelta >= self.leftAimLimit);
      weight = yawDelta / self.leftAimLimit * self.a.aimweight;
      self setAnimLimited(aim6, 0, aimBlendTime);
      self setAnimLimited(aim4, weight, aimBlendTime);
    }
    if(pitchDelta > 0) {
      assert(pitchDelta <= self.upAimLimit);
      weight = pitchDelta / self.upAimLimit * self.a.aimweight;
      self setAnimLimited(aim2, 0, aimBlendTime);
      self setAnimLimited(aim8, weight, aimBlendTime);
    } else if(pitchDelta < 0) {
      assert(pitchDelta >= self.downAimLimit);
      weight = pitchDelta / self.downAimLimit * self.a.aimweight;
      self setAnimLimited(aim8, 0, aimBlendTime);
      self setAnimLimited(aim2, weight, aimBlendTime);
    }
    if(players.size == 1) {
      wait(0.05);
    } else {
      wait(1);
    }
  }
}

setAnimAimWeight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = goalweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = 0;
  } else {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = int(goaltime * 20);
  }
  self.a.aimweight_t = 0;
}

incrAnimAimWeight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
  }
}

decideNumShotsForBurst() {
  numShots = 0;
  if(animscripts\weaponList::usingSemiAutoWeapon()) {
    numShots = anim.semiFireNumShots[randomint(anim.semiFireNumShots.size)];
  }
  else if(self.fastBurst) {
    numShots = anim.fastBurstFireNumShots[randomint(anim.fastBurstFireNumShots.size)];
  }
  else {
    numShots = anim.burstFireNumShots[randomint(anim.burstFireNumShots.size)];
  }
  if(numShots <= self.bulletsInClip) {
    return numShots;
  }
  assertex(self.bulletsInClip >= 0, self.bulletsInClip);
  if(self.bulletsInClip <= 0) {
    return 1;
  }
  return self.bulletsInClip;
}

decideNumShotsForFull() {
  numShots = self.bulletsInClip;
  if(weaponClass(self.weapon) == "mg") {
    choice = randomfloat(10);
    if(choice < 3) {
      numShots = randomIntRange(2, 6);
    }
    else if(choice < 8) {
      numShots = randomIntRange(6, 12);
    }
    else {
      numShots = randomIntRange(12, 20);
    }
  }
  return numShots;
}

handleDropClip(flagName) {
  self endon("killanimscript");
  self endon("abort_reload");
  clipModel = undefined;
  if(self.weaponInfo[self.weapon].useClip) {
    clipModel = getWeaponClipModel(self.weapon);
    if(!isDefined(level.weaponClipModelsLoaded) || !isDefined(anim._effect[clipModel])) {
      println("^1Warning: Couldn't drop clip model " + clipModel + " because it is not in level.weaponClipModels so it probably wasn't precached.");
      println("^1Set dvar scr_generateClipModels to 1 and map_restart, then follow instructions in console.");
      clipModel = undefined;
    }
  }
  if(self.weaponInfo[self.weapon].hasClip) {
    if(weaponAnims() == "pistol") {
      self playSound("weap_reload_pistol_clipout_npc");
    }
    else {
      self playSound("weap_reload_smg_clipout_npc");
    }
    if(isDefined(clipModel)) {
      self hidepart("tag_clip");
      assert(isDefined(anim._effect[clipModel]));
      playFXOnTag(anim._effect[clipModel], self, "tag_clip");
      self.weaponInfo[self.weapon].hasClip = false;
      self thread resetClipOnAbort(clipModel);
    }
  }
  for(;;) {
    self waittill(flagName, noteTrack);
    switch (noteTrack) {
      case "attach clip left":
      case "attach clip right":
        if(isDefined(clipModel)) {
          self attach(clipModel, "tag_inhand");
          self hidepart("tag_clip");
          self thread resetClipOnAbort(clipModel, "tag_inhand");
        }
        self animscripts\weaponList::RefillClip();
        break;
      case "detach clip right":
      case "detach clip left":
        if(isDefined(clipModel)) {
          self detach(clipModel, "tag_inhand");
          self showpart("tag_clip");
          self notify("clip_detached");
          self.weaponInfo[self.weapon].hasClip = true;
        }
        if(weaponAnims() == "pistol") {
          self playSound("weap_reload_pistol_clipin_npc");
        }
        else {
          self playSound("weap_reload_smg_clipin_npc");
        }
        return;
    }
  }
}

resetClipOnAbort(clipModel, currentTag) {
  self notify("clip_detached");
  self endon("clip_detached");
  self waittill_any("killanimscript", "abort_reload");
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(currentTag)) {
    self detach(clipModel, currentTag);
  }
  if(isAlive(self)) {
    self showpart("tag_clip");
    self.weaponInfo[self.weapon].hasClip = true;
  } else {
    if(isDefined(currentTag) && isDefined(anim._effect[clipModel])) {
      playFXOnTag(anim._effect[clipModel], self, currentTag);
    }
  }
}

moveToOriginOverTime(origin, time) {
  self endon("killanimscript");
  if(distanceSquared(self.origin, origin) > 16 * 16 && !self mayMoveToPoint(origin)) {
    println("^1Warning: AI starting behavior for node at " + origin + " but could not move to that point.");
    return;
  }
  self.keepClaimedNodeInGoal = true;
  offset = self.origin - origin;
  frames = int(time * 20);
  offsetreduction = vectorScale(offset, 1.0 / frames);
  for(i = 0; i < frames; i++) {
    offset -= offsetreduction;
    self teleport(origin + offset);
    wait .05;
  }
  self.keepClaimedNodeInGoal = false;
}

returnTrue() {
  return true;
}

playLookAnimation(lookAnim, lookTime, canStopCallback) {
  if(!isDefined(canStopCallback)) {
    canStopCallback = ::returnTrue;
  }
  for(i = 0; i < lookTime * 10; i++) {
    if(isalive(self.enemy)) {
      if(self canSeeEnemy() && [
          [canStopCallback]
        ]())
        return;
    }
    if(self isSuppressedWrapper() && [
        [canStopCallback]
      ]()) {
      return;
    }
    self setAnimKnobAll(lookAnim, % body, 1, .1);
    wait(0.1);
  }
}

throwDownWeapon(swapAnim) {
  self endon("killanimscript");
  self animMode("angle deltas");
  self setFlaggedAnimKnobAllRestart("weapon swap", swapAnim, % body, 1, .1, 1);
  note = "";
  while(note != "end") {
    self waittill("weapon swap", note);
    if(note == "dropgun" || note == "gun drop") {
      DropAIWeapon();
    }
    if(note == "anim_gunhand = \"right\"") {
      assertex(isDefined(self.secondaryweapon), "self.secondaryweapon not defined! check the aitype for this actor. ");
      self animscripts\shared::placeWeaponOn(self.primaryweapon, "none");
      self animscripts\shared::placeWeaponOn(self.secondaryweapon, "right");
    }
  }
  self maps\_gameskill::didSomethingOtherThanShooting();
}