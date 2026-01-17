/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_tone_death.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_tone_death;

function autoexec __init__sytem__() {
  system::register("zm_bgb_tone_death", &__init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_tone_death", "event", &event, undefined, undefined, undefined);
  bgb::register_actor_death_override("zm_bgb_tone_death", &actor_death_override);
}

function event() {
  self endon("disconnect");
  self thread function_1473087b();
  self util::waittill_any("disconnect", "bled_out", "bgb_gumball_anim_give", "bgb_tone_death_maxed");
}

function function_1473087b() {
  self util::waittill_any("disconnect", "bled_out", "bgb_gumball_anim_give", "bgb_tone_death_maxed");
  self.n_bgb_tone_death_count = undefined;
}

function actor_death_override(e_attacker) {
  if(self.archetype !== "zombie" || !isplayer(e_attacker)) {
    return;
  }
  if(e_attacker bgb::is_enabled("zm_bgb_tone_death")) {
    self.bgb_tone_death = 1;
    if(!isDefined(e_attacker.n_bgb_tone_death_count)) {
      e_attacker.n_bgb_tone_death_count = 25;
    }
    e_attacker.n_bgb_tone_death_count--;
    e_attacker bgb::set_timer(e_attacker.n_bgb_tone_death_count, 25);
    if(e_attacker.n_bgb_tone_death_count <= 0) {
      e_attacker notify("bgb_tone_death_maxed");
    }
  }
}