/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_convoy_manager.gsc
***********************************************/

function allow_stealing_from_player_car(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.can_steal_hvt = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.can_steal_hvt = var0;
    }

    return;
  }
}

function allow_picking_up_hvts(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.can_pickup_hvt = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.can_pickup_hvt = var0;
    }

    return;
  }
}

function set_hide_icon_on_pickup_target(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.hide_icon_on_pickup = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.hide_icon_on_pickup = var0;
    }

    return;
  }
}

function spawn_convoy_from_type(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var6)) {
    var6 = "axis";
  }

  var8 = level scripts\cp\cp_convoy_manager_code::spawn_convoy(var0, var1, var2, var3, var4, var5, var6, var7);
  return var8;
}

function set_convoy_target(var0, var1, var2, var3) {
  thread scripts\cp\cp_convoy_manager_code::change_convoy_objective_target(var0, var1, var2, var3);
}

function set_convoy_targeted_hvt(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.targeted_hvt = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.targeted_hvt = var0;
    }

    return;
  }
}

function set_roaming(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.roaming = var0;

    if(istrue(var0)) {
      scripts\cp\cp_convoy_manager_code::set_roaming();
      return;
    }

    self notify("reset_path");
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.roaming = var0;

      if(istrue(var0)) {
        var2 scripts\cp\cp_convoy_manager_code::set_roaming();
        continue;
      }

      var2 notify("reset_path");
    }

    return;
  }
}

function ref_130ed(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.ref_13898 = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.ref_13898 = var0;
    }

    return;
  }
}

function set_suspend_at_end_path(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.suspend_at_end_path = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.suspend_at_end_path = var0;
    }

    return;
  }
}

function ref_130fe(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.ref_13f14 = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.ref_13f14 = var0;
    }

    return;
  }
}

function set_use_path_speeds_modifier(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.use_path_speeds = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.use_path_speeds = var0;
    }

    return;
  }
}

function set_path_jitter(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.path_jitter = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.path_jitter = var0;
    }

    return;
  }
}

function set_convoy_durations_modifier(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.cp_speed = var0;

    foreach(var2 in self.spawned_vehicles) {
      if(isent(var2)) {
        var2.cp_speed = var0;
      }
    }

    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var5 in level.all_convoys) {
      foreach(var2 in var5.spawned_vehicles) {
        if(isent(var2)) {
          var2.cp_speed = var0;
        }
      }
    }

    return;
  }
}

function ref_1307d(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::toggle_trucks_disable_leave(var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2 scripts\cp\cp_convoy_manager_code::toggle_trucks_disable_leave(var0);
    }

    return;
  }
}

function attach_smuggler_loot(var0, var1, var2) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_attach(var0, var1, var2);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var4 in level.all_convoys) {
      var4 scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_attach(var0, var1, var2);
    }

    return;
  }
}

function keep_smuggler_loot_on_death(var0, var1, var2) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_drop(var0, var1, var2);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var4 in level.all_convoys) {
      var4 scripts\cp\cp_convoy_manager_code::handle_smuggler_loot_drop(var0, var1, var2);
    }

    return;
  }
}

function get_smuggler_loot_amount(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    if(isDefined(self) && isDefined(self.attached_barrels)) {
      var1 = 0;

      for(var2 = 0; var2 < self.attached_barrels.size; var2++) {
        if(isent(self.attached_barrels[var2])) {
          if(!istrue(var0)) {
            if(!istrue(self.attached_barrels[var2].loot_marked)) {
              var1++;
            }

            continue;
          }

          var1++;
        }
      }

      return var1;
    }
  }

  return undefined;
}

function get_convoy_target() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    return self.target;
  }

  return undefined;
}

function get_convoy_targeted_hvt() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    return self.targeted_hvt;
  }

  return undefined;
}

function set_convoy_lookahead_dist(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.lookahead = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.lookahead = var0;
    }

    return;
  }
}

function set_unload_at_target(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.unload_at_target = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.unload_at_target = var0;
    }

    return;
  }
}

function set_stop_all_cars(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.enable_stop_all_cars = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.enable_stop_all_cars = var0;
    }

    return;
  }
}

function toggle_convoy_wheel_outlines(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    foreach(var2 in self.main_truck.wheel_tags) {
      level thread scripts\cp\cp_convoy_manager_code::toggle_tire_outlines(self.main_truck, var2, var0);
    }

    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var5 in level.all_convoys) {
      if(isDefined(var5.main_truck) && isent(var5.main_truck)) {
        foreach(var2 in var5.main_truck.wheel_tags) {
          level thread scripts\cp\cp_convoy_manager_code::toggle_tire_outlines(var5.main_truck, var2, var0);
        }
      }
    }

    return;
  }
}

function set_attach_objective_icon(var0, var1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.attach_icon = var0;
    scripts\cp\cp_convoy_manager_code::objective_icon_attach_to_center_vehicle(var0, var1);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var3 in level.all_convoys) {
      var3.settings.attach_icon = var0;
      var3 scripts\cp\cp_convoy_manager_code::objective_icon_attach_to_center_vehicle(var0, var1);
    }

    return;
  }
}

function set_objective_icon_label(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::objective_icon_show_label(var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2 scripts\cp\cp_convoy_manager_code::objective_icon_show_label(var0);
    }

    return;
  }
}

function show_objective_icon(var0, var1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::objective_icon_show(var0, var1);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var3 in level.all_convoys) {
      var3 scripts\cp\cp_convoy_manager_code::objective_icon_show(var0, var1);
    }

    return;
  }
}

function show_health_on_objective_icon(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.show_health = var0;
    scripts\cp\cp_convoy_manager_code::objective_icon_show_health(var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.show_health = var0;
      var2 scripts\cp\cp_convoy_manager_code::objective_icon_show_health(var0);
    }

    return;
  }
}

function set_objective_struct(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::objective_icon_override(var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2 scripts\cp\cp_convoy_manager_code::objective_icon_override(var0);
    }

    return;
  }
}

function get_objective_struct() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    return self.convoy_objectivestruct;
  }

  return undefined;
}

function enable_defeat_on_kill_backup(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.defeated_on_kill_backup = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.defeated_on_kill_backup = var0;
    }

    return;
  }
}

function set_soldier_backup_deposit_names(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.backup_deposit_names = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.backup_deposit_names = var0;
    }

    return;
  }
}

function toggle_vo_on_hvt_pickup(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.toggle_vo_on_hvt_pickup = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.toggle_vo_on_hvt_pickup = var0;
    }

    return;
  }
}

function toggle_vo_on_convoy_death(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.toggle_vo_on_convoy_death = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.toggle_vo_on_convoy_death = var0;
    }

    return;
  }
}

function toggle_vo_on_nearby_convoy(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.toggle_vo_on_nearby_convoy = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.toggle_vo_on_nearby_convoy = var0;
    }

    return;
  }
}

function toggle_vo_on_hvt_rescued(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.toggle_vo_on_hvt_rescued = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.toggle_vo_on_hvt_rescued = var0;
    }

    return;
  }
}

function allow_recruiting_nearby_soldiers(var0, var1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_enable = var0;

    if(istrue(var1)) {
      level thread scripts\cp\cp_convoy_manager_code::attempt_new_pulse_set(self);
      return;
    }

    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var3 in level.all_convoys) {
      var3.settings.recruit_enable = var0;

      if(istrue(var1)) {
        level thread scripts\cp\cp_convoy_manager_code::attempt_new_pulse_set(var3);
      }
    }

    return;
  }
}

function allow_recruiting_juggernauts(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_juggs = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.recruit_juggs = var0;
    }

    return;
  }
}

function set_recruited_goal_distance(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.goal_distance = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.goal_distance = var0;
    }

    return;
  }
}

function set_recruiting_distance(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_distance = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.recruit_distance = var0;
    }

    return;
  }
}

function set_recruiting_amount(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_amount = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.recruit_amount = var0;
    }

    return;
  }
}

function set_recruiting_time_btwn(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_time_between = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.recruit_time_between = var0;
    }

    return;
  }
}

function set_recruiting_time_until(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.recruit_time_until = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.recruit_time_until = var0;
    }

    return;
  }
}

function allow_routing_to_any_vehicles(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.route_to_any_veh = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.route_to_any_veh = var0;
    }

    return;
  }
}

function allow_routing_to_backup_vehicles(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.route_to_other_veh = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.route_to_other_veh = var0;
    }

    return;
  }
}

function allow_routing_to_backup_support_vehicles(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.route_to_other_support_veh = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.route_to_other_support_veh = var0;
    }

    return;
  }
}

function set_soldier_pickup_to_origin(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.pickup_uses_origin = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.pickup_uses_origin = var0;
    }

    return;
  }
}

function set_amount_cars_to_compromise(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.amount_to_compromise = var0;
    self.amount_to_compromise_left = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.amount_to_compromise = var0;
      var2.amount_to_compromise_left = var0;
    }

    return;
  }
}

function set_center_compromises(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.center_compromises = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.center_compromises = var0;
    }

    return;
  }
}

function set_can_compromise_before_1st_target(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.can_compromise_before_first_target = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.can_compromise_before_first_target = var0;
    }

    return;
  }
}

function set_compromise_megahealth(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.long_low_health = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.long_low_health = var0;
    }

    return;
  }
}

function set_healthdrain_on_lowhealth(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.health_drain = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.health_drain = var0;
    }

    return;
  }
}

function set_center_hull_invulnerable(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.center_invulnerable = var0;
    self.main_truck.hull_invulnerable = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.center_invulnerable = var0;
      var2.main_truck.hull_invulnerable = var0;
    }

    return;
  }
}

function compromise_center_truck() {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::main_truck_compromise(self);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var1 in level.all_convoys) {
      scripts\cp\cp_convoy_manager_code::main_truck_compromise(var1);
    }

    return;
  }
}

function set_despawn_at_farz(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.distance_z = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.distance_z = var0;
    }

    return;
  }
}

function set_despawn_at_distance(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.despawn_dist_enable = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.despawn_dist_enable = var0;
    }

    return;
  }
}

function set_despawn_distance(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    self.settings.despawn_dist = var0;
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2.settings.despawn_dist = var0;
    }

    return;
  }
}

function delay_kill_convoy_ents(var0, var1) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    if(istrue(var1)) {
      scripts\cp\cp_convoy_manager_code::kill_convoy_all_safe(var0);
      return;
    }

    scripts\cp\cp_convoy_manager_code::kill_convoy_all(self, var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var3 in level.all_convoys) {
      if(istrue(var1)) {
        var3 scripts\cp\cp_convoy_manager_code::kill_convoy_all_safe(var0);
        continue;
      }

      var3 scripts\cp\cp_convoy_manager_code::kill_convoy_all(var3, var0);
    }

    return;
  }
}

function delay_kill_main_truck(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    scripts\cp\cp_convoy_manager_code::kill_main_truck(self, var0);
    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var2 in level.all_convoys) {
      var2 scripts\cp\cp_convoy_manager_code::kill_main_truck(var2, var0);
    }

    return;
  }
}

function delay_kill_convoy_accessories(var0) {
  if(scripts\cp\cp_convoy_manager_code::is_convoy()) {
    for(var1 = 0; var1 < self.spawned_vehicles.size; var1++) {
      if(isalive(self.spawned_vehicles[var1])) {
        self.spawned_vehicles[var1] scripts\cp\cp_convoy_manager_code::delete_accessories(var0);
      }
    }

    return;
  }

  if(isDefined(level.all_convoys) && level.all_convoys.size > 0) {
    foreach(var3 in level.all_convoys) {
      for(var1 = 0; var1 < var3.spawned_vehicles.size; var1++) {
        if(isalive(var3.spawned_vehicles[var1])) {
          var3.spawned_vehicles[var1] scripts\cp\cp_convoy_manager_code::delete_accessories(var0);
        }
      }
    }

    return;
  }
}

function delay_kill_convoy_riders(var0) {
  if(!scripts\cp\cp_convoy_manager_code::is_convoy()) {
    return;
  }
}

function route_towards_exit(var0, var1) {
  if(!scripts\cp\cp_convoy_manager_code::is_convoy()) {
    return;
  }
}