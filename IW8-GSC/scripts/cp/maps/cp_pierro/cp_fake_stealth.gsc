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

    var0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(var0.size == 0) {
      waitframe();
      continue;
    }

    foreach(var2 in var0) {
      if(isDefined(var2.fake_stealth)) {
        continue;
      }

      var2.dont_cleanup = 1;
      var2.fake_stealth = 1;
      thread zombie_fake_stealth();
      thread stealth_patrol(var2);
      waitframe();
      LOC_000000b3:
    }

    waitframe();
  }
}

function set_zombie_awareness(var0) {}

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
  var0 = scripts\engine\utility::waittill_any_return("alerted", "damage");

  if(var0 == "damage") {
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

    var0 = self.enemy;
    var1 = distance(var0.origin, self.origin);
    var2 = self cansee(var0) && sighttracepassed(self getEye(), var0.origin + (0, 0, 40), 0, self);
    var3 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("tag_eye"), var0.origin + (0, 0, 40), level.const_cos60);
    var4 = var0 getstance();

    if(var2 && var3) {
      if(var1 < 650) {
        if(var4 == "stand") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var0);
          return;
        }
      } else if(var1 < 128) {
        if(var4 == "prone") {
          wait 0.25;
          continue;
        } else {
          go_to_last_player_position(var0);
          return;
        }
      }
    } else if(var1 > 196) {
      go_to_last_player_position(var0);
      return;
    }

    wait 0.25;
  }
}

function go_to_last_player_position(var0) {
  self.fake_stealth_state = "going_to_last_position";
  self.scripted_mode = 1;
  self.ignoreall = 1;
  thread zombie_fake_stealth();
  thread go_to_spot(var0.origin);
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
    self waittill("bulletwhizby", var0);
    self.fake_stealth_state = "investigating_bullet_whizby";
    thread go_to_spot(var0.origin);
  }
}

function environment_listener() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    level waittill("environment_alert", var0);

    if(distance(self.origin, var0) > 650) {
      continue;
    }

    self.fake_stealth_state = "investigating environment";
    thread go_to_spot(var0);
  }
}

function grenade_listener() {
  self endon("death");
  self endon("alerted");
  self endon("exit_stealth");

  for(;;) {
    self waittill("explode", var0);

    if(distance(self.origin, var0) > 1000) {
      continue;
    }

    self.fake_stealth_state = "investigating_grenade explosion";
    thread go_to_spot(var0);
  }
}

function player_nearby_listener() {
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    foreach(var1 in level.players) {
      var2 = distance(var1.origin, self.origin);

      if(var2 > 600) {
        continue;
      }

      if(var2 < 96) {
        self.fake_stealth_state = "spotted";
        self notify("alerted");
        break;
      }

      var3 = self cansee(var1) && sighttracepassed(self getEye(), var1.origin + (0, 0, 40), 0, self);
      var4 = var1 getstance();

      if(var3) {
        var5 = scripts\engine\utility::within_fov(self getEye(), self gettagangles("tag_eye"), var1.origin + (0, 0, 40), level.const_cos60);

        if(!var5) {
          continue;
        }

        if(var2 <= 600 && var4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self.fake_stealth_state = "spotted";
          self notify("alerted");
          return;
        } else if(var2 <= 400 && var4 == "stand") {
          self playSound("emt_wood_barrier_destr");
          self.fake_stealth_state = "spotted";
          self notify("alerted");
          return;
        } else if(var2 <= 200 && var4 != "prone") {
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

function stealth_patrol(var0) {
  self endon("death");
  self endon("alerted");
  self endon("new_goal");
  self endon("exit_stealth");
  self.og_goalradius = self.goalradius;

  if(!isDefined(var0)) {
    var0 = self.origin;
  }

  var1 = getrandomnavpoints(var0, 350, 6);

  if(!isDefined(var1)) {
    return;
  }

  self.fake_stealth_state = "patrol";

  for(;;) {
    var2 = scripts\engine\utility::random(var1);

    if(self islegacyagent()) {
      self scragentsetgoalRadius(8);
      self scragentsetgoalpos(var2);
    } else {
      self.goalradius = 8;
      self setgoalpos(var2);
    }

    scripts\engine\utility::waittill_any("goal", "goal_reached");
    wait randomfloatrange(0.05, 3);
  }
}

function go_to_spot(var0) {
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
    self scragentsetgoalpos(getclosestpointonnavmesh(var0));
    var1 = scripts\engine\utility::waittill_any_return("goal", "goal_reached");
  } else {
    self setgoalpos(getclosestpointonnavmesh(var0));
    self waittill("goal");
  }

  self.legacy.movemode = "slow_walk";
  wait 3;
  self.fake_stealth_state = "patrol";
  thread stealth_patrol(var0);
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
    level waittill("weapon_fired", var0, var1);

    if(distance(var0, self.origin) > 1500) {
      continue;
    }

    self.fake_stealth_state = "investigating_weapon_fire";
    thread go_to_spot(var0);
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

    var0 = self gettagorigin("tag_eye");
    var1 = self gettagangles("tag_eye");
    var2 = anglesToForward(var1);
    var3 = var0 + var2 * self.stealthvals.standdetectdist;
    waitframe();
  }
}

function load_stealth_values_from_table() {
  level.zombie_stealth_values = [];
  var0 = "scripts/cp/zombie_stealth.csv";
  var1 = 1;
  var2 = 1;

  for(;;) {
    var3 = tablelookupbyrow(var0, var2, var1);

    if(var3 == "") {
      break;
    }

    var4 = spawnStruct();
    var4.standdetectdist = int(tablelookupbyrow(var0, 2, var1));
    var4.crouchdetectdist = int(tablelookupbyrow(var0, 3, var1));
    var4.pronedetectdist = int(tablelookupbyrow(var0, 4, var1));
    var4.hiddenstanddetectdist = int(tablelookupbyrow(var0, 5, var1));
    var4.hiddencrouchdetectdist = int(tablelookupbyrow(var0, 6, var1));
    var4.hiddenpronedetectdist = int(tablelookupbyrow(var0, 7, var1));
    var4.propdistance = int(tablelookupbyrow(var0, 8, var1));
    var4.timebeforeescalate = int(tablelookupbyrow(var0, 9, var1));
    var4.timebeforedeescalate = int(tablelookupbyrow(var0, 10, var1));
    var4.distancebeforedeescalate = int(tablelookupbyrow(var0, 11, var1));
    var4.timehiddennolosbeforedeescalate = int(tablelookupbyrow(var0, 12, var1));
    var4.zombiemovespeed = tablelookupbyrow(var0, 13, var1);
    var4.playerstandmovedist = int(tablelookupbyrow(var0, 14, var1));
    var4.playercrouchmovedist = int(tablelookupbyrow(var0, 15, var1));
    var4.playerpronemovedist = int(tablelookupbyrow(var0, 16, var1));
    var4.hiddenplayerstandmovedist = int(tablelookupbyrow(var0, 17, var1));
    var4.hiddenplayercrouchmovedist = int(tablelookupbyrow(var0, 18, var1));
    var4.hiddenplayerpronemovedist = int(tablelookupbyrow(var0, 19, var1));
    var4.playermovedistlerptime = int(tablelookupbyrow(var0, 20, var1));
    var4.losfov = int(tablelookupbyrow(var0, 21, var1));
    level.zombie_stealth_values[int(var3)] = var4;
    var1++;
  }
}

function set_stealth_values(var0, var1) {
  var1 = "" + var1;
  var2 = spawnStruct();
  var2.standdetectdist = level.zombie_stealth_values[var1].standdetectdist;
  var2.crouchdetectdist = level.zombie_stealth_values[var1].crouchdetectdist;
  var2.pronedetectdist = level.zombie_stealth_values[var1].pronedetectdist;
  var2.hiddenstanddetectdist = level.zombie_stealth_values[var1].hiddenstanddetectdist;
  var2.hiddencrouchdetectdist = level.zombie_stealth_values[var1].hiddencrouchdetectdist;
  var2.hiddenpronedetectdist = level.zombie_stealth_values[var1].hiddenpronedetectdist;
  var2.propdistance = level.zombie_stealth_values[var1].propdistance;
  var2.timebeforeescalate = level.zombie_stealth_values[var1].timebeforeescalate;
  var2.timebeforedeescalate = level.zombie_stealth_values[var1].timebeforedeescalate;
  var2.distancebeforedeescalate = level.zombie_stealth_values[var1].distancebeforedeescalate;
  var2.timehiddennolosbeforedeescalate = level.zombie_stealth_values[var1].timehiddennolosbeforedeescalate;
  var2.zombiemovespeed = level.zombie_stealth_values[var1].zombiemovespeed;
  var2.playerstandmovedist = level.zombie_stealth_values[var1].playerstandmovedist;
  var2.playercrouchmovedist = level.zombie_stealth_values[var1].playercrouchmovedist;
  var2.playerpronemovedist = level.zombie_stealth_values[var1].playerpronemovedist;
  var2.hiddenplayerstandmovedist = level.zombie_stealth_values[var1].hiddenplayerstandmovedist;
  var2.hiddenplayercrouchmovedist = level.zombie_stealth_values[var1].hiddenplayercrouchmovedist;
  var2.hiddenplayerpronemovedist = level.zombie_stealth_values[var1].hiddenplayerpronemovedist;
  var2.playermovedistlerptime = level.zombie_stealth_values[var1].playermovedistlerptime;
  var2.losfov = level.zombie_stealth_values[var1].losfov;
  var0.stealthvals = var2;
}