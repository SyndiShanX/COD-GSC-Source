/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_hashima.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\mp_hashima_precache::main();
  maps\createart\mp_hashima_art::main();
  maps\mp\mp_hashima_fx::main();

  precache();

  level.mapCustomCrateFunc = ::hashimaCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::hashimaCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::hashimaCustomBotKillstreakFunc;

  level.vanguardVisionSet = "ac130_enhanced_mp_hashima";

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_hashima");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_diffuseColorScale", 1.75, 1);
  setdvar_cg_ng("r_specularcolorscale", 3, 8);
  setdvar("r_ssaoFadeDepth", 1024);

  setdvar("r_reactiveMotionWindAmplitudeScale", .3);
  setdvar("r_reactiveMotionWindFrequencyScale", .5);

  SetDvar("r_sky_fog_intensity", "1");
  SetDvar("r_sky_fog_min_angle", "50");
  SetDvar("r_sky_fog_max_angle", "85");

  if((level.ps3) || (level.xenon)) {
    setdvar("sm_sunShadowScale", "0.7");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "urban";

  flag_init("north_target_hit");
  flag_init("south_target_hit");

  level.coal_car = undefined;
  level.start_to_end_length = 0.0;
  level.end_to_start_length = 0.0;
  coal_car_init();
  level thread use_switch_toggle_multiple();
  level thread handle_missiles();
  level thread initHideyModels();
}

initHideyModels() {
  trashCan1 = spawn("script_model", (-1494, 3177.5, 238.3));
  trashCan1 setModel("com_trashcan_metal_with_trash");
  trashCan1.angles = (4.51282, 176.769, 100.788);

  trashCan2 = spawn("script_model", (-1497, 3239.5, 223.3));
  trashCan2 setModel("com_trashcan_metal_with_trash");
  trashcan2.angles = (353.55, 216.271, -2.19454);

  trashCan3 = spawn("script_model", (-1452, 3025, 267.5));
  trashCan3 setModel("com_trashcan_metal_with_trash");
  trashcan3.angles = (2.21881, 22.6731, 83.4648);

  lid1 = spawn("script_model", (-1507, 3218, 237.3));
  lid1 setModel("com_trashcan_metallid");
  lid1.angles = (19.0974, 81.1217, 75.5672);

  lid2 = spawn("script_model", (-1442.5, 2973.5, 274.8));
  lid2 setModel("com_trashcan_metallid");
  lid2.angles = (3.4983, 102.922, 81.874);

  collision1 = GetEnt("clip64x64x64", "targetname");
  collision1Ent = spawn("script_model", (-1515, 3215, 194));
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision2 = GetEnt("player64x64x256", "targetname");
  collision2Ent = spawn("script_model", (-1515, 3215, 258));
  collision2Ent CloneBrushmodelToScriptmodel(collision2);

  collision3 = GetEnt("clip32x32x32", "targetname");
  collision3ent = spawn("script_model", (-1446.5, 3004.47, 249.201));
  collision3ent.angles = (3.68833, 23.7315, -8.32483);
  collision3ent CloneBrushmodelToScriptmodel(collision3);

  collision4 = GetEnt("player32x32x128", "targetname");
  collision4Ent = spawn("script_model", (-78, -1222, 380));
  collision4Ent CloneBrushmodelToScriptmodel(collision4);

  collision5 = GetEnt("player32x32x128", "targetname");
  collision5Ent = spawn("script_model", (-78, -1234, 380));
  collision5Ent CloneBrushmodelToScriptmodel(collision5);

  collision6 = GetEnt("player64x64x256", "targetname");
  collision6Ent = spawn("script_model", (896, -1330, 404));
  collision6Ent CloneBrushmodelToScriptmodel(collision6);

  collision7 = GetEnt("player32x32x128", "targetname");
  collision7Ent = spawn("script_model", (912, -1084, 352));
  collision7Ent CloneBrushmodelToScriptmodel(collision7);

  collision8 = GetEnt("clip64x64x64", "targetname");
  collision8Ent = spawn("script_model", (320, 571, 245));
  collision8ent.angles = (0, 330, 0);
  collision8Ent CloneBrushmodelToScriptmodel(collision8);

  collision9 = GetEnt("player64x64x256", "targetname");
  collision9Ent = spawn("script_model", (-238, 5466, 180));
  collision9Ent CloneBrushmodelToScriptmodel(collision9);

  collision10 = GetEnt("clip256x256x256", "targetname");
  collision10Ent = spawn("script_model", (-1960, -860, -17));
  collision10ent.angles = (0, 0, 0);
  collision10Ent CloneBrushmodelToScriptmodel(collision10);

  collision11 = GetEnt("clip256x256x256", "targetname");
  collision11Ent = spawn("script_model", (-672, 5664, 577));
  collision11ent.angles = (0, 0, 0);
  collision11Ent CloneBrushmodelToScriptmodel(collision11);

  collision12 = GetEnt("clip256x256x256", "targetname");
  collision12Ent = spawn("script_model", (-672, 5664, 845));
  collision12ent.angles = (0, 0, 0);
  collision12Ent CloneBrushmodelToScriptmodel(collision12);

  collision13 = GetEnt("clip256x256x256", "targetname");
  collision13Ent = spawn("script_model", (-2344, 5376, 309));
  collision13ent.angles = (0, 0, 0);
  collision13Ent CloneBrushmodelToScriptmodel(collision13);

  collision14 = GetEnt("clip32x32x128", "targetname");
  collision14Ent = spawn("script_model", (-118, -1307.03, 380.887));
  collision14ent.angles = (0, 0, -80);
  collision14Ent CloneBrushmodelToScriptmodel(collision14);

  gryphonTrig1Ent = spawn("trigger_radius", (1061, -1483, 320), 0, 700, 44);
  gryphonTrig1Ent.radius = 700;
  gryphonTrig1Ent.height = 100;
  gryphonTrig1Ent.angles = (0, 0, 0);
  gryphonTrig1Ent.targetname = "gryphonDeath";
}

precache() {
  PrecacheMpAnim("mp_hashima_coal_cart_start_idle");
  PrecacheMpAnim("mp_hashima_coal_cart_end_idle");
  PrecacheMpAnim("mp_hashima_coal_cart_move_1");
  PrecacheMpAnim("mp_hashima_coal_cart_move_2");
  PrecacheMpAnim("mp_hashima_coal_cart_start_idle_origin");
  PrecacheMpAnim("mp_hashima_coal_cart_start_idle_origin_scripted");
  PrecacheMpAnim("mp_hashima_coal_cart_end_idle_origin");
  PrecacheMpAnim("mp_hashima_coal_cart_move_1_origin");
  PrecacheMpAnim("mp_hashima_coal_cart_move_2_origin");
}

handle_missiles() {
  init_missiles();
  run_missiles();
}

init_missiles() {
  missiles_precache();

  waittillframeend;

  level.missile_starts = getstructarray("missile_start", "targetname");
}

missiles_

run_missiles() {
  level endon("stop_missiles");

  minimum_missile_delay_interval = 10;
  maximum_random_missile_delay = 20;
  flight_time_delay = 5.0;
  west_movement_distance = -92500.0;

  missile_launch_height_spawn = 10000;
  missile_drop_height_spawn = 5000;

  while(1) {
    level waittill("start_missile_strike", calling_player);

    missile_targets = [];

    foreach(participant in level.participants) {
      if(calling_player isEnemy(participant)) {
        missile_targets[missile_targets.size] = participant;
      }
    }

    level thread fake_missile_launch(missile_targets, missile_launch_height_spawn, missile_drop_height_spawn, calling_player);

    wait(flight_time_delay);
  }
}

fake_missile_launch(target_array, missile_launch_height, missile_drop_height, calling_player) {
  launch_start_array = getstructarray("missile_start", "targetname");
  launch_start_array = array_randomize(launch_start_array);

  index = 0;
  foreach(missile_target in target_array) {
    targetOrigin = missile_target.origin;
    fake_missile = spawn("script_model", launch_start_array[index].origin);
    fake_missile setModel("tag_origin");

    fake_missile thread play_loop_sound_on_entity("move_hashima_second_proj_loop1");
    waitframe();
    playSoundAtPos(launch_start_array[index].origin, "hashima_missile_launch");
    index++;
    fake_missile thread move_fake_missile(targetOrigin, missile_launch_height, missile_drop_height, calling_player, missile_target);
    fake_missile PlaySoundOnMovingEnt("hashima_missile_incoming");
    wait(RandomFloatRange(0.1, 0.5));
  }
}

move_fake_missile(missile_target, missile_launch_height, missile_drop_height, calling_player, target_player) {
  playFXOnTag(level._effect["hashima_missile_lens_flare"], self, "tag_origin");
  move_time = 4.0;
  self MoveTo(missile_target + (0, 0, missile_launch_height), move_time, 1.5, 1.5);

  start_pos = missile_target + (0, 0, 40) + (anglesToForward(target_player.angles) * 100);
  kill_cam_ent = spawn("script_model", start_pos);
  kill_cam_ent LinkTo(target_player);

  wait(move_time);

  kill_cam_ent thread waitAndDelete(5);

  if(isDefined(target_player))
    missile_target = target_player.origin;

  stopFXOnTag(level._effect["hashima_missile_lens_flare"], self, "tag_origin");
  waitframe();
  playFX(level._effect["hashima_missile_turn_obscurer"], self.origin);
  waitframe();
  self.angles = VectorToAngles(missile_target - self.origin);
  self MoveTo(missile_target + (0, 0, missile_drop_height), 0.5, 0.5, 0.0);
  wait(0.5);

  flight_time = 1.0;

  if(isDefined(target_player))
    missile_target = target_player.origin;

  start_pos = self.origin;
  missile_trace = bulletTrace(start_pos, missile_target, false);
  end_pos = missile_trace["position"];

  self Delete();

  if(!isDefined(calling_player))
    projectile = MagicBullet("hashima_missiles_mp", start_pos, end_pos);
  else
    projectile = MagicBullet("hashima_missiles_mp", start_pos, end_pos, calling_player);

  projectile PlaySoundOnMovingEnt("hashima_missile_flyover");
  projectile.killCamEnt = kill_cam_ent;

  projectile waittill("explode", position);
  PlayRumbleOnPosition("artillery_rumble", position);
  Earthquake(0.3, 1.0, position, 20000);
}

waitAndDelete(time) {
  self endon("death");
  level endon("game_ended");
  wait(time);
  self delete();
}

HASHIMA_MISSILES_WEIGHT = 85;
hashimaCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "hashima_missiles", HASHIMA_MISSILES_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_HASHIMA_MISSILES");
  level thread watch_for_hashima_missiles_crate();
}

watch_for_hashima_missiles_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "hashima_missiles") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "hashima_missiles", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "hashima_missiles", HASHIMA_MISSILES_WEIGHT);
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

hashimaCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Hashima Missiles\" \"set scr_devgivecarepackage hashima_missiles; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Hashima Missiles\" \"set scr_givekillstreak hashima_missiles\"\n");

  level.killStreakFuncs["hashima_missiles"] = ::tryUseHashimaMissiles;
  level.killstreakWeildWeapons["hashima_missiles_mp"] = "hashima_missiles";
}

hashimaCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Hashima Missiles\" \"set scr_testclients_givekillstreak hashima_missiles\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("hashima_missiles", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseHashimaMissiles(lifeId, streakName) {
  level notify("start_missile_strike", self);

  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "hashima_missiles", 0);
  game["player_holding_level_killstrek"] = false;
  return true;
}

#using_animtree("animated_props");

coal_car_init() {
  spawn_struct = getstruct("coal_car_spawn", "targetname");
  coal_car_clip = GetEnt("coal_car_clip", "targetname");

  coal_car = spawn("script_model", spawn_struct.origin);
  coal_car setModel("has_coal_mine_cart_anim");
  coal_car_collision_origin = spawn("script_model", spawn_struct.origin);
  coal_car_collision_origin setModel("generic_prop_raven");
  waitframe();
  coal_car_clip LinkTo(coal_car_collision_origin, "tag_origin");
  coal_car.clip = coal_car_clip;
  coal_car.collision_origin = coal_car_collision_origin;
  waitframe();

  level.start_to_end_length = GetAnimLength( % mp_hashima_coal_cart_move_1);
  level.end_to_start_length = GetAnimLength( % mp_hashima_coal_cart_move_2);

  coal_car ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_start_idle");
  coal_car.collision_origin ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_start_idle_origin_scripted");
  level.coal_car = coal_car;
  level.coal_car thread coal_car_run();
}

coal_car_run() {
  ai_sight_brush_start = GetEnt("ai_sight_brush_start", "targetname");
  ai_sight_brush_end = GetEnt("ai_sight_brush_end", "targetname");

  ai_sight_brush_start NotSolid();
  ai_sight_brush_start Show();
  ai_sight_brush_start SetAISightLineVisible(true);

  ai_sight_brush_end NotSolid();
  ai_sight_brush_end Hide();
  ai_sight_brush_end SetAISightLineVisible(false);
  ai_sight_brush_end ConnectPaths();

  startSoundTime = LookupSoundLength("scn_cargo_button_start") / 1000;
  initial_origin = self.origin;
  initial_angles = self.angles;
  initial_collision_origin = self.collision_origin.origin;
  initial_collision_angles = self.collision_origin.angles;
  waitframe();
  self.clip DisconnectPaths();

  while(1) {
    self waittill_any("trigger", "reset");

    ai_sight_brush_start NotSolid();
    ai_sight_brush_start Hide();
    ai_sight_brush_start ConnectPaths();

    self PlaySoundOnMovingEnt("scn_cargo_button_start");

    self ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_move_1");
    self.collision_origin ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_move_1_origin");
    self thread disconnect_path_periodic(1.0);

    wait(startSoundTime);

    self playLoopSound("scn_cargo_button_loop");

    wait(level.start_to_end_length - startSoundTime);

    self StopLoopSound();
    self PlaySoundOnMovingEnt("scn_cargo_button_end");
    self notify("stop_disconnect_path_periodic");
    self ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_end_idle");
    self.collision_origin ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_end_idle_origin");
    self.clip DisconnectPaths();

    ai_sight_brush_start SetAISightLineVisible(false);

    ai_sight_brush_end Show();
    ai_sight_brush_end SetAISightLineVisible(true);
    self waittill_any("trigger", "reset");
    self PlaySoundOnMovingEnt("scn_cargo_button_start");
    self thread disconnect_path_periodic(1.0);

    self ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_move_2");
    self.collision_origin ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_move_2_origin");

    wait(startSoundTime);

    self playLoopSound("scn_cargo_button_loop");

    wait(level.end_to_start_length - startSoundTime);

    self StopLoopSound();
    self PlaySoundOnMovingEnt("scn_cargo_button_end");

    self ScriptModelClearAnim();
    self.collision_origin ScriptModelClearAnim();
    self.origin = initial_origin;
    self.angles = (0, 0, 0);
    self.collision_origin.origin = initial_origin;
    self.collision_origin.angles = (0, 0, 0);
    self notify("stop_disconnect_path_periodic");
    self ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_start_idle");
    self.collision_origin ScriptModelPlayAnimDeltaMotion("mp_hashima_coal_cart_start_idle_origin_scripted");

    self.clip DisconnectPaths();

    ai_sight_brush_start Show();
    ai_sight_brush_start SetAISightLineVisible(true);

    ai_sight_brush_end Hide();
    ai_sight_brush_end SetAISightLineVisible(false);
  }
}

disconnect_path_periodic(interval) {
  self endon("stop_disconnect_path_periodic");

  while(1) {
    wait(interval);
    self.clip DisconnectPaths();
  }
}

use_switch_toggle_multiple() {
  level.door_buttons = [];
  useSwitch = getstructarray("switch_toggle", "targetname");
  array_thread(useSwitch, ::use_switch_toggle_multiple_init);
}

use_switch_toggle_multiple_init() {
  targets = getEntArray(self.target, "targetname");

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "use_trigger":
        if(!isDefined(self.use_triggers)) {
          self.use_triggers = [];
        }
        self.use_triggers[self.use_triggers.size] = target;
        break;
      case "button_toggle":
        if(!isDefined(self.button_toggles)) {
          self.button_toggles = [];
        }
        num_button_toggles = self.button_toggles.size;
        self.button_toggles[num_button_toggles] = target;
        level.door_buttons[level.door_buttons.size] = target;
        break;
      default:
        break;
    }
  }

  self.off_hintString = "Turn On";
  self.on_hintString = "Turn Off";
  self.trigger_list = [];

  self.trigger_list[0] = level.coal_car;

  self.off_hintString = &"MP_HASHIMA_TRAIN_CAR";

  self.on_hintString = &"MP_HASHIMA_TRAIN_CAR";
  self use_switch_toggle_wait();
}

use_switch_toggle_wait() {
  wait_struct = spawnStruct();
  buzzer_sound_loc = GetEnt("buzzer_sound_loc", "targetname");

  while(1) {
    foreach(use_trigger in self.use_triggers) {
      use_trigger SetHintString(self.off_hintString);
      use_trigger thread notify_struct_on_use(wait_struct);
    }

    self thread pop_up_targets_set_buttons(true);

    wait_struct waittill("trigger", player);

    if(isDefined(self.button_toggles)) {
      self.button_toggles[0] playSound("scn_cargo_button_push");
    }
    buzzer_sound_loc playSound("scn_cargo_button_buzzer");

    foreach(use_trigger in self.use_triggers) {
      use_trigger SetHintString("");
    }

    self thread pop_up_targets_set_buttons(false);

    foreach(thing in self.trigger_list) {
      thing notify("trigger", player);
    }

    wait level.start_to_end_length;

    foreach(use_trigger in self.use_triggers) {
      use_trigger SetHintString(self.on_hintString);
      use_trigger thread notify_struct_on_use(wait_struct);
    }

    self thread pop_up_targets_set_buttons(true);

    wait_struct waittill("trigger", player);

    if(isDefined(self.button_toggles)) {
      self.button_toggles[0] playSound("scn_cargo_button_push");
    }
    buzzer_sound_loc playSound("scn_cargo_button_buzzer");

    foreach(use_trigger in self.use_triggers) {
      use_trigger SetHintString("");
    }

    self thread pop_up_targets_set_buttons(false);

    if(isDefined(self.levers)) {
      foreach(lever in self.levers) {
        lever setModel("weapon_light_stick_tactical_red");
      }
    }

    foreach(thing in self.trigger_list) {
      thing notify("reset");
    }

    wait level.end_to_start_length;
  }
}

notify_struct_on_use(wait_struct) {
  self waittill("trigger");
  wait_struct notify("trigger");
}

pop_up_targets_set_buttons(on) {
  if(isDefined(self.button_toggles)) {
    foreach(button in self.button_toggles) {
      button set_button("mp_frag_button", on);
    }
  }
}

set_button(button_name, turn_on) {
  if(turn_on) {
    name = "mp_frag_button_on_green";
  } else {
    name = "mp_frag_button_on";
  }

  self.in_use = turn_on;
  self setModel(name);
}

hashima_nukeDeathVision() {
  level.nukeVisionSet = "aftermath_mp_hashima";
  setExpFog(512, 4097, 0.578828, 0.802656, 1, 0.75, 0.75, 5, 0.382813, 0.350569, 0.293091, 3, (1, -0.109979, 0.267867), 0, 80, 1, 0.179688, 26, 180);
  VisionSetNaked(level.nukeVisionSet, 5);
  VisionSetPain(level.nukeVisionSet);
}