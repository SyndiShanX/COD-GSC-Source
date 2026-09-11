/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58319.gsc
***********************************************/

function ref_12425(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  if(isalive(var0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
    return;
  }

  thread ref_12981(var0);
}

function ref_12424(var0, var1) {
  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = undefined;

    if(isalive(var3)) {
      if(isDefined(var1)) {
        var4 = spawnStruct();
        var4.intvar = var1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var3, var0, var4);
      continue;
    }

    if(!isDefined(var4)) {
      var4 = spawnStruct();
    }

    var4.intvar = var1;
    var4.ref_136f3 = var0;
    thread ref_12981(var3);
  }
}

function ref_12981(var0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var2.ref_136f3, var2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}