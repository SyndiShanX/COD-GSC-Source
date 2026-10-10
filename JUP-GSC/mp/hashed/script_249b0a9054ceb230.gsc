/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_249b0a9054ceb230.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_42982ffd0134f28e;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5640d32580c6bc7d;
#using script_5753ba9c28794a65;
#using script_64351208cb856df9;
#using script_6bffae1b97f70547;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace namespace_a5c2977d842bbf87;

function function_3d88cdeba8222b15() {
  thread function_3153056f9a15760f();

  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 0, &function_1d591bf930d61bc2);
  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 1, &function_b2cc205c275b5365);
  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 2, &function_d5e1eb6208782ae5);
  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 3, &function_f42737a99169f63c);
  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 4, &function_1388a2815d6f3111);
  function_89384091f7a2dbd("REV_OB_TURRET_TRAP", 5, &function_9a183acf062c5062);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_TURRET_TRAP");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_TURRET_TRAP");
  namespace_8ef157d888576350::function_610dfcbf191b189b();
}

function function_1d591bf930d61bc2() {
  self.variant_definition = function_b9c4aa88ad97ee68(self);
  self.var_a1ac32f04bfb9e82 = "s_" + tolower(self.varianttag);
  [self.var_996796f4b15a2737] = getStructArray(self.var_a1ac32f04bfb9e82, "targetname");
  function_b8562e9bc1648ad1();
}

function function_b8562e9bc1648ad1() {
  var_f0a73224e2b13518 = getStructArray(self.var_a1ac32f04bfb9e82, "target");
  self.content_structs = [];

  foreach(content_struct in var_f0a73224e2b13518) {
    if(!isDefined(content_struct.script_noteworthy)) {
      continue;
    }

    self.content_structs[content_struct.script_noteworthy] = default_to(self.content_structs[content_struct.script_noteworthy], []);
    self.content_structs[content_struct.script_noteworthy] = array_add(self.content_structs[content_struct.script_noteworthy], content_struct);
  }

  thread function_577419b6760f20e();
  function_b6fc2c96b463c007(self);
}

function function_577419b6760f20e() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  turretspawn = spawnStruct();
  turretspawn.origin = self.content_structs["turret_trap_spawn"][0].origin;
  turretspawn.angles = self.content_structs["turret_trap_spawn"][0].angles + (0, -90, 0);
  turretspawn.turrettype = function_c160909504e47884(turretspawn);
  turretspawn.invulnerable = 1;
  player_owner = level.players[0];

  if(isPlayer(self.var_8356321c5f5eb4c3)) {
    player_owner = self.var_8356321c5f5eb4c3;
  }

  turret_team = "allies";

  if(isPlayer(player_owner) && isDefined(player_owner.team)) {
    turret_team = default_to(player_owner.team, "allies");
  }

  turretspawn.team = turret_team;
  turretspawn.owner = player_owner;
  turretspawn.var_6d9f48354b1ae939 = 1;
  turretspawn.var_12c37b454baa515d = 1;
  turretspawn.var_12e39261f1ccd13c = 1;
  self.turret = namespace_8ef157d888576350::sentryturret_create(turretspawn);
  namespace_8ef157d888576350::sentryturret_setinactive(self.turret);
  createnavobstaclebyent(self.turret);
  self.turret.activity_instance = self;
  var_1fe0a3ddc9b60566 = self.content_structs["turret_trap_panel"][0];
  panel_offset = self.content_structs["turret_trap_spawn"][0].origin - self.content_structs["turret_trap_panel"][0].origin;
  self.turret_trap_panel = spawnscriptable("ob_jup_turret_trap_panel", var_1fe0a3ddc9b60566.origin, var_1fe0a3ddc9b60566.angles);
  self.turret_trap_panel.activity_instance = self;
  self.turret_trap_panel.var_532eac3c428e5b9b = 1;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body_turret_trap_panel", &function_cf1b1f86951a9209);
  self.turret_trap_panel.var_55bb3585d29af1be = &function_d52be86cf922bec2;
  self.turret_trap_panel callback::add("on_cache_closed", &function_beffaa7f40862259);
  self.turret_trap_panel.var_6978a4b328fd33b3 = &function_245e4c4f2c8f50df;
  self.turret_trap_panel.noweaponslot = 1;
  self.turret_trap_panel.containertype = 18;
}

function function_d52be86cf922bec2(instance, player) {}

function function_a3bc9a96e7494b90(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!function_ace73c6f69026c0b(instance.type)) {
    return;
  }

  if(isDefined(instance.objective_instance)) {
    instance.objective_instance notify("turret_trap_interact");
  }
}

function function_ace73c6f69026c0b(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "ob_jup_turret_trap_panel";
}

function function_245e4c4f2c8f50df(container, player, lootid, quantity, itemtype, itemindex) {
  noextract = undefined;
  backpackquantity = quantity;

  if(isDefined(itemtype) && itemtype == 10) {
    backpackquantity = scripts\cp_mp\loot\common_cache::function_8e5978971b5dcd16(player, itemindex);
  }

  backpackquantity = 1;

  if(!isDefined(itemtype)) {
    itemtype = 0;
  }

  if(!isDefined(itemindex)) {
    itemindex = 0;
  }

  player notify("item_added_to_cache", itemtype, itemindex, lootid, backpackquantity);
  return [lootid, noextract];
}

function function_1459744b58026a21(key_name, owner) {
  self.turret_trap_panel setscriptablepartstate("body_turret_trap_panel", "closed_unusable");
  function_2b164bf1240548cd(self.turret, owner);
  turreticon = "jup_ui_map_icon_poi_turret_trap";

  if(issharedfuncdefined("game", "createObjective")) {
    self.turret.minimapid = self.turret[[getsharedfunc("game", "createObjective")]](turreticon, self.turret.team, undefined, 0, 1);
  }

  waitframe();
  turret_info = self.turret getturretweaponinfo();
  var_5a5520aa86c1e979 = 1;
  self.turret.owner namespace_dc2e59577d3a271f::function_b4da81e43557ada1(turret_info);

  switch (key_name) {
    case #"hash_c99f80fc7285c624":
      self.turret.owner namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(turret_info, "brainrot");
      break;
    case #"hash_406a9b154cc52cae":
      self.turret.owner namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(turret_info, "deadwire");
      break;
    case #"hash_4263a081cbbc42cb":
      self.turret.owner namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(turret_info, "cryofreeze");
      break;
    case #"hash_5caf5c606cbae692":
      self.turret.owner namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(turret_info, "napalmburst");
      break;
    case #"hash_fb7fb4f322446308":
      self.turret.owner namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(turret_info, "shatterblast");
      break;
    default:
      self.turret.owner namespace_dc2e59577d3a271f::function_b4da81e43557ada1(turret_info);
      var_5a5520aa86c1e979 = 0;
      break;
  }

  if(!istrue(self.var_9cc74ce986b31dfb)) {
    self.var_9cc74ce986b31dfb = 1;

    if(isDefined(self.playerlist)) {
      foreach(player in self.playerlist) {
        player callback::callback("on_turret_trap_circuit_added");
      }
    } else {
      owner callback::callback("on_turret_trap_circuit_added");
    }
  }

  thread function_bd241b99658cd3c8(owner);
}

function function_bd241b99658cd3c8(owner) {
  wait 120;
  params = spawnStruct();
  params.opener = owner;
  panel_result = self.turret_trap_panel function_beffaa7f40862259(params);

  if(!istrue(panel_result)) {
    function_cea4bfa4bc0fabf6();
  }
}

function function_cea4bfa4bc0fabf6() {
  self.turret_trap_panel setscriptablepartstate("body_turret_trap_panel", "closed_usable");

  if(isDefined(self.turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](self.turret.minimapid);
    }

    self.turret.minimapid = undefined;
  }

  self.var_9cc74ce986b31dfb = 0;
  sentryturret_setinactive(self.turret);
}

function function_beffaa7f40862259(params) {
  opener = params.opener;
  self setscriptablepartstate("body_turret_trap_panel", "closed_usable");

  foreach(index, item in self.contents) {
    if(!isDefined(item.lootid) || item.lootid == 0) {
      continue;
    }

    bundlename = function_fc925a153c7fd55c(item.lootid);
    itembundle = getscriptbundle("itemspawnentry:" + bundlename);
    scriptablename = itembundle.scriptable;
    itemtype = itembundle.type;

    if(isDefined(self.activity_instance) && self.activity_instance function_3712c4e725d18962(bundlename)) {
      if(item.quantity > 1) {
        item.quantity--;
      } else {
        self.contents = array_remove_index(self.contents, index);
      }

      self.activity_instance function_1459744b58026a21(bundlename, opener);
      return true;
    }
  }

  return false;
}

function function_3712c4e725d18962(key_name) {
  if(!isDefined(key_name)) {
    return 0;
  }

  switch (key_name) {
    case #"hash_406a9b154cc52cae":
    case #"hash_4263a081cbbc42cb":
    case #"hash_5caf5c606cbae692":
    case #"hash_9b06adbbfd096664":
    case #"hash_c99f80fc7285c624":
    case #"hash_fb7fb4f322446308":
      return 1;
    default:
      return 0;
  }
}

function function_4e53c739bf22ff46(params) {
  if(!isDefined(params)) {
    return false;
  }

  if(is_equal(params.turrettype, "defend_turret") || is_equal(params.turrettype, "defend_turret_green") || is_equal(params.turrettype, "defend_turret_yellow") || is_equal(params.turrettype, "defend_turret_orange") || is_equal(params.turrettype, "defend_turret_red")) {
    return true;
  }

  if(is_equal(params.basename, "jup_ob_defend_turret") || is_equal(params.basename, "jup_ob_defend_turret_green") || is_equal(params.basename, "jup_ob_defend_turret_yellow") || is_equal(params.basename, "jup_ob_defend_turret_orange") || is_equal(params.basename, "jup_ob_defend_turret_red")) {
    return true;
  }

  return false;
}

function function_b2cc205c275b5365() {}

function function_d5e1eb6208782ae5() {}

function function_f42737a99169f63c() {}

function function_1388a2815d6f3111() {
  if(!isDefined(self.var_996796f4b15a2737)) {
    var_4fc079a0d192b315 = getStructArray("s_" + tolower(self.varianttag), "targetname");
    return var_4fc079a0d192b315[0].origin;
  }

  return self.var_996796f4b15a2737.origin;
}

function function_9a183acf062c5062() {
  reward_structs = getStructArray("s_" + tolower(self.varianttag) + "_reward", "targetname");
  return reward_structs[0];
}

function function_c160909504e47884(spawn_struct) {
  difficulty_region = "";

  if(isDefined(level.var_fac39a693f085779)) {
    difficulty_region = [[level.var_fac39a693f085779]](spawn_struct.origin);
  }

  switch (difficulty_region) {
    case #"hash_7bb2cd766703d463":
      return "defend_turret_green";
    case #"hash_af83e47edfa8900a":
      return "defend_turret_yellow";
    case #"hash_5343b465e56ec9a4":
      return "defend_turret_orange";
    case #"hash_651f76c0ad6741ec":
      return "defend_turret_red";
    default:
      return "defend_turret_green";
  }
}

function function_1531bbf5cff97dc0(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.var_b494ea8c4b70490;
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
}

function function_3153056f9a15760f(params) {
  wait 5;
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x4b>", "<dev string:x5e>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x7c>", "<dev string:x92>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xb3>", "<dev string:xc9>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:xea>", "<dev string:x104>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x129>", "<dev string:x142>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x166>", "<dev string:x17e>", &function_de07a0000b48b33, 1);
  scripts\common\devgui::function_fe953f000498048f();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x1a1>", "<dev string:x1c1>", &function_6565310170d18089);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_de07a0000b48b33(params) {
  if(!isDefined(params[0]) || is_equal(params[0], "<dev string:x1e7>")) {
    return;
  }

  switch (params[0]) {
    case #"hash_588b588d16332e1d":
      function_38e113a4c30f6c0d("<dev string:x1f4>", level.players[0].origin);
      return;
    case #"hash_afaaf053b2461f8a":
      function_38e113a4c30f6c0d("<dev string:x227>", level.players[0].origin);
      return;
    case #"hash_41d942d30dd3f804":
      function_38e113a4c30f6c0d("<dev string:x267>", level.players[0].origin);
      return;
    case #"hash_4f5cd54aaf7f106":
      function_38e113a4c30f6c0d("<dev string:x2aa>", level.players[0].origin);
      return;
    case #"hash_fe0fd5228eda0f07":
      function_38e113a4c30f6c0d("<dev string:x2eb>", level.players[0].origin);
      return;
    case #"hash_853faa00a9ff1020":
      function_38e113a4c30f6c0d("<dev string:x329>", level.players[0].origin);
      return;
  }

  spawn_point = level.players[0].origin;
  var_317e5132733169cb = getclosestpointonnavmesh((level.players[0].origin[0] + 64, level.players[0].origin[1] + 64, level.players[0].origin[2]));

  if(isDefined(var_317e5132733169cb)) {
    spawn_point = var_317e5132733169cb;
  }
}

function function_6565310170d18089(a_params) {
  player = level.players[0];
  spawn_origin = player.origin + (200, 0, 0);
  ground_pos = getgroundposition(player.origin + (200, 0, 100), 10);
  function_936a5eebf22b23e1("<dev string:x359>", ground_pos, player.angles);
}

function function_936a5eebf22b23e1(instance_targetname, spawn_origin, spawn_angles, panel_origin, panel_angles) {
  if(!isDefined(level.var_cee1e495e30eb18a)) {
    level.var_cee1e495e30eb18a = [];
  }

  if(isDefined(level.var_cee1e495e30eb18a[instance_targetname])) {
    return;
  }

  var_c0c7c0983ff152bb = spawnStruct();
  var_c0c7c0983ff152bb.var_a1ac32f04bfb9e82 = "s_" + tolower(instance_targetname);
  spawn_struct = spawnStruct();
  spawn_struct.origin = spawn_origin;
  spawn_struct.angles = spawn_angles;
  panel_struct = spawnStruct();

  if(!isDefined(panel_origin)) {
    var_4ae8132ef88c6f62 = vectorNormalize(anglesToForward(spawn_angles));
    offset = (var_4ae8132ef88c6f62[0] * 20, var_4ae8132ef88c6f62[1] * 20, 50);
    panel_origin = spawn_origin + offset;
    panel_angles = spawn_angles;
  }

  panel_struct.origin = default_to(panel_origin, (0, 0, 0));
  panel_struct.angles = default_to(panel_angles, (0, 0, 0));
  var_c0c7c0983ff152bb.content_structs = [];
  var_c0c7c0983ff152bb.content_structs["turret_trap_spawn"] = [];
  var_c0c7c0983ff152bb.content_structs["turret_trap_panel"] = [];
  var_c0c7c0983ff152bb.content_structs["turret_trap_spawn"][0] = spawn_struct;
  var_c0c7c0983ff152bb.content_structs["turret_trap_panel"][0] = panel_struct;
  var_c0c7c0983ff152bb thread function_577419b6760f20e();
  level.var_cee1e495e30eb18a[instance_targetname] = var_c0c7c0983ff152bb;
  return var_c0c7c0983ff152bb;
}