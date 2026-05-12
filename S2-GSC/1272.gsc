/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1272.gsc
*********************************************/

func_52B4() {
  var_00 = 0;
  if(!var_00) {
    func_5364();
    level.var_611["turret_destruction"] = loadfx("vfx/metal_equipment_sm_expl");
  }

  if(isDefined(level.var_79C2)) {
    level.var_79C2.var_9F96 = [];
    var_01 = getEntArray("raid_turret", "targetname");
    foreach(var_03 in var_01) {
      if(!var_00) {
        func_5363(var_03, 0);
        continue;
      }

      func_7D01(var_03);
    }

    var_05 = getEntArray("raid_turret_prebuilt", "targetname");
    foreach(var_03 in var_05) {
      if(!var_00) {
        func_5363(var_03, 1);
        continue;
      }

      func_7D01(var_03);
    }

    var_08 = getEntArray("raid_turret_static", "targetname");
    foreach(var_03 in var_08) {
      level.var_79C2.var_9F96[level.var_79C2.var_9F96.size] = var_03;
    }
  }
}

func_7D01(param_00) {
  var_01 = getEntArray(param_00.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    var_03 delete();
  }

  param_00 delete();
}

func_7CCF() {
  var_00 = getEntArray("raid_turret", "targetname");
  foreach(var_02 in var_00) {
    var_02.var_E9E delete();
    var_02.var_A21B delete();
    var_02 delete();
  }

  var_04 = getEntArray("raid_turret_prebuilt", "targetname");
  foreach(var_02 in var_04) {
    var_02.var_E9E delete();
    var_02.var_A21B delete();
    var_02 delete();
  }
}

func_5363(param_00, param_01) {
  level.var_79C2.var_9F96[level.var_79C2.var_9F96.size] = param_00;
  lib_0502::func_1D39(param_00);
  param_00.var_79E8 = level.var_79E8[param_00.var_165];
  param_00 thread func_8A4C(param_01);
}

func_5364() {
  level.var_79E8 = [];
  level.var_79E8["mg42"] = [];
  level.var_79E8["mg42"]["constructTime"] = 5;
  level.var_79E8["mg42"]["flipTime"] = 0;
  level.var_79E8["mg42"]["useLocationOffset"] = (0, 0, 9);
  level.var_79E8["mg42"]["inactiveIdleAnimName"] = "mp_raids_turret_mg42_inactive_idle";
  level.var_79E8["mg42"]["clipParts"] = ["tag_clip", "J_Bullet_01", "J_Bullet_02", "J_Bullet_03", "J_Bullet_04", "J_Bullet_05"];
  level.var_79E8["mg42"]["buildAnimName"] = "mp_raids_turret_mg42_build";
  level.var_79E8["mg42"]["buildAnimRef"] = % mp_raids_turret_mg42_build;
  level.var_79E8["mg42"]["objectiveModel"] = "npc_ger_mg42_bipod_turret_raid_obj";
  level.var_79E8["pak38"] = [];
  level.var_79E8["pak38"]["constructTime"] = 5;
  level.var_79E8["pak38"]["flipTime"] = 0;
  level.var_79E8["pak38"]["useLocationOffset"] = (0, 0, 20);
  level.var_79E8["pak38"]["objectiveModel"] = "ger_btry_pak38_raid_obj";
}

func_5837() {
  var_00 = getarraykeys(level.var_79E8);
  return common_scripts\utility::func_F79(var_00, self.var_165);
}

func_8A4C(param_00) {
  self setdefaultdroppitchyaw(0, 0);
  self makeunusable();
  self.var_1D3D = 0;
  self.var_1D3C = 0;
  self.var_2599 = 0;
  self method_805C();
  func_52BB(self);
  thread func_9F8C();
  var_01 = getEntArray(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.var_3A == "trigger_use_touch") {
      if(var_03.var_165 == "canBuildTurret") {
        self.var_1F89 = var_03;
        var_04 = self.var_116 + self.var_79E8["useLocationOffset"];
        self.var_1F89 usetouchtriggerrequirefacingposition(1, var_04);
        self.var_1D4F = maps\mp\gametypes\_gameobjects::func_2837("neutral", self.var_1F89, [self], (0, 0, 32), 1);
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A5A(self.var_79E8["constructTime"]);
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_CONSTRUCT");
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_CONSTRUCT");
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_C30("any");
        self.var_1D4F.var_6BBF = ::func_6BC1;
        self.var_1D4F.var_6ABC = ::func_6ABB;
        self.var_1D4F.var_6AFA = ::func_6AF8;
        self.var_1D4F.var_A248 = "war_wrench_assemble_mp";
        self.var_1D4F.var_A23C = 0;
        self.var_1D4F.var_1F84 = ::func_2982;
        self.var_1D4F.var_502A = "raidConstruct";
        self.var_1D4F.var_113F = 0;
        self.var_1D4F.var_7894 = 1;
        self.var_1D4F.var_A23E = 6;
        var_03 func_52BB(self);
      } else if(var_03.var_165 == "flipTrigger") {
        self.var_3D79 = var_03;
        var_04 = self.var_116 + self.var_79E8["useLocationOffset"];
        self.var_3D79 usetouchtriggerrequirefacingposition(1, var_04);
        self.var_1D4F = maps\mp\gametypes\_gameobjects::func_2837("neutral", self.var_3D79, [], (0, 0, 32), 1);
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A5A(self.var_79E8["flipTime"]);
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A59(&"FLIPPING_TURRET");
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A57(&"FLIP_TURRET");
        self.var_1D4F maps\mp\gametypes\_gameobjects::func_C30("any");
        self.var_1D4F.var_6BBF = ::func_6BC4;
        self.var_1D4F.var_1F84 = ::func_2982;
        self.var_1D4F.var_113F = 0;
        self.var_1D4F.var_A23E = 6;
        self.var_1D4F.var_9EDD = self;
        var_03 func_52BB(self);
      }

      continue;
    }

    if(var_03.var_3A == "script_model") {
      self.var_A21B = var_03;
      self.var_A21B func_52BB(self);
    }
  }

  self.var_E9E = spawn("script_model", self.var_116);
  self.var_E9E.var_1D = self.var_1D;
  if(isDefined(self.var_3D73)) {
    self.var_E9E.var_92F0 = self.var_92F0;
    self.var_E9E.var_92B8 = self.var_92B8;
    self.var_E9E.var_3D73 = self.var_3D73;
    self.var_E9E.var_3D6E = self.var_3D6E;
    self.var_E9E thread func_3D78(self);
  }

  self.var_E9E setModel(self.var_79E8["objectiveModel"]);
  if(isDefined(self.var_79E8["inactiveIdleAnimName"])) {
    self.var_E9E scriptmodelplayanim(self.var_79E8["inactiveIdleAnimName"], "turret_anim");
  }

  if(isDefined(self.var_79E8["clipParts"])) {
    foreach(var_07 in self.var_79E8["clipParts"]) {
      self.var_E9E hidepart(var_07);
    }
  }

  self.var_E9E.var_9EDD = self;
  if(param_00) {
    thread func_3668(0.1);
  }

  lib_0502::func_1D3A(self, param_00);
}

func_2982(param_00) {
  if(isDefined(param_00) && isDefined(param_00.var_2016)) {
    return 0;
  }

  return 1;
}

func_9F8C() {
  self endon("death");
  for(;;) {
    self waittill("turretownerchange");
    func_3D7A();
  }
}

func_52BB(param_00) {
  if(!isDefined(self.var_1A2)) {
    return;
  }

  if(!isDefined(self.var_1D)) {
    self.var_1D = (0, 0, 0);
  }

  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  self.var_92F0 = self.var_116;
  self.var_92B8 = self.var_1D;
  self.var_92D1 = self.var_92F0;
  self.var_92D0 = self.var_92B8;
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_1D)) {
      var_03.var_1D = (0, 0, 0);
    }

    switch (var_03.var_165) {
      case "origin":
        self.var_92D1 = var_03.var_116;
        self.var_92D0 = var_03.var_1D;
        break;

      case "flip":
        self.var_3D73 = var_03.var_116;
        self.var_3D6E = var_03.var_1D;
        break;
    }
  }

  if(!isDefined(self.var_92B8)) {
    self.var_92B8 = (0, 0, 0);
  }

  if(!isDefined(self.var_92D0)) {
    self.var_92D0 = (0, 0, 0);
  }

  if(isDefined(self.var_3D73)) {
    var_05 = transformmove(self.var_3D73, self.var_3D6E, self.var_92D1, self.var_92D0, self.var_116, self.var_1D);
    self.var_3D73 = var_05["origin"];
    self.var_3D6E = var_05["angles"];
    thread func_3D78(param_00);
  }
}

func_3D7A() {
  var_00 = self.var_3D79;
  if(!isDefined(var_00)) {
    return;
  }

  if(self.var_1D3C || isDefined(self method_80E2())) {
    var_00 makeunusable();
    return;
  }

  var_00 makeusable();
}

func_3D78(param_00) {
  self endon("death");
  for(;;) {
    param_00 waittill("flip");
    self.var_116 = self.var_3D73;
    self.var_1D = self.var_3D6E;
    param_00 waittill("flip");
    self.var_116 = self.var_92F0;
    self.var_1D = self.var_92B8;
  }
}

func_6BC4(param_00) {
  self.var_9EDD notify("flip");
}

func_3668(param_00) {
  wait(param_00);
  self.var_1D3D = 1;
  thread func_3667();
}

func_9F78() {
  self endon("pauseBuildAnim");
  self endon("built");
  for(;;) {
    self waittill("turret_anim", var_00);
    thread func_9F79(var_00);
    if(var_00 == "end") {
      break;
    }
  }
}

func_9F79(param_00) {
  if(common_scripts\utility::func_9467(param_00, "snd_")) {
    var_01 = getsubstr(param_00, 4);
    var_02 = strtok(var_01, ";");
    var_03 = var_02[0];
    var_04 = var_02[1];
    var_05 = self.var_116;
    if(isDefined(var_04)) {
      var_05 = self gettagorigin(var_04);
    }

    lib_04F3::func_79CB(var_03, var_05);
  }

  if(param_00 == "show_piece_clip") {
    if(isDefined(self.var_9EDD.var_79E8["clipParts"])) {
      foreach(var_07 in self.var_9EDD.var_79E8["clipParts"]) {
        self showpart(var_07);
      }
    }
  }

  if(param_00 == "end") {
    self.var_9EDD.var_1D3D = 1;
  }
}

func_6ABB(param_00) {
  var_01 = self.var_A582[0];
  var_01 thread func_9F7A(param_00);
  var_01.var_E9E lib_0502::func_793D("drop");
  var_01.var_1D3C = 1;
  var_01 func_3D7A();
}

func_6AF8(param_00, param_01, param_02) {
  var_03 = self.var_A582[0];
  if(!param_02) {
    var_03 thread func_9F7B();
    var_03.var_E9E lib_0502::func_793D();
  }

  var_03.var_1D3C = 0;
  var_03 func_3D7A();
}

func_9F85() {
  var_00 = "buildable_mg42_handle";
  var_01 = "tag_barrel";
  lib_04F3::func_79CF(var_00, self, var_01);
}

func_9F7A(param_00) {
  param_00 endon("disconnect");
  if(!isDefined(self.var_79E8["buildAnimName"])) {
    return;
  }

  self.var_E9E endon("pauseBuildAnim");
  while(isDefined(self.var_1D4F.var_A248) && param_00 getcurrentweapon() != self.var_1D4F.var_A248) {
    wait 0.05;
  }

  var_01 = getanimlength(self.var_79E8["buildAnimRef"]);
  var_02 = self.var_1D4F.var_28D5 / self.var_1D4F.var_A23F;
  var_03 = var_01 / self.var_1D4F.var_A23F / 1000;
  if(isDefined(param_00) && param_00 maps\mp\_utility::func_649("specialty_improvedobjectives")) {
    var_03 = var_03 * param_00.var_696D;
  }

  self.var_E9E scriptmodelplayanim(self.var_79E8["buildAnimName"], "turret_anim", var_02 * var_01, var_03, 1);
  self.var_E9E thread func_9F78();
  self.var_E9E thread func_9F85();
}

func_9F7B() {
  if(isDefined(self.var_79E8["clipParts"])) {
    foreach(var_01 in self.var_79E8["clipParts"]) {
      self.var_E9E hidepart(var_01);
    }
  }

  if(!isDefined(self.var_79E8["inactiveIdleAnimName"])) {
    return;
  }

  self.var_E9E notify("pauseBuildAnim");
  self.var_E9E scriptmodelplayanim(self.var_79E8["inactiveIdleAnimName"], "turret_anim", undefined, undefined, 1);
  self.var_E9E thread func_9F85();
}

func_3667(param_00) {
  if(isDefined(self.var_79E8["buildAnimName"])) {
    while(!self.var_1D3D) {
      wait 0.05;
    }
  }

  if(isDefined(self.var_A21B)) {
    self.var_A21B lib_0502::func_7997();
  }

  self method_805B();
  self.var_E9E lib_0502::func_7997();
  self restoredefaultdroppitch();
  self makeusable();
  self setCanDamage(1);
  self method_8131();
  thread maps\mp\gametypes\_damage::func_8676(4, "raid_buildable", ::func_35F3, ::lib_0502::func_1D38, 0);
  self.var_6A = 0;
  self.var_566B = 1;
  self.var_2599 = 1;
  lib_0502::func_7D5C(self);
  self.var_1F89 makeunusable();
  self.var_1D4F notify("disabled");
  wait 0.05;
  self.var_1D4F maps\mp\gametypes\_gameobjects::func_2D58();
  self.var_1D4F = undefined;
  self.var_E9E notify("built");
  lib_0502::func_1D3B(self.var_566B);
}

func_6BC1(param_00) {
  var_01 = self.var_A582[0];
  var_01 thread func_3667(param_00);
  if(lib_0502::func_21AC(var_01, param_00)) {
    lib_0502::func_7922(param_00);
  }

  lib_0506::func_166E(param_00, "turret_repaired");
}

func_35F3(param_00, param_01, param_02, param_03, param_04) {
  if(isPlayer(param_00)) {
    lib_0506::func_166E(param_00, "turret_disabled");
    if(lib_0502::func_21AC(self, param_00)) {
      lib_0502::func_7923(param_00);
    }
  }

  thread func_2DDE();
}

func_2DDE() {
  while(isDefined(self.var_1D4F)) {
    wait 0.05;
  }

  self notify("turret_destroyed");
  self setdefaultdroppitchyaw(0, 0);
  self.var_1D3D = 0;
  self makeunusable();
  self method_805C();
  if(isDefined(self.var_A21B)) {
    self.var_A21B lib_0502::func_79C6();
  }

  self setCanDamage(0);
  self setdamagecallbackon(0);
  self.var_29B5 = undefined;
  self.var_566B = 0;
  if(isDefined(self method_80E2())) {
    self method_80E2() method_85E9();
  }

  self.var_E9E lib_0502::func_79C6();
  if(isDefined(self.var_79E8["clipParts"])) {
    foreach(var_01 in self.var_79E8["clipParts"]) {
      self.var_E9E hidepart(var_01);
    }
  }

  if(isDefined(self.var_79E8["inactiveIdleAnimName"])) {
    self.var_E9E scriptmodelplayanim(self.var_79E8["inactiveIdleAnimName"], "turret_anim");
  }

  if(isDefined(self.var_79E8["constructTime"])) {
    self.var_1F89 makeusable();
    self.var_1D4F = maps\mp\gametypes\_gameobjects::func_2837("neutral", self.var_1F89, [self], (0, 0, 32), 1);
    self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A5A(self.var_79E8["constructTime"]);
    self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_CONSTRUCT");
    self.var_1D4F maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_CONSTRUCT");
    self.var_1D4F maps\mp\gametypes\_gameobjects::func_C30("any");
    self.var_1D4F.var_6BBF = ::func_6BC1;
    self.var_1D4F.var_6ABC = ::func_6ABB;
    self.var_1D4F.var_6AFA = ::func_6AF8;
    self.var_1D4F.var_A248 = "war_wrench_assemble_mp";
    self.var_1D4F.var_A23C = 0;
    self.var_1D4F.var_502A = "raidConstruct";
    self.var_1D4F.var_A23E = 6;
    self.var_1D4F.var_113F = 0;
    self.var_1D4F.var_7894 = 1;
  }

  lib_04F3::func_79CF("mp_war_bomb_explo", self.var_E9E, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("turret_destruction"), self.var_E9E, "tag_origin");
  lib_0502::func_1D3B(self.var_566B);
}