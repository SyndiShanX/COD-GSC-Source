/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3192.gsc
*********************************************/

func_FE6A(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  lib_0F3E::func_FE89();
  var_4 = lib_0F3E::func_FE64();
  self func_83CE();
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self.is_shooting = 1;
  lib_0F3E::shootblankorrpg(var_1, 0.7, 2);
  self.asm.shootparams.var_C21C--;
  self.is_shooting = 0;
  func_85F5();
  scripts\asm\asm::asm_fireevent(var_1, "shoot_finished");
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
  var_0 = randomfloatrange(0.2, 0.5);
  wait(var_0);
}

func_13F91(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.is_regening_health);
}

func_13F93(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.should_shock_wave);
}

func_13F92(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.should_regen_summon);
}

zombiegreyshouldteleporttoloner(var_0, var_1, var_2, var_3) {
  return isDefined(self.teleport_loner_target_player);
}

zombiegreyshouldteleportattack(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.doing_teleport_attack);
}

zombiegreyshouldteleportsummon(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.doing_teleport_summon);
}

zombiegreyshouldteleportdash(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.doing_teleport_dash);
}

func_13F8C(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.var_9B78);
}

func_13F8E(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.doing_duplicating_attack);
}

func_13F6F(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "cloneGreyIdle");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "masterGreyIdle");
}

func_13F71(var_0, var_1, var_2, var_3) {
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
  var_0 = scripts\asm\asm::asm_lookupanimfromalias("duplicating_attack", "idle");
  self setanimstate("duplicating_attack", var_0, 1);
}

func_10BF0(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_clear("clone_complete");
  drop_max_ammo();
  func_F5F3(var_0);
  wait(1);
  func_10721(var_0);
  func_8E85();
  func_1870();
  func_1872();
  func_1871();
  func_23D7(var_0);
  level thread func_424F();
  wait(2);
  func_516E();
  scripts\engine\utility::flag_set("clone_complete");
}

func_23D7(var_0) {
  var_1 = func_7CDC();
  var_2 = var_1.size;
  foreach(var_8, var_4 in level.spawned_grey) {
    var_4 give_zombies_perk("grey" + var_8 % var_2 + 1);
    foreach(var_6 in level.players) {
      var_4 getenemyinfo(var_6);
    }
  }

  foreach(var_10, var_6 in var_1) {
    var_6 give_zombies_perk("player" + var_10 + 1);
  }
}

func_8E85() {
  foreach(var_1 in level.spawned_grey) {
    var_1 notify("update_mobile_shield_visibility", 0);
  }
}

func_7CDC() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

hudoutlinedisableforclients(var_0, var_1, var_2) {
  var_3 = func_7B0B(var_0.origin);
  var_4 = func_7B0A(var_0 getplayerangles(), var_0.origin, func_7813(var_0, var_1), var_2);
  return func_7B09(var_0, var_3, var_4);
}

func_7813(var_0, var_1) {
  var_2 = 360 / var_1;
  var_3 = var_0.angles;
  var_4 = [];
  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_4[var_4.size] = var_2 / 2 + var_5 * var_2;
  }

  return var_4;
}

func_7B36(var_0) {
  return var_0.num_of_clones;
}

func_10721(var_0) {
  level endon("game_ended");
  var_1 = func_7B36(var_0);
  func_F426(var_0, 1);
  for(var_2 = 0; var_2 < var_1 - 1; var_2++) {
    var_3 = scripts\mp\mp_agent::spawnnewagent("zombie_grey", "axis", var_0.origin, var_0.angles);
    if(isDefined(var_3)) {
      func_F426(var_3, 1);
      set_grey_clone(var_3);
      set_up_grey(var_3);
      func_F5F3(var_3);
      func_4644(var_3, var_0);
      func_463D(var_3, var_0);
    }
  }
}

func_F426(var_0, var_1) {
  var_0.var_9B78 = var_1;
}

func_F5F3(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1.angles = vectortoangles((0, 0, 1));
  var_1 linkto(var_0, "tag_origin");
  var_1 thread func_CD2C(var_1, var_0);
  var_1 thread func_13340(var_1, var_0);
  if(!isDefined(level.var_85EB)) {
    level.var_85EB = [];
  }

  level.var_85EB[level.var_85EB.size] = var_1;
}

func_516E() {
  foreach(var_1 in level.var_85EB) {
    killfxontag(level._effect["zombie_grey_start_duplicate"], var_1, "tag_origin");
    var_1 delete();
  }

  level.var_85EB = [];
}

func_CD2C(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_start_duplicate"], var_0, "tag_origin");
}

func_13340(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  killfxontag(level._effect["zombie_grey_start_duplicate"], var_0, "tag_origin");
  var_0 delete();
}

set_grey_clone(var_0) {
  foreach(var_2 in var_0.available_fuse) {
    var_2 hide();
  }

  var_0 notify("stop_health_light_monitor");
  var_0.i_am_clone = 1;
  var_0.var_10AB7 = 1;
  var_0.desiredenemydistmax = 60;
  var_0.meleerangesq = 90000;
  var_0.strafeifwithindist = var_0.desiredenemydistmax + 100;
  var_0 setModel("park_alien_gray_small");
}

func_4131() {
  foreach(var_1 in level.spawned_grey) {
    func_F426(var_1, 0);
    wait(1);
  }
}

func_1870() {
  foreach(var_1 in level.spawned_grey) {
    var_1.health = level.clone_health;
  }
}

func_1872() {
  foreach(var_1 in level.spawned_grey) {
    func_F3E9(var_1, 1);
  }
}

func_F3E9(var_0, var_1) {
  if(isDefined(var_0.moveplaybackrate)) {
    var_0.var_D8A4 = var_0.moveplaybackrate;
  }

  var_0.moveplaybackrate = var_1;
}

func_E2FB(var_0) {
  if(isDefined(var_0.var_D8A4)) {
    var_0.moveplaybackrate = var_0.var_D8A4;
    return;
  }

  var_0.moveplaybackrate = undefined;
}

func_1871() {
  foreach(var_1 in level.spawned_grey) {
    func_F3E8(var_1, 90000);
  }
}

func_F3E8(var_0, var_1) {
  var_0.var_D8A3 = var_0.meleerangesq;
  var_0.meleerangesq = var_1;
}

func_E2FA(var_0) {
  var_0.meleerangesq = var_0.var_D8A3;
}

func_424F() {
  wait(0.1);
  var_0 = ["jump_left", "jump_right", "jump_back", "jump_left"];
  foreach(var_3, var_2 in level.spawned_grey) {
    var_2 thread func_CE3B(var_2, var_0[var_3]);
  }
}

func_CE3B(var_0, var_1) {
  var_0 endon("death");
  var_2 = "duplicating_attack";
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_1);
  var_0 scripts\mp\agents\_scriptedagents::func_CED5(var_2, var_3, var_2, "end");
  var_0 func_CD46();
}

func_13F72(var_0, var_1, var_2, var_3) {
  self notify("grey play regen");
  self setscriptablepartstate("backpack_dome_shield", "off");
  self setscriptablepartstate("regen_beam", "on");
  self.actually_doing_regen = 1;
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1, 0);
}

func_13F70(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("backpack_dome_shield", "on");
  self setscriptablepartstate("regen_beam", "off");
}

func_13F73(var_0, var_1, var_2, var_3) {
  thread func_CE0A(self);
  scripts\asm\asm_mp::func_2367(var_0, var_1, var_2, "end");
}

func_13F74(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::func_2367(var_0, var_1, var_2, "early_end");
  scripts\asm\asm::asm_fireevent(var_1, "early_end");
}

func_13F76(var_0, var_1, var_2, var_3) {
  self playSound("grey_shockwave_build");
  scripts\asm\asm_mp::func_2367(var_0, var_1, var_2, "shock_wave_damage");
  self notify("shockwave_deploy");
  self notify("update_mobile_shield_visibility", 1);
  self playSound("grey_shockwave");
  func_FE53(self);
}

func_3EDC(var_0, var_1, var_2) {
  if(scripts\engine\utility::istrue(self.i_am_clone)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "mini_grey_melee");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "master_grey_melee");
}

func_13F75(var_0, var_1, var_2, var_3) {
  func_15A8(self, undefined, "prop_mp_dome_shield_scr");
  scripts\asm\asm_mp::func_2367(var_0, var_1, var_2, "start_summon_zombies");
  thread func_111C2(self);
  scripts\asm\asm_mp::func_2367(var_0, var_1, var_2, "early_end");
  func_4DB1(self);
}

func_111C2(var_0) {
  try_kill_off_zombies(6);
  var_1 = hudoutlinedisableforclients(var_0, 6, 128);
  foreach(var_3 in var_1) {
    level thread summon_a_zombie_at(var_3, 0);
  }
}

summon_a_zombie_at(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.script_parameters = "ground_spawn_no_boards";
  var_2.script_animation = "spawn_ground";
  var_3 = var_2 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1);
  if(isDefined(var_3)) {
    if(scripts\engine\utility::istrue(var_1)) {
      var_3 scragentsetanimscale(0, 1);
    }

    var_4 = spawnfx(level._effect["summon_zombie_energy_ring"], var_0 + (0, 0, -11), (0, 0, 1), (1, 0, 0));
    playsoundatpos(var_0 + (0, 0, -11), "zmb_grey_energy_ring_activate");
    var_5 = thread scripts\engine\utility::play_loopsound_in_space("zmb_grey_energy_ring_activate_lp", var_0 + (0, 0, -11));
    triggerfx(var_4);
    var_3 scripts\engine\utility::waittill_any("death", "intro_vignette_done");
    if(scripts\engine\utility::istrue(var_1) && isDefined(var_3)) {
      var_3 scragentsetanimscale(1, 1);
    }

    playsoundatpos(var_0 + (0, 0, -11), "zmb_grey_energy_ring_deactivate");
    var_5 stoploopsound();
    var_4 delete();
    wait(0.05);
    var_5 delete();
  }
}

try_kill_off_zombies(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(level.spawned_enemies), level.spawned_enemies.size, 0);
  var_2 = 24 - var_1;
  if(var_2 < var_0) {
    var_3 = var_0 - var_2;
    scripts\cp\zombies\zombies_spawning::func_A5FA(var_3);
  }
}

func_CE0A(var_0) {
  var_1 = (0, 0, 150);
  var_2 = (0, 0, 15);
  var_3 = var_0.origin + var_2;
  var_4 = spawnfx(level._effect["zombie_grey_shockwave_begin"], var_3);
  triggerfx(var_4);
  var_0 thread func_5D40(var_0, var_0.origin + var_1, var_3);
  var_5 = var_0 scripts\engine\utility::waittill_any_return("shockwave_deploy");
  var_4 delete();
  if(isDefined(var_5) && var_5 == "shockwave_deploy") {
    playFX(level._effect["zombie_grey_shockwave_deploy"], var_3);
  }
}

func_5D40(var_0, var_1, var_2) {
  var_3 = 0.2;
  var_4 = func_7D01(var_0, "regen_pain_in", "end");
  var_5 = func_7D01(var_0, "regen_pain_loop", "early_end");
  var_6 = func_7D01(var_0, "shockwave", "shock_wave_damage");
  var_7 = var_4 + var_5 + var_6;
  var_8 = spawn("script_model", var_1);
  var_8 setModel("tag_origin");
  wait(var_3);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_8, "tag_origin");
  var_8 moveto(var_2, var_7 - var_3);
  scripts\engine\utility::waittill_any_ents(var_8, "movedone", var_0, "death");
  var_8 delete();
}

func_7D01(var_0, var_1, var_2) {
  var_3 = var_0 getsafecircleorigin(var_1, 0);
  var_4 = getnotetracktimes(var_3, var_2);
  var_5 = getanimlength(var_3);
  var_6 = var_4[0] * var_5;
  return var_6;
}

func_FE53(var_0) {
  foreach(var_2 in level.players) {
    if(distancesquared(var_0.origin, var_2.origin) > 22500) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_3 = var_2.health;
    var_4 = int(var_3 * 0.9);
    var_2 dodamage(var_4, var_0.origin);
    scripts\mp\agents\zombie_grey\zombie_grey_agent::func_85F8(var_0, var_2);
  }
}

func_13F79(var_0, var_1, var_2, var_3) {
  self.var_DDC6 = [];
  var_4 = self.origin;
  var_5 = func_7CED(self);
  if(isDefined(var_5)) {
    var_6 = func_7CEF(self, var_5);
    if(isDefined(var_6)) {
      func_57CD(self, var_6, var_5);
      func_1164C(self, get_teleport_end_pos(var_4), "teleport_summon");
      scripts\aitypes\zombie_grey\behaviors::set_next_teleport_summon_time(self);
      scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
      scripts\asm\asm_bb::bb_clearmeleerequest();
    }
  }

  self.doing_teleport_summon = 0;
}

func_13F78(var_0, var_1, var_2, var_3) {
  var_4 = func_7CEC(self);
  if(isDefined(var_4)) {
    var_5 = func_7CEB(var_4);
    if(isDefined(var_5)) {
      func_1164C(self, var_5, "teleport_dash");
      scripts\aitypes\zombie_grey\behaviors::set_next_teleport_dash_time(self);
      scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
      scripts\asm\asm_bb::bb_clearmeleerequest();
    }
  }

  self.doing_teleport_dash = 0;
}

func_13F77(var_0, var_1, var_2, var_3) {
  self notify("update_mobile_shield_visibility", 0);
  self.var_DDC6 = [];
  self.var_8B73 = 0;
  var_4 = self.origin;
  var_5 = randomintrange(2, 5);
  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = func_7CEA(self);
    if(isDefined(var_7)) {
      var_8 = func_7CEF(self, var_7);
      if(isDefined(var_8)) {
        func_57CC(self, var_8, var_7);
      }
    }
  }

  if(self.var_8B73) {
    func_1164C(self, get_teleport_end_pos(var_4), "teleport_attack");
    scripts\aitypes\zombie_grey\behaviors::set_next_teleport_attack_time(self);
    scripts\aitypes\zombie_grey\behaviors::set_next_melee_time(self);
    scripts\asm\asm_bb::bb_clearmeleerequest();
  }

  self notify("update_mobile_shield_visibility", 1);
  self.doing_teleport_attack = 0;
}

get_teleport_end_pos(var_0) {
  if(clear_from_players(var_0)) {
    return var_0;
  }

  var_1 = "ufo_zombie_spawn_loc";
  var_2 = 300;
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_3, undefined, undefined, undefined, var_2);
  foreach(var_5 in var_3) {
    var_6 = scripts\engine\utility::drop_to_ground(var_5.origin, 5, -50);
    if(clear_from_players(var_6)) {
      return var_6;
    }
  }

  return var_0;
}

clear_from_players(var_0) {
  var_1 = 10000;
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1) {
      return 0;
    }
  }

  return 1;
}

func_57CD(var_0, var_1, var_2) {
  var_1.var_9B8C = 1;
  var_0.var_11643 = var_2;
  var_0 func_1164C(var_0, var_1.origin, "teleport_summon", var_0.var_11643);
  var_0 func_CECC("teleport_summon", "summon", ::func_11642);
  var_1.var_9B8C = 0;
}

func_57CC(var_0, var_1, var_2) {
  var_1.var_9B8C = 1;
  var_0.var_8B73 = 1;
  var_0.var_11618 = var_2;
  var_0 func_1164C(var_0, var_1.origin, "teleport_attack", var_0.var_11618);
  var_0 func_CECC("teleport_attack", "attack", ::func_11617);
  var_1.var_9B8C = 0;
}

func_1164C(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0.origin, var_1);
  var_5 = var_4 / 4000;
  var_6 = spawn("script_model", var_0.origin);
  var_6 setModel("tag_origin");
  var_0 playsoundonmovingent("grey_teleport_start");
  var_6 thread func_4104(var_0, var_6);
  var_0 setscriptablepartstate("teleport_attack_trail", "on");
  var_0 func_CECC(var_2, "start");
  var_0 linkto(var_6);
  var_6 moveto(var_1, var_5);
  var_6 waittill("movedone");
  var_0 playSound("grey_teleport_end");
  if(isDefined(var_3)) {
    var_3 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_alien_teleport", "zmb_comment_vo", "low", 3, 0, 0, 1, 5);
  }

  var_0 unlink();
  var_6 delete();
  var_0 setscriptablepartstate("teleport_attack_trail", "off");
  var_0 func_CECC(var_2, "end");
}

func_4104(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  var_1 delete();
}

func_CECC(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED5(var_0, var_3, var_0, "end", var_2);
}

func_11617(var_0, var_1, var_2, var_3) {
  if(var_0 == "fire") {
    var_4 = self getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = self.origin + (0, 0, 60) + var_5 * 20;
    magicbullet("zmb_grey_teleport_attack", var_6, self.var_11618.origin);
  }
}

func_11642(var_0, var_1, var_2, var_3) {
  if(var_0 == "start_summon_zombies") {
    if(isDefined(self.var_11643) && !scripts\engine\utility::istrue(self.var_11643.in_afterlife_arcade)) {
      try_kill_off_zombies(6);
      var_4 = hudoutlinedisableforclients(self.var_11643, 6, 128);
      foreach(var_6 in var_4) {
        level thread summon_a_zombie_at(var_6, 1);
        wait(randomfloatrange(0.1, 0.9));
      }
    }
  }
}

func_7CED(var_0) {
  if(isDefined(var_0.target_player) && !scripts\engine\utility::istrue(var_0.target_player.in_afterlife_arcade)) {
    return var_0.target_player;
  }

  return undefined;
}

func_7CEC(var_0) {
  if(isDefined(var_0.target_player) && !scripts\cp\cp_laststand::player_in_laststand(var_0.target_player)) {
    return var_0.target_player;
  }

  return undefined;
}

func_7CEA(var_0) {
  return var_0.target_player;
}

func_7CEB(var_0) {
  var_1 = 8;
  var_2 = hudoutlinedisableforclients(var_0, var_1, 256);
  var_2 = [var_2[0], var_2[var_2.size - 1]];
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_2 = func_12637(var_2);
  var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2);
  return var_2[var_2.size - 1].origin;
}

func_12637(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

func_7CEF(var_0, var_1) {
  var_2 = scripts\engine\utility::get_array_of_closest(var_1.origin, level.var_85F2, undefined, level.var_85F2.size, 1400, 200);
  var_3 = undefined;
  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    if(scripts\engine\utility::istrue(var_5.var_9B8C)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_5.origin) < 250000) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_0.var_DDC6, var_5)) {
      continue;
    }

    if(!sighttracepassed(var_5.origin + (0, 0, 60), var_1 getEye(), 0, var_0) && !sighttracepassed(var_5.origin + (0, 0, 60), var_1.origin, 0, var_0)) {
      continue;
    }

    var_3 = var_5;
    var_0.var_DDC6 = scripts\engine\utility::array_add(var_0.var_DDC6, var_3);
    break;
  }

  return var_3;
}

func_13F7A(var_0, var_1, var_2, var_3) {
  self notify("update_mobile_shield_visibility", 0);
  var_4 = self.origin;
  var_5 = (650, 625, 100);
  self setorigin(var_5);
  var_6 = func_85F4(var_4);
  var_7 = self.teleport_loner_target_player;
  var_8 = func_7B0B(var_7.origin);
  var_9 = func_7B0A(var_7 getplayerangles(), var_7.origin, func_7CE9(), 350);
  var_10 = func_7CEE(self, var_8, var_9);
  func_85F3(var_6, var_10);
  self setorigin(var_10);
  self.angles = vectortoangles(var_7.origin - self.origin);
  self show();
  self notify("update_mobile_shield_visibility", 1);
  self.teleport_loner_target_player = undefined;
}

func_7CE9() {
  var_0 = scripts\engine\utility::array_randomize([10, 350]);
  var_1 = scripts\engine\utility::array_randomize([20, 340]);
  var_2 = scripts\engine\utility::array_randomize([30, 330]);
  var_3 = [];
  var_3 = scripts\engine\utility::array_combine(var_3, var_0);
  var_3 = scripts\engine\utility::array_combine(var_3, var_1);
  var_3 = scripts\engine\utility::array_combine(var_3, var_2);
  return var_3;
}

func_7B0A(var_0, var_1, var_2, var_3) {
  var_4 = [];
  foreach(var_6 in var_2) {
    var_7 = (var_0[0], var_0[1] + var_6, var_0[2]);
    var_8 = anglesToForward(var_7);
    var_9 = var_1 + var_8 * var_3;
    var_9 = scripts\engine\utility::drop_to_ground(var_9, 200, -200);
    var_4[var_4.size] = var_9;
  }

  return var_4;
}

func_7B0B(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 0, -200);
  var_2 = getclosestpointonnavmesh(var_1);
  if(var_1 == var_2) {
    return var_2;
  }

  var_3 = vectornormalize(var_2 - var_1);
  var_4 = var_2 + var_3;
  return getclosestpointonnavmesh(var_4);
}

func_7B09(var_0, var_1, var_2) {
  var_3 = [];
  foreach(var_5 in var_2) {
    var_6 = navtrace(var_1, var_5, var_0, 1);
    var_3[var_3.size] = var_6["position"];
  }

  return var_3;
}

func_7CEE(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = -1;
  foreach(var_6 in var_2) {
    var_7 = navtrace(var_1, var_6, var_0, 1);
    var_8 = var_7["fraction"];
    if(var_8 > var_4) {
      var_3 = var_7["position"];
      var_4 = var_8;
    }
  }

  return var_3;
}

func_85F4(var_0) {
  playFX(level._effect["zombie_grey_teleport"], var_0);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  wait(0.2);
  playFXOnTag(level._effect["zombie_grey_teleport_trail"], var_1, "tag_origin");
  var_1 moveto((648, 654, 326), 2, 2);
  var_1 waittill("movedone");
  wait(1);
  return var_1;
}

func_85F3(var_0, var_1) {
  var_2 = spawnfx(level._effect["zombie_grey_teleport_trail"], var_1);
  triggerfx(var_2);
  var_0 moveto(var_1, 1, 1);
  var_0 waittill("movedone");
  var_0 delete();
  var_2 delete();
  playFX(level._effect["zombie_grey_teleport"], var_1);
}

func_15A8(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
  var_3 = spawn("script_model", var_0.origin + var_1);
  var_3 setModel(var_2);
  playsoundatpos(var_0.origin + var_1, "grey_bubbleshield_start");
  var_3 thread setpartstates(var_0, var_3);
  var_3 thread func_58F8(var_3, var_0);
  var_4 = spawn("script_model", var_0.origin + var_1);
  var_4 setModel("prop_mp_domeshield_col");
  var_4 thread func_58F8(var_4, var_0);
  var_0.var_58F7 = var_3;
  var_0.var_58F9 = var_4;
}

setpartstates(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_1 setscriptablepartstate("plant", "active", 0);
  wait(0.5);
  var_1 setscriptablepartstate("plant", "neutral", 0);
  var_1 setscriptablepartstate("armed", "active", 0);
}

func_4DB1(var_0) {
  playsoundatpos(var_0.origin, "grey_bubbleshield_end");
  var_0.var_58F7 delete();
  var_0.var_58F9 delete();
}

func_58F8(var_0, var_1) {
  playsoundatpos(var_1.origin, "grey_bubbleshield_end");
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

set_up_grey(var_0) {
  if(!isDefined(level.spawned_grey)) {
    level.spawned_grey = [];
  }

  var_0.a.rockets = 3;
  var_0.entered_playspace = 1;
  var_0.is_reserved = 1;
  level.spawned_enemies[level.spawned_enemies.size] = var_0;
  level.spawned_grey[level.spawned_grey.size] = var_0;
}

func_85FE(var_0, var_1, var_2, var_3) {
  level.var_85EE = 1;
  self setscriptablepartstate("spawn_beam", "on");
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

func_85FD(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("spawn_beam", "on");
  scripts\asm\asm_mp::func_235F(var_0, var_1, var_2, 1, 0);
}

func_85F7(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("spawn_beam", "off");
}

func_8601(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.should_stop_intro_anim);
}

func_85FF(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getmeleetarget();
  if(!isDefined(var_4)) {
    self orientmode("face angle abs", self.angles);
  } else if(isPlayer(var_4) && isDefined(self.enemy) && var_4 == self.enemy) {
    self orientmode("face enemy");
  } else {
    var_5 = var_4.origin - self.origin;
    var_6 = vectornormalize(var_5);
    var_7 = vectortoangles(var_6);
    self orientmode("face angle abs", var_7);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(self.moveplaybackrate), self.moveplaybackrate, 1);
  var_9 = func_3EDC(var_0, var_1, var_3);
  self setanimstate(var_1, var_9, var_8);
  self endon(var_1 + "_finished");
  func_58BB(var_0, var_1);
  scripts\asm\asm_bb::bb_clearmeleerequest();
  scripts\asm\asm::asm_fireevent(var_1, "end");
}

func_58BB(var_0, var_1) {
  for(;;) {
    self waittill(var_1, var_2);
    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    foreach(var_4 in var_2) {
      switch (var_4) {
        case "early_end":
        case "end":
          break;

        case "stop":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_5)) {
            return;
          }

          if(!isalive(var_5)) {
            return;
          }

          var_6 = distancesquared(var_5.origin, self.origin);
          if(var_6 > self.meleerangesq) {
            return;
          }
          break;

        case "start_melee":
        case "fire":
          var_5 = scripts\asm\asm_bb::bb_getmeleetarget();
          if(!isDefined(var_5)) {
            return;
          }

          if(isalive(var_5)) {
            if(scripts\engine\utility::istrue(self.i_am_clone)) {
              func_B787(self, var_5);
            } else {
              lib_0C35::func_CA1F(var_5);
            }
          }
          break;

        default:
          scripts\asm\asm_mp::func_2345(var_4, var_1);
          break;
      }
    }
  }
}

func_B787(var_0, var_1) {
  if(!func_FF46(var_0, var_1)) {
    return;
  }

  if(!func_9B68(var_0)) {
    var_2 = scripts\engine\utility::drop_to_ground(self.origin, 5, -50);
    var_3 = scripts\engine\utility::drop_to_ground(var_1.origin, 5, -50);
    var_4 = func_7C62();
    var_5 = var_2 + var_4;
    var_6 = var_3 + var_4;
    level thread func_6D07(var_5, 700, 2, var_6 - var_5, 0);
  }
}

func_FF46(var_0, var_1) {
  if(!isalive(var_1)) {
    return 0;
  }

  return 1;
}

func_9B68(var_0) {
  var_1 = getEntArray("mini_grey_shock_arc_trigger", "targetname");
  foreach(var_3 in var_1) {
    if(scripts\engine\utility::istrue(var_3.in_use) && distancesquared(var_0.origin, var_3.origin) < 640000) {
      return 1;
    }
  }

  return 0;
}

func_7C62() {
  var_0 = [(0, 0, 20), (0, 0, 60)];
  return scripts\engine\utility::random(var_0);
}

func_6D07(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 125;
  var_6 = func_7AE5();
  if(!isDefined(var_6)) {
    return;
  }

  var_3 = vectornormalize(var_3);
  var_6.origin = var_0;
  var_6.angles = func_7827(var_3, var_4);
  var_7 = int(var_2 * 20);
  var_8 = var_1 / var_7;
  var_6 thread func_FE3A(var_6);
  for(var_9 = 0; var_9 < var_7; var_9++) {
    var_10 = var_6.origin;
    var_11 = anglesToForward(var_6.angles);
    var_6.origin = var_10 + var_3 * var_8;
    var_12 = var_11 * var_5;
    var_13 = var_10 + var_12;
    var_14 = var_10 - var_12;
    playfxbetweenpoints(level._effect["zombie_mini_grey_shock_arc"], var_13, vectortoangles(var_14 - var_13), var_14);
    scripts\engine\utility::waitframe();
  }

  var_6.origin = var_6.original_pos;
  var_6.in_use = 0;
  var_6 notify("stop_shock_arc_trigger_monitor");
}

func_7827(var_0, var_1) {
  var_2 = vectortoangles(var_0);
  switch (var_1) {
    case 0:
      var_3 = anglestoright(var_2);
      return vectortoangles(var_3);

    case 45:
      var_4 = anglestoright(var_3);
      var_5 = anglestoup(var_3);
      var_6 = var_4 + var_5;
      return vectortoangles(var_6);

    case 90:
      var_7 = anglestoup(var_6);
      return vectortoangles(var_7);

    case 135:
      var_8 = anglestoleft(var_7);
      var_5 = anglestoup(var_7);
      var_6 = var_7 + var_8;
      return vectortoangles(var_8);
  }
}

func_FE3A(var_0) {
  var_0 endon("stop_shock_arc_trigger_monitor");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isPlayer(var_1)) {
      continue;
    }

    if(func_37FC(var_1)) {
      var_1 dodamage(60, var_0.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

func_7AE5() {
  var_0 = getEntArray("mini_grey_shock_arc_trigger", "targetname");
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::istrue(var_2.in_use)) {
      continue;
    }

    var_2.original_pos = var_2.origin;
    var_2.in_use = 1;
    return var_2;
  }

  return undefined;
}

func_37FC(var_0) {
  var_1 = gettime();
  if(!isDefined(var_0.var_D8A5)) {
    var_0.var_D8A5 = 0;
  }

  if(var_1 - var_0.var_D8A5 < 1000) {
    return 0;
  }

  var_0.var_D8A5 = var_1;
  return 1;
}

func_5F35(var_0) {
  level notify("grey_duplicating_attack_timer");
  level endon("grey_duplicating_attack_timer");
  level endon("grey_duplicating_attack_end");
  wait(420);
  scripts\mp\agents\zombie_grey\zombie_grey_agent::try_merge_clones();
}

func_4644(var_0, var_1) {
  var_0.activate_health_regen_threshold = var_1.activate_health_regen_threshold;
  var_0.current_max_health_regen_level = var_1.current_max_health_regen_level;
  var_0.max_health_regen_level_penalty = var_1.max_health_regen_level_penalty;
  var_0.min_health_regen_level = var_1.min_health_regen_level;
  var_0.health_addition_per_regen_segement = var_1.health_addition_per_regen_segement;
  var_0.trigger_clone_health = var_1.trigger_clone_health;
  var_0.health_regen_minimum = var_1.health_regen_minimum;
}

func_463D(var_0, var_1) {
  var_1.var_269D = [];
  foreach(var_3 in var_1.available_fuse) {
    var_1.var_269D[var_1.var_269D.size] = var_3.tag_name;
  }

  var_0.var_269D = var_1.var_269D;
}

drop_max_ammo() {
  scripts\engine\utility::flag_set("force_drop_max_ammo");
}