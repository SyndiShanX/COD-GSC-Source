/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_trial_lighthouse_beam.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm\zm_orange_lighthouse;
#include scripts\zm\zm_orange_pap;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_orange_trial_lighthouse_beam;

autoexec __init__system__() {
  system::register(#"zm_orange_trial_lighthouse_beam", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"lighthouse_beam", &on_begin, &on_end);
}

private on_begin() {
  str_targetname = "trials_lighthouse_beam";
  level setup_lighthouse();
  callback::function_33f0ddd3(&function_33f0ddd3);
  level zm_trial::function_25ee130(1);

  foreach(player in getplayers()) {
    player thread function_1e902f3b();
  }
}

private on_end(round_reset) {
  level notify(#"hash_2b53ed06a97eb26c");
  level.var_ab11c23d function_f223e16f(round_reset);
  callback::function_824d206(&function_33f0ddd3);
  level zm_trial::function_25ee130(0);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_dc0859e();
    player thread zm_trial_util::function_73ff0096();
  }

  level.var_7f31a12d = undefined;
  level zm_orange_lighthouse::function_d85bd834();
}

private setup_lighthouse() {
  level notify(#"hash_661044fd7c7faa55");

  if(level.var_7d8bf93f zm_pack_a_punch::is_on()) {
    if(level.var_7d8bf93f flag::get("Pack_A_Punch_on")) {
      level.var_7d8bf93f flag::wait_till("pap_waiting_for_user");
    }

    var_611e46b7 = undefined;

    foreach(var_143bf55a in level.var_9f657597) {
      if(var_143bf55a.script_noteworthy == level.var_7d8bf93f.script_noteworthy + "_debris") {
        var_611e46b7 = var_143bf55a;
        break;
      }
    }

    level.var_7d8bf93f zm_pack_a_punch::function_bb629351(0, "initial");

    if(level.var_7d8bf93f == level.var_9d121dce) {
      exploder::exploder_stop("fxexp_pap_light_icefloe");
    }

    if(isDefined(var_611e46b7)) {
      while(var_611e46b7 scene::is_playing("melt")) {
        wait 0.25;
      }

      var_611e46b7 thread zm_orange_pap::function_69a4b74b(1);

      if(isDefined(var_611e46b7.target)) {
        clip_brush = getent(var_611e46b7.target, "targetname");
        clip_brush thread zm_orange_pap::function_4d7320f5(1);
      }
    }
  }

  if(level.var_ab11c23d.var_58df9892 == 3 || level.var_ab11c23d.var_58df9892 == 8) {
    level.var_ab11c23d notify(#"hash_1aa56851d9d4ec0d");

    if(isDefined(level.var_ab11c23d.vh_target)) {
      level.var_ab11c23d.vh_target.b_moving = 0;
      level.var_ab11c23d.vh_target clientfield::set("" + #"hash_19bce46b8ab82440", 0);
      waitframe(1);
      level.var_ab11c23d.vh_target delete();
    }

    if(isDefined(level.var_ab11c23d.t_trap)) {
      level.var_ab11c23d.t_trap notify(#"trap_done");
      waitframe(1);
      level.var_ab11c23d.t_trap delete();
    }
  }

  level thread zm_orange_lighthouse::function_ad646ef8(0);
  level.var_ab11c23d thread function_dbad2f5a();
}

function_dbad2f5a() {
  self endon(#"death", #"hash_2b53ed06a97eb26c");
  level.var_ab11c23d notify(#"hash_78fc5bbd712046b0");

  for(vh_target = spawner::simple_spawn_single(getent("virgil", "targetname")); !isDefined(vh_target); vh_target = spawner::simple_spawn_single(getent("virgil", "targetname"))) {
    waitframe(1);
  }

  self.var_da138ae4 = getvehiclenode("trials_lighthouse_start", "targetname");
  vh_target.origin = self.var_da138ae4.origin;
  vh_target.b_moving = 0;
  vh_target val::set(#"lighthouse_target", "takedamage", 0);
  self.vh_target = vh_target;
  self zm_orange_lighthouse::function_1b488412(vh_target.origin, 1);
  self.vh_target.e_spotlight = util::spawn_model("tag_origin", self.vh_target.origin);
  self.vh_target.e_spotlight enablelinkto();
  self.vh_target.e_spotlight linkto(self.vh_target, "tag_origin", (0, 0, 390), (90, 0, 0));
  self waittill(#"rotatedone");
  level.var_ab11c23d clientfield::set("lighthouse_on", 3);
  self.vh_target.e_spotlight clientfield::set("" + #"trials_lighthouse_beam", 2);
  self.vh_target thread zm_orange_lighthouse::function_18f63949();
  self zm_orange_lighthouse::function_2b2f2a7f();
  wait 1;
  self.vh_target thread function_b502c51(self.var_da138ae4);
}

private function_b502c51(nd_start) {
  self endon(#"death", #"hash_2b53ed06a97eb26c");

  while(true) {
    self thread vehicle::get_on_and_go_path(nd_start);
    self setspeed(4);
    self.b_moving = 1;
    self waittill(#"reached_end_node");
  }
}

function_f223e16f(round_reset) {
  self endon(#"death");
  self.vh_target.b_moving = 0;
  wait 2;
  self.vh_target clientfield::set("" + #"hash_19bce46b8ab82440", 0);
  self.vh_target.e_spotlight delete();
  self.vh_target delete();

  if(round_reset !== 1) {
    level thread zm_orange_lighthouse::function_ad646ef8(1);

    switch (level.var_98138d6b) {
      case 2:
        level thread zm_orange_pap::function_56db9cdc();
        break;
      case 3:
        level thread zm_orange_pap::function_56db9cdc();
        break;
    }
  }
}

private function_1e902f3b() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  var_407eb07 = 0;

  while(true) {
    var_f2b6fe6e = 0;
    n_distance = distancesquared(level.var_ab11c23d.vh_target.origin, self.origin);

    if(n_distance < 30000) {
      var_f2b6fe6e = 1;
    }

    if(var_f2b6fe6e && var_407eb07) {
      self zm_trial_util::function_dc0859e();
      var_407eb07 = 0;
    } else if(!var_f2b6fe6e && !var_407eb07) {
      self zm_trial_util::function_bf710271();
      var_407eb07 = 1;
    }

    waitframe(1);
  }
}

function_91f0d131() {
  n_distance = distancesquared(level.var_ab11c23d.vh_target.origin, self.origin);

  if(n_distance < 30000) {
    return 1;
  }

  return 0;
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    var_f2b6fe6e = 0;

    if(self.b_in_water === 1) {
      var_f2b6fe6e = 1;
      return;
    }

    if(!var_f2b6fe6e && !zm_loadout::function_2ff6913(s_event.weapon)) {
      self lockweapon(s_event.weapon, 1, 1);
    }
  }
}