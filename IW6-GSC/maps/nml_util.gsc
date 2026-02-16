/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_util.gsc
*****************************************************/

team_set_colors() {
  level.baker maps\_utility::set_force_color("r");
  level.dog maps\_utility::set_force_color("o");
}

team_unset_colors(var_0) {
  if(!isDefined(var_0))
    var_0 = 256;

  level.baker maps\_utility::clear_force_color();
  level.baker.goalradius = var_0;
  level.baker.fixednode = 1;
  level.dog maps\_utility::clear_force_color();
  level.dog set_move_rate(0.8);
  level.dog.goalradius = var_0;
  level.dog.fixednode = 1;
}

team_2_unset_colors(var_0) {
  if(!isDefined(var_0))
    var_0 = 128;

  level.baker maps\_utility::clear_force_color();
  level.baker.goalradius = var_0;
  level.adam maps\_utility::clear_force_color();
  level.adam.goalradius = var_0;
}

set_start_positions(var_0) {
  var_1 = common_scripts\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "baker":
        level.baker forceteleport(var_3.origin, var_3.angles);
        level.baker setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.baker, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.baker thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "adam":
        level.adam forceteleport(var_3.origin, var_3.angles);
        level.adam setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.adam, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.adam thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "cairo":
      case "dog":
        level.dog forceteleport(var_3.origin, var_3.angles);
        level.dog setgoalpos(var_3.origin);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.dog thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "merrick":
        level.merrick forceteleport(var_3.origin, var_3.angles);
        level.merrick setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.merrick, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.merrick thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
      case "keegan":
        level.keegan forceteleport(var_3.origin, var_3.angles);
        level.keegan setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread maps\_anim::anim_generic(level.keegan, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 common_scripts\utility::get_target_ent();
          level.keegan thread maps\_utility::follow_path_and_animate(var_3);
        }

        break;
    }
  }
}

spawn_adam() {
  var_0 = common_scripts\utility::get_target_ent("adam");
  level.adam = var_0 maps\_utility::spawn_ai(1);
  level.adam thread maps\_utility::deletable_magic_bullet_shield();
  level.adam.animname = "adam";
  level.adam.script_friendname = "Logan";
  level.adam.name = "Logan";
  level.adam maps\_utility::set_force_color("g");
  level.adam thread maps\_stealth_utility::stealth_default();
  level.adam maps\_utility::disable_surprise();
  level.adam.fixednode = 1;
  level.adam maps\_utility::forceuseweapon("honeybadger+reflex_sp", "primary");
  level.adam.disable_sniper_glint = 1;
}

spawn_baker() {
  var_0 = common_scripts\utility::get_target_ent("baker");
  level.baker = var_0 maps\_utility::spawn_ai(1);
  level.baker thread maps\_utility::magic_bullet_shield();
  level.baker.animname = "hesh";
  level.baker.fixednode = 1;
  level.baker maps\_utility::set_ai_bcvoice("seal");
  level.baker maps\_utility::set_force_color("r");
  level.baker thread maps\_stealth_utility::stealth_default();
  level.baker maps\_utility::disable_surprise();
  level.baker pushplayer(1);
  level.baker maps\_utility::forceuseweapon("honeybadger+reflex_sp", "primary");
  level.baker.disable_sniper_glint = 1;
}

spawn_merrick() {
  var_0 = common_scripts\utility::get_target_ent("merrick");
  level.merrick = var_0 maps\_utility::spawn_ai(1);
  level.merrick thread maps\_utility::magic_bullet_shield();
  level.merrick.animname = "merrick";
  level.merrick maps\_utility::set_force_color("p");
}

spawn_keegan() {
  var_0 = common_scripts\utility::get_target_ent("keegan");
  level.keegan = var_0 maps\_utility::spawn_ai(1);
  level.keegan thread maps\_utility::magic_bullet_shield();
  level.keegan.animname = "keegan";
  level.keegan maps\_utility::set_force_color("b");
  level.keegan maps\_utility::forceuseweapon("l115a3+scopel115a3_sp", "primary");
}

spawn_dog() {
  var_0 = common_scripts\utility::get_target_ent("cairo");
  level.dog = var_0 maps\_utility::spawn_ai(1);
  level.dog thread maps\_utility::magic_bullet_shield();
  level.dog.animname = "dog";
  level.dog.meleealwayswin = 1;
  level.dog.script_stealthgroup = "dog";
  level.dog.script_nobark = 1;
  level.dog.script_friendname = "Riley";
  level.dog.name = "Riley";
  level.dog maps\_utility::set_force_color("r");
  level.dog.goalradius = 512;
  level.dog.goalheight = 128;
  level.dog.pathenemyfightdist = level.dog.goalradius;
  level.dog.fixednode = 1;
  level.dog setdogattackradius(128);
  level.dog setthreatbiasgroup("dog");
  setthreatbias("dog", "axis", 75);
  level.dog pushplayer(1);
  level.dog set_move_rate(0.7);
  level.dog thread maps\nml_stealth::dog_stealth();
  level.dog.script_color_delay_override = 1.5;
  level.dog thread maps\_utility_dogs::dog_pant_think();
}

set_move_rate(var_0) {
  self.moveplaybackrate = var_0;
  self.movetransitionrate = var_0;
}

move_up_when_clear() {
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = var_0 common_scripts\utility::get_target_ent();

  for(;;) {
    move_up_when_clear_think(var_1, var_0);
    wait 2;
  }
}

move_up_when_clear_think(var_0, var_1) {
  var_0 endon("trigger");
  self waittill("trigger");
  volume_waittill_no_axis(var_1.targetname, var_1.script_count);
  var_0 thread maps\_utility::activate_trigger();
}

tree_sway() {
  self endon("death");
  var_0 = common_scripts\utility::random([-1, 1]);

  for(;;) {
    var_1 = randomfloatrange(4, 8);
    var_2 = randomfloatrange(4, 7);
    self rotateyaw(var_2 * var_0, var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
    self rotateyaw(-1 * var_2 * var_0, var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
  }
}

tree_pitch() {
  self endon("death");
  var_0 = common_scripts\utility::random([-1, 1]);

  for(;;) {
    var_1 = randomfloatrange(5, 10);
    var_2 = randomfloatrange(5, 10);
    self rotatepitch(var_2 * var_0, var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
    self rotatepitch(-1 * var_2 * var_0, var_1, var_1 * 0.45, var_1 * 0.45);
    wait(var_1);
  }
}

earthquake_trigger() {
  self waittill("trigger");
  thread common_scripts\utility::do_earthquake(self.script_earthquake, self.origin);
  var_0 = common_scripts\utility::getStructArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_0, ::fx_ent_think);

  if(isDefined(self.script_soundalias))
    thread common_scripts\utility::play_sound_in_space(self.script_soundalias, var_0[0].origin);

  wait 0.75;
  level.player maps\_utility::player_speed_percent(50, 1);
  wait 0.5;
  level.player maps\_utility::player_speed_percent(100, 0.25);
}

fx_ent_think() {
  var_0 = "cave_dust";
  wait(randomfloatrange(1, 3.5));
  playFX(common_scripts\utility::getfx(var_0), self.origin, (0, 0, 1), (0, 1, 0));
  thread common_scripts\utility::play_sound_in_space("nml_rubble", self.origin - (0, 0, 32));
}

ledge_trigger_logic() {
  var_0 = common_scripts\utility::get_target_ent();

  for(;;) {
    self waittill("trigger");

    if(level.player maps\_utility::player_looking_at(var_0.origin, 0, 1))
      common_scripts\utility::flag_set("player_on_ledge");
    else
      common_scripts\utility::flag_clear("player_on_ledge");

    wait 0.1;
  }
}

player_ledge_logic() {
  for(;;) {
    common_scripts\utility::flag_wait("player_on_ledge");
    level.player disableweapons();
    level.player thread maps\_utility::player_speed_percent(15, 1);
    thread ledge_fx();
    thread ledge_quake();
    common_scripts\utility::flag_waitopen("player_on_ledge");
    level.player playersetgroundreferenceent(undefined);
    level notify("stop_ledge");
    level.player enableweapons();
    level.player thread maps\_utility::player_speed_percent(100, 1);
  }
}

ledge_quake() {
  level endon("stop_ledge");
  wait 1;

  for(;;) {
    earthquake(randomfloatrange(0.08, 0.12), randomfloatrange(1, 2), level.player.origin, 512);
    wait(randomfloatrange(0.1, 0.5));
  }
}

ledge_sway(var_0) {
  level endon("stop_ledge");
  var_0 rotatepitch(4, 5, 2, 2);
  var_0 waittill("rotatedone");

  for(;;) {
    var_0 rotatepitch(-8, 5, 2, 2);
    var_0 waittill("rotatedone");
    var_0 rotatepitch(8, 5, 2, 2);
    var_0 waittill("rotatedone");
  }
}

ledge_fx() {
  level endon("stop_ledge");
  var_0 = common_scripts\utility::getStructArray("ledge_top_fx", "targetname");
  var_1 = common_scripts\utility::getStructArray("ledge_edge_fx", "targetname");
  level.ledge_old_player_pos = level.player.origin;
  childthread ledge_track_player_pos();
  wait 2;

  for(;;) {
    level.ledge_old_player_pos = level.player.origin;
    spawn_fx_near_player(var_0, randomintrange(1, 3));
    spawn_fx_near_player(var_1, randomintrange(1, 3));
    level common_scripts\utility::waittill_notify_or_timeout("spawn_new_ledge_fx", 3);
  }
}

ledge_track_player_pos() {
  for(;;) {
    if(distance2d(level.ledge_old_player_pos, level.player.origin) > 12) {
      level notify("spawn_new_ledge_fx");
      level.ledge_old_player_pos = level.player.origin;
    }

    wait 0.05;
  }
}

spawn_fx_near_player(var_0, var_1) {
  var_2 = 0;
  var_3 = sortbydistance(var_0, level.player.origin);

  foreach(var_5 in var_0) {
    if(common_scripts\utility::cointoss()) {
      playFX(common_scripts\utility::getfx("cave_dust"), var_5.origin, (0, 0, 1), (1, 0, 0));
      var_2 = var_2 + 1;
    }

    if(var_2 >= var_1) {
      break;
    }
  }
}

wait_for_group_attack(var_0) {
  common_scripts\utility::array_thread(var_0, ::notify_ai_on_attack, self);
  self waittill("attack", var_1);
  var_0 = maps\_utility::array_removedead(var_0);
  var_0 = common_scripts\utility::array_removeundefined(var_0);
  var_0 = common_scripts\utility::array_remove(var_0, var_1);
  var_2 = 0.97;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    var_6 = level.player getEye();
    var_7 = var_5 getEye();
    var_8 = vectortoangles(var_7 - var_6);
    var_9 = anglesToForward(var_8);
    var_10 = level.player getplayerangles();
    var_11 = anglesToForward(var_10);
    var_12 = vectordot(var_9, var_11);

    if(var_12 > var_2) {
      var_3 = var_5;
      var_2 = var_12;
    }
  }

  if(isDefined(var_3))
    var_0 = common_scripts\utility::array_remove(var_0, var_3);

  wait 0.3;
  var_0 = maps\_utility::array_removedead(var_0);

  if(var_0.size > 0)
    maps\nml_stealth::stealth_shot(common_scripts\utility::random(var_0));
}

notify_ai_on_attack(var_0) {
  common_scripts\utility::waittill_either("damage", "dog_attacks_ai");
  var_0 notify("attack", self);
}

hero_follow_path_trig() {
  self waittill("trigger");
  hero_paths(self.target);
}

hero_paths(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = common_scripts\utility::getStructArray(var_0, "targetname");
  var_6 = common_scripts\utility::array_combine(var_6, getnodearray(var_0, "targetname"));

  foreach(var_8 in var_6) {
    if(isDefined(var_8.script_noteworthy)) {
      switch (var_8.script_noteworthy) {
        case "baker":
          if(!isDefined(var_2))
            var_2 = var_1;

          if(!isDefined(var_4))
            var_4 = 0;

          level.baker maps\_utility::delaythread(var_4, maps\_utility::follow_path_and_animate, var_8, var_2);
          break;
        case "cairo":
          if(!isDefined(var_3))
            var_3 = var_1;

          if(!isDefined(var_5))
            var_5 = 1.5;

          level.dog maps\_utility::delaythread(var_5, maps\_utility::follow_path_and_animate, var_8, var_3);
          break;
        case "adam":
          level.adam maps\_utility::delaythread(0.5, maps\_utility::follow_path_and_animate, var_8);
          break;
        case "merrick":
          level.merrick maps\_utility::delaythread(0, maps\_utility::follow_path_and_animate, var_8);
          break;
        case "keegan":
          level.keegan maps\_utility::delaythread(0, maps\_utility::follow_path_and_animate, var_8);
          break;
      }
    }
  }
}

hero_paths_cairo_first(var_0, var_1) {
  var_2 = common_scripts\utility::getStructArray(var_0, "targetname");
  var_2 = common_scripts\utility::array_combine(var_2, getnodearray(var_0, "targetname"));

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy)) {
      switch (var_4.script_noteworthy) {
        case "baker":
          level.baker maps\_utility::delaythread(1.5, maps\_utility::follow_path_and_animate, var_4, var_1);
          break;
        case "cairo":
          level.dog maps\_utility::delaythread(0, maps\_utility::follow_path_and_animate, var_4, var_1);
          break;
        case "adam":
          level.adam maps\_utility::delaythread(0.5, maps\_utility::follow_path_and_animate, var_4);
          break;
      }
    }
  }
}

delete_trigger() {
  for(;;) {
    self waittill("trigger", var_0);
    var_0 delete();
  }
}

link_linked_ents() {
  var_0 = common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_thread(var_0, ::parent_to_me, self);
}

parent_to_me(var_0) {
  self linkto(var_0);
  self show();
  var_0 waittill("death");
  self delete();
}

volume_waittill_no_axis(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent(var_0);

  for(;;) {
    if(volume_is_empty(var_2, var_1)) {
      break;
    }

    wait 0.2;
  }
}

volume_is_empty(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getaiarray("axis");
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(var_5 istouching(var_0)) {
      var_3 = var_3 + 1;

      if(var_3 > var_1)
        return 0;
    }
  }

  return 1;
}

moveto_rotateto(var_0, var_1, var_2, var_3) {
  self moveto(var_0.origin, var_1, var_2, var_3);
  self rotateto(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

moveto_rotateto_speed(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_7 <= 0) {
    return;
  }
  self rotateto(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveto(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

stealth_range_trigger() {
  self endon("death");

  if(!isDefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, " ");
  var_1 = [];
  var_1["prone"] = float(var_0[2]);
  var_1["crouch"] = float(var_0[1]);
  var_1["stand"] = float(var_0[0]);

  for(;;) {
    self waittill("trigger", var_2);

    if(!isDefined(var_2.rangetriggeroverride)) {
      var_2.istouchingrangetrigger = 0;
      var_2.rangetriggeroverride = 0;
    }

    if(!var_2.rangetriggeroverride) {
      while(isDefined(var_2) && var_2 istouching(self) && !var_2.rangetriggeroverride) {
        maps\_stealth_visibility_system::system_set_detect_ranges(var_1);
        var_2.istouchingrangetrigger = 1;
        wait 0.1;
      }

      if(isDefined(var_2)) {
        var_2.istouchingrangetrigger = 0;
        wait 0.2;
      }

      if(!isDefined(var_2) || !var_2.istouchingrangetrigger && !var_2.rangetriggeroverride)
        default_stealth_settings();
    }
  }
}

default_stealth_settings() {
  if(isDefined(level.default_stealth_override))
    [[level.default_stealth_override]]();
  else
    maps\_stealth_visibility_system::system_default_detect_ranges();
}

vehicle_rumble_even_if_not_moving() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;
  var_1 = undefined;

  if(isDefined(self.vehicle_rumble_unique))
    var_1 = self.vehicle_rumble_unique;
  else if(isDefined(level.vehicle_rumble_override) && isDefined(level.vehicle_rumble_override[var_0]))
    var_1 = level.vehicle_rumble_override;
  else if(isDefined(level.vehicle_rumble[var_0]))
    var_1 = level.vehicle_rumble[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkto();
  var_4 linkto(self);
  self.rumbletrigger = var_4;
  self endon("death");

  if(!isDefined(self.rumbleon))
    self.rumbleon = 1;

  if(isDefined(var_1.scale))
    self.rumble_scale = var_1.scale;
  else
    self.rumble_scale = 0.15;

  if(isDefined(var_1.duration))
    self.rumble_duration = var_1.duration;
  else
    self.rumble_duration = 4.5;

  if(isDefined(var_1.radius))
    self.rumble_radius = var_1.radius;
  else
    self.rumble_radius = 600;

  if(isDefined(var_1.basetime))
    self.rumble_basetime = var_1.basetime;
  else
    self.rumble_basetime = 1;

  if(isDefined(var_1.randomaditionaltime))
    self.rumble_randomaditionaltime = var_1.randomaditionaltime;
  else
    self.rumble_randomaditionaltime = 1;

  var_4.radius = self.rumble_radius;

  for(;;) {
    var_4 waittill("trigger");

    if(!self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1.rumble);

    while(level.player istouching(var_4) && self.rumbleon) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }

    self stoprumble(var_1.rumble);
  }
}

btr_attack_player_on_flag(var_0) {
  foreach(var_2 in self.mgturret)
  var_2 notify("stop_burst_fire_unmanned");

  maps\_vehicle::mgoff();
  self endon("death");

  for(;;) {
    common_scripts\utility::flag_wait(var_0);
    self notify("stop_random_fire");
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.baseaccuracy = 9999;
    self.favoriteenemy = level.player;

    foreach(var_2 in self.mgturret)
    var_2 thread maps\_mgturret::burst_fire_unmanned();

    thread maps\_vehicle::mgon();
    thread btr_target_player();
    common_scripts\utility::flag_waitopen(var_0);

    foreach(var_2 in self.mgturret)
    var_2 notify("stop_burst_fire_unmanned");

    self notify("stop_shooting");
  }
}

btr_target_player() {
  self endon("death");
  self endon("stop_shooting");
  self vehicle_setspeedimmediate(0.0, 5.0, 15.0);
  self setturrettargetent(level.player);
  wait 1.5;

  while(isalive(level.player)) {
    self setturrettargetent(level.player);

    if(self.model == "vehicle_btr80") {
      if(can_see_player())
        fire_at_target();
    }

    wait 0.3;
  }
}

fire_at_target() {
  var_0 = randomintrange(2, 15);
  var_1 = 0.1;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    self fireweapon();
    wait(var_1);
  }
}

can_see_player() {
  var_0 = level.player;
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0 getEye();

  if(sighttracepassed(var_1, var_2, 0, self)) {
    if(isDefined(level.debug)) {}

    return 1;
  } else
    return 0;
}

ghille_on_player() {
  level.player.ghille_top = common_scripts\utility::get_target_ent("ghille_top");
  level.player.ghille_top.animname = "grass";
  level.player.ghille_top maps\_anim::setanimtree();
  level.player.ghille_top delete();
}

dyn_dogspeed_enable(var_0) {
  self endon("death");
  self endon("dynspeed_off");

  if(isDefined(self.dyn_speed)) {
    return;
  }
  self.dyn_speed = 1;

  if(!isDefined(var_0))
    var_0 = 200;

  self.old_moveplaybackrate = self.moveplaybackrate;

  for(;;) {
    var_1 = maps\_utility_dogs::player_is_behind_me();
    var_2 = distance(self.origin, level.player.origin);

    if(!var_1 || var_2 < var_0) {
      if(self.type == "dog")
        self.moveplaybackrate = self.old_moveplaybackrate * 1.4;
      else
        self.moveplaybackrate = self.old_moveplaybackrate * 1.15;

      self.movetransitionrate = self.moveplaybackrate;
      wait 1;

      while(!maps\_utility_dogs::player_is_behind_me() || distance(self.origin, level.player.origin) < var_0)
        wait 0.1;

      self.moveplaybackrate = self.old_moveplaybackrate;
      self.movetransitionrate = self.moveplaybackrate;
      wait 5;
    }

    wait 0.3;
  }
}

dyn_dogspeed_disable() {
  self notify("dynspeed_off");

  if(isDefined(self.old_moveplaybackrate)) {
    self.moveplaybackrate = self.old_moveplaybackrate;
    self.movetransitionrate = self.moveplaybackrate;
  }

  self.old_moveplaybackrate = undefined;
  self.dyn_speed = undefined;
}

make_enemy_squad_burst(var_0, var_1) {
  level endon(var_1);
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.radio_emitter = common_scripts\utility::spawn_tag_origin();
    var_4.radio_emitter linkto(var_4, "J_SpineUpper", (0, 0, 0), (0, 0, 0));
    var_2 = common_scripts\utility::array_add(var_2, var_4.radio_emitter);
  }

  common_scripts\utility::array_thread(var_2, ::delete_on_notify, var_1);
  var_6 = randomintrange(0, level.scr_enemy_bursts.size);

  for(;;) {
    var_7 = common_scripts\utility::random(var_2);
    var_7 maps\_utility::play_sound_on_entity(level.scr_enemy_bursts[var_6]);
    var_6 = (var_6 + 1) % level.scr_enemy_bursts.size;
    wait(randomfloatrange(3, 7));
  }
}

delete_on_notify(var_0) {
  if(!isDefined(var_0))
    var_0 = "level_cleanup";

  self endon("death");
  level waittill(var_0);

  if(common_scripts\utility::flag_exist("_stealth_spotted"))
    common_scripts\utility::flag_waitopen("_stealth_spotted");

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self delete();
}

blur_pulse(var_0) {
  level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_focus");
  level.player setblurforplayer(var_0, 0.4);
  wait 0.6;
  level.player setblurforplayer(0, 0.3);
  wait 0.3;
  level.player setblurforplayer(var_0 / 2, 0.25);
  wait 0.5;
  level.player setblurforplayer(0, 0.5);
}

is_dog_attacking() {
  return isDefined(level.dog.favoriteenemy);
}

is_dog_really_attacking() {
  return isDefined(level.dog.enemy) && isDefined(level.dog.enemy.syncedmeleetarget) || isDefined(level.player.attack_indicator_on) && level.player.attack_indicator_on.alpha == 0;
}

waittill_player_lookat_on_dog(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = level.player;

  var_5 = int(var_0 * 20);
  var_6 = var_5;
  self endon("death");
  var_7 = isai(self);
  var_8 = undefined;

  for(;;) {
    if(var_7)
      var_8 = self getEye();
    else
      var_8 = self.origin;

    if(var_4 player_looking_at_on_dog(var_8, var_1, var_2, var_3)) {
      var_6--;

      if(var_6 <= 0)
        return 1;
    } else
      var_6 = var_5;

    wait 0.05;
  }
}

player_looking_at_on_dog(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_4 = maps\_utility::get_player_from_self();
  var_5 = var_4 maps\_dog_control::get_eye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

mission_fail_on_dog_death(var_0) {
  if(isDefined(level.dog) && isalive(level.dog)) {
    level.dog notify("magic_bullet_shield");
    level.dog endon("magic_bullet_shield");

    if(isDefined(level.dog.magic_bullet_shield) && level.dog.magic_bullet_shield)
      level.dog maps\_utility::stop_magic_bullet_shield();

    level.dog.health = 1;
    level.dog waittill("death", var_1);

    if(isDefined(var_1) && var_1 == level.player)
      force_deathquote(&"NML_HINT_CAIRO_DEATH_PLR");
    else if(isDefined(var_0))
      force_deathquote(var_0);
    else
      force_deathquote("");
  }

  maps\_utility::missionfailedwrapper();
}

hazmat_if_hazmat(var_0) {
  if(issubstr(self.model, "hazmat"))
    thread hazmat_think(var_0);
}

hazmat_think(var_0) {
  if(!isDefined(var_0))
    var_0 = "stand";

  self.generic_voice_override = "hazmat";
  self.ignoreall = 1;
  self.hazmat_stance = var_0;
  self.combatmode = "no_cover";
  maps\_utility::gun_remove();
  maps\_utility::set_generic_idle_anim("hazmat_" + var_0 + "_geiger_idle");
  maps\_utility::set_generic_run_anim("hazmat_walk_geiger");
  self.animname = "generic";
  self.script_animation = "hazmat";
  self attach("nml_geiger_counter", "tag_inhand", 1);
  thread drop_geiger_on_dogattack();
  self.geiger_sound_source = common_scripts\utility::spawn_tag_origin();
  self.geiger_sound_source linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self.geiger_sound_source playLoopSound("scn_nml_geiger_counter");
  thread yell_and_scream_kill();
  thread hazmat_gets_scared();
}

drop_geiger_on_dogattack() {
  self endon("death");
  self endon("geiger_drop");
  self waittill("dog_attacks_ai");
  self detach("nml_geiger_counter", "tag_inhand");
  thread maps\nml_anim::drop_geiger_counter(self);
}

hazmat_change_stance(var_0) {
  maps\_anim::anim_generic(self, "hazmat_" + self.hazmat_stance + "_2_" + var_0);
  self.hazmat_stance = var_0;
}

hazmat_gets_scared() {
  level.dog endon("death");
  self endon("death");
  self endon("dog_attacks_ai");
  thread hazmat_guy_wait_for_dog_attack();
  thread hazmat_guy_wait_for_dog_proximity();
  self waittill("runaway", var_0);
  self notify("end_patrol");
  maps\_stealth_utility::disable_stealth_for_ai();
  common_scripts\utility::waitframe();
  self.ignoreall = 1;
  thread maps\_utility::set_battlechatter(0);
  maps\_utility::set_generic_run_anim("hazmat_run");
  maps\_utility::set_generic_idle_anim("unarmed_cowercrouch_idle");
  maps\_utility::disable_turnanims();
  maps\_utility::disable_arrivals();
  maps\_utility::disable_exits();
  maps\_utility::disable_surprise();
  self.turnrate = 0.4;
  common_scripts\utility::waitframe();
  hazmat_notify_nearby_allies();
  thread hazmat_react(var_0);
  wait 1;

  if(hazmat_find_gun() == 0)
    hazmat_run_away();
  else
    thread hazmat_scared_fire();
}

hazmat_notify_nearby_allies() {
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, self.origin);

  foreach(var_2 in var_0) {
    if(var_2 != self) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_2 getenemyinfo(level.dog);
        continue;
      }

      break;
    }
  }
}

hazmat_scared_fire() {
  self endon("death");
  level.dog endon("death");
  wait 3;

  for(;;) {
    self notify("stop_yelling");
    self getenemyinfo(level.dog);
    self.goalradius = 128;
    self setgoalentity(level.dog);
    maps\_utility::clear_generic_idle_anim();
    maps\_utility::clear_generic_run_anim();
    self.ignoreall = 0;
    break;
    wait 0.05;
  }
}

hazmat_guy_wait_for_dog_attack() {
  self endon("death");
  self endon("dog_attacks_ai");
  self endon("runaway");

  for(;;) {
    level waittill("dog_attacks_ai", var_0, var_1);

    if(distance2d(var_0.origin, self.origin) < max(400, level.dog.maxvisibledist))
      self notify("runaway", var_0);
  }
}

hazmat_guy_wait_for_dog_proximity() {
  self endon("death");
  self endon("dog_attacks_ai");
  self endon("runaway");
  level.dog endon("death");

  for(;;) {
    var_0 = distance(self.velocity, (0, 0, 0));
    var_1 = distance2d(level.dog.origin, self.origin);
    var_2 = level.dog.maxvisibledist;

    if(var_1 < var_2) {
      var_3 = vectortoangles(level.dog.origin - self gettagorigin("tag_eye"));
      var_4 = anglesToForward(var_3);
      var_5 = anglesToForward(self gettagangles("tag_eye"));
      var_6 = vectordot(var_4, var_5);

      if(var_6 > 0.7) {
        break;
      }
    }

    wait 0.05;
  }

  self notify("runaway", level.dog);
}

hazmat_react(var_0) {
  self endon("death");
  self endon("dog_attacks_ai");
  self notify("end_patrol");

  if(self.type == "dog") {
    return;
  }
  var_1 = var_0.origin;
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_2);
  var_4 = vectortoangles(var_3);
  var_5 = vectortoangles(var_1 - self.origin);
  var_6 = var_4[1] - var_5[1];
  var_6 = var_6 + 360;
  var_6 = int(var_6) % 360;
  self.react_node = spawn("script_origin", self.origin);

  if(var_6 > 315 || var_6 < 45) {
    var_7 = "_B";
    self.react_node.angles = (0, var_5[1] + 0, 0);
  } else if(var_6 < 135) {
    var_7 = "_L";
    self.react_node.angles = (0, var_5[1] + 90, 0);
  } else if(var_6 < 225) {
    var_7 = "";
    self.react_node.angles = (0, var_5[1] + 0, 0);
  } else {
    var_7 = "_R";
    self.react_node.angles = (0, var_5[1] - 90, 0);
  }

  thread yell_and_scream();
  self.react_node thread maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self, "gravity", "hazmat_stand_geiger_react" + var_7);
}

yell_and_scream() {
  self endon("death");
  self endon("entitydeleted");
  self endon("dog_attacks_ai");
  maps\_utility::play_sound_on_entity("hazmat_dogstartle_enemy_1");
  self.scream_node = common_scripts\utility::spawn_tag_origin();
  self.scream_node linkto(self, "j_head", (0, 0, 0), (0, 0, 0));
  thread yell_and_scream_stop();

  for(;;) {
    yell_and_scream_think();
    wait 0.1;
  }
}

yell_and_scream_think() {
  self endon("stop_yelling");
  self.scream_node endon("death");
  self.scream_node endon("entitydeleted");

  if(isDefined(self.scream_node)) {
    self.scream_node playSound("hazmat_dogrun_enemy_1", "done_yelling");
    self.scream_node waittill("done_yelling");
  }
}

yell_and_scream_stop() {
  common_scripts\utility::waittill_any("death", "damage", "dog_attacks_ai", "stop_yelling");
  self.scream_node stopsounds();
}

yell_and_scream_kill() {
  common_scripts\utility::waittill_either("death", "stop_yelling");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self.scream_node))
    var_0 = self.scream_node;

  if(isDefined(self.geiger_sound_source)) {
    self.geiger_sound_source stopsounds();
    var_1 = self.geiger_sound_source;
  }

  wait 0.1;

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();
}

hazmat_find_gun() {
  self endon("death");
  self endon("dog_attacks_ai");

  if(!isDefined(level.pickup_guns))
    return 0;

  var_0 = sortbydistance(level.pickup_guns, self.origin);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.claimed)) {
      var_3 = distance2d(var_2.origin, self.origin);
      var_4 = distance2d(var_2.origin, level.dog.origin);

      if(var_3 <= var_4) {
        var_5 = var_2.node;
        var_2.claimed = 1;
        level.pickup_guns = common_scripts\utility::array_remove(level.pickup_guns, var_2);

        for(;;) {
          var_6 = getstartorigin(var_5.origin, var_5.angles, maps\_utility::getgenericanim("hazmat_run_2_grab_rifle_180"));
          var_5 maps\_anim::anim_generic_reach(self, "hazmat_run_2_grab_rifle_180");

          if(distance(self.origin, var_6) < 16) {
            break;
          }
        }

        var_5 thread maps\_anim::anim_generic_gravity(self, "hazmat_run_2_grab_rifle_180");
        common_scripts\utility::waitframe();
        var_2 delete();
        maps\_utility::delaythread(0.5, maps\_utility::gun_recall);
        scared_behavior();
        return 1;
      }
    }
  }

  return 0;
}

hazmat_run_away() {
  run_away_from_dog();
}

run_away_from_dog() {
  level endon("mall_run_away");
  self endon("death");
  level.dog endon("death");
  level.dog endon("");

  for(;;) {
    while(distance2d(self.origin, level.dog.origin) > 400)
      wait 0.1;

    var_0 = getnodesinradius(level.dog.origin, 1024, 600, 300);
    self.goalradius = 128;
    self setgoalnode(common_scripts\utility::random(var_0));
    self waittill("goal");
  }
}

scared_behavior() {
  maps\_utility::set_generic_run_anim("scared_walk_forward");
  maps\_utility::set_generic_idle_anim("scared_idle");
}

load_hazmat_guns(var_0) {
  if(!isDefined(level.pickup_guns))
    level.pickup_guns = [];

  var_1 = getEntArray(var_0, "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::spawn_pickup_gun);
}

delete_hazmat_guns() {
  if(!isDefined(level.pickup_guns))
    level.pickup_guns = [];

  foreach(var_1 in level.pickup_guns)
  var_1 delete();

  level.pickup_guns = [];
}

spawn_pickup_gun() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(self.model);
  var_0.animname = "gun";
  var_0 maps\_anim::setanimtree();
  var_0.node = self;
  thread maps\_anim::anim_first_frame_solo(var_0, "hazmat_run_2_grab_rifle_180");
  level.pickup_guns = common_scripts\utility::array_add(level.pickup_guns, var_0);
}

hud_outlineenable() {
  self.grenadeammo = 0;
  thread delayhudoutline(1, 0);
  thread hudoutline_wait_death();
  self endon("death");
  self waittill("dog_attacks_ai");

  if(isDefined(self)) {
    self.no_more_outlines = 1;
    self hudoutlinedisable();
  }
}

hudoutline_wait_death() {
  self waittill("death");
  wait 2.5;

  if(isDefined(self)) {
    self.no_more_outlines = 1;
    self hudoutlinedisable();
  }

  var_0 = getcorpsearray();

  foreach(var_2 in var_0)
  var_2 hudoutlinedisable();
}

delayhudoutline(var_0, var_1) {
  self endon("death");
  thread outline_off_when_far(var_1);
}

outline_off_when_far(var_0) {
  self endon("death");
  level.dog endon("death");

  for(;;) {
    while(distance2d(self.origin, level.dog.origin) > level.hudoutline_maxdist)
      wait 0.05;

    if(!isDefined(self.no_more_outlines)) {
      wait(randomfloatrange(0, 0.5));
      self hudoutlineenable(var_0, 0);
      level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");
    }

    wait 1;

    while(distance2d(self.origin, level.dog.origin) <= level.hudoutline_maxdist)
      wait 0.05;

    self hudoutlinedisable();
    wait 0.2;
  }
}

sneak_trig() {
  for(;;) {
    self waittill("trigger", var_0);

    if(var_0.type != "dog") {
      wait 0.05;
      continue;
    }

    if(issubstr(self.targetname, "enable")) {
      var_0 maps\_utility_dogs::enable_dog_sneak();
      continue;
    }

    var_0 maps\_utility_dogs::disable_dog_sneak();
  }
}

intro_heli_think() {
  common_scripts\utility::flag_set("skip_cave_cqb");
  self vehicle_turnengineoff();
  maps\_utility::play_sound_on_entity(self.script_soundalias);
}

#using_animtree("generic_human");

switch_from_cqb_to_creepwalk() {
  if(isDefined(self.cqbwalking)) {
    if(self.cqbwalking == 1) {
      maps\_utility::disable_cqbwalk();
      self.moveloopoverridefunc = ::play_move_transition;
      self.deerhunttransitionanim = % cqb_run_to_creepwalk_iw6;
      animscripts\run::endfaceenemyaimtracking();
    }
  }

  maps\_utility::set_archetype("creepwalk");
  maps\_utility::disable_turnanims();
  maps\_utility::enable_readystand();
}

switch_from_creepwalk_to_cqb() {
  maps\_utility::enable_turnanims();
  maps\_utility::enable_cqbwalk();
  maps\_utility::clear_archetype();
  maps\_utility::disable_readystand();
  self.moveloopoverridefunc = ::play_move_transition;
  self.deerhunttransitionanim = % creepwalk_to_cqb_run_iw6;
}

play_move_transition() {
  self.moveloopoverridefunc = undefined;
  self clearanim(%body, 0.2);
  self setflaggedanimknoballrestart("creepwalk_transition", self.deerhunttransitionanim, %body);
  animscripts\shared::donotetracks("creepwalk_transition");
  self clearanim(%body, 0.2);
  self.deerhunttransitionanim = undefined;
}

ragdoll_corpses() {
  var_0 = getcorpsearray();

  foreach(var_2 in var_0) {
    if(var_2 isragdoll() == 0)
      var_2 startragdoll();
  }
}

baker_noncombat() {
  level.baker clearenemy();
  level.baker.alertlevel = "noncombat";
  level.baker.a.combatendtime = gettime() - 10000;
}

group_walla(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("enemy");
    var_5 endon("damage");
    var_5 endon("dog_attacks_ai");
  }

  if(isDefined(var_3))
    level endon(var_3);

  var_7 = var_1;
  var_8 = 1;

  for(;;) {
    var_0 = common_scripts\utility::array_removeundefined(var_0);
    var_0 = maps\_utility::array_removedead(var_0);

    if(var_0.size == 0) {
      break;
    }

    var_9 = "walla_" + var_7 + "_" + var_8;

    if(isDefined(level.scr_sound["generic"][var_9])) {
      var_10 = common_scripts\utility::random(var_0);
      var_10 maps\_utility::generic_dialogue_queue(var_9);
      var_8 = var_8 + 1;
      wait(randomfloatrange(0.5, 0.9));
      continue;
    }

    var_7 = var_7 + 1;
    var_8 = 1;

    if(var_7 > var_2) {
      break;
    }
  }
}

force_deathquote(var_0) {
  if(isDefined(var_0)) {
    level notify("new_quote_string");
    setDvar("ui_deadquote", var_0);
  }
}

track_player_bark() {
  level waittill("dog_barked", var_0);
  common_scripts\utility::flag_set("player_knows_how_to_bark");
}

check_player_bark() {
  return common_scripts\utility::flag("player_knows_how_to_bark") || common_scripts\utility::flag("pc_guy_2_dead");
}

check_dog_ready_to_attack() {
  return isDefined(level.player.attack_indicator_on) && level.player.attack_indicator_on.alpha == 1;
}

check_dog_sprinting() {
  return isDefined(level.dog) && (!level.dog isdogbeingdriven() || level.dog.sprint);
}

check_player_zoom() {
  return isDefined(level.dog) && (!level.dog isdogbeingdriven() || level.dog.zoomed);
}

reactive_grass_settings() {
  setsaveddvar("r_reactiveMotionActorRadius", 40);
  setsaveddvar("r_reactiveMotionActorVelocityMax", 0.2);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 10);
  setsaveddvar("r_reactiveMotionVelocityTailScale", 0.5);
  setsaveddvar("r_reactiveMotionWindDir", (-1, 0, 1));
  setsaveddvar("r_reactiveMotionWindAreaScale", 0.5);
  thread common_scripts\_wind::wind(0.02, 0.6, 4);
}

reactive_grass_settings_pc() {
  setsaveddvar("r_reactiveMotionActorRadius", 20);
  setsaveddvar("r_reactiveMotionActorVelocityMax", 0.2);
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 20);
  setsaveddvar("r_reactiveMotionVelocityTailScale", 0.1);
  setsaveddvar("r_reactiveMotionWindDir", (-1, 0, 1));
  setsaveddvar("r_reactiveMotionWindAreaScale", 0.5);
  thread common_scripts\_wind::wind(0.02, 0.6, 4);
}

player_has_silenced_weapon() {
  var_0 = level.player getcurrentweapon();

  if(issubstr(var_0, "honeybadger") || issubstr(var_0, "silence"))
    return 1;

  return 0;
}

slide_sounds(var_0) {
  maps\_utility::play_sound_on_entity("foot_slide_npc_start");
  thread common_scripts\utility::play_loop_sound_on_entity("foot_slide_npc_loop");
  self waittillmatch("single anim", "stop_slide");
  common_scripts\utility::stop_loop_sound_on_entity("foot_slide_npc_loop");
  maps\_utility::play_sound_on_entity("foot_slide_npc_end");
}