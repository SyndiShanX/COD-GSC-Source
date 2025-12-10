/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_dead_wire.csc
*************************************************/

#using scripts\shared\aat_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_aat_dead_wire;

function autoexec __init__sytem__() {
  system::register("zm_aat_dead_wire", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_dead_wire", "zmui_zm_aat_dead_wire", "t7_icon_zm_aat_dead_wire");
  clientfield::register("actor", "zm_aat_dead_wire" + "_zap", 1, 1, "int", &zm_aat_dead_wire_zap, 0, 0);
  clientfield::register("vehicle", "zm_aat_dead_wire" + "_zap_vehicle", 1, 1, "int", &zm_aat_dead_wire_zap_vehicle, 0, 0);
  level._effect["zm_aat_dead_wire"] = "zombie/fx_tesla_shock_zmb";
}

function zm_aat_dead_wire_zap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.fx_aat_dead_wire_zap = playFXOnTag(localclientnum, "zombie/fx_tesla_shock_zmb", self, "J_SpineUpper");
  } else if(isDefined(self.fx_aat_dead_wire_zap)) {
    stopfx(localclientnum, self.fx_aat_dead_wire_zap);
    self.fx_aat_dead_wire_zap = undefined;
  }
}

function zm_aat_dead_wire_zap_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    tag = "tag_body";
    v_tag = self gettagorigin(tag);
    if(!isDefined(v_tag)) {
      tag = "tag_origin";
    }
    self.fx_aat_dead_wire_zap = playFXOnTag(localclientnum, "zombie/fx_tesla_shock_zmb", self, tag);
  } else if(isDefined(self.fx_aat_dead_wire_zap)) {
    stopfx(localclientnum, self.fx_aat_dead_wire_zap);
    self.fx_aat_dead_wire_zap = undefined;
  }
}