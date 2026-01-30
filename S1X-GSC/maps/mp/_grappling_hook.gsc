/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_grappling_hook.gsc
***************************************/

init() {
  if(maps\mp\_utility::isgrapplinghookgamemode()) {
    level thread grappling_hook_on_player_connect();
  }
}

grappling_hook_on_player_connect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread grappling_hook_on_loadout_given();
  }
}

grappling_hook_on_loadout_given() {
  level endon("game_ended");

  for(;;) {
    self waittill("applyLoadout");

    if(!maps\mp\_utility::isjuggernaut()) {
      give_grappling_hook();
      thread grappling_hook_wait_for_death();
      thread grappling_hook_wait_for_game_end();
    }
  }
}

grappling_hook_wait_for_death() {
  level endon("game_ended");
  self endon("disconnect");
  common_scripts\utility::waittill_any("death", "joined_team", "faux_spawn", "grappling_hook_reset", "entering_juggernaut");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon, "ui_exo_battery_toggle", 0);
}

grappling_hook_wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("grappling_hook_reset");
  self endon("grappling_hook_battery_hud_reset");
  level waittill("game_ended");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon, "ui_exo_battery_toggle", 0);
}

give_grappling_hook() {
  var_0 = get_grappling_hook_weapon();

  if(self hasweapon(var_0)) {
    return;
  }
  self settacticalweapon(var_0);
  self giveweapon(var_0);
  self notify("grappling_hook_reset");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setentityowner(self);
  var_1 setotherent(self);
  self setgrapplinghooktarget(var_1);
  thread common_scripts\utility::delete_on_death(var_1);
  thread delete_on_reset(var_1);
  var_2 = self batterygetsize(level.grapplinghookweapon);
  self setclientomnvar("ui_exo_battery_level0", var_2);
  self setclientomnvar("exo_ability_nrg_req0", batteryreqtouse(level.grapplinghookweapon));
  self setclientomnvar("exo_ability_nrg_total0", var_2);
  self setclientomnvar("ui_invalid_grapple", 0);
  thread wait_for_grappling_hook_pressed();
}

wait_for_full_battery() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("grappling_hook_reset");
  self endon("grappling_hook_battery_hud_reset");
  var_0 = self batterygetsize(level.grapplinghookweapon);

  for(;;) {
    var_1 = self batterygetcharge(level.grapplinghookweapon);

    if(var_1 >= var_0) {
      maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon, "ui_exo_battery_toggle", 0);
      return;
    }

    wait 0.1;
  }
}

wait_for_grappling_hook_pressed() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("grappling_hook_reset");

  for(;;) {
    self waittill("exo_ability_activate", var_0, var_1);

    if(var_0 == level.grapplinghookweapon && isDefined(var_1)) {
      if(var_1 == 1) {
        self notify("grappling_hook_battery_hud_reset");

        if(isDefined(self.last_grapple_time)) {
          self.last_grapple_time_prev = self.last_grapple_time;
        }

        self.last_grapple_time = gettime();
        maps\mp\_exo_battery::set_exo_ability_hud_omnvar(level.grapplinghookweapon, "ui_exo_battery_toggle", 1);
        thread maps\mp\_exo_battery::update_exo_battery_hud(level.grapplinghookweapon);
        thread wait_for_full_battery();
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgun12");

        if(isDefined(self.lastdamagedtime) && isDefined(self.last_grapple_time)) {
          if(self.last_grapple_time - self.lastdamagedtime < 1500) {
            maps\mp\gametypes\_missions::processchallenge("ch_tier2_5_iw5_dlcgun12");
          }
        }

        continue;
      }

      if(var_1 == 0) {
        thread pulse_grapple_hud_message(2);
        continue;
      }

      if(var_1 == -1) {
        thread pulse_grapple_hud_message(1);
      }
    }
  }
}

pulse_grapple_hud_message(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self setclientomnvar("ui_invalid_grapple", var_0);

  if(var_0 == 1) {
    self setclientomnvar("ui_border_warning_toggle", 0);
    wait 0.6;
  } else if(var_0 == 2) {
    wait 1.0;
  }

  self setclientomnvar("ui_invalid_grapple", 0);
}

take_grappling_hook() {
  var_0 = get_grappling_hook_weapon();
  self settacticalweapon("none");
  self takeweapon(var_0);
  self notify("grappling_hook_reset");
}

get_grappling_hook_weapon() {
  if(isDefined(level.grapplinghookweapon)) {
    return level.grapplinghookweapon;
  }

  level.grapplinghookweapon = "iw5_dlcgun12loot7_mp";
  return level.grapplinghookweapon;
}

delete_on_reset(var_0) {
  var_0 endon("death");
  self waittill("grappling_hook_reset");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}