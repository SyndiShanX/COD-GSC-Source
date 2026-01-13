/***************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_grey\zombie_grey_agent.gsc
***************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  lib_03B5::func_DEE8();
  lib_0F47::func_2371();
  func_9812();
  func_98E9();
  func_98E8();
  func_9885();
  func_98D8();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["zombie_grey"]["setup_func"] = ::setupagent;
  level.agent_funcs["zombie_grey"]["on_killed"] = ::func_C5D1;
  level.agent_funcs["zombie_grey"]["on_damaged"] = ::func_C5CF;
  level.agent_funcs["zombie_grey"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.agent_funcs["zombie_grey"]["gametype_on_damage_finished"] = ::func_C5D0;
}

func_98E8() {
  scripts\engine\utility::flag_init("clone_complete");
}

func_9885() {
  level.var_85EE = 0;
}

func_98D8() {
  level.var_85F2 = [];
  var_0 = [(324, 1657, 195), (319, 1164, 195), (980, 1639, 196), (966, 1148, 196), (210, 3338, 259), (425, 3778, 259), (985, 3777, 259), (1164, 3204, 259), (453, 187, 226), (452, -86, 195), (859, 189, 195), (839, -62, 227), (184, 2260, 284), (1066, 2275, 285), (974, 1752, 220), (334, 1049, 220), (967, 1516, 219), (968, 1281, 219), (967, 1043, 222), (934, 313, 248), (373, 314, 243), (236, 990, 243), (1048, 991, 242), (1272, 999, 283), (1224, 319, 297), (-56, 990, 297), (77, 318, 297), (141, -197, 302), (-344, -941, 182), (133, -1281, 606), (695, -1616, 611), (449, -1472, 595), (-277, -396, 239), (-395, -339, 388), (1151, -840, 115)];
  foreach(var_2 in var_0) {
    var_3 = func_B28D(var_2);
    level.var_85F2[level.var_85F2.size] = var_3;
  }
}

func_B28D(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  return var_1;
}

setupagent() {
  self.var_71D0 = ::func_1004E;
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 360;
  self.desiredenemydistmin = 340;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.fastcrawlanimscale = 12;
  self.forcefastcrawldist = 340;
  self.fastcrawlmaxhealth = 40;
  self.dismemberchargeexplodedistsq = 2500;
  self.explosionradius = 75;
  self.explosiondamagemin = 30;
  self.explosiondamagemax = 50;
  self.guid = self getentitynumber();
  self.backawayenemydist = 0;
  self.meleerangesq = 22500;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 250;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 50;
  self.meleemaxdamage = 70;
  self.var_B62B = ::func_85F8;
  self.var_BF9F = gettime() + randomintrange(3000, 5000);
  self.var_9343 = 1;
  self.immune_against_freeze = 1;
  self.var_9342 = 1;
  self.immune_against_nuke = 1;
  self.allowpain = 0;
  self.var_1A44 = 90;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.var_4F63 = ::func_85F6;
  func_2475();
  setupdestructibleparts();
  self setscriptablepartstate("backpack_dome_shield", "on");
  if(isDefined(level.greysetupfunc)) {
    [[level.greysetupfunc]](self);
  }

  thread scriptedgoalwaitforarrival();
  thread func_8CAC(self);
}

func_85F6(var_0, var_1) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
    return;
  }

  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
}

func_85F8(var_0, var_1) {
  var_2 = vectornormalize(var_1.origin - var_0.origin) * (1, 1, 0);
  var_1 setvelocity(var_2 * 800);
  var_0 playSound("grey_force_push");
  if(isplayer(var_1)) {
    var_1 earthquakeforplayer(0.5, 1, var_1.origin, 800);
    if(!scripts\engine\utility::istrue(var_0.i_am_clone)) {
      var_1 shellshock("frag_grenade_mp", 1);
    }
  }
}

func_1004E() {
  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return 0;
  }

  var_0 = gettime();
  if(var_0 < self.var_BF9F) {
    return 0;
  }

  self.var_BF9F = var_0 + randomintrange(3000, 5000);
  return 1;
}

func_2475() {
  if(isDefined(self.var_2AB4) && self.var_2AB4 == 0) {
    return;
  }

  self.voice = "american";
  self give_explosive_touch_on_revived("cloth");
  var_0 = [];
  var_0["tag_armor_head_ri"] = 165;
  var_0["tag_armor_head_le"] = 165;
  var_0["tag_armor_head_front"] = 165;
  var_0["tag_armor_forearm_le"] = 120;
  var_0["tag_armor_bicep_le"] = 120;
  var_0["tag_armor_forearm_ri"] = 120;
  var_0["tag_armor_bicep_ri"] = 120;
  var_0["tag_armor_chest_upper_le"] = 165;
  var_0["tag_armor_chest_upper_ri"] = 165;
  var_0["tag_armor_back_upper"] = 165;
  var_0["tag_armor_chest_stomach"] = 165;
  var_0["tag_armor_back_lower"] = 165;
  var_0["tag_armor_leg_thigh_front_le"] = 120;
  var_0["tag_armor_leg_thigh_back_le"] = 120;
  var_0["tag_armor_leg_thigh_front_ri"] = 120;
  var_0["tag_armor_leg_thigh_back_ri"] = 120;
  var_0["tag_armor_kneepad_behind_le"] = 50;
  var_0["tag_armor_kneepad_down_le"] = 50;
  var_0["tag_armor_kneepad_upper_le"] = 50;
  var_0["tag_armor_kneepad_behind_ri"] = 50;
  var_0["tag_armor_kneepad_down_ri"] = 50;
  var_0["tag_armor_kneepad_upper_ri"] = 50;
  self.var_2AB4 = 1;
}

setupdestructibleparts() {
  self.var_2AB5 = 1;
}

func_17CC(var_0, var_1) {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
    anim.var_85E1 = [];
  }

  var_2 = level.var_85DF.size;
  level.var_85DF[var_2] = var_0;
  level.var_85E1[var_2] = var_1;
}

func_9812() {
  func_17CC(0, (41.5391, 7.28883, 72.2128));
  func_17CC(1, (34.8849, -4.77048, 74.0488));
}

scriptedgoalwaitforarrival() {
  self endon("death");
  for(;;) {
    self waittill("goal_reached");
    if(isDefined(self.var_EF7D)) {
      var_0 = self.var_EF7D;
    } else if(isDefined(self.var_EF7A)) {
      var_0 = self.var_EF7A.origin;
    } else if(isDefined(self.var_EF7C)) {
      var_0 = self.var_EF7C.origin;
    } else {
      continue;
    }

    var_1 = 16;
    if(isDefined(self.var_EF7E)) {
      var_1 = self.var_EF7E * self.var_EF7E;
    }

    if(distance2dsquared(self.origin, var_0) <= var_1) {
      self.var_EF7D = undefined;
      self.var_EF7C = undefined;
      if(!isDefined(self.var_EF7B)) {
        self.var_EF7A = undefined;
      }

      self notify("scriptedGoal_reached");
    }
  }
}

func_F834(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.var_EF79 = var_1;
  self.var_EF73 = var_0;
}

func_F835(var_0, var_1) {
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = undefined;
  self.var_EF7D = var_0;
  self.var_EF7E = var_1;
}

func_F833(var_0, var_1) {
  self.var_EF7D = undefined;
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = var_0;
  self.var_EF7E = var_1;
}

func_F832(var_0, var_1, var_2) {
  self.var_EF7D = undefined;
  self.var_EF7C = undefined;
  self.var_EF7A = var_0;
  self.var_EF7E = var_1;
  if(isDefined(var_2) && var_2) {
    self.var_EF7B = var_2;
    return;
  }

  self.var_EF7B = undefined;
}

func_41D9() {
  if(isDefined(self.var_EF7D) || isDefined(self.var_EF7A) || isDefined(self.var_EF7C)) {
    self.var_EF7D = undefined;
    self.var_EF7A = undefined;
    self.var_EF7B = undefined;
    self.var_EF7C = undefined;
    self clearpath();
  }
}

func_C5D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  foreach(var_0A in level.players) {
    var_0A scripts\cp\cp_persistence::give_player_xp(1000, 1);
  }

  if(isDefined(level.grey_on_killed_func)) {
    [[level.grey_on_killed_func]](self, var_1, var_4, var_6, var_3);
  }
}

try_merge_clones(var_0) {
  if(isDefined(level.spawned_grey) && level.spawned_grey.size > 1) {
    if(!isDefined(var_0)) {
      var_0 = func_79F0();
    }

    var_1 = func_79F1(var_0);
    foreach(var_3 in level.spawned_grey) {
      if(var_3 == var_1) {
        continue;
      }

      func_B67C(var_3, var_1);
    }

    func_12BFD(var_1);
    var_1 notify("update_mobile_shield_visibility", 1);
    var_1 thread func_50D4(var_1);
  }

  level notify("grey_duplicating_attack_end");
}

func_50D4(var_0) {
  var_0 endon("death");
  wait(1.5);
  var_0 suicide();
}

func_12BFD(var_0) {
  func_B2C4(var_0);
  var_0.i_am_clone = 0;
  var_0.var_10AB7 = undefined;
  var_0.desiredenemydistmax = 360;
  var_0.meleerangesq = 90000;
  var_0.strafeifwithindist = var_0.desiredenemydistmax + 100;
  var_0.can_do_duplicating_attack = 0;
  var_0.can_do_health_regen = 0;
  var_0 setModel("park_alien_gray");
  var_0 give_zombies_perk();
  scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(var_0);
  scripts\aitypes\zombie_grey\behaviors::reset_recent_damage_data(var_0);
  scripts\asm\zombie_grey\zombie_grey_asm::func_E2FB(var_0);
  scripts\asm\zombie_grey\zombie_grey_asm::func_E2FA(var_0);
  var_0 thread func_8CAC(var_0);
  var_0 scripts\mp\mp_agent::func_FAFA("iw7_zapper_grey");
}

func_B2C4(var_0) {
  var_1 = var_0.available_fuse;
  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(var_0.var_269D, var_3.tag_name)) {
      var_3 show();
      continue;
    }

    var_0.available_fuse = scripts\engine\utility::array_remove(var_0.available_fuse, var_3);
  }
}

func_79F1(var_0) {
  var_1 = undefined;
  var_2 = -1;
  foreach(var_4 in level.spawned_grey) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(var_4 == var_0) {
      continue;
    }

    if(var_4.health > var_2) {
      var_1 = var_4;
      var_2 = var_4.health;
    }
  }

  return var_1;
}

func_79F0() {
  var_0 = undefined;
  var_1 = 9999999;
  foreach(var_3 in level.spawned_grey) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(var_3.health < var_1) {
      var_0 = var_3;
      var_1 = var_3.health;
    }
  }

  return var_0;
}

func_B67C(var_0, var_1) {
  level thread func_CD95(var_0, var_1);
  var_1.health = var_1.health + var_0.health;
  var_0.nocorpse = 1;
  if(isalive(var_0)) {
    var_0 suicide();
  }
}

func_CD95(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin + (0, 0, 50));
  var_2 setModel("tag_origin");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_2, "tag_origin");
  var_2 moveto(var_1.origin + (0, 0, 50), 0.8, 0.8);
  var_2 waittill("movedone");
  var_2 delete();
}

func_C5CF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = 3.5;
  if(isDefined(var_1) && var_1 == self) {
    return;
  }

  if(scripts\engine\utility::istrue(self.is_regening_health)) {
    if(isDefined(var_4) && var_4 == "MOD_MELEE" && isDefined(self.alien_fuse_exposed) && isDefined(var_6) && distancesquared(var_6, self.alien_fuse_exposed.origin) < 225) {
      self playSound("grey_fuse_smash");
      self.current_max_health_regen_level = max(self.min_health_regen_level, self.current_max_health_regen_level - self.max_health_regen_level_penalty);
      self.melee_attacker = var_1;
      self notify("stop_regen_health");
      return;
    } else {
      var_0D = gettime();
      if(isplayer(var_1)) {
        if(!scripts\engine\utility::istrue(self.actually_doing_regen)) {
          scripts\cp\cp_agent_utils::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
        }

        if(func_FF8A(self, var_1, var_0D)) {
          var_1.var_D8A2 = var_0D;
          if(randomint(100) > 80) {
            var_1 thread scripts\cp\cp_vo::try_to_play_vo("nag_ufo_fusefail", "zmb_comment_vo", "low", 3, 0, 0, 1);
          }
        }
      }

      return;
    }
  }

  if(isDefined(var_0C) && var_0C == "j_chest_light") {
    var_9 = "head";
    var_3 = int(var_3 * var_0D);
  } else if(isDefined(var_9) && var_9 == "head" || var_9 == "helmet" || var_9 == "neck") {
    var_9 = "soft";
    var_3 = int(var_3 / var_0D);
  }

  if(isDefined(var_6) && var_6 == "zmb_imsprojectile_mp" || var_6 == "zmb_fireworksprojectile_mp") {
    var_3 = min(int(self.maxhealth / 20), 1000);
  }

  var_4 = var_4 | level.idflags_no_knockback;
  scripts\cp\agents\gametype_zombie::onzombiedamaged(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
  if(isDefined(var_3)) {
    if(isplayer(var_2)) {
      if(!isDefined(self.sum_of_recent_damage)) {
        scripts\aitypes\zombie_grey\behaviors::reset_recent_damage_data(self);
      }

      self.sum_of_recent_damage = self.sum_of_recent_damage + var_3;
      if(!scripts\engine\utility::array_contains(self.recent_player_attackers, var_2)) {
        self.recent_player_attackers = scripts\engine\utility::array_add(self.recent_player_attackers, var_2);
        return;
      }
    }
  }
}

func_C5D0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  scripts\cp\agents\gametype_zombie::onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
  scripts\aitypes\zombie_grey\behaviors::try_update_mobile_shield(self, var_1);
  scripts\aitypes\zombie_grey\behaviors::try_regen_health(self);
}

func_98E9() {
  level._effect["zombie_grey_shockwave_begin"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_swave_begin.vfx");
  level._effect["zombie_grey_shockwave_deploy"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_swave_deploy.vfx");
  level._effect["zombie_grey_teleport"] = loadfx("vfx\old\_requests\archetypes\vfx_phase_shift_start_volume");
  level._effect["zombie_grey_teleport_trail"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_grey_tport_trail.vfx");
  level._effect["zombie_grey_start_duplicate"] = loadfx("vfx\iw7\_requests\coop\vfx_magicwheel_beam.vfx");
  level._effect["summon_zombie_energy_ring"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_grey_spawn_portal.vfx");
  level._effect["zombie_mini_grey_shock_arc"] = loadfx("vfx\iw7\_requests\coop\vfx_mini_grey_shock_arc.vfx");
}

func_FF8A(var_0, var_1, var_2) {
  var_3 = 3000;
  var_4 = 22500;
  if(distancesquared(var_0.origin, var_1.origin) > var_4) {
    return 0;
  }

  if(!isDefined(var_1.var_D8A2)) {
    return 1;
  }

  if(var_2 - var_1.var_D8A2 > var_3) {
    return 1;
  }

  return 0;
}

func_8CAC(var_0) {
  var_0 notify("stop_health_light_monitor");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("stop_health_light_monitor");
  scripts\engine\utility::waitframe();
  if(scripts\engine\utility::istrue(var_0.i_am_clone)) {
    return;
  }

  while(!isDefined(var_0.maxhealth)) {
    scripts\engine\utility::waitframe();
  }

  var_1 = var_0.maxhealth * 0.33;
  var_2 = var_0.maxhealth * 0.66;
  for(;;) {
    if(var_0.health <= var_1) {
      var_0 setscriptablepartstate("health_light", "red");
    } else if(var_0.health <= var_2) {
      var_0 setscriptablepartstate("health_light", "yellow");
    } else {
      var_0 setscriptablepartstate("health_light", "green");
    }

    var_0 scripts\engine\utility::waittill_any_3("damage", "update_health_light");
  }
}