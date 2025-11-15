/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie\zmb_zombie_agent.gsc
*********************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  lib_03B2::func_DEE8();
  lib_0F44::func_2371();
  level.var_13BDC = 1;
  level.var_4878 = 0;
  level.var_BF7C = 0;
  level.movemodefunc = [];
  level.var_BCE5 = [];
  level.var_C082 = [];
  level.var_126E9 = [];
  level.var_8EE6 = [];
  level.var_5662 = [];
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
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

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
  self.precacheleaderboards = 0;
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
  self.synctransients = "walk";
  self.sharpturnnotifydist = 100;
  self.fgetarg = 15;
  self.height = 40;
  self.var_252B = 26 + self.fgetarg;
  self.var_B640 = "normal";
  self.var_B641 = 50;
  self.var_2539 = 54;
  self.var_253A = -64;
  self.var_4D45 = 2250000;
  self.precacheminimapicon = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1;
  self.var_C081 = 1;
  self.traverseratescale = 1;
  self.generalspeedratescale = 1;
  self.var_2AB2 = 0;
  self.var_2AB8 = 1;
  self.timelineevents = 0;
  self.var_2F = 1;
  self.var_B5F9 = 40;
  self.var_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.defaultgoalradius = self.fgetarg + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.is_crawler = 0;
  self.died_poorly = 0;
  self.damaged_by_player = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.var_B0FC = 1;
  self.full_gib = 0;
  scripts\mp\agents\zombie\zombie_util::func_F794(self.var_B62E);
  self.loadstartpointtransients = undefined;
  self.var_E821 = undefined;
  self.last_damage_time_on_player = [];
  self.var_8C12 = 0;
  self.hasplayedvignetteanim = undefined;
  self.is_cop = undefined;
  self.pointonsegmentnearesttopoint = 200;
  self.deathmethod = undefined;
  self.var_10A57 = undefined;
  self.gib_fx_override = undefined;
  self.var_CE65 = undefined;
  self.var_29D2 = 1;
  self.vignette_nocorpse = undefined;
  self.death_anim_no_ragdoll = undefined;
  self.var_B603 = 0.85;
  self.var_A9B8 = gettime();
  self.var_9342 = undefined;
  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }

  var_00 = 15;
  if(isDefined(level.avoidance_radius)) {
    var_00 = level.avoidance_radius;
  }

  self setavoidanceradius(var_00);
  thread func_13F55();
  thread func_BA27();
  thread func_899C();
  var_01 = getdvarint("scr_zombie_traversal_push", 1);
  if(var_01 == 1) {
    thread func_13F99();
  }
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  foreach(var_04, var_01 in self.var_164D) {
    var_02 = var_01.var_4BC0;
    var_03 = level.asm[var_04].states[var_02];
    scripts\asm\asm::func_2388(var_04, var_02, var_03, var_03.var_116FB);
    scripts\asm\asm::func_238A(var_04, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(param_00) {
  self setModel(func_79E5());
  thread func_50EF();
}

func_79E5() {
  var_00 = "zombie_male_outfit_1";
  var_01 = undefined;
  if(isDefined(level.generic_zombie_model_override_list)) {
    var_01 = scripts\engine\utility::random(level.generic_zombie_model_override_list);
  } else if(isDefined(level.generic_zombie_model_list)) {
    var_01 = scripts\engine\utility::random(level.generic_zombie_model_list);
  } else {
    var_01 = var_00;
  }

  return var_01;
}

dying_zapper_death() {
  return scripts\engine\utility::istrue(self.rocket_feet) || scripts\engine\utility::istrue(self.dischord_spin) || scripts\engine\utility::istrue(self.head_is_exploding) || scripts\engine\utility::istrue(self.shredder_death);
}

func_50EF() {
  self endon("death");
  wait(0.5);
  if(dying_zapper_death()) {
    return;
  }

  if(isDefined(level.var_C01F)) {
    return;
  }

  if(scripts\asm\zombie\zombie::func_9F87()) {
    self setscriptablepartstate("right_eye", "active");
    self setscriptablepartstate("left_eye", "active");
    return;
  }

  if(scripts\engine\utility::istrue(self.is_turned)) {
    self setscriptablepartstate("eyes", "turned_eyes");
    return;
  }

  if(scripts\engine\utility::istrue(self.is_cop)) {
    self getrandomhovernodesaroundtargetpos(1, 0.1);
    self setscriptablepartstate("eyes", "cop_eyes");
    return;
  }

  self getrandomhovernodesaroundtargetpos(1, 0.1);
}

func_13FAF() {
  return isDefined(self.var_117F7);
}

agent_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(param_00) || isDefined(param_01)) {
    if(!isDefined(param_00)) {
      param_00 = param_01;
    }

    if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
      if(isDefined(param_00.classname) && param_00.classname == "script_vehicle") {
        return 0;
      }
    }

    if(isDefined(param_00.classname) && param_00.classname == "auto_turret") {
      param_01 = param_00;
    }

    if(isDefined(param_01) && param_04 != "MOD_FALLING" && param_04 != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(param_01.team) && param_01.team != self.team) {
          self give_ammo(param_01);
        }
      } else {
        self give_ammo(param_01);
      }
    }
  }

  scripts\mp\mp_agent::default_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
  return 1;
}

func_9F01() {
  if(isDefined(self.inplayerscrambler) && self.inplayerscrambler) {
    return 1;
  }

  if(isDefined(self.inplayerportableradar) && self.inplayerportableradar) {
    return 1;
  }

  return 0;
}

func_12EE6() {
  self notify("updatePainSensor");
  self endon("updatePainSensor");
  self endon("death");
  self.var_C87E = spawnStruct();
  self.var_C87E.var_A9C8 = gettime();
  self.var_C87E.var_DA = 0;
  var_00 = 0.05;
  var_01 = 5 * var_00;
  for(;;) {
    wait(var_00);
    if(gettime() > self.var_C87E.var_A9C8 + 2000) {
      self.var_C87E.var_DA = self.var_C87E.var_DA - var_01;
    }

    self.var_C87E.var_DA = max(self.var_C87E.var_DA, 0);
    if(func_9F01()) {
      self.var_C87E.var_DA = 0;
    }
  }
}

func_389D() {
  if(gettime() - self.spawntime <= 0.05) {
    return 0;
  }

  return 1;
}

func_13F9C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");
  while(isDefined(self) && isalive(self)) {
    self.pendingdeath = 1;
    if(!func_389D()) {
      wait(0.05);
      continue;
    }

    self.pendingdeath = 0;
    onzombiedamagefinished(param_00, param_01, self.health + 1, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }
}

func_C4E4(param_00, param_01, param_02) {
  if(isDefined(self.var_C4E5)) {
    [[self.var_C4E5]](param_00, param_01, param_02);
  }

  if(isDefined(param_02) && param_02 == "dna_aoe_grenade_zombie_mp" || param_02 == "trap_zm_mp") {
    return;
  }

  self.var_C87E.var_A9C8 = gettime();
  self.var_C87E.var_DA = self.var_C87E.var_DA + param_00;
}

ispendingdeath(param_00) {
  return isDefined(self.pendingdeath) && self.pendingdeath;
}

func_9DC4() {
  return 0;
}

func_9FB2() {
  return 0;
}

isonhumanteam(param_00) {
  if(isDefined(param_00.team)) {
    return param_00.team == level.playerteam;
  }

  return 0;
}

onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  var_0D = self.health;
  var_0E = 0;
  var_0F = !func_13FAF() && param_04 != "MOD_FALLING" && param_05 != "repulsor_zombie_mp" && param_05 != "zombie_water_trap_mp";
  if(var_0F && scripts\engine\utility::istrue(self.died_poorly)) {
    var_0F = 0;
  }

  if(dying_zapper_death()) {
    var_0F = 0;
  }

  if(scripts\engine\utility::istrue(self.is_dancing)) {
    var_0F = 0;
  }

  if(var_0F && isDefined(level.mutilation_perk_func)) {
    var_0F = [[level.mutilation_perk_func]](var_0F, param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
  }

  if(self.health > 0) {
    var_10 = clamp(param_02 / self.health, 0, 1);
  } else {
    var_10 = 1;
  }

  if(var_0F) {
    var_0E = func_128A7(param_08, param_05, param_04, var_10, param_01, param_07, param_04, param_00);
    if(var_0E && isDefined(param_01)) {
      param_02 = self.health + 1;
    }
  }

  if(isDefined(param_01) && isplayer(param_01) && !isDefined(self.loadstartpointtransients)) {
    var_11 = isDefined(self.curmeleetarget) && self.curmeleetarget == param_01;
    var_12 = isDefined(self.curmeleetarget) && !isplayer(self.curmeleetarget);
    if(var_11 || var_12) {
      if(distancesquared(self.origin, param_01.origin) <= self.var_4D45) {
        scripts\mp\agents\zombie\zombie_util::func_F702(param_01);
        thread func_E1EB(0.2);
      }
    }
  }

  thread func_C4E3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  if(!func_389D() && self.health - param_02 <= 0) {
    thread func_13F9C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0B, param_0C);
    param_02 = int(max(0, self.health - 1));
  }

  func_C4E4(param_02, param_04, param_05);
  level notify("zombie_damaged", self, param_01);
  if(self.agent_type != "skater") {
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "pain", 0);
  }

  agent_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0B, param_0C);
  if(isalive(self)) {
    if(var_0E && !ispendingdeath()) {
      self suicide();
      return;
    }

    func_12ECD();
  }
}

func_E1EB(param_00) {
  self endon("death");
  wait(param_00);
  self.loadstartpointtransients = undefined;
}

func_12ECD() {}

func_9890() {
  level.var_1C7F = 1;
  level.var_4BEE = 0;
  level.var_C4BD = ::func_C4BD;
}

func_98A5() {
  level.var_BDFA = [];
  func_97F2();
}

func_97F2() {
  func_17F1("crawl", ::func_BDF8);
}

func_17F1(param_00, param_01, param_02, param_03, param_04) {
  level.var_BDFA[param_00] = [];
  level.var_BDFA[param_00][0] = param_01;
  level.var_BDFA[param_00][2] = param_02;
  level.var_BDFA[param_00][3] = param_03;
  level.var_BDFA[param_00][4] = param_04;
}

func_97FB() {
  level.var_566C[1]["tagName"] = "J_Shoulder_RI";
  level.var_566C[2]["tagName"] = "J_Shoulder_LE";
  level.var_566C[4]["tagName"] = "J_Hip_RI";
  level.var_566C[8]["tagName"] = "J_Hip_LE";
  level.var_566C[16]["tagName"] = "J_Head";
  level.var_566C[1]["torsoFX"] = "torso_arm_loss_right";
  level.var_566C[2]["torsoFX"] = "torso_arm_loss_left";
  level.var_566C[4]["torsoFX"] = "torso_loss_right";
  level.var_566C[8]["torsoFX"] = "torso_loss_left";
  level.var_566C[16]["torsoFX"] = "torso_head_loss";
  level.var_566C[1]["fxTagName"] = "J_Shoulder_RI";
  level.var_566C[2]["fxTagName"] = "J_Shoulder_LE";
  level.var_566C[4]["fxTagName"] = "J_Hip_RI";
  level.var_566C[8]["fxTagName"] = "J_Hip_LE";
  level.var_566C[16]["fxTagName"] = "j_neck";
  level.var_566C["full"]["fxTagName"] = "J_MainRoot";
  level.var_566C[1]["limbFX"] = "arm_loss_right";
  level.var_566C[2]["limbFX"] = "arm_loss_left";
  level.var_566C[4]["limbFX"] = "limb_loss_right";
  level.var_566C[8]["limbFX"] = "limb_loss_left";
  level.var_566C[16]["limbFX"] = "head_loss";
  level.var_74B9 = 0;
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

func_3DE4(param_00) {
  return isDefined(self.var_1657) && isDefined(self.var_1657[param_00]);
}

func_128A7(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = 0;
  if(!func_FF69(self)) {
    return 0;
  }

  if(weaponisimpaling(param_01)) {
    return 0;
  }

  if(isalive(self) && !scripts\mp\agents\_scriptedagents::isstatelocked() || param_03 >= 1 && !func_9FB2()) {
    if(!isDefined(self.var_B8BA)) {
      self.var_B8BA = 0;
    }

    var_09 = func_7FD6(param_00, param_01, param_02, param_03, param_04, self.var_B8BA, param_07);
    if(var_09 != 0) {
      var_0A = !scripts\engine\utility::istrue(self.dismember_crawl);
      var_0B = isDefined(self.var_B8BA) && self.var_B8BA == 0;
      if(level.var_4878 < 8 || scripts\engine\utility::istrue(self.dismember_crawl) || var_09 & 12 == 0 || var_09 & 16 != 0 || self.var_B8BA & 3 != 0) {
        if(func_BDFB(self.var_B8BA | var_09, param_01, param_03, param_05, param_06)) {
          if(func_9E51()) {
            earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          }

          var_08 = 1;
        } else if(!isDefined(self.var_ACDB) && var_09 != 0 && func_3DE4("exploder") || func_9E51() && func_3DE4("emz") || func_3DE4("fast")) {
          earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          var_08 = 1;
        }
      }
    }
  }

  return var_08;
}

func_FF69(param_00) {
  if(scripts\engine\utility::istrue(self.is_traversing)) {
    return 0;
  }

  if(isDefined(self.linked_to_boat)) {
    return 0;
  }

  if(isDefined(self.dontmutilate)) {
    return 0;
  }

  if(isDefined(param_00.isfrozen)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.is_suicide_bomber)) {
    return 0;
  }

  if(param_00.agent_type == "zombie_cop") {
    return 0;
  }

  if(param_00.agent_type == "zombie_brute") {
    return 0;
  }

  if(isDefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim) {
    return 0;
  }

  if(isDefined(level.traversal_dismember_check)) {
    return [[level.traversal_dismember_check]](param_00);
  }

  return 1;
}

func_7FD6(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(param_03 >= 1) {
    if(func_3DE4("exploder")) {
      return 31;
    }
  }

  var_07 = func_9E51();
  if(var_07) {
    var_08 = 31;
  } else {
    var_08 = func_AED2(param_01);
  }

  var_09 = 1;
  if(isDefined(level.mutilation_mask_override_func)) {
    var_0A = [[level.mutilation_mask_override_func]](var_08, param_01, param_02, param_03, param_04, param_05, param_06);
    if(isDefined(var_0A)) {
      var_08 = var_0A;
    }
  }

  if(var_08 == 0) {
    return 0;
  }

  var_09 = var_09 * func_7E78(param_04, param_01, undefined) * func_7E78(param_04, undefined, param_02);
  var_09 = var_09 * -0.7 * param_03 + 1;
  return func_7FD7(var_08, param_05, param_03, var_09);
}

func_C819(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  return 0;
}

func_9E51() {
  var_00 = scripts\engine\utility::flag_exist("insta_kill") && scripts\engine\utility::flag("insta_kill");
  return var_00;
}

func_AED2(param_00) {
  switch (param_00) {
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

    case "helmet":
    case "neck":
    case "head":
      return 16;

    default:
      return 0;
  }
}

iskillstreakweapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  if(scripts\engine\utility::isdestructibleweapon(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "killstreak")) {
    return 1;
  }

  if(issubstr(param_00, "remote_tank_projectile")) {
    return 1;
  }

  if(issubstr(param_00, "minijackal_")) {
    return 1;
  }

  if(isDefined(level.killstreakweildweapons) && isDefined(level.killstreakweildweapons[param_00])) {
    return 1;
  }

  if(scripts\engine\utility::isairdropmarker(param_00)) {
    return 1;
  }

  var_01 = weaponinventorytype(param_00);
  if(isDefined(var_01) && var_01 == "exclusive") {
    return 1;
  }

  return 0;
}

func_7E78(param_00, param_01, param_02) {
  if(func_9E51()) {
    return 0;
  }

  var_03 = undefined;
  if(isDefined(param_01)) {
    param_01 = getweaponbasename(param_01);
    var_03 = param_01;
  } else if(isDefined(param_02)) {
    var_03 = param_02;
  }

  if(!isDefined(var_03)) {
    return 1;
  }

  if(isDefined(level.var_566F) && isDefined(level.var_566F[var_03])) {
    return level.var_566F[var_03];
  }

  var_04 = 1;
  if(isDefined(param_00) && isplayer(param_00) && isDefined(param_01) && isDefined(var_04) && !iskillstreakweapon(param_01)) {
    var_04 = func_3E61(param_00, param_01, var_04);
    return var_04;
  }

  if(isDefined(var_04)) {
    return var_04;
  }

  return 1;
}

func_3E61(param_00, param_01, param_02) {
  var_03 = 1;
  if(!isDefined(var_03)) {
    return param_02;
  }

  var_04 = _meth_8254(param_00, param_01);
  if(var_04 <= 1) {
    return param_02;
  }

  var_05 = param_02 - var_03;
  var_06 = param_02 - var_04 / 3 * var_05;
  return clamp(var_06, var_03, param_02);
}

_meth_8254(param_00, param_01) {
  var_02 = getweaponbasename(param_01);
  if(!func_8C3E(param_00, var_02)) {
    return 0;
  }

  return param_00.weaponstate[var_02]["level"];
}

func_8C3E(param_00, param_01) {
  return isDefined(param_01) && isDefined(param_00.weaponstate) && isDefined(param_00.weaponstate[param_01]);
}

func_7FD7(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  var_05 = param_00 & param_00 - 1;
  if(var_05 > 0) {
    if(param_02 < 1) {
      var_06 = randomint(24);
      var_07 = 228;
      for(var_08 = 4; var_08 > 0; var_08--) {
        var_09 = 1 << var_06 % var_08 * 2;
        var_06 = int(var_06 / var_08);
        var_0A = var_07 % var_09;
        var_0B = int(var_07 / var_09);
        var_07 = var_0A + var_0B >> 2 * var_09;
        var_0C = 1 << var_0B & 3;
        if(param_00 & var_0C != 0 && isDefined(func_2C18(param_01 | var_04 | var_0C))) {
          if(randomfloat(1) > func_3C3B(var_0C) * param_03) {
            var_04 = var_04 | var_0C;
          }
        }
      }
    } else {
      while(param_00 > 0) {
        var_0C = param_00 & 0 - param_00;
        if(randomfloat(1) > func_3C3B(var_0C) * param_03) {
          var_04 = var_04 | var_0C;
        }

        param_00 = param_00 - var_0C;
      }
    }
  } else if(param_02 >= 1 || isDefined(func_2C18(param_01 | param_00))) {
    var_0D = func_3C3B(param_00) * param_03;
    var_0E = randomfloat(1);
    if(var_0E > var_0D) {
      var_04 = param_00;
    }
  }

  return var_04;
}

func_2C18(param_00) {
  switch (param_00) {
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

func_3C3B(param_00) {
  if(isDefined(level.var_719A)) {
    return self[[level.var_719A]](param_00);
  }

  if(isDefined(self.var_8BCC) && param_00 != 16) {
    return 1;
  }

  switch (param_00) {
    case 1:
      return 0.45;

    case 2:
      return 0.45;

    case 4:
      return 0.5;

    case 8:
      return 0.5;

    case 16:
      if(isDefined(self.var_8BFE)) {
        return 1;
      }
      return 0.65;

    default:
      return 1;
  }
}

func_BDFB(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  var_06 = 0;
  if(isDefined(param_01)) {
    var_06 = scripts\engine\utility::istrue(level.var_8EE6[param_01]);
  }

  if(param_00 != self.var_B8BA) {
    var_07 = ~self.var_B8BA & param_00;
    if(scripts\cp\utility::is_codxp()) {
      if(!scripts\engine\utility::istrue(self.entered_playspace)) {
        return 0;
      }
    }

    self.var_B8BA = param_00;
    var_08 = self.spawntime < gettime();
    if(func_46BA(var_07) >= 3) {
      if(var_08) {
        self.var_DDC8 = var_07;
      }

      var_08 = 0;
      self.full_gib = 1;
      self.nocorpse = 1;
      self.deathmethod = "mutilate";
    }

    if(var_07 & 1 != 0) {
      func_5394(1);
    }

    if(var_07 & 2 != 0) {
      func_5394(2);
    }

    if(var_07 & 4 != 0) {
      func_5394(4);
    }

    if(var_07 & 8 != 0) {
      func_5394(8);
    }

    if(var_07 & 16 != 0) {
      func_5394(16);
    }

    var_09 = func_2C18(param_00);
    if(isDefined(var_09)) {
      if(self.dismember_crawl) {
        var_08 = 0;
      }

      if(!self.dismember_crawl && param_00 & 12 != 0) {
        thread func_10D81();
      }

      if(var_08) {
        if(param_02 < 1) {
          lib_0C72::func_F6C8(param_00, var_06);
        } else {
          var_05 = 1;
        }
      }
    } else {
      var_05 = 1;
    }

    if(var_05 && var_08) {
      self.var_DDC8 = var_07;
    }
  }

  return var_05;
}

func_46BA(param_00) {
  var_01 = 0;
  while(param_00 > 0) {
    var_01++;
    param_00 = param_00 - param_00 & 0 - param_00;
  }

  return var_01;
}

func_5394(param_00) {
  if(isDefined(level.dismember_queue_func)) {
    [[level.dismember_queue_func]](param_00);
  }

  level notify("dismember", self, param_00);
  switch (param_00) {
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
      playsoundatpos(self gettagorigin("j_neck"), "zombie_dismember_head");
      self setscriptablepartstate("head", "detached", 1);
      break;
  }
}

func_6A58() {
  self endon("death");
  if(dying_zapper_death()) {
    return;
  }

  if(isDefined(level.var_C01F)) {
    return;
  }

  self setscriptablepartstate("eyes", "eye_glow_off");
  wait(0.1);
  if(scripts\asm\zombie\zombie::func_9F87()) {
    self setscriptablepartstate("right_eye", "active");
    self setscriptablepartstate("left_eye", "active");
    return;
  }

  if(scripts\engine\utility::istrue(self.is_turned)) {
    self setscriptablepartstate("eyes", "turned_eyes");
    return;
  }

  if(scripts\engine\utility::istrue(self.is_cop)) {
    self setscriptablepartstate("eyes", "cop_eyes");
    return;
  }

  self setscriptablepartstate("eyes", "yellow_eyes");
}

func_7F75(param_00, param_01, param_02) {
  if(isDefined(level.var_566C[param_01])) {
    var_03 = level.var_566C[param_01][param_02];
    if(isDefined(var_03)) {
      return var_03;
    }
  }

  var_03 = level.var_566C[param_00][param_02];
  return var_03;
}

func_7F74(param_00, param_01) {
  var_02 = 40;
  switch (param_00) {
    case 2:
    case 1:
      return self.origin + (0, 0, var_02);

    case 8:
    case 4:
      var_03 = self gettagorigin(param_01);
      return (self.origin[0], self.origin[1], var_03[2]);

    case 16:
      return self gettagorigin(var_02);
  }
}

func_CCDB(param_00) {
  scripts\engine\utility::waitframe();
  if(self.health > 0) {
    self playsoundonmovingent(param_00);
    return;
  }

  self playSound(param_00);
}

func_BDF8() {
  func_BDFB(12);
}

func_10D81() {
  self.var_2CA7 = undefined;
  self.dismember_crawl = 1;
  thread func_F34B();
  self _meth_828D(15);
  level.var_4878++;
  self waittill("death");
  level.var_4878--;
}

func_F34B() {
  self endon("death");
  wait(0.5);
  self.is_crawler = 1;
}

func_C4E3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  foreach(var_0B in level.var_BDFA) {
    if(isDefined(var_0B[4])) {
      self[[var_0B[4]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    }
  }
}

func_BC5C() {
  level.var_13F3F = ["slow_walk", "walk", "run", "sprint"];
  if(!isDefined(level.var_BCE6)) {
    level.var_BCE6["slow_walk"][0] = 1;
    level.var_BCE6["slow_walk"][1] = 1;
    level.var_BCE6["walk"][0] = 1;
    level.var_BCE6["walk"][1] = 1;
    level.var_BCE6["run"][0] = 1;
    level.var_BCE6["run"][1] = 1;
    level.var_BCE6["sprint"][0] = 1;
    level.var_BCE6["sprint"][1] = 1;
  }

  if(!isDefined(level.var_C083)) {
    level.var_C083["slow_walk"] = 1;
    level.var_C083["walk"] = 1;
    level.var_C083["run"] = 1;
    level.var_C083["sprint"] = 1;
  }

  if(!isDefined(level.var_126EA)) {
    level.var_126EA[0] = 1;
    level.var_126EA[1] = 1;
  }

  if(!isDefined(level.var_13FA8)) {
    level.var_13FA8["slow_walk"] = 20;
    level.var_13FA8["walk"] = 20;
    level.var_13FA8["run"] = 24;
    level.var_13FA8["sprint"] = 32;
  }
}

func_13F55() {
  self endon("death");
  if(isDefined(level.var_13BDD)) {
    var_00 = level.var_13BDD;
  } else {
    var_00 = 7;
  }

  if(!isDefined(level.wave_num)) {
    level.wave_num = 1;
  }

  scripts\engine\utility::waitframe();
  self.speed_adjusted = undefined;
  self.speedup = undefined;
  thread speed_up_every_now_and_then();
  self.synctransients = calulatezombiemovemode(var_00);
  var_01 = "";
  for(;;) {
    if(scripts\mp\agents\_scriptedagents::isstatelocked() || self.aistate == "traverse") {
      wait(0.05);
      continue;
    }

    if(isDefined(self.isfrozen)) {
      wait(0.05);
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::iscrawling()) {
      self.moveratescale = 0.85;
    }

    if(isDefined(level.movemodefunc[self.agent_type])) {
      var_02 = [
        [level.movemodefunc[self.agent_type]]
      ](var_00);
      if(isDefined(var_02)) {
        self.synctransients = var_02;
      }
    }

    if(var_01 != self.synctransients) {
      var_01 = self.synctransients;
      self.sharpturnnotifydist = level.var_13FA8[self.synctransients];
      if(isDefined(level.var_BCE5[self.agent_type])) {
        self.moveratescale = [
          [level.var_BCE5[self.agent_type]]
        ]();
      } else {
        self.moveratescale = 1;
      }

      if(isDefined(level.var_C082[self.agent_type])) {
        self.var_C081 = [
          [level.var_C082[self.agent_type]]
        ]();
      } else {
        self.var_C081 = 1;
      }

      if(isDefined(level.var_126E9[self.agent_type])) {
        self.traverseratescale = [
          [level.var_126E9[self.agent_type]]
        ]();
      } else {
        self.traverseratescale = 1;
      }

      self.generalspeedratescale = self.traverseratescale;
      if(scripts\mp\agents\zombie\zombie_util::iscrawling()) {
        self.sharpturnnotifydist = 100;
        self.moveratescale = 0.85;
      }

      scripts\asm\asm_bb::bb_requestmovetype(self.synctransients);
    }

    if(self.synctransients == "sprint") {
      if(scripts\engine\utility::istrue(self.speedup)) {
        if(!isDefined(self.speed_adjusted)) {
          self.speed_adjusted = 1;
          self.moveratescale = 1.15;
        }
      } else if(isDefined(self.speedup)) {
        if(isDefined(level.var_BCE5[self.agent_type])) {
          self.moveratescale = [
            [level.var_BCE5[self.agent_type]]
          ]();
        } else {
          self.moveratescale = 1;
        }

        self.speed_adjusted = undefined;
        self.speedup = undefined;
      }
    }

    scripts\engine\utility::waittill_any_timeout_1(1, "speed_debuffs_changed");
  }
}

speed_up_every_now_and_then() {
  self endon("death");
  for(;;) {
    if(!isDefined(self.speedup)) {
      if(randomint(100) < 25) {
        self.speedup = 1;
        wait(5);
        self.speedup = 0;
      }
    }

    wait(5);
  }
}

calulatezombiemovemode(param_00) {
  if(scripts\asm\zombie\zombie::func_9F87()) {
    return "sprint";
  }

  if(scripts\engine\utility::istrue(self.is_skeleton)) {
    return "sprint";
  }

  if(isDefined(self.var_BC4B)) {
    return self.var_BC4B;
  }

  if(level.wave_num == 1) {
    return "slow_walk";
  }

  var_01 = level.wave_num * 4;
  var_02 = randomintrange(var_01, var_01 + 35);
  if(var_02 <= 32) {
    return "slow_walk";
  }

  if(var_02 <= 55) {
    return "walk";
  }

  if(var_02 <= 78) {
    return "run";
  }

  return "sprint";
}

func_372A(param_00) {
  var_01 = level.var_C083[param_00];
  var_01 = var_01 * func_7E10();
  return var_01;
}

func_372B(param_00) {
  var_01 = level.wave_num - 1;
  if(isDefined(self.var_BCE3)) {
    var_01 = var_01 + self.var_BCE3;
  }

  var_01 = int(clamp(var_01, 0, level.var_13F3F.size * param_00 - 1));
  return var_01;
}

func_3729(param_00, param_01, param_02) {
  var_03 = func_372B(param_00);
  var_04 = var_03 % param_00;
  if(param_00 < 2) {
    var_05 = float(var_04) / 1;
  } else {
    var_05 = float(var_05) / float(param_01 - 1);
  }

  var_06 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_05, param_01, param_02);
  if(scripts\asm\zombie\zombie::func_9F87()) {
    var_06 = var_06 * 1.2;
  }

  return var_06;
}

func_372C(param_00, param_01, param_02) {
  var_03 = func_372B(param_00);
  var_04 = var_03 / level.var_13F3F.size * param_00 - 1;
  var_05 = scripts\mp\agents\zombie\zombie_util::func_AB6F(var_04, param_01, param_02);
  return var_05;
}

func_7E10() {
  var_00 = 1;
  if(!isDefined(self.bufferedstatwritethink)) {
    return var_00;
  }

  foreach(var_02 in self.bufferedstatwritethink) {
    if(!isDefined(var_02.var_109AF)) {
      continue;
    }

    var_00 = var_00 * var_02.var_109AF;
  }

  return var_00;
}

onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\asm\zombie\zombie::func_9F87()) {
    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      self playSound("zmb_skater_explode");
    } else {
      self playSound("zmb_clown_explode");
    }

    if(isDefined(param_01) && isplayer(param_01)) {
      scripts\common\fx::playfxnophase(level._effect["suicide_zmb_death"], self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
    } else {
      scripts\common\fx::playfxnophase(level._effect["suicide_zmb_explode"], self.origin + (0, 0, 50), anglesToForward(self.angles), anglestoup(self.angles));
      radiusdamage(self.origin + (0, 0, 40), 250, 50, 10, self, "MOD_EXPLOSIVE", "zombie_suicide_bomb");
      earthquake(0.4, 0.5, self.origin, 200);
    }

    scripts\mp\mp_agent::default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
    return;
  }

  if(isDefined(self.vignette_nocorpse)) {
    self.nocorpse = 1;
    self.full_gib = 1;
    self.vignette_nocorpse = undefined;
  }

  func_10926(self.var_1657, param_03, param_04);
  if(isDefined(self.var_6658)) {
    if(isDefined(self.var_BF2F)) {
      var_09 = scripts\cp\zombies\zombie_entrances::func_7872(self.var_6658, self.var_BF2F - 1);
      if(var_09 == "destroying") {
        scripts\cp\zombies\zombie_entrances::func_F2E3(self.var_6658, self.var_BF2F - 1, "boarded");
      }

      self.var_BF2F = undefined;
    }

    scripts\cp\zombies\zombie_entrances::func_E005(self.var_6658);
    self.var_6658 = undefined;
  }

  if(isDefined(self.attack_spot)) {
    scripts\cp\zombies\zombie_entrances::release_attack_spot(self.attack_spot);
    self.attack_spot = undefined;
  }

  scripts\mp\mp_agent::default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_10926(param_00, param_01, param_02) {
  if(isDefined(self.isfrozen) && !issubstr(self.agent_type, "alien")) {
    self.nocorpse = 1;
    self playSound("forge_freeze_shatter");
    self setscriptablepartstate("frozen", "unfrozen", 1);
    playFX(level._effect["zombie_freeze_shatter"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(!isDefined(self.body) && !scripts\engine\utility::istrue(self.full_gib)) {
    return;
  }

  var_03 = self.var_DDC8;
  if(!isDefined(var_03) && !scripts\engine\utility::istrue(self.full_gib)) {
    return;
  }

  if(self.full_gib || func_46BA(var_03) >= 3) {
    thread func_10840(param_00);
    return;
  }

  while(var_03 > 0) {
    var_04 = var_03 & 0 - var_03;
    thread func_1083F(var_04, param_00);
    var_03 = var_03 - var_04;
  }
}

func_10840(param_00) {
  var_01 = 3;
  if(isDefined(level.splitscreen) && level.splitscreen) {
    var_01 = 1;
  }

  var_02 = level.var_74B9 < var_01;
  if(var_02) {
    level.var_74B9++;
    var_03 = scripts\engine\utility::getfx("gib_full_body");
  } else {
    var_03 = scripts\engine\utility::getfx("gib_full_body_cheap");
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00["emz"])) {
      var_03 = scripts\engine\utility::getfx("gib_full_body_emz");
    } else if(isDefined(param_00["exploder"])) {
      var_03 = scripts\engine\utility::getfx("gib_full_body_exp");
    } else if(isDefined(param_00["fast"])) {
      var_03 = scripts\engine\utility::getfx("gib_full_body_ovr");
    }
  }

  if(isDefined(self.gib_fx_override)) {
    var_03 = scripts\engine\utility::getfx(self.gib_fx_override);
  }

  var_04 = level.var_566C["full"]["fxTagName"];
  if(isDefined(self.body)) {
    playFXOnTag(var_03, self.body, var_04);
  } else {
    scripts\common\fx::playfxnophase(var_03, self.origin + (0, 0, 25));
  }

  playsoundatpos(self.origin, "zombie_full_body_gib");
  wait(3);
  if(isDefined(self.body)) {
    stopFXOnTag(var_03, self.body, var_04);
  }

  if(var_02) {
    level.var_74B9--;
  }
}

func_C4BD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self.var_164D[self.asmname].var_4BC0;
  var_0B = level.asm[self.asmname].states[var_0A];
  var_0C = scripts\mp\mp_agent::should_do_immediate_ragdoll(self);
  if(isDefined(self.nocorpse)) {
    var_0C = 0;
  }

  var_0D = isDefined(self.ragdollimpactvector);
  if(scripts\asm\asm_mp::func_2382(self.asmname, var_0B)) {
    if(!var_0C || !scripts\engine\utility::istrue(self.is_traversing)) {
      scripts\asm\asm::func_231E(self.asmname, var_0B, var_0A);
    }
  }

  if(isDefined(self.nocorpse)) {
    if(scripts\cp\utility::is_melee_weapon(param_04)) {
      var_0E = self getplayerviewmodelfrombody(param_08, 1);
      var_0E hide(1);
    }

    return;
  }

  var_0F = self;
  if(isDefined(self.has_backpack) && isDefined(level.should_drop_pillage)) {
    if([
        [level.should_drop_pillage]
      ](param_01, self.origin)) {
      self setscriptablepartstate("backpack", "hide", 1);
    }
  }

  if(isDefined(self.ragdollhitloc)) {
    self.body = self getplayerviewmodelfrombody(param_08, var_0C);
    self.body.ragdollhitloc = self.ragdollhitloc;
    self.body.ragdollimpactvector = self.ragdollimpactvector;
  } else {
    self.body = self getplayerviewmodelfrombody(param_08, var_0C);
  }

  if(isDefined(self.is_burning) || isDefined(param_01) && isDefined(param_04) && param_04 == "incendiary_ammo_mp") {
    self.body setscriptablepartstate("burning", "active", 1);
  } else if(isDefined(self.var_10A57)) {
    self.body setscriptablepartstate("spoon", "active", 1);
  } else if(isDefined(self.electrocuted)) {
    self.body setscriptablepartstate("electrocuted", "active", 1);
  }

  if(isDefined(self.var_CE65)) {
    self.body thread func_5774(self.var_CE65, scripts\engine\utility::istrue(self.is_traversing));
  }

  if(scripts\engine\utility::istrue(var_0C)) {
    scripts\mp\mp_agent::do_immediate_ragdoll(self.body);
  } else if(scripts\engine\utility::istrue(var_0D)) {
    thread velocityragdoll(self.body, param_06, param_05, param_04, param_00, param_03);
  } else if(!scripts\engine\utility::istrue(self.death_anim_no_ragdoll)) {
    thread scripts\mp\mp_agent::delaystartragdoll(self.body, param_06, param_05, param_04, param_00, param_03);
  }

  self.death_anim_no_ragdoll = undefined;
}

velocityragdoll(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_07 in level.noragdollents) {
      if(distancesquared(param_00.origin, var_07.origin) < 65536) {
        return;
      }
    }
  }

  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 _meth_81B7()) {
    return;
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00.ragdollhitloc) && isDefined(param_00.ragdollimpactvector)) {
      param_00 giverankxp_regularmp(param_00.ragdollhitloc, param_00.ragdollimpactvector);
      return;
    }

    param_00 giverankxp();
  }
}

func_5774(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_01)) {
    wait(param_00);
  }

  if(isDefined(self)) {
    self setscriptablepartstate("death_fx", "active", 1);
    wait(0.1);
    self hide(1);
  }
}

func_1083F(param_00, param_01) {
  var_02 = level.var_566C[param_00]["torsoFX"];
  if(isDefined(param_01)) {
    if(isDefined(param_01["emz"])) {
      var_02 = var_02 + "_emz";
    } else if(isDefined(param_01["exploder"])) {
      var_02 = var_02 + "_exp";
    } else if(isDefined(param_01["fast"])) {
      var_02 = var_02 + "_ovr";
    }
  }

  playFXOnTag(scripts\engine\utility::getfx(var_02), self.body, level.var_566C[param_00]["fxTagName"]);
  wait(10);
  if(isDefined(self.body)) {
    stopFXOnTag(scripts\engine\utility::getfx(var_02), self.body, level.var_566C[param_00]["fxTagName"]);
  }
}

func_B9B9() {
  self endon("death");
  level endon("game_ended");
  var_00 = gettime();
  var_01 = self.origin;
  var_02 = var_00;
  var_03 = 0;
  var_04 = 5;
  for(;;) {
    wait(var_04);
    var_05 = distancesquared(self.origin, var_01);
    var_06 = gettime() - var_02 / 1000;
    var_07 = var_05 > 16384;
    var_08 = scripts\engine\utility::istrue(self.var_1198.var_2BDE);
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

  if(var_03 && shouldreacttolight()) {
    thread func_DE06(self.agent_type);
  }

  killagent(self);
}

func_BA27() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    if(length(self getvelocity()) == 0 && self.aistate == "move") {
      var_00 = var_00 + 0.05;
    } else {
      var_00 = 0;
    }

    if(var_00 > 2) {
      var_01 = self getspectatepoint();
      if(isDefined(var_01)) {
        var_02 = distancesquared(self.origin, var_01.origin);
        if(var_02 < squared(15)) {
          self setorigin(var_01.origin, 0);
        }
      }
    }

    wait(0.05);
  }
}

func_3E0A(param_00, param_01, param_02) {
  if(isDefined(self.var_932A) && self.var_932A) {
    return 0;
  }

  var_03 = gettime() - param_00 / 1000;
  if(var_03 > param_01) {
    if(var_03 > param_02) {
      return 1;
    }
  }

  return 0;
}

shouldreacttolight() {
  if(!isDefined(level.var_1CB5)) {
    return 0;
  }

  return allowjump() > 1;
}

allowjump() {
  var_00 = scripts\mp\mp_agent::getactiveagentsoftype("all");
  var_01 = 0;
  foreach(var_03 in var_00) {
    if(var_03.team == level.var_6575) {
      var_01++;
    }
  }

  return var_01;
}

func_DE06(param_00) {
  if(!isDefined(level.var_DE07)) {
    level.var_DE07 = 0;
  }

  level.var_DE07++;
  while(scripts\mp\mp_agent::getnumactiveagents() >= level.var_B497 || isDefined(level.var_DE08)) {
    scripts\engine\utility::waitframe();
  }

  level.var_DE08 = 1;
  wait(0.2);
  level.var_DE08 = undefined;
  level.var_DE07--;
  if(level.var_DE07 < 0) {
    level.var_DE07 = 0;
  }
}

func_A012() {
  if(!isDefined(level.var_13F60)) {
    return 0;
  }

  return level.var_13F60;
}

killagent(param_00) {
  param_00 dodamage(param_00.health + 500000, param_00.origin);
}

func_13F9F(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_04 = self.origin[2] - var_03.origin[2];
    if(abs(var_04) < param_01) {
      var_05 = distance2dsquared(self.origin, var_03.origin);
      if(var_05 < param_00) {
        var_06 = self.var_381;
        var_07 = length2d(var_06);
        if(var_07 == 0) {
          break;
        }

        var_08 = var_03.origin - self.origin;
        var_08 = (var_08[0], var_08[1], 0);
        var_09 = vectornormalize(var_08);
        if(var_07 < 60) {
          var_07 = 60;
        }

        var_0A = var_03 getvelocity();
        var_0A = (var_0A[0], var_0A[1], 0);
        var_0B = length2d(var_0A);
        if(var_0B > 0) {
          var_0C = var_09 * var_07;
          var_0D = var_0A + var_0C;
          var_0E = length2d(var_0D);
          if(vectordot(var_0D, var_0C) < 0) {
            var_0F = vectorcross((0, 0, 1), var_09);
            if(vectordot(var_0F, var_0A) > 0) {
              var_0B = length2d(var_0A);
              var_0A = var_0F * var_0B;
            } else {
              var_10 = var_0F * -1;
              var_0B = length2d(var_0A);
              var_0A = var_10 * var_0B;
            }

            var_0D = var_0A + var_0C;
            var_07 = length2d(var_0D);
          } else {
            if(var_0B > var_07) {
              var_07 = var_0B;
            }

            var_09 = vectornormalize(var_0D);
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