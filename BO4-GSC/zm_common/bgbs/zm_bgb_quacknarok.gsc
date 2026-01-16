/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_quacknarok.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_quacknarok;

autoexec __init__system__() {
  system::register(#"zm_bgb_quacknarok", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_quacknarok", "time", 300, &activation, &deactivation);
  bgb::register_actor_death_override(#"zm_bgb_quacknarok", &actor_death_override);
  level.var_5bf2be84 = gettime();
  callback::on_ai_spawned(&on_ai_spawned);
}

activation() {
  self endon(#"disconnect");
}

deactivation() {}

on_ai_spawned() {
  if(self.archetype === #"zombie") {
    var_85574d7a = 0;

    foreach(player in getplayers()) {
      if(player bgb::is_enabled(#"zm_bgb_quacknarok")) {
        var_85574d7a = 1;
      }
    }

    if(var_85574d7a) {
      self attach("p8_zm_red_floatie_duck", "j_spinelower", 1);
      self.bgb_quacknarok = 1;
    }
  }
}

actor_death_override(s_data) {
  if(isDefined(self) && isDefined(self.bgb_quacknarok) && self.bgb_quacknarok) {
    if(gettime() >= level.var_5bf2be84 && randomint(100) < 40) {
      duckie = util::spawn_model("p8_zm_red_floatie_duck", self gettagorigin("j_spinelower"), self gettagangles("j_spinelower"));

      if(isDefined(duckie)) {
        self detach("p8_zm_red_floatie_duck", "j_spinelower");
        level.var_5bf2be84 = gettime() + randomintrange(2000, 5000);
        duckie physicslaunch(self.origin, (0, 0, 64));
        duckie thread function_645efd58();
      }
    }
  }
}

function_645efd58() {
  wait randomintrange(15, 25);

  if(isDefined(self)) {
    self delete();
  }
}