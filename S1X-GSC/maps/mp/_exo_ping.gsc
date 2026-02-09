/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_ping.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_snd_common_mp;

EXO_PING_RANGE = 700;
EXO_PING_RANGE_SQ = 490000;
EXO_PING_DURATION = 1.5;
EXO_PING_THREAT_DURATION = 1.75;
MIN_TIME_BETWEEN_PINGS = 5000;

exo_ping_think() {
  self notify("exo_ping_taken");

  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_ping_taken");

  if(!self HasWeapon("exoping_equipment_mp")) {
    return;
  }

  self exo_ping_init();

  self thread toggle_exo_ping();
  self thread wait_for_player_death();
  self thread wait_for_game_end();
}

exo_ping_init() {
  self.exo_ping_on = false;

  self BatterySetDischargeScale("exoping_equipment_mp", 1.0);
  full_energy = self BatteryGetSize("exoping_equipment_mp");

  if(self GetTacticalWeapon() == "exoping_equipment_mp") {
    self SetClientOmnvar("ui_exo_battery_level0", full_energy);
    self SetClientOmnvar("exo_ability_nrg_req0", BatteryReqToUse("exoping_equipment_mp"));
    self SetClientOmnvar("exo_ability_nrg_total0", full_energy);
  } else if(self GetLethalWeapon() == "exoping_equipment_mp") {
    self SetClientOmnvar("ui_exo_battery_level1", full_energy);
    self SetClientOmnvar("exo_ability_nrg_req1", BatteryReqToUse("exoping_equipment_mp"));
    self SetClientOmnvar("exo_ability_nrg_total1", full_energy);
  }

  if(!isDefined(level.exo_ping_vfx_inactive)) {
    level.exo_ping_vfx_inactive = LoadFX("vfx/unique/exo_ping_inactive");
  }
  if(!isDefined(level.exo_ping_vfx_active)) {
    level.exo_ping_vfx_active = LoadFX("vfx/unique/exo_ping_active");
  }

  wait 0.05;

  if(!inVirtualLobby()) {
    playFXOnTag(level.exo_ping_vfx_inactive, self, "J_SpineUpper");
  }
}

toggle_exo_ping() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_ping_taken");

  while(true) {
    self waittill("exo_ability_activate", weapname);
    if(weapname != "exoping_equipment_mp") {
      continue;
    }

    if(self.exo_ping_on == true) {
      self thread stop_exo_ping();
    } else if(self HasWeapon("exoping_equipment_mp")) {
      if(self BatteryGetCharge("exoping_equipment_mp") > 0) {
        self start_exo_ping();
      }
    }
  }
}

monitor_exoping_battery_charge() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_ping_taken");
  self endon("stop_exo_ping");

  while(self.exo_ping_on == true) {
    if(self BatteryGetCharge("exoping_equipment_mp") <= 0) {
      self thread stop_exo_ping();
    }

    wait(0.05);
  }
}

take_exo_ping() {
  self notify("kill_battery");
  self notify("exo_ping_taken");
  self takeWeapon("exoping_equipment_mp");
}

give_exo_ping() {
  self giveWeapon("exoping_equipment_mp");
  self thread exo_ping_think();
}

killPingFx() {
  if(isDefined(self.ping_fx)) {
    self.ping_fx delete();
    self.ping_fx = undefined;
  }
}

start_exo_ping() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_ping_taken");
  self endon("stop_exo_ping");

  self.exo_ping_on = true;

  self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self, -1);

  self SetPerk("specialty_exo_ping", true, false);

  self BatteryDischargeOnce("exoping_equipment_mp", BatteryUsePerShot("exoping_equipment_mp"));
  self BatteryDischargeBegin("exoping_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exoping_equipment_mp", "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud("exoping_equipment_mp");

  self thread monitor_exoping_battery_charge();

  self snd_message("mp_exo_ping_activate");

  killPingFx();

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
    self.ping_fx = SpawnLinkedFx(level.exo_ping_vfx_active, self, "J_SpineUpper");
    TriggerFX(self.ping_fx);
  }
}

stop_exo_ping(should_play_fx) {
  if(!isDefined(self.exo_ping_on) || !self.exo_ping_on) {
    return;
  }

  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  self notify("stop_exo_ping");

  self.exo_ping_on = false;

  if(isDefined(self.highlight_effect)) {
    maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
  }

  self UnSetPerk("specialty_exo_ping", true);

  self BatteryDischargeEnd("exoping_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exoping_equipment_mp", "ui_exo_battery_toggle", 0);

  killPingFx();

  if(should_play_fx == true) {
    self snd_message("mp_exo_ping_deactivate");

    wait(0.05);

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
      self.ping_fx = SpawnLinkedFx(level.exo_ping_vfx_inactive, self, "J_SpineUpper");
      TriggerFX(self.ping_fx);
    }
  }

}

wait_for_player_death() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_ping_taken");

  self thread stop_exo_ping(false);
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_ping_taken");

  level waittill("game_ended");

  self thread stop_exo_ping(false);
}