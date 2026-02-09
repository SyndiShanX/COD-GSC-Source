/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42799.gsc
**************************************/

update_exo_battery_hud(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("kill_battery");

  if(!isPlayer(self)) {
    return;
  }
  while(get_exo_ability_hud_omnvar_value(var_0, "ui_exo_battery_toggle") == 1) {
    var_1 = self batterygetcharge(var_0);
    set_exo_ability_hud_omnvar(var_0, "ui_exo_battery_level", var_1);
    wait 0.05;
  }
}

set_exo_ability_hud_omnvar(var_0, var_1, var_2) {
  if(self gettacticalweapon() == var_0) {
    self setclientomnvar(var_1 + "0", var_2);

    if(var_1 == "ui_exo_battery_toggle") {
      if(var_2 == 1) {
        self setclientomnvar("ui_exo_battery_iconA", var_0);
      }
    }
  } else if(self getlethalweapon() == var_0) {
    self setclientomnvar(var_1 + "1", var_2);

    if(var_1 == "ui_exo_battery_toggle") {
      if(var_2 == 1) {
        self setclientomnvar("ui_exo_battery_iconB", var_0);
      }
    }
  } else {
    self setclientomnvar("ui_exo_battery_iconA", "reset");
    self setclientomnvar("ui_exo_battery_iconB", "reset");
    self setclientomnvar("ui_exo_battery_toggle0", 0);
    self setclientomnvar("ui_exo_battery_toggle1", 0);
  }
}

get_exo_ability_hud_omnvar_value(var_0, var_1) {
  if(self gettacticalweapon() == var_0) {
    return self getclientomnvar(var_1 + "0");
  } else if(self getlethalweapon() == var_0) {
    return self getclientomnvar(var_1 + "1");
  }

  return -1;
}

play_insufficient_tactical_energy_sfx() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("kill_battery");
  self notifyonplayercommandremove("tried_left_exo_ability", "+smoke");
  wait 0.05;
  self notifyonplayercommand("tried_left_exo_ability", "+smoke");

  for(;;) {
    self waittill("tried_left_exo_ability");
    var_0 = self gettacticalweapon();

    if(maps\mp\_utility::is_exo_ability_weapon(var_0)) {
      if(self batterygetcharge(var_0) < batteryreqtouse(var_0)) {
        self playlocalsound("mp_exo_bat_empty");
      }
    }
  }
}

play_insufficient_lethal_energy_sfx() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("kill_battery");
  self notifyonplayercommandremove("tried_right_exo_ability", "+frag");
  wait 0.05;
  self notifyonplayercommand("tried_right_exo_ability", "+frag");

  for(;;) {
    self waittill("tried_right_exo_ability");
    var_0 = self getlethalweapon();

    if(maps\mp\_utility::is_exo_ability_weapon(var_0)) {
      if(self batterygetcharge(var_0) < batteryreqtouse(var_0)) {
        self playlocalsound("mp_exo_bat_empty");
      }
    }
  }
}