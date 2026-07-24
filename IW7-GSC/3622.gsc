/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3622.gsc
**************************************/

_id_972B() {
  setdvarifuninitialized("debug_seeker", 0);
  level._id_F10A = spawnStruct();
  level._id_F10A.targets = [];
  level._id_F10A._id_1633 = [];
  level._id_F10A._id_162D = [];
  level._id_F10A._id_A8C6 = undefined;
  level.player._id_F179 = spawnStruct();
  level.player._id_F179._id_45BF = 0;
  level.player._id_F179._id_9076 = 0;
  level._id_F10A._id_4D19 = 128;
  level._id_F10A._id_4D0C = 200;
  level._id_F10A._id_4D02 = 550;
  level._id_F10A._id_B41A = 4;
  scripts\engine\utility::flag_init("seeker_force_delete");
  scripts\sp\utility::_id_9189("default_seeker", 3, "default");
}

_id_F135(var_0) {
  if(level._id_F10A._id_1633.size >= level._id_F10A._id_B41A) {
    _id_A5FB();
  }

  var_1 = undefined;

  if(self == level.player && isDefined(level.player._id_AF29)) {
    var_1 = level.player._id_AF29;
    level.player._id_AF29 = undefined;
  }

  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2 linkTo(var_0);
  var_2.grenade = var_0;
  level._id_F10A._id_162D[level._id_F10A._id_162D.size] = var_2;
  var_0 thread _id_F136();
  var_3 = var_2.grenade scripts\engine\utility::waittill_any_return("missile_stuck", "death", "entitydeleted");

  if(!isDefined(var_2.grenade)) {
    var_2 thread _id_E085();
    return;
  }

  if(var_3 == "missile_stuck") {
    _id_107D1(var_2, undefined, undefined, var_1);
  }

  if(level.player._id_F179._id_45BF) {
    level thread _id_B9CD();
  }

  var_2 thread _id_E085();
}

_id_F136() {
  self endon("death");
  wait 5;
  self delete();
}

_id_E085() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.grenade)) {
    level._id_F10A._id_A8C6 = self.grenade.origin;
    self.grenade unlink();
    self.grenade delete();
  }

  if(scripts\engine\utility::flag("seeker_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self)) {
    level._id_F10A._id_162D = scripts\engine\utility::array_remove(level._id_F10A._id_162D, self);
    self delete();
  }
}

_id_A5FB() {
  var_0 = undefined;
  var_1 = 0;

  foreach(var_3 in level._id_F10A._id_1633) {
    if(var_1 == 0 || var_3.starttime < var_1) {
      var_1 = var_3.starttime;
      var_0 = var_3;
    }
  }

  if(isDefined(var_0)) {
    var_0._id_EA0E = 1;

    if(isDefined(var_0._id_F166)) {
      stopFXOnTag(level._id_7649[var_0._id_F166], var_0, "tag_fx");
    }

    if(isDefined(var_0._id_B14F)) {
      var_0 scripts\sp\utility::_id_1101B();
    }

    playFXOnTag(level._id_7649["seeker_sparks"], var_0, "tag_fx");
    playworldsound("seeker_expire", var_0.origin);
    var_0 hudoutlinedisable();
    var_0 _meth_81D0();
  }
}

_id_DFC1() {
  level notify("removing_all_seekers_instantly");
  level endon("removing_all_seekers_instantly");
  scripts\engine\utility::flag_set("seeker_force_delete");

  foreach(var_1 in level._id_F10A._id_162D) {
    var_1 thread _id_E085();
  }

  foreach(var_4 in level._id_F10A._id_1633) {
    var_4 thread _id_E084();
  }

  for(;;) {
    if(level._id_F10A._id_162D.size > 0 || level._id_F10A._id_1633.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("seeker_force_delete");
}

_id_107D1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_4 = getclosestpointonnavmesh(var_0.origin, undefined, 1);
  var_5 = distancesquared(var_4, var_0.origin);

  if(var_5 > squared(250)) {
    return;
  }
  var_6 = getspawner("actor_ally_equipment_seeker", "classname");
  var_6.origin = var_0.origin;

  if(isDefined(var_2)) {
    var_6.origin = var_6.origin + var_2;
  }

  var_6.angles = self.angles;
  var_6.count = var_6.count + 1;
  var_7 = var_6 _id_F15A();

  if(!isDefined(var_7)) {
    return;
  }
  var_7.owner = self;

  if(isDefined(var_1) && var_1 == 1) {
    var_7._id_C93D = 1;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_expire") {
    self._id_595E = 1;
  }

  if(!isDefined(var_7._id_C93D)) {
    var_7.team = var_7.owner.team;
  }

  self._id_F10A = var_7;

  if(isDefined(var_3)) {
    var_7.favoriteenemy = var_3;
  }

  var_7 thread _id_F159();

  if(isDefined(level._id_F10A._id_4C74)) {
    var_7 thread[[level._id_F10A._id_4C74]]();
  }

  level._id_F10A._id_1633[level._id_F10A._id_1633.size] = var_7;
  return var_7;
}

_id_107D2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getspawner("actor_ally_equipment_seeker", "classname");
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.count = var_5.count + 1;
  var_6 = var_5 _id_F15A();

  if(!isDefined(var_6)) {
    return;
  }
  var_6.owner = var_6;
  var_6.team = var_2;

  if(isDefined(var_3)) {
    var_6._id_728A = var_3;
  }

  if(isDefined(var_4)) {
    var_6._id_5967 = var_4;
  }

  var_6 thread _id_F159();
  level._id_F10A._id_1633[level._id_F10A._id_1633.size] = var_6;
  return var_6;
}

_id_F12A() {
  self endon("death");
  var_0 = 0;
  var_1 = 5;

  for(;;) {
    if(!self islinked()) {
      var_2 = self _meth_812B();

      if(var_2 == "none") {
        var_0++;

        if(var_0 > 4 * var_1) {
          self delete();
        }
      } else
        var_0 = 0;
    } else
      var_0 = 0;

    wait 0.25;
  }
}

_id_F15A() {
  level endon("seeker_force_delete");

  if(scripts\engine\utility::flag("seeker_force_delete")) {
    return undefined;
  }

  var_0 = 0;

  while(isDefined(self._id_9C20)) {
    wait 0.05;
    var_0++;

    if(var_0 > 5) {
      return undefined;
    }
  }

  var_1 = undefined;
  self._id_9C20 = 1;
  self.count = self.count + 1;

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 = self _meth_8393();

    if(!isDefined(var_1)) {
      wait 0.05;
      continue;
    }

    break;
  }

  self._id_9C20 = undefined;
  return var_1;
}

_id_10679(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  wait(var_0);

  if(self.team == "allies" || self.team == "neutral") {
    var_3 = "axis";
  } else {
    var_3 = "allies";
  }

  return _id_107D2(var_1, var_2, var_3, self);
}

_id_F162() {
  self endon("death");
  self endon("seeker_unequipped");

  if(!level.player._id_F179._id_9076) {
    return;
  }
  thread _id_F165();

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0 != "seeker") {
      continue;
    }
    self._id_AF29 = undefined;
    childthread _id_F161();
    self waittill("offhand_end");
    scripts\engine\utility::waitframe();
  }
}

_id_F165() {
  self endon("death");
  self endon("stop_seeker_unequipped_think");
  self notify("seeker_unequipped_think");
  self endon("seeker_unequipped_think");
  self waittill("primary_equipment_change");

  if(!scripts\sp\utility::_id_93A6()) {
    self enableoffhandsecondaryweapons();
  }

  self notify("seeker_unequipped");
}

_id_F160() {
  scripts\engine\utility::waittill_either("offhand_end", "offhand_ammo");
  wait 0.05;

  if(isDefined(self._id_AF29)) {
    self._id_AF29 scripts\sp\utility::_id_9193("default_seeker");
    self._id_AF29 = undefined;
  }
}

_id_F161() {
  self endon("offhand_end");
  self endon("offhand_ammo");
  thread _id_F160();
  wait 1.5;

  for(;;) {
    var_0 = _id_F07D();

    if(isDefined(var_0)) {
      if(isDefined(self._id_AF29) && var_0 != self._id_AF29) {
        self._id_AF29 scripts\sp\utility::_id_9193("default_seeker");
      }

      var_0 scripts\sp\utility::_id_9196(1, 0, 0, "default_seeker");
      self._id_AF29 = var_0;
      wait 0.5;
    } else if(isDefined(self._id_AF29))
      self._id_AF29 scripts\sp\utility::_id_9193("default_seeker");

    scripts\engine\utility::waitframe();
  }
}

_id_10793() {
  var_0 = _id_F15A();
  var_0._id_C93D = 1;
  var_0 thread _id_F159();
}

_id_F159() {
  if(isDefined(self._id_C93D)) {
    self.team = "team3";

    if(isDefined(self.target)) {
      thread _id_0B77::_id_8409();
    }
  }

  self._id_F166 = "seeker_" + self.team;
  playFXOnTag(level._id_7649[self._id_F166], self, "tag_fx");
  self.combatmode = "no_cover";
  self.name = "";
  self.grenadeawareness = 0;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self._id_10264 = 1;
  self._id_28CF = 0;
  self._id_B5DD = 1;
  self.ignoresuppression = 1;
  self._id_5963 = 1;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 0;
  self.newenemyreactiondistsq = 0;
  self.fixednode = 0;
  self.disablebulletwhizbyreaction = 1;
  self._id_55EF = 1;
  self.dodangerreact = 0;
  self._id_C012 = 1;
  self._id_2745 = [];
  self._id_2A4B = 1;
  self._id_733D = 0;
  self _meth_84E5(0.0);

  if(isDefined(self._id_C93D)) {
    self.ignoreme = 1;
  }

  if(self.owner == level.player) {
    self.health = 3000;
    thread scripts\sp\utility::_id_B14F(1);
  } else
    self.health = 50;

  if(level._id_7683 == 0 && self.owner != level.player) {
    thread _id_F169();
  }

  _id_F13A();
  thread scripts\sp\utility::play_sound_on_entity("seeker_init");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_seek_lp");
  thread _id_BC0A();
  thread _id_F137();
  thread _id_F114();
  thread _id_F12A();
  thread _id_F115();
  thread _id_6C95();

  if(self.owner == level.player) {
    thread _id_F14C();
  }
}

_id_F115() {
  scripts\engine\utility::waittill_either("death", "entitydeleted");

  if(isDefined(self._id_A481)) {
    self._id_A481 delete();
  }
}

_id_F13A() {
  if(self.owner == level.player) {
    self.moveplaybackrate = 1.0;
  } else {
    if(level._id_7683 <= 1) {
      self.moveplaybackrate = 0.65;
      return;
    }

    self.moveplaybackrate = 0.75;
  }
}

_id_F114() {
  self endon("death");

  for(;;) {
    glassradiusdamage(self.origin, 25, 1000, 1000);
    scripts\engine\utility::waitframe();
  }
}

_id_8BA7() {
  if(level.player hasweapon("seeker")) {
    return "current";
  }

  var_0 = scripts\sp\utility::_id_7CAF();

  if(!isDefined(var_0)) {
    return "no";
  }

  if(var_0 == "seeker") {
    return "stored";
  } else {
    return "no";
  }
}

_id_F16B() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waitframe();
    var_0 = _id_8BA7();

    if(var_0 == "no") {
      self notify("no_inventory");
      continue;
    }

    var_1 = 0;

    if(var_0 == "current") {
      var_1 = scripts\sp\utility::_id_7BD7();
    } else if(var_0 == "stored") {
      var_1 = scripts\sp\utility::_id_7CB0();
    }

    if(var_1 == 4) {
      self notify("max_ammo");
      continue;
    }
  }
}

_id_F14C() {
  self endon("death");

  if(isDefined(self._id_C93D)) {
    return;
  }
  var_0 = 0;
  childthread _id_F16B();

  for(;;) {
    scripts\engine\utility::waitframe();

    if(isDefined(self.bt._id_F15D) && self.bt._id_F15D != self.owner) {
      continue;
    }
    var_1 = _id_8BA7();

    if(var_1 == "no") {
      continue;
    }
    var_2 = 0;

    if(var_1 == "current") {
      var_2 = scripts\sp\utility::_id_7BD7();
    } else if(var_1 == "stored") {
      var_2 = scripts\sp\utility::_id_7CB0();
    }

    if(var_2 == 4) {
      continue;
    }
    thread _id_0E46::_id_48C4("tag_origin", (0, 0, 25), &"EQUIPMENT_SEEKER_RETRIEVE", undefined, 60, 50, undefined, undefined, undefined, &"hud_interaction_prompt_center_equipment", undefined, undefined, undefined, undefined, 90);
    var_0 = 1;
    var_3 = scripts\engine\utility::waittill_any_return("trigger", "max_ammo", "no_inventory", "set_bt_target");

    if(var_3 == "trigger") {
      break;
    } else {
      if(var_0) {
        _id_0E46::_id_DFE3();
      }

      continue;
    }
  }

  playworldsound("player_refill_all_ammo", level.player.origin);
  var_1 = _id_8BA7();
  var_2 = 0;

  if(var_1 == "current") {
    var_2 = scripts\sp\utility::_id_7BD7();
    level.player setweaponammoclip("seeker", var_2 + 1);
  } else if(var_1 == "stored") {
    var_2 = scripts\sp\utility::_id_7CB0();
    level.player._id_110BE++;
  }

  _id_E084();
}

_id_E084() {
  self._id_EA0E = 1;

  if(isDefined(self._id_F166)) {
    stopFXOnTag(level._id_7649[self._id_F166], self, "tag_fx");
    self._id_F166 = undefined;
  }

  if(isDefined(self.melee)) {
    self _meth_8484();

    if(isDefined(self.melee)) {
      if(isDefined(self.melee.target)) {
        self.melee.target.melee = undefined;
      }

      self.melee = undefined;
    }
  }

  self notify("stop soundseeker_target_acquire_lp");
  self notify("stop soundseeker_move_lp");
  self notify("stop soundseeker_move_servo_lp");
  level._id_F10A._id_1633 = scripts\engine\utility::array_remove(level._id_F10A._id_1633, self);

  if(isPlayer(self.owner)) {
    var_0 = level.player _id_7B02();

    if(!var_0.size) {
      level._id_F10A._id_5AE6 = undefined;
      level.player notify("stop_monitoring_doubletap");
    }
  }

  self delete();
}

_id_F169() {
  level.player endon("death");

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    if(isDefined(self.bt) && isDefined(self.bt._id_F15D)) {
      if(self.bt._id_F15D == level.player) {
        if(distance2dsquared(self.origin, level.player getorigin()) < squared(800)) {
          self._id_138F2 = newhudelem();
          var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 30));
          var_0 linkTo(self);
          self._id_138F2 setshader("hud_icon_grenade_incoming_seeker", 32, 32);
          self._id_138F2.color = (1, 1, 1);
          self._id_138F2.alpha = 1.0;
          self._id_138F2 setwaypoint(1, 1, 0);
          self._id_138F2 settargetEnt(var_0);
          scripts\engine\utility::waittill_either("jumped_on_player", "death");
          self._id_138F2 destroy();
          var_0 delete();
          return;
        }
      }
    }

    wait 0.05;
  }
}

_id_F137() {
  if(isDefined(self._id_C93D) || isDefined(self._id_5967) && self._id_5967) {
    return;
  }
  if(self.team == "allies") {
    scripts\sp\utility::_id_9196(3, 0, 0, "default_seeker");
  } else if(self.team == "axis") {
    scripts\sp\utility::_id_9196(1, 1, 1, "default_seeker");
  }
}

_id_BC0A() {
  self endon("death");

  for(;;) {
    _id_BC73();

    while(self._id_164D["seeker"]._id_4BC0 != "run_loop") {
      wait 0.05;
    }

    _id_BC72();

    while(self._id_164D["seeker"]._id_4BC0 == "run_loop") {
      wait 0.05;
    }
  }
}

_id_BC72() {
  self playSound("seeker_move_start", "sound_done");
  self waittill("sound_done");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_move_lp");
  thread scripts\engine\utility::play_loop_sound_on_entity("seeker_move_servo_lp");
}

_id_BC73() {
  self notify("stop soundseeker_move_lp");
  self notify("stop soundseeker_move_servo_lp");
  self playSound("seeker_move_end", "sound_done");
  self waittill("sound_done");
}

_id_B9CD() {
  if(isDefined(self._id_C93D)) {
    return;
  }
  if(isDefined(level._id_F10A._id_5AE6)) {
    return;
  }
  level._id_F10A._id_5AE6 = 1;
  level.player endon("stop_monitoring_doubletap");
  var_0 = 0;
  var_1 = 0.3;

  for(;;) {
    if(level.player useButtonPressed()) {
      var_0 = 0;

      while(level.player useButtonPressed()) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= var_1) {
        continue;
      }
      var_0 = 0;

      while(!level.player useButtonPressed() && var_0 < var_1) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= var_1) {
        continue;
      }
      _id_2BCF(level.player);
      level._id_F10A._id_5AE6 = undefined;
      level.player notify("stop_monitoring_doubletap");
      return;
    }

    wait 0.05;
  }
}

_id_2BCF(var_0) {
  foreach(var_2 in level._id_F10A._id_1633) {
    if(var_2.owner == var_0) {
      if(isDefined(var_2._id_9BB9)) {
        continue;
      }
      var_2._id_9BB9 = 1;
      var_2 thread _id_F11E(1);
    }
  }
}

_id_7B02() {
  var_0 = [];

  foreach(var_2 in level._id_F10A._id_1633) {
    if(var_2.owner == self) {
      if(isDefined(var_2._id_9BB9)) {
        continue;
      }
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_F11C() {
  self endon("seeker_detonate_finish");
  self._id_50EB = 1;
  wait 0.4;

  if(!isDefined(self) || isDefined(self._id_9BB9)) {
    return;
  }
  playworldsound("seeker_expl_beep", self.origin);
  wait 0.6;

  if(!isDefined(self) || isDefined(self._id_9BB9)) {
    return;
  }
  self._id_9BB9 = 1;
  thread _id_F11E();
}

_id_F11E(var_0, var_1, var_2) {
  if(isDefined(self)) {
    destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");

    if(isDefined(self._id_F166)) {
      stopFXOnTag(level._id_7649[self._id_F166], self, "tag_fx");
      self._id_F166 = undefined;
    }

    if(isDefined(self._id_EA0E)) {
      return;
    }
    if(!isDefined(var_0)) {
      thread _id_F11D();
    }

    var_3 = self gettagorigin("j_body") + (0, 0, 2);

    if(isDefined(var_1)) {
      var_3 = var_1;
    }

    if(isDefined(self.owner) && level.player == self.owner) {
      var_4 = self.owner _id_0B1D::_id_734E();
      self.owner scripts\engine\utility::delaythread(0.1, _id_0B1D::_id_734D, var_3, var_4, level._id_F10A._id_4D19);
    }

    self notify("seeker_detonate_finish", var_3);
    self notify("stop soundseeker_target_acquire_lp");

    if(self.health > 0 || isDefined(var_2)) {
      if(isalive(self) && isDefined(self)) {
        self.grenadeweapon = "seeker_expl";
        self _meth_81EE(var_3, (0, 0, 0), 0);
      } else
        magicgrenademanual("seeker_expl", var_3, (0, 0, 0), 0);

      if(isalive(self)) {
        self hide();
      }

      wait 0.1;
      physicsexplosionsphere(var_3, 1000, 100, 2);
      thread _id_0B1D::_id_DBDB(var_3 + (0, 0, 5), 0.2);
      earthquake(0.5, 0.8, var_3, 250);
      thread scripts\sp\utility::_id_54EF(var_3);
      thread _id_F110(250, var_3);
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(self._id_B14F)) {
        scripts\sp\utility::_id_1101B();
      }

      if(isalive(self)) {
        self _meth_81D0();
      }

      self delete();
    }

    wait 0.75;
  }
}

_id_F129(var_0) {
  var_1 = getaiarray("axis", "allies");
  var_1[var_1.size] = level.player;
  var_2 = [];

  foreach(var_4 in var_1) {
    if(distance(var_0, var_4.origin) <= level._id_F10A._id_4D19) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_2) {
    if(isPlayer(var_4) && _id_0B1D::_id_385D(var_0)) {
      _id_57BB(var_0, var_4);
    }

    if(_id_0B1D::_id_385C(var_0, var_4)) {
      _id_57BB(var_0, var_4);
    }
  }
}

_id_57BB(var_0, var_1) {
  var_2 = distance2d(var_1.origin, var_0);
  var_3 = scripts\sp\math::_id_C097(0, level._id_F10A._id_4D19, var_2);
  var_4 = scripts\sp\math::_id_6A8E(level._id_F10A._id_4D0C, level._id_F10A._id_4D02, var_3);

  if(isDefined(var_1.unittype)) {
    var_5 = tolower(var_1.unittype);

    if(var_5 == "c6") {
      var_4 = var_4 * 3.0;
    } else if(var_5 == "c8") {
      var_4 = var_4 * 3.0;
    } else if(var_5 == "c12") {
      var_4 = var_4 * 3.0;
    }
  }

  var_1 dodamage(var_4, self.origin, self, self, "MOD_EXPLOSIVE", "seeker");
}

_id_F11D() {
  scripts\engine\utility::play_sound_in_space("seeker_expl_beep", self.origin);
}

_id_F110(var_0, var_1) {
  if(level.player scripts\sp\utility::_id_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player _meth_8448()) {
    return;
  }
  var_2 = distance2dsquared(level.player.origin, var_1);

  if(var_2 > squared(var_0)) {
    return;
  }
  if(var_2 > squared(var_0 * 0.25)) {
    var_3 = vectordot(scripts\engine\utility::flatten_vector(vectorNormalize(var_1 - level.player.origin)), anglesToForward(level.player.angles));

    if(var_3 < 0.0) {
      return;
    }
  }

  if(!scripts\common\trace::ray_trace_passed(var_1 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
    return;
  }
  level.player thread _id_F155(var_1);
}

_id_F155(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = "ges_frag_block";
  var_3 = self playgestureviewmodel(var_2, var_1, 1, 0.1);

  if(var_3) {
    childthread _id_0E49::_id_D092(var_2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);

    for(;;) {
      self waittill("gesture_stopped", var_2);

      if(var_2 == "ges_frag_block") {
        break;
      }
    }
  }

  var_1 delete();
}

_id_F14D(var_0) {
  if(var_0) {
    if(isDefined(self.owner) && !isPlayer(self.owner)) {
      return;
    }
    if(isDefined(self._id_C93D)) {
      return;
    }
    if(isDefined(self._id_9BB9)) {
      return;
    }
    if(isDefined(level._id_F14D)) {
      return;
    }
    level._id_F14D = 1;
    self._id_CBA0 = scripts\engine\utility::spawn_tag_origin();
    thread scripts\engine\utility::delete_on_death(self._id_CBA0);
    thread _id_CBA1();
    thread _id_F14E();
    var_1 = (0, 0, 0);
    var_2 = (0, 0, 0);
    scripts\sp\pip_util::_id_CBB5(self._id_CBA0, "tag_origin", 40, var_1, var_2);
  } else {
    scripts\sp\pip_util::_id_CBA3();
    level._id_F14D = undefined;
  }
}

_id_F14E() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_9BB9)) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_blownup");
      setomnvar("ui_pip_message_type", 3);
    } else if(self.bt._id_1152B) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_locked");
      setomnvar("ui_pip_message_type", 3);
    } else if(isDefined(self.bt._id_F15D) && self.bt._id_F15D == self.owner) {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_idle");
      setomnvar("ui_pip_message_type", 1);
    } else {
      setomnvar("ui_pip_message_text_top", "equipment_seeker_top");
      setomnvar("ui_pip_message_text_bottom", "equipment_seeker_searching");
      setomnvar("ui_pip_message_type", 2);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_CBA1() {
  scripts\engine\utility::waitframe();
  var_0 = spawnturret("misc_turret", self.origin, "seeker_camera");
  var_0 setModel("tag_turret");
  var_0 setdefaultdroppitch(0);
  var_0 setmode("manual");
  var_0 makeunusable();
  var_0._id_9FF0 = 1;
  var_0 _meth_82C9(0, "yaw");
  var_0 _meth_82C9(0, "pitch");
  var_1 = (2, 0, 7);

  if(isDefined(self._id_37B3)) {
    var_1 = var_1 + self._id_37B3;
  }

  var_0 linkTo(self, "j_spine4", var_1, (0, 0, 0));
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_0 settargetentity(var_3);
  self._id_CBA0 linkTo(var_0, "tag_flash", (0, 0, 0), (0, 0, 0));

  while(isalive(self)) {
    if(isDefined(self._id_7260)) {
      var_3 linkTo(self._id_7260, "tag_origin", (0, 0, 0), (0, 0, 0));
    } else if(isDefined(self.melee) && isDefined(self.melee._id_312F) && self.melee._id_312F && isalive(self.melee.target)) {
      if(isDefined(self._id_2479)) {
        var_3 linkTo(self.melee.target, "tag_eye", (0, 0, 0), (0, 0, 0));
      } else {
        var_3 linkTo(self.melee.target, "j_neck", (0, 0, 0), (0, 0, 0));
      }
    } else if(isalive(self.bt._id_F15D) && (self cansee(self.bt._id_F15D) || self.bt._id_1152B))
      var_3 linkTo(self.bt._id_F15D, "tag_eye", (0, 0, 0), (0, 0, 0));
    else {
      var_3 linkTo(self, "tag_eye", (50, 0, 2), (0, 0, 0));
    }

    wait 0.05;
  }

  var_2 delete();
  var_3 delete();
  var_0 delete();
}

_id_CBA2(var_0, var_1) {
  var_2 = scripts\sp\math::_id_10AAE(10, var_0.origin, (0, 0, 0));

  while(isalive(self) && isDefined(var_1)) {
    var_3 = scripts\sp\math::_id_10AB4(var_2, var_1.origin, var_0.origin);
    var_0.origin = var_3;
    scripts\engine\utility::waitframe();
  }

  scripts\sp\math::_id_10AAA(var_2);
}

_id_F11B(var_0) {}

_id_6C95() {
  self endon("death");
  self._id_733D = 0;

  for(;;) {
    var_0 = getclosestpointonnavmesh(self.origin, self);
    var_1 = distancesquared(var_0, self.origin);

    if(var_1 <= squared(15)) {
      self._id_733D = 1;
      return;
    }

    wait 0.05;
  }
}

_id_7C41(var_0) {
  if(!isDefined(self._id_728A) && !self._id_733D) {
    return undefined;
  }

  var_1 = gettime();

  if(self.bt._id_1152B || self.bt._id_1154B > 0 && self.bt._id_1154B + 700 > var_1) {
    return self.bt._id_F15D;
  }

  if(isDefined(self._id_EA0E) || isDefined(self._id_C93D) || isDefined(self._id_50EB) || isDefined(self._id_9BB9) || !isDefined(self.bt._id_652A)) {
    return undefined;
  }

  if(!isDefined(self.bt._id_9882)) {
    return undefined;
  }

  if(scripts\engine\utility::flag_exist("stealth_enabled") && scripts\engine\utility::flag("stealth_enabled")) {
    if(isalive(self.owner) && self.owner scripts\sp\utility::_id_65DF("stealth_attack") && !self.owner scripts\sp\utility::_id_65DB("stealth_attack")) {
      return undefined;
    }
  }

  if(isDefined(self.favoriteenemy)) {
    return self.favoriteenemy;
  }

  if(isDefined(self._id_728A)) {
    return self._id_728A;
  }

  var_2 = getaiunittypearray(self.bt._id_652A, "all");

  if(self.bt._id_652A == "allies") {
    if(_id_0F3D::_id_B575(self.unittype)) {
      var_2 = scripts\engine\utility::array_add(var_2, level.player);
    }
  }

  var_3 = 1200;
  var_4 = 100;
  var_5 = [];

  foreach(var_7 in var_2) {
    if(var_7.ignoreme || !isalive(var_7) || isDefined(var_7._id_C012)) {
      continue;
    }
    if(isDefined(var_7._id_2023)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self._id_2745, var_7)) {
      continue;
    }
    if(isalive(self.owner)) {
      var_8 = distancesquared(self.owner.origin, var_7.origin);

      if(var_8 < squared(var_4) || var_8 > squared(var_3)) {
        continue;
      }
    }

    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  if(!var_5.size) {
    if(isalive(self.owner)) {
      return self.owner;
    } else {
      return undefined;
    }
  }

  if(var_5.size == 1) {
    if(isDefined(var_5[0]) && isalive(var_5[0])) {
      return var_5[0];
    }
  }

  var_10 = undefined;

  if(self.owner == level.player) {
    var_10 = level.player _id_797E();
  }

  var_11 = cos(45);
  var_12 = 400;
  var_13 = 0;
  var_14 = undefined;
  var_15 = 1;

  foreach(var_17 in var_5) {
    var_18 = var_15;

    if(isDefined(var_17.unittype)) {
      if(var_17.unittype == "c6" || var_17.unittype == "c6i") {
        var_18 = var_18 * 0.99;
      } else if(var_17.unittype == "c8") {
        var_18 = var_18 * 0.98;
      } else if(var_17.unittype == "c12") {
        var_18 = var_18 * 0.2;
      }
    }

    if(isPlayer(var_17)) {
      var_18 = var_18 * 0.99;
    }

    if(isDefined(var_17._id_F126) && var_17._id_F126 != self) {
      var_18 = var_18 * 0.5;
    }

    if(var_0) {
      var_8 = distancesquared(self.origin, var_17.origin);

      if(isDefined(self.bt._id_F15D) && self.bt._id_F15D == var_17) {
        var_18 = var_18 * 2.0;
        var_19 = 1 - scripts\sp\math::_id_C097(0, squared(var_12), var_8);
        var_18 = var_18 * (var_19 + 0.5);
      } else if(var_8 > squared(var_12))
        var_18 = 0;
      else {
        var_19 = 1 - scripts\sp\math::_id_C097(0, squared(var_12), var_8);
        var_18 = var_18 * (var_19 + 0.5);
      }
    } else {
      if(self.owner == level.player) {
        if(isDefined(var_10) && var_10 == var_17) {
          var_18 = var_18 * 3.0;
        }

        var_20 = scripts\sp\utility::_id_7951(level.player getEye(), level.player getplayerangles(), var_17.origin);
        var_21 = scripts\sp\math::_id_DF68(var_20, var_11, 1, 0, 1);
        var_18 = var_18 * var_21;
      } else if(self.bt._id_652A == "axis") {
        if(isDefined(level.player.damageattacker) && issentient(level.player.damageattacker) && isalive(level.player.damageattacker)) {
          var_18 = var_18 * 2.0;
        }
      } else if(isDefined(self.owner.lastattacker) && issentient(self.owner.lastattacker) && isalive(self.owner.lastattacker))
        var_18 = var_18 * 2.0;

      var_8 = distancesquared(self.origin, var_17.origin);
      var_19 = 1 - scripts\sp\math::_id_C097(squared(var_4), squared(var_3), var_8);
      var_18 = var_18 * (var_19 + 0.5);
    }

    if(!isDefined(var_14) || var_18 > var_13) {
      var_14 = var_17;
      var_13 = var_18;
    }
  }

  return var_14;
}

_id_F07D() {
  var_0 = getaiunittypearray("axis", "all");
  var_1 = 100;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4.ignoreme || !isalive(var_4)) {
      continue;
    }
    var_5 = distancesquared(self.origin, var_4.origin);

    if(var_5 < squared(var_1)) {
      continue;
    }
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  if(!var_2.size) {
    return undefined;
  }

  if(var_2.size == 1) {
    if(isDefined(var_2[0]) && isalive(var_2[0])) {
      return var_2[0];
    }
  }

  var_7 = _id_797E();

  if(isDefined(var_7)) {
    return var_7;
  }

  var_8 = cos(45);
  var_9 = 800;
  var_10 = 400;
  var_11 = 0;
  var_12 = undefined;
  var_13 = 1;

  foreach(var_15 in var_2) {
    var_16 = var_13;

    if(isDefined(var_15._id_F126) && var_15._id_F126 != self) {
      var_16 = var_16 * 0.5;
    }

    var_17 = scripts\sp\utility::_id_7951(level.player getEye(), level.player getplayerangles(), var_15.origin);
    var_18 = scripts\sp\math::_id_DF68(var_17, var_8, 1, 0, 1);
    var_16 = var_16 * var_18;
    var_5 = distancesquared(self.origin, var_15.origin);
    var_19 = 1 - scripts\sp\math::_id_C097(squared(var_1), squared(var_9), var_5);
    var_16 = var_16 * (var_19 + 0.5);

    if(!isDefined(var_12) || var_16 > var_11) {
      var_12 = var_15;
      var_11 = var_16;
    }
  }

  return var_12;
}

_id_797E() {
  var_0 = vectorNormalize(anglesToForward(self.angles));
  var_1 = self.origin + var_0 * 10000;
  var_2 = scripts\common\trace::ray_trace(self getEye(), var_1, self);

  if(isDefined(var_2["entity"])) {
    if(issentient(var_2["entity"])) {
      if(isenemyteam(self.team, var_2["entity"].team)) {
        var_3 = var_2["entity"];
        return var_3;
      }
    } else
      return undefined;
  }
}

_id_7981(var_0, var_1) {
  if(isalive(self.owner)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 2000);
  var_0 = sortbydistance(var_0, self.origin);

  foreach(var_3 in var_0) {
    var_4 = distancesquared(self.owner.origin, var_3.origin);

    if(_id_56EF(var_4, var_1)) {
      if(isalive(var_3)) {
        return var_3;
      }
    }
  }

  return undefined;
}

_id_56EF(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 800);

  if(var_0 <= var_1 * var_1 && var_0 >= level._id_F10A._id_4D19 * level._id_F10A._id_4D19) {
    return 1;
  }

  return 0;
}