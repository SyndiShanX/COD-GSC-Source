/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
**************************************/

placeweaponon(var_0, var_1, var_2) {
  self notify("weapon_position_change");
  var_3 = self.weaponinfo[var_0].position;

  if(var_1 != "none" && self.a.weaponpos[var_1] == var_0) {
    return;
  }
  _id_5390();

  if(var_3 != "none")
    _id_5398(var_0);

  if(var_1 == "none") {
    _id_12E61();
    return;
  }

  if(self.a.weaponpos[var_1] != "none")
    _id_5398(self.a.weaponpos[var_1]);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2 && (var_1 == "left" || var_1 == "right")) {
    _id_24AF(var_0, var_1);
    self.weapon = var_0;
  } else
    _id_24AF(var_0, var_1);

  _id_12E61();
}

_id_5398(var_0) {
  self.a.weaponpos[self.weaponinfo[var_0].position] = "none";
  self.weaponinfo[var_0].position = "none";
}

_id_24AF(var_0, var_1) {
  self.weaponinfo[var_0].position = var_1;
  self.a.weaponpos[var_1] = var_0;

  if(self.a.weaponposdropping[var_1] != "none") {
    self notify("end_weapon_drop_" + var_1);
    self.a.weaponposdropping[var_1] = "none";
  }
}

_id_8221(var_0) {
  var_1 = self.a.weaponpos[var_0];

  if(var_1 == "none")
    return self.a.weaponposdropping[var_0];

  return var_1;
}

_id_5390() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  self laseroff();

  foreach(var_2 in var_0) {
    var_3 = _id_8221(var_2);

    if(var_3 == "none") {
      continue;
    }
    if(weapontype(var_3) == "riotshield" && isDefined(self._id_FCA0)) {
      if(isDefined(self._id_FC94) && self._id_FC94) {
        playFXOnTag(scripts\engine\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self._id_FC94 = undefined;
      }
    }
  }

  self _meth_83CD();
}

_id_12E61() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";

  foreach(var_4 in var_0) {
    var_1[var_1.size] = _id_8221(var_4);
    var_2[var_2.size] = _id_8193(var_4);
  }

  self _meth_83CD(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);

  foreach(var_4 in var_0) {
    var_7 = _id_8221(var_4);

    if(var_7 == "none") {
      continue;
    }
    if(self.weaponinfo[var_7]._id_13053 && !self.weaponinfo[var_7]._id_8BDE)
      self hidepart("tag_clip");
  }

  updatelaserstatus();
}

updatelaserstatus() {
  if(isDefined(self._id_4C5C))
    [[self._id_4C5C]]();
  else {
    if(self.a.weaponpos["right"] == "none") {
      return;
    }
    if(_id_3939()) {
      self laseron();
      return;
    }

    self laseroff();
  }
}

_id_3939() {
  if(!self.a.laseron)
    return 0;

  if(scripts\anim\utility_common::isshotgun(self.weapon))
    return 0;

  return isalive(self);
}

_id_8193(var_0) {
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

_id_5D19(var_0) {
  if(!isDefined(var_0))
    var_0 = self.weapon;

  if(var_0 == "none") {
    return;
  }
  if(isDefined(self._id_C05C)) {
    return;
  }
  _id_5390();
  var_1 = self.weaponinfo[var_0].position;

  if(self.dropweapon && var_1 != "none")
    thread _id_5EF5(var_0, var_1);

  _id_5398(var_0);

  if(var_0 == self.weapon)
    self.weapon = "none";

  _id_12E61();
}

_id_5D1A() {
  if(isDefined(self._id_C05C))
    return "none";

  var_0 = [];
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  _id_5390();

  foreach(var_2 in var_0) {
    var_3 = self.a.weaponpos[var_2];

    if(var_3 == "none") {
      continue;
    }
    self.weaponinfo[var_3].position = "none";
    self.a.weaponpos[var_2] = "none";

    if(self.dropweapon)
      thread _id_5EF5(var_3, var_2);
  }

  self.weapon = "none";
  _id_12E61();
}

_id_5EF5(var_0, var_1) {
  if(self _meth_81B7())
    return "none";

  self.a.weaponposdropping[var_1] = var_0;
  var_2 = getweaponbasename(var_0);
  var_3 = getsubstr(var_0, var_2.size, var_0.size);

  if(issubstr(tolower(var_2), "_ai"))
    var_2 = getsubstr(var_2, 0, var_2.size - 3);

  var_4 = var_2 + var_3;
  self dropweapon(var_4, var_1, 0);
  self endon("end_weapon_drop_" + var_1);
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  _id_5390();
  self.a.weaponposdropping[var_1] = "none";
  _id_12E61();
}

donotetracks(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3))
      var_3 = ["undefined"];

    if(!isarray(var_3))
      var_3 = [var_3];

    scripts\anim\utility::validatenotetracks(var_0, var_3);

    foreach(var_5 in var_3) {
      var_6 = scripts\anim\notetracks::handlenotetrack(var_5, var_0, var_1);

      if(isDefined(var_6))
        return var_6;
    }
  }
}

getaimyawtoshootentorpos() {
  if(!isDefined(self._id_FE9E)) {
    if(!isDefined(self._id_FECF))
      return 0;

    return scripts\engine\utility::getaimyawtopoint(self._id_FECF);
  }

  return scripts\engine\utility::getaimyawtopoint(self._id_FE9E getshootatpos());
}

_id_7DA5() {
  var_0 = _id_8064();

  if(self.script == "cover_crouch" && isDefined(self.a._id_4727) && self.a._id_4727 == "lean")
    var_0 = var_0 - anim.covercrouchleanpitch;

  return var_0;
}

_id_8064() {
  if(!isDefined(self._id_FE9E)) {
    if(!isDefined(self._id_FECF))
      return 0;

    return scripts\anim\combat_utility::_id_8065(self._id_FECF);
  }

  return scripts\anim\combat_utility::_id_8065(self._id_FE9E getshootatpos());
}

_id_811C() {
  if(scripts\engine\utility::actor_is3d())
    return self getEye();
  else {
    if(isDefined(self._id_130A9) && self._id_130A9) {
      var_0 = self _meth_8143();

      if(isDefined(self._id_130A8))
        return var_0;

      return (var_0[0], var_0[1], self getEye()[2]);
    }

    return (self.origin[0], self.origin[1], self getEye()[2]);
  }
}

_id_DC59(var_0) {
  self endon("killanimscript");
  _id_DC5A(var_0);
}

_id_DC5A(var_0) {
  self endon("rambo_aim_end");
  waittillframeend;
  var_1 = 0.2;
  var_2 = 0;

  for(;;) {
    if(isDefined(self._id_FECF)) {
      var_3 = scripts\engine\utility::getyaw(self._id_FECF) - self.covernode.angles[1];
      var_3 = angleclamp180(var_3 - var_0);

      if(abs(var_3 - var_2) > 10) {
        if(var_3 > var_2)
          var_3 = var_2 + 10;
        else
          var_3 = var_2 - 10;
      }

      var_2 = var_3;
    }

    if(var_2 < 0) {
      var_4 = var_2 / -45;

      if(var_4 > 1)
        var_4 = 1;
    } else {
      var_4 = var_2 / 45;

      if(var_4 > 1)
        var_4 = 1;
    }

    wait(var_1);
  }
}

_id_4F65() {
  var_0 = 0;
  var_1 = weaponburstcount(self.weapon);

  if(var_1)
    var_0 = var_1;
  else if(scripts\anim\weaponlist::usingsemiautoweapon())
    var_0 = anim._id_F217[randomint(anim._id_F217.size)];
  else if(self._id_6B92)
    var_0 = anim._id_6B93[randomint(anim._id_6B93.size)];
  else
    var_0 = anim._id_32BF[randomint(anim._id_32BF.size)];

  if(var_0 <= self.bulletsinclip)
    return var_0;

  if(self.bulletsinclip <= 0)
    return 1;

  return self.bulletsinclip;
}

_id_4F66() {
  var_0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    var_1 = randomfloat(10);

    if(var_1 < 3)
      var_0 = randomintrange(2, 6);
    else if(var_1 < 8)
      var_0 = randomintrange(6, 12);
    else
      var_0 = randomintrange(12, 20);
  }

  return var_0;
}

handledropclip(var_0) {
  self endon("abort_reload");
  self endon(var_0 + "_finished");
  var_1 = self.weapon;
  var_2 = undefined;

  if(self.weaponinfo[self.weapon]._id_13053)
    var_2 = getweaponclipmodel(self.weapon);

  if(self.weaponinfo[self.weapon]._id_8BDE) {
    if(scripts\anim\utility_common::isusingsidearm())
      self playSound("weap_reload_pistol_clipout_npc");
    else
      self playSound("weap_reload_smg_clipout_npc");

    if(isDefined(var_2)) {
      self hidepart("tag_clip");
      thread _id_5D25(var_2, "tag_clip");
      self.weaponinfo[self.weapon]._id_8BDE = 0;
    }
  }

  var_3 = 0;

  while(!var_3) {
    self waittill(var_0, var_4);

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_6 in var_4) {
      switch (var_6) {
        case "attach clip left":
          if(isDefined(var_2)) {
            self attach(var_2, "tag_accessory_left");

            if(!self.weaponinfo[self.weapon]._id_8BDE)
              self hidepart("tag_clip");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "attach clip right":
          if(isDefined(var_2)) {
            self attach(var_2, "tag_accessory_right");

            if(!self.weaponinfo[self.weapon]._id_8BDE)
              self hidepart("tag_clip");
          }

          scripts\anim\weaponlist::refillclip();
          break;
        case "detach clip nohand":
          if(isDefined(var_2))
            self detach(var_2, "tag_accessory_right");

          break;
        case "detach clip right":
          if(isDefined(var_2)) {
            self detach(var_2, "tag_accessory_right");

            if(var_1 == self.weapon)
              self showpart("tag_clip");
            else
              self.weaponinfo[var_1]._id_8BDE = 1;

            self notify("clip_detached");
            self.weaponinfo[self.weapon]._id_8BDE = 1;
          }

          if(scripts\anim\utility_common::isusingsidearm())
            self playSound("weap_reload_pistol_clipin_npc");
          else
            self playSound("weap_reload_smg_clipin_npc");

          self.a.needstorechamber = 0;
          var_3 = 1;
          break;
        case "detach clip left":
          if(isDefined(var_2)) {
            self detach(var_2, "tag_accessory_left");

            if(var_1 == self.weapon)
              self showpart("tag_clip");
            else
              self.weaponinfo[var_1]._id_8BDE = 1;

            self notify("clip_detached");
            self.weaponinfo[self.weapon]._id_8BDE = 1;
          }

          if(scripts\anim\utility_common::isusingsidearm())
            self playSound("weap_reload_pistol_clipin_npc");
          else
            self playSound("weap_reload_smg_clipin_npc");

          self.a.needstorechamber = 0;
          var_3 = 1;
          break;
      }
    }
  }
}

_id_E24C(var_0, var_1) {
  self notify("clip_detached");
  self endon("clip_detached");
  scripts\engine\utility::waittill_any("killanimscript", "abort_reload");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1))
    self detach(var_0, var_1);

  if(isalive(self)) {
    if(self.weapon != "none" && self.weaponinfo[self.weapon].position != "none")
      self showpart("tag_clip");

    self.weaponinfo[self.weapon]._id_8BDE = 1;
  } else if(isDefined(var_1))
    _id_5D25(var_0, var_1);
}

_id_5D25(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_1));
  var_2 setModel(var_0);
  var_2.angles = self gettagangles(var_1);
  wait 0.05;
  var_2 _meth_8224(var_2.origin, (0, 0, -0.1));
  wait 10;

  if(isDefined(var_2))
    var_2 delete();
}

_id_BD1D(var_0, var_1) {
  self endon("killanimscript");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);

  if(var_3 < 1) {
    self _meth_8272(var_2);
    return;
  }

  if(var_3 > 256 && !self maymovetopoint(var_2, !scripts\engine\utility::actor_is3d())) {
    return;
  }
  self.keepclaimednodeifvalid = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectorNormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + (var_2 - var_8) * ((var_6 + 1) / var_5);
    self _meth_8272(var_9);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

_id_E47B() {
  return 1;
}

#using_animtree("generic_human");

_id_D4C2(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = ::_id_E47B;

  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.enemy)) {
      if(scripts\anim\utility_common::canseeenemy() && [[var_2]]())
        return;
    }

    if(scripts\anim\utility_common::issuppressedwrapper() && [[var_2]]()) {
      return;
    }
    self _meth_82A5(var_0, %body, 1, 0.1);
    wait 0.1;
  }
}

_id_1180E(var_0) {
  self endon("killanimscript");
  placeweaponon(self.secondaryweapon, "right");
  scripts\sp\gameskill::_id_54C4();
}

_id_E775() {
  var_0 = _id_E777();

  if(var_0 == 0) {
    return;
  }
  self endon("death");

  for(;;) {
    level waittill("an_enemy_shot", var_1);

    if(var_1 != self) {
      continue;
    }
    if(!isDefined(var_1.enemy)) {
      continue;
    }
    if(var_1.enemy != level.player) {
      continue;
    }
    if(isDefined(level._id_4A0A) && level._id_4A0A == 0) {
      continue;
    }
    thread _id_E776();
    var_0--;

    if(var_0 <= 0)
      return;
  }
}

_id_E777() {
  var_0 = scripts\sp\utility::_id_7E72();

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

_id_E776() {
  var_0 = missile_createrepulsorent(level.player, 5000, 800);
  wait 4.0;
  missile_deleteattractor(var_0);
}

_id_CB29() {
  if(isDefined(self._id_13CAE) && self._id_13CAE) {
    return;
  }
  if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }
  if(distancesquared(self.origin, self.enemy.origin) < self._id_42AE * self._id_42AE)
    var_0 = self._id_72BB;
  else
    var_0 = self._id_72BC;

  if(var_0 != self.weapon) {
    scripts\sp\utility::_id_72EC(var_0, "primary");
    self._id_13C4D setModel(getweaponmodel(self._id_72BA));
    self._id_72BA = var_0;
  }
}