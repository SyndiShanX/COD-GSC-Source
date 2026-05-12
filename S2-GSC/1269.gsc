/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1269.gsc
*********************************************/

func_533B() {
  func_52FB();
  var_00 = lib_0502::func_2548("destructionObjective", ::func_2E32);
  var_01 = var_00 lib_0502::func_2548("destructionRepairTrigger", ::func_2E35);
  var_02 = var_00 lib_0502::func_2548("overtime_trigger", ::destructionovertimezoneinit);
  var_03 = var_01 lib_0502::func_2548("destructionTarget", ::func_2E34);
  var_04 = var_03 lib_0502::func_2548("destructionNode");
  var_05 = var_03 lib_0502::func_2548("ownedByParent", ::lib_0502::ces_setownedbyparent);
}

func_2E32(param_00) {
  lib_04FF::func_6934(param_00);
  lib_04FF::func_6983(self.var_1A5);
  lib_04FF::func_6965("objectHealth", 750, []);
  lib_04FF::func_6963("grenadeDamageMult", 0.1, [0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
  param_00.var_1A7 = game["attackers"];
  var_01 = lib_04FF::func_27DE("A", param_00.var_1A7, self.var_116);
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("any");
  param_00.var_2563 = var_01;
  param_00.var_6896 = 0;
  param_00.var_294F = 0;
  if(isDefined(param_00.numexternaltargets)) {
    func_2E33(param_00.numexternaltargets);
  }

  param_00 thread func_7F99();
}

func_7F99() {
  thread func_2E31(self.var_2563);
  if(isDefined(self.overtimezone)) {
    thread runovertimezone(self.overtimezone);
  }

  lib_04FF::func_6982(self.var_1A5);
  thread func_2E30();
}

func_2E31(param_00) {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_01 = self.var_6896 * 1000;
  param_00.var_A23F = var_01;
  var_02 = 110;
  if(isDefined(self.iconimageindexoverride)) {
    var_02 = self.iconimageindexoverride;
  }

  if(isDefined(self.externaliconent)) {
    param_00 lib_04FF::func_990(self.externaliconent, undefined, (0, 0, 0), var_01, var_02, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.var_6896);
  } else {
    param_00 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_01, var_02, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.var_6896);
  }

  param_00 lib_04FF::func_860A(var_02);
  var_03 = self.var_6896;
  for(;;) {
    if(self.var_6896 != var_03) {
      var_04 = var_03 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_04);
    }

    self waittill("prop_destroyed");
  }
}

func_2E30() {
  self endon("death");
  level endon("game_ended");
  self.var_2563 lib_04FF::func_7CCA();
  self.var_2563 maps\mp\gametypes\_gameobjects::func_2D58();
}

destructionobjectoverrideiconimageindex(param_00) {
  self.iconimageindexoverride = param_00;
}

destructionobjectsetexternaliconent(param_00) {
  self.externaliconent = param_00;
}

destructionobjectsetnumexternalobjects(param_00) {
  self.numexternaltargets = param_00;
}

func_2E33(param_00) {
  self.var_6896 = self.var_6896 + param_00;
  self notify("prop_destroyed");
  if(self.var_6896 <= 0) {
    lib_04FF::func_6935(self.var_1A5);
  }
}

func_52FB() {
  level.var_611["destructionExplode"] = loadfx("vfx/map/mp_raid_d_day/r_dday_equipment_damaged_state_2");
  level.var_611["engine_smoke"] = loadfx("vfx/fire/fire_licks_small");
  level.var_611["engine_damage"] = loadfx("vfx/vehicle/vehicle_tank_engine_damage_3_lightfire");
  level.var_611["engine_fire"] = loadfx("vfx/fire/fire_licks_small");
  level.var_611["engine_explode"] = loadfx("vfx/explosion/drone_swarm_projectile_explode");
}

func_2E34(param_00) {
  param_00.var_65EA = self;
  param_00.var_7D11 = undefined;
  if(param_00.var_982E.var_165 != "destructionObjective") {
    param_00.var_982E.var_6DA7 = param_00;
    param_00.var_7D11 = param_00.var_982E;
  }

  lib_04FF::func_6983(param_00.var_65EA.var_1A5);
  waittillframeend;
  param_00 setdamagecallbackon(1);
  param_00.var_29B5 = ::func_2E2C;
  param_00 setCanDamage(1);
  param_00 method_86B7();
  param_00 method_80B0(8576);
  var_01 = lib_04FF::func_45D0("objectHealth");
  param_00.var_BC = var_01;
  param_00.var_FB = param_00.var_BC;
  param_00.repairdamageto = 0;
  param_00.var_6A = 0;
  param_00.var_1A7 = game["defenders"];
  param_00.var_29D7 = 1;
  param_00.var_29DD = [];
  param_00.var_3F7C = -1;
  param_00.outlinecolor = 0;
  param_00 thread updatehudoutline();
  param_00.var_6E56 = lib_0502::func_4679(param_00);
  if(lib_0502::func_A273(param_00.var_6E56, [], ["type", "healthMult", "damaged", "partial_damage"])) {
    destructionpropapplyparamaters(param_00);
  }

  param_00 initfxnodes(param_00);
  param_00 initdamageportions();
  thread func_2E2D(param_00);
  func_2E33(1);
}

destructionpropapplyparamaters(param_00) {
  var_01 = param_00.var_6E56;
  if(isDefined(var_01["healthMult"])) {
    var_01["healthMult"] = float(var_01["healthMult"]);
    param_00.var_BC = int(param_00.var_BC * var_01["healthMult"]);
    param_00.var_FB = param_00.var_BC;
  }

  var_02 = lib_0501::func_4647("destroy_objectHealthPercent");
  param_00.var_BC = int(int(var_02) / 100 * param_00.var_BC);
  param_00.var_FB = param_00.var_BC;
  if(isDefined(var_01["damaged"])) {
    param_00.destroyed_model = var_01["damaged"];
  }

  if(isDefined(var_01["partial_damage"])) {
    param_00.partialdamaged_model = var_01["partial_damage"];
  }
}

initfxnodes(param_00) {
  foreach(var_02 in param_00.var_982D) {
    foreach(var_04 in var_02) {
      if(var_04.var_165 == "fxSource") {
        fxstructinit(var_04);
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
  param_00 hudoutlinedisable();
  param_00 setdamagecallbackon(0);
}

func_2E2E() {
  self setdamagecallbackon(0);
  self setCanDamage(0);
  if(isDefined(self.var_7D11)) {
    self.var_7D11.var_7D0D maps\mp\gametypes\_gameobjects::func_2F93();
  }

  self.var_65EA func_2E33(-1);
  self notify("destroyed");
  foreach(var_01 in self.var_29DD) {
    var_01 func_36EB();
  }

  playFX(common_scripts\utility::func_44F5("destructionExplode"), self.var_116);
  self method_8617("mp_war_radio_lrg_explo");
  if(isDefined(self.destroyed_model)) {
    self hudoutlinedisable();
    self setModel(self.destroyed_model);
    if(maps\mp\_utility::func_4571() == "mp_raid_dlc3") {
      self.var_1D = self.var_1D + (0, 90, 0);
    }

    self hudoutlinedisable();
    return;
  }

  self method_8511();
  thread lib_0502::func_2D2D();
}

func_2E2C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01) || param_01.var_3A == "worldspawn" || !isPlayer(param_01) && !lib_0502::func_57F9(param_01)) {
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

  if(maps\mp\_utility::func_4571() == "mp_raid_dlc3") {
    if(param_05 != "usa_tank_sherman_turret_player_mp" && param_05 != "turretweapon_usa_m1919_tank_sherman_bucket_mp") {
      return;
    }

    if(param_05 == "usa_tank_sherman_turret_player_mp" && param_04 == "MOD_CRUSH") {
      return;
    }
  }

  param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
  if(isPlayer(param_01)) {
    var_0C = param_01 getcurrentprimaryweapon();
    if(var_0C != "flamethrower_mp" && var_0C != "flamethrower_grenadier_mp") {
      self method_8617("mp_war_radio_lrg_hit");
    }
  }

  var_0D = modifydamagefordestructibles(param_04, param_02, self, param_00);
  if(maps\mp\_utility::func_4571() == "mp_raid_dlc3" && param_05 == "turretweapon_usa_m1919_tank_sherman_bucket_mp") {
    var_0D = int(var_0D / 3);
  }

  self.var_6A = self.var_6A + var_0D;
  var_0E = var_0D;
  var_0F = "aud_stop_radio_fire_lp";
  var_10 = "mp_war_radio_lrg_destruct_fire_lp";
  if(self.var_6A >= self.var_FB) {
    var_11 = self.var_6A - self.var_FB;
    var_0E = var_0E - var_11;
    level thread maps\mp\gametypes\_rank::func_1457("raids_destruct_equipment", param_01);
    func_2E2E();
    level notify(var_0F);
  } else {
    var_12 = func_469D(self);
    if(var_12 != self.var_3F7C) {
      func_0A15(var_12);
      var_13 = lib_0380::func_2889(var_10, undefined, self.var_116, 1);
      lib_0380::func_5F2(var_13, 1, var_0F);
    }
  }

  lib_04FF::func_6981(self.var_65EA.var_1A5);
}

modifydamagefordestructibles(param_00, param_01, param_02, param_03) {
  if(param_00 == "MOD_RIFLE_BULLET") {
    return param_01;
  }

  if(maps\mp\_utility::func_5755(param_00)) {
    return 0.6 * param_01;
  }

  if(param_00 == "MOD_GRENADE_SPLASH") {
    var_04 = 0;
    if(isDefined(param_03.var_A9E0)) {
      var_04 = getweaponexplosionradius(param_03.var_A9E0);
    }

    if(var_04 != 0) {
      var_05 = distance(self.var_116, param_03.var_116);
      var_06 = lerp(0.1, self.var_65EA lib_04FF::func_45D0("grenadeDamageMult"), var_05 / var_04);
    } else {
      var_06 = self.var_65EA lib_04FF::func_45D0("grenadeDamageMult");
    }

    return max(param_02.var_FB * var_06, param_01);
  }

  if(isexplosivedamagemod(param_02)) {
    return min(int(var_04.var_FB * 0.51), param_03);
  }

  return param_03;
}

setoutline(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = game["attackers"];
  }

  if(!isDefined(param_00.outlinecolor)) {
    param_00.outlinecolor = 1;
  }

  if(param_01 == game["attackers"]) {
    var_02 = 1;
  } else {
    var_02 = 2;
  }

  param_00 hudoutlinedisableforclient(self);
  param_00 hudoutlineenableforclient(self, var_02, 1);
}

updatehudoutline() {
  self endon("death");
  self endon("destroyed");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_01 setoutline(self, var_01.var_1A7);
    }

    wait(3);
  }
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
  var_01 = self.var_3F7C;
  if(param_00 > var_01) {
    self.repairdamageto = max(0, self.var_29DD[param_00].healththreashold - 1);
  }

  if(isDefined(self.var_29DD[var_01])) {
    self.var_29DD[var_01] func_36EB();
  }

  for(var_02 = -1; var_02 <= param_00; var_02++) {
    if(isDefined(self.var_29DD[var_02])) {
      if(var_02 > var_01) {
        self.var_29DD[var_02] thread func_74E0();
      }
    }

    self.var_3F7C = var_02;
  }
}

fxstructinit(param_00) {
  param_00.var_65EB = self;
  param_00.var_3F78 = 0;
  param_00.var_6E56 = lib_0502::func_4679(param_00);
  if(lib_0502::func_A273(param_00.var_6E56, ["effect", "portions"], []) == 0) {
    return;
  }

  fxstructapplyparamaters(param_00);
  initfxnodes(param_00);
}

fxstructapplyparamaters(param_00) {
  if(!isDefined(level.var_611[param_00.var_6E56["effect"]])) {
    return;
  }

  param_00.var_6E56["portions"] = int(param_00.var_6E56["portions"]);
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

  var_00 = spawn("script_model", self.var_116);
  var_00 setModel("tag_origin");
  var_00.var_1D = self.var_1D;
  self.var_3F6E = var_00;
  self.var_3F73 = common_scripts\utility::func_44F5(self.var_6E56["effect"]);
  self.var_3F78 = 1;
  playFXOnTag(self.var_3F73, self.var_3F6E, "tag_origin");
  if(isDefined(self.var_65EB) && isDefined(self.var_65EB.partialdamaged_model)) {
    self.var_65EB setModel(self.var_65EB.partialdamaged_model);
  }

  if(isDefined(self.var_6E56["duration"])) {
    wait(int(self.var_6E56["duration"]));
    self.var_3F6E delete();
    self.var_3F78 = 0;
  }
}

func_36EB() {
  if(self.var_3F78 == 0) {
    return;
  }

  self.var_3F6E delete();
  self.var_3F78 = 0;
}

func_2E35(param_00) {
  param_00.var_65EA = self;
  param_00.var_6DA7 = undefined;
  lib_04FF::func_6983(self.var_1A5);
  if(!isDefined(param_00.var_6DA7)) {
    return;
  }

  var_01 = maps\mp\gametypes\_gameobjects::func_2837(game["defenders"], param_00, [], param_00.var_116, 1, 1);
  var_01 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_01 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_DEST");
  var_01 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_CONSTRUCT");
  var_01.var_A23E = 7;
  var_01.var_1B9 = "repair_trigger";
  var_01.var_695F = 1;
  var_01.var_A414 = 1;
  var_01 maps\mp\gametypes\_gameobjects::func_8A5A(1);
  var_01.var_9D65 = param_00;
  var_01.var_6AFA = ::func_2E26;
  param_00.var_7D0D = var_01;
  var_01 maps\mp\gametypes\_gameobjects::func_2F93();
  lib_04FF::func_6982(self.var_1A5);
  var_01 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_2E26(param_00, param_01, param_02) {
  if(param_02 == 0) {
    return;
  }

  if(!isDefined(self.var_9D65.var_6DA7)) {
    return;
  }

  var_03 = self.var_9D65.var_6DA7;
  var_03.var_6A = var_03.repairdamageto;
  var_04 = func_469D(var_03);
  if(var_04 != var_03.var_3F7C) {
    var_03 func_0A15(var_04);
  }

  self.var_9D65.var_7D0D maps\mp\gametypes\_gameobjects::func_2F93();
}

destructionovertimezoneinit(param_00) {
  self.overtimezone = param_00;
}

runovertimezone(param_00) {
  level endon("game_ended");
  var_01 = lib_04FF::func_45CE(self);
  var_02 = game["attackers"];
  var_03 = [];
  var_04 = min(10, self.var_6896) * 1000;
  var_05 = maps\mp\gametypes\_gameobjects::func_2837(var_02, param_00, var_03, var_01, 0, 1);
  var_05 thread destructionovertimeupdate(self.var_1A5);
  lib_04FF::func_6982(self.var_1A5);
  var_05 maps\mp\gametypes\_gameobjects::func_2F93();
  var_05 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_05 maps\mp\gametypes\_gameobjects::func_2D58();
}

destructionobjectiveupdate(param_00) {
  level endon("game_ended");
  var_01 = self.var_6896;
  while(self.var_6896 > 0) {
    if(self.var_6896 != var_01) {
      lib_04F3::func_79CE(game["music"]["stinger_pos"], game["attackers"]);
      lib_04F3::func_79CE(game["music"]["stinger_neg"], game["defenders"]);
      var_02 = var_01 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_02);
    }

    self waittill("prop_destroyed");
  }
}

destructionovertimeupdate(param_00) {
  self endon("deleted");
  for(;;) {
    if(self.var_9AC3[game["attackers"]].size > 0 && lib_04FF::func_79B8() / 1000 < 120) {
      lib_04FF::func_6981(param_00);
    }

    wait 0.05;
  }
}