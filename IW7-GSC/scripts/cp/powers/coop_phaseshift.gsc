/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = 5;
  self notify("phase_shift_power_activated");
  if(!isentityphaseshifted(self)) {
    func_6626(1, var_0);
  }

  scripts\cp\powers\coop_powers::func_4575(var_0, "powers_phase_shift_update", "phaseshift_interrupted");
  exitphaseshift();
  wait(0.1);
}

func_6626(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 5;
  }

  self notify("phase_shift_start");
  func_F7E3(1);
  scripts\cp\powers\coop_powers::activatepower("power_phaseShift");
  if(getdvarint("bg_thirdPerson") == 0) {
    self visionsetnakedforplayer("phase_shift_mp", scripts\engine\utility::ter_op(var_0, 0.1, 0));
    if(var_0) {
      thread doscreenflash();
    }

    thread func_1090A(var_1);
  }

  self playlocalsound("ftl_phase_out");
  self playSound("ftl_phase_out_npc");
  func_2A71(self, var_1);
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

exitphaseshift(var_0) {
  self notify("phase_shift_completed");
  self playanimscriptevent("power_exit", "phaseshift");
  self playlocalsound("ftl_phase_in");
  self playSound("ftl_phase_in_npc");
  if(getdvarint("bg_thirdPerson") == 0) {
    if(!isDefined(var_0) || var_0) {
      doscreenflash();
    }
  }

  func_410A();
  self clearclienttriggeraudiozone(0.1);
}

func_10918(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  if(getdvarint("bg_thirdPerson") == 0) {
    var_1 hidefromplayer(self);
  }

  wait(0.1);
  playfxontagforteam(scripts\engine\utility::getfx(var_0 + "_friendly"), var_1, "tag_origin", self.team);
  playfxontagforteam(scripts\engine\utility::getfx(var_0), var_1, "tag_origin", scripts\cp\utility::getotherteam(self.team));
  wait(0.15);
  var_1 delete();
}

func_1090A(var_0) {
  var_1 = spawnfxforclient(scripts\engine\utility::getfx("vfx_phaseshift_fp_scrn"), (0, 0, 0), self);
  var_1 setfxkilldefondelete();
  triggerfx(var_1);
  scripts\engine\utility::waittill_any_timeout_1(var_0, "death", "phase_shift_completed");
  var_1 delete();
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

func_108EE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_1.origin);
  var_5 setModel("tag_origin");
  var_5.triggerportableradarping = var_1;
  var_5.var_CACB = var_2;
  var_5.var_762C = var_0;
  wait(0.1);
  if(var_1 == var_2) {
    playfxontagforteam(var_0, var_5, "tag_origin", var_3);
    var_5 hidefromplayer(var_2);
  } else {
    playfxontagforclients(var_0, var_5, "tag_origin", var_2);
  }

  var_5 thread func_12EEA(var_4);
}

func_2A71(var_0, var_1) {
  var_2 = undefined;
  if(var_0.team == "allies") {
    var_2 = "axis";
  } else if(var_0.team == "axis") {
    var_2 = "allies";
  }

  thread func_108EE(scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"), var_0, var_0, var_2, var_1);
  var_3 = scripts\engine\utility::ter_op(level.teambased, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
  thread func_108EE(var_3, var_0, var_0, var_0.team, var_1);
  foreach(var_5 in level.players) {
    if(var_5 == var_0) {
      continue;
    }

    var_6 = scripts\engine\utility::ter_op(level.teambased && var_5.team == var_0.team, scripts\engine\utility::getfx("vfx_phase_shift_trail_friendly"), scripts\engine\utility::getfx("vfx_phase_shift_trail_enemy"));
    thread func_108EE(var_6, var_5, var_0, var_0.team, var_1);
  }
}

func_12EEA(var_0) {
  var_1 = 0;
  var_2 = 0.15;
  for(;;) {
    if(!isDefined(self) || !isDefined(self.triggerportableradarping) || !scripts\cp\utility::isreallyalive(self.triggerportableradarping) || !isDefined(self.var_CACB) || !scripts\cp\utility::isreallyalive(self.var_CACB) || !isentityphaseshifted(self.var_CACB) || var_1 > var_0) {
      self.origin = self.origin + (0, 0, 10000);
      wait(0.2);
      self delete();
      return;
    }

    var_1 = var_1 + var_2;
    if(self.var_CACB == self.triggerportableradarping) {
      foreach(var_4 in level.players) {
        if(!areentitiesinphase(var_4, self.triggerportableradarping)) {
          self showtoplayer(var_4);
          continue;
        }

        self hidefromplayer(var_4);
      }
    } else {
      foreach(var_4 in level.players) {
        if(!areentitiesinphase(var_4, self.triggerportableradarping)) {
          self showtoplayer(self.triggerportableradarping);
          continue;
        }

        self hidefromplayer(self.triggerportableradarping);
      }
    }

    self moveto(self.triggerportableradarping.origin, var_2);
    wait(var_2);
  }
}

doscreenflash() {
  scripts\engine\utility::waitframe();
  if(isDefined(self)) {
    playfxontagforclients(scripts\engine\utility::getfx("vfx_screen_flash"), self, "tag_eye", self);
  }
}

isentityphaseshifted(var_0) {
  return isDefined(var_0) && isplayer(var_0) || isagent(var_0) && var_0 isinphase();
}

areentitiesinphase(var_0, var_1) {
  var_2 = isentityphaseshifted(var_0);
  var_3 = isentityphaseshifted(var_1);
  return (var_2 && var_3) || !var_3 && !var_2;
}

func_F7E3(var_0) {
  return self setphasestatus(var_0);
}

outline_enemies() {
  self endon("disconnect");
  level endon("game_ended");
  while(isentityphaseshifted(self)) {
    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_3, var_2 in var_0) {
      if(!isalive(var_2)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.pet)) {
        wait(0.2);
        continue;
      }

      if(isDefined(level.var_A71C) && var_2 == level.var_A71C) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.agent_type) && var_2.agent_type == "kraken_tentacle") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.agent_type) && var_2.agent_type == "spawn_tentacle") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.agent_type) && var_2.agent_type == "spider") {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.damaged_by_players)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.marked_for_challenge)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.marked_by_hybrid)) {
        scripts\cp\cp_outline::enable_outline_for_player(var_2, self, 1, 0, 0, "high");
        wait(0.2);
        continue;
      }

      if(isDefined(var_2.feral_occludes)) {
        wait(0.2);
        continue;
      }

      if(isentityphaseshifted(self)) {
        scripts\cp\cp_outline::enable_outline_for_player(var_2, self, 2, 0, 0, "high");
        wait(0.2);
        continue;
      }

      if(isDefined(self.var_9DF2) && self.var_9DF2 == 1) {
        wait(0.2);
        continue;
      }

      if(var_3 % 2 == 0) {
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
  var_0 = self getcurrentweapon();
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\cp\utility::_giveweapon("phaseshift_activation_mp");
  self switchtoweaponimmediate("phaseshift_activation_mp");
  scripts\engine\utility::waitframe();
  self switchtoweapon(var_0);
  wait(0.2);
  scripts\engine\utility::allow_weapon_switch(1);
  self takeweapon("phaseshift_activation_mp");
}