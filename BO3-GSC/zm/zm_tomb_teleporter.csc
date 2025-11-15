/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_teleporter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using_animtree("generic");
#namespace zm_tomb_teleporter;

function init() {
  clientfield::register("allplayers", "teleport_arrival_departure_fx", 21000, 1, "counter", & function_dadd24b7, 0, 0);
  clientfield::register("vehicle", "teleport_arrival_departure_fx", 21000, 1, "counter", & function_dadd24b7, 0, 0);
}

function main() {
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 21000, 1, "pstfx_zm_tomb_teleport");
}

function function_a8255fab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("disconnect");
  if(newval == 1) {
    if(!isDefined(self.var_1e8e073f)) {
      self.var_1e8e073f = playFXOnTag(localclientnum, level._effect["teleport_1p"], self, "tag_origin");
      setfxignorepause(localclientnum, self.var_1e8e073f, 1);
    }
  } else if(isDefined(self.var_1e8e073f)) {
    stopfx(localclientnum, self.var_1e8e073f);
    self.var_1e8e073f = undefined;
  }
}

function function_ffedfe48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_b162502d = !(isDefined(self.var_76534568) && self.var_76534568);
  if(!(isDefined(self.var_76534568) && self.var_76534568)) {
    self useanimtree($generic);
    self.var_76534568 = 1;
  }
  if(newval) {
    self thread scene::play("p7_fxanim_zm_ori_portal_open_bundle", self);
  } else {
    self thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", self);
  }
}

function function_dadd24b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_tag_name = "";
  if(self isplayer()) {
    str_tag_name = "j_spinelower";
  } else {
    str_tag_name = "tag_brain";
  }
  a_e_players = getlocalplayers();
  foreach(e_player in a_e_players) {
    self.var_16ab725 = playFXOnTag(e_player.localclientnum, level._effect["teleport_arrive_player"], self, str_tag_name);
    setfxignorepause(e_player.localclientnum, self.var_16ab725, 1);
  }
}