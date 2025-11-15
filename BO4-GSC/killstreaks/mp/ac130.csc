/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ac130.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace ac130;

autoexec __init__system__() {
  system::register(#"ac130", &__init__, undefined, #"killstreaks");
}

__init__() {
  callback::on_localclient_connect(&on_localclient_connect);
  callback::function_17381fe(&function_17381fe);
  clientfield::register("clientuimodel", "vehicle.selectedWeapon", 1, 2, "int", &function_db40057d, 0, 0);
  clientfield::register("clientuimodel", "vehicle.flareCount", 1, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "vehicle.inAC130", 1, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "inAC130", 1, 1, "int", &function_555656fe, 0, 1);
}

on_localclient_connect(localclientnum) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.maincannonClipSize"), 2);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.autocannonClipSize"), 4);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "vehicle.ac130.chaingunClipSize"), 20);
}

function_17381fe(localclientnum) {
  if(shoutcaster::is_shoutcaster(localclientnum)) {
    player = function_5c10bd79(localclientnum);

    if(player clientfield::get_to_player("inAC130")) {
      function_555656fe(localclientnum, undefined, !shoutcaster::function_2e6e4ee0(localclientnum));
    }
  }
}

function_555656fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  bundle = struct::get_script_bundle("killstreak", "killstreak_ac130");
  postfxbundle = bundle.("ksVehiclePostEffectBun");

  if(!isDefined(postfxbundle)) {
    return;
  }

  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval && shoutcaster::function_2e6e4ee0(localclientnum)) {
    newval = 0;
  }

  if(newval) {
    if(self postfx::function_556665f2(postfxbundle) == 0) {
      self codeplaypostfxbundle(postfxbundle);
    }

    return;
  }

  if(self postfx::function_556665f2(postfxbundle)) {
    self codestoppostfxbundle(postfxbundle);
  }
}

function_db40057d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == 0) {
    return;
  }

  switch (newval) {
    case 1:
      playSound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
      break;
    case 2:
      playSound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
      break;
    case 3:
      playSound(0, #"hash_731251c4b03b5b09", (0, 0, 0));
      break;
  }
}