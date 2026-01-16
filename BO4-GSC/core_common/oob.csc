/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\oob.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace oob;

autoexec __init__system__() {
  system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

__init__() {
  if(sessionmodeismultiplayergame()) {
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
  } else if(sessionmodeiswarzonegame()) {
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
  } else {
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
  }

  clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
  clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int", &function_95c61f07, 0, 1);
  callback::on_localclient_connect(&on_localplayer_connect);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

on_localplayer_connect(localclientnum) {
  oobmodel = getoobuimodel(localclientnum);
  setuimodelvalue(oobmodel, 0);
}

on_localplayer_spawned(localclientnum) {
  filter::disable_filter_oob(localclientnum, 0);
  self randomfade(0);
}

on_localplayer_shutdown(localclientnum) {
  localplayer = self;

  if(isDefined(localplayer)) {
    stopoutofboundseffects(localclientnum, localplayer);
  }
}

function_95c61f07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    self.nonplayeroobusage = 1;
    return;
  }

  self.nonplayeroobusage = undefined;
}

onoutofboundschange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.oob_sound_ent)) {
    level.oob_sound_ent = [];
  }

  if(!isDefined(level.oob_sound_ent[localclientnum])) {
    level.oob_sound_ent[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_origin");
  }

  localplayer = function_5c10bd79(localclientnum);

  if(function_3132f113(localplayer)) {
    return;
  }

  self callback::entity_callback(#"oob", localclientnum, {
    #old_val: oldval, 
    #new_val: newval
  });

  if(newval > 0) {
    if(!isDefined(localplayer.oob_effect_enabled)) {
      filter::init_filter_oob(localplayer);
      filter::enable_filter_oob(localclientnum, 0);
      localplayer.oob_effect_enabled = 1;

      if(util::get_game_type() === #"zstandard") {
        level.oob_sound_ent[localclientnum] playLoopSound(#"hash_6da7ae12f538ef5e", 0.5);
      } else {
        level.oob_sound_ent[localclientnum] playLoopSound(#"uin_out_of_bounds_loop", 0.5);
      }

      oobmodel = getoobuimodel(localclientnum);

      if(isDefined(level.oob_timekeep_ms) && isDefined(self.oob_start_time) && isDefined(self.oob_active_duration) && getservertime(0) - self.oob_end_time < level.oob_timekeep_ms) {
        setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms - self.oob_active_duration);
      } else {
        self.oob_active_duration = undefined;
        setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms);
      }

      self.oob_start_time = getservertime(0, 1);
    }

    newvalf = newval / 31;

    if(newvalf > 0.5) {
      newvalf = 0.5;
    }

    localplayer randomfade(newvalf);
    return;
  }

  if(isDefined(level.oob_timekeep_ms) && isDefined(self.oob_start_time)) {
    self.oob_end_time = getservertime(0, 1);

    if(!isDefined(self.oob_active_duration)) {
      self.oob_active_duration = 0;
    }

    self.oob_active_duration += self.oob_end_time - self.oob_start_time;
  }

  if(isDefined(self.nonplayeroobusage) && self.nonplayeroobusage) {
    self.oob_active_duration = undefined;
  }

  stopoutofboundseffects(localclientnum, localplayer);
}

stopoutofboundseffects(localclientnum, localplayer) {
  if(!isDefined(localplayer)) {
    return;
  }

  filter::disable_filter_oob(localclientnum, 0);

  if(isDefined(localplayer)) {
    localplayer randomfade(0);
  }

  if(isDefined(level.oob_sound_ent) && isDefined(level.oob_sound_ent[localclientnum])) {
    level.oob_sound_ent[localclientnum] stopallloopsounds(0.5);
  }

  oobmodel = getoobuimodel(localclientnum);
  setuimodelvalue(oobmodel, 0);

  if(isDefined(localplayer) && isDefined(localplayer.oob_effect_enabled)) {
    localplayer.oob_effect_enabled = 0;
    localplayer.oob_effect_enabled = undefined;
  }
}

getoobuimodel(localclientnum) {
  controllermodel = getuimodelforcontroller(localclientnum);
  return createuimodel(controllermodel, "hudItems.outOfBoundsEndTime");
}