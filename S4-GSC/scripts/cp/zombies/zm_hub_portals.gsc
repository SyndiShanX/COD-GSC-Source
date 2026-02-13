/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_hub_portals.gsc
*************************************************/

_id_C1EF() {
  _id_0737::_id_C266("portal_inactive", ::get_portal_hint_func, ::on_portal_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128);
  _id_0737::_id_10C8("portal_inactive", ::portal_set_hint);
  _id_0737::addinteractionhinttypecallback("portal_inactive", ::portal_hint_type);
  _id_0737::_id_C4AB("portal_inactive");
  _id_81C4();
}

_id_81C4() {
  var_0 = get_all_portal_structs();

  foreach(var_2 in var_0) {
    toggle_portal_clip_by_name(0, var_2._id_0481);
  }
}

on_portal_interact(var_0, var_1) {}

portal_set_hint(var_0, var_1) {
  var_2 = var_1 portal_hint_type(var_0, var_1);
  var_1._id_8388 setcursorhint(var_2);
}

get_portal_hint_func(var_0, var_1) {
  return var_1 get_portal_hint_string();
}

portal_hint_type(var_0, var_1) {
  return var_1 get_portal_hint_type();
}

get_portal_hint_type() {
  return "HINT_NOBUTTON";
}

get_portal_hint_string() {
  return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
}

get_exfil_interact_struct(var_0) {
  foreach(var_2 in var_0._id_3BE8["start_interact"]) {
    if(scripts\engine\utility::is_equal(var_2._id_0481, "exfil_radio")) {
      return var_2;
    }
  }

  return _id_651A(var_0);
}

get_forever_blitz_interact_struct(var_0) {
  foreach(var_2 in var_0._id_3BE8["start_interact"]) {
    if(scripts\engine\utility::is_equal(var_2._id_0481, "forever_blitz_portal")) {
      return var_2;
    }
  }

  return _id_651A(var_0);
}

_id_651A(var_0) {
  return var_0._id_3BE8["start_interact"][0];
}

get_hub_instance() {
  return level._id_3BE9._id_96DE["objectives_location_fob"];
}

get_active_portals(var_0) {
  var_1 = [];
  var_2 = get_hub_instance();

  if(isDefined(var_2.portals)) {
    foreach(var_4 in var_2.portals) {
      if(isDefined(var_4) && !_func_0458(var_4)) {
        var_1[var_1.size] = var_4;
      }
    }
  }

  if(var_0 && isDefined(var_2.portal_fixed)) {
    var_1[var_1.size] = var_2.portal_fixed;
  }

  return var_1;
}

get_all_portal_structs() {
  var_0 = get_portal_structs(1, 1, 1);
  var_0 = scripts\engine\utility::array_combine(var_0, get_secondary_portal_structs(1));
  var_0 = scripts\engine\utility::array_combine(var_0, get_all_quest_portal_structs());
  return var_0;
}

get_portal_structs(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in get_hub_instance()._id_3BE8["start_interact"]) {
    var_6 = var_1 && scripts\engine\utility::is_equal(var_5._id_3BE5, "portal") && !scripts\engine\utility::is_equal(var_5._id_0481, "portal_fixed");

    if(var_6) {
      if(var_2) {
        var_3[var_3.size] = var_5;
      } else {
        var_7 = !isDefined(var_5.is_removed) || isDefined(var_5.is_removed) && !var_5.is_removed;

        if(var_7) {
          var_3[var_3.size] = var_5;
        }
      }
    }

    var_8 = var_0 && scripts\engine\utility::is_equal(var_5._id_0481, "portal_fixed");

    if(var_8) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

get_secondary_portal_structs(var_0) {
  var_1 = [];
  var_2 = get_hub_instance();
  var_3 = var_2._id_3BE8["secondary_interact"];

  if(istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_4 = var_2._id_3BE8["secondary_interact_vlo"];

    if(_func_0107(var_4)) {
      var_3 = scripts\engine\utility::array_combine(var_4, var_3);
    }
  }

  if(!_func_0107(var_3)) {
    return var_1;
  }

  foreach(var_6 in var_3) {
    if(var_0) {
      var_1[var_1.size] = var_6;
      continue;
    }

    var_7 = istrue(var_6.is_removed);
    var_8 = istrue(var_6.has_prerequisite_portal_removed);

    if(!var_7 && var_8) {
      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}

get_all_quest_portal_structs() {
  var_0 = [];
  var_1 = get_hub_instance();
  var_2 = var_1._id_3BE8["quest_interact"];
  return var_2;
}

spawn_next_interact(var_0) {
  var_1 = _id_651A(var_0._id_96CF);
  var_2 = _id_06EF::_id_672B(var_0._id_3BE5);

  if(scripts\engine\utility::is_equal(var_0._id_3BE5, "exfil")) {
    var_3 = get_exfil_interact_struct(var_0._id_96CF);
    var_4 = _id_E206(var_3, var_0, "s4_zm_exfil_start_01", 0);
  } else if(scripts\engine\utility::is_equal(var_0._id_3BE5, "forever_blitz")) {
    var_5 = get_forever_blitz_interact_struct(var_0._id_96CF);
    var_4 = _id_E206(var_5, var_0, "s4_zm_portal_01", 1);
  } else {
    var_4 = spawn_hub_portal(var_0);

    if(isDefined(get_hub_instance().portals) && get_hub_instance().portals.size == 0) {
      var_4 = _id_E206(var_1, var_0, "s4_zm_portal_01", 1);
    }

    if(isDefined(var_4)) {
      var_4 setscriptablepartstate("sfx", "activate");
    }
  }
}

_id_E206(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4 = var_1._id_3BE8["interact_dressing"];

  if(isDefined(var_4) && var_4.size > 0) {
    foreach(var_6 in var_4) {
      _id_06EF::_id_E1E5(var_6, var_6.model, 1);
    }
  }

  var_8 = _id_06EF::_id_E170(var_0, var_2, ::_id_AA6A);
  var_8.interact_struct = var_0;
  var_8._id_82FC = var_1;
  var_1._id_E5F6 = var_8;
  var_8.portal_inactive_struct = scripts\engine\utility::getstruct(var_8.interact_struct._id_0481 + "_inactive", "targetname");

  if(var_3) {
    var_8.hub_portal = var_0._id_0481;
    var_8 set_portal_asset(var_1);
  }

  return var_8;
}

_id_AA6A(var_0) {
  level endon("begin_game_ended");
  var_1 = self._id_82FC;

  if(!isDefined(var_1)) {
    return 0;
  }

  level scripts\engine\utility::_id_5C1B("objective_locked");

  if(scripts\engine\utility::is_equal(var_1._id_0481, "objective_dark_aether_forever_blitz") || scripts\engine\utility::is_equal(var_1._id_0481, "objective_dark_aether_assault")) {
    level.str_portal_cinematic_override = "zm_portal_full_green";
    level.str_portal_first_person_effect_label_override = "zm_teleport_intro_green";
    level.str_portal_end_first_person_effect_label_override = "zm_teleport_end_green";
  }

  if((scripts\engine\utility::is_equal(var_1._id_0481, "objective_domination_dark_aether_south") || scripts\engine\utility::is_equal(var_1._id_0481, "objective_domination_dark_aether_north")) && istrue(var_1.b_is_quest)) {
    level.str_portal_cinematic_override = "zm_portal_full_blue";
    level.str_portal_first_person_effect_label_override = "zm_teleport_intro_blue";
    level.str_portal_end_first_person_effect_label_override = "zm_teleport_end_blue";
  }

  if(!scripts\engine\utility::is_equal(self _meth_8575("content_interact"), "visible")) {
    return;
  }
  var_3 = 0;
  var_4 = "could not find portal failed";

  if(isDefined(var_1) && isDefined(var_1._id_3BE5)) {
    switch (var_1._id_3BE5) {
      case "holdout":
        var_3 = 2;
        var_4 = "blitz failed";
        break;
      case "assault":
        var_3 = 5;
        var_4 = "assault failed";
        break;
      case "orb_follow":
        var_3 = 3;
        var_4 = "orb follow failed";
        break;
      case "domination":
        var_3 = 6;
        var_4 = "domination failed";
        break;
      case "soul_capture":
        var_3 = 4;
        var_4 = "soul capture failed";
        break;
      case "exfil":
        var_3 = 1;
        var_4 = "exfil failed";
        break;
      case "forever_blitz":
        var_3 = 7;
        var_4 = "forever blitz start failed";
        break;
    }
  }

  set_portals_inactive();
  var_5 = _id_0992::_id_106AF(var_0, var_3, var_4);

  if(!var_5) {
    set_portals_active();
    level scripts\engine\utility::_id_5C04("objective_locked");
    level notify("s2_mq_portal_reactive");
    return 0;
  } else {
    level notify("force_quit_current_dialogue");
    level notify("vote_passed");
  }

  if(!_id_0987::_id_E618(var_1, var_0)) {
    level scripts\engine\utility::_id_5C04("objective_locked");
    return 0;
  }

  if(isDefined(self._id_82FC)) {
    self._id_82FC.hub_portal = self.hub_portal;
  }

  level.last_objective_start = _func_00D7();
  scripts\cp\telemetry_cp::logevent_serveraispawned();
  level.spawnedaibase = 0;
  level.spawnedaijuggernaut = 0;
  level.spawnedaiscreamer = 0;
  level.spawnedaitrickster = 0;
  return 1;
}

set_portal_asset(var_0) {
  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = "hub";

  if(isDefined(level.a_portal_model_state_map[var_0.target])) {
    var_1 = level.a_portal_model_state_map[var_0.target];
  }

  if(get_is_hub_instance(var_0)) {
    var_1 = "hub";
  }

  if(isDefined(self.hub_portal) && scripts\engine\utility::is_equal(self.hub_portal, "mq_portal")) {
    var_2 = "mq";
  } else if(isDefined(self.hub_portal) && scripts\engine\utility::is_equal(self.hub_portal, "s2_mq_unique_assault_portal")) {
    var_1 = "dark_aether";
    var_2 = "normal_green";
  } else if(isDefined(self.hub_portal) && scripts\engine\utility::is_equal(self.hub_portal, "s2_mq_unique_domination_portal")) {
    var_1 = "dark_aether";
    var_2 = "normal_blue";
  } else if(isDefined(self.hub_portal) && scripts\engine\utility::is_equal(self._id_82FC._id_0481, "objective_dark_aether_forever_blitz")) {
    var_1 = "dark_aether";
    var_2 = "normal_green";
  } else
    var_2 = "normal";

  self setscriptablepartstate("base", var_1);
  self setscriptablepartstate("fx", var_2);
  toggle_portal_clip(1);
}

get_is_hub_instance(var_0) {
  var_1 = 0;

  switch (var_0._id_0481) {
    case "objective_domination_basement_outdoor":
    case "objective_domination_red_star_alley":
    case "objective_basement_outdoor_assault":
    case "objective_basement_south_orb_follow":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

spawn_hub_portal(var_0) {
  var_1 = get_hub_instance();
  var_2 = get_portal_structs(0, 1, 0);
  var_2 = scripts\engine\utility::array_combine(var_2, get_secondary_portal_structs(0));
  var_3 = isDefined(var_1.portals) && var_1.portals.size > 0 && var_2.size == 0;

  if(var_3) {
    if(!isDefined(var_1.portal_fixed)) {
      foreach(var_5 in level.players) {
        _id_070F::createopenportalevent(var_5);
      }

      foreach(var_8 in var_1._id_3BE8["start_interact"]) {
        if(scripts\engine\utility::is_equal(var_8._id_0481, "portal_fixed")) {
          var_9 = _id_E206(var_8, var_0, "s4_zm_portal_01", 1);
          var_1.portal_fixed = var_9;

          foreach(var_5 in level.players) {
            _id_070F::createareaunlockevent(var_5, scripts\cp\utility::_id_6871() - 1, 1);
          }

          return var_9;
        }
      }
    } else {
      var_1.portal_fixed._id_82FC = var_0;
      var_1.portal_fixed set_portal_asset(var_0);
      var_0._id_E5F6 = var_1.portal_fixed;
      level.active_objective_instances = scripts\cp\utility::_id_459B(level.active_objective_instances, []);
      level.active_objective_instances = scripts\cp\utility::_id_1B8C(level.active_objective_instances, var_0);
      return undefined;
    }
  }

  if(!isDefined(var_1.portals)) {
    var_1.portals = [];
  }

  foreach(var_8 in var_2) {
    var_14 = scripts\engine\utility::is_equal(var_8._id_3BE5, "portal") && !scripts\engine\utility::is_equal(var_8._id_0481, "portal_fixed") && !isDefined(var_8.is_removed);

    if(var_14) {
      var_8.is_removed = 0;
      var_9 = _id_E206(var_8, var_0, "s4_zm_portal_01", 1);
      var_1.portals[var_1.portals.size] = var_9;
      return var_9;
    }
  }

  return undefined;
}

update_objective_portal(var_0) {
  if(istrue(level.soak_testing) && !isDefined(var_0.hub_portal)) {
    return;
  }
  var_1 = check_for_additional_secondary_portal_activation(var_0.hub_portal);
  var_2 = get_all_portal_structs();
  var_3 = undefined;

  foreach(var_5 in get_active_portals(0)) {
    if(isDefined(var_5.hub_portal) && isDefined(var_0.hub_portal) && var_5.hub_portal == var_0.hub_portal) {
      foreach(var_7 in var_2) {
        if(scripts\engine\utility::is_equal(var_7._id_0481, var_0.hub_portal) && isDefined(var_7.is_removed)) {
          var_7.is_removed = 1;
        }
      }

      var_3 = var_5;
      break;
    }
  }

  if(isDefined(var_0.hub_portal) && _func_0121(var_0.hub_portal)) {
    level notify(var_0.hub_portal + "_completed");
  }

  level waittill("portal_activated");
  spawn_new_objectives_at_portals();

  if(!isDefined(var_3)) {
    show_portals_objectives();
  } else {
    var_3 thread portal_wait_to_die(var_1);
  }
}

portal_wait_to_die(var_0) {
  cleanup_portal();
  show_portals_objectives();
  spawn_additional_objectives(var_0);
}

spawn_additional_objectives(var_0) {
  while(var_0 > 0) {
    _id_0987::_id_B05F();
    _id_0987::_id_E1A2();
    var_0--;
  }
}

cleanup_portal() {
  self setscriptablepartstate("sfx", "deactivate");

  if(isDefined(self.portal_clip_ent) && !scripts\engine\utility::is_equal(self.hub_portal, "portal_fixed")) {
    toggle_portal_clip(0);
  }

  if(isDefined(self.portal_inactive_struct)) {
    _id_0737::_id_C3C5(self.portal_inactive_struct);
  }

  self notify("death");
  self _meth_86BE();
}

cleanup_all_active_portals() {
  toggle_start_interact_markers(0);
  waitframe();

  foreach(var_1 in get_active_portals(0)) {
    if(var_1._id_82FC._id_3BE5 != "exfil") {
      var_1 cleanup_portal();
    }
  }
}

filter_portals_for_respawn(var_0) {
  var_1 = 0;
  var_2 = get_all_portal_structs();

  foreach(var_4 in var_2) {
    var_5 = !isDefined(var_4.is_removed) || var_4.is_removed;

    if(var_5) {
      continue;
    }
    foreach(var_7 in get_active_portals(0)) {
      if(var_7.hub_portal == var_4._id_0481 && get_is_filtered_portal(var_7)) {
        var_4.is_removed = undefined;
        var_7 cleanup_portal();
        var_1++;
        break;
      }
    }
  }

  spawn_additional_objectives(var_1);
}

spawn_new_objectives_at_portals() {
  var_0 = 0;
  var_1 = get_all_portal_structs();

  foreach(var_3 in var_1) {
    var_4 = !isDefined(var_3.is_removed) || var_3.is_removed;

    if(var_4) {
      continue;
    }
    foreach(var_6 in get_active_portals(0)) {
      if(var_6.hub_portal == var_3._id_0481) {
        var_3.is_removed = undefined;
        var_6 cleanup_portal();
        var_0++;
        break;
      }
    }
  }

  spawn_additional_objectives(var_0);
}

get_is_filtered_portal(var_0) {
  if(level._id_11049 >= 4) {
    if(isDefined(level.small_objective_instance_names)) {
      foreach(var_2 in level.small_objective_instance_names) {
        if(var_0._id_82FC._id_0481 == var_2) {
          return 1;
        }
      }
    }
  }

  return 0;
}

check_for_additional_secondary_portal_activation(var_0) {
  var_1 = get_hub_instance();
  var_2 = 0;
  var_3 = scripts\cp\utility::_id_459B(var_1._id_3BE8["secondary_interact"], []);

  if(istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_4 = var_1._id_3BE8["secondary_interact_vlo"];

    if(_func_0107(var_4)) {
      var_3 = scripts\engine\utility::array_combine(var_4, var_3);
    }
  }

  foreach(var_6 in var_3) {
    if(!istrue(var_6.is_removed) && isDefined(var_6._id_039B) && scripts\engine\utility::is_equal(var_6._id_039B, var_0)) {
      var_6.has_prerequisite_portal_removed = 1;
      var_2++;
    }
  }

  return var_2;
}

hide_portals_asset() {
  var_0 = get_active_portals(1);

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 toggle_portal_clip(0);
      var_2 setscriptablepartstate("base", "off");
      var_2 setscriptablepartstate("fx", "off");

      if(isDefined(var_2.portal_inactive_struct)) {
        _id_0737::_id_C3C5(var_2.portal_inactive_struct);
      }
    }
  }

  if(!istrue(level.b_skip_hide_forever_blitz)) {
    if(isDefined(level.a_forever_blitz_instance)) {
      foreach(var_5 in level.a_forever_blitz_instance) {
        if(istrue(var_5.forever_blitz_ready)) {
          var_5._id_E5F6 toggle_portal_clip(0);
          var_5._id_E5F6 setscriptablepartstate("base", "off");
          var_5._id_E5F6 setscriptablepartstate("fx", "off");

          if(isDefined(var_5._id_E5F6.portal_inactive_struct)) {
            _id_0737::_id_C3C5(var_5._id_E5F6.portal_inactive_struct);
          }
        }
      }
    }
  }
}

set_portals_inactive() {
  if(isDefined(level._id_570D) && istrue(level._id_570D._id_5713)) {
    level._id_570D._id_E5F6 setscriptablepartstate("content_interact", "visible_inactive");

    if(isDefined(level._id_570D._id_E5F6.portal_inactive_struct)) {
      level._id_570D._id_E5F6.portal_inactive_struct thread set_inactive_struct_delay();
    }
  }

  if(isDefined(level.a_forever_blitz_instance)) {
    foreach(var_1 in level.a_forever_blitz_instance) {
      if(istrue(var_1.forever_blitz_ready)) {
        var_1._id_E5F6 setscriptablepartstate("content_interact", "visible_inactive");

        if(isDefined(var_1._id_E5F6.portal_inactive_struct)) {
          _id_0737::_id_1037(var_1._id_E5F6.portal_inactive_struct);
        }
      }
    }
  }

  if(isDefined(level._id_A883) && isDefined(level._id_A883._id_E5F6)) {
    if(scripts\engine\utility::is_equal(level._id_A883._id_0481, "objective_domination_dark_aether_south") || scripts\engine\utility::is_equal(level._id_A883._id_0481, "objective_domination_dark_aether_north") || scripts\engine\utility::is_equal(level._id_A883._id_0481, "objective_dark_aether_assault")) {
      level._id_A883._id_E5F6 setscriptablepartstate("content_interact", "visible_inactive");
    }
  }

  var_3 = get_active_portals(1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_5 setscriptablepartstate("content_interact", "visible_inactive");

      if(isDefined(var_5.portal_inactive_struct)) {
        var_5.portal_inactive_struct thread set_inactive_struct_delay();
      }
    }
  }
}

set_inactive_struct_delay() {
  level endon("game_ended");
  level endon("activating_portals");
  waittillframeend;

  if(isDefined(level._id_CAB8)) {
    for(;;) {
      if(isDefined(level._id_CAB8)) {
        wait 0.1;
        continue;
      }

      break;
    }
  }

  if(isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "exfil")) {
    return;
  }
  wait 2;
  _id_0737::_id_1037(self);
}

set_portals_hidden() {
  if(isDefined(level._id_570D) && istrue(level._id_570D._id_5713)) {
    level._id_570D._id_E5F6 setscriptablepartstate("fx", "inactive");

    if(isDefined(level._id_570D._id_E5F6.portal_inactive_struct)) {
      _id_0737::_id_C3C5(level._id_570D._id_E5F6.portal_inactive_struct);
    }
  }

  if(!istrue(level.b_skip_hide_forever_blitz)) {
    if(isDefined(level.a_forever_blitz_instance)) {
      foreach(var_1 in level.a_forever_blitz_instance) {
        if(istrue(var_1.forever_blitz_ready)) {
          var_1._id_E5F6 setscriptablepartstate("content_interact", "hidden");
          var_1._id_E5F6 toggle_portal_clip(0);

          if(isDefined(var_1._id_E5F6.portal_inactive_struct)) {
            _id_0737::_id_C3C5(var_1._id_E5F6.portal_inactive_struct);
          }
        }
      }
    }
  }

  var_3 = get_active_portals(1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_5 setscriptablepartstate("content_interact", "hidden");

      if(isDefined(var_5.portal_inactive_struct)) {
        _id_0737::_id_C3C5(var_5.portal_inactive_struct);
      }
    }
  }
}

set_portals_active() {
  level notify("activating_portals");

  if(isDefined(level._id_570D) && istrue(level._id_570D._id_5713)) {
    level._id_570D._id_E5F6 setscriptablepartstate("content_interact", "visible");
    level._id_570D._id_E5F6 setscriptablepartstate("fx", "idle");

    if(isDefined(level._id_570D._id_E5F6.portal_inactive_struct)) {
      _id_0737::_id_C3C5(level._id_570D._id_E5F6.portal_inactive_struct);
    }
  }

  if(isDefined(level.a_forever_blitz_instance)) {
    foreach(var_1 in level.a_forever_blitz_instance) {
      if(istrue(var_1.forever_blitz_ready)) {
        var_1._id_E5F6 toggle_portal_clip(1);
        var_1._id_E5F6 setscriptablepartstate("content_interact", "visible");
        var_1._id_E5F6 set_portal_asset(var_1);

        if(isDefined(var_1._id_E5F6.portal_inactive_struct)) {
          _id_0737::_id_C3C5(var_1._id_E5F6.portal_inactive_struct);
        }
      }
    }
  }

  var_3 = get_active_portals(1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_5 toggle_portal_clip(1);
      var_5 setscriptablepartstate("content_interact", "visible");
      var_5 set_portal_asset(var_5._id_82FC);
    }
  }

  _id_0737::_id_C4AB("portal_inactive");
}

set_spawned_objectives(var_0) {
  foreach(var_2 in level._id_3BE9._id_E2BA) {
    foreach(var_4 in var_2) {
      if(isDefined(var_4._id_A8FE)) {
        var_5 = "invisible";

        if(var_0) {
          var_5 = "active";
        }

        _func_016B(var_4._id_A8FE, var_5);
      }
    }
  }
}

hide_portals_objectives() {
  set_spawned_objectives(0);
  set_portals_hidden();
  hide_portals_asset();
}

show_portals_objectives() {
  set_portals_active();
  set_spawned_objectives(1);
}

add_start_interact_marker(var_0, var_1, var_2) {
  if(isDefined(var_1.startinteractinstanceindex)) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_E747 = "current";
  var_3._id_96CF = var_1.origin;

  if(isDefined(var_2)) {
    var_3._id_11012 = var_2;
  } else {
    var_3._id_11012 = 50;
  }

  var_3._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_3.minimapiconsize = "icon_regular";
  var_3._id_E747 = "current";

  if(isDefined(var_0._id_3BE5)) {
    var_4 = undefined;

    switch (var_0._id_3BE5) {
      case "holdout":
        var_3.label = &"CP_ZMB/OBJECTIVE_HOLDOUT_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("holdout_start_marker", var_3);
        break;
      case "assault":
        var_3.label = &"CP_ZMB/OBJECTIVE_ASSAULT_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("assault_start_marker", var_3);
        break;
      case "orb_follow":
        var_3.label = &"CP_ZMB/OBJECTIVE_ORB_FOLLOW_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("orb_follow_start_marker", var_3);
        break;
      case "domination":
        var_3.label = &"CP_ZMB/OBJECTIVE_DOMINATION_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("domination_start_marker", var_3);
        break;
      case "soul_capture":
        var_3.label = &"CP_ZMB/OBJECTIVE_SOUL_CAPTURE_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("soul_capture_start_marker", var_3);
        break;
      case "exfil":
        var_3.label = &"CP_ZMB/OBJECTIVE_EXFIL_TITLE";
        var_4 = _id_0987::add_instanced_objective_marker("exfil_start_marker", var_3);
        break;
      case "forever_blitz":
        var_3.label = &"CP_ZMB/OBJECTIVE_FOREVER_BLITZ";
        var_4 = _id_0987::add_instanced_objective_marker("forever_blitz_start_marker", var_3);
        break;
    }

    if(!isDefined(var_4)) {
      return;
    } else {
      var_1.startinteractinstanceindex = var_4;
    }
  }
}

remove_start_interact_marker(var_0, var_1) {
  if(isDefined(var_0._id_3BE5) && isDefined(var_1.startinteractinstanceindex)) {
    switch (var_0._id_3BE5) {
      case "holdout":
        _id_0987::remove_instanced_objective_marker("holdout_start_marker", var_1.startinteractinstanceindex);
        break;
      case "assault":
        _id_0987::remove_instanced_objective_marker("assault_start_marker", var_1.startinteractinstanceindex);
        break;
      case "orb_follow":
        _id_0987::remove_instanced_objective_marker("orb_follow_start_marker", var_1.startinteractinstanceindex);
        break;
      case "domination":
        _id_0987::remove_instanced_objective_marker("domination_start_marker", var_1.startinteractinstanceindex);
        break;
      case "soul_capture":
        _id_0987::remove_instanced_objective_marker("soul_capture_start_marker", var_1.startinteractinstanceindex);
        break;
      case "exfil":
        _id_0987::remove_instanced_objective_marker("exfil_start_marker", var_1.startinteractinstanceindex);
        break;
      case "forever_blitz":
        _id_0987::remove_instanced_objective_marker("forever_blitz_start_marker", var_1.startinteractinstanceindex);
        break;
    }

    var_1.startinteractinstanceindex = undefined;
  }
}

toggle_start_interact_markers(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);
  var_2 = get_active_portals(var_1);

  foreach(var_4 in var_2) {
    if(var_0) {
      add_start_interact_marker(var_4._id_82FC, var_4);
    } else {
      remove_start_interact_marker(var_4._id_82FC, var_4);
    }

    waitframe();
  }

  foreach(var_7 in level.active_objective_instances) {
    if(var_7._id_3BE5 == "exfil" && istrue(var_7._id_5713) || var_7._id_3BE5 == "forever_blitz" && istrue(var_7.forever_blitz_ready)) {
      var_8 = undefined;

      if(isDefined(var_7._id_E5F6)) {
        var_8 = var_7._id_E5F6;
      } else if(isDefined(var_7.hub_portal)) {
        var_8 = var_7.hub_portal;
      }

      if(isDefined(var_8)) {
        if(var_0) {
          add_start_interact_marker(var_7, var_8, 65);
        } else if(!istrue(level.b_skip_hide_forever_blitz)) {
          remove_start_interact_marker(var_7, var_8);
        }
      }
    }

    waitframe();
  }
}

hide_portal_clip_at_start() {
  var_0 = getEntArray("portal_clip_hide_at_start", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 _meth_8093();
    var_2 hide();
  }
}

toggle_portal_clip(var_0) {
  self.portal_clip_ent = getent(self.hub_portal + "_clip", "targetname");

  if(!isDefined(self.portal_clip_ent)) {
    return;
  }
  if(var_0) {
    self.portal_clip_ent _meth_80B5();
    self.portal_clip_ent show();
  } else {
    self.portal_clip_ent _meth_8093();
    self.portal_clip_ent hide();
  }
}

toggle_portal_clip_by_name(var_0, var_1) {
  var_2 = getent(var_1 + "_clip", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0) {
    var_2 _meth_80B5();
    var_2 show();
  } else {
    var_2 _meth_8093();
    var_2 hide();
  }
}