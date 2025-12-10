/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_profit_sharing.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_profit_sharing;

function autoexec __init__sytem__() {
  system::register("zm_bgb_profit_sharing", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("allplayers", "zm_bgb_profit_sharing_3p_fx", 15000, 1, "int", &function_df72a623, 0, 0);
  clientfield::register("toplayer", "zm_bgb_profit_sharing_1p_fx", 15000, 1, "int", &function_f683a0e1, 0, 1);
  bgb::register("zm_bgb_profit_sharing", "time");
  level.var_75dff42 = [];
}

function function_df72a623(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_local_player = getlocalplayer(localclientnum);
  if(newval) {
    if(e_local_player != self) {
      if(!isDefined(self.var_3485cf73)) {
        self.var_3485cf73 = [];
      }
      if(isDefined(self.var_3485cf73[localclientnum])) {
        return;
      }
      self.var_3485cf73[localclientnum] = playFXOnTag(localclientnum, "zombie/fx_bgb_profit_3p", self, "j_spine4");
    }
  } else if(isDefined(self.var_3485cf73) && isDefined(self.var_3485cf73[localclientnum])) {
    stopfx(localclientnum, self.var_3485cf73[localclientnum]);
    self.var_3485cf73[localclientnum] = undefined;
  }
}

function function_f683a0e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(level.var_75dff42[localclientnum])) {
      deletefx(localclientnum, level.var_75dff42[localclientnum]);
    }
    level.var_75dff42[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_profit_1p", (0, 0, 0), (1, 0, 0));
  } else if(isDefined(level.var_75dff42[localclientnum])) {
    stopfx(localclientnum, level.var_75dff42[localclientnum]);
    level.var_75dff42[localclientnum] = undefined;
  }
}