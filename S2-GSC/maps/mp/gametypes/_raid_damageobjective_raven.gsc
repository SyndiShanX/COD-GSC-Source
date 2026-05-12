/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_damageobjective_raven.gsc
*************************************************************/

func_533B() {
  var_00 = lib_0502::func_2548("destructionObjective", ::func_2E32);
  var_01 = var_00 lib_0502::func_2548("destructionTarget", ::func_2E34);
  var_02 = var_01 lib_0502::func_2548("destructionNode");
  var_03 = var_01 lib_0502::func_2548("ownedByParent", ::lib_0502::ces_setownedbyparent);
  var_04 = var_00 lib_0502::func_2548("destructionOvertimeZone", ::destructionovertimezoneinit);
}

func_2E32(param_00) {
  lib_04FF::func_6934(param_00);
  param_00.overtimezone = undefined;
  self.var_6940 = ::destructionobjectivecenter;
  lib_04FF::func_6965("objectHealth", 300, []);
  var_01 = [10, 8, 5, 2.5, 1];
  lib_04FF::func_6961("OvertimeDurationArray", var_01);
  lib_04FF::func_6983(self.var_1A5);
  param_00.var_1A7 = game["attackers"];
  var_02 = lib_04FF::func_27DE("A", param_00.var_1A7, self.var_116);
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  param_00.var_2563 = var_02;
  param_00.totalobjects = 0;
  param_00.var_6896 = 0;
  param_00.var_294F = 0;
  param_00.damagedobjects = 0;
  func_52FB(param_00);
  param_00 thread func_7F99();
  thread destructionresetprops();
}

destructionobjectivecenter() {
  return self;
}

func_7F99() {
  wait 0.05;
  lib_04FF::func_6983(self.var_1A5);
  thread runovertimezone(self.overtimezone);
  lib_04FF::func_6982(self.var_1A5);
  thread func_2E30();
}

func_2E31(param_00) {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_01 = self.var_6896 * 1000;
  param_00.var_A23F = var_01;
  param_00 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_01, 110, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.var_6896);
  param_00 lib_04FF::func_860A(110);
  var_02 = self.var_6896;
  for(;;) {
    if(self.var_6896 != var_02) {
      var_03 = var_02 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_03);
    }

    self waittill("prop_destroyed");
  }
}

func_2E30() {
  self endon("death");
  level endon("game_ended");
  self.var_2563 lib_04FF::func_7CCA();
  self.var_2563 maps\mp\gametypes\_gameobjects::func_2D58();
  self notify("objectiveComplete");
  destructionshutdownprops();
}

destructionaddobject(param_00) {
  self.totalobjects = self.totalobjects + 1;
  self.var_6896 = self.var_6896 + 1;
  if(isDefined(level.ondestructionaddobject)) {
    self thread[[level.ondestructionaddobject]](param_00);
  }
}

destructionobjectdestroyed(param_00) {
  var_01 = self.var_6896 / self.totalobjects;
  self.var_6896 = self.var_6896 - 1;
  var_02 = self.var_6896 / self.totalobjects;
  self notify("prop_destroyed");
  var_03 = "progress";
  var_04 = undefined;
  if(self.var_6896 == 10) {
    var_03 = "tenleft";
  } else if(self.var_6896 == 5) {
    var_03 = "fiveleft";
  } else if(self.var_6896 == 3) {
    var_03 = "threeleft";
  } else if(self.var_6896 == 1) {
    var_03 = "oneleft";
  } else if(var_01 > 0.5 && var_02 <= 0.5) {
    var_03 = "50p";
  }

  if(var_03 != "progress") {
    var_04 = "force";
  }

  lib_04FF::func_6981(self.var_695A, var_03, 0, 1, var_04);
}

func_52FB(param_00) {
  level.var_611["destructionExplode"] = loadfx("vfx/explosion/flashbang_no_model");
  level.var_611["destructionExplode_sm"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_expl_sm");
  level.var_611["destructionExplode_med"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_expl_med");
  level.var_611["destructionExplode_lrg"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_expl_lrg");
  level.var_611["sparks_burst"] = loadfx("vfx/explosion/sparks_burst_lrg_b");
  level.var_611["damage_fire_small"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_dmg_sm");
  level.var_611["damage_fire_medium"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_dmg_med");
  level.var_611["damage_fire_large"] = loadfx("vfx/map/mp_raid_aachen/raid_aachen_radio_dmg_lrg");
  level.var_611["engine_fire"] = loadfx("vfx/map/mp_raid_d_day/r_dday_equipment_damaged_state_1");
  param_00.sfxtable = [];
  param_00.sfxtable["damage_fire_small"] = "ob2_comm_fire_sml";
  param_00.sfxtable["damage_fire_medium"] = "ob2_comm_fire_med";
  param_00.sfxtable["damage_fire_large"] = "ob2_comm_fire_lrg";
  param_00.sfxoffsets = [];
  param_00.sfxoffsets["damage_fire_small"] = (0, 0, 8);
  param_00.sfxoffsets["damage_fire_medium"] = (0, 0, 48);
  param_00.sfxoffsets["damage_fire_large"] = (0, 0, 64);
}

destructionresetprops() {
  level endon("game_ended");
  self endon("objectiveComplete");
  for(;;) {
    level waittill("resetDestructibles");
    foreach(var_01 in self.var_982D["destructionTarget"]) {
      var_01.repairenabled = 0;
      if(var_01.var_6A > 0) {
        if(isDefined(var_01.mycontents)) {
          var_01 method_80B0(var_01.mycontents);
          var_01.mycontents = undefined;
        }

        var_01.outlinecolor = 1;
        var_01.killed = 0;
        var_01 lib_0502::func_79C6();
        var_01 func_2E26(undefined, undefined, 1);
        var_01 setdamagecallbackon(1);
        var_01 setCanDamage(1);
        if(isDefined(var_01.var_3F6E)) {
          var_01.var_3F6E delete();
        }

        var_01 notify("reset");
      }
    }

    self.var_6896 = self.totalobjects;
    self notify("prop_destroyed");
  }
}

destructionshutdownprops() {
  var_00 = common_scripts\utility::func_FA0(self.var_982D["destructionTarget"]);
  foreach(var_02 in var_00) {
    if(var_02.var_6A > 0) {
      var_02 func_2E26(undefined, undefined, 1);
    }

    var_02.repairenabled = 0;
    var_02 setdamagecallbackon(0);
    var_02 setCanDamage(0);
    var_02 endallfx();
    killdestructibleoutlinethread(var_02);
  }
}

runovertimemonitor() {}

destructionovertimezoneinit(param_00) {
  self.overtimezone = param_00;
}

runovertimezone(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  level endon("game_ended");
  var_01 = lib_04FF::func_45CE(self);
  var_02 = game["attackers"];
  var_03 = [];
  var_04 = self.var_6896 * 1000;
  var_05 = maps\mp\gametypes\_gameobjects::func_2837(var_02, param_00, var_03, var_01, 0, 1);
  var_05.var_6BBF = undefined;
  var_05 maps\mp\gametypes\_gameobjects::func_365D();
  var_05.snapicon = 1;
  var_05.var_681A = 1;
  var_05.var_A23F = var_04;
  var_05 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_04, 110, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.var_6896);
  var_05 lib_04FF::func_860A(110);
  lib_04FF::func_6942(var_05);
  thread destructionobjectiveupdate(var_05);
  var_05 thread destructionzoneoccupied(self);
  lib_04FF::func_6982(self.var_1A5);
  lib_04F7::func_5A4F(param_00.var_116, 750);
  lib_04F7::func_2F99(param_00.var_116, 750);
  var_05 lib_04FF::func_7CCA();
  var_05 maps\mp\gametypes\_gameobjects::func_2F93();
  var_05 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_05 maps\mp\gametypes\_gameobjects::func_2D58();
}

destructionobjectiveupdate(param_00) {
  var_01 = 5000;
  level endon("game_ended");
  var_02 = -1 * var_01;
  var_03 = self.var_6896;
  childthread func_A90E(param_00);
  for(;;) {
    if(self.var_6896 != var_03) {
      if(!isDefined(level.var_774) && self.var_6896 > 0) {
        if(gettime() > var_02 + var_01) {
          lib_04F3::raidmusiconteam("attackers", "stinger_pos", "stinger_neg");
        } else {
          lib_04F3::raidmusiconteam("attackers", "stinger_pos", "stinger_neg");
        }
      }

      var_02 = gettime();
      var_04 = var_03 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_04);
    }

    if(self.var_6896 == 0) {
      lib_04FF::func_6935(self.var_1A5);
      return;
    }

    self waittill("prop_destroyed");
  }
}

func_A90E(param_00) {
  level endon("game_ended");
  var_01 = 0;
  var_02 = self.var_6896;
  for(;;) {
    if(isDefined(level.var_4E09)) {
      var_01 = 1;
    } else if(var_01) {
      var_01 = 0;
      var_03 = var_02 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_03);
    }

    wait(1);
  }
}

destructionzoneoccupied(param_00) {
  self endon("death");
  self.var_50A9 endon("death");
  param_00 endon("objectiveComplete");
  for(;;) {
    var_01 = 0;
    var_02 = self.var_9AC3[game["attackers"]];
    if(var_02.size > 0) {
      var_03 = 1;
      if(var_03) {
        var_01 = 1;
      }
    }

    if(var_01) {
      param_00.var_5024 = "contested";
    } else {
      param_00.var_5024 = "none";
    }

    var_07 = lib_0502::func_4518("destroy_objects", var_01);
    lib_04FF::func_860A(var_07);
    self.var_50A9.var_C9 = var_07;
    wait 0.05;
  }
}

func_2E34(param_00) {
  param_00.var_65EA = self;
  fixobjectorigin(param_00);
  var_01 = lib_04FF::func_45D0("objectHealth");
  param_00.var_BC = 999999;
  param_00.var_FB = var_01;
  param_00.var_6A = 0;
  param_00.var_1A7 = game["defenders"];
  param_00 method_86B7();
  param_00 method_80B0(8576);
  lib_04FF::func_6983(param_00.var_65EA.var_1A5);
  waittillframeend;
  param_00 setdamagecallbackon(1);
  param_00.var_29B5 = ::func_2E2C;
  param_00 setCanDamage(1);
  param_00.healthmultiple = 1;
  param_00.canrepair = 0;
  param_00.var_29D7 = 1;
  param_00.var_29DD = [];
  param_00.var_3F7C = -1;
  param_00.var_3F6E = undefined;
  param_00.basemodel = param_00.var_106;
  param_00.stagemodel = param_00.basemodel;
  param_00.killed = 0;
  param_00.suppressmodelchangesound = 1;
  destructionpropapplyparamaters(param_00);
  param_00.repairdamageto = int(max(0, param_00.var_FB - param_00.var_FB * 1));
  param_00 thread setdestructibleoutlinethread(param_00, 2);
  param_00 initfxnodes(param_00);
  param_00 initdamageportions();
  thread func_2E2D(param_00);
  destructionaddobject(param_00);
}

fixobjectorigin(param_00) {
  if(param_00.var_106 == "ger_radio_equip_07" || param_00.var_106 == "ger_radio_equip_05") {
    param_00.var_116 = param_00.var_116 + (0, 0, 1);
  }
}

destructionpropapplyparamaters(param_00) {
  param_00.var_6E56 = lib_0502::func_4679(param_00);
  var_01 = param_00.var_6E56;
  if(lib_0502::func_A273(var_01, [], ["size", "brokenModel", "repair", "sndcluster"]) == 0) {
    return;
  }

  if(isDefined(var_01["size"])) {
    var_02 = var_01["size"];
    switch (var_02) {
      case "large":
        param_00.healthmultiple = 2.5;
        break;

      case "small":
        param_00.healthmultiple = 0.4;
        break;

      default:
        param_00.healthmultiple = 1;
        break;
    }

    param_00.var_FB = int(param_00.var_FB * param_00.healthmultiple);
    var_03 = lib_0501::func_4647("destroy_objectHealthPercent");
    param_00.var_FB = int(int(var_03) / 100 * param_00.var_FB);
    param_00.repairdamageto = int(param_00.var_FB * 1);
  } else {
    param_00.var_6E56["size"] = "not specified";
  }

  if(isDefined(var_01["brokenModel"])) {
    param_00.destroyed_model = var_01["brokenModel"];
  }

  if(isDefined(var_01["repair"]) && var_01["repair"] == "true") {
    thread destructsetuprepair(param_00);
  }
}

initfxnodes(param_00) {
  foreach(var_02 in param_00.var_982D) {
    foreach(var_04 in var_02) {
      if(var_04.var_165 == "fxSource") {
        fxstructinit(var_04, param_00.stagemodel);
      }
    }
  }
}

initdamageportions() {
  var_00 = 0;
  var_01 = int(self.var_FB / self.var_29D7);
  foreach(var_03 in self.var_29DD) {
    var_00 = var_00 + var_03.var_6E56["portions"];
    var_03.healththreashold = var_00 * var_01;
  }
}

func_2E2D(param_00) {
  param_00 endon("death");
  lib_04FF::func_6982(self.var_1A5);
  killdestructibleoutlinethread(param_00);
  param_00 setdamagecallbackon(0);
}

func_2E2E() {
  self setdamagecallbackon(0);
  self setCanDamage(0);
  if(self.canrepair) {
    self makeunusable();
  }

  self.killed = 1;
  wait 0.05;
  self.var_65EA destructionobjectdestroyed(self);
  endallfx();
  self.var_3F6E = playFX(destructiongetdeathfx(self), self.var_116);
  lib_04F3::func_79CB("mp_war_small_explo", self.var_116);
  killdestructibleoutlinethread(self);
  if(isDefined(self.destroyed_model)) {
    setdestructionpropmodel(self.destroyed_model);
    return;
  }

  self.mycontents = self method_80B1(self);
  self method_8511();
}

destructiongetdeathfx(param_00) {
  var_01 = param_00.var_6E56["size"];
  switch (var_01) {
    case "large":
      return common_scripts\utility::func_44F5("destructionExplode_lrg");

    case "small":
      return common_scripts\utility::func_44F5("destructionExplode_sm");

    default:
      return common_scripts\utility::func_44F5("destructionExplode_med");
  }
}

func_2E2C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01) || param_01.var_3A == "worldspawn" || !isPlayer(param_01)) {
    return;
  }

  if(isDefined(param_01.var_1A7)) {
    if(self.var_1A7 == param_01.var_1A7) {
      return;
    }
  } else if(isDefined(param_01.var_117) && isDefined(param_01.var_117.var_1A7)) {
    if(self.var_1A7 == param_01.var_117.var_1A7) {
      return;
    }
  }

  var_0C = "standard_nosound";
  if(param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE_SPLASH" || param_04 == "MOD_PROJECTILE") {
    var_0C = "raid_buildable";
  }

  var_0D = modifydamagefordestructibles(param_04, param_02, self, param_05);
  if(var_0D < 1) {
    return;
  }

  self.var_6A = self.var_6A + var_0D;
  var_0E = var_0D;
  if(isDefined(level.ondestructiondamagecallback)) {
    self.var_65EA thread[[level.ondestructiondamagecallback]](self, var_0D, self.var_FB, param_06, param_00, param_01);
  }

  if(self.var_6A >= self.var_FB) {
    var_0C = "raid_buildable_kill";
    lib_0502::raidawarddestructionpropevent(param_01);
    var_0F = self.var_6A - self.var_FB;
    var_0E = var_0E - var_0F;
    func_2E2E();
  } else {
    thread setdestructibleoutlinethread(self, 1);
    var_10 = func_469D(self);
    if(self.var_6A > self.repairdamageto && self.canrepair) {
      destructenablerepair(self);
    }

    if(var_10 != self.var_3F7C) {
      func_0A15(var_10);
    }
  }

  param_01 maps\mp\gametypes\_damagefeedback::func_A102(var_0C);
  self.var_65EA thread damageovertimesingleton(self.var_65EA.var_1A5);
}

damageovertimesingleton(param_00) {
  if(!isDefined(self.extraluaovertimeframes)) {
    self.extraluaovertimeframes = 0;
  }

  if(self.extraluaovertimeframes > 0) {
    self.extraluaovertimeframes = 3;
    return;
  }

  self.extraluaovertimeframes = 3;
  while(self.extraluaovertimeframes > 0) {
    lib_04FF::func_6981(param_00);
    self.extraluaovertimeframes--;
    wait 0.05;
  }
}

modifydamagefordestructibles(param_00, param_01, param_02, param_03) {
  var_04 = 0.2;
  var_05 = 0.2;
  var_06 = 0.1;
  var_07 = 0.05;
  var_08 = 1.6;
  var_09 = 2.5;
  if(param_00 == "MOD_RIFLE_BULLET") {
    return param_01;
  }

  if(maps\mp\_utility::func_5755(param_00)) {
    return min(int(max(param_02.var_FB - param_02.var_6A * var_04, param_02.var_FB * var_05) * 1 / param_02.healthmultiple), param_01);
  }

  if(param_00 == "MOD_GRENADE_SPLASH") {
    if(param_01 <= 10) {
      return 0;
    }

    return min(int(max(param_02.var_FB - param_02.var_6A * var_06, param_02.var_FB * var_07) * 1 / param_02.healthmultiple), param_01);
  }

  if(isexplosivedamagemod(param_00)) {
    var_0A = min(int(param_02.var_FB * var_08 * 1 / param_02.healthmultiple), param_01);
    if(param_00 == "MOD_PROJECTILE_SPLASH") {
      var_0A = var_0A / 2;
    }

    return var_0A;
  }

  if(lib_0502::isshotgun(var_04)) {
    return int(param_02 * var_0A);
  }

  return param_02;
}

setdestructibleoutlinethread(param_00, param_01, param_02) {
  param_00 endon("death");
  level endon("game_ended");
  param_00 notify("killOutline");
  param_00 hudoutlinedisable();
  param_00 endon("killOutline");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  for(;;) {
    param_00 hudoutlinedisable();
    param_00 hudoutlineenable(param_01, param_02);
    param_00.outlinecolor = param_01;
    level waittill("joined_team");
  }
}

killdestructibleoutlinethread(param_00) {
  param_00 notify("killOutline");
  param_00 hudoutlinedisable();
}

func_469D(param_00) {
  if(param_00.var_29DD.size == 0) {
    return -1;
  }

  var_01 = param_00.var_6A;
  var_02 = -1;
  for(var_03 = 0; var_03 < param_00.var_29DD.size; var_03++) {
    var_04 = param_00.var_29DD[var_03];
    if(var_01 < var_04.healththreashold) {
      break;
    }

    var_02 = var_03;
  }

  return var_02;
}

func_0A15(param_00) {
  if(isDefined(self.var_29DD[self.var_3F7C])) {
    var_01 = self.var_29DD[self.var_3F7C];
    if(var_01.var_6F75 == 0) {
      var_01 func_36EB();
    }
  }

  if(param_00 >= self.var_29DD.size) {
    return;
  }

  for(var_02 = 0; var_02 <= param_00; var_02++) {
    if(var_02 > self.var_3F7C) {
      self.var_29DD[var_02] thread func_74E0();
    }
  }

  self.var_3F7C = param_00;
  setdestructionpropmodel(self.var_29DD[param_00].stagemodel);
}

setdestructionpropmodel(param_00) {
  if(param_00 == self.stagemodel) {
    return;
  }

  self setModel(param_00);
  self.stagemodel = param_00;
  if(param_00 != self.basemodel) {
    if(self.suppressmodelchangesound) {
      self.suppressmodelchangesound = 0;
      return;
    }

    lib_04F3::func_79CC("ob2_comm_damage_lrg", self);
  }
}

deleteatobjectivecomplete(param_00) {
  self endon("death");
  self endon("reset");
  wait 0.05;
  wait 0.05;
  lib_04FF::func_6982(param_00);
  self delete();
}

fxstructinit(param_00, param_01) {
  param_00.var_65EB = self;
  param_00.var_3F78 = 0;
  param_00.var_6F75 = 0;
  param_00.stagemodel = param_01;
  fxstructapplyparamaters(param_00);
  initfxnodes(param_00);
}

fxstructapplyparamaters(param_00) {
  param_00.var_6E56 = lib_0502::func_4679(param_00);
  if(lib_0502::func_A273(param_00.var_6E56, [], ["effect", "portions", "persist", "model"]) == 0) {
    return;
  }

  if(!isDefined(param_00.var_6E56["effect"]) || !isDefined(level.var_611[param_00.var_6E56["effect"]])) {
    param_00.var_6E56["effect"] = "";
  }

  if(isDefined(param_00.var_6E56["portions"])) {
    param_00.var_6E56["portions"] = int(param_00.var_6E56["portions"]);
  } else {
    param_00.var_6E56["portions"] = 1;
  }

  if(isDefined(param_00.var_6E56["persist"])) {
    param_00.var_6F75 = param_00.var_6E56["persist"] == "true";
  }

  if(isDefined(param_00.var_6E56["model"])) {
    param_00.stagemodel = param_00.var_6E56["model"];
  }

  self.var_29DD[self.var_29DD.size] = param_00;
  self.var_29D7 = self.var_29D7 + param_00.var_6E56["portions"];
  self.var_3F7D = int(self.var_FB / self.var_29D7);
}

func_74E0() {
  self.var_65EB endon("death");
  level endon("game_ended");
  if(self.var_3F78) {
    return;
  }

  if(self.var_6E56["effect"] == "") {
    return;
  }

  var_00 = spawn("script_model", self.var_116);
  var_00 setModel("tag_origin");
  var_00.var_1D = self.var_1D;
  var_01 = self.var_6E56["effect"];
  self.var_3F6E = var_00;
  self.var_3F73 = common_scripts\utility::func_44F5(var_01);
  playFXOnTag(self.var_3F73, self.var_3F6E, "tag_origin");
  self.var_3F78 = 1;
  var_02 = self.var_65EB.var_116;
  var_03 = self.var_65EB.var_65EA.sfxtable[var_01];
  var_04 = self.var_65EB.var_65EA.sfxoffsets[var_01];
  if(isDefined(var_03) && !isDefined(self.var_65EB.var_A238)) {
    if(function_0296(var_04)) {
      var_02 = var_02 + var_04;
    }

    self.var_65EB.var_A238 = lib_04F3::func_79CB(var_03, var_02);
  }

  if(isDefined(self.var_6E56["duration"])) {
    wait(int(self.var_6E56["duration"]));
    self.var_3F6E delete();
    self.var_3F78 = 0;
  }
}

endallfx() {
  foreach(var_01 in self.var_29DD) {
    var_01 func_36EB();
  }

  self.var_3F7C = -1;
  lib_04F3::func_79D0(self.var_A238, 0.1);
}

func_36EB() {
  if(self.var_3F78 == 0) {
    return;
  }

  killfxontag(self.var_3F73, self.var_3F6E, "tag_origin");
  self.var_3F6E delete();
  self.var_3F78 = 0;
}

destructsetuprepair(param_00) {
  param_00.canrepair = 1;
  param_00.killed = 0;
  param_00.repairenabled = 0;
  param_00.repairinuse = 0;
  param_00 setcursorhint("HINT_ACTIVATE");
  param_00 sethintstring(&"RAIDS_REPAIR_HINT");
  param_00.var_A23E = 23;
  param_00.var_5022 = "";
  level.var_79BF[level.var_79BF.size] = param_00;
}

destructenablerepair(param_00) {
  if(param_00.repairenabled) {
    return;
  }

  param_00.repairenabled = 1;
  enableactivate(param_00);
  param_00.var_65EA.damagedobjects = param_00.var_65EA.damagedobjects + 1;
  lib_0502::func_2D53("dropped_weapon", param_00.var_116, 128);
  param_00 maps\mp\_utility::func_5FBD(game["defenders"]);
  param_00 thread repairablethink();
}

repairablethink() {
  self endon("death");
  level endon("game_ended");
  self endon("repaired");
  while(isDefined(self)) {
    self waittill("trigger", var_00);
    thread attempttorepairobject(var_00);
  }
}

attempttorepairobject(param_00) {
  if(param_00 method_83B8()) {
    return;
  }

  if(self.repairinuse) {
    return;
  }

  lockoutactivate(self);
  var_01 = func_A213(param_00, 800, self);
  enableactivate(self);
  if(!var_01) {
    return;
  }

  level thread maps\mp\_utility::func_9863("raids_subobjective_repaired", param_00);
  param_00 thread maps\mp\gametypes\_hud_message::func_73C2("raids_subobjective_repaired", param_00);
  func_2E26(undefined, undefined, var_01);
  self.var_65EA.damagedobjects = self.var_65EA.damagedobjects - 1;
  self notify("repaired", param_00);
  lib_04FF::func_6981(self.var_65EA.var_695A, "repair", 0, 1);
}

func_A213(param_00, param_01, param_02) {
  if(isPlayer(param_00)) {
    param_00 playerlinkto(self);
  } else {
    param_00 linkto(self);
  }

  if(param_00 getcurrentweapon() != "flamethrower_german_mp") {
    param_00 common_scripts\utility::func_602();
  } else {
    param_00 common_scripts\utility::func_603();
  }

  thread func_A215(param_00);
  self.var_28D5 = 0;
  self.var_54F5 = 1;
  self.buttonpressed = 0;
  param_00 thread func_6F82(self, param_01, param_02);
  var_03 = func_A214(param_00, param_01);
  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  self.var_54F5 = 0;
  self.var_28D5 = 0;
  return var_03;
}

func_A215(param_00) {
  common_scripts\utility::knock_off_battery("death", "repaired", "useHoldThinkLoopDone");
  if(isalive(param_00)) {
    if(param_00 getcurrentweapon() != "flamethrower_german_mp") {
      param_00 common_scripts\utility::func_616();
    } else {
      param_00 common_scripts\utility::func_617();
    }

    if(param_00 islinked()) {
      param_00 unlink();
    }
  }
}

lockoutactivate(param_00) {
  param_00.repairinuse = 1;
  param_00 sethintstring("");
}

enableactivate(param_00) {
  param_00.repairinuse = 0;
  param_00 sethintstring(&"RAIDS_REPAIR_HINT");
  param_00 setcursorhint("HINT_NOICON");
}

func_6F82(param_00, param_01, param_02) {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", param_02.var_A23E);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_03 = -1;
  var_04 = gettime() + param_01;
  while(maps\mp\_utility::func_57A0(self) && isDefined(param_00) && param_00.var_54F5 && !level.var_3F9D && param_00.killed == 0) {
    if(var_03 != param_00.buttonpressed) {
      if(param_00.var_28D5 > param_01) {
        param_00.var_28D5 = param_01;
      }

      if(param_00.buttonpressed > 0) {
        var_05 = int(param_02.var_116[0]);
        var_06 = int(param_02.var_116[1]);
        var_07 = int(param_02.var_116[2] + 25);
        self luinotifyevent(&"carepackage_icon_world_position", 3, var_05, var_06, var_07);
        self setclientomnvar("ui_use_bar_end_time", int(var_04));
      }

      var_03 = param_00.buttonpressed;
    }

    wait 0.05;
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

func_A214(param_00, param_01) {
  while(!level.var_3F9D && isDefined(self) && maps\mp\_utility::func_57A0(param_00) && param_00 useButtonPressed() && self.var_28D5 < param_01) {
    self.var_28D5 = self.var_28D5 + self.buttonpressed * 50;
    if(!self.buttonpressed) {
      self.buttonpressed = 1;
    }

    if(self.killed) {
      return 0;
    }

    if(self.var_28D5 >= param_01) {
      return maps\mp\_utility::func_57A0(param_00);
    }

    wait 0.05;
  }

  return 0;
}

func_2E26(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return;
  }

  if(self.killed) {
    return;
  }

  self.repairenabled = 0;
  self.var_6A = self.repairdamageto;
  self.repairdamageto = int(self.repairdamageto * 1);
  endallfx();
  self.suppressmodelchangesound = 1;
  setdestructionpropmodel(self.basemodel);
  lib_04F3::func_79CC("ob2_comm_repaired", self);
  thread setdestructibleoutlinethread(self, 2);
  maps\mp\_utility::func_871D();
  if(isDefined(level.ondestructiblerepairuse)) {
    self thread[[level.ondestructiblerepairuse]](param_02);
  }
}