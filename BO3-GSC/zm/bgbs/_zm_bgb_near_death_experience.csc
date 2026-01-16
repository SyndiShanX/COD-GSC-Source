/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_near_death_experience.csc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_near_death_experience;

function autoexec __init__sytem__() {
  system::register("zm_bgb_near_death_experience", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 15000, 1, "int", & function_24480126, 0, 0);
  clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 15000, 1, "int", & function_11972f24, 0, 1);
  bgb::register("zm_bgb_near_death_experience", "rounds");
  level.var_3b53e98b = [];
}

function function_24480126(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_local_player = getlocalplayer(localclientnum);
  if(newval) {
    if(e_local_player != self) {
      if(!isdefined(self.var_6b39dbae)) {
        self.var_6b39dbae = [];
      }
      if(isdefined(self.var_6b39dbae[localclientnum])) {
        return;
      }
      self.var_6b39dbae[localclientnum] = playfxontag(localclientnum, "zombie/fx_bgb_near_death_3p", self, "j_spine4");
    }
  } else if(isdefined(self.var_6b39dbae) && isdefined(self.var_6b39dbae[localclientnum])) {
    stopfx(localclientnum, self.var_6b39dbae[localclientnum]);
    self.var_6b39dbae[localclientnum] = undefined;
  }
}

function function_11972f24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isdefined(level.var_3b53e98b[localclientnum])) {
      deletefx(localclientnum, level.var_3b53e98b[localclientnum]);
    }
    level.var_3b53e98b[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_near_death_1p", (0, 0, 0), (1, 0, 0));
  } else if(isdefined(level.var_3b53e98b[localclientnum])) {
    stopfx(localclientnum, level.var_3b53e98b[localclientnum]);
    level.var_3b53e98b[localclientnum] = undefined;
  }
}