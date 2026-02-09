/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\death.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  self stopsoundchannel("voice");
  var_0 = 0.3;
  self clearanim(%scripted_talking, var_0);

  if(self.a._id_0D55 == 1) {
    return;
  }
  if(isDefined(self._id_0D45)) {
    var_1 = self[[self._id_0D45]]();

    if(!isDefined(var_1)) {
      var_1 = 1;
    }
    if(var_1) {
      return;
    }
  }

  animscripts\utility::_id_0D15("death");
  _id_0ED1(self.origin);
  anim._id_0D43--;
  anim._id_0D6B--;

  if(isDefined(self._id_0EC0) || self.forceragdollimmediate) {
    _id_0EC2();
  }
  if(isDefined(self._id_0D50)) {
    _id_0D56(self._id_0D50);

    if(isDefined(self._id_0EC1)) {
      self[[self._id_0EC1]]();
    }
    return;
  }

  var_2 = animscripts\pain::_id_0D1F();

  if(self.damagelocation == "helmet" || self.damagelocation == "head") {
    _id_0D17();
  } else if(var_2 && randomint(3) == 0) {
    _id_0D17();
  }
  self clearanim(%root, 0.3);

  if(!animscripts\utility::_id_0D2F("head", "helmet")) {
    if(self.diequietly) {} else {
      playdeathsound();
    }
  }

  if(var_2 && _id_0EE7()) {
    return;
  }
  if(isDefined(self._id_0D4B)) {
    if([[self._id_0D4B]]()) {
      return;
    }
  }

  if(_id_0ECC()) {
    return;
  }
  var_3 = _id_0ED8();
  _id_0D56(var_3);
}

_id_0EC2() {
  animscripts\shared::_id_0D73();
  self._id_0EC3 = 1;
  var_0 = 10;
  var_1 = common_scripts\_destructible::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var_1 == "melee") {
    var_0 = 5;
  }
  var_2 = self.damagetaken;

  if(var_1 == "bullet") {
    var_2 = max(var_2, 300);
  }
  var_3 = var_0 * var_2;
  var_4 = max(0.3, self.damagedir[2]);
  var_5 = (self.damagedir[0], self.damagedir[1], var_4);

  if(isDefined(self._id_0EC4)) {
    var_5 = var_5 * self._id_0EC4;
  } else {
    var_5 = var_5 * var_3;
  }
  if(self.forceragdollimmediate) {
    var_5 = var_5 + self.prevanimdelta * 20 * 10;
  }
  if(isDefined(self._id_0EC5)) {
    var_5 = var_5 + self._id_0EC5 * 10;
  }
  self startragdollfromimpact(self.damagelocation, var_5);
  wait 0.05;
}

_id_0D56(var_0) {
  if(!animhasnotetrack(var_0, "dropgun") && !animhasnotetrack(var_0, "fire_spray")) {
    animscripts\shared::_id_0D73();
  }
  self setflaggedanimknoballrestart("deathanim", var_0, %body, 1, 0.1);

  if(isDefined(self._id_0EC3)) {
    if(!isDefined(self._id_0EC6)) {
      self startragdoll();
    }
    wait 0.05;
    self animmode("gravity");
  } else if(isDefined(self._id_0EC7)) {
    thread _id_0EC8(self._id_0EC7);
  } else if(!animhasnotetrack(var_0, "start_ragdoll")) {
    thread _id_0EC8(getanimlength(var_0) * 0.35);
  }
  if(!isDefined(self._id_0EC3)) {
    thread _id_0EC9();
  }
  animscripts\shared::_id_0C51("deathanim");
  animscripts\shared::_id_0D73();
}

_id_0EC8(var_0) {
  wait(var_0);

  if(isDefined(self)) {
    animscripts\shared::_id_0D73();
  }
  if(isDefined(self) && !isDefined(self._id_0EC6)) {
    self startragdoll();
  }
}

_id_0EC9() {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }
  wait 2;
  _id_0ECA();
}

_id_0ECA(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_0ECB)) {
    return;
  }
  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = bulletTrace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, undefined);

  if(var_7["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var_2);
  }
}

_id_0ECC() {
  if(self.a._id_0D19 == "none") {
    return 0;
  }
  switch (self.a._id_0D19) {
    case "cover_right":
      if(self.a._id_0D26 == "stand") {
        var_0 = [];
        var_0[0] = % corner_standr_deatha;
        var_0[1] = % corner_standr_deathb;
        _id_0ECD(var_0);
      } else {
        var_0 = [];

        if(animscripts\utility::_id_0D2F("head", "neck")) {
          var_0[0] = % cornercrr_alert_death_slideout;
        } else {
          var_0[0] = % cornercrr_alert_death_slideout;
          var_0[1] = % cornercrr_alert_death_back;
        }

        _id_0ECD(var_0);
      }

      return 1;
    case "cover_left":
      if(self.a._id_0D26 == "stand") {
        var_0 = [];
        var_0[0] = % corner_standl_deatha;
        var_0[1] = % corner_standl_deathb;
        _id_0ECD(var_0);
      } else {
        var_0 = [];
        var_0[0] = % cornercrl_death_side;
        var_0[1] = % cornercrl_death_back;
        _id_0ECD(var_0);
      }

      return 1;
    case "cover_stand":
      var_0 = [];
      var_0[0] = % coverstand_death_left;
      var_0[1] = % coverstand_death_right;
      _id_0ECD(var_0);
      return 1;
    case "cover_crouch":
      var_0 = [];

      if(animscripts\utility::_id_0D2F("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        var_0[var_0.size] = % covercrouch_death_1;
      }
      if(self.damageyaw > -45 && self.damageyaw <= 45) {
        var_0[var_0.size] = % covercrouch_death_3;
      }
      var_0[var_0.size] = % covercrouch_death_2;
      _id_0ECD(var_0);
      return 1;
    case "saw":
      if(self.a._id_0D26 == "stand") {
        _id_0ECD(animscripts\utility::_id_0C6D(%saw_gunner_death));
      } else if(self.a._id_0D26 == "crouch") {
        _id_0ECD(animscripts\utility::_id_0C6D(%saw_gunner_lowwall_death));
      } else {
        _id_0ECD(animscripts\utility::_id_0C6D(%saw_gunner_prone_death));
      }
      return 1;
    case "dying_crawl":
      if(isDefined(self.a._id_0D29) && self.a._id_0D26 == "crouch") {
        var_0 = animscripts\utility::_id_0C6D(%dying_back_death_v2, %dying_back_death_v3, %dying_back_death_v4);
        _id_0ECD(var_0);
      } else {
        var_0 = animscripts\utility::_id_0C6D(%dying_crawl_death_v1, %dying_crawl_death_v2);
        _id_0ECD(var_0);
      }

      return 1;
  }

  return 0;
}

_id_0ECD(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  _id_0D56(var_1);

  if(isDefined(self._id_0EC1)) {
    self[[self._id_0EC1]]();
  }
}

playdeathsound() {
  animscripts\face::_id_0C41("death");
}

_id_0ECE(var_0, var_1, var_2) {
  var_3 = var_2 * 20;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    wait 0.05;
  }
}

_id_0D17() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.hatmodel)) {
    return;
  }
  var_0 = getpartname(self.hatmodel, 0);
  var_1 = spawn("script_model", self.origin + (0, 0, 64));
  var_1 setModel(self.hatmodel);
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_1 thread _id_0ED0(self.damagedir);
  var_2 = self.hatmodel;
  self.hatmodel = undefined;
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self detach(var_2, "");
}

_id_0ED0(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
  wait 60;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

_id_0ED1(var_0) {
  for(var_1 = 0; var_1 < anim._id_0A63.size; var_1++) {
    anim._id_0A63[var_1] _id_0ED2(var_0);
  }
}

_id_0ED2(var_0) {
  if(!isDefined(self._id_0ED3)) {
    return;
  }
  if(distance(var_0, self._id_0ED3) < 80) {
    self._id_0ED3 = undefined;
    self._id_0A67 = gettime();
  }
}

_id_0ED4() {
  if(self.a._id_0D2B != "run") {
    return 0;
  }
  if(self getmotionangle() > 60 || self getmotionangle() < -60) {
    return 0;
  }
  return 1;
}

_id_0ED5(var_0, var_1, var_2, var_3) {
  if(isDefined(self.a._id_0D69)) {
    return 0;
  }
  if(self.a._id_0D26 == "prone" || isDefined(self.a._id_0D29)) {
    return 0;
  }
  if(var_0 == "none") {
    return 0;
  }
  if(var_2 > 500) {
    return 1;
  }
  if(var_1 == "MOD_MELEE") {
    return 0;
  }
  if(self.a._id_0D2B == "run" && !_id_0ED7(var_3, 275)) {
    if(randomint(100) < 65) {
      return 0;
    }
  }

  if(animscripts\utility::_id_0BEB(var_0) && self.maxhealth < var_2) {
    return 1;
  }
  if(animscripts\utility::_id_0CEA(var_0) && _id_0ED7(var_3, 512)) {
    return 1;
  }
  if(_id_0ED6(var_0) && _id_0ED7(var_3, 425)) {
    return 1;
  }
  return 0;
}

_id_0ED6(var_0) {
  if(var_0 == "deserteagle") {
    return 1;
  }
  return 0;
}

_id_0ED7(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(distance(self.origin, var_0.origin) > var_1) {
    return 0;
  }
  return 1;
}

_id_0ED8() {
  if(_id_0ED5(self.damageweapon, self.damagemod, self.damagetaken, self.attacker)) {
    var_0 = _id_0ED9();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.a._id_0D29)) {
    if(self.a._id_0D26 == "crouch") {
      return _id_0EE1();
    } else {
      animscripts\notetracks::_id_0D2A();
    }
  }

  if(self.a._id_0D26 == "stand") {
    if(_id_0ED4()) {
      return _id_0EDA();
    } else {
      return _id_0EDD();
    }
  } else if(self.a._id_0D26 == "crouch") {
    return _id_0EDE();
  } else if(self.a._id_0D26 == "prone") {
    return _id_0EDF();
  }
}

_id_0ED9() {
  var_0 = abs(self.damageyaw);

  if(var_0 < 45) {
    return;
  }
  if(var_0 > 150) {
    if(animscripts\utility::_id_0D2F("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_1 = animscripts\utility::_id_0C6D(%death_shotgun_legs, %death_stand_sniper_leg);
    } else {
      var_1 = [];

      if(self.damagelocation == "torso_lower") {
        var_1[var_1.size] = % death_shotgun_legs;
        var_1[var_1.size] = % death_stand_sniper_leg;
      }

      var_1[var_1.size] = % death_shotgun_back_v1;
      var_1[var_1.size] = % exposed_death_blowback;
      var_1[var_1.size] = % death_stand_sniper_chest1;
      var_1[var_1.size] = % death_stand_sniper_chest2;
      var_1[var_1.size] = % death_stand_sniper_spin1;
    }
  } else if(self.damageyaw < 0) {
    var_1 = animscripts\utility::_id_0C6D(%death_shotgun_spinl, %death_stand_sniper_spin1, %death_stand_sniper_chest1, %death_stand_sniper_chest2);
  } else {
    var_1 = animscripts\utility::_id_0C6D(%death_shotgun_spinr, %death_stand_sniper_spin2, %death_stand_sniper_chest1, %death_stand_sniper_chest2);
  }
  return var_1[randomint(var_1.size)];
}

_id_0EDA() {
  var_0 = [];
  var_0[var_0.size] = _id_0EE5(%run_death_facedown);
  var_0[var_0.size] = _id_0EE5(%run_death_roll);
  var_0[var_0.size] = _id_0EE5(%run_death_fallonback);
  var_0[var_0.size] = _id_0EE5(%run_death_flop);
  var_0 = animscripts\pain::_id_0D32(var_0);

  if(!var_0.size) {
    return _id_0EDD();
  }
  return var_0[randomint(var_0.size)];
}

_id_0EDB(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2])) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

_id_0EDC() {
  var_0 = [];

  if(abs(self.damageyaw) < 50) {
    var_0[var_0.size] = % pistol_death_2;
  } else {
    if(abs(self.damageyaw) < 110) {
      var_0[var_0.size] = % pistol_death_2;
    }
    if(animscripts\utility::_id_0D2F("torso_lower", "torso_upper", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      var_0[var_0.size] = % pistol_death_3;

      if(!animscripts\utility::_id_0D2F("torso_upper")) {
        var_0[var_0.size] = % pistol_death_3;
      }
    }

    if(!animscripts\utility::_id_0D2F("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
      var_0[var_0.size] = % pistol_death_4;
    }
    if(var_0.size == 0 || animscripts\utility::_id_0D2F("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
      var_0[var_0.size] = % pistol_death_1;
    }
  }

  return var_0;
}

_id_0EDD() {
  var_0 = [];
  var_1 = [];

  if(animscripts\utility::_id_0C95()) {
    var_0 = _id_0EDC();
  } else {
    if(animscripts\utility::_id_0D2F("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_groin);
      var_0[var_0.size] = _id_0EE5(%stand_death_leg);
      var_1[var_1.size] = _id_0EE5(%stand_death_crotch);
      var_1[var_1.size] = _id_0EE5(%stand_death_guts);
    }

    if(animscripts\utility::_id_0D2F("head", "helmet")) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_headshot);
      var_0[var_0.size] = _id_0EE5(%exposed_death_flop);
    }

    if(animscripts\utility::_id_0D2F("neck")) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_neckgrab);
    }
    if(animscripts\utility::_id_0D2F("torso_upper", "left_arm_upper")) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_twist);
      var_0[var_0.size] = _id_0EE5(%stand_death_shoulder_spin);
      var_0[var_0.size] = _id_0EE5(%stand_death_shoulderback);
    }

    if(animscripts\utility::_id_0D2F("torso_upper")) {
      var_0[var_0.size] = _id_0EE5(%stand_death_tumbleforward);
      var_0[var_0.size] = _id_0EE5(%stand_death_stumbleforward);
      var_1[var_1.size] = _id_0EE5(%stand_death_fallside);
    }

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      if(animscripts\utility::_id_0D2F("neck", "head", "helmet")) {
        var_0[var_0.size] = _id_0EE5(%stand_death_face);
        var_0[var_0.size] = _id_0EE5(%stand_death_headshot_slowfall);
        var_1[var_1.size] = _id_0EE5(%stand_death_head_straight_back);
      }

      if(animscripts\utility::_id_0D2F("torso_upper")) {
        var_0[var_0.size] = _id_0EE5(%stand_death_tumbleback);
        var_1[var_1.size] = _id_0EE5(%stand_death_chest_stunned);
      }
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_falltoknees);
      var_0[var_0.size] = _id_0EE5(%exposed_death_falltoknees_02);
    }

    var_2 = var_0.size > 0;

    if(!var_2 || randomint(100) < 15) {
      var_0[var_0.size] = _id_0EE5(%exposed_death_02);
      var_0[var_0.size] = _id_0EE5(%exposed_death_nerve);
    }

    if(randomint(100) < 10 && _id_0EE2()) {
      var_0[var_0.size] = _id_0EE6(%exposed_death_firing_02);
      var_0[var_0.size] = _id_0EE6(%exposed_death_firing);
      var_0 = _id_0EDB(var_0);
    }
  }

  if(var_0.size == 0) {
    var_0[var_0.size] = % exposed_death;
  }
  if(!self.a._id_0D31 && self.stairsstate == "none" && !isDefined(self.a._id_0D13)) {
    var_3 = randomint(var_0.size + var_1.size);

    if(var_3 < var_0.size) {
      return var_0[var_3];
    } else {
      return var_1[var_3 - var_0.size];
    }
  }

  return var_0[randomint(var_0.size)];
}

_id_0EDE() {
  var_0 = [];

  if(animscripts\utility::_id_0D2F("head", "neck")) {
    var_0[var_0.size] = _id_0EE5(%exposed_crouch_death_fetal);
  }
  if(animscripts\utility::_id_0D2F("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    var_0[var_0.size] = _id_0EE5(%exposed_crouch_death_flip);
  }
  if(var_0.size < 2) {
    var_0[var_0.size] = _id_0EE5(%exposed_crouch_death_twist);
  }
  if(var_0.size < 2) {
    var_0[var_0.size] = _id_0EE5(%exposed_crouch_death_flip);
  }
  return var_0[randomint(var_0.size)];
}

_id_0EDF() {
  if(isDefined(self.a._id_0EE0)) {
    return % prone_death_quickdeath;
  } else {
    return % dying_crawl_death_v1;
  }
}

_id_0EE1() {
  var_0 = animscripts\utility::_id_0C6D(%dying_back_death_v1, %dying_back_death_v2, %dying_back_death_v3, %dying_back_death_v4);
  return var_0[randomint(var_0.size)];
}

_id_0EE2() {
  if(!isDefined(self.weapon) || !animscripts\utility::_id_0EE3() || !weaponisauto(self.weapon) || self.diequietly) {
    return 0;
  }
  if(self.a._id_0EE4["right"] == "none") {
    return 0;
  }
  return 1;
}

_id_0EE5(var_0) {
  return var_0;
}

_id_0EE6(var_0) {
  return var_0;
}

_id_0EE7() {
  if(isDefined(self._id_0A37)) {
    return 0;
  }
  if(self.damagelocation != "none") {
    return 0;
  }
  var_0 = [];

  if(self.a._id_0D2B != "run") {
    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_b_v1);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_b_v2);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_b_v3);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_b_v4);
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_l_v1);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_l_v2);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_l_v3);
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_f_v1);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_f_v2);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_f_v3);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_f_v4);
    } else {
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_r_v1);
      var_0[var_0.size] = _id_0EE5(%death_explosion_stand_r_v2);
    }
  } else if(self.damageyaw > 135 || self.damageyaw <= -135) {
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_b_v1);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_b_v2);
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_l_v1);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_l_v2);
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_f_v1);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_f_v2);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_f_v3);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_f_v4);
  } else {
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_r_v1);
    var_0[var_0.size] = _id_0EE5(%death_explosion_run_r_v2);
  }

  var_1 = var_0[randomint(var_0.size)];

  if(getDvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var_2 = getmovedelta(var_1, 0, 1);
    var_3 = self localtoworldcoords(var_2);

    if(!self maymovetopoint(var_3, 0)) {
      return 0;
    }
  }

  self animmode("nogravity");
  _id_0D56(var_1);
  return 1;
}