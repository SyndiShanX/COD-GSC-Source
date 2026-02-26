/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawnbeacon_shared.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace spawn_beacon;

function init_shared() {
  setupclientfields();
}

function setupclientfields() {
  clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int", &spawnbeacon_placed, 0, 0);
  clientfield::register_clientuimodel("hudItems.spawnbeacon.active", #"hud_items", [#"spawnbeacon", #"active"], 1, 1, "int", undefined, 0, 0);
}

function private spawnbeacon_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  playtagfxset(bwastimejump, "gadget_spawnbeacon_teamlight", self);
  self useanimtree("generic");
  self setanimrestart("o_spawn_beacon_deploy", 1, 0, 1);
}