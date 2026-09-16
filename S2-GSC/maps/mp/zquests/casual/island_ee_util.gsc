/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\casual\island_ee_util.gsc
*****************************************************/

init_util() {
  level.preplaced_turrets = [];
  level.cuttable_ropes = [];
  thread init_ropes();
  thread init_bomber_doors();
  thread init_freezer_zombie_manager();
  thread init_spine_collection_manager();
  thread init_artillery_cannon();
  thread init_buildable_turrets();
}

init_ropes() {
  var_00 = common_scripts\utility::func_44BE("beach_rope_cut", "targetname");
  var_01 = spawnStruct();
  var_02 = [];
  var_03 = [];
  foreach(var_05 in var_00) {
    switch (var_05.script_noteworthy) {
      case "rope":
        var_01.rope = var_05;
        break;

      case "rope_box":
        var_01.my_box = var_05;
        break;

      case "rope_landing_point":
        var_01.landing_point = var_05;
        break;

      case "rope_final_point":
        var_01.final_point = var_05;
        break;

      case "art":
        var_01.art = var_05;
        break;

      case "body":
        var_01.var_18A8 = var_05;
        break;

      case "healthy_scaffolding":
        var_02 = common_scripts\utility::func_F6F(var_02, var_05);
        break;

      case "dead_scaffolding":
        var_03 = common_scripts\utility::func_F6F(var_03, var_05);
        break;

      case "impale":
        var_01.impale = var_05;
        break;
    }
  }

  var_01.var_18A8 hide();
  var_01.rope hide();
  var_01.my_box hide();
  var_01.art hide();
  var_01.impale hide();
  var_07 = getEnt("zmb_island_plane_crash_strap", "targetname");
  var_07 hide();
  foreach(var_09 in var_03) {
    var_09 hide();
  }

  common_scripts\utility::func_3C9F(lib_0557::func_7838("Flak Tower", "Defend Flak Tower"));
  var_07 show();
  var_01.rope show();
  var_01.my_box show();
  var_01.art show();
  var_01.var_18A8 show();
  var_01.impale show();
  foreach(var_09 in var_02) {
    var_09 hide();
  }

  foreach(var_09 in var_03) {
    var_09 show();
  }

  var_01 thread run_rope_cut();
}

run_rope_cut() {
  var_00 = common_scripts\utility::func_46B5("rope_landing_point", "script_noteworthy");
  self.rope setCanDamage(1);
  for(;;) {
    self.rope waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isDefined(var_0A)) {
      continue;
    }

    if(issubstr(var_0A, "razergun_zm") || issubstr(var_0A, "razergun_pap_zm")) {
      break;
    }
  }

  self.rope delete();
  lib_0557::func_782D("Flak Tower", "Find crashed plane");
  var_0B = common_scripts\utility::func_46B5("rope_landing_scripted_node", "targetname");
  self.my_box method_8495("s2_zom_radio_drop", var_0B.origin, common_scripts\utility::func_98E7(isDefined(var_0B.angles), var_0B.angles, (0, 0, 0)), "radio_anim");
  self.my_box lib_0378::func_8D74("radio_part_drops");
  wait(getanimlength(%s2_zom_radio_drop));
  self.my_box lib_0547::func_AC41(&"zombie_island_radio_part_pickup", undefined, self.my_box gettagorigin("Backpack_01_lod0") + (0, 0, 16));
  self.my_box waittill("player_used", var_0C);
  self.my_box lib_0547::func_AC40();
  self.my_box delete();
  var_0C thread lib_0367::func_8E3C("radioparttwo", level.players);
  maps / mp / zquests / casual / island_ee_main::set_radio_part_2_found();
}

drop_strap() {
  var_00 = getEnt("zmb_island_plane_crash_strap", "targetname");
  var_00 gravitymove((0, 0, 0), 10);
  var_00 rotateby((20, 20, 20), 10);
}

get_parachute_ropes() {
  var_00 = spawnStruct();
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  return var_00;
}

init_usable_bombs() {
  level thread run_bomb_listener();
}

run_bomb_listener() {
  for(;;) {
    wait(0.125);
    if(!isDefined(level.var_393E)) {
      continue;
    }

    foreach(var_01 in level.var_393E) {
      if(!common_scripts\utility::func_562E(var_01.bombusableenabled)) {
        var_01.bombusableenabled = 1;
        var_01 lib_0547::func_AC41("pickup explosive", (0, 0, 16));
        var_01 thread pickup_bomb();
      }
    }
  }
}

pickup_bomb() {
  for(;;) {
    self waittill("player_used", var_00);
    if(!common_scripts\utility::func_562E(var_00.iscarryingbomberbomb)) {
      var_00.iscarryingbomberbomb = 1;
      break;
    } else {}
  }

  lib_0547::func_AC40();
  self delete();
  var_00.iscarryingbomberbomb = 1;
}

init_bomber_doors() {
  var_00 = common_scripts\utility::func_46B7("bomber_door", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    var_02.door_pieces = [];
    var_02.bomb_placements = [];
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "razergun_door":
          var_02.door_pieces = common_scripts\utility::func_F6F(var_02.door_pieces, var_05);
          break;

        case "razergun_door_target":
          var_02.bomb_target = var_05;
          break;

        case "bomb_door_usable":
          var_02.bomb_trigger = var_05;
          break;

        case "bomb_door_placements":
          var_02.bomb_placements = common_scripts\utility::func_F6F(var_02.bomb_placements, var_05);
          break;
      }
    }
  }

  var_08 = common_scripts\utility::func_46B7("bomber_door", "targetname");
  foreach(var_02 in var_08) {
    var_02 thread run_bomber_door();
  }
}

run_bomber_door() {
  wait_for_door_destroyed();
  self.bomb_target delete();
  foreach(var_01 in self.door_pieces) {
    var_01 connectpaths();
    var_01 delete();
  }
}

wait_for_door_destroyed() {
  self endon("force_open");
  for(;;) {
    self.bomb_trigger waittill("trigger", var_00);
    if(common_scripts\utility::func_562E(var_00.iscarryingbomberbomb)) {
      break;
    }
  }

  var_01 = common_scripts\utility::func_7A33(self.bomb_placements);
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel("zom_bomb");
  var_02.angles = var_01.angles;
  var_02 setCanDamage(1);
  var_02 waittill("damage");
  var_02 delete();
}

init_freezer_zombie_manager() {
  level.freezer_crane = freezer_setup_crane();
  level.freezer_crane thread freezer_zombie_think();
  level.freezer_crane thread freezer_crane_anim_think();
}

freezer_setup_crane() {
  var_00 = getEnt("mdl_freezer_crane", "targetname");
  var_00.var_830E = common_scripts\utility::func_46B5("struct_freezer_anim_node", "targetname");
  var_00.var_931A = "idling";
  var_00 common_scripts\utility::func_3799("ent_flag_crane_retrieving");
  return var_00;
}

freezer_crane_anim_think() {
  for(;;) {
    for(;;) {
      self method_8495("s2_zom_gate_spawn_idle_harness", self.var_830E.origin, self.var_830E.angles, "freezer_crane");
      self waittillmatch("end", "freezer_crane");
      if(self.var_931A != "idling") {
        break;
      }
    }

    thread start_runner_lights();
    common_scripts\utility::func_379A("ent_flag_crane_retrieving");
    lib_0378::func_8D74("freezer_crane_retrieving");
    self.var_931A = "retrieving";
    wait 0.05;
    wait 0.05;
    wait 0.05;
    self method_8495("s2_zom_gate_spawn_intro_harness", self.var_830E.origin, self.var_830E.angles, "freezer_crane");
    self waittillmatch("end", "freezer_crane");
    self method_8495("s2_zom_gate_spawn_exit_harness", self.var_830E.origin, self.var_830E.angles, "freezer_crane");
    self waittillmatch("end", "freezer_crane");
    thread stop_runner_lights();
    self.var_931A = "idling";
    common_scripts\utility::func_3796("ent_flag_crane_retrieving");
  }
}

start_runner_lights() {
  var_00 = function_021F("on1", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "off");
    wait(2.5);
    var_02 setscriptablepartstate("lightpart", "flicker");
  }

  var_04 = function_021F("on2", "targetname");
  foreach(var_06 in var_04) {
    wait(0.04);
    var_06 setscriptablepartstate("lightpart", "off");
    wait(2);
    var_06 setscriptablepartstate("lightpart", "flicker02");
  }

  var_08 = function_021F("on3", "targetname");
  foreach(var_0A in var_08) {
    wait(0.12);
    var_0A setscriptablepartstate("lightpart", "off");
    wait(1.6);
    var_0A setscriptablepartstate("lightpart", "flicker02");
  }
}

stop_runner_lights() {
  var_00 = function_021F("on1", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "on");
  }

  wait(0.02);
  var_04 = function_021F("on2", "targetname");
  foreach(var_06 in var_04) {
    wait(0.04);
    var_06 setscriptablepartstate("lightpart", "on");
  }

  wait(0.1);
  var_08 = function_021F("on3", "targetname");
  foreach(var_0A in var_08) {
    wait(0.04);
    var_0A setscriptablepartstate("lightpart", "on");
  }
}

freezer_zombie_think() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = ["zmb_isla_monk_pridefillsthemotherseyesw", "zmb_isla_monk_strengthwithoutfaithwitho"];
  var_03 = ["zmb_isla_monk_findtheruntofthelitterala", "zmb_isla_monk_guidetheblindsontosightto"];
  var_04 = ["zmb_isla_monk_findtheyoungestsonthechil"];
  for(;;) {
    level waittill("freezeer_summon_zombie", var_05);
    if(!isDefined(var_05) || common_scripts\utility::func_3C77("flag_crane_in_motion") || level.freezer_crane.var_931A == "request_retrieve") {
      wait 0.05;
      continue;
    }

    var_00 = common_scripts\utility::func_46B5("freezer_harness_spawner", "targetname");
    var_06 = undefined;
    var_07 = undefined;
    switch (var_05) {
      case "escort_bomber":
        var_01 = "zombie_exploder";
        var_06 = ::maps / mp / zquests / casual / island_ee_main::setup_escort_bomber;
        var_07 = "flag_hc_bomb_escort_complete";
        break;

      case "hc_pest":
        var_01 = "zombie_berserker";
        var_06 = ::maps / mp / zquests / hardcore / island_ee_hc::pest_hc_zombie_setup;
        var_07 = "zmb_hc_pest_destination";
        maps\mp\_utility::func_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::func_7A33(var_03), 1, var_07);
        break;

      case "hc_assassin":
        var_00 = common_scripts\utility::func_46B5("assassin_escort_spawner", "targetname");
        var_01 = "zombie_assassin";
        var_06 = ::maps / mp / zquests / hardcore / island_ee_hc::assassin_hc_zombie_setup;
        var_07 = "flag_hc_asn_escort_complete";
        maps\mp\_utility::func_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::func_7A33(var_04), 1, var_07);
        break;

      case "hc_follower":
        var_01 = "zombie_heavy";
        var_06 = ::maps / mp / zquests / hardcore / island_ee_hc::wustling_hc_zombie_setup;
        var_07 = "zmb_hc_follower_destination";
        maps\mp\_utility::func_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::func_7A33(var_02), 1, var_07);
        break;

      case "hc_zombie":
        var_01 = "zombie_generic";
        var_06 = ::maps / mp / zquests / hardcore / island_ee_hc::zombie_hc_zombie_setup;
        var_07 = "players_spawned_statue_piece_2";
        break;

      default:
        break;
    }

    if(!isDefined(var_00)) {
      return;
    }

    var_08 = spawn_an_escort_zombie(var_01, var_00, var_06, var_07);
    level.freezer_crane freezer_crane_retrieve_zombie_anim(var_08, var_00);
  }
}

spawn_an_escort_zombie(param_00, param_01, param_02, param_03) {
  var_04 = lib_054D::func_90BA(param_00, param_01, "freezer_zombie", 0, 0, 0);
  var_04.isfreezerzombie = 1;
  if(isDefined(param_02)) {
    if(!isDefined(param_03) || isDefined(param_03) && !common_scripts\utility::func_3C77(param_03)) {
      var_04[[param_02]]();
    }
  }

  return var_04;
}

freezer_crane_retrieve_zombie_anim(param_00, param_01) {
  var_02 = self.var_830E;
  param_00 scragentsetscripted(1);
  param_00 method_839D("noclip");
  param_00 method_839C("anim deltas");
  param_00 scragentsetorientmode("face angle abs", param_01.angles);
  param_00 maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "freezer spawn");
  param_00.var_509A = 1;
  param_00.ignoreall = 1;
  param_00.var_480F = 1;
  var_03 = param_00 maps / mp / agents / _scripted_agent_anim_util::func_434D("scripted_harness_spawn");
  var_04 = param_00 method_83D8(var_03, 0);
  var_05 = getstartorigin(var_02.origin, var_02.angles, var_04);
  var_06 = getstartangles(var_02.origin, var_02.angles, var_04);
  level.freezer_crane.var_931A = "request_retrieve";
  level.freezer_crane common_scripts\utility::func_379C("ent_flag_crane_retrieving");
  common_scripts\utility::func_3C8F("flag_crane_in_motion");
  param_00 setOrigin(var_05);
  param_00.angles = var_06;
  if(lib_0547::func_5565(level.escort_bomber, param_00)) {
    param_00 exploder_run_big_uber_fx();
  }

  param_00 maps / mp / agents / _scripted_agent_anim_util::func_71FD(var_03, 0, "scripted_anim");
  param_00 maps / mp / agents / _scripted_agent_anim_util::func_71FD(var_03, 2, "scripted_anim");
  level notify("freezer_zombie_placed", param_00);
  common_scripts\utility::func_3C7B("flag_crane_in_motion");
  param_00 scragentsetscripted(0);
  param_00 method_839D("gravity");
  param_00 method_839C("anim deltas");
  param_00 maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "freezer spawn");
  param_00.var_509A = 0;
  param_00.ignoreall = 0;
  param_00.var_480F = 0;
  param_00 lib_0547::func_84CB();
}

exploder_run_big_uber_fx() {
  if(isDefined(self.mybiguberfx)) {
    self.mybiguberfx delete();
  }

  self.mybiguberfx = spawnlinkedfx(level.var_611["bomber_artillery_shell_carry"], self, "TAG_INHAND");
  triggerfx(self.mybiguberfx);
  maps / mp / agents / _agent_utility::deleteentonagentdeath(self.mybiguberfx);
}

freezer_crane_retrieve_zombie_mover(param_00, param_01) {
  var_02 = 0.75;
  param_00 scragentsetscripted(1);
  param_00 method_839D("noclip");
  param_00 method_839C("anim deltas");
  param_00 maps / mp / agents / _scripted_agent_anim_util::func_8732(1, "freezer spawn");
  param_00.var_509A = 1;
  param_00.ignoreall = 1;
  param_00 linkTo(level.freezer_crane, "tag_origin", (0, 0, -120), (0, 0, 0));
  common_scripts\utility::func_3C8F("flag_crane_in_motion");
  for(var_03 = 0; var_03 < level.freezer_crane.cranepath.size; var_03++) {
    level.freezer_crane moveTo(level.freezer_crane.cranepath[var_03].origin, var_02);
    wait(var_02);
  }

  wait(0.5);
  param_00 unlink();
  var_04 = common_scripts\utility::func_46B5("struct_freezer_force_teleport", "targetname");
  level notify("freezer_zombie_placed", param_00);
  param_00 scragentsetscripted(0);
  param_00 method_839D("gravity");
  param_00 maps / mp / agents / _scripted_agent_anim_util::func_8732(0, "freezer spawn");
  param_00.var_509A = 0;
  param_00.ignoreall = 0;
  param_00 lib_0547::func_84CB();
  for(var_03 = level.freezer_crane.cranepath.size - 1; var_03 >= 0; var_03--) {
    level.freezer_crane moveTo(level.freezer_crane.cranepath[var_03].origin, var_02);
    param_00 setOrigin(var_04.origin);
    wait(var_02);
  }

  common_scripts\utility::func_3C7B("flag_crane_in_motion");
}

init_spine_collection_manager() {
  if(!isDefined(level.var_376B) || isDefined(level.var_376B) && !common_scripts\utility::func_F79(level.var_376B, ::spine_zombie_collect_listener)) {
    lib_0547::func_7BA9(::spine_zombie_collect_listener);
  }

  level thread maps\mp\_utility::func_6F74(::spine_player_manager);
}

spine_zombie_collect_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.var_AC10) || !isDefined(self.var_A4B) || !isDefined(param_01) || !isDefined(param_04) || !issubstr(param_04, "razergun") || common_scripts\utility::func_562E(self.isfreezerzombie) || !self.meleeheavycasualty || self method_864D(param_01) && common_scripts\utility::func_562E(param_01.var_165B)) {
    return;
  }

  param_01 endon("spine_collected");
  var_09 = undefined;
  switch (self.var_A4B) {
    case "zombie_berserker":
      var_09 = "pest_spine";
      break;

    case "zombie_heavy":
      var_09 = "wustling_spine";
      break;

    case "zombie_assassin":
      var_09 = "assassin_spine";
      break;

    case "zombie_generic":
      var_09 = "zombie_spine";
      break;

    default:
      break;
  }

  wait(0.1);
  var_0A = 28;
  if(!common_scripts\utility::func_562E(param_01.spine_hint_complete)) {
    param_01 thread spine_hint(var_0A);
  }

  for(var_0B = var_0A; var_0B > 0; var_0B--) {
    if(param_01 useButtonPressed()) {
      iprintln(var_09 + " collected!");
      param_01.spine_hint_complete = 1;
      param_01 notify("spine_collected", var_09);
    }

    wait 0.05;
  }
}

spine_hint(param_00) {
  self forceusehinton(&"ZOMBIE_ISLAND_SPINE_COLLECT");
  spine_collect_wait_or_timeout(param_00);
  self forceusehintoff(&"ZOMBIE_ISLAND_SPINE_COLLECT");
}

spine_collect_wait_or_timeout(param_00) {
  self endon("spine_collected");
  for(var_01 = 0; var_01 < param_00; var_01++) {
    wait 0.05;
  }
}

spine_player_manager() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 common_scripts\utility::func_3799("ent_flag_pest_spine_collected");
  var_00 common_scripts\utility::func_3799("ent_flag_follower_spine_collected");
  var_00 common_scripts\utility::func_3799("ent_flag_assassin_spine_collected");
  var_00 common_scripts\utility::func_3799("ent_flag_zombie_spine_collected");
  var_00 thread init_spine_pickup_achievement();
  for(;;) {
    var_00 waittill("spine_collected", var_01);
    var_00 thread spine_collect(var_01);
    wait(0.8);
  }
}

spine_collect(param_00) {
  var_01 = self;
  if(isDefined(var_01.spine_curret)) {
    var_01 spine_player_clear_data();
  }

  var_01 endon("disconnect");
  var_01 endon("spine_destroyed");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = 180;
  param_00 = spine_depleted_chance(param_00);
  switch (param_00) {
    case "pest_spine":
      var_02 = "spine_inspect_pest_zm";
      var_04 = "ent_flag_pest_spine_collected";
      var_03 = &"ZOMBIE_ISLAND_SPINE_PEST";
      var_05 = "hud_item_dlc1_hc7";
      break;

    case "wustling_spine":
      var_02 = "spine_inspect_wustling_zm";
      var_04 = "ent_flag_follower_spine_collected";
      var_03 = &"ZOMBIE_ISLAND_SPINE_WUSTLING";
      var_05 = "hud_item_dlc1_hc8";
      break;

    case "assassin_spine":
      var_02 = "spine_inspect_assassin_zm";
      var_04 = "ent_flag_assassin_spine_collected";
      var_03 = &"ZOMBIE_ISLAND_SPINE_ASSASSIN";
      var_05 = "hud_item_dlc1_hc6";
      break;

    case "zombie_spine":
      var_02 = "spine_inspect_zombie_zm";
      var_04 = "ent_flag_zombie_spine_collected";
      var_03 = &"ZOMBIE_ISLAND_SPINE_ZOMBIE";
      var_05 = "ui_transparent";
      break;

    default:
      var_06 = 1;
      var_07 = 2;
      var_02 = "spine_inspect_depleted_zm";
      var_03 = &"ZOMBIE_ISLAND_SPINE_DEPLETED";
      break;
  }

  var_01 spine_pickup_anim(var_02);
  if(isDefined(level.zmb_events_player_zombie_spine_harvest)) {
    var_01 thread[[level.zmb_events_player_zombie_spine_harvest]](param_00, var_06);
  }

  if(!common_scripts\utility::func_562E(var_06)) {
    var_01 spine_player_collect_data(var_04, var_03);
    var_01 thread spine_display_hud_elem(var_03, var_07);
    var_01 thread spine_achievement_on_pickup(param_00);
    var_08 = 1;
    var_09 = var_07 * 1000 + maps\mp\_utility::func_44FA();
    var_01 luinotifyeventextraplayer(&"zm_dlc1_bar_visibility", 3, var_09, var_08, var_05);
    wait(var_07);
    var_01 thread spine_player_clear_data();
    return;
  }

  var_01 spine_display_hud_elem(var_03, var_07, 1);
}

wait_for_weapon_change(param_00) {
  self endon("weapon_change");
  for(;;) {
    var_01 = self getcurrentweapon();
    if(var_01 == param_00) {
      break;
    }

    wait 0.05;
  }
}

spine_pickup_anim(param_00) {
  var_01 = self;
  while(var_01 method_833B()) {
    wait 0.05;
  }

  var_02 = var_01 getcurrentweapon();
  var_01 common_scripts\utility::func_603();
  var_01 common_scripts\utility::func_600();
  var_01 lib_0586::func_78C(param_00);
  var_01 lib_0586::func_78E(param_00, 1);
  var_01 allowjump(0);
  var_01 method_8308(0);
  wait(0.1);
  var_01 setstance("stand");
  var_01 method_8113(0);
  var_01 method_8114(0);
  var_01 thread lib_0378::func_8D74("ripsaw_spine_cut");
  var_01 wait_for_weapon_change(param_00);
  wait(3);
  if(!lib_0547::func_73F9(self, var_02)) {
    var_02 = var_01 lib_0547::func_AB2B();
  }

  var_01 lib_0586::func_78E(var_02);
  var_01 common_scripts\utility::func_617();
  var_01 common_scripts\utility::func_614();
  if(var_01 hasweapon(param_00)) {
    var_01 lib_0586::func_790(param_00);
  }

  var_01 allowmovement(1);
  var_01 allowlook(1);
  var_01 method_8308(1);
  var_01 method_8113(1);
  var_01 method_8114(1);
  var_01 allowjump(1);
}

spine_display_hud_elem(param_00, param_01, param_02) {
  var_03 = self;
  var_03 endon("disconnect");
  var_04 = undefined;
  if(common_scripts\utility::func_562E(level.show_spine_harvest_text)) {
    var_04 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
    var_04 maps\mp\gametypes\_hud_util::setpoint("LEFT", undefined, 20, 50);
    var_04.label = param_00;
    if(!common_scripts\utility::func_562E(param_02)) {
      var_04 settenthstimer(param_01);
    }
  }

  common_scripts\utility::func_A70D(param_01, var_03, "spine_destroyed");
  if(isDefined(var_04)) {
    var_04 maps\mp\gametypes\_hud_util::destroyelem();
  }
}

spine_player_collect_data(param_00, param_01) {
  var_02 = self;
  var_02.spine_curret = param_01;
  var_02.spine_flag = param_00;
  var_02 common_scripts\utility::func_379A(var_02.spine_flag);
}

spine_player_clear_data() {
  var_00 = self;
  var_00 notify("spine_destroyed");
  var_01 = 0;
  var_00 luinotifyeventextraplayer(&"zm_dlc1_bar_visibility", 2, undefined, var_01);
  var_00 common_scripts\utility::func_3796(var_00.spine_flag);
  var_00.spine_curret = undefined;
  var_00.spine_flag = undefined;
}

spine_depleted_chance(param_00) {
  if(getdvarint("scr_spineneverdepleted", 0) == 1) {
    return param_00;
  }

  switch (param_00) {
    case "zombie_spine":
      if(func_20AD(25)) {
        return "depleted";
      }
      break;

    case "pest_spine":
      if(func_20AD(50)) {
        return "depleted";
      }
      break;

    case "wustling_spine":
      if(func_20AD(75)) {
        return "depleted";
      }
      break;

    case "assassin_spine":
      if(func_20AD(85)) {
        return "depleted";
      }
      break;

    default:
      param_00 = "depleted";
      break;
  }

  return param_00;
}

func_20AD(param_00) {
  return randomint(100) >= param_00;
}

init_artillery_cannon() {
  common_scripts\utility::func_3C87("flag_loaded_flak_cannon");
  var_00 = initialize_artillery_controls();
  var_01 = common_scripts\utility::func_46B7("artillery_struct", "targetname");
  foreach(var_03 in var_01) {
    var_00 = function_01AC(var_00, var_03.origin, 200);
    var_03.controller = var_00[0];
    var_04 = common_scripts\utility::func_44BE(var_03.target, "targetname");
    foreach(var_06 in var_04) {
      switch (var_06.script_noteworthy) {
        case "artillery_use_model":
          var_03.artillery_model = var_06;
          var_03.artillery_model.current_pitch = 0;
          var_03.artillery_model.current_yaw = 0;
          var_03.artillery_model.var_61AE = -5;
          var_03.artillery_model.var_605C = 15;
          var_03.artillery_model.min_yaw = -60;
          var_03.artillery_model.max_yaw = 60;
          break;

        case "struct_muzzle":
          var_03.artillery_muzzle = var_06;
          break;

        case "artillery_bomber_goal":
          var_06.my_cannon = var_03;
          break;
      }
    }

    var_03.artillery_muzzle linkTo(var_03.artillery_model);
    var_03 thread run_artillery_cannon();
  }
}

run_artillery_cannon() {
  self.controller.ammo_count = 0;
  self.var_6C48 = self.artillery_model.angles;
  thread watch_fire_cannon();
  for(;;) {
    var_00 = waittill_any_triggerarray_return_hitent(self.controller.interacts_trigs);
    if(!lib_0547::is_power_on(var_00)) {
      continue;
    }

    var_01 = findclosest(var_00, self.controller.interacts);
    switch (var_01.var_8140) {
      case 1:
        aim_vertical(1);
        break;

      case 2:
        aim_vertical(-1);
        break;

      case 3:
        aim_horizontal(-5);
        break;

      case 4:
        aim_horizontal(5);
        break;
    }
  }
}

waittill_any_triggerarray_return_hitent(param_00) {
  var_01 = spawnStruct();
  foreach(var_03 in param_00) {
    var_03 childthread waittill_string_return(var_01);
  }

  var_01 waittill("returned", var_05, var_06);
  var_01 notify("die");
  return var_05;
}

waittill_string_return(param_00) {
  self endon("death");
  param_00 endon("die");
  self waittill("trigger", var_01);
  param_00 notify("returned", var_01, self);
}

add_ammo(param_00) {
  common_scripts\utility::func_3C8F("flag_loaded_flak_cannon");
  level thread common_scripts\_exploder::func_88E(218);
  self.controller.ammo_count = self.controller.ammo_count + param_00;
  foreach(var_02 in level.players) {
    if(isDefined(var_02.vo_artillery_load_heard) && gettime() - var_02.vo_artillery_load_heard < 20000) {
      continue;
    }

    var_02 maps\mp\_utility::func_2CED(1.25, ::lib_0367::func_8E3D, "shipbomberload");
    var_02.vo_artillery_load_heard = gettime();
  }

  show_ammo_obj(param_00);
}

watch_fire_cannon() {
  for(;;) {
    self.controller.control_fire_trig waittill("trigger", var_00);
    if(!lib_0547::is_power_on(var_00)) {
      var_00 thread lib_0367::func_8E3C("shippower");
      continue;
    }

    if(self.controller.ammo_count > 0) {
      thread maps / mp / zquests / hardcore / island_ee_hc::ee_rollers_check(self.controller.display_pitch.display_num, self.controller.display_yaw.display_num);
      disable_ammo_obj(self.controller.ammo_count);
      self.controller.ammo_count--;
      if(self.controller.ammo_count < 1) {
        common_scripts\utility::func_3C7B("flag_loaded_flak_cannon");
        level thread common_scripts\_exploder::func_2A6D(218, undefined, 0);
      }

      var_01 = get_artillery_target_loc();
      playFX(common_scripts\utility::func_44F5("zmb_isl_artillery_cannon_muz_rnr"), self.artillery_muzzle.origin);
      lib_0378::func_8D74("artillery_cannon_shot", self.artillery_muzzle.origin);
      earthquake(0.75, 0.8, self.artillery_muzzle.origin, 1200);
      playrumbleonposition("artillery_rumble", self.artillery_muzzle.origin);
      var_02 = magicartillery("zmi_airstrike_bomb_island_cannon", self.artillery_muzzle.origin, var_01[0], var_01[1], self.artillery_muzzle.origin[2] + 1000);
      var_02 thread handle_projectile_hit_loc(var_01[0], var_00, self);
      continue;
    }

    var_00 thread play_ammo_nag();
  }
}

play_ammo_nag() {
  self endon("disconnect");
  if(common_scripts\utility::func_562E(self.is_playing_ammo_nag)) {
    return;
  }

  self.is_playing_ammo_nag = 1;
  var_00 = ["shipnoammo", "shipnoshots"];
  lib_0367::func_8E3C(common_scripts\utility::func_7A33(var_00));
  wait(3);
  self.is_playing_ammo_nag = undefined;
}

handle_projectile_hit_loc(param_00, param_01, param_02) {
  var_03 = 0;
  self waittill("explode", var_04);
  var_05 = ["nagshipmiss", "shipmiss", "shipmiss2"];
  if(var_04[2] >= 35) {
    playFX(common_scripts\utility::func_44F5("zmb_isl_artillery_ship_explosion"), var_04);
  } else {
    playFX(common_scripts\utility::func_44F5("zmb_isl_artillery_water_explosion"), var_04);
  }

  if(isDefined(level.artillery_ee_ships) && level.artillery_ee_ships.size > 0) {
    var_06 = function_01AC(level.artillery_ee_ships, var_04, 8000, 1);
    if(isDefined(var_06[0]) && var_06[0] ship_hit_point_checks(var_04)) {
      var_03 = 1;
      param_01 maps\mp\_utility::func_2CED(0.75, ::lib_0367::func_8E3D, "shiphit", level.players);
      var_06[0] notify("hit_by_cannon");
      maps / mp / zquests / casual / island_ee_main::destoyer_add_hit();
      lib_0378::func_8D74("distant_ship_explode");
      common_scripts\utility::func_33A0(var_04 + (0, 0, 1000), var_04, (0, 1, 0), 6);
    } else if(isDefined(var_06[0])) {
      if(!isDefined(param_01.vo_artillery_miss_heard) || isDefined(param_01.vo_artillery_miss_heard) && gettime() - param_01.vo_artillery_miss_heard > 5000) {
        param_01 ship_miss_dialogue(var_06[0], param_02, var_04, var_05);
        param_01.vo_artillery_miss_heard = gettime();
      }

      lib_0378::func_8D74("distant_water_explode");
      common_scripts\utility::func_33A0(var_04 + (0, 0, 1000), var_04, (1, 0, 0), 6);
    } else {
      if(!isDefined(param_01.vo_artillery_miss_heard) || isDefined(param_01.vo_artillery_miss_heard) && gettime() - param_01.vo_artillery_miss_heard > 5000) {
        param_01 maps\mp\_utility::func_2CED(0.75, ::lib_0367::func_8E3D, common_scripts\utility::func_7A33(var_05), level.players);
        param_01.vo_artillery_miss_heard = gettime();
      }

      lib_0378::func_8D74("distant_water_explode");
      common_scripts\utility::func_33A0(var_04 + (0, 0, 1000), var_04, (1, 0, 0), 6);
    }
  } else {
    lib_0378::func_8D74("aud_zmb_distant_water_explode");
    common_scripts\utility::func_33A0(var_04 + (0, 0, 1000), var_04, (1, 0, 0), 6);
  }

  if(!var_03) {
    level notify("artillery_miss");
  }
}

ship_miss_dialogue(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(common_scripts\utility::func_562E(param_00.in_motion)) {
    var_04 maps\mp\_utility::func_2CED(0.75, ::lib_0367::func_8E3D, common_scripts\utility::func_7A33(param_03), level.players);
    return;
  }

  var_05 = vectortoangles(param_00.origin - param_01.origin)[1] + param_01.artillery_model.angles[1];
  var_06 = vectortoangles(param_01.origin - param_00.origin);
  var_07 = vectortoangles(param_01.origin - param_02);
  var_08 = vectortoangles(param_01.origin - param_00.hit_points[0].origin);
  var_09 = vectortoangles(param_01.origin - param_00.hit_points[param_00.hit_points.size - 1].origin);
  var_0A = var_08[1];
  var_0B = var_09[1];
  if(var_08[1] < var_09[1]) {
    var_0A = var_09[1];
    var_0B = var_08[1];
  }

  var_0C = var_0A - var_0B;
  var_0D = var_06[1] - var_07[1];
  var_0E = var_0D;
  if(var_0D < 0) {
    var_0E = var_0E * -1;
  }

  var_0F = undefined;
  if(var_0E < var_0C) {
    if(distance(param_00.origin, var_04.origin) > distance(param_02, var_04.origin)) {
      var_0F = "near";
    } else {
      var_0F = "far";
    }
  } else if(var_0D > 0) {
    var_0F = "left";
  } else if(var_0D < 0) {
    var_0F = "right";
  }

  var_10 = "shipmiss3";
  switch (var_0F) {
    case "left":
      var_10 = "shipleft";
      break;

    case "right":
      var_10 = "shipright";
      break;

    case "far":
      var_10 = "shiplower";
      break;

    case "near":
      var_10 = "shiphigh";
      break;

    default:
      break;
  }

  var_11 = function_01AC(level.players, var_04.origin, 1000);
  var_11 = common_scripts\utility::func_F9A(var_11, 0);
  if(var_11.size < 1) {
    var_12 = var_04;
  } else {
    var_12 = common_scripts\utility::func_7A33(var_12);
  }

  var_12 maps\mp\_utility::func_2CED(0.75, ::lib_0367::func_8E3D, var_10, level.players);
}

ship_hit_point_checks(param_00) {
  var_01 = self;
  var_02 = var_01.hit_points;
  foreach(var_04 in var_02) {
    if(distance2d(var_04.origin, param_00) < var_04.var_14F) {
      return 1;
    }
  }

  return 0;
}

show_ammo_obj(param_00) {
  show_control_buttons(param_00);
  show_source_battery();
}

disable_ammo_obj(param_00) {
  show_control_buttons(param_00 - 1);
  if(param_00 == 1) {
    disable_source_battery();
    common_scripts\utility::func_3C8F("flag_artillery_out_of_ammo_quest_started");
  }
}

hide_ammo_obj(param_00) {
  show_control_buttons(param_00 - 1);
  if(param_00 == 1) {
    hide_source_battery();
  }
}

show_control_buttons(param_00) {
  level.fire_button hidepart("LARGE_GREEN");
  level.fire_button showpart("LARGE_RED");
  var_01 = 0.1;
  if(param_00 >= 6) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button showpart("TAG_FX_GREEN_02");
    level.fire_button showpart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button hidepart("TAG_FX_RED_02");
    level.fire_button hidepart("TAG_FX_RED_03");
    wait(var_01);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
    return;
  }

  if(param_00 < 6 && param_00 >= 4) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button showpart("TAG_FX_GREEN_02");
    level.fire_button hidepart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button hidepart("TAG_FX_RED_02");
    level.fire_button showpart("TAG_FX_RED_03");
    wait(var_01);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
    return;
  }

  if(param_00 < 4 && param_00 >= 1) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button hidepart("TAG_FX_GREEN_02");
    level.fire_button hidepart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button showpart("TAG_FX_RED_02");
    level.fire_button showpart("TAG_FX_RED_03");
    wait(var_01);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
    return;
  }

  level.fire_button hidepart("TAG_FX_GREEN_01");
  level.fire_button hidepart("TAG_FX_GREEN_02");
  level.fire_button hidepart("TAG_FX_GREEN_03");
  level.fire_button showpart("TAG_FX_RED_01");
  level.fire_button showpart("TAG_FX_RED_02");
  level.fire_button showpart("TAG_FX_RED_03");
}

show_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }

  lib_0378::func_8D74("artillery_power_filled");
  var_00 = common_scripts\utility::func_46B5("zmb_artilley_pwr_source", "targetname");
  level.artillery_power_source_model = lib_0547::func_8FBA(var_00, "bomber_uber_battery_place");
  triggerfx(level.artillery_power_source_model);
}

disable_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }

  lib_0378::func_8D74("artillery_power_depleted");
  var_00 = common_scripts\utility::func_46B5("zmb_artilley_pwr_source", "targetname");
  level.artillery_power_source_model = lib_0547::func_8FBA(var_00, "bomber_uber_battery_place_still");
  triggerfx(level.artillery_power_source_model);
}

hide_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }
}

get_artillery_target_loc() {
  var_00 = self.artillery_muzzle;
  var_01 = self.artillery_model.current_pitch;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = 3.14159;
  var_05 = 7500;
  var_06 = -385;
  var_07 = cos(var_01) * var_05;
  var_08 = sin(var_01) * var_05;
  var_09 = -1 * sqrt(var_08 * var_08 - 4388 * var_06) - var_08 / 2 * var_06;
  var_0A = var_09 * var_07;
  var_0B = (0, 0, -4);
  var_0C = anglesToForward((0, self.artillery_muzzle.angles[1], 0));
  var_0D = var_0C * var_0A;
  var_02 = var_0D + self.artillery_muzzle.origin;
  var_02 = (var_02[0], var_02[1], var_0B[2]);
  return [var_02, var_09];
}

aim_vertical(param_00) {
  var_01 = self.artillery_model.current_pitch + param_00;
  var_02 = 0;
  var_03 = 1;
  if(param_00 < 0) {
    var_03 = -1;
  }

  if(self.artillery_model.var_605C >= var_01 && var_01 >= self.artillery_model.var_61AE) {
    var_02 = 1;
  }

  if(self.artillery_model.current_yaw >= 55 && var_01 >= 2 || var_01 <= -3) {
    var_02 = 0;
  }

  if(self.artillery_model.current_yaw <= -55 && var_01 >= 2 || var_01 <= -3) {
    var_02 = 0;
  }

  if(var_02) {
    self.artillery_model.current_pitch = self.artillery_model.current_pitch + param_00;
    self.artillery_model rotateTo((0, self.artillery_model.current_yaw * -1, self.artillery_model.current_pitch * -1), 1);
    self.controller.valve_pitch thread display_pitch_handle_anim(var_03);
    self.controller.display_pitch display_num_set(self.artillery_model.current_pitch);
    lib_0378::func_8D74("artillery_valve_vert_turn");
    return;
  }

  lib_0378::func_8D74("artillery_valve_vert_no_turn");
}

aim_horizontal(param_00) {
  var_01 = self.artillery_model.current_yaw + param_00;
  var_02 = 0;
  var_03 = 1;
  if(param_00 < 0) {
    var_03 = -1;
  }

  if(self.artillery_model.max_yaw >= var_01 && var_01 >= self.artillery_model.min_yaw) {
    var_02 = 1;
  }

  if(self.artillery_model.current_pitch >= 2 && var_01 >= 55 || var_01 <= -55) {
    var_02 = 0;
  }

  if(self.artillery_model.current_pitch <= -3 && var_01 >= 55 || var_01 <= -55) {
    var_02 = 0;
  }

  if(var_02) {
    self.artillery_model.current_yaw = self.artillery_model.current_yaw + param_00;
    self.artillery_model rotateTo((0, self.artillery_model.current_yaw * -1, self.artillery_model.current_pitch * -1), 1);
    self.controller.valve_yaw rotatevelocity((0, 0, 36 * var_03 * -1), 1, 0, 0.5);
    self.controller.display_yaw display_num_set(self.artillery_model.current_yaw);
    lib_0378::func_8D74("artillery_valve_hor_turn");
    return;
  }

  lib_0378::func_8D74("artillery_valve_hor_no_turn");
}

initialize_artillery_controls() {
  var_00 = common_scripts\utility::func_46B7("artillery_cannon_controller", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    var_02.interacts = [];
    var_02.interacts_trigs = [];
    var_02.indicator_lights = [];
    var_02.ammo_lights = [];
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "control_interact_panel":
          var_02.interacts[var_05.var_8140 - 1] = var_05;
          break;

        case "trig_control_fire":
          var_02.control_fire_trig = var_05;
          var_02.control_fire_trig setHintString(&"ZOMBIE_ISLAND_ARTILLERY_FIRE");
          break;

        case "trig_control_interact_pitch_up":
          var_05 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_RAISE");
          var_02.interacts_trigs = common_scripts\utility::func_F6F(var_02.interacts_trigs, var_05);
          break;

        case "trig_control_interact_pitch_down":
          var_05 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_LOWER");
          var_02.interacts_trigs = common_scripts\utility::func_F6F(var_02.interacts_trigs, var_05);
          break;

        case "trig_control_interact_yaw_left":
          var_05 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_LEFT");
          var_02.interacts_trigs = common_scripts\utility::func_F6F(var_02.interacts_trigs, var_05);
          break;

        case "trig_control_interact_yaw_right":
          var_05 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_RIGHT");
          var_02.interacts_trigs = common_scripts\utility::func_F6F(var_02.interacts_trigs, var_05);
          break;

        case "struct_artillery_display_pitch":
          var_02.display_pitch = var_05;
          var_02.display_pitch thread setup_display_pad();
          break;

        case "struct_artillery_display_yaw":
          var_02.display_yaw = var_05;
          var_02.display_yaw thread setup_display_pad();
          break;

        case "struct_artillery_valve_pitch":
          var_02.valve_pitch = var_05;
          var_02.valve_pitch.var_6C48 = var_05.angles;
          break;

        case "struct_artillery_valve_yaw":
          var_02.valve_yaw = var_05;
          break;

        case "struct_artillery_button":
          var_02.fire_button = var_05;
          level.fire_button = var_05;
          level.fire_button hidepart("LARGE_GREEN");
          level.fire_button hidepart("TAG_FX_GREEN_01");
          level.fire_button hidepart("TAG_FX_GREEN_02");
          level.fire_button hidepart("TAG_FX_GREEN_03");
          break;
      }
    }
  }

  return var_00;
}

setup_display_pad() {
  self.display_num = 0;
  foreach(var_01 in common_scripts\utility::func_44BE(self.target, "targetname")) {
    switch (var_01.script_noteworthy) {
      case "artillery_number_wheel_dash":
        self.negative_dash = var_01;
        self.negative_dash.var_6C48 = self.negative_dash.angles;
        break;

      case "artillery_number_wheel_0":
        self.digit_1 = var_01;
        self.digit_1.var_6C48 = self.digit_1.angles;
        break;

      case "artillery_number_wheel_1":
        self.digit_2 = var_01;
        self.digit_2.var_6C48 = self.digit_2.angles;
        break;
    }
  }

  display_num_set(0);
}

display_num_set(param_00) {
  self.display_num = param_00;
  display_num();
}

display_num() {
  var_00 = self.display_num % 10;
  var_01 = int(self.display_num / 10);
  self.digit_1 display_set_digit(var_00);
  self.digit_2 display_set_digit(var_01);
  if(self.display_num >= 0) {
    self.negative_dash display_set_digit(0);
    return;
  }

  self.negative_dash display_set_digit(9);
}

display_set_digit(param_00) {
  if(param_00 < 0) {
    param_00 = param_00 * -1;
  }

  var_01 = 36 * param_00 * -1;
  var_02 = 0.5;
  var_03 = self.angles - self.var_6C48;
  var_04 = (0, 0, var_01) - var_03;
  self rotateTo(combineangles(self.var_6C48, (0, 0, var_01)), var_02);
}

display_pitch_handle_anim(param_00) {
  self notify("pitch_adjustment");
  self endon("pitch_adjustment");
  var_01 = 40;
  if(isDefined(param_00) && param_00 > 0) {
    var_01 = var_01 * -1;
  }

  self rotateTo(combineangles(self.var_6C48, (var_01, 0, 0)), 0.3);
  wait(0.5);
  self rotateTo(self.var_6C48, 0.5);
}

func_3B8A(param_00, param_01) {
  var_02 = -1;
  var_03 = 0;
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    var_05 = anglesToForward(param_00.angles);
    var_06 = param_01[var_04].origin - param_00.origin;
    var_05 = var_05 * (1, 1, 0);
    var_06 = var_06 * (1, 1, 0);
    var_06 = vectorNormalize(var_06);
    var_05 = vectorNormalize(var_05);
    var_07 = vectordot(var_06, var_05);
    if(var_07 > var_02) {
      var_02 = var_07;
      var_03 = var_04;
    }
  }

  return param_01[var_03];
}

findclosest(param_00, param_01) {
  var_02 = function_01AC(param_01, param_00.origin);
  return var_02[0];
}

init_buildable_turrets() {
  var_00 = common_scripts\utility::func_46B7("island_turret_buildable", "targetname");
  level.preplaced_turrets = getEntArray("island_mg_turret", "script_noteworthy");
}

func_46F2() {
  if(!self method_80D8()) {
    return undefined;
  }

  var_00 = self method_80E2();
  if(isDefined(var_00) && var_00 == level.player) {
    return level.player getweaponammostock(self.var_1D1);
  }

  return self method_817B();
}

func_46F1() {
  if(!self method_80D8()) {
    return undefined;
  }

  var_00 = self method_80E2();
  if(isDefined(var_00) && var_00 == level.player) {
    return level.player getweaponammoclip(self.var_1D1);
  }

  return self method_817C();
}

func_3A12(param_00) {
  var_01 = param_00 - self.origin;
  var_02 = sqrt(abs(var_01[2] * 2 / 800));
  var_03 = 1 / var_02;
  var_04 = var_01 * (var_03, var_03, 0);
  self gravitymove(var_04 + (0, 0, 800), var_02);
  wait(var_02);
  self.origin = param_00;
  earthquake(0.55, 0.6, param_00, 200);
  self delete();
}

ent_move_with_ent(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    self endon(param_01);
  }

  if(isDefined(param_02)) {
    self waittill(param_02);
  }

  var_03 = 0.01;
  var_04 = self.angles;
  param_00.angles = self.angles + (0, var_03, var_03);
  for(;;) {
    param_00.origin = self.origin;
    var_05 = func_0DD9(self.angles, var_04);
    param_00.angles = param_00.angles + var_05;
    var_04 = self.angles;
    wait 0.05;
  }
}

func_0DD9(param_00, param_01) {
  var_02 = param_00 - param_01;
  return var_02;
}

func_7A43(param_00) {
  return (randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00));
}

func_7A44(param_00) {
  return (randomfloatrange(param_00 * -1, param_00), randomfloatrange(param_00 * -1, param_00), 0);
}

random_2d_vector_safe_zone(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, randomint(359), 0));
  var_04 = randomintrange(param_01, param_02);
  var_05 = var_03 * var_04;
  var_06 = var_05 + param_00.origin;
  return var_06;
}

make_array_from_struct_chain() {
  var_00 = self;
  var_01 = [var_00];
  for(var_02 = 0; isDefined(var_01[var_02].target); var_02++) {
    var_03 = common_scripts\utility::func_46B5(var_01[var_02].target, "targetname");
    var_01[var_01.size] = var_03;
  }

  return var_01;
}

waittill_at_waypoint(param_00, param_01, param_02) {
  wait 0.05;
  if(!isDefined(param_01)) {
    param_01 = 64;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  for(;;) {
    if(distance(self.origin, param_00.origin) <= param_01) {
      if(param_02) {
        if(!lib_0547::func_5565(self.var_BA4, "traverse")) {
          break;
        }
      } else {
        break;
      }
    }

    wait 0.05;
  }

  self notify("escort_goal_reached");
}

escort_waypoints_linear(param_00, param_01, param_02) {
  self.escort_wps = param_00;
  var_03 = 0;
  if(isDefined(param_01) && param_01 == 1) {
    self setOrigin(self.escort_wps[var_03].origin, 1);
    if(isDefined(self.var_A4B) && self.var_A4B == "zombie_exploder") {
      exploder_teleport_bomb();
    }
  }

  while(isDefined(self) && distance(self.origin, self.escort_wps[self.escort_wps.size - 1].origin) > 64) {
    if(var_03 >= self.escort_wps.size) {
      var_03 = 0;
    }

    self.var_1928 = self.escort_wps[var_03];
    if(isDefined(self.escort_wps[var_03].var_8260) && self.escort_wps[var_03].var_8260 == "teleport_to_next" && isDefined(self.escort_wps[var_03 + 1])) {
      self setOrigin(self.escort_wps[var_03 + 1].origin, 1);
      if(isDefined(self.var_A4B) && self.var_A4B == "zombie_exploder") {
        exploder_teleport_bomb();
      }

      var_03++;
      continue;
    }

    thread waittill_at_waypoint(self.escort_wps[var_03]);
    self waittill("escort_goal_reached");
    var_03++;
  }
}

escort_waypoints_dynamic(param_00, param_01) {
  self.escort_wps = param_00;
  var_02 = 0;
  if(isDefined(param_01) && param_01 == 1) {
    self setOrigin(self.escort_wps[self.escort_wps.size - 1].origin, 1);
    if(isDefined(self.var_A4B) && self.var_A4B == "zombie_exploder") {
      exploder_teleport_bomb();
    }
  }

  while(isDefined(self) && distance(self.origin, self.escort_wps[0].origin) > 64) {
    if(var_02 >= self.escort_wps.size) {
      var_02 = 0;
    }

    self.var_1928 = self.escort_wps[var_02];
    var_03 = common_scripts\utility::waittill_any_return("goal_reached", "bad_path");
    if(var_03 == "bad_path") {
      var_02++;
      continue;
    } else if(var_03 == "goal_reached") {
      if(distance(self.origin, self.escort_wps[var_02].origin) < 64) {
        for(var_04 = 0; var_04 < self.escort_wps.size - var_02; var_04++) {
          self.escort_wps = common_scripts\utility::func_F9A(self.escort_wps, self.escort_wps.size);
        }
      }

      if(var_02 == 0 && distance(self.origin, param_00[var_02].origin) < 64) {
        return 1;
      }
    }

    var_02 = 0;
    wait(0.15);
  }
}

exploder_teleport_bomb() {
  exploder_run_big_uber_fx();
}

exploder_bomb_cleanup(param_00) {
  var_01 = self;
  param_00 waittill("death");
  if(isDefined(var_01)) {
    var_01 delete();
  }
}

escort_custom_movemode() {
  if(common_scripts\utility::func_562E(self.is_scripted_monent)) {
    return "walk";
  }

  self.var_2FA4 = 1;
  return "sprint";
}

pointisinislandinterior(param_00) {
  if(!isDefined(param_00) || !isDefined(param_00.origin)) {
    return 0;
  }

  var_01 = lib_055A::func_4562(param_00.origin);
  if(var_01 == "sub_pens_1_zone") {
    return 1;
  }

  return 0;
}

func_ABE1(param_00) {
  self endon("death");
  self.var_4B9F = 1;
  var_01 = "board_taunt";
  var_02 = maps / mp / agents / _scripted_agent_anim_util::func_434D(var_01, undefined, 1);
  if(isDefined(var_02)) {
    var_03 = maps / mp / agents / _scripted_agent_anim_util::func_7A35(var_02);
    maps / mp / agents / _scripted_agent_anim_util::func_8732(1, var_01);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetscripted(1);
    loop_taunt(var_02, var_03, param_00);
    self scragentsetscripted(0);
    maps / mp / agents / _scripted_agent_anim_util::func_8732(0, var_01);
  }
}

loop_taunt(param_00, param_01, param_02) {
  level endon(param_02);
  var_03 = 4.5;
  var_04 = gettime();
  while(gettime() - var_04 / 1000 < var_03) {
    maps / mp / agents / _scripted_agent_anim_util::func_71FA(param_00, param_01, 1, "taunt_anim");
  }
}

player_ent_flag_wait(param_00) {
  while(isDefined(self) && !self.var_3794[param_00]) {
    self waittill(param_00);
  }
}

player_ent_flag_waitopen(param_00) {
  while(isDefined(self) && self.var_3794[param_00]) {
    self waittill(param_00);
  }
}

overlayfade(param_00, param_01, param_02) {
  var_03 = self;
  var_03 endon("death");
  wait(param_00);
  var_03 fadeovertime(param_01);
  var_03.alpha = param_02;
  wait(param_01);
}

func_7432(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = "white";
  }

  foreach(var_04 in level.players) {
    if(param_01 >= 1) {
      if(isDefined(var_04.var_1781)) {
        var_04.var_1781 destroy();
      }

      var_04.var_1781 = func_2787("black", 0, var_04, (1, 1, 1));
      var_04.var_1781 setshader(param_02, 640, 480);
    }

    if(isDefined(var_04.var_1781)) {
      var_04.var_1781 fadeovertime(param_00);
      var_04.var_1781.alpha = param_01;
    }
  }

  wait(param_00);
}

func_2787(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02)) {
    var_04 = newclienthudelem(param_02);
  } else {
    var_04 = newhudelem();
  }

  var_04.x = 0;
  var_04.y = 0;
  var_04 setshader(param_00, 640, 480);
  var_04.alignx = "left";
  var_04.aligny = "top";
  var_04.sort = 1;
  var_04.horzalign = "fullscreen";
  var_04.vertalign = "fullscreen";
  var_04.alpha = param_01;
  var_04.foreground = 1;
  if(isDefined(param_03)) {
    var_04.color = param_03;
  }

  return var_04;
}

monk_head_dialogue(param_00, param_01, param_02) {
  if((isDefined(param_02) && common_scripts\utility::func_3C77(param_02)) || !isDefined(level.zombie_forge_control_struct.var_B9)) {
    return;
  }

  while(common_scripts\utility::func_562E(level.zombie_forge_control_struct.var_B9.is_speaking)) {
    wait 0.05;
  }

  if(common_scripts\utility::func_562E(param_01)) {
    while(is_player_touching_talk_vol()) {
      wait(0.5);
    }
  }

  level.zombie_forge_control_struct.var_B9.is_speaking = 1;
  var_03 = level.zombie_forge_control_struct.var_B9;
  var_03 scriptmodelplayanim("s2_zom_monk_lip_flap");
  var_03.head_talk_snd = lib_0380::func_288B(param_00, undefined, var_03);
  if(isDefined(var_03.head_talk_snd)) {
    lib_0380::func_288F(var_03.head_talk_snd, var_03, "head_dialogue_done");
  }

  var_03 waittill("head_dialogue_done");
  var_03 scriptmodelclearanim();
  level.zombie_forge_control_struct.var_B9.is_speaking = 0;
}

is_player_touching_talk_vol() {
  var_00 = getEnt("vol_monk_head_talk", "targetname");
  foreach(var_02 in level.players) {
    if(var_02 istouching(var_00)) {
      return 1;
    }
  }

  return 0;
}

enforce_zombie_limit() {
  level endon(self.phase_flag + "_assassins_defeated");
  common_scripts\utility::func_3C9F("intro_boss_done");
  for(;;) {
    var_00 = lib_0547::func_408F();
    if(var_00.size >= maps / mp / zquests / casual / island_ee_main::get_difficulty_setting("zmb_assassin_boss_phase_" + self.phase_num + "_zombie_count", 1)) {
      maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8608();
    } else {
      maps / mp / mp_zombie_nest_ee_wave_manipulation::func_8606();
    }

    wait 0.05;
  }
}

escort_health_display_start(param_00, param_01) {
  level notify("escort_display_start");
  escort_health_display_setup(param_00, "a", param_01);
  setomnvar("ui_zm_waypoint_ents_type", 1);
}

escort_health_display_setup(param_00, param_01, param_02) {
  if(isDefined(level.escort_health_bar)) {
    level.escort_health_bar delete();
  }

  level.escort_health_bar = spawn("script_model", param_00.origin);
  level.escort_health_bar.var_3012 = "ui_zm_waypoint_ent_" + param_01;
  level.escort_health_bar.var_3013 = "ui_zm_waypoint_float_" + param_01;
  level.escort_health_bar setModel("tag_origin");
  level.escort_health_bar show();
  level.escort_health_bar linkTo(param_00, "tag_origin", (0, 0, param_02), (0, 0, 0));
  setomnvar(level.escort_health_bar.var_3012, level.escort_health_bar getentitynumber());
  setomnvar(level.escort_health_bar.var_3013, 1);
}

escort_health_display_update(param_00) {
  var_01 = clamp(param_00.health / param_00.maxhealth, 0, 1);
  if(isDefined(level.escort_health_bar)) {
    setomnvar(level.escort_health_bar.var_3013, var_01);
  }
}

escort_health_display_remove() {
  level endon("escort_display_start");
  if(isDefined(level.escort_health_bar)) {
    setomnvar(level.escort_health_bar.var_3013, -1);
    level.escort_health_bar delete();
  }

  wait(1.5);
  setomnvar("ui_zm_waypoint_ents_type", 0);
}

escort_health_display_death_listener() {
  self waittill("death");
  thread escort_health_display_remove();
}

escort_health_display_damage_listener() {
  self endon("death");
  for(;;) {
    self waittill("damage", var_00);
    escort_health_display_update(self);
    if(common_scripts\utility::func_562E(self.escort_zombie)) {
      if(self.health - var_00 <= 0) {
        if(isDefined(self.anointed_fx)) {
          self.anointed_fx delete();
        }

        if(isDefined(self.anointed_fx_model)) {
          self.anointed_fx_model delete();
        }
      }
    }
  }
}

escort_health_display_heal_listener() {
  self endon("death");
  for(;;) {
    self waittill("escort_heal");
    escort_health_display_update(self);
  }
}

has_anyone_used_preplaced_turrets() {
  return common_scripts\utility::func_562E(level.turrets_used);
}

init_spine_pickup_achievement() {
  var_00 = ["zombie_spine", "pest_spine", "wustling_spine", "assassin_spine"];
  foreach(var_02 in var_00) {
    self.achievement_spines_needed[var_02] = 1;
  }
}

spine_achievement_on_pickup(param_00) {
  if(self.achievement_spines_needed.size > 0) {
    self.achievement_spines_needed[param_00] = undefined;
    if(self.achievement_spines_needed.size == 0) {
      maps / mp / gametypes / zombies::func_47C8("DLC1_ZM_SPINE");
    }
  }
}

get_health_of_zombies_at_round(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = "zombie_generic";
  }

  return int(param_01 * maps / mp / gametypes / zombies::func_1E59(lib_0547::func_A51(param_02), param_00));
}

waittill_touching(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0.05;
  }

  while(isDefined(self) && isDefined(param_00)) {
    if(self istouching(param_00)) {
      return;
    }

    wait(param_01);
  }
}

clear_all_zombies() {
  maps / mp / gametypes / zombies::func_8B2((0, 0, 0), 1);
  wait 0.05;
  foreach(var_01 in lib_0547::func_408F()) {
    var_01 suicide();
  }
}

add_difficulty_setting(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.zmb_island_difficulty_settings)) {
    level.zmb_island_difficulty_settings = [];
  }

  var_05 = 4;
  level.zmb_island_difficulty_settings[param_00] = [];
  if(isarray(param_01)) {
    level.zmb_island_difficulty_settings[param_00] = param_01;
    return;
  }

  if(isDefined(param_03)) {
    level.zmb_island_difficulty_settings[param_00] = spawnStruct();
    level.zmb_island_difficulty_settings[param_00].minval = param_01;
    level.zmb_island_difficulty_settings[param_00].maxval = param_02;
    level.zmb_island_difficulty_settings[param_00].var_3F02 = param_03;
    level.zmb_island_difficulty_settings[param_00].var_6E5C = param_04;
    return;
  }

  for(var_06 = 0; var_06 < var_05; var_06++) {
    var_07 = get_player_frac(var_06 + 1);
    level.zmb_island_difficulty_settings[param_00][var_06] = lerp(param_01, param_02, var_07);
  }
}

get_player_frac(param_00) {
  var_01 = 4;
  return param_00 - 1 / var_01 - 1;
}

wait_one_round_bomber() {
  var_00 = level.var_A980;
  common_scripts\utility::func_3C8F("flag_bomber_wave_punished");
  while(level.var_A980 <= var_00) {
    wait(0.125);
  }

  common_scripts\utility::func_3C7B("flag_bomber_wave_punished");
}