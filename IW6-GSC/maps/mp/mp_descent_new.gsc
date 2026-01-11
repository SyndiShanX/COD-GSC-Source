/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_descent_new.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#using_animtree("animated_props_mp_descent");

CONST_EARTHQUAKE_RANGE = 5000;
CONST_DEFAULT_PREFALL_TIME = 1.5;
CONST_DEFAULT_FALL_TIME = 3.0;
CONST_DEFAULT_SETTLE_TIME = 1.5;
CONST_DEFAULT_MAX_ROLL = 6;
CONST_DEFAULT_MIN_ROLL = 4;
CONST_DEFAULT_MAX_PITCH = 3;
CONST_DEFAULT_MIN_PITCH = 2;
CONST_FALL_EXPLODER_ID = 1;
CONST_GLASS_BUILDING_EXPLODER_ID = 3;
CONST_CONCRETE_FACADE_NAME = "concrete_building";
CONST_CONCRETE_FACADE_RUIN_MODEL = "desc_building_destroyed_02";
CONST_GLASS_FACADE_NAME = "facade_glass_";

CONST_COLUMN_FALL_ANIM = "mp_descent_column_collapsing";
CONST_COLUMN_FALL_SFX = "scn_dest_collapse_fall";
CONST_COLUMN_IMPACT_SFX = "scn_dest_collapse_impact";
CONST_COLUMN_IMPACT_VFX_EXPLODER_ID = 23;
CONST_COLUMN_IMPACT_OFFSET = 180;
CONST_COLUMN_IMPACT_DELAY = 3.5;
CONST_COLUMN_DAMAGE_RADIUS = 192;
CONST_COLUMN_DAMAGE = 500;

CONST_SNIPER_DUCT_ANGLE = -90;
CONST_SNIPER_DUCT_TIME = 1;

CONST_EVENT_TRIGGER_FALL_DELAY_MIN = 3;
CONST_EVENT_TRIGGER_FALL_DELAY_MAX = 6;

main() {
  maps\mp\mp_descent_new_precache::main();
  maps\createart\mp_descent_new_art::main();
  maps\mp\mp_descent_new_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_descent_new");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_specularColorScale", 2.5, 2.5);

  if(level.ps3) {
    SetDvar("sm_sunShadowScale", "0.5");
    SetDvar("sm_sunsamplesizenear", ".15");
  } else if(level.xenon) {
    SetDvar("sm_sunShadowScale", "0.8");
    SetDvar("sm_sunsamplesizenear", ".25");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "elite";

  level thread watersheet_trig_setup();

  thread debugDescent();

  animLength = GetAnimLength( % mp_descent_light01_fall);
  animateScriptableProps("animated_model_descent_light01", animLength);
  animLength = GetAnimLength( % mp_descent_light02_fall);
  animateScriptableProps("animated_model_descent_light02", animLength);
  animLength = GetAnimLength( % mp_descent_light03_fall);
  animateScriptableProps("animated_model_descent_light03", animLength);
  animLength = GetAnimLength( % mp_descent_light04_fall);
  animateScriptableProps("animated_model_descent_light04", animLength);
  animLength = GetAnimLength( % mp_descent_phone01_fall);
  animateScriptableProps("animated_model_descent_phone01", animLength);
  animLength = GetAnimLength( % mp_descent_phone02_fall);
  animateScriptableProps("animated_model_descent_phone02", animLength);
  animLength = GetAnimLength( % mp_descent_microwave_fall);
  animateScriptableProps("animated_model_descent_microwave", animLength);
  animLength = GetAnimLength( % mp_descent_tv01_fall);
  animateScriptableProps("animated_model_descent_tv01", animLength);

  animLength = GetAnimLength( % mp_descent_whiteboard_fall);
  animateScriptableProps("animated_model_descent_whiteboard", animLength);
  animateScriptableProps("animated_model_descent_bulletinboard", animLength);
  animLength = GetAnimLength( % mp_descent_kitchen_fall);
  animateScriptableProps("animated_model_descent_kitchen", animLength);

  level setupBuildingCollapse();

  level thread connect_watch();

  thread setupCollapsingColumn("column");
  thread setupSniperDuct("sniper_mover");
}

connect_watch() {
  while(1) {
    level waittill("connected", player);
    thread connect_watch_endofframe(player);
  }
}

connect_watch_endofframe(player) {
  player endon("death");

  waittillframeend;
  if(isDefined(level.vista)) {
    player PlayerSetGroundReferenceEnt(level.vista);
  }
}

spawn_watch() {
  while(1) {
    level waittill("player_spawned", player);
    if(isDefined(level.vista)) {
      player PlayerSetGroundReferenceEnt(level.vista);
    }
  }
}

anglesClamp180(angles) {
  return (AngleClamp180(angles[0]), AngleClamp180(angles[1]), AngleClamp180(angles[2]));
}

world_tilt() {
  level endon("game_ended");

  damage_triggers = getEntArray("world_tilt_damage", "targetname");
  array_thread(damage_triggers, ::world_tilt_damage_watch);

  vista_ents = getEntArray("vista", "targetname");
  if(!vista_ents.size) {
    return;
  }
  level.vista = vista_ents[0];
  foreach(ent in vista_ents) {
    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "main") {
      level.vista = ent;
      break;
    }
  }

  level.vista_rotation_origins = [];
  rotation_orgs = getstructarray("rotation_point", "targetname");
  foreach(org in rotation_orgs) {
    if(!isDefined(org.script_noteworthy)) {
      continue;
    }
    org.angles = (0, 0, 0);

    level.vista_rotation_origins[org.script_noteworthy] = org;
  }

  foreach(ent in vista_ents) {
    if(ent != level.vista) {
      if(isDefined(ent.classname) && IsSubStr(ent.classname, "trigger")) {
        ent EnableLinkTo();
      }
      ent LinkTo(level.vista);
    }
    if(!isDefined(ent.target)) {
      continue;
    }
    targets = getEntArray(ent.target, "targetname");
    foreach(target in targets) {
      if(!isDefined(target.script_noteworthy)) {
        target.script_noteworthy = "link";
      }

      switch (target.script_noteworthy) {
        case "link":
          target LinkTo(ent);
          break;
        default:
          break;
      }
    }
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(player in level.players) {
    player PlayerSetGroundReferenceEnt(level.vista);
  }

  level.max_world_pitch = 8;
  level.max_world_roll = 8;

  max_abs_pitch = level.max_world_pitch;
  max_abs_roll = level.max_world_roll;
  max_fall_dist = 6500;
  num_lerp_tilts = 2;
  tilt_chance = .5;
  multi_fall_chance = [0, 0, 1, 0];

  test_vista = spawnStruct();
  test_vista.origin = level.vista.origin;
  test_vista.angles = level.vista.angles;

  vista_trans = [];
  while(1) {
    rotate_to = (0, 0, 0);
    if(tilt_chance < RandomFloat(1)) {
      rotate_to = (RandomFloatRange(-1 * max_abs_pitch, max_abs_pitch), 0, RandomFloatRange(-1 * max_abs_roll, max_abs_roll));
    }

    move_by = (0, 0, RandomFloatRange(200, 1000));

    scale = 1;
    if(num_lerp_tilts > 0) {
      scale = (vista_trans.size + 1) / num_lerp_tilts;
      scale = clamp(scale, 0, 1.0);
    }

    rotate_to *= scale;
    move_by *= scale;

    trans = test_vista world_tilt_get_trans(move_by, rotate_to);
    if(trans["origin"][2] > level.vista.origin[2] + max_fall_dist) {
      break;
    }
    trans["time"] = RandomFloatRange(1, 2) * scale;

    test_vista.origin = trans["origin"];
    test_vista.angles = trans["angles"];

    vista_trans[vista_trans.size] = trans;
  }

  fall_count = vista_trans.size;

  extra_z = level.vista.origin[2] + max_fall_dist - vista_trans[vista_trans.size - 1]["origin"][2];
  if(extra_z > 0) {
    add_z = array_zero_to_one(vista_trans.size, .5);
    for(i = 0; i < vista_trans.size; i++) {
      vista_trans[i]["origin"] += (0, 0, add_z[i] * extra_z);
    }
  }

  fall_wait_times = array_zero_to_one(fall_count, .5);
  for(i = 0; i < fall_wait_times.size - 1; i++) {
    multi_fall_start = i;
    multi_fall_end = i;

    chance = RandomFloatRange(0, 1);
    max_falls = int(min(multi_fall_chance.size - 1, fall_wait_times.size - i));
    for(j = max_falls; j >= 2; j--) {
      if(multi_fall_chance[j] > chance) {
        multi_fall_end = multi_fall_start + (j - 1);
        break;
      }
    }

    multi_fall_count = multi_fall_end - multi_fall_start;
    if(multi_fall_count > 0) {
      delta = fall_wait_times[multi_fall_end] - fall_wait_times[multi_fall_start];
      delta *= RandomFloatRange(.2, .8);

      new_time = fall_wait_times[multi_fall_start] + delta;
      for(j = multi_fall_start; j <= multi_fall_end; j++) {
        fall_wait_times[j] = new_time;
      }
      i += multi_fall_count;
    }
  }

  for(i = 0; i < vista_trans.size; i++) {
    level.tilt_active = false;
    tilt_wait(fall_wait_times[i]);

    level.tilt_active = true;

    trans = vista_trans[i];
    move_time = trans["time"];

    trans = vista_trans[i];
    level.vista world_tilt_move(trans);
    Earthquake(.35, 2, level.vista.origin, 100000);

  }
}

world_tilt_damage_watch() {
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type);

    if(level.tilt_active) {
      continue;
    }
    if(!isDefined(damage) || damage < 150) {
      continue;
    }
    if(!isDefined(type) || type != "MOD_PROJECTILE") {
      continue;
    }
    self thread world_tilt_damage(damage);
  }
}

world_tilt_damage(damage) {
  damage_min = 100;
  damage_max = 1000;
  damage_scale = clamp((damage - damage_min) / (damage_max - damage_min), .1, 1);

  pitch_move = RandomFloatRange(2, 3) * damage_scale;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "east") {
    pitch_move *= -1.0;
  }

  new_pitch = level.vista.angles[0] + pitch_move;
  new_pitch = Clamp(new_pitch, -1 * level.max_world_pitch, level.max_world_pitch);

  new_angles = (new_pitch, level.vista.angles[1], level.vista.angles[2]);

  move_time = .2;
  level.vista RotateTo(new_angles, move_time);
  Earthquake(.2, 1, level.vista.origin, 100000);
  wait move_time;
}

wait_game_percent_complete(time_percent, score_percent) {
  if(!isDefined(score_percent)) {
    score_percent = time_percent;
  }

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
  timePassed = (getTime() - level.startTime) / 1000;

  if(ignore_score) {
    while(timePassed < time_threshold) {
      wait(0.5);
      timePassed = (getTime() - level.startTime) / 1000;
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
      timePassed = (getTime() - level.startTime) / 1000;
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
        if(isDefined(player.score) && player.score > highestScore) {
          highestScore = player.score;
        }
      }
    }
  }
  return highestScore;
}

world_tilt_get_trans(move_delta, rotate_to) {
  delta_angles = anglesClamp180(rotate_to - self.angles);

  rotation_point = level.vista_rotation_origins["south"];
  if(delta_angles[2] < 0) {
    rotation_point = level.vista_rotation_origins["north"];
  }

  rotation_point.angles = self.angles;

  goal = spawnStruct();
  goal.origin = rotation_point.origin + move_delta;
  goal.angles = rotate_to;

  trans = TransformMove(goal.origin, goal.angles, rotation_point.origin, rotation_point.angles, self.origin, self.angles);

  return trans;
}

world_tilt_move(trans) {
  exploder(1);
  level thread tilt_sounds();

  move_time = trans["time"];
  if(trans["origin"] != self.origin) {
    self MoveTo(trans["origin"], move_time, move_time);
  }
  if(anglesClamp180(trans["angles"]) != anglesClamp180(self.angles)) {
    self RotateTo(trans["angles"], move_time);
  }

  Earthquake(RandomFloatRange(.3, .5), move_time, self.origin, 100000);
  wait move_time;
}

array_zero_to_one_rand(count, min_value, max_value, sum_to) {
  if(!isDefined(min_value)) {
    min_value = 0;
  }
  if(!isDefined(max_value)) {
    max_value = 1;
  }

  a = [];
  sum = 0;
  for(i = 0; i < count; i++) {
    a[i] = RandomFloatRange(min_value, max_value);
    sum += a[i];
  }

  if(isDefined(sum_to)) {
    for(i = 0; i < count; i++) {
      if(sum != 0) {
        a[i] = a[i] / sum;
        a[i] = a[i] * sum_to;
      } else {
        a[i] = sum_to / count;
      }
    }
  }

  return a;
}

array_zero_to_one(count, rand, sum_to) {
  if(!isDefined(rand)) {
    rand = 0;
  }

  a = [];

  center_offset = (1 / count) * .5;
  sum = 0;
  for(i = 0; i < count; i++) {
    a[i] = (i / count) + center_offset;

    if(rand > 0) {
      a[i] = a[i] + RandomFloatRange(-1 * center_offset * rand, center_offset * rand);
    }

    sum += a[i];
  }

  if(isDefined(sum_to)) {
    for(i = 0; i < count; i++) {
      a[i] = a[i] / sum;
      a[i] = a[i] * sum_to;
    }
  }

  return a;
}

tilt_wait(game_percent) {
  level endon("tilt_start");

  level thread tilt_wait_dvar();

  wait_game_percent_complete(game_percent);
  level notify("tilt_start");
}

tilt_wait_dvar() {
  level endon("tilt_start");

  dvar_name = "trigger_tilt";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);

  while(GetDvarInt(dvar_name) == default_value) {
    waitframe();
  }
  SetDvar(dvar_name, GetDvarInt(dvar_name) - 1);

  level notify("tilt_start");
}

tilt_sounds() {
  sound_origins = getstructarray("tilt_sound", "targetname");

  foreach(org in sound_origins) {
    playSoundAtPos(org.origin, "cobra_helicopter_crash");
  }
}

watersheet_trig_setup() {
  level endon("game_ended");
  self endon("death");
  self endon("using_remote");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");

  trig = getent("watersheet", "targetname");

  while(1) {
    trig waittill("trigger", player);

    if(!isDefined(player.isTouchingWaterSheetTrigger) || player.isTouchingWaterSheetTrigger == false) {
      thread watersheet_playFX(player);

    }

  }
}

watersheet_playFX(player) {
  player.isTouchingWaterSheetTrigger = true;

  player SetWaterSheeting(1, 2);
  wait(randomfloatrange(.15, .75));
  player SetWaterSheeting(0);

  player.isTouchingWaterSheetTrigger = false;
}

watersheet_sound(trig) {
  trig endon("death");
  thread watersheet_sound_play(trig);
  while(1) {
    trig waittill("trigger", player);

    trig.sound_end_time = GetTime() + 100;
    trig notify("start_sound");
  }
}

watersheet_sound_play(trig) {
  trig endon("death");

  while(1) {
    trig waittill("start_sound");

    trig playLoopSound("scn_jungle_under_falls_plr");

    while(trig.sound_end_time > GetTime()) {
      wait(trig.sound_end_time - GetTime()) / 1000;
    }

    trig StopLoopSound();
  }
}

animateScriptableProps(targetName, fallAnimLength) {
  ents = GetScriptableArray(targetName, "targetname");

  foreach(ent in ents) {
    ent thread animateOneScriptableProp(fallAnimLength);
  }
}

animateOneScriptableProp(fallAnimLength) {
  while(true) {
    self SetScriptablePartState(0, "idle");

    level waittill("shake_props");

    frameDelay = RandomIntRange(0, 7) * 0.05;
    wait(frameDelay);

    self SetScriptablePartState(0, "fall");

    wait(fallAnimLength);

  }
}

CONST_DOUBLE_DOOR_MIN_DAMAGE = 50;
CONST_DOUBLE_DOOR_VFX = "equipment_explode_big";
CONST_DOUBLE_DOOR_ANGLE_MAX = 85;
CONST_DOUBLE_DOOR_EXPLODE_OPEN_TIME = 0.125;
doubleDoorCreate(doorName) {
  door = GetEnt(doorName, "targetname");
  if(isDefined(door)) {
    door.collision = GetEnt(doorName + "_clip", "targetname");

    door.ruins = [];
    door.ruins[0] = getRuin(doorName + "_upper");
    door.ruins[1] = getRuin(doorName + "_lower");

    door.destroyFxPoint = getstruct(door.ruins[0].target, "targetname");
    Assert(isDefined(door.destroyFxPoint));

    waitframe();
    door blockPath();

    door thread doubleDoorWaitForDamage();
  }
}

doubleDoorWaitForDamage() {
  self.health = 9999;
  self setCanDamage(true);

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, impact_loc, damage_type);
    if(IsExplosiveDamageMOD(damage_type) && damage > CONST_DOUBLE_DOOR_MIN_DAMAGE) {
      self thread doubleDoorDestroy(attacker, direction_vec, impact_loc);
    }
  }
}

doubleDoorDestroy(attacker, direction_vec, impact_loc) {
  self.collision clearPath();
  self clearPath();

  facingDir = anglesToForward(self.destroyFxPoint.angles);
  dotProd = VectorDot(facingDir, direction_vec);
  isFront = dotProd > 0;
  angleLimit = CONST_DOUBLE_DOOR_ANGLE_MAX;

  thread drawLine(self.destroyFxPoint.origin, self.destroyFxPoint.origin + 20 * facingDir, 50, (1, 0, 0));

  if(!isFront) {
    facingDir *= -1;
  } else {
    angleLimit *= -1;
  }

  playFX(getfx(CONST_DOUBLE_DOOR_VFX), self.destroyFxPoint.origin, facingDir);

  foreach(doorRuin in self.ruins) {
    doorRuin Show();
    doorRuin thread doorApplyImpulse(angleLimit);
    angleLimit *= -1;
  }
}

getRuin(ruinName) {
  ruin = GetEnt(ruinName, "targetname");
  Assert(isDefined(ruin));
  ruin Hide();

  return ruin;
}

trapDoorCreate(doorName) {
  door = GetEnt(doorName, "targetname");
  if(isDefined(door)) {
    self.pathBlocker = GetEnt(door.target, "targetname");

    waitframe();
    self.pathBlocker blockPath();

    door thread trapDoorWaitForDamage();
  }
}

trapDoorWaitForDamage() {
  self.health = 9999;
  self setCanDamage(true);

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, impact_loc, damage_type);

    self thread trapDoorDestroy(attacker, direction_vec, impact_loc);
  }
}

trapDoorDestroy(attacker, direction_vec, impact_loc) {
  self.pathBlocker NotSolid();
  self.pathBlocker clearPath();

  anglelimit = 90.0;

  self thread doorApplyImpulse(angleLimit);
}

doorApplyImpulse(angleLimit) {
  self RotateBy((angleLimit, 0, 0), CONST_DOUBLE_DOOR_EXPLODE_OPEN_TIME, CONST_DOUBLE_DOOR_EXPLODE_OPEN_TIME, 0);
}

clearPath() {
  self ConnectPaths();
  self Hide();
  self NotSolid();
}

blockPath() {
  self Solid();
  self Show();
  self DisconnectPaths();
}

GRAVITY_DVAR = "phys_gravity";
levitateProps(minTime, maxTime) {
  baseGravity = GetDvarInt(GRAVITY_DVAR, -800);
  SetDvar(GRAVITY_DVAR, 0);

  PhysicsJitter(level.mapCenter, 2500, 0, 5.0, 5.0);

  gravityTime = RandomFloatRange(minTime, maxTime);

  wait(gravityTime);

  SetDvar(GRAVITY_DVAR, baseGravity);
}

moverCreate(moverName, triggerFlag) {
  mover = GetEnt(moverName, "targetname");
  mover.collision = GetEnt(moverName + "_collision", "targetname");

  if(isDefined(mover.collision)) {
    mover.collision LinkTo(mover);
    mover.collision thread moverExplosiveTrigger(triggerFlag);
  }

  mover.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;

  ent = mover;
  ent.keyframes = [];
  nextKeyFrameName = ent.target;
  i = 0;
  while(isDefined(nextKeyFrameName)) {
    struct = getstruct(nextKeyFrameName, "targetname");
    if(isDefined(struct)) {
      ent.keyframes[i] = struct;

      if(!isDefined(struct.script_duration)) {
        struct.script_duration = 1.0;
      }

      if(!isDefined(struct.script_accel)) {
        struct.script_accel = 0.0;
      }

      if(!isDefined(struct.script_decel)) {
        struct.script_decel = 0.0;
      }

      i++;
      nextKeyFrameName = struct.target;
    } else {
      break;
    }
  }

  mover thread moverDoMove(triggerFlag);
}

moverExplosiveTrigger(note) {
  level endon("game_ended");

  if(!isDefined(note)) {
    note = "explosive_damage";
  }

  self setCanDamage(true);
  while(true) {
    self.health = 1000000;
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(IsExplosiveDamageMOD(type)) {
      level notify(note, self);
    }
  }
}

moverDoMove(waitString) {
  level endon("game_ended");

  while(true) {
    level waittill(waitString, mover);

    if(!isDefined(mover) || mover == self) {
      break;
    }
  }

  for(i = 1; i < self.keyframes.size; i++) {
    kf = self.keyframes[i];

    self MoveTo(kf.origin, kf.script_duration, kf.script_accel, kf.script_decel);
    self RotateTo(kf.angles, kf.script_duration, kf.script_accel, kf.script_decel);

    if(isDefined(kf.shakeMag)) {
      Earthquake(kf.shakeMag, kf.shakeDuration, self.origin, kf.shakeDistance);
    }

    self waittill("movedone");
  }

  fakeImpactPoint = self.origin + (0, 0, 2000);

  Earthquake(0.25, .5, fakeImpactPoint, 3000);
}

animatedMoverCreate(entName, animName, fallSound, impactSound, impactDelay, impactOffset) {
  mover = GetEnt(entName, "targetname");

  if(isDefined(mover)) {
    level waittill("trigger_movers");

    if(isDefined(fallSound)) {
      mover playSound(fallSound);
    }

    mover ScriptModelPlayAnim(animName);

    if(isDefined(impactSound)) {
      wait(impactDelay);

      PlaySoundAtPos(impactOffset, impactSound);
    }
  }
}

setupCollapsingColumn(entName) {
  mover = GetEnt(entName, "targetname");
  if(isDefined(mover)) {
    rubble = GetEnt(entName + "_debris_clip", "targetname");

    rubble NotSolid();

    fallNum = RandomIntRange(1, level.dropNodes.size);
    fallString = "buildingCollapseEnd_" + fallNum;

    level waittill_any(fallString, "trigger_movers");

    mover playSound(CONST_COLUMN_FALL_SFX);

    mover ScriptModelPlayAnim(CONST_COLUMN_FALL_ANIM);

    impactPos = rubble.origin + (0, 0, 10);

    wait(CONST_COLUMN_IMPACT_DELAY);

    PlaySoundAtPos(impactPos, CONST_COLUMN_IMPACT_SFX);

    exploder(CONST_COLUMN_IMPACT_VFX_EXPLODER_ID);

    Earthquake(0.3, 0.25, impactPos, 500);

    RadiusDamage(impactPos, CONST_COLUMN_DAMAGE_RADIUS, CONST_COLUMN_DAMAGE, CONST_COLUMN_DAMAGE, undefined, "MOD_CRUSH");

    rubble Solid();

  }
}

setupSniperDuct(entName) {
  duct = GetEnt(entName, "targetname");
  if(isDefined(duct)) {
    rootStruct = getstruct(entName + "_origin", "targetname");
    root = spawn("script_model", rootStruct.origin);
    duct LinkTo(root);

    duct2 = GetEnt(duct.target, "targetname");
    duct2 LinkTo(root);

    fallNum = RandomIntRange(1, level.dropNodes.size);
    fallString = "buildingCollapseEnd_" + fallNum;

    level waittill_any(fallString, "trigger_movers");

    root RotatePitch(1.1 * CONST_SNIPER_DUCT_ANGLE, CONST_SNIPER_DUCT_TIME, 0.85 * CONST_SNIPER_DUCT_TIME, 0.15 * CONST_SNIPER_DUCT_TIME);
    wait(CONST_SNIPER_DUCT_TIME);

    CONST_SWING_PERCENTAGE = 0.5;
    recoveryTime = CONST_SWING_PERCENTAGE * CONST_SNIPER_DUCT_TIME;
    root RotatePitch(-0.15 * CONST_SNIPER_DUCT_ANGLE, recoveryTime, 0.5 * recoveryTime, 0.5 * recoveryTime);
    wait(recoveryTime);

    root RotatePitch(0.05 * CONST_SNIPER_DUCT_ANGLE, recoveryTime, 0.5 * recoveryTime, 0.5 * recoveryTime);
    wait(recoveryTime);

  }
}

setupBuildingCollapse() {
  level.soundSources = [];
  soundStructs = getstructarray("tilt_sound", "targetname");
  if(isDefined(soundStructs)) {
    foreach(struct in soundStructs) {
      level.soundSources[struct.script_label] = struct;
    }
  }

  level.collapseSettings = [];

  curSettings = [];
  curSettings["prefalltime"] = CONST_DEFAULT_PREFALL_TIME;
  curSettings["falltime"] = CONST_DEFAULT_FALL_TIME;
  curSettings["sfx"] = [];
  curSettings["sfx"]["rubble_left"] = "scn_bldg_fall1_rubble_left";
  curSettings["sfx"]["rubble_right"] = "scn_bldg_fall1_rubble_right";
  curSettings["sfx"]["glass_left"] = "scn_bldg_fall1_glass_left";
  curSettings["sfx"]["glass_right"] = "scn_bldg_fall1_glass_right";
  level.collapseSettings[level.collapseSettings.size] = curSettings;

  curSettings = [];
  curSettings["prefalltime"] = CONST_DEFAULT_PREFALL_TIME;
  curSettings["falltime"] = CONST_DEFAULT_FALL_TIME;
  curSettings["sfx"] = [];
  curSettings["sfx"]["rubble_left"] = "scn_bldg_fall2_rubble_left";
  curSettings["sfx"]["rubble_right"] = "scn_bldg_fall2_rubble_right";
  curSettings["sfx"]["glass_left"] = "scn_bldg_fall2_glass_left";
  curSettings["sfx"]["glass_right"] = "scn_bldg_fall2_glass_right";
  level.collapseSettings[level.collapseSettings.size] = curSettings;

  curSettings = [];
  curSettings["prefalltime"] = CONST_DEFAULT_PREFALL_TIME;
  curSettings["falltime"] = CONST_DEFAULT_FALL_TIME;
  curSettings["sfx"] = [];
  curSettings["sfx"]["rubble_left"] = "scn_bldg_fall3_rubble_left";
  curSettings["sfx"]["rubble_right"] = "scn_bldg_fall3_rubble_right";
  curSettings["sfx"]["glass_left"] = "scn_bldg_fall3_glass_left";
  curSettings["sfx"]["glass_right"] = "scn_bldg_fall3_glass_right";
  level.collapseSettings[level.collapseSettings.size] = curSettings;

  curSettings = [];
  curSettings["prefalltime"] = CONST_DEFAULT_PREFALL_TIME;
  curSettings["falltime"] = CONST_DEFAULT_FALL_TIME;
  curSettings["sfx"] = [];
  curSettings["sfx"]["rubble_left"] = "scn_bldg_fall4_rubble_left";
  curSettings["sfx"]["rubble_right"] = "scn_bldg_fall4_rubble_right";
  curSettings["sfx"]["glass_left"] = "scn_bldg_fall4_glass_left";
  curSettings["sfx"]["glass_right"] = "scn_bldg_fall4_glass_right";
  level.collapseSettings[level.collapseSettings.size] = curSettings;

  curSettings = [];
  curSettings["prefalltime"] = 0.5;
  curSettings["falltime"] = CONST_DEFAULT_FALL_TIME;
  curSettings["sfx"] = [];
  curSettings["sfx"]["rubble_left"] = "scn_bldg_fall5_rubble_left";
  curSettings["sfx"]["rubble_right"] = "scn_bldg_fall5_rubble_right";
  curSettings["sfx"]["glass_left"] = "scn_bldg_fall5_glass_left";
  curSettings["sfx"]["glass_right"] = "scn_bldg_fall5_glass_right";
  level.collapseSettings[level.collapseSettings.size] = curSettings;

  level.vista = GetEnt("vista_test", "targetname");

  dropNodeOffsets = [];
  dropNodeOffsets[0] = 550;
  dropNodeOffsets[1] = 400;
  dropNodeOffsets[2] = 350;

  level.dropNodes = [];
  curNode = getstruct("drop_node2", "targetname");

  maxPitch = CONST_DEFAULT_MAX_PITCH;
  maxRoll = CONST_DEFAULT_MAX_ROLL;

  curHeight = level.vista.origin[2];
  i = 0;
  while(isDefined(curNode)) {
    curNode.angles = (RandomFloatRange(-1 * maxPitch, maxPitch), 0, RandomFloatRange(-1 * maxRoll, maxRoll));
    curNode.origin -= (0, 0, dropNodeOffsets[i]);
    i++;

    level.dropNodes[level.dropNodes.size] = curNode;

    if(isDefined(curNode.target)) {
      curNode = getstruct(curNode.target, "targetname");
    }
    else {
      break;
    }
  }

  level thread dropNodeWait();
  level thread setupDropEventTrigger();

  level.facadeConcrete = [];
  for(i = 0; i < level.dropNodes.size; i++) {
    entName = CONST_CONCRETE_FACADE_NAME + i;
    facade = GetEnt(entName, "targetname");
    facade LinkTo(level.vista);
    level.facadeConcrete[i] = facade;
  }

  level.facadeGlass = [];
  level.ruinGlass = [];
  for(i = 0; i < level.dropNodes.size; i++) {
    entName = CONST_GLASS_FACADE_NAME + i;
    facades = getEntArray(entName, "targetname");

    facades = array_sort_with_func(facades, ::compareHeight);

    level.facadeGlass[i] = facades;

    foreach(item in facades) {
      item LinkTo(level.vista);
    }

    ruinName = CONST_GLASS_FACADE_NAME + "ruin_" + i;
    ruin = GetEnt(ruinName, "targetname");
    if(isDefined(ruin)) {
      ruin LinkTo(level.vista);
      ruin Hide();
      level.ruinGlass[i] = ruin;
    }
  }
}

compareHeight(a, b) {
  return (a.origin[2] > b.origin[2]);
}

dropNodeWait() {
  level.dropStage = 0;

  while(level.dropStage < level.dropNodes.size) {
    level waittill("buildingCollapse");

    doBuildingFall(level.dropStage);

    level.dropStage++;
  }
}

doBuildingFall(nodeIndex) {
  level.buildingIsFalling = true;

  targetPos = level.dropNodes[nodeIndex];
  settings = level.collapseSettings[nodeIndex];

  startShockTime = settings["prefalltime"];
  moveTime = settings["falltime"];

  foreach(structName, struct in level.soundSources) {
    PlaySoundAtPos(struct.origin, settings["sfx"][structName]);
  }

  Earthquake(RandomFloatRange(0.1, 0.2), startShockTime, level.mapCenter, CONST_EARTHQUAKE_RANGE);

  targetRoll = RandomFloatRange(CONST_DEFAULT_MIN_ROLL, CONST_DEFAULT_MAX_ROLL);
  if(RandomFloat(1) < 0.5) {
    targetRoll *= -1;
  }

  targetPitch = RandomFloatRange(CONST_DEFAULT_MIN_PITCH, CONST_DEFAULT_MAX_PITCH);
  if(RandomFloat(1) < 0.5) {
    targetPitch *= -1;
  }

  targetAngle = (targetPitch, 0, targetRoll);
  level.vista RotateTo(0.75 * targetAngle, startShockTime, 1.0 * startShockTime, 0.0);

  level thread destroyAirKillstreaks();

  wait(startShockTime);

  level.disableVanguardsInAir = true;

  exploder(CONST_GLASS_BUILDING_EXPLODER_ID);

  playRumble("damage_light");

  Earthquake(RandomFloatRange(0.3, 0.45), moveTime, level.mapCenter, CONST_EARTHQUAKE_RANGE);

  level thread animateConcreteBuildingFacade(nodeIndex, moveTime);
  level thread animateGlassBuildingFacade(nodeIndex, moveTime);

  level.vista MoveTo(targetPos.origin, moveTime, 0.25 * moveTime, 0.0);
  level.vista RotateTo(-1 * targetAngle, moveTime, 0.25 * moveTime, 0.0);

  level notify("shake_props");
  level notify("buildingCollapseStart_" + nodeIndex);

  wait(moveTime);

  Earthquake(RandomFloatRange(0.8, 1.0), 1.5, level.mapCenter, CONST_EARTHQUAKE_RANGE);
  exploder(CONST_FALL_EXPLODER_ID);
  exploder(CONST_GLASS_BUILDING_EXPLODER_ID);

  level notify("buildingCollapseEnd_" + nodeIndex);

  level.disableVanguardsInAir = undefined;

  playRumble("artillery_rumble");

  wait(0.5);

  settleTime = CONST_DEFAULT_SETTLE_TIME;
  finalAngles = (-0.25 * targetPitch, 0, 0.25 * targetRoll);
  level.vista RotateTo(finalAngles, settleTime, 0.8 * settleTime, 0.2 * settleTime);

  wait(0.75 * settleTime);
  Earthquake(RandomFloatRange(0.3, 0.5), 0.25 * settleTime + 1.0, level.mapCenter, CONST_EARTHQUAKE_RANGE);

  playRumble("damage_light");

  level.buildingIsFalling = undefined;
}

animateConcreteBuildingFacade(nodeIndex, moveTime) {
  facade = level.facadeConcrete[nodeIndex];
  if(isDefined(facade)) {
    oldModel = facade.model;
    facade setModel(CONST_CONCRETE_FACADE_RUIN_MODEL);

    oldFace = spawn("script_model", facade.origin);
    oldFace.angles = facade.angles;
    oldFace setModel(oldModel);

    upVec = AnglesToUp(oldFace.angles);

    endPos = oldFace.origin - 150 * upVec;
    oldFace MoveTo(endPos, moveTime, moveTime, 0);
    oldFace RotateRoll(20, moveTime, moveTime, 0);

    wait(movetime);
    oldFace Delete();
  }
}

animateGlassBuildingFacade(nodeIndex, moveTime) {
  if(isDefined(level.facadeGlass[nodeIndex])) {
    timeStep = moveTime / level.facadeGlass[nodeIndex].size;

    level.ruinGlass[nodeIndex] Show();

    foreach(item in level.facadeGlass[nodeIndex]) {
      item thread glassFacadeFall(moveTime);
      wait(timeStep);
    }
  }
}

glassFacadeFall(moveTime) {
  self Unlink();

  upVec = AnglesToUp(self.angles);

  endPos = self.origin - 400 * upVec;
  self MoveTo(endPos, moveTime, moveTime, 0);
  self RotateRoll(-60, moveTime, moveTime, 0);

  wait(moveTime);

  self Delete();
}

setupDropEventTrigger() {
  numIntervals = level.dropNodes.size + 1;

  if(level.gameType == "sr" || level.gameType == "sd") {
    level thread searchAndRescueEventTriggerDrop();
  } else {
    scoreLimit = getWatchedDvar("scorelimit");
    if(level.teamBased && scoreLimit >= level.dropNodes.size * 20) {
      level thread scoreLimitTriggerDrop(scoreLimit, level.dropNodes.size);
    } else {
      timeLimit = getWatchedDvar("timelimit");
      if(timeLimit <= 0) {
        timeLimit = 10;
      }
      timeLimit *= 60;

      level thread timeLimitTriggerDrop(timeLimit, numIntervals);
    }
  }
}

searchAndRescueEventTriggerDrop() {
  level endon("game_ended");

  while(true) {
    result = level waittill_any_return("last_alive", "bomb_exploded", "bomb_dropped");

    if(result == "last_alive" || !level.bombPlanted) {
      interval = RandomFloatRange(CONST_EVENT_TRIGGER_FALL_DELAY_MIN, CONST_EVENT_TRIGGER_FALL_DELAY_MAX);
      wait(interval);
    } else if(result != "bomb_exploded") {
      continue;
    }

    level notify("buildingCollapse");
  }
}

scoreLimitTriggerDrop(scoreLimit, numDrops) {
  level endon("game_ended");

  level thread periodicTremor(90, 120);

  scoreInterval = Int(0.3 * scoreLimit);

  SetDvarIfUninitialized("scr_desc_scoreInterval", scoreInterval);

  curDrop = 1;

  while(true) {
    level waittill("update_team_score", team, newScore);

    scoreInterval = GetDvarInt("scr_desc_scoreInterval");

    if(newScore >= curDrop * scoreInterval) {
      interval = RandomFloatRange(CONST_EVENT_TRIGGER_FALL_DELAY_MIN, CONST_EVENT_TRIGGER_FALL_DELAY_MAX);
      wait(interval);

      level notify("buildingCollapse");
      curDrop++;
    }
  }
}

timeLimitTriggerDrop(timeLimit, numIntervals) {
  level endon("game_ended");

  timeInterval = timeLimit / numIntervals;

  level thread periodicTremor(0.8 * timeInterval, 1.2 * timeInterval);

  while(level.dropStage < level.dropNodes.size) {
    wait(timeInterval);
    level notify("buildingCollapse");
  }
}

periodicTremor(minTime, maxTime) {
  level endon("game_ended");

  interval = 0.5 * RandomFloatRange(minTime, maxTime);

  debugInterval = GetDvarInt("scr_dbg_tremor_interval");
  if(debugInterval > 0) {
    interval = debugInterval;
  }

  wait(interval);

  while(true) {
    if(!isDefined(level.buildingIsFalling)) {
      PlaySoundAtPos(level.mapCenter, "scn_bldg_tremor_lr");

      magnitude = RandomFloatRange(0.2, 0.3);
      duration = RandomFloatRange(1.0, 1.5);

      Earthquake(magnitude, duration, level.mapCenter, CONST_EARTHQUAKE_RANGE);

    }

    interval = RandomFloatRange(minTime, maxTime);

    debugInterval = GetDvarInt("scr_dbg_tremor_interval");
    if(debugInterval > 0) {
      interval = debugInterval;
    }

    wait(interval);
  }
}

setupBuildingFx() {
  fxRig = GetEnt("column_chunk", "targetname");

  playFXOnTag(getfx("vfx_building_debris_runner"), fxRig, "tag_03_vfx_building_debris_runner");
  playFXOnTag(getfx("vfx_spark_drip_dec_runner"), fxRig, "tag_02_vfx_spark_drip_dec_runner");
  playFXOnTag(getfx("vfx_building_hole_elec_short_runner"), fxRig, "tag_01_vfx_building_hole_elec_short_runner");
}

destroyAirKillstreaks() {
  destroyAirKillstreaksForTeam(undefined, "allies");
  destroyAirKillstreaksForTeam(undefined, "axis");
}

destroyAirKillstreaksForTeam(attacker, victimTeam) {
  maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", level.heli_pilot);
  if(isDefined(level.lbSniper)) {
    tempArray = [];
    tempArray[0] = level.lbSniper;
    maps\mp\killstreaks\_killstreaks::destroyTargetArray(attacker, victimTeam, "aamissile_projectile_mp", tempArray);
  }
}

playRumble(rumbleType) {
  foreach(player in level.players) {
    player PlayRumbleOnEntity(rumbleType);
  }
}

debugDescent() {
  SetDvarIfUninitialized("scr_dbg_shake_props", 0);
  SetDvarIfUninitialized("scr_dbg_movers", 0);
  SetDvarIfUninitialized("scr_dbg_building_collapse", 0);
  SetDvarIfUninitialized("scr_dbg_tremor_interval", 0);

  while(true) {
    checkDbgDvar("scr_dbg_shake_props", undefined, "shake_props");
    checkDbgDvar("scr_dbg_movers", undefined, "trigger_movers");
    checkDbgDvar("scr_dbg_building_collapse", undefined, "buildingCollapse");
    checkDbgDvar("scr_desc_fx", ::dbgFireFx, undefined);

    wait(0.1);
  }
}

checkDbgDvar(dvarName, callback, notifyStr) {
  if(GetDvarInt(dvarName) > 0) {
    if(isDefined(callback)) {
      [[callback]](GetDvarInt(dvarName));
    }

    if(isDefined(notifyStr)) {
      level notify(notifyStr);
    }

    SetDvar(dvarName, 0);
  }
}

dbgFireFx(fxId) {
  exploder(fxId);
}
# /