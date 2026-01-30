/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_hover.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_snd_common_mp;

exo_hover_think() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_hover_taken");

  if(!self HasWeapon(level.hoverWeapon)) {
    return;
  }

  exo_hover_init();

  for(;;) {
    if(self BatteryIsInUse(level.hoverWeapon) == false) {
      self waittillmatch("battery_discharge_begin", level.hoverWeapon);
    }

    self.exo_hover_on = true;

    maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);

    self.pers["numberOfTimesHoveringUsed"]++;

    self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverWeapon, "ui_exo_battery_toggle", 1);

    self thread maps\mp\_exo_battery::update_exo_battery_hud(level.hoverWeapon);

    self thread exo_hover_update();
    self thread play_exo_hover_vfx();

    if(self _hasPerk("specialty_exo_blastsuppressor")) {
      self snd_message("mp_suppressed_exo_hover");
    } else {
      self snd_message("mp_regular_exo_hover");
    }

    self thread end_exo_hover_on_notifies();

    if(self BatteryIsInUse(level.hoverWeapon) == true) {
      self waittillmatch("battery_discharge_end", level.hoverWeapon);
    }

    self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverWeapon, "ui_exo_battery_toggle", 0);

    self.exo_hover_on = false;

    self notify("stop_exo_hover_effects");
  }
}

exo_hover_init() {
  self BatterySetDischargeScale(level.hoverWeapon, 1.0);
  maxCharge = self BatteryGetSize(level.hoverWeapon);
  if(self GetTacticalWeapon() == level.hoverWeapon) {
    self SetClientOmnvar("exo_ability_nrg_req0", 0);
    self SetClientOmnvar("exo_ability_nrg_total0", maxCharge);
    self SetClientOmnvar("ui_exo_battery_level0", maxCharge);
  } else if(self GetLethalWeapon() == level.hoverWeapon) {
    self SetClientOmnvar("exo_ability_nrg_req1", 0);
    self SetClientOmnvar("exo_ability_nrg_total1", maxCharge);
    self SetClientOmnvar("ui_exo_battery_level1", maxCharge);
  }

  if(!isDefined(level.regular_exo_hover_vfx)) {
    level.regular_exo_hover_vfx = LoadFX("vfx/smoke/exohover_exhaust_continuous");
  }
  if(!isDefined(level.suppressed_exo_hover_vfx)) {
    level.suppressed_exo_hover_vfx = LoadFX("vfx/smoke/exohover_exhaust_continuous_suppressed");
  }
}

end_exo_hover_on_notifies() {
  self endon("stop_exo_hover_effects");

  self waittill_any("death", "disconnect", "joined_team", "faux_spawn", "exo_hover_taken");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.hoverWeapon, "ui_exo_battery_toggle", 0);
  self.exo_hover_on = false;
  self notify("stop_exo_hover_effects");
}

take_exo_hover() {
  level.hoverWeapon = "exohover_equipment_mp";
  if(isDefined(level.isHorde)) {
    level.hoverWeapon = "exohoverhorde_equipment_mp";
  }

  self notify("kill_battery");
  self notify("exo_hover_taken");
  self takeWeapon(level.hoverWeapon);
}

give_exo_hover() {
  level.hoverWeapon = "exohover_equipment_mp";
  if(isDefined(level.isHorde)) {
    level.hoverWeapon = "exohoverhorde_equipment_mp";
  }

  self giveWeapon(level.hoverWeapon);
  self thread exo_hover_think();
}

exo_hover_update() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_hover_taken");
  self endon("stop_exo_hover_effects");

  dischargeRate = self BatteryGetDischargeRate(level.hoverWeapon);
  maxBattery = self BatteryGetSize(level.hoverWeapon);
  Assert(dischargeRate > 0);

  while(true) {
    self PlayRumbleOnEntity("damage_heavy");

    velocity = self GetVelocity();
    latSpeed = Length2D(velocity);
    minSpeed = 1.0;

    if(level.gametype == "horde") {
      if(isDefined(self.hordeExoBattery)) {
        minSpeed = 1.0 + (self.hordeExoBattery * -0.1);
      }
    }

    self BatterySetDischargeScale(level.hoverWeapon, max(minSpeed, (maxBattery * latSpeed) / (GetDvarInt("hover_max_travel_distance", 350) * dischargeRate)));

    wait(0.1);
  }
}

play_exo_hover_vfx() {
  level endon("game_ended");

  hover_type = 0;

  if(self _hasPerk("specialty_exo_blastsuppressor")) {
    hover_type = 1;
    hover_vfx = SpawnLinkedFx(level.suppressed_exo_hover_vfx, self, "tag_jetpack");
  } else {
    hover_vfx = SpawnLinkedFx(level.regular_exo_hover_vfx, self, "tag_jetpack");
  }
  TriggerFX(hover_vfx);

  self waittill_any("disconnect", "death", "joined_team", "faux_spawn", "exo_hover_taken", "stop_exo_hover_effects");

  if(isDefined(hover_vfx)) {
    hover_vfx delete();
  }
}