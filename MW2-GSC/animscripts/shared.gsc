/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: animscripts\shared.gsc
********************************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include common_scripts\utility;
#using_animtree("generic_human");

placeWeaponOn(weapon, position, activeWeapon) {
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

  if(!isDefined(activeWeapon)) {
    activeWeapon = true;
  }

  if(activeWeapon && (position == "left" || position == "right")) {
    self attachWeapon(weapon, position);
    self.weapon = weapon;
  } else {
    self attachWeapon(weapon, position);
  }

  self updateAttachedWeaponModels();
}

detachWeapon(weapon) {
  self.a.weaponPos[self.weaponInfo[weapon].position] = "none";
  self.weaponInfo[weapon].position = "none";
}

attachWeapon(weapon, position) {
  self.weaponInfo[weapon].position = position;
  self.a.weaponPos[position] = weapon;

  if(self.a.weaponPosDropping[position] != "none") {
    self notify("end_weapon_drop_" + position);
    self.a.weaponPosDropping[position] = "none";
  }
}

getWeaponForPos(position) {
  weapon = self.a.weaponPos[position];

  if(weapon == "none") {
    return self.a.weaponPosDropping[position];
  }

  assert(self.a.weaponPosDropping[position] == "none");

  return weapon;
}

detachAllWeaponModels() {
  positions = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";

  self laserOff();

  foreach(position in positions) {
    weapon = self getWeaponForPos(position);

    if(weapon == "none") {
      continue;
    }
    self detach(getWeaponModel(weapon), getTagForPos(position));
  }
}

NO_COLLISION = true;

updateAttachedWeaponModels() {
  positions = [];
  positions[positions.size] = "right";
  positions[positions.size] = "left";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";

  foreach(position in positions) {
    weapon = self getWeaponForPos(position);

    if(weapon == "none") {
      continue;
    }
    weapon_model = getWeaponModel(weapon);
    assertEx(weapon_model != "", "No weapon model for '" + weapon + "', make sure it is precached");

    if(weapon == "riotshield") {
      self attach(weapon_model, getTagForPos(position));
    } else {
      self attach(weapon_model, getTagForPos(position), NO_COLLISION);
    }

    hideTagList = GetWeaponHideTags(weapon);
    for(i = 0; i < hideTagList.size; i++) {
      self HidePart(hideTagList[i], weapon_model);
    }

    if(self.weaponInfo[weapon].useClip && !self.weaponInfo[weapon].hasClip) {
      self hidepart("tag_clip");
    }
  }

  self updateLaserStatus();
}

updateLaserStatus() {
  if(isDefined(self.custom_laser_function)) {
    [[self.custom_laser_function]]();
    return;
  }

  if(self.a.weaponPos["right"] == "none") {
    return;
  }
  if(canUseLaser()) {
    self laserOn();
  } else {
    self laserOff();
  }
}

canUseLaser() {
  if(!self.a.laserOn) {
    return false;
  }

  if(isShotgun(self.weapon)) {
    return false;
  }

  return isAlive(self);
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

DropAIWeapon(weapon) {
  if(!isDefined(weapon)) {
    weapon = self.weapon;
  }

  if(weapon == "none") {
    return;
  }
  if(isDefined(self.noDrop)) {
    return;
  }
  self detachAllWeaponModels();

  position = self.weaponInfo[weapon].position;

  if(self.dropWeapon && position != "none") {
    self thread DropWeaponWrapper(weapon, position);
  }

  self detachWeapon(weapon);
  if(weapon == self.weapon) {
    self.weapon = "none";
  }

  self updateAttachedWeaponModels();
}

DropAllAIWeapons() {
  if(isDefined(self.noDrop)) {
    return "none";
  }

  positions = [];
  positions[positions.size] = "left";
  positions[positions.size] = "right";
  positions[positions.size] = "chest";
  positions[positions.size] = "back";

  self detachAllWeaponModels();

  foreach(position in positions) {
    weapon = self.a.weaponPos[position];

    if(weapon == "none") {
      continue;
    }
    self.weaponInfo[weapon].position = "none";
    self.a.weaponPos[position] = "none";

    if(self.dropWeapon) {
      self thread DropWeaponWrapper(weapon, position);
    }
  }

  self.weapon = "none";

  self updateAttachedWeaponModels();
}

DropWeaponWrapper(weapon, position) {
  if(self IsRagdoll()) {
    return "none";
  }

  assert(self.a.weaponPosDropping[position] == "none");
  self.a.weaponPosDropping[position] = weapon;

  actualDroppedWeapon = weapon;
  if(issubstr(tolower(actualDroppedWeapon), "rpg")) {
    actualDroppedWeapon = "rpg_player";
  }

  self DropWeapon(actualDroppedWeapon, position, 0);

  self endon("end_weapon_drop_" + position);
  wait .1;

  if(!isDefined(self)) {
    return;
  }
  self detachAllWeaponModels();
  self.a.weaponPosDropping[position] = "none";
  self updateAttachedWeaponModels();
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
  } else if(note == "undefined") {
    color = (1, .5, .5);
  }

  for(i = 0; i < duration; i++) {
    if(duration - i <= anim.showNotetrackDuration) {
      amnt = 1.0 * (i - (duration - anim.showNotetrackDuration)) / anim.showNotetrackDuration;
    } else {
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
  if(note == "sound_dogstep_run_default") {
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
  } else {
    self thread play_sound_in_space(alias, self getEye());
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

  anim.notetracks["footstep_right_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_right_small"] = ::noteTrackFootStepSmall;
  anim.notetracks["footstep_left_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_left_small"] = ::noteTrackFootStepSmall;
  anim.notetracks["footscrape"] = ::noteTrackFootScrape;
  anim.notetracks["land"] = ::noteTrackLand;

  anim.notetracks["code_move"] = ::noteTrackCodeMove;
  anim.notetracks["face_enemy"] = ::noteTrackFaceEnemy;

  anim.notetracks["laser_on"] = ::noteTrackLaser;
  anim.notetracks["laser_off"] = ::noteTrackLaser;

  anim.notetracks["start_ragdoll"] = ::noteTrackStartRagdoll;

  anim.notetracks["fire"] = ::noteTrackFire;
  anim.notetracks["fire_spray"] = ::noteTrackFireSpray;

  anim.notetracks["bloodpool"] = animscripts\death::play_blood_pool;

  anim.notetracks["attach clip left"] = animscripts\shared::insure_dropping_clip;
  anim.notetracks["attach clip right"] = animscripts\shared::insure_dropping_clip;
  anim.notetracks["detach clip left"] = animscripts\shared::insure_dropping_clip;
  anim.notetracks["detach clip right"] = animscripts\shared::insure_dropping_clip;

  if(isDefined(level._notetrackFX)) {
    keys = getArrayKeys(level._notetrackFX);
    foreach(key in keys) {
      anim.notetracks[key] = ::customNotetrackFX;
    }
  }
}

noteTrackFire(note, flagName) {
  if(isDefined(anim.fire_notetrack_functions[self.script])) {
    thread[[anim.fire_notetrack_functions[self.script]]]();
  } else {
    thread[[animscripts\shared::shootNotetrack]]();
  }
}

noteTrackLaser(note, flagName) {
  if(isSubStr(note, "on")) {
    self.a.laserOn = true;
  } else {
    self.a.laserOn = false;
  }
  self animscripts\shared::updateLaserStatus();
}

noteTrackStopAnim(note, flagName) {}

unlinkNextFrame() {
  wait .1;
  if(isDefined(self)) {
    self unlink();
  }
}

noteTrackStartRagdoll(note, flagName) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  if(!isDefined(self.dont_unlink_ragdoll)) {
    self thread unlinkNextFrame();
  }
  self startRagdoll();

  if(isalive(self)) {
    println("^4Warning!! Living guy did ragdoll!");
  }
}

noteTrackMovementStop(note, flagName) {
  self.a.movement = "stop";
}

noteTrackMovementWalk(note, flagName) {
  self.a.movement = "walk";
}

noteTrackMovementRun(note, flagName) {
  self.a.movement = "run";
}

noteTrackAlertnessAiming(note, flagName) {}

noteTrackAlertnessCasual(note, flagName) {}

noteTrackAlertnessAlert(note, flagName) {}

stopOnBack() {
  self ExitProneWrapper(1.0);
  self.a.onback = undefined;
}

setPose(pose) {
  self.a.pose = pose;

  if(isDefined(self.a.onback)) {
    stopOnBack();
  }

  self notify("entered_pose" + pose);
}

noteTrackPoseStand(note, flagName) {
  if(self.a.pose == "prone") {
    self OrientMode("face default");
    self ExitProneWrapper(1.0);
  }
  setPose("stand");
}

noteTrackPoseCrouch(note, flagName) {
  if(self.a.pose == "prone") {
    self OrientMode("face default");
    self ExitProneWrapper(1.0);
  }
  setPose("crouch");
}

noteTrackPoseProne(note, flagName) {
  if(!issentient(self)) {
    return;
  }
  self setProneAnimNodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(1.0);
  setPose("prone");

  if(isDefined(self.a.goingToProneAim)) {
    self.a.proneAiming = true;
  } else {
    self.a.proneAiming = undefined;
  }
}

noteTrackPoseCrawl(note, flagName) {
  if(!issentient(self)) {
    return;
  }
  self setProneAnimNodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(1.0);
  setPose("prone");
  self.a.proneAiming = undefined;
}

noteTrackPoseBack(note, flagName) {
  if(!issentient(self)) {
    return;
  }
  setPose("crouch");
  self.a.onback = true;
  self.a.movement = "stop";

  self setProneAnimNodes(-90, 90, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  self EnterProneWrapper(1.0);
}

noteTrackGunHand(note, flagName) {
  if(isSubStr(note, "left")) {
    animscripts\shared::placeWeaponOn(self.weapon, "left");
    self notify("weapon_switch_done");
  } else if(isSubStr(note, "right")) {
    animscripts\shared::placeWeaponOn(self.weapon, "right");
    self notify("weapon_switch_done");
  } else if(isSubStr(note, "none")) {
    animscripts\shared::placeWeaponOn(self.weapon, "none");
  }
}

noteTrackGunDrop(note, flagName) {
  self DropAIWeapon();

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
  self.a.needsToRechamber = 0;
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
  } else if(isSubStr(note, "off")) {
    self animMode("nogravity");
  }
}

noteTrackFootStep(note, flagName) {
  if(isSubStr(note, "left")) {
    playFootStep("J_Ball_LE");
  } else {
    playFootStep("J_BALL_RI");
  }

  self playSound("gear_rattle_run");
}

noteTrackFootStepSmall(note, flagName) {
  if(isSubStr(note, "left")) {
    playFootStepSmall("J_Ball_LE");
  } else {
    playFootStepSmall("J_BALL_RI");
  }

  self playSound("gear_rattle_run");
}

customNotetrackFX(note, flagName) {
  assert(isDefined(level._notetrackFX[note]));

  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }

  fxStruct = undefined;
  if(isDefined(level._notetrackFX[note][groundType])) {
    fxStruct = level._notetrackFX[note][groundType];
  } else if(isDefined(level._notetrackFX[note]["all"])) {
    fxStruct = level._notetrackFX[note]["all"];
  }

  if(!isDefined(fxStruct)) {
    return;
  }
  if(isAI(self)) {
    playFXOnTag(fxStruct.fx, self, fxStruct.tag);
  }

  if(!isDefined(fxStruct.sound_prefix) && !isDefined(fxStruct.sound_suffix)) {
    return;
  }
  soundAlias = "" + fxStruct.sound_prefix + groundType + fxStruct.sound_suffix;
  self playSound(soundAlias);
}

noteTrackFootScrape(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }

  self playSound("step_scrape_" + groundType);
}

noteTrackLand(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }

  self playSound("land_" + groundType);
}

noteTrackCodeMove(note, flagName) {
  return "code_move";
}

noteTrackFaceEnemy(note, flagName) {
  if(self.script != "reactions") {
    self orientmode("face enemy");
  } else {
    if(isDefined(self.enemy) && distanceSquared(self.enemy.origin, self.reactionTargetPos) < 64 * 64) {
      self orientmode("face enemy");
    } else {
      self orientmode("face point", self.reactionTargetPos);
    }
  }
}

HandleNoteTrack(note, flagName, customFunction) {
  self thread showNoteTrack(note);

  if(isAI(self) && self.type == "dog") {
    if(HandleDogSoundNoteTracks(note)) {}
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
      return note;

    case "finish early":
      if(isDefined(self.enemy)) {
        return note;
      }
      break;

    case "swish small":
      self thread play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      self thread play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;

    case "rechamber":
      if(weapon_pump_action_shotgun()) {
        self playSound("weap_reload_shotgun_pump_npc");
      }
      self.a.needsToRechamber = 0;
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
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    default:
      if(isDefined(customFunction)) {
        return [[customFunction]](note);
      }
      break;
  }
}
DoNoteTracks(flagName, customFunction, debugIdentifier) {
  for(;;) {
    self waittill(flagName, note);

    if(!isDefined(note)) {
      note = "undefined";
    }

    val = self HandleNoteTrack(note, flagName, customFunction);

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

DoNoteTracksForTimeout(flagName, killString, customFunction, debugIdentifier) {
  DoNoteTracks(flagName, customFunction, debugIdentifier);
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

      returnedNote = [[notetracksFunc]](flagName, customFunction, debugIdentifier);

      timetaken = GetTime() - time;
      if(timetaken < 0.05) {
        println(GetTime() + " " + debugIdentifier + " animscripts\shared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagName + ", returned " + returnedNote + ".");
        wait(0.05 - timetaken);
      }
    }

  }
}
DoNoteTracksWithTimeout(flagName, time, customFunction, debugIdentifier) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForTimeout, flagName, customFunction, debugIdentifier, ent);
}
DoNoteTracksForTime(time, flagName, customFunction, debugIdentifier) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForever, flagName, customFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeIntercept(time, flagName, interceptFunction, debugIdentifier) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForeverIntercept, flagName, interceptFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeProc(doNoteTracksForeverFunc, flagName, customFunction, debugIdentifier, ent) {
  ent endon("stop_notetracks");
  [[doNoteTracksForeverFunc]](flagName, undefined, customFunction, debugIdentifier);
}

doNoteTracksForTimeEndNotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

playFootStep(foot) {
  if(!isAI(self)) {
    self playSound("step_run_dirt");
    return;
  }

  groundType = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastGroundtype)) {
      self playSound("step_run_dirt");
      return;
    }

    groundtype = self.lastGroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastGroundtype = self.groundType;
  }

  self playSound("step_run_" + groundType);
  if(![[anim.optionalStepEffectFunction]](foot, groundType)) {
    playFootStepEffectSmall(foot, groundType);
  }
}

playFootStepSmall(foot) {
  if(!isAI(self)) {
    self playSound("step_run_dirt");
    return;
  }

  groundType = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastGroundtype)) {
      self playSound("step_run_dirt");
      return;
    }

    groundtype = self.lastGroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastGroundtype = self.groundType;
  }

  self playSound("step_run_" + groundType);
  if(![[anim.optionalStepEffectSmallFunction]](foot, groundType)) {
    playFootStepEffect(foot, groundType);
  }
}

playFootStepEffect(foot, groundType) {
  for(i = 0; i < anim.optionalStepEffects.size; i++) {
    if(groundType != anim.optionalStepEffects[i]) {
      continue;
    }
    org = self gettagorigin(foot);
    angles = self.angles;
    forward = anglesToForward(angles);
    back = forward * -1;
    up = anglestoup(angles);

    playFX(level._effect["step_" + anim.optionalStepEffects[i]], org, up, back);
    return true;
  }

  return false;
}

playFootStepEffectSmall(foot, groundType) {
  for(i = 0; i < anim.optionalStepEffectsSmall.size; i++) {
    if(groundType != anim.optionalStepEffectsSmall[i]) {
      continue;
    }
    org = self gettagorigin(foot);
    angles = self.angles;
    forward = anglesToForward(angles);
    back = forward * -1;
    up = anglestoup(angles);

    playFX(level._effect["step_small_" + anim.optionalStepEffectsSmall[i]], org, up, back);
    return true;
  }
  return false;
}

shootNotetrack() {
  waittillframeend;
  if(isDefined(self) && gettime() > self.a.lastShootTime) {
    self shootEnemyWrapper();
    self decrementBulletsInClip();
    if(weaponClass(self.weapon) == "rocketlauncher") {
      self.a.rockets--;
    }
  }
}

fire_straight() {
  if(self.a.weaponPos["right"] == "none") {
    return;
  }
  if(isDefined(self.dontShootStraight)) {
    shootNotetrack();
    return;
  }

  weaporig = self gettagorigin("tag_weapon");
  dir = anglesToForward(self getMuzzleAngle());
  pos = weaporig + vector_multiply(dir, 1000);

  self shoot(1, pos);
  self decrementBulletsInClip();
}

noteTrackFireSpray(note, flagName) {
  if(!isalive(self) && self isBadGuy()) {
    if(isDefined(self.changed_team)) {
      return;
    }
    self.changed_team = true;
    teams["axis"] = "team3";
    teams["team3"] = "axis";
    assertex(isDefined(teams[self.team]), "no team for " + self.team);
    self.team = teams[self.team];
  }

  if(!issentient(self)) {
    self notify("fire");

    return;
  }

  if(self.a.weaponPos["right"] == "none") {
    return;
  }

  weaporig = self getMuzzlePos();
  dir = anglesToForward(self getMuzzleAngle());

  ang = 10;
  if(isDefined(self.isRambo)) {
    ang = 20;
  }

  hitenemy = false;

  if(isalive(self.enemy) && issentient(self.enemy) && self canShootEnemy()) {
    enemydir = vectornormalize(self.enemy getEye() - weaporig);
    if(vectordot(dir, enemydir) > cos(ang)) {
      hitenemy = true;
    }
  }

  if(hitenemy) {
    self shootEnemyWrapper();
  } else {
    dir += ((randomfloat(2) - 1) * .1, (randomfloat(2) - 1) * .1, (randomfloat(2) - 1) * .1);
    pos = weaporig + vector_multiply(dir, 1000);

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

  predictedPos = self.shootEnt.origin + vector_multiply(self.shootEntVelocity, time);
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
  if(self.script == "cover_crouch" && isDefined(self.a.coverMode) && self.a.coverMode == "lean") {
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

getShootFromPos() {
  if(isDefined(self.useMuzzleSideOffset)) {
    muzzlePos = self getMuzzleSideOffsetPos();
    return (muzzlePos[0], muzzlePos[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
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

  assert(!isDefined(self.trackLoopThread));
  self.trackLoopThread = thisthread;
  self.trackLoopThreadType = "trackShootEntOrPos";

  trackLoop(%aim_2, %aim_4, %aim_6, %aim_8);
}
normalDeltaChangePerFrame = 10;
largeDeltaChangePerFrame = 30;

trackLoop(aim2, aim4, aim6, aim8) {
  assert(isDefined(self.trackLoopThread));

  prevYawDelta = 0;
  prevPitchDelta = 0;
  pitchAdd = 0;
  yawAdd = 0;
  wasOnStairs = false;
  angleDeltas = (0, 0, 0);
  firstFrame = true;
  prevMotionRelativeDir = 0;
  quickTurnFrames = 0;
  deltaChangePerFrame = normalDeltaChangePerFrame;

  if(self.type == "dog") {
    doMaxAngleCheck = false;
    self.shootEnt = self.enemy;
  } else {
    doMaxAngleCheck = true;

    if(isDefined(self.coverCrouchLean_aimmode)) {
      pitchAdd = anim.coverCrouchLeanPitch;
    }

    if((self.script == "cover_left" || self.script == "cover_right") && isDefined(self.a.cornerMode) && self.a.cornerMode == "lean") {
      yawAdd = self.coverNode.angles[1] - self.angles[1];
    }
  }

  for(;;) {
    incrAnimAimWeight();

    shootFromPos = getShootFromPos();

    shootPos = self.shootPos;
    if(isDefined(self.shootEnt)) {
      shootPos = self.shootEnt getShootAtPos();
    }

    if(!isDefined(shootPos) && self shouldCQB()) {
      shootPos = trackLoop_CQBShootPos(shootFromPos);
    }

    if(self.stairsState == "up") {
      pitchAdd = -40;
      wasOnStairs = true;
    } else if(self.stairsState == "down") {
      pitchAdd = 40;
      yawAdd = 12;
      wasOnStairs = true;
    } else if(wasOnStairs) {
      pitchAdd = 0;
      yawAdd = 0;
      wasOnStairs = false;
    }

    if(!isDefined(shootPos)) {
      angleDeltas = trackLoop_anglesForNoShootPos(shootFromPos, pitchAdd, yawAdd);
    } else {
      angleDeltas = trackLoop_getDesiredAngles((shootPos - shootFromPos), pitchAdd, yawAdd);
    }

    angleDeltas = trackLoop_clampAngles(angleDeltas[0], angleDeltas[1], doMaxAngleCheck);

    pitchDelta = angleDeltas[0];
    yawDelta = angleDeltas[1];

    if(quickTurnFrames > 0) {
      quickTurnFrames = quickTurnFrames - 1;
      deltaChangePerFrame = max(normalDeltaChangePerFrame, deltaChangePerFrame - 5);
    } else if(self.relativeDir && self.relativeDir != prevMotionRelativeDir) {
      quickTurnFrames = 2;
      deltaChangePerFrame = largeDeltaChangePerFrame;
    } else {
      deltaChangePerFrame = normalDeltaChangePerFrame;
    }

    deltaChangePerFrameSq = squared(deltaChangePerFrame);

    prevMotionRelativeDir = self.relativeDir;

    checkDeltaChange = (self.moveMode != "stop") || !firstFrame;

    if(checkDeltaChange) {
      yawDeltaChange = yawDelta - prevYawDelta;
      if(squared(yawDeltaChange) > deltaChangePerFrameSq) {
        yawDelta = prevYawDelta + clamp(yawDeltaChange, -1 * deltaChangePerFrame, deltaChangePerFrame);
        yawDelta = clamp(yawDelta, self.leftAimLimit, self.rightAimLimit);
      }

      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(squared(pitchDeltaChange) > deltaChangePerFrameSq) {
        pitchDelta = prevPitchDelta + clamp(pitchDeltaChange, -1 * deltaChangePerFrame, deltaChangePerFrame);
        pitchDelta = clamp(pitchDelta, self.downAimLimit, self.upAimLimit);
      }
    }

    firstFrame = false;
    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;

    trackLoop_setAnimWeights(aim2, aim4, aim6, aim8, pitchDelta, yawDelta);

    wait(0.05);
  }
}

trackLoop_CQBShootPos(shootFromPos) {
  shootPos = undefined;
  selfForward = anglesToForward(self.angles);

  if(isDefined(self.cqb_target)) {
    shootPos = self.cqb_target getShootAtPos();
    if(vectorDot(vectorNormalize(shootPos - shootFromPos), selfForward) < 0.643) {
      shootPos = undefined;
    }
  }
  if(!isDefined(shootPos) && isDefined(self.cqb_point_of_interest)) {
    shootPos = self.cqb_point_of_interest;
    if(vectorDot(vectorNormalize(shootPos - shootFromPos), selfForward) < 0.643) {
      shootPos = undefined;
    }
  }

  return shootPos;
}

trackLoop_anglesForNoShootPos(shootFromPos, pitchAdd, yawAdd) {
  assert(!isDefined(self.shootEnt));

  if(recentlySawEnemy()) {
    shootAtOffset = (self.enemy getShootAtPos() - self.enemy.origin);
    shootAtPos = (self lastKnownPos(self.enemy) + shootAtOffset);
    return trackLoop_getDesiredAngles((shootAtPos - shootFromPos), pitchAdd, yawAdd);
  }

  pitchDelta = 0;
  yawDelta = 0;

  if(isDefined(self.node) && isDefined(anim.isCombatScriptNode[self.node.type]) && distanceSquared(self.origin, self.node.origin) < 16) {
    yawDelta = AngleClamp180(self.angles[1] - self.node.angles[1]);
  } else {
    likelyEnemyDir = self getAnglesToLikelyEnemyPath();
    if(isDefined(likelyEnemyDir)) {
      yawDelta = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
      pitchDelta = AngleClamp180(360 - likelyEnemyDir[0]);
    }
  }

  return (pitchDelta, yawDelta, 0);
}

trackLoop_getDesiredAngles(vectorToShootPos, pitchAdd, yawAdd) {
  anglesToShootPos = vectorToAngles(vectorToShootPos);

  pitchDelta = 360 - anglesToShootPos[0];
  pitchDelta = AngleClamp180(pitchDelta + pitchAdd);

  if(isDefined(self.stepOutYaw)) {
    yawDelta = self.stepOutYaw - anglesToShootPos[1];
  } else {
    yawOffset = AngleClamp180(self.desiredAngle - self.angles[1]) * 0.5;
    yawDelta = yawOffset + self.angles[1] - anglesToShootPos[1];
  }
  yawDelta = AngleClamp180(yawDelta + yawAdd);

  return (pitchDelta, yawDelta, 0);
}

trackLoop_clampAngles(pitchDelta, yawDelta, doMaxAngleCheck) {
  if(isDefined(self.onSnowMobile)) {
    if(yawDelta > self.rightAimLimit || yawDelta < self.leftAimLimit) {
      yawDelta = 0;
    }
    if(pitchDelta > self.upAimLimit || pitchDelta < self.downAimLimit) {
      pitchDelta = 0;
    }
  } else if(doMaxAngleCheck && (abs(yawDelta) > anim.maxAngleCheckYawDelta || abs(pitchDelta) > anim.maxAngleCheckPitchDelta)) {
    yawDelta = 0;
    pitchDelta = 0;
  } else {
    if(self.gunBlockedByWall) {
      yawDelta = clamp(yawDelta, -10, 10);
    } else {
      yawDelta = clamp(yawDelta, self.leftAimLimit, self.rightAimLimit);
    }

    pitchDelta = clamp(pitchDelta, self.downAimLimit, self.upAimLimit);
  }

  return (pitchDelta, yawDelta, 0);
}

aimBlendTime = .1;

trackLoop_setAnimWeights(aim2, aim4, aim6, aim8, pitchDelta, yawDelta) {
  if(yawDelta > 0) {
    assert(yawDelta <= self.rightAimLimit);
    weight = yawDelta / self.rightAimLimit * self.a.aimweight;
    self setAnimLimited(aim4, 0, aimBlendTime, 1, true);
    self setAnimLimited(aim6, weight, aimBlendTime, 1, true);
  } else if(yawDelta < 0) {
    assert(yawDelta >= self.leftAimLimit);
    weight = yawDelta / self.leftAimLimit * self.a.aimweight;
    self setAnimLimited(aim6, 0, aimBlendTime, 1, true);
    self setAnimLimited(aim4, weight, aimBlendTime, 1, true);
  }

  if(pitchDelta > 0) {
    assert(pitchDelta <= self.upAimLimit);
    weight = pitchDelta / self.upAimLimit * self.a.aimweight;
    self setAnimLimited(aim2, 0, aimBlendTime, 1, true);
    self setAnimLimited(aim8, weight, aimBlendTime, 1, true);
  } else if(pitchDelta < 0) {
    assert(pitchDelta >= self.downAimLimit);
    weight = pitchDelta / self.downAimLimit * self.a.aimweight;
    self setAnimLimited(aim8, 0, aimBlendTime, 1, true);
    self setAnimLimited(aim2, weight, aimBlendTime, 1, true);
  }
}
setAnimAimWeight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = goalweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = 0;
  } else {
    if(!isDefined(self.a.aimweight)) {
      self.a.aimweight = 0;
    }
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

ramboAim(baseYaw) {
  self endon("killanimscript");

  ramboAimInternal(baseYaw);

  self clearAnim(%generic_aim_left, 0.5);
  self clearAnim(%generic_aim_right, 0.5);
}

ramboAimInternal(baseYaw) {
  self endon("rambo_aim_end");

  waittillframeend;

  self clearAnim(%generic_aim_left, 0.2);
  self clearAnim(%generic_aim_right, 0.2);

  self setAnimLimited(%generic_aim_45l, 1, 0.2);
  self setAnimLimited(%generic_aim_45r, 1, 0.2);

  interval = 0.2;

  yaw = 0;
  for(;;) {
    if(isDefined(self.shootPos)) {
      newyaw = GetYaw(self.shootPos) - self.coverNode.angles[1];
      newyaw = AngleClamp180(newyaw - baseYaw);

      if(abs(newyaw - yaw) > 10) {
        if(newyaw > yaw) {
          newyaw = yaw + 10;
        } else {
          newyaw = yaw - 10;
        }
      }
      yaw = newyaw;
    }

    if(yaw < 0) {
      weight = yaw / -45;
      if(weight > 1) {
        weight = 1;
      }

      self setAnimLimited(%generic_aim_right, weight, interval);
      self setAnimLimited(%generic_aim_left, 0, interval);
    } else {
      weight = yaw / 45;
      if(weight > 1) {
        weight = 1;
      }

      self setAnimLimited(%generic_aim_left, weight, interval);
      self setAnimLimited(%generic_aim_right, 0, interval);
    }

    wait interval;
  }
}
decideNumShotsForBurst() {
  numShots = 0;
  fixedBurstCount = weaponBurstCount(self.weapon);

  if(fixedBurstCount) {
    numShots = fixedBurstCount;
  } else if(animscripts\weaponList::usingSemiAutoWeapon()) {
    numShots = anim.semiFireNumShots[randomint(anim.semiFireNumShots.size)];
  } else if(self.fastBurst) {
    numShots = anim.fastBurstFireNumShots[randomint(anim.fastBurstFireNumShots.size)];
  } else {
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
    } else if(choice < 8) {
      numShots = randomIntRange(6, 12);
    } else {
      numShots = randomIntRange(12, 20);
    }
  }

  return numShots;
}

insure_dropping_clip(note, flagName) {}

handleDropClip(flagName) {
  self endon("killanimscript");
  self endon("abort_reload");

  self.last_drop_clip_time = gettime();

  clipModel = undefined;
  if(self.weaponInfo[self.weapon].useClip) {
    clipModel = getWeaponClipModel(self.weapon);
  }

  if(isDefined(clipModel)) {
    self thread assertDropClipCleanedUp(4, clipModel);
  }

  if(self.weaponInfo[self.weapon].hasClip) {
    if(usingSidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(clipModel)) {
      self hidepart("tag_clip");
      self thread dropClipModel(clipModel, "tag_clip");
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
          self thread resetClipOnAbort(clipModel, "tag_inhand");
        }

        self animscripts\weaponList::RefillClip();

        break;

      case "detach clip nohand":
        if(isDefined(clipModel)) {
          self detach(clipModel, "tag_inhand");
        }
        break;

      case "detach clip right":
      case "detach clip left":
        if(isDefined(clipModel)) {
          self detach(clipModel, "tag_inhand");
          self showpart("tag_clip");
          self notify("clip_detached");
          self.weaponInfo[self.weapon].hasClip = true;
        }

        if(usingSidearm()) {
          self playSound("weap_reload_pistol_clipin_npc");
        } else {
          self playSound("weap_reload_smg_clipin_npc");
        }

        self.a.needsToRechamber = 0;

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
    if(isDefined(currentTag)) {
      self dropClipModel(clipModel, currentTag);
    }
  }
}

dropClipModel(clipModel, tagName) {
  clip = spawn("script_model", self getTagOrigin(tagName));
  clip setModel(clipModel);
  clip.angles = self getTagAngles(tagName);
  clip PhysicsLaunchClient(clip.origin, (0, 0, 0));

  wait 10;

  if(isDefined(clip)) {
    clip delete();
  }
}

assertDropClipCleanedUp(waitTime, clipModel) {
  self endon("death");
  self endon("abort_reload");
  self endon("clip_detached");

  wait waitTime;

  assertmsg("AI " + self getEntityNumber() + " started a reload and didn't reset clip models after " + waitTime + " seconds");
}

moveToOriginOverTime(origin, time) {
  self endon("killanimscript");

  distSq = distanceSquared(self.origin, origin);

  if(distSq < 1) {
    self safeTeleport(origin);
    return;
  }

  if(distSq > 16 * 16 && !self mayMoveToPoint(origin)) {
    println("^1Warning: AI starting behavior for node at " + origin + " but could not move to that point.");
    return;
  }

  self.keepClaimedNodeIfValid = true;

  offset = self.origin - origin;

  frames = int(time * 20);
  offsetreduction = vector_multiply(offset, 1.0 / frames);

  for(i = 0; i < frames; i++) {
    offset -= offsetreduction;
    self safeTeleport(origin + offset);
    wait .05;
  }

  self.keepClaimedNodeIfValid = false;
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
      if(self canSeeEnemy() && [[canStopCallback]]()) {
        return;
      }
    }
    if(self isSuppressedWrapper() && [[canStopCallback]]()) {
      return;
    }
    self setAnimKnobAll(lookAnim, %body, 1, .1);
    wait(0.1);
  }
}

throwDownWeapon(swapAnim) {
  self endon("killanimscript");

  self animscripts\shared::placeWeaponOn(self.secondaryweapon, "right");

  self maps\_gameskill::didSomethingOtherThanShooting();
}

rpgPlayerRepulsor() {
  MISSES_REMAINING = rpgPlayerRepulsor_getNumMisses();
  if(MISSES_REMAINING == 0) {
    return;
  }
  self endon("death");
  for(;;) {
    level waittill("an_enemy_shot", guy);

    if(guy != self) {
      continue;
    }
    if(!isDefined(guy.enemy)) {
      continue;
    }
    if(guy.enemy != level.player) {
      continue;
    }
    if((isDefined(level.createRpgRepulsors)) && (level.createRpgRepulsors == false)) {
      continue;
    }
    thread rpgPlayerRepulsor_create();

    MISSES_REMAINING--;
    if(MISSES_REMAINING <= 0) {
      return;
    }
  }
}

rpgPlayerRepulsor_getNumMisses() {
  skill = getdifficulty();
  switch (skill) {
    case "gimp":
    case "easy":
      return 2;
    case "medium":
    case "hard":
    case "difficult":
      return 1;
    case "fu":
      return 0;
  }
  return 2;
}

rpgPlayerRepulsor_create() {
  repulsor = Missile_CreateRepulsorEnt(level.player, 5000, 800);
  wait 4.0;
  Missile_DeleteAttractor(repulsor);
}