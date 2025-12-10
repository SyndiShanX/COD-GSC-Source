/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_dogs.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm;
#namespace zm_ai_dogs;

function autoexec __init__sytem__() {
  system::register("zm_ai_dogs", &__init__, undefined, undefined);
}

function __init__() {
  init_dog_fx();
  clientfield::register("actor", "dog_fx", 1, 1, "int", &dog_fx, 0, 0);
}

function init_dog_fx() {
  level._effect["dog_eye_glow"] = "zombie/fx_dog_eyes_zmb";
  level._effect["dog_trail_fire"] = "zombie/fx_dog_fire_trail_zmb";
}

function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self._eyeglow_fx_override = level._effect["dog_eye_glow"];
    self zm::createzombieeyes(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());
    self.n_trails_fx_id = playFXOnTag(localclientnum, level._effect["dog_trail_fire"], self, "j_spine2");
  } else {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
    self zm::deletezombieeyes(localclientnum);
    if(isDefined(self.n_trails_fx_id)) {
      deletefx(localclientnum, self.n_trails_fx_id);
    }
  }
}