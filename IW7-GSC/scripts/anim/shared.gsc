/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
*********************************************/

placeweaponon(var_0, var_1, var_2) {
  self notify("weapon_position_change");
  var_3 = self.var_39B[var_0].weaponisauto;
  if(var_1 != "none" && self.a.weaponpos[var_1] == var_0) {
    return;
  }

  func_5390();
  if(var_3 != "none") {
    func_5398(var_0);
  }

  if(var_1 == "none") {
    func_12E61();
    return;
  }

  if(self.a.weaponpos[var_1] != "none") {
    func_5398(self.a.weaponpos[var_1]);
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2 && var_1 == "left" || var_1 == "right") {
    func_24AF(var_0, var_1);
    self.var_394 = var_0;
  } else {
    func_24AF(var_0, var_1);
  }

  func_12E61();
}

func_5398(var_0) {
  self.a.weaponpos[self.var_39B[var_0].weaponisauto] = "none";
  self.var_39B[var_0].weaponisauto = "none";
}

func_24AF(var_0, var_1) {
  self.var_39B[var_0].weaponisauto = var_1;
  self.a.weaponpos[var_1] = var_0;
  if(self.a.weaponposdropping[var_1] != "none") {
    self notify("end_weapon_drop_" + var_1);
    self.a.weaponposdropping[var_1] = "none";
  }
}

orientmode(var_0) {
  var_1 = self.a.weaponpos[var_0];
  if(var_1 == "none") {
    return self.a.weaponposdropping[var_0];
  }

  return var_1;
}

func_5390() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  self laseroff();
  foreach(var_2 in var_0) {
    var_3 = orientmode(var_2);
    if(var_3 == "none") {
      continue;
    }

    if(weapontype(var_3) == "riotshield" && isDefined(self.var_FCA0)) {
      if(isDefined(self.var_FC94) && self.var_FC94) {
        playFXOnTag(scripts\engine\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self.var_FC94 = undefined;
      }
    }
  }

  self _meth_83CD();
}

func_12E61() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  foreach(var_4 in var_0) {
    var_1[var_1.size] = orientmode(var_4);
    var_2[var_2.size] = _meth_8193(var_4);
  }

  self _meth_83CD(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);
  foreach(var_4 in var_0) {
    var_7 = orientmode(var_4);
    if(var_7 == "none") {
      continue;
    }

    if(self.var_39B[var_7].var_13053 && !self.var_39B[var_7].var_8BDE) {
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

_meth_8193(var_0) {
  switch (var_0) {
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

func_5D19(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.var_394;
  }

  if(var_0 == "none") {
    return;
  }

  if(isDefined(self.var_C05C)) {
    return;
  }

  func_5390();
  var_1 = self.var_39B[var_0].weaponisauto;
  if(self.iscinematicplaying && var_1 != "none") {
    thread func_5EF5(var_0, var_1);
  }

  func_5398(var_0);
  if(var_0 == self.var_394) {
    self.var_394 = "none";
  }

  func_12E61();
}

func_5D1A() {
  if(isDefined(self.var_C05C)) {
    return "none";
  }

  var_0 = [];
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  func_5390();
  foreach(var_2 in var_0) {
    var_3 = self.a.weaponpos[var_2];
    if(var_3 == "none") {
      continue;
    }

    self.var_39B[var_3].weaponisauto = "none";
    self.a.weaponpos[var_2] = "none";
    if(self.iscinematicplaying) {
      thread func_5EF5(var_3, var_2);
    }
  }

  self.var_394 = "none";
  func_12E61();
}

func_5EF5(var_0, var_1) {
  if(self _meth_81B7()) {
    return "none";
  }

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = getweaponbasename(var_0);
  var_3 = getsubstr(var_0, var_2.size, var_0.size);
  if(issubstr(tolower(var_2), "_ai")) {
    var_2 = getsubstr(var_2, 0, var_2.size - 3);
  }

  var_4 = var_2 + var_3;
  self dropweapon(var_4, var_1, 0);
  self endon("end_weapon_drop_" + var_1);
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  func_5390();
  self.a.weaponposdropping[var_1] = "none";
  func_12E61();
}

donotetracks(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);
    if(!isDefined(var_3)) {
      var_3 = ["undefined"];
    }

    if(!isarray(var_3)) {
      var_3 = [var_3];
    }

    scripts\anim\utility::validatenotetracks(var_0, var_3);
    foreach(var_5 in var_3) {
      var_6 = scripts\anim\notetracks::handlenotetrack(var_5, var_0, var_1);
      if(isDefined(var_6)) {
        return var_6;
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
  var_0 = _meth_8064();
  if(self.script == "cover_crouch" && isDefined(self.a.var_4727) && self.a.var_4727 == "lean") {
    var_0 = var_0 - level.covercrouchleanpitch;
  }

  return var_0;
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
    var_0 = self getspawnteam();
    if(isDefined(self.var_130A8)) {
      return var_0;
    }

    return (var_0[0], var_0[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

func_DC59(var_0) {
  self endon("killanimscript");
  func_DC5A(var_0);
}

func_DC5A(var_0) {
  self endon("rambo_aim_end");
  waittillframeend;
  var_1 = 0.2;
  var_2 = 0;
  for(;;) {
    if(isDefined(self.var_FECF)) {
      var_3 = scripts\engine\utility::getyaw(self.var_FECF) - self.covernode.angles[1];
      var_3 = angleclamp180(var_3 - var_0);
      if(abs(var_3 - var_2) > 10) {
        if(var_3 > var_2) {
          var_3 = var_2 + 10;
        } else {
          var_3 = var_2 - 10;
        }
      }

      var_2 = var_3;
    }

    if(var_2 < 0) {
      var_4 = var_2 / -45;
      if(var_4 > 1) {
        var_4 = 1;
      }
    } else {
      var_4 = var_2 / 45;
      if(var_4 > 1) {
        var_4 = 1;
      }
    }

    wait(var_1);
  }
}

func_4F65() {
  var_0 = 0;
  var_1 = weaponburstcount(self.var_394);
  if(var_1) {
    var_0 = var_1;
  } else if(scripts\anim\weaponlist::usingsemiautoweapon()) {
    var_0 = level.var_F217[randomint(level.var_F217.size)];
  } else if(self.var_6B92) {
    var_0 = level.var_6B93[randomint(level.var_6B93.size)];
  } else {
    var_0 = level.var_32BF[randomint(level.var_32BF.size)];
  }

  if(var_0 <= self.bulletsinclip) {
    return var_0;
  }

  if(self.bulletsinclip <= 0) {
    return 1;
  }

  return self.bulletsinclip;
}

func_4F66() {
  var_0 = self.bulletsinclip;
  if(weaponclass(self.var_394) == "mg") {
    var_1 = randomfloat(10);
    if(var_1 < 3) {
      var_0 = randomintrange(2, 6);
    } else if(var_1 < 8) {
      var_0 = randomintrange(6, 12);
    } else {
      var_0 = randomintrange(12, 20);
    }
  }

  return var_0;
}

handledropclip(var_0) {
  self endon("abort_reload");
  self endon(var_0 + "_finished");
  var_1 = self.var_394;
  var_2 = undefined;
  if(self.var_39B[self.var_394].var_13053) {
    var_2 = getweaponclipmodel(self.var_394);
  }

  if(self.var_39B[self.var_394].var_8BDE) {
    if(scripts\anim\utility_common::isusingsidearm()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(var_2)) {
      self hidepart("tag_clip");
      thread func_5D25(var_2, "tag_clip");
      self.var_39B[self.var_394].var_8BDE = 0;
    }
  }

  var_3 = 0;
  while(!var_3) {
    self waittill(var_0, var_4);
    if(!isarray(var_4)) {
      var_4 = [var_4];
    }

    foreach(var_6 in var_4) {
      switch (var_6) {
        case "attach clip left":
          if(isDefined(var_2)) {
            self attach(var_2, "tag_accessory_left");
            if(!self.var_39B[self.var_394].var_8BDE) {
              self hidepart("tag_clip");
            }
          }

          scripts\anim\weaponlist::refillclip();
          break;

        case "attach clip right":
          if(isDefined(var_2)) {
            self attach(var_2, "tag_accessory_right");
            if(!self.var_39B[self.var_394].var_8BDE) {
              self hidepart("tag_clip");
            }
          }

          scripts\anim\weaponlist::refillclip();
          break;

        case "detach clip nohand":
          if(isDefined(var_2)) {
            self detach(var_2, "tag_accessory_right");
          }
          break;

        case "detach clip right":
          if(isDefined(var_2)) {
            self detach(var_2, "tag_accessory_right");
            if(var_1 == self.var_394) {
              self giveperk("tag_clip");
            } else {
              self.var_39B[var_1].var_8BDE = 1;
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
          var_3 = 1;
          break;

        case "detach clip left":
          if(isDefined(var_2)) {
            self detach(var_2, "tag_accessory_left");
            if(var_1 == self.var_394) {
              self giveperk("tag_clip");
            } else {
              self.var_39B[var_1].var_8BDE = 1;
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
          var_3 = 1;
          break;
      }
    }
  }
}

func_E24C(var_0, var_1) {
  self notify("clip_detached");
  self endon("clip_detached");
  scripts\engine\utility::waittill_any_3("killanimscript", "abort_reload");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_1)) {
    self detach(var_0, var_1);
  }

  if(isalive(self)) {
    if(self.var_394 != "none" && self.var_39B[self.var_394].weaponisauto != "none") {
      self giveperk("tag_clip");
    }

    self.var_39B[self.var_394].var_8BDE = 1;
    return;
  }

  if(isDefined(var_1)) {
    func_5D25(var_0, var_1);
  }
}

func_5D25(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_1));
  var_2 setModel(var_0);
  var_2.angles = self gettagangles(var_1);
  wait(0.05);
  var_2 physicslaunchclient(var_2.origin, (0, 0, -0.1));
  wait(10);
  if(isDefined(var_2)) {
    var_2 delete();
  }
}

func_BD1D(var_0, var_1) {
  self endon("killanimscript");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);
  if(var_3 < 1) {
    self ghost_target_position(var_2);
    return;
  }

  if(var_3 > 256 && !self maymovetopoint(var_2, !scripts\engine\utility::actor_is3d())) {
    return;
  }

  self.sendmatchdata = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);
  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectornormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + var_2 - var_8 * var_6 + 1 / var_5;
    self ghost_target_position(var_9);
    wait(0.05);
  }

  self.sendmatchdata = 0;
}

func_E47B() {
  return 1;
}

func_D4C2(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = ::func_E47B;
  }

  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.isnodeoccupied)) {
      if(scripts\anim\utility_common::canseeenemy() && [[var_2]]()) {
        return;
      }
    }

    if(scripts\anim\utility_common::issuppressedwrapper() && [
        [var_2]
      ]()) {
      return;
    }

    self _meth_82A5(var_0, % body, 1, 0.1);
    wait(0.1);
  }
}

func_1180E(var_0) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\sp\gameskill::func_54C4();
}

func_E775() {
  var_0 = func_E777();
  if(var_0 == 0) {
    return;
  }

  self endon("death");
  for(;;) {
    level waittill("an_enemy_shot", var_1);
    if(var_1 != self) {
      continue;
    }

    if(!isDefined(var_1.isnodeoccupied)) {
      continue;
    }

    if(var_1.isnodeoccupied != level.player) {
      continue;
    }

    if(isDefined(level.var_4A0A) && level.var_4A0A == 0) {
      continue;
    }

    thread func_E776();
    var_0--;
    if(var_0 <= 0) {
      return;
    }
  }
}

func_E777() {
  var_0 = scripts\sp\utility::func_7E72();
  switch (var_0) {
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
  var_0 = missile_createrepulsorent(level.player, 5000, 800);
  wait(4);
  missile_deleteattractor(var_0);
}

func_CB29() {
  if(isDefined(self.var_13CAE) && self.var_13CAE) {
    return;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }

  if(distancesquared(self.origin, self.isnodeoccupied.origin) < self.var_42AE * self.var_42AE) {
    var_0 = self.var_72BB;
  } else {
    var_0 = self.var_72BC;
  }

  if(var_0 != self.var_394) {
    scripts\sp\utility::func_72EC(var_0, "primary");
    self.var_13C4D setModel(getweaponmodel(self.var_72BA));
    self.var_72BA = var_0;
  }
}