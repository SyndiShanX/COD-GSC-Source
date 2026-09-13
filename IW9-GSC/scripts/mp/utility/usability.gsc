/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\usability.gsc
***********************************************/

setselfusable(caller) {
  self makeusable();

  foreach(player in level.players) {
    if(player != caller) {
      self disableplayeruse(player);
      continue;
    }

    self enableplayeruse(player);
  }
}

setallunusable() {
  foreach(player in level.players)
  self disableplayeruse(player);
}

maketeamusable(team) {
  self makeusable();
  thread _updateteamusable(team);
}

_updateteamusable(team) {
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

makeenemyusable(owner, _id_418A5C9B9391DFC7) {
  self makeusable();
  thread _updateenemyusable(owner, _id_418A5C9B9391DFC7);
}

_updateenemyusable(owner, _id_418A5C9B9391DFC7) {
  self endon("death");
  team = owner.team;

  for(;;) {
    if(level.teambased) {
      foreach(player in level.players) {
        if(istrue(_id_418A5C9B9391DFC7)) {
          if(player.team != team || player == owner)
            self enableplayeruse(player);
          else
            self disableplayeruse(player);

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
        if(istrue(_id_418A5C9B9391DFC7)) {
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

notusableforjoiningplayers(owner) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  owner endon("death_or_disconnect");
  self endon("notusablejoiningplayers");
  self endon("makeExplosiveUnusable");

  for(;;) {
    level waittill("player_spawned", player);

    if(isDefined(self) && isDefined(player) && player != owner)
      self disableplayeruse(player);
  }
}

notusableafterownerchange(owner, equipment) {
  self notify("notusableafterownerchange");
  self endon("death");
  level endon("game_ended");
  owner endon("death_or_disconnect");
  self endon("notusableafterownerchange");
  self endon("makeExplosiveUnusable");

  for(;;) {
    equipment waittill("ownerChanged");
    self disableplayeruse(owner);
  }
}