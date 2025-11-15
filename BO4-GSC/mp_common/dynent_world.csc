/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\dynent_world.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace dynent_world;

autoexec __init__system__() {
  system::register(#"dynent_world", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0)) {
    return;
  }

  clientfield::register("clientuimodel", "hudItems.dynentUseHoldProgress", 13000, 5, "float", undefined, 0, 0);
}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  dynent = eventstruct.ent;
  var_16a4afdc = eventstruct.state;
  bundle = function_489009c1(dynent);

  if(isDefined(bundle) && isDefined(bundle.dynentstates) && isDefined(bundle.dynentstates[var_16a4afdc])) {
    newstate = bundle.dynentstates[var_16a4afdc];
    var_eb7c2031 = isDefined(bundle.var_eb7c2031) && bundle.var_eb7c2031;
    var_59102aec = isDefined(bundle.vehicledestroyed) ? bundle.vehicledestroyed : 0;

    if(var_16a4afdc == var_59102aec) {
      if(var_eb7c2031 && !function_8a8a409b(dynent)) {
        if(isDefined(newstate.var_55c3fa1)) {
          playSound(0, newstate.var_55c3fa1, dynent.origin);
        }

        return;
      }
    }

    teleport = eventstruct.teleport;
    var_718063b0 = eventstruct.rootorigin;
    var_c286a1ae = eventstruct.rootangles;

    if(!(isDefined(bundle.var_f710132b) && bundle.var_f710132b)) {
      pos = (isDefined(newstate.pos_x) ? newstate.pos_x : 0, isDefined(newstate.pos_y) ? newstate.pos_y : 0, isDefined(newstate.pos_z) ? newstate.pos_z : 0);
      pos = rotatepoint(pos, var_c286a1ae);
      neworigin = var_718063b0 + pos;
      pitch = var_c286a1ae[0] + (isDefined(newstate.var_9d1a4684) ? newstate.var_9d1a4684 : 0);
      yaw = var_c286a1ae[1] + (isDefined(newstate.var_d81008de) ? newstate.var_d81008de : 0);
      roll = var_c286a1ae[2] + (isDefined(newstate.var_774f5d57) ? newstate.var_774f5d57 : 0);
      newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
      var_a852a7dd = isDefined(bundle.var_a852a7dd) ? bundle.var_a852a7dd : 0;

      if(!teleport && var_a852a7dd > 0) {
        dynent function_49ed8678(neworigin, var_a852a7dd);
        dynent function_7622f013(newangles, var_a852a7dd);
      } else {
        dynent.origin = neworigin;
        dynent.angles = newangles;
      }
    }

    if(!teleport && isDefined(newstate.var_55c3fa1)) {
      playSound(0, newstate.var_55c3fa1, dynent.origin);
    }

    if(isDefined(newstate.overridemodel)) {
      add_helico(dynent, newstate.overridemodel);
    }

    if(isDefined(newstate.stateanim)) {
      starttime = 0;
      rate = isDefined(newstate.animrate) ? newstate.animrate : 0;

      if(isDefined(newstate.var_8725802) && newstate.var_8725802) {
        gametime = gettime();

        if(isDefined(newstate.var_e23400ad) && newstate.var_e23400ad) {
          gametime += abs(dynent.origin[0] + dynent.origin[1] + dynent.origin[2]);
        }

        animlength = int(getanimlength(newstate.stateanim) * 1000);
        starttime = gametime / animlength / rate;
        starttime -= int(starttime);
      } else if(teleport && !isanimlooping(0, newstate.stateanim)) {
        starttime = 1;
      }

      function_1e23c01f(dynent, newstate.stateanim, starttime, rate);
    } else {
      function_27b5ddff(dynent);
    }

    if(isDefined(newstate.statefx) && isDefined(eventstruct.localclientnum)) {
      if(isDefined(dynent.fx)) {
        stopfx(eventstruct.localclientnum, dynent.fx);
        dynent.fx = undefined;
      }

      if(newstate.statefx !== #"hash_633319dd8957ddbb") {
        dynent.fx = playfxondynent(newstate.statefx, dynent);
      }
    }

    setdynentenabled(dynent, isDefined(newstate.enable) && newstate.enable);
  }
}