/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_disciple\zombie_disciple_metabones.gsc
*************************************************************************/

#using scripts\common\metabone;
#namespace zombie_disciple_metabones;

function autoexec main() {
  var_601bcee5d276f46d = "zombie_disciple";
  function_d6736c5ef5ac2990(var_601bcee5d276f46d, &function_b9f4b7206d76e7ce);
}

function private function_b9f4b7206d76e7ce(params) {
  metabone_name = params.metabone_name;

  if(self getscriptablehaspart(metabone_name)) {
    self setscriptablepartstate(metabone_name, "destroyed");
    function_3d2728c0e2252a1d(metabone_name, "destroyed");
    function_7380ccd6f2c49392(metabone_name, 1);

    if(!istrue(self.var_8eea1c7b28ac77b5)) {
      self function_3e89eb3d8e3f1811("in_head_pain", 1);
    }

    return;
  }

  assertmsg("<dev string:x1c>" + metabone_name);
}