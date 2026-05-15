/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_odin.gsc
*****************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.killstreakFuncs["odin_support"] = ::tryUseOdin;
  level.killstreakFuncs["odin_assault"] = ::tryUseOdin;

  level._effect["odin_clouds"] = LoadFX("vfx/gameplay/mp/killstreaks/odin/odin_parallax_clouds");
  level._effect["odin_fisheye"] = LoadFX("vfx/gameplay/screen_effects/vfx_scrnfx_odin_fisheye");
  level._effect["odin_targeting"] = LoadFX("vfx/gameplay/mp/killstreaks/odin/vfx_marker_odin_cyan");

  level.odinSettings = [];

  level.odinSettings["odin_support"] = spawnStruct();
  level.odinSettings["odin_support"].timeOut = 60.0;
  level.odinSettings["odin_support"].streakName = "odin_support";
  level.odinSettings["odin_support"].vehicleInfo = "odin_mp";
  level.odinSettings["odin_support"].modelBase = "vehicle_odin_mp";
  level.odinSettings["odin_support"].teamSplash = "used_odin_support";
  level.odinSettings["odin_support"].voTimedOut = "odin_gone";
  level.odinSettings["odin_support"].voKillSingle = "odin_target_killed";
  level.odinSettings["odin_support"].voKillMulti = "odin_targets_killed";
  level.odinSettings["odin_support"].ui_num = 1;
  level.odinSettings["odin_support"].unavailable_string = &"KILLSTREAKS_ODIN_UNAVAILABLE";

  level.odinSettings["odin_support"].weapon["airdrop"] = spawnStruct();
  level.odinSettings["odin_support"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.odinSettings["odin_support"].weapon["airdrop"].rumble = "smg_fire";
  level.odinSettings["odin_support"].weapon["airdrop"].ammoOmnvar = "ui_odin_airdrop_ammo";
  level.odinSettings["odin_support"].weapon["airdrop"].airdropType = "airdrop_support";
  level.odinSettings["odin_support"].weapon["airdrop"].reloadTimer = 20;
  level.odinSettings["odin_support"].weapon["airdrop"].ui_num_fired = -1;
  level.odinSettings["odin_support"].weapon["airdrop"].voAirdrop = "odin_carepackage";
  level.odinSettings["odin_support"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
  level.odinSettings["odin_support"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";

  level.odinSettings["odin_support"].weapon["marking"] = spawnStruct();
  level.odinSettings["odin_support"].weapon["marking"].projectile = "odin_projectile_marking_mp";
  level.odinSettings["odin_support"].weapon["marking"].rumble = "heavygun_fire";
  level.odinSettings["odin_support"].weapon["marking"].ammoOmnvar = "ui_odin_marking_ammo";
  level.odinSettings["odin_support"].weapon["marking"].reloadTimer = 4;
  level.odinSettings["odin_support"].weapon["marking"].ui_num_fired = -1;
  level.odinSettings["odin_support"].weapon["marking"].voMarking = "odin_marking";
  level.odinSettings["odin_support"].weapon["marking"].voMarkedSingle = "odin_marked";
  level.odinSettings["odin_support"].weapon["marking"].voMarkedMulti = "odin_m_marked";
  level.odinSettings["odin_support"].weapon["marking"].plr_ready_sound = "odin_flash_ready";
  level.odinSettings["odin_support"].weapon["marking"].plr_fire_sound = "odin_flash_launch";

  level.odinSettings["odin_support"].weapon["smoke"] = spawnStruct();
  level.odinSettings["odin_support"].weapon["smoke"].projectile = "odin_projectile_smoke_mp";
  level.odinSettings["odin_support"].weapon["smoke"].rumble = "smg_fire";
  level.odinSettings["odin_support"].weapon["smoke"].ammoOmnvar = "ui_odin_smoke_ammo";
  level.odinSettings["odin_support"].weapon["smoke"].reloadTimer = 7;
  level.odinSettings["odin_support"].weapon["smoke"].ui_num_fired = -1;
  level.odinSettings["odin_support"].weapon["smoke"].voSmoke = "odin_smoke";
  level.odinSettings["odin_support"].weapon["smoke"].plr_ready_sound = "odin_smoke_ready";
  level.odinSettings["odin_support"].weapon["smoke"].plr_fire_sound = "odin_smoke_launch";

  level.odinSettings["odin_support"].weapon["juggernaut"] = spawnStruct();
  level.odinSettings["odin_support"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.odinSettings["odin_support"].weapon["juggernaut"].rumble = "heavygun_fire";
  level.odinSettings["odin_support"].weapon["juggernaut"].ammoOmnvar = "ui_odin_juggernaut_ammo";
  level.odinSettings["odin_support"].weapon["juggernaut"].juggType = "juggernaut_recon";
  level.odinSettings["odin_support"].weapon["juggernaut"].reloadTimer = level.odinSettings["odin_support"].timeOut;
  level.odinSettings["odin_support"].weapon["juggernaut"].ui_num_fired = -1;
  level.odinSettings["odin_support"].weapon["juggernaut"].ui_num_move = -2;
  level.odinSettings["odin_support"].weapon["juggernaut"].ui_num_dead = -3;
  level.odinSettings["odin_support"].weapon["juggernaut"].voJugg = "odin_moving";
  level.odinSettings["odin_support"].weapon["juggernaut"].plr_ready_sound = "null";
  level.odinSettings["odin_support"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";

  level.odinSettings["odin_assault"] = spawnStruct();
  level.odinSettings["odin_assault"].timeOut = 60.0;
  level.odinSettings["odin_assault"].streakName = "odin_assault";
  level.odinSettings["odin_assault"].vehicleInfo = "odin_mp";
  level.odinSettings["odin_assault"].modelBase = "vehicle_odin_mp";
  level.odinSettings["odin_assault"].teamSplash = "used_odin_assault";
  level.odinSettings["odin_assault"].voTimedOut = "loki_gone";
  level.odinSettings["odin_assault"].voKillSingle = "odin_target_killed";
  level.odinSettings["odin_assault"].voKillMulti = "odin_targets_killed";
  level.odinSettings["odin_assault"].ui_num = 2;
  level.odinSettings["odin_assault"].unavailable_string = &"KILLSTREAKS_LOKI_UNAVAILABLE";

  level.odinSettings["odin_assault"].weapon["airdrop"] = spawnStruct();
  level.odinSettings["odin_assault"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
  level.odinSettings["odin_assault"].weapon["airdrop"].rumble = "smg_fire";
  level.odinSettings["odin_assault"].weapon["airdrop"].ammoOmnvar = "ui_odin_airdrop_ammo";
  level.odinSettings["odin_assault"].weapon["airdrop"].airdropType = "airdrop_assault";
  level.odinSettings["odin_assault"].weapon["airdrop"].reloadTimer = 20;
  level.odinSettings["odin_assault"].weapon["airdrop"].ui_num_fired = -1;
  level.odinSettings["odin_assault"].weapon["airdrop"].voAirdrop = "odin_carepackage";
  level.odinSettings["odin_assault"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
  level.odinSettings["odin_assault"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";

  level.odinSettings["odin_assault"].weapon["large_rod"] = spawnStruct();
  level.odinSettings["odin_assault"].weapon["large_rod"].projectile = "odin_projectile_large_rod_mp";
  level.odinSettings["odin_assault"].weapon["large_rod"].rumble = "heavygun_fire";
  level.odinSettings["odin_assault"].weapon["large_rod"].ammoOmnvar = "ui_odin_marking_ammo";
  level.odinSettings["odin_assault"].weapon["large_rod"].reloadTimer = 4;
  level.odinSettings["odin_assault"].weapon["large_rod"].ui_num_fired = -2;
  level.odinSettings["odin_assault"].weapon["large_rod"].plr_ready_sound = "null";
  level.odinSettings["odin_assault"].weapon["large_rod"].plr_fire_sound = "ac130_105mm_fire";
  level.odinSettings["odin_assault"].weapon["large_rod"].npc_fire_sound = "ac130_105mm_fire_npc";

  level.odinSettings["odin_assault"].weapon["small_rod"] = spawnStruct();
  level.odinSettings["odin_assault"].weapon["small_rod"].projectile = "odin_projectile_small_rod_mp";
  level.odinSettings["odin_assault"].weapon["small_rod"].rumble = "smg_fire";
  level.odinSettings["odin_assault"].weapon["small_rod"].ammoOmnvar = "ui_odin_smoke_ammo";
  level.odinSettings["odin_assault"].weapon["small_rod"].reloadTimer = 2;
  level.odinSettings["odin_assault"].weapon["small_rod"].ui_num_fired = -2;
  level.odinSettings["odin_assault"].weapon["small_rod"].plr_ready_sound = "null";
  level.odinSettings["odin_assault"].weapon["small_rod"].plr_fire_sound = "ac130_40mm_fire";
  level.odinSettings["odin_assault"].weapon["small_rod"].npc_fire_sound = "ac130_40mm_fire_npc";

  level.odinSettings["odin_assault"].weapon["juggernaut"] = spawnStruct();
  level.odinSettings["odin_assault"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
  level.odinSettings["odin_assault"].weapon["juggernaut"].rumble = "heavygun_fire";
  level.odinSettings["odin_assault"].weapon["juggernaut"].ammoOmnvar = "ui_odin_juggernaut_ammo";
  level.odinSettings["odin_assault"].weapon["juggernaut"].juggType = "juggernaut";
  level.odinSettings["odin_assault"].weapon["juggernaut"].reloadTimer = level.odinSettings["odin_assault"].timeOut;
  level.odinSettings["odin_assault"].weapon["juggernaut"].ui_num_fired = -1;
  level.odinSettings["odin_assault"].weapon["juggernaut"].ui_num_move = -2;
  level.odinSettings["odin_assault"].weapon["juggernaut"].ui_num_dead = -3;
  level.odinSettings["odin_assault"].weapon["juggernaut"].voJugg = "odin_moving";
  level.odinSettings["odin_assault"].weapon["juggernaut"].plr_ready_sound = "null";
  level.odinSettings["odin_assault"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";

  if(!isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh = GetEnt("heli_pilot_mesh", "targetname");
    if(!isDefined(level.heli_pilot_mesh)) {
      PrintLn("heli_pilot_mesh doesn't exist in this level: " + level.script);
    } else {
      level.heli_pilot_mesh.origin += getHeliPilotMeshOffset();
    }
  }

  maps\mp\agents\_agents::wait_till_agent_funcs_defined();
  level.agent_funcs["odin_juggernaut"] = level.agent_funcs["player"];
  level.agent_funcs["odin_juggernaut"]["think"] = ::empty_init_func;

  level.odin_marking_flash_radius_max = 800;
  level.odin_marking_flash_radius_min = 200;

  level.active_odin = [];

  SetDevDvarIfUninitialized("scr_odin_support_timeout", 60.0);
  SetDevDvarIfUninitialized("scr_odin_assault_timeout", 60.0);
}

tryUseOdin(lifeId, streakName) {
  if(isDefined(self.underWater) && self.underWater) {
    return false;
  }

  odinType = streakName;

  numIncomingVehicles = 1;

  if(currentActiveVehicleCount() >= maxVehiclesAllowed() || level.fauxVehicleCount + numIncomingVehicles >= maxVehiclesAllowed()) {
    self IPrintLnBold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return false;
  }

  if(isDefined(level.active_odin[odinType])) {
    self IPrintLnBold(level.odinSettings[odinType].unavailable_string);
    return false;
  }

  incrementFauxVehicleCount();

  odin = createOdin(odinType);

  if(!isDefined(odin)) {
    decrementFauxVehicleCount();

    return false;
  }

  result = self startOdin(odin);

  if(!isDefined(result)) {
    result = false;
  }

  return result;
}

watchHostMigrationFinishedInit(player) {
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  player endon("killstreak_disowned");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    player SetClientOmnvar("ui_odin", level.odinSettings[self.odinType].ui_num);
    player ThermalVisionFOFOverlayOn();

    playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
    self.targeting_marker ShowToPlayer(player);
  }
}

createOdin(odinType) {
  startPos = (self.origin * (1, 1, 0)) + ((level.heli_pilot_mesh.origin - getHeliPilotMeshOffset()) * (0, 0, 1));
  startAng = (0, 0, 0);

  odin = SpawnHelicopter(self, startPos, startAng, level.odinSettings[odinType].vehicleInfo, level.odinSettings[odinType].modelBase);
  if(!isDefined(odin)) {
    return;
  }
  odin.speed = 40;
  odin.owner = self;
  odin.team = self.team;
  odin.odinType = odinType;

  level.active_odin[odinType] = true;
  self.odin = odin;

  odin thread odin_watchDeath();
  odin thread odin_watchTimeout();
  odin thread odin_watchOwnerLoss();
  odin thread odin_watchRoundEnd();
  odin thread odin_watchTargeting();
  odin thread odin_watchObjectiveCamera();
  odin thread odin_watchOutlines();
  odin thread odin_watchPlayerKilled();
  odin thread odin_dialog_killed_player();
  odin thread odin_onPlayerConnect();

  odin.owner maps\mp\_matchdata::logKillstreakEvent(level.odinSettings[odinType].streakName, startPos);

  return odin;
}

startOdin(odin) {
  level endon("game_ended");
  odin endon("death");

  self.restoreAngles = VectorToAngles(anglesToForward(self.angles));

  self odin_set_using(odin);

  if(GetDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(false);
  }

  self thread watchIntroCleared(odin);

  self freezeControlsWrapper(true);

  self odin_zoom_up(odin);
  self thread maps\mp\killstreaks\_juggernaut::disableJuggernaut();

  result = self maps\mp\killstreaks\_killstreaks::initRideKillstreak(odin.odinType);
  if(result != "success") {
    if(isDefined(self.disabledWeapon) && self.disabledWeapon) {
      self _enableWeapon();
    }
    odin notify("death");

    return false;
  }

  self freezeControlsWrapper(false);

  self RemoteControlVehicle(odin);

  odin thread watchHostMigrationFinishedInit(self);

  odin.odin_overlay_ent = SpawnFXForClient(level._effect["odin_fisheye"], self getEye(), self);
  TriggerFX(odin.odin_overlay_ent);
  odin.odin_overlay_ent SetFXKillDefOnDelete();

  level thread teamPlayerCardSplash(level.odinSettings[odin.odinType].teamSplash, self);

  self ThermalVisionFOFOverlayOn();
  self thread waitAndOutlineOwner(odin);

  return true;
}

waitAndOutlineOwner(odin) {
  self endon("disconnect");
  odin endon("death");

  wait(1.0);
  id = outlineEnableForPlayer(self, "cyan", self, false, "killstreak");
  odin thread removeOutline(id, self);
}

odin_zoom_up(odin) {
  ent = spawn("script_model", odin.origin + (0, 0, 3000));
  ent.angles = VectorToAngles((0, 0, 1));
  ent setModel("tag_origin");
  ent thread waitAndDelete(5);

  zoom_file = "odin_zoom_up";
  lead = ent GetEntityNumber();
  support = self GetEntityNumber();
  bullet_trace = bulletTrace(self.origin, odin.origin, false, self);
  if(bullet_trace["surfacetype"] != "none") {
    zoom_file = "odin_zoom_down";
    lead = odin GetEntityNumber();
    support = ent GetEntityNumber();
  }

  players_to_zoom = array_add(self get_players_watching(), self);
  foreach(player in players_to_zoom) {
    player SetClientOmnvar("cam_scene_name", zoom_file);
    player SetClientOmnvar("cam_scene_lead", lead);
    player SetClientOmnvar("cam_scene_support", support);
    player thread clouds();
  }
}

waitAndDelete(time) {
  self endon("death");
  level endon("game_ended");
  wait(time);
  self delete();
}

clouds() {
  level endon("game_ended");

  ent = spawn("script_model", self.origin + (0, 0, 250));
  ent.angles = VectorToAngles((0, 0, 1));
  ent setModel("tag_origin");
  ent thread waitAndDelete(2);
  wait(0.1);
  PlayFXOnTagForClients(level._effect["odin_clouds"], ent, "tag_origin", self);
}

odin_set_using(odin) {
  self setUsingRemote(odin.odinType);
  self.odin = odin;
}

odin_clear_using(odin) {
  odin.odin_juggernautUseTime = undefined;
  odin.odin_markingUseTime = undefined;
  odin.odin_smokeUseTime = undefined;
  odin.odin_airdropUseTime = undefined;
  odin.odin_largeRodUseTime = undefined;
  odin.odin_smallRodUseTime = undefined;

  if(isDefined(self)) {
    self clearUsingRemote();
    self.odin = undefined;
  }
}

watchIntroCleared(odin) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  odin endon("death");

  self waittill("intro_cleared");

  self SetClientOmnvar("ui_odin", level.odinSettings[odin.odinType].ui_num);

  self watchEarlyExit(odin);
}

odin_waitForDoneFiring(time_out) {
  while(isDefined(self.is_firing) && time_out > 0) {
    wait(0.05);
    time_out -= 0.05;
  }
}

odin_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner odin_EndRide(self);
  }

  cleanup_ents();

  self odin_waitForDoneFiring(3.0);

  decrementFauxVehicleCount();

  level.active_odin[self.odinType] = undefined;

  self delete();
}

odin_watchTimeout() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  config = level.odinSettings[self.odinType];
  timeout = config.timeOut;

  timeout = GetDvarFloat("scr_" + self.odinType + "_timeout");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(timeout);

  self thread odin_leave();
}

odin_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self thread odin_leave();
}

odin_watchObjectiveCamera() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  level waittill("objective_cam");

  self thread odin_leave();
}

odin_watchRoundEnd() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  level waittill_any("round_end_finished", "game_ended");

  self thread odin_leave();
}

odin_leave() {
  self endon("death");
  self notify("leaving");

  config = level.odinSettings[self.odinType];
  leaderDialog(config.voTimedOut);

  if(isDefined(self.owner)) {
    self.owner odin_EndRide(self);
  }

  self notify("gone");

  cleanup_ents();

  self odin_waitForDoneFiring(3.0);

  decrementFauxVehicleCount();

  level.active_odin[self.odinType] = undefined;

  self delete();
}

odin_EndRide(odin) {
  if(isDefined(odin)) {
    self SetClientOmnvar("ui_odin", -1);

    odin notify("end_remote");
    self notify("odin_ride_ended");

    self odin_clear_using(odin);

    if(GetDvarInt("camera_thirdPerson")) {
      self setThirdPersonDOF(true);
    }

    self ThermalVisionFOFOverlayOff();
    self RemoteControlVehicleOff(odin);

    self SetPlayerAngles(self.restoreAngles);

    self thread odin_FreezeBuffer();

    self StopLocalSound("odin_negative_action");
    self StopLocalSound("odin_positive_action");
    foreach(odin_weapon in level.odinSettings[odin.odinType].weapon) {
      if(isDefined(odin_weapon.plr_ready_sound)) {
        self StopLocalSound(odin_weapon.plr_ready_sound);
      }
      if(isDefined(odin_weapon.plr_fire_sound)) {
        self StopLocalSound(odin_weapon.plr_fire_sound);
      }
    }

    if(isDefined(odin.juggernaut)) {
      odin.juggernaut maps\mp\bots\_bots_strategy::bot_guard_player(self, 350);
    }
  }
}

odin_FreezeBuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self freezeControlsWrapper(true);
  wait(0.5);
  self freezeControlsWrapper(false);
}

odin_watchTargeting() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  startTrace = owner GetViewOrigin();
  endTrace = startTrace + (anglesToForward(self GetTagAngles("tag_player")) * 10000);
  markerPos = bulletTrace(startTrace, endTrace, false, self);
  marker = spawn("script_model", markerPos["position"]);
  marker.angles = VectorToAngles((0, 0, 1));
  marker setModel("tag_origin");

  self.targeting_marker = marker;
  marker endon("death");

  trace = bulletTrace(marker.origin + (0, 0, 50), marker.origin + (0, 0, -100), false, marker);
  marker.origin = trace["position"] + (0, 0, 50);

  marker Hide();
  marker ShowToPlayer(owner);
  marker childthread monitorMarkerVisibility(owner);

  self thread showFX();
  self thread watchAirdropUse();
  self thread watchJuggernautUse();
  switch (self.odinType) {
    case "odin_support":
      self thread watchSmokeUse();
      self thread watchMarkingUse();
      break;
    case "odin_assault":
      self thread watchLargeRodUse();
      self thread watchSmallRodUse();
      break;
  }

  self SetOtherEnt(marker);
}

monitorMarkerVisibility(owner) {
  wait(1.5);

  prev_players_watching = [];
  while(1) {
    current_players_watching = owner get_players_watching();
    foreach(player in prev_players_watching) {
      if(!array_contains(current_players_watching, player)) {
        prev_players_watching = array_remove(prev_players_watching, player);

        self Hide();
        self ShowToPlayer(owner);
      }
    }

    foreach(player in current_players_watching) {
      self ShowToPlayer(player);

      if(!array_contains(prev_players_watching, player)) {
        prev_players_watching = array_add(prev_players_watching, player);
        stopFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
        wait(0.05);

        playFXOnTag(level._effect["odin_targeting"], self, "tag_origin");
      }
    }

    wait(0.25);
  }
}

watchAirdropUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  weaponStruct = level.odinSettings[self.odinType].weapon["airdrop"];

  self.odin_airdropUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("airdrop_action", "+smoke");
  }

  while(true) {
    owner waittill("airdrop_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_airdropUseTime) {
      if(level.teamBased) {
        leaderDialog(weaponStruct.voAirdrop, self.team);
      } else {
        owner leaderDialogOnPlayer(weaponStruct.voAirdrop);
      }

      self.odin_airdropUseTime = self odin_fireWeapon("airdrop");
      weaponStruct = level.odinSettings[self.odinType].weapon["airdrop"];
      level thread maps\mp\killstreaks\_airdrop::doFlyBy(owner, self.targeting_marker.origin, randomFloat(360), weaponStruct.airdropType);
    } else
      owner _playLocalSound("odin_negative_action");

    wait(1.0);
  }
}

watchSmokeUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  weaponStruct = level.odinSettings[self.odinType].weapon["smoke"];

  self.odin_smokeUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("smoke_action", "+speed_throw");
    owner NotifyOnPlayerCommand("smoke_action", "+ads_akimbo_accessible");
    if(!level.console) {
      owner NotifyOnPlayerCommand("smoke_action", "+toggleads_throw");
    }
  }

  while(true) {
    owner waittill("smoke_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_smokeUseTime) {
      if(level.teamBased) {
        leaderDialog(weaponStruct.voSmoke, self.team);
      } else {
        owner leaderDialogOnPlayer(weaponStruct.voSmoke);
      }

      self.odin_smokeUseTime = self odin_fireWeapon("smoke");
    } else
      owner _playLocalSound("odin_negative_action");

    wait(1.0);
  }
}

watchMarkingUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  weaponStruct = level.odinSettings[self.odinType].weapon["marking"];

  self.odin_markingUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("marking_action", "+attack");
    owner NotifyOnPlayerCommand("marking_action", "+attack_akimbo_accessible");
  }

  while(true) {
    owner waittill("marking_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_markingUseTime) {
      self.odin_markingUseTime = self odin_fireWeapon("marking");
      self thread doMarkingFlash(self.targeting_marker.origin + (0, 0, 10));
    } else
      owner _playLocalSound("odin_negative_action");

    wait(1.0);
  }
}

watchJuggernautUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");
  owner endon("juggernaut_dead");

  weaponStruct = level.odinSettings[self.odinType].weapon["juggernaut"];

  self.odin_juggernautUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("juggernaut_action", "+frag");
  }

  while(true) {
    owner waittill("juggernaut_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_juggernautUseTime) {
      node = getJuggStartingPathNode(self.targeting_marker.origin);
      if(isDefined(node)) {
        self.odin_juggernautUseTime = self odin_fireWeapon("juggernaut");
        self thread waitAndSpawnJugg(node);
      } else
        owner _playLocalSound("odin_negative_action");
    } else if(isDefined(self.juggernaut)) {
      node = getJuggMovingPathNode(self.targeting_marker.origin);
      if(isDefined(node)) {
        owner leaderDialogOnPlayer(weaponStruct.voJugg);
        owner _playLocalSound("odin_positive_action");
        owner PlayRumbleOnEntity("pistol_fire");
        self.juggernaut maps\mp\bots\_bots_strategy::bot_protect_point(node.origin, 128);
        owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);
      } else
        owner _playLocalSound("odin_negative_action");
    }

    wait(1.1);

    if(isDefined(self.juggernaut)) {
      owner SetClientOmnvar(weaponStruct.ammoOmnvar, weaponStruct.ui_num_move);
    }
  }
}

watchLargeRodUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  weaponStruct = level.odinSettings[self.odinType].weapon["large_rod"];

  self.odin_LargeRodUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("large_rod_action", "+attack");
    owner NotifyOnPlayerCommand("large_rod_action", "+attack_akimbo_accessible");
  }

  while(true) {
    owner waittill("large_rod_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_LargeRodUseTime) {
      self.odin_largeRodUseTime = self odin_fireWeapon("large_rod");
    } else
      owner _playLocalSound("odin_negative_action");

    wait(1.0);
  }
}

watchSmallRodUse() {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  weaponStruct = level.odinSettings[self.odinType].weapon["small_rod"];

  self.odin_smallRodUseTime = 0;
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, level.odinSettings[self.odinType].ui_num);

  if(!IsAI(owner)) {
    owner NotifyOnPlayerCommand("small_rod_action", "+speed_throw");
    owner NotifyOnPlayerCommand("small_rod_action", "+ads_akimbo_accessible");
    if(!level.console) {
      owner NotifyOnPlayerCommand("small_rod_action", "+toggleads_throw");
    }
  }

  while(true) {
    owner waittill("small_rod_action");
    if(isDefined(level.hostMigrationTimer)) {
      continue;
    }
    if(!isDefined(owner.odin)) {
      return;
    }
    if(GetTime() >= self.odin_smallRodUseTime) {
      self.odin_smallRodUseTime = self odin_fireWeapon("small_rod");
    } else
      owner _playLocalSound("odin_negative_action");

    wait(1.0);
  }
}

odin_fireWeapon(weaponType) {
  self.is_firing = true;

  owner = self.owner;
  weaponStruct = level.odinSettings[self.odinType].weapon[weaponType];

  forward_dir = anglesToForward(owner GetPlayerAngles());
  start = self.origin + (forward_dir * 100);
  owner SetClientOmnvar(weaponStruct.ammoOmnvar, weaponStruct.ui_num_fired);
  self thread watchReload(weaponStruct);
  target_pos = self.targeting_marker.origin;
  reload_time = (GetTime() + (weaponStruct.reloadTimer * 1000));

  if(weaponType == "large_rod") {
    wait(0.5);
    owner PlayRumbleOnEntity(weaponStruct.rumble);
    Earthquake(0.3, 1.5, self.origin, 1000);
    owner PlaySoundToPlayer(weaponStruct.plr_fire_sound, owner);
    playSoundAtPos(self.origin, weaponStruct.npc_fire_sound);
    wait(1.5);
  } else if(weaponType == "small_rod") {
    wait(0.5);
    owner PlayRumbleOnEntity(weaponStruct.rumble);
    Earthquake(0.2, 1, self.origin, 1000);
    owner PlaySoundToPlayer(weaponStruct.plr_fire_sound, owner);
    playSoundAtPos(self.origin, weaponStruct.npc_fire_sound);
    wait(0.3);
  } else {
    if(isDefined(weaponStruct.plr_fire_sound)) {
      owner PlaySoundToPlayer(weaponStruct.plr_fire_sound, owner);
    }
    if(isDefined(weaponStruct.npc_fire_sound)) {
      playSoundAtPos(self.origin, weaponStruct.npc_fire_sound);
    }
    owner PlayRumbleOnEntity(weaponStruct.rumble);
  }

  projectile = MagicBullet(weaponStruct.projectile, start, target_pos, owner);
  projectile.type = "odin";
  projectile thread watchExplosion(weaponType);

  if(weaponType == "smoke" || weaponType == "juggernaut" || weaponType == "large_rod") {
    level notify("smoke", projectile, weaponStruct.projectile);
  }

  self.is_firing = undefined;

  return reload_time;
}

watchExplosion(weaponType) {
  self waittill("explode", position);

  if(weaponType == "small_rod") {
    PlayRumbleOnPosition("grenade_rumble", position);
    Earthquake(0.7, 1.0, position, 1000);
  } else if(weaponType == "large_rod") {
    PlayRumbleOnPosition("artillery_rumble", position);
    Earthquake(1.0, 1.0, position, 2000);
  }
}

getJuggStartingPathNode(pos) {
  if(!isDefined(pos)) {
    return;
  }
  nearestPathNode = GetNodesInRadiusSorted(pos, 256, 0, 128, "Path");
  if(!isDefined(nearestPathNode[0])) {
    return;
  }
  return nearestPathNode[0];
}

getJuggMovingPathNode(pos) {
  if(!isDefined(pos)) {
    return;
  }
  nearestPathNode = GetNodesInRadiusSorted(pos, 128, 0, 64, "Path");
  if(!isDefined(nearestPathNode[0])) {
    return;
  }
  return nearestPathNode[0];
}

waitAndSpawnJugg(nearestPathNode) {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");

  pos = self.targeting_marker.origin;

  wait(3.0);

  agent = maps\mp\agents\_agents::add_humanoid_agent("odin_juggernaut", owner.team, "class1", nearestPathNode.origin, VectorToAngles(pos - nearestPathNode.origin), owner, false, false, "veteran");

  if(isDefined(agent)) {
    weaponStruct = level.odinSettings[self.odinType].weapon["juggernaut"];
    agent thread maps\mp\killstreaks\_juggernaut::giveJuggernaut(weaponStruct.juggType);
    agent thread maps\mp\killstreaks\_agent_killstreak::sendAgentWeaponNotify();

    agent maps\mp\bots\_bots_strategy::bot_protect_point(nearestPathNode.origin, 128);
    self.juggernaut = agent;
    self thread watchJuggernautDeath();

    owner SetClientOmnvar(weaponStruct.ammoOmnvar, weaponStruct.ui_num_move);

    id = outlineEnableForPlayer(agent, "cyan", self.owner, false, "killstreak");
    self thread removeOutline(id, agent);

    agent _setNameplateMaterial("player_name_bg_green_agent", "player_name_bg_red_agent");
  } else {
    owner iPrintLnBold(&"KILLSTREAKS_AGENT_MAX");
  }
}

watchJuggernautDeath() {
  self endon("death");
  level endon("game_ended");

  self.juggernaut waittill("death");

  self.owner notify("juggernaut_dead");
  weaponStruct = level.odinSettings[self.odinType].weapon["juggernaut"];
  self.owner SetClientOmnvar(weaponStruct.ammoOmnvar, weaponStruct.ui_num_dead);

  self.juggernaut = undefined;
}

showFX() {
  self endon("death");
  wait(1.0);
  playFXOnTag(level._effect["odin_targeting"], self.targeting_marker, "tag_origin");
}

watchReload(weaponStruct) {
  self endon("death");
  level endon("game_ended");

  owner = self.owner;
  owner endon("disconnect");
  owner endon("odin_ride_ended");

  dvar = weaponStruct.ammoOmnvar;
  time = weaponStruct.reloadTimer;
  plr_ready_sound = weaponStruct.plr_ready_sound;
  ui_num = level.odinSettings[self.odinType].ui_num;

  wait(time);

  if(!isDefined(owner.odin)) {
    return;
  }
  if(isDefined(plr_ready_sound)) {
    owner _playLocalSound(plr_ready_sound);
  }
  owner SetClientOmnvar(dvar, ui_num);
}

doMarkingFlash(pos) {
  level endon("game_ended");

  attacker = self.owner;

  radius_max_sq = level.odin_marking_flash_radius_max * level.odin_marking_flash_radius_max;
  radius_min_sq = level.odin_marking_flash_radius_min * level.odin_marking_flash_radius_min;

  viewHeightStanding = 60;
  viewHeightCrouching = 40;
  viewHeightProne = 11;

  num_marked = 0;
  foreach(player in level.participants) {
    if(!isReallyAlive(player) || player.sessionstate != "playing") {
      continue;
    }
    if(level.teamBased && player.team == self.team) {
      continue;
    }
    dist = DistanceSquared(pos, player.origin);
    if(dist > radius_max_sq) {
      continue;
    }
    stance = player GetStance();
    viewOrigin = player.origin;
    switch (stance) {
      case "stand":
        viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightStanding);
        break;
      case "crouch":
        viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightCrouching);
        break;
      case "prone":
        viewOrigin = (viewOrigin[0], viewOrigin[1], viewOrigin[2] + viewHeightProne);
        break;
    }

    if(!BulletTracePassed(pos, viewOrigin, false, player)) {
      continue;
    }
    if(dist <= radius_min_sq) {
      percent_distance = 1.0;
    } else {
      percent_distance = 1.0 - (dist - radius_min_sq) / (radius_max_sq - radius_min_sq);
    }

    forward = anglesToForward(player GetPlayerAngles());

    toBlast = pos - viewOrigin;
    toBlast = VectorNormalize(toBlast);

    percent_angle = 0.5 * (1.0 + VectorDot(forward, toBlast));

    extra_duration = 1;
    player notify("flashbang", pos, percent_distance, percent_angle, attacker, extra_duration);
    num_marked++;

    if(!enemyNotAffectedByOdinOutline(player)) {
      if(level.teamBased) {
        id = outlineEnableForTeam(player, "orange", self.team, false, "killstreak");
      } else {
        id = outlineEnableForPlayer(player, "orange", self.owner, false, "killstreak");
      }
      self thread removeOutline(id, player, 3.0);
    }
  }

  weaponStruct = level.odinSettings[self.odinType].weapon["marking"];
  if(num_marked == 1) {
    if(level.teamBased) {
      leaderDialog(weaponStruct.voMarkedSingle, self.team);
    } else {
      attacker leaderDialogOnPlayer(weaponStruct.voMarkedSingle);
    }
  } else if(num_marked > 1) {
    if(level.teamBased) {
      leaderDialog(weaponStruct.voMarkedMulti, self.team);
    } else {
      attacker leaderDialogOnPlayer(weaponStruct.voMarkedMulti);
    }
  }

  ents = maps\mp\gametypes\_weapons::getEMPDamageEnts(pos, 512, false);

  foreach(ent in ents) {
    if(isDefined(ent.owner) && !maps\mp\gametypes\_weapons::friendlyFireCheck(self.owner, ent.owner)) {
      continue;
    }
    ent notify("emp_damage", self.owner, 8.0);
  }
}

applyOutline(player) {
  if(level.teamBased && player.team == self.team) {
    return;
  } else if(!level.teamBased && player == self.owner) {
    return;
  }
  if(enemyNotAffectedByOdinOutline(player)) {
    return;
  }
  id = outlineEnableForPlayer(player, "orange", self.owner, true, "killstreak");
  self thread removeOutline(id, player);
}

enemyNotAffectedByOdinOutline(enemy) {
  return enemy _hasPerk("specialty_noplayertarget");
}

removeOutline(id, ent, time_out) {
  if(isDefined(ent)) {
    ent endon("disconnect");
  }
  level endon("game_ended");

  wait_array = ["leave", "death"];
  if(isDefined(time_out)) {
    self waittill_any_in_array_or_timeout_no_endon_death(wait_array, time_out);
  } else {
    self waittill_any_in_array_return_no_endon_death(wait_array);
  }

  if(isDefined(ent)) {
    outlineDisable(id, ent);
  }
}

odin_watchOutlines() {
  self endon("death");
  level endon("game_ended");

  foreach(player in level.participants) {
    self applyOutline(player);
  }
}

odin_watchPlayerKilled() {
  self endon("death");
  level endon("game_ended");

  self.enemiesKilledInTimeWindow = 0;

  while(true) {
    level waittill("odin_killed_player", victim);

    self.enemiesKilledInTimeWindow++;
    self notify("odin_enemy_killed");
  }
}

odin_dialog_killed_player(victim) {
  self endon("death");
  level endon("game_ended");

  config = level.odinSettings[self.odinType];

  time_window = 1.0;
  while(true) {
    self waittill("odin_enemy_killed");
    wait(time_window);

    if(self.enemiesKilledInTimeWindow > 1) {
      self.owner leaderDialogOnPlayer(config.voKillMulti);
    } else {
      self.owner leaderDialogOnPlayer(config.voKillSingle);
    }

    self.enemiesKilledInTimeWindow = 0;
  }
}

odin_onPlayerConnect() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    player thread odin_onPlayerSpawned(self);
  }
}

odin_onPlayerSpawned(odin) {
  self endon("disconnect");

  self waittill("spawned_player");
  odin applyOutline(self);
}

cleanup_ents() {
  if(isDefined(self.targeting_marker)) {
    self.targeting_marker delete();
  }
  if(isDefined(self.odin_overlay_ent)) {
    self.odin_overlay_ent delete();
  }
}

watchEarlyExit(odin) {
  level endon("game_ended");
  odin endon("death");

  odin thread maps\mp\killstreaks\_killstreaks::allowRideKillstreakPlayerExit();

  odin waittill("killstreakExit");
  config = level.odinSettings[odin.odinType];
  leaderDialog(config.voTimedOut);

  odin notify("death");
}