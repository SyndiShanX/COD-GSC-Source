/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_respin_cycle.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_respin_cycle;

function autoexec __init__sytem__() {
  system::register("zm_bgb_respin_cycle", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_respin_cycle", "activated", 2, undefined, undefined, & validation, & activation);
  clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter");
}

function validation() {
  for(i = 0; i < level.chests.size; i++) {
    chest = level.chests[i];
    if(isDefined(chest.zbarrier.weapon_model) && isDefined(chest.chest_user) && self == chest.chest_user) {
      return true;
    }
  }
  return false;
}

function activation() {
  self endon("disconnect");
  for(i = 0; i < level.chests.size; i++) {
    chest = level.chests[i];
    if(isDefined(chest.zbarrier.weapon_model) && isDefined(chest.chest_user) && self == chest.chest_user) {
      chest thread function_7a5dc39b(self);
    }
  }
}

function function_7a5dc39b(player) {
  self.zbarrier clientfield::increment("zm_bgb_respin_cycle");
  if(isDefined(self.zbarrier.weapon_model)) {
    self.zbarrier.weapon_model notify("kill_respin_think_thread");
  }
  self.no_fly_away = 1;
  self.zbarrier notify("box_hacked_respin");
  self.zbarrier playSound("zmb_bgb_powerup_respin");
  self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
  zm_utility::play_sound_at_pos("open_chest", self.zbarrier.origin);
  zm_utility::play_sound_at_pos("music_chest", self.zbarrier.origin);
  self.zbarrier thread zm_magicbox::treasure_chest_weapon_spawn(self, player);
  self.zbarrier waittill("randomization_done");
  self.no_fly_away = undefined;
  if(!level flag::get("moving_chest_now")) {
    self.grab_weapon_hint = 1;
    self.grab_weapon = self.zbarrier.weapon;
    self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, & zm_magicbox::magicbox_unitrigger_think);
    self thread zm_magicbox::treasure_chest_timeout();
  }
}