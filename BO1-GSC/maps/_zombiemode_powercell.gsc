/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_powercell.gsc
******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

init() {
  level.powercells = getEntArray("powercell_pickup", "targetname");
  if(level.powercells.size == 0) {
    return;
  } else {
    for(i = 0; i < level.powercells.size; i++) {
      level.powercells[i] thread powercell_init();
    }
  }
  level thread powercell_init_hud();
  level thread powercell_init_dropoff();
  level thread test();
  if(isDefined(level.powercell_init_func)) {
    [[level.powercell_init_func]]();
  }
}
test() {}
powercell_precache() {
  PrecacheShader("zom_pack_a_punch_battery_icon");
}
powercell_init() {
  self.trigger = GetEnt(self.target, "targetname");
  if(!isDefined(self.trigger)) {
    return;
  }
  self.trigger SetHintString(&"ZOMBIE_POWERCELL_PICKUP");
  self.trigger SetCursorHint("HINT_NOICON");
  self thread powercell_wait();
}
powercell_wait() {
  self thread powercell_fx();
  self.trigger UseTriggerRequireLookAt();
  for(;;) {
    self.trigger waittill("trigger", user);
    if(!user.powercellEquipped) {
      self.trigger trigger_off();
      self hide();
      self thread play_sound_on_entity("zmb_power_cell_pickup");
      user powercell_pickup(self);
      break;
    } else {
      play_sound_on_ent("no_purchase");
    }
  }
}
powercell_fx() {
  self.fx = spawn("script_model", self.origin);
  self.fx.angles = self.angles;
  self.fx setModel("tag_origin");
  playFXOnTag(level._effect["powercell"], self.fx, "tag_origin");
  self waittill("powercell_picked_up");
  self.fx delete();
}
powercell_replace() {
  self.trigger trigger_on();
  self show();
  self thread powercell_wait();
}
powercell_init_dropoff() {
  dropoff_trigger = GetEnt("powercell_dropoff", "targetname");
  if(!isDefined(dropoff_trigger)) {
    return;
  }
  dropoff_trigger thread powercell_dropoff();
}
powercell_init_hud() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i].powercellHud = create_simple_hud(players[i]);
    players[i].powercellHud.foreground = true;
    players[i].powercellHud.sort = 2;
    players[i].powercellHud.hidewheninmenu = false;
    players[i].powercellHud.alignX = "center";
    players[i].powercellHud.alignY = "bottom";
    players[i].powercellHud.horzAlign = "user_center";
    players[i].powercellHud.vertAlign = "user_bottom";
    players[i].powercellHud.x = 256;
    players[i].powercellHud.y = 0;
    players[i].powercellHud.alpha = 0.8;
    players[i].powercellEquipped = false;
  }
}
powercell_pickup(powercell) {
  self endon("death");
  self.powercellEquipped = true;
  self.powercellHud.alpha = 1;
  self.powercellHud setshader("zom_pack_a_punch_battery_icon", 32, 32);
  self.powercell = powercell;
  self thread powercell_check_for_loss();
  powercell notify("powercell_picked_up");
}
powercell_check_for_loss() {
  self endon("powercell_dropoff");
  self waittill_any("fake_death", "death", "player_downed");
  if(self.powercellEquipped) {
    self powercell_lost();
  }
}
powercell_dropoff() {
  self UseTriggerRequireLookAt();
  self SetHintString(&"ZOMBIE_POWERCELL_DROPOFF");
  self SetCursorHint("HINT_NOICON");
  self thread powercell_dropoff_done();
  for(;;) {
    self waittill("trigger", user);
    if(user.powercellEquipped) {
      user.powercellEquipped = false;
      user.powercellHud.alpha = 0;
      self thread play_sound_on_entity("zmb_power_cell_insert");
      user notify("powercell_dropoff");
      if(isDefined(level.powercell_dropoff_func)) {
        [[level.powercell_dropoff_func]]();
      }
      user maps\_zombiemode_rank::giveRankXP("powercell");
    } else {
      play_sound_on_ent("no_purchase");
    }
  }
}
powercell_dropoff_done() {
  level waittill("powercell_done");
  self delete();
}
powercell_lost() {
  self.powercellEquipped = false;
  self.powercellHud.alpha = 0;
  if(isDefined(self.powercell)) {
    self.powercell powercell_replace();
    self.powercell = undefined;
  }
}