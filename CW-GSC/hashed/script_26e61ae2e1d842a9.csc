/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26e61ae2e1d842a9.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\map;
#using scripts\core_common\util_shared;
#namespace namespace_1a4edaec;

function event_handler[level_init] main(eventstruct) {
  bundle = function_9ea44286();

  if(isDefined(bundle)) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
  }
}

function on_localplayer_spawned(localclientnum) {
  self thread function_fe8cf253(localclientnum);
}

function function_9ea44286() {
  mapbundle = map::get_script_bundle();

  if(!isDefined(mapbundle)) {
    return undefined;
  }

  str_gametype = util::get_game_type();

  if(str_gametype === # "zsurvival") {
    if(isDefined(mapbundle.var_b74bbf7)) {
      return getscriptbundle(mapbundle.var_b74bbf7);
    }
  }

  if(!isDefined(mapbundle.var_e13ec3f3)) {
    return undefined;
  }

  return getscriptbundle(mapbundle.var_e13ec3f3);
}

function private function_fe8cf253(localclientnum) {
  self endon(#"death");
  util::waittill_dobj(localclientnum);
  bundle = function_9ea44286();

  if(isDefined(self.var_87259100)) {
    stopfx(localclientnum, self.var_87259100);
  }

  if(isDefined(bundle.var_492662d7)) {
    self.var_87259100 = playfxoncamera(localclientnum, bundle.var_492662d7);
  }

  if(isDefined(bundle.var_39b6fcfb)) {
    minwait = isDefined(bundle.var_472be987) ? bundle.var_472be987 : 0.25;
    maxwait = isDefined(bundle.var_bce2eec7) ? bundle.var_bce2eec7 : 0.25;

    while(true) {
      playfxoncamera(localclientnum, bundle.var_39b6fcfb);

      minwait = isDefined(bundle.var_472be987) ? bundle.var_472be987 : 0.25;
      maxwait = isDefined(bundle.var_bce2eec7) ? bundle.var_bce2eec7 : 0.25;

      if(minwait <= maxwait) {
        wait randomfloatrange(minwait, maxwait);
        continue;
      }

      wait min(minwait, maxwait);
    }
  }
}