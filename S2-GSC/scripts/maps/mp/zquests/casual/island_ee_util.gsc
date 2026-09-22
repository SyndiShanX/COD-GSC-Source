/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\casual\island_ee_util.gsc
*************************************************************/

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
  var_0 = common_scripts\utility::_id_44BE("beach_rope_cut", "targetname");
  var_1 = spawnStruct();
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    switch (var_5._id_0165) {
      case "rope":
        var_1.rope = var_5;
        break;
      case "rope_box":
        var_1.my_box = var_5;
        break;
      case "rope_landing_point":
        var_1.landing_point = var_5;
        break;
      case "rope_final_point":
        var_1.final_point = var_5;
        break;
      case "art":
        var_1.art = var_5;
        break;
      case "body":
        var_1._id_18A8 = var_5;
        break;
      case "healthy_scaffolding":
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);
        break;
      case "dead_scaffolding":
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_5);
        break;
      case "impale":
        var_1.impale = var_5;
        break;
    }
  }

  var_1._id_18A8 hide();
  var_1.rope hide();
  var_1.my_box hide();
  var_1.art hide();
  var_1.impale hide();
  var_7 = _getEnt("zmb_island_plane_crash_strap", "targetname");
  var_7 hide();

  foreach(var_9 in var_3) {
    var_9 hide();
  }

  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("Flak Tower", "Defend Flak Tower"));
  var_7 show();
  var_1.rope show();
  var_1.my_box show();
  var_1.art show();
  var_1._id_18A8 show();
  var_1.impale show();

  foreach(var_9 in var_2) {
    var_9 hide();
  }

  foreach(var_9 in var_3) {
    var_9 show();
  }

  var_1 thread run_rope_cut();
}

#using_animtree("animated_props_zombies_DLC1");

run_rope_cut() {
  var_0 = common_scripts\utility::_id_46B5("rope_landing_point", "script_noteworthy");
  self.rope setCanDamage(1);

  for(;;) {
    self.rope waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_10)) {
      continue;
    }
    if(issubstr(var_10, "razergun_zm") || issubstr(var_10, "razergun_pap_zm")) {
      break;
    }
  }

  self.rope delete();
  _id_0557::_id_782D("Flak Tower", "Find crashed plane");
  var_11 = common_scripts\utility::_id_46B5("rope_landing_scripted_node", "targetname");
  self.my_box scriptmodelplayanimdeltamotionfrompos("s2_zom_radio_drop", var_11.origin, common_scripts\utility::_id_98E7(isDefined(var_11.angles), var_11.angles, (0, 0, 0)), "radio_anim");
  self.my_box _id_0378::_id_8D74("radio_part_drops");
  wait(_getanimlength(%s2_zom_radio_drop));
  self.my_box _id_0547::_id_AC41(&"zombie_island_radio_part_pickup", undefined, self.my_box gettagorigin("Backpack_01_lod0") + (0, 0, 16));
  self.my_box waittill("player_used", var_12);
  self.my_box _id_0547::_id_AC40();
  self.my_box delete();
  var_12 thread _id_0367::_id_8E3C("radioparttwo", level.players);
  maps\mp\zquests\casual\island_ee_main::set_radio_part_2_found();
}

drop_strap() {
  var_0 = _getEnt("zmb_island_plane_crash_strap", "targetname");
  var_0 movegravity((0, 0, 0), 10);
  var_0 rotateby((20, 20, 20), 10);
}

get_parachute_ropes() {
  var_0 = spawnStruct();
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  return var_0;
}

init_usable_bombs() {
  level thread run_bomb_listener();
}

run_bomb_listener() {
  for(;;) {
    wait 0.125;

    if(!isDefined(level._id_393E)) {
      continue;
    }
    foreach(var_1 in level._id_393E) {
      if(!common_scripts\utility::_id_562E(var_1.bombusableenabled)) {
        var_1.bombusableenabled = 1;
        var_1 _id_0547::_id_AC41("pickup explosive", (0, 0, 16));
        var_1 thread pickup_bomb();
      }
    }
  }
}

pickup_bomb() {
  for(;;) {
    self waittill("player_used", var_0);

    if(!common_scripts\utility::_id_562E(var_0.iscarryingbomberbomb)) {
      var_0.iscarryingbomberbomb = 1;
      break;
    } else {}
  }

  _id_0547::_id_AC40();
  self delete();
  var_0.iscarryingbomberbomb = 1;
}

init_bomber_doors() {
  var_0 = common_scripts\utility::_id_46B7("bomber_door", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_2.door_pieces = [];
    var_2.bomb_placements = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "razergun_door":
          var_2.door_pieces = common_scripts\utility::_id_0F6F(var_2.door_pieces, var_5);
          break;
        case "razergun_door_target":
          var_2.bomb_target = var_5;
          break;
        case "bomb_door_usable":
          var_2.bomb_trigger = var_5;
          break;
        case "bomb_door_placements":
          var_2.bomb_placements = common_scripts\utility::_id_0F6F(var_2.bomb_placements, var_5);
          break;
      }
    }
  }

  var_8 = common_scripts\utility::_id_46B7("bomber_door", "targetname");

  foreach(var_2 in var_8) {
    var_2 thread run_bomber_door();
  }
}

run_bomber_door() {
  wait_for_door_destroyed();
  self.bomb_target delete();

  foreach(var_1 in self.door_pieces) {
    var_1 connectpaths();
    var_1 delete();
  }
}

wait_for_door_destroyed() {
  self endon("force_open");

  for(;;) {
    self.bomb_trigger waittill("trigger", var_0);

    if(common_scripts\utility::_id_562E(var_0.iscarryingbomberbomb)) {
      break;
    }
  }

  var_1 = common_scripts\utility::random(self.bomb_placements);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("zom_bomb");
  var_2.angles = var_1.angles;
  var_2 setCanDamage(1);
  var_2 waittill("damage");
  var_2 delete();
}

init_freezer_zombie_manager() {
  level.freezer_crane = freezer_setup_crane();
  level.freezer_crane thread freezer_zombie_think();
  level.freezer_crane thread freezer_crane_anim_think();
}

freezer_setup_crane() {
  var_0 = _getEnt("mdl_freezer_crane", "targetname");
  var_0.setviewkickscale = common_scripts\utility::_id_46B5("struct_freezer_anim_node", "targetname");
  var_0._id_931A = "idling";
  var_0 common_scripts\utility::_id_3799("ent_flag_crane_retrieving");
  return var_0;
}

freezer_crane_anim_think() {
  for(;;) {
    for(;;) {
      self scriptmodelplayanimdeltamotionfrompos("s2_zom_gate_spawn_idle_harness", self.setviewkickscale.origin, self.setviewkickscale.angles, "freezer_crane");
      self waittillmatch("freezer_crane", "end");

      if(self._id_931A != "idling") {
        break;
      }
    }

    thread start_runner_lights();
    common_scripts\utility::_id_379A("ent_flag_crane_retrieving");
    _id_0378::_id_8D74("freezer_crane_retrieving");
    self._id_931A = "retrieving";
    waitframe();
    waitframe();
    waitframe();
    self scriptmodelplayanimdeltamotionfrompos("s2_zom_gate_spawn_intro_harness", self.setviewkickscale.origin, self.setviewkickscale.angles, "freezer_crane");
    self waittillmatch("freezer_crane", "end");
    self scriptmodelplayanimdeltamotionfrompos("s2_zom_gate_spawn_exit_harness", self.setviewkickscale.origin, self.setviewkickscale.angles, "freezer_crane");
    self waittillmatch("freezer_crane", "end");
    thread stop_runner_lights();
    self._id_931A = "idling";
    common_scripts\utility::_id_3796("ent_flag_crane_retrieving");
  }
}

start_runner_lights() {
  var_0 = _getscriptablearray("on1", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "off");
    wait 2.5;
    var_2 setscriptablepartstate("lightpart", "flicker");
  }

  var_4 = _getscriptablearray("on2", "targetname");

  foreach(var_6 in var_4) {
    wait 0.04;
    var_6 setscriptablepartstate("lightpart", "off");
    wait 2;
    var_6 setscriptablepartstate("lightpart", "flicker02");
  }

  var_8 = _getscriptablearray("on3", "targetname");

  foreach(var_10 in var_8) {
    wait 0.12;
    var_10 setscriptablepartstate("lightpart", "off");
    wait 1.6;
    var_10 setscriptablepartstate("lightpart", "flicker02");
  }
}

stop_runner_lights() {
  var_0 = _getscriptablearray("on1", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "on");
  }

  wait 0.02;
  var_4 = _getscriptablearray("on2", "targetname");

  foreach(var_6 in var_4) {
    wait 0.04;
    var_6 setscriptablepartstate("lightpart", "on");
  }

  wait 0.1;
  var_8 = _getscriptablearray("on3", "targetname");

  foreach(var_10 in var_8) {
    wait 0.04;
    var_10 setscriptablepartstate("lightpart", "on");
  }
}

freezer_zombie_think() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = ["zmb_isla_monk_pridefillsthemotherseyesw", "zmb_isla_monk_strengthwithoutfaithwitho"];
  var_3 = ["zmb_isla_monk_findtheruntofthelitterala", "zmb_isla_monk_guidetheblindsontosightto"];
  var_4 = ["zmb_isla_monk_findtheyoungestsonthechil"];

  for(;;) {
    level waittill("freezeer_summon_zombie", var_5);

    if(!isDefined(var_5) || common_scripts\utility::_id_3C77("flag_crane_in_motion") || level.freezer_crane._id_931A == "request_retrieve") {
      waitframe();
      continue;
    }

    var_0 = common_scripts\utility::_id_46B5("freezer_harness_spawner", "targetname");
    var_6 = undefined;
    var_7 = undefined;

    switch (var_5) {
      case "escort_bomber":
        var_1 = "zombie_exploder";
        var_6 = maps\mp\zquests\casual\island_ee_main::setup_escort_bomber;
        var_7 = "flag_hc_bomb_escort_complete";
        break;
      case "hc_pest":
        var_1 = "zombie_berserker";
        var_6 = maps\mp\zquests\hardcore\island_ee_hc::pest_hc_zombie_setup;
        var_7 = "zmb_hc_pest_destination";
        maps\mp\_utility::_id_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::random(var_3), 1, var_7);
        break;
      case "hc_assassin":
        var_0 = common_scripts\utility::_id_46B5("assassin_escort_spawner", "targetname");
        var_1 = "zombie_assassin";
        var_6 = maps\mp\zquests\hardcore\island_ee_hc::assassin_hc_zombie_setup;
        var_7 = "flag_hc_asn_escort_complete";
        maps\mp\_utility::_id_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::random(var_4), 1, var_7);
        break;
      case "hc_follower":
        var_1 = "zombie_heavy";
        var_6 = maps\mp\zquests\hardcore\island_ee_hc::wustling_hc_zombie_setup;
        var_7 = "zmb_hc_follower_destination";
        maps\mp\_utility::_id_2CED(1.25, ::monk_head_dialogue, common_scripts\utility::random(var_2), 1, var_7);
        break;
      case "hc_zombie":
        var_1 = "zombie_generic";
        var_6 = maps\mp\zquests\hardcore\island_ee_hc::zombie_hc_zombie_setup;
        var_7 = "players_spawned_statue_piece_2";
        break;
      default:
        break;
    }

    if(!isDefined(var_0)) {
      return;
    }
    var_8 = spawn_an_escort_zombie(var_1, var_0, var_6, var_7);
    level.freezer_crane freezer_crane_retrieve_zombie_anim(var_8, var_0);
  }
}

spawn_an_escort_zombie(var_0, var_1, var_2, var_3) {
  var_4 = _id_054D::_id_90BA(var_0, var_1, "freezer_zombie", 0, 0, 0);
  var_4.isfreezerzombie = 1;

  if(isDefined(var_2)) {
    if(!isDefined(var_3) || isDefined(var_3) && !common_scripts\utility::_id_3C77(var_3)) {
      var_4[[var_2]]();
    }
  }

  return var_4;
}

freezer_crane_retrieve_zombie_anim(var_0, var_1) {
  var_2 = self.setviewkickscale;
  var_0 scragentsetscripted(1);
  var_0 scragentsetphysicsmode("noclip");
  var_0 scragentsetanimmode("anim deltas");
  var_0 scragentsetorientmode("face angle abs", var_1.angles);
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "freezer spawn");
  var_0._id_509A = 1;
  var_0._id_00CA = 1;
  var_0._id_480F = 1;
  var_3 = var_0 maps\mp\agents\_scripted_agent_anim_util::_id_434D("scripted_harness_spawn");
  var_4 = var_0 getanimentry(var_3, 0);
  var_5 = _getstartorigin(var_2.origin, var_2.angles, var_4);
  var_6 = _getstartangles(var_2.origin, var_2.angles, var_4);
  level.freezer_crane._id_931A = "request_retrieve";
  level.freezer_crane common_scripts\utility::_id_379C("ent_flag_crane_retrieving");
  common_scripts\utility::flag_set("flag_crane_in_motion");
  var_0 setOrigin(var_5);
  var_0.angles = var_6;

  if(_id_0547::_id_5565(level.escort_bomber, var_0)) {
    var_0 exploder_run_big_uber_fx();
  }

  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_3, 0, "scripted_anim");
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_71FD(var_3, 2, "scripted_anim");
  level notify("freezer_zombie_placed", var_0);
  common_scripts\utility::_id_3C7B("flag_crane_in_motion");
  var_0 scragentsetscripted(0);
  var_0 scragentsetphysicsmode("gravity");
  var_0 scragentsetanimmode("anim deltas");
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "freezer spawn");
  var_0._id_509A = 0;
  var_0._id_00CA = 0;
  var_0._id_480F = 0;
  var_0 _id_0547::disableoffhandsecondaryweapons();
}

exploder_run_big_uber_fx() {
  if(isDefined(self.mybiguberfx)) {
    self.mybiguberfx delete();
  }

  self.mybiguberfx = _spawnlinkedfx(level._effect["bomber_artillery_shell_carry"], self, "TAG_INHAND");
  _triggerfx(self.mybiguberfx);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.mybiguberfx);
}

freezer_crane_retrieve_zombie_mover(var_0, var_1) {
  var_2 = 0.75;
  var_0 scragentsetscripted(1);
  var_0 scragentsetphysicsmode("noclip");
  var_0 scragentsetanimmode("anim deltas");
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "freezer spawn");
  var_0._id_509A = 1;
  var_0._id_00CA = 1;
  var_0 linkTo(level.freezer_crane, "tag_origin", (0, 0, -120), (0, 0, 0));
  common_scripts\utility::flag_set("flag_crane_in_motion");

  for(var_3 = 0; var_3 < level.freezer_crane.cranepath.size; var_3++) {
    level.freezer_crane moveTo(level.freezer_crane.cranepath[var_3].origin, var_2);
    wait(var_2);
  }

  wait 0.5;
  var_0 unlink();
  var_4 = common_scripts\utility::_id_46B5("struct_freezer_force_teleport", "targetname");
  level notify("freezer_zombie_placed", var_0);
  var_0 scragentsetscripted(0);
  var_0 scragentsetphysicsmode("gravity");
  var_0 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "freezer spawn");
  var_0._id_509A = 0;
  var_0._id_00CA = 0;
  var_0 _id_0547::disableoffhandsecondaryweapons();

  for(var_3 = level.freezer_crane.cranepath.size - 1; var_3 >= 0; var_3--) {
    level.freezer_crane moveTo(level.freezer_crane.cranepath[var_3].origin, var_2);
    var_0 setOrigin(var_4.origin);
    wait(var_2);
  }

  common_scripts\utility::_id_3C7B("flag_crane_in_motion");
}

init_spine_collection_manager() {
  if(!isDefined(level._id_376B) || isDefined(level._id_376B) && !common_scripts\utility::_id_0F79(level._id_376B, ::spine_zombie_collect_listener)) {
    _id_0547::_id_7BA9(::spine_zombie_collect_listener);
  }

  level thread maps\mp\_utility::_id_6F74(::spine_player_manager);
}

spine_zombie_collect_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self._id_AC10) || !isDefined(self._id_0A4B) || !isDefined(var_1) || !isDefined(var_4) || !issubstr(var_4, "razergun") || common_scripts\utility::_id_562E(self.isfreezerzombie) || !(self._id_0103 || self _meth_864D(var_1) && common_scripts\utility::_id_562E(var_1._id_165B))) {
    return;
  }
  var_1 endon("spine_collected");
  var_9 = undefined;

  switch (self._id_0A4B) {
    case "zombie_berserker":
      var_9 = "pest_spine";
      break;
    case "zombie_heavy":
      var_9 = "wustling_spine";
      break;
    case "zombie_assassin":
      var_9 = "assassin_spine";
      break;
    case "zombie_generic":
      var_9 = "zombie_spine";
      break;
    default:
      return;
  }

  wait 0.1;
  var_10 = 28;

  if(!common_scripts\utility::_id_562E(var_1.spine_hint_complete)) {
    var_1 thread spine_hint(var_10);
  }

  for(var_11 = var_10; var_11 > 0; var_11--) {
    if(var_1 useButtonPressed()) {
      _iprintln(var_9 + " collected!");
      var_1.spine_hint_complete = 1;
      var_1 notify("spine_collected", var_9);
    }

    waitframe();
  }
}

spine_hint(var_0) {
  self forceusehinton(&"ZOMBIE_ISLAND_SPINE_COLLECT");
  spine_collect_wait_or_timeout(var_0);
  self forceusehintoff(&"ZOMBIE_ISLAND_SPINE_COLLECT");
}

spine_collect_wait_or_timeout(var_0) {
  self endon("spine_collected");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    waitframe();
  }
}

spine_player_manager() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 common_scripts\utility::_id_3799("ent_flag_pest_spine_collected");
  var_0 common_scripts\utility::_id_3799("ent_flag_follower_spine_collected");
  var_0 common_scripts\utility::_id_3799("ent_flag_assassin_spine_collected");
  var_0 common_scripts\utility::_id_3799("ent_flag_zombie_spine_collected");
  var_0 thread init_spine_pickup_achievement();

  for(;;) {
    var_0 waittill("spine_collected", var_1);
    var_0 thread spine_collect(var_1);
    wait 0.8;
  }
}

spine_collect(var_0) {
  var_1 = self;

  if(isDefined(var_1.spine_curret)) {
    var_1 spine_player_clear_data();
  }

  var_1 endon("disconnect");
  var_1 endon("spine_destroyed");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 180;
  var_0 = spine_depleted_chance(var_0);

  switch (var_0) {
    case "pest_spine":
      var_2 = "spine_inspect_pest_zm";
      var_4 = "ent_flag_pest_spine_collected";
      var_3 = &"ZOMBIE_ISLAND_SPINE_PEST";
      var_5 = "hud_item_dlc1_hc7";
      break;
    case "wustling_spine":
      var_2 = "spine_inspect_wustling_zm";
      var_4 = "ent_flag_follower_spine_collected";
      var_3 = &"ZOMBIE_ISLAND_SPINE_WUSTLING";
      var_5 = "hud_item_dlc1_hc8";
      break;
    case "assassin_spine":
      var_2 = "spine_inspect_assassin_zm";
      var_4 = "ent_flag_assassin_spine_collected";
      var_3 = &"ZOMBIE_ISLAND_SPINE_ASSASSIN";
      var_5 = "hud_item_dlc1_hc6";
      break;
    case "zombie_spine":
      var_2 = "spine_inspect_zombie_zm";
      var_4 = "ent_flag_zombie_spine_collected";
      var_3 = &"ZOMBIE_ISLAND_SPINE_ZOMBIE";
      var_5 = "ui_transparent";
      break;
    default:
      var_6 = 1;
      var_7 = 2;
      var_2 = "spine_inspect_depleted_zm";
      var_3 = &"ZOMBIE_ISLAND_SPINE_DEPLETED";
      break;
  }

  var_1 spine_pickup_anim(var_2);

  if(isDefined(level.zmb_events_player_zombie_spine_harvest)) {
    var_1 thread[[level.zmb_events_player_zombie_spine_harvest]](var_0, var_6);
  }

  if(!common_scripts\utility::_id_562E(var_6)) {
    var_1 spine_player_collect_data(var_4, var_3);
    var_1 thread spine_display_hud_elem(var_3, var_7);
    var_1 thread spine_achievement_on_pickup(var_0);
    var_8 = 1;
    var_9 = var_7 * 1000 + maps\mp\_utility::_id_44FA();
    var_1 _meth_866C(&"zm_dlc1_bar_visibility", 3, var_9, var_8, var_5);
    wait(var_7);
    var_1 thread spine_player_clear_data();
  } else
    var_1 spine_display_hud_elem(var_3, var_7, 1);
}

wait_for_weapon_change(var_0) {
  self endon("weapon_change");

  for(;;) {
    var_1 = self getcurrentweapon();

    if(var_1 == var_0) {
      break;
    }

    waitframe();
  }
}

spine_pickup_anim(var_0) {
  var_1 = self;

  while(var_1 isswitchingweapon()) {
    waitframe();
  }

  var_2 = var_1 getcurrentweapon();
  var_1 common_scripts\utility::_id_0603();
  var_1 common_scripts\utility::_disableoffhandweapons();
  var_1 _id_0586::_id_078C(var_0);
  var_1 _id_0586::_id_078E(var_0, 1);
  var_1 allowjump(0);
  var_1 allowsprint(0);
  wait 0.1;
  var_1 setstance("stand");
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 thread _id_0378::_id_8D74("ripsaw_spine_cut");
  var_1 wait_for_weapon_change(var_0);
  wait 3.0;

  if(!_id_0547::_id_73F9(self, var_2)) {
    var_2 = var_1 _id_0547::_id_AB2B();
  }

  var_1 _id_0586::_id_078E(var_2);
  var_1 common_scripts\utility::_id_0617();
  var_1 common_scripts\utility::_id_0614();

  if(var_1 hasweapon(var_0)) {
    var_1 _id_0586::_id_0790(var_0);
  }

  var_1 _meth_8546(1);
  var_1 allowlean(1);
  var_1 allowsprint(1);
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1 allowjump(1);
}

spine_display_hud_elem(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("disconnect");
  var_4 = undefined;

  if(common_scripts\utility::_id_562E(level.show_spine_harvest_text)) {
    var_4 = maps\mp\gametypes\_hud_util::createfontstring("default", 1);
    var_4 maps\mp\gametypes\_hud_util::setpoint("LEFT", undefined, 20, 50);
    var_4.label = var_0;

    if(!common_scripts\utility::_id_562E(var_2)) {
      var_4 settenthstimer(var_1);
    }
  }

  common_scripts\utility::_id_A70D(var_1, var_3, "spine_destroyed");

  if(isDefined(var_4)) {
    var_4 maps\mp\gametypes\_hud_util::destroyelem();
  }
}

spine_player_collect_data(var_0, var_1) {
  var_2 = self;
  var_2.spine_curret = var_1;
  var_2.spine_flag = var_0;
  var_2 common_scripts\utility::_id_379A(var_2.spine_flag);
}

spine_player_clear_data() {
  var_0 = self;
  var_0 notify("spine_destroyed");
  var_1 = 0;
  var_0 _meth_866C(&"zm_dlc1_bar_visibility", 2, undefined, var_1);
  var_0 common_scripts\utility::_id_3796(var_0.spine_flag);
  var_0.spine_curret = undefined;
  var_0.spine_flag = undefined;
}

spine_depleted_chance(var_0) {
  if(getdvarint("scr_spineneverdepleted", 0) == 1) {
    return var_0;
  }

  switch (var_0) {
    case "zombie_spine":
      if(_id_20AD(25)) {
        return "depleted";
      }

      break;
    case "pest_spine":
      if(_id_20AD(50)) {
        return "depleted";
      }

      break;
    case "wustling_spine":
      if(_id_20AD(75)) {
        return "depleted";
      }

      break;
    case "assassin_spine":
      if(_id_20AD(85)) {
        return "depleted";
      }

      break;
    default:
      var_0 = "depleted";
      break;
  }

  return var_0;
}

_id_20AD(var_0) {
  return randomint(100) >= var_0;
}

init_artillery_cannon() {
  common_scripts\utility::flag_init("flag_loaded_flak_cannon");
  var_0 = initialize_artillery_controls();
  var_1 = common_scripts\utility::_id_46B7("artillery_struct", "targetname");

  foreach(var_3 in var_1) {
    var_0 = _sortbydistance(var_0, var_3.origin, 200);
    var_3.controller = var_0[0];
    var_4 = common_scripts\utility::_id_44BE(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_0165) {
        case "artillery_use_model":
          var_3.artillery_model = var_6;
          var_3.artillery_model.current_pitch = 0;
          var_3.artillery_model.current_yaw = 0;
          var_3.artillery_model._id_61AE = -5;
          var_3.artillery_model._id_605C = 15;
          var_3.artillery_model.min_yaw = -60;
          var_3.artillery_model.max_yaw = 60;
          break;
        case "struct_muzzle":
          var_3.artillery_muzzle = var_6;
          break;
        case "artillery_bomber_goal":
          var_6.my_cannon = var_3;
          break;
      }
    }

    var_3.artillery_muzzle linkTo(var_3.artillery_model);
    var_3 thread run_artillery_cannon();
  }
}

run_artillery_cannon() {
  self.controller.ammo_count = 0;
  self._id_6C48 = self.artillery_model.angles;
  thread watch_fire_cannon();

  for(;;) {
    var_0 = waittill_any_triggerarray_return_hitent(self.controller.interacts_trigs);

    if(!_id_0547::is_power_on(var_0)) {
      continue;
    }
    var_1 = findclosest(var_0, self.controller.interacts);

    switch (var_1.setanimknobrestart) {
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

waittill_any_triggerarray_return_hitent(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    var_3 childthread waittill_string_return(var_1);
  }

  var_1 waittill("returned", var_5, var_6);
  var_1 notify("die");
  return var_5;
}

waittill_string_return(var_0) {
  self endon("death");
  var_0 endon("die");
  self waittill("trigger", var_1);
  var_0 notify("returned", var_1, self);
}

add_ammo(var_0) {
  common_scripts\utility::flag_set("flag_loaded_flak_cannon");
  level thread common_scripts\_exploder::_id_088E(218);
  self.controller.ammo_count = self.controller.ammo_count + var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.vo_artillery_load_heard) && gettime() - var_2.vo_artillery_load_heard < 20000) {
      continue;
    }
    var_2 maps\mp\_utility::_id_2CED(1.25, _id_0367::_id_8E3D, "shipbomberload");
    var_2.vo_artillery_load_heard = gettime();
  }

  show_ammo_obj(var_0);
}

watch_fire_cannon() {
  for(;;) {
    self.controller.control_fire_trig waittill("trigger", var_0);

    if(!_id_0547::is_power_on(var_0)) {
      var_0 thread _id_0367::_id_8E3C("shippower");
      continue;
    }

    if(self.controller.ammo_count > 0) {
      thread maps\mp\zquests\hardcore\island_ee_hc::ee_rollers_check(self.controller.display_pitch.display_num, self.controller.display_yaw.display_num);
      disable_ammo_obj(self.controller.ammo_count);
      self.controller.ammo_count--;

      if(self.controller.ammo_count < 1) {
        common_scripts\utility::_id_3C7B("flag_loaded_flak_cannon");
        level thread common_scripts\_exploder::_id_2A6D(218, undefined, 0);
      }

      var_1 = get_artillery_target_loc();
      playFX(common_scripts\utility::_id_44F5("zmb_isl_artillery_cannon_muz_rnr"), self.artillery_muzzle.origin);
      _id_0378::_id_8D74("artillery_cannon_shot", self.artillery_muzzle.origin);
      _earthquake(0.75, 0.8, self.artillery_muzzle.origin, 1200);
      _playrumbleonposition("artillery_rumble", self.artillery_muzzle.origin);
      var_2 = _func_1B6("zmi_airstrike_bomb_island_cannon", self.artillery_muzzle.origin, var_1[0], var_1[1], self.artillery_muzzle.origin[2] + 1000);
      var_2 thread handle_projectile_hit_loc(var_1[0], var_0, self);
      continue;
    }

    var_0 thread play_ammo_nag();
  }
}

play_ammo_nag() {
  self endon("disconnect");

  if(common_scripts\utility::_id_562E(self.is_playing_ammo_nag)) {
    return;
  }
  self.is_playing_ammo_nag = 1;
  var_0 = ["shipnoammo", "shipnoshots"];
  _id_0367::_id_8E3C(common_scripts\utility::random(var_0));
  wait 3;
  self.is_playing_ammo_nag = undefined;
}

handle_projectile_hit_loc(var_0, var_1, var_2) {
  var_3 = 0;
  self waittill("explode", var_4);
  var_5 = ["nagshipmiss", "shipmiss", "shipmiss2"];

  if(var_4[2] >= 35) {
    playFX(common_scripts\utility::_id_44F5("zmb_isl_artillery_ship_explosion"), var_4);
  } else {
    playFX(common_scripts\utility::_id_44F5("zmb_isl_artillery_water_explosion"), var_4);
  }

  if(isDefined(level.artillery_ee_ships) && level.artillery_ee_ships.size > 0) {
    var_6 = _sortbydistance(level.artillery_ee_ships, var_4, 8000, 1);

    if(isDefined(var_6[0]) && var_6[0] ship_hit_point_checks(var_4)) {
      var_3 = 1;
      var_1 maps\mp\_utility::_id_2CED(0.75, _id_0367::_id_8E3D, "shiphit", level.players);
      var_6[0] notify("hit_by_cannon");
      maps\mp\zquests\casual\island_ee_main::destoyer_add_hit();
      _id_0378::_id_8D74("distant_ship_explode");
      common_scripts\utility::_id_33A0(var_4 + (0, 0, 1000), var_4, (0, 1, 0), 6);
    } else if(isDefined(var_6[0])) {
      if(!isDefined(var_1.vo_artillery_miss_heard) || isDefined(var_1.vo_artillery_miss_heard) && gettime() - var_1.vo_artillery_miss_heard > 5000) {
        var_1 ship_miss_dialogue(var_6[0], var_2, var_4, var_5);
        var_1.vo_artillery_miss_heard = gettime();
      }

      _id_0378::_id_8D74("distant_water_explode");
      common_scripts\utility::_id_33A0(var_4 + (0, 0, 1000), var_4, (1, 0, 0), 6);
    } else {
      if(!isDefined(var_1.vo_artillery_miss_heard) || isDefined(var_1.vo_artillery_miss_heard) && gettime() - var_1.vo_artillery_miss_heard > 5000) {
        var_1 maps\mp\_utility::_id_2CED(0.75, _id_0367::_id_8E3D, common_scripts\utility::random(var_5), level.players);
        var_1.vo_artillery_miss_heard = gettime();
      }

      _id_0378::_id_8D74("distant_water_explode");
      common_scripts\utility::_id_33A0(var_4 + (0, 0, 1000), var_4, (1, 0, 0), 6);
    }
  } else {
    _id_0378::_id_8D74("aud_zmb_distant_water_explode");
    common_scripts\utility::_id_33A0(var_4 + (0, 0, 1000), var_4, (1, 0, 0), 6);
  }

  if(!var_3) {
    level notify("artillery_miss");
  }
}

ship_miss_dialogue(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(common_scripts\utility::_id_562E(var_0.in_motion)) {
    var_4 maps\mp\_utility::_id_2CED(0.75, _id_0367::_id_8E3D, common_scripts\utility::random(var_3), level.players);
    return;
  }

  var_5 = vectortoangles(var_0.origin - var_1.origin)[1] + var_1.artillery_model.angles[1];
  var_6 = vectortoangles(var_1.origin - var_0.origin);
  var_7 = vectortoangles(var_1.origin - var_2);
  var_8 = vectortoangles(var_1.origin - var_0.hit_points[0].origin);
  var_9 = vectortoangles(var_1.origin - var_0.hit_points[var_0.hit_points.size - 1].origin);
  var_10 = var_8[1];
  var_11 = var_9[1];

  if(var_8[1] < var_9[1]) {
    var_10 = var_9[1];
    var_11 = var_8[1];
  }

  var_12 = var_10 - var_11;
  var_13 = var_6[1] - var_7[1];
  var_14 = var_13;

  if(var_13 < 0) {
    var_14 = var_14 * -1;
  }

  var_15 = undefined;

  if(var_14 < var_12) {
    if(distance(var_0.origin, var_4.origin) > distance(var_2, var_4.origin)) {
      var_15 = "near";
    } else {
      var_15 = "far";
    }
  } else if(var_13 > 0)
    var_15 = "left";
  else if(var_13 < 0) {
    var_15 = "right";
  }

  var_16 = "shipmiss3";

  switch (var_15) {
    case "left":
      var_16 = "shipleft";
      break;
    case "right":
      var_16 = "shipright";
      break;
    case "far":
      var_16 = "shiplower";
      break;
    case "near":
      var_16 = "shiphigh";
      break;
    default:
      break;
  }

  var_17 = _sortbydistance(level.players, var_4.origin, 1000);
  var_17 = common_scripts\utility::_id_0F9A(var_17, 0);

  if(var_17.size < 1) {
    var_18 = var_4;
  } else {
    var_18 = common_scripts\utility::random(var_17);
  }

  var_18 maps\mp\_utility::_id_2CED(0.75, _id_0367::_id_8E3D, var_16, level.players);
}

ship_hit_point_checks(var_0) {
  var_1 = self;
  var_2 = var_1.hit_points;

  foreach(var_4 in var_2) {
    if(_distance2d(var_4.origin, var_0) < var_4.radius) {
      return 1;
    }
  }

  return 0;
}

show_ammo_obj(var_0) {
  show_control_buttons(var_0);
  show_source_battery();
}

disable_ammo_obj(var_0) {
  show_control_buttons(var_0 - 1);

  if(var_0 == 1) {
    disable_source_battery();
    common_scripts\utility::flag_set("flag_artillery_out_of_ammo_quest_started");
  }
}

hide_ammo_obj(var_0) {
  show_control_buttons(var_0 - 1);

  if(var_0 == 1) {
    hide_source_battery();
  }
}

show_control_buttons(var_0) {
  level.fire_button hidepart("LARGE_GREEN");
  level.fire_button showpart("LARGE_RED");
  var_1 = 0.1;

  if(var_0 >= 6) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button showpart("TAG_FX_GREEN_02");
    level.fire_button showpart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button hidepart("TAG_FX_RED_02");
    level.fire_button hidepart("TAG_FX_RED_03");
    wait(var_1);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
  } else if(var_0 < 6 && var_0 >= 4) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button showpart("TAG_FX_GREEN_02");
    level.fire_button hidepart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button hidepart("TAG_FX_RED_02");
    level.fire_button showpart("TAG_FX_RED_03");
    wait(var_1);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
  } else if(var_0 < 4 && var_0 >= 1) {
    level.fire_button showpart("TAG_FX_GREEN_01");
    level.fire_button hidepart("TAG_FX_GREEN_02");
    level.fire_button hidepart("TAG_FX_GREEN_03");
    level.fire_button hidepart("TAG_FX_RED_01");
    level.fire_button showpart("TAG_FX_RED_02");
    level.fire_button showpart("TAG_FX_RED_03");
    wait(var_1);
    level.fire_button showpart("LARGE_GREEN");
    level.fire_button hidepart("LARGE_RED");
  } else {
    level.fire_button hidepart("TAG_FX_GREEN_01");
    level.fire_button hidepart("TAG_FX_GREEN_02");
    level.fire_button hidepart("TAG_FX_GREEN_03");
    level.fire_button showpart("TAG_FX_RED_01");
    level.fire_button showpart("TAG_FX_RED_02");
    level.fire_button showpart("TAG_FX_RED_03");
  }
}

show_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }

  _id_0378::_id_8D74("artillery_power_filled");
  var_0 = common_scripts\utility::_id_46B5("zmb_artilley_pwr_source", "targetname");
  level.artillery_power_source_model = _id_0547::_id_8FBA(var_0, "bomber_uber_battery_place");
  _triggerfx(level.artillery_power_source_model);
}

disable_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }

  _id_0378::_id_8D74("artillery_power_depleted");
  var_0 = common_scripts\utility::_id_46B5("zmb_artilley_pwr_source", "targetname");
  level.artillery_power_source_model = _id_0547::_id_8FBA(var_0, "bomber_uber_battery_place_still");
  _triggerfx(level.artillery_power_source_model);
}

hide_source_battery() {
  if(isDefined(level.artillery_power_source_model)) {
    level.artillery_power_source_model delete();
  }
}

get_artillery_target_loc() {
  var_0 = self.artillery_muzzle;
  var_1 = self.artillery_model.current_pitch;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 3.14159;
  var_5 = 7500;
  var_6 = -385;
  var_7 = _cos(var_1) * var_5;
  var_8 = _sin(var_1) * var_5;
  var_9 = (-1 * _sqrt(var_8 * var_8 - 4388 * var_6) - var_8) / (2 * var_6);
  var_10 = var_9 * var_7;
  var_11 = (0, 0, -4);
  var_12 = anglesToForward((0, self.artillery_muzzle.angles[1], 0));
  var_13 = var_12 * var_10;
  var_2 = var_13 + self.artillery_muzzle.origin;
  var_2 = (var_2[0], var_2[1], var_11[2]);
  return [var_2, var_9];
}

aim_vertical(var_0) {
  var_1 = self.artillery_model.current_pitch + var_0;
  var_2 = 0;
  var_3 = 1;

  if(var_0 < 0) {
    var_3 = -1;
  }

  if(self.artillery_model._id_605C >= var_1 && var_1 >= self.artillery_model._id_61AE) {
    var_2 = 1;
  }

  if(self.artillery_model.current_yaw >= 55 && (var_1 >= 2 || var_1 <= -3)) {
    var_2 = 0;
  }

  if(self.artillery_model.current_yaw <= -55 && (var_1 >= 2 || var_1 <= -3)) {
    var_2 = 0;
  }

  if(var_2) {
    self.artillery_model.current_pitch = self.artillery_model.current_pitch + var_0;
    self.artillery_model rotateTo((0, self.artillery_model.current_yaw * -1, self.artillery_model.current_pitch * -1), 1);
    self.controller.valve_pitch thread display_pitch_handle_anim(var_3);
    self.controller.display_pitch display_num_set(self.artillery_model.current_pitch);
    _id_0378::_id_8D74("artillery_valve_vert_turn");
  } else
    _id_0378::_id_8D74("artillery_valve_vert_no_turn");
}

aim_horizontal(var_0) {
  var_1 = self.artillery_model.current_yaw + var_0;
  var_2 = 0;
  var_3 = 1;

  if(var_0 < 0) {
    var_3 = -1;
  }

  if(self.artillery_model.max_yaw >= var_1 && var_1 >= self.artillery_model.min_yaw) {
    var_2 = 1;
  }

  if(self.artillery_model.current_pitch >= 2 && (var_1 >= 55 || var_1 <= -55)) {
    var_2 = 0;
  }

  if(self.artillery_model.current_pitch <= -3 && (var_1 >= 55 || var_1 <= -55)) {
    var_2 = 0;
  }

  if(var_2) {
    self.artillery_model.current_yaw = self.artillery_model.current_yaw + var_0;
    self.artillery_model rotateTo((0, self.artillery_model.current_yaw * -1, self.artillery_model.current_pitch * -1), 1);
    self.controller.valve_yaw rotatevelocity((0, 0, 36 * var_3 * -1), 1, 0, 0.5);
    self.controller.display_yaw display_num_set(self.artillery_model.current_yaw);
    _id_0378::_id_8D74("artillery_valve_hor_turn");
  } else
    _id_0378::_id_8D74("artillery_valve_hor_no_turn");
}

initialize_artillery_controls() {
  var_0 = common_scripts\utility::_id_46B7("artillery_cannon_controller", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_2.interacts = [];
    var_2.interacts_trigs = [];
    var_2.indicator_lights = [];
    var_2.ammo_lights = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "control_interact_panel":
          var_2.interacts[var_5.setanimknobrestart - 1] = var_5;
          break;
        case "trig_control_fire":
          var_2.control_fire_trig = var_5;
          var_2.control_fire_trig setHintString(&"ZOMBIE_ISLAND_ARTILLERY_FIRE");
          break;
        case "trig_control_interact_pitch_up":
          var_5 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_RAISE");
          var_2.interacts_trigs = common_scripts\utility::_id_0F6F(var_2.interacts_trigs, var_5);
          break;
        case "trig_control_interact_pitch_down":
          var_5 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_LOWER");
          var_2.interacts_trigs = common_scripts\utility::_id_0F6F(var_2.interacts_trigs, var_5);
          break;
        case "trig_control_interact_yaw_left":
          var_5 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_LEFT");
          var_2.interacts_trigs = common_scripts\utility::_id_0F6F(var_2.interacts_trigs, var_5);
          break;
        case "trig_control_interact_yaw_right":
          var_5 setHintString(&"ZOMBIE_ISLAND_ARTILLERY_RIGHT");
          var_2.interacts_trigs = common_scripts\utility::_id_0F6F(var_2.interacts_trigs, var_5);
          break;
        case "struct_artillery_display_pitch":
          var_2.display_pitch = var_5;
          var_2.display_pitch thread setup_display_pad();
          break;
        case "struct_artillery_display_yaw":
          var_2.display_yaw = var_5;
          var_2.display_yaw thread setup_display_pad();
          break;
        case "struct_artillery_valve_pitch":
          var_2.valve_pitch = var_5;
          var_2.valve_pitch._id_6C48 = var_5.angles;
          break;
        case "struct_artillery_valve_yaw":
          var_2.valve_yaw = var_5;
          break;
        case "struct_artillery_button":
          var_2.fire_button = var_5;
          level.fire_button = var_5;
          level.fire_button hidepart("LARGE_GREEN");
          level.fire_button hidepart("TAG_FX_GREEN_01");
          level.fire_button hidepart("TAG_FX_GREEN_02");
          level.fire_button hidepart("TAG_FX_GREEN_03");
          break;
      }
    }
  }

  return var_0;
}

setup_display_pad() {
  self.display_num = 0;

  foreach(var_1 in common_scripts\utility::_id_44BE(self.target, "targetname")) {
    switch (var_1._id_0165) {
      case "artillery_number_wheel_dash":
        self.negative_dash = var_1;
        self.negative_dash._id_6C48 = self.negative_dash.angles;
        break;
      case "artillery_number_wheel_0":
        self.digit_1 = var_1;
        self.digit_1._id_6C48 = self.digit_1.angles;
        break;
      case "artillery_number_wheel_1":
        self.digit_2 = var_1;
        self.digit_2._id_6C48 = self.digit_2.angles;
        break;
    }
  }

  display_num_set(0);
}

display_num_set(var_0) {
  self.display_num = var_0;
  display_num();
}

display_num() {
  var_0 = self.display_num % 10;
  var_1 = int(self.display_num / 10);
  self.digit_1 display_set_digit(var_0);
  self.digit_2 display_set_digit(var_1);

  if(self.display_num >= 0) {
    self.negative_dash display_set_digit(0);
  } else {
    self.negative_dash display_set_digit(9);
  }
}

display_set_digit(var_0) {
  if(var_0 < 0) {
    var_0 = var_0 * -1;
  }

  var_1 = 36 * var_0 * -1;
  var_2 = 0.5;
  var_3 = self.angles - self._id_6C48;
  var_4 = (0, 0, var_1) - var_3;
  self rotateTo(_combineangles(self._id_6C48, (0, 0, var_1)), var_2);
}

display_pitch_handle_anim(var_0) {
  self notify("pitch_adjustment");
  self endon("pitch_adjustment");
  var_1 = 40;

  if(isDefined(var_0) && var_0 > 0) {
    var_1 = var_1 * -1;
  }

  self rotateTo(_combineangles(self._id_6C48, (var_1, 0, 0)), 0.3);
  wait 0.5;
  self rotateTo(self._id_6C48, 0.5);
}

_id_3B8A(var_0, var_1) {
  var_2 = -1;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = anglesToForward(var_0.angles);
    var_6 = var_1[var_4].origin - var_0.origin;
    var_5 = var_5 * (1, 1, 0);
    var_6 = var_6 * (1, 1, 0);
    var_6 = vectorNormalize(var_6);
    var_5 = vectorNormalize(var_5);
    var_7 = vectordot(var_6, var_5);

    if(var_7 > var_2) {
      var_2 = var_7;
      var_3 = var_4;
    }
  }

  return var_1[var_3];
}

findclosest(var_0, var_1) {
  var_2 = _sortbydistance(var_1, var_0.origin);
  return var_2[0];
}

init_buildable_turrets() {
  var_0 = common_scripts\utility::_id_46B7("island_turret_buildable", "targetname");
  level.preplaced_turrets = getEntArray("island_mg_turret", "script_noteworthy");
}

_id_46F2() {
  if(!self _meth_80D8()) {
    return undefined;
  }

  var_0 = self getturretowner();

  if(isDefined(var_0) && var_0 == level.player) {
    return level.player getweaponammostock(self._id_01D1);
  } else {
    return self _meth_817B();
  }
}

_id_46F1() {
  if(!self _meth_80D8()) {
    return undefined;
  }

  var_0 = self getturretowner();

  if(isDefined(var_0) && var_0 == level.player) {
    return level.player getweaponammoclip(self._id_01D1);
  } else {
    return self _meth_817C();
  }
}

_id_3A12(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  self movegravity(var_4 + (0, 0, 800), var_2);
  wait(var_2);
  self.origin = var_0;
  _earthquake(0.55, 0.6, var_0, 200);
  self delete();
}

ent_move_with_ent(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self waittill(var_2);
  }

  var_3 = 0.01;
  var_4 = self.angles;
  var_0.angles = self.angles + (0, var_3, var_3);

  for(;;) {
    var_0.origin = self.origin;
    var_5 = _id_0DD9(self.angles, var_4);
    var_0.angles = var_0.angles + var_5;
    var_4 = self.angles;
    waitframe();
  }
}

_id_0DD9(var_0, var_1) {
  var_2 = var_0 - var_1;
  return var_2;
}

_id_7A43(var_0) {
  return (_randomfloatrange(var_0 * -1, var_0), _randomfloatrange(var_0 * -1, var_0), _randomfloatrange(var_0 * -1, var_0));
}

_id_7A44(var_0) {
  return (_randomfloatrange(var_0 * -1, var_0), _randomfloatrange(var_0 * -1, var_0), 0);
}

random_2d_vector_safe_zone(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, randomint(359), 0));
  var_4 = _randomintrange(var_1, var_2);
  var_5 = var_3 * var_4;
  var_6 = var_5 + var_0.origin;
  return var_6;
}

make_array_from_struct_chain() {
  var_0 = self;
  var_1 = [var_0];

  for(var_2 = 0; isDefined(var_1[var_2].target); var_2++) {
    var_3 = common_scripts\utility::_id_46B5(var_1[var_2].target, "targetname");
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

waittill_at_waypoint(var_0, var_1, var_2) {
  waitframe();

  if(!isDefined(var_1)) {
    var_1 = 64;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(;;) {
    if(distance(self.origin, var_0.origin) <= var_1) {
      if(var_2) {
        if(!_id_0547::_id_5565(self._id_0BA4, "traverse")) {
          break;
        }
      } else
        break;
    }

    waitframe();
  }

  self notify("escort_goal_reached");
}

escort_waypoints_linear(var_0, var_1, var_2) {
  self.escort_wps = var_0;
  var_3 = 0;

  if(isDefined(var_1) && var_1 == 1) {
    self setOrigin(self.escort_wps[var_3].origin, 1);

    if(isDefined(self._id_0A4B) && self._id_0A4B == "zombie_exploder") {
      exploder_teleport_bomb();
    }
  }

  while(isDefined(self) && distance(self.origin, self.escort_wps[self.escort_wps.size - 1].origin) > 64) {
    if(var_3 >= self.escort_wps.size) {
      var_3 = 0;
    }

    self._id_1928 = self.escort_wps[var_3];

    if(isDefined(self.escort_wps[var_3].setlookatent) && self.escort_wps[var_3].setlookatent == "teleport_to_next" && isDefined(self.escort_wps[var_3 + 1])) {
      self setOrigin(self.escort_wps[var_3 + 1].origin, 1);

      if(isDefined(self._id_0A4B) && self._id_0A4B == "zombie_exploder") {
        exploder_teleport_bomb();
      }

      var_3++;
      continue;
    }

    thread waittill_at_waypoint(self.escort_wps[var_3]);
    self waittill("escort_goal_reached");
    var_3++;
  }
}

escort_waypoints_dynamic(var_0, var_1) {
  self.escort_wps = var_0;
  var_2 = 0;

  if(isDefined(var_1) && var_1 == 1) {
    self setOrigin(self.escort_wps[self.escort_wps.size - 1].origin, 1);

    if(isDefined(self._id_0A4B) && self._id_0A4B == "zombie_exploder") {
      exploder_teleport_bomb();
    }
  }

  while(isDefined(self) && distance(self.origin, self.escort_wps[0].origin) > 64) {
    if(var_2 >= self.escort_wps.size) {
      var_2 = 0;
    }

    self._id_1928 = self.escort_wps[var_2];
    var_3 = common_scripts\utility::waittill_any_return("goal_reached", "bad_path");

    if(var_3 == "bad_path") {
      var_2++;
      continue;
    } else if(var_3 == "goal_reached") {
      if(distance(self.origin, self.escort_wps[var_2].origin) < 64) {
        for(var_4 = 0; var_4 < self.escort_wps.size - var_2; var_4++) {
          self.escort_wps = common_scripts\utility::_id_0F9A(self.escort_wps, self.escort_wps.size);
        }
      }

      if(var_2 == 0 && distance(self.origin, var_0[var_2].origin) < 64) {
        return 1;
      }
    }

    var_2 = 0;
    wait 0.15;
  }
}

exploder_teleport_bomb() {
  exploder_run_big_uber_fx();
}

exploder_bomb_cleanup(var_0) {
  var_1 = self;
  var_0 waittill("death");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

escort_custom_movemode() {
  if(common_scripts\utility::_id_562E(self.is_scripted_monent)) {
    return "walk";
  } else {
    self._id_2FA4 = 1;
    return "sprint";
  }
}

pointisinislandinterior(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return 0;
  }

  var_1 = _id_055A::_id_4562(var_0.origin);

  if(var_1 == "sub_pens_1_zone") {
    return 1;
  } else {
    return 0;
  }
}

_id_ABE1(var_0) {
  self endon("death");
  self._id_4B9F = 1;
  var_1 = "board_taunt";
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1, undefined, 1);

  if(isDefined(var_2)) {
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_2);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, var_1);
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetscripted(1);
    loop_taunt(var_2, var_3, var_0);
    self scragentsetscripted(0);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, var_1);
  }
}

loop_taunt(var_0, var_1, var_2) {
  level endon(var_2);
  var_3 = 4.5;
  var_4 = gettime();

  while((gettime() - var_4) / 1000 < var_3) {
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, var_1, 1.0, "taunt_anim");
  }
}

player_ent_flag_wait(var_0) {
  while(isDefined(self) && !self._id_3794[var_0]) {
    self waittill(var_0);
  }
}

player_ent_flag_waitopen(var_0) {
  while(isDefined(self) && self._id_3794[var_0]) {
    self waittill(var_0);
  }
}

overlayfade(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  wait(var_0);
  var_3 fadeovertime(var_1);
  var_3.alpha = var_2;
  wait(var_1);
}

_id_7432(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = "white";
  }

  foreach(var_4 in level.players) {
    if(var_1 >= 1) {
      if(isDefined(var_4._id_1781)) {
        var_4._id_1781 destroy();
      }

      var_4._id_1781 = _id_2787("black", 0.0, var_4, (1, 1, 1));
      var_4._id_1781 setshader(var_2, 640, 480);
    }

    if(isDefined(var_4._id_1781)) {
      var_4._id_1781 fadeovertime(var_0);
      var_4._id_1781.alpha = var_1;
    }
  }

  wait(var_0);
}

_id_2787(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = _newclienthudelem(var_2);
  } else {
    var_4 = newhudelem();
  }

  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4._id_00C6 = "fullscreen";
  var_4._id_01CA = "fullscreen";
  var_4.alpha = var_1;
  var_4.foreground = 1;

  if(isDefined(var_3)) {
    var_4.color = var_3;
  }

  return var_4;
}

monk_head_dialogue(var_0, var_1, var_2) {
  if(isDefined(var_2) && common_scripts\utility::_id_3C77(var_2) || !isDefined(level.zombie_forge_control_struct._id_00B9)) {
    return;
  }
  while(common_scripts\utility::_id_562E(level.zombie_forge_control_struct._id_00B9.is_speaking)) {
    waitframe();
  }

  if(common_scripts\utility::_id_562E(var_1)) {
    while(is_player_touching_talk_vol()) {
      wait 0.5;
    }
  }

  level.zombie_forge_control_struct._id_00B9.is_speaking = 1;
  var_3 = level.zombie_forge_control_struct._id_00B9;
  var_3 scriptmodelplayanim("s2_zom_monk_lip_flap");
  var_3.head_talk_snd = _id_0380::_id_288B(var_0, undefined, var_3);

  if(isDefined(var_3.head_talk_snd)) {
    _id_0380::_id_288F(var_3.head_talk_snd, var_3, "head_dialogue_done");
  }

  var_3 waittill("head_dialogue_done");
  var_3 scriptmodelclearanim();
  level.zombie_forge_control_struct._id_00B9.is_speaking = 0;
}

is_player_touching_talk_vol() {
  var_0 = _getEnt("vol_monk_head_talk", "targetname");

  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0)) {
      return 1;
    }
  }

  return 0;
}

enforce_zombie_limit() {
  level endon(self.phase_flag + "_assassins_defeated");
  common_scripts\utility::_id_3C9F("intro_boss_done");

  for(;;) {
    var_0 = _id_0547::_id_408F();

    if(var_0.size >= maps\mp\zquests\casual\island_ee_main::get_difficulty_setting("zmb_assassin_boss_phase_" + self.phase_num + "_zombie_count", 1)) {
      maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
    } else {
      maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
    }

    waitframe();
  }
}

escort_health_display_start(var_0, var_1) {
  level notify("escort_display_start");
  escort_health_display_setup(var_0, "a", var_1);
  _setomnvar("ui_zm_waypoint_ents_type", 1);
}

escort_health_display_setup(var_0, var_1, var_2) {
  if(isDefined(level.escort_health_bar)) {
    level.escort_health_bar delete();
  }

  level.escort_health_bar = spawn("script_model", var_0.origin);
  level.escort_health_bar._id_3012 = "ui_zm_waypoint_ent_" + var_1;
  level.escort_health_bar._id_3013 = "ui_zm_waypoint_float_" + var_1;
  level.escort_health_bar setModel("tag_origin");
  level.escort_health_bar show();
  level.escort_health_bar linkTo(var_0, "tag_origin", (0, 0, var_2), (0, 0, 0));
  _setomnvar(level.escort_health_bar._id_3012, level.escort_health_bar getentitynumber());
  _setomnvar(level.escort_health_bar._id_3013, 1.0);
}

escort_health_display_update(var_0) {
  var_1 = clamp(var_0.health / var_0.maxhealth, 0.0, 1.0);

  if(isDefined(level.escort_health_bar)) {
    _setomnvar(level.escort_health_bar._id_3013, var_1);
  }
}

escort_health_display_remove() {
  level endon("escort_display_start");

  if(isDefined(level.escort_health_bar)) {
    _setomnvar(level.escort_health_bar._id_3013, -1.0);
    level.escort_health_bar delete();
  }

  wait 1.5;
  _setomnvar("ui_zm_waypoint_ents_type", 0);
}

escort_health_display_death_listener() {
  self waittill("death");
  thread escort_health_display_remove();
}

escort_health_display_damage_listener() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0);
    escort_health_display_update(self);

    if(common_scripts\utility::_id_562E(self.escort_zombie)) {
      if(self.health - var_0 <= 0) {
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
  return common_scripts\utility::_id_562E(level.turrets_used);
}

init_spine_pickup_achievement() {
  var_0 = ["zombie_spine", "pest_spine", "wustling_spine", "assassin_spine"];

  foreach(var_2 in var_0) {
    self.achievement_spines_needed[var_2] = 1;
  }
}

spine_achievement_on_pickup(var_0) {
  if(self.achievement_spines_needed.size > 0) {
    self.achievement_spines_needed[var_0] = undefined;

    if(self.achievement_spines_needed.size == 0) {
      maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_SPINE");
    }
  }
}

get_health_of_zombies_at_round(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "zombie_generic";
  }

  return int(var_1 * maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51(var_2), var_0));
}

waittill_touching(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  while(isDefined(self) && isDefined(var_0)) {
    if(self istouching(var_0)) {
      return;
    }
    wait(var_1);
  }
}

clear_all_zombies() {
  maps\mp\gametypes\zombies::_id_08B2((0, 0, 0), 1);
  waitframe();

  foreach(var_1 in _id_0547::_id_408F()) {
    var_1 suicide();
  }
}

add_difficulty_setting(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.zmb_island_difficulty_settings)) {
    level.zmb_island_difficulty_settings = [];
  }

  var_5 = 4;
  level.zmb_island_difficulty_settings[var_0] = [];

  if(_isarray(var_1)) {
    level.zmb_island_difficulty_settings[var_0] = var_1;
    return;
  } else if(isDefined(var_3)) {
    level.zmb_island_difficulty_settings[var_0] = spawnStruct();
    level.zmb_island_difficulty_settings[var_0].minval = var_1;
    level.zmb_island_difficulty_settings[var_0].maxval = var_2;
    level.zmb_island_difficulty_settings[var_0]._id_3F02 = var_3;
    level.zmb_island_difficulty_settings[var_0]._id_6E5C = var_4;
  } else {
    for(var_6 = 0; var_6 < var_5; var_6++) {
      var_7 = get_player_frac(var_6 + 1);
      level.zmb_island_difficulty_settings[var_0][var_6] = _func_2CA(var_1, var_2, var_7);
    }
  }
}

get_player_frac(var_0) {
  var_1 = 4;
  return (var_0 - 1) / (var_1 - 1);
}

wait_one_round_bomber() {
  var_0 = level._id_A980;
  common_scripts\utility::flag_set("flag_bomber_wave_punished");

  while(level._id_A980 <= var_0) {
    wait 0.125;
  }

  common_scripts\utility::_id_3C7B("flag_bomber_wave_punished");
}