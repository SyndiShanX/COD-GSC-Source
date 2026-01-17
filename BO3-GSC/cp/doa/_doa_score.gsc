/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_score.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_utility;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace namespace_64c6b720;

function init() {}

function function_acd89108(note) {
  self endon("hash_a49bc808");
  self waittill(note);
  self notify("hash_7c5410c4");
}

function function_7c5410c4() {
  self endon("hash_acd89108");
  self waittill("hash_7c5410c4");
  foreach(player in namespace_831a4a7c::function_5eb6e4d1()) {
    if(isDefined(player.doa.timerhud)) {
      player closeluimenu(player.doa.timerhud);
      player.doa.timerhud = undefined;
    }
  }
  self notify("hash_a49bc808");
}

function function_92c929ab(val) {
  ret = (val << 2) + self.entnum;
  return ret;
}

function function_676edeb7() {
  self endon("disconnect");
  if(isDefined(self.doa)) {
    if(isDefined(self.doa.respawning) && self.doa.respawning) {
      var_132c0655 = math::clamp(self.var_9ea856f6 / 60, 0, 1);
      var_7d01b30f = 0;
      var_f63556d9 = 0;
    } else {
      var_132c0655 = math::clamp(self.doa.var_d55e6679 / level.doa.rules.var_d55e6679, 0, 1);
      var_7d01b30f = math::clamp(self.doa.var_91c268dc / getdvarint("scr_doa_weapon_increment_range", 1024), 0, 1);
      var_f63556d9 = self.doa.weaponlevel;
    }
    var_24b562d = (self.doa.var_db3637c0 << 2) + (self.doa.respawning ? 1 : 0);
    multiplier = self.doa.multiplier + self.doa.var_a3f61a60;
    max = level.doa.rules.max_multiplier;
    if(self.doa.fate == 11) {
      max++;
    }
    multiplier = math::clamp(multiplier, 0, max);
    self.score = int(self.doa.score / 25);
    self.headshots = (self.doa.lives << 12) + (self.doa.bombs << 8) + (self.doa.boosters << 4) + multiplier;
    self.downs = ((int(var_132c0655 * 255)) << 2) + var_f63556d9;
    self.revives = ((int(var_7d01b30f * 255)) << 2) + self.doa.var_9742391e;
    self.assists = var_24b562d;
  }
}

function function_93ccc5da() {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return 0;
  }
  return self.doa.score + (self.doa.var_db3637c0 * (int((int(4000000) * 25) - 1)));
}

function function_80eb303(points, var_c979daec = 0) {
  if(!level flag::get("doa_game_is_running")) {
    return;
  }
  if(!(isDefined(var_c979daec) && var_c979daec)) {
    multiplier = self.doa.multiplier + self.doa.var_a3f61a60;
    max = level.doa.rules.max_multiplier;
    if(self.doa.fate == 11) {
      max++;
    }
    multiplier = math::clamp(multiplier, 0, max);
    points = points * multiplier;
  }
  points = 25 * (int(points / 25));
  self.doa.var_e1956fd2 = self.doa.var_e1956fd2 + points;
  self.doa.score = self.doa.score + points;
  if(self.doa.score > (int((int(4000000) * 25) - 1))) {
    if(self.doa.var_db3637c0 < 3) {
      self.doa.score = 0;
      self.doa.var_db3637c0++;
      self.doa.var_295df6ca = level.doa.rules.var_61b88ecb;
    } else {
      self.doa.score = int((int(4000000) * 25) - 1);
    }
  }
  if(self.doa.score >= self.doa.var_295df6ca) {
    self.doa.var_295df6ca = self.doa.var_295df6ca + level.doa.rules.var_61b88ecb;
    max = level.doa.rules.max_lives;
    if(self.doa.fate == 11) {
      max++;
    }
    if(self.doa.lives < max) {
      self thread doa_pickups::directeditemawardto(self, "zombietron_extra_life");
    } else {
      if(randomint(100) > 50) {
        self thread doa_pickups::directeditemawardto(self, level.doa.var_326cdb5e);
      } else {
        self thread doa_pickups::directeditemawardto(self, level.doa.var_24fe9829);
      }
    }
  }
}

function function_126dc996(multiplier) {
  max = level.doa.rules.max_multiplier;
  if(self.doa.fate == 11) {
    max = max + 1;
  }
  self.doa.multiplier = doa_utility::clamp(multiplier, 1, max);
  self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
  if(self.doa.multiplier > 1) {
    for(reductions = self.doa.multiplier - 1; reductions; reductions--) {
      self.doa.var_5d2140f2 = doa_utility::clamp(int((self.doa.var_5d2140f2 * 0.65) + 0.69), 1, level.doa.rules.var_a9114441);
    }
  }
}

function function_850bb47e(increment, forcex) {
  if(!isDefined(forcex)) {
    if(!isDefined(increment)) {
      self.doa.var_d55e6679 = 0;
      self.doa.multiplier = 1;
      if(self.doa.fate == 2 || self.doa.fate == 11) {
        self.doa.multiplier = 2;
      }
      self function_126dc996(self.doa.multiplier);
      return;
    }
    if(!increment) {
      return;
    }
    var_6281aed1 = self.doa.var_5d2140f2 / level.doa.rules.var_a9114441;
    var_9903a63d = int(increment * var_6281aed1);
    self.doa.var_d55e6679 = int(self.doa.var_d55e6679 + var_9903a63d);
    if(self.doa.var_d55e6679 > level.doa.rules.var_d55e6679) {
      self function_126dc996(self.doa.multiplier + 1);
      self.doa.var_d55e6679 = self.doa.var_d55e6679 - level.doa.rules.var_d55e6679;
    }
  } else {
    self.doa.multiplier = forcex;
    self.doa.var_d55e6679 = level.doa.rules.var_d55e6679;
  }
}