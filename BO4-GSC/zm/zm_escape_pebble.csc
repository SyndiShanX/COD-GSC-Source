/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_pebble.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_escape_pebble;

autoexec __init__system__() {
  system::register(#"zm_escape_pebble", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "" + #"hash_7792af358100c735", 1, 1, "int", &function_33f1dd99, 0, 0);
  clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter", &function_87d68f99, 0, 0);
  clientfield::register("world", "" + #"attic_room", 1, 1, "int", &attic_room, 0, 0);
  clientfield::register("world", "" + #"narrative_room", 1, 1, "int", &narrative_room, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_46dbc12bdc275121", 1, 1, "int", &glyph_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_59623b8b4fc694c8", 1, 2, "int", &function_db9b47b5, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_ce418c45d804842", 1, 1, "counter", &function_2f00e842, 0, 0);
  level._effect[#"hash_7184fc7d78dcf1c0"] = #"hash_73000f9a6abd5658";
  level._effect[#"hash_20080a107a8533e"] = #"hash_7965ec9e0938553f";
  level._effect[#"walnut_teleport"] = #"hash_2844b7026fd0f451";
  level._effect[#"hash_7792af358100c735"] = #"hash_3d18884453d39646";
  level._effect[#"light_red"] = #"hash_6fdf0d26a4ab7a7";
}

function_87d68f99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self thread postfx::playpostfxbundle(#"hash_114ea20734e794cf");
  playSound(localclientnum, #"hash_307805bbe1d946b", (0, 0, 0));
}

function_33f1dd99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_7792af358100c735"], self, "j_spine_4");
}

narrative_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    function_a5777754(localclientnum, "broom_closet");
    return;
  }

  function_73b1f242(localclientnum, "broom_closet");
}

attic_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    function_a5777754(localclientnum, "back_room");
    return;
  }

  function_73b1f242(localclientnum, "back_room");
}

glyph_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_7184fc7d78dcf1c0"], self, "tag_origin");
}

function_db9b47b5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_2d6d5baa = util::playFXOnTag(localclientnum, level._effect[#"light_red"], self, "tag_eye_rt");
    self.var_ab585fc = util::playFXOnTag(localclientnum, level._effect[#"light_red"], self, "tag_eye_lt");
    return;
  }

  if(newval == 2) {
    self.var_a25a09ff = util::playFXOnTag(localclientnum, level._effect[#"hash_20080a107a8533e"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_2d6d5baa)) {
    killfx(localclientnum, self.var_2d6d5baa);
    self.var_2d6d5baa = undefined;
  }

  if(isDefined(self.var_ab585fc)) {
    killfx(localclientnum, self.var_ab585fc);
    self.var_ab585fc = undefined;
  }

  if(isDefined(self.var_a25a09ff)) {
    stopfx(localclientnum, self.var_a25a09ff);
    self.var_a25a09ff = undefined;
  }
}

function_2f00e842(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"walnut_teleport"], self, "tag_origin");
}