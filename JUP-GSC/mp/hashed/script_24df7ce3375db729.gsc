/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_24df7ce3375db729.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_39d11000e476a42a;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_46c7c73b1a7e4773;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_64351208cb856df9;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#using scripts\ob\points;
#namespace namespace_9009ac93da54a15e;

function function_7105d76c89d3fea3() {
  thread function_7af4fc80d8a7506f();

  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 0, &function_dd230c7848b7248);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 1, &function_757a0db88492fac3);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 2, &function_544acb4d7f48c28f);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 3, &function_6f879c9d431b663a);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 4, &function_25295fdd3cc070a3);
  activity_common::function_89384091f7a2dbd("REV_OB_ZOMBIE_CONTROL", 5, &function_bfe0732d980d4854);
  activity_common::function_8b5b2a3392fc7e2a("PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_ZOMBIE_CONTROL");
  activity_common::function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_ZOMBIE_CONTROL");
  activity_common::function_8b5b2a3392fc7e2a("PlayerAbandon", &function_540f9b357f3b5419, "REV_OB_ZOMBIE_CONTROL");
  level._effect["spore_pulse"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field_burst_os.vfx");
  level._effect["spore_pulse_red"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field_burst_os_red.vfx");
  level._effect["spore_impact"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field_cocoon_imp.vfx");
  level._effect["shield_impact"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field_shell_imp.vfx");
  level._effect["spore_field"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_field.vfx");
}

function function_dd230c7848b7248() {
  self.variant_definition = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);
  self.var_7877363178ded3e8 = "s_" + tolower(self.varianttag);
  [self.var_b05cfa500862b245] = utility::getStructArray(self.var_7877363178ded3e8, "targetname");
  self.var_4a30e8b5f565a933 = [];
  self.var_4a30e8b5f565a933["difficulty_easy"] = [];
  self.var_4a30e8b5f565a933["difficulty_normal"] = [];
  self.var_4a30e8b5f565a933["difficulty_hard"] = [];
  self.var_4a30e8b5f565a933["difficulty_darkaether"] = [];

  foreach(struct in self.variant_definition.var_422eb765983e90c5) {
    self.var_4a30e8b5f565a933["difficulty_easy"] = utility::function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_easy"], struct.var_a1e98b53400b28c8);
  }

  foreach(struct in self.variant_definition.var_281c814a12a5fbdc) {
    self.var_4a30e8b5f565a933["difficulty_normal"] = utility::function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_normal"], struct.var_a1e98b53400b28c8);
  }

  foreach(struct in self.variant_definition.var_8c0b78f0914cd95e) {
    self.var_4a30e8b5f565a933["difficulty_hard"] = utility::function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_hard"], struct.var_a1e98b53400b28c8);
  }

  foreach(struct in self.variant_definition.var_5e51b0e42b6825a5) {
    self.var_4a30e8b5f565a933["difficulty_darkaether"] = utility::function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_darkaether"], struct.var_a1e98b53400b28c8);
  }

  self.var_61b9e0a9072d1322 = [];
  self.var_61b9e0a9072d1322["difficulty_easy"] = [];
  self.var_61b9e0a9072d1322["difficulty_normal"] = [];
  self.var_61b9e0a9072d1322["difficulty_hard"] = [];
  self.var_61b9e0a9072d1322["difficulty_darkaether"] = [];

  foreach(struct in self.variant_definition.var_36580a8603f37d28) {
    self.var_61b9e0a9072d1322["difficulty_easy"] = utility::function_6d6af8144a5131f1(self.var_61b9e0a9072d1322["difficulty_easy"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_d5f514e3f40b591f) {
    self.var_61b9e0a9072d1322["difficulty_normal"] = utility::function_6d6af8144a5131f1(self.var_61b9e0a9072d1322["difficulty_normal"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_202004aa59cd95a5) {
    self.var_61b9e0a9072d1322["difficulty_hard"] = utility::function_6d6af8144a5131f1(self.var_61b9e0a9072d1322["difficulty_hard"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_8db5d77e931fbc88) {
    self.var_61b9e0a9072d1322["difficulty_darkaether"] = utility::function_6d6af8144a5131f1(self.var_61b9e0a9072d1322["difficulty_darkaether"], struct.var_42dc5ba76891bff9);
  }

  self.var_451f96515b100237 = [];

  foreach(struct in self.variant_definition.var_bf3f48b7d2da1848) {
    if(isDefined(struct.var_f5ed9f20966ab692)) {
      self.var_451f96515b100237[struct.var_f5ed9f20966ab692] = utility::function_6d6af8144a5131f1(self.var_451f96515b100237[struct.var_f5ed9f20966ab692], struct.special_encounter);
    }
  }

  self.var_e9c1fd52868a6722 = [];
  self.var_e9c1fd52868a6722["location"] = [];
  self.var_e245ba1b36b148a3 = [];
  self.var_e245ba1b36b148a3["zombie_hellhound"] = 0;
  self.var_e245ba1b36b148a3["zombie_base_armored_heavy"] = 0;
  self.var_e245ba1b36b148a3["zombie_base_armored_light"] = 0;
  self.var_e245ba1b36b148a3["zombie_base"] = 0;
  self.var_e245ba1b36b148a3["zombie_mangler"] = 0;
  self.var_e245ba1b36b148a3["zombie_disciple"] = 0;
  self.var_e245ba1b36b148a3["zombie_mimic"] = 0;
  self.var_bdca411dd4bdd1 = [];
  self.var_bdca411dd4bdd1["difficulty_easy"] = [];
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_location_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_location_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_easy"]["wave_location_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_hellhound"] = 2;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_base_armored_heavy"] = 4;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_base_armored_light"] = 4;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_base"] = 5;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_mangler"] = 1;
  self.var_bdca411dd4bdd1["difficulty_easy"]["zombie_disciple"] = 1;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_mimic"] = 1;
  self.var_bdca411dd4bdd1["difficulty_normal"] = [];
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_location_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_location_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_normal"]["wave_location_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_hellhound"] = 2;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_base_armored_heavy"] = 5;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_base_armored_light"] = 5;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_base"] = 5;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_mangler"] = 1;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_disciple"] = 1;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_mimic"] = 1;
  self.var_bdca411dd4bdd1["difficulty_hard"] = [];
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_location_1"] = 3;
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_location_2"] = 4;
  self.var_bdca411dd4bdd1["difficulty_hard"]["wave_location_3"] = 5;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_hellhound"] = 3;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_base_armored_heavy"] = 6;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_base_armored_light"] = 6;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_base"] = 5;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_mangler"] = 2;
  self.var_bdca411dd4bdd1["difficulty_hard"]["zombie_disciple"] = 1;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_mimic"] = 1;
  self.var_bdca411dd4bdd1["difficulty_darkaether"] = [];
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_1"] = 4;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_2"] = 5;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_3"] = 6;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_location_1"] = 4;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_location_2"] = 5;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["wave_location_3"] = 6;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_hellhound"] = 3;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_base_armored_heavy"] = 7;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_base_armored_light"] = 7;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_base"] = 6;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_mangler"] = 2;
  self.var_bdca411dd4bdd1["difficulty_darkaether"]["zombie_disciple"] = 2;
  self.var_bdca411dd4bdd1["difficulty_normal"]["zombie_mimic"] = 1;
  self.var_19739569e497fcd1 = [];
  self.var_19739569e497fcd1["difficulty_easy"] = 300;
  self.var_19739569e497fcd1["difficulty_normal"] = 425;
  self.var_19739569e497fcd1["difficulty_hard"] = 575;
  self.var_19739569e497fcd1["difficulty_darkaether"] = 725;
  level._effect["zombie_control_area"] = loadfx("vfx/jup/ob/vfx_ob_soul_ring.vfx");
  level._effect["zombie_control_spore_spawn"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_spawn.vfx");
  level._effect["zombie_control_spore_destroy"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_spore_destroy.vfx");
  thread setup_zombie_control();
}

function function_25295fdd3cc070a3() {
  if(!isDefined(self.var_b05cfa500862b245)) {
    var_319e90dfad369b73 = utility::getStructArray("s_" + tolower(self.varianttag), "targetname");
    return var_319e90dfad369b73[0].origin;
  }

  return self.var_b05cfa500862b245.origin;
}

function function_bfe0732d980d4854() {
  if(!isDefined(self.var_8f26e5fac9d493c3)) {
    return self.content_structs["objective_reward_struct"][0];
  }

  var_fa72b05f74204fb9 = self.var_8f26e5fac9d493c3;
  var_6c1956fd6ce84917 = 1;
  var_cc7aa96a854fd8ee = namespace_71ca15b739deab72::function_3ae7f99339b96499(var_fa72b05f74204fb9, var_6c1956fd6ce84917, 220);
  return var_cc7aa96a854fd8ee;
}

function setup_zombie_control() {
  self endon("activity_ended");
  var_f0a73224e2b13518 = utility::getStructArray(self.var_7877363178ded3e8, "target");
  self.content_structs = [];

  foreach(content_struct in var_f0a73224e2b13518) {
    if(!isDefined(content_struct.script_noteworthy)) {
      continue;
    }

    self.content_structs[content_struct.script_noteworthy] = utility::default_to(self.content_structs[content_struct.script_noteworthy], []);
    self.content_structs[content_struct.script_noteworthy] = utility::array_add(self.content_structs[content_struct.script_noteworthy], content_struct);
  }

  var_674340293d7fb2a1 = getentitylessscriptablearray(self.var_7877363178ded3e8 + "_start_scriptable", "targetname");

  if(isarray(var_674340293d7fb2a1) && var_674340293d7fb2a1.size > 0) {
    self.content_structs[var_674340293d7fb2a1[0].script_noteworthy] = var_674340293d7fb2a1;
  }

  self.var_b5abb73ae8ee13c4 = self.content_structs["zombie_control_start_interact_inhibitor_model"][0];
  self.var_144a30f17f9670b0 = default_to(self.content_structs["zombie_control_quest_circle"][0], self.var_b5abb73ae8ee13c4);
  self.var_14424c0e967b4241 = [];
  self.var_ade5f3330c853440 = 0;
  self.var_bfd712ec076ad829 = self.content_structs["control_spawn_point"];
  self.var_d29404f2ecabd562 = self.var_bfd712ec076ad829;
  self.control_points_destroyed = 0;
  self.contract_complete = 0;
  self.var_f8a6f75f7795cacb = 1;
  self.var_950a1d674c052052 = 0;
  self.difficulty_region = function_415547ee4122c2ca();
  namespace_4fda5d7358015a06::function_b6fc2c96b463c007(self);
}

function zombie_control_start_interact() {
  self endon("activity_ended");
  function_5db678d359c61a6f();
  self.inhibitor_toolbox = spawnscriptable("ob_cache_inhibitor_toolbox", self.content_structs["zombie_control_start_interact_inhibitor_model"][0].origin, self.content_structs["zombie_control_start_interact_inhibitor_model"][0].angles);
  self.inhibitor_toolbox setscriptablepartstate("body", "closed_usable");
  self.inhibitor_toolbox.objective_instance = self;
  common_cache::fillcontentsfromlist(self.inhibitor_toolbox, "ob_jup_items_cache_inhibitor_toolbox", 4);
  self.inhibitor_toolbox callback::add("on_cache_closed", &function_55a1a39cc1a3bc4e);
  scriptable::scriptable_addusedcallback(&function_ba99ee1ab267e97f);
  thread function_965043913bb0310d();
  thread function_c059aea4f30a95e1();
  thread function_17409c55b9259362();
  self waittill("toolbox_first_interact");

  if(isarray(self.content_structs["start_scriptable"])) {
    self.content_structs["start_scriptable"][0] notify("trigger");
  }

  thread function_fc8b36f6f52a356d();
}

function function_965043913bb0310d() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.inhibitor_toolbox endon("death");

  foreach(player in level.players) {
    self.inhibitor_toolbox disablescriptableplayeruse(player);
  }

  self.var_1e3d862c39b84a24 = self.playerparticipants;

  foreach(player in self.var_1e3d862c39b84a24) {
    self.inhibitor_toolbox enablescriptableplayeruse(player);
  }

  while(true) {
    if(!isDefined(self.inhibitor_toolbox)) {
      return;
    }

    foreach(player in self.var_1e3d862c39b84a24) {
      if(isPlayer(player) && !utility::array_contains(self.playerparticipants, player)) {
        self.inhibitor_toolbox disablescriptableplayeruse(player);
        self.var_1e3d862c39b84a24 utility::array_remove(self.var_1e3d862c39b84a24, player);
      }
    }

    foreach(player in self.playerparticipants) {
      if(isPlayer(player) && !utility::array_contains(self.playerparticipants, player)) {
        self.inhibitor_toolbox enablescriptableplayeruse(player);
        self.var_1e3d862c39b84a24 utility::array_add(self.var_1e3d862c39b84a24, player);
      }
    }

    wait 1;
  }
}

function function_ba99ee1ab267e97f(instance, part, state, player, bautouse, usestring) {
  if(!function_458c1f5cd882144(instance.type)) {
    return;
  }

  if(isDefined(instance.objective_instance) && !istrue(instance.toolbox_first_interact)) {
    instance.toolbox_first_interact = 1;
    instance.objective_instance notify("toolbox_first_interact");

    if(isPlayer(instance.objective_instance.ping_owner)) {
      instance.objective_instance.ping_owner scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(instance.objective_instance.ping_index);
    }

    if(!instance.objective_instance.on_mission) {
      instance.objective_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_sporecontrol_inihibitor_collect_conv");
    }

    objidpoolmanager::objective_playermask_hidefrom(instance.objective_instance.var_dbecfcc0c094d1b1, player);
  }
}

function function_55a1a39cc1a3bc4e(params) {
  if(!function_458c1f5cd882144(self.type)) {
    return;
  }

  if(isarray(self.contents) && isDefined(self.objective_instance)) {
    empty_slots = 0;

    foreach(item in self.contents) {
      if(is_equal(item.lootid, 0) && is_equal(item.quantity, 0)) {
        empty_slots++;
      }
    }

    if(is_equal(empty_slots, self.contents.size)) {
      self.objective_instance namespace_c669075cf56436f4::function_765b706dc170e214(self.objective_instance.var_3d20f8f7d66c4778);
      self.objective_instance namespace_c669075cf56436f4::function_765b706dc170e214(self.objective_instance.var_dbecfcc0c094d1b1);
    }
  }
}

function function_458c1f5cd882144(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "ob_cache_inhibitor_toolbox";
}

function function_9f2ef86e9bc669ee() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  var_32ae8247ab203094 = 1000;

  while(true) {
    wait 1;
    players = [];

    if(self.playerparticipants.size > 0) {
      players = scripts\mp\utility\player::getplayersinradius(self.inhibitor_toolbox.origin, 2000, self.playerparticipants[0].team);
    }

    if(players.size > 0) {
      if(!self.on_mission) {
        thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_sporecontrol_arrive_conv");
      }

      return;
    }
  }
}

function function_50d413ddc8f582fe() {
  self.phase = "inhibitor";
  thread zombie_control_start_interact();
}

function function_fc8b36f6f52a356d() {
  self.phase = "control";
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_ZOMBIE_CONTROL_SPORE_PHASE");
  namespace_262d6474998a2356::function_c661dba3e304266b(0);

  foreach(player in self.playerparticipants) {
    player setclientomnvar("ui_br_objective_index", 9);
    player setclientomnvar("ui_br_objective_param", 0);
  }

  thread function_1d8ed7c37cd92395();
}

function function_5db678d359c61a6f() {
  self.var_cd05af3824c52cde = [];

  if(isDefined(self.content_structs["zombie_control_start_interact_soldier_a_model"]) && isDefined(self.content_structs["zombie_control_start_interact_soldier_a_model"][0].targetname)) {
    model_name = self.content_structs["zombie_control_start_interact_soldier_a_model"][0].targetname;
    spawn_struct = self.content_structs["zombie_control_start_interact_soldier_a_model"][0];
    var_6c51b0b9b13e4a89 = spawnscriptable(model_name, spawn_struct.origin, spawn_struct.angles);
    var_6c51b0b9b13e4a89 setscriptablepartstate("base", "enabled");
    self.var_cd05af3824c52cde[self.var_cd05af3824c52cde.size] = var_6c51b0b9b13e4a89;
  }

  if(isDefined(self.content_structs["zombie_control_start_interact_soldier_b_model"]) && isDefined(self.content_structs["zombie_control_start_interact_soldier_b_model"][0].targetname)) {
    model_name = self.content_structs["zombie_control_start_interact_soldier_b_model"][0].targetname;
    spawn_struct = self.content_structs["zombie_control_start_interact_soldier_b_model"][0];
    var_6c51b0b9b13e4a89 = spawnscriptable(model_name, spawn_struct.origin, spawn_struct.angles);
    var_6c51b0b9b13e4a89 setscriptablepartstate("base", "enabled");
    self.var_cd05af3824c52cde[self.var_cd05af3824c52cde.size] = var_6c51b0b9b13e4a89;
  }
}

function function_757a0db88492fac3() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.on_mission = zombie_challenges::function_f578373042c34e16(16640, "quest_s0a2t5_extr_start", self.playerparticipants);

  if(!self.on_mission) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("spore_control_start");
  }

  foreach(player in self.playerparticipants) {
    player callback::callback("spore_control_started");
  }

  thread function_9f2ef86e9bc669ee();
  thread function_50d413ddc8f582fe();
  thread function_11697105e56916b7();
  thread function_ce9bb4226b05b21e();
  self notify("zombie_control_started");
}

function function_36f4aa3b83a386f2(e_shield) {
  self endon("death");

  while(isalive(e_shield)) {
    e_shield waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, weapon, sorigin, angles, normal, einflictor, eventid);
    e_shield.health = 2000000;
    thread function_ad8c25df4e33c859(attacker, attacker, self, damage, idflags, smeansofdeath, weapon, normal, point);
  }
}

function function_c775eae1b8b1dc89(params) {
  if(isDefined(params.instance.shield_health) && params.instance.shield_health > 0) {
    if(!isPlayer(params.eattacker)) {
      return;
    }

    params.instance.shield_health -= params.idamage;
    params.instance.var_f49149402765ecae = utility::function_6d6af8144a5131f1(params.instance.var_f49149402765ecae, params.eattacker);

    if(mp_agent_damage::function_87c3b43d00319847()) {
      mp_agent_damage::function_c54b2cc2e762c201(params.eattacker, params.instance.shield, "none", "MOD_BULLET", params.einflictor.weapon_object, int(params.idamage), undefined, 0, undefined, 0, 1);
    }

    params.eattacker damagefeedback::updatehitmarker("standard", params.instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
    params.instance.shield setscriptablepartstate("shell_damage", "impact");

    if(params.instance.shield_health > 375 && params.instance.shield_health < 500) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_1");
    } else if(params.instance.shield_health > 250 && params.instance.shield_health < 375) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_2");
    }

    if(params.instance.shield_health > 125 && params.instance.shield_health < 250) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_3");
    }

    if(params.instance.shield_health <= 0) {
      params.instance function_29be25cb08d0c29();
    }
  }
}

function function_ad8c25df4e33c859(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  instance endon("death");

  if(!utility::is_equal(instance.type, "jup_ob_zombie_control_spore") || istrue(instance.destroyed)) {
    return;
  }

  if(eattacker scripts\common\vehicle::isvehicle()) {
    if(isPlayer(eattacker.owner)) {
      if(isDefined(self.var_56b0ebbb2acef6a6) && gettime() - self.var_56b0ebbb2acef6a6 < 2000) {
        return;
      }

      self.var_56b0ebbb2acef6a6 = gettime();
      eattacker = eattacker.owner;
    }
  }

  if(!isPlayer(eattacker) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(isDefined(instance.shield_health) && instance.shield_health > 0) {
    playFX(level._effect["shield_impact"], shitloc, vdir);
    instance setscriptablepartstate("spore_damage", "impact_nodamage");

    if(isPlayer(eattacker)) {
      if(mp_agent_damage::function_73075c88c97d2d50() && mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(0), undefined, 1, undefined, 0, 0);
        eattacker damagefeedback::updatehitmarker("standard", instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
      } else {
        eattacker damagefeedback::updatedamagefeedback("hitimmune", instance.var_b9cf34b729d1596e <= 0, 0);
      }
    }

    idamage = 0;
    instance.shield.fake_health = instance.var_b9cf34b729d1596e;
    return;
  }

  if(isDefined(instance.var_b9cf34b729d1596e)) {
    instance.var_b9cf34b729d1596e -= idamage;
    instance.shield.fake_health = instance.var_b9cf34b729d1596e;
    instance setscriptablepartstate("spore_damage", "impact");

    if(isPlayer(eattacker)) {
      instance.var_f49149402765ecae = utility::function_6d6af8144a5131f1(instance.var_f49149402765ecae, eattacker);

      if(mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker damagefeedback::updatehitmarker("standard", instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
    }

    playFX(level._effect["spore_impact"], shitloc, vdir);

    if(instance.var_b9cf34b729d1596e <= 0) {
      instance.shield.var_1e0eb63ecb3f1e2 = 0;
      instance thread function_925f6265c08189ca(1);
    }
  }
}

function function_11697105e56916b7() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.var_16573d54f9178a1b = [];

  for(i = 0; i < 6; i++) {
    spawn_control_point(1);
  }
}

function spawn_control_point(var_85bff92bec5e44d7) {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.var_ade5f3330c853440 += 1;
  spawn_struct = function_87f84219b48fe765();
  self.var_78f6d526cd0f800a = [];

  if(isDefined(spawn_struct)) {
    var_dcf9e92f1c7034ad = spawnStruct();
    navmesh_pos = getclosestpointonnavmesh(spawn_struct.origin);
    ground_pos = getgroundposition(navmesh_pos, 1);
    rayinfo = trace::ray_trace(ground_pos + (0, 0, 12), ground_pos - (0, 0, 999));
    raynormal = rayinfo["normal"];
    control_point = spawnscriptable("jup_ob_zombie_control_spore", ground_pos - (0, 0, 1), raynormal);
    control_point.shield = utility::spawn_model("jup_zm_spores_shell", ground_pos - (0, 0, 1), raynormal);
    control_point.shield solid();
    control_point.shield.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_spore_healthbar");
    control_point.shield.subclass_scriptbundle = getscriptbundle(%"hash_6bab55d6fc0d95fc");
    control_point.shield.subclass = control_point.shield.subclass_scriptbundle.name;
    control_point.shield setCanDamage(1);
    control_point.shield.health = 2000000;
    control_point.shield.navobstacleid = createnavobstaclebyent(control_point.shield);
    control_point thread function_36f4aa3b83a386f2(control_point.shield);
    control_point.spore_base = spawnscriptable("jup_ob_zombie_control_spore_base", ground_pos, spawn_struct.angles);
    self.var_16573d54f9178a1b = array_add(self.var_16573d54f9178a1b, control_point.spore_base);
    waitframe();
    control_point.shield.identifier = "jup_ob_zombie_control_spore";
    control_point.shield.control_point = control_point;
    control_point callback::add("shield_damaged", &function_c775eae1b8b1dc89);
    control_point.spawn_struct = spawn_struct;
    control_point.var_b9cf34b729d1596e = function_50433f9946e47cfc();
    control_point.objective_instance = self;
    control_point.var_25c4c85795f9db01 = spawn_struct;
    control_point.objective_instance.var_c78bf8036d0536b1 = control_point;
    control_point.var_f49149402765ecae = [];
    control_point.var_9f7b53f50c23948e = [];
    self.var_14424c0e967b4241 = utility::function_6d6af8144a5131f1(self.var_14424c0e967b4241, control_point);
    waitframe();
    control_point setscriptablepartstate("health", "damage_detect");
    control_point thread function_d124200a69043346();
    control_point function_133cf58c6cc00c96();
    control_point function_5d901f142e0e3a40(self);

    if(!isDefined(level.ob.spores)) {
      level.ob.spores = [];
    }

    level.ob.spores = array_add(level.ob.spores, control_point);
    return;
  }

  self.var_ade5f3330c853440 = max(0, self.var_ade5f3330c853440 - 1);
}

function function_5d901f142e0e3a40(instance) {
  game_utility::function_6b6b6273f8180522("ZombieControl_Ob", self.origin, 300);
  self.var_206ffeac182f7114 = instance.playerparticipants;

  foreach(player in self.var_206ffeac182f7114) {
    game_utility::function_cfd53c8f6878014f(player);
  }
}

function function_54c46311ea3c60be() {
  game_utility::function_af5604ce591768e1();
}

function function_87f84219b48fe765() {
  if(!isarray(self.var_bfd712ec076ad829)) {
    return undefined;
  }

  if(utility::is_equal(self.var_bfd712ec076ad829.size, 0)) {
    self.var_bfd712ec076ad829 = self.var_d29404f2ecabd562;
  }

  selected_index = 0;
  spawnpt_struct = undefined;
  var_9907d14293e5472f = namespace_8480efeffcd6e233::function_7ec62d1550b9897e(self, "Awareness_Zone");

  for(i = 0; i < 12; i++) {
    var_d93a6089292a4660 = 1;
    selected_index = randomint(self.var_bfd712ec076ad829.size);

    foreach(player in var_9907d14293e5472f) {
      if(distancesquared(player.origin, self.var_bfd712ec076ad829[selected_index].origin) < 4096) {
        var_d93a6089292a4660 = 0;
      }
    }

    if(istrue(var_d93a6089292a4660)) {
      spawnpt_struct = self.var_bfd712ec076ad829[selected_index];
      break;
    }
  }

  if(!isDefined(spawnpt_struct)) {
    spawnpt_struct = self.var_bfd712ec076ad829[selected_index];
    offset_origin = spawnpt_struct.origin + (64, 64, 0);
    var_f5a5c006177cc94d = getclosestpointonnavmesh(offset_origin);
    spawnpt_struct.origin = var_f5a5c006177cc94d;
  }

  self.var_bfd712ec076ad829 = utility::array_remove_index(self.var_bfd712ec076ad829, selected_index);
  self.var_d29404f2ecabd562 = utility::array_remove_index(self.var_d29404f2ecabd562, selected_index);
  return spawnpt_struct;
}

function function_133cf58c6cc00c96() {
  self endon("death");
  function_ef78359994963366();
  self.shield.health = 2000000;
  self.objective_instance.var_ade5f3330c853440 = max(0, self.objective_instance.var_ade5f3330c853440 - 1);
  thread function_9e4aac8d77f2d80c();
  thread function_c75381b9c6262b9f();
}

function function_ef78359994963366() {
  self endon("death");
  self.shield endon("death");

  if(!isDefined(self.shield)) {
    return;
  }

  self notify("shielded");

  if(is_equal(self.shielded_state, "inactive")) {
    self.shield setscriptablepartstate("damage_states", "regenerate");
  }

  self.shield solid();
  self.shielded_state = "active";
  self.shield_health = 500;
  self.shield setscriptablepartstate("shield", "shielded");
  self setscriptablepartstate("shield", "shielded");
  self.shield.var_4919d15787f01154 = 0;
  self.shield.var_1e0eb63ecb3f1e2 = 0;
  self.shield.fake_health = self.objective_instance function_50433f9946e47cfc();
  self.shield.max_fake_health = self.objective_instance function_50433f9946e47cfc();
}

function function_29be25cb08d0c29() {
  self endon("death");
  self notify("unshielded");
  self.shield solid();
  self.shield setscriptablepartstate("damage_states", "damage_state_4");
  self.shielded_state = "inactive";
  self.shield setscriptablepartstate("shield", "destroyed");
  self setscriptablepartstate("shield", "unshielded");
  thread function_b444cc129345d426();
  self.shield.var_1e0eb63ecb3f1e2 = 1;
  self.shield.var_4919d15787f01154 = 1;
  self.shield.fake_health = self.objective_instance function_50433f9946e47cfc();
  self.shield.health = self.shield.fake_health;
  self.shield.max_fake_health = self.objective_instance function_50433f9946e47cfc();
}

function function_b444cc129345d426() {
  self endon("death");
  var_9f9ce3d7aa616f07 = gettime();
  var_deedc2a699d2b4a0 = 0;

  while(true) {
    if(isarray(self.var_9f7b53f50c23948e) && is_equal(self.var_9f7b53f50c23948e.size, 0)) {
      if(istrue(var_deedc2a699d2b4a0)) {
        var_9f9ce3d7aa616f07 = gettime();
      }

      var_deedc2a699d2b4a0 = 0;
    } else {
      var_deedc2a699d2b4a0 = 1;
    }

    if(!var_deedc2a699d2b4a0 && gettime() - var_9f9ce3d7aa616f07 > 5000) {
      function_ef78359994963366();

      if(isDefined(self.objective_instance)) {
        self.objective_instance.var_950a1d674c052052 = 1;
      }

      return;
    }

    wait 1;
  }
}

function function_c75381b9c6262b9f() {
  self endon("death");
  self.objective_instance endon("activity_ended");
  self.objective_instance endon("instance_destroyed");
  self.players_nearby = player::getplayersinradius(self.origin, 200);

  while(true) {
    players = player::getplayersinradius(self.origin, 200);

    foreach(player in players) {
      if(isDefined(player)) {
        if(!utility::array_contains(self.players_nearby, player) && !is_equal(player getscriptablepartstate("ob_spore_fx"), "spore_fx_on")) {
          player setscriptablepartstate("ob_spore_fx", "spore_fx_on");
          player.nearby_spore = self;
          self.players_nearby = utility::function_6d6af8144a5131f1(self.players_nearby, player);

          if(!istrue(player.var_e23ddb97da39365)) {
            player thread function_bce9ee9a0fc6f5fe(self.objective_instance);
          }
        }
      }
    }

    foreach(player in self.players_nearby) {
      if(isDefined(player)) {
        if(!utility::array_contains(players, player) && !is_equal(player getscriptablepartstate("ob_spore_fx"), "spore_fx_stop")) {
          player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
          player.nearby_spore = undefined;
          self.players_nearby = utility::array_remove(self.players_nearby, player);
        }
      }
    }

    wait 0.25;
  }
}

function function_bce9ee9a0fc6f5fe(instance) {
  self endon("disconnect");
  instance endon("instance_destroyed");
  self.var_e23ddb97da39365 = 1;

  while(true) {
    if(!isDefined(self.nearby_spore) && is_equal(self getscriptablepartstate("ob_spore_fx"), "spore_fx_on")) {
      self setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
    }

    wait 0.5;
  }
}

function function_9e4aac8d77f2d80c() {
  self endon("death");
  self setscriptablepartstate("ground_vfx", "active");
  self setscriptablepartstate("pulse", "active");

  while(true) {
    if(is_equal(self.shielded_state, "inactive")) {
      playFX(level._effect["spore_pulse_red"], self.origin);
    } else {
      playFX(level._effect["spore_pulse"], self.origin);
    }

    self setscriptablepartstate("pulse_audio", "pulse");
    players = player::getplayersinradius(self.origin, 200);

    foreach(player in players) {
      var_bc8818c262ac2b04 = 10;

      if(player.health - 10 < 1) {
        var_bc8818c262ac2b04 = 10 + player.health - 10 - 1;
      }

      player dodamage(var_bc8818c262ac2b04, self.origin, player, player, "MOD_TRIGGER_HURT");
    }

    wait 3;
  }
}

function function_dbdbea19c234b48c() {
  if(isarray(self.var_14424c0e967b4241)) {
    foreach(control_point in self.var_14424c0e967b4241) {
      control_point function_925f6265c08189ca();
    }
  }
}

function function_925f6265c08189ca(var_78b9aeb5ca65e86f) {
  self endon("death");

  if(istrue(self.destroyed)) {
    return;
  }

  if(istrue(var_78b9aeb5ca65e86f) && !is_equal(self.objective_instance.phase, "control")) {
    self.objective_instance function_fc8b36f6f52a356d();
  }

  self.destroyed = 1;

  if(isDefined(self.shield)) {
    if(isDefined(self.shield.navobstacleid)) {
      destroynavobstacle(self.shield.navobstacleid);
      self.shield.navobstacleid = undefined;
    }

    self.shield delete();
  }

  self setscriptablepartstate("body", "destroyed");
  function_1e2b64e8e860a307();
  self.objective_instance.var_14424c0e967b4241 = utility::array_remove(self.objective_instance.var_14424c0e967b4241, self);
  self.objective_instance.var_ade5f3330c853440 = max(0, self.objective_instance.var_ade5f3330c853440 - 1);

  if(utility::is_equal(self.objective_instance.control_points_destroyed, 0)) {
    self.objective_instance function_405a23317f287e0a();
  }

  self.objective_instance.control_points_destroyed++;
  self.objective_instance namespace_262d6474998a2356::function_c661dba3e304266b(self.objective_instance.control_points_destroyed);

  if(self.objective_instance.control_points_destroyed > 2 && self.objective_instance.control_points_destroyed < 2 * 2) {
    self.objective_instance function_950fa7e52fc16f65(2);
  } else if(self.objective_instance.control_points_destroyed >= 2 * 2) {
    self.objective_instance function_950fa7e52fc16f65(3);
  } else {
    self.objective_instance function_950fa7e52fc16f65(1);
  }

  if(istrue(var_78b9aeb5ca65e86f) && self.objective_instance.control_points_destroyed >= 6) {
    self.objective_instance.var_8f26e5fac9d493c3 = self.origin;
    self.objective_instance notify("all_control_points_destroyed");
  } else if(!self.objective_instance.on_mission && (!isDefined(self.objective_instance.var_715178ed66499339) || gettime() > self.objective_instance.var_715178ed66499339 + 45000)) {
    self.objective_instance.var_715178ed66499339 = gettime();
    self.objective_instance thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_sporecontrol_spore_eliminated");
  }

  if(isarray(self.var_f49149402765ecae)) {
    foreach(player in self.var_f49149402765ecae) {
      player points::function_ddee59d6b1a2b9e(#"hash_6d900cfbbe7dbb30");
    }
  }

  self notify("control_point_stop_thinking");
  function_54c46311ea3c60be();
  self.objective_instance.var_d29404f2ecabd562 = utility::array_add(self.objective_instance.var_d29404f2ecabd562, self.var_25c4c85795f9db01);
  wait 1;

  if(isarray(self.players_nearby)) {
    foreach(player in self.players_nearby) {
      if(isDefined(player)) {
        player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
      }
    }
  }

  self freescriptable();
  self notify("death");
}

function function_950fa7e52fc16f65(var_37f3682d493918a1) {
  self.wave_number = var_37f3682d493918a1;
  function_ef5b69bfb2654b4();
}

function function_ce9bb4226b05b21e() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self waittill("all_control_points_destroyed");
  function_66629e64959d95e5();
}

function function_765f206e8010b6b3(player) {
  if(utility::is_equal(self.objective_instance.phase, "inhibitor")) {
    self notify("zombie_control_start");
  }

  fakeitem = spawnStruct();
  fakeitem.type = "obloot_offhand_inhibitor";
  fakeitem.count = 1;
  fakeitem.fromcache = 0;
  player common_item::function_de489fa2ffdb7f2d(fakeitem, 0);
}

function function_1d8ed7c37cd92395() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.wave_number = 1;
}

function function_27b28d74be03501b(control_point, wave_number) {
  self endon("activity_ended");

  if(!isDefined(self.var_61b9e0a9072d1322[self.difficulty_region][0])) {
    return;
  }

  if(istrue(control_point.var_712ef29aebb75103)) {
    return;
  }

  var_934083a148144947 = "ai_flood_fill_encounter:" + self.var_61b9e0a9072d1322[self.difficulty_region][0];
  request_id = namespace_80f1ffea676eeeaa::function_f8ccadcd850da124(var_934083a148144947, control_point.origin, 800, 1, 0, 1, 2);
  namespace_80f1ffea676eeeaa::function_ce9c21523336cdbc(request_id, &function_335743e3da68cf7e, self);
  function_d37068aac7785c04(request_id, "base_zombie", 1);
  encounter_params = spawnStruct();
  encounter_params.request_id = request_id;
  encounter_params.control_point = control_point;
  encounter_params.var_198843bede81a3d5 = gettime();
  control_point.var_7c0039b86afdec4 = request_id;
  self.var_e9c1fd52868a6722["location"][request_id] = encounter_params;
  ai_spawn_director::function_bc5315dc37ae4cf(request_id, &function_6bf6b79b9f0b8236, self);
  ai_spawn_director::function_73147cdf5c28d10c(request_id, &function_24dbc4ad18d2aade, self);
  function_ab358ecbff440304(request_id, wave_number);
}

function function_ab358ecbff440304(request_id, wave_number) {
  if(isDefined(self.var_e9c1fd52868a6722["location"])) {
    var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_location_1");

    switch (wave_number) {
      case 1:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_location_1");
        break;
      case 2:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_location_2");
        break;
      case 3:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_location_3");
        break;
    }

    function_4b7d420e1bad897f(request_id, var_5390af79cb787f4f);
  }
}

function function_405a23317f287e0a() {
  self endon("activity_ended");

  if(!isDefined(self.var_4a30e8b5f565a933[self.difficulty_region][0])) {
    return;
  }

  var_934083a148144947 = "ai_flood_fill_encounter:" + self.var_4a30e8b5f565a933[self.difficulty_region][0];
  request_id = namespace_80f1ffea676eeeaa::function_f8ccadcd850da124(var_934083a148144947, self.var_144a30f17f9670b0.origin, 2000, 1, 0, 1, 2);
  namespace_80f1ffea676eeeaa::function_ce9c21523336cdbc(request_id, &function_335743e3da68cf7e, self);
  function_d37068aac7785c04(request_id, "base_zombie", 1);
  encounter_params = spawnStruct();
  encounter_params.request_id = request_id;
  encounter_params.wave_number = self.wave_number;
  self.var_e9c1fd52868a6722["ambient"] = encounter_params;
  ai_spawn_director::function_bc5315dc37ae4cf(request_id, &function_b5a2024b4e4f9e97, self);
  ai_spawn_director::function_73147cdf5c28d10c(request_id, &function_b4bb2aa392c3c44b, self);
  function_4b7d420e1bad897f(request_id, function_58bc8439fdf4e1b("wave_1"));
}

function function_ef5b69bfb2654b4() {
  if(isDefined(self.var_e9c1fd52868a6722["ambient"]) && self.var_e9c1fd52868a6722["ambient"].size > 0) {
    var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_1");

    switch (self.wave_number) {
      case 1:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_1");
        break;
      case 2:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_2");
        break;
      case 3:
        var_5390af79cb787f4f = function_58bc8439fdf4e1b("wave_3");
        break;
    }

    function_4b7d420e1bad897f(self.var_e9c1fd52868a6722["ambient"].request_id, var_5390af79cb787f4f);
  }
}

function function_c231f9a4c4cd9b45(spawn_origin) {
  self endon("activity_ended");

  if(utility::is_equal(self.difficulty_region, "difficulty_easy")) {
    return;
  }

  var_b227e87491386337 = function_6a4adea808080a34();

  if(!isDefined(var_b227e87491386337)) {
    return;
  }

  str_encounter = "ai_encounter:" + self.var_451f96515b100237["specials"][0];
  request_id = namespace_80f1ffea676eeeaa::function_f8ccadcd850da124(str_encounter, spawn_origin, 800, 1, 0, 1, 2);
  namespace_80f1ffea676eeeaa::function_ce9c21523336cdbc(request_id, &function_335743e3da68cf7e, self);
  function_d37068aac7785c04(request_id, var_b227e87491386337, 1);
  function_a0ebac5daa1b4f4b(request_id, self.difficulty_region);
}

function function_d124200a69043346() {
  self endon("death");

  while(true) {
    self.var_9f7b53f50c23948e = utility::array_removeundefined(self.var_9f7b53f50c23948e);

    if(utility::is_equal(self.objective_instance.phase, "control") && (!isDefined(self.var_7c0039b86afdec4) || !isDefined(self.objective_instance.var_e9c1fd52868a6722["location"][self.var_7c0039b86afdec4])) && isarray(self.var_9f7b53f50c23948e) && self.var_9f7b53f50c23948e.size > 0) {
      self.objective_instance.var_940c0f5fb629479b = 1;
      self.objective_instance function_27b28d74be03501b(self, self.objective_instance.wave_number);
      self.objective_instance function_f44014e875d7b1fd(self);
    }

    wait 1;
  }
}

function function_6a4adea808080a34() {
  var_12d878a8b860195d = [];

  if(isDefined(self.var_e245ba1b36b148a3["zombie_mangler"]) && self.var_e245ba1b36b148a3["zombie_mangler"] < function_58bc8439fdf4e1b("zombie_mangler")) {
    var_12d878a8b860195d = array_add(var_12d878a8b860195d, "mangler");
  }

  if(isDefined(self.var_e245ba1b36b148a3["zombie_disciple"]) && self.var_e245ba1b36b148a3["zombie_disciple"] < function_58bc8439fdf4e1b("zombie_disciple")) {
    var_12d878a8b860195d = array_add(var_12d878a8b860195d, "disciple");
  }

  if(var_12d878a8b860195d.size > 0) {
    return array_random(var_12d878a8b860195d);
  }

  return undefined;
}

function function_f44014e875d7b1fd(spawn_struct) {
  if(!isDefined(self.wave_number)) {
    return;
  }

  special_chance = 0;

  switch (self.wave_number) {
    case 1:
      special_chance = 100;
      break;
    case 2:
      special_chance = 65;
      break;
    case 3:
      special_chance = 35;
      break;
    default:
      return;
  }

  special_chance = randomintrange(1, special_chance);

  if(special_chance > 0 && special_chance < 25) {
    function_c231f9a4c4cd9b45(spawn_struct.origin);
  }
}

function function_415547ee4122c2ca() {
  difficulty_region = undefined;

  if(isDefined(level.var_fac39a693f085779)) {
    difficulty_region = [[level.var_fac39a693f085779]](namespace_4fda5d7358015a06::function_8988a4c89289d7f4(self));
  }

  if(!isDefined(difficulty_region) || utility::is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_6bf6b79b9f0b8236(requestid, userdata) {
  function_d37068aac7785c04(requestid, "hellhound", 0);
  function_d37068aac7785c04(requestid, "light_armored_zombie", 0);
  function_d37068aac7785c04(requestid, "heavy_armored_zombie", 0);
  function_d37068aac7785c04(requestid, "base_zombie", 0);
  var_b227e87491386337 = userdata function_a1080ca0704d2c39();

  if(isDefined(var_b227e87491386337)) {
    function_d37068aac7785c04(requestid, var_b227e87491386337, 1);
  }

  return true;
}

function function_b5a2024b4e4f9e97(requestid, userdata) {
  function_d37068aac7785c04(requestid, "hellhound", 0);
  function_d37068aac7785c04(requestid, "light_armored_zombie", 0);
  function_d37068aac7785c04(requestid, "heavy_armored_zombie", 0);
  function_d37068aac7785c04(requestid, "base_zombie", 0);
  var_b227e87491386337 = userdata function_a1080ca0704d2c39();

  if(isDefined(var_b227e87491386337)) {
    function_d37068aac7785c04(requestid, var_b227e87491386337, 1);
  }

  if(!isarray(userdata.var_e9c1fd52868a6722["location"]) || is_equal(userdata.var_e9c1fd52868a6722["location"].size, 0)) {
    if(!isDefined(userdata.var_c01af6d274360064)) {
      userdata.var_c01af6d274360064 = gettime();
    }

    var_3551c01e421abf6b = getdvarint(@ "hash_882db5bb8e1f25b0", 20000);

    if(gettime() > userdata.var_c01af6d274360064 + var_3551c01e421abf6b) {
      userdata.var_9b48607aa4f81592 = 1;
      return false;
    }
  } else {
    userdata.var_c01af6d274360064 = undefined;
    userdata.var_9b48607aa4f81592 = 0;
  }

  return true;
}

function function_a1080ca0704d2c39() {
  str_aitype = "base_zombie";

  if(utility::percent_chance(20) && isDefined(self.var_e245ba1b36b148a3["zombie_hellhound"]) && self.var_e245ba1b36b148a3["zombie_hellhound"] < function_58bc8439fdf4e1b("zombie_hellhound")) {
    str_aitype = "hellhound";
  } else if(utility::percent_chance(35) && isDefined(self.var_e245ba1b36b148a3["zombie_base_armored_light"]) && self.var_e245ba1b36b148a3["zombie_base_armored_light"] < function_58bc8439fdf4e1b("zombie_base_armored_light") && utility::is_equal(self.difficulty_region, "difficulty_normal")) {
    str_aitype = "light_armored_zombie";
  } else if(utility::percent_chance(35) && isDefined(self.var_e245ba1b36b148a3["zombie_base_armored_heavy"]) && self.var_e245ba1b36b148a3["zombie_base_armored_heavy"] < function_58bc8439fdf4e1b("zombie_base_armored_heavy") && function_8fbf2d2648c5c8c5(self.difficulty_region, "difficulty_hard")) {
    str_aitype = "heavy_armored_zombie";
  }

  return str_aitype;
}

function function_8fbf2d2648c5c8c5(difficulty_region, var_38571731af34358a) {
  if(is_equal(difficulty_region, var_38571731af34358a)) {
    return true;
  }

  if(is_equal(difficulty_region, "difficulty_easy") || is_equal(difficulty_region, "difficulty_undefined")) {
    return false;
  }

  if(is_equal(difficulty_region, "difficulty_normal") && (is_equal(var_38571731af34358a, "difficulty_hard") || is_equal(var_38571731af34358a, "difficulty_darkaether"))) {
    return false;
  }

  if(is_equal(difficulty_region, "difficulty_hard") && is_equal(var_38571731af34358a, "difficulty_darkaether")) {
    return false;
  }

  return true;
}

function function_f24631baf1209b1d(requestid, userdata) {
  return false;
}

function function_335743e3da68cf7e(requestid, userdata, agent, data) {
  if(userdata.var_f8a6f75f7795cacb) {
    if(!userdata.on_mission) {
      userdata thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_sporecontrol_first_zombie_spawn");
    }

    userdata.var_f8a6f75f7795cacb = 0;
  }

  if(isDefined(userdata.var_e245ba1b36b148a3)) {
    if(!isDefined(userdata.var_e245ba1b36b148a3[agent.subclass])) {
      userdata.var_e245ba1b36b148a3[agent.subclass] = 0;
    }

    userdata.var_e245ba1b36b148a3[agent.subclass]++;
  }

  agent.var_df13bc784addc5a = userdata;
  agent thread zombie_death_watcher();
  agent thread function_c9ce2ea582e3e3c7(userdata);
}

function function_b4bb2aa392c3c44b(requestid, userdata) {
  if(!isDefined(userdata)) {
    return true;
  }

  if(!isarray(userdata.var_e9c1fd52868a6722)) {
    return true;
  }

  if(!isDefined(userdata.var_e9c1fd52868a6722["ambient"].request_id)) {
    return true;
  }

  if(istrue(userdata.contract_complete)) {
    return true;
  }

  return false;
}

function function_24dbc4ad18d2aade(requestid, userdata) {
  result = 0;
  var_6432982cf5e9726a = getdvarint(@ "hash_996bab8db4fbf2aa", 45000);

  if(!isDefined(userdata)) {
    result = 1;
  } else if(!isarray(userdata.var_e9c1fd52868a6722)) {
    result = 1;
  } else if(!isDefined(userdata.var_e9c1fd52868a6722["location"][requestid]) || !isDefined(userdata.var_e9c1fd52868a6722["location"][requestid].control_point)) {
    result = 1;
  } else if(isDefined(userdata.var_e9c1fd52868a6722["location"][requestid].var_198843bede81a3d5) && gettime() > userdata.var_e9c1fd52868a6722["location"][requestid].var_198843bede81a3d5 + var_6432982cf5e9726a) {
    if(isDefined(userdata.var_e9c1fd52868a6722["location"][requestid].control_point)) {
      userdata.var_e9c1fd52868a6722["location"][requestid].control_point.var_712ef29aebb75103 = 1;
    }

    result = 1;
  } else if(isDefined(userdata.var_e9c1fd52868a6722["location"][requestid].control_point) && isarray(self.var_9f7b53f50c23948e) && self.var_9f7b53f50c23948e.size > 0) {
    result = 1;
  }

  if(istrue(result)) {
    userdata.var_e9c1fd52868a6722["location"] = array_remove_key(userdata.var_e9c1fd52868a6722["location"], requestid);
  }

  return result;
}

function function_33380f94361e2f5e() {
  struct_origin = self.origin;
  valid_points = [];
  var_5ac1024b00cecc71 = (0, 0, 48);
  i = 0;

  while(i < 360) {
    x1 = 200 * cos(i * 57.2958);
    y1 = 200 * sin(i * 57.2958);
    check_pt = struct_origin + (x1, y1, 0);
    pos_on_navmesh = getclosestpointonnavmesh(check_pt);

    if(isDefined(pos_on_navmesh)) {
      valid_points[valid_points.size] = pos_on_navmesh;
    }

    i += 40;
  }

  self.var_3fa44b93882f1abd = [];

  foreach(spawn_pt in valid_points) {
    var_3de4d21ad927da59 = utility::spawn_model("t10_zm_crystal_medium_01_dmg", spawn_pt);
    var_3de4d21ad927da59 notsolid();
    self.var_3fa44b93882f1abd = utility::array_add(self.var_3fa44b93882f1abd, var_3de4d21ad927da59);
  }
}

function function_1e2b64e8e860a307() {
  if(!isarray(self.var_3fa44b93882f1abd)) {
    return;
  }

  foreach(var_3de4d21ad927da59 in self.var_3fa44b93882f1abd) {
    if(isDefined(var_3de4d21ad927da59)) {
      var_3de4d21ad927da59 delete();
    }
  }
}

function function_b584f143ed0ec5d0(struct_origin, num_spots, n_outer_radius, n_inner_radius) {
  a_s_spawnpts = [];
  valid_points = [];
  var_5ac1024b00cecc71 = (0, 0, 48);
  i = 0;

  while(i < 360) {
    x1 = n_outer_radius * cos(i * 57.2958);
    y1 = n_outer_radius * sin(i * 57.2958);
    check_pt = struct_origin + (x1, y1, 0);
    pos_on_navmesh = getclosestpointonnavmesh(check_pt);

    if(isDefined(pos_on_navmesh)) {
      bsight = sighttracepassed(struct_origin + var_5ac1024b00cecc71, pos_on_navmesh + var_5ac1024b00cecc71, 0, self.player_activator);

      if(istrue(bsight)) {
        valid_points[valid_points.size] = pos_on_navmesh;
      }
    }

    i += 20;
  }

  if(utility::is_equal(valid_points.size, 0)) {
    for(i = 0; i < num_spots; i++) {
      var_c0a72ca2cb7292bf = randomintrange(n_outer_radius * -1, n_inner_radius * -1);
      var_2a74fdb9fac967ff = randomintrange(n_inner_radius, n_outer_radius);
      var_76a1e608e76406cd = utility::cointoss();

      if(istrue(var_76a1e608e76406cd)) {
        var_2a74fdb9fac967ff = var_c0a72ca2cb7292bf;
      }

      var_c0a72ba2cb72908c = randomintrange(n_outer_radius * -1, n_inner_radius * -1);
      var_2a74fcb9fac965cc = randomintrange(n_inner_radius, n_outer_radius);
      var_76a1e608e76406cd = utility::cointoss();

      if(istrue(var_76a1e608e76406cd)) {
        var_2a74fcb9fac965cc = var_c0a72ba2cb72908c;
      }

      pos = struct_origin + (var_2a74fdb9fac967ff, var_2a74fcb9fac965cc, 0);
      pos_on_navmesh = getclosestpointonnavmesh(pos);

      if(isDefined(pos_on_navmesh)) {
        valid_points[valid_points.size] = pos_on_navmesh;
      }
    }
  }

  for(i = 0; i < valid_points.size; i++) {
    s_spot = spawnStruct();
    s_spot.origin = valid_points[i];
    s_spot.angles = (0, 0, 0);
    a_s_spawnpts[a_s_spawnpts.size] = s_spot;
  }

  return a_s_spawnpts;
}

function function_17409c55b9259362() {
  bundlexhash = hashcat(%"hash_334a4b8da1c7fd3f", "ob_zombie_control_marker");
  objectivemarkerbundle = getscriptbundle(bundlexhash);
  self.var_3d20f8f7d66c4778 = function_36a95c9de2ace25a("ob_zombie_control_marker", 0, 1);
  waitframe();
  function_c37023c94938fcdb(objectivemarkerbundle, self.var_3d20f8f7d66c4778, "active");
  scripts\mp\objidpoolmanager::update_objective_position(self.var_3d20f8f7d66c4778, self.var_b5abb73ae8ee13c4.origin + (0, 0, 24));
  namespace_c669075cf56436f4::function_6f02ac608d44fdbf(self.var_3d20f8f7d66c4778, 0, 1);
  self waittill("activity_ended");
  namespace_c669075cf56436f4::function_765b706dc170e214(self.var_3d20f8f7d66c4778);
}

function function_c059aea4f30a95e1() {
  bundlexhash = hashcat(%"hash_334a4b8da1c7fd3f", "ob_zombie_control_marker");
  objectivemarkerbundle = getscriptbundle(bundlexhash);
  self.var_dbecfcc0c094d1b1 = objidpoolmanager::requestobjectiveid(0);
  waitframe();
  function_c37023c94938fcdb(objectivemarkerbundle, self.var_dbecfcc0c094d1b1);
  objidpoolmanager::update_objective_state(self.var_dbecfcc0c094d1b1, "current");
  objidpoolmanager::update_objective_position(self.var_dbecfcc0c094d1b1, self.var_b5abb73ae8ee13c4.origin + (0, 0, 24));
  objidpoolmanager::objective_playermask_showtoall(self.var_dbecfcc0c094d1b1);
  namespace_c669075cf56436f4::function_6f02ac608d44fdbf(self.var_dbecfcc0c094d1b1, 0, 1);
  thread function_6fcbe1beca7b3e87();
  self waittill("activity_ended");
  namespace_c669075cf56436f4::function_765b706dc170e214(self.var_dbecfcc0c094d1b1);
}

function function_6fcbe1beca7b3e87() {
  self endon("activity_ended");
  wait 2;
  self.ping_owner = self.playerparticipants[0];
  self.ping_index = self.ping_owner scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, self.var_b5abb73ae8ee13c4.origin + (0, 0, 24), self.var_dbecfcc0c094d1b1);
}

function function_c37023c94938fcdb(objectivemarkerbundle, objectivemarkerid, override_state) {
  generalsettings = objectivemarkerbundle.generalsettings;
  minimapsettings = objectivemarkerbundle.minimapsettings;
  var_4b16eeed74027f36 = objectivemarkerbundle.var_4b16eeed74027f36;
  compasssettings = objectivemarkerbundle.compasssettings;
  hudsettings = objectivemarkerbundle.hudsettings;
  objective_icon(objectivemarkerid, generalsettings.var_63d1b5b543ef6387);
  objective_state(objectivemarkerid, default_to(override_state, generalsettings.state));
  function_5fd2627c5ce186db(objectivemarkerid, generalsettings.isoptional);
  objective_setownerteam(objectivemarkerid, generalsettings.ownerteam);

  if(isDefined(level.var_9e689c10231cd26a) && isDefined(level.var_9e689c10231cd26a.backgroundoptions)) {
    backgroundoption = level.var_9e689c10231cd26a.backgroundoptions[generalsettings.background];
    objective_setbackground(objectivemarkerid, backgroundoption);
  } else {
    objective_setbackground(objectivemarkerid, 1);
  }

  if(isDefined(generalsettings.var_670c323f7450e31c)) {
    var_670c323f7450e31c = (0, 0, 0);
    var_22fcb4a5ea0d8ffd = generalsettings.var_670c323f7450e31c;
    var_a1308c95bb637c66 = strtok(var_22fcb4a5ea0d8ffd, " ");

    if(var_a1308c95bb637c66.size == 4) {
      var_670c323f7450e31c = (float(var_a1308c95bb637c66[0]) * 255, float(var_a1308c95bb637c66[1]) * 255, float(var_a1308c95bb637c66[2]) * 255);
    }

    objective_settint(objectivemarkerid, int(var_670c323f7450e31c[0]), int(var_670c323f7450e31c[1]), int(var_670c323f7450e31c[2]));
  }
}

function function_bece45249110d92e() {
  self endon("activity_ended");

  foreach(player in level.players) {
    objidpoolmanager::objective_playermask_hidefrom(self.var_3d20f8f7d66c4778, player);
  }

  waitframe();

  foreach(player in self.playerparticipants) {
    objidpoolmanager::objective_playermask_addshowplayer(self.var_3d20f8f7d66c4778, player);
  }
}

function function_5adbed0a8941e5cb() {
  a_players = namespace_4c2b495b8d79cc2e::function_7ec62d1550b9897e(self, "Awareness_Zone");

  if(isDefined(a_players) && a_players.size) {
    return a_players;
  }
}

function function_703285e65f44f9d3() {
  function_1bb538077d615194();
  self.contract_complete = 1;
  thread function_dbdbea19c234b48c();

  foreach(player in self.playerparticipants) {
    function_4a508fcbbea05afd(player);
  }

  namespace_4fda5d7358015a06::endactivity(self, 0);
}

function function_66629e64959d95e5() {
  if(!self.on_mission) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("spore_control_success");
  }

  function_1bb538077d615194();
  self.contract_complete = 1;

  foreach(player in self.playerparticipants) {
    player.var_e23ddb97da39365 = undefined;
    player.nearby_spore = undefined;
    player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
  }

  namespace_4fda5d7358015a06::endactivity(self, 1);
}

function function_544acb4d7f48c28f() {
  foreach(control_point in self.var_14424c0e967b4241) {
    control_point function_54c46311ea3c60be();
  }

  foreach(player in self.playerparticipants) {
    player.var_e23ddb97da39365 = undefined;
    player.nearby_spore = undefined;
    player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
  }
}

function function_1bb538077d615194() {
  self.wave_number = -1;
  game_utility::function_af5604ce591768e1();
}

function function_6f879c9d431b663a() {
  game_utility::function_af5604ce591768e1();
  thread function_dbdbea19c234b48c();

  if(isarray(self.var_16573d54f9178a1b)) {
    foreach(spore_base in self.var_16573d54f9178a1b) {
      spore_base freescriptable();
      spore_base notify("death");
    }
  }

  if(isDefined(self.var_6323bc3c6aa23916)) {
    self.var_6323bc3c6aa23916 delete();
  }

  if(isDefined(self.inhibitor_toolbox)) {
    self.inhibitor_toolbox freescriptable();
    self.inhibitor_toolbox notify("death");
  }

  if(isDefined(self.var_cd05af3824c52cde)) {
    foreach(var_92a23e31eae12117 in self.var_cd05af3824c52cde) {
      var_92a23e31eae12117 freescriptable();
      var_92a23e31eae12117 notify("death");
    }
  }
}

function function_d6edb73d5c5fe3a9() {
  self endon("death");
  wait 120;
  self freescriptable();
  self notify("death");
}

function zombie_death_watcher() {
  level endon("game_ended");
  self waittill("death");

  if(!isDefined(self.var_df13bc784addc5a)) {
    return;
  }

  if(isDefined(self.var_df13bc784addc5a.objective_instance) && self.var_df13bc784addc5a.objective_instance.var_e245ba1b36b148a3[self.subclass] - 1 >= 0) {
    self.var_df13bc784addc5a.objective_instance.var_e245ba1b36b148a3[self.subclass]--;
  }
}

function function_50433f9946e47cfc() {
  if(isDefined(self.var_19739569e497fcd1[self.difficulty_region])) {
    return self.var_19739569e497fcd1[self.difficulty_region];
  }

  return 300;
}

function function_58bc8439fdf4e1b(zombie_type, wave_type) {
  difficulty_region = default_to(self.difficulty_region, "difficulty_easy");

  if(isDefined(self.var_bdca411dd4bdd1[difficulty_region][zombie_type])) {
    return self.var_bdca411dd4bdd1[difficulty_region][zombie_type];
  }

  if(isDefined(self.var_bdca411dd4bdd1[difficulty_region][wave_type])) {
    return self.var_bdca411dd4bdd1[difficulty_region][wave_type];
  }

  return 0;
}

function function_4a203813b7418588(speed_multiplier) {
  self endon("death");

  if(!isDefined(speed_multiplier)) {
    speed_multiplier = 1;
  }

  yaw_sign = 1;
  x_sign = -1;
  original_angles = self.angles;

  while(isDefined(self)) {
    waittime = randomfloatrange(5 / speed_multiplier, 6 / speed_multiplier);
    yaw = randomfloat(180 / speed_multiplier);
    yaw_sign *= -1;
    x_sign *= -1;
    yaw = original_angles[1] + yaw * yaw_sign;
    x_angles = original_angles[0] + randomfloat(10) * x_sign;
    new_angles = (x_angles, yaw, 0);
    self rotateTo(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
  }
}

function function_c9ce2ea582e3e3c7(activity_instance) {
  activity_instance endon("activity_ended");
  self endon("death");
  self function_65cdab0fc78aba8f(activity_instance.var_b5abb73ae8ee13c4.origin, 2600);
}

function function_1531bbf5cff97dc0(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
}

function function_540f9b357f3b5419(var_b381b0883bcd4847) {
  var_c606519b03a24916 = self.playerparticipants.size == 0;

  if(var_c606519b03a24916) {
    namespace_c669075cf56436f4::function_765b706dc170e214(self.var_3d20f8f7d66c4778);
    namespace_c669075cf56436f4::function_765b706dc170e214(self.var_dbecfcc0c094d1b1);
  }

  foreach(control_point in self.var_14424c0e967b4241) {
    foreach(player in var_b381b0883bcd4847.playerlist) {
      control_point game_utility::function_d7d113d56ef0ef5b(player);
      self.ping_owner calloutmarkerping_hide(self.ping_index, player);
    }
  }

  wait 0.2;

  foreach(player in var_b381b0883bcd4847.playerlist) {
    function_4a508fcbbea05afd(player);
  }
}

function private function_4a508fcbbea05afd(player) {
  if(function_5acc35fc66331385(player, 16640)) {
    player ent_flag_clear("quest_s0a2t5_extr_start");
  }
}

function function_7af4fc80d8a7506f(params) {
  wait 5;
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x4e>", "<dev string:x60>", &function_12b5e47689dd56e9, 1);
  devgui::function_fe953f000498048f();
}

function function_12b5e47689dd56e9(params) {
  if(!isDefined(params[0]) || utility::is_equal(params[0], "<dev string:x7c>")) {
    return;
  }

  switch (params[0]) {
    case #"hash_108e564bd5f431c1":
      spawnnewitemfromscriptablesharedfunc("<dev string:x8d>", level.players[0].origin);
      return;
  }
}

# /