/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3c24a56641a03789.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#namespace namespace_963441cb55eef69e;

function init() {
  if(!getdvarint(@ "hash_8bfdc77e20414f2a", 0)) {
    return;
  }

  thread function_38317b48d412b1d5();
}

function function_38317b48d412b1d5() {
  flag_wait("scriptables_ready");
  caralarms = getentitylessscriptablearray("scriptablecaralarm", "script_noteworthy");

  if(caralarms.size <= 0) {
    return;
  }

  level waittill("prematch_fade_done");

  foreach(alarm in caralarms) {
    alarm setscriptablepartstate("base", "alive");
  }
}