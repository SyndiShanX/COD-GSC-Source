/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_vl_base.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_vl_camera;
#include maps\mp\_vl_firingrange;
#include maps\mp\_vl_selfiebooth;

PARTYSTATUS_EMPTY = 0;
PARTYSTATUS_ZOMBIE = 1;
PARTYSTATUS_ANONYMOUS = 2;
PARTYSTATUS_JOINED = 3;
PARTYSTATUS_COMMITTED = 4;
PARTYSTATUS_PRESENT = 5;

vlprint(str) {
  print("VLOBBY[" + GetTime() + "]: " + str);
}

vlprintln(str) {
  println("VLOBBY[" + GetTime() + "]: " + str);
}

vl_init() {
  level.vl_onSpawnPlayer = ::onSpawnPlayer;
  vl_main();
}

vl_main() {
  setDvar("r_dof_physical_enable", 1);
  setDvar("r_dof_physical_bokehEnable", 1);
  setDvar("r_adaptiveSubdiv", 0);
  setDvar("r_eyePupil", 0.15);
  setDvar("r_uiblurdstmode", 3);
  setDvar("r_blurdstgaussianblurradius", 1.5);
  ResetEntPlayerXuidForEmblems();

  level.PartyMembers_cb = ::party_members;
  level.vlavatars = [];
  level.xuid2ownerId = [];
  level.vl_focus = 0;
  level.avatarInfo = [];
  maxAvatars = 18;
  if(level.ps3 || level.xenon) {
    maxAvatars = 12;
  }
  for(i = 0; i < maxAvatars; i++) {
    level.avatarInfo[i] = spawnStruct();
    level.avatarInfo[i].timeToDelete = 0;
    level.avatarInfo[i].xuid = "";
  }
  level.maxAvatars = maxAvatars;

  thread monitor_member_class_changes();
  thread monitor_member_timeouts();

  setDvar("virtuallobbymembers", 0);

  SetDvarIfUninitialized("scr_vl_addfakemembers", "0");
  SetDvarIfUninitialized("scr_vl_debugfly", "0");
  SetDvarIfUninitialized("scr_vl_printcostume", "0");
  level.vl_fakemembers = 0;

  level.num_lobby_idles = 4;
  init_firingrange();
  init_selfiebooth();
}

init_avatars() {
  EXTRA_AVATARS = 1;
  maxAvatars = level.maxAvatars + EXTRA_AVATARS;
  level.vlavatarpool = [];
  for(i = 0; i < maxAvatars; i++) {
    avatar = getFreeAgent();
    level.vlavatarpool[i] = avatar;
    avatar SpawnAgent((0, 0, 0), (0, 0, 0));
    avatar set_agent_values("spectator", "none");
    avatar maps\mp\agents\_agent_common::set_agent_health(100);

    avatar BotClearScriptEnemy();
    avatar BotClearScriptGoal();
    avatar bot_disable_tactical_goals();
    avatar BotSetFlag("disable_movement", 1);
    avatar BotSetFlag("disable_rotation", 1);
    avatar.isfree = true;
  }
}

alloc_avatar() {
  if(!isDefined(level.vlavatarpool)) {
    init_avatars();
  }

  foreach(avatar in level.vlavatarpool) {
    if(avatar.isfree) {
      avatar.isfree = false;
      return avatar;
    }
  }
  assertmsg("Unable to alloc_avatar");
}

free_avatar(avatar) {
  assert(!avatar.isfree);
  avatar notify("free_avatar");
  avatar.isfree = true;
}

onSpawnPlayer() {
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  self thread vlobby_player();
  level.playerStatus[0] = PARTYSTATUS_JOINED;
  self thread monitor_member_focus_change();
  self thread monitor_create_an_operator(0);
  self thread monitor_create_a_class(0);
  self thread monitor_clans();
  thread monitor_move_btn_fr_vl(self);
  self disable_player_controls();

  self SetDemiGod(true);
  self SetMLGSpectator(0);
}

on_agent_player_killed(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {}

player_sticks_in_lefty_config() {
  if(self is_player_gamepad_enabled()) {
    sticksLayoutName = self GetLocalPlayerProfileData("gpadSticksConfig");
    return isDefined(sticksLayoutName) && ((sticksLayoutName == "thumbstick_southpaw") || (sticksLayoutName == "thumbstick_legacy"));
  }

  return false;
}

player_setup_lefty_angle(avatar) {
  if(!isDefined(avatar.fakeAngle)) {
    if(isDefined(avatar.storedRightStickY)) {
      avatar.fakeAngle = avatar.storedRightStickY;
    } else {
      avatar.fakeAngle = 0;
    }
  }
}

player_get_right_stick_y(avatar) {
  if(self player_sticks_in_lefty_config()) {
    player_setup_lefty_angle(avatar);
    return avatar.fakeAngle;
  } else {
    rightStick = self GetUnNormalizedCameraMovement();
    return rightStick[1];
  }
}

player_update_right_stick_y(avatar) {
  rightStickY = 0;
  if(self player_sticks_in_lefty_config()) {
    player_setup_lefty_angle(avatar);

    rightStick = self GetNormalizedMovement();
    rotSpeed = -12;
    rotDelta = rightStick[1] * rotSpeed;
    avatar.fakeAngle = AngleClamp(avatar.fakeAngle + rotDelta);
    rightStickY = avatar.fakeAngle;
  } else {
    rightStick = self GetUnNormalizedCameraMovement();
    rightStickY = rightStick[1];

    if(isDefined(avatar.fakeAngle)) {
      avatar.fakeAngle = undefined;
    }
  }

  return rightStickY;
}

prep_for_controls(avatar, set_avatar_angles) {
  avatar.storedRightStickY = self player_get_right_stick_y(avatar);
  avatar.rotation_total = 0;
  avatar.storedangleY = avatar.angles[1];
  avatar.mouseRot = 0;
  avatar.positivewrap = 0;
  avatar.negativewrap = 0;
  avatar.addtobaseangle = 0;
  set_avatar_angles = (0, set_avatar_angles[1], 0);
  if(isDefined(set_avatar_angles)) {
    if(IsAgent(avatar)) {
      avatar HackAgentAngles(set_avatar_angles);
    } else {
      avatar.angles = set_avatar_angles;
    }
  }
}

avatar_scheduled_for_removal(ownerid) {
  assert(level.avatarInfo[ownerid].timeToDelete == 0);
  return level.avatarInfo[ownerid].timeToDelete > 0;
}

schedule_remove_avatar(ownerid, dly) {
  remove_avatar(ownerid);
}

all_avatars_scheduled_for_delete() {
  if(level.vlavatars.size == 0) {
    return false;
  }
  foreach(ownerId, avatarInfo in level.avatarInfo) {
    if(!isDefined(level.vlavatars[ownerId])) {
      continue;
    }
    if(avatarInfo.timeToDelete == 0) {
      return false;
    }
  }
  return true;
}

reuse_avatar(xuid) {
  assert(level.vlavatars.size == 1);
  avatar = undefined;
  foreach(xuidtmp, idx in level.xuid2ownerId) {
    avatar = level.vlavatars[idx];
    level.vlavatars[idx] = undefined;
    setEntPlayerXuidForEmblem(avatar, xuidtmp, true);
    level.xuid2ownerId[xuidtmp] = undefined;
  }

  level.xuid2ownerId[xuid] = 0;
  level.avatarInfo[0].timeToDelete = 0;
  level.avatarInfo[0].xuid = xuid;
  if(isDefined(avatar)) {
    setEntPlayerXuidForEmblem(avatar, xuid);
    level.vlavatars[0] = avatar;
  }
}

add_avatar(xuid) {
  ownerId = -1;
  oId = -1;
  while(oId == ownerId) {
    ownerId++;
    foreach(oId in level.xuid2ownerId) {
      if(oId == ownerId) {
        break;
      }
    }
  }
  vlprint("Adding new xuid " + xuid + " with ownerId=" + ownerId + "\n");
  level.xuid2ownerId[xuid] = ownerId;
  level.avatarInfo[ownerId].xuid = xuid;
  level.avatarInfo[ownerId].timeToDelete = 0;
  return ownerId;
}

avatar_after_spawn(ownerId) {
  if(isDefined(level.needToPresent)) {
    thread SetVirtualLobbyPresentable();
  }
}

update_avatars() {
  anyRemoved = false;
  foreach(ownerId, avatarInfo in level.avatarInfo) {
    if((avatarInfo.timeToDelete > 0) && (GetTime() > avatarInfo.timeToDelete)) {
      vlprint("update_avatars removing ownerId" + ownerId + "\n");
      remove_avatar(ownerId);
      anyRemoved = true;
    }
  }
  if(anyRemoved) {
    wait 0.1;
  }
}

hide_non_owner_avatars() {
  foreach(idx, avatar in level.vlavatars) {
    if(idx == 0) {
      continue;
    }
    hide_avatar(avatar);
  }
  if(level.camParams.mode != "prelobby") {
    level.camParams.camera.cut = true;
  }

  level.vl_focus = 0;
  level.old_vl_focus = level.vl_focus;
}

show_non_owner_avatars() {
  foreach(idx, avatar in level.vlavatars) {
    if(idx == 0) {
      continue;
    }
    show_avatar(avatar);
  }
}

RightStickRotateAvatar(targetAvatar, ratio) {
  rightStickY = self player_update_right_stick_y(targetAvatar);
  rightStickDiffY = AngleClamp(rightStickY - targetAvatar.storedRightStickY);

  mouseRot = GetDvarFloat("ui_mouse_char_rot", 0);
  if(mouseRot != 0) {
    targetAvatar.mouseRot = AngleClamp(targetAvatar.mouseRot + mouseRot);
    SetDynamicDvar("ui_mouse_char_rot", 0);
  }

  AddtoAngle = GetModifiedRotationAngle(targetAvatar, rightStickDiffY, ratio);
  AddtoAngle *= -1;
  AvatarYAngle = AngleClamp(targetAvatar.storedangleY + AddtoAngle + targetAvatar.mouseRot);
  avatar_angles = (0, AvatarYAngle, 0);

  if(IsAgent(targetAvatar)) {
    targetAvatar SetPlayerAngles(avatar_angles);
  } else {
    targetAvatar.angles = avatar_angles;
  }
}
PlayerHasTouchedStick(targetAvatar) {
  rightStickY = self player_get_right_stick_y(targetAvatar);
  rightStickDiffY = AngleClamp(rightStickY - targetAvatar.storedRightStickY);
  if(self.HasTouchedStick == false) {
    if(abs(rightStickDiffY) >= 1) {
      targetAvatar.storedangleY = targetAvatar.angles[1];
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }
}

disable_player_controls() {
  self notify("kill_enable_weapons");

  self AllowFire(false);
}

enable_player_controls() {
  self endon("enter_lobby");
  self endon("kill_enable_weapons");

  val = GetDvarInt("virtualLobbyInFiringRange", 0);
  if((val == 1) && level.in_firingrange == true) {
    self AllowFire(true);
  }
}

enter_vlobby(player) {
  deactivate_targets();

  camera = player.camera;
  player SetOrigin(camera.origin);
  player PlayerLinkTo(camera, "tag_player");
  player CameraLinkTo(camera, "tag_player");
  player SetClientDVar("cg_fovscale", "0.6153");

  player VisionSetNakedForPlayer("mp_virtual_lobby_cac", 0);

  if(isDefined(level.vlavatars) && isDefined(level.old_vl_focus) && isDefined(level.vlavatars[level.old_vl_focus])) {
    player prep_for_controls(level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles);
  }

  level.in_firingrange = false;
  player AllowFire(false);
  updateSessionState("spectator");
}

monitor_move_btn_fr_vl(player) {
  while(true) {
    if(isDefined(level.in_firingrange)) {
      val = GetDvarInt("virtualLobbyInFiringRange", 0);
      if((val == 1) && !level.in_firingrange) {
        class_num = getClassIndex("lobby" + (player.currentSelectedClass + 1));
        classLoc = cac_getCustomClassLoc();
        loadout = player.loadouts[classLoc][class_num];
        loadoutPrimary = loadout["primary"];
        loadoutSecondary = loadout["secondary"];

        if(isDefined(level.vlavatars) && isDefined(level.old_vl_focus) && isDefined(level.vlavatars[level.old_vl_focus])) {
          player prep_for_controls(level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles);
        }

        WeaponNames = [];
        {
          if(isDefined(loadoutPrimary) && loadoutPrimary != "specialty_null") {
            WeaponNames[WeaponNames.size] = maps\mp\gametypes\_class::buildWeaponName(loadoutPrimary, loadout["primaryAttachment1"], loadout["primaryAttachment2"], loadout["primaryAttachment3"], 0, 0);
          }
          if(isDefined(loadoutSecondary) && loadoutSecondary != "specialty_null") {
            WeaponNames[WeaponNames.size] = maps\mp\gametypes\_class::buildWeaponName(loadoutSecondary, loadout["secondaryAttachment1"], loadout["secondaryAttachment2"], loadout["secondaryAttachment3"], 0, 0);
          }
        }

        while(WeaponNames.size > 0) {
          HasLoadededWeapons = player loadweapons(WeaponNames);
          if(HasLoadededWeapons == true) {
            break;
          }
          wait(0.05);
        }

        player ShowViewModel();

        enter_firingrange(player);
        player clientclearsoundsubmix("mp_no_foley", 1);
        setDvar("r_dof_physical_bokehEnable", 0);
        setDvar("r_dof_physical_enable", 0);
        setDvar("r_uiblurdstmode", 0);
        setDvar("r_blurdstgaussianblurradius", 1);
      } else if((val == 0) && level.in_firingrange) {
        player HideViewModel();
        player FiringRangeCleanup();
        player disable_player_controls();

        player notify("enter_lobby");
        enter_vlobby(player);
        player clientaddsoundsubmix("mp_no_foley", 1);
        setDvar("r_dof_physical_enable", 1);
        setDvar("r_dof_physical_bokehEnable", 1);
        setDvar("r_uiblurdstmode", 3);
        setDvar("r_blurdstgaussianblurradius", 1.5);
      }
    }

    wait 0.05;
  }
}

FiringRangeCleanup() {
  player = self;
  player GrenadeCleanup();
  player thread RiotShieldCleanup();
  weaponListOffhand = player GetWeaponsListOffhands();
  foreach(weapon in weaponListOffhand) {
    player maps\mp\gametypes\_class::takeOffhand(weapon);
  }
}