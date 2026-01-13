/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\karatemaster\karatemaster_agent.gsc
*****************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\karatemaster::func_DEE8();
  scripts\asm\karatemaster\mp\states::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["karatemaster"]["setup_func"] = ::setupagent;
  level.agent_definition["karatemaster"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["karatemaster"]["gametype_on_damage_finished"] = scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["karatemaster"]["gametype_on_killed"] = scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.agent_funcs["karatemaster"]["on_damaged"] = ::func_C4E0;
  level.agent_funcs["karatemaster"]["on_damaged_finished"] = ::ondamagefinished;
  level.agent_funcs["karatemaster"]["on_killed"] = level.var_C4BE;
  level.var_1094E["karatemaster"] = ::should_spawn_karatemaster;
}

func_FACE(var_0) {
  if(isDefined(level.karate_zombie_model_list)) {
    var_1 = scripts\engine\utility::random(level.karate_zombie_model_list);
  } else {
    var_1 = "karatemaster_male_3_black";
  }

  self setModel(var_1);
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
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
  self setavoidanceradius(30);
  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }

  setmovemode("run");
}

setupagent() {
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_12EE6();
  setupzombiegametypevars();
  self.karatemaster = 1;
  self.aj_karatemaster = 0;
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
  self.allowpain = 0;
  self.dontmutilate = 1;
  scripts\mp\agents\karatemaster\karatemaster_tunedata::setuptunedata();
}

getenemy() {
  return self.myenemy;
}

setmovemode(var_0) {
  self.desiredmovemode = var_0;
}

findgoodteleportcloserspot() {
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_0 = self pathdisttogoal();
    var_1 = self getposonpath(var_0 - scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cteleportthisclosetoplayer);
    return var_1;
  }

  return self.initialteleportpos;
}

accumulatedamage(var_0, var_1) {
  var_2 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  if(!isDefined(self.damageaccumulator)) {
    self.damageaccumulator = spawnStruct();
    self.damageaccumulator.accumulateddamage = 0;
  } else if(!isDefined(self.damageaccumulator.lastdamagetime) || gettime() > self.damageaccumulator.lastdamagetime + var_2.cdamageaccumulationcleartimems) {
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

getdamageaccumulator() {
  if(!isDefined(self.damageaccumulator)) {
    self.damageaccumulator = spawnStruct();
    self.damageaccumulator.accumulateddamage = 0;
  }

  var_0 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  if(!isDefined(self.damageaccumulator.lastdamagetime) || gettime() > self.damageaccumulator.lastdamagetime + var_0.cdamageaccumulationcleartimems) {
    self.damageaccumulator.accumulateddamage = 0;
    self.damageaccumulator.lastdamagetime = 0;
  }

  if(self.damageaccumulator.accumulateddamage == 0) {
    return undefined;
  }

  return self.damageaccumulator;
}

cleardamageaccumulator() {
  self.damageaccumulator.accumulateddamage = 0;
  self.damageaccumulator.lastdamagetime = 0;
}

ondamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  accumulatedamage(var_2, var_7);
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
}

func_C4E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(scripts\engine\utility::istrue(self.ishidden)) {
    return;
  }

  [[level.on_zombie_damaged_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

should_spawn_karatemaster() {
  if(scripts\engine\utility::flag_exist("rk_fight_started") && scripts\engine\utility::flag("rk_fight_started")) {
    return undefined;
  }

  var_0 = 0;
  if(level.wave_num >= 20) {
    var_0 = min(level.wave_num - 19, 10);
  } else if(level.wave_num < 10) {
    return undefined;
  }

  var_1 = 5;
  if(getdvarint("scr_force_karatemaster_spawn", 0) == 1) {
    var_1 = 0;
    var_0 = 100;
  }

  if(getdvarint("scr_force_no_karatemaster_spawn", 0) == 1) {
    var_1 = 500;
    var_0 = 0;
  }

  if(level.wave_num > var_1) {
    if(randomint(100) < var_0) {
      return "karatemaster";
    }

    return undefined;
  }

  return undefined;
}