/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42805.gsc
**************************************/

exo_shield_think() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_shield_taken");
  self notify("exo_shield_think_end");
  self endon("exo_shield_think_end");
  var_0 = get_exo_shield_weapon();

  if(!self hasweapon(var_0)) {
    return;
  }
  self batterysetdischargescale(var_0, 1.0);
  var_1 = batteryusepershot(var_0);
  var_2 = self batterygetsize(var_0);

  if(self gettacticalweapon() == var_0) {
    self setclientomnvar("ui_exo_battery_level0", var_2);
    self setclientomnvar("exo_ability_nrg_req0", var_1);
    self setclientomnvar("exo_ability_nrg_total0", var_2);
  } else if(self getlethalweapon() == var_0) {
    self setclientomnvar("ui_exo_battery_level1", var_2);
    self setclientomnvar("exo_ability_nrg_req1", var_1);
    self setclientomnvar("exo_ability_nrg_total1", var_2);
  }

  thread wait_for_player_death(var_0);

  for(;;) {
    self waittillmatch("grenade_pullback", var_0);
    maps\mp\_snd_common_mp::snd_message("mp_exo_shield_activate");
    self.pers["numberOfTimesShieldUsed"]++;
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar(var_0, "ui_exo_battery_toggle", 1);
    self.exo_shield_on = 1;

    if(!isagent(self)) {
      thread maps\mp\_exo_battery::update_exo_battery_hud(var_0);
    }

    if(self batteryisinuse(var_0) == 1) {
      self waittillmatch("battery_discharge_end", var_0);
    }

    maps\mp\_snd_common_mp::snd_message("mp_exo_shield_deactivate");
    maps\mp\_exo_battery::set_exo_ability_hud_omnvar(var_0, "ui_exo_battery_toggle", 0);
    self.exo_shield_on = 0;
  }
}

take_exo_shield() {
  self notify("kill_battery");
  self notify("exo_shield_taken");
  self takeweapon(get_exo_shield_weapon());
}

give_exo_shield() {
  self giveweapon(get_exo_shield_weapon());
  thread exo_shield_think();
}

get_exo_shield_weapon() {
  if(isDefined(level.exoshieldweapon)) {
    return level.exoshieldweapon;
  }

  level.exoshieldweapon = "exoshield_equipment_mp";

  if(isDefined(level.ishorde)) {
    level.exoshieldweapon = "exoshieldhorde_equipment_mp";
  }

  return level.exoshieldweapon;
}

wait_for_player_death(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  common_scripts\utility::waittill_any("death", "joined_team", "faux_spawn", "exo_shield_taken");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar(var_0, "ui_exo_battery_toggle", 0);
  self.exo_shield_on = 0;
  self refreshshieldmodels();
}