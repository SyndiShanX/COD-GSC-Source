/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_ping.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zm_ping;

function private autoexec __init__system__() {
  system::register(#"zm_ping", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_dfecc4e02f58398", 1, 3, "int");
  clientfield::register("zbarrier", "" + # "hash_dfecc4e02f58398", 1, 2, "int");
  level.var_142ecedc = &function_142ecedc;
}

function function_9e0598bb(id) {
  assert(isentity(self), "<dev string:x38>");

  if(!isentity(self)) {
    return;
  }

  self clientfield::set("" + # "hash_dfecc4e02f58398", id);
}

function function_550247bd(id) {
  assert(id > 10, "<dev string:x6e>");
  function_9e0598bb(id - 10);
}

function private function_142ecedc(param) {
  duration = -1;
  ai = getentbynum(param);

  if(isactor(ai) && isalive(ai) && ai.zm_ai_category === # "boss") {
    duration = 10;
  }

  if(isDefined(ai.var_fdd8e511)) {
    duration = ai.var_fdd8e511;
  }

  return duration;
}