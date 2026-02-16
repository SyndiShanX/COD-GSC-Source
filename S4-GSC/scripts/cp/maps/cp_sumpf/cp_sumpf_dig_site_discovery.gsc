/********************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_dig_site_discovery.gsc
********************************************************************/

init() {
  if(!getdvarint("#x33ad41eaa5a9a3eec", 0) == 1) {
    return;
  }
  level.exfil_started = 0;
  level.dig_site_breadcrumbs_step = 0;
  level.a_dig_site_breadcrumbs = [];
  level.b_dig_site_breadcrumbs_is_hidden = 0;
  level.a_dig_site_tracked_markers = [];
  level.a_dig_site_active_markers = [];
  level thread listener_exfil_start();
  _id_099C::_id_C211("digsite_discover", 1, ::init_step_one_marker, ::do_step_one_marker, ::cleanup_step_one_marker, ::debug_step_one_marker);
  _id_099C::_id_C211("digsite_discover", 2, ::init_step_two_marker, ::do_step_two_marker, ::cleanup_step_two_marker, ::debug_step_two_marker);
}

init_step_one_marker(var_0) {
  var_1 = ["dig_site_breadcrumbs_1", "dig_site_breadcrumbs_2", "dig_site_breadcrumbs_3"];

  foreach(var_3 in var_1) {
    var_4 = spawnStruct();
    var_4.markers = scripts\engine\utility::getStructArray(var_3, "script_noteworthy");
    level.a_dig_site_breadcrumbs[level.a_dig_site_breadcrumbs.size] = var_4;
  }
}

setup(var_0) {}

do_step_one_marker() {
  if(!isDefined(level.a_dig_site_breadcrumbs)) {
    return;
  }
  wait 1;
  level thread show_hint_monitor(&"CP_SUMPF/SEARCH_THE_DIGSITE");
  var_0 = level.a_dig_site_breadcrumbs[0];

  if(isDefined(var_0.markers)) {
    level.a_dig_site_tracked_markers = var_0.markers;
    show_markers(var_0.markers);
    check_players_find_markers(var_0.markers);
    level.dig_site_breadcrumbs_step++;

    if(istrue(level.exfil_started)) {
      return;
    }
  }
}

cleanup_step_one_marker() {}

debug_step_one_marker() {
  level notify("dig_site_discovery_marker_found");
}

init_step_two_marker() {
  var_0 = spawnStruct();
  var_0.markers = scripts\engine\utility::getStructArray("dig_site_breadcrumbs_4", "script_noteworthy");
  var_0.finish_flag = "dig_site_discovery_marker_final_found";
  level.a_dig_site_breadcrumbs[level.a_dig_site_breadcrumbs.size] = var_0;
}

do_step_two_marker() {
  level thread step_two_find_marker();
  level waittill("dig_site_breadcrumbs_step_two_done");
}

step_two_find_marker() {
  if(!isDefined(level.a_dig_site_breadcrumbs) || !isDefined(level.a_dig_site_breadcrumbs[level.dig_site_breadcrumbs_step]) || !isDefined(level.a_dig_site_breadcrumbs[level.dig_site_breadcrumbs_step].markers)) {
    return;
  }
  if(istrue(level.exfil_started)) {
    return;
  }
  foreach(var_1 in level.a_dig_site_breadcrumbs[level.dig_site_breadcrumbs_step].markers) {
    level thread find_marker_sequence(var_1);
  }
}

find_marker_sequence(var_0) {
  level endon("game_ended");
  level endon("exfil_radio_interacted");

  if(isDefined(level.a_dig_site_tracked_markers) && scripts\engine\utility::array_contains(level.a_dig_site_tracked_markers, var_0)) {
    return;
  }
  level.a_dig_site_tracked_markers = scripts\engine\utility::array_add(level.a_dig_site_tracked_markers, var_0);
  show_markers([var_0]);

  if(isDefined(var_0._id_039B) && var_0._id_039B == "dig_site_breadcrumbs_4") {
    check_players_find_final_marker([var_0]);
    level notify("dig_site_breadcrumbs_step_two_done");
    hide_breadcrumbs_quest();
    return;
  } else {
    check_players_find_markers([var_0]);
    var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

    foreach(var_3 in var_1) {
      level thread find_marker_sequence(var_3);
    }
  }
}

cleanup_step_two_marker() {}

debug_step_two_marker() {}

show_hint_monitor(var_0) {
  level endon("game_ended");
  level endon("dig_site_hint_cleared");
  level endon("exfil_radio_interacted");
  scripts\engine\utility::_id_5C24("introscreen_over");

  if(isDefined(level.dig_site_breadcrumbs_step)) {
    while(level.dig_site_breadcrumbs_step < 4) {
      foreach(var_2 in level.players) {
        if(isDefined(var_2)) {
          if(!isDefined(var_2.dig_site_search_hint) && !istrue(level.b_dig_site_breadcrumbs_is_hidden)) {
            var_2.dig_site_search_hint = var_2 scripts\cp\utility::createfontstring("default", 1);
            var_2.dig_site_search_hint scripts\cp\utility::setpoint("LEFT", undefined, 30, -90);
            var_2.dig_site_search_hint.color = (1, 1, 1);
            var_2.dig_site_search_hint settext(var_0);
            var_2.dig_site_search_hint.alpha = 1;
          }
        }
      }

      wait 1;
    }
  }
}

clear_hint() {
  level notify("dig_site_hint_cleared");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.dig_site_search_hint)) {
      var_1.dig_site_search_hint fadeovertime(0.15);
      var_1.dig_site_search_hint.alpha = 0;
      var_1.dig_site_search_hint scripts\cp\utility::destroyelem();
    }
  }
}

listener_exfil_start() {
  level endon("game_ended");
  level waittill("exfil_radio_interacted");
  level.exfil_started = 1;
  clear_hint();
}

show_markers(var_0) {
  if(!istrue(level.b_dig_site_breadcrumbs_is_hidden)) {
    foreach(var_2 in var_0) {
      var_3 = spawnStruct();
      var_3._id_E747 = "current";
      var_3._id_96CF = var_2.origin;
      var_3._id_11012 = 50;
      var_3._id_7C3B = "v_ui_icons_zombies_minimap_objective";
      var_3.minimapiconsize = "icon_regular";
      var_3.showsdistance = 1;
      var_2.objective_marker_index = _id_0987::_id_0FFD(var_2._id_CD99, var_3);
      var_2.objective_param = var_3;
    }
  }
}

cleanup_markers(var_0) {
  level endon("game_ended");

  foreach(var_2 in var_0) {
    _id_0987::_id_C413(var_2._id_CD99, var_2.objective_marker_index);
    waitframe();
    var_2.objective_marker_index = undefined;
  }
}

check_players_find_markers(var_0) {
  level endon("game_ended");
  level endon("exfil_radio_interacted");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_CD99)) {
      level endon("stop_checking_markers_" + var_2._id_CD99);
    }

    level.a_dig_site_active_markers = scripts\engine\utility::array_add(level.a_dig_site_active_markers, var_2);
  }

  var_4 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_CD4B)) {
      var_4[var_4.size] = var_2._id_CD4B;
    }
  }

  if(var_4.size > 0) {
    level scripts\engine\utility::_id_5C28(var_4);
  }

  cleanup_markers(var_0);

  foreach(var_2 in var_0) {
    level.a_dig_site_active_markers = scripts\engine\utility::array_remove(level.a_dig_site_active_markers, var_2);

    if(isDefined(var_2._id_039B)) {
      var_8 = scripts\engine\utility::getStructArray(var_2._id_039B, "script_noteworthy");

      foreach(var_10 in var_8) {
        if(isDefined(var_10._id_0481)) {
          var_11 = scripts\engine\utility::getStructArray(var_10._id_0481, "target");

          foreach(var_13 in var_11) {
            if(scripts\engine\utility::array_contains(level.a_dig_site_active_markers, var_13)) {
              if(isDefined(var_13._id_CD99)) {
                level notify("stop_checking_markers_" + var_13._id_CD99);
              }

              cleanup_markers([var_13]);
              level.a_dig_site_active_markers = scripts\engine\utility::array_remove(level.a_dig_site_active_markers, var_13);
            }
          }
        }
      }
    }
  }
}

check_players_find_final_marker(var_0) {
  level endon("game_ended");
  level endon("exfil_radio_interacted");

  foreach(var_2 in var_0) {
    level.a_dig_site_active_markers = scripts\engine\utility::array_add(level.a_dig_site_active_markers, var_2);
  }

  for(;;) {
    foreach(var_5 in level.players) {
      if(isDefined(var_5)) {
        foreach(var_2 in var_0) {
          var_7 = scripts\cp\utility::_id_459B(var_2._id_0359, 150);

          if(distance(var_5.origin, var_2.origin) < var_7) {
            cleanup_markers(var_0);

            foreach(var_2 in var_0) {
              level.a_dig_site_active_markers = scripts\engine\utility::array_remove(level.a_dig_site_active_markers, var_2);
            }

            return;
          }
        }
      }
    }

    wait 1;
  }
}

hide_breadcrumbs_quest() {
  if(!istrue(level.b_dig_site_breadcrumbs_is_hidden)) {
    level.b_dig_site_breadcrumbs_is_hidden = 1;
    clear_hint();

    if(isDefined(level.a_dig_site_active_markers)) {
      cleanup_markers(level.a_dig_site_active_markers);
    }
  }
}

show_breadcrumbs_quest() {
  if(!isDefined(level.a_dig_site_active_markers) || level.a_dig_site_active_markers.size == 0) {
    return;
  }
  if(istrue(level.b_dig_site_breadcrumbs_is_hidden)) {
    level.b_dig_site_breadcrumbs_is_hidden = 0;
    level thread show_hint_monitor(&"CP_SUMPF/SEARCH_THE_DIGSITE");

    if(isDefined(level.a_dig_site_active_markers)) {
      show_markers(level.a_dig_site_active_markers);
    }
  }
}