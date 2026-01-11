/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3439.gsc
***************************************/

func_97D0() {
  level._effect["dodge_ground_spark_fx"] = loadfx("vfx\iw7\_requests\mp\vfx_dodge_ground_spark_fx");
  level._effect["dash_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_dash_trail");
  level._effect["dodge_fwd_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_fwd_scrn");
  level._effect["dodge_back_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_back_scrn");
  level._effect["dodge_left_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_left_scrn");
  level._effect["dodge_right_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_right_scrn");
  level._effect["dodge_fwd_left_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_fwd_left_scrn");
  level._effect["dodge_fwd_right_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_fwd_right_scrn");
  level._effect["dodge_back_left_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_back_left_scrn");
  level._effect["dodge_back_right_screen"] = loadfx("vfx\core\mp\equipment\vfx_dodge_back_right_scrn");
}

func_98AE() {
  level._effect["speed_strip_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_aura_speed_friend");
}

applyarchetype() {
  equipextras();
}

equipextras() {
  scripts\mp\utility::giveperk("specialty_falldamage");
}

removearchetype() {
  self.func_B94B = undefined;
  self setclientomnvar("ui_dodge_charges", 0);
  self notify("removeArchetype");
}

func_3886() {
  self notify("removeScoutMomentum");
}

func_13B32() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("removeScoutMomentum");
  var_00 = 0;
  var_01 = -1;

  for(;;) {
    var_02 = self getentityvelocity();
    var_03 = length(var_02);

    if(var_03 >= 0 && var_03 <= 120) {
      var_01 = -25;
    } else if(var_03 > 120 && var_03 <= 150) {
      var_01 = -20;
    } else if(var_03 > 150 && var_03 <= 180) {
      var_01 = -15;
    } else if(var_03 > 180 && var_03 <= 210) {
      var_01 = -10;
    } else if(var_03 > 210 && var_03 <= 250) {
      var_01 = 0;
    } else if(var_03 > 250 && var_03 <= 330) {
      var_01 = 5;
    } else if(var_03 > 330) {
      var_01 = 10;
    }

    var_00 = var_00 + var_01;
    var_00 = clamp(var_00, 0, 100);
    var_04 = func_7FC8(var_00);
    self.func_B94B = var_04;

    if(scripts\mp\utility::_hasperk("specialty_scoutping") || scripts\mp\utility::_hasperk("passive_scoutping")) {
      scripts\mp\perks\perkfunctions::updatescoutpingvalues(var_04);
    }

    wait 0.5;
  }
}

func_7FC8(var_00) {
  var_01 = 0;

  if(var_00 >= 10 && var_00 <= 20) {
    var_01 = 1;
  } else if(var_00 > 20 && var_00 <= 30) {
    var_01 = 2;
  } else if(var_00 > 30 && var_00 <= 40) {
    var_01 = 3;
  } else if(var_00 > 40 && var_00 <= 50) {
    var_01 = 4;
  } else if(var_00 > 50 && var_00 <= 60) {
    var_01 = 5;
  } else if(var_00 > 60 && var_00 <= 70) {
    var_01 = 6;
  } else if(var_00 > 70 && var_00 <= 80) {
    var_01 = 7;
  } else if(var_00 > 80 && var_00 <= 90) {
    var_01 = 8;
  } else if(var_00 > 90 && var_00 <= 100) {
    var_01 = 9;
  }

  return var_01;
}

func_139F9() {
  self endon("death");
  self endon("disconnect");
  self notify("setDodge");
  self endon("setDodge");
  self endon("removeArchetype");
  thread func_5802();

  for(;;) {
    self waittill("dodgeBegin");

    if(isDefined(self.controlsfrozen) && self.controlsfrozen == 1) {
      continue;
    }
    if(isDefined(self.usingremote) && self.usingremote != "") {
      continue;
    }
    self.dodging = 1;

    if(scripts\mp\utility::_hasperk("specialty_dodge_defense")) {
      self setclientomnvar("ui_light_armor", 1);
    }

    thread func_139FB();
    var_00 = self getnormalizedmovement();

    for(;;) {
      if(var_0[0] > 0) {
        if(var_0[1] <= 0.7 && var_0[1] >= -0.7) {
          self setscriptablepartstate("dodge", "dodge_forward");
          break;
        }

        if(var_0[0] > 0.5 && var_0[1] > 0.7) {
          self setscriptablepartstate("dodge", "dodge_forward_right");
          break;
        }

        if(var_0[0] > 0.5 && var_0[1] < -0.7) {
          self setscriptablepartstate("dodge", "dodge_forward_left");
          break;
        }
      }

      if(var_0[0] < 0) {
        if(var_0[1] < 0.4 && var_0[1] > -0.4) {
          self setscriptablepartstate("dodge", "dodge_back");
          break;
        }

        if(var_0[0] < -0.5 && var_0[1] > 0.5) {
          self setscriptablepartstate("dodge", "dodge_back_right");
          break;
        }

        if(var_0[0] < -0.5 && var_0[1] < -0.5) {
          self setscriptablepartstate("dodge", "dodge_back_left");
          break;
        }
      }

      if(var_0[1] > 0.4) {
        self setscriptablepartstate("dodge", "dodge_right");
        break;
      }

      if(var_0[1] < -0.4) {
        self setscriptablepartstate("dodge", "dodge_left");
        break;
      } else
        break;
    }

    if(isDefined(self.func_5809)) {
      triggerfx(self.func_5809);
    }

    foreach(var_02 in level.players) {
      if(isDefined(var_02) && var_02 != self) {
        playfxontagforclients(level._effect["dash_trail"], self, "tag_shield_back", var_02);
      }
    }

    if(!self isjumping()) {
      playFXOnTag(level._effect["dodge_ground_spark_fx"], self, "tag_origin");
    }

    self playlocalsound("synaptic_dash");
    self playSound("synaptic_dash_npc");
  }
}

func_5802() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("setDodge");

  for(;;) {
    var_00 = self energy_getenergy(1);
    var_01 = self energy_getmax(1);

    if(var_00 >= var_01) {
      self setclientomnvar("ui_dodge_charges", 1);
    } else {
      self setclientomnvar("ui_dodge_charges", 0);
    }

    wait 0.05;
  }
}

func_139FB() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("dodgeEnd", "death", "disconnect");
  self.dodging = 0;

  if(scripts\mp\utility::_hasperk("specialty_dodge_defense")) {
    self setclientomnvar("ui_light_armor", 0);
  }

  if(isDefined(self)) {
    stopFXOnTag(level._effect["dash_trail"], self, "tag_shield_back");
  }

  if(isDefined(self.func_5809)) {
    self.func_5809 delete();
  }
}

func_E175() {
  if(isDefined(self.func_D753) && self.func_D753 == 1) {
    scripts\mp\utility::removeperk("specialty_quieter");
    scripts\mp\utility::removeperk("specialty_ghost");
    scripts\mp\utility::removeperk("specialty_spygame");
    scripts\mp\utility::removeperk("specialty_blindeye");
    scripts\mp\utility::removeperk("specialty_coldblooded");
    scripts\mp\utility::removeperk("specialty_noscopeoutline");
    scripts\mp\utility::removeperk("specialty_heartbreaker");
    scripts\mp\utility::removeperk("specialty_noplayertarget");
    self.func_D753 = undefined;
  }
}

func_130E0() {
  for(;;) {
    if(self isonladder()) {
      wait 0.1;
      continue;
    }

    break;
  }

  scripts\mp\utility::giveperk("specialty_quieter");
  scripts\mp\utility::giveperk("specialty_ghost");
  scripts\mp\utility::giveperk("specialty_spygame");
  scripts\mp\utility::giveperk("specialty_blindeye");
  scripts\mp\utility::giveperk("specialty_coldblooded");
  scripts\mp\utility::giveperk("specialty_noscopeoutline");
  scripts\mp\utility::giveperk("specialty_heartbreaker");
  scripts\mp\utility::giveperk("specialty_noplayertarget");
  self.func_D753 = 1;
  func_11320();
  scripts\mp\powers::func_4575(30, "powers_stealth_mode_update");
  func_E175();
}

func_11320() {
  scripts\engine\utility::allow_weapon(0);
  var_00 = self getweaponslistprimaries();
  var_01 = getweaponbasename(var_0[0]);
  var_02 = self getweaponammostock(var_0[0]);
  var_03 = self getweaponammoclip(var_0[0]);
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;

  if(var_0.size > 1) {
    var_04 = getweaponbasename(var_0[1]);
    var_05 = self getweaponammostock(var_0[1]);
    var_06 = self getweaponammoclip(var_0[1]);
  }

  var_07 = self getcurrentweapon();
  var_08 = undefined;

  foreach(var_10 in var_00) {
    if(!issubstr(var_10, "silencer")) {
      var_11 = undefined;
      var_12 = getweaponattachments(var_10);
      var_13 = scripts\mp\utility::getweaponattachmentarrayfromstats(var_10);

      foreach(var_15 in var_13) {
        if(issubstr(var_15, "silencer")) {
          var_11 = scripts\mp\utility::attachmentmap_tounique(var_15, var_10);
          break;
        }
      }

      if(isDefined(var_11)) {
        foreach(var_15 in var_12) {
          if(scripts\mp\utility::attachmentscompatible(var_15, var_11)) {
            continue;
          }
          var_12 = scripts\engine\utility::array_remove(var_12, var_15);
        }

        var_12 = scripts\engine\utility::array_add(var_12, var_11);
        var_19 = getweaponbasename(var_10);
        var_20 = scripts\mp\utility::getweaponrootname(var_10);
        var_08 = scripts\mp\class::buildweaponname(var_20, var_12);
        wait 0.3;
        scripts\mp\utility::_takeweapon(var_10);
        scripts\mp\utility::_giveweapon(var_08);

        if(var_19 == var_01) {
          self setweaponammoclip(var_08, var_03);
          self setweaponammostock(var_08, var_02);
        } else if(isDefined(var_06)) {
          self setweaponammoclip(var_08, var_06);
          self setweaponammostock(var_08, var_05);
        }

        if(var_10 == var_07) {
          scripts\mp\utility::_switchtoweapon(var_08);
        }
      }
    }
  }

  scripts\engine\utility::allow_weapon(1);
}

func_F6F2() {
  self _meth_8454(4);
}

func_139FA() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");

  if(0) {
    thread func_E844();
  }

  if(0) {
    thread func_E85D();
  }

  if(0) {
    thread func_E864();
  }

  if(0) {
    thread func_E89E();
  }
}

func_E844() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");

  for(;;) {
    self waittill("dodgeBegin");
    var_00 = spawn("script_origin", self.origin);
    var_00 setModel("tag_origin");
    var_00 linkto(self, "tag_origin", (0, 0, 64), (0, 0, 0));
    var_00 thread scripts\mp\weapons::func_56E5(self, 1);
  }
}

func_E85D() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
}

func_E89E() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");

  for(;;) {
    self waittill("dodgeEnd");
  }
}

func_E864() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");

  for(;;) {
    self waittill("dodgeEnd");

    if(!isDefined(self.func_B94A)) {
      self.func_B94A = 1.5;
    } else {
      self.func_B94A = self.func_B94A + 1.5;
      continue;
    }

    scripts\mp\utility::giveperk("specialty_stalker");
    func_B949();
    scripts\mp\utility::removeperk("specialty_stalker");
    self.func_B94A = undefined;
  }
}

func_B949() {
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();

  for(var_00 = gettime(); var_00 + self.func_B94A * 1000 > gettime(); self.func_B94A = self.func_B94A - 0.05) {
    scripts\engine\utility::waitframe();
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

func_2620() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  func_98AE();
  self setclientomnvar("ui_aura_speedboost", 0);

  for(;;) {
    self waittill("got_a_kill");

    foreach(var_01 in level.players) {
      if(var_1.team != self.team) {
        continue;
      }
      if(scripts\mp\equipment\charge_mode::func_3CEE(var_01)) {
        continue;
      }
      if(distance2dsquared(var_1.origin, self.origin) > 147456) {
        continue;
      }
      var_01 thread func_261E(self);
    }
  }
}

func_261E(var_00) {
  self endon("disconnect");
  self endon("giveLoadout_start");

  if(self != var_00) {
    var_00 thread scripts\mp\utility::giveunifiedpoints("buff_teammate");
  }

  self.movespeedscaler = 1.1;
  scripts\mp\weapons::updatemovespeedscale();
  self setclientomnvar("ui_aura_speedboost", 1);
  var_01 = playFXOnTag(scripts\engine\utility::getfx("speed_strip_friendly"), self, "tag_origin");
  thread func_2621(var_01);
  scripts\engine\utility::waittill_any_timeout(3, "death");
  thread func_261F();
}

func_2621(var_00) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("death", "aura_speed_end");
  stopFXOnTag(scripts\engine\utility::getfx("speed_strip_friendly"), self, "tag_origin");
  self setclientomnvar("ui_aura_speedboost", 0);
}

func_261F() {
  self notify("aura_speed_end");
  self.movespeedscaler = 1.0;
  scripts\mp\weapons::updatemovespeedscale();
}

func_B947() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("removeCombatHigh");
  func_98AF();

  for(;;) {
    self waittill("got_a_kill", var_00, var_01, var_02);

    if(scripts\engine\utility::isbulletdamage(var_02) || var_02 == "MOD_MELEE") {
      thread func_B942();
    }
  }
}

func_B942() {
  self endon("disconnect");
  self endon("giveLoadout_start");
  self.speedonkillmod = 0.06;
  scripts\mp\weapons::updatemovespeedscale();
  self playlocalsound("mp_overcharge_on");
  self setscriptablepartstate("momentumScreen", "momentumScreen_On", 0);
  thread func_B948();
  scripts\engine\utility::waittill_any_timeout(scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 3, 4), "death");
  thread func_B945();
}

func_B948() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("death", "momentum_end");
  self setscriptablepartstate("momentumScreen", "momentumScreen_Off", 0);
}

func_B945() {
  self notify("momentum_end");
  self.speedonkillmod = 0;
  scripts\mp\weapons::updatemovespeedscale();
  self playlocalsound("mp_overcharge_off");
}

func_B946() {
  if(self.loadoutarchetype == "archetype_scout" && level.gametype != "infect") {
    self setscriptablepartstate("momentumScreen", "momentumScreen_Off", 0);
  }
}