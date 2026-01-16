/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_exploderanim.gsc
********************************/

main() {
  var_0 = getentarray("script_model", "classname");

  foreach(var_2 in var_0) {
    if(isdefined(var_2.script_exploder))
      var_2 thread exploderanim_think();
  }
}

exploderanim_think() {
  for (;;) {
    self waittill("play_exploder_anim");
    thread anim_play();
  }
}

anim_play() {
  var_0 = undefined;
  var_1 = strtok(self.targetname, ":;, ");

  if(var_1.size > 1 && isdefined(var_1[1]))
    var_0 = var_1[1];
  else
    var_0 = self.model + "_anim";

  var_2 = get_animtree(var_0);
  maps\_utility::assign_animtree(var_2);
  maps\_anim::anim_single_solo(self, var_0);
}

get_animtree(var_0) {
  var_1 = undefined;

  for (var_2 = 0; var_2 < level.exploder_animtrees.size; var_2++) {
    var_3 = getarraykeys(level.scr_anim[level.exploder_animtrees[var_2]]);

    if(common_scripts\utility::array_contains(var_3, var_0)) {
      var_1 = level.exploder_animtrees[var_2];
      break;
    }
  }

  return var_1;
}