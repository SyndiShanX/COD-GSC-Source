/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_mech.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\mechz;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_zm_ai_mechz_claw;
#namespace zm_tomb_mech;

function init() {
  clientfield::register("actor", "tomb_mech_eye", 21000, 1, "int", &function_8c8b6484, 0, 0);
}

function function_8c8b6484(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    waittillframeend();
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
  } else {
    waittillframeend();
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 3, 0);
  }
}