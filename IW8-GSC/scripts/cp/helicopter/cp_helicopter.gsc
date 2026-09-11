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

function heli_mg_create(var0, var1, var2, var3) {
  var4 = "tag_flash";

  if(isDefined(var2)) {
    var4 = var2;
  }

  var5 = (0, 0, 0);

  if(isDefined(var3)) {
    var6 = var3;
  }

  var7 = self gettagorigin(var4);

  if(!isDefined(var1)) {
    var1 = "sentry_minigun_mp";
  }

  if(isDefined(level.heli_minigun_override)) {
    var1 = level.heli_minigun_override;
  }

  self.minigun = spawnturret("misc_turret", var7, var1);
  self.minigun.angles = self gettagangles(var4);

  if(isDefined(var0)) {
    self.minigun setModel(var0);
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
  self.minigun linkTo(self, var4, var5, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun.chopper = self;
  thread scripts\engine\utility::delete_on_death(self.minigun);
}

function heli_dmg_sparks() {
  self endon("death");
  playFXOnTag(level._effect["smoke_trail"], self, "tag_origin");
  var0 = 0;

  for(;;) {
    wait randomfloatrange(0.2, 3);
    playFX(level._effect["chopper_sparks"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

function heli_think_default(var0, var1, var2) {
  var0 endon("death");
  var0 endon("leave_area");

  if(isDefined(var2)) {
    var1 = scripts\engine\utility::getStructArray(var2, "script_noteworthy")[0].origin[2];
  } else if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  }

  var0.chopper_height = var1;
  thread rumble_nearby_players();
  thread evasive_think(level);
  var0.minigun setmode("manual");
  var0.nextfiretime = gettime() + 2000;
  var3 = 0;
  var4 = 5;
  var0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var0.needs_to_evade) {
      var0 notify("evade");
      var0 waittill("evasive_action_done");
      var0.circling_target = 0;
      var0.needs_to_evade = 0;
    }

    var5 = heli_get_target(var0, undefined, 0);

    if(!isDefined(var5)) {
      wait 1;
      var3 += 1;

      if(var3 > var4) {
        heli_go_search(var0, undefined, undefined, var2);
        var5 = var0.best_target;
        var3 = 0;
      } else {
        continue;
      }
    }

    if(should_move_to_target(var0, var0.minigun, var5)) {
      heli_move_to_target(var0, var5);
    }

    if(istrue(var0.nocircle)) {
      thread engage_target_from_pos(var0);
    } else {
      thread engage_target_circle_strafe(var0, var5);
    }

    var0 scripts\engine\utility::ref_143ba(60, "target_engaged", "needs_to_evade");
    var0.nocircle = 0;
  }
}

function heli_rocket_think_default(var0) {
  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  var0 endon("death");
  var1 = scripts\engine\utility::getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  var0.has_rockets = 1;
  var0.chopper_height = var1;
  thread rumble_nearby_players();

  if(!isDefined(var0.evade_radius)) {
    var0.evade_radius = 2000;
  }

  var0.rockets_ready = 1;
  thread evasive_think(level);

  if(isDefined(var0.minigun)) {
    var0.minigun setmode("manual");
  }

  var0.nextfiretime = gettime() + 2000;
  var2 = 0;
  var3 = 5;
  var0 vehicle_setspeed(50, 30);

  for(;;) {
    if(var0.needs_to_evade) {
      var0 notify("evade");
      var0 waittill("evasive_action_done");
      var0.circling_target = 0;
      var0.needs_to_evade = 0;
    }

    if(istrue(var0.force_search)) {
      heli_go_search(var0);
      var4 = var0.best_target;
      var2 = 0;
    } else {
      var4 = heli_get_target(var0, undefined, 0);

      if(!isDefined(var4)) {
        wait 1;
        var2 += 1;

        if(var2 > var3) {
          heli_go_search(var0);
          var4 = var0.best_target;
          var2 = 0;
        } else {
          continue;
        }
      }
    }

    if(should_move_to_target(var0, var0, var4)) {
      heli_move_to_target(var0, var4);
    }

    if(istrue(var0.nocircle)) {
      thread engage_target_from_pos(var0);
    } else {
      thread engage_target_circle_strafe(var0, var4);
    }

    var0 scripts\engine\utility::ref_143a5("target_engaged", "needs_to_evade");
  }
}

function heli_move_to_target(var0) {
  self endon("death");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var0);
  var1 = (self.gotopos[0], self.gotopos[1], self.chopper_height);

  if(distance2dsquared(self.origin, var1) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(var1, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(var1, 0);
  }

  scripts\engine\utility::ref_143bb(15, "goal", "goal_reached", "near_goal");
}

function engage_target_circle_strafe(var0, var1) {
  self endon("needs_to_evade");
  self endon("death");
  var0 endon("last_stand");
  var0 endon("death_or_disconnect");
  thread circle_around_target(var0, var1);
  self setlookatent(var0);

  if(isDefined(self.minigun)) {
    self.minigun settargetentity(var0, (0, 0, 40));
  }

  var2 = undefined;

  while(istrue(self.circling_target)) {
    var3 = heli_can_target(var0, (0, 0, 60));

    if(!var3) {
      self clearlookatent();

      if(isDefined(self.rockets)) {
        var4 = self gettagorigin("tag_rocket_left");
      } else {
        var4 = self.minigun gettagorigin("tag_flash");
      }

      var3 = choose_new_target(var4);

      if(!isDefined(var3)) {
        self notify("stop_circling");
        waitframe();
        self notify("target_engaged");
        return;
      } else {
        var5 = 1;

        if(isDefined(self.minigun)) {
          self.minigun settargetentity(var3);
        }

        self setlookatent(var3);
      }
    }

    if(isDefined(self.minigun)) {
      var4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(2, self.minigun, "turret_on_target");

      if(var4 != "turret_on_target") {
        continue;
      }
    }

    if(istrue(self.has_rockets)) {
      if(istrue(self.rockets_ready)) {
        if(isDefined(var3)) {
          hover_and_shoot_rockets(var3);
        } else {
          hover_and_shoot_rockets(var1);
        }
      }

      continue;
    }

    if(isDefined(var3)) {
      shoot_at_target(var3);
    } else {
      shoot_at_target(var1);
    }

    wait randomintrange(2, 4);
  }

  self notify("target_engaged");
}

function engage_target_from_pos(var0) {
  self endon("death");
  self sethoverparams(150, 35, 35);

  if(!istrue(self.has_rockets)) {
    self.minigun settargetentity(var0, (0, 0, 40));
    var1 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
  } else {
    wait 2;
  }

  if(istrue(self.has_rockets)) {
    if(istrue(self.rockets_ready)) {
      hover_and_shoot_rockets(var0);
    }
  } else {
    shoot_at_target(var0);
  }

  self notify("target_engaged");
  self sethoverparams(0, 0, 0);
}

function choose_new_target(var0) {
  var1 = 3500;

  if(isDefined(self.new_target_dist)) {
    var1 = self.new_target_dist;
  }

  var2 = var1 * var1;

  foreach(var4 in level.players) {
    if(!var4 scripts\cp\utility::is_valid_player() || distance2dsquared(var0, var4.origin) > var2) {
      continue;
    }

    if(!heli_can_target(var4)) {
      continue;
    }

    return var4;
  }

  return undefined;
}

function shoot_at_target(var0) {
  var1 = randomintrange(20, 30);
  self.minigun startbarrelspin();
  wait 2;

  if(isPlayer(var0) && var0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  var2 = getcompleteweaponname("apache_turret_cp");
  var3 = weaponfiretime(var2);

  for(var4 = 0; var4 < var1; var4++) {
    self.minigun shootturret();
    wait var3;
  }

  self.minigun stopbarrelspin();
  wait 2;
}

function shoot_rockets_at_target(var0) {
  self endon("death");
  self endon("needs_to_evade");
  thread rocket_fire_cooldown(5);
  var1 = 100;

  for(var2 = 0; var2 < 1; var2++) {
    var3 = var0.origin;
    var4 = self gettagorigin("tag_rocket_right");
    var5 = self gettagangles("tag_rocket_right");
    var6 = (0, 0, 30);
    var7 = randomintrange(-20, 20);
    var8 = randomintrange(-20, 20);
    var3 = (var3[0] + var7, var3[1] + var8, var3[2]);
    var3 += var6;

    if(scripts\engine\utility::within_fov(var4, var5, var3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_right");
      var9 = anglesToForward(var5);
      var9 *= var1;
      var4 += var9;
      var10 = "iw8_la_rpapa7_heli_cp";
      var11 = magicbullet(var10, var4, var3);

      if(isDefined(var11)) {
        var11.owner = self;
      }
    }

    wait 0.25;
    var4 = self gettagorigin("tag_rocket_left");
    var5 = self gettagangles("tag_rocket_left");
    var6 = (0, 0, 30);
    var7 = randomintrange(-20, 20);
    var8 = randomintrange(-20, 20);
    var3 = (var3[0] + var7, var3[1] + var8, var3[2]);
    var3 += var6;

    if(scripts\engine\utility::within_fov(var4, var5, var3, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, "tag_rocket_left");
      var9 = anglesToForward(var5);
      var9 *= var1;
      var4 += var9;
      var10 = "iw8_la_rpapa7_heli_cp";
      var11 = magicbullet(var10, var4, var3);

      if(isDefined(var11)) {
        var11.owner = self;
      }
    }

    wait 0.5;
  }

  wait 2;
}

function rocket_fire_cooldown(var0) {
  level endon("game_ended");
  self endon("death");
  self.rockets_ready = 0;
  wait var0;
  self.rockets_ready = 1;
}

function hover_and_shoot_rockets(var0) {
  self endon("needs_to_evade");
  self notify("stop_circling");
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(var0) && var0 scripts\cp\utility::_hasperk("specialty_covert_ops")) {
    wait 2;
  }

  shoot_rockets_at_target(var0);
  self.hovering = 0;
}

function heli_get_target(var0, var1) {
  if(!isDefined(var0)) {
    var0 = self.origin;
  }

  var2 = undefined;
  var3 = scripts\engine\utility::get_array_of_closest(var0, level.players, undefined, undefined);

  foreach(var5 in var3) {
    if(!var5 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var5 isinfreefall()) || istrue(var5 isskydiving()) || istrue(var5 isparachuting())) {
      continue;
    }

    var0 = (var5.origin[0], var5.origin[1], self.chopper_height);

    if(isDefined(var5.vehicle)) {
      var6 = [self, var5, var5.vehicle];
    } else {
      var6 = [self, var5];
    }

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var0, var5.origin + (0, 0, 10), var6)) {
        var2 = var5;
        self.gotopos = var0;
      }
    }

    if(!isDefined(var2)) {
      var7 = anglestoright(var5.angles);
      var8 = anglestoleft(var5.angles);
      var9 = anglesToForward(var5.angles);
      var10 = var9 * -1;
      var11 = [var7, var8, var9, var10];

      foreach(var13 in var11) {
        var0 = (var5.origin[0], var5.origin[1], 0) + (var13[0], var13[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var0, var5.origin + (0, 0, 10), var6)) {
          var2 = var5;
          self.gotopos = var0;
          self.nocircle = 1;
          return var2;
        }
      }
    }

    if(isDefined(var2)) {
      break;
    }
  }

  return var2;
}

function heli_can_target(var0, var1) {
  var2 = 3500;

  if(isDefined(self.heli_can_target_dist)) {
    var2 = self.heli_can_target_dist;
  }

  if(!var0 scripts\cp\utility::is_valid_player() || distance2d(self.origin, var0.origin) > var2) {
    return false;
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var3 = self.minigun gettagorigin("tag_flash");
  var4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var5 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var6 = 0; var6 < var5.size; var6++) {
    if(!scripts\engine\trace::ray_trace_passed(var3 + var1, var5[var6], self, var4)) {
      continue;
    }

    return true;
  }

  return false;
}

function heli_go_search(var0, var1, var2) {
  self endon("death");
  self endon("heli_alerted");

  if(isDefined(var0)) {
    var3 = var0;
  } else if(isDefined(var3)) {
    var3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray(var3, "script_noteworthy"));
  } else {
    var3 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("heli_search", "script_noteworthy"));
  }

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun)) {
    self.minigun cleartargetentity();
  }

  var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
  self setvehgoalpos(var3.origin, 0);
  thread heli_check_players();
  scripts\engine\utility::ref_143ba(15, "goal", "goal_reached");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  for(;;) {
    self setvehgoalpos(var4.origin, 0);
    scripts\engine\utility::ref_143ba(15, "goal", "goal_reached");
    var4 = scripts\engine\utility::getStruct(var4.target, "targetname");
  }
}

function heli_check_players() {
  self endon("death");
  self endon("heli_alerted");
  self endon("evade");
  self.best_target = undefined;

  for(;;) {
    var0 = heli_get_target(undefined, 0);

    if(!isDefined(var0)) {
      wait 1;
      continue;
    }

    break;
  }

  self vehicle_setspeed(50, 30);
  self.best_target = var0;
  self notify("heli_alerted");
}

function evasive_think(var0) {
  var0 endon("death");
  jumpiftrue(isDefined(var0.needs_to_evade)) LOC_0000001e;
  var0.needs_to_evade = 0;

  while(var0.health_remaining > 0) {
    var0 waittill("evade", var1);
    var0.circling_target = 0;
    thread heli_evade(var0);
    var0 waittill("evasive_action_done");
  }
}

function should_move_to_target(var0, var1) {
  var2 = 3400;

  if(isDefined(self.should_move_to_target_dist)) {
    var2 = self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2d(var0.origin, var1.origin) > var2 || isDefined(self.gotopos) && distance(var0.origin, self.gotopos) > var2) {
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

function circle_around_target(var0, var1) {
  self endon("evade");
  self endon("death");
  self endon("stop_circling");

  if(!isDefined(var0) || !isDefined(var0.origin)) {
    return;
  }

  if(!isDefined(var0.origin[0]) || !isDefined(var0.origin[1])) {
    return;
  }

  self.circling_target = 1;
  var2 = 1500;

  if(isDefined(self.circle_radius)) {
    var2 = self.circle_radius;
  }

  var3 = (var0.origin[0], var0.origin[1], var1);
  var4 = create_radius_around_point(var3, 6, var2);
  var5 = 0;
  var6 = var4[0];
  var7 = distance2dsquared(self.origin, var4[0].origin);

  foreach(var11, var9 in var4) {
    var10 = distance2dsquared(self.origin, var9.origin);

    if(var10 < var7) {
      var7 = var10;
      var6 = var9;
      var5 = var11;
    }
  }

  self.veh_goal_pos = var4[var5].origin;
  self setvehgoalpos(var4[var5].origin);
  self setneargoalnotifydist(30);
  self vehicle_setspeed(12, 10, 10);
  self.veh_speed_vals = (12, 10, 10);
  self.can_rocket_hover = 1;
  var12 = 0;

  for(var11 = var5 + 1; var12 < var4.size - 1; var11++) {
    while(istrue(self.hovering)) {
      wait 0.1;
    }

    if(var11 >= var4.size) {
      var11 = 0;
    }

    if(!isalive(var0)) {
      break;
    }

    var13 = var0.origin + (0, 0, 60);

    if(!sighttracepassed(var4[var11].origin, var13, 0, undefined)) {
      wait 0.1;
      var12++;
      var11++;
      continue;
    }

    self.veh_goal_pos = var4[var11].origin;
    self setvehgoalpos(var4[var11].origin, 1);
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 60);
    var12++;
  }

  self.can_rocket_hover = 0;
  self.circling_target = 0;
}

function create_radius_around_point(var0, var1, var2) {
  var3 = 360 / var1;
  var4 = [];
  var5 = (1, 0, 0);
  var6 = 0;

  while(var6 < 360) {
    var7 = var5 * var2;
    var8 = (cos(var6) * var7[0] - sin(var6) * var7[1], sin(var6) * var7[0] + cos(var6) * var7[1], var7[2]);
    var9 = var0 + var8;
    var10 = spawnStruct();
    var10.origin = var9;
    var4 = var10;
    var6 += var3;
  }

  return var4;
}

function heli_evade(var0) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  var1 = 5000;

  if(isDefined(self.evade_radius)) {
    var1 = self.evade_radius;
  }

  if(show_on_minimap(self)) {
    lootleadermarks(self);
    var0 = (self.origin[0], self.origin[1], self.chopper_height);
  }

  var2 = create_radius_around_point(var0, 8, var1);
  var3 = 0;
  var4 = var2[0];
  self cleargoalyaw();
  self cleartargetyaw();
  self clearlookatent();

  foreach(var7, var6 in var2) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var6.origin, cos(25))) {
      var4 = var6;
      var3 = var7;
      break;
    }
  }

  self setvehgoalpos(var2[var3].origin, 0);
  var8 = 1500;
  var8 *= var1 / 5000;
  var9 = 100;
  var9 *= var1 / 5000;
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  var10 = 0;
  var7 = var3 + 1;
  var11 = randomint(4);

  while(var10 < var2.size - 1) {
    if(var7 >= var2.size) {
      var7 = 0;
    }

    self setvehgoalpos(var2[var7].origin, 0);
    scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
    var10++;
    var7++;

    if(var10 == var11) {
      break;
    }
  }

  self notify("evasive_action_done");
}

function lootleadermarks(var0) {
  var1 = undefined;
  var2 = propminigameupdateui(var0);

  if(var2.size > 0) {
    var1 = scripts\engine\utility::getclosest(var0.origin, var2);
  } else {
    var1 = scripts\engine\utility::getclosest(var0.origin, scripts\engine\utility::getStructArray(var0.obj_pregame, "targetname"));
  }

  var0 setneargoalnotifydist(250);
  var0 vehicle_setspeed(100, 50, 50);
  var0 setvehgoalpos(var1.origin, 0);
  var0 scripts\engine\utility::waittill_notify_or_timeout("near_goal", 15);
}

function show_on_minimap(var0) {
  if(!isDefined(var0.obj_pregame)) {
    return false;
  }

  var1 = scripts\engine\utility::getStructArray(var0.obj_pregame, "targetname");

  if(var1.size == 0) {
    return false;
  }

  return true;
}

function propminigameupdateui(var0) {
  var1 = [];
  var2 = scripts\engine\utility::getStructArray(var0.obj_pregame, "targetname");
  var3 = anglesToForward(var0.angles);

  foreach(var5 in var2) {
    var6 = vectorNormalize(var5.origin - var0.origin);

    if(vectordot(var6, var3) > 0) {
      var1 = var5;
    }
  }

  return var1;
}

function setup_pilot(var0, var1, var2, var3) {
  var4 = "tag_pilot";

  if(isDefined(var1)) {
    var4 = var1;
  }

  if(!self tagexists(var4) && self tagexists("tag_pilot1")) {
    var4 = "tag_pilot1";
  }

  if(!self tagexists(var4)) {
    return;
  }

  var5 = (0, 0, 0);

  if(isDefined(var2)) {
    var5 = var2;
  }

  var6 = (0, 0, 0);

  if(isDefined(var3)) {
    var6 = var3;
  }

  var7 = spawn("script_model", self gettagorigin(var4));
  var7 setModel("aq_pilot_fullbody_1");
  var7 linkTo(self, var4, var5, var6);
  var7 scriptmodelplayanim("vh_mindia8_pilot_idle");
  self.pilot = var7;

  if(istrue(var0)) {
    thread heli_damagemonitor();
  }

  return var7;
}

function heli_damagemonitor(var0, var1) {
  self endon("death");
  var2 = 0;
  self.health = 1000000;
  self.interaction_is_jugg_maze_button = 1;
  jumpiftrue(isDefined(var1)) LOC_00000029;
  var1 = 2500;

  for(;;) {
    self waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16);
    self.health = 1000000;

    if(isDefined(var4) && var4 == self) {
      continue;
    }

    if(isDefined(var16) && isDefined(var16.owner) && var16.owner == self) {
      continue;
    }

    if(isDefined(var4) && isDefined(self.minigun) && var4 == self.minigun) {
      continue;
    }

    if(isDefined(var4) && isDefined(var4.owner) && var4.owner scripts\cp\utility::is_valid_player()) {
      var4 = var4.owner;
    }

    if(is_snipe_kill(var4, var6, var12)) {
      var2++;

      if(var2 == 1) {
        var4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var4 scripts\cp\cp_persistence::give_player_currency(500, "large");
        thread do_heli_crash(var4);
        return;
      }

      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var7)) {
      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var12) && isDefined(var12.basename)) {
        switch (var12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var3 = 1400;
            break;
          default:
            break;
        }
      } else if(var3 < 700) {
        var3 = 700;
      }

      if(isDefined(var0) && scripts\engine\utility::flag_exist(var0) && !scripts\engine\utility::flag(var0)) {
        scripts\engine\utility::flag_set(var0);
      } else {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(var12) && isDefined(var12.basename)) {
      switch (var12.basename) {
        case "cruise_proj_mp":
          var3 = self.health_remaining;
          break;
        case "iw8_la_gromeo_mp":
          var3 = int(var1 * 0.5);
          break;
      }
    }

    if(self.health_remaining <= var1 * 0.75) {
      if(isDefined(var0) && scripts\engine\utility::flag_exist(var0) && !scripts\engine\utility::flag(var0)) {
        scripts\engine\utility::flag_set(var0);
      }
    }

    self.health_remaining -= var3;

    if(self.health_remaining <= var1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx = 1;
    } else if(self.health_remaining <= var1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        setheadiconimage(self.headicon);
      }

      level.cashtypes = undefined;
      self.headicon = undefined;

      if(isDefined(var12) && issubstr(var12.basename, "molotov")) {
        if(isDefined(var4) && isPlayer(var4)) {
          var4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var4) && isPlayer(var4)) {
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        var4 scripts\cp\cp_persistence::give_player_currency(500, "large");
      }

      if(isDefined(self.veh_spawn_point) && istrue(self.veh_spawn_point.in_use)) {
        thread silo_door_clip(level);
      }

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      playFX(level._effect["vfx_blima_explosion"], self.origin);

      if(istrue(self.ref_11e98)) {
        thread ref_11bd8(var4);
        return;
      }

      thread do_heli_crash(var4);
      return;
    }

    if(isDefined(var4) && isPlayer(var4)) {
      var4 scripts\cp\cp_persistence::give_player_currency(10, "large");
    }
  }
}

function silo_door_clip(var0) {
  level endon("game_ended");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  var1 = var0.veh_spawn_point;
  level waittill("timeout_wave");
  waitframe();

  if(isDefined(var1) && istrue(var1.in_use)) {
    var1 scripts\cp\cp_vehicles::ref_13bb7(0);
    return;
  }
}

function do_heli_crash(var0) {
  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  self.crash_speed = 150;
  thread crash_deathfx();
  self notify("death", var0, "MOD_EXPLOSIVE", undefined, self.origin);
}

function ref_11bd8(var0) {
  playFX(level._effect["helidown_rpghit"], self.origin);

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var0);
  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
  self stoploopsound();
  wait 0.15;
  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  earthquake(0.45, 3, var0 + (0, 0, -100), 1024);
  radiusdamage(var0 + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function is_snipe_kill(var0, var1, var2) {
  var3 = isDefined(var2) && isDefined(var2.classname) && var2.classname == "sniper";

  if(!ispointnearpilot(self, var1) || !var3) {
    return false;
  }

  return true;
}

function ispointnearpilot(var0, var1) {
  var2 = anglesToForward(self.angles);
  var3 = anglestoleft(self.angles);
  var4 = self.origin + var2 * 133 + (0, 0, -70);
  var5 = self.origin + var2 * 112 + var3 * 17 + (0, 0, -70);
  var6 = self.origin + var2 * 112 + (0, 0, -50);

  if(distance(var1, var4) <= 20) {
    return 1;
  }

  if(distance(var1, var5) <= 20) {
    return 1;
  }

  if(distance(var1, var6) <= 20) {
    return 1;
  }

  return 0;
}