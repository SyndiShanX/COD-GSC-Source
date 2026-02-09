/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\traps\_trap_sewergas.gsc
****************************************************/

trap_sewergas_player_watch(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = 0;
  var_2 = 0.15;

  if(isDefined(self.script_duration)) {
    var_3 = self.script_duration;
  } else {
    var_3 = 20;
  }

  while(var_1 < var_3) {
    wait(var_2);
    var_1 = var_1 + var_2;

    foreach(var_5 in level.players) {
      if(!isalive(var_5)) {
        continue;
      }
      if(!var_5 istouching(var_0)) {
        continue;
      }
      if(maps\mp\zombies\_util::isplayerinlaststand(var_5)) {
        continue;
      }
      if(!isplayercamouflaged(var_5)) {
        var_5 thread playersewergascamo();
      }
    }
  }
}

isplayercamouflaged(var_0) {
  return isDefined(var_0.ignoreme) && var_0.ignoreme;
}

trap_sewergas_trigger_watch(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = 0;
  var_2 = 0.15;

  if(isDefined(self.script_duration)) {
    var_3 = self.script_duration;
  } else {
    var_3 = 20;
  }

  while(var_1 < var_3) {
    wait(var_2);
    var_1 = var_1 + var_2;

    if(!isDefined(level.agentarray)) {
      continue;
    }
    foreach(var_5 in level.agentarray) {
      if(!isDefined(var_5) || !isalive(var_5)) {
        continue;
      }
      if(!var_5 istouching(var_0)) {
        continue;
      }
      if(isPlayer(var_5)) {
        continue;
      }
      if(isDefined(var_5.inspawnanim) && var_5.inspawnanim == 1) {
        continue;
      }
      if(isDefined(var_5.agentteam) && var_5.agentteam == level.playerteam) {
        if(!isDefined(var_5.civiscamouflaged)) {
          var_5 thread sewergasciv();
        }

        continue;
      }

      if(!isDefined(var_5.zomisconfused)) {
        var_5 thread sewergaszombie();
      }
    }
  }
}

sewergaszombie() {
  self endon("death");

  if(!threatbiasgroupexists("zombie_confused")) {
    createthreatbiasgroup("zombie_confused");
    setthreatbias("zombies", "zombie_confused", 1000);
    setthreatbias("zombie_confused", "zombies", 1000);
  }

  self.zomisconfused = 1;

  if(maps\mp\zombies\_util::istrapresistant() || isDefined(self.agent_type) && self.agent_type == "zombie_host") {
    return;
  }
  if(common_scripts\utility::cointoss()) {
    self setthreatbiasgroup("zombie_confused");
    maps\mp\agents\_agent_utility::set_agent_team(level.playerteam);
    thread sewergaszombiecleanup();
  }
}

sewergaszombiecleanup() {
  self endon("death");
  level endon("game_ended");
  var_0 = randomfloatrange(1, 2);
  var_1 = 10 * var_0;
  wait(var_1);
  self setthreatbiasgroup("zombies");
  maps\mp\agents\_agent_utility::set_agent_team(level.enemyteam);
}

sewergasciv() {
  self endon("death");
  level endon("game_ended");
  self.civiscamouflaged = 1;
  self.ignoreme = 1;
  var_0 = randomfloatrange(1, 2);
  wait(10 * var_0);
  self.civiscamouflaged = undefined;
  self.ignoreme = 0;
}

playersewergascamo() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(10);
  self allowsprint(0);
  var_0 = ["center", "right", "left"];

  foreach(var_2 in var_0) {
    thread sewergasoverlay(var_2);
  }

  wait 1.0;

  if(!maps\mp\zombies\_util::isplayerinlaststand(self)) {
    self allowsprint(1);
  }

  wait 2.0;
  self notify("remove_gas_overlay");
}

sewergasoverlay(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1 setshader("screen_blood_directional_" + var_0 + "_yellow", 640, 480);
  var_1.sort = -10;
  var_1.archived = 1;
  var_1.hidein3rdperson = 1;
  var_1.alpha = 0;
  _fadehudalpha(var_1, 1, 1);
  self waittill("remove_gas_overlay");
  _fadehudalpha(var_1, 0, 1);
  wait 1;
  var_1 destroy();
}

_fadehudalpha(var_0, var_1, var_2) {
  var_0 fadeovertime(var_2);
  var_0.alpha = var_1;
}