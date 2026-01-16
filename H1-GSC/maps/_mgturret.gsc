/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_mgturret.gsc
********************************/

init_mgturretsettings() {
  level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
  level.mgturretsettings["easy"]["suppressionTime"] = 3.0;
  level.mgturretsettings["easy"]["accuracy"] = 0.38;
  level.mgturretsettings["easy"]["aiSpread"] = 2;
  level.mgturretsettings["easy"]["playerSpread"] = 0.5;
  level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
  level.mgturretsettings["medium"]["suppressionTime"] = 3.0;
  level.mgturretsettings["medium"]["accuracy"] = 0.38;
  level.mgturretsettings["medium"]["aiSpread"] = 2;
  level.mgturretsettings["medium"]["playerSpread"] = 0.5;
  level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
  level.mgturretsettings["hard"]["suppressionTime"] = 3.0;
  level.mgturretsettings["hard"]["accuracy"] = 0.38;
  level.mgturretsettings["hard"]["aiSpread"] = 2;
  level.mgturretsettings["hard"]["playerSpread"] = 0.5;
  level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
  level.mgturretsettings["fu"]["suppressionTime"] = 3.0;
  level.mgturretsettings["fu"]["accuracy"] = 0.38;
  level.mgturretsettings["fu"]["aiSpread"] = 2;
  level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

main() {
  if(getdvar("mg42") == "")
    setdvar("mgTurret", "off");

  level.magic_distance = 24;
  var_0 = getentarray("turretInfo", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] delete();
}

portable_mg_behavior() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level.default_goalradius;

  if(isdefined(self.target)) {
    var_0 = getnode(self.target, "targetname");

    if(isdefined(var_0)) {
      if(isdefined(var_0.radius))
        self.goalradius = var_0.radius;

      self setgoalnode(var_0);
    }
  }

  while (!isdefined(self.node))
    wait 0.05;

  var_1 = undefined;

  if(isdefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    var_1 = var_0;
  }

  if(!isdefined(var_1))
    var_1 = self.node;

  if(!isdefined(var_1)) {
    return;
  }
  if(var_1.type != "Turret") {
    return;
  }
  var_2 = gettakennodes();
  var_2[self.node.origin + ""] = undefined;

  if(isdefined(var_2[var_1.origin + ""])) {
    return;
  }
  var_3 = var_1.turret;

  if(isdefined(var_3.reserved)) {
    return;
  }
  reserve_turret(var_3);

  if(var_3.issetup)
    leave_gun_and_run_to_new_spot(var_3);
  else
    run_to_new_spot_and_setup_gun(var_3);

  maps\_mg_penetration::gunner_think(var_1.turret);
}

mg42_trigger() {
  self waittill("trigger");
  level notify(self.targetname);
  level.mg42_trigger[self.targetname] = 1;
  self delete();
}

mgturret_auto(var_0) {
  var_0 waittill("trigger");
  var_1 = getaiarray("bad_guys");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isdefined(var_1[var_2].script_mg42auto) && var_0.script_mg42auto == var_1[var_2].script_mg42auto)
      var_1[var_2] notify("auto_ai");
  }

  var_3 = getspawnerarray();

  for (var_2 = 0; var_2 < var_3.size; var_2++) {
    if(isdefined(var_3[var_2].script_mg42auto) && var_0.script_mg42auto == var_3[var_2].script_mg42auto)
      var_3[var_2].ai_mode = "auto_ai";
  }

  maps\_spawner::kill_trigger(var_0);
}

mg42_suppressionfire(var_0) {
  self endon("death");
  self endon("stop_suppressionFire");

  if(!isdefined(self.suppresionfire))
    self.suppresionfire = 1;

  for (;;) {
    while (self.suppresionfire) {
      self settargetentity(var_0[randomint(var_0.size)]);
      wait(2 + randomfloat(2));
    }

    self cleartargetentity();

    while (!self.suppresionfire)
      wait 1;
  }
}

manual_think(var_0) {
  var_1 = self.origin;
  self waittill("auto_ai");
  var_0 notify("stopfiring");
  var_0 setmode("auto_ai");
  var_0 settargetentity(level.player);
}

burst_fire_settings(var_0) {
  if(var_0 == "delay")
    return 0.2;
  else if(var_0 == "delay_range")
    return 0.5;
  else if(var_0 == "burst")
    return 0.5;
  else
    return 1.5;
}

burst_fire_unmanned() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isdefined(self.script_delay_min))
    var_0 = self.script_delay_min;
  else
    var_0 = burst_fire_settings("delay");

  if(isdefined(self.script_delay_max))
    var_1 = self.script_delay_max - var_0;
  else
    var_1 = burst_fire_settings("delay_range");

  if(isdefined(self.script_burst_min))
    var_2 = self.script_burst_min;
  else
    var_2 = burst_fire_settings("burst");

  if(isdefined(self.script_burst_max))
    var_3 = self.script_burst_max - var_2;
  else
    var_3 = burst_fire_settings("burst_range");

  var_4 = gettime();
  var_5 = "start";

  if(isdefined(self.shell_fx))
    thread turret_shell_fx();

  for (;;) {
    var_6 = (var_4 - gettime()) * 0.001;

    if(self isfiringturret() && var_6 <= 0) {
      if(var_5 != "fire") {
        var_5 = "fire";
        thread doshoot();
      }

      var_6 = var_2 + randomfloat(var_3);
      thread turrettimer(var_6);
      self waittill("turretstatechange");
      var_6 = var_0 + randomfloat(var_1);
      var_4 = gettime() + int(var_6 * 1000);
      continue;
    }

    if(var_5 != "aim")
      var_5 = "aim";

    thread turrettimer(var_6);
    self waittill("turretstatechange");
  }
}

doshoot() {
  self endon("death");
  self endon("turretstatechange");

  for (;;) {
    self shootturret();
    self notify("turret_fire");
    wait 0.1;
  }
}

turret_shell_fx() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isdefined(self.shell_sound))
    self.shell_sound_enabled = 1;

  for (;;) {
    self waittill("turret_fire");
    playfxontag(self.shell_fx, self, "tag_origin");

    if(isdefined(self.shell_sound_enabled) && self.shell_sound_enabled)
      thread turret_shell_sound();
  }
}

turret_shell_sound() {
  self endon("death");
  self.shell_sound_enabled = 0;
  var_0 = self gettagorigin("tag_origin");
  var_1 = common_scripts\utility::drop_to_ground(var_0, -30);
  var_2 = var_0[2] - var_1[2];
  var_3 = var_2 / 300;
  wait(var_3);
  level thread common_scripts\utility::play_sound_in_space(self.shell_sound, var_1);
  wait 1;
  self.shell_sound_enabled = 1;
}

turrettimer(var_0) {
  if(var_0 <= 0) {
    return;
  }
  self endon("turretstatechange");
  wait(var_0);

  if(isdefined(self))
    self notify("turretstatechange");
}

random_spread(var_0) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(var_0);

  for (;;) {
    if(isplayer(var_0))
      var_0.origin = self.manual_target getorigin();
    else
      var_0.origin = self.manual_target.origin;

    var_0.origin = var_0.origin + (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

mg42_firing(var_0) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  var_0 stopfiring();

  for (;;) {
    var_0 waittill("startfiring");
    thread burst_fire(var_0);
    var_0 startfiring();
    var_0 waittill("stopfiring");
    var_0 stopfiring();
  }
}

burst_fire(var_0, var_1) {
  var_0 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isdefined(var_0.script_delay_min))
    var_2 = var_0.script_delay_min;
  else
    var_2 = burst_fire_settings("delay");

  if(isdefined(var_0.script_delay_max))
    var_3 = var_0.script_delay_max - var_2;
  else
    var_3 = burst_fire_settings("delay_range");

  if(isdefined(var_0.script_burst_min))
    var_4 = var_0.script_burst_min;
  else
    var_4 = burst_fire_settings("burst");

  if(isdefined(var_0.script_burst_max))
    var_5 = var_0.script_burst_max - var_4;
  else
    var_5 = burst_fire_settings("burst_range");

  for (;;) {
    var_0 startfiring();

    if(isdefined(var_1))
      var_0 thread random_spread(var_1);

    wait(var_4 + randomfloat(var_5));
    var_0 stopfiring();
    wait(var_2 + randomfloat(var_3));
  }
}

_spawner_mg42_think() {
  if(!isdefined(self.flagged_for_use))
    self.flagged_for_use = 0;

  if(!isdefined(self.targetname)) {
    return;
  }
  var_0 = getnode(self.targetname, "target");

  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.script_mg42)) {
    return;
  }
  if(!isdefined(var_0.mg42_enabled))
    var_0.mg42_enabled = 1;

  self.script_mg42 = var_0.script_mg42;
  var_1 = 1;

  for (;;) {
    if(var_1) {
      var_1 = 0;

      if(isdefined(var_0.targetname) || self.flagged_for_use)
        self waittill("get new user");
    }

    if(!var_0.mg42_enabled) {
      var_0 waittill("enable mg42");
      var_0.mg42_enabled = 1;
    }

    var_2 = [];
    var_3 = getaiarray();

    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = 1;

      if(isdefined(var_3[var_4].script_mg42) && var_3[var_4].script_mg42 == self.script_mg42)
        var_5 = 0;

      if(isdefined(var_3[var_4].used_an_mg42))
        var_5 = 1;

      if(var_5)
        var_2[var_2.size] = var_3[var_4];
    }

    if(var_2.size)
      var_3 = maps\_utility::get_closest_ai_exclude(var_0.origin, undefined, var_2);
    else
      var_3 = maps\_utility::get_closest_ai(var_0.origin, undefined);

    var_2 = undefined;

    if(isdefined(var_3)) {
      var_3 notify("stop_going_to_node");
      var_3 thread maps\_spawner::go_to_node(var_0);
      var_3 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

mg42_think() {
  if(!isdefined(self.ai_mode))
    self.ai_mode = "manual_ai";

  var_0 = getnode(self.target, "targetname");

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = getent(var_0.target, "targetname");
  var_1.org = var_0.origin;

  if(isdefined(var_1.target)) {
    if(!isdefined(level.mg42_trigger) || !isdefined(level.mg42_trigger[var_1.target])) {
      level.mg42_trigger[var_1.target] = 0;
      getent(var_1.target, "targetname") thread mg42_trigger();
    }

    var_2 = 1;
  } else
    var_2 = 0;

  for (;;) {
    if(self.count == 0) {
      return;
    }
    var_3 = undefined;

    while (!isdefined(var_3)) {
      var_3 = self dospawn();
      wait 1;
    }

    var_3 thread mg42_gunner_think(var_1, var_2, self.ai_mode);
    var_3 thread mg42_firing(var_1);
    var_3 waittill("death");

    if(isdefined(self.script_delay)) {
      wait(self.script_delay);
      continue;
    }

    if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max)) {
      wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
      continue;
    }

    wait 1;
  }
}

kill_objects(var_0, var_1, var_2, var_3) {
  var_0 waittill(var_1);

  if(isdefined(var_2))
    var_2 delete();

  if(isdefined(var_3))
    var_3 delete();
}

mg42_gunner_think(var_0, var_1, var_2) {
  self endon("death");

  if(var_2 == "manual_ai") {
    for (;;) {
      thread mg42_gunner_manual_think(var_0, var_1);
      self waittill("auto_ai");
      move_use_turret(var_0, "auto_ai");
      self waittill("manual_ai");
    }
  } else {
    for (;;) {
      move_use_turret(var_0, "auto_ai", level.player);
      self waittill("manual_ai");
      thread mg42_gunner_manual_think(var_0, var_1);
      self waittill("auto_ai");
    }
  }
}

player_safe() {
  if(!isdefined(level.player_covertrigger))
    return 0;

  if(level.player getstance() == "prone")
    return 1;

  if(level.player_covertype == "cow" && level.player getstance() == "crouch")
    return 1;

  return 0;
}

stance_num() {
  if(level.player getstance() == "prone")
    return (0, 0, 5);
  else if(level.player getstance() == "crouch")
    return (0, 0, 25);

  return (0, 0, 50);
}

mg42_gunner_manual_think(var_0, var_1) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self setgoalpos(var_0.org);
  self.goalradius = level.magic_distance;
  self waittill("goal");

  if(var_1) {
    if(!level.mg42_trigger[var_0.target])
      level waittill(var_0.target);
  }

  self.pacifist = 0;
  var_0 setmode("auto_ai");
  var_0 cleartargetentity();
  var_2 = spawn("script_origin", (0, 0, 0));
  var_3 = spawn("script_model", (0, 0, 0));
  var_3.scale = 3;

  if(getdvar("mg42") != "off")
    var_3 setmodel("temp");

  var_3 thread temp_think(var_0, var_2);
  level thread kill_objects(self, "death", var_2, var_3);
  level thread kill_objects(self, "auto_ai", var_2, var_3);
  var_0.player_target = 0;
  var_4 = 0;
  var_5 = getentarray("mg42_target", "targetname");

  if(var_5.size > 0) {
    var_6 = 1;
    var_7 = var_5[randomint(var_5.size)].origin;
    thread shoot_mg42_script_targets(var_5);
    move_use_turret(var_0);
    self.target_entity = var_2;
    var_0 setmode("manual_ai");
    var_0 settargetentity(var_2);
    var_0 notify("startfiring");
    var_8 = 15;
    var_9 = 0.08;
    var_10 = 0.05;
    var_2.origin = var_5[randomint(var_5.size)].origin;
    var_11 = 0;

    while (!isdefined(level.player_covertrigger)) {
      var_7 = var_2.origin;

      if(distance(var_7, var_5[self.gun_targ].origin) > var_8) {
        var_12 = vectornormalize(var_5[self.gun_targ].origin - var_7);
        var_12 = var_12 * var_8;
        var_7 = var_7 + var_12;
      } else
        self notify("next_target");

      var_2.origin = var_7;
      wait 0.1;
    }

    for (;;) {
      for (var_13 = 0; var_13 < 1; var_13 = var_13 + var_10) {
        var_2.origin = var_7 * (1.0 - var_13) + (level.player getorigin() + stance_num()) * var_13;

        if(player_safe())
          var_13 = 2;

        wait(var_9);
      }

      var_14 = level.player getorigin();

      while (!player_safe()) {
        var_2.origin = level.player getorigin();
        var_15 = var_2.origin - var_14;
        var_2.origin = var_2.origin + var_15 + stance_num();
        var_14 = level.player getorigin();
        wait 0.1;
      }

      if(player_safe()) {
        var_11 = gettime() + 1500 + randomfloat(4000);

        while (player_safe() && isdefined(level.player_covertrigger.target) && gettime() < var_11) {
          var_16 = getentarray(level.player_covertrigger.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("next_target");

      while (player_safe()) {
        var_7 = var_2.origin;

        if(distance(var_7, var_5[self.gun_targ].origin) > var_8) {
          var_12 = vectornormalize(var_5[self.gun_targ].origin - var_7);
          var_12 = var_12 * var_8;
          var_7 = var_7 + var_12;
        } else
          self notify("next_target");

        var_2.origin = var_7;
        wait 0.1;
      }
    }
  } else {
    for (;;) {
      move_use_turret(var_0);

      while (!isdefined(level.player_covertrigger)) {
        if(!var_0.player_target) {
          var_0 settargetentity(level.player);
          var_0.player_target = 1;
          var_3.targent = level.player;
        }

        wait 0.2;
      }

      var_0 setmode("manual_ai");
      move_use_turret(var_0);
      var_0 notify("startfiring");
      var_11 = gettime() + 1500 + randomfloat(4000);

      while (var_11 > gettime()) {
        if(isdefined(level.player_covertrigger)) {
          var_16 = getentarray(level.player_covertrigger.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          var_0 settargetentity(var_2);
          var_3.targent = var_2;
          wait(randomfloat(1));
          continue;
        }

        break;
      }

      var_0 notify("stopfiring");
      move_use_turret(var_0);

      if(var_0.player_target) {
        var_0 setmode("auto_ai");
        var_0 cleartargetentity();
        var_0.player_target = 0;
        var_3.targent = var_3;
        var_3.origin = (0, 0, 0);
      }

      while (isdefined(level.player_covertrigger))
        wait 0.2;

      wait(0.75 + randomfloat(0.2));
    }
  }
}

shoot_mg42_script_targets(var_0) {
  self endon("death");

  for (;;) {
    var_1 = [];

    for (var_2 = 0; var_2 < var_0.size; var_2++)
      var_1[var_2] = 0;

    for (var_2 = 0; var_2 < var_0.size; var_2++) {
      self.gun_targ = randomint(var_0.size);
      self waittill("next_target");

      while (var_1[self.gun_targ]) {
        self.gun_targ++;

        if(self.gun_targ >= var_0.size)
          self.gun_targ = 0;
      }

      var_1[self.gun_targ] = 1;
    }
  }
}

move_use_turret(var_0, var_1, var_2) {
  self setgoalpos(var_0.org);
  self.goalradius = level.magic_distance;
  self waittill("goal");

  if(isdefined(var_1) && var_1 == "auto_ai") {
    var_0 setmode("auto_ai");

    if(isdefined(var_2))
      var_0 settargetentity(var_2);
    else
      var_0 cleartargetentity();
  }

  self useturret(var_0);
}

temp_think(var_0, var_1) {
  if(getdvar("mg42") == "off") {
    return;
  }
  self.targent = self;

  for (;;) {
    self.origin = var_1.origin;
    wait 0.1;
  }
}

turret_think(var_0) {
  var_1 = getent(var_0.auto_mg42_target, "targetname");
  var_2 = 0.5;

  if(isdefined(var_1.script_turret_reuse_min))
    var_2 = var_1.script_turret_reuse_min;

  var_3 = 2;

  if(isdefined(var_1.script_turret_reuse_max))
    var_2 = var_1.script_turret_reuse_max;

  for (;;) {
    var_1 waittill("turret_deactivate");
    wait(var_2 + randomfloat(var_3 - var_2));

    while (!isturretactive(var_1)) {
      turret_find_user(var_0, var_1);
      wait 1.0;
    }
  }
}

turret_find_user(var_0, var_1) {
  var_2 = getaiarray();

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] isingoal(var_0.origin) && var_2[var_3] canuseturret(var_1)) {
      var_4 = var_2[var_3].keepclaimednodeifvalid;
      var_2[var_3].keepclaimednodeifvalid = 0;

      if(!var_2[var_3] usecovernode(var_0))
        var_2[var_3].keepclaimednodeifvalid = var_4;
    }
  }
}

setdifficulty() {
  init_mgturretsettings();
  var_0 = getentarray("misc_turret", "code_classname");
  var_1 = maps\_utility::getdifficulty();

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isdefined(var_0[var_2].script_skilloverride)) {
      switch (var_0[var_2].script_skilloverride) {
        case "easy":
          var_1 = "easy";
          break;
        case "medium":
          var_1 = "medium";
          break;
        case "hard":
          var_1 = "hard";
          break;
        case "fu":
          var_1 = "fu";
          break;
        default:
          continue;
      }
    }

    mg42_setdifficulty(var_0[var_2], var_1);
  }
}

mg42_setdifficulty(var_0, var_1) {
  var_0.convergencetime = level.mgturretsettings[var_1]["convergenceTime"];
  var_0.suppressiontime = level.mgturretsettings[var_1]["suppressionTime"];
  var_0.accuracy = level.mgturretsettings[var_1]["accuracy"];
  var_0.aispread = level.mgturretsettings[var_1]["aiSpread"];
  var_0.playerspread = level.mgturretsettings[var_1]["playerSpread"];
}

mg42_target_drones(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 0.88;

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.dronefailed = 0;

  if(!isdefined(self.script_fireondrones))
    self.script_fireondrones = 0;

  if(!isdefined(var_0))
    var_0 = 0;

  self setmode("manual_ai");
  var_3 = maps\_utility::getdifficulty();

  if(!isdefined(level.drones))
    var_4 = 1;
  else
    var_4 = 0;

  for (;;) {
    if(var_4) {
      if(isdefined(self.drones_targets_sets_to_default))
        self setmode(self.defaultonmode);
      else if(var_0)
        self setmode("auto_nonai");
      else
        self setmode("auto_ai");

      level waittill("new_drone");
    }

    if(!isdefined(self.oldconvergencetime))
      self.oldconvergencetime = self.convergencetime;

    self.convergencetime = 2;

    if(!var_0) {
      var_5 = self getturretowner();

      if(!isalive(var_5) || isplayer(var_5)) {
        wait 0.05;
        continue;
      } else
        var_1 = var_5.team;
    } else
      var_5 = undefined;

    if(var_1 == "allies")
      var_6 = "axis";
    else
      var_6 = "allies";

    while (level.drones[var_6].lastindex) {
      common_scripts\utility::lock("mg42_drones");

      if(!level.drones[var_6].lastindex) {
        common_scripts\utility::unlock("mg42_drones");
        break;
      }

      var_7 = get_bestdrone(var_6, var_2);
      common_scripts\utility::unlock("mg42_drones");

      if(!isdefined(self.script_fireondrones) || !self.script_fireondrones) {
        wait 0.05;
        break;
      }

      if(!isdefined(var_7)) {
        wait 0.05;
        break;
      }

      if(isdefined(self.anim_wait_func))
        [[self.anim_wait_func]]();

      if(var_0)
        self setmode("manual");
      else
        self setmode("manual_ai");

      self settargetentity(var_7, (0, 0, 32));
      drone_target(var_7, 1, var_2);
      self cleartargetentity();
      self stopfiring();

      if(!var_0 && !(isdefined(self getturretowner()) && self getturretowner() == var_5)) {
        break;
      }
    }

    self.convergencetime = self.oldconvergencetime;
    self.oldconvergencetime = undefined;
    self cleartargetentity();
    self stopfiring();

    if(level.drones[var_6].lastindex) {
      var_4 = 0;
      continue;
    }

    var_4 = 1;
  }
}

drone_target(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_3 = gettime() + var_1 * 1000;
  var_4 = 0;

  while (var_3 > gettime() || var_4) {
    common_scripts\utility::lock("mg42_drones_target_trace");
    var_5 = self getturrettarget(1);

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_0.origin + (0, 0, 40), 0, var_0)) {
      common_scripts\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isdefined(var_5) && distance(var_5.origin, self.origin) < distance(self.origin, var_0.origin)) {
      common_scripts\utility::unlock("mg42_drones_target_trace");
      break;
    }

    if(!var_4) {
      self startfiring();
      var_4 = 1;
    }

    common_scripts\utility::unlock_wait("mg42_drones_target_trace");
  }

  self stopfiring();
  maps\_utility::structarray_shuffle(level.drones[var_0.team], 1);
}

get_bestdrone(var_0, var_1) {
  if(level.drones[var_0].lastindex < 1) {
    return;
  }
  var_2 = undefined;
  var_3 = anglestoforward(self.angles);

  for (var_4 = 0; var_4 < level.drones[var_0].lastindex; var_4++) {
    if(!isdefined(level.drones[var_0].array[var_4])) {
      continue;
    }
    var_5 = vectortoangles(level.drones[var_0].array[var_4].origin - self.origin);
    var_6 = anglestoforward(var_5);

    if(vectordot(var_3, var_6) < var_1) {
      continue;
    }
    var_2 = level.drones[var_0].array[var_4];

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_2 getcentroid(), 0, var_2)) {
      var_2 = undefined;
      continue;
    }

    break;
  }

  var_7 = self getturrettarget(1);

  if(!isdefined(self.prefers_drones)) {
    if(isdefined(var_2) && isdefined(var_7) && distancesquared(self.origin, var_7.origin) < distancesquared(self.origin, var_2.origin))
      var_2 = undefined;
  }

  return var_2;
}

saw_mgturretlink(var_0) {
  var_1 = getentarray("misc_turret", "code_classname");
  var_2 = [];

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(isdefined(var_1[var_3].targetname)) {
      continue;
    }
    if(isdefined(var_1[var_3].isvehicleattached)) {
      continue;
    }
    var_2[var_1[var_3].origin + ""] = var_1[var_3];
  }

  if(!var_2.size) {
    return;
  }
  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_5.type == "Path") {
      continue;
    }
    if(var_5.type == "Begin") {
      continue;
    }
    if(var_5.type == "End") {
      continue;
    }
    var_6 = anglestoforward((0, var_5.angles[1], 0));

    foreach(var_11, var_8 in var_2) {
      if(distance(var_5.origin, var_8.origin) > 50) {
        continue;
      }
      var_9 = anglestoforward((0, var_8.angles[1], 0));
      var_10 = vectordot(var_6, var_9);

      if(var_10 < 0.9) {
        continue;
      }
      var_5.turretinfo = spawn("script_origin", var_8.origin);
      var_5.turretinfo.angles = var_8.angles;
      var_5.turretinfo.node = var_5;
      var_5.turretinfo.leftarc = 45;
      var_5.turretinfo.rightarc = 45;
      var_5.turretinfo.toparc = 15;
      var_5.turretinfo.bottomarc = 15;

      if(isdefined(var_8.leftarc))
        var_5.turretinfo.leftarc = min(var_8.leftarc, 45);

      if(isdefined(var_8.rightarc))
        var_5.turretinfo.rightarc = min(var_8.rightarc, 45);

      if(isdefined(var_8.toparc))
        var_5.turretinfo.toparc = min(var_8.toparc, 15);

      if(isdefined(var_8.bottomarc))
        var_5.turretinfo.bottomarc = min(var_8.bottomarc, 15);

      var_2[var_11] = undefined;
      var_8 delete();
    }
  }
}

auto_mgturretlink(var_0) {
  var_1 = getentarray("misc_turret", "code_classname");
  var_2 = [];

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isdefined(var_1[var_3].targetname) || tolower(var_1[var_3].targetname) != "find_mgTurret") {
      continue;
    }
    if(!isdefined(var_1[var_3].export)) {
      continue;
    }
    if(!isdefined(var_1[var_3].script_dont_link_turret))
      var_2[var_1[var_3].origin + ""] = var_1[var_3];
  }

  if(!var_2.size) {
    return;
  }
  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_5.type == "Path") {
      continue;
    }
    if(var_5.type == "Begin") {
      continue;
    }
    if(var_5.type == "End") {
      continue;
    }
    var_6 = anglestoforward((0, var_5.angles[1], 0));
    var_7 = getarraykeys(var_2);

    for (var_3 = 0; var_3 < var_7.size; var_3++) {
      var_8 = var_2[var_7[var_3]];

      if(distance(var_5.origin, var_8.origin) > 70) {
        continue;
      }
      var_9 = anglestoforward((0, var_8.angles[1], 0));
      var_10 = vectordot(var_6, var_9);

      if(var_10 < 0.9) {
        continue;
      }
      var_5.turret = var_8;
      var_8.node = var_5;
      var_8.issetup = 1;
      var_2[var_7[var_3]] = undefined;
    }
  }

  var_0 = undefined;
}

save_turret_sharing_info() {
  self.shared_turrets = [];
  self.shared_turrets["connected"] = [];
  self.shared_turrets["ambush"] = [];

  if(!isdefined(self.export)) {
    return;
  }
  level.shared_portable_turrets[self.export] = self;

  if(isdefined(self.script_turret_share)) {
    var_0 = strtok(self.script_turret_share, " ");

    for (var_1 = 0; var_1 < var_0.size; var_1++)
      self.shared_turrets["connected"][var_0[var_1]] = 1;
  }

  if(isdefined(self.script_turret_ambush)) {
    var_0 = strtok(self.script_turret_ambush, " ");

    for (var_1 = 0; var_1 < var_0.size; var_1++)
      self.shared_turrets["ambush"][var_0[var_1]] = 1;
  }
}

restoredefaultpitch() {
  self notify("gun_placed_again");
  self endon("gun_placed_again");
  self waittill("restore_default_drop_pitch");
  wait 1;
  self restoredefaultdroppitch();
}

dropturret() {
  thread dropturretproc();
}

dropturretproc() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0.origin = self gettagorigin(level.portable_mg_gun_tag);
  var_0.angles = self gettagangles(level.portable_mg_gun_tag);
  var_0 setmodel(self.turretmodel);
  var_1 = anglestoforward(self.angles);
  var_1 = var_1 * 100;
  var_0 movegravity(var_1, 0.5);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  self.turretmodel = undefined;
  wait 0.7;
  var_0 delete();
}

turretdeathdetacher() {
  self endon("kill_turret_detach_thread");
  self endon("dropped_gun");
  self waittill("death");

  if(!isdefined(self)) {
    return;
  }
  dropturret();
}

turretdetacher() {
  self endon("death");
  self endon("kill_turret_detach_thread");
  self waittill("dropped_gun");
  self detach(self.turretmodel, level.portable_mg_gun_tag);
}

restoredefaults() {
  self.run_overrideanim = undefined;
  common_scripts\utility::set_all_exceptions(animscripts\init::empty);
}

restorepitch() {
  self waittill("turret_deactivate");
  self restoredefaultdroppitch();
}

update_enemy_target_pos_while_running(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for (;;) {
    self waittill("saw_enemy");
    var_0.origin = self.last_enemy_sighting_position;
  }
}

move_target_pos_to_new_turrets_visibility(var_0, var_1) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_2 = self.turret.origin + (0, 0, 16);
  var_3 = var_1.origin + (0, 0, 16);

  for (;;) {
    wait 0.05;

    if(sighttracepassed(var_0.origin, var_3, 0, undefined)) {
      continue;
    }
    var_4 = vectortoangles(var_2 - var_0.origin);
    var_5 = anglestoforward(var_4);
    var_5 = var_5 * 8;
    var_0.origin = var_0.origin + var_5;
  }
}

record_bread_crumbs_for_ambush(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_0.bread_crumbs = [];

  for (;;) {
    var_0.bread_crumbs[var_0.bread_crumbs.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

aim_turret_at_ambush_point_or_visible_enemy(var_0, var_1) {
  if(!isalive(self.current_enemy) && self cansee(self.current_enemy)) {
    var_1.origin = self.last_enemy_sighting_position;
    return;
  }

  var_2 = anglestoforward(var_0.angles);

  for (var_3 = var_1.bread_crumbs.size - 3; var_3 >= 0; var_3--) {
    var_4 = var_1.bread_crumbs[var_3];
    var_5 = vectornormalize(var_4 - var_0.origin);
    var_6 = vectordot(var_2, var_5);

    if(var_6 < 0.75) {
      continue;
    }
    var_1.origin = var_4;

    if(sighttracepassed(var_0.origin, var_4, 0, undefined)) {
      continue;
    }
    break;
  }
}

find_a_new_turret_spot(var_0) {
  var_1 = get_portable_mg_spot(var_0);
  var_2 = var_1["spot"];
  var_3 = var_1["type"];

  if(!isdefined(var_2)) {
    return;
  }
  reserve_turret(var_2);
  thread update_enemy_target_pos_while_running(var_0);
  thread move_target_pos_to_new_turrets_visibility(var_0, var_2);

  if(var_3 == "ambush")
    thread record_bread_crumbs_for_ambush(var_0);

  if(var_2.issetup)
    leave_gun_and_run_to_new_spot(var_2);
  else {
    pickup_gun(var_2);
    run_to_new_spot_and_setup_gun(var_2);
  }

  self notify("stop_updating_enemy_target_pos");

  if(var_3 == "ambush")
    aim_turret_at_ambush_point_or_visible_enemy(var_2, var_0);

  var_2 settargetentity(var_0);
}

snap_lock_turret_onto_target(var_0) {
  var_0 setmode("manual");
  wait 0.5;
  var_0 setmode("manual_ai");
}

leave_gun_and_run_to_new_spot(var_0) {
  self stopuseturret();
  animscripts\shared::placeweaponon(self.primaryweapon, "none");
  var_1 = get_turret_setup_anim(var_0);
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  self setruntopos(var_2);
  self waittill("runto_arrived");
  use_the_turret(var_0);
}

pickup_gun(var_0) {
  self stopuseturret();
  self.turret hide_turret();
}

get_turret_setup_anim(var_0) {
  var_1 = [];
  var_1["saw_bipod_stand"] = level.mg_animmg["bipod_stand_setup"];
  var_1["saw_bipod_crouch"] = level.mg_animmg["bipod_crouch_setup"];
  var_1["saw_bipod_prone"] = level.mg_animmg["bipod_prone_setup"];
  return var_1[var_0.weaponinfo];
}

#using_animtree("generic_human");

run_to_new_spot_and_setup_gun(var_0) {
  var_1 = self.health;
  var_0 endon("turret_deactivate");
  self.mg42 = var_0;
  self endon("death");
  self endon("dropped_gun");
  var_2 = get_turret_setup_anim(var_0);
  self.turretmodel = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  animscripts\shared::placeweaponon(self.weapon, "none");

  if(self isbadguy())
    self.health = 1;

  self.run_overrideanim = % saw_gunner_run_fast;
  self.crouchrun_combatanim = % saw_gunner_run_fast;
  self attach(self.turretmodel, level.portable_mg_gun_tag);
  thread turretdeathdetacher();
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  self setruntopos(var_3);
  wait 0.05;
  common_scripts\utility::set_all_exceptions(animscripts\combat::exception_exposed_mg42_portable);
  common_scripts\utility::clear_exception("move");
  common_scripts\utility::set_exception("cover_crouch", ::hold_indefintely);

  while (distance(self.origin, var_3) > 16) {
    self setruntopos(var_3);
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy())
    self.health = var_1;

  if(soundexists("weapon_setup"))
    thread common_scripts\utility::play_sound_in_space("weapon_setup");

  self animscripted("setup_done", var_0.origin, var_0.angles, var_2);
  restoredefaults();
  self waittillmatch("setup_done", "end");
  var_0 notify("restore_default_drop_pitch");
  var_0 show_turret();
  animscripts\shared::placeweaponon(self.primaryweapon, "right");
  use_the_turret(var_0);
  self detach(self.turretmodel, level.portable_mg_gun_tag);
  common_scripts\utility::set_all_exceptions(animscripts\init::empty);
  self notify("bcs_portable_turret_setup");
}

move_to_run_pos() {
  self setruntopos(self.runpos);
}

hold_indefintely() {
  self endon("killanimscript");
  self waittill("death");
}

using_a_turret() {
  if(!isdefined(self.turret))
    return 0;

  return self.turret.owner == self;
}

turret_user_moves() {
  if(!using_a_turret()) {
    common_scripts\utility::clear_exception("move");
    return;
  }

  var_0 = find_connected_turrets("connected");
  var_1 = var_0["spots"];

  if(!var_1.size) {
    common_scripts\utility::clear_exception("move");
    return;
  }

  var_2 = self.node;

  if(!isdefined(var_2) || !maps\_utility::is_in_array(var_1, var_2)) {
    var_3 = gettakennodes();

    for (var_4 = 0; var_4 < var_1.size; var_4++) {
      var_2 = common_scripts\utility::random(var_1);

      if(isdefined(var_3[var_2.origin + ""]))
        return;
    }
  }

  var_5 = var_2.turret;

  if(isdefined(var_5.reserved)) {
    return;
  }
  reserve_turret(var_5);

  if(var_5.issetup)
    leave_gun_and_run_to_new_spot(var_5);
  else
    run_to_new_spot_and_setup_gun(var_5);

  maps\_mg_penetration::gunner_think(var_2.turret);
}

use_the_turret(var_0) {
  var_1 = self useturret(var_0);

  if(var_1) {
    common_scripts\utility::set_exception("move", ::turret_user_moves);
    self.turret = var_0;
    thread mg42_firing(var_0);
    var_0 setmode("manual_ai");
    var_0 thread restorepitch();
    self.turret = var_0;
    var_0.owner = self;
    return 1;
  } else {
    var_0 restoredefaultdroppitch();
    return 0;
  }
}

get_portable_mg_spot(var_0) {
  var_1 = [];
  var_1[var_1.size] = ::find_different_way_to_attack_last_seen_position;
  var_1[var_1.size] = ::find_good_ambush_spot;
  var_1 = common_scripts\utility::array_randomize(var_1);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = [
      [var_1[var_2]]
    ](var_0);

    if(!isdefined(var_3["spots"])) {
      continue;
    }
    var_3["spot"] = common_scripts\utility::random(var_3["spots"]);
    return var_3;
  }
}

gettakennodes() {
  var_0 = [];
  var_1 = getaiarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isdefined(var_1[var_2].node)) {
      continue;
    }
    var_0[var_1[var_2].node.origin + ""] = 1;
  }

  return var_0;
}

find_connected_turrets(var_0) {
  var_1 = level.shared_portable_turrets;
  var_2 = [];
  var_3 = getarraykeys(var_1);
  var_4 = gettakennodes();
  var_4[self.node.origin + ""] = undefined;

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(var_1[var_6] == self.turret) {
      continue;
    }
    var_7 = getarraykeys(self.turret.shared_turrets[var_0]);

    for (var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_1[var_6].export+"" != var_7[var_8]) {
        continue;
      }
      if(isdefined(var_1[var_6].reserved)) {
        continue;
      }
      if(isdefined(var_4[var_1[var_6].node.origin + ""])) {
        continue;
      }
      if(distance(self.goalpos, var_1[var_6].origin) > self.goalradius) {
        continue;
      }
      var_2[var_2.size] = var_1[var_6];
    }
  }

  var_9 = [];
  var_9["type"] = var_0;
  var_9["spots"] = var_2;
  return var_9;
}

find_good_ambush_spot(var_0) {
  return find_connected_turrets("ambush");
}

find_different_way_to_attack_last_seen_position(var_0) {
  var_1 = find_connected_turrets("connected");
  var_2 = var_1["spots"];

  if(!var_2.size) {
    return;
  }
  var_3 = [];

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    if(!common_scripts\utility::within_fov(var_2[var_4].origin, var_2[var_4].angles, var_0.origin, 0.75)) {
      continue;
    }
    if(!sighttracepassed(var_0.origin, var_2[var_4].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }
    var_3[var_3.size] = var_2[var_4];
  }

  var_1["spots"] = var_3;
  return var_1;
}

portable_mg_spot() {
  save_turret_sharing_info();
  var_0 = 1;
  self.issetup = 1;
  self.reserved = undefined;

  if(isdefined(self.isvehicleattached)) {
    return;
  }
  if(self.spawnflags & var_0) {
    return;
  }
  hide_turret();
}

hide_turret() {
  self notify("stop_checking_for_flanking");
  self.issetup = 0;
  self hide();
  self.solid = 0;
  self makeunusable();
  self setdefaultdroppitch(0);
  thread restoredefaultpitch();
}

show_turret() {
  self show();
  self.solid = 1;
  self makeusable();
  self.issetup = 1;
  thread stop_mg_behavior_if_flanked();
}

stop_mg_behavior_if_flanked() {
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");

  if(isalive(self.owner))
    self.owner notify("end_mg_behavior");
}

turret_is_mine(var_0) {
  var_1 = var_0 getturretowner();

  if(!isdefined(var_1))
    return 0;

  return var_1 == self;
}

end_turret_reservation(var_0) {
  waittill_turret_is_released(var_0);
  var_0.reserved = undefined;
}

waittill_turret_is_released(var_0) {
  var_0 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

reserve_turret(var_0) {
  var_0.reserved = self;
  thread end_turret_reservation(var_0);
}