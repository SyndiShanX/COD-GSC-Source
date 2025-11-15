/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_fasttravel_ziplines.csc
************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_fasttravel;

#namespace zm_orange_fasttravel_ziplines;

init() {
  clientfield::register("scriptmover", "clone_control", 24000, 1, "int", &function_f747c7cd, 0, 0);
  clientfield::register("toplayer", "hide_player_legs", 24000, 1, "int", &function_a0c1af51, 0, 0);
  clientfield::register("toplayer", "blur_post_fx", 24000, 1, "int", &play_blur_post_fx, 0, 1);
}

function_f747c7cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self.owner == function_5c10bd79(localclientnum)) {
      self thread function_97adc67(localclientnum);
    }
  }
}

private function_97adc67(localclientnum) {
  self endon(#"death", #"entityshutdown");
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  while(true) {
    if(self clientfield::get("clone_control")) {
      players = getlocalplayers();

      foreach(player in players) {
        if(isthirdperson(localclientnum)) {
          self show();
          player hide();
          continue;
        }

        player show();
        self hide();
      }
    }

    waitframe(1);
  }
}

private function_a0c1af51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval) {
    self hideviewlegs();
    return;
  }

  self showviewlegs();
}

play_blur_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval === 1) {
    if(!self postfx::function_556665f2("pstfx_speedblur")) {
      self postfx::playpostfxbundle("pstfx_speedblur");
    }

    self postfx::function_c8b5f318("pstfx_speedblur", #"blur", 0.05);
    self postfx::function_c8b5f318("pstfx_speedblur", #"inner mask", 0.3);
    self postfx::function_c8b5f318("pstfx_speedblur", #"outer mask", 0.8);
    return;
  }

  if(self postfx::function_556665f2("pstfx_speedblur")) {
    self postfx::stoppostfxbundle("pstfx_speedblur");
  }
}