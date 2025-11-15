/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\crab_mini\crab_mini_agent.gsc
***********************************************************/

registerscriptedagent() {
  scripts\mp\agents\crab_mini\crab_mini_tunedata::setuptunedata();
  scripts\aitypes\bt_util::init();
  behaviortree\crab_mini::func_DEE8();
  scripts\asm\crab_mini\mp\states::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["crab_mini"]["setup_func"] = ::setupagent;
  level.agent_definition["crab_mini"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["crab_mini"]["on_damaged"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiedamaged;
  level.agent_funcs["crab_mini"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["crab_mini"]["gametype_on_killed"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiekilled;
  level.agent_funcs["crab_mini"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["crab_mini"]["on_killed"] = ::onkilled;
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["crab_mini"] = ::calculatecrabminihealth;
  if(!isDefined(level.damage_feedback_overrride)) {
    level.damage_feedback_overrride = [];
  }

  level.damage_feedback_overrride["crab_mini"] = ::scripts\cp\maps\cp_town\cp_town_damage::crog_processdamagefeedback;
  if(!isDefined(level.special_zombie_damage_func)) {
    level.special_zombie_damage_func = [];
  }

  level.special_zombie_damage_func["crab_mini"] = ::crab_mini_special_damage_func;
}

func_FACE(param_00) {
  self setModel("zmb_minicrab");
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
}

getenemy() {
  if(isDefined(self.myenemy)) {
    return self.myenemy;
  }

  return undefined;
}

lookatenemy() {
  var_00 = getenemy();
  if(isDefined(var_00)) {
    var_01 = var_00.origin - self.origin;
    var_02 = vectortoangles(var_01);
    self orientmode("face angle abs", var_02);
    return;
  }

  self orientmode("face angle abs", self.angles);
}

calculatecrabminihealth() {
  var_00 = 200;
  switch (level.specialroundcounter) {
    case 0:
      var_00 = 300;
      break;

    case 1:
      var_00 = 450;
      break;

    case 2:
      var_00 = 450;
      break;

    case 3:
      var_00 = 600;
      break;

    default:
      var_00 = 600;
      break;
  }

  return var_00;
}

create_sludge_pool(param_00) {
  self.var_CE65 = 1;
  if(!isDefined(level.goo_pool_ent_array)) {
    level.goo_pool_ent_array = [];
  }

  var_01 = 2500;
  foreach(var_03 in level.goo_pool_ent_array) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(distancesquared(param_00, var_03.origin) < var_01) {
      var_03.var_AC75 = gettime() + 10000;
      return;
    }
  }

  var_05 = spawn("script_model", param_00);
  var_05 setModel("tag_origin_crab_goo");
  level.goo_pool_ent_array[level.goo_pool_ent_array.size] = var_05;
  var_05 setscriptablepartstate("blood_pool", "active");
  var_05 thread run_sludge_pool_damage_func();
}

run_sludge_pool_damage_func() {
  self endon("death");
  var_00 = 2500;
  self.var_AC75 = gettime() + 10000;
  while(self.var_AC75 > gettime()) {
    foreach(var_02 in level.players) {
      if(distancesquared(self.origin, var_02.origin) < var_00) {
        var_03 = gettime();
        if(!isDefined(var_02.last_crab_sludge_time) || var_02.last_crab_sludge_time + 1000 < var_03) {
          var_02 dodamage(20, self.origin, self, self, "MOD_UNKNOWN");
          var_02.last_crab_sludge_time = gettime();
        }
      }
    }

    wait(0.05);
  }

  self delete();
}

setisstuck(param_00) {
  self.bisstuck = param_00;
}

iscrabministuck() {
  return isDefined(self.bisstuck) && self.bisstuck;
}

crab_mini_special_damage_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(level.insta_kill) && level.insta_kill) {
    return self.health;
  }

  if(isDefined(param_05) && param_05 == "iw7_knife_zm_cleaver") {
    return self.health;
  }

  if(isDefined(param_07)) {
    var_0C = scripts\mp\agents\crab_mini\crab_mini_tunedata::gettunedata();
    var_0D = anglesToForward(self.angles) * -1;
    var_0E = vectordot(var_0D, param_07);
    if(var_0E > var_0C.reduce_damage_dot) {
      param_02 = param_02 * var_0C.reduce_damage_pct;
      self.armor_hit = 1;
    }
  }

  return param_02;
}

onkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  thread play_death_sfx(1);
  return scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

play_death_sfx(param_00) {
  playsoundatpos(self.origin, "minion_crog_pre_explo");
  wait(param_00);
  playsoundatpos(self.origin, "minion_crog_explode");
}