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

function callbacksoldieragentdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = self;

  if(!isDefined(var13.agent_type)) {
    return;
  }

  if(istrue(var13.clear_keypad_currentdisplay_models)) {
    var13.clear_keypad_currentdisplay_models = undefined;
    return;
  }

  if(!isDefined(var12)) {
    var12 = var5;
  }

  if(var4 != "MOD_SUICIDE") {
    if(scripts\cp\utility::is_friendly_damage(var13, var0)) {
      return;
    }
  }

  if(!isDefined(var1)) {
    var1 = var13;
  }

  var14 = should_do_damage_checks(var1, var2, var4, var5, var8, var13);

  if(!var14) {
    return;
  }

  var3 |= 4;
  var15 = var2;
  var16 = isDefined(var13.agent_type);
  var17 = var12.basename;
  var18 = var12.classname;
  var19 = triggered_module_spawn();
  var20 = istrue(var1.inlaststand);
  var21 = var4 == "MOD_MELEE";
  var22 = var13 scripts\cp\utility::agentisinstakillimmune();
  var23 = scripts\engine\utility::isbulletdamage(var4) || var4 == "MOD_EXPLOSIVE_BULLET" && var8 != "none";
  var24 = isDefined(var1) && isPlayer(var1);
  var25 = isDefined(var1.owner) && isPlayer(var1.owner);
  var26 = isDefined(var1) && isDefined(var1.agent_type) && var1.agent_type == "soldier_agent";
  var27 = isDefined(var13.unittype) && var13.unittype == "juggernaut";
  var28 = var23 && scripts\cp\utility::isheadshot(var12, var8, var4, var1);
  var29 = var4 == "MOD_EXPLOSIVE_BULLET" && isDefined(var8) && var8 == "none" || var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE_SPLASH" || var4 == "MOD_PROJECTILE" || var4 == "MOD_PROJECTILE_SPLASH" || var4 == "MOD_GRENADE";
  var30 = var4 == "MOD_FIRE";
  var31 = 0;
  var32 = var24 && var1 scripts\cp\utility::_hasperk("specialty_bulletdamage");
  var33 = isDefined(var1.classname) && var1.classname == "script_vehicle" && isDefined(var1.owner) && isPlayer(var1.owner);
  var34 = var33 && var4 == "MOD_CRUSH";
  var35 = isDefined(var1.classname) && var1.classname == "script_vehicle" && !isDefined(var1.owner);
  var36 = var35 && var4 == "MOD_CRUSH";

  if(isDefined(level.ref_14000)) {
    level thread[[level.ref_14000]](var1, var5, var13, var4, var8, var9);
  }

  if((var24 || var25) && istrue(var13.invulnerable) && var4 != "MOD_SUICIDE") {
    return;
  }

  if(var27) {
    if(var21) {
      var37 = [];
      var38 = spawnStruct();
      var38.type = "break_stealth_with_no_damage";
      var38.entity = var1;
      var37 = var38;
      var13 notify("ai_events", var37);
      return;
    } else {
      if(var19 == "thermite_ap_mp" || var19 == "thermite_proj_cp") {
        var4 *= 15;
      }

      if(var19 == "cruise_proj_mp") {
        var4 = self.health + 1000;
      }
    }

    if(var36) {
      var39 = ["atv"];

      if(scripts\engine\utility::array_contains(var39, var3.vehiclename)) {
        var3 dodamage(10000, var3.origin, var15);
      } else {
        playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");
        var4 = self.health + 1000;
      }
    }
  } else if(var26) {
    if(var19 == "throwingknife_mp") {
      var4 = self.health + 1000;
    }

    if((var19 == "tur_bradley_mp" || var19 == "tur_bradley_ks_mp") && var6 == "MOD_PROJECTILE") {
      var4 = self.health + 1000;
    }
  }

  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    if(setuphudelemninfilcover(var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14)) {
      return;
    }

    if(var10 == "shield" && (var6 == "MOD_GRENADE" || var6 == "MOD_PROJECTILE") && var4 > 175) {
      var4 *= 0.05;
      var10 = "torso_lower";
    }
  }

  if(var21) {
    if(var19 == "emp_drone_player_mp") {
      var4 = self.health + 1000;
    }
  }

  if(var36) {
    playsoundatpos(self.origin + (0, 0, 40), "gib_fullbody");

    if(istrue(level.global_stealth_broken)) {}
  }

  if(var38) {
    if(istrue(self.trial_target_think_func)) {
      var4 = 0;
      var15 notify("veh_crush_damage", var3);
    }
  }

  if(var26) {
    var15.damaged_by_player = 1;

    if(var30) {
      if(var29) {
        if(scripts\cp\utility::tryingtoleave()) {
          var4 *= 0.3;
        } else {
          var4 = bink_save_hack(var4, var7, var20, var6, var3);
        }
      }
    }

    if(var34) {
      var4 *= 2;
    }

    if(var31) {
      var40 = var4 * 2.5;

      if(isDefined(level.explosivedamagemod)) {
        var40 *= level.explosivedamagemod;
      }

      var4 += var40;
    }

    if(var32) {
      var4 += var4 * 3.5;
    }

    if(var23) {
      if(istrue(var15.immune_to_melee_damage)) {
        var4 = 0;
        var15 notify("melee_hit_on_melee_immune", var3);
      } else {
        var4 = 150;
        var4 *= var3 scripts\cp\perks\cp_perks::get_perk("melee_scalar");

        if(turn_off_have_target_hud(var19)) {
          var4 = 175;
        } else {
          if(issubstr(var19, "iw8_knife_mp")) {
            var4 = 350;
          }

          if(issubstr(var19, "iw8_me_")) {
            var4 = 350;
          } else if(isDefined(var14.muzzle)) {
            if(issubstr(var14.muzzle, "muzzlemelee")) {
              var4 = 350;
            }

            if(issubstr(var14.muzzle, "bayonet")) {
              var4 = 350;
            }
          }
        }
      }
    }

    if(var25) {
      if(!var30) {
        if(!isDefined(level.bullet_damage_scalar)) {
          level.bullet_damage_scalar = 1;
        }

        var4 *= level.bullet_damage_scalar;
      }

      var4 *= var3 scripts\cp\perks\cp_perks::get_perk("bullet_damage_scalar");
    }

    if(is_wearing_armor()) {
      if(var29 || var10 == "torso_upper" || var10 == "torso_lower") {
        var4 = scripts\cp\cp_damage::handleapdamage(var14, var6, var4, var3);
        var4 *= 0.5;
      }
    }

    if(var4 < var15.health) {
      var3 scripts\cp\cp_persistence::give_player_currency(10, "large", var10);
    } else if(var26) {
      if(var29) {
        thread scripts\cp_mp\xmike109::getaverageangularvelocity();
      }

      thread scripts\cp\cp_achievement::ascender_disableplayeruse(var3, var6, var19);
    }

    var41 = var3 scripts\cp\perks\cp_perks::get_perk("short_range_damage_scalar");

    if(var41 > 1) {
      var42 = distancesquared(var3.origin, var15.origin);

      if(var42 < 40000) {
        var4 *= var41;
      }
    }

    if(istrue(var3.is_available_for_hack)) {
      var43 = var3.origin[2];
      var44 = var15.origin[2];

      if(var43 >= var44) {
        var45 = int(abs(var43 - var44));
        var46 = int(var45 / 64);

        if(var46 > 0) {
          var4 *= 1 + 0.4 * var46;
        }
      }
    }
  }

  if(!var29 && var33) {
    var4 = self.health + 100;
  }

  if(isDefined(var19) && var19 == "tur_bradley_mp" && isDefined(var6) && var6 == "MOD_PROJECTILE_SPLASH") {
    var4 *= 2;
  }

  if(isPlayer(var3)) {
    scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(var3, 1);

    if(isDefined(var3.pers["participation"])) {
      var3.pers["participation"]++;
    } else {
      var3.pers["participation"] = 1;
    }

    if(isDefined(var3.pers["periodic_xp_participation"])) {
      var3.pers["periodic_xp_participation"]++;
    } else {
      var3.pers["periodic_xp_participation"] = 1;
    }
  }

  var47 = isDefined(var6) && var6 == "MOD_EXECUTION";

  if(var47) {
    var3 thread scripts\cp\cp_player_battlechatter::battle_tracks_monitorstandingonvehicles();
  }

  var4 = scripts\cp\cp_damage::modifydamagegeneral(var2, var3, var15, var4, var5, var6, var14, var8, var9, var10);

  if(var26 || var27 || var36) {
    if(isDefined(var14)) {
      if(var27) {
        var3 = var3.owner;
      }

      addattacker(self, var3, var2, var14, var4, var8, var9, var10, var11, var6);
    }

    if(var4 >= var15.health) {
      if(var14.basename == "none") {
        if(isDefined(var2) && isDefined(var2.weapon_name)) {
          var14 = getcompleteweaponname(var2.weapon_name);
        }
      }

      var48 = spawnStruct();
      var48.einflictor = var2;
      var48.eattacker = var3;
      var48.idamage = var4;
      var48.idflags = var5;
      var48.smeansofdeath = var6;
      var48.sweapon = var7;
      var48.vpoint = var8;
      var48.vdir = var9;
      var48.shitloc = var10;
      var48.timeoffset = var11;
      var48.modelindex = var12;
      var48.partname = var13;
      var48.objweapon = var14;
      thread ai_drop_func(var48);
    }
  }

  ref_1289f(var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
  var4 = int(min(var4, var15.maxhealth));

  if(isDefined(level.updateondamagerelicsfunc)) {
    level thread[[level.updateondamagerelicsfunc]](var3, var7, var15, var6, var10, var11);
  }

  scripts\cp\cp_damagefeedback::process_damage_feedback(var2, var3, var4, var5, var6, var7, var9, var9, var10, var11, self);

  if(is_flashbang(var19, var14, var2) && var6 == "MOD_GRENADE_SPLASH") {
    var15 notify("flashbang", var10, 1, undefined, var3, "allies");
  }

  if(is_gas(var19) && var6 == "MOD_GRENADE_SPLASH") {
    var15 notify("flashbang", var10, 1, undefined, var3, "allies");
  }

  if(isDefined(var15.unittype) && isDefined(level.agent_funcs[var15.unittype]) && isDefined(level.agent_funcs[var15.unittype]["on_damaged_finished"])) {
    var15[[level.agent_funcs[var15.unittype]["on_damaged_finished"]]](var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, 0, var12, var13);
    return;
  }

  var15[[level.agent_funcs[var15.agent_type]["on_damaged_finished"]]](var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, 0, var12, var13);
}

function turn_off_have_target_hud(var0) {
  switch (var0) {
    case "iw8_me_akimboblunt_mp":
    case "iw8_me_riotshield_mp":
      return true;
  }

  return false;
}

function ref_1289f(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = self;
  var13 endon("death");

  if(!isPlayer(var1)) {
    return;
  }

  if(var2 >= var13.health) {
    if(isDefined(var1.ref_119d4) && var1.ref_119d4.size > 0) {
      if(istrue(var1.ref_119d4[var13 getentitynumber()])) {
        return;
      }
    }

    var1 thread scripts\mp\mp_agent_damage::vip_playerdied(undefined, self, var12, var4, var0, 0, var8);
    thread scripts\mp\ammorestock::onplayerkilled(var0, var1, var2, var3, var4, var12, var8, var1.modifiers);
    return;
  }
}

function setuphudelemninfilcover(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = var12.basename;
  var14 = 0;

  if(isDefined(var0) && (issubstr(var13, "thermite") || isDefined(var12.magazine) && issubstr(var12.magazine, "boltfire") || isDefined(var0.weapon_name) && issubstr(var0.weapon_name, "incendiary"))) {
    var14 = 1;
    var15 = var8 == "shield";

    if(var15) {
      var16 = scripts\engine\trace::create_character_contents();
      var17 = vectorNormalize(var7);
      var18 = var6 - var17 * 12;
      var19 = var6 + var17 * 12;
      var20 = scripts\engine\trace::ray_trace_detail(var18, var19, undefined, var16);

      if(var20["fraction"] > 0 && var20["fraction"] < 1) {
        var21 = var6 - self.origin;
        var21 = (var21[0], var21[1], 0);

        if(vectordot(var21, var20["normal"]) < 0) {
          var15 = 0;
        }
      } else {
        var15 = 0;
      }
    }

    if(var15) {
      var22 = var0 getlinkedparent();

      if(isDefined(var22) && var22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self.ref_13b2a = 0;
      }
    } else if(var8 != "none") {
      self.clearspaceforscriptableinstance = undefined;
      self.ref_13b2a = undefined;
    }
  }

  if(var8 == "shield") {
    if(var14) {
      return true;
    }
  } else if(var8 == "none" && isDefined(var0)) {
    var23 = var0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var14 && isDefined(var23) && var23 == self) {
      if(!isDefined(self.ref_13b2c)) {
        self.ref_13b2c = [var0];
      } else if(!scripts\engine\utility::array_contains(self.ref_13b2c, var0)) {
        self.ref_13b2c[self.ref_13b2c.size] = var0;
      }

      self.ref_13b2a++;
      return true;
    } else if(issubstr(var13, "molotov")) {
      var24 = var0.origin - self.origin;
      var25 = vectorNormalize((var24[0], var24[1], 0));
      var24 = vectorNormalize(var24);

      if(vectordot(anglesToForward(self.angles), var25) > 0.5 && -0.98 < var24[2] && var24[2] < 0.98) {
        return true;
      }
    }
  }

  if(var4 == "MOD_MELEE") {
    if(isDefined(var1)) {
      var26 = vectorNormalize(var1.origin - self.origin);
    } else {
      var26 = vectorNormalize(var7 - self.origin);
    }

    var27 = anglesToForward(self.angles);

    if(vectordot(var27, var26) > 0.5) {
      return true;
    }
  }

  return false;
}

function bink_save_hack(var0, var1, var2, var3, var4) {
  var5 = var0;

  switch (var2) {
    case "rifle":
      var5 = min(var0, 84);
      break;
    case "smg":
      var5 = min(var0, 110);
      break;
    case "mg":
      var5 = min(var0, 105);
      break;
    case "spread":
      var5 = min(var0, 84);
      break;
    case "pistol":
      var5 = min(var0, 75);
      break;
    case "sniper":
      var5 = min(var0, 130);
      break;
    default:
      var5 = var0;
      break;
  }

  return var0;
}

function triggered_module_spawn() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function getcodecomputerdisplaycode() {
  level endon("game_ended");
  level.bullet_damage_scalar = 1;

  for(;;) {
    var0 = getdvarfloat("scr_bullet_damage_scalar", 1);

    if(level.bullet_damage_scalar != var0) {
      level.bullet_damage_scalar = var0;
    }

    wait 1;
  }
}

function register_ai_drop_funcs() {
  register_drop_func("weapon", &drop_weapon_func, &should_drop_weapon, 0);
}

function register_drop_func(var0, var1, var2, var3) {
  if(!isDefined(level.ai_drop_info)) {
    level.ai_drop_info = [];
  }

  var4 = spawnStruct();
  var4.name = var0;
  var4.chance_func = var2;
  var4.func = var1;
  var4.score = 0;
  var4.delay = var3;
  var4.next_chance = 0;
  level.ai_drop_info[level.ai_drop_info.size] = var4;
}

function ai_drop_func(var0) {
  if(!isDefined(level.ai_drop_info)) {
    return;
  }

  if(isDefined(level.ref_13fd4)) {
    [[level.ref_13fd4]](self.origin, var0);
  }

  if(isDefined(self.force_drop)) {
    var1 = get_func_by_name(self.force_drop);
    self thread[[var1]](var0);
    return;
  }

  var2 = check_for_drop(var0);
}

function get_func_by_name(var0) {
  for(var1 = 0; var1 < level.ai_drop_info.size; var1++) {
    if(level.ai_drop_info[var1].name == var0) {
      return level.ai_drop_info[var1].func;
    }
  }
}

function drop_ready_item(var0, var1) {
  var2 = gettime();
  self thread[[var0.func]](var1);
  var0.score = 0;
  var0.next_chance = var2 + var0.delay * 1000;
}

function check_for_drop(var0) {
  var1 = gettime();
  var2 = 0;
  var3 = scripts\engine\utility::array_randomize(level.ai_drop_info);

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var3[var4];

    if(!var2) {
      if(var1 > var5.next_chance) {
        if(var5.score > 99) {
          drop_ready_item(var5, var0);
          var2 = 1;
          continue;
        }

        if([[var5.chance_func]](var0)) {
          drop_ready_item(var5, var0);
          var2 = 1;
        }
      }
    }
  }

  return var2;
}

function drop_weapon_func(var0) {
  if(!istrue(var0.eattacker.ref_11e8e)) {
    self.dropweapon = 1;
  }

  if(!isPlayer(var0.eattacker)) {
    return;
  }

  if(isDefined(var0.eattacker.class) && var0.eattacker.class == "crusader" || isDefined(level.blueprintextract_trygetreward)) {
    if(ref_132c8(var0.eattacker)) {
      drop_grenade(var0);
    }
  }

  if(var0.eattacker scripts\cp\utility::_hasperk("specialty_scavenger")) {
    if(ref_132cb(var0.eattacker)) {
      var1 = self.origin - (10, 10, 0);
      minigun_origin_offset(var0, var1);
      return;
    }

    return;
  }
}

function ref_132cb(var0) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(var0.waittill_any_return_no_endon_death_6)) {
    var0.waittill_any_return_no_endon_death_6 = gettime();
    return true;
  }

  var1 = 10000;
  var2 = gettime() - var0.waittill_any_return_no_endon_death_6;

  if(var2 > var1) {
    var0.waittill_any_return_no_endon_death_6 = gettime();
    return true;
  }

  return false;
}

function minigun_origin_offset(var0, var1) {
  var2 = self.origin;

  if(isDefined(var1)) {
    var2 = var1;
  }

  var3 = spawn("script_model", var2);
  thread astar_node_radius_override(var3);
}

function astar_node_radius_override(var0) {
  self endon("death");

  foreach(var2 in level.players) {
    if(var2 != var0) {
      self hidefromplayer(var2);
    }
  }

  self setModel("equipment_scavenger_bag");
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 10);
  thread scripts\cp\utility::delayentdelete(20);
  self.trigger thread scripts\cp\utility::delayentdelete(20);

  for(;;) {
    self.trigger waittill("trigger", var4);

    if(var4 == var0) {
      var4 playlocalsound("weap_ammo_pickup");
      score_spawner_relative_to_objective(var4);
      var4 thread scripts\cp\cp_damagefeedback::hudicontype("scavenger");
      self.trigger delete();
      self delete();
    }
  }
}

function scorelimitreached() {
  var0 = self getweaponslistprimaries();

  foreach(var2 in var0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var2)) {
      continue;
    }

    if(scripts\cp\cp_weapon::is_launcher(var2)) {
      continue;
    }

    if(cangive_ammo()) {
      var3 = self getweaponammoclip(var2);
      var4 = self getweaponammostock(var2);
      var5 = weaponclipsize(var2);
      var6 = var3 + var4 + var5;

      if(var6 == var5) {
        self setweaponammoclip(var2, var6);
      } else {
        self setweaponammoclip(var2, var5);
        var7 = var6 - var5;
        self setweaponammostock(var2, var7);
      }
    }
  }
}

function score_spawner_relative_to_objective() {
  var0 = 30;
  var1 = 0;
  var2 = self getcurrentprimaryweapon();

  if(!scripts\cp\utility::is_valid_player()) {
    var1 = 1;
  }

  if(weapontype(var2) == "riotshield") {
    var1 = 1;
  }

  if(scripts\cp\cp_weapon::is_incompatible_weapon(var2)) {
    var1 = 1;
  }

  if(scripts\cp\cp_weapon::is_launcher(var2)) {
    var1 = 1;
  }

  if(!var1) {
    if(cangive_ammo()) {
      var0 = getammooverride(var2);
      var3 = self getweaponammostock(var2);
      var4 = weaponmaxammo(var2);
      var5 = var3 + var0;
      var6 = int(min(var4, var5));
      self setweaponammostock(var2, var6);
      return true;
    }
  }

  var7 = self getweaponslistprimaries();

  foreach(var6 in var7) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var6) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var6)) {
      continue;
    }

    if(scripts\cp\cp_weapon::is_launcher(var6)) {
      continue;
    }

    if(cangive_ammo()) {
      var4 = getammooverride(var6);
      var3 = self getweaponammostock(var6);
      var4 = weaponmaxammo(var6);
      var5 = var3 + var4;
      var6 = int(min(var4, var5));
      self setweaponammostock(var6, var6);
      return true;
    }
  }

  var5 = undefined;
  var6 = undefined;
  return false;
}

function getammooverride(var0) {
  var1 = var0 getbaseweapon();
  var2 = weaponclipsize(var1);
  var3 = scripts\cp\utility::getweaponrootname(var0);
  var4 = 30;
  var5 = var4;

  if(var0.isalternate) {
    var6 = scripts\cp\utility::attachmentmap_tobase(var0.underbarrel);

    switch (var6) {
      case "glsemtex":
      case "glgas":
      case "gl":
      case "glsnap":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glsmoke":
        var5 = 1;
        break;
      case "ubshtgn":
        var5 = 999;
        break;
      default:
        var5 = 0;
        break;
    }
  } else {
    switch (var0.classname) {
      case "spread":
        switch (var3) {
          case "iw8_sh_charlie725":
            var5 = 6;
            break;
          case "iw8_sh_dpapa12":
            var5 = 8;
            break;
          default:
            var5 = int(min(var2, var4));
            break;
        }

        break;
      case "sniper":
        switch (var3) {
          case "iw8_sn_crossbow":
            var5 = 3;
            break;
          default:
            var5 = int(min(var2, var4));
            break;
        }

        break;
      default:
        var5 = int(min(var2, var4));
        break;
    }
  }

  return var5;
}

function cangive_ammo() {
  var0 = scripts\cp\utility::getvalidtakeweapon();
  var1 = self getweaponammoclip(var0);
  var2 = weaponclipsize(var0);
  var3 = weaponmaxammo(var0);
  var4 = self getweaponammostock(var0);

  if(var4 < var3 || var1 < var2) {
    return 1;
  }

  return 0;
}

function ref_132c8(var0) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(var0.waittill_any_timeout_no_endon_death_1)) {
    var0.waittill_any_timeout_no_endon_death_1 = gettime();
    return true;
  }

  var1 = 10000;
  var2 = gettime() - var0.waittill_any_timeout_no_endon_death_1;

  if(var2 > var1) {
    var0.waittill_any_timeout_no_endon_death_1 = gettime();
    return true;
  }

  return false;
}

function drop_grenade(var0) {
  var1 = self.origin + (10, 10, 0);
  mine_destroyed_vfx(var0, var1);
}

function mine_destroyed_vfx(var0, var1, var2) {
  var3 = self.origin;

  if(isDefined(var1)) {
    var3 = var1;
  }

  var4 = scripts\cp\utility::createhintobject(var3, "HINT_BUTTON", "cp_crate_icon_lethalrefill", &"COOP_GAME_PLAY/PICK_GRENADE", 5, "duration_short", "show", 200, undefined, 100, 360);
  var4 setModel("offhand_wm_grenade_mike67");
  thread activate_grenade_object();
  var4 thread scripts\cp\utility::delayentdelete(30);

  if(isDefined(var2)) {
    foreach(var6 in level.players) {
      if(var6 != var2) {
        var4 hidefromplayer(var6);
      }
    }

    return;
  }
}

function activate_grenade_object() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);
    var0 forceplaygestureviewmodel("ges_pickup");
    var0 playlocalsound("weap_ammo_pickup");

    foreach(var2 in var0.powers) {
      if(var2.slot == "primary") {
        var0 notify("pickup_equipment", var2.weaponuse);
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

function should_do_damage_checks(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    return false;
  } else if(var0 != var5 && isDefined(var0.team) && var0.team == var5.team) {
    return false;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var0, var1, var2, var3, var4, var5)) {
    return false;
  }

  if(isDefined(level.ref_132c6)) {
    if(isarray(level.ref_132c6) && level.ref_132c6.size > 0) {
      foreach(var7 in level.ref_132c6) {
        if(![[var7]](var0, var1, var2, var3, var4, var5)) {
          return false;
        }
      }
    }
  }

  return true;
}

function ishighdamageweapon(var0) {
  return var0.classname == "sniper" || var0.classname == "dmr";
}

function should_drop_weapon(var0) {
  var1 = getdvarint("scr_force_weapon_drop");

  if(var1) {
    return true;
  }

  if(!isDefined(level.weapon_drop_cooldown)) {
    return false;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!isDefined(var0.eattacker)) {
    return false;
  }

  var2 = 5;
  var3 = gettime();
  var4 = var0.eattacker getentitynumber();

  if(!isDefined(level.weapon_drop_cooldown[var4])) {
    level.weapon_drop_cooldown[var4] = var3 + var2 * 1000;
    return true;
  }

  if(var3 > level.weapon_drop_cooldown[var4]) {
    level.weapon_drop_cooldown[var4] = var3 + var2 * 1000;
    return true;
  }

  return false;
}

function is_flashbang(var0, var1, var2) {
  if(isDefined(var1.underbarrel)) {
    var3 = scripts\cp\utility::attachmentmap_tobase(var1.underbarrel);

    if(var3 == "glflash" || var3 == "glconc") {
      return true;
    }
  }

  return var0 == "flash_grenade_mp";
}

function is_gas(var0) {
  return var0 == "gas_mp";
}

function callbacksoldieragentgametypedamagefinished(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(var4 == "MOD_SUICIDE") {
    return;
  }

  var3 = 0;

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

function callbacksoldieragentgametypekilled(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  scripts\cp\cp_agent_utils::deactivateagent();

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](var1, var4);
  }

  if(triggered_module_spawn()) {
    if(!istrue(self.died_poorly)) {
      level notify("grenade_exploded_during_stealth", self.origin, "suicide_vest", rear_spotlight(var0, var1, self.origin));
    }
  }

  if(var3 == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.isinlaststand)) {
    var9 = spawnStruct();
    var9.einflictor = var0;
    var9.eattacker = var1;
    var9.idamage = var2;
    var9.smeansofdeath = var3;
    var9.sweapon = var4;
    var9.vdir = var5;
    var9.shitloc = var6;
    var9.timeoffset = var7;
    var9.deathanimduration = var8;
    GscBinSkip1(0x74, self.isinlaststand, var9);
  }

  if(isPlayer(var2)) {
    level notify("zombie_killed_by", var2);
    thread handle_death_sounds(level, var2, self);
    self.died_poorly = undefined;
    var10 = scripts\cp\cp_endgame::get_current_zone(var2);
    var11 = 1;
    scripts\cp\cp_analytics::ref_119b5(var2, self, var5);

    if(isDefined(var2.perk_data) && var2 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
      var12 = 10;
      var13 = var12 * var2.perk_data["super_fill_scalar"];
      var2 scripts\cp\coop_super::increase_super_progress(var13);
    }
  }

  if(scripts\cp\cp_relics::calldropbag()) {
    if(isPlayer(var2) && isDefined(level.updateonkillrelicsfunc)) {
      level thread[[level.updateonkillrelicsfunc]](var5, var2, self, var4, var7);
    }
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  if(isDefined(self.attackers)) {
    foreach(var15 in self.attackers) {
      if(var15 == var2) {
        continue;
      }

      if(self == var15) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      var16 = undefined;

      if(isDefined(self.attackerdata)) {
        var17 = self.attackerdata[var15.guid];

        if(isDefined(var17)) {
          var16 = var17.objweapon;
        }
      }

      var18 = 0;

      if(self.attackerdata[var15.guid].damage >= 35) {
        var18 = 1;
      }

      if(self.attackerdata[var15.guid].damage >= 70) {
        var18 = 2;
      }

      var15 thread scripts\cp\cp_gamescore::processassist(self, var16, var18);
      LOC_0000025b:
    }
  }

  give_attacker_kill_rewards(var1, var2, var7, var4, var5);
  var20 = 0;
  scripts\cp\cp_damagefeedback::process_damage_feedback(var1, var2, var3, var20, var4, var5, var6, var6, var7, var8, self);
  scripts\cp\cp_merits::process_agent_on_killed_merits(var1, var2, var3, var4, var5, var6, var7, var8, var9);
  level thread scripts\cp\utility::add_to_notify_queue("ai_killed", self.origin, var5, var4, var2, self, self.team);
}

function ref_13c35() {
  self endon("death_or_disconnect");
  self notify("stop_tracking_consec_kills");
  self endon("stop_tracking_consec_kills");

  for(;;) {
    level waittill("ai_killed", var0, var1, var2, var3, var4, var5);

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
  var0 = 3;

  if(scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak")) {
    var0 += 3;
  }

  return var0;
}

function handle_death_sounds(var0, var1, var2) {
  if(!scripts\engine\utility::isbulletdamage(var2)) {
    return;
  }

  if(isDefined(var1.deathsound) && soundexists(var1.deathsound)) {
    playsoundatpos(var1.origin, var1.deathsound);
  }

  var3 = var1;

  if(var2 == "MOD_HEAD_SHOT") {
    var3 playsoundtoplayer("bullet_impact_headshot", var0);
    var3 playsoundtoteam("bullet_impact_headshot_npc", var0.team, var0);
    return;
  }

  var3 playsoundtoplayer("mp_kill_alert", var0);
  var3 playsoundtoteam("mp_hit_alert_final_npc", var0.team, var0);
}

function give_attacker_kill_rewards(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    return;
  }

  if(isDefined(self.team) && isDefined(var1.team) && self.team == var1.team) {
    return;
  }

  if(!isDefined(self.agent_type)) {
    return;
  }

  var5 = scripts\mp\mp_agent::get_agent_type(self);
  var6 = getdvarint("scr_agent_points_override", 0);

  if(var6 != 0) {
    var7 = var6;
  } else {
    var7 = level.agent_definition[var6]["reward"];
  }

  var8 = level.agent_definition[var6]["xp"];
  var9 = 0;
  var10 = triggered_module_spawn();
  var11 = isDefined(var5) && (var5.basename == "incendiary_ammo_mp" || var5.basename == "slayer_ammo_mp");

  if(isDefined(var2.classname) && var2.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar)) {
      var12 = var7 * (level.cash_scalar + level.consumable_cash_scalar);
    } else {
      var12 = var8 * level.cash_scalar;
    }

    foreach(var14 in level.players) {
      if(!var14 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(isDefined(level.zombie_xp)) {
        var14 scripts\cp\cp_persistence::give_player_xp(int(var9));
      }

      if(istrue(level.special_event)) {
        continue;
      }

      var15 = "large";
      var4 = "none";
      var14 scripts\cp\cp_persistence::give_player_currency(var12, var15, var4, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(var7) && (!isDefined(var7.owner) || !isPlayer(var7.owner))) {
    return;
  }

  if(isDefined(var7.owner)) {
    var7 = var7.owner;
    var14 = 1;
  }

  if(!var16 && (var11 == "generic_zombie" || var11 == "fast_zombie" || var11 == "zombie_cop")) {
    if(scripts\cp\utility::isheadshot(var10, var8, var9, var7) && !var14 && scripts\engine\utility::isbulletdamage(var9) && !var15) {
      var12 = int(100);
      var13 = int(75);
    }

    if(isDefined(var9) && var9 == "MOD_MELEE" && !issubstr(var10.basename, "axe")) {
      var12 = int(130);
      var13 = int(100);
    }
  }

  if(isPlayer(var7)) {
    if(!istrue(var7.pers["ignoreWeaponMatchBonus"]) && (scripts\cp\cp_weapon::iscacprimaryweapon(var10) || scripts\cp\cp_weapon::iscacsecondaryweapon(var10))) {
      if(!isDefined(var7.pers["weaponMatchBonusKills"])) {
        var7.pers["weaponMatchBonusKills"] = 1;
      } else {
        var7.pers["weaponMatchBonusKills"]++;
      }

      if(var7.pers["weaponMatchBonusKills"] > scripts\cp\cp_weaponrank::reload_use_think()) {
        var7.pers["ignoreWeaponMatchBonus"] = 1;
        var7.pers["weaponMatchBonusKills"] = undefined;
        var7.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(var7.pers["killsPerWeapon"])) {
          var7.pers["killsPerWeapon"] = [];
        }

        var17 = scripts\cp\utility::getweaponrootname(var10);
        var18 = 0;

        foreach(var20 in var7.pers["killsPerWeapon"]) {
          if(var21 == var17) {
            var20.killcount++;
            var18 = 1;
            break;
          }
        }

        if(!var18) {
          var20 = spawnStruct();
          var20.killcount = 1;
          var20.basename = var10.basename;
          var20.ref_1213c = var7.pers["killsPerWeapon"].size;
          var7.pers["killsPerWeapon"][var17] = var20;
        }
      }
    }
  }

  if(isDefined(level.kill_reward_func)) {
    var12 = [[level.kill_reward_func]](var7, var7, var8, var9, var10, var11, var12);
  }

  if(isDefined(var12)) {
    givekillreward(var7, var7, var12, var13, "large", var8, var10, var9);
    return;
  }
}

function givekillreward(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(level.consumable_cash_scalar)) {
    var2 *= level.cash_scalar + level.consumable_cash_scalar;
  } else {
    var2 *= level.cash_scalar;
  }

  thread giveplayerbonuscash(var1, var0, var1, var2, var3, var4, var5, var6);
  var1 scripts\cp\cp_persistence::record_player_kills(var6, var5, var7, var1);

  if(isDefined(self.shared_damage_points)) {
    foreach(var9 in level.players) {
      if(istrue(level.special_event)) {
        continue;
      }

      var9 scripts\cp\cp_persistence::give_player_currency(var2, var4, var5, 1, "crafted");
      LOC_000000a0:
    }
  } else if(should_get_currency_from_kill(var0, var1, var6)) {
    var1 scripts\cp\cp_persistence::give_player_currency(var2, var4, var5, 1);
  }

  if(!scripts\cp\utility::tryingtoleave()) {
    var1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill", var6, undefined, undefined, self);
    return;
  }
}

function giveplayerbonuscash(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(should_get_currency_from_kill(var0, var1, var6)) {
    if(var1 scripts\cp\utility::is_consumable_active("extra_sniping_points") && scripts\engine\utility::isbulletdamage(var7) && var6.classname == "weapon_sniper" && checkaltmodestatus(var6)) {
      var8 = 300;

      if(var6 == "iw7_shared_fate_weapon") {
        var1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
      } else {
        var1 scripts\cp\utility::notify_used_consumable("extra_sniping_points");
        thread delaygivecurrency(var1, var8, var4, var5, "bonus");
      }
    }

    if(isPlayer(var1) && isDefined(var1.cash_scalar)) {
      if(isDefined(var1.cash_scalar_weapon) && var1.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(var6)) {
        var9 = int(var2 * var1.cash_scalar - var2);
        thread delaygivecurrency(var1, var9, var4, var5, "bonus");
      }

      if(isDefined(var1.cash_scalar_alt_weapon) && var1.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(var6) && istrue(var6.isalternate) && istrue(var1.alt_mode_passive)) {
        var9 = int(var2 * var1.cash_scalar - var2);
        thread delaygivecurrency(var1, var9, var4, var5, "bonus");
        return;
      }

      return;
    }

    return;
  }
}

function delaygivecurrency(var0, var1, var2, var3, var4) {
  self endon("disconnect");
  wait var4;
  scripts\cp\cp_persistence::give_player_currency(var0, var1, var2, 1, var3);
}

function should_get_currency_from_kill(var0, var1, var2) {
  if(isPlayer(var1) && scripts\cp\cp_laststand::player_in_laststand(var1)) {
    return false;
  }

  if(scripts\cp\utility::is_trap(var0, var2)) {
    return false;
  }

  if(istrue(level.special_event)) {
    return false;
  }

  return true;
}

function checkaltmodestatus(var0) {
  if(!isDefined(var0) || var0 == "none") {
    return 0;
  }

  var1 = scripts\cp\utility::getbaseweaponname(var0);

  switch (var1) {
    case "iw7_m8":
      if(scripts\cp\utility::isaltmodeweapon(var0)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

function addattacker(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var0.attackerdata)) {
    var0.attackerdata = [];
  }

  if(!isDefined(var1.guid) && (isagent(var1) || isPlayer(var1))) {
    var1.guid = var1 scripts\cp\utility\player::getuniqueid();
  }

  if(!isDefined(var1.guid)) {
    return;
  }

  if(!isDefined(var0.attackerdata[var1.guid])) {
    var0.attackers[var1.guid] = var1;
    var0.attackerdata[var1.guid] = spawnStruct();
    var0.attackerdata[var1.guid].damage = 0;
    var0.attackerdata[var1.guid].attackerent = var1;
    var0.attackerdata[var1.guid].firsttimedamaged = gettime();
    var0.attackerdata[var1.guid].hitcount = 1;
  } else {
    var0.attackerdata[var1.guid].hitcount++;
  }

  if(scripts\cp\cp_weapon::iscacprimaryweapon(var3) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var3)) {
    var0.attackerdata[var1.guid].diddamagewithprimary = 1;
  }

  if(isDefined(var9) && var9 != "MOD_MELEE") {
    var0.attackerdata[var1.guid].didnonmeleedamage = 1;
  }

  var10 = scripts\cp\utility::getequipmenttype(var3.basename);

  if(isDefined(var10)) {
    if(var10 == "lethal") {
      var0.attackerdata[var1.guid].diddamagewithlethalequipment = 1;
    }

    if(var10 == "tactical") {
      var0.attackerdata[var1.guid].diddamagewithtacticalequipment = 1;
    }
  }

  var0.attackerdata[var1.guid].damage += var4;
  var0.attackerdata[var1.guid].weapon = createheadicon(var3);
  var0.attackerdata[var1.guid].objweapon = var3;
  var0.attackerdata[var1.guid].vpoint = var5;
  var0.attackerdata[var1.guid].vdir = var6;
  var0.attackerdata[var1.guid].shitloc = var7;
  var0.attackerdata[var1.guid].psoffsettime = var8;
  var0.attackerdata[var1.guid].smeansofdeath = var9;
  var0.attackerdata[var1.guid].attackerent = var1;
  var0.attackerdata[var1.guid].lasttimedamaged = gettime();

  if(isDefined(var2) && !isPlayer(var2) && isDefined(var2.primaryweapon)) {
    var0.attackerdata[var1.guid].sprimaryweapon = var2.primaryweapon;
    return;
  }

  if(isDefined(var1) && isPlayer(var1) && !nullweapon(var1 getcurrentprimaryweapon())) {
    var0.attackerdata[var1.guid].sprimaryweapon = createheadicon(var1 getcurrentprimaryweapon());
    return;
  }

  var0.attackerdata[var1.guid].sprimaryweapon = undefined;
}

function rear_spotlight(var0, var1, var2) {
  if(isPlayer(var1)) {
    return var1.name;
  }

  if(isPlayer(var0)) {
    return var0.name;
  }

  if(isDefined(var0.owner) && isPlayer(var0.owner)) {
    return var0.owner.name;
  }

  var3 = scripts\engine\utility::getclosest(var2, level.players);
  return var3.name;
}

function _validateattacker(var0) {
  if(isagent(var0) && (!isDefined(var0.isactive) || !var0.isactive)) {
    return undefined;
  }

  if(isagent(var0) && !isDefined(var0.classname)) {
    return undefined;
  }

  return var0;
}