/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend\mp_frontend.gsc
*******************************************************/

#using script_cbb0697de4c5728;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\stackablehitmarker;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\frontendutils;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\weapons_dev;
#using scripts\engine\utility;
#using scripts\mp\maps\mp_frontend\gen\mp_frontend_art;
#using scripts\mp\maps\mp_frontend\mp_frontend_fx;
#using scripts\mp\maps\mp_frontend\mp_frontend_lighting;
#using scripts\mp\maps\mp_frontend\mp_frontend_precache;
#namespace mp_frontend;

function onplayerconnectrunonce() {
  level endon("game_ended");
  self endon("disconnect");
  level.playerviewowner = self;
  level.var_6437f87ec88fec96 = 1;
  level.var_2012113081d2a67f = "iw9_";
  level.var_3ff084b89b959f13 = "";
  level.var_ccc8d1ad327315cd = 0;

  if(isDefined(level.playerconnectedevents)) {
    return;
  }

  level.playerconnectedevents = 1;
  level.var_3d353e3274a23c81 = 0;
  thread play_fx();
  thread function_38e401b130e8f256();
  thread function_3079b57592326a74();
  frontendutils::function_206e476c61647ec1();
  self enablephysicaldepthoffieldscripting();
  wait 0.5;
}

function callback_frontendplayerconnect() {
  thread onplayerconnectrunonce();
}

function callback_frontendplayerdisconnect(reason) {
  setDvar(@ "bg_cinematicfullscreen", "1");
}

function function_2d3cbaf377c401a3() {
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

function function_38e401b130e8f256() {
  function_2d3cbaf377c401a3();
  level.foamlarge = frontendutils::function_28d43ffc378eedeb("foam_large");
  level.foammedium = frontendutils::function_28d43ffc378eedeb("foam_med");
  level.foamsmall = frontendutils::function_28d43ffc378eedeb("foam_small");
  level.foamlarge show();
  level.foammedium hide();
  level.foamsmall hide();
  setDvar(@ "hash_adb9d289548d38d9", "-1 -1");

  while(true) {
    self waittill("luinotifyserver", msg, arg);
    setDvar(@ "r_tessellationoverride", 0);

    if(msg == "swap_gun_foam") {
      if(arg == 3) {
        setDvar(@ "hash_adb9d289548d38d9", "-1 -1");
        level.foamlarge show();
        level.foammedium hide();
        level.foamsmall hide();
        continue;
      }

      if(arg == 2) {
        setDvar(@ "hash_adb9d289548d38d9", "1 1");
        level.foamlarge hide();
        level.foammedium show();
        level.foamsmall hide();
        continue;
      }

      if(arg == 1) {
        setDvar(@ "hash_adb9d289548d38d9", "1 1");
        level.foamlarge hide();
        level.foammedium hide();
        level.foamsmall show();
      }
    }
  }
}

function function_a62597239452f920() {
  var_37b84c7ba4bfb6fa = getEnt("shop_character_bg", #targetname);

  if(isDefined(var_37b84c7ba4bfb6fa)) {
    level.var_6d9f8ea019296372 = spawn("script_model", var_37b84c7ba4bfb6fa.origin);
    level.var_6d9f8ea019296372.angles = var_37b84c7ba4bfb6fa.angles;
    level.var_cfec6213d70ba3ae = var_37b84c7ba4bfb6fa.origin;
  } else {
    level.var_6d9f8ea019296372 = spawn("script_model", (0, 0, 0));
    level.var_6d9f8ea019296372.angles = (0, 0, 0);
    level.var_cfec6213d70ba3ae = (0, 0, 0);
  }

  var_b1412723db9387af = getEnt("shop_bundle_bg", #targetname);

  if(isDefined(var_b1412723db9387af)) {
    level.var_7ee813dc4c2b115f = spawn("script_model", var_b1412723db9387af.origin);
    level.var_7ee813dc4c2b115f.angles = var_b1412723db9387af.angles;
    level.var_8015fd9f3d7dea27 = var_b1412723db9387af.origin;
    return;
  }

  level.var_7ee813dc4c2b115f = spawn("script_model", (0, 0, 0));
  level.var_7ee813dc4c2b115f.angles = (0, 0, 0);
  level.var_8015fd9f3d7dea27 = (0, 0, 0);
}

function main() {
  println("<dev string:x24>");
  mp_frontend_precache::main();
  mp_frontend_art::main();
  mp_frontend_fx::main();
  mp_frontend_lighting::main();
  stackablehitmarker::init();

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.projectbundle = getprojectscriptbundle();
  level.gamemodebundle = getgamemodescriptbundle();
  level.var_3d353e3274a23c81 = 0;
  frontendutils::init_frontend_utils();
  level.transition_interrupted = 0;
  level.showseasonalcontent = getdvarint(@ "hash_ca079d844e54e73a");
  level.ttlos_suppressasserts = 1;

  if(getbuildversion() != "SHIP") {
    weapons_dev::function_4104f01b5a640281();
  }

  level.callbackplayerconnect = &callback_frontendplayerconnect;
  level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
  level thread initfiringrange();
  level thread function_a62597239452f920();
  setDvar(@ "r_mbradialoverridefocusdir", 1);
  setDvar(@ "bg_cinematicfullscreen", "0");
  level thread function_547a46c3ec1b7fca();
  level mtx_weapon::function_f877fea1e7d31f31();

  level thread animation::function_2cff1618834b2ab7();
  level thread watch_scene();
}

function function_547a46c3ec1b7fca() {
  wait 1;
  setglobalsoundcontext("zm_intel", "frontend");
}

function watch_scene() {
  while(true) {
    shouldplay = getdvarint(@ "hash_ca167f2be850ac25", 0);

    if(shouldplay == 1) {
      setDvar(@ "hash_ca167f2be850ac25", 0);
      scenename = getDvar(@ "hash_4d1bdabe05cf586d", "<dev string:x39>");

      if(isDefined(scenename)) {
        scene::play(undefined, undefined, scenename);
      }
    }

    waitframe();
  }
}

function function_3079b57592326a74() {
  level.lanetriggers = frontendutils::function_55f1609e123f6a51("shooting_range_lane_triggers");
  level.roomtrigger = frontendutils::function_28d43ffc378eedeb("shooting_range_room_trigger");
  level.firingrangetargets = frontendutils::function_55f1609e123f6a51("enemyTarget");
  level.var_480357a8ac4a1212 = frontendutils::function_55f1609e123f6a51("firingrange_target_1");
  level.var_480356a8ac4a0fdf = frontendutils::function_55f1609e123f6a51("firingrange_target_2");
  level.var_480355a8ac4a0dac = frontendutils::function_55f1609e123f6a51("firingrange_target_3");
  level.var_88efb3520383bb2 = arraycombine(level.var_480357a8ac4a1212, level.var_480356a8ac4a0fdf, level.var_480355a8ac4a0dac);
  level.var_8d05a2b01cb7422 = 0;

  foreach(frtarget in level.firingrangetargets) {
    targetpositions = utility::getStructArray(frtarget.target, "targetname");

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

    damagetriggers = getEntArray(frtarget.target, #targetname);

    foreach(trigg in damagetriggers) {
      trigg enablelinkTo();

      if(!isPlayer(trigg)) {
        trigg linkTo(frtarget);
      }
    }
  }

  foreach(light in level.var_88efb3520383bb2) {
    light.var_a04f31996e6b5246 = light getlightintensity();
  }

  thread function_ec2bac4d6225817c("lane1");

  foreach(trig in level.lanetriggers) {
    trig.var_33f76c2d569e4abf = 0;
    trig thread function_ca87a1115b909f2c();
  }

  setomnvar("ui_firing_range_lane", -1);
  setomnvar("ui_firing_range_target_kill_count", 0);
}

function function_ca87a1115b909f2c() {
  while(true) {
    if(!self.var_33f76c2d569e4abf) {
      self waittill("trigger");
      thread function_820594477a5e5d93(self.script_noteworthy);
      thread function_ec2bac4d6225817c(self.script_noteworthy);
      level notify("firing_range_weapon_stats_reset");

      foreach(trig in level.lanetriggers) {
        trig.var_33f76c2d569e4abf = 0;
      }

      self.var_33f76c2d569e4abf = 1;
      setomnvar("ui_firing_range_target_kill_count", 0);
      setomnvar("ui_firing_range_accuracy", 0);
      level.var_6d20f1bfea78492e = 0;
      level.var_65d3ec21afb8c1b1 = 0;
      level.bulletshitsecondary = 0;
      level.var_ec67017c22f64929 = 0;
      level.var_38e10219d88bb19c = 0;
      level.var_edd9d75d4e242354 = 0;
      level.primarydamagedealt = 0;
      level.secondarydamagedealt = 0;
      continue;
    }

    wait 1;
  }
}

function function_ec2bac4d6225817c(lane) {
  foreach(light in level.var_88efb3520383bb2) {
    light setlightintensity(0);
  }

  level.var_8d05a2b01cb7422++;
  wait 1.5;

  if(level.var_8d05a2b01cb7422 < 2) {
    switch (lane) {
      case #"hash_683099596bfc9c1a":
        foreach(light in level.var_480357a8ac4a1212) {
          light setlightintensity(light.var_a04f31996e6b5246);
        }

        break;
      case #"hash_683098596bfc9a87":
        foreach(light in level.var_480356a8ac4a0fdf) {
          light setlightintensity(light.var_a04f31996e6b5246);
        }

        break;
      case #"hash_683097596bfc98f4":
        foreach(light in level.var_480355a8ac4a0dac) {
          light setlightintensity(light.var_a04f31996e6b5246);
        }

        break;
      default:
        break;
    }
  }

  level.var_8d05a2b01cb7422--;
}

function function_820594477a5e5d93(newposition) {
  foreach(frtarget in level.firingrangetargets) {
    switch (newposition) {
      case #"hash_683099596bfc9c1a":
        setomnvar("ui_firing_range_lane", 1);

        if(frtarget.var_f9a396aeb09d7be2) {
          frtarget thread function_aaea15f4823e8b6d(frtarget.position1);
        } else {
          frtarget thread watchdeathonmove(frtarget.position1);
        }

        break;
      case #"hash_683098596bfc9a87":
        setomnvar("ui_firing_range_lane", 2);

        if(frtarget.var_f9a396aeb09d7be2) {
          frtarget thread function_aaea15f4823e8b6d(frtarget.position2);
        } else {
          frtarget thread watchdeathonmove(frtarget.position2);
        }

        break;
      case #"hash_683097596bfc98f4":
        setomnvar("ui_firing_range_lane", 3);

        if(frtarget.var_f9a396aeb09d7be2) {
          frtarget thread function_aaea15f4823e8b6d(frtarget.position3);
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
  thread audio_move_dummy();
  currenttime = gettime();
  endtime = currenttime + 1500;

  while(currenttime < endtime) {
    currenttime = gettime();

    if(self.var_f9a396aeb09d7be2) {
      thread function_aaea15f4823e8b6d(position);
      break;
    }

    wait 0.1;
  }
}

function function_aaea15f4823e8b6d(position) {
  self notify("move_dummy");
  self endon("delete");
  self endon("move_dummy");

  while(self.var_f9a396aeb09d7be2) {
    waitframe();
  }

  self moveTo(position, 1.5, 0.25, 0.5);
  thread audio_move_dummy();
}

function audio_move_dummy() {}

function play_fx() {
  waitframe();
  level.frontendfx = [];
  wait 0.5;
}

function endlesslobbyfloor() {
  wait 0.1;
  floor1 = getEnt("mp_lobby_floor_01", #targetname);
  var_c7a6006099c69be4 = getEntArray("floor_01_clutter", #targetname);
  floor2 = getEnt("mp_lobby_floor_02", #targetname);
  floor2clutter = getEntArray("floor_02_clutter", #targetname);

  foreach(clutter in var_c7a6006099c69be4) {
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

function initfiringrange() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  damagefeedback::damagefeedback_init();
  level.course_triggers = getEntArray("progression", #targetname);
  function_4e9a7827b711fa9();
  level.course_targets = gettargetarray();
  level.civilian_targets = [];
  level.enemy_targets = [];

  foreach(targ in level.course_triggers) {
    targ thread trial_trigger_think();
  }

  foreach(targ in level.course_targets) {
    targ thread function_2453e65d6120ef71();
  }

  level.var_77114a6fc636145f = level.civilian_targets.size;
  level.var_10b39d46e55794fc = level.enemy_targets.size;
}

function function_2453e65d6120ef71() {
  self.initial_forward = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.initial_right = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking)) {
    level.targets_thinking = 0;
  }

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, #script_linkto);
  self.parts = arrayremove(self.parts, self);

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
    target_arrays_structs[i] = utility::getStructArray(target_types[i], "script_noteworthy");

    foreach(struct in target_arrays_structs[i]) {
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
    target_arrays[i] = getEntArray(target_types[i], #script_noteworthy);
  }

  return utility::array_combine_multiple(target_arrays);
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
      level.var_77114a6fc636145f--;
    } else {
      level.var_10b39d46e55794fc--;

      if(level.var_10b39d46e55794fc == 0) {
        foreach(door in level.var_f73078b8ad14f6b4) {
          door scriptabledoorfreeze(0);
          door scriptabledooropen("away", level.var_fe88e599446821bf.origin);
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

function trial_target_flip(up_or_down) {
  if(up_or_down == "up") {
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

  if(up_or_down == "up") {}

  if(self.initial_right[2] != 0) {
    self rotateYaw(-1 * self.initial_right[2] * ang * sign, time);
  } else {
    self rotatepitch(ang * sign, time);
  }

  wait time;

  if(up_or_down == "down") {
    waitframe();
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

function trial_moving_target_think() {
  self notify("trial_moving_target_think");
  self endon("trial_moving_target_think");

  if(!isDefined(self.mover)) {
    self.mover = function_47c86977a18df38b(level.course_movers, self.origin, 32);
  }

  if(!isDefined(self.mover)) {
    assertmsg("<dev string:x54>" + self.targetname + "<dev string:x66>" + self.origin + "<dev string:x6e>");
    return;
  }

  if(!isDefined(self.mover_ends)) {
    self.mover_ends = utility::getStructArray(self.mover.targetname, "target");
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
      self.dummy thread utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
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
  self.dummy thread utility::play_loop_sound_on_entity("trial_sfx_target_move_loop");

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

    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && self.state_up) {
      self.plate dodamage(1, self.plate.origin);
    }
  }
}

function trial_target_requisites() {
  self notify("trial_target_requisites");
  self endon("trial_target_requisites");
  waitframe();

  if(isDefined(self.targetname)) {
    requisites = getEntArray(self.targetname, #target);
  } else {
    requisites = [];
  }

  while(true) {
    all_requisites = 1;

    foreach(var_1de3f66c4a6ef6f in requisites) {
      if(var_1de3f66c4a6ef6f.activated == 0) {
        all_requisites = 0;
      }
    }

    if(all_requisites == 1) {
      trial_target_flip("up");
      level waittill("course_ended");
    }

    waitframe();
  }
}

function trial_trigger_think() {
  self notify("trial_trigger_think");
  self endon("trial_trigger_think");
  checkpoints = getEntArray("end_checkpoint", #script_noteworthy);

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

    if(self.script_noteworthy == "end") {
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

function trial_hitmarker(var_d09ca95a87894237, isdeath, iscivilian, isbody) {
  if(!isDefined(isdeath)) {
    isdeath = 0;
  }

  if(!isDefined(iscivilian)) {
    iscivilian = 0;
  }

  if(!isDefined(isbody)) {
    isbody = 0;
  }

  alias = getDvar(@ "snd_hitmarker_alias");
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

  if(self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype) && !killingblow) {
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

      level thread function_932a7ff49d584d2c();
    }

    if(getdvarint(@ "door_test", 0) != 0) {
      setdevdvar(@ "door_test", 0);

      foreach(door in level.var_965747965992ff2d) {
        door scriptabledooropen("away", level.var_b4491010f040dc0a.origin);
      }
    }
  }
}

function function_4e9a7827b711fa9() {
  level.var_b4491010f040dc0a = undefined;
  level.var_fe88e599446821bf = undefined;
  level.var_965747965992ff2d = [];
  level.var_f73078b8ad14f6b4 = [];

  foreach(trigger in level.course_triggers) {
    if(isDefined(trigger.script_noteworthy)) {
      if(trigger.script_noteworthy == "start") {
        level.var_b4491010f040dc0a = trigger;
        level.var_965747965992ff2d = scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
        continue;
      }

      if(trigger.script_noteworthy == "end") {
        level.var_fe88e599446821bf = trigger;
        level.var_f73078b8ad14f6b4 = scriptable_door_utility::scriptable_door_get_in_radius(trigger.origin, 512, 1000);
      }
    }
  }
}

function function_932a7ff49d584d2c() {
  while(!(isDefined(level.var_b4491010f040dc0a) && isDefined(level.var_fe88e599446821bf))) {
    waitframe();
  }

  level.var_b4491010f040dc0a notify("monitorStartTrigger");
  level.var_b4491010f040dc0a endon("monitorStartTrigger");

  foreach(door in level.var_965747965992ff2d) {
    door scriptabledoorclose();
  }

  foreach(door in level.var_f73078b8ad14f6b4) {
    door scriptabledoorclose();
    door scriptabledoorfreeze(1);
  }

  level.var_b4491010f040dc0a waittill("trigger");

  foreach(door in level.var_965747965992ff2d) {
    door scriptabledooropen("away", level.var_b4491010f040dc0a.origin);
  }

  level.var_2e4782d99dcefb0e = 1;
  level notify("course_started");
  starttime = gettime();
  level.var_fe88e599446821bf waittill("trigger");
  elapsedtime = (gettime() - starttime) / 1000;
  level.playerviewowner iprintlnbold("MOUT Course Time: " + elapsedtime);
  level thread function_932a7ff49d584d2c();
}