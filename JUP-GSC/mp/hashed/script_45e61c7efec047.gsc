/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_45e61c7efec047.gsc
***********************************************/

#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\weapon;
#namespace perk_tombstone;

function function_ce82f1d47d2e5a58(str_currency, var_fe59c44529c721a0) {
  if(istrue(level.var_5025186a3fc7fa4)) {
    return;
  }

  level thread function_f3a23df892bf82f6("specialty_tombstone", str_currency, var_fe59c44529c721a0, &function_c9b691d2acfb3c55, &function_be6733eb26422227);
  callback::add("player_spawned", &function_c0a90b470c8db3b5);
  callback::add("player_disconnect", &function_5f75982dd09c5aff);
  callback::add("player_death", &function_828d4e52d624e921);
  callback::add("player_revived", &function_72a8eb52f0be7b20);
  callback::add("player_team_revived", &function_72a8eb52f0be7b20);
  callback::add(#"hash_83238eee27237eeb", &function_72a8eb52f0be7b20);
  callback::add("player_connect", &function_a96eb05bcccdae3d);
  callback::add("ob_exfil_success", &function_cb0dffa5e243988f);
  callback::add(#"player_eliminated", &function_68a1dda7fd1c33f9);
  callback::add("map_to_map_transition", &function_daacf7d82f553a35);
  callback::add("player_item_pickup", &on_item_pickup);
  scriptable_addnotifycallback("stash_dead", &function_53984676bfb1fe35);
  level.var_2251a7fd416d962a = [];
  level.var_d3bc04e8a1946502 = [(36845, 17622, 3396), (36527, 17795, 3395), (36258, 17703, 3327), (35979, 17378, 3312), (35789, 17361, 3312), (35620, 17401, 3312), (35568, 17644, 3306), (35012, 17582, 3158), (34423, 17935, 3135), (34162, 18085, 3131), (33681, 19037, 3133), (37069, 17864, 3395), (35585, 18342, 3310), (33758, 19259, 3127), (35926, 17660, 3290)];
  setdvarifuninitialized(@ "hash_6d31f61a8b813a5a", 1);
}

function function_c9b691d2acfb3c55() {
  function_d60544ce1e681740();
}

function function_be6733eb26422227(b_pause, str_perk, str_result, n_slot) {
  function_480ad40598a5406a();
}

function function_d60544ce1e681740() {
  function_ab7a3ff9f75e4867("specialty_tombstone");
}

function function_480ad40598a5406a() {
  function_fe0d28e6f0008329("specialty_tombstone");
}

function function_c0a90b470c8db3b5(params) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  if(mapname == "mp_jup_bigmap" || istrue(level.var_18a131403527449e)) {
    function_58b9475ad345f0d3();

    foreach(cache in level.var_2251a7fd416d962a) {
      if(!isDefined(cache)) {
        continue;
      }

      if(isDefined(self.var_9b55e3337571adb4) && is_equal(self.var_9b55e3337571adb4.cache, cache)) {
        cache enablescriptableplayeruse(self);

        if(isDefined(cache.icon) && isDefined(cache.icon.objectiveiconid)) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(cache.icon.objectiveiconid, self);
          scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, cache.origin, cache.icon.objectiveiconid);
        }

        continue;
      }

      if(isDefined(cache.icon) && isDefined(cache.icon.objectiveiconid)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(cache.icon.objectiveiconid, self);
      }

      cache disablescriptableplayeruse(self);
    }
  }

  if(level._custom_perks.size) {
    self endon("<dev string:x1c>");
    var_3352bf952cfc182a = self.name;
    function_6e7290c8ee4f558b("<dev string:x25>" + var_3352bf952cfc182a + "<dev string:x35>");
    function_b23a59dfb4ca49a1("<dev string:x3a>", "<dev string:x53>" + var_3352bf952cfc182a + "<dev string:x69>", &function_e8e91e981eed0341);
    function_b23a59dfb4ca49a1("<dev string:x6e>", "<dev string:x88>" + var_3352bf952cfc182a + "<dev string:x69>", &function_d809d194ca48db47);
    function_b23a59dfb4ca49a1("<dev string:x9f>", "<dev string:xb7>" + var_3352bf952cfc182a + "<dev string:x69>", &function_1829cbe6d232c1d9);
    function_b23a59dfb4ca49a1("<dev string:xcc>", "<dev string:xec>" + var_3352bf952cfc182a + "<dev string:x108>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x10f>", "<dev string:x12f>" + var_3352bf952cfc182a + "<dev string:x14b>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x152>", "<dev string:x172>" + var_3352bf952cfc182a + "<dev string:x18e>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x195>", "<dev string:x1b5>" + var_3352bf952cfc182a + "<dev string:x1d1>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x1d8>", "<dev string:x1f8>" + var_3352bf952cfc182a + "<dev string:x214>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x21b>", "<dev string:x23b>" + var_3352bf952cfc182a + "<dev string:x257>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x25e>", "<dev string:x27e>" + var_3352bf952cfc182a + "<dev string:x29a>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x2a1>", "<dev string:x2c1>" + var_3352bf952cfc182a + "<dev string:x2dd>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x2e4>", "<dev string:x304>" + var_3352bf952cfc182a + "<dev string:x320>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x327>", "<dev string:x348>" + var_3352bf952cfc182a + "<dev string:x365>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x36c>", "<dev string:x38d>" + var_3352bf952cfc182a + "<dev string:x3aa>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x3b2>", "<dev string:x3d3>" + var_3352bf952cfc182a + "<dev string:x3f0>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x3f8>", "<dev string:x419>" + var_3352bf952cfc182a + "<dev string:x436>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x43e>", "<dev string:x45f>" + var_3352bf952cfc182a + "<dev string:x47c>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x484>", "<dev string:x4a5>" + var_3352bf952cfc182a + "<dev string:x4c2>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x4ca>", "<dev string:x4eb>" + var_3352bf952cfc182a + "<dev string:x508>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x510>", "<dev string:x531>" + var_3352bf952cfc182a + "<dev string:x54e>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x556>", "<dev string:x577>" + var_3352bf952cfc182a + "<dev string:x594>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x59c>", "<dev string:x5bd>" + var_3352bf952cfc182a + "<dev string:x5da>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x5e2>", "<dev string:x603>" + var_3352bf952cfc182a + "<dev string:x620>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x628>", "<dev string:x649>" + var_3352bf952cfc182a + "<dev string:x666>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x66e>", "<dev string:x68f>" + var_3352bf952cfc182a + "<dev string:x6ac>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x6b4>", "<dev string:x6d5>" + var_3352bf952cfc182a + "<dev string:x6f2>", &function_f8a387a8c88b1c8a);
    function_b23a59dfb4ca49a1("<dev string:x6fa>", "<dev string:x71b>" + var_3352bf952cfc182a + "<dev string:x738>", &function_f8a387a8c88b1c8a);
    function_fe953f000498048f();
  }
}

function function_5f75982dd09c5aff(params) {
  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    self.var_9b55e3337571adb4.cache cleanup_cache(self, 1);
  }
}

function function_828d4e52d624e921(params) {
  function_5f07fd4885970a1d();
}

function function_cb0dffa5e243988f(params) {
  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    self.var_9b55e3337571adb4.cache thread cleanup_cache(self, 1);
  }

  if(isPlayer(self)) {
    self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
    function_8ec2a2bfd11473be();
  }
}

function function_68a1dda7fd1c33f9(param) {
  if(istrue(self.var_addfab42810330a4)) {
    self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 1);
    return;
  }

  self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
}

function function_daacf7d82f553a35(params) {
  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
    self.var_9b55e3337571adb4.cache cleanup_cache(self, 1);
    waitframe();
    self commitstats(1);
  }
}

function function_5f07fd4885970a1d() {
  var_277e5a7de395bb2e = getdvarint(@ "hash_5c869b8df5b17357", 0);

  if(var_277e5a7de395bb2e > 0) {
    if(gettime() <= function_a5b14435e3229bed(var_277e5a7de395bb2e)) {
      return;
    }
  }

  if(has_perk("specialty_tombstone")) {
    params = spawnStruct();

    if(isbot(self)) {
      function_39c1cce4c78f1e6c(params);
    } else {
      function_ea489c9a3e230419(params);
    }

    return;
  }

  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    if(isPlayer(self)) {
      self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
      self.var_9b55e3337571adb4.cache cleanup_cache(self, 1);
      waitframe();
      self commitstats(1);
    }
  }
}

function function_72a8eb52f0be7b20(params) {
  if(istrue(self.var_addfab42810330a4)) {
    self.var_addfab42810330a4 = undefined;
    self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
    function_8ec2a2bfd11473be();
  }
}

function function_a96eb05bcccdae3d(params) {
  var_76063bf99f55fa00 = self getplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack");

  if(istrue(var_76063bf99f55fa00)) {
    self.var_9cabc8bf28b5247f = 1;
  }
}

function function_5421a86d7a9a981d(itembundlename) {
  if(isDefined(itembundlename) && (itembundlename == "ob_jup_item_rift_object_season3_vision" || itembundlename == "ob_jup_item_rift_object_season3_speed" || itembundlename == "ob_jup_item_rift_object_season3_damage" || itembundlename == "ob_jup_item_thermal_phone" || itembundlename == "ob_jup_item_rr_s5_gold_skull" || itembundlename == "ob_jup_item_rr_s5_thumb_drive" || itembundlename == "ob_jup_item_key_tower_roof" || itembundlename == "ob_jup_item_key_rift_run_tower_thermal_hunt" || itembundlename == "ob_jup_item_key_tower_breakroom")) {
    return true;
  }

  return false;
}

function function_ea489c9a3e230419(params) {
  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    self.var_9b55e3337571adb4.cache cleanup_cache(self, 1);
  }

  if(!has_perk("specialty_tombstone") || self.sessionstate == "intermission") {
    return;
  }

  function_8ec2a2bfd11473be();
  self.var_9b55e3337571adb4 = spawnStruct();
  self.var_9b55e3337571adb4.a_backpack = [];
  self.var_9b55e3337571adb4.var_af2cea418410a822 = [];

  for(i = 0; i < 10; i++) {
    lootid = function_d870b2c45335bd88(i);
    lootcount = function_5ce7fe3dca9c1a22(i);
    self.var_9b55e3337571adb4.var_af2cea418410a822[lootid] = lootcount;
    itembundlename = function_fc925a153c7fd55c(lootid);

    if(!isDefined(itembundlename)) {
      continue;
    }

    if(function_5421a86d7a9a981d(itembundlename)) {
      continue;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    scriptable = itembundle.scriptable;
    self.var_9b55e3337571adb4.a_backpack = array_add(self.var_9b55e3337571adb4.a_backpack, lootid);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "lootID", lootid);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "quantity", lootcount);
    index_high = i;
  }

  var_7a83ce8a86de986 = self.scoreondeath;
  essence_total = isDefined(var_7a83ce8a86de986) ? var_7a83ce8a86de986 : currency::function_15975e20bbd2c824("essence");
  essence_total = int(essence_total * getdvarfloat(@ "hash_6d31f61a8b813a5a"));
  self setplayerdata(level.var_5d69837cf4db0407, "tombstoneEssence", essence_total);

  if(essence_total > 0) {
    lootid = function_6d15e119c2779a93(getscriptbundle("itemspawnentry:ob_jup_item_essence_tombstone"));
    self.var_9b55e3337571adb4.a_backpack = array_add(self.var_9b55e3337571adb4.a_backpack, lootid);
    index = isDefined(index_high) ? index_high + 1 : 0;
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", index, "lootID", lootid);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", index, "quantity", 1);
  }

  if(self.var_9b55e3337571adb4.a_backpack.size) {
    self.var_addfab42810330a4 = 1;
    mapname = scripts\cp_mp\utility\game_utility::getmapname();

    if(mapname != "mp_jup_bigmap" && !istrue(level.var_18a131403527449e) || scripts\mp\outofbounds::istouchingoobtrigger() || ispointinwater(self.origin)) {
      randomspawn = function_b2cd26ac28946ea7(level.var_d3bc04e8a1946502);
      self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 0, randomspawn[0]);
      self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 1, randomspawn[1]);
      self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 2, randomspawn[2]);
      return;
    }

    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 0, self.origin[0]);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 1, self.origin[1]);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 2, self.origin[2]);
  }
}

function function_388d12d30b04fbc1() {
  assertex(isDefined(self.clientid), "<dev string:x740>");
  var_e89a9a6a3475bd0a = undefined;

  if(!isDefined(self.var_9b55e3337571adb4) || !isDefined(self.var_9b55e3337571adb4.a_backpack) || self.var_9b55e3337571adb4.a_backpack.size < 1) {
    return;
  }

  if(isDefined(self.var_30ae0dc4dbcb9e7f)) {
    var_f4991b19147602f9 = self.var_30ae0dc4dbcb9e7f;
  } else {
    var_f4991b19147602f9 = self.clientid;
  }

  n_scriptable = var_f4991b19147602f9 + 1;

  if(n_scriptable < 10) {
    var_e89a9a6a3475bd0a = function_40fd49171fad19d3("tombstone_stash_0" + n_scriptable);
  } else {
    var_e89a9a6a3475bd0a = function_40fd49171fad19d3("tombstone_stash_" + n_scriptable);
  }

  x = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 0);
  y = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 1);
  z = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneStashOrigin", 2);
  essence = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneEssence");
  dropstruct = scripts\cp_mp\loot\common_item::function_59a2e61d79065dca();
  dropinfo = scripts\cp_mp\loot\common_item::function_49b86047c8a8b228(dropstruct, (x, y, z), (0, 0, 0), undefined, 1);
  icon = function_efda1ea04874e527(dropinfo.origin);

  if(!isDefined(icon)) {
    return;
  }

  cache = spawnscriptable(var_e89a9a6a3475bd0a, dropinfo.origin, dropinfo.angles);

  if(!isDefined(cache)) {
    assertmsg("<dev string:x765>" + var_e89a9a6a3475bd0a + "<dev string:x78b>" + var_f4991b19147602f9);
    return;
  }

  cache.icon = icon;
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, cache.origin, icon.objectiveiconid);
  cache setscriptablepartstate("body", "closed_usable");
  var_b98ef95ec6346029 = [];
  var_b98ef95ec6346029 = array_combine(var_b98ef95ec6346029, self.var_9b55e3337571adb4.a_backpack);

  foreach(item in var_b98ef95ec6346029) {
    if(!isDefined(item)) {
      continue;
    }

    n_count = 1;

    if(isDefined(self.var_9b55e3337571adb4.var_af2cea418410a822[item])) {
      n_count = self.var_9b55e3337571adb4.var_af2cea418410a822[item];
    }

    scripts\cp_mp\loot\common_cache::function_6eee0ede493b44e8(cache, n_count, item);
  }

  foreach(player in level.players) {
    if(player == self) {
      cache enablescriptableplayeruse(player);
      n_id = var_f4991b19147602f9 + 1;
      player setclientomnvar("tombstone_stash", n_id);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(cache.icon.objectiveiconid, player);
    cache disablescriptableplayeruse(player);
  }

  self.var_9b55e3337571adb4.cache = cache;
  level.var_2251a7fd416d962a = array_add(level.var_2251a7fd416d962a, cache);
  cache callback::add("on_cache_closed", &function_db8eb6248ea8a6df);
  self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
  waitframe();
  self commitstats(1);
}

function cleanup_cache(player, is_immediate) {
  if(!isDefined(is_immediate)) {
    is_immediate = 0;
  }

  self notify("cleanup_tombstone_cache");
  self endon("cleanup_tombstone_cache");

  if(!is_immediate && !player iscontainerempty(self)) {
    return;
  }

  if(isDefined(self.icon)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.icon.objectiveiconid);
    self.icon = undefined;
  }

  self setscriptablepartstate("body", "shutdown");
  player setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
  player function_8ec2a2bfd11473be();

  if(!is_immediate) {
    waittill_notify_or_timeout("stash_dead", 20);
  }

  while(isPlayer(player) && player scripts\cp_mp\loot\common_cache::function_d6041f45fee8083d() && !is_immediate) {
    wait 0.1;
  }

  level.var_2251a7fd416d962a = array_remove(level.var_2251a7fd416d962a, self);
  self freescriptable();

  if(isPlayer(player)) {
    player setclientomnvar("tombstone_stash", 0);
    player.var_9b55e3337571adb4 = undefined;
  }
}

function function_db8eb6248ea8a6df(params) {
  player = params.opener;

  if(isPlayer(player) && isDefined(player.var_9b55e3337571adb4) && isDefined(player.var_9b55e3337571adb4.cache) && self == player.var_9b55e3337571adb4.cache) {
    player callback::callback("on_tombstone_used_cache", {
      #tombstone_cache: self
    });
    player.var_9b55e3337571adb4.cache cleanup_cache(params.opener);
  }
}

function function_53984676bfb1fe35(instance, note, param, var_535d9c3fdddab5a9) {
  waitframe();
  instance notify("stash_dead");
}

function function_70cb750bdeab27e1(instance, player) {}

function function_47a4709ac15919(oldweaponobj) {
  oldweaponclipammo = self getweaponammoclip(oldweaponobj);
  var_763c9d03986746af = self getweaponammoclip(oldweaponobj, "left");
  oldweaponstockammo = self getweaponammostock(oldweaponobj);
  var_742208586ecb63c3 = self getweaponammoclip(oldweaponobj getaltweapon());
  var_bb9462c52bd454eb = function_7209c8cd4b2e3afd(oldweaponclipammo + oldweaponstockammo, var_763c9d03986746af, var_742208586ecb63c3);
  return var_bb9462c52bd454eb;
}

function function_ebc56eeecea60302(weapon) {
  if(isDefined(weapon.basename)) {
    switch (weapon.basename) {
      case #"hash_6c8fe4d0c94a4fb4":
      case #"hash_b7c258f34317cf65":
      case #"hash_d95d00b228b20251":
        return true;
    }
  }

  if(weapon.inventorytype == "altmode") {
    return true;
  }

  return false;
}

function function_58b9475ad345f0d3() {
  if(istrue(self.var_9cabc8bf28b5247f)) {
    self.var_9cabc8bf28b5247f = undefined;
    self setplayerdata(level.var_5d69837cf4db0407, "restoreTombstoneBackpack", 0);
    self.var_9b55e3337571adb4 = spawnStruct();
    self.var_9b55e3337571adb4.a_backpack = [];
    self.var_9b55e3337571adb4.var_af2cea418410a822 = [];

    for(i = 0; i < 10; i++) {
      [lootid, lootcount] = function_eb02768c294d3e1c(i);

      if(lootid != 0) {
        self.var_9b55e3337571adb4.var_af2cea418410a822[lootid] = lootcount;
        itembundlename = function_fc925a153c7fd55c(lootid);

        if(!isDefined(itembundlename)) {
          self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "lootID", 0);
          self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "quantity", 0);
          continue;
        }

        itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
        scriptable = itembundle.scriptable;
        self.var_9b55e3337571adb4.a_backpack = array_add(self.var_9b55e3337571adb4.a_backpack, lootid);
      }
    }

    function_388d12d30b04fbc1();
    waitframe();
    self commitstats(1);
  }
}

function function_eb02768c294d3e1c(index) {
  lootid = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", index, "lootID");
  quantity = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", index, "quantity");
  return [lootid, quantity];
}

function function_8ec2a2bfd11473be() {
  self endon("disconnect");

  for(i = 0; i < 10; i++) {
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "lootID", 0);
    self setplayerdata(level.var_5d69837cf4db0407, "tombstoneBackpack", i, "quantity", 0);
  }

  self setplayerdata(level.var_5d69837cf4db0407, "tombstoneEssence", 0);
  waitframe();
  self commitstats(1);
}

function private function_efda1ea04874e527(origin) {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid == -1) {
    return undefined;
  }

  icon = spawnStruct();
  icon.objectiveiconid = objectiveiconid;
  scripts\mp\objidpoolmanager::objective_add_objective(icon.objectiveiconid, "active", origin + (0, 0, 49), "jup_ui_icon_tombstone_soda");
  nobackground = 1;
  scripts\mp\objidpoolmanager::update_objective_setbackground(icon.objectiveiconid, nobackground);
  objective_setdescription(icon.objectiveiconid, &"CP_ZMB/PING_TOMBSTONE_STASH");
  return icon;
}

function on_item_pickup(params) {
  if(is_equal(params.itembundlename, "ob_jup_item_essence_tombstone")) {
    essence = self getplayerdata(level.var_5d69837cf4db0407, "tombstoneEssence");
    currency::function_3036cef61495210f("essence", essence - 1);
  }
}

function function_e8e91e981eed0341(a_params) {
  player = function_b3818ef99e063667(a_params[0]);
  params = spawnStruct();

  if(player has_perk("<dev string:x79c>")) {
    player function_388d12d30b04fbc1();
  }
}

function function_1829cbe6d232c1d9(a_params) {
  player = function_b3818ef99e063667(a_params[0]);
  params = spawnStruct();

  if(isbot(player)) {
    player thread function_39c1cce4c78f1e6c(params);
    return;
  }

  player thread function_ea489c9a3e230419(params);
}

function function_d809d194ca48db47(a_params) {
  player = function_b3818ef99e063667(a_params[0]);
  player.var_9b55e3337571adb4.cache thread cleanup_cache(player, 1);
}

function function_f8a387a8c88b1c8a(a_params) {
  player = function_b3818ef99e063667(a_params[0]);
  player.var_30ae0dc4dbcb9e7f = int(a_params[1]);
}

function function_39c1cce4c78f1e6c(params) {
  if(isDefined(self.var_9b55e3337571adb4) && isDefined(self.var_9b55e3337571adb4.cache)) {
    self.var_9b55e3337571adb4.cache cleanup_cache(self, 1);
  }

  if(!has_perk("<dev string:x79c>")) {
    return;
  }

  function_8ec2a2bfd11473be();
  self.var_9b55e3337571adb4 = spawnStruct();
  self.var_9b55e3337571adb4.a_backpack = [];
  self.var_9b55e3337571adb4.var_af2cea418410a822 = [];

  for(i = 0; i < 10; i++) {
    lootid = level.players[0] function_d870b2c45335bd88(i);
    lootcount = level.players[0] function_5ce7fe3dca9c1a22(i);
    self.var_9b55e3337571adb4.var_af2cea418410a822[lootid] = lootcount;
    itembundlename = function_fc925a153c7fd55c(lootid);

    if(!isDefined(itembundlename)) {
      continue;
    }

    itembundle = getscriptbundle("<dev string:x7b3>" + itembundlename);
    scriptable = itembundle.scriptable;
    self.var_9b55e3337571adb4.a_backpack = array_add(self.var_9b55e3337571adb4.a_backpack, lootid);
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x7c6>", i, "<dev string:x7db>", lootid);
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x7c6>", i, "<dev string:x7e5>", lootcount);
  }

  if(self.var_9b55e3337571adb4.a_backpack.size) {
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x7f1>", 1);
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x80d>", 0, self.origin[0]);
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x80d>", 1, self.origin[1]);
    self setplayerdata(level.var_5d69837cf4db0407, "<dev string:x80d>", 2, self.origin[2]);
  }
}

# /