/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\usability.gsc
***********************************************/

function setselfusable(var0) {
  self makeusable();

  foreach(var2 in level.players) {
    if(var2 != var0) {
      self disableplayeruse(var2);
      continue;
    }

    self enableplayeruse(var2);
  }
}

function setallunusable() {
  foreach(var1 in level.players) {
    self disableplayeruse(var1);
  }
}

function maketeamusable(var0) {
  self makeusable();
  thread _updateteamusable(var0);
}

function _updateteamusable(var0) {
  self endon("death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2.team == var0) {
        self enableplayeruse(var2);
        continue;
      }

      self disableplayeruse(var2);
    }

    level waittill("joined_team");
  }
}

function makeenemyusable(var0, var1) {
  self makeusable();
  thread _updateenemyusable(var0, var1);
}

function _updateenemyusable(var0, var1) {
  self endon("death");
  var2 = var0.team;

  for(;;) {
    if(level.teambased) {
      foreach(var4 in level.players) {
        if(istrue(var1)) {
          if(var4.team != var2 || var4 == var0) {
            self enableplayeruse(var4);
          } else {
            self disableplayeruse(var4);
          }

          continue;
        }

        if(var4.team != var2) {
          self enableplayeruse(var4);
          continue;
        }

        self disableplayeruse(var4);
      }
    } else {
      foreach(var4 in level.players) {
        if(istrue(var1)) {
          self enableplayeruse(var4);
          continue;
        }

        if(var4 != var0) {
          self enableplayeruse(var4);
          continue;
        }

        self disableplayeruse(var4);
      }
    }

    level waittill("joined_team");
  }
}

function notusableforjoiningplayers(var0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  self endon("notusablejoiningplayers");
  self endon("makeExplosiveUnusable");

  for(;;) {
    level waittill("player_spawned", var1);

    if(isDefined(var1) && var1 != var0) {
      self disableplayeruse(var1);
    }
  }
}

function notusableafterownerchange(var0, var1) {
  self notify("notusableafterownerchange");
  self endon("death");
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  self endon("notusableafterownerchange");
  self endon("makeExplosiveUnusable");

  for(;;) {
    var1 waittill("ownerChanged");
    self disableplayeruse(var0);
  }
}