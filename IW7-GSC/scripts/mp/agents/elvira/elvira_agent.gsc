/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\elvira\elvira_agent.gsc
*****************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\elvira::func_DEE8();
  scripts\asm\elvira\mp\states::func_2371();
  scripts\mp\agents\elvira\elvira_tunedata::setuptunedata();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.species_funcs["elvira"] = [];
  level.agent_definition["elvira"]["setup_func"] = ::setupagent;
  level.agent_definition["elvira"]["setup_model_func"] = ::func_FACE;
}

func_FACE(param_00) {
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
  self.var_1A44 = 50;
  self.var_B62D = 70;
  self.var_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.meleedot = 0.5;
  self.var_B601 = 9999;
  self.var_129AF = 55;
  self.fgetarg = 15;
  self.height = 65;
  self.allowpain = 0;
  func_FAFE();
  thread func_899D();
  level.the_hoff_revive = 1;
  thread elviracleanup();
}

elviracleanup() {
  self waittill("death");
  level.the_hoff_revive = undefined;
}

func_FAFE() {
  self.targetcrawlerfunction = ::func_11562;
  self.targetingfunctions = [::func_11562, ::func_11559, ::func_1156F, ::func_1157B, ::func_11570];
  self.targetingfunctionchances = [0, 47, 21, 21, 11];
}

func_899D() {
  self endon("death");
  for(;;) {
    self waittill("enemy");
    for(;;) {
      if(isDefined(self.isnodeoccupied)) {
        self.var_6571 = gettime() + 1000;
      } else if(isDefined(self.var_6571)) {
        if(gettime() > self.var_6571) {
          self.var_6571 = undefined;
          break;
        }
      }

      wait(0.25);
    }
  }
}

func_11570() {
  var_00 = 70;
  var_01 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.25, 0.35);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_06[0] * var_05, var_06[1] * var_05, var_02);
  var_08 = self.isnodeoccupied.origin + var_07;
  return var_08;
}

func_1157B() {
  var_00 = 70;
  var_01 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_04[0] * var_03, var_04[1] * var_03, var_02);
  var_06 = self.isnodeoccupied.origin + var_05;
  return var_06;
}

func_1156F() {
  var_00 = 70;
  var_01 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * -0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_04[0] * var_03, var_04[1] * var_03, var_02);
  var_06 = self.isnodeoccupied.origin + var_05;
  return var_06;
}

func_11559() {
  var_00 = 70;
  var_01 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_06[0] * var_05, var_06[1] * var_05, var_02);
  var_08 = self.isnodeoccupied.origin + var_07;
  return var_08;
}

func_11562() {
  var_00 = self.isnodeoccupied gettagorigin("j_head");
  return var_00;
}

picktargetingfunction() {
  if(isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.dismember_crawl) && self.isnodeoccupied.dismember_crawl) {
    if(isDefined(self.targetcrawlerfunction)) {
      return self.targetcrawlerfunction;
    }
  }

  var_00 = 0;
  var_01 = randomint(100);
  for(var_02 = 0; var_02 < self.targetingfunctionchances.size; var_02++) {
    var_03 = self.targetingfunctionchances[var_02];
    if(var_01 < var_03 + var_00) {
      return self.targetingfunctions[var_02];
    }

    var_00 = var_00 + var_03;
  }

  return undefined;
}

func_7E8E() {
  var_00 = self.isnodeoccupied gettagorigin("j_head");
  return var_00;
}

getdefaultenemychestpos() {
  if(scripts\engine\utility::istrue(self.dismember_crawl)) {
    return func_7E8E();
  }

  var_00 = 70;
  var_01 = 15;
  if(isDefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * 0.75;
  var_03 = (0, 0, var_02);
  var_04 = self.isnodeoccupied.origin + var_03;
  return var_04;
}

getenemy() {
  return self.isnodeoccupied;
}