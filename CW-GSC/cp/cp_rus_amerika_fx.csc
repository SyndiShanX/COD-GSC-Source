/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_amerika_fx.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace namespace_f942705d;

function preload() {
  clientfield::register("scriptmover", "play_coin_fx", 1, 1, "counter", &play_coin_fx, 0, 0);
  clientfield::register("scriptmover", "kill_coin_fx", 1, 1, "counter", &kill_coin_fx, 0, 0);
}

function play_coin_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_9053876c = function_239993de(bwastimejump, "maps/cp_rus_amerika/fx9_amerika_quarter_glint_runner", self, "tag_origin");
}

function kill_coin_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  killfx(bwastimejump, self.var_9053876c);
}