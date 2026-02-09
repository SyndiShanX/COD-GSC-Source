/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_behemoth.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  maps\mp\mp_ca_behemoth_precache::main();
  maps\createart\mp_ca_behemoth_art::main();
  maps\mp\mp_ca_behemoth_fx::main();

  level.mapCustomCrateFunc = ::behemothCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::behemothCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::behemothCustomBotKillstreakFunc;

  maps\mp\_load::main();

  behemothSetMiniMap("compass_map_mp_ca_behemoth");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("bucket", 1);

  setdvar_cg_ng("r_specularColorScale", 1.4, 10.75);
  setdvar_cg_ng("r_diffuseColorScale", 1.72, 2.25);

  if(level.ps3) {
    setDvar("sm_sunShadowScale", "0.55");
    setDvar("sm_sunsamplesizenear", ".15");
  } else if(level.xenon) {
    setDvar("sm_sunShadowScale", "0.56" + "");
    setDvar("sm_sunsamplesizenear", ".22");
  } else {
    setDvar("sm_sunShadowScale", "0.9");
    setDvar("sm_sunsamplesizenear", ".27");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  level.steam_burst_active = 0;
  level.steam_stream_points = [];
  level.steam_burst_points = [];
  level.steam_bokeh_points = [];

  thread setup_burstpipes();
  thread setup_extinguishers();
  thread setup_machinery();
  thread setup_rollers();
  thread setup_movers();
  thread setup_bucketwheels();

  thread setup_fans();

  thread setup_tvs();

  thread maps\mp\mp_ca_killstreaks_heliGunner::init();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
}

setup_fans() {
  fans = getEntArray("destruct_fan", "targetname");
  array_thread(fans, ::update_fan);
}

rotate_fan() {
  self endon("stop_rotate");

  while(1) {
    self RotateYaw(360, 0.5);
    wait 0.25;
  }
}

update_fan() {
  trigger_box = GetEnt(self.target, "targetname");
  if(isDefined(trigger_box)) {
    trigger_box setCanDamage(true);
    self thread rotate_fan();
    trigger_box waittill("damage");

    playFX(level._effect["tv_explode"], self.origin);
    playSoundAtPos(self.origin, "tv_shot_burst");

    self notify("stop_rotate");

    trigger_box setCanDamage(false);

    self RotateYaw(RandomFloat(360), 1.0, 0, .75);
  }
}

setup_rollers() {
  rollers = getEntArray("beh_roller", "targetname");
  array_thread(rollers, ::update_roller);
}

update_roller() {
  wait_time = 6.0;
  while(1) {
    self RotatePitch(360, wait_time);
    wait(wait_time);
  }
}

setup_tvs() {
  tvs = getEntArray("beh_destruct_tv", "targetname");
  array_thread(tvs, ::update_tv);
}

update_tv() {
  monitor_effect = "monitors_0" + RandomIntRange(1, 5);

  if(isDefined(level._effect[monitor_effect])) {
    forward = anglestoright(self.angles) * 0.125;
    end = self.origin + (forward);

    angles = anglesToRight(self.angles);
    origin = end + (0, 0, -1);

    fx_ent = playLoopedFX(level._effect[monitor_effect], 0.5, origin, 1000, angles);

    self setCanDamage(true);

    self waittill("damage");

    playFX(level._effect["tv_explode"], self.origin);
    playSoundAtPos(self.origin, "tv_shot_burst");

    fx_ent Delete();

    self setCanDamage(false);
  }
}

BEHEMOTH_KILLSTREAK_WEIGHT = 80;

behemothSetMiniMap(material) {
  corners = getEntArray("minimap_corner", "targetname");
  if(corners.size != 2) {
    return;
  }
  corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
  corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
  center = corner0 + 0.5 * (corner1 - corner0);

  northYaw = getnorthyaw();

  scaleFactor = abs(sin(northYaw)) + abs(cos(northYaw));
  corner0 = center + scaleFactor * (corner0 - center);
  corner1 = center + scaleFactor * (corner1 - center);

  level.mapSize = max(abs(corner0[1] - corner1[1]), abs(corner0[0] - corner1[0]));

  corner0 = RotatePoint2D(corner0, center, northYaw * -1);
  corner1 = RotatePoint2D(corner1, center, northYaw * -1);

  north = (cos(northYaw), sin(northYaw), 0);
  west = (0 - north[1], north[0], 0);

  cornerdiff = VectorNormalize(corner1 - corner0);

  if(vectordot(cornerdiff, west) > 0) {
    if(vectordot(cornerdiff, north) > 0) {
      northwest = corner1;
      southeast = corner0;
    } else {
      northwest = corner1 + VectorDot(north, corner0 - corner1) * north;
      southeast = 2 * center - northwest;
    }
  } else {
    if(vectordot(cornerdiff, north) > 0) {
      northwest = corner0 + VectorDot(north, corner1 - corner0) * north;
      southeast = 2 * center - northwest;
    } else {
      northwest = corner0;
      southeast = corner1;
    }
  }

  setMiniMap(material, northwest[0], northwest[1], southeast[0], southeast[1]);
}

vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

RotatePoint2D(point, center, angle) {
  rotated = (point[0] - center[0], point[1] - center[1], point[2]);
  rotated = RotatePointAroundVector((0, 0, 1), rotated, angle);
  return (rotated[0] + center[0], rotated[1] + center[1], rotated[2]);
}

behemothCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "heli_gunner", BEHEMOTH_KILLSTREAK_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_CA_KILLSTREAKS_HELI_GUNNER_PICKUP");
  maps\mp\killstreaks\_airdrop::generateMaxWeightedCrateValue();
  level thread watch_for_behemoth_crate();
}

behemothCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Behemoth Killstreak\" \"set scr_devgivecarepackage heli_gunner; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Behemoth Killstreak\" \"set scr_givekillstreak heli_gunner\"\n");

  level.killStreakFuncs["heli_gunner"] = ::tryUseBehemothKillstreak;
}

behemothCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Behemoth Killstreak\" \"set scr_testclients_givekillstreak heli_gunner\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("heli_gunner", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

watch_for_behemoth_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "heli_gunner") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "heli_gunner", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "heli_gunner", BEHEMOTH_KILLSTREAK_WEIGHT);
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

tryUseBehemothKillstreak(lifeId, streakName) {
  return maps\mp\mp_ca_killstreaks_heliGunner::tryUseHeliGunner(lifeId, streakName);
}

setup_bucketwheels() {
  buckets = getEntArray("bucket_wheel", "targetname");
  if(buckets.size)
    array_thread(buckets, ::update_bucketwheel);
}

update_bucketwheel() {
  while(1) {
    self RotatePitch(360, 20.0);
    wait 20.0;
  }
}

CONST_STEAM_SFX_END_DELAY = 0.25;
setup_burstpipes() {
  burstpipes = getstructarray("burstpipe", "targetname");
  array_thread(burstpipes, ::setup_pipe);
}

loop_pipe_fx(fx_loc, soundEnt) {
  up_angles = (90, 0, 0);

  duration = RandomFloatRange(7.5, 8.0);
  fx_node = PlayLoopedFX(level._effect["vfx_pipe_steam_ring"], duration, fx_loc, 0.0, up_angles);

  soundEnt playLoopSound("mtl_steam_pipe_hiss_loop");

  self waittill("end_fx");

  soundEnt playSound("mtl_steam_pipe_hiss_loop_end");

  wait(CONST_STEAM_SFX_END_DELAY);

  soundEnt StopLoopSound("mtl_steam_pipe_hiss_loop");

  fx_node Delete();
}

update_pipe_fx(fx_loc) {
  wait RandomFloat(.25);

  while(self.waiting) {
    fx_loc thread loop_pipe_fx(fx_loc.origin, self.soundEnt);
    level waittill("pipe_burst_cutoff");

    fx_loc notify("end_fx");

    level waittill("pipe_burst_restart");
  }
}

play_effects_at_loc_array(loc_array, effect_id, rand_angle) {
  burst_angle = (0, 0, 0);
  foreach(loc in loc_array) {
    if(rand_angle)
      burst_angle = (RandomFloat(180.0), RandomFloat(180.0), RandomFloat(180.0));
    playFX(effect_id, loc, burst_angle);
  }
}

setup_pipe() {
  fx_locs = GetStructArray(self.target, "targetname");

  level.steam_burst_points[level.steam_burst_points.size] = self.origin;
  level.steam_bokeh_points[level.steam_bokeh_points.size] = self.origin + (0, 0, 30.0);

  foreach(fx_loc in fx_locs)
  level.steam_stream_points[level.steam_stream_points.size] = fx_loc.origin;

  self update_pipe();
}

bokeh_timer(loc) {
  fx_node = SpawnFX(level._effect["scrnfx_water_bokeh_dots_cam_16"], loc);
  TriggerFX(fx_node);
  wait 10.0;
  fx_node Delete();
}

play_bokeh() {
  foreach(loc in level.steam_bokeh_points)
  thread bokeh_timer(loc);
}

update_pipe() {
  self.waiting = 1;

  fx_locs = GetStructArray(self.target, "targetname");

  damage_models = getEntArray(self.target, "targetname");
  if(damage_models.size) {
    self.soundEnt = damage_models[0];

    array_thread(damage_models, ::burstpipe_damage_watcher, self);

    foreach(loc in fx_locs)
    self thread update_pipe_fx(loc);

    self waittill("burstpipe_damage");

    self.soundEnt playSound("mtl_steam_pipe_hit");

    level notify("pipe_burst_cutoff");

    thread play_effects_at_loc_array(level.steam_stream_points, level._effect["vfx_pipe_steam_stream"], 1);

    wait 0.5;

    thread play_bokeh();
    thread play_effects_at_loc_array(level.steam_burst_points, level._effect["vfx_pipe_steam_burst"], 1);

    level.steam_burst_active = 1;

    self.soundEnt playLoopSound("mtl_steam_pipe_hiss_loop");

    wait 10.0 - CONST_STEAM_SFX_END_DELAY;

    self.soundEnt playSound("mtl_steam_pipe_hiss_loop_end");

    wait(CONST_STEAM_SFX_END_DELAY);

    damage_models[0] StopLoopSound("mtl_steam_pipe_hiss_loop");

    level.steam_burst_active = 0;

    level notify("pipe_burst_restart");

    self.waiting = 0;

    wait 120.0;

    while(level.steam_burst_active) {
      wait 0.5;
    }
    self update_pipe();
  }
}

burstpipe_damage_watcher(struct) {
  self setCanDamage(true);
  while(struct.waiting) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(!level.steam_burst_active)
      struct notify("burstpipe_damage", direction_vec, point);
  }
  self setCanDamage(false);
}

setup_extinguishers() {
  extinguishers = getEntArray("extinguisher", "targetname");
  array_thread(extinguishers, ::update_extinguisher);
}

update_extinguisher() {
  self setCanDamage(true);
  damaged = false;

  while(!damaged) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);

    if(IsSubStr(damage_type, "MELEE") || IsSubStr(damage_type, "BULLET")) {
      self setCanDamage(false);

      playFX(level._effect["vfx_fire_extinguisher"], hit_point, RotateVector(direction_vec, (0, 180.0, 0.0)));
      playSoundAtPos(self.origin, "extinguisher_break");
      damaged = true;
    } else {
      self setCanDamage(false);
      playFX(level._effect["vfx_fire_extinguisher"], self.origin, AnglesToUp(self.angles));
      playSoundAtPos(self.origin, "extinguisher_break");
    }
  }
}

play_hit(effect_id, spawn_point, spawn_dir) {
  vfx_ent = SpawnFx(effect_id, spawn_point, anglesToForward(spawn_dir), AnglesToUp(spawn_dir));
  TriggerFX(vfx_ent);
  wait 5.0;
  vfx_ent Delete();
}

#using_animtree("mp_ca_behemoth");
setup_machinery() {
  machines = getEntArray("machinery", "targetname");
  array_thread(machines, ::update_machine);
}

update_machine() {
  anim_time = 10.0;
  play_anim = "";
  go = 1;
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "center") {
      anim_time = GetAnimLength(%mp_ca_beh_center_machine_idle);
      play_anim = "mp_ca_beh_center_machine_idle";
    } else if(self.script_noteworthy == "left") {
      anim_time = GetAnimLength(%mp_ca_beh_engine_a_idle);
      play_anim = "mp_ca_beh_engine_a_idle";
    } else if(self.script_noteworthy == "right") {
      anim_time = GetAnimLength(%mp_ca_beh_engine_b_idle);
      play_anim = "mp_ca_beh_engine_b_idle";
    }

    if(anim_time) {
      while(go) {
        self ScriptModelPlayAnim(play_anim);
        wait anim_time;
      }
    }
  }
}

setup_movers() {
  movers = getEntArray("mover", "targetname");
  array_thread(movers, ::update_mover);
}

setup_mover_nodes() {
  next_point = GetStruct(self.target, "targetname");
  if(isDefined(next_point)) {
    self.angles = VectorToAngles(self.origin - next_point.origin);
    good_to_go = 1;
    while((next_point != self) && (good_to_go)) {
      curr_point = next_point;
      next_point = GetStruct(curr_point.target, "targetname");
      if(isDefined(next_point)) {
        next_point.angles = VectorToAngles(next_point.origin - curr_point.origin);
      } else
        good_to_go = 0;
    }
  }
}

update_mover() {
  current_point = GetStruct(self.target, "targetname");
  if(!isDefined(current_point)) {
    return;
  }
  current_point setup_mover_nodes();

  self.origin = current_point.origin;
  self.angles = current_point.angles;

  self.enabled = true;

  default_speed = 140.0;
  stop_time = 0.0;
  start_time = 0.0;
  if(isDefined(current_point.script_accel))
    start_time = current_point.script_accel;

  current_point = GetStruct(current_point.target, "targetname");
  while(isDefined(current_point)) {
    stop_time = 0.0;
    if(isDefined(current_point.script_decel))
      stop_time = current_point.script_decel;

    move_speed = default_speed;

    if(isDefined(current_point.script_physics))
      move_speed *= current_point.script_physics;
    move_time = Distance(self.origin, current_point.origin) / move_speed;
    move_time = Max(move_time, stop_time + start_time);

    self MoveTo(current_point.origin, move_time, start_time, stop_time);
    self RotateTo(current_point.angles, move_time, start_time, stop_time);

    point_angle = current_point.angles[1];

    wait move_time - (start_time + stop_time);

    if(isDefined(current_point.script_node_pausetime))
      wait current_point.script_node_pausetime;

    start_time = 0.0;
    if(isDefined(current_point.script_accel))
      start_time = current_point.script_accel;

    current_point = GetStruct(current_point.target, "targetname");
  }
}