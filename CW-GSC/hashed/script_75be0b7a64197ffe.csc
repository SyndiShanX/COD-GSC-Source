/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_75be0b7a64197ffe.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_2c949ef8;

function init() {}

function function_ac525f72(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  self endon(#"death", #"disconnect");
  self postfx::playpostfxbundle(#"hash_66a9fee7028a1e13");
  wait 8;
  self postfx::exitpostfxbundle(#"hash_66a9fee7028a1e13");
}