/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_grappler.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\filter_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_grappler;

autoexec __init__system__() {
  system::register(#"zm_grappler", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &grappler_source, 1, 0);
  clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &grappler_beam, 1, 0);

  if(!isDefined(level.grappler_beam)) {
    level.grappler_beam = "zod_beast_grapple_beam";
  }
}

grappler_source(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.grappler_sources)) {
    level.grappler_sources = [];
  }

  assert(!isDefined(level.grappler_sources[newval]));
  level.grappler_sources[newval] = self;
  level notify("grapple_id_" + newval);
}

grappler_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!isDefined(level.grappler_sources)) {
    level.grappler_sources = [];
  }

  if(!isDefined(level.grappler_sources[newval])) {
    level waittilltimeout(1, "grapple_id_" + newval);
  }

  assert(isDefined(level.grappler_sources[newval]));
  pivot = level.grappler_sources[newval];

  if(!isDefined(pivot)) {
    return;
  }

  if(newval) {
    thread function_34e3f163(self, "tag_origin", pivot, 0.05);
    return;
  }

  self notify(#"grappler_done");
}

function_34e3f163(player, tag, pivot, delay) {
  player endon(#"grappler_done", #"death");
  pivot endon(#"death");
  wait delay;
  thread grapple_beam(player, tag, pivot);
}

function_f4b9c325(notifyhash) {
  level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.grappler_beam);
}

grapple_beam(player, tag, pivot) {
  self endoncallback(&function_f4b9c325, #"death");
  self.player = player;
  self.tag = tag;
  self.pivot = pivot;
  level beam::launch(player, tag, pivot, "tag_origin", level.grappler_beam, 1);
  player waittill(#"grappler_done");
  level beam::kill(player, tag, pivot, "tag_origin", level.grappler_beam);
}