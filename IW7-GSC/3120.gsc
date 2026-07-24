/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3120.gsc
**************************************/

#using_animtree("script_model");

_id_80A1() {
  var_0 = [];
  var_0["chokePlayer_counter_c"] = % c6_grnd_red_melee_choke_counter_cable;
  return var_0;
}

#using_animtree("player");

_id_807A() {
  var_0 = [];
  var_0["chokePlayer_save"] = % vm_grnd_red_melee_choke_rescued;
  var_0["chokePlayer_kill"] = % vm_grnd_red_melee_choke_death;
  var_0["chokePlayer_counter"] = % vm_grnd_red_melee_choke_counter;
  var_0["chokePlayer_counter_b"] = % vm_grnd_red_melee_choke_counter_fast_knife_out_b;
  var_0["chokePlayer_counter_c"] = % vm_grnd_red_melee_choke_counter_cable_cut;
  var_0["chokePlayer"] = % vm_grnd_red_melee_choke_enter;
  var_0["crawlMeleeGrab"] = % vm_grnd_red_melee_pounding_enter;
  var_0["crawlMeleeGrab_loop"] = % vm_grnd_red_melee_pounding_loop;
  var_0["crawlMeleeGrab_win"] = % vm_grnd_red_melee_pounding_win;
  var_0["crawlMeleeGrab_lose"] = % vm_grnd_red_melee_pounding_lose;
  return var_0;
}

#using_animtree("generic_human");

_id_8100() {
  var_0 = [];
  var_0["slt_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  var_0["omr_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  var_0["eth_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  return var_0;
}

_id_B64E(var_0, var_1, var_2, var_3) {
  return isPlayer(self.melee.target);
}

_id_B608(var_0, var_1, var_2, var_3) {
  if(isPlayer(self.melee.target)) {
    var_4 = self.origin;
    var_5 = self.melee.target.origin;

    if(int(var_5[2]) > int(var_4[2]) + 1) {
      return 0;
    }

    var_6 = vectorNormalize(var_5 - var_4);
    var_7 = var_4 - var_6 * 36;
    var_8 = scripts\common\trace::ai_trace_passed(var_4, var_7, undefined, [self, self.melee.target], undefined, 4);
    return var_8;
  } else
    return 0;
}

_id_B61B(var_0, var_1, var_2, var_3) {
  _id_0F3D::_id_D394();
  self.damageshield = 1;
  self.ignoreme = 1;
  _id_0F3D::_id_B60F();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");

  if(isDefined(self.weapon)) {
    self.meleegrabweapon = self.weapon;
  }

  scripts\anim\shared::placeweaponon(self.weapon, "none");
  scripts\aitypes\melee::_id_B5B4(self.unittype);
  thread _id_D3F9();
  self playSound("c6_grapple_grab_enter");
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_D3F9() {
  if(isDefined(self._id_72CE)) {
    var_0 = (0, self._id_72CE, 0);
  } else {
    var_0 = vectortoangles(self.origin - level.player.origin);
    var_0 = (0, var_0[1], 0);
  }

  var_1 = _id_0F3D::_id_108F6();
  var_1.angles = var_0;
  level.player.melee.partner = self;
  level.player.melee._id_E505 = var_1;
  var_2 = _id_807A();
  level.player playRumbleOnEntity("heavy_2s");
  var_3 = "meleeAnim";
  var_1 _meth_82E4(var_3, var_2["chokePlayer"], var_1._id_E6E5, 1, 0.2, 1);
  level.player notify("choke_scene_music");
  thread _id_D3F8(var_1);
  var_4 = getanimlength(var_2["chokePlayer"]);
  level.player thread _id_0F3D::_id_B611(var_4);

  if(getdvarint("exec_review") > 0) {
    thread _id_68D0(var_4);
  }

  var_1 thread scripts\sp\anim::_id_10CBF(var_1, var_3);
  var_1 scripts\anim\shared::donotetracks(var_3);
}

_id_68D0(var_0) {
  wait(var_0 - 0.1);
  level.player.melee._id_46B6 = 1;

  if(isDefined(level.player.melee._id_B5FE)) {
    level.player thread _id_0F3D::_id_46B5(0.1);
  }

  level.player notify("bt_meleegrab_slowmo");
}

_id_D3F8(var_0) {
  level.player endon("meleegrab_interupt");
  var_1 = 0.2;
  var_0 thread _id_B615(self);
  level.player _meth_823C(var_0, "tag_player", var_1, 0, var_1);
  level.player viewkick(10, self.origin);
  self _meth_81E1(var_0, "tag_sync", 1, 0);
  wait(var_1);

  if(!isalive(self)) {
    return;
  }
  level.player _meth_84FE();
  thread _id_0F3D::_id_5103(0.5, 2, 20, 10, 5, 60, 10, 0.1);
  thread _id_0F3D::_id_5103(1, 2, 20, 4, 50, 90, 10, 0.1);
  thread _id_0F3D::_id_510F(1, 50, 0.4);
  var_0 show();
  level.player thread _id_0F3D::_id_D3A3();
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.2, 0, 0, 15, 5, 30, 5);
  thread _id_D395();
}

_id_B615(var_0) {
  self endon("death");
  level.player endon("bt_stop_meleegrab");

  while(!_id_B60E(var_0)) {
    wait 0.05;
  }

  level.player notify("meleegrab_interupt");

  if(isDefined(level.player.melee) && isDefined(level.player.melee._id_B5FE)) {
    level.player _id_0F3D::_id_46B5();
  }

  if(!isalive(var_0)) {
    var_0 _id_B5FA();
  } else {
    var_0.damageshield = 0;
    var_0.ignoreme = 0;
    var_0 scripts\anim\shared::placeweaponon(var_0.weapon, "right");
    var_0 _id_B5FA();
  }

  thread _id_0F3D::_id_50E8(0.2);
  thread _id_0F3D::_id_510F(0.25, 65, 0.4);
  setslowmotion(1, 1, 0);
  _id_0F3D::_id_D3D2();
  level.player unlink();
  self delete();
}

_id_B60E(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(isDefined(var_0._id_2029)) {
    return 1;
  }

  if(isDefined(level.player._id_93B5) && level.player._id_93B5 == 1) {
    return 1;
  }

  return 0;
}

_id_D395() {
  wait 0.1;
  var_0 = level.player.origin + anglesToForward(level.player.angles) * -100;
  screenshake(var_0, 10, 2, 1, 0.4, 0.2, 0.2, 700, 0.2, 1, 1);
  wait 0.5;
  var_0 = level.player.origin + anglesToForward(level.player.angles) * 100;
  screenshake(var_0, 10, 2, 1, 0.6, 0.3, 0.3, 700, 0.2, 1, 1);
}

_id_B61E(var_0, var_1, var_2, var_3) {
  if(isDefined(level.player.gs._id_B639._id_72DC)) {
    level.player.gs._id_B639._id_EB7B = level.player.gs._id_B639._id_72DC;
    return 1;
  }

  if(scripts\sp\utility::_id_7E72() == "fu") {
    return 0;
  }

  var_4 = gettime();

  if(isDefined(level.player.gs._id_B639._id_B63B) && var_4 < level.player.gs._id_B639._id_B63B) {
    return 0;
  }

  if(level.player.gs._id_B63C <= 0) {
    return 0;
  }

  var_5 = _id_7BCF();

  if(var_5.size == 0) {
    return 0;
  }

  var_5 = scripts\sp\utility::array_removedeadvehicles(var_5);
  var_6 = (40, -55, 0);
  var_7 = self.origin + rotatevector(var_6, self.angles);

  if(!_func_2AC(self _meth_84AC(), var_7, self)) {
    return 0;
  }

  var_8 = squared(2000);
  var_9 = [];

  foreach(var_11 in var_5) {
    var_12 = distancesquared(level.player.origin, var_11.origin);

    if(var_12 > var_8) {
      continue;
    }
    if(var_11 _meth_81A6()) {
      continue;
    }
    if(isDefined(var_11.melee)) {
      continue;
    }
    if(var_11 islinked()) {
      continue;
    }
    if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_11.origin, 0.173648)) {
      continue;
    }
    if(var_5.size > 1 && isDefined(level.player.gs._id_B639._id_A9E8) && level.player.gs._id_B639._id_A9E8 == var_11) {
      continue;
    }
    var_9[var_9.size] = var_11;
  }

  if(var_9.size > 0) {
    level.player.gs._id_B639._id_EB7B = scripts\engine\utility::random(var_9);
    level.player.gs._id_B639._id_A9E8 = level.player.gs._id_B639._id_EB7B;
    level.player.gs._id_B63C--;
    level.player.gs._id_B639._id_B63B = var_4 + level.player.gs._id_B63A;

    if(isDefined(level.player.melee._id_B5FE)) {
      level.player thread _id_0F3D::_id_46B5();
    }

    return 1;
  }

  return 0;
}

_id_7BCF() {
  var_0 = [];
  var_1 = getaiarray("allies");
  var_2 = ["eth", "slt", "omr"];

  foreach(var_4 in var_1) {
    foreach(var_6 in var_2) {
      if(var_4.npcid == var_6) {
        var_0[var_0.size] = var_4;
      }
    }
  }

  return var_0;
}

_id_B61D(var_0, var_1, var_2, var_3) {
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

_id_B60D(var_0, var_1, var_2, var_3) {
  if(isDefined(anim)) {
    if(isPlayer(self.melee.target)) {
      anim._id_B5F7[self.unittype] = gettime();
    } else {
      anim._id_B5F8[self.unittype] = gettime();
    }
  }

  _id_B5FA();
}

_id_B5FA() {
  if(isalive(self)) {
    self._id_87F6 = 1;
    self.ignoreme = 0;
    scripts\asm\asm_bb::bb_clearmeleerequest();
    scripts\aitypes\melee::melee_destroy();
  }
}

_id_B61F(var_0, var_1, var_2, var_3) {
  var_4 = _id_8100();
  var_5 = _id_807A();
  var_6 = "meleeSave";
  var_7 = "chokePlayer_save";
  var_8 = var_5[var_7];
  var_9 = level.player.melee._id_E505;
  var_10 = level.player.gs._id_B639._id_EB7B;
  var_10.asm._id_EB67 = var_4[var_10.npcid + "_save"];
  var_10.allowpain = 0;
  var_10.ignoreme = 1;
  var_10 setCanDamage(0);
  thread _id_0F3D::_id_50E8(0.5);
  thread _id_0F3D::_id_510F(0.5, 65, 0.4);
  var_9 _meth_82E4(var_6, var_8, var_9._id_E6E5, 1, 0.2, 1);
  var_9 thread scripts\sp\anim::_id_10CBF(var_9, var_6);
  var_9 thread scripts\anim\shared::donotetracks(var_6, ::_id_B617);
  var_11 = self gettagorigin("tag_sync");
  var_12 = self gettagangles("tag_sync");
  var_10 dontinterpolate();
  var_10 _meth_80F1(var_11, var_12);
  var_10._id_B650 = spawn("script_model", var_11);
  var_10._id_B650 setModel("tag_origin");
  var_10._id_B650.angles = var_12;
  var_10._id_B650 linkTo(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  level.player thread _id_B062();
  var_10 _meth_81E1(var_10._id_B650, "tag_origin", 1, 0);
  var_10 _id_0A1E::_id_2307(::_id_EB7C, ::saviorcleanup);
  var_13 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_13, 1.0, var_2, 1.0);
  thread scripts\sp\anim::_id_10CBF(self, var_1);
  var_14 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_14 == "end") {
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }
}

_id_B062() {
  level.player endon("bt_stop_loopscreenshake");

  for(;;) {
    var_0 = level.player.origin + anglesToForward(level.player.angles) * 100;
    screenshake(var_0, 10, 15, 10, 1, 0.5, 0.5, 1000, 3, 1, 1);
    wait 1;
  }
}

_id_B61C(var_0, var_1, var_2, var_3) {
  level.player endon("meleegrab_interupt");
  var_4 = _id_807A();
  var_5 = undefined;
  var_6 = randomfloatrange(0, 1);

  if(var_6 <= 0.33) {
    var_7 = "chokePlayer_counter";
    var_8 = _id_0A1E::_id_2356("melee_playerCounter", var_7);
  } else if(var_6 >= 0.67) {
    var_7 = "chokePlayer_counter_b";
    var_8 = _id_0A1E::_id_2356("melee_playerCounter", var_7);
  } else {
    var_7 = "chokePlayer_counter_c";
    var_8 = _id_0A1E::_id_2356("melee_playerCounter", var_7);
    var_9 = _id_80A1();
    var_5 = var_9[var_7];
  }

  var_10 = "meleeCounter";
  var_11 = var_4[var_7];
  var_12 = level.player.melee._id_E505;
  thread _id_0F3D::_id_50E8(0.5);
  thread _id_0F3D::_id_510F(0.5, 65, 0.4);
  var_12 _meth_82E4(var_10, var_11, var_12._id_E6E5, 1, 0.2, 1);
  var_12 thread scripts\sp\anim::_id_10CBF(var_12, var_10);
  var_12 thread scripts\anim\shared::donotetracks(var_10, ::_id_B617);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  if(isDefined(var_5)) {
    thread _id_3675(var_1, var_5, var_2);
  }

  self _meth_82E7(var_1, var_8, 1.0, var_2, 1.0);
  thread scripts\sp\anim::_id_10CBF(self, var_1);
  var_13 = _id_0A1E::_id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

#using_animtree("script_model");

_id_3675(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("robot_c6_cable");
  var_3._id_1FBB = "script_model";
  var_3 _meth_83D0(#animtree);
  var_3.origin = self gettagorigin("j_head_pv_z");
  var_3.angles = self gettagangles("j_head_pv_z");
  var_3 linkTo(self, "j_head_pv_z");
  var_3 _meth_82E7(var_0, var_1, 1.0, var_2, 1);
  scripts\engine\utility::waittill_notify_or_timeout("death", 7);

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_EB7C() {
  self endon("killanimscript");
  var_0 = "meleeSave";
  self _meth_82E4(var_0, self.asm._id_EB67, _id_0A1E::_id_2342(), 1, 0.2, 1);
  thread scripts\sp\anim::_id_10CBF(self, var_0);
  var_1 = getanimlength(self.asm._id_EB67) + 1.0;
  scripts\anim\notetracks::donotetrackswithtimeout(var_0, var_1, ::_id_B617);
}

saviorcleanup() {
  self setCanDamage(1);
  self.allowpain = 1;
  self.ignoreme = 0;
  self.asm._id_EB67 = undefined;
  self unlink();
  self notify("melee_save_complete");

  if(isDefined(self._id_B650)) {
    self._id_B650 delete();
  }
}

_id_B61A(var_0, var_1, var_2, var_3) {
  level.player thread _id_0F3D::_id_46B5();
  var_4 = _id_807A();
  var_5 = "meleeKillPlayer";
  var_6 = "chokePlayer_kill";
  var_7 = var_4[var_6];
  var_8 = level.player.melee._id_E505;
  thread _id_0F3D::_id_50E8(0.5);
  thread _id_0F3D::_id_510F(0.5, 65, 0.4);
  var_8 _meth_82E4(var_5, var_7, var_8._id_E6E5, 1, 0.2, 1);
  var_8 thread scripts\sp\anim::_id_10CBF(var_8, var_5);
  var_8 thread scripts\anim\shared::donotetracks(var_5, ::_id_B617);
  self playSound("c6_grapple_punch");
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_B617(var_0) {
  switch (var_0) {
    case "unlink":
      self unlink();
      break;
    case "player_unlink":
      _id_D456();
      break;
    case "attach_knife":
      self attach(level._id_EC8C["asm_viewmodel_knife"], "tag_accessory_right", 1);
      break;
    case "knife_stab":
      playFXOnTag(level._id_7649["bt_c6_knife_counter_stab"], self, "tag_knife_fx");
      thread _id_A707();
      break;
    case "detach_knife":
      self detach(level._id_EC8C["asm_viewmodel_knife"], "tag_accessory_right");
      break;
    case "headgib":
      var_1 = spawnStruct();
      var_1.partname = "head";
      _id_0BFE::_id_EF2B(var_1);
      self.damageshield = 0;
      self.ignoreme = 0;
      self._id_10265 = 1;
      self.asm._id_4E40 = ::_id_B614;
      self _meth_81D0();

      if(isDefined(self._id_B63D)) {
        self._id_B63D unlink();
      }

      break;
    case "player_kick_off":
      self.bt._id_55CE = 1;
      self.bt._id_55CF = 1;
      self.damageshield = 0;
      thread _id_0BFE::_id_4D64();
      self setCanDamage(1);
      self playSound("c6_grapple_kick_pain");
      break;
    case "kill_c6":
      self.damageshield = 0;
      self.ignoreme = 0;
      self._id_10265 = 1;
      self.asm._id_4E40 = ::_id_B613;
      self playSound("c6_grapple_knife_death");
      self _meth_81D0();
      break;
    case "player_kill":
      level.player notify("bt_stop_meleegrab");
      _id_E128();
      setblur(10, 0.1);
      level.player _meth_80A1();
      level.player _meth_81D0();
      break;
    case "disable_weapons":
      level.player disableweapons();
      level.player viewkick(10, self.origin);
      break;
    case "rm_damage_heavy":
      if(scripts\engine\utility::cointoss()) {
        level.player playRumbleOnEntity("heavy_1s");
        return;
      }

      level.player playRumbleOnEntity("light_1s");
      return;
  }
}

_id_A707() {
  var_0 = ["c6_grapple_knife_pain_01", "c6_grapple_knife_pain_02", "c6_grapple_knife_pain_03"];

  if(isalive(level.player)) {
    if(isDefined(level.player.melee) && isDefined(level.player.melee.partner)) {
      level.player.melee.partner playSound(var_0[randomintrange(0, 3)]);
    }
  }
}

_id_D456() {
  level.player endon("death");
  level.player unlink();
  level.player _meth_84FD();

  if(isDefined(level.player.melee) && isDefined(level.player.melee._id_E505)) {
    level.player.melee._id_E505 delete();
  }

  level.player notify("bt_stop_loopscreenshake");
  level.player notify("bt_stop_meleegrab");

  if(isDefined(level.player)) {
    if(isDefined(level.player.melee) && isDefined(level.player.melee.partner)) {
      var_0 = vectorNormalize(level.player.origin - level.player.melee.partner.origin);
      var_0 = var_0 * 100;
      level.player setvelocity(var_0);
    }
  }

  _id_0F3D::_id_D3D2();
}

_id_B614() {
  _id_B5FA();
  self waittillmatch("melee_savePlayer", "start_ragdoll");

  if(isDefined(self._id_71C8)) {
    self[[self._id_71C8]]();
  }

  wait 0.2;
  return 1;
}

_id_B613() {
  if(isDefined(self.meleegrabweapon)) {
    self dropweapon(self.meleegrabweapon, "right", 0);
  }

  _id_B5FA();

  if(isDefined(self._id_71C8)) {
    self[[self._id_71C8]]();
  }

  self startragdoll();
  wait 0.05;
  return 1;
}

_id_3386(var_0, var_1, var_2, var_3) {
  _id_0C64::_id_B57F();
  return 1;
}

_id_335A(var_0, var_1) {
  var_2 = self.melee.target;
  var_3 = var_2.origin;
  var_4 = vectortoangles(var_3 - self.origin);
  self.melee._id_10D6D = var_4;
  var_2.melee._id_10E0E = var_2.angles[1];
  return 1;
}

_id_3366(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;

  if(!isDefined(var_4)) {
    return 0;
  }

  if(!isalive(var_4)) {
    return 0;
  }

  var_5 = var_3;

  if(self.melee._id_13D8A != var_5) {
    return 0;
  }

  var_6 = self[[self._id_7191]](var_0, var_2);

  if(!_id_335A(var_1 + "_victim", var_6)) {
    return 0;
  }

  self.melee.target.melee._id_331C = 1;
  return 1;
}

_id_4885(var_0, var_1, var_2, var_3) {
  self.damageshield = 1;
  self.ignoreme = 1;
  self.bt.crawlmeleegrab = 1;
  self _meth_8078();
  _id_0F3D::_id_D394("crawlmelee");
  _id_0F3D::_id_B60F();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread _id_D3EC();
  self.bt._id_F1F9 = undefined;
  self.bt._id_55CE = 1;
  self.bt._id_55CF = 1;
  self stoploopsound();
  level.player playSound("c6_grapple_crawl_takedown");
  self playSound("c6_grapple_grab_grunt");
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_D3EC() {
  level.player endon("crawlmeleegrab_interrupt");
  var_0 = vectortoangles(self.origin - level.player.origin);
  var_0 = (0, var_0[1], 0);
  var_1 = _id_0F3D::_id_108F6();
  var_1.angles = var_0;
  level.player.melee.partner = self;
  level.player.melee._id_E505 = var_1;
  var_2 = _id_807A();
  var_3 = "meleeAnim";
  var_1 _meth_82E4(var_3, var_2["crawlMeleeGrab"], var_1._id_E6E5, 1, 0.2, 1);
  var_1 thread _id_4884(self);
  thread _id_487D(var_1);
  level.player forceplaygestureviewmodel("ges_crawlmelee_enter", undefined, undefined, undefined, 1);
  var_1 thread scripts\sp\anim::_id_10CBF(var_1, var_3);
  var_1 scripts\anim\shared::donotetracks(var_3);
}

_id_D3EB(var_0) {
  level.player endon("stop_crawlmelee_loop");
  level.player endon("crawlmeleegrab_interrupt");
  var_0 thread scripts\engine\utility::play_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  var_1 = _id_807A();
  var_2 = var_1["crawlMeleeGrab_loop"];
  level.player forceplaygestureviewmodel("ges_crawlmelee_grabbed");
  var_3 = "crawMeleeGrabLoop";

  while(isDefined(level.player.melee)) {
    level.player.melee._id_E505 _meth_82E7(var_3, var_2, 1.0, 0.2, 1);
    level.player.melee._id_E505 scripts\anim\shared::donotetracks(var_3);
  }
}

_id_487D(var_0) {
  level.player endon("crawlmeleegrab_interrupt");
  var_1 = 0.2;
  level.player _meth_823C(var_0, "tag_player", var_1, 0, var_1);
  wait(var_1);
  self _meth_81E1(var_0, "tag_sync", 1, 0);
  _id_17CD(var_0);
  var_2 = level.player getcurrentprimaryweapon();

  if(isDefined(var_2)) {
    var_3 = weaponclass(var_2);
    var_4 = ["rifle", "smg", "pistol", "spread", "mg"];

    if(scripts\engine\utility::array_contains(var_4, var_3)) {
      var_5 = weaponclipsize(var_2);
      var_6 = level.player getweaponammoclip(var_2);
      var_7 = int(var_5 * 0.35);

      if(var_6 <= int(var_5 * 0.4)) {
        level.player setweaponammoclip(var_2, var_6 + var_7);
      }
    }
  }

  level.player _meth_84FE();
  thread _id_0F3D::_id_5103(1.5, 1, 50, 100, 15, 100, 5, 1.5);
  var_0 show();
  level.player thread _id_0F3D::_id_D3A3();
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 30, 30, 10);
  thread _id_D395();
}

_id_4884(var_0) {
  self endon("death");
  thread _id_933D();

  while(!_id_4883(var_0)) {
    wait 0.05;
  }

  level.player notify("crawlmeleegrab_interrupt");

  if(isDefined(level.player.melee) && isDefined(level.player.melee._id_B5FE)) {
    level.player _id_0F3D::_id_46B5();
  }

  if(!isalive(var_0)) {
    var_0 _id_B5FA();
  } else {
    if(isDefined(var_0.bt._id_6B4B)) {
      var_0.health = var_0.bt._id_6B4B;
    }

    var_0.damageshield = 0;
    var_0 scripts\anim\shared::placeweaponon(var_0.weapon, "right");
    var_0 _id_B5FA();
  }

  _id_E128();
  thread _id_0F3D::_id_50E8(0.2);
  thread _id_0F3D::_id_510F(0.25, 65, 0.4);
  setslowmotion(1, 1, 0);
  level.player unlink();
  level.player notify("crawlgrabmelee_cleanup");
  self delete();
}

_id_933D() {
  level.player endon("death");
  level.player endon("crawlgrabmelee_cleanup");
  level.player waittill("crawlmeleegrab_antigrav");
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableweapons();
  level.player allowoffhandshieldweapons(1);
  level.player _meth_80A6();
  level.player enableusability();
  level.player scripts\sp\utility::_id_1C34(1);
}

_id_4883(var_0) {
  if(isDefined(var_0._id_2029)) {
    return 1;
  }

  if(isDefined(level.player._id_93B5) && level.player._id_93B5 == 1) {
    return 1;
  }

  return 0;
}

_id_17CD(var_0) {
  level.player._id_8675 = spawn("script_origin", level.player.origin);
  level.player._id_8675 linkTo(var_0, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player _meth_823F(level.player._id_8675);
}

_id_E128() {
  if(!isDefined(level.player._id_8675)) {
    return;
  }
  level.player _meth_823F(undefined);
  level.player._id_8675 delete();
}

_id_4886(var_0, var_1, var_2, var_3) {
  level.player endon("crawlmeleegrab_interrupt");
  level.player thread _id_4887(self);
  self.bt._id_6B4B = self.health;
  self.health = 50000;
  level.player thread _id_D3EB(self);
  _id_0A1E::_id_235F(var_0, var_1, var_2, 1.0);
}

_id_4887(var_0) {
  level.player endon("crawlmeleegrab_interrupt");
  var_1 = gettime() + 5000;
  var_0.damageshield = 0;
  var_2 = 50000;
  var_3 = 0;

  while(gettime() < var_1) {
    wait 0.05;
    var_4 = var_2 - var_0.health;

    if(var_4 != var_3) {
      if(var_0.damagemod == "MOD_MELEE") {
        var_0 playSound("c6_grapple_hit_pain");
        var_2 = var_2 + 85;
        var_4 = var_2 - var_0.health;
        var_3 = var_4;
      } else if(scripts\engine\utility::cointoss())
        var_0 playSound("c6_grapple_shot_pain_01");
      else {
        var_0 playSound("c6_grapple_shot_pain_02");
      }
    }

    if(var_4 >= var_0.bt._id_6B4B) {
      level.player.melee._id_46B6 = 1;
      return;
    }
  }

  if(getdvarint("exec_review") > 0) {
    level.player.melee._id_46B6 = 1;
    return;
  }

  level.player.melee._id_46B6 = 0;
}

_id_488A(var_0, var_1, var_2, var_3) {
  level.player notify("stop_crawlmelee_loop");
  scripts\engine\utility::stop_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  self playSound("c6_grapple_crawl_win_collapse");
  level.player thread _id_488B();
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  _id_0A1E::_id_2364(var_0, var_1, var_2);
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "c6_grapple_crawl_win_foley");
}

_id_488B() {
  var_0 = level.player.melee._id_E505;
  var_1 = _id_807A();
  var_2 = "crawlMeleeCounter";
  thread _id_0F3D::_id_50E8(1);
  level.player _meth_80A6();
  level.player stopgestureviewmodel("ges_crawlmelee_grabbed");
  var_0 _meth_82E4(var_2, var_1["crawlMeleeGrab_win"], var_0._id_E6E5, 1, 0.2, 1);
  var_0 thread scripts\sp\anim::_id_10CBF(var_0, var_2);
  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_B617);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(0);
  level.player unlink();
  _id_E128();
  var_0 delete();
  level.player _meth_84FD();
  level.player enableoffhandweapons();
  level.player allowoffhandshieldweapons(1);
  level.player enableusability();
  wait 0.2;
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(1);
  level.player scripts\sp\utility::_id_1C34(1);
  level.player notify("crawlgrabmelee_cleanup");
}

_id_4888(var_0, var_1, var_2, var_3) {
  self.damageshield = 1;
  level.player notify("stop_crawlmelee_loop");
  scripts\engine\utility::stop_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  var_4 = _id_807A();
  var_5 = "crawlMeleeKill";
  level.player.melee._id_E505 _meth_82E4(var_5, var_4["crawlMeleeGrab_lose"], level.player.melee._id_E505._id_E6E5, 1, 0.2, 1);
  level.player.melee._id_E505 thread scripts\sp\anim::_id_10CBF(level.player.melee._id_E505, var_5);
  level.player.melee._id_E505 thread scripts\anim\shared::donotetracks(var_5, ::_id_B617);
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "c6_grapple_crawl_lose_pound_01");
  level.player scripts\engine\utility::delaycall(0.7, ::playsound, "c6_grapple_crawl_lose_pound_02");
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "c6_grapple_crawl_lose_pound_03");
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  _id_0A1E::_id_2364(var_0, var_1, var_2);
}

_id_D906() {}