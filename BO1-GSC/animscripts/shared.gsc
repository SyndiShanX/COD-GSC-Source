/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shared.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\anims;
#include common_scripts\utility;
#using_animtree("generic_human");
placeWeaponOn(weapon, position) {
  self notify("weapon_position_change");
  if(!isDefined(self.weaponInfo[weapon])) {
    self call_overloaded_func("animscripts\init", "initWeapon", weapon);
  }
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
    call_overloaded_func("animscripts\init", "SetWeaponDist");
    return;
  }
  if(self.a.weaponPos[position] != "none") {
    self detachWeapon(self.a.weaponPos[position]);
  }
  if(position == "left" || position == "right") {
    self attachWeapon(weapon, position);
    self.weapon = weapon;
    self animscripts\anims::clearAnimCache();
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
  call_overloaded_func("animscripts\init", "SetWeaponDist");
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
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponPos[self.weapon_positions[index]];
      if(weapon == "none") {
        continue;
      }
      self detach(getWeaponModel(weapon), getTagForPos(self.weapon_positions[index]));
    }
  }
}

updateAttachedWeaponModels() {
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponPos[self.weapon_positions[index]];
      if(weapon == "none") {
        continue;
      }
      self attach(getWeaponModel(weapon), getTagForPos(self.weapon_positions[index]));
      if(self.weaponInfo[weapon].useClip && !self.weaponInfo[weapon].hasClip) {
        self hidepart("tag_clip");
      }
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
  if(is_true(self.a.dropping_weapons)) {
    return;
  }
  if(self.weapon == "none" || self.weapon == "") {
    return;
  }
  if(is_true(self.script_nodropsecondaryweapon) && (self.weapon == self.initial_secondaryweapon)) {
    PrintLn("Not dropping secondary weapon '" + self.weapon + "'");
    return;
  } else if(is_true(self.script_nodropsidearm) && (self.weapon == self.sidearm)) {
    PrintLn("Not dropping sidearm '" + self.weapon + "'");
    return;
  }
  self swapDropWeapon();
  current_weapon = self.weapon;
  position = self.weaponInfo[current_weapon].position;
  if(isDefined(current_weapon) && current_weapon != "none") {
    animscripts\shared::placeWeaponOn(current_weapon, "none");
    if(current_weapon == self.primaryweapon) {
      self.primaryweapon = "none";
    } else if(current_weapon == self.secondaryweapon) {
      self.secondaryweapon = "none";
    }
  }
  if(self.dropWeapon) {
    dropWeaponName = player_weapon_drop(self.weapon);
    velocity = self GetAiVelocity();
    speed = Length(velocity) * 0.5;
    droppedWeapon = self DropWeapon(dropWeaponName, position, speed);
  }
  self.weapon = "none";
}

DropAllAIWeapons() {
  if(is_true(self.a.dropping_weapons)) {
    return;
  }
  if(!self.dropweapon) {
    if(self.weapon != "none") {
      animscripts\shared::placeWeaponOn(self.weapon, "none");
      self.weapon = "none";
    }
    return;
  }
  self.a.dropping_weapons = true;
  self swapDropWeapon();
  self detachAllWeaponModels();
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponPos[self.weapon_positions[index]];
      if(weapon != "none") {
        self.weaponInfo[weapon].position = "none";
        self.a.weaponPos[self.weapon_positions[index]] = "none";
        if(is_true(self.script_nodropsecondaryweapon) && (weapon == self.initial_secondaryweapon)) {
          PrintLn("Not dropping secondary weapon '" + weapon + "'");
        } else if(is_true(self.script_nodropsidearm) && (weapon == self.sidearm)) {
          PrintLn("Not dropping sidearm '" + weapon + "'");
        } else {
          weapon = player_weapon_drop(weapon);
          velocity = self GetAiVelocity();
          speed = Length(velocity) * 0.5;
          droppedWeapon = self DropWeapon(weapon, self.weapon_positions[index], speed);
        }
      }
    }
  }
  self.weapon = "none";
  self.a.dropping_weapons = undefined;
}

swapDropWeapon() {
  if(has_script_drop_weapon()) {
    found_weapon = false;
    for(i = 0; i < self.weapon_positions.size; i++) {
      weapon = self.a.weaponPos[self.weapon_positions[i]];
      weapon_toks = StrTok(weapon, "_");
      drop_weapon_toks = StrTok(self.script_dropweapon, "_");
      if(weapon_toks[0] == drop_weapon_toks[0]) {
        PrintLn("Swapping out weapon '" + weapon + "' for script_dropweapon '" + self.script_dropweapon + "'");
        self placeWeaponOn(weapon, "none");
        if(self.weapon == weapon) {
          self.weapon = self.script_dropweapon;
        }
        self placeWeaponOn(self.script_dropweapon, self.weapon_positions[i]);
        found_weapon = true;
        break;
      }
    }
    if(!found_weapon) {
      self swapDropWeaponPrimary();
    }
    self.script_dropweapon = undefined;
  }
}

swapDropWeaponPrimary() {
  if(has_script_drop_weapon()) {
    position = self.weaponInfo[self.primaryweapon].position;
    if(position != "none") {
      PrintLn("Swapping out weapon '" + self.primaryweapon + "' for script_dropweapon '" + self.script_dropweapon + "'");
      self placeWeaponOn(self.primaryweapon, "none");
      self placeWeaponOn(self.script_dropweapon, position);
    }
  }
}

addPhysWeapon() {
  self thread deleteAtLimit();
}

has_script_drop_weapon() {
  if(isDefined(self.script_dropweapon) && IsString(self.script_dropweapon) && (self.script_dropweapon != "")) {
    return true;
  }
  return false;
}

player_weapon_drop(weapon_name) {
  if(IsSubStr(ToLower(weapon_name), "rpg")) {
    return "rpg_player_sp";
  } else if(IsSubStr(ToLower(weapon_name), "panzerschreck")) {
    return "panzerschreck_player_sp";
  }
  return weapon_name;
}

deleteAtLimit() {
  wait 30.0;
  self delete();
}

HandleDogSoundNoteTracks(note) {
  if(note == "sound_dogstep_run_default") {
    self PlaySound("fly_dog_step_run_default");
    return true;
  }
  prefix = getsubstr(note, 0, 5);
  if(prefix != "sound") {
    return false;
  }
  alias = "aml" + getsubstr(note, 5);
  if(IsAlive(self)) {
    self thread play_sound_on_tag_endon_death(alias, "tag_eye");
  } else {
    self thread play_sound_in_space(alias, self gettagorigin("tag_eye"));
  }
  return true;
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
  anim.notetracks["chest_2_back"] = ::noteTrackChestToBack;
  anim.notetracks["pistol_pickup"] = ::noteTrackPistolPickup;
  anim.notetracks["pistol_putaway"] = ::noteTrackPistolPutaway;
  anim.notetracks["drop clip"] = ::noteTrackDropClip;
  anim.notetracks["refill clip"] = ::noteTrackRefillClip;
  anim.notetracks["reload done"] = ::noteTrackRefillClip;
  anim.notetracks["load_shell"] = ::noteTrackLoadShell;
  anim.notetracks["pistol_rechamber"] = ::noteTrackPistolRechamber;
  anim.notetracks["weapon_switch"] = ::noteTrackWeaponSwitch;
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
  anim.notetracks["fire spray"] = ::noteTrackFireSpray;
  anim.notetracks["lookat = \"player\""] = ::noteTrackLookatPlayer;
  anim.notetracks["headlookat = \"player\""] = ::noteTrackHeadLookatPlayer;
  anim.notetracks["lookat = \"\""] = ::noteTrackClearLookAt;
}

noteTrackLookAtPlayer(note, flagName) {
  if(!IsSentient(self)) {
    return;
  }
  relax_ik_headtracking_limits();
  self.lookat_set_in_anim = true;
  self LookAtEntity(get_players()[0]);
}

noteTrackHeadLookAtPlayer(note, flagName) {
  if(!IsSentient(self)) {
    return;
  }
  relax_ik_headtracking_limits();
  SetSavedDvar("ik_dvar_lookatentity_notorso", true);
  self.lookat_set_in_anim = true;
  self LookAtEntity(get_players()[0]);
}

noteTrackClearLookAt(note, flagName) {
  if(!IsSentient(self)) {
    return;
  }
  restore_ik_headtracking_limits();
  self.lookat_set_in_anim = false;
  SetSavedDvar("ik_dvar_lookatentity_notorso", false);
  self LookAtEntity();
}

noteTrackFire(note, flagName) {
  if(!IsSentient(self)) {
    return;
  }
  if(isDefined(anim.fire_notetrack_functions[self.a.script])) {
    thread[[anim.fire_notetrack_functions[self.a.script]]]();
  } else {
    thread[[animscripts\shared::shootNotetrack]]();
  }
}

noteTrackStopAnim(note, flagName) {}
noteTrackStartRagdoll(note, flagName) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  self do_ragdoll_death();
}

noteTrackMovementStop(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "stop";
  }
}

noteTrackMovementWalk(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "walk";
  }
}

noteTrackMovementRun(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "run";
  }
}

noteTrackAlertnessAiming(note, flagName) {
  if(IsSentient(self)) {
    self.a.alertness = "aiming";
  }
}

noteTrackAlertnessCasual(note, flagName) {
  if(IsSentient(self)) {
    self.a.alertness = "casual";
  }
}

noteTrackAlertnessAlert(note, flagName) {
  if(IsSentient(self)) {
    self.a.alertness = "alert";
  }
}

noteTrackPoseStand(note, flagName) {
  if(IsSentient(self)) {
    if(self.a.pose == "prone") {
      self OrientMode("face default");
      self ExitProneWrapper(1.0);
    }
    self.a.pose = "stand";
    self notify("entered_pose" + "stand");
  }
}

noteTrackPoseCrouch(note, flagName) {
  if(IsSentient(self)) {
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
}

noteTrackPoseProne(note, flagName) {
  if(IsSentient(self)) {
    self setProneAnimNodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
    self EnterProneWrapper(1.0);
    self.a.pose = "prone";
    self notify("entered_pose" + "prone");
  }
}

noteTrackPoseCrawl(note, flagName) {
  if(IsSentient(self)) {
    self setProneAnimNodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
    self EnterProneWrapper(1.0);
    self.a.pose = "prone";
    self notify("entered_pose" + "prone");
  }
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
  } else if(isSubStr(note, "none")) {
    animscripts\shared::placeWeaponOn(self.weapon, "none");
  }
}

placeWeaponOnRightOnInterrupt() {
  self endon("death");
  self endon("placed_weapon_on_right");
  self waittill("killanimscript");
  if(AIhasWeapon(self.weapon)) {
    animscripts\shared::placeWeaponOn(self.weapon, "right");
  }
}

noteTrackGunDrop(note, flagName) {
  self.lastWeapon = self.weapon;
  primaryweapon = self.primaryweapon;
  secondaryweapon = self.secondaryweapon;
  pistolOnlyAI = AIHasOnlyPistol();
  self animscripts\shared::DropAIWeapon();
  if(self.lastWeapon == primaryweapon) {
    self.weapon = self.secondaryweapon;
  } else if(self.lastWeapon == secondaryweapon) {
    self.weapon = self.primaryweapon;
  }
  self animscripts\anims::clearAnimCache();
}

noteTrackGunToChest(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "chest");
}

noteTrackGunToBack(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "back");
  self.weapon = self getPreferredWeapon();
  self.bulletsInClip = weaponClipSize(self.weapon);
  self animscripts\anims::clearAnimCache();
}

noteTrackChestToBack(note, flagName) {
  assert(hasSecondaryWeapon());
  animscripts\shared::placeWeaponOn(getSecondaryWeapon(), "back");
}

noteTrackPistolPickup(note, flagName) {
  if(AIHasSidearm()) {
    animscripts\shared::placeWeaponOn(self.sidearm, "right");
    self.bulletsInClip = weaponClipSize(self.weapon);
    self notify("weapon_switch_done");
  }
}

noteTrackPistolPutaway(note, flagName) {
  animscripts\shared::placeWeaponOn(self.weapon, "none");
  self.weapon = self getPreferredWeapon();
  self.bulletsInClip = weaponClipSize(self.weapon);
  self animscripts\anims::clearAnimCache();
}

noteTrackWeaponSwitch(note, flagName) {
  assertex(hasSecondaryWeapon(), "no secondary weapon available! check the aitype for this actor. ");
  if(self.weapon == self.primaryweapon) {
    if(self.weapon != "none") {
      self animscripts\shared::placeWeaponOn(self.weapon, "back");
    }
    self animscripts\shared::placeWeaponOn(self.secondaryweapon, "right");
  } else {
    if(self.weapon != "none") {
      self animscripts\shared::placeWeaponOn(self.weapon, "back");
    }
    self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
  }
  clipSize = weaponClipSize(self.weapon);
  if(NeedToReload(0.5)) {
    if(clipSize > 1) {
      self.bulletsInClip = Int(clipSize * 0.5);
    } else {
      self.bulletsInClip = clipSize;
    }
  } else if(self.bulletsInClip > clipSize) {
    self.bulletsInClip = clipSize;
  }
  self notify("complete_weapon_switch");
  noteTrackWeaponSwitchGlint(note, flagName);
  self.lastWeapon = self.weapon;
}

noteTrackWeaponSwitchGlint(note, flagName) {
  if(isDefined(self.weapon)) {}
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

noteTrackLoadShell(note, flagName) {}
noteTrackPistolRechamber(note, flagName) {}
noteTrackGravity(note, flagName) {
  if(isSubStr(note, "on")) {
    self AnimMode("gravity");
  } else if(isSubStr(note, "off")) {
    self AnimMode("nogravity");
  }
}

noteTrackBodyFall(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  if(isSubStr(note, "large")) {
    self PlaySound("fly_bodyfall_large_" + groundType);
  } else if(isSubStr(note, "small")) {
    self PlaySound("fly_bodyfall_small_" + groundType);
  }
}

noteTrackFootStep(note, flagName) {
  if(isSubStr(note, "left")) {
    playFootStep("J_Ball_LE");
  } else {
    playFootStep("J_BALL_RI");
  }
  if(!level.clientScripts) {
    self PlaySound("fly_gear_run");
  }
}

noteTrackFootScrape(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  self PlaySound("fly_step_scrape_" + groundType);
}

noteTrackLand(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  if(IsPlayer(self)) {
    self PlaySound("fly_land_plr_" + groundType);
  } else {
    self PlaySound("fly_land_npc_" + groundType);
  }
}

HandleNoteTrack(note, flagName, customFunction, var1) {
  if(isAI(self) && self.isdog) {
    if(HandleDogSoundNoteTracks(note)) {
      return;
    }
  }
  notetrackFunc = anim.notetracks[note];
  if(isDefined(notetrackFunc)) {
    return [
      [notetrackFunc]
    ](note, flagName);
  }
  switch (note) {
    case "end":
    case "finish":
    case "undefined":
      if(isAI(self) && self.a.pose == "back") {}
      return note;
    case "swish small":
      self thread play_sound_in_space("wpn_melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      self thread play_sound_in_space("wpn_melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "rechamber":
      if(self usingShotgun()) {
        break;
      }
    case "no death":
      self.a.nodeath = true;
      break;
    case "no pain":
      self disable_pain();
      break;
    case "allow pain":
      self enable_pain();
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
    intercepted = [
      [interceptFunction]
    ](note);
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
    [
      [postFunction]
    ](note);
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
    returnedNote = [
      [notetracksFunc]
    ](flagName, customFunction, debugIdentifier);
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
  ent = SpawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForever, time, flagName, customFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeIntercept(time, flagName, interceptFunction, debugIdentifier) {
  ent = SpawnStruct();
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
      self PlaySound("fly_step_run_dirt");
      return;
    }
  }
  groundType = undefined;
  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastGroundtype)) {
      if(!level.clientScripts) {
        self PlaySound("fly_step_run_dirt");
      }
      return;
    }
    groundtype = self.lastGroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastGroundtype = self.groundType;
  }
  if(!level.clientScripts) {
    self PlaySound("fly_step_run_" + groundType);
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
    playfx(level._effect["step_" + anim.optionalStepEffects[i]], org, org + (0, 0, 100));
    return;
  }
}

shootNotetrack() {
  waittillframeend;
  now = GetTime();
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
  dir = AnglesToForward(self GetTagAngles("tag_weapon"));
  pos = weaporig + vector_scale(dir, 1000);
  self.a.lastShootTime = GetTime();
  self shoot(1, pos);
  self decrementBulletsInClip();
}

noteTrackFireSpray(note, flagName) {
  if(self.a.weaponPos["right"] == "none") {
    return;
  }
  weaporig = self gettagorigin("tag_weapon");
  dir = AnglesToForward(self GetTagAngles("tag_weapon"));
  hitenemy = false;
  if(IsSentient(self.enemy) && IsAlive(self.enemy) && self canShoot(self.enemy GetShootAtPos())) {
    enemydir = VectorNormalize(self.enemy geteye() - weaporig);
    if(vectordot(dir, enemydir) > cos(10)) {
      hitenemy = true;
    }
  }
  if(hitenemy) {
    self shootEnemyWrapper();
  } else {
    dir += ((RandomFloat(2) - 1) * .1, (RandomFloat(2) - 1) * .1, (RandomFloat(2) - 1) * .1);
    pos = weaporig + vector_scale(dir, 1000);
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
  predictedPos = self.shootEnt.origin + vector_scale(self.shootEntVelocity, time);
  return getAimYawToPoint(predictedPos);
}

getAimYawToShootEntOrPos() {
  if(!isDefined(self.shootEnt)) {
    if(!isDefined(self.shootPos)) {
      return 0;
    }
    return getAimYawToPoint(self.shootPos);
  }
  return getAimYawToPoint(self.shootEnt GetShootAtPos(self));
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
  return animscripts\combat_utility::getPitchToSpot(self.shootEnt GetShootAtPos(self));
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
  self animscripts\shared::setAimingAnims( % aim_2, % aim_4, % aim_6, % aim_8);
  self animscripts\shared::trackLoopStart();
}

trackLoopStart() {
  self notify("trackLoopStart");
  self.pauseTrackLoop = false;
}

trackLoopPause() {
  self endon("death");
  while(1) {
    self waittill_any("killanimscript", "stop tracking", "melee");
    self.pauseTrackLoop = true;
  }
}

trackLoopPacer() {
  self endon("death");
  wait(0.05);
  self notify("trackLoopStart");
}

scriptNeedsTagAim() {
  if(isDefined(self.a.script)) {
    if(self.a.script == "move" || self.a.script == "cover_right" || self.a.script == "cover_left" || self.a.script == "cover_pillar") {
      return true;
    }
  }
  return false;
}

trackLoopGetShootFromPos() {
  origin = undefined;
  if(scriptNeedsTagAim()) {
    origin = self getTagOrigin("tag_aim");
  }
  if(!isDefined(origin)) {
    eyeHeight = self geteyeapprox()[2];
    if(self.a.pose == "crouch") {
      eyeHeight = self.origin[2] + (eyeHeight - self.origin[2]) * 0.5;
    }
    origin = (self.origin[0], self.origin[1], eyeHeight);
  }
  return origin;
}

trackLoopGetShootFromAngles() {
  angles = undefined;
  if(scriptNeedsTagAim()) {
    angles = self getTagAngles("tag_aim");
  }
  if(!isDefined(angles)) {
    angles = self.angles;
  }
  return angles;
}

trackLoop() {
  self endon("death");
  self.aimAngleOffset = 0;
  self.pitchAngleOffset = 0;
  self waittill("trackLoopStart");
  players = GetPlayers();
  prevYawDelta = 0;
  prevPitchDelta = 0;
  prevAim2 = self.a.aim_2;
  maxYawDeltaChange = 5;
  maxPitchDeltaChange = 5;
  yawDelta = 0;
  yawAdd = 0;
  pitchDelta = 0;
  pitchAdd = 0;
  if(self.isdog) {
    doMaxAngleCheck = false;
    self.shootEnt = self.enemy;
  } else {
    doMaxAngleCheck = true;
  }
  firstFrame = true;
  self.pauseTrackLoop = false;
  self thread trackLoopPause();
  shootFromAngles = self trackLoopGetShootFromAngles();
  prevshootFromYawAngle = shootFromAngles[1] + self.aimAngleOffset;
  prevshootFromPitchAngle = shootFromAngles[0] + self.pitchAngleOffset;
  for(;;) {
    rightAimLimit = self.rightAimLimit;
    leftAimLimit = self.leftAimLimit;
    upAimLimit = self.upAimLimit;
    downAimLimit = self.downAimLimit;
    if(prevYawDelta > rightAimLimit) {
      prevYawDelta = rightAimLimit;
    } else if(prevYawDelta < leftAimLimit) {
      prevYawDelta = leftAimLimit;
    }
    if(prevPitchDelta > upAimLimit) {
      prevPitchDelta = upAimLimit;
    } else if(prevPitchDelta < downAimLimit) {
      prevPitchDelta = downAimLimit;
    }
    aimingAnimsChanged = false;
    aimBlendTime = .05;
    if(prevAim2 != self.a.aim_2) {
      aimingAnimsChanged = true;
      aimBlendTime = 0;
      prevAim2 = self.a.aim_2;
    }
    incrAnimAimWeight();
    shootFromPos = self trackLoopGetShootFromPos();
    shootPos = self.shootPos;
    if(isDefined(self.shootEnt)) {
      shootPos = self.shootEnt GetShootAtPos(self, self, self);
    }
    if(!isDefined(shootPos) && self call_overloaded_func("animscripts\cqb", "shouldCQB")) {
      selfForward = AnglesToForward(self.angles);
      if(isDefined(self.cqb_target)) {
        shootPos = self.cqb_target GetShootAtPos(self);
        dir = shootPos - shootFromPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir))) {
          shootPos = undefined;
        }
      }
      if(!isDefined(shootPos) && isDefined(self.cqb_point_of_interest)) {
        shootPos = self.cqb_point_of_interest;
        dir = shootPos - shootFromPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir))) {
          shootPos = undefined;
        }
      }
    }
    shootFromAngles = self trackLoopGetShootFromAngles();
    shootFromYawAngle = shootFromAngles[1] + self.aimAngleOffset;
    shootFromPitchAngle = shootFromAngles[0] + self.pitchAngleOffset;
    shootFromYawDelta = AngleClamp180(shootFromYawAngle - prevshootFromYawAngle);
    shootFromPitchDelta = AngleClamp180(shootFromPitchAngle - prevshootFromPitchAngle);
    maxAngleDelta = 10;
    if(abs(shootFromYawDelta) > maxAngleDelta) {
      shootFromYawAngle = prevshootFromYawAngle + maxAngleDelta * sign(shootFromYawDelta);
    }
    if(abs(shootFromPitchDelta) > maxAngleDelta) {
      shootFromPitchAngle = prevshootFromPitchAngle + maxAngleDelta * sign(shootFromPitchDelta);
    }
    shootFromAngles = (shootFromPitchAngle, shootFromYawAngle, shootFromAngles[2]);
    if(!isDefined(shootPos)) {
      assert(!isDefined(self.shootEnt));
      if(isDefined(self.node) && self.node.type == "Guard" && distanceSquared(self.origin, self.node.origin) < 16) {
        yawDelta = AngleClamp180(shootFromYawAngle - self.node.angles[1]);
        pitchDelta = 0;
      } else {
        likelyEnemyDir = self getAnglesToLikelyEnemyPath();
        if(isDefined(likelyEnemyDir)) {
          yawDelta = AngleClamp180(shootFromYawAngle - likelyEnemyDir[1]);
          pitchDelta = AngleClamp180(360 - likelyEnemyDir[0]);
        } else {
          yawDelta = 0;
          pitchDelta = 0;
        }
      }
    } else {
      vectorToShootPos = shootPos - shootFromPos;
      anglesToShootPos = VectorToAngles(vectorToShootPos);
      yawDelta = shootFromYawAngle - anglesToShootPos[1];
      yawDelta = AngleClamp180(yawDelta + yawAdd);
      pitchDelta = shootFromPitchAngle - anglesToShootPos[0];
      pitchDelta = AngleClamp180(pitchDelta + pitchAdd);
    }
    if(doMaxAngleCheck && !aimingAnimsChanged && (abs(yawDelta) > 60 || abs(pitchDelta) > 60)) {
      yawDelta = 0;
      pitchDelta = 0;
    } else {
      if(yawDelta > rightAimLimit) {
        yawDelta = rightAimLimit;
      } else if(yawDelta < leftAimLimit) {
        yawDelta = leftAimLimit;
      }
      if(pitchDelta > upAimLimit) {
        pitchDelta = upAimLimit;
      } else if(pitchDelta < downAimLimit) {
        pitchDelta = downAimLimit;
      }
    }
    if(firstFrame) {
      firstFrame = false;
      yawDelta = 0;
      pitchDelta = 0;
    } else {
      adjustedMaxYawDeltaChange = maxYawDeltaChange + abs(shootFromYawDelta);
      adjustedMaxPitchDeltaChange = maxPitchDeltaChange + abs(shootFromPitchDelta);
      yawDeltaChange = yawDelta - prevYawDelta;
      if(abs(yawDeltaChange) > adjustedMaxYawDeltaChange)
        yawDelta = prevYawDelta + adjustedMaxYawDeltaChange * sign(yawDeltaChange);
      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(abs(pitchDeltaChange) > adjustedMaxPitchDeltaChange)
        pitchDelta = prevPitchDelta + adjustedMaxPitchDeltaChange * sign(pitchDeltaChange);
    }
    prevshootFromYawAngle = shootFromYawAngle;
    prevshootFromPitchAngle = shootFromPitchAngle;
    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;
    if(yawDelta > 0) {
      assert(yawDelta <= rightAimLimit);
      weight = yawDelta / rightAimLimit * self.a.aimweight;
      self SetAnimLimited(self.a.aim_4, 0, aimBlendTime);
      self SetAnimLimited(self.a.aim_6, weight, aimBlendTime);
    } else if(yawDelta < 0) {
      assert(yawDelta >= leftAimLimit);
      weight = yawDelta / leftAimLimit * self.a.aimweight;
      self SetAnimLimited(self.a.aim_6, 0, aimBlendTime);
      self SetAnimLimited(self.a.aim_4, weight, aimBlendTime);
    }
    if(pitchDelta > 0) {
      assert(pitchDelta <= upAimLimit);
      weight = pitchDelta / upAimLimit * self.a.aimweight;
      self SetAnimLimited(self.a.aim_2, 0, aimBlendTime);
      self SetAnimLimited(self.a.aim_8, weight, aimBlendTime);
    } else if(pitchDelta < 0) {
      assert(pitchDelta >= downAimLimit);
      weight = pitchDelta / downAimLimit * self.a.aimweight;
      self SetAnimLimited(self.a.aim_8, 0, aimBlendTime);
      self SetAnimLimited(self.a.aim_2, weight, aimBlendTime);
    }
    if(players.size == 1) {
      self thread trackLoopPacer();
      self waittill("trackLoopStart");
      waittillframeend;
    } else {
      wait(1);
    }
    if(self.pauseTrackLoop) {
      self.aimAngleOffset = 0;
      self.pitchAngleOffset = 0;
      self waittill("trackLoopStart");
      self.pauseTrackLoop = false;
      firstFrame = true;
      prevYawDelta = 0;
      prevPitchDelta = 0;
      shootFromAngles = self trackLoopGetShootFromAngles();
      prevshootFromYawAngle = shootFromAngles[1] + self.aimAngleOffset;
      prevshootFromPitchAngle = shootFromAngles[0] + self.pitchAngleOffset;
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
    if(!isDefined(self.a.aimweight))
      self.a.aimweight = 0;
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
    numShots = anim.semiFireNumShots[randomInt(anim.semiFireNumShots.size)];
  } else if(self.fastBurst) {
    numShots = anim.fastBurstFireNumShots[randomInt(anim.fastBurstFireNumShots.size)];
  } else {
    numShots = anim.burstFireNumShots[randomInt(anim.burstFireNumShots.size)];
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
    choice = RandomFloat(10);
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

handleDropClip(flagName) {
  self endon("killanimscript");
  self endon("abort_reload");
  if(!IsSentient(self)) {
    return;
  }
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
    if(weaponAnims() == "pistol") {} else {}
    if(isDefined(clipModel)) {
      self hidepart("tag_clip");
      assert(isDefined(anim._effect[clipModel]));
      playFxOnTag(anim._effect[clipModel], self, "tag_clip");
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
        if(weaponAnims() == "pistol") {} else {}
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
  if(IsAlive(self)) {
    self showpart("tag_clip");
    self.weaponInfo[self.weapon].hasClip = true;
  } else {
    if(isDefined(currentTag) && isDefined(anim._effect[clipModel])) {
      playFxOnTag(anim._effect[clipModel], self, currentTag);
    }
  }
}

moveToOriginOverTime(origin, time) {
  self endon("killanimscript");
  if(distanceSquared(self.origin, origin) > 16 * 16 && !self mayMoveToPoint(origin)) {
    return;
  }
  self.keepClaimedNodeInGoal = true;
  offset = self.origin - origin;
  frames = int(time * 20);
  offsetreduction = vector_scale(offset, 1.0 / frames);
  for(i = 0; i < frames; i++) {
    offset -= offsetreduction;
    self Teleport(origin + offset);
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
    if(IsAlive(self.enemy)) {
      if(self canSeeEnemy() && [
          [canStopCallback]
        ]()) {
        return;
      }
    }
    if(self isSuppressedWrapper() && [
        [canStopCallback]
      ]()) {
      return;
    }
    self SetAnimKnobAll(lookAnim, % body, 1, .1);
    wait(0.1);
  }
}

getSecondaryWeapon() {
  if(isDefined(self.weapon)) {
    if(self.weapon == self.primaryweapon && AIhasWeapon(self.secondaryweapon) && weaponClass(self.secondaryweapon) != "pistol") {
      return self.secondaryweapon;
    } else if(self.weapon == self.secondaryweapon && AIhasWeapon(self.primaryweapon) && weaponClass(self.secondaryweapon) != "pistol") {
      return self.primaryweapon;
    }
  }
  return undefined;
}

hasSecondaryWeapon() {
  weapon = getSecondaryWeapon();
  return (isDefined(weapon) && (weapon != "none"));
}

shouldThrowDownWeapon() {
  if(!hasSecondaryWeapon()) {
    return false;
  }
  if(!self.a.allow_weapon_switch) {
    return false;
  }
  curWeaponClass = weaponAnims();
  if(curWeaponClass == "none") {
    return false;
  }
  if(isDefined(self.shootPos)) {
    distSqToShootPos = lengthsquared(self.origin - self.shootPos);
    if(weaponAnims() == "rocketlauncher" && (distSqToShootPos < squared(512) || self.a.rockets < 1)) {
      return true;
    }
  }
  return false;
}

throwDownWeapon() {
  self endon("killanimscript");
  swapAnim = animArray("throw_down_weapon");
  if(!isDefined(swapAnim) || swapAnim == % void) {
    return;
  }
  self AnimMode("angle deltas");
  self SetFlaggedAnimKnobAllRestart("weapon swap", swapAnim, % body, 1, .1, 1);
  note = "";
  while(note != "end") {
    self waittill("weapon swap", note);
    if(note == "dropgun" || note == "gun drop") {
      DropAIWeapon();
    }
    if(note == "anim_gunhand = \"right\"") {
      assertex(hasSecondaryWeapon(), "self.secondaryweapon not defined! check the aitype for this actor. ");
      if(AIhasWeapon(self.secondaryweapon)) {
        self animscripts\shared::placeWeaponOn(self.secondaryweapon, "right");
      } else {
        self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
      }
    }
  }
  if(self.bulletsInClip > weaponClipSize(self.weapon)) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  }
  self maps\_gameskill::didSomethingOtherThanShooting();
}

shouldSwitchWeapons() {
  if(!hasSecondaryWeapon() || !self.a.allow_weapon_switch) {
    return false;
  }
  if(self.a.atPillarNode) {
    return false;
  }
  if(isDefined(self.a.weapon_switch_ASAP) && (self.a.weapon_switch_ASAP)) {
    assertex(hasSecondaryWeapon(), "self.secondaryweapon not defined! check the aitype for this actor. ");
    self.a.weapon_switch_ASAP = false;
    return true;
  }
  if((gettime() - self.a.weapon_switch_time) < 1000) {
    return false;
  }
  if(GetDvarInt(#"aiForceSwitchWeapons")) {
    return true;
  }
  curWeaponClass = weaponAnims();
  if(curWeaponClass == "none") {
    return true;
  }
  if(shouldSwitchWeaponForSituation()) {
    return true;
  }
  if(shouldSwitchWeaponForDistance()) {
    return true;
  }
  return false;
}

shouldSwitchWeaponForDistance() {
  if((weaponAnims() == "rocketlauncher" && isEnemyInExplodableVolume()) || !IsSentient(self.enemy)) {
    return false;
  }
  if(isDefined(self.shootPos)) {
    distSqToShootPos = lengthsquared(self.origin - self.shootPos);
    shouldUseWeapon = undefined;
    Assert(isDefined(self.primaryweapon_fightdist_minSq));
    Assert(isDefined(self.secondaryweapon_fightdist_minSq));
    withinPrimaryRange = ((self.primaryweapon_fightdist_minSq < distSqToShootPos) && (distSqToShootPos < self.primaryweapon_fightdist_maxSq));
    withinSecondaryRange = ((self.secondaryweapon_fightdist_minSq < distSqToShootPos) && (distSqToShootPos < self.secondaryweapon_fightdist_maxSq));
    if((withinPrimaryRange && withinSecondaryRange) || (!withinPrimaryRange && !withinSecondaryRange)) {
      if(isDefined(self.enemy)) {
        primaryweapon_accuracy = getweaponaccuracy(self, self.primaryweapon);
        secondaryweapon_accuracy = getweaponaccuracy(self, self.secondaryweapon);
        if(primaryweapon_accuracy > secondaryweapon_accuracy) {
          shouldUseWeapon = self.primaryweapon;
        } else {
          shouldUseWeapon = self.secondaryweapon;
        }
      } else {
        shouldUseWeapon = self.weapon;
      }
    } else {
      if(withinPrimaryRange) {
        shouldUseWeapon = self.primaryweapon;
      } else if(withinSecondaryRange) {
        shouldUseWeapon = self.secondaryweapon;
      }
    }
    Assert(isDefined(shouldUseWeapon));
    if(self.weapon != shouldUseWeapon) {
      if(self.a.weapon_switch_for_distance_time < 0) {
        self.a.weapon_switch_for_distance_time = GetTime() + RandomFloatRange(2, 4) * 1000;
      }
      if(isExposed() && GetTime() < self.a.weapon_switch_for_distance_time) {
        return false;
      }
      return true;
    }
    self.a.weapon_switch_for_distance_time = -1;
    return false;
  }
  self.a.weapon_switch_for_distance_time = -1;
  return false;
}

isExposed() {
  if(self.a.script == "cover_crouch" || self.a.script == "cover_stand") {
    if(isDefined(self.a.coverMode) && self.a.coverMode == "Hide") {
      return false;
    }
  } else if(self.a.script == "cover_left" || self.a.script == "cover_right" || self.a.script == "cover_pillar") {
    if(!isDefined(self.cornerAiming) || !self.cornerAiming) {
      return false;
    }
  }
  return true;
}

getWeaponSwitchAnim() {
  animName = "weapon_switch";
  if(!isExposed()) {
    animName = "weapon_switch_cover";
    if(GetDvarInt(#"aiQuadrantSwitch") == 1) {
      animName = "weapon_switch_quadrants_cover";
    } else if(GetDvarInt(#"aiQuadrantSwitch") == 2) {
      animName = "weapon_putaway_cover";
    }
  } else {
    if(GetDvarInt(#"aiQuadrantSwitch") == 1) {
      animName = "weapon_switch_quadrants";
    } else if(GetDvarInt(#"aiQuadrantSwitch") == 2) {
      animName = "weapon_putaway";
    }
  }
  if(IsArray(animArray(animName))) {
    return animArrayPickRandom(animName);
  }
  return animArray(animName);
}

getWeaponPulloutAnim() {
  animName = "weapon_pullout";
  if(!isExposed()) {
    animName = "weapon_pullout_cover";
  }
  assert(animArrayExist(animName));
  if(IsArray(animArray(animName))) {
    return animArrayPickRandom(animName);
  }
  return animArray(animName);
}

switchWeapons() {
  swapAnim = getWeaponSwitchAnim();
  if(!isDefined(swapAnim)) {
    return;
  }
  self animMode("angle deltas");
  self SetFlaggedAnimKnobAllRestart("weapon swap", swapAnim, % body, 1, .1, 1);
  self DoNoteTracks("weapon swap");
  if(GetDvarInt(#"aiQuadrantSwitch") == 2) {
    pulloutAnim = getWeaponPulloutAnim();
    if(isDefined(swapAnim)) {
      self SetFlaggedAnimKnobAllRestart("weapon swap", pulloutAnim, % body, 1, .1, 1);
      self DoNoteTracks("weapon swap");
    }
  }
  self ClearAnim( % weapon_switch, 0.2);
  self.a.weapon_switch_time = gettime();
  self.a.weapon_switch_for_distance_time = -1;
  self notify("weapon_switched");
  self maps\_gameskill::didSomethingOtherThanShooting();
}

isEnemyInExplodableVolume() {
  if(!isDefined(self.enemy)) {
    return false;
  }
  if(isDefined(self.enemy._explodable_targets)) {
    for(i = 0; i < self.enemy._explodable_targets.size; i++) {
      if(isDefined(self.enemy._explodable_targets[i]) && self CanSee(self.enemy._explodable_targets[i])) {
        return true;
      }
    }
  } else if(isDefined(self.enemy.script_exploder) || self.enemy is_destructible()) {
    return true;
  }
  return false;
}

shouldSwitchWeaponForSituation() {
  self endon("death");
  secondaryWeaponClass = weaponClass(self getSecondaryWeapon());
  if(isEnemyInExplodableVolume() && secondaryWeaponClass == "rocketlauncher" && WeaponClass(self.weapon) != "rocketlauncher") {
    return true;
  }
  return false;
}

setAimingAnims(aim_2, aim_4, aim_6, aim_8) {
  assert(isDefined(aim_2));
  assert(isDefined(aim_4));
  assert(isDefined(aim_6));
  assert(isDefined(aim_8));
  self.a.aim_2 = aim_2;
  self.a.aim_4 = aim_4;
  self.a.aim_6 = aim_6;
  self.a.aim_8 = aim_8;
}