/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_drones.gsc
**************************************/

drone_spawn() {
  var_0 = drones_request(1);

  if(var_0) {
    var_1 = maps\_utility::spawn_ai();
    var_1 thread drones_death_watcher();
    return var_1;
  }

  return undefined;
}

drones_request(var_0) {
  var_1 = spawnStruct();
  var_1.requestamount = var_0;
  level.dronequeue[level.dronequeue.size] = var_1;
  var_1 waittill("drones_granted", var_2);

  if(getdvarint("daniel"))
    iprintln("drones granted : " + var_2);

  return var_2;
}

drones_request_queue() {
  for(;;) {
    while(level.dronequeue.size == 0)
      wait 0.05;

    var_0 = level.dronequeue[0];
    drones_request_think(var_0);
    level.dronequeue = common_scripts\utility::array_remove(level.dronequeue, var_0);
  }
}

drones_request_think(var_0) {
  var_1 = var_0.requestamount;

  if(getdvarint("daniel"))
    iprintln("drones requested : " + var_1);

  var_2 = level.availabledrones - var_1;

  if(var_2 < 0) {
    var_3 = level.availabledrones;
    level.availabledrones = 0;
  } else {
    level.availabledrones = level.availabledrones - var_1;
    var_3 = var_1;
  }

  var_0 notify("drones_granted", var_3);
}

drones_death_watcher() {
  common_scripts\utility::waittill_any("death", "deleted");
  level.availabledrones++;
}

drones_request_init() {
  level.dronequeue = [];
  level.availabledrones = 35;
  thread drones_request_queue();
}

drone_move_custom(var_0) {
  self endon("death");
  self endon("drone_stop");
  wait 0.05;
  var_1 = maps\_drone::getpatharray(var_0, self.origin);
  var_2 = level.drone_anims[self.team]["stand"]["run"];

  if(isDefined(self.runanim))
    var_2 = self.runanim;

  var_3 = maps\_drone::get_anim_data(var_2);
  var_4 = var_3.run_speed;
  var_5 = var_3.anim_relative;

  if(isDefined(self.drone_move_callback)) {
    var_3 = [[self.drone_move_callback]]();

    if(isDefined(var_3)) {
      var_2 = var_3.runanim;
      var_4 = var_3.run_speed;
      var_5 = var_3.anim_relative;
    }

    var_3 = undefined;
  }

  if(!var_5)
    thread maps\_drone::drone_move_z(var_4);

  maps\_drone::drone_play_looping_anim(var_2, self.moveplaybackrate);
  var_6 = 0.5;
  var_7 = 0;
  self.started_moving = 1;
  self.cur_node = var_1[var_7];
  var_8 = 0;
  var_9 = undefined;

  for(;;) {
    if(!isDefined(var_1[var_7])) {
      break;
    }

    var_10 = var_1[var_7]["vec"];
    var_11 = self.origin - var_1[var_7]["origin"];
    var_12 = vectordot(vectornormalize(var_10), var_11);

    if(!isDefined(var_1[var_7]["dist"])) {
      break;
    }

    var_13 = level.drone_lookahead_value;

    if(isDefined(self.drone_lookahead_value))
      var_13 = self.drone_lookahead_value;

    var_14 = var_12 + var_13;

    while(var_14 > var_1[var_7]["dist"]) {
      var_14 = var_14 - var_1[var_7]["dist"];
      var_7++;
      self.cur_node = var_1[var_7];

      if(!isDefined(var_1[var_7]["dist"])) {
        self rotateto(vectortoangles(var_1[var_1.size - 1]["vec"]), var_6);
        var_15 = distance(self.origin, var_1[var_1.size - 1]["origin"]);
        var_16 = var_15 / (var_4 * self.moveplaybackrate);
        var_17 = var_1[var_1.size - 1]["origin"] + (0, 0, 100);
        var_18 = var_1[var_1.size - 1]["origin"] - (0, 0, 100);
        var_19 = physicstrace(var_17, var_18);

        if(getdvar("debug_drones") == "1") {
          thread common_scripts\utility::draw_line_for_time(var_17, var_18, 1, 1, 1, var_6);
          thread common_scripts\utility::draw_line_for_time(self.origin, var_19, 0, 0, 1, var_6);
        }

        self moveto(var_19, var_16);
        wait(var_16);
        self notify("goal");

        if(isDefined(self.cur_node["script_noteworthy"]))
          drone_traverse_check();

        if(!isDefined(self.skipdelete)) {
          cur_node_check_delete();
          thread maps\_drone::check_delete();
        }

        thread maps\_drone::drone_idle(var_1[var_1.size - 1], var_19);
        return;
      }

      if(!isDefined(var_1[var_7])) {
        self notify("goal");

        if(isDefined(self.cur_node["script_noteworthy"]))
          drone_traverse_check();

        thread maps\_drone::drone_idle();
        return;
      }
    }

    if(isDefined(self.drone_move_callback)) {
      var_3 = [
        [self.drone_move_callback]
      ]();

      if(isDefined(var_3)) {
        var_2 = var_3.runanim;

        if(var_3.runanim != var_2) {
          var_4 = var_3.run_speed;
          var_5 = var_3.anim_relative;

          if(!var_5)
            thread maps\_drone::drone_move_z(var_4);
          else
            self notify("drone_move_z");

          maps\_drone::drone_play_looping_anim(var_2, self.moveplaybackrate);
        }
      }
    }

    self.cur_node = var_1[var_7];
    var_20 = var_1[var_7]["vec"] * var_14;
    var_20 = var_20 + var_1[var_7]["origin"];
    var_21 = var_20;
    var_17 = var_21 + (0, 0, 100);
    var_18 = var_21 - (0, 0, 100);
    var_21 = physicstrace(var_17, var_18);

    if(!var_5)
      self.drone_look_ahead_point = var_21;

    if(getdvar("debug_drones") == "1") {
      thread common_scripts\utility::draw_line_for_time(var_17, var_18, 1, 1, 1, var_6);
      thread maps\_drone::draw_point(var_21, 1, 0, 0, 16, var_6);
    }

    var_22 = vectortoangles(var_21 - self.origin);
    self rotateto((0, var_22[1], 0), var_6);
    var_23 = var_4 * var_6 * self.moveplaybackrate;
    var_24 = vectornormalize(var_21 - self.origin);
    var_20 = var_24 * var_23;
    var_20 = var_20 + self.origin;

    if(getdvar("debug_drones") == "1")
      thread common_scripts\utility::draw_line_for_time(self.origin, var_20, 0, 0, 1, var_6);

    self moveto(var_20, var_6);
    wait(var_6);
  }

  if(isDefined(self.cur_node["script_noteworthy"]))
    drone_traverse_check();

  thread maps\_drone::drone_idle();
}

drone_traverse_check() {
  var_0 = self.cur_node["script_noteworthy"];
  var_1 = strtok(var_0, "_");

  if(var_1[0] != "traverse") {
    return;
  }
  var_2 = [];
  var_2["origin"] = self.cur_node["origin"];
  var_2["angles"] = (0, 180, 0);
  var_3 = level.drone_anims[self.team]["traverse"][var_0];
  drone_play_anim(var_3, var_2);
}

cur_node_check_delete() {
  if(!isDefined(self.cur_node["script_noteworthy"])) {
    return;
  }
  var_0 = self.cur_node["script_noteworthy"];

  if(var_0 == "die")
    self kill();
  else if(var_0 == "delete")
    self delete();
}

drone_set_runanim() {
  if(!isDefined(self.drone_runanim)) {
    return;
  }
  var_0 = spawnStruct();
  var_0 = maps\_drone::get_anim_data(self.drone_runanim);
  var_0.runanim = self.drone_runanim;
  return var_0;
}

drone_animate_on_path(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("drone_stop");
  var_1.dontdonotetracks = 1;

  if(!isDefined(var_0)) {
    var_2 = var_1 maps\_utility::get_linked_structs();
    var_0 = common_scripts\utility::random(var_2);
  }

  var_3 = undefined;
  var_4 = var_0;

  while(isDefined(var_4)) {
    var_3 = var_4;
    var_5 = undefined;

    if(var_4 maps\homecoming_util::parameters_check("fight")) {
      var_6 = [];
      var_6["script_noteworthy"] = var_4.script_noteworthy;
      var_6["origin"] = var_4.origin;
      var_6["angles"] = var_4.angles;
      var_1.cur_node = var_6;
      var_1 thread drone_fight_smart();
      break;
    } else if(!var_4 maps\homecoming_util::parameters_check("nomove")) {
      var_1 drone_move_custom(var_4.targetname);
      var_7 = var_1.cur_node["script_linkname"];

      if(!isDefined(var_7)) {
        return;
      }
      var_5 = common_scripts\utility::getstruct(var_7, "script_linkname");
    } else
      var_5 = var_4;

    var_3 = var_5;
    var_4 = undefined;
    var_8 = undefined;

    if(isDefined(var_5.script_animation)) {
      var_8 = var_5.script_animation;

      if(isDefined(var_5.script_linkto))
        var_4 = common_scripts\utility::getstruct(var_5.script_linkto, "script_linkname");
    } else {
      var_9 = var_5 maps\_utility::get_linked_structs();

      foreach(var_11 in var_9) {
        if(var_11 maps\homecoming_util::parameters_check("animate")) {
          var_8 = var_11.script_animation;
          var_5 = var_11;

          if(isDefined(var_11.target))
            var_4 = common_scripts\utility::getstruct(var_11.target, "targetname");

          break;
        }
      }
    }

    if(!isDefined(var_8)) {
      continue;
    }
    common_scripts\utility::waitframe();
    var_13 = getanimlength(maps\_utility::getanim_generic(var_8));
    var_5 thread maps\_anim::anim_generic(var_1, var_8);

    if(isDefined(var_5.script_timeout)) {
      wait(var_5.script_timeout);
      var_1 stopanimscripted();
      continue;
    }

    wait(var_13);
  }

  var_1.dontdonotetracks = undefined;
  var_1 struct_check_delete(var_3);
}

hovercraft_drone_fightspots() {
  var_0 = squared(128);

  for(;;) {
    wait 0.1;

    if(!isDefined(level.hovercraftdrones)) {
      continue;
    }
    var_1 = maps\_utility::array_removedead(level.hovercraftdrones);

    if(var_1.size == 0) {
      wait 0.1;
      continue;
    }

    var_2 = sortbydistance(var_1, self.origin);

    foreach(var_4 in var_2) {
      if(isDefined(var_4.hasspot))
        var_2 = common_scripts\utility::array_remove(var_2, var_4);
    }

    if(var_2.size == 0) {
      break;
    }

    var_4 = var_2[0];

    if(distance2dsquared(var_4.origin, self.origin) <= var_0) {
      var_4.hasspot = 1;
      var_4.skipdelete = 1;
      var_4 notify("drone_stop");
      var_4 notify("drone_random_death");
      var_4.drone_lookahead_value = 50;
      var_4 thread drone_move_custom(self.targetname);
      var_4.drone_idle_custom = 1;
      var_4.drone_idle_override = ::drone_fight_smart;
      var_4 waittill("death");
    }
  }
}

drone_fight_smart(var_0) {
  self endon("death");
  self endon("stop_drone_fighting");

  if(isDefined(var_0))
    self waittill("goal");

  var_1 = [];

  if(self.team == "axis")
    var_1 = ["ak12", "cz805", "cbjms"];
  else
    var_1 = ["r5rgp", "fad", "m27"];

  self.weaponsound = "drone_" + var_1[randomint(var_1.size)] + "_fire_npc";
  var_2 = self.cur_node;
  var_3 = var_2["script_noteworthy"];
  self.animset = var_3;
  var_4 = self.team;
  var_5 = randomint(2);

  for(;;) {
    if(common_scripts\utility::cointoss()) {
      var_6 = randomint(level.drone_anims[var_4][var_3]["idle"].size);
      drone_play_anim(level.drone_anims[var_4][var_3]["idle"][var_6], var_2);
    }

    drone_play_anim(level.drone_anims[var_4][var_3]["hide_2_aim"], var_2);

    if(var_3 == "coverprone")
      drone_play_anim(level.drone_anims[var_4][var_3]["fire_exposed"]);
    else
      drone_play_anim(level.drone_anims[var_4][var_3]["fire"]);

    maps\_drone::drone_fire_randomly();
    drone_play_anim(level.drone_anims[var_4][var_3]["aim_2_hide"]);
  }
}

#using_animtree("generic_human");

drone_play_anim(var_0, var_1, var_2) {
  self clearanim( % body, 0.2);
  self stopanimscripted();
  var_3 = "normal";

  if(isDefined(var_2))
    var_3 = "deathplant";

  if(isDefined(var_1)) {
    var_4 = var_1["origin"];
    var_5 = var_1["angles"];
    var_1 = spawnStruct();
    var_1.origin = var_4;
    var_1.angles = var_5;
  } else
    var_1 = self;

  var_6 = "drone_anim";
  self animscripted(var_6, var_1.origin, var_1.angles, var_0, var_3);
  self waittillmatch("drone_anim", "end");
}

drone_infinite_runners(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(!isarray(self))
    var_6 = maps\_utility::make_array(self);
  else
    var_6 = self;

  var_7 = [];

  foreach(var_9 in var_6) {
    var_10 = var_9 common_scripts\utility::get_linked_ents();

    foreach(var_12 in var_10) {
      if(var_12 maps\homecoming_util::parameters_check("starter"))
        var_7 = common_scripts\utility::array_add(var_7, var_12);
    }
  }

  maps\_utility::array_spawn(var_7);
  var_15 = [];

  while(!common_scripts\utility::flag(var_0)) {
    var_16 = undefined;

    if(isDefined(var_5)) {
      var_15 = common_scripts\utility::array_removeundefined(var_15);

      if(var_15.size >= var_5) {
        wait(randomfloatrange(var_1[0], var_1[1]));
        var_16 = 1;
      }
    }

    if(isDefined(var_16)) {
      continue;
    }
    var_17 = drones_request(1);

    if(var_17 == 0) {
      wait 0.1;
      continue;
    }

    var_9 = var_6[randomint(var_6.size)];
    var_18 = var_9 maps\_utility::spawn_ai();
    var_15 = common_scripts\utility::array_removeundefined(var_15);
    var_15 = common_scripts\utility::array_add(var_15, var_18);
    var_18 thread drone_animate_on_path();
    var_18 thread drones_death_watcher();
    var_19 = var_2[randomint(var_2.size)];
    var_18.runanim = level.drone_anims["allies"]["stand"][var_19];

    if(isDefined(var_3))
      var_18.weaponsound = var_3[randomint(var_3.size)];
    else
      var_18.nodroneweaponsound = 1;

    if(var_19 == "run_n_gun")
      var_18 thread drone_fire_randomly_loop();
    else if(var_19 == "sprint")
      var_18 maps\_utility::set_moveplaybackrate(1.4);

    if(isDefined(var_4))
      var_18 maps\_utility::delaythread(randomfloatrange(var_4[0], var_4[1]), maps\_utility::die);

    var_18 notify("move");

    if(common_scripts\utility::flag(var_0)) {
      break;
    }

    wait(randomfloatrange(var_1[0], var_1[1]));
  }
}

beach_path_drones(var_0) {
  self endon("stop_drone_runners");

  if(isDefined(var_0))
    level.drone_runner_group[var_0] = [];

  var_1 = self;
  var_2 = common_scripts\utility::getstruct(self.script_linkto, "script_linkname");
  var_3 = 2;

  if(isDefined(var_1.script_count))
    var_3 = var_1.script_count;

  if(!isDefined(self.script_wait_min)) {
    self.script_wait_min = 8;
    self.script_wait_max = 16;
  }

  var_4 = 5;
  var_5 = 9;

  if(isDefined(self.randomdeath)) {
    var_4 = self.randomdeath[0];
    var_5 = self.randomdeath[1];
  }

  for(;;) {
    var_6 = randomint(var_3);
    var_6 = var_6 + 1;
    var_6 = drones_request(var_6);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = var_1 maps\_utility::spawn_ai();

      if(isDefined(var_0)) {
        level.drone_runner_group[var_0] = common_scripts\utility::array_removeundefined(level.drone_runner_group[var_0]);
        level.drone_runner_group[var_0] = common_scripts\utility::array_add(level.drone_runner_group[var_0], var_8);
      }

      if(var_1 maps\homecoming_util::parameters_check("random_death"))
        var_8 maps\_utility::delaythread(randomfloatrange(var_4, var_5), ::drone_die);

      var_8 thread drones_death_watcher();

      if(isDefined(var_1.drone_lookahead_value))
        var_8.drone_lookahead_value = var_1.drone_lookahead_value;
      else
        var_8.drone_lookahead_value = 56;

      var_9 = [ % stand_death_tumbleback, % stand_death_headshot_slowfall, % stand_death_shoulderback];
      var_8.deathanim = var_9[randomint(var_9.size)];
      var_8 thread drone_animate_on_path(var_2);
      wait(randomfloatrange(0.6, 0.9));
    }

    var_1 maps\_utility::script_wait();
  }
}

drone_fire_randomly_loop() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(0.8, 1.2));
    thread maps\_drone::drone_fire_randomly();
  }
}

drone_fire_fake_javelin_loop(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_firing");

  if(!isDefined(level.fakejavelinfireents))
    level.fakejavelinfireents = [];

  var_5 = 4;
  var_6 = 9;

  if(isDefined(var_2)) {
    var_5 = var_2[0];
    var_6 = var_2[1];
  }

  if(!isDefined(self.javtargets))
    self.javtargets = [];

  if(isDefined(var_0))
    self.javtargets = common_scripts\utility::array_combine(self.javtargets, var_0);

  if(!isDefined(self.javelin_smarttargeting)) {
    if(isDefined(var_1) && var_1 == 1)
      self.javelin_smarttargeting = 1;
    else
      self.javelin_smarttargeting = 0;
  }

  if(isalive(self)) {
    var_7 = spawn("script_model", self.origin);
    var_7 setModel("weapon_javelin");
    var_7 linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
    self.javelin = var_7;
  }

  for(;;) {
    if(isalive(self)) {
      drone_play_anim(maps\_utility::getgenericanim("javelin_idle"));
      thread drone_play_anim(maps\_utility::getgenericanim("javelin_fire"));
    } else
      wait(randomfloatrange(var_5, var_6));

    if(self.javelin_smarttargeting == 1) {
      level.javelintargets = maps\_utility::array_removedead(level.javelintargets);
      level.javelintargets = common_scripts\utility::array_removeundefined(level.javelintargets);
      var_0 = common_scripts\utility::array_combine(self.javtargets, level.javelintargets);
    }

    if(level.javelintargets.size > 0)
      var_8 = level.javelintargets[randomint(level.javelintargets.size)];
    else {
      if(self.javtargets.size == 0) {
        return;
      }
      self.javtargets = common_scripts\utility::array_removeundefined(self.javtargets);
      var_8 = self.javtargets[randomint(self.javtargets.size)];
    }

    maps\homecoming_util::fire_fake_javelin(var_8, var_3, var_4);
  }
}

drone_javelin_smart_targeting() {}

drone_respawner(var_0, var_1) {
  var_2 = self;
  var_2.dontdonotetracks = 1;

  for(;;) {
    if(isDefined(var_1)) {
      var_3 = randomfloatrange(5, 10);
      var_2 maps\_utility::delaythread(var_3, ::drone_death_custom);
    }

    var_2 waittill("death");
    var_2 = var_0 drone_spawn();
    var_2 drone_animate_on_path();
  }
}

drone_death_custom() {
  self notify("stop_drone_fighting");

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  var_0 = ["drone_death_slowfall", "drone_death_shoulderback"];
  var_1 = common_scripts\utility::random(var_0);
  drone_gun_remove();
  self clearanim( % body, 0.2);
  maps\_utility::anim_stopanimscripted();
  maps\_anim::anim_generic(self, var_1);
  wait 0.5;

  if(isDefined(self))
    self delete();
}

default_mg_drone() {
  thread maps\_utility::magic_bullet_shield();
  maps\_utility::gun_remove();
  var_0 = getent(self.script_linkto, "script_linkname");
  self.mg = var_0;
  var_0.owner = self;
  var_0 thread maps\_anim::anim_generic_first_frame(self, "stand_gunner_idle", "tag_butt");
  self linkto(var_0, "tag_butt", (0, 5, -45), (0, 0, 0));
}

struct_check_delete(var_0) {
  if(var_0 maps\homecoming_util::parameters_check("delete"))
    maps\homecoming_util::delete_safe();
  else if(var_0 maps\homecoming_util::parameters_check("die"))
    maps\homecoming_util::kill_safe();
}

drone_death_handler(var_0) {
  if(isDefined(self.customdeathanim)) {
    return;
  }
  if(isDefined(self.deathanim))
    var_0 = self.deathanim;

  maps\_drone::drone_play_scripted_anim(var_0, "deathplant");

  if(!isDefined(self.noragdoll))
    self startragdoll();

  self notsolid();
  thread maps\_drone::drone_thermal_draw_disable(2);

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }
  if(!isDefined(level.drone_bodies))
    level.drone_bodies = 0;

  level.drone_bodies++;

  while(isDefined(self)) {
    wait 2;

    if(!isDefined(self)) {
      break;
    }

    if(drone_should_delete())
      self delete();
  }

  level.drone_bodies--;
}

drone_should_delete() {
  if(distancesquared(level.player.origin, self.origin) > 1000000)
    return 1;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, self.origin, 0.5))
    return 1;

  if(level.drone_bodies > 5)
    return 1;

  return 0;
}

drone_gun_remove() {
  var_0 = getweaponmodel(self.weapon);
  self detach(var_0, "tag_weapon_right");
  self.weapon = "none";
}

drone_die(var_0) {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield == 1)
    maps\_utility::stop_magic_bullet_shield();

  if(!isDefined(self.dronebloodfx)) {
    maps\_utility::die();
    return;
  }

  var_1 = ["j_shoulder_ri", "j_shoulder_le", "j_head"];
  var_2 = var_1[randomint(var_1.size)];
  playFX(common_scripts\utility::getfx("body_impact1"), self gettagorigin(var_2));
  maps\_utility::die();
}

drone_bloodfx(var_0) {
  self.dronebloodfx = 1;

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = ["body_impact1", "body_impact2"];

  while(isDefined(self) && isalive(self)) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(var_0) {
      if(var_3 != level.player)
        continue;
    }

    var_7 = var_1[randomint(var_1.size)];
    playFX(common_scripts\utility::getfx(var_7), var_5);
  }
}

drone_removename() {
  self.name = "";
  self setlookattext("", & "");
}

isdrone() {
  if(isDefined(self.script_drone) && self.script_drone == 1)
    return 1;

  return 0;
}

set_noragdoll() {
  self.noragdoll = 1;
}

drone_enableaimassist() {
  self enableaimassist();
}

give_drone_deathanim() {
  var_0 = [ % stand_death_tumbleback, % stand_death_headshot_slowfall, % stand_death_shoulderback];
  self.deathanim = var_0[randomint(var_0.size)];
}

drone_setname(var_0) {
  self.name = var_0;
  self setlookattext(var_0, & "");
}