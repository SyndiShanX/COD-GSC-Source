/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_extrahealth.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\_snd_common_mp;

CONST_EXTRA_HEALTH_MULTIPLIER = 1.4;

watchExtraHealthUsage() {
  self notify("exo_health_taken");

  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_health_taken");

  if(!self HasWeapon("extra_health_mp")) {
    return;
  }

  ExtraHealthInit();

  self thread MonitorPlayerDeath();
  self thread wait_for_game_end();

  while(1) {
    self waittill("exo_ability_activate", weapname);
    if(weapname == "extra_health_mp") {
      if(!IsAlive(self)) {
        return;
      }

      thread tryUseExtraHealth();
    }
  }
}

ExtraHealthInit() {
  self.exo_health_on = false;

  self BatterySetDischargeScale("extra_health_mp", 1.0);
  full_energy = self BatteryGetSize("extra_health_mp");

  if(self GetTacticalWeapon() == "extra_health_mp") {
    self SetClientOmnvar("exo_ability_nrg_req0", 0);
    self SetClientOmnvar("exo_ability_nrg_total0", full_energy);
    self SetClientOmnvar("ui_exo_battery_level0", full_energy);
  } else if(self GetLethalWeapon() == "extra_health_mp") {
    self SetClientOmnvar("exo_ability_nrg_req1", 0);
    self SetClientOmnvar("exo_ability_nrg_total1", full_energy);
    self SetClientOmnvar("ui_exo_battery_level1", full_energy);
  }

  if(!isDefined(level.exo_health_le_inactive_vfx)) {
    level.exo_health_le_inactive_vfx = LoadFX("vfx/unique/exo_health_le_inactive");
  }
  if(!isDefined(level.exo_health_le_active_vfx)) {
    level.exo_health_le_active_vfx = LoadFX("vfx/unique/exo_health_le_active");
  }
  if(!isDefined(level.exo_health_rt_inactive_vfx)) {
    level.exo_health_rt_inactive_vfx = LoadFX("vfx/unique/exo_health_rt_inactive");
  }
  if(!isDefined(level.exo_health_rt_active_vfx)) {
    level.exo_health_rt_active_vfx = LoadFX("vfx/unique/exo_health_rt_active");
  }

  wait(0.05);

  if(!inVirtualLobby()) {
    playFXOnTag(level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE");
    playFXOnTag(level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI");
  }
}

tryUseExtraHealth() {
  self endon("exo_health_taken");

  if(self.exo_health_on == true) {
    self thread StopExtraHealth(true);
  } else {
    self thread StartExtraHealth();
  }
}

killStimFx() {
  if(isDefined(self.stim_fx_l)) {
    self.stim_fx_l delete();
    self.stim_fx_l = undefined;
  }
  if(isDefined(self.stim_fx_r)) {
    self.stim_fx_r delete();
    self.stim_fx_r = undefined;
  }
}

StartExtraHealth() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_health_taken");
  self endon("EndExtraHealth");

  self.exo_health_on = true;

  self.maxhealth = int(self.maxhealth * CONST_EXTRA_HEALTH_MULTIPLIER);
  self.ignoreRegenDelay = true;
  self.healthRegenLevel = .99;
  self notify("damage");

  self BatteryDischargeBegin("extra_health_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("extra_health_mp", "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud("extra_health_mp");

  self thread monitory_health_battery_charge();

  self snd_message("mp_exo_health_activate");

  self killStimFx();

  wait(0.05);

  if(!self.exo_health_on) {
    return;
  }

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
    self.stim_fx_l = SpawnLinkedFX(level.exo_health_le_active_vfx, self, "J_Shoulder_LE");
    self.stim_fx_r = SpawnLinkedFX(level.exo_health_rt_active_vfx, self, "J_Shoulder_RI");
    TriggerFX(self.stim_fx_l);
    TriggerFX(self.stim_fx_r);
  }

}

StopExtraHealth(should_play_fx) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_health_taken");

  if(!isDefined(self.exo_health_on) || !self.exo_health_on) {
    return;
  }

  self notify("EndExtraHealth");

  self endon("EndExtraHealth");

  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  self.exo_health_on = false;

  if(isDefined(level.isHorde)) {
    class = self GetClientOmnvar("ui_horde_player_class");
    self.maxhealth = self.classSettings[class]["classhealth"];
  } else {
    self.maxhealth = int(self.maxhealth / CONST_EXTRA_HEALTH_MULTIPLIER);
  }

  if(self.health > self.maxhealth) {
    self.health = self.maxhealth;
  }

  self.healthRegenLevel = undefined;

  self BatteryDischargeEnd("extra_health_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("extra_health_mp", "ui_exo_battery_toggle", 0);

  self killStimFx();

  if(should_play_fx == true) {
    self snd_message("mp_exo_health_deactivate");

    wait(0.05);

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
      self.stim_fx_l = SpawnLinkedFx(level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE");
      self.stim_fx_r = SpawnLinkedFx(level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI");
      TriggerFX(self.stim_fx_l);
      TriggerFX(self.stim_fx_r);
    }
  }

}

MonitorPlayerDeath() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_health_taken");

  self thread StopExtraHealth(false);
}

monitory_health_battery_charge() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_health_taken");

  while(self.exo_health_on == true) {
    if(self BatteryGetCharge("extra_health_mp") <= 0) {
      self thread StopExtraHealth(true);
    }

    wait(0.05);
  }
}

take_exo_health() {
  self notify("kill_battery");
  self notify("exo_health_taken");
  self takeWeapon("extra_health_mp");
}

give_exo_health() {
  self giveWeapon("extra_health_mp");
  self thread watchExtraHealthUsage();
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_health_taken");

  level waittill("game_ended");

  self thread StopExtraHealth(false);
}

PrintHealthToScreen() {
  self endon("EndExtraHealth");
  self endon("death");
  self endon("exo_health_taken");

  while(true) {
    IPrintLnBold(self.health);
    wait 1;
  }
}