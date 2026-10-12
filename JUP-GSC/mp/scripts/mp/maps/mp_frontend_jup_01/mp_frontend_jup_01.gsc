/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01.gsc
*********************************************************************/

#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\frontendutils;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\maps\mp_frontend_jup_01\gen\mp_frontend_jup_01_art;
#using scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_fx;
#using scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting;
#using scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_precache;
#namespace mp_frontend_jup_01;

function onplayerconnectrunonce() {
  level endon("game_ended");
  self endon("disconnect");
  level namespace_46e942396566f2da::function_3b59b4d385a202e6();
  level.playerviewowner = self;
  level.var_590ffe018fb94089 = 1;
  level.var_8a919d89cd6129ae = "iw9_";
  level.var_9aa5b3137bd141b4 = "";
  level.var_939d7db4d53fd126 = 0;

  if(isDefined(level.playerconnectedevents)) {
    return;
  }

  level.playerconnectedevents = 1;
  init_struct_class();
  thread play_fx();
  thread function_b5f3ddb65d04e2fd();
  thread function_118645267f63501d();
  function_186283adf8bff6d8();
  self enablephysicaldepthoffieldscripting();
  wait 0.5;
  scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_fx::main();
  scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting::main();
}

function callback_frontendplayerconnect() {
  thread onplayerconnectrunonce();
}

function callback_frontendplayerdisconnect(reason) {
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
}

function function_725ec88952496746() {
  setDvar(@ "hash_8abfcbda995d5ac7", " 0.0 0.0 1.0");
  setDvar(@ "hash_b18595ca486864b7", "45 10");
  setDvar(@ "hash_46662909b0598f88", 0.45);
  setDvar(@ "hash_45b0a73a964f330c", 1);
  setDvar(@ "hash_8ed702d6312a78b0", 2);
  setDvar(@ "hash_bc82f376d1811fad", 2);
  setDvar(@ "hash_b071824130b16c58", 1);
  setDvar(@ "hash_d58971fc7e97aed6", "1 1");
  setDvar(@ "hash_8cd1e9b67117a0ff", 0.25);
}

function function_b5f3ddb65d04e2fd() {
  function_725ec88952496746();
  level.foamlarge = function_70a855dd0c75561c("foam_large");
  level.foammedium = function_70a855dd0c75561c("foam_med");
  level.foamsmall = function_70a855dd0c75561c("foam_small");
  level.foamlarge show();
  level.foammedium hide();
  level.foamsmall hide();
  setDvar(@ "hash_adb9d289548d38d9", "1 1");

  while(true) {
    self waittill("luinotifyserver", msg, arg);
    setDvar(@ "hash_52e4ca82ec45d480", 0);

    if(msg == "swap_gun_foam") {
      if(arg == 3) {
        setDvar(@ "hash_adb9d289548d38d9", "1 1");
        level.foamlarge show();
        level.foammedium hide();
        level.foamsmall hide();
        continue;
      }

      if(arg == 2) {
        setDvar(@ "hash_adb9d289548d38d9", "-1 -1");
        level.foamlarge hide();
        level.foammedium show();
        level.foamsmall hide();
        continue;
      }

      if(arg == 1) {
        setDvar(@ "hash_adb9d289548d38d9", "-1 -1");
        level.foamlarge hide();
        level.foammedium hide();
        level.foamsmall show();
      }
    }
  }
}

function function_90384e8d6b1996d5() {
  var_4d53cafbbd7bf91d = getEnt("shop_character_bg", "targetname");
  level.var_3455211a7fd01921 = spawn("script_model", var_4d53cafbbd7bf91d.origin);
  level.var_3455211a7fd01921.angles = var_4d53cafbbd7bf91d.angles;
  level.var_a41e68b26a527a29 = var_4d53cafbbd7bf91d.origin;
  var_5e2c7a5a2f9bab0e = getEnt("shop_bundle_bg", "targetname");
  level.var_2179aaba15b2d35e = spawn("script_model", var_5e2c7a5a2f9bab0e.origin);
  level.var_2179aaba15b2d35e.angles = var_5e2c7a5a2f9bab0e.angles;
  level.var_96b8921fe92408f1 = var_5e2c7a5a2f9bab0e.angles;
  level.var_5af5ef2a9a52f0ca = var_5e2c7a5a2f9bab0e.origin;
}

function main() {
  println("<dev string:x1c>");
  scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_precache::main();
  scripts\mp\maps\mp_frontend_jup_01\gen\mp_frontend_jup_01_art::main();
  scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_fx::main();

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.projectbundle = getprojectscriptbundle();
  level.gamemodebundle = getgamemodescriptbundle();
  init_frontend_utils();
  level.transition_interrupted = 0;
  level.showseasonalcontent = getdvarint(@ "hash_ca079d844e54e73a");
  level.ttlos_suppressasserts = 1;
  scripts\cp_mp\weapon::function_5238382582ce39fa();
  level.callbackplayerconnect = &callback_frontendplayerconnect;
  level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
  level thread function_777406e0dd520161();
  level thread function_90384e8d6b1996d5();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
}

function function_118645267f63501d() {
  level.lanetriggers = function_abdba932e247d9c2("shooting_range_lane_triggers");
  level.roomtrigger = function_70a855dd0c75561c("shooting_range_room_trigger");
  level.var_c19cc64d3f6aec77 = function_abdba932e247d9c2("enemyTarget");
  level.var_20e9b9e742a3703f = function_abdba932e247d9c2("firingrange_target_1");
  level.var_20e9bae742a37272 = function_abdba932e247d9c2("firingrange_target_2");
  level.var_20e9bbe742a374a5 = function_abdba932e247d9c2("firingrange_target_3");
  level.var_b609004a0ecec80f = array_combine(level.var_20e9b9e742a3703f, level.var_20e9bae742a37272, level.var_20e9bbe742a374a5);
  level.var_ace7bc84ecac30f5 = 0;

  foreach(frtarget in level.var_c19cc64d3f6aec77) {
    targetpositions = getStructArray(frtarget.target, "targetname");

    foreach(position in targetpositions) {
      switch (position.script_noteworthy) {
        case #"hash_683099596bfc9c1a":
          frtarget.position1 = position.origin;
          break;
        case #"hash_683098596bfc9a87":
          frtarget.position2 = position.origin;
          break;
        case #"hash_683097596bfc98f4":
          frtarget.position3 = position.origin;
          break;
        default:
          break;
      }
    }

    damagetriggers = getEntArray(frtarget.target, "targetname");

    foreach(trigg in damagetriggers) {
      trigg enablelinkTo();

      if(!isPlayer(trigg)) {
        trigg linkTo(frtarget);
      }
    }
  }

  foreach(light in level.var_b609004a0ecec80f) {
    light.var_86102e35e838b321 = light getlightintensity();
  }

  thread function_ba26a4bcb29225cb("lane1");

  foreach(trig in level.lanetriggers) {
    trig.var_27654d98d67bccc8 = 0;
    trig thread function_2e13e46e49665acb();
  }

  setomnvar("ui_firing_range_lane", -1);
  setomnvar("ui_firing_range_target_kill_count", 0);
}

function function_2e13e46e49665acb() {
  while(true) {
    if(!self.var_27654d98d67bccc8) {
      self waittill("trigger");
      thread function_f18749ddfef7d6c0(self.script_noteworthy);
      thread function_ba26a4bcb29225cb(self.script_noteworthy);
      level notify("firing_range_weapon_stats_reset");

      foreach(trig in level.lanetriggers) {
        trig.var_27654d98d67bccc8 = 0;
      }

      self.var_27654d98d67bccc8 = 1;
      setomnvar("ui_firing_range_target_kill_count", 0);
      setomnvar("ui_firing_range_accuracy", 0);
      level.var_91d278fb245d797b = 0;
      level.var_37a55ecaf979d920 = 0;
      level.bulletshitsecondary = 0;
      level.var_febc1f5f6fc40f70 = 0;
      level.var_31b6d2832a330f45 = 0;
      level.var_4e5b1ceaad66b065 = 0;
      level.primarydamagedealt = 0;
      level.secondarydamagedealt = 0;
      continue;
    }

    wait 1;
  }
}

function function_ba26a4bcb29225cb(lane) {
  foreach(light in level.var_b609004a0ecec80f) {
    light setlightintensity(0);
  }

  level.var_ace7bc84ecac30f5++;
  wait 1.5;

  if(level.var_ace7bc84ecac30f5 < 2) {
    switch (lane) {
      case #"hash_683099596bfc9c1a":
        foreach(light in level.var_20e9b9e742a3703f) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_683098596bfc9a87":
        foreach(light in level.var_20e9bae742a37272) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      case #"hash_683097596bfc98f4":
        foreach(light in level.var_20e9bbe742a374a5) {
          light setlightintensity(light.var_86102e35e838b321);
        }

        break;
      default:
        break;
    }
  }

  playsoundatpos((-6775, -3468, 80), "uin_firingrange_light_on");
  level.var_ace7bc84ecac30f5--;
}

function function_f18749ddfef7d6c0(newposition) {
  foreach(frtarget in level.var_c19cc64d3f6aec77) {
    switch (newposition) {
      case #"hash_683099596bfc9c1a":
        setomnvar("ui_firing_range_lane", 1);

        if(istrue(frtarget.var_9a74c6fbe0cf64eb)) {
          frtarget thread function_65cc3cb6946266d8(frtarget.position1);
        } else {
          frtarget thread watchdeathonmove(frtarget.position1);
        }

        break;
      case #"hash_683098596bfc9a87":
        setomnvar("ui_firing_range_lane", 2);

        if(istrue(frtarget.var_9a74c6fbe0cf64eb)) {
          frtarget thread function_65cc3cb6946266d8(frtarget.position2);
        } else {
          frtarget thread watchdeathonmove(frtarget.position2);
        }

        break;
      case #"hash_683097596bfc98f4":
        setomnvar("ui_firing_range_lane", 3);

        if(istrue(frtarget.var_9a74c6fbe0cf64eb)) {
          frtarget thread function_65cc3cb6946266d8(frtarget.position3);
        } else {
          frtarget thread watchdeathonmove(frtarget.position3);
        }

        break;
      default:
        setomnvar("ui_firing_range_lane", -1);
        setomnvar("ui_firing_range_target_kill_count", 0);
        setomnvar("ui_firing_range_accuracy", 0);
        break;
    }
  }
}

function watchdeathonmove(position) {
  self moveTo(position, 1.5, 0.25, 0.5);
  thread function_e9618a25a1c711d0();
  currenttime = gettime();
  endtime = currenttime + 1500;

  while(currenttime < endtime) {
    currenttime = gettime();

    if(istrue(self.var_9a74c6fbe0cf64eb)) {
      thread function_65cc3cb6946266d8(position);
      break;
    }

    wait 0.1;
  }
}

function function_65cc3cb6946266d8(position) {
  self notify("move_dummy");
  self endon("delete");
  self endon("move_dummy");

  while(istrue(self.var_9a74c6fbe0cf64eb)) {
    waitframe();
  }

  self moveTo(position, 1.5, 0.25, 0.5);
  thread function_e9618a25a1c711d0();
}

function function_e9618a25a1c711d0() {
  self playSound("uin_firingrange_target_move");
}

function play_fx() {
  waitframe();
  level.frontendfx = [];
  wait 0.5;
}

function endlesslobbyfloor() {
  wait 0.1;
  floor1 = getEnt("mp_lobby_floor_01", "targetname");
  var_d84ba0bfd9897989 = getEntArray("floor_01_clutter", "targetname");
  floor2 = getEnt("mp_lobby_floor_02", "targetname");
  floor2clutter = getEntArray("floor_02_clutter", "targetname");

  foreach(clutter in var_d84ba0bfd9897989) {
    clutter linkTo(floor1);
  }

  foreach(clutter in floor2clutter) {
    clutter linkTo(floor2);
  }

  middleposition = floor1.origin;
  initialposition = floor2.origin;
  dist = distance(middleposition, initialposition);
  speed = 36.96;
  time = dist / speed;
  finalposition = middleposition + vectorNormalize(middleposition - initialposition) * dist;
  initial = 1;

  while(true) {
    if(initial) {
      floor2 hide();
      floor2.origin += (0, 0, -200);
      waitframe();
      floor2.origin = initialposition + (0, 0, -200);
      waitframe();
      floor2.origin = initialposition;
      floor2 show();
      floor2 moveTo(middleposition, time);
      floor1 moveTo(finalposition, time);
    } else {
      floor1 hide();
      floor1.origin += (0, 0, -500);
      waitframe();
      floor1.origin = initialposition + (0, 0, -500);
      waitframe();
      floor1.origin = initialposition;
      floor1 show();
      floor1 moveTo(middleposition, time);
      floor2 moveTo(finalposition, time);
    }

    initial = !initial;
    wait time;
  }
}

function function_777406e0dd520161() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  damagefeedback_init();
  level.course_triggers = getEntArray("progression", "targetname");
  function_b73c05f4babd6b8e();
  level.course_targets = gettargetarray();
  level.civilian_targets = [];
  level.enemy_targets = [];

  foreach(targ in level.course_triggers) {
    targ thread trial_trigger_think();
  }

  foreach(targ in level.course_targets) {
    targ thread function_2c304f9c3c96cd70();
  }

  level.var_f350d6beb0d98524 = level.civilian_targets.size;
  level.var_bf2546e3156db5d9 = level.enemy_targets.size;
}

function function_2c304f9c3c96cd70() {
  self.initial_forward = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.initial_right = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking)) {
    level.targets_thinking = 0;
  }

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = array_remove(self.parts, self);

  foreach(part in self.parts) {
    switch (part.script_noteworthy) {
      case #"hash_8dfa7fb0771c3cf3":
        self.plate = part;
        break;
      case #"hash_901f1f5695d0ce90":
        self.plate = part;
        self.plate_dest = part;
        break;
      case #"hash_1004c5b17e830005":
        self.arm = part;
        break;
      case #"hash_a56b5d7ebc91b688":
        self.base = part;
        break;
      case #"hash_477619b8824acced":
        self.wheels = part;
        break;
      case #"hash_8dfcbc268496a780":
        self.aim_assist = part;
        break;
      case #"hash_539c8dfe6bc5ff1f":
        self.collision = part;
        break;
      case #"hash_544160f92836c76c":
        self.collision_down = part;
        break;
      case #"hash_926f72c617dfc74d":
        self.collision_up = part;
        break;
      default:
        break;
    }

    part.target = "null";
    part.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels)) {
    self.wheels linkTo(self.base);
  }

  if(isDefined(self.base)) {
    if(isDefined(self.collision)) {
      self.collision linkTo(self.base);
    }

    if(isDefined(self.collision_down)) {
      self.collision_down linkTo(self.base);
    }

    if(isDefined(self.collision_up)) {
      self.collision_up linkTo(self.base);
    }
  }

  if(issubstr(self.script_noteworthy, "civilian")) {
    self.is_civilian = 1;
    level.civilian_targets[level.civilian_targets.size] = self;
  } else {
    self.is_civilian = 0;
    level.enemy_targets[level.enemy_targets.size] = self;
  }

  thread trial_target_think();
}

function trial_target_think() {
  self notify("trial_target_think");
  self endon("trial_target_think");
  self.state_up = 0;
  self.flipping = 0;
  thread trial_target_damage();

  if(isDefined(self.plate_dest)) {
    thread trial_target_arm_damage();
  }

  self.activated = 0;
  thread trial_target_requisites();

  if(issubstr(self.script_noteworthy, "moving")) {
    thread trial_moving_target_think();
  }

  if(isDefined(level.trial_target_think_func)) {
    self[[level.trial_target_think_func]]();
  }

  if(isDefined(level.trial_target_thread_func)) {
    self thread[[level.trial_target_thread_func]]();
  }

  level.targets_thinking--;
}

function gettargetarray() {
  target_types = ["standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian"];
  target_arrays = [];

  for(i = 0; i < target_types.size; i++) {
    var_15684233dc41d60a[i] = getStructArray(target_types[i], "script_noteworthy");

    foreach(struct in var_15684233dc41d60a[i]) {
      ent = spawn("script_origin", struct.origin);
      ent.angles = struct.angles;
      ent.script_gameobjectname = struct.script_gameobjectname;
      ent.script_linkname = struct.script_linkname;
      ent.script_noteworthy = struct.script_noteworthy;
      ent.target = struct.target;
      ent.targetname = struct.targetname;
    }
  }

  for(i = 0; i < target_types.size; i++) {
    target_arrays[i] = getEntArray(target_types[i], "script_noteworthy");
  }

  return array_combine_multiple(target_arrays);
}

function trial_target_damage() {
  self notify("trial_target_damage");
  self endon("trial_target_damage");
  fxid = undefined;

  if(isDefined(self.plate_dest)) {
    hit_sound = "trial_sfx_target_report_clay_smash";
    fxid = level.impact_vfx;
  } else {
    hit_sound = "trial_sfx_target_report_metal_light";
  }

  while(true) {
    self.activated = 0;

    while(self.state_up == 0) {
      waitframe();
    }

    self.plate waittill("damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon);

    if(self.is_civilian == 1) {
      level.playerviewowner thread trial_hitmarker(self, 0, 1, 0);
    } else {
      level.playerviewowner thread trial_hitmarker(self, 1, 0, 0);
    }

    self.activated = 1;

    if(type == "MOD_MELEE") {
      level.playerviewowner notify("fake_weapon_fired");
    }

    if(self.is_civilian) {
      level.var_f350d6beb0d98524--;
    } else {
      level.var_bf2546e3156db5d9--;

      if(level.var_bf2546e3156db5d9 == 0) {
        foreach(door in level.var_f3809fd379f33883) {
          door scriptabledoorfreeze(0);
          door scriptabledooropen("away", level.var_4a2d1176b91b8818.origin);
        }
      }
    }

    if(self.is_civilian && isDefined(level.trial_target_civilian_killed_func)) {
      self[[level.trial_target_civilian_killed_func]]();
    } else if(isDefined(level.trial_target_enemy_killed_func)) {
      self[[level.trial_target_enemy_killed_func]]();
    }

    if(isDefined(level.trial_target_headshot_func) && self.plate tagexists("tag_head") && distance(self.plate gettagorigin("tag_head"), point) <= 5) {
      self[[level.trial_target_headshot_func]]();
    }

    if(isDefined(fxid)) {
      playFX(fxid, point);
    }

    if(isDefined(self.plate_dest)) {
      self.plate_dest hide();
      wait randomfloatrange(0.7, 1);
    }

    thread trial_target_flip("down");
    level waittill("course_ended");

    if(isDefined(self.plate_dest)) {
      while(true) {
        level.playerviewowner waittill("luinotifyserver", msg);

        if(msg == "trial_retry") {
          return;
        }
      }

      self.plate_dest show();
    }
  }
}

function trial_target_flip(var_f1118c1a072b6415) {
  if(var_f1118c1a072b6415 == "up") {
    if(isDefined(self.script_delay)) {
      wait self.script_delay;
    }

    self.plate setCanDamage(1);

    if(isDefined(self.aim_assist)) {
      self.aim_assist enableaimassist();
    }

    if(isDefined(self.collision_up)) {
      self.collision_up solid();
    }

    if(isDefined(self.collision_down)) {
      self.collision_up notsolid();
    }

    if(self.state_up == 1) {
      return;
    }

    self.state_up = 1;
    sign = 1;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.aim_assist)) {
      self.aim_assist disableaimassist();
    }

    if(isDefined(self.collision_up)) {
      self.collision_up notsolid();
    }

    if(isDefined(self.collision_down)) {
      self.collision_up solid();
    }

    if(self.state_up == 0) {
      return;
    }

    self.state_up = 0;
    sign = -1;
  }

  time = undefined;
  ang = undefined;

  switch (self.script_noteworthy) {
    case #"hash_4fa135c280bf8bb8":
    case #"hash_61bfeecb3a35db71":
    case #"hash_90cb0f2603954833":
    case #"hash_9fa4d55df09d03e8":
      ang = 90;
      time = 0.2;
      break;
    case #"hash_2b3b8b1ea205bfb5":
    case #"hash_f3fe62d2a49b4707":
      ang = 30;
      time = 0.15;
      break;
    case #"hash_fce9709bf4fdbff4":
      ang = 180;
      time = 0.4;
      break;
    default:
      ang = 90;
      time = 0.2;
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving")) {
    waitframe();
  }

  if(var_f1118c1a072b6415 == "up") {}

  if(self.initial_right[2] != 0) {
    self rotateYaw(-1 * self.initial_right[2] * ang * sign, time);
  } else {
    self rotatepitch(ang * sign, time);
  }

  wait time;

  if(var_f1118c1a072b6415 == "down") {
    waitframe();
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

function trial_moving_target_think() {
  self notify("trial_moving_target_think");
  self endon("trial_moving_target_think");

  if(!isDefined(self.mover)) {
    self.mover = getclosest(self.origin, level.course_movers, 32);
  }

  if(!isDefined(self.mover)) {
    assertmsg("<dev string:x31>" + self.targetname + "<dev string:x43>" + self.origin + "<dev string:x4b>");
    return;
  }

  if(!isDefined(self.mover_ends)) {
    self.mover_ends = getStructArray(self.mover.targetname, "target");
    self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
    mover_delta = self.mover.origin - self.origin;
    self.mover.origin += mover_delta;
    self.mover_ends[0].origin += mover_delta;
    self.mover_ends[1].origin += mover_delta;
  }

  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed)) {
    self.move_speed = self.script_speed;
  } else {
    self.move_speed = 32;
  }

  level waittill("player_spawned");
  thread trial_moving_target_reset();

  while(true) {
    if(self.moving && (90 > distance(level.playerviewowner.origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.dummy thread stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.playerviewowner.origin, self.origin) && self.state_up == 1) {
      thread trial_moving_target_mover();
    }

    waitframe();
  }
}

function trial_moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  childthread trial_target_follow_dummy();
  self.dummy thread play_loop_sound_on_entity("trial_sfx_target_move_loop");

  while(true) {
    next_end = self.mover_ends[self.moveforward];
    dist = distance(self.dummy.origin, next_end.origin);
    time = dist / self.move_speed;
    accel = 0.5;
    accel = clamp(accel, 0, time / 2);
    self.dummy moveTo(next_end.origin, time, accel, accel);
    wait time;
    self.moveforward = !self.moveforward;
  }
}

function trial_moving_target_reset() {
  while(true) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

function trial_target_follow_dummy() {
  while(true) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

function trial_target_arm_damage() {
  self notify("trial_target_arm_damage");
  self endon("trial_target_arm_damage");
  self.arm setCanDamage(1);

  while(true) {
    self.arm waittill("damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon);

    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && istrue(self.state_up)) {
      self.plate dodamage(1, self.plate.origin);
    }
  }
}

function trial_target_requisites() {
  self notify("trial_target_requisites");
  self endon("trial_target_requisites");
  waitframe();

  if(isDefined(self.targetname)) {
    requisites = getEntArray(self.targetname, "target");
  } else {
    requisites = [];
  }

  while(true) {
    var_ec8a7173e0c630fb = 1;

    foreach(requisite in requisites) {
      if(requisite.activated == 0) {
        var_ec8a7173e0c630fb = 0;
      }
    }

    if(var_ec8a7173e0c630fb == 1) {
      trial_target_flip("up");
      level waittill("course_ended");
    }

    waitframe();
  }
}

function trial_trigger_think() {
  self notify("trial_trigger_think");
  self endon("trial_trigger_think");
  checkpoints = getEntArray("end_checkpoint", "script_noteworthy");

  while(true) {
    self.activated = 0;

    while(!isDefined(level.playerviewowner)) {
      waitframe();
    }

    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy != "start") {
        level waittill("course_started");
      }
    } else {
      level waittill("course_started");
    }

    while(level.playerviewowner istouching(self)) {
      waitframe();
    }

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "end") {
      while(true) {
        self waittill("trigger");

        if(all_end_checkpoints_activated(checkpoints)) {
          break;
        }
      }
    } else {
      self waittill("trigger");
    }

    self.activated = 1;
    level notify("trigger_activated");

    if(isDefined(level.trial_trigger_activated_func)) {
      self[[level.trial_trigger_activated_func]]();
    }

    level waittill("course_ended");
  }
}

function all_end_checkpoints_activated(checkpoints) {
  foreach(checkpoint in checkpoints) {
    if(!checkpoint.activated) {
      return false;
    }
  }

  return true;
}

function trial_hitmarker(var_f182d284b07a828e, isdeath, iscivilian, isbody) {
  if(!isDefined(isdeath)) {
    isdeath = 0;
  }

  if(!isDefined(iscivilian)) {
    iscivilian = 0;
  }

  if(!isDefined(isbody)) {
    isbody = 0;
  }

  alias = getDvar(@ "hash_d6875627fd8914de");
  trial_updatehitmarker("standard", isdeath, 0, iscivilian);
}

function trial_updatehitmarker(markertype, killingblow, headshot, nonplayer, icontype) {
  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(!isDefined(nonplayer)) {
    nonplayer = 0;
  }

  priority = trial_gethitmarkerpriority(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype) && !istrue(killingblow)) {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", markertype);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(killingblow) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(headshot) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(nonplayer) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function trial_gethitmarkerpriority(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}

function resettargets() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_f427df4858af05fe", 0) != 0) {
      setdevdvar(@ "hash_f427df4858af05fe", 0);

      foreach(targ in level.course_triggers) {
        targ thread trial_trigger_think();
      }

      foreach(targ in level.course_targets) {
        targ trial_target_flip("down");
        targ thread trial_target_think();
      }

      level thread function_9f7978a6a0c46c0b();
    }

    if(getdvarint(@ "door_test", 0) != 0) {
      setdevdvar(@ "door_test", 0);

      foreach(door in level.var_2aaab671aef7cdc6) {
        door scriptabledooropen("away", level.var_a7ba750765d34ca9.origin);
      }
    }
  }
}

function function_b73c05f4babd6b8e() {
  level.var_a7ba750765d34ca9 = undefined;
  level.var_4a2d1176b91b8818 = undefined;
  level.var_2aaab671aef7cdc6 = [];
  level.var_f3809fd379f33883 = [];

  foreach(trigger in level.course_triggers) {
    if(isDefined(trigger.script_noteworthy)) {
      if(trigger.script_noteworthy == "start") {
        level.var_a7ba750765d34ca9 = trigger;
        level.var_2aaab671aef7cdc6 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
        continue;
      }

      if(trigger.script_noteworthy == "end") {
        level.var_4a2d1176b91b8818 = trigger;
        level.var_f3809fd379f33883 = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
      }
    }
  }
}

function function_9f7978a6a0c46c0b() {
  while(!isDefined(level.var_a7ba750765d34ca9) || !isDefined(level.var_4a2d1176b91b8818)) {
    waitframe();
  }

  level.var_a7ba750765d34ca9 notify("monitorStartTrigger");
  level.var_a7ba750765d34ca9 endon("monitorStartTrigger");

  foreach(door in level.var_2aaab671aef7cdc6) {
    door scriptabledoorclose();
  }

  foreach(door in level.var_f3809fd379f33883) {
    door scriptabledoorclose();
    door scriptabledoorfreeze(1);
  }

  level.var_a7ba750765d34ca9 waittill("trigger");

  foreach(door in level.var_2aaab671aef7cdc6) {
    door scriptabledooropen("away", level.var_a7ba750765d34ca9.origin);
  }

  level.var_915231e52d22d349 = 1;
  level notify("course_started");
  starttime = gettime();
  level.var_4a2d1176b91b8818 waittill("trigger");
  elapsedtime = (gettime() - starttime) / 1000;
  level.playerviewowner iprintlnbold("MOUT Course Time: " + elapsedtime);
  level thread function_9f7978a6a0c46c0b();
}