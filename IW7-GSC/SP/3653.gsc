/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3653.gsc
**************************************/

main() {
  level._effect["vfx_contextmelee_throatslash"] = loadfx("vfx/iw7/core/mechanics/contextmelee/vfx_contextmelee_throatslash.vfx ");
  level._effect["vfx_contextmelee_neckstab"] = loadfx("vfx/iw7/core/mechanics/contextmelee/vfx_contextmelee_neckstab.vfx ");
  scripts\sp\utility::_id_16EB("context_melee", &"CONTEXT_MELEE_SILENT_KILL", ::_id_458B);
  level.player thread _id_61F2();
}

_id_CE34(var_0) {
  if(!soundexists(var_0)) {
    return;
  }
  self playSound(var_0);
  return;
}

_id_5F81() {
  precachemodel("tactical_knife_iw7_vm");
  scripts\engine\utility::flag_init("hold_context_melee");
  _id_5F82();
  _id_5F83();
}

#using_animtree("generic_human");

_id_5F82() {
  var_0 = [];
  var_0["context_melee_kill_01_back"] = % hm_grnd_stealth_exposed_stand_death_melee_2;
  var_0["context_melee_kill_02_back"] = % hm_grnd_stealth_exposed_stand_death_melee_01;
  var_0["context_melee_kill_03_back"] = % hm_grnd_stealth_exposed_stand_death_melee_02;

  foreach(var_3, var_2 in var_0) {
    level._id_EC85["generic"][var_3] = var_2;
    scripts\sp\anim::_id_17F6("generic", "death", ::_id_4588, var_3);
    scripts\sp\anim::_id_17F6("generic", "ragdoll", ::_id_4592, var_3);
    scripts\sp\anim::_id_17F6("generic", "start_ragdoll", ::_id_4592, var_3);
    scripts\sp\anim::_id_17F6("generic", "fx_death", ::_id_458A, var_3);
  }
}

#using_animtree("player");

_id_5F83() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["context_melee_kill_01_back"] = % vm_grnd_stealth_exposed_melee_kill_2;
  level._id_EC85["player_rig"]["context_melee_kill_02_back"] = % vm_grnd_stealth_exposed_melee_kill_01;
  level._id_EC85["player_rig"]["context_melee_kill_03_back"] = % vm_grnd_stealth_exposed_melee_kill_02;
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_458C, "context_melee_kill_01_back");
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_458D, "context_melee_kill_02_back");
  scripts\sp\anim::_id_17F6("player_rig", "stealth_kill", ::_id_458E, "context_melee_kill_03_back");
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  level.player._id_1E9C hide();
}

_id_458B() {
  self._id_6AB8 = 0;

  if(!isDefined(level.player._id_4593)) {
    return 1;
  }

  return scripts\engine\utility::is_true(level.player._id_4593._id_939E);
}

_id_4587() {
  self notify("context_melee_check_attack");
  self endon("context_melee_check_attack");
  self endon("stop_player_melee");
  self notifyonplayercommand("player_melee_attack", "+attack");
  self notifyonplayercommand("player_melee_attack", "+attack_akimbo_accessible");

  for(;;) {
    self waittill("player_melee_attack");
    var_0 = self getcurrentweapon();

    if(issubstr(var_0, "knife") && isDefined(level.player._id_4593)) {
      self notify("player_melee");
    }
  }
}

_id_4582(var_0) {
  if(!isDefined(self._id_4582)) {
    self._id_4582 = 1;
  }

  if(self._id_4582 == var_0) {
    return;
  }
  scripts\engine\utility::allow_melee(var_0);
  self._id_4582 = var_0;
}

_id_5F92() {
  self endon("stop_player_melee");

  for(;;) {
    self._id_4593 = undefined;
    self._id_4589 = undefined;
    self._id_4586 = undefined;
    _id_4582(1);

    if(isDefined(self._id_10E6D)) {
      if(!scripts\engine\utility::flag("stealth_enabled")) {
        scripts\engine\utility::flag_wait("stealth_enabled");
      }

      if(scripts\engine\utility::flag("stealth_spotted")) {
        scripts\engine\utility::flag_waitopen("stealth_spotted");
      }
    }

    if(scripts\engine\utility::flag("hold_context_melee")) {
      scripts\engine\utility::flag_waitopen("hold_context_melee");
    }

    if(scripts\sp\utility::_id_65DF("zero_gravity") && scripts\sp\utility::_id_65DB("zero_gravity") || self isreloading() || scripts\engine\utility::is_true(self.isreloading) || _id_9CFE() || _id_0E29::_id_87BA()) {
      wait 0.25;
      continue;
    }

    var_0 = _id_3D79();

    if(isDefined(var_0)) {
      var_1 = var_0 _id_D2DE();
      var_2 = var_0 _id_781A(var_1);

      if(var_0 _id_CFB3(var_2)) {
        self._id_4593 = var_0;
        self._id_4589 = var_1;
        self._id_4586 = var_2;
        thread scripts\sp\utility::_id_56BA("context_melee");
        _id_4582(0);
      } else
        self._id_4593 = undefined;
    }

    wait 0.05;
  }
}

_id_61F2() {
  self notify("stop_player_melee");

  if(!isDefined(self._id_B56F)) {
    self._id_B56F = scripts\sp\utility::_id_10639("player_rig", self.origin, self.angles);
  }

  self._id_B56F setcontents(0);
  self._id_B56F hide();
  self endon("stop_player_melee");
  self notifyonplayercommand("player_melee", "+melee");
  self notifyonplayercommand("player_melee", "+melee_breath");
  self notifyonplayercommand("player_melee", "+melee_zoom");
  _id_4582(0);
  thread _id_4587();
  thread _id_5F92();

  for(;;) {
    self waittill("player_melee");

    if(isalive(self._id_4593)) {
      var_0 = self._id_4593;
      var_1 = self._id_4589;
      var_2 = self._id_4586;

      if(isDefined(var_2)) {
        var_0 _id_D1F0(var_2);
      }
    }
  }
}

_id_5524() {
  self notify("stop_player_melee");
  _id_4582(1);
  self._id_4593 = undefined;
}

_id_3D79() {
  var_0 = 100;
  var_1 = var_0 * var_0;
  var_2 = getaiarray("axis");
  var_3 = anglesToForward((0, level.player getplayerangles()[1], 0));
  var_4 = level.player getEye();

  foreach(var_6 in var_2) {
    if(scripts\engine\utility::is_true(var_6._id_BFE4)) {
      continue;
    }
    if(var_6._id_1FEC != "generic_human") {
      continue;
    }
    if(!isalive(var_6)) {
      continue;
    }
    var_7 = var_6 gettagorigin("j_spine4");
    var_8 = distancesquared(var_7, var_4);

    if(var_8 > var_1) {
      continue;
    }
    var_9 = vectorNormalize(var_7 - var_4);

    if(vectordot(var_9, var_3) < 0.5) {
      continue;
    }
    if(var_6 cansee(level.player)) {
      continue;
    }
    if(isDefined(self._id_2023)) {
      continue;
    }
    if(bullettracepassed(level.player.origin + (0, 0, 48), var_7, 0, undefined)) {
      return var_6;
    }
  }

  return undefined;
}

_id_CFC5(var_0) {
  wait 0.05;
  var_1 = self.origin + (0, 0, 1);
  var_2 = playerphysicstrace(var_0 + (0, 0, 1), var_1, self, self.angles);

  if(distancesquared(var_1, var_2) > 0.0001) {
    var_3 = vectorNormalize(var_0 - var_1);
    self setOrigin(var_2 + var_3);
  }
}

_id_D1F0(var_0) {
  self notify("start_context_melee");
  var_1 = level.player.origin;

  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  var_2 = randomint(2);

  if(isDefined(self._id_10E6D)) {
    scripts\sp\utility::_id_65DD("stealth_enabled");
  }

  self notify("end_patrol");
  var_3 = scripts\engine\utility::spawn_tag_origin();
  self notify("stop_loop");
  scripts\sp\utility::anim_stopanimScripted();

  if(isDefined(self._id_4591)) {
    var_3.origin = self._id_4591;
  } else {
    var_3.origin = self.origin;
  }

  if(isDefined(self._id_4583)) {
    var_3.angles = self._id_4583;
  } else {
    var_3.angles = level.player.angles;
  }

  level.player._id_939E = 1;
  self._id_939E = 1;
  self._id_1C78 = 0;
  self.dontmelee = 1;
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self._id_28CF = 0;
  self._id_1FBB = "generic";
  self._id_4584 = var_0;
  self._id_E014 = 1;

  if(isDefined(self._id_10E6D)) {
    _id_0F22::_id_9B25();
  }

  self setgoalpos(var_3.origin);
  self clearpath();

  if(isDefined(self) && isalive(self) && !isDefined(self.delayeddeath) && !isDefined(self.melee)) {
    thread scripts\sp\utility::_id_B14F();
  }

  if(isDefined(self) || isalive(self)) {
    level.player _meth_80D1();
    level.player _meth_84AF(1);
    var_3 scripts\sp\anim::_id_1EC3(level.player._id_B56F, var_0);
    scripts\engine\utility::waitframe();
    var_4 = spawn("script_model", level.player.origin);
    var_4 setModel("tactical_knife_iw7_vm");
    var_4 setcontents(0);
    var_4 linkTo(level.player._id_B56F, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    scripts\engine\utility::delaythread(5, ::_id_4E1D, self);
    _id_D85C();
    level.player thread _id_D1D7();
    var_3 scripts\sp\anim::_id_1F2C([level.player._id_B56F, self], var_0);
    _id_4588(self);
    _id_4592(self);
    level.player._id_B56F hide();
    var_4 delete();
  }

  level.player _id_DF3E(var_1);
  level.player _meth_80A1();
  level.player _meth_84AF(0);
  level.player._id_B56F hide();
  level.player._id_4590 = _id_7B11(level.player._id_4590);
  level.player._id_939E = undefined;
  var_3 delete();
}

_id_D1D7() {
  self _meth_823C(self._id_B56F, "tag_player", 0.2, 0.1, 0.1);
  wait 0.2;
  self playerlinktodelta(self._id_B56F, "tag_player", 0, 5, 5, 5, 5);
  self._id_B56F show();
}

_id_4588(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0._id_10265 = 1;
  var_0.noragdoll = 1;
  var_0 _meth_8250(0);
  var_0 setcontents(0);
  var_0 scripts\anim\shared::_id_5D1A();
  var_0.allowdeath = 1;

  if(isDefined(var_0._id_B14F)) {
    var_0 scripts\sp\utility::_id_1101B();
  }

  var_0 _meth_81D0((0, 0, 0), level.player, level.player);

  if(!scripts\engine\utility::is_true(var_0._id_4592)) {
    level.player._id_458F = var_0.origin;
  }
}

_id_458A(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_4584)) {
    switch (var_0._id_4584) {
      case "context_melee_kill_01_back":
        break;
      case "context_melee_kill_02_back":
        playFXOnTag(scripts\engine\utility::getfx("vfx_contextmelee_throatslash"), var_0, "j_neck");
        break;
      case "context_melee_kill_03_back":
        playFXOnTag(scripts\engine\utility::getfx("vfx_contextmelee_neckstab"), var_0, "j_neck");
        break;
    }
  }
}

_id_4592(var_0) {
  if(!isDefined(var_0) && isDefined(level.player._id_458F)) {
    foreach(var_2 in getcorpsearray()) {
      if(scripts\engine\utility::is_true(var_2._id_4592)) {
        continue;
      }
      if(var_2 _meth_81B7()) {
        continue;
      }
      var_3 = var_2.origin;

      if(getdvarint("ai_corpsesynch")) {
        var_3 = var_2 _meth_82CC();
      }

      if(isDefined(var_3) && distancesquared(var_3, level.player._id_458F) < squared(60)) {
        var_2 startragdoll();
        var_2._id_4592 = 1;
      }
    }
  } else if(isDefined(var_0) && !scripts\engine\utility::is_true(var_0._id_4592)) {
    var_0 thread scripts\anim\shared::_id_5D1A();
    var_0 startragdoll();
    var_0._id_4592 = 1;
  }

  level.player._id_458F = undefined;
}

_id_4E1D(var_0) {
  if(isDefined(var_0)) {
    if(isalive(var_0)) {
      if(isDefined(var_0._id_B14F)) {
        var_0 scripts\sp\utility::_id_1101B();
      }
    }
  }
}

_id_CFB3(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level._id_EC85["generic"][var_0])) {
    return 0;
  }

  if(self.a.pose != "stand" && self.a.pose != "crouch") {
    return 0;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee._id_9882) && self.melee._id_9882 || isDefined(self.melee._id_9904) && self.melee._id_9904) {
      return 0;
    }
  }

  var_1 = abs(self.origin[2] - level.player.origin[2]);

  if(var_1 >= 20) {
    return 0;
  }

  return 1;
}

_id_D2DE() {
  var_0 = self gettagangles("j_spine4");
  var_1 = self gettagorigin("j_spine4");
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  var_4 = level.player.origin - var_1;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_5 = abs(vectordot(var_3, (0, 0, 1)));

  if(var_5 > 0.7) {
    var_3 = vectorNormalize((var_2[0], var_2[1], 0));
  } else {
    var_3 = vectorNormalize((var_3[0], var_3[1], 0));
  }

  var_6 = anglesToForward(self.angles);

  if(vectordot(var_4, var_6) > vectordot(var_3, var_6)) {
    var_3 = var_6;
  }

  var_2 = vectorcross(var_3, (0, 0, 1));
  var_7 = vectordot(var_3, var_4);
  var_8 = vectordot(var_2, var_4);

  if(var_7 < -0.6) {
    return "back";
  } else if(var_7 > 0.6) {
    return "front";
  } else if(var_8 > 0) {
    return "right";
  } else {
    return "left";
  }

  return undefined;
}

_id_7B11(var_0, var_1) {
  var_2 = var_0;

  for(;;) {
    var_3 = "context_melee_kill_0" + var_2 + "_";

    if(isDefined(var_1)) {
      if(isDefined(level._id_EC85["generic"][var_3 + var_1])) {
        return var_3 + var_1;
      }
    }

    var_2++;
    var_3 = "context_melee_kill_0" + var_2 + "_";

    if(!isDefined(level._id_EC85["generic"][var_3 + "back"]) && !isDefined(level._id_EC85["generic"][var_3 + "front"]) && !isDefined(level._id_EC85["generic"][var_3 + "left"]) && !isDefined(level._id_EC85["generic"][var_3 + "right"])) {
      var_2 = 1;
    }

    if(!isDefined(var_1)) {
      return var_2;
    }

    if(var_2 == var_0) {
      break;
    }
  }

  return undefined;
}

_id_781A(var_0) {
  if(!isDefined(level.player._id_4590)) {
    level.player._id_4590 = 1;
  }

  var_1 = level.player._id_4590;
  var_2 = undefined;

  if(isDefined(self._id_4585)) {
    if(isDefined(self._id_4585[var_0])) {
      var_2 = self._id_4585[var_0];
    } else if(isDefined(self._id_4585["all"])) {
      var_2 = self._id_4585["all"];
    }
  }

  if(!isDefined(var_2)) {
    var_2 = _id_7B11(level.player._id_4590, var_0);
  }

  return var_2;
}

_id_F309(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  if(!isDefined(var_0) && isDefined(self._id_4585) && isDefined(self._id_4585[var_1])) {
    self._id_4585[var_1] = undefined;
    return;
  }

  if(isDefined(level._id_EC85["player_rig"][var_0]) && isDefined(level._id_EC85["generic"][var_0])) {
    if(!isDefined(self._id_4585)) {
      self._id_4585 = [];
    }

    self._id_4585[var_1] = var_0;
    scripts\sp\anim::_id_17F6("generic", "death", ::_id_4588, var_0);
    scripts\sp\anim::_id_17F6("generic", "ragdoll", ::_id_4592, var_0);
    scripts\sp\anim::_id_17F6("generic", "start_ragdoll", ::_id_4592, var_0);
  }
}

_id_9CFE() {
  if(scripts\sp\utility::_id_65DF("player_retract_shield_active")) {
    return scripts\sp\utility::_id_65DB("player_retract_shield_active");
  }
}

_id_D85C() {
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
}

_id_DF3E(var_0) {
  level.player unlink(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.player thread _id_CFC5(var_0);
}

_id_458C(var_0) {
  var_0 _id_CE34("context_melee_kill_01_back");
}

_id_458D(var_0) {
  var_0 _id_CE34("context_melee_kill_02_back");
}

_id_458E(var_0) {
  var_0 _id_CE34("context_melee_kill_03_back");
}