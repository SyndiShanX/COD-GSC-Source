/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\helicopter\cp_helicopter.gsc
******************************************************/

#using script_f603f40349f99c8;
#using scripts\common\utility;
#using scripts\cp\cp_achievement;
#using scripts\cp\damagefeedback;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\persistence;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_helicopter;

function heli_precache() {
  level._effect["smoke_trail"] = loadfx("vfx/core/smktrail/smoke_trail_white_heli.vfx");
  level._effect["aerial_explosion"] = loadfx("vfx/core/expl/aerial_explosion.vfx");
  level._effect["chopper_sparks"] = loadfx("vfx/iw8_cp/level/cp_stk_faridah/vfx_chopper_sparks.vfx");
  level._effect["blima_rocket_flash"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_rocket_pod_launch.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
}

function heli_mg_create(mg_model, turret_weapon, var_d585fc09c3d5709d, originoffset_override) {
  tag = "tag_flash";

  if(isDefined(var_d585fc09c3d5709d)) {
    tag = var_d585fc09c3d5709d;
  }

  originoffset = (0, 0, 0);

  if(isDefined(originoffset_override)) {
    origin_offset = originoffset_override;
  }

  origin = self gettagorigin(tag);

  if(!isDefined(turret_weapon)) {
    turret_weapon = "sentry_minigun_mp";
  }

  if(isDefined(level.heli_minigun_override)) {
    turret_weapon = level.heli_minigun_override;
  }

  self.minigun = spawnturret("misc_turret", origin, turret_weapon);
  self.minigun.angles = self gettagangles(tag);

  if(isDefined(mg_model)) {
    self.minigun setModel(mg_model);
  } else {
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(5);
  self.minigun setbottomarc(90);
  self.minigun setconvergencetime(0.5, "yaw");
  self.minigun setconvergencetime(0.5, "pitch");
  self.minigun.convergencetime = 0.5;
  self.minigun linkTo(self, tag, originoffset, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun.suppressiontime = 2;
  self.minigun.accuracy = 0.01;
  self.minigun.aispread = 180;
  self.minigun.chopper = self;
  thread delete_on_death(self.minigun);
}

function heli_dmg_sparks() {
  self endon("death");
  playFXOnTag(level._effect["smoke_trail"], self, "tag_origin");
  count = 0;

  while(true) {
    wait randomfloatrange(0.2, 3);
    playFX(level._effect["chopper_sparks"], self.origin + (randomintrange(-100, 100), randomintrange(-50, 50), randomintrange(-100, 0)));
  }
}

function heli_think_default(enemy_chopper, chopper_height, path_noteworthy) {
  enemy_chopper endon("death");
  enemy_chopper endon("leave_area");

  if(isDefined(path_noteworthy)) {
    chopper_height = getStructArray(path_noteworthy, "script_noteworthy")[0].origin[2];
  } else if(!isDefined(chopper_height)) {
    chopper_height = getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  }

  enemy_chopper.chopper_height = chopper_height;
  enemy_chopper thread rumble_nearby_players();
  level thread evasive_think(enemy_chopper);
  enemy_chopper.minigun setmode("manual");
  enemy_chopper.nextfiretime = gettime() + 2000;
  targettimeout = 0;
  timeout = 5;
  enemy_chopper vehicle_setspeed(50, 30);

  while(true) {
    if(enemy_chopper.needs_to_evade) {
      enemy_chopper notify("evade");
      enemy_chopper waittill("evasive_action_done");
      enemy_chopper.circling_target = 0;
      enemy_chopper.needs_to_evade = 0;
    }

    valid_target = enemy_chopper heli_get_target(undefined, 0);

    if(!isDefined(valid_target)) {
      wait 1;
      targettimeout += 1;

      if(targettimeout > timeout) {
        enemy_chopper heli_go_search(undefined, undefined, path_noteworthy);
        valid_target = enemy_chopper.best_target;
        targettimeout = 0;
      } else {
        continue;
      }
    }

    if(enemy_chopper should_move_to_target(enemy_chopper.minigun, valid_target)) {
      enemy_chopper heli_move_to_target(valid_target);
    }

    if(istrue(enemy_chopper.nocircle)) {
      enemy_chopper thread engage_target_from_pos(valid_target);
    } else {
      enemy_chopper thread engage_target_circle_strafe(valid_target, chopper_height);
    }

    enemy_chopper waittill_any_timeout_2(60, "target_engaged", "needs_to_evade");
    enemy_chopper.nocircle = 0;
  }
}

function heli_rocket_think_default(enemy_chopper) {
  if(!isDefined(enemy_chopper) || !isalive(enemy_chopper)) {
    return;
  }

  enemy_chopper endon("death");
  chopper_height = getStructArray("heli_search", "script_noteworthy")[0].origin[2];
  enemy_chopper.has_rockets = 1;
  enemy_chopper.chopper_height = chopper_height;
  enemy_chopper thread rumble_nearby_players();

  if(!isDefined(enemy_chopper.evade_radius)) {
    enemy_chopper.evade_radius = 2000;
  }

  enemy_chopper.rockets_ready = 1;
  level thread evasive_think(enemy_chopper);

  if(isDefined(enemy_chopper.minigun)) {
    enemy_chopper.minigun setmode("manual");
  }

  enemy_chopper.nextfiretime = gettime() + 2000;
  targettimeout = 0;
  timeout = 5;
  enemy_chopper vehicle_setspeed(50, 30);

  while(true) {
    if(enemy_chopper.needs_to_evade) {
      enemy_chopper notify("evade");
      enemy_chopper waittill("evasive_action_done");
      enemy_chopper.circling_target = 0;
      enemy_chopper.needs_to_evade = 0;
    }

    if(istrue(enemy_chopper.force_search)) {
      enemy_chopper heli_go_search();
      valid_target = enemy_chopper.best_target;
      targettimeout = 0;
    } else {
      valid_target = enemy_chopper heli_get_target(undefined, 0);

      if(!isDefined(valid_target)) {
        wait 1;
        targettimeout += 1;

        if(targettimeout > timeout) {
          enemy_chopper heli_go_search();
          valid_target = enemy_chopper.best_target;
          targettimeout = 0;
        } else {
          continue;
        }
      }
    }

    if(enemy_chopper should_move_to_target(enemy_chopper, valid_target)) {
      enemy_chopper heli_move_to_target(valid_target);
    }

    if(istrue(enemy_chopper.nocircle)) {
      enemy_chopper thread engage_target_from_pos(valid_target);
    } else {
      enemy_chopper thread engage_target_circle_strafe(valid_target, chopper_height);
    }

    enemy_chopper waittill_any_2("target_engaged", "needs_to_evade");
  }
}

function heli_move_to_target(target) {
  self endon("death");
  self endon("crashing");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);
  chopper_height = function_68c2534a5ea3cd2b();
  dest_vec = (self.gotopos[0], self.gotopos[1], chopper_height);

  if(distance2dsquared(self.origin, dest_vec) > 640000) {
    self setneargoalnotifydist(300);
    self vehicle_setspeed(50, 30, 30);
    self setvehgoalpos(dest_vec, 1);
  } else {
    self vehicle_setspeed(15, 12, 12);
    self setvehgoalpos(dest_vec, 0);
  }

  waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
}

function function_aebfdaba98161e9(newpos, startpos, color, radius, duration) {
  radius = default_to(radius, 400);
  duration = default_to(duration, 3);

  if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
    thread drawsphere(newpos, radius, duration, color);

    if(isDefined(startpos)) {
      thread drawline(startpos, newpos, duration, color);
    }
  }
}

function check_position(tracestartpos, newpos, heli_radius, ignorelist, trace_contents, color, return_normal) {
  obstructiontrace = sphere_trace(tracestartpos, newpos, heli_radius, ignorelist, trace_contents, undefined, 1);

  function_aebfdaba98161e9(newpos, tracestartpos, color);

  if(isDefined(obstructiontrace) && obstructiontrace["hittype"] != "hittype_none") {
    newpos = obstructiontrace["shape_position"];

    contact_normal = newpos + obstructiontrace["<dev string:x1c>"] * 75;
    function_aebfdaba98161e9(newpos, contact_normal, (0, 0, 0), 75);

    dist_change = distance(newpos, self.origin);

    if(dist_change < 200) {
      if(isDefined(return_normal)) {
        return obstructiontrace["contact_normal"];
      } else {
        wait 0.1;
        return undefined;
      }
    }
  }

  return newpos;
}

function function_2fae207f93fb45c8(var_f22a4ac7915b0164) {
  if(abs(var_f22a4ac7915b0164[0]) > 1) {
    return false;
  }

  if(abs(var_f22a4ac7915b0164[1]) > 1) {
    return false;
  }

  if(abs(var_f22a4ac7915b0164[2]) > 1) {
    return false;
  }

  return true;
}

function function_875ed67682e3f07a(target, forcestopatgoal) {
  self notify("escort_moving");
  waitframe();
  self endon("escort_moving");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("stop_circling");
  self endon("evade");
  self endon("stop_on_foot_think");
  self endon("gained_new_target");

  while(self.ishovering) {
    wait 0.25;
  }

  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(target);
  self setneargoalnotifydist(192);
  self sethoverparams(50, 1, 0.5);
  self setmaxpitchroll(20, 20);
  self setturningability(1);
  self setyawspeed(100, 40, 80, 0.05);
  ignorelist = [self, self.minigun, self.driver];
  ignorelist = array_removeundefined(ignorelist);
  trace_contents = create_contents(0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1);
  newpos = undefined;
  var_d3671915718c45cd = 0;
  self.var_a1ed01ef20c22c15 = default_to(self.var_a1ed01ef20c22c15, gettime());

  while(true) {
    while(self.ishovering) {
      wait 0.25;
    }

    tracestartpos = self.origin;
    chopper_height = function_68c2534a5ea3cd2b(target, 1550);
    initialgoalpos = (self.gotopos[0], self.gotopos[1], chopper_height);
    newpos = initialgoalpos;
    obstructed = 0;
    newpos = check_position(tracestartpos, newpos, 550, ignorelist, trace_contents, (0, 0, 1));

    if(!isDefined(newpos)) {
      obstructed = 1;
      self setneargoalnotifydist(10);

      if(var_d3671915718c45cd) {
        var_d3671915718c45cd = 0;
        newpos = self.origin + (0, 0, 500);
        newpos = check_position(tracestartpos, newpos, 500, ignorelist, trace_contents, (1, 0, 0));

        if(!isDefined(newpos)) {
          var_cb65f5b7debfecb5 = anglesToForward(self.angles) * -1;
          var_cb65f5b7debfecb5 *= 800;
          var_ba10832134e4ff63 = self.origin + var_cb65f5b7debfecb5;
          newpos = check_position(tracestartpos, var_ba10832134e4ff63, 500, ignorelist, trace_contents, (1, 0, 0.5));

          if(!isDefined(newpos)) {
            fwddir = vectorNormalize(initialgoalpos - tracestartpos);
            fwddir *= 800;
            newpos = self.origin + fwddir;
            newpos = check_position(tracestartpos, newpos, 500, ignorelist, trace_contents, (1, 0, 1), 1);

            if(function_2fae207f93fb45c8(newpos)) {
              newpos = self.origin + newpos * 100;
            }
          }
        }
      } else {
        leftdir = anglestoleft(self.angles);
        leftdir *= 800;
        leftpos = initialgoalpos + leftdir;
        leftdist = distance2d(leftpos, target.origin);
        rightdir = anglestoright(self.angles);
        rightdir *= 800;
        rightpos = initialgoalpos + rightdir;
        rightdist = distance2d(rightpos, target.origin);

        if(leftdist <= rightdist) {
          newpos = leftpos;
          otherpos = rightpos;
        } else {
          newpos = rightpos;
          otherpos = leftpos;
        }

        newpos = check_position(tracestartpos, newpos, 550, ignorelist, trace_contents, (1, 1, 0));

        if(!isDefined(newpos)) {
          newpos = check_position(tracestartpos, otherpos, 550, ignorelist, trace_contents, (1, 0.8, 0));

          if(!isDefined(newpos)) {
            newpos = initialgoalpos + (0, 0, 300);
            newpos = check_position(tracestartpos, newpos, 500, ignorelist, trace_contents, (1, 0.6, 0));

            if(!isDefined(newpos)) {
              leftpos = self.origin + leftdir;
              leftdist = distance2d(leftpos, target.origin);
              rightpos = self.origin + rightdir;
              rightdist = distance2d(rightpos, target.origin);

              if(leftdist <= rightdist) {
                newpos = leftpos;
                otherpos = rightpos;
              } else {
                newpos = rightpos;
                otherpos = leftpos;
              }

              newpos = check_position(tracestartpos, newpos, 550, ignorelist, trace_contents, (1, 0.4, 0));

              if(!isDefined(newpos)) {
                newpos = check_position(tracestartpos, otherpos, 550, ignorelist, trace_contents, (1, 0.2, 0));

                if(!isDefined(newpos)) {
                  newpos = tracestartpos;
                  var_d3671915718c45cd = 1;
                }
              }
            }
          }
        }

        dist_change = distance(newpos, self.origin);

        if(dist_change < 200) {
          var_d3671915718c45cd = 1;
        }
      }
    } else {
      var_d3671915718c45cd = 0;
    }

    if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
      if(obstructed) {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(newpos, 50, 3, (1, 0, 0));
      } else {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(newpos, 50, 3, (0, 1, 0));
      }
    }

    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    var_4d5646d8783cf8c = distance(newpos, self.origin);

    if(var_4d5646d8783cf8c > 4000 || level.player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self vehicle_setspeed(45, 45, 180);
    } else {
      self vehicle_setspeed(25, 25, 100);
    }

    self setvehgoalpos(newpos, stopatgoal);
    self.goal_pos = newpos;
    waittill_any_timeout_1(20, "goal");
    var_10adfd76e0cca943 = (gettime() - self.var_a1ed01ef20c22c15) / 1000;

    if(var_10adfd76e0cca943 < 1) {
      wait 1 - var_10adfd76e0cca943;
    }

    self.var_a1ed01ef20c22c15 = gettime();

    if(!istrue(obstructed)) {
      break;
    }

    check_hover();
  }
}

function function_35e675d08951d566() {
  while(!isDefined(self.goal_pos)) {
    waitframe();
  }

  while(true) {
    thread scripts\cp_mp\utility\debug_utility::drawsphere(self.goal_pos, 100, 0.05, (1, 1, 1));
    thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, self.goal_pos, 0.05, (1, 1, 1));
    waitframe();
  }
}

function engage_target_circle_strafe(valid_target, chopper_height) {
  self endon("needs_to_evade");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("lost_target");

  if(isDefined(self.minigun)) {
    self.minigun endon("death");
  }

  valid_target endon("last_stand");
  valid_target endon("disconnect");
  self.circling_target = 1;
  thread circle_around_target(valid_target, chopper_height);
  wait 0.1;
  self setlookatent(valid_target);

  if(isDefined(self.minigun)) {
    self.minigun settargetentity(valid_target, (0, 0, 40));
  }

  while(istrue(self.circling_target)) {
    if(isDefined(self.minigun)) {
      result = waittill_any_ents_or_timeout_return(2, self.minigun, "turret_on_target");

      if(result != "turret_on_target") {
        continue;
      }
    }

    wait 0.1;
    thread shoot_at_target(valid_target);

    while(istrue(self.shooting_minigun)) {
      wait 0.1;
    }

    wait randomintrange(2, 4);
  }

  self notify("target_engaged");
}

function engage_target_from_pos(new_target) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self sethoverparams(150, 35, 35);

  if(!istrue(self.has_rockets)) {
    self.minigun settargetentity(new_target, (0, 0, 40));
    result = waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");
  } else {
    wait 2;
  }

  if(istrue(self.has_rockets)) {
    if(istrue(self.rockets_ready)) {
      hover_and_shoot_rockets(new_target);
    }
  } else {
    shoot_at_target(new_target);
  }

  self notify("target_engaged");
  self sethoverparams(0, 0, 0);
}

function function_9b5665bac76e622f() {
  if(!istrue(self.has_rockets)) {
    return false;
  }

  if(!istrue(self.rockets_ready)) {
    return false;
  }

  if(!isDefined(level.player.vehicle)) {
    return false;
  }

  if(!time_has_passed(self.var_8218d9794907e952, 10)) {
    return false;
  }

  return true;
}

function choose_new_target(trace_pos) {
  new_target_dist = 3500;

  if(isDefined(self.new_target_dist)) {
    new_target_dist = self.new_target_dist;
  }

  var_bdd628d52f94baa9 = new_target_dist * new_target_dist;

  if(isDefined(self.var_bb5f5542e38db179)) {
    return self.var_bb5f5542e38db179;
  }

  foreach(player in level.players) {
    if(!player is_valid_player() || distance2dsquared(trace_pos, player.origin) > var_bdd628d52f94baa9) {
      continue;
    }

    if(!heli_can_target(player)) {
      continue;
    }

    return player;
  }

  return undefined;
}

function shoot_at_target(target_ent) {
  if(istrue(self.shooting_minigun)) {
    return;
  }

  self endon("death");
  self endon("crashing");
  self.minigun endon("death");
  self endon("leaving");
  muzzle_pos = self.minigun gettagorigin("tag_flash");
  muzzle_angles = self.minigun gettagangles("tag_flash");

  if(!within_fov(muzzle_pos, muzzle_angles, target_ent.origin, 0)) {
    return;
  }

  self.shooting_minigun = 1;
  var_d3a5f69cd3290f84 = 10;
  var_e614c06a26f8627e = 20;

  if(isDefined(self.var_d3a5f69cd3290f84)) {
    var_d3a5f69cd3290f84 = self.var_d3a5f69cd3290f84;
  }

  if(isDefined(self.var_e614c06a26f8627e)) {
    var_e614c06a26f8627e = self.var_e614c06a26f8627e;
  }

  numshots = randomintrange(var_d3a5f69cd3290f84, var_e614c06a26f8627e);
  self.minigun startbarrelspin();
  wait 2;

  if(isPlayer(target_ent) && target_ent _hasperk("specialty_covert_ops")) {
    wait 2;
  }

  if(!isDefined(self.var_7741cd64dd73611)) {
    if(isPlayer(target_ent)) {
      level notify("playerdamaged", target_ent, 1);
    } else if(isDefined(target_ent.owner)) {
      level notify("playerdamaged", target_ent.owner, 1);
    }

    self.var_7741cd64dd73611 = 1;
  }

  wpn = makeweapon("chopper_gunner_turret_cp");
  fire_time = weaponfiretime(wpn);

  for(i = 0; i < numshots; i++) {
    self.minigun shootturret("tag_flash", 1);
    wait fire_time;
  }

  self.minigun stopbarrelspin();
  wait 2;
  self.shooting_minigun = undefined;
}

function shoot_rockets_at_target(target, left_tag, right_tag, var_a06f14ba0bcb9459, var_f1e32db18d45a178, var_d16bbd820535e195) {
  self endon("death");
  self endon("needs_to_evade");
  self.var_8218d9794907e952 = gettime();
  fired_rockets = 0;

  if(!isDefined(left_tag)) {
    if(isDefined(self.var_daa912f2a76549f9)) {
      left_tag = self.var_daa912f2a76549f9;
    } else {
      left_tag = "tag_rocket_left";
    }
  }

  if(!isDefined(right_tag)) {
    if(isDefined(self.var_daa92cf2a7658327)) {
      right_tag = self.var_daa92cf2a7658327;
    } else {
      right_tag = "tag_rocket_right";
    }
  }

  if(!isDefined(var_a06f14ba0bcb9459)) {
    var_a06f14ba0bcb9459 = (0, 0, 0);
  }

  if(!isDefined(var_f1e32db18d45a178)) {
    var_f1e32db18d45a178 = (0, 0, 0);
  }

  forward_scalar = 100;
  num_rockets = 1;

  if(isDefined(self.var_edff35a4f2cd74e)) {
    num_rockets = self.var_edff35a4f2cd74e;
  }

  for(i = 0; i < num_rockets; i++) {
    if(isDefined(var_d16bbd820535e195)) {
      target[[var_d16bbd820535e195]](self);
    }

    end_pos = target.origin;
    start_pos = self gettagorigin(right_tag);
    start_ang = self gettagangles(right_tag) + var_f1e32db18d45a178;
    var_9bcfc72d255b4ce = (0, 0, 0);
    var_aeadb5aeb7e1e046 = randomintrange(-20, 20);
    var_f7b89ac0144d0ed3 = randomintrange(-20, 20);
    end_pos = (end_pos[0] + var_aeadb5aeb7e1e046, end_pos[1] + var_f7b89ac0144d0ed3, end_pos[2]);
    end_pos += var_9bcfc72d255b4ce;

    if(within_fov(start_pos, start_ang, end_pos, cos(45))) {
      playFXOnTag(level._effect["blima_rocket_flash"], self, right_tag);
      fwd = anglesToForward(start_ang);
      fwd *= forward_scalar;
      start_pos += fwd;
      rocket_type = "iw9_la_rpapa7_cp_hind";
      rocket = magicbullet(rocket_type, start_pos, end_pos);

      if(isDefined(rocket)) {
        rocket.owner = self;
      }

      fired_rockets = 1;
    }

    wait 0.25;
    start_pos = self gettagorigin(left_tag);
    start_ang = self gettagangles(left_tag) + var_a06f14ba0bcb9459;
    var_9bcfc72d255b4ce = (0, 0, 0);
    var_aeadb5aeb7e1e046 = randomintrange(-20, 20);
    var_f7b89ac0144d0ed3 = randomintrange(-20, 20);
    end_pos = (end_pos[0] + var_aeadb5aeb7e1e046, end_pos[1] + var_f7b89ac0144d0ed3, end_pos[2]);
    end_pos += var_9bcfc72d255b4ce;

    if(within_fov(start_pos, start_ang, end_pos, cos(45))) {
      agent_owner = undefined;

      if(istrue(self.has_attractor)) {
        agent_owner = level.agentarray[0];
      }

      playFXOnTag(level._effect["blima_rocket_flash"], self, left_tag);
      fwd = anglesToForward(start_ang);
      fwd *= forward_scalar;
      start_pos += fwd;
      rocket_type = "iw9_la_rpapa7_cp_hind";
      rocket = magicbullet(rocket_type, start_pos, end_pos, agent_owner);

      if(isDefined(rocket)) {
        rocket.owner = self;
      }

      fired_rockets = 1;
    }

    wait 0.5;
  }

  if(fired_rockets) {
    thread rocket_fire_cooldown(randomfloatrange(20, 60));
  }

  if(istrue(self.var_a2838155288f4e2d)) {
    wait self.var_a2838155288f4e2d;
    return;
  }
}

function rocket_fire_cooldown(timer) {
  level endon("game_ended");
  self endon("death");
  self.rockets_ready = 0;
  wait timer;
  self.rockets_ready = 1;
}

function hover_and_shoot_rockets(target, left_tag, right_tag, var_a06f14ba0bcb9459, var_f1e32db18d45a178, var_d16bbd820535e195) {
  self endon("needs_to_evade");
  self notify("stop_circling");
  self.circling_target = 0;
  self.hovering = 1;
  self sethoverparams(25, 15, 10);
  self vehicle_setspeed(10, 10, 10);

  if(isPlayer(target) && target _hasperk("specialty_covert_ops")) {
    wait 2;
  } else if(isDefined(level.var_823764a36756de4f)) {
    wait level.var_823764a36756de4f;
  }

  shoot_rockets_at_target(target, left_tag, right_tag, var_a06f14ba0bcb9459, var_f1e32db18d45a178, var_d16bbd820535e195);
  self.hovering = 0;
}

function heli_get_target(trace_pos, alert) {
  if(!isDefined(trace_pos)) {
    trace_pos = self.origin;
  }

  if(isDefined(self.var_bb5f5542e38db179)) {
    return self.var_bb5f5542e38db179;
  }

  closest = undefined;
  all_players = get_array_of_closest(trace_pos, level.players, undefined, undefined);

  foreach(player in all_players) {
    if(!player is_valid_player(undefined, 0) || istrue(player isinfreefall()) || istrue(player isskydiving()) || istrue(player isparachuting())) {
      continue;
    }

    chopper_height = function_68c2534a5ea3cd2b(player);
    trace_pos = (player.origin[0], player.origin[1], chopper_height);

    if(isDefined(player.vehicle)) {
      ignore_array = [self, player, player.vehicle];
    } else {
      ignore_array = [self, player];
    }

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(trace_pos, player.origin + (0, 0, 10), ignore_array)) {
        closest = player;
        self.gotopos = trace_pos;
      }
    }

    if(!isDefined(closest)) {
      r = anglestoright(player.angles);
      l = anglestoleft(player.angles);
      f = anglesToForward(player.angles);
      b = f * -1;
      tracepoints = [r, l, f, b];

      foreach(point in tracepoints) {
        trace_pos = (player.origin[0], player.origin[1], 0) + (point[0], point[1], 0) * 1800 + (0, 0, chopper_height);

        if(scripts\engine\trace::ray_trace_passed(trace_pos, player.origin + (0, 0, 10), ignore_array)) {
          closest = player;
          self.gotopos = trace_pos;
          self.nocircle = 1;
          return closest;
        }
      }
    }

    if(isDefined(closest)) {
      break;
    }
  }

  return closest;
}

function heli_can_target(target, offset) {
  can_target_dist = 3500;

  if(isDefined(self.heli_can_target_dist)) {
    can_target_dist = self.heli_can_target_dist;
  }

  player_vehicle = undefined;

  if(level.gametype == "dungeons") {
    player_vehicle = namespace_548a10c405703106::function_dc167ebe6403c4b7(undefined, self);
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1);
  } else {
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  }

  if(isPlayer(target) && !target is_valid_player() && !isDefined(player_vehicle) || distance2d(self.origin, target.origin) > can_target_dist) {
    return false;
  }

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  trace_org = self.minigun gettagorigin("tag_flash");

  if(level.gametype == "dungeons" && isDefined(player_vehicle)) {
    target = player_vehicle;
    tracepoints = [target getpointinbounds(0, 0, 0), target getpointinbounds(1, 0, 0), target getpointinbounds(-1, 0, 0)];

    for(i = 0; i < tracepoints.size; i++) {
      if(!sighttracepassed(trace_org + offset, tracepoints[i], 0, target)) {
        continue;
      }

      return true;
    }

    return false;
  }

  if(isPlayer(target) || isDefined(player_vehicle)) {
    tracepoints = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];
  } else {
    tracepoints = [target gettagorigin("tag_origin")];
  }

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(trace_org + offset, tracepoints[i], self, contents)) {
      continue;
    }

    return true;
  }

  return false;
}

function heli_go_search(start_path, build_path, path_noteworthy) {
  self endon("death");
  self endon("heli_alerted");

  if(isDefined(start_path)) {
    start_search = start_path;
  } else if(isDefined(path_noteworthy)) {
    start_search = getclosest(self.origin, getStructArray(path_noteworthy, "script_noteworthy"));
  } else {
    start_search = getclosest(self.origin, getStructArray("heli_search", "script_noteworthy"));
  }

  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun)) {
    self.minigun cleartargetentity();
  }

  next_pos = getStruct(start_search.target, "targetname");
  self setvehgoalpos(start_search.origin, 0);
  thread heli_check_players();
  waittill_any_timeout_2(15, "goal", "goal_reached");
  self vehicle_setspeed(30, 15);
  self setneargoalnotifydist(500);

  while(true) {
    self setvehgoalpos(next_pos.origin, 0);
    waittill_any_timeout_2(15, "goal", "goal_reached");
    next_pos = getStruct(next_pos.target, "targetname");
  }
}

function heli_check_players() {
  self endon("death");
  self endon("heli_alerted");
  self endon("evade");
  self.best_target = undefined;

  while(true) {
    valid_target = heli_get_target(undefined, 0);

    if(!isDefined(valid_target)) {
      wait 1;
      continue;
    }

    break;
  }

  self vehicle_setspeed(50, 30);
  self.best_target = valid_target;
  self notify("heli_alerted");
}

function evasive_think(vehicle) {
  vehicle endon("death");

  if(!isDefined(vehicle.needs_to_evade)) {
    vehicle.needs_to_evade = 0;
  }

  while(vehicle.health_remaining > 0) {
    vehicle waittill("evade", player);
    vehicle.circling_target = 0;
    chopper_height = vehicle function_68c2534a5ea3cd2b();
    vehicle thread heli_evade((vehicle.origin[0], vehicle.origin[1], chopper_height));
    vehicle waittill("evasive_action_done");
  }
}

function should_move_to_target(dist_ent, target) {
  var_18f8fc61eb07be87 = 3400;

  if(isDefined(self.should_move_to_target_dist)) {
    var_18f8fc61eb07be87 = self.should_move_to_target_dist;
  }

  if(istrue(self.landed)) {
    self.landed = undefined;
    return true;
  }

  if(distance2d(dist_ent.origin, target.origin) > var_18f8fc61eb07be87 || isDefined(self.gotopos) && distance(dist_ent.origin, self.gotopos) > var_18f8fc61eb07be87) {
    return true;
  }

  return false;
}

function rumble_nearby_players() {
  self endon("death");
  self notify("rumble_players");
  self endon("rumble_players");

  while(true) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.1;
  }
}

function function_208126a1361c976() {
  self makeentitysentient("axis", 1);
  self.var_d1f953c063dff1eb = 1;
}

function function_ecfae3fe40d58512(target_ent) {
  circle_radius = 1500;

  if(isDefined(self.circle_radius)) {
    circle_radius = self.circle_radius;
  }

  chopper_height = function_68c2534a5ea3cd2b();
  target = (target_ent.origin[0], target_ent.origin[1], chopper_height);
  points = create_radius_around_point(target, 8, circle_radius);
  start_index = 0;
  start_point = points[0];
  start_dist = distance2dsquared(self.origin, points[0].origin);

  foreach(point in points) {
    dist = distance2dsquared(self.origin, point.origin);

    if(dist < start_dist) {
      start_dist = dist;
      start_point = point;
      start_index = index;
    }
  }

  self.gotopos = points[start_index].origin;
}

function function_d7ddd4f92aa2f365() {
  self endon("death");
  self endon("crashing");
  self.ishovering = default_to(self.ishovering, 0);

  if(self.ishovering) {
    while(self.ishovering) {
      wait 0.1;
    }

    return;
  }

  player_vehicle = namespace_548a10c405703106::function_dc167ebe6403c4b7(undefined, self);

  if(isDefined(player_vehicle)) {
    return;
  }

  self.var_4c9ec1894f2acd2c = default_to(self.var_4c9ec1894f2acd2c, gettime());
  self.var_f1ec5b0e3c5e83e2 = default_to(self.var_f1ec5b0e3c5e83e2, (0, 0, 0));
  self.var_35e5c4d85b393e70 = default_to(self.var_35e5c4d85b393e70, 0);
  self.var_35e5c4d85b393e70++;
  var_65c5443c57d5a3c0 = distance(self.origin, self.var_f1ec5b0e3c5e83e2);
  var_6bd149235314dd38 = gettime() - self.var_4c9ec1894f2acd2c;

  if(self.var_35e5c4d85b393e70 > 10 && var_65c5443c57d5a3c0 > 2000 || var_6bd149235314dd38 >= 30000) {
    var_2d58e8aae155cc83 = distance(self.origin, level.player.origin);

    if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
      iprintlnbold(var_2d58e8aae155cc83);
    }

    if(var_2d58e8aae155cc83 < 3500) {
      target_eye = level.player.origin + (0, 0, 60);

      if(!sighttracepassed(self.origin, target_eye, 0, self, self.minigun)) {
        if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
          thread drawline(self.origin, target_eye, 3, (1, 0, 0), 1);
          thread drawsphere(target_eye, 50, 3, (1, 0, 0));
        }

        return;
      }

      ignorelist = [self, self.minigun, self.driver];
      trace_contents = create_contents(0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0);
      obstructiontrace = sphere_trace(self.origin, self.origin + (0, 0, 0.1), 600, ignorelist, trace_contents, undefined, 1);

      if(isDefined(obstructiontrace) && obstructiontrace["hittype"] != "hittype_none") {
        if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
          thread drawsphere(self.origin, 600, 3, (0, 0, 0));
        }

        return;
      }

      self.ishovering = 1;
      self.var_35e5c4d85b393e70 = 0;
      var_a7b02b73babd3b09 = randomintrange(8, 11);
      self.var_f1ec5b0e3c5e83e2 = self.origin;
      self vehicle_setspeed(10, 20, 30);
      self sethoverparams(80, 10, 5);

      if(getdvarint(@ "hash_b829e1e0eacd17a4", 0)) {
        thread drawsphere(self.origin, 600, var_a7b02b73babd3b09, (1, 1, 1));
      }

      wait var_a7b02b73babd3b09;

      if(!isDefined(self)) {
        return;
      }

      self.var_4c9ec1894f2acd2c = gettime();
      self.ishovering = 0;
    }
  }
}

function check_hover() {
  thread function_d7ddd4f92aa2f365();
}

function circle_around_target(target_ent, chopper_height) {
  self.circling_target = 1;
  self notify("circling_around_target_single");
  waitframe();
  self endon("circling_around_target_single");
  self endon("evade");
  self endon("death");
  self endon("stop_circling");
  self endon("crashing");
  circle_radius = 1700;

  if(isDefined(self.circle_radius)) {
    circle_radius = self.circle_radius;
  }

  chopper_height = function_68c2534a5ea3cd2b();
  target = (target_ent.origin[0], target_ent.origin[1], chopper_height);
  points = create_radius_around_point(target, 8, circle_radius, cointoss());
  start_index = 0;
  start_point = points[0];
  start_dist = distance2dsquared(self.origin, points[0].origin);
  var_21b02722c4d3f5f8 = target;

  foreach(index, point in points) {
    dist = distance2dsquared(self.origin, point.origin);

    if(dist < start_dist) {
      start_dist = dist;
      start_point = point;
      start_index = index;
    }
  }

  if(level.gametype == "dungeons") {
    self.gotopos = points[start_index].origin;
    thread function_875ed67682e3f07a(target_ent, 1);
  } else {
    self setvehgoalpos(points[start_index].origin);
    self.goalpos = points[start_index].origin;
  }

  self setneargoalnotifydist(192);

  if(isDefined(self.circlespeed)) {
    self vehicle_setspeed(self.circlespeed, self.var_f9ff3a209aa9db43, self.var_434136cad96e6f3a);
  } else {
    self vehicle_setspeed(12, 10, 10);
  }

  self.veh_speed_vals = (12, 10, 10);
  self.can_rocket_hover = 1;
  numpoints = 0;

  for(index = start_index + 1; numpoints < points.size - 1; index++) {
    while(istrue(self.hovering)) {
      wait 0.1;
    }

    if(index >= points.size) {
      index = 0;
    }

    target_eye = target_ent.origin + (0, 0, 60);
    player_vehicle = undefined;

    if(level.gametype == "dungeons") {
      player_vehicle = namespace_548a10c405703106::function_dc167ebe6403c4b7(undefined, self);
    }

    points[index].origin = function_16ea97d790526a42(points[index], var_21b02722c4d3f5f8, target_ent.origin, self);

    if(!sighttracepassed(points[index].origin, target_eye, 0, undefined) && !isDefined(player_vehicle)) {
      function_aebfdaba98161e9(target_eye, points[index].origin, (1, 0, 0), 100, 15);

      wait 0.1;
      numpoints++;
      index++;
      continue;
    }

    if(level.gametype == "dungeons") {
      self.gotopos = points[index].origin;
      function_875ed67682e3f07a(target_ent, 1);
      thread check_hover();
    } else {
      self setvehgoalpos(points[index].origin, 0);
      self.goalpos = points[start_index].origin;
      waittill_notify_or_timeout("near_goal", 60);
    }

    numpoints++;
  }

  self.can_rocket_hover = 0;
  self.circling_target = 0;
}

function function_16ea97d790526a42(point, var_21b02722c4d3f5f8, var_289d4e9a10d08e63, heli) {
  point_pos = point.origin;
  x_change = var_289d4e9a10d08e63[0] - var_21b02722c4d3f5f8[0];
  y_change = var_289d4e9a10d08e63[1] - var_21b02722c4d3f5f8[1];
  updated_pos = (point_pos[0] + x_change, point_pos[1] + y_change, var_289d4e9a10d08e63[2]);
  point.origin = updated_pos;
  z = heli function_68c2534a5ea3cd2b(point);
  updated_pos = (updated_pos[0], updated_pos[1], z);
  return updated_pos;
}

function create_radius_around_point(point, num_positions, path_radius, reverse_dir) {
  degs_per_pos = 360 / num_positions;
  positions = [];
  fwd = (1, 0, 0);
  i = 0;

  while(i < 360) {
    altforward = fwd * path_radius;
    rotated_forward = (cos(i) * altforward[0] - sin(i) * altforward[1], sin(i) * altforward[0] + cos(i) * altforward[1], altforward[2]);
    pos = point + rotated_forward;
    position = spawnStruct();
    position.origin = pos;
    z = function_68c2534a5ea3cd2b();
    position.origin = (position.origin[0], position.origin[1], z);
    positions[positions.size] = position;
    i += degs_per_pos;
  }

  if(istrue(reverse_dir)) {
    positions = array_reverse(positions);
  }

  return positions;
}

function heli_evade(target) {
  self notify("taking_evasive_actions");
  self endon("taking_evasive_actions");
  self endon("death");
  rad = 5000;

  if(isDefined(self.evade_radius)) {
    rad = self.evade_radius;
  }

  if(have_custom_evade_start(self)) {
    do_custom_evade_start(self);
    chopper_height = function_68c2534a5ea3cd2b();
    target = (self.origin[0], self.origin[1], chopper_height);
  }

  points = create_radius_around_point(target, 8, rad);
  start_index = 0;
  start_point = points[0];
  self cleargoalyaw();
  self cleartargetyaw();
  self clearlookatent();

  foreach(index, point in points) {
    if(within_fov(self.origin, self.angles, point.origin, cos(25))) {
      start_point = point;
      start_index = index;
      break;
    }
  }

  self setvehgoalpos(points[start_index].origin, 0);
  notify_dist = 1500;
  notify_dist *= rad / 5000;
  heli_speed = 100;
  heli_speed *= rad / 5000;
  self setneargoalnotifydist(1500);
  self vehicle_setspeed(100, 50, 50);
  numpoints = 0;
  index = start_index + 1;
  random_num = randomint(4);

  while(numpoints < points.size - 1) {
    if(index >= points.size) {
      index = 0;
    }

    self setvehgoalpos(points[index].origin, 0);
    waittill_notify_or_timeout("near_goal", 15);
    numpoints++;
    index++;

    if(numpoints == random_num) {
      break;
    }
  }

  self notify("evasive_action_done");
}

function do_custom_evade_start(heli) {
  var_679126dd7a6b091b = undefined;
  evade_start_structs_in_front = get_evade_start_structs_in_front(heli);

  if(evade_start_structs_in_front.size > 0) {
    var_679126dd7a6b091b = scripts\engine\utility::getclosest(heli.origin, evade_start_structs_in_front);
  } else {
    var_679126dd7a6b091b = scripts\engine\utility::getclosest(heli.origin, scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname"));
  }

  heli setneargoalnotifydist(250);
  heli vehicle_setspeed(100, 50, 50);
  heli setvehgoalpos(var_679126dd7a6b091b.origin, 0);
  heli waittill_notify_or_timeout("near_goal", 15);
}

function have_custom_evade_start(heli) {
  if(!isDefined(heli.evade_start_targetname)) {
    return false;
  }

  var_2f41e1143965afb8 = scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname");

  if(var_2f41e1143965afb8.size == 0) {
    return false;
  }

  return true;
}

function get_evade_start_structs_in_front(heli) {
  assertex(isDefined(heli.evade_start_targetname), "<dev string:x2b>");
  results = [];
  var_2f41e1143965afb8 = scripts\engine\utility::getStructArray(heli.evade_start_targetname, "targetname");
  heli_forward = anglesToForward(heli.angles);

  foreach(var_679126dd7a6b091b in var_2f41e1143965afb8) {
    var_4e20552f0e10666 = vectorNormalize(var_679126dd7a6b091b.origin - heli.origin);

    if(vectordot(var_4e20552f0e10666, heli_forward) > 0) {
      results[results.size] = var_679126dd7a6b091b;
    }
  }

  return results;
}

function setup_pilot(var_ec2e74a36772e6a1, tag_override, pos_override, ang_override) {
  tag_pilot = "tag_pilot";

  if(isDefined(tag_override)) {
    tag_pilot = tag_override;
  }

  if(!self tagexists(tag_pilot) && self tagexists("tag_pilot1")) {
    tag_pilot = "tag_pilot1";
  }

  if(!self tagexists(tag_pilot)) {
    assertmsg("<dev string:x5c>" + tag_pilot);
    return;
  }

  org_offset = (0, 0, 0);

  if(isDefined(pos_override)) {
    org_offset = pos_override;
  }

  ang_offset = (0, 0, 0);

  if(isDefined(ang_override)) {
    ang_offset = ang_override;
  }

  pilot = spawn("script_model", self gettagorigin(tag_pilot));
  pilot setModel("aq_pilot_fullbody_1");
  pilot linkTo(self, tag_pilot, org_offset, ang_offset);
  pilot scriptmodelplayanim("vh_mindia8_pilot_idle");
  self.pilot = pilot;

  if(istrue(var_ec2e74a36772e6a1)) {
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
  }

  return pilot;
}

function heli_damagemonitor(var_227a4202bbfa2f79, starting_health, var_4b35c4051d5ddc1d) {
  self endon("death");
  snipes = 0;
  self.health = 1000000;
  self.custom_damage_handler = 1;

  if(!isDefined(starting_health)) {
    starting_health = 2500;
  }

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 1000000;

    if(isDefined(self.var_2c72dd1407c28de0) && isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "rocketlauncher") {
      continue;
    }

    if(isDefined(attacker) && attacker == self) {
      continue;
    }

    if(isDefined(inflictor) && isDefined(inflictor.owner) && inflictor.owner == self) {
      continue;
    }

    if(isDefined(attacker) && isDefined(self.minigun) && attacker == self.minigun) {
      continue;
    }

    if(isDefined(attacker) && isDefined(attacker.owner) && attacker.owner is_valid_player()) {
      attacker = attacker.owner;
    }

    if(!(level.mapname == "cp_jup_apt") && is_snipe_kill(attacker, dmgpoint, objweapon)) {
      snipes++;

      if(snipes == 1) {
        eventinfo = spawnStruct();
        eventinfo.isdestroyedkillstreak = 1;
        attacker thread scripts\cp\points::doscoreevent(#"hash_f88a0d21a577aa90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo);
        attacker scripts\cp\persistence::give_player_currency(500, "large");

        if(istrue(self.nocrash)) {
          thread mid_air_explode(attacker);
          return;
        }

        thread do_heli_crash(attacker);
        return;
      }

      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitvehcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitvehstandard");
    } else {
      attacker.lasthitmarkertime = undefined;
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitvehcritical");

      if(isDefined(objweapon) && isDefined(objweapon.basename)) {
        switch (objweapon.basename) {
          case #"hash_f59a8f678401aee2":
            break;
          case #"hash_c7ce3f77814f7950":
            amount = 1400;
            break;
          default:
            break;
        }
      } else if(amount < 700) {
        amount = 700;
      }

      if(isDefined(var_227a4202bbfa2f79) && flag_exist(var_227a4202bbfa2f79) && !flag(var_227a4202bbfa2f79)) {
        flag_set(var_227a4202bbfa2f79);
      } else if(!istrue(self.no_evasive)) {
        if(!istrue(self.needs_to_evade)) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      switch (objweapon.basename) {
        case #"hash_1a8f43f197f508a0":
        case #"hash_24936ab5bf8a0e20":
          amount = max(amount, 600);
          break;
        case #"hash_80d39fa6a58bf503":
        case #"hash_85ea99fcbe4116a4":
        case #"hash_d4d7a51a23d22720":
          amount = self.health_remaining;
          break;
        case #"hash_3e782fd775b72022":
        case #"hash_a9e31b8ffd42a67b":
          amount = self.health_remaining;
          break;
        case #"hash_a86d4075406d2de4":
          amount = min(amount, 400);
          break;
        case #"hash_d30bcd7e470500f3":
          amount = min(amount, 260);
          break;
      }
    }

    if(self.health_remaining <= starting_health * 0.75) {
      if(isDefined(var_227a4202bbfa2f79) && flag_exist(var_227a4202bbfa2f79) && !flag(var_227a4202bbfa2f79)) {
        flag_set(var_227a4202bbfa2f79);
      }
    }

    if(isbulletdamage(meansofdeath)) {
      amount = min(15, amount);

      if(isDefined(var_4b35c4051d5ddc1d)) {
        amount = var_4b35c4051d5ddc1d;
      }
    }

    self.health_remaining -= amount;

    if(self.health_remaining <= starting_health * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);

      if(self getscriptablehaspart("body_damage_heavy")) {
        self setscriptablepartstate("body_damage_heavy", "on", 1);
      } else if(self getscriptablehaspart("damageHeavy")) {
        self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
      }

      self.deathfx = 1;
    } else if(self.health_remaining <= starting_health * 0.5 && !isDefined(self.deathfx1)) {
      if(self getscriptablehaspart("body_damage_medium")) {
        self setscriptablepartstate("body_damage_medium", "on", 1);
      } else if(self getscriptablehaspart("damageMedium")) {
        self setscriptablepartstate("damageMedium", "lowSpeed", 1);
      }

      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= starting_health * 0.75 && !isDefined(self.deathfx2)) {
      if(self getscriptablehaspart("body_damage_light")) {
        self setscriptablepartstate("body_damage_light", "on", 1);
      } else if(self getscriptablehaspart("damageLight")) {
        self setscriptablepartstate("damageLight", "lowSpeed", 1);
      }

      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon)) {
        deleteheadicon(self.headicon);
      }

      level.attack_heli = undefined;
      self.headicon = undefined;

      if(isDefined(attacker) && isPlayer(attacker)) {
        eventinfo = spawnStruct();
        eventinfo.isdestroyedkillstreak = 1;
        attacker thread scripts\cp\points::doscoreevent(#"hash_f88a0d21a577aa90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo);
        attacker scripts\cp\persistence::give_player_currency(500, "large");
      }

      level.all_spawned_vehicles = array_remove(level.all_spawned_vehicles, self);
      attacker scripts\cp\damagefeedback::updatedamagefeedback("hitvehcritical", 1);
      level notify("heli_down", self, attacker);
      playFX(level._effect["vfx_blima_explosion"], self.origin);

      if(istrue(self.nocrash)) {
        thread mid_air_explode(attacker);
      } else {
        thread do_heli_crash(attacker);
      }

      level.players[0] scripts\cp\cp_achievement::function_1798ae18b940195a(objweapon);
      return;
    }

    if(isDefined(attacker) && isPlayer(attacker) && !istrue(self.var_1f6f35745b7f63fe)) {
      attacker scripts\cp\persistence::give_player_currency(10, "large");
    }
  }
}

function do_heli_crash(attacker) {
  if(isDefined(self.var_78da61277c9dee0a)) {
    self[[self.var_78da61277c9dee0a]](attacker);
    return;
  }

  self notify("crashing");

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  self.crash_speed = 150;
  thread crash_deathfx();

  if(istrue(self.auto_crash)) {
    position = anglestoright(self.angles) * randomintrange(-500, 500);
    groundpos = getgroundposition(self.origin + position, 128);
    pos = spawnStruct();
    pos.origin = groundpos;
    pos.angles = (0, 0, 0);
    level.helicopter_crash_locations[level.helicopter_crash_locations.size] = pos;
  }

  self notify("death", attacker, "MOD_EXPLOSIVE", undefined, self.origin);
}

function mid_air_explode(attacker) {
  if(isDefined(self.var_eae10920b9197a32)) {
    self[[self.var_eae10920b9197a32]](attacker);
    return;
  }

  playFX(level._effect["helidown_rpghit"], self.origin);

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}

function crash_deathfx(var_2910a48f23770a55) {
  crash_origin = self.origin;

  if(!istrue(var_2910a48f23770a55)) {
    self waittill("vehicle_deathComplete", crash_origin);
  }

  playFX(level._effect["vfx_blima_explosion"], crash_origin + (0, 0, -100));
  playsoundatpos(crash_origin, "cp_br_syrk_chopper_crash");

  if(isDefined(self)) {
    self stoploopsound();
  }

  wait 0.15;
  playFX(level._effect["vfx_blima_explosion"], crash_origin + (0, 0, -100));
  earthquake(0.45, 3, crash_origin + (0, 0, -100), 1024);
  radiusdamage(crash_origin + (0, 0, -100), 1024, 500, 50);

  if(isDefined(self)) {
    if(isDefined(self.pilot)) {
      self.pilot delete();
    }

    self delete();
  }
}

function is_snipe_kill(attacker, dmgpoint, objweapon) {
  is_sniper = isDefined(objweapon) && isDefined(objweapon.classname) && objweapon.classname == "sniper";

  if(!ispointnearpilot(self, dmgpoint) || !is_sniper) {
    return false;
  }

  return true;
}

function ispointnearpilot(heli, dmgpoint) {
  fwd = anglesToForward(self.angles);
  left = anglestoleft(self.angles);
  point1 = self.origin + fwd * 133 + (0, 0, -70);
  point2 = self.origin + fwd * 112 + left * 17 + (0, 0, -70);
  var_bf69da3c5a539d7a = self.origin + fwd * 112 + (0, 0, -50);

  if(distance(dmgpoint, point1) <= 25) {
    return 1;
  }

  if(distance(dmgpoint, point2) <= 25) {
    return 1;
  }

  if(distance(dmgpoint, var_bf69da3c5a539d7a) <= 25) {
    return 1;
  }

  return 0;
}

function function_68c2534a5ea3cd2b(target_ent, height_offset) {
  height_offset = default_to(height_offset, 1000);
  var_fe6f01b34661f92a = (0, 0, 1000);

  if(isDefined(self.var_6f81c60ba2b5b081)) {
    var_fe6f01b34661f92a = self.var_6f81c60ba2b5b081;
  }

  if(isDefined(self.chopper_height)) {
    chopper_height = self.chopper_height;
  }

  if(isDefined(target_ent)) {
    chopper_height = getgroundposition(target_ent.origin + (0, 0, 10), 4) + var_fe6f01b34661f92a;
  } else {
    chopper_height = getgroundposition(self.origin, 128, 10000, 2000) + (0, 0, 1000);
  }

  if(isvector(chopper_height)) {
    return chopper_height[2];
  }

  return chopper_height;
}

function function_d025dd1f241613d6(heli) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  level.special_lockon_target_list[level.special_lockon_target_list.size] = heli;
}

function function_1f281293e100467(heli) {
  if(!isDefined(level.killstreak_additional_targets)) {
    level.killstreak_additional_targets = [];
  }

  level.killstreak_additional_targets[level.killstreak_additional_targets.size] = heli;
}

function function_29d0c931ff7731cd(heli) {
  position = anglestoright(heli.angles) * randomintrange(-500, 500);
  groundpos = getgroundposition(heli.origin + position + (0, 0, -100), 128);
  pos = spawnStruct();
  pos.origin = groundpos;
  pos.angles = (0, 0, 0);
  return pos;
}

function function_b7e4041a3c02d74a() {
  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos) && istrue(rider._blackboard.var_41c9f8c7891f19da)) {
        var_adf3664b12362142 = 500;
        velocity = self vehicle_getvelocity();
        rider.do_immediate_ragdoll = 1;
        rider.ragdollhitloc = "torso_lower";
        rider.ragdollimpactvector = (rider.origin - self.origin) * var_adf3664b12362142 + velocity;
        rider._blackboard.var_80912ec8ade08716 = 1;
      }

      rider kill();
    }
  }

  thread crash_deathfx(1);
}

function heli_spotlight_create(spotlight_model, tagname, turret_info) {
  tag = "tag_flash";

  if(isDefined(tagname)) {
    tag = tagname;
  }

  if(!isDefined(turret_info)) {
    turret_info = "sentry_minigun_mp";
  }

  originoffset = (0, 0, -10);
  origin = self gettagorigin(tag);
  self.spotlight = spawnturret("misc_turret", origin, turret_info);
  self.spotlight.angles = self gettagangles(tag);

  if(isDefined(spotlight_model)) {
    self.spotlight setModel(spotlight_model);
  } else {
    self.spotlight setModel("com_blackhawk_spotlight_on_mg_setup");
  }

  self.spotlight linkTo(self, tag, originoffset, (0, 0, 0));
  self.spotlight setturretteam("axis");
  self.spotlight setmode("auto_nonai");
  self.spotlight setdefaultdroppitch(0);
  self.spotlight setleftarc(360);
  self.spotlight setrightarc(360);
  self.spotlight settoparc(180);
  self.spotlight setbottomarc(180);
  self.spotlight setconvergencetime(0.05, "yaw");
  self.spotlight setconvergencetime(0.05, "pitch");
  self.spotlight.target_ent = spawn_tag_origin();
  self.spotlight.target_ent show();
  self.spotlight.active = 0;
  self.spotlight.isdead = 0;
  thread delete_on_death(self.spotlight.target_ent);
}

function heli_spotlight_toggle(bool) {
  if(self.spotlight.isdead) {
    bool = 0;
  }

  if(bool && !self.spotlight.active) {
    playFXOnTag(getfx("chopper_spotlight"), self.spotlight, "tag_flash");
    self.spotlight.active = 1;
    return;
  }

  if(!bool && self.spotlight.active) {
    stopFXOnTag(getfx("chopper_spotlight"), self.spotlight, "tag_flash");
    self.spotlight.active = 0;
  }
}

function function_c1150d781d01adc8(heli, team_override) {
  if(!isDefined(team_override)) {
    if(isDefined(heli.team)) {
      team_override = heli.team;
    } else {
      team_override = "axis";
    }
  }

  heli make_entity_sentient_cp(team_override, 1);

  if(!threatbiasgroupexists("ai_chopper")) {
    createthreatbiasgroup("ai_chopper");
  }

  heli setthreatbiasgroup("ai_chopper");
  setthreatbias("axis", "ai_chopper", 700);
  setthreatbias("axis", "player1", 100);
  setthreatbias("axis", "player2", 100);
  setthreatbias("axis", "player3", 100);
  setthreatbias("axis", "player4", 100);
  heli thread function_a93ae188109e749c();
}

function function_a93ae188109e749c() {
  self endon("game_ended");
  self endon("death");
  self.heli_targets = [];
  var_4434ed09eb800de9 = anglestoaxis(self.angles);

  foreach(axis_heli in var_4434ed09eb800de9) {
    i = -1;

    while(i < 2) {
      heli_target = spawn_tag_origin();
      heli_target setModel("tag_origin_only_collision");
      heli_target makeentitysentient("allies");
      heli_target.origin = self getEye() + i * axis_heli * 450;
      heli_target linkTo(self);
      heli_target makeentitysentient("allies");
      heli_target setthreatbiasgroup("ai_chopper");
      heli_target notsolid();
      heli_target.health = 999;
      self.heli_targets[self.heli_targets.size] = heli_target;
      i += 2;
    }
  }
}

function function_9123f4f0cd12be6() {
  self endon("death");

  while(true) {
    foreach(heli_target in self.heli_targets) {
      thread drawsphere(heli_target.origin, 20, 0.1, (1, 1, 0));
    }

    wait 0.01;
  }
}