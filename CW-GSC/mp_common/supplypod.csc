/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\supplypod.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace supplypod;

function private autoexec __init__system__() {
  system::register(#"supplypod", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
}

function private supplypod_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  self function_1f0c7136(4);
  self useanimtree("generic");
}