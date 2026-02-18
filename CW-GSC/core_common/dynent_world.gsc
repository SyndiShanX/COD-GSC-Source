/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\dynent_world.gsc
***********************************************/

#using scripts\core_common\system_shared;
#namespace dynent_world;

function private autoexec __init__system__() {
  system::register(#"dynent_world", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread devgui_loop();
}

function private event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  dynent = eventstruct.ent;
  var_16a4afdc = eventstruct.state;
  bundle = function_489009c1(dynent);

  if(isDefined(bundle) && isDefined(bundle.dynentstates) && isDefined(bundle.dynentstates[var_16a4afdc])) {
    newstate = bundle.dynentstates[var_16a4afdc];
    teleport = eventstruct.teleport;

    if(!is_true(bundle.var_f710132b)) {
      pos = (isDefined(newstate.pos_x) ? newstate.pos_x : 0, isDefined(newstate.pos_y) ? newstate.pos_y : 0, isDefined(newstate.pos_z) ? newstate.pos_z : 0);
      pos = rotatepoint(pos, dynent.var_c286a1ae);
      neworigin = dynent.var_718063b0 + pos;
      pitch = dynent.var_c286a1ae[0] + (isDefined(newstate.var_9d1a4684) ? newstate.var_9d1a4684 : 0);
      yaw = dynent.var_c286a1ae[1] + (isDefined(newstate.var_d81008de) ? newstate.var_d81008de : 0);
      roll = dynent.var_c286a1ae[2] + (isDefined(newstate.var_774f5d57) ? newstate.var_774f5d57 : 0);
      newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
      var_a852a7dd = isDefined(bundle.var_a852a7dd) ? bundle.var_a852a7dd : isDefined(newstate.var_b272e331) ? newstate.var_b272e331 : 0;
      var_72e281d4 = isDefined(bundle.var_72e281d4) ? bundle.var_72e281d4 : isDefined(newstate.var_f5cff1c7) ? newstate.var_f5cff1c7 : 0;

      if(!teleport && var_a852a7dd > 0) {
        dynent function_49ed8678(neworigin, var_a852a7dd);
        dynent function_7622f013(newangles, var_a852a7dd, var_72e281d4);
      } else {
        dynent.origin = neworigin;
        dynent.angles = newangles;
      }
    }

    if(is_true(bundle.var_fd4bc8dd) && !teleport && isDefined(newstate.var_55c3fa1)) {
      if(!is_true(dynent.var_c78a0afc)) {
        playsoundatposition(newstate.var_55c3fa1, dynent.origin);
      }
    }

    if(isDefined(newstate.overridemodel)) {
      add_helico(dynent, newstate.overridemodel);
    }

    if(isDefined(newstate.stateanim)) {
      starttime = 0;
      rate = isDefined(newstate.animrate) ? newstate.animrate : 0;

      if(is_true(newstate.var_8725802)) {
        gametime = gettime();

        if(is_true(newstate.var_e23400ad)) {
          gametime += abs(dynent.origin[0] + dynent.origin[1] + dynent.origin[2]);
        }

        animlength = int(getanimlength(newstate.stateanim) * 1000);
        starttime = gametime / animlength / rate;
        starttime -= int(starttime);
      } else if(teleport && !isanimlooping(newstate.stateanim)) {
        starttime = 1;
      }

      function_1e23c01f(dynent, newstate.stateanim, starttime, rate);
    } else {
      function_27b5ddff(dynent);
    }

    setdynentenabled(dynent, is_true(newstate.enable));
    function_9d43a7ef(dynent, is_true(newstate.var_b7401b42));
  }
}

function private event_handler[event_9e981c4] function_ff8b3908(eventstruct) {
  dynent = eventstruct.ent;
  bundle = function_489009c1(dynent);
  var_1a5e0c43 = is_true(eventstruct.clientside);

  if(isDefined(bundle) && isDefined(bundle.dynentstates)) {
    stateindex = isDefined(bundle.destroyed) ? bundle.destroyed : var_1a5e0c43 ? isDefined(bundle.vehicledestroyed) ? bundle.vehicledestroyed : 0 : 0;

    if(isDefined(bundle.dynentstates[stateindex])) {
      setdynentstate(dynent, stateindex);
    }

    if(var_1a5e0c43 && dynent.script_noteworthy === # "hash_4d1fb8524fdfd254") {
      a_players = function_a1ef346b(undefined, dynent.origin, 225);

      foreach(player in a_players) {
        if(player isinvehicle()) {
          vehicle = player getvehicleoccupied();
          n_speed = vehicle getspeed();

          if(abs(n_speed) > 0) {
            player notify(#"hash_34928429a0070510", {
              #dynent: dynent
            });
          }
        }
      }
    }
  }
}

function event_handler[event_cf200f34] function_209450ae(eventstruct) {
  dynent = eventstruct.ent;

  if(isDefined(dynent.ondamaged)) {
    [[dynent.ondamaged]](eventstruct);
  }
}

function private devgui_loop() {
  level endon(#"game_ended");

  while(!canadddebugcommand()) {
    waitframe(1);
  }

  adddebugcommand("<dev string:x38>");

  while(true) {
    wait 0.25;
    dvarstr = getdvarstring(#"hash_40f9f26f308dd924", "<dev string:x81>");

    if(dvarstr == "<dev string:x81>") {
      continue;
    }

    setDvar(#"hash_40f9f26f308dd924", "<dev string:x81>");
    args = strtok(dvarstr, "<dev string:x85>");

    switch (args[0]) {
      case # "reset":
        resetdynents();
        break;
    }
  }
}