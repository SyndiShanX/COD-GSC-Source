/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_quantum_bomb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_quantum_bomb;

function autoexec __init__sytem__() {
  system::register("zm_weap_quantum_bomb", & __init__, undefined, undefined);
}

function __init__() {
  callback::add_weapon_type(getweapon("quantum_bomb"), & quantum_bomb_spawned);
  level._effect["quantum_bomb_viewmodel_twist"] = "dlc5/zmb_weapon/fx_twist";
  level._effect["quantum_bomb_viewmodel_press"] = "dlc5/zmb_weapon/fx_press";
  level thread quantum_bomb_notetrack_think();
}

function quantum_bomb_notetrack_think() {
  for(;;) {
    level waittill("notetrack", localclientnum, note);
    switch (note) {
      case "quantum_bomb_twist": {
        playviewmodelfx(localclientnum, level._effect["quantum_bomb_viewmodel_twist"], "tag_weapon");
        break;
      }
      case "quantum_bomb_press": {
        playviewmodelfx(localclientnum, level._effect["quantum_bomb_viewmodel_press"], "tag_weapon");
        break;
      }
    }
  }
}

function quantum_bomb_spawned(localclientnum, play_sound) {
  temp_ent = spawn(0, self.origin, "script_origin");
  temp_ent playLoopSound("wpn_quantum_rise", 0.5);
  while(isDefined(self)) {
    temp_ent.origin = self.origin;
    wait(0.05);
  }
  temp_ent delete();
}