/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_utility.gsc
***********************************************/

setup_named_ai(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\sp\utility::spawn_targetname(var_0, 1);

  if(!isDefined(var_1))
    var_1 = var_0;

  var_7.name = var_1;
  var_7.animname = var_0;
  var_7.script_friendname = var_1;
  var_7.script_parameters = var_0;
  var_7.disableplayeradsloscheck = 1;
  var_7.script_pushable = 1;
  var_7.disablebulletwhizbyreaction = 1;
  var_7.dontavoidplayer = 0;
  var_7.ignoreplayersuppressionlines = 1;
  var_7.dontchangepushplayer = 1;
  var_7 pushplayer(0);

  if(isDefined(var_6))
    var_7.callsign = var_6;

  if(var_0 == "griggs") {
    if(!isDefined(level.allymarines))
      init_marine_arrays();

    if(var_0 == "griggs")
      level.allymarines["o"] = scripts\engine\utility::array_add(level.allymarines["o"], var_7);

    level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], var_7);
  }

  var_7.colornode_func = ::color_node_arrive;

  if(!isDefined(var_5))
    var_5 = 1;

  if(var_5 == 1)
    var_7 thread scripts\engine\sp\utility::deletable_magic_bullet_shield();

  if(isDefined(var_3))
    scripts\engine\sp\utility::activate_trigger_with_targetname(var_3);

  if(isDefined(var_4) && isDefined(var_7.asmname)) {
    if(var_4 == "clear")
      var_7 scripts\common\utility::clear_demeanor_override();
    else
      var_7 scripts\common\utility::demeanor_override(var_4);
  }

  if(isDefined(var_2)) {
    var_8 = scripts\engine\utility::getStruct(var_2, "targetname");

    if(isDefined(var_8)) {
      var_7 forceteleport(var_8.origin, var_8.angles);
      var_7 setgoalpos(var_7.origin);
    }
  }

  return var_7;
}

setup_named_ai_after_spawn(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = var_0;

  self.name = var_1;
  self.animname = var_0;
  self.script_friendname = var_1;
  self.script_parameters = var_0;
  self.disableplayeradsloscheck = 1;
  self.script_pushable = 1;
  self.disablebulletwhizbyreaction = 1;
  self.dontavoidplayer = 1;
  self pushplayer(0);

  if(var_0 == "griggs" || var_0 == "farah") {
    if(!isDefined(level.allymarines))
      init_marine_arrays();

    if(var_0 == "griggs")
      level.allymarines["o"] = scripts\engine\utility::array_add(level.allymarines["o"], self);

    level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], self);
  }

  self.colornode_func = ::color_node_arrive;

  if(!isDefined(var_5))
    var_5 = 1;

  if(var_5 == 1 && !isDefined(self.magic_bullet_shield))
    thread scripts\engine\sp\utility::deletable_magic_bullet_shield();

  if(isDefined(var_3))
    scripts\engine\sp\utility::activate_trigger_with_targetname(var_3);

  if(isDefined(var_4) && isDefined(self.asmname)) {
    if(var_4 == "clear")
      scripts\common\utility::clear_demeanor_override();
    else
      scripts\common\utility::demeanor_override(var_4);
  }

  if(isDefined(var_2)) {
    var_6 = scripts\engine\utility::getStruct(var_2, "targetname");

    if(isDefined(var_6))
      self forceteleport(var_6.origin, var_6.angles);
  }
}

init_marine_arrays() {
  level.allymarines = [];
  level.allymarines["all"] = [];
  level.allymarines["o"] = [];
  level.allymarines["y"] = [];
  level.allymarines["r"] = [];
  level.allymarines["b"] = [];
  level.allymarines["c"] = [];
  level.allymarines["g"] = [];
  level.allymarines["p"] = [];
  level.colorspawners = [];
  level.colorspawners["o"] = [];
  level.colorspawners["y"] = [];
  level.colorspawners["r"] = [];
  level.colorspawners["b"] = [];
  level.colorspawners["c"] = [];
  level.colorspawners["g"] = [];
  level.colorspawners["p"] = [];
}

cleanup_marine_spawner_arrays() {
  level.colorspawners = [];
  level.colorspawners["o"] = [];
  level.colorspawners["y"] = [];
  level.colorspawners["r"] = [];
  level.colorspawners["b"] = [];
  level.colorspawners["c"] = [];
  level.colorspawners["g"] = [];
  level.colorspawners["p"] = [];
}

switch_marines_from_color_to_color(var_0, var_1) {
  var_2 = get_array_of_living_allies_by_color(var_0);

  if(var_2.size > 0) {
    foreach(var_4 in var_2) {
      if(isalive(var_4))
        var_4 switch_marine_color(var_0, var_1);
    }
  }
}

switch_marine_color(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self.script_color;

  var_2 = self.myfloodspawner;
  scripts\engine\sp\utility::set_force_color(var_1);
  level.allymarines[var_0] = scripts\engine\utility::array_remove(level.allymarines[var_0], self);
  level.allymarines[var_1] = scripts\engine\utility::array_add(level.allymarines[var_1], self);

  if(isDefined(var_2)) {
    var_2 scripts\engine\sp\utility::set_force_color(var_1);
    level.colorspawners[var_0] = scripts\engine\utility::array_remove(level.colorspawners[var_0], var_2);
    level.colorspawners[var_1] = scripts\engine\utility::array_add(level.colorspawners[var_1], var_2);
  }
}

color_node_arrive(var_0) {
  self endon("death");
  waitframe();
  self.oldgoalradius = self.goalradius;
  self.goalradius = 1;
  self waittill("goal");

  if(isDefined(var_0.script_gesture))
    thread scripts\asm\gesture::ai_request_gesture(var_0.script_gesture, level.player, 10000);

  if(isDefined(var_0.script_flag))
    scripts\engine\utility::flag_set(var_0.script_flag);

  if(isDefined(var_0.script_sound))
    thread scripts\engine\sp\utility::smart_dialogue(var_0.script_sound);

  if(var_0.type == "Exposed" && isDefined(var_0.script_parameters) && var_0.script_parameters == "auto_poi") {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);
    thread color_node_left_cleanup();
  }

  self.goalradius = self.oldgoalradius;
}

color_node_left_cleanup() {
  self endon("death");
  self waittill("stop_going_to_node");
  scripts\asm\shared\utility::toggle_poiauto(0);
}

display_ai_count(var_0) {
  level.player endon("death");
  level endon("nextmission");
  var_1 = (1, 1, 1);
  var_2 = (1, 1, 0);
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_5 = [];

  for(;;) {
    if(isDefined(var_0)) {
      if(var_0 != "all")
        var_5[0] = getaiarray(var_0).size;
      else {
        var_5[0] = getaiarray("axis").size;
        var_5[1] = getaiarray("allies").size;
        var_5[2] = getaiarray("neutral").size;
      }
    } else
      var_5[0] = getaiarray().size;

    var_6 = 0;

    foreach(var_8 in var_5)
    var_6 = var_6 + var_8;

    var_10 = var_1;

    if(var_6 < 10)
      var_10 = var_3;
    else if(var_6 < 20)
      var_10 = var_2;
    else
      var_10 = var_4;

    var_11 = 700;
    var_12 = 30;

    foreach(var_15, var_8 in var_5) {
      var_14 = " AI";

      if(isDefined(var_0)) {
        if(var_0 == "all") {
          switch (var_15) {
            case 0:
              var_14 = " enemies";
              break;
            case 1:
              var_14 = " allies";
              break;
            case 2:
              var_14 = " civilians";
              break;
          }
        } else
          var_14 = " " + var_0;
      }

      var_12 = var_12 + 20;
    }

    waitframe();
  }
}

setup_marine_allies(var_0, var_1, var_2, var_3) {
  level notify("new_setup_marine_allies");

  if(!isDefined(level.allymarines))
    init_marine_arrays();

  cleanup_marine_spawner_arrays();
  level notify("new_marine_spawners");
  level.maxallymarines = 16;

  if(isDefined(var_2))
    level.maxallymarines = var_2;

  if(isDefined(var_1)) {
    var_4 = getEnt(var_1, "targetname");

    if(isDefined(var_4))
      scripts\engine\sp\utility::activate_trigger_with_targetname(var_1);
  }

  var_5 = getspawnerarray(var_0);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.script_forcecolor)) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
      continue;
    }

    var_8 = var_7.script_forcecolor;

    switch (var_8) {
      case "o":
        level.colorspawners["o"] = add_spawner_to_color_spawner_array(level.colorspawners["o"], var_7);
        break;
      case "y":
        level.colorspawners["y"] = add_spawner_to_color_spawner_array(level.colorspawners["y"], var_7);
        break;
      case "r":
        level.colorspawners["r"] = add_spawner_to_color_spawner_array(level.colorspawners["r"], var_7);
        break;
      case "b":
        level.colorspawners["b"] = add_spawner_to_color_spawner_array(level.colorspawners["b"], var_7);
        break;
      case "c":
        level.colorspawners["c"] = add_spawner_to_color_spawner_array(level.colorspawners["c"], var_7);
        break;
      case "g":
        level.colorspawners["g"] = add_spawner_to_color_spawner_array(level.colorspawners["g"], var_7);
        break;
      case "p":
        level.colorspawners["p"] = add_spawner_to_color_spawner_array(level.colorspawners["p"], var_7);
        break;
      default:
        break;
    }
  }

  foreach(var_14, var_11 in level.colorspawners) {
    foreach(var_7 in var_11) {
      if(!isDefined(var_7) || !isspawner(var_7))
        var_11 = scripts\engine\utility::array_remove(var_11, var_7);
    }

    if(var_11.size == 0) {
      continue;
    }
    scripts\engine\sp\utility::array_spawn_function(var_11, ::add_marine_to_color_array);
    thread flood_spawn_allies(var_14);
  }
}

marine_callsign_generate_list_init() {
  level.callsign_squad = [];
  level.callsign_prefix = [];
  level.callsign_suffix = [];
  level.callsign_excluders = [];
  level.callsign_squad = scripts\engine\utility::array_add(level.callsign_squad, "Demon");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "1");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "2");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "4");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "5");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "6");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "7");
  level.callsign_prefix = scripts\engine\utility::array_add(level.callsign_prefix, "8");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "1");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "2");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "3");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "4");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "5");
  level.callsign_suffix = scripts\engine\utility::array_add(level.callsign_suffix, "6");
  level.callsign_excluders = scripts\engine\utility::array_add(level.callsign_excluders, "Demon 1-2");
  level.callsign_excluders = scripts\engine\utility::array_add(level.callsign_excluders, "Echo 3-1");
}

marine_callsign_picker(var_0) {
  thread marine_clear_callsign_on_death();

  for(;;) {
    var_1 = 0;

    if(isDefined(var_0))
      var_2 = var_0 + " " + scripts\engine\utility::random(level.callsign_prefix) + "-" + scripts\engine\utility::random(level.callsign_suffix);
    else
      var_2 = level.callsign_squad[0] + " " + scripts\engine\utility::random(level.callsign_prefix) + "-" + scripts\engine\utility::random(level.callsign_suffix);

    foreach(var_4 in level.callsign_excluders) {
      if(var_2 == var_4)
        var_1 = 1;
    }

    var_6 = getaiarray("allies");

    if(var_6.size > 0) {
      foreach(var_8 in var_6) {
        if(isDefined(var_8) && isalive(var_8) && isDefined(var_8.callsign)) {
          if(var_2 == var_8.callsign)
            var_1 = 1;
        }
      }
    }

    if(var_1 == 0 && isDefined(self) && isalive(self)) {
      self.callsign = var_2;
      break;
    } else
      waitframe();
  }
}

marine_clear_callsign_on_death() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");

  if(isDefined(self) && isDefined(self.callsign))
    self.callsign = undefined;
}

add_marine_to_color_array() {
  self endon("death");
  self endon("entitydeleted");
  thread marine_callsign_picker();
  var_0 = self.script_forcecolor;
  self.colornode_func = ::color_node_arrive;
  level.allymarines[var_0] = scripts\engine\utility::array_removedead_or_dying(level.allymarines[var_0]);
  level.allymarines["all"] = scripts\engine\utility::array_removedead_or_dying(level.allymarines["all"]);
  level.allymarines[var_0] = scripts\engine\utility::array_add(level.allymarines[var_0], self);
  level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], self);
}

add_spawner_to_color_spawner_array(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
      continue;
    }

    if(var_3.targetname == var_1.targetname)
      continue;
    else {
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
      var_3 delete();
    }
  }

  var_0 = scripts\engine\utility::array_add(var_0, var_1);
  return var_0;
}

flood_spawn_allies(var_0) {
  level endon("new_marine_spawners");
  var_1 = undefined;
  var_2 = level.colorspawners[var_0].size;

  while(level.colorspawners[var_0].size > 0) {
    var_3 = get_array_of_living_allies_by_color(var_0);
    var_4 = var_3.size;

    if(var_3.size >= var_2) {
      waitframe();
      continue;
    }

    if(level.allymarines["all"].size >= level.maxallymarines) {
      waitframe();
      continue;
    }

    var_5 = level.colorspawners[var_0][level.colorspawners[var_0].size - 1];

    if(isDefined(var_5)) {
      if(isDefined(var_5.script_radius)) {
        var_6 = getaiarray("axis");
        var_7 = 9999999;

        foreach(var_9 in var_6) {
          if(distancesquared(var_5.origin, var_9.origin) < var_7)
            var_7 = distancesquared(var_5.origin, var_9.origin);
        }

        if(var_7 < squared(var_5.script_radius)) {
          waitframe();
          continue;
        }
      }

      var_5 thread marine_flood_spawner_think();
      level.colorspawners[var_0] = scripts\engine\utility::array_remove(level.colorspawners[var_0], var_5);
      var_1 = var_5.targetname;
    } else
      return;

    var_11 = scripts\engine\utility::waittill_any_ents_or_timeout_return(5, var_5, "marine_finished_spawning");

    if(var_11 == "timeout") {
      var_5 notify("death");
      level.colorspawners[var_0] = scripts\engine\utility::array_insert(level.colorspawners[var_0], var_5, 0);
    } else {}

    var_3 = get_array_of_living_allies_by_color(var_0);
  }
}

marine_flood_spawner_think() {
  level endon("new_marine_spawners");

  if(isspawner(self))
    self endon("death");

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  while(self.count > 0) {
    var_0 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var_0)) {
      wait 2;
      continue;
    }

    self notify("marine_finished_spawning");
    var_0.myfloodspawner = self;
    var_0 thread scripts\sp\spawner::reincrement_count_if_deleted(self);
    var_0 waittill("death", var_1);

    if(!scripts\sp\spawner::player_saw_kill(var_0, var_1))
      self.count++;

    if(!isDefined(var_0)) {
      continue;
    }
    if(!scripts\engine\utility::script_wait())
      wait(randomfloatrange(5, 9));
  }
}

get_array_of_living_allies_by_color(var_0) {
  level.allymarines[var_0] = scripts\engine\utility::array_removedead_or_dying(level.allymarines[var_0]);
  level.allymarines["all"] = scripts\engine\utility::array_removedead_or_dying(level.allymarines["all"]);
  return level.allymarines[var_0];
}

setup_named_vehicle(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_6 = scripts\common\utility::getvehiclespawner(var_0, "targetname");
  var_7 = scripts\common\vehicle::vehicle_spawn(var_6);

  if(isDefined(var_5) && var_5 == 1)
    var_7 setModel("veh8_mil_lnd_stango_slats");

  if(isDefined(var_1))
    var_7 setvehiclelookattext(var_1, &"");

  if(var_4 == 1)
    var_7 thread vehicle_nav_repulsor();

  var_8 = getvehiclenode(var_2, "targetname");

  if(var_3 == 1)
    var_7 scripts\common\vehicle::attach_vehicle_and_gopath(var_8);
  else
    var_7 scripts\common\vehicle::attach_vehicle(var_8);

  if(var_7.classname == "script_vehicle_iw8_apc_stango") {
    scripts\common\vehicle_build::build_treadfx(var_7.classname, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
    var_7 vehicle_turret_init();
  }

  return var_7;
}

vehicle_nav_repulsor(var_0) {
  self.repulsor = createnavrepulsor("vehicle " + self getentitynumber(), -1, self, 180, 1, "allies", "neutral", "axis");
  self waittill("death");

  if(!isDefined(var_0)) {
    if(isDefined(self.repulsor))
      destroynavrepulsor(self.repulsor);
  }
}

vehicle_turret_init() {
  self.minigun = spawnturret("misc_turret", self.origin, "iw8_mg_50cal");
  self.minigun.angles = self.angles;
  self.minigun setModel("veh8_mil_lnd_stango_turret");
  self.minigun linkTo(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  self.minigun makeunusable();
  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(90);
  self.minigun setrightarc(90);
  self.minigun settoparc(90);
  self.minigun setbottomarc(90);
  self.minigun setconvergencetime(1, "yaw");
  self.minigun setconvergencetime(1, "pitch");
  self.minigun.target_ent = scripts\engine\utility::spawn_tag_origin();
  thread vehicle_turret_cleanup();
}

vehicle_turret_cleanup() {
  self waittill("death");

  if(isDefined(self.minigun))
    self.minigun delete();
}

delete_barricaded_door_boards(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "temp_board")
      var_3 delete();
  }
}

friendly_fire_dialogue_monitor() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_1 = level.friendlyfire["civilians_killed"];

    if(var_1 > var_0) {
      if(istrue(level.skip_next_friendly_fire_nag))
        level.skip_next_friendly_fire_nag = 0;
      else
        thread scripts\sp\maps\marines\marines_vo.gsc::vo_friendly_fire_dialogue();
    }

    var_0 = var_1;
    waitframe();
  }
}

check_los_and_proximity(var_0) {
  var_1 = sighttracepassed(self getEye(), var_0 getEye(), 0, var_0);
  var_2 = distance(self.origin, var_0.origin) <= 400;
  return var_1 && var_2;
}

marine_airstrike_group(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 1.0;

  if(!isDefined(var_3))
    var_3 = 3;

  var_5 = scripts\engine\utility::getStructArray(var_0, "targetname");
  scripts\engine\utility::array_thread_amortized(var_5, ::marine_airstrike_single, randomfloatrange(0.1, 0.2), var_1, var_2, var_3, var_4);
}

marine_airstrike_single(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\sp\utility::spawn_anim_model("a10", self.origin, self.angles);
  var_4 thread a10_play_contrail();

  if(var_0 == 1)
    var_4 thread marine_airstrike_bombing_run(var_1, var_2);

  if(isDefined(var_3))
    thread a10_airstrike_fx(var_4);

  var_4 setanimrate(var_4 scripts\engine\utility::getanim("precision_airstrike"), 0.75);
  thread scripts\common\anim::anim_single_solo(var_4, "precision_airstrike");
  var_4 thread scripts\engine\sp\utility::play_sound_on_entity("mar_a10_airstrike_flyby");
  level.player notify("stop_a10_approach_loop");
  var_4 setanimtime(var_4 scripts\engine\utility::getanim("precision_airstrike"), 0.35);
  wait(getanimlength(var_4 scripts\engine\utility::getanim("precision_airstrike")));
  var_4 notify("disable_contrails");
  var_4 delete();
}

a10_airstrike_fx(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(self.trace_location, self.angles);
  var_2 = var_1.origin - var_0.origin;
  var_2 = vectortoangles(var_2);
  var_1 rotateTo(var_2, 0.05);
  wait 0.25;

  for(var_3 = 0; var_3 < 5; var_3++) {
    for(var_4 = 0; var_4 < 10; var_4++)
      playFX(scripts\engine\utility::getfx("airstrike_tracer"), var_1.origin + scripts\engine\utility::randomvectorrange(-200, 200) * (1, 1, 0), anglesToForward(var_1.angles), anglestoup(var_1.angles));

    wait(randomfloatrange(0.1, 0.2));
    var_5 = var_1.origin + scripts\engine\utility::randomvectorrange(-200, 200) * (1, 1, 0);
    playFX(scripts\engine\utility::getfx("airstrike_impact"), var_5, anglesToForward(var_1.angles), anglestoup(var_1.angles));
    earthquake(0.25, 2, var_5, 2000);
    radiusdamage(var_5, 250, 500, 500, undefined, "MOD_PROJECTILE_SPLASH");
  }
}

a10_play_contrail() {
  self endon("death");
  var_0 = scripts\engine\utility::getfx("contrail");
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var_1 linkTo(self, "tag_origin", (0, 250, 0), (0, 0, 0));
  var_2 linkTo(self, "tag_origin", (0, -250, 0), (0, 0, 0));
  playFXOnTag(var_0, var_1, "tag_origin");
  playFXOnTag(var_0, var_2, "tag_origin");
  self waittill("disable_contrails");
  stopFXOnTag(var_0, var_1, "tag_origin");
  stopFXOnTag(var_0, var_2, "tag_origin");
}

marine_airstrike_bombing_run(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  wait(var_0);
  thread marine_airstrike_rumble();
}

marine_airstrike_rumble() {
  wait 1.0;
  earthquake(0.25, 2, level.player.origin, 2000);
  level.player playRumbleOnEntity("damage_heavy");
}

init_dialog_structs() {
  level.alex_dialog_struct = create_dialog_struct("Alex", "allies");
  level.aq_soldier_dialog_struct = create_dialog_struct("AQ Soldier", "axis");
  level.civilian_dialog_struct = create_dialog_struct("Civilian", "neutral");
  level.civilian_ambusher_dialog_struct = create_dialog_struct("Disguised AQ", "neutral");
  level.marine_dialog_struct = create_dialog_struct("US Marine", "allies");
  level.pilot_dialog_struct = create_dialog_struct("Red Hammer 7", "allies");
  level.griggs_dialog_struct = create_dialog_struct("Sgt. Griggs", "allies");
  level.convoy_apc_dialog_struct = create_dialog_struct("Viper 3-5", "allies");
  level.wolf_dialog_struct = create_dialog_struct("Wolf", "axis");
  level.radio_dialog_struct = create_dialog_struct("Radio", "allies");
}

create_dialog_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.name = var_0;
  var_2.team = var_1;
  return var_2;
}

add_dialogue_line_alex(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.player) && isalive(level.player)) {
    level.player.name = "Alex";
    level.player.team = "allies";
    level.player dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

add_dialogue_line_heli_pilot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.pilot_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

add_dialogue_line_convoy_apc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.convoy_apc_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

add_dialogue_line_radio(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.radio_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

add_dialogue_line_griggs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.griggs)) {
    level.griggs.name = "Sgt. Griggs";
    level.griggs.team = "allies";
    level.griggs dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(!soundexists(var_0))
    level.griggs_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

add_dialogue_line_civ_ambusher(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.civ_ambusher)) {
    level.civ_ambusher.name = "Disguised AQ";
    level.civ_ambusher thread dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(!soundexists(var_0))
    level.civilian_ambusher_dialog_struct thread dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  level.civ_ambusher scripts\engine\sp\utility::name_hide();
}

add_dialogue_line_wolf(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.wolf)) {
    level.wolf.name = "^1Wolf";
    level.wolf.callsign = "^1Omar Sulaman";
    level.wolf.team = "axis";
    level.wolf dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(!soundexists(var_0))
    level.wolf_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4);
}

add_dialogue_line_marine(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.team = "allies";

    if(!isDefined(self.animname))
      self.animname = "generic";

    dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(!soundexists(var_0))
    level.marine_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

add_dialogue_line_aq(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "AQ Soldier";
    scripts\engine\sp\utility::name_hide();
    self.team = "axis";

    if(!isDefined(self.animname))
      self.animname = "generic";

    dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(!soundexists(var_0))
    level.aq_soldier_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

add_dialogue_line_civilian(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(self) && isalive(self)) {
    self.name = "Civilian";
    dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(!soundexists(var_0))
    level.civilian_dialog_struct dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

add_dialogue_line_hms(var_0, var_1, var_2, var_3) {
  var_0 dialogue(var_1);
}

hadir_follow_player() {
  self endon("death");
  self endon("stop_following_player");
  scripts\engine\sp\utility::set_goal_radius(16);
  thread ai_follow_player_ai_color_manager();

  for(;;) {
    if(isDefined(self.current_goal_override)) {
      self setgoalnode(self.current_goal_override);
      scripts\engine\utility::waittill_any_timeout(1, "goal");
      continue;
    }

    var_0 = getnodearray("hadir_leash_node", "script_noteworthy");

    if(var_0.size > 0) {
      if(!isDefined(self.current_goal))
        var_1 = var_0[0];
      else
        var_1 = self.current_goal;

      if(var_0.size > 1) {
        for(var_2 = 1; var_2 < var_0.size; var_2++) {
          if(1.1 * distance(level.player.origin, var_0[var_2].origin) < distance(level.player.origin, var_1.origin) && sighttracepassed(level.player getEye(), var_0[var_2].origin + (0, 0, 42), 0, level.player))
            var_1 = var_0[var_2];
        }
      }

      self setgoalnode(var_1);
      self.current_goal = var_1;
      scripts\engine\utility::waittill_any_timeout(5, "goal");
    }

    waitframe();
  }
}

ai_follow_player_ai_color_manager() {
  scripts\engine\sp\utility::disable_ai_color();
  self waittill("stop_following_player");
  scripts\engine\sp\utility::enable_ai_color();
}

autosave() {
  scripts\engine\sp\utility::autosave_by_name();
}

marines_autosave(var_0) {
  if(!isDefined(var_0))
    var_0 = [];

  thread marines_autosave_thread(var_0);
}

marines_autosave_thread(var_0) {
  scripts\engine\sp\utility::add_extra_autosave_check("marines_los", ::player_safe_from_poi_los, "Player in unsafe position (LOS).");
  scripts\engine\sp\utility::add_extra_autosave_check("marines_proximity", ::player_safe_from_enemy_proximity, "Player in unsafe position (proximity).");
  level.marines_los_checks = var_0;
  scripts\engine\sp\utility::autosave_by_name_thread();
  level.marines_los_checks = [];
}

player_safe_from_poi_los() {
  foreach(var_1 in level.marines_los_checks) {
    if(var_1 has_los_to_player())
      return 0;
  }

  return 1;
}

player_safe_from_enemy_proximity() {
  if(!isDefined(level.autosave_proximity_check) || level.autosave_proximity_check == 0)
    return 1;

  foreach(var_1 in getaiarray("axis")) {
    if(distancesquared(level.player.origin, var_1.origin) < level.autosave_proximity_check * level.autosave_proximity_check)
      return 0;
  }

  return 1;
}

has_los_to_player() {
  var_0 = level.player getEye();
  var_1 = level.player.origin;
  var_2 = (var_0 + var_1) / 2;
  var_3 = level.player getplayerangles();
  var_4 = anglestoright(var_3) * 16 + var_2;
  var_5 = anglestoleft(var_3) * 16 + var_2;
  var_6 = anglesToForward(var_3) * 16 + var_2;
  var_7 = -1 * anglesToForward(var_3) * 16 + var_2;
  var_8 = sighttracepassed(self.origin, var_0, 0, level.player);

  if(!var_8) {
    var_9 = sighttracepassed(self.origin, var_6, 0, level.player);

    if(!var_9) {
      var_10 = sighttracepassed(self.origin, var_7, 0, level.player);

      if(!var_10) {
        var_11 = sighttracepassed(self.origin, var_4, 0, level.player);

        if(!var_11) {
          var_12 = sighttracepassed(self.origin, var_5, 0, level.player);

          if(!var_12)
            return 0;
        }
      }
    }
  }

  return 1;
}

death_hint_watcher_marines_tripwire_death() {
  level notify("death_hint_watcher_marines_tripwire_death");
  level endon("death_hint_watcher_marines_tripwire_death");
  level.player waittill("death", var_0, var_1, var_2);

  if(var_0.classname == "worldspawn" && var_1 == "MOD_GRENADE_SPLASH")
    scripts\sp\player_death::set_custom_death_quote(402);
}

dialogue(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");

  if(isDefined(var_5))
    thread dialogue_glanceatentity(var_5, var_6, var_7);

  if(isDefined(var_2) && isDefined(var_3)) {
    if(!isarray(var_2))
      var_2 = [var_2];

    if(!isarray(var_3))
      var_3 = [var_3];

    foreach(var_10 in var_2) {
      foreach(var_12 in var_3)
      var_10 endon(var_12);
    }
  }

  if(isDefined(var_1) && var_1)
    wait(var_1);

  if(isDefined(var_8) && distance2d(level.player.origin, self.origin) > 750) {
    if(soundexists(var_8))
      dialogue_play_sound(var_8, 1);
    else {}
  } else if(soundexists(var_0))
    dialogue_play_sound(var_0, var_4);
  else {}
}

dialogue_play_sound(var_0, var_1) {
  if(isPlayer(self))
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else if(istrue(var_1))
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  else
    scripts\engine\sp\utility::smart_dialogue(var_0);

  self notify("dialogue_finished");
}

dialogue_glanceatentity(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_0)) {}

  if(!isDefined(var_1))
    var_1 = 2.0;

  if(isDefined(var_2))
    var_2 = 0;

  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.poiauto)) {
    var_4 = self.poiauto;
    scripts\asm\shared\utility::toggle_poiauto(0);
    var_3 = 1;
  } else if(isDefined(self.currentpoi)) {
    var_5 = self.currentpoi;
    scripts\common\ai::poi_enable(0);
  }

  self glanceatentity(var_0, int(var_1 * 1000), var_2);
  wait(var_1);

  if(var_3) {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, var_4.yawmin, var_4.yawmax, var_4.pitchmin, var_4.pitchmax);
  } else if(isDefined(var_5))
    scripts\common\ai::poi_enable(1, var_5);
}

propane_rockets_init() {
  wait 1;
  var_0 = getEntArray("scriptable_misc_propane_rocket_lightblue", "classname");

  foreach(var_2 in var_0)
  var_2 thread propane_rocket_badplace_manager();

  var_0 = getEntArray("scriptable_misc_propane_rocket_darkblue", "classname");

  foreach(var_2 in var_0)
  var_2 thread propane_rocket_badplace_manager();
}

propane_rocket_badplace_manager() {
  level endon("flag_lobby_secured");

  if(isDefined(self.badplace_manager)) {
    return;
  }
  self.badplace_manager = 1;
  var_0 = undefined;

  for(;;) {
    self waittill("scriptableNotification", var_1);

    if(var_1 == "fire") {
      if(!isDefined(var_0))
        var_0 = createnavbadplacebybounds(self.origin, (200, 200, 100), (0, 0, 0));
    }

    if(var_1 == "dead") {
      if(isDefined(var_0))
        destroynavobstacle(var_0);

      break;
    }
  }
}

transient_unload_load(var_0, var_1) {
  waitframe();

  if(isDefined(var_0)) {
    var_2 = [];

    if(isarray(var_0))
      var_2 = var_0;
    else
      var_2[0] = var_0;

    scripts\engine\sp\utility::transient_unload_array(var_2);
  }

  if(isDefined(var_1)) {
    var_3 = [];

    if(isarray(var_1))
      var_3 = var_1;
    else
      var_3[0] = var_1;

    scripts\engine\sp\utility::transient_load_array(var_3);
  }
}

marines_checkpoint_forcespawn_allies(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2.script_forcespawn = 1;
  }

  wait 5;

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2.script_forcespawn = 0;
  }
}

marine_path_util(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("entitydeleted");
  self.disablebulletwhizbyreaction = 1;

  if(var_5 == 1) {
    if(!isDefined(self.magic_bullet_shield))
      scripts\common\ai::magic_bullet_shield();
  }

  if(isDefined(var_2)) {
    scripts\asm\gesture::ai_request_gesture(var_2);
    wait 1.0;
  }

  if(isDefined(var_1))
    thread scripts\common\ai::poi_enable(1, var_1);

  if(isDefined(var_0)) {
    self.ignoreplayersuppressionlines = 1;
    self.disableplayeradsloscheck = 1;
    thread scripts\sp\spawner::go_to_node(var_0);
  }

  self waittill("goal");

  if(isDefined(var_1))
    scripts\common\ai::poi_enable(0);

  self.ignoreplayersuppressionlines = 0;
  self.disableplayeradsloscheck = 0;

  if(isDefined(var_3) && isDefined(var_4)) {
    if(scripts\engine\utility::is_equal(var_3, self.node)) {
      wait 1.0;
      scripts\asm\gesture::ai_request_gesture(var_4);
    } else
      scripts\asm\gesture::ai_request_gesture(var_4);
  }

  if(var_5 == 1) {
    if(isDefined(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();
  }

  self.disablebulletwhizbyreaction = 0;
}

get_closest_marine(var_0) {
  var_1 = [level.griggs];

  if(isDefined(level.farah))
    var_1 = scripts\engine\utility::array_add(var_1, level.farah);

  if(isDefined(level.hadir))
    var_1 = scripts\engine\utility::array_add(var_1, level.hadir);

  if(isDefined(level.groundfloor_bed_civ_hack_ally))
    var_1 = scripts\engine\utility::array_add(var_1, level.groundfloor_bed_civ_hack_ally);

  if(isDefined(level.draggingmarine))
    var_1 = scripts\engine\utility::array_add(var_1, level.draggingmarine);

  if(isDefined(level.draggedmarine))
    var_1 = scripts\engine\utility::array_add(var_1, level.draggedmarine);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0]))
    var_1 = scripts\engine\utility::array_add(var_1, level.introdoorbreachmarines[0]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1]))
    var_1 = scripts\engine\utility::array_add(var_1, level.introdoorbreachmarines[1]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2]))
    var_1 = scripts\engine\utility::array_add(var_1, level.introdoorbreachmarines[2]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3]))
    var_1 = scripts\engine\utility::array_add(var_1, level.introdoorbreachmarines[3]);

  if(isDefined(var_0)) {
    foreach(var_3 in var_0)
    var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  var_5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "allies", var_1);
  var_5 thread vo_timeout_manager();
  return var_5;
}

get_closest_marine_no_vo(var_0, var_1) {
  var_2 = [level.griggs];

  if(isDefined(level.farah))
    var_2 = scripts\engine\utility::array_add(var_2, level.farah);

  if(isDefined(level.hadir))
    var_2 = scripts\engine\utility::array_add(var_2, level.hadir);

  if(isDefined(level.groundfloor_bed_civ_hack_ally))
    var_2 = scripts\engine\utility::array_add(var_2, level.groundfloor_bed_civ_hack_ally);

  if(isDefined(level.draggingmarine))
    var_2 = scripts\engine\utility::array_add(var_2, level.draggingmarine);

  if(isDefined(level.draggedmarine))
    var_2 = scripts\engine\utility::array_add(var_2, level.draggedmarine);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[0]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[1]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[2]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[3]);

  if(isDefined(var_0)) {
    foreach(var_4 in var_0)
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  var_6 = scripts\engine\sp\utility::get_closest_ai(var_1, "allies", var_2);
  return var_6;
}

get_closest_aq() {
  var_0 = [];

  if(isDefined(level.wolf))
    var_0 = scripts\engine\utility::array_add(var_0, level.wolf);

  var_1 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis", var_0);
  return var_1;
}

get_closest_civ(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_3 in var_0)
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    } else
      var_1 = scripts\engine\utility::array_add(var_1, var_0);
  }

  if(var_1.size > 0)
    var_5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "neutral", var_1);
  else
    var_5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "neutral");

  return var_5;
}

vo_get_closest_available_marine(var_0, var_1) {
  var_2 = [level.griggs];

  if(isDefined(level.farah))
    var_2 = scripts\engine\utility::array_add(var_2, level.farah);

  if(isDefined(level.hadir))
    var_2 = scripts\engine\utility::array_add(var_2, level.hadir);

  if(isDefined(level.groundfloor_bed_civ_hack_ally))
    var_2 = scripts\engine\utility::array_add(var_2, level.groundfloor_bed_civ_hack_ally);

  if(isDefined(level.draggingmarine))
    var_2 = scripts\engine\utility::array_add(var_2, level.draggingmarine);

  if(isDefined(level.draggedmarine))
    var_2 = scripts\engine\utility::array_add(var_2, level.draggedmarine);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[0]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[1]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[2]);

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3]))
    var_2 = scripts\engine\utility::array_add(var_2, level.introdoorbreachmarines[3]);

  var_3 = getaiarray("allies");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.name))
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  foreach(var_8 in var_2)
  var_3 = scripts\engine\utility::array_remove(var_3, var_8);

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_8 in var_0)
      var_2 = scripts\engine\utility::array_add(var_2, var_8);
    } else
      var_2 = scripts\engine\utility::array_add(var_2, var_0);
  }

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_13 in var_1)
      var_2 = scripts\engine\utility::array_remove(var_2, var_13);
    } else
      var_2 = scripts\engine\utility::array_remove(var_2, var_1);
  }

  var_15 = 1;

  foreach(var_5 in var_3) {
    if(!istrue(var_5.vo_timeout))
      var_15 = 0;
  }

  if(var_15) {
    foreach(var_5 in var_3)
    var_5.vo_timeout = 0;
  }

  foreach(var_5 in var_3) {
    if(istrue(var_5.vo_timeout))
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
  }

  if(var_2.size == 0)
    var_2 = undefined;

  var_5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "allies", var_2);
  var_5 thread vo_timeout_manager();
  return var_5;
}

vo_timeout_manager() {
  self.vo_timeout = 1;
  wait 30;

  if(isDefined(self))
    self.vo_timeout = 0;
}

put_player_into_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_6))
    var_0 setModel("viewhands_alex_fullbody");
  else
    level.player hidelegsandshadow();

  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var_1 > 0.0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait(var_1);
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  var_0 show();
  var_0 castshadows();
}

pull_player_out_of_rig_hide_rig(var_0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var_0 hide();
  var_0 dontcastshadows();
  var_0 setModel("viewhands_alex_fullbody");
  level.player enableweapons();
  level.player unlink();
}

objective_wolf_los(var_0, var_1, var_2, var_3) {
  level.wolf endon("death");
  level.player endon("death");
  level endon("objective_wolf_los_end");

  if(!isalive(level.wolf)) {
    return;
  }
  scripts\engine\sp\utility::delaychildthread(0.25, ::wolf_los_handler);
  thread objective_trigger_handler(var_0, var_2);
  var_4 = "";

  if(isDefined(var_3) && var_3 == 1)
    thread ping_current_objective();

  for(;;) {
    var_5 = scripts\engine\utility::waittill_any_return("objective_wolf_los_true", "objective_wolf_los_false");

    if(var_5 == "objective_wolf_los_true") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
      scripts\engine\sp\objectives::objective_set_on_entity(var_0, "Wolf", level.wolf);
      scripts\engine\sp\objectives::objective_set_show_distance(var_0, 0);
      scripts\engine\sp\objectives::objective_set_z_offset(var_0, 80);
      scripts\engine\sp\objectives::objective_set_label(var_0, "Wolf");
      continue;
    }

    if(var_5 == "objective_wolf_los_false") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
      var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
      scripts\engine\sp\objectives::objective_set_label(var_0, "Wolf");
    }
  }
}

ping_current_objective() {
  if(level.player.focus.objectivesupdatedisplay == 1) {
    return;
  }
  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(1);
  wait 2.5;
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
}

wolf_los_handler() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 2;

  if(!isalive(level.wolf)) {
    return;
  }
  for(;;) {
    var_3 = level.player getEye();
    var_4 = level.wolf getEye();
    var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);
    var_6 = physics_raycast(var_3, var_4, var_5, level.player, 0, "physicsquery_any", 1);

    if(!var_6 && !var_0) {
      var_0 = 1;
      var_1 = 0;
      level notify("objective_wolf_los_true");
      wait(var_2);
    } else if(var_6 && !var_1) {
      var_1 = 1;
      var_0 = 0;
      level notify("objective_wolf_los_false");
      wait(var_2);
    }

    waitframe();
  }
}

objective_trigger_handler(var_0, var_1) {
  scripts\engine\sp\utility::trigger_wait_targetname(var_1);
  level notify("objective_wolf_los_end");
  scripts\engine\sp\objectives::objective_remove_all_locations(var_0);
}

marines_lookatentity(var_0, var_1) {
  self endon("stoplookat");

  if(!isDefined(var_1))
    var_1 = 90;

  for(;;) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, cos(var_1)))
      scripts\common\utility::lookatentity(var_0);
    else
      self stoplookat();

    waitframe();
  }
}

marines_stoplookat() {
  self notify("stoplookat");
  self stoplookat();
}

mg_gunner(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  level endon("mg_ceasefire");
  self.dummy_targets = var_1;
  self.mg_damage_nag = var_2;
  childthread mg_damage_nag_manager();
  self.weapon = var_0;

  if(isDefined(var_7))
    self.mag_size = var_7;
  else
    self.mag_size = 200;

  if(isDefined(var_8))
    self.ammo = var_8;
  else
    self.ammo = self.mag_size;

  if(isDefined(var_9))
    self.los_req = var_9;
  else
    self.los_req = 2;

  if(isDefined(var_10))
    self.target_player_start = 1 + var_10;
  else
    self.target_player_start = 1;

  if(isDefined(var_11)) {
    self.target_player_stop_min = 1 + var_11;
    self.target_player_stop_max = 2 + var_11;
  } else {
    self.target_player_stop_min = 1;
    self.target_player_stop_max = 2;
  }

  if(isDefined(var_3))
    self[[var_3]]();
  else {
    self.target_ent = level.player;
    self.target_actual = self.target_ent.origin + (0, 200, -100);
    thread mg_switch_targets(self.target_actual, self.target_ent.origin + (0, 0, 25), 2);
  }

  thread mg_smoke_monitor();
  thread mg_target_ent_manager(var_4);
  thread mg_target_actual_manager();
  mg_shoot_behavior(var_5, var_6);
}

mg_damage_nag_manager() {
  if(isDefined(level.player.mg_damage_nag_manager)) {
    return;
  }
  while(!isDefined(level.mg_damage_owner))
    waitframe();

  level.mg_damage_owner endon("death");
  level.player.mg_damage_nag_manager = 1;
  level.player.mg_damage_nag_total = 0;

  for(;;) {
    level.player waittill("damage", var_0, var_1);

    if(var_1 == level.mg_damage_owner) {
      level.player.mg_damage_nag_total = level.player.mg_damage_nag_total + var_0;

      if(level.player.mg_damage_nag_total > 100) {
        [[self.mg_damage_nag]]();
        level.player.mg_damage_nag_total = 0;
        wait 60;
      }
    }
  }
}

mg_damage_smoke_nag_streets() {
  scripts\engine\sp\utility::display_hint("smoke_hint", 5);
}

mg_damage_smoke_nag_mghall() {
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_alley_griggs_mg_warning();
}

mg_intro_sequence_streets() {
  thread mg_intro_sequence_streets_thread();
}

mg_intro_sequence_streets_thread() {
  level endon("mg_ceasefire");
  level endon("obj_update_to_gate");
  thread mg_intro_sequence_streets_endon_monitor();
  level.mg_streets_intro = 1;

  while(!isDefined(level.pinned_marine))
    waitframe();

  self.target_ent = level.pinned_marine;
  self.target_actual = self.target_ent.origin + (0, 0, -100);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin + (0, 0, -25), 10);

  while(isalive(level.pinned_marine))
    waitframe();

  wait 1;
  self.target_ent = scripts\engine\utility::getStruct("convoy_dust_particles_2", "targetname");
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 5);
  scripts\engine\utility::flag_wait_or_timeout("griggs_at_mg_cover_node", 1);
  wait 1;
  self.target_ent = getEnt("griggs_fake_bullet_marker", "targetname");
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 5);
  wait 2;
  level.mg_streets_intro = undefined;
  scripts\engine\utility::flag_set("mg_intro_complete");
}

mg_intro_sequence_streets_endon_monitor() {
  level endon("mg_intro_complete");
  scripts\engine\utility::flag_wait("obj_update_to_gate");
  self.target_ent = level.player;
  self.target_actual = self.target_ent.origin + (0, 0, 25);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 0.05);
  level.mg_streets_intro = undefined;
  scripts\engine\utility::flag_set("mg_intro_complete");
}

mg_intro_sequence_mg_hall() {
  thread monitor_hallway_mh_mg_los();

  if(!level.player issprinting()) {
    level.hallway_mh_mg_current_inaccuracy_offset_x = 0;
    level.hallway_mh_mg_current_inaccuracy_offset_y = -50;
    level.hallway_mh_mg_current_inaccuracy_offset_z = -25;

    for(var_0 = 0; var_0 < 2; var_0 = var_0 + 0.1) {
      if(level.hospital_upperfloor_mg_los > 0) {
        var_1 = (level.hallway_mh_mg_current_inaccuracy_offset_x, level.hallway_mh_mg_current_inaccuracy_offset_y, level.hallway_mh_mg_current_inaccuracy_offset_z);
        var_2 = level.player.origin + (randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance), randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance), randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance) + 30) + var_1;
        mg_shoot(var_2, level.mg_damage_owner);
      }

      level.hallway_mh_mg_current_inaccuracy_offset_x = level.hallway_mh_mg_current_inaccuracy_offset_x - 0.0;
      level.hallway_mh_mg_current_inaccuracy_offset_y = level.hallway_mh_mg_current_inaccuracy_offset_y - -2.5;
      level.hallway_mh_mg_current_inaccuracy_offset_z = level.hallway_mh_mg_current_inaccuracy_offset_z - -1.25;
      wait 0.1;
    }
  }

  scripts\engine\utility::flag_set("upperfloor_murderhole_intro_complete");
  self.target_ent = level.player;
  self.target_actual = self.target_ent.origin + (0, 0, 25);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 0.05);
}

monitor_hallway_mh_mg_los() {
  var_0 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");
  var_1 = 0;
  var_2 = 0.333333;
  var_3 = 1.0;

  while(!scripts\engine\utility::flag("flag_upperfloor_murderhole_abandon")) {
    var_4 = undefined;

    if((scripts\engine\utility::flag("flag_upperfloor_murderhole_flank_left") || scripts\engine\utility::flag("flag_upperfloor_murderhole_flank_right")) && level.player getstance() == "prone")
      var_4 = 100;
    else
      var_4 = 100;

    var_5 = var_4 - 10;
    var_6 = var_5 * var_2;
    var_7 = var_5 * var_3;

    if(sighttracepassed(var_0.origin, level.player getEye(), 0, undefined, 1)) {
      var_1 = var_1 + var_6;

      if(var_1 > var_4 - 10)
        var_1 = var_4 - 10;
    } else {
      var_1 = var_1 - var_7;

      if(var_1 < 0)
        var_1 = 0;
    }

    if(!scripts\engine\utility::flag("upperfloor_murderhole_intro_complete"))
      var_1 = var_4 - 10;

    level.hallway_mh_mg_variance = var_4 - var_1;
    wait 1;
  }
}

mg_smoke_monitor() {
  level endon("mg_ceasefire");
  self.los = 1;

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(var_1.basename)) {
      return;
    }
    if(var_1.basename == "smoke_tall") {
      var_0 waittill("explode", var_2);
      var_3 = (var_2[0] - level.player.origin[0], var_2[1] - level.player.origin[1], 0);
      var_4 = (self.origin[0] - var_2[0], self.origin[1] - var_2[1], 0);
      var_5 = vectordot(vectorNormalize(var_3), vectorNormalize(var_4));
      var_6 = distance(level.player.origin, var_2);
      var_7 = distance(self.origin, var_2);
      var_8 = 0.9;
      var_9 = 1000;

      if(var_6 < var_9 || var_7 < var_9 || var_5 > var_8)
        childthread mg_smoked();
    }

    wait 1.0;
  }
}

mg_smoked() {
  self.los--;
  wait 12;
  self.los++;
}

mg_shoot_behavior(var_0, var_1) {
  level endon("mg_ceasefire");

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1)
      level endon(var_3);
    } else
      level endon(var_1);
  }

  self.b_suppressed = 0;
  childthread shooting_monitor();
  childthread suppression_monitor(var_0);

  for(;;) {
    while(self.ammo == 0) {
      waitframe();
      continue;
    }

    while(self.ammo > 0) {
      self.burst = randomintrange(5, 51);

      while(self.ammo > 0 && self.burst > 0) {
        if(istrue(level.b_smoke) || !isDefined(self.target_actual) || self.b_suppressed) {
          waitframe();
          continue;
        }

        if(isDefined(level.mg_streets_intro))
          var_5 = 0.01 * distance(self.origin, self.target_actual);
        else
          var_5 = 0.0075 * distance(self.origin, self.target_actual);

        var_6 = self.target_actual + (randomfloatrange(-1 * var_5, var_5), randomfloatrange(-1 * var_5, var_5), randomfloatrange(-1 * var_5, var_5) + mg_get_z_offset());

        if(isDefined(level.mg_damage_owner))
          mg_shoot(var_6, level.mg_damage_owner);
        else
          mg_shoot(var_6);

        if(isDefined(self.target_ent) && mg_get_los_score(self.target_ent, 60) >= self.los_req)
          self.burst++;

        wait 0.1;
        self.burst--;
        self.ammo--;
      }

      if(self.ammo > 0)
        wait(randomfloatrange(0.5, 2.0));
    }

    thread mg_reload();
  }
}

shooting_monitor() {
  while(!isDefined(self.burst))
    waitframe();

  for(;;) {
    self.shooting = self.ammo && self.burst && (!isDefined(level.b_smoke) || !level.b_smoke) && isDefined(self.target_actual) && !self.b_suppressed;
    waitframe();
  }
}

suppression_monitor(var_0) {
  self.suppressed = 0.0;
  self.bullet_damage = 0;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_3, var_4);

    if(var_2 == level.player) {
      if(var_4 == "MOD_GRENADE_SPLASH") {
        thread mg_suppressed(randomfloatrange(3.0, 5.0));
        continue;
      }

      self.bullet_damage = self.bullet_damage + var_1;

      if(self.bullet_damage > 1000)
        thread mg_suppressed(randomfloatrange(2.0, 4.0));
    }
  }
}

mg_suppressed(var_0) {
  self notify("mg_suppressed");
  self endon("mg_suppressed");
  self.b_suppressed = 1;

  if(var_0 > self.suppressed)
    self.suppressed = var_0;

  while(self.suppressed > 0) {
    wait 0.05;
    self.suppressed = self.suppressed - 0.05;
  }

  self.b_suppressed = 0;
  self.bullet_damage = 0;
}

mg_reload() {
  self.burst = 0;
  level notify("mg_reloading");
  wait 3.5;
  self.ammo = self.mag_size;
}

mg_target_ent_manager(var_0) {
  level endon("mg_ceasefire");
  scripts\engine\utility::flag_wait(var_0);
  self.target_ent = level.player;
  var_1 = 0;
  self.playervisiblecount = 0;
  self.b_player_exposed = 0;
  var_2 = 0.0;

  for(;;) {
    var_3 = getEnt("mg_ignore", "targetname");

    if(isDefined(var_3) && ispointinvolume(level.player.origin, var_3))
      self.isplayervisible = 0;
    else
      self.isplayervisible = mg_get_los_score(level.player, 60);

    if(self.isplayervisible) {
      if(level.b_mg_on_player == 0)
        mg_target_player();

      self.playervisiblecount = self.playervisiblecount + 1.0;
      self.playervisiblecount = min(self.playervisiblecount, 8.0);
      var_2 = var_2 + 0.25;

      if(var_2 >= 3)
        self.b_player_exposed = 1;
    } else {
      if(var_1) {
        var_2 = 0;
        self.b_player_exposed = 0;
        thread mg_target_other();
      }

      self.playerlastposition = level.player getEye();
      self.playervisiblecount = 0;
    }

    var_1 = self.isplayervisible;
    wait 0.25;
  }
}

mg_target_player() {
  level endon("mg_ceasefire");
  self endon("mg_target_other");
  self endon("mg_target_dummy");
  self notify("mg_target_player");
  self endon("mg_target_player");

  if(self.target_player_start > 0)
    wait(self.target_player_start);
  else
    waitframe();

  if(self.isplayervisible && !level.b_mg_on_player) {
    level.b_mg_on_player = 1;
    self.target_ent = level.player;
    mg_switch_targets(self.target_actual, self.target_ent.origin, 1);
  }
}

mg_target_other() {
  level endon("mg_ceasefire");
  self endon("mg_target_player");
  self endon("mg_target_dummy");
  self notify("mg_target_other");
  self endon("mg_target_other");

  if(self.los > 0)
    wait(randomfloatrange(self.target_player_stop_min, self.target_player_stop_max));

  if(isDefined(self.target_ent) && self.target_ent == level.player) {
    if(istrue(self.isplayervisible))
      return;
    else
      level.b_mg_on_player = 0;
  }

  for(;;) {
    var_0 = getaiarray("allies");
    var_1 = [];
    var_0 = scripts\engine\utility::array_remove(var_0, level.griggs);

    foreach(var_3 in var_0) {
      if(var_3 mg_ignore_check())
        var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    }

    if(var_0.size == 0)
      mg_target_dummy();

    for(var_5 = 0; var_5 < var_0.size; var_5++)
      var_1[var_5] = mg_get_los_score(var_0[var_5], 60);

    var_6 = 0;

    foreach(var_8 in var_1) {
      if(var_8 > var_6)
        var_6 = var_8;
    }

    if(var_6 > 0) {
      var_10 = 0;

      foreach(var_8 in var_1) {
        if(var_8 == var_6)
          var_10++;
      }

      var_13 = randomint(var_10);
      var_14 = 0;

      foreach(var_8 in var_1) {
        if(var_8 == var_6 || var_14 == var_13) {
          self.target_ent = var_0[var_8];
          break;
        } else
          var_14++;
      }
    } else
      mg_target_dummy();

    if(!isDefined(self.target_ent)) {
      waitframe();
      continue;
    }

    mg_switch_targets(self.target_actual, self.target_ent.origin, 2);
    wait 2;
  }
}

mg_target_dummy() {
  level endon("mg_ceasefire");
  self.target_ent = self.dummy_targets[randomint(self.dummy_targets.size)];
  mg_switch_targets(self.target_actual, self.target_ent.origin, 2);
  wait 2;

  if(level.b_mg_on_player == 0 && self.isplayervisible == 1)
    thread mg_target_player();
  else
    thread mg_target_other();
}

mg_ignore_check() {
  var_0 = getEntArray("mg_ignore", "targetname");

  foreach(var_2 in var_0) {
    if(ispointinvolume(self.origin, var_2))
      return 1;
  }

  return 0;
}

mg_get_z_offset() {
  level endon("mg_ceasefire");

  if(isDefined(self.target_ent) && self.target_ent == level.player) {
    var_0 = [];
    var_0 = getEntArray("mg_z_offset_volume", "targetname");

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(ispointinvolume(level.player.origin, var_2)) {
          if(!sighttracepassed(self.origin, level.player getEye(), 0, level.player, 1))
            return 45;
        }
      }
    }

    switch (self.target_ent getstance()) {
      case "stand":
        return 60;
      case "crouch":
        return 30;
      case "prone":
        return 15;
    }
  } else
    return 45;
}

mg_get_los_score(var_0, var_1) {
  if(isDefined(var_0) && var_0 != level.player && !isai(var_0))
    return 0;

  level endon("mg_ceasefire");

  if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, cos(var_1)))
    return 0;

  if(ispointinvolume(var_0.origin, getEnt("mg_ignore", "targetname")))
    return 0;

  var_2 = var_0 getEye();
  var_3 = var_0.origin;
  var_4 = (var_2 + var_3) / 2;
  var_5 = anglesToForward(var_0.angles);
  var_6 = anglesToForward(var_5) * 16 + var_4;
  var_7 = -1 * anglesToForward(var_5) * 16 + var_4;
  var_8 = anglestoright(var_5) * 16 + var_4;
  var_9 = -1 * anglestoright(var_5) * 16 + var_4;
  var_10 = sighttracepassed(self.origin, var_2, 0, level.player);
  var_11 = sighttracepassed(self.origin, var_6, 0, level.player);
  var_12 = sighttracepassed(self.origin, var_7, 0, level.player);
  var_13 = sighttracepassed(self.origin, var_8, 0, level.player);
  var_14 = sighttracepassed(self.origin, var_9, 0, level.player);
  var_15 = 2 * var_10 + var_11 + var_12 + var_13 + var_14;

  if(var_15 >= self.los_req)
    return var_15;

  return 0;
}

mg_target_actual_manager() {
  level endon("mg_ceasefire");
  scripts\engine\utility::flag_wait("mg_intro_complete");

  if(mg_get_los_score(level.player, 60))
    mg_target_player();
  else
    mg_target_other();

  for(;;) {
    if(istrue(self.b_switching_targets)) {
      wait 0.1;
      continue;
    } else {
      if(isDefined(self.target_ent)) {
        if(self.b_player_exposed == 1) {
          self.target_actual = self.target_ent.origin;
          waitframe();
        } else {
          var_0 = 3.0;

          if(self.target_ent == level.player)
            var_0 = 1;

          var_1 = 30 * var_0;
          var_2 = 30 * var_0;
          var_3 = 30 * var_0;
          var_4 = (randomfloatrange(-1 * var_1, var_1), randomfloatrange(-1 * var_2, var_2), randomfloatrange(-1 * var_3, var_3) + -20);
          mg_lerp(self.target_actual, self.target_ent.origin + var_4, 1);
        }

        continue;
      }

      if(mg_get_los_score(level.player, 60)) {
        mg_target_player();
        continue;
      }

      mg_target_other();
    }
  }
}

mg_switch_targets(var_0, var_1, var_2) {
  level endon("mg_ceasefire");
  self notify("stop_lerp");
  self.b_switching_targets = 1;
  var_3 = distance(var_0, var_1) * 0.001 * var_2;

  if(var_3 == 0)
    var_3 = 0.05;

  mg_lerp(var_0, var_1, var_3);
  self.b_switching_targets = 0;
}

mg_lerp(var_0, var_1, var_2) {
  level endon("mg_ceasefire");
  self endon("stop_lerp");
  var_3 = var_1;
  var_4 = 0;
  var_5 = var_4 / var_2;
  var_6 = var_1 - self.target_ent.origin;

  while(var_4 < var_2) {
    wait 0.1;
    var_4 = var_4 + 0.1;
    var_5 = var_4 / var_2;

    if(isDefined(self.target_ent)) {
      if(!isDefined(var_0)) {}

      if(!isDefined(self.target_ent.origin)) {}

      if(!isDefined(var_6)) {}

      if(!isDefined(var_5)) {}

      self.target_actual = vectorlerp(var_0, self.target_ent.origin + var_6, var_5);
      var_3 = self.target_ent.origin;
      continue;
    }

    self.target_actual = vectorlerp(var_0, var_3 + var_6, var_5);
  }
}

mg_shoot(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1))
    magicbullet(self.weapon, self.origin, var_0, var_1);
  else
    magicbullet(self.weapon, self.origin, var_0);

  playFX(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self.origin, vectortoangles(self.origin - var_0));

  if(!isDefined(self.tracer))
    self.tracer = 0;

  if(self.tracer == 3) {
    thread mg_tracer(var_0);
    self.tracer = 0;
  } else
    self.tracer++;
}

mg_tracer(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, vectortoangles(self.origin - var_0));
  var_1 notsolid();
  playFXOnTag(scripts\engine\utility::getfx("vfx_tracer_lmg_wheelson_w"), var_1, "tag_origin");
  waitframe();
  var_1.origin = var_1.origin - (var_1.origin - var_0);
  waitframe();
  var_1 delete();
}

force_long_death(var_0) {
  scripts\engine\sp\utility::enable_long_death();
  self.forcelongdeath = var_0;
  self asmsetstate(self.asmname, "choose_long_death");
}

player_wander_fail_manager() {
  if(!isDefined(level.wander_fail_volumes))
    level.wander_fail_volumes = [];

  var_0 = getEnt("wander_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var_0);

  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.wander_fail_volumes) {
      if(level.player istouching(var_3)) {
        scripts\sp\player_death::set_custom_death_quote(409);
        scripts\sp\utility::missionfailedwrapper();
        level.player freezecontrols(1);
        level notify("mission_failed");
        setomnvar("ui_out_of_bounds_countdown", 0);
      }
    }

    wait 0.1;
  }
}

player_wander_nag_manager() {
  level endon("mission_failed");

  if(!isDefined(level.wander_nag_volumes))
    level.wander_nag_volumes = [];

  var_0 = getEnt("wander_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var_0);

  for(;;) {
    level.playerinnagvolume = 0;

    foreach(var_2 in level.wander_nag_volumes) {
      if(level.player istouching(var_2))
        level.playerinnagvolume = 1;
    }

    if(level.playerinnagvolume == 1)
      setomnvar("ui_out_of_bounds_countdown", 1);

    if(level.playerinnagvolume == 0)
      setomnvar("ui_out_of_bounds_countdown", 0);

    wait 0.1;
  }
}

add_volumes_to_array() {
  scripts\engine\utility::flag_wait("convoy_speed_up");
  var_0 = getEnt("IED_wander_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var_0);
  var_1 = getEnt("IED_wander_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var_1);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_start");
  var_2 = getEntArray("post_MG_wander_nag_volume", "targetname");
  var_3 = getEntArray("post_MG_wander_fail_volume", "targetname");

  foreach(var_5 in var_2)
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var_5);

  foreach(var_5 in var_3)
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var_5);

  level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var_0);
  level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var_1);
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  var_9 = getEntArray("retreat_nag_volume", "targetname");
  var_10 = getEntArray("retreat_fail_volume", "targetname");

  foreach(var_5 in var_9)
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var_5);

  foreach(var_5 in var_10)
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var_5);

  foreach(var_5 in var_2)
  level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var_5);

  foreach(var_5 in var_3)
  level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var_5);

  scripts\engine\utility::flag_wait("flag_lobby_exiting");
  var_19 = getEnt("lobby_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var_19);
  var_20 = getEnt("lobby_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var_20);

  foreach(var_5 in var_9)
  level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var_5);

  foreach(var_5 in var_10)
  level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var_5);

  scripts\engine\utility::flag_wait("flag_wolf_snakecam_complete");
}

leaving_area_dialogue_monitor() {
  level.return_to_mission_nagged = 0;

  while(!isDefined(level.playerinnagvolume))
    waitframe();

  for(;;) {
    if(level.playerinnagvolume == 1 && level.return_to_mission_nagged == 0) {
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_marines_leaving_area_nag();
      level.return_to_mission_nagged = 1;
      wait(randomfloatrange(9, 10));
      level.return_to_mission_nagged = 0;
    }

    waitframe();
  }

  waitframe();
}

transient_waittill(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_0);
  thread transient_unload_load(var_1, var_2);
}

marines_tripwire_monitor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 999999;
  var_9 = undefined;

  foreach(var_11 in level.tripwires.traps) {
    if(isDefined(var_11.origin) && distance2dsquared(var_11.origin, var_0.origin) < var_8) {
      var_8 = distance2dsquared(var_11.origin, var_0.origin);
      var_9 = var_11;
    }
  }

  if(isDefined(var_5)) {
    if(var_5 == 1)
      var_9.defusehintstruct.cursor_hint_ent sethintlockplayermovement(1);
  }

  var_9 thread marines_tripwire_defused_tracker(var_6);
  var_9 thread marines_tripwire_detonation_tracker(var_7);

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 moveTo(var_3.origin, 0.1);
    wait 0.2;
    var_2 disconnectPaths();
  }

  var_13 = var_9 scripts\engine\utility::waittill_any_return("tripwire_defused", "tripwire_detonated");

  if(isDefined(var_1))
    scripts\engine\utility::flag_set(var_1);

  if(isDefined(var_2) && isDefined(var_4)) {
    var_2 moveTo(var_4.origin, 0.1);
    wait 0.2;
    var_2 connectpaths();
  }

  return var_13;
}

marines_tripwire_defused_tracker(var_0) {
  self endon("tripwire_detonated");
  self.defusehintstruct waittill("trigger");

  if(isDefined(var_0))
    scripts\engine\utility::flag_set(var_0);

  self notify("tripwire_defused");
}

marines_tripwire_detonation_tracker(var_0) {
  self endon("tripwire_defused");
  self waittill("trigger", var_1, var_2);

  if(isDefined(var_0))
    scripts\engine\utility::flag_set(var_0);

  self notify("tripwire_detonated");
}

spawn_corpses(var_0, var_1, var_2) {
  var_3 = getspawnerarray(var_0);

  foreach(var_5 in var_3)
  thread spawn_corpse(var_5, var_1, var_2);
}

spawn_corpse(var_0, var_1, var_2) {
  if(!isspawner(var_0))
    var_0 = getspawner(var_0, "targetname");

  if(isDefined(var_2))
    var_0 scripts\engine\sp\utility::add_spawn_function(var_2);

  var_3 = var_0 scripts\engine\sp\utility::spawn_ai();
  var_3 endon("entitydeleted");
  var_3.animname = "dead_body";
  var_3.team = "neutral";
  var_3 setCanDamage(0);
  scripts\engine\utility::delaythread(0.05, ::corpse_anim_hack, var_3);
  var_0 scripts\common\anim::anim_single_solo(var_3, var_3.animation);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_3, var_3.animation);

  if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "manpile_monitor_exempt") {
    wait 1;
    var_3.forceragdollimmediate = 1;
    var_3 scripts\engine\sp\utility::anim_stopanimScripted();
    var_3 scripts\engine\sp\utility::set_allowdeath(1);
    var_3 scripts\engine\sp\utility::die();
  }

  scripts\engine\utility::flag_wait(var_1);

  if(isDefined(var_3))
    var_3 delete();
}

corpse_anim_hack(var_0) {
  var_0 setanimtime(level.scr_anim[var_0.animname][var_0.animation], 0.99);
}

stairwell_corpses_cleanup() {
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  var_0 = getcorpsearray();
  var_1 = getEnt("stairwell_corpses_info_volume", "targetname");

  foreach(var_3 in var_0) {
    if(ispointinvolume(var_3.origin, var_1))
      var_3 delete();
  }
}

player_underbarrel_grenade_launcher_equipped_monitor() {
  level endon("underbarrel_grenade_launcher_equipped");

  for(;;) {
    level.player waittill("weapon_change");

    if(createheadicon(level.player getcurrentweapon()) == "alt_iw8_ar_mike4+back_mike4+front_mike4+hybrid_west02+mag_mike4+rec_mike4+ub_mike203_sp")
      level notify("underbarrel_grenade_launcher_equipped");
  }
}

player_underbarrel_grenade_launcher_used_monitor() {
  level endon("end_underbarrel_grenade_launcher_monitor");
  scripts\engine\utility::flag_init("flag_underbarrel_grenade_launcher_used");

  for(;;) {
    level.player waittill("weapon_fired");

    if(createheadicon(level.player getcurrentweapon()) == "alt_iw8_ar_mike4+back_mike4+front_mike4+hybrid_west02+mag_mike4+rec_mike4+ub_mike203_sp") {
      scripts\engine\utility::flag_set("flag_underbarrel_grenade_launcher_used");
      level notify("end_underbarrel_grenade_launcher_monitor");
    }
  }
}

deletables_thread() {
  thread wait_for_deletables("alex_civ_dialogue");
  thread wait_for_deletables("flag_retreat_trigger_counterattack");
  thread wait_for_deletables("hospital_doors_closed");
  thread wait_for_deletables("flag_lobby_secured");
}

wait_for_deletables(var_0) {
  scripts\engine\utility::flag_init(var_0);
  scripts\engine\utility::flag_wait(var_0);
  thread do_deletable_delete(var_0);
}

do_deletable_delete(var_0) {
  wait 1;
  var_1 = getEntArray("deletable_" + var_0, "targetname");
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_2++;
    var_4 hide();
  }
}

get_all_script_models_with_modelname(var_0) {
  var_1 = getEntArray("script_model", "classname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4.model == var_0)
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

delete_when_offscreen(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, cos(35))) {
      if(distance(level.player.origin, self.origin) > var_0) {
        self hide();
        break;
      }
    }

    wait 0.25;
  }
}

delete_all_script_models_with_modelname(var_0) {
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    if(var_3.model == var_0)
      var_3 hide();
  }
}

delete_all_script_models_with_modelname_async(var_0) {
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    if(var_3.model == var_0)
      var_3 hide();

    waitframe();
  }
}

disable_weapon_swap(var_0) {
  self allowads(0);
  self disableweaponswitch();
  wait(var_0);
  self allowads(1);
  self enableweaponswitch();
}

delay_poi_enable(var_0, var_1, var_2) {
  wait(var_0);

  if(isDefined(self) && isalive(self))
    scripts\common\ai::poi_enable(var_1, var_2);
}

marine_room_clear_node(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_2 disconnectnode();

  scripts\engine\utility::flag_wait(var_0);
  wait(randomfloatrange(1.0, 2.0));
  wait 1;
  var_1 disconnectnode();

  if(isDefined(var_2))
    var_2 connectnode();

  var_3 = get_closest_marine_no_vo(undefined, var_1.origin);

  if(isDefined(var_3) && isalive(var_3)) {
    var_4 = distance2d(var_3.origin, var_1.origin);

    if(var_4 < 50 && isDefined(var_3) && isalive(var_3))
      var_3 setgoalnode(var_2);
  }
}

marines_intro_glanceback(var_0, var_1) {
  if(isDefined(var_1)) {
    if(distance2d(level.griggs.origin, level.player.origin) < var_1)
      return;
  }

  if(isDefined(var_0))
    wait(var_0);

  var_2 = getdvarfloat("MOKSKQLLMM");
  setsaveddvar("MOKSKQLLMM", 2048.0);
  var_3 = getaiarrayinradius(level.griggs.origin, 400, "allies");

  if(var_3.size > 0) {
    var_3 = scripts\engine\utility::array_randomize(var_3);
    var_4 = int(min(var_3.size, randomint(2) + 1));

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(var_4 <= 0) {
        break;
      }

      var_6 = var_3[var_5];

      if(isalive(var_6) && !var_6 scripts\asm\asm_bb::bb_isanimScripted()) {
        var_6 glanceatentity(level.player, randomintrange(800, 1200), 0);
        var_4--;
        wait(randomfloatrange(0.1, 0.3));
      }
    }
  }

  setsaveddvar("MOKSKQLLMM", var_2);
}

waittill_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

ally_equipment_backpack(var_0, var_1) {
  var_0 endon("death");

  if(!var_0 scripts\engine\utility::ent_flag_exist("show_eq_icon"))
    var_0 scripts\engine\utility::ent_flag_init("show_eq_icon");

  var_0.support_equipment = 4;
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;
  var_5 = "hud_icon_equipment_smoke";
  var_2 = "smoke_full";
  var_0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.icon_spot dontinterpolate();
  var_0.icon_spot linkTo(var_0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var_0.model_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.model_spot dontinterpolate();
  var_0.model_spot linkTo(var_0, "j_spine4", (-5, 7, 0), (90, 0, 0));
  thread ally_equipment_backpack_icon(var_0, var_5);
  thread ally_equipment_backpack_interact(var_0, var_1, var_5, var_2, var_4);
  thread griggs_equipment_nag_monitor();
}

ally_equipment_backpack_interact(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("remove_equipment");
  var_0 endon("death");

  for(;;) {
    wait 0.1;

    while(var_0.support_equipment == 0 || level.player getammocount(getcompleteweaponname("smoke_tall")) > 0)
      waitframe();

    var_5 = scripts\engine\utility::string(var_0.support_equipment);
    var_0.icon_spot scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var_4, 40, 200, 100, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    var_0 thread ally_equipment_remove();
    var_0.icon_spot waittill("trigger");
    waitframe();

    if(var_0.support_equipment == 0) {
      while(!var_0.support_equipment)
        waitframe();

      continue;
    }

    var_6 = level.player getammocount(getcompleteweaponname(var_1));
    var_7 = weaponmaxammo(var_1);
    var_8 = var_7 - var_6;
    var_9 = 0;

    if(getDvar("LMMLNRSLKS") == "autobuild")
      getentitylessscriptablearray("sp_ally_equipment", ["type", var_3, "levelname", level.script, "x", level.player.origin[0], "y", level.player.origin[1], "z", level.player.origin[2], "checkpoint", level.start_point, "ally", var_0.script_friendname]);

    if(var_6 != var_7) {
      if(var_8 <= var_0.support_equipment) {
        var_9 = var_8 + var_6;
        var_0.support_equipment = 0;
      } else {
        var_9 = var_0.support_equipment + var_6;
        var_0.support_equipment = 0;
      }

      level.player scripts\engine\sp\utility::player_gesture_force("ges_swipe");
      wait 0.3;
      level.player playSound("mar_pickup_smoke");
      level.player playRumbleOnEntity("damage_heavy");

      if(var_3 == "rpg_full") {
        level.player givemaxammo(var_1);
        level.player switchtoweapon(var_1);
        level.player setweaponammoclip(var_1, weaponclipsize(var_1));
      } else {
        level.player scripts\engine\sp\utility::give_offhand(var_1, var_9);
        wait 1;
      }
    } else {
      level.player forceplaygestureviewmodel("ges_titan_bunker");
      wait 0.75;
      level.player stopgestureviewmodel("ges_titan_bunker", 0.5);
      wait 3;
    }

    wait 0.5;
  }
}

ally_increase_equipment(var_0) {
  while(var_0.support_equipment > 0)
    wait 0.1;

  wait 3;
  var_0.support_equipment = 4;
}

ally_equipment_backpack_icon(var_0, var_1) {
  level.player endon("death");
  level.player.ally_equipment_force_ping = 0;
  var_0 endon("death");
  var_0.icon = undefined;
  var_0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.icon_spot linkTo(var_0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var_0.display_equipment = 0;
  level.focus_pressed = 0;
  thread distance_notify(var_0);

  for(;;) {
    display_icon_logic(var_0, var_1);
    wait 0.1;
  }
}

display_icon_logic(var_0, var_1) {
  var_0 endon("death");

  if(var_0.support_equipment == 0 || level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
    return;
  }
  if(level.player.ally_equipment_force_ping || var_0.display_equipment || getomnvar("ui_show_objectives")) {
    var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    waitframe();
    var_0 scripts\engine\utility::ent_flag_set("show_eq_icon");
    var_2 = distance(level.player.origin, var_0.origin) + 15;
    var_0.icon = deleteheadicon(var_0.icon_spot);
    setheadiconfriendlyimage(var_0.icon, var_1);
    setheadiconsnaptoedges(var_0.icon, 5000);
    setheadiconmaxdistance(var_0.icon, 100);
    setheadicondrawthroughgeo(var_0.icon, 1);
    var_3 = gettime() + 4000;

    for(;;) {
      if(level.player.ally_equipment_force_ping) {
        if(gettime() > var_3)
          level.player.ally_equipment_force_ping = 0;
      }

      if(var_0.support_equipment == 0) {
        var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      if(!getomnvar("ui_show_objectives") && !var_0.display_equipment && !level.player.ally_equipment_force_ping) {
        var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      waitframe();
    }

    var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    level.player.ally_equipment_force_ping = 0;
    level.player notify("remove_ally_icon");

    if(isDefined(var_0.icon)) {
      setheadiconimage(var_0.icon);
      var_0.icon = undefined;
    }
  }
}

display_icon_shutdown_logic(var_0) {
  var_0 endon("death");
  var_0 scripts\engine\utility::ent_flag_waitopen("show_eq_icon");

  if(isDefined(var_0.icon))
    return;
}

distance_notify(var_0) {
  wait 0.5;
  var_0 endon("death");
  var_1 = 0.93;

  for(;;) {
    var_2 = distance(level.player.origin, var_0.origin);

    if(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0 && 100 > var_2 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin + (0, 0, 40), var_1)) {
      var_0.display_equipment = 1;
      level.player notify("ally_equipment_notify");
    } else
      var_0.display_equipment = 0;

    wait 0.2;
  }
}

distance_checker(var_0) {
  var_1 = gettime() + 5000;

  for(;;) {
    var_2 = distance(level.player.origin, var_0.origin);

    if(100 < var_2)
      level.player notify("show_icon");

    waitframe();
  }
}

ally_equipment_remove() {
  self waittill("remove_equipment");
  self.icon_spot scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.support_equipment = 0;
}

griggs_supplies_refill() {
  level.griggs.support_equipment = 4;
}

griggs_equipment_nag_monitor() {
  level.griggs endon("remove_equipment");
  level.griggs endon("death");
  level.player endon("death");

  for(;;) {
    while(level.griggs.support_equipment == 0)
      waitframe();

    while(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0)
      waitframe();

    wait 1.5;

    if(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0) {
      while(level.griggs check_los_and_proximity(level.player) == 0)
        waitframe();

      if(level.griggs.support_equipment > 0) {
        level thread scripts\sp\maps\marines\marines_vo.gsc::vo_smoke_nag_dialogue();
        scripts\engine\sp\utility::display_hint_forced("smoke_nag", 5);
      }
    }

    while(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0)
      waitframe();
  }
}

griggs_damage_juggle_monitor() {
  while(!isDefined(level.griggs) && !isalive(level.griggs))
    waitframe();

  level.griggs_damage_points = 0;
  var_0 = 0;

  while(isDefined(level.griggs) && isalive(level.griggs)) {
    level.griggs waittill("damage");

    if(level.griggs_damage_points < 1)
      thread griggs_damage_juggle_decay_handler();

    level.griggs_damage_points++;

    if(isDefined(level.griggs) && isalive(level.griggs) && level.griggs_damage_points >= 20) {
      if(level.griggs.ignoreme == 1)
        var_0 = 1;
      else
        level.griggs.ignoreme = 1;

      level.griggs.disablebulletwhizbyreaction = 1;
      level.griggs scripts\engine\utility::disable_pain();
      wait 6;

      if(isDefined(level.griggs) && isalive(level.griggs)) {
        if(var_0 == 0 && level.griggs.ignoreme == 1)
          level.griggs.ignoreme = 0;

        level.griggs scripts\engine\utility::enable_pain();
        level.griggs.disablebulletwhizbyreaction = 0;
        level.griggs_damage_points = 0;
      }
    }
  }
}

griggs_damage_juggle_decay_handler() {
  for(;;) {
    wait 0.5;

    if(level.griggs_damage_points > 0) {
      level.griggs_damage_points = level.griggs_damage_points - 1;
      continue;
    }

    break;
  }
}

dialogue_stop() {
  self stopsounds();
}