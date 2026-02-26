/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1bf9ac5f65d7ecce.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_4ed3ce47;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::function_5e69f468(&_objective);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  audio::function_21f8b7c3();
  element_init();
  level.var_936dc3f3 = 0;
  function_5ea2c6e3("cp_ger_hub_plrfly_down", 0, 1);
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "adler":
      level.adler = ent;
      level.adler thread function_952e21e3(ent, name);
      level.adler waittill(#"death");
      level.adler = undefined;
      break;
    case # "lazar":
      level.lazar = ent;
      level.lazar thread function_952e21e3(ent, name);
      level.lazar waittill(#"death");
      level.lazar = undefined;
      break;
    case # "park":
      level.park = ent;
      level.park thread function_952e21e3(ent, name);
      level.park waittill(#"death");
      level.park = undefined;
      break;
    case # "sims":
      level.sims = ent;
      level.sims thread function_952e21e3(ent, name);
      level.sims waittill(#"death");
      level.sims = undefined;
      break;
    case # "hudson":
      level.hudson = ent;
      level.hudson thread function_952e21e3(ent, name);
      level.hudson waittill(#"death");
      level.hudson = undefined;
      break;
    case # "woods":
      level.woods = ent;
      level.woods thread function_952e21e3(ent, name);
      level.woods waittill(#"death");
      level.woods = undefined;
      break;
    case # "mason":
      level.mason = ent;
      level.mason thread function_952e21e3(ent, name);
      level.mason waittill(#"death");
      level.mason = undefined;
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69(name, "<dev string:x5d>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case # "$default":
      snd::set_element(trigger, trigger_name);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "post_takedown":
      setsoundcontext("visit", "post_takedown");
      level.var_28b99ea7 = "post_takedown";
      function_a269371b();
      break;
    case # "post_armada":
      setsoundcontext("visit", "post_armada");
      level.var_28b99ea7 = "post_armada";
      function_a269371b();
      break;
    case # "post_kgb":
      setsoundcontext("visit", "post_kgb");
      level.var_28b99ea7 = "post_kgb";
      function_a269371b();
      break;
    case # "post_cuba":
      setsoundcontext("visit", "post_cuba");
      level.var_28b99ea7 = "post_cuba";
      function_a269371b();
      break;
    case # "post_prisoner":
      setsoundcontext("visit", "post_prisoner");
      level.var_28b99ea7 = "post_prisoner";
      function_a269371b();
      break;
    case # "hash_1b78b54c338981ad":
      function_5ea2c6e3("cp_ger_hub8_submix", 0, 1);
      break;
    case # "hash_5c379cf8b486919b":
      function_ed62c9c2("cp_ger_hub8_submix", 1);
      break;
    case # "post_prisoner_burn_scene":
      setsoundcontext("visit", "post_prisoner_burn_scene");
      level.var_28b99ea7 = "post_prisoner_burn_scene";
      function_a269371b();
      break;
    case # "post_yamantau":
      setsoundcontext("visit", "post_yamantau");
      level.var_28b99ea7 = "yamantau";
      function_a269371b();
      break;
    case # "hash_774f81b7fe6ee1f6":
      audio::snd_set_snapshot("cp_ger_hub_evidenceboard_enter");
      break;
    case # "hash_3f89f51c820e2ec0":
      audio::snd_set_snapshot("");
      break;
    case # "hash_3e89d014789ae73b":
      audio::snd_set_snapshot("cp_ger_hub_arcade_machine");
      break;
    case # "hash_3992190071e0da2f":
      audio::snd_set_snapshot("");
      break;
    case # "snd_overlook_scene":
      thread function_34050dad();
      break;
    case # "hash_1e58e46360c0a83b":
      level notify(#"hash_1e58e46360c0a83b");
      break;
    case # "plane_startup":
      thread function_955f4842();
      break;
    case # "plane_idle":
      thread function_2d8bbe54(0.5);
      break;
    case # "start_plane_rev":
      thread function_e9cf99c1();
      break;
    case # "ambient_ext_override":
      thread function_26282537();
      break;
    case # "hash_6e37b7c047667b8e":
      thread function_eeb6e2e1();
      break;
    case # "ambient_override_return_to_normal":
      thread ambient_override_return_to_normal();
      break;
    case # "hash_72dc7d49e5a3096a":
      thread dia_focus_on();
      break;
    case # "hash_4f97009133f1b2dc":
      thread dia_focus_off();
      break;
    case # "hash_3031949ab2125e03":
      function_5af45515();
      break;
    case # "amb_armada":
      function_f4c3ff4f();
      break;
    case # "hash_5b6ae81610d69a78":
      function_d701d197();
      break;
    case # "hash_2a6c48d5e64b11f4":
      function_91962847();
      break;
    case # "hash_6fbdea34819cb7c5":
      function_351d940();
      break;
    case # "amb_prisoner":
      function_d3856f8a();
      break;
    case # "hash_4e3a33825e832ae6":
      function_ef8c9b18();
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  players = snd::function_da785aa8();
  player = players[0];
  level thread allies_init();

  switch (objective) {
    case # "chapter_selection":
      break;
    case # "post_takedown":
    case # "post_takedown_skip_briefing":
      level.var_28b99ea7 = "post_takedown";
      function_a269371b();
      break;
    case # "post_armada":
    case # "post_armada_skip_briefing":
      level.var_28b99ea7 = "post_armada";
      function_a269371b();
      snd::set_element(player, "thunder_int");
      break;
    case # "post_yamantau":
    case # "post_yamantau_skip_briefing":
      level.var_28b99ea7 = "post_yamantau";
      function_a269371b();
      break;
    case # "post_kgb":
    case # "post_kgb_skip_briefing":
      level.var_28b99ea7 = "post_kgb";
      function_a269371b();
      break;
    case # "post_cuba":
    case # "hash_6245569317a5039e":
      level.var_28b99ea7 = "post_cuba";
      function_a269371b();
      break;
    case # "post_prisoner":
    case # "hash_65bc9e5b3b128daf":
      level.var_28b99ea7 = "post_prisoner";
      function_a269371b();
      break;
    case # "post_prisoner_burn_scene":
      level.var_28b99ea7 = "post_prisoner_burn_scene";
      function_a269371b();
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>");

      break;
  }
}

function element_init() {
  thunder_int = [["emt_thunder_int_cp_ger_hub", (-64, -200, 60), [14, 21], 1800]];
  snd::element_init("thunder_int", thunder_int);
}

function allies_init() {
  if(!isarray(level.var_2de628a1)) {
    level.var_2de628a1 = [];
    level.var_2de628a1[#"adler"][#"default"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"default"] = [["attire", "casual"], ["footwear", "sneaker"]];
    level.var_2de628a1[#"park"][#"default"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"default"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"default"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"woods"][#"default"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"mason"][#"default"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"adler"][#"post_takedown"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_takedown"] = [["attire", "casual"], ["footwear", "sneaker"]];
    level.var_2de628a1[#"park"][#"post_takedown"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_takedown"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_takedown"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"adler"][#"post_armada"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_armada"] = [["attire", "winter"], ["footwear", "cowboy_boot"]];
    level.var_2de628a1[#"park"][#"post_armada"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_armada"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_armada"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"adler"][#"post_yamantau"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_yamantau"] = [["attire", "winter"], ["footwear", "cowboy_boot"]];
    level.var_2de628a1[#"park"][#"post_yamantau"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_yamantau"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_yamantau"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"adler"][#"post_kgb"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_kgb"] = [["attire", "winter"], ["footwear", "cowboy_boot"]];
    level.var_2de628a1[#"park"][#"post_kgb"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_kgb"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_kgb"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"woods"][#"post_kgb"] = [["attire", "casual"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"mason"][#"post_kgb"] = [["attire", "casual"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"adler"][#"post_cuba"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_cuba"] = [["attire", "tactical"], ["footwear", "cowboy_boot"]];
    level.var_2de628a1[#"park"][#"post_cuba"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_cuba"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_cuba"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"adler"][#"post_prisoner"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"lazar"][#"post_prisoner"] = [["attire", "winter"], ["footwear", "cowboy_boot"]];
    level.var_2de628a1[#"park"][#"post_prisoner"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
    level.var_2de628a1[#"sims"][#"post_prisoner"] = [["attire", "tactical"], ["footwear", "combat_boot"]];
    level.var_2de628a1[#"hudson"][#"post_prisoner"] = [["attire", "leather"], ["footwear", "dress_shoe"]];
  }

  level.var_dafd41b2 = [];
  snd::waitforplayers();

  while(!isDefined(level.adler)) {
    waitframe(1);
  }

  waittillframeend();
  level.var_dafd41b2[#"adler"] = level.adler;
  level.var_dafd41b2[#"lazar"] = level.lazar;
  level.var_dafd41b2[#"park"] = level.park;
  level.var_dafd41b2[#"sims"] = level.sims;
  level.var_dafd41b2[#"hudson"] = level.hudson;
  level.var_dafd41b2[#"woods"] = level.woods;
  level.var_dafd41b2[#"mason"] = level.mason;
  arrayremovevalue(level.var_dafd41b2, undefined, 1);
}

function function_952e21e3(ent, name) {
  self endon(#"death");

  while(!isDefined(level.var_28b99ea7)) {
    waitframe(1);
  }

  waittillframeend();
  visit = level.var_28b99ea7;
  contexts = level.var_2de628a1[name][visit];

  if(!isDefined(contexts)) {
    contexts = level.var_2de628a1[name][#"default"];
  }

  if(snd::function_81fac19d(!isarray(contexts), "allies_context_init '" + name + "' has no default context!")) {
    return;
  }

  foreach(context in contexts) {
    type = context[0];
    value = context[1];
    ent setsoundentcontext(type, value);
  }

  ent playSound(0, "fly_step_walk_npc_default");
}

function function_a269371b() {
  allies_init();

  if(isarray(level.var_dafd41b2)) {
    foreach(ally_name, ally in level.var_dafd41b2) {
      ally thread function_952e21e3(ally, ally_name);
    }
  }
}

function function_34050dad() {
  wait 5;
  audio::snd_set_snapshot("cp_tkdn_hit3_overlook_duk");
  level waittill(#"start_sniping");
  audio::snd_set_snapshot("");
}

function function_26282537() {
  forceambientroom("ext");
}

function function_eeb6e2e1() {
  forceambientroom("main_int");
}

function ambient_override_return_to_normal() {
  forceambientroom("");
}

function dia_focus_on() {
  while(!isDefined(level.sims)) {
    waitframe(1);
  }

  audio::snd_set_snapshot("cp_ger_hub_dia_focus");

  if(isalive(level.adler)) {
    level.adler function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.park)) {
    level.park function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.lazar)) {
    level.lazar function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.sims)) {
    level.sims function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.hudson)) {
    level.hudson function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.mason)) {
    level.mason function_9974c822("cp_ger_hub_dia_focus");
  }

  if(isalive(level.woods)) {
    level.woods function_9974c822("cp_ger_hub_dia_focus");
  }
}

function dia_focus_off() {
  while(!isDefined(level.sims)) {
    waitframe(1);
  }

  audio::snd_set_snapshot("");

  if(isalive(level.adler)) {
    level.adler function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.park)) {
    level.park function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.lazar)) {
    level.lazar function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.sims)) {
    level.sims function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.hudson)) {
    level.hudson function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.mason)) {
    level.mason function_5dcc74d1("cp_ger_hub_dia_focus");
  }

  if(isalive(level.woods)) {
    level.woods function_5dcc74d1("cp_ger_hub_dia_focus");
  }
}

function function_5af45515() {
  snd::play("emt_cp_ger_hub_ham_radio_scanner", (-118, 153, 61));
  snd::play("emt_cp_ger_hub_tape_mach_interview", (-306, 167, 56));
  snd::play("evt_tape_machine_reels_lp", (-292, 101, 60));
  snd::play("vox_cp_ger_hub_radio_park_surveillance_01", (-287, 102, 49));
  snd::play("evt_fluorescent_light", (-240, -1108, 118));
  snd::play("evt_fluorescent_light", (-240, -810, 118));
  snd::play("evt_fluorescent_light", (-81, -577, 145));
  snd::play("evt_fluorescent_light", (76, -580, 146));
  snd::play("evt_fridge_hum_low", (-63, 177, 10));
  snd::play("emt_generator_room_tone_cp_ger_hub_lp", (-362, 463, -80));
  snd::play("emt_fan_industrial_cp_ger_hub_lp", (-257, 415, 145));
  snd::play("emt_safehouse_night_crickets_lp", (302, -395, 72));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [14, 15, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [14, 15, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [16, 17, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [14, 15, 10, 18]);
}

function function_f4c3ff4f() {
  snd::play("emt_cp_ger_hub_ham_radio_scanner", (-118, 153, 61));
  snd::play("emt_cp_ger_hub_tape_mach_interview", (-306, 167, 56));
  snd::play("evt_tape_machine_reels_lp", (-292, 101, 60));
  snd::play("vox_cp_ger_hub_radio_park_surveillance_03", (-287, 102, 49));
  snd::play("evt_fluorescent_light", (-240, -1108, 118));
  snd::play("evt_fluorescent_light", (-240, -810, 118));
  snd::play("evt_fluorescent_light", (-81, -577, 145));
  snd::play("evt_fluorescent_light", (76, -580, 146));
  snd::play("evt_fridge_hum_low", (-63, 177, 10));
  snd::play("emt_generator_room_tone_cp_ger_hub_lp", (-362, 463, -80));
  snd::play("emt_rain_garage_door_int_lp", (286, -204, 60));
  snd::play("emt_rain_metal_door_half_open_int_lp", (279, -389, 5));
  snd::play("emt_rain_metal_door_closed_int_lp", (-228, -1532, 54));
  snd::play("evt_fan_portable_idle_armada_lp", (73, 61, 54));
  snd::play("evt_fan_portable_idle_armada_lp", (94, 567, 56));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [14, 15, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [14, 15, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [16, 17, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [14, 15, 10, 18]);
}

function function_d701d197() {
  snd::play("emt_fan_industrial_cp_ger_hub_lp", (-257, 415, 145));
  snd::play("emt_generator_room_tone_cp_ger_hub_lp", (-362, 463, -80));
  snd::play("evt_fan_portable_idle_armada_lp", (73, 61, 54));
  snd::play("evt_fan_portable_idle_armada_lp", (94, 567, 56));
  snd::play("evt_fridge_hum_low", (-63, 177, 10));
  snd::play("emt_safehouse_morning_birds_lp", (302, -395, 72));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [27, 30, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [27, 30, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [27, 30, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [27, 30, 10, 18]);
}

function function_91962847() {
  snd::play("emt_fan_industrial_cp_ger_hub_lp", (-257, 415, 145));
  snd::play("emt_generator_room_tone_cp_ger_hub_lp", (-362, 463, -80));
  snd::play("evt_fridge_hum_low", (-63, 177, 10));
  snd::play("evt_fluorescent_light", (-240, -1108, 118));
  snd::play("evt_fluorescent_light", (-240, -810, 118));
  snd::play("evt_fluorescent_light", (-81, -577, 145));
  snd::play("emt_projector_idle_lp", (72, 261, 46));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [14, 15, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [14, 15, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [16, 17, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [14, 15, 10, 18]);
}

function function_351d940() {
  snd::play("emt_cp_ger_hub_ham_radio_scanner", (-118, 153, 61));
  snd::play("emt_cp_ger_hub_tape_mach_interview", (-306, 167, 56));
  snd::play("evt_tape_machine_reels_lp", (-292, 101, 60));
  snd::play("evt_fluorescent_light", (-240, -1108, 118));
  snd::play("evt_fluorescent_light", (-240, -810, 118));
  snd::play("evt_fluorescent_light", (-81, -577, 145));
  snd::play("evt_fluorescent_light", (76, -580, 146));
  snd::play("evt_fridge_hum_low", (-63, 177, 10));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [14, 15, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [14, 15, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [16, 17, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [14, 15, 10, 18]);
}

function function_d3856f8a() {
  snd::play("evt_fan_portable_idle_armada_lp", (73, 61, 54));
  snd::play("emt_fan_industrial_cp_ger_hub_lp", (-257, 415, 145));
  snd::play("emt_generator_room_tone_cp_ger_hub_lp", (-362, 463, -80));
  snd::play("emt_safehouse_night_crickets_lp", (302, -395, 72));
}

function function_ef8c9b18() {
  snd::play("evt_fan_portable_idle_armada_lp", (73, 61, 54));
  snd::play("emt_fire_messageboard_hvy_01_lp", (42, 90, 15));
  snd::play("emt_fire_wood_hvy_01_lp", (-395, -275, 14));
  snd::play("emt_fire_wood_med_01_lp", (-281, 100, 47));
  snd::emitter("emt_safehouse_garage_door_rattles", (281, -161, 123), [14, 15, 8, 14]);
  snd::emitter("emt_safehouse_metal_building_groans", (-253, 560, 334), [14, 15, 8, 17]);
  snd::emitter("emt_safehouse_metal_building_groans", (73, -512, 286), [16, 17, 9, 16]);
  snd::emitter("emt_safehouse_metal_building_groans", (-789, -176, 283), [14, 15, 10, 18]);
}

function function_cb00a128() {
  var_18dbd2db = snd::play("quad_tkd_af_dist_plane_wash_front_lp", 2);
  level waittill(#"hash_1e58e46360c0a83b");
  snd::stop(var_18dbd2db, 2);
}

function function_755bfc95() {
  walla = snd::play("emt_tkd_walla_plane_workers_temp", [level.var_a7c3bf6d, "tag_origin"]);
  loaders = snd::play("emt_tkd_cargo_loading_vehicles_lp", [level.var_a7c3bf6d, "tag_origin"]);
  level waittill(#"hash_1e58e46360c0a83b");
  snd::stop(walla, 2);
  snd::stop(loaders, 2);
}

function function_913d2991() {
  wait 1.5;
  var_913d2991 = snd::play("emt_tkd_walla_runway_panic_temp", (-49618, -55463, -25053));
}

function function_955f4842() {
  wait 5;
  start = snd::play("veh_tkd_af_cargo_plane_start", [level.var_a7c3bf6d, "tag_origin"]);
  thread function_2d8bbe54(2);
}

function function_2d8bbe54(wait_time) {
  wait_time = snd::function_ea2f17d1(wait_time, 0.5);
  level.var_abe3f688 = snd::play("veh_tkd_af_cargo_plane_idle_lp", [level.var_a7c3bf6d, "tag_origin"]);
  snd::set_volume(level.var_abe3f688, 0);
  snd::set_pitch(level.var_abe3f688, 1);
  thread function_755bfc95();
  thread function_cb00a128();
  wait wait_time;
  snd::set_volume(level.var_abe3f688, 1, 0.5);
  level waittill(#"hash_1c43601f4e93efcd");
  snd::stop(level.var_abe3f688, 5);
}

function function_e9cf99c1() {
  snd::set_pitch(level.var_abe3f688, snd::function_d8b24901(8), 1);
  snd::play("veh_tkd_af_cargo_plane_accelerate", [level.var_a7c3bf6d, "tag_origin"]);
}