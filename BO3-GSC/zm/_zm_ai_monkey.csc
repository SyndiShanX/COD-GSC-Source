/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_monkey.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace _zm_ai_monkey;

function autoexec __init__sytem__() {
  system::register("monkey", &__init__, undefined, undefined);
}

function __init__() {
  ai::add_archetype_spawn_function("monkey", &function_70fb871f);
  clientfield::register("actor", "monkey_eye_glow", 21000, 1, "int", &function_2e74dabc, 0, 0);
  level._effect["monkey_eye_glow"] = "dlc5/zmhd/fx_zmb_monkey_eyes";
}

function private function_70fb871f(localclientnum) {
  self suppressragdollselfcollision(1);
}

function function_2e74dabc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    waittillframeend();
    if(!isDefined(self)) {
      return;
    }
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
    self._eyearray[localclientnum] = playFXOnTag(localclientnum, level._effect["monkey_eye_glow"], self, "j_eyeball_le");
  } else {
    waittillframeend();
    if(!isDefined(self)) {
      return;
    }
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 3, 0);
    if(isDefined(self._eyearray)) {
      if(isDefined(self._eyearray[localclientnum])) {
        deletefx(localclientnum, self._eyearray[localclientnum], 1);
        self._eyearray[localclientnum] = undefined;
      }
    }
  }
}