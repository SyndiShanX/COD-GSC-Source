/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_snow.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hostmigration;

main() {
  maps\mp\mp_snow_precache::main();
  maps\createart\mp_snow_art::main();
  maps\mp\mp_snow_fx::main();
  thread maps\mp\_fx::func_glass_handler();

  flag_init("satellite_crashed");
  flag_init("satellite_incoming");

  level.snow_satellite_allowed = allowLevelKillstreaks();
  level thread satellite_fall();

  precache();

  level.mapCustomCrateFunc = ::snowCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::snowCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::snowCustomBotKillstreakFunc;

  maps\mp\_load::main();

  PreCacheShader("fullscreen_dirtylense");

  maps\mp\_compass::setupMiniMap("compass_map_mp_snow");

  setdvar_cg_ng("r_specularColorScale", 2.3, 10);
  setdvar_cg_ng("r_diffuseColorScale", 1.2, 3);
  setdvar("r_ssaorejectdepth", 1500);
  setdvar("r_ssaofadedepth", 1200);

  SetDvar("r_sky_fog_intensity", "1");
  SetDvar("r_sky_fog_min_angle", "74.6766");
  SetDvar("r_sky_fog_max_angle", "91.2327");
  SetDvar("r_lightGridEnableTweaks", 1);
  SetDvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else if(level.xenon) {
    setdvar("sm_sunShadowScale", "0.7");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  flag_init("satellite_active");
  flag_init("satellite_charged");

  level thread lighthouse();
  level thread snowmen();

  waitframe();

  level thread group_anim("buoy", "mp_snow_buoy_sway", 0.2, 1.0);
  level thread group_anim("boat", "mp_snow_boat_sway", 0.2, 1.0);

  level thread fishing_boat();
  level thread rotate_helicopter_rotor();
  level thread ice();
  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("player32x32x8", "targetname");
  collision1Ent = spawn("script_model", (-1646.94, 881.505, -2.82839));
  collision1Ent.angles = (270, 211.182, 123.817);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision4 = GetEnt("clip64x64x128", "targetname");
  collision4Ent = spawn("script_model", (245, 2512, -64));
  collision4Ent.angles = (0, 0, 0);
  collision4Ent CloneBrushmodelToScriptmodel(collision4);

  collision5 = GetEnt("clip256x256x128", "targetname");
  collision5Ent = spawn("script_model", (-1536, -1312, -136));
  collision5Ent.angles = (0, 0, 0);
  collision5Ent CloneBrushmodelToScriptmodel(collision5);

  collision6 = GetEnt("clip256x256x128", "targetname");
  collision6Ent = spawn("script_model", (-1484, -1440, -136));
  collision6Ent.angles = (0, 45, 0);
  collision6Ent CloneBrushmodelToScriptmodel(collision6);

  if(is_gen4()) {
    collision2 = GetEnt("player64x64x128", "targetname");
    collision2Ent = spawn("script_model", (-1474, 966, -136));
    collision2Ent.angles = (0, 352, 0);
    collision2Ent CloneBrushmodelToScriptmodel(collision2);

    collision3 = GetEnt("clip128x128x8", "targetname");
    collision3Ent = spawn("script_model", (1700, 872, -48));
    collision3Ent.angles = (0, 335, 0);
    collision3Ent CloneBrushmodelToScriptmodel(collision3);
  }
}

fishing_boat() {
  boats = getEntArray("fishing_boat", "targetname");
  foreach(boat in boats) {
    anim_ref = spawn("script_model", boat.origin);
    anim_ref.angles = (0, 0, 0);
    anim_ref setModel("generic_prop_raven");
    boat LinkTo(anim_ref, "tag_origin");
    anim_ref ScriptModelPlayAnimDeltaMotion("mp_snow_fishingboat_sway_prop");

    boat_misc_models = GetEnt(boat.target, "targetname");
    if(isDefined(boat_misc_models)) {
      boat_misc_models LinkTo(anim_ref, "tag_origin");
      boat_misc_models ScriptModelPlayAnimDeltaMotion("mp_snow_fishingboat_sway");
    }

    boat.no_moving_platfrom_death = true;
  }
}

lighthouse() {
  lighthouse = GetEnt("lighthouse", "targetname");

  prop = spawn("script_model", lighthouse.origin);
  prop.angles = lighthouse.angles;
  prop setModel("generic_prop_raven");

  lighthouse LinkTo(prop, "j_prop_1");

  prop ScriptModelPlayAnimDeltaMotion("mp_snow_lighthouse_scan");

  fx_ent = spawn("script_model", lighthouse.origin + (0, 0, 70));
  fx_ent.angles = lighthouse.angles;
  fx_ent setModel("tag_origin");
  fx_ent LinkTo(prop, "j_prop_1");
  lighthouse.fx_ent = fx_ent;

  level thread lighthouse_play_fx_onConnect(lighthouse);
}

snowmen() {
  snowmen = GetScriptableArray("snowman", "targetname");
  foreach(man in snowmen) {
    man thread snowman_death_watch();
  }
}

snowman_death_watch() {
  self waittill("death");
  self maps\mp\_movers::notify_moving_platform_invalid();
}

lighthouse_play_fx_onConnect(lighthouse) {
  while(true) {
    level waittill("connected", player);
    PlayFXOnTagForClients(level._effect["mp_snow_lighthouse"], lighthouse.fx_ent, "tag_origin", player);
  }
}

precache() {
  PrecacheMpAnim("mp_snow_boat_sway");
  PrecacheMpAnim("mp_snow_buoy_sway");
  PrecacheMpAnim("mp_snow_fishingboat_sway");
  PrecacheMpAnim("mp_snow_fishingboat_sway_prop");
  PrecacheMpAnim("mp_snow_tree_fall");
  PrecacheMpAnim("mp_snow_tree_prefall_loop");
}

is_dynamic_path() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

is_ai_sight_line() {
  return isDefined(self.spawnflags) && self.spawnflags & 2;
}

satellite_fall() {
  if(GetDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  if(level.snow_satellite_allowed) {
    level thread play_satellite_static_on_connect();
  }

  waitframe();

  tree_broken_stump = GetEnt("tree_broken_stump", "targetname");
  tree_broken_top = GetEnt("tree_broken_top", "targetname");

  anim_ref = spawn("script_model", tree_broken_stump.origin);
  anim_ref.angles = (0, 0, 0);
  anim_ref setModel("generic_prop_raven");
  anim_ref ScriptModelPlayAnimDeltaMotion("mp_snow_tree_prefall_loop");
  tree_broken_stump LinkTo(anim_ref, "j_prop_1", (0, 0, 0), (0, 0, 0));
  tree_broken_top LinkTo(anim_ref, "j_prop_2", (0, 0, 0), (0, 0, 0));

  pre_crash_group = satellite_group("satellite_pre_crash");
  post_crash_group = satellite_group("satellite_post_crash");

  if(!isDefined(pre_crash_group) || !isDefined(post_crash_group)) {
    return;
  }
  post_crash_group satellite_group_hide();

  if(!level.snow_satellite_allowed) {
    satellite_set_post_crash(pre_crash_group, post_crash_group);
    return;
  }

  flash_trigger = GetEnt("satellite_flash_trigger", "targetname");
  kill_trigger = GetEnt("satellite_kill_trigger", "targetname");

  satellite_start = getstruct("sat_start", "targetname");
  satellite_start_kill_trigger = GetEnt("sat_start_kill_trigger", "targetname");
  if(isDefined(satellite_start_kill_trigger)) {
    satellite_start_kill_trigger.start_origin = satellite_start_kill_trigger.origin;
    satellite_start_kill_trigger.start_angles = satellite_start_kill_trigger.angles;
    satellite_start_kill_trigger EnableLinkTo();
  }

  if(level.createFX_enabled) {
    while(!isDefined(level.player))
      waitframe();
    level.players = [level.player];
    level.characters = [];
  } else {
    gameFlagWait("prematch_done");
  }

  while(1) {
    sat_model = spawn("script_model", satellite_start.origin);
    sat_model.angles = satellite_start.angles;
    sat_model setModel("tag_origin");

    killstreak_player = satellite_killstreak_wait();
    killstreak_team = undefined;
    if(isDefined(killstreak_player)) {
      killstreak_team = killstreak_player.team;
    }

    flag_set("satellite_incoming");
    wait(0.5);

    move_speed = 2000;

    if(isDefined(satellite_start_kill_trigger)) {
      satellite_start_kill_trigger LinkTo(sat_model);
      satellite_start_kill_trigger thread monitor_touching();
    }

    level thread play_satellite_fx_on_model(sat_model);
    sat_model PlaySoundOnMovingEnt("scn_satellite_entry");

    current = satellite_start;

    move_count = 0;
    while(isDefined(current.target)) {
      move_count++;
      goal = getstruct(current.target, "targetname");

      dist = Distance(current.origin, goal.origin);
      move_time = dist / move_speed;
      sat_model MoveTo(goal.origin, move_time);
      level.satellite = sat_model;

      if(move_count == 1) {
        sat_model RotateVelocity((-360, 0, 0), move_time);
      } else {
        sat_model RotateVelocity((0, 1500, 1500), move_time);
      }

      sat_model waittill("movedone");

      if(move_count == 1) {
        anim_ref ScriptModelClearAnim();
        anim_ref ScriptModelPlayAnim("mp_snow_tree_fall");
        exploder("2");

        foreach(player in level.players) {
          player PlayRumbleOnEntity("artillery_rumble");
        }

        sat_model playSound("scn_satellite_skip");
      } else {
        flag_clear("satellite_incoming");
        satellite_flash(sat_model.origin, 2000, 0, flash_trigger);
        Earthquake(0.5, 3, sat_model.origin, 2000);
        playFX(level._effect["satellite_fall_impact"], sat_model.origin);

        while(level.inGracePeriod) {
          waitframe();
        }

        foreach(character in level.characters) {
          if(character IsTouching(kill_trigger)) {
            if(isDefined(killstreak_player) && (!level.teamBased || (character.team != killstreak_team))) {
              character DoDamage(character.health + 1000, character.origin, killstreak_player, sat_model, "MOD_EXPLOSIVE");
            } else {
              character maps\mp\_movers::mover_suicide();
            }
          }
        }

        if(isDefined(level.littleBirds)) {
          foreach(littlebird in level.littleBirds) {
            if(littlebird IsTouching(kill_trigger)) {
              littlebird notify("death");
            }
          }
        }
        sat_model playSound("scn_satellite_impact");

        waitframe();
        satellite_set_post_crash(pre_crash_group, post_crash_group);
      }

      current = goal;
    }

    if(isDefined(satellite_start_kill_trigger)) {
      satellite_start_kill_trigger Unlink();
      satellite_start_kill_trigger.origin = satellite_start_kill_trigger.start_origin;
      satellite_start_kill_trigger.angles = satellite_start_kill_trigger.start_angles;
    }
    sat_model Delete();

    if(!levelFlag("post_game_level_event_active")) {
      if(!level.teamBased && !isDefined(killstreak_player)) {
        continue;
      }
      satellite_use_loc = getstruct("satellite_use_loc", "targetname");

      killstreak_upLinkEnt = spawn("script_origin", satellite_use_loc.origin);
      killstreak_upLinkEnt.angles = (0, 0, 0);
      killstreak_upLinkEnt.owner = killstreak_player;
      killstreak_upLinkEnt.team = killstreak_team;
      killstreak_upLinkEnt.immediateDeath = false;
      if(isDefined(killstreak_player)) {
        killstreak_upLinkEnt SetOtherEnt(killstreak_player);
      }
      maps\mp\killstreaks\_uplink::addUplinkToLevelList(killstreak_upLinkEnt);

      allow_repeat_debug = false;

      if(!allow_repeat_debug) {
        break;
      }

      /#	
      satellite_killstreak_wait();
      flag_clear("satellite_crashed");
      pre_crash_group satellite_group_show();
      post_crash_group satellite_group_hide();

      maps\mp\killstreaks\_uplink::removeUplinkFromLevelList(killstreak_upLinkEnt);
      killstreak_upLinkEnt Delete();

      if(level.createFX_enabled) {
        common_scripts\_exploder::stop_exploder_proc("1");
        common_scripts\_exploder::stop_exploder_proc("2");
        common_scripts\_exploder::stop_exploder_proc("3");
        common_scripts\_exploder::stop_exploder_proc("4");
        common_scripts\_exploder::stop_exploder_proc("32");
      }

    }
  }

}

monitor_touching() {
  level endon("satellite_crashed");

  while(1) {
    if(isDefined(level.littleBirds)) {
      if(level.littleBirds.size > 0) {
        foreach(littlebird in level.littleBirds) {
          if(littlebird IsTouching(self)) {
            littlebird notify("death");
          }
        }
      }
    }
    waitframe();
  }
}

satellite_set_post_crash(pre_crash_group, post_crash_group) {
  flag_set("satellite_crashed");
  foreach(player in level.players) {
    player thread play_exploder_when_not_in_killcam();
  }
  pre_crash_group satellite_group_hide();
  post_crash_group satellite_group_show();
  level thread play_crater_fire_on_connect();
}

play_exploder_when_not_in_killcam() {
  self endon("disconnect");

  while(self isInKillcam()) {
    waitframe();
  }
  exploder("32", self);
}

satellite_flash(test_origin, test_radius, test_dot, test_volume) {
  foreach(player in level.players) {
    player_eye = player getEye();
    dir_to_sat = test_origin - player_eye;

    dist_to_sat = Length(dir_to_sat);
    if(dist_to_sat > test_radius) {
      continue;
    }
    dir_to_sat = VectorNormalize(dir_to_sat);

    look_dir = anglesToForward(player GetPlayerAngles());

    dot = VectorDot(look_dir, dir_to_sat);

    if(dot < test_dot) {
      continue;
    }
    if(isDefined(test_volume)) {
      if(!player IsTouching(test_volume))
        continue;
    }

    player ShellShock("flashbang_mp", max(2.0, 4 * (1 - (dist_to_sat / test_radius))));
  }
}

satellite_group_hide() {
  if(isDefined(self.satellite_group_hide) && self.satellite_group_hide) {
    return;
  }
  self.satellite_group_hide = true;
  self.origin -= (0, 0, 1000);

  foreach(ent in self.clip) {
    ent satellite_clip_hide();
  }

  self DontInterpolate();
}

satellite_clip_hide() {
  if(self is_dynamic_path())
    self ConnectPaths();

  if(self is_ai_sight_line())
    self SetAISightLineVisible(false);

  self maps\mp\_movers::notify_moving_platform_invalid();

  self.old_contents = self SetContents(0);
  self NotSolid();
  self Hide();
}

satellite_group_show() {
  if(isDefined(self.satellite_group_hide) && !self.satellite_group_hide) {
    return;
  }
  self.satellite_group_hide = false;
  self.origin += (0, 0, 1000);

  foreach(ent in self.clip) {
    ent satellite_clip_show();
  }
  self DontInterpolate();
}

satellite_clip_show() {
  self Solid();
  self SetContents(self.old_contents);
  self Show();

  if(self is_dynamic_path())
    self DisconnectPaths();

  if(self is_ai_sight_line())
    self SetAISightLineVisible(true);
}

satellite_group(targetname) {
  struct = getstruct(targetname, "targetname");
  if(!isDefined(struct))
    return undefined;

  parent = spawn("script_model", struct.origin);
  parent setModel("tag_origin");

  parent.clip = [];
  parent.linked = [];

  ents = getEntArray(struct.target, "targetname");
  foreach(ent in ents) {
    if(ent.classname == "script_brushmodel") {
      parent.clip[parent.clip.size] = ent;
    } else {
      parent.linked[parent.linked.size] = ent;
      ent LinkTo(parent);

    }
  }

  return parent;
}

satellite_killstreak_wait() {
  level thread satellite_killstreak_wait_dvar();

  level thread satellite_activate_at_end_of_match();

  level thread satellite_killstreak_notify_wait();
  level waittill("satellite_start", killstreak_player);
  return killstreak_player;
}

satellite_activate_at_end_of_match() {
  level endon("satellite_start");

  if(!level.snow_satellite_allowed) {
    return;
  }
  level waittill("spawning_intermission");
  level thread satellite_end_of_match();

  level notify("satellite_start");
}

satellite_end_of_match() {
  levelFlagSet("post_game_level_event_active");
  VisionSetNaked("", 0.5);

  wait 15;
  levelFlagClear("post_game_level_event_active");
}

satellite_killstreak_notify_wait() {
  level waittill("snow_satellite_killstreak", killstreak_player);
  level notify("satellite_start", killstreak_player);
}

satellite_killstreak_wait_dvar() {
  level endon("satellite_start");

  dvar_name = "trigger_satellite";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value == default_value) {
      waitframe();
    } else {
      SetDvar(dvar_name, default_value);
      level notify("satellite_start", level.player);
    }
  }
}

move_satellite(end) {
  start = self.origin;
  fall_time = 3.0;
  accel_time = 3.0;

  while(1) {
    self MoveTo(end, fall_time, accel_time, 0);
    wait(fall_time + 3.0);
    self MoveTo(start, 0.1);
    wait(0.1);
  }

}

play_satellite_static_on_connect() {
  while(1) {
    level waittill("connected", player);
    player thread run_func_after_spawn(::satellite_static);
  }

}

play_crater_fire_on_connect() {
  while(1) {
    level waittill("connected", player);
    player thread run_func_after_spawn(::call_fire_exploder_on_spawn);
  }
}

call_fire_exploder_on_spawn() {
  self endon("disconnect");
  exploder("32", self);
}

run_func_after_spawn(func) {
  self endon("disconnect");
  self endon("death");

  self waittill("spawned_player");

  self thread[[func]]();
}

play_satellite_fx_on_model(sat_model) {
  playFXOnTag(level._effect["satellite_fall"], sat_model, "tag_origin");
  playFXOnTag(level._effect["satellite_fall_child0"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child1"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child2"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child3"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child4"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child5"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child6"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child7"], sat_model, "tag_origin");
  wait(0.7);
  playFXOnTag(level._effect["satellite_fall_child8"], sat_model, "tag_origin");
}

group_anim(targetname, animname, min_wait, max_wait) {
  animating_objects = getEntArray(targetname, "targetname");
  foreach(object in animating_objects) {
    if(isDefined(min_wait) && isDefined(max_wait)) {
      wait(RandomFloatRange(min_wait, max_wait));
    }

    anim_ref = spawn("script_model", object.origin);
    anim_ref.angles = (0, 0, 0);
    anim_ref setModel("generic_prop_raven");
    object LinkTo(anim_ref, "tag_origin");
    anim_ref ScriptModelPlayAnimDeltaMotion(animname);

    if(isDefined(object.target)) {
      subobjects = getEntArray(object.target, "targetname");
      foreach(subobject in subobjects) {
        subobject LinkTo(anim_ref, "j_prop_1");
      }
    }
  }
}

rotating_windows() {
  windows = getEntArray("rotating_window", "targetname");
  array_thread(windows, ::rotating_windows_init);
}

rotating_windows_init() {
  if(!isDefined(self.target)) {
    return;
  }
  structs = getstructarray(self.target, "targetname");
  foreach(struct in structs) {
    switch (struct.script_noteworthy) {
      case "open_angles":
        self.open_angles = struct.angles;
        break;
      case "closed_angles":
        self.closed_angles = struct.angles;
        break;
      default:
        break;
    }
  }

  ents = getEntArray(self.target, "targetname");
  self.hide_when_closed = [];
  foreach(ent in ents) {
    switch (ent.script_noteworthy) {
      case "open_trigger":
        self.open_trigger = ent;
        break;
      case "close_trigger":
        self.close_trigger = ent;
        break;
      case "hide_when_closed":
        self.hide_when_closed[self.hide_when_closed.size] = ent;
        break;
      default:
        break;
    }
  }

  self setCanDamage(false);
  self thread rotating_windows_run();
}

rotating_windows_run() {
  window_node = spawn("script_model", self.origin);
  window_node.angles = self.open_angles;
  window_node setModel("tag_origin");
  self LinkTo(window_node, "tag_origin");

  start_closed = false;
  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "start_closed")) {
    start_closed = true;
    self.open_trigger trigger_off();
    foreach(hide_me in self.hide_when_closed) {
      hide_me Hide();
    }
  } else {
    self.close_trigger trigger_off();
    foreach(hide_me in self.hide_when_closed) {
      hide_me Show();
    }
  }

  pitch_rotation = AngleClamp(self.closed_angles[0] - self.open_angles[0]);

  while(1) {
    if(start_closed) {
      start_closed = false;
    } else {
      self.open_trigger trigger_off();
      self.close_trigger trigger_on();
      self.close_trigger waittill("trigger");
      foreach(hide_me in self.hide_when_closed) {
        hide_me Hide();
      }
      window_node RotatePitch(pitch_rotation, 0.3, 0, 0);
      wait(1);
    }

    self.open_trigger trigger_on();
    self.close_trigger trigger_off();

    self.open_trigger waittill("trigger");
    window_node RotatePitch(-1 * pitch_rotation, 0.3, 0, 0);
    wait(0.3);
    foreach(hide_me in self.hide_when_closed) {
      hide_me Show();
    }
    wait(0.7);
  }
}

satellite_scrambler() {
  scrambler_loc_struct = getstruct("satellite_use_loc", "targetname");
  scrambler = spawn("script_model", scrambler_loc_struct.origin);
  scrambler.angles = scrambler_loc_struct.angles;

  scrambler MakeScrambler(self);
}

rotate_helicopter_rotor() {
  rotor = GetEnt("heli_rotor_top", "targetname");
  rotor RotateVelocity((0, -300, 0), 36000, 0, 0);

  rotor_back = GetEnt("heli_rotor_back", "targetname");
  if(isDefined(rotor_back))
    rotor_back RotateVelocity((-300, 0, 0), 36000, 0, 0);
}

satellite_static() {
  self endon("disconnect");

  static_center = getstruct("satellite_use_loc", "targetname");
  self maps\mp\killstreaks\_emp_common::staticFieldInit();
  static_dist = 512;
  static_dist_squared = static_dist * static_dist;

  while(1) {
    in_range = Length2DSquared(self.origin - static_center.origin) < static_dist_squared;
    if(in_range && flag("satellite_crashed")) {
      self maps\mp\killstreaks\_emp_common::staticFieldSetStrength(1);
    } else {
      self maps\mp\killstreaks\_emp_common::staticFieldSetStrength(0);
    }

    wait(0.5);
  }
}

satellite_static_emp_watch() {
  level waittill_either("emp_update");
}

ice() {
  ice_pieces = getEntArray("ice", "targetname");
  array_thread(ice_pieces, ::ice_init);
}

ice_init() {
  self.start_origin = self.origin;

  self.anim_ref = self;

  targets = getEntArray(self.target, "targetname");

  foreach(target in targets) {
    switch (target.script_noteworthy) {
      case "border":
        self.border = target;
        break;
      case "trigger_sink":
        self.trigger = target;
        self.trigger EnableLinkTo();
        self.trigger LinkTo(self);
        break;
      default:
        break;
    }
  }

  self thread ice_damage_watch();
}

ice_damage_watch() {
  self setCanDamage(true);
  self.health = 30;

  while(1) {
    self waittill("damage");
    if(self.health <= 0) {
      break;
    }
  }

  if(isDefined(self.script_fxid)) {
    exploder(self.script_fxid);
  }

  self playSound("pond_ice_crack");

  self.border Delete();

  self thread ice_float();
  self thread ice_player_watch();
  self thread ice_sink();
}

ice_float() {
  loop_count = 0;
  while(1) {
    moveTime = RandomFloatRange(3, 5);
    new_angles = (RandomFloatRange(-1, 1), RandomFloatRange(-1, 1), RandomFloatRange(-1, 1));
    new_angles = VectorNormalize(new_angles);
    new_angles *= 3;
    if(loop_count <= 2) {
      new_angles *= 3 - loop_count;
      moveTime /= 3 - loop_count;
    }

    self RotateTo(new_angles, moveTime);
    self waittill("rotatedone");
    loop_count++;
  }
}

ice_player_watch() {
  self.sink_time = 0;
  while(1) {
    self.trigger waittill("trigger");
    self.sink_time = GetTime() + 200;
  }
}

ice_sink() {
  sink_speed = 40;
  raise_speed = 20;

  raise_origin = self.start_origin;
  sink_origin = raise_origin - (0, 0, 100);

  while(1) {
    while(self.sink_time < GetTime())
      waitframe();

    dist = Distance(self.origin, sink_origin);
    move_time = dist / sink_speed;
    self.anim_ref MoveTo(sink_origin, move_time);

    while(self.sink_time >= GetTime())
      waitframe();

    dist = Distance(self.origin, raise_origin);
    move_time = dist / raise_speed;
    self.anim_ref MoveTo(raise_origin, move_time, 0, move_time);
  }
}

wait_game_percent_complete(time_percent, score_percent) {
  if(!isDefined(score_percent))
    score_percent = time_percent;

  gameFlagWait("prematch_done");

  if(!isDefined(level.startTime)) {
    return;
  }
  score_limit = getScoreLimit();
  time_limit = getTimeLimit() * 60;

  ignore_score = false;
  ignore_time = false;

  if((score_limit <= 0) && (time_limit <= 0)) {
    ignore_score = true;
    time_limit = 10 * 60;
  } else if(score_limit <= 0) {
    ignore_score = true;
  } else if(time_limit <= 0) {
    ignore_time = true;
  }

  time_threshold = time_percent * time_limit;
  score_threshold = score_percent * score_limit;

  higher_score = get_highest_score();
  timePassed = (GetTime() - level.startTime) / 1000;

  if(ignore_score) {
    while(timePassed < time_threshold) {
      wait(0.5);
      timePassed = (GetTime() - level.startTime) / 1000;
    }
  } else if(ignore_time) {
    while(higher_score < score_threshold) {
      wait(0.5);
      higher_score = get_highest_score();
    }
  } else {
    while((timePassed < time_threshold) && (higher_score < score_threshold)) {
      wait(0.5);
      higher_score = get_highest_score();
      timePassed = (GetTime() - level.startTime) / 1000;
    }
  }
}

get_highest_score() {
  highestScore = 0;
  if(level.teamBased) {
    if(isDefined(game["teamScores"])) {
      highestScore = game["teamScores"]["allies"];
      if(game["teamScores"]["axis"] > highestScore) {
        highestScore = game["teamScores"]["axis"];
      }
    }
  } else {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(isDefined(player.score) && player.score > highestScore)
          highestScore = player.score;
      }
    }
  }
  return highestScore;
}

SNOW_SATELLITE_WEIGHT = 55;
snowCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!level.snow_satellite_allowed || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "snow_satellite", SNOW_SATELLITE_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_SNOW_SATELLITE");
  level thread watch_for_snow_satellite_crate();
}

watch_for_snow_satellite_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "snow_satellite") {
      disable_snow_satellite();
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "snow_satellite", SNOW_SATELLITE_WEIGHT);
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

disable_snow_satellite() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "snow_satellite", 0);
}

snowCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/snow Satellite\" \"set scr_devgivecarepackage snow_satellite; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/snow Satellite\" \"set scr_givekillstreak snow_satellite\"\n");

  level.killStreakFuncs["snow_satellite"] = ::tryUseSnowSatellite;
  level.killstreakWeildWeapons["snow_satellite_mp"] = "snow_satellite";
}

snowCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/snow Satellite\" \"set scr_testclients_givekillstreak snow_satellite\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("snow_satellite", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseSnowSatellite(lifeId, streakName) {
  game["player_holding_level_killstrek"] = false;
  level notify("snow_satellite_killstreak", self);
  return true;
}