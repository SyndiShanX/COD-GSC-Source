/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\usability.gsc
***********************************************/

#namespace usability;

function setselfusable(caller) {
  self makeusable();

  foreach(player in level.players) {
    if(player != caller) {
      self disableplayeruse(player);
      continue;
    }

    self enableplayeruse(player);
  }
}

function setallunusable() {
  foreach(player in level.players) {
    self disableplayeruse(player);
  }
}

function maketeamusable(team) {
  self makeusable();
  thread _updateteamusable(team);
}

function _updateteamusable(team) {
  self endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(player.team == team) {
        self enableplayeruse(player);
        continue;
      }

      self disableplayeruse(player);
    }

    level waittill("joined_team");
  }
}

function makeenemyusable(owner, var_418a5c9b9391dfc7) {
  self makeusable();
  thread _updateenemyusable(owner, var_418a5c9b9391dfc7);
}

function _updateenemyusable(owner, var_418a5c9b9391dfc7) {
  self endon("death");
  team = owner.team;

  for(;;) {
    if(level.teambased) {
      foreach(player in level.players) {
        if(istrue(var_418a5c9b9391dfc7)) {
          if(player.team != team || player == owner) {
            self enableplayeruse(player);
          } else {
            self disableplayeruse(player);
          }

          continue;
        }

        if(player.team != team) {
          self enableplayeruse(player);
          continue;
        }

        self disableplayeruse(player);
      }
    } else {
      foreach(player in level.players) {
        if(istrue(var_418a5c9b9391dfc7)) {
          self enableplayeruse(player);
          continue;
        }

        if(player != owner) {
          self enableplayeruse(player);
          continue;
        }

        self disableplayeruse(player);
      }
    }

    level waittill("joined_team");
  }
}

function notusableforjoiningplayers(owner) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  owner endon("death_or_disconnect");
  self endon("notusablejoiningplayers");
  self endon("makeExplosiveUnusable");

  while(true) {
    level waittill("player_spawned", player);

    if(isDefined(self) && isDefined(player) && player != owner) {
      self disableplayeruse(player);
    }
  }
}

function notusableafterownerchange(owner, equipment) {
  self notify("notusableafterownerchange");
  self endon("death");
  level endon("game_ended");
  owner endon("death_or_disconnect");
  self endon("notusableafterownerchange");
  self endon("makeExplosiveUnusable");

  while(true) {
    equipment waittill("ownerChanged");
    self disableplayeruse(owner);
  }
}