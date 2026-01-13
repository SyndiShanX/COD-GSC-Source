/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3552.gsc
*********************************************/

init() {}

setturrettargetent() {
  self endon("death");
  self endon("disconnect");
  thread func_C799();
  thread func_2652();
  self playlocalsound("synaptic_comm_on");
  thread func_13B7F();
}

func_E0E0() {
  self notify("endComLink");
}

func_C799() {
  if(!level.teambased) {
    return;
  }

  foreach(var_1 in level.participants) {
    if(!isDefined(var_1.team)) {
      continue;
    }

    if(var_1.team == self.team) {
      var_2 = scripts\mp\utility::outlineenableforplayer(var_1, "cyan", self, 0, 0, "killstreak");
      thread func_5604(var_2, var_1);
    }
  }
}

func_5604(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(10, "death", "joined_team");
  scripts\mp\utility::outlinedisable(var_0, var_1);
}

func_2652() {
  self endon("endComLink");
  var_0 = 3;
  var_1 = 3;
  var_2 = 0.5;
  var_3 = 0;
  for(;;) {
    var_4 = sortbydistance(level.participants, self.origin);
    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(var_6 == self) {
        continue;
      }

      if(level.teambased && var_6.team == self.team) {
        continue;
      }

      if(var_6 scripts\mp\utility::_hasperk("specialty_gpsjammer")) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_6)) {
        if(isDefined(var_6.var_2A3B)) {
          var_6.var_2A3B delete();
        }

        continue;
      }

      if(isDefined(var_6.var_12AF1)) {
        if(isDefined(var_6.var_2A3B)) {
          var_6.var_2A3B delete();
        }

        var_6.var_12AF1.origin = var_6.origin;
        var_6.var_12AF2.origin = var_6.origin;
        var_6.var_12AF2.alpha = 0.95;
        var_6.var_12AF2 thread func_6AB8(var_1, var_3);
      } else {
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("tag_origin");
        var_7.triggerportableradarping = var_6;
        var_6.var_12AF1 = var_7;
        var_6.var_12AF2 = var_7 scripts\mp\entityheadicons::setheadicon(self, "headicon_enemy", (0, 0, 48), 2, 2, 1, 0.01, 0, 1, 1, 0);
        var_6.var_12AF2 setwaypointedgestyle_rotatingicon();
        var_6.var_12AF2.alpha = 0.95;
        var_6.var_12AF2 thread func_6AB8(var_1, var_3);
      }

      wait(var_2);
    }

    wait(var_1);
  }
}

func_B37E() {
  self endon("death");
  self endon("disconnect");
  self endon("endComLink");
  level endon("game_ended");
  var_0 = 3;
  var_1 = 3;
  var_2 = 0.5;
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_12AF1)) {
    if(isDefined(self.var_2A3B)) {
      self.var_2A3B delete();
    }

    self.var_12AF1.origin = self.origin;
    self.var_12AF2.origin = self.origin;
    self.var_12AF2.alpha = 0.95;
    self.var_12AF2 thread func_6AB8(var_1, var_2);
  } else {
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3.triggerportableradarping = self;
    self.var_12AF1 = var_3;
    self.var_12AF2 = var_3 scripts\mp\entityheadicons::setheadicon(scripts\mp\utility::getotherteam(self.team), "headicon_enemy", (0, 0, 48), 14, 14, 1, 0.01, 0, 1, 1, 0);
    self.var_12AF2.alpha = 0.95;
    self.var_12AF2 thread func_6AB8(var_1, var_2);
    self.var_12AF2 setwaypointedgestyle_rotatingicon();
  }

  wait(var_1);
  if(isDefined(self.var_2A3B)) {
    self.var_2A3B delete();
  }
}

func_6AB8(var_0, var_1) {
  self notify("fadeOut");
  self endon("fadeOut");
  var_2 = var_0 - var_1;
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self fadeovertime(var_2);
  self.alpha = 0;
}

func_13B7F(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(10);
  self notify("endComLink");
}

watchempdamage() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    scripts\engine\utility::waitframe();
    self notify("endComLink");
  }
}

func_13A11() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    level waittill("emp_update");
    if(scripts\mp\killstreaks\_emp_common::isemped()) {
      self notify("endComLink");
    }
  }
}