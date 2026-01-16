/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_pap_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\zm\_zm_pack_a_punch;
#namespace zm_castle_pap_quest;

function autoexec main() {
  register_clientfields();
  level._effect["pap_tp"] = "dlc1/castle/fx_castle_pap_reform";
}

function register_clientfields() {
  clientfield::register("scriptmover", "pap_tp_fx", 5000, 1, "counter", & pap_tp_fx, 0, 0);
}

function pap_tp_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfx(localclientnum, level._effect["pap_tp"], self.origin);
}