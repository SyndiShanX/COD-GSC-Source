/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58319.gsc
***********************************************/

function ref_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  if(isalive(var_0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, var_1, var_3);
    return;
  }

  thread ref_12981(var_0);
}

function ref_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, var_0, var_4);
      continue;
    }

    if(!isDefined(var_4)) {
      var_4 = spawnStruct();
    }

    var_4.intvar = var_1;
    var_4.ref_136f3 = var_0;
    thread ref_12981(var_3);
  }
}

function ref_12981(var_0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var_2.ref_136f3, var_2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}