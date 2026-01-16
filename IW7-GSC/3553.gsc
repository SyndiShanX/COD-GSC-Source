/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3553.gsc
*********************************************/

func_44F9() {
  level._effect["coneFlash_wave"] = loadfx("vfx\iw7\_requests\mp\trail_kinetic_wave");
  level._effect["coneFlash_wedge"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_wave_wedge");
  level._effect["coneFlash_explosion"] = loadfx("vfx\old\_requests\archetypes\vfx_cone_flash_exp");
  level._effect["coneFlash_explosionScreen"] = loadfx("vfx\old\_requests\archetypes\vfx_cone_flash_exp_scr");
}

func_44FB() {
  func_44F1();
}

func_44FD() {
  self notify("coneFlash_unset");
  func_44F4();
}

func_44FF() {
  thread func_4500();
  func_44F5();
}

func_44F4() {
  self notify("coneFlash_end");
}

func_4500() {
  self endon("coneFlash_end");
  scripts\engine\utility::waittill_any("death", "disconnect");
  thread func_44F4();
}

func_44F5() {
  var_0 = undefined;
  if(level.teambased) {
    var_0 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  } else {
    var_0 = level.characters;
  }

  var_1 = self gettagorigin("tag_eye");
  var_2 = self getEye() + anglesToForward(self getplayerangles()) * 454;
  var_3 = scripts\common\trace::create_contents(0, 1, 1, 0, 0, 0, 0);
  var_4 = physics_raycast(var_1, var_2, var_3, undefined, 0, "physicsquery_closest");
  if(isDefined(var_4) && var_4.size > 0) {
    var_2 = var_4[0]["position"];
  }

  var_5 = vectortoangles(var_2 - var_1);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoup(var_5);
  var_8 = -96 * var_6;
  var_9 = var_1 + var_8;
  thread func_44F6(var_1, var_2, var_5);
  var_10 = 0;
  foreach(var_12 in var_0) {
    if(!func_44FC(var_12)) {
      continue;
    }

    if(!scripts\mp\utility::pointvscone(var_12 gettagorigin("j_spineupper"), var_9, var_6, var_7, 550, 96, 22, 72)) {
      continue;
    }

    var_4 = physics_raycast(self getEye(), var_12 getEye(), var_3, undefined, 0, "physicsquery_closest");
    if(isDefined(var_4) && var_4.size != 0) {
      continue;
    }

    var_13 = var_12 gettagorigin("j_spineupper") - var_9;
    var_14 = vectordot(var_6, var_13);
    if(var_14 <= 550) {
      if(var_14 <= 296) {
        var_12 dodamage(45, self.origin, self, self, "MOD_IMPACT", "coneflash_mp");
      } else {
        var_12 dodamage(27, self.origin, self, self, "MOD_IMPACT", "coneflash_mp");
      }
    }

    var_15 = min(max(var_14, 296), 550);
    var_10 = 1 - var_15 - 296 / 254;
    var_11 = 0.5 * 1 + vectordot(var_6, vectornormalize(var_13));
    thread func_44F0(var_12, var_9, var_10, var_11);
    var_10++;
  }

  func_44F8(var_10);
}

func_44F0(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  var_0 notify("flashbang", var_1, var_2, var_3, self, self.team, 1.33);
  scripts\mp\gamescore::func_11ACE(self, var_0, "power_coneFlash");
  var_0 scripts\engine\utility::waittill_any_timeout(1.33, "death");
  if(isDefined(self)) {
    scripts\mp\gamescore::untrackdebuffassist(self, var_0, "power_coneFlash");
  }
}

func_44F8(var_0) {
  var_1 = scripts\mp\lightarmor::getlightarmorvalue(self);
  var_1 = min(self.maxhealth, var_1 + var_0 * 45);
  scripts\mp\lightarmor::setlightarmorvalue(self, var_1);
}

func_44FC(var_0) {
  if(!isplayer(var_0)) {
    return 0;
  }

  if(!scripts\mp\utility::isreallyalive(var_0)) {
    return 0;
  }

  if(var_0 == self) {
    return 0;
  }

  if(level.teambased && var_0.team == self.team) {
    return 0;
  }

  if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_0)) {
    return 0;
  }

  return 1;
}

func_44F6(var_0, var_1, var_2) {
  self playlocalsound("kinetic_pulse");
  self playsoundtoteam("kinetic_pulse_npc", "axis", self);
  self playsoundtoteam("kinetic_pulse_npc", "allies", self);
  var_3 = func_44F7();
  var_3.origin = var_0;
  var_3.angles = var_2;
  var_4 = vectordot(var_1 - var_0, anglesToForward(var_2));
  var_5 = max(0.05, var_4 / 8000);
  var_3 moveto(var_1, var_5);
  var_6 = scripts\engine\utility::getfx("coneFlash_explosion");
  playFXOnTag(var_6, var_3, "tag_origin");
}

func_44F1() {
  self.var_4502 = [];
  for(var_0 = 0; var_0 < 3; var_0++) {
    var_1 = spawn("script_model", (10000, 10000, 0));
    var_1 setModel("tag_origin");
    self.var_4502[var_0] = var_1;
  }

  thread func_44FE();
}

func_44FE() {
  self endon("disconnect");
  self endon("coneFlash_unset");
  for(;;) {
    self.var_4502[0].origin = self gettagorigin("tag_eye");
    self.var_4502[0].angles = self getplayerangles();
    scripts\engine\utility::waitframe();
  }
}

func_44F2() {
  if(!isDefined(self.var_4502)) {
    return;
  }

  var_0 = scripts\engine\utility::getfx("coneFlash_explosion");
  foreach(var_2 in self.var_4502) {
    if(!isDefined(var_2)) {
      continue;
    }

    stopFXOnTag(var_0, var_2, "tag_origin");
    var_2 delete();
  }

  self.var_4502 = undefined;
}

func_4501() {
  scripts\engine\utility::waittill_any("coneflash_unset", "disconnect");
  func_44F2();
}

func_44F7() {
  var_0 = self.var_4502[0];
  var_1 = [];
  for(var_2 = 1; var_2 < 3; var_2++) {
    var_1[var_1.size] = self.var_4502[var_2];
  }

  var_1[var_1.size] = var_0;
  self.var_4502 = var_1;
  return var_0;
}