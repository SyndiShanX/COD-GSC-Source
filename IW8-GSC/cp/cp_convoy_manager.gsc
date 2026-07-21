/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_convoy_manager.gsc
***********************************************/

allow_stealing_from_player_car(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.can_steal_hvt = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.can_steal_hvt = var_0;
  }
}

allow_picking_up_hvts(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.can_pickup_hvt = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.can_pickup_hvt = var_0;
  }
}

set_hide_icon_on_pickup_target(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.hide_icon_on_pickup = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.hide_icon_on_pickup = var_0;
  }
}

spawn_convoy_from_type(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_6))
    var_6 = "_encstr_8E8405EA382B2A";

  var_8 = level scripts\cp\cp_convoy_manager_code::spawn_convoy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  return var_8;
}

set_convoy_target(var_0, var_1, var_2, var_3) {
  thread scripts\cp\cp_convoy_manager_code::change_convoy_objective_target(var_0, var_1, var_2, var_3);
}

set_convoy_targeted_hvt(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.targeted_hvt = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.targeted_hvt = var_0;
  }
}

set_roaming(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.roaming = var_0;

    if(istrue(var_0))
      scripts\cp\cp_convoy_manager_code::set_roaming();
    else
      self notify("_encstr_8C9E0BD847079DA879ABD879E1");
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys) {
      var_2.settings.roaming = var_0;

      if(istrue(var_0)) {
        var_2 scripts\cp\cp_convoy_manager_code::set_roaming();
        continue;
      }

      var_2 notify("_encstr_8C9E0BD847079DA879ABD879E1");
    }
  }
}

_id_130ED(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings._id_13898 = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings._id_13898 = var_0;
  }
}

set_suspend_at_end_path(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.suspend_at_end_path = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.suspend_at_end_path = var_0;
  }
}

_id_130FE(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings._id_13F14 = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings._id_13F14 = var_0;
  }
}

set_use_path_speeds_modifier(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.use_path_speeds = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.use_path_speeds = var_0;
  }
}

set_path_jitter(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.path_jitter = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.path_jitter = var_0;
  }
}

set_convoy_durations_modifier(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.cp_speed = var_0;

    foreach(var_2 in self.spawned_vehicles) {
      if(isent(var_2))
        var_2.cp_speed = var_0;
    }
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_5 in level.all_convoys) {
      foreach(var_2 in var_5.spawned_vehicles) {
        if(isent(var_2))
          var_2.cp_speed = var_0;
      }
    }
  }
}

_id_1307D(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::toggle_trucks_disable_leave(var_0);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2 scripts\cp\cp_convoy_manager_code::toggle_trucks_disable_leave(var_0);
  }
}

attach_smuggler_loot(var_0, var_1, var_2) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_attach(var_0, var_1, var_2);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_4 in level.all_convoys)
    var_4 scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_attach(var_0, var_1, var_2);
  }
}

keep_smuggler_loot_on_death(var_0, var_1, var_2) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_drop(var_0, var_1, var_2);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_4 in level.all_convoys)
    var_4 scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_drop(var_0, var_1, var_2);
  }
}

get_smuggler_loot_amount(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    if(isDefined(self) && isDefined(self.attached_barrels)) {
      var_1 = 0;

      for(var_2 = 0; var_2 < self.attached_barrels.size; var_2++) {
        if(isent(self.attached_barrels[var_2])) {
          if(!istrue(var_0)) {
            if(!istrue(self.attached_barrels[var_2].loot_marked))
              var_1++;

            continue;
          }

          var_1++;
        }
      }

      return var_1;
    }
  }

  return undefined;
}

get_convoy_target() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    return self.target;

  return undefined;
}

get_convoy_targeted_hvt() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    return self.targeted_hvt;

  return undefined;
}

set_convoy_lookahead_dist(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.lookahead = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.lookahead = var_0;
  }
}

set_unload_at_target(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.unload_at_target = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.unload_at_target = var_0;
  }
}

set_stop_all_cars(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.enable_stop_all_cars = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.enable_stop_all_cars = var_0;
  }
}

toggle_convoy_wheel_outlines(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    foreach(var_2 in self.main_truck.wheel_tags)
    level thread scripts\cp\cp_convoy_manager_code::toggle_tire_outlines(self.main_truck, var_2, var_0);
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_5 in level.all_convoys) {
      if(isDefined(var_5.main_truck) && isent(var_5.main_truck)) {
        foreach(var_2 in var_5.main_truck.wheel_tags)
        level thread scripts\cp\cp_convoy_manager_code::toggle_tire_outlines(var_5.main_truck, var_2, var_0);
      }
    }
  }
}

set_attach_objective_icon(var_0, var_1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.attach_icon = var_0;
    scripts\cp\cp_convoy_manager_code::objective_icon_attach_to_center_vehicle(var_0, var_1);
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_3 in level.all_convoys) {
      var_3.settings.attach_icon = var_0;
      var_3 scripts\cp\cp_convoy_manager_code::objective_icon_attach_to_center_vehicle(var_0, var_1);
    }
  }
}

set_objective_icon_label(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::objective_icon_show_label(var_0);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2 scripts\cp\cp_convoy_manager_code::objective_icon_show_label(var_0);
  }
}

show_objective_icon(var_0, var_1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::objective_icon_show(var_0, var_1);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_3 in level.all_convoys)
    var_3 scripts\cp\cp_convoy_manager_code::objective_icon_show(var_0, var_1);
  }
}

show_health_on_objective_icon(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.show_health = var_0;
    scripts\cp\cp_convoy_manager_code::objective_icon_show_health(var_0);
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys) {
      var_2.settings.show_health = var_0;
      var_2 scripts\cp\cp_convoy_manager_code::objective_icon_show_health(var_0);
    }
  }
}

set_objective_struct(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::objective_icon_override(var_0);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2 scripts\cp\cp_convoy_manager_code::objective_icon_override(var_0);
  }
}

get_objective_struct() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    return self.convoy_objectivestruct;

  return undefined;
}

enable_defeat_on_kill_backup(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.defeated_on_kill_backup = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.defeated_on_kill_backup = var_0;
  }
}

set_soldier_backup_deposit_names(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.backup_deposit_names = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.backup_deposit_names = var_0;
  }
}

toggle_vo_on_hvt_pickup(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.toggle_vo_on_hvt_pickup = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.toggle_vo_on_hvt_pickup = var_0;
  }
}

toggle_vo_on_convoy_death(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.toggle_vo_on_convoy_death = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.toggle_vo_on_convoy_death = var_0;
  }
}

toggle_vo_on_nearby_convoy(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.toggle_vo_on_nearby_convoy = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.toggle_vo_on_nearby_convoy = var_0;
  }
}

toggle_vo_on_hvt_rescued(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.toggle_vo_on_hvt_rescued = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.toggle_vo_on_hvt_rescued = var_0;
  }
}

allow_recruiting_nearby_soldiers(var_0, var_1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_enable = var_0;

    if(istrue(var_1))
      level thread scripts\cp\cp_convoy_manager_code::attempt_new_pulse_set(self);
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_3 in level.all_convoys) {
      var_3.settings.recruit_enable = var_0;

      if(istrue(var_1))
        level thread scripts\cp\cp_convoy_manager_code::attempt_new_pulse_set(var_3);
    }
  }
}

allow_recruiting_juggernauts(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.recruit_juggs = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.recruit_juggs = var_0;
  }
}

set_recruited_goal_distance(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.goal_distance = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.goal_distance = var_0;
  }
}

set_recruiting_distance(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.recruit_distance = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.recruit_distance = var_0;
  }
}

set_recruiting_amount(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.recruit_amount = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.recruit_amount = var_0;
  }
}

set_recruiting_time_btwn(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.recruit_time_between = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.recruit_time_between = var_0;
  }
}

set_recruiting_time_until(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.recruit_time_until = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.recruit_time_until = var_0;
  }
}

allow_routing_to_any_vehicles(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.route_to_any_veh = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.route_to_any_veh = var_0;
  }
}

allow_routing_to_backup_vehicles(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.route_to_other_veh = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.route_to_other_veh = var_0;
  }
}

allow_routing_to_backup_support_vehicles(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.route_to_other_support_veh = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.route_to_other_support_veh = var_0;
  }
}

set_soldier_pickup_to_origin(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.pickup_uses_origin = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.pickup_uses_origin = var_0;
  }
}

set_amount_cars_to_compromise(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.amount_to_compromise = var_0;
    self.amount_to_compromise_left = var_0;
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys) {
      var_2.settings.amount_to_compromise = var_0;
      var_2.amount_to_compromise_left = var_0;
    }
  }
}

set_center_compromises(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.center_compromises = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.center_compromises = var_0;
  }
}

set_can_compromise_before_1st_target(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.can_compromise_before_first_target = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.can_compromise_before_first_target = var_0;
  }
}

set_compromise_megahealth(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.long_low_health = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.long_low_health = var_0;
  }
}

set_healthdrain_on_lowhealth(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.health_drain = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.health_drain = var_0;
  }
}

set_center_hull_invulnerable(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.center_invulnerable = var_0;
    self.main_truck.hull_invulnerable = var_0;
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys) {
      var_2.settings.center_invulnerable = var_0;
      var_2.main_truck.hull_invulnerable = var_0;
    }
  }
}

compromise_center_truck() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::main_truck_compromise(self);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_1 in level.all_convoys)
    scripts\cp\cp_convoy_manager_code::main_truck_compromise(var_1);
  }
}

set_despawn_at_farz(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.distance_z = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.distance_z = var_0;
  }
}

set_despawn_at_distance(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.despawn_dist_enable = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.despawn_dist_enable = var_0;
  }
}

set_despawn_distance(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    self.settings.despawn_dist = var_0;
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2.settings.despawn_dist = var_0;
  }
}

delay_kill_convoy_ents(var_0, var_1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    if(istrue(var_1))
      scripts\cp\cp_convoy_manager_code::kill_convoy_all_safe(var_0);
    else
      scripts\cp\cp_convoy_manager_code::kill_convoy_all(self, var_0);
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_3 in level.all_convoys) {
      if(istrue(var_1)) {
        var_3 scripts\cp\cp_convoy_manager_code::kill_convoy_all_safe(var_0);
        continue;
      }

      var_3 scripts\cp\cp_convoy_manager_code::kill_convoy_all(var_3, var_0);
    }
  }
}

delay_kill_main_truck(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy())
    scripts\cp\cp_convoy_manager_code::kill_main_truck(self, var_0);
  else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_2 in level.all_convoys)
    var_2 scripts\cp\cp_convoy_manager_code::kill_main_truck(var_2, var_0);
  }
}

delay_kill_convoy_accessories(var_0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    for(var_1 = 0; var_1 < self.spawned_vehicles.size; var_1++) {
      if(isalive(self.spawned_vehicles[var_1]))
        self.spawned_vehicles[var_1] scripts\cp\cp_convoy_manager_code::delete_accessories(var_0);
    }
  } else if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var_3 in level.all_convoys) {
      for(var_1 = 0; var_1 < var_3.spawned_vehicles.size; var_1++) {
        if(isalive(var_3.spawned_vehicles[var_1]))
          var_3.spawned_vehicles[var_1] scripts\cp\cp_convoy_manager_code::delete_accessories(var_0);
      }
    }
  }
}

delay_kill_convoy_riders(var_0) {
  if(!scripts\cp\cp_convoy_manager_code::is_convoy())
    return;
}

route_towards_exit(var_0, var_1) {
  if(!scripts\cp\cp_convoy_manager_code::is_convoy())
    return;
}