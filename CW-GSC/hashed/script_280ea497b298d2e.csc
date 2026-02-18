/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_280ea497b298d2e.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace namespace_f180c0d7;

function pstfx_script_vignette(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level notify(#"hash_a9b7279222ef8d9");
  level endon(#"hash_a9b7279222ef8d9");

  if(bwasdemojump > 0) {
    self postfx::playpostfxbundle("pstfx_script_vignette");
    self postfx::function_c8b5f318("pstfx_script_vignette", "Inner Radius", 0.25);
    self postfx::function_c8b5f318("pstfx_script_vignette", "Outer Radius", 1);
    bottom_distance = getdvarfloat(#"bottom_distance", 0);
    middle_distance = getdvarfloat(#"middle_distance", 0);
    top_distance = getdvarfloat(#"top_distance", 0);

    while(true) {
      current_distance = getdvarfloat(#"current_distance", 0);

      if(current_distance > middle_distance) {
        level.var_9d53a8fc = mapfloat(middle_distance, bottom_distance, 0.85, 0, current_distance);

        iprintlnbold("<dev string:x38>" + level.var_9d53a8fc + "<dev string:x49>" + current_distance);
      } else {
        level.var_9d53a8fc = mapfloat(top_distance, middle_distance, 1, 0.85, current_distance);

        iprintlnbold("<dev string:x58>" + level.var_9d53a8fc + "<dev string:x49>" + current_distance);
      }

      self postfx::function_c8b5f318("pstfx_script_vignette", "Opacity", level.var_9d53a8fc);
      waitframe(1);
    }

    return;
  }

  level.var_9d53a8fc = 0;
  self postfx::exitpostfxbundle("pstfx_script_vignette");
  self postfx::function_c8b5f318("pstfx_script_vignette", "Opacity", 0);
}