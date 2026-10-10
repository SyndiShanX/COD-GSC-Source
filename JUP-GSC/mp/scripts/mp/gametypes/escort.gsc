/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\escort.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_62384cde1a08c286;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace escort;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);
  setdvarifuninitialized(@ "hash_c5e7c7fe685b44df", 1.5);
  setdvarifuninitialized(@ "hash_afdee58102ac62c7", 1);
  setdvarifuninitialized(@ "hash_25c32e812b54a991", 1.25);
  setdvarifuninitialized(@ "hash_89ba53fef5f59147", 3);
  setdvarifuninitialized(@ "hash_828d89a14ca9f861", 15);
  setdvarifuninitialized(@ "hash_57d5ecf3fc3f15ff", 3);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 3);
    registerroundlimitdvar(getgametype(), 2);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
    level.var_bddd4052ef4b38e9 = 180;
    level.var_5ce7af9684488d62 = 1.6;
    level.var_79ba6723e529379d = 5;
  }

  updategametypedvars();
  initdialog();

  setdevdvarifuninitialized(@ "hash_955092b9791e3642", 0);
  setdevdvarifuninitialized(@ "hash_de98b06a57eb27f0", 0);
  setdevdvarifuninitialized(@ "hash_f7880ced2490f6ea", 0);

  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.ontimelimit = &ontimelimit;
  level.onplayerkilled = &onplayerkilled;
  level.modeonspawnplayer = &onspawnplayer;
  level.onplayerconnect = &onplayerconnect;
  level.resetscoreonroundstart = &function_180943832c190cc0;
  level.onrespawndelay = &getrespawndelay;
  level.var_9c7ce92ca0bfa182 = getdvarint(@ "hash_29735379749831cd", 0) != 0;
  level.var_4538f9d8dc0b9007 = &function_602c658374655858;
  level.var_de10493ff1b21699 = 0;
  level.disablemajoritycapprogress = 1;
  level.var_abaccd362e5a9da1 = 1;
  level.dontendonscore = 1;
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&function_5134feee4679d224);
  registersharedfunc("escort", "registerEscortCollisionCallback", &registerescortcollisioncallback);
}

function initdialog() {
  game["dialog"]["gametype"] = "iw9_mtdm_mode_uktl_name";
  game["dialog"]["match_start_attacker"] = "dx_mp_esct_game_x_obeg";
  game["dialog"]["match_start_defender"] = "dx_mp_esct_game_x_obgi";
  game["dialog"]["maw_not_moved_attacker"] = "dx_mp_esct_game_x_ontk";
  game["dialog"]["maw_not_moved_attacker2"] = "dx_mp_esct_game_x_ontk";
  game["dialog"]["maw_near_checkpoint_defender"] = "dx_mp_esct_game_x_ondf";
  game["dialog"]["maw_near_checkpoint_defender2"] = "dx_mp_esct_game_x_ondf";
  game["dialog"]["maw_blocked_attacker"] = "dx_mp_esct_game_x_o2wb";
  game["dialog"]["maw_blocked_defender"] = "dx_mp_esct_game_x_o2bd";
  game["dialog"]["first_point_reached_attacker"] = "dx_mp_esct_game_x_o1sa";
  game["dialog"]["first_point_reached_defender"] = "dx_mp_esct_game_x_o1sd";
  game["dialog"]["first_point_hacked_attacker"] = "dx_mp_esct_game_x_o1ht";
  game["dialog"]["first_point_hacked_defender"] = "dx_mp_esct_game_x_o1hd";
  game["dialog"]["second_point_reached_attacker"] = "dx_mp_esct_game_x_o2sa";
  game["dialog"]["second_point_reached_defender"] = "dx_mp_esct_game_x_o2sd";
  game["dialog"]["almost_over_attacker"] = "dx_mp_esct_game_x_ootk";
  game["dialog"]["almost_over_defender"] = "dx_mp_esct_game_x_oodf";
  game["dialog"]["fail_attacker"] = "dx_mp_esct_game_x_oftk";
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  registerhalftimedvar(getgametype(), 0);
  level.var_bddd4052ef4b38e9 = getmatchrulesdata("escortData", "robotCaptureRadius");
  level.var_5ce7af9684488d62 = getmatchrulesdata("escortData", "robotCaptureTime");
  level.var_79ba6723e529379d = getmatchrulesdata("escortData", "robotMoveSpeed");
  level.var_b5b193ddb90ac26 = 1;
  level.var_d64a2d9f18e2a1b6 = 0;
  level.var_cc32d3ddb8ce727d = getdvarint(@ "hash_7979684c0c17d015", 1.5);
  level.var_3a309de6da405ec8 = 1;
  level.pausemodetimer = 0;
  level.zonecapturetime = getdvarint(@ "hash_828d89a14ca9f861", 15);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.overtime = dvars::dvarfloatvalue("overtimeLimit", 60, 0, 180);
  level.bonustime = getdvarint(@ "hash_d71c41415b34b325", 0);
  level.speedmultiplier = getdvarfloat(@ "hash_c5e7c7fe685b44df", 1);
  level.var_fe2c6aa29170b830 = getdvarint(@ "hash_afdee58102ac62c7", 0);
  level.var_74c440fd40f9cc0b = getdvarfloat(@ "hash_25c32e812b54a991", 1);
  level.var_12145f208d7c6529 = getdvarint(@ "hash_89ba53fef5f59147", 1);
  level.respawndelaytype = function_29227adb79acc568("respawnType", 0);
  level.attackersrespawndelay = function_ef4d323f56385843("attackersRespawnDelay", 0);
  level.defendersrespawndelay = function_ef4d323f56385843("defendersRespawnDelay", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["firstRoundAllZonesHacked"])) {
    game["firstRoundAllZonesHacked"] = 0;
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;

    if(istrue(game["firstRoundAllZonesHacked"])) {
      setoverridewatchdvar("timelimit", game["timePassedInSeconds"][game["defenders"]]);
      setDvar(@ "ui_timelimit", gettimelimit());
    }
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/ESCORT");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/ESCORT");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/ESCORT_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/ESCORT_HINT");
  }

  scripts\mp\flags::gameflaginit("escort_vehicle_spawned", 0);
  function_64ea0c4f3f0f33a8();
  function_95c08ab3ede6e069();
  function_d5f9bdff33942a5e();
  level thread function_28c9bb84699d73b2();
  initspawns();
  function_650429986b10b325();
  function_df305a7a25129b95();
  level thread function_8298599a4183cd44();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\outofbounds::function_99d6508da7894de2(level.outofboundstriggers);

  thread function_9d7b6a4d62e449fb();
}

function function_5134feee4679d224(player) {
  oobzones = getEntArray("escort_toggle_visual_ent", "script_noteworthy");

  foreach(oobzone in oobzones) {
    if(player.team == game["defenders"]) {
      oobzone showtoplayer(player);
      continue;
    }

    if(player.team == game["attackers"]) {
      oobzone hidefromplayer(player);
    }
  }
}

function function_64ea0c4f3f0f33a8() {
  if(isDefined(level.escortroute)) {
    return;
  }

  level.escortroute = [];
  level.var_bccbe1ff8f6ea962 = spawnStruct();
  level.var_bccbe1ff8f6ea962.capture_zones = [];
  var_a9240f92b0769a9d = [];
  var_83ced3c593a28a8a = [];
  use_structs = 0;
  currnode = getvehiclenode("escort_tank_path", "targetname");

  if(!isDefined(currnode)) {
    currnode = getStruct("escort_tank_path", "targetname");
    use_structs = 1;
  }

  level.escortroute["escort_tank_path"] = currnode;
  var_a9240f92b0769a9d[0] = currnode.origin;
  var_83ced3c593a28a8a["escort_tank_path"] = 0;

  while(isDefined(currnode.target)) {
    if(use_structs) {
      currnode = getStruct(currnode.target, "targetname");
    } else {
      currnode = getvehiclenode(currnode.target, "targetname");
    }

    if(isDefined(currnode.script_noteworthy)) {
      switch (currnode.script_noteworthy) {
        case #"hash_a345206f83346c51":

          if(isDefined(var_83ced3c593a28a8a["<dev string:x1c>"])) {
            assertmsg("<dev string:x2c>");
          }

          var_83ced3c593a28a8a["hack_point_1"] = var_a9240f92b0769a9d.size;
          level.escortroute["hack_point_1"] = currnode;
          break;
        case #"hash_a3451d6f83346798":

          if(isDefined(var_83ced3c593a28a8a["<dev string:x76>"])) {
            assertmsg("<dev string:x86>");
          }

          var_83ced3c593a28a8a["hack_point_2"] = var_a9240f92b0769a9d.size;
          level.escortroute["hack_point_2"] = currnode;
          break;
        case #"hash_a3451e6f8334692b":

          if(isDefined(var_83ced3c593a28a8a["<dev string:xd0>"])) {
            assertmsg("<dev string:xe0>");
          }

          var_83ced3c593a28a8a["hack_point_3"] = var_a9240f92b0769a9d.size;
          level.escortroute["hack_point_3"] = currnode;
          break;
      }
    }

    var_a9240f92b0769a9d[var_a9240f92b0769a9d.size] = currnode.origin;
  }
}

function function_d5f9bdff33942a5e() {
  var_bb943a1424fd93ad = getEntArray("escort_hack_trig", "targetname");

  if(!isDefined(level.objectives)) {
    level.objectives = [];
  }

  level.var_66cad6c85a4d2a8c = undefined;

  foreach(trig in var_bb943a1424fd93ad) {
    hackzone = undefined;

    if(!isDefined(trig.script_noteworthy)) {
      continue;
    }

    linked_node = trig.script_noteworthy;

    if(linked_node != "hack_point_1" && linked_node != "hack_point_2" && linked_node != "hack_point_3") {
      continue;
    }

    switch (linked_node) {
      case #"hash_a345206f83346c51":
        assertex(!isDefined(level.escortroute["<dev string:x12a>"]), "<dev string:x13f>");
        level.escortroute["hack_point_1_trig"] = trig;
        hackzone = function_a1dde56f66dafa59(trig, 1, "hack_point_1");
        scripts\mp\flags::gameflaginit("point_1_hacked", 0);
        scripts\mp\flags::gameflaginit("wheelson_reach_hack_point_1", 0);
        level.var_bccbe1ff8f6ea962.capture_zones[0] = hackzone;
        level.var_66cad6c85a4d2a8c = hackzone;
        break;
      case #"hash_a3451d6f83346798":
        assertex(!isDefined(level.escortroute["<dev string:x16a>"]), "<dev string:x13f>");
        level.escortroute["hack_point_2_trig"] = trig;
        hackzone = function_a1dde56f66dafa59(trig, 2, "hack_point_2");
        scripts\mp\flags::gameflaginit("point_2_hacked", 0);
        scripts\mp\flags::gameflaginit("wheelson_reach_hack_point_2", 0);
        level.var_bccbe1ff8f6ea962.capture_zones[1] = hackzone;
        break;
      case #"hash_a3451e6f8334692b":
        assertex(!isDefined(level.escortroute["<dev string:x17f>"]), "<dev string:x13f>");
        level.escortroute["hack_point_3_trig"] = trig;
        hackzone = function_a1dde56f66dafa59(trig, 3, "hack_point_3");
        scripts\mp\flags::gameflaginit("point_3_hacked", 0);
        scripts\mp\flags::gameflaginit("wheelson_reach_hack_point_3", 0);
        level.var_bccbe1ff8f6ea962.capture_zones[2] = hackzone;
        break;
    }
  }
}

function function_a1dde56f66dafa59(trig, objid, nodename) {
  visuals = [trig];
  hackzone = scripts\mp\gameobjects::createuseobject("neutral", trig, visuals, trig.origin + (0, 0, 160), objid);
  hackzone scripts\mp\gameobjects::disableobject();
  hackzone obj_zonecapture::activatezone(hackzone.objidnum);
  hackzone scripts\mp\gameobjects::cancontestclaim(1);
  hackzone scripts\mp\gameobjects::pinobjiconontriggertouch();
  hackzone scripts\mp\gameobjects::mustmaintainclaim(1);

  if(!isDefined(trig.script_label)) {
    trig.script_label = objid;
  }

  hackzone.objectivekey = hackzone scripts\mp\gameobjects::getlabel();
  hackzone.id = "hardpoint";
  hackzone.claimgracetime = level.zonecapturetime * 1000;

  if(isDefined(hackzone.trigger.target)) {
    hackzone thread assignchevrons(hackzone.trigger.target, hackzone.trigger.script_label);
  }

  hackzone.onuse = &function_1259100ca5b22bfd;
  hackzone.onbeginuse = &function_60bf30ad3151f226;
  hackzone.onenduse = &function_e6f69f5a001df1ae;
  hackzone.onuseupdate = &function_742b82afd4cb766c;
  hackzone.ignorestomp = 1;
  hackzone.useratemultiplier = 1;
  hackzone.var_823c5a7bf6a0e64a = 0;
  hackzone.blockcapdisabled = 1;
  hackzone.var_7848db50cd8c444f = 1;
  hackzone.var_93f25dd7906beb3c = level.escortroute[nodename];
  level.objectives[hackzone.objectivekey] = hackzone;
  objective_state(hackzone.objidnum, "done");
  return hackzone;
}

function function_95c08ab3ede6e069() {
  exclusionzones = getEntArray("escortExclusionZone", "targetname");

  if(isDefined(level.var_6e8e0a120244629a)) {
    exclusionzones = [[level.var_6e8e0a120244629a]](exclusionzones);
  }

  level.var_a5b3d36d2abdefea = exclusionzones;
}

function function_df305a7a25129b95() {
  startnode = level.escortroute["escort_tank_path"];
  var_3f1b16fd75f63e7d = startnode.origin;
  vehicle = spawnescortvehicle(startnode);
  var_2b56ed4aa70f4980 = 0;
  team = game["attackers"];
  trigger = spawn("trigger_radius", var_3f1b16fd75f63e7d, 0, level.var_bddd4052ef4b38e9, 128);

  if(var_2b56ed4aa70f4980) {
    zone = scripts\mp\gameobjects::createuseobject("neutral", trigger, [], (0, 0, 70), 0, 0, 1);
    zone scripts\mp\gameobjects::allowuse("enemy");
    zone scripts\mp\gameobjects::setvisibleteam("any");
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.var_f305e9a391a97629);
    zone scripts\mp\gameobjects::cancontestclaim(1);
    zone scripts\mp\gameobjects::mustmaintainclaim(0);
    zone scripts\mp\gameobjects::setusetime(level.var_5ce7af9684488d62);
    zone scripts\mp\gameobjects::pinobjiconontriggertouch();
    zone.var_88806e65c3197677 = 1;
    zone.alwaysstalemate = 0;
    zone.id = "hardpoint";
    zone.blockcapdisabled = 1;
    zone.checkuseconditioninthink = 1;
  } else {
    zone = scripts\mp\gameobjects::createobjidobject(var_3f1b16fd75f63e7d, team, (0, 0, 70), 0, "all", 0);
    zone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", zone.objidnum, team);
    scripts\mp\objidpoolmanager::update_objective_icon(zone.objidnum, level.var_f305e9a391a97629);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(zone.objidnum, team);
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(zone.objidnum, &"MP_INGAME_ONLY/OBJ_HALT_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(zone.objidnum, &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS");
    zone.trigger = trigger;
  }

  scripts\mp\objidpoolmanager::update_objective_onentity(zone.objidnum, vehicle);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(zone.objidnum, 70);
  zone.var_baa644f30eca9796 = &"MP_INGAME_ONLY/OBJ_ESCORTING_CAPS";

  if(isDefined(zone.trigger)) {
    zone.trigger enablelinkTo();
    zone.trigger linkTo(vehicle);
  }

  level.var_56adfa324022c19b = "state_1";
  zone.vehicle = vehicle;
  vehicle.zone = zone;
  level.var_eef3a4f4d6b03130 = zone;
  level.escortvehicles = [vehicle];
  scripts\mp\flags::gameflagset("escort_vehicle_spawned");
  vehicle thread function_7706e4552129710c(startnode);
}

function spawnescortvehicle(startnode) {
  spawndata = spawnStruct();
  spawndata.cannotbesuspended = 1;
  spawndata.angles = isDefined(startnode.angles) ? startnode.angles : (0, 0, 0);
  spawndata.origin = startnode.origin;
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_skydiving_com_large";
  spawndata.targetname = "remote_tank";
  spawndata.vehicletype = "veh_pac_sentry_ground_mp_escort";
  spawndata.spawntype = "GAME_MODE";
  spawndata.ownerteam = game["attackers"];
  spawndata.team = game["attackers"];
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  spawndata.node = startnode;
  spawndata.var_558e3ab4e0b5ddbc = startnode.origin;
  vehicle = function_1a9f6dcef6e686ab(spawndata);
  vehicle.var_7150b8620d62148 = [];
  vehicle.directionblocked = [];
  vehicle.var_95f2a51e7b487eb2 = [];
  vehicle.pathnodes = [];
  vehicle.nearbydefenders = [];
  vehicle.vehiclename = "pac_sentry";
  vehicle.var_6decdc73003db8d0 = 0;
  vehicle.var_29a4616e42091783 = 1;
  vehicle.defaultspeed = level.var_79ba6723e529379d;
  vehicle.retreatspeed = level.var_cc32d3ddb8ce727d;
  vehicle.tanknearbyrange = level.var_bddd4052ef4b38e9;
  vehicle.var_98e373d243c1936f = 1;
  vehicle.stageid = 0;
  vehicle.progress = 0;
  vehicle.speedmultiplier = 1;
  vehicle.var_20eb6b3f6aa4f46f = 0.5;
  vehicle.currnodeindex = startnode;
  vehicle.usep2p = 0;
  level thread function_3129b5cf1b77c634(vehicle);
  thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_updateinstance(vehicle);
  return vehicle;
}

function function_7706e4552129710c(startnode) {
  vehicle = self;
  vehicle.team = game["attackers"];
  vehicle.teamfriendlyto = game["attackers"];
  vehicle setvehicleteam(game["attackers"]);
  vehicle vehicleshowonminimap(0);

  if(isDefined(level.var_bccbe1ff8f6ea962)) {
    foreach(i, capturezone in level.var_bccbe1ff8f6ea962.capture_zones) {
      capturezone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_capture", capturezone.objidnum, game["defenders"]);
      capturezone scripts\mp\gameobjects::setownerteam(game["defenders"]);
      capturezone scripts\mp\gameobjects::setvisibleteam("any");
      setomnvar("ui_wm_escort_checkpoint_objid_" + i, capturezone.objidnum);
    }

    vehicle thread function_7318c4542deb6762(level.var_bccbe1ff8f6ea962);
  }

  if(istrue(level.var_b5b193ddb90ac26)) {
    vehicle.canstopbydefenders = 1;
  }

  if(istrue(level.var_d64a2d9f18e2a1b6)) {
    vehicle.demigodmode = 1;
    vehicle.var_5fb0e90d5b2a8aae = 0;
  } else {
    vehicle.godmode = 1;
    vehicle setCanDamage(0);
  }

  pathnodes = [];

  for(nextnode = startnode; isDefined(nextnode); nextnode = undefined) {
    pathnodes[pathnodes.size] = nextnode;

    if(isDefined(nextnode.target)) {
      nextnode = getvehiclenode(nextnode.target, "targetname");

      if(!isDefined(nextnode)) {
        nextnode = getStruct(nextnode.target, "targetname");
      }

      continue;
    }
  }

  endnode = pathnodes[pathnodes.size - 1];
  vehicle.pathnodes = pathnodes;

  if(istrue(level.var_9c7ce92ca0bfa182) || isstruct(startnode)) {
    vehicle.usep2p = 1;
    vehicle addcomponent("p2p");
    vehicle thread function_c1bc249b0499979e();
  } else {
    vehicle attachpath(startnode);
    vehicle startpath();
  }

  totaldistance = 0;
  vehicle.pathnodes[0].var_1d7ebd1bcc23a4e1 = 0;

  for(i = 0; i < vehicle.pathnodes.size - 1; i++) {
    currentnode = vehicle.pathnodes[i];
    nextnode = vehicle.pathnodes[i + 1];
    totaldistance += distance2d(currentnode.origin, nextnode.origin);
    nextnode.var_1d7ebd1bcc23a4e1 = totaldistance;
  }

  foreach(pathnode in vehicle.pathnodes) {
    pathnode.progress = pathnode.var_1d7ebd1bcc23a4e1 / totaldistance;
  }

  if(isDefined(level.var_4538f9d8dc0b9007)) {
    vehicle.checkpoints = [[level.var_4538f9d8dc0b9007]](vehicle);
  }

  level notify("escort_path_set", vehicle);
  level thread function_b63c307e88f55d86(vehicle, vehicle.zone.objidnum);
  var_e21fdc330521a449 = 1;
  vehicle thread function_eb31d2457d09576(var_e21fdc330521a449);
  level thread function_7d5057db2f8ddb6f(vehicle, vehicle.zone.objidnum);
}

function function_602c658374655858(vehicle) {
  var_5beb550b14979da6 = 3;
  var_2946f1f5b9485f68 = [];

  for(i = 0; i <= var_5beb550b14979da6; i++) {
    name = "hack_point_" + i + 1;
    var_a1cf1ca2c44eca8b = getvehiclenode(name, "script_noteworthy");

    if(isDefined(var_a1cf1ca2c44eca8b)) {
      assert(isDefined(var_a1cf1ca2c44eca8b.progress));
      var_a1cf1ca2c44eca8b.visible = 1;
      var_2946f1f5b9485f68[i] = var_a1cf1ca2c44eca8b;
      continue;
    }

    checkpointstruct = getStruct(name, "script_noteworthy");

    if(isDefined(checkpointstruct)) {
      assert(isDefined(checkpointstruct.progress));
      checkpointstruct.visible = 1;
      var_2946f1f5b9485f68[i] = checkpointstruct;
    }
  }

  return var_2946f1f5b9485f68;
}

function function_eb31d2457d09576(var_e21fdc330521a449) {
  level endon("game_ended");
  self endon("death");
  thread function_367f87c96dccaf2();
  tank = self;
  var_40d4ab48b1615807 = tank getentitynumber();

  if(istrue(var_e21fdc330521a449)) {
    var_21412c22fd1045d7 = 50;
    var_dcb6304be0fe7b52 = 70;
    var_24d1ae7b69b2b3f3 = 80;
  } else {
    var_21412c22fd1045d7 = 150;
    var_dcb6304be0fe7b52 = 240;
    var_24d1ae7b69b2b3f3 = 160;
  }

  itemcontents = physics_createcontents(["physicscontents_item", "physicscontents_vehicle"]);
  radiusvector = (var_21412c22fd1045d7, var_21412c22fd1045d7, var_24d1ae7b69b2b3f3);
  var_f8d57c6bc526da29 = (var_dcb6304be0fe7b52, var_dcb6304be0fe7b52, var_24d1ae7b69b2b3f3);
  var_646389193279e8ec = [tank];

  while(true) {
    if(istrue(var_e21fdc330521a449)) {
      var_863c619037f3ac74 = tank.origin;
    } else {
      var_863c619037f3ac74 = tank.origin + rotatevector((30, 0, -30), tank.angles);
    }

    aabbmin = var_863c619037f3ac74 - radiusvector;
    aabbmax = var_863c619037f3ac74 + radiusvector;
    var_3c4b19abbdf0937c = var_863c619037f3ac74 - var_f8d57c6bc526da29;
    var_2e1990d919dc0eb2 = var_863c619037f3ac74 + var_f8d57c6bc526da29;

    if(getdvarint(@ "hash_955092b9791e3642", 0) == 1) {
      level thread draw_line_for_time(aabbmin, aabbmax, 1, 0, 0, 2);
      level thread draw_circle(var_863c619037f3ac74, var_21412c22fd1045d7, (1, 0, 0), 1, 0, 2);
      level thread draw_line_for_time(var_3c4b19abbdf0937c, var_2e1990d919dc0eb2, 1, 0, 0, 2);
      level thread draw_circle(var_863c619037f3ac74, var_dcb6304be0fe7b52, (1, 0, 0), 1, 0, 2);
    }

    var_3a3a8605cd6d3dfc = physics_aabbbroadphasequery(aabbmin, aabbmax, itemcontents, var_646389193279e8ec);
    var_e4c6a394b5df337 = physics_aabbbroadphasequery(var_3c4b19abbdf0937c, var_2e1990d919dc0eb2, itemcontents, var_646389193279e8ec);

    foreach(ent in var_e4c6a394b5df337) {
      if(isDefined(ent.cratetype) && ent.cratetype == "loadout_drop" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\cp_mp\killstreaks\airdrop::destroycrate(0);
      }
    }

    foreach(ent in var_3a3a8605cd6d3dfc) {
      if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
      }

      if(isDefined(ent.vehiclename) && ent.vehiclename == "radar_drone_recon" && !istrue(ent.beingdestroyed)) {
        ent.beingdestroyed = 1;
        ent thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(1);
      }
    }

    waitframe();
  }
}

function function_367f87c96dccaf2() {
  level endon("game_ended");
  self endon("death");
  temppos = self.origin;
  var_8fb02da86884df3f = 0;

  while(true) {
    wait 0.25;

    if(distancesquared(self.origin, temppos) < 16 && istrue(self.var_92051c7cb27cb3bb)) {
      var_8fb02da86884df3f++;
    } else if(distancesquared(self.origin, temppos) > 16) {
      var_8fb02da86884df3f = 0;
    }

    if(var_8fb02da86884df3f >= 2) {
      if(!istrue(self.usep2p) && isDefined(self.pathnodes[self.var_6bb0ab1fe092bd5d - 1])) {
        self startpath(self.pathnodes[self.var_6bb0ab1fe092bd5d - 1]);
        var_8fb02da86884df3f = 0;
      }
    }

    temppos = self.origin;
  }
}

function function_7d5057db2f8ddb6f(tank, objidnum) {
  tank endon("entitydeleted");
  tank endon("reached_goal");
  tank vehicle_turnengineon();
  tank thread function_2fd30b01784b1b6b();

  while(!isDefined(level.players)) {
    waitframe();
  }

  if(!isDefined(tank.tanknearbyrange)) {
    tank.tanknearbyrange = 500;
  }

  tank thread tankscoreevent();
  reversible = level.var_3a309de6da405ec8;
  setspeed = tank.defaultspeed;

  foreach(player in level.players) {
    player.var_3a9ae1fe9210a5b7 = 0;
  }

  while(true) {
    shouldmove = 0;
    nearbyrange = tank.tanknearbyrange;
    tank.shouldjump = 0;
    tank.var_92051c7cb27cb3bb = 0;
    var_95f2a51e7b487eb2 = tank function_50b1e7d653deac05(game["attackers"]);

    if(var_95f2a51e7b487eb2.size > 0) {
      shouldmove = 1;
      setspeed = tank.defaultspeed * pow(level.speedmultiplier, var_95f2a51e7b487eb2.size - 1);
    }

    nearbydefenders = tank function_50b1e7d653deac05(game["defenders"]);
    tank.var_95f2a51e7b487eb2 = var_95f2a51e7b487eb2;
    tank.nearbydefenders = nearbydefenders;
    fullyhalt = istrue(tank.var_5fb0e90d5b2a8aae) || istrue(tank.var_6decdc73003db8d0) || istrue(tank.var_65ab8f532ca7195);

    foreach(player in level.players) {
      if(!isDefined(player.var_3a9ae1fe9210a5b7)) {
        player.var_3a9ae1fe9210a5b7 = 0;
      }

      var_763caca9e047aed4 = player.var_3a9ae1fe9210a5b7;
      team = player.team;

      if(!isDefined(team) && isDefined(player.bot_team)) {
        team = player.bot_team;
      }

      if(game["attackers"] == team) {
        player.var_3a9ae1fe9210a5b7 = array_contains(var_95f2a51e7b487eb2, player);
        continue;
      }

      player.var_3a9ae1fe9210a5b7 = array_contains(nearbydefenders, player);
    }

    tank.contested = 0;

    if(istrue(tank.canstopbydefenders)) {
      if(shouldmove && nearbydefenders.size > 0) {
        tank.contested = 1;
        shouldmove = 0;
      }

      if(reversible) {
        backwardcheck = 0;

        if(isDefined(tank.stageid) && isDefined(tank.checkpoints) && isDefined(tank.checkpoints[tank.stageid - 1])) {
          backwardcheck = tank.checkpoints[tank.stageid - 1].progress;
        }

        if(!fullyhalt && !isDefined(tank.overridespeed)) {
          if(tank.progress - backwardcheck > 0.004 && nearbydefenders.size > 0 && var_95f2a51e7b487eb2.size == 0) {
            shouldmove = 1;

            if(!istrue(tank.shouldreverse)) {
              tank.shouldreverse = 1;
              setspeed = tank.defaultspeed / 2;

              if(isDefined(level.var_cc32d3ddb8ce727d)) {
                setspeed = level.var_cc32d3ddb8ce727d;
              }

              tank.veh_pathdir = "reverse";
              tank.veh_transmission = "reverse";
              tank notify("reverse_changed");
            }
          } else if(nearbydefenders.size == 0 && var_95f2a51e7b487eb2.size > 0) {
            if(istrue(tank.shouldreverse)) {
              tank.shouldreverse = 0;
              setspeed = tank.defaultspeed;
              tank.veh_pathdir = "forward";
              tank.veh_transmission = "forward";
              tank notify("reverse_changed");
            }
          }
        }
      }
    }

    foreach(player in level.players) {
      player function_3cd19573df126b43(objidnum, tank);
    }

    tank.var_5b67ad6d3409a341 = 0;

    if(isDefined(tank.var_7150b8620d62148)) {
      foreach(index, trapped in tank.var_7150b8620d62148) {
        if(istrue(trapped)) {
          tank.var_5b67ad6d3409a341 = 1;

          if(tank.directionblocked[index] == "forward" && !istrue(tank.shouldreverse)) {
            shouldmove = 0;
            break;
          }

          if(tank.directionblocked[index] == "backward" && istrue(tank.shouldreverse)) {
            shouldmove = 0;
            break;
          }
        }
      }
    }

    function_56a6df7bc15c1d56(tank, objidnum);

    if(fullyhalt) {
      tank.var_92051c7cb27cb3bb = 0;
      currentspeed = tank function_796a1097d8a12f6a();

      if(currentspeed != 0) {
        if(!isDefined(tank.var_b93f7569f683ebb6)) {
          tank.var_b93f7569f683ebb6 = currentspeed;
        }

        currentspeed -= tank.var_b93f7569f683ebb6 / 3;
        tank.shouldjump = 1;

        if(currentspeed < 0) {
          currentspeed = 0;
          tank.shouldjump = 0;
          tank.var_b93f7569f683ebb6 = undefined;
        }

        tank function_221a50fb1dadfc46(currentspeed);
        tank notify("tank_stop");
      }
    } else if(isDefined(tank.overridespeed)) {
      tank.var_92051c7cb27cb3bb = 0;
      tank function_221a50fb1dadfc46(tank.overridespeed);
      tank.shouldjump = 1;
    } else if(!shouldmove) {
      tank.var_92051c7cb27cb3bb = 0;
      tank function_221a50fb1dadfc46(0);
      tank.shouldjump = 0;
      tank notify("tank_stop");
    } else {
      tank.var_92051c7cb27cb3bb = 1;
      tank function_221a50fb1dadfc46(setspeed);
      tank.shouldjump = 1;
      tank notify("tank_moving");
    }

    wait 0.25;
  }
}

function function_221a50fb1dadfc46(speed) {
  if(speed < 0) {
    speed = 0;
  }

  if(speed == 0) {
    setomnvar("ui_wm_escort_dir", 0);
  } else {
    setomnvar("ui_wm_escort_dir", ter_op(self.veh_pathdir == "forward", 1, -1));
  }

  if(self.usep2p) {
    if(speed == 0) {
      self function_a7fac0397762d7a6("p2p", "pause", 1);
    } else {
      self function_a7fac0397762d7a6("p2p", "resume", 1);
    }

    self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(speed));
    return;
  }

  self vehicle_setspeed(speed);
}

function function_796a1097d8a12f6a() {
  if(self.usep2p) {
    return ips_to_mph(self function_210ad508dfc813a2("p2p", "manualSpeed"));
  }

  return self vehicle_getspeed();
}

function function_2fd30b01784b1b6b() {
  self endon("entitydeleted");
  self endon("reached_goal");

  if(self.vehicletype == "veh_jup_mil_lnd_tank_cougar_mg_physics") {
    return;
  }

  if(self.vehicletype == "veh_pac_sentry_ground_mp_escort") {
    self.var_5be28c4da990b127 = spawn("script_model", self.origin);
    self.var_5be28c4da990b127 linkTo(self, "tag_origin", (0, 0, 15), (0, 0, 0));

    while(true) {
      if(istrue(self.var_65ab8f532ca7195)) {
        self.var_5be28c4da990b127 stoploopsound("veh_jup_kls_wheelson_engine_lp");
        self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_stop");
        self waittill("tank_moving");
      }

      if(self vehicle_getspeed() > 0) {
        if(istrue(self.shouldreverse)) {
          self.var_5be28c4da990b127 playLoopSound("veh_jup_kls_wheelson_engine_reverse_lp");
          thread function_28518f0349b4e5cb();
          waittill_any_2("reverse_changed", "tank_stop");
        } else {
          self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_start");
          wait 0.5;
          self.var_5be28c4da990b127 playLoopSound("veh_jup_kls_wheelson_engine_lp");
          self waittill("tank_stop");
        }
      } else {
        self.var_5be28c4da990b127 stoploopsound();
        self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_stop");
        self waittill("tank_moving");
      }

      waitframe();
    }

    return;
  }

  return;
}

function function_28518f0349b4e5cb() {
  self endon("entitydeleted");
  self endon("reached_goal");
  self endon("tank_stop");

  while(self.veh_pathdir == "reverse") {
    self.var_5be28c4da990b127 playsoundonmovingent("veh_jup_kls_wheelson_engine_reverse_beep");
    wait 1;
  }
}

function function_650429986b10b325() {
  game["OBJ_KEYS"][1] = "a";
  game["OBJ_KEYS"][2] = "b";
  game["OBJ_KEYS"][3] = "c";
  setomnvar("ui_escort_goal_percent", 0.5);
  setomnvar("ui_escort_ent_speed", 0);
  setomnvar("ui_escort_owner_team", 0);

  if(game["attackers"] == "axis") {
    setomnvar("ui_escort_attacking_side", 1);
  } else if(game["attackers"] == "allies") {
    setomnvar("ui_escort_attacking_side", 2);
  }

  level.iconneutral = "waypoint_captureneutral";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
  level.iconclearing = "waypoint_clearing";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.var_13bb9c2cc0880d1 = "waypoint_friendlyCheckpoint";
  level.var_41bb19836c51437e = "waypoint_EnemyCheckpoint";
  level.var_fe2635993c34c970 = "waypoint_friendlyEnd";
  level.var_849122b5c456dcf5 = "waypoint_EnemyEnd";
  level.var_f305e9a391a97629 = "icon_waypoint_wheelson";
  scripts\mp\gamelogic::setwaypointiconinfo(level.icontaking, 0, "friendly", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", "icon_waypoint_dom_a", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconlosing, 0, "friendly", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", "icon_waypoint_dom_a", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle", 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_wheelson", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_vehicle_blocked", 0, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_wheelson_blocked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconcapture, 0, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.icondefend, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconneutral, 0, "neutral", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_dom_a", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconcontested, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.var_41bb19836c51437e, 0, "enemy", &"MP_INGAME_ONLY/OBJ_CHECKPOINT_CAPS", "icon_waypoint_koth", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.var_13bb9c2cc0880d1, 0, "friendly", &"MP_INGAME_ONLY/OBJ_CHECKPOINT_CAPS", "icon_waypoint_koth", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.var_849122b5c456dcf5, 0, "enemy", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", "icon_waypoint_koth", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.var_fe2635993c34c970, 0, "friendly", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", "icon_waypoint_koth", 0, undefined);
  level thread function_b65a584330084e94();
}

function function_b65a584330084e94() {
  while(!isDefined(level.escortvehicles) || !isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  setomnvar("ui_wm_escort_objective_id", level.escortvehicles[0].zone.objidnum);

  foreach(vehicle in level.escortvehicles) {
    if(isDefined(vehicle.checkpoints)) {
      foreach(i, checkpoint in vehicle.checkpoints) {
        if(istrue(checkpoint.visible)) {
          setomnvar("ui_wm_escort_checkpoint_" + i, checkpoint.progress);
        }
      }
    }
  }
}

function function_60bf30ad3151f226(player) {
  var_7b5920c79f63bb71 = int(clamp(self.objidnum, 0, game["OBJ_KEYS"].size));
  var_5574d5ac4ebd15d = "icon_waypoint_dom_" + game["OBJ_KEYS"][var_7b5920c79f63bb71];
  scripts\mp\gamelogic::setwaypointiconinfo(level.icontaking, 0, "friendly", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconlosing, 0, "friendly", &"MP_INGAME_ONLY/OBJ_GOAL_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconcapture, 0, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconneutral, 0, "neutral", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.iconcontested, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo(level.icondefend, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", var_5574d5ac4ebd15d, 0, undefined);
  obj_zonecapture::zone_onusebegin(player);
}

function function_e6f69f5a001df1ae(team, player, success) {
  obj_zonecapture::zone_onuseend(team, player, success);
  self.var_572daa460d2bb71b = self.objidnum;
  var_7b5920c79f63bb71 = int(clamp(self.var_572daa460d2bb71b + 1, 0, game["OBJ_KEYS"].size));
  var_5574d5ac4ebd15d = "icon_waypoint_dom_" + game["OBJ_KEYS"][var_7b5920c79f63bb71];
  scripts\mp\objidpoolmanager::update_objective_icon(var_7b5920c79f63bb71, var_5574d5ac4ebd15d);
}

function function_1259100ca5b22bfd(player) {
  zone = self;
  zone obj_zonecapture::deactivatezone();
  zone thread obj_zonecapture::updatechevrons("off");
  zone scripts\mp\gameobjects::disableobject();
  zone.captured = 1;
  zone.active = 0;

  if(zone.objectivekey == "1") {
    leaderdialog("first_point_hacked_attacker", game["attackers"]);
    leaderdialog("first_point_hacked_defender", game["defenders"]);
  }

  level notify("escort_zone_captured", zone);
  player notify("escort_zone_captured");

  if(level.var_bccbe1ff8f6ea962.capture_zones.size > function_b8bd193977a27782()) {
    thread scripts\mp\music_and_dialog::function_20981f58c35e2997(game["attackers"]);
  }
}

function function_742b82afd4cb766c(team, progress, change, capplayer) {
  scripts\mp\gametypes\obj_zonecapture::zone_onuseupdate(team, progress, change, capplayer);

  if(progress < 1 && !level.gameended) {
    function_5abeacef073d11e6(team);
  }

  if(!isDefined(level.escortvehicles) || level.escortvehicles.size < 1) {
    return;
  }

  if(progress >= 0 && level.var_56adfa324022c19b == "state_1") {
    level notify("wheelson_capture_state_1");
    level.var_56adfa324022c19b = "state_2";
  }

  if(progress >= 0.2 && level.var_56adfa324022c19b == "state_2") {
    level notify("wheelson_capture_state_2");
    level.var_56adfa324022c19b = "state_3";
  }

  if(progress >= 0.3 && !istrue(self.firstnotified)) {
    level.escortvehicles[0] notify("point_" + self.pointidx + "_30_percent");
    self.firstnotified = 1;
  }

  if(progress >= 0.4 && level.var_56adfa324022c19b == "state_3") {
    level notify("wheelson_capture_state_3");
    level.var_56adfa324022c19b = "state_4";
  }

  if(progress >= 0.8 && !istrue(self.secondnotified)) {
    level.escortvehicles[0] notify("point_" + self.pointidx + "_80_percent");
    self.secondnotified = 1;
  }

  if(progress >= 0.6 && level.var_56adfa324022c19b == "state_4") {
    level notify("wheelson_capture_state_4");
    level.var_56adfa324022c19b = "state_5";
  }

  if(progress >= 0.8 && level.var_56adfa324022c19b == "state_5") {
    level notify("wheelson_capture_state_5");
    level.var_56adfa324022c19b = "state_6";
  }

  if(progress >= 0.8 && level.var_56adfa324022c19b == "state_6") {
    level notify("wheelson_capture_state_6");
  }
}

function function_5abeacef073d11e6(team) {
  if(!isDefined(self.var_93fb9dad4134739d)) {
    self.var_93fb9dad4134739d = gettime();
  }

  if(self.var_93fb9dad4134739d + 2000 < gettime()) {
    self.var_93fb9dad4134739d = gettime();
    self.visuals[0] playsoundtoteam("jup_wm_hack_beep_ally", team);
    self.visuals[0] playsoundtoteam("jup_wm_hack_beep_enemy", getotherteam(team)[0]);
  }
}

function function_9ace184d65c28ecd(vehicle, capturezone) {
  level endon("game_ended");
  level endon("escort_zone_captured");

  while(true) {
    wait 5;

    if(istrue(capturezone.stalemate)) {
      continue;
    }

    var_95f2a51e7b487eb2 = vehicle function_50b1e7d653deac05(game["attackers"]);

    foreach(attacker in var_95f2a51e7b487eb2) {
      var_9cb84269bb4959b6 = 0;

      if(istrue(attacker scripts\mp\gameobjects::function_781844c0c05b5ac7() && isDefined(attacker.owner))) {
        attacker = attacker.owner;
        var_9cb84269bb4959b6 = 1;
      }

      attacker function_8db3128fbc6e494(#"hash_4eee2253a0d109f1", var_9cb84269bb4959b6);
    }
  }
}

function function_4b18165476fd992a(vehicle, var_3452ca9608f63439) {
  var_95f2a51e7b487eb2 = vehicle function_50b1e7d653deac05(game["attackers"]);

  foreach(attacker in var_95f2a51e7b487eb2) {
    var_9cb84269bb4959b6 = 0;

    if(istrue(attacker scripts\mp\gameobjects::function_781844c0c05b5ac7() && isDefined(attacker.owner))) {
      if(array_contains(var_95f2a51e7b487eb2, attacker.owner)) {
        continue;
      }

      attacker = attacker.owner;
      var_9cb84269bb4959b6 = 1;
    }

    attacker function_8db3128fbc6e494(#"hash_68e3445a3babfc66", var_9cb84269bb4959b6, var_3452ca9608f63439);
  }
}

function function_b63c307e88f55d86(vehicle, objidnum) {
  level endon("game_ended");
  assert(vehicle.pathnodes.size > 0);
  endnode = vehicle.pathnodes[vehicle.pathnodes.size - 1];
  totaldistance = endnode.var_1d7ebd1bcc23a4e1;
  vehicle.var_56df20c41f5b3159 = 1 / totaldistance;

  level thread function_a1f12ca71aa45e6c(vehicle, vehicle.pathnodes);

  if(isDefined(vehicle.spawndata.spawnmethod) && vehicle.spawndata.spawnmethod == "airdrop_at_position_unsafe") {
    vehicle waittill("landed");
  }

  scripts\mp\objidpoolmanager::objective_set_show_progress(objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_progress_team(objidnum, game["defenders"]);
  var_b8d9c602e284684e = 900;

  while(vehicle.progress != 1) {
    waitframe();

    if(!istrue(vehicle.usep2p)) {
      if(!isDefined(vehicle.var_6bb0ab1fe092bd5d)) {
        vehicle.var_6bb0ab1fe092bd5d = 1;
      }

      var_b2f8f3051e3018b1 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d].origin, vehicle.origin);

      if(vehicle.var_6bb0ab1fe092bd5d > 0) {
        var_1f7233a1b7010fe4 = distance2dsquared(vehicle.pathnodes[vehicle.var_6bb0ab1fe092bd5d - 1].origin, vehicle.origin);
      } else {
        var_1f7233a1b7010fe4 = 0;
      }

      if(vehicle.var_6bb0ab1fe092bd5d + 1 < vehicle.pathnodes.size && var_b2f8f3051e3018b1 < var_b8d9c602e284684e && !istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d++;
      } else if(vehicle.var_6bb0ab1fe092bd5d > 0 && var_1f7233a1b7010fe4 < var_b8d9c602e284684e && istrue(vehicle.shouldreverse)) {
        vehicle.var_6bb0ab1fe092bd5d--;
      }

      if(getdvarint(@ "hash_de98b06a57eb27f0", 0) == 1) {
        print3d(vehicle.origin + (0, 0, 200), var_b2f8f3051e3018b1, (1, 0, 0));
      }
    }

    var_92bc69459236be07 = vehicle.var_6bb0ab1fe092bd5d - 1;
    backnode = vehicle.pathnodes[var_92bc69459236be07];

    if(!isDefined(backnode)) {
      continue;
    }

    cachedistance = distance2d(vehicle.origin, backnode.origin);
    progress = (backnode.var_1d7ebd1bcc23a4e1 + cachedistance) / totaldistance;

    if(progress > 1) {
      progress = 1;
    } else if(vehicle.var_6bb0ab1fe092bd5d >= vehicle.pathnodes.size - 1) {
      var_b0162d29bef25c14 = distancesquared(vehicle.pathnodes[vehicle.pathnodes.size - 1].origin, vehicle.origin) < var_b8d9c602e284684e;

      if(var_b0162d29bef25c14) {
        progress = 1;
      }
    }

    if(istrue(vehicle.var_43af500ed85b7ace)) {
      progress = 1;
    } else if(1 == progress) {
      progress = 0.99;
    }

    vehicle.progress = progress;

    if(isDefined(vehicle.checkpoints) && isDefined(vehicle.checkpoints[vehicle.stageid])) {
      if(vehicle.progress >= vehicle.checkpoints[vehicle.stageid].progress) {
        vehicle.stageid++;
        level notify("escort_vehicle_checkpoint_" + vehicle.stageid);
      }
    }

    scripts\mp\objidpoolmanager::objective_set_progress(objidnum, progress);

    if(getdvarint(@ "hash_de98b06a57eb27f0", 0) == 1) {
      print3d(vehicle.origin + (0, 0, 72), "<dev string:x194>" + int(cachedistance) + "<dev string:x19f>" + backnode.var_1d7ebd1bcc23a4e1 + "<dev string:x1ae>" + distance2d(vehicle.origin, vehicle.pathnodes[var_92bc69459236be07 + 1].origin));
    }
  }

  function_21f4ea5eb7868cbd(vehicle);
}

function function_21f4ea5eb7868cbd(vehicle) {
  if(!istrue(vehicle.var_a7719deb5db7d637)) {
    vehicle notify("reached_goal");
    vehicle vehicle_setspeed(0, 0, 1);
    vehicle.var_a7719deb5db7d637 = 1;
    winner = determinewinner(vehicle);
    game["firstRoundAllZonesHacked"] = 1;
    thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["objective_completed"]);
  }
}

function function_50b1e7d653deac05(team) {
  tankorigin = self.origin;
  nearbyrange = self.tanknearbyrange;
  nearbyplayers = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");
  nearbyplayers = sortbydistancecullbyradius(nearbyplayers, tankorigin, nearbyrange);
  laststandplayers = [];

  foreach(player in nearbyplayers) {
    if(istrue(player.inlaststand) || istrue(player.playergoingintols)) {
      laststandplayers[laststandplayers.size] = player;
    }
  }

  nearbyplayers = array_remove_array(nearbyplayers, laststandplayers);
  var_21c4f8a0ffd605ce = [];

  if(issharedfuncdefined("super_capture_bot", "captureBot_getAllCaptureBotsForTeam")) {
    var_21c4f8a0ffd605ce = function_f3bb4f4911a1beb2("super_capture_bot", "captureBot_getAllCaptureBotsForTeam", team, 1);
    var_21c4f8a0ffd605ce = sortbydistancecullbyradius(var_21c4f8a0ffd605ce, tankorigin, nearbyrange);

    foreach(capturebot in var_21c4f8a0ffd605ce) {
      if(isDefined(capturebot.owner) && isDefined(capturebot.owner.team)) {
        scripts\mp\gameobjects::function_f1e265068d2e3fc5(capturebot.owner, capturebot.owner.team);
      }
    }
  }

  var_adbdef6100344a79 = array_combine(nearbyplayers, var_21c4f8a0ffd605ce);

  if(isDefined(level.var_7b3187b12cba9559)) {
    foreach(entity in var_adbdef6100344a79) {
      if(entity istouching(level.var_7b3187b12cba9559)) {
        var_adbdef6100344a79 = arrayremove(var_adbdef6100344a79, entity);
      }
    }
  }

  return var_adbdef6100344a79;
}

function function_7318c4542deb6762(var_3abf844425ac7c00) {
  level endon("game_ended");
  self endon("entitydeleted");
  var_abbff9933224f0a = 0;
  var_da319380d6306e21 = 1;
  stopdistancesq = 1600;
  flagdistancesq = 1600;

  for(i = 0; i < var_3abf844425ac7c00.capture_zones.size; i++) {
    capturezone = var_3abf844425ac7c00.capture_zones[i];
    self.var_bd58ba3741947988 = capturezone;
    capturezone.active = 1;

    capturezone.trigger thread function_86bddcb4c5e824e9();

    var_93f25dd7906beb3c = capturezone.var_93f25dd7906beb3c;
    var_abbff9933224f0a++;
    objective_state(capturezone.objidnum, "current");
    level.var_66cad6c85a4d2a8c = capturezone;
    level.zone = capturezone;

    if(var_abbff9933224f0a == 1) {
      thread function_868663203dc57531(var_93f25dd7906beb3c);
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
      scripts\mp\flags::gameflagset("wheelson_reach_hack_point_1");
      leaderdialog("first_point_reached_attacker", game["attackers"]);
      leaderdialog("first_point_reached_defender", game["defenders"]);
    } else if(var_abbff9933224f0a == 2) {
      thread function_868663203dc57531(var_93f25dd7906beb3c);
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
      scripts\mp\flags::gameflagset("wheelson_reach_hack_point_2");
      leaderdialog("second_point_reached_attacker", game["attackers"]);
      leaderdialog("second_point_reached_defender", game["defenders"]);
    } else {
      thread function_868663203dc57531(var_93f25dd7906beb3c);
      function_cc40376968f08b19(var_93f25dd7906beb3c, stopdistancesq);
      scripts\mp\flags::gameflagset("wheelson_reach_hack_point_3");
    }

    level.var_eef3a4f4d6b03130.currentphase = "wheelson_capture";
    capturezone.useratemultiplier = level.var_74c440fd40f9cc0b;
    capturezone scripts\mp\gameobjects::setusetime(level.zonecapturetime);
    capturezone scripts\mp\gameobjects::enableobject();
    capturezone scripts\mp\gameobjects::allowuse("enemy");
    capturezone thread obj_zonecapture::updatechevrons(game["defenders"]);
    level thread function_9ace184d65c28ecd(self, capturezone);
    objective_state(capturezone.objidnum, "current");
    objective_state(level.var_eef3a4f4d6b03130.objidnum, "done");
    utility::function_3677f2be30fdd581("wm_hack", "hacking_on_" + var_da319380d6306e21);
    capturezone.var_b2dfb3f0778c829a = &"MP/HACKING_EXPLOSIVE";
    capturezone.pointidx = var_abbff9933224f0a;
    self.var_65ab8f532ca7195 = 1;
    self playsoundtoteam("jup_wm_hack_start_ally", self.team);
    self playSound("mp_jup_secure_hack_screens_popup");
    self playsoundtoteam("jup_wm_hack_start_enemy", scripts\mp\utility\game::getotherteam(self.team)[0]);
    level.objectivescaler = ter_op(level.var_fe2c6aa29170b830, level.var_12145f208d7c6529, 1);
    level waittill("escort_zone_captured");
    level.objectivescaler = undefined;
    level.var_eef3a4f4d6b03130.currentphase = "wheelson_escort";
    objective_state(level.var_eef3a4f4d6b03130.objidnum, "current");
    level.var_eef3a4f4d6b03130 scripts\mp\gameobjects::setvisibleteam("any");
    utility::function_3677f2be30fdd581("wm_hack", "hacking_off");
    var_da319380d6306e21 += 1;
    self notify("point_" + var_abbff9933224f0a + "_hacked");
    level notify("point_" + var_abbff9933224f0a + "_hacked");
    self.var_65ab8f532ca7195 = 0;
    scripts\mp\flags::gameflagset("point_" + var_abbff9933224f0a + "_hacked");
    self playsoundtoteam("mp_jup_point_captured", self.team);
    self playsoundtoteam("mp_jup_point_lost", scripts\mp\utility\game::getotherteam(self.team)[0]);
    scripts\mp\gamescore::giveteamscoreforobjective(game["attackers"], 1);
    level thread function_4b18165476fd992a(self, var_abbff9933224f0a);
    game["timePassedInSeconds"][game["attackers"]] = level.timepassedinseconds;

    if(level.currentround >= level.roundlimit) {
      winner = scripts\mp\gamescore::gethighestscoringteam();

      if(winner == "tie") {
        winner = function_906f30bd3a53a4fe();

        if(winner == game["attackers"]) {
          game["teamScores"][winner] = game["teamScores"][winner] + 1;
        }
      }

      if(winner == game["attackers"]) {
        thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["objective_completed"]);
        continue;
      }
    }

    if(!isDefined(level.extratime)) {
      level.extratime = level.bonustime;
      continue;
    }

    level.extratime += level.bonustime;
  }

  self.var_43af500ed85b7ace = 1;
}

function function_cc40376968f08b19(trigger, distsquared) {
  while(true) {
    if(distancesquared(self.origin, trigger.origin) <= distsquared) {
      break;
    }

    waitframe();
  }
}

function function_868663203dc57531(trigger) {
  level endon("game_ended");

  if(!isDefined(trigger.progress)) {
    level waittill("escort_path_set");
  }

  progress = 0;

  if(trigger.script_noteworthy == "hack_point_1") {
    progress = trigger.progress / 2;
  }

  if(trigger.script_noteworthy == "hack_point_2") {
    progress = (trigger.progress - level.var_bccbe1ff8f6ea962.capture_zones[0].var_93f25dd7906beb3c.progress) / 2 + level.var_bccbe1ff8f6ea962.capture_zones[0].var_93f25dd7906beb3c.progress;
  }

  if(trigger.script_noteworthy == "hack_point_3") {
    progress = (trigger.progress - level.var_bccbe1ff8f6ea962.capture_zones[1].var_93f25dd7906beb3c.progress) / 2 + level.var_bccbe1ff8f6ea962.capture_zones[1].var_93f25dd7906beb3c.progress;
  }

  while(true) {
    if(self.progress >= progress) {
      dialog = ter_op(randomint(2), "maw_near_checkpoint_defender", "maw_near_checkpoint_defender2");
      leaderdialog(dialog, game["defenders"]);
      break;
    }

    waitframe();
  }
}

function function_3129b5cf1b77c634(vehicle) {
  level endon("game_ended");

  if(!isDefined(vehicle)) {
    level waittill("wheelson_spawn", vehicle);
  }

  while(!isDefined(level.var_eef3a4f4d6b03130)) {
    waitframe();
  }

  while(true) {
    if(isDefined(level.var_eef3a4f4d6b03130.currentphase) && level.var_eef3a4f4d6b03130.currentphase == "wheelson_capture") {
      vehicle setscriptablepartstate("wm_light", "hacking");
    } else if(vehicle.var_95f2a51e7b487eb2.size == 0 && vehicle.nearbydefenders.size == 0 && !istrue(vehicle.var_5b67ad6d3409a341)) {
      vehicle setscriptablepartstate("wm_light", "stop");
    } else if(vehicle.veh_pathdir == "forward" && !istrue(vehicle.var_5b67ad6d3409a341) && vehicle.nearbydefenders.size == 0) {
      vehicle setscriptablepartstate("wm_light", "forward");
    } else if(vehicle.veh_pathdir == "reverse" || istrue(vehicle.var_5b67ad6d3409a341)) {
      vehicle setscriptablepartstate("wm_light", "reverse");
    } else if(istrue(vehicle.contested)) {
      vehicle setscriptablepartstate("wm_light", "reverse");
    }

    waitframe();
  }
}

function function_c1bc249b0499979e() {
  level endon("game_ended");
  self endon("entitydeleted");

  if(!isDefined(self.pathnodes) || self.pathnodes.size == 0) {
    return;
  }

  self function_a7fac0397762d7a6("p2p", "brakeAtGoal", 0);
  self function_a7fac0397762d7a6("p2p", "goalThreshold", 10);
  nodeid = 0;
  targetnode = self.pathnodes[nodeid];
  self.var_6bb0ab1fe092bd5d = 0;

  while(isDefined(targetnode)) {
    self function_a7fac0397762d7a6("p2p", "goalPoint", targetnode.origin);
    self function_a7fac0397762d7a6("p2p", "goalAngles", targetnode.angles);
    msg = waittill_any_return_3("near_goal", "path_blocked", "reverse_changed");

    if(msg == "path_blocked") {
      continue;
    } else if(msg == "reverse_changed") {
      if(istrue(self.shouldreverse)) {
        self function_a7fac0397762d7a6("p2p", "checkStuck", 0);
        self function_a7fac0397762d7a6("p2p", "reverseForBehindGoal", 1);
      } else {
        self function_a7fac0397762d7a6("p2p", "checkStuck", 1);
        self function_a7fac0397762d7a6("p2p", "reverseForBehindGoal", 0);
      }
    }

    if(istrue(self.shouldreverse)) {
      nodeid--;
    } else {
      nodeid++;
    }

    targetnode = self.pathnodes[nodeid];
    self.var_6bb0ab1fe092bd5d = nodeid;
  }
}

function function_3cd19573df126b43(objidnum, tank) {
  state = 0;
  text = undefined;

  if(istrue(self.var_3a9ae1fe9210a5b7)) {
    if(istrue(tank.var_5b67ad6d3409a341)) {
      state = 4;
      text = &"MP_INGAME_ONLY/OBJ_BLOCKED_BAFFLE";
    } else if(istrue(tank.var_65ab8f532ca7195)) {
      state = 4;
      text = &"MP_INGAME_ONLY/OBJ_HALT_CAPS";
    } else if(tank.contested) {
      state = 3;
      text = &"MP_INGAME_ONLY/OBJ_CONTESTING_CAPS";
    } else if(self.team == game["attackers"]) {
      state = 1;
      text = &"MP_INGAME_ONLY/OBJ_ESCORTING_CAPS";
    } else {
      state = 2;
      text = &"MP_INGAME_ONLY/OBJ_FORCING_BACK_CAPS";
    }
  }

  if(!isDefined(self.var_974cca039ded252e) || self.var_974cca039ded252e != state) {
    thread function_e9ecbc39979febfd(objidnum, state, text, !istrue(tank.var_65ab8f532ca7195));
    self.var_974cca039ded252e = state;
  }
}

function function_e9ecbc39979febfd(objidnum, var_974cca039ded252e, text, var_d2f33cb2882e714d) {
  if(isDefined(self.var_974cca039ded252e) && self.var_974cca039ded252e != 0) {
    scripts\mp\objidpoolmanager::objective_unpin_player(objidnum, self);
    function_8b71eb96e1636edc("", self);
    waitframe();
  }

  if(var_d2f33cb2882e714d) {
    if(var_974cca039ded252e != 0) {
      scripts\mp\objidpoolmanager::objective_pin_player(objidnum, self);
    }

    if(istrue(self.var_3a9ae1fe9210a5b7)) {
      scripts\mp\objidpoolmanager::function_160f522b63c32d76(1, text);
    }
  }
}

function function_b8bd193977a27782() {
  score = 0;

  foreach(zone in level.var_bccbe1ff8f6ea962.capture_zones) {
    if(istrue(zone.captured)) {
      score++;
    }
  }

  return score;
}

function function_56a6df7bc15c1d56(tank, objidnum) {
  scripts\mp\objidpoolmanager::update_objective_sethot(objidnum, istrue(tank.contested || tank.var_5b67ad6d3409a341));

  if(istrue(tank.var_5b67ad6d3409a341)) {
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
  } else if(istrue(tank.contested)) {
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
  } else {
    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS");
    scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_HALT_CAPS");
  }

  if(istrue(tank.var_5b67ad6d3409a341)) {
    scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_blocked"));
    return;
  }

  if(istrue(tank.var_5fb0e90d5b2a8aae)) {
    if(isDefined(tank.repairguy)) {
      scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_repair"));
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_REPAIRING");
    } else {
      scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle_damaged"));
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
    }

    return;
  }

  scripts\mp\objidpoolmanager::update_objective_icon(objidnum, scripts\mp\gameobjects::getwaypointshader("waypoint_escort_vehicle"));
}

function tankscoreevent() {
  level endon("game_ended");
  self endon("entitydeleted");
  self endon("reached_goal");

  while(true) {
    wait 5;
    var_e73e0f9742826fe7 = 0;

    if(istrue(self.contested) || self vehicle_getspeed() == 0) {
      continue;
    }

    if(istrue(self.veh_pathdir == "forward")) {
      var_e73e0f9742826fe7 = 1;
    }

    var_e1c948e35c619ee7 = var_e73e0f9742826fe7 ? game["attackers"] : game["defenders"];
    nearbyplayers = function_50b1e7d653deac05(var_e1c948e35c619ee7);

    foreach(player in nearbyplayers) {
      var_9cb84269bb4959b6 = 0;

      if(istrue(player scripts\mp\gameobjects::function_781844c0c05b5ac7() && isDefined(player.owner))) {
        player = player.owner;
        var_9cb84269bb4959b6 = 1;
      }

      if(var_e1c948e35c619ee7 == game["attackers"]) {
        player function_8db3128fbc6e494(#"hash_342ce3047a7c1fe", var_9cb84269bb4959b6);
        continue;
      }

      player function_8db3128fbc6e494(#"hash_eead7d8ad3d6ecd8", var_9cb84269bb4959b6);
    }
  }
}

function function_8db3128fbc6e494(event, var_9cb84269bb4959b6, var_44a9227c42d73c7d) {
  if(isDefined(var_44a9227c42d73c7d) && var_44a9227c42d73c7d <= 3 && var_44a9227c42d73c7d >= 1) {
    event = hashcat(event, "_" + var_44a9227c42d73c7d);
  }

  if(istrue(var_9cb84269bb4959b6)) {
    event = hashcat(event, "_capture_bot");
  }

  thread scripts\mp\utility\points::doscoreevent(event);
}

function function_180943832c190cc0(isinovertime) {
  return isinovertime;
}

function initspawns() {
  if(!spawnlogic::function_bff229a11ecd1e34()) {
    spawnlogic::setactivespawnlogic("Default", "Crit_Default", 1);
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  spawnkey = "escort";

  if(spawnlogic::function_b17bf43316b9fb08(spawnkey)) {
    spawnlogic::function_afe4709b818e7c9e(spawnkey);
  } else {
    spawnlogic::addstartspawnpoints("mp_escort_spawn_attacker_start", 0, game["attackers"]);
    spawnlogic::addstartspawnpoints("mp_escort_spawn_defender_start", 0, game["defenders"]);
    spawnlogic::registerspawnset("start_attackers", spawnlogic::getspawnpointarray("mp_escort_spawn_attacker_start"));
    spawnlogic::registerspawnset("start_defenders", spawnlogic::getspawnpointarray("mp_escort_spawn_defender_start"));
    spawnlogic::registerspawnset("primary_attackers", spawnlogic::getspawnpointarray("mp_escort_spawn_attacker"));
    spawnlogic::registerspawnset("primary_defenders", spawnlogic::getspawnpointarray("mp_escort_spawn_defender"));
    spawnlogic::addspawnpoints(game["attackers"], "mp_escort_spawn_attacker", 1);
    spawnlogic::addspawnpoints(game["defenders"], "mp_escort_spawn_defender", 1);
    spawnlogic::registerspawnset("fallback_attackers", spawnlogic::getspawnpointarray("mp_escort_spawn_attacker_secondary"));
    spawnlogic::registerspawnset("fallback_defenders", spawnlogic::getspawnpointarray("mp_escort_spawn_defender_secondary"));
    spawnlogic::addspawnpoints(game["attackers"], "mp_escort_spawn_attacker_secondary", 1, 1);
    spawnlogic::addspawnpoints(game["defenders"], "mp_escort_spawn_defender_secondary", 1, 1);

    if(!isDefined(level.spawnpoints)) {
      spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
      spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
      spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
      spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
      tdmspawns = spawnlogic::getspawnpointarray("mp_tdm_spawn");
      var_3d83bc62b320d11a = spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
      spawnlogic::registerspawnset("primary", tdmspawns);
      spawnlogic::registerspawnset("fallback", var_3d83bc62b320d11a);
    }

    spawnlogic::function_48ed29b53fd72775();
  }

  level.mapcenter = spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.spawnpoints[0] = [];
    zone.spawnpoints[2] = [];
  }

  obj_zonecapture::function_4265173fd3869f34(0, "primary_attackers", spawnkey);
  obj_zonecapture::function_4265173fd3869f34(0, "primary_defenders", spawnkey);
  obj_zonecapture::function_4265173fd3869f34(2, "fallback_attackers", spawnkey);
  obj_zonecapture::function_4265173fd3869f34(2, "fallback_defenders", spawnkey);

  foreach(objid, zone in level.objectives) {
    attackerspawns = [];
    defenderspawns = [];
    var_f159cedc9bfd4274 = [];
    var_b00b9ccdeeb95bb8 = [];

    foreach(spawnpoint in zone.spawnpoints[0]) {
      if(is_equal(spawnpoint.classname, "mp_escort_spawn_attacker")) {
        attackerspawns[attackerspawns.size] = spawnpoint;
        continue;
      }

      defenderspawns[defenderspawns.size] = spawnpoint;
    }

    foreach(spawnpoint in zone.spawnpoints[2]) {
      if(is_equal(spawnpoint.classname, "mp_escort_spawn_attacker_secondary")) {
        var_f159cedc9bfd4274[var_f159cedc9bfd4274.size] = spawnpoint;
        continue;
      }

      var_b00b9ccdeeb95bb8[var_b00b9ccdeeb95bb8.size] = spawnpoint;
    }

    zone.var_f2ab575486736a3c = "escort_" + objid + "_attackers";
    zone.var_9495f6521a8eba4 = "escort_" + objid + "_defenders";
    zone.var_902bc32e3298bd0a = "escort_" + objid + "_attackers_fallback";
    zone.var_5465729366911b62 = "escort_" + objid + "_defenders_fallback";
    spawnlogic::registerspawnset(zone.var_f2ab575486736a3c, attackerspawns);
    spawnlogic::registerspawnset(zone.var_9495f6521a8eba4, defenderspawns);
    spawnlogic::registerspawnset(zone.var_902bc32e3298bd0a, var_f159cedc9bfd4274);
    spawnlogic::registerspawnset(zone.var_5465729366911b62, var_b00b9ccdeeb95bb8);
  }
}

function getspawnpoint() {
  var_2fa17baefe0fa286 = function_fc0cbba05d78875();
  spawnparams = scripts\mp\spawnfactor::function_75c03ed937b75b22(level.var_66cad6c85a4d2a8c.trigger getentitynumber(), level.var_66cad6c85a4d2a8c.furthestspawndistsq, var_2fa17baefe0fa286 * var_2fa17baefe0fa286, 12250000);
  usingstartspawns = spawnlogic::shoulduseteamstartspawn();

  if(!isDefined(level.switchedtohardpointspawnlogic) && !spawnlogic::function_bff229a11ecd1e34() && !usingstartspawns) {
    level.switchedtohardpointspawnlogic = 1;
    spawnlogic::setactivespawnlogic("Hardpoint", "Crit_Default");
  }

  if(spawnlogic::function_bff229a11ecd1e34()) {
    factor_set = #"default";

    if(usingstartspawns) {
      factor_set = #"start";
    }

    if(!spawnlogic::isactivespawnlogic(factor_set)) {
      spawnlogic::setactivespawnlogic(factor_set);
    }
  }

  if(usingstartspawns) {
    return spawnlogic::function_8be1c339876506b9(self, "start", self.pers["team"], spawnparams);
  }

  if(is_equal(self.pers["team"], game["attackers"])) {
    spawnset = level.var_66cad6c85a4d2a8c.var_f2ab575486736a3c;
    var_9551de3d91fc9bc2 = level.var_66cad6c85a4d2a8c.var_902bc32e3298bd0a;
  } else {
    spawnset = level.var_66cad6c85a4d2a8c.var_9495f6521a8eba4;
    var_9551de3d91fc9bc2 = level.var_66cad6c85a4d2a8c.var_5465729366911b62;
  }

  return spawnlogic::getspawnpoint(self, self.pers["team"], spawnset, var_9551de3d91fc9bc2, 2, spawnparams);
}

function getrespawndelay() {
  if(level.respawndelaytype == 0) {
    if(self.team == game["defenders"]) {
      return level.defendersrespawndelay;
    } else {
      return level.attackersrespawndelay;
    }

    return;
  }

  return 0;
}

function function_fc0cbba05d78875() {
  return 1000;
}

function onplayerconnect(player) {
  player setextrascore0(0);

  if(isDefined(player.pers["objTime"])) {
    player setextrascore0(player.pers["objTime"]);
  }

  player setextrascore1(0);

  if(isDefined(player.pers["defends"])) {
    player setextrascore1(player.pers["defends"]);
  }
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  victim = self;

  if(!isPlayer(attacker) || attacker.team == victim.team) {
    return;
  }

  zone = level.var_eef3a4f4d6b03130;
  ownerteam = zone scripts\mp\gameobjects::getownerteam();

  if(!isDefined(ownerteam)) {
    return;
  }

  if(isDefined(objweapon) && iskillstreakweapon(objweapon.basename)) {
    return;
  }

  var_9ff9376383f4bc58 = 0;
  attackerteam = attacker.team;

  if(attackerteam != ownerteam) {
    if(isDefined(zone.trigger) && victim istouching(zone.trigger) || istrue(victim.var_3a9ae1fe9210a5b7)) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
      attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
    }

    return;
  }

  if(isDefined(zone.trigger) && attacker istouching(zone.trigger) || istrue(attacker.var_3a9ae1fe9210a5b7)) {
    attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
    attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
    attacker incpersstat("defends", 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker setextrascore1(attacker.pers["defends"]);
  }
}

function ontimelimit() {
  vehicle = level.var_eef3a4f4d6b03130.vehicle;
  winner = determinewinner(vehicle);

  if(isDefined(winner)) {
    thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
  }
}

function determinewinner(vehicle) {
  winner = scripts\mp\gamescore::gethighestscoringteam();
  var_29ab5cf0772e2fec = 0;

  if(!isDefined(vehicle.var_a7719deb5db7d637) || vehicle.var_a7719deb5db7d637 == 0) {
    var_95f2a51e7b487eb2 = vehicle function_50b1e7d653deac05(game["attackers"]);

    if(var_95f2a51e7b487eb2.size > 0) {
      var_29ab5cf0772e2fec = 1;
    }
  }

  if(istrue(game["firstRoundAllZonesHacked"])) {
    var_29ab5cf0772e2fec = 0;
  }

  if(var_29ab5cf0772e2fec && (level.currentround < level.roundlimit || level.currentround >= level.roundlimit && winner != game["attackers"])) {
    if(!isDefined(level.extratime)) {
      level.extratime = 1;
    } else {
      level.extratime += 1;
    }

    setomnvar("ui_match_timer_hidden", 1);
    return;
  }

  if(level.currentround < level.roundlimit) {
    return "match_point";
  }

  if(winner == "tie" && level.currentround >= level.roundlimit) {
    winner = function_906f30bd3a53a4fe();

    if(winner != game["attackers"] && var_29ab5cf0772e2fec == 1) {
      if(!isDefined(level.extratime)) {
        level.extratime = 1;
        return;
      }

      level.extratime += 1;
      return;
    }

    if(winner == game["attackers"] || winner == game["defenders"]) {
      game["teamScores"][winner] = game["teamScores"][winner] + 1;
    }
  }

  if(game["status"] == "overtime") {
    winner = "forfeit";
  } else if(game["status"] == "tie" && level.roundlimit == level.currentround) {
    winner = "overtime";
  }

  return winner;
}

function function_906f30bd3a53a4fe() {
  winner = "tie";

  if(istrue(game["firstRoundAllZonesHacked"]) && isDefined(game["timePassedInSeconds"]) && isDefined(game["timePassedInSeconds"][game["attackers"]]) && isDefined(game["timePassedInSeconds"][game["defenders"]])) {
    if(game["timePassedInSeconds"][game["attackers"]] < game["timePassedInSeconds"][game["defenders"]]) {
      winner = game["attackers"];
    } else if(game["timePassedInSeconds"][game["defenders"]] < game["timePassedInSeconds"][game["attackers"]]) {
      winner = game["defenders"];
    }
  }

  return winner;
}

function function_8298599a4183cd44() {
  level endon("game_ended");
  level endon("round_end_finished");
  var_83901c253811b8db = 0;

  while(true) {
    if(isDefined(level.starttime)) {
      var_b7d39a4661f3460 = gettime();
      level.timepassedinseconds = (var_b7d39a4661f3460 - level.starttime) / 1000;

      if(level.timepassedinseconds > 20 && !var_83901c253811b8db) {
        tank = level.escortvehicles[0];

        if(tank.progress < 0.0001) {
          dialog = ter_op(randomint(2), "maw_not_moved_attacker", "maw_not_moved_attacker2");
          leaderdialog(dialog, game["attackers"]);
          var_83901c253811b8db = 1;
        }
      }
    }

    waitframe();
  }
}

function function_28c9bb84699d73b2() {
  scripts\mp\flags::gameflaginit("zone_2_objective_start", 1);
  scripts\mp\flags::gameflaginit("zone_2_objective_end", 0);
  level._effect["sandbag_built"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_sandbags_debris_02.vfx");
  isinit = level scripts\mp\gametypes\wm_buildable::function_e2344ec3f70a089c();

  if(istrue(isinit)) {
    namespace_555f6ee22fb8fd82::function_61359962e417f21();
    function_a622792cc81eaea2();
    level thread function_51311df691f23540();
  }
}

function function_a622792cc81eaea2() {
  buildinfo = spawnStruct();
  buildinfo.models = level.var_c88bedfa8ddcb42c["Baffle"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["Baffle"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.gestureweapon = "jup_war_ges_wrench_bollard";
  buildinfo.var_32a2681a13f18cb1 = &function_2cd909ef45d6629a;
  buildinfo.var_fc147a62066d05bd = &function_736d94f76d0d49a;
  buildinfo.var_562da06e56403b2f = &function_8da7f2ee4b0a5572;
  level.buildablepool["bdb_Baffle"] = buildinfo;
}

function function_51311df691f23540() {
  level waittill("escort_path_set");
  ents = getEntArray("tri_build_tank_trap", "targetname");

  foreach(index, ent in ents) {
    var_1c59cace1457e117 = getStruct(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_Baffle", ent, ent.script_noteworthy, 0, var_1c59cace1457e117.origin, var_1c59cace1457e117.angles);
    ent.buildable = buildable;
    ent.id = index;

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    var_58c4969f9f12ba44 = getEnt(var_1c59cace1457e117.target, "targetname");
    var_58c4969f9f12ba44.var_7a64011f0deec917 = var_58c4969f9f12ba44.origin;
    var_58c4969f9f12ba44 connectpaths();
    var_58c4969f9f12ba44 notsolid();
    var_58c4969f9f12ba44.origin -= (0, 0, 50);
    var_58c4969f9f12ba44.originalpos = var_58c4969f9f12ba44.origin;
    buildable.clip = var_58c4969f9f12ba44;
    entparts = getEntArray(ent.target, "targetname");

    foreach(part in entparts) {
      if(!isDefined(part.script_noteworthy)) {
        continue;
      }

      if(part.script_noteworthy == "destroy_trigger") {
        ent.destroytrigger = part;
      }
    }

    c4set = getscriptablearray(ent.target, "targetname");

    foreach(c4 in c4set) {
      c4 setscriptablepartstate("body", "init");
      positionvec = c4.origin - buildable.models[0].origin;
      var_a12e637c4db09413 = vectordot(positionvec, anglesToForward(buildable.models[0].angles));

      if(var_a12e637c4db09413 > 0) {
        buildable.c4forward = c4;
        continue;
      }

      buildable.c4back = c4;
    }

    var_8c093373c4b24c9b = getStructArray(var_58c4969f9f12ba44.target, "targetname");

    foreach(node in var_8c093373c4b24c9b) {
      if(node.script_noteworthy == "forward") {
        buildable.var_27d08fc3c69c0059 = node;
        continue;
      }

      buildable.var_e336e2182bf34119 = node;
    }

    ent useTriggerRequireLookAt(1);
    ent thread function_380b6579f5fa4cd();
    buildable thread function_819c53825b132b02("zone_2");
  }
}

function function_2cd909ef45d6629a(player, buildable) {
  buildable thread function_3f4db4dc27eadcb0(player);
  buildable.models[0] function_adc7327a592cc4a1();
}

function function_3f4db4dc27eadcb0(player) {
  level endon("game_ended");
  self endon("stop_building");
  self notify("start_push");
  self endon("start_push");
  var_58c4969f9f12ba44 = self.clip;
  var_b7e0e91fb38920df = var_58c4969f9f12ba44.originalpos + (0, 0, 50);
  var_58c4969f9f12ba44 solid();
  var_58c4969f9f12ba44 movez(40, 0.2);
  positionvec = player.origin - self.models[0].origin;
  var_5f6cefedf599151 = vectordot(positionvec, anglesToForward(self.models[0].angles));

  if(var_5f6cefedf599151 > 0) {
    pushgoal = self.models[0].origin + anglesToForward(self.models[0].angles) * 10;
  } else {
    pushgoal = self.models[0].origin - anglesToForward(self.models[0].angles) * 10;
  }

  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.2, "stop_building", &moveto, pushgoal, 0.2);
  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.4, "stop_building", &movez, 10, 0.1);
  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.5, "stop_building", &moveto, var_b7e0e91fb38920df, 0.2);
}

function function_736d94f76d0d49a(player, buildable) {
  buildable notify("stop_building");
  var_58c4969f9f12ba44 = buildable.clip;
  var_58c4969f9f12ba44 notify("stop_building");
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_8da7f2ee4b0a5572(player, buildable) {
  ent = buildable.triggerent;
  playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  buildable thread function_9017bcad2eca0813("zone_2");
  buildable.clip disconnectPaths();
  buildable.clip function_adc7327a592cc4a1();
  buildable.c4forward setscriptablepartstate("body", "built");
  buildable.c4forward.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4forward, "shimmer_crafting_wm_buildable", "level_script");
  buildable.c4back setscriptablepartstate("body", "built");
  buildable.c4back.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4back, "shimmer_crafting_wm_buildable", "level_script");
  forwardendnode = getStruct(buildable.var_27d08fc3c69c0059.target, "targetname");
  backendnode = getStruct(buildable.var_e336e2182bf34119.target, "targetname");
  createnavlink("baffle_forward_warp_over", buildable.var_27d08fc3c69c0059.origin, forwardendnode.origin, "traverse_warp_over");
  createnavlink("baffle_back_warp_over", buildable.var_e336e2182bf34119.origin, backendnode.origin, "traverse_warp_over");
  destroyobj = scripts\mp\gametypes\wm_buildable::function_310f1a814bf9c37c(buildable, ent.destroytrigger, &"MP_JUP_LAUNCHFACILITY/REMOVETANKTRAP", 3, undefined, &function_acb62a89095ed874);
  setomnvar("ui_wm_escort_trap_" + ent.id, ent.progress);
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[0], "hogs_destroyed");
}

function function_acb62a89095ed874(player) {
  self.buildable notify("trap_destroyed");
  ent = self.buildable.triggerent;
  setomnvar("ui_wm_escort_trap_" + ent.id, 0);
  oldmodel = self.buildable.models[0];

  if(isDefined(oldmodel)) {
    scripts\mp\utility\outline::outlinedisable(oldmodel.outlineid, oldmodel);
  }

  var_2642ca865799c9 = oldmodel.origin;
  var_c617038fddbdb57 = oldmodel.angles;
  newbuildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_2642ca865799c9, var_c617038fddbdb57);
  ent.buildable = newbuildable;
  newbuildable.clip = self.buildable.clip;
  newmodel = newbuildable.models[0];

  if(isDefined(newmodel)) {
    newmodel.outlineid = scripts\mp\utility\outline::outlineenableforall(newmodel, "shimmer_crafting_wm_buildable", "level_script");
  }

  ent.buildable.c4back = self.buildable.c4back;
  ent.buildable.c4forward = self.buildable.c4forward;
  destroynavlink("baffle_forward_warp_over");
  destroynavlink("baffle_back_warp_over");
  ent.buildable.var_27d08fc3c69c0059 = self.buildable.var_27d08fc3c69c0059;
  ent.buildable.var_e336e2182bf34119 = self.buildable.var_e336e2182bf34119;
  ent.buildable.clip connectpaths();
  ent.buildable.clip notsolid();
  ent.buildable.clip movez(-50, 0.2);
  ent useTriggerRequireLookAt(1);
  ent thread function_380b6579f5fa4cd();
  newbuildable thread function_819c53825b132b02("zone_2");
}

function function_380b6579f5fa4cd() {
  self notify("stop_get_progress");
  self endon("stop_get_progress");
  level endon("game_ended");
  pathnodes = getvehiclenodearray("tank_trap_pos", "script_noteworthy");

  if(pathnodes.size <= 0) {
    pathnodes = getStructArray("tank_trap_pos", "script_noteworthy");
  }

  if(pathnodes.size <= 0) {
    assertmsg("<dev string:x1b9>" + self.origin + "<dev string:x1db>");
    self.buildable.useobj.trigger makeunusable();
    return;
  }

  pathnode = sortbydistance(pathnodes, self.origin)[0];
  scripts\mp\flags::gameflagwait("zone_2_objective_start");
  distsquared = distance2dsquared(self.origin, pathnode.origin);

  if(distsquared > 3000) {
    assertmsg(distsquared + "<dev string:x1b9>" + self.origin + "<dev string:x1db>");
    self.buildable.useobj.trigger makeunusable();
  }

  self.progress = pathnode.progress;
}

function function_819c53825b132b02(zoneinfo) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("escort_vehicle_spawned");
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  var_31a72e6f2e39b666 = spawn("script_model", self.triggerent.origin);
  var_31a72e6f2e39b666.angles = self.triggerent.angles;
  var_31a72e6f2e39b666 makeusable();
  var_31a72e6f2e39b666 sethintdisplayrange(128);
  var_31a72e6f2e39b666 sethintdisplayfov(360);
  var_31a72e6f2e39b666 setuserange(128);
  var_31a72e6f2e39b666 setusefov(360);
  var_31a72e6f2e39b666 sethintonobstruction("show");
  var_31a72e6f2e39b666 setCursorHint("HINT_NOBUTTON");
  var_31a72e6f2e39b666 setHintString(&"MP_JUP_WM/UNABLE_TO_BUILD_BAFFLE");

  while(self.buildphase == 0 && isDefined(tank)) {
    if(abs(self.triggerent.progress - tank.progress) > tank.var_56df20c41f5b3159 * 200) {
      self.useobj.trigger makeusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 disableplayeruse(player);
      }
    } else {
      self.useobj.trigger makeunusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 enableplayeruse(player);
      }
    }

    waitframe();
  }

  var_31a72e6f2e39b666 delete();
}

function function_9017bcad2eca0813(zoneinfo) {
  level endon("game_ended");
  self endon("deleted");
  scripts\mp\flags::gameflagwait("escort_vehicle_spawned");
  ref = self.models[0] getentitynumber();
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  while(true) {
    if(!istrue(tank.var_7150b8620d62148[ref]) && istrue(function_a8fd08ad364df689(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 1;

      if(self.triggerent.progress > tank.progress) {
        tank.directionblocked[ref] = "forward";
      } else {
        tank.directionblocked[ref] = "backward";
      }
    }

    msg = waittill_notify_or_timeout_return("trap_destroyed", level.framedurationseconds);

    if(msg == "trap_destroyed") {
      tank.var_7150b8620d62148[ref] = 0;
      break;
    }

    if(istrue(tank.var_7150b8620d62148[ref]) && !istrue(function_a8fd08ad364df689(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 0;
    }
  }
}

function function_a8fd08ad364df689(var_56df20c41f5b3159, trapprogress, tankprogress) {
  return tankprogress - trapprogress > var_56df20c41f5b3159 * 45 * -1 && tankprogress - trapprogress < var_56df20c41f5b3159 * 90;
}

function registerescortcollisioncallback(callback) {
  self.escortcollisioncallback = callback;
}

function function_9d7b6a4d62e449fb() {
  level endon("<dev string:x249>");
  level notify("<dev string:x257>");
  level endon("<dev string:x257>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      points = getdvarint(@ "hash_46a6b424af6acbc2");

      if(points == -1) {
        points = getdvarint(@ "hash_47ffa661178edb25") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x26d>", points, 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      points = getdvarint(@ "hash_86e14326e43c0115");

      if(points == -1) {
        points = getdvarint(@ "hash_47ffa661178edb25") - 1;
      }

      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x277>", points, 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_9d7b6a4d62e449fb();
}

function function_86bddcb4c5e824e9() {
  self endon("<dev string:x27f>");

  while(true) {
    if(getdvarint(@ "hash_f7880ced2490f6ea", 0) == 1) {
      drawentitybounds(self, (1, 1, 0), 0, 1);
    }

    waitframe();
  }
}

function function_a1f12ca71aa45e6c(vehicle, pathnodes) {
  level endon("<dev string:x249>");
  vehicle endon("<dev string:x288>");

  while(true) {
    if(getdvarint(@ "hash_de98b06a57eb27f0", 0) == 1) {
      for(i = 0; i < pathnodes.size; i++) {
        if(array_contains(level.escortroute, pathnodes[i])) {
          box(pathnodes[i].origin, pathnodes[i].angles[1], (1, 0, 0), 0, 1);
        } else {
          box(pathnodes[i].origin, pathnodes[i].angles[1], (1, 1, 1), 0, 1);
        }

        print3d(pathnodes[i].origin + (0, 0, 50), "<dev string:x298>" + i + "<dev string:x2a1>" + pathnodes[i].var_1d7ebd1bcc23a4e1);
        print3d(pathnodes[i].origin + (0, 0, 36), "<dev string:x2a7>" + int(pathnodes[i].progress * 100) + "<dev string:x2ab>");
      }
    }

    waitframe();
  }
}

# /