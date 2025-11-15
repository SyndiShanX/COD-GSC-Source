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
  var_00 = [(324, 1657, 195), (319, 1164, 195), (980, 1639, 196), (966, 1148, 196), (210, 3338, 259), (425, 3778, 259), (985, 3777, 259), (1164, 3204, 259), (453, 187, 226), (452, -86, 195), (859, 189, 195), (839, -62, 227), (184, 2260, 284), (1066, 2275, 285), (974, 1752, 220), (334, 1049, 220), (967, 1516, 219), (968, 1281, 219), (967, 1043, 222), (934, 313, 248), (373, 314, 243), (236, 990, 243), (1048, 991, 242), (1272, 999, 283), (1224, 319, 297), (-56, 990, 297), (77, 318, 297), (141, -197, 302), (-344, -941, 182), (133, -1281, 606), (695, -1616, 611), (449, -1472, 595), (-277, -396, 239), (-395, -339, 388), (1151, -840, 115)];
  foreach(var_02 in var_00) {
    var_03 = func_B28D(var_02);
    level.var_85F2[level.var_85F2.size] = var_03;
  }
}

func_B28D(param_00) {
  var_01 = spawnStruct();
  var_01.origin = param_00;
  return var_01;
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

func_85F6(param_00, param_01) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    scripts\asm\asm_bb::bb_requestcombatmovetype_facemotion();
    return;
  }

  scripts\asm\asm_bb::bb_requestcombatmovetype_strafe();
}

func_85F8(param_00, param_01) {
  var_02 = vectornormalize(param_01.origin - param_00.origin) * (1, 1, 0);
  param_01 setvelocity(var_02 * 800);
  param_00 playSound("grey_force_push");
  if(isplayer(param_01)) {
    param_01 earthquakeforplayer(0.5, 1, param_01.origin, 800);
    if(!scripts\engine\utility::istrue(param_00.i_am_clone)) {
      param_01 shellshock("frag_grenade_mp", 1);
    }
  }
}

func_1004E() {
  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return 0;
  }

  var_00 = gettime();
  if(var_00 < self.var_BF9F) {
    return 0;
  }

  self.var_BF9F = var_00 + randomintrange(3000, 5000);
  return 1;
}

func_2475() {
  if(isDefined(self.var_2AB4) && self.var_2AB4 == 0) {
    return;
  }

  self.voice = "american";
  self give_explosive_touch_on_revived("cloth");
  var_00 = [];
  var_00["tag_armor_head_ri"] = 165;
  var_00["tag_armor_head_le"] = 165;
  var_00["tag_armor_head_front"] = 165;
  var_00["tag_armor_forearm_le"] = 120;
  var_00["tag_armor_bicep_le"] = 120;
  var_00["tag_armor_forearm_ri"] = 120;
  var_00["tag_armor_bicep_ri"] = 120;
  var_00["tag_armor_chest_upper_le"] = 165;
  var_00["tag_armor_chest_upper_ri"] = 165;
  var_00["tag_armor_back_upper"] = 165;
  var_00["tag_armor_chest_stomach"] = 165;
  var_00["tag_armor_back_lower"] = 165;
  var_00["tag_armor_leg_thigh_front_le"] = 120;
  var_00["tag_armor_leg_thigh_back_le"] = 120;
  var_00["tag_armor_leg_thigh_front_ri"] = 120;
  var_00["tag_armor_leg_thigh_back_ri"] = 120;
  var_00["tag_armor_kneepad_behind_le"] = 50;
  var_00["tag_armor_kneepad_down_le"] = 50;
  var_00["tag_armor_kneepad_upper_le"] = 50;
  var_00["tag_armor_kneepad_behind_ri"] = 50;
  var_00["tag_armor_kneepad_down_ri"] = 50;
  var_00["tag_armor_kneepad_upper_ri"] = 50;
  self.var_2AB4 = 1;
}

setupdestructibleparts() {
  self.var_2AB5 = 1;
}

func_17CC(param_00, param_01) {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
    anim.var_85E1 = [];
  }

  var_02 = level.var_85DF.size;
  level.var_85DF[var_02] = param_00;
  level.var_85E1[var_02] = param_01;
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
      var_00 = self.var_EF7D;
    } else if(isDefined(self.var_EF7A)) {
      var_00 = self.var_EF7A.origin;
    } else if(isDefined(self.var_EF7C)) {
      var_00 = self.var_EF7C.origin;
    } else {
      continue;
    }

    var_01 = 16;
    if(isDefined(self.var_EF7E)) {
      var_01 = self.var_EF7E * self.var_EF7E;
    }

    if(distance2dsquared(self.origin, var_00) <= var_01) {
      self.var_EF7D = undefined;
      self.var_EF7C = undefined;
      if(!isDefined(self.var_EF7B)) {
        self.var_EF7A = undefined;
      }

      self notify("scriptedGoal_reached");
    }
  }
}

func_F834(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  self.var_EF79 = param_01;
  self.var_EF73 = param_00;
}

func_F835(param_00, param_01) {
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = undefined;
  self.var_EF7D = param_00;
  self.var_EF7E = param_01;
}

func_F833(param_00, param_01) {
  self.var_EF7D = undefined;
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = param_00;
  self.var_EF7E = param_01;
}

func_F832(param_00, param_01, param_02) {
  self.var_EF7D = undefined;
  self.var_EF7C = undefined;
  self.var_EF7A = param_00;
  self.var_EF7E = param_01;
  if(isDefined(param_02) && param_02) {
    self.var_EF7B = param_02;
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

func_C5D1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  scripts\mp\mp_agent::default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  foreach(var_0A in level.players) {
    var_0A scripts\cp\cp_persistence::give_player_xp(1000, 1);
  }

  if(isDefined(level.grey_on_killed_func)) {
    [[level.grey_on_killed_func]](self, param_01, param_04, param_06, param_03);
  }
}

try_merge_clones(param_00) {
  if(isDefined(level.spawned_grey) && level.spawned_grey.size > 1) {
    if(!isDefined(param_00)) {
      param_00 = func_79F0();
    }

    var_01 = func_79F1(param_00);
    foreach(var_03 in level.spawned_grey) {
      if(var_03 == var_01) {
        continue;
      }

      func_B67C(var_03, var_01);
    }

    func_12BFD(var_01);
    var_01 notify("update_mobile_shield_visibility", 1);
    var_01 thread func_50D4(var_01);
  }

  level notify("grey_duplicating_attack_end");
}

func_50D4(param_00) {
  param_00 endon("death");
  wait(1.5);
  param_00 suicide();
}

func_12BFD(param_00) {
  func_B2C4(param_00);
  param_00.i_am_clone = 0;
  param_00.var_10AB7 = undefined;
  param_00.desiredenemydistmax = 360;
  param_00.meleerangesq = 90000;
  param_00.strafeifwithindist = param_00.desiredenemydistmax + 100;
  param_00.can_do_duplicating_attack = 0;
  param_00.can_do_health_regen = 0;
  param_00 setModel("park_alien_gray");
  param_00 give_zombies_perk();
  scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(param_00);
  scripts\aitypes\zombie_grey\behaviors::reset_recent_damage_data(param_00);
  scripts\asm\zombie_grey\zombie_grey_asm::func_E2FB(param_00);
  scripts\asm\zombie_grey\zombie_grey_asm::func_E2FA(param_00);
  param_00 thread func_8CAC(param_00);
  param_00 scripts\mp\mp_agent::func_FAFA("iw7_zapper_grey");
}

func_B2C4(param_00) {
  var_01 = param_00.available_fuse;
  foreach(var_03 in var_01) {
    if(scripts\engine\utility::array_contains(param_00.var_269D, var_03.tag_name)) {
      var_03 show();
      continue;
    }

    param_00.available_fuse = scripts\engine\utility::array_remove(param_00.available_fuse, var_03);
  }
}

func_79F1(param_00) {
  var_01 = undefined;
  var_02 = -1;
  foreach(var_04 in level.spawned_grey) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(var_04 == param_00) {
      continue;
    }

    if(var_04.health > var_02) {
      var_01 = var_04;
      var_02 = var_04.health;
    }
  }

  return var_01;
}

func_79F0() {
  var_00 = undefined;
  var_01 = 9999999;
  foreach(var_03 in level.spawned_grey) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.health < var_01) {
      var_00 = var_03;
      var_01 = var_03.health;
    }
  }

  return var_00;
}

func_B67C(param_00, param_01) {
  level thread func_CD95(param_00, param_01);
  param_01.health = param_01.health + param_00.health;
  param_00.nocorpse = 1;
  if(isalive(param_00)) {
    param_00 suicide();
  }
}

func_CD95(param_00, param_01) {
  var_02 = spawn("script_model", param_00.origin + (0, 0, 50));
  var_02 setModel("tag_origin");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_02, "tag_origin");
  var_02 moveto(param_01.origin + (0, 0, 50), 0.8, 0.8);
  var_02 waittill("movedone");
  var_02 delete();
}

func_C5CF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = 3.5;
  if(isDefined(param_01) && param_01 == self) {
    return;
  }

  if(scripts\engine\utility::istrue(self.is_regening_health)) {
    if(isDefined(param_04) && param_04 == "MOD_MELEE" && isDefined(self.alien_fuse_exposed) && isDefined(param_06) && distancesquared(param_06, self.alien_fuse_exposed.origin) < 225) {
      self playSound("grey_fuse_smash");
      self.current_max_health_regen_level = max(self.min_health_regen_level, self.current_max_health_regen_level - self.max_health_regen_level_penalty);
      self.melee_attacker = param_01;
      self notify("stop_regen_health");
      return;
    } else {
      var_0D = gettime();
      if(isplayer(param_01)) {
        if(!scripts\engine\utility::istrue(self.actually_doing_regen)) {
          scripts\cp\cp_agent_utils::process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, self);
        }

        if(func_FF8A(self, param_01, var_0D)) {
          param_01.var_D8A2 = var_0D;
          if(randomint(100) > 80) {
            param_01 thread scripts\cp\cp_vo::try_to_play_vo("nag_ufo_fusefail", "zmb_comment_vo", "low", 3, 0, 0, 1);
          }
        }
      }

      return;
    }
  }

  if(isDefined(var_0C) && var_0C == "j_chest_light") {
    param_09 = "head";
    param_03 = int(param_03 * var_0D);
  } else if(isDefined(param_09) && param_09 == "head" || param_09 == "helmet" || param_09 == "neck") {
    param_09 = "soft";
    param_03 = int(param_03 / var_0D);
  }

  if(isDefined(param_06) && param_06 == "zmb_imsprojectile_mp" || param_06 == "zmb_fireworksprojectile_mp") {
    param_03 = min(int(self.maxhealth / 20), 1000);
  }

  param_04 = param_04 | level.idflags_no_knockback;
  scripts\cp\agents\gametype_zombie::onzombiedamaged(param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, var_0C);
  if(isDefined(param_03)) {
    if(isplayer(param_02)) {
      if(!isDefined(self.sum_of_recent_damage)) {
        scripts\aitypes\zombie_grey\behaviors::reset_recent_damage_data(self);
      }

      self.sum_of_recent_damage = self.sum_of_recent_damage + param_03;
      if(!scripts\engine\utility::array_contains(self.recent_player_attackers, param_02)) {
        self.recent_player_attackers = scripts\engine\utility::array_add(self.recent_player_attackers, param_02);
        return;
      }
    }
  }
}

func_C5D0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  scripts\cp\agents\gametype_zombie::onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
  scripts\aitypes\zombie_grey\behaviors::try_update_mobile_shield(self, param_01);
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

func_FF8A(param_00, param_01, param_02) {
  var_03 = 3000;
  var_04 = 22500;
  if(distancesquared(param_00.origin, param_01.origin) > var_04) {
    return 0;
  }

  if(!isDefined(param_01.var_D8A2)) {
    return 1;
  }

  if(param_02 - param_01.var_D8A2 > var_03) {
    return 1;
  }

  return 0;
}

func_8CAC(param_00) {
  param_00 notify("stop_health_light_monitor");
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("stop_health_light_monitor");
  scripts\engine\utility::waitframe();
  if(scripts\engine\utility::istrue(param_00.i_am_clone)) {
    return;
  }

  while(!isDefined(param_00.maxhealth)) {
    scripts\engine\utility::waitframe();
  }

  var_01 = param_00.maxhealth * 0.33;
  var_02 = param_00.maxhealth * 0.66;
  for(;;) {
    if(param_00.health <= var_01) {
      param_00 setscriptablepartstate("health_light", "red");
    } else if(param_00.health <= var_02) {
      param_00 setscriptablepartstate("health_light", "yellow");
    } else {
      param_00 setscriptablepartstate("health_light", "green");
    }

    param_00 scripts\engine\utility::waittill_any_3("damage", "update_health_light");
  }
}