/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\battle_tracks.gsc
********************************************/

#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace battle_tracks;

function init() {
  level.monitorstandingonvehiclethrottle = throttle::throttle_initialize("monitorStandingOnVehicle_throttle", 15, 0.5);
  projectbundle = getprojectscriptbundle();

  if(isDefined(projectbundle)) {
    vehicletracklistname = hashcat(%"hash_5c338ed91460dbe1", projectbundle.vehicletracklist);
  } else {
    assertmsg("<dev string:x24>");
    return;
  }

  level.vehicletracklist = getscriptbundle(vehicletracklistname).vehicletracklist;

  if(!isDefined(level.vehicletracklist)) {
    return;
  }

  foreach(index, trackinfo in level.vehicletracklist) {
    if(index <= 1) {
      continue;
    }

    if(!isDefined(trackinfo.vehicletrack)) {
      continue;
    }

    trackname = hashcat(%"hash_8f87dca26d14f0d", trackinfo.vehicletrack);
    var_398625bea915896 = getscriptbundlefieldvalues(trackname, [#"ingamesfxalias", #"ingamemusicstate"]);
    trackinfo.ingamesfxalias = var_398625bea915896.ingamesfxalias;
    trackinfo.ingamemusicstate = var_398625bea915896.ingamemusicstate;

    if(!isDefined(trackinfo.ingamesfxalias)) {
      assertmsg("<dev string:x60>" + trackinfo.vehicletrack);
    }

    if(!isDefined(trackinfo.ingamemusicstate)) {
      assertmsg("<dev string:x86>" + trackinfo.vehicletrack);
    }
  }
}

function on_enter_vehicle(vehicle, player) {
  if(function_98a4262da2114872(player)) {
    function_7cc783ef7693ce1a(player);

    if(!function_d0f537105677946d(vehicle, player)) {
      function_482d28a40f664fcf(player);
    }
  }

  if(function_175fcb8dec0707a(vehicle)) {
    function_7b6150da5d44a400(vehicle, player, 0);
  }
}

function vehicle_occupancy_enter(vehicle, player, seatid, oldseatid) {
  isdriverseat = vehicle_occupancy::function_d4f0603190ab379f(vehicle, seatid);
  isbattletracksowner = function_43834de46c196376(vehicle, player);
  function_7c84110a2c9c894f(vehicle, player, oldseatid);
  function_c910157cea5c0954(player);

  if(isdriverseat) {
    if(!isbattletracksowner) {
      function_b3b4a8466e3ef2b1(vehicle);
      update_battle_tracks(vehicle, player);
    }

    if(function_175fcb8dec0707a(vehicle)) {
      function_d451d9fddcd1aa5f(vehicle);
    }

    if(!function_c808eddfd852442c(vehicle)) {
      player thread toggle_think(player, vehicle);
    }
  }
}

function on_exit_vehicle(vehicle, player, seatid) {
  function_3e1312745ee699b2(vehicle.battletracksmusicstate, player, 0);
  function_7c84110a2c9c894f(vehicle, player, seatid);
  function_c910157cea5c0954(player);
  isbattletracksowner = function_43834de46c196376(vehicle, player);

  if(isbattletracksowner) {
    function_b3b4a8466e3ef2b1(vehicle);
    clear_battle_tracks(vehicle);
  }
}

function function_4d496ad4a720fdd5(player) {
  if(!isDefined(level.monitorstandingonvehiclethrottle)) {
    return;
  }

  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    throttle::throttle_wait_in_queue(level.monitorstandingonvehiclethrottle, player);
    function_7d6b782d39e720af(player);
  }
}

function private update_battle_tracks(vehicle, player) {
  vehicle.battletracks = [];
  vehicle.battletracksowner = player;
  vehicle.battletracksmusicstate = "";

  if(function_25407aba6aeab037(vehicle, player)) {
    function_28abebc210f16c89(vehicle, player, 1, 9);
  } else {
    function_28abebc210f16c89(vehicle, player, 0, 9);
  }

  if(function_9255747b6c80fec5()) {
    vehicle.battletracks = function_870c977ebe2b0ac8(vehicle);
  }

  vehicle.battletracks = utility::array_randomize(vehicle.battletracks);
}

function private function_28abebc210f16c89(vehicle, player, startindex, endindex) {
  data = vehicle::function_9f6a9bf9120d5a37(vehicle vehicle::get_ref());

  for(arrayindex = startindex; arrayindex <= endindex; arrayindex++) {
    trackindex = function_63492c16f530e2a9(vehicle, player, arrayindex, data);

    if(getdvarint(@ "hash_aa9c7230c056a9f8", 0) > 0) {
      trackindex = getdvarint(@ "hash_aa9c7230c056a9f8");
    }

    if(trackindex > 1) {
      if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
        sfxalias = function_822ddd5a38d19c29(trackindex);

        if(isDefined(sfxalias) && sfxalias != "") {
          vehicle.battletracks[vehicle.battletracks.size] = sfxalias;
          function_fab582dbfec3f8c(vehicle, trackindex);
        }

        continue;
      }

      vehicle.battletracks[vehicle.battletracks.size] = trackindex;
    }
  }
}

function private function_fab582dbfec3f8c(vehicle, trackindex) {
  musicstate = function_6d02b9ca0dd1cd38(trackindex);

  if(vehicle.battletracksmusicstate == "") {
    vehicle.battletracksmusicstate = musicstate;
    return;
  }

  assert(vehicle.battletracksmusicstate == musicstate, "<dev string:xae>");
}

function private function_25407aba6aeab037(vehicle, player) {
  data = vehicle::function_9f6a9bf9120d5a37(vehicle vehicle::get_ref());
  firsttrackindex = function_63492c16f530e2a9(vehicle, player, 0, data);
  return firsttrackindex == 1;
}

function private function_63492c16f530e2a9(vehicle, player, arrayindex, data) {
  debugindex = getdvarint(@ "hash_97029a354c4876c0", 0);

  if(debugindex != 0) {
    return debugindex;
  }

  if(isDefined(data) && isDefined(data.ref)) {
    trackindex = player utility::callsharedfunc(#"player", #"getplayerdata", level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "tracks", arrayindex);
    return trackindex;
  }

  return undefined;
}

function private function_822ddd5a38d19c29(trackindex) {
  if(isDefined(level.vehicletracklist) && isDefined(level.vehicletracklist[trackindex])) {
    return level.vehicletracklist[trackindex].ingamesfxalias;
  }
}

function private function_6d02b9ca0dd1cd38(trackindex) {
  if(isDefined(level.vehicletracklist) && isDefined(level.vehicletracklist[trackindex])) {
    return level.vehicletracklist[trackindex].ingamemusicstate;
  }
}

function private function_d451d9fddcd1aa5f(vehicle) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
    all_occupants = vehicle_occupancy::get_all_occupants(vehicle, 1);

    if(isDefined(vehicle.turretoccupants)) {
      all_occupants = arraycombineunique(all_occupants, vehicle.turretoccupants);
    }

    foreach(occupant in all_occupants) {
      function_7b6150da5d44a400(vehicle, occupant, 0);
    }

    return;
  }

  vehicle setvehiclewartracksstate(vehicle.battletracks);
}

function private function_b3b4a8466e3ef2b1(vehicle) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
    all_occupants = vehicle_occupancy::get_all_occupants(vehicle, 1);

    if(isDefined(vehicle.turretoccupants)) {
      all_occupants = arraycombineunique(all_occupants, vehicle.turretoccupants);
    }

    foreach(occupant in all_occupants) {
      function_3e1312745ee699b2(vehicle.battletracksmusicstate, occupant, 0);
    }

    return;
  }

  vehicle stopvehiclewartracks();
}

function private function_7b6150da5d44a400(vehicle, player, var_ca21b28965eff8a3) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) != 0) {
    return;
  }

  isbattletracksowner = function_43834de46c196376(vehicle, player);

  if(isDefined(vehicle.battletracks) && isDefined(vehicle.battletracksmusicstate) && isDefined(player)) {
    if(isDefined(vehicle.battletracksowner) && (isbattletracksowner || var_ca21b28965eff8a3 || player getwartrackpassengerenabled())) {
      vehiclebattletracksid = function_7a721cbb76c07b7a(vehicle);

      if(!function_79be5acf788f128b(vehicle, player, vehiclebattletracksid)) {
        function_aafad573e2b0040(vehicle, player);

        player.battletracksmusicstate = vehicle.battletracksmusicstate;
        player.battletracksid = vehiclebattletracksid;
        player setplayermusicstate(vehicle.battletracksmusicstate, vehicle.battletracks, vehicle, (0, 0, 0));
      }
    }

    if(!isbattletracksowner && !var_ca21b28965eff8a3) {
      player thread function_6daf9fd5aef4f91d(player, vehicle);
    }
  }
}

function private function_79be5acf788f128b(vehicle, player, vehiclebattletracksid) {
  if(!isDefined(player.battletracksmusicstate)) {
    return false;
  }

  if(!isDefined(player.battletracksid)) {
    return false;
  }

  return player.battletracksmusicstate == vehicle.battletracksmusicstate && player.battletracksid == vehiclebattletracksid;
}

function private function_3e1312745ee699b2(battletracksmusicstate, player, var_ca21b28965eff8a3) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) != 0) {
    return;
  }

  if(function_98a4262da2114872(player)) {
    if(isDefined(battletracksmusicstate) && isDefined(player)) {
      function_82c62238872f4386(battletracksmusicstate, player);

      player.battletracksmusicstate = undefined;
      player.battletracksid = undefined;
      player stopplayermusicstate(battletracksmusicstate);

      if(!var_ca21b28965eff8a3) {
        player notify("stop_battle_tracks_option_watch");
      }
    }
  }
}

function private function_98a4262da2114872(player) {
  return isDefined(player.battletracksmusicstate) && isDefined(player.battletracksid);
}

function private function_43834de46c196376(vehicle, player) {
  return vehicle.battletracksowner == player;
}

function private clear_battle_tracks(vehicle) {
  vehicle.battletracksowner = undefined;
  vehicle.battletracks = undefined;
  vehicle.battletracksmusicstate = undefined;
}

function private function_c808eddfd852442c(vehicle) {
  if(!isDefined(vehicle.battletracks)) {
    return true;
  }

  if(vehicle.battletracks.size == 0) {
    return true;
  }

  return false;
}

function private toggle_think(player, vehicle) {
  player notify("stop_battle_tracks_toggle_think");
  player endon("stop_battle_tracks_toggle_think");
  player endon("death_or_disconnect");
  player endon("last_stand_enter");
  function_acc1a2cc615ba009(player);
  currenttogglestate = get_toggle_state(player);
  update_toggle_state(player, vehicle, currenttogglestate);
  requirehold = player utility::is_player_gamepad_enabled();

  if(requirehold) {
    if(vehicle vehicle::ishelicopter()) {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+melee_zoom");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-melee_zoom");
      player.battletracktogglebutton = "melee_zoom";
    } else {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+frag");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-frag");
      player.battletracktogglebutton = "frag";
    }
  } else {
    player notifyonplayercommand("update_battle_tracks_toggle_state", "nightvision");
    player.battletracktogglebutton = "nightvision";
  }

  while(true) {
    player setclientomnvar("ui_veh_music_toggle_button_holdtime", 0);
    player waittill("update_battle_tracks_toggle_state");
    newtogglestate = function_755eaaa856a3fcda(player);

    if(requirehold) {
      player childthread function_ecfb841cd2e72748();
      result = player utility::waittill_notify_or_timeout_return("cancel_battle_tracks_toggle_state", 0.25);

      if(result == "timeout") {
        player notify("cancel_battle_tracks_toggle_state");
        update_toggle_state(player, vehicle, newtogglestate);
      }

      continue;
    }

    update_toggle_state(player, vehicle, newtogglestate);
  }
}

function private function_ecfb841cd2e72748() {
  self endon("cancel_battle_tracks_toggle_state");
  progress = 0;

  while(true) {
    progress += level.framedurationseconds;
    self setclientomnvar("ui_veh_music_toggle_button_holdtime", min(1, progress / 0.25));
    waitframe();
  }
}

function private update_toggle_state(player, vehicle, togglestate) {
  switch (togglestate) {
    case #"hash_fa2ad6f6bd651030":
      toggle_on_state(player, vehicle);
      break;
    case #"hash_3699ac6c262c25ea":
      toggle_off_state(player, vehicle);
      break;
  }
}

function private toggle_on_state(player, vehicle) {
  set_toggle_state(player, "on");
  function_d451d9fddcd1aa5f(vehicle);
}

function private toggle_off_state(player, vehicle) {
  set_toggle_state(player, "off");
  function_b3b4a8466e3ef2b1(vehicle);
}

function private function_755eaaa856a3fcda(player) {
  switch (player.pers["battleTracksToggleState"]) {
    case #"hash_fa2ad6f6bd651030":
      return "off";
    case #"hash_3699ac6c262c25ea":
      return "on";
  }
}

function private function_acc1a2cc615ba009(player) {
  if(!isDefined(player.pers["battleTracksToggleState"])) {
    set_toggle_state(player, "on");
  }
}

function private set_toggle_state(player, value) {
  if(!player function_5c766d1d0140b86("ui_veh_battle_tracks_toggle_state")) {
    return;
  }

  player.pers["battleTracksToggleState"] = value;
  var_fb5d97f2bb9a9a3a = player getclientomnvar("ui_veh_battle_tracks_toggle_state");

  switch (value) {
    case #"hash_fa2ad6f6bd651030":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 1);

      function_c0acbf135a7bc9a7(player, var_fb5d97f2bb9a9a3a);

      break;
    case #"hash_3699ac6c262c25ea":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 2);

      function_378f088ffe168eeb(player, var_fb5d97f2bb9a9a3a);

      break;
  }
}

function private function_c910157cea5c0954(player) {
  if(isDefined(player) && player function_5c766d1d0140b86("ui_veh_battle_tracks_toggle_state")) {
    var_fb5d97f2bb9a9a3a = player getclientomnvar("ui_veh_battle_tracks_toggle_state");
    player setclientomnvar("ui_veh_battle_tracks_toggle_state", 0);

    function_655c50210a09088e(player, var_fb5d97f2bb9a9a3a);
  }
}

function private get_toggle_state(player) {
  assert(isDefined(player.pers["<dev string:xe2>"]), "<dev string:xfd>");
  return player.pers["battleTracksToggleState"];
}

function private toggle_state_is(player, value) {
  return player.pers["battleTracksToggleState"] == value;
}

function private function_7c84110a2c9c894f(vehicle, player, seatid) {
  isdriverseat = isDefined(seatid) && vehicle_occupancy::function_d4f0603190ab379f(vehicle, seatid);

  if(isdriverseat) {
    player stop_toggle_think(player);
  }
}

function private stop_toggle_think(player) {
  if(!isDefined(player)) {
    return;
  }

  player notify("stop_battle_tracks_toggle_think");

  if(isDefined(player.battletracktogglebutton)) {
    switch (player.battletracktogglebutton) {
      case #"hash_10931e593d5bdf":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "+melee_zoom");
        player notifyonplayercommandremove("cancel_battle_tracks_toggle_state", "-melee_zoom");
        break;
      case #"hash_a8e4a914fb03a4d5":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "+frag");
        player notifyonplayercommandremove("cancel_battle_tracks_toggle_state", "-frag");
        break;
      case #"hash_b4b26057ca84210d":
        player notifyonplayercommandremove("update_battle_tracks_toggle_state", "nightvision");
        break;
    }

    player.battletracktogglebutton = undefined;
  }
}

function private function_175fcb8dec0707a(vehicle) {
  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.battletracksenabled) && !level.gametypebundle.battletracksenabled) {
    return false;
  }

  if(function_c808eddfd852442c(vehicle)) {
    return false;
  }

  if(isDefined(vehicle.battletracksowner) && toggle_state_is(vehicle.battletracksowner, "off")) {
    return false;
  }

  return true;
}

function private function_7d6b782d39e720af(player) {
  vehicle = player getmovingplatformparent();

  if(function_b52c64c08b732fc5(vehicle, player)) {
    player thread function_40be3d350d9c6aad(vehicle, player);

    if(!function_5dde30c1eedfbe1b(vehicle, player)) {
      function_482d28a40f664fcf(player);
      function_f37887eecb8944c1(vehicle, player);
    }
  }
}

function private function_f37887eecb8944c1(vehicle, player) {
  function_7b6150da5d44a400(vehicle, player, 0);
}

function private function_482d28a40f664fcf(player) {
  if(function_98a4262da2114872(player)) {
    function_7cc783ef7693ce1a(player);
    function_d993f54277870b9f(player);
  }
}

function private function_7cc783ef7693ce1a(player) {
  player notify("battle_tracks_standingOnVehicleTimeout");
}

function private function_40be3d350d9c6aad(vehicle, player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("battle_tracks_standingOnVehicleTimeout");
  player endon("battle_tracks_standingOnVehicleTimeout");
  wait 1;
  function_d993f54277870b9f(player);
}

function private function_6daf9fd5aef4f91d(player, vehicle) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_battle_tracks_option_watch");

  for(var_aed76dd5af307d5e = player getwartrackpassengerenabled(); true; var_aed76dd5af307d5e = var_14d8b6ee49763758) {
    wait 0.5;
    var_14d8b6ee49763758 = player getwartrackpassengerenabled();

    if(var_14d8b6ee49763758 != var_aed76dd5af307d5e) {
      if(var_14d8b6ee49763758) {
        if(function_175fcb8dec0707a(vehicle)) {
          function_7b6150da5d44a400(vehicle, player, 1);
        }

        continue;
      }

      function_3e1312745ee699b2(vehicle.battletracksmusicstate, player, 1);
    }
  }
}

function private function_d993f54277870b9f(player) {
  function_3e1312745ee699b2(player.battletracksmusicstate, player, 0);
}

function private function_b52c64c08b732fc5(vehicle, player) {
  if(!isDefined(vehicle)) {
    return false;
  }

  if(!vehicle vehicle::is_vehicle()) {
    return false;
  }

  if(!vehicle::function_8957ae4cd340941c(vehicle, player)) {
    return false;
  }

  if(!function_175fcb8dec0707a(vehicle)) {
    return false;
  }

  return true;
}

function private function_5dde30c1eedfbe1b(vehicle, player) {
  if(!isDefined(player.battletracksid)) {
    return false;
  }

  battletracksid = function_7a721cbb76c07b7a(vehicle);
  return battletracksid == player.battletracksid;
}

function private function_d0f537105677946d(vehicle, player) {
  if(function_c808eddfd852442c(vehicle)) {
    return false;
  }

  return function_5dde30c1eedfbe1b(vehicle, player);
}

function private function_7a721cbb76c07b7a(vehicle) {
  vehicleid = vehicle getentitynumber() + "";
  trackownerid = vehicle.battletracksowner getentitynumber() + "";
  return vehicleid + trackownerid;
}

function private function_9255747b6c80fec5() {
  return getDvar(@ "hash_88960e36a4bc7a7d", "<dev string:x134>") != "<dev string:x134>";
}

function private function_870c977ebe2b0ac8(vehicle) {
  vehicle.battletracksmusicstate = "<dev string:x138>";
  result = [];
  debugwartracks = getDvar(@ "hash_88960e36a4bc7a7d", "<dev string:x134>");
  var_8ca27d53289c4f16 = strtok(debugwartracks, "<dev string:x145>");

  foreach(var_db6f5c44cef6bae1 in var_8ca27d53289c4f16) {
    result[result.size] = int(var_db6f5c44cef6bae1);
  }

  return result;
}

function private function_aafad573e2b0040(vehicle, player) {
  if(!debug_enabled()) {
    return;
  }

  println("<dev string:x14a>");
  println("<dev string:x170>" + gettime());
  println("<dev string:x181>" + player getentitynumber());
  println("<dev string:x19b>" + vehicle.battletracksmusicstate);

  foreach(battletrack in vehicle.battletracks) {
    println("<dev string:x1ac>" + battletrack);
  }

  println("<dev string:x1b7>");
}

function private function_82c62238872f4386(battletracksmusicstate, player) {
  if(!debug_enabled()) {
    return;
  }

  println("<dev string:x1dd>");
  println("<dev string:x170>" + gettime());
  println("<dev string:x181>" + player getentitynumber());
  println("<dev string:x19b>" + battletracksmusicstate);
  println("<dev string:x1b7>");
}

function private function_c0acbf135a7bc9a7(player, var_fb5d97f2bb9a9a3a) {
  if(!debug_enabled() || !player function_5c766d1d0140b86("<dev string:x203>")) {
    return;
  }

  println("<dev string:x228>");
  println("<dev string:x170>" + gettime());
  println("<dev string:x181>" + player getentitynumber());
  println("<dev string:x253>");
  println("<dev string:x281>" + var_fb5d97f2bb9a9a3a);
  println("<dev string:x293>" + player getclientomnvar("<dev string:x203>"));
  println("<dev string:x2a0>");
}

function private function_378f088ffe168eeb(player, var_fb5d97f2bb9a9a3a) {
  if(!debug_enabled() || !player function_5c766d1d0140b86("<dev string:x203>")) {
    return;
  }

  println("<dev string:x2cb>");
  println("<dev string:x170>" + gettime());
  println("<dev string:x181>" + player getentitynumber());
  println("<dev string:x253>");
  println("<dev string:x281>" + var_fb5d97f2bb9a9a3a);
  println("<dev string:x293>" + player getclientomnvar("<dev string:x203>"));
  println("<dev string:x2f7>");
}

function private function_655c50210a09088e(player, var_fb5d97f2bb9a9a3a) {
  if(!debug_enabled() || !player function_5c766d1d0140b86("<dev string:x203>")) {
    return;
  }

  println("<dev string:x323>");
  println("<dev string:x170>" + gettime());
  println("<dev string:x181>" + player getentitynumber());
  println("<dev string:x253>");
  println("<dev string:x281>" + var_fb5d97f2bb9a9a3a);
  println("<dev string:x293>" + player getclientomnvar("<dev string:x203>"));
  println("<dev string:x351>");
}

function private debug_enabled() {
  return getdvarint(@ "hash_79d2fc5a92fbfcd1", 0) != 0;
}

# /