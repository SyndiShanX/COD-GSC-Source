/*****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

func_FACE(param_00) {
  self setModel("fullbody_zmb_superslasher");
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self.var_1198.bgameended = 1;
}

onsuperslasherkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
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
  scripts\mp\mp_agent::default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

superslasherdeathscriptmodelsequence(param_00) {
  level.soul_key_drop_pos = scripts\engine\utility::drop_to_ground(param_00.origin, 200, -5000) + (0, 0, 50);
  var_01 = param_00.origin;
  var_02 = spawn("script_model", var_01);
  var_02 setModel("fullbody_zmb_superslasher");
  var_02 scriptmodelplayanim("IW7_cp_super_death_01");
  playsoundatpos(var_02.origin, "zmb_superslasher_death_lr");
  var_02 thread super_slasher_death_vfx_sequence(var_02);
  wait(3.5);
  var_02 moveto(var_01 + (0, 0, -300), 11.5);
  var_02 waittill("movedone");
  var_02 delete();
  level notify("super_slasher_death");
}

super_slasher_death_vfx_sequence(param_00) {
  var_01 = spawnfx(level._effect["super_slasher_death_base"], param_00.origin);
  triggerfx(var_01);
  wait(0.6);
  playFXOnTag(level._effect["super_slasher_death_hand"], param_00, "j_wrist_ri");
  playFXOnTag(level._effect["super_slasher_death_limb"], param_00, "j_hip_ri");
  wait(0.5);
  playFXOnTag(level._effect["super_slasher_death_hand"], param_00, "j_wrist_le");
  wait(0.2);
  playFXOnTag(level._effect["super_slasher_death_limb"], param_00, "j_hip_le");
  wait(1.3);
  playFXOnTag(level._effect["super_slasher_death_limb"], param_00, "j_elbow_le");
  wait(1);
  playFXOnTag(level._effect["super_slasher_death_limb"], param_00, "j_clavicle_ri");
  wait(0.7);
  playFXOnTag(level._effect["super_slasher_death_limb"], param_00, "j_clavicle_le");
  param_00 waittill("movedone");
  var_01 delete();
}

onsuperslasherdamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(param_01) && param_01 == self) {
    return;
  }

  if(scripts\engine\utility::istrue(self.var_E0) && isDefined(param_06) && isDefined(param_07)) {
    playFX(level._effect["super_slasher_shield_hit"], param_06, param_07 * -150);
  }

  if(isDefined(self.btrophysystem)) {
    if(isDefined(param_01) && isplayer(param_01)) {
      self.lastdamagedir[self.lastdamagedir.size] = vectornormalize(param_01.origin - self.origin);
      self.lastdamagetime = gettime();
    }

    return;
  }

  if(scripts\engine\utility::istrue(self.var_E0)) {
    return;
  }

  if(isDefined(self.var_1198.binair)) {
    param_02 = int(min(param_02, self.health - 1));
    if(param_02 == 0) {
      return;
    }
  }

  if(param_05 == "iw7_harpoon_zm") {
    param_02 = min(0.1 * self.maxhealth, 2000);
    param_02 = int(param_02);
  } else if(issubstr(param_05, "harpoon1")) {
    param_02 = min(0.01 * self.maxhealth, 75);
    param_02 = int(param_02);
  } else if(issubstr(param_05, "harpoon2")) {
    param_02 = min(0.1 * self.maxhealth, 1500);
    param_02 = int(param_02);
  } else if(issubstr(param_05, "harpoon3")) {
    param_02 = min(0.1 * self.maxhealth, 2000);
    param_02 = int(param_02);
  } else if(issubstr(param_05, "harpoon4")) {
    param_02 = min(0.01 * self.maxhealth, 1000);
    param_02 = int(param_02);
  }

  param_03 = param_03 | level.idflags_no_knockback;
  if(isDefined(level.players) && level.players.size >= 1) {
    param_02 = param_02 / level.players.size;
  }

  scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

onsuperslasherdamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  scripts\mp\mp_agent::default_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
}