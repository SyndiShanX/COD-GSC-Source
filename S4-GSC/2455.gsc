/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2455.gsc
*************************************************/

_id_2F44(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(level.soak_testing) && level.soak_testing) {
    return;
  }
  if(isdedicatedserver() && getdvarint("#x3d555e8fc9032beda")) {
    return;
  }
  var_15 = getcompleteweaponname(var_5);
  var_16 = self;

  if(!_id_DBF8(var_2, var_1, var_15, var_3)) {
    return;
  }
  if(var_4 == "MOD_SUICIDE") {
    if(isDefined(level._id_AD1E[var_15])) {
      level thread[[level._id_AD1E[var_15]]](var_16, var_15);
    }
  }

  var_17 = isDefined(var_4) && (var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH");
  var_18 = isDefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_19 = _id_886D(self, var_1);
  var_20 = scripts\cp\utility::_id_85EA();
  var_21 = scripts\cp\utility::_id_7531("perk_machine_boom");
  var_22 = isDefined(var_1);
  var_23 = var_22 && isDefined(var_1._id_E3D8) && var_1._id_E3D8 == "zombie";
  var_24 = 0;

  if(var_22 && isDefined(var_1._id_110B0)) {
    var_24 = var_1._id_110B0 == "juggernaut" || var_1._id_110B0 == "screamer" || var_1._id_110B0 == "trickster";
  }

  var_25 = var_22 && isDefined(var_1._id_E3D8) && var_1._id_E3D8 == "zombie_grey";
  var_26 = var_22 && isDefined(var_1._id_1210) && var_1._id_1210 == "zombie_brute";
  var_27 = var_22 && var_1 == self;
  var_28 = (var_27 || !var_22) && var_4 == "MOD_SUICIDE";

  if(var_22) {
    if(var_1 == self) {
      if(issubstr(var_15, "iw7_harpoon2_zm") || issubstr(var_15, "iw7_harpoon1_zm") || issubstr(var_15, "iw7_acid_rain_projectile_zm")) {
        var_2 = 0;
      }

      if(var_17) {
        if(var_21) {
          var_2 = 0;
        } else {
          var_2 = _id_6496(var_0, var_1, var_2, var_3, var_4, var_15);
        }
      }

      switch (var_15) {
        case "zmb_fireworksprojectile_mp":
        case "iw7_armageddonmeteor_mp":
        case "zmb_imsprojectile_mp":
          var_2 = 0;
          break;
        case "iw7_stunbolt_zm":
        case "iw7_bluebolts_zm":
        case "blackhole_grenade_zm":
        case "blackhole_grenade_mp":
          var_2 = 25;
          break;
        default:
          break;
      }
    } else if(var_19) {
      if(var_20) {
        if(scripts\cp\utility::_id_86A0()) {
          if(isPlayer(var_1) && isDefined(var_8) && var_8 != "shield") {
            if(isDefined(var_0)) {
              var_1 dodamage(var_2, var_1.origin - (0, 0, 50), var_1, var_0, var_4);
            } else {
              var_1 dodamage(var_2, var_1.origin, var_1);
            }
          }

          var_2 = 0;
        }
      } else
        var_2 = 0;
    } else if(var_23) {
      if(issubstr(var_15, "zombie_ranged_attack_mp") && isDefined(var_1._id_9D80)) {
        var_2 = var_1._id_9D80;
      }

      if(var_4 != "MOD_EXPLOSIVE" && var_16 scripts\cp\utility::_id_8580("burned_out")) {
        if(!istrue(var_1._id_8569)) {
          var_16 scripts\cp\utility::_id_A689("burned_out");
          var_1 thread scripts\cp\utility::_id_42D4(var_1, var_16, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
          var_1._id_58C9 = 1;
        }
      }

      var_29 = gettime();

      if(!isDefined(self._id_8F80) || var_29 - self._id_8F80 > 200) {
        self._id_8F80 = var_29;
      } else {
        return;
      }

      var_30 = 500;

      if(getdvarint("#x32023755ea26eb46f") != 0) {
        var_30 = getdvarint("#x32023755ea26eb46f");
      }

      if(isDefined(var_1._id_8F13[self._id_105F0])) {
        var_31 = var_1._id_8F13[self._id_105F0];

        if(var_31 + var_30 > gettime()) {
          var_2 = 0;
        } else {
          var_1._id_8F13[self._id_105F0] = gettime();
        }
      } else
        var_1._id_8F13[self._id_105F0] = gettime();

      var_16.killswithoutgettinghit = 0;
      var_16.killswithoutgettinghit_ar = 0;

      if(isDefined(var_16.b_getting_hit_in_objective)) {
        var_16.b_getting_hit_in_objective = 1;
      }
    } else if(var_25)
      var_2 = _id_6433(var_0, var_1, var_2, var_3, var_4, var_15);

    if(var_18) {
      if(var_21) {
        var_2 = 0;
      } else if(!var_20 || var_1 == self && var_8 == "none") {
        var_2 = 0;
      }
    } else if(var_24) {
      var_16.killswithoutgettinghit = 0;
      var_16.killswithoutgettinghit_ar = 0;

      if(isDefined(var_16.b_getting_hit_in_objective)) {
        var_16.b_getting_hit_in_objective = 1;
      }
    }
  } else if(var_21 && var_4 == "MOD_SUICIDE") {
    if(var_15 == "frag_grenade_zm" || var_15 == "cluster_grenade_zm") {
      var_2 = 0;
    }
  }

  if(var_4 == "MOD_FALLING") {
    if(scripts\cp\utility::_hasperk("specialty_falldamage")) {
      var_2 = 0;
    } else if(var_2 > 10) {
      if(var_2 > self.health * 0.15) {
        var_2 = int(self.health * 0.15);
      }
    } else
      var_2 = 0;
  }

  var_32 = 0.0;

  if(var_22 && var_1 scripts\cp\utility::_id_872B() && istrue(self._id_9501)) {
    if(self.health - var_2 < 1) {
      var_2 = self.health - 1;
    }
  }

  if(var_23 || var_25 || var_26 || var_27 && !var_28) {
    var_2 = int(var_2 * var_16 scripts\cp\utility::_id_69C1());
  }

  if((var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") && istrue(self._id_75A5)) {
    if(var_8 == "shield") {
      self dodamage(int(var_2 * scripts\cp\utility::get_riot_shield_bullet_damage_percent()), var_6, var_1, var_0, var_4, var_5, "torso_upper");
    } else if(var_1 scripts\cp\utility::isprotectedbyriotshieldcp(self)[0]) {
      var_33 = var_2;
      var_2 = int(var_2 * scripts\cp\utility::get_riot_shield_bullet_damage_percent());
      var_34 = var_33 - var_2;
      _id_070F::createabsorbdamageevent(self, var_1, var_4, var_34);
    }
  }

  var_2 = int(_id_0707::_id_42B7(self, var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8, var_9, var_32, var_10, var_11));

  if(isDefined(self._id_9500)) {
    var_2 = int(max(self.maxhealth / 2.75, var_2));
  }

  if(var_16 scripts\cp\utility::_id_8580("secret_service") && isalive(var_1)) {
    var_35 = !isDefined(var_1._id_1210) || var_23 || !var_25 || !var_26 || istrue(var_1._id_86D9) || !istrue(var_1._id_54D1);
    var_36 = isDefined(var_1._id_1210) && (var_23 && (!var_25 || !var_26 || istrue(var_1._id_86D9) || !istrue(var_1._id_54D1)));
    var_36 = 0;

    if(isDefined(var_1._id_1210) && (var_1._id_1210 == "karatemaster" || var_25 || var_26 || istrue(var_1._id_86D9) || !istrue(var_1._id_54D1))) {
      var_36 = 0;
    } else if(var_1 scripts\cp\utility::_id_1216()) {
      var_36 = 0;
    } else {
      var_36 = 1;
    }

    if(var_36) {
      var_16 scripts\cp\utility::_id_A689("secret_service");
    }
  }

  var_2 = int(var_2);

  if(isDefined(var_5.basename) && var_5.basename == "s4_ar_tgun_mp" && isDefined(var_4) && var_4 == "MOD_PROJECTILE_SPLASH") {
    if(isDefined(var_1) && self == var_1) {
      var_2 = 2;

      if(isDefined(level.dg2_splash_vfx_func)) {
        self thread[[level.dg2_splash_vfx_func]]();
      }
    } else
      var_2 = 0;
  }

  if(!var_19 || var_20) {
    _id_5B1C(var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8, var_9, var_32, var_10, var_11);
    self notify("player_damaged");
  }

  _id_072C::_id_FBA7("personal", "damage_taken", var_2);

  if(var_2 <= 0) {
    return;
  }
  thread scripts\cp\utility::_id_B573(var_1);
  thread _id_B29B(self);
  thread scripts\cp\utility::_id_B572();

  if(isDefined(var_1)) {
    thread scripts\cp\cp_hud_util::_id_B400();

    if(isagent(var_1)) {
      if(!isDefined(var_1._id_42BC)) {
        var_1._id_42BC = 0;
      } else {
        var_1._id_42BC = var_1._id_42BC + var_2;
      }

      self._id_C0E8 = var_1;

      if(isDefined(level._id_4158)) {
        self[[level._id_425B]](var_0, var_1, var_2, var_3, var_4, var_15, var_6, var_7, var_8);
      }
    }
  }

  self.consecutiveweaponkills = [];

  if(var_22 && isDefined(var_1._id_110B0) && var_1._id_110B0 == "trickster") {
    self.a_hit_trickers = scripts\cp\utility::_id_459B(self.a_hit_trickers, []);
    self.a_hit_trickers = scripts\cp\utility::_id_1B8C(self.a_hit_trickers, var_1);
  }

  thread scripts\cp\utility::_id_FCF9();
}

_id_B29B(var_0) {
  var_0 notify("play_pain_photo");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("play_pain_photo");

  if(!isDefined(level._id_B73B)) {
    return;
  }
  if(_id_073B::_id_B4EF(var_0)) {
    return;
  }
  [[level._id_B73B]](var_0, "damaged");
  wait 4;
  [[level._id_B73B]](var_0, "healthy");
}

_id_46B8(var_0) {
  self endon("death");
  var_0 endon("death");
  wait 0.05;
  self dodamage(2, self.origin, var_0, undefined, "MOD_MELEE");
}

_id_6496(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    return var_2;
  }

  var_6 = getweaponbasename(var_5);

  if(!isDefined(var_6)) {
    return var_2;
  }

  switch (var_6) {
    case "iw7_chargeshot_zm":
    case "throwingknifec4_mp":
    case "semtex_zm":
    case "frag_grenade_zm":
      var_7 = var_2 / 1200;
      var_2 = var_7 * 100;
      break;
    case "iw7_blackholegun_mp":
    case "c4_zm":
      var_7 = var_2 / 2000;
      var_2 = var_7 * 100;
      break;
    case "iw7_glprox_zm":
    case "cluster_grenade_zm":
      var_7 = var_2 / 800;
      var_2 = var_7 * 100;
      break;
    case "iw7_g18_zml":
    case "iw7_g18_zmr":
    case "iw7_g18_zm":
      if(scripts\cp\cp_weapon::_id_683D(var_6) <= 2) {
        var_7 = var_2 / 1800;
        var_2 = var_7 * 100;
        break;
      } else
        var_2 = 0;

      break;
    case "iw7_armageddonmeteor_mp":
      var_2 = 0;
      break;
    case "iw7_stunbolt_zm":
    case "iw7_bluebolts_zm":
      var_2 = var_2 * 0.33;
      var_2 = min(80, var_2);
      break;
    case "iw7_headcutter3_zm":
    case "iw7_headcutter2_zm":
    case "iw7_dischorddummy_zm":
    case "iw7_facemelterdummy_zm":
    case "iw7_headcutterdummy_zm":
    case "iw7_shredderdummy_zm":
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      var_2 = 0;
      break;
    case "iw7_headcuttershards_mp":
      var_2 = 0;
      break;
    case "splash_grenade_zm":
    case "splash_grenade_mp":
      var_2 = min(10, var_2);
      break;
    case "s4_pi_raygun_mp":
      var_2 = min(25, var_2);
      break;
    default:
      break;
  }

  var_2 = min(80, var_2);
  var_2 = var_2 * var_1 scripts\cp\covenants\cp_explosives_expert::get_explosives_expert_self_reduction(var_6);
  return var_2;
}

_id_6433(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4)) {
    switch (var_4) {
      case "MOD_EXPLOSIVE":
        return var_2;
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        return min(80, var_2);
      case "MOD_UNKNOWN":
        return var_2;
      default:
        return var_2;
    }
  }

  return var_2;
}

_id_DC03(var_0) {
  var_1 = 20;

  if(var_0 == 0) {
    return 0;
  } else {
    return self._id_75D0 && var_0 > self.health && var_0 < self.health + var_1;
  }
}

_id_FF19(var_0) {
  var_1 = 0.2;
  var_2 = self.maxhealth * var_1;
  return scripts\cp\utility::_id_8ACE() && (var_0 > self.health || self.health - var_0 <= var_2);
}

_id_E94A() {
  self notify("stop_using_remote");
}

_id_FE85(var_0) {
  self.health = var_0 + 1;
  self._id_75D0 = 0;
}

_id_DBF8(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && (var_2 == "zmb_imsprojectile_mp" || var_2 == "zmb_fireworksprojectile_mp") || var_2 == "zmb_robotprojectile_mp") {
    return 0;
  }

  if(isDefined(var_2) && var_2 == "bolasprayprojhome_mp") {
    return 0;
  }

  if(isDefined(var_3) && (var_3 == 256 || var_3 == 258)) {
    return 0;
  }

  if(isDefined(self.inlaststand) && self.inlaststand) {
    return 0;
  }

  if(gettime() < self._id_4329) {
    return 0;
  }

  if(isDefined(self._id_0E05)) {
    return 0;
  }

  if(isDefined(var_1) && isDefined(var_1._id_863E)) {
    return 0;
  }

  if(istrue(self._id_864C)) {
    return 0;
  }

  if(isDefined(self._id_85CC)) {
    return 0;
  }

  if(isDefined(self._id_94FF)) {
    return 0;
  }

  return 1;
}

_id_D13E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(var_1 == "xm25_mp" && var_0 == "MOD_IMPACT") {
      var_2 = 95;
    }

    if(var_1 == "spider_beam_mp") {
      var_2 = var_2 * 15;
    }

    if(var_1 == "alienthrowingknife_mp" && var_0 == "MOD_IMPACT") {
      if(_id_06FE::_id_6305(self) != "elite") {
        var_2 = 500;
      }
    }
  }

  return var_2;
}

_id_FB52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isDefined(var_1.owner)) {
    _id_06FE::_id_E9B2(var_1.owner, var_2 * 0.75);
  } else if(isDefined(var_1) && isDefined(var_1._id_B02C) && var_1._id_B02C == 1) {
    _id_06FE::_id_E9B2(var_1.owner, var_2);
  } else {
    _id_06FE::_id_E9B2(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_5)) {
    level thread _id_FBEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
  }

  _id_FB36(var_1, var_2, var_4);
}

_id_FBEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(self._id_4982)) {
    return;
  }
  if(!isDefined(level._id_4158)) {
    return;
  }
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = self[[level._id_422F]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10);

    if(!istrue(var_11)) {
      return;
    }
  }
}

_id_FB36(var_0, var_1, var_2) {
  if(isDefined(level._id_FB36)) {
    [[level._id_FB36]](var_0, var_1, var_2);
  } else {
    _id_FBA5(var_0, var_1, var_2);
  }
}

_id_FBA5(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return;
  }
  if(var_2 == "MOD_TRIGGER_HURT") {
    return;
  }
  _id_072C::_id_FBD9(_id_072C::_id_67C3(), "damage_done_on_alien", var_1);

  if(isPlayer(var_0)) {
    var_0 _id_072C::_id_FBA7("personal", "damage_done_on_alien", var_1);
  } else if(isDefined(var_0.owner)) {
    var_0.owner _id_072C::_id_FBA7("personal", "damage_done_on_alien", var_1);
  }
}

_id_1B58(var_0, var_1, var_2) {
  return 1.0;
}

_id_EAA6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(self._id_EAA5)) {
    return 0;
  }

  var_7 = gettime();

  if(isDefined(self._id_8F69) && !isDefined(var_5)) {
    if(var_7 < self._id_8F69) {
      return;
    }
  }

  self._id_8F69 = var_7 + 500;
  var_8 = 0;
  var_9 = 0;
  var_10 = 4;

  if(!isDefined(var_4)) {
    var_4 = 256;
  }

  var_11 = _id_06FE::_id_68A1("axis");
  var_12 = scripts\engine\utility::_id_6369(var_1.origin, var_11, undefined, var_10, var_4, 1);

  if(scripts\engine\utility::array_contains(var_12, var_1)) {
    var_12 = scripts\engine\utility::array_remove(var_12, var_1);
  }

  if(var_12.size >= 1) {
    if(!isDefined(self._id_EAA5)) {
      self._id_EAA5 = spawnStruct();
    }

    if(istrue(var_5)) {
      var_2 = int(var_2);
    } else {
      var_2 = int(var_2 * 0.5);
    }

    var_13 = ["j_crotch", "j_hip_le", "j_hip_ri"];
    var_0 = var_1 gettagorigin(scripts\engine\utility::random(var_13));

    foreach(var_15 in var_12) {
      if(isDefined(var_15) && var_15 != var_1 && isalive(var_15) && !istrue(var_15._id_EAAB)) {
        var_8 = 1;

        if(istrue(var_5)) {
          var_15._id_D9E9 = 1;
        }

        var_15 _id_EAA1(self, var_2, var_3, var_0);
        var_9++;

        if(var_9 >= var_10) {
          break;
        }
      }
    }

    wait 0.05;
    self._id_EAA5 = undefined;
  }

  if(istrue(var_5)) {
    scripts\cp\utility::_id_A689("shock_melee_upgrade");
    var_1._id_D9E9 = 1;
  }

  if(isDefined(var_6)) {
    self notify(var_6);
  }

  return var_8;
}

_id_EAA1(var_0, var_1, var_2, var_3) {
  self endon("death");
  waitframe();
  var_4 = undefined;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_5 = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  var_4 = self gettagorigin(scripts\engine\utility::random(var_5));

  if(isDefined(var_4)) {
    _func_0313(level._effect["blue_ark_beam"], var_3, vectortoangles(var_3 - var_4), var_4);
    wait 0.05;

    if(isDefined(self) && var_2 == "MOD_MELEE") {
      self playSound("zombie_fence_shock");
    }

    wait 0.05;
    var_6 = int(var_1);
    _id_06D6::_id_B842(level._effect["stun_shock"], var_4);

    if(isDefined(self)) {
      thread _id_EAA2(var_0, var_2, var_6, "stun_ammo_mp");
    }
  }
}

_id_EAA2(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = 100;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  } else {
    var_5 = "iw7_stunbolt_zm";
  }

  if(!_id_0909::_id_8A73()) {
    self._id_EAAB = 1;
    thread _id_075B::_id_19F5(self);
    self._id_EAA4 = gettime() + 1500;
  }

  thread _id_C451(1);

  if(isDefined(var_0)) {
    self dodamage(var_4, self.origin, var_0, var_0, var_1, var_5);
  } else {
    self dodamage(var_4, self.origin, undefined, undefined, var_1, var_5);
  }
}

_id_C451(var_0) {
  self endon("death");
  wait(var_0);

  if(!scripts\cp\utility::_id_DA7B(self)) {
    return;
  }
  self._id_EAAB = undefined;
}

_id_886D(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

_id_5B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!_id_2F33(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self)) {
    self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  _id_4327(var_0, var_5, var_4, var_2, var_3, var_1);
}

_id_2F33(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_8FB7) && self._id_8FB7 && var_2 >= self.health && isDefined(self._id_3AB0) && self._id_3AB0 == "specialty_endgame") {
    scripts\cp\utility::_id_6FC2("specialty_endgame");
    return 0;
  }

  return 1;
}

_id_4327(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_ABD9(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

_id_ABD9(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");

  switch (var_1) {
    default:
      if(_id_15D4(var_1) && !isai(var_4)) {
        scripts\cp\cp_weapon::_id_D9D4(var_2, var_3);
      }

      break;
  }
}

_id_15D4(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "iw7_zapper_grey":
        return 0;
    }
  }

  return 1;
}