/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\crab_brute\crab_brute_agent.gsc
*************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\crab_brute::_id_DEE8();
  scripts\asm\crab_brute\mp\states::_id_2371();
  scripts\mp\agents\crab_brute\crab_brute_tunedata::setuptunedata();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["crab_brute"]["setup_func"] = ::setupagent;
  level.agent_definition["crab_brute"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["crab_brute"]["on_damaged"] = ::scripts\cp\maps\cp_town\cp_town_damage::cp_town_onzombiedamaged;

  if(!isDefined(level._id_8CBD)) {
    level._id_8CBD = [];
  }

  level._id_8CBD["crab_brute"] = ::calculatecrabbruteihealth;
  level.agent_funcs["crab_brute"]["gametype_on_killed"] = ::_id_C4D1;
  level.brute_loot_check = [];

  if(!isDefined(level.damage_feedback_overrride)) {
    level.damage_feedback_overrride = [];
  }

  level.damage_feedback_overrride["crab_brute"] = ::scripts\cp\maps\cp_town\cp_town_damage::crog_processdamagefeedback;

  if(!isDefined(level.special_zombie_damage_func)) {
    level.special_zombie_damage_func = [];
  }

  level.special_zombie_damage_func["crab_brute"] = ::crab_brute_special_damage_func;
}

_id_FACE(var_0) {
  self setModel("zmb_brutecrab");
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
  self._id_9342 = 1;
  self.aistate = "idle";
  self.movemode = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
  self._id_252B = 26 + self.radius;
  self._id_B640 = "normal";
  self._id_B641 = 50;
  self._id_2539 = 54;
  self._id_253A = -64;
  self._id_4D45 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1.0;
  self._id_C081 = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self._id_2AB2 = 0;
  self._id_2AB8 = 1;
  self.timelineevents = 0;
  self.allowcrouch = 1;
  self._id_B5F9 = 40;
  self._id_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self._id_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.is_crawler = 0;
  self.died_poorly = 0;
  self.damaged_by_player = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self._id_B0FC = 1;
  self.full_gib = 0;
  self.favoriteenemy = undefined;
  self._id_E821 = undefined;
  self.last_damage_time_on_player = [];
  self._id_8C12 = 0;
  self.hasplayedvignetteanim = undefined;
  self.is_cop = undefined;
  self.highlyawareradius = 200;
  self.deathmethod = undefined;
  self._id_10A57 = undefined;
  self.gib_fx_override = undefined;
  self._id_CE65 = undefined;
  self._id_29D2 = 1;
  self.vignette_nocorpse = undefined;
  self.death_anim_no_ragdoll = undefined;
  self.dont_cleanup = 1;
  self.spawn_round_num = level.wave_num;

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self._id_AB3F = 1;
  }
}

setupagent() {
  setupzombiegametypevars();
  self.height = self._id_18F4;
  self.radius = self._id_18F9;
  self.immune_against_nuke = 1;
  self._id_B62D = 70;
  self._id_B62E = 70;
  self.meleeradiuswhentargetnotonnavmesh = 80;
  self.meleeradiusbasesq = squared(self._id_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self._id_B601 = 45;
  self._id_504E = 55;
  self._id_129AF = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self setavoidanceradius(45);
  self.ground_pound_damage = 50;
  self.footstepdetectdist = 2500;
  self.footstepdetectdistwalk = 2500;
  self.footstepdetectdistsprint = 2500;
  self.ignoreall = 1;
  thread dopostspawnupdates();
  thread listen_for_death_sfx();
}

dopostspawnupdates() {
  wait 0.5;
  self.dont_cleanup = 1;
}

listen_for_death_sfx() {
  self waittill("death");
  self playSound("brute_crog_death");
  wait 1;
  self playSound("brute_crog_explo");
}

getenemy() {
  if(isDefined(self.myenemy)) {
    return self.myenemy;
  }

  return undefined;
}

lookatenemy() {
  var_0 = getenemy();

  if(isDefined(var_0)) {
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    self orientmode("face angle abs", var_2);
  } else
    self orientmode("face angle abs", self.angles);
}

crab_brute_special_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(scripts\asm\asm::asm_isinstate("burrow_loop")) {
    return 0;
  }

  if(var_5 == "gas_grenade_mp") {
    return 0;
  }

  self.lastdamagetime = gettime();

  if(isDefined(var_7)) {
    var_12 = scripts\mp\agents\crab_brute\crab_brute_tunedata::gettunedata();
    var_13 = anglesToForward(self.angles) * -1;
    var_14 = vectordot(var_13, var_7);

    if(var_14 > var_12.reduce_damage_dot) {
      var_2 = var_2 * var_12.reduce_damage_pct;
      self.armor_hit = 1;
    }
  }

  return var_2;
}

_id_C4D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.agent_type) && self.agent_type == "crab_brute") {
    var_1 scripts\cp\cp_merits::processmerit("mt_dlc3_crab_brute");
  }

  var_12 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);

  if(isDefined(var_12) && !isDefined(self._id_72AC)) {
    if(!isDefined(level.brute_loot_check[self.spawn_round_num])) {
      level.brute_loot_check[self.spawn_round_num] = 1;
      level thread scripts\cp\loot::drop_loot(self.origin, var_1, var_12);
    }
  }

  var_13 = 400;
  level thread boss_death_vo();

  foreach(var_15 in level.players) {
    var_15 scripts\cp\cp_persistence::give_player_currency(var_13);
  }
}

boss_death_vo() {
  wait 10;

  if(isDefined(level.elvira_ai)) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_crog_defeat_elvira", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  } else {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_crog_defeat_generic", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  }
}

calculatecrabbruteihealth() {
  return 5000 * level.players.size;
}

shouldignoreenemy(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(var_0.ignoreme || isDefined(var_0.owner) && var_0.owner.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 1;
  }

  return 0;
}

create_brute_death_fx(var_0) {
  self._id_CE65 = 1;
}