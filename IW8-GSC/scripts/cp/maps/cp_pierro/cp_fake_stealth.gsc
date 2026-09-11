/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_pierro\cp_fake_stealth.gsc
*********************************************************/

function cp_fake_stealth() {
  scripts\engine\utility::flag_init("fake_stealth_paused");
  level.const_cos60 = cos(65);
  thread load_stealth_values_from_table();
  level.current_escalation_level = 0;

  for(;;) {
    if(scripts\engine\utility::flag("fake_stealth_paused")) {
      waitframe();
      continue;
    }

    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(var_0.size == 0) {
      waitframe();
      continue;
    }

    foreach(var_2 in var_0) {
      if(isDefined(var_2.fake_stealth)) {
        continue;
      }

      var_2.dont_cleanup = 1;
      var_2.fake_stealth = 1;
      thread zombie_fake_stealth();
      thread stealth_patrol(var_2);
      waitframe();
      LOC_000000b3:
    }

    waitframe();
  }
}

function set_zombie_awareness(var_0) {}

function zombie_fake_stealth() {
  self endon("death");
  self endon("exit_stealth");

  if(!istrue(self.hasplayedvignetteanim)) {
    wait 2;
  }

  waitframe();
  self.ignoreall = 1;
  self.scripted_mode = 1;
  fake_stealth_funcs();
  var_0 = scripts\engine\utility::waittill_any_return("alerted", "damage");

  if(var_0 == "damage") {
    self.fake_stealth_state = "took damage";
  }

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }

  if(self islegacyagent()) {
    self scragentsetgoalpos(self.origin);
  } else {
    self setgoalpos(self.origin);
    self clearpath();
  }

  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.legacy.movemode = "sprint";
  wait 5;
  thread revert_to_stealth();
}

function revert_to_stealth() {
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    while(!isDefined(self.enemy)) {
      waitframe();
    }

    if(!isPlayer(self.enemy)) {
      waitframe();
      continue;
    }

    var_0 = self.enemy;
    var_1 = distance(var_0.origin, self.origin);
    var_2 = self cansee(var_0) && sighttracepassed(self getEye(), var_0.origin + (0, 0, 40), 0, self);
    var_3 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("tag_eye"), var_0.origin + (0, 0, 40), level.const_cos60);
    var_4 = var_0 getstance();

    if(var_2 && var_3) {
      if(var_1 < 650) {
        if(var_4 == "stand") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var_0);
          return;
        }
      } else if(var_1 < 128) {
        if(var_4 == "prone") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var_0);
          return;
        }
      }
    } else if(var_1 > 196) {
      go_to_last_player_position(var_0);
      return;
    }

    wait 0.25;
  }
}

function go_to_last_player_position(var_0) {
  self.fake_stealth_state = "going_to_last_position";
  self.scripted_mode = 1;
  self.ignoreall = 1;
  thread zombie_fake_stealth();
  thread go_to_spot(var_0.origin);
}

function fake_stealth_funcs() {
  thread whizby_listener();
  thread grenade_listener();
  thread environment_listener();
  thread player_nearby_listener();
  thread player_weapon_listener();
  set_stealth_values(self, 0);
  thread zombie_3dtext_handler();
  thread draw_fov();
}

function whizby_listener() {
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    self waittill("bulletwhizby", var_0);
    self.fake_stealth_state = "investigating_bullet_whizby";
    thread go_to_spot(var_0.origin);
  }
}

function environment_listener() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    level waittill("environment_alert", var_0);

    if(distance(self.origin, var_0) > 650) {
      continue;
    }

    self.fake_stealth_state = "investigating environment";
    thread go_to_spot(var_0);
  }
}

function grenade_listener() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    self waittill("explode", var_0);

    if(distance(self.origin, var_0) > 1000) {
      continue;
    }

    self.fake_stealth_state = "investigating_grenade explosion";
    thread go_to_spot(var_0);
  }
}

function player_nearby_listener() {
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distance(var_1.origin, self.origin);

      if(var_2 > 600) {
        continue;
      }

      if(var_2 < 96) {
        self.fake_stealth_state = "spotted";
        self notify("alerted");
        break;
      }

      var_3 = self cansee(var_1) && sighttracepassed(self getEye(), var_1.origin + (0, 0, 40), 0, self);
      var_4 = var_1 getstance();

      if(var_3) {
        var_5 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("tag_eye"), var_1.origin + (0, 0, 40), level.const_cos60);

        if(!var_5) {
          continue;
        }

        if(var_2 <= 600 && var_4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self.fake_stealth_state = "spotted";
          self notify("alerted");
          return;
        } else if(var_2 <= 400 && var_4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self.fake_stealth_state = "spotted";
          self notify("alerted");
          return;
        } else if(var_2 <= 200 && var_4 != "prone") {
          self playSound("emt_wood_barrier_destr");
          self.fake_stealth_state = "spotted";
          self notify("alerted");
          return;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

function stealth_patrol(var_0) {
  self endon("death");
  self endon("alerted");
  self endon("new_goal");
  self endon("exit_stealth");
  self.og_goalradius = self.goalradius;

  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  var_1 = getrandomnavpoints(var_0, 350, 6);

  if(!isDefined(var_1)) {
    return;
  }

  self.fake_stealth_state = "patrol";

  for(;;) {
    var_2 = scripts\engine\utility::random(var_1);

    if(self islegacyagent()) {
      self scragentsetgoalRadius(8);
      self scragentsetgoalpos(var_2);
    } else {
      self.goalradius = 8;
      self setgoalpos(var_2);
    }

    scripts\engine\utility::waittill_any("goal", "goal_reached");
    wait randomfloatrange(0.05, 3);
  }
}

function go_to_spot(var_0) {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");
  self notify("new_goal");
  self endon("new_goal");

  if(self islegacyagent()) {
    self scragentsetgoalpos(self.origin);
    scripts\engine\utility::waittill_any("goal", "goal_reached");
  } else {
    self setgoalpos(self.origin);
    self clearpath();
  }

  if(!isDefined(self.legacy)) {
    iprintln("** - LEGACY IS UNDEFINED FOR : " + self getentitynumber() + ", health: " + self.health + ", agent: " + self.agent_type);
    self.legacy = spawnStruct();
  }

  self.legacy.movemode = "sprint";

  if(self islegacyagent()) {
    self scragentsetgoalpos(getclosestpointonnavmesh(var_0));
    var_1 = scripts\engine\utility::waittill_any_return("goal", "goal_reached");
  } else {
    self setgoalpos(getclosestpointonnavmesh(var_0));
    self waittill("goal");
  }

  self.legacy.movemode = "slow_walk";
  wait 3;
  self.fake_stealth_state = "patrol";
  thread stealth_patrol(var_0);
}

function weapon_fire_monitor() {
  self notify("weapon_fire_monitor");
  self endon("weapon_fire_monitor");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired");
    level notify("weapon_fired", self.origin, self getcurrentweapon());
  }
}

function player_weapon_listener() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    level waittill("weapon_fired", var_0, var_1);

    if(distance(var_0, self.origin) > 1500) {
      continue;
    }

    self.fake_stealth_state = "investigating_weapon_fire";
    thread go_to_spot(var_0);
  }
}

function zombie_3dtext_handler() {
  self endon("death");
  self notify("texthandler");
  self endon("texthandler");

  for(;;) {
    if(getDvar("stealth_show_states") == "") {
      wait 1;
      continue;
    }

    waitframe();
  }
}

function draw_fov() {
  self notify("draw_fov");
  self endon("draw_fov");
  self endon("death");

  for(;;) {
    if(getDvar("stealth_show_los") == "") {
      wait 1;
      continue;
    }

    var_0 = self gettagorigin("tag_eye");
    var_1 = self gettagangles("tag_eye");
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * self.stealthvals.standdetectdist;
    waitframe();
  }
}

function load_stealth_values_from_table() {
  level.zombie_stealth_values = [];
  var_0 = "scripts/cp/zombie_stealth.csv";
  var_1 = 1;
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, var_1);

    if(var_3 == "") {
      break;
    }

    var_4 = spawnStruct();
    var_4.standdetectdist = int(tablelookupbyrow(var_0, 2, var_1));
    var_4.crouchdetectdist = int(tablelookupbyrow(var_0, 3, var_1));
    var_4.pronedetectdist = int(tablelookupbyrow(var_0, 4, var_1));
    var_4.hiddenstanddetectdist = int(tablelookupbyrow(var_0, 5, var_1));
    var_4.hiddencrouchdetectdist = int(tablelookupbyrow(var_0, 6, var_1));
    var_4.hiddenpronedetectdist = int(tablelookupbyrow(var_0, 7, var_1));
    var_4.propdistance = int(tablelookupbyrow(var_0, 8, var_1));
    var_4.timebeforeescalate = int(tablelookupbyrow(var_0, 9, var_1));
    var_4.timebeforedeescalate = int(tablelookupbyrow(var_0, 10, var_1));
    var_4.distancebeforedeescalate = int(tablelookupbyrow(var_0, 11, var_1));
    var_4.timehiddennolosbeforedeescalate = int(tablelookupbyrow(var_0, 12, var_1));
    var_4.zombiemovespeed = tablelookupbyrow(var_0, 13, var_1);
    var_4.playerstandmovedist = int(tablelookupbyrow(var_0, 14, var_1));
    var_4.playercrouchmovedist = int(tablelookupbyrow(var_0, 15, var_1));
    var_4.playerpronemovedist = int(tablelookupbyrow(var_0, 16, var_1));
    var_4.hiddenplayerstandmovedist = int(tablelookupbyrow(var_0, 17, var_1));
    var_4.hiddenplayercrouchmovedist = int(tablelookupbyrow(var_0, 18, var_1));
    var_4.hiddenplayerpronemovedist = int(tablelookupbyrow(var_0, 19, var_1));
    var_4.playermovedistlerptime = int(tablelookupbyrow(var_0, 20, var_1));
    var_4.losfov = int(tablelookupbyrow(var_0, 21, var_1));
    level.zombie_stealth_values[int(var_3)] = var_4;
    var_1++;
  }
}

function set_stealth_values(var_0, var_1) {
  var_1 = "" + var_1;
  var_2 = spawnStruct();
  var_2.standdetectdist = level.zombie_stealth_values[var_1].standdetectdist;
  var_2.crouchdetectdist = level.zombie_stealth_values[var_1].crouchdetectdist;
  var_2.pronedetectdist = level.zombie_stealth_values[var_1].pronedetectdist;
  var_2.hiddenstanddetectdist = level.zombie_stealth_values[var_1].hiddenstanddetectdist;
  var_2.hiddencrouchdetectdist = level.zombie_stealth_values[var_1].hiddencrouchdetectdist;
  var_2.hiddenpronedetectdist = level.zombie_stealth_values[var_1].hiddenpronedetectdist;
  var_2.propdistance = level.zombie_stealth_values[var_1].propdistance;
  var_2.timebeforeescalate = level.zombie_stealth_values[var_1].timebeforeescalate;
  var_2.timebeforedeescalate = level.zombie_stealth_values[var_1].timebeforedeescalate;
  var_2.distancebeforedeescalate = level.zombie_stealth_values[var_1].distancebeforedeescalate;
  var_2.timehiddennolosbeforedeescalate = level.zombie_stealth_values[var_1].timehiddennolosbeforedeescalate;
  var_2.zombiemovespeed = level.zombie_stealth_values[var_1].zombiemovespeed;
  var_2.playerstandmovedist = level.zombie_stealth_values[var_1].playerstandmovedist;
  var_2.playercrouchmovedist = level.zombie_stealth_values[var_1].playercrouchmovedist;
  var_2.playerpronemovedist = level.zombie_stealth_values[var_1].playerpronemovedist;
  var_2.hiddenplayerstandmovedist = level.zombie_stealth_values[var_1].hiddenplayerstandmovedist;
  var_2.hiddenplayercrouchmovedist = level.zombie_stealth_values[var_1].hiddenplayercrouchmovedist;
  var_2.hiddenplayerpronemovedist = level.zombie_stealth_values[var_1].hiddenplayerpronemovedist;
  var_2.playermovedistlerptime = level.zombie_stealth_values[var_1].playermovedistlerptime;
  var_2.losfov = level.zombie_stealth_values[var_1].losfov;
  var_0.stealthvals = var_2;
}