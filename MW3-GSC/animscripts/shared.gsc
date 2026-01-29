/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shared.gsc
**************************************/

_id_0C9B(var_0, var_1, var_2) {
  self notify("weapon_position_change");
  var_3 = self.weaponinfo[var_0]._id_2099;

  if(var_1 != "none" && self.a._id_0EE4[var_1] == var_0) {
    return;
  }
  _id_23C1();

  if(var_3 != "none") {
    _id_23BE(var_0);

  }
  if(var_1 == "none") {
    _id_23C4();
    return;
  }

  if(self.a._id_0EE4[var_1] != "none") {
    _id_23BE(self.a._id_0EE4[var_1]);

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  if(var_2 && (var_1 == "left" || var_1 == "right")) {
    _id_23BF(var_0, var_1);
    self.weapon = var_0;
  } else {
    _id_23BF(var_0, var_1);

  }
  _id_23C4();
}

_id_23BE(var_0) {
  self.a._id_0EE4[self.weaponinfo[var_0]._id_2099] = "none";
  self.weaponinfo[var_0]._id_2099 = "none";
}

_id_23BF(var_0, var_1) {
  self.weaponinfo[var_0]._id_2099 = var_1;
  self.a._id_0EE4[var_1] = var_0;

  if(self.a._id_20A4[var_1] != "none") {
    self notify("end_weapon_drop_" + var_1);
    self.a._id_20A4[var_1] = "none";
  }
}

_id_23C0(var_0) {
  var_1 = self.a._id_0EE4[var_0];

  if(var_1 == "none") {
    return self.a._id_20A4[var_0];

  }
  return var_1;
}

_id_23C1() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  self laseroff();

  foreach(var_2 in var_0) {
    var_3 = _id_23C0(var_2);

    if(var_3 == "none") {
      continue;
    }
    if(weapontype(var_3) == "riotshield" && isDefined(self._id_23C2)) {
      if(isDefined(self._id_23C3) && self._id_23C3) {
        playFXOnTag(common_scripts\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self._id_23C3 = undefined;
      }

      self detach(getweaponmodel(var_3, self._id_23C2), _id_23C7(var_2));
      continue;
    }

    self detach(getweaponmodel(var_3), _id_23C7(var_2));
  }
}

_id_23C4() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";

  foreach(var_2 in var_0) {
    var_3 = _id_23C0(var_2);

    if(var_3 == "none") {
      continue;
    }
    var_4 = 0;

    if(weapontype(var_3) == "riotshield" && isDefined(self._id_23C2)) {
      var_4 = self._id_23C2;

    }
    var_5 = getweaponmodel(var_3, var_4);

    if(weapontype(var_3) == "riotshield") {
      self attach(var_5, _id_23C7(var_2));
    } else {
      self attach(var_5, _id_23C7(var_2), 1);

    }
    var_6 = getweaponhidetags(var_3);

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      self hidepart(var_6[var_7], var_5);

    }
    if(self.weaponinfo[var_3]._id_209B && !self.weaponinfo[var_3]._id_209A) {
      self hidepart("tag_clip");
    }
  }

  _id_0CE0();
}

_id_0CE0() {
  if(isDefined(self._id_23C5)) {
    [[self._id_23C5]]();
  } else {
    if(self.a._id_0EE4["right"] == "none") {
      return;
    }
    if(_id_23C6()) {
      self laseron();
      return;
    }

    self laseroff();
  }
}

_id_23C6() {
  if(!self.a._id_0CDF) {
    return 0;

  }
  if(animscripts\utility::_id_0CEA(self.weapon)) {
    return 0;

  }
  return isalive(self);
}

_id_23C7(var_0) {
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
      return "tag_inhand";
    default:
      break;
  }
}

_id_23C8(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.weapon;

  }
  if(var_0 == "none") {
    return;
  }
  if(isDefined(self._id_2145)) {
    return;
  }
  _id_23C1();
  var_1 = self.weaponinfo[var_0]._id_2099;

  if(self.dropweapon && var_1 != "none") {
    thread _id_23C9(var_0, var_1);

  }
  _id_23BE(var_0);

  if(var_0 == self.weapon) {
    self.weapon = "none";

  }
  _id_23C4();
}

_id_0D73() {
  if(isDefined(self._id_2145)) {
    return "none";

  }
  var_0 = [];
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  _id_23C1();

  foreach(var_2 in var_0) {
    var_3 = self.a._id_0EE4[var_2];

    if(var_3 == "none") {
      continue;
    }
    self.weaponinfo[var_3]._id_2099 = "none";
    self.a._id_0EE4[var_2] = "none";

    if(self.dropweapon) {
      thread _id_23C9(var_3, var_2);
    }
  }

  self.weapon = "none";
  _id_23C4();
}

_id_23C9(var_0, var_1) {
  if(self isragdoll()) {
    return "none";

  }
  self.a._id_20A4[var_1] = var_0;
  var_2 = var_0;

  if(issubstr(tolower(var_2), "rpg")) {
    var_2 = "rpg_player";

  }
  self dropweapon(var_2, var_1, 0);
  self endon("end_weapon_drop_" + var_1);
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }
  _id_23C1();
  self.a._id_20A4[var_1] = "none";
  _id_23C4();
}

_id_0C51(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = "undefined";

    }
    var_4 = animscripts\notetracks::_id_23CA(var_3, var_0, var_1);

    if(isDefined(var_4)) {
      return var_4;
    }
  }
}

_id_111C(var_0) {
  if(!isDefined(self._id_0CAB)) {
    if(!isDefined(self._id_0CB1)) {
      return 0;

    }
    return _id_23CE(self._id_0CB1);
  }

  var_1 = self._id_0CAB.origin + self._id_0D81 * var_0;
  return _id_23CE(var_1);
}

_id_10E9() {
  if(!isDefined(self._id_0CAB)) {
    if(!isDefined(self._id_0CB1)) {
      return 0;

    }
    return _id_23CE(self._id_0CB1);
  }

  return _id_23CE(self._id_0CAB getshootatpos());
}

_id_23CB() {
  var_0 = _id_23CC();

  if(self.script == "cover_crouch" && isDefined(self.a._id_0CF8) && self.a._id_0CF8 == "lean") {
    var_0 = var_0 - anim._id_0CAD;

  }
  return var_0;
}

_id_23CC() {
  if(!isDefined(self._id_0CAB)) {
    if(!isDefined(self._id_0CB1)) {
      return 0;

    }
    return animscripts\combat_utility::_id_23B3(self._id_0CB1);
  }

  return animscripts\combat_utility::_id_23B3(self._id_0CAB getshootatpos());
}

_id_0CB0() {
  if(isDefined(self._id_23CD)) {
    var_0 = self getmuzzlesideoffsetpos();
    return (var_0[0], var_0[1], self getEye()[2]);
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

_id_23CE(var_0) {
  var_1 = animscripts\utility::_id_113E(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = asin(-3 / var_2);
    var_1 = var_1 + var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

#using_animtree("generic_human");

_id_0F90(var_0) {
  self endon("killanimscript");
  _id_23CF(var_0);
  self clearanim( % generic_aim_left, 0.5);
  self clearanim( % generic_aim_right, 0.5);
}

_id_23CF(var_0) {
  self endon("rambo_aim_end");
  waittillframeend;
  self clearanim( % generic_aim_left, 0.2);
  self clearanim( % generic_aim_right, 0.2);
  self setanimlimited( % generic_aim_45l, 1, 0.2);
  self setanimlimited( % generic_aim_45r, 1, 0.2);
  var_1 = 0.2;
  var_2 = 0;

  for(;;) {
    if(isDefined(self._id_0CB1)) {
      var_3 = animscripts\utility::_id_101A(self._id_0CB1) - self._id_0CAF.angles[1];
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
      self setanimlimited( % generic_aim_right, var_4, var_1);
      self setanimlimited( % generic_aim_left, 0, var_1);
    } else {
      var_4 = var_2 / 45;

      if(var_4 > 1) {
        var_4 = 1;

      }
      self setanimlimited( % generic_aim_left, var_4, var_1);
      self setanimlimited( % generic_aim_right, 0, var_1);
    }

    wait(var_1);
  }
}

_id_237A() {
  var_0 = 0;
  var_1 = weaponburstcount(self.weapon);

  if(var_1) {
    var_0 = var_1;
  } else if(animscripts\weaponlist::_id_0CCB()) {
    var_0 = anim._id_20DC[randomint(anim._id_20DC.size)];
  } else if(self._id_0CDB) {
    var_0 = anim._id_20DB[randomint(anim._id_20DB.size)];
  } else {
    var_0 = anim._id_20DA[randomint(anim._id_20DA.size)];

  }
  if(var_0 <= self._id_0CD1) {
    return var_0;

  }
  if(self._id_0CD1 <= 0) {
    return 1;

  }
  return self._id_0CD1;
}

_id_2379() {
  var_0 = self._id_0CD1;

  if(weaponclass(self.weapon) == "mg") {
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

_id_23D0(var_0, var_1) {}

_id_23D1(var_0) {
  self endon("killanimscript");
  self endon("abort_reload");
  var_1 = undefined;

  if(self.weaponinfo[self.weapon]._id_209B) {
    var_1 = getweaponclipmodel(self.weapon);

  }
  if(self.weaponinfo[self.weapon]._id_209A) {
    if(animscripts\utility::_id_0C95()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");

    }
    if(isDefined(var_1)) {
      self hidepart("tag_clip");
      thread _id_23D3(var_1, "tag_clip");
      self.weaponinfo[self.weapon]._id_209A = 0;
      thread _id_23D2(var_1);
    }
  }

  for(;;) {
    self waittill(var_0, var_2);

    switch (var_2) {
      case "attach clip right":
      case "attach clip left":
        if(isDefined(var_1)) {
          self attach(var_1, "tag_inhand");
          thread _id_23D2(var_1, "tag_inhand");
        }

        animscripts\weaponlist::_id_0CD0();
        break;
      case "detach clip nohand":
        if(isDefined(var_1)) {
          self detach(var_1, "tag_inhand");

        }
        break;
      case "detach clip right":
      case "detach clip left":
        if(isDefined(var_1)) {
          self detach(var_1, "tag_inhand");
          self showpart("tag_clip");
          self notify("clip_detached");
          self.weaponinfo[self.weapon]._id_209A = 1;
        }

        if(animscripts\utility::_id_0C95()) {
          self playSound("weap_reload_pistol_clipin_npc");
        } else {
          self playSound("weap_reload_smg_clipin_npc");

        }
        self.a._id_114D = 0;
        return;
    }
  }
}

_id_23D2(var_0, var_1) {
  self notify("clip_detached");
  self endon("clip_detached");
  common_scripts\utility::waittill_any("killanimscript", "abort_reload");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1)) {
    self detach(var_0, var_1);

  }
  if(isalive(self)) {
    if(self.weapon != "none" && self.weaponinfo[self.weapon]._id_2099 != "none") {
      self showpart("tag_clip");

    }
    self.weaponinfo[self.weapon]._id_209A = 1;
  } else if(isDefined(var_1)) {
    _id_23D3(var_0, var_1);
  }
}

_id_23D3(var_0, var_1) {
  var_2 = spawn("script_model", self gettagorigin(var_1));
  var_2 setModel(var_0);
  var_2.angles = self gettagangles(var_1);
  var_2 physicslaunchclient(var_2.origin, (0, 0, 0));
  wait 10;

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_0F7C(var_0, var_1) {
  self endon("killanimscript");
  var_2 = distancesquared(self.origin, var_0);

  if(var_2 < 1) {
    self safeteleport(var_0);
    return;
  }

  if(var_2 > 256 && !self maymovetopoint(var_0)) {
    return;
  }
  self.keepclaimednodeifvalid = 1;
  var_3 = self.origin - var_0;
  var_4 = int(var_1 * 20);
  var_5 = var_3 * 1.0 / var_4;

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_3 = var_3 - var_5;
    self safeteleport(var_0 + var_3);
    wait 0.05;
  }

  self.keepclaimednodeifvalid = 0;
}

_id_23D4() {
  return 1;
}

_id_0F93(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = ::_id_23D4;

  }
  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self.enemy)) {
      if(animscripts\utility::_id_0CE3() && [[var_2]]()) {
        return;
      }
    }

    if(animscripts\utility::_id_0F4C() && [[var_2]]()) {
      return;
    }
    self setanimknoball(var_0, % body, 1, 0.1);
    wait 0.1;
  }
}

_id_0F87(var_0) {
  self endon("killanimscript");
  _id_0C9B(self.secondaryweapon, "right");
  maps\_gameskill::_id_0F89();
}

_id_20A6() {
  var_0 = _id_23D6();

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
    if(isDefined(level._id_23D5) && level._id_23D5 == 0) {
      continue;
    }
    thread _id_23D7();
    var_0--;

    if(var_0 <= 0) {
      return;
    }
  }
}

_id_23D6() {
  var_0 = maps\_utility::_id_229D();

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

_id_23D7() {
  var_0 = missile_createrepulsorent(level.player, 5000, 800);
  wait 4.0;
  missile_deleteattractor(var_0);
}