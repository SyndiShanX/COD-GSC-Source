/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_adrenaline.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\_snd_common_mp;

CONST_Adrenaline_SpeedScale = 1.12;
CONST_Adrenaline_Timeout = 10;

watchAdrenalineUsage() {
  self notify("exo_overclock_taken");

  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_overclock_taken");

  if(!self HasWeapon("adrenaline_mp")) {
    return;
  }

  self AdrenalineInit();

  self thread MonitorPlayerDeath();
  self thread wait_for_game_end();

  while(1) {
    self waittill("exo_adrenaline_fire");

    if(!IsAlive(self)) {
      return;
    }

    self thread tryUseAdrenaline();
  }
}

AdrenalineInit() {
  self.overclock_on = false;

  self BatterySetDischargeScale("adrenaline_mp", 1.0);
  full_energy = self BatteryGetSize("adrenaline_mp");

  if(self GetTacticalWeapon() == "adrenaline_mp") {
    self SetClientOmnvar("exo_ability_nrg_req0", 0);
    self SetClientOmnvar("exo_ability_nrg_total0", full_energy);
    self SetClientOmnvar("ui_exo_battery_level0", full_energy);
  } else if(self GetLethalWeapon() == "adrenaline_mp") {
    self SetClientOmnvar("exo_ability_nrg_req1", 0);
    self SetClientOmnvar("exo_ability_nrg_total1", full_energy);
    self SetClientOmnvar("ui_exo_battery_level1", full_energy);
  }

  if(!isDefined(level.exo_overclock_vfx_le_active)) {
    level.exo_overclock_vfx_le_active = LoadFX("vfx/lights/exo_overclock_hip_le_start");
  }
  if(!isDefined(level.exo_overclock_vfx_ri_active)) {
    level.exo_overclock_vfx_ri_active = LoadFX("vfx/lights/exo_overclock_hip_ri_start");
  }
  if(!isDefined(level.exo_overclock_vfx_le_inactive)) {
    level.exo_overclock_vfx_le_inactive = LoadFX("vfx/lights/exo_overclock_hip_le_inactive");
  }
  if(!isDefined(level.exo_overclock_vfx_ri_inactive)) {
    level.exo_overclock_vfx_ri_inactive = LoadFX("vfx/lights/exo_overclock_hip_ri_inactive");
  }

  wait(0.05);

  if(!inVirtualLobby()) {
    playFXOnTag(level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE");
    playFXOnTag(level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI");
  }
}

tryUseAdrenaline() {
  self endon("exo_overclock_taken");

  if(self.overclock_on == true) {
    self thread StopAdrenaline(true);
  } else {
    self thread StartAdrenaline();
  }
}

killOverclockFx() {
  if(isDefined(self.overclock_fx_l)) {
    self.overclock_fx_l delete();
    self.overclock_fx_l = undefined;
  }
  if(isDefined(self.overclock_fx_r)) {
    self.overclock_fx_r delete();
    self.overclock_fx_r = undefined;
  }
}

StartAdrenaline() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_overclock_taken");
  self endon("EndAdrenaline");

  self.overclock_on = true;

  maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

  self.adrenaline_speed_scalar = CONST_Adrenaline_SpeedScale;

  if(self _hasPerk("specialty_lightweight")) {
    self.moveSpeedScaler = self.adrenaline_speed_scalar + (lightWeightScalar() - 1);
  } else {
    self.moveSpeedScaler = self.adrenaline_speed_scalar;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    class = self GetClientOmnvar("ui_horde_player_class");
    self.moveSpeedScaler = min((level.classSettings[class]["speed"] + 0.25), CONST_Adrenaline_SpeedScale);
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self BatteryDischargeBegin("adrenaline_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("adrenaline_mp", "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud("adrenaline_mp");

  self thread monitor_overclock_battery_charge();

  self snd_message("mp_exo_overclock_activate");

  self killOverclockFx();

  wait(0.05);

  if(!self.overclock_on) {
    return;
  }

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
    self.overclock_fx_l = SpawnLinkedFx(level.exo_overclock_vfx_le_active, self, "J_Hip_LE");
    self.overclock_fx_r = SpawnLinkedFx(level.exo_overclock_vfx_ri_active, self, "J_Hip_RI");
    TriggerFX(self.overclock_fx_l);
    TriggerFX(self.overclock_fx_r);
  }
}

StopAdrenaline(should_play_fx) {
  if(!isDefined(self.overclock_on) || !self.overclock_on) {
    return;
  }

  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  self notify("EndAdrenaline");

  self.overclock_on = false;

  if(self _hasPerk("specialty_lightweight")) {
    self.moveSpeedScaler = lightWeightScalar();
  } else {
    self.moveSpeedScaler = level.basePlayerMoveScale;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    class = self GetClientOmnvar("ui_horde_player_class");
    self.moveSpeedScaler = level.classSettings[class]["speed"];
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self.adrenaline_speed_scalar = undefined;

  self BatteryDischargeEnd("adrenaline_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("adrenaline_mp", "ui_exo_battery_toggle", 0);

  self killOverclockFx();

  if(should_play_fx == true) {
    self snd_message("mp_exo_overclock_deactivate");

    wait(0.05);

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
      self.overclock_fx_l = SpawnLinkedFx(level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE");
      self.overclock_fx_r = SpawnLinkedFx(level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI");
      TriggerFX(self.overclock_fx_l);
      TriggerFX(self.overclock_fx_r);
    }
  }

}

MonitorPlayerDeath() {
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_overclock_taken");

  self thread StopAdrenaline(false);
}

monitor_overclock_battery_charge() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_overclock_taken");
  self endon("EndAdrenaline");

  while(self.overclock_on == true) {
    if(self BatteryGetCharge("adrenaline_mp") <= 0) {
      thread StopAdrenaline(true);
    }

    wait(0.05);
  }
}

take_exo_overclock() {
  self notify("kill_battery");
  self notify("exo_overclock_taken");
  self takeWeapon("adrenaline_mp");
}

give_exo_overclock() {
  self giveWeapon("adrenaline_mp");
  self thread watchAdrenalineUsage();
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_overclock_taken");

  level waittill("game_ended");

  self thread StopAdrenaline(false);
}