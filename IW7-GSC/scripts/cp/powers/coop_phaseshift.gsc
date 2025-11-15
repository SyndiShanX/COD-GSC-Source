/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_phaseshift.gsc
*************************************************/

init() {
  level._effect["vfx_phase_shift_start"] = loadfx("vfx\old\_requests\archetypes\vfx_phase_shift_start_volume");
  level._effect["vfx_phase_shift_end"] = loadfx("vfx\old\_requests\archetypes\vfx_phase_shift_start_volume");
  level._effect["vfx_phase_shift_start_friendly"] = loadfx("vfx\old\_requests\archetypes\vfx_phase_shift_start_volume_blue");
  level._effect["vfx_phase_shift_end_friendly"] = loadfx("vfx\old\_requests\archetypes\vfx_phase_shift_start_volume_blue");
  level._effect["vfx_phase_shift_trail_friendly"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_fr.vfx");
  level._effect["vfx_phase_shift_trail_enemy"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_body_en.vfx");
  level._effect["vfx_screen_flash"] = loadfx("vfx\core\mp\core\vfx_screen_flash");
  level._effect["vfx_phaseshift_fp_scrn"] = loadfx("vfx\iw7\_requests\mp\vfx_phase_shift_scrn_warp.vfx");
}

func_E154() {
  self notify("remove_phase_shift");
  if(isentityphaseshifted(self)) {
    exitphaseshift(0);
  }
}

func_E88D() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_phase_shift");
  var_00 = 5;
  self notify("phase_shift_power_activated");
  if(!isentityphaseshifted(self)) {
    func_6626(1, var_00);
  }

  scripts\cp\powers\coop_powers::func_4575(var_00, "powers_phase_shift_update", "phaseshift_interrupted");
  exitphaseshift();
  wait(0.1);
}

func_6626(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 5;
  }

  self notify("phase_shift_start");
  func_F7E3(1);
  scripts\cp\powers\coop_powers::activatepower("power_phaseShift");
  if(getdvarint("bg_thirdPerson") == 0) {
    self visionsetnakedforplayer("phase_shift_mp", scripts\engine\utility::ter_op(param_00, 0.1, 0));
    if(param_00) {
      thread doscreenflash();
    }

    thread func_1090A(param_01);
  }

  self playlocalsound("ftl_phase_out");
  self playSound("ftl_phase_out_npc");
  func_2A71(self, param_01);
  self _meth_82C0("phaseshift_mp_shock", 0.1);
  thread func_13A57();
  scripts\cp\utility::allow_player_ignore_me(1);
  if(!scripts\engine\utility::istrue(level.no_power_cooldowns)) {
    scripts\cp\powers\coop_powers::power_modifycooldownrate(0);
  }

  if(!scripts\engine\utility::istrue(self.wor_phase_shift)) {
    self disableusability();
  }

  scripts\cp\utility::allow_player_interactions(0);
  scripts\cp\powers\coop_powers::power_disablepower();
  self.has_special_weapon = 1;
}

exitphaseshift(param_00) {
  self notify("phase_shift_completed");
  self playanimscriptevent("power_exit", "phaseshift");
  self playlocalsound("ftl_phase_in");
  self playSound("ftl_phase_in_npc");
  if(getdvarint("bg_thirdPerson") == 0) {
    if(!isDefined(param_00) || param_00) {
      doscreenflash();
    }
  }

  func_410A();
  self clearclienttriggeraudiozone(0.1);
}

func_10918(param_00) {
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("tag_origin");
  if(getdvarint("bg_thirdPerson") == 0) {
    var_01 hidefromplayer(self);
  }

  wait(0.1);
  playfxontagforteam(scripts\engine\utility::getfx(param_00 + "_friendly"), var_01, "tag_origin", self.team);
  playfxontagforteam(scripts\engine\utility::getfx(param_00), var_01, "tag_origin", scripts\cp\utility::getotherteam(self.team));
  wait(0.15);
  var_01 delete();
}

func_1090A(param_00) {
  var_01 = spawnfxforclient(scripts\engine\utility::getfx("vfx_phaseshift_fp_scrn"), (0, 0, 0), self);
  var_01 setfxkilldefondelete();
  triggerfx(var_01);
  scripts\engine\utility::waittill_any_timeout_1(param_00, "death", "phase_shift_completed");
  var_01 delete();
}

func_410A() {
  self visionsetnakedforplayer("", 0);
  self.has_special_weapon = 0;
  if(!scripts\engine\utility::istrue(level.no_power_cooldowns) || scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    scripts\cp\powers\coop_powers::func_D74E();
  }

  if(scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(0);
  }

  scripts\cp\powers\coop_powers::deactivatepower("power_phaseShift");
  if(!scripts\cp\utility::areinteractionsenabled()) {
    scripts\cp\utility::allow_player_interactions(1);
  }

  self enableusability();
  scripts\cp\powers\coop_powers::power_enablepower();
  func_F7E3(0);
}

func_13A57() {
  self endon("disconnect");
  self endon("phase_shift_completed");
  scripts\engine\utility::waittill_any_3("death", "remove_phase_shift");
  func_410A();
}

func_108EE(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawn("script_model", param_01.origin);
  var_05 setModel("tag_origin");
  var_05.triggerportableradarping = param_01;
  var_05.var_CACB = param_02;
  var_05.var_762C = param_00;
  wait(0.1);
  if(param_01 == param_02) {
    playfxontagforteam(param_00, var_05, "tag_origin", param_03);
    var_05 hidefromplayer(param_02);
  } else {
    playfxontagforclients(param_00, var_05, "tag_origin", param_02);
  }

  var_05 thread func_12EEA(param_04);
}

func_2A71(param_00, param_01) {
  var_02 = undefined;
  if(param_00.team == "allies") {
    var_02 = "axis";
  } else if(param_00.team == "axis") {
    var_02 = "allies";
  } else {}

  thread func_108EE(scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"), param_00, param_00, var_02, param_01);
  var_03 = scripts\engine\utility::ter_op(level.teambased, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
  thread func_108EE(var_03, param_00, param_00, param_00.team, param_01);
  foreach(var_05 in level.players) {
    if(var_05 == param_00) {
      continue;
    }

    var_06 = scripts\engine\utility::ter_op(level.teambased && var_05.team == param_00.team, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
    thread func_108EE(var_06, var_05, param_00, param_00.team, param_01);
  }
}

func_12EEA(param_00) {
  var_01 = 0;
  var_02 = 0.15;
  for(;;) {
    if(!isDefined(self) || !isDefined(self.triggerportableradarping) || !scripts\cp\utility::isreallyalive(self.triggerportableradarping) || !isDefined(self.var_CACB) || !scripts\cp\utility::isreallyalive(self.var_CACB) || !isentityphaseshifted(self.var_CACB) || var_01 > param_00) {
      self.origin = self.origin + (0, 0, 10000);
      wait(0.2);
      self delete();
      return;
    }

    var_01 = var_01 + var_02;
    if(self.var_CACB == self.triggerportableradarping) {
      foreach(var_04 in level.players) {
        if(!areentitiesinphase(var_04, self.triggerportableradarping)) {
          self showtoplayer(var_04);
          continue;
        }

        self hidefromplayer(var_04);
      }
    } else {
      foreach(var_04 in level.players) {
        if(!areentitiesinphase(var_04, self.triggerportableradarping)) {
          self showtoplayer(self.triggerportableradarping);
          continue;
        }

        self hidefromplayer(self.triggerportableradarping);
      }
    }

    self moveto(self.triggerportableradarping.origin, var_02);
    wait(var_02);
  }
}

doscreenflash() {
  scripts\engine\utility::waitframe();
  if(isDefined(self)) {
    playfxontagforclients(scripts\engine\utility::getfx("vfx_screen_flash"), self, "tag_eye", self);
  }
}

isentityphaseshifted(param_00) {
  return isDefined(param_00) && isplayer(param_00) || isagent(param_00) && param_00 isinphase();
}

areentitiesinphase(param_00, param_01) {
  var_02 = isentityphaseshifted(param_00);
  var_03 = isentityphaseshifted(param_01);
  return (var_02 && var_03) || !var_03 && !var_02;
}

func_F7E3(param_00) {
  return self setphasestatus(param_00);
}

outline_enemies() {
  self endon("disconnect");
  level endon("game_ended");
  while(isentityphaseshifted(self)) {
    var_00 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_03, var_02 in var_00) {
      if(!isalive(var_02)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.pet)) {
        wait(0.2);
        continue;
      }

      if(isDefined(level.var_A71C) && var_02 == level.var_A71C) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.agent_type) && var_02.agent_type == "kraken_tentacle") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.agent_type) && var_02.agent_type == "spawn_tentacle") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.agent_type) && var_02.agent_type == "spider") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.damaged_by_players)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.marked_for_challenge)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.marked_by_hybrid)) {
        scripts\cp\cp_outline::enable_outline_for_player(var_02, self, 1, 0, 0, "high");
        wait(0.2);
        continue;
      }

      if(isDefined(var_02.feral_occludes)) {
        wait(0.2);
        continue;
      }

      if(isentityphaseshifted(self)) {
        scripts\cp\cp_outline::enable_outline_for_player(var_02, self, 2, 0, 0, "high");
        wait(0.2);
        continue;
      }

      if(isDefined(self.var_9DF2) && self.var_9DF2 == 1) {
        wait(0.2);
        continue;
      }

      if(var_03 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.25);
  }

  scripts\cp\cp_outline::unset_outline();
}

func_135FA() {
  self endon("death");
  self endon("disconnect");
  self endon("exit_phase_shift");
  for(;;) {
    if(!isDefined(self)) {
      wait(1);
      break;
    }

    self waittill("power_secondary_used");
    break;
  }

  self notify("exit_phase_shift");
}

func_E830() {
  var_00 = self getcurrentweapon();
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\cp\utility::_giveweapon("phaseshift_activation_mp");
  self switchtoweaponimmediate("phaseshift_activation_mp");
  scripts\engine\utility::waitframe();
  self switchtoweapon(var_00);
  wait(0.2);
  scripts\engine\utility::allow_weapon_switch(1);
  self takeweapon("phaseshift_activation_mp");
}