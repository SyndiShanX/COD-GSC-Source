/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\notetracks.gsc
**************************************/

_id_23D8(var_0) {
  if(var_0 == "sound_dogstep_run_default") {
    self playSound("dogstep_run_default");
    return 1;
  }

  var_1 = getsubstr(var_0, 0, 5);

  if(var_1 != "sound") {
    return 0;

  }
  var_2 = "anml" + getsubstr(var_0, 5);

  if(isalive(self)) {
    thread maps\_utility::_id_23D9(var_2, "tag_eye");
  } else {
    thread common_scripts\utility::play_sound_in_space(var_2, self getEye());

  }
  return 1;
}

_id_23DA() {
  return isDefined(self._id_23DB);
}

_id_1E73() {
  anim._id_1E72["anim_pose = \"stand\""] = ::_id_23E9;
  anim._id_1E72["anim_pose = \"crouch\""] = ::_id_23EA;
  anim._id_1E72["anim_pose = \"prone\""] = ::_id_23EB;
  anim._id_1E72["anim_pose = \"crawl\""] = ::_id_23EC;
  anim._id_1E72["anim_pose = \"back\""] = ::_id_0D74;
  anim._id_1E72["anim_movement = \"stop\""] = ::_id_23E2;
  anim._id_1E72["anim_movement = \"walk\""] = ::_id_23E3;
  anim._id_1E72["anim_movement = \"run\""] = ::_id_23E4;
  anim._id_1E72["anim_aiming = 1"] = ::_id_23E5;
  anim._id_1E72["anim_aiming = 0"] = ::_id_23E7;
  anim._id_1E72["anim_alertness = causal"] = ::_id_23E6;
  anim._id_1E72["anim_alertness = alert"] = ::_id_23E7;
  anim._id_1E72["anim_alertness = aiming"] = ::_id_23E5;
  anim._id_1E72["gunhand = (gunhand)_left"] = ::_id_23ED;
  anim._id_1E72["anim_gunhand = \"left\""] = ::_id_23ED;
  anim._id_1E72["gunhand = (gunhand)_right"] = ::_id_23ED;
  anim._id_1E72["anim_gunhand = \"right\""] = ::_id_23ED;
  anim._id_1E72["anim_gunhand = \"none\""] = ::_id_23ED;
  anim._id_1E72["gun drop"] = ::_id_23EE;
  anim._id_1E72["dropgun"] = ::_id_23EE;
  anim._id_1E72["gun_2_chest"] = ::_id_23EF;
  anim._id_1E72["gun_2_back"] = ::_id_23F0;
  anim._id_1E72["pistol_pickup"] = ::_id_23F2;
  anim._id_1E72["pistol_putaway"] = ::_id_23F3;
  anim._id_1E72["drop clip"] = ::_id_23F4;
  anim._id_1E72["refill clip"] = ::_id_23F5;
  anim._id_1E72["reload done"] = ::_id_23F5;
  anim._id_1E72["load_shell"] = ::_id_23F6;
  anim._id_1E72["pistol_rechamber"] = ::_id_23F7;
  anim._id_1E72["gravity on"] = ::_id_23F8;
  anim._id_1E72["gravity off"] = ::_id_23F8;
  anim._id_1E72["footstep_right_large"] = ::_id_23F9;
  anim._id_1E72["footstep_right_small"] = ::_id_23F9;
  anim._id_1E72["footstep_left_large"] = ::_id_23F9;
  anim._id_1E72["footstep_left_small"] = ::_id_23F9;
  anim._id_1E72["footscrape"] = ::_id_23FE;
  anim._id_1E72["land"] = ::_id_23FF;
  anim._id_1E72["bodyfall large"] = ::_id_2402;
  anim._id_1E72["bodyfall small"] = ::_id_2402;
  anim._id_1E72["code_move"] = ::_id_2400;
  anim._id_1E72["face_enemy"] = ::_id_2401;
  anim._id_1E72["laser_on"] = ::_id_23DD;
  anim._id_1E72["laser_off"] = ::_id_23DD;
  anim._id_1E72["start_ragdoll"] = ::_id_23E0;
  anim._id_1E72["fire"] = ::_id_23DC;
  anim._id_1E72["fire_spray"] = ::_id_240C;
  anim._id_1E72["bloodpool"] = animscripts\death::_id_0ECA;

  if(isDefined(level._id_1E89)) {
    var_0 = getarraykeys(level._id_1E89);

    foreach(var_2 in var_0) {}
    anim._id_1E72[var_2] = ::_id_23FB;
  }
}

_id_23DC(var_0, var_1) {
  if(isDefined(anim._id_20D6[self.script])) {
    thread[[anim._id_20D6[self.script]]]();
  } else {
    thread[[::_id_20D7]]();
  }
}

_id_23DD(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self.a._id_0CDF = 1;
  } else {
    self.a._id_0CDF = 0;

  }
  animscripts\shared::_id_0CE0();
}

_id_23DE(var_0, var_1) {}

_id_23DF() {
  wait 0.1;

  if(isDefined(self)) {
    self unlink();
  }
}

_id_23E0(var_0, var_1) {
  if(isDefined(self._id_0EC6)) {
    return;
  }
  if(isDefined(self._id_0EC7)) {
    return;
  }
  if(!isDefined(self._id_23E1)) {
    thread _id_23DF();

  }
  self startragdoll();
}

_id_23E2(var_0, var_1) {
  self.a._id_0D2B = "stop";
}

_id_23E3(var_0, var_1) {
  self.a._id_0D2B = "walk";
}

_id_23E4(var_0, var_1) {
  self.a._id_0D2B = "run";
}

_id_23E5(var_0, var_1) {}

_id_23E6(var_0, var_1) {}

_id_23E7(var_0, var_1) {}

_id_0D2A() {
  animscripts\utility::_id_0F7D(1.0);
  self.a._id_0D29 = undefined;
}

_id_23E8(var_0) {
  self.a._id_0D26 = var_0;

  if(isDefined(self.a._id_0D29)) {
    _id_0D2A();

  }
  self notify("entered_pose" + var_0);
}

_id_23E9(var_0, var_1) {
  if(self.a._id_0D26 == "prone") {
    self orientmode("face default");
    animscripts\utility::_id_0F7D(1.0);
  }

  _id_23E8("stand");
}

_id_23EA(var_0, var_1) {
  if(self.a._id_0D26 == "prone") {
    self orientmode("face default");
    animscripts\utility::_id_0F7D(1.0);
  }

  _id_23E8("crouch");
}

#using_animtree("generic_human");

_id_23EB(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(1.0);
  _id_23E8("prone");

  if(isDefined(self.a._id_10E0)) {
    self.a._id_0EE0 = 1;
  } else {
    self.a._id_0EE0 = undefined;
  }
}

_id_23EC(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(1.0);
  _id_23E8("prone");
  self.a._id_0EE0 = undefined;
}

_id_0D74(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  _id_23E8("crouch");
  self.a._id_0D29 = 1;
  self.a._id_0D2B = "stop";
  self setproneanimnodes(-90, 90, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::_id_10E1(1.0);
}

_id_23ED(var_0, var_1) {
  if(issubstr(var_0, "left")) {
    animscripts\shared::_id_0C9B(self.weapon, "left");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "right")) {
    animscripts\shared::_id_0C9B(self.weapon, "right");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "none")) {
    animscripts\shared::_id_0C9B(self.weapon, "none");
  }
}

_id_23EE(var_0, var_1) {
  animscripts\shared::_id_23C8();
  self._id_1005 = self.weapon;
}

_id_23EF(var_0, var_1) {
  animscripts\shared::_id_0C9B(self.weapon, "chest");
}

_id_23F0(var_0, var_1) {
  animscripts\shared::_id_0C9B(self.weapon, "back");
  self.weapon = animscripts\utility::_id_23F1();
  self._id_0CD1 = weaponclipsize(self.weapon);
}

_id_23F2(var_0, var_1) {
  animscripts\shared::_id_0C9B(self.sidearm, "right");
  self._id_0CD1 = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

_id_23F3(var_0, var_1) {
  animscripts\shared::_id_0C9B(self.weapon, "none");
  self.weapon = animscripts\utility::_id_23F1();
  self._id_0CD1 = weaponclipsize(self.weapon);
}

_id_23F4(var_0, var_1) {
  thread animscripts\shared::_id_23D1(var_1);
}

_id_23F5(var_0, var_1) {
  if(weaponclass(self.weapon) == "rocketlauncher") {
    animscripts\combat_utility::_id_2385();

  }
  animscripts\weaponlist::_id_0CD0();
  self.a._id_114D = 0;
}

_id_23F6(var_0, var_1) {
  self playSound("weap_reload_shotgun_loop_npc");
}

_id_23F7(var_0, var_1) {
  self playSound("weap_reload_pistol_chamber_npc");
}

_id_23F8(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self animmode("gravity");
  } else if(issubstr(var_0, "off")) {
    self animmode("nogravity");
  }
}

_id_23F9(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  _id_2409(var_2, var_3);
  var_4 = _id_23FA();
  self playSound("gear_rattle_" + var_4);
}

_id_23FA() {
  var_0 = "run";

  if(isDefined(self._id_0FD7)) {
    var_0 = "sprint";

  }
  if(isDefined(self.a)) {
    if(isDefined(self.a._id_0D2B)) {
      if(self.a._id_0D2B == "walk") {
        var_0 = "walk";
      }
    }

    if(isDefined(self.a._id_0D26)) {
      if(self.a._id_0D26 == "prone") {
        var_0 = "prone";
      }
    }
  }

  return var_0;
}

_id_23FB(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";

  }
  var_3 = undefined;

  if(isDefined(level._id_1E89[var_0][var_2])) {
    var_3 = level._id_1E89[var_0][var_2];
  } else if(isDefined(level._id_1E89[var_0]["all"])) {
    var_3 = level._id_1E89[var_0]["all"];

  }
  if(!isDefined(var_3)) {
    return;
  }
  if(isai(self)) {
    playFXOnTag(var_3.fx, self, var_3.tag);

  }
  if(!isDefined(var_3._id_23FC) && !isDefined(var_3._id_23FD)) {
    return;
  }
  var_4 = "" + var_3._id_23FC + var_2 + var_3._id_23FD;
  self playSound(var_4);
}

_id_23FE(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";

  }
  self playSound("step_scrape_" + var_2);
}

_id_23FF(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";

  }
  self playSound("land_" + var_2);
}

_id_2400(var_0, var_1) {
  return "code_move";
}

_id_2401(var_0, var_1) {
  if(self.script != "reactions") {
    self orientmode("face enemy");
  } else if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 4096) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", self.reactiontargetpos);
  }
}

_id_2402(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large")) {
    var_2 = "_large";

  }
  if(isDefined(self.groundtype)) {
    var_3 = self.groundtype;
  } else {
    var_3 = "dirt";

  }
  self playSound("bodyfall_" + var_3 + var_2);
}

_id_23CA(var_0, var_1, var_2) {
  if(isai(self) && self.type == "dog") {
    if(_id_23D8(var_0)) {
      return;
    }
  }

  var_3 = anim._id_1E72[var_0];

  if(isDefined(var_3)) {
    return [[var_3]](var_0, var_1);

  }
  switch (var_0) {
    case "undefined":
    case "finish":
    case "end":
      return var_0;
    case "finish early":
      if(isDefined(self.enemy)) {
        return var_0;

      }
      break;
    case "swish small":
      thread common_scripts\utility::play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      thread common_scripts\utility::play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "rechamber":
      if(animscripts\utility::_id_0C97()) {
        self playSound("weap_reload_shotgun_pump_npc");

      }
      self.a._id_114D = 0;
      break;
    case "no death":
      self.a._id_0D55 = 1;
      break;
    case "no pain":
      self.allowpain = 0;
      break;
    case "allow pain":
      self.allowpain = 1;
      break;
    case "anim_melee = \"right\"":
    case "anim_melee = right":
      self.a._id_110C = "right";
      break;
    case "anim_melee = \"left\"":
    case "anim_melee = left":
      self.a._id_110C = "left";
      break;
    case "swap taghelmet to tagleft":
      if(isDefined(self.hatmodel)) {
        if(isDefined(self._id_2403)) {
          self detach(self._id_2403, "TAG_HELMETSIDE");
          self._id_2403 = undefined;
        }

        self detach(self.hatmodel, "");
        self attach(self.hatmodel, "TAG_WEAPON_LEFT");
        self.hatmodel = undefined;
      }

      break;
    case "stop anim":
      maps\_utility::_id_1414();
      return var_0;
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    default:
      if(isDefined(var_2)) {
        return [[var_2]](var_0);

      }
      break;
  }
}

_id_0D4C(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = "undefined";

    }
    var_4 = [[var_1]](var_3);

    if(isDefined(var_4) && var_4) {
      continue;
    }
    var_5 = _id_23CA(var_3, var_0);

    if(isDefined(var_5)) {
      return var_5;
    }
  }
}

_id_1156(var_0, var_1) {
  for(;;) {
    self waittill(var_0, var_2);

    if(!isDefined(var_2)) {
      var_2 = "undefined";

    }
    var_3 = _id_23CA(var_2, var_0);
    [[var_1]](var_2);

    if(isDefined(var_3)) {
      return var_3;
    }
  }
}

_id_2404(var_0, var_1, var_2, var_3) {
  animscripts\shared::_id_0C51(var_0, var_2, var_3);
}

_id_239E(var_0, var_1, var_2, var_3) {
  _id_2406(animscripts\shared::_id_0C51, var_0, var_1, var_2, var_3);
}

_id_2405(var_0, var_1, var_2, var_3) {
  _id_2406(::_id_0D4C, var_0, var_1, var_2, var_3);
}

_id_2406(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self endon(var_2);

  }
  self endon("killanimscript");

  if(!isDefined(var_4)) {
    var_4 = "undefined";

  }
  for(;;) {
    var_5 = gettime();
    var_6 = [[var_0]](var_1, var_3, var_4);
    var_7 = gettime() - var_5;

    if(var_7 < 0.05) {
      var_5 = gettime();
      var_6 = [[var_0]](var_1, var_3, var_4);
      var_7 = gettime() - var_5;

      if(var_7 < 0.05) {
        wait(0.05 - var_7);
      }
    }
  }
}

_id_106C(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_2408(var_1);
  _id_2407(::_id_2404, var_0, var_2, var_3, var_4);
}

_id_0D4F(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_2408(var_0);
  _id_2407(::_id_239E, var_1, var_2, var_3, var_4);
}

_id_1001(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread _id_2408(var_0);
  _id_2407(::_id_2405, var_1, var_2, var_3, var_4);
}

_id_2407(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon("stop_notetracks");
  [[var_0]](var_1, undefined, var_2, var_3);
}

_id_2408(var_0) {
  wait(var_0);
  self notify("stop_notetracks");
}

_id_2409(var_0, var_1) {
  if(!isai(self)) {
    self playSound("step_run_dirt");
  } else {
    var_2 = undefined;

    if(!isDefined(self.groundtype)) {
      if(!isDefined(self._id_240A)) {
        self playSound("step_run_dirt");
        return;
      }

      var_2 = self._id_240A;
    } else {
      var_2 = self.groundtype;
      self._id_240A = self.groundtype;
    }

    var_3 = "J_Ball_RI";

    if(var_0) {
      var_3 = "J_Ball_LE";

    }
    var_4 = _id_23FA();
    self playSound("step_" + var_4 + "_" + var_2);

    if(var_1) {
      if(![[anim._id_20CD]](var_3, var_2)) {
        _id_20CE(var_3, var_2);
        return;
      }

      return;
    }

    if(![[anim._id_20CF]](var_3, var_2)) {
      _id_20D0(var_3, var_2);
    }
  }
}

_id_20D0(var_0, var_1) {
  for(var_2 = 0; var_2 < anim._id_20D1.size; var_2++) {
    if(var_1 != anim._id_20D1[var_2]) {
      continue;
    }
    var_3 = self gettagorigin(var_0);
    var_4 = self.angles;
    var_5 = anglesToForward(var_4);
    var_6 = var_5 * -1;
    var_7 = anglestoup(var_4);
    playFX(level._effect["step_" + anim._id_20D1[var_2]], var_3, var_7, var_6);
    return 1;
  }

  return 0;
}

_id_20CE(var_0, var_1) {
  for(var_2 = 0; var_2 < anim._id_20D2.size; var_2++) {
    if(var_1 != anim._id_20D2[var_2]) {
      continue;
    }
    var_3 = self gettagorigin(var_0);
    var_4 = self.angles;
    var_5 = anglesToForward(var_4);
    var_6 = var_5 * -1;
    var_7 = anglestoup(var_4);
    playFX(level._effect["step_small_" + anim._id_20D2[var_2]], var_3, var_7, var_6);
    return 1;
  }

  return 0;
}

_id_20D7() {
  waittillframeend;

  if(isDefined(self) && gettime() > self.a._id_0AA7) {
    animscripts\utility::_id_0D5F();
    animscripts\combat_utility::_id_2386();

    if(weaponclass(self.weapon) == "rocketlauncher") {
      self.a.rockets--;
    }
  }
}

_id_20D5() {
  if(self.a._id_0EE4["right"] == "none") {
    return;
  }
  if(isDefined(self._id_240B)) {
    _id_20D7();
    return;
  }

  var_0 = self gettagorigin("tag_weapon");
  var_1 = anglesToForward(self getmuzzleangle());
  var_2 = var_0 + var_1 * 1000;
  self shoot(1, var_2);
  animscripts\combat_utility::_id_2386();
}

_id_240C(var_0, var_1) {
  if(!isalive(self) && self isbadguy()) {
    if(isDefined(self._id_240D)) {
      return;
    }
    self._id_240D = 1;
    var_2["axis"] = "team3";
    var_2["team3"] = "axis";
    self.team = var_2[self.team];
  }

  if(!issentient(self)) {
    self notify("fire");
    return;
  }

  if(self.a._id_0EE4["right"] == "none") {
    return;
  }
  var_3 = self getmuzzlepos();
  var_4 = anglesToForward(self getmuzzleangle());
  var_5 = 10;

  if(isDefined(self._id_0F8F)) {
    var_5 = 20;

  }
  var_6 = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    var_7 = vectornormalize(self.enemy getEye() - var_3);

    if(vectordot(var_4, var_7) > cos(var_5)) {
      var_6 = 1;
    }
  }

  if(var_6) {
    animscripts\utility::_id_0D5F();
  } else {
    var_4 = var_4 + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var_8 = var_3 + var_4 * 1000;
    animscripts\utility::_id_2384(var_8);
  }

  animscripts\combat_utility::_id_2386();
}