/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\alien_goon\alien_goon_agent.gsc
*************************************************************/

registerscriptedagent() {
  scripts\mp\agents\alien_goon\alien_goon_tunedata::setuptunedata();
  scripts\aitypes\bt_util::init();
  behaviortree\alien_goon::func_DEE8();
  scripts\asm\alien_goon\mp\states::func_2371();
  scripts\asm\dlc4\alien_anim_utils::func_97C5();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["alien_goon"]["setup_func"] = ::setupagent;
  level.agent_definition["alien_goon"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["alien_goon"]["on_damaged"] = ::func_C4E0;
  level.agent_funcs["alien_goon"]["gametype_on_damage_finished"] = scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["alien_goon"]["gametype_on_killed"] = scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiekilled;
  level.agent_funcs["alien_goon"]["on_damaged_finished"] = scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["alien_goon"]["on_killed"] = scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["alien_goon"] = ::calculatealiengoonhealth;
  if(!isDefined(level.damage_feedback_overrride)) {
    level.damage_feedback_overrride = [];
  }
}

func_FACE(var_0) {
  self setModel("alien_goon");
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
  self.moveratescale = 0.9;
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
  self.allowpain = 0;
  self setavoidanceradius(45);
  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }
}

setupagent() {
  setupzombiegametypevars();
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_12EE6();
  self.height = self.var_18F4;
  self.fgetarg = self.var_18F9;
  self.var_B62D = 70;
  self.var_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.defaultgoalradius = self.fgetarg + 1;
  self.meleedot = 0.5;
  self.var_B601 = 45;
  self.var_504E = 55;
  self.var_129AF = 55;
  self.var_368 = -60;
  self.isbot = 60;
  self.ground_pound_damage = 50;
  self.footstepdetectdist = 2500;
  self.footstepdetectdistwalk = 2500;
  self.footstepdetectdistsprint = 2500;
  self.precacheleaderboards = 1;
  self.dontmutilate = 1;
  if(scripts\engine\utility::istrue(self.activated_venomx_sphere)) {
    self.activated_venomx_sphere = undefined;
  }

  if(scripts\engine\utility::istrue(self.dot_triggered)) {
    self.dot_triggered = undefined;
  }

  self.aj_goon = 0;
  self.preventplayerpushdist = 12;
  thread monitorwhizbys();
}

func_AEB0() {
  level._effect["alien_teleport_fx"] = loadfx("vfx\iw7\_requests\coop\zmb_fullbody_gib.vfx");
}

monitorwhizbys() {
  self endon("death");
  self.lastwhizbytime = undefined;
  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);
    self.lastwhizbytime = gettime();
    self.lastwhizbyshooter = var_0;
    self.lastwhizbydist = var_1;
  }
}

calculatealiengoonhealth() {
  var_0 = 200;
  switch (level.specialroundcounter) {
    case 0:
      var_0 = 400;
      break;

    case 1:
      var_0 = 900;
      break;

    case 2:
      var_0 = 1300;
      break;

    case 3:
      var_0 = 1600;
      break;

    case 4:
      var_0 = 2000;
      break;

    default:
      var_0 = 2000;
      break;
  }

  return var_0;
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
  if(isDefined(self.fake_damage)) {
    self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + self.fake_damage;
    self.fake_damage = undefined;
    return;
  }

  self.damageaccumulator.accumulateddamage = self.damageaccumulator.accumulateddamage + var_0;
}

func_C4E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  accumulatedamage(var_2, var_7);
  scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}