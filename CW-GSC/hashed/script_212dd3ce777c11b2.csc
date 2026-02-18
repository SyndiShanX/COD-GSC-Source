/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_212dd3ce777c11b2.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_d592c983;

function event_handler[level_init] main(eventstruct) {
  if(!is_true(getgametypesetting(#"hash_580b0e5930bebbd1"))) {
    return;
  }

  if(!zm_utility::is_classic()) {
    return;
  }

  clientfield::register("scriptmover", "zm_round_accelerant_fx", 15000, 2, "int", &zm_round_accelerant_fx, 0, 0);
  clientfield::function_5b7d846d("hud_items_rampage_inducer.rampage_state", #"hud_items_rampage_inducer", #"rampage_state", 15000, 2, "int", undefined, 0, 0);
}

function zm_round_accelerant_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump >= 2) {
    if(isDefined(self.fxid)) {
      stopfx(fieldname, self.fxid);
    }

    self.fxid = function_239993de(fieldname, #"hash_e53abb78895dec6", self, "tag_origin");
    return;
  }

  if(isDefined(self.fxid)) {
    stopfx(fieldname, self.fxid);
  }

  self.fxid = function_239993de(fieldname, #"hash_72817177ffeaeafd", self, "tag_origin");
}