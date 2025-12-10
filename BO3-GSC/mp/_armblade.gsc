/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_armblade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_proximity_grenade;
#namespace armblade;

function autoexec __init__sytem__() {
  system::register("armblade", &__init__, undefined, undefined);
}

function __init__() {
  level.weaponarmblade = getweapon("hero_armblade");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self thread armblade_sound_thread();
}

function armblade_sound_thread() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    result = self util::waittill_any_return("weapon_change", "disconnect");
    if(isDefined(result)) {
      if(result == "weapon_change" && self getcurrentweapon() == level.weaponarmblade) {
        if(!isDefined(self.armblade_loop_sound)) {
          self.armblade_loop_sound = spawn("script_origin", self.origin);
          self.armblade_loop_sound linkto(self);
        }
        self.armblade_loop_sound playLoopSound("wpn_armblade_idle", 0.25);
        continue;
      }
      if(isDefined(self.armblade_loop_sound)) {
        self.armblade_loop_sound stoploopsound(0.25);
      }
    }
  }
}