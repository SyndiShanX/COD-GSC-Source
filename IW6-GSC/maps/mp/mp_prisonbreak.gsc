/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_prisonbreak.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\mp_prisonbreak_precache::main();
  maps\createart\mp_prisonbreak_art::main();
  maps\mp\mp_prisonbreak_fx::main();

  level thread log_piles();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_prisonbreak");

  setdvar("r_reactiveMotionWindAmplitudeScale", .3);
  setdvar("r_reactiveMotionWindFrequencyScale", .5);

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_diffusecolorscale", 1.5, 1.8);
  setdvar_cg_ng("r_specularcolorscale", 3.0, 6.0);
  SetDvar("r_ssaofadedepth", 1089);
  SetDvar("r_ssaorejectdepth", 1200);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else if(level.xenon) {
    setdvar("sm_sunShadowScale", "0.7");
  }

  if(level.ps4) {
    setdvar("sm_sunSampleSizeNear", 0.33);
  } else if(level.xb3) {
    setdvar("sm_sunSampleSizeNear", 0.38);
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.gametype == "sd" ||
    level.gameType == "sr") {
    level.srKillCamOverridePosition = [];
    level.srKillCamOverridePosition["_a"] = (-1158, 952, 1139);

    level thread setOnBombTimerEnd();
  }

  level thread tree_bridges();
  level thread falling_rocks();
  level thread initPatchModels();
}

initPatchModels() {
  blackThing1 = spawn("script_model", (-74, 120, 1038));
  blackThing1 setModel("defaultvehicle");
  blackThing1.angles = (359.24, 258.983, -8.0374);

  collision1 = GetEnt("clip128x128x128", "targetname");
  collision1Ent = spawn("script_model", (1112, 1859.07, 949.574));
  collision1Ent.angles = (0, 325, 45);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);
}

setOnBombTimerEnd() {
  level endon("game_ended");

  level.sd_onBombTimerEnd = ::onBombTimerEnd;

  level waittill("bomb_planted", destroyedObj);

  if(destroyedObj maps\mp\gametypes\_gameobjects::getLabel() == "_b") {
    level.sd_onBombTimerEnd = undefined;
  }
}

onBombTimerEnd() {
  door1 = getEnt("prisondoor1", "targetname");
  door2 = getEnt("prisondoor2", "targetname");

  door1 RotateYaw(-70, 0.5);
  door1 playSound("scn_prison_gate_right");
  door2 RotateYaw(70, 0.5);
  door1 playSound("scn_prison_gate_left");

  wait(1);
  level notify("sd_free_prisoners");
}

initPrisoners() {
  initPrisonerLoadout();

  level.sd_prisonerObjective = getEnt("sd_prisonerObjective", "targetname");

  wait(3);

  level.bot_funcs["think"] = maps\mp\gametypes\_globallogic::blank;

  spawnPoints = getEntArray("mp_spawn", "classname");
  foreach(spawnPoint in spawnPoints) {
    level thread createPrisoner(spawnPoint);
  }
}

createPrisoner(spawnPoint) {
  bot = AddTestClient();
  bot.pers["isBot"] = true;
  bot.equipment_enabled = true;
  bot.bot_team = game["attackers"];

  while(!isDefined(bot.pers["team"])) {
    wait(0.05);
  }

  bot notify("menuresponse", game["menu_team"], game["attackers"]);
  wait(0.5);

  bot.pers["gamemodeLoadout"] = level.sd_loadouts["prisoner"];

  spawnPoint.playerSpawnPos = spawnPoint.origin;
  spawnPoint.notTI = true;
  bot.setSpawnPoint = spawnPoint;

  bot notify("menuresponse", "changeclass", "gamemode");

  bot thread holdPrisoner();
}

holdPrisoner() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill("spawned_player");

  gameFlagWait("prematch_done");

  self _disableWeapon();
  anchor = spawn("script_origin", self.origin);
  self playerLinkTo(anchor);

  level waittill("sd_free_prisoners");

  self unlink();

  anchor delete();

  while(true) {
    self BotClearScriptGoal();
    self BotSetScriptGoal(level.sd_prisonerObjective.origin, 64, "critical");

    msg = self waittill_any_return("goal", "bad_path");
    if(msg == "goal") {
      break;
    }

    wait(0.05);
  }
}

initPrisonerLoadout() {
  level.sd_loadouts["prisoner"]["loadoutPrimary"] = "none";
  level.sd_loadouts["prisoner"]["loadoutPrimaryAttachment"] = "none";
  level.sd_loadouts["prisoner"]["loadoutPrimaryAttachment2"] = "none";
  level.sd_loadouts["prisoner"]["loadoutPrimaryBuff"] = "specialty_null";
  level.sd_loadouts["prisoner"]["loadoutPrimaryCamo"] = "none";
  level.sd_loadouts["prisoner"]["loadoutPrimaryReticle"] = "none";

  level.sd_loadouts["prisoner"]["loadoutSecondary"] = "none";
  level.sd_loadouts["prisoner"]["loadoutSecondaryAttachment"] = "none";
  level.sd_loadouts["prisoner"]["loadoutSecondaryAttachment2"] = "none";
  level.sd_loadouts["prisoner"]["loadoutSecondaryBuff"] = "specialty_null";
  level.sd_loadouts["prisoner"]["loadoutSecondaryCamo"] = "none";
  level.sd_loadouts["prisoner"]["loadoutSecondaryReticle"] = "none";

  level.sd_loadouts["prisoner"]["loadoutEquipment"] = "specialty_null";
  level.sd_loadouts["prisoner"]["loadoutOffhand"] = "none";

  level.sd_loadouts["prisoner"]["loadoutPerk1"] = "specialty_null";
  level.sd_loadouts["prisoner"]["loadoutPerk2"] = "specialty_null";
  level.sd_loadouts["prisoner"]["loadoutPerk3"] = "specialty_null";

  level.sd_loadouts["prisoner"]["loadoutStreakType"] = "assault";
  level.sd_loadouts["prisoner"]["loadoutKillstreak1"] = "none";
  level.sd_loadouts["prisoner"]["loadoutKillstreak2"] = "none";
  level.sd_loadouts["prisoner"]["loadoutKillstreak3"] = "none";

  level.sd_loadouts["prisoner"]["loadoutDeathstreak"] = "specialty_null";

  level.sd_loadouts["prisoner"]["loadoutJuggernaut"] = false;
}

initInsertionVehicles() {
  level.sd_insertionVehicles = [];
  starts = getEntArray("sd_vehStart", "targetname");
  foreach(start in starts) {
    vehicle = spawn("script_model", start.origin);
    vehicle.origin = start.origin;
    vehicle.angles = start.angles;
    vehicle setModel("vehicle_hummer_open_top_noturret");

    path = [];
    waypoint = getEnt(start.target, "targetname");
    while(isDefined(waypoint)) {
      path[path.size] = waypoint;
      if(isDefined(waypoint.target)) {
        waypoint = getEnt(waypoint.target, "targetname");
      } else {
        break;
      }
    }

    level.sd_insertionVehicles[start.script_count] = spawnStruct();
    level.sd_insertionVehicles[start.script_count].index = start.script_count;
    level.sd_insertionVehicles[start.script_count].vehicle = vehicle;
    level.sd_insertionVehicles[start.script_count].start = start;
    level.sd_insertionVehicles[start.script_count].path = path;
    level.sd_insertionVehicles[start.script_count].driver = false;
    level.sd_insertionVehicles[start.script_count].passenger = false;
    level.sd_insertionVehicles[start.script_count].arrived = false;
  }

  level.sd_insertionStarted = undefined;
}

onAttackerspawn() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    if(game["state"] != "postgame" && player.pers["team"] == game["attackers"]) {
      player thread attackerRide();
    }
  }
}

attackerRide() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  self _disableWeapon();

  if(!isDefined(level.sd_insertionStarted)) {
    level.sd_insertionStarted = true;
    level thread startInsertionVehicles();
  }

  vehIndex = -1;
  isDriver = false;
  exitTag = "";
  vehicle = undefined;
  for(i = 0; i < level.sd_insertionVehicles.size; i++) {
    vehicle = level.sd_insertionVehicles[i].vehicle;
    if(!level.sd_insertionVehicles[i].driver) {
      vehIndex = i;
      isDriver = true;
      level.sd_insertionVehicles[i].driver = true;
      self playerLinkToDelta(vehicle, "tag_driver", 1, 30, 30, 30, 30, 1);
      self setStance("crouch");

      if(i == 2) {
        exitTag = "tag_walker3";
      } else {
        exitTag = "tag_walker0";
      }

      break;
    } else if(!level.sd_insertionVehicles[i].passenger) {
      vehIndex = i;
      level.sd_insertionVehicles[i].passenger = true;
      self playerLinkToDelta(vehicle, "tag_passenger", 1, 30, 30, 30, 30, 1);
      self setStance("crouch");

      if(i == 2) {
        exitTag = "tag_walker1";
      } else {
        exitTag = "tag_walker2";
      }

      break;
    }
  }
  if(vehIndex < 0) {
    assertMsg("Couldn't find seat for attacker in insertion vehicles!");
  }

  wait(0.05);
  while(!level.sd_insertionVehicles[vehIndex].arrived) {
    wait(0.05);
  }

  self unlink();
  self setStance("stand");

  carrier = spawn("script_model", self.origin);
  carrier.origin = self.origin;
  carrier.angles = self.angles;
  carrier setModel("tag_player");
  self playerLinkToDelta(carrier, "tag_player", 1, 30, 30, 30, 30, 1);

  exitPos = vehicle getTagOrigin(exitTag);
  exitAngles = vehicle getTagAngles(exitTag);
  time = distance(carrier.origin, exitPos) / 100;
  carrier moveTo(exitPos, time, time / 2, time / 2);
  carrier rotateTo(exitAngles, time, time / 2, time / 2);

  wait(time);
  self unlink();
  carrier delete();

  self _enableWeapon();

  if(isDriver) {
    level.sd_insertionVehicles[vehIndex].driver = false;
  } else {
    level.sd_insertionVehicles[vehIndex].passenger = false;
  }
}

startInsertionVehicles() {
  level endon("game_ended");

  for(i = 0; i < level.sd_insertionVehicles.size; i++) {
    level thread vehicleMove(i);
    wait(0.3);
  }
}

vehicleMove(vehicleIndex) {
  level endon("game_ended");

  gameFlagWait("prematch_done");

  vehicle = level.sd_insertionVehicles[vehicleIndex].vehicle;
  path = level.sd_insertionVehicles[vehicleIndex].path;

  for(i = 0; i < path.size; i++) {
    time = distance(vehicle.origin, path[i].origin) / 550;
    accelTime = 0;
    decelTime = 0;
    if(i == 0) {
      accelTime = time / 2;
    } else if(i == path.size - 1) {
      decelTime = time / 2;
    }

    vehicle moveTo(path[i].origin, time, accelTime, decelTime);
    vehicle rotateTo(path[i].angles, time);

    wait(time);
  }

  level.sd_insertionVehicles[vehicleIndex].arrived = true;
}

normalize_angles_180(angles) {
  return (angle_180(angles[0]), angle_180(angles[1]), angle_180(angles[2]));
}

angle_180(ang) {
  while(ang > 180) {
    ang -= 360;
  }
  while(ang < -180) {
    ang += 360;
  }
  return ang;
}

is_explosive(cause) {
  if(!isDefined(cause)) {
    return false;
  }

  cause = tolower(cause);
  switch (cause) {
    case "mod_grenade_splash":
    case "mod_projectile_splash":
    case "mod_explosive":
    case "splash":
      return true;
    default:
      return false;
  }
  return false;
}

trap_init(remove) {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  if(!isDefined(remove)) {
    remove = false;
  }

  targets = getEntArray(self.target, "targetname");

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "activate_trigger":
        if(remove) {
          target Delete();
        } else {
          self.activate_trigger = target;
        }
        break;
      case "use_model":
        if(remove) {
          target Delete();
        } else {
          self.use_model = target;
        }
        break;
      case "use_trigger":
        if(remove) {
          target Delete();
        } else {
          self.use_trigger = target;
        }
        break;
      default:
        break;
    }
  }

  if(isDefined(self.activate_trigger) && isDefined(self.use_model) && isDefined(self.use_trigger)) {
    self thread trap_use_watch();
    self thread trap_delete_visuals();
  }
}

trap_delete_visuals() {
  self waittill("trap_activated");

  foreach(vis in self.useObject.visuals) {
    vis Delete();
  }

  self.useObject.visuals = [];

  trap_set_can_use(false);
}

trap_use_watch() {
  wait .05;

  self.useObject = maps\mp\gametypes\_gameobjects::createUseObject("neutral", self.use_trigger, [self.use_model], (0, 0, 0));
  self.useObject.parent = self;

  self trap_set_can_use(true);
  self.useObject maps\mp\gametypes\_gameobjects::setUseTime(2.5);
  self.useObject maps\mp\gametypes\_gameobjects::setUseText(&"MP_SETTING_TRAP");
  self.useObject maps\mp\gametypes\_gameobjects::setUseHintText(&"MP_SET_TRAP");
  self.useObject maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
  self.useObject.onUse = ::trap_onUse;
}

trap_set_can_use(canUse) {
  if(canUse) {
    if(isDefined(self.use_icon_angles) && isDefined(self.use_icon_origin)) {
      self thread hand_icon("use", self.use_icon_origin, self.use_icon_angles, "trap_triggered");
    }

    if(isDefined(self.useObject) && isDefined(self.useObject.visuals)) {
      foreach(vis in self.useObject.visuals) {
        vis Hide();
      }

      self.useObject maps\mp\gametypes\_gameobjects::allowUse("any");
    }
  } else {
    if(isDefined(self.useObject) && isDefined(self.useObject.visuals)) {
      foreach(vis in self.useObject.visuals) {
        vis Show();
        vis setModel("mil_semtex_belt");
      }
      self.useObject maps\mp\gametypes\_gameobjects::allowUse("none");
    }
  }
}

trap_onUse(player) {
  self.parent trap_set_can_use(false);
  self.parent notify("trap_triggered");

  self.parent.owner = player;
  self.parent thread trap_owner_watch();
  self.parent thread trap_active_watch();
}

trap_owner_watch() {
  self endon("trap_activated");

  self.owner waittill("death");

  self trap_set_can_use(true);
}

trap_active_watch() {
  self endon("trap_activated");
  self.owner endon("death");

  while(1) {
    self.activate_trigger waittill("trigger", player);

    if(trap_can_player_trigger(player)) {
      break;
    }
  }

  self notify("trap_activated");
}

trap_can_player_trigger(player) {
  if(!isDefined(self.owner)) {
    return false;
  }

  if(IsAgent(player) && isDefined(player.owner) && isDefined(self.owner) && player.owner == self.owner) {
    return false;
  }

  if(!level.teamBased) {
    return player != self.owner;
  }

  if(player.team != self.owner.team) {
    return true;
  }

  return false;
}

tree_bridges() {
  PrecacheMpAnim("mp_prisonbreak_tree_fall");

  bridges = getstructarray("tree_bridge", "targetname");
  array_thread(bridges, ::tree_bridge_init);
}

tree_bridge_init() {
  self.tree = undefined;
  self.clip_up = undefined;
  self.clip_down = undefined;
  self.clip_up_delete = undefined;

  self.linked_ents = [];
  targets = getEntArray(self.target, "targetname");
  structs = getstructarray(self.target, "targetname");

  targets = array_combine(targets, structs);

  foreach(target_ent in targets) {
    if(!isDefined(target_ent.script_noteworthy)) {
      continue;
    }
    switch (target_ent.script_noteworthy) {
      case "the_tree":
        self.tree = target_ent;
        self thread tree_bridge_damage_watch(target_ent, false);
        break;
      case "clip_up_delete":
        self.clip_up_delete = target_ent;
        break;
      case "clip_up":
        self.clip_up = target_ent;
        self.linked_ents[self.linked_ents.size] = target_ent;
        break;
      case "clip_down":
        self.clip_down = target_ent;
        self.clip_down trigger_off();
        break;

      case "link":
        self.linked_ents[self.linked_ents.size] = target_ent;
        break;
      case "delete":
        self.decal = target_ent;
        break;
      case "killcam":
        self.killCamEnt = spawn("script_model", target_ent.origin);
        self.killCamEnt setModel("tag_origin");
        break;
      default:
        break;
    }
  }

  self.animated_prop = spawn("script_model", self.tree.origin);
  self.animated_prop setModel("generic_prop_raven");
  self.animated_prop.angles = self.tree.angles;

  self.tree LinkTo(self.animated_prop, "j_prop_2");

  foreach(ent in self.linked_ents) {
    ent LinkTo(self.tree);
  }

  self thread tree_bridge_run();
}

tree_bridge_damage_watch(watch_ent, delete_on_trigger) {
  self endon("tree_down");

  if(!isDefined(delete_on_trigger)) {
    delete_on_trigger = false;
  }

  large_health_value = 1000000;
  damage_needed_to_fall = 100;

  watch_ent.health = large_health_value;
  watch_ent setCanDamage(true);

  while(1) {
    watch_ent waittill("damage", amount, attacker, direction_vec, point, type);
    attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("tree");

    if(watch_ent.health < (large_health_value - damage_needed_to_fall)) {
      break;
    }
  }

  watch_ent setCanDamage(false);

  if(isDefined(self.tree)) {
    self.tree playSound("scn_prison_tree_fall");
  }

  if(delete_on_trigger) {
    watch_ent Delete();
  }

  self.attacker = attacker;
  self notify("tree_down");
}

#using_animtree("animated_props");
tree_bridge_run() {
  self waittill("tree_down");

  if(isDefined(self.decal)) {
    self.decal Delete();
  }

  if(isDefined(self.clip_up_delete)) {
    self.clip_up_delete Delete();
  }

  self.clip_up ConnectPaths();

  self.tree maps\mp\_movers::notify_moving_platform_invalid();
  self.animated_prop ScriptModelPlayAnimDeltaMotion("mp_prisonbreak_tree_fall");

  anim_length = GetAnimLength( % mp_prisonbreak_tree_fall);
  fall_time = anim_length - 0.3;

  sound_origin = GetEnt("tree_impact_sound_origin", "targetname");
  sound_origin delayThread(fall_time, ::PlaySound_wrapper, "scn_prison_tree_impact");

  wait(fall_time);

  self.clip_down trigger_on();
  self.clip_down DontInterpolate();
  self.clip_up maps\mp\_movers::notify_moving_platform_invalid();
  self.clip_up Delete();

  foreach(character in level.characters) {
    if(character IsTouching(self.clip_down) && IsAlive(character)) {
      if(isDefined(self.attacker) && isDefined(self.attacker.team) && (self.attacker.team == character.team)) {
        character maps\mp\_movers::mover_suicide();
      } else {
        self.clip_down.killCamEnt = self.killCamEnt;
        character DoDamage(character.health + 500, character.origin, self.attacker, self.clip_down, "MOD_CRUSH");
      }
    }
  }

  foreach(vanguard in level.remote_uav) {
    if(vanguard IsTouching(self.clip_down)) {
      vanguard notify("death");
    }
  }

  clip_base = getent("tree_base_clip", "targetname");
  if(isDefined(clip_base)) {
    clip_base Delete();
  }
}

PlaySound_wrapper(alias) {
  self playSound(alias);
}

log_piles() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  log_piles_precache();

  wait .05;

  piles = getstructArray("logpile", "targetname");
  array_thread(piles, ::log_pile_init);
}

log_piles_precache() {
  level.log_visual_link_joints = [];
  level.log_visual_link_joints["ten_log_roll"] = "j_log_5";

  level.log_anim_lengths = [];
  level.log_anim_lengths["ten_log_roll"] = GetAnimLength( % mp_prisonbreak_log_roll);

  level.log_anims = [];
  level.log_anims["ten_log_roll"] = "mp_prisonbreak_log_roll";
  foreach(key, value in level.log_anims) {
    PrecacheMpAnim(value);
  }
}

log_pile_init() {
  self.logs = [];
  self.animated_logs = [];
  self.log_supports = [];
  self.log_supports_broken = [];
  self.clip_delete = [];
  self.clip_show = [];
  self.clip_move = [];
  self.kill_trigger = undefined;
  self.kill_trigger_linked = [];

  link_visuals_to = undefined;
  link_visuals_to_tag = undefined;

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  targets = getEntArray(self.target, "targetname");
  targets = array_combine(targets, getstructarray(self.target, "targetname"));

  foreach(target_ent in targets) {
    if(!isDefined(target_ent.script_noteworthy)) {
      continue;
    }
    switch (target_ent.script_noteworthy) {
      case "log_with_use_visuals":
        link_visuals_to = target_ent;

      case "log":
        self.logs[self.logs.size] = target_ent;
        if(isDefined(target_ent.target)) {
          target_ent.endpos = getstruct(target_ent.target, "targetname");
        }
        break;
      case "animated_log_use_visuals":
        link_visuals_to = target_ent;
        if(isDefined(target_ent.script_animation)) {
          link_visuals_to_tag = level.log_visual_link_joints[target_ent.script_animation];
        }
        self thread log_pile_support_damage_watch(target_ent);

      case "animated_log":
        if(isDefined(target_ent.script_animation) && isDefined(level.log_anims[target_ent.script_animation])) {
          self.animated_logs[self.animated_logs.size] = target_ent;
        }
        break;
      case "log_support":
        self.log_supports[self.log_supports.size] = target_ent;
        self thread log_pile_support_damage_watch(target_ent);
        break;
      case "log_support_broken":
        self.log_supports_broken[self.log_supports_broken.size] = target_ent;
        target_ent Hide();
        break;
      case "clip_delete":
        self.clip_delete[self.clip_delete.size] = target_ent;
        break;
      case "clip_move":

        if(isDefined(target_ent.target)) {
          target_ent.end_pos = getstruct(target_ent.target, "targetname");
          if(isDefined(target_ent.end_pos) && isDefined(target_ent.end_pos.target)) {
            target_ent.start_pos = getstruct(target_ent.end_pos.target, "targetname");
            if(isDefined(target_ent.start_pos)) {
              target_ent.move_delta = target_ent.end_pos.origin - target_ent.start_pos.origin;
              if(target_ent is_dynamic_path()) {
                target_ent ConnectPaths();
              }
              target_ent.origin = target_ent.origin - target_ent.move_delta;
              self.clip_move[self.clip_move.size] = target_ent;
            }
          }
        }
        break;
      case "clip_show":
        self.clip_show[self.clip_show.size] = target_ent;
        target_ent Hide();
        target_ent NotSolid();
        break;
      case "kill_trigger":
        self.kill_trigger = target_ent;
        if(isDefined(self.kill_trigger.target)) {
          self.kill_trigger.start_pos = getstruct(self.kill_trigger.target, "targetname");
          if(isDefined(self.kill_trigger.start_pos) && isDefined(self.kill_trigger.start_pos.target)) {
            self.kill_trigger.end_pos = getstruct(self.kill_trigger.start_pos.target, "targetname");
            if(isDefined(self.kill_trigger.end_pos)) {
              self.kill_trigger.script_mover = spawn("script_model", self.kill_trigger.start_pos.origin);
              self.kill_trigger.script_mover setModel("tag_origin");

              self.kill_trigger EnableLinkTo();
              self.kill_trigger LinkTo(self.kill_trigger.script_mover, "tag_origin");
            }
          }
        }
        break;
      case "kill_trigger_link":
        self.kill_trigger_linked[self.kill_trigger_linked.size] = target_ent;
        break;
      case "use_icon":
        self.use_icon_origin = target_ent.origin;
        self.use_icon_angles = target_ent.angles;
        break;
      case "killcam":
        self.killCamEnt = spawn("script_model", target_ent.origin);
        self.killCamEnt setModel("tag_origin");
      default:
        break;
    }
  }

  if(isDefined(self.kill_trigger) && isDefined(self.kill_trigger.script_mover)) {
    if(isDefined(self.killCamEnt)) {
      self.kill_trigger.script_mover.killCamEnt = self.killCamEnt;
    } else {
      self.kill_trigger.script_mover.killCamEnt = self.kill_trigger.script_mover;
    }
  }

  if(isDefined(link_visuals_to)) {
    foreach(linked_kill_trigger in self.kill_trigger_linked) {
      linked_kill_trigger.killCamEnt = self.killCamEnt;

      linked_kill_trigger EnableLinkTo();
      linked_kill_trigger.no_moving_platfrom_unlink = true;
      linked_kill_trigger linkTo(link_visuals_to, linked_kill_trigger.script_parameters);
    }
  }

  self.nodes = GetNodeArray(self.target, "targetname");
  foreach(node in self.nodes) {
    node DisconnectNode();
  }

  if((self.logs.size || self.animated_logs.size) && self.log_supports.size > 0) {
    self thread log_pile_run();
    self thread trap_init();
  }

  if(isDefined(link_visuals_to) && isDefined(self.use_model)) {
    if(isDefined(link_visuals_to_tag)) {
      self.use_model LinkTo(link_visuals_to, link_visuals_to_tag);
    } else {
      self.use_model LinkTo(link_visuals_to);
    }
  }
}

log_pile_support_damage_watch(log_support) {
  self endon("trap_activated");

  large_health_value = 1000000;

  log_support.health = large_health_value;
  log_support setCanDamage(true);

  while(1) {
    log_support waittill("damage", amount, attacker, direction_vec, point, type);

    log_support.health = large_health_value;
    if(is_explosive(type) && amount >= 10) {
      self.owner = attacker;
      break;
    }
  }

  log_support setCanDamage(false);

  self notify("trap_activated");
}

log_pile_run() {
  self waittill("trap_activated");

  self trap_set_can_use(false);

  log_roll_time = 2.3;
  self thread log_pile_kill_trigger(self.kill_trigger);
  foreach(kill_trig in self.kill_trigger_linked) {
    self thread log_pile_kill_trigger(kill_trig);
  }
  self thread log_pile_kill_trigger_end(log_roll_time);

  array_thread(self.log_supports, maps\mp\_movers::notify_moving_platform_invalid);
  array_call(self.log_supports, ::Delete);
  array_call(self.log_supports_broken, ::Show);
  array_thread(self.clip_delete, maps\mp\_movers::notify_moving_platform_invalid);
  array_call(self.clip_delete, ::Delete);
  array_call(self.clip_show, ::Show);
  array_call(self.clip_show, ::Solid);

  foreach(clip_move in self.clip_move) {
    if(clip_move is_dynamic_path()) {
      clip_move delayCall(log_roll_time, ::DisconnectPaths);
    }

    clip_move thread log_pile_clip_move(1.5, 0.5);
  }

  if(isDefined(self.kill_trigger) && isDefined(self.kill_trigger.script_mover)) {
    self.kill_trigger.script_mover MoveTo(self.kill_trigger.end_pos.origin, log_roll_time, log_roll_time * .5, 0);
  }

  foreach(log in self.logs) {
    if(isDefined(log.endpos)) {
      log MoveTo(log.endpos.origin, log_roll_time, log_roll_time * .5, 0);

      delta_angles = log.endpos.angles - log.angles;
      delta_angles = normalize_angles_180(delta_angles);
      delta_angles += (4 * 360, 0, 0);
      vel = delta_angles / log_roll_time;
      log RotateVelocity(vel, log_roll_time, log_roll_time * .5, 0);
    }
  }

  foreach(animated_log in self.animated_logs) {
    animated_log maps\mp\_movers::notify_moving_platform_invalid();
    animated_log ScriptModelPlayAnimDeltaMotion(level.log_anims[animated_log.script_animation]);

    throw_vec = (-20000, 0, 9000);
    offset = (0, 0, 50);
    delete_volume = GetEnt("care_package_delete_volume", "targetname");

    maps\mp\killstreaks\_airdrop::throw_linked_care_packages(animated_log, offset, throw_vec, delete_volume);

    anim_length = level.log_anim_lengths[animated_log.script_animation];
    if(isDefined(anim_length) && anim_length > log_roll_time) {
      log_roll_time = anim_length;
    }
  }

  if(isDefined(self.animated_logs) && (self.animated_logs.size > 0)) {
    self.animated_logs[0] PlaySoundOnMovingEnt("scn_prison_logtrap_logs_roll");
  }

  wait log_roll_time;

  self notify("log_roll_done");

  wait .05;
  foreach(node in self.nodes) {
    node ConnectNode();
  }

}

log_pile_clip_move(delay_time, move_time) {
  wait(delay_time);
  self MoveTo(self.origin + self.move_delta, move_time);
}

log_pile_kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }
  self endon("log_roll_end_kill_trigger");
  while(1) {
    trigger waittill("trigger", player);

    if(!log_pile_can_damage_player(player)) {
      continue;
    }
    inflictor = trigger;
    if(isDefined(trigger.script_mover)) {
      inflictor = trigger.script_mover;
    }

    attacker = self.owner;
    if(IsAgent(player) && isDefined(player.owner) && isDefined(attacker) && (player.owner == attacker)) {
      player maps\mp\_movers::mover_suicide();
    } else {
      inflictor.killCamEnt = self.killCamEnt;
      inflictor RadiusDamage(player.origin, 8, 1000, 1000, attacker, "MOD_CRUSH", "none");
    }
  }
}

log_pile_kill_trigger_end(waitTime) {
  wait waitTime;
  self notify("log_roll_end_kill_trigger");
}

log_pile_can_damage_player(player) {
  return true;
}

falling_rocks() {
  rocks = getEntArray("falling_rock", "targetname");
  array_thread(rocks, ::falling_rock_init);
}

falling_rock_init() {
  self.fall_to = [];
  self.clip_move = [];

  targets = getEntArray(self.target, "targetname");
  structs = getstructarray(self.target, "targetname");

  targets = array_combine(targets, structs);
  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "kill_trigger":
        target EnableLinkTo();
        target LinkTo(self);
        self.kill_trigger = target;
        break;
      case "rock_clip":
        target LinkTo(self);
        self.clip = target;
        break;
      case "fall_to":
        self.fall_to[self.fall_to.size] = target;
        target.fall_dist = Distance(self.origin, target.origin);
        self.fall_dist = target.fall_dist;

        while(isDefined(target.target)) {
          prev_target = target;
          target = getstruct(target.target, "targetname");
          if(!isDefined(target)) {
            break;
          }

          self.fall_to[self.fall_to.size] = target;
          target.fall_dist = Distance(prev_target.origin, target.origin);
          self.fall_dist += target.fall_dist;
        }
        break;

      case "clip_move":

        if(isDefined(target.target)) {
          target.end_pos = getstruct(target.target, "targetname");
          if(isDefined(target.end_pos) && isDefined(target.end_pos.target)) {
            target.start_pos = getstruct(target.end_pos.target, "targetname");
            if(isDefined(target.start_pos)) {
              target.move_delta = target.end_pos.origin - target.start_pos.origin;
              target.origin = target.origin - target.move_delta;
              if(target is_dynamic_path()) {
                target ConnectPaths();
              }
              self.clip_move[self.clip_move.size] = target;
            }
          }
        }
        break;
      default:
        break;
    }
  }

  self thread falling_rock_damage_watch();
  self thread falling_rock_run();
}

is_dynamic_path() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

falling_rock_damage_watch() {
  large_health_value = 1000000;

  self.health = large_health_value;
  self setCanDamage(true);

  while(1) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    self.health = large_health_value;
    if(is_explosive(type)) {
      self.attacker = attacker;
      break;
    }
  }

  self setCanDamage(false);

  self notify("rock_fall");
}

falling_rock_run() {
  self waittill("rock_fall");

  fall_time = 1.0;

  self thread falling_rock_kill_trigger();

  accel = 1;
  for(i = 0; i < self.fall_to.size; i++) {
    next = self.fall_to[i];

    time = (next.fall_dist / self.fall_dist) * fall_time;

    self MoveTo(next.origin, time, time * accel, 0);
    self RotateTo(next.angles, time, time * accel, 0);

    if(i == self.fall_to.size - 1) {
      foreach(clip_move in self.clip_move) {
        if(clip_move is_dynamic_path()) {
          clip_move delayCall(time, ::DisconnectPaths);
        }
        clip_move MoveTo(clip_move.origin + clip_move.move_delta, time);
      }
    }

    self waittill("movedone");
    accel = 0;
  }

  self notify("rock_move_done");
  self.clip Delete();
  self.kill_trigger Delete();
}

falling_rock_kill_trigger() {
  self endon("death");
  self endon("rock_move_done");

  while(1) {
    self.kill_trigger waittill("trigger", player);

    RadiusDamage(player.origin, 8, 1000, 1000, self.attacker, "MOD_CRUSH");
  }

}

rock_slides() {
  rock_slides_precache();

  wait .05;
  rocks = getStructArray("rock_slide", "targetname");
  array_thread(rocks, ::rock_slides_init);
}

rock_slides_

rock_slides_init() {
  self.ground_ents = [];
  self.rocks = [];

  targets = getEntArray(self.target, "targetname");

  remove = true;

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "ground":
        if(isDefined(target.target) && !remove) {
          target.start_pos = getstruct(target.target, "targetname");
          if(isDefined(target.start_pos) && isDefined(target.start_pos.target)) {
            target.end_pos = getstruct(target.start_pos.target, "targetname");
            if(isDefined(target.end_pos)) {
              target.move_ent = spawn("script_model", target.start_pos.origin);
              target.move_ent setModel("tag_origin");
              target.move_ent.angles = target.start_pos.angles;
              target LinkTo(target.move_ent);
              self.ground_ents[self.ground_ents.size] = target;
              target.move_delete = isDefined(target.end_pos.script_noteworthy) && target.end_pos.script_noteworthy == "delete";
            }
          }
        }
        break;
      case "rock":
        if(remove) {
          target Delete();
        } else {
          target.end_pos = getstruct(target.target, "targetname");
          if(isDefined(target.end_pos)) {
            self.rocks[self.rocks.size] = target;
            target.move_delete = isDefined(target.end_pos.script_noteworthy) && target.end_pos.script_noteworthy == "delete";
          }
        }

        break;
      default:
        break;
    }
  }

  if(!remove) {
    array_thread(self.ground_ents, ::rock_slide_damage_watch, self);
    self thread rock_slide_run();
  }
  self thread trap_init(remove);
}

rock_slide_damage_watch(parent) {
  parent endon("trap_activated");

  large_health_value = 1000000;

  self.health = large_health_value;
  self setCanDamage(true);

  while(1) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    self.health = large_health_value;
    if(is_explosive(type)) {
      self.attacker = attacker;
      break;
    }
  }

  self setCanDamage(false);

  parent notify("trap_activated");
}

rock_slide_run() {
  self waittill("trap_activated");

  Earthquake(.4, 3, self.origin, 800);

  rock_time = 1.5;
  foreach(rock in self.rocks) {
    rock MoveTo(rock.end_pos.origin, rock_time, rock_time, 0);
    rock RotateTo(rock.end_pos.angles, rock_time, rock_time, 0);
    if(rock.move_delete) {
      rock delayCall(rock_time, ::delete);
    }
  }

  wait .5;

  slide_time = 1;
  foreach(ent in self.ground_ents) {
    ent.move_ent MoveTo(ent.end_pos.origin, slide_time, slide_time, 0);
    ent.move_ent RotateTo(ent.end_pos.angles, slide_time, slide_time, 0);
    if(ent.move_delete) {
      ent delayCall(rock_time, ::delete);
    }
  }
}

hand_icon(type, origin, angles, end_ons) {
  if(level.createFX_enabled) {
    return;
  }
  if(!isDefined(level.hand_icon_count)) {
    level.hand_icon_count = 0;
  }

  level.hand_icon_count++;

  icon_id = "hand_icon_" + level.hand_icon_count;

  hand_icon_update(type, origin, angles, icon_id, end_ons);

  foreach(player in level.players) {
    if(isDefined(player.hand_icons) && isDefined(player.hand_icons[icon_id])) {
      player.hand_icons[icon_id] thread hand_icon_fade_out();
    }
  }
}

hand_icon_update(type, origin, angles, icon_id, end_ons) {
  if(isDefined(end_ons)) {
    if(isString(end_ons)) {
      end_ons = [end_ons];
    }

    foreach(end_on in end_ons) {
      self endon(end_on);
    }
  }

  while(!isDefined(level.players)) {
    wait .05;
  }

  show_dist = 200;
  icon = "hint_usable";
  pin = false;
  switch (type) {
    default:
      break;
  }

  dir = undefined;
  if(isDefined(angles)) {
    dir = anglesToForward(angles);
  }

  show_dist_sqr = show_dist * show_dist;

  while(1) {
    foreach(player in level.players) {
      if(!isDefined(player.hand_icons)) {
        player.hand_icons = [];
      }

      test_origin = player.origin + (0, 0, 50);
      dist_sqr = DistanceSquared(test_origin, origin);

      dir_check = true;
      if(isDefined(dir)) {
        dir_to_player = VectorNormalize(test_origin - origin);
        dir_check = VectorDot(dir, dir_to_player) > .2;
      }

      if(dist_sqr <= show_dist_sqr && dir_check && (!isDefined(self.in_use) || !self.in_use) && !(player isUsingRemote())) {
        if(!isDefined(player.hand_icons[icon_id])) {
          player.hand_icons[icon_id] = hand_icon_create(player, icon, origin, pin);
          player.hand_icons[icon_id].alpha = 0;
        }

        player.hand_icons[icon_id] notify("stop_fade");
        player.hand_icons[icon_id] thread hand_icon_fade_in();
      } else {
        if(isDefined(player.hand_icons[icon_id])) {
          player.hand_icons[icon_id] thread hand_icon_fade_out();
        }
      }
    }
    wait .05;
  }
}

hand_icon_create(player, icon, origin, pin) {
  icon = player createIcon(icon, 16, 16);
  icon setWayPoint(true, pin);
  icon.x = origin[0];
  icon.y = origin[1];
  icon.z = origin[2];
  return icon;
}

hand_icon_fade_in() {
  self endon("death");

  if(self.alpha == 1) {
    return;
  }
  self FadeOverTime(.5);
  self.alpha = 1;
}

hand_icon_fade_out() {
  self endon("death");
  self endon("stop_fade");

  if(self.alpha == 0) {
    return;
  }
  time = .5;
  self FadeOverTime(time);
  self.alpha = 0;
  wait time;

  self Destroy();
}

tower_radio() {
  tower_radio = GetEnt("tower_radio", "targetname");

  tower_radio.tracklist = [];
  tower_radio.tracklist[0] = "mus_emt_portable_radio_01";
  tower_radio.tracklist[1] = "mus_emt_portable_radio_02";
  tower_radio.tracklist[2] = "mus_emt_portable_radio_03";

  gameFlagWait("prematch_done");

  tower_radio thread tower_radio_damage_watch();

  tower_radio endon("death");

  while(1) {
    level waittill("connected", player);
    tower_radio thread tower_radio_sounds(player);
  }
}

tower_radio_damage_watch() {
  self.health = 10000;
  self setCanDamage(true);
  self waittill("damage", damage, attacker, direction_vec, point, type);
  self playSound("radio_destroyed_static");
  self PhysicsLaunchClient(point, direction_vec);
}

tower_radio_sounds(player) {
  self endon("damage");
  player endon("death");
  player endon("disconnect");

  player waittill("spawned_player");
  waitframe();

  last_song = "";

  while(1) {
    song = last_song;
    while(song == last_song) {
      song = random(self.tracklist);
    }
    song_length = LookupSoundLength(song) / 1000;
    if(song_length < 0.1) {
      wait(5.0);
    } else {
      self PlaySoundToPlayer(song, player);
    }

    wait(song_length);
    last_song = song;
  }
}