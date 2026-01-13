/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3578.gsc
*********************************************/

init() {
  level._effect["plasmaSpear_trail"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_life_link");
  level._effect["plasmaSpear_death"] = loadfx("vfx\old\_requests\mp_weapons\vfx_muz_plasma_blast_w");
  level._effect["plasmaSpear_trail2"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_knife_tele");
  level._effect["plasmaSpear_trail2_enemy"] = loadfx("vfx\old\_requests\mp_weapons\vfx_trail_knife_tele_red");
}

giveplayeraccessory() {
  self.var_CC58 = [];
  self.var_CC58[0] = scripts\engine\utility::spawn_tag_origin();
  self.var_CC58[1] = scripts\engine\utility::spawn_tag_origin();
  self.var_C243 = 0;
}

func_E158() {
  self notify("removePlasmaSpear");
  foreach(var_1 in self.var_CC58) {
    var_1 delete();
  }
}

func_CC59(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  self notify("powers_spear_used");
  var_1 = (0, 0, 32);
  if(self.var_C243) {
    var_2 = self.var_CC58[1];
    self.var_C3FF = self.var_CC5A;
    self.var_CC5A = var_0;
  } else {
    var_2 = self.var_CC58[0];
    self.var_CC5A = var_0;
  }

  var_2.origin = self.origin + var_1;
  self.var_C243++;
  var_2 show();
  thread func_CF18(var_2);
  var_0 scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  var_0 playSound("plasma_spear_impact");
  self notify("powers_spear_used");
  thread func_BCD5(var_0, var_2, var_1);
  thread func_CC56(var_0, var_2);
  thread func_13A80(var_0, var_2);
  thread func_13A54(var_0, var_2);
}

func_BCD5(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  var_1.var_BCEC = 0;
  var_1.var_115F6 = 0;
  var_3 = 589824;
  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    var_4 = level.players;
    if(self.var_C243 > 1) {
      var_5 = var_0 gettagorigin("tag_end");
      var_6 = self.var_C3FF gettagorigin("tag_end");
      var_4[var_4.size] = var_0;
      var_4[var_4.size] = self.var_C3FF;
      var_3 = 1048576;
    } else {
      var_5 = var_0 gettagorigin("tag_end");
      var_6 = self.origin + var_2;
      var_4[var_4.size] = var_0;
      var_3 = 589824;
    }

    var_7 = scripts\common\trace::ray_trace_passed(var_6, var_5, level.players);
    var_8 = distancesquared(var_6, var_5);
    if(var_8 < var_3) {
      var_9 = 1;
    } else {
      var_9 = 0;
    }

    if(!var_7 || !var_9) {
      var_1.origin = var_5;
      var_1.var_115F6 = 0;
      var_0A = scripts\engine\utility::randomvector(1);
      var_0B = vectortoangles(var_0A);
      var_0C = anglesToForward(var_0B);
      var_0D = var_5 + var_0C * randomintrange(64, 128);
      var_1 moveto(var_0D, 0.1);
      wait(0.1);
      continue;
    }

    var_1.var_115F6 = 1;
    if(scripts\engine\utility::mod(var_1.var_BCEC, 2) == 0) {
      var_1 moveto(var_5, 0.25);
    } else {
      var_1 moveto(var_6, 0.25);
    }

    var_1.var_BCEC++;
    wait(0.25);
  }
}

func_CF18(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removePlasmaSpear");
  wait(0.05);
  if(isDefined(var_0)) {
    var_0 playsoundonmovingent("plasma_spear_energy");
    if(level.teambased) {
      playfxontagforteam(level._effect["plasmaSpear_trail2"], var_0, "tag_origin", self.team);
      wait(0.05);
      playfxontagforteam(level._effect["plasmaSpear_trail2_enemy"], var_0, "tag_origin", scripts\mp\utility::getotherteam(self.team));
      return;
    }

    playfxontagforclients(level._effect["plasmaSpear_trail2"], var_0, "tag_origin", self);
    wait(0.15);
    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      }

      playfxontagforclients(level._effect["plasmaSpear_trail2_enemy"], var_0, "tag_origin", var_2);
      wait(0.15);
    }
  }
}

func_13A54(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");
  stopFXOnTag(level._effect["plasmaSpear_trail2"], var_1, "tag_origin");
  stopFXOnTag(level._effect["plasmaSpear_trail2_enemy"], var_1, "tag_origin");
  self.var_C243--;
  var_1 hide();
}

func_13A80(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  self.var_C243--;
  if(isDefined(var_1)) {
    var_1 hide();
  }
}

func_CC56(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  if(!isDefined(var_0)) {
    return;
  }

  for(;;) {
    if(!isDefined(var_1)) {
      return;
    }

    if(var_1.var_115F6) {
      var_2 = func_808B(32, var_1);
    } else {
      var_2 = func_808B(64, var_1);
    }

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }

      var_5 = gettime();
      if(isDefined(var_4.var_118F4) && var_4.var_118F4 > var_5 + 500) {
        continue;
      }

      var_4.var_118F4 = var_5;
      var_4 thread[[level.callbackplayerdamage]](var_1, self, 50, 0, "MOD_MELEE", "throwingreaper_mp", var_1.origin, undefined, "none", 0);
      var_1 playsoundtoplayer("plasma_shock", var_4);
      var_4 playsoundonmovingent("plasma_shock_npc");
    }

    wait(0.05);
  }
}

func_808B(var_0, var_1) {
  var_2 = [];
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_4 in level.players) {
    if(!isDefined(var_1)) {
      return;
    }

    if(var_4 == self) {
      continue;
    }

    if(!isDefined(var_4.team)) {
      continue;
    }

    if(var_4.team != scripts\mp\utility::getotherteam(self.team)) {
      continue;
    }

    if(!scripts\mp\utility::isreallyalive(var_4)) {
      continue;
    }

    if(var_0 != 0) {
      var_5 = scripts\engine\utility::distance_2d_squared(var_1.origin, var_4.origin);
      var_6 = var_0 * var_0;
      if(var_5 > var_6) {
        continue;
      }
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}