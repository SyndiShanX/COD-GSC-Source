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

function create_computer_interaction(var0, var1, var2, var3) {
  var4 = "cpu" + var1 + "_search_result";
  var5 = spawn("script_model", var0);
  var5.computer_name = var4;
  var5.popup_omnvar = var1;
  var5 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/SCAN_AREA", 25, "duration_none", "show", 256, 120, 48, 90);
  thread computer_think(var5, var1, var3);
  thread computer_event_listener(var5);
  thread computer_watch_for_search(var5);
  return var5;
}

function computer_think(var0, var1, var2) {
  self notify("computer_think");
  self endon("computer_think");

  for(;;) {
    self waittill("trigger", var3);

    if(!var3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    level notify("manifest_computer_used", var3);
    self makeunusable();
    thread computer_think_internal(var3, var0, var1, var2);
  }
}

function computer_think_internal(var0, var1, var2, var3) {
  self notify("computer_think_internal");
  self endon("computer_think_internal");
  var0 endon("disconnect");
  computer_player_allow(var0, 0);
  thread computer_laststand_handler(var0, var1);
  thread computer_disconnect_handler(var0);

  while(var0 useButtonPressed()) {
    wait 0.05;
  }

  var0 playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  scripts\engine\utility::delaythread(1, &computer_activate, var0, var1, var2, var3);
  do_computer_anims(var0);
  computer_player_allow(var0, 1);
  var0 setclientomnvar("dpad_popup", 0);

  if(!istrue(self.disable_playeruse)) {
    self makeusable();
    return;
  }
}

function computer_activate(var0, var1, var2, var3) {
  if(isDefined(var2) && isDefined(var3)) {
    setomnvar(var2, var3);
  }

  var0 setclientomnvar("dpad_popup", var1);
}

function do_computer_anims(var0) {
  init_computer_anims();

  if(getdvarint("disallow_scripted_anims") > 0) {
    thread computer_anim_loop_exit(var0);
    return;
  }

  var1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var0, "plyr_stand_computer", 1, 0);
  var2 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var1], "start", 1, 0) && var0 scripts\cp_mp\utility\player_utility::_isalive();
  thread computer_anim_loop_exit(var0);
  computer_anim_loop(self.scenenode, var0, var1);
  self.scenenode scripts\cp_mp\anim_scene::anim_scene([var1], "stop", 0, 1);
}

function computer_anim_loop(var0, var1) {
  var0 endon("exit_computer");

  while(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\cp_mp\anim_scene::anim_scene([var1], "use_loop", 0, 0);
  }
}

function computer_anim_loop_exit(var0) {
  level endon("game_ended");
  var0 endon("last_stand");
  var0 endon("disconnect");
  var0 endon("exit_computer");
  level.ref_1404b = 1;

  if(var0 usinggamepad()) {
    if(istrue(level.ref_1404b)) {
      while(var0 useButtonPressed()) {
        wait 0.05;
      }
    } else {
      while(var0 stancebuttonPressed()) {
        wait 0.05;
      }
    }
  } else {
    while(var0 useButtonPressed()) {
      wait 0.05;
    }
  }

  for(;;) {
    if(var0 usinggamepad()) {
      if(istrue(level.ref_1404b)) {
        if(var0 useButtonPressed()) {
          break;
        }
      } else if(var0 stancebuttonPressed()) {
        break;
      }
    } else if(var0 useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  var0 playlocalsound("cp_computer_exit");
  var0 notify("exit_computer");
}

function computer_disconnect_handler(var0) {
  var0 endon("exit_computer");
  var0 waittill("disconnect");
  self makeusable();
}

function computer_laststand_handler(var0, var1) {
  var0 endon("exit_computer");
  var0 waittill("last_stand");
  computer_player_allow(var0, 1);

  if(isDefined(var1)) {
    var0 setclientomnvar("dpad_popup", var1);
  }

  self makeusable();
  var0 notify("exit_computer");
}

function computer_player_allow(var0, var1) {
  var0 scripts\common\utility::allow_crouch(var1);
  var0 scripts\common\utility::allow_prone(var1);
  var0 scripts\common\utility::allow_weapon(var1);
  var0.ref_140ae = !var1;
  var0.disable_super = !var1;
}

function computer_event_listener(var0) {
  for(;;) {
    level waittill("player_computer_searched", var1, var2, var3);

    if(var2 != var0) {
      continue;
    }

    self notify("computer_event", var1, var3);
  }
}

function computer_watch_for_search(var0) {
  for(;;) {
    level waittill("player_computer_startsearch", var1, var2, var3);

    if(var2 != var0) {
      continue;
    }

    self notify("computer_searching", var1, var3);
  }
}

function hit_by_emp_monitor(var0) {
  var0 notify("computer_interface_think");
  var0 endon("computer_interface_think");
  var0 endon("disconnect");

  while(var0 useButtonPressed()) {
    wait 0.05;
  }

  thread computer_laststand_handler(var0);
  thread computer_disconnect_handler(var0);
  var0 playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  computer_player_allow(var0, 0);
  do_computer_anims(var0);
  computer_player_allow(var0, 1);
}