/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1561.gsc
**************************************/

chopper_boss_load_fx() {
  level._effect["chopper_boss_light_smoke"] = loadfx("smoke/smoke_trail_white_heli");
  level._effect["chopper_boss_heavy_smoke"] = loadfx("smoke/smoke_trail_black_heli");
}

chopper_boss_locs_populate(var_0, var_1) {
  level.chopper_boss_locs = common_scripts\utility::getStructArray(var_1, var_0);

  foreach(var_3 in level.chopper_boss_locs) {
    var_3.neighbors = var_3 maps\_utility::get_linked_structs();

    foreach(var_5 in level.chopper_boss_locs) {
      if(var_3 == var_5) {
        continue;
      }
      if(!maps\_utility::array_contains(var_3.neighbors, var_5) && maps\_utility::array_contains(var_5 maps\_utility::get_linked_structs(), var_3)) {
        var_3.neighbors[var_3.neighbors.size] = var_5;
      }
    }
  }
}

chopper_path_release(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = strtok(var_1, " ");

    foreach(var_4 in var_2) {}
    self endon(var_4);
  }

  var_6 = strtok(var_0, " ");

  switch (var_6.size) {
    case 1:
      self waittill(var_6[0]);
      break;
    case 2:
      common_scripts\utility::waittill_either(var_6[0], var_6[1]);
      break;
    case 3:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2]);
      break;
    case 4:
      common_scripts\utility::waittill_any(var_6[0], var_6[1], var_6[2], var_6[3]);
      break;
    default:
      break;
  }

  self.loc_current.in_use = undefined;
}

chopper_boss_behavior_little_bird(var_0) {
  self endon("death");
  self endon("deathspin");
  level endon("special_op_terminated");
  self.loc_current = var_0;
  self.loc_current.in_use = 1;
  chopper_boss_setup();
  thread chopper_boss_damage_states();
  thread chopper_event_on_death();
  var_1 = 0;

  for(;;) {
    self.heli_target = undefined;
    var_2 = isDefined(self.request_move) && self.request_move || var_1;

    while(isDefined(level.chopper_boss_finding_target) && level.chopper_boss_finding_target == 1) {
      wait 0.05;
    }
    var_3 = chopper_boss_get_best_location_and_target(var_2);

    if(isDefined(var_3) && self.loc_current != var_3) {
      if(isDefined(self.heli_target)) {
        self setlookatent(self.heli_target);
      } else {
        var_4 = maps\_utility::getclosest(self.origin, level.players);

        if(isDefined(var_4)) {
          self setlookatent(var_4);
        }
      }

      self.request_move = undefined;
      thread chopper_boss_move(var_3);
      self waittill("reached_dynamic_path_end");
    }

    if(isDefined(self.heli_target)) {
      var_1 = chopper_boss_attempt_firing(self.heli_target);
    }
    wait 0.1;
  }
}

chopper_boss_setup() {
  maps\_vehicle::mgoff();
  chopper_boss_sentient();
  maps\_utility::add_damagefeedback();
  self.mgturret[1] unlink();
  self.mgturret[1] delete();
  var_0 = self.mgturret[0];
  var_0 unlink();
  var_0 linkTo(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_0 setleftarc(45);
  var_0 setrightarc(45);
  var_0 settoparc(45);
  var_0 setbottomarc(55);
  var_0 setdefaultdroppitch(-10);
  self.mgturret = [];
  self.mgturret[self.mgturret.size] = var_0;
}

chopper_event_on_death() {
  self waittill("death", var_0);

  if(!isDefined(self)) {
    return;
  }
  if(maps\_utility::is_survival()) {
    playFX(level._effect["money"], self.origin + (0, 0, -32));
  }
}

chopper_boss_damage_states() {
  self endon("death");
  self endon("deathspin");
  var_0 = self.health - self.healthbuffer;
  var_1 = 0;

  for(;;) {
    var_2 = self.health - self.healthbuffer;

    if(var_2 <= var_0 * 0.5) {
      if(var_1 == 1) {
        var_1 = 2;
        self.request_move = 1;
      }

      playFXOnTag(common_scripts\utility::getfx("chopper_boss_heavy_smoke"), self, "tag_engine");
    } else if(var_2 <= var_0 * 0.75) {
      if(var_1 == 0) {
        var_1 = 1;
        self.request_move = 1;
      }

      playFXOnTag(common_scripts\utility::getfx("chopper_boss_light_smoke"), self, "tag_engine");
    }

    wait 0.05;
  }
}

chopper_boss_can_hit_from(var_0, var_1) {
  var_2 = self.mgturret[0].origin[2] - self.origin[2];
  return bullettracepassed(var_0 + (0, 0, var_2), var_1, 0, self);
}

chopper_boss_in_range(var_0) {
  var_1 = distance2d(self.origin, var_0);
  var_2 = 384;

  if(isDefined(level.chopper_boss_min_dist2d)) {
    var_2 = level.chopper_boss_min_dist2d;
  }
  return var_1 >= var_2 && var_1 <= 3072;
}

chopper_boss_set_target(var_0) {
  if(isDefined(var_0)) {
    self.heli_target = var_0;
  }
}

chopper_boss_attempt_firing(var_0) {
  self endon("deathspin");
  self endon("death");
  var_1 = 0;

  if(isDefined(var_0) && !isDefined(var_0.heli_shooting) && chopper_boss_in_range(var_0.origin)) {
    thread chopper_boss_manage_shooting_flag(self.heli_target);
    self setlookatent(var_0);
    var_2 = chopper_boss_wait_face_target(var_0, 5.0);

    if(isDefined(var_0)) {
      if(isDefined(var_2) && var_2) {
        chopper_boss_fire_turrets(var_0);
        var_1 = 1;
      }
    }

    self notify("chopper_done_shooting");
  }

  return var_1;
}

chopper_boss_manage_shooting_flag(var_0) {
  var_0.heli_shooting = 1;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_shooting");

  if(isDefined(var_0)) {
    var_0.heli_shooting = undefined;
  }
}

chopper_boss_wait_face_target(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  var_0 endon("death");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = gettime() + var_1 * 1000;
  }
  while(isDefined(var_0)) {
    if(maps\_utility::within_fov_2d(self.origin, self.angles, var_0.origin, 0.0)) {
      return 1;
    }
    if(isDefined(var_2) && gettime() >= var_2) {
      return 0;
    }
    wait 0.25;
  }
}

chopper_boss_fire_turrets(var_0) {
  self endon("deathspin");
  self endon("death");
  var_0 endon("death");
  var_1 = 20;

  foreach(var_3 in self.mgturret) {
    if(isai(var_0)) {
      var_3 settargetentity(var_0, var_0 getEye() - var_0.origin);
    } else if(isPlayer(var_0)) {
      if(maps\_utility::is_player_down(var_0)) {
        var_1 = 60;
        var_3 settargetentity(var_0);
      } else {
        var_3 settargetentity(var_0, var_0 getEye() - var_0.origin);
      }
    } else {
      var_3 settargetentity(var_0, (0, 0, 32));
    }
    var_3 startbarrelspin();
  }

  wait 2.0;
  var_5 = weaponfiretime("minigun_littlebird_spinnup");
  var_6 = 0;

  for(var_7 = 0; var_7 < var_1; var_7++) {
    self.mgturret[var_6] shootturret();
    var_6++;

    if(var_6 >= self.mgturret.size) {
      var_6 = 0;
    }
    wait(var_5 + 0.05);
  }

  wait 1.0;

  foreach(var_3 in self.mgturret) {}
  var_3 stopbarrelspin();
}

chopper_boss_manage_targeting_flag() {
  level.chopper_boss_finding_target = 1;
  common_scripts\utility::waittill_any("death", "deathspin", "chopper_done_targeting");
  level.chopper_boss_finding_target = undefined;
}

chopper_boss_get_best_location_and_target(var_0) {
  self endon("death");
  var_1 = self.loc_current.neighbors;

  if(!isDefined(var_0) || var_0 == 0) {
    var_1[var_1.size] = self.loc_current;
  }
  thread chopper_boss_manage_targeting_flag();
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!maps\_utility::is_player_down(var_4) && (!isDefined(var_4.ignoreme) || var_4.ignoreme == 0)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = getaiarray("allies");

  foreach(var_8 in var_6) {
    if(!isDefined(var_8.ignoreme) || var_8.ignoreme == 0) {
      var_2[var_2.size] = var_8;
    }
  }

  if(isDefined(level.placed_sentry)) {
    foreach(var_11 in level.placed_sentry) {
      if(!isDefined(var_11.ignoreme) || var_11.ignoreme == 0) {
        var_2[var_2.size] = var_11;
      }
    }
  }

  if(!var_2.size) {
    foreach(var_4 in level.players) {
      if(!maps\_utility::is_player_down_and_out(var_4) && (!isDefined(var_4.ignoreme) || var_4.ignoreme == 0)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  var_15 = [];
  var_16 = 0;

  foreach(var_18 in var_1) {
    if(var_18 != self.loc_current && isDefined(var_18.in_use)) {
      continue;
    }
    var_18.heli_target = undefined;
    var_18.dist2d = undefined;
    var_19 = undefined;

    foreach(var_21 in var_2) {
      if(!isDefined(var_21)) {
        continue;
      }
      if(var_18 chopper_boss_in_range(var_21.origin) == 0) {
        continue;
      }
      var_22 = var_21.origin + (0, 0, 64);

      if(isai(var_21) || isPlayer(var_21)) {
        var_22 = var_21 getEye();
      }
      if(chopper_boss_can_hit_from(var_18.origin, var_22)) {
        if(!isDefined(var_18.heli_target)) {
          var_15[var_15.size] = var_18;
          var_18.heli_target = var_21;
          var_19 = distance2d(var_18.origin, var_21.origin);
        } else {
          var_23 = distance2d(var_18.origin, var_21.origin);

          if(var_23 < var_19) {
            var_18.heli_target = var_21;
            var_19 = var_23;
          }
        }
      }

      var_16++;

      if(var_16 >= 4) {
        wait 0.05;
        var_16 = 0;
      }
    }
  }

  if(var_15.size) {
    var_26 = [];

    foreach(var_18 in var_15) {
      if(isDefined(var_18.heli_target)) {
        var_26[var_26.size] = var_18;
      }
    }

    var_15 = var_26;
  }

  if(!var_15.size) {
    foreach(var_18 in var_1) {
      if(var_18 != self.loc_current && isDefined(var_18.in_use)) {
        continue;
      }
      var_30 = undefined;

      foreach(var_21 in var_2) {
        if(!isDefined(var_21)) {
          continue;
        }
        if(!isDefined(var_30)) {
          var_30 = var_21;
          var_18.dist2d = distance2d(var_18.origin, var_21.origin);
          continue;
        }

        var_32 = distance2d(var_18.origin, var_21.origin);

        if(var_32 < var_18.dist2d) {
          var_30 = var_21;
          var_18.dist2d = var_32;
        }
      }

      if(isDefined(var_18.dist2d)) {
        var_15[var_15.size] = var_18;
      }
    }
  } else {
    foreach(var_18 in var_15) {}
    var_18.dist2d = distance2d(var_18.heli_target.origin, var_18.origin);
  }

  var_37 = maps/_utility_joec::exchange_sort_by_handler(var_15, ::chopper_boss_loc_compare);
  var_38 = undefined;
  var_39 = 0;

  foreach(var_18 in var_37) {
    var_41 = 384;

    if(isDefined(level.chopper_boss_min_dist2d)) {
      var_41 = level.chopper_boss_min_dist2d;
    }
    if(var_18.dist2d >= var_41 && var_18.dist2d <= 3072) {
      var_38 = var_18;
      var_39 = 1;
      break;
    }
  }

  if(!isDefined(var_38) && var_37.size) {
    var_38 = var_37[0];
  }
  if(isDefined(var_38) && isDefined(var_38.heli_target)) {
    chopper_boss_set_target(var_38.heli_target);
  }
  self notify("chopper_done_targeting");

  if(isDefined(var_38) && var_38 != self.loc_current) {
    return var_38;
  } else {
    return undefined;
  }
}

chopper_boss_loc_compare() {
  return self.dist2d;
}

chopper_boss_move(var_0) {
  self.loc_current.in_use = undefined;
  self.loc_current = var_0;
  self.loc_current.in_use = 1;
  thread maps\_vehicle::vehicle_paths(var_0);
}

chopper_boss_sentient() {
  self makeentitysentient("axis", 1);
  self.attackeraccuracy = 6;
  self.maxvisibledist = 3072;
  self.threatbias = 10000;
}