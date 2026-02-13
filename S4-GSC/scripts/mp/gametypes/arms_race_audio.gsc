/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arms_race_audio.gsc
****************************************************/

main() {
  config_system();
  init_snd_flags();
  init_globals();
  launch_threads();
}

config_system() {}

init_snd_flags() {}

init_globals() {}

launch_threads() {}

play_motorcycle_summon(var_0) {
  _id_0847::_id_DF08("mp_arms_race_summon_motorcycle", var_0);
}

player_spawn_camera_whoosh() {
  self playsoundtoplayer("ui_mp_respawn_camera_whoosh", self);
}

nukecrategrabsound(var_0) {
  if(isDefined(var_0)) {
    _id_0847::_id_DF08("mp_arms_race_crate_grab", var_0);
  }
}

prenukewarningsound(var_0) {
  if(isDefined(var_0)) {
    var_0.warning_alarm = _id_0847::_id_DF08("mp_arms_race_pre_nuke_alarm_lp", var_0.origin);
    var_0.warning_siren_01 = _id_0847::_id_DF08("mp_arms_race_pre_nuke_sirens_01", var_0.origin);
    var_0.warning_siren_02 = _id_0847::_id_DF08([3.0, "mp_arms_race_pre_nuke_sirens_02"], var_0.origin);
    var_0.warning_siren_03 = _id_0847::_id_DF08([7.0, "mp_arms_race_pre_nuke_sirens_01"], var_0.origin);
    var_0.warning_siren_far_01 = _id_0847::_id_DF08("mp_arms_race_pre_nuke_sirens_far_01", var_0.origin);
    var_0.warning_siren_far_02 = _id_0847::_id_DF08([3.0, "mp_arms_race_pre_nuke_sirens_far_02"], var_0.origin);
    var_0.warning_siren_far_03 = _id_0847::_id_DF08([7.0, "mp_arms_race_pre_nuke_sirens_far_01"], var_0.origin);
    var_0 thread stopprenukewarning();
  }
}

stopprenukewarning() {
  level waittill("nuke_landed");
  _id_0847::_id_DF21(self.warning_alarm, 0.5);
  _id_0847::_id_DF21(self.warning_siren_01, 0.5);
  _id_0847::_id_DF21(self.warning_siren_02, 0.5);
  _id_0847::_id_DF21(self.warning_siren_03, 0.5);
  _id_0847::_id_DF21(self.warning_siren_far_01, 0.5);
  _id_0847::_id_DF21(self.warning_siren_far_02, 0.5);
  _id_0847::_id_DF21(self.warning_siren_far_03, 0.5);
}

startnuketimersounds_outsidenukebase(var_0) {
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      if(isDefined(var_2.small_destruction_timer)) {
        var_2.small_destruction_timer_num_pending = var_2.small_destruction_timer_num_pending + 1;
        continue;
      }

      var_2.small_destruction_timer = _id_0847::_id_DF08("mp_arms_race_destruction_timer_sml", var_2);

      if(istrue(var_0) && isDefined(var_2.small_destruction_timer_num_pending)) {
        var_2.small_destruction_timer_num_pending = var_2.small_destruction_timer_num_pending - 1;
      } else {
        var_2.small_destruction_timer_num_pending = 0;
      }

      var_2 thread stopnuketimer_outsidenukebase();
    }
  }
}

stopnuketimer_outsidenukebase() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("nuke_landed");
  _id_0847::_id_DF21(self.small_destruction_timer, 0.5);
  _id_0847::_id_DF21(self.lrg_destruction_timer, 0.5);
  self.small_destruction_timer = undefined;
  self.lrg_destruction_timer = undefined;

  if(self.small_destruction_timer_num_pending > 0) {
    startnuketimersounds_outsidenukebase(1);
  }
}

startnuketimersounds_insidenukebase() {
  level endon("game_ended");
  self endon("disconnect");
  level endon("nuke_landed");

  if(!isDefined(self)) {
    return;
  }
  _id_0847::_id_DF08("mp_arms_race_destruction_timer_banner_start", self);
  self.lrg_destruction_timer = _id_0847::_id_DF08("mp_arms_race_destruction_timer_lrg", self);
  thread stopnuketimer_insidenukebase();
}

stopnuketimer_insidenukebase() {
  level endon("game_ended");
  self endon("disconnect");
  level endon("nuke_landed");
  level waittill("large_destruction_timer_stop");
  _id_0847::_id_DF21(self.lrg_destruction_timer, 0.5);
  _id_0847::_id_DF08("mp_arms_race_destruction_timer_banner_end", self);
}

contested_base_alarm_sfx(var_0) {
  var_1 = 3;
  var_2 = _id_0847::_id_DF08("mp_arms_race_contested_base_alarm_lp", var_0);
  self waittill("snd_stop_contested_alarm");
  _id_0847::_id_DF21(var_2, 3);
}

snd_incomingmissileintro(var_0) {
  wait 1.3;
  _id_0847::_id_DF08("mp_arms_race_missile_incoming_intro", var_0);
}

snd_incomingmissile(var_0) {
  _id_0847::_id_DF08("mp_arms_race_missile_incoming", var_0);
}

snd_nebulagas(var_0) {
  _id_0847::_id_DF08("mp_arms_race_nebula_gas_lp", var_0);
}