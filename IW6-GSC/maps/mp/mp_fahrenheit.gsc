/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_fahrenheit.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

SIDE_LEFT = 1;
SIDE_RIGHT = 2;
SIDE_NONE = 3;

main() {
  maps\mp\mp_fahrenheit_precache::main();
  maps\createart\mp_fahrenheit_art::main();
  maps\mp\mp_fahrenheit_fx::main();

  precache();
  maps\mp\_load::main();

  flag_init("stop_dynamic_events");

  level.rainScriptables = [];
  level.rainScriptables = GetScriptableArray("rain_scriptable", "targetname");

  level.round_start_fraction = 0;
  level.round_end_fraction = 1;
  level.storm_stage = 0;
  level.stage_1_fraction = 0.4;
  level.stage_2_fraction = 0.7;
  round_time = getTimeLimit() * 60;
  if(round_time <= 0) {
    round_time = 600;
  }
  level.assumed_match_length = round_time;

  maps\mp\_compass::setupMiniMap("compass_map_mp_fahrenheit");

  setDvar("r_reactiveMotionWindAmplitudeScale", .5);
  setDvar("r_reactiveMotionWindFrequencyScale", .5);

  if((level.ps3) || (level.xenon)) {
    setDvar("sm_sunShadowScale", "0.8");
  }

  setdvar_cg_ng("r_specularColorScale", 3, 9);
  setdvar_cg_ng("r_diffuseColorScale", 1.6, 2.2);
  setDvar("r_ssaorejectdepth", 1500);
  setDvar("r_ssaofadedepth", 1200);
  setDvar("r_sky_fog_intensity", "1");
  setDvar("r_sky_fog_min_angle", "56.6766");
  setDvar("r_sky_fog_max_angle", "75");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  flag_init("begin_storm");

  level thread plant_anims();

  waitframe();
  if(isRoundBased()) {
    compute_round_based_percentages(round_time);
  }

  level thread sky_and_visionsets(level.assumed_match_length, level.round_start_fraction, level.round_end_fraction);
  level thread connect_watch();

  level thread exploder_test();

  thread setupElevator();
  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x8", "targetname");
  collision1Ent = spawn("script_model", (-2352, -1938, 512));
  collision1Ent.angles = (0, 0, 0);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision2 = GetEnt("clip32x32x256", "targetname");
  collision2Ent = spawn("script_model", (176, -2420, 848));
  collision2Ent.angles = (0, 0, 0);
  collision2Ent CloneBrushmodelToScriptmodel(collision2);

  collision3 = GetEnt("clip32x32x256", "targetname");
  collision3Ent = spawn("script_model", (176, -2452, 848));
  collision3Ent.angles = (0, 0, 0);
  collision3Ent CloneBrushmodelToScriptmodel(collision3);

  collision4 = GetEnt("clip32x32x256", "targetname");
  collision4Ent = spawn("script_model", (666, -1824, 868));
  collision4Ent.angles = (0, 0, 0);
  collision4Ent CloneBrushmodelToScriptmodel(collision4);

  collision5 = GetEnt("clip256x256x8", "targetname");
  collision5Ent = spawn("script_model", (-1372, -3232, 784));
  collision5Ent.angles = (0, 0, 0);
  collision5Ent CloneBrushmodelToScriptmodel(collision5);

  collision6 = GetEnt("clip64x64x256", "targetname");
  collision6Ent = spawn("script_model", (-1928, 624, 680));
  collision6Ent.angles = (0, 0, -90);
  collision6Ent CloneBrushmodelToScriptmodel(collision6);

  collision7 = GetEnt("clip256x256x8", "targetname");
  collision7Ent = spawn("script_model", (-1808, 760, 648));
  collision7Ent.angles = (0, 0, 0);
  collision7Ent CloneBrushmodelToScriptmodel(collision7);

  gryphonTrig1Ent = spawn("trigger_radius", (-1216, 80, 496), 0, 864, 110);
  gryphonTrig1Ent.radius = 864;
  gryphonTrig1Ent.height = 110;
  gryphonTrig1Ent.angles = (0, 0, 0);
  gryphonTrig1Ent.targetname = "gryphonDeath";

  gryphonTrig2Ent = spawn("trigger_radius", (576, -3104, 312), 0, 2240, 75);
  gryphonTrig2Ent.radius = 2240;
  gryphonTrig2Ent.height = 75;
  gryphonTrig2Ent.angles = (0, 0, 0);
  gryphonTrig2Ent.targetname = "gryphonDeath";

  gryphonTrig3Ent = spawn("trigger_radius", (-1080, -4136, 520), 0, 176, 528);
  gryphonTrig3Ent.radius = 176;
  gryphonTrig3Ent.height = 528;
  gryphonTrig3Ent.angles = (0, 0, 0);
  gryphonTrig3Ent.targetname = "gryphonDeath";

  gryphonTrig4Ent = spawn("trigger_radius", (-1184, -3808, 416), 0, 176, 96);
  gryphonTrig4Ent.radius = 176;
  gryphonTrig4Ent.height = 96;
  gryphonTrig4Ent.angles = (0, 0, 0);
  gryphonTrig4Ent.targetname = "gryphonDeath";

  antiFoliageEnt = spawn("trigger_radius", (448, -2144, 896), 0, 400, 128);
  antiFoliageEnt.radius = 400;
  antiFoliageEnt.height = 128;
  antiFoliageEnt.angles = (0, 0, 0);
  antiFoliageEnt.targetname = "antiFoliage";
  level thread watchAntiFoliage(antiFoliageEnt);

  level thread killTrigger((-194, 198, 352), 700, 256);

  level thread killTrigger((-2148, -340, 718), 96, 6);
}

watchAntiFoliage(trigger) {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      wait(0.05);

      if(!isDefined(player)) {
        continue;
      }
      if(player IsTouching(trigger)) {
        if(isDefined(player.wasInAntiFoliage) && player.wasInAntiFoliage) {
          continue;
        }
        player SetIgnoreFoliageSightingMe(1);
        player.wasInAntiFoliage = true;
      } else if(isDefined(player.wasInAntiFoliage) && player.wasInAntiFoliage) {
        player SetIgnoreFoliageSightingMe(0);
        player.wasInAntiFoliage = false;
      }
    }

    wait(.1);
  }
}

precache() {}

setupElevator() {
  if(level.gametype == "horde") {
    return;
  }
  elevatorCfg = spawnStruct();
  elevatorCfg.name = "elevator";
  elevatorCfg.doors = [];
  elevatorCfg.doors["floor1"] = ["e_door_floor1_", "e_door_elevator_1_"];
  elevatorCfg.doors["floor2"] = ["e_door_floor2_", "e_door_elevator_2_"];

  elevatorCfg.doors["elevator"] = ["e_door_elevator_1_", "e_door_elevator_2_"];
  elevatorCfg.doorMoveDist = 35;
  elevatorCfg.buttons = "elevator_button";
  elevatorCfg.trigBlockName = "elevator_door_checker";

  maps\mp\_elevator::init_elevator(elevatorCfg);
}

compute_round_based_percentages(round_time) {
  round_limit = getWatchedDvar("roundlimit");
  win_limit = getWatchedDvar("winlimit");

  if(win_limit > 0) {
    level.assumed_match_length = win_limit * round_time;
    if(isFirstRound()) {
      winning_team_round = 0;
    } else {
      winning_team_round = max(game["roundsWon"]["allies"], game["roundsWon"]["axis"]);
    }
    level.round_start_fraction = (winning_team_round / win_limit);
    level.round_end_fraction = (winning_team_round + 1) / win_limit;
  } else if(round_limit > 0) {
    level.assumed_match_length = round_limit * round_time;
    level.round_start_fraction = game["roundsPlayed"] / round_limit;
    level.round_end_fraction = (game["roundsPlayed"] + 1) / round_limit;
  }
}

exploder_test() {
  while(1) {
    SetDevDvar("test_exploder", "-1");
    while(GetDvarInt("test_exploder") < 0) {
      wait .05;
    }
    exploder(GetDvarInt("test_exploder"));
  }
}

plant_anims() {
  level.plants = GetScriptableArray("storm_plant", "targetname");

  level waittill("storm_stage_1");
  plant_set_stage_directional("stage_1", 180, 6, 1);
}

plant_set_stage_directional(stage, angle, time, rand) {
  forward = anglesToForward((0, angle, 0));
  right = AnglesToRight((0, angle, 0));

  min_dist = undefined;
  max_dist = undefined;
  foreach(plant in level.plants) {
    dist = DistToLine(plant.origin, (0, 0, 0), right);

    if(LRTest(plant.origin, (0, 0, 0), right) == SIDE_RIGHT)
      dist *= -1;

    if(!isDefined(min_dist) || dist < min_dist)
      min_dist = dist;

    if(!isDefined(max_dist) || dist > max_dist)
      max_dist = dist;

    plant.temp_dist = dist;
  }

  foreach(plant in level.plants) {
    frac = (plant.temp_dist - min_dist) / (max_dist - min_dist);

    delay = time * frac;
    if(isDefined(rand) && rand > 0)
      delay += RandomFloatRange(0, rand);

    level thread plant_set_stage(plant, stage, delay);
  }
}

plant_set_stage(plant, stage, delay) {
  if(isDefined(delay) && delay > 0)
    wait delay;

  plant SetScriptablePartState("storm_plant", stage);
}

rainFXStage(number) {
  if(!isDefined(number)) {
    number = 0;
  }
  if(number > 2) {
    number = 0;
  }
  if(isDefined(level.rainscriptables)) {
    foreach(scriptable in level.rainscriptables) {
      scriptable SetScriptablePartState(0, number);
    }
  }
}

visiontest() {
  wait(20);

  current_stage = 0;
  MAX_STAGES = 2;
  sign = -1;

  level.skydome = GetEnt("skydome", "targetname");

  {
    current_stage = current_stage + 1;
    if(current_stage >= MAX_STAGES) {
      current_stage = 0;
    }

    IPrintLnBold("CHANGING VISIONSETS to:" + current_stage);

    foreach(player in level.players) {
      player VisionSetStage(Int(min(1, current_stage)), 3);
    }
    level.skydome RotatePitch(sign * 45, 3);
    sign = sign * -1;

    rainFXStage(1);

    wait 6;
  }
}
fx_test() {
  scriptables = [];
  scriptables = GetScriptableArray("rain_scriptable", "targetname");

  while(1) {
    scriptables[0] SetScriptablePartState(0, 0);
    wait(5);
    scriptables[0] SetScriptablePartState(0, 1);
    wait(5);
    scriptables[0] SetScriptablePartState(0, 2);
    wait(5);
    scriptables[0] SetScriptablePartState(0, 3);
    wait(5);
  }
}

sky_and_visionsets(match_duration, start_fraction, end_fraction) {
  level.volmods = [];

  if(flag("stop_dynamic_events")) {
    return;
  }
  level endon("stop_dynamic_events");

  clear_stage = 0;
  transition_time = 10;

  gameFlagWait("prematch_done");

  level.storm_stage = 0;

  current_fraction = start_fraction;
  if(start_fraction < level.stage_1_fraction) {
    foreach(player in level.players) {
      player VisionSetStage(Int(min(1, level.storm_stage)), 0.1);
    }
    remaining_time = (level.stage_1_fraction * match_duration) - (current_fraction * match_duration);
    wait(remaining_time);
    current_fraction = level.stage_1_fraction;
  }

  if(start_fraction < level.stage_2_fraction) {
    level notify("storm_stage_1");
    level.storm_stage = 1;
    exploder(1);

    level thread storm_sound_stage("storm_sound_stage_1");

    level.rainEmitEnt = spawn("script_origin", (0, 0, 0));
    storm_sounds_volMod("scripted2", 0, 0);

    wait(0.05);
    level.rainEmitEnt playLoopSound("amb_fah_rain_light_loop");
    storm_sounds_volMod("scripted2", 1, 3);

    sun_scriptables = GetScriptableArray("sun_scriptable", "targetname");
    foreach(sun in sun_scriptables) {
      sun SetScriptablePartState(0, "storm_stage_1");
    }

    foreach(player in level.players) {
      player VisionSetStage(Int(min(1, level.storm_stage)), transition_time);
    }
    wait(transition_time);
    rainFXStage(level.storm_stage);

    remaining_time = (level.stage_2_fraction * match_duration) - ((current_fraction * match_duration) + transition_time);
    wait(remaining_time);
    current_fraction = level.stage_2_fraction;
  }
  level notify("storm_stage_2");
  level.storm_stage = 2;
  exploder(1);
  level thread storm_sound_stage("storm_sound_stage_2");

  level.heavyRainEmitEnt = spawn("script_origin", (0, 0, 0));

  storm_sounds_volMod("scripted3", 0, 0);

  wait(0.05);
  level.heavyRainEmitEnt playLoopSound("amb_fah_rain_heavy_loop");

  storm_sounds_volMod("scripted3", 1, 3);

  wait(0.05);
  storm_sounds_volMod("scripted2", 0, 3);

  rainFXStage(level.storm_stage);
  if(start_fraction >= level.stage_2_fraction) {
    foreach(player in level.players) {
      player VisionSetStage(Int(min(1, level.storm_stage)), 0.1);
    }
  } else {
    foreach(player in level.players) {
      player VisionSetStage(Int(min(1, level.storm_stage)), transition_time);
    }
  }

}

storm_sound_stage(origin_targetname) {
  time_between_sounds = .9;

  sound_origins = getEntArray(origin_targetname, "targetname");
  foreach(org in sound_origins) {
    sound_name = org.script_noteworthy;

    if(isDefined(sound_name)) {
      org playLoopSound(sound_name);
    } else {
      AssertMsg("Storm Sound @" + org.origin + " missing script_noteworthy sound name.");
    }

    wait time_between_sounds;
  }
}

storm_sounds_volMod(volmod, value, time) {
  level.volmods[volmod] = value;

  foreach(player in level.players) {
    player SetVolMod(volmod, value, time);
  }
}

watch_storm_dvar() {
  dvar_name = "storm_stage";
  default_stage = 0;
  SetDevDvarIfUninitialized(dvar_name, default_stage);
  while(1) {
    value = GetDvarInt(dvar_name, default_stage);
    if(value == level.storm_stage) {
      waitframe();
    } else {
      if((value > 2) || (value < 0)) {
        println("Invalid storm stage. Valid values are 0, 1, 2.");
      } else {
        setDvar(dvar_name, value);
        level.storm_stage = value;
        rainFXStage(level.storm_stage);
        foreach(player in level.players) {
          player VisionSetStage(Int(min(1, level.storm_stage)), 0.1);
        }
        level notify("stop_dynamic_events");
      }
      waitframe();
    }
  }
}

rotate_skydome(start_fraction, end_fraction, rotation_time) {
  min_angle = 0;
  max_angle = -70;

  start_fraction = min(1, start_fraction / level.stage_1_fraction);
  end_fraction = min(1, end_fraction / level.stage_1_fraction);

  level.skydome RotatePitch(180, 0.1);
  wait(0.1);
  level.skydome RotatePitch(start_fraction * max_angle, 0.1);
  gameFlagWait("prematch_done");

  level.skydome RotatePitch((end_fraction - start_fraction) * max_angle, max(0.1, (end_fraction - start_fraction) * rotation_time));
}

connect_watch() {
  while(1) {
    level waittill("connected", player);
    if(isDefined(level.storm_stage)) {
      player VisionSetStage(Int(min(1, level.storm_stage)), 0.1);
    }

    foreach(volmod, value in level.volmods) {
      player SetVolMod(volmod, value);
    }
  }
}

AreaParallelPipid(A, B, C) {
  return ((A[0] * B[1] - A[1] * B[0]) + (B[0] * C[1] - C[0] * B[1]) + (C[0] * A[1] - A[0] * C[1]));
}

AreaTriange(A, B, C) {
  return (AreaParallelPipid(A, B, C) * 0.5);
}

LRTest(Test, Start, End, Tolerance) {
  if(!isDefined(Tolerance))
    Tolerance = 0.0;

  Area = AreaParallelPipid(Start, End, Test);
  if(Area > Tolerance) {
    return SIDE_LEFT;
  }
  if(Area < (Tolerance * -1)) {
    return SIDE_RIGHT;
  }
  return SIDE_NONE;
}

Project(V, U) {
  Scale = (VectorDot(V, U) / LengthSquared(U));
  return [U * Scale, Scale];
}

ProjectToLine(Point, Start, Stop) {
  Point -= Start;
  [Point, Scale] = Project(Point, Stop - Start);
  Point += Start;
  return [Point, Scale];
}

ProjectToLineSeg(Point, Start, Stop) {
  [Point, Scale] = ProjectToLine(Point, Start, Stop);
  if(Scale < 0.0) {
    Point = Start;
  } else if(Scale > 1.0) {
    Point = Stop;
  }
  return [Point, Scale];
}

DistToLine(Point, Start, Stop) {
  [PointOnLine, Scale] = ProjectToLine(Point, Start, Stop);

  return Distance(PointOnLine, Point);
}