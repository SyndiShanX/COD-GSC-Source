/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\362.gsc
**************************************/

_id_2852() {
  if(!isDefined(self.vehicletype)) {
    return;
  }
  var_0 = 0;

  if(self.vehicletype == "hind" || self.vehicletype == "ny_harbor_hind") {
    var_0 = 1;
  }
  if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player") {
    thread _id_286C("chopperpilot_hellfire", "cobra_Sidewinder");

    if(isDefined(self._id_2853)) {
      self._id_2853 thread _id_286C("chopperpilot_hellfire", "cobra_Sidewinder");
    }
    var_0 = 1;
  }

  if(!var_0) {
    return;
  }
  level thread _id_2856(self);
  level thread maps\_helicopter_ai::_id_2845(self);

  if(getDvar("cobrapilot_wingman_enabled") == "1") {
    if(isDefined(self._id_2854)) {
      level._id_2855 = self;
      level thread maps\_helicopter_ai::_id_284E(self);
    }
  }
}

_id_2856(var_0) {
  var_0 endon("death");
  notifyoncommand("flare_button", "+frag");
  notifyoncommand("flare_button", "+usereload");
  notifyoncommand("flare_button", "+activate");

  while(var_0.health > 0) {
    if(isDefined(var_0._id_2857)) {
      var_0._id_2858 waittill("flare_button");
    } else {
      var_0 waittill("incomming_missile", var_1);

      if(!isDefined(var_1)) {
        continue;
      }
      if(randomint(3) == 0) {
        continue;
      }
      wait(randomfloatrange(0.5, 1.0));
    }

    thread _id_285B(var_0);
    wait 3.0;
  }
}

_id_2859(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    playFX(level._id_285A[var_0.vehicletype], var_0 gettagorigin("tag_flare"));

    if(isDefined(var_0._id_2857)) {
      level.stats["flares_used"]++;
      var_0 notify("dropping_flares");

      if(var_4) {
        var_0 playSound("cobra_flare_fire");
      }
      var_4 = !var_4;
    }

    if(var_5 <= var_2 - 1) {
      thread _id_2860(var_0, var_3);
    }
    wait 0.1;
  }
}

_id_285B(var_0) {
  var_0 endon("death");
  var_1 = 5.0;

  if(isDefined(var_0._id_285C)) {
    var_1 = var_0._id_285C;
  }
  _id_2859(var_0, 8, 1, var_1);
}

_id_285D() {
  if(isDefined(self._id_285E)) {
    missile_deleteattractor(self._id_285E);
  }
  self._id_285E = missile_createattractorent(self._id_285F, 10000, 10000);
}

_id_2860(var_0, var_1) {
  var_0 notify("flares_out");
  var_0 endon("death");
  var_0 endon("flares_out");

  if(!isDefined(var_1)) {
    var_1 = 5.0;
  }
  var_2 = _id_2863(var_0);
  var_3 = spawn("script_origin", var_0 gettagorigin("tag_flare"));
  var_3 movegravity(var_2, var_1);
  var_4 = undefined;

  if(isDefined(var_0._id_2857)) {
    if(isDefined(var_0._id_285E)) {
      missile_deleteattractor(var_0._id_285E);
    }
    var_4 = missile_createattractorent(var_3, 10000, 10000);
  }

  if(isDefined(var_0._id_2861)) {
    for(var_5 = 0; var_5 < var_0._id_2861.size; var_5++) {
      var_0._id_2861[var_5] missile_settargetent(var_3);
    }
  }

  wait(var_1);

  if(isDefined(var_0._id_2857)) {
    if(isDefined(var_4)) {
      missile_deleteattractor(var_4);
    }
    var_0 thread _id_285D();
  }

  if(!isDefined(var_0.script_targetoffset_z)) {
    var_0.script_targetoffset_z = 0;
  }
  var_6 = (0, 0, var_0.script_targetoffset_z);

  if(!isDefined(var_0._id_2861)) {
    return;
  }
  for(var_5 = 0; var_5 < var_0._id_2861.size; var_5++) {
    var_0._id_2861[var_5] missile_settargetent(var_0, var_6);
  }
}

_id_2863(var_0) {
  var_1 = var_0.origin;
  wait 0.05;
  var_2 = var_0.origin - var_1;
  return var_2 * 20;
}

_id_2864(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");

  if(!isDefined(var_1._id_2861)) {
    return;
  }
  var_1._id_2861 = common_scripts\utility::array_remove(var_1._id_2861, var_0);
}

_id_2865(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  if(!isDefined(var_4)) {
    var_4 = 1;
  }
  if(!isDefined(var_5)) {
    var_5 = 0;
  }
  var_7 = [];
  var_8 = undefined;
  var_9 = common_scripts\utility::get_enemy_team(self.script_team);
  var_10 = [];

  if(var_4) {
    for(var_11 = 0; var_11 < level._id_0B5A[var_9].size; var_11++) {
      var_10[var_10.size] = level._id_0B5A[var_9][var_11];
    }
  }

  if(var_2) {
    var_12 = getaiarray(var_9);

    for(var_11 = 0; var_11 < var_12.size; var_11++) {
      if(isDefined(var_12[var_11]._id_2866)) {
        continue;
      }
      var_10[var_10.size] = var_12[var_11];
    }

    if(var_9 == "allies") {
      for(var_11 = 0; var_11 < level.players.size; var_11++) {
        var_10[var_10.size] = level.players[var_11];
      }
    }
  }

  if(isDefined(var_6)) {
    var_10 = maps\_utility::_id_264D(var_10, var_6);
  }
  if(var_5) {
    var_10 = maps\_utility::_id_0B53(var_10);
  }
  var_13 = anglesToForward(self.angles);

  for(var_11 = 0; var_11 < var_10.size; var_11++) {
    if(issentient(var_10[var_11]) && issentient(self) && self getthreatbiasgroup() != "") {
      var_14 = getthreatbias(var_10[var_11] getthreatbiasgroup(), self getthreatbiasgroup());

      if(var_14 <= -1000000) {
        continue;
      }
    }

    if(isDefined(var_0) && var_0 > 0) {
      if(distance(self.origin, var_10[var_11].origin) > var_0) {
        continue;
      }
    }

    if(isDefined(var_1)) {
      var_15 = vectornormalize(var_10[var_11].origin - self.origin);
      var_16 = vectordot(var_13, var_15);

      if(var_16 <= var_1) {
        continue;
      }
    }

    if(var_3) {
      var_17 = 0;

      if(isai(var_10[var_11])) {
        var_18 = 48;
      } else {
        var_18 = 150;
      }
      var_17 = sighttracepassed(self.origin, var_10[var_11].origin + (0, 0, var_18), 0, self);

      if(!var_17) {
        continue;
      }
    }

    var_7[var_7.size] = var_10[var_11];
  }

  self notify("gunner_new_target");

  if(var_7.size == 0) {
    return var_8;
  }
  if(var_7.size == 1) {
    return var_7[0];
  }
  var_19 = maps\_utility::_id_0AE9(self.origin, var_7);
  return var_19;
}

_id_2867(var_0) {
  self endon("death");
  self endon("mg_off");
  var_0 endon("death");
  self endon("gunner_new_target");

  if(isDefined(self._id_2857)) {
    self endon("gunner_stop_firing");
  }
  var_1 = (0, 0, 0);

  if(isDefined(var_0.script_targetoffset_z)) {
    var_1 = var_1 + (0, 0, var_0.script_targetoffset_z);
  } else if(issentient(var_0)) {
    var_1 = (0, 0, 32);
  }
  self setturrettargetent(var_0, var_1);

  while(self.health > 0) {
    var_2 = randomintrange(1, 25);

    if(getDvar("cobrapilot_debug") == "1") {
      iprintln("randomShots = " + var_2);
    }
    for(var_3 = 0; var_3 < var_2; var_3++) {
      if(isDefined(self._id_2857)) {
        if(isDefined(level._id_2868) && level._id_2868.size > 0) {
          self setvehweapon(level._id_2869);
        }
      }

      thread _id_286B(self, "tag_turret", var_0, var_1, (1, 1, 0), 0.05);
      self fireweapon("tag_flash");

      if(isDefined(self._id_2857)) {
        self setvehweapon(level._id_2868[self._id_2858.currentweapon].v["weapon"]);
      }
      wait 0.05;
    }

    wait(randomfloatrange(0.25, 2.5));
  }
}

_id_286B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getDvar("cobrapilot_debug") != "1") {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }
  var_2 endon("death");
  self endon("gunner_new_target");

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }
  if(isDefined(var_5)) {
    var_5 = gettime() + var_5 * 1000;

    while(gettime() < var_5) {
      wait 0.05;
    }
  } else {
    for(;;) {
      wait 0.05;
    }
  }
}

_id_286C(var_0, var_1, var_2, var_3) {
  self._id_286D = 1;
  var_4 = [];
  var_4[0] = var_0;

  if(isDefined(var_1)) {
    var_4[1] = var_1;
  }
  if(isDefined(var_2)) {
    var_4[2] = var_2;
  }
  if(isDefined(var_3)) {
    var_4[3] = var_3;
  }
  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    for(var_6 = 0; var_6 < level._id_286E[var_4[var_5]].size; var_6++) {
      self attach(level.cobra_missile_models[var_4[var_5]], level._id_286E[var_4[var_5]][var_6]);
    }
  }
}

fire_missile(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  var_5 = undefined;
  var_6 = undefined;
  var_7 = "cobra_20mm";
  var_8 = [];

  switch (var_0) {
    case "f15_missile":
      var_5 = "cobra_Sidewinder";
      var_8[0] = "le_side_wing_jnt";
      var_8[1] = "ri_side_wing_jnt";
      break;
    case "mi28_seeker":
      var_5 = "cobra_seeker";
      var_8[0] = "tag_store_L_1_a";
      var_8[1] = "tag_store_R_1_a";
      var_8[2] = "tag_store_L_2_a";
      var_8[3] = "tag_store_R_2_a";
      break;
    case "ffar":
      var_5 = "cobra_FFAR";
      var_8[0] = "tag_store_r_2";
      break;
    case "seeker":
      var_5 = "cobra_seeker";
      var_8[0] = "tag_store_r_2";
      break;
    case "ffar_bog_a_lite":
      var_5 = "cobra_FFAR_bog_a_lite";
      var_8[0] = "tag_store_r_2";
      break;
    case "ffar_airlift":
      var_5 = "cobra_FFAR_airlift";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "ffar_airlift_nofx":
      var_5 = "cobra_FFAR_airlift_nofx";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "cobra_zippy":
      var_5 = "zippy_rockets";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "apache_zippy":
      var_5 = "zippy_rockets_apache";
      var_8[0] = "tag_flash_2";
      var_8[1] = "tag_flash_3";
      break;
    case "apache_zippy_nd":
      var_5 = "zippy_rockets_apache_nodamage";
      var_8[0] = "tag_flash_2";
      var_8[1] = "tag_flash_3";
      break;
    case "mi28_zippy":
      var_5 = "zippy_rockets_apache";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "mi28_zippy_cheap":
      var_5 = "zippy_rockets_apache_cheap";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "cobra_turret":
      var_5 = "hind_turret_penetration";
      var_8[0] = "tag_store_L_wing";
      var_8[1] = "tag_store_R_wing";
      break;
    case "ffar_hind":
      var_7 = "hind_turret";
      var_5 = "hind_FFAR";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_zippy":
      var_7 = "hind_turret";
      var_5 = "zippy_rockets";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_rpg":
      var_7 = "hind_turret";
      var_5 = "rpg";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "hind_rpg_cheap":
      var_7 = "hind_turret";
      var_5 = "rpg_cheap";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "ffar_hind_nodamage":
      var_7 = "hind_turret";
      var_5 = "hind_FFAR_nodamage";
      var_8[0] = "tag_missile_left";
      var_8[1] = "tag_missile_right";
      break;
    case "ffar_mi28_village_assault":
      var_7 = "hind_turret";
      var_5 = "mi28_ffar_village_assault";
      var_8[0] = "tag_store_L_2_a";
      var_8[1] = "tag_store_R_2_a";
      var_8[2] = "tag_store_L_2_b";
      var_8[3] = "tag_store_R_2_b";
      var_8[4] = "tag_store_L_2_c";
      var_8[5] = "tag_store_R_2_c";
      var_8[6] = "tag_store_L_2_d";
      var_8[7] = "tag_store_R_2_d";
      break;
    case "ffar_co_rescue":
      var_5 = "cobra_FFAR_bog_a_lite";
      var_8[0] = "tag_store_R_2_a";
      var_8[1] = "tag_store_L_2_a";
      break;
    default:
      break;
  }

  var_6 = weaponfiretime(var_5);

  if(isDefined(self._id_2871)) {
    var_9 = self._id_2871;
  } else {
    var_9 = -1;
  }
  for(var_10 = 0; var_10 < var_1; var_10++) {
    var_9++;
    var_9 = var_9 % var_8.size;

    if(var_0 == "ffar_mi28_village_assault") {
      if(isDefined(var_2) && isDefined(var_2.origin)) {
        magicbullet(var_5, self gettagorigin(var_8[var_9]), var_2.origin);

        if(isDefined(level._effect["ffar_mi28_muzzleflash"])) {
          playFXOnTag(common_scripts\utility::getfx("ffar_mi28_muzzleflash"), self, var_8[var_9]);
        }
        thread _id_2872(0.1, 0.5, 0.2, var_2.origin, 1600);
      }
    } else {
      self setvehweapon(var_5);

      if(isDefined(var_2)) {
        var_11 = self fireweapon(var_8[var_9], var_2);
        maps\_audio::aud_send_msg("missile_fired", var_11);

        switch (var_0) {
          case "ffar_airlift":
          case "ffar_bog_a_lite":
          case "ffar":
            var_11 thread _id_2873(0.1);
            break;
          case "apache_zippy_wall":
          case "mi28_zippy_cheap":
          case "mi28_zippy":
          case "apache_zippy_nd":
          case "apache_zippy":
            if(!isDefined(var_4)) {
              var_11 thread _id_2873(0.6);
            } else {
              var_11 thread _id_2873(var_4);
            }
            break;
          default:
            break;
        }
      } else {
        var_11 = self fireweapon(var_8[var_9]);
      }
      self notify("missile_fired", var_11);
    }

    self._id_2871 = var_9;

    if(var_10 < var_1 - 1) {
      wait(var_6);
    }
    if(isDefined(var_3)) {
      wait(var_3);
    }
  }

  self setvehweapon(var_7);
}

_id_2872(var_0, var_1, var_2, var_3, var_4) {
  wait(var_0);
  earthquake(var_1, var_2, var_3, var_4);
}

_id_2873(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self)) {
    self missile_cleartarget();
  }
}