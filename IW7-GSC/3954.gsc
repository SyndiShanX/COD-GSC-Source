/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3954.gsc
***************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  func_03B2::func_DEE8();
  func_0F44::func_2371();
  level.func_13BDC = 1;
  level.func_4878 = 0;
  level.func_BF7C = 0;
  level.movemodefunc = [];
  level.func_BCE5 = [];
  level.func_C082 = [];
  level.func_126E9 = [];
  level.func_8EE6 = [];
  level.func_5662 = [];
  level.playerteam = "allies";
  func_9890();
  func_98A5();
  func_97FB();
  func_AEB0();
  thread func_FAB0();
  thread func_BC5C();
}

func_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

  level.agent_definition["generic_zombie"]["setup_func"] = ::setupagent;
  level.agent_definition["generic_zombie"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["on_killed"] = ::onzombiekilled;
}

setupagent() {
  thread func_12EE6();
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
  self.attackent = undefined;
  self.aistate = "idle";
  self.movemode = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
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
  self.func_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self.func_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.is_crawler = 0;
  self.died_poorly = 0;
  self.damaged_by_player = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.func_B0FC = 1;
  self.full_gib = 0;
  scripts\mp\agents\zombie\zombie_util::func_F794(self.func_B62E);
  self.favoriteenemy = undefined;
  self.func_E821 = undefined;
  self.last_damage_time_on_player = [];
  self.func_8C12 = 0;
  self.hasplayedvignetteanim = undefined;
  self.is_cop = undefined;
  self.highlyawareradius = 200;
  self.deathmethod = undefined;
  self.func_10A57 = undefined;
  self.gib_fx_override = undefined;
  self.func_CE65 = undefined;
  self.func_29D2 = 1;
  self.vignette_nocorpse = undefined;
  self.death_anim_no_ragdoll = undefined;
  self.func_B603 = 0.85;
  self.func_A9B8 = gettime();
  self.func_9342 = undefined;

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1)
    self.func_AB3F = 1;

  var_00 = 15;

  if(isDefined(level.avoidance_radius))
    var_00 = level.avoidance_radius;

  self setavoidanceradius(var_00);
  thread func_13F55();
  thread func_BA27();
  thread func_899C();
  var_01 = getdvarint("scr_zombie_traversal_push", 1);

  if(var_01 == 1)
    thread func_13F99();
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
  self setModel(func_79E5());
  thread func_50EF();
}

func_79E5() {
  var_00 = "zombie_male_outfit_1";
  var_01 = undefined;

  if(isDefined(level.generic_zombie_model_override_list))
    var_01 = scripts\engine\utility::random(level.generic_zombie_model_override_list);
  else if(isDefined(level.generic_zombie_model_list))
    var_01 = scripts\engine\utility::random(level.generic_zombie_model_list);
  else
    var_01 = var_00;

  return var_01;
}

dying_zapper_death() {
  return scripts\engine\utility::is_true(self.rocket_feet) || scripts\engine\utility::is_true(self.dischord_spin) || scripts\engine\utility::is_true(self.head_is_exploding) || scripts\engine\utility::is_true(self.shredder_death);
}

func_50EF() {
  self endon("death");
  wait 0.5;

  if(dying_zapper_death()) {
    return;
  }
  if(isDefined(level.func_C01F)) {
    return;
  }
  if(scripts\asm\zombie\zombie::func_9F87()) {
    self setscriptablepartstate("right_eye", "active");
    self setscriptablepartstate("left_eye", "active");
  } else if(scripts\engine\utility::is_true(self.is_turned))
    self setscriptablepartstate("eyes", "turned_eyes");
  else if(scripts\engine\utility::is_true(self.is_cop)) {
    self getrandomhovernodesaroundtargetpos(1, 0.1);
    self setscriptablepartstate("eyes", "cop_eyes");
  } else
    self getrandomhovernodesaroundtargetpos(1, 0.1);
}

func_13FAF() {
  return isDefined(self.func_117F7);
}

agent_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(isDefined(var_00) || isDefined(var_01)) {
    if(!isDefined(var_00))
      var_00 = var_01;

    if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
      if(isDefined(var_0.classname) && var_0.classname == "script_vehicle")
        return 0;
    }

    if(isDefined(var_0.classname) && var_0.classname == "auto_turret")
      var_01 = var_00;

    if(isDefined(var_01) && var_04 != "MOD_FALLING" && var_04 != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(var_1.team) && var_1.team != self.team)
          self setagentattacker(var_01);
      } else
        self setagentattacker(var_01);
    }
  }

  scripts\mp\mp_agent::default_on_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, 0.0, var_10, var_11);
  return 1;
}

func_9F01() {
  if(isDefined(self.inplayerscrambler) && self.inplayerscrambler)
    return 1;

  if(isDefined(self.inplayerportableradar) && self.inplayerportableradar)
    return 1;

  return 0;
}

func_12EE6() {
  self notify("updatePainSensor");
  self endon("updatePainSensor");
  self endon("death");
  self.func_C87E = spawnStruct();
  self.func_C87E.func_A9C8 = gettime();
  self.func_C87E.damage = 0.0;
  var_00 = 0.05;
  var_01 = 5 * var_00;

  for(;;) {
    wait(var_00);

    if(gettime() > self.func_C87E.func_A9C8 + 2000)
      self.func_C87E.damage = self.func_C87E.damage - var_01;

    self.func_C87E.damage = max(self.func_C87E.damage, 0);

    if(func_9F01())
      self.func_C87E.damage = 0;
  }
}

func_389D() {
  if(gettime() - self.spawntime <= 0.05)
    return 0;

  return 1;
}

func_13F9C(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");

  while(isDefined(self) && isalive(self)) {
    self.pendingdeath = 1;

    if(!func_389D()) {
      wait 0.05;
      continue;
    }

    self.pendingdeath = 0;
    onzombiedamagefinished(var_00, var_01, self.health + 1, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  }
}

func_C4E4(var_00, var_01, var_02) {
  if(isDefined(self.func_C4E5))
    [[self.func_C4E5]](var_00, var_01, var_02);

  if(isDefined(var_02) && (var_02 == "dna_aoe_grenade_zombie_mp" || var_02 == "trap_zm_mp")) {
    return;
  }
  self.func_C87E.func_A9C8 = gettime();
  self.func_C87E.damage = self.func_C87E.damage + var_00;
}

ispendingdeath(var_00) {
  return isDefined(self.pendingdeath) && self.pendingdeath;
}

func_9DC4() {
  return 0;
}

func_9FB2() {
  return 0;
}

isonhumanteam(var_00) {
  if(isDefined(var_0.team))
    return var_0.team == level.playerteam;

  return 0;
}

onzombiedamagefinished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  var_13 = self.health;
  var_14 = 0;
  var_15 = !func_13FAF() && var_04 != "MOD_FALLING" && var_05 != "repulsor_zombie_mp" && var_05 != "zombie_water_trap_mp";

  if(var_15 && scripts\engine\utility::is_true(self.died_poorly))
    var_15 = 0;

  if(dying_zapper_death())
    var_15 = 0;

  if(scripts\engine\utility::is_true(self.is_dancing))
    var_15 = 0;

  if(var_15 && isDefined(level.mutilation_perk_func))
    var_15 = [[level.mutilation_perk_func]](var_15, var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);

  if(self.health > 0)
    var_16 = clamp(var_02 / self.health, 0, 1);
  else
    var_16 = 1;

  if(var_15) {
    var_14 = func_128A7(var_08, var_05, var_04, var_16, var_01, var_07, var_04, var_00);

    if(var_14 && isDefined(var_01))
      var_02 = self.health + 1;
  }

  if(isDefined(var_01) && isplayer(var_01) && !isDefined(self.favoriteenemy)) {
    var_17 = isDefined(self.curmeleetarget) && self.curmeleetarget == var_01;
    var_18 = isDefined(self.curmeleetarget) && !isplayer(self.curmeleetarget);

    if(var_17 || var_18) {
      if(distancesquared(self.origin, var_1.origin) <= self.func_4D45) {
        scripts\mp\agents\zombie\zombie_util::func_F702(var_01);
        thread func_E1EB(0.2);
      }
    }
  }

  thread func_C4E3(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

  if(!func_389D() && self.health - var_02 <= 0) {
    thread func_13F9C(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_11, var_12);
    var_02 = int(max(0, self.health - 1));
  }

  func_C4E4(var_02, var_04, var_05);
  level notify("zombie_damaged", self, var_01);

  if(self.agent_type != "skater")
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "pain", 0);

  agent_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_11, var_12);

  if(isalive(self)) {
    if(var_14 && !ispendingdeath())
      self suicide();
    else
      func_12ECD();
  }
}

func_10168(var_00, var_01, var_02, var_03, var_04, var_05, var_03, var_06) {
  return 0;
}

func_E1EB(var_00) {
  self endon("death");
  wait(var_00);
  self.favoriteenemy = undefined;
}

func_12ECD() {}

func_9890() {
  level.func_1C7F = 1;
  level.func_4BEE = 0;
  level.func_C4BD = ::func_C4BD;
}

func_98A5() {
  level.func_BDFA = [];
  func_97F2();
}

func_97F2() {
  func_17F1("crawl", ::func_BDF8);
}

func_17F1(var_00, var_01, var_02, var_03, var_04) {
  level.func_BDFA[var_00] = [];
  level.func_BDFA[var_00][0] = var_01;
  level.func_BDFA[var_00][2] = var_02;
  level.func_BDFA[var_00][3] = var_03;
  level.func_BDFA[var_00][4] = var_04;
}

func_97FB() {
  level.func_566C[1]["tagName"] = "J_Shoulder_RI";
  level.func_566C[2]["tagName"] = "J_Shoulder_LE";
  level.func_566C[4]["tagName"] = "J_Hip_RI";
  level.func_566C[8]["tagName"] = "J_Hip_LE";
  level.func_566C[16]["tagName"] = "J_Head";
  level.func_566C[1]["torsoFX"] = "torso_arm_loss_right";
  level.func_566C[2]["torsoFX"] = "torso_arm_loss_left";
  level.func_566C[4]["torsoFX"] = "torso_loss_right";
  level.func_566C[8]["torsoFX"] = "torso_loss_left";
  level.func_566C[16]["torsoFX"] = "torso_head_loss";
  level.func_566C[1]["fxTagName"] = "J_Shoulder_RI";
  level.func_566C[2]["fxTagName"] = "J_Shoulder_LE";
  level.func_566C[4]["fxTagName"] = "J_Hip_RI";
  level.func_566C[8]["fxTagName"] = "J_Hip_LE";
  level.func_566C[16]["fxTagName"] = "j_neck";
  level.func_566C["full"]["fxTagName"] = "J_MainRoot";
  level.func_566C[1]["limbFX"] = "arm_loss_right";
  level.func_566C[2]["limbFX"] = "arm_loss_left";
  level.func_566C[4]["limbFX"] = "limb_loss_right";
  level.func_566C[8]["limbFX"] = "limb_loss_left";
  level.func_566C[16]["limbFX"] = "head_loss";
  level.func_74B9 = 0;
}

func_AEB0() {
  level._effect["gib_full_body"] = loadfx("vfx\iw7\_requests\coop\vfx_zmb_blackhole_death");
  level._effect["suicide_zmb_death"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_exp.vfx");
  level._effect["suicide_zmb_explode"] = loadfx("vfx\iw7\core\zombie\vfx_clown_exp_big.vfx");
  level._effect["gib_full_body_cheap"] = loadfx("vfx\iw7\_requests\coop\zmb_fullbody_gib");
  level._effect["torso_arm_loss_right"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_dism_arm_r.vfx");
  level._effect["torso_arm_loss_left"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_dism_arm_l.vfx");
  level._effect["torso_loss_left"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_torso_l.vfx");
  level._effect["torso_head_loss"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_dism_head.vfx");
  level._effect["torso_loss_right"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_torso_r.vfx");
  level._effect["arm_loss_left"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_arm_l.vfx");
  level._effect["arm_loss_right"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_arm_r.vfx");
  level._effect["limb_loss_right"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_limb_r.vfx");
  level._effect["limb_loss_left"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_limb_l.vfx");
  level._effect["head_loss"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_impact_head.vfx");
}

func_3DE4(var_00) {
  return isDefined(self.func_1657) && isDefined(self.func_1657[var_00]);
}

func_128A7(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = 0;

  if(!func_FF69(self))
    return 0;

  if(weaponisimpaling(var_01))
    return 0;

  if(isalive(self) && (!scripts\anim\notetracks_mp::isstatelocked() || var_03 >= 1) && !func_9FB2()) {
    if(!isDefined(self.func_B8BA))
      self.func_B8BA = 0;

    var_09 = func_7FD6(var_00, var_01, var_02, var_03, var_04, self.func_B8BA, var_07);

    if(var_09 != 0) {
      var_10 = !scripts\engine\utility::is_true(self.dismember_crawl);
      var_11 = isDefined(self.func_B8BA) && self.func_B8BA == 0;

      if(level.func_4878 < 8 || scripts\engine\utility::is_true(self.dismember_crawl) || (var_09 & 12) == 0 || (var_09 & 16) != 0 || (self.func_B8BA & 3) != 0) {
        if(func_BDFB(self.func_B8BA | var_09, var_01, var_03, var_05, var_06)) {
          if(func_9E51())
            earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);

          var_08 = 1;
        } else if(!isDefined(self.func_ACDB) && var_09 != 0 && (func_3DE4("exploder") || func_9E51() && (func_3DE4("emz") || func_3DE4("fast")))) {
          earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          var_08 = 1;
        }
      }
    }
  }

  return var_08;
}

func_FF69(var_00) {
  if(scripts\engine\utility::is_true(self.is_traversing))
    return 0;

  if(isDefined(self.linked_to_boat))
    return 0;

  if(isDefined(self.dontmutilate))
    return 0;

  if(isDefined(var_0.isfrozen))
    return 0;

  if(scripts\engine\utility::is_true(var_0.is_suicide_bomber))
    return 0;

  if(var_0.agent_type == "zombie_cop")
    return 0;

  if(var_0.agent_type == "zombie_brute")
    return 0;

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim)
    return 0;

  if(isDefined(level.traversal_dismember_check))
    return [[level.traversal_dismember_check]](var_00);

  return 1;
}

func_7FD6(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(var_03 >= 1) {
    if(func_3DE4("exploder"))
      return 31;
  }

  var_07 = func_9E51();

  if(var_07)
    var_08 = 31;
  else
    var_08 = func_AED2(var_00);

  var_09 = 1;

  if(isDefined(level.mutilation_mask_override_func)) {
    var_10 = [[level.mutilation_mask_override_func]](var_08, var_01, var_02, var_03, var_04, var_05, var_06);

    if(isDefined(var_10))
      var_08 = var_10;
  }

  if(var_08 == 0)
    return 0;

  var_09 = var_09 * (func_7E78(var_04, var_01, undefined) * func_7E78(var_04, undefined, var_02));
  var_09 = var_09 * (-0.7 * var_03 + 1);
  return func_7FD7(var_08, var_05, var_03, var_09);
}

func_C819(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  return 0;
}

func_9E51() {
  var_00 = scripts\engine\utility::flag_exist("insta_kill") && scripts\engine\utility::flag("insta_kill");
  return var_00;
}

func_AED2(var_00) {
  switch (var_00) {
    case "right_arm_lower":
    case "right_hand":
    case "right_arm_upper":
      return 1;
    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 4;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 8;
    case "neck":
    case "helmet":
    case "head":
      return 16;
    default:
      return 0;
  }
}

iskillstreakweapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  if(var_00 == "none")
    return 0;

  if(scripts\engine\utility::isdestructibleweapon(var_00))
    return 0;

  if(issubstr(var_00, "killstreak"))
    return 1;

  if(issubstr(var_00, "remote_tank_projectile"))
    return 1;

  if(issubstr(var_00, "minijackal_"))
    return 1;

  if(isDefined(level.killstreakweildweapons) && isDefined(level.killstreakweildweapons[var_00]))
    return 1;

  if(scripts\engine\utility::isairdropmarker(var_00))
    return 1;

  var_01 = weaponinventorytype(var_00);

  if(isDefined(var_01) && var_01 == "exclusive")
    return 1;

  return 0;
}

func_7E78(var_00, var_01, var_02) {
  if(func_9E51())
    return 0;

  var_03 = undefined;

  if(isDefined(var_01)) {
    var_01 = getweaponbasename(var_01);
    var_03 = var_01;
  } else if(isDefined(var_02))
    var_03 = var_02;

  if(!isDefined(var_03))
    return 1;

  if(isDefined(level.func_566F) && isDefined(level.func_566F[var_03]))
    return level.func_566F[var_03];

  var_04 = 1.0;

  if(isDefined(var_00) && isplayer(var_00) && isDefined(var_01) && isDefined(var_04) && !iskillstreakweapon(var_01)) {
    var_04 = func_3E61(var_00, var_01, var_04);
    return var_04;
  } else if(isDefined(var_04))
    return var_04;
  else
    return 1;
}

func_3E61(var_00, var_01, var_02) {
  var_03 = 1.0;

  if(!isDefined(var_03))
    return var_02;

  var_04 = _meth_8254(var_00, var_01);

  if(var_04 <= 1)
    return var_02;

  var_05 = var_02 - var_03;
  var_06 = var_02 - var_04 / 3 * var_05;
  return clamp(var_06, var_03, var_02);
}

_meth_8254(var_00, var_01) {
  var_02 = getweaponbasename(var_01);

  if(!func_8C3E(var_00, var_02))
    return 0;

  return var_0.weaponstate[var_02]["level"];
}

func_8C3E(var_00, var_01) {
  return isDefined(var_01) && isDefined(var_0.weaponstate) && isDefined(var_0.weaponstate[var_01]);
}

func_7FD7(var_00, var_01, var_02, var_03) {
  var_04 = 0;

  if(!isDefined(var_03))
    var_03 = 1;

  var_05 = var_00 & var_00 - 1;

  if(var_05 > 0) {
    if(var_02 < 1) {
      var_06 = randomint(24);
      var_07 = 228;

      for(var_08 = 4; var_08 > 0; var_8--) {
        var_09 = 1 << var_06 % var_08 * 2;
        var_06 = int(var_06 / var_08);
        var_10 = var_07 % var_09;
        var_11 = int(var_07 / var_09);
        var_07 = var_10 + (var_11 >> 2) * var_09;
        var_12 = 1 << (var_11 & 3);

        if((var_00 & var_12) != 0 && isDefined(func_2C18(var_01 | var_04 | var_12))) {
          if(randomfloat(1.0) > func_3C3B(var_12) * var_03)
            var_04 = var_04 | var_12;
        }
      }
    } else {
      while(var_00 > 0) {
        var_12 = var_00 & 0 - var_00;

        if(randomfloat(1.0) > func_3C3B(var_12) * var_03)
          var_04 = var_04 | var_12;

        var_00 = var_00 - var_12;
      }
    }
  } else if(var_02 >= 1 || isDefined(func_2C18(var_01 | var_00))) {
    var_13 = func_3C3B(var_00) * var_03;
    var_14 = randomfloat(1.0);

    if(var_14 > var_13)
      var_04 = var_00;
  }

  return var_04;
}

func_2C18(var_00) {
  switch (var_00) {
    case 1:
      return "zombie_missing_right_arm_animclass";
    case 2:
      return "zombie_missing_left_arm_animclass";
    case 4:
      return "zombie_missing_right_leg_animclass";
    case 8:
      return "zombie_missing_left_leg_animclass";
    case 12:
      return "zombie_crawl_animclass";
    case 0:
      return "zombie_asm_animclass";
    default:
      return undefined;
  }
}

func_3C3B(var_00) {
  if(isDefined(level.func_719A))
    return self[[level.func_719A]](var_00);

  if(isDefined(self.func_8BCC) && var_00 != 16)
    return 1;

  switch (var_00) {
    case 1:
      return 0.45;
    case 2:
      return 0.45;
    case 4:
      return 0.5;
    case 8:
      return 0.5;
    case 16:
      if(isDefined(self.func_8BFE))
        return 1;

      return 0.65;
    default:
      return 1;
  }
}

func_BDFB(var_00, var_01, var_02, var_03, var_04) {
  var_05 = 0;
  var_06 = 0;

  if(isDefined(var_01))
    var_06 = scripts\engine\utility::is_true(level.func_8EE6[var_01]);

  if(var_00 != self.func_B8BA) {
    var_07 = ~self.func_B8BA & var_00;

    if(scripts\cp\utility::is_codxp()) {
      if(!scripts\engine\utility::is_true(self.entered_playspace))
        return 0;
    }

    self.func_B8BA = var_00;
    var_08 = self.spawntime < gettime();

    if(func_46BA(var_07) >= 3) {
      if(var_08)
        self.func_DDC8 = var_07;

      var_08 = 0;
      self.full_gib = 1;
      self.nocorpse = 1;
      self.deathmethod = "mutilate";
    }

    if((var_07 & 1) != 0)
      func_5394(1);

    if((var_07 & 2) != 0)
      func_5394(2);

    if((var_07 & 4) != 0)
      func_5394(4);

    if((var_07 & 8) != 0)
      func_5394(8);

    if((var_07 & 16) != 0)
      func_5394(16);

    var_09 = func_2C18(var_00);

    if(isDefined(var_09)) {
      if(self.dismember_crawl)
        var_08 = 0;

      if(!self.dismember_crawl && (var_00 & 12) != 0)
        thread func_10D81();

      if(var_08) {
        if(var_02 < 1)
          func_0C72::func_F6C8(var_00, var_06);
        else
          var_05 = 1;
      }
    } else
      var_05 = 1;

    if(var_05 && var_08)
      self.func_DDC8 = var_07;
  }

  return var_05;
}

func_46BA(var_00) {
  for(var_01 = 0; var_00 > 0; var_00 = var_00 - (var_00 & 0 - var_00))
    var_1++;

  return var_01;
}

func_5394(var_00) {
  if(isDefined(level.dismember_queue_func))
    [[level.dismember_queue_func]](var_00);

  level notify("dismember", self, var_00);

  switch (var_00) {
    case 1:
      self setscriptablepartstate("right_arm", "detached", 1);
      break;
    case 4:
      self setscriptablepartstate("right_leg", "detached", 1);
      break;
    case 2:
      self setscriptablepartstate("left_arm", "detached", 1);
      break;
    case 8:
      self setscriptablepartstate("left_leg", "detached", 1);
      break;
    case 16:
      playLoopSound(self gettagorigin("j_neck"), "zombie_dismember_head");
      self setscriptablepartstate("head", "detached", 1);
      break;
  }
}

func_6A58() {
  self endon("death");

  if(dying_zapper_death()) {
    return;
  }
  if(isDefined(level.func_C01F)) {
    return;
  }
  self setscriptablepartstate("eyes", "eye_glow_off");
  wait 0.1;

  if(scripts\asm\zombie\zombie::func_9F87()) {
    self setscriptablepartstate("right_eye", "active");
    self setscriptablepartstate("left_eye", "active");
  } else if(scripts\engine\utility::is_true(self.is_turned))
    self setscriptablepartstate("eyes", "turned_eyes");
  else if(scripts\engine\utility::is_true(self.is_cop))
    self setscriptablepartstate("eyes", "cop_eyes");
  else
    self setscriptablepartstate("eyes", "yellow_eyes");
}

func_7F75(var_00, var_01, var_02) {
  if(isDefined(level.func_566C[var_01])) {
    var_03 = level.func_566C[var_01][var_02];

    if(isDefined(var_03))
      return var_03;
  }

  var_03 = level.func_566C[var_00][var_02];
  return var_03;
}

func_7F74(var_00, var_01) {
  var_02 = 40;

  switch (var_00) {
    case 2:
    case 1:
      return self.origin + (0, 0, var_02);
    case 8:
    case 4:
      var_03 = self gettagorigin(var_01);
      return (self.origin[0], self.origin[1], var_3[2]);
    case 16:
      return self gettagorigin(var_01);
  }
}

func_CCDB(var_00) {
  scripts\engine\utility::waitframe();

  if(self.health > 0)
    self playsoundonmovingent(var_00);
  else
    self playSound(var_00);
}

func_BDF8() {
  func_BDFB(12);
}

func_10D81() {
  self.func_2CA7 = undefined;
  self.dismember_crawl = 1;
  thread func_F34B();
  self _meth_828D(15);
  level.func_4878++;
  self waittill("death");
  level.func_4878--;
}

func_F34B() {
  self endon("death");
  wait 0.5;
  self.is_crawler = 1;
}

func_C4E3(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  foreach(var_11 in level.func_BDFA) {
    if(isDefined(var_11[4]))
      self[[var_11[4]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  }
}

func_BC5C() {
  level.func_13F3F = ["slow_walk", "walk", "run", "sprint"];

  if(!isDefined(level.func_BCE6)) {
    level.func_BCE6["slow_walk"][0] = 1;
    level.func_BCE6["slow_walk"][1] = 1;
    level.func_BCE6["walk"][0] = 1;
    level.func_BCE6["walk"][1] = 1;
    level.func_BCE6["run"][0] = 1;
    level.func_BCE6["run"][1] = 1;
    level.func_BCE6["sprint"][0] = 1.0;
    level.func_BCE6["sprint"][1] = 1.0;
  }

  if(!isDefined(level.func_C083)) {
    level.func_C083["slow_walk"] = 1.0;
    level.func_C083["walk"] = 1.0;
    level.func_C083["run"] = 1.0;
    level.func_C083["sprint"] = 1.0;
  }

  if(!isDefined(level.func_126EA)) {
    level.func_126EA[0] = 1.0;
    level.func_126EA[1] = 1.0;
  }

  if(!isDefined(level.func_13FA8)) {
    level.func_13FA8["slow_walk"] = 20;
    level.func_13FA8["walk"] = 20;
    level.func_13FA8["run"] = 24;
    level.func_13FA8["sprint"] = 32;
  }
}

func_13F55() {
  self endon("death");

  if(isDefined(level.func_13BDD))
    var_00 = level.func_13BDD;
  else
    var_00 = 7;

  if(!isDefined(level.wave_num))
    level.wave_num = 1;

  scripts\engine\utility::waitframe();
  self.speed_adjusted = undefined;
  self.speedup = undefined;
  thread speed_up_every_now_and_then();
  self.movemode = calulatezombiemovemode(var_00);
  var_01 = "";

  for(;;) {
    if(scripts\anim\notetracks_mp::isstatelocked() || self.aistate == "traverse") {
      wait 0.05;
      continue;
    }

    if(isDefined(self.isfrozen)) {
      wait 0.05;
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::iscrawling())
      self.moveratescale = 0.85;

    if(isDefined(level.movemodefunc[self.agent_type])) {
      var_02 = [
        [level.movemodefunc[self.agent_type]]
      ](var_00);

      if(isDefined(var_02))
        self.movemode = var_02;
    }

    if(var_01 != self.movemode) {
      var_01 = self.movemode;
      self.sharpturnnotifydist = level.func_13FA8[self.movemode];

      if(isDefined(level.func_BCE5[self.agent_type]))
        self.moveratescale = [
          [level.func_BCE5[self.agent_type]]
        ]();
      else
        self.moveratescale = 1;

      if(isDefined(level.func_C082[self.agent_type]))
        self.func_C081 = [
          [level.func_C082[self.agent_type]]
        ]();
      else
        self.func_C081 = 1;

      if(isDefined(level.func_126E9[self.agent_type]))
        self.traverseratescale = [
          [level.func_126E9[self.agent_type]]
        ]();
      else
        self.traverseratescale = 1;

      self.generalspeedratescale = self.traverseratescale;

      if(scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        self.sharpturnnotifydist = 100;
        self.moveratescale = 0.85;
      }

      scripts\asm\asm_bb::bb_requestmovetype(self.movemode);
    }

    if(self.movemode == "sprint") {
      if(scripts\engine\utility::is_true(self.speedup)) {
        if(!isDefined(self.speed_adjusted)) {
          self.speed_adjusted = 1;
          self.moveratescale = 1.15;
        }
      } else if(isDefined(self.speedup)) {
        if(isDefined(level.func_BCE5[self.agent_type]))
          self.moveratescale = [
            [level.func_BCE5[self.agent_type]]
          ]();
        else
          self.moveratescale = 1;

        self.speed_adjusted = undefined;
        self.speedup = undefined;
      }
    }

    scripts\engine\utility::waittill_any_timeout(1.0, "speed_debuffs_changed");
  }
}

speed_up_every_now_and_then() {
  self endon("death");

  for(;;) {
    if(!isDefined(self.speedup)) {
      if(randomint(100) < 25) {
        self.speedup = 1;
        wait 5;
        self.speedup = 0;
      }
    }

    wait 5;
  }
}

calulatezombiemovemode(var_00) {
  if(scripts\asm\zombie\zombie::func_9F87())
    return "sprint";

  if(scripts\engine\utility::is_true(self.is_skeleton))
    return "sprint";

  if(isDefined(self.func_BC4B))
    return self.func_BC4B;

  if(level.wave_num == 1)
    return "slow_walk";

  var_01 = level.wave_num * 4;
  var_02 = randomintrange(var_01, var_01 + 35);

  if(var_02 <= 32)
    return "slow_walk";
  else if(var_02 <= 55)
    return "walk";
  else if(var_02 <= 78)
    return "run";
  else
    return "sprint";
}

func_372A(var_00) {
  var_01 = level.func_C083[var_00];
  var_01 = var_01 * func_7E10();
  return var_01;
}

func_372B(var_00) {
  var_01 = level.wave_num - 1;

  if(isDefined(self.func_BCE3))
    var_01 = var_01 + self.func_BCE3;

  var_01 = int(clamp(var_01, 0, level.func_13F3F.size * var_00 - 1));
  return var_01;
}

func_3729(var_00, var_01, var_02) {
  var_03 = func_372B(var_00);
  var_04 = var_03 % var_00;

  if(var_00 < 2)
    var_05 = float(var_04) / 1;
  else
    var_05 = float(var_04) / float(var_00 - 1);

  var_06 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_05, var_01, var_02);

  if(scripts\asm\zombie\zombie::func_9F87())
    var_06 = var_06 * 1.2;

  return var_06;
}

func_372C(var_00, var_01, var_02) {
  var_03 = func_372B(var_00);
  var_04 = var_03 / (level.func_13F3F.size * var_00 - 1.0);
  var_05 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_04, var_01, var_02);
  return var_05;
}

func_7E10() {
  var_00 = 1;

  if(!isDefined(self.bufferedstatwritethink))
    return var_00;

  foreach(var_03, var_02 in self.bufferedstatwritethink) {
    if(!isDefined(var_2.func_109AF)) {
      continue;
    }
    var_00 = var_00 * var_2.func_109AF;
  }

  return var_00;
}

onzombiekilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(scripts\asm\zombie\zombie::func_9F87()) {
    if(isDefined(self.agent_type) && self.agent_type == "skater")
      self playSound("zmb_skater_explode");
    else
      self playSound("zmb_clown_explode");

    if(isDefined(var_01) && isplayer(var_01))
      scripts\common\fx::playfxnophase(level._effect["suicide_zmb_death"], self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
    else {
      scripts\common\fx::playfxnophase(level._effect["suicide_zmb_explode"], self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
      radiusdamage(self.origin + (0, 0, 40), 250, 50, 10, self, "MOD_EXPLOSIVE", "zombie_suicide_bomb");
      earthquake(0.4, 0.5, self.origin, 200);
    }

    scripts\mp\mp_agent::default_on_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
    return;
  }

  if(isDefined(self.vignette_nocorpse)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    self.vignette_nocorpse = undefined;
  }

  func_10926(self.func_1657, var_03, var_04);

  if(isDefined(self.func_6658)) {
    if(isDefined(self.func_BF2F)) {
      var_09 = scripts\cp\zombies\zombie_entrances::func_7872(self.func_6658, self.func_BF2F - 1);

      if(var_09 == "destroying")
        scripts\cp\zombies\zombie_entrances::func_F2E3(self.func_6658, self.func_BF2F - 1, "boarded");

      self.func_BF2F = undefined;
    }

    scripts\cp\zombies\zombie_entrances::func_E005(self.func_6658);
    self.func_6658 = undefined;
  }

  if(isDefined(self.attack_spot)) {
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
    self.attack_spot = undefined;
  }

  scripts\mp\mp_agent::default_on_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
}

func_10926(var_00, var_01, var_02) {
  if(isDefined(self.isfrozen)) {
    self.nocorpse = 1;
    self playSound("forge_freeze_shatter");
    self setscriptablepartstate("frozen", "unfrozen");
    playFX(level._effect["zombie_freeze_shatter"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(!isDefined(self.body) && !scripts\engine\utility::is_true(self.full_gib)) {
    return;
  }
  var_03 = self.func_DDC8;

  if(!isDefined(var_03) && !scripts\engine\utility::is_true(self.full_gib)) {
    return;
  }
  if(self.full_gib || func_46BA(var_03) >= 3) {
    thread func_10840(var_00);
    return;
  }

  while(var_03 > 0) {
    var_04 = var_03 & 0 - var_03;
    thread func_1083F(var_04, var_00);
    var_03 = var_03 - var_04;
  }
}

func_10840(var_00) {
  var_01 = 3;

  if(isDefined(level.splitscreen) && level.splitscreen)
    var_01 = 1;

  var_02 = level.func_74B9 < var_01;

  if(var_02) {
    level.func_74B9++;
    var_03 = scripts\engine\utility::getfx("gib_full_body");
  } else
    var_03 = scripts\engine\utility::getfx("gib_full_body_cheap");

  if(isDefined(var_00)) {
    if(isDefined(var_0["emz"]))
      var_03 = scripts\engine\utility::getfx("gib_full_body_emz");
    else if(isDefined(var_0["exploder"]))
      var_03 = scripts\engine\utility::getfx("gib_full_body_exp");
    else if(isDefined(var_0["fast"]))
      var_03 = scripts\engine\utility::getfx("gib_full_body_ovr");
  }

  if(isDefined(self.gib_fx_override))
    var_03 = scripts\engine\utility::getfx(self.gib_fx_override);

  var_04 = level.func_566C["full"]["fxTagName"];

  if(isDefined(self.body))
    playFXOnTag(var_03, self.body, var_04);
  else
    scripts\common\fx::playfxnophase(var_03, self.origin + (0, 0, 25));

  playLoopSound(self.origin, "zombie_full_body_gib");
  wait 3;

  if(isDefined(self.body))
    stopFXOnTag(var_03, self.body, var_04);

  if(var_02)
    level.func_74B9--;
}

func_C4BD(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_10 = self.func_164D[self.asmname].func_4BC0;
  var_11 = anim.asm[self.asmname].states[var_10];
  var_12 = scripts\mp\mp_agent::should_do_immediate_ragdoll(self);

  if(isDefined(self.nocorpse))
    var_12 = 0;

  var_13 = isDefined(self.ragdollimpactvector);

  if(scripts\asm\asm_mp::func_2382(self.asmname, var_11)) {
    if(!var_12 || !scripts\engine\utility::is_true(self.is_traversing))
      scripts\asm\asm::func_231E(self.asmname, var_11, var_10);
  }

  if(isDefined(self.nocorpse)) {
    if(scripts\cp\utility::is_melee_weapon(var_04)) {
      var_14 = self cloneagent(var_08, 1);
      var_14 hide(1);
    }

    return;
  }

  var_15 = self;

  if(isDefined(self.has_backpack) && isDefined(level.should_drop_pillage)) {
    if([
        [level.should_drop_pillage]
      ](var_01, self.origin))
      self setscriptablepartstate("backpack", "hide", 1);
  }

  if(isDefined(self.ragdollhitloc)) {
    self.body = self cloneagent(var_08, var_12);
    self.body.ragdollhitloc = self.ragdollhitloc;
    self.body.ragdollimpactvector = self.ragdollimpactvector;
  } else
    self.body = self cloneagent(var_08, var_12);

  if(isDefined(self.is_burning) || isDefined(var_01) && isDefined(var_04) && var_04 == "incendiary_ammo_mp")
    self.body setscriptablepartstate("burning", "active", 1);
  else if(isDefined(self.func_10A57))
    self.body setscriptablepartstate("spoon", "active", 1);
  else if(isDefined(self.electrocuted))
    self.body setscriptablepartstate("electrocuted", "active");

  if(isDefined(self.func_CE65))
    self.body thread func_5774(self.func_CE65, scripts\engine\utility::is_true(self.is_traversing));

  if(scripts\engine\utility::is_true(var_12))
    scripts\mp\mp_agent::do_immediate_ragdoll(self.body);
  else if(scripts\engine\utility::is_true(var_13))
    thread velocityragdoll(self.body, var_06, var_05, var_04, var_00, var_03);
  else if(!scripts\engine\utility::is_true(self.death_anim_no_ragdoll))
    thread scripts\mp\mp_agent::delaystartragdoll(self.body, var_06, var_05, var_04, var_00, var_03);

  self.death_anim_no_ragdoll = undefined;
}

velocityragdoll(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_07 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_7.origin) < 65536)
        return;
    }
  }

  if(!isDefined(var_00)) {
    return;
  }
  if(var_00 _meth_81B7()) {
    return;
  }
  if(isDefined(var_00)) {
    if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector))
      var_00 giverankxp_regularmp(var_0.ragdollhitloc, var_0.ragdollimpactvector);
    else
      var_00 startragdoll();
  }
}

func_5774(var_00, var_01) {
  if(!scripts\engine\utility::is_true(var_01))
    wait(var_00);

  if(isDefined(self)) {
    self setscriptablepartstate("death_fx", "active", 1);
    wait 0.1;
    self hide(1);
  }
}

func_1083F(var_00, var_01) {
  var_02 = level.func_566C[var_00]["torsoFX"];

  if(isDefined(var_01)) {
    if(isDefined(var_1["emz"]))
      var_02 = var_02 + "_emz";
    else if(isDefined(var_1["exploder"]))
      var_02 = var_02 + "_exp";
    else if(isDefined(var_1["fast"]))
      var_02 = var_02 + "_ovr";
  }

  playFXOnTag(scripts\engine\utility::getfx(var_02), self.body, level.func_566C[var_00]["fxTagName"]);
  wait 10;

  if(isDefined(self.body))
    stopFXOnTag(scripts\engine\utility::getfx(var_02), self.body, level.func_566C[var_00]["fxTagName"]);
}

func_B9B9() {
  self endon("death");
  level endon("game_ended");
  var_00 = gettime();
  var_01 = self.origin;
  var_02 = var_00;
  var_03 = 0;
  var_04 = 5.0;

  for(;;) {
    wait(var_04);
    var_05 = distancesquared(self.origin, var_01);
    var_06 = (gettime() - var_02) / 1000;
    var_07 = var_05 > 16384;
    var_08 = scripts\engine\utility::is_true(self.var_1198.func_2BDE);

    if(var_07 || var_08) {
      var_01 = self.origin;
      var_02 = gettime();
    } else if(var_06 > 35) {
      if(var_06 > 55) {
        var_03 = 1;
        break;
      }
    }

    if(func_3E0A(var_00, 180, 240)) {
      break;
    }
  }

  if(var_03 && shouldreacttolight())
    thread func_DE06(self.agent_type);

  killagent(self);
}

func_BA27() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;

  for(;;) {
    if(length(self getvelocity()) == 0 && self.aistate == "move")
      var_00 = var_00 + 0.05;
    else
      var_00 = 0;

    if(var_00 > 2.0) {
      var_01 = self getspectatepoint();

      if(isDefined(var_01)) {
        var_02 = distancesquared(self.origin, var_1.origin);

        if(var_02 < squared(15))
          self setorigin(var_1.origin, 0);
      }
    }

    wait 0.05;
  }
}

func_3E0A(var_00, var_01, var_02) {
  if(isDefined(self.func_932A) && self.func_932A)
    return 0;

  var_03 = (gettime() - var_00) / 1000;

  if(var_03 > var_01) {
    if(var_03 > var_02)
      return 1;
  }

  return 0;
}

shouldreacttolight() {
  if(!isDefined(level.func_1CB5))
    return 0;

  return allowjump() > 1;
}

allowjump() {
  var_00 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  var_01 = 0;

  foreach(var_03 in var_00) {
    if(var_3.team == level.func_6575)
      var_1++;
  }

  return var_01;
}

func_DE06(var_00) {
  if(!isDefined(level.func_DE07))
    level.func_DE07 = 0;

  level.func_DE07++;

  while(scripts\mp\mp_agent::getnumactiveagents() >= level.func_B497 || isDefined(level.func_DE08))
    scripts\engine\utility::waitframe();

  level.func_DE08 = 1;
  wait 0.2;
  level.func_DE08 = undefined;
  level.func_DE07--;

  if(level.func_DE07 < 0)
    level.func_DE07 = 0;
}

func_A012() {
  if(!isDefined(level.func_13F60))
    return 0;

  return level.func_13F60;
}

killagent(var_00) {
  var_00 getrandomarmkillstreak(var_0.health + 500000, var_0.origin);
}

func_13F9F(var_00, var_01) {
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

func_13FA0() {
  self endon("death");
  level endon("game_ended");
  self endon("traverse_end");

  for(;;) {
    func_13F9F(3600, 100);
    scripts\engine\utility::waitframe();
  }
}

func_13F99() {
  self endon("death");
  self endon("game_ended");

  for(;;) {
    self waittill("traverse_begin");
    func_13FA0();
  }
}