/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\display_transition.csc
******************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#namespace display_transition;

init_shared() {
  registerclientfields();
}

registerclientfields() {
  if(sessionmodeiswarzonegame()) {
    clientfield::register("clientuimodel", "eliminated_postfx", 12000, 1, "int", &function_c73ec9a, 0, 0);
  }
}

function_c73ec9a(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  isplaying = postfx::function_556665f2(#"pstfx_wz_loss");

  if(newval == 1) {
    if(!isplaying) {
      self codeplaypostfxbundle(#"pstfx_wz_loss");
    }

    return;
  }

  if(newval == 0) {
    if(isplaying) {
      self postfx::stoppostfxbundle(#"pstfx_wz_loss");
    }
  }
}