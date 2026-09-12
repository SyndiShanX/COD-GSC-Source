/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\cargo_truck_mg_mp.gsc
*****************************************************/

function main() {
  scripts\stealth\manager::main();
  level.stealth.cantracetoaiignoreents = [];
  level.stealth.fnaddeventplaybcs = &ref_123cc;
  level.stealth.fnthreatsightsetstateparameters = &threat_sight_set_state_parameters;
  level.fngetcorpsearrayfunc = &propaddtolocation;
  level.stealth.playerdelaydisablezombie = &ref_119db;
  level.stealth.playerclearspectatekillchainsystem = &scripts\cp\coop_stealth::quickdropnewitem;
  set_detect_ranges();
  ref_13078();
  level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);
  thread manager_thread();
  thread update_stealth_spotted_thread();
}

function empty(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function set_detect_ranges() {}

function ref_13078() {
  GscBinSkip1(0x45, "sight_dist", 600);
}

function manager_thread() {
  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    threat_sight_set_dvar(1);
    scripts\engine\utility::flag_wait("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    scripts\stealth\manager::event_change("spotted");
    scripts\engine\utility::flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    scripts\stealth\manager::event_change("hidden");
    waittillframeend();
  }
}

function threat_sight_set_dvar(var_0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);

  if(var_0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }

  setDvar("ai_threatSight", var_0);
}

function update_stealth_spotted_thread() {
  waitframe();
  var_0 = 0;

  for(;;) {
    var_1 = scripts\stealth\manager::anyone_in_combat();

    if(var_1) {
      if(!var_0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait level.stealth.stealth_spotted_delay;

        if(!scripts\stealth\manager::anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        foreach(var_3 in level.players) {
          if(isDefined(var_3.stealth)) {
            var_4 = var_3 scripts\stealth\utility::get_group_flagname("stealth_spotted");
            scripts\engine\utility::flag_set(var_4);
          }
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      foreach(var_3 in level.players) {
        if(isDefined(var_3.stealth)) {
          var_4 = var_3 scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_clear(var_4);
        }
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

function threat_sight_set_state_parameters(var_0) {
  if(!isalive(self)) {
    return;
  }

  var_1 = 1;
  var_2 = 1;

  if(!isDefined(var_0)) {
    var_0 = self.stealth.threat_sight_state;
  }

  if(isDefined(self.stealth.threatsightratescale)) {
    var_1 *= self.stealth.threatsightratescale;
  }

  if(isDefined(self.stealth.threatsightdistscale)) {
    var_2 *= self.stealth.threatsightdistscale;
  }

  if(isDefined(level.stealth.threatsightratescale)) {
    var_1 *= level.stealth.threatsightratescale;
  }

  if(isDefined(level.stealth.threatsightdistscale)) {
    var_2 *= level.stealth.threatsightdistscale;
  }

  switch (var_0) {
    case "flashlight_in_dark":
    case "investigate":
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1.333 * var_1;
      self.threatsightratemax = 0.8 * var_1;
      break;
    case "combat_hunt":
      self.threatsightdistmin = 64 * var_2;
      self.threatsightdistmax = 128 * var_2;
      self.threatsightratemin = 2.5 * var_1;
      self.threatsightratemax = 2 * var_1;
      break;
    default:
      self.threatsightdistmin = 256 * var_2;
      self.threatsightdistmax = 1024 * var_2;
      self.threatsightratemin = 1 * var_1;
      self.threatsightratemax = 0.4 * var_1;
      break;
  }
}

function propaddtolocation() {
  if(!isDefined(level.stealth.corpses)) {
    return [];
  }

  foreach(var_1 in level.stealth.corpses) {
    if(!isDefined(level.stealth.corpses[var_2])) {
      level.stealth.corpses[var_2] = undefined;
    }
  }

  return level.stealth.corpses;
}

function ref_11cd7(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  if(isDefined(self.stealth.override_damage_auto_range)) {
    var_0 = self.stealth.override_damage_auto_range;
  } else if(isDefined(level.stealth.override_damage_auto_range)) {
    var_0 = level.stealth.override_damage_auto_range;
  }

  if(isDefined(self.stealth.override_damage_sight_range)) {
    var_1 = self.stealth.override_damage_sight_range;
  } else if(isDefined(level.stealth.override_damage_sight_range)) {
    var_1 = level.stealth.override_damage_sight_range;
  }

  self waittill("death");
  var_4 = self getcorpseentity();

  if(isDefined(var_4)) {
    level.stealth.corpses[var_4 getentitynumber()] = var_4;
  }

  if(!isDefined(self.lastattacker)) {
    return;
  }

  var_2 = self.lastattacker;

  if(!isPlayer(var_2) && (!isDefined(var_2.owner) || !isPlayer(var_2.owner))) {
    return;
  }

  if(isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  if(!isDefined(var_2.team) || var_2.team == var_3) {
    return;
  }

  scripts\stealth\event::event_broadcast_axis("ally_killed", "ally_hurt_peripheral", var_2, var_0, var_1);
}

function ref_119db() {
  var_0 = 2;
  var_1 = 200;
  var_2 = 10;
  var_3 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var_4 = self getapproxeyepos();
  var_5 = anglesToForward(self.angles);

  foreach(var_7 in level.players) {
    var_8 = 1.1;
    var_9 = 512;
    var_10 = 3000;
    var_11 = 0.6;
    var_12 = undefined;
    var_13 = undefined;
    var_14 = undefined;

    if(var_7 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var_12 = var_7.vehicle;
      var_13 = var_7.origin;
      var_14 = var_7 getEye();
    } else {
      var_12 = scripts\cp\coop_stealth::quickdropnewitem(var_7);

      if(isDefined(var_12)) {
        var_13 = var_12.origin;
        var_14 = var_12.origin;
        var_9 = 256;
        var_8 = 2;
        var_10 = 2000;
      }
    }

    if(isDefined(var_12)) {
      var_15 = var_13 - self.origin;

      if(abs(var_15[2]) > var_9) {
        continue;
      }

      var_16 = length(var_15);

      if(var_16 > self.threatsightdistmax) {
        var_17 = self.threatsightratemax;
      } else if(var_16 < self.threatsightdistmin) {
        var_17 = self.threatsightratemin;
      } else {
        var_18 = (var_16 - self.threatsightdistmin) / (self.threatsightdistmax - self.threatsightdistmin);
        var_17 = var_18 * (self.threatsightratemax - self.threatsightratemin) + self.threatsightratemin;
      }

      var_19 = self cansee(var_7);
      var_20 = var_19;

      if(!var_20 && var_16 < var_10) {
        var_20 = scripts\engine\trace::ray_trace_passed(var_4, var_14, [self, var_7, var_12], var_3);
      }

      if(!var_20) {
        continue;
      }

      if(var_19) {
        var_17 *= var_8 - 1;
      } else {
        var_17 *= var_8;
        var_15 = vectorNormalize(var_13 - self.origin);

        if(vectordot(var_15, var_5) < self.fovcosine) {
          var_17 *= var_11;
        }
      }

      var_21 = length(var_12 vehicle_getvelocity());

      if(var_21 > var_2) {
        if(var_21 > var_1) {
          var_17 *= var_0;
        } else {
          var_17 *= var_0 * (var_21 - var_2) / (var_1 - var_2);
        }
      }

      var_22 = self getthreatsight(var_7);
      var_23 = var_22 + var_17 * level.frameduration / 1000;
      var_23 = min(var_23, 1);
      self setthreatsight(var_7, var_23);
    }
  }
}

function ref_123cc(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!self isnearanyplayer(1024)) {
    return;
  }

  if(isDefined(var_3)) {
    wait var_3;
  }

  var_6 = undefined;

  switch (var_2) {
    case "alertreset":
      var_6 = scripts\cp\coop_stealth::prematchmusic();
      break;
    case "investigate":
      var_6 = scripts\cp\coop_stealth::puddle_structs();
      break;
    case "coverblown":
      var_6 = scripts\cp\coop_stealth::propane_detonate_fiery_drips();
      break;
    case "combat":
      var_6 = scripts\cp\coop_stealth::projectileimpactthermite();
      break;
    case "sight":
      var_6 = scripts\cp\coop_stealth::raritycamlarge();
      break;
    case "explosion":
      var_6 = scripts\cp\coop_stealth::propnumclones();
      break;
    case "grenade_danger":
      var_6 = scripts\cp\coop_stealth::propwaitminigamehudsetpoint();
      break;
    case "bulletwhizby":
      var_6 = scripts\cp\coop_stealth::processassist_regularcp();
      break;
    case "silenced shot":
      var_6 = scripts\cp\coop_stealth::ray_trace_trigger_radius_2d();
      break;
    case "gunshot":
      var_6 = scripts\cp\coop_stealth::propwatchcleanupondisconnect();
      break;
    case "gunshot_teammate":
      var_6 = scripts\cp\coop_stealth::propwatchcleanuponroundend();
      break;
    case "ally_killed":
      var_6 = scripts\cp\coop_stealth::pressure_timeout();
      break;
    case "proximity":
      var_6 = scripts\cp\coop_stealth::race_set_player_safe();
      break;
    case "footstep":
      var_6 = scripts\cp\coop_stealth::propsizetext();
      break;
    case "footstep_sprint":
      var_6 = scripts\cp\coop_stealth::propspawnorigin();
      break;
    case "teaminquiry":
      var_6 = scripts\cp\coop_stealth::recent_spawn_threshold();
      break;
    case "lost_sight":
      var_6 = scripts\cp\coop_stealth::put_passenger_in_truck();
      break;
    case "first_lost":
      var_6 = scripts\cp\coop_stealth::proximity_explode();
      break;
  }

  if(isDefined(var_6)) {
    level thread scripts\cp\coop_stealth::play_enemy_radio_chat(var_6, self);
    return;
  }
}