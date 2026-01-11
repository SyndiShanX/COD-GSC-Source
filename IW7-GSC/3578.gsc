/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3578.gsc
************************/

init() {
  level._effect["plasmaSpear_trail"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_life_link");
  level._effect["plasmaSpear_death"] = loadfx("vfx\old\_requests\mp_weapons\vfx_muz_plasma_blast_w");
  level._effect["plasmaSpear_trail2"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_knife_tele");
  level._effect["plasmaSpear_trail2_enemy"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_knife_tele_red");
}

giveplayeraccessory() {
  self.var_CC58 = [];
  self.var_CC58[0] = ::scripts\engine\utility::spawn_tag_origin();
  self.var_CC58[1] = ::scripts\engine\utility::spawn_tag_origin();
  self.var_C243 = 0;
}

func_E158() {
  self notify("removePlasmaSpear");
  foreach(var_01 in self.var_CC58) {
    var_01 delete();
  }
}

func_CC59(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  self notify("powers_spear_used");
  var_01 = (0, 0, 32);
  if(self.var_C243) {
    var_02 = self.var_CC58[1];
    self.var_C3FF = self.var_CC5A;
    self.var_CC5A = param_00;
  } else {
    var_02 = self.var_CC58[0];
    self.var_CC5A = param_00;
  }

  var_02.origin = self.origin + var_01;
  self.var_C243++;
  var_02 show();
  thread func_CF18(var_02);
  param_00 scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  param_00 playSound("plasma_spear_impact");
  self notify("powers_spear_used");
  thread func_BCD5(param_00, var_02, var_01);
  thread func_CC56(param_00, var_02);
  thread func_13A80(param_00, var_02);
  thread func_13A54(param_00, var_02);
}

func_BCD5(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  param_01.var_BCEC = 0;
  param_01.var_115F6 = 0;
  var_03 = 589824;
  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    var_04 = level.players;
    if(self.var_C243 > 1) {
      var_05 = param_00 gettagorigin("tag_end");
      var_06 = self.var_C3FF gettagorigin("tag_end");
      var_04[var_04.size] = param_00;
      var_04[var_04.size] = self.var_C3FF;
      var_03 = 1048576;
    } else {
      var_05 = param_00 gettagorigin("tag_end");
      var_06 = self.origin + param_02;
      var_04[var_04.size] = param_00;
      var_03 = 589824;
    }

    var_07 = scripts\common\trace::ray_trace_passed(var_06, var_05, level.players);
    var_08 = distancesquared(var_06, var_05);
    if(var_08 < var_03) {
      var_09 = 1;
    } else {
      var_09 = 0;
    }

    if(!var_07 || !var_09) {
      param_01.origin = var_05;
      param_01.var_115F6 = 0;
      var_0A = scripts\engine\utility::randomvector(1);
      var_0B = vectortoangles(var_0A);
      var_0C = anglesToForward(var_0B);
      var_0D = var_05 + var_0C * randomintrange(64, 128);
      param_01 moveto(var_0D, 0.1);
      wait(0.1);
      continue;
    }

    param_01.var_115F6 = 1;
    if(scripts\engine\utility::mod(param_01.var_BCEC, 2) == 0) {
      param_01 moveto(var_05, 0.25);
    } else {
      param_01 moveto(var_06, 0.25);
    }

    param_01.var_BCEC++;
    wait(0.25);
  }
}

func_CF18(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  wait(0.05);
  if(isDefined(param_00)) {
    param_00 playsoundonmovingent("plasma_spear_energy");
    if(level.teambased) {
      playfxontagforteam(level._effect["plasmaSpear_trail2"], param_00, "tag_origin", self.team);
      wait(0.05);
      playfxontagforteam(level._effect["plasmaSpear_trail2_enemy"], param_00, "tag_origin", scripts\mp\utility::getotherteam(self.team));
      return;
    }

    playfxontagforclients(level._effect["plasmaSpear_trail2"], param_00, "tag_origin", self);
    wait(0.15);
    foreach(var_02 in level.players) {
      if(var_02 == self) {
        continue;
      }

      playfxontagforclients(level._effect["plasmaSpear_trail2_enemy"], param_00, "tag_origin", var_02);
      wait(0.15);
    }
  }
}

func_13A54(param_00, param_01) {
  param_00 endon("death");
  self waittill("death");
  stopFXOnTag(level._effect["plasmaSpear_trail2"], param_01, "tag_origin");
  stopFXOnTag(level._effect["plasmaSpear_trail2_enemy"], param_01, "tag_origin");
  self.var_C243--;
  param_01 hide();
}

func_13A80(param_00, param_01) {
  self endon("death");
  param_00 waittill("death");
  self.var_C243--;
  if(isDefined(param_01)) {
    param_01 hide();
  }
}

func_CC56(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  param_00 endon("death");
  if(!isDefined(param_00)) {
    return;
  }

  for(;;) {
    if(!isDefined(param_01)) {
      return;
    }

    if(param_01.var_115F6) {
      var_02 = _meth_808B(32, param_01);
    } else {
      var_02 = _meth_808B(64, param_01);
    }

    foreach(var_04 in var_02) {
      if(!isDefined(var_04)) {
        continue;
      }

      var_05 = gettime();
      if(isDefined(var_04.var_118F4) && var_04.var_118F4 > var_05 + 500) {
        continue;
      }

      var_04.var_118F4 = var_05;
      var_04 thread[[level.callbackplayerdamage]](param_01, self, 50, 0, "MOD_MELEE", "throwingreaper_mp", param_01.origin, undefined, "none", 0);
      param_01 playsoundtoplayer("plasma_shock", var_04);
      var_04 playsoundonmovingent("plasma_shock_npc");
    }

    wait(0.05);
  }
}

_meth_808B(param_00, param_01) {
  var_02 = [];
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  foreach(var_04 in level.players) {
    if(!isDefined(param_01)) {
      return;
    }

    if(var_04 == self) {
      continue;
    }

    if(!isDefined(var_04.team)) {
      continue;
    }

    if(var_04.team != scripts\mp\utility::getotherteam(self.team)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_04)) {
      continue;
    }

    if(param_00 != 0) {
      var_05 = scripts\engine\utility::distance_2d_squared(param_01.origin, var_04.origin);
      var_06 = param_00 * param_00;
      if(var_05 > var_06) {
        continue;
      }
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}