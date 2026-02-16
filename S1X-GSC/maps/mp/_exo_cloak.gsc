/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_cloak.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_snd_common_mp;

give_exo_cloak() {
  cloakWeapon = get_exo_cloak_weapon();

  if(self HasWeapon(cloakWeapon)) {
    return;
  }

  self giveWeapon(cloakWeapon);

  self BatterySetDischargeScale(cloakWeapon, 1.0);

  self.exo_cloak_on = false;
  self.exo_cloak_off_time = undefined;

  if(self GetTacticalWeapon() == cloakWeapon) {
    self SetClientOmnvar("ui_exo_battery_level0", self BatteryGetCharge(cloakWeapon));
    self SetClientOmnvar("exo_ability_nrg_req0", BatteryReqToUse(cloakWeapon));
    self SetClientOmnvar("exo_ability_nrg_total0", self BatteryGetSize(cloakWeapon));
  } else if(self GetLethalWeapon() == cloakWeapon) {
    self SetClientOmnvar("ui_exo_battery_level1", self BatteryGetCharge(cloakWeapon));
    self SetClientOmnvar("exo_ability_nrg_req1", BatteryReqToUse(cloakWeapon));
    self SetClientOmnvar("exo_ability_nrg_total1", self BatteryGetSize(cloakWeapon));
  }

  if(!isDefined(self.exocloak)) {
    self.exocloak = spawnStruct();
  }

  self.exocloak.costume = [];
  self.exocloak.costume["viewmodel"] = self GetViewModel();
  self.exocloak.costume["body"] = self GetModelFromEntity();

  assert(isDefined(self.exocloak.costume["viewmodel"]));
  assert(isDefined(self.exocloak.costume["body"]));

  self notify("exo_cloak_reset");

  self thread wait_for_exocloak_cancel();
  self thread wait_for_exocloak_pressed();
  self thread wait_for_player_death();
  self thread wait_for_game_end();
}

wait_for_exocloak_pressed() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("exo_cloak_reset");

  while(true) {
    self waittill("exo_ability_activate", weaponName);

    if(weaponName == level.cloakWeapon) {
      if(!self IsCloaked()) {
        self thread handle_exocloak();
      } else {
        self active_cloaking_disable(true);
      }
    } else if(!is_exo_ability_weapon(weaponname)) {
      self active_cloaking_disable(true);
    }
  }
}

wait_for_exocloak_cancel() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("exo_cloak_reset");

  while(true) {
    self waittill_any("using_remote", "weapon_fired", "melee_fired", "ground_slam", "grenade_fire");

    self active_cloaking_disable(true);
  }
}

wait_for_player_death() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("exo_cloak_reset");

  self waittill_any("death", "faux_spawn", "joined_team");

  self active_cloaking_disable(true);
}

handle_exocloak() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("exo_cloak_disabled");
  self endon("exo_cloak_reset");

  if(self BatteryGetCharge(level.cloakWeapon) > 0) {
    self active_cloaking_enable();

    while(self BatteryGetCharge(level.cloakWeapon) > 0) {
      wait 0.05;
    }

    self active_cloaking_disable(true);
  }
}

active_cloaking_enable() {
  println("active_cloaking_enable() called.");

  self.exo_cloak_on = true;
  self.exo_cloak_off_time = undefined;

  self CloakingEnable();

  self hideAttachmentsWhileCloaked();

  self BatteryDischargeBegin(level.cloakWeapon);

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.cloakWeapon, "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud(level.cloakWeapon);

  self snd_message("mp_exo_cloak_activate");

  self.pers["numberOfTimesCloakingUsed"]++;

  if(isDefined(level.isHorde)) {
    wait 2;
    self.ignoreme = true;
  }
}

active_cloaking_disable(should_play_fx)

{
  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  if(!self IsCloaked()) {
    return;
  }

  println("active_cloaking_disable() called.");

  self.exo_cloak_on = false;
  self.exo_cloak_off_time = GetTime();

  self CloakingDisable();

  self showAttachmentsAfterCloak();

  if(isDefined(level.isHorde)) {
    self.ignoreme = false;
  }

  self BatteryDischargeEnd(level.cloakWeapon);

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.cloakWeapon, "ui_exo_battery_toggle", 0);

  if(should_play_fx) {
    self snd_message("mp_exo_cloak_deactivate");
  }

  self notify("exo_cloak_disabled");
}

take_exo_cloak() {
  cloakWeapon = get_exo_cloak_weapon();

  self notify("kill_battery");
  self active_cloaking_disable(false);
  self takeWeapon(cloakWeapon);
  self notify("exo_cloak_reset");
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_cloak_reset");

  level waittill("game_ended");

  self active_cloaking_disable(true);
}

hideAttachmentsWhileCloaked() {
  if(self HasWeapon("adrenaline_mp")) {
    if(isDefined(self.overclock_on) && self.overclock_on == true) {
      KillFXOnTag(level.exo_overclock_vfx_le_active, self, "J_Hip_LE");
      KillFXOnTag(level.exo_overclock_vfx_ri_active, self, "J_Hip_RI");
    } else {
      KillFXOnTag(level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE");
      KillFXOnTag(level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI");
    }
  }

  if(self HasWeapon("exorepulsor_equipment_mp")) {
    if(isDefined(self.repulsorActive) && self.repulsorActive == true) {
      KillFXOnTag(level.exo_repulsor_player_vfx_active, self, "TAG_JETPACK");
    } else {
      KillFXOnTag(level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK");
    }
  }

  if(self HasWeapon("exoping_equipment_mp")) {
    if(isDefined(self.exo_ping_on) && self.exo_ping_on == true) {
      KillFXOnTag(level.exo_ping_vfx_active, self, "J_SpineUpper");
    } else {
      KillFXOnTag(level.exo_ping_vfx_inactive, self, "J_SpineUpper");
    }
  }

  if(self HasWeapon("extra_health_mp")) {
    if(isDefined(self.exo_health_on) && self.exo_health_on == true) {
      KillFXOnTag(level.exo_health_le_active_vfx, self, "J_Shoulder_LE");
      KillFXOnTag(level.exo_health_rt_active_vfx, self, "J_Shoulder_RI");
    } else {
      KillFXOnTag(level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE");
      KillFXOnTag(level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI");
    }
  }
}

showAttachmentsAfterCloak() {
  if(self HasWeapon("adrenaline_mp")) {
    if(isDefined(self.overclock_on) && self.overclock_on == true) {
      playFXOnTag(level.exo_overclock_vfx_le_active, self, "J_Hip_LE");
      playFXOnTag(level.exo_overclock_vfx_ri_active, self, "J_Hip_RI");
    } else {
      playFXOnTag(level.exo_overclock_vfx_le_inactive, self, "J_Hip_LE");
      playFXOnTag(level.exo_overclock_vfx_ri_inactive, self, "J_Hip_RI");
    }
  }

  if(self HasWeapon("exorepulsor_equipment_mp")) {
    if(isDefined(self.repulsorActive) && self.repulsorActive == true) {
      playFXOnTag(level.exo_repulsor_player_vfx_active, self, "TAG_JETPACK");
    } else {
      playFXOnTag(level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK");
    }
  }

  if(self HasWeapon("exoping_equipment_mp")) {
    if(isDefined(self.exo_ping_on) && self.exo_ping_on == true) {
      playFXOnTag(level.exo_ping_vfx_active, self, "J_SpineUpper");
    } else {
      playFXOnTag(level.exo_ping_vfx_inactive, self, "J_SpineUpper");
    }
  }

  if(self HasWeapon("extra_health_mp")) {
    if(isDefined(self.exo_health_on) && self.exo_health_on == true) {
      playFXOnTag(level.exo_health_le_active_vfx, self, "J_Shoulder_LE");
      playFXOnTag(level.exo_health_rt_active_vfx, self, "J_Shoulder_RI");
    } else {
      playFXOnTag(level.exo_health_le_inactive_vfx, self, "J_Shoulder_LE");
      playFXOnTag(level.exo_health_rt_inactive_vfx, self, "J_Shoulder_RI");
    }
  }
}

get_exo_cloak_weapon() {
  if(isDefined(level.cloakWeapon)) {
    return level.cloakWeapon;
  }

  level.cloakWeapon = "exocloak_equipment_mp";
  if(isDefined(level.isHorde)) {
    level.cloakWeapon = "exocloakhorde_equipment_mp";
  }

  return level.cloakWeapon;
}