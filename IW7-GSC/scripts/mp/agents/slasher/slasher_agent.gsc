/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\slasher\slasher_agent.gsc
*******************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\slasher::func_DEE8();
  scripts\asm\slasher\mp\states::func_2371();
  scripts\mp\agents\slasher\slasher_tunedata::setuptunedata();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["slasher"]["setup_func"] = ::setupagent;
  level.agent_definition["slasher"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["slasher"]["on_damaged_finished"] = ::onslasherdamagefinished;
  level.agent_funcs["slasher"]["on_killed"] = ::onslasherkilled;
}

func_FACE(var_0) {
  var_1 = getdvar("ui_mapname");
  if(var_1 == "cp_final") {
    self setModel("body_final_slasher");
  } else {
    self setModel("body_zmb_slasher");
  }

  self attach("head_zmb_slasher");
  self attach("weapon_zmb_slasher_vm", "tag_weapon_right");
}

setupzombiegametypevars() {
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
  self.var_9342 = 1;
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
  self.dont_cleanup = 1;
  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }
}

setupagent() {
  setupzombiegametypevars();
  self.height = self.var_18F4;
  self.fgetarg = self.var_18F9;
  self.immune_against_nuke = 1;
  self.var_B62D = 70;
  self.var_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.defaultgoalradius = self.fgetarg + 1;
  self.meleedot = 0.5;
  self.var_B601 = 45;
  self.meleeattackchance["melee_spin"] = 10;
  self.meleeattackchance["ground_pound"] = 30;
  self.meleeattackchance["swipe_attack"] = 100;
  self.var_504E = 55;
  self.var_129AF = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.grenadeweapon = "slasher_grenade_zm";
  self.objective_state = 999;
  self.ground_pound_damage = 50;
  self.footstepdetectdist = 2500;
  self.footstepdetectdistwalk = 2500;
  self.footstepdetectdistsprint = 2500;
  self.var_71D0 = ::shouldslasherplaypainanim;
  self.precacheleaderboards = 1;
  var_0 = getdvar("ui_mapname");
  if(var_0 != "cp_final") {
    self setethereal(1);
  }

  if(isDefined(level.slasher_level)) {
    if(level.wave_num < 30 && level.wave_num > 19 && level.slasher_level < 3) {
      level.slasher_level = 2;
    } else if(level.wave_num > 29) {
      level.slasher_level = 3;
    }
  }

  thread turn_on_saw_blade_after_time(5);
  thread listen_for_fake_death();
}

turn_on_saw_blade_after_time(var_0) {
  self endon("death");
  wait(var_0);
  self setscriptablepartstate("slasher_saw", "active");
  var_1 = getdvar("ui_mapname");
  if(var_1 == "cp_final") {
    return;
  }

  if(isDefined(level.slasher_level)) {
    switch (level.slasher_level) {
      case 1:
        self setscriptablepartstate("mask", "blue_mask");
        break;

      case 2:
        self setscriptablepartstate("mask", "yellow_mask");
        break;

      case 3:
        self setscriptablepartstate("mask", "green_mask");
        break;

      default:
        break;
    }
  }
}

accumulatedamage(var_0, var_1) {
  if(!isDefined(self.damageaccumulator)) {
    self.damageaccumulator = spawnStruct();
    self.damageaccumulator.accumulateddamage = 0;
  } else if(!isDefined(self.damageaccumulator.lastdamagetime) || gettime() > self.damageaccumulator.lastdamagetime + 1000) {
    self.damageaccumulator.accumulateddamage = 0;
    self.damageaccumulator.lastdamagetime = 0;
  }

  self.damageaccumulator.lastdamagetime = gettime();
  if(!isDefined(var_1)) {
    var_1 = (1, 1, 1);
  }

  self.damageaccumulator.lastdir = var_1;
  self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + var_0;
}

isinravemode() {
  if(self isethereal()) {
    return 1;
  }

  return 0;
}

onslasherdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_2;
  if(var_5 == "iw7_harpoon_zm") {
    var_2 = min(0.1 * self.maxhealth, 2000);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon1")) {
    var_2 = min(0.01 * self.maxhealth, 100);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon2")) {
    var_2 = min(0.1 * self.maxhealth, 1500);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon3")) {
    var_2 = min(0.1 * self.maxhealth, 1500);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon4")) {
    var_2 = min(0.01 * self.maxhealth, 1000);
    var_2 = int(var_2);
  }

  if(isDefined(var_5) && var_5 == "iw7_slasher_zm") {
    var_2 = var_2 * 0.1;
    var_2 = int(var_2);
  } else {
    if(isinravemode() || scripts\engine\utility::istrue(var_1.rave_mode)) {
      var_2 = 0;
    }

    if(scripts\asm\asm::asm_isinstate("block")) {
      var_2 = var_2 * 0.1;
      var_2 = int(var_2);
    }
  }

  if(isDefined(level.players) && level.players.size > 1) {
    if(var_2 != 0) {
      var_14 = int(var_2 / level.players.size + 1);
      var_2 = int(max(var_14, 1));
    }
  }

  if(var_2 > 0) {
    accumulatedamage(var_2, var_7);
  }

  if(isDefined(self.nodamagescale)) {
    var_2 = var_13;
  }

  slasher_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_11, var_12);
}

slasher_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self.health;
  if(isDefined(var_7)) {
    var_14 = vectortoyaw(var_7);
    var_15 = self.angles[1];
    self.var_E3 = angleclamp180(var_14 - var_15);
  } else {
    self.var_E3 = 0;
  }

  self.var_DD = var_8;
  self.var_DE = var_4;
  self.damagedby = var_1;
  self.var_DC = var_7;
  self.var_E1 = var_2;
  self.var_E2 = var_5;
  self.var_4D62 = var_6;
  if(var_2 >= self.health) {
    var_2 = 0;
    if(isDefined(var_5) && var_5 == "iw7_slasher_zm") {
      var_1 notify("slasher_killed_by_own_weapon", var_1, var_5);
    }

    self notify("fake_death");
  }

  self getrespawndelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_11, var_12, 0, 1);
  if(self.health > 0 && self.health < var_13) {
    self notify("pain");
  }

  if(isalive(self) && isDefined(self.agent_type)) {
    var_10 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];
    if(isDefined(var_10)) {
      [
        [var_10]
      ](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }
  }
}

onslasherkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self detach("weapon_zmb_slasher_vm", "tag_weapon_right");
  self.nocorpse = 1;
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

getslashergrenadehandoffset() {
  return (12, 12, 100);
}

getslasherhandposition() {
  return self gettweakablevalue(self.origin + (12, 12, 100));
}

shouldslasherplaypainanim() {
  return 0;
}

getenemy() {
  if(isDefined(self.slasherenemy)) {
    return self.slasherenemy;
  }

  return undefined;
}

lookatslasherenemy() {
  var_0 = getenemy();
  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    self orientmode("face angle abs", var_2);
    return;
  }

  self orientmode("face angle abs", self.angles);
}

listen_for_fake_death() {
  self endon("death");
  for(;;) {
    self waittill("fake_death");
    if(!scripts\engine\utility::istrue(level.slasher_fight)) {
      self.precacheleaderboards = 1;
      self setscriptablepartstate("teleport", "hide");
      wait(0.1);
      self hide();
      wait(0.1);
      self suicide();
    }
  }
}