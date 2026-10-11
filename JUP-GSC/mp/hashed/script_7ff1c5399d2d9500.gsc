/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7ff1c5399d2d9500.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_2d400da2610fe542;
#using script_2ff6eb4f5b8663fb;
#using script_443d99fe707f1d9f;
#using script_4f7c27d4fef4bc09;
#using script_6df6604a74a7a9c7;
#using script_7534b1d3ac3ea47a;
#using script_7cfaa6fd841fb4dd;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\hud_util;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_945da193e84ea7bb;

function init() {
  wait 5;
  level.vault_manager = spawnStruct();
  level._effect["vfx_zb_sos_body_exp_f"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_laser_ch.vfx");
  level._effect["vfx_zai_blood_annihilate_exp"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_blood_annihilate_exp.vfx");
  level._effect["vfx_megabomb_raz_dest_weak_point_exp_blood_ch_1"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_raz_dest_weak_point_exp_blood_ch_1.vfx");
  level.vault_manager function_d248cfa981edc561();
  level.vault_manager thread function_a35cf12bd47f74d0();
  level.vault_manager thread function_f5041efcb5c830e0();
  level.vault_manager thread function_50eaf1d6526a26c3();
  level.vault_manager thread function_ed2e505118e05ca4();
  level.vault_manager.playerparticipants = [];
}

function function_d248cfa981edc561() {
  self.panic_room_center = getStruct("vault_panic_room_center", "targetname");

  if(!isDefined(self.panic_room_center)) {
    println("<dev string:x1c>");
    return;
  }

  self.var_5277d508414310ec = 0;
  self.unlock_terminal = getentitylessscriptablearray("ob_ivory_terminal", "targetname")[0];
  self.var_78d32439fe570df0 = getentitylessscriptablearray("ob_ivory_game", "script_noteworthy");
  self.vault_lights = getentitylessscriptablearray("ob_ivory_light", "script_noteworthy");
  self.vault_blockers = getentitylessscriptablearray("ob_ivory_blocker", "targetname");

  foreach(scriptable in self.var_78d32439fe570df0) {
    scriptable setscriptablepartstate("model", "visible");
  }

  foreach(blocker in self.vault_blockers) {
    blocker setscriptablepartstate("state", "visible");
  }

  foreach(light in self.vault_lights) {
    light setscriptablepartstate("model", "visible");
  }

  if(isDefined(self.unlock_terminal)) {
    self.unlock_terminal setscriptablepartstate("model", "visible");
  }

  var_fdac662e687fe18d = self.panic_room_center function_954eb52ab4cdeb46("s_vault_door", "targetname");
  var_aee2168ef9296c2b = self.panic_room_center function_954eb52ab4cdeb46("s_vault_cache", "targetname");
  self.vault_doors = [];
  var_aee2168ef9296c2b = array_randomize(var_aee2168ef9296c2b);

  foreach(s_door in var_fdac662e687fe18d) {
    self.vault_doors = namespace_f6368c72597c6d90::function_ad1b6accbaab404e(s_door, self.vault_doors, "vault", 1);
  }

  for(i = 0; i < var_aee2168ef9296c2b.size; i++) {
    cache_struct = var_aee2168ef9296c2b[i];

    if(i == 0) {
      thread function_e1544d723150bc92(cache_struct, 3);
      continue;
    }

    if(i == 1) {
      thread function_e1544d723150bc92(cache_struct, 1);
      continue;
    }

    thread function_e1544d723150bc92(cache_struct, 2);
  }

  foreach(door in self.vault_doors) {
    if(istrue(door.doubledoor)) {
      door scriptabledoorfreeze(1);
      continue;
    }

    namespace_f6368c72597c6d90::function_fbbfe6f05eda5eb1(door);
  }
}

function function_b6f48b1b3dcc129b(instance, player) {
  instance setscriptablepartstate("body", "hidden");
  var_ee29db2c510a0a0a = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_mimic_hvt");
  var_8034a1f2faf000f1 = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(var_ee29db2c510a0a0a[0], instance.origin, instance.angles, "team_two_hundred");
  var_8034a1f2faf000f1 waittill("death");
  function_d8e0882d86531309("k");
}

function function_d8e0882d86531309(piecename) {
  var_d9010fc83650b43e = getentitylessscriptablearray("ob_ivory_" + piecename, "targetname")[0];

  if(isDefined(var_d9010fc83650b43e)) {
    var_d9010fc83650b43e setscriptablepartstate("orientation", "toppled");
    playsoundatpos(var_d9010fc83650b43e.origin, "evt_ob_vault_chess_piece_falls");
  }
}

function function_a35cf12bd47f74d0() {
  loc = getStruct("vault_bishop_encounter", "targetname");

  if(!isDefined(loc)) {
    println("<dev string:x48>");
    return;
  }

  var_3cfd601891a152ff = getStructArray(loc.target, "targetname");
  function_606642b946a01237("bishop_encounter", loc.origin, 1000, 1);

  while(function_7c093aaec980131b(loc.origin) < 0.85) {
    wait 1;
  }

  foreach(smoke in var_3cfd601891a152ff) {
    smokegrenadeent = magicgrenademanual("smoke_grenade_mp", smoke.origin, (0, 0, -10), 0);
    thread play_sound_in_space("smoke_grenade_expl_trans", smokegrenadeent.origin);
  }

  requestid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_vault_bishop", loc.origin, loc.radius, 1, 1, 0);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(requestid, &function_145c21969dc1144d, self);
  function_adcc96a7d541aa36(requestid, 0);
}

function function_145c21969dc1144d(requestid, instance, agent, data) {
  if(agent.agent_type == "actor_jup_ob_enemy_specialist_bishop") {
    agent.var_7e4b076a06c6df27 = 1;
    agent.var_7aebd48da5b12133 = randomfloatrange(250, 299);
    agent.var_f714dcba7a0b7168 = randomfloatrange(200, 250);
    agent namespace_c77c96f1aa8fcce1::function_5213d881f2e26966(agent.origin, 1000);
    agent waittill("death", attacker);
    var_c9b69aecc5c631ed = attacker scripts\cp_mp\utility\squad_utility::getsquadmembers();
    self.vault_manager.playerparticipants = array_combine_unique(self.vault_manager.playerparticipants, var_c9b69aecc5c631ed);
    agent function_3ecabd59662c63e4("b");
    agent thread function_9749f093b0e831ec("ob_jup_item_weapon_pi_decho" + "_blue");
    function_c7311cb3f768f21e("bishop_encounter", 40);
  }
}

function private function_e4314d1dd59383d5() {
  self endon("death");

  while(true) {
    wait 6;
    self waittill("damage", attacker);
  }
}

function function_f5041efcb5c830e0() {
  loc = getStruct("vault_rook_encounter", "targetname");

  if(!isDefined(loc)) {
    println("<dev string:x72>");
    return;
  }

  self.var_fddd4165e203ecbf = getStruct(loc.target, "targetname");
  self.rook_trigger = getStruct("rook_trigger_location", "targetname");
  requestid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_vault_rook", loc.origin, loc.radius, 1, 1, 0);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(requestid, &function_213b8f238df26b55, self);
  function_adcc96a7d541aa36(requestid, 0);
  data = function_9a39e23c3c52c2af(requestid);

  if(!isDefined(data) || !isDefined(data.ai)) {
    println("<dev string:x9b>");
    return;
  }

  while(data.ai.size <= 0) {
    data = function_9a39e23c3c52c2af(requestid);
    waitframe();
  }

  rook = data.ai[0];
  var_f32357b4f622db32 = getStructArray("vault_rook_sentry", "targetname");

  foreach(struct in var_f32357b4f622db32) {
    namespace_64135de19550f047::function_586d4d82f07e0d09(struct);
  }

  a_mines = getStructArray("vault_rook_mine", "targetname");

  foreach(struct in a_mines) {
    namespace_64135de19550f047::function_908ec13fb4d6cede(struct.origin, struct.targetname, rook, 100);
  }

  loc2 = getStruct("vault_rook_zombies_encounter", "targetname");
  var_a4d0ab6d312a821f = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_flood_fill_encounter:enc_vault_rook_flood_zombies", loc2.origin, loc2.radius, 1, 1, 0);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(var_a4d0ab6d312a821f, &function_b125915248d5d6f8, self);
  scripts\cp_mp\agents\ai_spawn_director::function_73147cdf5c28d10c(var_a4d0ab6d312a821f, &function_71515921947dd954, rook);
}

function function_71515921947dd954(requestid, data) {
  if(isalive(data) || isPlayer(data.target)) {
    return false;
  }

  return true;
}

function function_b125915248d5d6f8(requestid, instance, agent, data) {
  waitframe();
  agent.dontattackme = 0;
  agent.attackeraccuracy = 1000;
}

function function_213b8f238df26b55(requestid, instance, agent, data) {
  agent function_9f94dc92da1665ff(instance);
  agent.var_7e4b076a06c6df27 = 1;
  agent.ignoreme = 1;
  agent.accuracy = 1;
  agent.forcesuppressai = 1;
  agent.disablesuppressingfire = 0;
  agent function_65cdab0fc78aba8f(agent.origin, 5000);
  agent setgoalpos(agent.origin, 126);
  agent waittill("death", attacker);
  var_c9b69aecc5c631ed = attacker scripts\cp_mp\utility\squad_utility::getsquadmembers();
  self.vault_manager.playerparticipants = array_combine_unique(self.vault_manager.playerparticipants, var_c9b69aecc5c631ed);
  agent function_3ecabd59662c63e4("r");
  agent thread function_9749f093b0e831ec("ob_jup_item_weapon_sn_boscar" + "_blue");
}

function private function_9f94dc92da1665ff(manager) {
  self endon("death");
  childthread function_65fc225c8178ed55(manager);
  childthread function_88a0090ded17ffd5(manager);
  childthread function_d4ea6e47247325c7(manager);
}

function private function_88a0090ded17ffd5(manager) {
  self endon("ROOK_GOAL_UPDATE_NOTIFY");

  while(true) {
    self waittill("damage", amount, attacker);

    if(self.helmethealth <= 0 || self.armorhealth <= 20) {
      self setgoalpos(manager.var_fddd4165e203ecbf.origin, 20);

      if(getdvarint(@ "hash_4595c5559a093ea6", 0)) {
        iprintlnbold("<dev string:xc2>");
        thread function_a913a37e48f4f7ae(manager.var_fddd4165e203ecbf.origin, 20);
      }

      return;
    }
  }
}

function private function_65fc225c8178ed55(manager) {
  while(true) {
    self waittill("damage", amount, attacker);

    if(!issentient(attacker)) {
      continue;
    }

    self agentsetfavoriteenemy(attacker);
    self setagentattacker(attacker);
    self getenemyinfo(attacker);
    self forcethreatupdate();
  }
}

function private function_d4ea6e47247325c7(manager) {
  var_bdfbd0e95b4ce3f6 = spawn_trigger(manager.rook_trigger.origin, manager.rook_trigger.angles, 600, 250, 50);

  while(true) {
    var_bdfbd0e95b4ce3f6 waittill("trigger", data);

    if(isPlayer(data)) {
      self setgoalpos(manager.var_fddd4165e203ecbf.origin, 150);
      self notify("ROOK_GOAL_UPDATE_NOTIFY");

      if(getdvarint(@ "hash_4595c5559a093ea6", 0)) {
        iprintlnbold("<dev string:xdd>");
        thread function_a913a37e48f4f7ae(manager.var_fddd4165e203ecbf.origin, 150);
      }

      return;
    }
  }
}

function private spawn_trigger(location, angles, length, width, height) {
  size = (length, width, height);
  trigger_box = spawn("trigger_box", location, 0, size, size + (1, 1, 1));
  trigger_box.angles = angles;

  thread function_4ee7b39c84cb18ab(trigger_box, size);

  return trigger_box;
}

function private function_4ee7b39c84cb18ab(trigger_box, size) {
  while(isDefined(trigger_box)) {
    if(getdvarint(@ "hash_4595c5559a093ea6", 0)) {
      orientedbox(trigger_box.origin, size * 2, trigger_box.angles, (0, 0, 1), 0, 1);
    }

    waitframe();
  }
}

function function_a913a37e48f4f7ae(v_goal, n_goal_radius) {
  self endon("<dev string:xf5>");
  self notify("<dev string:xfe>");
  self endon("<dev string:xfe>");
  level endon("<dev string:x110>");

  while(true) {
    thread draw_ent_axis((1, 0, 0), 10, 30);
    sphere(v_goal, n_goal_radius, (1, 0, 0), undefined, 1);
    thread draw_line_for_time(self.origin, v_goal, 1, 0, 0, 0.1);
    wait 0.1;
  }
}

function function_50eaf1d6526a26c3() {
  var_1a65e2c434cfab4e = getStruct("s_vault_pawn_center", "targetname");

  if(!isDefined(var_1a65e2c434cfab4e)) {
    println("<dev string:x11e>");
    return;
  }

  phone_spawn = var_1a65e2c434cfab4e function_98edf48d14333f3f("s_vault_pawn_phone", "targetname");
  cache_structs = var_1a65e2c434cfab4e function_954eb52ab4cdeb46("s_vault_cache", "targetname");

  foreach(cache_struct in cache_structs) {
    thread function_e1544d723150bc92(cache_struct, 0);
  }

  phone_spawn function_3ecabd59662c63e4("p", &function_a8e25edd9bd5d91);
}

function private function_a8e25edd9bd5d91(transmission_device, player) {
  var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  level.vault_manager.playerparticipants = array_combine_unique(level.vault_manager.playerparticipants, var_c9b69aecc5c631ed);
  s_vault_pawn_encounter = getStruct("s_vault_pawn_encounter", "targetname");

  if(isDefined(s_vault_pawn_encounter)) {
    earthquake(0.25, 1.25, transmission_device.origin, s_vault_pawn_encounter.radius);
    var_a4d0ab6d312a821f = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_vault_pawn_zombies", s_vault_pawn_encounter.origin, s_vault_pawn_encounter.radius, 1, 0);
    scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(var_a4d0ab6d312a821f, &function_5a686d590d9806d3, level.vault_manager);
  }
}

function function_5a686d590d9806d3(requestid, instance, agent, data) {
  agent function_65cdab0fc78aba8f(agent.origin, 800);
}

function function_ed2e505118e05ca4() {
  vh_start = getStruct("vault_knight_h_to_e", "targetname");

  if(!isDefined(vh_start)) {
    println("<dev string:x144>");
    return;
  }

  spawndata = spawnStruct();
  spawndata.angles = (0, 90, 0);
  spawndata.team = "team_hundred_ninety";
  spawndata.initai = 1;
  spawndata.preventrespawn = 1;
  spawndata.origin = vh_start.origin;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;
  vehicleref = "veh9_techo_rebel_armor";
  encounterdata = spawnStruct();
  encounterdata.encounterbundle = "enc_vault_knight";
  vehicle = vehicle_spawn(vehicleref, spawndata);
  vehicle.isstopped = 0;
  vehicle.var_aa4804cc1bc59e93 = 1;
  vehicle setscriptablepartstate("single", "vehicle_unusable");
  vehicle scripts\common\vehicle_aianim::handle_attached_guys();
  function_1dbb97673ec1e0c7(encounterdata, spawndata.origin, vehicle);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "neutral");
  vehicle thread function_5a285e11881bf4c4();
  vehicle function_a2955e32519b544f();
  return vehicle;
}

function function_a2955e32519b544f() {
  self endon("death");
  self endon("entitydeleted");
  childthread function_b5fc6db21a3000c8();
  childthread function_9f49e74f355beae1();
  thread function_86c0d294557b3f18();
}

function private function_1dbb97673ec1e0c7(encounterdata, origin, vehicle) {
  vehicle.requestid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:" + encounterdata.encounterbundle, origin, 128, 1, 1, 0);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(vehicle.requestid, &function_bed20391ba8dcfce, vehicle);
  function_adcc96a7d541aa36(vehicle.requestid, 0);
  function_b0a68315f80cb547(vehicle.requestid, vehicle);
}

function private function_bed20391ba8dcfce(requestid, instance, agent, data) {
  if(agent.agent_type == "actor_jup_ob_enemy_specialist_knight") {
    instance.knight_ai = agent;
    agent.var_7e4b076a06c6df27 = 1;
    agent.subclass_scriptbundle.displayname = &"JUP_OB_OBJECTIVES/THE_KNIGHT";
    agent waittill("death", attacker);
    var_c9b69aecc5c631ed = attacker scripts\cp_mp\utility\squad_utility::getsquadmembers();
    self.vault_manager.playerparticipants = array_combine_unique(self.vault_manager.playerparticipants, var_c9b69aecc5c631ed);
    agent function_3ecabd59662c63e4("h");
    agent thread function_9749f093b0e831ec("ob_jup_item_weapon_lm_foxtrot" + "_blue");
  }
}

function function_b5fc6db21a3000c8() {
  while(!isDefined(self.driver) || !isDefined(self.knight_ai)) {
    waitframe();
  }

  msg = waittill_any_ents_return(self.driver, "death", self, "damage_heavy", self.knight_ai, "death");
  self notify("leavepath_unload");
  function_9ca6ea0ca85c0fbf();
}

function private function_9f49e74f355beae1() {
  if(!isDefined(self)) {
    println("<dev string:x16e>");
    return;
  }

  while(self.riders.size != 5) {
    waitframe();
  }

  self vehicle_turnengineon();
  self.var_83407d7413600f7f = 0;
  self.var_365e0ef7b20d47d8 = 0;

  while(isDefined(self) && !self.isstopped) {
    if(function_7c093aaec980131b(self.origin) > 0.5) {
      players = scripts\mp\utility\player::getplayersinradius(self.origin, 1500);

      if(players.size > 0) {
        function_a2f48e85dd453198(players);
      }

      set_vehicle_speed(40);

      if(isDefined(self.team) && self.team != "team_hundred_ninety") {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "team_hundred_ninety");
      }

      self.var_cea4023330a76a08 = 1;

      if(self.veh_speed >= 35) {
        function_e3eed47d3d829f6a();
      }
    } else {
      set_vehicle_speed(26);

      if(isDefined(self.team) && self.team != "neutral") {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
      }
    }

    wait 1;
  }
}

function private function_e3eed47d3d829f6a(var_49e1c02ad714708e) {
  if(!isDefined(var_49e1c02ad714708e)) {
    var_49e1c02ad714708e = 6;
  }

  if(isDefined(self) && !self.var_83407d7413600f7f) {
    mine = namespace_64135de19550f047::function_908ec13fb4d6cede(self.origin, undefined, self.driver);
    mine setscriptablepartstate("arm", "active");
    mine thread function_bd3bafa9e60cb7c5(1, self);
    childthread function_c87978976b1e2686("mines", var_49e1c02ad714708e);
  }
}

function private set_vehicle_speed(vehicle_speed, var_3464e6452137cd18) {
  if(!isDefined(var_3464e6452137cd18)) {
    var_3464e6452137cd18 = 30;
  }

  if(!self.var_365e0ef7b20d47d8) {
    self setconfigvalue("p2p", "manualSpeed", mph_to_ips(vehicle_speed));
    self vehicle_setspeedimmediate(0, 1, 1);
    childthread function_c87978976b1e2686("speed", var_3464e6452137cd18);
  }
}

function private function_c87978976b1e2686(cooldowntype, cooldowntime) {
  if(!isDefined(cooldowntype) || !isDefined(cooldowntime)) {
    return;
  }

  switch (cooldowntype) {
    case #"hash_628ffe6f4a417560":
      self.var_365e0ef7b20d47d8 = 1;
      wait cooldowntime;
      self.var_365e0ef7b20d47d8 = 0;
      break;
    case #"hash_515260130b210bff":
      self.var_83407d7413600f7f = 1;
      wait cooldowntime;
      self.var_83407d7413600f7f = 0;
      break;
  }
}

function function_a2f48e85dd453198(players) {
  if(isDefined(self.knight_ai)) {
    closestplayer = sortbydistance(players, self.knight_ai.origin)[0];
    self.knight_ai getenemyinfo(closestplayer);
    self.knight_ai.favoriteenemy = closestplayer;
    self.knight_ai forcethreatupdate();
  }
}

function private function_bd3bafa9e60cb7c5(time, vehicle) {
  self endon("mine_destroyed");
  wait time;

  if(isDefined(self)) {
    self detonate();
  }
}

function private function_90a3bfcfefc8a07a(player) {
  to_point = player.origin - self.origin;
  forward = anglesToForward(self.angles);
  angle = scripts\engine\math::anglebetweenvectors(to_point, forward);
  return angle < 45;
}

function private function_9ca6ea0ca85c0fbf() {
  self vehphys_parkingbrake(1);
  self setconfigvalue("p2p", "manualSpeed", mph_to_ips(0));
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  self.isstopped = 1;
  self.var_aa4804cc1bc59e93 = undefined;
  waitframe();
  scripts\common\vehicle_code::_vehicle_unload("default");
  self waittill("unloaded");
  self.isunloaded = 1;

  if(self hascomponent("p2p")) {
    self removecomponent("p2p");
  }

  if(self hascomponent("path")) {
    self removecomponent("path");
  }

  if(self hascomponent("animator")) {
    self removecomponent("animator");
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
  self setscriptablepartstate("single", "vehicle_use");
  self vehicleclearanims();
  self vehphys_parkingbrake(0);
  function_38d372701ae1e2d9(self.requestid);
  thread function_598bba9d433d8d5a(self.requestid);
}

function private function_38d372701ae1e2d9(requestid) {
  data = function_9a39e23c3c52c2af(requestid);

  foreach(ai in data.ai) {
    ai function_65cdab0fc78aba8f(ai.origin, 1000);
  }
}

function private function_86c0d294557b3f18() {
  self waittill("vehicleStuckNavSpline");
  function_9ca6ea0ca85c0fbf();
}

function function_598bba9d433d8d5a(requestid) {
  level endon("game_ended");
  data = function_9a39e23c3c52c2af(requestid);
  data.isnotarget = 0;

  while(data.ai.size != 0 && isDefined(self)) {
    if(function_7c093aaec980131b(self.origin, 0) < 0.8) {
      if(!data.isnotarget) {
        foreach(ai in data.ai) {
          ai.ignoreme = 1;
        }

        data.isnotarget = 1;
      }
    } else if(data.isnotarget) {
      foreach(ai in data.ai) {
        ai.ignoreme = 0;
      }

      data.isnotarget = 0;
    }

    wait 1;
  }
}

function private function_5a285e11881bf4c4() {
  self endon("death");
  var_6b962f57738d2659 = 26;
  function_b61f675503083701();
  goalpoint = getStruct("vault_knight_h_to_e", "targetname");
  self vehicle_teleport(goalpoint.origin + (0, 0, 100), goalpoint.angles);
  speedips = mph_to_ips(var_6b962f57738d2659);
  self setconfigvalue("p2p", "manualSpeed", speedips);
  thread scripts\common\vehicle_paths::checkvehiclenavsplinestuck();

  while(isDefined(goalpoint)) {
    self setconfigvalue("p2p", "goalPoint", goalpoint.origin);
    self waittill("near_goal");
    oldgoalpoint = goalpoint;
    goalpoint = getStruct(goalpoint.target, "targetname");

    if(isDefined(level.var_984bc6feaab3cad4)) {
      duration = 5000;
      var_17129dc345d151cf = ips_to_mph(self function_3dda404001a83ee(function_906e53c2fb9d3f9c("<dev string:x190>", "<dev string:x197>")));
      goalthreshold = self function_3dda404001a83ee(function_906e53c2fb9d3f9c("<dev string:x190>", "<dev string:x1a6>"));
      sphere(goalpoint.origin, goalthreshold, (1, 1, 0), 0, duration);
      nextgoalpoint = getStruct(goalpoint.target, "<dev string:x1b7>");
      vehicleforward = anglesToForward(self.angles);
      goaldirection = goalpoint.origin - self.origin;
      var_3896fef17cab20be = vectordot(goaldirection, vehicleforward);
      color = ter_op(var_3896fef17cab20be > 0, (1, 1, 1), (1, 0, 0));
      line(self.origin, goalpoint.origin, color, 1, 0, duration);
      line(self.origin, self.origin + vehicleforward * goalthreshold, (1, 1, 0), 1, 0, duration);
    }
  }
}

function private function_b61f675503083701(addpath, var_784030f0b32d0f1d) {
  addpath = ter_op(isDefined(addpath), addpath, 0);
  var_784030f0b32d0f1d = ter_op(isDefined(var_784030f0b32d0f1d), var_784030f0b32d0f1d, 0);

  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  if(addpath) {
    if(!self hascomponent("path")) {
      self addcomponent("path");
    }
  }

  if(var_784030f0b32d0f1d) {
    if(!self hascomponent("animator")) {
      self addcomponent("animator");
    }
  }

  self setconfigvalue("p2p", "checkStuck", 0);
  self setconfigvalue("p2p", "brakeAtGoal", 1);
  self setconfigvalue("p2p", "automaticNormal", 1);
  self setconfigvalue("p2p", "brakeOnGoalGasbrake", 1);
  self setconfigvalue("p2p", "goalPoint", self.origin);
  self setconfigvalue("p2p", "goalThreshold", 200);
  self setconfigvalue("p2p", "throttleSpeedClose", 1);
  self setconfigvalue("p2p", "throttleSpeedThreshold", 1);
  self setconfigvalue("p2p", "automaticFastTopspeedFraction", 1);
  self setconfigvalue("p2p", "throttleSpeedFarBelow", 1);
  self setconfigvalue("p2p", "throttleSpeedFarAbove", 4);
  self setconfigvalue("p2p", "throttleSpeedClose", 2);
  self setconfigvalue("p2p", "gasToStopMovement", 0.9);
  self setconfigvalue("p2p", "steeringMultiplier", 2);
  self setconfigvalue("path", "radiusToStep", 300);
  self.stopping = 0;
}

function private function_a646f25304f0c578(splinepoints, speedips) {
  durations = [];
  assert(splinepoints.size <= 48);

  if(splinepoints.size >= 2) {
    for(index = 0; index < splinepoints.size - 1; index++) {
      currentpoint = splinepoints[index];
      nextpoint = splinepoints[index + 1];
      durations[durations.size] = function_215e10bf17f98702(currentpoint, nextpoint, speedips);
    }

    durations[durations.size] = durations[durations.size - 1];
  }

  return durations;
}

function private function_215e10bf17f98702(startpos, endpos, speed) {
  segmentlength = distance(startpos, endpos);
  moverate = segmentlength / speed;

  if(moverate < 0.05) {
    moverate = 0.05;
  }

  return moverate;
}

function function_6ce516b4bbba4cae() {
  loc = getStruct("vault_king_encounter", "targetname");
  requestid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_vault_king", loc.origin, 90, 1, 1, 0);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(requestid, &function_8e73dcfacecaa96b, self);
}

function private function_8e73dcfacecaa96b(requestid, instance, agent, data) {
  agent.nocorpse = 1;
  agent waittill("death");
  e_vfx = spawn_tag_origin(agent.origin + (0, 0, 25), agent.angles);
  thread play_sound_in_space("gib_fullbody", agent.origin);
  playFXOnTag(getfx("vfx_zb_sos_body_exp_f"), e_vfx, "tag_origin");
  playFXOnTag(getfx("vfx_zai_blood_annihilate_exp"), e_vfx, "tag_origin");
  wait 0.3;
  playFX(getfx("vfx_megabomb_raz_dest_weak_point_exp_blood_ch_1"), getgroundposition(agent.origin, 1));
  var_8034a1f2faf000f1 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_mimic", agent.origin, agent.angles, "team_two_hundred");
}

function function_3ecabd59662c63e4(var_b4eb12f662dd36a6, on_use_function) {
  if(var_b4eb12f662dd36a6 == "p") {
    transmission_device = spawnscriptable("ob_vault_transmission_device", self.origin, self.angles);
  } else {
    playsoundatpos(self.origin, "evt_ob_vault_chess_enemy_killed_stinger");
    transmission_device = spawnscriptable("ob_vault_transmission_device", self.origin + (20, 20, 25), (270, 180, 180));
    level.vault_manager thread function_8884edbcdf7fafcf(transmission_device, 120);
  }

  transmission_device setscriptablepartstate("model", "dropped");
  transmission_device setscriptablepartstate("interact", "usable");
  namespace_29b5250e9959ea::function_3cec1b2981075936("jup_hacking_device_ob", transmission_device, &function_e6b0b57c7fd33045, undefined, &function_1dab1047cc916891, 2);
  transmission_device.var_c606b11086a2b24b = var_b4eb12f662dd36a6;
  transmission_device.vault_manager = level.vault_manager;
  transmission_device.codesent = 0;
}

function private function_1dab1047cc916891(player) {
  player endon("interaction_complete");
  self setscriptablepartstate("model", "hidden");
  player waittill("cancel");
  self setscriptablepartstate("model", "dropped");
}

function private function_e6b0b57c7fd33045(player) {
  if(self.var_c606b11086a2b24b == "p") {
    function_a8e25edd9bd5d91(self, player);
  }

  self.codesent = 1;
  self.vault_manager function_94b78afd5298be48(self.var_c606b11086a2b24b);
  self setscriptablepartstate("model", "hidden");
  self setscriptablepartstate("interact", "unusable");
  self notify("device_used");
}

function function_94b78afd5298be48(var_c606b11086a2b24b) {
  if(!isDefined(self.panic_room_center)) {
    println("<dev string:x1c>");
    return;
  }

  function_d8e0882d86531309(var_c606b11086a2b24b);
  self.var_5277d508414310ec++;
  lights = getentitylessscriptablearray("ob_ivory_light_" + self.var_5277d508414310ec, "targetname");

  foreach(light in lights) {
    light setscriptablepartstate("model", "on");
  }

  if(self.var_5277d508414310ec == 4) {
    foreach(player in level.players) {
      self.unlock_terminal disablescriptableplayeruse(player);
    }

    foreach(player in self.playerparticipants) {
      if(isPlayer(player)) {
        self.unlock_terminal enablescriptableplayeruse(player);
      }
    }

    if(isDefined(self.unlock_terminal)) {
      self.unlock_terminal setscriptablepartstate("model", "enabled");
      self.unlock_terminal scriptable_addusedcallbackbypart("model", &function_29e2ee863284984c);
      self.unlock_terminal.vault_manager = self;
    }
  }
}

function function_8884edbcdf7fafcf(var_27d6902091f45267, var_92d6f86c9665c12e) {
  var_27d6902091f45267 endon("device_used");
  wait var_92d6f86c9665c12e;

  if(!var_27d6902091f45267.codesent) {
    var_27d6902091f45267 setscriptablepartstate("model", "hidden");
    var_27d6902091f45267 setscriptablepartstate("interact", "unusable");
    function_94b78afd5298be48(var_27d6902091f45267.var_c606b11086a2b24b);
  }
}

function private function_29e2ee863284984c(instance, part, state, player, bautouse, usestring) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.inlaststand) || !isalive(player)) {
    return;
  }

  if(player isreloading() || player isgestureplaying()) {
    return;
  }

  interaction_result = namespace_29b5250e9959ea::function_aec261e207cbd04a("jup_hacking_device_ob", player, 3);

  if(istrue(interaction_result)) {
    instance setscriptablepartstate("model", "visible");

    foreach(door in instance.vault_manager.vault_doors) {
      playsoundatpos(door.origin, "evt_ob_vault_door_unlock");
      namespace_f6368c72597c6d90::function_b092780f9ec4496e(door);
      time = lookupsoundlength("evt_ob_vault_door_unlock") / 1000;
      wait time;
    }
  }
}

function private function_9749f093b0e831ec(itembundlename) {
  itembundlename = default_to(itembundlename, "ob_jup_item_weapon_pi_decho_blue");
  dropquantity = 4;
  var_2d62b5de8c483c2f = "ob_jup_items_enemy_droplist_solider";

  if(isDefined(level.var_e7e662c51dc0814a) && level.var_e7e662c51dc0814a != "") {
    var_2d62b5de8c483c2f = level.var_e7e662c51dc0814a;
  }

  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);

  if(itembundle.type == "weapon" && isDefined(itembundle.baseweapon)) {
    if(!isDefined(itembundle.spawncount)) {
      var_29bdca006c2f9d55 = function_7209c8cd4b2e3afd(weaponmaxammo(itembundle.baseweapon));
    } else {
      var_29bdca006c2f9d55 = function_7209c8cd4b2e3afd(itembundle.spawncount);
    }
  }

  spawn_pos = self.origin;
  var_d03b21428bf6d166 = spawnStruct();
  function_f632348cbb773537(level.var_230e213404e33c44, var_d03b21428bf6d166);
  namespace_b4f2af6fa775d9b::function_c069cffb4cbd1707(itembundle, spawn_pos, self.angles);
  scripts\cp_mp\loot\common_item::function_cd45408bd44fab07(var_2d62b5de8c483c2f, dropquantity, spawn_pos);
}

function private function_e1544d723150bc92(cache_struct, cache_type) {
  switch (cache_type) {
    case 0:
      cache = common_cache::cache_spawncache(#"hash_7707c98d8fb91322", cache_struct.origin, cache_struct.angles);
      break;
    case 1:
      cache = common_cache::cache_spawncache(#"hash_db9dd25fb9a30359", cache_struct.origin, cache_struct.angles);
      break;
    case 2:
      cache = common_cache::cache_spawncache(#"hash_c93e3c6a0f418c4d", cache_struct.origin, cache_struct.angles);
      break;
    case 3:
      cache = spawnscriptable("ob_loot_cache_large_zm", cache_struct.origin, cache_struct.angles);
      cache.var_55bb3585d29af1be = &function_b6f48b1b3dcc129b;
      break;
    default:
      cache = common_cache::cache_spawncache(#"hash_7707c98d8fb91322", cache_struct.origin, cache_struct.angles);
      break;
  }

  while(!isDefined(cache)) {
    waitframe();
  }

  cache_struct.cache = cache;
  cache_struct.cache setscriptablepartstate("body", "closed_usable");
}