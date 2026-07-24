/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\elvira\elvira_agent.gsc
*****************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\elvira::_id_DEE8();
  scripts\asm\elvira\mp\states::_id_2371();
  scripts\mp\agents\elvira\elvira_tunedata::setuptunedata();
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

  level.species_funcs["elvira"] = [];
  level.agent_definition["elvira"]["setup_func"] = ::setupagent;
  level.agent_definition["elvira"]["setup_model_func"] = ::_id_FACE;
}

_id_FACE(var_0) {
  self setModel("fullbody_zmb_hero_elvira");
}

setupagent() {
  self.accuracy = 0.8;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.maxsightdistsqrd = 67108864;
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
  self._id_B62D = 70;
  self._id_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self._id_B62E);
  self.meleedot = 0.5;
  self._id_B601 = 9999;
  self._id_129AF = 55;
  self.radius = 15;
  self.height = 65;
  self.allowpain = 0;
  _id_FAFE();
  thread _id_899D();
  level.the_hoff_revive = 1;
  thread elviracleanup();
}

elviracleanup() {
  self waittill("death");
  level.the_hoff_revive = undefined;
}

_id_FAFE() {
  self.targetcrawlerfunction = ::_id_11562;
  self.targetingfunctions = [::_id_11562, ::_id_11559, ::_id_1156F, ::_id_1157B, ::_id_11570];
  self.targetingfunctionchances = [0, 47, 21, 21, 11];
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

picktargetingfunction() {
  if(isDefined(self.enemy) && isDefined(self.enemy.dismember_crawl) && self.enemy.dismember_crawl) {
    if(isDefined(self.targetcrawlerfunction)) {
      return self.targetcrawlerfunction;
    }
  }

  var_0 = 0;
  var_1 = randomint(100);

  for(var_2 = 0; var_2 < self.targetingfunctionchances.size; var_2++) {
    var_3 = self.targetingfunctionchances[var_2];

    if(var_1 < var_3 + var_0) {
      return self.targetingfunctions[var_2];
    }

    var_0 = var_0 + var_3;
  }

  return undefined;
}

_id_7E8E() {
  var_0 = self.enemy gettagorigin("j_head");
  return var_0;
}

getdefaultenemychestpos() {
  if(scripts\engine\utility::is_true(self.dismember_crawl)) {
    return _id_7E8E();
  }

  var_0 = 70;
  var_1 = 15;

  if(isDefined(self.enemy._id_18F4)) {
    var_0 = self.enemy._id_18F4;
    var_1 = self.enemy._id_18F9;
  }

  var_2 = var_0 * 0.75;
  var_3 = (0, 0, var_2);
  var_4 = self.enemy.origin + var_3;
  return var_4;
}

getenemy() {
  return self.enemy;
}