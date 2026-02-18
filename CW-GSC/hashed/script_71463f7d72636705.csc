/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_71463f7d72636705.csc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace sound_tinnitus;

function function_fbb3b7ed(_notify, _handle) {
  if(isDefined(_handle)) {
    self stoploopsound(_handle);
    level.var_2b64ba11--;
  }
}

function function_9a82b890(localclientnum, duration, startsound, var_ed2d4562, endsound) {
  if(level.var_2b64ba11 < 200) {
    level.var_2b64ba11++;
    handle = undefined;
    self endoncallbackparam(&function_fbb3b7ed, &handle, #"death", #"disconnect");
    endtime = gettime() + duration * 1000;

    if(isDefined(startsound)) {
      if(gettime() < endtime) {
        self playSound(localclientnum, startsound);
      }
    }

    if(isDefined(var_ed2d4562)) {
      while(gettime() < endtime) {
        handle = self playLoopSound(var_ed2d4562);
        waitframe(1);
      }

      self stoploopsound(handle);
      handle = undefined;
    }

    if(isDefined(endsound)) {
      self playSound(localclientnum, endsound);
    }

    level.var_2b64ba11--;
  }
}

function event_handler[event_b19fdc1e] event_watcher(eventstruct) {
  if(!isDefined(level.var_73eeec22[eventstruct.weapon.var_b57f13ef])) {
    level.var_73eeec22[eventstruct.weapon.var_b57f13ef] = getscriptbundle(eventstruct.weapon.var_b57f13ef);

    if(!isDefined(level.var_73eeec22[eventstruct.weapon.var_b57f13ef])) {
      return;
    }
  }

  var_73eeec22 = level.var_73eeec22[eventstruct.weapon.var_b57f13ef];
  local_player = function_5c10bd79(eventstruct.localclientnum);

  if(!function_56e2eaa8(local_player)) {
    return;
  }

  if(!isPlayer(local_player) || isDefined(getplayervehicle(local_player))) {
    return;
  }

  if(distancesquared(local_player.origin, eventstruct.position) < var_73eeec22.maxrange * var_73eeec22.maxrange) {
    if(!isDefined(level.var_2b64ba11)) {
      level.var_2b64ba11 = 0;
    }

    viewangles = local_player getplayerangles();
    dirtotarget = vectornormalize(eventstruct.position - local_player.origin);
    playerforward = anglesToForward(viewangles);
    playerright = anglestoright(viewangles);
    var_1978c7fc = vectordot(dirtotarget, playerforward);
    rightdot = vectordot(dirtotarget, playerright);
    var_5c9ee157 = dirtotarget * -1;
    var_6059f1ff = local_player.origin + (randomfloat(10) - 5, randomfloat(10) - 5, randomfloat(10) - 5) + 2 * var_5c9ee157;
    local_player function_3edb40f5(eventstruct.weapon, eventstruct.position, var_6059f1ff, dirtotarget * -1);

    if(var_1978c7fc >= 0.5) {
      local_player thread function_9a82b890(eventstruct.localclientnum, var_73eeec22.duration, var_73eeec22.var_499e1c7f, var_73eeec22.var_d45165cb, var_73eeec22.var_82c14e93);
    } else if(var_1978c7fc <= -0.5) {
      local_player thread function_9a82b890(eventstruct.localclientnum, var_73eeec22.duration, var_73eeec22.var_f3b0d4f, var_73eeec22.var_9d3d0581, var_73eeec22.var_efce6189);
    }

    if(rightdot >= 0.5) {
      local_player thread function_9a82b890(eventstruct.localclientnum, var_73eeec22.duration, var_73eeec22.var_3db06635, var_73eeec22.var_5dddb8e8, var_73eeec22.var_edcc1468);
      return;
    }

    if(rightdot <= -0.5) {
      local_player thread function_9a82b890(eventstruct.localclientnum, var_73eeec22.duration, var_73eeec22.var_90c3ef0c, var_73eeec22.var_60e944e1, var_73eeec22.var_94f03120);
    }
  }
}