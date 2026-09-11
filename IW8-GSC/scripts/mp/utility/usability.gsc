/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\usability.gsc
***********************************************/

function setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

function setallunusable() {
  foreach(var_1 in level.players) {
    self disableplayeruse(var_1);
  }
}

function maketeamusable(var_0) {
  self makeusable();
  thread _updateteamusable(var_0);
}

function _updateteamusable(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
    }

    level waittill("joined_team");
  }
}

function makeenemyusable(var_0, var_1) {
  self makeusable();
  thread _updateenemyusable(var_0, var_1);
}

function _updateenemyusable(var_0, var_1) {
  self endon("death");
  var_2 = var_0.team;

  for(;;) {
    if(level.teambased) {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          if(var_4.team != var_2 || var_4 == var_0) {
            self enableplayeruse(var_4);
          } else {
            self disableplayeruse(var_4);
          }

          continue;
        }

        if(var_4.team != var_2) {
          self enableplayeruse(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    } else {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          self enableplayeruse(var_4);
          continue;
        }

        if(var_4 != var_0) {
          self enableplayeruse(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    }

    level waittill("joined_team");
  }
}

function notusableforjoiningplayers(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  self endon("notusablejoiningplayers");
  self endon("makeExplosiveUnusable");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
  }
}

function notusableafterownerchange(var_0, var_1) {
  self notify("notusableafterownerchange");
  self endon("death");
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  self endon("notusableafterownerchange");
  self endon("makeExplosiveUnusable");

  for(;;) {
    var_1 waittill("ownerChanged");
    self disableplayeruse(var_0);
  }
}