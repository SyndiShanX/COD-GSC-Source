/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_idle.gsc
*****************************************************/

create_animation_list() {
  var_0 = [];
  var_0[var_0.size] = "phone";
  var_0[var_0.size] = "smoke";
  var_0[var_0.size] = "lean_smoke";
  var_0[var_0.size] = "coffee";
  var_0[var_0.size] = "sleep";
  var_0[var_0.size] = "sit_load_ak";
  var_0[var_0.size] = "smoke_balcony";

  if(isDefined(level.idle_animation_list_func)) {
    var_0 = [[level.idle_animation_list_func]](var_0);
  }

  return var_0;
}

idle_main() {
  level.global_callbacks["_idle_call_idle_func"] = ::idle;
}

idle() {
  waittillframeend;

  if(!isalive(self)) {
    return;
  }
  var_0 = undefined;

  if(!isDefined(self.target)) {
    var_0 = self;
  } else {
    var_0 = getnode(self.target, "targetname");
    var_1 = getent(self.target, "targetname");
    var_2 = common_scripts\utility::getstruct(self.target, "targetname");
    var_3 = undefined;

    if(isDefined(var_0)) {
      var_3 = ::get_node;
    } else if(isDefined(var_1)) {
      var_3 = ::get_ent;
    } else if(isDefined(var_2)) {
      var_3 = common_scripts\utility::getstruct;
    }

    for(var_0 = [
        [var_3]
      ](self.target, "targetname"); isDefined(var_0.target); var_0 = [
        [var_3]
      ](var_0.target, "targetname")) {}
  }

  var_4 = var_0.script_animation;

  if(!isDefined(var_4)) {
    var_4 = "random";
  }

  if(!check_animation(var_4, var_0)) {
    return;
  }
  if(var_4 == "random") {
    var_4 = create_random_animation();
    var_0.script_animation = var_4;
  }

  var_5 = var_4 + "_idle";
  var_6 = var_4 + "_react";
  var_7 = var_4 + "_death";
  thread idle_proc(var_0, var_5, var_6, var_7);
}

idle_reach_node(var_0, var_1) {
  self endon("death");
  self endon("stop_idle_proc");

  if(isDefined(self._stealth)) {
    level maps\_utility::add_wait(common_scripts\utility::flag_wait, maps\_stealth_utility::stealth_get_group_spotted_flag());

    if(isDefined(self._stealth.plugins.corpse)) {
      level maps\_utility::add_wait(common_scripts\utility::flag_wait, maps\_stealth_utility::stealth_get_group_corpse_flag());
      maps\_utility::add_wait(maps\_utility::ent_flag_wait, "_stealth_saw_corpse");
    }
  } else
    maps\_utility::add_wait(maps\_utility::waittill_msg, "enemy");

  maps\_utility::add_func(maps\_utility::send_notify, "stop_idle_proc");
  thread maps\_utility::do_wait_any();

  if(isDefined(self.script_patroller)) {
    self waittill("_patrol_reached_path_end");
  } else {
    var_0 maps\_anim::anim_generic_reach(self, var_1);
  }
}

idle_proc(var_0, var_1, var_2, var_3) {
  self.allowdeath = 1;
  self endon("death");

  if(isDefined(self.script_idlereach)) {
    self endon("stop_idle_proc");
    idle_reach_node(var_0, var_1);
  }

  if(isDefined(self.script_idlereach)) {
    self.script_animation = var_0.script_animation;
    var_0 = self;
  }

  if(var_0.script_animation == "sit_load_ak") {
    var_4 = maps\_utility::spawn_anim_model("chair_ak");
    self.has_delta = 1;
    self.anim_props = maps\_utility::make_array(var_4);
    var_0 thread maps\_anim::anim_first_frame_solo(var_4, "sit_load_ak_react");
  }

  if(var_0.script_animation == "lean_smoke" || var_0.script_animation == "smoke_balcony") {
    thread maps\_props::attach_cig_self();
  }

  if(var_0.script_animation == "smoke_balcony") {
    thread special_death_proc(var_0, var_3);
  }

  if(var_0.script_animation == "sleep") {
    var_4 = maps\_utility::spawn_anim_model("chair");
    self.has_delta = 1;
    self.anim_props = maps\_utility::make_array(var_4);
    var_0 thread maps\_anim::anim_first_frame_solo(var_4, "sleep_react");
    thread reaction_sleep();
  }

  if(isDefined(level.idle_proc_func)) {
    self[[level.idle_proc_func]](var_0, var_1, var_2, var_3);
  }

  var_0 maps\_utility::script_delay();
  self.deathanim = level.scr_anim["generic"][var_3];

  if(isDefined(self._stealth)) {
    var_5 = undefined;

    if(var_0.script_animation == "smoke_balcony") {
      var_5 = 1;
    }

    var_0 maps\_stealth_utility::stealth_ai_idle_and_react(self, var_1, var_2, undefined, var_5);
    var_0 common_scripts\utility::waittill_either("stop_loop", "stop_idle_proc");
    maps\_utility::clear_deathanim();
    return;
  }

  var_6 = "stop_loop";
  var_0 thread maps\_anim::anim_generic_loop(self, var_1, var_6);
  thread animate_props_on_death(var_0, var_2);
  thread reaction_proc(var_0, var_6, var_2);
}

reaction_sleep() {
  self endon("death");
  self.ignoreall = 1;
  reaction_sleep_wait_wakeup();
  self.ignoreall = 0;
}

reaction_sleep_wait_wakeup() {
  self endon("death");

  if(isDefined(self._stealth)) {
    thread maps\_stealth_utility::stealth_enemy_endon_alert();
    self endon("stealth_enemy_endon_alert");
  }

  var_0 = 70;
  common_scripts\utility::array_thread(level.players, ::reaction_sleep_wait_wakeup_dist, self, var_0);
  self waittill("_idle_reaction");
}

reaction_sleep_wait_wakeup_dist(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("_idle_reaction");
  self endon("death");
  var_0 endon("enemy");
  var_2 = var_1 * var_1;

  for(;;) {
    while(distancesquared(self.origin, var_0.origin) > var_2) {
      wait 0.1;
    }

    var_0.ignoreall = 0;

    while(distancesquared(self.origin, var_0.origin) <= var_2) {
      wait 0.1;
    }

    var_0.ignoreall = 1;
  }
}

reaction_proc(var_0, var_1, var_2, var_3) {
  self endon("death");
  thread reaction_wait("enemy");
  thread reaction_wait("stop_idle_proc");
  thread reaction_wait("react");
  thread reaction_wait("doFlashBanged");
  thread reaction_wait("explode");
  var_4 = undefined;
  self waittill("_idle_reaction", var_4);
  maps\_utility::clear_deathanim();
  var_0 notify(var_1);

  if(isDefined(self.anim_props)) {
    self.anim_props_animated = 1;
    var_0 thread maps\_anim::anim_single(self.anim_props, var_2);
  }

  if(var_4 == "stop_idle_proc") {
    maps\_utility::anim_stopanimscripted();
    return;
  }

  if(var_4 != "doFlashBanged") {
    if(isDefined(var_3) || isDefined(self.has_delta)) {
      var_0 maps\_anim::anim_generic(self, var_2, var_3);
    } else {
      var_0 maps\_anim::anim_generic_custom_animmode(self, "gravity", var_2);
    }
  }
}

reaction_wait(var_0) {
  self waittill(var_0);
  self notify("_idle_reaction", var_0);
}

special_death_proc(var_0, var_1) {
  thread maps\_utility::deletable_magic_bullet_shield();
  thread clear_bulletshield_on_alert(var_0);
  self waittill("damage");

  if(isDefined(self.deathanim)) {
    if(isDefined(self._stealth)) {
      maps\_stealth_utility::disable_stealth_for_ai();
    }

    var_0 maps\_anim::anim_generic(self, var_1);
    self delete();
  }
}

clear_bulletshield_on_alert(var_0) {
  self endon("death");

  if(!isDefined(self._stealth)) {
    self waittill("_idle_reaction");
  } else {
    var_0 common_scripts\utility::waittill_either("stop_loop", "stop_idle_proc");
  }

  maps\_utility::clear_deathanim();

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    maps\_utility::stop_magic_bullet_shield();
  }
}

animate_props_on_death(var_0, var_1) {
  if(!isDefined(self.anim_props)) {
    return;
  }
  var_2 = self.anim_props;
  self waittill("death");

  if(isDefined(self.anim_props_animated)) {
    return;
  }
  var_0 thread maps\_anim::anim_single(var_2, var_1);
}

create_random_animation() {
  var_0 = create_animation_list();
  return var_0[randomint(2)];
}

check_animation(var_0, var_1) {
  var_2 = create_animation_list();

  if(var_0 == "random") {
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      if(!isDefined(level.scr_anim["generic"][var_2[var_4] + "_react"])) {
        var_3[var_3.size] = var_2[var_4];
      }
    }

    if(!var_3.size) {
      return 1;
    }

    for(var_4 = 0; var_4 < var_3.size; var_4++) {}

    return 0;
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_2[var_4] == var_0) {
      if(!isDefined(level.scr_anim["generic"][var_0 + "_react"])) {
        return 0;
      }

      return 1;
    }
  }

  var_5 = "";

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_5 + var_2[var_4] + ", ";
  }

  var_5 = var_5 + "and random.";
  return 0;
}

get_ent(var_0, var_1) {
  return getent(var_0, var_1);
}

get_node(var_0, var_1) {
  return getnode(var_0, var_1);
}