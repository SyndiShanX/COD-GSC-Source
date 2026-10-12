/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2e177f1d7a5b9456.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_3b78d23dad7ec5be;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using scripts\cp_mp\zombie_challenges;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_7534b1d3ac3ea47a;
#using script_7956d56c4922bd1;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\callbacks;
#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_b03ac398e745b619;

function function_923e85d3bf0ec24b() {
  function_89384091f7a2dbd("REV_OB_SABOTAGE", 0, &function_ab08c03a615a0cb4);
  function_89384091f7a2dbd("REV_OB_SABOTAGE", 1, &function_142dd8b75b609524);
  function_89384091f7a2dbd("REV_OB_SABOTAGE", 2, &function_ff106919e26008fe);
  function_89384091f7a2dbd("REV_OB_SABOTAGE", 3, &function_2a71141af11128b7);
  function_89384091f7a2dbd("REV_OB_SABOTAGE", 5, &function_12ab2881b64adb9b);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_SABOTAGE");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_SABOTAGE");
  function_8b5b2a3392fc7e2a("PlayerEnteredAwarenessZone", &function_9738f4c3207eeecd, "REV_OB_SABOTAGE");
  function_8b5b2a3392fc7e2a("PlayerAbandon", &function_540f9b357f3b5419, "REV_OB_SABOTAGE");
  scripts\engine\scriptable::scriptable_addnotifycallback("ae_landing_complete", &function_482dc13081f2f82);
  scripts\engine\scriptable::scriptable_addnotifycallback("ae_takeoff_complete", &function_d9f232af40634687);
  scripts\engine\scriptable::scriptable_addnotifycallback("aether_extractor_active", &function_69f745961864f7a3);
  scripts\engine\scriptable::scriptable_addnotifycallback("aether_extractor_disabled", &function_5b9c0d50066b9799);
}

function function_ab08c03a615a0cb4() {
  activityvariantdefinition = function_b9c4aa88ad97ee68(self);
  self.variant_definition = activityvariantdefinition;
  var_4c561dfa68aa0b08 = getStructArray(self.varianttag, "targetname");

  foreach(setup in var_4c561dfa68aa0b08) {
    self.var_4c561dfa68aa0b08 = function_6d6af8144a5131f1(self.var_4c561dfa68aa0b08, setup);
  }

  self.var_236d14e22e619c4 = 0;
  self.var_b9224694cb1be9 = [];
  self.str_group = self.varianttag + " " + self.id;
  [self.interact_struct] = getStructArray(self.varianttag, "script_noteworthy");
  self.var_575022c4aab8bff4 = [];
  self.shouldreinforce = 1;
  function_b6fc2c96b463c007(self);
}

function function_142dd8b75b609524() {
  level endon("game_ended");
  self notify("phone_used");
  self.on_mission = zombie_challenges::function_f578373042c34e16(16445, "quest_s0a2t4_heist_extstart_conv", self.playerparticipants);
  function_5c55a963e30c4568();
  function_3febd77882069bec();
  thread function_f469740a20ef8777();
  function_1ce44390c1941808();
  function_900a372a40986d3f();
  request_id = function_3ee36bc763779ba1(self.varianttag, 1, 0, 1, 2);
  radii = namespace_8480efeffcd6e233::function_5bbdc39a533d9d57(self, "Ambient_AI_Exclusion_Zone");
  function_5b9ffa6991e4d730(request_id, &function_8e5eba83ac0e12e5, [self, self.var_9046be937751609b, radii[0].radius]);
  function_3c85fe57dbc02e4e(request_id, &function_ea2e54093d2e1c1b, self);
  self.var_dcb639dfa56e091b = request_id;
  self.dummy_attacker = spawn("script_model", (0, 0, 0));
  self.dummy_attacker setModel("tag_origin");
  self.dummy_attacker.team = "civilian";
  msg = waittill_any_return_2("all_disabled", "countdown_finished");

  if(istrue(self.on_mission)) {
    cannister_collected = 0;

    foreach(player in self.playerparticipants) {
      if(istrue(player.var_8fb5cf84d3fec2ed)) {
        cannister_collected = 1;
      }
    }
  }

  if(msg == "all_disabled") {
    if(!self.on_mission) {
      thread function_1281c7fff9456e18("activity_sabotage_success");
    } else if(!cannister_collected) {
      foreach(player in self.playerparticipants) {
        player callback::callback("on_sabotage_success_nocannister");
      }
    } else {
      foreach(player in self.playerparticipants) {
        player callback::callback("on_sabotage_success_withcannister");
      }
    }

    endactivity(self, 1);
    return;
  }

  foreach(var_95f25c491d535550 in self.var_b9224694cb1be9) {
    var_95f25c491d535550.extractor setscriptablepartstate("trigger", "unusable");
  }

  foreach(player in self.playerparticipants) {
    player namespace_29b5250e9959ea::function_70946e24f54d3f1a("jup_hacking_device_ob");

    if(istrue(player.var_8fb5cf84d3fec2ed)) {
      cannister_collected = 1;
    }
  }

  if(!self.on_mission) {
    thread function_1281c7fff9456e18("activity_sabotage_failure");
  } else if(!cannister_collected) {
    foreach(player in self.playerparticipants) {
      player callback::callback("on_sabotage_failure_nocannister");
    }
  } else {
    thread function_1281c7fff9456e18("SABOTAGE_ACTIVITY_VO_FAILURE_FIRSTLINE");
  }

  foreach(player in self.playerparticipants) {
    function_4a508fcbbea05afd(player);
  }

  endactivity(self, 0);
}

function function_ff106919e26008fe() {
  self.shouldreinforce = 0;

  if(isDefined(self.var_dcb639dfa56e091b)) {
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(self.var_dcb639dfa56e091b);
  }

  foreach(s_root in self.var_b9224694cb1be9) {
    if(isDefined(s_root.request_id)) {
      scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(s_root.request_id);
    }

    if(s_root.extractor getscriptablepartstate("aether_extractor") == "warmup") {
      s_root.extractor thread function_607022f8dbd87fb7();

      if(isDefined(s_root.landing_pad)) {
        s_root.landing_pad thread function_cb956a4b213221cb();
      }

      if(isDefined(s_root.interact)) {
        s_root.interact delete();
      }
    }
  }

  if(isDefined(self.dummy_attacker)) {
    self.dummy_attacker delete();
    self.dummy_attacker = undefined;
  }
}

function function_89a7111bd154e223(structspawn) {
  self.trigger_ent = spawn("trigger_radius", structspawn.origin, 0, structspawn.radius, structspawn.height);
  thread watchplayertrigger(self.trigger_ent);
}

function watchplayertrigger(trigger) {
  self.extractor.activity_instance endon("activity_ended");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent)) {
      player = ent;
      player callback::callback("player_near_extractor");
    }
  }
}

function function_607022f8dbd87fb7() {
  radius = 300;
  players = getplayersinradius(self.origin, radius);

  foreach(player in players) {
    player knockback(player.origin - self.origin, radius * 90 / length(player.origin - self.origin));
  }

  start_pos = self.origin;
  end_pos = start_pos + (0, 0, 5000);
  start_angles = self.angles;
  takeoff_ae = spawn("script_model", start_pos);
  takeoff_ae setModel("jup_zm_aether_extractor_rocket_scriptable");
  takeoff_ae.angles = start_angles;

  while(!isDefined(takeoff_ae)) {
    waitframe();
  }

  takeoff_ae setscriptablepartstate("aether_extractor_ent", "takeoff");
  takeoff_ae moveTo(takeoff_ae.origin + (0, 0, 5000), 9, 3, 0);
  self setscriptablepartstate("aether_extractor", "hide");
  self setscriptablepartstate("screen_material", "screen_hidden");
}

function function_cb956a4b213221cb() {
  self setscriptablepartstate("vfx", "close");
  wait 3;
  self setscriptablepartstate("vfx", "mid");
  wait 2;
  self setscriptablepartstate("vfx", "far");
  wait 2;
  self setscriptablepartstate("vfx", "blank");
}

function function_2a71141af11128b7() {
  foreach(s_root in self.var_b9224694cb1be9) {
    if(isDefined(s_root.extractor)) {
      s_root.extractor setscriptablepartstate("aether_extractor", "hide");
    }

    if(isDefined(s_root.landing_pad)) {
      s_root.landing_pad setscriptablepartstate("model", "disabled");
    }

    if(isDefined(s_root.trigger_ent)) {
      s_root.trigger_ent delete();
    }

    namespace_64135de19550f047::function_486b0f579d5b6dae(s_root.active_cover);
  }

  if(isDefined(self.dummy_attacker)) {
    self.dummy_attacker delete();
    self.dummy_attacker = undefined;
  }
}

function function_12ab2881b64adb9b() {
  foreach(player in self.playerparticipants) {
    params = spawnStruct();
    params.player = player;
    callback::callback("aether_extractor_destroyed", params);
  }

  self.reward_struct.origin = self.reward_struct.origin + (0, 0, -20) + anglesToForward(self.reward_struct.angles + (0, 180, 0)) * 60;
  return self.reward_struct;
}

function function_1531bbf5cff97dc0(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;

  if(isDefined(self.var_b9224694cb1be9) && self.var_b9224694cb1be9.size > 0) {
    foreach(s_root in self.var_b9224694cb1be9) {
      if(isDefined(s_root.extractor)) {
        foreach(player in player_list) {
          s_root.extractor enablescriptableplayeruse(player);
        }
      }
    }
  }
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  if(isDefined(self.var_b9224694cb1be9) && self.var_b9224694cb1be9.size > 0) {
    foreach(s_root in self.var_b9224694cb1be9) {
      if(isDefined(s_root.extractor)) {
        foreach(player in player_list) {
          s_root.extractor disablescriptableplayeruse(player);
        }
      }
    }
  }
}

function function_9738f4c3207eeecd(var_b381b0883bcd4847) {
  self notify("initCountdown");
}

function function_540f9b357f3b5419(var_b381b0883bcd4847) {
  if(!self.on_mission) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_sabotage_cancelled", var_b381b0883bcd4847.playerlist);
  }

  foreach(player in var_b381b0883bcd4847.playerlist) {
    player callback::callback("on_abandon_sabotage_contract");
  }

  wait 0.2;

  foreach(player in var_b381b0883bcd4847.playerlist) {
    function_4a508fcbbea05afd(player);
  }
}

function private function_4a508fcbbea05afd(player) {
  if(function_5acc35fc66331385(player, 16445)) {
    player ent_flag_clear("quest_s0a2t4_heist_extstart_conv");
    player ent_flag_clear("quest_s0a2t4_heist_extcontractcancel");
    player ent_flag_clear("quest_s0a2t4_heist_extfailure_conv");
  }

  if(function_5acc35fc66331385(player, 16132)) {
    player ent_flag_clear("quest_s0a1t3_saboteur_start");
  }
}

function private function_5c55a963e30c4568() {
  self.var_9046be937751609b = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);
  var_78e63668e454888f = function_c9a98411e715c2f7(self.var_9046be937751609b);

  switch (var_78e63668e454888f) {
    case #"hash_af83e47edfa8900a":
      self.difficulty_settings = self.variant_definition.yellowdifficulty;
      break;
    case #"hash_5343b465e56ec9a4":
    case #"hash_651f76c0ad6741ec":
      self.difficulty_settings = self.variant_definition.var_27745d4ad204d462;
      break;
    case #"hash_7bb2cd766703d463":
    default:
      self.difficulty_settings = self.variant_definition.greendifficulty;
      break;
  }

  if(self.var_4c561dfa68aa0b08.size >= self.difficulty_settings.var_44bd8e9da18a644e) {
    self.var_e41aed3a07053b4f = self.difficulty_settings.var_44bd8e9da18a644e;
  } else {
    self.var_e41aed3a07053b4f = self.var_4c561dfa68aa0b08.size;
  }

  self.var_839a43fcca67a8ed = self.difficulty_settings.var_839a43fcca67a8ed;
}

function private function_c9a98411e715c2f7(location) {
  var_78e63668e454888f = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(location);

  if(var_78e63668e454888f == "difficulty_undefined") {
    var_78e63668e454888f = getDvar(@ "hash_de95b79f1cc2ed1", "difficulty_easy");
  }

  return var_78e63668e454888f;
}

function private function_900a372a40986d3f() {
  level endon("game_ended");
  self.var_4c561dfa68aa0b08 = array_randomize(self.var_4c561dfa68aa0b08);

  for(i = 0; i < self.var_e41aed3a07053b4f; i++) {
    self.var_b9224694cb1be9 = function_6d6af8144a5131f1(self.var_b9224694cb1be9, self.var_4c561dfa68aa0b08[i]);
    thread function_fb460cc13d5fa06b(self.var_4c561dfa68aa0b08[i]);
    wait 0.2;
  }
}

function private function_fb460cc13d5fa06b(s_root) {
  self endon("activity_ended");
  pos = getgroundposition(s_root.origin, 1);
  s_root.active_cover = namespace_64135de19550f047::function_e9158c9e8c391f25(s_root.script_noteworthy);
  a_pos = scripts\engine\utility::getStructArray(s_root.target, "targetname");

  foreach(pos in a_pos) {
    if(pos.script_label == "reward_struct") {
      s_root.reward_struct = pos;
      continue;
    }

    if(pos.script_label == "bomb_struct") {
      s_root.bomb_struct = pos;
    }
  }

  scriptables = getentitylessscriptablearray(s_root.target, "targetname");

  foreach(scriptable in scriptables) {
    if(scriptable.script_noteworthy == "scriptable_extractor") {
      s_root.extractor = scriptable;
    }

    if(scriptable.script_noteworthy == "scriptable_extractor_landing") {
      s_root.landing_pad = scriptable;
    }
  }

  if(isDefined(s_root.landing_pad)) {
    s_root.landing_pad setscriptablepartstate("model", "ae_landing");
    s_root.landing_pad thread function_9f48ea02d7ddacf4();
  }

  s_root.extractor.activity_instance = self;
  s_root.extractor.bomb_struct = s_root.bomb_struct;
  s_root.extractor.reward_struct = s_root.reward_struct;
  s_root.extractor.landing_pad = s_root.landing_pad;

  foreach(player in level.players) {
    s_root.extractor disablescriptableplayeruse(player);
  }

  foreach(player in self.playerparticipants) {
    s_root.extractor enablescriptableplayeruse(player);
  }

  namespace_64135de19550f047::function_daee52aa53ad6314(s_root.landing_pad.origin, 600);
  request_id = function_3ee36bc763779ba1(s_root.script_parameters, 1, 0, 1, 2);
  function_ce9c21523336cdbc(request_id, &function_8e5eba83ac0e12e5, [self, s_root.origin, 800]);
  s_root.request_id = request_id;
  s_root.extractor thread function_f4be15aae7f918c9();
  thread function_21f24af7d8f2e443(s_root.origin);
  trigger_struct = spawnStruct();
  trigger_struct.origin = s_root.origin;
  trigger_struct.radius = 500;
  trigger_struct.height = 500;
  s_root function_89a7111bd154e223(trigger_struct);
  namespace_29b5250e9959ea::function_3cec1b2981075936("jup_hacking_device_ob", s_root.extractor, &function_f290d3f882055a3c, undefined, &function_59ae620b2626f676, 4);
}

function private function_f4be15aae7f918c9() {
  landing_pos = self.origin;
  starting_pos = landing_pos + (0, 0, 3500);
  landing_angles = self.angles;
  landing_ae = spawn("script_model", starting_pos);
  landing_ae.active_ae = self;
  landing_ae setModel("jup_zm_aether_extractor_rocket_scriptable", landing_pos + (0, 0, 3500));
  landing_ae.angles = landing_angles;

  while(!isDefined(landing_ae)) {
    waitframe();
  }

  landing_ae moveTo(landing_pos, 6, 0, 5);
  thread function_bded3d00bf53c249(landing_pos, 300);
}

function private function_bded3d00bf53c249(pos, radius) {
  wait 4;
  vehicles = vehicle_getarrayinradius(pos, radius);

  foreach(vehicle in vehicles) {
    if(vehicle isvehiclehusk()) {
      vehicle function_e3ff0a92ad2bf58d();
      continue;
    }

    vehicle.dontspawnhusk = 1;
    vehicle function_9672da471530b44a();
  }

  wait 0.5;
  players = getplayersinradius(pos, radius);

  foreach(player in players) {
    player knockback(player.origin - pos, radius * 90 / length(player.origin - pos));
  }
}

function private function_482dc13081f2f82(scriptable, notif, params, instigator) {
  self.active_ae setscriptablepartstate("aether_extractor", "active");
  wait 0.2;
  self delete();
}

function private function_d9f232af40634687(scriptable, notif, params, instigator) {
  wait 0.2;
  self delete();
}

function private function_69f745961864f7a3(scriptable, notif, params, instigator) {
  if(!isDefined(scriptable.activity_instance)) {
    return;
  }

  foreach(root in scriptable.activity_instance.var_b9224694cb1be9) {
    if(root.extractor == scriptable) {
      activity_instance = scriptable.activity_instance;
      activity_instance thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();

      if(isDefined(level.var_7f1d1c7c6153a9bf) && [[level.var_7f1d1c7c6153a9bf]]()) {
        scriptable.activity_id = activity_instance function_36a95c9de2ace25a("extractor_marker_rift_run", 0, 1);
      } else {
        scriptable.activity_id = activity_instance function_36a95c9de2ace25a("extractor_marker", 0, 1);
      }

      scripts\mp\objidpoolmanager::update_objective_position(scriptable.activity_id, scriptable.bomb_struct.origin);

      if(isDefined(scriptable.landing_pad)) {
        scriptable.landing_pad setscriptablepartstate("model", "ae_landed");
      }

      scriptable setscriptablepartstate("trigger", "usable");
    }
  }
}

function private function_f290d3f882055a3c(player) {
  self setscriptablepartstate("aether_extractor", "overload");
  self setscriptablepartstate("trigger", "unusable");
  activity_instance = self.activity_instance;
  activity_instance.var_236d14e22e619c4++;
  activity_instance namespace_262d6474998a2356::function_c661dba3e304266b(activity_instance.var_236d14e22e619c4);
  activity_instance notify("one_sabotaged");
  activity_instance thread function_765b706dc170e214(self.activity_id);

  if(activity_instance.var_e41aed3a07053b4f - activity_instance.var_236d14e22e619c4 == 1) {
    activity_instance notify("one_extractor_left");
  }
}

function function_59ae620b2626f676(player) {
  player endon("interaction_complete");
  self setscriptablepartstate("screen_material", "screen_hacking");
  player waittill("cancel");
  self setscriptablepartstate("screen_material", "screen_active");
}

function function_7fc5185aadece0ad(player) {
  self waittill("one_disabled");
  params = spawnStruct();
  params.player = player;
  callback::callback("aether_extractor_destroyed", params);
}

function private function_5b9c0d50066b9799(scriptable, notif, params, instigator) {
  if(!isDefined(scriptable.activity_instance)) {
    return;
  }

  scriptable setscriptablepartstate("screen_material", "screen_hidden");

  foreach(root in scriptable.activity_instance.var_b9224694cb1be9) {
    if(root.extractor == scriptable) {
      activity_instance = scriptable.activity_instance;
      activity_instance function_3f0019081ff6b7e1(scriptable.bomb_struct);
      earthquake(0.4, 0.7, scriptable.bomb_struct.origin, 800);
      activity_instance notify("one_disabled");

      if(activity_instance.var_236d14e22e619c4 >= activity_instance.var_e41aed3a07053b4f) {
        if(issharedfuncdefined("ob_quest_missions", "onSabotageExtractorDisabled")) {
          [[getsharedfunc("ob_quest_missions", "onSabotageExtractorDisabled")]](activity_instance, scriptable);
        }
      }

      if(activity_instance.var_236d14e22e619c4 >= activity_instance.var_e41aed3a07053b4f) {
        activity_instance notify("all_disabled");
        activity_instance.reward_struct = scriptable.reward_struct;
        continue;
      }

      var_95b365e2882773f3 = ["SABOTAGE_ACTIVITY_DIALOG_DISABLED_1", "SABOTAGE_ACTIVITY_DIALOG_DISABLED_2", "SABOTAGE_ACTIVITY_DIALOG_DISABLED_3"];
      var_c574f8a20082fa67 = random(var_95b365e2882773f3);
    }
  }
}

function function_21f24af7d8f2e443(center) {
  self endon("activity_ended");
  self endon("extractor_destroy_prompt_triggered");
  self endon("one_sabotaged");
  var_e50147bc7c6e7ba6 = 0;

  while(true) {
    players = scripts\mp\utility\player::getplayersinradius(center, 170);

    if(players.size > 0) {
      var_e50147bc7c6e7ba6++;

      if(var_e50147bc7c6e7ba6 >= 10) {
        thread namespace_277c27ef297ef569::function_1281c7fff9456e18("SABOTAGE_ACTIVITY_VO_DESTROY_PROMPT");
        wait 1;
        self notify("extractor_destroy_prompt_triggered");
      }
    } else {
      var_e50147bc7c6e7ba6 = 0;
    }

    wait 1;
  }
}

function function_9f48ea02d7ddacf4() {
  self setscriptablepartstate("vfx", "far");
  wait 2;
  self setscriptablepartstate("vfx", "mid");
  wait 2;
  self setscriptablepartstate("vfx", "close");
  wait 2;
  self setscriptablepartstate("vfx", "blank");
}

function function_3f0019081ff6b7e1(explosion_source) {
  radius = 350;

  if(isDefined(self.dummy_attacker)) {
    radiusdamage(explosion_source.origin, radius, 100, 50, self.dummy_attacker, undefined, undefined, 0, 0);
  }

  foreach(ent in getplayersandaiarrayinradius(explosion_source.origin, radius)) {
    if(isPlayer(ent)) {
      ent knockback(ent.origin - explosion_source.origin, radius * 90 / length(ent.origin - explosion_source.origin));
      continue;
    }

    if(ent.team == "team_two_hundred") {
      ent knockdown_ai(explosion_source.origin);

      if(istrue(ent.disallow_knockdown) || !ent asmhasstate(ent.asmname, "knockdown_in")) {
        ent dodamage(self.var_839a43fcca67a8ed * 10, explosion_source.origin, self.dummy_attacker);
        continue;
      }

      ent dodamage(self.var_839a43fcca67a8ed, explosion_source.origin, self.dummy_attacker);
    }
  }
}

function function_fbd42d684f66806e(activityinstance) {
  activityinstance endon("activity_ended");
  self waittill("ae_sabotaged", player);
  activityinstance.var_575022c4aab8bff4 = array_removedead_or_dying(activityinstance.var_575022c4aab8bff4);

  foreach(soldier in activityinstance.var_575022c4aab8bff4) {
    if(isDefined(soldier) && isDefined(player)) {
      soldier setstealthstate("combat");
      soldier getenemyinfo(player);
    }
  }
}

function private function_f469740a20ef8777() {
  self endon("activity_ended");
  self waittill("initCountdown");
  self.var_141a4840cd4686d6 = 0;

  while(function_42a842295fe70a62(self) <= 0) {
    waitframe();
  }

  n_time_remaining = self.difficulty_settings.timelimit;
  missiontime = int(gettime() + function_a5b14435e3229bed(n_time_remaining));
  thread function_95f8d1b9f6685b61("SabotageTimer", n_time_remaining, &function_ed899763b14cd13c);
  function_7c6a95fad00519b0(n_time_remaining);
  self waittill("countdown_finished");
}

function function_ed899763b14cd13c(progress_tracker) {
  if(progress_tracker.currentprogressvalue / progress_tracker.startingprogressvalue <= 0.15 && !self.var_141a4840cd4686d6) {
    self notify("timer_low");
    self.var_141a4840cd4686d6 = 1;

    foreach(var_95f25c491d535550 in self.var_b9224694cb1be9) {
      if(var_95f25c491d535550.extractor getscriptablepartstate("aether_extractor") == "active") {
        var_95f25c491d535550.extractor setscriptablepartstate("aether_extractor", "warmup");
      }
    }
  }

  if(progress_tracker scripts\common\progress_tracker::iscomplete()) {
    if(self.var_236d14e22e619c4 >= self.var_e41aed3a07053b4f) {
      return;
    }

    self notify("countdown_finished");
  }
}

function function_8e5eba83ac0e12e5(request_id, userdata, agent, data) {
  activityinstance = userdata[0];
  activityinstance.var_575022c4aab8bff4 = array_add(activityinstance.var_575022c4aab8bff4, agent);
  agent thread function_e312b0c0acaf6800(userdata[1], userdata[2]);
  agent ent_flag_init("activity_sabotage_spawned");
}

function function_ea2e54093d2e1c1b(request_id, userdata, agent, data) {
  if(userdata.shouldreinforce) {
    return true;
  }

  return false;
}

function function_e312b0c0acaf6800(center, radius) {
  self endon("death");
  self function_65cdab0fc78aba8f(center, radius);
  function_134471b58eb3d915();
}

function private function_134471b58eb3d915() {
  if(isDefined(self.directorrequestid)) {
    requestdata = function_9a39e23c3c52c2af(self.directorrequestid);

    if(isDefined(requestdata)) {
      self setgoalpos(requestdata.origin, requestdata.radius);
    }
  }
}

function function_1ce44390c1941808() {
  thread function_dca867221a499442();

  switch (self.var_e41aed3a07053b4f) {
    case 4:
      var_ccfaad18a5501c24 = "SABOTAGE_ACTIVITY_VO_START_FOUR";
      var_6603b68a91b98209 = "SABOTAGE_ACTIVITY_VO_EXT_DOWN_FOUR";
      break;
    case 5:
      var_ccfaad18a5501c24 = "SABOTAGE_ACTIVITY_VO_START_FIVE";
      var_6603b68a91b98209 = "SABOTAGE_ACTIVITY_VO_EXT_DOWN_FIVE";
      break;
    default:
      var_ccfaad18a5501c24 = "SABOTAGE_ACTIVITY_VO_START_THREE";
      var_6603b68a91b98209 = "SABOTAGE_ACTIVITY_VO_EXT_DOWN_THREE";
      break;
  }

  thread function_31070f2e8c05719a(var_ccfaad18a5501c24, var_6603b68a91b98209);
}

function private function_31070f2e8c05719a(var_ccfaad18a5501c24, var_6603b68a91b98209) {
  self endon("activity_ended");

  foreach(player in self.playerparticipants) {
    player callback::callback("on_sabotage_start");
  }

  if(self.var_47187a65a8fb783d.size <= 0) {
    if(!self.on_mission) {
      namespace_277c27ef297ef569::function_1281c7fff9456e18(var_ccfaad18a5501c24);
    }
  } else {
    self notify("initCountdown");
  }

  self waittill("one_disabled");

  if(cointoss()) {
    namespace_277c27ef297ef569::function_1281c7fff9456e18(var_6603b68a91b98209);
    return;
  }

  self waittill("one_extractor_left");
  namespace_277c27ef297ef569::function_1281c7fff9456e18("SABOTAGE_ACTIVITY_VO_EXT_ONE_LEFT");
}

function private function_dca867221a499442(var_e321d8116d27f841) {
  self endon("activity_ended");
  self waittill("initCountdown");
  namespace_277c27ef297ef569::function_1281c7fff9456e18("SABOTAGE_ACTIVITY_VO_TIMER_START");
  self waittill("timer_low");
  namespace_277c27ef297ef569::function_1281c7fff9456e18("SABOTAGE_ACTIVITY_VO_TIMER_LOW");
}

function private function_3febd77882069bec() {
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_SABOTAGE");
}

function private function_7c6a95fad00519b0(n_time_remaining) {
  switch (self.var_e41aed3a07053b4f) {
    case 4:
      namespace_262d6474998a2356::function_716949a1eeeb1f47();
      waitframe();
      namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_SABOTAGE_FOUR_EXTRACTORS");
      break;
    case 5:
      namespace_262d6474998a2356::function_716949a1eeeb1f47();
      waitframe();
      namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_SABOTAGE_FIVE_EXTRACTORS");
      break;
    default:
      namespace_262d6474998a2356::function_716949a1eeeb1f47();
      waitframe();
      namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_SABOTAGE_THREE_EXTRACTORS");
      break;
  }

  namespace_262d6474998a2356::function_c661dba3e304266b(0);
  namespace_262d6474998a2356::function_474722293c221d5c(n_time_remaining);
}