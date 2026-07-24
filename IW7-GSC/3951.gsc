/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3951.gsc
**************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  _id_03A9::_id_DEE8();
  _id_0F37::_id_2371();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.species_funcs["the_hoff"] = [];
  level.agent_definition["the_hoff"]["setup_func"] = ::setupagent;
  level.agent_definition["the_hoff"]["setup_model_func"] = ::_id_FACE;
}

setupagent() {
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 500;
  self.desiredenemydistmin = 400;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.maxsightdistsqrd = 67108864;
  self.backawayenemydist = self.desiredenemydistmin - 100;
  self.meleerangesq = 9216;
  self.meleechargedist = 45;
  self.meleechargedistvsplayer = 45;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 300;
  self.meleemaxdamage = 450;
  self.footstepdetectdist = 1000;
  self.footstepdetectdistwalk = 1000;
  self.footstepdetectdistsprint = 1000;
  self._id_1A44 = 50;
  _id_FAFE();
  thread scriptedgoalwaitforarrival();
  thread _id_899D();
}

_id_FAFE() {
  self._id_3402 = ::_id_11562;
  self._id_3404 = [::_id_11562, ::_id_11559, ::_id_1156F, ::_id_1157B, ::_id_11570];
  self._id_3403 = [0, 47, 21, 21, 11];
}

_id_899D() {
  self endon("death");

  for(;;) {
    self waittill("enemy");

    for(;;) {
      if(isDefined(self.enemy)) {
        self._id_6571 = gettime() + 1000;
      } else if(isDefined(self._id_6571)) {
        if(gettime() > self._id_6571) {
          self._id_6571 = undefined;
          break;
        }
      }

      wait 0.25;
    }
  }
}

_id_11570() {
  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy._id_18F4)) {
    var_0 = self.enemy._id_18F4;
    var_1 = self.enemy._id_18F9;
  }

  var_2 = var_0 * randomfloatrange(0.25, 0.35);
  var_3 = var_1 * 0.5;
  var_4 = var_3 * -1;
  var_5 = randomfloatrange(var_4, var_3);
  var_6 = anglestoright(self.angles);
  var_7 = (var_6[0] * var_5, var_6[1] * var_5, var_2);
  var_8 = self.enemy.origin + var_7;
  return var_8;
}

_id_1157B() {
  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy._id_18F4)) {
    var_0 = self.enemy._id_18F4;
    var_1 = self.enemy._id_18F9;
  }

  var_2 = var_0 * randomfloatrange(0.65, 0.75);
  var_3 = var_1 * 0.75;
  var_4 = anglestoright(self.angles);
  var_5 = (var_4[0] * var_3, var_4[1] * var_3, var_2);
  var_6 = self.enemy.origin + var_5;
  return var_6;
}

_id_1156F() {
  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy._id_18F4)) {
    var_0 = self.enemy._id_18F4;
    var_1 = self.enemy._id_18F9;
  }

  var_2 = var_0 * randomfloatrange(0.65, 0.75);
  var_3 = var_1 * -0.75;
  var_4 = anglestoright(self.angles);
  var_5 = (var_4[0] * var_3, var_4[1] * var_3, var_2);
  var_6 = self.enemy.origin + var_5;
  return var_6;
}

_id_11559() {
  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy._id_18F4)) {
    var_0 = self.enemy._id_18F4;
    var_1 = self.enemy._id_18F9;
  }

  var_2 = var_0 * randomfloatrange(0.65, 0.75);
  var_3 = var_1 * 0.5;
  var_4 = var_3 * -1;
  var_5 = randomfloatrange(var_4, var_3);
  var_6 = anglestoright(self.angles);
  var_7 = (var_6[0] * var_5, var_6[1] * var_5, var_2);
  var_8 = self.enemy.origin + var_7;
  return var_8;
}

_id_11562() {
  var_0 = self.enemy gettagorigin("j_head");
  return var_0;
}

scriptedgoalwaitforarrival() {
  self endon("death");

  for(;;) {
    self waittill("goal_reached");

    if(isDefined(self._id_EF7D)) {
      var_0 = self._id_EF7D;
    } else if(isDefined(self._id_EF7A)) {
      var_0 = self._id_EF7A.origin;
    } else if(isDefined(self._id_EF7C)) {
      var_0 = self._id_EF7C.origin;
    } else {
      continue;
    }

    var_1 = 16;

    if(isDefined(self._id_EF7E)) {
      var_1 = self._id_EF7E * self._id_EF7E;
    }

    if(distance2dsquared(self.origin, var_0) <= var_1) {
      self._id_EF7D = undefined;
      self._id_EF7C = undefined;

      if(!isDefined(self._id_EF7B)) {
        self._id_EF7A = undefined;
      }

      self notify("scriptedGoal_reached");
    }
  }
}

_id_F834(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self._id_EF79 = var_1;
  self._id_EF73 = var_0;
}

_id_F835(var_0, var_1) {
  self._id_EF7A = undefined;
  self._id_EF7B = undefined;
  self._id_EF7C = undefined;
  self._id_EF7D = var_0;
  self._id_EF7E = var_1;
}

_id_F833(var_0, var_1) {
  self._id_EF7D = undefined;
  self._id_EF7A = undefined;
  self._id_EF7B = undefined;
  self._id_EF7C = var_0;
  self._id_EF7E = var_1;
}

_id_F832(var_0, var_1, var_2) {
  self._id_EF7D = undefined;
  self._id_EF7C = undefined;
  self._id_EF7A = var_0;
  self._id_EF7E = var_1;

  if(isDefined(var_2) && var_2) {
    self._id_EF7B = var_2;
  } else {
    self._id_EF7B = undefined;
  }
}

_id_41D9() {
  if(isDefined(self._id_EF7D) || isDefined(self._id_EF7A) || isDefined(self._id_EF7C)) {
    self._id_EF7D = undefined;
    self._id_EF7A = undefined;
    self._id_EF7B = undefined;
    self._id_EF7C = undefined;
    self clearpath();
  }
}

_id_FACE(var_0) {
  self setModel("body_zmb_hero_dj_agent");
}