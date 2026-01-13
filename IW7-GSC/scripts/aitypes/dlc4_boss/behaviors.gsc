/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4_boss\behaviors.gsc
***************************************************/

initbehaviors(var_0) {
  setupbehaviorstates();
  setupblackboard();
  setupnodes();
  setupactions();
  self.desiredaction = undefined;
  self.lastenemyengagetime = 0;
  self.myenemy = undefined;
  self.timers = spawnStruct();
  self.timers.idletimer = 0;
  self setscriptablepartstate("flames", "on");
  resetsoulhealth();
  self.var_71D0 = ::shouldplaydlc4bosspainanim;
  self.unlockedactions = [];
  self.forcingaction = 0;
  self.specialactionnames = scripts\engine\utility::array_randomize(["clap", "throw", "air_pound", "tornado"]);
  self.passivetimer = 0;
  self.specialactiontimer = 0;
  self.automaticspawntimer = 0;
  self.claponarena = 0;
  self.eclipseactive = 0;
  self.cantakedamage = 0;
  self.var_FCA5 = 1;
  self.showblood = 0;
  self.interruptable = 1;
  self.automaticspawn = 0;
  self.vulnerable = 0;
  self.damagecap = 0;
  self.maxdamagecap = scripts\asm\dlc4\dlc4_asm::gettunedata().frenzied_damage_cap;
  updateweights();
  return level.success;
}

shouldplaydlc4bosspainanim() {
  return 1;
}

setupbehaviorstates() {
  scripts\aitypes\dlc4\simple_action::setupsimplebtaction();
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("move_action", ::moveaction_begin, ::moveaction_tick, ::moveaction_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("ground_pound", ::groundpound_begin, ::groundpound_tick, ::groundpound_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("temp_idle", ::tempidle_begin, ::tempidle_tick, ::tempidle_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("air_pound", ::airpound_begin, ::airpound_tick, ::airpound_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("ground_vul", ::groundvul_begin, ::groundvul_tick, ::groundvul_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("drop_move", ::dropmove_begin, ::dropmove_tick, ::dropmove_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("fly_over", ::flyover_begin, ::flyover_tick, ::flyover_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("teleport", ::teleport_begin, ::teleport_tick, ::teleport_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("death", ::death_begin, ::death_tick, ::death_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("simple_setup", ::simplesetup_begin, ::simplesetup_tick, ::simplesetup_end);
  scripts\aitypes\dlc4\bt_action_api::setupbtaction("eclipse", ::eclipse_begin, ::eclipse_tick, ::eclipse_end);
}

setupblackboard() {
  self._blackboard.var_4BF7 = undefined;
  self._blackboard.desirednode = undefined;
  self._blackboard.previousposition = undefined;
  self._blackboard.currentmovedirindex = 5;
  self._blackboard.nodestomove = 0;
  self._blackboard.movereadyforarrival = 0;
  self._blackboard.smoothmotion = 0;
  self._blackboard.facecenter = 0;
  self._blackboard.fastmovement = 0;
  self._blackboard.lookaheadorigin = undefined;
  self._blackboard.lookaheadcurrnode = undefined;
  self._blackboard.lookaheadnextnode = undefined;
  self._blackboard.strafeaction = "none";
  self._blackboard.groundpoundstate = 0;
  self._blackboard.painnotifytime = 0;
}

setupnodes() {
  self.arenacenter = scripts\engine\utility::getstruct("arena_center", "targetname").origin;
  var_0 = [];
  var_1 = scripts\engine\utility::getstruct("boss_path", "script_noteworthy");
  var_2 = var_1.var_336;
  for(;;) {
    var_1.var_1E75 = vectornormalize(self.arenacenter - var_1.origin * (1, 1, 0));
    var_0[var_0.size] = var_1;
    var_1 = scripts\engine\utility::getstruct(var_1.target, "targetname");
    if(var_1.var_336 == var_2) {
      break;
    }
  }

  self._blackboard.nodes = var_0;
}

setupactions() {
  self.bossactions = [];
  self.bossactionsstruct = [];
  self.weightcopies = [];
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = spawnStruct();
  var_1.name = "fireball";
  var_1.dofunc = ::fireball;
  var_1.canfunc = ::canfireball;
  var_1.weight = var_0.fireball_weight;
  var_1.var_11910 = 0;
  var_1.cooldowntime = var_0.fireball_cooldown_time;
  self.bossactions[self.bossactions.size] = var_1;
  self.bossactionsstruct[var_1.name] = var_1;
  var_2 = spawnStruct();
  var_2.name = "clap";
  var_2.dofunc = ::clap;
  var_2.canfunc = ::canclap;
  var_2.weight = var_0.clap_weight;
  var_2.var_11910 = 0;
  var_2.cooldowntime = var_0.clap_cooldown_time;
  self.bossactions[self.bossactions.size] = var_2;
  self.bossactionsstruct[var_2.name] = var_2;
  var_3 = spawnStruct();
  var_3.name = "throw";
  var_3.dofunc = ::
    throw;
  var_3.canfunc = ::canthrow;
  var_3.weight = var_0.throw_weight;
  var_3.var_11910 = 0;
  var_3.cooldowntime = var_0.throw_cooldown_time;
  self.bossactions[self.bossactions.size] = var_3;
  self.bossactionsstruct[var_3.name] = var_3;
  var_4 = spawnStruct();
  var_4.name = "tornado";
  var_4.dofunc = ::tornado;
  var_4.canfunc = ::cantornado;
  var_4.weight = var_0.tornado_weight;
  var_4.var_11910 = 0;
  var_4.cooldowntime = var_0.tornado_cooldown_time;
  self.bossactions[self.bossactions.size] = var_4;
  self.bossactionsstruct[var_4.name] = var_4;
  var_5 = spawnStruct();
  var_5.name = "summon";
  var_5.dofunc = ::summon;
  var_5.canfunc = ::cansummon;
  var_5.weight = var_0.summon_weight;
  var_5.var_11910 = 0;
  var_5.cooldowntime = var_0.summon_cooldown_time;
  self.bossactions[self.bossactions.size] = var_5;
  self.bossactionsstruct[var_5.name] = var_5;
  var_6 = spawnStruct();
  var_6.name = "move_left";
  var_6.dofunc = ::moveleft;
  var_6.canfunc = ::canmoveleft;
  var_6.weight = var_0.move_left_weight;
  var_6.var_11910 = 0;
  var_6.cooldowntime = var_0.move_left_cooldown_time;
  self.bossactions[self.bossactions.size] = var_6;
  self.bossactionsstruct[var_6.name] = var_6;
  var_7 = spawnStruct();
  var_7.name = "move_right";
  var_7.dofunc = ::moveright;
  var_7.canfunc = ::canmoveright;
  var_7.weight = var_0.move_right_weight;
  var_7.var_11910 = 0;
  var_7.cooldowntime = var_0.move_right_cooldown_time;
  self.bossactions[self.bossactions.size] = var_7;
  self.bossactionsstruct[var_7.name] = var_7;
  var_8 = spawnStruct();
  var_8.name = "temp_idle";
  var_8.dofunc = ::tempidle;
  var_8.canfunc = ::canidle;
  var_8.weight = var_0.idle_weight;
  var_8.var_11910 = 0;
  var_8.cooldowntime = var_0.temp_idle_cooldown_time;
  self.bossactions[self.bossactions.size] = var_8;
  self.bossactionsstruct[var_8.name] = var_8;
  var_9 = spawnStruct();
  var_9.name = "move_fireball_left";
  var_9.dofunc = ::movefireballleft;
  var_9.canfunc = ::canmovefireballleft;
  var_9.weight = var_0.move_fireball_left_weight;
  var_9.var_11910 = 0;
  var_9.cooldowntime = var_0.move_fireball_left_cooldown_time;
  self.bossactions[self.bossactions.size] = var_9;
  self.bossactionsstruct[var_9.name] = var_9;
  var_0A = spawnStruct();
  var_0A.name = "move_fireball_right";
  var_0A.dofunc = ::movefireballright;
  var_0A.canfunc = ::canmovefireballright;
  var_0A.weight = var_0.move_fireball_right_weight;
  var_0A.var_11910 = 0;
  var_0A.cooldowntime = var_0.move_fireball_right_cooldown_time;
  self.bossactions[self.bossactions.size] = var_0A;
  self.bossactionsstruct[var_0A.name] = var_0A;
  var_0B = spawnStruct();
  var_0B.name = "air_pound";
  var_0B.dofunc = ::airpound;
  var_0B.canfunc = ::canairpound;
  var_0B.weight = var_0.air_pound_weight;
  var_0B.var_11910 = 0;
  var_0B.cooldowntime = var_0.air_pound_cooldown_time;
  self.bossactions[self.bossactions.size] = var_0B;
  self.bossactionsstruct[var_0B.name] = var_0B;
  var_0C = spawnStruct();
  var_0C.name = "ground_vul";
  var_0C.dofunc = ::groundvul;
  var_0C.canfunc = ::cangroundvul;
  var_0C.weight = 0;
  var_0C.var_11910 = 0;
  var_0C.cooldowntime = 0;
  self.bossactions[self.bossactions.size] = var_0C;
  self.bossactionsstruct[var_0C.name] = var_0C;
  var_0D = spawnStruct();
  var_0D.name = "drop_move";
  var_0D.dofunc = ::dropmove;
  var_0D.canfunc = ::candropmove;
  var_0D.weight = var_0.drop_move_weight;
  var_0D.var_11910 = 0;
  var_0D.cooldowntime = var_0.drop_move_cooldown_time;
  self.bossactions[self.bossactions.size] = var_0D;
  self.bossactionsstruct[var_0D.name] = var_0D;
  var_0E = spawnStruct();
  var_0E.name = "fly_over";
  var_0E.dofunc = ::flyover;
  var_0E.canfunc = ::canflyover;
  var_0E.weight = var_0.fly_over_weight;
  var_0E.var_11910 = 0;
  var_0E.cooldowntime = var_0.fly_over_cooldown_time;
  self.bossactions[self.bossactions.size] = var_0E;
  self.bossactionsstruct[var_0E.name] = var_0E;
  var_0F = spawnStruct();
  var_0F.name = "black_hole";
  var_0F.dofunc = ::func_2B2F;
  var_0F.canfunc = ::canblackhole;
  var_0F.weight = var_0.black_hole_weight;
  var_0F.var_11910 = 0;
  var_0F.cooldowntime = var_0.black_hole_cooldown_time;
  self.bossactions[self.bossactions.size] = var_0F;
  self.bossactionsstruct[var_0F.name] = var_0F;
  var_10 = spawnStruct();
  var_10.name = "eclipse";
  var_10.dofunc = ::eclipse;
  var_10.canfunc = ::caneclipse;
  var_10.weight = 0;
  var_10.var_11910 = 0;
  var_10.cooldowntime = 0;
  self.bossactions[self.bossactions.size] = var_10;
  self.bossactionsstruct[var_10.name] = var_10;
  var_11 = spawnStruct();
  var_11.name = "taunt";
  var_11.dofunc = ::taunt;
  var_11.canfunc = ::cantaunt;
  var_11.weight = 0;
  var_11.var_11910 = 0;
  var_11.cooldowntime = 0;
  self.bossactions[self.bossactions.size] = var_11;
  self.bossactionsstruct[var_11.name] = var_11;
}

entrance_begin(var_0) {
  self.introfinished = 0;
  self ghostskulls_total_waves(100000);
  self clearpath();
  self._blackboard.desirednode = 0;
  self._blackboard.smoothmotion = 0;
  self._blackboard.facecenter = 0;
  self.bt.instancedata[var_0] = spawnStruct();
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "entrance", "move_back_arrival", undefined, undefined, undefined, 2000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "entrance");
  moveaction_internalsetup(var_0);
}

entrance_tick(var_0) {
  var_1 = self._blackboard;
  var_2 = distance(self.origin, var_1.previousposition);
  var_3 = self.traversallength;
  if(!var_1.movereadyforarrival) {
    if(var_2 + var_1.movearrivaldist >= var_3) {
      var_1.movereadyforarrival = 1;
    }
  } else {
    if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
      self._blackboard.var_4BF7 = self._blackboard.desirednode;
      return level.running;
    }

    return level.success;
  }

  return level.running;
}

entrance_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.lookaheadorigin = self.origin;
  self.introfinished = 1;
  self.automaticspawn = 1;
}

updateeveryframe(var_0) {
  scripts\aitypes\dlc4\behavior_utils::updateenemy();
  updatetimers();
  self._blackboard.painnotifytime = max(self._blackboard.painnotifytime - 50, 0);
  return level.failure;
}

updatetimers(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(isDefined(self.bossactions)) {
    foreach(var_3 in self.bossactions) {
      var_3.var_11910 = max(var_3.var_11910 - 50, 0);
    }
  }

  self.passivetimer = max(self.passivetimer - 50, 0);
  self.specialactiontimer = max(self.specialactiontimer - 50, 0);
  if(isDefined(level.meph_battle_over)) {
    return;
  }

  self.automaticspawntimer = max(self.automaticspawntimer - 50, 0);
  if(self.automaticspawntimer == 0 && self.automaticspawn) {
    self.automaticspawntimer = var_1.automatic_spawn_time;
    var_6 = scripts\mp\mp_agent::getactiveagentsoftype("skeleton");
    if(var_6.size < int(max(var_1.automatic_spawn_cap, level.players.size))) {
      computespawnpoints(1, var_6);
      scripts\asm\dlc4_boss\dlc4_boss_asm::summonskeletons();
    }
  }
}

taunt(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "taunt");
}

fireball(var_0) {
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "fireball");
}

clap(var_0) {
  if(self.forcingaction) {
    restoreweights();
  }

  self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
  scripts\asm\dlc4_boss\dlc4_boss_asm::facearenacenter();
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "clap");
}

throw (var_0) {
  if(self.forcingaction) {
    restoreweights();
  }

  self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "throw");
}

tornado(var_0) {
  if(self.forcingaction) {
    restoreweights();
  }

  self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "tornado");
}

teleporttonode(var_0) {
  var_1 = self._blackboard.nodes.size;
  self._blackboard.desirednode = self._blackboard.var_4BF7 + randomint(var_1 - 1) + 1 % var_1;
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "teleport");
}

groundpound(var_0) {
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "ground_pound");
}

summon(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_2 = scripts\mp\mp_agent::getactiveagentsoftype(var_1.summon_agent_type);
  var_3 = var_1.summon_min_spawn_num["" + level.players.size];
  var_4 = var_1.summon_max_spawn_num["" + level.players.size];
  var_5 = var_1.summon_max_total["" + level.players.size];
  var_6 = min(randomintrange(var_3, var_4), var_5 - var_2.size);
  computespawnpoints(var_6, var_2);
  scripts\aitypes\dlc4\simple_action::dosimpleaction_immediate(var_0, "summon");
}

moveleft(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = randomintrange(var_1.min_move_nodes, var_1.max_move_nodes + 1);
  self.passivetimer = var_1.passive_cooldown;
  self._blackboard.currentmovedirindex = 4;
  self._blackboard.desirednode = self._blackboard.var_4BF7 + 1 % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "none";
  self._blackboard.smoothmotion = 1;
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

moveright(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = randomintrange(var_1.min_move_nodes, var_1.max_move_nodes + 1);
  self.passivetimer = var_1.passive_cooldown;
  self._blackboard.currentmovedirindex = 6;
  self._blackboard.desirednode = self._blackboard.var_4BF7 - 1 + self._blackboard.nodes.size % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "none";
  self._blackboard.smoothmotion = 1;
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

tempidle(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.passivetimer = var_1.passive_cooldown;
  self.timers.idletimer = randomfloatrange(var_1.min_idle_time, var_1.max_idle_time);
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "temp_idle");
}

movefireballleft(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = var_1.strafe_move_nodes;
  self._blackboard.currentmovedirindex = 4;
  self._blackboard.desirednode = self._blackboard.var_4BF7 + 1 % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "fireball";
  self._blackboard.smoothmotion = 1;
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

movefireballright(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = var_1.strafe_move_nodes;
  self._blackboard.currentmovedirindex = 6;
  self._blackboard.desirednode = self._blackboard.var_4BF7 - 1 + self._blackboard.nodes.size % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "fireball";
  self._blackboard.smoothmotion = 1;
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

moveclapleft(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = var_1.strafe_move_nodes;
  self._blackboard.currentmovedirindex = 4;
  self._blackboard.desirednode = self._blackboard.var_4BF7 + 1 % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "clap";
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

moveclapright(var_0) {
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self._blackboard.nodestomove = var_1.strafe_move_nodes;
  self._blackboard.currentmovedirindex = 6;
  self._blackboard.desirednode = self._blackboard.var_4BF7 - 1 + self._blackboard.nodes.size % self._blackboard.nodes.size;
  self._blackboard.strafeaction = "clap";
  self._blackboard.facecenter = 1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "move_action");
}

airpound(var_0) {
  if(self.forcingaction) {
    restoreweights();
  }

  self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown + 5;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "air_pound");
}

groundvul(var_0) {
  restoreweights();
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "ground_vul");
}

dropmove(var_0) {
  var_1 = self._blackboard.nodes.size;
  self._blackboard.desirednode = self._blackboard.var_4BF7 + randomint(var_1 - 5) + 3 % var_1;
  self.passivetimer = scripts\asm\dlc4\dlc4_asm::gettunedata().passive_cooldown;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "drop_move");
}

flyover(var_0) {
  if(self.forcingaction) {
    restoreweights();
  }

  self.specialactiontimer = scripts\asm\dlc4\dlc4_asm::gettunedata().special_cooldown;
  var_1 = self._blackboard;
  var_1.desirednode = var_1.var_4BF7 + scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_nodes_travelled % var_1.nodes.size;
  scripts\asm\dlc4_boss\dlc4_boss_asm::facedesirednode();
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "fly_over");
}

func_2B2F(var_0) {
  scripts\asm\dlc4_boss\dlc4_boss_asm::facearenacenter();
  self.simplesetupstartstate = "black_hole";
  self.simplesetupendstate = "black_hole_end";
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "simple_setup");
}

death(var_0) {
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "death");
}

eclipse(var_0) {
  restoreweights();
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "eclipse");
}

cooldownfinished(var_0) {
  if(!isDefined(self.bossactions)) {
    return 0;
  }

  foreach(var_2 in self.bossactions) {
    if(var_2.name == var_0) {
      return var_2.var_11910 <= 0;
    }
  }

  return 1;
}

canfireball() {
  var_0 = undefined;
  var_1 = scripts\asm\dlc4_boss\dlc4_boss_asm::getspecialenemy();
  var_0 = self.arenacenter;
  if(isDefined(var_1)) {
    var_0 = var_1.origin;
  }

  var_2 = scripts\common\trace::create_default_contents(1);
  var_3 = scripts\common\trace::sphere_trace_passed(self.origin + (0, 0, 250), var_0 + (0, 0, 12), 10, undefined, var_2);
  if(var_3) {
    self.fireballtargetpos = var_0;
    return 1;
  }

  return 0;
}

canclap() {
  if(self.specialactiontimer > 0) {
    return 0;
  }

  if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 10000) {
    return 0;
  }

  if(level.fbd.bossstate == "MAIN" && self.soulhealth <= 1) {
    return 0;
  }

  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = anglesToForward(self.angles);
  var_2 = var_0.staff_projectile_speed * var_0.staff_projectile_interval;
  var_3 = var_2 / 2;
  var_4 = self.origin + var_1 * var_3;
  var_5 = var_4 + var_1 * var_0.staff_projectile_range;
  var_6 = scripts\common\trace::create_default_contents(1);
  var_7 = scripts\common\trace::ray_trace_passed(var_4 + (0, 0, 250), var_5 + (0, 0, 250), undefined, var_6);
  return var_7;
}

canthrow() {
  if(self.specialactiontimer > 0) {
    return 0;
  }

  return 1;
}

cantornado() {
  if(self.specialactiontimer > 0) {
    return 0;
  }

  return 1;
}

canteleport() {
  return 1;
}

cangroundpound() {
  return 1;
}

cansummon() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = scripts\mp\mp_agent::getactiveagentsoftype(var_0.summon_agent_type);
  return var_1.size <= var_0.summon_min_zombies_before_active;
}

canmoveleft() {
  if(self.passivetimer > 0) {
    return 0;
  }

  return 1;
}

canmoveright() {
  if(self.passivetimer > 0) {
    return 0;
  }

  return 1;
}

canidle() {
  return 1;
}

canmovefireballleft() {
  return 1;
}

canmovefireballright() {
  return 1;
}

canmoveclapleft() {
  return 1;
}

canmoveclapright() {
  return 1;
}

canairpound() {
  if(self.specialactiontimer > 0) {
    return 0;
  }

  if(self.claponarena) {
    return 0;
  }

  if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000) {
    return 0;
  }

  return 1;
}

cangroundvul() {
  return 1;
}

candropmove() {
  if(self.passivetimer > 0) {
    return 0;
  }

  if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000) {
    return 0;
  }

  return 1;
}

canflyover() {
  if(self.specialactiontimer > 0) {
    return 0;
  }

  if(level.fbd.bossstate == "FRENZIED" && self.frenziedhealth < 100000) {
    return 0;
  }

  var_0 = self._blackboard;
  var_1 = var_0.var_4BF7 + scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_nodes_travelled % var_0.nodes.size;
  var_2 = var_0.nodes[var_1].origin;
  var_3 = scripts\common\trace::create_default_contents(1);
  var_4 = scripts\common\trace::ray_trace_passed(self.origin + (0, 0, 250), var_2 + (0, 0, 250), undefined, var_3);
  return var_4;
}

canblackhole() {
  return 1;
}

caneclipse() {
  return 1;
}

cantaunt() {
  return 1;
}

decideaction(var_0) {
  self.terminateaction = 0;
  if(isDefined(self.desiredaction)) {
    return level.success;
  }

  if(isDefined(self.nextaction)) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, self.nextaction);
    self.nextaction = undefined;
    return level.success;
  }

  if(isDefined(level.meph_battle_over)) {
    scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "debug_handler");
    return level.success;
  }

  var_1 = pickrandomvalidaction(var_0);
  return scripts\engine\utility::ter_op(var_1, level.success, level.failure);
}

pickrandomvalidaction(var_0) {
  var_1 = [];
  var_2 = 0;
  foreach(var_4 in self.bossactions) {
    if(cooldownfinished(var_4.name) && [
        [var_4.canfunc]
      ]()) {
      var_1[var_1.size] = var_4;
      var_2 = var_2 + var_4.weight;
      continue;
    }
  }

  if(var_2 == 0) {
    return 0;
  }

  var_6 = randomfloat(var_2);
  foreach(var_4 in var_1) {
    var_6 = var_6 - var_4.weight;
    if(var_6 <= 0) {
      [
        [var_4.dofunc]
      ](var_0);
      resettimer(var_4.name, var_4.cooldowntime);
      return 1;
    }
  }

  return 0;
}

moveaction_begin(var_0) {
  self ghostskulls_total_waves(100000);
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  self setscriptablepartstate("flame_trail", "on");
  var_1 = self._blackboard;
  var_1.lookaheadorigin = var_1.nodes[var_1.desirednode].origin;
  var_1.lookaheadcurrnode = var_1.var_4BF7;
  var_1.lookaheadnextnode = var_1.desirednode;
  moveaction_internalsetup(var_0);
  func_F8A3(var_0, "move");
}

moveaction_internalsetup(var_0) {
  var_1 = self._blackboard;
  var_1.previousposition = self.origin;
  var_1.movereadyforarrival = 0;
  self.traversallength = distance(var_1.previousposition, var_1.nodes[var_1.desirednode].origin);
}

moveaction_tick(var_0) {
  var_1 = self._blackboard;
  var_2 = distance(self.origin, var_1.previousposition);
  var_3 = self.traversallength;
  if(scripts\asm\dlc4_boss\dlc4_boss_asm::shouldterminateaction()) {
    return level.success;
  }

  if(var_1.nodestomove > 1) {
    if(var_2 >= var_3) {
      var_1.var_4BF7 = var_1.desirednode;
      var_1.nodestomove--;
      if(var_1.currentmovedirindex == 4) {
        var_1.desirednode = var_1.var_4BF7 + 1 % var_1.nodes.size;
      } else {
        var_1.desirednode = var_1.var_4BF7 - 1 + var_1.nodes.size % var_1.nodes.size;
      }

      moveaction_internalsetup(var_0);
      var_1.desireddir = vectornormalize(var_1.nodes[var_1.desirednode].origin - self.origin);
    }
  } else if(var_1.nodestomove == 1) {
    if(var_2 + var_1.movearrivaldist >= var_3) {
      var_1.nodestomove--;
      var_1.movereadyforarrival = 1;
    }
  } else if(scripts\asm\asm::asm_ephemeraleventfired("move_arrival", "end")) {
    var_1.var_4BF7 = var_1.desirednode;
    return level.success;
  }

  return level.running;
}

moveaction_end(var_0) {
  self setscriptablepartstate("flame_trail", "off");
  cleanup("move");
  self.traversallength = undefined;
  var_1 = self._blackboard;
  var_1.var_4BF7 = var_1.desirednode;
}

tempidle_begin(var_0) {
  self ghostskulls_total_waves(100000);
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  func_F8A3(var_0, "temp_idle");
}

tempidle_tick(var_0) {
  if(scripts\asm\dlc4\dlc4_asm::checkpainnotify()) {
    return level.failure;
  }

  if(self.timers.idletimer <= 0) {
    return level.success;
  }

  self.timers.idletimer = self.timers.idletimer - 50;
  return level.running;
}

tempidle_end(var_0) {
  self.timers.idletimer = 0;
  cleanup("temp_idle");
}

groundpound_begin(var_0) {
  func_F8A3(var_0, "ground_pound");
  self._blackboard.desirednode = self._blackboard.var_4BF7;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "ground_pound", "ground_pound_launch", undefined, undefined, undefined, 2000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "ground_pound");
}

groundpound_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

groundpound_end(var_0) {
  cleanup("ground_pound");
}

airpound_begin(var_0) {
  func_F8A3(var_0, "air_pound");
  self._blackboard.desirednode = self._blackboard.var_4BF7;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "air_pound", "air_pound_teleport_finish", undefined, undefined, undefined, 2000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "air_pound");
  self.interruptable = 0;
}

airpound_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

airpound_end(var_0) {
  cleanup("air_pound");
  self.interruptable = 1;
}

groundvul_begin(var_0) {
  func_F8A3(var_0, "ground_vul");
  self._blackboard.desirednode = self._blackboard.var_4BF7;
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "ground_vul", "ground_vul_finish", undefined, undefined, undefined, 2000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "ground_vul");
  self setscriptablepartstate("flames", "off");
  self.doinggroundvul = 1;
  self.teleportedin = 0;
  self.var_FCA5 = 0;
  if(level.fbd.bossstate == "MAIN") {
    thread scripts\cp\maps\cp_final\cp_final_final_boss::setupweakspot(level.fbd.activecircle);
  }
}

groundvul_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

groundvul_end(var_0) {
  cleanup("ground_vul");
  self.doinggroundvul = 0;
  resetsoulhealth();
  self.var_FCA5 = 1;
  if(isDefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete) {
    if(level.fbd.bossstate == "MAIN") {
      setnextaction("eclipse");
    } else if(level.fbd.bossstate == "FRENZIED") {
      setupfrenziedmode();
      self.var_FCA5 = 0;
    }

    level.fbd.sectioncomplete = 0;
  }
}

setupfrenziedmode() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.frenziedhealth = var_0.frenzied_health;
  self.cantakedamage = 1;
  self.automaticspawn = 0;
  thread frenzyspawnmonitor();
  thread frenzyarmageddonmonitor();
  var_1 = self.bossactionsstruct;
  var_1["temp_idle"].weight = var_0.frenzied_idle_weight;
  var_1["move_left"].weight = var_0.frenzied_move_weight;
  var_1["move_right"].weight = var_0.frenzied_move_weight;
  var_1["drop_move"].weight = var_0.frenzied_drop_move_weight;
  var_1["fireball"].weight = var_0.frenzied_fireball_weight;
  var_1["move_fireball_left"].weight = var_0.frenzied_move_fireball_weight;
  var_1["move_fireball_right"].weight = var_0.frenzied_move_fireball_weight;
  var_1["black_hole"].weight = var_0.frenzied_black_hole_weight;
  var_1["fly_over"].weight = var_0.frenzied_fly_over_weight;
  var_1["summon"].weight = var_0.frenzied_summon_weight;
  foreach(var_3 in self.unlockedactions) {
    var_1[var_3].weight = var_0.frenzied_special_weight;
  }

  thread frenzydamagecap();
  thread scripts\cp\maps\cp_final\cp_final_final_boss::frenzyprogressmonitor();
}

frenzyspawnmonitor() {
  self endon("last_stand");
  self endon("death");
  level endon("STOP_FRENZY_SPAWN");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = var_0.frenzied_summon_wave_period;
  var_2 = var_0.frenzied_summon_start_wave;
  var_3 = var_0.frenzied_summon_number;
  var_4 = var_3;
  var_5 = [];
  foreach(var_7 in var_0.frenzied_summon_agents) {
    var_5[var_7] = 0;
  }

  for(;;) {
    var_9 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
    var_9 = scripts\engine\utility::array_remove(var_9, level.dlc4_boss);
    if(var_9.size < var_4 || var_9.size < level.players.size) {
      var_0A = [];
      var_0B = [];
      for(var_0C = 0; var_0C < int(min(var_2, var_0.frenzied_summon_agents.size)); var_0C++) {
        var_7 = var_0.frenzied_summon_agents[var_0C];
        if(var_5[var_7] == 0) {
          var_0A[var_0A.size] = var_7;
          var_0B[var_0B.size] = var_0.frenzied_summon_data[var_7][0];
          if(var_0B.size > 1) {
            var_0B[var_0B.size - 1] = var_0B[var_0B.size - 1] + var_0B[var_0B.size - 2];
          }
        }
      }

      var_7 = scripts\engine\utility::choose_from_weighted_array(var_0A, var_0B);
      if(!computespawnpoints(1, var_9)) {
        wait(0.05);
        continue;
      }

      scripts\asm\dlc4_boss\dlc4_boss_asm::spawnzombie(var_7, var_0.spawnpoints[0]);
      var_5[var_7] = var_5[var_7] + var_0.frenzied_summon_data[var_7][1];
      var_4 = max(var_4 - 1, 0);
      foreach(var_7 in var_0.frenzied_summon_agents) {
        var_5[var_7] = max(var_5[var_7] - 1, 0);
      }
    }

    var_0F = randomfloatrange(var_0.frenzied_summon_min_interval, var_0.frenzied_summon_max_interval);
    wait(var_0F);
    var_1 = var_1 - var_0F * 1000;
    if(var_1 <= 0) {
      var_1 = var_0.frenzied_summon_wave_period;
      var_2 = var_2 + 1;
      var_3 = var_3 + var_0.frenzied_summon_increase_per_wave;
      var_4 = var_4 + var_3;
      self.maxdamagecap = self.maxdamagecap + var_0.frenzied_damage_cap_wave_increase;
    }
  }
}

frenzyarmageddonmonitor() {
  self endon("last_stand");
  self endon("death");
  self endon("STOP_FRENZY_ARMAGEDDON");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  for(;;) {
    if(level.fbd.bossstate == "LAST_STAND") {
      break;
    }

    var_1 = pow(1 * var_0.frenzied_meteor_target_min_radius / var_0.frenzied_meteor_target_radius, 2);
    var_2 = sqrt(randomfloat(1 - var_1) + var_1) * var_0.frenzied_meteor_target_radius;
    var_3 = randomfloat(360);
    var_4 = self.arenacenter[0] + var_2 * cos(var_3);
    var_5 = self.arenacenter[1] + var_2 * sin(var_3);
    var_6 = (var_4, var_5, self.arenacenter[2]);
    magicbullet("iw7_dlc4eclipse_mp", (-17910.3, 966.038, 5116), var_6);
    wait(randomfloatrange(var_0.frenzied_meteor_min_period, var_0.frenzied_meteor_max_period));
  }
}

frenzydamagecap() {
  self endon("death");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = var_0.frenzied_damage_cap_time;
  for(;;) {
    self.damagecap = self.maxdamagecap;
    wait(var_1);
  }
}

dropmove_begin(var_0) {
  func_F8A3(var_0, "drop_move");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "drop_move", "drop_move_arrival", undefined, undefined, undefined, 2000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "drop_move");
  self playSound("final_meph_eclipse");
  self.interruptable = 0;
}

dropmove_tick(var_0) {
  self clearpath();
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

dropmove_end(var_0) {
  cleanup("drop_move");
  self.interruptable = 1;
}

computespawnpoints(var_0, var_1) {
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = getrandomnavpoints(self.arenacenter, var_2.summon_max_radius, 32);
  var_2.spawnpoints = [];
  for(var_4 = 0; var_4 < 10; var_4++) {
    foreach(var_6 in var_3) {
      if(pointnearanyplayer(var_6, var_2.summon_min_dist_from_player)) {
        continue;
      }

      if(isnearanypointinarray(var_6, var_2.spawnpoints, var_2.summon_min_radius)) {
        continue;
      }

      if(isnearagents(var_6, var_1, var_2.summon_min_radius)) {
        continue;
      }

      var_2.spawnpoints[var_2.spawnpoints.size] = var_6;
      if(var_2.spawnpoints.size >= var_0) {
        return 1;
      }
    }
  }

  return var_2.spawnpoints.size > 0;
}

flyover_begin(var_0) {
  var_1 = self getsafecircleorigin("fly_over_arrival", 0);
  self._blackboard.flyoverarrivaldist = length2d(getmovedelta(var_1, 0, 1)) * scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_speed;
  func_F8A3(var_0, "fly_over");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "fly_over", "fly_over_arrival", undefined, undefined, undefined, 10000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "fly_over");
  thread stop_flame_trail(3.5);
  self.interruptable = 0;
}

stop_flame_trail(var_0) {
  wait(1);
  self setscriptablepartstate("flame_trail", "on");
  wait(var_0);
  self setscriptablepartstate("flame_trail", "off");
}

flyover_tick(var_0) {
  return scripts\engine\utility::ter_op(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0), level.running, level.success);
}

flyover_end(var_0) {
  self._blackboard.var_4BF7 = self._blackboard.desirednode;
  cleanup("fly_over");
  self.interruptable = 1;
}

teleport_begin(var_0) {
  func_F8A3(var_0, "teleport");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "teleport", "teleport_out", undefined, undefined, undefined, 10000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "teleport");
}

teleport_tick(var_0) {
  return scripts\engine\utility::ter_op(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0), level.running, level.success);
}

teleport_end(var_0) {
  cleanup("teleport");
}

death_begin(var_0) {
  func_F8A3(var_0, "death");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "death", "death_death", undefined, undefined, undefined, 10000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "death");
}

death_tick(var_0) {
  return scripts\engine\utility::ter_op(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0), level.running, level.success);
}

death_end(var_0) {
  cleanup("death");
}

eclipse_begin(var_0) {
  level.specialroundcounter = 3;
  if(level.players.size >= 3) {
    level.specialroundcounter = 5;
  }

  func_F8A3(var_0, "eclipse");
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, "eclipse", "eclipse", undefined, undefined, undefined, 10000000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, "eclipse");
  self.eclipseanimfinished = 0;
}

eclipse_tick(var_0) {
  if(!scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    self.eclipseanimfinished = 1;
  }

  return scripts\engine\utility::ter_op(self.eclipseanimfinished && !self.eclipseactive, level.success, level.running);
}

eclipse_end(var_0) {
  cleanup("eclipse");
  self.eclipseanimfinished = undefined;
  scripts\cp\maps\cp_final\cp_final_final_boss::setupfornextwave();
  setnextaction(self.unlockedactions[self.unlockedactions.size - 1]);
  self.automaticspawn = 1;
}

clearweights() {
  if(!isDefined(self.bossactions)) {
    return;
  }

  foreach(var_1 in self.bossactions) {
    var_1.weight = 0;
  }
}

setweight(var_0, var_1) {
  if(!isDefined(self.bossactions)) {
    return;
  }

  foreach(var_3 in self.bossactions) {
    if(var_3.name == var_0) {
      var_3.weight = var_1;
    }
  }
}

updateweights() {
  clearweights();
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = self.unlockedactions.size;
  var_2 = self.bossactionsstruct;
  var_2["move_left"].weight = var_0.move_base_weight / 2 + var_1 * var_0.move_stage_multiplier;
  var_2["move_right"].weight = var_2["move_left"].weight;
  var_2["temp_idle"].weight = var_0.idle_base_weight + var_1 * var_0.idle_stage_multiplier;
  var_2["drop_move"].weight = var_0.drop_move_base_weight + var_1 * var_0.drop_move_stage_multiplier;
  var_2["fireball"].weight = var_0.fireball_base_weight + var_1 * var_0.fireball_stage_multiplier;
  var_2["move_fireball_left"].weight = var_0.move_fireball_base_weight / 2 + var_1 * var_0.move_fireball_stage_multiplier;
  var_2["move_fireball_right"].weight = var_2["move_fireball_left"].weight;
  var_2["summon"].weight = var_0.summon_base_weight + var_1 * var_0.summon_stage_multiplier;
  var_3 = var_0.black_hole_base_weight;
  var_3 = var_3 + var_1 * var_0.black_hole_stage_multiplier;
  var_3 = var_3 + level.fbd.numplayerschargingcircle * var_0.black_hole_charge_multiplier;
  var_2["black_hole"].weight = var_3;
  var_2["fly_over"].weight = var_0.fly_over_base_weight + var_1 * var_0.fly_over_stage_multiplier;
  foreach(var_5 in self.unlockedactions) {
    var_2[var_5].weight = var_0.special_base_weight + var_1 * var_0.special_stage_multiplier;
  }
}

setnextaction(var_0) {
  foreach(var_2 in self.bossactions) {
    self.weightcopies[var_2.name] = var_2.weight;
    var_2.weight = 0;
    if(var_2.name == var_0) {
      var_2.weight = 1;
    }
  }

  self.forcingaction = 1;
}

restoreweights() {
  foreach(var_1 in self.bossactions) {
    var_1.weight = self.weightcopies[var_1.name];
  }

  self.forcingaction = 0;
}

func_593B() {}

func_F8A3(var_0, var_1) {
  self ghostskulls_total_waves(100000000);
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::setasmaction(var_1);
}

cleanup(var_0) {
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  self notify(var_0 + "_done");
}

pointnearanyplayer(var_0, var_1) {
  var_2 = var_1 * var_1;
  foreach(var_4 in level.players) {
    if(!isalive(var_4)) {
      continue;
    }

    if(var_4.ignoreme || isDefined(var_4.triggerportableradarping) && var_4.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_4)) {
      continue;
    }

    if(distancesquared(var_0, var_4.origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

isnearanypointinarray(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

isnearagents(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4.origin, var_0);
    if(var_5 < var_2) {
      return 1;
    }
  }

  return 0;
}

resettimer(var_0, var_1) {
  if(!isDefined(self.bossactions)) {
    return 0;
  }

  foreach(var_3 in self.bossactions) {
    if(var_3.name == var_0) {
      var_3.var_11910 = var_1;
      return 1;
    }
  }

  return 0;
}

simplesetup_begin(var_0) {
  func_F8A3(var_0, self.simplesetupstartstate);
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, self.simplesetupstartstate, self.simplesetupendstate, undefined, undefined, undefined, 100000);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, self.simplesetupstartstate);
}

simplesetup_tick(var_0) {
  if(scripts\asm\dlc4_boss\dlc4_boss_asm::shouldterminateaction()) {
    return level.success;
  }

  return scripts\engine\utility::ter_op(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0), level.running, level.success);
}

simplesetup_end(var_0) {
  cleanup(self.simplesetupstartstate);
}

resetsoulhealth(var_0) {
  self.soulhealth = ceil(scripts\asm\dlc4\dlc4_asm::gettunedata().max_soul_health * level.players.size * pow(0.9, level.players.size - 1));
}