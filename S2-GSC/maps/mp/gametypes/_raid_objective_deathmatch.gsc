/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_objective_deathmatch.gsc
************************************************************/

initraiddeathmatchobjectives() {
  var_00 = lib_0502::func_2548("deathmatchObjective", ::deathmatchobjectiveinit);
  var_01 = lib_0502::func_2548("deathmatchSubObjective", ::deathmatchsubobjectiveinit);
}

deathmatchobjectiveinit(param_00) {
  var_01 = 2;
  lib_04FF::func_6934(param_00);
  var_02 = common_scripts\utility::func_46B7(param_00.var_81EF, "script_linkname");
  foreach(var_04 in var_02) {
    if(var_04.var_82B2 == "attackers") {
      self.attackerobj = var_04;
      continue;
    }

    if(var_04.var_82B2 == "defenders") {
      self.defenderobj = var_04;
      continue;
    }
  }

  lib_04FF::func_6983(self.var_1A5);
  param_00.var_1A7 = param_00.var_82B2;
  param_00.var_6BB6 = ::deathmatchobjectiveontimelimit;
  param_00 thread rundeathmatchobjective();
}

deathmatchobjectiveontimelimit() {
  var_00 = self.attackerobj.currentscore == self.defenderobj.currentscore;
  var_01 = level.var_984F[game["attackers"]] > 0;
  var_02 = level.var_984F[game["defenders"]] > 0;
  if(var_00 && !var_01 || !var_02) {
    var_03 = 0;
    if(var_01) {
      var_03 = self.var_82B2 == "attackers";
    } else if(var_02) {
      var_03 = self.var_82B2 == "defenders";
    } else {}

    self notify("deathmatch_complete", var_03);
    return;
  }

  deathmatchawardwinfromscore();
}

deathmatchawardwinfromscore() {
  var_00 = undefined;
  if(self.attackerobj.currentscore < self.defenderobj.currentscore) {
    var_00 = self.var_82B2 == "attackers";
  } else {
    var_00 = self.var_82B2 == "defenders";
  }

  self notify("deathmatch_complete", var_00);
}

deathmatchmonitorobjectivecomplete() {
  level endon("game_ended");
  self endon("deathmatch_complete");
  lib_04FF::func_6982(self.var_1A5);
  deathmatchawardwinfromscore();
}

deathmatchmonitorscorelimit(param_00) {
  level endon("game_ended");
  self endon("deathmatch_complete");
  param_00 waittill("deathmatch_score_limit_reached");
  var_01 = param_00.var_82B2 == self.var_82B2;
  self notify("deathmatch_complete", var_01);
}

rundeathmatchobjective() {
  lib_04FF::func_6972(self.attackerobj.var_1A5);
  lib_04FF::func_6972(self.defenderobj.var_1A5);
  thread deathmatchovertimeupdate(self);
  thread deathmatchmonitorobjectivecomplete();
  thread deathmatchmonitorscorelimit(self.attackerobj);
  thread deathmatchmonitorscorelimit(self.defenderobj);
  var_00 = undefined;
  self waittill("deathmatch_complete", var_00);
  self.objectivesuccess = var_00;
  wait 0.05;
  if(!var_00) {
    lib_0502::raidobjectivefailure(1);
    return;
  }

  if(!lib_04FF::func_5761(self.var_1A5)) {
    lib_04FF::func_6935(self.var_1A5);
  }

  wait 0.05;
  if(!lib_04FF::func_5761(self.attackerobj.var_1A5)) {
    lib_04FF::func_6935(self.attackerobj.var_1A5);
  }

  if(!lib_04FF::func_5761(self.defenderobj.var_1A5)) {
    lib_04FF::func_6935(self.defenderobj.var_1A5);
  }
}

deathmatchobjectupdatescore(param_00, param_01) {
  if(param_00 == "attackers") {
    self.attackerobj deathmatchsubobjectiveupdatescore(param_01);
    return;
  }

  if(param_00 == "defenders") {
    self.defenderobj deathmatchsubobjectiveupdatescore(param_01);
    return;
  }
}

deathmatchovertimeupdate(param_00) {
  level endon("game_ended");
  self endon("deathmatch_complete");
  for(;;) {
    var_01 = self.attackerobj.currentscore == self.defenderobj.currentscore;
    var_02 = level.var_984F[game["attackers"]] > 0;
    var_03 = level.var_984F[game["defenders"]] > 0;
    var_04 = lib_04FF::func_79B8() / 1000 < 120;
    if(var_01 && var_02 && var_03 && var_04) {
      lib_04FF::func_6981(param_00.var_1A5);
    }

    wait 0.05;
  }
}

deathmatchsubobjectiveinit(param_00) {
  lib_04FF::func_6934(param_00);
  param_00.scoretowin = lib_0501::func_4648("deathmatch_scoreLimit");
  param_00.currentscore = param_00.scoretowin;
  lib_04FF::func_6983(self.var_1A5);
  param_00.var_1A7 = game[param_00.var_82B2];
  self.var_651B = 1;
  var_01 = lib_04FF::func_27DE(param_00.var_81E8, param_00.var_82B2, self.var_116);
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("none");
  param_00.var_2563 = var_01;
  param_00 thread rundeathmatchsubobjective();
}

rundeathmatchsubobjective() {
  thread deathmatchsubobjectiveimagetimer(self.var_2563);
  lib_04FF::func_6982(self.var_1A5);
  deathmatchsubobjectivecleanup();
  if(self.currentscore <= 0) {
    self notify("deathmatch_score_limit_reached");
  }
}

deathmatchsubobjectiveimagetimer(param_00) {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_01 = self.scoretowin * 1000;
  param_00.var_A23F = var_01;
  var_02 = lib_0502::func_4518("deathmatch", self.var_81E1);
  param_00 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_01, var_02, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.scoretowin);
  param_00 lib_04FF::func_860A(var_02);
  for(;;) {
    if(self.currentscore != self.scoretowin) {
      var_03 = self.scoretowin - self.currentscore * 1000;
      param_00 lib_04FF::func_8615(var_03);
    }

    self waittill("deathmatch_team_score");
  }
}

deathmatchsubobjectivecleanup() {
  self.var_2563 lib_04FF::func_7CCA();
}

deathmatchsubobjectiveupdatescore(param_00) {
  self.currentscore = self.currentscore + param_00;
  self notify("deathmatch_team_score");
  if(self.currentscore == 0) {
    lib_04FF::func_6935(self.var_1A5);
  }
}