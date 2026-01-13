/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\pamgrier\pamgrier_agent.gsc
*********************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\pamgrier::func_DEE8();
  scripts\asm\pamgrier\mp\states::func_2371();
  scripts\mp\agents\pamgrier\pamgrier_tunedata::setuptunedata();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["pamgrier"]["setup_func"] = ::setupagent;
  level.agent_definition["pamgrier"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["pamgrier"]["on_damaged_finished"] = ::ondamagefinished;
}

func_FACE(var_0) {
  self setModel("cp_disco_female_boss_pam_grier");
  self attach("weapon_zmb_katana_wm_camo", "tag_weapon_right");
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
  self.var_B601 = 9999;
  self.var_504E = 55;
  self.var_129AF = 55;
  self.var_368 = -60;
  self.isbot = 60;
  self.ground_pound_damage = 50;
  self.footstepdetectdist = 2500;
  self.footstepdetectdistwalk = 2500;
  self.footstepdetectdistsprint = 2500;
  self.team = "allies";
  self.precacheleaderboards = 1;
  self.ignoreme = 1;
  self.bchillin = 0;
  self.chillinpos = self.origin;
  self.chillinangles = self.angles;
  level.the_hoff_revive = 1;
  thread pamcleanup();
}

pamcleanup() {
  self waittill("death");
  level.the_hoff_revive = undefined;
}

getenemy() {
  return self.pamenemy;
}

lookatenemy() {
  var_0 = getenemy();
  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    self orientmode("face angle abs", (0, var_2[1], 0));
    return;
  }

  self orientmode("face angle abs", self.angles);
}

setpassive() {
  if(scripts\engine\utility::istrue(self.bpassive)) {
    return;
  }

  self.bneedschilltransition = 1;
  self.bpassive = 1;
}

clearpassive() {
  self.bneedschilltransition = undefined;
  self.bpassive = undefined;
}

ondamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {}