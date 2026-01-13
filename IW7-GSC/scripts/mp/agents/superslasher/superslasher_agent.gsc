/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\superslasher\superslasher_agent.gsc
*****************************************************************/

superslasheragentinit() {
  registerscriptedagent();
}

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\superslasher::func_DEE8();
  scripts\asm\superslasher\mp\states::func_2371();
  thread func_FAB0();
  level.superslasherspawnspot = (-4803, 4703, -130);
  level.superslasherspawnangles = (0, -170, 0);
  level.superslasherrooftopspot = (-6119, 4829, 355);
  level.superslasherrooftopangles = (0, 10, 0);
  level.superslashergotogroundspot = (-5024, 4857, -130);
  level.superslasherjumptoroofangles = (0, -170, 0);
  loadsuperslasherscriptmodelanim();
  loadsuperslashervfx();
}

loadsuperslasherscriptmodelanim() {
  precachempanim("IW7_cp_super_death_01");
}

loadsuperslashervfx() {
  level._effect["super_slasher_death_base"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_ss_death_base_start.vfx");
  level._effect["super_slasher_death_hand"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_ss_death_hands_glow.vfx");
  level._effect["super_slasher_death_limb"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_ss_death_limbs_glow.vfx");
  level._effect["super_slasher_shield_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_ss_shield_hit.vfx");
  level._effect["super_slasher_saw_shark_hit"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_stomp_attack.vfx");
  level._effect["super_slasher_saw_shark_spark"] = loadfx("vfx\iw7\levels\cp_rave\superslasher\vfx_rave_superslasher_saw_spark.vfx");
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.species_funcs["superslasher"] = [];
  level.agent_definition["superslasher"]["setup_func"] = ::setupagent;
  level.agent_definition["superslasher"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["superslasher"] = [];
  level.agent_funcs["superslasher"]["on_damaged"] = ::onsuperslasherdamaged;
  level.agent_funcs["superslasher"]["on_killed"] = ::onsuperslasherkilled;
  level.agent_funcs["superslasher"]["on_damaged_finished"] = ::onsuperslasherdamagefinished;
}

setupagent() {
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
  self.immune_against_nuke = 1;
  self.var_9342 = 1;
  self.immune_against_nuke = 1;
  self.aistate = "idle";
  self.synctransients = "run";
  self.sharpturnnotifydist = 150;
  self.fgetarg = 20;
  self.height = 53;
  self.var_252B = 26 + self.fgetarg;
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
  self.defaultgoalradius = self.fgetarg + 1;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self.var_B0FC = 1;
  self.full_gib = 0;
  self.croc_chomp = 0;
  self.spawn_round_num = level.wave_num;
  self.dont_cleanup = 1;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.allowpain = 1;
  self.last_damage_time_on_player = [];
  self.lastdamagedir = [];
  self.lastdamagetime = 0;
  if(getdvarint("scr_zombie_left_foot_sharp_turn_only", 0) == 1) {
    self.var_AB3F = 1;
  }

  thread func_899C();
}

func_FACE(var_0) {
  self setModel("fullbody_zmb_superslasher");
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self._blackboard.bgameended = 1;
}

onsuperslasherkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.death_anim_no_ragdoll = 1;
  self.nocorpse = 1;
  if(isDefined(self.attackents)) {
    foreach(var_0A in self.attackents) {
      var_0A delete();
    }
  }

  if(isDefined(self.shields)) {
    foreach(var_0D in self.shields) {
      var_0D delete();
    }
  }

  scripts\asm\superslasher\superslasher_actions::stopwireattack();
  thread superslasherdeathscriptmodelsequence(self);
  var_0F = self.asmname;
  var_10 = self.var_164D[var_0F].var_4BC0;
  var_11 = level.asm[var_0F].states[var_10];
  scripts\asm\asm::func_2388(var_0F, var_10, var_11, undefined);
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

superslasherdeathscriptmodelsequence(var_0) {
  level.soul_key_drop_pos = scripts\engine\utility::drop_to_ground(var_0.origin, 200, -5000) + (0, 0, 50);
  var_1 = var_0.origin;
  var_2 = spawn("script_model", var_1);
  var_2 setModel("fullbody_zmb_superslasher");
  var_2 scriptmodelplayanim("IW7_cp_super_death_01");
  playsoundatpos(var_2.origin, "zmb_superslasher_death_lr");
  var_2 thread super_slasher_death_vfx_sequence(var_2);
  wait(3.5);
  var_2 moveto(var_1 + (0, 0, -300), 11.5);
  var_2 waittill("movedone");
  var_2 delete();
  level notify("super_slasher_death");
}

super_slasher_death_vfx_sequence(var_0) {
  var_1 = spawnfx(level._effect["super_slasher_death_base"], var_0.origin);
  triggerfx(var_1);
  wait(0.6);
  playFXOnTag(level._effect["super_slasher_death_hand"], var_0, "j_wrist_ri");
  playFXOnTag(level._effect["super_slasher_death_limb"], var_0, "j_hip_ri");
  wait(0.5);
  playFXOnTag(level._effect["super_slasher_death_hand"], var_0, "j_wrist_le");
  wait(0.2);
  playFXOnTag(level._effect["super_slasher_death_limb"], var_0, "j_hip_le");
  wait(1.3);
  playFXOnTag(level._effect["super_slasher_death_limb"], var_0, "j_elbow_le");
  wait(1);
  playFXOnTag(level._effect["super_slasher_death_limb"], var_0, "j_clavicle_ri");
  wait(0.7);
  playFXOnTag(level._effect["super_slasher_death_limb"], var_0, "j_clavicle_le");
  var_0 waittill("movedone");
  var_1 delete();
}

onsuperslasherdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  if(isDefined(var_1) && var_1 == self) {
    return;
  }

  if(scripts\engine\utility::istrue(self.var_E0) && isDefined(var_6) && isDefined(var_7)) {
    playFX(level._effect["super_slasher_shield_hit"], var_6, var_7 * -150);
  }

  if(isDefined(self.btrophysystem)) {
    if(isDefined(var_1) && isplayer(var_1)) {
      self.lastdamagedir[self.lastdamagedir.size] = vectornormalize(var_1.origin - self.origin);
      self.lastdamagetime = gettime();
    }

    return;
  }

  if(scripts\engine\utility::istrue(self.var_E0)) {
    return;
  }

  if(isDefined(self._blackboard.binair)) {
    var_2 = int(min(var_2, self.health - 1));
    if(var_2 == 0) {
      return;
    }
  }

  if(var_5 == "iw7_harpoon_zm") {
    var_2 = min(0.1 * self.maxhealth, 2000);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon1")) {
    var_2 = min(0.01 * self.maxhealth, 75);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon2")) {
    var_2 = min(0.1 * self.maxhealth, 1500);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon3")) {
    var_2 = min(0.1 * self.maxhealth, 2000);
    var_2 = int(var_2);
  } else if(issubstr(var_5, "harpoon4")) {
    var_2 = min(0.01 * self.maxhealth, 1000);
    var_2 = int(var_2);
  }

  var_3 = var_3 | level.idflags_no_knockback;
  if(isDefined(level.players) && level.players.size >= 1) {
    var_2 = var_2 / level.players.size;
  }

  scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

onsuperslasherdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  scripts\mp\mp_agent::default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
}