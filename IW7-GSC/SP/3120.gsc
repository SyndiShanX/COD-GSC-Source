/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3120.gsc
************************/

_meth_80A1() {
  var_00 = [];
  var_00["chokePlayer_counter_c"] = % c6_grnd_red_melee_choke_counter_cable;
  return var_00;
}

clearpotentialthreat() {
  var_00 = [];
  var_00["chokePlayer_save"] = % vm_grnd_red_melee_choke_rescued;
  var_00["chokePlayer_kill"] = % vm_grnd_red_melee_choke_death;
  var_00["chokePlayer_counter"] = % vm_grnd_red_melee_choke_counter;
  var_00["chokePlayer_counter_b"] = % vm_grnd_red_melee_choke_counter_fast_knife_out_b;
  var_00["chokePlayer_counter_c"] = % vm_grnd_red_melee_choke_counter_cable_cut;
  var_00["chokePlayer"] = % vm_grnd_red_melee_choke_enter;
  var_00["crawlMeleeGrab"] = % vm_grnd_red_melee_pounding_enter;
  var_00["crawlMeleeGrab_loop"] = % vm_grnd_red_melee_pounding_loop;
  var_00["crawlMeleeGrab_win"] = % vm_grnd_red_melee_pounding_win;
  var_00["crawlMeleeGrab_lose"] = % vm_grnd_red_melee_pounding_lose;
  return var_00;
}

getanimentrycount() {
  var_00 = [];
  var_00["slt_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  var_00["omr_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  var_00["eth_save"] = % hm_grnd_red_melee_choke_rescued_salter;
  return var_00;
}

func_B64E(param_00, param_01, param_02, param_03) {
  return isplayer(self.melee.target);
}

func_B608(param_00, param_01, param_02, param_03) {
  if(isplayer(self.melee.target)) {
    var_04 = self.origin;
    var_05 = self.melee.target.origin;
    if(int(var_05[2]) > int(var_04[2]) + 1) {
      return 0;
    }

    var_06 = vectornormalize(var_05 - var_04);
    var_07 = var_04 - var_06 * 36;
    var_08 = scripts\common\trace::ai_trace_passed(var_04, var_07, undefined, [self, self.melee.target], undefined, 4);
    return var_08;
  }

  return 0;
}

func_B61B(param_00, param_01, param_02, param_03) {
  lib_0F3D::func_D394();
  self.var_E0 = 1;
  self.ignoreme = 1;
  lib_0F3D::func_B60F();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  if(isDefined(self.var_394)) {
    self.meleegrabweapon = self.var_394;
  }

  scripts\anim\shared::placeweaponon(self.var_394, "none");
  scripts\aitypes\melee::func_B5B4(self.unittype);
  thread func_D3F9();
  self playSound("c6_grapple_grab_enter");
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_D3F9() {
  if(isDefined(self.var_72CE)) {
    var_00 = (0, self.var_72CE, 0);
  } else {
    var_00 = vectortoangles(self.origin - level.player.origin);
    var_00 = (0, var_00[1], 0);
  }

  var_01 = lib_0F3D::func_108F6();
  var_01.angles = var_00;
  level.player.melee.partner = self;
  level.player.melee.var_E505 = var_01;
  var_02 = clearpotentialthreat();
  level.player playrumbleonentity("heavy_2s");
  var_03 = "meleeAnim";
  var_01 _meth_82E4(var_03, var_02["chokePlayer"], var_01.var_E6E5, 1, 0.2, 1);
  level.player notify("choke_scene_music");
  thread func_D3F8(var_01);
  var_04 = getanimlength(var_02["chokePlayer"]);
  level.player thread lib_0F3D::func_B611(var_04);
  if(getdvarint("exec_review") > 0) {
    thread func_68D0(var_04);
  }

  var_01 thread scripts\sp\anim::func_10CBF(var_01, var_03);
  var_01 scripts\anim\shared::donotetracks(var_03);
}

func_68D0(param_00) {
  wait(param_00 - 0.1);
  level.player.melee.var_46B6 = 1;
  if(isDefined(level.player.melee.var_B5FE)) {
    level.player thread lib_0F3D::func_46B5(0.1);
  }

  level.player notify("bt_meleegrab_slowmo");
}

func_D3F8(param_00) {
  level.player endon("meleegrab_interupt");
  var_01 = 0.2;
  param_00 thread func_B615(self);
  level.player playerlinktoblend(param_00, "tag_player", var_01, 0, var_01);
  level.player viewkick(10, self.origin);
  self linktoblendtotag(param_00, "tag_sync", 1, 0);
  wait(var_01);
  if(!isalive(self)) {
    return;
  }

  level.player _meth_84FE();
  thread lib_0F3D::func_5103(0.5, 2, 20, 10, 5, 60, 10, 0.1);
  thread lib_0F3D::func_5103(1, 2, 20, 4, 50, 90, 10, 0.1);
  thread lib_0F3D::func_510F(1, 50, 0.4);
  param_00 show();
  level.player thread lib_0F3D::func_D3A3();
  level.player playerlinktodelta(param_00, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.2, 0, 0, 15, 5, 30, 5);
  thread func_D395();
}

func_B615(param_00) {
  self endon("death");
  level.player endon("bt_stop_meleegrab");
  while(!func_B60E(param_00)) {
    wait(0.05);
  }

  level.player notify("meleegrab_interupt");
  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_B5FE)) {
    level.player lib_0F3D::func_46B5();
  }

  if(!isalive(param_00)) {
    param_00 func_B5FA();
  } else {
    param_00.var_E0 = 0;
    param_00.ignoreme = 0;
    param_00 scripts\anim\shared::placeweaponon(param_00.var_394, "right");
    param_00 func_B5FA();
  }

  thread lib_0F3D::func_50E8(0.2);
  thread lib_0F3D::func_510F(0.25, 65, 0.4);
  setslowmotion(1, 1, 0);
  lib_0F3D::func_D3D2();
  level.player unlink();
  self delete();
}

func_B60E(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(isDefined(param_00.var_2029)) {
    return 1;
  }

  if(isDefined(level.player.var_93B5) && level.player.var_93B5 == 1) {
    return 1;
  }

  return 0;
}

func_D395() {
  wait(0.1);
  var_00 = level.player.origin + anglesToForward(level.player.angles) * -100;
  screenshake(var_00, 10, 2, 1, 0.4, 0.2, 0.2, 700, 0.2, 1, 1);
  wait(0.5);
  var_00 = level.player.origin + anglesToForward(level.player.angles) * 100;
  screenshake(var_00, 10, 2, 1, 0.6, 0.3, 0.3, 700, 0.2, 1, 1);
}

func_B61E(param_00, param_01, param_02, param_03) {
  if(isDefined(level.player.gs.var_B639.var_72DC)) {
    level.player.gs.var_B639.var_EB7B = level.player.gs.var_B639.var_72DC;
    return 1;
  }

  if(scripts\sp\utility::func_7E72() == "fu") {
    return 0;
  }

  var_04 = gettime();
  if(isDefined(level.player.gs.var_B639.var_B63B) && var_04 < level.player.gs.var_B639.var_B63B) {
    return 0;
  }

  if(level.player.gs.var_B63C <= 0) {
    return 0;
  }

  var_05 = func_7BCF();
  if(var_05.size == 0) {
    return 0;
  }

  var_05 = scripts\sp\utility::array_removedeadvehicles(var_05);
  var_06 = (40, -55, 0);
  var_07 = self.origin + rotatevector(var_06, self.angles);
  if(!navisstraightlinereachable(self _meth_84AC(), var_07, self)) {
    return 0;
  }

  var_08 = squared(2000);
  var_09 = [];
  foreach(var_0B in var_05) {
    var_0C = distancesquared(level.player.origin, var_0B.origin);
    if(var_0C > var_08) {
      continue;
    }

    if(var_0B _meth_81A6() || var_0B scripts\sp\utility::isactorwallrunning()) {
      continue;
    }

    if(isDefined(var_0B.melee)) {
      continue;
    }

    if(var_0B islinked()) {
      continue;
    }

    if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0B.origin, 0.173648)) {
      continue;
    }

    if(var_05.size > 1 && isDefined(level.player.gs.var_B639.var_A9E8) && level.player.gs.var_B639.var_A9E8 == var_0B) {
      continue;
    }

    var_09[var_09.size] = var_0B;
  }

  if(var_09.size > 0) {
    level.player.gs.var_B639.var_EB7B = scripts\engine\utility::random(var_09);
    level.player.gs.var_B639.var_A9E8 = level.player.gs.var_B639.var_EB7B;
    level.player.gs.var_B63C--;
    level.player.gs.var_B639.var_B63B = var_04 + level.player.gs.var_B63A;
    if(isDefined(level.player.melee.var_B5FE)) {
      level.player thread lib_0F3D::func_46B5();
    }

    return 1;
  }

  return 0;
}

func_7BCF() {
  var_00 = [];
  var_01 = getaiarray("allies");
  var_02 = ["eth", "slt", "omr"];
  foreach(var_04 in var_01) {
    foreach(var_06 in var_02) {
      if(var_04.npcid == var_06) {
        var_00[var_00.size] = var_04;
      }
    }
  }

  return var_00;
}

func_B61D(param_00, param_01, param_02, param_03) {
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_B60D(param_00, param_01, param_02, param_03) {
  if(isDefined(anim)) {
    if(isplayer(self.melee.target)) {
      level.var_B5F7[self.unittype] = gettime();
    } else {
      level.var_B5F8[self.unittype] = gettime();
    }
  }

  func_B5FA();
}

func_B5FA() {
  if(isalive(self)) {
    self.var_87F6 = 1;
    self.ignoreme = 0;
    scripts\asm\asm_bb::bb_clearmeleerequest();
    scripts\aitypes\melee::melee_destroy();
  }
}

func_B61F(param_00, param_01, param_02, param_03) {
  var_04 = getanimentrycount();
  var_05 = clearpotentialthreat();
  var_06 = "meleeSave";
  var_07 = "chokePlayer_save";
  var_08 = var_05[var_07];
  var_09 = level.player.melee.var_E505;
  var_0A = level.player.gs.var_B639.var_EB7B;
  var_0A.asm.var_EB67 = var_04[var_0A.npcid + "_save"];
  var_0A.allowpain = 0;
  var_0A.ignoreme = 1;
  var_0A setCanDamage(0);
  thread lib_0F3D::func_50E8(0.5);
  thread lib_0F3D::func_510F(0.5, 65, 0.4);
  var_09 _meth_82E4(var_06, var_08, var_09.var_E6E5, 1, 0.2, 1);
  var_09 thread scripts\sp\anim::func_10CBF(var_09, var_06);
  var_09 thread scripts\anim\shared::donotetracks(var_06, ::func_B617);
  var_0B = self gettagorigin("tag_sync");
  var_0C = self gettagangles("tag_sync");
  var_0A dontinterpolate();
  var_0A _meth_80F1(var_0B, var_0C);
  var_0A.var_B650 = spawn("script_model", var_0B);
  var_0A.var_B650 setModel("tag_origin");
  var_0A.var_B650.angles = var_0C;
  var_0A.var_B650 linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  level.player thread func_B062();
  var_0A linktoblendtotag(var_0A.var_B650, "tag_origin", 1, 0);
  var_0A lib_0A1E::func_2307(::func_EB7C, ::saviorcleanup);
  var_0D = lib_0A1E::asm_getallanimsforstate(param_00, param_01);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  self _meth_82E7(param_01, var_0D, 1, param_02, 1);
  thread scripts\sp\anim::func_10CBF(self, param_01);
  var_0E = lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
  if(var_0E == "end") {
    thread scripts\asm\asm::func_2310(param_00, param_01, 0);
  }
}

func_B062() {
  level.player endon("bt_stop_loopscreenshake");
  for(;;) {
    var_00 = level.player.origin + anglesToForward(level.player.angles) * 100;
    screenshake(var_00, 10, 15, 10, 1, 0.5, 0.5, 1000, 3, 1, 1);
    wait(1);
  }
}

func_B61C(param_00, param_01, param_02, param_03) {
  level.player endon("meleegrab_interupt");
  var_04 = clearpotentialthreat();
  var_05 = undefined;
  var_06 = randomfloatrange(0, 1);
  if(var_06 <= 0.33) {
    var_07 = "chokePlayer_counter";
    var_08 = lib_0A1E::func_2356("melee_playerCounter", var_07);
  } else if(var_08 >= 0.67) {
    var_07 = "chokePlayer_counter_b";
    var_08 = lib_0A1E::func_2356("melee_playerCounter", var_08);
  } else {
    var_07 = "chokePlayer_counter_c";
    var_08 = lib_0A1E::func_2356("melee_playerCounter", var_08);
    var_09 = _meth_80A1();
    var_05 = var_09[var_07];
  }

  var_0A = "meleeCounter";
  var_0B = var_04[var_07];
  var_0C = level.player.melee.var_E505;
  thread lib_0F3D::func_50E8(0.5);
  thread lib_0F3D::func_510F(0.5, 65, 0.4);
  var_0C _meth_82E4(var_0A, var_0B, var_0C.var_E6E5, 1, 0.2, 1);
  var_0C thread scripts\sp\anim::func_10CBF(var_0C, var_0A);
  var_0C thread scripts\anim\shared::donotetracks(var_0A, ::func_B617);
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  if(isDefined(var_05)) {
    thread func_3675(param_01, var_05, param_02);
  }

  self _meth_82E7(param_01, var_08, 1, param_02, 1);
  thread scripts\sp\anim::func_10CBF(self, param_01);
  var_0D = lib_0A1E::func_231F(param_00, param_01, scripts\asm\asm::func_2341(param_00, param_01));
}

func_3675(param_00, param_01, param_02) {
  var_03 = spawn("script_model", self.origin);
  var_03 setModel("robot_c6_cable");
  var_03.var_1FBB = "script_model";
  var_03 glinton(#animtree);
  var_03.origin = self gettagorigin("j_head_pv_z");
  var_03.angles = self gettagangles("j_head_pv_z");
  var_03 linkto(self, "j_head_pv_z");
  var_03 _meth_82E7(param_00, param_01, 1, param_02, 1);
  scripts\engine\utility::waittill_notify_or_timeout("death", 7);
  if(isDefined(var_03)) {
    var_03 delete();
  }
}

func_EB7C() {
  self endon("killanimscript");
  var_00 = "meleeSave";
  self _meth_82E4(var_00, self.asm.var_EB67, lib_0A1E::func_2342(), 1, 0.2, 1);
  thread scripts\sp\anim::func_10CBF(self, var_00);
  var_01 = getanimlength(self.asm.var_EB67) + 1;
  scripts\anim\notetracks::donotetrackswithtimeout(var_00, var_01, ::func_B617);
}

saviorcleanup() {
  self setCanDamage(1);
  self.allowpain = 1;
  self.ignoreme = 0;
  self.asm.var_EB67 = undefined;
  self unlink();
  self notify("melee_save_complete");
  if(isDefined(self.var_B650)) {
    self.var_B650 delete();
  }
}

func_B61A(param_00, param_01, param_02, param_03) {
  level.player thread lib_0F3D::func_46B5();
  var_04 = clearpotentialthreat();
  var_05 = "meleeKillPlayer";
  var_06 = "chokePlayer_kill";
  var_07 = var_04[var_06];
  var_08 = level.player.melee.var_E505;
  thread lib_0F3D::func_50E8(0.5);
  thread lib_0F3D::func_510F(0.5, 65, 0.4);
  var_08 _meth_82E4(var_05, var_07, var_08.var_E6E5, 1, 0.2, 1);
  var_08 thread scripts\sp\anim::func_10CBF(var_08, var_05);
  var_08 thread scripts\anim\shared::donotetracks(var_05, ::func_B617);
  self playSound("c6_grapple_punch");
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_B617(param_00) {
  switch (param_00) {
    case "unlink":
      self unlink();
      break;

    case "player_unlink":
      func_D456();
      break;

    case "attach_knife":
      self attach(level.var_EC8C["asm_viewmodel_knife"], "tag_accessory_right", 1);
      break;

    case "knife_stab":
      playFXOnTag(level.var_7649["bt_c6_knife_counter_stab"], self, "tag_knife_fx");
      thread func_A707();
      break;

    case "detach_knife":
      self detach(level.var_EC8C["asm_viewmodel_knife"], "tag_accessory_right");
      break;

    case "headgib":
      var_01 = spawnStruct();
      var_01.updategamerprofileall = "head";
      lib_0BFE::func_EF2B(var_01);
      self.var_E0 = 0;
      self.ignoreme = 0;
      self.var_10265 = 1;
      self.asm.var_4E40 = ::func_B614;
      self _meth_81D0();
      if(isDefined(self.var_B63D)) {
        self.var_B63D unlink();
      }
      break;

    case "player_kick_off":
      self.var_3135.var_55CE = 1;
      self.var_3135.var_55CF = 1;
      self.var_E0 = 0;
      thread lib_0BFE::func_4D64();
      self setCanDamage(1);
      self playSound("c6_grapple_kick_pain");
      break;

    case "kill_c6":
      self.var_E0 = 0;
      self.ignoreme = 0;
      self.var_10265 = 1;
      self.asm.var_4E40 = ::func_B613;
      self playSound("c6_grapple_knife_death");
      self _meth_81D0();
      break;

    case "player_kill":
      level.player notify("bt_stop_meleegrab");
      func_E128();
      setblur(10, 0.1);
      level.player _meth_80A1();
      level.player _meth_81D0();
      break;

    case "disable_weapons":
      level.player getradiuspathsighttestnodes();
      level.player viewkick(10, self.origin);
      break;

    case "rm_damage_heavy":
      if(scripts\engine\utility::cointoss()) {
        level.player playrumbleonentity("heavy_1s");
        return;
      }
      level.player playrumbleonentity("light_1s");
      break;
  }
}

func_A707() {
  var_00 = ["c6_grapple_knife_pain_01", "c6_grapple_knife_pain_02", "c6_grapple_knife_pain_03"];
  if(isalive(level.player)) {
    if(isDefined(level.player.melee) && isDefined(level.player.melee.partner)) {
      level.player.melee.partner playSound(var_00[randomintrange(0, 3)]);
    }
  }
}

func_D456() {
  level.player endon("death");
  level.player unlink();
  level.player _meth_84FD();
  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_E505)) {
    level.player.melee.var_E505 delete();
  }

  level.player notify("bt_stop_loopscreenshake");
  level.player notify("bt_stop_meleegrab");
  if(isDefined(level.player)) {
    if(isDefined(level.player.melee) && isDefined(level.player.melee.partner)) {
      var_00 = vectornormalize(level.player.origin - level.player.melee.partner.origin);
      var_00 = var_00 * 100;
      level.player setvelocity(var_00);
    }
  }

  lib_0F3D::func_D3D2();
}

func_B614() {
  func_B5FA();
  self waittillmatch("start_ragdoll", "melee_savePlayer");
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  wait(0.2);
  return 1;
}

func_B613() {
  if(isDefined(self.meleegrabweapon)) {
    self dropweapon(self.meleegrabweapon, "right", 0);
  }

  func_B5FA();
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  self giverankxp();
  wait(0.05);
  return 1;
}

func_3386(param_00, param_01, param_02, param_03) {
  lib_0C64::func_B57F();
  return 1;
}

func_335A(param_00, param_01) {
  var_02 = self.melee.target;
  var_03 = var_02.origin;
  var_04 = vectortoangles(var_03 - self.origin);
  self.melee.var_10D6D = var_04;
  var_02.melee.var_10E0E = var_02.angles[1];
  return 1;
}

func_3366(param_00, param_01, param_02, param_03) {
  var_04 = self.melee.target;
  if(!isDefined(var_04)) {
    return 0;
  }

  if(!isalive(var_04)) {
    return 0;
  }

  var_05 = param_03;
  if(self.melee.var_13D8A != var_05) {
    return 0;
  }

  var_06 = self[[self.var_7191]](param_00, param_02);
  if(!func_335A(param_01 + "_victim", var_06)) {
    return 0;
  }

  self.melee.target.melee.var_331C = 1;
  return 1;
}

func_4885(param_00, param_01, param_02, param_03) {
  self.var_E0 = 1;
  self.ignoreme = 1;
  self.var_3135.crawlmeleegrab = 1;
  self getplayermodelindex();
  lib_0F3D::func_D394("crawlmelee");
  lib_0F3D::func_B60F();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread func_D3EC();
  self.var_3135.var_F1F9 = undefined;
  self.var_3135.var_55CE = 1;
  self.var_3135.var_55CF = 1;
  self stoploopsound();
  level.player playSound("c6_grapple_crawl_takedown");
  self playSound("c6_grapple_grab_grunt");
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_D3EC() {
  level.player endon("crawlmeleegrab_interrupt");
  var_00 = vectortoangles(self.origin - level.player.origin);
  var_00 = (0, var_00[1], 0);
  var_01 = lib_0F3D::func_108F6();
  var_01.angles = var_00;
  level.player.melee.partner = self;
  level.player.melee.var_E505 = var_01;
  var_02 = clearpotentialthreat();
  var_03 = "meleeAnim";
  var_01 _meth_82E4(var_03, var_02["crawlMeleeGrab"], var_01.var_E6E5, 1, 0.2, 1);
  var_01 thread func_4884(self);
  thread func_487D(var_01);
  level.player forceplaygestureviewmodel("ges_crawlmelee_enter", undefined, undefined, undefined, 1);
  var_01 thread scripts\sp\anim::func_10CBF(var_01, var_03);
  var_01 scripts\anim\shared::donotetracks(var_03);
}

func_D3EB(param_00) {
  level.player endon("stop_crawlmelee_loop");
  level.player endon("crawlmeleegrab_interrupt");
  param_00 thread scripts\engine\utility::play_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  var_01 = clearpotentialthreat();
  var_02 = var_01["crawlMeleeGrab_loop"];
  level.player forceplaygestureviewmodel("ges_crawlmelee_grabbed");
  var_03 = "crawMeleeGrabLoop";
  while(isDefined(level.player.melee)) {
    level.player.melee.var_E505 _meth_82E7(var_03, var_02, 1, 0.2, 1);
    level.player.melee.var_E505 scripts\anim\shared::donotetracks(var_03);
  }
}

func_487D(param_00) {
  level.player endon("crawlmeleegrab_interrupt");
  var_01 = 0.2;
  level.player playerlinktoblend(param_00, "tag_player", var_01, 0, var_01);
  wait(var_01);
  self linktoblendtotag(param_00, "tag_sync", 1, 0);
  func_17CD(param_00);
  var_02 = level.player getcurrentprimaryweapon();
  if(isDefined(var_02)) {
    var_03 = weaponclass(var_02);
    var_04 = ["rifle", "smg", "pistol", "spread", "mg"];
    if(scripts\engine\utility::array_contains(var_04, var_03)) {
      var_05 = weaponclipsize(var_02);
      var_06 = level.player getweaponammoclip(var_02);
      var_07 = int(var_05 * 0.35);
      if(var_06 <= int(var_05 * 0.4)) {
        level.player setweaponammoclip(var_02, var_06 + var_07);
      }
    }
  }

  level.player _meth_84FE();
  thread lib_0F3D::func_5103(1.5, 1, 50, 100, 15, 100, 5, 1.5);
  param_00 show();
  level.player thread lib_0F3D::func_D3A3();
  level.player playerlinktodelta(param_00, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 30, 30, 10);
  thread func_D395();
}

func_4884(param_00) {
  self endon("death");
  thread func_933D();
  while(!func_4883(param_00)) {
    wait(0.05);
  }

  level.player notify("crawlmeleegrab_interrupt");
  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_B5FE)) {
    level.player lib_0F3D::func_46B5();
  }

  if(!isalive(param_00)) {
    param_00 func_B5FA();
  } else {
    if(isDefined(param_00.var_3135.var_6B4B)) {
      param_00.health = param_00.var_3135.var_6B4B;
    }

    param_00.var_E0 = 0;
    param_00 scripts\anim\shared::placeweaponon(param_00.var_394, "right");
    param_00 func_B5FA();
  }

  func_E128();
  thread lib_0F3D::func_50E8(0.2);
  thread lib_0F3D::func_510F(0.25, 65, 0.4);
  setslowmotion(1, 1, 0);
  level.player unlink();
  level.player notify("crawlgrabmelee_cleanup");
  self delete();
}

func_933D() {
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
  level.player scripts\sp\utility::func_1C34(1);
}

func_4883(param_00) {
  if(isDefined(param_00.var_2029)) {
    return 1;
  }

  if(isDefined(level.player.var_93B5) && level.player.var_93B5 == 1) {
    return 1;
  }

  return 0;
}

func_17CD(param_00) {
  level.player.var_8675 = spawn("script_origin", level.player.origin);
  level.player.var_8675 linkto(param_00, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player getwholescenedurationmin(level.player.var_8675);
}

func_E128() {
  if(!isDefined(level.player.var_8675)) {
    return;
  }

  level.player getwholescenedurationmin(undefined);
  level.player.var_8675 delete();
}

func_4886(param_00, param_01, param_02, param_03) {
  level.player endon("crawlmeleegrab_interrupt");
  level.player thread func_4887(self);
  self.var_3135.var_6B4B = self.health;
  self.health = -15536;
  level.player thread func_D3EB(self);
  lib_0A1E::func_235F(param_00, param_01, param_02, 1);
}

func_4887(param_00) {
  level.player endon("crawlmeleegrab_interrupt");
  var_01 = gettime() + 5000;
  param_00.var_E0 = 0;
  var_02 = -15536;
  var_03 = 0;
  while(gettime() < var_01) {
    wait(0.05);
    var_04 = var_02 - param_00.health;
    if(var_04 != var_03) {
      if(param_00.var_DE == "MOD_MELEE") {
        param_00 playSound("c6_grapple_hit_pain");
        var_02 = var_02 + 85;
        var_04 = var_02 - param_00.health;
        var_03 = var_04;
      } else if(scripts\engine\utility::cointoss()) {
        param_00 playSound("c6_grapple_shot_pain_01");
      } else {
        param_00 playSound("c6_grapple_shot_pain_02");
      }
    }

    if(var_04 >= param_00.var_3135.var_6B4B) {
      level.player.melee.var_46B6 = 1;
      return;
    }
  }

  if(getdvarint("exec_review") > 0) {
    level.player.melee.var_46B6 = 1;
    return;
  }

  level.player.melee.var_46B6 = 0;
}

func_488A(param_00, param_01, param_02, param_03) {
  level.player notify("stop_crawlmelee_loop");
  scripts\engine\utility::stop_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  self playSound("c6_grapple_crawl_win_collapse");
  level.player thread func_488B();
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  lib_0A1E::func_2364(param_00, param_01, param_02);
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "c6_grapple_crawl_win_foley");
}

func_488B() {
  var_00 = level.player.melee.var_E505;
  var_01 = clearpotentialthreat();
  var_02 = "crawlMeleeCounter";
  thread lib_0F3D::func_50E8(1);
  level.player _meth_80A6();
  level.player stopgestureviewmodel("ges_crawlmelee_grabbed");
  var_00 _meth_82E4(var_02, var_01["crawlMeleeGrab_win"], var_00.var_E6E5, 1, 0.2, 1);
  var_00 thread scripts\sp\anim::func_10CBF(var_00, var_02);
  var_00 scripts\anim\shared::donotetracks(var_02, ::func_B617);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(0);
  level.player unlink();
  func_E128();
  var_00 delete();
  level.player _meth_84FD();
  level.player enableoffhandweapons();
  level.player allowoffhandshieldweapons(1);
  level.player enableusability();
  wait(0.2);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowstand(1);
  level.player scripts\sp\utility::func_1C34(1);
  level.player notify("crawlgrabmelee_cleanup");
}

func_4888(param_00, param_01, param_02, param_03) {
  self.var_E0 = 1;
  level.player notify("stop_crawlmelee_loop");
  scripts\engine\utility::stop_loop_sound_on_entity("c6_grapple_crawl_struggle_lp");
  var_04 = clearpotentialthreat();
  var_05 = "crawlMeleeKill";
  level.player.melee.var_E505 _meth_82E4(var_05, var_04["crawlMeleeGrab_lose"], level.player.melee.var_E505.var_E6E5, 1, 0.2, 1);
  level.player.melee.var_E505 thread scripts\sp\anim::func_10CBF(level.player.melee.var_E505, var_05);
  level.player.melee.var_E505 thread scripts\anim\shared::donotetracks(var_05, ::func_B617);
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "c6_grapple_crawl_lose_pound_01");
  level.player scripts\engine\utility::delaycall(0.7, ::playsound, "c6_grapple_crawl_lose_pound_02");
  level.player scripts\engine\utility::delaycall(1.5, ::playsound, "c6_grapple_crawl_lose_pound_03");
  self clearanim(lib_0A1E::asm_getbodyknob(), param_02);
  lib_0A1E::func_2364(param_00, param_01, param_02);
}

func_D906() {}