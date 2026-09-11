/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\drone.gsc
***********************************************/

function initglobals() {
  if(getDvar("debug_drones") == "") {
    setDvar("debug_drones", "0");
  }

  if(!isDefined(level.lookahead_value)) {
    level.drone_lookahead_value = 200;
  }

  if(!isDefined(level.max_drones)) {
    level.max_drones = [];
  }

  if(!isDefined(level.max_drones["allies"])) {
    level.max_drones["allies"] = 99999;
  }

  if(!isDefined(level.max_drones["axis"])) {
    level.max_drones["axis"] = 99999;
  }

  if(!isDefined(level.max_drones["team3"])) {
    level.max_drones["team3"] = 99999;
  }

  if(!isDefined(level.max_drones["neutral"])) {
    level.max_drones["neutral"] = 99999;
  }

  if(!isDefined(level.drones)) {
    level.drones = [];
  }

  if(!isDefined(level.drones["allies"])) {
    level.drones["allies"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.drones["axis"])) {
    level.drones["axis"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.drones["team3"])) {
    level.drones["team3"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.drones["neutral"])) {
    level.drones["neutral"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  level.g_effect["drone_flesh_impact"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level.drone_spawn_func = &drone_init;
}

function drone_init() {
  if(level.drones[self.team].array.size >= level.max_drones[self.team]) {
    self delete();
    return;
  }

  thread drone_array_handling(self);
  level notify("new_drone");
  self setCanDamage(1);
  scripts\sp\drone_base::drone_give_soul();

  if(isDefined(self.script_drone_override)) {
    return;
  }

  thread drone_death_thread();

  if(isDefined(self.target)) {
    if(!isDefined(self.script_moveoverride)) {
      thread drone_move();
    } else {
      thread drone_wait_move();
    }
  }

  if(isDefined(self.script_looping) && self.script_looping == 0) {
    return;
  }

  thread drone_idle();
}

function drone_array_handling(var0) {
  scripts\engine\sp\utility::structarray_add(level.drones[var0.team], var0);
  var1 = var0.team;
  var0 waittill("death");

  if(isDefined(var0) && isDefined(var0.struct_array_index)) {
    scripts\engine\sp\utility::structarray_remove_index(level.drones[var1], var0.struct_array_index);
    return;
  }

  scripts\engine\sp\utility::structarray_remove_undefined(level.drones[var1]);
}

function drone_death_thread() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var5, var5, var5, var6);

    if(!isDefined(self)) {
      return;
    }

    playFX(level.g_effect["drone_flesh_impact"], var3, var2);

    if(isDefined(self.script_allowdeath) && !self.script_allowdeath) {
      continue;
    }

    var7 = "stand";

    if(isDefined(self.animset) && isDefined(level.drone_anims[self.team][self.animset]) && isDefined(level.drone_anims[self.team][self.animset]["death"])) {
      var7 = self.animset;
    }

    var8 = level.drone_anims[self.team][var7]["death"];

    if(isDefined(self.deathanim)) {
      var8 = self.deathanim;
    }

    self notify("death", var1, var4, var6);

    if(isDefined(level.drone_death_handler)) {
      self thread[[level.drone_death_handler]](var8);
      return;
    }

    if(isDefined(self.noragdoll)) {
      drone_play_scripted_anim(var8, "deathplant");
    } else if(isDefined(self.skipdeathanim)) {
      self startragdoll();
    } else {
      drone_play_scripted_anim(var8, "deathplant");
      self startragdoll();
    }

    self notsolid();
    thread drone_thermal_draw_disable(2);

    if(isDefined(self) && isDefined(self.nocorpsedelete)) {
      return;
    }

    wait 10;

    while(isDefined(self)) {
      if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, 0.5)) {
        self delete();
      }

      wait 5;
    }

    return;
  }
}

function drone_thermal_draw_disable(var0) {
  wait var0;

  if(isDefined(self)) {
    self thermaldrawdisable();
    return;
  }
}

#using_animtree("");

function drone_play_looping_anim(var0, var1) {
  if(isDefined(self.drone_loop_custom)) {
    self[[self.drone_loop_override]](var0, var1);
    return;
  }

  self clearanim(%body, 0.2);
  self stopanimScripted();
  self setflaggedanimknoballrestart("drone_anim", var0, $body, 1, 0.2, var1);
  self.droneanim = var0;
}

function drone_play_scripted_anim(var0, var1) {
  if(self.type == "human") {
    self clearanim(%body, 0.2);
  }

  self stopanimScripted();
  var2 = "normal";

  if(isDefined(var1)) {
    var2 = "deathplant";
  }

  var3 = "drone_anim";
  self animScripted(var3, self.origin, self.angles, var0, var2);
  self waittillmatch("drone_anim", "end");
}

function drone_drop_real_weapon_on_death() {
  if(!isDefined(self)) {
    return;
  }

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  var0 = getweaponmodel(self.weapon);
  var1 = self.weapon;

  if(isDefined(var0)) {
    self detach(var0, "tag_weapon_right");
    var2 = self gettagorigin("tag_weapon_right");
    var3 = self gettagangles("tag_weapon_right");
    var4 = spawn("weapon_" + var1, (0, 0, 0));
    var4.angles = var3;
    var4.origin = var2;
    return;
  }
}

function drone_idle(var0, var1) {
  if(isDefined(self.drone_idle_custom)) {
    [[self.drone_idle_override]]();
    return;
  }

  if(isDefined(var0) && isDefined(var0["script_noteworthy"]) && isDefined(level.drone_anims[self.team][var0["script_noteworthy"]])) {
    thread drone_fight(var0["script_noteworthy"], var0, var1);
    return;
  }

  if(isDefined(self.idleanim)) {
    drone_play_looping_anim(self.idleanim, 1);
    return;
  }

  drone_play_looping_anim(level.drone_anims[self.team]["stand"]["idle"], 1);
}

function drone_get_goal_loc_with_arrival(var0, var1) {
  var2 = var1["script_noteworthy"];

  if(!isDefined(level.drone_anims[self.team][var2]["arrival"])) {
    return var0;
  }

  var3 = getmovedelta(level.drone_anims[self.team][var2]["arrival"], 0, 1);
  var3 = length(var3);
  var0 -= var3;
  return var0;
}

function drone_fight(var0, var1, var2) {
  self endon("death");
  self endon("stop_drone_fighting");
  self.animset = var0;
  self.weaponsound = undefined;
  var3 = randomintrange(1, 4);

  if(self.team == "axis") {
    if(var3 == 1) {
      self.weaponsound = "drone_ak12_fire_npc";
    } else if(var3 == 2) {
      self.weaponsound = "drone_cz805_fire_npc";
    }

    if(var3 == 3) {
      self.weaponsound = "drone_cbjms_fire_npc";
    }
  } else {
    if(var3 == 1) {
      self.weaponsound = "drone_r5rgp_fire_npc";
    } else if(var3 == 2) {
      self.weaponsound = "drone_fad_fire_npc";
    }

    if(var3 == 3) {
      self.weaponsound = "drone_m27_fire_npc";
    }
  }

  self.angles = (0, self.angles[1], self.angles[2]);

  if(var0 == "coverprone") {
    self moveTo(self.origin + (0, 0, 8), 0.05);
  }

  self.noragdoll = 1;
  var4 = level.drone_anims[self.team][var0];
  self.deathanim = var4["death"];

  while(isDefined(self)) {
    drone_play_scripted_anim(var4["idle"][randomint(var4["idle"].size)]);

    if(scripts\engine\utility::cointoss() && !isDefined(self.ignoreall)) {
      var5 = 1;

      if(isDefined(var4["pop_up_chance"])) {
        var5 = var4["pop_up_chance"];
      }

      var5 *= 100;
      var6 = 1;

      if(randomfloat(100) > var5) {
        var6 = 0;
      }

      if(var6 == 1) {
        drone_play_scripted_anim(var4["hide_2_aim"]);
        wait getanimlength(var4["hide_2_aim"]) - 0.5;
      }

      if(isDefined(var4["fire"])) {
        if(var0 == "coverprone" && var6 == 1) {
          thread drone_play_looping_anim(var4["fire_exposed"], 1);
        } else {
          thread drone_play_looping_anim(var4["fire"], 1);
        }

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

      if(var6 == 1) {
        drone_play_scripted_anim(var4["aim_2_hide"]);
      }

      drone_play_scripted_anim(var4["reload"]);
    }
  }
}

function drone_fire_randomly() {
  self endon("death");

  if(scripts\engine\utility::cointoss()) {
    drone_shoot();
    wait 0.1;
    drone_shoot();
    wait 0.1;
    drone_shoot();

    if(scripts\engine\utility::cointoss()) {
      wait 0.1;
      drone_shoot();
    }

    if(scripts\engine\utility::cointoss()) {
      wait 0.1;
      drone_shoot();
      wait 0.1;
      drone_shoot();
      wait 0.1;
    }

    if(scripts\engine\utility::cointoss()) {
      wait randomfloatrange(1, 2);
      return;
    }

    return;
  }

  drone_shoot();
  wait randomfloatrange(0.25, 0.75);
  drone_shoot();
  wait randomfloatrange(0.15, 0.75);
  drone_shoot();
  wait randomfloatrange(0.15, 0.75);
  drone_shoot();
  wait randomfloatrange(0.15, 0.75);
}

function drone_shoot() {
  self endon("death");
  self notify("firing");
  self endon("firing");
  drone_shoot_fx();
  var0 = % exposed_crouch_shoot_auto_v2;
  self setanimknobrestart(var0, 1, 0.2, 1);
  scripts\engine\utility::delaycall(0.25, &clearanim, var0, 0);
}

function drone_shoot_fx() {
  var0 = scripts\engine\utility::getfx("ak47_muzzleflash");

  if(self.team == "allies") {
    var0 = scripts\engine\utility::getfx("m16_muzzleflash");
  }

  if(isDefined(self.muzzleflashoverride)) {
    var0 = scripts\engine\utility::getfx(self.muzzleflashoverride);
  }

  if(!isDefined(self.nodroneweaponsound)) {
    thread drone_play_weapon_sound(self.weaponsound);
  }

  playFXOnTag(var0, self, "tag_flash");
}

function drone_play_weapon_sound(var0) {
  self playSound(var0);
}

function drone_wait_move() {
  self endon("death");
  self waittill("move");
  thread drone_move();
}

function get_anim_data(var0) {
  var1 = 170;
  var2 = 1;
  var3 = getanimlength(var0);
  var4 = getmovedelta(var0, 0, 1);
  var5 = length(var4);

  if(var3 > 0 && var5 > 0) {
    var1 = var5 / var3;
    var2 = 0;
  }

  if(isDefined(self.drone_run_speed)) {
    var1 = self.drone_run_speed;
  }

  var6 = spawnStruct();
  var6.anim_relative = var2;
  var6.run_speed = var1;
  var6.anim_time = var3;
  return var6;
}

function drone_move() {
  self endon("death");
  self endon("drone_stop");
  wait 0.05;
  var0 = getpatharray(self.target, self.origin);
  var1 = level.drone_anims[self.team]["stand"]["run"];

  if(isDefined(self.runanim)) {
    var1 = self.runanim;
  }

  var2 = get_anim_data(var1);
  var3 = var2.run_speed;
  var4 = var2.anim_relative;

  if(isDefined(self.drone_move_callback)) {
    var2 = [[self.drone_move_callback]]();

    if(isDefined(var2)) {
      var1 = var2.runanim;
      var3 = var2.run_speed;
      var4 = var2.anim_relative;
    }

    var2 = undefined;
  }

  if(!var4) {
    thread drone_move_z(var3);
  }

  drone_play_looping_anim(var1, self.moveplaybackrate);
  var5 = 0.5;
  var6 = 0;
  self.started_moving = 1;
  self.cur_node = var0[var6];
  var7 = 0;
  var8 = undefined;

  for(;;) {
    if(!isDefined(var0[var6])) {
      break;
    }

    var9 = var0[var6]["vec"];
    var10 = self.origin - var0[var6]["origin"];
    var11 = vectordot(vectorNormalize(var9), var10);

    if(!isDefined(var0[var6]["dist"])) {
      break;
    }

    var12 = var11 + level.drone_lookahead_value;

    while(var12 > var0[var6]["dist"]) {
      var12 -= var0[var6]["dist"];
      var6++;
      self.cur_node = var0[var6];

      if(isDefined(var8)) {
        if(var6 == 0) {}

        if(!isDefined(self.beforestairanim)) {
          self.beforestairanim = self.droneanim;
        }

        var13 = level.drone_anims[self.team]["stairs"][var8];
        drone_play_looping_anim(var13, self.moveplaybackrate);
        var7 = 1;
      }

      if(!isDefined(var0[var6]["dist"])) {
        self rotateTo(vectortoangles(var0[var0.size - 1]["vec"]), var5);
        var14 = distance(self.origin, var0[var0.size - 1]["origin"]);
        var15 = var14 / var3 * self.moveplaybackrate;
        var16 = var0[var0.size - 1]["origin"] + (0, 0, 100);
        var17 = var0[var0.size - 1]["origin"] - (0, 0, 100);
        var18 = physicstrace(var16, var17);

        if(getDvar("debug_drones") == "1") {
          thread scripts\engine\utility::draw_line_for_time(var16, var17, 1, 1, 1, var5);
          thread scripts\engine\utility::draw_line_for_time(self.origin, var18, 0, 0, 1, var5);
        }

        self moveTo(var18, var15);
        wait var15;
        self notify("goal");
        thread check_delete();
        thread drone_idle(var0[var0.size - 1], var18);
        return;
      }

      if(!isDefined(var3[var9])) {
        self notify("goal");
        thread drone_idle();
        return;
      }
    }

    if(isDefined(self.drone_move_callback)) {
      var5 = [[self.drone_move_callback]]();

      if(isDefined(var5)) {
        if(var5.runanim != var4) {
          var4 = var5.runanim;
          var6 = var5.run_speed;
          var7 = var5.anim_relative;

          if(!var7) {
            thread drone_move_z(var6);
          } else {
            self notify("drone_move_z");
          }

          drone_play_looping_anim(var4, self.moveplaybackrate);
        }
      }
    }

    self.cur_node = var3[var9];
    var17 = var3[var9]["vec"] * var16;
    var17 += var3[var9]["origin"];
    var21 = var17;
    var22 = var21 + (0, 0, 100);
    var23 = var21 - (0, 0, 100);
    var21 = physicstrace(var22, var23);

    if(!var7) {
      self.drone_look_ahead_point = var21;
    }

    if(getDvar("debug_drones") == "1") {
      thread scripts\engine\utility::draw_line_for_time(var22, var23, 1, 1, 1, var8);
      thread draw_point(var21, 1, 0, 0, 16, var8);
    }

    var14 = vectortoangles(var21 - self.origin);
    self rotateTo((0, var14[1], 0), var8);
    var15 = var6 * var8 * self.moveplaybackrate;
    var18 = vectorNormalize(var21 - self.origin);
    var17 = var18 * var15;
    var17 += self.origin;

    if(getDvar("debug_drones") == "1") {
      thread scripts\engine\utility::draw_line_for_time(self.origin, var17, 0, 0, 1, var8);
    }

    self moveTo(var17, var8);
    wait var8;

    if(isDefined(self.cur_node["script_noteworthy"]) && (self.cur_node["script_noteworthy"] == "stairs_start_up" || self.cur_node["script_noteworthy"] == "stairs_start_down")) {
      var24 = strtok(self.cur_node["script_noteworthy"], "_");
      var11 = var24[2];
      continue;
    }

    if(var10 == 1) {
      if(isDefined(self.cur_node["script_noteworthy"]) && self.cur_node["script_noteworthy"] == "stairs_end") {
        var25 = self.beforestairanim;
        drone_play_looping_anim(var25, self.moveplaybackrate);
        var10 = 0;
        var11 = undefined;
      }
    }
  }

  thread drone_idle();
}

function drone_move_z(var0) {
  self endon("death");
  self endon("drone_stop");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var1 = 0.05;

  for(;;) {
    if(isDefined(self.drone_look_ahead_point) && var0 > 0) {
      var2 = self.drone_look_ahead_point[2] - self.origin[2];
      var3 = distance2d(self.drone_look_ahead_point, self.origin);
      var4 = var3 / var0;

      if(var4 > 0 && var2 != 0) {
        var5 = abs(var2) / var4;
        var6 = var5 * var1;

        if(var2 >= var5) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var6);
        } else if(var2 <= var5 * -1) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var6);
        }
      }
    }

    wait var1;
  }
}

function getpatharray(var0, var1) {
  var2 = 1;
  var3 = [];
  GscBinSkip0(0x2e, 0, "origin", var1);
}

function draw_point(var0, var1, var2, var3, var4, var5) {
  var6 = var0 + (var4, 0, 0);
  var7 = var0 - (var4, 0, 0);
  thread scripts\engine\utility::draw_line_for_time(var6, var7, var1, var2, var3, var5);
  var6 = var0 + (0, var4, 0);
  var7 = var0 - (0, var4, 0);
  thread scripts\engine\utility::draw_line_for_time(var6, var7, var1, var2, var3, var5);
  var6 = var0 + (0, 0, var4);
  var7 = var0 - (0, 0, var4);
  thread scripts\engine\utility::draw_line_for_time(var6, var7, var1, var2, var3, var5);
}

function check_delete() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self.magic_bullet_shield)) {
        scripts\common\ai::stop_magic_bullet_shield();
      }

      self delete();
      break;
    case "die_on_goal":
      self kill();
      break;
  }
}