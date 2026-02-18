/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_17b26b2e6b98a995.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\trigger_shared;
#namespace namespace_ecdab0f4;

function function_b68e2d37() {
  setDvar(#"hash_76c0d7e6385ee6de", 0.3);
  setDvar(#"hash_5639762beeb6f5ad", 1.9);
}

function function_f84e1e7() {
  var_dd67799c = getent("heli", "targetname");
  var_dd67799c.probe = getent("probe_script_introHeli", "targetname");

  if(isDefined(var_dd67799c.probe)) {
    var_dd67799c.probe linkto(var_dd67799c, "tag_origin_animate", (50, 0, -50), (0, 89.981, 2.4999));
  }
}