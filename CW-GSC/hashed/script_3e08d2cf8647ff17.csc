/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3e08d2cf8647ff17.csc
***********************************************/

#using scripts\core_common\ai\archetype_nosferatu;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace namespace_be2ae534;

function init() {
  function_cae618b4("spawner_zombietron_demon");
  clientfield::register("actor", "nfrtu_move_dash", 8000, 1, "int", &function_87acfe6f, 0, 0);
}

function private function_87acfe6f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_b8cc5182 = util::playFXOnTag(fieldname, "zm_ai/fx8_nosferatu_dash_eyes", self, "tag_eye");
    return;
  }

  if(isDefined(self.var_b8cc5182)) {
    stopfx(fieldname, self.var_b8cc5182);
  }
}