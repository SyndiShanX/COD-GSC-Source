/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\suicidebomber\suicidebomber.gsc
*******************************************************/

function bomber_init(var0, var1, var2) {
  scripts\asm\shared\utility::setbasearchetype("suicidebomber");

  if(self isscriptable()) {
    thread initscriptable();
    return;
  }
}

function initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

function shouldexplode(var0, var1, var2, var3) {
  return istrue(self.explode);
}

function playanim_explode(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  var5 = getanimlength(var4);
  var6 = getnotetracktimes(var4, "explode")[0];

  if(isDefined(var6)) {
    var5 *= var6;
  }

  wait var5;

  if(isDefined(level.suicide_bomber_explode_func)) {
    self thread[[level.suicide_bomber_explode_func]](self);
  }

  thread bomber_detonation();
}

function playanim_bomberdeath(var0, var1, var2) {
  if(!istrue(self.hasexploded) && !istrue(self.skipdetonation)) {
    if(!istrue(self.instantexplode)) {
      thread scripts\asm\soldier\death::playdeathanim(var0, var1);

      if(!isagent(self)) {
        wait 1.2;
      }

      if(!isagent(self) || isalive(self)) {
        stopFXOnTag(scripts\engine\utility::getfx("suicide_bomber_clicker_flash"), self, "J_Wrist_LE");
      }
    }

    if(!istrue(self.diequietly)) {
      bomber_detonation();
      return;
    }

    return;
  }
}

function bomber_detonation() {
  self.hasexploded = 1;

  if(getdvarint("NTMLLPTNLT")) {
    if(isDefined(self) && isDefined(self.grenadeweapon) && istrue(self.bomberusegrenade)) {
      var0 = self magicgrenade(self.origin + (0, 0, 60), self.origin, 0, 0);
    } else {
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
  earthquake(1, 0.6, self.origin, 1500);
  self notify("detonated");
  waitframe();

  if(!isagent(self)) {
    self delete();
    return;
  }

  self kill();
}

function bomber_finishpainhead(var0, var1, var2) {
  scripts\asm\soldier\pain::cleanuppainanim(var0, var1, var2);
  self kill();
}

function playanim_bombermoveloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
  self aisetanim(var1, var3);
  thread blendspacerndm(var1);

  for(;;) {
    scripts\asm\asm::asm_donotetracks(var0, var1);
  }
}

function blendspacerndm(var0) {
  self endon("death");
  self endon(var0 + "_finished");

  for(;;) {
    var1 = randomfloatrange(-1, 1);
    self setcivilianfocus(var1);
    wait randomfloatrange(0.25, 2);
  }
}

function bomber_shouldraisearm(var0, var1, var2, var3) {
  return istrue(self.bomberraisearm);
}