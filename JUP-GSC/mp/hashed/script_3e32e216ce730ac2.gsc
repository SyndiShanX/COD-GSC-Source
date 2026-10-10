/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e32e216ce730ac2.gsc
*************************************************/

#using script_1174abedbefe9ada;
#using script_2f2628d802eb2807;
#using script_440a6f7f2d90cc3c;
#using script_64acb6ce534155b7;
#using script_772861646614d63a;
#using script_a62705cb078ec0a;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_351a0d9dc2222c9;

function function_80d68c9701e1aea5(data) {
  potentialstarts = array_randomize(getStructArray("dmz_boatdrive_start", "script_noteworthy"));
  potentialends = array_randomize(getStructArray("dmz_boatdrive_end", "script_noteworthy"));
  level.var_41880bc6655538ca = [];

  foreach(node in potentialends) {
    if(!namespace_7789f919216d38a2::function_cdcab1374db7f007(node.origin)) {
      level.var_41880bc6655538ca[level.var_41880bc6655538ca.size] = node;
    }
  }

  level.boatdrivestarts = [];

  foreach(start in potentialstarts) {
    foreach(end in level.var_41880bc6655538ca) {
      if(istrue(end.inuse)) {
        continue;
      }

      dist = distance2d(start.origin, end.origin);

      if(dist > 25000 && dist < 40000) {
        start.end = end;
        end.start = start;
        end.inuse = 1;
        level.boatdrivestarts[level.boatdrivestarts.size] = start;
      }
    }
  }

  function_7828c1afe3365dd2();
  namespace_b1af0fcaf4ad16d6::function_3e3a73f1039ca16d();

  thread function_2c009c8118040c5f();

  function_b713f2d39b34540f(data, &function_8811f695b5e87b84, level.boatdrivestarts);
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x33>");
}

function function_8811f695b5e87b84(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_dc2f3d89d774dc4d;
  task.funcs["onPlayerJoined"] = &function_e930f02bb2ceb38f;
  task.funcs["onPlayerRemoved"] = &function_f5cc4925e5b36ea6;
  task.funcs["onTeamAssigned"] = &function_88cc122b335d9302;
  task.funcs["onForceEnd"] = &function_8a340139361c0e9b;
  task.funcs["onTeamStart"] = &function_22e0898b918c342;
  task.funcs["onCancel"] = &function_fd0a97f1103dcbd5;
  task.ref = "dmz_boatdrive_explore";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  task.end = node.end;

  if(!isDefined(level.var_9fb539420ed34f34)) {
    level.var_9fb539420ed34f34 = 0;
  }

  task.assignmentname = "boatDriveMission" + level.var_9fb539420ed34f34;
  level.var_9fb539420ed34f34++;
  task.numagents = 0;
  return task;
}

function function_dc2f3d89d774dc4d() {
  if(!isDefined(self.node)) {
    return;
  }

  scripts\mp\gametypes\dmz_task_utils::function_c847bfd52c064289(self.node.origin + (0, 0, 60));

  if(!isDefined(self.end) || !scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1("veh9_patrol_boat")) {
    task_ended();
    return;
  }

  self.activity.origin = self.node.origin;
  function_93add0b65db9f722(&function_6259c52471af01f2);
  var_37f4f6505381d02a = 1;

  if(istrue(var_37f4f6505381d02a)) {
    self.helidata = namespace_d38b9642992c29b5::function_e09936350b8d90fe();
    return;
  }

  self.helidata = namespace_2b263a10299a0a3a::function_e09936350b8d90fe();
}

function function_88cc122b335d9302(teamname) {
  players = getteamdata(teamname, "players");
  function_1759acfd39bb5edf("dmz_boatdrive_accept", teamname);
  thread function_7a036ed55902a5a1();

  if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_assigned_generic", teamname, 2);
  } else {
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_assigned", teamname, 2);
  }

  function_c1fd3441ccfba6f8(teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

function function_22e0898b918c342(teamname) {
  if(isDefined(self.boat)) {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_approach", teamname);
  } else {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_approach_dropped", teamname);
  }

  function_c1fd3441ccfba6f8(teamname, undefined, 0);
}

function function_e930f02bb2ceb38f(player) {}

function function_f5cc4925e5b36ea6(player) {}

function function_8a340139361c0e9b() {
  function_a9305bd4dc095942();
}

function function_fd0a97f1103dcbd5(teamname) {
  function_2d69bd312de68c60();
}

function private function_a9305bd4dc095942() {
  function_66a6064fad612bf3(&function_6259c52471af01f2);
  scripts\mp\gametypes\dmz_task_utils::function_629ed367d1393020();

  if(isDefined(self.c4heli)) {
    self.c4heli thread[[self.helidata.flyaway]]();
  }

  if(isDefined(self.extractheli)) {
    self.extractheli.readytoleave = 1;
  }
}

function private function_2d69bd312de68c60(teamname) {
  self endon("task_ended");
  function_a9305bd4dc095942();

  if(isDefined(teamname)) {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_heli_extracted", teamname);
    function_c1fd3441ccfba6f8(teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    wait 5;
    function_a1738a95d7aa8094("dmz_boatdrive_complete", "vehicledrive", self.activity.cashreward, teamname);
    function_cd4f277cf0d6a560(teamname);
  }

  task_ended(teamname);
}

function function_7a036ed55902a5a1() {
  self endon("task_ended");
  level endon("game_ended");
  ownerplayer = undefined;
  players = getteamdata(self.teams[0], "players");

  if(!isDefined(players)) {
    function_2d69bd312de68c60();
    return;
  }

  for(i = 0; i < players.size && !isDefined(ownerplayer); i++) {
    ownerplayer = players[i];
  }

  if(!isDefined(ownerplayer)) {
    function_2d69bd312de68c60();
    return;
  }

  self.boat = function_dca84f44880b74d(self.node.origin, self.node.angles, ownerplayer);
  self.vehicle = self.boat;

  if(!istrue(self.boat.deployed)) {
    self.boat waittill("deployed");
  }

  thread function_c23d51aba69e0718();
  thread function_acb7e3e09af20b16();
  function_b3c1ba9fbd1dd01e(self.boat, 50);
  function_5314298e777e5688("dmz_boatdrive_wait");

  for(driver = undefined; !isDefined(driver); driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.boat, 1)) {
    wait 0.1;
  }

  areaorigin = self.boat.origin;
  self.boat function_481c2a63f2ba3332(0);
  function_5314298e777e5688("dmz_boatdrive");
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_entered", self.teams[0], 3);
  self thread[[self.helidata.var_e0fd93cddc4b8912]]();
  function_cef2ed613a8338be(self.end.origin + (0, 0, 50));
  self.boat.var_a21a9516d1dede9e = driver.team;
  self.boat makeentitysentient(self.boat.var_a21a9516d1dede9e);
  self.boat makeentitynomeleetarget();

  while(isDefined(self.boat) && distance2dsquared(self.boat.origin, areaorigin) < 9000000) {
    wait 0.1;
  }

  self.c4heli = self[[self.helidata.spawnheli]](self.boat);
  thread function_29578edc44176c7d(self.teams[0]);
  wait 5;
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("vehicledrive_enemyheliinbound", self.teams[0]);
  function_c1fd3441ccfba6f8(self.teams[0], "dmz_boss_chopper_combat", 1.5);
}

function function_9e0eab9a6a39506(owner, pos, angles) {
  data = spawnStruct();
  data.origin = pos;
  data.angles = angles;
  data.team = owner.team;
  data.disableusabilityatspawn = 1;
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_blima", data);
  heli.animname = "blima";
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  heli.callingteam = owner.team;
  return heli;
}

function private function_6aa807e90ef0afad() {
  var_53456645791df147 = getStructArray("vehicledrive_guard", "targetname");
  initiallocations = get_array_of_closest(self.node.origin, var_53456645791df147, undefined, undefined, 2000);
  agents = [];

  for(i = 0; i < initiallocations.size; i++) {
    angles = initiallocations[i].angles;
    origin = initiallocations[i].origin;
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("ar");
    agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, origin, angles, "high", "mission", "vehicleDriveGuards", undefined, undefined, undefined, self.node.poi);

    if(isDefined(agent)) {
      agents[i] = agent;
      thread scripts\mp\ai_behavior::function_b11c1964f528574b(agent);
    }
  }

  self.numagents += agents.size;
}

function private function_6259c52471af01f2(agent, killer) {
  assignment = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "assignment");

  if(isDefined(assignment) && assignment == self.assignmentname) {
    self.numagents--;
  }
}

function private function_29578edc44176c7d(teamname) {
  self.boat endon("death");
  self endon("task_ended");
  var_23cd6d769cd06450 = 0;
  sqdist = squared(int(100));
  heliflyaway = 0;

  while(true) {
    wait 0.1;

    if(!isDefined(self.boat) || !isDefined(self.boat.payload)) {
      if(isDefined(self.extractheli)) {
        self.extractheli.readytoleave = 1;
        self.extractheli notify("ready_to_leave");
      }

      if(isDefined(self.c4heli)) {
        self.c4heli thread[[self.helidata.flyaway]]();
        heliflyaway = 1;
      }

      return;
    }

    curdist = distancesquared(self.boat.payload.origin, self.end.origin);

    if(curdist <= sqdist) {
      break;
    }

    if(isDefined(self.c4heli) && !heliflyaway && distancesquared(self.boat.origin, self.end.origin) <= 20250000) {
      self.c4heli thread[[self.helidata.flyaway]]();
      heliflyaway = 1;
    }

    if(!var_23cd6d769cd06450 && curdist <= 256000000) {
      players = getteamdata(self.boat.var_a21a9516d1dede9e, "players");

      if(isDefined(players) && players.size) {
        self.extractheli = players[0] namespace_b1af0fcaf4ad16d6::function_5a081e065a93bd08(self.end.origin, (0, 0, 60));
      }

      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_heli_exfil", self.boat.var_a21a9516d1dede9e);
      var_23cd6d769cd06450 = 1;
    }
  }

  self.boat.payload notsolid();
  waitframe();
  self.boat.payload unlink();
  self.boat.payload linkTo(self.extractheli.crate, "tag_origin", (0, 0, -110), (0, 0, 0));
  self notify("payload_delivered");
  self.extractheli.readytoleave = 1;
  self.extractheli notify("ready_to_leave");
  backturret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self.boat, "iw9_mg_patrol_boat_back_mp");
  backturret.exit = backturret.prevexit;
  self.extractheli.crate playsoundonmovingent("mp_dmz_cargo_delivery_hook");
  thread function_2d69bd312de68c60(self.teams[0]);
}

function function_c23d51aba69e0718() {
  level endon("game_ended");
  self endon("payload_delivered");
  self endon("task_ended");
  self.boat endon("death");

  while(true) {
    if(isDefined(self.boat) && isDefined(self.boat.occupants)) {
      driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.boat, 1);

      if(isDefined(driver) && isDefined(driver.team) && driver.team != self.teams[0]) {
        function_a1738a95d7aa8094("dmz_boatdrive_fail_stolen", "vehicledrive", 0, self.teams[0]);
        thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_boat_stolen", self.teams[0], 2);
        function_c1fd3441ccfba6f8(self.teams[0], "dmz_activity_lose", 1, "dmz_activity_lose_classic");
        function_2d69bd312de68c60();
        return;
      }
    }

    wait 1;
  }
}

function private function_acb7e3e09af20b16() {
  level endon("game_ended");
  self endon("payload_delivered");
  self endon("task_ended");
  self.boat waittill("death");
  function_a1738a95d7aa8094("dmz_boatdrive_fail_destroyed", "vehicledrive", 0, self.teams[0]);
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("boatdrive_boat_destroyed", self.teams[0], 2);
  function_c1fd3441ccfba6f8(self.teams[0], "dmz_activity_lose", 1, "dmz_activity_lose_classic");
  function_2d69bd312de68c60();
}

#using_animtree("script_model");

function function_7828c1afe3365dd2() {
  level.scr_animtree["rope1"] = #animtree;
  level.scr_anim["rope1"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_rope1;
  level.scr_animtree["rope2"] = #animtree;
  level.scr_anim["rope2"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_rope2;
  function_1ecfc00892db5fe2();
}

#using_animtree("mp_vehicles_always_loaded");

function function_1ecfc00892db5fe2() {
  level.scr_animtree["armored_patrol_boat"] = #animtree;
  level.scr_anim["armored_patrol_boat"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_boat;
  level.scr_animtree["blima"] = #animtree;
  level.scr_anim["blima"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_heli;
}

function function_118d4d3861116a71() {
  wait 18;
  self playsoundonmovingent("iw9_drop_chute_release");
}

function function_61b857e8eaa21d3b() {
  wait 2.25;
  self playsoundonmovingent("mp_care_package_impact_water_body");
}

function sfx_boat_dropoff() {
  wait 6;
  self setscriptablepartstate("boat_dropoff_sfx", "on");
}

function function_8bed43ba9ad1726d(origin, angles) {
  boatspawndata = spawnStruct();
  boatspawndata.origin = origin;
  boatspawndata.angles = angles;
  boat = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", boatspawndata);
  boat.animname = "armored_patrol_boat";
  backturret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(boat, "iw9_mg_patrol_boat_back_mp");
  backturret.prevexit = backturret.exit;
  backturret.exit = (-100, 45, -7);
  payload = spawn("script_model", boat.origin + (0, 0, 5) + anglesToForward(boat.angles) * -90);
  payload.angles = boat.angles;
  payload setModel("cargo_pallet_02_dmz_script");
  payload linkTo(boat);
  boat.payload = payload;
  thread namespace_168c086126cfa488::function_cf8f787850f621f9(boat);
  return boat;
}

function function_dca84f44880b74d(origin, angles, player) {
  sceneorigin = origin - (-49.233, 15.251, -575.692);
  sceneangles = angles;
  forward = anglesToForward(sceneangles);
  height = 700;
  var_30f22e255c6ced30 = 0;

  while(height < 3000) {
    middle = sceneorigin + (0, 0, height);
    start = middle - forward * 3000 + (0, 0, 1) * 2000;
    end = middle + forward * 3000 + (0, 0, 1) * 2000;
    trace = scripts\engine\trace::sphere_trace(middle, start, 500);

    if(trace["hittype"] == "hittype_none") {
      trace = scripts\engine\trace::sphere_trace(middle, end, 500);

      if(trace["hittype"] == "hittype_none") {
        var_30f22e255c6ced30 = 1;
        break;
      }
    }

    height += 200;
  }

  if(!istrue(var_30f22e255c6ced30)) {
    boat = function_8bed43ba9ad1726d(origin + 3000, angles);
    boat.deployed = 1;
    boat vehicleshowonminimap(1);
    return boat;
  }

  sceneorigin += (0, 0, height);
  boat = function_8bed43ba9ad1726d(sceneorigin + rotatevector((-6491.19, 8.381, 2602.64), sceneangles), combineangles(sceneangles, (21.543, 0, 0)));
  boat vehphys_forcekeyframedmotion();
  heli = function_9e0eab9a6a39506(player, sceneorigin + rotatevector((-6226.31, 0, 3287.4), sceneangles), combineangles(sceneangles, (8.289, 0, 0)));
  heli vehphys_forcekeyframedmotion();
  heli function_247ad6a91f6a4ffe(1);
  rope1 = spawn("script_model", sceneorigin + rotatevector((-6233.72, -23.428, 3195.29), sceneangles));
  rope1.angles = combineangles(sceneangles, (7.507, -0.229, -1.363));
  rope1 setModel("veh9_mil_air_heli_airdrop_rig");
  rope1.animname = "rope1";
  rope1 scripts\common\anim::setanimtree();
  rope1 show();
  rope2 = spawn("script_model", sceneorigin + rotatevector((-6233.57, 22.939, 3194.19), sceneangles));
  rope2.angles = combineangles(sceneangles, (7.507, -0.229, -1.363));
  rope2 setModel("veh9_mil_air_heli_airdrop_rig");
  rope2.animname = "rope2";
  rope2 scripts\common\anim::setanimtree();
  rope2 show();
  thread function_8ed7cc8db82dd643(heli, rope1, rope2);
  thread function_4a72e137f2ab1bda(boat);
  return boat;
}

function function_8ed7cc8db82dd643(heli, rope1, rope2) {
  helinode = spawnStruct();
  helinode.origin = heli.origin;
  helinode.angles = heli.angles;
  var_d6951e00866d274 = spawnStruct();
  var_d6951e00866d274.origin = rope1.origin;
  var_d6951e00866d274.angles = rope1.angles;
  var_c92e8ed49b8990c9 = spawnStruct();
  var_c92e8ed49b8990c9.origin = rope2.origin;
  var_c92e8ed49b8990c9.angles = rope2.angles;
  var_d6951e00866d274 scripts\common\anim::anim_first_frame_solo(rope1, "armored_patrol_boat_dropoff");
  var_c92e8ed49b8990c9 scripts\common\anim::anim_first_frame_solo(rope2, "armored_patrol_boat_dropoff");
  waitframe();
  var_d6951e00866d274 thread scripts\common\anim::anim_single_solo(rope1, "armored_patrol_boat_dropoff");
  var_c92e8ed49b8990c9 thread scripts\common\anim::anim_single_solo(rope2, "armored_patrol_boat_dropoff");
  heli animScripted("notify", helinode.origin, helinode.angles, %iw9_mp_armored_patrol_boat_dropoff_heli);
  heli thread sfx_boat_dropoff();
  duration = getanimlength(level.scr_anim["blima"]["armored_patrol_boat_dropoff"]);
  wait duration;
  heli delete();
  rope1 delete();
  rope2 delete();
}

function function_4a72e137f2ab1bda(boat) {
  boatnode = spawnStruct();
  boatnode.origin = boat.origin;
  boatnode.angles = boat.angles;
  boatnode scripts\common\anim::anim_first_frame_solo(boat, "armored_patrol_boat_dropoff");
  waitframe();
  boatnode thread scripts\common\anim::anim_single_solo(boat, "armored_patrol_boat_dropoff");
  boat thread function_118d4d3861116a71();
  waittime = 18.0333;
  wait waittime;
  boat stopanimScripted();
  boat vehphys_setdefaultmotion();
  boat vehicleshowonminimap(1);
  boat.deployed = 1;
  boat notify("deployed");
  boat thread function_61b857e8eaa21d3b();
}

function function_2c009c8118040c5f() {
  heli = undefined;
  boat = undefined;
  rope1 = undefined;
  rope2 = undefined;

  while(true) {
    if(getdvarint(@ "hash_fb8ea82d10086841", 0)) {
      setDvar(@ "hash_fb8ea82d10086841", 0);
      forward = anglesToForward(level.players[0] getplayerangles(0));
      right = anglestoright(level.players[0].angles);
      start = level.players[0] getEye();
      trace = ray_trace(start, start + forward * 1000);
      sphere(trace["<dev string:x48>"], 10, (1, 0, 0), 0, 1000000);
      function_dca84f44880b74d(trace["<dev string:x48>"], level.players[0].angles, level.players[0]);
    }

    if(getdvarint(@ "hash_ea9b91e4e6ffdfe0", 0)) {
      setDvar(@ "hash_ea9b91e4e6ffdfe0", 0);
      origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 500 + (0, 0, 200);
      angles = level.players[0].angles;
      function_8bed43ba9ad1726d(origin, angles);
    }

    wait 1;
  }
}

# /