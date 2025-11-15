/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3192.gsc
************************/

func_FE6A(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  lib_0F3E::func_FE89();
  var_04 = lib_0F3E::func_FE64();
  self _meth_83CE();
  var_05 = scripts\asm\asm_mp::asm_getanim(param_00, param_01);
  self.is_shooting = 1;
  lib_0F3E::shootblankorrpg(param_01, 0.7, 2);
  self.asm.shootparams.var_C21C--;
  self.is_shooting = 0;
  func_85F5();
  scripts\asm\asm::asm_fireevent(param_01, "shoot_finished");
}

func_8602() {
  if(scripts\asm\asm_bb::bb_moverequested()) {
    return 0;
  }

  if(!scripts\asm\asm_bb::func_291C()) {
    return 0;
  }

  return 1;
}

func_85F5() {
  var_00 = randomfloatrange(0.2, 0.5);
  wait(var_00);
}

func_13F91(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.is_regening_health);
}

func_13F93(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.should_shock_wave);
}

func_13F92(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.should_regen_summon);
}

zombiegreyshouldteleporttoloner(param_00, param_01, param_02, param_03) {
  return isDefined(self.teleport_loner_target_player);
}

zombiegreyshouldteleportattack(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.doing_teleport_attack);
}

zombiegreyshouldteleportsummon(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.doing_teleport_summon);
}

zombiegreyshouldteleportdash(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.doing_teleport_dash);
}

func_13F8C(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.var_9B78);
}

func_13F8E(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.doing_duplicating_attack);
}

func_13F6F(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "cloneGreyIdle");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "masterGreyIdle");
}

func_13F71(param_00, param_01, param_02, param_03) {
  self takeweapon("iw7_zapper_grey");
  func_15A8(self, undefined, "prop_mp_dome_shield_scr");
  func_CD46();
  level thread func_10BF0(self);
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("quest_ufo_spawn_minialiens");
  if(!scripts\engine\utility::flag("clone_complete")) {
    scripts\engine\utility::flag_wait("clone_complete");
  }

  self.doing_duplicating_attack = 0;
  func_4131();
  func_4DB1(self);
}

func_CD46() {
  var_00 = scripts\asm\asm::asm_lookupanimfromalias("duplicating_attack", "idle");
  self setanimstate("duplicating_attack", var_00, 1);
}

func_10BF0(param_00) {
  level endon("game_ended");
  scripts\engine\utility::flag_clear("clone_complete");
  drop_max_ammo();
  func_F5F3(param_00);
  wait(1);
  func_10721(param_00);
  func_8E85();
  func_1870();
  func_1872();
  func_1871();
  func_23D7(param_00);
  level thread func_424F();
  wait(2);
  func_516E();
  scripts\engine\utility::flag_set("clone_complete");
}

func_23D7(param_00) {
  var_01 = func_7CDC();
  var_02 = var_01.size;
  foreach(var_08, var_04 in level.spawned_grey) {
    var_04 give_zombies_perk("grey" + var_08 % var_02 + 1);
    foreach(var_06 in level.players) {
      var_04 getenemyinfo(var_06);
    }
  }

  foreach(var_0A, var_06 in var_01) {
    var_06 give_zombies_perk("player" + var_0A + 1);
  }
}

func_8E85() {
  foreach(var_01 in level.spawned_grey) {
    var_01 notify("update_mobile_shield_visibility", 0);
  }
}

func_7CDC() {
  var_00 = [];
  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    var_00[var_00.size] = var_02;
  }

  return var_00;
}

hudoutlinedisableforclients(param_00, param_01, param_02) {
  var_03 = func_7B0B(param_00.origin);
  var_04 = func_7B0A(param_00 getplayerangles(), param_00.origin, func_7813(param_00, param_01), param_02);
  return func_7B09(param_00, var_03, var_04);
}

func_7813(param_00, param_01) {
  var_02 = 360 / param_01;
  var_03 = param_00.angles;
  var_04 = [];
  for(var_05 = 0; var_05 < param_01; var_05++) {
    var_04[var_04.size] = var_02 / 2 + var_05 * var_02;
  }

  return var_04;
}

func_7B36(param_00) {
  return param_00.num_of_clones;
}

func_10721(param_00) {
  level endon("game_ended");
  var_01 = func_7B36(param_00);
  func_F426(param_00, 1);
  for(var_02 = 0; var_02 < var_01 - 1; var_02++) {
    var_03 = scripts\mp\mp_agent::spawnnewagent("zombie_grey", "axis", param_00.origin, param_00.angles);
    if(isDefined(var_03)) {
      func_F426(var_03, 1);
      set_grey_clone(var_03);
      set_up_grey(var_03);
      func_F5F3(var_03);
      func_4644(var_03, param_00);
      func_463D(var_03, param_00);
    }
  }
}

func_F426(param_00, param_01) {
  param_00.var_9B78 = param_01;
}

func_F5F3(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01 setModel("tag_origin");
  var_01.angles = vectortoangles((0, 0, 1));
  var_01 linkto(param_00, "tag_origin");
  var_01 thread func_CD2C(var_01, param_00);
  var_01 thread func_13340(var_01, param_00);
  if(!isDefined(level.var_85EB)) {
    level.var_85EB = [];
  }

  level.var_85EB[level.var_85EB.size] = var_01;
}

func_516E() {
  foreach(var_01 in level.var_85EB) {
    killfxontag(level._effect["zombie_grey_start_duplicate"], var_01, "tag_origin");
    var_01 delete();
  }

  level.var_85EB = [];
}

func_CD2C(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_start_duplicate"], param_00, "tag_origin");
}

func_13340(param_00, param_01) {
  param_00 endon("death");
  param_01 waittill("death");
  killfxontag(level._effect["zombie_grey_start_duplicate"], param_00, "tag_origin");
  param_00 delete();
}

set_grey_clone(param_00) {
  foreach(var_02 in param_00.available_fuse) {
    var_02 hide();
  }

  param_00 notify("stop_health_light_monitor");
  param_00.i_am_clone = 1;
  param_00.var_10AB7 = 1;
  param_00.desiredenemydistmax = 60;
  param_00.meleerangesq = 90000;
  param_00.strafeifwithindist = param_00.desiredenemydistmax + 100;
  param_00 setModel("park_alien_gray_small");
}

func_4131() {
  foreach(var_01 in level.spawned_grey) {
    func_F426(var_01, 0);
    wait(1);
  }
}

func_1870() {
  foreach(var_01 in level.spawned_grey) {
    var_01.health = level.clone_health;
  }
}

func_1872() {
  foreach(var_01 in level.spawned_grey) {
    func_F3E9(var_01, 1);
  }
}

func_F3E9(param_00, param_01) {
  if(isDefined(param_00.moveplaybackrate)) {
    param_00.var_D8A4 = param_00.moveplaybackrate;
  }

  param_00.moveplaybackrate = param_01;
}

func_E2FB(param_00) {
  if(isDefined(param_00.var_D8A4)) {
    param_00.moveplaybackrate = param_00.var_D8A4;
    return;
  }

  param_00.moveplaybackrate = undefined;
}

func_1871() {
  foreach(var_01 in level.spawned_grey) {
    func_F3E8(var_01, 90000);
  }
}

func_F3E8(param_00, param_01) {
  param_00.var_D8A3 = param_00.meleerangesq;
  param_00.meleerangesq = param_01;
}

func_E2FA(param_00) {
  param_00.meleerangesq = param_00.var_D8A3;
}

func_424F() {
  wait(0.1);
  var_00 = ["jump_left", "jump_right", "jump_back", "jump_left"];
  foreach(var_03, var_02 in level.spawned_grey) {
    var_02 thread func_CE3B(var_02, var_00[var_03]);
  }
}

func_CE3B(param_00, param_01) {
  param_00 endon("death");
  var_02 = "duplicating_attack";
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(var_02, param_01);
  param_00 scripts\mp\agents\_scriptedagents::func_CED5(var_02, var_03, var_02, "end");
  param_00 func_CD46();
}

func_13F72(param_00, param_01, param_02, param_03) {
  self notify("grey play regen");
  self setscriptablepartstate("backpack_dome_shield", "off");
  self setscriptablepartstate("regen_beam", "on");
  self.actually_doing_regen = 1;
  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1, 0);
}

func_13F70(param_00, param_01, param_02, param_03) {
  self setscriptablepartstate("backpack_dome_shield", "on");
  self setscriptablepartstate("regen_beam", "off");
}

func_13F73(param_00, param_01, param_02, param_03) {
  thread func_CE0A(self);
  scripts\asm\asm_mp::func_2367(param_00, param_01, param_02, "end");
}

func_13F74(param_00, param_01, param_02, param_03) {
  scripts\asm\asm_mp::func_2367(param_00, param_01, param_02, "early_end");
  scripts\asm\asm::asm_fireevent(param_01, "early_end");
}

func_13F76(param_00, param_01, param_02, param_03) {
  self playSound("grey_shockwave_build");
  scripts\asm\asm_mp::func_2367(param_00, param_01, param_02, "shock_wave_damage");
  self notify("shockwave_deploy");
  self notify("update_mobile_shield_visibility", 1);
  self playSound("grey_shockwave");
  func_FE53(self);
}

func_3EDC(param_00, param_01, param_02) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "mini_grey_melee");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "master_grey_melee");
}

func_13F75(param_00, param_01, param_02, param_03) {
  func_15A8(self, undefined, "prop_mp_dome_shield_scr");
  scripts\asm\asm_mp::func_2367(param_00, param_01, param_02, "start_summon_zombies");
  thread func_111C2(self);
  scripts\asm\asm_mp::func_2367(param_00, param_01, param_02, "early_end");
  func_4DB1(self);
}

func_111C2(param_00) {
  try_kill_off_zombies(6);
  var_01 = hudoutlinedisableforclients(param_00, 6, 128);
  foreach(var_03 in var_01) {
    level thread summon_a_zombie_at(var_03, 0);
  }
}

summon_a_zombie_at(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = param_00;
  var_02.script_parameters = "ground_spawn_no_boards";
  var_02.script_animation = "spawn_ground";
  var_03 = var_02 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
  if(isDefined(var_03)) {
    if(scripts\engine\utility::istrue(param_01)) {
      var_03 scragentsetanimscale(0, 1);
    }

    var_04 = spawnfx(level._effect["summon_zombie_energy_ring"], param_00 + (0, 0, -11), (0, 0, 1), (1, 0, 0));
    playsoundatpos(param_00 + (0, 0, -11), "zmb_grey_energy_ring_activate");
    var_05 = thread scripts\engine\utility::play_loopsound_in_space("zmb_grey_energy_ring_activate_lp", param_00 + (0, 0, -11));
    triggerfx(var_04);
    var_03 scripts\engine\utility::waittill_any_3("death", "intro_vignette_done");
    if(scripts\engine\utility::istrue(param_01) && isDefined(var_03)) {
      var_03 scragentsetanimscale(1, 1);
    }

    playsoundatpos(param_00 + (0, 0, -11), "zmb_grey_energy_ring_deactivate");
    var_05 stoploopsound();
    var_04 delete();
    wait(0.05);
    var_05 delete();
  }
}

try_kill_off_zombies(param_00) {
  var_01 = scripts\engine\utility::ter_op(isDefined(level.spawned_enemies), level.spawned_enemies.size, 0);
  var_02 = 24 - var_01;
  if(var_02 < param_00) {
    var_03 = param_00 - var_02;
    scripts\cp\zombies\zombies_spawning::func_A5FA(var_03);
  }
}

func_CE0A(param_00) {
  var_01 = (0, 0, 150);
  var_02 = (0, 0, 15);
  var_03 = param_00.origin + var_02;
  var_04 = spawnfx(level._effect["zombie_grey_shockwave_begin"], var_03);
  triggerfx(var_04);
  param_00 thread func_5D40(param_00, param_00.origin + var_01, var_03);
  var_05 = param_00 scripts\engine\utility::waittill_any_return("shockwave_deploy");
  var_04 delete();
  if(isDefined(var_05) && var_05 == "shockwave_deploy") {
    playFX(level._effect["zombie_grey_shockwave_deploy"], var_03);
  }
}

func_5D40(param_00, param_01, param_02) {
  var_03 = 0.2;
  var_04 = func_7D01(param_00, "regen_pain_in", "end");
  var_05 = func_7D01(param_00, "regen_pain_loop", "early_end");
  var_06 = func_7D01(param_00, "shockwave", "shock_wave_damage");
  var_07 = var_04 + var_05 + var_06;
  var_08 = spawn("script_model", param_01);
  var_08 setModel("tag_origin");
  wait(var_03);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_08, "tag_origin");
  var_08 moveto(param_02, var_07 - var_03);
  scripts\engine\utility::waittill_any_ents(var_08, "movedone", param_00, "death");
  var_08 delete();
}

func_7D01(param_00, param_01, param_02) {
  var_03 = param_00 getsafecircleorigin(param_01, 0);
  var_04 = getnotetracktimes(var_03, param_02);
  var_05 = getanimlength(var_03);
  var_06 = var_04[0] * var_05;
  return var_06;
}

func_FE53(param_00) {
  foreach(var_02 in level.players) {
    if(distancesquared(param_00.origin, var_02.origin) > 22500) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      continue;
    }

    var_03 = var_02.health;
    var_04 = int(var_03 * 0.9);
    var_02 dodamage(var_04, param_00.origin);
    scripts\mp\agents\zombie_grey\zombie_grey_agent::func_85F8(param_00, var_02);
  }
}

func_13F79(param_00, param_01, param_02, param_03) {
  self.var_DDC6 = [];
  var_04 = self.origin;
  var_05 = func_7CED(self);
  if(isDefined(var_05)) {
    var_06 = func_7CEF(self, var_05);
    if(isDefined(var_06)) {
      func_57CD(self, var_06, var_05);
      func_1164C(self, get_teleport_end_pos(var_04), "teleport_summon");
      scripts\aitypes\zombie_grey\behaviors::set_next_teleport_summon_time(self);
      scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
      scripts\asm\asm_bb::bb_clearmeleerequest();
    }
  }

  self.doing_teleport_summon = 0;
}

func_13F78(param_00, param_01, param_02, param_03) {
  var_04 = func_7CEC(self);
  if(isDefined(var_04)) {
    var_05 = func_7CEB(var_04);
    if(isDefined(var_05)) {
      func_1164C(self, var_05, "teleport_dash");
      scripts\aitypes\zombie_grey\behaviors::set_next_teleport_dash_time(self);
      scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
      scripts\asm\asm_bb::bb_clearmeleerequest();
    }
  }

  self.doing_teleport_dash = 0;
}

func_13F77(param_00, param_01, param_02, param_03) {
  self notify("update_mobile_shield_visibility", 0);
  self.var_DDC6 = [];
  self.var_8B73 = 0;
  var_04 = self.origin;
  var_05 = randomintrange(2, 5);
  for(var_06 = 0; var_06 < var_05; var_06++) {
    var_07 = func_7CEA(self);
    if(isDefined(var_07)) {
      var_08 = func_7CEF(self, var_07);
      if(isDefined(var_08)) {
        func_57CC(self, var_08, var_07);
      }
    }
  }

  if(self.var_8B73) {
    func_1164C(self, get_teleport_end_pos(var_04), "teleport_attack");
    scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(self);
    scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
    scripts\asm\asm_bb::bb_clearmeleerequest();
  }

  self notify("update_mobile_shield_visibility", 1);
  self.doing_teleport_attack = 0;
}

get_teleport_end_pos(param_00) {
  if(clear_from_players(param_00)) {
    return param_00;
  }

  var_01 = "ufo_zombie_spawn_loc";
  var_02 = 300;
  var_03 = scripts\engine\utility::getstructarray(var_01, "targetname");
  var_03 = scripts\engine\utility::get_array_of_closest(param_00, var_03, undefined, undefined, undefined, var_02);
  foreach(var_05 in var_03) {
    var_06 = scripts\engine\utility::drop_to_ground(var_05.origin, 5, -50);
    if(clear_from_players(var_06)) {
      return var_06;
    }
  }

  return param_00;
}

clear_from_players(param_00) {
  var_01 = 10000;
  foreach(var_03 in level.players) {
    if(distancesquared(var_03.origin, param_00) < var_01) {
      return 0;
    }
  }

  return 1;
}

func_57CD(param_00, param_01, param_02) {
  param_01.var_9B8C = 1;
  param_00.var_11643 = param_02;
  param_00 func_1164C(param_00, param_01.origin, "teleport_summon", param_00.var_11643);
  param_00 func_CECC("teleport_summon", "summon", ::func_11642);
  param_01.var_9B8C = 0;
}

func_57CC(param_00, param_01, param_02) {
  param_01.var_9B8C = 1;
  param_00.var_8B73 = 1;
  param_00.var_11618 = param_02;
  param_00 func_1164C(param_00, param_01.origin, "teleport_attack", param_00.var_11618);
  param_00 func_CECC("teleport_attack", "attack", ::func_11617);
  param_01.var_9B8C = 0;
}

func_1164C(param_00, param_01, param_02, param_03) {
  var_04 = distance(param_00.origin, param_01);
  var_05 = var_04 / 4000;
  var_06 = spawn("script_model", param_00.origin);
  var_06 setModel("tag_origin");
  param_00 playsoundonmovingent("grey_teleport_start");
  var_06 thread func_4104(param_00, var_06);
  param_00 setscriptablepartstate("teleport_attack_trail", "on");
  param_00 func_CECC(param_02, "start");
  param_00 linkto(var_06);
  var_06 moveto(param_01, var_05);
  var_06 waittill("movedone");
  param_00 playSound("grey_teleport_end");
  if(isDefined(param_03)) {
    param_03 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_alien_teleport", "zmb_comment_vo", "low", 3, 0, 0, 1, 5);
  }

  param_00 unlink();
  var_06 delete();
  param_00 setscriptablepartstate("teleport_attack_trail", "off");
  param_00 func_CECC(param_02, "end");
}

func_4104(param_00, param_01) {
  param_01 endon("death");
  param_00 waittill("death");
  param_01 delete();
}

func_CECC(param_00, param_01, param_02) {
  var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED5(param_00, var_03, param_00, "end", param_02);
}

func_11617(param_00, param_01, param_02, param_03) {
  if(param_00 == "fire") {
    var_04 = self getplayerangles();
    var_05 = anglesToForward(var_04);
    var_06 = self.origin + (0, 0, 60) + var_05 * 20;
    magicbullet("zmb_grey_teleport_attack", var_06, self.var_11618.origin);
  }
}

func_11642(param_00, param_01, param_02, param_03) {
  if(param_00 == "start_summon_zombies") {
    if(isDefined(self.var_11643) && !scripts\engine\utility::istrue(self.var_11643.in_afterlife_arcade)) {
      try_kill_off_zombies(6);
      var_04 = hudoutlinedisableforclients(self.var_11643, 6, 128);
      foreach(var_06 in var_04) {
        level thread summon_a_zombie_at(var_06, 1);
        wait(randomfloatrange(0.1, 0.9));
      }
    }
  }
}

func_7CED(param_00) {
  if(isDefined(param_00.target_player) && !scripts\engine\utility::istrue(param_00.target_player.in_afterlife_arcade)) {
    return param_00.target_player;
  }

  return undefined;
}

func_7CEC(param_00) {
  if(isDefined(param_00.target_player) && !scripts\cp\cp_laststand::player_in_laststand(param_00.target_player)) {
    return param_00.target_player;
  }

  return undefined;
}

func_7CEA(param_00) {
  return param_00.target_player;
}

func_7CEB(param_00) {
  var_01 = 8;
  var_02 = hudoutlinedisableforclients(param_00, var_01, 256);
  var_02 = [var_02[0], var_02[var_02.size - 1]];
  var_02 = scripts\engine\utility::array_randomize(var_02);
  var_02 = func_12637(var_02);
  var_02 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_02);
  return var_02[var_02.size - 1].origin;
}

func_12637(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_04 = spawnStruct();
    var_04.origin = var_03;
    var_01[var_01.size] = var_04;
  }

  return var_01;
}

func_7CEF(param_00, param_01) {
  var_02 = scripts\engine\utility::get_array_of_closest(param_01.origin, level.var_85F2, undefined, level.var_85F2.size, 1400, 200);
  var_03 = undefined;
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = var_02[var_04];
    if(scripts\engine\utility::istrue(var_05.var_9B8C)) {
      continue;
    }

    if(distancesquared(param_00.origin, var_05.origin) < 250000) {
      continue;
    }

    if(scripts\engine\utility::array_contains(param_00.var_DDC6, var_05)) {
      continue;
    }

    if(!sighttracepassed(var_05.origin + (0, 0, 60), param_01 getEye(), 0, param_00) && !sighttracepassed(var_05.origin + (0, 0, 60), param_01.origin, 0, param_00)) {
      continue;
    }

    var_03 = var_05;
    param_00.var_DDC6 = scripts\engine\utility::array_add(param_00.var_DDC6, var_03);
    break;
  }

  return var_03;
}

func_13F7A(param_00, param_01, param_02, param_03) {
  self notify("update_mobile_shield_visibility", 0);
  var_04 = self.origin;
  var_05 = (650, 625, 100);
  self setorigin(var_05);
  var_06 = func_85F4(var_04);
  var_07 = self.teleport_loner_target_player;
  var_08 = func_7B0B(var_07.origin);
  var_09 = func_7B0A(var_07 getplayerangles(), var_07.origin, func_7CE9(), 350);
  var_0A = func_7CEE(self, var_08, var_09);
  func_85F3(var_06, var_0A);
  self setorigin(var_0A);
  self.angles = vectortoangles(var_07.origin - self.origin);
  self show();
  self notify("update_mobile_shield_visibility", 1);
  self.teleport_loner_target_player = undefined;
}

func_7CE9() {
  var_00 = scripts\engine\utility::array_randomize([10, 350]);
  var_01 = scripts\engine\utility::array_randomize([20, 340]);
  var_02 = scripts\engine\utility::array_randomize([30, 330]);
  var_03 = [];
  var_03 = scripts\engine\utility::array_combine(var_03, var_00);
  var_03 = scripts\engine\utility::array_combine(var_03, var_01);
  var_03 = scripts\engine\utility::array_combine(var_03, var_02);
  return var_03;
}

func_7B0A(param_00, param_01, param_02, param_03) {
  var_04 = [];
  foreach(var_06 in param_02) {
    var_07 = (param_00[0], param_00[1] + var_06, param_00[2]);
    var_08 = anglesToForward(var_07);
    var_09 = param_01 + var_08 * param_03;
    var_09 = scripts\engine\utility::drop_to_ground(var_09, 200, -200);
    var_04[var_04.size] = var_09;
  }

  return var_04;
}

func_7B0B(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(param_00, 0, -200);
  var_02 = getclosestpointonnavmesh(var_01);
  if(var_01 == var_02) {
    return var_02;
  }

  var_03 = vectornormalize(var_02 - var_01);
  var_04 = var_02 + var_03;
  return getclosestpointonnavmesh(var_04);
}

func_7B09(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_02) {
    var_06 = navtrace(param_01, var_05, param_00, 1);
    var_03[var_03.size] = var_06["position"];
  }

  return var_03;
}

func_7CEE(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = -1;
  foreach(var_06 in param_02) {
    var_07 = navtrace(param_01, var_06, param_00, 1);
    var_08 = var_07["fraction"];
    if(var_08 > var_04) {
      var_03 = var_07["position"];
      var_04 = var_08;
    }
  }

  return var_03;
}

func_85F4(param_00) {
  playFX(level._effect["zombie_grey_teleport"], param_00);
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_01, "tag_origin");
  var_01 moveto((648, 654, 326), 2, 2);
  var_01 waittill("movedone");
  wait(1);
  return var_01;
}

func_85F3(param_00, param_01) {
  var_02 = spawnfx(level._effect["zombie_grey_teleport_trail"], param_01);
  triggerfx(var_02);
  param_00 moveto(param_01, 1, 1);
  param_00 waittill("movedone");
  param_00 delete();
  var_02 delete();
  playFX(level._effect["zombie_grey_teleport"], param_01);
}

func_15A8(param_00, param_01, param_02) {
  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, (0, 0, 0));
  var_03 = spawn("script_model", param_00.origin + param_01);
  var_03 setModel(param_02);
  playsoundatpos(param_00.origin + param_01, "grey_bubbleshield_start");
  var_03 thread setpartstates(param_00, var_03);
  var_03 thread func_58F8(var_03, param_00);
  var_04 = spawn("script_model", param_00.origin + param_01);
  var_04 setModel("prop_mp_domeshield_col");
  var_04 thread func_58F8(var_04, param_00);
  param_00.var_58F7 = var_03;
  param_00.var_58F9 = var_04;
}

setpartstates(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  param_01 setscriptablepartstate("plant", "active", 0);
  wait(0.5);
  param_01 setscriptablepartstate("plant", "neutral", 0);
  param_01 setscriptablepartstate("armed", "active", 0);
}

func_4DB1(param_00) {
  playsoundatpos(param_00.origin, "grey_bubbleshield_end");
  param_00.var_58F7 delete();
  param_00.var_58F9 delete();
}

func_58F8(param_00, param_01) {
  playsoundatpos(param_01.origin, "grey_bubbleshield_end");
  param_00 endon("death");
  param_01 waittill("death");
  param_00 delete();
}

set_up_grey(param_00) {
  if(!isDefined(level.spawned_grey)) {
    level.spawned_grey = [];
  }

  param_00.a.rockets = 3;
  param_00.entered_playspace = 1;
  param_00.is_reserved = 1;
  level.spawned_enemies[level.spawned_enemies.size] = param_00;
  level.spawned_grey[level.spawned_grey.size] = param_00;
}

func_85FE(param_00, param_01, param_02, param_03) {
  level.var_85EE = 1;
  self setscriptablepartstate("spawn_beam", "on");
  lib_0F3C::func_CEA8(param_00, param_01, param_02, param_03);
}

func_85FD(param_00, param_01, param_02, param_03) {
  self setscriptablepartstate("spawn_beam", "on");
  scripts\asm\asm_mp::func_235F(param_00, param_01, param_02, 1, 0);
}

func_85F7(param_00, param_01, param_02, param_03) {
  self setscriptablepartstate("spawn_beam", "off");
}

func_8601(param_00, param_01, param_02, param_03) {
  return scripts\engine\utility::istrue(self.should_stop_intro_anim);
}

func_85FF(param_00, param_01, param_02, param_03) {
  var_04 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_04)) {
    self orientmode("face angle abs", self.angles);
  } else if(isplayer(var_04) && isDefined(self.isnodeoccupied) && var_04 == self.isnodeoccupied) {
    self orientmode("face enemy");
  } else {
    var_05 = var_04.origin - self.origin;
    var_06 = vectornormalize(var_05);
    var_07 = vectortoangles(var_06);
    self orientmode("face angle abs", var_07);
  }

  var_08 = scripts\engine\utility::ter_op(isDefined(self.moveplaybackrate), self.moveplaybackrate, 1);
  var_09 = func_3EDC(param_00, param_01, param_03);
  self setanimstate(param_01, var_09, var_08);
  self endon(param_01 + "_finished");
  func_58BB(param_00, param_01);
  scripts\asm\asm_bb::bb_clearmeleerequest();
  scripts\asm\asm::asm_fireevent(param_01, "end");
}

func_58BB(param_00, param_01) {
  for(;;) {
    self waittill(param_01, var_02);
    if(!isarray(var_02)) {
      var_02 = [var_02];
    }

    foreach(var_04 in var_02) {
      switch (var_04) {
        case "early_end":
        case "end":
          break;

        case "stop":
          var_05 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_05)) {
            return;
          }

          if(!isalive(var_05)) {
            return;
          }

          var_06 = distancesquared(var_05.origin, self.origin);
          if(var_06 > self.meleerangesq) {
            return;
          }
          break;

        case "start_melee":
        case "fire":
          var_05 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_05)) {
            return;
          }

          if(isalive(var_05)) {
            if(scripts\engine\utility::istrue(self.i_am_clone)) {
              func_B787(self, var_05);
            } else {
              lib_0C35::func_CA1F(var_05);
            }
          }
          break;

        default:
          scripts\asm\asm_mp::func_2345(var_04, param_01);
          break;
      }
    }
  }
}

func_B787(param_00, param_01) {
  if(!func_FF46(param_00, param_01)) {
    return;
  }

  if(!func_9B68(param_00)) {
    var_02 = scripts\engine\utility::drop_to_ground(self.origin, 5, -50);
    var_03 = scripts\engine\utility::drop_to_ground(param_01.origin, 5, -50);
    var_04 = func_7C62();
    var_05 = var_02 + var_04;
    var_06 = var_03 + var_04;
    level thread func_6D07(var_05, 700, 2, var_06 - var_05, 0);
  }
}

func_FF46(param_00, param_01) {
  if(!isalive(param_01)) {
    return 0;
  }

  return 1;
}

func_9B68(param_00) {
  var_01 = getEntArray("mini_grey_shock_arc_trigger", "targetname");
  foreach(var_03 in var_01) {
    if(scripts\engine\utility::istrue(var_03.in_use) && distancesquared(param_00.origin, var_03.origin) < 640000) {
      return 1;
    }
  }

  return 0;
}

func_7C62() {
  var_00 = [(0, 0, 20), (0, 0, 60)];
  return scripts\engine\utility::random(var_00);
}

func_6D07(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 125;
  var_06 = func_7AE5();
  if(!isDefined(var_06)) {
    return;
  }

  param_03 = vectornormalize(param_03);
  var_06.origin = param_00;
  var_06.angles = func_7827(param_03, param_04);
  var_07 = int(param_02 * 20);
  var_08 = param_01 / var_07;
  var_06 thread func_FE3A(var_06);
  for(var_09 = 0; var_09 < var_07; var_09++) {
    var_0A = var_06.origin;
    var_0B = anglesToForward(var_06.angles);
    var_06.origin = var_0A + param_03 * var_08;
    var_0C = var_0B * var_05;
    var_0D = var_0A + var_0C;
    var_0E = var_0A - var_0C;
    playfxbetweenpoints(level._effect["zombie_mini_grey_shock_arc"], var_0D, vectortoangles(var_0E - var_0D), var_0E);
    scripts\engine\utility::waitframe();
  }

  var_06.origin = var_06.original_pos;
  var_06.in_use = 0;
  var_06 notify("stop_shock_arc_trigger_monitor");
}

func_7827(param_00, param_01) {
  var_02 = vectortoangles(param_00);
  switch (param_01) {
    case 0:
      var_03 = anglestoright(var_02);
      return vectortoangles(var_03);

    case 45:
      var_04 = anglestoright(var_03);
      var_05 = anglestoup(var_03);
      var_06 = var_04 + var_05;
      return vectortoangles(var_06);

    case 90:
      var_07 = anglestoup(var_06);
      return vectortoangles(var_07);

    case 135:
      var_08 = anglestoleft(var_07);
      var_05 = anglestoup(var_07);
      var_06 = var_07 + var_08;
      return vectortoangles(var_08);
  }
}

func_FE3A(param_00) {
  param_00 endon("stop_shock_arc_trigger_monitor");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      continue;
    }

    if(func_37FC(var_01)) {
      var_01 dodamage(60, param_00.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

func_7AE5() {
  var_00 = getEntArray("mini_grey_shock_arc_trigger", "targetname");
  foreach(var_02 in var_00) {
    if(scripts\engine\utility::istrue(var_02.in_use)) {
      continue;
    }

    var_02.original_pos = var_02.origin;
    var_02.in_use = 1;
    return var_02;
  }

  return undefined;
}

func_37FC(param_00) {
  var_01 = gettime();
  if(!isDefined(param_00.var_D8A5)) {
    param_00.var_D8A5 = 0;
  }

  if(var_01 - param_00.var_D8A5 < 1000) {
    return 0;
  }

  param_00.var_D8A5 = var_01;
  return 1;
}

func_5F35(param_00) {
  level notify("grey_duplicating_attack_timer");
  level endon("grey_duplicating_attack_timer");
  level endon("grey_duplicating_attack_end");
  wait(420);
  scripts\mp\agents\zombie_grey\zombie_grey_agent::try_merge_clones();
}

func_4644(param_00, param_01) {
  param_00.activate_health_regen_threshold = param_01.activate_health_regen_threshold;
  param_00.current_max_health_regen_level = param_01.current_max_health_regen_level;
  param_00.max_health_regen_level_penalty = param_01.max_health_regen_level_penalty;
  param_00.min_health_regen_level = param_01.min_health_regen_level;
  param_00.health_addition_per_regen_segement = param_01.health_addition_per_regen_segement;
  param_00.trigger_clone_health = param_01.trigger_clone_health;
  param_00.health_regen_minimum = param_01.health_regen_minimum;
}

func_463D(param_00, param_01) {
  param_01.var_269D = [];
  foreach(var_03 in param_01.available_fuse) {
    param_01.var_269D[param_01.var_269D.size] = var_03.tag_name;
  }

  param_00.var_269D = param_01.var_269D;
}

drop_max_ammo() {
  scripts\engine\utility::flag_set("force_drop_max_ammo");
}