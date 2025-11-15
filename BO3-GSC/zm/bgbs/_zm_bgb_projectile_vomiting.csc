/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_projectile_vomiting.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_projectile_vomiting;

function autoexec __init__sytem__() {
  system::register("zm_bgb_projectile_vomiting", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("actor", "projectile_vomit", 12000, 1, "counter", & function_6ac13208, 0, 0);
  bgb::register("zm_bgb_projectile_vomiting", "rounds");
  level._effect["bgb_puke_reaction"] = "zombie/fx_liquid_vomit_stream_zmb";
  level._effect["bgb_puke_reaction_no_head"] = "zombie/fx_liquid_vomit_stream_neck_zmb";
  level.var_e0154011 = 0;
}

function function_6ac13208(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(level.var_e0154011 < 10) {
    if(gibclientutils::isgibbed(localclientnum, self, 8)) {
      playFXOnTag(localclientnum, level._effect["bgb_puke_reaction_no_head"], self, "j_neck");
    } else {
      playFXOnTag(localclientnum, level._effect["bgb_puke_reaction"], self, "j_neck");
    }
    self playSound(0, "zmb_bgb_vomit_vox");
    level thread function_6d325051();
  }
}

function function_6d325051() {
  level.var_e0154011++;
  wait(1);
  level.var_e0154011--;
}