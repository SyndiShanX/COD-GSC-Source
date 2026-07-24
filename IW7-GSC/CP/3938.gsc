/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3938.gsc
**************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  _id_03A9::_id_DEE8();
  _id_0F37::_id_2371();

  if(level.gametype != "zombie")
    _id_09FD::_id_3353();

  _id_9812();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

  if(!isDefined(level.species_funcs))
    level.species_funcs = [];

  level.species_funcs["c6"] = [];
  level.agent_definition["c6"]["setup_func"] = ::setupagent;
}

setupagent() {
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 360;
  self.desiredenemydistmin = 340;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.backawayenemydist = self.desiredenemydistmin - 100;
  self.fastcrawlanimscale = 12;
  self.forcefastcrawldist = 340;
  self.fastcrawlmaxhealth = 40;
  self.dismemberchargeexplodedistsq = 2500;
  self.explosionradius = 75;
  self.explosiondamagemin = 30;
  self.explosiondamagemax = 50;
  self.meleerangesq = 9216;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 250;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 30;
  self.meleemaxdamage = 45;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self._id_1A44 = 50;
  _id_FAFE();
  thread scriptedgoalwaitforarrival();
  thread _id_899D();
}

_id_FAFE() {
  self._id_3402 = ::_id_11562;
  self._id_3404 = [::_id_11562, ::_id_11559, ::_id_1156F, ::_id_1157B, ::_id_11570];
  self._id_3403 = [15, 40, 17, 17, 11];
}

_id_899D() {
  self endon("death");

  for(;;) {
    self waittill("enemy");

    for(;;) {
      if(isDefined(self.enemy))
        self._id_6571 = gettime() + 1000;
      else if(isDefined(self._id_6571)) {
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

_id_2475() {
  if(isDefined(self._id_2AB4) && self._id_2AB4 == 0) {
    return;
  }
  self.voice = "american";
  self _meth_82C6("cloth");
  self attach("robot_c6_armor");
  var_0 = [];
  var_0["tag_armor_head_ri"] = 165;
  var_0["tag_armor_head_le"] = 165;
  var_0["tag_armor_head_front"] = 165;
  var_0["tag_armor_forearm_le"] = 120;
  var_0["tag_armor_bicep_le"] = 120;
  var_0["tag_armor_forearm_ri"] = 120;
  var_0["tag_armor_bicep_ri"] = 120;
  var_0["tag_armor_chest_upper_le"] = 165;
  var_0["tag_armor_chest_upper_ri"] = 165;
  var_0["tag_armor_back_upper"] = 165;
  var_0["tag_armor_chest_stomach"] = 165;
  var_0["tag_armor_back_lower"] = 165;
  var_0["tag_armor_leg_thigh_front_le"] = 120;
  var_0["tag_armor_leg_thigh_back_le"] = 120;
  var_0["tag_armor_leg_thigh_front_ri"] = 120;
  var_0["tag_armor_leg_thigh_back_ri"] = 120;
  var_0["tag_armor_kneepad_behind_le"] = 50;
  var_0["tag_armor_kneepad_down_le"] = 50;
  var_0["tag_armor_kneepad_upper_le"] = 50;
  var_0["tag_armor_kneepad_behind_ri"] = 50;
  var_0["tag_armor_kneepad_down_ri"] = 50;
  var_0["tag_armor_kneepad_upper_ri"] = 50;
  self._id_2AB4 = 1;
}

setupdestructibleparts() {
  self._id_2AB5 = 1;
}

_id_17CC(var_0, var_1) {
  if(!isDefined(anim._id_85DF)) {
    anim._id_85DF = [];
    anim._id_85E1 = [];
  }

  var_2 = anim._id_85DF.size;
  anim._id_85DF[var_2] = var_0;
  anim._id_85E1[var_2] = var_1;
}

_id_9812() {
  _id_17CC(0, (41.5391, 7.28883, 72.2128));
  _id_17CC(1, (34.8849, -4.77048, 74.0488));
}

scriptedgoalwaitforarrival() {
  self endon("death");

  for(;;) {
    self waittill("goal_reached");

    if(isDefined(self._id_EF7D))
      var_0 = self._id_EF7D;
    else if(isDefined(self._id_EF7A))
      var_0 = self._id_EF7A.origin;
    else if(isDefined(self._id_EF7C))
      var_0 = self._id_EF7C.origin;
    else
      continue;

    var_1 = 16;

    if(isDefined(self._id_EF7E))
      var_1 = self._id_EF7E * self._id_EF7E;

    if(distance2dsquared(self.origin, var_0) <= var_1) {
      self._id_EF7D = undefined;
      self._id_EF7C = undefined;

      if(!isDefined(self._id_EF7B))
        self._id_EF7A = undefined;

      self notify("scriptedGoal_reached");
    }
  }
}

_id_F834(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

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

  if(isDefined(var_2) && var_2)
    self._id_EF7B = var_2;
  else
    self._id_EF7B = undefined;
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