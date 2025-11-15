/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3958.gsc
***************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  func_03B3::func_DEE8();
  func_0F45::func_2371();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

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
  self.func_9342 = 1;
  self.immune_against_nuke = 1;
  self.aistate = "idle";
  self.movemode = "run";
  self.sharpturnnotifydist = 150;
  self.radius = 20;
  self.height = 53;
  self.func_252B = 26 + self.radius;
  self.func_B640 = "normal";
  self.func_B641 = 50;
  self.func_2539 = 54;
  self.func_253A = -64;
  self.func_4D45 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1.0;
  self.func_C081 = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self.func_2AB2 = 0;
  self.func_2AB8 = 1;
  self.timelineevents = 0;
  self.allowcrouch = 1;
  self.func_B5F9 = 40;
  self.func_B62E = 100;
  self.meleeradiusbasesq = squared(self.func_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self.func_B0FC = 1;
  self.full_gib = 0;
  scripts\mp\agents\zombie\zombie_util::func_F794(self.func_B62E);
  self.meleeradiuswhentargetnotonnavmesh = 100;
  self.croc_chomp = 0;
  self.spawn_round_num = level.wave_num;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.allowpain = 1;

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1)
    self.func_AB3F = 1;

  self.func_1009D = ::func_3121;
  thread func_B9B9();
  thread func_BA27();
  thread func_899C();
  var_00 = getdvarint("scr_zombie_traversal_push", 1);

  if(var_00 == 1)
    thread func_311D();

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

  foreach(var_04, var_01 in self.func_164D) {
    var_02 = var_1.func_4BC0;
    var_03 = anim.asm[var_04].states[var_02];
    scripts\asm\asm::func_2388(var_04, var_02, var_03, var_3.func_116FB);
    scripts\asm\asm::func_238A(var_04, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(var_00) {
  self setModel(func_7D86());
  thread func_50EF();
}

func_7D86() {
  var_00 = ["zmb_brute_mascot_body"];
  return scripts\engine\utility::random(var_00);
}

func_50EF() {
  self endon("death");
  wait 0.5;

  if(isDefined(level.func_C01F)) {
    return;
  }
  self getrandomhovernodesaroundtargetpos(1, 0.1);
}

func_AEB0() {
  level._effect["laser_muzzle_flash"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_brute_lensf.vfx");
}

func_3110(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = 25;
  var_13 = var_12 * var_12;
  var_14 = self gettagorigin("tag_eye");
  var_15 = (var_08 == "head" || var_08 == "helmet" || var_08 == "neck") && var_04 != "MOD_MELEE" && var_04 != "MOD_IMPACT" && var_04 != "MOD_CRUSH";

  if(!var_15 && var_08 == "torso_upper" && self.helmetlocation == "hand" && distancesquared(var_06, var_14) < var_13)
    var_15 = 1;

  if(var_15) {
    var_02 = scale_ww_damage(var_02, var_05);
    var_16 = var_02 / 3;

    if(isDefined(var_05) && (var_05 == "zmb_imsprojectile_mp" || var_05 == "zmb_fireworksprojectile_mp"))
      var_02 = 0;
    else
      var_02 = max(10, var_16);

    if(self.helmetlocation == "head") {
      if(!isDefined(self.func_8DDE))
        self.func_8DDE = 0;

      self.func_8DDE = self.func_8DDE + var_02;
      var_02 = 1;
    }
  } else
    var_02 = 1;

  return var_02;
}

scale_ww_damage(var_00, var_01) {
  var_02 = getweaponbasename(var_01);

  if(!isDefined(var_02)) {
    return;
  }
  var_03 = 2000;

  switch (var_02) {
    case "iw7_headcutter_zm_pap1":
    case "iw7_headcutter_zm":
    case "iw7_facemelter_zm_pap1":
    case "iw7_facemelter_zm":
    case "iw7_dischord_zm_pap1":
    case "iw7_dischord_zm":
    case "iw7_shredder_zm_pap1":
    case "iw7_shredder_zm":
      var_00 = var_03;
  }

  return var_00;
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

func_DB25(var_00) {
  self endon("death");
  self notify("reset_helmet_timer");
  self endon("reset_helmet_timer");
  wait(var_00);

  if(self.helmetlocation == "hand")
    self.desiredhelmetlocation = "head";
}

func_3112() {
  self endon("death");

  if(!isDefined(self.func_8DDE))
    self.func_8DDE = 0;

  while(!isDefined(self.maxhealth))
    wait 0.1;

  self.func_8E09 = 0;

  for(;;) {
    var_00 = self.health / self.maxhealth;
    var_01 = max(self.func_8DF0 * var_00, 1000);

    if(self.func_8E09 == 1)
      var_01 = var_01 * 0.5;

    self waittill("helmet_damage");

    if(self.func_8DDE > var_01) {
      self.func_8E09++;
      self.desiredhelmetlocation = "hand";
      self.func_8DDE = 0;

      if(self.func_8E09 < 2)
        thread func_DB25(20);
    }
  }
}

func_C4D0(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  if(!isDefined(self.func_8E09))
    self.func_8E09 = 0;

  if(self.croc_chomp)
    var_02 = 1;
  else if(var_08 == "head" || var_02 > 1) {
    var_13 = "standard";

    if(self.helmetlocation == "head") {
      if(!isDefined(self.func_8DDE))
        self.func_8DDE = 0;

      self notify("helmet_damage");
      var_02 = 0;
    } else {
      var_13 = "hitcritical";

      if(self.func_8E09 < 2)
        thread func_DB25(5);
    }

    if(isplayer(var_01))
      var_01 thread scripts\cp\cp_damage::updatedamagefeedback(var_13, undefined, var_02);
  } else if(var_08 == "helmet") {
    var_13 = "standard";

    if(self.helmetlocation == "head") {
      if(!isDefined(self.func_8DDE))
        self.func_8DDE = 0;

      self notify("helmet_damage");

      if(isplayer(var_01))
        var_01 thread scripts\cp\cp_damage::updatedamagefeedback(var_13, undefined, var_02);

      var_02 = 0;
    } else
      var_02 = 0;
  } else
    var_02 = 0;

  scripts\mp\mp_agent::default_on_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);
}

brute_killed_vo(var_00) {
  if(isplayer(var_00))
    var_00 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_brute", "zmb_comment_vo", "medium", 10, 0, 0, 0, 20);

  wait 4;
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_brute_death", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

func_C4D1(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  level thread brute_killed_vo(var_01);
  func_10838(self.func_1657, var_03, var_04);
  self.death_anim_no_ragdoll = 1;
  scripts\mp\mp_agent::default_on_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  var_09 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);

  if(isDefined(var_09) && !isDefined(self.func_72AC)) {
    if(!isDefined(level.brute_loot_check[self.spawn_round_num])) {
      level.brute_loot_check[self.spawn_round_num] = 1;
      level thread scripts\cp\loot::drop_loot(self.origin, var_01, var_09);
    }
  }

  var_10 = 400;

  foreach(var_12 in level.players) {
    var_12 scripts\cp\cp_persistence::give_player_currency(var_10);
    var_12 scripts\cp\zombies\achievement::update_achievement("THE_BIGGER_THEY_ARE", 1);
  }
}

func_10838(var_00, var_01, var_02) {
  self.func_CE65 = 1;
}

func_10840(var_00) {}

func_B9B9() {
  self endon("death");
  level endon("game_ended");
}

func_BA27() {
  self endon("death");
  level endon("game_ended");
}

func_A012() {
  if(!isDefined(level.func_13F60))
    return 0;

  return level.func_13F60;
}

killagent(var_00) {
  var_00 getrandomarmkillstreak(var_0.health + 500000, var_0.origin);
}

func_311E(var_00, var_01) {
  foreach(var_03 in level.players) {
    var_04 = self.origin[2] - var_3.origin[2];

    if(abs(var_04) < var_01) {
      var_05 = distance2dsquared(self.origin, var_3.origin);

      if(var_05 < var_00) {
        var_06 = self.velocity;
        var_07 = length2d(var_06);

        if(var_07 == 0) {
          break;
        }
        var_08 = var_3.origin - self.origin;
        var_08 = (var_8[0], var_8[1], 0);
        var_09 = vectornormalize(var_08);

        if(var_07 < 60)
          var_07 = 60;

        var_10 = var_03 getvelocity();
        var_10 = (var_10[0], var_10[1], 0);
        var_11 = length2d(var_10);

        if(var_11 > 0) {
          var_12 = var_09 * var_07;
          var_13 = var_10 + var_12;
          var_14 = length2d(var_13);

          if(vectordot(var_13, var_12) < 0) {
            var_15 = vectorcross((0, 0, 1), var_09);

            if(vectordot(var_15, var_10) > 0) {
              var_11 = length2d(var_10);
              var_10 = var_15 * var_11;
            } else {
              var_16 = var_15 * -1;
              var_11 = length2d(var_10);
              var_10 = var_16 * var_11;
            }

            var_13 = var_10 + var_12;
            var_07 = length2d(var_13);
          } else {
            if(var_11 > var_07)
              var_07 = var_11;

            var_09 = vectornormalize(var_13);
          }
        }

        var_03 _meth_84DC(var_09, var_07);
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
  if(!isDefined(self.desiredhelmetlocation) || !isDefined(self.helmetlocation))
    return 0;

  if(self.helmetlocation != self.desiredhelmetlocation)
    return 1;

  return 0;
}

func_88F5() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("large_footstep");
    var_00 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 500);

    foreach(var_02 in var_00) {
      var_02 earthquakeforplayer(0.2, 0.25, self.origin, 500);
      var_02 getyaw("artillery_rumble", self.origin);
    }
  }
}

func_3116() {
  self endon("death");
  var_00 = 0;

  for(;;) {
    if(scripts\engine\utility::is_true(self.func_3117)) {
      var_00 = 0;
      wait 1;
      continue;
    }

    if(scripts\engine\utility::is_true(self.is_traversing)) {
      var_00 = 0;
      wait 1;
      continue;
    }

    var_01 = undefined;
    var_02 = level.spawn_volume_array;

    foreach(var_04 in var_02) {
      if(!var_4.active) {
        continue;
      }
      if(self istouching(var_04)) {
        var_01 = var_04;
        break;
      }
    }

    if(!isDefined(var_01)) {
      var_00 = 0;
      self notify("no_path_to_targets");
    } else {
      var_06 = scripts\cp\zombies\func_0D60::allowedstances(var_01);

      if(var_06 == 0) {
        var_07 = 0;
        var_02 = var_1.func_186E;

        if(isDefined(var_02)) {
          foreach(var_04 in var_02) {
            var_06 = scripts\cp\zombies\func_0D60::allowedstances(var_04);

            if(var_06 > 0) {
              var_07 = 1;
              break;
            }
          }
        }

        if(!var_07)
          var_0++;
        else
          var_00 = 0;
      } else
        var_00 = 0;

      if(var_00 > 5) {
        self notify("no_path_to_targets");
        var_00 = 0;
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
    self.func_3117 = 1;
    func_1164D();
    self.func_3117 = 0;
  }
}

func_6CA4() {
  var_00 = scripts\cp\zombies\zombies_spawning::get_scored_goon_spawn_location();
  return var_00;
}

func_1164D() {
  var_00 = spawnStruct();
  var_0.origin = self.origin;
  scripts\cp\zombies\zombies_spawning::func_3115(var_00);
  self.ignoreall = 1;
  var_01 = scripts\engine\utility::getstruct("brute_hide_org", "targetname");
  self setorigin(var_1.origin, 1);
  self give_mp_super_weapon(self.origin);
  wait 3;
  var_02 = func_6CA4();
  scripts\cp\zombies\zombies_spawning::func_3115(var_02);
  self setorigin(var_2.origin + (0, 0, 3), 1);
  self.ignoreall = 0;
  wait 3;
}