/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_perks.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm_ai_spiders;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_electric_cherry;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_random;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_island_vo;
#namespace zm_island_perks;

function init() {
  clientfield::register("world", "perk_light_speed_cola", 1, 3, "int");
  clientfield::register("world", "perk_light_doubletap", 1, 3, "int");
  clientfield::register("world", "perk_light_quick_revive", 1, 3, "int");
  clientfield::register("world", "perk_light_staminup", 1, 3, "int");
  clientfield::register("world", "perk_light_juggernog", 1, 3, "int");
  clientfield::register("world", "perk_light_mule_kick", 1, 1, "int");
  level thread function_8b929f79();
  level thread function_588068b3();
  level thread function_6753e7bb();
  level thread function_5508b348();
  level thread function_e840e164();
  level thread function_55b919e6();
  level.var_1eddc9ee = 9;
}

function function_c97259e9() {
  if(!isDefined(level.var_c54e133)) {
    level.var_c54e133 = struct::get_array("perk_random_machine_location", "targetname");
    level.var_922007f3 = &function_afa51c0f;
    var_7a46d09b = struct::get("perk_spot_bunker1");
    var_ff311e3a = struct::get("perk_spot_construction");
    array::add(level.var_c54e133, var_7a46d09b);
    array::add(level.var_c54e133, var_ff311e3a);
  }
  if(!isDefined(level.var_961b3545)) {
    level.var_961b3545 = getEntArray("zombie_vending", "targetname");
  }
  function_8abc06a5();
  level thread function_3bccea41();
  function_f9d235ed();
  foreach(var_271d87d8 in level.var_961b3545) {
    var_271d87d8.machine.b_keep_when_turned_off = 1;
  }
  level thread function_d2e344e9();
  function_80cf986b();
}

function function_8abc06a5() {
  level.initial_quick_revive_power_off = 1;
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  while(!isDefined(level.quick_revive_machine) || !isDefined(level.chests)) {
    wait(0.05);
  }
  level.var_47ff1ff7 = [];
  foreach(chest in level.chests) {
    if(chest.zbarrier.state == "initial") {
      if(chest.zbarrier.script_noteworthy == "zone_crash_site_chest_zbarrier") {
        level.var_844a554b[0] = "right";
        level.var_844a554b[1] = "left";
      } else {
        if(chest.zbarrier.script_noteworthy == "zone_ruins_chest_zbarrier") {
          level.var_844a554b[0] = "left";
          level.var_844a554b[1] = "right";
        } else {
          iprintlnbold("ERROR: Magic Box not started in either left nor right side.");
        }
      }
      break;
    }
  }
  level.var_3f48878 = [];
  for(i = 0; i < level.var_844a554b.size; i++) {
    var_b2a1f4eb = "airdrop_" + level.var_844a554b[i];
    level.var_3f48878[i] = struct::get(var_b2a1f4eb, "script_noteworthy");
  }
  var_79578271 = function_d6286636(level.var_3f48878[0].origin);
  var_81d49f84 = function_f2a3ece3("vending_revive");
  if(var_79578271 != var_81d49f84) {
    function_83158efb(var_79578271, var_81d49f84);
  }
  if(level.players.size > 1) {
    var_415d2262 = function_f2a3ece3("vending_jugg");
    function_83158efb(var_81d49f84, var_415d2262);
    var_3aacf417 = struct::get("perk_spot_bunker1");
    level.quick_revive_machine.original_pos = var_3aacf417.origin;
    level.quick_revive_machine.original_angles = var_3aacf417.angles;
  } else {
    level.quick_revive_machine.original_pos = level.var_3f48878[0].origin;
    level.quick_revive_machine.original_angles = level.var_3f48878[0].angles;
  }
  level.var_fd5c770c = [];
  for(i = 0; i < level.var_3f48878.size; i++) {
    level.var_fd5c770c[i] = function_d6286636(level.var_3f48878[i].origin);
    level.var_fd5c770c[i].var_5a70972b = 1;
  }
  for(i = 0; i < level.var_fd5c770c.size; i++) {
    if(level.var_fd5c770c[i].var_f11ace87 === undefined) {
      level.var_fd5c770c[i] function_17f9c5ad(1);
    }
  }
}

function function_3bccea41() {
  while(level.round_number <= 6) {
    level waittill("end_of_round");
    wait(6);
    if(level.round_number == 2) {
      function_233e0157(0);
    }
    if(level.round_number == 6) {
      function_233e0157(1);
    }
  }
}

function function_233e0157(var_b8cb4c1e) {
  var_3661504c = [];
  var_3661504c["vending_revive"] = "p7_fxanim_zm_island_perk_drop1_revive_bundle";
  var_3661504c["vending_doubletap"] = "p7_fxanim_zm_island_perk_drop1_doubletap_bundle";
  var_3661504c["vending_sleight"] = "p7_fxanim_zm_island_perk_drop1_speed_bundle";
  var_3661504c["vending_marathon"] = "p7_fxanim_zm_island_perk_drop1_stamina_bundle";
  var_3661504c["vending_jugg"] = "p7_fxanim_zm_island_perk_drop1_jug_bundle";
  var_e2093f63 = [];
  var_e2093f63["vending_revive"] = "p7_fxanim_zm_island_perk_drop2_revive_bundle";
  var_e2093f63["vending_doubletap"] = "p7_fxanim_zm_island_perk_drop2_doubletap_bundle";
  var_e2093f63["vending_sleight"] = "p7_fxanim_zm_island_perk_drop2_speed_bundle";
  var_e2093f63["vending_marathon"] = "p7_fxanim_zm_island_perk_drop2_stamina_bundle";
  var_e2093f63["vending_jugg"] = "p7_fxanim_zm_island_perk_drop2_jug_bundle";
  var_f9e9760b = [];
  var_f9e9760b["left"] = "fxanim_perk_drop1_b17";
  var_f9e9760b["right"] = "fxanim_perk_drop2_b17";
  level.var_5697feca = level.var_844a554b[var_b8cb4c1e];
  if(level.var_5697feca == "left") {
    level.var_e9331fab = "fxanim_perk_drop1_b17";
    var_9419d2c4 = var_3661504c;
  } else {
    level.var_e9331fab = "fxanim_perk_drop2_b17";
    var_9419d2c4 = var_e2093f63;
  }
  var_c9340b8 = level.var_fd5c770c[var_b8cb4c1e];
  var_3df944fc = var_9419d2c4[var_c9340b8.target];
  level.var_58f37cc3 = var_c9340b8.machine;
  scene::add_scene_func(var_3df944fc, &function_3c8f18a8, "play");
  scene::add_scene_func(var_3df944fc, &function_89159ff6, "done");
  level thread scene::play(var_3df944fc);
  level waittill("hash_7c6b5254");
  level.var_58f37cc3 unlink();
  level.var_fd5c770c[var_b8cb4c1e] function_17f9c5ad(0);
  if(var_c9340b8.target === "vending_revive" && level.players.size == 1) {
    var_c9340b8 function_37ca6cbb(1);
    var_c9340b8.machine playSound("evt_perk_poweron");
  } else {
    var_c9340b8 function_c14f3d0d(level.var_3f48878[var_b8cb4c1e].script_special);
  }
}

function function_3c8f18a8(a_ents) {
  var_100583a4 = a_ents["vending_links"];
  var_c739e142 = [];
  var_c739e142["vending_doubletap"] = "link_doubletap_jnt";
  var_c739e142["vending_jugg"] = "link_jugg_jnt";
  var_c739e142["vending_revive"] = "link_revive_jnt";
  var_c739e142["vending_sleight"] = "link_sleight_jnt";
  var_c739e142["vending_marathon"] = "link_marathon_jnt";
  if(isDefined(level.var_58f37cc3)) {
    str_tag = var_c739e142[level.var_58f37cc3.targetname];
    level.var_58f37cc3.origin = var_100583a4 gettagorigin(str_tag);
    level.var_58f37cc3.angles = var_100583a4 gettagangles(str_tag);
    level.var_58f37cc3 show();
    level.var_58f37cc3 linkto(var_100583a4, str_tag);
  }
  var_c3f519a9 = a_ents["airdrop_plane"];
  v_fx_pos = var_c3f519a9 gettagorigin("tag_engine_inner_left");
  var_4bde0ff5 = var_c3f519a9 gettagangles("tag_engine_inner_left");
  var_503f61aa = util::spawn_model("tag_origin", v_fx_pos, var_4bde0ff5);
  var_503f61aa linkto(var_c3f519a9);
  var_503f61aa thread vehicle_rumble(0, 2);
  wait(20);
  var_503f61aa notify("rumble_stop");
  var_503f61aa delete();
}

function function_89159ff6(a_ents) {
  if(isDefined(a_ents["airdrop_plane"])) {
    a_ents["airdrop_plane"] delete();
  }
  var_c3f519a9 = getent("airdrop_plane", "targetname");
  if(isDefined(var_c3f519a9)) {
    var_c3f519a9 delete();
  }
}

function function_d2e344e9() {
  while(!level flag::exists("power_on" + 4)) {
    wait(0.1);
  }
  foreach(var_f184b6b4 in level.var_961b3545) {
    if(var_f184b6b4.target !== "vending_revive" && (!(isDefined(var_f184b6b4.var_5a70972b) && var_f184b6b4.var_5a70972b))) {
      var_7ec79867 = arraygetclosest(var_f184b6b4.origin, level.var_c54e133);
      var_f184b6b4 thread function_c14f3d0d(var_7ec79867.script_special);
    }
  }
}

function function_c14f3d0d(var_efa86ccd) {
  if(!isDefined(self.script_int)) {
    self.script_int = var_efa86ccd;
    foreach(var_49c78343 in level.powered_items) {
      if(self === var_49c78343.target) {
        powered_perk = var_49c78343;
        break;
      }
    }
    if(isDefined(powered_perk)) {
      powered_perk thread zm_power::zone_controlled_perk(self.script_int);
      str_power = "power_on" + var_efa86ccd;
      if(level flag::get(str_power)) {
        self function_37ca6cbb(1);
        self playSound("evt_perk_poweron");
      }
    } else {
      iprintlnbold("perk not found in level.powered_items");
    }
  }
}

function function_235019b6(str_spawner_name, n_speed = 35, n_acceleration = 100) {
  var_9a17836d = str_spawner_name + "_end";
  self endon("death");
  nd_start = getvehiclenode(self.target, "targetname");
  self attachpath(nd_start);
  if(isDefined(n_speed)) {
    if(!isDefined(n_acceleration)) {
      self setspeed(n_speed);
    } else {
      self setspeed(n_speed, n_acceleration);
    }
  }
  self startpath();
  self thread vehicle_rumble();
  self waittill("reached_end_node");
  self notify(var_9a17836d);
  self notify("rumble_stop");
  self delete();
}

function vehicle_rumble(b_wait_for_flag = 1, b_delay = 0) {
  self endon("rumble_stop");
  var_8e09e52a = 0;
  if(isDefined(b_wait_for_flag) && b_wait_for_flag) {
    level flag::wait_till("flag_plane_start_rumble");
  }
  if(b_delay > 0) {
    wait(b_delay);
  }
  while(isDefined(self) && var_8e09e52a < 1) {
    self playrumbleonentity("zm_island_plane_rumble");
    wait(20);
    var_8e09e52a++;
  }
}

function function_afa51c0f(e_who) {
  self thread function_ed4dd4e3(e_who);
  self thread function_12b8ab88(e_who);
}

function function_f9d235ed() {
  level.var_fed21619 = [];
  for(i = 0; i < 2; i++) {
    str_struct_name = "s_webbing" + i;
    var_284427db = "destructible_webbing" + i;
    var_7716d15a = "t_webbing_extra_damage" + i;
    level.var_fed21619[i] = struct::get(str_struct_name, "targetname");
    level.var_fed21619[i].e_destructible = getent(var_284427db, "targetname");
    level.var_fed21619[i].e_destructible.var_7117876c = level.var_fed21619[i].e_destructible.origin;
    level.var_fed21619[i].e_destructible.var_380861c6 = level.var_fed21619[i].e_destructible.angles;
    level.var_fed21619[i].e_destructible.v_off_pos = level.var_fed21619[i].e_destructible.var_7117876c - vectorscale((0, 0, 1), 256);
    level.var_fed21619[i].e_destructible.var_401e166a = level.var_fed21619[i].e_destructible.angles;
    level.var_fed21619[i].e_destructible setCanDamage(1);
    level.var_fed21619[i].e_destructible clientfield::set("web_fade_material", 0.5);
    level.var_fed21619[i].var_ae94a833 = &function_4680ee05;
    level.var_fed21619[i].t_webbing_extra_damage = getent(var_7716d15a, "targetname");
    if(isDefined(level.var_fed21619[i].t_webbing_extra_damage)) {
      var_7872c6f9 = level.var_fed21619[i].t_webbing_extra_damage;
      var_7872c6f9.e_destructible = level.var_fed21619[i].e_destructible;
      var_7872c6f9.var_1c12769f = struct::get(var_7872c6f9.target, "targetname");
      var_7872c6f9.var_f83345c7 = 1;
      var_7872c6f9.var_20cd3c71 = i;
      var_7872c6f9 thread function_1ec3c42a();
    }
    level.var_fed21619[i] function_869d004a(0);
    level.var_fed21619[i] function_e8e25ea9();
    level.var_fed21619[i].var_20cd3c71 = i;
    level.var_fed21619[i].e_destructible.var_20cd3c71 = i;
    level.var_fed21619[i].s_unitrigger.var_20cd3c71 = i;
  }
}

function function_1ec3c42a() {
  self endon("death");
  while(!isDefined(level.var_d3b40681)) {
    wait(1);
  }
  array::add(level.var_d3b40681, self);
  while(true) {
    self waittill("web_torn");
    if(self.var_f83345c7) {
      level.var_fed21619[self.var_20cd3c71] thread function_4680ee05();
    }
  }
}

function function_4680ee05(e_player) {
  self function_749646f5(e_player);
  level waittill("hash_9c49b4a8");
  do {
    var_340c2125 = zm_ai_spiders::function_f67965ad(self.origin);
    wait(2);
  }
  while(!(isDefined(var_340c2125) && var_340c2125));
  self function_660e6649();
}

function function_660e6649() {
  if(isDefined(self.t_webbing_extra_damage.var_1c12769f)) {
    var_fde3dbd8 = self.t_webbing_extra_damage.var_1c12769f.origin;
    var_e1a86b86 = self.t_webbing_extra_damage.var_1c12769f.angles;
    self.t_webbing_extra_damage thread fx::play("spider_web_perk_machine_reweb", var_fde3dbd8, var_fde3dbd8);
  }
  self.e_destructible show();
  self.e_destructible solid();
  self.t_webbing_extra_damage.var_f83345c7 = 1;
  zm_unitrigger::register_static_unitrigger(self.s_unitrigger, &zm_ai_spiders::function_c915f7a9);
  self function_869d004a(0);
}

function function_749646f5(e_player) {
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  self.e_destructible notsolid();
  self.e_destructible hide();
  self.t_webbing_extra_damage notify("web_torn");
  self.t_webbing_extra_damage.var_f83345c7 = 0;
  if(zm_utility::is_player_valid(e_player)) {
    e_player zm_ai_spiders::function_20915a1a();
  }
  self function_869d004a(1);
}

function function_869d004a(b_enable) {
  var_9b28ee1d = getEntArray("zombie_vending", "targetname");
  t_perk = arraygetclosest(self.origin, var_9b28ee1d);
  t_perk triggerenable(b_enable);
}

function function_6cda4851(e_player) {
  var_77f9de0d = arraygetclosest(self.origin, level.var_fed21619);
  var_77f9de0d function_4680ee05(e_player);
}

function function_e8e25ea9() {
  if(!isDefined(self.s_unitrigger)) {
    s_unitrigger = spawnStruct();
  } else {
    s_unitrigger = self.s_unitrigger;
  }
  s_unitrigger.origin = self.origin;
  s_unitrigger.angles = self.angles;
  s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_unitrigger.cursor_hint = "HINT_NOICON";
  s_unitrigger.require_look_at = 0;
  s_unitrigger.var_a6a648f0 = self.t_webbing_extra_damage;
  s_unitrigger.related_parent = self;
  s_unitrigger.script_width = 130;
  s_unitrigger.script_length = 130;
  s_unitrigger.script_height = 100;
  s_unitrigger.prompt_and_visibility_func = &zm_ai_spiders::function_e433eb78;
  self.s_unitrigger = s_unitrigger;
  self.s_unitrigger.var_20cd3c71 = self.var_20cd3c71;
  self.b_occupied = 0;
  self.b_destroyed = 0;
  self.n_hits = 0;
  zm_unitrigger::register_static_unitrigger(self.s_unitrigger, &zm_ai_spiders::function_c915f7a9);
}

function function_9b238648(player) {
  var_77f9de0d = arraygetclosest(player.origin, level.var_fed21619);
  if(!player zm_utility::is_player_looking_at(var_77f9de0d.e_destructible.origin, 0.4, 0)) {
    self sethintstring("");
    return false;
  }
  if(!isDefined(var_77f9de0d.b_occupied) || (!(isDefined(var_77f9de0d.b_occupied) && var_77f9de0d.b_occupied))) {
    self sethintstring(&"ZM_ISLAND_TEAR_WEB");
    return true;
  }
  self sethintstring("");
  return false;
}

function function_54db2b79() {
  while(true) {
    b_done = 0;
    while(!(isDefined(b_done) && b_done)) {
      self waittill("trigger", e_who);
      if(!zm_utility::is_player_valid(e_who)) {
        continue;
      }
      if(e_who zm_utility::in_revive_trigger()) {
        continue;
      }
      if(e_who.is_drinking > 0) {
        continue;
      }
      if(isDefined(self.related_parent)) {
        self.related_parent notify("trigger_activated", e_who);
      }
      if(!isDefined(e_who.usebar)) {
        b_done = self function_647fcf70(e_who);
      }
    }
    self thread function_6cda4851(e_who);
  }
}

function function_647fcf70(player) {
  player.var_77f9de0d = arraygetclosest(player.origin, level.var_fed21619);
  player.var_77f9de0d.b_occupied = 1;
  self thread function_ed4dd4e3(player);
  self thread function_12b8ab88(player);
  var_a7579b72 = self util::waittill_any_return("webtear_succeed", "webtear_failed");
  player.var_77f9de0d.b_occupied = 0;
  if(var_a7579b72 == "webtear_succeed") {
    return true;
  }
  return false;
}

function function_12b8ab88(player, var_41b6c34b = 2) {
  var_a6a648f0 = self.stub.var_a6a648f0;
  wait(0.01);
  if(!isDefined(self)) {
    if(isDefined(var_a6a648f0.var_160abeb7)) {
      var_a6a648f0.var_160abeb7 zm_ai_spiders::function_9b41e249(0);
    }
    if(isDefined(player.var_652fc581)) {
      player.var_652fc581 delete();
      player.var_652fc581 = undefined;
    }
    return;
  }
  var_6c552ad1 = getweapon("bowie_knife");
  w_widows_wine_bowie_knife = getweapon("bowie_knife_widows_wine");
  var_1e74f559 = player hasweapon(var_6c552ad1) || player hasweapon(w_widows_wine_bowie_knife);
  if(var_1e74f559) {
    var_41b6c34b = var_41b6c34b / 2;
  }
  var_41b6c34b = int(var_41b6c34b * 1000);
  self.var_41b6c34b = var_41b6c34b;
  self.var_57d3f07b = self.var_41b6c34b;
  self.var_21104f30 = gettime();
  var_57d3f07b = self.var_57d3f07b;
  var_21104f30 = self.var_21104f30;
  var_c6160fd4 = self.var_21104f30 + self.var_57d3f07b;
  if(var_57d3f07b > 0) {
    player zm_utility::disable_player_move_states(1);
    player zm_utility::increment_is_drinking();
    var_48baa69f = player getcurrentweapon();
    var_352c1778 = getweapon("zombie_spider_web_tear");
    player giveweapon(var_352c1778);
    util::wait_network_frame();
    player switchtoweapon(var_352c1778);
    player thread function_a0c0f437(var_21104f30, var_57d3f07b);
    while(isDefined(self) && player function_afb24eeb(self) && gettime() < var_c6160fd4) {
      wait(0.05);
    }
    player notify("hash_bd5f338b");
    if(isDefined(var_48baa69f)) {
      player switchtoweapon(var_48baa69f);
    }
    if(isDefined(var_352c1778)) {
      player takeweapon(var_352c1778);
    }
    if(isDefined(player.is_drinking) && player.is_drinking) {
      player zm_utility::decrement_is_drinking();
    }
    player zm_utility::enable_player_move_states();
  }
  if(isDefined(player.usebartext)) {
    player.usebartext hud::destroyelem();
  }
  if(isDefined(player.usebar)) {
    player.usebar hud::destroyelem();
  }
  if(isDefined(self) && player function_afb24eeb(self) && self.var_57d3f07b <= 0 || gettime() >= var_c6160fd4) {
    self notify("webtear_succeed");
    if(var_1e74f559) {
      player.var_f795ee17 = 1;
    }
  } else {
    if(isDefined(player.var_652fc581)) {
      player.var_652fc581 delete();
      player.var_652fc581 = undefined;
    }
    if(isDefined(self)) {
      self notify("webtear_failed");
    } else if(isDefined(var_a6a648f0.var_160abeb7)) {
      var_a6a648f0.var_160abeb7 zm_ai_spiders::function_9b41e249(0);
    }
  }
}

function function_afb24eeb(s_unitrigger) {
  if(self laststand::player_is_in_laststand() || self zm_laststand::is_reviving_any()) {
    return false;
  }
  if(!self useButtonPressed()) {
    return false;
  }
  if(!self zm_utility::is_player_looking_at(self.var_77f9de0d.e_destructible.origin, 0.4, 0)) {
    return false;
  }
  if(isDefined(s_unitrigger.stub.origin) && isDefined(s_unitrigger.stub.radius)) {
    if(distance(self.origin, s_unitrigger.stub.origin) > s_unitrigger.stub.radius) {
      return false;
    }
  }
  return true;
}

function function_2f6a6dcd(n_start_time, var_ddb12d5c) {
  self endon("entering_last_stand");
  self endon("death");
  self endon("disconnect");
  self endon("hash_bd5f338b");
  while(isDefined(self) && (gettime() - n_start_time) < var_ddb12d5c) {
    n_progress = (gettime() - n_start_time) / var_ddb12d5c;
    if(n_progress < 0) {
      n_progress = 0;
    }
    if(n_progress > 1) {
      n_progress = 1;
    }
    self.usebar hud::updatebar(n_progress);
    wait(0.05);
  }
}

function function_a0c0f437(start_time, craft_time) {
  if(isDefined(self.usebartext)) {
    self.usebartext hud::destroyelem();
  }
  if(isDefined(self.usebar)) {
    self.usebar hud::destroyelem();
  }
  self.usebar = self hud::createprimaryprogressbar();
  self.usebartext = self hud::createprimaryprogressbartext();
  self.usebartext settext(&"ZM_ISLAND_TEARING_WEB");
  if(isDefined(self) && isDefined(start_time) && isDefined(craft_time)) {
    self function_2f6a6dcd(start_time, craft_time);
  }
  if(isDefined(self.usebartext)) {
    self.usebartext hud::destroyelem();
  }
  if(isDefined(self.usebar)) {
    self.usebar hud::destroyelem();
  }
}

function function_ed4dd4e3(player) {
  self endon("kill_trigger");
  self endon("webtear_succeed");
  self endon("webtear_failed");
  self endon("hash_bd5f338b");
  while(true) {
    playFX(level._effect["building_dust"], player getplayercamerapos(), player.angles);
    wait(0.5);
  }
}

function function_37ca6cbb(var_5eeae9f2 = 0) {
  var_c12b618 = self.target;
  a_str_keys = strtok(var_c12b618, "_");
  if(isDefined(var_5eeae9f2) && var_5eeae9f2) {
    function_1957d78d(a_str_keys[1], 1);
    wait(0.1);
  }
  function_1957d78d(a_str_keys[1]);
}

function function_1957d78d(str_perk, b_off = 0) {
  if(!(isDefined(b_off) && b_off)) {
    str_msg = str_perk + "_on";
    var_e3e6c76a = str_perk + "_power_on";
  } else {
    str_msg = str_perk + "_off";
    var_e3e6c76a = str_perk + "_power_off";
  }
  level notify(str_msg);
  level notify(var_e3e6c76a);
}

function function_d6286636(v_pos) {
  var_b70d1559 = arraysortclosest(level.var_961b3545, v_pos);
  return var_b70d1559[0];
}

function function_f2a3ece3(str_type) {
  var_1ed8ce62 = undefined;
  foreach(vending in level.var_961b3545) {
    if(vending.target == str_type) {
      var_1ed8ce62 = vending;
      break;
    }
  }
  return var_1ed8ce62;
}

function function_122682ad(b_visible) {
  if(!b_visible) {
    self.machine hide();
    self.clip hide();
  } else {
    self.machine show();
    self.clip show();
  }
  self.bump triggerenable(b_visible);
  self triggerenable(b_visible);
}

function function_17f9c5ad(var_861443b0 = 1) {
  if(var_861443b0) {
    assert(!isDefined(self.var_f11ace87), "");
    self.var_f11ace87 = self.origin;
    self.var_d7ae6fe9 = self.machine.angles;
    s_bury_loc = struct::get("s_bury_loc", "targetname");
    var_382a4db = s_bury_loc.origin;
    self function_4ecb5bf5(var_382a4db, self.var_d7ae6fe9);
    self.var_f391d884 = 1;
  } else {
    assert(isDefined(self.var_f11ace87), "");
    self function_4ecb5bf5(self.var_f11ace87, self.var_d7ae6fe9);
    self.var_f11ace87 = undefined;
    self.var_d7ae6fe9 = undefined;
    self.var_f391d884 = 0;
  }
}

function function_4ecb5bf5(v_loc, v_angles, var_352943cd = 1) {
  if(var_352943cd) {
    self.origin = v_loc;
    self.clip.origin = v_loc - vectorscale((0, 0, 1), 60);
    self.machine.origin = v_loc - vectorscale((0, 0, 1), 60);
    self.bump.origin = v_loc - vectorscale((0, 0, 1), 30);
  } else {
    self.origin = v_loc + vectorscale((0, 0, 1), 60);
    self.clip.origin = v_loc + vectorscale((0, 0, 1), 60);
    self.machine.origin = v_loc - vectorscale((0, 0, 1), 60);
    self.bump.origin = v_loc - vectorscale((0, 0, 1), 30);
  }
  self.angles = v_angles;
  self.machine.angles = v_angles;
  self.clip.angles = v_angles;
  self.bump.angles = v_angles;
}

function function_83158efb(var_220103b4, var_940872ef) {
  var_1f0a690d = var_220103b4.origin;
  var_6dcfdccd = var_220103b4.machine.angles;
  var_458c6947 = var_220103b4.machine.origin;
  var_ce7a742f = var_220103b4.machine.angles;
  var_f84a1658 = var_220103b4.clip.origin;
  var_3dd86ca2 = var_220103b4.clip.angles;
  var_e089f21a = var_220103b4.bump.origin;
  var_2e5bdafc = var_220103b4.bump.angles;
  var_220103b4 function_dd961efc(var_940872ef.origin, var_940872ef.machine.origin, var_940872ef.clip.origin, var_940872ef.bump.origin, var_940872ef.angles, var_940872ef.machine.angles, var_940872ef.clip.angles, var_940872ef.bump.angles);
  var_940872ef function_dd961efc(var_1f0a690d, var_458c6947, var_f84a1658, var_e089f21a, var_6dcfdccd, var_ce7a742f, var_3dd86ca2, var_2e5bdafc);
  wait(0.1);
}

function function_dd961efc(var_34b28fe3, var_b6584494, var_6c749069, var_e03f87ff, var_b483c937, var_ebd3afa, var_65ff7c3d, var_9fbc3dab) {
  self.origin = var_34b28fe3;
  self.angles = var_b483c937;
  self.machine.origin = var_b6584494;
  self.machine.angles = var_ebd3afa;
  self.clip.origin = var_6c749069;
  self.clip.angles = var_65ff7c3d;
  self.bump.origin = var_e03f87ff;
  self.bump.angles = var_9fbc3dab;
}

function function_5508b348() {
  level thread function_90a782bd("revive", "vending_revive", "perk_light_quick_revive");
}

function function_55b919e6() {
  level thread function_90a782bd("marathon", "vending_marathon", "perk_light_staminup");
}

function function_e840e164() {
  level thread function_90a782bd("sleight", "vending_sleight", "perk_light_speed_cola");
}

function function_8b929f79() {
  level thread function_90a782bd("doubletap", "vending_doubletap", "perk_light_doubletap");
}

function function_588068b3() {
  level thread function_90a782bd("juggernog", "vending_jugg", "perk_light_juggernog");
}

function function_90a782bd(var_aa9ee7dd, var_6a2f816c, var_c16251e2) {
  var_95ac3b8c = var_aa9ee7dd + "_on";
  var_a7367b5a = var_aa9ee7dd + "_off";
  while(true) {
    level util::waittill_any(var_95ac3b8c, "power_on");
    function_4f44d932(var_6a2f816c, var_c16251e2, "on");
    level waittill(var_a7367b5a);
    function_4f44d932(var_6a2f816c, var_c16251e2, "off");
  }
}

function function_53fbb551(v_pos) {
  if(!isDefined(level.var_e115ec55)) {
    level.var_c54e133 = struct::get_array("perk_random_machine_location", "targetname");
    level.var_c54e133[level.var_c54e133.size] = struct::get("vending_loc_bunker");
  }
  var_7ec79867 = arraygetclosest(v_pos, level.var_c54e133);
  return var_7ec79867;
}

function function_80cf986b() {
  foreach(var_48b5604f in level.var_fed21619) {
    t_perk = arraygetclosest(var_48b5604f.origin, level.var_961b3545);
    switch (t_perk.script_noteworthy) {
      case "specialty_doubletap2": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_doubletap2");
        break;
      }
      case "specialty_quickrevive": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_revive");
        break;
      }
      case "specialty_fastreload": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_sleight");
        break;
      }
      case "specialty_staminup": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_marathon");
        break;
      }
      case "specialty_armorvest": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_jugg");
        break;
      }
      case "specialty_additionalprimaryweapon": {
        var_48b5604f.e_destructible setModel("p7_zm_isl_web_vending_three_gun");
      }
      default: {
        break;
      }
    }
    var_48b5604f.e_destructible.origin = t_perk.machine.origin;
    var_48b5604f.e_destructible.angles = t_perk.machine.angles;
  }
}

function function_4f44d932(var_6a2f816c, str_clientfield, var_96296bd9 = "on") {
  var_8bcf7b93 = function_f2a3ece3(var_6a2f816c);
  var_7ec79867 = arraygetclosest(var_8bcf7b93.machine.origin, level.var_c54e133);
  if(var_96296bd9 == "on") {
    clientfield::set(str_clientfield, var_7ec79867.script_index);
    var_8bcf7b93 function_5c8137e6(var_6a2f816c, 1);
  } else {
    clientfield::set(str_clientfield, 0);
    var_8bcf7b93 function_5c8137e6(var_6a2f816c, 0);
  }
}

function function_5c8137e6(var_6a2f816c, b_on = 1) {
  if(isDefined(b_on) && b_on) {
    if(!isDefined(self.var_3966775a)) {
      self.var_3966775a = util::spawn_model("tag_origin", self.origin);
      str_fx = "islandfx_" + var_6a2f816c;
      self.var_3966775a linkto(self);
      playFXOnTag(level._effect[str_fx], self.var_3966775a, "tag_origin");
    }
  } else if(isDefined(self.var_3966775a)) {
    self.var_3966775a delete();
  }
}

function function_6753e7bb() {
  level waittill("additionalprimaryweapon_on");
  clientfield::set("perk_light_mule_kick", 1);
  var_8bcf7b93 = function_f2a3ece3("vending_additionalprimaryweapon");
  var_8bcf7b93 function_5c8137e6("vending_additionalprimaryweapon", 1);
}