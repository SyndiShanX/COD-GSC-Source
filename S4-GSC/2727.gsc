/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2727.gsc
*************************************************/

_id_D6C2(var_0) {
  self makeuseable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self _meth_80E0(var_2);
  }
}

_id_D46B() {
  foreach(var_1 in level.players) {
    self disableplayeruse(var_1);
  }
}

_id_9A0F(var_0) {
  self makeuseable();
  thread _id_0DAF(var_0);
}

_id_0DAF(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self _meth_80E0(var_2);
        continue;
      }

      self disableplayeruse(var_2);
    }

    level waittill("joined_team");
  }
}

_id_99E7(var_0, var_1) {
  self makeuseable();
  thread _id_0DA8(var_0, var_1);
}

_id_0DA8(var_0, var_1) {
  self endon("death");
  var_2 = var_0.team;

  for(;;) {
    if(level.teambased) {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          if(var_4.team != var_2 || var_4 == var_0) {
            self _meth_80E0(var_4);
          } else {
            self disableplayeruse(var_4);
          }

          continue;
        }

        if(var_4.team != var_2) {
          self _meth_80E0(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    } else {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          self _meth_80E0(var_4);
          continue;
        }

        if(var_4 != var_0) {
          self _meth_80E0(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    }

    level waittill("joined_team");
  }
}

_id_A6C3(var_0) {
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

_id_A6C2(var_0, var_1) {
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