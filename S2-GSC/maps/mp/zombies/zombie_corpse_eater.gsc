/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_corpse_eater.gsc
***************************************************/

func_00D5() {
  level.zmb_corpse_eater_channel_counter = 0;
  common_scripts\utility::func_92C("zmb_corpse_eater_zombie_smoldering", "vfx/zombie/prototype_fx/zmf_corpse_eater_smoldering");
  var_00 = spawnStruct();
  var_00.var_A4B = "zombie_dlc4";
  var_00.var_EAE = "zombie_animclass";
  var_00.var_E88 = "zombie_generic";
  var_00.var_879 = "zombie_generic";
  var_00.var_4C12 = 1;
  var_00.var_60E2 = 40;
  var_00.var_8302 = 65;
  var_00.var_8303 = 15;
  var_00.parenttype = "zombie_generic";
  var_00.suppressive_fire_speed_multiplier = 0.3;
  var_00.tacklebymelee = 1;
  var_00.tacklebycharge = 1;
  var_00.knockbyravensword = 1;
  var_00.shockbyteslablood = 1;
  var_00.energyhold = 1;
  var_00.energyholdsecondary = 1;
  var_00.throwable = 1;
  var_01 = ["zom_corpseeater_head_a_org1", "zom_corpseeater_head_b_org1", "zom_corpseeater_head_c_org1"];
  var_00.var_5ED2["corpse_eater_a"]["whole_body"] = "zom_corpseeater_torso_a_org1";
  var_00.var_5ED2["corpse_eater_a"]["heads"] = var_01;
  var_00.var_5ED2["corpse_eater_b"]["whole_body"] = "zom_corpseeater_torso_b_org1";
  var_00.var_5ED2["corpse_eater_b"]["heads"] = var_01;
  var_00.var_5ED2["corpse_eater_c"]["whole_body"] = "zom_corpseeater_torso_c_org1";
  var_00.var_5ED2["corpse_eater_c"]["heads"] = var_01;
  level.var_A41["zombie_dlc4"] = level.var_A41["zombie"];
  level.var_A41["zombie_dlc4"]["post_model"] = ::zombie_corpse_eater_vfx;
  level.var_A41["zombie_dlc4"]["move_mode"] = ::maps\mp\zombies\zombie_sizzler::zombie_sizzler_move_mode_func;
  level.var_A41["zombie_dlc4"]["think"] = ::zombie_corpse_eater_think;
  level.var_A41["zombie_dlc4"]["get_action_params"] = ::zombie_corpse_eater_params;
  level.var_A41["zombie_dlc4"]["on_damaged"] = ::zombie_corpse_eater_on_damaged;
  level.var_A41["zombie_dlc4"]["on_damaged_finished"] = ::zombie_corpse_eater_on_damaged_finished;
  lib_0547::func_7BA9(::unlink_corpseeater);
  lib_0547::func_7BD0("corpse_eater_feed", ::enterfeedingstate, ::exitfeedingstate, 4);
  lib_0547::func_7BD0("corpse_eater_detonate", ::enterdetonation, ::exitdetonation, 8);
  lib_0547::func_A52(var_00, "zombie_dlc4");
}

enterfeedingstate(param_00) {
  var_01 = get_target_zombie();
  if(!isDefined(var_01)) {
    exitfeedingstate();
    return;
  }

  self endon("death");
  if(!isDefined(self.var_5A36)) {
    self.var_5A36 = 0;
  }

  level notify("corpse_eater_start_feed", self, var_01);
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "corpse_eater_feed");
  self method_839C("anim deltas");
  wait_for_eating_done();
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("corpse_eat_exit");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, 0, 1, "scripted_anim");
  if(self.var_5A36 >= 5 && 0) {
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_434D("corpse_eat_rage");
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_02, 0, 1, "scripted_anim");
  }

  exitfeedingstate();
}

enterdetonation(param_00) {
  self endon("death");
  self scragentsetscripted(1);
  self method_839C("code_move");
  self scragentsetorientmode("face angle abs", self.var_1D);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "corpse_eater_detonate");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("corpse_death_explode");
  thread maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "scripted_anim", undefined, ::detonate_on_notetrack);
  lib_0378::func_8D74("aud_corpse_eater_pre_explosion");
}

detonate_on_notetrack(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "deathboom":
      do_final_detonation();
      break;
  }
}

do_final_detonation() {
  self.var_1F4C = 1;
  self.shouldexplode = 1;
  var_00 = undefined;
  if(isDefined(self.var_E6)) {
    var_00 = self.var_E6;
  }

  self.luckycrit = 1;
  self.var_1DEB = 1;
  try_detonation();
  self dodamage(self.var_BC * 2, self.var_116, var_00);
}

exitfeedingstate(param_00) {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "corpse_eater_feed");
}

exitdetonation(param_00) {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "corpse_eater_detonate");
}

get_target_zombie() {
  foreach(var_01 in get_all_zombies_for_ce()) {
    if(var_01 is_corpse_eater_linked(self)) {
      return var_01;
    }
  }
}

get_all_zombies_for_ce() {
  var_00 = [];
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_A) && var_03.var_A == level.var_746E && !common_scripts\utility::func_562E(var_03.isdarkhost)) {
      continue;
    }

    if(lib_0547::func_5565(level.zombie_king, var_03)) {
      continue;
    }

    var_00[var_00.size] = var_03;
  }

  return var_00;
}

get_feed_secondary_count() {
  if(isDefined(self.forcedfeedcount)) {
    return self.forcedfeedcount;
  }

  return 0;
}

exit_loop() {
  self endon("corpse_eat_loop");
  wait(3);
  self notify("corpse_eat_loop", "scripted_anim");
}

wait_for_eating_done() {
  self endon("death");
  var_00 = get_target_zombie();
  if(!isDefined(var_00)) {
    exitfeedingstate();
    return;
  }

  var_00 endon("death");
  self scragentsetorientmode("face angle abs", self.var_1D);
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("corpse_eat_enter");
  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "scripted_anim");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_434D("corpse_eat_loop");
  childthread exit_loop();
  if(isDefined(self.loc_beam)) {
    self.loc_beam delete();
  }

  self.loc_beam = launchbeam("zmb_geistkraft_reg_beam_med", self, "jnt_mandible", var_00, "j_neck");
  playFXOnTag(level.var_611["zmb_corpse_eater_feed"], self, "j_head");
  playFXOnTag(level.var_611["dark_energy_burst"], var_00, "J_Head");
  lib_0378::func_8D74("aud_corpse_eater_soul_suck", self.var_116, var_00.var_116);
  childthread kill_zombie_target();
  var_02 = get_feed_secondary_count();
  if(isDefined(var_02) && var_02 > 0) {
    var_03 = [];
    if(isDefined(self.secondary_loc_beams)) {
      foreach(var_05 in self.secondary_loc_beams) {
        if(isDefined(var_05)) {
          var_05 delete();
        }
      }
    }

    self.secondary_loc_beams = [];
    var_07 = common_scripts\utility::func_40B0(self.var_116, lib_0547::func_4090("zombie_generic"), [var_00], var_02, 256);
    foreach(var_09 in var_07) {
      if(!var_09 lib_0547::func_4B2C()) {
        continue;
      }

      if(var_09 == self) {
        continue;
      }

      if(isDefined(var_09.corpseeatertargetid)) {
        continue;
      }

      var_03 = common_scripts\utility::func_F6F(var_03, var_09);
    }

    foreach(var_0C in var_03) {
      self.secondary_loc_beams[self.secondary_loc_beams.size] = launchbeam("zmb_geistkraft_reg_beam_med", self, "jnt_mandible", var_0C, "j_neck");
      playFXOnTag(level.var_611["zmb_corpse_eater_feed"], self, "j_head");
      playFXOnTag(level.var_611["dark_energy_burst"], var_00, "J_Head");
      lib_0378::func_8D74("aud_corpse_eater_soul_suck", self.var_116, var_0C.var_116);
      thread kill_zombie_target(var_0C);
    }
  }

  maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_01, 0, 1, "scripted_anim");
  self notify("corpse_eater_end_feed");
}

zombie_corpse_eater_params() {
  var_00 = lib_054D::func_AC22();
  var_00["script_var"] = "sizzler_dlc4";
  return var_00;
}

periodically_spawn_corpse_eaters() {
  var_00 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  var_01 = [];
  level.plr_training_time = 0;
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_8260) && issubstr(var_03.var_8260, "corpse_eater_enabled")) {
      var_01 = common_scripts\utility::func_F6F(var_01, var_03);
    }
  }

  var_05 = 3;
  for(;;) {
    while(!isDefined(level.var_A980) || level.var_A980 < var_05) {
      wait 0.05;
    }

    while(!players_are_training_zombies()) {
      level.plr_training_time++;
      wait(1);
    }

    foreach(var_03 in common_scripts\utility::func_F92(var_01)) {
      if(var_03 lib_055A::func_905D()) {
        var_07 = lib_054D::func_90BA("zombie_dlc4", var_03, "corpse_eater", 1, 1, 0);
        break;
      }
    }

    var_05 = level.var_A980 + 2;
    level.plr_training_time = 0;
  }
}

players_are_training_zombies() {
  if(lib_0547::func_408F().size > 5) {
    level.plr_training_time = 0;
    return 0;
  }

  return level.plr_training_time >= 180;
}

zombie_corpse_eater_vfx(param_00) {
  self endon("death");
  if(isDefined(self.poweredupfx)) {
    self.poweredupfx delete();
  }

  while(!should_detonate_on_players()) {
    wait 0.05;
  }

  self.poweredupfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_corpse_eater_zombie_smoldering"), self, "J_Spine4");
  triggerfx(self.poweredupfx);
  if(!common_scripts\utility::func_562E(param_00)) {
    lib_0378::func_8D74("aud_corpse_eater_fully_charged");
  }
}

zombie_corpse_eater_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_00 = 0.2;
  self.var_5A36 = 0;
  maps\mp\zombies\zombie_sizzler::zombie_sizzler_think_setup();
  self.custom_passive_action = ::zombie_corpse_eater_passive;
  self.var_6816 = 1;
  var_01 = 4;
  self.var_FB = int(self.var_FB * 3.8);
  self.var_BC = self.var_FB;
  for(;;) {
    wait(var_00);
    if(common_scripts\utility::func_562E(self.startcorpseeater)) {
      self.startcorpseeater = 0;
      self.var_5A36 = 4;
      var_01 = 0;
    }

    if(!isDefined(self.var_1928)) {
      var_01 = var_01 - var_00;
    }

    if(should_target_new_zombie(var_01)) {
      target_new_zombie();
    }

    if(should_kill_zombie_target()) {
      lib_0547::func_7D1A("corpse_eater_feed");
      continue;
    }

    if(lib_053C::func_4F8C()) {
      continue;
    }

    if(lib_053C::func_4F84()) {
      continue;
    }

    if(lib_053C::func_4F9B()) {
      continue;
    }

    if(lib_053C::func_4F9A()) {
      continue;
    }

    lib_053C::func_647();
  }
}

should_detonate_on_players() {
  if(!lib_0547::func_5565(self.var_A4B, "zombie_dlc4")) {
    return 0;
  }

  if(!isDefined(self.var_5A36)) {
    return 0;
  }

  if(self.var_5A36 < 5) {
    return 0;
  }

  return 1;
}

get_max_zombies_to_eat() {
  return 5;
}

should_target_new_zombie(param_00) {
  if(isDefined(self.var_5A36) && self.var_5A36 >= 5) {
    return 0;
  }

  return !isDefined(self.var_1928) && param_00 <= 0;
}

target_new_zombie() {
  var_00 = common_scripts\utility::func_40B0(self.var_116, get_all_zombies_for_ce());
  foreach(var_02 in var_00) {
    if(!var_02 lib_0547::func_4B2C()) {
      continue;
    }

    if(var_02 == self) {
      continue;
    }

    if(lib_0547::func_5565(level.zombie_king, var_02)) {
      continue;
    }

    if(isDefined(var_02.corpseeatertargetid)) {
      continue;
    }

    if(!lib_0547::func_5565(var_02.var_A4B, "zombie_generic") && !common_scripts\utility::func_562E(var_02.isdarkhost)) {
      continue;
    }

    level.zmb_corpse_eater_channel_counter++;
    var_02.corpseeatertargetid = level.zmb_corpse_eater_channel_counter;
    self.corpseeatertargetid = level.zmb_corpse_eater_channel_counter;
    self.var_1928 = var_02;
    break;
  }
}

unlink_corpseeater(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isDefined(self.poweredupfx)) {
    self.poweredupfx delete();
  }

  if(isDefined(self.loc_beam)) {
    self.loc_beam delete();
  }

  if(isDefined(self.secondary_loc_beams)) {
    foreach(var_0A in self.secondary_loc_beams) {
      if(isDefined(var_0A)) {
        var_0A delete();
      }
    }
  }

  if(!lib_0547::func_5565(self.var_A4B, "zombie_dlc4") && isDefined(param_01) && isPlayer(param_01)) {
    var_0C = get_my_corpse_eater();
    if(isDefined(var_0C) && isDefined(self.var_8E1) && lib_0547::func_5565(self.var_8E1.var_109, "tesla_shock")) {
      self.beingeatenbyce = 1;
      var_0D = lib_0580::func_8317(self.var_116, param_01);
      var_0D.var_6AA0 = ::lib_0557::func_30D8;
      var_0C thread lib_0547::func_7D1A("tesla_shock", [var_0D], 1.8);
    }
  }

  if(!isDefined(self.corpseeatertargetid)) {
    return;
  }

  foreach(var_0F in get_all_zombies_for_ce()) {
    if(var_0F is_corpse_eater_linked(self)) {
      var_0F.var_1928 = undefined;
      var_0F.corpseeatertargetid = undefined;
    }
  }
}

is_corpse_eater_linked(param_00) {
  if(param_00 == self) {
    return 0;
  }

  if(lib_0547::func_5565(self.corpseeatertargetid, param_00.corpseeatertargetid)) {
    return 1;
  }

  return 0;
}

get_my_corpse_eater() {
  foreach(var_01 in get_all_zombies_for_ce()) {
    if(var_01 is_corpse_eater_linked(self)) {
      return var_01;
    }
  }
}

should_kill_zombie_target() {
  var_00 = get_target_zombie();
  if(!isDefined(var_00)) {
    return 0;
  }

  return distance(self.var_116, var_00.var_116) < 96;
}

kill_zombie_target(param_00) {
  self endon("death");
  if(!isDefined(param_00)) {
    var_01 = get_target_zombie();
  } else {
    var_01 = var_01;
  }

  if(common_scripts\utility::func_562E(var_01.var_2FDA)) {
    var_01 dodamage(var_01.var_BC + 1, self.var_116);
    return;
  }

  var_02 = lib_0580::func_8317(var_01.var_116, self);
  var_01 thread lib_0547::func_7D1A("tesla_shock", [var_02], 1.8);
  if(!isDefined(var_01)) {
    return;
  }

  wait(1.8);
  var_03 = var_01.var_BC;
  var_01.soulcollectinvalid = 1;
  self notify("corpse_eater_feed_on_target", var_01);
  if(common_scripts\utility::func_562E(var_01.isdarkhost)) {
    var_01 suicide();
  } else if(!common_scripts\utility::func_562E(var_01.var_2FDA) && !lib_0547::func_5565(var_01.var_A4B, "zombie_fireman")) {
    var_01 maps\mp\mp_zombies_soul_collection::func_865C("scripted_soul_eat", 0);
  }

  if(!isDefined(self.var_5A36)) {
    self.var_5A36 = 0;
  }

  self.var_5A36++;
  self.var_FB = self.var_FB + int(var_03 * 0.35);
  self.var_BC = self.var_FB;
  var_01 dodamage(var_01.var_BC + 1, self.var_116);
}

zombie_corpse_eater_on_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(param_02 >= self.var_BC || lib_0547::func_5731()) {
    if(isDefined(param_05) && issubstr(param_05, "scythe_emp") || issubstr(param_05, "scythe_cleave_emp")) {
      if(isDefined(self.poweredupfx)) {
        self.poweredupfx delete();
      }
    } else if(should_detonate_on_players()) {
      if(!common_scripts\utility::func_562E(self.detonating)) {
        self.detonating = 1;
        self.my_killer = param_01;
        self.my_killer_weapon = param_05;
        self.my_killer_smod = param_04;
        if(isDefined(self.my_killer) && isPlayer(self.my_killer)) {
          if(isDefined(self.my_killer_weapon) && issubstr(self.my_killer_weapon, "scythe")) {
            self.my_killer thread maps\mp\mp_zombie_descent_ee_main::give_player_the_corpse_eater_spine();
          }
        }

        thread lib_0547::func_7D1A("corpse_eater_detonate");
      }
    } else {}
  }

  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

zombie_corpse_eater_on_damaged_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  lib_054D::func_6BD3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

try_detonation() {
  if(isDefined(self.poweredupfx)) {
    self.poweredupfx delete();
  }

  if(should_detonate_on_players()) {
    var_00 = self gettagorigin("TAG_ORIGIN");
    playFX(level.var_611["zmb_corpse_eater_detonate"], var_00);
    lib_0378::func_8D74("aud_corpse_eater_explosion");
    level notify("ce_explosion", self.var_116);
    var_01 = 240;
    var_02 = 200;
    var_03 = 80;
    if(lib_0547::is_solo() && common_scripts\utility::func_562E(self.cenerfedexplosion)) {
      radiusdamage(self.var_116, var_01, var_02 / 2, var_03 / 2, self, "MOD_EXPLOSIVE", "corpse_eater_dlc4_zm", 1);
      return;
    }

    radiusdamage(self.var_116, var_01, var_02, var_03, self, "MOD_EXPLOSIVE", "corpse_eater_dlc4_zm", 1);
  }
}

get_ce_requirement() {
  return 5;
}

set_corpse_eater_full() {
  var_00 = self;
  var_00.var_5A36 = 5;
}

zombie_corpse_eater_passive() {
  self endon("zombie_passive");
  self endon("death");
  for(;;) {
    var_00 = maps\mp\agents\_scripted_agent_anim_util::func_434D("idle_noncombat");
    var_01 = maps\mp\agents\_scripted_agent_anim_util::func_7A35(var_00);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_1D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, var_01, 1, "idle_anim");
  }
}