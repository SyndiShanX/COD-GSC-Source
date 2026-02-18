/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6126d188b0a04d94.csc
***********************************************/

#using scripts\core_common\ai\archetype_nosferatu;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace namespace_58e19d6;

function init() {
  function_cae618b4("spawner_zombietron_silverback");
  clientfield::register("actor", "silverback_spawn", 1, 1, "counter", &silverback_spawn, 0, 0);
}

function private silverback_spawn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(bwastimejump);
  forcestreamxmodel("zombietron_spoon");
  wait 3;
  stopforcestreamingxmodel("zombietron_spoon");
}