/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_pack_a_punch.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#namespace _zm_pack_a_punch;

function autoexec __init__sytem__() {
  system::register("zm_pack_a_punch", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["pap_working_fx"] = "dlc1/castle/fx_packapunch_castle";
  clientfield::register("zbarrier", "pap_working_FX", 5000, 1, "int", &pap_working_fx_handler, 0, 0);
}

function pap_working_fx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    pap_play_fx(localclientnum, 0, "base_jnt");
  } else {
    if(isDefined(self.n_pap_fx)) {
      stopfx(localclientnum, self.n_pap_fx);
      self.n_pap_fx = undefined;
    }
    wait(1);
    if(isDefined(self.mdl_fx)) {
      self.mdl_fx delete();
    }
  }
}

function private pap_play_fx(localclientnum, n_piece_index, str_tag) {
  mdl_piece = self zbarriergetpiece(n_piece_index);
  if(isDefined(self.mdl_fx)) {
    self.mdl_fx delete();
  }
  if(isDefined(self.n_pap_fx)) {
    deletefx(localclientnum, self.n_pap_fx);
    self.n_pap_fx = undefined;
  }
  self.mdl_fx = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
  self.mdl_fx linkto(mdl_piece, str_tag);
  self.n_pap_fx = playFXOnTag(localclientnum, level._effect["pap_working_fx"], self.mdl_fx, "tag_origin");
}