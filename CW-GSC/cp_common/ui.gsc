/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;
#namespace ui;

function private autoexec __init__system__() {
  system::register(#"ui", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.var_ef4974d7)) {
    level.var_ef4974d7 = [];
  }

  level thread devgui_loop();
}

function private postinit() {
  level thread game_time();
}

function game_time() {
  level flag::wait_till("game_start");
  level.n_start_time = gettime();
}

function countdown_timer(var_753cb060, var_3b192471 = "mission_fail_timer", str_team = # "any", var_9c038d31 = 1, var_f27011e3 = 1, var_3efd443d, var_edf9778a = 3, var_72f304a8 = 0, var_243f2dbe, var_f2a3a140 = array()) {
  function_d1eb8589(var_3b192471);
  level endon("destroy_ui_countdown_timer_" + var_3b192471);
  level.var_ef4974d7[var_3b192471] = spawnStruct();
  level.var_ef4974d7[var_3b192471].str_team = util::get_team_mapping(str_team);
  level.var_ef4974d7[var_3b192471].b_paused = 0;
  level.var_ef4974d7[var_3b192471].var_9c038d31 = var_9c038d31;
  level.var_ef4974d7[var_3b192471].n_time_left = var_753cb060;
  level.var_ef4974d7[var_3b192471].var_f27011e3 = var_f27011e3;
  level.var_ef4974d7[var_3b192471].var_c215d29e = var_72f304a8;

  if(level.var_ef4974d7[var_3b192471].n_time_left == 0) {
    function_c01d14b6(var_3b192471);
    return;
  }

  var_72f304a8 = var_72f304a8 || isDefined(var_243f2dbe);

  if(var_f27011e3) {
    switch (level.var_ef4974d7[var_3b192471].str_team) {
      case # "allies":
        if(is_true(var_72f304a8)) {
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.hardpoint.progress", 0);
        } else {
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.radialTimerMaxTime", var_753cb060);
        }

        clientfield::set_world_uimodel("hudItems.cpObjective.allies.progressType", var_edf9778a);
        break;
      case # "axis":
        if(is_true(var_72f304a8)) {
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.hardpoint.progress", 0);
        } else {
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.radialTimerMaxTime", var_753cb060);
        }

        clientfield::set_world_uimodel("hudItems.cpObjective.axis.progressType", var_edf9778a);
        break;
      default:
        if(is_true(var_72f304a8)) {
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.hardpoint.progress", 0);
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.hardpoint.progress", 0);
        } else {
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.radialTimerMaxTime", var_753cb060);
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.radialTimerMaxTime", var_753cb060);
        }

        clientfield::set_world_uimodel("hudItems.cpObjective.allies.progressType", var_edf9778a);
        clientfield::set_world_uimodel("hudItems.cpObjective.axis.progressType", var_edf9778a);
        break;
    }
  }

  while(level.var_ef4974d7[var_3b192471].n_time_left > 0) {
    if(var_f27011e3) {
      if(!level.var_ef4974d7[var_3b192471].var_9c038d31) {
        function_ba6cfb59(var_3b192471, 0, var_72f304a8);
      } else if(!level.var_ef4974d7[var_3b192471].b_paused) {
        function_c01d14b6(var_3b192471);
      }
    }

    waitframe(1);

    if(!level.var_ef4974d7[var_3b192471].b_paused) {
      level.var_ef4974d7[var_3b192471].n_time_left -= float(function_60d95f53()) / 1000;
    }

    n_time_left = level.var_ef4974d7[var_3b192471].n_time_left;
    var_d7b76468 = (var_753cb060 - n_time_left) / var_753cb060;

    if(isDefined(var_243f2dbe)) {
      var_d7b76468 = [[var_243f2dbe]](var_d7b76468);
      n_time_left = var_753cb060 * (1 - var_d7b76468);
    }

    if(is_true(var_72f304a8)) {
      switch (level.var_ef4974d7[var_3b192471].str_team) {
        case # "allies":
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.hardpoint.progress", var_d7b76468);
          break;
        case # "axis":
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.hardpoint.progress", var_d7b76468);
          break;
        default:
          clientfield::set_world_uimodel("hudItems.cpObjective.allies.hardpoint.progress", var_d7b76468);
          clientfield::set_world_uimodel("hudItems.cpObjective.axis.hardpoint.progress", var_d7b76468);
          break;
      }
    }

    foreach(index, var_2e453ccb in var_f2a3a140) {
      if(n_time_left <= var_2e453ccb.seconds) {
        level notify(var_2e453ccb.notify_str, {
          #var_3b192471: var_3b192471
        });
        self notify(var_2e453ccb.notify_str);
        arrayremoveindex(var_f2a3a140, index);
        break;
      }
    }

    if(isDefined(var_3efd443d)) {
      foreach(var_ed6377c1 in var_3efd443d) {
        self hud::function_b825bd3d(var_ed6377c1, var_d7b76468);
      }
    }
  }

  if(var_f27011e3) {
    function_c01d14b6(var_3b192471, 0);
  }

  self notify(var_3b192471 + "_complete");

  if(var_f27011e3) {
    function_ba6cfb59(var_3b192471, 0, var_72f304a8);
    arrayremoveindex(level.var_ef4974d7, var_3b192471, 1);
  }
}

function function_77ab7e7d(n_seconds, var_8430ebdc, var_c15fc3d5) {
  notifies = [];

  foreach(index, var_9cdf346f in var_8430ebdc) {
    if(n_seconds >= var_9cdf346f) {
      var_d67e0fa4 = spawnStruct();
      var_d67e0fa4.seconds = var_9cdf346f;
      var_d67e0fa4.notify_str = var_c15fc3d5[index];
      notifies[notifies.size] = var_d67e0fa4;
    }
  }

  return notifies;
}

function private function_c01d14b6(var_3b192471, n_time_left) {
  if(isDefined(n_time_left)) {
    level.var_ef4974d7[var_3b192471].n_time_left = n_time_left;
  }

  var_1c0820a1 = gettime() + 1000 + int(level.var_ef4974d7[var_3b192471].n_time_left * 1000);
  function_ba6cfb59(var_3b192471, 1, !is_true(level.var_ef4974d7[var_3b192471].var_c215d29e));

  switch (level.var_ef4974d7[var_3b192471].str_team) {
    case # "allies":
      setbombtimer("A", var_1c0820a1);
      break;
    case # "axis":
      setbombtimer("B", var_1c0820a1);
      break;
    default:
      setbombtimer("A", var_1c0820a1);
      setbombtimer("B", var_1c0820a1);
      break;
  }
}

function private function_ba6cfb59(var_3b192471, b_enable = 1, var_96dc7504 = 1) {
  if(!is_true(level.var_ef4974d7[var_3b192471].var_f27011e3)) {
    return;
  }

  str_team = level.var_ef4974d7[var_3b192471].str_team;

  switch (str_team) {
    case # "allies":
      setmatchflag("bomb_timer_a", is_true(b_enable && var_96dc7504));
      break;
    case # "axis":
      setmatchflag("bomb_timer_b", is_true(b_enable && var_96dc7504));
      break;
    default:
      setmatchflag("bomb_timer_a", is_true(b_enable && var_96dc7504));
      setmatchflag("bomb_timer_b", is_true(b_enable && var_96dc7504));
      break;
  }

  if(!b_enable) {
    switch (str_team) {
      case # "allies":
        clientfield::set_world_uimodel("hudItems.cpObjective.allies.progressType", 0);
        break;
      case # "axis":
        clientfield::set_world_uimodel("hudItems.cpObjective.axis.progressType", 0);
        break;
      default:
        clientfield::set_world_uimodel("hudItems.cpObjective.allies.progressType", 0);
        clientfield::set_world_uimodel("hudItems.cpObjective.axis.progressType", 0);
        break;
    }
  }
}

function function_b4e596c2(var_3b192471, n_time, str_notify) {
  level endon("destroy_ui_countdown_timer_" + var_3b192471);
  self endon(var_3b192471 + "_complete");
  assert(isDefined(level.var_ef4974d7[var_3b192471]), "<dev string:x38>" + var_3b192471);

  while(level.var_ef4974d7[var_3b192471].n_time_left > n_time) {
    waitframe(1);
  }

  if(isDefined(str_notify)) {
    self notify(str_notify);
    return;
  }

  self notify("timer_" + var_3b192471 + "_reached_" + n_time);
}

function function_d1eb8589(var_3b192471 = "mission_fail_timer") {
  if(isDefined(level.var_ef4974d7[var_3b192471])) {
    level notify("destroy_ui_countdown_timer_" + var_3b192471);
    function_ba6cfb59(var_3b192471, 0, level.var_ef4974d7[var_3b192471].var_316c2f69);
    arrayremoveindex(level.var_ef4974d7, var_3b192471, 1);
  }
}

function function_f7aafb81(var_3b192471 = "mission_fail_timer") {
  if(isDefined(level.var_ef4974d7[var_3b192471])) {
    level.var_ef4974d7[var_3b192471].b_paused = 1;
  }
}

function function_bb62027a(var_3b192471 = "mission_fail_timer") {
  if(isDefined(level.var_ef4974d7[var_3b192471])) {
    level.var_ef4974d7[var_3b192471].b_paused = 0;
  }
}

function function_c061766e(var_3b192471 = "mission_fail_timer") {
  if(isDefined(level.var_ef4974d7[var_3b192471])) {
    level.var_ef4974d7[var_3b192471].var_9c038d31 = 1;
  }
}

function function_7ec9d70a(var_3b192471 = "mission_fail_timer") {
  if(isDefined(level.var_ef4974d7[var_3b192471])) {
    level.var_ef4974d7[var_3b192471].var_9c038d31 = 0;
  }
}

function function_7856e5e0(var_3b192471 = "mission_fail_timer") {
  assert(isDefined(level.var_ef4974d7[var_3b192471]), "<dev string:x5a>" + var_3b192471 + "<dev string:x6e>");
  return level.var_ef4974d7[var_3b192471].n_time_left;
}

function game_result(str_winning_team) {
  foreach(player in level.players) {
    player val::set(#"game_result", "freezecontrols_allowlook");
    player playlocalsound(#"hash_339c0a10af56146d");

    if(!isbot(player)) {
      if(str_winning_team == # "none") {
        var_1a47c004 = # "hash_694986fb14b7d7dd";
        var_1da53c42 = # "hash_42774b4d7620fcbc";
      } else if(player util::is_on_side(str_winning_team)) {
        var_1a47c004 = # "hash_5379a106e94c7ecc";
        var_1da53c42 = # "hash_26e1226347737c3c";
      } else {
        var_1a47c004 = # "hash_694986fb14b7d7dd";
        var_1da53c42 = # "hash_6e65cf69191bdda7";
      }

      player luinotifyevent(#"pre_killcam_transition", 4, 1, level.teamindex[util::get_team_mapping(str_winning_team)], var_1a47c004, var_1da53c42);
    }
  }
}

function private devgui_loop() {
  while(true) {
    wait 0.25;
    dvarstr = getdvarstring(#"devgui_ui", "<dev string:x80>");

    if(dvarstr == "<dev string:x80>") {
      continue;
    }

    setDvar(#"devgui_ui", "<dev string:x80>");
    args = strtok(dvarstr, "<dev string:x84>");
    host = util::gethostplayer();

    if(!isDefined(host)) {
      continue;
    }

    switch (args[0]) {
      case # "comms":
        host function_97f309cb(args[1]);
        break;
      case # "specialist_comms":
        host function_97f309cb(args[1], args[2]);
        break;
      case # "prompt":
        host function_f29c45f6(args[1]);
        break;
    }
  }
}

function private function_97f309cb(portraitid, var_e9f94d47) {
  if(!isDefined(var_e9f94d47)) {
    var_e9f94d47 = undefined;
  }

  if(isDefined(portraitid)) {
    if(isDefined(var_e9f94d47)) {
      self luinotifyevent(#"offsite_comms_message", 2, portraitid, var_e9f94d47);
    } else {
      self luinotifyevent(#"offsite_comms_message", 1, portraitid);
    }

    return;
  }

  self luinotifyevent(#"offsite_comms_complete");
}

function private function_f29c45f6(index) {
  if(!isDefined(index)) {
    index = 0;
  }

  if(isstring(index)) {
    index = int(index);
  }

  self clientfield::set_player_uimodel("<dev string:x89>", index);
}