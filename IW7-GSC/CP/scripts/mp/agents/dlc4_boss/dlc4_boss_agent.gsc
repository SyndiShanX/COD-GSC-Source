/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\dlc4_boss\dlc4_boss_agent.gsc
***********************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\dlc4_boss::_id_DEE8();
  scripts\asm\dlc4_boss\mp\states::_id_2371();
  scripts\mp\agents\dlc4_boss\dlc4_boss_tunedata::setuptunedata();
  _id_AEB0();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

  level.agent_definition["dlc4_boss"]["setup_func"] = ::setupagent;
  level.agent_definition["dlc4_boss"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["dlc4_boss"]["on_damaged"] = ::_id_C4E0;
  level.agent_funcs["dlc4_boss"]["on_damaged_finished"] = ::ondamagefinished;
}

_id_FACE(var_0) {
  self setModel("zmb_mephistopheles");
}

_id_AEB0() {}

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

  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1)
    self._id_AB3F = 1;
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
  self.ignoreall = 1;
  self scragentsetphysicsmode("noclip");
}

_id_C4E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\asm\dlc4\dlc4_asm::gettunedata();

  if(var_5 == var_12.entangler_weapon_name)
    var_2 = 0;

  if(!isDefined(var_1) || !isPlayer(var_1))
    var_2 = 0;

  [[level.agent_funcs["dlc4_boss"]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

ondamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_2 == 0) {
    return;
  }
  self.health = 999999;
  var_13 = 0;

  if(self.showblood || var_13)
    self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

  if(self._id_FCA5 && !var_13) {
    if(isDefined(var_6) && isDefined(var_7))
      playFX(level._effect["boss_shield_hit"], var_6, var_7 * -150);
  }

  if(!self.cantakedamage) {
    return;
  }
  if(isPlayer(var_1))
    var_1 thread scripts\cp\cp_damage::updatehitmarker("high_damage_cp");

  var_14 = scripts\asm\dlc4\dlc4_asm::gettunedata();

  if(level.fbd.bossstate == "FRENZIED") {
    self.frenziedhealth = self.frenziedhealth - min(var_2, self.damagecap);
    self.damagecap = max(self.damagecap - var_2, 0);

    if(self.frenziedhealth <= 0) {
      if(!self.interruptable)
        self.frenziedhealth = 1;
    }
  } else if(level.fbd.bossstate == "LAST_STAND") {
    self.laststandhealth = self.laststandhealth - min(var_2, self.damagecap);
    self.damagecap = max(self.damagecap - var_2, 0);
  }
}