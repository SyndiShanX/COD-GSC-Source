/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2451.gsc
*************************************************/

init() {
  _id_06F6::_id_E416();
  _id_75E4();
  _id_5885();
  level._id_5886 = [];
}

_id_607A() {
  self endon("death");
  self._id_EAAB = 1;
  thread _id_075B::_id_19F5(self);
  wait 0.5;
  self._id_EAAB = undefined;
}

_id_E3C6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self._id_1210) && (self._id_1210 == "zombie_brute" || self._id_1210 == "zombie_grey")) {
    return;
  }
  var_12 = istrue(var_1.inlaststand);
  var_13 = istrue(self._id_86D9);
  var_14 = var_5.basename;

  if(!isDefined(var_14)) {
    return;
  }
  var_15 = 0;

  if(!var_13) {
    switch (var_14) {
      case "iw7_headcutter3_zm":
      case "iw7_headcutter2_zm":
      case "iw7_headcutter_zm_pap1":
      case "iw7_headcutter_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !istrue(self._id_8873)) {
          self.health = var_2 + 1;
          self._id_0043 = 1;
          self._id_8D78 = var_1;
          thread _id_75DC(var_1, var_6, var_8, var_2, var_5);
          var_15 = 1;
        }

        break;
      case "iw7_dischord_zm_pap1":
      case "iw7_dischord_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !istrue(self._id_8873)) {
          self.health = var_2 + 1;
          self._id_0043 = 1;
          self._id_8D78 = var_1;
          thread _id_4B0E(var_1, var_6, var_8, var_2, var_5);
        }

        break;
      case "iw7_facemelter_zm_pap1":
      case "iw7_facemelter_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !istrue(self._id_8873)) {
          self.health = var_2 + 1;
          self._id_0043 = 1;
          self._id_8D78 = var_1;
          thread _id_5883(var_1, var_6, var_8, var_2, var_5);
        }

        break;
      case "iw7_shredder_zm_pap1":
      case "iw7_shredder_zm":
        if(var_4 != "MOD_MELEE" && var_2 >= self.health && !istrue(self._id_8873)) {
          self.health = var_2 + 1;
          self._id_0043 = 1;
          self._id_8D78 = var_1;
          thread _id_DD06(var_1, var_6, var_8, var_2);
        }

        break;
      default:
        break;
    }

    if(self.health - var_2 < 1) {
      if(isDefined(level._id_9D2D)) {
        var_16 = [[level._id_9D2D]](self);

        if(isDefined(var_16)) {
          self._id_A546 = 1;
          self._id_A3EE = var_16;
        } else
          self._id_A3EE = undefined;
      }

      if(isDefined(level._id_40E4)) {
        if(isPlayer(var_1) && isDefined(var_5) && var_5.basename != "none") {
          var_17 = [[level._id_40E4]](self, var_5);

          if(var_17) {
            self._id_A546 = 1;
            self._id_A3EA = 1;
          } else
            self._id_A3EA = undefined;
        } else
          self._id_A3EA = undefined;
      }
    }
  }

  if(self.health - var_2 < 1) {
    if(isDefined(level._id_91DF)) {
      [[level._id_91DF]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(!var_12 && !var_15) {
      if(var_1 scripts\cp\utility::_id_8580("headshot_explosion")) {
        _id_34D4(var_1, var_6, var_2, var_4, var_5, var_8, var_13);
      }
    }
  }
}

_id_4B0E(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_94EB)) {
    return;
  }
  self endon("death");

  if(istrue(self._id_8595) || self._id_CF4A) {
    self._id_4C08 = 1;
    self dodamage(self.health + 1000, self.origin, var_0, var_0, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  self._id_CF4A = 1;
  var_5 = 0;
  var_6 = scripts\cp\utility::weaponhasattachment(var_4, "pap1");
  var_7 = 50;

  if(var_6) {
    var_7 = 100;
    self._id_FD9B = 1;
  }

  self._id_4B0F = 1;

  if(istrue(self._id_86ED)) {
    thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 5);
    playFXOnTag(level._effect["dischord_tornado"], self, "tag_origin");
    var_5 = 1;

    while(istrue(self._id_86ED)) {
      wait 0.1;
    }

    self notify("stop_spin");
  }

  thread _id_8D31(5, "ready_to_spin");

  if(!var_5) {
    self setscriptablepartstate("dischord_spin_fx", "active", 1);
  }

  self waittill("ready_to_spin");
  self._id_94EB = spawn("script_origin", self.origin);
  self._id_94EB thread _id_8D2E(self);

  if(!var_6) {
    self linkto(self._id_94EB);
  }

  thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 0.5);
  self._id_94EB rotateyaw(360, 1.0);
  wait 0.5;
  thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 0.5);
  self._id_94EB rotateyaw(720, 1.0);
  wait 0.5;
  thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 1);
  self._id_94EB rotateyaw(1080, 1.0);
  wait 1;
  thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 1);
  self._id_94EB rotateyaw(1240, 1.0);
  wait 1;

  if(var_6) {
    thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 2);
    wait 2;
  } else
    thread _id_4B10(var_0, var_1, var_2, var_3, var_7, 0.1);

  playsoundatpos(self.origin, "zombie_dischord_zmb_spin_explo");
  self._id_5FF5 = 1;
  self._id_A546 = 1;
  self._id_6EAC = "dischord_explosion";
  self setscriptablepartstate("dischord_spin_fx", "inactive", 1);
  var_8 = 128;

  if(var_6) {
    var_8 = 256;
  }

  if(isDefined(var_0)) {
    var_0 radiusdamage(self.origin, var_8, 2000, 2000, var_0, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  } else {
    level.players[0] radiusdamage(self.origin, var_8, 2000, 2000, level.players[0], "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }

  if(isDefined(self._id_94EB)) {
    self._id_4B0F = 0;
    self._id_43F2 = "dischord";
    self dodamage(self.health + 1000, self.origin, var_0, self._id_94EB, "MOD_GRENADE_SPLASH", "iw7_dischorddummy_zm");
  }
}

_id_8D2E(var_0) {
  var_0 waittill("death");
  wait 0.25;
  self delete();
}

_id_8D31(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  wait(var_0);
  self suicide();
}

_id_4B10(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("stop_spin");
  var_6 = var_5;
  var_7 = 0.1;
  var_8 = 2;
  var_3 = 3000;

  if(var_4 == 100) {
    var_3 = 7000;
  }

  while(var_6 > 0) {
    var_9 = 0;
    var_10 = scripts\engine\utility::_id_6369(self.origin, level._id_E2A4, [self], 30, var_4);

    if(isDefined(var_10)) {
      foreach(var_12 in var_10) {
        if(var_12._id_1210 == "zombie_brute" || var_12._id_1210 == "zombie_grey") {
          continue;
        }
        var_13 = undefined;

        if(istrue(self._id_86ED)) {
          var_13 = 1;
        }

        if(!istrue(var_12._id_426B)) {
          var_9++;

          if(var_9 >= var_8) {
            var_13 = 1;
          }

          var_12 thread _id_5CFA(var_3, self._id_94EB, var_0, var_13);
        }
      }
    }

    var_6 = var_6 - var_7;
    wait(var_7);
  }
}

_id_5CFA(var_0, var_1, var_2, var_3) {
  self._id_4C08 = 1;
  self._id_426B = 1;
  self._id_49D8 = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait 0.05;

  if(istrue(var_3)) {
    self._id_A546 = 1;
    self._id_5FF5 = 1;

    if(isDefined(var_2)) {
      self dodamage(self.health + 1000, self.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    } else {
      self dodamage(self.health + 1000, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    }
  } else {
    self setvelocity(vectornormalize(self.origin - var_1.origin) * 200 + (0, 0, 800));
    wait 0.1;

    if(isDefined(var_2)) {
      self dodamage(self.health + 1000, var_1.origin, var_2, var_1, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    } else {
      self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_dischorddummy_zm");
    }
  }
}

_id_DAE4(var_0) {
  var_1 = 3;

  if(var_0 scripts\cp\utility::_id_7531("perk_machine_more")) {
    var_1 = 4;
  }

  var_2 = var_0 _meth_8191("primary");
  return var_2.size >= var_1;
}

_id_5885() {
  level._effect["base_plasma_explosion_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_large_explosion_enemy.vfx");
  level._effect["glob_plasma_pool_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_med_flames_enemy.vfx");
  level._effect["glob_plasma_impact_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_small_explosion_enemy.vfx");
  level._effect["glob_plasma_trail_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_trail_enemy.vfx");
  level._effect["dischord_tornado"] = loadfx("vfx/iw7/core/zombie/weapon/dischord/vfx_zmb_dischord_energy_tornado.vfx");
  level._effect["player_plasma_enemy"] = loadfx("vfx/iw7/_requests/mp/power/vfx_splash_grenade_light_en.vfx");
  level._effect["player_plasma_friendly"] = loadfx("vfx/iw7/_requests/mp/power/vfx_splash_grenade_light_fr.vfx");
}

_id_5883(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(self._id_94EB)) {
    return;
  }
  self._id_CF4A = 1;
  self._id_0229 = 1;
  var_5 = var_4 _meth_8624("pap1");

  if(isDefined(self._id_7598) && !self._id_7598) {
    level thread _id_5884(self, 5, var_0);
    self._id_A546 = 1;
    self dodamage(self.health + 1000, self.origin, var_0, var_0, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
    return;
  } else if(isDefined(self._id_86ED)) {
    self._id_C8AA = 1;
    level thread _id_5884(self, 5, var_0, var_5, 1);
    self setscriptablepartstate("burning", "active", 1);

    while(istrue(self._id_86ED)) {
      wait 0.1;
    }
  }

  self._id_C8AA = 1;

  if(isDefined(self._id_B9DF)) {
    self._id_B9DF notify("fire_pool_done");
  }

  thread _id_C440();
  level thread _id_5884(self, 5, var_0, var_5);

  if(!istrue(self._id_8584)) {
    thread _id_F807();
    self waittill("ready_to_launch");
    self._id_94EB = spawn("script_origin", self.origin);
    self._id_94EB.angles = self.angles;
    self._id_94EB thread _id_8D2E(self);
    self linkto(self._id_94EB);
    var_6 = self.origin + (0, 0, 200);
    var_7 = self _meth_8008(self.origin, self.origin + (0, 0, 200), 15, 60, 1, 1);
    var_8 = 1;

    if(isDefined(var_7) && isDefined(var_7["position"])) {
      var_6 = var_7["position"] + (0, 0, -40);
      var_8 = var_6[2] - self._id_94EB.origin[2];

      if(var_8 < 20) {
        var_8 = 20;
        var_6 = (var_6[0], var_6[1], self._id_94EB.origin[2] + 20);
      }

      var_8 = var_8 / 200;
    }

    self._id_94EB moveto(var_6, var_8);
    wait 0.1;
    self setscriptablepartstate("left_leg", "detached", 1);
    self setscriptablepartstate("right_leg", "detached", 1);
    wait(0.8 * var_8);
    self playSound("zombie_facemelter_rocket_launch");
  } else {
    wait 0.9;
    self._id_5FF5 = 1;
    self._id_A546 = 1;
  }

  self setscriptablepartstate("rocket_explosion", "active", 1);
  wait 0.1;
  var_9 = self.origin;
  var_10 = var_0;
  var_11 = var_10.team;

  if(var_5) {
    var_12 = 3;

    for(var_13 = 0; var_13 < var_12; var_13++) {
      var_14 = randomintrange(-200, 200);
      var_15 = randomintrange(-200, 200);
      var_16 = randomintrange(200, 400);
      var_17 = var_9 + (var_14, var_15, var_16) - var_9;
      var_18 = var_0 launchgrenade("zmb_globproj_zm", var_9, var_17, 8);
      var_18.owner = var_0;
      var_18.team = var_0.team;
      var_18._id_F691 = "zmb_globproj_zm";

      if(var_13 == 0) {
        var_18 setscriptablepartstate("explosion", "active");
      } else {
        var_18 setscriptablepartstate("explosion", "neutral");
      }

      var_18 setscriptablepartstate("trail", "active");
      level._id_5886 = scripts\engine\utility::_id_1B8D(level._id_5886, var_18);
      var_18 thread _id_10B6B("iw7_facemelterdummy_zm", var_5);
      waitframe();
    }
  }

  var_19 = self._id_94EB;

  if(isalive(self)) {
    self._id_C8AA = 0;
    self setscriptablepartstate("rocket_feet", "inactive", 1);
    self setscriptablepartstate("rocket_explosion", "inactive", 1);

    if(!isDefined(var_0)) {
      var_0 = undefined;
    }

    self dodamage(self.health + 1000, self.origin, var_0, self._id_94EB, "MOD_GRENADE_SPLASH", "iw7_facemelterdummy_zm");
  }

  if(isDefined(var_19)) {
    var_19 delete();
  }
}

_id_F807() {
  self endon("death");
  self playSound("zombie_facemelter_rocket_feet");
  self waittill("facemelter_launch_chosen");

  if(istrue(self._id_4B40)) {
    wait 0.3;
  } else {
    wait 0.1;
  }

  self setscriptablepartstate("rocket_feet", "active", 1);
}

_id_C440() {
  self endon("death");
  wait 6;
  self._id_C8AA = 0;
}

_id_5884(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 75;
  var_6 = 30;

  if(isDefined(var_4)) {
    wait 0.1;
    self._id_B9DF = spawn("trigger_rotatable_radius", var_0.origin, 0, var_5, var_6);
    self._id_B9DF thread _id_C9C8(var_0, var_1, var_2, var_3);
    self._id_B9DF thread _id_5B49(var_1);
    wait(var_1);
  } else {
    var_7 = spawnfx(level._effect["fire_pool_wide"], var_0.origin);
    var_7 playSound("zombie_facemelter_fire_pool");
    wait 0.1;
    var_8 = spawn("trigger_rotatable_radius", var_0.origin, 0, var_5, var_6);
    var_8 thread _id_C9C8(var_0, var_1, var_2, var_3);
    var_8 thread _id_5B49(var_1);
    var_7 _meth_8322();
    triggerfx(var_7);
    wait(var_1);
    var_7 delete();
  }
}

_id_C9C8(var_0, var_1, var_2, var_3) {
  self endon("fire_pool_done");
  var_4 = var_1 * 10;

  for(;;) {
    self waittill("trigger", var_5);

    if(isDefined(var_5._id_C8AA)) {
      wait 0.1;
      continue;
    } else if(isPlayer(var_5)) {
      if(var_2 == var_5 && !istrue(var_3) && !isDefined(var_5._id_2D86)) {
        if(!istrue(var_5.inlaststand)) {
          var_5._id_2D86 = 1;
          var_5 thread _id_4C54(var_5, self);
        }
      }

      wait 0.1;
      continue;
    } else if(isalive(var_5))
      level thread scripts\cp\utility::_id_42D4(var_5, var_2, 5, var_5.health + 1000, undefined, "iw7_facemelterdummy_zm", 0, "burning");

    wait 0.1;
  }
}

_id_4C54(var_0, var_1) {
  var_0 notify("doDamageAndUnsetBurnState");
  var_0 endon("doDamageAndUnsetBurnState");
  var_0 endon("disconnect");

  if(isalive(var_0)) {
    var_0 dodamage(int(var_0.maxhealth * 0.15), var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_facemelterdummy_zm");
  }

  wait 1;
  var_0._id_2D86 = undefined;
}

_id_5B49(var_0) {
  wait(var_0);
  self notify("fire_pool_done");
  self delete();
}

_id_DD06(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_DD05 = 1;
  self._id_0229 = 1;
  self _meth_8474();
  wait 0.1;
  var_4 = ["left_arm", "right_arm"];
  var_4 = scripts\engine\utility::array_randomize(var_4);

  if(!istrue(self._id_8584)) {
    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.25;
    }

    var_4 = ["right_leg", "left_leg"];
    var_4 = scripts\engine\utility::array_randomize(var_4);

    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.25;
    }

    self setscriptablepartstate("shredder_fx", "active", 1);
    wait 0.25;
    self setscriptablepartstate("head", "detached", 1);
  } else {
    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.1;
    }

    var_4 = ["right_leg", "left_leg"];
    var_4 = scripts\engine\utility::array_randomize(var_4);

    foreach(var_6 in var_4) {
      self setscriptablepartstate(var_6, "disintegrate", 1);
      wait 0.1;
    }

    self._id_5FF5 = 1;
  }

  wait 0.1;
  self._id_A546 = 1;
  self._id_43F2 = "shredder";
  self._id_DD05 = 0;
  self dodamage(self.health + 1000, self.origin, var_0, undefined, "MOD_UNKNOWN", "iw7_shredderdummy_zm");
}

_id_34D4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::_id_8794(var_3) || var_3 == "MOD_EXPLOSIVE_BULLET" && var_5 != "none";

  if(!var_7) {
    return;
  }
  if(!scripts\cp\utility::_id_8891(var_4, var_5, var_3, var_0)) {
    return;
  }
  var_0 scripts\cp\utility::_id_A689("headshot_explosion");
  thread _id_57B2(var_0, var_5, var_2, "bloody_death", undefined, var_6);
}

_id_57B2(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_75DE = 1;
  var_4 = self gettagorigin("J_Spine4");
  playsoundatpos(self.origin, "zmb_fnf_headpopper_explo");
  playFX(level._effect[var_3], var_4);

  foreach(var_7 in level.players) {
    if(distance(var_7.origin, var_4) <= 350) {
      var_7 thread _id_DCD3();
    }
  }

  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
  }

  if(!var_5) {
    self setscriptablepartstate("head", "hide");
  }
}

_id_DCD3() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::_id_108A8(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

_id_75E4() {
  level._effect["head_exploder"] = loadfx("vfx/iw7/_requests/coop/zmb_head_exploder.vfx");
  level._effect["head_expander"] = loadfx("vfx/iw7/_requests/coop/zmb_head_expander.vfx");
  level._effect["head_blood_explosion"] = loadfx("vfx/iw7/_requests/coop/zmb_head_blood_explosion.vfx");
}

_id_75DC(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self._id_75DE = 1;
  wait(randomfloatrange(0.0, 0.5));

  if(!istrue(self._id_8584)) {
    self setscriptablepartstate("eyes", "headcutter_eyes");
  }

  self._id_0229 = 1;
  self _meth_8474();
  wait 1;
  self setscriptablepartstate("eyes", "eye_glow_off");
  wait 0.1;
  self setscriptablepartstate("headcutter_fx", "active");
  wait 0.1;
  self setscriptablepartstate("head", "hide", 1);
  wait 0.1;
  var_1 = self gettagorigin("J_Spine4");
  var_0 thread _id_57B1(var_0, var_1, self, var_4);

  if(istrue(self._id_8584)) {
    self._id_5FF5 = 1;
    self._id_A546 = 1;
  }

  self dodamage(self.health + 1000, self.origin, var_0, undefined, "MOD_UNKNOWN", "iw7_headcutterdummy_zm");
}

_id_57B1(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::weaponhasattachment(var_3, "pap1");
  var_5 = getweaponbasename(var_3);
  var_6 = "iw7_headcutterdummy_zm";
  var_7 = 15000;

  switch (var_5) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
      if(var_4) {
        var_6 = "iw7_headcutter2_zm+hcpap1";
      } else {
        var_6 = "iw7_headcutter2_zm";
      }

      break;
    case "iw7_headcutter2_zm":
      if(var_4) {
        var_6 = "iw7_headcutter3_zm+hcpap1";
      } else {
        var_6 = "iw7_headcutterdummy_zm";
      }

      break;
  }

  var_8 = [];
  var_8 = level._id_E2A4;
  var_9 = [var_2];
  var_10 = 128;

  if(var_4) {
    var_10 = 256;
  }

  var_11 = scripts\engine\utility::_id_6369(var_1, var_8, var_9, undefined, var_10, 0);

  foreach(var_13 in var_11) {
    if(isDefined(var_13._id_1210) && (var_13._id_1210 == "zombie_grey" || var_13._id_1210 == "zombie_brute")) {
      var_14 = 100;
    } else {
      var_14 = 100000;
    }

    var_13 dodamage(var_14, var_1, var_0, var_0, "MOD_EXPLOSIVE", var_6);
  }
}

_id_46DC(var_0, var_1, var_2, var_3) {
  var_3 endon("disconnect");
  wait(var_0);
  var_4 = _func_0143("iw7_headcuttershards_mp", var_1, var_2, var_3);
}

_id_10D25() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self._id_1FD6 = 0;
  self._id_A7C6 = 0;
  self._id_5EFF = 0;
  var_0 = self getcurrentprimaryweapon();
  var_1 = var_0 _meth_8625();
  var_2 = self getcurrentweapon();
  var_3 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.basename == "iw7_axe_zm" && self._id_1FD6 < 3) {
      scripts\cp\utility::_id_D5E9("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self._id_1FD6 = self._id_1FD6 + 1;
    } else if(isDefined(var_1) && var_1.basename == "iw7_forgefreeze_zm" && self._id_5EFF < 5) {
      scripts\cp\utility::_id_D5E9("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self._id_5EFF = self._id_5EFF + 1;
    }

    _id_FC24(var_2, var_3);
    var_3 = var_2;
    self waittill("weapon_change");
    wait 0.5;
    var_0 = self getcurrentprimaryweapon();
    var_1 = var_0 _meth_8625();
    var_2 = self getcurrentweapon();
  }
}

_id_FC24(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = _func_00ED(var_0);
  } else {
    var_2 = undefined;
  }

  if(isDefined(var_1)) {
    var_3 = _func_00ED(var_1);
  } else {
    var_3 = undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  _id_392A(var_1, var_3);
  _id_CA28(var_0, var_2);
}

_id_CA28(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "camo211":
      self setscriptablepartstate("camo_211", "reset");
      break;
    case "camo212":
      self setscriptablepartstate("camo_212", "reset");
      break;
    case "camo204":
      self setscriptablepartstate("camo_204", "activate");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "activate");
      break;
    case "camo84":
      thread _id_25AA();
      break;
    case "camo222":
      thread _id_25A9();
      break;
  }
}

_id_392A(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "camo204":
      self setscriptablepartstate("camo_204", "neutral");
      break;
    case "camo205":
      self setscriptablepartstate("camo_205", "neutral");
      break;
    case "camo84":
      self notify("blood_camo_84");
      break;
    case "camo222":
      self notify("blood_camo_222");
      break;
  }
}

_id_25AA() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_84");

  if(!isDefined(self._id_25AE)) {
    self._id_25AE = 0;
  }

  var_0 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self._id_25AE = self._id_25AE + 1;

    if(self._id_25AE / 5 == var_0) {
      var_1 = int(self._id_25AE / 5);

      if(var_1 > 14) {
        break;
      }

      self setscriptablepartstate("camo_84", var_1 + "_kills");
      var_0++;
    }
  }
}

_id_25A9() {
  self endon("disconnect");
  self endon("death");
  self endon("blood_camo_222");
  self._id_8CAE = 0;
  self setscriptablepartstate("camo_222", "null_state");
  var_0 = 1;

  for(;;) {
    self waittill("zombie_killed");
    self._id_8CAE = self._id_8CAE + 1;

    if(self._id_8CAE / 5 == var_0) {
      var_1 = int(self._id_8CAE / 5);

      if(var_1 > 10) {
        break;
      }

      self setscriptablepartstate("camo_222", var_1 + "_kills");
      var_0++;
    }
  }
}

_id_1FD5() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", var_0, var_1, var_2);
    var_3 = var_0.basename;
    var_4 = scripts\cp\cp_weapon::_id_683D(var_3);
    var_5 = _id_659D(var_3, var_4);
    var_6 = _id_659E(var_3, var_4);
    var_7 = _id_659F(var_3, var_4);
    var_8 = _id_34FB(var_5, var_6, var_7);
    thread _id_D48B(self);

    foreach(var_10 in var_8) {
      if(var_10 == var_1) {
        continue;
      }
      var_10 thread _id_1FD4(var_10, self, var_2, var_10.origin, self.origin, var_0, 0.5);
    }
  }
}

_id_D48A(var_0) {
  var_0 setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe - idle", "level 1");
}

_id_D48B(var_0) {
  var_0 notify("setaxeblooddrip");
  var_0 endon("setaxeblooddrip");
  var_0 setscriptablepartstate("axe", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe", "blood on");
  wait 5;
  var_0 setscriptablepartstate("axe", "neutral");
}

_id_659D(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 45;
  }

  switch (var_1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

_id_659E(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 125;
  }

  switch (var_1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

_id_659F(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  switch (var_1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

_id_65A0(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1100;
  }

  switch (var_1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

_id_3F0A(var_0) {
  var_1 = var_0 / 2;
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.0);
}

_id_B8C7() {
  var_0 = _func_020D(level._effect["repulsor_view_red"], self gettagorigin("tag_eye"), self);
  triggerfx(var_0);
  var_0 thread scripts\cp\utility::_id_46C7(1);
  playrumbleonposition("slide_collision", self.origin);
  self earthquakeforplayer(0.5, 0.5, self.origin, 62.5);
}

_id_34FB(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = _id_06FE::_id_68A1("axis");
  var_6 = scripts\engine\utility::_id_6369(self.origin, var_5, undefined, 24, var_1, 1);

  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectornormalize(var_9) * -25;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::_id_10E76(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);

    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);

        if(var_14 < var_1) {
          var_11 = 1;
        }
      } else
        var_11 = 1;
    }

    if(var_11 && var_4.size < var_2) {
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

_id_1FD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_0._id_0043 = 1;
  var_0 dodamage(var_2, var_3, var_1, var_1, "MOD_MELEE", var_5);
  wait(var_6);

  if(istrue(var_0._id_0043)) {
    var_0._id_0043 = 0;
  }
}

_id_C314() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    self waittill("reload");
  }
}

_id_1A34(var_0) {
  scripts\engine\utility::_id_5C24("doors_initialized");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");

  while(!isDefined(var_0._id_EAF7)) {
    wait 0.1;
  }

  var_0 thread _id_FB05(var_0);

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_3("weapon_change", "weapon_switch_started", "ads_out");
    var_0 _id_38B2(var_0);
    var_0 _id_F7FD();
    var_0 thread _id_1075C(var_0);
  }
}

_id_CF0E() {
  scripts\engine\utility::_id_5C24("doors_initialized");
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("scriptableNotification", var_0, var_1, var_2);

    if(!isDefined(var_0)) {
      continue;
    }
    wait 0.05;
  }
}

_id_FB05(var_0) {
  var_0 endon("disconnect");
  var_0 notifyonplayercommand("ads_in", "+speed_throw");
  var_0 notifyonplayercommand("ads_out", "-speed_throw");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_10897("ads_in", "ads_out");
    var_2 = var_0 getcurrentweapon();

    if(var_2.classname == "weapon_sniper") {
      if(var_1 == "ads_in") {
        var_0 _id_38B3(var_0);
        var_0._id_AF53 = 1;
        continue;
      }

      var_0._id_AF53 = undefined;
    }
  }
}

_id_38B3(var_0) {
  var_0 setscriptablepartstate("arcane", "neutral", 1);
}

_id_38B2(var_0) {
  var_0 setclientomnvar("zm_ui_specialammo", 0);
  var_0._id_E3B8 = undefined;
  var_0 setscriptablepartstate("arcane", "neutral", 1);

  if(var_0 scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }

  if(var_0 scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_armorpiercing");
  }

  if(var_0 scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
    var_0 scripts\cp\utility::_unsetperk("specialty_bulletdamage");
  }
}

_id_1075C(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("wait_for_weapon_switch_done");
  var_0 endon("wait_for_weapon_switch_done");
  var_0 endon("disconnect");
  var_0 endon("weapon_switch_started");

  while(var_0 isswitchingweapon()) {
    wait 0.05;
  }

  var_2 = var_0 getcurrentweapon();
  var_0 notify("weapon_switch_done");
  var_0 _id_1CF5(var_0, undefined, var_2);
  var_0 _id_7418(var_0, var_2);
}

_id_1CF5(var_0, var_1, var_2) {
  if(istrue(var_0._id_AF53)) {
    return;
  }
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      var_2 = self getcurrentweapon();
    }

    if(!var_2 _meth_8624("ark", 1)) {
      return;
    }
    foreach(var_4 in var_2._id_0070) {
      if(issubstr(var_4, "ark")) {
        var_1 = var_4;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = "blank";
  }

  switch (var_1) {
    case "arkblue_sm":
    case "arkblue_akimbo":
    case "blue":
    case "arkblue":
      self setclientomnvar("zm_ui_specialammo", 1);
      self._id_E3B8 = "stun_ammo";
      self._id_E3B9 = var_2;

      if(!scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        scripts\cp\utility::_id_6FC2("specialty_bulletdamage");
      }

      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      self setscriptablepartstate("arcane", "blue_on", 0);
      break;
    case "arkgreen_sm":
    case "arkgreen_akimbo":
    case "arkgreen":
    case "green":
      self._id_E3B8 = "poison_ammo";
      self setclientomnvar("zm_ui_specialammo", 0);
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "green_on", 0);
      break;
    case "arkyellow_sm":
    case "arkyellow_akimbo":
    case "arkyellow":
    case "yellow":
      self setclientomnvar("zm_ui_specialammo", 3);
      self._id_E3B8 = "explosive_ammo";

      if(!scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
        scripts\cp\utility::_id_6FC2("specialty_explosivebullets");
      }

      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "yellow_on", 0);
      break;
    case "arkred_sm":
    case "arkred_akimbo":
    case "arkred":
    case "red":
      self setclientomnvar("zm_ui_specialammo", 2);
      self._id_E3B8 = "incendiary_ammo";
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "red_on", 0);
      break;
    case "arkpink_sm":
    case "arkpink_akimbo":
    case "arkpink_lmg":
    case "pink":
    case "arkpink":
      self setclientomnvar("zm_ui_specialammo", 5);
      self._id_E3B8 = "combined_ammo";

      if(!scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        scripts\cp\utility::_id_6FC2("specialty_bulletdamage");
      }

      if(!scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
        scripts\cp\utility::_id_6FC2("specialty_armorpiercing");
      }

      self setscriptablepartstate("arcane", "pink_on", 0);
      break;
    default:
      self setclientomnvar("zm_ui_specialammo", 0);
      self._id_E3B8 = undefined;
      scripts\cp\utility::_unsetperk("specialty_explosivebullets");
      scripts\cp\utility::_unsetperk("specialty_armorpiercing");
      scripts\cp\utility::_unsetperk("specialty_bulletdamage");
      self setscriptablepartstate("arcane", "neutral", 0);
      break;
  }
}

_id_7418(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getcurrentweapon();
  }

  var_2 = getweaponbasename(var_1);
  _id_F7FD();

  if(isDefined(var_2)) {
    switch (var_2) {
      case "iw7_facemelter_zm_pap1":
      case "iw7_facemelter_zm":
        self setscriptablepartstate("facemelter", "active");
        break;
      case "iw7_headcutter_zm_pap1":
      case "iw7_headcutter_zm":
        self setscriptablepartstate("headcutter", "active");
        break;
      case "iw7_dischord_zm_pap1":
      case "iw7_dischord_zm":
        self setscriptablepartstate("dischord", "active");
        break;
      case "iw7_shredder_zm_pap1":
      case "iw7_shredder_zm":
        self setscriptablepartstate("shredder", "active");
        break;
    }
  }
}

_id_F7FD() {
  self setscriptablepartstate("headcutter", "inactive");
  self setscriptablepartstate("facemelter", "inactive");
  self setscriptablepartstate("dischord", "inactive");
  self setscriptablepartstate("shredder", "inactive");
}

_id_6367(var_0) {
  if(isweapon(var_0)) {
    var_1 = var_0._id_0070;
  } else {
    var_1 = strtok(var_0, "+");
  }

  foreach(var_3 in var_1) {
    var_4 = _func_00D6(var_3, 0, 3);

    if(var_4 == "ark") {
      switch (var_3) {
        case "arkblueburst":
        case "arkblueshotgun":
        case "arkblueautospread":
        case "arkblueauto":
        case "arkbluesingle":
          return "arkblue";
        case "arkgreenburst":
        case "arkgreenshotgun":
        case "arkgreenautospread":
        case "arkgreenauto":
        case "arkgreensingle":
          return "arkgreen";
        case "arkyellowburst":
        case "arkyellowshotgun":
        case "arkyellowautospread":
        case "arkyellowauto":
        case "arkyellowsingle":
          return "arkyellow";
        case "arkpinkburst":
        case "arkpinkshotgun":
        case "arkpinkautospread":
        case "arkpinkauto":
        case "arkpinksingle":
          return "arkpink";
        case "arkredburst":
        case "arkredshotgun":
        case "arkredautospread":
        case "arkredauto":
        case "arkredsingle":
          return "arkred";
        case "arkwhiteburst":
        case "arkwhiteshotgun":
        case "arkwhiteautospread":
        case "arkwhiteauto":
        case "arkwhitesingle":
          return "arkwhite";
      }
    }
  }

  return undefined;
}

_id_10CFD(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = makeweaponfromstring(var_0);
  }

  foreach(var_4 in var_1) {
    if(var_4 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_10B6B(var_0, var_1) {
  self endon("death");
  thread _id_C3C8();
  self waittill("missile_stuck", var_2);

  if(!isDefined(self.owner)) {
    return;
  }
  self setscriptablepartstate("trail", "neutral");
  self setscriptablepartstate("explosion", "active");
  playsoundatpos(self.origin, "plasma_grenade_impact");
  _func_01BA(self.origin, 128, 10, 5, self.owner, "MOD_EXPLOSIVE", var_0);

  if(level._id_5886.size > 5) {
    self delete();
    return;
  }

  var_3 = spawn("trigger_rotatable_radius", self.origin, 0, 60, 60);
  var_3.angles = self.angles;
  var_3.owner = self.owner;
  var_3.team = self.owner.team;
  var_3 thread _id_10BE5(var_0, var_1);
  var_3 thread scripts\cp\utility::_id_46C7(8);
  var_3 thread _id_46D7(0.1, "plasma_grenade_fire_glob");
  self._id_B9DD = "poolGround";
  self setscriptablepartstate("poolGround", "active");
  wait 8;
  self setscriptablepartstate(self._id_B9DD, "activeEnd", 0);
  self delete();
}

_id_C3C8() {
  self waittill("death");
  level._id_5886 = scripts\engine\utility::array_remove(level._id_5886, self);
}

_id_E694(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("disconnect");
  self._id_E6A3 = 1;
  self._id_E6A2 = undefined;
  self._id_8569 = 1;
  thread _id_10B6F();
  thread _id_10C05(var_0, var_1);

  if(isDefined(level._id_E413) && isalive(self) && isDefined(self._id_E3D8) && self._id_E3D8 == "zombie") {
    self thread[[level._id_E413]](self);
  } else {}

  thread _id_E58F(var_0, var_1, var_2, var_3, var_4);
}

_id_B235(var_0, var_1, var_2) {
  var_3 = undefined;
  var_3 = spawnfx(scripts\engine\utility::getfx(var_1), var_0);

  if(isDefined(var_3)) {
    triggerfx(var_3);
  }

  var_3 thread scripts\cp\utility::_id_46C7(var_2);
  return var_3;
}

_id_10BE5(var_0, var_1) {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    self waittill("trigger", var_2);

    if(scripts\cp\utility\player::isreallyalive(var_2) && !isDefined(var_2._id_E6A3) && (var_2.team != self.owner.team || var_2 == self.owner)) {
      if(var_1) {
        if(var_2 == self.owner) {
          continue;
        }
      }

      var_2 notify("start_plasma_stand");
      var_2 thread _id_E694(var_0, self.owner, 33, 0.5, self);
      var_2 thread _id_10B8E(self);
    }
  }
}

_id_10B8E(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(!isDefined(var_0) || !self istouching(var_0)) {
      self notify("plasma_dot_end");
      break;
    }

    waitframe();
  }
}

_id_10B6F() {
  level endon("game_ended");
  self endon("death");
  self waittill("plasma_dot_end");
  self._id_E6A3 = undefined;
  self._id_E6A2 = undefined;
  self._id_704D = undefined;
  self._id_8569 = undefined;
  stopFXOnTag(scripts\engine\utility::getfx("glob_plasma_trail_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_enemy"), self, "j_mainroot");
  stopFXOnTag(scripts\engine\utility::getfx("player_plasma_friendly"), self, "j_mainroot");
}

_id_10C05(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("plasma_dot_end");
  var_1 endon("disconnect");
  self waittill("start_plasma_linger");
  var_2 = 1;
  var_3 = 25;
  var_4 = 1;
  self._id_E6A3 = undefined;
  self._id_E6A2 = 1;
  var_5 = _func_020D(scripts\engine\utility::getfx("player_plasma_screen_linger"), self getEye(), self);
  triggerfx(var_5);
  var_5 thread scripts\cp\utility::_id_46C7(1);
  var_5 thread scripts\cp\utility::_id_477D(self);
  var_5 thread _id_477F(self);
  thread _id_431C(var_0, var_1, var_3, var_4, var_2, "start_plasma_stand", "plasma_dot_end");
}

_id_477A(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("plasma_dot_end");

  if(isDefined(self)) {
    self delete();
  }
}

_id_46D6(var_0, var_1, var_2, var_3) {
  var_2 endon("death");
  wait(var_0);

  if(isDefined(var_2) && isDefined(self)) {
    _func_019D(scripts\engine\utility::getfx(var_1), var_2, var_3, self);
  }
}

_id_E58F(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("disconnect");

  if(isDefined(var_4)) {
    var_4 endon("death");
  }

  var_5 = int(var_2 / 4);
  var_6 = var_3;
  childthread _id_431C(var_0, var_1, var_5, var_6, undefined, "start_stage2_plasma");
  wait 1;
  self notify("start_stage2_plasma");
  var_5 = int(var_2 / 2);
  var_6 = var_3 / 2;
  childthread _id_431C(var_0, var_1, var_5, var_6, undefined, "start_stage3_plasma");
  wait 0.5;
  self notify("start_stage3_plasma");
  var_5 = var_2;
  var_6 = var_3 / 4;
  childthread _id_431C(var_0, var_1, var_5, var_6);
}

_id_431C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  var_1 endon("disconnect");

  if(!isDefined(var_4)) {
    for(;;) {
      self dodamage(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
      self._id_5C4B = gettime() + 500;
      wait(var_3);
    }
  } else {
    if(var_3 > var_4) {
      return;
    }
    var_7 = var_2;

    if(self.health <= var_7) {
      self dodamage(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
      self._id_5C4B = gettime() + 500;
    }

    while(var_4 > 0) {
      if(self.health > 15 && self.health - var_2 < 15) {
        var_2 = var_2 - (15 - (self.health - var_2));
      }

      if(self.health > var_7 && self.health <= 15) {
        var_2 = 1;
      }

      if(var_2 > 0) {
        self dodamage(var_2, self.origin, var_1, undefined, "MOD_EXPLOSIVE", var_0);
        self._id_5C4B = gettime() + 500;
      }

      var_4 = var_4 - var_3;
      wait(var_3);
    }

    if(isDefined(var_6)) {
      self notify(var_6);
    }
  }
}

_id_477F(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("start_plasma_stand");

  if(isDefined(self)) {
    self delete();
  }
}

_id_46D7(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self playSound(var_1);
}