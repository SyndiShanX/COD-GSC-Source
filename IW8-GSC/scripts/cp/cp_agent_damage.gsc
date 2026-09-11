/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_damage.gsc
***********************************************/

function register_ai_damage_callbacks() {
  level.agent_funcs["soldier_agent"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["soldier_agent"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier_agent"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["soldier"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["soldier"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["civilian"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["civilian"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["civilian"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut_agent"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["juggernaut_agent"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut_agent"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["juggernaut"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["suicidebomber"]["on_damaged"] = &callbacksoldieragentdamaged;
  level.agent_funcs["suicidebomber"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["suicidebomber"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
}

function callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13.agent_type)) {
    return;
  }

  if(istrue(var_13.clear_keypad_currentdisplay_models)) {
    var_13.clear_keypad_currentdisplay_models = undefined;
    return;
  }

  if(!isDefined(var_12)) {
    var_12 = var_5;
  }

  if(var_4 != "MOD_SUICIDE") {
    if(scripts\cp\utility::is_friendly_damage(var_13, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_13;
  }

  var_14 = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_13);

  if(!var_14) {
    return;
  }

  var_3 |= 4;
  var_15 = var_2;
  var_16 = isDefined(var_13.agent_type);
  var_17 = var_12.basename;
  var_18 = var_12.classname;
  var_19 = triggered_module_spawn();
  var_20 = istrue(var_1.inlaststand);
  var_21 = var_4 == "MOD_MELEE";
  var_22 = var_13 scripts\cp\utility::agentisinstakillimmune();
  var_23 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_24 = isDefined(var_1) && isPlayer(var_1);
  var_25 = isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_26 = isDefined(var_1) && isDefined(var_1.agent_type) && var_1.agent_type == "soldier_agent";
  var_27 = isDefined(var_13.unittype) && var_13.unittype == "juggernaut";
  var_28 = var_23 && scripts\cp\utility::isheadshot(var_12, var_8, var_4, var_1);
  var_29 = var_4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var_8) && var_8 == "none" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE";
  var_30 = var_4 == "MOD_FIRE";
  var_31 = 0;
  var_32 = var_24 && var_1 scripts\cp\utility::_hasperk("specialty_bulletdamage");
  var_33 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
  var_34 = var_33 && var_4 == "MOD_CRUSH";
  var_35 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && !isDefined(var_1.owner);
  var_36 = var_35 && var_4 == "MOD_CRUSH";

  if(isDefined(level.ref_14000)) {
    level thread[[level.ref_14000]](var_1, var_5, var_13, var_4, var_8, var_9);
  }

  if((var_24 || var_25) && istrue(var_13.invulnerable) && var_4 != "MOD_SUICIDE") {
    return;
  }

  if(var_27) {
    if(var_21) {
      var_37 = [];
      var_38 = spawnStruct();
      var_38.type = "break_stealth_with_no_damage";
      var_38.entity = var_1;
      var_37 = var_38;
      var_13 notify("ai_events", var_37);
      return;
    } else {
      if(var_19 == "thermite_ap_mp" || var_19 == "thermite_proj_cp") {
        var_4 *= 15;
      }

      if(var_19 == "cruise_proj_mp") {
        var_4 = self.health + 1000;
      }
    }

    if(var_36) {
      var_39 = ["atv"];

      if(scripts\engine\utility::array_contains(var_39, var_3.vehiclename)) {
        var_3 dodamage(10000, var_3.origin, var_15);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        var_4 = self.health + 1000;
      }
    }
  } else if(var_26) {
    if(var_19 == "throwingknife_mp") {
      var_4 = self.health + 1000;
    }

    if((var_19 == "tur_bradley_mp" || var_19 == "tur_bradley_ks_mp") && var_6 == "MOD_PROJECTILE") {
      var_4 = self.health + 1000;
    }
  }

  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    if(setuphudelemninfilcover(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14)) {
      return;
    }

    if(var_10 == "shield" && (var_6 == "MOD_GRENADE" || var_6 == "MOD_PROJECTILE") && var_4 > 175) {
      var_4 *= 0.05;
      var_10 = "torso_lower";
    }
  }

  if(var_21) {
    if(var_19 == "emp_drone_player_mp") {
      var_4 = self.health + 1000;
    }
  }

  if(var_36) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");

    if(istrue(level.global_stealth_broken)) {}
  }

  if(var_38) {
    if(istrue(self.trial_target_think_func)) {
      var_4 = 0;
      var_15 notify("veh_crush_damage", var_3);
    }
  }

  if(var_26) {
    var_15.damaged_by_player = 1;

    if(var_30) {
      if(var_29) {
        if(scripts\cp\utility::tryingtoleave()) {
          var_4 *= 0.3;
        } else {
          var_4 = bink_save_hack(var_4, var_7, var_20, var_6, var_3);
        }
      }
    }

    if(var_34) {
      var_4 *= 2;
    }

    if(var_31) {
      var_40 = var_4 * 2.5;

      if(isDefined(level.explosivedamagemod)) {
        var_40 *= level.explosivedamagemod;
      }

      var_4 += var_40;
    }

    if(var_32) {
      var_4 += var_4 * 3.5;
    }

    if(var_23) {
      if(istrue(var_15.immune_to_melee_damage)) {
        var_4 = 0;
        var_15 notify("melee_hit_on_melee_immune", var_3);
      } else {
        var_4 = 150;
        var_4 *= var_3 scripts\cp\perks\cp_perks::get_perk("melee_scalar");

        if(turn_off_have_target_hud(var_19)) {
          var_4 = 175;
        } else {
          if(issubstr(var_19, "iw8_knife_mp")) {
            var_4 = 350;
          }

          if(issubstr(var_19, "iw8_me_")) {
            var_4 = 350;
          } else if(isDefined(var_14.muzzle)) {
            if(issubstr(var_14.muzzle, "muzzlemelee")) {
              var_4 = 350;
            }

            if(issubstr(var_14.muzzle, "bayonet")) {
              var_4 = 350;
            }
          }
        }
      }
    }

    if(var_25) {
      if(!var_30) {
        if(!isDefined(level.bullet_damage_scalar)) {
          level.bullet_damage_scalar = 1;
        }

        var_4 *= level.bullet_damage_scalar;
      }

      var_4 *= var_3 scripts\cp\perks\cp_perks::get_perk("bullet_damage_scalar");
    }

    if(is_wearing_armor()) {
      if(var_29 || var_10 == "torso_upper" || var_10 == "torso_lower") {
        var_4 = scripts\cp\cp_damage::handleapdamage(var_14, var_6, var_4, var_3);
        var_4 *= 0.5;
      }
    }

    if(var_4 < var_15.health) {
      var_3 scripts\cp\cp_persistence::give_player_currency(10, "large", var_10);
    } else if(var_26) {
      if(var_29) {
        thread scripts\cp_mp\xmike109::getaverageangularvelocity();
      }

      thread scripts\cp\cp_achievement::ascender_disableplayeruse(var_3, var_6, var_19);
    }

    var_41 = var_3 scripts\cp\perks\cp_perks::get_perk("short_range_damage_scalar");

    if(var_41 > 1) {
      var_42 = distancesquared(var_3.origin, var_15.origin);

      if(var_42 < 40000) {
        var_4 *= var_41;
      }
    }

    if(istrue(var_3.is_available_for_hack)) {
      var_43 = var_3.origin[2];
      var_44 = var_15.origin[2];

      if(var_43 >= var_44) {
        var_45 = int(abs(var_43 - var_44));
        var_46 = int(var_45 / 64);

        if(var_46 > 0) {
          var_4 *= 1 + 0.4 * var_46;
        }
      }
    }
  }

  if(!var_29 && var_33) {
    var_4 = self.health + 100;
  }

  if(isDefined(var_19) && var_19 == "tur_bradley_mp" && isDefined(var_6) && var_6 == "MOD_PROJECTILE_SPLASH") {
    var_4 *= 2;
  }

  if(isPlayer(var_3)) {
    scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(var_3, 1);

    if(isDefined(var_3.pers["participation"])) {
      var_3.pers["participation"]++;
    } else {
      var_3.pers["participation"] = 1;
    }

    if(isDefined(var_3.pers["periodic_xp_participation"])) {
      var_3.pers["periodic_xp_participation"]++;
    } else {
      var_3.pers["periodic_xp_participation"] = 1;
    }
  }

  var_47 = isDefined(var_6) && var_6 == "MOD_EXECUTION";

  if(var_47) {
    var_3 thread scripts\cp\cp_player_battlechatter::battle_tracks_monitorstandingonvehicles();
  }

  var_4 = scripts\cp\cp_damage::modifydamagegeneral(var_2, var_3, var_15, var_4, var_5, var_6, var_14, var_8, var_9, var_10);

  if(var_26 || var_27 || var_36) {
    if(isDefined(var_14)) {
      if(var_27) {
        var_3 = var_3.owner;
      }

      addattacker(self, var_3, var_2, var_14, var_4, var_8, var_9, var_10, var_11, var_6);
    }

    if(var_4 >= var_15.health) {
      if(var_14.basename == "none") {
        if(isDefined(var_2) && isDefined(var_2.weapon_name)) {
          var_14 = getcompleteweaponname(var_2.weapon_name);
        }
      }

      var_48 = spawnStruct();
      var_48.einflictor = var_2;
      var_48.eattacker = var_3;
      var_48.idamage = var_4;
      var_48.idflags = var_5;
      var_48.smeansofdeath = var_6;
      var_48.sweapon = var_7;
      var_48.vpoint = var_8;
      var_48.vdir = var_9;
      var_48.shitloc = var_10;
      var_48.timeoffset = var_11;
      var_48.modelindex = var_12;
      var_48.partname = var_13;
      var_48.objweapon = var_14;
      thread ai_drop_func(var_48);
    }
  }

  ref_1289f(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_4 = int(min(var_4, var_15.maxhealth));

  if(isDefined(level.updateondamagerelicsfunc)) {
    level thread[[level.updateondamagerelicsfunc]](var_3, var_7, var_15, var_6, var_10, var_11);
  }

  scripts\cp\cp_damagefeedback::process_damage_feedback(var_2, var_3, var_4, var_5, var_6, var_7, var_9, var_9, var_10, var_11, self);

  if(is_flashbang(var_19, var_14, var_2) && var_6 == "MOD_GRENADE_SPLASH") {
    var_15 notify("flashbang", var_10, 1, undefined, var_3, "allies");
  }

  if(is_gas(var_19) && var_6 == "MOD_GRENADE_SPLASH") {
    var_15 notify("flashbang", var_10, 1, undefined, var_3, "allies");
  }

  if(isDefined(var_15.unittype) && isDefined(level.agent_funcs[var_15.unittype]) && isDefined(level.agent_funcs[var_15.unittype]["on_damaged_finished"])) {
    var_15[[level.agent_funcs[var_15.unittype]["on_damaged_finished"]]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, 0, var_12, var_13);
    return;
  }

  var_15[[level.agent_funcs[var_15.agent_type]["on_damaged_finished"]]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, 0, var_12, var_13);
}

function turn_off_have_target_hud(var_0) {
  switch (var_0) {
    case "iw8_me_akimboblunt_mp":
    case "iw8_me_riotshield_mp":
      return true;
  }

  return false;
}

function ref_1289f(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_13 endon("death");

  if(!isPlayer(var_1)) {
    return;
  }

  if(var_2 >= var_13.health) {
    if(isDefined(var_1.ref_119d4) && var_1.ref_119d4.size > 0) {
      if(istrue(var_1.ref_119d4[var_13 getentitynumber()])) {
        return;
      }
    }

    var_1 thread scripts\mp\mp_agent_damage::vip_playerdied(undefined, self, var_12, var_4, var_0, 0, var_8);
    thread scripts\mp\ammorestock::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_12, var_8, var_1.modifiers);
    return;
  }
}

function setuphudelemninfilcover(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_12.basename;
  var_14 = 0;

  if(isDefined(var_0) && (issubstr(var_13, "thermite") || isDefined(var_12.magazine) && issubstr(var_12.magazine, "boltfire") || isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "incendiary"))) {
    var_14 = 1;
    var_15 = var_8 == "shield";

    if(var_15) {
      var_16 = scripts\engine\trace::create_character_contents();
      var_17 = vectorNormalize(var_7);
      var_18 = var_6 - var_17 * 12;
      var_19 = var_6 + var_17 * 12;
      var_20 = scripts\engine\trace::ray_trace_detail(var_18, var_19, undefined, var_16);

      if(var_20["fraction"] > 0 && var_20["fraction"] < 1) {
        var_21 = var_6 - self.origin;
        var_21 = (var_21[0], var_21[1], 0);

        if(vectordot(var_21, var_20["normal"]) < 0) {
          var_15 = 0;
        }
      } else {
        var_15 = 0;
      }
    }

    if(var_15) {
      var_22 = var_0 getlinkedparent();

      if(isDefined(var_22) && var_22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self.ref_13b2a = 0;
      }
    } else if(var_8 != "none") {
      self.clearspaceforscriptableinstance = undefined;
      self.ref_13b2a = undefined;
    }
  }

  if(var_8 == "shield") {
    if(var_14) {
      return true;
    }
  } else if(var_8 == "none" && isDefined(var_0)) {
    var_23 = var_0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var_14 && isDefined(var_23) && var_23 == self) {
      if(!isDefined(self.ref_13b2c)) {
        self.ref_13b2c = [var_0];
      } else if(!scripts\engine\utility::array_contains(self.ref_13b2c, var_0)) {
        self.ref_13b2c[self.ref_13b2c.size] = var_0;
      }

      self.ref_13b2a++;
      return true;
    } else if(issubstr(var_13, "molotov")) {
      var_24 = var_0.origin - self.origin;
      var_25 = vectorNormalize((var_24[0], var_24[1], 0));
      var_24 = vectorNormalize(var_24);

      if(vectordot(anglesToForward(self.angles), var_25) > 0.5 && -0.98 < var_24[2] && var_24[2] < 0.98) {
        return true;
      }
    }
  }

  if(var_4 == "MOD_MELEE") {
    if(isDefined(var_1)) {
      var_26 = vectorNormalize(var_1.origin - self.origin);
    } else {
      var_26 = vectorNormalize(var_7 - self.origin);
    }

    var_27 = anglesToForward(self.angles);

    if(vectordot(var_27, var_26) > 0.5) {
      return true;
    }
  }

  return false;
}

function bink_save_hack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  switch (var_2) {
    case "rifle":
      var_5 = min(var_0, 84);
      break;
    case "smg":
      var_5 = min(var_0, 110);
      break;
    case "mg":
      var_5 = min(var_0, 105);
      break;
    case "spread":
      var_5 = min(var_0, 84);
      break;
    case "pistol":
      var_5 = min(var_0, 75);
      break;
    case "sniper":
      var_5 = min(var_0, 130);
      break;
    default:
      var_5 = var_0;
      break;
  }

  return var_0;
}

function triggered_module_spawn() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function getcodecomputerdisplaycode() {
  level endon("game_ended");
  level.bullet_damage_scalar = 1;

  for(;;) {
    var_0 = getdvarfloat("scr_bullet_damage_scalar", 1);

    if(level.bullet_damage_scalar != var_0) {
      level.bullet_damage_scalar = var_0;
    }

    wait 1;
  }
}

function register_ai_drop_funcs() {
  register_drop_func("weapon", &drop_weapon_func, &should_drop_weapon, 0);
}

function register_drop_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.ai_drop_info)) {
    level.ai_drop_info = [];
  }

  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.chance_func = var_2;
  var_4.func = var_1;
  var_4.score = 0;
  var_4.delay = var_3;
  var_4.next_chance = 0;
  level.ai_drop_info[level.ai_drop_info.size] = var_4;
}

function ai_drop_func(var_0) {
  if(!isDefined(level.ai_drop_info)) {
    return;
  }

  if(isDefined(level.ref_13fd4)) {
    [[level.ref_13fd4]](self.origin, var_0);
  }

  if(isDefined(self.force_drop)) {
    var_1 = get_func_by_name(self.force_drop);
    self thread[[var_1]](var_0);
    return;
  }

  var_2 = check_for_drop(var_0);
}

function get_func_by_name(var_0) {
  for(var_1 = 0; var_1 < level.ai_drop_info.size; var_1++) {
    if(level.ai_drop_info[var_1].name == var_0) {
      return level.ai_drop_info[var_1].func;
    }
  }
}

function drop_ready_item(var_0, var_1) {
  var_2 = gettime();
  self thread[[var_0.func]](var_1);
  var_0.score = 0;
  var_0.next_chance = var_2 + var_0.delay * 1000;
}

function check_for_drop(var_0) {
  var_1 = gettime();
  var_2 = 0;
  var_3 = scripts\engine\utility::array_randomize(level.ai_drop_info);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(!var_2) {
      if(var_1 > var_5.next_chance) {
        if(var_5.score > 99) {
          drop_ready_item(var_5, var_0);
          var_2 = 1;
          continue;
        }

        if([[var_5.chance_func]](var_0)) {
          drop_ready_item(var_5, var_0);
          var_2 = 1;
        }
      }
    }
  }

  return var_2;
}

function drop_weapon_func(var_0) {
  if(!istrue(var_0.eattacker.ref_11e8e)) {
    self.dropweapon = 1;
  }

  if(!isPlayer(var_0.eattacker)) {
    return;
  }

  if(isDefined(var_0.eattacker.class) && var_0.eattacker.class == "crusader" || isDefined(level.blueprintextract_trygetreward)) {
    if(ref_132c8(var_0.eattacker)) {
      drop_grenade(var_0);
    }
  }

  if(var_0.eattacker scripts\cp\utility::_hasperk("specialty_scavenger")) {
    if(ref_132cb(var_0.eattacker)) {
      var_1 = self.origin - (10, 10, 0);
      minigun_origin_offset(var_0, var_1);
      return;
    }

    return;
  }
}

function ref_132cb(var_0) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(var_0.waittill_any_return_no_endon_death_6)) {
    var_0.waittill_any_return_no_endon_death_6 = gettime();
    return true;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0.waittill_any_return_no_endon_death_6;

  if(var_2 > var_1) {
    var_0.waittill_any_return_no_endon_death_6 = gettime();
    return true;
  }

  return false;
}

function minigun_origin_offset(var_0, var_1) {
  var_2 = self.origin;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = spawn("script_model", var_2);
  thread astar_node_radius_override(var_3);
}

function astar_node_radius_override(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self hidefromplayer(var_2);
    }
  }

  self setModel("equipment_scavenger_bag");
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 10);
  thread scripts\cp\utility::delayentdelete(20);
  self.trigger thread scripts\cp\utility::delayentdelete(20);

  for(;;) {
    self.trigger waittill("trigger", var_4);

    if(var_4 == var_0) {
      var_4 playlocalsound("weap_ammo_pickup");
      score_spawner_relative_to_objective(var_4);
      var_4 thread scripts\cp\cp_damagefeedback::hudicontype("scavenger");
      self.trigger delete();
      self delete();
    }
  }
}

function scorelimitreached() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }

    if(scripts\cp\cp_weapon::is_launcher(var_2)) {
      continue;
    }

    if(cangive_ammo()) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = self getweaponammostock(var_2);
      var_5 = weaponclipsize(var_2);
      var_6 = var_3 + var_4 + var_5;

      if(var_6 == var_5) {
        self setweaponammoclip(var_2, var_6);
      } else {
        self setweaponammoclip(var_2, var_5);
        var_7 = var_6 - var_5;
        self setweaponammostock(var_2, var_7);
      }
    }
  }
}

function score_spawner_relative_to_objective() {
  var_0 = 30;
  var_1 = 0;
  var_2 = self getcurrentprimaryweapon();

  if(!scripts\cp\utility::is_valid_player()) {
    var_1 = 1;
  }

  if(weapontype(var_2) == "riotshield") {
    var_1 = 1;
  }

  if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
    var_1 = 1;
  }

  if(scripts\cp\cp_weapon::is_launcher(var_2)) {
    var_1 = 1;
  }

  if(!var_1) {
    if(cangive_ammo()) {
      var_0 = getammooverride(var_2);
      var_3 = self getweaponammostock(var_2);
      var_4 = weaponmaxammo(var_2);
      var_5 = var_3 + var_0;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_2, var_6);
      return true;
    }
  }

  var_7 = self getweaponslistprimaries();

  foreach(var_6 in var_7) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_6) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_6)) {
      continue;
    }

    if(scripts\cp\cp_weapon::is_launcher(var_6)) {
      continue;
    }

    if(cangive_ammo()) {
      var_4 = getammooverride(var_6);
      var_3 = self getweaponammostock(var_6);
      var_4 = weaponmaxammo(var_6);
      var_5 = var_3 + var_4;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_6, var_6);
      return true;
    }
  }

  var_5 = undefined;
  var_6 = undefined;
  return false;
}

function getammooverride(var_0) {
  var_1 = var_0 getbaseweapon();
  var_2 = weaponclipsize(var_1);
  var_3 = scripts\cp\utility::getweaponrootname(var_0);
  var_4 = 30;
  var_5 = var_4;

  if(var_0.isalternate) {
    var_6 = scripts\cp\utility::attachmentmap_tobase(var_0.underbarrel);

    switch (var_6) {
      case "glsemtex":
      case "glgas":
      case "gl":
      case "glsnap":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glsmoke":
        var_5 = 1;
        break;
      case "ubshtgn":
        var_5 = 999;
        break;
      default:
        var_5 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "spread":
        switch (var_3) {
          case "iw8_sh_charlie725":
            var_5 = 6;
            break;
          case "iw8_sh_dpapa12":
            var_5 = 8;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      case "sniper":
        switch (var_3) {
          case "iw8_sn_crossbow":
            var_5 = 3;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      default:
        var_5 = int(min(var_2, var_4));
        break;
    }
  }

  return var_5;
}

function cangive_ammo() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2) {
    return 1;
  }

  return 0;
}

function ref_132c8(var_0) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(var_0.waittill_any_timeout_no_endon_death_1)) {
    var_0.waittill_any_timeout_no_endon_death_1 = gettime();
    return true;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0.waittill_any_timeout_no_endon_death_1;

  if(var_2 > var_1) {
    var_0.waittill_any_timeout_no_endon_death_1 = gettime();
    return true;
  }

  return false;
}

function drop_grenade(var_0) {
  var_1 = self.origin + (10, 10, 0);
  mine_destroyed_vfx(var_0, var_1);
}

function mine_destroyed_vfx(var_0, var_1, var_2) {
  var_3 = self.origin;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = scripts\cp\utility::createhintobject(var_3, "HINT_BUTTON", "cp_crate_icon_lethalrefill", &"COOP_GAME_PLAY/PICK_GRENADE", 5, "duration_short", "show", 200, undefined, 100, 360);
  var_4 setModel("offhand_wm_grenade_mike67");
  thread activate_grenade_object();
  var_4 thread scripts\cp\utility::delayentdelete(30);

  if(isDefined(var_2)) {
    foreach(var_6 in level.players) {
      if(var_6 != var_2) {
        var_4 hidefromplayer(var_6);
      }
    }

    return;
  }
}

function activate_grenade_object() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 forceplaygestureviewmodel("ges_pickup");
    var_0 playlocalsound("weap_ammo_pickup");

    foreach(var_2 in var_0.powers) {
      if(var_2.slot == "primary") {
        var_0 notify("pickup_equipment", var_2.weaponuse);
        waitframe();
      }
    }

    self delete();
  }
}

function is_wearing_armor() {
  if(self.unittype == "juggernaut") {
    return 1;
  }

  if(scripts\cp\cp_modular_spawning::is_armored()) {
    return 1;
  }

  return 0;
}

function should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return false;
  } else if(var_0 != var_5 && isDefined(var_0.team) && var_0.team == var_5.team) {
    return false;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return false;
  }

  if(isDefined(level.ref_132c6)) {
    if(isarray(level.ref_132c6) && level.ref_132c6.size > 0) {
      foreach(var_7 in level.ref_132c6) {
        if(![[var_7]](var_0, var_1, var_2, var_3, var_4, var_5)) {
          return false;
        }
      }
    }
  }

  return true;
}

function ishighdamageweapon(var_0) {
  return var_0.classname == "sniper" || var_0.classname == "dmr";
}

function should_drop_weapon(var_0) {
  var_1 = getdvarint("scr_force_weapon_drop");

  if(var_1) {
    return true;
  }

  if(!isDefined(level.weapon_drop_cooldown)) {
    return false;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!isDefined(var_0.eattacker)) {
    return false;
  }

  var_2 = 5;
  var_3 = gettime();
  var_4 = var_0.eattacker getentitynumber();

  if(!isDefined(level.weapon_drop_cooldown[var_4])) {
    level.weapon_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return true;
  }

  if(var_3 > level.weapon_drop_cooldown[var_4]) {
    level.weapon_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return true;
  }

  return false;
}

function is_flashbang(var_0, var_1, var_2) {
  if(isDefined(var_1.underbarrel)) {
    var_3 = scripts\cp\utility::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "glflash" || var_3 == "glconc") {
      return true;
    }
  }

  return var_0 == "flash_grenade_mp";
}

function is_gas(var_0) {
  return var_0 == "gas_mp";
}

function callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_4 == "MOD_SUICIDE") {
    return;
  }

  var_3 = 0;

  if(!isDefined(self.painsound)) {
    return;
  }

  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound)) {
      self playSound(self.painsound);
    }

    self.next_dmg_sound = gettime() + 500;
    return;
  }
}

function callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\cp\cp_agent_utils::deactivateagent();

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](var_1, var_4);
  }

  if(triggered_module_spawn()) {
    if(!istrue(self.died_poorly)) {
      level notify("grenade_exploded_during_stealth", self.origin, "suicide_vest", rear_spotlight(var_0, var_1, self.origin));
    }
  }

  if(var_3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.isinlaststand)) {
    var_9 = spawnStruct();
    var_9.einflictor = var_0;
    var_9.eattacker = var_1;
    var_9.idamage = var_2;
    var_9.smeansofdeath = var_3;
    var_9.sweapon = var_4;
    var_9.vdir = var_5;
    var_9.shitloc = var_6;
    var_9.timeoffset = var_7;
    var_9.deathanimduration = var_8;
    GscBinSkip1(0x74, self.isinlaststand, var_9);
  }

  if(isPlayer(var_2)) {
    level notify("zombie_killed_by", var_2);
    thread handle_death_sounds(level, var_2, self);
    self.died_poorly = undefined;
    var_10 = scripts\cp\cp_endgame::get_current_zone(var_2);
    var_11 = 1;
    scripts\cp\cp_analytics::ref_119b5(var_2, self, var_5);

    if(isDefined(var_2.perk_data) && var_2 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
      var_12 = 10;
      var_13 = var_12 * var_2.perk_data["super_fill_scalar"];
      var_2 scripts\cp\coop_super::increase_super_progress(var_13);
    }
  }

  if(scripts\cp\cp_relics::calldropbag()) {
    if(isPlayer(var_2) && isDefined(level.updateonkillrelicsfunc)) {
      level thread[[level.updateonkillrelicsfunc]](var_5, var_2, self, var_4, var_7);
    }
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  if(isDefined(self.attackers)) {
    foreach(var_15 in self.attackers) {
      if(var_15 == var_2) {
        continue;
      }

      if(self == var_15) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      var_16 = undefined;

      if(isDefined(self.attackerdata)) {
        var_17 = self.attackerdata[var_15.guid];

        if(isDefined(var_17)) {
          var_16 = var_17.objweapon;
        }
      }

      var_18 = 0;

      if(self.attackerdata[var_15.guid].damage >= 35) {
        var_18 = 1;
      }

      if(self.attackerdata[var_15.guid].damage >= 70) {
        var_18 = 2;
      }

      var_15 thread scripts\cp\cp_gamescore::processassist(self, var_16, var_18);
      LOC_0000025b:
    }
  }

  give_attacker_kill_rewards(var_1, var_2, var_7, var_4, var_5);
  var_20 = 0;
  scripts\cp\cp_damagefeedback::process_damage_feedback(var_1, var_2, var_3, var_20, var_4, var_5, var_6, var_6, var_7, var_8, self);
  scripts\cp\cp_merits::process_agent_on_killed_merits(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  level thread scripts\cp\utility::add_to_notify_queue("ai_killed", self.origin, var_5, var_4, var_2, self, self.team);
}

function ref_13c35() {
  self endon("death_or_disconnect");
  self notify("stop_tracking_consec_kills");
  self endon("stop_tracking_consec_kills");

  for(;;) {
    level waittill("ai_killed", var_0, var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(self.hostdamagefactormedium)) {
      self.hostdamagefactormedium = 1;
    } else {
      self.hostdamagefactormedium += 1;
    }

    thread ref_13b82();
  }
}

function ref_13b82() {
  self endon("death_or_disconnect");
  self notify("stop_timeout_consec_kills");
  self endon("stop_timeout_consec_kills");
  wait propability();
  self.hostdamagefactormedium = undefined;
}

function propability() {
  var_0 = 3;

  if(scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak")) {
    var_0 += 3;
  }

  return var_0;
}

function handle_death_sounds(var_0, var_1, var_2) {
  if(!scripts\engine\utility::isbulletdamage(var_2)) {
    return;
  }

  if(isDefined(var_1.deathsound) && soundexists(var_1.deathsound)) {
    playsoundatpos(var_1.origin, var_1.deathsound);
  }

  var_3 = var_1;

  if(var_2 == "MOD_HEAD_SHOT") {
    var_3 playsoundtoplayer("bullet_impact_headshot", var_0);
    var_3 playsoundtoteam("bullet_impact_headshot_npc", var_0.team, var_0);
    return;
  }

  var_3 playsoundtoplayer("mp_kill_alert", var_0);
  var_3 playsoundtoteam("mp_hit_alert_final_npc", var_0.team, var_0);
}

function give_attacker_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }

  if(isDefined(self.team) && isDefined(var_1.team) && self.team == var_1.team) {
    return;
  }

  if(!isDefined(self.agent_type)) {
    return;
  }

  var_5 = scripts\mp\mp_agent::get_agent_type(self);
  var_6 = getdvarint("scr_agent_points_override", 0);

  if(var_6 != 0) {
    var_7 = var_6;
  } else {
    var_7 = level.agent_definition[var_6]["reward"];
  }

  var_8 = level.agent_definition[var_6]["xp"];
  var_9 = 0;
  var_10 = triggered_module_spawn();
  var_11 = isDefined(var_5) && (var_5.basename == "incendiary_ammo_mp" || var_5.basename == "slayer_ammo_mp");

  if(isDefined(var_2.classname) && var_2.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar)) {
      var_12 = var_7 * (level.cash_scalar + level.consumable_cash_scalar);
    } else {
      var_12 = var_8 * level.cash_scalar;
    }

    foreach(var_14 in level.players) {
      if(!var_14 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(isDefined(level.zombie_xp)) {
        var_14 scripts\cp\cp_persistence::give_player_xp(int(var_9));
      }

      if(istrue(level.special_event)) {
        continue;
      }

      var_15 = "large";
      var_4 = "none";
      var_14 scripts\cp\cp_persistence::give_player_currency(var_12, var_15, var_4, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(var_7) && (!isDefined(var_7.owner) || !isPlayer(var_7.owner))) {
    return;
  }

  if(isDefined(var_7.owner)) {
    var_7 = var_7.owner;
    var_14 = 1;
  }

  if(!var_16 && (var_11 == "generic_zombie" || var_11 == "fast_zombie" || var_11 == "zombie_cop")) {
    if(scripts\cp\utility::isheadshot(var_10, var_8, var_9, var_7) && !var_14 && scripts\engine\utility::isbulletdamage(var_9) && !var_15) {
      var_12 = int(100);
      var_13 = int(75);
    }

    if(isDefined(var_9) && var_9 == "MOD_MELEE" && !issubstr(var_10.basename, "axe")) {
      var_12 = int(130);
      var_13 = int(100);
    }
  }

  if(isPlayer(var_7)) {
    if(!istrue(var_7.pers["ignoreWeaponMatchBonus"]) && (scripts\cp\cp_weapon::iscacprimaryweapon(var_10) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_10))) {
      if(!isDefined(var_7.pers["weaponMatchBonusKills"])) {
        var_7.pers["weaponMatchBonusKills"] = 1;
      } else {
        var_7.pers["weaponMatchBonusKills"]++;
      }

      if(var_7.pers["weaponMatchBonusKills"] > scripts\cp\cp_weaponrank::reload_use_think()) {
        var_7.pers["ignoreWeaponMatchBonus"] = 1;
        var_7.pers["weaponMatchBonusKills"] = undefined;
        var_7.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(var_7.pers["killsPerWeapon"])) {
          var_7.pers["killsPerWeapon"] = [];
        }

        var_17 = scripts\cp\utility::getweaponrootname(var_10);
        var_18 = 0;

        foreach(var_20 in var_7.pers["killsPerWeapon"]) {
          if(var_21 == var_17) {
            var_20.killcount++;
            var_18 = 1;
            break;
          }
        }

        if(!var_18) {
          var_20 = spawnStruct();
          var_20.killcount = 1;
          var_20.basename = var_10.basename;
          var_20.ref_1213c = var_7.pers["killsPerWeapon"].size;
          var_7.pers["killsPerWeapon"][var_17] = var_20;
        }
      }
    }
  }

  if(isDefined(level.kill_reward_func)) {
    var_12 = [[level.kill_reward_func]](var_7, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  if(isDefined(var_12)) {
    givekillreward(var_7, var_7, var_12, var_13, "large", var_8, var_10, var_9);
    return;
  }
}

function givekillreward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.consumable_cash_scalar)) {
    var_2 *= level.cash_scalar + level.consumable_cash_scalar;
  } else {
    var_2 *= level.cash_scalar;
  }

  thread giveplayerbonuscash(var_1, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  var_1 scripts\cp\cp_persistence::record_player_kills(var_6, var_5, var_7, var_1);

  if(isDefined(self.shared_damage_points)) {
    foreach(var_9 in level.players) {
      if(istrue(level.special_event)) {
        continue;
      }

      var_9 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1, "crafted");
      LOC_000000a0:
    }
  } else if(should_get_currency_from_kill(var_0, var_1, var_6)) {
    var_1 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1);
  }

  if(!scripts\cp\utility::tryingtoleave()) {
    var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill", var_6, undefined, undefined, self);
    return;
  }
}

function giveplayerbonuscash(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(should_get_currency_from_kill(var_0, var_1, var_6)) {
    if(var_1 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(var_7) && var_6.classname == "weapon_sniper" && checkaltmodestatus(var_6)) {
      var_8 = 300;

      if(var_6 == "iw7_shared_fate_weapon") {
        var_1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
      } else {
        var_1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
        thread delaygivecurrency(var_1, var_8, var_4, var_5, "bonus");
      }
    }

    if(isPlayer(var_1) && isDefined(var_1.cash_scalar)) {
      if(isDefined(var_1.cash_scalar_weapon) && var_1.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(var_6)) {
        var_9 = int(var_2 * var_1.cash_scalar - var_2);
        thread delaygivecurrency(var_1, var_9, var_4, var_5, "bonus");
      }

      if(isDefined(var_1.cash_scalar_alt_weapon) && var_1.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(var_6) && istrue(var_6.isalternate) && istrue(var_1.alt_mode_passive)) {
        var_9 = int(var_2 * var_1.cash_scalar - var_2);
        thread delaygivecurrency(var_1, var_9, var_4, var_5, "bonus");
        return;
      }

      return;
    }

    return;
  }
}

function delaygivecurrency(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  wait var_4;
  scripts\cp\cp_persistence::give_player_currency(var_0, var_1, var_2, 1, var_3);
}

function should_get_currency_from_kill(var_0, var_1, var_2) {
  if(isPlayer(var_1) && scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    return false;
  }

  if(scripts\cp\utility::is_trap(var_0, var_2)) {
    return false;
  }

  if(istrue(level.special_event)) {
    return false;
  }

  return true;
}

function checkaltmodestatus(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = scripts\cp\utility::getbaseweaponname(var_0);

  switch (var_1) {
    case "iw7_m8":
      if(scripts\cp\utility::isaltmodeweapon(var_0)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

function addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_1.guid) && (isagent(var_1) || isPlayer(var_1))) {
    var_1.guid = var_1 scripts\cp\utility\player::getuniqueid();
  }

  if(!isDefined(var_1.guid)) {
    return;
  }

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else {
    var_0.attackerdata[var_1.guid].hitcount++;
  }

  if(scripts\cp\cp_weapon::iscacprimaryweapon(var_3) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var_3)) {
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;
  }

  var_10 = scripts\cp\utility::getequipmenttype(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "lethal") {
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;
    }

    if(var_10 == "tactical") {
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
    }
  }

  var_0.attackerdata[var_1.guid].damage += var_4;
  var_0.attackerdata[var_1.guid].weapon = createheadicon(var_3);
  var_0.attackerdata[var_1.guid].objweapon = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].psoffsettime = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon)) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
    return;
  }

  if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon())) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
    return;
  }

  var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

function rear_spotlight(var_0, var_1, var_2) {
  if(isPlayer(var_1)) {
    return var_1.name;
  }

  if(isPlayer(var_0)) {
    return var_0.name;
  }

  if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    return var_0.owner.name;
  }

  var_3 = scripts\engine\utility::getclosest(var_2, level.players);
  return var_3.name;
}

function _validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}