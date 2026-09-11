/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\helicopter\cp_helicopter.gsc
***************************************************/

function heli_precache() {
  level._effect["smoke_trail"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli.vfx");
  level._effect["aerial_explosion"] = loadfx("vfx/core/expl/aerial_explosion.vfx");
  level._effect["aerial_explosion_large"] = loadfx("vfx/core/expl/aerial_explosion_heli_large.vfx");
  level._effect["chopper_sparks"] = loadfx("vfx/iw8_cp/level/cp_stk_faridah/vfx_chopper_sparks.vfx");
  level._effect["blima_rocket_flash"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_rocket_pod_launch.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

function heli_mg_create(var_0, var_1, var_2, var_3) {
  var_4 = "tag_flash";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  var_7 = self gettagorigin(var_4);

  if(!isDefined(var_1)) {
    var_1 = "sentry_minigun_mp";
  }

  if(isDefined(level.heli_minigun_override)) {
    var_1 = level.heli_minigun_override;
  }

  self.minigun = spawnturret("misc_turret", var_7, var_1);
  self.minigun.angles = self gettagangles(var_4);

  if(isDefined(var_0)) {
    self.minigun setModel(var_0);
  } else {
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(5);
  self.minigun setbottomarc(90);
  self.minigun setconvergencetime(0.05, "yaw");
  self.minigun setconvergencetime(0.05, "pitch");
  self.minigun linkTo(self, var_4, var_5, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun.chopper = self;
  thread scripts\engine\utility::delete_on_death(self.minigun);
}

function heli_dmg_sparks() {
  self endon("death");
  playFXOnTag(level._effect["smoke_trail"], self, "tag_origin");
  var_0 = 0;

  for(;;) {
    wait randomfloatrange(0.2, 3);
    playFX(level._effect["chopper_sparks"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

function heli_think_default(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("leave_area");

  if(isDefined(var_2)) {
    var_1 = scripts\engine\utility::getStructArray(var_2, "script_noteworthy")[0].origin[2];
  } else if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  }

  var_0.chopper_height = var_1;
  thread rumble_nearby_players();
  thread evasive_think(level);
  var_0.minigun setmode("manual");
  var_0.nextfiretime = gettime() + 2000;
  var_3 = 0;
  var_4 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0.needs_to_evade) {
      var_0 notify("evade");
      var_0 waittill("evasive_action_done");
      var_0.circling_target = 0;
      var_0.needs_to_evade = 0;
    }

    var_5 = heli_get_target(var_0, undefined, 0);

    if(!isDefined(var_5)) {
      wait 1;
      var_3 += 1;

      if(var_3 > var_4) {
        heli_go_search(var_0, undefined, undefined, var_2);
        var_5 = var_0.best_target;
        var_3 = 0;
      } else {
        continue;
      }
    }

    if(should_move_to_target(var_0, var_0.minigun, var_5)) {
      heli_move_to_target(var_0, var_5);
    }

    if(istrue(var_0.nocircle)) {
      thread engage_target_from_pos(var_0);
    } else {
      thread engage_target_circle_strafe(var_0, var_5);
    }

    var_0 scripts\engine\utility::ref_143ba(60, "target_engaged", "needs_to_evade");
    var_0.nocircle = 0;
  }
}

function heli_rocket_think_default(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }

  var_0 endon("death");
  var_1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  var_0.has_rockets = 1;
  var_0.chopper_height = var_1;
  thread rumble_nearby_players();

  if(!isDefined(var_0.evade_radius)) {
    var_0.evade_radius = 2000;
  }

  var_0.rockets_ready = 1;
  thread evasive_think(level);

  if(isDefined(var_0.minigun)) {
    var_0.minigun setmode("manual");
  }

  var_0.nextfiretime = gettime() + 2000;
  var_2 = 0;
  var_3 = 5;
  var_0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var_0.needs_to_evade) {
      var_0 notify("evade");
      var_0 waittill("evasive_action_done");
      var_0.circling_target = 0;
      var_0.needs_to_evade = 0;
    }

    if(istrue(var_0.force_search)) {
      heli_go_search(var_0);
      var_4 = var_0.best_target;
      var_2 = 0;
    } else {
      var_4 = heli_get_target(var_0, undefined, 0);

      if(!isDefined(var_4)) {
        wait 1;
        var_2 += 1;

        if(var_2 > var_3) {
          heli_go_search(var_0);
          var_4 = var_0.best_target;
          var_2 = 0;
        } else {
          continue;
        }
      }
    }

    if(should_move_to_target(var_0, var_0, var_4)) {
      heli_move_to_target(var_0, var_4);
    }

    if(istrue(var_0.nocircle)) {
      thread engage_target_from_pos(var_0);
    } else {
      thread engage_target_circle_strafe(var_0, var_4);
    }

    var_0 scripts\engine\utility::ref_143a5("target_engaged", "needs_to_evade");
  }
}

function heli_move_to_target(var_0) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var_0);
  var_1 = (self.gotopos[0], self.gotopos[1], self.chopper_height);

  if(distance2dsquared(self.origin, var_1) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(var_1, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(var_1, 0);
  }

  scripts\engine\utility::ref_143bb(15, "goal", "goal_reached", "near_goal");
}

function engage_target_circle_strafe(var_0, var_1) {
  self endon("needs_to_evade");
  self endon("death");
  var_0 endon("last_stand");
  var_0 endon("death_or_disconnect");
  thread circle_around_target(var_0, var_1);
  self setlookatent(var_0);

  if(isDefined(self.minigun)) {
    self.minigun settargetentity(var_0, (0, 0, 40));
  }

  var_2 = undefined;

  while(istrue(self.circling_target)) {
    var_3 = heli_can_target(var_0, (0, 0, 60));

    if(!var_3) {
      self clearlookatent();

      if(isDefined(self.rockets)) {
        var_4 = self gettagorigin("tag_rocket_left");
      } else {
        var_4 = self.minigun gettagorigin("tag_flash");
      }

      var_3 = choose_new_target(var_4);

      if(!isDefined(var_3)) {
        self notify("stop_circling");
        waitframe();
        self notify("target_engaged");
        return;
      } else {
        var_5 = 1;

        if(isDefined(self.minigun)) {
          self.minigun settargetentity(var_3);
        }

        self setlookatent(var_3);
      }
    }

    if(isDefined(self.minigun)) {
      var_4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(2, self.minigun, "turret_on_target");

      if(var_4 != "turret_on_target") {
        continue;
      }
    }

    if(istrue(self.has_rockets)) {
      if(istrue(self.rockets_ready)) {
        if(isDefined(var_3)) {
          hover_and_shoot_rockets(var_3);
        } else {
          hover_and_shoot_rockets(var_1);
        }
      }

      continue;
    }

    if(isDefined(var_3)) {
      shoot_at_target(var_3);
    } else {
      shoot_at_target(var_1);
    }

    wait randomintrange(2, 4);
  }

  self notify("target_engaged");
}

function engage_target_from_pos(var_0) {
  self endon("death");
  self sethoverparams(150, 35, 35);

  if(!istrue(self.has_rockets)) {
    self.minigun settargetentity(var_0, (0, 0, 40));
    var_1 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
  } else {
    wait 2;
  }

  if(istrue(self.has_rockets)) {
    if(istrue(self.rockets_ready)) {
      hover_and_shoot_rockets(var_0);
    }
  } else {
    shoot_at_target(var_0);
  }

  self notify("target_engaged");
  self sethoverparams(0, 0, 0);
}

function choose_new_target(var_0) {
  var_1 = 3500;

  if(isDefined(self.new_target_dist)) {
    var_1 = self.new_target_dist;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || distance2dsquared(var_0, var_4.origin) > var_2) {
      continue;
    }

    if(!heli_can_target(var_4)) {
      continue;
    }

    return var_4;
  }

  return undefined;
}

function shoot_at_target(var_0) {
  var_1 = randomintrange(20, 30);
  self.minigun startbarrelspin();
  wait 2;

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  var_2 = getcompleteweaponname("apache_turret_cp");
  var_3 = weaponfiretime(var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    self.minigun shootturret();
    wait var_3;
  }

  self.minigun stopbarrelspin();
  wait 2;
}

function shoot_rockets_at_target(var_0) {
  self endon("death");
  self endon("needs_to_evade");
  thread rocket_fire_cooldown(5);
  var_1 = 100;

  for(var_2 = 0; var_2 < 1; var_2++) {
    var_3 = var_0.origin;
    var_4 = self gettagorigin("tag_rocket_right");
    var_5 = self gettagangles("tag_rocket_right");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 += var_6;

    if(scripts\engine\utility::within_fov(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_right");
      var_9 = anglesToForward(var_5);
      var_9 *= var_1;
      var_4 += var_9;
      var_10 = "iw8_la_rpapa7_heli_cp";
      var_11 = magicbullet(var_10, var_4, var_3);

      if(isDefined(var_11)) {
        var_11.owner = self;
      }
    }

    wait 0.25;
    var_4 = self gettagorigin("tag_rocket_left");
    var_5 = self gettagangles("tag_rocket_left");
    var_6 = (0, 0, 30);
    var_7 = randomintrange(-20, 20);
    var_8 = randomintrange(-20, 20);
    var_3 = (var_3[0] + var_7, var_3[1] + var_8, var_3[2]);
    var_3 += var_6;

    if(scripts\engine\utility::within_fov(var_4, var_5, var_3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_left");
      var_9 = anglesToForward(var_5);
      var_9 *= var_1;
      var_4 += var_9;
      var_10 = "iw8_la_rpapa7_heli_cp";
      var_11 = magicbullet(var_10, var_4, var_3);

      if(isDefined(var_11)) {
        var_11.owner = self;
      }
    }

    wait 0.5;
  }

  wait 2;
}

function rocket_fire_cooldown(var_0) {
  level endon("game_ended");
  self endon("death");
  self.rockets_ready = 0;
  wait var_0;
  self.rockets_ready = 1;
}

function hover_and_shoot_rockets(var_0) {
  self endon("needs_to_evade");
  self notify("stop_circling");
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  shoot_rockets_at_target(var_0);
  self.hovering = 0;
}

function heli_get_target(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_2 = undefined;
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, level.players, undefined, undefined);

  foreach(var_5 in var_3) {
    if(!var_5 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var_5 isinfreefall()) || istrue(var_5 isskydiving()) || istrue(var_5 isparachuting())) {
      continue;
    }

    var_0 = (var_5.origin[0], var_5.origin[1], self.chopper_height);

    if(isDefined(var_5.vehicle)) {
      var_6 = [self, var_5, var_5.vehicle];
    } else {
      var_6 = [self, var_5];
    }

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
        var_2 = var_5;
        self.gotopos = var_0;
      }
    }

    if(!isDefined(var_2)) {
      var_7 = anglestoright(var_5.angles);
      var_8 = anglestoleft(var_5.angles);
      var_9 = anglesToForward(var_5.angles);
      var_10 = var_9 * -1;
      var_11 = [var_7, var_8, var_9, var_10];

      foreach(var_13 in var_11) {
        var_0 = (var_5.origin[0], var_5.origin[1], 0) + (var_13[0], var_13[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var_0, var_5.origin + (0, 0, 10), var_6)) {
          var_2 = var_5;
          self.gotopos = var_0;
          self.nocircle = 1;
          return var_2;
        }
      }
    }

    if(isDefined(var_2)) {
      break;
    }
  }

  return var_2;
}

function heli_can_target(var_0, var_1) {
  var_2 = 3500;

  if(isDefined(self.heli_can_target_dist)) {
    var_2 = self.heli_can_target_dist;
  }

  if(!var_0 scripts\cp\utility::is_valid_player() || distance2d(self.origin, var_0.origin) > var_2) {
    return false;
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_3 = self.minigun gettagorigin("tag_flash");
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var_5 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!scripts\engine\trace::ray_trace_passed(var_3 + var_1, var_5[var_6], self, var_4)) {
      continue;
    }

    return true;
  }

  return false;
}

function heli_go_search(var_0, var_1, var_2) {
  self endon("death");
  self endon("heli_alerted");

  if(isDefined(var_0)) {
    var_3 = var_0;
  } else if(isDefined(var_3)) {
    var_3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray(var_3, "script_noteworthy"));
  } else {
    var_3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("heli_search", "script_noteworthy"));
  }

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun)) {
    self.minigun cleartargetentity();
  }

  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  self setvehgoalpos(var_3.origin, 0);
  thread heli_check_players();
  scripts\engine\utility::ref_143ba(15, "goal", "goal_reached");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  for(;;) {
    self setvehgoalpos(var_4.origin, 0);
    scripts\engine\utility::ref_143ba(15, "goal", "goal_reached");
    var_4 = scripts\engine\utility::getStruct(var_4.target, "targetname");
  }
}

function heli_check_players() {
  self endon("death");
  self endon("heli_alerted");
  self endon("evade");
  self.best_target = undefined;

  for(;;) {
    var_0 = heli_get_target(undefined, 0);

    if(!isDefined(var_0)) {
      wait 1;
      continue;
    }

    break;
  }

  self vehicle_setspeed(50, 30);
  self.best_target = var_0;
  self notify("heli_alerted");
}

function evasive_think(var_0) {
  var_0 endon("death");
  jumpiftrue(isDefined(var_0.needs_to_evade)) LOC_0000001e;
  var_0.needs_to_evade = 0;

  while(var_0.health_remaining > 0) {
    var_0 waittill("evade", var_1);
    var_0.circling_target = 0;
    thread heli_evade(var_0);
    var_0 waittill("evasive_action_done");
  }
}

function should_move_to_target(var_0, var_1) {
  var_2 = 3400;

  if(isDefined(self.should_move_to_target_dist)) {
    var_2 = self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2d(var_0.origin, var_1.origin) > var_2 || isDefined(self.gotopos) && distance(var_0.origin, self.gotopos) > var_2) {
    return true;
  }

  return false;
}

function rumble_nearby_players() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

function circle_around_target(var_0, var_1) {
  self endon("evade");
  self endon("death");
  self endon("stop_circling");

  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return;
  }

  if(!isDefined(var_0.origin[0]) || !isDefined(var_0.origin[1])) {
    return;
  }

  self.circling_target = 1;
  var_2 = 1500;

  if(isDefined(self.circle_radius)) {
    var_2 = self.circle_radius;
  }

  var_3 = (var_0.origin[0], var_0.origin[1], var_1);
  var_4 = create_radius_around_point(var_3, 6, var_2);
  var_5 = 0;
  var_6 = var_4[0];
  var_7 = distance2dsquared(self.origin, var_4[0].origin);

  foreach(var_11, var_9 in var_4) {
    var_10 = distance2dsquared(self.origin, var_9.origin);

    if(var_10 < var_7) {
      var_7 = var_10;
      var_6 = var_9;
      var_5 = var_11;
    }
  }

  self.veh_goal_pos = var_4[var_5].origin;
  self setvehgoalpos(var_4[var_5].origin);
  self setneargoalnotifydist(30);
  self vehicle_setspeed(12, 10, 10);
  self.veh_speed_vals = (12, 10, 10);
  self.can_rocket_hover = 1;
  var_12 = 0;

  for(var_11 = var_5 + 1; var_12 < var_4.size - 1; var_11++) {
    while(istrue(self.hovering)) {
      wait 0.1;
    }

    if(var_11 >= var_4.size) {
      var_11 = 0;
    }

    if(!isalive(var_0)) {
      break;
    }

    var_13 = var_0.origin + (0, 0, 60);

    if(!sighttracepassed(var_4[var_11].origin, var_13, 0, undefined)) {
      wait 0.1;
      var_12++;
      var_11++;
      continue;
    }

    self.veh_goal_pos = var_4[var_11].origin;
    self setvehgoalpos(var_4[var_11].origin, 1);
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 60);
    var_12++;
  }

  self.can_rocket_hover = 0;
  self.circling_target = 0;
}

function create_radius_around_point(var_0, var_1, var_2) {
  var_3 = 360 / var_1;
  var_4 = [];
  var_5 = (1, 0, 0);
  var_6 = 0;

  while(var_6 < 360) {
    var_7 = var_5 * var_2;
    var_8 = (cos(var_6) * var_7[0] - sin(var_6) * var_7[1], sin(var_6) * var_7[0] + cos(var_6) * var_7[1], var_7[2]);
    var_9 = var_0 + var_8;
    var_10 = spawnStruct();
    var_10.origin = var_9;
    var_4 = var_10;
    var_6 += var_3;
  }

  return var_4;
}

function heli_evade(var_0) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  var_1 = 5000;

  if(isDefined(self.evade_radius)) {
    var_1 = self.evade_radius;
  }

  if(show_on_minimap(self)) {
    lootleadermarks(self);
    var_0 = (self.origin[0], self.origin[1], self.chopper_height);
  }

  var_2 = create_radius_around_point(var_0, 8, var_1);
  var_3 = 0;
  var_4 = var_2[0];
  self cleargoalyaw();
  self cleartargetyaw();
  self clearlookatent();

  foreach(var_7, var_6 in var_2) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, cos(25))) {
      var_4 = var_6;
      var_3 = var_7;
      break;
    }
  }

  self setvehgoalpos(var_2[var_3].origin, 0);
  var_8 = 1500;
  var_8 *= var_1 / 5000;
  var_9 = 100;
  var_9 *= var_1 / 5000;
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  var_10 = 0;
  var_7 = var_3 + 1;
  var_11 = randomint(4);

  while(var_10 < var_2.size - 1) {
    if(var_7 >= var_2.size) {
      var_7 = 0;
    }

    self setvehgoalpos(var_2[var_7].origin, 0);
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
    var_10++;
    var_7++;

    if(var_10 == var_11) {
      break;
    }
  }

  self notify("evasive_action_done");
}

function lootleadermarks(var_0) {
  var_1 = undefined;
  var_2 = propminigameupdateui(var_0);

  if(var_2.size > 0) {
    var_1 = scripts\engine\utility::getclosest(var_0.origin, var_2);
  } else {
    var_1 = scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getStructArray(var_0.obj_pregame, "targetname"));
  }

  var_0 setneargoalnotifydist(250);
  var_0 vehicle_setspeed(100, 50, 50);
  var_0 setvehgoalpos(var_1.origin, 0);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
}

function show_on_minimap(var_0) {
  if(!isDefined(var_0.obj_pregame)) {
    return false;
  }

  var_1 = scripts\engine\utility::getStructArray(var_0.obj_pregame, "targetname");

  if(var_1.size == 0) {
    return false;
  }

  return true;
}

function propminigameupdateui(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.obj_pregame, "targetname");
  var_3 = anglesToForward(var_0.angles);

  foreach(var_5 in var_2) {
    var_6 = vectorNormalize(var_5.origin - var_0.origin);

    if(vectordot(var_6, var_3) > 0) {
      var_1 = var_5;
    }
  }

  return var_1;
}

function setup_pilot(var_0, var_1, var_2, var_3) {
  var_4 = "tag_pilot";

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  if(!self tagexists(var_4) && self tagexists("tag_pilot1")) {
    var_4 = "tag_pilot1";
  }

  if(!self tagexists(var_4)) {
    return;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_6 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  var_7 = spawn("script_model", self gettagorigin(var_4));
  var_7 setModel("aq_pilot_fullbody_1");
  var_7 linkTo(self, var_4, var_5, var_6);
  var_7 scriptmodelplayanim("vh_mindia8_pilot_idle");
  self.pilot = var_7;

  if(istrue(var_0)) {
    thread heli_damagemonitor();
  }

  return var_7;
}

function heli_damagemonitor(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  self.health = 1000000;
  self.interaction_is_jugg_maze_button = 1;
  jumpiftrue(isDefined(var_1)) LOC_00000029;
  var_1 = 2500;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }

    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }

    if(isDefined(var_4) && isDefined(self.minigun) && var_4 == self.minigun) {
      continue;
    }

    if(isDefined(var_4) && isDefined(var_4.owner) && var_4.owner scripts\cp\utility::is_valid_player()) {
      var_4 = var_4.owner;
    }

    if(is_snipe_kill(var_4, var_6, var_12)) {
      var_2++;

      if(var_2 == 1) {
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "large");
        thread do_heli_crash(var_4);
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var_12) && isDefined(var_12.basename)) {
        switch (var_12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700) {
        var_3 = 700;
      }

      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0)) {
        scripts\engine\utility::flag_set(var_0);
      } else {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(var_12) && isDefined(var_12.basename)) {
      switch (var_12.basename) {
        case "cruise_proj_mp":
          var_3 = self.health_remaining;
          break;
        case "iw8_la_gromeo_mp":
          var_3 = int(var_1 * 0.5);
          break;
      }
    }

    if(self.health_remaining <= var_1 * 0.75) {
      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0)) {
        scripts\engine\utility::flag_set(var_0);
      }
    }

    self.health_remaining -= var_3;

    if(self.health_remaining <= var_1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= var_1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        setheadiconimage(self.headicon);
      }

      level.cashtypes = undefined;
      self.headicon = undefined;

      if(isDefined(var_12) && issubstr(var_12.basename, "molotov")) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "large");
      }

      if(isDefined(self.veh_spawn_point) && istrue(self.veh_spawn_point.in_use)) {
        thread silo_door_clip(level);
      }

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      playFX(level._effect["vfx_blima_explosion"], self.origin);

      if(istrue(self.ref_11e98)) {
        thread ref_11bd8(var_4);
        return;
      }

      thread do_heli_crash(var_4);
      return;
    }

    if(isDefined(var_4) && isPlayer(var_4)) {
      var_4 scripts\cp\cp_persistence::give_player_currency(10, "large");
    }
  }
}

function silo_door_clip(var_0) {
  level endon("game_ended");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  var_1 = var_0.veh_spawn_point;
  level waittill("timeout_wave");
  waitframe();

  if(isDefined(var_1) && istrue(var_1.in_use)) {
    var_1 scripts\cp\cp_vehicles::ref_13bb7(0);
    return;
  }
}

function do_heli_crash(var_0) {
  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  self.crash_speed = 150;
  thread crash_deathfx();
  self notify("death", var_0, "MOD_EXPLOSIVE", undefined, self.origin);
}

function ref_11bd8(var_0) {
  playFX(level._effect["helidown_rpghit"], self.origin);

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var_0);
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
  self stoploopsound();
  wait 0.15;
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  earthquake(0.45, 3, var_0 + (0, 0, -100), 1024);
  radiusdamage(var_0 + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "sniper";

  if(!ispointnearpilot(self, var_1) || !var_3) {
    return false;
  }

  return true;
}

function ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20) {
    return 1;
  }

  if(distance(var_1, var_5) <= 20) {
    return 1;
  }

  if(distance(var_1, var_6) <= 20) {
    return 1;
  }

  return 0;
}