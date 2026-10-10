/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\vehicles\customization\battle_tracks.gsc
*********************************************************************/

#using scripts\common\vehicle;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace battle_tracks;

function function_620aa345ac2f9963() {
  if(level.gametype == "dungeons") {
    return;
  }

  projectbundle = function_811510b694ddd963();

  if(isDefined(projectbundle)) {
    var_eecca1d1275b620d = hashcat(%"hash_5c338ed91460dbe1", projectbundle.var_702b32c96429baee);
  } else {
    assertmsg("Undefined project bundle when initializing battle tracks");
    return;
  }

  level.var_702b32c96429baee = getscriptbundle(var_eecca1d1275b620d).var_702b32c96429baee;

  if(!isDefined(level.var_702b32c96429baee)) {
    assertmsg("Didn't find a vehicle track list");
    return;
  }

  foreach(trackinfo in level.var_702b32c96429baee) {
    if(index <= 1) {
      continue;
    }

    if(!isDefined(trackinfo.vehicletrack)) {
      continue;
    }

    trackname = hashcat(%"hash_8f87dca26d14f0d", trackinfo.vehicletrack);
    var_2450b73ccbdae7d = function_50f8a8f765bad85e(trackname, [#"hash_7fcaf90080dbf68d", #"ingamemusicstate"]);
    trackinfo.var_ebb583a772b21a39 = var_2450b73ccbdae7d.var_ebb583a772b21a39;
    trackinfo.ingamemusicstate = var_2450b73ccbdae7d.ingamemusicstate;

    if(!isDefined(trackinfo.var_ebb583a772b21a39)) {
      assertmsg("Didn't find a SFX alias in track: " + trackinfo.vehicletrack);
    }

    if(!isDefined(trackinfo.ingamemusicstate)) {
      assertmsg("Didn't find a music state in track: " + trackinfo.vehicletrack);
    }
  }
}

function battle_tracks_onentervehicle(vehicle, player) {
  if(level.gametype == "dungeons") {
    return;
  }

  if(function_c3d244ceadc23533(player)) {
    function_7718d2895fdba333(player);

    if(!function_4c953e9e77258030(vehicle, player)) {
      battle_tracks_stopbattletrackswhenstandingonvehicle(player);
    }
  }

  if(battle_tracks_shouldstartbattletracks(vehicle)) {
    battle_tracks_playbattletrackstoplayer(vehicle, player, 0);
  }
}

function battle_tracks_vehicleoccupancyenter(vehicle, player, seatid, var_fc7c7a874b43a31a) {
  if(level.gametype == "dungeons") {
    return;
  }

  isdriverseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);
  isbattletracksowner = battle_tracks_isbattletracksowner(vehicle, player);
  battle_tracks_trystopdrivertogglethink(vehicle, player, var_fc7c7a874b43a31a);
  battle_tracks_hidetogglewidget(player);

  if(isdriverseat) {
    if(!isbattletracksowner) {
      battle_tracks_stopbattletrackstoalloccupants(vehicle);
      battle_tracks_updatebattletracks(vehicle, player);
    }

    if(battle_tracks_shouldstartbattletracks(vehicle)) {
      battle_tracks_playbattletrackstoalloccupants(vehicle);
    }

    if(!battle_tracks_hasemptybattletracks(vehicle)) {
      player thread battle_tracks_togglethink(player, vehicle);
    }
  }
}

function battle_tracks_onexitvehicle(vehicle, player, seatid) {
  if(level.gametype == "dungeons") {
    return;
  }

  battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, player, 0);
  battle_tracks_trystopdrivertogglethink(vehicle, player, seatid);
  battle_tracks_hidetogglewidget(player);
  isbattletracksowner = battle_tracks_isbattletracksowner(vehicle, player);

  if(isbattletracksowner) {
    battle_tracks_stopbattletrackstoalloccupants(vehicle);
    battle_tracks_clearbattletracks(vehicle);
  }
}

function battle_tracks_monitorstandingonvehicles(player) {
  if(level.gametype == "dungeons") {
    return;
  }

  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    battle_tracks_tryplayingbattletrackswhenstandingonvehicle(player);
    wait 0.5;
  }
}

function battle_tracks_updatebattletracks(vehicle, player) {
  vehicle.battletracks = [];
  vehicle.battletracksowner = player;
  vehicle.battletracksmusicstate = "";

  if(battle_tracks_playerselectrandomtracks(vehicle, player)) {
    battle_tracks_updatebattletracksfromplayerdata(vehicle, player, 1, 9);
  } else {
    battle_tracks_updatebattletracksfromplayerdata(vehicle, player, 0, 9);
  }

  if(function_561f62b5ed736105()) {
    vehicle.battletracks = function_ea5ef1563045fe8c(vehicle);
  }

  vehicle.battletracks = scripts\engine\utility::array_randomize(vehicle.battletracks);
}

function battle_tracks_updatebattletracksfromplayerdata(vehicle, player, startindex, endindex) {
  data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb(vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());

  for(arrayindex = startindex; arrayindex <= endindex; arrayindex++) {
    trackindex = battle_tracks_gettrackindex(vehicle, player, arrayindex, data);

    if(getdvarint(@ "hash_aa9c7230c056a9f8", 0) > 0) {
      trackindex = getdvarint(@ "hash_aa9c7230c056a9f8");
    }

    if(isDefined(trackindex) && trackindex > 1) {
      if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
        sfxalias = battle_tracks_getsfxalias(trackindex);

        if(isDefined(sfxalias) && sfxalias != "") {
          vehicle.battletracks = scripts\engine\utility::array_add(vehicle.battletracks, sfxalias);
          battle_tracks_setmusicstate(vehicle, trackindex);
        }

        continue;
      }

      vehicle.battletracks = scripts\engine\utility::array_add(vehicle.battletracks, trackindex);
    }
  }
}

function battle_tracks_setmusicstate(vehicle, trackindex) {
  musicstate = battle_tracks_getmusicstate(trackindex);

  if(vehicle.battletracksmusicstate == "") {
    vehicle.battletracksmusicstate = musicstate;
    return;
  }

  assertex(vehicle.battletracksmusicstate == musicstate, "Unable to play tracks from different music state");
}

function battle_tracks_playerselectrandomtracks(vehicle, player) {
  data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb(vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
  var_5cd83eed6cc7ed18 = battle_tracks_gettrackindex(vehicle, player, 0, data);
  return isDefined(var_5cd83eed6cc7ed18) && var_5cd83eed6cc7ed18 == 1;
}

function battle_tracks_gettrackindex(vehicle, player, arrayindex, data) {
  debugindex = getdvarint(@ "hash_97029a354c4876c0", 0);

  if(debugindex != 0) {
    return debugindex;
  }

  if(isDefined(data) && isDefined(data.ref)) {
    trackindex = player getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "tracks", arrayindex);
    return trackindex;
  }

  return undefined;
}

function battle_tracks_getsfxalias(trackindex) {
  if(isDefined(level.var_702b32c96429baee) && isDefined(level.var_702b32c96429baee[trackindex])) {
    return level.var_702b32c96429baee[trackindex].var_ebb583a772b21a39;
  }
}

function battle_tracks_getmusicstate(trackindex) {
  if(isDefined(level.var_702b32c96429baee) && isDefined(level.var_702b32c96429baee[trackindex])) {
    return level.var_702b32c96429baee[trackindex].ingamemusicstate;
  }
}

function battle_tracks_playbattletrackstoalloccupants(vehicle) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
    all_occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 1);

    if(isDefined(vehicle.turretoccupants)) {
      all_occupants = array_combine_unique(all_occupants, vehicle.turretoccupants);
    }

    foreach(occupant in all_occupants) {
      battle_tracks_playbattletrackstoplayer(vehicle, occupant, 0);
    }

    return;
  }

  vehicle function_6db07c8a8c0f9ae6(vehicle.battletracks);
}

function battle_tracks_stopbattletrackstoalloccupants(vehicle) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) == 0) {
    all_occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 1);

    if(isDefined(vehicle.turretoccupants)) {
      all_occupants = array_combine_unique(all_occupants, vehicle.turretoccupants);
    }

    foreach(occupant in all_occupants) {
      battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, occupant, 0);
    }

    return;
  }

  vehicle function_3a119112e4018367();
}

function battle_tracks_playbattletrackstoplayer(vehicle, player, var_29172b8e5d02be98) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) != 0) {
    return;
  }

  isbattletracksowner = battle_tracks_isbattletracksowner(vehicle, player);

  if(isDefined(vehicle.battletracksmusicstate) && isDefined(vehicle.battletracks) && isDefined(player)) {
    if(isDefined(vehicle.battletracksowner) && (isbattletracksowner || var_29172b8e5d02be98 || player getwartrackpassengerenabled())) {
      var_a922e318ff7f4a24 = battle_tracks_getbattletracksid(vehicle);

      if(!function_59720efc5c367af2(vehicle, player, var_a922e318ff7f4a24)) {
        function_3971973c87f8c8d(vehicle, player);

        player.battletracksmusicstate = vehicle.battletracksmusicstate;
        player.battletracksid = var_a922e318ff7f4a24;
        player setplayermusicstate(vehicle.battletracksmusicstate, vehicle.battletracks, vehicle, (0, 0, 0));
      }
    }

    if(!isbattletracksowner && !var_29172b8e5d02be98) {
      player thread function_d9a28875c82616d0(player, vehicle);
    }
  }
}

function function_59720efc5c367af2(vehicle, player, var_a922e318ff7f4a24) {
  if(!isDefined(player.battletracksmusicstate)) {
    return false;
  }

  if(!isDefined(player.battletracksid)) {
    return false;
  }

  return player.battletracksmusicstate == vehicle.battletracksmusicstate && player.battletracksid == var_a922e318ff7f4a24;
}

function battle_tracks_stopbattletracksforplayer(battletracksmusicstate, player, var_29172b8e5d02be98) {
  if(getdvarint(@ "hash_157cdff8f5182e88", 0) != 0) {
    return;
  }

  if(function_c3d244ceadc23533(player)) {
    if(isDefined(battletracksmusicstate) && isDefined(player)) {
      function_be79f42e9d2ddc27(battletracksmusicstate, player);

      player.battletracksmusicstate = undefined;
      player.battletracksid = undefined;
      player stopplayermusicstate(battletracksmusicstate);

      if(!var_29172b8e5d02be98) {
        player notify("stop_battle_tracks_option_watch");
      }
    }
  }
}

function function_c3d244ceadc23533(player) {
  return isDefined(player.battletracksmusicstate) && isDefined(player.battletracksid);
}

function battle_tracks_isbattletracksowner(vehicle, player) {
  return isDefined(vehicle.battletracksowner) && vehicle.battletracksowner == player;
}

function battle_tracks_clearbattletracks(vehicle) {
  vehicle.battletracksowner = undefined;
  vehicle.battletracks = undefined;
  vehicle.battletracksmusicstate = undefined;
}

function battle_tracks_hasemptybattletracks(vehicle) {
  if(!isDefined(vehicle.battletracks)) {
    return true;
  }

  if(vehicle.battletracks.size == 0) {
    return true;
  }

  return false;
}

function battle_tracks_togglethink(player, vehicle) {
  player notify("stop_battle_tracks_toggle_think");
  player endon("stop_battle_tracks_toggle_think");
  player endon("death_or_disconnect");
  player endon("last_stand_start");
  battle_tracks_tryinittogglestate(player);
  var_4844d16e0d10f08b = battle_tracks_gettogglestate(player);
  battle_tracks_updatetogglestate(player, vehicle, var_4844d16e0d10f08b);
  requirehold = player is_player_gamepad_enabled();

  if(requirehold) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+melee_zoom");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-melee_zoom");
      player.var_23b06600e2a88b42 = "melee_zoom";
    } else {
      player notifyonplayercommand("update_battle_tracks_toggle_state", "+frag");
      player notifyonplayercommand("cancel_battle_tracks_toggle_state", "-frag");
      player.var_23b06600e2a88b42 = "frag";
    }
  } else {
    player notifyonplayercommand("update_battle_tracks_toggle_state", "nightvision");
    player.var_23b06600e2a88b42 = "nightvision";
  }

  while(true) {
    player setclientomnvar("ui_veh_music_toggle_button_holdtime", 0);
    player waittill("update_battle_tracks_toggle_state");
    newtogglestate = battle_tracks_getnewtogglestate(player);

    if(requirehold) {
      player childthread function_338b77c14712dbb3();
      result = player waittill_notify_or_timeout_return("cancel_battle_tracks_toggle_state", 0.25);

      if(result == "timeout") {
        player notify("cancel_battle_tracks_toggle_state");
        battle_tracks_updatetogglestate(player, vehicle, newtogglestate);
      }

      continue;
    }

    battle_tracks_updatetogglestate(player, vehicle, newtogglestate);
  }
}

function function_338b77c14712dbb3() {
  self endon("cancel_battle_tracks_toggle_state");
  progress = 0;

  while(true) {
    progress += level.framedurationseconds;
    self setclientomnvar("ui_veh_music_toggle_button_holdtime", min(1, progress / 0.25));
    waitframe();
  }
}

function battle_tracks_updatetogglestate(player, vehicle, togglestate) {
  switch (togglestate) {
    case #"hash_fa2ad6f6bd651030":
      battle_tracks_toggleonstate(player, vehicle);
      break;
    case #"hash_3699ac6c262c25ea":
      battle_tracks_toggleoffstate(player, vehicle);
      break;
  }
}

function battle_tracks_toggleonstate(player, vehicle) {
  battle_tracks_settogglestate(player, "on");
  battle_tracks_playbattletrackstoalloccupants(vehicle);
}

function battle_tracks_toggleoffstate(player, vehicle) {
  battle_tracks_settogglestate(player, "off");
  battle_tracks_stopbattletrackstoalloccupants(vehicle);
}

function battle_tracks_getnewtogglestate(player) {
  switch (player.pers["battleTracksToggleState"]) {
    case #"hash_fa2ad6f6bd651030":
      return "off";
    case #"hash_3699ac6c262c25ea":
      return "on";
  }
}

function battle_tracks_tryinittogglestate(player) {
  if(!isDefined(player.pers["battleTracksToggleState"])) {
    battle_tracks_settogglestate(player, "on");
  }
}

function battle_tracks_settogglestate(player, value) {
  player.pers["battleTracksToggleState"] = value;
  var_587830fd4042be45 = player getclientomnvar("ui_veh_battle_tracks_toggle_state");

  switch (value) {
    case #"hash_fa2ad6f6bd651030":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 1);

      function_55f68a20f93c4f9a(player, var_587830fd4042be45);

      break;
    case #"hash_3699ac6c262c25ea":
      player setclientomnvar("ui_veh_battle_tracks_toggle_state", 2);

      function_495e92841f7d35ec(player, var_587830fd4042be45);

      break;
  }
}

function battle_tracks_hidetogglewidget(player) {
  if(isDefined(player)) {
    var_587830fd4042be45 = player getclientomnvar("ui_veh_battle_tracks_toggle_state");
    player setclientomnvar("ui_veh_battle_tracks_toggle_state", 0);

    function_d852952d0fba338f(player, var_587830fd4042be45);
  }
}

function battle_tracks_gettogglestate(player) {
  assertex(isDefined(player.pers["<dev string:x1c>"]), "<dev string:x34>");
  return player.pers["battleTracksToggleState"];
}

function battle_tracks_togglestateis(player, value) {
  return isDefined(player.pers["battleTracksToggleState"]) && player.pers["battleTracksToggleState"] == value;
}

function battle_tracks_trystopdrivertogglethink(vehicle, player, seatid) {
  isdriverseat = isDefined(seatid) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);

  if(isdriverseat) {
    player battle_tracks_stoptogglethink(player);
  }
}

function battle_tracks_stoptogglethink(player) {
  if(!isDefined(player)) {
    return;
  }

  player notify("stop_battle_tracks_toggle_think");

  if(isDefined(player.var_23b06600e2a88b42)) {
    switch (player.var_23b06600e2a88b42) {
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

    player.var_23b06600e2a88b42 = undefined;
  }
}

function function_12a073ab00ffe201() {
  gametype = level.gametype;

  if(gametype == "br") {
    subgametype = getDvar(@ "hash_7611a2790a0bf7fe", "");

    if(subgametype != "") {
      return subgametype;
    }
  }

  return gametype;
}

function battle_tracks_shouldstartbattletracks(vehicle) {
  if(function_12a073ab00ffe201() == "x2") {
    return false;
  }

  if(battle_tracks_hasemptybattletracks(vehicle)) {
    return false;
  }

  if(isDefined(vehicle.battletracksowner) && battle_tracks_togglestateis(vehicle.battletracksowner, "off")) {
    return false;
  }

  return true;
}

function battle_tracks_tryplayingbattletrackswhenstandingonvehicle(player) {
  vehicle = player getmovingplatformparent();

  if(battle_tracks_shouldplaybattletrackswhenstandingonvehicle(vehicle, player)) {
    player thread battle_tracks_standingonvehicletimeout(vehicle, player);

    if(!battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player)) {
      battle_tracks_stopbattletrackswhenstandingonvehicle(player);
      battle_tracks_playbattletrackswhenstandingonvehicle(vehicle, player);
    }
  }
}

function battle_tracks_playbattletrackswhenstandingonvehicle(vehicle, player) {
  battle_tracks_playbattletrackstoplayer(vehicle, player, 0);
}

function battle_tracks_stopbattletrackswhenstandingonvehicle(player) {
  if(function_c3d244ceadc23533(player)) {
    function_7718d2895fdba333(player);
    battle_tracks_stopbattletracksfromstandingonvehicle(player);
  }
}

function function_7718d2895fdba333(player) {
  player notify("battle_tracks_standingOnVehicleTimeout");
}

function battle_tracks_standingonvehicletimeout(vehicle, player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("battle_tracks_standingOnVehicleTimeout");
  player endon("battle_tracks_standingOnVehicleTimeout");
  wait 1;
  battle_tracks_stopbattletracksfromstandingonvehicle(player);
}

function function_d9a28875c82616d0(player, vehicle) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("stop_battle_tracks_option_watch");

  for(var_5b0fc1b88f867313 = player getwartrackpassengerenabled(); true; var_5b0fc1b88f867313 = var_4192fc05bb9a1187) {
    wait 0.5;
    var_4192fc05bb9a1187 = player getwartrackpassengerenabled();

    if(var_4192fc05bb9a1187 != var_5b0fc1b88f867313) {
      if(var_4192fc05bb9a1187) {
        if(battle_tracks_shouldstartbattletracks(vehicle)) {
          battle_tracks_playbattletrackstoplayer(vehicle, player, 1);
        }

        continue;
      }

      battle_tracks_stopbattletracksforplayer(vehicle.battletracksmusicstate, player, 1);
    }
  }
}

function battle_tracks_stopbattletracksfromstandingonvehicle(player) {
  battle_tracks_stopbattletracksforplayer(player.battletracksmusicstate, player, 0);
}

function battle_tracks_shouldplaybattletrackswhenstandingonvehicle(vehicle, player) {
  if(!isDefined(vehicle)) {
    return false;
  }

  if(!vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return false;
  }

  if(!battle_tracks_vehicleallowlisteningoutsideoccupancy(vehicle)) {
    return false;
  }

  if(!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, player)) {
    return false;
  }

  if(!battle_tracks_shouldstartbattletracks(vehicle)) {
    return false;
  }

  if(!battle_tracks_playerinlisteningzone(vehicle, player)) {
    return false;
  }

  return true;
}

function battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player) {
  if(!isDefined(player.battletracksid)) {
    return false;
  }

  battletracksid = battle_tracks_getbattletracksid(vehicle);
  return battletracksid == player.battletracksid;
}

function function_4c953e9e77258030(vehicle, player) {
  if(battle_tracks_hasemptybattletracks(vehicle)) {
    return false;
  }

  return battle_tracks_standingonsamevehiclewithsametracksowner(vehicle, player);
}

function battle_tracks_getbattletracksid(vehicle) {
  vehicleid = vehicle getentitynumber() + "";
  var_d92a58c3390f0ff2 = vehicle.battletracksowner getentitynumber() + "";
  return vehicleid + var_d92a58c3390f0ff2;
}

function battle_tracks_playerinlisteningzone(vehicle, player) {
  switch (vehicle.targetname) {
    case #"hash_6e693d48c24e303b":
    case #"hash_9386dbfe3d8d881c":
      return scripts\cp_mp\utility\train_utility::isplayerinsiderectangularzonebasedonent(player, vehicle, "tag_origin", -85, 0, 77, 185, 125, 40);
    default:
      return 0;
  }
}

function battle_tracks_vehicleallowlisteningoutsideoccupancy(vehicle) {
  if(isDefined(vehicle.targetname)) {
    switch (vehicle.targetname) {
      case #"hash_6e693d48c24e303b":
      case #"hash_9386dbfe3d8d881c":
        return 1;
      default:
        return 0;
    }

    return;
  }

  return 0;
}

function function_561f62b5ed736105() {
  return getDvar(@ "hash_88960e36a4bc7a7d", "<dev string:x68>") != "<dev string:x68>";
}

function function_ea5ef1563045fe8c(vehicle) {
  vehicle.battletracksmusicstate = "<dev string:x69>";
  result = [];
  var_44b9b57f1594cdf2 = getDvar(@ "hash_88960e36a4bc7a7d", "<dev string:x68>");
  var_5587c2774459b359 = strtok(var_44b9b57f1594cdf2, "<dev string:x73>");

  foreach(var_ab66d57be4626030 in var_5587c2774459b359) {
    var_d60db1b8fa4a20ce = int(var_ab66d57be4626030);
    result = scripts\engine\utility::array_add(result, var_d60db1b8fa4a20ce);
  }

  return result;
}

function function_3971973c87f8c8d(vehicle, player) {
  if(!function_f15328434523e979()) {
    return;
  }

  println("<dev string:x75>");
  println("<dev string:x98>" + gettime());
  println("<dev string:xa6>" + player getentitynumber());
  println("<dev string:xbd>" + vehicle.battletracksmusicstate);

  foreach(battletrack in vehicle.battletracks) {
    println("<dev string:xcb>" + battletrack);
  }

  println("<dev string:xd3>");
}

function function_be79f42e9d2ddc27(battletracksmusicstate, player) {
  if(!function_f15328434523e979()) {
    return;
  }

  println("<dev string:xf6>");
  println("<dev string:x98>" + gettime());
  println("<dev string:xa6>" + player getentitynumber());
  println("<dev string:xbd>" + battletracksmusicstate);
  println("<dev string:xd3>");
}

function function_55f68a20f93c4f9a(player, var_587830fd4042be45) {
  if(!function_f15328434523e979()) {
    return;
  }

  println("<dev string:x119>");
  println("<dev string:x98>" + gettime());
  println("<dev string:xa6>" + player getentitynumber());
  println("<dev string:x141>");
  println("<dev string:x16c>" + var_587830fd4042be45);
  println("<dev string:x17b>" + player getclientomnvar("<dev string:x185>"));
  println("<dev string:x1a7>");
}

function function_495e92841f7d35ec(player, var_587830fd4042be45) {
  if(!function_f15328434523e979()) {
    return;
  }

  println("<dev string:x1cf>");
  println("<dev string:x98>" + gettime());
  println("<dev string:xa6>" + player getentitynumber());
  println("<dev string:x141>");
  println("<dev string:x16c>" + var_587830fd4042be45);
  println("<dev string:x17b>" + player getclientomnvar("<dev string:x185>"));
  println("<dev string:x1f8>");
}

function function_d852952d0fba338f(player, var_587830fd4042be45) {
  if(!function_f15328434523e979()) {
    return;
  }

  println("<dev string:x221>");
  println("<dev string:x98>" + gettime());
  println("<dev string:xa6>" + player getentitynumber());
  println("<dev string:x141>");
  println("<dev string:x16c>" + var_587830fd4042be45);
  println("<dev string:x17b>" + player getclientomnvar("<dev string:x185>"));
  println("<dev string:x24c>");
}

function function_f15328434523e979() {
  return getdvarint(@ "hash_79d2fc5a92fbfcd1", 0) != 0;
}

# /