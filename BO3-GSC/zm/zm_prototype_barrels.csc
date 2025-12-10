/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_prototype_barrels.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_prototype_barrels;

function autoexec __init__sytem__() {
  system::register("zm_prototype_barrels", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "exploding_barrel_burn_fx", 21000, 1, "int", &function_66d46c7d, 0, 0);
  clientfield::register("scriptmover", "exploding_barrel_explode_fx", 21000, 1, "int", &function_b6fe19c5, 0, 0);
}

function function_66d46c7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_39bdc445 = playFXOnTag(localclientnum, level.breakables_fx["barrel"]["burn_start"], self, "tag_fx_btm");
  }
}

function function_b6fe19c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.var_39bdc445)) {
      stopfx(localclientnum, self.var_39bdc445);
    }
    self.var_4360e059 = playFXOnTag(localclientnum, level.breakables_fx["barrel"]["explode"], self, "tag_fx_btm");
  }
}