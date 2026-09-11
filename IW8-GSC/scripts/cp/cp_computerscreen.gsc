/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_computerscreen.gsc
***********************************************/

#using_animtree("");

function init_computer_anims() {
  level.scr_animtree["plyr_stand_computer"] = #animtree;
  level.scr_anim["plyr_stand_computer"]["start"] = $cp_scripted_computerinterface_enter;
  level.scr_animname["plyr_stand_computer"]["start"] = "cp_scripted_computerinterface_enter";
  level.scr_eventanim["plyr_stand_computer"]["start"] = "use_computer_in";
  level.scr_anim["plyr_stand_computer"]["stop"] = % cp_scripted_computerinterface_exit;
  level.scr_animname["plyr_stand_computer"]["stop"] = "cp_scripted_computerinterface_exit";
  level.scr_eventanim["plyr_stand_computer"]["stop"] = "use_computer_out";
  level.scr_anim["plyr_stand_computer"]["use_loop"] = % cp_scripted_computerinterface_idle;
  level.scr_animname["plyr_stand_computer"]["use_loop"] = "cp_scripted_computerinterface_idle";
  level.scr_eventanim["plyr_stand_computer"]["use_loop"] = "use_computer_loop";
}

function create_computer_interaction(var_0, var_1, var_2, var_3) {
  var_4 = "cpu" + var_1 + "_search_result";
  var_5 = spawn("script_model", var_0);
  var_5.computer_name = var_4;
  var_5.popup_omnvar = var_1;
  var_5 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/SCAN_AREA", 25, "duration_none", "show", 256, 120, 48, 90);
  thread computer_think(var_5, var_1, var_3);
  thread computer_event_listener(var_5);
  thread computer_watch_for_search(var_5);
  return var_5;
}

function computer_think(var_0, var_1, var_2) {
  self notify("computer_think");
  self endon("computer_think");

  for(;;) {
    self waittill("trigger", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    level notify("manifest_computer_used", var_3);
    self makeunusable();
    thread computer_think_internal(var_3, var_0, var_1, var_2);
  }
}

function computer_think_internal(var_0, var_1, var_2, var_3) {
  self notify("computer_think_internal");
  self endon("computer_think_internal");
  var_0 endon("disconnect");
  computer_player_allow(var_0, 0);
  thread computer_laststand_handler(var_0, var_1);
  thread computer_disconnect_handler(var_0);

  while(var_0 useButtonPressed()) {
    wait 0.05;
  }

  var_0 playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  scripts\engine\utility::delaythread(1, &computer_activate, var_0, var_1, var_2, var_3);
  do_computer_anims(var_0);
  computer_player_allow(var_0, 1);
  var_0 setclientomnvar("dpad_popup", 0);

  if(!istrue(self.disable_playeruse)) {
    self makeusable();
    return;
  }
}

function computer_activate(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(var_3)) {
    setomnvar(var_2, var_3);
  }

  var_0 setclientomnvar("dpad_popup", var_1);
}

function do_computer_anims(var_0) {
  init_computer_anims();

  if(getdvarint("disallow_scripted_anims") > 0) {
    thread computer_anim_loop_exit(var_0);
    return;
  }

  var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "plyr_stand_computer", 1, 0);
  var_2 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_1], "start", 1, 0) && var_0 scripts\cp_mp\utility\player_utility::_isalive();
  thread computer_anim_loop_exit(var_0);
  computer_anim_loop(self.scenenode, var_0, var_1);
  self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_1], "stop", 0, 1);
}

function computer_anim_loop(var_0, var_1) {
  var_0 endon("exit_computer");

  while(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\cp_mp\anim_scene::anim_scene([var_1], "use_loop", 0, 0);
  }
}

function computer_anim_loop_exit(var_0) {
  level endon("game_ended");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_0 endon("exit_computer");
  level.ref_1404b = 1;

  if(var_0 usinggamepad()) {
    if(istrue(level.ref_1404b)) {
      while(var_0 useButtonPressed()) {
        wait 0.05;
      }
    } else {
      while(var_0 stancebuttonPressed()) {
        wait 0.05;
      }
    }
  } else {
    while(var_0 useButtonPressed()) {
      wait 0.05;
    }
  }

  for(;;) {
    if(var_0 usinggamepad()) {
      if(istrue(level.ref_1404b)) {
        if(var_0 useButtonPressed()) {
          break;
        }
      } else if(var_0 stancebuttonPressed()) {
        break;
      }
    } else if(var_0 useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  var_0 playlocalsound("cp_computer_exit");
  var_0 notify("exit_computer");
}

function computer_disconnect_handler(var_0) {
  var_0 endon("exit_computer");
  var_0 waittill("disconnect");
  self makeusable();
}

function computer_laststand_handler(var_0, var_1) {
  var_0 endon("exit_computer");
  var_0 waittill("last_stand");
  computer_player_allow(var_0, 1);

  if(isDefined(var_1)) {
    var_0 setclientomnvar("dpad_popup", var_1);
  }

  self makeusable();
  var_0 notify("exit_computer");
}

function computer_player_allow(var_0, var_1) {
  var_0 scripts\common\utility::allow_crouch(var_1);
  var_0 scripts\common\utility::allow_prone(var_1);
  var_0 scripts\common\utility::allow_weapon(var_1);
  var_0.ref_140ae = !var_1;
  var_0.disable_super = !var_1;
}

function computer_event_listener(var_0) {
  for(;;) {
    level waittill("player_computer_searched", var_1, var_2, var_3);

    if(var_2 != var_0) {
      continue;
    }

    self notify("computer_event", var_1, var_3);
  }
}

function computer_watch_for_search(var_0) {
  for(;;) {
    level waittill("player_computer_startsearch", var_1, var_2, var_3);

    if(var_2 != var_0) {
      continue;
    }

    self notify("computer_searching", var_1, var_3);
  }
}

function hit_by_emp_monitor(var_0) {
  var_0 notify("computer_interface_think");
  var_0 endon("computer_interface_think");
  var_0 endon("disconnect");

  while(var_0 useButtonPressed()) {
    wait 0.05;
  }

  thread computer_laststand_handler(var_0);
  thread computer_disconnect_handler(var_0);
  var_0 playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  computer_player_allow(var_0, 0);
  do_computer_anims(var_0);
  computer_player_allow(var_0, 1);
}