/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_orbital.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;

precacheOrbital()

{
  PreCacheModel("tag_player");
  PreCacheModel("vehicle_ac130_coop");
  PreCacheModel("vehicle_drop_pod_base");
  PreCacheModel("vehicle_drop_pod_base_enemy");

  PreCacheMpAnim("mp_orbital_pod_base_unfold");

  game["dialog"]["orbital_pod_destroyed"] = "orbital_pod_destroyed";
  game["dialog"]["orbital_pod_destroyed_enemy"] = "orbital_pod_destroyed_enemy";
  game["dialog"]["orbital_dropin"] = "orbital_dropin";
  game["dialog"]["orbital_notgood_tryhard"] = "orbital_notgood_tryhard";

  level.drop_pod_effect["pod_base_destroyed"] = LoadFX("vfx/explosion/orbital_pod_base_explosion");
  level.drop_pod_effect["dome_impact_flash"] = LoadFX("vfx/unique/orbital_dome_impact_flash");
  level.drop_pod_effect["dome_shutdown_friendly"] = LoadFX("vfx/unique/orbital_dome_shutdown_friendly");
  level.drop_pod_effect["dome_shutdown_enemy"] = LoadFX("vfx/unique/orbital_dome_shutdown_enemy");
  level.drop_pod_effect["player_spawn_from_pod"] = LoadFX("vfx/ui/drop_pod_spawn_point_active");
  level.drop_pod_effect["drop_pod_fire_flash"] = LoadFX("vfx/unique/orbital_drop_pod_fire_flash");
  level.drop_pod_effect["decel_explosion"] = LoadFX("vfx/explosion/orbital_pod_decel_explosion");
  level.drop_pod_effect["dome_impact"] = LoadFX("vfx/explosion/orbital_pod_impact_dome");
  level.drop_pod_effect["landing_impact"] = LoadFX("vfx/smoke/drop_pod_landing_impact");
  level.drop_pod_effect["drop_pod_explode"] = LoadFX("vfx/explosion/orbital_drop_pod_explode");
  level.drop_pod_effect["drop_pod_spike_impact"] = LoadFX("vfx/weaponimpact/drop_pod_spike_impact");

  current_level = getDvar("mapname");
  switch (current_level) {
    case "mp_refraction":
      level.drop_pod_dome["friendly"] = LoadFX("vfx/unique/orbital_dome_friendly_ref");
      level.drop_pod_dome["enemy"] = LoadFX("vfx/unique/orbital_dome_enemy_ref");
      level.drop_pod_dome_ground["friendly"] = LoadFX("vfx/unique/orbital_dome_ground_friendly_ref");
      level.drop_pod_dome_ground["enemy"] = LoadFX("vfx/unique/orbital_dome_ground_enemy_ref");
      break;

    default:
      level.drop_pod_dome["friendly"] = LoadFX("vfx/unique/orbital_dome_friendly");
      level.drop_pod_dome["enemy"] = LoadFX("vfx/unique/orbital_dome_enemy");
      level.drop_pod_dome_ground["friendly"] = LoadFX("vfx/unique/orbital_dome_ground_friendly");
      level.drop_pod_dome_ground["enemy"] = LoadFX("vfx/unique/orbital_dome_ground_enemy");
      break;
  }
}

initializeOribtalMode()

{
  precacheOrbital();

  level.drop_pod = spawnStruct();
  level.drop_pod.model = "vehicle_drop_pod_base";
  level.drop_pod.enemy_model = "vehicle_drop_pod_base_enemy";
  level.drop_pod.deploy_delay = 2;
  level.drop_pod_volume_array = getEntArray("drop_pod_volume", "targetname");
  level.drop_pod_bad_spawn_overlay = getEntArray("orbital_bad_spawn_overlay", "targetname");
  level.orbital_ships = spawnStruct();

  level.forcerespawn_time = 15;

  current_level = getDvar("mapname");

  switch (current_level) {
    case "mp_refraction":

      setDvar("missileRemoteSteerPitchRange", "37 88");

      level.left_loop_start = getent("orbital_plane_left_loop_start", "targetname");
      level.left_big_loop_start = getent("orbital_plane_left_big_loop_start", "targetname");
      level.right_loop_start = getent("orbital_plane_right_loop_start", "targetname");
      level.right_big_loop_start = getent("orbital_plane_right_big_loop_start", "targetname");

      level.left_pivot = getent("orbital_left_loop_pivot", "targetname");
      level.left_big_pivot = getent("orbital_left_big_loop_pivot", "targetname");
      level.right_pivot = getent("orbital_right_loop_pivot", "targetname");
      level.right_big_pivot = getent("orbital_right_big_loop_pivot", "targetname");

      level.orbital_ships.missileSpawn["target"] = getent("orbitalMissileTarget", "targetname");

      level.orbital_ships.cameraView["allies"] = spawn("script_model", level.left_loop_start.origin);
      level.orbital_ships.cameraView["allies"] setModel("tag_player");
      level.orbital_ships.cameraView["allies"].angles += (0, 220, 0);
      level.orbital_ships.cameraView["allies"].team = "allies";
      level.orbital_ships.cameraView["allies"] LinkToSynchronizedParent(level.left_pivot);
      level.orbital_ships.cameraView["allies"].track = "left";
      level.orbital_ships.cameraView["allies"] hide();

      level.orbital_ships.cameraView["axis"] = spawn("script_model", level.left_big_loop_start.origin);
      level.orbital_ships.cameraView["axis"] setModel("tag_player");
      level.orbital_ships.cameraView["axis"].angles += (0, 330, 0);
      level.orbital_ships.cameraView["axis"].team = "axis";
      level.orbital_ships.cameraView["axis"] LinkToSynchronizedParent(level.left_big_pivot);
      level.orbital_ships.cameraView["axis"].track = "left_big";
      level.orbital_ships.cameraView["axis"] hide();

      level.orbital_ships.ship["allies"] = spawn("script_model", level.left_loop_start.origin);
      level.orbital_ships.ship["allies"] setModel("vehicle_ac130_coop");
      level.orbital_ships.ship["allies"].angles += (0, 220, 0);
      level.orbital_ships.ship["allies"] LinkToSynchronizedParent(level.orbital_ships.cameraView["allies"], "", (0, 0, 80), (0, 0, 0));

      level.orbital_ships.ship["axis"] = spawn("script_model", level.left_big_loop_start.origin);
      level.orbital_ships.ship["axis"] setModel("vehicle_ac130_coop");
      level.orbital_ships.ship["axis"].angles += (0, 330, 0);
      level.orbital_ships.ship["axis"] LinkToSynchronizedParent(level.orbital_ships.cameraView["axis"], "", (0, 0, 80), (0, 0, 0));

      thread rotateOrbitalShipPivots();

      level.orbital_ships.cameraView["allies"] thread monitorTrackSwitching();
      level.orbital_ships.cameraView["axis"] thread monitorTrackSwitching();

      break;

    default:

      setDvar("missileRemoteSteerPitchRange", "47 88");

      height_ent = getent("airstrikeheight", "targetname");
      minimap_origins = getEntArray("minimap_corner", "targetname");

      if(minimap_origins.size == 2) {
        level.orbital_ships.center = maps\mp\gametypes\_spawnlogic::findBoxCenter(minimap_origins[0].origin, minimap_origins[1].origin);
      } else {
        AssertMsg("unexpected number of minimap_corner ents found. " + minimap_origins.size);
      }

      level.orbital_ships.dist_from_center = 3500;
      level.orbital_ships.extra_height = 2000;
      level.orbital_ships.center *= (1, 1, 0);
      level.orbital_ships.center += (0, 0, height_ent.origin[2] + level.orbital_ships.extra_height);

      map_center = level.orbital_ships.center;
      angles_ally = (0, 0, 0);
      angles_axis = (0, 180, 0);

      start_point_ally = map_center + (anglesToForward(angles_ally) * (level.orbital_ships.dist_from_center));
      start_point_axis = map_center + (anglesToForward(angles_axis) * (level.orbital_ships.dist_from_center));

      level.orbital_ships.script_origin = spawn("script_origin", level.orbital_ships.center);

      level.orbital_ships.cameraView["allies"] = spawn("script_model", start_point_ally);
      level.orbital_ships.cameraView["allies"] setModel("tag_player");
      level.orbital_ships.cameraView["allies"].angles += (0, 180, 0);
      level.orbital_ships.cameraView["allies"] LinkToSynchronizedParent(level.orbital_ships.script_origin);
      level.orbital_ships.cameraView["allies"] hide();

      level.orbital_ships.cameraView["axis"] = spawn("script_model", start_point_axis);
      level.orbital_ships.cameraView["axis"] setModel("tag_player");
      level.orbital_ships.cameraView["axis"].angles += (0, 0, 0);
      level.orbital_ships.cameraView["axis"] LinkToSynchronizedParent(level.orbital_ships.script_origin);
      level.orbital_ships.cameraView["axis"] hide();

      level.orbital_ships.missileSpawn["target"] = spawn("script_origin", (level.orbital_ships.center - (0, 0, 7000)));
      level.orbital_ships.missileSpawn["target"].targetname = "orbitalMissileTarget";

      level.orbital_ships.ship["allies"] = spawn("script_model", start_point_ally);
      level.orbital_ships.ship["allies"] setModel("vehicle_ac130_coop");
      level.orbital_ships.ship["allies"].angles += (0, 180, 0);
      level.orbital_ships.ship["allies"] LinkToSynchronizedParent(level.orbital_ships.cameraView["allies"], "", (0, 0, 100), (15, 0, 0));

      level.orbital_ships.ship["axis"] = spawn("script_model", start_point_axis);
      level.orbital_ships.ship["axis"] setModel("vehicle_ac130_coop");
      level.orbital_ships.ship["axis"].angles += (0, 0, 0);
      level.orbital_ships.ship["axis"] LinkToSynchronizedParent(level.orbital_ships.cameraView["axis"], "", (0, 0, 100), (15, 0, 0));

      level.orbital_ships.script_origin thread rotateOrbitalShips();

      break;
  }

  thread showDropPodBadSpawnOverlay();
  thread spawnPlayerInOrbital();
}

monitorTrackSwitching()

{
  level endon("game_ended");

  self.started_bank = false;
  level.ship_pos_wait_delay = 0.5;
  switch_threshold = 4;

  wait 2;

  while(true) {
    dist_to_next_track = "none";
    plane_track = self.track;

    switch (plane_track) {
      case "right":
        dist_to_next_track = Distance(self.origin, level.left_big_loop_start.origin);

        if(dist_to_next_track <= 200 && self.started_bank == false) {
          level.ship_pos_wait_delay = 0.05;
        }

        if(dist_to_next_track <= switch_threshold) {
          self unlink();
          self.origin = level.left_big_loop_start.origin;
          self LinkToSynchronizedParent(level.left_big_pivot);
          self.track = "left_big";
          level.ship_pos_wait_delay = 0.5;
        }
        break;

      case "left_big":
        dist_to_next_track = Distance(self.origin, level.left_loop_start.origin);

        if(dist_to_next_track <= 200 && self.started_bank == false) {
          level.ship_pos_wait_delay = 0.05;
        }

        if(dist_to_next_track <= switch_threshold) {
          self unlink();
          self.origin = level.left_loop_start.origin;
          self LinkToSynchronizedParent(level.left_pivot);
          self.track = "left";
          level.ship_pos_wait_delay = 0.5;
        }
        break;

      case "left":
        dist_to_next_track = Distance(self.origin, level.right_big_loop_start.origin);

        if(dist_to_next_track <= 200 && self.started_bank == false) {
          level.ship_pos_wait_delay = 0.05;
        }

        if(dist_to_next_track <= switch_threshold) {
          self unlink();
          self.origin = level.right_big_loop_start.origin;
          self LinkToSynchronizedParent(level.right_big_pivot);
          self.track = "right_big";
          level.ship_pos_wait_delay = 0.5;
        }
        break;

      case "right_big":
        dist_to_next_track = Distance(self.origin, level.right_loop_start.origin);

        if(dist_to_next_track <= 200 && self.started_bank == false) {
          level.ship_pos_wait_delay = 0.05;
        }

        if(dist_to_next_track <= switch_threshold) {
          self unlink();
          self.origin = level.right_loop_start.origin;
          self LinkToSynchronizedParent(level.right_pivot);
          self.track = "right";
          level.ship_pos_wait_delay = 0.5;
        }
        break;

      default:
        break;
    }

    level.distance = dist_to_next_track;

    wait level.ship_pos_wait_delay;
  }
}

rotateOrbitalShips()

{
  level endon("game_ended");

  while(true) {
    self RotateYaw(3600, 1200);
    wait 1199;
  }
}

rotateOrbitalShipPivots()

{
  level endon("game_ended");

  while(true) {
    level.left_pivot RotateYaw(-5400, 1200);
    level.left_big_pivot RotateYaw(-700, 1200);
    level.right_pivot RotateYaw(5400, 1200);
    level.right_big_pivot RotateYaw(700, 1200);

    wait 1199;
  }
}

spawnPlayerInOrbital()

{
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    player SetClientOmnvar("ui_orbital_toggle_hud", 1);
    player SetClientOmnvar("ui_orbital_is_dropping", true);

    if(!isbot(player)) {
      player DisableWeapons();
      player PlayerHide();
      player HideViewModel();
      player thread setFovScale(1, 0);

      player.isdropping = true;

      player thread showDropPodFX();

      player thread playerInOrbital();
      player thread waitForSpawnFinished();
    }
  }
}

showDropPodFX()

{
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");

  while(true) {
    hidePodFx();

    foreach(player in level.players) {
      if(isDefined(player.isdropping)) {
        if(player.isdropping == true) {
          player showPodDroppingFXToPlayer();
        } else {
          player showPodGroundFXToPlayer();
        }
      }
    }

    wait(0.05);
  }
}

hidePodFx()

{
  foreach(player in level.players) {
    if(isDefined(player.drop_pod)) {
      if(isDefined(player.drop_pod.trophyFX_friendly)) {
        player.drop_pod.trophyFX_friendly hide();
      }

      if(isDefined(player.drop_pod.trophyFX_enemy)) {
        player.drop_pod.trophyFX_enemy hide();
      }

      if(isDefined(player.drop_pod.trophyFX_ground_friendly)) {
        player.drop_pod.trophyFX_ground_friendly hide();
      }

      if(isDefined(player.drop_pod.trophyFX_ground_enemy)) {
        player.drop_pod.trophyFX_ground_enemy hide();
      }
    }
  }
}

showPodDroppingFXToPlayer()

{
  foreach(player in level.players) {
    if(isDefined(player.drop_pod)) {
      if(player.team == self.team) {
        if(isDefined(player.drop_pod.trophyFX_friendly))
      }
      player.drop_pod.trophyFX_friendly ShowToPlayer(self);

      if(!(player.team == self.team)) {
        if(isDefined(player.drop_pod.trophyFX_enemy))
      }
      player.drop_pod.trophyFX_enemy ShowToPlayer(self);
    }
  }
}

showPodGroundFXToPlayer()

{
  foreach(player in level.players) {
    if(isDefined(player.drop_pod)) {
      if(player.team == self.team) {
        if(isDefined(player.drop_pod.trophyFX_ground_friendly))
      }
      player.drop_pod.trophyFX_ground_friendly ShowToPlayer(self);

      if(!(player.team == self.team)) {
        if(isDefined(player.drop_pod.trophyFX_ground_enemy))
      }
      player.drop_pod.trophyFX_ground_enemy ShowToPlayer(self);
    }
  }
}

waitForSpawnFinished()

{
  level endon("game_ended");
  self endon("disconnect");

  self waittill_any("player_drop_pod_spawned", "player_spawned_at_drop_pod");

  self.isdropping = false;
  self thread setOrbitalView("off", 0);

  thread hideOverlays();
  self thread destroyPlayerIcons();
}

playerInOrbital()

{
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(!IsBot(self)) {
    if(!isDefined(self.prematch_over)) {
      self.prematch_over = false;
    }
    if(!isDefined(self.respawn_mode)) {
      self.respawn_mode = 0;
    }
    if(!isDefined(self.mode_button_released)) {
      self.mode_button_released = 0;
    }

    self.spawn_button_released = 0;
    self.is_linked_to_pod = false;
    self.is_linked_to_ship = false;

    if(self.prematch_over == false) {
      self DisableWeapons();
      self HideViewModel();

      if(!self IsLinked()) {
        self linkPlayerOrbitalShip();
      }
    }

    gameFlagWait("prematch_done");

    self.prematch_over = true;

    self DisableWeapons();
    self HideViewModel();

    self.forcerespawn_timer = level.forcerespawn_time;
    timer_time = (level.forcerespawn_time * 1000.0) + GetTime();

    self SetClientOmnvar("ui_orbital_toggle_color", 0);
    self SetClientOmnvar("ui_orbital_timer_time", timer_time);

    self thread dropPodForceRespawn();
    self.forcerespawn = false;

    if(isDefined(self.drop_pod) && self.drop_pod.destroyed == false) {
      self.respawn_mode = 1;
    }

    while(1) {
      if(isDefined(self.drop_pod) && self.drop_pod.destroyed == false && self.respawn_mode == 1) {
        if(self.is_linked_to_pod == false) {
          if(self IsLinked()) {
            self Unlink();
          }
          self linkPlayerPod();
        }
      }

      if(!isDefined(self.drop_pod) || self.drop_pod.destroyed == true || self.respawn_mode == 0) {
        if(self.is_linked_to_ship == false) {
          if(self IsLinked()) {
            self Unlink();
          }
          self linkPlayerOrbitalShip();
        }
      }

      if(!self AdsButtonPressed()) {
        self.mode_button_released = 1;
      }

      if(!self AttackButtonPressed()) {
        self.spawn_button_released = 1;
      }

      if(self AdsButtonPressed() && self.mode_button_released == 1) {
        self.mode_button_released = 0;

        if(self.respawn_mode == 0 && isDefined(self.drop_pod) && self.drop_pod.destroyed == false) {
          self.respawn_mode = 1;
          if(self.is_linked_to_pod == false) {
            if(self IsLinked()) {
              self Unlink();
            }
            self linkPlayerPod();
          }
        } else if(self.respawn_mode == 1) {
          self.respawn_mode = 0;
          if(self.is_linked_to_ship == false) {
            if(self IsLinked()) {
              self Unlink();
            }
            self linkPlayerOrbitalShip();
          }
        }
      } else if((self AttackButtonPressed() && self.spawn_button_released == 1) || self.forcerespawn) {
        self.spawn_button_released = 0;

        if(isDefined(self.drop_pod) && self.drop_pod.destroyed == false && self.respawn_mode == 1 && self.is_linked_to_pod == true) {
          if(isDefined(self.drop_pod)) {
            if(isDefined(self.drop_pod.spawn_fx)) {
              self.drop_pod.spawn_fx delete();
            }
          }

          player_viewangles = self GetPlayerAngles();

          self Unlink();

          self notify("player_spawned_at_drop_pod");
          self thread setOrbitalView("off", 0);

          self SetPlayerAngles(player_viewangles);
          self SetOrigin(self.drop_pod.origin);
          self EnableWeapons();
          self playerShow();
          self ShowViewModel();

          return;
        } else if(self.respawn_mode == 0 && self.is_linked_to_ship == true) {
          nearest_node = _fire(self.lifeId, self);

          return;
        }
      }
      wait(0.05);
    }
  } else {
    self linkPlayerOrbitalShip();

    nearest_node = _fire(self.lifeId, self);

    if(isDefined(nearest_node)) {
      self setOrigin(nearest_node.origin);

      self createPlayerDropPod(nearest_node.origin);

      self.drop_pod thread drop_pod_handleDeath();

      wait 0.05;
    }
  }
}

linkPlayerPod()

{
  self.is_linked_to_pod = true;
  self.is_linked_to_ship = false;
  self.isdropping = false;

  self destroyPlayerIcons();
  self showPlayerIcons("friendly");

  self notify("switched_to_pod_view");

  self thread setOrbitalView("pod", 0);

  self DontInterpolate();
  self PlayerLinkTo(self.drop_pod.camera, "tag_player", 0);

  self.drop_pod.spawn_fx = SpawnFx(level.drop_pod_effect["player_spawn_from_pod"], self.drop_pod.origin, self.drop_pod.forward);
  TriggerFX(self.drop_pod.spawn_fx);

  self thread centerPodSpawnView();
}

linkPlayerOrbitalShip()

{
  self.is_linked_to_pod = false;
  self.is_linked_to_ship = true;
  self.isdropping = true;

  self destroyPlayerIcons();
  self thread showPlayerIcons("both");

  if(!isDefined(self.is_first_drop)) {
    self.is_first_drop = false;
  } else {
    self thread leaderDialogOnPlayer("orbital_dropin", undefined, undefined, self.origin);
  }

  if(isDefined(self.drop_pod)) {
    self SetClientOmnvar("ui_orbital_toggle_switch", 0);

    if(isDefined(self.drop_pod.spawn_fx)) {
      self.drop_pod.spawn_fx delete();
    }
  } else {
    self SetClientOmnvar("ui_orbital_toggle_switch", 1);
  }

  static_length = 0.3;
  self thread setOrbitalView("ship", 0);

  current_level = getDvar("mapname");

  self DontInterpolate();
  switch (current_level) {
    case "mp_refraction":
      self PlayerLinkTo(level.orbital_ships.cameraView[self.pers["team"]], "tag_player", 0, 180, 180, -40, 80, false);
      break;
    default:
      self PlayerLinkTo(level.orbital_ships.cameraView[self.pers["team"]], "tag_player", 1, 90, 90, -50, 80, false);
      break;
  }

  self thread centerOrbitalView();

  self SetClientOmnvar("ui_orbital_collision_warn", 0);
  self thread traceCollisionWarn();
}

unlinkPlayer()

{
  self DontInterpolate();
  self ControlsUnlink();
  self CameraUnlink();
  self unlink();

  self FreezeControls(true);
  self EnableWeapons();
  self ShowViewModel();
}

centerOrbitalView()

{
  startPos = level.orbital_ships.cameraView[self.pers["team"]].origin;
  endPos = level.orbital_ships.missileSpawn["target"].origin;
  angles = VectorToAngles(endPos - startPos);

  self SetPlayerAngles(angles);
}

centerPodSpawnView()

{
  startPos = self.drop_pod.camera.origin;
  endPos = level.orbital_ships.missileSpawn["target"].origin;
  angles = VectorToAngles(endPos - startPos);
  angles *= (0, 1, 0);

  self SetPlayerAngles(angles);
}

setOrbitalView(view, wait_delay)

{
  self SetClientOmnvar("ui_orbital_toggle_ship_view", 2);
  self SetClientOmnvar("ui_orbital_toggle_pod_view", 2);
  self SetClientOmnvar("ui_orbital_toggle_drop_view", 2);

  wait(wait_delay);

  switch (view) {
    case "ship":
      self SetClientOmnvar("ui_orbital_toggle_ship_view", 1);
      break;

    case "pod":
      self SetClientOmnvar("ui_orbital_collision_warn", 0);
      self SetClientOmnvar("ui_orbital_toggle_pod_view", 1);
      break;

    case "drop":
      self SetClientOmnvar("ui_orbital_toggle_drop_view", 1);
      break;

    case "off":
      self SetClientOmnvar("ui_orbital_is_dropping", false);

      break;

    default:
      break;
  }
}

traceCollisionWarn()

{
  self endon("player_drop_pod_spawned");
  self endon("disconnect");
  self endon("player_spawned_at_drop_pod");
  self endon("joined_team");
  self endon("death");
  self endon("switched_to_pod_view");

  while(true) {
    angles = self GetPlayerAngles();
    start = self getEye() + (anglesToForward(angles) * 20);
    end = start + (anglesToForward(angles) * 30000);

    trace = PlayerPhysicsTraceInfo(start, end);
    trace["position"] += (0, 0, 10);
    level.trace = trace;

    if(isDefined(trace["position"])) {
      location = trace["position"];
      precision_spawn_good = false;
      temp_origin = spawn("script_origin", location);
      temp_origin.targetname = "orbital_trace_position";

      foreach(trigger in level.drop_pod_volume_array) {
        is_touching = temp_origin IsTouching(trigger);
        can_spawn = Canspawn(location);

        if(is_touching && can_spawn) {
          precision_spawn_good = true;
          break;
        }
      }
      temp_origin delete();

      if(precision_spawn_good == true) {
        self SetClientOmnvar("ui_orbital_collision_warn", 0);
      } else {
        self SetClientOmnvar("ui_orbital_collision_warn", 1);
      }
    }
    wait 0.15;
  }
}

_fire(lifeId, player)

{
  player endon("death");

  static_length = 0.3;
  player thread setOrbitalView("drop", 0);
  thread setFovScale(4.333, 0.1);

  player destroyPlayerIcons();
  player showPlayerIcons("friendly");

  if(!IsBot(player)) {
    player.orbital_location = player getEye();
    player.orbital_viewangles = player GetPlayerAngles();
    player.orbital_forward = anglesToForward(player.orbital_viewangles);
    player.orbital_endpoint = player.orbital_location + player.orbital_forward * 5000;
    rocket = MagicBullet("orbital_drop_pod_mp", player.orbital_location, self.orbital_endpoint, player);
    rocket thread aud_drop_pod_fire(player);
    rocket thread aud_play_rocket_travel_loops(player);
  } else {
    player.orbital_location = level.orbital_ships.cameraView[self.pers["team"]].origin;
    startPos = level.orbital_ships.cameraView[self.pers["team"]].origin;
    endPos = level.orbital_ships.missileSpawn["target"].origin;
    player.orbital_viewangles = VectorToAngles(endPos - startPos);
    player.orbital_forward = anglesToForward(player.orbital_viewangles);
    player.orbital_endpoint = startPos + player.orbital_forward * 5000;
    rocket = MagicBullet("orbital_drop_pod_mp", startPos, self.orbital_endpoint, player);
    rocket thread aud_drop_pod_fire(player);
    rocket thread aud_play_rocket_travel_loops(player);
  }

  playFX(level.drop_pod_effect["drop_pod_fire_flash"], player.orbital_location, player.orbital_forward);

  self thread destroyPlayerDropPod();

  self notify("drop_pod_spawned");

  if(!isDefined(rocket)) {
    return;
  }

  rocket.trigger = spawn("trigger_radius", rocket.origin, 0, 128, 256);

  if(player IsLinked()) {
    player Unlink();
    player DontInterpolate();
    player PlayerLinkTo(rocket);
  }

  rocket.owner = player;
  rocket.lifeId = lifeId;
  rocket.type = "orbital_drop_pod_mp";
  rocket.team = player.team;
  level.remoteMissileInProgress = true;
  rocket thread createKillCamEntity();
  player.rocket = rocket;

  wait 0.1;

  nearest_node = MissileEyes(player, rocket);

  return nearest_node;
}

setFovScale(fov_scale, delay)

{
  if(isDefined(delay)) {
    wait delay;
  }

  self setclientdvar("cg_fovScale", fov_scale);
}

MissileEyes(player, rocket)

{
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("death");

  rocket thread Rocket_CleanupOnDeath();
  player thread Player_CleanupOnGameEnded(rocket);
  player thread Player_CleanupOnTeamChange(rocket);
  rocket thread waitForRocketImpact(player);
  rocket thread waitForRocketDeath(player);

  current_level = getDvar("mapname");
  player VisionSetMissilecamForPlayer(current_level, 0);

  player endon("disconnect");

  player.spawn_was_good = false;
  nearest_node = undefined;
  direction = (0, 0, 0);

  if(isDefined(rocket)) {
    player CameraLinkTo(rocket, "tag_origin");
    player ControlsLinkTo(rocket);

    rocket thread trackRocket(player);
    rocket thread dropPodTrophySystem();

    if(getDvarInt("camera_thirdPerson")) {
      player setThirdPersonDOF(false);
    }

    player waittill_any("rocket_impacted", "rocket_destroyed");

    rocket thread aud_play_pod_impact(player);

    player destroyPlayerIcons();

    player notify("player_drop_pod_spawned");

    player unlinkPlayer();

    if(!level.gameEnded || isDefined(player.finalKill)) {
      thread setFovScale(1, 0);
    }

    if(getDvarInt("camera_thirdPerson")) {
      player setThirdPersonDOF(true);
    }
  } else {
    AssertMsg("rocket is undefined");
  }

  freeze_delay = 0.3;

  if(player.spawn_was_good == true && isDefined(player.nearest_node)) {
    player createPlayerDropPod(player.nearest_node.origin);

    player setOrigin(player.drop_pod.origin);
    player SetPlayerAngles((0, player.angles[1], 0));
    player thread unfreezeControlsDelay(freeze_delay);
    player playerShow();

    player.nearest_node = undefined;

    player thread dropPodBaseUnfold();

    player.drop_pod thread drop_pod_handleDeath();
    player.drop_pod thread aud_drop_pod_land_success(player);
  } else {
    player SetOrigin(player.impact_info["rocket_position"]);
    player thread dropPodBadSpawnDeathFX();
    player maps\mp\gametypes\_damage::addAttacker(player, player, player.rocket.killCamEnt, "orbital_drop_pod_mp", 999999, (0, 0, 0), player.origin, "none", 0, "MOD_EXPLOSIVE");
    player thread unfreezeControlsDelay(freeze_delay);
    thread aud_drop_pod_land_fail(player);
    player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(player.rocket.killCamEnt, player, 999999, 0, "MOD_EXPLOSIVE", "orbital_drop_pod_mp", player.origin, player.origin, "none", 0, 0);
    player thread leaderDialogOnPlayer("orbital_notgood_tryhard", undefined, undefined, self.origin);
  }

  return nearest_node;
}

waitForRocketImpact(player)

{
  level endon("game_ended");
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("death");

  while(true) {
    player waittill("projectile_impact", weaponName, position, radius, direction);

    if(weaponName == "orbital_drop_pod_mp") {
      break;
    }
  }

  player.spawn_was_good = true;

  player notify("rocket_impacted");
}

waitForRocketDeath(player)

{
  level endon("game_ended");
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("death");

  self waittill("death");

  if(isDefined(self)) {
    self Delete();
  }

  player CameraUnlink();
  player ControlsUnlink();
  player setFovScale(1, 0);

  player notify("rocket_destroyed");
}

vmLandingImpact()

{
  wait(0.5);

  self StunPlayer(0.3);
}

dropPodBaseUnfold()

{
  wait(level.drop_pod.deploy_delay - 1);
  self.drop_pod thread dropPodSpikeImpacts();
  self.drop_pod_enemy_model thread dropPodSpikeImpacts();

  self.drop_pod ScriptModelPlayAnimDeltaMotion("mp_orbital_pod_base_unfold");
  self.drop_pod_enemy_model ScriptModelPlayAnimDeltaMotion("mp_orbital_pod_base_unfold");
}

dropPodSpikeImpacts()

{
  wait 0.68;

  spikeLength = 2;
  spikeOrg = [];
  spikeAngles = [];

  spikeOrg[0] = self GetTagOrigin("J_spike_FL");
  spikeAngles[0] = self GetTagAngles("J_spike_FL");

  spikeOrg[1] = self GetTagOrigin("J_spike_BL");
  spikeAngles[1] = self GetTagAngles("J_spike_BL");

  spikeOrg[2] = self GetTagOrigin("J_spike_BR");
  spikeAngles[2] = self GetTagAngles("J_spike_BR");

  spikeOrg[3] = self GetTagOrigin("J_spike_FR");
  spikeAngles[3] = self GetTagAngles("J_spike_FR");

  for(x = 0; x < spikeOrg.size; x++) {
    start = spikeOrg[x] - (8 * anglesToForward(spikeAngles[x]));
    end = spikeOrg[x] + (spikeLength * anglesToForward(spikeAngles[x]));
    trace = bulletTrace(start, end, false, self);
    if(isDefined(trace["position"])) {
      playFX(level.drop_pod_effect["drop_pod_spike_impact"], trace["position"], anglesToForward((270, 0, 0)));
    }
  }
}

trackRocket(player)

{
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  while(true) {
    player.impact_info["rocket_position"] = self.origin;
    start = self.origin;
    direction = self.angles;
    forward = anglesToForward(direction);
    end = start + (forward * 512);

    trace = PlayerPhysicsTraceInfo(start, end);

    self.trigger DontInterpolate();
    self.trigger.origin = trace["position"] + (0, 0, -128);

    nearest_node = self.trigger thread getNearestPathNode();
    if(isDefined(nearest_node)) {
      self.owner.nearest_node = nearest_node;
      self hide();

      playFXOnTag(level.drop_pod_effect["decel_explosion"], self, "tag_origin");
      start = self.origin;
      end = nearest_node.origin;
      direction = VectorToAngles(end - start);

      self.angles = direction;

      self.trigger delete();
      break;
    }

    wait(0.05);
  }
}

unfreezeControlsDelay(delay)

{
  wait delay;
  self FreezeControls(false);
}

dropPodBadSpawnDeathFX()

{
  self endon("disconnect");

  self waittill("death");

  playFX(level.drop_pod_effect["drop_pod_explode"], self.origin + (0, 0, 10));
}

getNearestPathNode()

{
  nodes = GetNodesInTrigger(self);

  if(isDefined(nodes) && nodes.size > 0) {
    closest_node = 0;
    temp_dist = DistanceSquared(self.origin, nodes[0].origin);
    for(i = 0; i < nodes.size; i++) {
      switch (nodes[i].type) {
        case "End":
        case "Begin":
        case "Cover Stand":
        case "Cover Left":
        case "Cover Right":
          nodes[i] = undefined;
          continue;

        default:
          break;
      }

      if(isDefined(nodes[i].script_noteworthy)) {
        if(nodes[i].script_noteworthy == "orbital_no_spawn") {
          nodes[i] = undefined;
          continue;
        }
      }

      check_dist = DistanceSquared(self.origin, nodes[i].origin);
      if(check_dist < temp_dist) {
        temp_dist = check_dist;
        closest_node = i;
      }
    }
    return nodes[closest_node];
  } else {
    return undefined;
  }
}

Rocket_CleanupOnDeath()

{
  entityNumber = self getEntityNumber();
  level.rockets[entityNumber] = self;
  self waittill("death");

  level.rockets[entityNumber] = undefined;

  level.remoteMissileInProgress = undefined;
}

Player_CleanupOnGameEnded(rocket)

{
  rocket endon("death");
  self endon("death");

  level waittill("game_ended");

  self ControlsUnlink();
  self CameraUnlink();

  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }
}

Player_CleanupOnTeamChange(rocket)

{
  rocket endon("death");
  self endon("disconnect");

  self waittill_any("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self ControlsUnlink();
    self CameraUnlink();

    if(getDvarInt("camera_thirdPerson")) {
      self setThirdPersonDOF(true);
    }
  }

  self setFovScale(1, 0);

  level.remoteMissileInProgress = undefined;
}

dropPod_CleanupOnTeamChange()

{
  self.drop_pod endon("death");
  self waittill_any("joined_team", "joined_spectators");

  self deletePlayerDropPod();
}

dropPod_CleanupOnDisconnect()

{
  self.drop_pod endon("death");
  self waittill("disconnect");

  self deletePlayerDropPod();
}

createPlayerDropPod(coords)

{
  self deletePlayerDropPod();

  if(!isDefined(coords)) {
    AssertMsg("createPlayerDropPod -> coords undefined!");
  }

  traceStart = coords + (0, 0, 32);
  traceEnd = coords + (0, 0, -1024);
  trace = PlayerPhysicsTraceInfo(traceStart, traceEnd);
  location = trace["position"];
  upangles = vectorToAngles(trace["normal"]);
  forward = anglesToForward(upangles);
  upangles += (180, 0, 0);

  playFX(level.drop_pod_effect["landing_impact"], location, trace["normal"]);
  self.drop_pod = spawn("script_model", location);
  self.drop_pod.angles = upangles;
  self.drop_pod.forward = forward;
  self.drop_pod setModel(level.drop_pod.model);
  self.drop_pod Solid();
  self.drop_pod setCanDamage(true);
  self.drop_pod setCanRadiusDamage(true);
  self.drop_pod.hidden = false;
  self.drop_pod.owner = self;
  self.drop_pod.destroyed = false;
  self.drop_pod.health = 999999;
  self.drop_pod.maxHealth = 100;
  self.drop_pod.damageTaken = 0;
  self.drop_pod Hide();

  self.drop_pod_enemy_model = spawn("script_model", self.drop_pod.origin);
  self.drop_pod_enemy_model setModel(level.drop_pod.enemy_model);
  self.drop_pod_enemy_model.angles = self.drop_pod.angles;
  self.drop_pod_enemy_model.owner = self;
  self.drop_pod_enemy_model Hide();
  self.drop_pod_enemy_model NotSolid();

  foreach(player in level.players) {
    if(player.team == self.team) {
      self.drop_pod ShowToPlayer(player);
    } else {
      self.drop_pod_enemy_model ShowToPlayer(player);
    }
  }

  self.drop_pod thread aud_setup_drop_pod_loop();

  self.drop_pod.camera = spawn("script_model", self.drop_pod.origin);
  self.drop_pod.camera setModel("tag_player");
  self.drop_pod.camera.angles = (0, 0, 0);
  self.drop_pod.camera hide();

  self.isdropping = false;

  self.drop_pod thread PodSetupTrophyFX(self);

  self thread dropPod_CleanupOnDisconnect();
  self thread dropPod_CleanupOnTeamChange();
}

destroyPlayerDropPod()

{
  if(!isDefined(self.drop_pod)) {
    return;
  }

  self endon("player_drop_pod_spawned");

  drop_pod = self.drop_pod;
  pod_destroyed = level.drop_pod_effect["pod_base_destroyed"];
  dome_shutdown_friendly = level.drop_pod_effect["dome_shutdown_friendly"];
  dome_shutdown_enemy = level.drop_pod_effect["dome_shutdown_enemy"];

  playFX(pod_destroyed, drop_pod.origin, drop_pod.forward);
  drop_pod Hide();
  self.drop_pod_enemy_model Hide();

  drop_pod.shutdown_fx_friendly = SpawnFx(dome_shutdown_friendly, drop_pod.origin, drop_pod.forward);
  drop_pod.shutdown_fx_enemy = SpawnFx(dome_shutdown_enemy, drop_pod.origin, drop_pod.forward);
  TriggerFX(drop_pod.shutdown_fx_friendly);
  drop_pod.shutdown_fx_friendly Hide();
  TriggerFX(drop_pod.shutdown_fx_enemy);
  drop_pod.shutdown_fx_enemy Hide();

  drop_pod thread aud_destroy_deployed_pod();

  foreach(player in level.players) {
    if(player.team == self.team) {
      drop_pod.shutdown_fx_friendly ShowToPlayer(player);
    } else {
      drop_pod.shutdown_fx_enemy ShowToPlayer(player);
    }
  }

  wait(0.7);

  self deletePlayerDropPod();
}

deletePlayerDropPod()

{
  if(isDefined(self.drop_pod_enemy_model)) {
    self.drop_pod_enemy_model Delete();
  }

  if(isDefined(self.drop_pod)) {
    self deletePlayerDropPodVFX();

    if(isDefined(self.drop_pod.camera)) {
      self.drop_pod.camera Delete();
    }

    self.drop_pod Delete();
  }
}

deletePlayerDropPodVFX()

{
  if(isDefined(self.drop_pod)) {
    if(isDefined(self.drop_pod.trophyFX_friendly)) {
      self.drop_pod.trophyFX_friendly delete();
    }

    if(isDefined(self.drop_pod.trophyFX_enemy)) {
      self.drop_pod.trophyFX_enemy delete();
    }

    if(isDefined(self.drop_pod.trophyFX_ground_friendly)) {
      self.drop_pod.trophyFX_ground_friendly delete();
    }

    if(isDefined(self.drop_pod.trophyFX_ground_enemy)) {
      self.drop_pod.trophyFX_ground_enemy delete();
    }

    if(isDefined(self.drop_pod.shutdown_fx_enemy)) {
      self.drop_pod.shutdown_fx_enemy delete();
    }

    if(isDefined(self.drop_pod.shutdown_fx_enemy)) {
      self.drop_pod.shutdown_fx_enemy delete();
    }

    if(isDefined(self.drop_pod.spawn_fx)) {
      self.drop_pod.spawn_fx delete();
    }
  }
}

createKillCamEntity() {
  killCamOffset = (-512, 0, 128);

  self.killCamEnt = spawn("script_model", self.origin);
  self.killCamEnt SetScriptMoverKillCam("explosive");
  self.killCamEnt LinkTo(self, "tag_origin", killCamOffset, (0, 0, 0));
  self.killCamEnt SetContents(0);
  self.killCamEnt.startTime = getTime();
  self.killCamEnt.isOrbitalCam = true;
}

removeKillCamEntity() {
  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }
}

drop_pod_handleDeath()

{
  entNum = self GetEntityNumber();

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.owner thread leaderDialogOnPlayer("orbital_pod_destroyed_enemy", undefined, undefined, self.owner.origin);
  self.owner destroyPlayerDropPod();
}

dropPodTrophySystem()

{
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  while(isDefined(self)) {
    foreach(player in level.players) {
      if(player.team != self.owner.team) {
        if(isDefined(player.drop_pod)) {
          if(DistanceSquared(self.origin, player.drop_pod.origin) < 40000 && self.owner.health > 0) {
            player.drop_pod thread dropPodTrophyKill(self, player);
          }
        }
      }
    }

    foreach(trophy in level.trophies) {
      if(isDefined(trophy)) {
        if(DistanceSquared(self.origin, trophy.origin) < 40000 && trophy.owner.health > 0) {
          trophy thread dropPodTrophyKill(self, trophy.owner);

          trophy.ammo--;
          if(trophy.ammo <= 0) {
            trophy thread maps\mp\gametypes\_equipment::trophyBreak();
          }
        }
      }
    }

    wait(0.05);
  }
}

dropPodTrophyKill(grenade, owner)

{
  grenade notify("destroyed");
  playFX(level.sentry_fire, self.origin + (0, 0, 0), (grenade.origin - self.origin), AnglesToUp(self.angles));
  self playSound("trophy_detect_projectile");

  if((isDefined(grenade.classname) && grenade.classname == "rocket") &&
    (isDefined(grenade.type) && (grenade.type == "remote"))) {
    if(isDefined(grenade.type) && grenade.type == "remote") {
      level thread maps\mp\gametypes\_missions::vehicleKilled(grenade.owner, owner, undefined, owner, undefined, "MOD_EXPLOSIVE", "trophy_mp");
      level thread teamPlayerCardSplash("callout_destroyed_predator_missile", owner);
      level thread maps\mp\gametypes\_rank::awardGameEvent("kill", owner, "trophy_mp", undefined, "MOD_EXPLOSIVE");
    }

    self thread aud_drop_pod_trophy_kill();
  }

  owner thread projectileExplode(grenade, self);
}

projectileExplode(projectile, trophy)

{
  projPosition = projectile.origin;
  projType = projectile.model;
  projAngles = projectile.angles;
  proj_owner = projectile.owner;
  trophy_owner = trophy.owner;
  drop_pod = trophy_owner.drop_pod;

  dome_flash = level.drop_pod_effect["dome_impact_flash"];
  dome_impact = level.drop_pod_effect["dome_impact"];
  start = trophy.origin;
  end = projPosition;
  fx_angles = VectorToAngles(end - start);
  fx_forward = anglesToForward(fx_angles);
  fx_up = AnglesToUp(fx_angles);

  playFX(dome_impact, projPosition, fx_forward, fx_up);
  playFXOnTag(dome_flash, drop_pod, "tag_origin");

  waittillframeend;

  if(proj_owner.health <= 0) {
    return;
  }

  proj_owner thread setFovScale(1, 0);
  proj_owner unlink();
  proj_owner CameraUnlink();
  proj_owner setOrigin(projPosition);

  proj_owner maps\mp\gametypes\_damage::addAttacker(proj_owner, proj_owner, proj_owner.rocket.killCamEnt, "orbital_drop_pod_mp", 999999, (0, 0, 0), proj_owner.origin, "none", 0, "MOD_EXPLOSIVE");
  proj_owner thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper(proj_owner.rocket.killCamEnt, proj_owner, 999999, 0, "MOD_EXPLOSIVE", "orbital_drop_pod_mp", proj_owner.origin, proj_owner.origin, "none", 0, 0);

  if(isDefined(projectile)) {
    projectile delete();
  }

  trophy thread aud_play_trophy_fire();
  RadiusDamage(projPosition, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");

  proj_owner thread leaderDialogOnPlayer("orbital_pod_destroyed", undefined, undefined, proj_owner.origin);
}

PodSetupTrophyFX(owner)

{
  self endon("death");
  owner endon("disconnect");
  owner endon("joined_team");
  owner endon("joined_spectators");

  self.trophyFX_friendly = SpawnFx(level.drop_pod_dome["friendly"], self.origin, self.forward);
  TriggerFx(self.trophyFX_friendly);
  self.trophyFX_friendly hide();

  self.trophyFX_enemy = SpawnFx(level.drop_pod_dome["enemy"], self.origin, self.forward);
  TriggerFx(self.trophyFX_enemy);
  self.trophyFX_enemy hide();

  wait(level.drop_pod.deploy_delay - 0.5);

  self.trophyFX_ground_friendly = SpawnFx(level.drop_pod_dome_ground["friendly"], self.origin, self.forward);
  TriggerFx(self.trophyFX_ground_friendly);

  self.trophyFX_ground_enemy = SpawnFx(level.drop_pod_dome_ground["enemy"], self.origin, self.forward);
  TriggerFx(self.trophyFX_ground_enemy);
  self.trophyFX_ground_enemy hide();

  self thread deletePodTrophyFxOnDeath(owner);
  self thread deletePodTrophyFxOnDisconnect(owner);
  self thread deletePodTrophyFXOnTeamChange(owner);
}

showPlayerIcons(team)

{
  self endon("death");

  foreach(player in level.players) {
    if(player == self || isDefined(player.isdropping)) {
      continue;
    }

    switch (team) {
      case "friendly":

        if(player.team == self.team) {
          player maps\mp\_entityheadIcons::setHeadIcon(self, "ac130_hud_friendly_vehicle_target", (0, 0, 0), 4, 4, undefined, undefined, undefined, undefined, undefined, false);
        }
        break;

      case "enemy":

        if(!(player.team == self.team)) {
          player maps\mp\_entityheadIcons::setHeadIcon(self, "hud_fofbox_hostile", (0, 0, 0), 4, 4, undefined, undefined, undefined, undefined, undefined, false);
        }
        break;

      case "both":

        if(player.team == self.team) {
          player maps\mp\_entityheadIcons::setHeadIcon(self, "ac130_hud_friendly_vehicle_target", (0, 0, 0), 4, 4, undefined, undefined, undefined, undefined, undefined, false);
        } else {
          player maps\mp\_entityheadIcons::setHeadIcon(self, "hud_fofbox_hostile", (0, 0, 0), 4, 4, undefined, undefined, undefined, undefined, undefined, false);
        }
        break;

      default:
        break;
    }
  }
}

destroyPlayerIcons()

{
  level endon("game_ended");
  self endon("disconnect");

  foreach(player in level.players) {
    if(isDefined(player.entityHeadIcons)) {
      if(isDefined(player.entityHeadIcons[self.guid])) {
        player.entityHeadIcons[self.guid] destroy();
        player.entityHeadIcons[self.guid] = undefined;
      }
    }
  }
}

showDropPodBadSpawnOverlay()

{
  level endon("game_ended");

  while(true) {
    hideOverlays();

    foreach(player in level.players) {
      if(isDefined(player.isdropping)) {
        if(player.isdropping)
      }
      player showOverlaysToPlayer();
    }
    wait(0.05);
  }
}

showOverlaysToPlayer()

{
  foreach(overlay in level.drop_pod_bad_spawn_overlay) {
    overlay ShowToPlayer(self);
  }
}

hideOverlays()

{
  foreach(overlay in level.drop_pod_bad_spawn_overlay) {
    overlay hide();
  }
}

deletePodTrophyFxOnDeath(owner)

{
  owner endon("disconnect");

  self waittill("death");

  self deletePodTrophyFX();
}

deletePodTrophyFXOnDisconnect(owner)

{
  self endon("death");
  owner waittill("disconnect");

  self deletePodTrophyFX();
}

deletePodTrophyFXOnTeamChange(owner)

{
  self endon("death");

  owner waittill_any("joined_team", "joined_spectators");

  self deletePodTrophyFX();
}

deletePodTrophyFX()

{
  if(isDefined(self.trophyFX_friendly)) {
    self.trophyFX_friendly delete();
  }

  if(isDefined(self.trophyFx_enemy)) {
    self.trophyFx_enemy delete();
  }
}

dropPodForceRespawn()

{
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("player_drop_pod_spawned");
  self endon("player_spawned_at_drop_pod");
  level endon("game_ended");
  self.forcerespawn = false;

  if(!isDefined(self.forcerespawn_timer)) {
    self.forcerespawn_timer = level.forcerespawn_time;
  }

  while(self.forcerespawn_timer > 0) {
    if(self.forcerespawn_timer <= 5) {
      self SetClientOmnvar("ui_orbital_toggle_color", 1);
    }

    self.forcerespawn_timer--;
    wait(1);
  }
  self.forcerespawn = true;
}

aud_play_rocket_travel_loops(player) {
  rocket = self;
  thread snd_play_linked_loop("orbital_drop_pod_proj", rocket);
}

aud_play_pod_impact(player) {
  rocket = self;
}

aud_drop_pod_fire(player) {
  rocket = self;
  player playlocalsound("orbital_drop_pod_fire_plr");
}

aud_drop_pod_land_success(player) {
  drop_pod = self;
  thread snd_play_linked("orbital_drop_pod_impact", drop_pod);
  player playlocalsound("orbital_drop_pod_impact");
}

aud_drop_pod_land_fail(player) {
  drop_pod = self;
  thread snd_play_linked("orbital_drop_pod_impact", drop_pod);
  player playlocalsound("orbital_drop_pod_impact");
}

aud_destroy_deployed_pod() {
  drop_pod = self;
  drop_pod playSound("orbital_drop_pod_platform_exp");
}

aud_drop_pod_trophy_kill() {
  drop_pod = self;
}

aud_play_trophy_fire() {
  trophy = self;
}

aud_setup_drop_pod_loop() {
  thread snd_play_linked_loop("orbital_drop_pod_platform_lp", self);

  self waittill("Death");

  if(isDefined(self)) {
    self stopsounds();
  }
}