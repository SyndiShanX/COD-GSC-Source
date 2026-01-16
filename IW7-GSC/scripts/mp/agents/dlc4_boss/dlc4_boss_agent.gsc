/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\dlc4_boss\dlc4_boss_agent.gsc
***********************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\dlc4_boss::func_DEE8();
  scripts\asm\dlc4_boss\mp\states::func_2371();
  scripts\mp\agents\dlc4_boss\dlc4_boss_tunedata::setuptunedata();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["dlc4_boss"]["setup_func"] = ::setupagent;
  level.agent_definition["dlc4_boss"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["dlc4_boss"]["on_damaged"] = ::func_C4E0;
  level.agent_funcs["dlc4_boss"]["on_damaged_finished"] = ::ondamagefinished;
}

func_FACE(var_0) {
  self setModel("zmb_mephistopheles");
}

func_AEB0() {}

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
  self.var_504E = 55;
  self.var_129AF = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.precacheleaderboards = 1;
  self gib_fx_override("noclip");
}

func_C4E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(var_5 == var_12.entangler_weapon_name) {
    var_2 = 0;
  }

  if(!isDefined(var_1) || !isplayer(var_1)) {
    var_2 = 0;
  }

  [[level.agent_funcs["dlc4_boss"]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

ondamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_2 == 0) {
    return;
  }

  self.health = 999999;
  var_13 = 0;
  if(self.showblood || var_13) {
    self getrespawndelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  if(self.var_FCA5 && !var_13) {
    if(isDefined(var_6) && isDefined(var_7)) {
      playFX(level._effect["boss_shield_hit"], var_6, var_7 * -150);
    }
  }

  if(!self.cantakedamage) {
    return;
  }

  if(isplayer(var_1)) {
    var_1 thread scripts\cp\cp_damage::updatehitmarker("high_damage_cp");
  }

  var_14 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(level.fbd.bossstate == "FRENZIED") {
    self.frenziedhealth = self.frenziedhealth - min(var_2, self.damagecap);
    self.damagecap = max(self.damagecap - var_2, 0);
    if(self.frenziedhealth <= 0) {
      if(!self.interruptable) {
        self.frenziedhealth = 1;
        return;
      }

      return;
    }

    return;
  }

  if(level.fbd.bossstate == "LAST_STAND") {
    self.laststandhealth = self.laststandhealth - min(var_2, self.damagecap);
    self.damagecap = max(self.damagecap - var_2, 0);
  }
}