/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_drone.gsc
*****************************************************/

initglobals() {
  if(getDvar("debug_drones") == "")
    setDvar("debug_drones", "0");

  if(!isDefined(level.lookahead_value))
    level.drone_lookahead_value = 200;

  if(!isDefined(level.max_drones))
    level.max_drones = [];

  if(!isDefined(level.max_drones["allies"]))
    level.max_drones["allies"] = 99999;

  if(!isDefined(level.max_drones["axis"]))
    level.max_drones["axis"] = 99999;

  if(!isDefined(level.max_drones["team3"]))
    level.max_drones["team3"] = 99999;

  if(!isDefined(level.max_drones["neutral"]))
    level.max_drones["neutral"] = 99999;

  if(!isDefined(level.drones))
    level.drones = [];

  if(!isDefined(level.drones["allies"]))
    level.drones["allies"] = maps\_utility::struct_arrayspawn();

  if(!isDefined(level.drones["axis"]))
    level.drones["axis"] = maps\_utility::struct_arrayspawn();

  if(!isDefined(level.drones["team3"]))
    level.drones["team3"] = maps\_utility::struct_arrayspawn();

  if(!isDefined(level.drones["neutral"]))
    level.drones["neutral"] = maps\_utility::struct_arrayspawn();

  level.drone_spawn_func = ::drone_init;
}

drone_init() {
  if(level.drones[self.team].array.size >= level.max_drones[self.team]) {
    self delete();
    return;
  }

  thread drone_array_handling(self);
  level notify("new_drone");
  self setCanDamage(1);
  maps\_drone_base::drone_give_soul();

  if(isDefined(self.script_drone_override)) {
    return;
  }
  thread drone_death_thread();

  if(isDefined(self.target)) {
    if(!isDefined(self.script_moveoverride))
      thread drone_move();
    else
      thread drone_wait_move();
  }

  if(isDefined(self.script_looping) && self.script_looping == 0) {
    return;
  }
  thread drone_idle();
}

drone_array_handling(var_0) {
  maps\_utility::structarray_add(level.drones[var_0.team], var_0);
  var_1 = var_0.team;
  var_0 waittill("death");

  if(isDefined(var_0) && isDefined(var_0.struct_array_index))
    maps\_utility::structarray_remove_index(level.drones[var_1], var_0.struct_array_index);
  else
    maps\_utility::structarray_remove_undefined(level.drones[var_1]);
}

drone_death_thread() {
  drone_wait_for_death();

  if(!isDefined(self)) {
    return;
  }
  var_0 = "stand";

  if(isDefined(self.animset) && isDefined(level.drone_anims[self.team][self.animset]) && isDefined(level.drone_anims[self.team][self.animset]["death"]))
    var_0 = self.animset;

  var_1 = level.drone_anims[self.team][var_0]["death"];

  if(isDefined(self.deathanim))
    var_1 = self.deathanim;

  self notify("death");

  if(isDefined(level.drone_death_handler)) {
    self thread[[level.drone_death_handler]](var_1);
    return;
  }

  if(!(isDefined(self.noragdoll) && isDefined(self.skipdeathanim))) {
    if(isDefined(self.noragdoll))
      drone_play_scripted_anim(var_1, "deathplant");
    else if(isDefined(self.skipdeathanim)) {
      self startragdoll();
      drone_play_scripted_anim(var_1, "deathplant");
    } else {
      drone_play_scripted_anim(var_1, "deathplant");
      self startragdoll();
    }
  }

  self notsolid();
  thread drone_thermal_draw_disable(2);

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }
  wait 10;

  while(isDefined(self)) {
    if(!common_scripts\utility::within_fov(level.player.origin, level.player.angles, self.origin, 0.5))
      self delete();

    wait 5;
  }
}

drone_wait_for_death() {
  self endon("death");

  while(isDefined(self)) {
    self waittill("damage");

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }
  }
}

drone_thermal_draw_disable(var_0) {
  wait(var_0);

  if(isDefined(self))
    self thermaldrawdisable();
}

#using_animtree("generic_human");

drone_play_looping_anim(var_0, var_1) {
  if(isDefined(self.drone_loop_custom))
    self[[self.drone_loop_override]](var_0, var_1);
  else {
    self clearanim(%body, 0.2);
    self stopanimscripted();
    self setflaggedanimknoballrestart("drone_anim", var_0, %body, 1, 0.2, var_1);
    self.droneanim = var_0;
  }
}

drone_play_scripted_anim(var_0, var_1) {
  if(self.type == "human")
    self clearanim(%body, 0.2);

  self stopanimscripted();
  var_2 = "normal";

  if(isDefined(var_1))
    var_2 = "deathplant";

  var_3 = "drone_anim";
  self animscripted(var_3, self.origin, self.angles, var_0, var_2);
  self waittillmatch("drone_anim", "end");
}

drone_drop_real_weapon_on_death() {
  if(!isDefined(self)) {
    return;
  }
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  var_0 = getweaponmodel(self.weapon);
  var_1 = self.weapon;

  if(isDefined(var_0)) {
    self detach(var_0, "tag_weapon_right");
    var_2 = self gettagorigin("tag_weapon_right");
    var_3 = self gettagangles("tag_weapon_right");
    var_4 = spawn("weapon_" + var_1, (0, 0, 0));
    var_4.angles = var_3;
    var_4.origin = var_2;
  }
}

drone_idle(var_0, var_1) {
  if(isDefined(self.drone_idle_custom))
    [[self.drone_idle_override]]();
  else if(isDefined(var_0) && isDefined(var_0["script_noteworthy"]) && isDefined(level.drone_anims[self.team][var_0["script_noteworthy"]]))
    thread drone_fight(var_0["script_noteworthy"], var_0, var_1);
  else {
    if(isDefined(self.idleanim)) {
      drone_play_looping_anim(self.idleanim, 1);
      return;
    }

    drone_play_looping_anim(level.drone_anims[self.team]["stand"]["idle"], 1);
  }
}

drone_get_goal_loc_with_arrival(var_0, var_1) {
  var_2 = var_1["script_noteworthy"];

  if(!isDefined(level.drone_anims[self.team][var_2]["arrival"]))
    return var_0;

  var_3 = getmovedelta(level.drone_anims[self.team][var_2]["arrival"], 0, 1);
  var_3 = length(var_3);
  var_0 = var_0 - var_3;
  return var_0;
}

drone_fight(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_drone_fighting");
  self.animset = var_0;
  self.weaponsound = undefined;
  var_3 = randomintrange(1, 4);

  if(self.team == "axis") {
    if(var_3 == 1)
      self.weaponsound = "drone_ak12_fire_npc";
    else if(var_3 == 2)
      self.weaponsound = "drone_cz805_fire_npc";

    if(var_3 == 3)
      self.weaponsound = "drone_cbjms_fire_npc";
  } else {
    if(var_3 == 1)
      self.weaponsound = "drone_r5rgp_fire_npc";
    else if(var_3 == 2)
      self.weaponsound = "drone_fad_fire_npc";

    if(var_3 == 3)
      self.weaponsound = "drone_m27_fire_npc";
  }

  self.angles = (0, self.angles[1], self.angles[2]);

  if(var_0 == "coverprone")
    self moveto(self.origin + (0, 0, 8), 0.05);

  self.noragdoll = 1;
  var_4 = level.drone_anims[self.team][var_0];
  self.deathanim = var_4["death"];

  while(isDefined(self)) {
    drone_play_scripted_anim(var_4["idle"][randomint(var_4["idle"].size)]);

    if(common_scripts\utility::cointoss() && !isDefined(self.ignoreall)) {
      var_5 = 1;

      if(isDefined(var_4["pop_up_chance"]))
        var_5 = var_4["pop_up_chance"];

      var_5 = var_5 * 100;
      var_6 = 1;

      if(randomfloat(100) > var_5)
        var_6 = 0;

      if(var_6 == 1) {
        drone_play_scripted_anim(var_4["hide_2_aim"]);
        wait(getanimlength(var_4["hide_2_aim"]) - 0.5);
      }

      if(isDefined(var_4["fire"])) {
        if(var_0 == "coverprone" && var_6 == 1)
          thread drone_play_looping_anim(var_4["fire_exposed"], 1);
        else
          thread drone_play_looping_anim(var_4["fire"], 1);

        drone_fire_randomly();
      } else {
        drone_shoot();
        wait 0.15;
        drone_shoot();
        wait 0.15;
        drone_shoot();
        wait 0.15;
        drone_shoot();
      }

      if(var_6 == 1)
        drone_play_scripted_anim(var_4["aim_2_hide"]);

      drone_play_scripted_anim(var_4["reload"]);
    }
  }
}

drone_fire_randomly() {
  self endon("death");

  if(common_scripts\utility::cointoss()) {
    drone_shoot();
    wait 0.1;
    drone_shoot();
    wait 0.1;
    drone_shoot();

    if(common_scripts\utility::cointoss()) {
      wait 0.1;
      drone_shoot();
    }

    if(common_scripts\utility::cointoss()) {
      wait 0.1;
      drone_shoot();
      wait 0.1;
      drone_shoot();
      wait 0.1;
    }

    if(common_scripts\utility::cointoss())
      wait(randomfloatrange(1, 2));
  } else {
    drone_shoot();
    wait(randomfloatrange(0.25, 0.75));
    drone_shoot();
    wait(randomfloatrange(0.15, 0.75));
    drone_shoot();
    wait(randomfloatrange(0.15, 0.75));
    drone_shoot();
    wait(randomfloatrange(0.15, 0.75));
  }
}

drone_shoot() {
  self endon("death");
  self notify("firing");
  self endon("firing");
  drone_shoot_fx();
  var_0 = % exposed_crouch_shoot_auto_v2;
  self setanimknobrestart(var_0, 1, 0.2, 1.0);
  common_scripts\utility::delaycall(0.25, ::clearanim, var_0, 0);
}

drone_shoot_fx() {
  var_0 = common_scripts\utility::getfx("ak47_muzzleflash");

  if(self.team == "allies")
    var_0 = common_scripts\utility::getfx("m16_muzzleflash");

  if(isDefined(self.muzzleflashoverride))
    var_0 = common_scripts\utility::getfx(self.muzzleflashoverride);

  if(!isDefined(self.nodroneweaponsound))
    thread drone_play_weapon_sound(self.weaponsound);

  playFXOnTag(var_0, self, "tag_flash");
}

drone_play_weapon_sound(var_0) {
  self playSound(var_0);
}

drone_wait_move() {
  self endon("death");
  self waittill("move");
  thread drone_move();
}

get_anim_data(var_0) {
  var_1 = 170;
  var_2 = 1;
  var_3 = getanimlength(var_0);
  var_4 = getmovedelta(var_0, 0, 1);
  var_5 = length(var_4);

  if(var_3 > 0 && var_5 > 0) {
    var_1 = var_5 / var_3;
    var_2 = 0;
  }

  if(isDefined(self.drone_run_speed))
    var_1 = self.drone_run_speed;

  var_6 = spawnStruct();
  var_6.anim_relative = var_2;
  var_6.run_speed = var_1;
  var_6.anim_time = var_3;
  return var_6;
}

drone_move() {
  self endon("death");
  self endon("drone_stop");
  wait 0.05;
  var_0 = getpatharray(self.target, self.origin);
  var_1 = level.drone_anims[self.team]["stand"]["run"];

  if(isDefined(self.runanim))
    var_1 = self.runanim;

  var_2 = get_anim_data(var_1);
  var_3 = var_2.run_speed;
  var_4 = var_2.anim_relative;

  if(isDefined(self.drone_move_callback)) {
    var_2 = [[self.drone_move_callback]]();

    if(isDefined(var_2)) {
      var_1 = var_2.runanim;
      var_3 = var_2.run_speed;
      var_4 = var_2.anim_relative;
    }

    var_2 = undefined;
  }

  if(!var_4)
    thread drone_move_z(var_3);

  drone_play_looping_anim(var_1, self.moveplaybackrate);
  var_5 = 0.5;
  var_6 = 0;
  self.started_moving = 1;
  self.cur_node = var_0[var_6];
  var_7 = 0;
  var_8 = undefined;

  for(;;) {
    if(!isDefined(var_0[var_6])) {
      break;
    }

    var_9 = var_0[var_6]["vec"];
    var_10 = self.origin - var_0[var_6]["origin"];
    var_11 = vectordot(vectornormalize(var_9), var_10);

    if(!isDefined(var_0[var_6]["dist"])) {
      break;
    }

    var_12 = var_11 + level.drone_lookahead_value;

    while(var_12 > var_0[var_6]["dist"]) {
      var_12 = var_12 - var_0[var_6]["dist"];
      var_6++;
      self.cur_node = var_0[var_6];

      if(isDefined(var_8)) {
        if(var_6 == 0) {}

        if(!isDefined(self.beforestairanim))
          self.beforestairanim = self.droneanim;

        var_13 = level.drone_anims[self.team]["stairs"][var_8];
        drone_play_looping_anim(var_13, self.moveplaybackrate);
        var_7 = 1;
      }

      if(!isDefined(var_0[var_6]["dist"])) {
        self rotateto(vectortoangles(var_0[var_0.size - 1]["vec"]), var_5);
        var_14 = distance(self.origin, var_0[var_0.size - 1]["origin"]);
        var_15 = var_14 / (var_3 * self.moveplaybackrate);
        var_16 = var_0[var_0.size - 1]["origin"] + (0, 0, 100);
        var_17 = var_0[var_0.size - 1]["origin"] - (0, 0, 100);
        var_18 = physicstrace(var_16, var_17);

        if(getDvar("debug_drones") == "1") {
          thread common_scripts\utility::draw_line_for_time(var_16, var_17, 1, 1, 1, var_5);
          thread common_scripts\utility::draw_line_for_time(self.origin, var_18, 0, 0, 1, var_5);
        }

        self moveto(var_18, var_15);
        wait(var_15);
        self notify("goal");
        thread check_delete();
        thread drone_idle(var_0[var_0.size - 1], var_18);
        return;
      }

      if(!isDefined(var_0[var_6])) {
        self notify("goal");
        thread drone_idle();
        return;
      }
    }

    if(isDefined(self.drone_move_callback)) {
      var_2 = [[self.drone_move_callback]]();

      if(isDefined(var_2)) {
        if(var_2.runanim != var_1) {
          var_1 = var_2.runanim;
          var_3 = var_2.run_speed;
          var_4 = var_2.anim_relative;

          if(!var_4)
            thread drone_move_z(var_3);
          else
            self notify("drone_move_z");

          drone_play_looping_anim(var_1, self.moveplaybackrate);
        }
      }
    }

    self.cur_node = var_0[var_6];
    var_19 = var_0[var_6]["vec"] * var_12;
    var_19 = var_19 + var_0[var_6]["origin"];
    var_20 = var_19;
    var_16 = var_20 + (0, 0, 100);
    var_17 = var_20 - (0, 0, 100);
    var_20 = physicstrace(var_16, var_17);

    if(!var_4)
      self.drone_look_ahead_point = var_20;

    if(getDvar("debug_drones") == "1") {
      thread common_scripts\utility::draw_line_for_time(var_16, var_17, 1, 1, 1, var_5);
      thread draw_point(var_20, 1, 0, 0, 16, var_5);
    }

    var_21 = vectortoangles(var_20 - self.origin);
    self rotateto((0, var_21[1], 0), var_5);
    var_22 = var_3 * var_5 * self.moveplaybackrate;
    var_23 = vectornormalize(var_20 - self.origin);
    var_19 = var_23 * var_22;
    var_19 = var_19 + self.origin;

    if(getDvar("debug_drones") == "1")
      thread common_scripts\utility::draw_line_for_time(self.origin, var_19, 0, 0, 1, var_5);

    self moveto(var_19, var_5);
    wait(var_5);

    if(isDefined(self.cur_node["script_noteworthy"]) && (self.cur_node["script_noteworthy"] == "stairs_start_up" || self.cur_node["script_noteworthy"] == "stairs_start_down")) {
      var_24 = strtok(self.cur_node["script_noteworthy"], "_");
      var_8 = var_24[2];
      continue;
    }

    if(var_7 == 1) {
      if(isDefined(self.cur_node["script_noteworthy"]) && self.cur_node["script_noteworthy"] == "stairs_end") {
        var_25 = self.beforestairanim;
        drone_play_looping_anim(var_25, self.moveplaybackrate);
        var_7 = 0;
        var_8 = undefined;
      }
    }
  }

  thread drone_idle();
}

drone_move_z(var_0) {
  self endon("death");
  self endon("drone_stop");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;

  for(;;) {
    if(isDefined(self.drone_look_ahead_point) && var_0 > 0) {
      var_2 = self.drone_look_ahead_point[2] - self.origin[2];
      var_3 = distance2d(self.drone_look_ahead_point, self.origin);
      var_4 = var_3 / var_0;

      if(var_4 > 0 && var_2 != 0) {
        var_5 = abs(var_2) / var_4;
        var_6 = var_5 * var_1;

        if(var_2 >= var_5)
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_6);
        else if(var_2 <= var_5 * -1)
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_6);
      }
    }

    wait(var_1);
  }
}

getpatharray(var_0, var_1) {
  var_2 = 1;
  var_3 = [];
  var_3[0]["origin"] = var_1;
  var_3[0]["dist"] = 0;
  var_4 = undefined;
  var_4 = var_0;
  var_5["entity"] = maps\_spawner::get_target_ents;
  var_5["node"] = maps\_spawner::get_target_nodes;
  var_5["struct"] = maps\_spawner::get_target_structs;
  var_6 = undefined;
  var_7 = [[var_5["entity"]]](var_4);
  var_8 = [[var_5["node"]]](var_4);
  var_9 = [[var_5["struct"]]](var_4);

  if(var_7.size)
    var_6 = "entity";
  else if(var_8.size)
    var_6 = "node";
  else if(var_9.size)
    var_6 = "struct";

  for(;;) {
    var_10 = var_3.size;
    var_11 = [[var_5[var_6]]](var_4);
    var_12 = common_scripts\utility::random(var_11);
    var_13 = var_12.origin;

    if(isDefined(var_12.radius)) {
      if(!isDefined(self.dronerunoffset))
        self.dronerunoffset = -1 + randomfloat(2);

      if(!isDefined(var_12.angles))
        var_12.angles = (0, 0, 0);

      var_14 = anglesToForward(var_12.angles);
      var_15 = anglestoright(var_12.angles);
      var_16 = anglestoup(var_12.angles);
      var_17 = (0, self.dronerunoffset * var_12.radius, 0);
      var_13 = var_13 + var_14 * var_17[0];
      var_13 = var_13 + var_15 * var_17[1];
      var_13 = var_13 + var_16 * var_17[2];
    }

    var_3[var_10]["origin"] = var_13;
    var_3[var_10]["target"] = var_12.target;

    if(isDefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isDefined(var_12.angles))
      var_3[var_10]["angles"] = var_12.angles;

    if(isDefined(var_12.script_noteworthy))
      var_3[var_10]["script_noteworthy"] = var_12.script_noteworthy;

    if(isDefined(var_12.script_linkname))
      var_3[var_10]["script_linkname"] = var_12.script_linkname;

    var_3[var_10 - 1]["dist"] = distance(var_3[var_10]["origin"], var_3[var_10 - 1]["origin"]);
    var_3[var_10 - 1]["vec"] = vectornormalize(var_3[var_10]["origin"] - var_3[var_10 - 1]["origin"]);

    if(!isDefined(var_3[var_10 - 1]["target"]))
      var_3[var_10 - 1]["target"] = var_12.targetname;

    if(!isDefined(var_3[var_10 - 1]["script_noteworthy"]) && isDefined(var_12.script_noteworthy))
      var_3[var_10 - 1]["script_noteworthy"] = var_12.script_noteworthy;

    if(!isDefined(var_3[var_10 - 1]["script_linkname"]) && isDefined(var_12.script_linkname))
      var_3[var_10 - 1]["script_linkname"] = var_12.script_linkname;

    if(!isDefined(var_12.target)) {
      break;
    }

    var_4 = var_12.target;
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "use_last_node_angles" && isDefined(var_3[var_10]["angles"]))
    var_3[var_10]["vec"] = anglesToForward(var_3[var_10]["angles"]);
  else
    var_3[var_10]["vec"] = var_3[var_10 - 1]["vec"];

  var_12 = undefined;
  return var_3;
}

draw_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + (var_4, 0, 0);
  var_7 = var_0 - (var_4, 0, 0);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, var_4, 0);
  var_7 = var_0 - (0, var_4, 0);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
  var_6 = var_0 + (0, 0, var_4);
  var_7 = var_0 - (0, 0, var_4);
  thread common_scripts\utility::draw_line_for_time(var_6, var_7, var_1, var_2, var_3, var_5);
}

check_delete() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self.magic_bullet_shield))
        maps\_utility::stop_magic_bullet_shield();

      self delete();
      break;
    case "die_on_goal":
      self kill();
      break;
  }
}