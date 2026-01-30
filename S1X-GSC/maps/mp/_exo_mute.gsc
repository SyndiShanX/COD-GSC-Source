/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_mute.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\_snd_common_mp;

exo_mute_think() {
  self notify("exo_mute_taken");

  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_mute_taken");

  if(!self HasWeapon("exomute_equipment_mp")) {
    return;
  }

  self exo_mute_init();

  self thread monitor_player_death();
  self thread wait_for_game_end();

  while(1) {
    self waittill("exo_ability_activate", weapon_name);

    if(weapon_name == "exomute_equipment_mp") {
      self thread try_use_exo_mute();
    }
  }
}

exo_mute_init() {
  self.mute_on = false;

  self BatterySetDischargeScale("exomute_equipment_mp", 1.0);
  full_energy = self BatteryGetSize("exomute_equipment_mp");

  if(self GetTacticalWeapon() == "exomute_equipment_mp") {
    self SetClientOmnvar("exo_ability_nrg_req0", 0);
    self SetClientOmnvar("exo_ability_nrg_total0", full_energy);
    self SetClientOmnvar("ui_exo_battery_level0", full_energy);
  } else if(self GetLethalWeapon() == "exomute_equipment_mp") {
    self SetClientOmnvar("exo_ability_nrg_req1", 0);
    self SetClientOmnvar("exo_ability_nrg_total1", full_energy);
    self SetClientOmnvar("ui_exo_battery_level1", full_energy);
  }

  if(!isDefined(level.exo_mute_3p)) {
    level.exo_mute_3p = LoadFX("vfx/unique/exo_mute_3p");
  }

  wait(0.05);

  if(!inVirtualLobby()) {}
}

try_use_exo_mute() {
  self endon("exo_mute_taken");

  if(self.mute_on == true) {
    self thread stop_exo_mute(true);
  } else {
    self thread start_exo_mute();
  }
}

killMuteFx() {
  if(isDefined(self.mute_fx)) {
    self.mute_fx delete();
    self.mute_fx = undefined;
  }
}

start_exo_mute() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_mute_taken");
  self endon("end_exo_mute");

  self.mute_on = true;

  self givePerk("specialty_quieter", false);

  self BatteryDischargeBegin("exomute_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exomute_equipment_mp", "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud("exomute_equipment_mp");

  self thread monitor_mute_battery_charge();

  self snd_message("mp_exo_mute_activate");

  wait(0.05);

  if(!self.mute_on) {
    return;
  }

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
    self.mute_fx = SpawnLinkedFx(level.exo_mute_3p, self, "TAG_ORIGIN");
    TriggerFX(self.mute_fx);
  }
}

stop_exo_mute(should_play_fx) {
  if(!isDefined(self.mute_on) || !self.mute_on) {
    return;
  }

  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  self notify("end_exo_mute");

  self.mute_on = false;

  self UnSetPerk("specialty_quieter", true);

  self BatteryDischargeEnd("exomute_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exomute_equipment_mp", "ui_exo_battery_toggle", 0);

  killMuteFx();

  if(should_play_fx == true) {
    self snd_message("mp_exo_mute_deactivate");

    wait(0.05);

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {}
  }

}

monitor_player_death() {
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_mute_taken");

  self thread stop_exo_mute(false);
}

monitor_mute_battery_charge() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_mute_taken");
  self endon("end_exo_mute");

  while(self.mute_on == true) {
    if(self BatteryGetCharge("exomute_equipment_mp") <= 0) {
      thread stop_exo_mute(true);
    }

    wait(0.05);
  }
}

take_exo_mute() {
  self notify("kill_battery");
  self notify("exo_mute_taken");
  self takeWeapon("exomute_equipment_mp");
}

give_exo_mute() {
  self giveWeapon("exomute_equipment_mp");
  self thread exo_mute_think();
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_mute_taken");

  level waittill("game_ended");

  self thread stop_exo_mute(false);
}