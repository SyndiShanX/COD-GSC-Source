/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_profit_sharing.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_profit_sharing;

function autoexec __init__sytem__() {
  system::register("zm_bgb_profit_sharing", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  clientfield::register("allplayers", "zm_bgb_profit_sharing_3p_fx", 15000, 1, "int");
  clientfield::register("toplayer", "zm_bgb_profit_sharing_1p_fx", 15000, 1, "int");
  bgb::register("zm_bgb_profit_sharing", "time", 600, & enable, & disable, undefined, undefined);
  bgb::function_ff4b2998("zm_bgb_profit_sharing", & add_to_player_score_override, 1);
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  self thread bgb::function_4ed517b9(720, & function_ff41ae2d, & function_3c1690be);
  self thread function_677e212b();
}

function disable() {}

function function_677e212b() {
  self endon("disconnect");
  self clientfield::set("zm_bgb_profit_sharing_3p_fx", 1);
  self util::waittill_either("bled_out", "bgb_update");
  self clientfield::set("zm_bgb_profit_sharing_3p_fx", 0);
  self notify("profit_sharing_complete");
}

function add_to_player_score_override(n_points, str_awarded_by, var_1ed9bd9b) {
  if(str_awarded_by == "zm_bgb_profit_sharing") {
    return n_points;
  }
  switch (str_awarded_by) {
    case "bgb_machine_ghost_ball":
    case "equip_hacker":
    case "magicbox_bear":
    case "reviver": {
      return n_points;
    }
    default: {
      break;
    }
  }
  if(!var_1ed9bd9b) {
    foreach(e_player in level.players) {
      if(isdefined(e_player) && "zm_bgb_profit_sharing" == e_player bgb::get_enabled()) {
        if(isdefined(e_player.var_6638f10b) && array::contains(e_player.var_6638f10b, self)) {
          e_player thread zm_score::add_to_player_score(n_points, 1, "zm_bgb_profit_sharing");
        }
      }
    }
  } else if(isdefined(self.var_6638f10b) && self.var_6638f10b.size > 0) {
    foreach(e_player in self.var_6638f10b) {
      if(isdefined(e_player)) {
        e_player thread zm_score::add_to_player_score(n_points, 1, "zm_bgb_profit_sharing");
      }
    }
  }
  return n_points;
}

function function_ff41ae2d(e_player) {
  self function_d1d595b5();
  e_player function_d1d595b5();
  str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
  level util::waittill_any_ents(e_player, "disconnect", e_player, str_notify, self, "disconnect", self, "profit_sharing_complete");
  if(isdefined(self)) {
    self function_c0b35f9d();
  }
  if(isdefined(e_player)) {
    e_player function_c0b35f9d();
  }
}

function function_3c1690be(e_player) {
  str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
  e_player notify(str_notify);
}

function function_d1d595b5() {
  if(!isdefined(self.var_95b54) || self.var_95b54 == 0) {
    self.var_95b54 = 1;
    self clientfield::set_to_player("zm_bgb_profit_sharing_1p_fx", 1);
  } else {
    self.var_95b54++;
  }
}

function function_c0b35f9d() {
  self.var_95b54--;
  if(self.var_95b54 == 0) {
    self clientfield::set_to_player("zm_bgb_profit_sharing_1p_fx", 0);
  }
}