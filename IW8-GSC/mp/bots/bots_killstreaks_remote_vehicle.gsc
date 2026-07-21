/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_killstreaks_remote_vehicle.gsc
*******************************************************/

remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized))
    wait 0.05;

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }
  level.bot_ks_heli_offset["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = (0, 0, 350);
  level.bot_ks_heli_offset["_encstr_86670C1ACAD896D76EE62D83AC39"] = (0, 0, 228);
  level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_96B30D67CDC2C06FB60B1F216F8863"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_8C8E0D47314312AF704BC2CA2050CC"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_8C7F143F48D88CCAD136154E2DE3C123C0F0A7ABA0D3"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_AB49096BB878DFEB03FED7"] = ::isusingvanguard;
  level.bot_ks_funcs["_encstr_AC7D16C8F719E381F24561E01CDAE3AB718F981147A79979"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = ::heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["_encstr_AC7D16C8F719E381F24561E01CDAE3AB718F981147A79979"]["_encstr_86670C1ACAD896D76EE62D83AC39"] = ::heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["_encstr_85070FB7E737734250A8C94E2068910A6C"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = ::heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["_encstr_85070FB7E737734250A8C94E2068910A6C"]["_encstr_86670C1ACAD896D76EE62D83AC39"] = scripts\engine\utility::empty_init_func;
  level.bot_ks_funcs["_encstr_85070FB7E737734250A8C94E2068910A6C"]["_encstr_AB49096BB878DFEB03FED7"] = ::vanguard_control_aiming;
  level.bot_ks_funcs["_encstr_9BD60E1BA708634B308D616A2B9B2F5A"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = ::heli_pilot_monitor_flares;
  level.bot_ks_funcs["_encstr_A6B60F139838D1492173160C70350264A1"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = ::heli_pilot_pick_node;
  level.bot_ks_funcs["_encstr_A6B60F139838D1492173160C70350264A1"]["_encstr_86670C1ACAD896D76EE62D83AC39"] = ::heli_sniper_pick_node;
  level.bot_ks_funcs["_encstr_A6B60F139838D1492173160C70350264A1"]["_encstr_AB49096BB878DFEB03FED7"] = ::vanguard_pick_node;
  level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = ::heli_get_node_origin;
  level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"]["_encstr_86670C1ACAD896D76EE62D83AC39"] = ::heli_get_node_origin;
  level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"]["_encstr_AB49096BB878DFEB03FED7"] = ::vanguard_get_node_origin;
  level.bot_ks_funcs["_encstr_A2C314658D132297C3F8137B90BB6DF9DB962B1CE0B5"]["_encstr_96B30D67CDC2C06FB60B1F216F8863"] = ::odin_assault_perform_action;
  level.bot_ks_funcs["_encstr_A2C314658D132297C3F8137B90BB6DF9DB962B1CE0B5"]["_encstr_8C8E0D47314312AF704BC2CA2050CC"] = ::odin_support_perform_action;
  level.bot_ks_funcs["_encstr_B40410DE32B4CDEB9D951DBE8EC2C9D99547"]["_encstr_96B30D67CDC2C06FB60B1F216F8863"] = ::odin_assault_get_target;
  level.bot_ks_funcs["_encstr_B40410DE32B4CDEB9D951DBE8EC2C9D99547"]["_encstr_8C8E0D47314312AF704BC2CA2050CC"] = ::odin_support_get_target;
  var_0 = scripts\engine\utility::getStructArray("_encstr_8D6E1CF8D7B05E0CCDFB28A733D83B675BCB89F0CEB3236F9BA3A85D1159", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.bot_heli_nodes = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkname))
      level.bot_heli_nodes = scripts\engine\utility::array_add(level.bot_heli_nodes, var_2);
  }

  level.bot_heli_pilot_traceoffset = scripts\mp\utility\killstreak::gethelipilottraceoffset();

  foreach(var_5 in level.bot_heli_nodes) {
    var_5.vanguard_origin = var_5.origin;
    var_6 = var_5.origin + (0, 0, 50);
    var_5.valid_for_vanguard = 1;

    if(var_6[2] <= var_5.origin[2] - 1000)
      var_5.valid_for_vanguard = 0;

    var_6 = var_6 - (0, 0, 50);
    var_5.vanguard_origin = var_6;
  }

  var_8 = -99999999;

  foreach(var_5 in level.bot_heli_nodes)
  var_8 = max(var_8, var_5.origin[2]);

  level.bot_vanguard_height_trace_size = var_8 - level.bot_map_min_z + 100;
  level.heli_pilot_missile_radius = getdvarfloat("_encstr_A94F0BA796A61413E96A8A93A9");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min))
    wait 0.05;

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc))
    var_11 = [[level.teleportgetactivepathnodezonesfunc]]();
  else {
    var_11 = [];

    for(var_12 = 0; var_12 < level.zonecount; var_12++)
      var_11[var_11.size] = var_12;
  }

  foreach(var_14 in var_11) {
    if(botzonegetindoorpercent(var_14) < 0.25)
      level.outside_zones = scripts\engine\utility::array_add(level.outside_zones, var_14);
  }

  level.bot_odin_time_to_move["_encstr_889F0893CA6CC9BA2D8E"] = 1.0;
  level.bot_odin_time_to_move["_encstr_813008928DA89D31A8CA"] = 0.7;
  level.bot_odin_time_to_move["_encstr_A7D409342C272359DC59C8"] = 0.4;
  level.bot_odin_time_to_move["_encstr_BAAF081BD348D7E299C8"] = 0.05;
  level.bot_initialized_remote_vehicles = 1;
}

bot_killstreak_remote_control(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    return 0;

  var_5 = 1;
  var_6 = 1;
  var_7 = undefined;

  if(isDefined(self.node_ambushing_from)) {
    var_8 = self botgetscriptgoalRadius();
    var_9 = distancesquared(self.origin, self.node_ambushing_from.origin);

    if(var_9 < squared(var_8)) {
      var_5 = 0;
      var_6 = 0;
    } else if(var_9 < squared(200))
      var_5 = 0;
  }

  var_10 = var_0.streakname == "_encstr_AB49096BB878DFEB03FED7" && is_indoor_map();

  if(var_10 || var_5) {
    var_11 = getnodesinradius(self.origin, 500, 0, 512);

    if(isDefined(var_11) && var_11.size > 0) {
      if(isDefined(var_4) && var_4) {
        var_12 = var_11;
        var_11 = [];

        foreach(var_14 in var_12) {
          if(nodeexposedtosky(var_14)) {
            var_15 = getlinkednodes(var_14);
            var_16 = 0;

            foreach(var_18 in var_15) {
              if(nodeexposedtosky(var_18))
                var_16++;
            }

            if(var_16 / var_15.size > 0.5)
              var_11 = scripts\engine\utility::array_add(var_11, var_14);
          }
        }
      }

      if(var_10) {
        var_21 = self botnodescoremultiple(var_11, "_encstr_81D70DCDED23B2F556E183DB9BB28C");

        foreach(var_14 in var_21) {
          if(scripts\engine\trace::_bullet_trace_passed(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          wait 0.05;
        }
      } else if(var_11.size > 0)
        var_7 = self botnodepick(var_11, min(3, var_11.size), "_encstr_8E210AB9ED8C56F51AA53259");

      if(!isDefined(var_7))
        return 0;

      self botsetscriptgoalnode(var_7, "_encstr_99C209E34FC743616118AB");
    }
  }

  if(var_6) {
    var_24 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(var_24 != "_encstr_8B7205D9ED5958") {
      try_clear_hide_goal(var_7);
      return 1;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    try_clear_hide_goal(var_7);
    return 0;
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(var_7);
    return 1;
  }

  if(!isDefined(var_7)) {
    if(self getstance() == "_encstr_922406F1A6FD5E05")
      self botsetstance("_encstr_922406F1A6FD5E05");
    else if(self getstance() == "_encstr_B13D076BED70539F23")
      self botsetstance("_encstr_B13D076BED70539F23");
  } else if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0) {
    if(randomint(100) > 50)
      self botsetstance("_encstr_922406F1A6FD5E05");
    else
      self botsetstance("_encstr_B13D076BED70539F23");
  }

  scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  self.vehicle_controlling = undefined;
  self thread[[var_3]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(var_7);
  self waittill("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  return 1;
}

bot_end_control_on_respawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

bot_end_control_watcher(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  try_clear_hide_goal(var_0);
  self botsetstance("_encstr_8BBA05185F8B99");
  self botsetscriptmove(0, 0);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  self botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 0);
  self.vehicle_controlling = undefined;
}

try_clear_hide_goal(var_0) {
  if(isDefined(var_0) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == var_0)
    self botclearscriptgoal();
}

bot_end_control_on_vehicle_death(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

bot_waittill_using_vehicle(var_0) {
  var_1 = gettime();

  while(!self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"][var_0]]]()) {
    wait 0.05;

    if(gettime() - var_1 > 5000)
      return 0;
  }

  return 1;
}

bot_control_switchblade_cluster() {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  childthread handle_disable_rotation();
  var_0 = bot_waittill_using_vehicle("_encstr_8C7F143F48D88CCAD136154E2DE3C123C0F0A7ABA0D3");

  if(!var_0)
    self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");

  thread switchblade_handle_awareness();
  var_1 = find_cluster_rocket_for_bot(self);
  wait 0.1;
  self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 256000000;
  thread watch_end_switchblade();
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = [];
  var_6 = undefined;
  var_7 = 0;
  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = is_indoor_map();

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_8C7F143F48D88CCAD136154E2DE3C123C0F0A7ABA0D3"]]]() && isDefined(var_1)) {
    foreach(var_14 in level.rockets) {
      if(isDefined(var_14) && var_14.owner == self && var_14.weapon_name == "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0") {
        var_15 = 1;

        foreach(var_17 in var_5) {
          if(var_17.rocket == var_14)
            var_15 = 0;
        }

        if(var_15) {
          var_19 = spawnStruct();
          var_19.rocket = var_14;
          var_19.target = var_6;
          var_6 = undefined;
          var_5 = scripts\engine\utility::array_add(var_5, var_19);
        }
      }
    }

    for(var_21 = 0; var_21 < var_5.size; var_21++) {
      var_17 = var_5[var_21];

      if(isDefined(var_17) && isDefined(var_17.rocket) && !scripts\engine\utility::array_contains(level.rockets, var_17.rocket)) {
        var_5[var_21] = var_5[var_5.size - 1];
        var_5[var_5.size - 1] = undefined;
        var_21--;
      }
    }

    if(var_11) {
      wait 0.05;
      continue;
    }

    var_22 = undefined;

    if(isDefined(var_10)) {
      var_22 = var_10;

      if(!isalive(var_10) || !self botcanseeentity(var_22)) {
        if(!isalive(var_10))
          var_11 = 1;

        wait 0.05;
        continue;
      }
    }

    var_23 = [];

    if(!isDefined(var_22)) {
      var_24 = bot_killstreak_get_all_outside_enemies(0);
      var_25 = [];

      foreach(var_17 in var_5) {
        if(isDefined(var_17.target))
          var_25 = scripts\engine\utility::array_add(var_25, var_17.target);
      }

      var_24 = scripts\engine\utility::array_remove_array(var_24, var_25);

      foreach(var_29 in var_24) {
        if(var_29 scripts\mp\utility\perk::_hasperk("_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D")) {
          continue;
        }
        if(self botcanseeentity(var_29) || var_12 && scripts\engine\utility::within_fov(self getEye(), var_1.angles, var_29.origin, self botgetfovdot())) {
          if(!bot_body_is_dead() && distancesquared(var_29.origin, self.origin) < 40000) {
            continue;
          }
          var_23 = scripts\engine\utility::array_add(var_23, var_29);

          if(!isDefined(var_22)) {
            var_22 = var_29;
            continue;
          }

          var_30 = vectorNormalize(var_22.origin - var_1.origin);
          var_31 = vectorNormalize(var_29.origin - var_1.origin);
          var_32 = anglesToForward(var_1.angles);
          var_33 = vectordot(var_30, var_32);
          var_34 = vectordot(var_31, var_32);

          if(var_34 > var_33)
            var_22 = var_29;
        }
      }
    }

    if(isDefined(var_22)) {
      var_2 = undefined;
      var_36 = var_1.origin[2] - var_22.origin[2];
      var_37 = self botgetdifficulty();

      if(var_37 == "_encstr_889F0893CA6CC9BA2D8E")
        var_9 = var_22.origin;
      else if(var_36 < 5000)
        var_9 = var_22.origin;
      else if(length(var_22 getentityvelocity()) < 25)
        var_9 = var_22.origin;
      else if(gettime() - var_8 > 500) {
        var_8 = gettime();
        var_38 = 3.0;

        if(var_37 == "_encstr_813008928DA89D31A8CA")
          var_38 = 1.0;

        var_9 = getpredictedentityposition(var_22, var_38);
      }

      var_39 = missile_get_desired_angles_to_target(var_1, var_9);
      var_40 = missile_get_distance_to_target(var_1, var_9);

      if(var_40 < 30)
        var_41 = 0.0;
      else if(var_40 < 100)
        var_41 = 0.15;
      else if(var_40 < 200)
        var_41 = 0.3;
      else if(var_40 < 400)
        var_41 = 0.6;
      else
        var_41 = 1.0;

      if(var_7)
        var_41 = min(var_41 * 3, 1.0);

      if(var_41 > 0)
        self botsetscriptmove(var_39[1], 0.05, var_41, 1, 1);
      else if(gettime() > var_4) {
        if(var_3 < 2) {
          self botpressbutton("_encstr_999A07C61338F9A23A");
          var_3++;
          var_4 = gettime() + 200;

          if(var_37 == "_encstr_813008928DA89D31A8CA" && var_3 == 2 || var_37 == "_encstr_A7D409342C272359DC59C8" || var_37 == "_encstr_BAAF081BD348D7E299C8") {
            var_42 = var_3 == 1 && var_23.size == 1;

            if(!var_42) {
              var_6 = var_22;
              var_4 = var_4 + 800;
            }
          }
        } else if(!var_7 && (var_36 < 5000 || var_37 == "_encstr_889F0893CA6CC9BA2D8E")) {
          var_7 = 1;
          self botpressbutton("_encstr_999A07C61338F9A23A");

          if(var_37 == "_encstr_889F0893CA6CC9BA2D8E")
            var_10 = var_22;
        }
      }
    } else {
      if(!isDefined(var_2))
        var_2 = scripts\engine\utility::random(level.outside_zones);

      var_43 = getzonenodeforindex(var_2).origin;

      if(missile_get_distance_to_target(var_1, var_43) < 200) {
        var_2 = scripts\engine\utility::random(level.outside_zones);
        var_43 = getzonenodeforindex(var_2).origin;
      }

      var_39 = missile_get_desired_angles_to_target(var_1, var_43);
      self botsetscriptmove(var_39[1], 0.05, 0.75, 1, 1);
    }

    wait 0.05;
  }

  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

missile_get_desired_angles_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  var_3 = vectorNormalize(var_1 - var_2);
  return vectortoangles(var_3);
}

missile_get_distance_to_target(var_0, var_1) {
  var_2 = missile_find_ground_target(var_0, var_1[2]);
  return distance(var_2, var_1);
}

handle_disable_rotation() {
  self botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 1);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
  find_cluster_rocket_for_bot(self);
  self botsetflag("_encstr_BE321128AF7B29C53AAF40DE05930B33D91FE0", 0);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
}

switchblade_handle_awareness() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self botsetawareness(2.5);
  self waittill("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  self botsetawareness(1.0);
}

missile_find_ground_target(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = (var_1 - var_0.origin[2]) / var_2[2];
  var_4 = var_0.origin + var_2 * var_3;
  return var_4;
}

watch_end_switchblade() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

find_cluster_rocket_for_bot(var_0) {
  for(;;) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2) && var_2.owner == var_0)
        return var_2;
    }

    wait 0.05;
  }
}

vanguard_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  if(scripts\mp\bots\bots_killstreaks::iskillstreakblockedforbots("_encstr_AB49096BB878DFEB03FED7"))
    return 0;

  return 1;
}

bot_killstreak_vanguard_start(var_0, var_1, var_2, var_3) {
  bot_killstreak_remote_control(var_0, var_1, var_2, var_3, 1);
}

isusingvanguard() {
  return scripts\mp\utility\player::isusingremote() && self.usingremote == "_encstr_AB49096BB878DFEB03FED7" && isDefined(self.remoteuav);
}

bot_control_vanguard() {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = bot_waittill_using_vehicle("_encstr_AB49096BB878DFEB03FED7");

  if(!var_0)
    self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");

  self.vehicle_controlling = self.remoteuav;
  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("_encstr_AD75063D571AE108");
  wait 0.5;
  var_1 = 0;
  var_2 = !self.vehicle_controlling vanguard_is_outside();
  var_3 = undefined;
  var_4 = 0;
  var_5 = is_indoor_map();

  while(var_2 && !var_5) {
    var_6 = getnodesinradiussorted(self.vehicle_controlling.origin, 1024, 64, 512, "_encstr_8F0D0583C21D43");

    if(isDefined(var_3))
      var_6 = scripts\engine\utility::array_remove(var_6, var_3);

    foreach(var_8 in var_6) {
      if(node_is_valid_outside_for_vanguard(var_8)) {
        var_3 = var_8;
        break;
      }

      wait 0.05;
      var_1 = var_1 + 0.05;
    }

    if(var_1 < 1.0)
      wait(1.0 - var_1);

    if(!isDefined(var_3)) {
      self botpressbutton("_encstr_AB19049D0FC0", 4.0);
      wait 4.0;
    }

    var_10 = scripts\mp\bots\bots_util::bot_queued_process("_encstr_A2EF178927C46477E2C72E281D79B3EB30133058877DD9058A", scripts\mp\bots\bots_util::func_get_nodes_on_path, self.vehicle_controlling.origin, var_3.origin);

    if(!isDefined(var_10)) {
      if(var_4 == 0) {
        var_4++;
        wait 0.05;
        continue;
      } else {
        self botpressbutton("_encstr_AB19049D0FC0", 4.0);
        wait 4.0;
      }
    }

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = var_10[var_11];

      if(var_11 == 0 && distancesquared(self.origin, var_12.origin) < 1600) {
        continue;
      }
      var_13 = 32;

      if(var_11 == var_10.size - 1)
        var_13 = 16;

      var_14 = self.vehicle_controlling.origin;
      var_15 = gettime() + 2500;

      while(distance2dsquared(var_12.origin, self.vehicle_controlling.origin) > var_13 * var_13) {
        if(self.vehicle_controlling vanguard_is_outside()) {
          var_11 = var_10.size;
          break;
        }

        if(gettime() > var_15) {
          var_15 = gettime() + 2500;
          var_16 = distancesquared(self.vehicle_controlling.origin, var_14);

          if(var_16 < 1.0) {
            var_11++;
            break;
          }

          var_14 = self.vehicle_controlling.origin;
        }

        var_17 = vectorNormalize(var_12.origin - self.vehicle_controlling.origin);
        self botsetscriptmove(vectortoangles(var_17)[1], 0.2);
        self botlookatpoint(var_12.origin, 0.2, "_encstr_A7300E08584D77DBA497CF3FC5432757");
        var_18 = var_12.origin[2] + 64;
        var_19 = var_18 - self.vehicle_controlling.origin[2];

        if(var_19 > 10)
          self botpressbutton("_encstr_B116071BCAD186858D");
        else if(var_19 < -10)
          self botpressbutton("_encstr_99C209E34FC743616118AB");

        wait 0.05;
      }
    }

    var_2 = 0;

    if(!self.vehicle_controlling vanguard_is_outside())
      var_2 = 1;
  }

  self botsetscriptmove(0, 0);
  self botlookatpoint(undefined);
  self childthread[[level.bot_ks_funcs["_encstr_85070FB7E737734250A8C94E2068910A6C"]["_encstr_AB49096BB878DFEB03FED7"]]]();
  var_21 = self.vehicle_controlling.origin[2];
  var_22 = undefined;
  var_23 = gettime() + 2000;
  var_24 = [];
  var_24[0] = (1, 0, 0);
  var_24[1] = (-1, 0, 0);
  var_24[2] = (0, 1, 0);
  var_24[3] = (0, -1, 0);
  var_24[4] = (1, 1, 0);
  var_24[5] = (1, -1, 0);
  var_24[6] = (-1, 1, 0);
  var_24[7] = (-1, -1, 0);
  var_25 = find_closest_heli_node_2d(self.vehicle_controlling.origin, "_encstr_AB49096BB878DFEB03FED7");

  while(var_25.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20) {
    if(gettime() > var_23) {
      var_23 = gettime() + 2000;

      if(isDefined(var_22))
        var_22 = undefined;
      else {
        var_19 = self.vehicle_controlling.origin[2] - var_21;

        if(var_19 < 20 && !var_5) {
          var_26 = scripts\engine\utility::array_randomize(var_24);

          foreach(var_28 in var_26) {
            if(pos_passes_sky_trace(self.vehicle_controlling.origin + var_28 * 64)) {
              if(!scripts\engine\trace::_bullet_trace_passed(self.vehicle_controlling.origin, self.vehicle_controlling.origin + var_28 * 64, 0, self.vehicle_controlling)) {
                wait 0.05;
                continue;
              }

              var_22 = var_28;
              break;
            }

            wait 0.05;
          }
        }
      }

      var_21 = self.vehicle_controlling.origin[2];
    }

    if(isDefined(var_22)) {
      self botsetscriptmove(vectortoangles(var_22)[1], 0.05);

      if(scripts\engine\utility::cointoss())
        self botpressbutton("_encstr_99C209E34FC743616118AB");
    } else
      self botpressbutton("_encstr_B116071BCAD186858D");

    wait 0.05;
  }

  wait 1.0;
  wait 1.0;
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
  bot_control_heli_main_move_loop("_encstr_AB49096BB878DFEB03FED7", 0);
  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

pos_is_valid_outside_for_vanguard(var_0) {
  var_1 = getclosestnodeinsight(var_0);

  if(isDefined(var_1))
    return node_is_valid_outside_for_vanguard(var_1);

  return 0;
}

node_is_valid_outside_for_vanguard(var_0) {
  if(nodeexposedtosky(var_0))
    return pos_passes_sky_trace(var_0.origin);

  return 0;
}

pos_passes_sky_trace(var_0) {
  var_1 = var_0;
  var_2 = var_0 + (0, 0, level.bot_vanguard_height_trace_size);

  if(var_2[2] <= var_1[2])
    return 0;

  var_3 = scripts\engine\trace::_bullet_trace_passed(var_1, var_2, 0, undefined);
  return var_3;
}

vanguard_is_outside() {
  var_0 = getclosestnodeinsight(self.origin);

  if(isDefined(var_0) && !nodeexposedtosky(var_0))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (18, 0, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (-18, 0, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, 18, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, -18, 25)))
    return 0;

  return 1;
}

vanguard_control_aiming() {
  self notify("_encstr_92E118133A8329555F32292713DD6AC3BB0753AF2BA0A553D8B2");
  self endon("_encstr_92E118133A8329555F32292713DD6AC3BB0753AF2BA0A553D8B2");
  var_0 = undefined;
  var_1 = 0;
  var_2 = gettime();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_AB49096BB878DFEB03FED7"]]]()) {
    var_6 = undefined;
    var_7 = self getEye();
    var_8 = self getplayerangles();
    var_9 = self botgetfovdot();

    if(isalive(self.enemy) && self botcanseeentity(self.enemy)) {
      var_10 = 1;
      var_6 = self.enemy;
      var_5 = 0;
    } else if(var_5 < 10.0) {
      foreach(var_12 in level.characters) {
        if(var_12 == self || !isalive(var_12)) {
          continue;
        }
        if(var_12 scripts\mp\utility\perk::_hasperk("_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D")) {
          continue;
        }
        if(!isDefined(var_12.team)) {
          continue;
        }
        if(!level.teambased || self.team != var_12.team) {
          if(scripts\engine\utility::within_fov(var_7, var_8, var_12.origin, var_9)) {
            var_5 = var_5 + 0.05;

            if(isDefined(var_6)) {
              var_13 = distancesquared(self.vehicle_controlling.origin, var_6.origin);
              var_14 = distancesquared(self.vehicle_controlling.origin, var_12.origin);

              if(var_14 < var_13)
                var_6 = var_12;

              continue;
            }

            var_6 = var_12;
          }
        }
      }
    }

    if(isDefined(var_6)) {
      if((isai(var_6) || isPlayer(var_6)) && length(var_6 getentityvelocity()) < 25)
        var_0 = var_6.origin;
      else if(gettime() - var_3 < 500) {
        if(var_4 != var_6)
          var_0 = var_6.origin;
      } else if(gettime() - var_3 > 500) {
        var_3 = gettime();
        var_0 = getpredictedentityposition(var_6, 3.0);
        var_4 = var_6;
      }

      var_16 = 165;

      if(gettime() - var_2 > 10000)
        var_16 = 200;

      if(distancesquared(self.vehicle_controlling.attackarrow.origin, var_0) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          var_2 = gettime();
          self botpressbutton("_encstr_999A07C61338F9A23A");
        }
      }
    } else if(gettime() > var_1) {
      var_1 = gettime() + randomintrange(1000, 2000);
      var_0 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    if(length(var_0) == 0)
      var_0 = (0, 0, 10);

    self botlookatpoint(var_0, 0.2, "_encstr_A7300E08584D77DBA497CF3FC5432757");
    wait 0.05;
  }
}

vanguard_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = [[level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"]["_encstr_AB49096BB878DFEB03FED7"]]](var_0);
  var_2 = bot_vanguard_find_unvisited_nodes(var_0);
  var_3 = var_2;
  var_2 = [];

  foreach(var_5 in var_3) {
    if(var_5.valid_for_vanguard) {
      if(var_0.origin[2] != var_0.vanguard_origin[2] || var_5.origin[2] != var_5.vanguard_origin[2]) {
        var_6 = [[level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"]["_encstr_AB49096BB878DFEB03FED7"]]](var_5);
        var_7 = playerphysicstrace(var_1, var_6);

        if(distancesquared(var_7, var_6) < 1)
          var_2 = scripts\engine\utility::array_add(var_2, var_5);

        wait 0.05;
        continue;
      }

      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  if(var_2.size == 0 && var_3.size > 0) {
    foreach(var_5 in var_3)
    var_5.bot_visited_times[self.entity_number]++;
  }

  return heli_pick_node_furthest_from_center(var_2, "_encstr_AB49096BB878DFEB03FED7");
}

bot_vanguard_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname) && var_4.valid_for_vanguard) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

vanguard_get_node_origin(var_0) {
  return var_0.vanguard_origin;
}

origin_is_valid_for_vanguard(var_0) {
  var_1 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 delete();
  return var_1;
}

heli_sniper_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  return 1;
}

heli_sniper_waittill_initial_goal() {
  self.vehicle_controlling waittill("_encstr_B4D10ADC950BE4EB76DE8536");
}

bot_control_heli_sniper() {
  thread heli_sniper_clear_script_goal_on_ride();
  bot_control_heli("_encstr_86670C1ACAD896D76EE62D83AC39");
}

heli_sniper_clear_script_goal_on_ride() {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botclearscriptgoal();
}

heli_sniper_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  return heli_pick_node_furthest_from_center(var_1, "_encstr_86670C1ACAD896D76EE62D83AC39");
}

heli_pilot_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  if(scripts\mp\killstreaks\helicopter_pilot::exceededmaxhelipilots(self.team))
    return 0;

  return 1;
}

heli_pilot_waittill_initial_goal() {
  self.vehicle_controlling waittill("_encstr_A3130D9AF069D2310E87C1D9C03A82");
}

bot_control_heli_pilot() {
  bot_control_heli("_encstr_9B100BD059D8A5D7C1B4C6B7D1");
}

heli_pilot_pick_node(var_0) {
  var_0.bot_visited_times[self.entity_number]++;
  var_1 = bot_heli_find_unvisited_nodes(var_0);
  var_2 = scripts\engine\utility::random(var_1);
  return var_2;
}

heli_pilot_monitor_flares() {
  self notify("_encstr_86481A59ED9DC8D0BBE2E0881B2FF140B549F9DF8209F88127ABD933");
  self endon("_encstr_86481A59ED9DC8D0BBE2E0881B2FF140B549F9DF8209F88127ABD933");
  var_0 = [];

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"]]]()) {
    self.vehicle_controlling waittill("_encstr_84521DB9D773E470143FE19EE6F1692B4A3717034F1ABCD955140B13CCDCE0", var_1);

    if(!scripts\mp\killstreaks\flares::flares_areavailable(self.vehicle_controlling)) {
      break;
    }

    var_2 = 1;

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && !scripts\engine\utility::array_contains(var_0, var_4))
        var_2 = 0;
    }

    if(!var_2) {
      var_6 = clamp(0.34 * self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592"), 0.0, 1.0);

      if(randomfloat(1.0) < var_6)
        self notify("_encstr_B2B2140111C0C3F971990434EE3DC716409F98CADFCD");

      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
      var_0 = scripts\engine\utility::array_removeundefined(var_0);
      wait 3.0;
    }
  }
}

heli_pilot_control_heli_aiming() {
  self notify("_encstr_88DC1F8057AC9007B3F491288B794798068BD8409B47083B1A9CAF2724B29BE077");
  self endon("_encstr_88DC1F8057AC9007B3F491288B794798068BD8409B47083B1A9CAF2724B29BE077");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self botgetdifficultysetting("_encstr_931A0E4579C2F71079AADE3F0A788720") + self botgetdifficultysetting("_encstr_AA770EADC2C34ADC0BD836AB9CB0C6F2")) / 2;
  var_7 = 0;

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"]["_encstr_9B100BD059D8A5D7C1B4C6B7D1"]]]()) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1.deathtime < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_8 = 1;
      var_1 = self.enemy;
      var_0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_7 = 0;
        var_9 = 1;
        var_10 = gettime();
      } else {
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0)
          var_8 = 0;
      }
    }

    if(var_8) {
      var_2 = var_0 - (0, 0, 50);

      if(var_9 && (bot_body_is_dead() || distancesquared(var_2, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius))
        self botpressbutton("_encstr_999A07C61338F9A23A");

      if(gettime() > var_4 + 500) {
        var_11 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_11, 150 * var_12, 150 * var_13);
        var_4 = gettime();
      }

      var_2 = var_2 + var_5;
      var_14 = self.vehicle_controlling gettagorigin("_encstr_8E010B996FB7B6B3C1D1183343");
      var_15 = vectorNormalize(var_2 - var_14);
      var_16 = anglesToForward(self getplayerangles());
      var_17 = vectordot(var_15, var_16);

      if(var_17 > 0.5)
        self botpressbutton("_encstr_AD1904291F7B", 0.1);
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    var_18 = var_2 - self.vehicle_controlling.origin;
    var_19 = length(var_18);
    var_20 = vectortoangles(var_18);
    var_21 = angleclamp(self.vehicle_controlling.angles[0]);
    var_22 = angleclamp(var_20[0]);
    var_23 = int(var_21 - var_22) % 360;

    if(var_23 > 180)
      var_23 = 360 - var_23;
    else if(var_23 < -180)
      var_23 = -360 + var_23;

    if(var_23 > 15)
      var_22 = var_21 - 15;
    else if(var_23 < -15)
      var_22 = var_21 + 15;

    var_20 = (var_22, var_20[1], var_20[2]);
    var_18 = anglesToForward(var_20);
    var_2 = self.vehicle_controlling.origin + var_18 * var_19;

    if(length(var_2) == 0)
      var_2 = (0, 0, 10);

    self botlookatpoint(var_2, 0.2, "_encstr_A7300E08584D77DBA497CF3FC5432757");
    wait 0.05;
  }
}

bot_control_odin_assault() {
  bot_control_odin("_encstr_96B30D67CDC2C06FB60B1F216F8863");
}

odin_assault_perform_action() {
  if(bot_odin_try_spawn_juggernaut())
    return 1;

  if(bot_odin_try_rods())
    return 1;

  if(bot_odin_try_airdrop())
    return 1;

  return 0;
}

odin_assault_get_target() {
  return bot_odin_find_target_for_rods();
}

bot_odin_find_target_for_rods() {
  var_0 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000)
    var_0 = self.last_large_rod_target;

  return bot_odin_get_closest_visible_outside_player("_encstr_88BF06FD784A6393", 1, var_0);
}

bot_odin_try_rods() {
  var_0 = bot_odin_should_fire_rod_at_marker();

  if(var_0 == "_encstr_8DEC06B1E943615B") {
    self notify("_encstr_9B8D11214E33DFA157CB80D09781B9212A75A8");
    return 1;
  }

  if(var_0 == "_encstr_A972062F7FDAF9B0") {
    self notify("_encstr_A9181127ADE6D881CF8B4811610FCED03C3795");
    return 1;
  }

  return 0;
}

bot_odin_should_fire_rod_at_marker() {
  var_0 = gettime() >= self.odin.odin_largerodusetime;
  var_1 = gettime() >= self.odin.odin_smallrodusetime;

  if(var_0 || var_1) {
    var_2 = bot_odin_get_visible_outside_players("_encstr_88BF06FD784A6393", 0);
    var_3 = [];
    var_4 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = bot_odin_get_player_target_point(var_2[var_5]);
      var_3[var_5] = distancesquared(self.odin.targeting_marker.origin, var_6);
    }

    if(var_0) {
      if(!bot_body_is_dead() && var_4 < level.odin_large_rod_radius * level.odin_large_rod_radius)
        return "_encstr_8BBA05185F8B99";

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = var_2[var_5];
          self.last_large_rod_time = gettime();
          return "_encstr_8DEC06B1E943615B";
        }
      }
    }

    if(var_1) {
      if(!bot_body_is_dead() && var_4 < level.odin_small_rod_radius * level.odin_small_rod_radius)
        return "_encstr_8BBA05185F8B99";

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == var_2[var_5] && gettime() - self.last_large_rod_time < 5000) {
            continue;
          }
          return "_encstr_A972062F7FDAF9B0";
        }
      }
    }
  }

  return "_encstr_8BBA05185F8B99";
}

bot_control_odin_support() {
  bot_control_odin("_encstr_8C8E0D47314312AF704BC2CA2050CC");
}

odin_support_perform_action() {
  if(bot_odin_try_spawn_juggernaut())
    return 1;

  if(bot_odin_try_airdrop())
    return 1;

  if(bot_odin_try_smoke())
    return 1;

  if(bot_odin_try_flash())
    return 1;

  return 0;
}

bot_odin_try_flash() {
  if(bot_odin_should_fire_flash_at_marker()) {
    self notify("_encstr_B2600F08FFFB5770C8E14167FF6BDCAFFD");
    return 1;
  }

  return 0;
}

bot_odin_should_fire_flash_at_marker() {
  if(gettime() < self.odin.odin_markingusetime)
    return 0;

  var_0 = bot_odin_get_visible_outside_players("_encstr_88BF06FD784A6393", 0);
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = bot_odin_get_player_target_point(var_0[var_2]);
    var_1[var_2] = distancesquared(self.odin.targeting_marker.origin, var_3);

    if(var_1[var_2] < squared(level.odin_flash_radius / 2))
      return 1;
  }

  return 0;
}

bot_odin_try_smoke() {
  if(bot_odin_should_drop_smoke_at_marker()) {
    self notify("_encstr_B6C30D92F98FE23DB668E7A33068FE");
    return 1;
  }

  return 0;
}

bot_odin_should_drop_smoke_at_marker() {
  if(gettime() < self.odin.odin_smokeusetime)
    return 0;

  var_0 = bot_odin_get_high_priority_smoke_locations();

  foreach(var_2 in var_0) {
    if(distancesquared(var_2, self.odin.targeting_marker.origin) < 2500)
      return 1;
  }

  var_4 = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node))
    var_4 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(var_4))
    return 0;

  var_5 = bot_killstreak_get_zone_enemies_outside(1);
  var_6 = var_5[var_4].size;

  if(var_6 >= 2)
    return 1;

  return 0;
}

bot_odin_get_high_priority_smoke_locations() {
  var_0 = [];

  if(gettime() < self.odin.odin_smokeusetime)
    return var_0;

  foreach(var_2 in level.carepackages) {
    if(scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2)) {
      var_3[0] = self;
      var_4 = scripts\engine\utility::get_array_of_closest(var_2.origin, level.players, var_3);

      if(var_4.size > 0 && var_4[0].team == self.team)
        var_0 = scripts\engine\utility::array_add(var_0, var_2.origin);
    }
  }

  var_6 = bot_odin_get_visible_outside_players("_encstr_AD830516C68DE5", 0);

  foreach(var_8 in var_6) {
    if(isai(var_8) && var_8 scripts\mp\bots\bots_util::bot_is_capturing())
      var_0 = scripts\engine\utility::array_add(var_0, var_8.origin);
  }

  return var_0;
}

odin_support_get_target() {
  var_0 = bot_odin_get_high_priority_smoke_locations();

  if(var_0.size > 0)
    return var_0[0];

  return bot_odin_get_closest_visible_outside_player("_encstr_88BF06FD784A6393", 1);
}

monitor_odin_marker() {
  for(;;) {
    self.odin.targeting_marker.nearest_node = getclosestnodeinsight(self.odin.targeting_marker.origin);

    if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(self.odin.targeting_marker.origin, 200))
      self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
    else
      self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;

    wait 0.25;
  }
}

bot_control_odin(var_0) {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = bot_waittill_using_vehicle(var_0);

  if(!var_1)
    self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");

  self.vehicle_controlling = self.odin;
  childthread bot_end_control_on_vehicle_death(self.odin);
  self.odin endon("_encstr_AD75063D571AE108");
  wait 1.4;
  self botsetawareness(0.7);
  thread bot_end_odin_watcher();
  self.odin_predicted_loc_for_player = [];
  self.odin_predicted_loc_time_for_player = [];
  self.odin_last_predict_position_time = 0;
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;
  childthread monitor_odin_marker();
  var_5 = self.odin.targeting_marker.origin;
  var_6 = gettime();

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"][var_0]]]()) {
    var_7 = self[[level.bot_ks_funcs["_encstr_A2C314658D132297C3F8137B90BB6DF9DB962B1CE0B5"][var_0]]]();

    if(gettime() > var_6 + 2000) {
      var_6 = gettime();
      var_8 = distance(var_5, self.odin.targeting_marker.origin);
      var_5 = self.odin.targeting_marker.origin;

      if(var_8 < 100) {
        var_4 = undefined;
        var_2 = undefined;
      }
    }

    if(gettime() > var_3 || !isDefined(var_4)) {
      var_9 = level.bot_odin_time_to_move[self botgetdifficulty()];
      var_3 = gettime() + var_9 * 1000;
      var_10 = self[[level.bot_ks_funcs["_encstr_B40410DE32B4CDEB9D951DBE8EC2C9D99547"][var_0]]]();

      if(isDefined(var_10)) {
        var_2 = undefined;

        if(isPlayer(var_10))
          var_4 = bot_odin_get_player_target_point(var_10);
        else
          var_4 = var_10;
      } else {
        if(!isDefined(var_2))
          var_2 = scripts\engine\utility::random(level.outside_zones);

        var_11 = getzonenodeforindex(var_2).origin;

        if(distance2dsquared(self.odin.targeting_marker.origin, var_11) < 10000) {
          var_2 = scripts\engine\utility::random(level.outside_zones);
          var_11 = getzonenodeforindex(var_2).origin;
          var_6 = gettime();
        }

        var_4 = var_11;
      }
    }

    var_12 = var_4 - self.odin.targeting_marker.origin;

    if(lengthsquared(var_12) > 100) {
      var_13 = vectortoangles(var_12);
      self botsetscriptmove(var_13[1], 0.05);
      self botlookatpoint(var_4, 0.1, "_encstr_A7300E08584D77DBA497CF3FC5432757");
    } else
      var_6 = gettime();

    wait 0.05;
  }

  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

bot_end_odin_watcher(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1.0);
}

bot_odin_get_player_target_point(var_0) {
  if(level.teambased && self.team == var_0.team)
    return var_0.origin;
  else {
    if(length(var_0 getentityvelocity()) < 25)
      return var_0.origin;

    var_1 = var_0 getentitynumber();

    if(!isDefined(self.odin_predicted_loc_time_for_player[var_1]))
      self.odin_predicted_loc_time_for_player[var_1] = 0;

    var_2 = gettime();
    var_3 = var_2 - self.odin_predicted_loc_time_for_player[var_1];

    if(var_3 <= 400) {
      var_4 = vectorNormalize(var_0 getentityvelocity());
      var_5 = vectorNormalize(self.odin_predicted_loc_for_player[var_1] - var_0.origin);

      if(vectordot(var_4, var_5) < -0.5)
        return var_0.origin;
    }

    if(var_3 > 400) {
      if(var_2 == self.odin_last_predict_position_time) {
        if(var_3 > 1000)
          return var_0.origin;
      } else {
        self.odin_predicted_loc_for_player[var_1] = getpredictedentityposition(var_0, 1.5);
        self.odin_predicted_loc_time_for_player[var_1] = var_2;
        self.odin_last_predict_position_time = var_2;
      }
    }

    return self.odin_predicted_loc_for_player[var_1];
  }
}

bot_odin_get_closest_visible_outside_player(var_0, var_1, var_2) {
  var_3 = bot_odin_get_visible_outside_players(var_0, var_1);

  if(isDefined(var_2))
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);

  if(var_3.size > 0) {
    var_4 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3);
    return var_4[0];
  }

  return undefined;
}

bot_odin_try_spawn_juggernaut() {
  if(gettime() >= self.odin.odin_juggernautusetime) {
    if(!isDefined(self.odin.targeting_marker.nearest_node))
      return 0;
  }

  return 0;
}

bot_odin_find_target_for_airdrop() {
  return bot_odin_get_closest_visible_outside_player("_encstr_AD830516C68DE5", 0);
}

bot_odin_try_airdrop() {
  if(bot_odin_should_airdrop_at_marker()) {
    self notify("_encstr_AD700FB05A272327DEE07DB01BE85AB7E6");
    self notify("_encstr_994612E8AB6F51BD8028490BE859BEE3B3235090");
    return 1;
  }

  return 0;
}

bot_odin_should_airdrop_at_marker() {
  if(gettime() < self.odin.odin_airdropusetime)
    return 0;

  if(!isDefined(self.odin.targeting_marker.nearest_node))
    return 0;

  if(bot_odin_get_num_valid_care_packages() > 2)
    return 0;

  if(!isDefined(self.odin.targeting_marker.nearest_point_on_pathgrid))
    return 0;

  var_0 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(var_0))
    return 0;

  var_1 = bot_killstreak_get_zone_allies_outside(1);
  var_2 = var_1[var_0].size;
  var_3 = bot_killstreak_get_zone_enemies_outside(1);
  var_4 = var_3[var_0].size;

  if(var_2 == 0)
    return 0;

  if(var_4 == 0) {
    var_5 = 0;
    var_6 = bot_odin_get_visible_outside_players("_encstr_88BF06FD784A6393", 1);

    foreach(var_8 in var_6) {
      if(distancesquared(var_8.origin, self.odin.targeting_marker.origin) < 14400)
        var_5 = 1;
    }

    if(!var_5)
      return 1;
  }

  if(var_2 - var_4 >= 2) {
    var_10 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_1[var_0]);
    var_11 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, var_3[var_0]);
    var_12 = distance(self.odin.targeting_marker.origin, var_10[0].origin);
    var_13 = distance(self.odin.targeting_marker.origin, var_11[0].origin);

    if(var_12 + 120 < var_13)
      return 1;
  }

  return 0;
}

bot_odin_get_num_valid_care_packages() {
  var_0 = 0;

  foreach(var_2 in level.carepackages) {
    if(isDefined(var_2) && scripts\mp\bots\bots::crate_landed_and_on_path_grid(var_2))
      var_0++;
  }

  return var_0;
}

bot_odin_get_visible_outside_players(var_0, var_1, var_2) {
  var_3 = bot_killstreak_get_outside_players(self.team, var_0, var_1);
  var_4 = self botgetfovdot();
  var_5 = [];

  foreach(var_7 in var_3) {
    var_8 = 0;
    var_9 = var_4;

    if(var_0 == "_encstr_88BF06FD784A6393")
      var_9 = var_9 * 0.9;

    if(scripts\engine\utility::within_fov(self.vehicle_controlling.origin, self getplayerangles(), var_7.origin, var_9)) {
      if(!var_8 || self botcanseeentity(var_7))
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
    }
  }

  return var_5;
}

is_indoor_map() {
  return level.script == "_encstr_9BCB0DE77B61A6F0A31918CDE21F15";
}

bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

heli_pick_node_furthest_from_center(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = distancesquared(level.bot_map_center, [[level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"][var_1]]](var_5));

    if(var_6 > var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2))
    return var_2;
  else
    return scripts\engine\utility::random(var_0);
}

heli_get_node_origin(var_0) {
  return var_0.origin;
}

find_closest_heli_node_2d(var_0, var_1) {
  var_2 = undefined;
  var_3 = 99999999;

  foreach(var_5 in level.bot_heli_nodes) {
    var_6 = distance2dsquared(var_0, [[level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"][var_1]]](var_5));

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

bot_killstreak_get_zone_allies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_allies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++)
    var_2[var_3] = [];

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);

    if(isDefined(var_7))
      var_2[var_7] = scripts\engine\utility::array_add(var_2[var_7], var_5);
  }

  return var_2;
}

bot_killstreak_get_zone_enemies_outside(var_0) {
  var_1 = bot_killstreak_get_all_outside_enemies(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level.zonecount; var_3++)
    var_2[var_3] = [];

  foreach(var_5 in var_1) {
    var_6 = var_5 getnearestnode();
    var_7 = getnodezone(var_6);
    var_2[var_7] = scripts\engine\utility::array_add(var_2[var_7], var_5);
  }

  return var_2;
}

bot_killstreak_get_all_outside_enemies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "_encstr_88BF06FD784A6393", var_0);
}

bot_killstreak_get_all_outside_allies(var_0) {
  return bot_killstreak_get_outside_players(self.team, "_encstr_AD830516C68DE5", var_0);
}

bot_killstreak_get_outside_players(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = level.participants;

  if(isDefined(var_2) && var_2)
    var_4 = level.players;

  foreach(var_6 in var_4) {
    if(var_6 == self || !isalive(var_6)) {
      continue;
    }
    var_7 = 0;

    if(var_1 == "_encstr_AD830516C68DE5")
      var_7 = level.teambased && var_0 == var_6.team;
    else if(var_1 == "_encstr_88BF06FD784A6393")
      var_7 = !level.teambased || var_0 != var_6.team;

    if(var_7) {
      var_8 = var_6 getnearestnode();

      if(isDefined(var_8) && nodeexposedtosky(var_8))
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
    }
  }

  var_3 = scripts\engine\utility::array_remove(var_3, self);
  return var_3;
}

bot_heli_find_unvisited_nodes(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0.neighbors) {
    if(isDefined(var_4.script_linkname)) {
      var_5 = var_4.bot_visited_times[self.entity_number];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

bot_control_heli(var_0) {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = bot_waittill_using_vehicle(var_0);

  if(!var_1)
    self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");

  foreach(var_3 in level.littlebirds) {
    if(var_3.owner == self)
      self.vehicle_controlling = var_3;
  }

  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("_encstr_AD75063D571AE108");

  if(isDefined(level.bot_ks_funcs["_encstr_9BD60E1BA708634B308D616A2B9B2F5A"][var_0]))
    self childthread[[level.bot_ks_funcs["_encstr_9BD60E1BA708634B308D616A2B9B2F5A"][var_0]]]();

  self[[level.bot_ks_funcs["_encstr_AC7D16C8F719E381F24561E01CDAE3AB718F981147A79979"][var_0]]]();
  self childthread[[level.bot_ks_funcs["_encstr_85070FB7E737734250A8C94E2068910A6C"][var_0]]]();
  bot_control_heli_main_move_loop(var_0, 1);
  self notify("_encstr_A3B4120630A8ACF37811BF235B90AACFA098FD0F");
}

bot_get_heli_goal_dist_sq(var_0) {
  if(var_0)
    return squared(100);
  else
    return squared(30);
}

bot_get_heli_slowdown_dist_sq(var_0) {
  if(var_0)
    return squared(300);
  else
    return squared(90);
}

bot_control_heli_main_move_loop(var_0, var_1) {
  foreach(var_3 in level.bot_heli_nodes)
  var_3.bot_visited_times[self.entity_number] = 0;

  var_5 = find_closest_heli_node_2d(self.vehicle_controlling.origin, var_0);
  var_6 = undefined;
  self.next_goal_time = 0;
  var_7 = "_encstr_A37D0F7B0B0DFACB4960FF437EB0EF6251";
  var_8 = undefined;
  var_9 = self.vehicle_controlling.origin;
  var_10 = 3.0;
  var_11 = 0.05;

  while(self[[level.bot_ks_funcs["_encstr_B4FD08E7A7950B5140C1"][var_0]]]()) {
    if(gettime() > self.next_goal_time && var_7 == "_encstr_A37D0F7B0B0DFACB4960FF437EB0EF6251") {
      var_12 = var_5;
      var_5 = [[level.bot_ks_funcs["_encstr_A6B60F139838D1492173160C70350264A1"][var_0]]](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level.bot_ks_funcs["_encstr_93F415732DFB60EFCDAA404081A7431BDFDF867B8757C8"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset);
          var_15 = var_5.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset);
          var_16 = scripts\engine\trace::_bullet_trace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["_encstr_BD260953AA97E3F014279D"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_ks_heli_offset[var_0];
        } else
          var_6 = var_13;
      }

      if(isDefined(var_6)) {
        self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
        var_7 = "_encstr_950912EEC2D2D1B473D9AFA3A51B8DBECEF6B01B";
        var_10 = 3.0;
        var_9 = self.vehicle_controlling.origin;
      } else {
        var_5 = var_12;
        self.next_goal_time = gettime() + 2000;
      }
    } else if(var_7 == "_encstr_950912EEC2D2D1B473D9AFA3A51B8DBECEF6B01B") {
      if(!var_1) {
        var_17 = var_6[2] - self.vehicle_controlling.origin[2];

        if(var_17 > 10)
          self botpressbutton("_encstr_B116071BCAD186858D");
        else if(var_17 < -10)
          self botpressbutton("_encstr_99C209E34FC743616118AB");
      }

      var_18 = var_6 - self.vehicle_controlling.origin;

      if(var_1)
        var_8 = length2dsquared(var_18);
      else
        var_8 = lengthsquared(var_18);

      if(var_8 < bot_get_heli_goal_dist_sq(var_1)) {
        self botsetscriptmove(0, 0);
        self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);

        if(self botgetdifficulty() == "_encstr_889F0893CA6CC9BA2D8E")
          self.next_goal_time = gettime() + randomintrange(5000, 7000);
        else
          self.next_goal_time = gettime() + randomintrange(3000, 5000);

        var_7 = "_encstr_A37D0F7B0B0DFACB4960FF437EB0EF6251";
      } else {
        var_18 = var_6 - self.vehicle_controlling.origin;
        var_19 = vectortoangles(var_18);
        var_20 = scripts\engine\utility::ter_op(var_8 < bot_get_heli_slowdown_dist_sq(var_1), 0.5, 1.0);
        self botsetscriptmove(var_19[1], var_11, var_20);
        var_10 = var_10 - var_11;

        if(var_10 <= 0.0) {
          if(distancesquared(self.vehicle_controlling.origin, var_9) < 225) {
            var_5.bot_visited_times[self.entity_number]++;
            var_7 = "_encstr_A37D0F7B0B0DFACB4960FF437EB0EF6251";
          }

          var_9 = self.vehicle_controlling.origin;
          var_10 = 3.0;
        }
      }
    }

    wait(var_11);
  }
}

get_random_outside_target() {
  var_0 = [];

  foreach(var_2 in level.outside_zones) {
    var_3 = botzonegetcount(var_2, self.team, "_encstr_B2620E4878194F72EE030A77E3BA5EB4");

    if(var_3 > 0)
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = scripts\engine\utility::random(var_0);
    var_7 = scripts\engine\utility::random(getzonenodes(var_6));
    var_5 = var_7.origin;
  } else {
    var_8 = undefined;
    var_9 = undefined;

    if(isDefined(level.teleportgetactivenodesfunc))
      var_8 = [[level.teleportgetactivenodesfunc]]();
    else
      var_9 = getsentientcounts();

    var_10 = 0;

    while(var_10 < 10) {
      var_10++;
      var_11 = undefined;

      if(isDefined(var_8))
        var_11 = scripts\engine\utility::random(var_8);
      else
        var_11 = nvidiahighlightsrequestpermissions(randomint(var_9));

      if(isDefined(var_11)) {
        var_5 = var_11.origin;

        if(nodeexposedtosky(var_11) && distance2dsquared(var_11.origin, self.vehicle_controlling.origin) > 62500) {
          break;
        }
      }
    }
  }

  return var_5;
}