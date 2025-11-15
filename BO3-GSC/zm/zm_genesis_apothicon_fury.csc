/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_apothicon_fury.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_apothicon_fury;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_genesis_apothicon_fury;

function autoexec __init__sytem__() {
  system::register("zm_genesis_apothicon_fury", & __init__, undefined, undefined);
}

function __init__() {
  if(ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
    clientfield::register("scriptmover", "apothicon_fury_spawn_meteor", 15000, 2, "int", & function_87fb20f7, 0, 0);
  }
  level._effect["apothicon_fury_meteor_fx"] = "dlc4/genesis/fx_apothicon_fury_spawn_in";
  level._effect["apothicon_fury_meteor_exp"] = "dlc4/genesis/fx_apothicon_fury_spawn_in_exp";
}

function function_87fb20f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval === 0) {
    if(isDefined(self.apothicon_fury_meteor_fx)) {
      stopfx(localclientnum, self.apothicon_fury_meteor_fx);
    }
  }
  if(newval === 1) {
    self.apothicon_fury_meteor_fx = playFXOnTag(localclientnum, level._effect["apothicon_fury_meteor_fx"], self, "tag_origin");
  }
  if(newval == 2) {
    playFXOnTag(localclientnum, level._effect["apothicon_fury_meteor_exp"], self, "tag_origin");
    self earthquake(0.1, 1, self.origin, 100);
    self playrumbleonentity(localclientnum, "damage_heavy");
  }
}