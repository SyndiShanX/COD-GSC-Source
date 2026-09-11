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

function empty(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

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

function threat_sight_set_dvar(var0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);

  if(var0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }

  setDvar("OKQTSOMTKT", var0);
}

function update_stealth_spotted_thread() {
  waitframe();
  var0 = 0;

  for(;;) {
    var1 = scripts\stealth\manager::anyone_in_combat();

    if(var1) {
      if(!var0 && isDefined(level.stealth.stealth_spotted_delay)) {
        wait level.stealth.stealth_spotted_delay;

        if(!scripts\stealth\manager::anyone_in_combat()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_set("stealth_spotted");

        foreach(var3 in level.players) {
          if(isDefined(var3.stealth)) {
            var4 = var3 scripts\stealth\utility::get_group_flagname("stealth_spotted");
            scripts\engine\utility::flag_set(var4);
          }
        }
      }
    } else if(scripts\engine\utility::flag("stealth_spotted")) {
      scripts\engine\utility::flag_clear("stealth_spotted");

      foreach(var3 in level.players) {
        if(isDefined(var3.stealth)) {
          var4 = var3 scripts\stealth\utility::get_group_flagname("stealth_spotted");
          scripts\engine\utility::flag_clear(var4);
        }
      }
    }

    var0 = var1;
    waitframe();
  }
}

function threat_sight_set_state_parameters(var0) {
  if(!isalive(self)) {
    return;
  }

  var1 = 1;
  var2 = 1;

  if(!isDefined(var0)) {
    var0 = self.stealth.threat_sight_state;
  }

  if(isDefined(self.stealth.threatsightratescale)) {
    var1 *= self.stealth.threatsightratescale;
  }

  if(isDefined(self.stealth.threatsightdistscale)) {
    var2 *= self.stealth.threatsightdistscale;
  }

  if(isDefined(level.stealth.threatsightratescale)) {
    var1 *= level.stealth.threatsightratescale;
  }

  if(isDefined(level.stealth.threatsightdistscale)) {
    var2 *= level.stealth.threatsightdistscale;
  }

  switch (var0) {
    case "flashlight_in_dark":
    case "investigate":
      self.threatsightdistmin = 256 * var2;
      self.threatsightdistmax = 1024 * var2;
      self.threatsightratemin = 1.333 * var1;
      self.threatsightratemax = 0.8 * var1;
      break;
    case "combat_hunt":
      self.threatsightdistmin = 64 * var2;
      self.threatsightdistmax = 128 * var2;
      self.threatsightratemin = 2.5 * var1;
      self.threatsightratemax = 2 * var1;
      break;
    default:
      self.threatsightdistmin = 256 * var2;
      self.threatsightdistmax = 1024 * var2;
      self.threatsightratemin = 1 * var1;
      self.threatsightratemax = 0.4 * var1;
      break;
  }
}

function propaddtolocation() {
  if(!isDefined(level.stealth.corpses)) {
    return [];
  }

  foreach(var1 in level.stealth.corpses) {
    if(!isDefined(level.stealth.corpses[var2])) {
      level.stealth.corpses[var2] = undefined;
    }
  }

  return level.stealth.corpses;
}

function ref_11cd7(var0, var1) {
  var2 = undefined;
  var3 = self.team;

  if(isDefined(self.stealth.override_damage_auto_range)) {
    var0 = self.stealth.override_damage_auto_range;
  } else if(isDefined(level.stealth.override_damage_auto_range)) {
    var0 = level.stealth.override_damage_auto_range;
  }

  if(isDefined(self.stealth.override_damage_sight_range)) {
    var1 = self.stealth.override_damage_sight_range;
  } else if(isDefined(level.stealth.override_damage_sight_range)) {
    var1 = level.stealth.override_damage_sight_range;
  }

  self waittill("death");
  var4 = self getcorpseentity();

  if(isDefined(var4)) {
    level.stealth.corpses[var4 getentitynumber()] = var4;
  }

  if(!isDefined(self.lastattacker)) {
    return;
  }

  var2 = self.lastattacker;

  if(!isPlayer(var2) && (!isDefined(var2.owner) || !isPlayer(var2.owner))) {
    return;
  }

  if(isDefined(var2.owner)) {
    var2 = var2.owner;
  }

  if(!isDefined(var2.team) || var2.team == var3) {
    return;
  }

  scripts\stealth\event::event_broadcast_axis("ally_killed", "ally_hurt_peripheral", var2, var0, var1);
}

function ref_119db() {
  var0 = 2;
  var1 = 200;
  var2 = 10;
  var3 = scripts\engine\trace::init_ground_vehicle(1, 0);
  var4 = self getapproxeyepos();
  var5 = anglesToForward(self.angles);

  foreach(var7 in level.players) {
    var8 = 1.1;
    var9 = 512;
    var10 = 3000;
    var11 = 0.6;
    var12 = undefined;
    var13 = undefined;
    var14 = undefined;

    if(var7 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var12 = var7.vehicle;
      var13 = var7.origin;
      var14 = var7 getEye();
    } else {
      var12 = scripts\cp\coop_stealth::quickdropnewitem(var7);

      if(isDefined(var12)) {
        var13 = var12.origin;
        var14 = var12.origin;
        var9 = 256;
        var8 = 2;
        var10 = 2000;
      }
    }

    if(isDefined(var12)) {
      var15 = var13 - self.origin;

      if(abs(var15[2]) > var9) {
        continue;
      }

      var16 = length(var15);

      if(var16 > self.threatsightdistmax) {
        var17 = self.threatsightratemax;
      } else if(var16 < self.threatsightdistmin) {
        var17 = self.threatsightratemin;
      } else {
        var18 = (var16 - self.threatsightdistmin) / (self.threatsightdistmax - self.threatsightdistmin);
        var17 = var18 * (self.threatsightratemax - self.threatsightratemin) + self.threatsightratemin;
      }

      var19 = self cansee(var7);
      var20 = var19;

      if(!var20 && var16 < var10) {
        var20 = scripts\engine\trace::ray_trace_passed(var4, var14, [self, var7, var12], var3);
      }

      if(!var20) {
        continue;
      }

      if(var19) {
        var17 *= var8 - 1;
      } else {
        var17 *= var8;
        var15 = vectorNormalize(var13 - self.origin);

        if(vectordot(var15, var5) < self.fovcosine) {
          var17 *= var11;
        }
      }

      var21 = length(var12 vehicle_getvelocity());

      if(var21 > var2) {
        if(var21 > var1) {
          var17 *= var0;
        } else {
          var17 *= var0 * (var21 - var2) / (var1 - var2);
        }
      }

      var22 = self getthreatsight(var7);
      var23 = var22 + var17 * level.frameduration / 1000;
      var23 = min(var23, 1);
      self setthreatsight(var7, var23);
    }
  }
}

function ref_123cc(var0, var1, var2, var3, var4, var5) {
  if(!self isnearanyplayer(1024)) {
    return;
  }

  if(isDefined(var3)) {
    wait var3;
  }

  var6 = undefined;

  switch (var2) {
    case "alertreset":
      var6 = scripts\cp\coop_stealth::prematchmusic();
      break;
    case "investigate":
      var6 = scripts\cp\coop_stealth::puddle_structs();
      break;
    case "coverblown":
      var6 = scripts\cp\coop_stealth::propane_detonate_fiery_drips();
      break;
    case "combat":
      var6 = scripts\cp\coop_stealth::projectileimpactthermite();
      break;
    case "sight":
      var6 = scripts\cp\coop_stealth::raritycamlarge();
      break;
    case "explosion":
      var6 = scripts\cp\coop_stealth::propnumclones();
      break;
    case "grenade_danger":
      var6 = scripts\cp\coop_stealth::propwaitminigamehudsetpoint();
      break;
    case "bulletwhizby":
      var6 = scripts\cp\coop_stealth::processassist_regularcp();
      break;
    case "silenced shot":
      var6 = scripts\cp\coop_stealth::ray_trace_trigger_radius_2d();
      break;
    case "gunshot":
      var6 = scripts\cp\coop_stealth::propwatchcleanupondisconnect();
      break;
    case "gunshot_teammate":
      var6 = scripts\cp\coop_stealth::propwatchcleanuponroundend();
      break;
    case "ally_killed":
      var6 = scripts\cp\coop_stealth::pressure_timeout();
      break;
    case "proximity":
      var6 = scripts\cp\coop_stealth::race_set_player_safe();
      break;
    case "footstep":
      var6 = scripts\cp\coop_stealth::propsizetext();
      break;
    case "footstep_sprint":
      var6 = scripts\cp\coop_stealth::propspawnorigin();
      break;
    case "teaminquiry":
      var6 = scripts\cp\coop_stealth::recent_spawn_threshold();
      break;
    case "lost_sight":
      var6 = scripts\cp\coop_stealth::put_passenger_in_truck();
      break;
    case "first_lost":
      var6 = scripts\cp\coop_stealth::proximity_explode();
      break;
  }

  if(isDefined(var6)) {
    level thread scripts\cp\coop_stealth::play_enemy_radio_chat(var6, self);
    return;
  }
}