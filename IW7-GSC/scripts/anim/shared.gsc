/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
***********************************/

placeweaponon(param_00, param_01, param_02) {
  self notify("weapon_position_change");
  var_03 = self.var_39B[param_00].weaponisauto;
  if(param_01 != "none" && self.a.weaponpos[param_01] == param_00) {
    return;
  }

  func_5390();
  if(var_03 != "none") {
    func_5398(param_00);
  }

  if(param_01 == "none") {
    func_12E61();
    return;
  }

  if(self.a.weaponpos[param_01] != "none") {
    func_5398(self.a.weaponpos[param_01]);
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(param_02 && param_01 == "left" || param_01 == "right") {
    func_24AF(param_00, param_01);
    self.var_394 = param_00;
  } else {
    func_24AF(param_00, param_01);
  }

  func_12E61();
}

func_5398(param_00) {
  self.a.weaponpos[self.var_39B[param_00].weaponisauto] = "none";
  self.var_39B[param_00].weaponisauto = "none";
}

func_24AF(param_00, param_01) {
  self.var_39B[param_00].weaponisauto = param_01;
  self.a.weaponpos[param_01] = param_00;
  if(self.a.weaponposdropping[param_01] != "none") {
    self notify("end_weapon_drop_" + param_01);
    self.a.weaponposdropping[param_01] = "none";
  }
}

orientmode(param_00) {
  var_01 = self.a.weaponpos[param_00];
  if(var_01 == "none") {
    return self.a.weaponposdropping[param_00];
  }

  return var_01;
}

func_5390() {
  var_00 = [];
  var_00[var_00.size] = "right";
  var_00[var_00.size] = "left";
  var_00[var_00.size] = "chest";
  var_00[var_00.size] = "back";
  self laseroff();
  foreach(var_02 in var_00) {
    var_03 = orientmode(var_02);
    if(var_03 == "none") {
      continue;
    }

    if(weapontype(var_03) == "riotshield" && isDefined(self.var_FCA0)) {
      if(isDefined(self.var_FC94) && self.var_FC94) {
        playFXOnTag(scripts\engine\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.var_FC94 = undefined;
      }
    }
  }

  self _meth_83CD();
}

func_12E61() {
  var_00 = [];
  var_01 = [];
  var_02 = [];
  var_00[var_00.size] = "right";
  var_00[var_00.size] = "left";
  var_00[var_00.size] = "chest";
  var_00[var_00.size] = "back";
  foreach(var_04 in var_00) {
    var_01[var_01.size] = orientmode(var_04);
    var_02[var_02.size] = _meth_8193(var_04);
  }

  self _meth_83CD(var_01[0], var_02[0], var_01[1], var_02[1], var_01[2], var_02[2], var_01[3], var_02[3]);
  foreach(var_04 in var_00) {
    var_07 = orientmode(var_04);
    if(var_07 == "none") {
      continue;
    }

    if(self.var_39B[var_07].var_13053 && !self.var_39B[var_07].var_8BDE) {
      self hidepart("tag_clip");
    }
  }

  updatelaserstatus();
}

updatelaserstatus() {
  if(isDefined(self.var_4C5C)) {
    [[self.var_4C5C]]();
    return;
  }

  if(self.a.weaponpos["right"] == "none") {
    return;
  }

  if(func_3939()) {
    self laseron();
    return;
  }

  self laseroff();
}

func_3939() {
  if(!self.a.laseron) {
    return 0;
  }

  if(scripts\anim\utility_common::isshotgun(self.var_394)) {
    return 0;
  }

  return isalive(self);
}

_meth_8193(param_00) {
  switch (param_00) {
    case "chest":
      return "tag_weapon_chest";

    case "back":
      return "tag_stowed_back";

    case "left":
      return "tag_weapon_left";

    case "right":
      return "tag_weapon_right";

    case "hand":
      return "tag_accessory_right";

    case "thigh":
      return "tag_stowed_thigh";

    default:
      break;
  }
}

func_5D19(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.var_394;
  }

  if(param_00 == "none") {
    return;
  }

  if(isDefined(self.var_C05C)) {
    return;
  }

  func_5390();
  var_01 = self.var_39B[param_00].weaponisauto;
  if(self.iscinematicplaying && var_01 != "none") {
    thread func_5EF5(param_00, var_01);
  }

  func_5398(param_00);
  if(param_00 == self.var_394) {
    self.var_394 = "none";
  }

  func_12E61();
}

func_5D1A() {
  if(isDefined(self.var_C05C)) {
    return "none";
  }

  var_00 = [];
  var_00[var_00.size] = "left";
  var_00[var_00.size] = "right";
  var_00[var_00.size] = "chest";
  var_00[var_00.size] = "back";
  func_5390();
  foreach(var_02 in var_00) {
    var_03 = self.a.weaponpos[var_02];
    if(var_03 == "none") {
      continue;
    }

    self.var_39B[var_03].weaponisauto = "none";
    self.a.weaponpos[var_02] = "none";
    if(self.iscinematicplaying) {
      thread func_5EF5(var_03, var_02);
    }
  }

  self.var_394 = "none";
  func_12E61();
}

func_5EF5(param_00, param_01) {
  if(self _meth_81B7()) {
    return "none";
  }

  self.a.weaponposdropping[param_01] = param_00;
  var_02 = getweaponbasename(param_00);
  var_03 = getsubstr(param_00, var_02.size, param_00.size);
  if(issubstr(tolower(var_02), "_ai")) {
    var_02 = getsubstr(var_02, 0, var_02.size - 3);
  }

  var_04 = var_02 + var_03;
  self dropweapon(var_04, param_01, 0);
  self endon("end_weapon_drop_" + param_01);
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  func_5390();
  self.a.weaponposdropping[param_01] = "none";
  func_12E61();
}

donotetracks(param_00, param_01, param_02) {
  for(;;) {
    self waittill(param_00, var_03);
    if(!isDefined(var_03)) {
      var_03 = ["undefined"];
    }

    if(!isarray(var_03)) {
      var_03 = [var_03];
    }

    scripts\anim\utility::validatenotetracks(param_00, var_03);
    foreach(var_05 in var_03) {
      var_06 = scripts\anim\notetracks::handlenotetrack(var_05, param_00, param_01);
      if(isDefined(var_06)) {
        return var_06;
      }
    }
  }
}

getaimyawtoshootentorpos() {
  if(!isDefined(self.var_FE9E)) {
    if(!isDefined(self.var_FECF)) {
      return 0;
    }

    return scripts\engine\utility::getaimyawtopoint(self.var_FECF);
  }

  return scripts\engine\utility::getaimyawtopoint(self.var_FE9E getshootatpos());
}

func_7DA5() {
  var_00 = _meth_8064();
  if(self.script == "cover_crouch" && isDefined(self.a.var_4727) && self.a.var_4727 == "lean") {
    var_00 = var_00 - level.covercrouchleanpitch;
  }

  return var_00;
}

_meth_8064() {
  if(!isDefined(self.var_FE9E)) {
    if(!isDefined(self.var_FECF)) {
      return 0;
    }

    return scripts\anim\combat_utility::castshadows(self.var_FECF);
  }

  return scripts\anim\combat_utility::castshadows(self.var_FE9E getshootatpos());
}

_meth_811C() {
  if(scripts\engine\utility::actor_is3d()) {
    return self getEye();
  }

  if(isDefined(self.var_130A9) && self.var_130A9) {
    var_00 = self getspawnteam();
    if(isDefined(self.var_130A8)) {
      return var_00;
    }

    return (var_00[0], var_00[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

func_DC59(param_00) {
  self endon("killanimscript");
  func_DC5A(param_00);
}

func_DC5A(param_00) {
  self endon("rambo_aim_end");
  waittillframeend;
  var_01 = 0.2;
  var_02 = 0;
  for(;;) {
    if(isDefined(self.var_FECF)) {
      var_03 = scripts\engine\utility::getyaw(self.var_FECF) - self.covernode.angles[1];
      var_03 = angleclamp180(var_03 - param_00);
      if(abs(var_03 - var_02) > 10) {
        if(var_03 > var_02) {
          var_03 = var_02 + 10;
        } else {
          var_03 = var_02 - 10;
        }
      }

      var_02 = var_03;
    }

    if(var_02 < 0) {
      var_04 = var_02 / -45;
      if(var_04 > 1) {
        var_04 = 1;
      }
    } else {
      var_04 = var_02 / 45;
      if(var_04 > 1) {
        var_04 = 1;
      }
    }

    wait(var_01);
  }
}

func_4F65() {
  var_00 = 0;
  var_01 = weaponburstcount(self.var_394);
  if(var_01) {
    var_00 = var_01;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    var_00 = level.var_F217[randomint(level.var_F217.size)];
  } else if(self.var_6B92) {
    var_00 = level.var_6B93[randomint(level.var_6B93.size)];
  } else {
    var_00 = level.var_32BF[randomint(level.var_32BF.size)];
  }

  if(var_00 <= self.bulletsinclip) {
    return var_00;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

func_4F66() {
  var_00 = self.bulletsinclip;
  if(weaponclass(self.var_394) == "mg") {
    var_01 = randomfloat(10);
    if(var_01 < 3) {
      var_00 = randomintrange(2, 6);
    } else if(var_01 < 8) {
      var_00 = randomintrange(6, 12);
    } else {
      var_00 = randomintrange(12, 20);
    }
  }

  return var_00;
}

handledropclip(param_00) {
  self endon("abort_reload");
  self endon(param_00 + "_finished");
  var_01 = self.var_394;
  var_02 = undefined;
  if(self.var_39B[self.var_394].var_13053) {
    var_02 = getweaponclipmodel(self.var_394);
  }

  if(self.var_39B[self.var_394].var_8BDE) {
    if(scripts\anim\utility_common::isusingsidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(var_02)) {
      self hidepart("tag_clip");
      thread func_5D25(var_02, "tag_clip");
      self.var_39B[self.var_394].var_8BDE = 0;
    }
  }

  var_03 = 0;
  while(!var_03) {
    self waittill(param_00, var_04);
    if(!isarray(var_04)) {
      var_04 = [var_04];
    }

    foreach(var_06 in var_04) {
      switch (var_06) {
        case "attach clip left":
          if(isDefined(var_02)) {
            self attach(var_02, "tag_accessory_left");
            if(!self.var_39B[self.var_394].var_8BDE) {
              self hidepart("tag_clip");
            }
          }

          scripts\anim\weaponlist::refillclip();
          break;

        case "attach clip right":
          if(isDefined(var_02)) {
            self attach(var_02, "tag_accessory_right");
            if(!self.var_39B[self.var_394].var_8BDE) {
              self hidepart("tag_clip");
            }
          }

          scripts\anim\weaponlist::refillclip();
          break;

        case "detach clip nohand":
          if(isDefined(var_02)) {
            self detach(var_02, "tag_accessory_right");
          }
          break;

        case "detach clip right":
          if(isDefined(var_02)) {
            self detach(var_02, "tag_accessory_right");
            if(var_01 == self.var_394) {
              self giveperk("tag_clip");
            } else {
              self.var_39B[var_01].var_8BDE = 1;
            }

            self notify("clip_detached");
            self.var_39B[self.var_394].var_8BDE = 1;
          }

          if(scripts\anim\utility_common::isusingsidearm()) {
            self playSound("weap_reload_pistol_clipin_npc");
          } else {
            self playSound("weap_reload_smg_clipin_npc");
          }

          self.a.needstorechamber = 0;
          var_03 = 1;
          break;

        case "detach clip left":
          if(isDefined(var_02)) {
            self detach(var_02, "tag_accessory_left");
            if(var_01 == self.var_394) {
              self giveperk("tag_clip");
            } else {
              self.var_39B[var_01].var_8BDE = 1;
            }

            self notify("clip_detached");
            self.var_39B[self.var_394].var_8BDE = 1;
          }

          if(scripts\anim\utility_common::isusingsidearm()) {
            self playSound("weap_reload_pistol_clipin_npc");
          } else {
            self playSound("weap_reload_smg_clipin_npc");
          }

          self.a.needstorechamber = 0;
          var_03 = 1;
          break;
      }
    }
  }
}

func_E24C(param_00, param_01) {
  self notify("clip_detached");
  self endon("clip_detached");
  scripts\engine\utility::waittill_any_3("killanimscript", "abort_reload");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(param_01)) {
    self detach(param_00, param_01);
  }

  if(isalive(self)) {
    if(self.var_394 != "none" && self.var_39B[self.var_394].weaponisauto != "none") {
      self giveperk("tag_clip");
    }

    self.var_39B[self.var_394].var_8BDE = 1;
    return;
  }

  if(isDefined(param_01)) {
    func_5D25(param_00, param_01);
  }
}

func_5D25(param_00, param_01) {
  var_02 = spawn("script_model", self gettagorigin(param_01));
  var_02 setModel(param_00);
  var_02.angles = self gettagangles(param_01);
  wait(0.05);
  var_02 physicslaunchclient(var_02.origin, (0, 0, -0.1));
  wait(10);
  if(isDefined(var_02)) {
    var_02 delete();
  }
}

func_BD1D(param_00, param_01) {
  self endon("killanimscript");
  var_02 = param_00.origin;
  var_03 = distancesquared(self.origin, var_02);
  if(var_03 < 1) {
    self ghost_target_position(var_02);
    return;
  }

  if(var_03 > 256 && !self maymovetopoint(var_02, !scripts\engine\utility::actor_is3d())) {
    return;
  }

  self.sendmatchdata = 1;
  var_04 = distance(self.origin, var_02);
  var_05 = int(param_01 * 20);
  for(var_06 = 0; var_06 < var_05; var_06++) {
    var_02 = param_00.origin;
    var_07 = self.origin - var_02;
    var_07 = vectornormalize(var_07);
    var_08 = var_02 + var_07 * var_04;
    var_09 = var_08 + var_02 - var_08 * var_06 + 1 / var_05;
    self ghost_target_position(var_09);
    wait(0.05);
  }

  self.sendmatchdata = 0;
}

func_E47B() {
  return 1;
}

func_D4C2(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = ::func_E47B;
  }

  for(var_03 = 0; var_03 < param_01 * 10; var_03++) {
    if(isalive(self.isnodeoccupied)) {
      if(scripts\anim\utility_common::canseeenemy() && [
          [param_02]
        ]()) {
        return;
      }
    }

    if(scripts\anim\utility_common::issuppressedwrapper() && [
        [param_02]
      ]()) {
      return;
    }

    self _meth_82A5(param_00, % body, 1, 0.1);
    wait(0.1);
  }
}

func_1180E(param_00) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\sp\gameskill::func_54C4();
}

func_E775() {
  var_00 = func_E777();
  if(var_00 == 0) {
    return;
  }

  self endon("death");
  for(;;) {
    level waittill("an_enemy_shot", var_01);
    if(var_01 != self) {
      continue;
    }

    if(!isDefined(var_01.isnodeoccupied)) {
      continue;
    }

    if(var_01.isnodeoccupied != level.player) {
      continue;
    }

    if(isDefined(level.var_4A0A) && level.var_4A0A == 0) {
      continue;
    }

    thread func_E776();
    var_00--;
    if(var_00 <= 0) {
      return;
    }
  }
}

func_E777() {
  var_00 = scripts\sp\utility::func_7E72();
  switch (var_00) {
    case "gimp":
    case "easy":
      return 2;

    case "difficult":
    case "hard":
    case "medium":
      return 1;

    case "fu":
      return 0;
  }

  return 2;
}

func_E776() {
  var_00 = missile_createrepulsorent(level.player, 5000, 800);
  wait(4);
  missile_deleteattractor(var_00);
}

func_CB29() {
  if(isDefined(self.var_13CAE) && self.var_13CAE) {
    return;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }

  if(distancesquared(self.origin, self.isnodeoccupied.origin) < self.var_42AE * self.var_42AE) {
    var_00 = self.var_72BB;
  } else {
    var_00 = self.var_72BC;
  }

  if(var_00 != self.var_394) {
    scripts\sp\utility::func_72EC(var_00, "primary");
    self.var_13C4D setModel(getweaponmodel(self.var_72BA));
    self.var_72BA = var_00;
  }
}