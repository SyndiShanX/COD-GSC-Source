/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_transformer.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\system_shared;
#namespace zm_zod_transformer;

function autoexec __init__sytem__() {
  system::register("zm_zod_transformer", &__init__, undefined, undefined);
}

function __init__() {
  n_bits = getminbitcountfornum(16);
  clientfield::register("scriptmover", "transformer_light_switch", 1, n_bits, "int", &transformer_light_switch, 0, 0);
}

function transformer_light_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    exploder::exploder("powerbox_" + newval);
  }
}