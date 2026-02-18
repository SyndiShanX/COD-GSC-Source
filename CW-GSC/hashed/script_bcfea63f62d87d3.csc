/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_bcfea63f62d87d3.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_77b8863;

function autoexec main() {
  clientfield::register("scriptmover", "towers_boss_dust_ball_fx", 1, getminbitcountfornum(4), "int", &function_72955447, 0, 0);
}

function function_72955447(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_attack_slam_trail_lg", self, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.fx)) {
      stopfx(fieldname, self.fx);
    }

    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_attack_slam_trail", self, "tag_origin");
    return;
  }

  if(bwastimejump == 3) {
    if(isDefined(self.fx)) {
      stopfx(fieldname, self.fx);
    }

    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_death_soul_trail", self, "tag_origin");
    return;
  }

  if(isDefined(self.fx)) {
    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_attack_slam_trail_end", self, "tag_origin");
    stopfx(fieldname, self.fx);
  }
}