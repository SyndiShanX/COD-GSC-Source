/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\suicidebomber\suicidebomber.gsc
*******************************************************/

bomber_init(asmname, statename, params) {
  self setbasearchetype("suicidebomber");

  if(self isscriptable())
    thread initscriptable();
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

shouldexplode(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self.explode);
}

playanim_explode(asmname, statename, params) {
  self endon(statename + "_finished");
  self._id_89C6B6E976238647 = 1;
  self._id_43DBF74C17EFBA26 = 1;
  animindex = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, animindex);
  self aisetanim(statename, animindex);
  _id_5B4471E9EFDE87C3 = getanimlength(xanim);
  _id_A647F347E70842C6 = getnotetracktimes(xanim, "explode")[0];

  if(isDefined(_id_A647F347E70842C6))
    _id_5B4471E9EFDE87C3 = _id_5B4471E9EFDE87C3 * _id_A647F347E70842C6;

  wait(_id_5B4471E9EFDE87C3);

  if(isDefined(level.suicide_bomber_explode_func))
    self thread[[level.suicide_bomber_explode_func]](self);

  self.nocorpse = 1;
  thread bomber_detonation();
}

playanim_bomberdeath(asmname, statename, params) {
  if(!istrue(self.hasexploded) && !istrue(self.skipdetonation)) {
    if(!istrue(self.instantexplode)) {
      thread scripts\asm\soldier\death::playdeathanim(asmname, statename);

      if(!istrue(self._id_66BE891389B593AA)) {
        if(!isagent(self))
          wait 1.2;

        if(!isagent(self) || isalive(self))
          stopFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, "J_Wrist_LE");
      }
    }

    if(!istrue(self.diequietly) && !istrue(self._id_66BE891389B593AA)) {
      self.nocorpse = 1;
      bomber_detonation();
    } else
      self.nocorpse = undefined;
  }
}

bomber_detonation() {
  self.hasexploded = 1;
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(isdismembermentenabled()) {
    if(isDefined(self) && isDefined(self.grenadeweapon) && istrue(self.bomberusegrenade))
      grenade = self _meth_22E707DB087AA60E(self.origin + (0, 0, 60), self.origin, 0.0, 0);
    else {
      playFX(level.g_effect["human_gib_fullbody"], self.origin);
      playFX(level.g_effect["vfx_suicide_bomber_gib_explode"], self.origin);
      thread bomber_radiusdamage();
      self playSound("vest_expl_trans");
    }
  } else {
    playFX(level.g_effect["vfx_suicide_bomber_no_dismember"], self.origin);
    thread bomber_radiusdamage();
    self playSound("vest_expl_trans");
  }

  playrumbleonposition("grenade_rumble", self.origin);

  if(scripts\engine\utility::is_equal(level.gametype, "cp_survival"))
    earthquake(0.8, 0.6, self.origin, 350);
  else
    earthquake(1.0, 0.6, self.origin, 1500);

  self notify("detonated");
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(!isagent(self))
    self delete();
  else
    self kill();
}

delay_explosion_fx(timer, org) {
  wait(timer);
  playFX(level.g_effect["vfx_suicide_bomber_no_dismember"], org);
}

bomber_radiusdamage() {
  if(scripts\engine\utility::is_equal(level.gametype, "cp_specops"))
    radiusdamage(self.origin + (0, 0, 60), 500, 250, 75);
  else if(scripts\engine\utility::is_equal(level.gametype, "cp_survival"))
    radiusdamage(self.origin + (0, 0, 60), 300, 250, 75, self);
  else
    self radiusdamage(self.origin + (0, 0, 60), 500, 250, 75, self);
}

bomber_finishpainhead(asmname, statename, params) {
  scripts\asm\soldier\pain::cleanuppainanim(asmname, statename, params);
}

playanim_bombermoveloop(asmname, statename, params) {
  self endon(statename + "_finished");
  self._id_89C6B6E976238647 = 1;
  self._id_43DBF74C17EFBA26 = 1;
  _id_0C8AAF5BC74C22BB = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");

  if(istrue(self._id_66BE891389B593AA))
    self aisetanim(statename, _id_0C8AAF5BC74C22BB, 0.8);
  else
    self aisetanim(statename, _id_0C8AAF5BC74C22BB);

  thread blendspacerndm(statename);

  for(;;)
    scripts\asm\asm::asm_donotetracks(asmname, statename);
}

blendspacerndm(statename) {
  self endon("death");
  self endon(statename + "_finished");

  for(;;) {
    _id_4C29F4CFA11921C7 = randomfloatrange(-1, 1);
    self _meth_2219BC2B5BE8918A(_id_4C29F4CFA11921C7);
    wait(randomfloatrange(0.25, 2));
  }
}

bomber_shouldraisearm(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self.bomberraisearm);
}