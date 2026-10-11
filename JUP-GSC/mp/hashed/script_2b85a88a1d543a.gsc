/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2b85a88a1d543a.gsc
***********************************************/

#using script_3aacf02225ca0da5;
#using script_5c65d346ac65390c;
#using script_713ccfa3a01d4d19;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\poi;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_38792c8a2bf7f251;

function autoexec init() {
  svenabled = getmatchrulesdata("brData", "svEnabled");
  var_183344133d2e1d5e = getdvarint(@ "hash_f35af94032732e47", svenabled);

  if(!var_183344133d2e1d5e) {
    return false;
  }

  if(isDefined(level.secondaryvictory)) {
    return true;
  }

  svdata = getmatchrulesdata("brData", "svData");

  if(!isDefined(svdata)) {
    return false;
  }

  svbundlename = hashcat(%"hash_7ab67ff682ad6a50", svdata);
  svbundle = getscriptbundle(svbundlename);
  function_89db4cf4358b1915(1);

  scripts\mp\gametypes\br_dev::registerhandlecommand(&handledevcommand);

  level.secondaryvictory = spawnStruct();
  level.secondaryvictory.started = 0;
  level.secondaryvictory.var_7210c81ee207cdb0 = max(getdvarint(@ "hash_31739bb33b05d74c", svbundle.choppertime), 26.5);
  level.secondaryvictory.choppertotaltime = level.secondaryvictory.var_7210c81ee207cdb0 + svbundle.var_4ccd047b077a4b6a.waittime;
  level.secondaryvictory.scriptbundle = svbundle;
  level.secondaryvictory.var_f1a47f3d1492db51 = &function_f1a47f3d1492db51;
  level.secondaryvictory.var_3a91667e613d19c1 = &function_3a91667e613d19c1;
  level.secondaryvictory.var_ca6df075cc967173 = [];
  level.secondaryvictory.missions = [];
  level.secondaryvictory.var_5fc0bb331fcc1784 = svbundle.var_5fc0bb331fcc1784;
  level.secondaryvictory.var_ddb244800e3f1329 = randomintrange(0, svbundle.var_8396ddb130a38012);
  level.secondaryvictory.var_ddd94078236bd05 = getdvarint(@ "hash_8546cb8c5523f232", 20);
  level.secondaryvictory.mindistance = getdvarint(@ "hash_ec6a0742a30321bd", svbundle.mindistance);
  level.secondaryvictory.maxdistance = getdvarint(@ "hash_b083e7f0964a470f", svbundle.maxdistance);

  level.secondaryvictory.var_c0c782ebf134ee03 = getdvarint(@ "hash_d45f2e96f48c9129", 0);

  assert(level.secondaryvictory.var_5fc0bb331fcc1784 > 0);
  function_15ec8dc28147b1b7(@ "hash_64d082079ceb46b6", &function_b878acdc34c32bd, &function_e89fc0ef7d6123d9, "cash");
  function_15ec8dc28147b1b7(@ "hash_64d081079ceb4483", &function_677a58693f27bb60, &function_15e5e77836d740c2, "");
  game["dialog"]["brsv_pickup_inbound"] = "chop_grav_chne";
  game["dialog"]["brsv_pickup_arrived"] = "chop_grav_char";
  game["dialog"]["brsv_exfiltration"] = "chop_grav_chle";

  level.var_82a0e660e66306dc = 1;

  thread function_7d47bded29ed7882(svbundle.var_4ccd047b077a4b6a);
  level thread function_48f199019893233();
  return true;
}

function function_7d47bded29ed7882(var_4ccd047b077a4b6a) {
  assert(isDefined(var_4ccd047b077a4b6a));
  namespace_e8fceb5cf6e8cdf8::function_7d47bded29ed7882(var_4ccd047b077a4b6a.timetoarrive, var_4ccd047b077a4b6a.heliheight, var_4ccd047b077a4b6a.waittime, var_4ccd047b077a4b6a.minwaittime, var_4ccd047b077a4b6a.var_1a7e969d835799f2, var_4ccd047b077a4b6a.exitheight, var_4ccd047b077a4b6a.var_abe738473a42706b, var_4ccd047b077a4b6a.helihealth);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("player_exfil_timer", &function_7b63b062159d64cb);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("music_stop", &function_118dc20289bc94a0);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("exfil_players", &function_d15cbb4f920e92fd);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("reset_exfil", &function_7b51c79840a37c3a);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("setup_gas_masks", &function_8c8e1037bb8c3ef4);
}

function handledevcommand(command, args) {
  switch (command) {
    case #"hash_af32b9b7ebc04c7":
      function_30fb8dea9a7466c4(level.secondaryvictory.var_6a74104a63470ca2);
      break;
    case #"hash_1b4ecfb568298fd2":
      level thread function_627d884a50e4bbbc();
      break;
    case #"hash_7c8ad5104b2870aa":
      function_8f78f23c923cee28(args);
      break;
    case #"hash_fdff73e06f359bb":
      devvictory(args);
      break;
    case #"hash_d4e56e3ef5685967":
      function_ddd97b020459c8d1(args);
      break;
    case #"hash_8ffd5b7429ec26f2":
      devsplash(args);
      break;
    case #"hash_5177508bcd7a8800":
      player = devgetplayer();
      player playsoundtoteam(args[0], player.team);
      break;
  }
}

function private function_627d884a50e4bbbc() {
  player = devgetplayer();

  while(true) {
    wait 1;
    triggers = function_4edea32bcde90be0(player.origin);

    if(isDefined(level.var_87a042f91827f93d)) {
      function_30fb8dea9a7466c4(triggers);
    }

    function_30fb8dea9a7466c4(triggers);
  }
}

function private function_30fb8dea9a7466c4(triggers) {
  if(!isDefined(level.var_87a042f91827f93d)) {
    level.var_87a042f91827f93d = [];

    if(isDefined(level.secondaryvictory) && isDefined(triggers)) {
      foreach(et in triggers) {
        objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

        if(objid != -1) {
          scripts\mp\objidpoolmanager::objective_add_objective(objid, "<dev string:x87>", et.origin, "<dev string:x92>");
          scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
          scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 1);
          level.var_87a042f91827f93d[level.var_87a042f91827f93d.size] = objid;
          continue;
        }

        println("<dev string:xb3>");
      }
    }

    return;
  }

  foreach(objid in level.var_87a042f91827f93d) {
    scripts\mp\objidpoolmanager::returnobjectiveid(objid);
  }

  level.var_87a042f91827f93d = undefined;
}

function private devgetplayer(args) {
  player = scripts\mp\gametypes\br_dev::function_69dffe7a5cb1b4b9();

  if(isDefined(args) && args.size > 0 && int(args[0]) > 0) {
    player = level.players[int(args[0])];
  }

  return player;
}

function private function_8f78f23c923cee28(args) {
  if(!isDefined(level.secondaryvictory)) {
    iprintln("<dev string:xe1>");
    return;
  }

  if(!level.secondaryvictory.started) {
    iprintln("<dev string:x105>");
    return;
  }

  player = devgetplayer(args);
  player function_2aa9a736450d87ce();
}

function private devvictory(args) {
  if(!isDefined(level.secondaryvictory)) {
    iprintln("<dev string:xe1>");
    return;
  }

  endingid = 0;

  if(isDefined(args) && args.size > 0) {
    endingid = int(args[0]);
  } else {
    endingid = level.secondaryvictory.var_ddb244800e3f1329;
    function_1324ed2d881d301f();
  }

  player = devgetplayer();
  player function_d15cbb4f920e92fd([player], function_d6da5b6a241b8149(player.team));
}

function private function_ddd97b020459c8d1(args) {
  if(!isDefined(level.secondaryvictory)) {
    iprintln("<dev string:xe1>");
    return;
  }

  player = devgetplayer();
  players = level.teamdata[player.team]["<dev string:x11e>"];
  player function_d15cbb4f920e92fd(players, function_d6da5b6a241b8149(player.team));
}

function private function_d6da5b6a241b8149(team) {
  seq = spawnStruct();
  seq.team = team;
  seq.trigger = spawnStruct();
  seq.trigger.origin = (0, 0, 0);
  info = spawnStruct();
  info.var_394aebba88e4e8c2 = seq;
  return info;
}

function private devsplash(args) {
  if(!isDefined(args) || args.size < 1) {
    return;
  }

  player = devgetplayer();
  splash = args[0];
  player function_f3830638ad346e8e(splash);
}

function function_48f199019893233() {
  level endon("game_ended");
  level waittill("prematch_done");

  if(level.mapname == "mp_jup_br_mechanics") {
    utility::addstruct({
      #origin: (487, -2506, 0), #angles: (0, 0, 0), #script_noteworthy: "chopper_exfil_covert"});
    utility::addstruct({
      #origin: (-1528, -2257, 0), #angles: (0, 90, 0), #script_noteworthy: "chopper_exfil_covert"});
    utility::addstruct({
      #origin: (-1309, 466, 0), #angles: (0, 90, 0), #script_noteworthy: "chopper_exfil_covert"});
  } else if(scripts\cp_mp\utility\game_utility::function_314ff105a27cc131()) {
    finalstruct = {
      #origin: (-2870, 416, 1258), #angles: (0, 53, 0), #script_noteworthy: "chopper_exfil_covert"};
    utility::addstruct(finalstruct);
  } else if(scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    var_6a74104a63470ca2 = getStructArray("chopper_exfil_covert", "script_noteworthy");

    if(var_6a74104a63470ca2.size == 0) {
      utility::addstruct({
        #origin: (7053, 5551, 1440), #angles: (0, 61, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-22731, -9846, 1503), #angles: (0, 352, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (6990, -26253, 1705), #angles: (0, 88, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (23741, 10660, 1469), #angles: (0, 0, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-166, 19195, 998), #angles: (0, 255, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-355, -15090, 2042), #angles: (0, 175, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-16673, 10802, 1274), #angles: (0, 340, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-11505, -20149, 1745), #angles: (0, 128, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (26560, -16714, 3066), #angles: (0, 70, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (23985, 428, 2549), #angles: (0, 70, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-27443, 4315, 1029), #angles: (0, 15, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-2047, 1837, 2006), #angles: (0, 210, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (-13712, 28828, 2589), #angles: (0, 94, 0), #script_noteworthy: "chopper_exfil_covert"});
      utility::addstruct({
        #origin: (11350, 26786, 1564), #angles: (0, 150, 0), #script_noteworthy: "chopper_exfil_covert"});
    }
  }

  level.secondaryvictory.var_6a74104a63470ca2 = getStructArray("chopper_exfil_covert", "script_noteworthy");
  iprintln("exfil trigger count: " + level.secondaryvictory.var_6a74104a63470ca2.size);

  for(i = 0; i < level.secondaryvictory.var_6a74104a63470ca2.size; i++) {
    if(isDefined(level.secondaryvictory.var_6a74104a63470ca2[i].target)) {
      helinode = getStruct(level.secondaryvictory.var_6a74104a63470ca2[i].target, "targetname");

      if(isDefined(helinode)) {
        level.secondaryvictory.var_6a74104a63470ca2[i].heliorigin = helinode.origin;
        level.secondaryvictory.var_6a74104a63470ca2[i].heliangles = helinode.angles;
      }
    }
  }

  level thread function_d2c4882ce103ea5();
  initteamdata();
  level.secondaryvictory.started = 1;
  function_3049b4b9d7489dca(1);
  function_3f39c7ace07c243();
}

function function_d2c4882ce103ea5() {
  waitframe();

  for(i = 0; i < level.secondaryvictory.var_6a74104a63470ca2.size; i++) {
    node = level.secondaryvictory.var_6a74104a63470ca2[i];
    node.circleinfo = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab(node.origin);

    if(i % 20 == 0) {
      waitframe();
    }
  }
}

function function_f1a47f3d1492db51() {
  player = self;
  teamdata = getteamdata(player.team);

  if(isDefined(teamdata.var_394aebba88e4e8c2)) {
    iprintln(player.name + "<dev string:x129>");

    return false;
  }

  return true;
}

function function_3a91667e613d19c1(pickupent) {
  player = self;

  if(!isDefined(level.secondaryvictory)) {
    return;
  }

  iprintlnbold("<dev string:x169>");

  player function_2aa9a736450d87ce();
}

function function_70ee001b7b3a1bd0() {
  player = self;
  teamdata = getteamdata(player.team);

  if(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
    iprintln("<dev string:x183>" + player.name + "<dev string:x19e>");

    return 27;
  }

  if(isDefined(teamdata.var_394aebba88e4e8c2)) {
    iprintln("<dev string:x183>" + player.name + "<dev string:x1ba>");

    return 26;
  }

  trigger = function_64b11aef75e78506(player.origin);

  if(!isDefined(trigger)) {
    iprintln("<dev string:x183>" + player.name + "<dev string:x1df>");

    return 18;
  }

  return 2;
}

function function_2aa9a736450d87ce() {
  assert(level.secondaryvictory.started);

  if(istrue(level.secondaryvictory.var_c0c782ebf134ee03)) {
    foreach(trigger in level.secondaryvictory.var_6a74104a63470ca2) {
      thread startevent(self, trigger);
    }

    return;
  }

  if(function_70ee001b7b3a1bd0() != 2) {
    return;
  }

  player = self;
  teamdata = getteamdata(player.team);
  assert(!isDefined(teamdata.var_394aebba88e4e8c2));
  trigger = function_64b11aef75e78506(player.origin);
  assert(isDefined(trigger));
  thread startevent(player, trigger);
}

function startevent(player, trigger) {
  var_394aebba88e4e8c2 = function_fdd037317409179e(player);
  team = player.team;
  teamdata = getteamdata(team);
  teamdata.var_394aebba88e4e8c2 = var_394aebba88e4e8c2;
  level endon("game_ended");

  if(var_394aebba88e4e8c2.achieved || var_394aebba88e4e8c2.inprogress) {
    return;
  }

  function_92993664746f4afa(team, level.secondaryvictory.scriptbundle.var_48b81409af379a6b);
  function_6a694b8e45c2ca3c("brsv_pickup_inbound", var_394aebba88e4e8c2.team, 3);

  iprintln("<dev string:x1f7>" + var_394aebba88e4e8c2.name);

  var_394aebba88e4e8c2.inprogress = 1;
  trigger.inuse = 1;
  var_394aebba88e4e8c2 thread function_203ccd957c2ef7e4(level.teamdata[team]["players"]);
  avg_dist = 0;

  foreach(p in level.teamdata[team]["players"]) {
    d = distance2d(p.origin, trigger.origin);
    avg_dist += d;
    p function_810f4a04a9253967(d);
  }

  teamsize = level.teamdata[team]["players"].size;
  avg_dist /= teamsize;
  function_4c04d9675ebe2f9f(team, teamsize, trigger.origin, avg_dist, level.secondaryvictory.var_7210c81ee207cdb0);
  assert(!isDefined(var_394aebba88e4e8c2.var_86909aea6009b811));
  var_394aebba88e4e8c2 initchopper(trigger);
  var_394aebba88e4e8c2 function_160e85c84dcd9d28();
  var_394aebba88e4e8c2 choppersequence();
  var_394aebba88e4e8c2 cleanup();
  var_394aebba88e4e8c2.inprogress = 0;
  teamdata.var_394aebba88e4e8c2 = undefined;

  iprintln("<dev string:x22f>" + var_394aebba88e4e8c2.name + "<dev string:x24b>");
}

function function_4edea32bcde90be0(origin) {
  scriptbundle = level.secondaryvictory.scriptbundle;
  min2 = squared(level.secondaryvictory.mindistance);
  max2 = squared(level.secondaryvictory.maxdistance);
  comparetime = level.secondaryvictory.choppertotaltime;
  weights = [];
  maxweight = 0;

  for(i = 0; i < level.secondaryvictory.var_6a74104a63470ca2.size; i++) {
    exfiltrigger = level.secondaryvictory.var_6a74104a63470ca2[i];
    d2 = distance2dsquared(exfiltrigger.origin, origin);
    weight = 0;

    if(d2 > min2) {
      weight += 1;
    }

    if(d2 < max2) {
      weight += 2;
    }

    if(isDefined(exfiltrigger.circleinfo)) {
      dangertime = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852(exfiltrigger.circleinfo);

      if(dangertime >= comparetime) {
        weight += 4;
      }
    }

    weights[i] = weight;
    maxweight = max(maxweight, weight);
  }

  besttriggers = [];

  for(i = 0; i < level.secondaryvictory.var_6a74104a63470ca2.size; i++) {
    exfiltrigger = level.secondaryvictory.var_6a74104a63470ca2[i];

    if(weights[i] == maxweight && !istrue(exfiltrigger.inuse)) {
      besttriggers[besttriggers.size] = exfiltrigger;
    }
  }

  if(besttriggers.size > 5) {
    besttriggers = sortbydistance(besttriggers, origin);
    besttriggers = array_slice(besttriggers, 0, 5);
  }

  return besttriggers;
}

function function_64b11aef75e78506(origin) {
  besttriggers = function_4edea32bcde90be0(origin);

  if(besttriggers.size == 0) {
    return undefined;
  }

  return random(besttriggers);
}

function initchopper(trigger) {
  var_394aebba88e4e8c2 = self;
  var_394aebba88e4e8c2.trigger = trigger;
  var_394aebba88e4e8c2.var_3064fa24dbbd5bbf = function_ee503e14666bf0b9(var_394aebba88e4e8c2.trigger);
  var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.var_394aebba88e4e8c2 = var_394aebba88e4e8c2;
  function_68d3e10e25ad432(var_394aebba88e4e8c2.var_3064fa24dbbd5bbf);
}

function function_363fe741930d5e4b() {
  var_394aebba88e4e8c2 = self;
  scriptbundle = level.secondaryvictory.scriptbundle;
  radius2 = scriptbundle.var_8544cdb39053b6da * scriptbundle.var_8544cdb39053b6da;
  time = min(scriptbundle.var_fccf931e70112a65, level.secondaryvictory.var_7210c81ee207cdb0);
  wait time;

  iprintln("<dev string:x258>" + scriptbundle.var_8544cdb39053b6da + "<dev string:x282>");

  teamsinrange = [];

  foreach(team, data in level.teamdata) {
    if(team == var_394aebba88e4e8c2.team) {
      continue;
    }

    foreach(player in data["players"]) {
      if(distance2dsquared(player.origin, var_394aebba88e4e8c2.trigger.origin) < radius2) {
        teamsinrange = function_6d6af8144a5131f1(teamsinrange, player.team);
        break;
      }
    }
  }

  foreach(team in teamsinrange) {
    iprintln("<dev string:x287>" + player.team);

    function_92993664746f4afa(team, scriptbundle.var_a5dce8ab6aa7ff9b);
  }

  ent = var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent;
  ent setscriptablepartstate("br_sv_exfil_icon", "communal_icon");
}

function choppersequence() {
  var_394aebba88e4e8c2 = self;
  assert(isDefined(var_394aebba88e4e8c2.player));
  var_394aebba88e4e8c2 thread function_3681229b1ab89438();
  var_394aebba88e4e8c2 thread function_363fe741930d5e4b();
  overhead = 26.5;
  waittime = max(level.secondaryvictory.var_7210c81ee207cdb0 - overhead, 0);
  wait waittime;
  var_394aebba88e4e8c2.player thread namespace_e8fceb5cf6e8cdf8::function_d1478474b036b87f(var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent, undefined, undefined, var_394aebba88e4e8c2.player, undefined, undefined, undefined, "vj001");
  var_394aebba88e4e8c2 waittill("chopperSequence_done");
}

function function_3681229b1ab89438() {
  var_394aebba88e4e8c2 = self;
  waittime = int(level.secondaryvictory.var_7210c81ee207cdb0);
  function_b27feffb50ecce3(self.player.team, waittime);
  wait waittime - 1;
}

function function_68d3e10e25ad432(var_3064fa24dbbd5bbf, model) {
  if(isDefined(var_3064fa24dbbd5bbf.ent)) {
    return;
  }

  if(!isDefined(model)) {
    model = var_3064fa24dbbd5bbf.modelname;
  }

  ent = spawn("script_model", var_3064fa24dbbd5bbf.origin);
  ent setModel(model);
  ent.angles = var_3064fa24dbbd5bbf.angles;
  ent.info = var_3064fa24dbbd5bbf;
  ent.var_394aebba88e4e8c2 = var_3064fa24dbbd5bbf.var_394aebba88e4e8c2;
  scripts\cp_mp\calloutmarkerping::function_6b9641d0060c3a2c(ent);
  ent setscriptablepartstate("dmz_exfil_smoke", "smoking", 0);
  ent setscriptablepartstate("dmz_exfil_site", "standby");
  ent setotherent(var_3064fa24dbbd5bbf.var_394aebba88e4e8c2.player);
  var_3064fa24dbbd5bbf.ent = ent;
}

function function_ee503e14666bf0b9(node) {
  var_3064fa24dbbd5bbf = spawnStruct();

  if(isDefined(node.poi)) {
    var_3064fa24dbbd5bbf.poi = node.poi;
  } else {
    var_3064fa24dbbd5bbf.poi = scripts\mp\poi::function_55cf921efa4cbd09(node.origin);
  }

  var_3064fa24dbbd5bbf.angles = node.angles;
  var_3064fa24dbbd5bbf.origin = scripts\mp\gametypes\br_public::droptogroundmultitrace(getclosestpointonnavmesh(node.origin));
  var_3064fa24dbbd5bbf.modelname = level.secondaryvictory.scriptbundle.var_abd5187f5fa7e8f8;

  if(isDefined(node.heliorigin) && isDefined(node.heliangles)) {
    var_3064fa24dbbd5bbf.helitargetorigin = node.heliorigin;
    var_3064fa24dbbd5bbf.helitargetangles = node.heliangles;
  } else {
    var_3064fa24dbbd5bbf.helitargetorigin = node.origin;
    var_3064fa24dbbd5bbf.helitargetangles = node.angles;
  }

  if(isDefined(node.script_label)) {
    if(node.script_label == "land") {
      var_3064fa24dbbd5bbf.land = 1;
    }
  }

  return var_3064fa24dbbd5bbf;
}

function function_7b63b062159d64cb(heli, time, dist) {
  self notify("exgm_exfil_timer");
  self endon("disconnect");
  self endon("exgm_exfil_timer");
  timer = time;

  if(heli.callingteam != self.team) {
    return;
  }

  teamdata = getteamdata(heli.callingteam);

  if(!isDefined(teamdata.var_394aebba88e4e8c2)) {
    return;
  }

  var_394aebba88e4e8c2 = teamdata.var_394aebba88e4e8c2;
  assert(isDefined(var_394aebba88e4e8c2) && isDefined(var_394aebba88e4e8c2.var_241735be4107a4fa));

  if(!var_394aebba88e4e8c2.var_241735be4107a4fa) {
    function_f3830638ad346e8e(level.secondaryvictory.scriptbundle.var_916f6b3ff9e56ecb);
    function_6a694b8e45c2ca3c("brsv_pickup_arrived", var_394aebba88e4e8c2.team);
    var_394aebba88e4e8c2.var_241735be4107a4fa = 1;
  }

  if(!isDefined(timer) || !isDefined(heli)) {
    return;
  }

  while(timer > 0) {
    if(timer < 11) {
      self setentitysoundcontext("lobby_fade", "on");
    }

    if(isDefined(dist) && (!isDefined(self) || distance(heli.origin, self.origin) > dist)) {
      break;
    }

    if(timer < 80) {
      function_74cdb6b6565f33a3(timer);
    }

    timer--;
    wait 1;
  }

  namespace_e8fceb5cf6e8cdf8::function_423f49e2512a5f53();
  function_74cdb6b6565f33a3(0);
  self setentitysoundcontext("lobby_fade", "", 2);
  function_6a694b8e45c2ca3c("brsv_exfiltration", var_394aebba88e4e8c2.team);
}

function function_8c8e1037bb8c3ef4(heli) {
  var_bf80f581fdce86d2 = heli.angles + (0, -90, -18);
  var_840c2ee92c8f78fe = [(33, 40, -198), (-15, 40, -198), (-58, 40, -198), (-105, 40, -198)];

  foreach(offset in var_840c2ee92c8f78fe) {
    relativeoffset = rotatevector(offset, heli.angles);
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(heli.origin + relativeoffset, var_bf80f581fdce86d2);
    gasmask = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_equip_gasmask", dropinfo, 108);
    gasmask utility::scriptable_setparententity(heli, offset);
  }
}

function function_b27feffb50ecce3(team, time) {
  self notify("exgm_exfil_timer");
  self endon("disconnect");
  self endon("exgm_exfil_timer");
  timer = time;

  if(!isDefined(timer)) {
    return;
  }

  while(timer > 0) {
    foreach(teammember in level.teamdata[team]["players"]) {
      teammember function_74cdb6b6565f33a3(timer);
    }

    timer--;
    wait 1;
  }

  foreach(teammember in level.teamdata[team]["players"]) {
    teammember function_74cdb6b6565f33a3(0);
  }
}

function function_8f6b4a55252d124c(player) {
  var_394aebba88e4e8c2 = self;
  player notify("end_heli_exit_listener");
  player endon("end_heli_exit_listener");

  while(true) {
    msg = function_7b9e0e7ca4b3b940(player, "abort_exfil_music", player, "exited_chopper", var_394aebba88e4e8c2, "chopperSequence_done");

    if(isstring(msg)) {
      if(msg == "abort_exfil_music") {
        break;
      }

      if(msg == "exited_chopper") {
        if(istrue(var_394aebba88e4e8c2.liftoff)) {
          break;
        }

        continue;
      }
    }
  }

  waittillframeend();

  if(!isPlayer(player) || istrue(player.extracted)) {
    return;
  }

  function_f47d0805b8290615([player], 1);
  musicstate = function_17ee301cf0b5ba85("br_secondary_exfil_aborted");
  player setplayermusicstate(musicstate);
  player.var_43fa6aa15d11c927 = undefined;
}

function function_203ccd957c2ef7e4(players, finalexfil) {
  level endon("game_ended");
  self endon("exfil_lifted_off");
  musicstate = function_17ee301cf0b5ba85("br_secondary_exfil");

  while(true) {
    active_players = scripts\mp\music_and_dialog::function_aecafe54c65c0e35(players);

    foreach(player in active_players) {
      if(isPlayer(player) && !istrue(player.var_43fa6aa15d11c927)) {
        player.var_43fa6aa15d11c927 = 1;
        player setplayermusicstate(musicstate);
        thread function_8f6b4a55252d124c(player);
      }
    }

    inactive_players = array_difference(players, active_players);

    foreach(player in inactive_players) {
      if(isPlayer(player) && istrue(player.var_43fa6aa15d11c927)) {
        player notify("abort_exfil_music");
      }
    }

    wait 1;
  }
}

function function_118dc20289bc94a0(playersinside, finalexfil) {
  player = self;
  teamdata = getteamdata(player.team);
  assert(isDefined(teamdata.var_394aebba88e4e8c2));
  var_394aebba88e4e8c2 = teamdata.var_394aebba88e4e8c2;
  var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent setscriptablepartstate("br_sv_exfil_icon", "hidden_icon");
  var_394aebba88e4e8c2.liftoff = 1;
  var_394aebba88e4e8c2 notify("exfil_lifted_off");
  players_outside = array_difference(level.teamdata[player.team]["players"], playersinside);

  foreach(outside_player in players_outside) {
    outside_player notify("abort_exfil_music");
  }
}

function function_2bf05f985938205e(players, fadetime) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player setsoundsubmix("solo_cin_igc_music", fadetime);
    player.var_30dc7dfd9be2a276 = 1;
  }
}

function function_f47d0805b8290615(players, fadetime) {
  foreach(player in players) {
    player clearsoundsubmix("solo_cin_igc_music", fadetime);
    player.var_30dc7dfd9be2a276 = undefined;
  }
}

function function_d15cbb4f920e92fd(players, info) {
  assert(isDefined(info.var_394aebba88e4e8c2));
  var_394aebba88e4e8c2 = info.var_394aebba88e4e8c2;
  trigger = var_394aebba88e4e8c2.trigger;
  team_count = 0;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player notify("end_heli_exit_listener");

    if(player.team == var_394aebba88e4e8c2.team) {
      team_count++;
    }
  }

  has_weapon_case = 0;
  endingid = level.secondaryvictory.var_ddb244800e3f1329;
  function_1324ed2d881d301f();
  namespace_a8b2b88699fc40fb::function_25a4b6a2083e2ab(players);
  scripts\mp\gametypes\br::function_50e7496b6d13c173(players);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player.extracted = 1;

    if(namespace_a8b2b88699fc40fb::didextractwithweaponcase(player)) {
      has_weapon_case = 1;
    }

    player thread function_1e1dd16af9297efd(player.origin, player.angles, -1, endingid, var_394aebba88e4e8c2);
  }

  relevantplayers = array_combine_unique(players, level.teamdata[var_394aebba88e4e8c2.team]["players"]);

  foreach(player in relevantplayers) {
    player scripts\cp_mp\challenges::function_565d6af7da923110(istrue(player.extracted));
  }

  fullyextracted = function_751af1123571e361(self.team);
  function_b1c6ce7b2edc4ec2(trigger.origin, var_394aebba88e4e8c2.team, team_count, fullyextracted, players.size, has_weapon_case, endingid);
}

function private function_1e1dd16af9297efd(extractpos, var_831b4ced8bc8fbee, var_532ecf4a03864da7, endingid, var_394aebba88e4e8c2) {
  if(!isDefined(self)) {
    return;
  }

  iprintln("<dev string:x2a4>" + self.name);

  self.extracted = 1;
  level endon("game_ended");
  self endon("disconnect");
  scripts\common\callbacks::callback("br_player_successful_exfil", var_394aebba88e4e8c2.trigger);
  scripts\cp_mp\challenges::function_b7793133df5fb0df(#"hash_4a7f024e87253788", #"hash_cbddf4cbba197f26");

  if(istrue(level.secondaryvictory.var_ca6df075cc967173[self.team])) {
    self setclientomnvar("ui_br_sv_extract_successful", 2);
  } else {
    fullyextracted = function_751af1123571e361(self.team);

    if(fullyextracted) {
      level.secondaryvictory.var_ca6df075cc967173[self.team] = 1;
      self setclientomnvar("ui_br_sv_extract_successful", 2);
    } else {
      self setclientomnvar("ui_br_sv_extract_successful", 1);
    }
  }

  self allowmovement(0);
  self allowfire(0);
  self freezecontrols(1);
  self disableweapons();
  scripts\mp\gametypes\br_pickups::function_4d16b9c52efa3b8();
  self notify("successful_exfil");
  musicstate = function_17ee301cf0b5ba85("br_secondary_exfil_success");
  self setplayermusicstate(musicstate);
  function_2bf05f985938205e([self], 2);
  function_f3830638ad346e8e(level.secondaryvictory.scriptbundle.var_b0c0afb388cd54e2);
  scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/SECONDARY_VICTORY");
  thread handleplayerexfildone(endingid, var_394aebba88e4e8c2);
}

function private handleplayerexfildone(endingid, var_394aebba88e4e8c2) {
  player = self;
  assert(istrue(player.extracted));
  namespace_a8b2b88699fc40fb::function_5704ab2a9381630f(player);
  player scripts\mp\utility\stats::incpersstat("secondaryVictories", 1);
  holding_weapon_case = namespace_a8b2b88699fc40fb::didextractwithweaponcase(player);

  if(holding_weapon_case) {
    player scripts\mp\utility\stats::incpersstat("weaponCaseExfils", 1);
    scripts\cp_mp\challenges::function_8359cadd253f9604(player, "weapons_case_secondary_exfil", 1);
  }

  if(isDefined(var_394aebba88e4e8c2)) {
    player function_f35d9659b8af4887(var_394aebba88e4e8c2.team, holding_weapon_case, endingid, var_394aebba88e4e8c2.trigger.origin);
  }

  player function_10da62a5050109ed(endingid);
  player setclientomnvar("ui_br_squad_eliminated_active", 1);
  player setclientomnvar("ui_round_end_title", game["round_end"]["secondary_victory"]);
  player setclientomnvar("ui_round_end_reason", game["end_reason"]["covert_exfil"]);
  player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);

  if(getdvarint(@ "hash_14f8aed437e5e3b1", 0) == 1) {
    player kill();
    return;
  }

  player.fauxdead = 1;
  player.plotarmor = 1;
  scripts\mp\gametypes\br_spectate::migratespectators(player, undefined, 0);
  wait 1;

  if(!isDefined(player)) {
    return;
  }

  player.skipplaybodycountsound = 1;
  player scripts\common\damage_effects::onexitdeathsdoor(0);
  scripts\mp\gametypes\br_utility::markplayeraseliminated(player, "svExfil");
  player scripts\mp\playerlogic::removefromalivecount(0, "svExfil");
  scripts\mp\utility\teams::validatealivecount("extract", player.team, player);
  level thread scripts\mp\gametypes\br::updateplayerandteamcountui();
  player thread scripts\mp\gametypes\br_spectate::spawnspectator();
  wait 13;

  if(!isDefined(player)) {
    return;
  }

  function_f47d0805b8290615([player], 3);
  player.var_43fa6aa15d11c927 = undefined;
  player.plotarmor = undefined;
}

function function_7b51c79840a37c3a(team) {
  self endon("disable");
  self setscriptablepartstate("dmz_exfil_smoke", "smoking", 1);
  var_394aebba88e4e8c2 = self.var_394aebba88e4e8c2;
  var_394aebba88e4e8c2 notify("chopperSequence_done");
}

function cleanup() {
  var_394aebba88e4e8c2 = self;

  if(isDefined(var_394aebba88e4e8c2.var_3064fa24dbbd5bbf)) {
    if(isDefined(var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent)) {
      var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent.var_394aebba88e4e8c2 = undefined;
      var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent delete();
      var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.ent = undefined;
    }

    var_394aebba88e4e8c2.var_3064fa24dbbd5bbf.var_394aebba88e4e8c2 = undefined;
    var_394aebba88e4e8c2.var_3064fa24dbbd5bbf = undefined;
  }

  var_394aebba88e4e8c2.trigger.inuse = 0;
  var_394aebba88e4e8c2 destroyhudelements();
}