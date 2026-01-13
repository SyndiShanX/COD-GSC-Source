/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3625.gsc
************************/

func_87ED(var_0) {
  level.player.var_885C = 1;
}

func_87E2(var_0) {
  level.player.var_8855 = var_0;
}

func_878C() {
  level.player.var_8855 = undefined;
}

func_87CB(var_0, var_1) {
  if(var_0) {
    level.player.var_8856 = var_1;
    return;
  }

  level.player.var_8856 = undefined;
}

func_87E0(var_0) {
  level.player notify("hack_reset_timeout");
  thread func_5C97(var_0);
}

func_8781(var_0) {
  level.player.var_8803 = !var_0;
}

func_87A1() {
  level.player notify("drone_timeout");
}

func_87F3() {
  level.player waittill("player_is_hacked_robot", var_0, var_1);
  if(isDefined(var_1)) {
    return var_1;
  }

  return var_0;
}

func_8795(var_0, var_1) {
  if(!isDefined(level.var_8850)) {
    level.var_8850 = [];
  }

  var_0.var_1B07 = var_1;
  level.var_8850 = scripts\engine\utility::array_add(level.var_8850, var_0);
}

func_87D1(var_0) {
  level.var_8850 = scripts\engine\utility::array_remove(level.var_8850, var_0);
}

func_87BC(var_0) {
  if(!isDefined(level.var_8850)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.var_8850, var_0);
}

func_87C9(var_0, var_1) {
  var_0.var_884B = var_1;
}

func_8780(var_0) {
  if(var_0 == 1) {
    level.player.var_87F9 = var_0;
    return;
  }

  level.player.var_87F9 = undefined;
}

func_8782(var_0) {
  if(var_0 == 1) {
    level.player.var_87FA = var_0;
    return;
  }

  level.player.var_87FA = undefined;
}

func_87A7() {
  if(!isDefined(level.player.var_883D)) {
    return "none";
  }

  return level.player.var_883D;
}

func_87BA() {
  return func_87A7() != "none";
}

func_877F(var_0) {
  if(isarray(var_0)) {
    level.player.var_8839 = scripts\engine\utility::array_combine(level.player.var_8839, var_0);
    foreach(var_2 in var_0) {
      var_2 notify("hack_added_to_blacklist");
    }

    return;
  }

  level.player.var_8839 = scripts\engine\utility::array_add(level.player.var_8839, var_0);
  var_0 notify("hack_added_to_blacklist");
}

func_87D0(var_0) {
  if(isarray(var_0)) {
    level.player.var_8839 = scripts\engine\utility::array_remove_array(level.player.var_8839, var_0);
    return;
  }

  level.player.var_8839 = scripts\engine\utility::array_remove(level.player.var_8839, var_0);
}

func_87E1(var_0, var_1, var_2) {
  level.player.var_C391 = var_0;
  level.player.og_angles = var_1;
  if(isDefined(var_2)) {
    level.player.var_C396 = var_2;
  }
}

func_87CC(var_0, var_1) {
  if(var_0) {
    level.player.var_884D = var_1;
    return;
  }

  level.player.var_884D = undefined;
}

func_87CD(var_0, var_1) {
  if(var_0) {
    level.player.var_884E = var_1;
    return;
  }

  level.player.var_884E = undefined;
}

func_8799(var_0) {
  if(var_0) {
    level.player.var_8803 = 1;
    if(func_87A7() == "controllingrobot") {
      setomnvar("ui_hack_control_selfdestruct", 0);
      return;
    }

    return;
  }

  level.player.var_8803 = undefined;
  if(func_87A7() == "controllingrobot") {
    setomnvar("ui_hack_control_selfdestruct", 1);
  }
}

func_87A0(var_0, var_1) {
  if(isDefined(var_0)) {
    level.player.var_8859 = var_0;
  }

  if(isDefined(var_1)) {
    level.player.var_8858 = var_1;
  }
}

func_878D() {
  level.player.var_8859 = undefined;
  level.player.var_8858 = undefined;
}

func_87CA(var_0, var_1) {
  if(var_0) {
    level.player.var_884C = var_1;
    return;
  }

  level.player.var_884C = undefined;
}

func_879F(var_0) {
  if(var_0) {
    level.player.var_8849 = 1;
    return;
  }

  level.player.var_8849 = undefined;
}

hack_blacklist_all_robots(var_0) {
  if(var_0) {
    level.player.hackallrobotsblacklisted = 1;
    return;
  }

  level.player.hackallrobotsblacklisted = 0;
}

hack_enable_enemy_melee(var_0) {
  if(var_0) {
    level.player.hackenableenemymelee = 1;
    return;
  }

  level.player.hackenableenemymelee = undefined;
}

func_8829() {
  precacheitem("hackingdevice");
  precachesuit("hacked_c6");
  precacheitem("offhandshield_c8");
  precachesuit("hacked_c8");
  precacheitem("iw7_c6hack_melee");
  precacheitem("iw7_c6worker_fists");
  precacheshader("ac130_hud_friendly_vehicle_diamond_s_w");
  precacheshader("cb_remotemissile_target_hostile");
  precacheshader("hack_tool_reticule_lock1");
  precacheshader("hack_tool_reticule_lock2");
  precacheshader("hack_tool_reticule_lock3");
  precacheshader("hack_tool_reticule_lock4");
  precacheshader("hack_tool_reticule_lock5");
  precacheshader("hack_tool_reticule_lock6");
  precacheshader("hack_tool_reticule_lock7");
  precacheshader("hack_tool_reticule_lock8");
  precacheshader("hack_tool_reticule_lock9");
  precacheshader("hack_tool_reticule_nolock");
  precacheshader("visor_opaque_l");
  precacheshader("visor_opaque_r");
  precacheshader("visor_opaque_border");
  precacheshader("hack_tool_pip_frame");
  precacheshader("robot_control_dot_overlay");
  precacheshader("apache_zoom_overlay");
  level._effect["drone_suicide"] = loadfx("vfx\iw7\core\expl\weap\hydra_grenade\vfx_exp_gre_hydra_aerial.vfx");
  precacheshader("reticle_center_shard_ball");
  precacheshader("apache_target_lock");
  level.player scripts\sp\utility::func_65E0("is_controlling_robot");
  level.player scripts\sp\utility::func_65E0("is_hacked_robot");
  level.player scripts\sp\utility::func_65E0("hack_reticle_disabled");
  level.player scripts\sp\utility::func_65E0("hack_control_outro_done");
  level.player scripts\sp\utility::func_65E0("hack_raise_autohold_period");
  setomnvar("ui_hack_control_overlay", 0);
  setomnvar("ui_hack_targeting", 0);
  setomnvar("ui_hack_control_signal_failing", 0);
  setomnvar("ui_hack_control_selfdestruct", 0);
  setomnvar("ui_hack_control_selfdestruct_timer", 0);
  setomnvar("ui_hack_control_selfdestruct_show_timer", 0);
  level._effect["robot_explosion"] = loadfx("vfx\iw7\_requests\europa\vfx_beam_rifle_robot_explode.vfx");
  func_1EE6();
  func_5C25();
  scripts\engine\utility::flag_init("hack_device_target_locked");
  scripts\engine\utility::flag_init("hack_device_target_delay");
  scripts\engine\utility::flag_init("hack_hud_control_intro_black");
  scripts\engine\utility::flag_init("hack_hud_control_intro_finished");
  scripts\engine\utility::flag_init("hack_hud_control_outro_black");
  scripts\engine\utility::flag_init("hack_hud_control_outro_finished");
  level.player.var_8839 = [];
  scripts\sp\utility::func_9187("hackTarget", 100, ::func_919C);
  scripts\sp\utility::func_9187("hackControl", 101, ::func_91A4);
  level.player.var_883D = "none";
  if(!is_console()) {
    level.player scripts\sp\utility::func_65E0("hack_toggled_off");
    level.player scripts\sp\utility::func_65E0("hack_toggle_fired");
    level.player notifyonplayercommand("hack_fire", "+attack");
    level.player notifyonplayercommand("hack_weap_switch", "+weapnext");
  }
}

func_1EE6() {
  func_8784();
  func_E578();
  func_D304();
}

func_5C25() {
  createthreatbiasgroup("hacked_drone");
  createthreatbiasgroup("op_for");
  setignoremegroup("hacked_drone", "op_for");
  level.player.var_9BFA = 0;
  level.var_6AFC = getent("fake_player_spawn", "targetname");
  if(isDefined(level.var_6AFC)) {
    level.var_6AFC.dontdeletemehacking = 1;
  }
}

func_87F0() {
  self endon("death");
  self endon("stop_hack_unequipped_think");
  self notify("hack_unequipped_think");
  self endon("hack_unequipped_think");
  self waittill("secondary_equipment_change");
  self notify("hack_unequipped");
}

func_879A() {
  self endon("death");
  self endon("hack_unequipped");
  self endon("stop_hack_disabled_think");
  self notify("hack_disabled_think");
  self endon("hack_disabled_think");
  for(;;) {
    if(!func_381E()) {
      break;
    }

    wait(0.05);
  }

  self notify("hack_disabled");
}

func_8836() {
  self endon("death");
  self endon("hack_unequipped");
  self.var_9E1C = 0;
  thread func_87F0();
  var_0 = 1;
  var_1 = 0;
  for(;;) {
    if(is_mouse_and_keyboard() || !func_9BF9()) {
      self waittill("secondary_equipment_pressed");
    }

    self.var_9E1D = 0;
    self.var_8816 = 0;
    self.var_2A94 = undefined;
    if(!func_381E()) {
      wait(0.05);
      continue;
    }

    var_2 = self getrunningforwardpainanim("hackingdevice");
    if(var_2 <= 0) {
      wait(0.05);
      continue;
    }

    var_3 = self playgestureviewmodel("ges_hack_loop", undefined, 1, 0.2);
    if(!var_3) {
      wait(0.05);
      continue;
    }

    thread func_879A();
    if(!is_console()) {
      level.player scripts\sp\utility::func_65DD("hack_toggled_off");
      level.player scripts\sp\utility::func_65DD("hack_toggle_fired");
      thread hack_toggled_off_think();
    }

    level.player.var_883D = "scanning";
    level.player.var_883A = 1;
    self.var_9E1C = 1;
    level notify("pause_jackal_streak_message");
    scripts\engine\utility::flag_set("secondary_equipment_in_use");
    level.player scripts\sp\utility::func_1C49(0);
    level.player scripts\sp\utility::func_65DD("hack_control_outro_done");
    level.player scripts\sp\utility::func_65E1("hack_raise_autohold_period");
    level.player scripts\engine\utility::delaythread(0.4, ::scripts\sp\utility::func_65DD, "hack_raise_autohold_period");
    scripts\engine\utility::allow_reload(0);
    scripts\engine\utility::allow_ads(0);
    scripts\engine\utility::allow_fire(0);
    scripts\engine\utility::allow_offhand_primary_weapons(0);
    scripts\sp\utility::func_1C34(0);
    scripts\engine\utility::allow_weapon_switch(0);
    scripts\engine\utility::allow_autoreload(0);
    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_melee(0);
    thread func_8825();
    wait(0.3);
    level.player thread scripts\anim\battlechatter_ai::func_67CF("hackingdevice");
    if((!is_mouse_and_keyboard() && func_9BF9() && func_381E()) || is_mouse_and_keyboard() && !is_hack_toggled_off() && func_381E()) {
      scripts\engine\utility::flag_clear("hack_device_target_locked");
      func_882C();
      scripts\sp\utility::func_65DD("hack_reticle_disabled");
      thread func_5C8A();
      thread func_11AA1();
      while((!is_mouse_and_keyboard() && func_9BF9()) || is_mouse_and_keyboard() && !is_hack_toggled_off()) {
        func_8830();
        if(isDefined(self.var_AEFA)) {
          self forceplaygestureviewmodel("ges_hack_lock_in", undefined, 0.01, 0, 1, 1);
          wait(0.05);
          var_4 = func_882A();
          if(isDefined(var_4) && var_4 == "hack") {
            level.player notify("stop_hack_disabled_think");
            level.player notify("stop_hack_unequipped_think");
            level.player.var_883D = "transitiontorobot";
            level.player.var_883A = 1;
            thread player_lookat_ent_wrapper(self.var_AEFA, 0.65);
            self _meth_80A6();
            self notify("hack_control_target");
            level.player scripts\sp\utility::func_2B76(0, 0.5);
            self forceplaygestureviewmodel("ges_hack_lock_fire", undefined, 0.2, 0, 1, 1);
            thread func_E592(self.var_AEFA);
            wait(1);
            self notify("hack_intro_done");
            self getradiuspathsighttestnodes();
            level.var_D365 = scripts\sp\utility::func_10639("player_arms");
            var_5 = level.player _meth_84C6("currentViewModel");
            if(isDefined(var_5)) {
              level.var_D365 setModel(var_5);
            }

            level.var_D365 _meth_81E2(self, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
            level.var_D365 hide();
            level.player scripts\sp\utility::func_65E3("hack_control_outro_done");
            break;
          }

          self forceplaygestureviewmodel("ges_hack_lock_out", undefined, 0.01, 0, 1, 1);
          continue;
        }

        break;
      }
    }

    self notify("hackingdevice_end");
  }
}

func_8825() {
  self endon("death");
  self endon("stop_hacking_end_think");
  scripts\engine\utility::waittill_any_3("hack_unequipped", "hackingdevice_end", "hack_disabled");
  hacking_end();
}

hacking_end() {
  var_0 = func_87A7();
  if(var_0 == "scanning" || var_0 == "locking" || var_0 == "locked") {
    self forceplaygestureviewmodel("ges_hack_loop_end", undefined, 0.2, 0, 1, 1);
    scripts\engine\utility::delaythread(0.15, ::func_8823);
  } else if(var_0 == "transitiontorobot") {}

  self notify("hack_device_closing");
  scripts\engine\utility::flag_clear("secondary_equipment_in_use");
  level.player scripts\sp\utility::func_1C49(1);
  if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
    level.player.dontmelee = undefined;
  }

  self.var_9E1C = 0;
  setomnvar("ui_hack_target_entity", undefined);
  level notify("unpause_jackal_streak_message");
  self notify("hack_device_closed");
  self _meth_80A6();
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_reload, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_ads, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_offhand_primary_weapons, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_fire, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_usability, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_melee, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\sp\utility::func_1C34, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_weapon_switch, 1);
  scripts\engine\utility::delaythread(0.75, ::scripts\engine\utility::allow_autoreload, 1);
  self.hackdoingoutro = 1;
  thread func_882D();
  if(isDefined(self.var_8824)) {
    self.var_8824 = undefined;
    wait(1);
    return;
  }

  wait(0.05);
}

func_882D() {
  level.player endon("death");
  wait(0.3);
  level.player.var_883D = "none";
  level.player.var_883A = undefined;
  level.player notify("stop_hack_disabled_think");
  level.player.hackdoingoutro = undefined;
}

func_381E() {
  if(!self _meth_843C() || self getteamsize()) {
    return 0;
  }

  if(!isDefined(level.player getcurrentprimaryweapon()) || level.player getcurrentprimaryweapon() == "none") {
    return 0;
  }

  if(!scripts\engine\utility::isoffhandweaponsallowed() || !scripts\engine\utility::isoffhandsecondaryweaponsallowed()) {
    return 0;
  }

  if(self isthrowinggrenade()) {
    return 0;
  }

  if(scripts\sp\utility::func_D123()) {
    return 0;
  }

  if(isDefined(level.player.hackdoingoutro) && level.player.hackdoingoutro) {
    return 0;
  }

  if(scripts\sp\utility::func_93A6() && scripts\engine\utility::istrue(level.var_10964.var_D430)) {
    return 0;
  }

  return 1;
}

func_1D5E(var_0, var_1) {
  level endon("StopRotatingPlayer");
  level thread scripts\sp\utility::func_C12D("StopRotatingPlayer", var_1);
  for(;;) {
    var_2 = vectortoangles(var_0.origin - (0, 0, 30) - level.player.origin);
    level.player setplayerangles(var_2);
    wait(0.05);
  }
}

func_5C8A() {
  self endon("hack_device_closing");
  self endon("hack_control_target");
  self endon("death");
  for(;;) {
    self waittill("damage");
    setomnvar("ui_hack_targeting_damage", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_targeting_damage", 0);
    level.player scripts\sp\utility::func_65E1("hack_reticle_disabled");
    wait(0.4);
    level.player scripts\sp\utility::func_65DD("hack_reticle_disabled");
  }
}

func_882C() {
  self.var_883E = 1;
  thread func_87E4();
  scripts\sp\utility::func_2B76(0.75, 0.2);
  self playSound("hack_open_targeting_hud_lr");
  level.player _meth_82C2("hacking_targeting_hud", "mix", "filter", "ambient");
  scripts\sp\utility::func_9199("hackTarget", 1);
  setomnvar("ui_wrist_pc", 5);
}

func_8823() {
  if(isDefined(self.var_883E)) {
    func_87B3();
    self.var_883E = undefined;
  }

  scripts\sp\utility::func_2B76(1, 0.2);
  thread scripts\sp\utility::play_sound_on_entity("hack_close_targeting_hud_lr");
  level.player clearclienttriggeraudiozone(0.2);
  scripts\sp\utility::func_9199("hackTarget", 0);
  setomnvar("ui_wrist_pc", 1);
}

func_B2B5() {
  self.var_5923 = undefined;
}

func_882A() {
  self endon("hack_unequipped");
  self endon("hack_disabled");
  if(isDefined(self.var_AEFA)) {
    self.var_AEFA func_8827(1);
  }

  if(!is_console()) {
    level.player scripts\sp\utility::func_65DD("hack_toggle_fired");
    thread hacking_locked_fire_think();
  }

  for(;;) {
    if(!isDefined(self.var_AEFA) || !func_9CAA(self.var_AEFA) || !func_3DD2(self.var_AEFA) || is_mouse_and_keyboard() && is_hack_toggled_off()) {
      scripts\engine\utility::flag_clear("hack_device_target_locked");
      func_11050(self.var_AEFA);
      self.var_4B20 = undefined;
      self.var_AEFA = undefined;
      level.player.var_883D = "scanning";
      if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
        level.player.dontmelee = undefined;
      }

      self getrawbaseweaponname(0.4, 0.45);
      self notify("hack_lost_target");
      if(!is_console()) {
        self notify("hack_locked_hold_done");
      }

      return "lost_target";
    }

    if((!is_mouse_and_keyboard() && !func_9BF9()) || is_mouse_and_keyboard() && level.player scripts\sp\utility::func_65DB("hack_toggle_fired")) {
      if(!is_console()) {
        self notify("hack_locked_hold_done");
        level.player scripts\sp\utility::func_65E1("hack_toggled_off");
        level.player notify("hack_input_on_locked_robot");
      }

      return "hack";
    }

    wait(0.05);
  }
}

func_87E4() {
  self.var_8802 = [];
  scripts\engine\utility::flag_clear("hack_hud_control_intro_black");
  scripts\engine\utility::flag_clear("hack_hud_control_intro_finished");
  scripts\engine\utility::flag_clear("hack_hud_control_outro_black");
  scripts\engine\utility::flag_clear("hack_hud_control_outro_finished");
  level.player scripts\sp\utility::func_1C3E(0);
  setomnvar("ui_hack_targeting", 1);
  visionsetnaked("hack_targeting", 0);
  thread func_87B8();
  thread func_87B7();
}

func_87B7() {
  self endon("hack_device_closed");
  self waittill("death");
  func_87B3();
}

func_87B8() {
  self endon("death");
  self endon("hack_device_closed");
  self.var_8853 = newhudelem();
  self.var_8853.sort = 0;
  self.var_8853.x = 0;
  self.var_8853.y = 0;
  self.var_8853.hidewheninmenu = 1;
  self.var_8853.playrumblelooponposition = 1;
  self.var_8853.alignx = "center";
  self.var_8853.aligny = "middle";
  self.var_8853.horzalign = "center";
  self.var_8853.vertalign = "middle";
  self.var_8853.alpha = 1;
  self.var_8802 = scripts\engine\utility::array_add(self.var_8802, self.var_8853);
  self.var_8852 = newhudelem();
  self.var_8852.sort = 0;
  self.var_8852.x = 0;
  self.var_8852.y = 0;
  self.var_8852.hidewheninmenu = 1;
  self.var_8852.playrumblelooponposition = 1;
  self.var_8852.alignx = "center";
  self.var_8852.aligny = "middle";
  self.var_8852.horzalign = "center";
  self.var_8852.vertalign = "middle";
  self.var_8852.alpha = 0;
  self.var_8802 = scripts\engine\utility::array_add(self.var_8802, self.var_8852);
  setomnvar("ui_hack_targeting_status", "searching");
  var_0 = 1;
  for(;;) {
    var_1 = ["hack_acquired_target", "hack_lost_target", "hack_locked_target", "hack_control_target", "hack_done_control_target", "hack_acquired_non_hackable", "hack_acquired_need_upgrade", "hack_no_target", "hack_suicide", "hack_shutdown_sequence"];
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_1);
    if(var_2 == "hack_acquired_target") {
      setomnvar("ui_hack_targeting_status", "connecting");
      setomnvar("ui_hack_target_entity", self.var_4B20);
      var_3 = self.var_4B20 func_12A5();
      if(var_3 == "C8") {
        var_3 = 1;
      } else {
        var_3 = 2;
      }

      setomnvar("ui_hack_control_robot_type", var_3);
      continue;
    }

    if(var_2 == "hack_lost_target") {
      self notify("hack_hud_stop_tracking_target");
      self.var_8853.x = 0;
      self.var_8853.y = 0;
      self.var_8852.alpha = 0;
      setomnvar("ui_hack_targeting_status", "searching");
      setomnvar("ui_hack_target_entity", self.var_4B20);
      continue;
    }

    if(var_2 == "hack_locked_target") {
      setomnvar("ui_hack_targeting_status", "locked");
      continue;
    }

    if(var_2 == "hack_control_target") {
      func_87AF();
      continue;
    }

    if(var_2 == "hack_suicide") {
      func_87B2();
      continue;
    }

    if(var_2 == "hack_shutdown_sequence") {
      func_87B1();
      continue;
    }

    if(var_2 == "hack_done_control_target") {
      func_87B0();
      continue;
    }

    if(var_2 == "hack_acquired_non_hackable" && var_0) {
      setomnvar("ui_hack_targeting_status", "notcompatible");
      var_0 = 0;
      continue;
    }

    if(var_2 == "hack_acquired_need_upgrade" && var_0) {
      setomnvar("ui_hack_targeting_status", "needupgrade");
      var_0 = 0;
      continue;
    }

    if(var_2 == "hack_no_target" && !var_0) {
      setomnvar("ui_hack_targeting_status", "searching");
      var_0 = 1;
    }
  }
}

func_87AF() {
  if(isDefined(level.var_8826) && level.var_8826) {
    setomnvar("ui_hack_ethan_overlay", 1);
  } else {
    setomnvar("ui_hack_control_overlay", 1);
  }

  scripts\engine\utility::delaythread(0.35, ::func_87B6);
  thread scripts\sp\utility::func_C12D("hack_hud_stop_tracking_target", 0.35);
  if(isDefined(level.player.var_884D)) {
    scripts\engine\utility::noself_delaycall(0.6, ::visionsetnaked, level.player.var_884D, 0);
  } else if(level.player.var_8820 == "C6" || level.player.var_8820 == "C6Worker") {
    scripts\engine\utility::noself_delaycall(0.6, ::visionsetnaked, "hack_c6_control", 0);
  } else if(level.player.var_8820 == "C8") {
    scripts\engine\utility::noself_delaycall(0.6, ::visionsetnaked, "hack_c8_control", 0);
  }

  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_intro_black", 0.6);
  scripts\engine\utility::noself_delaycall(0.6, ::setomnvar, "ui_wrist_pc", 0);
  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_intro_finished", 1);
  scripts\engine\utility::delaycall(0.65, ::playsound, "hack_start_hud_lr");
  level.player scripts\engine\utility::delaycall(0.65, ::_meth_82C2, "hacking_hud_transition", "mix");
}

func_87B2() {
  setomnvar("ui_hack_control_signal_failing", 0);
  setomnvar("ui_hack_control_outro", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_control_outro", 0);
}

func_87B1() {
  setomnvar("ui_hack_control_signal_failing", 0);
  setomnvar("ui_hack_control_outro", 3);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_control_outro", 0);
}

func_87B0() {
  setomnvar("ui_hack_control_outro", 2);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_control_outro", 0);
  level.player notify("stop soundhacked_drone_dmg_alarm");
  scripts\engine\utility::noself_delaycall(0.1, ::visionsetnaked, "", 0);
  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_outro_black", 0.2);
  scripts\engine\utility::noself_delaycall(0, ::setomnvar, "ui_wrist_pc", 5);
  scripts\engine\utility::noself_delaycall(0, ::setomnvar, "ui_hack_targeting_status", "closing");
  scripts\engine\utility::noself_delaycall(1.5, ::setomnvar, "ui_wrist_pc", 1);
  scripts\engine\utility::noself_delaycall(1.5, ::setomnvar, "ui_hack_targeting_status", "searching");
  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_outro_finished", 0.7);
  scripts\engine\utility::delaycall(0, ::playsound, "hack_hud_outro_lr");
  level.player scripts\engine\utility::delaycall(0.01, ::_meth_82C2, "hacking_hud_transition", "ambient", "mix");
  level.player scripts\engine\utility::delaycall(0.7, ::clearclienttriggeraudiozone, 0.2);
  level.player scripts\engine\utility::delaythread(1.4, ::func_87B3);
}

func_87B4(var_0) {
  return func_87A8(var_0);
}

func_87B5(var_0) {
  return level.player _meth_840B(var_0 gettagorigin(func_87A8(var_0)), getdvarint("cg_fov"));
}

func_87B3() {
  if(isDefined(level.var_8826) && level.var_8826) {
    setomnvar("ui_hack_ethan_overlay", 0);
  } else {
    setomnvar("ui_hack_control_overlay", 0);
  }

  setomnvar("ui_hack_targeting", 0);
  setomnvar("ui_hack_control_signal_failing", 0);
  setomnvar("ui_hack_control_selfdestruct", 0);
  setomnvar("ui_hack_control_selfdestruct_timer", 0);
  setomnvar("ui_hack_control_selfdestruct_show_timer", 0);
  level.player scripts\sp\utility::func_1C3E(1);
  foreach(var_1 in self.var_8802) {
    if(isDefined(var_1.bar)) {
      var_1.bar destroy();
    }

    var_1 destroy();
  }

  visionsetnaked("", 0);
}

func_87B6() {
  setomnvar("ui_hack_targeting", 0);
  foreach(var_1 in self.var_8802) {
    if(isDefined(var_1.bar)) {
      var_1.bar.alpha = 0;
    }

    var_1.alpha = 0;
  }

  visionsetnaked("", 0);
}

func_9BF9() {
  if(level.player scripts\sp\utility::func_65DB("hack_raise_autohold_period")) {
    return 1;
  }

  if(scripts\engine\utility::flag("secondary_equipment_input_down")) {
    return 1;
  }

  level.player notify("hack_button_released");
  return 0;
}

is_hack_toggled_off() {
  if(is_console()) {
    return 0;
  }

  if(level.player scripts\sp\utility::func_65DB("hack_raise_autohold_period")) {
    return 0;
  }

  if(!level.player scripts\sp\utility::func_65DB("hack_toggled_off")) {
    return 0;
  }

  return 1;
}

func_13644() {
  scripts\engine\utility::flag_waitopen("secondary_equipment_input_down");
}

func_87A8(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0.classname != "script_model" && !isDefined(var_0.var_6554)) {
    return "j_SpineUpper";
  }

  return "tag_origin";
}

func_8830() {
  self endon("hack_unequipped");
  self endon("hack_disabled");
  self endon("hack_close_pressed");
  self endon("robot_hacked");
  self endon("hack_locked_target");
  self.var_A997 = undefined;
  self.var_4B20 = undefined;
  self.var_AEFA = undefined;
  self getrawbaseweaponname(0.4, 0.45);
  scripts\engine\utility::flag_set("hack_device_target_delay");
  thread scripts\sp\utility::func_6E2B("hack_device_target_delay", 0.4);
  while((!is_mouse_and_keyboard() && func_9BF9()) || is_mouse_and_keyboard() && !is_hack_toggled_off()) {
    if(!isDefined(self.var_4B20) && !scripts\engine\utility::flag("hack_device_target_delay")) {
      self.var_4B20 = func_2A91();
      if(isDefined(self.var_4B20)) {
        thread func_10D4E(self.var_4B20);
        level.player.var_883D = "locking";
        level.player.var_883A = 1;
        if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
          level.player.dontmelee = 1;
        }

        self notify("hack_acquired_target");
        self getrawbaseweaponname(0.2, 0.25);
      }

      continue;
    }

    if(!scripts\engine\utility::flag("hack_device_target_delay")) {
      if(!func_3DD2(self.var_4B20)) {
        scripts\engine\utility::flag_clear("hack_device_target_locked");
        func_11050(self.var_4B20);
        self.var_4B20 = undefined;
        self.var_AEFA = undefined;
        level.player.var_883D = "scanning";
        if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
          level.player.dontmelee = undefined;
        }

        self notify("hack_lost_target");
        self getrawbaseweaponname(0.4, 0.45);
      }
    }

    wait(0.05);
  }
}

func_11AA1() {
  self endon("hack_unequipped");
  self endon("hack_disabled");
  self endon("hack_button_released");
  if(!is_console()) {
    self endon("hack_toggled_off");
  } else {
    self endon("secondary_equipment_released");
  }

  self endon("hack_close_pressed");
  self endon("robot_hacked");
  thread func_11AA0();
  for(;;) {
    self.var_87F8 = [];
    self.var_C123 = [];
    var_0 = getaiarray("bad_guys");
    foreach(var_2 in var_0) {
      if(isDefined(var_2.subclass) && var_2.subclass != "C6" && var_2.subclass != "C8" && var_2.subclass != "C12") {
        continue;
      }

      if(!func_9CAA(var_2)) {
        self.var_C123[self.var_C123.size] = var_2;
        continue;
      }

      self.var_87F8[self.var_87F8.size] = var_2;
    }

    if(isDefined(level.var_8850)) {
      level.var_8850 = scripts\engine\utility::array_removeundefined(level.var_8850);
      self.var_87F8 = scripts\engine\utility::array_combine(self.var_87F8, level.var_8850);
    }

    foreach(var_5 in self.var_87F8) {
      var_6 = 0;
      if(isDefined(self.var_4B20) && var_5 == self.var_4B20) {
        var_6 = 1;
      }

      var_5 func_8827(var_6);
    }

    foreach(var_5 in self.var_C123) {
      var_5 scripts\sp\utility::func_9193("hackTarget");
    }

    wait(0.05);
  }
}

func_11AA0() {
  if(!is_console()) {
    var_0 = ["hack_unequipped", "hack_disabled", "hack_button_released", "hack_close_pressed", "robot_hacked", "hack_toggled_off"];
    scripts\engine\utility::waittill_any_in_array_return(var_0);
  } else {
    scripts\engine\utility::waittill_any_3("hack_unequipped", "hack_disabled", "hack_button_released", "secondary_equipment_released", "hack_close_pressed", "robot_hacked");
  }

  foreach(var_2 in self.var_87F8) {
    var_2 scripts\sp\utility::func_9193("hackTarget");
  }

  foreach(var_2 in self.var_C123) {
    var_2 scripts\sp\utility::func_9193("hackTarget");
  }

  self.var_87F8 = undefined;
  self.var_C123 = undefined;
}

func_9CAA(var_0) {
  if(!isDefined(level.player.var_885D)) {
    if(!func_87BC(var_0) && var_0.subclass == "C8" || var_0.subclass == "C12") {
      return 0;
    }
  } else if(!func_87BC(var_0) && var_0.subclass == "C12") {
    return 0;
  }

  if(!func_3DC7(var_0)) {
    return 0;
  }

  if(!func_3DC6(var_0)) {
    return 0;
  }

  if(isDefined(var_0.var_87F6) && !var_0.var_87F6) {
    return 0;
  }

  if(isDefined(var_0.asm) && isDefined(var_0.asm.bpowereddown) && var_0.asm.bpowereddown) {
    return 0;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "nohack") {
    return 0;
  }

  if(scripts\engine\utility::array_contains(level.player.var_8839, var_0)) {
    return 0;
  }

  if(isDefined(var_0.bpowerdown) && var_0.bpowerdown == 1) {
    return 0;
  }

  if(isDefined(var_0.var_8804)) {
    return 0;
  }

  if(!func_9CA9(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.player.hackallrobotsblacklisted)) {
    return 0;
  }

  return 1;
}

func_9CA9(var_0) {
  if(!isDefined(var_0.var_884B) && distancesquared(level.player.origin, var_0.origin) > squared(1500)) {
    return 0;
  } else if(isDefined(var_0.var_884B) && distancesquared(level.player.origin, var_0.origin) > squared(var_0.var_884B)) {
    return 0;
  }

  return 1;
}

func_2A91() {
  if(level.player scripts\sp\utility::func_65DB("hack_reticle_disabled")) {
    return undefined;
  }

  if(!isDefined(self.var_87F8) || !isDefined(self.var_C123)) {
    return undefined;
  }

  var_0 = scripts\engine\utility::array_combine(self.var_87F8, self.var_C123);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = [];
  foreach(var_6 in var_0) {
    if(isDefined(var_6.var_C124)) {
      continue;
    }

    if(isDefined(var_6) && check_robot_in_sights(var_6)) {
      var_4[var_4.size] = var_6;
    }
  }

  if(var_4.size > 0) {
    var_4 = sortbydistance(var_4, level.player.origin);
    foreach(var_6 in var_4) {
      if(scripts\engine\utility::array_contains(self.var_87F8, var_6)) {
        var_3 = var_6;
        break;
      }
    }

    if(!isDefined(var_3)) {
      foreach(var_6 in var_4) {
        if(scripts\common\trace::ray_trace_passed(var_6 gettagorigin(func_87A8(var_6)), level.player getEye(), var_6, scripts\common\trace::create_solid_ai_contents(1)) && func_9CA9(var_6)) {
          var_1 = 1;
          if(var_6 func_12A5() == "C8") {
            var_2 = 1;
          }

          break;
        }
      }
    }
  }

  if(!isDefined(var_3) && var_1 && var_2) {
    self notify("hack_acquired_need_upgrade");
  } else if(!isDefined(var_3) && var_1) {
    self notify("hack_acquired_non_hackable");
  } else if(!isDefined(var_3) && !var_1) {
    self notify("hack_no_target");
  }

  return var_3;
}

func_3DC7(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0) && var_0.classname != "script_model") {
    return 0;
  }

  return 1;
}

func_3DC6(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0.classname, "worker")) {
    return 1;
  }

  if(!isDefined(var_0.var_394) || var_0.var_394 == "" || var_0.var_394 == "none") {
    return 0;
  }

  return 1;
}

func_3DD2(var_0) {
  if(level.player scripts\sp\utility::func_65DB("hack_reticle_disabled")) {
    return 0;
  }

  if(scripts\engine\utility::array_contains(self.var_8839, var_0)) {
    return 0;
  }

  if(!func_9CAA(var_0)) {
    return 0;
  }

  return check_robot_in_sights(var_0, 1);
}

check_robot_in_sights(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = var_0 gettagorigin(func_87A8(var_0));
  var_3 = distancesquared(var_0.origin, level.player.origin);
  var_4 = 100;
  if(var_3 < squared(var_4)) {
    var_5 = 200;
    var_6 = 75;
    var_7 = 30;
    var_8 = var_4;
    var_9 = 1.1;
    var_0A = 1.25;
  } else {
    var_5 = 75;
    var_6 = 15;
    var_7 = var_8;
    var_8 = 500;
    var_9 = 1.25;
    var_0A = 3;
  }

  if(var_3 <= squared(var_7)) {
    var_0B = var_5;
    var_0C = var_9;
  } else if(var_5 >= squared(var_0A)) {
    var_0B = var_8;
    var_0C = var_0B;
  } else {
    var_0D = sqrt(var_5);
    var_0E = var_0D - var_7 / var_8 - var_7;
    var_0B = var_0E * var_6 - var_5 + var_5;
    var_0C = var_0E * var_0A - var_9 + var_9;
  }

  if(var_1) {
    var_0B = var_0B * var_0C;
  }

  return level.player worldpointinreticle_circle(var_2, 65, var_0B);
}

func_10D4E(var_0) {
  self endon("hack_unequipped");
  self endon("hack_disabled");
  self endon("hack_close_pressed");
  self endon("robot_hacked");
  self endon("hack_lost_target");
  if(!is_console()) {
    self endon("hack_toggled_off");
  } else {
    self endon("secondary_equipment_released");
  }

  self endon("hack_button_released");
  var_1 = func_129E(var_0) / 2;
  self playSound("hack_target_reticule");
  setomnvar("ui_hack_targeting_ping", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_targeting_ping", 0);
  wait(var_1);
  self playSound("hack_target_reticule");
  setomnvar("ui_hack_targeting_ping", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hack_targeting_ping", 0);
  wait(var_1);
  self playSound("hack_target_reticule_locked");
  scripts\engine\utility::flag_set("hack_device_target_locked");
  level.player.var_883D = "locked";
  level.player.var_883A = 1;
  if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
    level.player.dontmelee = 1;
  }

  self notify("hack_locked_target");
  self.var_AEFA = var_0;
}

func_129E(var_0) {
  var_1 = 0.8;
  if(isDefined(level.player.var_885E)) {
    var_1 = 0.5;
  }

  if(var_0 func_12A5() == "C8") {
    var_1 = 2;
  }

  return var_1;
}

func_11050(var_0) {
  self notify("hack_targeting_released");
}

func_8827(var_0) {
  var_1 = self;
  if(isDefined(self.var_6554)) {
    var_1 = self.var_5CBA;
  }

  if(var_0) {
    if(isDefined(level.player.var_AEFA) && level.player.var_AEFA == self) {
      var_1 scripts\sp\utility::func_9196(1, 0, 1, "hackTarget");
    } else {
      var_1 scripts\sp\utility::func_9196(4, 0, 1, "hackTarget");
    }
  } else if(isDefined(level.player.var_8846)) {
    var_1 scripts\sp\utility::func_9193("hackTarget");
  } else {
    var_1 scripts\sp\utility::func_9196(0, 0, 1, "hackTarget");
  }

  thread func_8828();
}

func_8828() {
  if(isDefined(self.var_87FC)) {
    return;
  }

  self.var_87FC = 1;
  level.player scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  level.player scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "hack_device_closing");
  level.player scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "hack_control_target");
  scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "player_controlled");
  scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "hack_added_to_blacklist");
  scripts\sp\utility::func_57D6();
  if(isDefined(self.var_6554)) {
    self.var_5CBA scripts\sp\utility::func_9193("hackTarget");
  } else if(isDefined(level.player.var_AEFA) && self == level.player.var_AEFA) {
    scripts\engine\utility::delaythread(1, ::scripts\sp\utility::func_9193, "hackTarget");
  } else {
    scripts\sp\utility::func_9193("hackTarget");
  }

  self.var_87FC = undefined;
}

func_E592(var_0) {
  self endon("death");
  self.var_8816 = 1;
  if(isDefined(var_0.var_1B07)) {
    func_87D1(var_0);
    level.player.var_8844 = var_0;
    var_0 = var_0.var_1B07;
  }

  var_0.var_8804 = 1;
  self.var_8816 = 1;
  level.var_880A = var_0;
  self.var_8820 = level.var_880A func_12A5();
  var_0.var_8804 = 1;
  var_0.var_BFED = 1;
  self waittill("hack_intro_done");
  self notify("robot_hacked", var_0);
  thread func_E57D(var_0);
}

func_4FBB() {
  var_0 = self getrunningforwardpainanim("hackingdevice");
  self setweaponammoclip("hackingdevice", var_0 - 1);
  self notify("offhand_fired");
}

func_12A5() {
  if(!isDefined(self.subclass) || self.subclass == "C6") {
    if(issubstr(self.classname, "worker")) {
      return "C6Worker";
    } else {
      return "C6";
    }
  } else if(self.subclass == "C8") {
    return "C8";
  } else if(issubstr(self.classname, "eth3n")) {
    return "C6";
  }

  return "unhackable";
}

func_E57D(var_0) {
  var_0 notify("player_controlled");
  if(func_3DC7(var_0) && func_3DC6(var_0)) {
    var_0 thread func_2A46(self.var_8820);
    return;
  }

  func_E588();
}

func_E588() {
  level notify("robot_died_during_intro");
  scripts\sp\utility::func_9199("hackTarget", 0);
  if(isDefined(level.player.var_883E)) {
    level.player.var_883E = undefined;
  }

  level.player scripts\sp\utility::func_65E1("is_hacked_robot");
  wait(0.05);
  scripts\engine\utility::flag_wait("hack_hud_control_intro_black");
  level.player notify("hack_done_control_target");
  level.player scripts\sp\utility::func_65DD("is_hacked_robot");
  level.player scripts\sp\utility::func_2B76(1, 0.5);
  level.player thread func_87F0();
  func_8793(1);
}

func_2A46(var_0) {
  level endon("robot_died_during_intro");
  if(isalive(level.player)) {
    scripts\engine\utility::flag_wait("hack_hud_control_intro_black");
    if(!func_3DC7(self) || !func_3DC6(self)) {
      level.player thread func_E588();
    }

    scripts\sp\utility::func_9199("hackTarget", 0);
    if(isDefined(level.player.var_883E)) {
      level.player.var_883E = undefined;
    }

    var_1 = "hackControl";
    if(isDefined(level.player.var_8858)) {
      var_1 = level.player.var_8858;
    }

    scripts\sp\utility::func_9199(var_1, 1);
    if(!func_3DC7(self) || !func_3DC6(self)) {
      level.player thread func_E588();
    }

    self notify("stop_loop");
    lib_0A1E::func_2386();
    waittillframeend;
    if(!func_3DC7(self) || !func_3DC6(self)) {
      level.player thread func_E588();
    }

    level.player func_4FBB();
    if(!isDefined(level.player.var_87F9) || level.player.var_87F9 == 0) {
      func_54FD();
      level.player.var_885B = 1;
    }

    if(isDefined(level.player.var_87FA) && level.player.var_87FA == 1) {
      level.player scripts\engine\utility::allow_usability(1);
      level.player.var_8860 = 1;
    }

    level.var_87FF = [];
    for(var_2 = 0; var_2 < 24; var_2++) {
      level.var_87FF[var_2] = 0;
    }

    level.player.var_9BFA = 1;
    level.player.var_9BA2 = 1;
    level.player give_zombies_perk("hacked_drone");
    level.player.var_C391 = level.player.origin;
    level.player.og_angles = level.player.angles;
    level.player.var_C396 = level.player getstance();
    level.player.var_C384 = level.player.health;
    level.player.og_maxhealth = level.player.maxhealth;
    level.player thread func_6AFD();
    level.player scripts\engine\utility::allow_sprint(0);
    level.player scripts\engine\utility::allow_melee(1);
    level.player scripts\engine\utility::allow_doublejump(0);
    level.player scripts\engine\utility::allow_wallrun(0);
    level.player scripts\engine\utility::allow_prone(0);
    level.player setstance("stand");
    level.player scripts\engine\utility::allow_crouch(0);
    level.player scripts\engine\utility::delaythread(0.5, ::scripts\engine\utility::allow_crouch, 1);
    level.player scripts\engine\utility::allow_autoreload(1);
    level.var_ECA4["autopickup"] = 0;
    level.player disableweaponpickup();
    level.player scripts\engine\utility::allow_ads(1);
    level.player scripts\engine\utility::allow_fire(1);
    level.player scripts\sp\utility::func_1C75(0);
    level.player _meth_8559(0);
    level.player getrankinfofull(1);
    level.player scripts\engine\utility::allow_weapon_switch(1);
    if(isDefined(level.player.var_28CF)) {
      level.var_884F = level.player.var_28CF;
    }

    scripts\sp\utility::func_CF8B();
    if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
      level.player.dontmelee = 1;
    }

    lib_0E4B::func_8DEA();
    level.player lib_0E42::giveperks(["specialty_fastreload"]);
    level.player _meth_84FE();
    level.player notify("stop_hacking_end_think");
    lib_0B2A::func_11429();
    level.player notify("hack_unequipped");
    var_3 = level.player scripts\sp\utility::func_7D74();
    level.player.var_C39E = [];
    level.player.var_C37C = level.player getcurrentweapon();
    for(var_2 = 0; var_2 < var_3.size; var_2++) {
      level.player.var_C39E[var_2] = spawnStruct();
      level.player.var_C39E[var_2].var_394 = var_3[var_2];
      level.player.var_C39E[var_2].var_1E40 = level.player getweaponammoclip(var_3[var_2]);
      level.player.var_C39E[var_2].var_1E4D = level.player getweaponammostock(var_3[var_2]);
      level.player takeweapon(var_3[var_2]);
    }

    level.player.var_C376 = level.player scripts\sp\utility::func_77C9();
    if(isDefined(level.player.var_C376) && level.player.var_C376 != "") {
      level.player scripts\sp\utility::func_11425();
    }

    if(level.var_880A islinked() && !isDefined(level.var_880A.var_2029)) {
      level.player.var_883C = scripts\engine\utility::spawn_script_origin();
      level.player.var_883C.origin = level.player.origin;
      level.player.var_883C.angles = level.player.angles;
      level.player playerlinktodelta(level.player.var_883C, undefined, 1, 0, 0, 0, 0, 1);
      if(isDefined(level.var_880A.var_87BD)) {
        var_4 = level.var_880A.var_87BD;
        level.player scripts\engine\utility::delaycall(0.25, ::playerlinktodelta, level.player.var_883C, undefined, 1, var_4, var_4, var_4, var_4, 1);
      }

      level.player.var_883C.origin = level.var_880A.origin;
      if(isDefined(level.var_880A.var_87CF)) {
        level.player.var_883C.origin = level.player.var_883C.origin + level.var_880A.var_87CF;
      }

      level.player.var_883C.angles = level.var_880A.angles;
      var_5 = level.var_880A getlinkedparent();
      level.player.var_883C linkto(var_5);
    } else {
      level.player setorigin(level.var_880A.origin);
      level.player setplayerangles(level.var_880A.angles);
    }

    level.player enableweapons();
    level.player.var_87FE = 1;
    level.var_880C = 100 / level.player.var_DF * 1.5;
    if(isDefined(level.player.var_8856)) {
      level.var_880C = level.player.var_8856;
    }

    if(var_0 == "flying") {
      level.player allowswim(1);
      level.player allowlean(0);
      level.player scripts\engine\utility::allow_crouch(0);
      level.player _meth_818A();
      level.var_880A thread func_E0E3();
    } else if(var_0 == "C6") {
      func_61E0(1);
      level.var_880A thread func_E0E3();
    } else if(var_0 == "C8") {
      func_61E2(1);
      level.var_880A thread func_E0E3();
    } else if(var_0 == "C6Worker") {
      func_61E1(1);
      level.var_880A thread func_E0E3();
    }

    level.player scripts\sp\utility::func_65E1("is_hacked_robot");
    if(isDefined(level.player.var_8844)) {
      level.player notify("player_is_hacked_robot", self, level.player.var_8844);
      level.player.var_8844 = undefined;
    } else {
      level.player notify("player_is_hacked_robot", self);
    }

    scripts\engine\utility::flag_wait("hack_hud_control_intro_finished");
    level.player thread func_11AA2();
    level.player thread func_5C2E(var_0);
    level.player thread func_880B(var_0);
    level.player.var_883D = "controllingrobot";
    level.player scripts\sp\utility::func_65E1("is_controlling_robot");
    var_6 = getaiarray("bad_guys");
    var_7 = getspawnerteamarray("bad_guys");
    foreach(var_9 in var_6) {
      var_9 thread func_19C8(1);
      var_9 thread func_1933();
      var_9.var_884A = var_9.objective_state;
      var_9 scripts\sp\utility::func_F3E6(0);
    }

    scripts\sp\utility::func_22C7(var_7, ::func_19C8, 1);
    scripts\sp\utility::func_22C7(var_7, ::func_1933);
    level.player thread func_5C97();
    if(isDefined(level.player.var_884C)) {
      level.player.var_87FE = level.player.var_884C;
    }

    level.player scripts\sp\utility::func_2B76(level.player.var_87FE, 0.5);
    level.player thread func_5C86(level.var_880A, var_0);
    var_0B = level.player scripts\engine\utility::waittill_any_return("drone_timeout", "hack_player_took_damage", "hack_drone_took_damage", "player_suicided_drone", "hack_drone_took_damage_trigger_hurt");
    level.player scripts\sp\utility::func_65DD("is_controlling_robot");
    level.player.var_883D = "selfdestruct";
    var_0C = 0;
    if(var_0 == "C8") {
      var_0C = 1;
    }

    if(var_0B == "hack_drone_took_damage_trigger_hurt") {
      thread func_5C3B(level.var_880A, var_0C);
    } else if(isDefined(level.player.var_8849) && level.player.var_8849) {
      thread func_5C77(level.var_880A);
    } else if(var_0B == "player_suicided_drone") {
      thread func_5C85(level.var_880A, 1, var_0C);
    } else {
      thread func_5C85(level.var_880A, 0, var_0C);
      level.player waittill("suicide_control_done");
    }

    level.player scripts\engine\utility::allow_ads(0);
    level.player scripts\engine\utility::allow_fire(0);
    level.player scripts\engine\utility::allow_weapon_switch(0);
    level.player scripts\engine\utility::allow_jump(0);
    level.player scripts\engine\utility::allow_mantle(0);
    level.player scripts\sp\utility::func_2B76(0, 0.5);
    level.player getrawbaseweaponname(0.03, 0.03);
    setomnvar("ui_hack_control_selfdestruct", 0);
    setomnvar("ui_hack_control_selfdestruct_timer", 0);
    setomnvar("ui_hack_control_selfdestruct_show_timer", 0);
    var_7 = getspawnerteamarray("bad_guys");
    scripts\engine\utility::array_thread(var_7, ::scripts\sp\utility::func_E08B, ::func_19C8);
    scripts\engine\utility::array_thread(var_7, ::scripts\sp\utility::func_E08B, ::func_1933);
    level.player thread func_2A47(var_0);
  }
}

func_61E0(var_0) {
  if(var_0) {
    level.player give_explosive_touch_on_revived("c6servo");
    level.player setsuit("hacked_c6");
    level.player.var_C37E = getdvar("cg_fov");
    setsaveddvar("cg_fov", 75);
    level.player _meth_81DE(75, 0.05);
    level.player scripts\engine\utility::allow_reload(1);
    level.player.health = self.health;
    level.player.var_C39C = level.player _meth_816D();
    if(level.player.var_C39C == "") {
      level.player.var_C39C = "viewmodel_base_viewhands_iw7";
    }

    level.player givegoproattachments("viewmodel_robot_c6");
    func_12C5();
    level.player scripts\engine\utility::delaythread(1.25, ::scripts\sp\utility::func_D090, "ges_c6raise");
    level.player.var_C389 = level.player scripts\sp\utility::func_7AD7();
    level.player scripts\sp\utility::_meth_82EA("iw7_c6hack_melee");
    level.player.var_87FE = 0.9;
    return;
  }

  var_1 = level.player getweaponslistprimaries();
  foreach(var_3 in var_1) {
    level.player takeweapon(var_3);
  }

  if(isDefined(level.player.var_C389)) {
    level.player scripts\sp\utility::_meth_82EA(level.player.var_C389);
  }

  level.player givegoproattachments(level.player.var_C39C);
  level.player.var_C39C = undefined;
  level.player give_explosive_touch_on_revived("vestlight");
  level.player setsuit("normal_sp");
  level.player _meth_81DE(float(level.player.var_C37E), 0.05);
  level.player scripts\engine\utility::allow_reload(0);
}

func_61E2(var_0) {
  if(var_0) {
    setsaveddvar("offhandShield_useCustomShader", 0);
    level.player give_explosive_touch_on_revived("c8servo");
    level.player setsuit("hacked_c8");
    level.player.var_C37E = getdvar("cg_fov");
    setsaveddvar("cg_fov", 75);
    level.player _meth_81DE(75, 0.05);
    level.player.health = self.health;
    level.player.var_C39C = level.player _meth_816D();
    if(level.player.var_C39C == "") {
      level.player.var_C39C = "viewmodel_base_viewhands_iw7";
    }

    level.player givegoproattachments("vm_robot_c8_base");
    scripts\engine\utility::delaythread(1.35, ::func_3464);
    level.player.var_C389 = level.player scripts\sp\utility::func_7AD7();
    if(isDefined(level.player.var_C389)) {
      level.player scripts\sp\utility::func_1143E();
    }

    level.player.var_87FE = 0.7;
    return;
  }

  setsaveddvar("offhandShield_useCustomShader", 1);
  level.player scripts\sp\utility::func_11428();
  level.player notify("hack_stop_sustaining_ammo");
  if(isDefined(level.player.var_C389)) {
    level.player scripts\sp\utility::_meth_82EA(level.player.var_C389);
  }

  level.player givegoproattachments(level.player.var_C39C);
  level.player.var_C39C = undefined;
  level.player give_explosive_touch_on_revived("vestlight");
  level.player setsuit("normal_sp");
  level.player _meth_81DE(float(level.player.var_C37E), 0.05);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
}

func_3464() {
  level.player giveweapon("iw7_mauler_c8hack");
  level.player switchtoweaponimmediate("iw7_mauler_c8hack");
  level.player giveweapon("offhandshield_c8");
  thread func_34E4();
  level.player scripts\engine\utility::allow_offhand_primary_weapons(1);
}

func_34E4() {
  level.player endon("hack_stop_sustaining_ammo");
  for(;;) {
    var_0 = level.player getcurrentprimaryweapon();
    var_1 = level.player getcurrentweaponclipammo();
    var_2 = weaponclipsize(var_0);
    if(var_1 < var_2) {
      level.player setweaponammoclip(var_0, var_2);
    }

    wait(0.05);
  }
}

func_61E1(var_0) {
  if(var_0) {
    level.player give_explosive_touch_on_revived("c6servo");
    level.player setsuit("hacked_c6");
    level.player.var_C37E = getdvar("cg_fov");
    setsaveddvar("cg_fov", 75);
    level.player _meth_81DE(75, 0.05);
    level.player scripts\engine\utility::allow_reload(1);
    level.player.health = self.health;
    level.player giveweapon("iw7_c6worker_fists");
    level.player switchtoweaponimmediate("iw7_c6worker_fists");
    level.player.var_C39C = level.player _meth_816D();
    if(level.player.var_C39C == "") {
      level.player.var_C39C = "viewmodel_base_viewhands_iw7";
    }

    level.player givegoproattachments("viewmodel_robot_c6");
    level.player.var_87FE = 1.2;
    return;
  }

  var_1 = level.player getweaponslistprimaries();
  foreach(var_3 in var_1) {
    level.player takeweapon(var_3);
  }

  level.player givegoproattachments(level.player.var_C39C);
  level.player.var_C39C = undefined;
  level.player give_explosive_touch_on_revived("vestlight");
  level.player setsuit("normal_sp");
  level.player _meth_81DE(float(level.player.var_C37E), 0.05);
  level.player scripts\engine\utility::allow_reload(0);
}

func_12C5() {
  if(isDefined(level.player.var_884E)) {
    level.player giveweapon(level.player.var_884E);
    level.player switchtoweaponimmediate(level.player.var_884E);
    return;
  }

  var_0 = strtok(self.var_394, "+");
  var_1 = var_0[0];
  var_2 = scripts\sp\utility::array_remove_index(var_0, 0);
  var_2[var_2.size] = "hacked";
  var_2 = scripts\engine\utility::alphabetize(var_2);
  foreach(var_4 in var_2) {
    var_1 = var_1 + "+" + var_4;
  }

  level.player giveweapon(var_1);
  level.player switchtoweaponimmediate(var_1);
}

func_880B(var_0) {
  level.player endon("stop drone sounds");
  level.player playSound("hacked_drone_on");
  wait(0.2);
  if(isDefined(level.var_8805)) {
    level.player _meth_82C0(level.var_8805, 0.4);
  } else if(var_0 == "C6" || var_0 == "C6Worker") {
    wait(0.3);
    level.player setclienttriggeraudiozonepartialwithfade("hacking_hud_c6", 0.3, "reverb", "mix", "filter", "ambient", "player_adsr");
  } else {
    wait(0.3);
    level.player setclienttriggeraudiozonepartialwithfade("hacking_hud_c8", 0.3, "mix", "filter", "ambient");
  }

  level.player.var_10466 = spawn("script_origin", level.player.origin);
  level.player.var_10466 linkto(level.player);
  for(;;) {
    level.player playSound("hacked_drone_hacking");
    wait(randomintrange(1, 3));
  }
}

func_8809() {
  level.player endon("stop drone sounds");
  var_0 = 1;
  var_1 = 0;
  var_2 = -1;
  var_3 = 0;
  thread func_3367();
  for(;;) {
    if(!level.player isonground()) {
      var_2 = -1;
    }

    if(var_2 != -1 && var_2 <= gettime()) {
      var_1 = gettime();
      level.player playSound("c6_hacked_step");
      if(var_0) {
        level.player playSound("c6_hacked_step_servo_l");
      } else {
        level.player playSound("c6_hacked_step_servo_r");
      }

      var_0 = !var_0;
    }

    if(self.var_87FB < var_3 || var_2 <= gettime()) {
      if(self.var_87FB == -1) {
        var_2 = -1;
      } else {
        var_2 = var_1 + self.var_87FB * 1000;
      }
    }

    var_3 = self.var_87FB;
    wait(0.05);
  }
}

func_3367() {
  level.player endon("stop drone sounds");
  self.var_87FB = -1;
  var_0 = 0.4;
  var_1 = 0.8;
  var_2 = 2.2;
  var_3 = 170;
  var_4 = 90;
  var_5 = 32;
  for(;;) {
    var_6 = level.player.origin;
    var_7 = distance2d(level.player getvelocity(), (0, 0, 0));
    if(var_7 < var_5) {
      self.var_87FB = -1;
      wait(0.05);
      continue;
    }

    if(var_7 < var_4) {
      var_8 = var_7 - var_5 / var_4 - var_5;
      var_8 = abs(var_8 - 1);
      var_9 = var_1 + var_8 * var_2 - var_1;
      self.var_87FB = var_9;
      wait(0.05);
      continue;
    }

    if(var_7 >= var_3) {
      self.var_87FB = var_0;
      wait(0.05);
      continue;
    }

    var_8 = var_7 - var_4 / var_3 - var_4;
    var_8 = abs(var_8 - 1);
    var_9 = var_0 + var_8 * var_1 - var_0;
    self.var_87FB = var_9;
    wait(0.05);
  }
}

func_11AA2() {
  level.player endon("death");
  level.player endon("faded_out");
  level.player endon("stop_track_hacked_drone_health");
  var_0 = 0;
  var_1 = 0;
  level.player.health = 100;
  for(;;) {
    level.player waittill("damage", var_2, var_3);
    self playSound("hack_hud_static_impact");
    var_0 = var_0 + var_2;
    var_4 = 0;
    if(isDefined(var_3) && isDefined(var_3.classname) && var_3.classname == "trigger_hurt") {
      var_4 = 1;
    }

    level.player.health = 100;
    if(var_0 > level.var_880C) {
      if(!var_4) {
        level.player notify("hack_drone_took_damage");
      } else {
        level.player notify("hack_drone_took_damage_trigger_hurt");
      }
    }

    if(var_0 > level.var_880C / 1.4 && !var_1) {
      level.player thread scripts\engine\utility::play_loop_sound_on_entity("hacked_drone_dmg_alarm");
      var_1 = 1;
    }
  }
}

func_1933() {
  if(!issentient(self)) {
    return;
  }

  self.var_C3DE = self getthreatbiasgroup();
  self give_zombies_perk("op_for");
  thread func_1934();
  thread func_19CA();
}

func_19CA() {
  var_0 = "hackControl";
  if(isDefined(level.player.var_8858)) {
    var_0 = level.player.var_8858;
  }

  if(!isDefined(level.player.var_8859)) {
    scripts\sp\utility::func_9196(1, 0, 1, var_0);
    var_1 = func_E5B9(self, 0);
    thread func_19D5(var_1, var_0);
    return;
  }

  if(scripts\engine\utility::array_contains(level.player.var_8859, self)) {
    scripts\sp\utility::func_9196(1, 0, 1, var_0);
    var_1 = func_E5B9(self, 0);
    thread func_19D5(var_1, var_0);
    return;
  }

  scripts\sp\utility::func_9196(1, 0, 0, var_0);
  thread func_19D5(-1, var_0);
}

func_19D5(var_0, var_1) {
  scripts\engine\utility::waittill_any_3("death", "player_hack_faded_out");
  scripts\sp\utility::func_9193(var_1);
  if(var_0 != -1) {
    func_E5B8(var_0);
  }
}

func_1934() {
  level.player endon("faded_out");
  self endon("death");
  if(!issentient(self)) {
    return;
  }

  thread func_1932();
  for(;;) {
    self waittill("damage", var_0, var_1);
    if(var_1 == level.player) {
      if(isDefined(self.var_C3DE) && self.var_C3DE != "") {
        self give_zombies_perk(self.var_C3DE);
      } else {
        self give_zombies_perk();
      }

      level notify("ai_aware_of_hacked_drone");
    }

    scripts\engine\utility::waitframe();
  }
}

func_1932() {
  level.player endon("faded_out");
  self waittill("death", var_0);
  level notify("ai_aware_of_hacked_drone");
}

func_19C8(var_0) {
  self endon("death");
  self endon("entitydeleted");
  if(!issentient(self)) {
    return;
  }

  if(var_0) {
    level.player endon("faded_out");
    level waittill("ai_aware_of_hacked_drone");
    if(!isalive(self)) {
      return;
    }

    var_1 = distance(self.origin, level.player.origin);
    if(var_1 <= 512) {
      var_2 = 0.8;
    } else if(var_2 >= 1024) {
      var_2 = 3;
    } else {
      var_3 = var_2 - 512 / 512;
      var_2 = 0.8 + var_3 * 2.2;
    }

    var_2 = var_2 + randomfloat(0.4);
    wait(var_2);
  }

  if(isalive(self)) {
    if(isDefined(self.var_C3DE) && self.var_C3DE != "") {
      self give_zombies_perk(self.var_C3DE);
    } else {
      self give_zombies_perk();
    }

    if(var_0) {
      wait(randomintrange(1, 3));
    }
  }
}

func_5C2E(var_0) {
  if(var_0 == "flying") {
    level.player scripts\sp\utility::func_1C3E(0);
  }

  level.player waittill("faded_out");
  if(isDefined(level.var_5C24)) {
    foreach(var_2 in level.var_5C24) {
      var_2 destroy();
    }
  }

  if(isDefined(level.var_54D5)) {
    level.var_54D5 destroy();
  }

  if(isDefined(level.var_54D6)) {
    level.var_54D6 destroy();
  }

  if(var_0 == "flying") {
    level.player scripts\sp\utility::func_1C3E(1);
  }
}

func_5C97(var_0) {
  level.player endon("hack_reset_timeout");
  level.player endon("hack_done_control_target");
  level.player endon("player_suicided_drone");
  level.player endon("hack_player_took_damage");
  level.player endon("hack_drone_took_damage");
  level.player endon("hack_drone_took_damage_trigger_hurt");
  level.player endon("faded_out");
  for(;;) {
    var_1 = 20;
    if(isDefined(var_0)) {
      var_1 = var_0;
    } else if(isDefined(level.player.var_8855)) {
      var_1 = level.player.var_8855;
    }

    if(var_1 > 5) {
      scripts\engine\utility::delaythread(var_1 - 5, ::func_12851);
    } else {
      thread func_12851();
    }

    wait(var_1);
    if(!isDefined(level.player.var_885C) || level.player.var_885C == 0) {
      break;
    }
  }

  level.player notify("drone_timeout");
}

func_12851() {
  if(!level.player scripts\sp\utility::func_65DB("is_controlling_robot")) {
    return;
  }

  if(!isDefined(level.player.var_885C) || level.player.var_885C == 0) {
    setomnvar("ui_hack_control_signal_failing", 1);
  }
}

func_5C86(var_0, var_1) {
  level.player endon("hack_done_control_target");
  wait(1);
  if(!isDefined(level.player.var_8803) || level.player.var_8803 == 0) {
    scripts\engine\utility::noself_delaycall(2.5, ::setomnvar, "ui_hack_control_selfdestruct", 1);
  }

  for(;;) {
    level.player waittill("primary_equipment_pressed");
    if(!isDefined(level.player.var_8803) || level.player.var_8803 == 0) {
      break;
    }
  }

  level.player notify("player_suicided_drone");
}

func_5C85(var_0, var_1, var_2) {
  if(isDefined(level.var_8826) && level.var_8826) {
    wait(2);
  }

  level.player notify("hack_suicide");
  level.player playSound("hack_hud_self_destruct_start");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("hack_hud_self_destruct_alarm");
  level.player notify("player_suicided_drone");
  var_3 = _func_313(level.player.origin, (150, 150, 25), (0, 0, 0));
  thread scripts\engine\utility::noself_delaycall(4.5, ::destroynavobstacle, var_3);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
  level.player scripts\engine\utility::allow_melee(0);
  if(!var_2) {
    level.player playgestureviewmodel("ges_shocknade_loop", undefined, 1);
  } else {
    level.player playgestureviewmodel("ges_c8_shield_damage", undefined, 1);
  }

  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_5 = level.player getEye();
  var_6 = level.player getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = anglestoup(var_6);
  var_4.origin = var_5;
  var_4.angles = vectortoangles(var_7);
  var_4 thread func_113DC();
  playFXOnTag(level._effect["hack_pov_suicide_loop"], var_4, "tag_origin");
  level.player._meth_843F = 1;
  var_9 = 0.65;
  if(var_1) {
    level.player playSound("c6_hack_self_destruct_initiate_short_plr");
    thread func_992D();
    wait(var_9);
    level.player thread scripts\sp\utility::func_C12D("hack_done_control_target", var_9);
  } else {
    var_4 playSound("c6_hack_self_destruct_initiate_plr");
    var_0A = int(gettime() + 3000);
    setomnvar("ui_hack_control_selfdestruct_timer", var_0A);
    setomnvar("ui_hack_control_selfdestruct_show_timer", 1);
    if(!isDefined(level.player.var_8803) || level.player.var_8803 == 0) {
      scripts\engine\utility::delaythread(0.25, ::func_AFE2);
    }

    thread func_AFE1();
    thread func_AFE3();
    var_0B = level.player scripts\engine\utility::waittill_any_return("long_suicide_done", "player_suicided_drone", "hack_drone_took_damage_trigger_hurt");
    setomnvar("ui_hack_control_selfdestruct_timer", 0);
    setomnvar("ui_hack_control_selfdestruct_show_timer", 0);
    level.player notify("suicide_control_done");
    thread func_992D();
    if(var_0B != "hack_drone_took_damage_trigger_hurt") {
      wait(var_9);
    }

    level.player thread scripts\sp\utility::func_C12D("hack_done_control_target", var_9);
  }

  level.player notify("stop soundhack_hud_self_destruct_alarm");
  stopFXOnTag(level._effect["hack_pov_suicide_loop"], var_4, "tag_origin");
  playFXOnTag(level._effect["hack_pov_explode"], var_4, "tag_origin");
  var_0C = level.player.origin;
  thread func_5C84(var_0C);
  if(!var_2) {
    level.player playgestureviewmodel("ges_player_death_drop1", undefined, 1);
  } else {
    level.player playgestureviewmodel("ges_c8_shield_death", undefined, 1);
  }

  scripts\engine\utility::flag_wait("hack_hud_control_outro_black");
  level.player scripts\engine\utility::allow_offhand_primary_weapons(1);
  level.player scripts\engine\utility::allow_melee(1);
  var_4 stopsounds();
  var_4 scripts\engine\utility::delaycall(0.05, ::delete);
  level.player._meth_843F = undefined;
  if(!var_2) {
    level.player stopgestureviewmodel("ges_player_death_drop1", 0.05);
  } else {
    level.player stopgestureviewmodel("ges_c8_shield_death", 0.05);
  }

  level.player stoprumble("damage_heavy");
  if(isDefined(var_0) && isai(var_0) && isalive(var_0)) {
    var_0.var_6D = 16;
    var_0 _meth_8481(var_0C);
    var_0 _meth_81D0();
  }
}

func_AFE3() {
  level.player endon("death");
  level.player endon("player_suicided_drone");
  wait(3);
  level.player notify("long_suicide_done");
}

func_AFE2() {
  level.player endon("death");
  level.player endon("long_suicide_done");
  level.player waittill("primary_equipment_pressed");
  level.player notify("player_suicided_drone");
}

func_AFE1() {
  level.player endon("death");
  level.player endon("long_suicide_done");
  for(;;) {
    level.player waittill("damage", var_0, var_1);
    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "trigger_hurt") {
      break;
    }
  }

  level.player notify("hack_drone_took_damage_trigger_hurt");
}

func_5C3B(var_0, var_1) {
  level.player notify("hack_suicide");
  level.player notify("player_suicided_drone");
  var_2 = _func_313(level.player.origin, (150, 150, 25), (0, 0, 0));
  thread scripts\engine\utility::noself_delaycall(4.5, ::destroynavobstacle, var_2);
  thread func_992D();
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_4 = level.player getEye();
  var_5 = level.player getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = anglestoup(var_5);
  var_3.origin = var_4;
  var_3.angles = vectortoangles(var_6);
  var_3 thread func_113DC();
  level.player._meth_843F = 1;
  var_8 = 0.65;
  level.player thread scripts\sp\utility::func_C12D("hack_done_control_target", var_8);
  level.player notify("stop soundhack_hud_self_destruct_alarm");
  playFXOnTag(level._effect["hack_pov_explode"], var_3, "tag_origin");
  var_9 = level.player.origin;
  thread func_5C84(var_9);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
  level.player scripts\engine\utility::allow_melee(0);
  if(!var_1) {
    level.player playgestureviewmodel("ges_player_death_drop1", undefined, 1);
  } else {
    level.player playgestureviewmodel("ges_c8_shield_death", undefined, 1);
  }

  scripts\engine\utility::flag_wait("hack_hud_control_outro_black");
  level.player scripts\engine\utility::allow_offhand_primary_weapons(1);
  level.player scripts\engine\utility::allow_melee(1);
  var_3 delete();
  level.player._meth_843F = undefined;
  if(!var_1) {
    level.player stopgestureviewmodel("ges_player_death_drop1", 0.05);
  } else {
    level.player stopgestureviewmodel("ges_c8_shield_death", 0.05);
  }

  level.player stoprumble("damage_heavy");
  if(isDefined(var_0) && isai(var_0) && isalive(var_0)) {
    var_0.var_6D = 16;
    var_0 _meth_8481(var_9);
    var_0 _meth_81D0();
  }
}

func_992D() {
  level.player endon("death");
  var_0 = getdvarfloat("bg_viewKickMin", 5);
  var_1 = getdvarfloat("bg_viewKickScale", 0.8);
  setsaveddvar("bg_viewKickMin", 2);
  setsaveddvar("bg_viewKickScale", 0);
  scripts\engine\utility::flag_wait("hack_hud_control_outro_black");
  setsaveddvar("bg_viewKickMin", var_0);
  setsaveddvar("bg_viewKickScale", var_1);
}

func_113DC() {
  self endon("death");
  for(;;) {
    self.origin = level.player getEye();
    self.angles = level.player getplayerangles();
    wait(0.05);
  }
}

func_B068() {
  self endon("hack_returned_to_player_position");
  for(;;) {
    playFX(level._effect["drone_suicide"], level.player.origin);
    earthquake(randomfloatrange(0.25, 0.5), 0.35, self.origin, 200);
    wait(0.35);
  }
}

func_5C84(var_0) {
  var_1 = var_0 + (0, 0, 48);
  var_2 = 300;
  var_3 = 300;
  var_4 = 80;
  if(isDefined(level.override_hack_eplo_dmg_min)) {
    var_4 = level.override_hack_eplo_dmg_min;
  }

  if(isDefined(level.override_hack_eplo_dmg_max)) {
    var_3 = level.override_hack_eplo_dmg_max;
  }

  var_5 = level.player.var_C391 + (0, 0, 48);
  if(distance(var_1, var_5) < var_2) {
    if(scripts\common\trace::ray_trace_passed(var_1, var_5, undefined, scripts\common\trace::create_solid_ai_contents(1))) {
      level.drone_explosion_near_player = 1;
    }
  }

  if(!isDefined(level.var_1024F)) {
    var_6 = level.player scripts\sp\detonategrenades::func_734E();
    level.player scripts\engine\utility::delaythread(2.4, ::scripts\sp\detonategrenades::func_734D, var_1, var_6, var_2);
  }

  radiusdamage(var_1, var_2, var_3, var_4, level.player);
  physicsexplosionsphere(var_1, 500, 50, 1);
  playFX(level._effect["drone_suicide"], var_1);
  level.player playSound("c6_hack_self_destruct_explo_plr", "sounddone");
  scripts\engine\utility::noself_delaycall(2, ::playworldsound, "c6_destruct", var_0);
  scripts\engine\utility::noself_delaycall(2, ::playfx, level._effect["drone_suicide"], var_1);
  level.player scripts\engine\utility::delaythread(2, ::drone_suide_explosion_player_damage);
}

drone_suide_explosion_player_damage() {
  if(scripts\engine\utility::istrue(level.drone_explosion_near_player)) {
    wait(0.2);
    if(isalive(level.player)) {
      level.player dodamage(level.player.health * 0.66, level.player.origin);
      thread scripts\sp\gameskill::func_2BDB(3.6, 2);
    }

    level.drone_explosion_near_player = undefined;
  }
}

func_6AFB() {
  level.player endon("player_suicided_drone");
  level.player endon("hack_player_took_damage");
  level.player endon("hack_drone_took_damage");
  level.player endon("hack_drone_took_damage_trigger_hurt");
  level.player endon("faded_out");
  for(;;) {
    self waittill("damage", var_0, var_1);
    if(!isDefined(level.var_CFEF)) {
      level.var_CFEF = 0;
    }

    level.var_CFEF = level.var_CFEF + var_0;
    if(level.var_CFEF > 200) {
      level.var_CFEE = 200;
      break;
    }
  }

  level.player notify("hack_player_took_damage");
}

func_5C77(var_0) {
  level.player notify("hack_shutdown_sequence");
  level.player notify("player_suicided_drone");
  var_1 = _func_313(level.player.origin, (150, 150, 25), (0, 0, 0));
  thread scripts\engine\utility::noself_delaycall(4.5, ::destroynavobstacle, var_1);
  level.player playgestureviewmodel("ges_shocknade_loop", undefined, 1);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = level.player getEye();
  var_4 = level.player getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = anglestoup(var_4);
  var_2.origin = var_3;
  var_2.angles = vectortoangles(var_5);
  var_2 thread func_113DC();
  playFXOnTag(level._effect["hack_pov_suicide_loop"], var_2, "tag_origin");
  level.player._meth_843F = 1;
  var_7 = 0.65;
  level.player playSound("c6_shutdown");
  wait(var_7);
  level.player thread scripts\sp\utility::func_C12D("hack_done_control_target", var_7);
  stopFXOnTag(level._effect["hack_pov_suicide_loop"], var_2, "tag_origin");
  var_8 = level.player.origin;
  scripts\engine\utility::flag_wait("hack_hud_control_outro_black");
  var_2 delete();
  level.player._meth_843F = undefined;
  level.player stopgestureviewmodel("ges_shocknade_loop", 0.05);
  level.player stoprumble("damage_heavy");
  if(isDefined(var_0) && isai(var_0) && isalive(var_0)) {
    var_0.var_6D = 16;
    var_0 _meth_8481(var_8);
    var_0 _meth_81D0();
  }
}

func_E0E3() {
  level.player.var_8815 = spawn("script_model", level.var_880A.origin);
  level.var_880A hide();
  level.var_880A linkto(level.player.var_8815);
  level.player.var_8815.origin = level.player.var_8815.origin - (0, 0, 10000);
}

func_E44E() {
  if(isDefined(level.var_880A) && isalive(level.var_880A)) {
    level.var_880A show();
    level.var_880A unlink();
    if(isai(level.var_880A)) {
      level.var_880A _meth_80F1(level.player.origin, level.player.angles);
    } else {
      level.var_880A.origin = level.player.origin;
      level.var_880A.angles = level.player.angles;
    }

    level.var_880A.var_8804 = undefined;
  }

  level.player.var_8815 delete();
  level.player notify("drone_reset");
}

func_2A47(var_0) {
  scripts\engine\utility::flag_wait("hack_hud_control_outro_black");
  level.player notify("faded_out");
  var_1 = "hackControl";
  if(isDefined(level.player.var_8858)) {
    var_1 = level.player.var_8858;
  }

  scripts\sp\utility::func_9199(var_1, 0);
  var_2 = getaiarray("bad_guys");
  foreach(var_4 in var_2) {
    if(isDefined(var_4.var_884A)) {
      var_4 scripts\sp\utility::func_F3E6(var_4.var_884A);
    }

    var_4 notify("player_hack_faded_out");
  }

  level.var_ECA4["autopickup"] = 1;
  if(isalive(level.player)) {
    level.player.var_9BA2 = 0;
    level.player.var_9BFA = 0;
    if(scripts\sp\utility::func_93A6()) {
      level.player.health = level.player.var_C384;
      level.player.maxhealth = level.player.og_maxhealth;
    } else {
      level.player.health = level.player.og_maxhealth;
    }

    if(isDefined(level.var_CFEF)) {
      level.player dodamage(level.var_CFEF, level.player.origin);
      level.var_CFEF = undefined;
    }

    var_2 = getaiarray("bad_guys");
    scripts\engine\utility::array_thread(var_2, ::func_19C8, 0);
    level.player thread func_2A48();
    level.var_880A thread func_E44E();
    level.player give_zombies_perk();
    if(isDefined(level.player.var_883C)) {
      level.player.var_883C unlink();
      level.player.var_883C dontinterpolate();
      level.player.var_883C.origin = level.player.var_C391;
      level.player.var_883C.angles = level.player.og_angles;
      level.player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
      scripts\engine\utility::delaythread(0.1, ::func_62D5, level.player.var_C396);
    } else {
      level.player setorigin(level.player.var_C391);
      if(isDefined(level.var_880A) && isalive(level.var_880A)) {
        var_6 = vectortoangles(level.var_880A.origin - level.player.origin);
        level.player setplayerangles(var_6);
      } else {
        level.player setplayerangles(level.player.og_angles);
      }
    }

    if(!isDefined(level.player.hackenableenemymelee) || !level.player.hackenableenemymelee) {
      level.player.dontmelee = 1;
    }

    level.player scripts\engine\utility::delaythread(3, ::func_B2B5);
    level.player giveperkoffhand();
    level.player allowswim(0);
    level.player allowlean(1);
    level.player thermalvisionoff();
    level.player scripts\engine\utility::allow_sprint(1);
    level.player scripts\engine\utility::allow_melee(0);
    level.player scripts\engine\utility::allow_doublejump(1);
    level.player scripts\engine\utility::allow_wallrun(1);
    level.player scripts\engine\utility::allow_prone(1);
    level.player setstance(level.player.var_C396);
    level.player.var_C396 = undefined;
    level.player scripts\engine\utility::allow_autoreload(0);
    level.player enableweaponpickup();
    if(scripts\engine\utility::istrue(level.var_884F)) {
      scripts\sp\utility::func_CF8D();
      level.var_884F = undefined;
    }

    if(!getdvarint("exec_review", 0)) {
      level.player getrankinfofull(0);
    }

    level.player scripts\sp\utility::func_1C75(1);
    level.player _meth_8559(1);
    lib_0E4B::func_8E0A();
    level.player lib_0E42::removeperk("specialty_fastreload");
    level.player _meth_84FD();
    level.player _meth_8475();
    level.var_87FF = undefined;
    if(isDefined(level.player.var_8860)) {
      level.player scripts\engine\utility::allow_usability(0);
      level.player.var_8860 = undefined;
    }

    if(var_0 == "flying") {
      level.player scripts\engine\utility::allow_crouch(1);
    } else if(var_0 == "C6") {
      func_61E0(0);
    } else if(var_0 == "C8") {
      func_61E2(0);
    } else if(var_0 == "C6Worker") {
      func_61E1(0);
    }

    lib_0B2A::func_E2C0();
    level.player notify("hack_returned_to_player_position");
    scripts\engine\utility::flag_wait("hack_hud_control_outro_finished");
    if(isDefined(level.player.var_885B)) {
      func_61D0();
      level.player.var_885B = undefined;
    }

    level.player scripts\engine\utility::delaythread(0.4, ::func_2A49);
    level.player scripts\engine\utility::allow_jump(1);
    level.player scripts\engine\utility::allow_mantle(1);
    level.player scripts\engine\utility::delaycall(0.3, ::_meth_80A6);
    for(var_7 = 0; var_7 < level.player.var_C39E.size; var_7++) {
      var_8 = level.player.var_C39E[var_7];
      level.player giveweapon(var_8.var_394);
      level.player setweaponammoclip(var_8.var_394, var_8.var_1E40);
      level.player setweaponammostock(var_8.var_394, var_8.var_1E4D);
    }

    level.player switchtoweapon(level.player.var_C37C);
    if(isDefined(level.player.var_C376) && level.player.var_C376 != "") {
      level.player scripts\sp\utility::scriptmodelplayanimdeltamotion(level.player.var_C376);
    }

    level.player.var_C376 = undefined;
    level.player scripts\sp\utility::func_65DD("is_hacked_robot");
    func_8793();
  }
}

func_62D5(var_0) {
  var_1 = ["stand", "crouch", "prone"];
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  foreach(var_3 in var_1) {
    if(var_3 == "stand") {
      level.player scripts\engine\utility::allow_stances(0);
    }

    if(var_3 == "crouch") {
      level.player scripts\engine\utility::allow_crouch(0);
    }

    if(var_3 == "prone") {
      level.player scripts\engine\utility::allow_prone(0);
    }
  }

  level.player setstance(var_0);
  wait(1);
  level.player unlink();
  level.player.var_883C delete();
  foreach(var_3 in var_1) {
    if(var_3 == "stand") {
      level.player scripts\engine\utility::allow_stances(1);
    }

    if(var_3 == "crouch") {
      level.player scripts\engine\utility::allow_crouch(1);
    }

    if(var_3 == "prone") {
      level.player scripts\engine\utility::allow_prone(1);
    }
  }
}

func_2A49() {
  level.player scripts\sp\utility::func_2B76(1, 0.5);
}

func_8793(var_0) {
  level.player.var_883D = "end";
  self getradiuspathsighttestnodes();
  if(isDefined(level.var_D365)) {
    level.var_D365 show();
    scripts\sp\anim::func_1EC7(level.var_D365, "hack_control_end");
    if(isDefined(level.var_D365)) {
      level.var_D365 delete();
    }
  }

  level.var_D365 = undefined;
  self enableweapons();
  if(!isDefined(var_0) || !var_0) {
    level.player thread hacking_end();
  }

  self.var_8824 = 1;
  level.player scripts\sp\utility::func_65E1("hack_control_outro_done");
}

func_2A48() {
  level.player notify("stop drone sounds");
  if(isDefined(level.player.var_10466)) {
    level.player.var_10466 unlink();
    level.player.var_10466 delete();
  }
}

func_6AFD() {
  if(!isDefined(level.var_6AFC)) {
    return;
  }

  level.var_6AFC.angles = level.player.angles;
  level.var_6AFC.origin = level.player.origin;
  var_0 = level.var_6AFC giveplayeraccessory();
  var_1 = level.player getmovingplatformparent();
  if(isDefined(var_1)) {
    var_0 linkto(var_1);
  }

  level.player.var_6AF9 = var_0;
  var_0 glinton(#animtree);
  var_0.var_1FBB = "fake_player";
  var_0 thread scripts\sp\anim::func_1EEA(var_0, "drone_use_idle", "stop_loop");
  level.player waittill("faded_out");
  var_0 givescorefortrophyblocks();
  var_0 _meth_81D0();
  wait(0.05);
  var_0 delete();
}

func_54FD() {
  level.player _meth_84CE(["trigger_hurt"]);
}

func_61D0() {
  level.player _meth_84CD();
}

func_E5B9(var_0, var_1) {
  var_2 = -1;
  for(var_3 = 0; var_3 < 24; var_3++) {
    if(level.var_87FF[var_3] == 0) {
      var_2 = var_3;
      level.var_87FF[var_3] = 1;
      break;
    }
  }

  if(getdvarint("exec_review")) {
    return var_2;
  }

  if(var_2 != -1) {
    setomnvar("ui_reticles_" + var_2 + "_target_ent", var_0);
    setomnvar("ui_reticles_" + var_2 + "_lock_state", var_1);
  }

  return var_2;
}

func_E5B8(var_0) {
  level.var_87FF[var_0] = 0;
  setomnvar("ui_reticles_" + var_0 + "_target_ent", undefined);
  setomnvar("ui_reticles_" + var_0 + "_lock_state", 0);
}

func_79CE(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

func_919C() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 2;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.8";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.8";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

func_91A4() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.4";
  var_0["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 0.4";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 0";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.6 0.6 0.6 0.8";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.6 0.6 0.6 0.1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

func_8784() {
  level.var_EC87["player_arms"] = #animtree;
  level.var_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level.var_EC85["generic"]["hack_control_end"] = % vm_gauntlet_hack_control_end;
}

func_E578() {
  level.var_EC85["generic"]["robot_hacked"][0] = % pain_electric_claymore;
}

func_D304() {
  level.var_EC85["fake_player"]["drone_use_idle"][0] = % shipcrib_crouch_point_idle_01;
}

player_lookat_ent_wrapper(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  func_1D5E(var_0, var_1);
}

is_console() {
  return level.console;
}

is_mouse_and_keyboard() {
  if(is_console()) {
    return 0;
  }

  return !level.player usinggamepad();
}

hack_toggled_off_think() {
  self endon("death");
  self endon("hack_unequipped");
  self endon("stop_hack_disabled_think");
  self notify("hack_toggled_off_think");
  self endon("hack_toggled_off_think");
  scripts\engine\utility::waittill_any_3("secondary_equipment_pressed", "hack_weap_switch", "hack_input_on_locked_robot");
  level.player scripts\sp\utility::func_65E1("hack_toggled_off");
  level.player notify("hack_toggled_off");
}

hacking_locked_fire_think() {
  self endon("hack_unequipped");
  self endon("hack_disabled");
  self endon("hack_locked_hold_done");
  self waittill("hack_fire");
  level.player scripts\sp\utility::func_65E1("hack_toggle_fired");
}