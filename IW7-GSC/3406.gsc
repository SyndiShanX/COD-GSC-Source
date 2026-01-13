/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3406.gsc
*********************************************/

fast_travel_init() {
  scripts\engine\utility::flag_init("fast_travel_init_done");
  level.end_portal_name = "main_street";
  level.var_8E63 = 0;
  func_95D9();
  level.fast_travel_spots = [];
  level.var_6B91 = [];
  var_0 = scripts\engine\utility::getstructarray("fast_travel", "script_noteworthy");
  level.var_5592 = ::disable_teleportation;
  level.var_6B8D = ::func_126BF;
  level.portal_exit_fx_org = (646.605, 701.459, 105.882);
  foreach(var_2 in var_0) {
    level.var_6B91[level.var_6B91.size] = var_2;
    var_2 func_95DA();
  }

  scripts\engine\utility::flag_set("fast_travel_init_done");
  level thread func_8E62();
  level thread func_B23A();
  level thread func_172F();
  level thread func_172E();
  scripts\engine\utility::flag_init("disable_portals");
  scripts\engine\utility::flag_init("pap_portal_used");
}

func_95D9() {
  level._effect["hidden_room_portal_locked"] = loadfx("vfx\iw7\_requests\coop\vfx_cp_z_portal_01_idle.vfx");
  level._effect["hidden_room_portal_locked_exit"] = loadfx("vfx\iw7\_requests\coop\vfx_cp_z_portal_01_out.vfx");
  level._effect["hidden_room_portal_locked_charging"] = loadfx("vfx\iw7\levels\cp_zmb\vfx_cp_z_portal_01.vfx");
  level._effect["hidden_room_portal"] = loadfx("vfx\iw7\core\impact\energy_sm\vfx_cp_z_portal_02.vfx");
}

func_95DA() {
  level endon("game_ended");
  var_0 = getEntArray("portal_center", "targetname");
  var_1 = level.end_portal_name == self.script_area;
  if(!var_1) {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, var_0);
    self.var_D682 = var_0[0];
    func_F4AA();
  } else {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, var_0);
    self.var_D682 = var_0[0];
    func_F4AA();
  }

  self.end_positions = scripts\engine\utility::getstructarray(self.target, "targetname");
  level.fast_travel_spots[self.script_area] = self;
  var_2 = getEntArray("portal_trigger", "targetname");
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_2);
  self.var_D680 = var_2[0];
  self.portal_can_be_started = 0;
  thread func_D681();
  var_3 = getEntArray(self.target, "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_3);
  self.setminimap = var_3[0];
  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  self.powered_on = 0;
  self.portal_can_be_started = 0;
  self.var_D67E = 0;
  self.portal_charging = 0;
  thread func_8947(var_1);
}

func_8947(var_0) {
  var_1 = self.script_area;
  if(var_1 == "moon") {
    var_2 = getEntArray("rangetarget", "targetname");
    foreach(var_4 in var_2) {
      var_4 hide();
    }
  }

  if(var_0) {
    for(;;) {
      var_6 = level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "portal_on", "power_off");
      if(var_6 != "power_off") {
        self.powered_on = 1;
        self.portal_can_be_started = 1;
        turn_on_exit_portal_fx(0);
        getent("center_portal", "targetname") setscriptablepartstate("model", "on");
        continue;
      }

      self.powered_on = 0;
      turn_on_exit_portal_fx(0);
      wait(0.25);
    }

    return;
  }

  for(;;) {
    var_6 = level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
    if(scripts\engine\utility::flag("disable_portals")) {
      continue;
    }

    if(var_6 != "power_off") {
      if(scripts\cp\utility::map_check(0)) {
        level thread scripts\cp\cp_vo::add_to_nag_vo("dj_portal_use_nag", "zmb_dj_vo", 60, 15, 2, 1);
      }

      scripts\cp\cp_vo::try_to_play_vo_on_all_players("nag_use_portal", 1);
      switch (var_1) {
        default:
          self.powered_on = 1;
          self.portal_can_be_started = 1;
          self.var_D67E = 0;
          self.portal_charging = 0;
          if(isDefined(self.setminimap)) {
            self.setminimap setlightintensity(1);
          }

          func_F556();
          level notify("portal_on");
          break;
      }
    } else {
      self.powered_on = 0;
      if(isDefined(self.var_D682)) {
        self.var_D682 stoploopsound();
        func_F4AA();
      }

      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(0);
      }
    }

    wait(0.25);
  }
}

pap_timer_start() {
  self endon("disconnect");
  if(!isDefined(self.pap_timer_running)) {
    self.pap_timer_running = 1;
    var_0 = 30;
    self setclientomnvar("zombie_papTimer", var_0);
    wait(1);
    for(;;) {
      var_0--;
      if(var_0 < 0) {
        var_0 = 30;
        wait(1);
        break;
      }

      self setclientomnvar("zombie_papTimer", var_0);
      wait(1);
    }

    self setclientomnvar("zombie_papTimer", -1);
    self notify("kicked_out");
    wait(30);
    self.pap_timer_running = undefined;
  }
}

func_172F() {
  var_0 = getent("fast_travel_tube_start", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_zmb_portal_base_01"], var_0.origin + (0, 0, 15), var_1);
  triggerfx(var_2);
  var_0 = getent("fast_travel_tube_end", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_zmb_portal_centhub"], var_0.origin + (0, 0, 15), var_1);
  triggerfx(var_2);
}

func_172E() {
  var_0 = getent("hidden_travel_tube_start", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_zmb_portal_centhub"], var_0.origin + (0, 0, 15), var_1);
  triggerfx(var_2);
  var_0 = getent("hidden_travel_tube_end", "targetname");
  var_1 = anglesToForward(var_0.angles + (0, 180, 0));
  var_2 = spawnfx(level._effect["hidden_room_portal"], var_0.origin + (0, 0, 15), var_1);
  triggerfx(var_2);
}

fast_travel_hint_logic(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return "";
  }

  if(var_0.requires_power && !var_0.powered_on) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(var_0.script_area == level.end_portal_name) {
    if(scripts\engine\utility::istrue(level.var_8E61)) {
      return &"CP_ZMB_INTERACTIONS_HIDDEN_TELEPORT";
    } else if(level.var_8E63) {
      return &"COOP_INTERACTIONS_COOLDOWN";
    } else {
      return &"CP_ZMB_INTERACTIONS_EXIT_PORTAL";
    }
  }

  if(!scripts\engine\utility::istrue(var_0.portal_can_be_started)) {
    if(var_0.var_D67E) {
      return &"COOP_INTERACTIONS_COOLDOWN";
    } else {
      return "";
    }
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

disable_teleportation(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 scripts\cp\utility::allow_player_teleport(0);
  var_0 waittill(var_2);
  wait(var_1);
  if(!var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(1);
  }

  var_0 notify("can_teleport");
}

run_fast_travel_logic(var_0, var_1) {
  if(scripts\engine\utility::flag("disable_portals")) {
    return;
  }

  if(!var_1 scripts\cp\utility::isteleportenabled()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.portal_can_be_started)) {
    return;
  }

  var_2 = 0.5;
  if(var_0.script_area != level.end_portal_name) {
    if(scripts\engine\utility::flag("disable_portals")) {
      var_1 scripts\cp\cp_interaction::refresh_interaction();
      return;
    }

    var_3 = 0;
    if(var_1 scripts\cp\cp_persistence::player_has_enough_currency(var_3)) {
      var_1 scripts\cp\cp_interaction::take_player_money(var_3, "fast_travel");
      var_0 thread func_6B8B();
      return;
    }

    var_1 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::istrue(level.var_8E61)) {
    var_1 thread disable_teleportation(var_1, var_2, "fast_travel_complete");
    var_0 thread travel_through_hidden_tube(var_1);
  }
}

func_6AF8(var_0) {
  self.wor_phase_shift = 1;
  scripts\cp\powers\coop_phaseshift::func_6626(1, var_0);
  wait(var_0);
  if(scripts\engine\utility::istrue(self.wor_phase_shift)) {
    scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    self.wor_phase_shift = 0;
  }
}

func_126BF(var_0, var_1) {
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_2 = move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", var_1);
  level.fast_travel_spots[level.end_portal_name] teleport_to_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_3 = (646.605, 701.459, 105.882);
  var_4 = anglesToForward((0, 90, 0));
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_3, var_4);
  wait(0.1);
  var_2 delete();
  if(!isDefined(var_1)) {
    if(!scripts\engine\utility::istrue(self.used_once)) {
      self.used_once = 1;
      var_5 = 0;
      var_6 = self.script_area;
      switch (var_6) {
        case "moon":
          var_5 = 1;
          break;

        case "europa":
          var_5 = 2;
          break;

        case "mars":
          var_5 = 3;
          break;

        case "arcade":
          var_5 = 0;
          break;

        default:
          var_5 = 0;
          break;
      }

      level notify("turn_on_portal_light", int(var_5));
      if(func_1BF8()) {
        level.last_portal_opener = var_0;
      }
    }
  }

  var_0 notify("fast_travel_complete");
}

func_CE6F(var_0, var_1) {
  if(!isDefined(level.var_12913)) {
    level.var_12913 = 1;
  }

  if(scripts\engine\utility::istrue(var_0.used_once)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1)) {
    return;
  }

  switch (level.var_12913) {
    case 1:
      self playlocalsound("announcer_portal_1of4");
      break;

    case 2:
      self playlocalsound("announcer_portal_2of4");
      break;

    case 3:
      self playlocalsound("announcer_portal_3of4");
      break;

    case 4:
      level notify("pap_portal_unlocked");
      self playlocalsound("announcer_portal_4of4");
      break;

    default:
      break;
  }

  level.var_12913++;
}

travel_through_hidden_tube(var_0) {
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0 notify("delete_equipment");
  var_0.disable_consumables = 1;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_start", "hidden_travel_tube_end");
  var_0 teleport_to_hidden_room();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
}

hidden_room_exit_tube(var_0) {
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_end", "hidden_travel_tube_start", 1);
  level.fast_travel_spots[level.end_portal_name] teleport_to_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  if(scripts\engine\utility::istrue(var_0.wor_phase_shift)) {
    var_0 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    var_0.wor_phase_shift = 0;
  }

  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

set_in_pap_room(var_0, var_1) {
  var_0.is_in_pap = var_1;
}

is_in_pap_room(var_0) {
  return scripts\engine\utility::istrue(self.is_in_pap);
}

move_through_tube(var_0, var_1, var_2, var_3) {
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_4 = getent(var_1, "targetname");
  var_5 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_6 = var_4.origin + (0, 0, -45);
  var_7 = var_5.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_4.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_8 = spawn("script_origin", var_6);
  var_0 playerlinkto(var_8);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_8 moveto(var_7, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_8;
}

func_B23A() {
  var_0 = 0;
  var_1 = getent("center_portal", "targetname");
  while(var_0 < 4) {
    level waittill("turn_on_portal_light", var_2);
    var_3 = undefined;
    switch (var_2) {
      case 0:
        var_1 setscriptablepartstate("light2", "show");
        break;

      case 1:
        var_1 setscriptablepartstate("light1", "show");
        break;

      case 2:
        var_1 setscriptablepartstate("light3", "show");
        break;

      case 3:
        var_1 setscriptablepartstate("light4", "show");
        break;
    }

    var_0++;
  }
}

teleport_to_safe_spot(var_0) {
  var_1 = undefined;
  while(!isDefined(var_1)) {
    foreach(var_3 in self.end_positions) {
      if(!positionwouldtelefrag(var_3.origin)) {
        var_1 = var_3;
      }
    }

    if(!isDefined(var_1)) {
      var_5 = scripts\cp\utility::vec_multiply(anglesToForward(self.end_positions[0].angles, 64));
      var_1 = self.end_positions[0].origin + var_5;
    }

    wait(0.1);
  }

  var_0 playershow();
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_1.origin);
  var_0 setplayerangles(var_1.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("portal_exit", "zmb_comment_vo");
}

func_1BF8() {
  if(getdvarint("debug_teleport_quest_done", 0) == 1) {
    return 1;
  }

  foreach(var_1 in level.fast_travel_spots) {
    if(var_1.script_area == level.end_portal_name) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_1.used_once)) {
      return 0;
    }
  }

  return 1;
}

func_8E62() {
  for(;;) {
    if(func_1BF8()) {
      break;
    }

    wait(0.1);
  }

  if(isDefined(level.last_portal_opener)) {
    if(isDefined(level.last_portal_opener.vo_prefix)) {
      switch (level.last_portal_opener.vo_prefix) {
        case "p1_":
          level thread scripts\cp\cp_vo::try_to_play_vo("portal_pap_valleygirl_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p2_":
          level thread scripts\cp\cp_vo::try_to_play_vo("portal_pap_nerd_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p3_":
          level thread scripts\cp\cp_vo::try_to_play_vo("portal_pap_rapper_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        case "p4_":
          level thread scripts\cp\cp_vo::try_to_play_vo("portal_pap_jock_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          break;

        default:
          break;
      }
    }
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::add_to_nag_vo("nag_find_pap", "zmb_comment_vo", 60, 15, 6, 1);
  }

  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_pap1_nag", "zmb_dj_vo", 120, 100, 2, 1);
  func_15B6();
}

func_15B6() {
  level endon("game_ended");
  level thread turn_on_room_exit_portal();
  for(;;) {
    level.var_8E61 = 1;
    turn_on_exit_portal_fx(1);
    level waittill("hidden_room_portal_used");
    if(scripts\engine\utility::istrue(level.open_sesame)) {
      continue;
    }

    wait(30);
    level.var_8E61 = 0;
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_start");
    turn_on_exit_portal_fx(0);
    wait(60);
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_over");
  }
}

turn_on_exit_portal_fx(var_0) {
  if(var_0) {
    getent("center_portal", "targetname") setscriptablepartstate("portal", "active");
    return;
  }

  getent("center_portal", "targetname") setscriptablepartstate("portal", "powered_on");
}

turn_on_room_exit_portal() {
  var_0 = getent("hidden_room_portal", "targetname");
  var_1 = anglesToForward(var_0.angles);
  var_2 = spawnfx(level._effect["vfx_zmb_portal_centhub"], var_0.origin, var_1);
  triggerfx(var_2);
  teleport_from_hidden_room_before_time_up(var_0);
}

teleport_from_hidden_room_before_time_up(var_0) {
  var_0 makeusable();
  var_0 sethintstring(&"CP_ZMB_INTERACTIONS_HIDDEN_LEAVE");
  var_0.portal_is_open = 1;
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1.kicked_out)) {
      var_1 notify("left_hidden_room_early");
      var_1.disable_consumables = 1;
      hidden_room_exit_tube(var_1);
    }

    wait(0.1);
  }
}

teleport_to_hidden_room() {
  self endon("left_hidden_room_early");
  set_in_pap_room(self, 1);
  scripts\cp\utility::adddamagemodifier("papRoom", 0, 0);
  self.is_off_grid = 1;
  self.disable_consumables = undefined;
  var_0 = scripts\engine\utility::getstruct("hidden_room_spot", "targetname");
  self unlink();
  self dontinterpolate();
  scripts\cp\powers\coop_powers::power_enablepower();
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  self playershow();
  level notify("hidden_room_portal_used");
  thread hidden_room_timer();
}

hidden_room_timer() {
  self endon("left_hidden_room_early");
  self endon("disconnect");
  self endon("last_stand");
  self.kicked_out = undefined;
  if(!scripts\engine\utility::flag("pap_portal_used")) {
    scripts\engine\utility::flag_set("pap_portal_used");
  }

  thread pap_timer_start();
  level thread pap_vo(self);
  self waittill("kicked_out");
  self.kicked_out = 1;
  level thread hidden_room_exit_tube(self);
}

pap_vo(var_0) {
  if(level.pap_firsttime != 1) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "zmb_pap_vo");
  }

  level.pap_firsttime = 1;
  wait(4);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
}

func_6B8B() {
  self.portal_can_be_started = 0;
  self.var_D682.angles = self.var_D682.angles + (0, 180, 0);
  self.portal_charging = 1;
  func_F2FE();
  wait(3);
  self.portal_charging = 0;
  self.portal_is_open = 1;
  func_F28A();
  wait(15);
  self.portal_is_open = 0;
  func_F30B();
  self.var_D682.angles = self.var_D682.angles - (0, 180, 0);
  self.var_D682 stoploopsound();
  self.setminimap setlightintensity(0);
  self.var_D67E = 1;
  wait(30);
  self.portal_can_be_started = 1;
  self.var_D67E = 0;
  refresh_piccadilly_civs_array();
  self.setminimap setlightintensity(10);
  func_F556();
}

refresh_piccadilly_civs_array() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.last_interaction_point) && var_1.last_interaction_point == self) {
      var_1 scripts\cp\cp_interaction::refresh_interaction();
    }
  }
}

portal_close_fx() {
  if(isDefined(self.var_D67C)) {
    self.var_D67C delete();
  }
}

func_D681() {
  level endon("game_ended");
  if(!isDefined(self.var_D680)) {
    return;
  }

  self.portal_is_open = 0;
  var_0 = 0.5;
  for(;;) {
    self.var_D680 waittill("trigger", var_1);
    if(scripts\engine\utility::flag("disable_portals")) {
      wait(0.05);
      continue;
    }

    if(isplayer(var_1) && self.portal_is_open) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        wait(0.05);
        continue;
      }

      scripts\cp\zombies\zombie_analytics::func_AF85(level.wave_num, self.script_area);
      if(scripts\engine\utility::istrue(level.wor_portal_change_time)) {
        var_1 thread disable_teleportation(var_1, var_0, "fast_travel_complete");
        var_1 thread func_6AF8(30);
        level notify("player_entering_wor_changed_portal", var_1);
        thread travel_through_hidden_tube(var_1);
      } else {
        var_1 thread disable_teleportation(var_1, var_0, "fast_travel_complete");
        thread func_126BF(var_1);
      }
    }

    wait(0.1);
  }
}

func_F556() {
  self.var_D682 setscriptablepartstate("portal", "powered_on");
}

func_F2FE() {
  self.var_D682 setscriptablepartstate("portal", "charging");
}

func_F4AA() {
  self.var_D682 setscriptablepartstate("portal", "off");
}

func_F28A() {
  self.var_D682 setscriptablepartstate("portal", "active");
}

func_F30B() {
  self.var_D682 setscriptablepartstate("portal", "off");
}