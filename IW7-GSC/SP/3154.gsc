/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3154.gsc
*********************************************/

func_F130() {
  var_0 = [];
  var_0["seekerMeleeGrab"] = % equip_seeker_attack_player;
  var_0["seekerMeleeGrab_win"] = % equip_seeker_attack_win_player;
  var_0["seekerMeleeGrab_lose"] = % equip_seeker_attack_lose_player;
  return var_0;
}

func_F127(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;
  if(isplayer(var_4)) {
    return 0;
  }

  self.melee.var_13D8A = 1;
  var_4.melee.var_13D8A = 0;
  var_5 = func_F14B(self, self.melee.target);
  self.melee.var_F2 = var_5[0];
  self.melee.offset = var_5[1];
  var_4.melee.var_F2 = self.melee.var_F2;
  var_6 = func_3EB4(var_0, var_2, self.melee.var_F2);
  var_7 = vectortoyaw(self.origin - self.melee.target.origin);
  var_8 = (0, self.melee.offset + var_7, 0);
  self.melee.var_10D6D = self.angles;
  var_4.melee.var_10D6D = var_8;
  var_4.ignoreme = 1;
  self.ignoreme = 1;
  self notify("meleegrab_start");
  self.bt.var_1152B = 1;
  return 1;
}

func_F14B(var_0, var_1) {
  var_2 = var_1.angles;
  var_3 = var_1.origin;
  var_4 = var_0.origin;
  var_5 = vectortoangles(var_4 - var_3);
  var_6 = angleclamp(var_2[1] - var_5[1]);
  if(var_6 > 315 || var_6 < 45) {
    return ["front", 0];
  }

  if(var_6 < 135) {
    return ["right", 90];
  }

  if(var_6 > 225) {
    return ["left", -90];
  }

  return ["back", 180];
}

func_3EB4(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "jump_" + var_2);
}

func_3EB5(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "loop_" + var_2);
}

func_F172() {
  var_0 = 0.7071;
  for(;;) {
    wait(0.05);
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_0)) {
      self notify("on_screen");
      return;
    }
  }
}

func_F836() {
  self.var_2479 = 1;
}

func_13132(var_0) {
  switch (var_0) {
    case "w2":
    case "w1":
    case "w0":
    case "5":
    case "4":
    case "3":
    case "2":
    case "0":
    case "1":
    case "omr":
    case "slt":
      return 1;
  }

  return 0;
}

func_D4CE(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee.var_312F = 1;
  var_4 = self.melee.target;
  var_5 = func_3EB4(var_0, var_1, self.melee.var_F2);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  lib_0F42::func_B5CB(var_1, 1);
  if(!isDefined(var_4.var_F184)) {
    var_4.var_F184 = 1;
    if(isDefined(var_4.var_46BC) && isDefined(var_4.npcid) && var_4.var_46BC == "UN" || var_4.var_46BC == "SD") {
      if(func_13132(var_4.npcid) && !isDefined(level.var_93A9)) {
        var_6 = var_4.var_46BC + "_" + var_4.npcid + "_reaction_seeker_attack";
        var_4 playSound(var_6);
      }
    }
  }

  var_7 = [self];
  var_4 scripts\asm\asm::asm_setstate(var_1 + "_victim", var_7);
  createnavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor", -1, self, 250, 1, self.bt.var_652A);
  self animmode("zonly_physics");
  self linktoblendtotag(self.melee.target, "tag_sync", 0, 0);
  self clearanim(lib_0A1E::asm_getbodyknob(), 0);
  self _meth_82EA(var_1, var_5, 1, 0, 1);
  scripts\engine\utility::delaythread(0.25, ::func_F836);
  var_8 = lib_0A1E::func_231F(var_0, var_1, ::lib_0C64::func_B590);
  var_9 = func_3EB5(var_0, var_1, self.melee.var_F2);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_9, 1, var_2, 1);
  childthread func_F172();
  scripts\engine\utility::waittill_notify_or_timeout("on_screen", 1.5);
  wait(0.4);
  playworldsound("seeker_expl_beep", self.origin);
  wait(0.6);
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
  self.var_9BB9 = 1;
  thread lib_0E26::func_F11E();
}

func_D4CF(var_0, var_1, var_2) {
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
  if(isDefined(self.melee.target)) {
    if(isDefined(self.melee.target.melee)) {
      self.melee.target.melee.var_2720 = 1;
    }

    self.melee.target.ignoreme = 0;
  }
}

func_F148(var_0, var_1, var_2, var_3) {
  level.player.var_E0 = 1;
  self.var_55B1 = 1;
  self.ignoreme = 1;
  scripts\sp\utility::func_9193("default_seeker");
  lib_0F3D::func_B60F();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread func_F153();
  lib_0A1E::func_2364(var_0, var_1, 0);
}

func_F153() {
  if(isDefined(self.var_72CE)) {
    var_0 = (0, self.var_72CE, 0);
  } else {
    var_0 = vectortoangles(self.origin - level.player.origin);
    var_0 = (0, var_0[1], 0);
  }

  var_1 = lib_0F3D::func_108F6();
  var_1.angles = var_0;
  self notify("jumped_on_player");
  playworldsound("seeker_expl_beep", self.origin);
  level.player.melee.partner = self;
  level.player.melee.var_E505 = var_1;
  var_2 = func_F130();
  var_3 = "meleeAnim";
  var_1 _meth_82E4(var_3, var_2["seekerMeleeGrab"], var_1.var_E6E5, 1, 0, 1);
  thread func_F152(var_1);
  var_4 = getanimlength(var_2["seekerMeleeGrab"]);
  thread func_F142(1.25, 0.75);
  var_1 thread scripts\sp\anim::func_10CBF(var_1, var_3);
  var_1 scripts\anim\shared::donotetracks(var_3);
}

func_F142(var_0, var_1) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  scripts\engine\utility::waittill_notify_or_timeout_return("death", var_0);
  if(!isDefined(level.player.melee)) {
    return;
  }

  lib_0E46::func_48C4("j_body", undefined, undefined, undefined, 1000, 1000, 1, 1);
  var_2 = func_F13F(var_1);
  if(!isDefined(level.player) || !isDefined(level.player.melee)) {
    return;
  }

  level.player.melee.var_46B6 = var_2;
  lib_0E46::func_DFE3();
}

func_F13F(var_0) {
  self endon("meleegrab_interupt");
  var_0 = var_0 * 1000;
  var_1 = 1;
  var_2 = 0.4;
  var_3 = var_1;
  var_4 = undefined;
  for(;;) {
    var_5 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", var_3);
    if(isDefined(var_5) && var_5 == "timeout") {
      break;
    }

    if(!isDefined(var_4)) {
      var_4 = gettime();
    }

    if(gettime() - var_4 > var_0) {
      return 1;
    }

    var_3 = var_2;
  }

  return 0;
}

func_F146() {
  self endon("meleegrab_interupt");
  for(;;) {
    level.player playrumbleonentity("damage_light");
    earthquake(0.15, 0.1, level.player.origin, 5000);
    wait(0.05);
  }
}

func_F143() {
  var_0 = spawn("script_model", self.origin);
  var_0 linkto(self, "j_hip_le", (0, 0, 0), (0, 0, 0));
  var_0 lib_0E46::func_48C4(undefined, undefined, "", undefined, undefined, undefined, 1, 1);
  self waittill("meleegrab_interupt");
  var_0 lib_0E46::func_DFE3();
}

func_F141(var_0) {
  level.player endon("meleegrab_interupt");
  var_1 = 0.2;
  var_2 = 0.3;
  wait(var_0 - var_1 - 0.05);
  if(isDefined(self.melee.var_B5FE)) {
    self.melee.var_B5FE destroy();
  }

  self.melee.var_B5FE = newclienthudelem(level.player);
  self.melee.var_B5FE.color = (1, 1, 1);
  self.melee.var_B5FE settext(&"SCRIPT_PLATFORM_HINT_MELEE_TAP");
  self.melee.var_B5FE.x = 0;
  self.melee.var_B5FE.y = 20;
  self.melee.var_B5FE.alignx = "center";
  self.melee.var_B5FE.aligny = "middle";
  self.melee.var_B5FE.horzalign = "center";
  self.melee.var_B5FE.vertalign = "middle";
  self.melee.var_B5FE.foreground = 1;
  self.melee.var_B5FE.alpha = 0;
  self.melee.var_B5FE.fontscale = 0.5;
  self.melee.var_B5FE.playrumblelooponposition = 1;
  self.melee.var_B5FE.sort = -1;
  self.melee.var_B5FE endon("death");
  self.melee.var_B5FE fadeovertime(var_1);
  self.melee.var_B5FE changefontscaleovertime(var_1);
  self.melee.var_B5FE.fontscale = 1.3;
  self.melee.var_B5FE.alpha = 1;
  wait(var_1);
  if(!isDefined(self.melee.var_B5FE)) {
    return;
  }

  self.melee.var_B5FE fadeovertime(var_2);
  self.melee.var_B5FE changefontscaleovertime(var_2);
  self.melee.var_B5FE.fontscale = 1.2;
}

func_F152(var_0) {
  var_1 = 0.3;
  var_0 thread func_F144(self);
  level.player playerlinktoblend(var_0, "tag_player", var_1, 0, var_1);
  level.player viewkick(5, self.origin);
  lib_0F3D::func_D394("seeker");
  self linktoblendtotag(var_0, "tag_sync", 0, 0);
  wait(var_1);
  if(!isalive(self)) {
    return;
  }

  level.player _meth_84FE();
  thread lib_0F3D::func_5103(0.5, 2, 20, 10, 5, 60, 10, 0.1);
  thread lib_0F3D::func_5103(1, 2, 20, 4, 50, 90, 10, 0.1);
  thread lib_0F3D::func_510F(1, 50, 0.4);
  var_0 show();
  level.player thread lib_0F3D::func_D3A3();
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 20, 30, 0);
  thread func_F151();
}

func_F151() {
  wait(0.1);
  var_0 = level.player.origin + anglesToForward(level.player.angles) * -100;
  screenshake(var_0, 10, 2, 1, 0.4, 0.2, 0.2, 700, 0.2, 1, 1);
  wait(0.5);
  var_0 = level.player.origin + anglesToForward(level.player.angles) * 100;
  screenshake(var_0, 10, 2, 1, 0.6, 0.3, 0.3, 700, 0.2, 1, 1);
}

func_F145(var_0) {
  switch (var_0) {
    case "unlink":
      self unlink();
      break;

    case "disable_weapons":
      level.player getradiuspathsighttestnodes();
      level.player viewkick(10, self.origin);
      break;
  }
}

func_F144(var_0) {
  self endon("death");
  level.player endon("bt_stop_meleegrab");
  while(!func_F140(var_0)) {
    wait(0.05);
  }

  level.player notify("meleegrab_interupt");
  if(isDefined(level.player.melee) && isDefined(level.player.melee.var_B5FE)) {
    level.player.melee.var_B5FE destroy();
  }

  thread lib_0F3D::func_50E8(0.2);
  thread lib_0F3D::func_510F(0.25, 65, 0.4);
  lib_0F3D::func_D3D2();
  level.player.var_E0 = 0;
  level.player.ignoreme = 0;
  level.player setCanDamage(1);
  level.player unlink();
  self delete();
}

func_F140(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(isDefined(var_0.var_2029)) {
    return 1;
  }

  return 0;
}

func_F149(var_0, var_1, var_2, var_3) {
  var_4 = func_F130();
  var_5 = var_4["seekerMeleeGrab_win"];
  var_6 = level.player.melee.var_E505;
  thread lib_0F3D::func_50E8(0.2);
  thread lib_0F3D::func_510F(0.2, 65, 0.4);
  var_6 _meth_82E4("meleeCounter", var_5, var_6.var_E6E5, 1, 0.2, 1);
  var_6 thread scripts\sp\anim::func_10CBF(var_6, "meleeCounter");
  var_6 thread scripts\anim\shared::donotetracks("meleeCounter", ::func_F145);
  var_7 = lib_0A1E::asm_getallanimsforstate(var_0, var_1);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  playworldsound("seeker_expl_beep", self.origin);
  thread func_F116();
  self _meth_82E7(var_1, var_7, 1, var_2, 1);
  thread scripts\sp\anim::func_10CBF(self, var_1);
  lib_0A1E::func_231F(var_0, var_1, scripts\asm\asm::func_2341(var_0, var_1));
  func_F13E();
}

func_F13E(var_0) {
  if(isDefined(self.var_9BB9) && self.var_9BB9) {
    return;
  }

  level.player viewkick(50, self.origin);
  level.player getrankinfoxpamt();
  self.var_9BB9 = 1;
  thread lib_0E26::func_F11E(1, var_0);
  level.player thread post_meleeexplode();
}

post_meleeexplode() {
  wait(0.1);
  self _meth_80A1();
}

func_F116() {
  self endon("death");
  for(;;) {
    var_0 = self gettagorigin("j_body");
    wait(0.05);
    var_1 = scripts\common\trace::create_solid_ai_contents(1);
    var_2 = scripts\common\trace::ray_trace(var_0, self gettagorigin("j_body"), self, var_1);
    if(var_2["hittype"] != "hittype_none") {
      func_F13E(var_2["position"]);
      return;
    }
  }
}

func_F147(var_0, var_1, var_2, var_3) {
  level.player thread lib_0F3D::func_46B5();
  var_4 = func_F130();
  var_5 = var_4["seekerMeleeGrab_lose"];
  var_6 = level.player.melee.var_E505;
  wait(0.8);
  if(isDefined(self)) {
    self.var_9BB9 = 1;
    thread lib_0E26::func_F11E();
  }
}

func_D4D0(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.melee.var_312F = 1;
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.var_10D6D[1]);
  lib_0F42::func_B5CB(var_1, 0);
  thread lib_0C64::func_B5D7(var_1);
  var_4 = func_3EB4(var_0, var_1, self.melee.var_F2);
  self clearanim(lib_0A1E::asm_getbodyknob(), 0);
  self _meth_82EA(var_1, var_4, 1, 0, 1);
  lib_0A1E::func_2369(var_0, var_1, var_4);
  scripts\anim\face::saygenericdialogue("pain");
  var_5 = lib_0A1E::func_231F(var_0, var_1, ::lib_0C64::func_B590);
  var_6 = func_3EB5(var_0, var_1, self.melee.var_F2);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_6, 1, var_2, 1);
  childthread func_F16D();
  lib_0A1E::func_231F(var_0, var_1, ::lib_0C64::func_B590);
}

func_F16D() {
  var_0 = self.melee.partner;
  for(;;) {
    if(!isDefined(self.melee)) {
      break;
    }

    if(!isDefined(self.melee.partner) || !isalive(self.melee.partner)) {
      self.melee.var_2720 = 1;
      break;
    }

    wait(0.05);
  }
}