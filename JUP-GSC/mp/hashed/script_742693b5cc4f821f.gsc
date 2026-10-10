/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_742693b5cc4f821f.gsc
*************************************************/

#using script_261e315c49e5e4ef;
#using script_2d9d24f7c63ac143;
#using script_5bab271917698dc4;
#using script_5f7dbb7992c5c4cf;
#using script_64acb6ce534155b7;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_map_quest;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace quest_cursed;

function init() {
  quest = {
    #on_infil: &on_infil, #on_prematch_end: &on_prematch_end, #on_start: &on_start, #on_precache: &on_precache, #on_init: &on_init, #name: "cursed"};
  br_map_quest::register(quest);
}

function on_init() {
  set_dvars();
  function_47883c99846943d0();
  set_callbacks();

  if(br_map_quest::get_setting("teleport_enabled")) {
    namespace_41030f3ba48eb7e8::init();
  }

  debug_init();
}

function on_precache() {
  utility::add_fx("cursed_item_player", "vfx/iw9_br/equip/vfx_chest_super_zombie_torso_trail");
}

function on_start() {
  foreach(instance in self.quest_instances) {
    instance.item = instance spawn_item();
    instance.rewards = instance function_20b222942020715();
  }
}

function on_prematch_end() {}

function on_infil() {
  foreach(var_e6e50c89ae141b0f in self.var_ddd60ec9d63871b4) {
    var_e6e50c89ae141b0f setscriptablepartstate("base", "healthy");
  }
}

function set_dvars() {
  br_map_quest::add_setting("kills_to_complete", 5);
  br_map_quest::add_setting("reset_on_drop", 0);
  br_map_quest::add_setting("teleport_enabled", 1);
  br_map_quest::add_setting("teleport_each_pickup", 1);
  br_map_quest::add_setting("drop_ww", 1);
  br_map_quest::add_setting("mark_cursed_player", 1);
  br_map_quest::add_setting("ww_name", "jup_pi_raygun_mp");
}

function function_47883c99846943d0() {
  self.var_ddd60ec9d63871b4 = [];
  large = getentitylessscriptablearray("scriptable_fence_wood_planks_01_64_lm", "classname", (-11143.3, -3632.25, 1049.5), 500);
  small = getentitylessscriptablearray("scriptable_fence_wood_planks_01_32_lm", "classname", (-11143.3, -3632.25, 1049.5), 500);
  self.var_ddd60ec9d63871b4 = utility::array_combine(large, small);
  self.quest_instances = [];
  self.var_2c8a1dfa6e4b5952 = utility::getStructArray("quest_cursed_spawn_loc", "targetname");

  if(self.var_2c8a1dfa6e4b5952.size > 0) {
    foreach(loc in self.var_2c8a1dfa6e4b5952) {
      self.quest_instances[self.quest_instances.size] = function_3b1a4e5d006d826e(loc);
    }
  }
}

function function_3b1a4e5d006d826e(loc) {
  instance = {
    #quest: self, #rewards: [], #complete: 0, #first_pickup: 0, #var_4305c9c81a417ff: 0, #var_b5c2bc759e130860: br_map_quest::get_setting("kills_to_complete"), #item_loc: loc
  };
  return instance;
}

function set_callbacks() {
  utility::registersharedfunc(48842, "canQuickDrop", &function_ae7fdf79614c9f6f);
  utility::registersharedfunc(48842, "pickedUp", &function_1f7f65169228bd71);
  utility::registersharedfunc(48842, "dropOnDeath", &function_8cd3ce612122fbab);
  utility::registersharedfunc("sidequest_cursed", "supplyDropUsed", &function_3df74fa4218e45c);
  level scripts\common\callbacks::add("player_death", &on_player_killed);
}

function spawn_item() {
  dropinfo = br_pickups::getitemdroporiginandangles(br_pickups::function_7b9f3966a7a42003(), self.item_loc.origin, self.item_loc.angles, undefined, undefined, undefined, undefined, undefined, self.item_loc.origin);
  pickup = br_pickups::spawnpickup("brloot_jup_quest_cursed_item", dropinfo, 1);
  pickup.var_a6ec9df37a632660 = 1;
  pickup.criticalitem = 1;
  pickup.var_47a692a2105275dc = self;
  return pickup;
}

function function_20b222942020715() {
  rewards = [];

  for(i = 0; i < 3; i++) {
    rewards[rewards.size] = scripts\mp\gametypes\br_plunder::getplundernamebyamount(ter_op(cointoss(), 50, 80));
  }

  rewards[rewards.size] = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/jup_sm_island_2/resurgence/lootset_cache_lege.csv");
  rewards[rewards.size] = scripts\mp\gametypes\br_gametype_resurgence::function_53382489ff523151();
  rewards[rewards.size] = pickscriptablelootitem("killstreak", 0, 3, "mp/loot/br/jup_sm_island_2/resurgence/lootset_cache_base.csv");

  if(self.quest br_map_quest::get_setting("drop_ww")) {
    rewards[rewards.size] = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(self.quest br_map_quest::get_setting("ww_name"));
  }

  return rewards;
}

function function_eab7b539afd6dd11() {
  level endon("game_ended");
  self endon("cursed_item_dropped");
  self endon("cursed_item_complete");
  self.var_e8ab9a0402079035 endon("death_or_disconnect");

  if(self.quest br_map_quest::get_setting("mark_cursed_player")) {
    if(!isDefined(self.objectiveiconid)) {
      namespace_c133516bfc1d803c::createquestobjicon("jup_ui_icon_quest_cursed_item", "active", self.var_e8ab9a0402079035.origin + (0, 0, 100));
      objective_disableping(self.objectiveiconid, 1);
    }

    foreach(player in level.players) {
      namespace_c133516bfc1d803c::showquestobjicontoplayer(player);
    }

    foreach(player in scripts\mp\utility\teams::getteamdata(self.var_e8ab9a0402079035.team, "players")) {
      namespace_c133516bfc1d803c::hidequestobjiconfromplayer(player);
    }

    thread function_fddcbf27c0f66fd5();
  }

  self.var_7fb2bc08be5395c9 = utility::spawn_tag_origin(self.var_e8ab9a0402079035 gettagorigin("j_spineupper"));
  self.var_7fb2bc08be5395c9 linkTo(self.var_e8ab9a0402079035, "j_spineupper");
  self.var_7fb2bc08be5395c9 show();
  self.var_7fb2bc08be5395c9 forcenetfieldhighlod(1);
  waitframe();
  playFXOnTag(utility::getfx("cursed_item_player"), self.var_7fb2bc08be5395c9, "tag_origin");
}

function function_fddcbf27c0f66fd5() {
  level endon("game_ended");
  self endon("cursed_item_dropped");
  self endon("cursed_item_complete");
  self.var_e8ab9a0402079035 endon("death_or_disconnect");

  while(true) {
    namespace_c133516bfc1d803c::movequestobjicon(self.var_e8ab9a0402079035.origin + (0, 0, 100));
    wait 10;
  }
}

function function_8e0ee42aeeba8bae() {
  self.var_e8ab9a0402079035 thread scripts\mp\utility\points::doscoreevent(#"hash_d85b6fe0576528c5");
  self.var_b5c2bc759e130860--;
  function_94dbf32b1cf86b34();

  if(!istrue(self.complete)) {
    namespace_e50e624d9af51c8c::function_e900e7e66383ad97(self.var_e8ab9a0402079035, self.backpack_index, self.var_b5c2bc759e130860, 1);
  }
}

function function_94dbf32b1cf86b34() {
  if(self.var_b5c2bc759e130860 == 0) {
    self.var_e8ab9a0402079035 thread scripts\mp\utility\points::doscoreevent(#"hash_61e2de6118a7b8a4");
    self notify("cursed_item_complete");
    namespace_1eb3c4e0e28fac71::deletequestobjicon();
    self.objectiveiconid = undefined;
    stopFXOnTag(utility::getfx("cursed_item_player"), self.var_7fb2bc08be5395c9, "tag_origin");
    self.var_7fb2bc08be5395c9 delete();
    self.var_e8ab9a0402079035 setscriptablepartstate("cursed_item_fx", "curse_broken");
    self.complete = 1;
    self.var_e8ab9a0402079035 namespace_e50e624d9af51c8c::function_db1dd76061352e5b(self.backpack_index);
    thread function_51c00a1f35c303(self.var_e8ab9a0402079035);
    self.quest thread quest_complete(self.var_e8ab9a0402079035);
    self.var_4305c9c81a417ff = 0;
    self.var_e8ab9a0402079035 = undefined;
  }
}

function quest_complete(player) {
  params = {
    #completed_by: teams::getteamdata(player.team, "players"), #is_successful: 1
  };
  br_map_quest::on_completed(params);
}

function function_51c00a1f35c303(player) {
  level endon("game_ended");
  wait 2;
  forward = anglesToForward(player.angles);
  rotation_angle = randomfloatrange(0, 360);
  offset = rotatepointaroundvector((0, 0, 1), forward, rotation_angle) + (0, 200, 0);
  drop_point = getclosestpointonnavmesh(player.origin + offset);
  self.crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, player.team, "legendary_supply_drop", drop_point + (0, 0, 4096), (0, randomfloat(360), 0), drop_point, undefined, 1);
  assert(isDefined(self.crate));

  if(!utility::issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse")) {
    utility::registersharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse", &namespace_f51c41a139e03299::function_3241afdfec957cb9);
  }

  self.crate.source = "sidequest_cursed";
  self.crate.rewards = self.rewards;
  self.skipminimapicon = 1;
  id = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(id > -1) {
    self.crate setscriptablepartstate("objective_map", "hidden");
    scripts\mp\objidpoolmanager::objective_add_objective(id, "current", self.crate.origin, "jup_ui_icon_quest_cursed_item");
    objective_removeallfrommask(id);
    objective_addteamtomask(id, player.team);
    objective_setbackground(id, 1);
    objective_onentity(id, self.crate);
    objective_setzoffset(id, 75);
    objective_setdescription(id, &"MP_BR_INGAME/QUEST_CURSED_ITEM_REWARD");
    self.crate.scriptedobjid = id;
    thread function_661c0753eb356280(self.crate);

    if(!level.br_circle_disabled) {
      self.crate thread function_710d5f503b5060a1(drop_point);
    }
  }
}

function function_661c0753eb356280(crate) {
  level endon("game_ended");
  id = crate.scriptedobjid;

  while(isDefined(crate)) {
    waitframe();
  }

  crate notify("sidequest_cursed_gas");

  if(isDefined(id)) {
    for(i = 0; i < level.objectiveidpool.reclaimed.size; i++) {
      if(id == level.objectiveidpool.reclaimed[i]) {
        return;
      }
    }

    scripts\mp\objidpoolmanager::returnobjectiveid(id);
  }
}

function function_710d5f503b5060a1(origin) {
  level endon("game_ended");
  self endon("sidequest_cursed_gas");
  crate_timeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab(origin);
  var_6cd08fe827af3392 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852(crate_timeline);
  wait var_6cd08fe827af3392;

  if(isDefined(self.scriptedobjid)) {
    scripts\mp\objidpoolmanager::update_objective_state(self.scriptedobjid, "active");
  }
}

function teleport_player() {
  timeuntilspawn = 3;
  teleport_loc = namespace_8bfdb6eb5a3df67a::getsafeoriginaroundpoint(self.origin, scripts\mp\gametypes\br_circle::getdangercircleradius(), timeuntilspawn, 0);

  if(isDefined(teleport_loc)) {
    teleport_loc = getclosestpointonnavmesh(teleport_loc);
  }

  if(!isDefined(teleport_loc)) {
    teleport_loc = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(0, timeuntilspawn);
  }

  self setscriptablepartstate("cursed_item_fx", "teleport_charge");
  thread namespace_41030f3ba48eb7e8::teleport_start(teleport_loc, 1);
  thread namespace_41030f3ba48eb7e8::function_94aaf61453367a7c();
}

function function_3df74fa4218e45c(player) {
  dropstruct = br_pickups::function_7b9f3966a7a42003();

  if(isDefined(self.rewards)) {
    foreach(item in self.rewards) {
      if(scripts\mp\gametypes\br_lootcache::canspawnitemname(item, isweapon(item))) {
        if(isstring(item)) {
          raritynum = level.br_pickups.br_itemrarity[item];
        }

        legendary = 0;

        if(isDefined(raritynum) && raritynum == 4) {
          legendary = 1;
        }

        pickup = scripts\mp\gametypes\br_lootcache::lootspawnitem(item, dropstruct, self.origin, self.angles, 0, legendary);
      }
    }
  }

  player thread scripts\mp\utility\points::doscoreevent(#"hash_f396d39fee1a8054");
  player playsoundtoplayer("uin_loot_container_open_epic", player);
}

function on_player_killed(death_data) {
  quest = br_map_quest::get_quest("cursed");

  foreach(quest_instance in quest.quest_instances) {
    if(istrue(quest_instance.var_4305c9c81a417ff) && isDefined(quest_instance.var_e8ab9a0402079035)) {
      if(isDefined(death_data.attacker) && isDefined(death_data.victim) && quest_instance.var_e8ab9a0402079035 == death_data.attacker && death_data.attacker != death_data.victim) {
        quest_instance thread function_a0233f797c081c46(death_data.victim, quest_instance.var_e8ab9a0402079035);
        continue;
      }

      if(isDefined(death_data.victim) && quest_instance.var_e8ab9a0402079035 == death_data.victim) {
        stopFXOnTag(utility::getfx("cursed_item_player"), quest_instance.var_7fb2bc08be5395c9, "tag_origin");
        quest_instance.var_7fb2bc08be5395c9 delete();

        if(isDefined(quest_instance.wisps)) {
          foreach(wisp in quest_instance.wisps) {
            wisp delete();
          }

          quest_instance.wisps = [];
        }

        quest_instance.var_4305c9c81a417ff = 0;
        quest_instance.var_e8ab9a0402079035 = undefined;
        quest_instance notify("cursed_item_dropped");
        quest_instance namespace_1eb3c4e0e28fac71::deletequestobjicon();
        quest_instance.objectiveiconid = undefined;

        if(quest br_map_quest::get_setting("reset_on_drop")) {
          quest_instance.var_b5c2bc759e130860 = quest br_map_quest::get_setting("kills_to_complete");
        }
      }
    }
  }
}

function function_ae7fdf79614c9f6f(player) {
  return false;
}

function function_1f7f65169228bd71(item, player) {
  quest_instance = item.var_47a692a2105275dc;

  if(!isDefined(quest_instance)) {
    return;
  }

  quest_instance.var_4305c9c81a417ff = 1;
  quest_instance.var_e8ab9a0402079035 = player;
  quest_instance.backpack_index = player getavailabledmzbackpackindex();
  namespace_e50e624d9af51c8c::function_11f48ae5b87b4525(player, quest_instance.backpack_index, 48842, quest_instance.var_b5c2bc759e130860);

  if(quest_instance.quest br_map_quest::get_setting("teleport_enabled")) {
    if(!istrue(quest_instance.first_pickup)) {
      quest_instance.first_pickup = 1;
      player teleport_player();
    } else if(quest_instance.quest br_map_quest::get_setting("teleport_each_pickup")) {
      player teleport_player();
    }
  }

  quest_instance thread function_eab7b539afd6dd11();
  return 0;
}

function function_8cd3ce612122fbab(dropped_ent, player, dropped_origin) {
  quest = br_map_quest::get_quest("cursed");

  foreach(instance in quest.quest_instances) {
    if(isDefined(instance.var_e8ab9a0402079035) && instance.var_e8ab9a0402079035 == player) {
      dropped_ent.var_47a692a2105275dc = instance;
      break;
    }
  }
}

function function_a0233f797c081c46(dead_player, attacker) {
  level endon("game_ended");
  attacker endon("death_or_disconnect");

  if(!isDefined(self.wisps)) {
    self.wisps = [];
  }

  vfx_root = spawn("script_model", dead_player.origin);
  vfx_root setModel("quest_jup_cursed_wisp_scriptable");
  vfx_root forcenetfieldhighlod(1);
  self.wisps[self.wisps.size] = vfx_root;
  start_position = dead_player.origin + (0, 0, 100);
  end_position = attacker.origin + (0, 0, 10);
  vfx_root setscriptablepartstate("cursed_wisp", "created");
  vfx_root moveTo(start_position, 1.5);
  wait 1.5;
  vfx_root.angles = vectortoangles(end_position - start_position);
  var_3dd4d1307228765 = distance(start_position, end_position);
  var_e8356ef0252e2368 = var_3dd4d1307228765 / 10;
  speed = 100 * var_e8356ef0252e2368 + 250;
  speed += randomfloatrange(-1 * speed * 0.2 / 2, speed * 0.2 / 2);

  if(speed < 250) {
    speed = 250;
  }

  if(speed > 350) {
    speed = 350;
  }

  duration = var_3dd4d1307228765 / speed;
  start_timestamp = gettime();
  current_timestamp = start_timestamp;
  spiral_seed = randomint(360);
  var_8be3eec04aead445 = randomfloatrange(3, 4);
  spiral_magnitude = randomintrange(50, 70);
  offset_z = 0;
  var_4da255dc2b713cb4 = start_position[2] - end_position[2];

  if(var_4da255dc2b713cb4 < 60) {
    var_ac03b17fc9cbce8d = randomintrange(40, 60) + var_4da255dc2b713cb4 / 2;
  } else if(var_4da255dc2b713cb4 < 120) {
    var_ac03b17fc9cbce8d = randomintrange(0, 40) + var_4da255dc2b713cb4 / 2;
  } else {
    var_ac03b17fc9cbce8d = randomintrange(-40, 0) + var_4da255dc2b713cb4 / 2;
  }

  lerp_value = 0;

  while(lerp_value < 1) {
    current_timestamp = gettime();
    end_position = attacker.origin + (0, 0, 10);
    spiral_angle = spiral_seed + var_8be3eec04aead445 * lerp_value * 180;
    var_639fd1c5a5ba7db9 = sin(lerp_value * 180) * spiral_magnitude;
    var_5ca266b2a3a69863 = rotatepointaroundvector(anglesToForward(vfx_root.angles), var_639fd1c5a5ba7db9 * anglestoright(vfx_root.angles), spiral_angle);
    v_z_offset = (0, 0, var_ac03b17fc9cbce8d * sin(lerp_value * 180 + sin(lerp_value * 180) / -1));
    target_position = vectorlerp(start_position, end_position, lerp_value) + v_z_offset + var_5ca266b2a3a69863;
    vfx_root.origin = target_position;
    lerp_value = pow((current_timestamp - start_timestamp) / 1000 / duration, 1.1);
    waitframe();
  }

  if(!istrue(self.complete)) {
    function_8e0ee42aeeba8bae();
  }

  vfx_root setscriptablepartstate("cursed_wisp", "off");

  if(!istrue(self.complete)) {
    attacker setscriptablepartstate("cursed_item_fx", "soul_consumed");
  }

  wait 2;
  self.wisps = utility::array_remove(self.wisps, vfx_root);
  vfx_root delete();
}

function debug_init() {
  devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_a9a864379a098ad6("<dev string:x41>", "<dev string:x4f>", &function_8ceab4fddfa5e5ea);
  devgui::function_a9a864379a098ad6("<dev string:x6e>", "<dev string:x7f>", &function_d12cfb94fb1e29a5);
  devgui::function_a9a864379a098ad6("<dev string:xa1>", "<dev string:xb3>", &function_f92a2485d314b50b);
  devgui::function_a9a864379a098ad6("<dev string:xd6>", "<dev string:xe5>", &function_28455d21c0029079);
  devgui::function_a9a864379a098ad6("<dev string:x105>", "<dev string:x116>", &function_ba8b401af36a89ed);
  devgui::function_b23a59dfb4ca49a1("<dev string:x138>", "<dev string:x15a>", &function_7c780b4fa5300b49);
  devgui::function_b23a59dfb4ca49a1("<dev string:x17f>", "<dev string:x1a7>", &function_7c780b4fa5300b49);
  devgui::function_b23a59dfb4ca49a1("<dev string:x1cc>", "<dev string:x1f9>", &function_7c780b4fa5300b49);
  devgui::function_b23a59dfb4ca49a1("<dev string:x21e>", "<dev string:x248>", &function_7c780b4fa5300b49);
  devgui::function_fe953f000498048f();
}

function function_8ceab4fddfa5e5ea() {
  quest = br_map_quest::get_quest("<dev string:x26d>");
  loc = {
    #angles: level.player.angles, #origin: level.player.origin
  };
  instance = quest function_3b1a4e5d006d826e(loc);
  quest.quest_instances[quest.quest_instances.size] = instance;
  pickup_item = instance spawn_item();
}

function function_d12cfb94fb1e29a5() {
  quest = br_map_quest::get_quest("<dev string:x26d>");

  foreach(instance in quest.quest_instances) {
    if(!isDefined(instance.var_e8ab9a0402079035) || !istrue(instance.var_4305c9c81a417ff)) {
      continue;
    }

    instance.var_e8ab9a0402079035 thread scripts\mp\utility\points::doscoreevent(#"hash_d85b6fe0576528c5");
    instance.var_b5c2bc759e130860--;
    instance function_94dbf32b1cf86b34();

    if(!istrue(instance.complete)) {
      namespace_e50e624d9af51c8c::function_e900e7e66383ad97(instance.var_e8ab9a0402079035, instance.backpack_index, instance.var_b5c2bc759e130860, 1);
    }
  }
}

function function_f92a2485d314b50b() {
  quest = br_map_quest::get_quest("<dev string:x26d>");
  inst = undefined;

  foreach(instance in quest.quest_instances) {
    if(!isDefined(instance.var_e8ab9a0402079035)) {
      continue;
    }

    inst = instance;
    inst.var_b5c2bc759e130860 = 0;
  }

  if(!isDefined(inst)) {
    iprintlnbold("<dev string:x277>");
    return;
  }

  inst function_94dbf32b1cf86b34();
}

function function_28455d21c0029079() {
  quest = br_map_quest::get_quest("<dev string:x26d>");

  foreach(player in level.players) {
    player namespace_e50e624d9af51c8c::function_43f9da47b5084ce0("<dev string:x2b3>");
  }

  dropped_items = getentitylessscriptablearray("<dev string:x2b3>");

  if(dropped_items.size > 0) {
    foreach(item in dropped_items) {
      item freescriptable();
    }
  }

  if(isDefined(quest.var_ddd60ec9d63871b4) && quest.var_ddd60ec9d63871b4.size > 0) {
    quest.var_ddd60ec9d63871b4 = [];
    large = getentitylessscriptablearray("<dev string:x2d3>", "<dev string:x2fc>", (-11143.3, -3632.25, 1049.5), 500);
    small = getentitylessscriptablearray("<dev string:x309>", "<dev string:x2fc>", (-11143.3, -3632.25, 1049.5), 500);
    quest.var_ddd60ec9d63871b4 = utility::array_combine(large, small);

    foreach(var_e6e50c89ae141b0f in quest.var_ddd60ec9d63871b4) {
      var_e6e50c89ae141b0f setscriptablepartstate("<dev string:x332>", "<dev string:x33a>");
    }
  }

  quest.quest_instances = [];

  if(quest.var_2c8a1dfa6e4b5952.size > 0) {
    foreach(loc in quest.var_2c8a1dfa6e4b5952) {
      quest.quest_instances[quest.quest_instances.size] = quest function_3b1a4e5d006d826e(loc);
    }
  }

  quest on_start();
}

function function_ba8b401af36a89ed() {
  level.players[0] teleport_player();
}

function function_7c780b4fa5300b49(params) {
  level notify("<dev string:x345>");
  level endon("<dev string:x345>");
  player = level.players[0];
  player_pos = player.origin;
  version = int(params[0]);

  for(i = 0; i < 100; i++) {
    switch (version) {
      case 0:
        respawn_info = player namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(0, 1.5);
        respawn_pos = respawn_info.origin;
        break;
      case 1:
        respawn_pos = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle(0.3, 0.8);
        break;
      case 2:
        respawn_pos = scripts\mp\gametypes\br_circle::getrandompointinboundssafecircle(0.1, 0.8);
        break;
      case 3:
        respawn_pos = namespace_8bfdb6eb5a3df67a::getsafeoriginaroundpoint(player_pos, scripts\mp\gametypes\br_circle::getdangercircleradius(), 3, 0);
        break;
      default:
        return;
    }

    if(!isDefined(respawn_pos)) {
      assertmsg("<dev string:x345>" + "<dev string:x36f>" + version);
      continue;
    }

    color = (randomfloat(1), randomfloat(1), randomfloat(1));
    debug::debug_line(player_pos, respawn_pos, color, 30, "<dev string:x345>");
  }
}

# /