/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_utility.gsc
*******************************************************/

function setup_named_ai(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\engine\sp\utility::spawn_targetname(var0, 1);

  if(!isDefined(var1)) {
    var1 = var0;
  }

  var7.name = var1;
  var7.animname = var0;
  var7.script_friendname = var1;
  var7.script_parameters = var0;
  var7.disableplayeradsloscheck = 1;
  var7.script_pushable = 1;
  var7.disablebulletwhizbyreaction = 1;
  var7.dontavoidplayer = 0;
  var7.ignoreplayersuppressionlines = 1;
  var7.dontchangepushplayer = 1;
  var7 pushplayer(0);

  if(isDefined(var6)) {
    var7.callsign = var6;
  }

  if(var0 == "griggs") {
    if(!isDefined(level.allymarines)) {
      init_marine_arrays();
    }

    if(var0 == "griggs") {
      level.allymarines["o"] = scripts\engine\utility::array_add(level.allymarines["o"], var7);
    }

    level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], var7);
  }

  var7.colornode_func = &color_node_arrive;

  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(var5 == 1) {
    var7 thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  }

  if(isDefined(var3)) {
    scripts\engine\sp\utility::activate_trigger_with_targetname(var3);
  }

  if(isDefined(var4) && isDefined(var7.asmname)) {
    if(var4 == "clear") {
      var7 scripts\common\utility::clear_demeanor_override();
    } else {
      var7 scripts\common\utility::demeanor_override(var4);
    }
  }

  if(isDefined(var2)) {
    var8 = scripts\engine\utility::getStruct(var2, "targetname");

    if(isDefined(var8)) {
      var7 forceteleport(var8.origin, var8.angles);
      var7 setgoalpos(var7.origin);
    }
  }

  return var7;
}

function setup_named_ai_after_spawn(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1)) {
    var1 = var0;
  }

  self.name = var1;
  self.animname = var0;
  self.script_friendname = var1;
  self.script_parameters = var0;
  self.disableplayeradsloscheck = 1;
  self.script_pushable = 1;
  self.disablebulletwhizbyreaction = 1;
  self.dontavoidplayer = 1;
  self pushplayer(0);

  if(var0 == "griggs" || var0 == "farah") {
    if(!isDefined(level.allymarines)) {
      init_marine_arrays();
    }

    if(var0 == "griggs") {
      level.allymarines["o"] = scripts\engine\utility::array_add(level.allymarines["o"], self);
    }

    level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], self);
  }

  self.colornode_func = &color_node_arrive;

  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(var5 == 1 && !isDefined(self.magic_bullet_shield)) {
    thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  }

  if(isDefined(var3)) {
    scripts\engine\sp\utility::activate_trigger_with_targetname(var3);
  }

  if(isDefined(var4) && isDefined(self.asmname)) {
    if(var4 == "clear") {
      scripts\common\utility::clear_demeanor_override();
    } else {
      scripts\common\utility::demeanor_override(var4);
    }
  }

  if(isDefined(var2)) {
    var6 = scripts\engine\utility::getStruct(var2, "targetname");

    if(isDefined(var6)) {
      self forceteleport(var6.origin, var6.angles);
      return;
    }

    return;
  }
}

function init_marine_arrays() {
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

function cleanup_marine_spawner_arrays() {
  level.colorspawners = [];
  level.colorspawners["o"] = [];
  level.colorspawners["y"] = [];
  level.colorspawners["r"] = [];
  level.colorspawners["b"] = [];
  level.colorspawners["c"] = [];
  level.colorspawners["g"] = [];
  level.colorspawners["p"] = [];
}

function switch_marines_from_color_to_color(var0, var1) {
  var2 = get_array_of_living_allies_by_color(var0);

  if(var2.size > 0) {
    foreach(var4 in var2) {
      if(isalive(var4)) {
        switch_marine_color(var4, var0, var1);
      }
    }

    return;
  }
}

function switch_marine_color(var0, var1) {
  if(!isDefined(var0)) {
    var0 = self.script_color;
  }

  var2 = self.myfloodspawner;
  scripts\engine\sp\utility::set_force_color(var1);
  level.allymarines[var0] = scripts\engine\utility::array_remove(level.allymarines[var0], self);
  level.allymarines[var1] = scripts\engine\utility::array_add(level.allymarines[var1], self);

  if(isDefined(var2)) {
    var2 scripts\engine\sp\utility::set_force_color(var1);
    level.colorspawners[var0] = scripts\engine\utility::array_remove(level.colorspawners[var0], var2);
    level.colorspawners[var1] = scripts\engine\utility::array_add(level.colorspawners[var1], var2);
    return;
  }
}

function color_node_arrive(var0) {
  self endon("death");
  waitframe();
  self.oldgoalradius = self.goalradius;
  self.goalradius = 1;
  self waittill("goal");

  if(isDefined(var0.script_gesture)) {
    thread scripts\asm\gesture::ai_request_gesture(var0.script_gesture, level.player, 10000);
  }

  if(isDefined(var0.script_flag)) {
    scripts\engine\utility::flag_set(var0.script_flag);
  }

  if(isDefined(var0.script_sound)) {
    thread scripts\engine\sp\utility::smart_dialogue(var0.script_sound);
  }

  if(var0.type == "Exposed" && isDefined(var0.script_parameters) && var0.script_parameters == "auto_poi") {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, 10, 20, 10, 20);
    thread color_node_left_cleanup();
  }

  self.goalradius = self.oldgoalradius;
}

function color_node_left_cleanup() {
  self endon("death");
  self waittill("stop_going_to_node");
  scripts\asm\shared\utility::toggle_poiauto(0);
}

function display_ai_count(var0) {
  level.player endon("death");
  level endon("nextmission");
  var1 = (1, 1, 1);
  var2 = (1, 1, 0);
  var3 = (0, 1, 0);
  var4 = (1, 0, 0);
  var5 = [];

  for(;;) {
    if(isDefined(var0)) {
      if(var0 != "all") {
        var5 = getaiarray(var0).size;
      } else {
        var5 = getaiarray("axis").size;
        var5 = getaiarray("allies").size;
        var5 = getaiarray("neutral").size;
      }
    } else {
      var5 = getaiarray().size;
    }

    var6 = 0;

    foreach(var8 in var5) {
      var6 += var8;
    }

    var10 = var1;

    if(var6 < 10) {
      var10 = var3;
    } else if(var6 < 20) {
      var10 = var2;
    } else {
      var10 = var4;
    }

    var11 = 700;
    var12 = 30;

    foreach(var8 in var5) {
      var14 = " AI";

      if(isDefined(var0)) {
        if(var0 == "all") {
          switch (var15) {
            case 0:
              var14 = " enemies";
              break;
            case 1:
              var14 = " allies";
              break;
            case 2:
              var14 = " civilians";
              break;
          }
        } else {
          var14 = " " + var0;
        }
      }

      var12 += 20;
    }

    waitframe();
  }
}

function setup_marine_allies(var0, var1, var2, var3) {
  level notify("new_setup_marine_allies");

  if(!isDefined(level.allymarines)) {
    init_marine_arrays();
  }

  cleanup_marine_spawner_arrays();
  level notify("new_marine_spawners");
  level.maxallymarines = 16;

  if(isDefined(var2)) {
    level.maxallymarines = var2;
  }

  if(isDefined(var1)) {
    var4 = getEnt(var1, "targetname");

    if(isDefined(var4)) {
      scripts\engine\sp\utility::activate_trigger_with_targetname(var1);
    }
  }

  var5 = getspawnerarray(var0);

  foreach(var7 in var5) {
    if(!isDefined(var7.script_forcecolor)) {
      var5 = scripts\engine\utility::array_remove(var5, var7);
      continue;
    }

    var8 = var7.script_forcecolor;

    switch (var8) {
      case "o":
        level.colorspawners["o"] = add_spawner_to_color_spawner_array(level.colorspawners["o"], var7);
        break;
      case "y":
        level.colorspawners["y"] = add_spawner_to_color_spawner_array(level.colorspawners["y"], var7);
        break;
      case "r":
        level.colorspawners["r"] = add_spawner_to_color_spawner_array(level.colorspawners["r"], var7);
        break;
      case "b":
        level.colorspawners["b"] = add_spawner_to_color_spawner_array(level.colorspawners["b"], var7);
        break;
      case "c":
        level.colorspawners["c"] = add_spawner_to_color_spawner_array(level.colorspawners["c"], var7);
        break;
      case "g":
        level.colorspawners["g"] = add_spawner_to_color_spawner_array(level.colorspawners["g"], var7);
        break;
      case "p":
        level.colorspawners["p"] = add_spawner_to_color_spawner_array(level.colorspawners["p"], var7);
        break;
      default:
        break;
    }
  }

  foreach(var11 in level.colorspawners) {
    foreach(var7 in var11) {
      if(!isDefined(var7) || !isspawner(var7)) {
        var11 = scripts\engine\utility::array_remove(var11, var7);
      }
    }

    if(var11.size == 0) {
      continue;
    }

    scripts\engine\sp\utility::array_spawn_function(var11, &add_marine_to_color_array);
    thread flood_spawn_allies(var14);
  }
}

function marine_callsign_generate_list_init() {
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

function marine_callsign_picker(var0) {
  thread marine_clear_callsign_on_death();

  for(;;) {
    var1 = 0;

    if(isDefined(var0)) {
      var2 = var0 + " " + scripts\engine\utility::random(level.callsign_prefix) + "-" + scripts\engine\utility::random(level.callsign_suffix);
    } else {
      var2 = level.callsign_squad[0] + " " + scripts\engine\utility::random(level.callsign_prefix) + "-" + scripts\engine\utility::random(level.callsign_suffix);
    }

    foreach(var4 in level.callsign_excluders) {
      if(var2 == var4) {
        var1 = 1;
      }
    }

    var6 = getaiarray("allies");

    if(var6.size > 0) {
      foreach(var8 in var6) {
        if(isDefined(var8) && isalive(var8) && isDefined(var8.callsign)) {
          if(var2 == var8.callsign) {
            var1 = 1;
          }
        }
      }
    }

    if(var1 == 0 && isDefined(self) && isalive(self)) {
      self.callsign = var2;
      break;
    }

    waitframe();
  }
}

function marine_clear_callsign_on_death() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");

  if(isDefined(self) && isDefined(self.callsign)) {
    self.callsign = undefined;
    return;
  }
}

function add_marine_to_color_array() {
  self endon("death");
  self endon("entitydeleted");
  thread marine_callsign_picker();
  var0 = self.script_forcecolor;
  self.colornode_func = &color_node_arrive;
  level.allymarines[var0] = scripts\engine\utility::array_removedead_or_dying(level.allymarines[var0]);
  level.allymarines["all"] = scripts\engine\utility::array_removedead_or_dying(level.allymarines["all"]);
  level.allymarines[var0] = scripts\engine\utility::array_add(level.allymarines[var0], self);
  level.allymarines["all"] = scripts\engine\utility::array_add(level.allymarines["all"], self);
}

function add_spawner_to_color_spawner_array(var0, var1) {
  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      var0 = scripts\engine\utility::array_remove(var0, var3);
      continue;
    }

    if(var3.targetname == var1.targetname) {
      continue;
    }

    var0 = scripts\engine\utility::array_remove(var0, var3);
    var3 delete();
  }

  var0 = scripts\engine\utility::array_add(var0, var1);
  return var0;
}

function flood_spawn_allies(var0) {
  level endon("new_marine_spawners");
  var1 = undefined;
  var2 = level.colorspawners[var0].size;

  while(level.colorspawners[var0].size > 0) {
    var3 = get_array_of_living_allies_by_color(var0);
    var4 = var3.size;

    if(var3.size >= var2) {
      waitframe();
      continue;
    }

    if(level.allymarines["all"].size >= level.maxallymarines) {
      waitframe();
      continue;
    }

    var5 = level.colorspawners[var0][level.colorspawners[var0].size - 1];

    if(isDefined(var5)) {
      if(isDefined(var5.script_radius)) {
        var6 = getaiarray("axis");
        var7 = 9999999;

        foreach(var9 in var6) {
          if(distancesquared(var5.origin, var9.origin) < var7) {
            var7 = distancesquared(var5.origin, var9.origin);
          }
        }

        if(var7 < squared(var5.script_radius)) {
          waitframe();
          continue;
        }
      }

      thread marine_flood_spawner_think();
      level.colorspawners[var0] = scripts\engine\utility::array_remove(level.colorspawners[var0], var5);
      var1 = var5.targetname;
    } else {
      return;
    }

    var11 = scripts\engine\utility::waittill_any_ents_or_timeout_return(5, var5, "marine_finished_spawning");

    if(var11 == "timeout") {
      var5 notify("death");
      level.colorspawners[var0] = scripts\engine\utility::array_insert(level.colorspawners[var0], var5, 0);
    }

    var3 = get_array_of_living_allies_by_color(var0);
  }
}

function marine_flood_spawner_think() {
  level endon("new_marine_spawners");

  if(isspawner(self)) {
    self endon("death");
  }

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  while(self.count > 0) {
    var0 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var0)) {
      wait 2;
      continue;
    }

    self notify("marine_finished_spawning");
    var0.myfloodspawner = self;
    var0 thread scripts\sp\spawner::reincrement_count_if_deleted(self);
    var0 waittill("death", var1);

    if(!scripts\sp\spawner::player_saw_kill(var0, var1)) {
      self.count++;
    }

    if(!isDefined(var0)) {
      continue;
    }

    if(!scripts\engine\utility::script_wait()) {
      wait randomfloatrange(5, 9);
    }
  }
}

function get_array_of_living_allies_by_color(var0) {
  level.allymarines[var0] = scripts\engine\utility::array_removedead_or_dying(level.allymarines[var0]);
  level.allymarines["all"] = scripts\engine\utility::array_removedead_or_dying(level.allymarines["all"]);
  return level.allymarines[var0];
}

function setup_named_vehicle(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var6 = scripts\common\utility::getvehiclespawner(var0, "targetname");
  var7 = scripts\common\vehicle::vehicle_spawn(var6);

  if(isDefined(var5) && var5 == 1) {
    var7 setModel("veh8_mil_lnd_stango_slats");
  }

  if(isDefined(var1)) {
    var7 setvehiclelookattext(var1, &"");
  }

  if(var4 == 1) {
    thread vehicle_nav_repulsor();
  }

  var8 = getvehiclenode(var2, "targetname");

  if(var3 == 1) {
    var7 scripts\common\vehicle::attach_vehicle_and_gopath(var8);
  } else {
    var7 scripts\common\vehicle::attach_vehicle(var8);
  }

  if(var7.classname == "script_vehicle_iw8_apc_stango") {
    scripts\common\vehicle_build::build_treadfx(var7.classname, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
    vehicle_turret_init(var7);
  }

  return var7;
}

function vehicle_nav_repulsor(var0) {
  self.repulsor = createnavrepulsor("vehicle " + self getentitynumber(), -1, self, 180, 1, "allies", "neutral", "axis");
  self waittill("death");

  if(!isDefined(var0)) {
    if(isDefined(self.repulsor)) {
      destroynavrepulsor(self.repulsor);
      return;
    }

    return;
  }
}

function vehicle_turret_init() {
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

function vehicle_turret_cleanup() {
  self waittill("death");

  if(isDefined(self.minigun)) {
    self.minigun delete();
    return;
  }
}

function delete_barricaded_door_boards(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "temp_board") {
      var3 delete();
    }
  }
}

function friendly_fire_dialogue_monitor() {
  var0 = 0;
  var1 = 0;

  for(;;) {
    var1 = level.friendlyfire["civilians_killed"];

    if(var1 > var0) {
      if(istrue(level.skip_next_friendly_fire_nag)) {
        level.skip_next_friendly_fire_nag = 0;
      } else {
        thread scripts\sp\maps\marines\marines_vo::vo_friendly_fire_dialogue();
      }
    }

    var0 = var1;
    waitframe();
  }
}

function check_los_and_proximity(var0) {
  var1 = sighttracepassed(self getEye(), var0 getEye(), 0, var0);
  var2 = distance(self.origin, var0.origin) <= 400;
  return var1 && var2;
}

function marine_airstrike_group(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 3;
  }

  var5 = scripts\engine\utility::getStructArray(var0, "targetname");
  scripts\engine\utility::array_thread_amortized(var5, &marine_airstrike_single, randomfloatrange(0.1, 0.2), var1, var2, var3, var4);
}

function marine_airstrike_single(var0, var1, var2, var3) {
  var4 = scripts\engine\sp\utility::spawn_anim_model("a10", self.origin, self.angles);
  thread a10_play_contrail();

  if(var0 == 1) {
    thread marine_airstrike_bombing_run(var4, var1);
  }

  if(isDefined(var3)) {
    thread a10_airstrike_fx(var4);
  }

  var4 setanimrate(var4 scripts\engine\utility::getanim("precision_airstrike"), 0.75);
  thread scripts\common\anim::anim_single_solo(var4, "precision_airstrike");
  var4 thread scripts\engine\sp\utility::play_sound_on_entity("mar_a10_airstrike_flyby");
  level.player notify("stop_a10_approach_loop");
  var4 setanimtime(var4 scripts\engine\utility::getanim("precision_airstrike"), 0.35);
  wait getanimlength(var4 scripts\engine\utility::getanim("precision_airstrike"));
  var4 notify("disable_contrails");
  var4 delete();
}

function a10_airstrike_fx(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin(self.trace_location, self.angles);
  var2 = var1.origin - var0.origin;
  var2 = vectortoangles(var2);
  var1 rotateTo(var2, 0.05);
  wait 0.25;

  for(var3 = 0; var3 < 5; var3++) {
    for(var4 = 0; var4 < 10; var4++) {
      playFX(scripts\engine\utility::getfx("airstrike_tracer"), var1.origin + scripts\engine\utility::randomvectorrange(-200, 200) * (1, 1, 0), anglesToForward(var1.angles), anglestoup(var1.angles));
    }

    wait randomfloatrange(0.1, 0.2);
    var5 = var1.origin + scripts\engine\utility::randomvectorrange(-200, 200) * (1, 1, 0);
    playFX(scripts\engine\utility::getfx("airstrike_impact"), var5, anglesToForward(var1.angles), anglestoup(var1.angles));
    earthquake(0.25, 2, var5, 2000);
    radiusdamage(var5, 250, 500, 500, undefined, "MOD_PROJECTILE_SPLASH");
  }
}

function a10_play_contrail() {
  self endon("death");
  var0 = scripts\engine\utility::getfx("contrail");
  var1 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var1 linkTo(self, "tag_origin", (0, 250, 0), (0, 0, 0));
  var2 linkTo(self, "tag_origin", (0, -250, 0), (0, 0, 0));
  playFXOnTag(var0, var1, "tag_origin");
  playFXOnTag(var0, var2, "tag_origin");
  self waittill("disable_contrails");
  stopFXOnTag(var0, var1, "tag_origin");
  stopFXOnTag(var0, var2, "tag_origin");
}

function marine_airstrike_bombing_run(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  wait var0;
  thread marine_airstrike_rumble();
}

function marine_airstrike_rumble() {
  wait 1;
  earthquake(0.25, 2, level.player.origin, 2000);
  level.player playRumbleOnEntity("damage_heavy");
}

function init_dialog_structs() {
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

function create_dialog_struct(var0, var1) {
  var2 = spawnStruct();
  var2.name = var0;
  var2.team = var1;
  return var2;
}

function add_dialogue_line_alex(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(level.player) && isalive(level.player)) {
    level.player.name = "Alex";
    level.player.team = "allies";
    dialogue(level.player, var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }
}

function add_dialogue_line_heli_pilot(var0, var1, var2, var3, var4, var5, var6, var7) {
  dialogue(level.pilot_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7);
}

function add_dialogue_line_convoy_apc(var0, var1, var2, var3, var4, var5, var6, var7) {
  dialogue(level.convoy_apc_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7);
}

function add_dialogue_line_radio(var0, var1, var2, var3, var4, var5, var6, var7) {
  dialogue(level.radio_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7);
}

function add_dialogue_line_griggs(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(level.griggs)) {
    level.griggs.name = "Sgt. Griggs";
    level.griggs.team = "allies";
    dialogue(level.griggs, var0, var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }

  if(!soundexists(var0)) {
    dialogue(level.griggs_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }
}

function add_dialogue_line_civ_ambusher(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(level.civ_ambusher)) {
    level.civ_ambusher.name = "Disguised AQ";
    thread dialogue(level.civ_ambusher, var0, var1, var2, var3, var4, var5, var6);
  } else if(!soundexists(var0)) {
    thread dialogue(level.civilian_ambusher_dialog_struct, var0, var1, var2, var3, var4, var5, var6);
  }

  level.civ_ambusher scripts\engine\sp\utility::name_hide();
}

function add_dialogue_line_wolf(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(level.wolf)) {
    level.wolf.name = "^1Wolf";
    level.wolf.callsign = "^1Omar Sulaman";
    level.wolf.team = "axis";
    dialogue(level.wolf, var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }

  if(!soundexists(var0)) {
    dialogue(level.wolf_dialog_struct, var0, var1, var2, var3, var4);
    return;
  }
}

function add_dialogue_line_marine(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.team = "allies";

    if(!isDefined(self.animname)) {
      self.animname = "generic";
    }

    dialogue(var0, var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }

  if(!soundexists(var0)) {
    dialogue(level.marine_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }
}

function add_dialogue_line_aq(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(self) && isalive(self) && isai(self)) {
    self.name = "AQ Soldier";
    scripts\engine\sp\utility::name_hide();
    self.team = "axis";

    if(!isDefined(self.animname)) {
      self.animname = "generic";
    }

    dialogue(var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }

  if(!soundexists(var0)) {
    dialogue(level.aq_soldier_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }
}

function add_dialogue_line_civilian(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(self) && isalive(self)) {
    self.name = "Civilian";
    dialogue(var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }

  if(!soundexists(var0)) {
    dialogue(level.civilian_dialog_struct, var0, var1, var2, var3, var4, var5, var6, var7);
    return;
  }
}

function add_dialogue_line_hms(var0, var1, var2, var3) {
  dialogue(var0, var1);
}

function hadir_follow_player() {
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

    var0 = getnodearray("hadir_leash_node", "script_noteworthy");

    if(var0.size > 0) {
      if(!isDefined(self.current_goal)) {
        var1 = var0[0];
      } else {
        var1 = self.current_goal;
      }

      if(var1.size > 1) {
        for(var2 = 1; var2 < var1.size; var2++) {
          if(1.1 * distance(level.player.origin, var1[var2].origin) < distance(level.player.origin, var1.origin) && sighttracepassed(level.player getEye(), var1[var2].origin + (0, 0, 42), 0, level.player)) {
            var1 = var1[var2];
          }
        }
      }

      self setgoalnode(var1);
      self.current_goal = var1;
      scripts\engine\utility::waittill_any_timeout(5, "goal");
    }

    waitframe();
  }
}

function ai_follow_player_ai_color_manager() {
  scripts\engine\sp\utility::disable_ai_color();
  self waittill("stop_following_player");
  scripts\engine\sp\utility::enable_ai_color();
}

function autosave() {
  scripts\engine\sp\utility::autosave_by_name();
}

function marines_autosave(var0) {
  if(!isDefined(var0)) {
    var0 = [];
  }

  thread marines_autosave_thread(var0);
}

function marines_autosave_thread(var0) {
  scripts\engine\sp\utility::add_extra_autosave_check("marines_los", &player_safe_from_poi_los, "Player in unsafe position (LOS).");
  scripts\engine\sp\utility::add_extra_autosave_check("marines_proximity", &player_safe_from_enemy_proximity, "Player in unsafe position (proximity).");
  level.marines_los_checks = var0;
  scripts\engine\sp\utility::autosave_by_name_thread();
  level.marines_los_checks = [];
}

function player_safe_from_poi_los() {
  foreach(var1 in level.marines_los_checks) {
    if(has_los_to_player(var1)) {
      return false;
    }
  }

  return true;
}

function player_safe_from_enemy_proximity() {
  if(!isDefined(level.autosave_proximity_check) || level.autosave_proximity_check == 0) {
    return true;
  }

  foreach(var1 in getaiarray("axis")) {
    if(distancesquared(level.player.origin, var1.origin) < level.autosave_proximity_check * level.autosave_proximity_check) {
      return false;
    }
  }

  return true;
}

function has_los_to_player() {
  var0 = level.player getEye();
  var1 = level.player.origin;
  var2 = (var0 + var1) / 2;
  var3 = level.player getplayerangles();
  var4 = anglestoright(var3) * 16 + var2;
  var5 = anglestoleft(var3) * 16 + var2;
  var6 = anglesToForward(var3) * 16 + var2;
  var7 = -1 * anglesToForward(var3) * 16 + var2;
  var8 = sighttracepassed(self.origin, var0, 0, level.player);

  if(!var8) {
    var9 = sighttracepassed(self.origin, var6, 0, level.player);

    if(!var9) {
      var10 = sighttracepassed(self.origin, var7, 0, level.player);

      if(!var10) {
        var11 = sighttracepassed(self.origin, var4, 0, level.player);

        if(!var11) {
          var12 = sighttracepassed(self.origin, var5, 0, level.player);

          if(!var12) {
            return false;
          }
        }
      }
    }
  }

  return true;
}

function death_hint_watcher_marines_tripwire_death() {
  level notify("death_hint_watcher_marines_tripwire_death");
  level endon("death_hint_watcher_marines_tripwire_death");
  level.player waittill("death", var0, var1, var2);

  if(var0.classname == "worldspawn" && var1 == "MOD_GRENADE_SPLASH") {
    scripts\sp\player_death::set_custom_death_quote(402);
    return;
  }
}

function dialogue(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("death");

  if(isDefined(var5)) {
    thread dialogue_glanceatentity(var5, var6, var7);
  }

  if(isDefined(var2) && isDefined(var3)) {
    if(!isarray(var2)) {
      var2 = [var2];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    foreach(var10 in var2) {
      foreach(var12 in var3) {
        var10 endon(var12);
      }
    }
  }

  if(isDefined(var1) && var1) {
    wait var1;
  }

  if(isDefined(var8) && distance2d(level.player.origin, self.origin) > 750) {
    if(soundexists(var8)) {
      dialogue_play_sound(var8, 1);
      return;
    }

    return;
  }

  if(soundexists(var0)) {
    dialogue_play_sound(var0, var4);
    return;
  }
}

function dialogue_play_sound(var0, var1) {
  if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(istrue(var1)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else {
    scripts\engine\sp\utility::smart_dialogue(var0);
  }

  self notify("dialogue_finished");
}

function dialogue_glanceatentity(var0, var1, var2) {
  self endon("death");

  if(isDefined(var0)) {}

  if(!isDefined(var1)) {
    var1 = 2;
  }

  if(isDefined(var2)) {
    var2 = 0;
  }

  var3 = 0;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(self.poiauto)) {
    var4 = self.poiauto;
    scripts\asm\shared\utility::toggle_poiauto(0);
    var3 = 1;
  } else if(isDefined(self.currentpoi)) {
    var5 = self.currentpoi;
    scripts\common\ai::poi_enable(0);
  }

  self glanceatentity(var0, int(var1 * 1000), var2);
  wait var1;

  if(var3) {
    scripts\common\ai::set_gunpose("ready", 1);
    scripts\asm\shared\utility::toggle_poiauto(1, var4.yawmin, var4.yawmax, var4.pitchmin, var4.pitchmax);
    return;
  }

  if(isDefined(var5)) {
    scripts\common\ai::poi_enable(1, var5);
    return;
  }
}

function propane_rockets_init() {
  wait 1;
  var0 = getEntArray("scriptable_misc_propane_rocket_lightblue", "classname");

  foreach(var2 in var0) {
    thread propane_rocket_badplace_manager();
  }

  var0 = getEntArray("scriptable_misc_propane_rocket_darkblue", "classname");

  foreach(var2 in var0) {
    thread propane_rocket_badplace_manager();
  }
}

function propane_rocket_badplace_manager() {
  level endon("flag_lobby_secured");

  if(isDefined(self.badplace_manager)) {
    return;
  }

  self.badplace_manager = 1;
  var0 = undefined;

  for(;;) {
    self waittill("scriptableNotification", var1);

    if(var1 == "fire") {
      if(!isDefined(var0)) {
        var0 = createnavbadplacebybounds(self.origin, (200, 200, 100), (0, 0, 0));
      }
    }

    if(var1 == "dead") {
      if(isDefined(var0)) {
        destroynavobstacle(var0);
      }

      break;
    }
  }
}

function transient_unload_load(var0, var1) {
  waitframe();

  if(isDefined(var0)) {
    var2 = [];

    if(isarray(var0)) {
      var2 = var0;
    } else {
      GscBinSkip0(0x2e, 0, var0);
    }

    scripts\engine\sp\utility::transient_unload_array(var2);
  }

  if(isDefined(var1)) {
    var3 = [];

    if(isarray(var1)) {
      var3 = var1;
    } else {
      GscBinSkip0(0x2e, 0, var1);
    }

    scripts\engine\sp\utility::transient_load_array(var3);
    return;
  }
}

function marines_checkpoint_forcespawn_allies(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2.script_forcespawn = 1;
    }
  }

  wait 5;

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2.script_forcespawn = 0;
    }
  }
}

function marine_path_util(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("entitydeleted");
  self.disablebulletwhizbyreaction = 1;

  if(var5 == 1) {
    if(!isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::magic_bullet_shield();
    }
  }

  if(isDefined(var2)) {
    scripts\asm\gesture::ai_request_gesture(var2);
    wait 1;
  }

  if(isDefined(var1)) {
    thread scripts\common\ai::poi_enable(1, var1);
  }

  if(isDefined(var0)) {
    self.ignoreplayersuppressionlines = 1;
    self.disableplayeradsloscheck = 1;
    thread scripts\sp\spawner::go_to_node(var0);
  }

  self waittill("goal");

  if(isDefined(var1)) {
    scripts\common\ai::poi_enable(0);
  }

  self.ignoreplayersuppressionlines = 0;
  self.disableplayeradsloscheck = 0;

  if(isDefined(var3) && isDefined(var4)) {
    if(scripts\engine\utility::is_equal(var3, self.node)) {
      wait 1;
      scripts\asm\gesture::ai_request_gesture(var4);
    } else {
      scripts\asm\gesture::ai_request_gesture(var4);
    }
  }

  if(var5 == 1) {
    if(isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  self.disablebulletwhizbyreaction = 0;
}

function get_closest_marine(var0) {
  var1 = [level.griggs];

  if(isDefined(level.farah)) {
    var1 = scripts\engine\utility::array_add(var1, level.farah);
  }

  if(isDefined(level.hadir)) {
    var1 = scripts\engine\utility::array_add(var1, level.hadir);
  }

  if(isDefined(level.groundfloor_bed_civ_hack_ally)) {
    var1 = scripts\engine\utility::array_add(var1, level.groundfloor_bed_civ_hack_ally);
  }

  if(isDefined(level.draggingmarine)) {
    var1 = scripts\engine\utility::array_add(var1, level.draggingmarine);
  }

  if(isDefined(level.draggedmarine)) {
    var1 = scripts\engine\utility::array_add(var1, level.draggedmarine);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0])) {
    var1 = scripts\engine\utility::array_add(var1, level.introdoorbreachmarines[0]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1])) {
    var1 = scripts\engine\utility::array_add(var1, level.introdoorbreachmarines[1]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2])) {
    var1 = scripts\engine\utility::array_add(var1, level.introdoorbreachmarines[2]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3])) {
    var1 = scripts\engine\utility::array_add(var1, level.introdoorbreachmarines[3]);
  }

  if(isDefined(var0)) {
    foreach(var3 in var0) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  var5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "allies", var1);
  thread vo_timeout_manager();
  return var5;
}

function get_closest_marine_no_vo(var0, var1) {
  var2 = [level.griggs];

  if(isDefined(level.farah)) {
    var2 = scripts\engine\utility::array_add(var2, level.farah);
  }

  if(isDefined(level.hadir)) {
    var2 = scripts\engine\utility::array_add(var2, level.hadir);
  }

  if(isDefined(level.groundfloor_bed_civ_hack_ally)) {
    var2 = scripts\engine\utility::array_add(var2, level.groundfloor_bed_civ_hack_ally);
  }

  if(isDefined(level.draggingmarine)) {
    var2 = scripts\engine\utility::array_add(var2, level.draggingmarine);
  }

  if(isDefined(level.draggedmarine)) {
    var2 = scripts\engine\utility::array_add(var2, level.draggedmarine);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[0]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[1]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[2]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[3]);
  }

  if(isDefined(var0)) {
    foreach(var4 in var0) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  var6 = scripts\engine\sp\utility::get_closest_ai(var1, "allies", var2);
  return var6;
}

function get_closest_aq() {
  var0 = [];

  if(isDefined(level.wolf)) {
    var0 = scripts\engine\utility::array_add(var0, level.wolf);
  }

  var1 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis", var0);
  return var1;
}

function get_closest_civ(var0) {
  var1 = [];

  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var3 in var0) {
        var1 = scripts\engine\utility::array_add(var1, var3);
      }
    } else {
      var1 = scripts\engine\utility::array_add(var1, var0);
    }
  }

  if(var1.size > 0) {
    var5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "neutral", var1);
  } else {
    var5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "neutral");
  }

  return var5;
}

function vo_get_closest_available_marine(var0, var1) {
  var2 = [level.griggs];

  if(isDefined(level.farah)) {
    var2 = scripts\engine\utility::array_add(var2, level.farah);
  }

  if(isDefined(level.hadir)) {
    var2 = scripts\engine\utility::array_add(var2, level.hadir);
  }

  if(isDefined(level.groundfloor_bed_civ_hack_ally)) {
    var2 = scripts\engine\utility::array_add(var2, level.groundfloor_bed_civ_hack_ally);
  }

  if(isDefined(level.draggingmarine)) {
    var2 = scripts\engine\utility::array_add(var2, level.draggingmarine);
  }

  if(isDefined(level.draggedmarine)) {
    var2 = scripts\engine\utility::array_add(var2, level.draggedmarine);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[0])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[0]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[1])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[1]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[2])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[2]);
  }

  if(isDefined(level.introdoorbreachmarines) && isDefined(level.introdoorbreachmarines[3])) {
    var2 = scripts\engine\utility::array_add(var2, level.introdoorbreachmarines[3]);
  }

  var3 = getaiarray("allies");

  foreach(var5 in var3) {
    if(!isDefined(var5.name)) {
      var2 = scripts\engine\utility::array_add(var2, var5);
    }
  }

  foreach(var8 in var2) {
    var3 = scripts\engine\utility::array_remove(var3, var8);
  }

  if(isDefined(var0)) {
    if(isarray(var0)) {
      foreach(var8 in var0) {
        var2 = scripts\engine\utility::array_add(var2, var8);
      }
    } else {
      var2 = scripts\engine\utility::array_add(var2, var0);
    }
  }

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var13 in var1) {
        var2 = scripts\engine\utility::array_remove(var2, var13);
      }
    } else {
      var2 = scripts\engine\utility::array_remove(var2, var1);
    }
  }

  var15 = 1;

  foreach(var5 in var3) {
    if(!istrue(var5.vo_timeout)) {
      var15 = 0;
    }
  }

  if(var15) {
    foreach(var5 in var3) {
      var5.vo_timeout = 0;
    }
  }

  foreach(var5 in var3) {
    if(istrue(var5.vo_timeout)) {
      var2 = scripts\engine\utility::array_add(var2, var5);
    }
  }

  if(var2.size == 0) {
    var2 = undefined;
  }

  var5 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "allies", var2);
  thread vo_timeout_manager();
  return var5;
}

function vo_timeout_manager() {
  self.vo_timeout = 1;
  wait 30;

  if(isDefined(self)) {
    self.vo_timeout = 0;
    return;
  }
}

function put_player_into_rig(var0, var1, var2, var3, var4, var5, var6) {
  if(istrue(var6)) {
    var0 setModel("viewhands_alex_fullbody");
  } else {
    level.player hidelegsandshadow();
  }

  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  var0 show();
  var0 castshadows();
}

function pull_player_out_of_rig_hide_rig(var0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var0 hide();
  var0 dontcastshadows();
  var0 setModel("viewhands_alex_fullbody");
  level.player enableweapons();
  level.player unlink();
}

function objective_wolf_los(var0, var1, var2, var3) {
  level.wolf endon("death");
  level.player endon("death");
  level endon("objective_wolf_los_end");

  if(!isalive(level.wolf)) {
    return;
  }

  scripts\engine\sp\utility::delaychildthread(0.25, &wolf_los_handler);
  thread objective_trigger_handler(var0, var2);
  var4 = "";
  jumpiffalse(isDefined(var3) && var3 == 1) LOC_0000005f;
  thread ping_current_objective();

  for(;;) {
    var5 = scripts\engine\utility::waittill_any_return("objective_wolf_los_true", "objective_wolf_los_false");

    if(var5 == "objective_wolf_los_true") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var0);
      scripts\engine\sp\objectives::objective_set_on_entity(var0, "Wolf", level.wolf);
      scripts\engine\sp\objectives::objective_set_show_distance(var0, 0);
      scripts\engine\sp\objectives::objective_set_z_offset(var0, 80);
      scripts\engine\sp\objectives::objective_set_label(var0, "Wolf");
      continue;
    }

    if(var5 == "objective_wolf_los_false") {
      scripts\engine\sp\objectives::objective_remove_all_locations(var0);
      var6 = scripts\engine\utility::getStruct(var1, "targetname");
      scripts\engine\sp\objectives::objective_set_label(var0, "Wolf");
    }
  }
}

function ping_current_objective() {
  if(level.player.focus.objectivesupdatedisplay == 1) {
    return;
  }

  level.player scripts\sp\player::set_focus_objectives_update_display(1);
  level.player scripts\sp\player::set_focus_infinite_hold(1);
  wait 2.5;
  level.player scripts\sp\player::set_focus_objectives_update_display(0);
  level.player scripts\sp\player::set_focus_infinite_hold(0);
}

function wolf_los_handler() {
  var0 = 0;
  var1 = 0;
  var2 = 2;
  jumpiftrue(isalive(level.wolf)) LOC_00000017;
  return;
}

function objective_trigger_handler(var0, var1) {
  scripts\engine\sp\utility::trigger_wait_targetname(var1);
  level notify("objective_wolf_los_end");
  scripts\engine\sp\objectives::objective_remove_all_locations(var0);
}

function marines_lookatentity(var0, var1) {
  self endon("stoplookat");

  if(!isDefined(var1)) {
    var1 = 90;
  }

  for(;;) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, cos(var1))) {
      scripts\common\utility::lookatentity(var0);
    } else {
      self stoplookat();
    }

    waitframe();
  }
}

function marines_stoplookat() {
  self notify("stoplookat");
  self stoplookat();
}

function mg_gunner(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  level endon("mg_ceasefire");
  self.dummy_targets = var1;
  self.mg_damage_nag = var2;
  GscBinSkip4(0x35);
}

function mg_damage_nag_manager() {
  if(isDefined(level.player.mg_damage_nag_manager)) {
    return;
  }

  while(!isDefined(level.mg_damage_owner)) {
    waitframe();
  }

  level.mg_damage_owner endon("death");
  level.player.mg_damage_nag_manager = 1;
  level.player.mg_damage_nag_total = 0;

  for(;;) {
    level.player waittill("damage", var0, var1);

    if(var1 == level.mg_damage_owner) {
      level.player.mg_damage_nag_total += var0;

      if(level.player.mg_damage_nag_total > 100) {
        [[self.mg_damage_nag]]();
        level.player.mg_damage_nag_total = 0;
        wait 60;
      }
    }
  }
}

function mg_damage_smoke_nag_streets() {
  scripts\engine\sp\utility::display_hint("smoke_hint", 5);
}

function mg_damage_smoke_nag_mghall() {
  thread scripts\sp\maps\marines\marines_vo::vo_alley_griggs_mg_warning();
}

function mg_intro_sequence_streets() {
  thread mg_intro_sequence_streets_thread();
}

function mg_intro_sequence_streets_thread() {
  level endon("mg_ceasefire");
  level endon("obj_update_to_gate");
  thread mg_intro_sequence_streets_endon_monitor();
  level.mg_streets_intro = 1;

  while(!isDefined(level.pinned_marine)) {
    waitframe();
  }

  self.target_ent = level.pinned_marine;
  self.target_actual = self.target_ent.origin + (0, 0, -100);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin + (0, 0, -25), 10);

  while(isalive(level.pinned_marine)) {
    waitframe();
  }

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

function mg_intro_sequence_streets_endon_monitor() {
  level endon("mg_intro_complete");
  scripts\engine\utility::flag_wait("obj_update_to_gate");
  self.target_ent = level.player;
  self.target_actual = self.target_ent.origin + (0, 0, 25);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 0.05);
  level.mg_streets_intro = undefined;
  scripts\engine\utility::flag_set("mg_intro_complete");
}

function mg_intro_sequence_mg_hall() {
  thread monitor_hallway_mh_mg_los();

  if(!level.player issprinting()) {
    level.hallway_mh_mg_current_inaccuracy_offset_x = 0;
    level.hallway_mh_mg_current_inaccuracy_offset_y = -50;
    level.hallway_mh_mg_current_inaccuracy_offset_z = -25;
    var0 = 0;

    while(var0 < 2) {
      if(level.hospital_upperfloor_mg_los > 0) {
        var1 = (level.hallway_mh_mg_current_inaccuracy_offset_x, level.hallway_mh_mg_current_inaccuracy_offset_y, level.hallway_mh_mg_current_inaccuracy_offset_z);
        var2 = level.player.origin + (randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance), randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance), randomfloatrange(-1 * level.hallway_mh_mg_variance, level.hallway_mh_mg_variance) + 30) + var1;
        mg_shoot(var2, level.mg_damage_owner);
      }

      level.hallway_mh_mg_current_inaccuracy_offset_x -= 0;
      level.hallway_mh_mg_current_inaccuracy_offset_y -= -2.5;
      level.hallway_mh_mg_current_inaccuracy_offset_z -= -1.25;
      wait 0.1;
      var0 += 0.1;
    }
  }

  scripts\engine\utility::flag_set("upperfloor_murderhole_intro_complete");
  self.target_ent = level.player;
  self.target_actual = self.target_ent.origin + (0, 0, 25);
  thread mg_switch_targets(self.target_actual, self.target_ent.origin, 0.05);
}

function monitor_hallway_mh_mg_los() {
  var0 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");
  var1 = 0;
  var2 = 0.333333;
  var3 = 1;

  while(!scripts\engine\utility::flag("flag_upperfloor_murderhole_abandon")) {
    var4 = undefined;

    if((scripts\engine\utility::flag("flag_upperfloor_murderhole_flank_left") || scripts\engine\utility::flag("flag_upperfloor_murderhole_flank_right")) && level.player getstance() == "prone") {
      var4 = 100;
    } else {
      var4 = 100;
    }

    var5 = var4 - 10;
    var6 = var5 * var2;
    var7 = var5 * var3;

    if(sighttracepassed(var0.origin, level.player getEye(), 0, undefined, 1)) {
      var1 += var6;

      if(var1 > var4 - 10) {
        var1 = var4 - 10;
      }
    } else {
      var1 -= var7;

      if(var1 < 0) {
        var1 = 0;
      }
    }

    if(!scripts\engine\utility::flag("upperfloor_murderhole_intro_complete")) {
      var1 = var4 - 10;
    }

    level.hallway_mh_mg_variance = var4 - var1;
    wait 1;
  }
}

function mg_smoke_monitor() {
  level endon("mg_ceasefire");
  self.los = 1;

  for(;;) {
    level.player waittill("grenade_fire", var0, var1);

    if(!isDefined(var0)) {
      return;
    }

    if(!isDefined(var1.basename)) {
      return;
    }

    if(var1.basename == "smoke_tall") {
      var0 waittill("explode", var2);
      var3 = (var2[0] - level.player.origin[0], var2[1] - level.player.origin[1], 0);
      var4 = (self.origin[0] - var2[0], self.origin[1] - var2[1], 0);
      var5 = vectordot(vectorNormalize(var3), vectorNormalize(var4));
      var6 = distance(level.player.origin, var2);
      var7 = distance(self.origin, var2);
      var8 = 0.9;
      var9 = 1000;

      if(var6 < var9 || var7 < var9 || var5 > var8) {
        GscBinSkip4(0x35);
      }
    }

    wait 1;
  }
}

function mg_smoked() {
  self.los--;
  wait 12;
  self.los++;
}

function mg_shoot_behavior(var0, var1) {
  level endon("mg_ceasefire");

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var3 in var1) {
        level endon(var3);
      }
    } else {
      level endon(var1);
    }
  }

  self.b_suppressed = 0;
  GscBinSkip4(0x35);
}

function shooting_monitor() {
  while(!isDefined(self.burst)) {
    waitframe();
  }

  for(;;) {
    self.shooting = self.ammo && self.burst && (!isDefined(level.b_smoke) || !level.b_smoke) && isDefined(self.target_actual) && !self.b_suppressed;
    waitframe();
  }
}

function suppression_monitor(var0) {
  self.suppressed = 0;
  self.bullet_damage = 0;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var3, var4);

    if(var2 == level.player) {
      if(var4 == "MOD_GRENADE_SPLASH") {
        thread mg_suppressed(randomfloatrange(3, 5));
        continue;
      }

      self.bullet_damage += var1;

      if(self.bullet_damage > 1000) {
        thread mg_suppressed(randomfloatrange(2, 4));
      }
    }
  }
}

function mg_suppressed(var0) {
  self notify("mg_suppressed");
  self endon("mg_suppressed");
  self.b_suppressed = 1;

  if(var0 > self.suppressed) {
    self.suppressed = var0;
  }

  while(self.suppressed > 0) {
    wait 0.05;
    self.suppressed -= 0.05;
  }

  self.b_suppressed = 0;
  self.bullet_damage = 0;
}

function mg_reload() {
  self.burst = 0;
  level notify("mg_reloading");
  wait 3.5;
  self.ammo = self.mag_size;
}

function mg_target_ent_manager(var0) {
  level endon("mg_ceasefire");
  scripts\engine\utility::flag_wait(var0);
  self.target_ent = level.player;
  var1 = 0;
  self.playervisiblecount = 0;
  self.b_player_exposed = 0;
  var2 = 0;

  for(;;) {
    var3 = getEnt("mg_ignore", "targetname");

    if(isDefined(var3) && ispointinvolume(level.player.origin, var3)) {
      self.isplayervisible = 0;
    } else {
      self.isplayervisible = mg_get_los_score(level.player, 60);
    }

    if(self.isplayervisible) {
      if(level.b_mg_on_player == 0) {
        mg_target_player();
      }

      self.playervisiblecount += 1;
      self.playervisiblecount = min(self.playervisiblecount, 8);
      var2 += 0.25;

      if(var2 >= 3) {
        self.b_player_exposed = 1;
      }
    } else {
      if(var1) {
        var2 = 0;
        self.b_player_exposed = 0;
        thread mg_target_other();
      }

      self.playerlastposition = level.player getEye();
      self.playervisiblecount = 0;
    }

    var1 = self.isplayervisible;
    wait 0.25;
  }
}

function mg_target_player() {
  level endon("mg_ceasefire");
  self endon("mg_target_other");
  self endon("mg_target_dummy");
  self notify("mg_target_player");
  self endon("mg_target_player");

  if(self.target_player_start > 0) {
    wait self.target_player_start;
  } else {
    waitframe();
  }

  if(self.isplayervisible && !level.b_mg_on_player) {
    level.b_mg_on_player = 1;
    self.target_ent = level.player;
    mg_switch_targets(self.target_actual, self.target_ent.origin, 1);
    return;
  }
}

function mg_target_other() {
  level endon("mg_ceasefire");
  self endon("mg_target_player");
  self endon("mg_target_dummy");
  self notify("mg_target_other");
  self endon("mg_target_other");

  if(self.los > 0) {
    wait randomfloatrange(self.target_player_stop_min, self.target_player_stop_max);
  }

  jumpiffalse(isDefined(self.target_ent) && self.target_ent == level.player) LOC_00000069;

  if(istrue(self.isplayervisible)) {
    return;
  }

  level.b_mg_on_player = 0;

  for(;;) {
    var0 = getaiarray("allies");
    var1 = [];
    var0 = scripts\engine\utility::array_remove(var0, level.griggs);

    foreach(var3 in var0) {
      if(mg_ignore_check(var3)) {
        var0 = scripts\engine\utility::array_remove(var0, var3);
      }
    }

    if(var0.size == 0) {
      mg_target_dummy();
    }

    for(var5 = 0; var5 < var0.size; var5++) {
      var1 = mg_get_los_score(var0[var5], 60);
    }

    var6 = 0;

    foreach(var8 in var1) {
      if(var8 > var6) {
        var6 = var8;
      }
    }

    if(var6 > 0) {
      var10 = 0;

      foreach(var8 in var1) {
        if(var8 == var6) {
          var10++;
        }
      }

      var13 = randomint(var10);
      var14 = 0;

      foreach(var8 in var1) {
        if(var8 == var6 || var14 == var13) {
          self.target_ent = var0[var8];
          break;
        }

        var14++;
      }
    } else {
      mg_target_dummy();
    }

    if(!isDefined(self.target_ent)) {
      waitframe();
      continue;
    }

    mg_switch_targets(self.target_actual, self.target_ent.origin, 2);
    wait 2;
  }
}

function mg_target_dummy() {
  level endon("mg_ceasefire");
  self.target_ent = self.dummy_targets[randomint(self.dummy_targets.size)];
  mg_switch_targets(self.target_actual, self.target_ent.origin, 2);
  wait 2;

  if(level.b_mg_on_player == 0 && self.isplayervisible == 1) {
    thread mg_target_player();
    return;
  }

  thread mg_target_other();
}

function mg_ignore_check() {
  var0 = getEntArray("mg_ignore", "targetname");

  foreach(var2 in var0) {
    if(ispointinvolume(self.origin, var2)) {
      return true;
    }
  }

  return false;
}

function mg_get_z_offset() {
  level endon("mg_ceasefire");

  if(isDefined(self.target_ent) && self.target_ent == level.player) {
    var0 = [];
    var0 = getEntArray("mg_z_offset_volume", "targetname");

    if(var0.size > 0) {
      foreach(var2 in var0) {
        if(ispointinvolume(level.player.origin, var2)) {
          if(!sighttracepassed(self.origin, level.player getEye(), 0, level.player, 1)) {
            return 45;
          }
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

    return;
  }

  return 45;
}

function mg_get_los_score(var0, var1) {
  if(isDefined(var0) && var0 != level.player && !isai(var0)) {
    return 0;
  }

  level endon("mg_ceasefire");

  if(!scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, cos(var1))) {
    return 0;
  }

  if(ispointinvolume(var0.origin, getEnt("mg_ignore", "targetname"))) {
    return 0;
  }

  var2 = var0 getEye();
  var3 = var0.origin;
  var4 = (var2 + var3) / 2;
  var5 = anglesToForward(var0.angles);
  var6 = anglesToForward(var5) * 16 + var4;
  var7 = -1 * anglesToForward(var5) * 16 + var4;
  var8 = anglestoright(var5) * 16 + var4;
  var9 = -1 * anglestoright(var5) * 16 + var4;
  var10 = sighttracepassed(self.origin, var2, 0, level.player);
  var11 = sighttracepassed(self.origin, var6, 0, level.player);
  var12 = sighttracepassed(self.origin, var7, 0, level.player);
  var13 = sighttracepassed(self.origin, var8, 0, level.player);
  var14 = sighttracepassed(self.origin, var9, 0, level.player);
  var15 = 2 * var10 + var11 + var12 + var13 + var14;

  if(var15 >= self.los_req) {
    return var15;
  }

  return 0;
}

function mg_target_actual_manager() {
  level endon("mg_ceasefire");
  scripts\engine\utility::flag_wait("mg_intro_complete");

  if(mg_get_los_score(level.player, 60)) {
    mg_target_player();
  } else {
    mg_target_other();
  }

  for(;;) {
    if(istrue(self.b_switching_targets)) {
      wait 0.1;
      continue;
    }

    if(isDefined(self.target_ent)) {
      if(self.b_player_exposed == 1) {
        self.target_actual = self.target_ent.origin;
        waitframe();
      } else {
        var0 = 3;

        if(self.target_ent == level.player) {
          var0 = 1;
        }

        var1 = 30 * var0;
        var2 = 30 * var0;
        var3 = 30 * var0;
        var4 = (randomfloatrange(-1 * var1, var1), randomfloatrange(-1 * var2, var2), randomfloatrange(-1 * var3, var3) + -20);
        mg_lerp(self.target_actual, self.target_ent.origin + var4, 1);
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

function mg_switch_targets(var0, var1, var2) {
  level endon("mg_ceasefire");
  self notify("stop_lerp");
  self.b_switching_targets = 1;
  var3 = distance(var0, var1) * 0.001 * var2;

  if(var3 == 0) {
    var3 = 0.05;
  }

  mg_lerp(var0, var1, var3);
  self.b_switching_targets = 0;
}

function mg_lerp(var0, var1, var2) {
  level endon("mg_ceasefire");
  self endon("stop_lerp");
  var3 = var1;
  var4 = 0;
  var5 = var4 / var2;
  var6 = var1 - self.target_ent.origin;

  while(var4 < var2) {
    wait 0.1;
    var4 += 0.1;
    var5 = var4 / var2;

    if(isDefined(self.target_ent)) {
      if(isDefined(var0)) {}

      if(isDefined(self.target_ent.origin)) {}

      if(isDefined(var6)) {}

      if(isDefined(var5)) {}

      self.target_actual = vectorlerp(var0, self.target_ent.origin + var6, var5);
      var3 = self.target_ent.origin;
      continue;
    }

    self.target_actual = vectorlerp(var0, var3 + var6, var5);
  }
}

function mg_shoot(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var1)) {
    magicbullet(self.weapon, self.origin, var0, var1);
  } else {
    magicbullet(self.weapon, self.origin, var0);
  }

  playFX(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self.origin, vectortoangles(self.origin - var0));

  if(!isDefined(self.tracer)) {
    self.tracer = 0;
  }

  if(self.tracer == 3) {
    thread mg_tracer(var0);
    self.tracer = 0;
    return;
  }

  self.tracer++;
}

function mg_tracer(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin(self.origin, vectortoangles(self.origin - var0));
  var1 notsolid();
  playFXOnTag(scripts\engine\utility::getfx("vfx_tracer_lmg_wheelson_w"), var1, "tag_origin");
  waitframe();
  var1.origin -= var1.origin - var0;
  waitframe();
  var1 delete();
}

function force_long_death(var0) {
  scripts\engine\sp\utility::enable_long_death();
  self.forcelongdeath = var0;
  self asmsetstate(self.asmname, "choose_long_death");
}

function player_wander_fail_manager() {
  if(!isDefined(level.wander_fail_volumes)) {
    level.wander_fail_volumes = [];
  }

  var0 = getEnt("wander_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var0);

  for(;;) {
    var1 = 0;

    foreach(var3 in level.wander_fail_volumes) {
      if(level.player istouching(var3)) {
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

function player_wander_nag_manager() {
  level endon("mission_failed");

  if(!isDefined(level.wander_nag_volumes)) {
    level.wander_nag_volumes = [];
  }

  var0 = getEnt("wander_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var0);

  for(;;) {
    level.playerinnagvolume = 0;

    foreach(var2 in level.wander_nag_volumes) {
      if(level.player istouching(var2)) {
        level.playerinnagvolume = 1;
      }
    }

    if(level.playerinnagvolume == 1) {
      setomnvar("ui_out_of_bounds_countdown", 1);
    }

    if(level.playerinnagvolume == 0) {
      setomnvar("ui_out_of_bounds_countdown", 0);
    }

    wait 0.1;
  }
}

function add_volumes_to_array() {
  scripts\engine\utility::flag_wait("convoy_speed_up");
  var0 = getEnt("IED_wander_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var0);
  var1 = getEnt("IED_wander_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var1);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_start");
  var2 = getEntArray("post_MG_wander_nag_volume", "targetname");
  var3 = getEntArray("post_MG_wander_fail_volume", "targetname");

  foreach(var5 in var2) {
    level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var5);
  }

  foreach(var5 in var3) {
    level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var5);
  }

  level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var0);
  level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var1);
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  var9 = getEntArray("retreat_nag_volume", "targetname");
  var10 = getEntArray("retreat_fail_volume", "targetname");

  foreach(var5 in var9) {
    level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var5);
  }

  foreach(var5 in var10) {
    level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var5);
  }

  foreach(var5 in var2) {
    level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var5);
  }

  foreach(var5 in var3) {
    level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var5);
  }

  scripts\engine\utility::flag_wait("flag_lobby_exiting");
  var19 = getEnt("lobby_nag_volume", "targetname");
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var19);
  var20 = getEnt("lobby_fail_volume", "targetname");
  level.wander_fail_volumes = scripts\engine\utility::array_add(level.wander_fail_volumes, var20);

  foreach(var5 in var9) {
    level.wander_nag_volumes = scripts\engine\utility::array_remove(level.wander_nag_volumes, var5);
  }

  foreach(var5 in var10) {
    level.wander_fail_volumes = scripts\engine\utility::array_remove(level.wander_fail_volumes, var5);
  }

  scripts\engine\utility::flag_wait("flag_wolf_snakecam_complete");
}

function leaving_area_dialogue_monitor() {
  level.return_to_mission_nagged = 0;

  while(!isDefined(level.playerinnagvolume)) {
    waitframe();
  }

  for(;;) {
    if(level.playerinnagvolume == 1 && level.return_to_mission_nagged == 0) {
      thread scripts\sp\maps\marines\marines_vo::vo_marines_leaving_area_nag();
      level.return_to_mission_nagged = 1;
      wait randomfloatrange(9, 10);
      level.return_to_mission_nagged = 0;
    }

    waitframe();
  }

  waitframe();
}

function transient_waittill(var0, var1, var2) {
  scripts\engine\utility::flag_wait(var0);
  thread transient_unload_load(var1, var2);
}

function marines_tripwire_monitor(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = 999999;
  var9 = undefined;

  foreach(var11 in level.tripwires.traps) {
    if(isDefined(var11.origin) && distance2dsquared(var11.origin, var0.origin) < var8) {
      var8 = distance2dsquared(var11.origin, var0.origin);
      var9 = var11;
    }
  }

  if(isDefined(var5)) {
    if(var5 == 1) {
      var9.defusehintstruct.cursor_hint_ent sethintlockplayermovement(1);
    }
  }

  thread marines_tripwire_defused_tracker(var9);
  thread marines_tripwire_detonation_tracker(var9);

  if(isDefined(var2) && isDefined(var3)) {
    var2 moveTo(var3.origin, 0.1);
    wait 0.2;
    var2 disconnectPaths();
  }

  var13 = var9 scripts\engine\utility::waittill_any_return("tripwire_defused", "tripwire_detonated");

  if(isDefined(var1)) {
    scripts\engine\utility::flag_set(var1);
  }

  if(isDefined(var2) && isDefined(var4)) {
    var2 moveTo(var4.origin, 0.1);
    wait 0.2;
    var2 connectpaths();
  }

  return var13;
}

function marines_tripwire_defused_tracker(var0) {
  self endon("tripwire_detonated");
  self.defusehintstruct waittill("trigger");

  if(isDefined(var0)) {
    scripts\engine\utility::flag_set(var0);
  }

  self notify("tripwire_defused");
}

function marines_tripwire_detonation_tracker(var0) {
  self endon("tripwire_defused");
  self waittill("trigger", var1, var2);

  if(isDefined(var0)) {
    scripts\engine\utility::flag_set(var0);
  }

  self notify("tripwire_detonated");
}

function spawn_corpses(var0, var1, var2) {
  var3 = getspawnerarray(var0);

  foreach(var5 in var3) {
    thread spawn_corpse(var5, var1, var2);
  }
}

function spawn_corpse(var0, var1, var2) {
  if(!isspawner(var0)) {
    var0 = getspawner(var0, "targetname");
  }

  if(isDefined(var2)) {
    var0 scripts\engine\sp\utility::add_spawn_function(var2);
  }

  var3 = var0 scripts\engine\sp\utility::spawn_ai();
  var3 endon("entitydeleted");
  var3.animname = "dead_body";
  var3.team = "neutral";
  var3 setCanDamage(0);
  scripts\engine\utility::delaythread(0.05, &corpse_anim_hack, var3);
  var0 scripts\common\anim::anim_single_solo(var3, var3.animation);
  var0 thread scripts\common\anim::anim_last_frame_solo(var3, var3.animation);

  if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "manpile_monitor_exempt") {
    wait 1;
    var3.forceragdollimmediate = 1;
    var3 scripts\engine\sp\utility::anim_stopanimScripted();
    var3 scripts\engine\sp\utility::set_allowdeath(1);
    var3 scripts\engine\sp\utility::die();
  }

  scripts\engine\utility::flag_wait(var1);

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function corpse_anim_hack(var0) {
  var0 setanimtime(level.scr_anim[var0.animname][var0.animation], 0.99);
}

function stairwell_corpses_cleanup() {
  scripts\engine\utility::flag_wait("flag_containment_civambush");
  var0 = getcorpsearray();
  var1 = getEnt("stairwell_corpses_info_volume", "targetname");

  foreach(var3 in var0) {
    if(ispointinvolume(var3.origin, var1)) {
      var3 delete();
    }
  }
}

function player_underbarrel_grenade_launcher_equipped_monitor() {
  level endon("underbarrel_grenade_launcher_equipped");

  for(;;) {
    level.player waittill("weapon_change");

    if(createheadicon(level.player getcurrentweapon()) == "alt_iw8_ar_mike4+back_mike4+front_mike4+hybrid_west02+mag_mike4+rec_mike4+ub_mike203_sp") {
      level notify("underbarrel_grenade_launcher_equipped");
    }
  }
}

function player_underbarrel_grenade_launcher_used_monitor() {
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

function deletables_thread() {
  thread wait_for_deletables("alex_civ_dialogue");
  thread wait_for_deletables("flag_retreat_trigger_counterattack");
  thread wait_for_deletables("hospital_doors_closed");
  thread wait_for_deletables("flag_lobby_secured");
}

function wait_for_deletables(var0) {
  scripts\engine\utility::flag_init(var0);
  scripts\engine\utility::flag_wait(var0);
  thread do_deletable_delete(var0);
}

function do_deletable_delete(var0) {
  wait 1;
  var1 = getEntArray("deletable_" + var0, "targetname");
  var2 = 0;

  foreach(var4 in var1) {
    var2++;
    var4 hide();
  }
}

function get_all_script_models_with_modelname(var0) {
  var1 = getEntArray("script_model", "classname");
  var2 = [];

  foreach(var4 in var1) {
    if(var4.model == var0) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  return var2;
}

function delete_when_offscreen(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  for(;;) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, cos(35))) {
      if(distance(level.player.origin, self.origin) > var0) {
        self hide();
        break;
      }
    }

    wait 0.25;
  }
}

function delete_all_script_models_with_modelname(var0) {
  var1 = getEntArray("script_model", "classname");

  foreach(var3 in var1) {
    if(var3.model == var0) {
      var3 hide();
    }
  }
}

function delete_all_script_models_with_modelname_async(var0) {
  var1 = getEntArray("script_model", "classname");

  foreach(var3 in var1) {
    if(var3.model == var0) {
      var3 hide();
    }

    waitframe();
  }
}

function disable_weapon_swap(var0) {
  self allowads(0);
  self disableweaponswitch();
  wait var0;
  self allowads(1);
  self enableweaponswitch();
}

function delay_poi_enable(var0, var1, var2) {
  wait var0;

  if(isDefined(self) && isalive(self)) {
    scripts\common\ai::poi_enable(var1, var2);
    return;
  }
}

function marine_room_clear_node(var0, var1, var2) {
  if(isDefined(var2)) {
    var2 disconnectnode();
  }

  scripts\engine\utility::flag_wait(var0);
  wait randomfloatrange(1, 2);
  wait 1;
  var1 disconnectnode();

  if(isDefined(var2)) {
    var2 connectnode();
  }

  var3 = get_closest_marine_no_vo(undefined, var1.origin);

  if(isDefined(var3) && isalive(var3)) {
    var4 = distance2d(var3.origin, var1.origin);

    if(var4 < 50 && isDefined(var3) && isalive(var3)) {
      var3 setgoalnode(var2);
      return;
    }

    return;
  }
}

function marines_intro_glanceback(var0, var1) {
  if(isDefined(var1)) {
    if(distance2d(level.griggs.origin, level.player.origin) < var1) {
      return;
    }
  }

  if(isDefined(var0)) {
    wait var0;
  }

  var2 = getdvarfloat("MOKSKQLLMM");
  setsaveddvar("MOKSKQLLMM", 2048);
  var3 = getaiarrayinradius(level.griggs.origin, 400, "allies");

  if(var3.size > 0) {
    var3 = scripts\engine\utility::array_randomize(var3);
    var4 = int(min(var3.size, randomint(2) + 1));

    for(var5 = 0; var5 < var3.size; var5++) {
      if(var4 <= 0) {
        break;
      }

      var6 = var3[var5];

      if(isalive(var6) && !var6 scripts\asm\asm_bb::bb_isanimScripted()) {
        var6 glanceatentity(level.player, randomintrange(800, 1200), 0);
        var4--;
        wait randomfloatrange(0.1, 0.3);
      }
    }
  }

  setsaveddvar("MOKSKQLLMM", var2);
}

function waittill_or_timeout(var0, var1) {
  self endon(var0);
  wait var1;
}

function ally_equipment_backpack(var0, var1) {
  var0 endon("death");

  if(!var0 scripts\engine\utility::ent_flag_exist("show_eq_icon")) {
    var0 scripts\engine\utility::ent_flag_init("show_eq_icon");
  }

  var0.support_equipment = 4;
  var2 = undefined;
  var3 = 0;
  var4 = undefined;
  var5 = "hud_icon_equipment_smoke";
  var2 = "smoke_full";
  var0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var0.icon_spot dontinterpolate();
  var0.icon_spot linkTo(var0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var0.model_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var0.model_spot dontinterpolate();
  var0.model_spot linkTo(var0, "j_spine4", (-5, 7, 0), (90, 0, 0));
  thread ally_equipment_backpack_icon(var0, var5);
  thread ally_equipment_backpack_interact(var0, var1, var5, var2, var4);
  thread griggs_equipment_nag_monitor();
}

function ally_equipment_backpack_interact(var0, var1, var2, var3, var4) {
  var0 notify("remove_equipment");
  var0 endon("death");

  for(;;) {
    wait 0.1;

    while(var0.support_equipment == 0 || level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
      waitframe();
    }

    var5 = scripts\engine\utility::string(var0.support_equipment);
    var0.icon_spot scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var4, 40, 200, 100, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    thread ally_equipment_remove();
    var0.icon_spot waittill("trigger");
    waitframe();

    if(var0.support_equipment == 0) {
      while(!var0.support_equipment) {
        waitframe();
      }

      continue;
    }

    var6 = level.player getammocount(getcompleteweaponname(var1));
    var7 = weaponmaxammo(var1);
    var8 = var7 - var6;
    var9 = 0;

    if(getDvar("LMMLNRSLKS") == "autobuild") {
      getentitylessscriptablearray("sp_ally_equipment", ["type", var3, "levelname", level.script, "x", level.player.origin[0], "y", level.player.origin[1], "z", level.player.origin[2], "checkpoint", level.start_point, "ally", var0.script_friendname]);
    }

    if(var6 != var7) {
      if(var8 <= var0.support_equipment) {
        var9 = var8 + var6;
        var0.support_equipment = 0;
      } else {
        var9 = var0.support_equipment + var6;
        var0.support_equipment = 0;
      }

      level.player scripts\engine\sp\utility::player_gesture_force("ges_swipe");
      wait 0.3;
      level.player playSound("mar_pickup_smoke");
      level.player playRumbleOnEntity("damage_heavy");

      if(var3 == "rpg_full") {
        level.player givemaxammo(var1);
        level.player switchtoweapon(var1);
        level.player setweaponammoclip(var1, weaponclipsize(var1));
      } else {
        level.player scripts\engine\sp\utility::give_offhand(var1, var9);
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

function ally_increase_equipment(var0) {
  while(var0.support_equipment > 0) {
    wait 0.1;
  }

  wait 3;
  var0.support_equipment = 4;
}

function ally_equipment_backpack_icon(var0, var1) {
  level.player endon("death");
  level.player.ally_equipment_force_ping = 0;
  var0 endon("death");
  var0.icon = undefined;
  var0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var0.icon_spot linkTo(var0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var0.display_equipment = 0;
  level.focus_pressed = 0;
  thread distance_notify(var0);

  for(;;) {
    display_icon_logic(var0, var1);
    wait 0.1;
  }
}

function display_icon_logic(var0, var1) {
  var0 endon("death");

  if(var0.support_equipment == 0 || level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
    return;
  }

  if(level.player.ally_equipment_force_ping || var0.display_equipment || getomnvar("ui_show_objectives")) {
    var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    waitframe();
    var0 scripts\engine\utility::ent_flag_set("show_eq_icon");
    var2 = distance(level.player.origin, var0.origin) + 15;
    var0.icon = deleteheadicon(var0.icon_spot);
    setheadiconfriendlyimage(var0.icon, var1);
    setheadiconsnaptoedges(var0.icon, 5000);
    setheadiconmaxdistance(var0.icon, 100);
    setheadicondrawthroughgeo(var0.icon, 1);
    var3 = gettime() + 4000;

    for(;;) {
      if(level.player.ally_equipment_force_ping) {
        if(gettime() > var3) {
          level.player.ally_equipment_force_ping = 0;
        }
      }

      if(var0.support_equipment == 0) {
        var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      if(!getomnvar("ui_show_objectives") && !var0.display_equipment && !level.player.ally_equipment_force_ping) {
        var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      waitframe();
    }

    var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    level.player.ally_equipment_force_ping = 0;
    level.player notify("remove_ally_icon");

    if(isDefined(var0.icon)) {
      setheadiconimage(var0.icon);
      var0.icon = undefined;
      return;
    }

    return;
  }
}

function display_icon_shutdown_logic(var0) {
  var0 endon("death");
  var0 scripts\engine\utility::ent_flag_waitopen("show_eq_icon");

  if(isDefined(var0.icon)) {
    return;
  }
}

function distance_notify(var0) {
  wait 0.5;
  var0 endon("death");
  var1 = 0.93;

  for(;;) {
    var2 = distance(level.player.origin, var0.origin);

    if(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0 && 100 > var2 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin + (0, 0, 40), var1)) {
      var0.display_equipment = 1;
      level.player notify("ally_equipment_notify");
    } else {
      var0.display_equipment = 0;
    }

    wait 0.2;
  }
}

function distance_checker(var0) {
  var1 = gettime() + 5000;

  for(;;) {
    var2 = distance(level.player.origin, var0.origin);

    if(100 < var2) {
      level.player notify("show_icon");
    }

    waitframe();
  }
}

function ally_equipment_remove() {
  self waittill("remove_equipment");
  self.icon_spot scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.support_equipment = 0;
}

function griggs_supplies_refill() {
  level.griggs.support_equipment = 4;
}

function griggs_equipment_nag_monitor() {
  level.griggs endon("remove_equipment");
  level.griggs endon("death");
  level.player endon("death");

  for(;;) {
    while(level.griggs.support_equipment == 0) {
      waitframe();
    }

    while(level.player getammocount(getcompleteweaponname("smoke_tall")) > 0) {
      waitframe();
    }

    wait 1.5;

    if(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0) {
      while(check_los_and_proximity(level.griggs, level.player) == 0) {
        waitframe();
      }

      if(level.griggs.support_equipment > 0) {
        level thread scripts\sp\maps\marines\marines_vo::vo_smoke_nag_dialogue();
        scripts\engine\sp\utility::display_hint_forced("smoke_nag", 5);
      }
    }

    while(level.player getammocount(getcompleteweaponname("smoke_tall")) == 0) {
      waitframe();
    }
  }
}

function griggs_damage_juggle_monitor() {
  while(!isDefined(level.griggs) && !isalive(level.griggs)) {
    waitframe();
  }

  level.griggs_damage_points = 0;
  var0 = 0;

  while(isDefined(level.griggs) && isalive(level.griggs)) {
    level.griggs waittill("damage");

    if(level.griggs_damage_points < 1) {
      thread griggs_damage_juggle_decay_handler();
    }

    level.griggs_damage_points++;

    if(isDefined(level.griggs) && isalive(level.griggs) && level.griggs_damage_points >= 20) {
      if(level.griggs.ignoreme == 1) {
        var0 = 1;
      } else {
        level.griggs.ignoreme = 1;
      }

      level.griggs.disablebulletwhizbyreaction = 1;
      level.griggs scripts\engine\utility::disable_pain();
      wait 6;

      if(isDefined(level.griggs) && isalive(level.griggs)) {
        if(var0 == 0 && level.griggs.ignoreme == 1) {
          level.griggs.ignoreme = 0;
        }

        level.griggs scripts\engine\utility::enable_pain();
        level.griggs.disablebulletwhizbyreaction = 0;
        level.griggs_damage_points = 0;
      }
    }
  }
}

function griggs_damage_juggle_decay_handler() {
  for(;;) {
    wait 0.5;

    if(level.griggs_damage_points > 0) {
      level.griggs_damage_points -= 1;
      continue;
    }

    break;
  }
}

function dialogue_stop() {
  self stopsounds();
}