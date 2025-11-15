/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\targetting_delay.gsc
***********************************************/

#namespace targetting_delay;

function_7e1a12ce(radius) {
  self endon(#"death");
  level endon(#"game_ended");

  if(!isDefined(radius)) {
    radius = 8000;
  }

  self.var_5ddd7c26 = {};
  info = self.var_5ddd7c26;
  info.var_d1e06a5f = [];
  info.var_2fae95e = [];
  update_interval = isDefined(self.var_ab84134) ? self.var_ab84134 : min(0.25, 1);
  var_dd3b2438 = int(update_interval * 1000);

  while(true) {
    enemy_players = self getenemiesinradius(self.origin, radius);

    foreach(enemy in enemy_players) {
      if(!isplayer(enemy)) {
        continue;
      }

      delay = int(max(enemy function_9bd25293(), 250));

      if(delay <= 0) {
        continue;
      }

      entnum = enemy getentitynumber();

      if(isDefined(info.var_d1e06a5f[entnum]) && (!isalive(enemy) || isDefined(enemy.lastspawntime) && enemy.lastspawntime > info.var_d1e06a5f[entnum])) {
        info.var_d1e06a5f[entnum] = undefined;
        info.var_2fae95e[entnum] = undefined;
      }

      if(!isalive(enemy)) {
        continue;
      }

      if(issentient(self) && self cansee(enemy)) {
        if(!isDefined(info.var_2fae95e[entnum])) {
          info.var_2fae95e[entnum] = 0;
        }

        if(info.var_2fae95e[entnum] < delay) {
          self setpersonalignore(enemy, update_interval);
        }

        info.var_d1e06a5f[entnum] = gettime();
        info.var_2fae95e[entnum] += var_dd3b2438;
        continue;
      }

      if(isDefined(info.var_d1e06a5f[entnum])) {
        resettime = int(max(enemy function_348ab5dd(), 250));

        if(gettime() - info.var_d1e06a5f[entnum] > resettime) {
          info.var_d1e06a5f[entnum] = undefined;
          info.var_2fae95e[entnum] = undefined;
        }
      }
    }

    wait update_interval;
  }
}

function_1c169b3a(enemy, defaultdelay = 250) {
  if(!isplayer(enemy)) {
    return true;
  }

  delay = int(max(enemy function_9bd25293(), defaultdelay));

  if(delay <= 0) {
    return true;
  }

  info = self.var_5ddd7c26;

  if(!isDefined(info) || !isDefined(info.var_2fae95e)) {
    return false;
  }

  if((isDefined(info.var_2fae95e[enemy getentitynumber()]) ? info.var_2fae95e[enemy getentitynumber()] : 0) < delay) {
    return false;
  }

  return true;
}

function_a4d6d6d8(enemy, var_2770319) {
  if(!isplayer(enemy)) {
    return;
  }

  delay = int(max(enemy function_9bd25293(), 250));

  if(delay <= 0) {
    return;
  }

  if(!isDefined(var_2770319)) {
    var_2770319 = delay;
  }

  info = self.var_5ddd7c26;

  if(!isDefined(info) || !isDefined(info.var_2fae95e)) {
    return;
  }

  entnum = enemy getentitynumber();

  if(!isDefined(info.var_2fae95e[entnum])) {
    info.var_2fae95e[entnum] = 0;
  }

  info.var_2fae95e[entnum] += var_2770319;
}