/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_grappler.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_grappler;

function private autoexec __init__system__() {
  system::register(#"zm_grappler", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &grappler_source, 1, 0);
  clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &grappler_beam, 1, 0);

  if(!isDefined(level.grappler_beam)) {
    level.grappler_beam = "zod_beast_grapple_beam";
  }
}

function grappler_source(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.grappler_sources)) {
    level.grappler_sources = [];
  }

  assert(!isDefined(level.grappler_sources[bwastimejump]));
  level.grappler_sources[bwastimejump] = self;
  level notify("grapple_id_" + bwastimejump);
}

function grappler_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!isDefined(level.grappler_sources)) {
    level.grappler_sources = [];
  }

  if(!isDefined(level.grappler_sources[bwastimejump])) {
    level waittilltimeout(1, "grapple_id_" + bwastimejump);
  }

  assert(isDefined(level.grappler_sources[bwastimejump]));
  pivot = level.grappler_sources[bwastimejump];

  if(!isDefined(pivot)) {
    return;
  }

  if(bwastimejump) {
    thread function_34e3f163(self, "tag_origin", pivot, 0.05);
    return;
  }

  self notify(#"grappler_done");
}

function function_34e3f163(player, tag, pivot, delay) {
  player endon(#"grappler_done", #"death");
  pivot endon(#"death");
  wait delay;
  thread grapple_beam(player, tag, pivot);
}

function function_f4b9c325(notifyhash) {
  level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.grappler_beam);
}

function grapple_beam(player, tag, pivot) {
  self endoncallback(&function_f4b9c325, #"death");
  self.player = player;
  self.tag = tag;
  self.pivot = pivot;
  level beam::launch(player, tag, pivot, "tag_origin", level.grappler_beam, 1);
  player waittill(#"grappler_done");
  level beam::kill(player, tag, pivot, "tag_origin", level.grappler_beam);
}