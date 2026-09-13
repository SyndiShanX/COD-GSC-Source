/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_computerscreen.gsc
***********************************************/

#using_animtree("script_model");

init_computer_anims() {
  level.scr_animtree["plyr_stand_computer"] = #animtree;
  level.scr_anim["plyr_stand_computer"]["start"] = % iw9_cp_raid_code_console_enter;
  level.scr_animname["plyr_stand_computer"]["start"] = "iw9_cp_raid_code_console_enter";
  level.scr_eventanim["plyr_stand_computer"]["start"] = "iw9_cp_raid_code_console_enter";
  level.scr_anim["plyr_stand_computer"]["stop"] = % iw9_cp_raid_code_console_exit;
  level.scr_animname["plyr_stand_computer"]["stop"] = "iw9_cp_raid_code_console_exit";
  level.scr_eventanim["plyr_stand_computer"]["stop"] = "iw9_cp_raid_code_console_exit";
  level.scr_anim["plyr_stand_computer"]["use_loop"] = % iw9_cp_raid_code_console_idle;
  level.scr_animname["plyr_stand_computer"]["use_loop"] = "iw9_cp_raid_code_console_idle";
  level.scr_eventanim["plyr_stand_computer"]["use_loop"] = "iw9_cp_raid_code_console_idle";
  level.scr_animtree["computer_prop"] = #animtree;
  level.scr_anim["computer_prop"]["start"] = % iw9_cp_raid_code_console_enter_console;
  level.scr_animname["computer_prop"]["start"] = "iw9_cp_raid_code_console_enter_console";
  level.scr_anim["computer_prop"]["stop"] = % iw9_cp_raid_code_console_exit_console;
  level.scr_animname["computer_prop"]["stop"] = "iw9_cp_raid_code_console_exit_console";
  level.scr_anim["computer_prop"]["use_loop"] = % iw9_cp_raid_code_console_idle_console;
  level.scr_animname["computer_prop"]["use_loop"] = "iw9_cp_raid_code_console_idle_console";
}

create_computer_interaction(_id_718D80100704CC82, popup_omnvar, _id_5314A19EA59AB700, _id_094BDE51D48A4DDE) {
  computer_name = "cpu" + popup_omnvar + "_search_result";
  useobj = spawn("script_model", _id_718D80100704CC82);
  useobj.computer_name = computer_name;
  useobj.popup_omnvar = popup_omnvar;
  useobj scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/SCAN_AREA", 25, "duration_short", "show", 256, 120, 48, 90);
  useobj thread computer_think(popup_omnvar, _id_094BDE51D48A4DDE, _id_5314A19EA59AB700);
  useobj thread computer_event_listener(computer_name);
  useobj thread computer_watch_for_search(computer_name);
  return useobj;
}

computer_think(popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210) {
  self notify("computer_think");
  self endon("computer_think");

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(level._id_C32C64CB22CDC120))
      level[[level._id_C32C64CB22CDC120]](player);

    if(istrue(player._id_2D0FE75B4FBAA60D)) {
      continue;
    }
    if(istrue(self.in_use)) {
      continue;
    }
    level notify("manifest_computer_used", player);
    self _meth_DFB78B3E724AD620(0);
    thread computer_think_internal(player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210);
  }
}

computer_think_internal(player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210) {
  self notify("computer_think_internal");
  self endon("computer_think_internal");
  player endon("disconnect");
  self.in_use = 1;
  computer_player_allow(player, 0);
  thread computer_laststand_handler(player, popup_omnvar);
  thread computer_disconnect_handler(player);
  thread _id_26CA9B3A5AA15E8D(player);
  player playSound("cp_raid_computer_use");
  computer = scripts\engine\utility::getclosest(self.origin, getEntArray("usable_computer_console", "script_noteworthy"));
  self.scenenode = computer;
  scripts\engine\utility::delaythread(1, ::computer_activate, player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210);
  do_computer_anims(player, computer);
  computer_player_allow(player, 1);
  player setclientomnvar("dpad_popup", 0);

  if(!istrue(self.disable_playeruse))
    self _meth_DFB78B3E724AD620(1);

  if(isDefined(level._id_8517E78200ECC66E))
    level[[level._id_8517E78200ECC66E]](player, self);

  self.in_use = undefined;
}

computer_activate(player, popup_omnvar, _id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210) {
  if(isDefined(_id_094BDE51D48A4DDE) && isDefined(_id_6AA6E1A0A555C210))
    setomnvar(_id_094BDE51D48A4DDE, _id_6AA6E1A0A555C210);

  player setclientomnvar("dpad_popup", popup_omnvar);
}

do_computer_anims(player, computer) {
  init_computer_anims();

  if(getdvarint("dvar_2FF085BD9A55A1D7") > 0)
    player thread computer_anim_loop_exit(player);
  else {
    player thread _id_D757E4A47FC53FB0();
    actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_stand_computer", 1, 1);
    _id_75EC024ED21C00E3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(computer, "computer_prop", 0);
    duration = getanimlength(level.scr_anim["plyr_stand_computer"]["start"]);
    player _id_116171939929AF39::_id_DB31AE430D191461(1);
    player scripts\engine\utility::delaycall(duration - 0.25, ::lerpfovscalefactor, 0.0, 0.2);
    player scripts\engine\utility::delaycall(duration - 0.05, ::lerpfovbypreset, "90_200ms_noscale");
    started = self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_75EC024ED21C00E3], "start", 1, 0) && player scripts\cp_mp\utility\player_utility::_isalive();
    player thread computer_anim_loop_exit(player);
    self.scenenode computer_anim_loop(player, actorplayer, _id_75EC024ED21C00E3);
    duration = getanimlength(level.scr_anim["plyr_stand_computer"]["stop"]);
    player _id_116171939929AF39::_id_DB31AE430D191461(0);
    player scripts\engine\utility::delaycall(duration * 0.05, ::lerpfovbypreset, "default_200ms");
    player scripts\engine\utility::delaycall(duration * 0.05, ::lerpfovscalefactor, 1.0, 0.2);
    self.scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_75EC024ED21C00E3], "stop", 0, 1);
  }
}

computer_anim_loop(player, actorplayer, _id_75EC024ED21C00E3) {
  player endon("exit_computer");
  player notify("computer_started_loop");

  while(player scripts\cp_mp\utility\player_utility::_isalive())
    scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_75EC024ED21C00E3], "use_loop", 0, 0);
}

computer_anim_loop_exit(player) {
  level endon("game_ended");
  player endon("last_stand");
  player endon("last_stand_start");
  player endon("disconnect");
  player endon("exit_computer");

  while(player useButtonPressed() || player stancebuttonPressed())
    wait 0.05;

  for(;;) {
    if(player useButtonPressed() || player stancebuttonPressed()) {
      break;
    }

    wait 0.05;
  }

  player playSound("cp_raid_computer_exit");
  player notify("exit_computer");
}

_id_D757E4A47FC53FB0() {
  self endon("disconnect");
  self.ability_invulnerable = 1;
  scripts\engine\utility::waittill_any_2("computer_started_loop", "exit_computer");
  self.ability_invulnerable = undefined;
}

computer_disconnect_handler(player) {
  player endon("exit_computer");
  player waittill("disconnect");
  self _meth_DFB78B3E724AD620(1);
}

computer_laststand_handler(player, popup_omnvar) {
  player endon("exit_computer");
  player scripts\engine\utility::waittill_any_2("last_stand", "last_stand_start");
  computer_player_allow(player, 1);

  if(isDefined(popup_omnvar))
    player setclientomnvar("dpad_popup", popup_omnvar);

  self _meth_DFB78B3E724AD620(1);
  player notify("exit_computer");
}

_id_26CA9B3A5AA15E8D(player) {
  player endon("exit_computer");
  player endon("death_or_disconnect");
  maxdist = 90000;

  for(;;) {
    dist = distance2dsquared(self.origin, player.origin);

    if(dist > maxdist) {
      break;
    }

    wait 1.5;
  }

  player notify("exit_computer");
}

computer_player_allow(player, _id_CD187E38E3DF8F36) {
  if(isDefined(player._id_FF1E46E986EDEBE5) && player._id_FF1E46E986EDEBE5 == _id_CD187E38E3DF8F36) {
    return;
  }
  if(!_id_CD187E38E3DF8F36) {
    player _id_3B64EB40368C1450::set("computer", "crouch", 0);
    player _id_3B64EB40368C1450::set("computer", "prone", 0);
    player _id_3B64EB40368C1450::set("computer", "weapon", 0);
    player _id_3B64EB40368C1450::set("computer", "usability", 0);
  } else {
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("computer");
    player setstance("stand");
    player thread _id_C5F86F6EA9CD9CF9(self);
  }

  player.usingobject = !_id_CD187E38E3DF8F36;
  player.disable_super = !_id_CD187E38E3DF8F36;
  player._id_FF1E46E986EDEBE5 = _id_CD187E38E3DF8F36;
}

_id_C5F86F6EA9CD9CF9(useobj) {
  self endon("death_or_disconnect");
  self endon("last_stand_start");

  if(getdvarint("dvar_9D3C0C8BE1C63769", 0)) {
    return;
  }
  _id_4D12D9153651CB6D = scripts\engine\utility::flatten_vector(self.origin);
  _id_AC0E594AC96AA3A8 = 0;

  while(_id_AC0E594AC96AA3A8 < 60) {
    if(scripts\engine\utility::flatten_vector(self.origin) != _id_4D12D9153651CB6D) {
      return;
    }
    _id_AC0E594AC96AA3A8++;
    wait 0.05;
  }

  self setclientomnvar("dpad_popup", useobj.popup_omnvar);
  wait 0.1;
  self setclientomnvar("dpad_popup", 0);
}

computer_event_listener(computer_name) {
  for(;;) {
    level waittill("player_computer_searched", value, computer, player);

    if(computer != computer_name) {
      continue;
    }
    self notify("computer_event", value, player);
  }
}

computer_watch_for_search(computer_name) {
  for(;;) {
    level waittill("player_computer_startsearch", value, computer, player);

    if(computer != computer_name) {
      continue;
    }
    self notify("computer_searching", value, player);
  }
}

computer_interface_think_internal(player) {
  player notify("computer_interface_think");
  player endon("computer_interface_think");
  player endon("disconnect");

  while(player useButtonPressed())
    wait 0.05;

  thread computer_laststand_handler(player);
  thread computer_disconnect_handler(player);
  thread _id_26CA9B3A5AA15E8D(player);
  player playlocalsound("cp_computer_use");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("cpu_use_spot", "script_noteworthy"));
  computer_player_allow(player, 0);
  do_computer_anims(player);
  computer_player_allow(player, 1);

  if(isDefined(level._id_8517E78200ECC66E))
    level[[level._id_8517E78200ECC66E]](player, self);
}