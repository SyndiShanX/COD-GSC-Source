/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3958.gsc
**************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  func_03B3::func_DEE8();
  func_0F45::func_2371();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["zombie_brute"]["setup_func"] = ::setupagent;
  level.agent_definition["zombie_brute"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["zombie_brute"]["on_killed"] = ::func_C4D1;
  level.agent_funcs["zombie_brute"]["on_damaged_finished"] = ::func_C4D0;
  level.brute_damage_adjustment_func = ::func_3110;
  level.brute_loot_check = [];
}

setupagent() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.saved_actionslotdata = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  self.disabledweapon = undefined;
  self.disabledweaponswitch = undefined;
  self.disabledoffhandweapons = undefined;
  self.disabledusability = 1;
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.entered_playspace = 0;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self.var_9342 = 1;
  self.immune_against_nuke = 1;
  self.aistate = "idle";
  self.movemode = "run";
  self.sharpturnnotifydist = 150;
  self.radius = 20;
  self.height = 53;
  self.var_252B = 26 + self.radius;
  self.var_B640 = "normal";
  self.var_B641 = 50;
  self.var_2539 = 54;
  self.var_253A = -64;
  self.var_4D45 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1.0;
  self.var_C081 = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self.var_2AB2 = 0;
  self.var_2AB8 = 1;
  self.timelineevents = 0;
  self.allowcrouch = 1;
  self.var_B5F9 = 40;
  self.var_B62E = 100;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self.var_B0FC = 1;
  self.full_gib = 0;
  scripts\mp\agents\zombie\zombie_util::func_F794(self.var_B62E);
  self.meleeradiuswhentargetnotonnavmesh = 100;
  self.croc_chomp = 0;
  self.spawn_round_num = level.wave_num;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.allowpain = 1;

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }

  self.var_1009D = ::func_3121;
  thread func_B9B9();
  thread func_BA27();
  thread func_899C();
  var_0 = getdvarint("scr_zombie_traversal_push", 1);

  if(var_0 == 1) {
    thread func_311D();
  }

  thread func_89C9();
  func_108D6();
  thread func_3112();
  thread func_88F5();
  thread func_88BA();
}

func_89C9() {
  scripts\engine\utility::waitframe();
  scripts\asm\asm_bb::bb_requestmovetype("run");
  level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "run_grunt", 1);
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();

  foreach(var_4, var_1 in self.var_164D) {
    var_2 = var_1.var_4BC0;
    var_3 = anim.asm[var_4].states[var_2];
    scripts\asm\asm::func_2388(var_4, var_2, var_3, var_3.var_116FB);
    scripts\asm\asm::func_238A(var_4, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(var_0) {
  self setModel(func_7D86());
  thread func_50EF();
}

func_7D86() {
  var_0 = ["zmb_brute_mascot_body"];
  return scripts\engine\utility::random(var_0);
}

func_50EF() {
  self endon("death");
  wait 0.5;

  if(isDefined(level.var_C01F)) {
    return;
  }
  self getrandomhovernodesaroundtargetpos(1, 0.1);
}

func_AEB0() {
  level._effect["laser_muzzle_flash"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_brute_lensf.vfx");
}

func_3110(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = 25;
  var_13 = var_12 * var_12;
  var_14 = self gettagorigin("tag_eye");
  var_15 = (var_8 == "head" || var_8 == "helmet" || var_8 == "neck") && var_4 != "MOD_MELEE" && var_4 != "MOD_IMPACT" && var_4 != "MOD_CRUSH";

  if(!var_15 && var_8 == "torso_upper" && self.helmetlocation == "hand" && distancesquared(var_6, var_14) < var_13) {
    var_15 = 1;
  }

  if(var_15) {
    var_2 = scale_ww_damage(var_2, var_5);
    var_16 = var_2 / 3;

    if(isDefined(var_5) && (var_5 == "zmb_imsprojectile_mp" || var_5 == "zmb_fireworksprojectile_mp")) {
      var_2 = 0;
    } else {
      var_2 = max(10, var_16);
    }

    if(self.helmetlocation == "head") {
      if(!isDefined(self.var_8DDE)) {
        self.var_8DDE = 0;
      }

      self.var_8DDE = self.var_8DDE + var_2;
      var_2 = 1;
    }
  } else {
    var_2 = 1;
  }

  return var_2;
}

scale_ww_damage(var_0, var_1) {
  var_2 = getweaponbasename(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 2000;

  switch (var_2) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      var_0 = var_3;
  }

  return var_0;
}

func_108D6() {
  self.desiredhelmetlocation = "head";
  self.helmetlocation = "head";
}

func_BCBC() {
  self.helmetlocation = "hand";
  self setscriptablepartstate("eyes", "yellow_eyes");
  self.moveratescale = 1.0;
  scripts\asm\asm_bb::bb_requestmovetype("sprint");
}

func_BCBD() {
  self setscriptablepartstate("eyes", "eye_glow_off");
  self.helmetlocation = "head";
  self.moveratescale = 1.0;
  scripts\asm\asm_bb::bb_requestmovetype("run");
}

func_DB25(var_0) {
  self endon("death");
  self notify("reset_helmet_timer");
  self endon("reset_helmet_timer");
  wait(var_0);

  if(self.helmetlocation == "hand") {
    self.desiredhelmetlocation = "head";
  }
}

func_3112() {
  self endon("death");

  if(!isDefined(self.var_8DDE)) {
    self.var_8DDE = 0;
  }

  while(!isDefined(self.maxhealth)) {
    wait 0.1;
  }

  self.var_8E09 = 0;

  for(;;) {
    var_0 = self.health / self.maxhealth;
    var_1 = max(self.var_8DF0 * var_0, 1000);

    if(self.var_8E09 == 1) {
      var_1 = var_1 * 0.5;
    }

    self waittill("helmet_damage");

    if(self.var_8DDE > var_1) {
      self.var_8E09++;
      self.desiredhelmetlocation = "hand";
      self.var_8DDE = 0;

      if(self.var_8E09 < 2) {
        thread func_DB25(20);
      }
    }
  }
}

func_C4D0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(self.var_8E09)) {
    self.var_8E09 = 0;
  }

  if(self.croc_chomp) {
    var_2 = 1;
  } else if(var_8 == "head" || var_2 > 1) {
    var_13 = "standard";

    if(self.helmetlocation == "head") {
      if(!isDefined(self.var_8DDE)) {
        self.var_8DDE = 0;
      }

      self notify("helmet_damage");
      var_2 = 0;
    } else {
      var_13 = "hitcritical";

      if(self.var_8E09 < 2) {
        thread func_DB25(5);
      }
    }

    if(isplayer(var_1)) {
      var_1 thread scripts\cp\cp_damage::updatedamagefeedback(var_13, undefined, var_2);
    }
  } else if(var_8 == "helmet") {
    var_13 = "standard";

    if(self.helmetlocation == "head") {
      if(!isDefined(self.var_8DDE)) {
        self.var_8DDE = 0;
      }

      self notify("helmet_damage");

      if(isplayer(var_1)) {
        var_1 thread scripts\cp\cp_damage::updatedamagefeedback(var_13, undefined, var_2);
      }

      var_2 = 0;
    } else {
      var_2 = 0;
    }
  } else {
    var_2 = 0;
  }

  scripts\mp\mp_agent::default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

brute_killed_vo(var_0) {
  if(isplayer(var_0)) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_brute", "zmb_comment_vo", "medium", 10, 0, 0, 0, 20);
  }

  wait 4;
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_brute_death", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

func_C4D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level thread brute_killed_vo(var_1);
  func_10838(self.var_1657, var_3, var_4);
  self.death_anim_no_ragdoll = 1;
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);

  if(isDefined(var_9) && !isDefined(self.var_72AC)) {
    if(!isDefined(level.brute_loot_check[self.spawn_round_num])) {
      level.brute_loot_check[self.spawn_round_num] = 1;
      level thread scripts\cp\loot::drop_loot(self.origin, var_1, var_9);
    }
  }

  var_10 = 400;

  foreach(var_12 in level.players) {
    var_12 scripts\cp\cp_persistence::give_player_currency(var_10);
    var_12 scripts\cp\zombies\achievement::update_achievement("THE_BIGGER_THEY_ARE", 1);
  }
}

func_10838(var_0, var_1, var_2) {
  self.var_CE65 = 1;
}

func_10840(var_0) {}

func_B9B9() {
  self endon("death");
  level endon("game_ended");
}

func_BA27() {
  self endon("death");
  level endon("game_ended");
}

func_A012() {
  if(!isDefined(level.var_13F60)) {
    return 0;
  }

  return level.var_13F60;
}

killagent(var_0) {
  var_0 getrandomarmkillstreak(var_0.health + 500000, var_0.origin);
}

func_311E(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_4 = self.origin[2] - var_3.origin[2];

    if(abs(var_4) < var_1) {
      var_5 = distance2dsquared(self.origin, var_3.origin);

      if(var_5 < var_0) {
        var_6 = self.velocity;
        var_7 = length2d(var_6);

        if(var_7 == 0) {
          break;
        }
        var_8 = var_3.origin - self.origin;
        var_8 = (var_8[0], var_8[1], 0);
        var_9 = vectornormalize(var_8);

        if(var_7 < 60) {
          var_7 = 60;
        }

        var_10 = var_3 getvelocity();
        var_10 = (var_10[0], var_10[1], 0);
        var_11 = length2d(var_10);

        if(var_11 > 0) {
          var_12 = var_9 * var_7;
          var_13 = var_10 + var_12;
          var_14 = length2d(var_13);

          if(vectordot(var_13, var_12) < 0) {
            var_15 = vectorcross((0, 0, 1), var_9);

            if(vectordot(var_15, var_10) > 0) {
              var_11 = length2d(var_10);
              var_10 = var_15 * var_11;
            } else {
              var_16 = var_15 * -1;
              var_11 = length2d(var_10);
              var_10 = var_16 * var_11;
            }

            var_13 = var_10 + var_12;
            var_7 = length2d(var_13);
          } else {
            if(var_11 > var_7) {
              var_7 = var_11;
            }

            var_9 = vectornormalize(var_13);
          }
        }

        var_3 func_84DC(var_9, var_7);
      }
    }
  }
}

func_311F() {
  self endon("death");
  level endon("game_ended");
  self endon("traverse_end");

  for(;;) {
    func_311E(3600, 100);
    scripts\engine\utility::waitframe();
  }
}

func_311D() {
  self endon("death");
  self endon("game_ended");

  for(;;) {
    self waittill("traverse_begin");
    func_311F();
  }
}

func_3121() {
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation)) {
    return 0;
  }

  if(self.helmetlocation != self.desiredhelmetlocation) {
    return 1;
  }

  return 0;
}

func_88F5() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("large_footstep");
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 500);

    foreach(var_2 in var_0) {
      var_2 earthquakeforplayer(0.2, 0.25, self.origin, 500);
      var_2 getyaw("artillery_rumble", self.origin);
    }
  }
}

func_3116() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    if(scripts\engine\utility::is_true(self.var_3117)) {
      var_0 = 0;
      wait 1;
      continue;
    }

    if(scripts\engine\utility::is_true(self.is_traversing)) {
      var_0 = 0;
      wait 1;
      continue;
    }

    var_1 = undefined;
    var_2 = level.spawn_volume_array;

    foreach(var_4 in var_2) {
      if(!var_4.active) {
        continue;
      }
      if(self istouching(var_4)) {
        var_1 = var_4;
        break;
      }
    }

    if(!isDefined(var_1)) {
      var_0 = 0;
      self notify("no_path_to_targets");
    } else {
      var_6 = scripts\cp\zombies\func_0D60::allowedstances(var_1);

      if(var_6 == 0) {
        var_7 = 0;
        var_2 = var_1.var_186E;

        if(isDefined(var_2)) {
          foreach(var_4 in var_2) {
            var_6 = scripts\cp\zombies\func_0D60::allowedstances(var_4);

            if(var_6 > 0) {
              var_7 = 1;
              break;
            }
          }
        }

        if(!var_7) {
          var_0++;
        } else {
          var_0 = 0;
        }
      } else {
        var_0 = 0;
      }

      if(var_0 > 5) {
        self notify("no_path_to_targets");
        var_0 = 0;
      }
    }

    wait 1;
  }
}

func_88BA() {
  self endon("death");
  level endon("game_ended");
  thread func_3116();

  for(;;) {
    self waittill("no_path_to_targets");
    self.var_3117 = 1;
    func_1164D();
    self.var_3117 = 0;
  }
}

func_6CA4() {
  var_0 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
  return var_0;
}

func_1164D() {
  var_0 = spawnStruct();
  var_0.origin = self.origin;
  scripts\cp\zombies\zombies_spawning::func_3115(var_0);
  self.ignoreall = 1;
  var_1 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
  self setorigin(var_1.origin, 1);
  self give_mp_super_weapon(self.origin);
  wait 3;
  var_2 = func_6CA4();
  scripts\cp\zombies\zombies_spawning::func_3115(var_2);
  self setorigin(var_2.origin + (0, 0, 3), 1);
  self.ignoreall = 0;
  wait 3;
}