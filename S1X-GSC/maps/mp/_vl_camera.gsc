/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_vl_camera.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_vl_base;

LUI_MODE_PRELOBBY = 0;
LUI_MODE_LOBBY = 1;
LUI_MODE_CAC = 2;
LUI_MODE_CAO = 3;
LUI_MODE_OBSCURED = 4;
LUI_MODE_CLANPROFILE = 5;

OBSTACLE_RADIUS = 16;
OBSTACLE_PATHBIAS = 5;

delayed_luinotifyserver(delay, channel, value) {
  wait delay;
  self notify("luinotifyserver", channel, value);
}

setup_camparams() {
  camParams = spawnStruct();
  camParams.TARGETZOFF = 40;
  camParams.BASEDELTA = 0.25;
  camParams.tgtDelta = camParams.BASEDELTA;
  camParams.ACCEL = 0.01;
  camParams.delta = 0;
  camParams.BASEDANGLE = 0.5;
  camParams.ANGLEACCEL = 0.01;
  camParams.tgtDAngle = camParams.BASEDANGLE;
  camParams.dAngle = 0;
  camParams.MAXORBITANGLE = 60;
  camParams.MINORBITDIST = 60;
  camParams.MAXORBITDIST = 120;
  camParams.angle = 0;
  camParams.dist = 120;
  camParams.DOF_Time = 12;
  camParams.face_dof_mod = -10;
  camParams.CAOtoLobbyFrameDelay = 3;
  camParams.CAOtoLobbyFrameTimer = 0;

  camParams.GAMELOBBYGROUP_CAMOFFSET_ANGLE_RATIO = 0.0;
  camParams.GAMELOBBYGROUP_CAMERAZOFF_ZOOM = 45;
  camParams.GAMELOBBYGROUP_TARGETZOFF_ZOOM = 50;
  camParams.GAMELOBBYGROUP_CAMERA_OFFSET = 6;
  camParams.GAMELOBBYGROUP_CAMERA_TARGETOFFSET = 6;
  camParams.GAMELOBBYGROUP_CAMERA_UpCloseZ = 513;
  camParams.GAMELOBBYGROUP_CAMERA_NormalZ = 507;
  camParams.GAMELOBBYGROUP_CAMERA_CrouchZ = 483;
  camParams.GAMELOBBYGROUP_CAMERA_HunchZ = 502;
  camParams.GAMELOBBYGROUP_CAMERA_CloseDistance = 71.5;
  camParams.GAMELOBBYGROUP_CAMERA_NormalDistance = 96.8;
  camParams.GAMELOBBYGROUP_CAMERA_CrouchDistance = 96.8;
  camParams.GAMELOBBYGROUP_CAMERA_HunchDistance = 96.8;
  camParams.GAMELOBBYGROUP_CAMERA_CrouchThreshold = 490;
  camParams.GAMELOBBYGROUP_CAMERA_HunchThreshold = 504.5;
  camParams.GAMELOBBYGROUP_CAMERA_NormalThreshold = 509.5;
  camParams.GAMELOBBYGROUP_MOVESPEED_MODIFIER = 0.95;

  camParams.CAC_CAMOFFSET_ANGLE_RATIO = 0.0;
  camParams.CAC_CAMERAZOFF_ZOOM = 7;
  camParams.CAC_TARGETZOFF_ZOOM = 13;
  camParams.CAC_CAMERA_OFFSET = 0;
  camParams.CAC_CAMERA_TARGETOFFSET = 0;
  camParams.CAMOFFSET_RATIO_CAC = 0.1;
  camParams.CAC_RATIO_ZOOM = 0.2;
  camParams.CAC_FRAMEDELAY = 0;
  camParams.CAC_CAMERAZOFF = 17;
  camParams.CAC_TARGETZOFF = 14.5;
  camParams.CAC_DIST = 69;
  camParams.CAC_WEAP_OFFSET = 8;
  camParams.CAC_WEAP_TUNING = false;
  camParams.CAC_WEAP_TUNING_CAMOFFSET = 0;
  camParams.CAC_WEAP_TUNING_WEAP_SIDEOFFSET = 0;
  camParams.CAC_WEAP_TUNING_WEAP_ZOFFSET = 0;
  camParams.CACWeaponDelayTime = 0.35;
  camParams.CACWeaponAnimDelayTime = 0.1;
  camParams.CACWeaponAttachDelayTime = 0.05;

  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_enabled", 0);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_sideoffset", 0);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_weaponPedestal_x", 0);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_weaponPedestal_y", 0);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_weaponPedestal_z", 0);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_MoveModifier", 40);
  SetDevDvarIfUninitialized("scr_vl_cac_weap_tuning_Ratio", 0.05);
  SetDevDvarIfUninitialized("scr_vl_anim_choose_anim_enable", 0);
  SetDevDvarIfUninitialized("scr_vl_anim_index", 0);

  camParams.GAMELOBBY_MOVESPEED = 150;
  camParams.GAMELOBBY_CAMOFFSET_ANGLE_RATIO = 0.2;
  camParams.GAMELOBBY_CAMERAZOFF_ZOOM = 45;
  camParams.GAMELOBBY_TARGETZOFF_ZOOM = 55;
  camParams.GAMELOBBY_CAMERA_OFFSET = 16;
  camParams.GAMELOBBY_CAMERA_TARGETOFFSET = 24;
  camParams.GAMELOBBY_CAMERA_ROTATION_SPEED = 0.5;
  camParams.goal = "avatar";

  camParams.GAMELOBBY_CAMERA_CURVE_MODIFY = 0.005;
  camParams.GAMELOBBY_CAMERA_CURVE_STOREDY = 0;
  camParams.GAMELOBBY_CAMERA_CURVE_MOVEX = 64;
  camParams.GAMELOBBY_CAMERA_DEPTH_SCALER = 0;

  camParams.tgt_camoffset_ratio = camParams.CAMOFFSET_RATIO_PRELOBBY;
  camParams.cur_camoffset_ratio = camParams.tgt_camoffset_ratio;
  camParams.cac_camoffset_ratio = 0;
  camParams.cac_weap_loot_offset = (-0.02, 0, -0.08);
  camParams.cac_weap_screen_offset = (0.05, 0, -0.06);

  camParams.camoffset_ratio_maxspeed = 0.25;
  camParams.CAMZOFF = 10;
  camParams.MOVESPEED = 150;
  camParams.ANGSPEED = 800;
  camParams.prelobbyZoom = 0;
  rightStick = self GetUnNormalizedCameraMovement();
  camParams.oldRotX = rightStick[0];
  camParams.oldRotY = rightStick[1];
  camParams.zoom = 0.5;
  camParams.rotate = 0.5;

  camParams.framedelay = 0;
  camParams.pre_lobby_framedelay = 4;
  camParams.delayed_cut = false;

  camParams.dof_near_start = 0;
  camParams.dof_near_end = 0;
  camParams.dof_far_start = 159.8;
  camParams.dof_far_end = 205.59;
  camParams.dof_near_blur = 7.5;
  camParams.dof_far_blur = 2;

  camParams.origin_offset = (0, 0, 40);

  camParams.PRELOBBY_MOVESPEED = 300;
  camParams.PRELOBBY_TARGETZOFF_ZOOM = 10;
  camParams.PRELOBBY_TARGETZOFF = 42;
  camParams.PRELOBBY_NEARDIST = 40;
  camParams.PRELOBBY_FARDIST = 200;
  camParams.PRELOBBY_CAMERAZOFF = 0;
  camParams.PRELOBBY_CAMERAZOFF_ZOOM = 20;
  camParams.PRELOBBY_CAMERA_RATIO = 0.325;
  camParams.PRELOBBY_RATIO_ZOOM = 0.2;
  camParams.CAMOFFSET_RATIO_LOBBY = -0.1;
  camParams.CAMOFFSET_RATIO_PRELOBBY = 0.19;
  camParams.CAMOFFSET_RATIO_PRELOBBY_LOOT = -1;
  camParams.CH_CYL_ZOFF_FAR = 36;
  camParams.CH_CYL_ZOFF_NEAR = 42;
  camParams.transitioning = false;

  camParams.CAO_TARGETZOFF_ZOOM = 10;
  camParams.CAO_TARGETZOFF = 31;
  camParams.CAO_NEARDIST = 40;
  camParams.CAO_FARDIST = 200;
  camParams.CAO_CAMERAZOFF = 0;
  camParams.CAO_CAMERAZOFF_ZOOM = 20;
  camParams.CAO_CAMERA_RATIO = 0.77;
  camParams.CAO_RATIO_ZOOM = 0.2;
  camParams.CAO_CAMOFFSET_RATIO = 0.25;

  mode = GetDvarInt("virtualLobbyMode", 0);
  if(mode == LUI_MODE_PRELOBBY) {
    camParams.mode = "game_lobby";
    start_prelobby_anims();
    setDvar("virtualLobbyReady", "0");
  } else {
    camParams.mode = "transition";
    camParams.tgt_camoffset_ratio = camParams.CAMOFFSET_RATIO_LOBBY;
    camParams.cur_camoffset_ratio = camParams.tgt_camoffset_ratio;
    start_lobby_anims();
    if(GetDVarInt("virtualLobbyReady", 0) == 0) {
      setDvar("virtualLobbyReady", "1");
    }
    if(mode == LUI_MODE_CAC) {
      self thread delayed_luinotifyserver(0.1, "cac", 0);
    } else if(mode == LUI_MODE_CAO) {
      self thread delayed_luinotifyserver(0.1, "cao", 0);
    }
  }
  camParams.newmode = camParams.mode;

  level.camParams = camParams;
}

update_camera_params_ratio(camParams) {
  if(isDefined(self.cut)) {
    camParams.cur_camoffset_ratio = camParams.tgt_camoffset_ratio;
  } else {
    dRatio = camParams.tgt_camoffset_ratio - camParams.cur_camoffset_ratio;
    if(dRatio < -1 * camParams.camoffset_ratio_maxspeed) {
      dRatio = -1 * camParams.camoffset_ratio_maxspeed;
    } else if(dRatio > camParams.camoffset_ratio_maxspeed) {
      dRatio = camParams.camoffset_ratio_maxspeed;
    }
    camParams.cur_camoffset_ratio += dRatio;
  }
}

vlobby_lighting_setup() {
  player = self;
  if(isDefined(level.vl_lighting_setup)) {
    player[[level.vl_lighting_setup]]();
  } else {
    player EnablePhysicalDepthOfFieldScripting();
    player SetPhysicalDepthOfField(0.613159, 89.8318, level.camParams.DOF_Time, level.camParams.DOF_Time);
  }
}
Set_Avatar_DOF() {
  if(isDefined(level.camParams.goal)) {
    if(level.camParams.goal == "moving" || level.camParams.goal == "finding_new_position" || level.vlavatars[level.vl_focus] != level.vlavatars[level.old_vl_focus]) {
      return;
    }
  }
  if(isDefined(level.camParams.camera.cut) && level.camParams.camera.cut == true) {
    return;
  }
  player = self;

  if(isDefined(level.camParams.camera.goal_location)) {
    CamLocation = level.camParams.camera.goal_location;
  } else {
    avatar = level.vlavatars[level.old_vl_focus];
    tag_camera_loc_vec3 = avatar GetTagOrigin("TAG_STOWED_BACK");
    DistTagToAvatar = Distance2D(tag_camera_loc_vec3, avatar.avatar_spawnpoint.origin);
    CamLocationFloor = avatar.avatar_spawnpoint.origin + (anglesToForward(avatar.avatar_spawnpoint.angles) * DistTagToAvatar);
    CamLocation = (CamLocationFloor[0], CamLocationFloor[1], tag_camera_loc_vec3[2]);
  }

  bCamSHouldUpdate = CheckCamPosition(level.camParams.camera, CamLocation, 1.5);

  if(bCamSHouldUpdate == true) {
    predicted_cam_location = CamLocation;
  } else {
    predicted_cam_location = level.camParams.camera.origin;
  }

  Cam2TgtDist = distance(level.vlavatars[level.old_vl_focus] GetTagOrigin("j_spine4"), predicted_cam_location);
  player vlobby_dof_based_on_focus(Cam2TgtDist + level.camParams.face_dof_mod);
}
vlobby_dof_based_on_focus(Dist) {
  if(Dist <= 0.0) {
    return;
  }

  player = self;
  dof_time = level.camParams.DOF_Time;

  if(isDefined(level.vl_dof_based_on_focus)) {
    player[[level.vl_dof_based_on_focus]](Dist);
  } else {
    Dist2Tgt = Dist;
    player = self;
    FStopPerUnit = 0.025;
    scaler = 0.65;
    fStopBase = 0.613159;
    BaseDistance = 94.9504;

    result = ((BaseDistance - Dist2Tgt) * FStopPerUnit);
    fStop = fStopBase + result + (result * scaler);

    if(fStop < 0.125) {
      fStop = 0.125;
    } else if(fStop > 128) {
      fStop = 128;
    }
    player SetPhysicalDepthOfField(fStop, Dist2Tgt, level.camParams.DOF_Time, level.camParams.DOF_Time * 2);
  }
}

vlobby_handle_mode_change(mode, newmode, camParams) {
  player = self;
  if(isDefined(level.vl_handle_mode_change)) {
    player[[level.vl_handle_mode_change]](mode, newmode, camParams);
  } else {
    if(mode == "cac") {
      player SetDefaultPostFX();
    } else if(mode == "cao") {}

    if(newmode == "cac") {
      player VisionSetNakedForPlayer("mp_vlobby_refraction_cac", 0);
      player LightSetForPlayer("mp_vl_create_a_class");
    } else if(newmode == "cao") {
      player SetPhysicalDepthOfField(1.53, 130, level.camParams.DOF_Time, level.camParams.DOF_Time);
    } else if(newmode == "prelobby") {
      player SetDefaultPostFX();
    } else if(mode == "prelobby_members") {} else if(mode == "prelobby_loadout") {} else if(mode == "prelobby_loot") {} else if(newmode == "game_lobby") {
      player SetDefaultPostFX();
    } else if(mode == "startmenu") {} else if(mode == "transition") {}
  }
}

SetDefaultPostFX() {
  player = self;
  player VisionSetNakedForPlayer("mp_vlobby_room", 0);
  player LightSetForPlayer("mp_vlobby_room");
}

SetDefaultDOF() {
  player = self;
  player SetPhysicalDepthOfField(0.613159, 89.8318, level.camParams.DOF_Time, level.camParams.DOF_Time);
}

fixlocalfocus() {
  if(!isDefined(level.vlavatars[level.vl_focus])) {
    foreach(idx, avatar in level.vlavatars) {
      level.vl_focus = idx;
      break;
    }
  }
  if(!isDefined(level.vlavatars[level.vl_local_focus])) {
    level.vl_local_focus = level.vl_focus;
  }
}

vlobby_player() {
  self endon("disconnect");

  wait 0.05;

  player = self;

  player SetClientOmnvar("ui_vlobby_round_state", 0);
  player SetClientOmnvar("ui_vlobby_round_timer", 0);

  player grab_players_classes();
  player_origin = player.origin;
  player_angles = player.angles;

  target_origin = player_origin - (0, 0, 30);
  player setup_camparams();
  player vlobby_lighting_setup();

  facedir = anglesToForward(player.angles);
  rightdir = AnglesToRight(player.angles);
  movedir = facedir;
  ground_origin = GetGroundPosition(player_origin, 20, 512, 120);
  xuid = player getxuid();
  localPlayMatchReturn = (xuid == "");
  targetAvatar = undefined;
  level.needLocalMemberId = true;
  level.vl_focus = 0;
  level.vl_local_focus = 0;
  player.team = "spectator";

  primary_weapon = "iw5_hbra3_mp";
  primWeap = "iw5_hbra3";
  if(isDefined(player.loadouts["customClasses"][0]["primary"]) && player.loadouts["customClasses"][0]["primary"] != "none") {
    loadout_weapon = player.loadouts["customClasses"][0]["primary"];

    loadout_attachment1 = player.loadouts["customClasses"][0]["primaryAttachment1"];
    loadout_attachment2 = player.loadouts["customClasses"][0]["primaryAttachment2"];
    loadout_attachment3 = player.loadouts["customClasses"][0]["primaryAttachment3"];
    loadout_camo = player.loadouts["customClasses"][0]["primaryCamo"];
    loadout_reticule = player.loadouts["customClasses"][0]["primaryReticule"];

    if(isDefined(loadout_camo)) {
      loadout_camo = int(tableLookup("mp/camoTable.csv", 1, loadout_camo, 0));
    } else {
      loadout_camo = undefined;
    }
    if(isDefined(loadout_reticule)) {
      loadout_reticule = int(tableLookup("mp/reticleTable.csv", 1, loadout_reticule, 0));
    } else {
      loadout_reticule = undefined;
    }

    primary_weapon = maps\mp\gametypes\_class::BuildWeaponName(loadout_weapon, loadout_attachment1, loadout_attachment2, loadout_attachment3, loadout_camo, loadout_reticule);
    primWeap = player.loadouts["customClasses"][0]["primary"];
  } else if(isDefined(player.primaryWeapon)) {
    primary_weapon = player.primaryWeapon;
    primWeap = player.pers["primaryWeapon"];
  }

  cao_spawnpoint = getent("cao_spawnpoint", "targetname");
  if(!localPlayMatchReturn) {
    vlprintln("adding xuid " + xuid + "from vlobby_player");
    ownerId = add_avatar(xuid);
    assert(ownerId == 0);
    player spawn_an_avatar(player.avatar_spawnpoint, primary_weapon, player.secondaryWeapon, primWeap, player.loadoutEquipment, player.loadoutOffhand, player.perks, player.sessionCostume, player.name, ownerId, false);
    setEntPlayerXuidForEmblem(level.vlavatars[ownerid], xuid);
    thread SetVirtualLobbyPresentable();
  } else {
    level.needToPresent = true;
  }
  setDvar("virtuallobbymembers", level.xuid2ownerId.size);

  player.cao_agent = player spawn_an_avatar(cao_spawnpoint, primary_weapon, player.secondaryWeapon, primWeap, player.loadoutEquipment, player.loadoutOffhand, player.perks, player.sessionCostume, player.name, 0, true);
  setEntPlayerXuidForEmblem(player.cao_agent, xuid);
  hide_avatar(player.cao_agent);

  player thread monitor_class_select_or_weapon_change(0);

  if(!localPlayMatchReturn) {
    targetAvatar = level.vlavatars[level.vl_focus];
    targetAvatar.membertimeout = GetTime();
    targetAvatar.currentSelectedClass = player.currentSelectedClass;
    targetAvatar.player = player;
    targetAvatar.sessionCostume = targetAvatar.costume;
    virtual_lobby_set_class(0, "lobby" + (targetAvatar.currentSelectedClass + 1), true);
  }

  thread monitor_debug_addfakemembers(player, level.camParams);

  origin = (-70.7675, -691.293, 507.472);
  toavatar = player.avatar_spawnpoint.origin - origin;
  angles = (0, 87, 0);
  toavatar = VectorNormalize(toavatar);

  camera = spawn("script_model", origin);
  camera.angles = angles;
  camera setModel("tag_player");
  camera.startorigin = origin;
  camera.startangles = angles;
  camera.savedorigin = (0, 0, 0);
  camera.cam_percent_away = 0;
  camera.HasReachedFinalPos = true;
  camera.CamDirectionForward = true;
  camera.cut = true;
  camera.Gap = false;
  camera.finished = true;
  camera.goal_location = origin;
  self StoreCameraTargets(camera);
  sky_dist_from_cam = 400;
  player.camera = camera;
  camera.player = player;
  player.HasTouchedStick = false;
  weaponAngles = (0, 90, 0);
  camera.MovingState = "starting";

  level.vlCamera = camera;

  player SetOrigin(camera.origin);
  player PlayerLinkTo(camera, "tag_player");
  player CameraLinkTo(camera, "tag_player");
  level.in_firingrange = false;

  player AllowFire(false);
  player prep_for_controls(player.spawned_avatar, player.spawned_avatar.spawn_angles);
  player prep_for_controls(player.cao_agent, player.cao_agent.spawn_angles);

  updateSessionState("spectator");

  camParams = level.camParams;
  camParams.camera = camera;
  init_path_constants(camera);
  bg_dist_from_cam = 300;
  level.old_vl_focus = level.vl_focus;

  sky_dist_from_cam = 1000;
  camForward = anglesToForward(camera.angles);
  bg_plane = undefined;
  bg_plane_static = undefined;
  bg_plane_angles = undefined;
  bg_plane_offset = undefined;
  level.camParams.framedelay = level.camParams.pre_lobby_framedelay;

  thread monitor_player_removed();
  thread monitor_vl_mode_change();

  fly = false;
  testpaths = false;

  player SetClientDVar("cg_fovscale", "0.6153");

  player notify("fade_in");

  while(1) {
    avatar_after_spawn();
    if(level.vlavatars.size == 0) {
      if(camParams.mode == "game_lobby" || camParams.mode == "prelobby_loot") {
        hide_avatar(player.cao_agent);
        camera.cut = true;
        lobby_update_group_new(camera, undefined, camParams, player.avatar_spawnpoint);
        vlobby_vegnette(1, "ac130_overlay_pip_vignette_vlobby");
      }
      wait 0.05;
      continue;
    }
    targetAvatar = level.vlavatars[level.vl_focus];
    if(testpaths) {
      testpaths = false;
      player thread debug_pathing();
    }
    if(GetDvarInt("scr_vl_debugfly") > 0) {
      if(!fly) {
        fly = true;

        setDvar("r_dof_enable", "0");

        setDvar("lui_enabled", "0");
        level.debug_fly = undefined;
        player AllowFire(true);
      }
      player debug_fly(camera);
    } else if(fly) {
      setDvar("r_dof_enable", "1");

      setDvar("lui_enabled", "1");
      fly = false;
      camera.origin = camera.startorigin;
      camera.angles = camera.startangles;
      player AllowFire(false);
    }
    if(!level.in_firingrange) {
      if(level.vl_focus != level.old_vl_focus) {
        player prep_for_controls(level.vlavatars[level.vl_focus], level.vlavatars[level.vl_focus].angles);

        if(camParams.mode != "game_lobby") {
          camParams.newmode = "transition";
        }
        level.old_vl_focus = level.vl_focus;
        camParams.transitioning = true;
      }
      if(isDefined(level.vl_cao_focus) || isDefined(level.prv_vl_cao_focus)) {
        if(!isDefined(level.vl_cao_focus)) {
          camParams.newmode = camParams.pushmode;
          level.prv_vl_cao_focus = undefined;
        } else if(!isDefined(level.prv_vl_cao_focus)) {
          camParams.newmode = "cao";
          camParams.pushmode = camParams.mode;
          level.prv_vl_cao_focus = level.vl_cao_focus;
        } else if(level.vl_cao_focus != level.prv_vl_cao_focus) {
          level.prv_vl_cao_focus = level.vl_cao_focus;
        }
      }
      if(isDefined(level.cac) || isDefined(level.prv_cac)) {
        if(!isDefined(level.cac)) {
          camParams.newmode = camParams.pushmode;
          level.prv_cac = undefined;
          level.prv_cac_weapon = "none";
        } else if(!isDefined(level.prv_cac)) {
          camParams.newmode = "cac";
          camParams.pushmode = camParams.mode;
          level.prv_cac = level.cac;
        }
      }
      if(level.vlavatars.size == 0) {
        continue;
      }
      fixlocalfocus();
      targetAvatar = level.vlavatars[level.vl_focus];
      if(camParams.newmode != camParams.mode) {
        player vlobby_handle_mode_change(camParams.mode, camParams.newmode, camParams);

        if(camParams.newmode == "cac") {
          hide_avatar(player.cao_agent);
          player.HasTouchedStick = false;
          camParams.mode = camParams.newmode;
          camParams.tgt_camoffset_ratio = camParams.CAC_CAMOFFSET_ANGLE_RATIO;

          targetAvatar = level.vlavatars[level.vl_focus];
          player prep_for_controls(targetAvatar, targetAvatar.angles);
        } else if(camParams.mode == "cac") {
          show_non_owner_avatars();
          targetAvatar = level.vlavatars[level.vl_focus];

          player.HasTouchedStick = false;
        }
        if(camParams.newmode == "cao") {
          if(isDefined(level.vl_local_focus) && isDefined(level.vlavatars[level.vl_local_focus])) {
            agent = level.vlavatars[level.vl_local_focus];
            level.players[0].costume = agent.costume;
            costumeFound = level.players[0] maps\mp\gametypes\_teams::playerCostume();
            assert(costumeFound);
            costumeFound = agent maps\mp\gametypes\_teams::playerCostume();
            assert(costumeFound);

            caoAgent = level.players[0].cao_agent;
            vl_avatar_costume(caoAgent, agent.costume);
            costumeFound = caoAgent maps\mp\gametypes\_teams::playerCostume();
            assert(costumeFound);

            foreach(xuid, idx in level.xuid2ownerId) {
              if(idx == level.vl_local_focus) {
                if(isDefined(level.cao_xuid) && level.cao_xuid != xuid) {
                  SetEntPlayerXuidForEmblem(caoAgent, level.cao_xuid, true);
                }
                SetEntPlayerXuidForEmblem(caoAgent, xuid);
                level.cao_xuid = xuid;
                break;
              }
            }
          }

          show_avatar(player.cao_agent);
          player.cao_agent HackAgentAngles(player.cao_agent.spawn_angles);
          hide_avatars();
          targetAvatar = player.cao_agent;
          player prep_for_controls(player.cao_agent, player.cao_agent.angles);
          start_cao_anims();
          camParams.mode = camParams.newmode;

          camera.cut = true;
          player SetOrigin(targetAvatar.origin);
        } else if(camParams.newmode == "clanprofile") {
          hide_avatar(player.cao_agent);
          show_non_owner_avatars();
          targetAvatar = level.vlavatars[level.vl_focus];
          start_lobby_anims();
          player prep_for_controls(targetAvatar, targetAvatar.angles);
        } else if(camParams.newmode == "prelobby_loot") {
          camera.cut = true;
        } else if(camParams.newmode == "transition") {
          camParams.newmode = "game_lobby";
        }
        if(camParams.newmode == "game_lobby") {
          fixlocalfocus();

          vl_focus = 0;
          foreach(idx, avatar in level.vlavatars) {
            vl_focus = idx;
            break;
          }

          if(camParams.mode == "cao" || camParams.mode == "cac") {
            camera.finished = true;
            if(isDefined(level.vl_cao_focus)) {
              level.vl_local_focus = vl_focus;
              vl_focus = GetFocusFromController(level.vl_cao_focus);
            } else {
              level.vl_local_focus = vl_focus;
            }
          }

          if(isDefined(level.vlavatars) && isDefined(level.old_vl_focus) && isDefined(level.vlavatars[level.old_vl_focus])) {
            player prep_for_controls(level.vlavatars[level.old_vl_focus], level.vlavatars[level.old_vl_focus].angles);
          }

          camParams.goal = "waiting";

          if(camParams.mode != "cac") {
            show_avatars();
          }
          level.vl_focus = vl_focus;
          level.old_vl_focus = vl_focus;
          targetAvatar = level.vlavatars[vl_focus];

          if(camParams.mode != "cac") {
            camera.cut = true;
          } else if((camParams.mode == "cac") && isDefined(camera.avatar_spawnpoint) && (camera.avatar_spawnpoint != targetAvatar.avatar_spawnpoint)) {
            camera.cut = true;
          }

          start_lobby_anims();
          camera.last_avatar_position = targetAvatar.avatar_spawnpoint;
          camera.avatar_spawnpoint = targetAvatar.avatar_spawnpoint;

          player prep_for_controls(targetAvatar, targetAvatar.angles);

          camera.MovingState = "starting";
          player SetOrigin(targetAvatar.origin);
        }
        camParams.mode = camParams.newmode;
      }
      if(camParams.mode == "startmenu") {
        start_menu_update(camera, camParams);
      } else if(camParams.mode == "cao") {
        targetAvatar = player.cao_agent;
        cao_update(camera, targetAvatar, camParams);
        vlobby_vegnette(1, "ac130_overlay_pip_vignette_vlobby_cao");
      } else if(camParams.mode == "clanprofile") {
        clan_profile_update(camera, targetAvatar, camParams);
      } else if(camParams.mode == "cac") {
        lobby_update_group_new(camera, level.vlavatars[level.vl_focus], camParams, player.avatar_spawnpoint);
      } else if(camParams.mode == "transition") {
        camParams.newmode = "game_lobby";
      } else {
        if(camParams.CAOtoLobbyFrameTimer <= 0) {
          hide_avatar(player.cao_agent);
          lobby_update_group_new(camera, targetAvatar, camParams, player.avatar_spawnpoint);
          vlobby_vegnette(1, "ac130_overlay_pip_vignette_vlobby");
        } else {
          camParams.CAOtoLobbyFrameTimer = camParams.CAOtoLobbyFrameTimer - 1;
        }
      }
    }
    if(level.in_firingrange) {
      vlobby_vegnette(0, "ac130_overlay_pip_vignette_vlobby");
    }
    wait 0.05;
  }
}
TableLookupWeaponOffsets(WeaponString, SearchColumn, ReturnColumn) {
  offset = Float(TableLookup("mp/vlobby_cac_offsets.csv", SearchColumn, WeaponString, ReturnColumn));
  if(!isDefined(offset)) {
    offset = 0;
  }
  return offset;
}

StoreCameraTargets(camera) {
  PlayerPositions = getEntArray("player_pos", "targetname");
  camera.CamerHelperArray = [];
  foreach(AvatarSpawn in PlayerPositions) {
    camera.CamerHelperArray[camera.CamerHelperArray.size] = AvatarSpawn;
  }
  foreach(AvatarSpawn in PlayerPositions) {
    CameraTarget = GetEnt(AvatarSpawn.target, "targetname");
    if(CameraTarget.script_noteworthy == "camera_target") {
      AvatarSpawn.camera_lookat = CameraTarget;
    }
    CameraEnt = GetEnt(CameraTarget.target, "targetname");
    if(CameraEnt.script_noteworthy == "camera") {
      AvatarSpawn.camera_helper = CameraEnt;
      CameraEnt.camera_goal = AvatarSpawn;

      CameraEnt.camera_lookat = AvatarSpawn.camera_lookat;
    }
    if(AvatarSpawn.script_noteworthy == "0") {
      level.camParams.last_camera_helper = AvatarSpawn.camera_helper;
    }
    Num = int(AvatarSpawn.script_noteworthy);
    {
      camera.CamerHelperArray[Num] = AvatarSpawn;
    }
  }
}

calc_target_dir(camerapos, targetpos, camParams) {
  c2t = targetpos - camerapos;
  dist2D = Length2D(c2t);
  D = dist2D / sqrt(1 + camParams.cur_camoffset_ratio * camParams.cur_camoffset_ratio);
  vx = c2t[0] - camParams.cur_camoffset_ratio * c2t[1];
  vy = camParams.cur_camoffset_ratio * c2t[0] + c2t[1];
  v = D * VectorNormalize((vx, vy, 0));

  v = v + (0, 0, c2t[2]);
  return v;
}

hacky_get_delta_xrot(camParams, rotX) {
  dRot = rotX - camParams.oldRotX;
  if(dRot < -180) {
    dRot = 360 + dRot;
  } else if(dRot > 180) {
    dRot = 360 - dRot;
  }
  camParams.oldRotX = rotX;
  return dRot;
}
hacky_get_delta_yrot(camParams, rotY) {
  dRot = roty - camParams.oldRotY;
  if(dRot < -180) {
    dRot = -1;
  } else if(dRot > 180) {
    dRot = 1;
  } else {
    dRot = 0;
  }
  camParams.oldRotY = rotY;
  return dRot;
}

CamMove(target, time, acctime, dectime) {
  if(isDefined(self.cut)) {
    self.origin = target;
  } else {
    self moveto(target, time, acctime, dectime);
  }
}

CamRotate(target, time, acctime, dectime) {
  if(isDefined(self.cut)) {
    self.angles = target;
  } else {
    self rotateto(target, time, acctime, dectime);
  }
}

RotateAvatarTagCamera(avatar, spawnpoint) {
  if(!isDefined(avatar)) {
    CameraData = spawnStruct();
    CameraData.camera_tag_origin = (-70.8, -691.3, 502.2);
    CameraData.camera_tag_angles = (0, 87, 0);
    return cameraData;
  }

  tag_camera_loc_vec3 = avatar GetTagOrigin("TAG_STOWED_BACK");
  tag_camera_angles_vec3 = avatar GetTagAngles("TAG_STOWED_BACK");
  diff_angles_y = avatar.spawn_angles[1] - avatar.angles[1];

  up = (0, 0, 1);
  NewPos = tag_camera_loc_vec3 - avatar.origin;
  RotatedPos = RotatePointAroundVector(up, NewPos, diff_angles_y);
  NewCamPos = avatar.origin + RotatedPos;

  avatar.camera_tag_origin = NewCamPos;
  avatar.camera_tag_angles = (tag_camera_angles_vec3[0], AngleClamp(tag_camera_angles_vec3[1] + diff_angles_y), tag_camera_angles_vec3[2]);

  CameraData = spawnStruct();
  CameraData.camera_tag_origin = avatar.camera_tag_origin;
  CameraData.camera_tag_angles = avatar.camera_tag_angles;

  return CameraData;
}

CheckCamPosition(camera, position, units) {
  if(!isDefined(units)) {
    units = 2;
  }

  CamDist2Target = distance(position, camera.origin);

  if(CamDist2Target >= units) {
    return true;
  } else {
    return false;
  }
}

lobby_update_group_new(camera, targetAvatar, camParams, spawnpoint) {
  if(!isDefined(targetAvatar)) {
    level.camParams.framedelay = level.camParams.pre_lobby_framedelay;
    CameraAngles = camera.startangles;
    if(isDefined(spawnpoint)) {
      CameraAngles = (0, spawnpoint.angles[1] + 180, 0);
    }
    newCamOrigin = camera.startorigin;
    movedist = Distance(camera.origin, newCamOrigin);
    movetime = movedist / camParams.PRELOBBY_MOVESPEED;
    if(movetime < 0.1) {
      movetime = 0.1;
    }

    camera CamMove(newCamOrigin, movetime, movetime * 0.5, movetime * 0.5);
    camera CamRotate(CameraAngles, movetime, movetime * 0.5, movetime * 0.5);
  } else {
    if(level.camParams.framedelay == level.camParams.pre_lobby_framedelay) {
      self prep_for_controls(targetAvatar, targetAvatar.angles);
    }

    CameraAngles = (0, 87, 0);
    if(isDefined(targetAvatar.avatar_spawnpoint)) {
      CameraAngles = (0, targetAvatar.avatar_spawnpoint.angles[1] + 180, 0);
    }

    tag_camera_loc_vec3 = targetAvatar GetTagOrigin("TAG_STOWED_BACK");

    if(!isDefined(targetAvatar.camera_state)) {
      targetAvatar.camera_state = "stand";
    }

    if(targetAvatar.camera_state == "crouch") {
      CamLocationFloor = targetAvatar.avatar_spawnpoint.origin + (anglesToForward(targetAvatar.avatar_spawnpoint.angles) * camParams.GAMELOBBYGROUP_CAMERA_CrouchDistance);
      CamLocation = (CamLocationFloor[0], CamLocationFloor[1], camParams.GAMELOBBYGROUP_CAMERA_CrouchZ);
    } else if(targetAvatar.camera_state == "hunch") {
      CamLocationFloor = targetAvatar.avatar_spawnpoint.origin + (anglesToForward(targetAvatar.avatar_spawnpoint.angles) * camParams.GAMELOBBYGROUP_CAMERA_HunchDistance);
      CamLocation = (CamLocationFloor[0], CamLocationFloor[1], camParams.GAMELOBBYGROUP_CAMERA_HunchZ);
    } else if(targetAvatar.camera_state == "stand") {
      CamLocationFloor = targetAvatar.avatar_spawnpoint.origin + (anglesToForward(targetAvatar.avatar_spawnpoint.angles) * camParams.GAMELOBBYGROUP_CAMERA_NormalDistance);
      CamLocation = (CamLocationFloor[0], CamLocationFloor[1], camParams.GAMELOBBYGROUP_CAMERA_NormalZ);
    } else if(targetAvatar.camera_state == "zoom_high") {
      CamLocationFloor = targetAvatar.avatar_spawnpoint.origin + (anglesToForward(targetAvatar.avatar_spawnpoint.angles) * camParams.GAMELOBBYGROUP_CAMERA_CloseDistance);
      CamLocation = (CamLocationFloor[0], CamLocationFloor[1], camParams.GAMELOBBYGROUP_CAMERA_UpCloseZ);
    } else {
      CamLocationFloor = targetAvatar.avatar_spawnpoint.origin + (anglesToForward(targetAvatar.avatar_spawnpoint.angles) * camParams.GAMELOBBYGROUP_CAMERA_NormalDistance);
      CamLocation = (CamLocationFloor[0], CamLocationFloor[1], camParams.GAMELOBBYGROUP_CAMERA_NormalZ);
    }

    camera.goal_location = CamLocation;

    bCamSHouldUpdate = false;
    if(level.camParams.framedelay == 0) {
      bCamSHouldUpdate = CheckCamPosition(camera, CamLocation, 1.5);
    }

    camParams.cur_camoffset_ratio = camParams.GAMELOBBYGROUP_CAMOFFSET_ANGLE_RATIO;
    camParams.tgt_camoffset_ratio = camParams.GAMELOBBYGROUP_CAMOFFSET_ANGLE_RATIO;

    camera update_camera_params_ratio(camParams);

    AccelTime = 0;
    DecelTime = 0;

    movedist = Distance(camera.origin, CamLocation);
    movetime = movedist / camParams.GAMELOBBY_MOVESPEED;
    if(movetime < 0.1) {
      movetime = 0.1;
    }

    CorrectedMoveTime = movedist / (camParams.GAMELOBBY_MOVESPEED * level.camParams.GAMELOBBYGROUP_MOVESPEED_MODIFIER);
    if(CorrectedMoveTime < 0.1) {
      CorrectedMoveTime = 0.1;
    }

    rotationtime = 1;

    mode = GetDvarInt("virtualLobbyMode", 0);
    if(mode != LUI_MODE_CAC && mode != LUI_MODE_OBSCURED && mode != LUI_MODE_CAO) {
      self RightStickRotateAvatar(targetAvatar, 0.5);
    } else if(mode == LUI_MODE_OBSCURED || mode == LUI_MODE_CAO) {
      self prep_for_controls(targetAvatar, targetAvatar.angles);
      camera.cut = true;
    } else if(mode == LUI_MODE_CAC) {
      self prep_for_controls(targetAvatar, targetAvatar.angles);
    }

    if(level.camParams.framedelay > 0) {
      level.camParams.framedelay = level.camParams.framedelay - 1;
    }

    if(isDefined(targetAvatar.avatar_spawnpoint) && isDefined(camera.avatar_spawnpoint) && targetAvatar.avatar_spawnpoint != camera.avatar_spawnpoint) {
      camera.LastAvatarPositionEnt = camera.avatar_spawnpoint;
      camera.avatar_spawnpoint = targetAvatar.avatar_spawnpoint;
      camParams.goal = "finding_new_position";
      bCamSHouldUpdate = true;
      camera.finished = false;
    } else if(bCamSHouldUpdate == true) {
      camParams.goal = "moving";
    }

    if(camParams.goal == "waiting") {
      if(bCamSHouldUpdate == true) {
        camParams.goal = "moving";
        camera.finished = true;
      }

      camera.last_avatar_position = targetAvatar.avatar_spawnpoint;
    }

    if(camParams.goal == "finding_new_position") {
      if(bCamSHouldUpdate == true) {
        camera.LastAvatarPositionEnt = camera.avatar_spawnpoint;
        camera.avatar_spawnpoint = targetAvatar.avatar_spawnpoint;

        camera.obstacles = [];
        radius = OBSTACLE_RADIUS;
        foreach(avatar in level.vlavatars) {
          obstacle = [];
          obstacle["center"] = avatar.avatar_spawnpoint.origin;
          obstacle["radius"] = radius;
          camera.obstacles[camera.obstacles.size] = obstacle;
        }

        build_path_info(camera, camParams, camera.origin, CamLocation, CameraAngles);
        camera.fparams = calc_f_from_avatar(targetAvatar);
        camera.target_from_avatar = get_target_from_avatar(targetAvatar);
        camParams.goal = "moving";
      }
      camParams.goal = "moving";
    }

    if(camParams.goal == "moving") {
      if(level.camParams.framedelay <= 0) {
        level.camParams.framedelay = 0;

        if(camera.finished == false) {
          if(isDefined(camera.cut)) {
            camera CamMove(CamLocation, movetime, AccelTime, DecelTime);
            camera CamRotate(CameraAngles, rotationtime, rotationtime * 0.5, rotationtime * 0.5);

            camera.finished = true;
          } else {
            camera.finished = update_camera_on_path(camera, camParams);
          }
        }
        if(camera.finished) {
          camera CamMove(CamLocation, CorrectedMoveTime, CorrectedMoveTime * 0.5, CorrectedMoveTime * 0.5);
          camera CamRotate(CameraAngles, CorrectedMoveTime, CorrectedMoveTime * 0.5, CorrectedMoveTime * 0.5);

          camParams.goal = "waiting";
        }
      }
    }
    level.players[0] Set_Avatar_DOF();
  }

  if(isDefined(camera.cut)) {
    camera DontInterpolate();
    camera.cut = undefined;
  }

  if(GetDVarInt("virtualLobbyReady", 0) == 0) {
    wait 1.0;
    setDvar("virtualLobbyReady", "1");
    thread SetVirtualLobbyPresentable();
  }
}

SetVirtualLobbyPresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");

  if((level.vlavatars.size > 0) && isDefined(level.vlavatars[0]) && isDefined(level.vlavatars[0].primaryweapon) && IsWeaponLoaded(level.vlavatars[0].primaryweapon)) {
    level.needToPresent = undefined;
    wait 0.5;
    setDvar("virtualLobbyPresentable", "1");
  } else {
    level.needToPresent = true;
  }
}

ResetVirtualLobbyPresentable() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  level.needToPresent = undefined;
  wait 0.25;
  setDvar("virtualLobbyPresentable", "0");
}

MovePlayerEyeToCam(camera) {
  player = level.players[0];
  eyePos = player getEye();
  eyeDif = eyePos - player.origin;
  player SetOrigin(camera.origin - eyeDif, false);
  player SetPlayerAngles((player.angles[0], camera.angles[1], player.angles[2]));
}

GetAspectRatio() {
  AspectRatioData = spawnStruct();
  Resolution = getDvar("r_mode", "1280x720 [16:9]");
  Width_X_Height = StrTok(Resolution, " ");
  ResolutionArray = StrTok(Width_X_Height[0], "x");
  AspectRatioData.Width = stringToFloat(ResolutionArray[0]);
  AspectRatioData.Height = stringToFloat(ResolutionArray[1]);
  AspectRatioData.AspectRatio = roundDecimalPlaces(AspectRatioData.Width / AspectRatioData.Height, 3);
  return AspectRatioData;
}

GetModifiedRotationAngle(targetAvatar, rightStickDiffY, ratio) {
  if((abs(rightStickDiffY - targetAvatar.rotation_total) > 100)) {
    if(rightStickDiffY >= 270) {
      targetAvatar.addtobaseangle = targetAvatar.addtobaseangle + (-360 * ratio);
      if(targetAvatar.addtobaseangle == -360) {
        targetAvatar.addtobaseangle = 0;
      }
    }
    if(rightStickDiffY <= 100) {
      targetAvatar.addtobaseangle = targetAvatar.addtobaseangle + (360 * ratio);
      if(targetAvatar.addtobaseangle == 360) {
        targetAvatar.addtobaseangle = 0;
      }
    }
  }

  targetAvatar.rotation_total = rightStickDiffY;

  AddtoAngle = ((rightStickDiffY * ratio) + targetAvatar.addtobaseangle);

  return AddtoAngle;
}
cao_update(camera, targetAvatar, camParams) {
  self RightStickRotateAvatar(targetAvatar, 0.5);

  camParams.CAOtoLobbyFrameTimer = camParams.CAOtoLobbyFrameDelay;
  start_origin = targetAvatar.origin + (0, 0, -20) + (anglesToForward(targetAvatar.spawn_angles) * 120);

  camParams.zoom = camParams.CAO_CAMERA_RATIO;

  camParams.dist = camParams.CAO_NEARDIST + (camParams.CAO_FARDIST - camParams.CAO_NEARDIST) * camParams.zoom;
  cameraZOff = camParams.CAO_CAMERAZOFF + camParams.CAO_CAMERAZOFF_ZOOM * camParams.zoom;
  targetzoff = camParams.CAO_TARGETZOFF + camParams.CAO_TARGETZOFF_ZOOM * (1 - camParams.zoom);
  camParams.tgt_camoffset_ratio = camParams.CAO_CAMOFFSET_RATIO + camParams.PRELOBBY_RATIO_ZOOM * (camParams.zoom - 1);

  camera update_camera_params_ratio(camParams);
  ch_cyl_zoff = camParams.CH_CYL_ZOFF_NEAR + (camParams.CH_CYL_ZOFF_FAR - camParams.CH_CYL_ZOFF_NEAR) * camParams.zoom;

  target_origin = targetAvatar.origin + (0, 0, targetzoff);

  c2t = target_origin - (start_origin + camParams.origin_offset);
  c2t = camParams.dist * VectorNormalize(c2t);
  c2t = (c2t[0], c2t[1], -1 * cameraZOff);
  c2t = camParams.dist * VectorNormalize(c2t);
  newCamOrigin = target_origin - c2t;

  if(isDefined(level.caoAvatarPosOffset)) {
    target_origin = target_origin + level.caoAvatarPosOffset;
    newCamOrigin = newCamOrigin + level.caoAvatarPosOffset;
  }

  t2c = -1 * c2t;
  t2cangles = VectorToAngles(t2c);
  camParams.angle = t2cangles[1] - targetAvatar.startangles[1];

  movedist = Distance(camera.origin, newCamOrigin);
  movetime = movedist / camParams.PRELOBBY_MOVESPEED;
  if(movetime < 0.1) {
    movetime = 0.1;
  }
  camera CamMove(newCamOrigin, movetime, movetime * 0.5, movetime * 0.5);

  v = calc_target_dir(newCamOrigin, target_origin, camParams);
  angles = VectorToAngles(v);
  camera CamRotate(angles, movetime, movetime * 0.5, movetime * 0.5);

  if(isDefined(camera.cut)) {
    camera DontInterpolate();
    camera.cut = undefined;
  }
}

start_menu_update(camera, camParams) {}

clan_profile_update(camera, targetAvatar, camParams) {}

monitor_vl_mode_change() {
  self endon("disconnect");

  while(true) {
    mode = GetDvarInt("virtualLobbyMode", 0);
    if(level.camParams.mode != "cao") {
      if((level.camParams.mode != "prelobby") && (mode == LUI_MODE_PRELOBBY)) {
        level.camParams.newmode = "game_lobby";
      }
      if((string_find(level.camParams.mode, "prelobby") >= 0) && (mode == LUI_MODE_LOBBY)) {
        level.camParams.newmode = "game_lobby";
      }
    }
    wait 0.05;
  }
}

FindPositionNum() {
  position_number = self.script_noteworthy;
  position_number = int(position_number);
  return position_number;
}

monitor_player_removed() {
  self waittill("disconnect");

  self.camera Delete();
  vlprint("remove all ownerIds due to disconnect\n");
  foreach(xuid, ownerId in level.xuid2ownerId) {
    remove_avatar(ownerId);
  }
}

set_agent_values(team, sessionteam) {
  self set_agent_team(team);

  self.agent_gameParticipant = false;
  self.isActive = true;
  self.spawnTime = GetTime();
  self.IsSniper = false;
  self.sessionteam = sessionteam;;
}

bot_disable_tactical_goals() {
  self.disable_tactical_goals = true;
  self.tactical_goals = [];
}

wait_load_costume_show(agent) {
  if(IsAlive(agent)) {
    isLevelCAC = isDefined(level.cac);
    isPracticeNonOwner = GetDvarInt("practiceroundgame") && agent.ownerid != 0;

    if(!isLevelCAC && !isPracticeNonOwner) {
      show_avatar(agent);
    }
  }
}

wait_load_costume_timeout(seconds, agent) {
  self endon("disconnect");
  agent endon("wait_load_costume");

  agent endon("death");

  wait(seconds);

  wait_load_costume_show(agent);

  agent notify("wait_load_costume");
}

wait_load_costume(agent) {
  self endon("disconnect");

  agent notify("wait_load_costume");
  agent endon("wait_load_costume");
  agent endon("death");

  hide_avatar(agent);

  self thread wait_load_costume_timeout(5.0, agent);

  allLoaded = self LoadCostumeModels(agent.costume, agent.team);
  while(!allLoaded) {
    wait(0.1);
    allLoaded = self LoadCostumeModels(agent.costume, agent.team);
  }

  wait_load_costume_show(agent);

  agent notify("wait_load_costume");
}

#using_animtree("multiplayer_vlobby");
spawn_an_avatar(spawnpoint, primaryWeapon, secondaryWeapon, primWeap, equipment, offhand, perks, costume, memberName, ownerid, is_CAO_agent) {
  team = "spectator";
  sessionTeam = "none";
  agent = alloc_avatar();
  spawnpoint.spawned_avatar = agent;
  agent.avatar_spawnpoint = spawnpoint;
  agent.costume = costume;
  agent.activeCostume = 0;

  agent.rotation_offset = 0;
  agent set_agent_values(team, sessionTeam);

  ground_origin = GetGroundPosition(agent.avatar_spawnpoint.origin, 20, 512, 120);
  agent.spawn_angles = (spawnpoint.angles[0], spawnpoint.angles[1] + agent.rotation_offset, spawnpoint.angles[2]);
  agent.angles = agent.spawn_angles;
  agent Show();

  agent.ownerid = ownerid;

  agent SetPlayerAngles(agent.spawn_angles);
  agent SetOrigin(ground_origin, true);
  agent.angles = agent.spawn_angles;
  agent.startangles = agent.spawn_angles;
  agent.storedangleY = agent.angles[1];
  agent.mouseRot = 0;
  agent.storedRightStickY = 0;
  agent.rotation_total = 0;
  agent.addtobaseangle = 0;
  agent.rotation_parent = spawn("script_origin", agent.origin);

  agent.camera_cut = true;

  agent.camera_tag_origin = (0, 0, 0);
  agent.camera_tag_angles = (0, 0, 0);

  agent MotionBlurHQEnable();
  if(!isDefined(self.spawned_avatar)) {
    self.spawned_avatar = agent;
  }

  agent EnableAnimState(true);

  if(!isDefined(is_CAO_agent)) {
    is_CAO_agent = false;
  }

  if(is_CAO_agent == false) {
    level.vlavatars[ownerid] = agent;
    animdata = agent GetAnimData(primWeap);
    agent use_animstate(animdata.alias, true, animdata.animstate);
    agent thread CheckWeapChange(primaryWeapon);
  } else {
    agent.is_CAO_agent = true;
    primaryWeapon = undefined;
    agent.primaryWeapon = undefined;
    primWeap = undefined;

    agent use_animstate("cao_01", true, "lobby_idle");
  }

  agent maps\mp\gametypes\_spawnlogic::addToCharactersArray();

  if(IsALive(agent)) {
    vl_avatar_loadout(undefined, ownerid, primaryWeapon, secondaryWeapon, primWeap, equipment, offhand, perks, costume, agent);

    if(level.players.size > 0) {
      level.players[0] thread wait_load_costume(agent);
    }
  }

  if(isDefined(level.cac)) {}

  if(GetDvarInt("practiceroundgame") && ownerid != 0) {
    hide_avatar(agent);
  } else {
    show_avatar(agent);
  }

  return agent;
}

CheckWeapChange(primaryWeapon) {
  self endon("disconnect");
  self endon("death");
  self endon("free_avatar");

  if(!isDefined(self.primaryWeapon)) {
    self.primaryWeapon = primaryWeapon;
  }
  self.stored_weapon = self.primaryWeapon;

  WeaponString = undefined;

  while(true) {
    if(!isDefined(self.primaryWeaponEnt) || !isDefined(self.akimboWeaponEnt)) {
      wait 0.05;
      continue;
    }

    if(isDefined(self) && isDefined(self.primaryWeapon) && IsALive(self)) {
      WeapStringArray = StrTok(self.primaryWeapon, "_");
      WeaponString = WeapStringArray[0] + "_" + WeapStringArray[1];
    }

    CurrentAnim = self GetAnimEntry();
    CaoAnim = self GetAnimEntry("lobby_idle", "cao_01");
    animdata = self GetAnimData(WeaponString);
    DesiredAnim = self GetAnimEntry(animdata.animstate, animdata.alias);

    if(isDefined(level.camParams.mode)) {
      if(GetDvarInt("scr_vl_anim_choose_anim_enable", 0)) {
        if(self == level.vlavatars[level.vl_focus]) {
          animdata = self GetAnimData(WeaponString);

          anim_index = GetDvarInt("scr_vl_anim_index", 0);
          AnimCount = self GetAnimEntryCount(animdata.animstate);

          if(anim_index >= 0 && anim_index <= (AnimCount - 1)) {
            DesiredAnim = self GetAnimEntry(animdata.animstate, anim_index);

            if(CurrentAnim != DesiredAnim) {
              self.stored_weapon = self.primaryweapon;

              self use_animstate(anim_index, undefined, animdata.animstate);
            }
          }
        }

        wait(0.05);
        continue;
      }

      if(level.camParams.newmode != "cao" && level.camParams.mode != "cao") {
        if(isDefined(self) && isDefined(WeaponString) && IsALive(self)) {
          weaponLoaded = IsWeaponLoaded(self.primaryWeapon);

          changedWeapon = self.stored_weapon != self.primaryweapon;
          needUpdate = changedWeapon || (CurrentAnim != DesiredAnim);
          DiffBaseWeapon = GetWeaponBaseName(self.stored_weapon) != GetWeaponBaseName(self.primaryweapon);

          if(needUpdate) {
            if(weaponLoaded) {
              if(DiffBaseWeapon) {
                hide_avatar_primary_weapon(self);
                hide_avatar_akimbo_weapon(self);
                thread AttachWeaponDelayed(self);
                thread ShowPrimaryDelayed(self);
              }
              self.primaryWeaponEnt SetPickupWeapon(self.primaryWeapon);
              self.akimboWeaponEnt SetPickupWeapon(self.primaryWeapon);

              if(IsSubStr(self.primaryWeapon, "akimbo") || IsSubStr(self.primaryWeapon, "akimboxmg")) {
                if(DiffBaseWeapon) {
                  thread ShowAkimboDelayed(self);
                }
              } else {
                self.akimboWeaponEnt hide();
                self.akimboWeaponEnt HideAllParts();
              }
              self.stored_weapon = self.primaryweapon;
              animdata = self GetAnimData(WeaponString);
              self.camera_state = animdata.camera_state;

              self thread AnimDelayed(animdata.alias, animdata.animstate);
            } else {}
          }
        }
      }
    }
    wait(0.5);
  }
}

IsWeaponLoaded(weapon) {
  weaponLoaded = false;

  if(level.players.size > 0) {
    weaponLoaded = level.players[0] WorldWeaponsLoaded(weapon);
    if(!weaponLoaded) {
      level.players[0] LoadWeapons(weapon);
    }
  }

  return weaponLoaded;
}

AttachWeaponDelayed(agent) {
  wait(level.camParams.CACWeaponAttachDelayTime);
  AttachPrimaryWeapon(agent);
}

AnimDelayed(alias, animstate) {
  wait(level.camParams.CACWeaponAnimDelayTime);
  self use_animstate(alias, undefined, animstate);
}

#using_animtree("multiplayer_vlobby");
GetAnimData(primWeap) {
  animdata = spawnStruct();
  animdata.alias = primWeap;

  if(isDefined(primWeap) && primWeap != "" && primWeap != "none") {
    animdata.animstate = TableLookup("mp/vlobby_cac_offsets.csv", 0, primWeap, 5);
    animdata.camera_state = TableLookup("mp/vlobby_cac_offsets.csv", 0, primWeap, 6);
  }

  if(!isDefined(animdata.animstate) || animdata.animstate == "") {
    animdata.animstate = "lobby_idle";
    animdata.alias = "cao_01";
    animdata.camera_state = "stand";
  }
  self SetAnimClass("vlobby_animclass");

  if(!isDefined(animdata.camera_state)) {
    animdata.camera_state = "stand";
  }
  if(!isDefined(self.camera_state)) {
    self.camera_state = animdata.camera_state;
  }

  return animdata;
}

vl_give_weapons(player, agent) {
  AddLaunchers(agent);

  if(!isDefined(agent.primaryWeapon)) {
    return;
  }

  if(!isDefined(agent.animAlias)) {
    assertMsg("VL Agent doesn't have an animstate");
  } else {
    if(agent.primaryWeapon != "none") {
      if(!isDefined(agent.primaryWeaponEnt)) {
        primaryWeaponEnt = spawn("weapon_" + agent.primaryWeapon, (0, 0, 0));
        xuid = get_xuid_for_avatar(agent);
        setEntPlayerXuidForEmblem(primaryWeaponEnt, xuid);

        agent.primaryWeaponEnt = primaryWeaponEnt;
        primaryWeaponEnt.primaryweapon = agent.primaryWeapon;
        agent.primaryWeaponEnt show();
        agent.primaryWeaponEnt ShowAllParts();
        agent.primaryWeaponEnt SetPickupWeapon(agent.primaryWeapon);

        AttachPrimaryWeapon(agent);
      } else if(agent.primaryWeaponEnt.primaryWeapon != agent.primaryWeapon) {
        agent.primaryWeaponEnt.primaryweapon = agent.primaryWeapon;
      }

      if(!isDefined(agent.akimboWeaponEnt)) {
        akimboWeaponEnt = spawn("weapon_" + agent.primaryWeapon, (0, 0, 0));
        xuid = get_xuid_for_avatar(agent);
        setEntPlayerXuidForEmblem(akimboWeaponEnt, xuid);
        agent.akimboWeaponEnt = akimboWeaponEnt;
        akimboWeaponEnt.primaryweapon = agent.primaryWeapon;
      } else if(agent.akimboWeaponEnt.primaryWeapon != agent.primaryWeapon) {
        agent.akimboWeaponEnt.primaryweapon = agent.primaryWeapon;
      }
      tag_left = "tag_weapon_left";

      if(IsSubStr(agent.akimboWeaponEnt.primaryWeapon, "combatknife")) {
        tag_left = "tag_inhand";
      }

      if(IsSubStr(agent.akimboWeaponEnt.primaryWeapon, "riotshield")) {
        tag_left = "tag_weapon_left";
      }

      agent.akimboWeaponEnt unlink();
      agent.akimboWeaponEnt.origin = agent GetTagOrigin(tag_left);
      agent.akimboWeaponEnt.angles = agent GetTagAngles(tag_left);
      agent.akimboWeaponEnt LinkToSynchronizedParent(agent, tag_left);
      agent.akimboWeaponEnt SetOwnerOriginal(player);

      if(IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "akimbo") || IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "akimboxmg")) {
        thread ShowAkimboDelayed(agent);
      } else if(!isDefined(agent.stored_weapon)) {
        agent.akimboWeaponEnt hide();
        agent.akimboWeaponEnt HideAllParts();
      }
    }
    if(agent.secondaryWeapon != "none") {
      if(IsSubStr(agent.secondaryWeapon, "combatknife")) {
        if(isDefined(agent.secondaryWeaponEnt)) {
          if(agent.secondaryWeaponEnt IsLinked()) {
            agent.secondaryWeaponEnt Unlink();
          }
          agent.secondaryWeaponEnt Delete();
        }
      } else {
        if(!isDefined(agent.secondaryWeaponEnt)) {
          secondaryWeaponEnt = spawn("weapon_" + agent.secondaryWeapon, (0, 0, 0));
          xuid = get_xuid_for_avatar(agent);
          setEntPlayerXuidForEmblem(secondaryWeaponEnt, xuid);
          agent.secondaryWeaponEnt = secondaryWeaponEnt;
          secondaryWeaponEnt.secondaryweapon = agent.secondaryWeapon;
        } else if(agent.secondaryWeaponEnt.secondaryWeapon != agent.secondaryWeapon) {
          agent.secondaryWeaponEnt SetPickupWeapon(agent.secondaryWeapon);
          agent.secondaryWeaponEnt.secondaryweapon = agent.secondaryWeapon;
        }

        tag = "tag_stowed_back";
        agent.secondaryWeaponEnt unlink();
        agent.secondaryWeaponEnt.origin = agent GetTagOrigin(tag);
        agent.secondaryWeaponEnt.angles = agent GetTagAngles(tag);
        agent.secondaryWeaponEnt LinkToSynchronizedParent(agent, tag);
        agent.secondaryWeaponEnt ShowAllParts();
        agent.secondaryWeaponEnt SetOwnerOriginal(player);
      }
    }
  }
}

AttachPrimaryWeapon(agent) {
  player = undefined;
  if(isDefined(agent.player)) {
    player = agent.player;
  }
  tag = "tag_weapon_right";

  if(IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "combatknife")) {
    tag = "tag_inhand";
  }

  if(IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "riotshield")) {
    tag = "tag_weapon_left";
  }

  agent.primaryWeaponEnt unlink();
  agent.primaryWeaponEnt.origin = agent GetTagOrigin(tag);
  agent.primaryWeaponEnt.angles = agent GetTagAngles(tag);

  agent.primaryWeaponEnt LinkToSynchronizedParent(agent, tag);
  agent.primaryWeaponEnt SetOwnerOriginal(player);
}

AddLaunchers(agent) {
  agent Detach("npc_exo_arm_launcher_R", "J_Elbow_RI", false);
  agent Detach("npc_exo_arm_launcher_L", "J_Elbow_LE", false);

  if(isDefined(agent.lethal) && agent.lethal != "specialty_null") {
    if(!agent _hasPerk("specialty_wildcard_dualtacticals")) {
      agent attach("npc_exo_arm_launcher_R", "J_Elbow_RI", true);
    } else {}
  }

  if(isDefined(agent.tactical) && agent.tactical != "specialty_null") {
    if(agent _hasPerk("specialty_wildcard_duallethals")) {
      agent attach("npc_exo_arm_launcher_L", "J_Elbow_LE", true);
    } else {}
  }
}

ShowAkimboDelayed(agent) {
  agent endon("death");
  agent.primaryWeaponEnt endon("death");
  agent endon("hide_akimbo_weapon");

  wait(level.camParams.CACWeaponDelayTime);

  if(level.camParams.newmode != "cao" && level.camParams.mode != "cao") {
    if(IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "akimbo") || IsSubStr(agent.primaryWeaponEnt.primaryWeapon, "akimboxmg")) {
      agent.akimboWeaponEnt show();
      agent.akimboWeaponEnt ShowAllParts();
    }
  }
}

ShowPrimaryDelayed(agent) {
  agent endon("death");
  agent.primaryWeaponEnt endon("death");
  agent endon("hide_primary_weapon");

  wait(level.camParams.CACWeaponDelayTime);

  isPracticeNonOwner = GetDvarInt("practiceroundgame") && agent.ownerid != 0;

  if(level.camParams.newmode != "cao" && level.camParams.mode != "cao" && !isPracticeNonOwner) {
    agent.primaryWeaponEnt show();
    agent.primaryWeaponEnt ShowAllParts();
  }
}

vl_avatar_costume(agent, costume, setcostume) {
  agent TakeAllWeapons();
  agent DetachAll();
  agent.headModel = undefined;
  if(isDefined(costume)) {
    agent.costume = costume;
  }
  if(!isDefined(agent.costume) || !maps\mp\gametypes\_teams::validCostume(agent.costume)) {
    if(isDefined(agent.sessionCostume) && maps\mp\gametypes\_teams::validCostume(agent.sessionCostume)) {
      agent.costume = agent.sessionCostume;
    } else {
      agent.costume = maps\mp\gametypes\_teams::getDefaultCostume();
      agent.sessionCostume = agent.costume;
    }
  }
  if(isDefined(setcostume) && setcostume) {
    level.players[0].costume = agent.costume;
    costumeFound = level.players[0] maps\mp\gametypes\_teams::playerCostume();
    assert(costumeFound);
    costumeFound = agent maps\mp\gametypes\_teams::playerCostume();
    assert(costumeFound);

    caoAgent = level.players[0].cao_agent;
    vl_avatar_costume(caoAgent, agent.costume);
    costumeFound = caoAgent maps\mp\gametypes\_teams::playerCostume();
    assert(costumeFound);
  }
}

vl_avatar_loadout(player, ownerid, primaryWeapon, secondaryWeapon, primWeap, equipment, offhand, perks, costume, agent) {
  if(!isDefined(agent)) {
    agent = level.vlavatars[ownerid];
  }
  canLocalUpdate = false;

  if(isDefined(agent.loadout) && (agent.loadout.player_controller >= 0)) {
    canLocalUpdate = true;
  }

  vl_avatar_costume(agent, costume);

  if(getdvarint("scr_vl_printcostume", 0)) {
    print("ownerid " + ownerid + "\n");
    for(i = 0; i < level.costumeCategories.size; i++) {
      print("" + level.costumeCategories[i] + ": " + agent.costume[i] + "\n");
    }
  }

  agent maps\mp\gametypes\_teams::playerModelForWeapon(primWeap, getBaseWeaponName(secondaryWeapon));

  if(canLocalUpdate && isDefined(level.players[0])) {
    level.players[0] SetCostumeModels(agent.costume);
  }

  agent.primaryWeapon = primaryWeapon;

  agent.secondaryWeapon = "none";
  agent.tactical = offhand;
  agent.lethal = equipment;
  agent.perks = perks;

  vl_give_weapons(player, agent);
}

monitor_class_select_or_weapon_change(ownerid) {
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, index);
    if((channel == "classpreview" || channel == "classpreview_postcopy") && isDefined(index)) {
      if(index >= 0) {
        controller = index & 15;
        classIndex = int(index / 16);
        vlprint("classpreview " + channel + " controller=" + controller + "class=" + classIndex);

        if(classIndex > 0) {
          level.cac = true;
          self.currentSelectedClass = classIndex - 1;
        }
        ownerid = GetFocusFromController(controller);

        delayedRefresh = (channel == "classpreview_postcopy");
        avatar = level.vlavatars[ownerid];
        if(isDefined(avatar)) {
          level.vl_focus = ownerid;
          level.vl_local_focus = ownerid;
          virtual_lobby_set_class(ownerid, "lobby" + (self.currentSelectedClass + 1), !delayedRefresh);
          level.cac_weapon = avatar.primaryWeapon;
        }
        level.forceAvatarRefresh = delayedRefresh;
      } else {
        level.cac = undefined;
      }
    }
  }
}

monitor_cac_set_weapon(ownerid, newWeaponName) {
  ignore = "";
  if(newWeaponName != "none") {
    ignore = tablelookup("mp/statstable.csv", 4, newWeaponName, 51);
  }

  if((newWeaponName != "current") && (newWeaponName != "none") && (ignore == "")) {
    requiredAttachment = tablelookup("mp/statstable.csv", 4, newWeaponName, 40);

    if(requiredAttachment == "") {
      requiredAttachment = "none";
    }

    weaponName = maps\mp\gametypes\_class::buildWeaponName(newWeaponName, requiredAttachment, "none", "none");
  } else if(newWeaponName == "none") {
    weaponName = "none";
  } else {
    avatar = level.vlavatars[ownerid];
    weaponName = avatar.primaryWeapon;
  }
  level.cac_weapon = weaponName;
}

has_suffix(search_string, suffix) {
  if(search_string.size >= suffix.size) {
    if(GetSubStr(search_string, search_string.size - suffix.size, search_string.size) == suffix) {
      return true;
    }
  }

  return false;
}

monitor_create_a_class(ownerid) {
  self endon("disconnect");
  notifies = [];
  while(!isDefined(level.camParams)) {
    self waittill("luinotifyserver", channel, id);
    if(isDefined(id)) {
      notifies[notifies.size] = [channel, id];
    } else {
      notifies[notifies.size] = [channel];
    }
  }

  while(true) {
    if(notifies.size > 0) {
      note = notifies[0];
      newnotifies = [];
      for(i = 1; i < notifies.size; i++) {
        newnotifies[newnotifies.size] = notifies[i];
      }
      notifies = newnotifies;
      channel = note[0];
      if(note.size > 1) {
        id = note[1];
      } else {
        id = undefined;
      }
    } else {
      self waittill("luinotifyserver", channel, id);
    }
    if(channel == "cac" && isDefined(id)) {
      if(id == 0) {
        level.cac = undefined;
      } else {
        level.cac = true;
      }
      level.vl_cao_focus = undefined;
    } else if((channel == "weapon_highlighted") && isDefined(id)) {
      if(IsSubStr(id, "stream:")) {
        tokens = StrTok(id, ":");

        if(tokens.size > 1) {
          weaponName = tokens[tokens.size - 1];
          if(!has_suffix(weaponName, "_mp")) {
            weaponName += "_mp";
          }

          vlprintln("weapon_stream: " + weaponName);
          weaponsArray = [weaponName];
          self LoadWeapons(weaponsArray);
        }

        monitor_cac_set_weapon(ownerid, "none");
      } else {
        vlprintln("weapon_highlighted" + id);
        monitor_cac_set_weapon(ownerid, id);
      }
    } else if((channel == "lootscreen_weapon_highlighted") && isDefined(id)) {
      if(id == "none") {
        level.cac = undefined;
      } else if(id == "reset") {
        level.cac = true;
      } else {
        level.cac = true;
      }

      level.vl_cao_focus = undefined;
    } else {
      previewAttach = 0;
      if(channel == "preview_attach1") {
        previewAttach = 1;
      } else if(channel == "preview_attach2") {
        previewAttach = 2;
      } else if(channel == "preview_attach3") {
        previewAttach = 3;
      }

      if((previewAttach > 0) && isDefined(id)) {
        avatar = level.vlavatars[ownerid];
        entry = avatar.loadout;

        primary = TableLookup("mp/statstable.csv", 0, entry.primary, 4);
        primaryAttachment1 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment1, 3);
        primaryAttachment2 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment2, 3);
        primaryAttachment3 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment3, 3);
        primaryCamo = entry.primaryCamo;

        if(id != "current") {
          if(previewAttach == 1) {
            primaryAttachment1 = id;
          } else if(previewAttach == 2) {
            primaryAttachment2 = id;
          } else if(previewAttach == 3) {
            primaryAttachment3 = id;
          }
        }

        level.cac_weapon = maps\mp\gametypes\_class::BuildWeaponName(primary, primaryAttachment1, primaryAttachment2, primaryAttachment3, primaryCamo, undefined);
      }
    }
  }
}

GetFocusFromController(controller) {
  foreach(idx, avatar in level.vlavatars) {
    if(isDefined(avatar.loadout) && isDefined(avatar.loadout.player_controller) && (avatar.loadout.player_controller == controller)) {
      return idx;
    }
  }
  vlprintln("unable to find avatar for controller " + controller);
  return -1;
}

virtual_lobby_set_class(ownerid, class, refreshAvatar, force, agent) {
  if((isDefined(self.pers["class"]) && self.pers["class"] == class) && (!isDefined(force) || !force)) {
    return;
  }

  self.pers["class"] = class;
  self.class = class;

  self maps\mp\gametypes\_class::setClass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  self maps\mp\gametypes\_class::giveAndApplyLoadout(self.pers["team"], self.pers["class"]);

  if(refreshAvatar) {
    vl_avatar_loadout(self, ownerid, self.primaryWeapon, self.secondaryWeapon, self.pers["primaryWeapon"], self.loadoutEquipment, self.loadoutOffhand, self.perks, self.costume);
    if(isDefined(self.cao_agent)) {
      vl_avatar_loadout(self, ownerid, undefined, self.secondaryWeapon, self.pers["primaryWeapon"], self.loadoutEquipment, self.loadoutOffhand, self.perks, self.costume, self.cao_agent);
    }
  }
}

grab_players_classes() {
  customclasses = ["privateMatchCustomClasses", "customClasses"];
  self.loadouts = [];
  self.currentSelectedClass = 0;

  foreach(class in customclasses) {
    level.forceCustomClassLoc = class;
    self.loadouts[class] = [];
    for(class_num = 0; class_num < 10; class_num++) {
      loadout = [];
      loadout["primary"] = maps\mp\gametypes\_class::cac_getWeapon(class_num, 0);
      loadout["primaryAttachment1"] = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 0);
      loadout["primaryAttachment2"] = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 0);
      loadout["primaryAttachment3"] = maps\mp\gametypes\_class::cac_getWeaponAttachmentThree(class_num, 0);
      loadout["primaryCamo"] = maps\mp\gametypes\_class::cac_getWeaponCamo(class_num, 0);
      loadout["primaryReticle"] = maps\mp\gametypes\_class::cac_getWeaponReticle(class_num, 0);
      for(i = 0; i < 6; i++) {
        loadout["perk" + i] = maps\mp\gametypes\_class::cac_getPerk(class_num, i);
      }
      for(i = 0; i < 3; i++) {
        loadout["wildcard" + i] = maps\mp\gametypes\_class::cac_getWildcard(class_num, i);
      }
      loadout["secondary"] = maps\mp\gametypes\_class::cac_getWeapon(class_num, 1);
      loadout["secondaryAttachment1"] = maps\mp\gametypes\_class::cac_getWeaponAttachment(class_num, 1);
      loadout["secondaryAttachment2"] = maps\mp\gametypes\_class::cac_getWeaponAttachmentTwo(class_num, 1);
      loadout["secondaryAttachment3"] = maps\mp\gametypes\_class::cac_getWeaponAttachmentThree(class_num, 1);
      loadout["secondaryCamo"] = maps\mp\gametypes\_class::cac_getWeaponCamo(class_num, 1);
      loadout["secondaryReticle"] = maps\mp\gametypes\_class::cac_getWeaponReticle(class_num, 1);
      loadout["equipment"] = maps\mp\gametypes\_class::cac_getEquipment(class_num, 0);
      loadout["offhand"] = maps\mp\gametypes\_class::cac_getEquipment(class_num, 1);
      self.loadouts[class][class_num] = loadout;
    }
  }
  level.forceCustomClassLoc = undefined;
}

update_local_class(primary, primaryAttachment1, primaryAttachment2, primaryAttachment3, primaryCamo, primaryReticle, secondary, secondaryAttachment1, secondaryAttachment2, secondaryCamo, secondaryReticle, lethal, tactical, wildcard1, wildcard2, wildcard3, perk0, perk1, perk2, perk3, perk4, perk5) {
  class_num = int(self.currentSelectedClass);
  class = cac_getCustomClassLoc();
  self.loadouts[class][class_num]["primary"] = primary;
  self.loadouts[class][class_num]["primaryAttachment1"] = primaryAttachment1;
  self.loadouts[class][class_num]["primaryAttachment2"] = primaryAttachment2;
  self.loadouts[class][class_num]["primaryAttachment3"] = primaryAttachment3;
  self.loadouts[class][class_num]["primaryCamo"] = primaryCamo;
  self.loadouts[class][class_num]["primaryReticle"] = primaryReticle;
  self.loadouts[class][class_num]["secondary"] = secondary;
  self.loadouts[class][class_num]["secondaryAttachment1"] = secondaryAttachment1;
  self.loadouts[class][class_num]["secondaryAttachment2"] = secondaryAttachment2;
  self.loadouts[class][class_num]["secondaryCamo"] = secondaryCamo;
  self.loadouts[class][class_num]["secondaryReticle"] = secondaryReticle;
  self.loadouts[class][class_num]["equipment"] = lethal;
  self.loadouts[class][class_num]["lethal"] = lethal;
  self.loadouts[class][class_num]["offhand"] = tactical;
  self.loadouts[class][class_num]["tactical"] = tactical;
  self.loadouts[class][class_num]["wildcard0"] = wildcard1;
  self.loadouts[class][class_num]["wildcard1"] = wildcard2;
  self.loadouts[class][class_num]["wildcard2"] = wildcard3;
  self.loadouts[class][class_num]["perk0"] = perk0;
  self.loadouts[class][class_num]["perk1"] = perk1;
  self.loadouts[class][class_num]["perk2"] = perk2;
  self.loadouts[class][class_num]["perk3"] = perk3;
  self.loadouts[class][class_num]["perk4"] = perk4;
  self.loadouts[class][class_num]["perk5"] = perk5;
}

loadout_changed(orgLoadout, newLoadout) {
  if(!isDefined(orgLoadout)) {
    return true;
  }
  if(orgLoadout.primary != newLoadout.primary) {
    return true;
  }
  if(orgLoadout.primaryattachment1 != newLoadout.primaryattachment1) {
    return true;
  }
  if(orgLoadout.primaryattachment2 != newLoadout.primaryattachment2) {
    return true;
  }
  if(orgLoadout.primaryattachment3 != newLoadout.primaryattachment3) {
    return true;
  }
  if(orgLoadout.primarycamo != newLoadout.primarycamo) {
    return true;
  }
  if(orgLoadout.secondary != newLoadout.secondary) {
    return true;
  }
  if(orgLoadout.secondaryattachment1 != newLoadout.secondaryattachment1) {
    return true;
  }
  if(orgLoadout.secondaryattachment2 != newLoadout.secondaryattachment2) {
    return true;
  }
  if(orgLoadout.secondarycamo != newLoadout.secondarycamo) {
    return true;
  }
  if(orgLoadout.tactical != newLoadout.tactical) {
    return true;
  }
  if(orgLoadout.lethal != newLoadout.lethal) {
    return true;
  }

  return false;
}

costume_changed(orgCostume, newCostume) {
  if(!isDefined(orgCostume)) {
    if(!isDefined(newCostume)) {
      return false;
    }
    return true;
  }
  if(orgCostume.size != newCostume.size) {
    return true;
  }
  if(!maps\mp\gametypes\_teams::validCostume(newCostume)) {
    return false;
  }
  for(i = 0; i < newCostume.size; i++) {
    if(newCostume[i] < 0) {
      return false;
    }
    if(orgCostume[i] != newCostume[i]) {
      return true;
    }
  }
  return false;
}

setDefaultCostumeIfNeeded(costume) {
  if(costume[level.costumeCat2Idx["head"]] == 0) {
    costume[level.costumeCat2Idx["head"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["shirt"]]) {
    costume[level.costumeCat2Idx["shirt"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["pants"]]) {
    costume[level.costumeCat2Idx["pants"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["gloves"]]) {
    costume[level.costumeCat2Idx["gloves"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["shoes"]]) {
    costume[level.costumeCat2Idx["shoes"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["gear"]]) {
    costume[level.costumeCat2Idx["gear"]] = 1;
  }
  if(!costume[level.costumeCat2Idx["exo"]]) {
    costume[level.costumeCat2Idx["exo"]] = 1;
  }
  return costume;
}

monitor_member_class_changes() {
  level.mccqueue = [];

  while(true) {
    while(!isDefined(level.players) || (level.players.size == 0) || !isDefined(level.camParams)) {
      wait 0.05;
    }

    while(isDefined(level.players) && (level.players.size > 0)) {
      foreach(entry in level.mccqueue) {
        primary = TableLookup("mp/statstable.csv", 0, entry.primary, 4);
        primaryAttachment1 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment1, 3);
        primaryAttachment2 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment2, 3);
        primaryAttachment3 = TableLookup("mp/attachmenttable.csv", 0, entry.primaryattachment3, 3);
        primaryCamo = entry.primaryCamo;
        primaryCamoName = TableLookup("mp/camoTable.csv", 0, entry.primaryCamo, 1);
        primaryReticle = entry.primaryReticle;
        primaryReticleName = TableLookup("mp/reticleTable.csv", 0, entry.primaryReticle, 1);
        secondary = TableLookup("mp/statstable.csv", 0, entry.secondary, 4);
        secondaryAttachment1 = TableLookup("mp/attachmenttable.csv", 0, entry.secondaryattachment1, 3);
        secondaryAttachment2 = TableLookup("mp/attachmenttable.csv", 0, entry.secondaryattachment2, 3);
        secondaryAttachment3 = "none";
        secondaryCamo = entry.secondaryCamo;
        secondaryCamoName = TableLookup("mp/camoTable.csv", 0, entry.secondaryCamo, 1);
        secondaryReticle = entry.secondaryReticle;
        secondaryReticleName = TableLookup("mp/reticleTable.csv", 0, entry.secondaryReticle, 1);
        lethal = TableLookup("mp/perktable.csv", 0, entry.lethal, 1);
        tactical = TableLookup("mp/perktable.csv", 0, entry.tactical, 1);
        wildcard1 = TableLookup("mp/perktable.csv", 0, entry.wildcard1, 1);
        wildcard2 = TableLookup("mp/perktable.csv", 0, entry.wildcard2, 1);
        wildcard3 = TableLookup("mp/perktable.csv", 0, entry.wildcard3, 1);
        perk1 = TableLookup("mp/perktable.csv", 0, entry.perk1, 1);
        perk2 = TableLookup("mp/perktable.csv", 0, entry.perk2, 1);
        perk3 = TableLookup("mp/perktable.csv", 0, entry.perk3, 1);
        perk4 = TableLookup("mp/perktable.csv", 0, entry.perk4, 1);
        perk5 = TableLookup("mp/perktable.csv", 0, entry.perk5, 1);
        perk6 = TableLookup("mp/perktable.csv", 0, entry.perk6, 1);

        primaryWeapon = maps\mp\gametypes\_class::BuildWeaponName(primary, primaryAttachment1, primaryAttachment2, primaryAttachment3, primaryCamo, primaryReticle);
        secondaryWeapon = maps\mp\gametypes\_class::BuildWeaponName(secondary, secondaryAttachment1, secondaryAttachment2, secondaryAttachment3, secondaryCamo, secondaryReticle);
        weaponName = getBaseWeaponName(primaryWeapon);

        costume = [];
        costume[level.costumeCat2Idx["gender"]] = entry.gender;
        costume[level.costumeCat2Idx["shirt"]] = entry.shirt;
        costume[level.costumeCat2Idx["head"]] = entry.head;
        costume[level.costumeCat2Idx["pants"]] = entry.pants;
        costume[level.costumeCat2Idx["eyewear"]] = entry.eyewear;
        costume[level.costumeCat2Idx["hat"]] = entry.hat;
        costume[level.costumeCat2Idx["kneepads"]] = entry.kneepads;
        costume[level.costumeCat2Idx["gloves"]] = entry.gloves;
        costume[level.costumeCat2Idx["shoes"]] = entry.shoes;
        costume[level.costumeCat2Idx["gear"]] = entry.gear;
        costume[level.costumeCat2Idx["exo"]] = entry.exo;

        perks = [];
        if(isDefined(wildcard1)) {
          perks[wildcard1] = true;
        }
        if(isDefined(wildcard2)) {
          perks[wildcard2] = true;
        }
        if(isDefined(wildcard3)) {
          perks[wildcard3] = true;
        }

        if(!isDefined(level.xuid2ownerId[entry.xuid]) && all_avatars_scheduled_for_delete()) {
          reuse_avatar(entry.xuid);
        }
        if(!isDefined(level.xuid2ownerId[entry.xuid])) {
          ownerId = add_avatar(entry.xuid);
          vlprint("PartyMemberClassChange " + entry.xuid + " : " + primaryWeapon + "," + secondaryWeapon + "," + lethal + "," + tactical + "\n");
          setDvar("virtuallobbymembers", level.xuid2ownerId.size);
          spawnpoint = maps\mp\gametypes\vlobby::getSpawnPoint(ownerId);

          spawn_an_avatar(spawnpoint, primaryWeapon, secondaryWeapon, weaponName, lethal, tactical, perks, costume, entry.name, ownerId, false);
          avatar_after_spawn(ownerId);
          setEntPlayerXuidForEmblem(level.vlavatars[ownerId], entry.xuid);
          level.vlavatars[ownerId].loadout = entry;
          level.vlavatars[ownerId].membertimeout = GetTime() + 4000;

          if(level.vlavatars.size == 1) {
            caoAgent = level.players[0].cao_agent;
            vl_avatar_costume(caoAgent, level.vlavatars[ownerId].costume);
            costumeFound = caoAgent maps\mp\gametypes\_teams::playerCostume();
          }
        } else {
          ownerId = level.xuid2ownerId[entry.xuid];
          avatar = level.vlavatars[ownerId];

          if(entry.player_controller >= 0) {
            if(level.vl_local_focus == ownerId) {
              level.players[0] update_local_class(primary, primaryAttachment1, primaryAttachment2, primaryAttachment3, primaryCamoName, primaryReticleName, secondary, secondaryAttachment1, secondaryAttachment2, secondaryCamoName, secondaryReticleName, lethal, tactical, wildcard1, wildcard2, wildcard3, perk1, perk2, perk3, perk4, perk5, perk6);
            }

            if(isDefined(avatar.previewCostume)) {
              if(isDefined(avatar.costumes) && isDefined(avatar.costumes[avatar.previewCostume])) {
                costume = avatar.costumes[avatar.previewCostume];
              } else {
                print("ownerId " + ownerId + " doesnt have a costume " + avatar.previewCostume);
                costume = level.players[0] maps\mp\gametypes\_class::cao_getCostumeByIndex(avatar.previewCostume);
              }
              costume = setDefaultCostumeIfNeeded(costume);

              if(!isDefined(avatar.costumes)) {
                avatar.costumes = [];
              }
              avatar.costumes[avatar.previewCostume] = costume;

              if(avatar.previewGearCategory != "none") {
                catIdx = level.costumeCat2Idx[avatar.previewGearCategory];
                costume[catIdx] = avatar.previewGearId;
              }
            }
          }

          if(loadout_changed(avatar.loadout, entry) || costume_changed(avatar.costume, costume) || (isDefined(level.forceAvatarRefresh) && level.forceAvatarRefresh)) {
            vlprint("Updating xuid " + entry.xuid + " with ownerId=" + ownerId + "\n");
            vlprint("PartyMemberClassChange " + entry.xuid + " : " + primaryWeapon + "," + secondaryWeapon + "," + lethal + "," + tactical + "\n");
            if(isDefined(avatar.player)) {
              avatar.player.costume = costume;
            }
            vl_avatar_loadout(avatar.player, ownerid, primaryWeapon, secondaryWeapon, weaponName, lethal, tactical, perks, costume);
            if(entry.player_controller >= 0) {
              vl_avatar_loadout(avatar.player, ownerid, undefined, secondaryWeapon, weaponName, lethal, tactical, perks, costume, level.players[0].cao_agent);
            }
            avatar.loadout = entry;
            level.forceAvatarRefresh = false;
          }
        }
      }
      level.mccqueue = [];
      update_avatars();
      wait 0.05;
    }
  }
}

override_member_loadout_for_practice_round(entry) {
  if(!isDefined(level.practice_round_costume)) {
    level.practice_round_max_costumes = TableGetColumnCount(level.practiceRoundCostumeTableName) - 1;
    level.practice_round_costume = RandomInt(level.practice_round_max_costumes);
  }

  if(!isDefined(level.practice_round_class)) {
    practice_round_max_classes = TableGetColumnCount(level.practiceRoundClassTableName) - 1;
    level.practice_round_class = RandomInt(practice_round_max_classes);
  }

  SetDevDvarIfUninitialized("scr_test_pr_classes", 0);
  if(GetDvarInt("scr_test_pr_classes", 0)) {
    time_per_char = 2000;
    time_total = level.practice_round_max_costumes * time_per_char;
    level.practice_round_costume = Int((GetTime() % time_total) / time_per_char);
    level.practice_round_costume = level.practice_round_costume % level.practice_round_max_costumes;
  }

  assert(level.practice_round_costume < level.practice_round_max_costumes);

  newEntry = entry;

  newCostume = GetCostumeFromTable(level.practiceRoundCostumeTableName, level.practice_round_costume + 1);

  newEntry.gender = newCostume[level.costumeCat2Idx["gender"]];
  newEntry.shirt = newCostume[level.costumeCat2Idx["shirt"]];
  newEntry.head = newCostume[level.costumeCat2Idx["head"]];
  newEntry.pants = newCostume[level.costumeCat2Idx["pants"]];
  newEntry.eyewear = newCostume[level.costumeCat2Idx["eyewear"]];
  newEntry.hat = newCostume[level.costumeCat2Idx["hat"]];
  newEntry.gear = newCostume[level.costumeCat2Idx["gear"]];
  newEntry.kneepads = newCostume[level.costumeCat2Idx["kneepads"]];
  newEntry.gloves = newCostume[level.costumeCat2Idx["gloves"]];
  newEntry.shoes = newCostume[level.costumeCat2Idx["shoes"]];
  newEntry.exo = newCostume[level.costumeCat2Idx["exo"]];

  classIndex = level.practice_round_class;
  classColumn = classIndex + 1;

  primaryWeapon = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimary", classColumn);
  primaryAttach1 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimaryAttachment", classColumn);
  primaryAttach2 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimaryAttachment2", classColumn);
  primaryAttach3 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimaryAttachment3", classColumn);
  primaryCamo = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimaryCamo", classColumn);
  primaryReticle = TableLookup(level.practiceRoundClassTableName, 0, "loadoutPrimaryReticle", classColumn);

  newEntry.primary = Int(TableLookup("mp/statstable.csv", 4, primaryWeapon, 0));
  newEntry.primaryattachment1 = Int(TableLookup("mp/attachmenttable.csv", 3, primaryAttach1, 0));
  newEntry.primaryattachment2 = Int(TableLookup("mp/attachmenttable.csv", 3, primaryAttach2, 0));
  newEntry.primaryattachment3 = Int(TableLookup("mp/attachmenttable.csv", 3, primaryAttach3, 0));
  newEntry.primarycamo = Int(TableLookup("mp/camoTable.csv", 1, primaryCamo, 0));
  newEntry.primaryreticle = Int(TableLookup("mp/reticleTable.csv", 1, primaryReticle, 0));

  secondaryWeapon = TableLookup(level.practiceRoundClassTableName, 0, "loadoutSecondary", classColumn);
  secondaryAttach1 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutSecondaryAttachment", classColumn);
  secondaryAttach2 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutSecondaryAttachment2", classColumn);
  secondaryCamo = TableLookup(level.practiceRoundClassTableName, 0, "loadoutSecondaryCamo", classColumn);
  secondaryReticle = TableLookup(level.practiceRoundClassTableName, 0, "loadoutSecondaryReticle", classColumn);

  newEntry.secondary = Int(TableLookup("mp/statstable.csv", 4, secondaryWeapon, 0));
  newEntry.secondaryattachment1 = Int(TableLookup("mp/attachmenttable.csv", 3, secondaryAttach1, 0));
  newEntry.secondaryattachment2 = Int(TableLookup("mp/attachmenttable.csv", 3, secondaryAttach2, 0));
  newEntry.secondarycamo = Int(TableLookup("mp/camoTable.csv", 1, secondaryCamo, 0));
  newEntry.secondaryreticle = Int(TableLookup("mp/reticleTable.csv", 1, secondaryReticle, 0));

  wildcard1 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutWildcard1", classColumn);
  wildcard2 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutWildcard2", classColumn);
  wildcard3 = TableLookup(level.practiceRoundClassTableName, 0, "loadoutWildcard3", classColumn);

  newEntry.wildcard1 = Int(TableLookup("mp/perktable.csv", 1, wildcard1, 0));
  newEntry.wildcard2 = Int(TableLookup("mp/perktable.csv", 1, wildcard2, 0));
  newEntry.wildcard3 = Int(TableLookup("mp/perktable.csv", 1, wildcard3, 0));

  return newEntry;
}

add_party_member_class_change(entry) {
  if(GetDvarInt("practiceroundgame")) {
    entry = override_member_loadout_for_practice_round(entry);
  }

  for(i = 0; i < level.mccqueue.size; i++) {
    if(level.mccqueue[i].xuid == entry.xuid) {
      level.mccqueue[i] = entry;
      entry = undefined;
      break;
    }
  }
  if(isDefined(entry)) {
    level.mccqueue[level.mccqueue.size] = entry;
  }
}

party_members(loadouts) {
  if(!isDefined(level.xuid2ownerId)) {
    return;
  }

  foreach(loadout in loadouts) {
    xuid = loadout.xuid;
    ownerId = level.xuid2ownerid[xuid];
    if(isDefined(ownerId)) {
      avatar = level.vlavatars[ownerId];
      if(isDefined(avatar)) {
        avatar.membertimeout = GetTime() + 2000;
        avatar.memberHasTimedOut = undefined;
      }
    }
    if(loadout.primary >= 0) {
      add_party_member_class_change(loadout);
    }
  }
}

monitor_member_timeouts() {
  while(true) {
    localplay = GetDvarInt("splitscreen", 0);
    online = IsOnlineGame();
    systemlink = IsSystemLink();
    foreach(ownerId, avatar in level.vlavatars) {
      if(avatar_scheduled_for_removal(ownerId)) {
        continue;
      }

      if(avatar.membertimeout >= 0) {
        if(avatar.membertimeout < GetTime()) {
          if(ownerId == 0 && !isDefined(avatar.memberHasTimedOut)) {
            avatar.membertimeout = GetTime() + 2000;
            avatar.memberHasTimedOut = 1;
            continue;
          }
          vlprint("Schedule removal of ownerId " + ownerid + " from timeout\n");
          schedule_remove_avatar(ownerid);
        }
      }
    }
    wait 0.05;
  }
}

get_e3_costume(idx) {
  table = "mp/E3CostumeTable.csv";
  costume = [];
  for(i = 0; i < level.costumeCat2Idx.size; i++) {
    costume[i] = int(TableLookupByRow(table, i + 1, idx + 1));
  }
  return costume;
}

monitor_debug_addfakemembers(player, camParams) {
  while(true) {
    if(isDefined(level.vl_fakemembers) && level.vl_fakemembers > 0 && !isDefined(level.debug_fly)) {
      if(isDefined(camParams.mode) && camParams.mode == "game_lobby") {
        if(player AdsButtonPressed()) {
          ownerId = level.vl_focus - 1;
          if(ownerId < 0) {
            ownerId = 17;
          }
          oId = -1;
          while(ownerId != oId) {
            foreach(oId in level.xuid2ownerId) {
              if(oId == ownerId) {
                break;
              }
            }
            if(oId != ownerId) {
              oId = -1;
              ownerId--;
              if(ownerId < 0) {
                ownerId = 17;
              }
            }
          }
          level.vl_focus = ownerId;
          while(player AdsButtonPressed()) {
            wait 0.05;
          }
        } else if(player AttackButtonPressed()) {
          ownerId = level.vl_focus + 1;
          if(ownerId > 17) {
            ownerId = 0;
          }
          oId = -1;
          while(ownerId != oId) {
            foreach(oId in level.xuid2ownerId) {
              if(oId == ownerId) {
                break;
              }
            }
            if(oId != ownerId) {
              oId = -1;
              ownerId++;
              if(ownerId > 17) {
                ownerId = 0;
              }
            }
          }
          level.vl_focus = ownerId;
          while(player AttackButtonPressed()) {
            wait 0.05;
          }
        }
      }
    }
    if(GetDvarInt("scr_vl_addfakemembers", 0) > 0) {
      xuid = ToString(GetTime());
      ownerId = add_avatar(xuid);
      if(!isDefined(level.fake_ownerids)) {
        level.fake_ownerids = [];
      }
      level.fake_ownerids[level.fake_ownerids.size] = ownerId;
      vlprint("Adding new fake xuid " + xuid + " with ownerId=" + ownerId + "\n");
      vlprint("PartyMemberClassChange " + xuid + " : " + player.primaryWeapon + "," + player.secondaryWeapon + "," + player.loadoutOffhand + "," + player.loadoutEquipment + "\n");

      spawnpoint = maps\mp\gametypes\vlobby::getSpawnPoint(ownerId);

      team = player.team;
      sessionTeam = player.sessionteam;
      name = "fakeplayer" + ownerId;

      costume = get_e3_costume(ownerid);
      spawn_an_avatar(spawnpoint, player.primaryWeapon, player.secondaryWeapon, player.pers["primaryWeapon"], player.loadoutEquipment, player.loadoutOffhand, player.perks, costume, name, ownerId, false);
      avatar_after_spawn(ownerId);
      avatar = level.vlavatars[ownerid];
      avatar.loadout = level.vlavatars[0].loadout;
      avatar.costume = costume;
      avatar.sessionCostume = avatar.costume;
      avatar SetCostumeModels(avatar.costume);
      avatar.membertimeout = GetTime() + 3600000;
      SetEntPlayerXuidForEmblem(avatar, xuid);
      level.vl_fakemembers++;
      setDvar("scr_vl_addfakemembers", toString(GetDvarInt("scr_vl_addfakemembers", 1) - 1));
    }
    if(GetDvarInt("scr_vl_addfakemembers", 0) < 0) {
      foreach(oId in level.fake_ownerids) {
        level.vlavatars[oId].membertimeout = GetTime() + 1000;
        level.vl_fakemembers--;
      }
      level.fake_ownerids = [];
      setDvar("scr_vl_addfakemembers", "0");
      level.vl_focus = 0;
    }
    wait 0.05;
  }
}

monitor_member_focus_change() {
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, xuid);
    if(channel == "member_select") {
      level.vl_focus = level.xuid2ownerId[xuid];
      if(!isDefined(level.vl_focus)) {
        vlprint("vl_focus undefined, setting to 0\n");
        level.vl_focus = 0;
      }
      vlprint("selected member " + xuid + " ownerId=" + level.vl_focus + "\n");
    }
    if(channel == "vlpresentable") {
      vlprint("in main menu\n");
      thread SetVirtualLobbyPresentable();
    }
    if(channel == "leave_lobby") {
      vlprint("leave_lobby xuid=" + xuid + "\n");
      if(xuid == "0") {
        foreach(xuid, ownerId in level.xuid2ownerId) {
          vlprint("Schedule removal of ownerId " + ownerid + "\n");
          schedule_remove_avatar(ownerid, 0.25);
        }
      } else {
        ownerId = level.xuid2ownerId[xuid];
        if(isDefined(ownerId)) {
          vlprint("Schedule removal of ownerId " + ownerid + "\n");
          schedule_remove_avatar(ownerid, 0.25);
        }
      }
      thread ResetVirtualLobbyPresentable();
    }
  }
}

monitor_cao_set_cao_focus(controller) {
  if(controller < 0) {
    level.vl_cao_focus = undefined;
  } else {
    level.vl_local_focus = GetFocusFromController(controller);
    level.vl_cao_focus = 1;
    vlprint("cao ctrl = " + controller + " focus = " + level.vl_local_focus + "\n");
  }
}

cao_set_costumes_from_lua(val) {
  vlprintln("Cao set costumes from lua:" + val);
  cntrGrps = StrTok(val, "#");
  foreach(cntrGrp in cntrGrps) {
    costdefs = StrTok(cntrGrp, "|");
    if(costdefs.size > 0) {
      controller = int(costdefs[0]);
      focus = GetFocusFromController(controller);
      avatar = level.vlavatars[focus];
      if(isDefined(avatar)) {
        avatar.activeCostume = int(costdefs[1]);
        for(i = 2; i < costdefs.size; i++) {
          tokens = StrTok(costdefs[i], ",");
          costume = [];
          assert(tokens.size == (level.costumeCat2Idx.size + 1));
          for(type = 1; type < tokens.size; type++) {
            costume[costume.size] = int(tokens[type]);
          }
          if(!isDefined(avatar.costumes)) {
            avatar.costumes = [];
          }
          avatar.costumes[int(tokens[0])] = costume;
        }
      }
    }
  }
}

monitor_cao_set_costume_preview(val) {
  basetoks = StrTok(val, ":");
  controller = int(basetoks[0]);
  tokens = StrTok(basetoks[1], ",");
  ownerid = GetFocusFromController(controller);
  level.vl_local_focus = ownerid;
  avatar = level.vlavatars[ownerid];
  if(isDefined(avatar)) {
    avatar.previewCostume = Int(tokens[0]);
    avatar.previewGearCategory = tokens[1];
    avatar.previewGearId = Int(tokens[2]);
  }
  return avatar;
}

monitor_create_an_operator(ownerid) {
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, val);
    if(channel == "cao") {
      monitor_cao_set_cao_focus(val);

      level.caoAvatarPosOffset = undefined;

      if(isDefined(level.vl_local_focus)) {
        avatar = level.vlavatars[level.vl_local_focus];
      } else {
        avatar = level.vlavatars[ownerid];
      }
      if(val < 0 && isDefined(avatar)) {
        avatar.previewGearCategory = undefined;
        avatar.previewGearId = undefined;
        avatar.previewCostume = undefined;
        if(isDefined(avatar.costumes)) {
          vl_avatar_costume(avatar, avatar.costumes[avatar.activeCostume], true);
        }
      }
    } else if(channel == "lootscreen_gear_highlighted") {
      level.cac = undefined;

      monitor_cao_set_cao_focus(val);
      if(isDefined(level.vl_cao_focus)) {
        level.caoAvatarPosOffset = (56, 0, 5);
      } else {
        level.caoAvatarPosOffset = undefined;
      }

      level.camParams.pushmode = "prelobby_loot";
    } else if(channel == "costumes") {
      cao_set_costumes_from_lua(val);
    } else if(channel == "costume_preview") {
      monitor_cao_set_costume_preview(val);
    } else if(channel == "costume_apply") {
      avatar = monitor_cao_set_costume_preview(val);

      if(isDefined(avatar)) {
        catIdx = level.costumeCat2Idx[avatar.previewGearCategory];
        if(isDefined(avatar.costumes) && isDefined(avatar.costumes[avatar.previewCostume])) {
          avatar.costumes[avatar.previewCostume][catIdx] = avatar.previewGearId;
          if(avatar.previewCostume == avatar.activeCostume) {
            avatar SetCostumeModels(avatar.costumes[avatar.previewCostume]);
          }
        }
      }
    }
  }
}

monitor_clans() {
  self endon("disconnect");
  level.clanMemberOwnerIDs = [];

  while(true) {
    self waittill("luinotifyserver", channel, val);

    if(channel == "clanprofile") {
      vlprint("Using clan profile VL settings\n");
      if(val < 0) {
        level.vl_clanprofile_focus = undefined;
      } else {
        level.vl_clanprofile_focus = val;
      }
      level.caoAvatarPosOffset = undefined;
    }
  }
}

hide_avatar(avatar) {
  avatar Hide();
  avatar HideAllParts();

  hide_avatar_weapons(avatar);
}

show_avatar(avatar) {
  AddLaunchers(avatar);
  avatar Show();
  avatar ShowAllParts();

  if(isDefined(avatar.primaryWeaponEnt)) {
    avatar.primaryWeaponEnt Show();
    avatar.primaryWeaponEnt ShowAllParts();
  }
  if(isDefined(avatar.secondaryWeaponEnt)) {
    avatar.secondaryWeaponEnt Show();
    avatar.secondaryWeaponEnt ShowAllParts();
  }
  if(isDefined(avatar.akimboWeaponEnt) && isDefined(avatar.akimboWeaponEnt.primaryWeapon)) {
    if(IsSubStr(avatar.akimboWeaponEnt.primaryWeapon, "akimbo") || IsSubStr(avatar.akimboWeaponEnt.primaryWeapon, "akimboxmg")) {
      avatar.akimboWeaponEnt show();
      avatar.akimboWeaponEnt ShowAllParts();
    }
  }

}

hide_avatar_primary_weapon(avatar) {
  if(isDefined(avatar.primaryWeaponEnt)) {
    avatar notify("hide_primary_weapon");
    avatar.primaryWeaponEnt Hide();
    avatar.primaryWeaponEnt HideAllParts();
  }
}

hide_avatar_secondary_weapon(avatar) {
  if(isDefined(avatar.secondaryWeaponEnt)) {
    avatar notify("hide_secondary_weapon");
    avatar.secondaryWeaponEnt Hide();
    avatar.secondaryWeaponEnt HideAllParts();
  }
}

hide_avatar_akimbo_weapon(avatar) {
  if(isDefined(avatar.akimboWeaponEnt)) {
    avatar notify("hide_akimbo_weapon");
    avatar.akimboWeaponEnt Hide();
    avatar.akimboWeaponEnt HideAllParts();
  }
}

hide_avatar_weapons(avatar) {
  hide_avatar_primary_weapon(avatar);
  hide_avatar_secondary_weapon(avatar);
  hide_avatar_akimbo_weapon(avatar);
}

hide_avatars() {
  foreach(avatar in level.vlavatars) {
    hide_avatar(avatar);
  }
}

show_avatars() {
  foreach(avatar in level.vlavatars) {
    show_avatar(avatar);
  }
}

get_xuid_for_avatar(avatar) {
  foreach(xuid, ownId in level.xuid2ownerId) {
    if(isDefined(level.vlavatars[ownId]) && level.vlavatars[ownId] == avatar) {
      return xuid;
    }
  }
  return "";
}

remove_avatar(ownerId) {
  ownId = -1;
  foreach(xuid, ownId in level.xuid2ownerId) {
    if(ownId == ownerId) {
      break;
    }
  }
  vlprint("Removing xuid " + xuid + " for ownerId " + ownerId + "\n");
  assert(ownId == ownerId);
  setEntPlayerXuidForEmblem(level.vlavatars[ownerid], xuid, true);
  level.xuid2ownerId[xuid] = undefined;
  level.avatarInfo[ownerId].timeToDelete = 0;
  level.avatarInfo[ownerId].avatar = undefined;
  setDvar("virtuallobbymembers", level.xuid2ownerId.size);
  agent = level.vlavatars[ownerId];
  level.vlavatars[ownerId] = undefined;
  if(level.vl_focus == ownerId) {
    if(level.vlavatars.size > 0) {
      foreach(idx, avatar in level.vlavatars) {
        level.vl_focus = idx;
        break;
      }
    }
  }
  hide_avatar(agent);
  agent TakeAllWeapons();
  agent DetachAll();
  agent.headModel = undefined;
  agent HideAllParts();
  if(isDefined(agent.avatar_spawnpoint.spawned_avatar)) {
    agent.avatar_spawnpoint.spawned_avatar = undefined;
  }
  if(isDefined(agent.primaryWeaponEnt)) {
    setEntPlayerXuidForEmblem(agent.primaryWeaponEnt, xuid, true);
    agent.primaryWeaponEnt Delete();
    agent.primaryWeaponEnt = undefined;
  }
  if(isDefined(agent.secondaryWeaponEnt)) {
    setEntPlayerXuidForEmblem(agent.secondaryWeaponEnt, xuid, true);
    agent.secondaryWeaponEnt Delete();
    agent.secondaryWeaponEnt = undefined;
  }
  if(isDefined(agent.akimboWeaponEnt)) {
    setEntPlayerXuidForEmblem(agent.akimboWeaponEnt, xuid, true);
    agent.akimboWeaponEnt delete();
    agent.akimboWeaponEnt = undefined;
  }
  agent.primaryWeapon = undefined;
  agent.stored_weapon = undefined;
  free_avatar(agent);
  if(level.vl_focus == ownerid) {
    level.vl_focus = 0;
  }
}

reset_bot_settings_for_a_few_frames() {
  level notify("stop_reset_bot_settings");
  level endon("stop_reset_bot_settings");
  for(i = 0; i < 2; i++) {
    self maps\mp\agents\_agent_common::set_agent_health(100);
    self BotClearScriptEnemy();
    self BotClearScriptGoal();
    self bot_disable_tactical_goals();
    self BotSetFlag("disable_movement", 1);
    self BotSetFlag("disable_rotation", 1);
    wait 0.05;
  }
}
HackAgentAngles(angles) {
  self SetPlayerAngles(angles);
}

#using_animtree("multiplayer_vlobby");
use_animstate(animAlias, duringSetup, animstate) {
  RandomPlaybackRate = RandomFloatRange(0.85, 1.15);
  enablechanged = false;
  if(!isDefined(self.animAlias)) {
    self SetAnimClass("vlobby_animclass");
    enablechanged = true;
    level notify("stop_reset_bot_settings");
    self HackAgentAngles(self.spawn_angles);
  }

  if(!isDefined(animstate)) {
    animstate = "lobby_idle";
    animAlias = "assault_pose_06";
  }
  self.animAlias = animAlias;
  self.animstate = animstate;
  self SetAnimState(animstate, animAlias, RandomPlaybackRate);
  if(!isDefined(duringSetup) || !duringSetup) {
    self.animAlias = animAlias;
    if(enablechanged) {
      vl_give_weapons(self);
    }
  }
}

#using_animtree("multiplayer_vlobby");
start_anim() {
  if(isDefined(level.camParams) && isDefined(level.camParams.mode)) {
    switch (level.camParams.mode) {
      case "prelobby":
      case "prelobby_loot":
        animIdx = 0;

        if(isDefined(level.vlavatars)) {
          foreach(avatar in level.vlavatars) {
            if(!isDefined(avatar.animAlias)) {
              position_num = avatar.avatar_spawnpoint FindPositionNum();
              if(isDefined(self.ownerid) && self.ownerid == 0) {
                animIdx = 8;
              } else if(position_num < level.num_lobby_idles) {
                animIdx = position_num;
              } else {
                animIdx++;
                if(animIdx >= level.num_lobby_idles) {
                  animIdx = 0;
                }
              }
              animstate = "lobby_idle";
              self use_animstate(animIdx, undefined, animstate);
            }
          }
        }

        break;
      case "transition":
      case "game_lobby":
      case "cac":
      case "clanprofile":
        animIdx = 0;
        if(isDefined(level.vlavatars)) {
          foreach(avatar in level.vlavatars) {
            if(!isDefined(avatar.animAlias)) {
              position_num = avatar.avatar_spawnpoint FindPositionNum();
              if(isDefined(self.ownerid) && self.ownerid == 0) {
                animIdx = 8;
              } else if(position_num < level.num_lobby_idles) {
                animIdx = position_num;
              } else {
                animIdx++;
                if(animIdx >= level.num_lobby_idles) {
                  animIdx = 0;
                }
              }
              animstate = "lobby_idle";
              self use_animstate(animIdx, undefined, animstate);
            }
          }
        }
        break;
      case "cao":
        if(!isDefined(self.animAlias)) {
          if(isDefined(self.ownerid) && self.ownerid == 0) {
            animIdx = 8;
          } else {
            animIdx = RandomIntRange(0, level.num_lobby_idles - 1);
          }
          animstate = "lobby_idle";
          self use_animstate(animIdx, undefined, animstate);
        }
        break;
      default:
        if(!isDefined(self.animAlias)) {
          if(isDefined(self.ownerid) && self.ownerid == 0) {
            animIdx = 8;
          } else {
            animIdx = RandomIntRange(0, level.num_lobby_idles - 1);
          }

          animstate = "lobby_idle";
          self use_animstate(animIdx, undefined, animstate);
        }
        break;
    }
  }
}

start_prelobby_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }

  foreach(avatar in level.vlavatars) {
    if(!isDefined(avatar.animAlias) || !isDefined(avatar.animstate)) {
      animdata = avatar GetAnimData(avatar.primaryweapon);
      avatar use_animstate(animdata.alias, undefined, animdata.animstate);
    }
  }
}

start_lobby_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }

  foreach(avatar in level.vlavatars) {
    if(!isDefined(avatar.animAlias) || !isDefined(avatar.animstate)) {
      animdata = avatar GetAnimData(avatar.primaryweapon);
      avatar use_animstate(animdata.alias, undefined, animdata.animstate);
    }
  }
}

start_cao_anims() {
  if(!isDefined(level.vlavatars)) {
    return;
  }

  foreach(avatar in level.vlavatars) {
    if(!isDefined(avatar.animAlias) || !isDefined(avatar.animstate)) {
      animdata = avatar GetAnimData(avatar.primaryweapon);
      avatar use_animstate(animdata.alias, undefined, animdata.animstate);
    }
  }
}

/
find_best_cam_path(_start, _end, obstacles) {
  path = [];
  path[0] = _start;
  path[1] = _end;
  safetycount = 20;

  modified = true;
  while(modified && (safetycount > 0)) {
    safetycount--;
    modified = false;
    newpath = [];
    newpath[newpath.size] = path[0];
    bail = false;
    bailidx = 0;
    for(i = 0;
      (i < (path.size - 1)) && !bail; i++) {
      collision = true;
      start = path[i];
      end = path[i + 1];
      while(collision) {
        collision = false;
        best = undefined;
        best_trace = undefined;
        foreach(obstacle in obstacles) {
          trace = trace2d(start, end, obstacle);
          if(trace["intersect"]) {
            if((distance2D(newpath[newpath.size - 1], trace["closestpoint"]) > 0.1) &&
              (distance2D(end, trace["closestpoint"]) > 0.1)) {
              collision = true;
              if(!isDefined(best_trace) || (best_trace["radratio"] > trace["radratio"])) {
                best = obstacle;
                best_trace = trace;
              }
            }
          }
        }
        if(collision) {
          modified = true;

          if(length2D(start, best["center"]) < best["radius"]) {
            start = move_outside_circle(start, best);
            assert(i > 0);
            newpath[newpath.size - 1] = start;
            collision = false;
            bail = true;
            bailidx = i + 1;
          } else if(length2D(end, best["center"]) < best["radius"]) {
            end = move_outside_circle(end, best);
            assert((i + 1) < path.size);
            newpath[newpath.size] = end;
            collision = false;
            bail = true;
            bailidx = i + 2;
          } else {
            newpath[newpath.size] = best_trace["closestpoint"];
            newpath[newpath.size] = end;
            collision = false;
          }
        } else {
          newpath[newpath.size] = end;
        }
      }
    }
    if(bail) {
      for(i = bailidx; i < path.size; i++) {
        newpath[newpath.size] = path[i];
      }
    }
    path = newpath;
  }
  return path;
}

move_outside_circle(point, circle) {
  center = circle["center"];
  radius = circle["radius"];
  dir = VectorNormalize((point[0] - center[0], point[1] - center[1], 0));
  point = (center[0] + radius * dir[0], center[1] + radius * dir[1], point[2]);
  return point;
}

trace2d(start, end, circle) {
  pathbias = OBSTACLE_PATHBIAS;
  center = circle["center"];
  radius = circle["radius"];
  pathradius = radius + pathbias;
  vec2d = (end[0] - start[0], end[1] - start[1], 0);
  dir = VectorNormalize(vec2d);
  dist = Length2D(vec2d);
  s2c = (center[0] - start[0], center[1] - start[1], 0);
  off = VectorDot(dir, s2c);
  if(off < 0) {
    off = 0.0;
  } else if(off > dist) {
    off = dist;
  }
  closestpoint = (start[0] + off * dir[0], start[1] + off * dir[1], 0);
  fraction = off / dist;
  normal = (closestpoint[0] - center[0], closestpoint[1] - center[1], 0);
  dist = Length2D(normal);
  intersect = false;
  radratio = 1.0;
  if(dist < radius) {
    intersect = true;
    normal = VectorNormalize(normal);

    closestpoint = (center[0] + pathradius * normal[0], center[1] + pathradius * normal[1], start[2] + (fraction * (end[2] - start[2])));
    radratio = dist / radius;
  }
  retval = [];
  retval["intersect"] = intersect;
  retval["fraction"] = fraction;
  retval["closestpoint"] = closestpoint;
  retval["radratio"] = radratio;
  return retval;
}

calc_new_pos(prv_point, speed, goal) {
  dist = Distance(prv_point, goal);
  if(dist > speed) {
    dir = VectorNormalize(goal - prv_point);
    goal = prv_point + speed * dir;
  }
  return goal;
}

lookahead_path(prvIdx, prv_point, speed, lookahead, path) {
  start = path[prvIdx];
  if((prvIdx + 1) >= path.size) {
    return [prvIdx, calc_new_pos(prv_point, speed, path[prvIdx])];
  }
  end = path[prvIdx + 1];
  len = Distance(start, end);
  dir = VectorNormalize(end - start);
  dist_on_path = VectorDot(dir, prv_point - start);
  if(dist_on_path < 0) {
    dist_on_path = 0;
  }
  if(dist_on_path > len) {
    dist_on_path = len;
  }
  pnt_on_path = start + dist_on_path * dir;
  lookahead_left = lookahead;
  dist_in_seg = len - dist_on_path;
  lookahead_point = path[path.size - 1];
  while(lookahead_left > 0) {
    if(dist_in_seg > lookahead_left) {
      lookahead_point = pnt_on_path + lookahead_left * dir;
      lookahead_left = 0;
    } else {
      if((prvIdx + 1) >= path.size) {
        lookahead_point = path[prvIdx];
        lookahead_left = 0;
      }
      lookahead_left -= dist_in_seg;
      prvIdx++;
      pnt_on_path = path[prvIdx];
    }
  }
  return [prvIdx, calc_new_pos(prv_point, speed, lookahead_point)];
}

init_path_traversal(camera) {
  camera.distanceOnPath = 0;
  camera.pathIdx = 0;
  camera.distOnPathSegment = 0;
  camera.pathSpeed = 0;
  idealSpeed = camera.pathInfo_len / camera.PATH_IDEALTIME;
  if(idealSpeed < camera.PATH_MINSPEED) {
    idealSpeed = camera.PATH_MINSPEED;
  }
  if(idealSpeed > camera.PATH_MAXSPEED) {
    idealSpeed = camera.PATH_MAXSPEED;
  }
  camera.pathAccel = 0.05 * idealSpeed / camera.PATH_ACCEL_TIME;
  camera.pathDeccel = 0.05 * idealSpeed / camera.PATH_DECCEL_TIME;
  camera.pathTgtSpeed = idealSpeed;
  camera.pathAccelMode = 1;
  camera.pathInfo_t = 0;
  camera.pathInfo_totalt = camera.PATH_IDEALTIME;
  steps = (camera.PATH_DECCEL_TIME / 0.05);
  dist = 0;
  speed = idealSpeed;

  for(i = 0; i < steps; i++) {
    speed -= camera.pathDeccel;
    if(speed < camera.PATH_MINDECCELSPEED) {
      speed = camera.PATH_MINDECCELSPEED;
    }
    dist += speed;
  }
  camera.pathStartDeccelDist = camera.pathInfo_len - dist;
  camera.pitch = camera.pathInfo_startPitch;
}

update_path_speed(camera) {
  if(camera.distanceOnPath < camera.pathStartDeccelDist) {
    camera.pathSpeed += camera.pathAccel;
    if(camera.pathSpeed > camera.pathTgtSpeed) {
      camera.pathSpeed = camera.pathTgtSpeed;
    }
  } else {
    camera.pathSpeed -= camera.pathDeccel;
    if(camera.pathSpeed < camera.PATH_MINDECCELSPEED) {
      camera.pathSpeed = camera.PATH_MINDECCELSPEED;
    }
  }
}

init_path_constants(camera) {
  camera.PATH_MAXSPEED = 0.05 * 300;
  camera.PATH_MINSPEED = 0.05 * 36;
  camera.PATH_MINDECCELSPEED = 0.05 * 6;
  camera.PATH_IDEALTIME = 0.5;
  camera.PATH_ACCEL_TIME = 0.15 * camera.PATH_IDEALTIME;
  camera.PATH_DECCEL_TIME = 0.15 * camera.PATH_IDEALTIME;
  camera.pathMaxRotZ = 0.05 * 90;
  camera.pathMaxRotX = 0.05 * 90;
}

build_path_info(camera, camParams, start_loc, end_loc, endAngles) {
  path = find_best_cam_path(camera.origin, end_loc, camera.obstacles);
  camera.path = path;
  len = 0;
  foreach(idx, node in camera.path) {
    if(idx > 0) {
      len += Distance(camera.path[idx], camera.path[idx - 1]);
    }
  }
  camera.pathInfo_t = 0;
  camera.pathInfo_totalt = camera.PATH_IDEALTIME;
  camera.pathInfo_len = len;
  camera.pathInfo_startAim = anglesToForward(camera.angles);
  camera.pathInfo_endAim = anglesToForward(endAngles);

  camera.pathInfo_startPitch = AngleClamp180(camera.angles[0]);
  camera.pathInfo_curStartPitch = camera.pathInfo_startPitch;
  camera.pathInfo_endPitch = AngleClamp180(endAngles[0]);
  camera.pathInfo_startYaw = AngleClamp180(camera.angles[1]);
  camera.pathInfo_endYaw = AngleClamp180(endAngles[1]);
  camera.pathInfo_start_loc = start_loc;
  camera.pathInfo_end_loc = end_loc;
  camera.pathInfo_velocity = (0, 0, 0);
  baseTravelDir = VectorNormalize(camera.pathInfo_end_loc - camera.pathInfo_start_loc);
  startDP = VectorDot(baseTravelDir, camera.pathInfo_startAim);
  endDP = VectorDot(baseTravelDir, camera.pathInfo_endAim);
  path_mode = 0;
  if((endDP < -0.707) && (startDP < -0.707)) {
    path_mode = 1;
  }
  camera.pathInfo_mode = path_mode;
  init_path_traversal(camera);
}
FindNewTargetPos(CamAngles, CamOrigin, OldTargetOrigin) {
  Vec3CamDir = anglesToForward(CamAngles);
  Cam2Tgt = OldTargetOrigin - CamOrigin;
  Dist2Tgt = VectorDot(Cam2Tgt, Vec3CamDir);
  NewTargetPosition = CamOrigin + (Vec3CamDir * Dist2Tgt);

  return NewTargetPosition;
}

sigmoid(x, maxx) {
  xoffset = -0.5;
  x += xoffset;
  x *= 2 * maxx;
  scale = sqrt(1 + maxx * maxx) / (2 * maxx);
  offset = 0.5;
  value = scale * (x / sqrt(1 + x * x)) + offset;
  assert(value >= 0 && value <= 1);
  return value;
}

lerp_towards_desiredAngle(camera, desiredAngles) {
  desiredX = AngleClamp180(desiredAngles[0]);
  currentX = AngleClamp180(camera.angles[0]);

  dZ = AngleClamp180(desiredAngles[1] - camera.angles[1]);
  dX = AngleClamp180(desiredX - currentX);
  if(dZ < -1 * camera.pathMaxRotZ) {
    dZ = -1 * camera.pathMaxRotZ;
  }
  if(dZ > camera.pathMaxRotZ) {
    dZ = camera.pathMaxRotZ;
  }
  if(dX < -1 * camera.pathMaxRotX) {
    dX = -1 * camera.pathMaxRotX;
  }
  if(dX > camera.pathMaxRotX) {
    dX = camera.pathMaxRotX;
  }
  deltaAngles = (dX, dZ, 0);
  camera.angles = camera.angles + deltaAngles;
  if((abs(dX) < 0.1) && (abs(dZ) < 0.1)) {
    return true;
  } else {
    return false;
  }
}

update_camera_angles_on_path(camera, camParams) {
  fraction = camera.pathInfo_t / camera.pathInfo_totalt;
  fraction = sigmoid(fraction, 2);

  desiredAngles = camera.angles;

  lerpedPitch = fraction * (camera.pathInfo_endPitch - camera.pathInfo_startPitch) + camera.pathInfo_startPitch;

  startYaw = camera.pathInfo_startYaw + fraction * (camera.pathInfo_endYaw - camera.pathInfo_startYaw);
  desiredYaw = camera.angles[1] + AngleClamp180(startYaw - camera.angles[1]);
  desiredAngles = (lerpedPitch, desiredYaw, desiredAngles[2]);

  return lerp_towards_desiredAngle(camera, desiredAngles);
}

update_camera_position_on_path(camera) {
  fraction = camera.pathInfo_t / camera.pathInfo_totalt;
  fraction = sigmoid(fraction, 2);
  distToTravel = fraction * camera.pathInfo_len;
  camera.pathIdx = 0;
  camera.distOnPathSegment = 0;
  camera.distanceOnPath = 0;
  while(distToTravel > 0) {
    curSegLen = Distance(camera.path[camera.pathIdx], camera.path[camera.pathIdx + 1]);
    remainingLen = curSegLen - camera.distOnPathSegment;
    if(remainingLen > distToTravel) {
      camera.distOnPathSegment += distToTravel;
      neworigin = camera.path[camera.pathIdx] + camera.distOnPathSegment * VectorNormalize(camera.path[camera.pathIdx + 1] - camera.path[camera.pathIdx]);
      camera.pathInfo_velocity = neworigin - camera.origin;
      camera.origin = neworigin;
      camera.distanceOnPath += distToTravel;
      distToTravel = 0;
    } else {
      distToTravel -= remainingLen;
      camera.pathIdx++;
      if(camera.pathIdx >= (camera.path.size - 1)) {
        if(camera.pathIdx < camera.path.size) {
          neworigin = camera.path[camera.pathIdx];
        } else {
          neworigin = camera.path[camera.path.size - 1];
        }
        camera.pathInfo_velocity = neworigin - camera.origin;
        camera.origin = neworigin;
        camera.distanceOnPath = camera.pathInfo_len;
        distToTravel = 0;
      } else {
        camera.distanceOnPath += remainingLen;
        camera.distOnPathSegment = 0;
      }
    }
  }
}

update_camera_on_path(camera, camParams) {
  finished = false;
  camera.pathInfo_t += 0.05;
  if(camera.pathInfo_t >= camera.pathInfo_totalt) {
    camera.pathInfo_t = camera.pathInfo_totalt;
    finished = true;
    camera.pathInfo_velocity = (0, 0, 0);
  }

  update_camera_position_on_path(camera);
  update_camera_angles_on_path(camera, camParams);
  return finished;
}

get_target_from_avatar(avatar) {
  tag = "j_neck";
  target = avatar GetTagOrigin(tag);
  return target;
}

calc_f_from_avatar(avatar) {
  CameraData = RotateAvatarTagCamera(avatar);
  tag_camera_loc_vec3 = CameraData.camera_tag_origin;
  tag_camera_angles_vec3 = CameraData.camera_tag_angles;

  target = get_target_from_avatar(avatar);
  cam_origin = tag_camera_loc_vec3;
  cam_lookat = tag_camera_loc_vec3 + (anglesToForward(tag_camera_angles_vec3) * 64);

  return calc_f(cam_origin, cam_lookat, target);
}

calc_f_from_avatar_spawnpoint(avatar_spawnpoint) {
  target = avatar_spawnpoint.origin;
  cam_origin = avatar_spawnpoint.camera_helper.origin;
  cam_lookat = avatar_spawnpoint.camera_lookat.origin;
  return calc_f(cam_origin, cam_lookat, target);
}

calc_f(cam_origin, cam_lookat, target) {
  P = cam_lookat;
  C = cam_origin;
  T = target;
  result = [];
  X = VectorNormalize(VectorCross(P - C, (0, 0, 1)));
  Z = VectorNormalize(VectorCross(X, P - C));
  CT = T - C;
  Tx = T - (VectorDot(Z, CT) * Z);
  Tz = T - (VectorDot(X, CT) * X);
  Dx = Distance(Tx, P);
  Hx = Distance(Tx, C);
  fx = Dx / Hx;
  sx = 1;
  if(VectorDot(CT, X) < 0) {
    sx = -1;
  }
  result["fx"] = fx;
  result["sx"] = sx;
  Dz = Distance(Tz, P);
  Hz = Distance(Tz, C);
  fz = Dz / Hz;
  sz = 1;
  if(VectorDot(CT, Z) < 0) {
    sz = -1;
  }
  result["fz"] = fz;
  result["sz"] = sz;
  return result;
}

calc_f_fromscreen(ex, ez) {
  FOV = GetDvarFloat("cg_fov", 45) * GetDvarFloat("cg_fovScale", 1.0);
  aspectz = 1.0;
  dfov = tan(FOV);
  result = [];

  dx = dfov * abs(ex);
  sx = 1;
  if(ex < 0) {
    sx = -1;
  }
  fx = dx / sqrt(1 - dx * dx);
  result["sx"] = sx;
  result["fx"] = fx;

  dz = aspectz * dfov * abs(ez);
  sz = 1;
  if(ez < 0) {
    sz = -1;
  }
  fz = dz / sqrt(1 - dz * dz);
  result["sz"] = sz;
  result["fz"] = fz;

  return result;
}

calc_cam_lookat(fparams, cam_origin, target) {
  C = cam_origin;
  T = target;
  CT = T - C;
  X = VectorNormalize(VectorCross(CT, (0, 0, 1)));
  Z = VectorNormalize(VectorCross(X, CT));

  CTx = CT - (VectorDot(CT, Z) * Z);
  Hx = Length(CTx);
  fx = fparams["fx"];
  sx = fparams["sx"];
  Dx = Hx * fx;
  hx = Hx * fx * fx;
  lx = Hx * fx * sqrt(1 - (fx * fx));
  TPx = hx * CTx + lx * X;

  CTz = CT - (VectorDot(CT, X) * X);
  Hz = Length(CTz);
  fz = fparams["fz"];
  sz = fparams["sz"];
  Dz = Hz * fz;
  hz = Hz * fz * fz;
  lz = Hz * fz * sqrt(1 - (fz * fz));
  TPz = hz * CTz + lz * Z;

  P = T + sx * TPx + sz * TPz;
  return P;
}

debug_draw_path(path) {
  color = (1, 1, 1);
  prvpoint = path[0];
  newpoint = prvpoint;
  prvIdx = 0;
  speed = 10;
  lookahead = 30;
  if(level.use_lookahead) {
    while(true) {
      newrecord = lookahead_path(prvIdx, prvpoint, speed, lookahead, path);
      prvIdx = newrecord[0];
      newpoint = newrecord[1];
      if(distance(prvpoint, newpoint) < 0.1) {
        break;
      }
      line(prvpoint, newpoint, color, 1, true, 1);
      prvpoint = newpoint;
      if(prvIdx >= path.size) {
        break;
      }
    }
  } else {
    for(i = 0; i < (path.size - 1); i++) {
      line(path[i], path[i + 1], color, 1, true, 1);
    }
  }
}

debug_draw_obstacles(obstacles) {
  color = (1, 0.5, 0);
  foreach(obstacle in obstacles) {
    center = obstacle["center"];
    radius = obstacle["radius"];
    Cylinder(center, center + (0, 0, 100), radius, color, true, 1);
  }
}

debug_draw_aim(camera) {
  cntsBtnDraws = 1;
  cnt = cntsBtnDraws;
  aimLen = 36;
  init_path_traversal(camera);
  camera.target_from_avatar = get_target_from_avatar(camera.targetAvatar);
  while(!update_camera_on_path(camera)) {
    target = camera.target_from_avatar;
    cam_target = calc_cam_lookat(camera.fparams, camera.origin, target);
    cnt--;
    if(cnt <= 0) {
      cnt = cntsBtnDraws;
      line(camera.origin, camera.origin + aimLen * anglesToForward(camera.angles), (1, 0, 0), 1, true, 1);
      line(camera.origin, cam_target, (1, 0.5, 0.5), 1, true, 1);
    }
  }

  camera.angles = (AngleClamp180(camera.angles[0]), AngleClamp180(camera.angles[1]), AngleClamp180(camera.angles[2]));
  camera DontInterpolate();
}

test_pathing(camera, startEnt, endEnt, obstacles) {
  level notify("stop_test_pathing");
  level endon("stop_test_pathing");
  player_points = getEntArray("player_pos", "targetname");
  avatar = endEnt.spawned_avatar;

  CameraData = RotateAvatarTagCamera(avatar);
  tag_camera_loc_vec3 = CameraData.camera_tag_origin;
  tag_camera_angles_vec3 = CameraData.camera_tag_angles;

  end = tag_camera_loc_vec3;
  angles = tag_camera_angles_vec3;
  start = camera.origin;

  StartLookAtLoc = start + (anglesToForward(camera.angles) * 64);
  EndLookAtLoc = end + (anglesToForward(angles) * 64);

  camera.origin = start;
  camera.angles = angles;
  camera.obstacles = obstacles;
  init_path_constants(camera);

  build_path_info(camera, undefined, camera.origin, end, angles);
  camera.fparams = calc_f_from_avatar(avatar);
  camera.targetAvatar = avatar;
  while(true) {
    camera.origin = start;
    camera.angles = angles;
    line(start - (5, 0, 0), start + (5, 0, 0), (1, 0, 1));
    line(start - (0, 5, 0), start + (0, 5, 0), (1, 0, 1));
    line(start - (0, 0, 5), start + (0, 0, 5), (1, 0, 1));
    line(end - (5, 0, 0), end + (5, 0, 0), (1, 1, 0));
    line(end - (0, 5, 0), end + (0, 5, 0), (1, 1, 0));
    line(end - (0, 0, 5), end + (0, 0, 5), (1, 1, 0));
    line(start, StartLookAtLoc, (0, 1, 1));
    line(end, EndLookAtLoc, (0, 1, 1));
    debug_draw_path(camera.path);
    debug_draw_obstacles(camera.obstacles);
    debug_draw_aim(camera);
    wait 0.05;
  }
}

debug_pathing() {
  trigger = false;
  player_points = getEntArray("player_pos", "targetname");
  foreach(AvatarSpawn in player_points) {
    CameraTarget = GetEnt(AvatarSpawn.target, "targetname");
    if(CameraTarget.script_noteworthy == "camera_target") {
      AvatarSpawn.camera_lookat = CameraTarget;
    }
    CameraEnt = GetEnt(CameraTarget.target, "targetname");
    if(CameraEnt.script_noteworthy == "camera") {
      AvatarSpawn.camera_helper = CameraEnt;
      CameraEnt.camera_goal = AvatarSpawn;

      CameraEnt.camera_lookat = AvatarSpawn.camera_lookat;
    }
  }
  fakecamera = spawn("script_model", (0, 0, 0));
  fakecamera setModel("tag_player");

  level.use_lookahead = false;
  startIdx = 0;
  endIdx = 1;
  obstaclemask = "111111111111111111";
  radius = OBSTACLE_RADIUS;
  while(true) {
    if(self FragButtonPressed()) {
      while(self FragButtonPressed()) {
        wait 0.05;
      }
      endIdx++;
      if(endIdx >= 12) {
        endIdx = 0;
      }
      if(endIdx == startIdx) {
        endIdx++;
        if(endIdx >= 12) {
          endIdx = 0;
        }
      }
      trigger = true;
    }
    if(self SecondaryOffhandButtonPressed()) {
      while(self SecondaryOffhandButtonPressed()) {
        wait 0.05;
      }
      startIdx++;
      if(startIdx >= 12) {
        startIdx = 0;
      }
      if(endIdx == startIdx) {
        startIdx++;
        if(startIdx >= 12) {
          startIdx = 0;
        }
      }
      trigger = true;
    }
    if(trigger) {
      trigger = false;

      obstacles = [];
      start_point = undefined;
      end_point = undefined;
      foreach(idx, player_point in player_points) {
        if((GetSubStr(obstaclemask, idx, idx + 1) == "0")) {
          continue;
        }
        obstacle = [];
        obstacle["center"] = player_point.origin;
        obstacle["radius"] = radius;
        obstacles[obstacles.size] = obstacle;
        if(player_point.script_noteworthy == "" + startIdx) {
          start_point = player_point;
        }
        if(player_point.script_noteworthy == "" + endIdx) {
          end_point = player_point;
        }
      }
      thread test_pathing(fakecamera, start_point, end_point, obstacles);
    }
    wait 0.2;
  }
}

debug_fly(camera) {
  level.debug_fly = true;
  speed = 30;
  latspeed = 10;
  upspeed = 10;
  angles = self GetUnNormalizedCameraMovement();
  delta = self GetNormalizedMovement();
  forward = anglesToForward(angles);
  up = AnglesToUp(angles);
  right = AnglesToRight(angles);
  deltaUp = 0;
  if(self AdsButtonPressed()) {
    deltaUp = -1;
  } else if(self AttackButtonPressed()) {
    deltaUp = 1;
  }
  if(self SecondaryOffhandButtonPressed()) {
    speed = speed * 0.1;
    latspeed = latspeed * 0.1;
    upspeed = upspeed * 0.1;
  }

  camera.angles = angles;
  camera.origin = camera.origin + delta[0] * speed * forward + delta[1] * latspeed * right + deltaUp * upspeed * up;
}

vlobby_vegnette(opacity, material) {
  if(!isDefined(self.vegnette)) {
    self.vegnette = newClientHudElem(self);
    self.vegnette.x = 0;
    self.vegnette.y = 0;
    self.vegnette setshader(material, 640, 480);
    self.vegnette.alignX = "left";
    self.vegnette.alignY = "top";
    self.vegnette.horzAlign = "fullscreen";
    self.vegnette.vertAlign = "fullscreen";
    self.vegnette.alpha = opacity;
  }

  if(isDefined(self.vegnette) && self.vegnette.alpha > 0 && opacity == 0) {
    self.vegnette setshader(material, 640, 480);
    self.vegnette.alpha = 0;
  }

  if(isDefined(self.vegnette) && self.vegnette.alpha < 1 && opacity == 1) {
    self.vegnette setshader(material, 640, 480);
    self.vegnette.alpha = 1;
  }
}