/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\suicidebomber\suicidebomber.gsc
***********************************************/

bomber_init(var_0, var_1, var_2) {
  scripts\asm\shared\utility::setbasearchetype("suicidebomber");

  if(self isscriptable())
    thread initscriptable();
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

shouldexplode(var_0, var_1, var_2, var_3) {
  return istrue(self.explode);
}

playanim_explode(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  var_5 = getanimlength(var_4);
  var_6 = getnotetracktimes(var_4, "explode")[0];

  if(isDefined(var_6))
    var_5 = var_5 * var_6;

  wait(var_5);

  if(isDefined(level.suicide_bomber_explode_func))
    self thread[[level.suicide_bomber_explode_func]](self);

  thread bomber_detonation();
}

playanim_bomberdeath(var_0, var_1, var_2) {
  if(!istrue(self.hasexploded) && !istrue(self.skipdetonation)) {
    if(!istrue(self.instantexplode)) {
      thread scripts\asm\soldier\death::playdeathanim(var_0, var_1);

      if(!isagent(self))
        wait 1.2;

      if(!isagent(self) || isalive(self))
        stopFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, "J_Wrist_LE");
    }

    if(!istrue(self.diequietly))
      bomber_detonation();
  }
}

bomber_detonation() {
  self.hasexploded = 1;

  if(getdvarint("NTMLLPTNLT")) {
    if(isDefined(self) && isDefined(self.grenadeweapon) && istrue(self.bomberusegrenade))
      var_0 = self magicgrenade(self.origin + (0, 0, 60), self.origin, 0.0, 0);
    else {
      playFX(level.g_effect["human_gib_fullbody"], self.origin);
      playFX(level.g_effect["vfx_suicide_bomber_gib_explode"], self.origin);
      self radiusdamage(self.origin + (0, 0, 60), 500, 250, 75, self);
      self playSound("vest_expl_trans");
    }
  } else {
    playFX(level.g_effect["vfx_suicide_bomber_no_dismember"], self.origin);
    self radiusdamage(self.origin + (0, 0, 60), 500, 250, 75, self);
    self playSound("vest_expl_trans");
  }

  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(1.0, 0.6, self.origin, 1500);
  self notify("detonated");
  waitframe();

  if(!isagent(self))
    self delete();
  else
    self kill();
}

bomber_finishpainhead(var_0, var_1, var_2) {
  scripts\asm\soldier\pain::cleanuppainanim(var_0, var_1, var_2);
  self kill();
}

playanim_bombermoveloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
  self aisetanim(var_1, var_3);
  thread blendspacerndm(var_1);

  for(;;)
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

blendspacerndm(var_0) {
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_1 = randomfloatrange(-1, 1);
    self setcivilianfocus(var_1);
    wait(randomfloatrange(0.25, 2));
  }
}

bomber_shouldraisearm(var_0, var_1, var_2, var_3) {
  return istrue(self.bomberraisearm);
}