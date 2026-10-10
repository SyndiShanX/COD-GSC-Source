/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_222f62686867436a.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_1feb0785278dafea;
#using script_220d0eb95a8fab7d;
#using script_2d05e472a90adb1d;
#using script_2d400da2610fe542;
#using script_405d05c89e998922;
#using script_41387eecc35b88bf;
#using script_485622d93fa7e4cf;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5080d40cd904ba73;
#using script_55221d469e7b320e;
#using script_60dd6e3992c1f29;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6bffae1b97f70547;
#using script_6f65366f542f6627;
#using script_749ff6f56673a813;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7cfaa6fd841fb4dd;
#using script_7d3e27aa82b5d70b;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\ob;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace namespace_89d57ff5dfa37e5c;

function quest_act3_init() {
  if(level flag("jup_quest_act3_init")) {
    return;
  }

  level flag_set("jup_quest_act3_init");

  if(getdvarint(@ "hash_f0651d120dc93cc7", 0)) {
    mapname = getmapname();

    if(mapname == "mp_jup_gw_fallout") {
      setDvar(@ "hash_f1d095735ac37f33", 0);
      setDvar(@ "hash_f1f518497502aea8", 1);
      setDvar(@ "hash_37edd5a66bd29f3d", 2);
      setDvar(@ "hash_2fe0283b419ff08a", 1);
      level.var_9979559855d31f5a = -1;
      level.n_time_remaining = 30;
      level.var_3f4534fb14cca909 = &function_151037a96443f076;
      level.quest_airstrike = 1;
      level.var_a9e2544b9283299b = 1;
      level.var_4c272da3f0a1a024 = getEntArray("clip_zombie_container_opening", "targetname");
      level.var_a9e3bda690cc504c = getEntArray("clip_zombie_container_door", "targetname");
      callback::add("player_spawned", &on_player_spawned);
      callback::add("player_connect", &on_player_connected);
      scripts\engine\scriptable::scriptable_adddamagedcallback(&namespace_134d54e39331ee45::function_61c4487eafc2bc4c);
      level.var_cced1297c1210e46 = throttle_initialize("explosive_barrel", 1, default_to(level.framedurationseconds, 0.1));
      level.airstrike_throttle = throttle_initialize("airstrike_infil", 1, default_to(level.framedurationseconds, 0.1));
      level.var_70ec6a3c1cc881e1 = throttle_initialize("fuel_airstrike", 1, default_to(level.framedurationseconds, 0.1));
      function_c25a40ae517ef340();
      level._effect["chopper_explosion"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_explo_heli_act_3.vfx");
      level._effect["enrichment_explosion"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_enrichment_device_exp.vfx");
      level thread quest_start();
      return;
    }

    callback::add("exfil_to_s0_act3", &function_2a6c134406898721);
  }
}

function quest_start() {
  level flag_set("powerup_disable_nuke");
  level function_24f7bf25b01b1d1f();
  scripts\common\create_script_utility::wait_for_cs_flag("jup_ob_quest_s0_act_3_cs");
  level function_e9aa7259fb72d085();
  level flag_wait("player_has_spawned");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  level.var_98539610199d2422 thread function_5555f62a6cc0f560();
  level.var_98539610199d2422 thread setup_ammo();
  level.var_98539610199d2422 thread function_fbfcd9d440346989();
  level.var_98539610199d2422 thread oob_triggers();

  if(getdvarint(@ "hash_feadf2b99c87b563", 0)) {
    level.var_98539610199d2422 function_1e86be4e3accaf94();
    level.var_98539610199d2422 thread teleport_players("player_deathworm_pt");
    level.var_98539610199d2422 thread function_385b258887a1f451();
    level.var_98539610199d2422 thread function_3e10b038f30507eb();
    level.var_98539610199d2422 thread function_d58e9fe01994f55();
    level.var_98539610199d2422 thread function_5cb2f7158d07480c();
    level.var_98539610199d2422 flag_set("charge_planted");
    level.var_98539610199d2422 flag_set("approach_neutralizer");
    level.var_98539610199d2422 flag_set("neutralizer_dropped");
    level.var_98539610199d2422 flag_set("neutralizer_reached");
    level.var_98539610199d2422 flag_set("infil_start");
    return;
  }

  if(getdvarint(@ "hash_2966c4d5e406fbac", 0)) {
    setmusicstate("");
    level.var_98539610199d2422 function_1e86be4e3accaf94();
    level.var_98539610199d2422 thread teleport_players("player_deathworm_pt");
    level.var_98539610199d2422 thread function_385b258887a1f451();
    level.var_98539610199d2422 thread function_3e10b038f30507eb();
    level.var_98539610199d2422 thread function_5cb2f7158d07480c();
    level.var_98539610199d2422 thread function_47e9b34b3e46619();
    level thread function_262e81479efcd17a();
    level.var_98539610199d2422 flag_set("charge_planted");
    level.var_98539610199d2422 flag_set("approach_neutralizer");
    level.var_98539610199d2422 flag_set("neutralizer_dropped");
    level.var_98539610199d2422 flag_set("neutralizer_reached");
    level.var_98539610199d2422 flag_set("ava_arrived");
    var_a6cd1b1206e83312 = getStruct("neutralizer", "targetname");
    var_4b712b6b83e1a330 = getrandomnavpoint(var_a6cd1b1206e83312.origin, 500);
    var_ba8620293ff4622d = getrandomnavpoint(var_a6cd1b1206e83312.origin, 500);
    level.a_ai_allies = [];
    var_1edd111b66027300 = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("ava_jansen")[0];
    level.ava = scripts\mp\mp_agent::spawnnewagentaitype(var_1edd111b66027300, var_4b712b6b83e1a330, var_a6cd1b1206e83312.angles, level.players[0].team);
    level.ava function_f6991c09ecd5b798();
    var_67cd14c1cc125b93 = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("sergei_ravenov")[0];
    level.ravenov = scripts\mp\mp_agent::spawnnewagentaitype(var_67cd14c1cc125b93, var_ba8620293ff4622d, var_a6cd1b1206e83312.angles, level.players[0].team);
    level.ravenov function_f6991c09ecd5b798();
    level.a_ai_allies[level.a_ai_allies.size] = level.ava;
    level.a_ai_allies[level.a_ai_allies.size] = level.ravenov;
    return;
  }

  if(getdvarint(@ "hash_22a4c737ce7f7f1e", 0)) {
    level.var_98539610199d2422 function_1e86be4e3accaf94();
    level.var_98539610199d2422 thread function_47e9b34b3e46619();
    level.var_98539610199d2422 thread function_3a8fc38da7251e76();
    level.var_98539610199d2422 thread function_de6ae73d98f28ba3();
    wait 0.1;
    level.var_98539610199d2422 notify("entrance_found");
    level.var_98539610199d2422 thread teleport_players("enrichment_pos");
    return;
  }

  if(getdvarint(@ "hash_6e43d255b2ec9206", 0)) {
    level.var_98539610199d2422 function_1e86be4e3accaf94();
    level.var_98539610199d2422 thread function_340a2b1d87903294();
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level.var_98539610199d2422.var_4118ca23a8b62b78);
    scripts\mp\objidpoolmanager::update_objective_position(level.var_98539610199d2422.var_4118ca23a8b62b78, level.var_98539610199d2422.var_11d2e045f1efdf0f.origin);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(level.var_98539610199d2422.var_4118ca23a8b62b78, 0);
    level.var_98539610199d2422 thread function_6ddbbcc69eb0e369();
    level.var_98539610199d2422 thread teleport_players("player_deathworm_pt");
    return;
  }

  level.var_98539610199d2422 thread function_74139ae6c2c53345();
  level.var_98539610199d2422 thread setup_intro();
  level.var_98539610199d2422 thread function_11547bb002dd118c();
  level.var_98539610199d2422 thread start_quest();
}

function function_e9aa7259fb72d085() {
  level.var_98539610199d2422 = spawnStruct();
  level.var_98539610199d2422.n_mercs = 0;
  level.var_98539610199d2422.n_zombies = 0;
  level.var_98539610199d2422.n_armored = 0;
  level.var_98539610199d2422.var_8947dd7e97fc5ea1 = 0;
  level.var_98539610199d2422.var_cf47493985378a8e = 0;
  level.var_98539610199d2422.difficulty = "difficulty_normal";
  level.var_98539610199d2422.var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_soldier_long", "jup_ob_enemy_basic_soldier_short"];
  level.var_98539610199d2422.s_stronghold = getStruct("stronghold_proximity", "targetname");
  level.var_98539610199d2422.s_entrance = getStruct("stronghold_entrance", "targetname");
  level.var_98539610199d2422.s_device = getStruct("enrichment_device", "targetname");
  level.var_98539610199d2422.s_interior = getStruct("stronghold_interior", "targetname");
  level.var_98539610199d2422.s_charge = getStruct("explosive_charge", "targetname");
  level.var_98539610199d2422.var_a6cd1b1206e83312 = getStruct("neutralizer", "targetname");
  level.var_98539610199d2422.s_enrichment = getStruct("s_enrichment_room", "targetname");
  level.var_98539610199d2422.var_33ff83242dcaad2b = getStruct("facility_exit", "targetname");
  level.var_98539610199d2422.s_machine = getStruct("enrichment_machine", "targetname");
  level.var_98539610199d2422.var_11d2e045f1efdf0f = getStruct("neutralizer_panel", "targetname");
  level.var_eee94908df4c2824 = 0;
}

function start_quest() {
  namespace_64135de19550f047::function_e9158c9e8c391f25("scriptable_cover");
  level thread function_3820b80f0cb764ba();
  function_1e86be4e3accaf94();
  function_3e10b338f3050e84();
  function_3e10b638f305151d();
  function_3e10b538f30512ea();
  function_3e10b038f30507eb();
}

function function_3820b80f0cb764ba() {
  flags::gameflagwait("prematch_done");
  wait 0.5;
  setmusicstate("mx_ob_q3_infil");
}

function function_3e10b338f3050e84() {
  level thread namespace_134d54e39331ee45::function_7a5ab9d5c8dbfe6a();
  thread function_60721b5cb1eee95c();
  thread setup_barrels("barrel_explosive_river");
  thread soldier_frontline();
  thread function_1c3939b802f05136();
  thread function_aa0d525c497e873c();
  thread function_a606113e8150b7e4("mus_zombiepen_open", "mx_ob_q3_action_high");
}

function function_3e10b638f305151d() {
  thread function_3a8fc38da7251e76();
  thread function_3f90c8202c9d37cb();
  thread function_de6ae73d98f28ba3();
  thread merc_stronghold();
  thread function_47e9b34b3e46619();
  thread ambient_battles();
  flag_wait("charge_planted");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("place_explosive_zakhaev");
  }
}

function function_3e10b538f30512ea() {
  thread function_5cb2f7158d07480c();
  thread approach_neutralizer();
  thread merc_facility_exit();
  thread function_c40217c3d33491b2();
  thread function_de7c83bd54fe6c54();
  thread function_385b258887a1f451();
  thread merc_chopper_neutralizer();
  thread function_fc5245e119c3f4e5();
  thread function_d58e9fe01994f55();
  level thread function_262e81479efcd17a();
}

function function_3e10b038f30507eb() {
  thread function_1a18a6d6a5cee94d();
  thread function_44e1fb35d5a39cc1();
}

function on_player_connected(params) {
  self endon("disconnect");

  if(getdvarint(@ "hash_f0651d120dc93cc7", 0) && !ob_exfil::function_7bfb1ccacdacfd26()) {
    self setsoundsubmix("jup_ob_q3_infil");
    scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 1, 0);
  }
}

function on_player_spawned(params) {
  level flag_set("player_has_spawned");

  if(getdvarint(@ "hash_f0651d120dc93cc7", 0) && getdvarint(@ "hash_c221795287935921", 0)) {
    thread function_ce34466b3cece887();
  }

  if(getdvarint(@ "hash_2966c4d5e406fbac", 0) || getdvarint(@ "hash_22a4c737ce7f7f1e", 0) || getdvarint(@ "hash_feadf2b99c87b563", 0) || getdvarint(@ "hash_6e43d255b2ec9206", 0)) {
    level flag_set("player_has_spawned");
    scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 1);
    return;
  }

  level.var_9979559855d31f5a++;

  if(!level flag("chopper_end")) {
    self.n_pos = level.var_9979559855d31f5a + 1;
    level flag_wait("chopper_ready");
    thread function_1e66bb8b54246d6b();

    if(level flag("countdown") && !isDefined(self.var_73f4fb8b53668a5c) && level.n_time_remaining > 1) {
      self.var_73f4fb8b53668a5c = 1;
      thread function_69c1532c14dde0f1(level.var_98539610199d2422.infil_chopper, level.var_98539610199d2422);
    }
  }

  flag_set("player_ready");
}

function function_1e66bb8b54246d6b() {
  self endon("death");
  player_freeze(1);
  self.var_cac91eb6521df629 = level.var_98539610199d2422.infil_chopper;
  self.ignoreme = 1;
  v_pos = namespace_134d54e39331ee45::function_44dc89f43f1c1e1c(self.n_pos, level.var_98539610199d2422.infil_chopper);
  self setOrigin(v_pos);
  self setplayerangles(level.var_98539610199d2422.infil_chopper.angles * -1);
  waitframe();
  self playerlinkTo(level.var_98539610199d2422.infil_chopper);
  self playerlinkedoffsetenable();

  if(!isDefined(level.player_boarded)) {
    level.player_boarded = 1;
    level thread function_392d108673953c27();
  }

  level.var_98539610199d2422 flag_wait("infil_start");
  scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 1);
  self unlink();
  wait 2;
  player_freeze(0);

  if(!level.var_98539610199d2422.infil_chopper function_c80b9a252474413b(self)) {
    function_ac62c6628f23f82d();
  }
}

function function_392d108673953c27() {
  wait 3;
  level flag_set("all_players_onboard");
}

function players_infil() {
  for(i = 0; i < level.players.size; i++) {
    if(isalive(level.players[i])) {
      level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.players[i], 0, 0);
      level.players[i] setplayerangles(self.infil_chopper.angles * -1);
    }
  }

  flag_wait("bridge");

  for(i = 0; i < level.players.size; i++) {
    if(isalive(level.players[i])) {
      level.players[i].ignoreme = 0;
    }
  }

  flag_wait("drop_off");
  flag_set("zombies_cleared");

  if(getdvarint(@ "hash_732447df682be5db", 0)) {
    level thread function_4c3b4b4059b45fba();
  }
}

function function_83ff2df370bc359b(s_quest) {
  self endon("death");
  s_quest endon("infil_done");
  level flag_set("countdown");
  self.mdl_clip delete();
  self.e_linkto delete();
  thread infil_timeout(s_quest);

  foreach(player in level.players) {
    player.var_73f4fb8b53668a5c = 1;
    player thread function_69c1532c14dde0f1(self, s_quest);
  }

  while(true) {
    self.var_9c80d69eb7a7d6cd = 0;

    foreach(player in level.players) {
      if(function_c80b9a252474413b(player)) {
        self.var_9c80d69eb7a7d6cd = 1;
      }
    }

    if(!self.var_9c80d69eb7a7d6cd) {
      break;
    }

    wait 0.1;
  }

  wait 2;

  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_q3_infil");
    player setclientomnvar("ui_match_start_countdown", -1);
  }

  s_quest flag_set("players_disembarked");
  s_quest notify("infil_done");

  if(getdvarint(@ "hash_732447df682be5db", 0)) {
    level thread function_4c3b4b4059b45fba();
  }
}

function function_69c1532c14dde0f1(vh_chopper, s_quest) {
  self endon("death");
  s_quest endon("infil_done");
  s_quest endon("players_disembarked");

  while(true) {
    self setclientomnvar("ui_match_start_countdown", level.n_time_remaining);

    if(!vh_chopper function_c80b9a252474413b(self)) {
      self setclientomnvar("ui_match_start_countdown", -1);
      break;
    }

    wait 1;
    level.n_time_remaining--;

    if(level.n_time_remaining < 1) {
      break;
    }
  }
}

function infil_timeout(s_quest) {
  self endon("death");
  s_quest endon("infil_done");
  wait 30;

  foreach(player in level.players) {
    player setclientomnvar("ui_match_start_countdown", -1);
  }

  s_quest flag_set("players_disembarked");
  s_quest notify("infil_done");
}

function function_c80b9a252474413b(player) {
  if(!isDefined(self) || !isalive(self) || !isDefined(self.origin) || !isDefined(player) || !isDefined(player.origin)) {
    return 0;
  }

  return function_f69d383479425bfa(player.origin);
}

function function_f69d383479425bfa(origin) {
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  toorigin = origin - self.origin;
  transform = coordtransformtranspose(origin, self.origin, self.angles);
  forwarddist = transform[0];
  sidedist = transform[1];
  verticaldist = transform[2];
  withinforward = forwarddist > -360 && forwarddist < 350;
  withinside = sidedist > -60 && sidedist < 60;
  withinvertical = verticaldist > -255 && verticaldist < -115;
  return withinforward && withinside && withinvertical;
}

function function_ac62c6628f23f82d() {
  self endon("death");
  var_f10d2bae0aa4fce7 = getStructArray("player_pos", "targetname");
  v_spawn = undefined;
  scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 1, 0);
  player_freeze(1);

  while(true) {
    s_pt = array_random(var_f10d2bae0aa4fce7);
    v_pos = getclosestpointonnavmesh(s_pt.origin);

    if(isDefined(v_pos) && !positionwouldtelefrag(v_pos)) {
      break;
    }

    waitframe();
  }

  self setOrigin(v_pos);
  self setplayerangles(s_pt.angles);
  level flag_set("all_players_onboard");
  level.var_98539610199d2422 flag_wait("drop_off");
  scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 1);
  player_freeze(0);
}

function function_2a6c134406898721(params) {
  if(!isDefined(params.player)) {
    return;
  }

  level.var_9ec4962076db301b["s0_act3"].var_576f57af0204c38c = params.exfil_chopper;
  level flag_set("exfil_to_s0_act_3");
  level thread function_700e95e77f71e457(params);
}

function function_700e95e77f71e457(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  var_684092929dab076f = [params.player];
  var_576f57af0204c38c = level.var_9ec4962076db301b["s0_act3"].var_576f57af0204c38c;
  level thread namespace_bbc151ced3ff8d46::map_transition(var_684092929dab076f, var_576f57af0204c38c, "s0_act3");
}

function oob_triggers() {
  flag_wait("players_disembarked");
  level notify("switch_oob");
  waitframe();
  level.outofboundstriggers = getEntArray("OutOfBounds_ob_story", "targetname");
  level thread scripts\mp\outofbounds::watchoobtriggers();
}

function setup_ammo() {
  var_77ae610b84ee2e95 = getStructArray("ammo_restock", "targetname");

  foreach(s_ammo in var_77ae610b84ee2e95) {
    var_28b750103c3b51fb = spawnscriptable("military_ammo_restock_noent", s_ammo.origin, s_ammo.angles);
    var_28b750103c3b51fb setscriptablepartstate("military_ammo_restock", "useable_on");
  }
}

function function_5555f62a6cc0f560() {
  var_33d6eed4b1e47fb8 = getStructArray("buystation", "targetname");

  foreach(s_buystation in var_33d6eed4b1e47fb8) {
    var_1811ae8d6e2868d = spawnscriptable("br_plunder_box", s_buystation.origin, s_buystation.angles);
    var_1811ae8d6e2868d setscriptablepartstate("br_plunder_box", "visible");
  }
}

function function_fbfcd9d440346989() {
  var_4b5db131cccce121 = getStructArray("mimic_prop", "targetname");
  var_4b5db131cccce121 = array_randomize(var_4b5db131cccce121);

  for(i = 0; i < int(var_4b5db131cccce121.size * 0.5); i++) {
    ai_mimic = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc("jup_spawner_zombie_mimic", var_4b5db131cccce121[i].origin, var_4b5db131cccce121[i].angles, "team_two_hundred");

    if(isDefined(ai_mimic)) {
      ai_mimic namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
      namespace_6119efd5d1925c17::function_232cabbc43f9536(var_4b5db131cccce121[i].origin, ai_mimic, undefined, 1, 200);
    }
  }
}

function function_f2b4f1b990effe1(n_pos) {
  self endon("death");
  level flag_wait("raft_ready");

  if(n_pos == 0) {
    self.str_seat = "front_right";
  } else if(n_pos == 1) {
    self.str_seat = "back_left";
  } else if(n_pos == 2) {
    self.str_seat = "back_right";
  }

  if(isDefined(self.str_seat)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.vh_zodiac, self.str_seat, self, level.vehicle_data, 1);
  }

  flag_set("player_boarded");
}

function function_74139ae6c2c53345() {
  s_pos = getStruct("infil_chopper", "targetname");

  if(isDefined(s_pos)) {
    s_goal = getStruct(s_pos.target, "targetname");
  }

  spawndata = spawnStruct();
  spawndata.origin = s_pos.origin;
  spawndata.angles = s_pos.angles;
  spawndata.preventrespawn = 1;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;
  self.infil_chopper = undefined;

  while(true) {
    self.infil_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", spawndata);

    if(isDefined(self.infil_chopper)) {
      self.infil_chopper.e_linkto = getEntArray("linkto_clip_infil_chopper", "targetname")[0];
      self.infil_chopper.mdl_clip = getEntArray("clip_infil_chopper", "targetname")[0];
      self.infil_chopper.mdl_clip linkTo(self.infil_chopper.e_linkto);
      break;
    }

    waitframe();
  }

  self.infil_chopper.e_linkto rotateTo(self.infil_chopper.angles, 0.05);
  self.infil_chopper.e_linkto moveTo(self.infil_chopper.origin, 0.05);
  self.infil_chopper.e_linkto waittill("movedone");
  self.infil_chopper.e_linkto linkTo(self.infil_chopper);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(self.infil_chopper);
  self.infil_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  v_pos = self.infil_chopper gettagorigin("tag_door_rear");
  v_pos = vectorNormalize(anglesToForward(self.infil_chopper.angles)) * 100 + v_pos;
  self.infil_chopper thread function_86b4ca8e83c456e6(self, s_goal);
}

function function_86b4ca8e83c456e6(s_quest, s_goal) {
  self endon("death");
  self.team = level.players[0].team;
  namespace_9f6a961447bab709::function_a609274d97743733();
  self vehicle_setspeed(40, 20, 8);
  self setvehgoalpos(self.origin, 1);
  self waittill("goal");
  level flag_set("chopper_ready");
  level flag_wait("all_players_onboard");
  s_quest thread players_infil();
  s_quest thread infil_zombies();
  s_quest thread vo_infil();
  wait 1;

  while(true) {
    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "infil_start") {
        self vehicle_setspeed(30, 20, 8);
        self setvehgoalpos(s_goal.origin, 0);
      } else if(s_goal.script_noteworthy == "bridge") {
        self setvehgoalpos(s_goal.origin, 0);
      } else if(s_goal.script_noteworthy == "drop_off") {
        self setgoalyaw(flat_angle(s_goal.angles)[1]);
        self setvehgoalpos(s_goal.origin, 1);
      } else if(s_goal.script_noteworthy == "depart") {
        self cleargoalyaw();
        self vehicle_setspeed(60, 20, 10);
        self setvehgoalpos(s_goal.origin, 0);
      }
    } else {
      self setvehgoalpos(s_goal.origin, 0);
    }

    self waittill("goal");

    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "infil_start") {
        s_quest flag_set("infil_start");
      } else if(s_goal.script_noteworthy == "bridge") {
        s_quest flag_set("airstrike");
        s_quest flag_set("bridge");
      } else if(s_goal.script_noteworthy == "drop_off") {
        self setgoalyaw(flat_angle(s_goal.angles)[1]);
        level flag_set("chopper_end");
        thread function_83ff2df370bc359b(s_quest);
        s_quest flag_set("drop_off");
        s_quest flag_wait("players_disembarked");
      } else if(s_goal.script_noteworthy == "depart") {
        self vehicle_setspeed(75, 20, 10);
      }
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    self setvehgoalpos(self.origin, 1);

    if(isDefined(self.pilots)) {
      foreach(pilot in self.pilots) {
        pilot delete();
      }
    }

    scripts\cp_mp\vehicles\vehicle::vehicle_explode();
  }
}

function infil_zombies() {
  s_airstrike = getStruct("airstrike1", "targetname");
  var_b7a10f9d2e99d257 = getStruct("airstrike3", "targetname");
  var_b7a10e9d2e99d024 = getStruct("airstrike2", "targetname");
  self.var_3dacfe63d95c9458 = [s_airstrike, var_b7a10f9d2e99d257, var_b7a10e9d2e99d024];
  var_c6e42f4c295786d2 = getStructArray("zombie_infil", "targetname");

  foreach(s_zombie in var_c6e42f4c295786d2) {
    a_ai_zombies = function_7ea5453572655fab(s_zombie, 25, 0, 0);

    foreach(ai_zombie in a_ai_zombies) {
      ai_zombie.var_7e4b076a06c6df27 = 1;
    }
  }

  flag_wait("infil_start");
  thread airstrike_kill();
  namespace_64135de19550f047::ob_airstrike(s_airstrike.origin, "quest_airstrike", 1, 0, s_airstrike.angles[1]);
  thread airstrike();
}

function airstrike() {
  wait 4.5;
  thread airstrike_launch(getStruct("airstrike3", "targetname"));
  wait 4;
  airstrike_launch(getStruct("airstrike2", "targetname"), 1);
}

function airstrike_kill() {
  self endon("airstrike_done");
  self.var_dc3f16d6cd6a2471 = 0;

  while(true) {
    level waittill("airstrike_explode");
    wait 0.5;
    self.var_dc3f16d6cd6a2471++;

    if(self.var_dc3f16d6cd6a2471 > 2) {
      a_ai_zombies = getaiarrayinradius(self.var_3dacfe63d95c9458[self.var_dc3f16d6cd6a2471 - 1].origin, self.var_3dacfe63d95c9458[self.var_dc3f16d6cd6a2471 - 1].radius * 2);
    } else {
      a_ai_zombies = getaiarrayinradius(self.var_3dacfe63d95c9458[self.var_dc3f16d6cd6a2471 - 1].origin, self.var_3dacfe63d95c9458[self.var_dc3f16d6cd6a2471 - 1].radius);
    }

    foreach(ai_zombie in a_ai_zombies) {
      if(isalive(ai_zombie)) {
        scripts\engine\throttle::function_f632348cbb773537(level.airstrike_throttle, ai_zombie);

        if(isalive(ai_zombie)) {
          ai_zombie dodamage(ai_zombie.health, ai_zombie.origin, undefined, undefined, "MOD_EXPLOSIVE");
        }
      }
    }

    if(self.var_dc3f16d6cd6a2471 > 2) {
      self notify("airstrike_done");
    }
  }
}

function airstrike_launch(s_airstrike, b_last) {
  namespace_64135de19550f047::ob_airstrike(s_airstrike.origin, "quest_airstrike", 1, 0, s_airstrike.angles[1]);
  self waittill("airstrike_done");
  thread function_3b71972269735715();
}

function setup_infil() {
  level.var_15c7e6ec178feef1 = 1;
  wait 1.1;
  s_pos = getStruct("infil_zodiac", "targetname");
  s_pos.var_699ac4a9c9e9f0ec = 1;
  s_pos.var_24993ee24f7c7c0 = 1;
  level.vh_zodiac = vehicle::vehicle_spawn("veh9_rhib", s_pos);
  level.vh_zodiac vehicle_turnengineon();

  if(isDefined(level.vh_zodiac)) {
    level.vh_zodiac vehicle_damage::vehicle_damage_setCanDamage(0);
    level.vehicle_data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(level.vh_zodiac.vehiclename);
    wait 1;
    level flag_set("raft_ready");

    if(isDefined(level.vh_zodiac)) {
      level.vh_zodiac thread infil_failsafe();
      level.vh_zodiac function_f46a6ba1faf07ca8(s_pos);
    }

    wait 3;

    if(isDefined(level.vh_zodiac)) {
      level.vh_zodiac function_481c2a63f2ba3332(1);
      level.vh_zodiac vehicle_turnengineoff();
    }

    foreach(player in level.players) {
      player clearsoundsubmix("jup_ob_q3_infil");
    }

    waitframe();
    self notify("players_unloaded");

    if(isDefined(level.var_98539610199d2422)) {
      level.var_98539610199d2422 flag_wait("players_unloaded");
    }

    thread function_b1aa1fb6109a052b();

    if(isDefined(level.vh_zodiac)) {
      level.vh_zodiac thread vehicle_remove();
    }
  }
}

function function_f46a6ba1faf07ca8(s_pos) {
  self endon("death");
  self endon("failsafe");
  self endon("infil_done");
  function_2cc3ca6a47e4797e();
  s_goal = getStruct(s_pos.target, "targetname");
  self function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  self function_77320e794d35465a("p2p", "manualSpeed", mph_to_ips(1.5));
  self function_77320e794d35465a("p2p", "goalPoint", s_goal.origin);
  function_19574bce39210b90(s_goal);
  level thread vo_infil();

  while(true) {
    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
    }

    if(isDefined(s_goal)) {
      self function_77320e794d35465a("p2p", "goalPoint", s_goal.origin);
      function_19574bce39210b90(s_goal);

      if(isDefined(s_goal.script_noteworthy)) {
        if(s_goal.script_noteworthy == "unload") {
          self notify("infil_done");
        } else if(s_goal.script_noteworthy == "hold") {
          self function_77320e794d35465a("p2p", "manualSpeed", 0);
          self function_481c2a63f2ba3332(1);
          wait 2;
          level.var_98539610199d2422 flag_set("hold");
          wait 4.5;
          self function_481c2a63f2ba3332(0);
          self function_77320e794d35465a("p2p", "manualSpeed", mph_to_ips(2.5));
        } else if(s_goal.script_noteworthy == "approach") {
          level.var_98539610199d2422 flag_set("players_unloaded");
          scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);
          scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(self);
          thread monitor_occupants();
        }
      }
    }

    if(!isDefined(s_goal.target)) {
      break;
    }
  }
}

function vehicle_remove() {
  s_stronghold_approach = getStruct("s_stronghold_approach", "targetname");
  proximity_watcher(s_stronghold_approach);
  scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
  scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function monitor_occupants() {
  self endon("death");

  while(true) {
    wait 1;
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    if(isDefined(occupants)) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);
    }
  }
}

function function_19574bce39210b90(s_goal) {
  self endon("death");
  self endon("goal_reached");

  while(true) {
    if(distance2dsquared(self.origin, s_goal.origin) <= 40000) {
      self notify("goal_reached");
    }

    wait 0.5;
  }
}

function infil_failsafe() {
  self endon("death");
  self endon("players_unloaded");
  wait 30;
}

function function_2cc3ca6a47e4797e() {
  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  self function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  self function_77320e794d35465a("p2p", "automaticFast", 1);
  self function_77320e794d35465a("p2p", "brakeOnGoalGasbrake", 1);
  self function_77320e794d35465a("p2p", "goalPoint", self.origin);
  self function_77320e794d35465a("p2p", "goalThreshold", 500);
  self function_77320e794d35465a("p2p", "throttleSpeedClose", 1);
  self function_77320e794d35465a("p2p", "throttleSpeedThreshold", 1);
  self function_77320e794d35465a("p2p", "automaticFastTopspeedFraction", 1);
  self function_77320e794d35465a("p2p", "throttleSpeedFarBelow", 10);
  self function_77320e794d35465a("p2p", "throttleSpeedFarAbove", 1);
  self function_77320e794d35465a("p2p", "throttleSpeedClose", 1);
  self function_77320e794d35465a("p2p", "gasToStopMovement", 1);
  self function_77320e794d35465a("p2p", "steeringMultiplier", 0.5);
  self function_77320e794d35465a("p2p", "reverseGasNormal", 0.1);
  self function_77320e794d35465a("path", "radiusToStep", 300);
  self function_77320e794d35465a("path", "stepSpeedFactor", 2);
  self function_77320e794d35465a("path", "yawHelper", 0);
  self.dontunloadonend = 1;
  self.donotunloadondriverdeath = 1;
  self.dontunloadondeath = 1;
  self.stopping = 0;
  self function_481c2a63f2ba3332(0);
  self vehicle_turnengineon();
}

function setup_intro() {
  var_c6e42f4c295786d2 = getStructArray("zombie_intro", "targetname");

  foreach(s_zombie in var_c6e42f4c295786d2) {
    a_ai_zombies = function_7ea5453572655fab(s_zombie, 25, 0, 0);

    foreach(ai_zombie in a_ai_zombies) {
      ai_zombie.var_7e4b076a06c6df27 = 1;
      ai_zombie callback::add("on_zombie_ai_damaged", &on_zombie_ai_damaged);
    }
  }
}

function function_d104044235189c3b(s_quest) {
  self endon("death");
  s_quest flag_wait("zombies_cleared");
  self kill(self.origin, self, self, "MOD_PROJECTILE_SPLASH");
}

function setup_barrels(str_barrel) {
  explosive_barrels = [];
  a_s_barrels = getStructArray(str_barrel, "targetname");

  foreach(s_barrel in a_s_barrels) {
    var_ca6d90a11ccbbf85 = spawnscriptable("barrel_toggleable_red", s_barrel.origin, s_barrel.angles);

    if(isDefined(var_ca6d90a11ccbbf85)) {
      namespace_134d54e39331ee45::activate_barrel(var_ca6d90a11ccbbf85);

      if(isDefined(s_barrel.script_noteworthy) && s_barrel.script_noteworthy == "rooftop_barrel") {
        explosive_barrels[explosive_barrels.size] = var_ca6d90a11ccbbf85;
      }
    }
  }
}

function setup_mines(str_name) {
  while(true) {
    var_da3a55eabb666c32 = getaiarray("team_hundred_ninety");

    if(isDefined(var_da3a55eabb666c32) && var_da3a55eabb666c32.size) {
      break;
    }

    wait 0.1;
  }

  a_mines = [];
  var_f75ab33b14599ef5 = getStructArray(str_name, "targetname");

  foreach(s_mine in var_f75ab33b14599ef5) {
    waitframe();
    mine = namespace_17b45e55cf344cda::function_908ec13fb4d6cede(s_mine.origin, undefined, var_da3a55eabb666c32[0]);

    if(isDefined(mine)) {
      mine.allowfriendlyfire = 1;
      a_mines[a_mines.size] = mine;
    }
  }

  return a_mines;
}

function function_3b71972269735715() {
  a_s_locs = getStructArray("s_fallback", "targetname");
  var_6a4e378d83f4ed19 = getStructArray("zombie_intro", "targetname");

  foreach(s_loc in a_s_locs) {
    if(level.players.size < 3) {
      var_c41ff3df2633113b = function_5e715be63f9f20de(s_loc, 1);
    } else {
      var_c41ff3df2633113b = function_5e715be63f9f20de(s_loc, 2);
    }

    foreach(ai_soldier in var_c41ff3df2633113b) {
      ai_soldier thread behavior_guard(array_random(var_6a4e378d83f4ed19).origin, 200);
    }
  }
}

function soldier_frontline() {
  s_stronghold_approach = getStruct("s_stronghold_approach", "targetname");
  thread function_a5b76e0f5024cc9a(s_stronghold_approach, "river_crossed", 9500);
  thread function_a5b76e0f5024cc9a(s_stronghold_approach, "train_tracks", 6000);
  proximity_watcher(s_stronghold_approach);
  thread setup_mines("sentry_mine_tracks");
  var_f10d2bae0aa4fce7 = getStructArray("merc_frontline_spawnpt", "targetname");
  var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];

  foreach(s_spawnpt in var_f10d2bae0aa4fce7) {
    if(isDefined(s_spawnpt.script_noteworthy)) {
      str_aitype = "jup_ob_enemy_specialist_" + s_spawnpt.script_noteworthy;
    } else {
      str_aitype = array_random(var_ee3ea8d303c9025c);
    }

    ai_merc = s_spawnpt merc_spawn(str_aitype);

    if(isDefined(ai_merc)) {
      if(ai_merc.agent_type == "actor_jup_ob_enemy_specialist_sniper") {
        ai_merc thread behavior_guard(s_spawnpt.origin);
        ai_merc thread ai_aware(5000);
        ai_merc thread function_a079767f0ca0d4c4(self);
        continue;
      }

      ai_merc thread function_c3e93b21ceeb1d92(self);
    }
  }

  s_sniper = getStruct("merc_sniper_tower", "targetname");
  ai_sniper = s_sniper merc_spawn("jup_ob_enemy_specialist_sniper");

  if(isDefined(ai_sniper)) {
    ai_sniper thread behavior_guard(s_sniper.origin);
    ai_sniper thread ai_aware(5000);
    ai_sniper thread function_a079767f0ca0d4c4(self);
    ai_sniper thread merc_sniper_tower(s_sniper);
  }

  s_sniper = getStruct("merc_facility_sniper", "targetname");
  s_goal = getStruct(s_sniper.target, "targetname");
  str_aitype = "jup_ob_enemy_specialist_" + s_sniper.script_noteworthy;
  proximity_watcher(s_sniper);
  ai_sniper = s_spawnpt merc_spawn(str_aitype);

  if(isDefined(ai_sniper)) {
    ai_sniper thread behavior_guard(s_goal.origin);
    ai_sniper thread ai_aware(5000);
    ai_sniper thread function_a079767f0ca0d4c4(self);
  }
}

function merc_sniper_tower(s_sniper) {
  self waittill("death");

  if(isDefined(self)) {
    v_forward = vectorNormalize(anglesToForward(s_sniper.angles)) * 4 + self.origin;
  }

  waitframe();

  if(isDefined(self)) {
    e_corpse = self getcorpseentity();
  }

  if(isDefined(e_corpse)) {
    e_corpse startragdollfromimpact("torso_lower", v_forward);
  }
}

function function_c3e93b21ceeb1d92(s_quest) {
  self endon("death");
  s_quest waittill("train_tracks");
  thread merc_attack();
}

function function_a079767f0ca0d4c4(s_quest) {
  self endon("death");
  s_quest flag_wait("charge_planted");
  self kill();
}

function function_1c3939b802f05136() {
  var_462dea9bc3c97dc3 = getStructArray("zombie_pen", "targetname");

  foreach(s_pen in var_462dea9bc3c97dc3) {
    s_pen.var_fb0b130aadea0e12 = spawnscriptable("ob_zombie_shipping_container", s_pen.origin, s_pen.angles);
    s_pen.var_fb0b130aadea0e12 setscriptablepartstate("state", "visible");
    s_pen thread function_ea9c9fa94fbf39f1();
  }

  var_1c0f03f93fb4f5b = getStructArray("zombie_container", "targetname");

  foreach(s_container in var_1c0f03f93fb4f5b) {
    var_fb0b130aadea0e12 = spawnscriptable("ob_zombie_shipping_container_ambient", s_container.origin, s_container.angles);
    var_fb0b130aadea0e12 setscriptablepartstate("state", "visible");
  }
}

function function_3f90c8202c9d37cb() {
  proximity_watcher(getStruct("s_zombie_water", "targetname"));
  a_s_spawners = getStructArray("zombie_water", "targetname");
  flag_set("alerted");
  self notify("alerted");

  for(i = 0; i < a_s_spawners.size; i++) {
    zombie_spawn(a_s_spawners[i], 0, 1);
    wait randomfloatrange(0.25, 0.5);
  }
}

function function_1e86be4e3accaf94() {
  self.var_4118ca23a8b62b78 = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  waitframe();
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_add_objective(self.var_4118ca23a8b62b78, "current");
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.s_stronghold.origin + (0, 0, 280));
  scripts\mp\objidpoolmanager::update_objective_icon(self.var_4118ca23a8b62b78, "jup_ui_map_icon_generic_marker");
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.var_4118ca23a8b62b78);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::function_98ba077848896a3(self.var_4118ca23a8b62b78, 1);
}

function function_60721b5cb1eee95c() {
  level flag_wait("chopper_end");
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_INFILTRATE", level.players);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("quest_s0_act3_start", level.players);
  flag_wait("players_disembarked");
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_REACH_FACILITY", level.players);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_4118ca23a8b62b78);
  thread function_a5b76e0f5024cc9a(getStruct("enrichment_machine", "targetname"), "facility_approach", 1000);
  level thread function_a0c0fd784f3d1882();
  self waittill("facility_approach");
  self notify("entrance_found");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("fight_to_stronghold_zakhaev");
  }
}

function function_3a8fc38da7251e76() {
  self waittill("entrance_found");
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_LOCATE_DEVICE", level.players);
  waitframe();
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.s_enrichment.origin + (0, 0, 68));
  proximity_watcher(self.s_enrichment);
  level flag_set("facility_entered");
  setmusicstate("mx_ob_q3_action_low");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.s_machine.origin + (0, 0, 80));
  proximity_watcher(self.s_machine);
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_PLANT_EXPLOSIVE", level.players);
  self notify("device_found");
  waitframe();
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_4118ca23a8b62b78);
  function_9766d0b79eada249(self.var_4118ca23a8b62b78, 0);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.s_charge.origin);
}

function approach_neutralizer() {
  proximity_watcher(self.var_33ff83242dcaad2b, 8500);
  flag_set("approach_neutralizer");
  flag_wait("neutralizer_dropped");
  function_a5b76e0f5024cc9a(self.var_a6cd1b1206e83312, "neutralizer_reached", 700);
  flag_set("neutralizer_reached");
}

function function_5cb2f7158d07480c() {
  flag_wait("charge_planted");
  setmusicstate("mx_ob_q3_action_high");
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_PROCEED_LZ", level.players);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.var_a6cd1b1206e83312.origin + (0, 0, 42));
  flag_wait("approach_neutralizer");
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.var_4118ca23a8b62b78);

  while(!isDefined(self.var_4ec719f9f007acbc)) {
    wait 0.1;
  }

  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_4118ca23a8b62b78);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.var_4118ca23a8b62b78, self.var_4ec719f9f007acbc);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.var_4118ca23a8b62b78, 248);
  flag_wait("neutralizer_dropped");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.var_a6cd1b1206e83312.origin + (0, 0, 100));
  thread function_340a2b1d87903294();
  flag_wait("neutralizer_reached");
  setmusicstate("mx_ob_q3_action_exit");
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_ACTIVATE_NEUTRALIZER", level.players);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_4118ca23a8b62b78, self.var_11d2e045f1efdf0f.origin);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.var_4118ca23a8b62b78, 0);
  thread function_6ddbbcc69eb0e369();
  flag_wait("neutralizer_on");
  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.players);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.var_4118ca23a8b62b78);
  flag_wait("chopper_obj");
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_4118ca23a8b62b78);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_4118ca23a8b62b78, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.var_4118ca23a8b62b78, self.vh_victim);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.var_4118ca23a8b62b78, 100);
  wait 1;
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_NEUTRALIZER_DEFEND", level.players);
}

function function_340a2b1d87903294() {
  neutralizer_scriptable = spawnscriptable("ob_quest_neutralizer", self.var_a6cd1b1206e83312.origin, self.var_a6cd1b1206e83312.angles);
  neutralizer_scriptable setscriptablepartstate("state", "visible");
  flag_wait("neutralizer_on");
  wait 1;
  neutralizer_scriptable setscriptablepartstate("state", "ready");
  wait 10;
  neutralizer_scriptable setscriptablepartstate("state", "activate");
  wait 8;
  neutralizer_scriptable setscriptablepartstate("state", "twentyfive");
  wait 8;
  neutralizer_scriptable setscriptablepartstate("state", "fifty");
  wait 8;
  neutralizer_scriptable setscriptablepartstate("state", "seventyfive");
  wait 8;
  neutralizer_scriptable setscriptablepartstate("state", "onehundred");
  level waittill("deathworm_dead");
  neutralizer_scriptable freescriptable();
}

function function_19c6345441a07ac8(v_spot, str_endon, n_radius) {
  self endon(str_endon);
  n_dist = squared(n_radius);

  while(true) {
    foreach(player in level.players) {
      if(isalive(player)) {
        if(distancesquared(v_spot, player.origin) < n_dist) {
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.var_4118ca23a8b62b78, player);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.var_4118ca23a8b62b78, player);
      }
    }

    wait 0.1;
  }
}

function function_2e0dc001c9a5c661() {
  var_d08f3ac86be7ae9e = getStructArray("map_transition_to_act3", "targetname");
  self.var_a5016e4b6acfea47 = [];
  level waittill("prematch_done");
  thread function_a49ca0a80cb63664();

  foreach(s_exfil in var_d08f3ac86be7ae9e) {
    s_exfil.var_d182b8d3f3aaa93b = content_manager::spawn_script_model(s_exfil, "ob_quest_exfil_site_xmodel", 1, 1);
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_site", "standby");
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_icon", "default_icon");
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_smoke", "smoking");
    self.var_a5016e4b6acfea47[self.var_a5016e4b6acfea47.size] = s_exfil.var_d182b8d3f3aaa93b;
    s_exfil.var_d182b8d3f3aaa93b.interact = interaction::register_interact(s_exfil.var_d182b8d3f3aaa93b, 80, &function_a1778cdfcc8373ae, &"JUP_OB_OBJECTIVES/QUEST_0_ACT3_TRANSITION");
    s_exfil.var_d182b8d3f3aaa93b.interact sethintonobstruction("show");
    s_exfil thread function_e3ba83b1bb428b8e();
  }

  level flag_wait("exfil_nuclear");

  foreach(s_exfil in var_d08f3ac86be7ae9e) {
    if(isDefined(s_exfil.n_obj_id)) {
      objidpoolmanager::returnobjectiveid(s_exfil.n_obj_id);
      s_exfil.n_obj_id = undefined;
    }
  }
}

function function_a49ca0a80cb63664() {
  level flag_wait("exfil_nuclear");
  wait 1;

  foreach(var_d182b8d3f3aaa93b in self.var_a5016e4b6acfea47) {
    if(isDefined(var_d182b8d3f3aaa93b) && isDefined(var_d182b8d3f3aaa93b.interact)) {
      var_d182b8d3f3aaa93b.interact delete();
    }

    if(isDefined(var_d182b8d3f3aaa93b)) {
      var_d182b8d3f3aaa93b delete();
    }
  }
}

function function_e3ba83b1bb428b8e() {
  self.n_obj_id = objidpoolmanager::requestobjectiveid(1);
  objidpoolmanager::objective_add_objective(self.n_obj_id, "invisible", self.var_d182b8d3f3aaa93b.origin, "ui_map_icon_ob_quest_exfil", "icon_small");
  objidpoolmanager::update_objective_onentity(self.n_obj_id, self.var_d182b8d3f3aaa93b);
  objidpoolmanager::function_c3c6bff089dfdd34(self.n_obj_id, "icon_regular");
  objective_setlabel(self.n_obj_id, &"SHARED_HINTSTRINGS/EXFIL");
  objective_setplayintro(self.n_obj_id, 0);
}

function function_a1778cdfcc8373ae(player) {
  if(isDefined(level.var_d8b6115a502e7e76)) {
    if(!self[[level.var_d8b6115a502e7e76]](player)) {
      self playsoundtoplayer("ui_zm_core_door_purchase_deny", player);
      return;
    }
  }

  level flag_set("exfil_nuclear");
  level thread map_transition();
  self function_dfb78b3e724ad620(0);
}

function map_transition(var_684092929dab076f, var_576f57af0204c38c) {
  a_squads = [];

  while(true) {
    player = var_684092929dab076f[0];
    var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);
    var_22d2a2a72fc2c595 = [];

    foreach(squad_member in var_c9b69aecc5c631ed) {
      if(var_576f57af0204c38c function_c80b9a252474413b(squad_member)) {
        var_22d2a2a72fc2c595[var_22d2a2a72fc2c595.size] = squad_member;
      }
    }

    a_squads[a_squads.size] = var_22d2a2a72fc2c595;

    foreach(squad_member in var_22d2a2a72fc2c595) {
      var_684092929dab076f = array_remove(var_684092929dab076f, squad_member);
    }

    if(!var_684092929dab076f.size) {
      break;
    }

    waitframe();
  }

  foreach(squad in a_squads) {
    level thread ob_exfil::function_e229d89e0c38206d(squad, 1003);
  }
}

function player_setup() {
  self.ignoreme = 1;
  self allowfire(0);
  hidehudenable();

  if(isDefined(level.var_98539610199d2422)) {
    level.var_98539610199d2422 flag_wait("players_unloaded");
  }

  wait 1;
  self.ignoreme = 0;
  self allowfire(1);
  hidehuddisable();
}

function function_804aa1cbd49ba400(veh_ref, s_pos, b_unload) {
  s_pos.spawndata = spawnStruct();
  s_pos.spawndata.origin = s_pos.origin;
  s_pos.spawndata.angles = s_pos.angles;
  s_pos.spawndata.preventrespawn = 1;
  vh_chopper = vehicle::vehicle_spawn(veh_ref, s_pos.spawndata);

  if(isDefined(vh_chopper)) {
    vehicle_interact::vehicle_interact_makeunusable(vh_chopper);
    vh_chopper.callingteam = "team_hundred_ninety";
    vh_chopper.unload_land_offset = 255;
    vh_chopper.script_disconnectpaths = 1;
    vh_chopper.ignorelist = [vh_chopper];

    if(b_unload) {
      vh_chopper vehicle_setspeed(60, 15, 10);
      vh_chopper.vehiclesetuprope = 1;
      vh_chopper chopper_load(self);
    } else {
      vh_chopper vehicle_setspeed(80, 25, 15);
      vh_chopper.var_bdec9a74b3b2a503 = vh_chopper function_61650f275ef0266f("tag_rocket_left1");
      vh_chopper.var_2d5a32b6a40fda8c = vh_chopper function_61650f275ef0266f("tag_rocket_right1");
    }

    vh_chopper setvehgoalpos(vh_chopper.origin, 1);
    return vh_chopper;
  }
}

function chopper_load(s_quest) {
  self endon("death");
  self.var_f585b76d7f472cd9 = [];
  n_riders = function_25e754c30394817f("chopper");

  for(i = 0; i < n_riders; i++) {
    str_aitype = array_random(s_quest.var_ee3ea8d303c9025c);
    ai_merc = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(str_aitype, self.origin, self.angles, "team_hundred_ninety");

    if(isDefined(ai_merc)) {
      self.var_f585b76d7f472cd9[i] = ai_merc;
    }

    waitframe();
  }

  namespace_d595138a91ee4a1d::function_35c699c709e24b69(self.var_f585b76d7f472cd9);
}

function function_467714861e4130a5(s_start) {
  self endon("death");
  self.rocket_side = "left";
  s_goal = getStruct(s_start.target, "targetname");

  while(true) {
    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "fire") {
        self setvehgoalpos(s_goal.origin, 1);
      } else if(s_goal.script_noteworthy == "wait") {
        self setvehgoalpos(s_goal.origin, 1);
      }
    } else {
      self setvehgoalpos(s_goal.origin, 0);
    }

    self waittill("goal");

    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "fire") {
        if(isDefined(s_start.script_noteworthy) && isDefined(self.var_8b485876981911ff) && self.var_8b485876981911ff) {
          self.var_8b485876981911ff = 0;
          s_target1 = getStruct("first_shot", "script_noteworthy");
          s_target2 = getStruct("second_shot", "script_noteworthy");
          ai_target1 = spawn_model("tag_origin", s_target1.origin);
          ai_target2 = spawn_model("tag_origin", s_target2.origin);
          self setlookatent(ai_target1);

          while(true) {
            if(function_3b142e491735475(ai_target1) || !isalive(ai_target1)) {
              break;
            }

            wait 0.1;
          }

          function_50446d8d9c77ea2e(ai_target1);
          wait 1;
          function_50446d8d9c77ea2e(ai_target2);
          self clearlookatent();
          ai_target1 delete();
          ai_target2 delete();
          wait 1;
          level.var_98539610199d2422 thread function_76ab8d60113c9c8f();
        }

        a_ai_zombies = getaiarrayinradius(self.origin, s_goal.radius, "team_two_hundred");

        while(!level.var_98539610199d2422 flag("hold")) {
          ai_target = array_random(a_ai_zombies);

          if(isDefined(ai_target)) {
            self setlookatent(ai_target);

            while(true) {
              if(function_3b142e491735475(ai_target) || !isalive(ai_target)) {
                break;
              }

              wait 0.1;
            }

            wait 1;
            function_50446d8d9c77ea2e(ai_target);
            self clearlookatent();
          }

          a_ai_zombies = array_removedead(a_ai_zombies);
          wait randomfloatrange(1, 1.5);
        }

        level.var_98539610199d2422 flag_set("zombies_cleared");
        self clearlookatent();
      } else if(s_goal.script_noteworthy == "wait") {
        level.var_98539610199d2422 flag_wait("zombies_cleared");
        wait randomfloatrange(1.8, 2.2);
      } else if(s_goal.script_noteworthy == "unload") {
        self setgoalyaw(flat_angle(s_goal.angles)[1]);
        self sethoverparams(0);
        self.var_da3a55eabb666c32 = heli_unload(s_goal);
        self notify("unloaded_mercs");
        self cleargoalyaw();
      }
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    var_f585b76d7f472cd9 = getaiarrayinradius(self.origin, 500, "team_hundred_ninety");

    foreach(ai_rider in var_f585b76d7f472cd9) {
      if(isalive(ai_rider)) {
        ai_rider kill();
      }
    }

    thread function_2464d79a2aec25f();
    scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
    scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    break;
  }
}

function function_50446d8d9c77ea2e(e_target) {
  if(self.rocket_side == "left") {
    self.var_bdec9a74b3b2a503 thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(1);
    self.missilepod = self.var_bdec9a74b3b2a503;
    self.str_tag = "tag_rocket_left1";
    self.rocket_side = "right";
  } else {
    self.var_2d5a32b6a40fda8c thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx(2);
    self.missilepod = self.var_2d5a32b6a40fda8c;
    self.str_tag = "tag_rocket_right1";
    self.rocket_side = "left";
  }

  turretviewpos = self gettagorigin(self.str_tag);

  if(isvector(e_target)) {
    missileend = e_target;
  } else {
    missileend = e_target.origin;
  }

  var_a437f2b6d33146eb = vectorNormalize(missileend - turretviewpos);
  missileorigin = self.missilepod.origin * (1, 1, 0) + (0, 0, turretviewpos[2]);
  missilestart = missileorigin + var_a437f2b6d33146eb * 100;
  missile_ref = "chopper_gunner_proj_dmz";
  missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(missile_ref), missilestart, missileend);
  missile.owner = self;
  wait 0.25;

  if(isDefined(missile) && isDefined(e_target)) {
    if(isai(e_target)) {
      missile thread function_9a12e4ae660ebeb9(e_target);
    } else if(isPlayer(e_target)) {
      missile thread function_9a4e1c2bf172c26b(e_target);
    }
  }

  missile missile_settargetpos(missileend);
}

function function_9a4e1c2bf172c26b(e_target) {
  self waittill("death");

  if(isDefined(self)) {
    v_impact = self.origin;
    radiusdamage(v_impact, 600, 60, 20, self, "MOD_PROJECTILE_SPLASH");
  }
}

function function_9a12e4ae660ebeb9(e_target) {
  self waittill("death");
  n_radius = 800;

  if(isDefined(self)) {
    if(isalive(e_target)) {
      e_target dodamage(50, self.origin);
    }

    a_ai_zombies = getaiarrayinradius(self.origin, n_radius, "team_two_hundred");

    foreach(ai_zombie in a_ai_zombies) {
      if(isalive(ai_zombie)) {
        ai_zombie dodamage(50, self.origin);
      }
    }
  }
}

function function_a5e63dc4b0096441() {
  n_index = randomint(6);

  switch (n_index) {
    case 0:
      str_hit_loc = "head";
      break;
    case 1:
      str_hit_loc = "right_leg_lower";
      break;
    case 2:
      str_hit_loc = "left_leg_lower";
      break;
    case 3:
      str_hit_loc = "torso_lower";
      break;
    case 4:
      str_hit_loc = "right_arm_upper";
      break;
    case 5:
      str_hit_loc = "left_arm_upper";
      break;
  }

  if(isDefined(str_hit_loc)) {
    return str_hit_loc;
  }
}

function function_61650f275ef0266f(tag) {
  missilepod = spawn("script_model", self gettagorigin(tag));
  missilepod setModel("ks_chopper_gunner_turret_mp");
  missilepod show();
  missilepod.angles = self.angles;
  missilepod linkTo(self, tag);
  missilepod setotherent(self);
  missilepod.heli = self;
  missilepod thread function_c6366a8fc111f210(self);
  return missilepod;
}

function function_c6366a8fc111f210(heli) {
  heli waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

function function_3b142e491735475(target) {
  if(!isDefined(self)) {
    return;
  }

  var_97f0985016aa48cb = 0.8;
  turretforward = anglesToForward(self.angles);
  targetdisplace = vectorNormalize(target.origin - self gettagorigin("tag_origin"));
  var_ff53e400dd536b82 = vectordot(turretforward, targetdisplace);
  return var_ff53e400dd536b82 >= var_97f0985016aa48cb;
}

function function_c776ee14bbf6320e(s_quest, s_goal) {
  self vehicle_setspeed(60, 10, 8);

  while(true) {
    if(isDefined(s_goal.script_noteworthy) && s_goal.script_noteworthy == "drop_off") {
      heli_unload(s_goal);
    } else {
      if(isDefined(s_goal.script_noteworthy)) {
        if(s_goal.script_noteworthy == "approach") {
          self setvehgoalpos(s_goal.origin, 1);
        }
      } else {
        self setvehgoalpos(s_goal.origin, 0);
      }

      self waittill("goal");
    }

    if(isDefined(s_goal.script_noteworthy) && s_goal.script_noteworthy == "approach") {
      if(isDefined(s_goal.target2)) {
        thread smoke_screen(getStruct(s_goal.target2, "targetname").origin);
      }
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    break;
  }

  thread function_2464d79a2aec25f();
  scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
  scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function function_2464d79a2aec25f() {
  var_f585b76d7f472cd9 = getaiarrayinradius(self.origin, 500, "team_hundred_ninety");

  foreach(ai_rider in var_f585b76d7f472cd9) {
    if(isalive(ai_rider)) {
      ai_rider kill();
    }
  }
}

function smoke_screen(v_pos) {
  magicgrenademanual("smoke_grenade_mp", v_pos, (0, 0, -10), 0.5);
  play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

function function_25e754c30394817f(var_262e2e52c4899135) {
  switch (level.players.size) {
    case 1:
      if(var_262e2e52c4899135 == "truck") {
        n_riders = 3;
      } else if(var_262e2e52c4899135 == "chopper") {
        n_riders = 6;
      }

      break;
    case 2:
      if(var_262e2e52c4899135 == "truck") {
        n_riders = 4;
      } else if(var_262e2e52c4899135 == "chopper") {
        n_riders = 6;
      }

      break;
    case 3:
      if(var_262e2e52c4899135 == "truck") {
        n_riders = 5;
      } else if(var_262e2e52c4899135 == "chopper") {
        n_riders = 6;
      }

      break;
    case 4:
      if(var_262e2e52c4899135 == "truck") {
        n_riders = 5;
      } else if(var_262e2e52c4899135 == "chopper") {
        n_riders = 6;
      }

      break;
    default:
      if(var_262e2e52c4899135 == "truck") {
        n_riders = 5;
      } else if(var_262e2e52c4899135 == "chopper") {
        n_riders = 6;
      }

      break;
  }

  return n_riders;
}

function heli_unload(s_loc) {
  self setvehgoalpos(s_loc.origin, 1);
  self waittill("goal");
  self sethoverparams(0);

  if(isDefined(s_loc.target2)) {
    thread smoke_screen(getStruct(s_loc.target2, "targetname").origin);
  }

  var_b3941e6a151cf4d2 = vehicle_code::_vehicle_unload();
  self waittill("unloaded");
  return var_b3941e6a151cf4d2;
}

function function_11547bb002dd118c() {
  var_72197e516436cc5c = getStructArray("door_lock", "targetname");

  foreach(s_door in var_72197e516436cc5c) {
    s_door thread function_5118998628125357();
  }
}

function function_5118998628125357() {
  level endon("facility_entered");
  proximity_watcher(self);
  a_s_spawners = getStructArray(self.target, "targetname");
  var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];

  foreach(s_spawner in a_s_spawners) {
    ai_merc = s_spawner merc_spawn(array_random(var_ee3ea8d303c9025c));
  }
}

function merc_interior() {
  s_interior = getStruct("s_merc_interior", "targetname");
  proximity_watcher(s_interior);
  setmusicstate("mx_ob_q3_action_high");
  s_interior smoke_screen(s_interior.origin);
  var_fdbc62a2eb9677f = getStructArray("merc_interior", "targetname");
  var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];

  foreach(s_merc in var_fdbc62a2eb9677f) {
    if(isDefined(s_merc.script_noteworthy)) {
      ai_merc = s_merc merc_spawn("jup_ob_enemy_specialist_shielded");
      continue;
    }

    ai_merc = s_merc merc_spawn(array_random(var_ee3ea8d303c9025c));
  }
}

function function_47e9b34b3e46619() {
  s_device = getStruct("enrichment_machine", "targetname");
  self.mdl_device = spawn_model("jup_zm_enrichment_device", s_device.origin, s_device.angles);
}

function merc_stronghold() {
  proximity_watcher(getStruct("enrichment_device", "targetname"));
  var_fdbc62a2eb9677f = getStructArray("merc_stronghold", "targetname");
  var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];
  self.var_690609742a2905ca = [];

  foreach(s_merc in var_fdbc62a2eb9677f) {
    if(isDefined(s_merc.script_noteworthy) && s_merc.script_noteworthy == "sniper") {
      str_aitype = "jup_ob_enemy_specialist_sniper";
    } else {
      str_aitype = array_random(var_ee3ea8d303c9025c);
    }

    ai_merc = s_merc merc_spawn(str_aitype);

    if(isDefined(ai_merc)) {
      if(ai_merc.agent_type == "actor_jup_ob_enemy_specialist_sniper") {
        ai_merc thread behavior_guard(s_merc.origin);
        ai_merc thread ai_aware(2000);
        ai_merc thread function_e5e953525a087911(self);
      } else if(isDefined(s_merc.script_noteworthy) && s_merc.script_noteworthy == "enrichment_guard") {
        ai_merc thread behavior_guard(s_merc.origin);
        ai_merc thread function_517d8a84dba86a25(self);
        ai_merc thread function_b864a4bcc824dd72(self);
      }

      ai_merc thread function_d9f63cad62a5df8e(self);
      self.var_690609742a2905ca[self.var_690609742a2905ca.size] = ai_merc;
    }
  }

  self.var_3367ed0e23330295 = self.var_690609742a2905ca.size;
  self.var_5be1f3a546b3c772 = int(self.var_3367ed0e23330295 * 0.66);
  self.var_be02557153721f54 = int(self.var_3367ed0e23330295 * 0.33);
  self.n_kills = 0;
}

function function_d9f63cad62a5df8e(s_quest) {
  self waittill("death");

  if(isDefined(s_quest.var_690609742a2905ca) && s_quest.var_690609742a2905ca.size) {
    s_quest.n_kills++;

    if(s_quest.n_kills == s_quest.var_be02557153721f54) {
      level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_first_stronghold", level.players, 0, 0);
      return;
    }

    if(s_quest.n_kills == s_quest.var_5be1f3a546b3c772) {
      level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_second_stronghold", level.players, 0, 0);
    }
  }
}

function function_b864a4bcc824dd72(s_quest) {
  self endon("death");
  self endon("combat");
  waittill_any_2("damage", "grenade danger");
  self notify("combat");
}

function function_517d8a84dba86a25(s_quest) {
  self endon("death");
  self endon("combat");
  s_quest waittill("device_found");
  self notify("combat");
}

function function_e5e953525a087911(s_quest) {
  self endon("death");
  self endon("combat");
  s_quest flag_wait("charge_planted");
  self notify("combat");
}

function function_de6ae73d98f28ba3() {
  self.s_interact = getStruct("explosive_charge", "targetname");
  waitframe();
  self.e_charge = scripts\cp_mp\interaction::register_interact(self.s_interact.origin, 64, &explosive_interact, &"JUP_OB_OBJECTIVES/Q0_PLANT_CHARGE");
  wait 0.1;
  self.e_charge setCursorHint("HINT_BUTTON");
  self.e_charge sethinticon("hud_icon_c4_plant");
  self.e_charge waittill("charge_planted");
  self.e_charge delete();
  flag_set("charge_planted");
}

function function_ecaaf38e23ec16b5(device, player) {
  level endon("game_ended");
  device.scenenode = getStruct("c4_scene_node", "targetname");
  actorplayer = anim_scene_create_actor(player, "player_rig_sm", 1);
  c4 = spawn_model("offhand_2h_c4_prop_ob", actorplayer.entity gettagorigin("tag_accessory_right"));
  c4 hide();
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 dontinterpolate();
  c4 linkTo(actorplayer.entity, "tag_accessory_right");
  level thread showc4(c4);
  c4 thread function_e9508a0db7cc3e83();
  var_db3b2bd857f61ae6 = device.scenenode anim_scene([actorplayer], "samsite_plant_f");
  c4 unlink();
  actorplayer = undefined;
  actorc4 = undefined;
  level thread function_d0b233de2e4f5720();
  c4 setscriptablepartstate("effects", "danger");

  if(isDefined(level.var_3f4534fb14cca909)) {
    detonate_success = [[level.var_3f4534fb14cca909]](c4, device, player);

    if(!istrue(detonate_success)) {
      c4 hide();
      return;
    }
  }

  playFX(getfx("enrichment_explosion"), self.mdl_device.origin, anglesToForward(self.mdl_device.angles), anglestoup(self.mdl_device.angles));
  earthquake(0.6, 0.7, self.mdl_device.origin, 800);
  playrumbleonposition("grenade_rumble", self.mdl_device.origin);
  playsoundatpos(self.mdl_device.origin, "c4_expl_trans");
  radiusdamage(self.mdl_device.origin, 256, 500, 50, self.mdl_device, "MOD_EXPLOSIVE", undefined, 0, 0);
  waitframe();
  self.mdl_device delete();
}

function function_151037a96443f076(c4, samsite, player) {
  samsite endon("samsite_cancel_bomb_countdown");
  currenttime = gettime();
  totaltime = 15000;
  bombendtime = int(currenttime + totaltime);
  var_c301d652d9a73075 = bombendtime - currenttime;

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 < 1500) {
      if(var_c301d652d9a73075 <= 250) {
        if(soundexists("breach_warning_beep_05")) {
          c4 playSound("breach_warning_beep_05");
        }
      } else if(var_c301d652d9a73075 < 500) {
        if(soundexists("breach_warning_beep_04")) {
          c4 playSound("breach_warning_beep_04");
        }
      } else if(var_c301d652d9a73075 < 1500) {
        if(soundexists("breach_warning_beep_03")) {
          c4 playSound("breach_warning_beep_03");
        }
      } else if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_c301d652d9a73075 < 3500) {
      if(soundexists("breach_warning_beep_02")) {
        c4 playSound("breach_warning_beep_02");
      }

      wait 0.5;
    } else {
      if(soundexists("breach_warning_beep_01")) {
        c4 playSound("breach_warning_beep_01");
      }

      wait 1;
    }

    if(var_c301d652d9a73075 < 0) {
      break;
    }
  }

  samsite notify("samsite_bomb_detonated");
  level.var_98539610199d2422 thread charge_explode(c4);
  return true;
}

function function_e9508a0db7cc3e83() {
  wait 1;

  if(soundexists("weap_samsite_plant_c4")) {
    self playSound("weap_samsite_plant_c4");
  }
}

function showc4(c4) {
  c4 endon("death");
  wait 1;
  c4 show();
}

#using_animtree("script_model");

function function_c25a40ae517ef340() {
  level.scr_animtree["player_rig_sm"] = #animtree;
  level.scr_anim["player_rig_sm"]["samsite_plant_l"] = % iw9_sam_breach_charge_left;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_l"] = % "iw9_sam_breach_charge_left";
  level.scr_anim["player_rig_sm"]["samsite_plant_r"] = % iw9_sam_breach_charge_right;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_r"] = % "iw9_sam_breach_charge_right";
  level.scr_anim["player_rig_sm"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front;
  level.scr_eventanim["player_rig_sm"]["samsite_plant_f"] = % "hash_7e94c3dd66a3eca0";
  level.scr_animtree["c4_prop"] = #animtree;
  level.scr_anim["c4_prop"]["samsite_plant_l"] = % iw9_cp_sam_breach_charge_left_c4;
  level.scr_anim["c4_prop"]["samsite_plant_r"] = % iw9_cp_sam_breach_charge_right_c4;
  level.scr_anim["c4_prop"]["samsite_plant_f"] = % iw9_cp_sam_breach_charge_front_c4;
}

function charge_explode(mdl_charge) {
  flag_set("charge_exploded");
  mdl_charge delete();
}

function explosive_interact(player) {
  player callback::callback("clear_stronghold_zakhaev");
  level.var_98539610199d2422 thread function_ecaaf38e23ec16b5(self, player);
  self notify("charge_planted");
}

function function_ea9c9fa94fbf39f1() {
  self.var_ef1bc48fde3da78 = getclosest(self.origin, level.var_4c272da3f0a1a024);
  self.var_e4558c4bf7159860 = getclosest(self.origin, level.var_a9e3bda690cc504c);
  proximity_watcher(self);

  if(percent_chance(30) && level.var_eee94908df4c2824 < 2) {
    n_spawns = function_dceb0638996decee("mimic");
    str_aitype = "jup_spawner_zombie_mimic";
    level.var_eee94908df4c2824++;
    self.var_2be52f64c1fda163 = 1;
  } else {
    n_spawns = function_ab65e0d9a8828ab2("container");
  }

  self.v_forward = vectorNormalize(anglesToForward(self.angles));
  self.v_right = vectorNormalize(anglestoright(self.angles));
  self.v_left = vectorNormalize(anglestoright(self.angles) * -1);
  var_31c7c79d67de5b32 = 20;
  var_595c4a700ef4f046 = 20;
  self.a_ai_zombies = [];

  for(i = 0; i < n_spawns; i++) {
    if(!isDefined(self.var_2be52f64c1fda163)) {
      str_aitype = "jup_spawner_zombie_base";
    }

    ai_zombie = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(str_aitype, self.origin, self.angles + (0, 90, 0), "team_two_hundred", "difficulty_yellow");

    if(isDefined(ai_zombie)) {
      ai_zombie thread namespace_f721fc7d0d2d0f47::function_4a4fab5fd0b06d7b("difficulty_normal");
      self.a_ai_zombies[self.a_ai_zombies.size] = ai_zombie;

      if(i == 0) {
        v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32;
        continue;
      }

      if(i == 1) {
        v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32 * -1;
        continue;
      }

      if(i < 7) {
        if(mod(i, 2)) {
          v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32 + self.v_right * var_595c4a700ef4f046 * (i - 1);
        } else {
          v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32 * -1 + self.v_right * var_595c4a700ef4f046 * (i - 1);
        }

        continue;
      }

      if(mod(i, 2)) {
        v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32 + self.v_left * var_595c4a700ef4f046 * (i - 6);
        continue;
      }

      v_pos = self.origin + self.v_forward * var_31c7c79d67de5b32 * -1 + self.v_left * var_595c4a700ef4f046 * (i - 6);
    }
  }

  self.var_fb0b130aadea0e12 setscriptablepartstate("audio", "warning");
  wait 0.2;
  thread function_9d280317afc39370();
  wait 0.6;
  self.var_fb0b130aadea0e12 setscriptablepartstate("state", "activate");

  if(!isDefined(level.vo_container)) {
    level.vo_container = 1;
    level thread vo_container();
  }

  self.var_ef1bc48fde3da78 connectpaths();
  self.var_e4558c4bf7159860 solid();
  self.var_e4558c4bf7159860 disconnectPaths();
  level.var_98539610199d2422 notify("mus_zombiepen_open");
  self.var_ef1bc48fde3da78 delete();
}

function function_9d280317afc39370() {
  foreach(ai_zombie in self.a_ai_zombies) {
    if(isalive(ai_zombie)) {
      ai_zombie.ignoreall = 0;
      ai_zombie thread attack_player(2000);
    }
  }
}

function function_dceb0638996decee(str_type) {
  switch (level.players.size) {
    case 1:
    case 2:
      if(str_type == "mimic") {
        n_spawns = 1;
      }

      break;
    default:
      if(str_type == "mimic") {
        n_spawns = 2;
      }

      break;
  }

  return n_spawns;
}

function function_ab65e0d9a8828ab2(str_type) {
  switch (level.players.size) {
    case 1:
      if(str_type == "container") {
        n_spawns = 9;
      } else if(str_type == "neutralizer") {
        n_spawns = 8;
      } else if(str_type == "horde") {
        n_spawns = 14;
      } else if(str_type == "ground") {
        n_spawns = 4;
      }

      break;
    case 2:
      if(str_type == "container") {
        n_spawns = 13;
      } else if(str_type == "neutralizer") {
        n_spawns = 12;
      } else if(str_type == "horde") {
        n_spawns = 16;
      } else if(str_type == "ground") {
        n_spawns = 5;
      }

      break;
    case 3:
      if(str_type == "container") {
        n_spawns = 16;
      } else if(str_type == "neutralizer") {
        n_spawns = 18;
      } else if(str_type == "horde") {
        n_spawns = 21;
      } else if(str_type == "ground") {
        n_spawns = 6;
      }

      break;
    default:
      if(str_type == "container") {
        n_spawns = 16;
      } else if(str_type == "neutralizer") {
        n_spawns = 20;
      } else if(str_type == "horde") {
        n_spawns = 27;
      } else if(str_type == "ground") {
        n_spawns = 8;
      }

      break;
  }

  return n_spawns;
}

function function_ee63d6fa5d4d6e87() {
  switch (level.players.size) {
    case 1:
      n_spawns = 4;
      break;
    case 2:
      n_spawns = 5;
      break;
    case 3:
      n_spawns = 7;
      break;
    case 4:
      n_spawns = 9;
      break;
    default:
      n_spawns = 10;
      break;
  }

  return n_spawns;
}

function ambient_battles() {
  flag_wait("charge_planted");
  var_7be0d181e782868e = getStructArray("s_ambient", "targetname");

  foreach(s_ambient in var_7be0d181e782868e) {
    s_ambient thread function_602096dbb1212f80();
  }
}

function function_602096dbb1212f80() {
  a_s_locs = getStructArray(self.target, "targetname");
  n_zombies = randomintrange(int(function_ab65e0d9a8828ab2("container") * 0.75), int(function_ab65e0d9a8828ab2("container") * 1.5));
  n_mercs = randomintrange(int(function_ee63d6fa5d4d6e87() * 0.75), int(function_ee63d6fa5d4d6e87() * 1.5));
  proximity_watcher(self);

  foreach(s_loc in a_s_locs) {
    if(s_loc.script_noteworthy == "zombie") {
      a_ai_zombies = function_7ea5453572655fab(s_loc, n_zombies, 0, 1);

      foreach(ai_zombie in a_ai_zombies) {
        ai_zombie thread ai_aware(2000);
      }

      continue;
    }

    var_c41ff3df2633113b = level.var_98539610199d2422 function_5e715be63f9f20de(s_loc, n_mercs);

    foreach(ai_soldier in var_c41ff3df2633113b) {
      ai_soldier thread ai_aware(2000);
    }
  }
}

function merc_facility_exit() {
  s_merc = getStruct("merc_facility_exit", "targetname");
  s_door = getStruct("facility_exit", "script_noteworthy");
  a_doors = [];
  a_doors = namespace_f6368c72597c6d90::function_ad1b6accbaab404e(s_door, a_doors, "fortress", 1);

  foreach(door in a_doors) {
    door.var_707cd84a8924ef55 = undefined;
    namespace_f6368c72597c6d90::function_b092780f9ec4496e(door);
  }

  ai_merc = s_merc merc_spawn("jup_ob_enemy_specialist_heavytactician");

  if(isDefined(ai_merc)) {
    ai_merc thread attack_player(2000);
  }
}

function function_c40217c3d33491b2() {
  thread setup_mines("sentry_mine_facility");
  proximity_watcher(self.var_33ff83242dcaad2b);
  var_fdbc62a2eb9677f = getStructArray("merc_exterior", "targetname");
  var_c6e42f4c295786d2 = getStructArray("zombie_exterior", "targetname");

  foreach(s_zombie in var_c6e42f4c295786d2) {
    a_ai_zombies = function_7ea5453572655fab(s_zombie, 10, 0, 1);
  }

  foreach(s_merc in var_fdbc62a2eb9677f) {
    var_c41ff3df2633113b = function_5e715be63f9f20de(s_merc, 4);

    foreach(ai_soldier in var_c41ff3df2633113b) {
      ai_soldier thread function_75555ebca72dc039();
    }
  }
}

function function_de7c83bd54fe6c54() {
  var_c6e42f4c295786d2 = getStructArray("zombie_exterior_reinforce", "targetname");
  function_a5b76e0f5024cc9a(self.var_33ff83242dcaad2b, "zombie_reinforce", 10000);

  foreach(s_zombie in var_c6e42f4c295786d2) {
    a_ai_zombies = function_7ea5453572655fab(s_zombie, 10, 0, 1);
    s_zombie thread spawn_mangler();
  }
}

function spawn_mangler() {
  v_org = getclosestpointonnavmesh(self.origin);
  var_fb98743d75ac80a0 = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc("jup_spawner_zombie_mangler", v_org, (0, 225, 0), "team_two_hundred");

  if(isDefined(var_fb98743d75ac80a0)) {
    var_fb98743d75ac80a0 namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
  }
}

function function_76ab8d60113c9c8f() {
  while(true) {
    var_da3a55eabb666c32 = getaiarray("team_hundred_ninety");

    if(isDefined(var_da3a55eabb666c32) && var_da3a55eabb666c32.size) {
      break;
    }

    wait 0.1;
  }

  var_f75ab33b14599ef5 = getStructArray("sentry_mine_river", "targetname");

  foreach(s_mine in var_f75ab33b14599ef5) {
    if(isDefined(var_da3a55eabb666c32[0])) {
      mine = namespace_64135de19550f047::function_908ec13fb4d6cede(s_mine.origin, undefined, var_da3a55eabb666c32[0]);

      if(isDefined(mine)) {
        mine thread function_b11dc3c5df6aa7c7(self);
      }
    }
  }
}

function function_b11dc3c5df6aa7c7(s_quest) {
  self endon("death");
  s_quest flag_wait("zombies_cleared");
  wait randomfloatrange(0.5, 1);
  self notify("detonateExplosive");
}

function function_75555ebca72dc039() {
  self endon("death");
  thread scripts\mp\ai_behavior::function_b11c1964f528574b(self, 1, self.origin);
}

function function_b38f0b92e2bc5fdb(attractor, zombie) {
  if(!isDefined(zombie.var_d0bf92fd0dbeaeaf)) {
    return false;
  }

  if(isDefined(zombie.closest_attractor) && attractor != zombie.closest_attractor) {
    return false;
  }

  if(isDefined(zombie.closest_attractor) && distance2dsquared(zombie.origin, zombie.closest_attractor.source.origin) <= 1000000) {
    return false;
  }

  return true;
}

function function_fc5245e119c3f4e5() {
  proximity_watcher(self.var_a6cd1b1206e83312);

  foreach(ai_merc in self.var_49395449fb8335d7) {
    ai_merc thread function_125fba683fe2c7db(self);
  }

  monitor_landing_zone(self.var_49395449fb8335d7);
}

function function_385b258887a1f451() {
  flag_wait("approach_neutralizer");
  wait 2;
  level thread vo_airdrop();
  spawndata = spawnStruct();
  spawndata.angles = self.var_a6cd1b1206e83312.angles;
  spawndata.team = "allies";
  spawndata.origin = self.var_a6cd1b1206e83312.origin;
  spawndata.preventrespawn = 1;
  vehicle_airdrop(spawndata);
}

function vehicle_airdrop(spawndata) {
  scenenode = spawn("script_model", spawndata.origin);
  scenenode.angles = spawndata.angles;
  scenenode setModel("tag_origin");
  parachute = spawn("script_model", spawndata.origin);
  parachute.angles = spawndata.angles;
  parachute.animname = "parachute";
  parachute setModel("veh8_mil_lnd_bromeo_parachute_green");
  parachute scripts\common\anim::setanimtree();
  parachute hide();
  carrier = spawn("script_model", spawndata.origin);
  carrier.angles = spawndata.angles;
  carrier.animname = "ac130";
  carrier setModel("veh9_mil_air_cargo_plane_wm");
  carrier scripts\common\anim::setanimtree();
  carrier hide();
  level.var_98539610199d2422.var_4ec719f9f007acbc = spawn_model("jup_zm_act_3_neutralizer_fxanim", spawndata.origin, spawndata.angles);
  level.var_98539610199d2422.var_4ec719f9f007acbc linkTo(parachute);
  level.var_98539610199d2422.var_4ec719f9f007acbc hide();
  scenenode.vehicle = level.var_98539610199d2422.var_4ec719f9f007acbc;
  scenenode.parachute = parachute;
  scenenode.carrier = carrier;
  scenenode.starttime = gettime() + level.frameduration;
  scenenode.endtime = gettime();
  scenenode thread function_c4f85850fb179639(spawndata);
}

function private function_c4f85850fb179639(spawndata) {
  scripts\common\anim::anim_first_frame_solo(self.parachute, "veh_jup_ob_tank_escort_drop");
  scripts\common\anim::anim_first_frame_solo(self.carrier, "veh_jup_ob_tank_escort_drop");
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, "veh_jup_ob_tank_escort_drop");
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("iw8_bradley_drop_c130");
    thread scripts\common\anim::anim_single_solo(self.carrier, "veh_jup_ob_tank_escort_drop");
  }

  wait getanimlength(level.scr_anim["parachute"]["veh_jup_ob_tank_escort_drop"]) - 2.8;
  function_b708213b1c5dc2a8(self.vehicle);

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  if(isDefined(self.carrier)) {
    self.carrier delete();
  }

  self delete();
}

function private function_b708213b1c5dc2a8(fakevehicle, spawndata) {
  self.vehicle = undefined;

  if(!isDefined(fakevehicle)) {
    return;
  }

  level.var_98539610199d2422.var_4ec719f9f007acbc thread function_f694f53c094603a();
}

function private function_f694f53c094603a() {
  self endon("death");
  self notify("freefall");
  playsoundatpos(self.origin, "iw9_drop_chute_release_whoosh");
  self unlink();
  waitframe();
  airdrop_land();
}

function private airdrop_land() {
  self rotateTo(level.var_98539610199d2422.var_a6cd1b1206e83312.angles, 0.2);
  self moveTo(level.var_98539610199d2422.var_a6cd1b1206e83312.origin, 0.2);
  self waittill("movedone");
  playsoundatpos(self.origin, "iw9_tank_land");
  earthquake(0.4, 0.8, self.origin, 1200);
  playrumbleonposition("artillery_rumble", self.origin);
  physicsexplosionsphere(self.origin, 800, 400, 0.5);
  waitframe();
  level.var_98539610199d2422 flag_set("neutralizer_dropped");
  self delete();
}

function merc_chopper_neutralizer() {
  self.var_49395449fb8335d7 = [];
  var_447e08a8adea1db3 = getStructArray("merc_chopper_neutralizer", "targetname");
  function_a5b76e0f5024cc9a(self.var_a6cd1b1206e83312, "neutralizer_reached", 8000);
  level thread function_601c9eb68a44a33();

  foreach(s_chopper in var_447e08a8adea1db3) {
    var_582d83559bcdf09b = function_804aa1cbd49ba400("veh_jup_blima_anim_infil", s_chopper, 1);

    if(isDefined(var_582d83559bcdf09b)) {
      var_582d83559bcdf09b thread function_467714861e4130a5(s_chopper);
      var_582d83559bcdf09b thread function_85c71338d7d317a9(self);
    }
  }
}

function function_85c71338d7d317a9(s_quest) {
  self endon("death");
  self waittill("unloaded_mercs");

  foreach(ai_merc in self.var_da3a55eabb666c32) {
    if(isalive(ai_merc)) {
      s_quest.var_49395449fb8335d7[s_quest.var_49395449fb8335d7.size] = ai_merc;
      ai_merc thread function_ef47d41add506150();
    }
  }
}

function function_ef47d41add506150() {
  self endon("death");
  level flag_wait("chopper_crash");
  wait randomfloatrange(1, 2);
  var_8f552b849231fff0 = getStructArray("s_ambient", "targetname");
  s_goal = getclosest(self.origin, var_8f552b849231fff0);
  behavior_goto(s_goal.origin, 100);
  self kill();
}

function function_9a8bf9fe77ccef72(s_quest) {
  self endon("death");
  v_goal = getrandomnavpoint(s_quest.var_a6cd1b1206e83312.origin, 1000);

  if(isDefined(v_goal)) {
    thread behavior_guard(v_goal);
  }
}

function function_98c2f84917ad6342() {
  self endon("death");
  self.rocket_side = "left";
  a_e_targets = sortbydistance(level.players, self.origin);
  n_timeout = 0;

  if(isDefined(a_e_targets) && a_e_targets.size) {
    n_index = int(mod(a_e_targets.size - 1, 2));
    e_target = a_e_targets[n_index];

    if(isDefined(e_target)) {
      self setlookatent(e_target);

      while(true) {
        if(function_3b142e491735475(e_target) || !isalive(e_target) || n_timeout > 100) {
          break;
        }

        n_timeout++;
        wait 0.1;
      }

      n_shots = 2;

      for(i = 0; i < n_shots; i++) {
        function_50446d8d9c77ea2e(e_target);
        wait randomfloatrange(0.5, 0.8);
      }

      self clearlookatent();
    }
  }

  wait 1.5;
}

function function_6ddbbcc69eb0e369() {
  self.var_1e935517ae0435cb = scripts\cp_mp\interaction::register_interact(self.var_11d2e045f1efdf0f.origin, 64, &function_9aed6bedca2e5b3, &"JUP_OB_OBJECTIVES/QUEST_0_ACT3_NEUTRALIZER_ACTIVATE");
  self.var_1e935517ae0435cb waittill("neutralizer_activated");
  self.var_1e935517ae0435cb delete();
  self.e_neutralizer = spawn_model("tag_origin", self.var_11d2e045f1efdf0f.origin);
  flag_set("neutralizer_on");
  self notify("neutralizer_on");
  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.players);
}

function function_9aed6bedca2e5b3(player) {
  player playRumbleOnEntity("damage_light");
  self notify("neutralizer_activated");
}

function function_d58e9fe01994f55() {
  s_chopper = getStruct("chopper_ava", "targetname");
  spawndata = spawnStruct();
  spawndata.origin = s_chopper.origin;
  spawndata.angles = s_chopper.angles;
  spawndata.preventrespawn = 1;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;
  function_a5b76e0f5024cc9a(self.var_a6cd1b1206e83312, "neutralizer_reached", 6800);
  vh_chopper = undefined;

  while(!isDefined(vh_chopper)) {
    vh_chopper = vehicle::vehicle_spawn("veh9_palfa", spawndata);
    waitframe();
  }

  vh_chopper vehicle_setspeed(60, 10, 8);
  vh_chopper vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(vh_chopper);
  vh_chopper namespace_9f6a961447bab709::function_a609274d97743733();
  level.ava = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_ally_ava_base", vh_chopper.origin, vh_chopper.angles, level.players[0].team);
  level.ravenov = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_ally_ravenov_base", vh_chopper.origin, vh_chopper.angles, level.players[0].team);
  vh_chopper thread ava_infil();
  s_goal = getStruct(s_chopper.target, "targetname");

  while(true) {
    if(isDefined(s_goal.script_noteworthy)) {
      vh_chopper vehicle_setspeed(20, 10, 8);
      vh_chopper setvehgoalpos(s_goal.origin, 1);

      if(s_goal.script_noteworthy == "unload") {
        vh_chopper setgoalyaw(flat_angle(s_goal.angles)[1]);
      }
    } else {
      vh_chopper setvehgoalpos(s_goal.origin, 0);
    }

    vh_chopper waittill("goal");

    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "unload") {
        vh_chopper sethoverparams(0);
        vh_chopper vehicle_setspeedimmediate(0);
        wait 2;
        vh_chopper notify("unload");
        wait 8;
        vh_chopper vehicle_setspeed(60, 10, 8);
      }
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    break;
  }

  if(isDefined(self.pilots)) {
    foreach(pilot in self.pilots) {
      pilot delete();
    }
  }

  vh_chopper scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
  vh_chopper scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function function_b1aa1fb6109a052b() {
  level.n_revives = 0;

  if(isDefined(level.players) && level.players.size == 1) {
    level.players[0].var_ac45ef94bf07d7d0 = 1;
    level.players[0] thread player_revive_monitor();
  }
}

function player_revive_monitor() {
  self endon("death");
  self endon("revive_used");

  while(true) {
    if(scripts\mp\utility\player::isinlaststand(self) && !isDefined(self.ai_reviver) && isDefined(self.var_dddc97480e104865) && !self.var_dddc97480e104865 && isDefined(level.a_ai_allies)) {
      self.ai_reviver = getclosest(self.origin, level.a_ai_allies);

      if(isDefined(self.ai_reviver)) {
        self.ai_reviver function_2f10cefc09778367(self);
      }
    }

    wait 0.1;
  }
}

function function_2f10cefc09778367(player) {
  self notify("reviving");

  while(true) {
    if(isDefined(player) && distance2dsquared(player.origin, self.origin) > 4096) {
      scripts\mp\ai_behavior::function_304da84d9a815c01(player.origin, 50, 1);
    } else {
      break;
    }

    wait 1;
  }

  if(scripts\mp\utility\player::isinlaststand(player)) {
    player namespace_f585f5e438cbdbc8::heal_player(self);
  }

  level.n_revives++;

  if(level.n_revives > 2) {
    player.ai_reviver = undefined;
    player.var_ac45ef94bf07d7d0 = undefined;
    player notify("revive_used");
  }
}

function ava_infil() {
  var_a6cd1b1206e83312 = getStruct("neutralizer", "targetname");
  thread scripts\common\scene::play(level.ava, "ava_infil_exit_idle", "jup_cin_zm_vig_s0_act3_quest_ava_infil_exit");
  thread scripts\common\scene::play(level.ravenov, "ravenov_infil_exit_idle", "jup_cin_zm_vig_s0_act3_quest_ava_infil_exit");
  self waittill("unload");
  level.ava thread function_a96ad3789e72a939(self, "ava_infil_exit_f");
  level.ravenov thread function_a96ad3789e72a939(self, "ravenov_infil_exit_f");
  level.a_ai_allies = [];

  if(isDefined(level.ava)) {
    level.a_ai_allies[level.a_ai_allies.size] = level.ava;
  }

  if(isDefined(level.ravenov)) {
    level.a_ai_allies[level.a_ai_allies.size] = level.ravenov;
  }

  level.var_98539610199d2422 flag_set("ava_arrived");
}

function function_a96ad3789e72a939(vh_chopper, str_anim) {
  vh_chopper scripts\common\scene::play(self, str_anim, "jup_cin_zm_vig_s0_act3_quest_ava_infil_exit");
  thread behavior_goto(level.var_98539610199d2422.var_11d2e045f1efdf0f.origin + (randomintrange(-300, 300), randomintrange(-300, 300), 0), 300);
  thread function_f6991c09ecd5b798();
}

function function_f6991c09ecd5b798() {
  function_7f18d1a95e354b02();
  scripts\common\ai::magic_bullet_shield();
  self.var_9f009877c3bea958 = 1;
  self.var_69b049cf4b18c73b = 1;
  self setscriptablepartstate("minimap", "active");

  if(!threatbiasgroupexists("ally_ai")) {
    createthreatbiasgroup("ally_ai");
  }

  self setthreatbiasgroup("ally_ai");
  self function_65cdab0fc78aba8f(self.origin, 3000);
  thread behavior_guard(level.var_98539610199d2422.var_11d2e045f1efdf0f.origin, 800);
}

function function_7f18d1a95e354b02() {
  if(isDefined(level.players[0])) {
    self.team = level.players[0].team;
  }
}

function function_1a18a6d6a5cee94d() {
  s_chopper = getStruct("chopper_victim", "targetname");
  s_goal = getStruct(s_chopper.target, "targetname");
  flag_wait("neutralizer_on");
  wait 7;
  flag_set("chopper_obj");
  self.vh_victim = function_804aa1cbd49ba400("veh_jup_hind", s_chopper, 0);

  if(isDefined(self.vh_victim)) {
    self.vh_victim thread function_2049da5e77063ab();
    self.vh_victim function_1080daa8e7a43c1d(s_goal);
    return;
  }

  wait 10;
  flag_set("deathworm_spawn");
  level flag_set("dw_approach");
}

function function_2049da5e77063ab() {
  level endon("dw_approach");
  self waittill("death");
  level flag_set("dw_approach");
}

function function_1080daa8e7a43c1d(s_goal) {
  self endon("death");
  self vehicle_setspeed(80, 40, 30);

  while(true) {
    if(isDefined(self.is_crashing)) {
      if(!isDefined(self.is_spinning)) {
        self.is_spinning = 1;
      } else {
        self setvehgoalpos(s_goal.origin, 0);
      }
    } else if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "fire") {
        self setvehgoalpos(s_goal.origin, 0);
      } else if(s_goal.script_noteworthy == "hover") {
        level flag_set("dw_approach");
        thread function_fa3a82932733eb0a();
        self setmaxpitchroll(45, 60);
        self setlookatent(level.var_98539610199d2422.e_neutralizer);
        self setvehgoalpos(s_goal.origin, 1);
      } else {
        self setvehgoalpos(s_goal.origin, 1);
      }
    } else {
      self setvehgoalpos(s_goal.origin, 0);
    }

    if(isDefined(self.is_crashing)) {
      wait 2;
    } else {
      self waittill("goal");
    }

    if(isDefined(s_goal.script_noteworthy)) {
      if(s_goal.script_noteworthy == "fire") {
        thread function_98c2f84917ad6342();
        self vehicle_setspeed(60, 40, 30);
      } else if(s_goal.script_noteworthy == "hover") {
        flag_set("deathworm_spawn");
        self setvehgoalpos(self.origin + (0, 0, 350), 1);
        level flag_wait("chopper_crash");
        thread chopper_spin(s_goal, 160);
        self.is_crashing = 1;
      }
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    break;
  }
}

function function_fa3a82932733eb0a() {
  self endon("death");
  var_50f71b2b6716d3a6 = getStruct("chopper_target_1", "targetname");
  var_50f71a2b6716d173 = getStruct("chopper_target_2", "targetname");
  e_target_1 = spawn_model("tag_origin", var_50f71b2b6716d3a6.origin);
  e_target_2 = spawn_model("tag_origin", var_50f71a2b6716d173.origin);

  if(isDefined(level.var_98539610199d2422.e_neutralizer)) {
    wait 5;
    self.rocket_side = "left";
    thread function_50446d8d9c77ea2e(e_target_1);
    wait 1;
    self.rocket_side = "right";
    thread function_50446d8d9c77ea2e(e_target_2);
  }
}

function function_7a6182b94b39e9ee(s_quest, v_org, v_ang) {
  n_riders = 1;

  for(i = 0; i < n_riders; i++) {
    str_aitype = array_random(s_quest.var_ee3ea8d303c9025c);
    ai_merc = namespace_2b1145f62aa835b8::spawnnewaitype_sharedfunc(str_aitype, v_org + (randomintrange(-10, 10), randomintrange(-10, 10), 0), v_ang, "team_hundred_ninety");
    waitframe();

    if(isDefined(ai_merc)) {
      ai_merc kill();
    }
  }
}

function chopper_spin(s_goal, speed) {
  self endon("death");
  self setmaxpitchroll(90, 120);
  self setyawspeed(600, 300);
  self setvehgoalpos(s_goal.origin, 0);
  self vehicle_setspeed(400, 100, 20);
  self clearlookatent();
  self dodamage(int(self.health * 0.5), self.origin);
  thread function_7a6182b94b39e9ee(level.var_98539610199d2422, self.origin, self.angles);
  ref = function_d93ec4635290febd();
  data = function_29b4292c92443328(ref);
  explosiondata = data.pristineexplosion;
  explosionposition = self gettagorigin(explosiondata.tag);
  playFX(getfx("chopper_explosion"), explosionposition, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(level.var_98539610199d2422.var_4118ca23a8b62b78)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.var_98539610199d2422.var_4118ca23a8b62b78);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function function_44e1fb35d5a39cc1() {
  flag_wait("deathworm_warn");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("defend_scrambler_zakhaev");
  }

  var_f261322cc6e930cb = getStruct("death_worm", "targetname");
  str_aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_deathworm_quest")[0];
  var_814b1ce165108544 = undefined;

  while(!isDefined(var_814b1ce165108544)) {
    var_814b1ce165108544 = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, var_f261322cc6e930cb.origin, (0, 35, 0), "team_two_hundred");
    waitframe();
  }

  var_814b1ce165108544 thread function_75b832fe9dfd7797();
}

function function_75b832fe9dfd7797() {
  self endon("death");
  asm::asm_setstate("emerge_attack_swallow");
  utility::function_3ab9164ef76940fd("audio", "emerge_sharkbite");
  earthquake(0.8, 1.5, self.origin, 5000);

  foreach(player in level.players) {
    player playRumbleOnEntity("artillery_rumble");
  }

  thread function_19f687607002ef81();
  namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");

  if(!threatbiasgroupexists("deathworm")) {
    createthreatbiasgroup("deathworm");
  }

  self setthreatbiasgroup("deathworm");
  setignoremegroup("ally_ai", "deathworm");
  setmusicstate("mx_ob_q3_boss");

  if(!threatbiasgroupexists("neutralizer_zombies")) {
    createthreatbiasgroup("neutralizer_zombies");
  }

  thread function_8b929ecbaad4582f();
  thread function_e2b79a69b7adcb1c();
  thread function_e2eb505173fb0a65();
  self waittill("swallow_in_air");
  level flag_set("chopper_crash");
  earthquake(0.8, 1, self.origin, 5000);

  foreach(player in level.players) {
    player playRumbleOnEntity("artillery_rumble");
  }

  wait 1;
  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.players);
  wait 2;
  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT3_DEFEAT_WORM", level.players);
}

function function_8b929ecbaad4582f() {
  self waittill("death");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("defeat_worm_zakhaev");
  }

  level notify("deathworm_dead");
  level thread function_962746693f32aa97();
  level thread function_4c3b4b4059b45fba();
}

function private function_19f687607002ef81() {
  self endon("death");
  self waittill("spittle_start");
  self.var_cfa89ff2e0efade1 = 1;

  while(self.health / self.maxhealth > 0.5) {
    wait 1;
  }

  self.var_cfa89ff2e0efade1 = 0;
}

function function_962746693f32aa97() {
  a_ai_zombies = getaiarray("team_two_hundred");

  foreach(ai_zombie in a_ai_zombies) {
    if(isalive(ai_zombie)) {
      ai_zombie kill();
    }
  }

  level.ravenov.ignoreme = 1;
  level.ravenov.ignoreall = 1;
  level.ava.ignoreme = 1;
  level.ava.ignoreall = 1;
}

function function_e2b79a69b7adcb1c() {
  self endon("death");

  while(true) {
    self waittill("emerge_from_ground");
    function_a668fa35458e61e3();
    thread function_1085884764c903c0();
  }
}

function function_a668fa35458e61e3() {
  self endon("death");
  a_s_pts = getStructArray("zombie_neutralizer", "targetname");
  a_s_spawns = sortbydistance(a_s_pts, self.origin);
  self.var_75fb15af31b0815c = [];

  for(i = 0; i < 9; i++) {
    self.var_75fb15af31b0815c[self.var_75fb15af31b0815c.size] = a_s_spawns[i];
  }
}

function function_1085884764c903c0() {
  self endon("death");
  n_max_active = function_ab65e0d9a8828ab2("neutralizer");
  level.var_b722fd5cac961153 = 0;

  while(true) {
    if(level.var_98539610199d2422.var_8947dd7e97fc5ea1 < n_max_active) {
      s_zombie = array_random(self.var_75fb15af31b0815c);

      if(isDefined(s_zombie)) {
        level.var_98539610199d2422.var_8947dd7e97fc5ea1++;
        ai_zombie = level.var_98539610199d2422 zombie_spawn(s_zombie, 1, 1);

        if(isDefined(ai_zombie)) {
          if(level.var_b722fd5cac961153 < 2) {
            level.var_b722fd5cac961153++;
            ai_zombie.var_2442daf1f2504be9 = 1;
          } else {
            ai_zombie setthreatbiasgroup("neutralizer_zombies");
            setignoremegroup("ally_ai", "neutralizer_zombies");
          }

          ai_zombie thread function_539b9a8c7e674d75(level.var_98539610199d2422);
        }
      }
    }

    wait 1;
  }
}

function vo_infil() {
  flag_wait("infil_start");
  wait 3;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_infil_1", level.players, 0, 0);
  s_entrance = getStruct("stronghold_entrance", "targetname");
  function_a5b76e0f5024cc9a(s_entrance, "approaching", 10500);
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_merc_helicopters", level.players, 0, 0);
}

function vo_container() {
  wait 2;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_container_zombies", level.players, 0, 0);
}

function function_a0c0fd784f3d1882() {
  level endon("facility_entered");
  proximity_watcher(getStruct("stronghold_entrance", "targetname"));
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_entry_approach", level.players, 0, 0);
  level.var_98539610199d2422 waittill("entrance_found");
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_clear_stronghold", level.players, 0, 0);
}

function function_d0b233de2e4f5720() {
  wait 1;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_plant_explosive", level.players, 0, 0);
  level.var_98539610199d2422 flag_wait("charge_exploded");
  wait 2;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_enricher_explodes", level.players, 0, 0);
}

function vo_airdrop() {
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_see_airdrop", level.players, 0, 0);
}

function function_601c9eb68a44a33() {
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_terminus_drop_33", level.players, 0, 0);
  wait 4;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_drop_site_choppers", level.players, 0, 0);
  wait 5;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_terminus_drop_66", level.players, 0, 0);
}

function function_262e81479efcd17a() {
  level.var_98539610199d2422 flag_wait("ava_arrived");
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_approach_drop_site", level.players, 0, 0);
  level.var_98539610199d2422 flag_wait("neutralizer_on");
  wait 2;
  scripts\cp_mp\overlord::playconversation("quest_s0a3t5_power_neutralizer", level.players, 0, 0);
  level.var_98539610199d2422 flag_wait("chopper_obj");
  wait 1.5;
  level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_neutralizer_helo", level.players, 0, 0);
  level flag_wait("dw_approach");
  scripts\cp_mp\overlord::playconversation("quest_s0a3t5_death_worm_arrival", level.players, 0, 0);
  wait 4;
  level.var_98539610199d2422 flag_set("deathworm_warn");
}

function function_e2eb505173fb0a65() {
  self endon("death");
  self.n_start_health = self.health;
  self.var_50fd23a0151b7f82 = int(self.n_start_health * 0.5);
  self.var_9465212fa2c7d453 = int(self.n_start_health * 0.1);

  while(true) {
    self waittill("damage");

    if(!isDefined(self.var_2911be99626c1c49)) {
      self.var_2911be99626c1c49 = 1;
      str_vo = function_d601c1decbbc86a7();

      if(isDefined(str_vo)) {
        level thread scripts\cp_mp\overlord::playevent(str_vo, level.players, 1);
      }
    }

    if(!isDefined(self.var_c9dbeab9ac3e2c9a) && self.health <= self.var_50fd23a0151b7f82) {
      self.var_c9dbeab9ac3e2c9a = 1;
      level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_boss_fight_50", level.players, 0, 0);
    }

    if(!isDefined(self.var_4a5dc763ed6d37c9) && self.health <= self.var_9465212fa2c7d453) {
      self.var_4a5dc763ed6d37c9 = 1;
      level thread scripts\cp_mp\overlord::playevent("quest_s0a3t5_defeat_zakhaev_success", level.players, 1);
    }
  }
}

function function_d601c1decbbc86a7() {
  var_68114aa2f03a9916 = ["quest_s0a3t5_boss_fight_start_soap", "quest_s0a3t5_boss_fight_start_greene"];
  return random(var_68114aa2f03a9916);
}

function merc_spawn(str_aitype) {
  ai_merc = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, self.origin, self.angles, "team_hundred_ninety");

  if(isDefined(ai_merc)) {
    return ai_merc;
  }
}

function behavior_goto(origin, n_radius) {
  self endon("death");
  self endon("reached");
  n_radius_sq = n_radius * n_radius;
  v_org = getclosestpointonnavmesh(origin);

  while(true) {
    if(distance2dsquared(v_org, self.origin) > n_radius_sq) {
      self setgoalpos(v_org);
    } else {
      self notify("reached");
    }

    wait 2;
  }
}

function behavior_guard(origin, n_radius) {
  self endon("death");
  self endon("combat");
  self endon("reviving");

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  if(isDefined(n_radius)) {
    n_goal_radius = n_radius;
  } else {
    n_goal_radius = 32;
  }

  while(true) {
    if(isDefined(origin) && distance2dsquared(origin, self.origin) > 4096) {
      scripts\mp\ai_behavior::function_304da84d9a815c01(origin, n_goal_radius, 1);
      self waittill("goal");
    }

    wait 2;
  }
}

function proximity_watcher(s_spot, n_radius) {
  if(isDefined(n_radius)) {
    n_dist = squared(n_radius);
  } else {
    n_dist = squared(s_spot.radius);
  }

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(distancesquared(s_spot.origin, player.origin) < n_dist) {
          return;
        }
      }
    }

    wait 0.1;
  }
}

function function_a5b76e0f5024cc9a(s_spot, str_notify, n_radius) {
  if(!isDefined(n_radius)) {
    n_dist = squared(int(s_spot.radius * 0.7));
  } else {
    n_dist = squared(n_radius);
  }

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(distance2dsquared(s_spot.origin, player.origin) < n_dist) {
          self notify(str_notify);
          return;
        }
      }
    }

    wait 0.1;
  }
}

function function_64fc67793461fff2(s_spot, str_notify, n_radius) {
  if(!isDefined(n_radius)) {
    n_dist = squared(int(s_spot.radius * 0.7));
  } else {
    n_dist = squared(n_radius);
  }

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(distance2dsquared(s_spot.origin, player.origin) > n_dist) {
          self notify(str_notify);
          return;
        }
      }
    }

    wait 0.1;
  }
}

function get_ai_type() {
  if(percent_chance(30)) {
    str_aitype = "jup_spawner_zombie_base_armored_heavy";
  } else if(percent_chance(25)) {
    str_aitype = "jup_spawner_zombie_base_armored_light";
  } else {
    str_aitype = "jup_spawner_zombie_base";
  }

  return str_aitype;
}

function zombie_death_watcher(s_quest) {
  self waittill("death");

  if(isDefined(s_quest.n_defend) && s_quest.n_defend > 0) {
    s_quest.n_defend--;
  }
}

function function_539b9a8c7e674d75(s_quest) {
  self waittill("death");

  if(isDefined(s_quest.var_8947dd7e97fc5ea1) && s_quest.var_8947dd7e97fc5ea1 > 0) {
    s_quest.var_8947dd7e97fc5ea1--;
  }

  if(isDefined(self.var_2442daf1f2504be9) && level.var_b722fd5cac961153 > 0) {
    level.var_b722fd5cac961153--;
  }
}

function function_4d201d5295b76e9e(s_quest) {
  self waittill("death");

  if(s_quest.n_zombies > 0) {
    s_quest.n_zombies--;
    s_quest.n_armored--;
  }
}

function function_fc70e8ce750f8776(s_quest) {
  self waittill("death");

  if(s_quest.var_d5b8ef36ed91386a > 0) {
    s_quest.var_d5b8ef36ed91386a--;
  }
}

function function_c506ee385d7c18cf(s_quest) {
  self waittill("death");

  if(s_quest.var_87da3b5200f9f001 > 0) {
    s_quest.var_87da3b5200f9f001--;
  }
}

function function_b584f143ed0ec5d0(origin, num_spots, n_radius) {
  var_f10d2bae0aa4fce7 = [];

  for(i = 0; i < num_spots; i++) {
    var_2a74fdb9fac967ff = randomintrange(n_radius * -1, n_radius + 1);
    var_2a74fcb9fac965cc = randomintrange(n_radius * -1, n_radius + 1);
    pos = origin + (var_2a74fdb9fac967ff, var_2a74fcb9fac965cc, 0);
    pos_on_navmesh = getclosestpointonnavmesh(pos);
    s_spot = spawnStruct();

    if(isDefined(s_spot)) {
      s_spot.origin = pos_on_navmesh;
      s_spot.angles = (0, 0, 0);
    }

    if(isDefined(pos_on_navmesh)) {
      var_f10d2bae0aa4fce7[var_f10d2bae0aa4fce7.size] = s_spot;
    }
  }

  return var_f10d2bae0aa4fce7;
}

function attack_player(n_radius) {
  self endon("death");

  while(true) {
    if(isDefined(level.players) && level.players.size) {
      player = getclosest(self.origin, level.players);

      if(isalive(player)) {
        if(!isDefined(n_radius)) {
          n_radius = distance2d(self.origin, player.origin) + 100;
        }

        self function_65cdab0fc78aba8f(player.origin, n_radius);
      }
    }

    wait 5;
  }
}

function ai_aware(n_radius) {
  self endon("death");

  while(true) {
    self function_65cdab0fc78aba8f(self.origin, n_radius);
    wait 3;
  }
}

function function_5e715be63f9f20de(var_b1a583aed2813bb7, n_spawns) {
  var_da3a55eabb666c32 = [];

  if(isstruct(var_b1a583aed2813bb7)) {
    s_spawner = var_b1a583aed2813bb7;
  } else {
    s_spawner = getStruct(var_b1a583aed2813bb7, "targetname");
  }

  var_f10d2bae0aa4fce7 = function_b584f143ed0ec5d0(s_spawner.origin, n_spawns, s_spawner.radius);
  var_ee3ea8d303c9025c = ["jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];

  for(i = 0; i < var_f10d2bae0aa4fce7.size; i++) {
    if(isDefined(var_f10d2bae0aa4fce7[i].script_noteworthy)) {
      str_aitype = "jup_ob_enemy_specialist_" + var_f10d2bae0aa4fce7[i].script_noteworthy;
    } else {
      str_aitype = array_random(var_ee3ea8d303c9025c);
    }

    aitype = getDvar(@ "hash_5254c3fbd200d7ee", str_aitype);
    ai_merc = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype, var_f10d2bae0aa4fce7[i].origin, var_f10d2bae0aa4fce7[i].angles, "team_hundred_ninety");

    if(isDefined(ai_merc)) {
      var_da3a55eabb666c32[var_da3a55eabb666c32.size] = ai_merc;

      if(isDefined(var_f10d2bae0aa4fce7[i].script_noteworthy) && var_f10d2bae0aa4fce7[i].script_noteworthy == "sniper") {
        ai_merc thread scripts\mp\ai_behavior::function_b11c1964f528574b(ai_merc, 1, var_f10d2bae0aa4fce7[i].origin);
        continue;
      }

      ai_merc thread scripts\mp\ai_behavior::function_9bbf1713a14fa580(ai_merc, 64, 32, var_f10d2bae0aa4fce7[i].origin);
    }
  }

  return var_da3a55eabb666c32;
}

function function_aa1b5db86c89322d(b_quest) {
  mdl_clip = getEnt("zombie_pen_clip", "targetname");

  if(!isDefined(mdl_clip)) {
    return;
  }

  if(b_quest) {
    mdl_clip movez(512, 1);
    return;
  }

  mdl_clip delete();
}

function function_f0d01ab513778a71(s_quest) {
  self endon("death");
  s_quest endon("alerted");

  while(true) {
    foreach(player in level.players) {
      if(isalive(player)) {
        if(function_59565896f06f1220(self, player)) {
          s_quest flag_set("alerted");
          s_quest notify("alerted");
          return;
        }
      }
    }

    wait 0.1;
  }
}

function function_8e7a3cfb8fc2d5df(s_quest) {
  self endon("death");
  waittill_any_4("damage", "bulletwhizby", "grenade danger", "gunshot");
  s_quest flag_set("alerted");
  s_quest notify("alerted");
}

function function_b628c2d5434b3cbc(s_quest) {
  self endon("death");
  s_quest flag_wait("alerted");
  self notify("startCombatRush");
  thread attack_player(3000);
}

function monitor_landing_zone(var_da3a55eabb666c32) {
  self endon("lz_cleared");
  thread function_962cd4f0b2c0e5fb();

  while(true) {
    var_da3a55eabb666c32 = array_removedead(var_da3a55eabb666c32);

    if(isDefined(var_da3a55eabb666c32)) {
      if(!var_da3a55eabb666c32.size) {
        flag_set("lz_cleared");
        self notify("lz_cleared");
      } else if(var_da3a55eabb666c32.size < 4) {
        flag_set("merc_attack");
      }
    }

    wait 1;
  }
}

function function_125fba683fe2c7db(s_quest) {
  self endon("death");
  s_quest flag_wait("merc_attack");
  thread merc_attack();
}

function merc_attack() {
  self endon("death");
  self endon("clear_attack");
  self endon("goal");
  self.goalradius = randomintrange(800, 1500);

  while(true) {
    player = getclosest(self.origin, level.players);

    if(isalive(player)) {
      pos_on_navmesh = getclosestpointonnavmesh(player.origin);

      if(isDefined(pos_on_navmesh)) {
        thread scripts\mp\ai_behavior::function_304da84d9a815c01(pos_on_navmesh, self.goalradius, 1);
      }
    }

    wait 8;
  }
}

function function_962cd4f0b2c0e5fb() {
  self endon("lz_cleared");
  wait 180;
  flag_set("lz_cleared");
  self notify("lz_cleared");
}

function zombie_spawn(s_pt, b_attack, b_anim) {
  str_aitype = get_ai_type();
  ai_zombie = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, s_pt.origin, s_pt.angles, "team_two_hundred", "difficulty_yellow");

  if(isDefined(ai_zombie) && ai_zombie function_8fa69650e33c84ef("spawn") && b_anim) {
    ai_zombie namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
    ai_zombie thread animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
  }

  waitframe();

  if(isalive(ai_zombie)) {
    ai_zombie namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
    level.var_98539610199d2422.n_zombies++;
    ai_zombie.team = "team_two_hundred";

    if(ai_zombie.agent_type == "actor_jup_spawner_zombie_base") {
      ai_zombie thread zombie_death_watcher(self);
    } else {
      level.var_98539610199d2422.n_armored++;
      ai_zombie thread function_4d201d5295b76e9e(self);
    }

    str_speed = "sprint";
    ai_zombie namespace_dd16d65e824b8e9::function_f1e5805da192a1ef(str_speed, "default", 26);

    if(isDefined(b_attack)) {
      ai_zombie thread attack_player(2000);
    }

    return ai_zombie;
  }
}

function function_7ea5453572655fab(s_loc, n_spawns, var_e6642530bf08708e, b_anim) {
  var_badfa29531597077 = [];
  var_f10d2bae0aa4fce7 = function_b584f143ed0ec5d0(s_loc.origin, n_spawns, s_loc.radius);

  for(i = 0; i < var_f10d2bae0aa4fce7.size; i++) {
    str_aitype = get_ai_type();
    ai_zombie = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, var_f10d2bae0aa4fce7[i].origin, var_f10d2bae0aa4fce7[i].angles, "team_two_hundred", "difficulty_yellow");

    if(isDefined(ai_zombie) && ai_zombie function_8fa69650e33c84ef("spawn") && b_anim) {
      ai_zombie thread animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
      ai_zombie namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
    }

    waitframe();

    if(isDefined(ai_zombie)) {
      ai_zombie namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
      var_badfa29531597077[var_badfa29531597077.size] = ai_zombie;
    }
  }

  return var_badfa29531597077;
}

function function_aa0d525c497e873c() {
  n_spawns = function_ab65e0d9a8828ab2("ground");

  foreach(s_spawner in getStructArray("zombie_proximity", "targetname")) {
    s_spawner thread function_a8219a727c620d1e(n_spawns);
  }
}

function function_a8219a727c620d1e(n_spawns) {
  v_forward = vectorNormalize(anglesToForward(self.angles)) * self.radius + self.origin;
  a_s_pts = function_b584f143ed0ec5d0(v_forward, n_spawns, self.radius);
  proximity_watcher(self);

  foreach(s_pt in a_s_pts) {
    level.var_98539610199d2422 zombie_spawn(s_pt, 0, 1);
  }
}

function on_zombie_ai_damaged(dmg_struct) {
  if(isDefined(dmg_struct.einflictor) && dmg_struct.einflictor.classname == "rocket") {
    if(percent_chance(40)) {
      if(isDefined(self.var_7050024e5f8ca246)) {
        self[[self.var_7050024e5f8ca246]]();
      }

      self kill();
      return;
    }

    if(percent_chance(40)) {
      function_bce021b0a87015f6(1);
      waitframe();
      self kill(self.origin, dmg_struct.einflictor, dmg_struct.einflictor, "MOD_PROJECTILE_SPLASH");
      return;
    }

    if(level.var_98539610199d2422.var_cf47493985378a8e < 7) {
      level.var_98539610199d2422.var_cf47493985378a8e++;
      zombie_fling(dmg_struct);
      return;
    }

    self kill(self.origin, dmg_struct.einflictor, dmg_struct.einflictor, "MOD_PROJECTILE_SPLASH");
  }
}

function zombie_fling(dmg_struct) {
  if(!isalive(self)) {
    return;
  }

  if(isDefined(self.b_flung)) {
    return;
  }

  self.b_flung = 1;
  v_dir = vectorNormalize(anglesToForward(dmg_struct.einflictor.owner.angles)) * randomintrange(25, 40) + dmg_struct.einflictor.owner.origin;
  v_launch = v_dir + (randomintrange(100, 500), 0, randomintrange(1000, 2500));
  self kill(dmg_struct.einflictor.origin, dmg_struct.einflictor, dmg_struct.einflictor, "MOD_PROJECTILE_SPLASH");
  waitframe();

  if(isDefined(self)) {
    e_corpse = self getcorpseentity();
  }

  if(isDefined(e_corpse)) {
    e_corpse startragdollfromimpact("torso_lower", v_launch);
    e_corpse thread ragdoll_monitor();
  }
}

function ragdoll_monitor() {
  while(isDefined(self)) {
    wait 1;
  }

  level.var_98539610199d2422.var_cf47493985378a8e--;
}

function function_4c3b4b4059b45fba() {
  setmusicstate("");
  level.battlechatterdisabled = 1;

  foreach(player in level.players) {
    if(scripts\mp\utility\player::isinlaststand(player)) {
      player namespace_f585f5e438cbdbc8::revive_player();
    }

    player setsoundsubmix("jup_ob_endgame");

    if(isalive(player)) {
      player val::set("exfil", "breath_system", 0);
      player val::set("exfil", "cg_drawcrosshair", 0);
      player val::set("exfil", "crouch", 0);
      player val::set("exfil", "damage", 0);
      player val::set("exfil", "gesture", 0);
      player val::set("exfil", "allow_jump", 0);
      player val::set("exfil", "killstreaks", 0);
      player val::set("exfil", "melee", 0);
      player val::set("exfil", "allow_movement", 0);
      player val::set("exfil", "offhand_weapons", 0);
      player val::set("exfil", "prone", 0);
      player val::set("exfil", "sprint", 0);
      player val::set("exfil", "supers", 0);
      player val::set("exfil", "usability", 0);
      player val::set("exfil", "weapon", 0);
      player val::set("exfil", "fire", 0);
      player val::set("exfil", "weapon_switch", 0);
      player val::set("exfil", "freezecontrols", 1);
      player val::set("exfil", "ignoreme", 1);
      player val::set("exfil", "show_weapon_hud", 0);
      level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
      player hidehudenable();
      player callback::callback("ob_act3_completed");
    }
  }

  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.players);
  namespace_134d54e39331ee45::ai_cleanup();
  wait 1;

  foreach(player in level.players) {
    if(isDefined(level.var_14a0183a6880d101)) {
      player[[level.var_14a0183a6880d101]]();
    }

    if(isalive(player)) {
      level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);
      player thread scripts\common\utility::letterbox_enable(1);
    }
  }

  play_movie("jup_ob_act3_cine_outro");
  level.battlechatterdisabled = 0;
  level thread namespace_134d54e39331ee45::function_bf01aba31e9023d1();
}

function play_movie(str_movie) {
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 10;
  videoname = str_movie;
  videoduration = 160;
  var_1bab87417f147c8f = 0;

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", var_8c6c2faac72ea626);
    player.var_59e5ea44ba5aff1 = 1;
  }

  playcinematicforall(videoname, 1, var_1bab87417f147c8f);
  wait videoduration;
  stopcinematicforall();

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", var_7848ff3f98ef4a73);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  }
}

function teleport_players(str_loc) {
  level flag_set("player_has_spawned");
  wait 3;
  var_f10d2bae0aa4fce7 = getStructArray(str_loc, "targetname");

  for(i = 0; i < level.players.size; i++) {
    level.players[i] setOrigin(var_f10d2bae0aa4fce7[i].origin);
    level.players[i] setplayerangles((0, 90, 0));
    level.players[i] flag_set("player_boarded");
    level.players[i] flag_set("players_unloaded");
  }

  thread function_b1aa1fb6109a052b();
}

function function_ce34466b3cece887() {
  ammo_mods = ["brainrot", "deadwire", "napalmburst", "cryofreeze", "shatterblast"];
  perks = ["specialty_juggernog", "specialty_quickrevive", "specialty_deadshot", "specialty_speedcola", "specialty_elemental_pop", "specialty_death_perception", "specialty_staminup"];
  supers = ["super_aether_shroud", "super_healing_aura", "super_frost_blast", "super_energy_mine", "super_frenzied_guard", "super_tesla_storm"];

  if(isDefined(self.has_power)) {
    return;
  }

  self.has_power = 1;
  self.platecarrierlevel = 2;
  self.maxarmorhealth = self.platecarrierlevel * level.var_4b78859bacc88808;
  waitframe();
  armor::setarmorhealth(self.maxarmorhealth);
  waitframe();
  armor::function_9c6e9a6643b6c9a6(3);
  waitframe();
  scripts\cp_mp\laststand::function_188085b8b8d431f2(1);
  waitframe();
  var_e1d199da4592fc05 = randomint(supers.size);
  perkpackage::perkpackage_givedebug(supers[var_e1d199da4592fc05]);
  waitframe();
  currency::function_3036cef61495210f("essence", 10000);
  waitframe();
  a_weapons = self getweaponslist("primary");

  foreach(weapon in a_weapons) {
    self takeweapon(weapon);
  }

  waitframe();
  fakeitem = spawnStruct();
  var_d7732d0238eae9ff = 240;
  item_entry = "ob_jup_item_weapon_ar_kilo53_blue";
  item_bundle = getscriptbundle("itemspawnentry:" + item_entry);
  item_scriptable = item_bundle.scriptable;
  fakeitem.count = common_item::function_7209c8cd4b2e3afd(var_d7732d0238eae9ff);
  common_item::function_7f6f62ba8dfd0da0(item_bundle, fakeitem);
  fakeitem = spawnStruct();
  var_d7732d0238eae9ff = 48;
  item_entry = "ob_jup_item_weapon_sh_mbravo_blue";
  item_bundle = getscriptbundle("itemspawnentry:" + item_entry);
  item_scriptable = item_bundle.scriptable;
  fakeitem.count = common_item::function_7209c8cd4b2e3afd(var_d7732d0238eae9ff);
  common_item::function_7f6f62ba8dfd0da0(item_bundle, fakeitem);
  wait 0.5;
  a_weapons = self getweaponslist("primary");

  for(i = 0; i < 2; i++) {
    pack_a_punch::pap_weapon(a_weapons[i], 1);
    waitframe();
    var_4bc27b790622bd85 = randomint(ammo_mods.size);
    ammo_mod::function_6c40f58b29a952a9(a_weapons[i], ammo_mods[var_4bc27b790622bd85]);
  }

  waitframe();
  zombie_perks::give_perk(perks[0], 0);
  wait 0.25;
  zombie_perks::give_perk(perks[1], 0);
  wait 0.25;
  zombie_perks::give_perk(perks[2], 0);
  wait 0.25;
  zombie_perks::give_perk(perks[3], 0);
  wait 0.25;
  zombie_perks::give_perk(perks[4], 0);
}

function function_a606113e8150b7e4(str_notify, musicstate) {
  self endon("end_music_watcher_" + str_notify);
  self waittill(str_notify);
  setmusicstate(musicstate);
}

function player_freeze(b_state) {
  val::set("exfil", "crouch", !b_state);
  val::set("exfil", "gesture", !b_state);
  val::set("exfil", "allow_jump", !b_state);
  val::set("exfil", "killstreaks", !b_state);
  val::set("exfil", "melee", !b_state);
  val::set("exfil", "offhand_weapons", !b_state);
  val::set("exfil", "prone", !b_state);
  val::set("exfil", "sprint", !b_state);
  val::set("exfil", "supers", !b_state);
  val::set("exfil", "usability", !b_state);
  val::set("exfil", "weapon", !b_state);
  val::set("exfil", "allow_movement", !b_state);
  val::set("exfil", "fire", !b_state);
  val::set("exfil", "weapon_switch", !b_state);
  val::set("exfil", "damage", !b_state);
  val::set("exfil", "ignoreme", b_state);
  self freezecontrols(b_state);
}