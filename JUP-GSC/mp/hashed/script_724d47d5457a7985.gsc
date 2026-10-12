/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_724d47d5457a7985.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using scripts\cp_mp\zombie_challenges;
#using script_4e6e58ab5d96c2b0;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_6617e2f2bb62b52b;
#using script_7956d56c4922bd1;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_c2d2e8531012bf72;

function function_480a44aafd55f27e() {
  level.trapprops = spawnStruct();
  level.trapprops.capturetime = getdvarint(@ "hash_1e13e72eb1d0857", 120);
  level.trapprops.captureradius = getdvarint(@ "hash_fc64481991b4ba4c", 800);
  level.trapprops.captureradiussq = level.trapprops.captureradius * level.trapprops.captureradius;
  level.trapprops.captureheight = getdvarint(@ "hash_a77a268ce7f2b5f5", 800);
  level.trapprops.usenodes = getdvarint(@ "hash_dcd4a9ee37ee2172", 1);
  level.trapprops.attractzombies = getdvarint(@ "hash_4c6bfdd85e09150a", 1);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_secret_stash", &function_626179fa845fc04d);
  function_8116ad1e179d91be();
  game["dialog"]["weaponstash_marked"] = "dx_br_dmzo_cost_ovld_tras";
  game["dialog"]["weaponstash_near"] = "dx_br_dmzo_cost_ovld_trne";
  game["dialog"]["weaponstash_enemies"] = "dx_br_dmzo_cost_ovld_trsu";
  game["dialog"]["weaponstash_unlocked"] = "dx_br_dmzo_cost_ovld_trun";
  game["dialog"]["weaponstash_other_squad"] = "dx_br_dmzo_cost_ovld_tsuo";
  function_89384091f7a2dbd("REV_OB_WEAPON_STASH", 0, &function_7794956942b5db04);
  function_89384091f7a2dbd("REV_OB_WEAPON_STASH", 1, &function_9e3d5d8870156844);
  function_89384091f7a2dbd("REV_OB_WEAPON_STASH", 2, &function_1813a3a4d9f2b830);
  function_89384091f7a2dbd("REV_OB_WEAPON_STASH", 3, &function_698f6262da0444db);
  function_89384091f7a2dbd("REV_OB_WEAPON_STASH", 5, &function_e6180bf27c299ba3);
  function_8b5b2a3392fc7e2a("PlayerAbandon", &function_d726e56dacf73235, "REV_OB_WEAPON_STASH");
}

function function_7794956942b5db04() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  if(istrue(level.var_dbca431b3ea02d2e)) {
    self.var_e726c726c6fb7dec = 1;
  }

  activityvariantdefinition = function_b9c4aa88ad97ee68(self);
  self.variant_definition = activityvariantdefinition;
  var_52262832127326a7 = getStructArray(self.varianttag, "target");
  self.var_da2e58464627b802 = [];

  foreach(struct in var_52262832127326a7) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "weaponstash_safe") {
      self.safe_struct = struct;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "weaponstash_spawn") {
      self.var_da2e58464627b802[self.var_da2e58464627b802.size] = struct;
    }

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "weaponstash_rift") {
      self.var_b56a0b41720db766 = struct;
    }
  }

  self.origin = self.safe_struct.origin;
  self.angles = self.safe_struct.angles;
  self.poi = self.safe_struct.poi;

  if(isDefined(level.var_fac39a693f085779)) {
    self.difficulty_region = [[level.var_fac39a693f085779]](self.origin);

    if(self.difficulty_region == "difficulty_undefined") {
      self.difficulty_region = "difficulty_easy";
    }
  } else {
    self.difficulty_region = "difficulty_easy";
  }

  switch (self.difficulty_region) {
    case #"hash_651f76c0ad6741ec":
      self.lootlist = "ob_jup_items_contract_weaponstash_red";
      self.numitems = 4;
      break;
    case #"hash_5343b465e56ec9a4":
      self.lootlist = "ob_jup_items_contract_weaponstash_orange";
      self.numitems = 4;
      break;
    case #"hash_af83e47edfa8900a":
      self.lootlist = "ob_jup_items_contract_weaponstash_yellow";
      self.numitems = 4;
      break;
    case #"hash_7bb2cd766703d463":
    default:
      self.lootlist = "ob_jup_items_contract_weaponstash_green";
      self.numitems = 4;
      break;
  }

  safe = spawnscriptable("dmz_secret_stash", self.safe_struct.origin, self.safe_struct.angles);
  safe.struct = self.safe_struct;
  safe.activity = self;
  safe.lootlist = self.lootlist;
  safe.numitems = self.numitems;
  self.safe = safe;
  safe.poi = self.poi;
  safe.var_55bb3585d29af1be = &function_2ed4dc6531007de3;

  foreach(player in level.players) {
    self.safe disablescriptableplayeruse(player);
  }

  self.capturetime = level.trapprops.capturetime;
  function_b6fc2c96b463c007(self);
}

function function_b479115b8fc652d0() {
  safe = self.safe;
  safe setscriptablepartstate("dmz_secret_stash", "usable");
  safe.capturetime = level.trapprops.capturetime;
  safe.trigger = spawn("trigger_radius", safe.origin, 0, int(level.trapprops.captureradius), int(level.trapprops.captureheight));
  safe.trigger trigger_off();
  safe thread function_ad0115b28e7b12e(safe.trigger, level.trapprops.captureradius);
}

function function_9e3d5d8870156844() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  callback::callback("weapon_stash_started");
  function_b479115b8fc652d0();
  function_3075c891e48a5474(self.playerparticipants[0], 1);
  thread function_f8594b26184f2bd1();

  foreach(player in self.playerparticipants) {
    player.activitykey = self.activitykey;
    self.safe enablescriptableplayeruse(player);
  }

  self.on_mission = zombie_challenges::function_f578373042c34e16(16635, "quest_s0a2t2_safecrack_start", self.playerparticipants);

  if(!self.on_mission) {
    thread function_1281c7fff9456e18("contract_weaponstash_accept_conv");
  }

  foreach(player in self.playerparticipants) {
    player callback::callback("weapon_stash_started");
  }

  if(issharedfuncdefined("ob_quest_missions", "OnWeaponStashActive")) {
    [[getsharedfunc("ob_quest_missions", "OnWeaponStashActive")]](self, player);
  }

  self.safe waittill("safe_unlocked");
  callback::callback("safe_opened");
  waitframe();

  foreach(player in self.playerparticipants) {
    player callback::callback("weapon_stash_completed");
  }

  endactivity(self, 1);
}

function function_1813a3a4d9f2b830(activity_succeeded) {
  self endon("instance_destroyed");
  thread function_a26e39e03a0d6739();

  foreach(player in level.players) {
    self.safe enablescriptableplayeruse(player);
  }

  if(!self.on_mission) {
    if(isDefined(self.playerparticipants[0])) {
      self.on_mission = function_5acc35fc66331385(self.playerparticipants[0], 16140);
    }

    if(!self.on_mission) {
      thread function_1281c7fff9456e18("contract_weaponstash_success_conv");
    }
  }
}

function function_698f6262da0444db() {
  self endon("instance_destroyed");
  thread function_a26e39e03a0d6739();

  if(isDefined(self.safe)) {
    self.safe freescriptable();
  }
}

function function_e6180bf27c299ba3() {
  self endon("instance_destroyed");

  if(isDefined(self.var_b56a0b41720db766)) {
    return self.var_b56a0b41720db766;
  }

  point_found = 0;
  counter = 0;

  while(!istrue(point_found) && counter < 10) {
    front_offset = randomintrange(110, 200);
    side_offset = randomintrange(-50, 50);
    struct_origin = self.safe.origin + anglesToForward(self.safe.angles) * front_offset + anglestoright(self.safe.angles) * side_offset;
    navmesh_point = getclosestpointonnavmesh(struct_origin);
    point_found = scripts\engine\trace::ray_trace_passed(self.safe.origin, navmesh_point);
    counter += 1;
  }

  struct = spawnStruct();
  struct.origin = navmesh_point;
  struct.angles = self.safe.angles;
  return struct;
}

function function_d726e56dacf73235(params) {
  if(self.playerparticipants.size == 0) {
    self notify("abandoned");
    waitframe();
    var_110aca939d912394 = self.safe getscriptablepartstate("dmz_secret_stash", 1);
    opening_states = ["opening", "drill_enter", "drill_loop"];

    if(array_contains(opening_states, var_110aca939d912394)) {
      self.safe setscriptablepartstate("dmz_secret_stash", "unusable");
    }

    wait 0.2;

    foreach(player in params.playerlist) {
      function_4a508fcbbea05afd(player);
    }
  }
}

function private function_4a508fcbbea05afd(player) {
  if(function_5acc35fc66331385(player, 16635)) {
    player ent_flag_clear("quest_s0a2t2_safecrack_start");
  }
}

function function_f8594b26184f2bd1() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  wait 3;

  while(true) {
    foreach(player in self.playerparticipants) {
      dist = distance2dsquared(player.origin, self.safe.origin);

      if(dist < 9000000) {
        return;
      }
    }

    wait 1;
  }
}

function function_626179fa845fc04d(instance, part, state, player, bautouse, usestring) {
  if(isDefined(player) && istrue(player.var_859654e0445a36d9)) {
    player scripts\mp\hud_message::showerrormessage("MP/DENY_USE_CARRY");
    return;
  }

  if(state == "usable") {
    thread function_a2e344606314374b(instance, part, state, player);
    return;
  }

  if(state == "closed_usable" || state == "opening" || state == "partially_open_usable") {
    if((state == "closed_usable" || state == "closed_usable_no_collision") && !isDefined(instance.entity)) {
      if(instance getscriptableparthasstate(part, "fully_opening_unusable")) {
        instance setscriptablepartstate(part, "fully_opening_unusable");
      }

      params = spawnStruct();
      params.cacheinstance = instance;
      player callback::callback("lootcache_looted", params);

      if(isDefined(instance.var_534e0cf170a981b7)) {
        [[instance.var_534e0cf170a981b7]](instance, player);
      }

      if(!isDefined(instance.contents)) {
        instance.containertype = 4;
        instance.var_6a4915c949e9e77e = 1;
        common_cache::fillcontentsfromlist(instance, instance.lootlist, instance.numitems);
      }
    } else if(isDefined(instance.contents) && state == "partially_open_usable") {
      if(instance getscriptableparthasstate(part, "fully_opening_unusable")) {
        instance setscriptablepartstate(part, "fully_opening_unusable");
      }
    }

    scripts\cp_mp\loot\common_cache::openlootablecontainer(instance, player);
  }
}

function function_2ed4dc6531007de3(instance, player) {}

function function_a2e344606314374b(safe, part, state, player) {
  safe setscriptablepartstate(part, "unusable");
  safe.successfuluse = 0;
  safe thread function_29d903a8de1ffd34(player);
  safe function_f05bfb2a652d7625(player);

  if(!istrue(safe.successfuluse)) {
    wait 3;
  }

  if(istrue(safe.successfuluse)) {
    safe.teams = [player.team];
    safe.trigger trigger_on();
    function_bbdcd857d0c2a65e(safe.activity, player, "PlayerJoinedInteract");

    if(level.trapprops.attractzombies) {
      safe.zombie_attractor = namespace_5381a59d140f4df8::add_attractor(safe.struct, 1, 750, 0, undefined, &function_3bef41fcdc0a4427, 0);
      safe.var_9562506b1c88abc2 = namespace_5381a59d140f4df8::add_attractor(safe.struct, 1, 750, 0, undefined, &function_3bef41fcdc0a4427, 1);
    }

    safe notify("safe_unlocking");
    safe.var_208c5333afcd7102 = 1;
    safe.activity thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
    safe.activity namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_WEAPON_STASH_DEFEND_PHASE");
    safe.activity thread function_430be47b55b52576(player.team);
    safe thread function_a0ee2bb161327c83();
    return;
  }

  safe setscriptablepartstate(part, "usable");
}

function function_a0ee2bb161327c83() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.activity endon("abandoned");
  self.progress = 0;
  var_a81135442ee1a731 = 0;
  var_306804c6c85c36b0 = undefined;
  intervalindex = 0;
  self.alertradius = 512;
  shownplayers = [];
  self.highestprogress = 0;
  self.var_1ffb466273023a62 = 0;
  self.progressmultiplier = 1;
  self.activity namespace_262d6474998a2356::function_f0361294db9d74a7(0, 1);
  self.activity namespace_262d6474998a2356::function_c661dba3e304266b(0);

  if(!istrue(getdvarint(@ "hash_408f0c3af174e92d", 0))) {
    thread function_f72294f967de9d73();
  }

  while(true) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      var_626a5cebca990863 = 0;

      if(!isDefined(var_306804c6c85c36b0)) {
        var_306804c6c85c36b0 = [0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75];
      }

      if(self.nearbyplayers.size > 0) {
        progressbefore = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds * self.progressmultiplier);
      } else {
        progressbefore = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 0.5);
        var_626a5cebca990863 = 1;
      }

      progress = int(100 * self.progress / self.capturetime);
      self.activity namespace_262d6474998a2356::function_f0361294db9d74a7(progress);
      self.activity namespace_262d6474998a2356::function_c661dba3e304266b(progress);

      if(self.progress >= self.capturetime) {
        if(var_626a5cebca990863 == 0) {
          foreach(team in self.teams) {
            foreach(player in getteamdata(team, "players")) {
              player callback::callback("ob_weaponstash_drill_notPaused");
            }
          }
        }

        thread function_392e3b295e1175de();
      }
    }

    waitframe();
  }
}

function private function_f72294f967de9d73() {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.activity endon("abandoned");
  self.activity endon("activity_ended");
  self.activity endon("instance_destroyed");
  var_9f62bb4e06fd3af4 = 0.08 * self.capturetime;
  timeuntilspawnpenalty = 24000;
  var_76f6e45eb846b44e = 0.055 * self.capturetime;
  var_d62c726509b30367 = 0.03 * self.capturetime;
  var_e417eb1a61ac3d4c = -1;
  var_a3e324804f7ab247 = -1;
  var_658b424303eaf747 = -1;

  while(true) {
    if(self.progress > self.highestprogress) {
      self.highestprogress = self.progress;
      self.progressmultiplier = 1;
    } else {
      self.progressmultiplier = 1.5;
    }

    if(istrue(self.var_1ffb466273023a62)) {
      function_4b7d420e1bad897f(self.activity.var_d2347688fc2e2c69, 0);
      var_711a1c048ff07480 = ter_op(var_658b424303eaf747 / self.capturetime < 0.8, var_658b424303eaf747 + var_76f6e45eb846b44e, var_658b424303eaf747 + var_d62c726509b30367);

      if(self.progress >= var_711a1c048ff07480) {
        self.var_1ffb466273023a62 = 0;
        var_e417eb1a61ac3d4c = -1;
        var_a3e324804f7ab247 = -1;
        var_658b424303eaf747 = -1;
        self.activity notify("safe_progress_unstalled");
        function_4b7d420e1bad897f(self.activity.var_d2347688fc2e2c69, 5);
      }
    } else {
      if(var_e417eb1a61ac3d4c < 0) {
        var_e417eb1a61ac3d4c = gettime();
        var_a3e324804f7ab247 = self.highestprogress;
      }

      if(self.progress < self.highestprogress - var_9f62bb4e06fd3af4) {
        self.var_1ffb466273023a62 = 1;
        var_658b424303eaf747 = self.highestprogress;
      } else if(self.progress > var_a3e324804f7ab247 - var_9f62bb4e06fd3af4 && self.progress < var_a3e324804f7ab247 + var_9f62bb4e06fd3af4) {
        if(gettime() > var_e417eb1a61ac3d4c + timeuntilspawnpenalty) {
          self.var_1ffb466273023a62 = 1;
          var_658b424303eaf747 = self.highestprogress;
        }
      } else {
        var_e417eb1a61ac3d4c = -1;
        var_a3e324804f7ab247 = -1;
      }
    }

    wait 1;
  }
}

function private function_f96e7c37c158cb9c(location, teamname) {
  wait randomintrange(2, 4);
  playsoundatpos(location, "mp_dmz_alrm_trap");
  wait 3;
  function_1281c7fff9456e18("weaponstash_wave1_zomb");
}

function function_c1db0d79087b2228(nearbyplayers, shownplayers, progress) {
  allplayers = array_combine(nearbyplayers, shownplayers);
  var_f6fd7b0e73c3270c = shownplayers;

  foreach(player in allplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!array_contains(shownplayers, player) && array_contains(nearbyplayers, player)) {
      var_f6fd7b0e73c3270c = array_add(var_f6fd7b0e73c3270c, player);
      continue;
    }

    if(array_contains(shownplayers, player) && !array_contains(nearbyplayers, player)) {
      var_f6fd7b0e73c3270c = array_remove(var_f6fd7b0e73c3270c, player);
    }
  }

  return var_f6fd7b0e73c3270c;
}

function function_392e3b295e1175de() {
  if(!istrue(self.unlocked)) {
    self.unlocked = 1;
  }

  foreach(team in self.teams) {
    foreach(player in getteamdata(team, "players")) {
      if(!isDefined(player.var_6b41d67653e80c4b)) {
        player.var_6b41d67653e80c4b = 0;
      }

      player.var_6b41d67653e80c4b++;
    }
  }

  self setscriptablepartstate("dmz_secret_stash", "opening");

  if(level.trapprops.attractzombies) {
    namespace_5381a59d140f4df8::remove_attractor(self.zombie_attractor);
  }

  self.trigger delete();
  scripts\mp\gameobjects::releaseid();
  self notify("safe_unlocked");
}

function function_ad0115b28e7b12e(trigger, radius) {
  level endon("game_ended");
  self endon("safe_unlocked");
  self.nearbyplayers = [];

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || array_contains(self.nearbyplayers, player) || !array_contains(self.activity.playerparticipants, player)) {
      continue;
    }

    if(!array_contains(self.teams, player.team)) {
      self.teams[self.teams.size] = player.team;
    }

    self.nearbyplayers = array_add(self.nearbyplayers, player);
    thread function_1cc5ba0bf9073e7f(trigger, player, radius);
  }
}

function function_1cc5ba0bf9073e7f(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2) {
    wait 0.2;
  }

  self.nearbyplayers = array_remove(self.nearbyplayers, player);
}

function private function_dad91f5cfff957c4(stronghold_instance) {
  locations = [];

  foreach(node in stronghold_instance.locked_doors) {
    if(!istrue(node.doubledoor)) {
      locations[locations.size] = node;
    }
  }

  return locations;
}

function private function_b864f99a920e0846(nodes) {
  wait 45;

  for(i = 0; i < 2; i++) {
    foreach(node in nodes) {
      thread function_65095d5eda84ccd1(node);
      waitframe();
    }

    wait 30;
  }
}

function private function_65095d5eda84ccd1(node) {
  wait randomfloatrange(0, 2);
  magicgrenademanual("smoke_grenade_mp", node.outerorigin, (0, 0, -10), 0.5);
  thread play_sound_in_space("smoke_grenade_expl_trans", node.outerorigin);
}

function private function_b9e25692448324a0(doors) {
  foreach(door in doors) {
    door function_80902296b05be00a();
  }
}

function private function_430be47b55b52576(teamname) {
  self.var_69b705b3551a18c0 = getteamdata(teamname, "players").size;
  self.safe.trigger trigger_on();

  if(!istrue(self.safe.var_9aef22e3cd04e1dd)) {
    self.agents = [];
    self.var_138a16b93547993 = 0;
    function_24b55c1a13b9a63a("ai_flood_fill_encounter:enc_ob_weapon_stash_floodfill_zombie");
    thread function_f508002ab4826c4c(2, 0, "wave_med", 0, undefined);
    thread function_f508002ab4826c4c(22, 3, "wave_small", 0, undefined);
    thread function_f508002ab4826c4c(26, 0, "wave_large", 1, undefined);
    thread function_f508002ab4826c4c(45, 3, "wave_large", 0, undefined);
    thread function_f508002ab4826c4c(68, 2, "wave_small", 0, undefined);
    thread function_f508002ab4826c4c(71, 0, "wave_small", 1, undefined);
    thread function_f508002ab4826c4c(95, 2, "wave_large", 0, undefined);
    thread function_f508002ab4826c4c(97, 0, "wave_small", 1, undefined);
    thread function_f508002ab4826c4c(107, 0, "wave_small", 1, undefined);
    thread function_f508002ab4826c4c(124, 2, "wave_med", 0, undefined);
    thread function_f508002ab4826c4c(127, 0, "wave_small", 1, undefined);
    thread function_f508002ab4826c4c(150, 6, "wave_small", 0, undefined);
    thread function_f508002ab4826c4c(153, 0, "wave_large", 1, undefined);
    thread function_f508002ab4826c4c(175, 4, "wave_large", 0, undefined);
    thread function_f508002ab4826c4c(198, 6, "wave_med", 0, undefined);
    thread function_f508002ab4826c4c(205, 0, "wave_small", 1, undefined);
  }

  foreach(player in level.players) {
    if(isDefined(player)) {
      self.safe enablescriptableplayeruse(player);
    }
  }

  self.traptriggered = 1;
  thread function_f96e7c37c158cb9c(self.safe.origin, teamname);
}

function function_9ede655e5f354b82(float_chance) {
  if(randomfloat(1) < float_chance) {
    return "ai_encounter:enc_ob_weapon_stash_reinforce_merc";
  }

  return "ai_encounter:enc_ob_weapon_stash_reinforce_zombie";
}

function function_f508002ab4826c4c(wait_sec, delay_limit, wave_size, is_hellhound, broadcast_name) {
  self endon("abandoned");
  self endon("activity_ended");
  self endon("instance_destroyed");

  for(sec = 0; sec < wait_sec; sec++) {
    if(istrue(self.safe.var_1ffb466273023a62)) {
      self waittill("safe_progress_unstalled");
    }

    wait 1;
  }

  wait wait_sec;
  counter = 0;

  while(self.agents.size > 4 && counter < delay_limit) {
    counter += 1;
    wait 1;
  }

  bundle = function_9ede655e5f354b82(0);
  self.encounterid = function_f8ccadcd850da124(bundle, self.safe.origin, 7000, 1, 0, 1, 2);

  if(!istrue(self.var_138a16b93547993) && isDefined(self.progress) && self.progress > 90) {
    function_1281c7fff9456e18("weaponstash_wavelast_zomb");
    self.var_138a16b93547993 = 1;
  }

  if(isDefined(self.encounterid)) {
    if(istrue(is_hellhound)) {
      function_d37068aac7785c04(self.encounterid, "wave_hellhound", 1);
      function_d37068aac7785c04(self.encounterid, wave_size + "_hellhound", 1);
    } else {
      function_d37068aac7785c04(self.encounterid, self.difficulty_region, 1);
      function_d37068aac7785c04(self.encounterid, wave_size, 1);
    }

    spawn_area = array_random(self.var_da2e58464627b802);
    spawn_radius = ter_op(isDefined(spawn_area.radius), spawn_area.radius, 200);
    function_df930eed75d4f74f(self.encounterid, spawn_area.origin, spawn_radius);
    function_ce9c21523336cdbc(self.encounterid, &function_d73576cca74f82d, self);
  }
}

function function_24b55c1a13b9a63a(bundle) {
  encounter_radius = 1000;
  self.var_d2347688fc2e2c69 = function_f8ccadcd850da124(bundle, self.safe_struct.origin, encounter_radius, 1, 0, 1, 2);

  if(isDefined(self.var_d2347688fc2e2c69)) {
    function_d37068aac7785c04(self.var_d2347688fc2e2c69, self.difficulty_region, 1);
    function_ce9c21523336cdbc(self.var_d2347688fc2e2c69, &function_a097afc443e2bf76, self);
    scripts\cp_mp\agents\ai_spawn_director::function_73147cdf5c28d10c(self.var_d2347688fc2e2c69, &function_c6d1ce0bfc8bb2c4, self);
    function_4b7d420e1bad897f(self.var_d2347688fc2e2c69, 5);
  }
}

function function_c6d1ce0bfc8bb2c4(requestid, userdata) {
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

function function_d73576cca74f82d(requestid, userdata, agent, data) {
  agent endon("death");
  safe = userdata.safe;
  activityinstance = userdata;
  agent ent_flag_init("activity_safe_attracted");

  if(isalive(agent)) {
    activityinstance.agents[activityinstance.agents.size] = agent;
    agent namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0(safe.struct, 1, 750, 0, undefined, &function_3bef41fcdc0a4427, 0);
    agent function_65cdab0fc78aba8f(safe.origin, level.trapprops.captureradius);
  }
}

function function_a097afc443e2bf76(requestid, userdata, agent, data) {
  agent endon("death");
  safe = userdata.safe;
  activityinstance = userdata;
  agent ent_flag_init("activity_safe_attracted");

  if(isalive(agent)) {
    agent namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0(safe.struct, 1, 750, 0, undefined, &function_3bef41fcdc0a4427, 0);
    agent function_65cdab0fc78aba8f(safe.origin, level.trapprops.captureradius);
  }
}

function function_5e0e53fdf854778e(requestid, userdata, wavenumber) {
  safe = userdata[0];

  if(!istrue(safe.reinforcementscalled) && istrue(safe.shouldreinforce)) {
    safe.reinforcementscalled = 1;
    return true;
  }

  return false;
}

function function_3bef41fcdc0a4427(attractor, zombie) {
  if(isDefined(zombie.enemy)) {
    return false;
  }

  player = getclosest(zombie.origin, level.players, 200);

  if(isDefined(player) && distance2dsquared(zombie.origin, player.origin) < distance2dsquared(zombie.origin, attractor.source.origin)) {
    return false;
  }

  if(is_equal(zombie.aicategory, "normal")) {
    return (zombie.team == "team_two_hundred");
  }

  return false;
}

#using_animtree("script_model");

function function_8116ad1e179d91be() {
  level.scr_animtree["gun_safe_drill_player"] = #animtree;
  level.scr_anim["gun_safe_drill_player"]["gun_safe_enter"] = % iw9_dmz_stashdrill_enter_stand_sdr;
  level.scr_eventanim["gun_safe_drill_player"]["gun_safe_enter"] = % "gun_safe_enter";
  level.scr_viewmodelanim["gun_safe_drill_player"]["gun_safe_enter"] = "iw9_dmz_stashdrill_enter_stand_sdr";
}

function private function_8735e24dceeb7187() {
  level endon("game_ended");
  self endon("drillingAnimComplete");
  self endon("death_or_disconnect");
  self endon("interact_finished");
  waittill_any_2("last_stand_start", "interact_interrupt");
  logstring("OB RWS -- Drilling anim interrupted, removing Gunless");
  scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
}

function function_f05bfb2a652d7625(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  logstring("OB RWS -- Player in drilling anim: " + player.name);
  logstring("OB RWS -- Drilling anim started");
  player function_b2451d0fac313fbe(0);
  playerviewangles = player getplayerangles();
  player.linktoent = player spawn_tag_origin(player.origin, player.playerviewangles);
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
  logstring("OB RWS -- Linked to ent");
  goalpos = self.origin + rotatevector((50.586, -6.262, 0), self.angles);
  forward = (0, 0, 0) - anglesToForward(self.angles);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);
  movetotime = 0.5;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  player setstance("stand");
  logstring("OB RWS -- Player stance and moveto set");
  var_cd9982adb17761a8 = gettime();
  player thread function_8735e24dceeb7187();
  player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
  waittime = max(0, var_218f64cb035d54be);
  wait waittime;
  logstring("OB RWS -- Player givegunless wait over");
  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  logstring("OB RWS -- Pre-infil_player_rig_updated");
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("gun_safe_drill_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);
  logstring("OB RWS -- Post-infil_player_rig_updated");
  animstruct = spawnStruct();
  animstruct.origin = self.origin;
  animstruct.angles = self.angles + (0, 90, 0);
  self setscriptablepartstate("dmz_secret_stash", "drill_enter");
  logstring("OB RWS -- Pre-anim_player_solo");
  animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "gun_safe_enter");
  logstring("OB RWS -- Post-anim_player_solo");

  if(isDefined(player) && isreallyalive(player)) {
    player notify("interact_finished");
    logstring("OB RWS -- Interact finished notified");
  }

  logstring("OB RWS -- Post-interact finished");
  waitframe();

  if(isDefined(player)) {
    player notify("remove_rig");
    logstring("OB RWS -- Remove rig notified");

    if(isreallyalive(player)) {
      player function_b2451d0fac313fbe(1);
      logstring("OB RWS -- Player movement reenabled");
    }
  }

  self.successfuluse = 1;
  logstring("OB RWS -- Successful use set to true");
}

function function_b7ba1061f0c2d5fa(safe) {
  waittill_any_timeout_2(4, "interact_finished", "remove_rig");
  logstring("OB RWS -- Timeout reached");
  self stopanimscriptsceneevent();
  self stopviewmodelanim();

  if(isDefined(self.linktoent)) {
    self unlink();
    self.linktoent delete();
    self.linktoent = undefined;
  }

  self notify("remove_rig");
  function_b2451d0fac313fbe(1);
  safe.successfuluse = 1;
}

function function_b2451d0fac313fbe(isallowed) {
  if(!isallowed) {
    val::set("drilling", "allow_jump", 0);
    val::set("drilling", "gesture", 0);
    val::set("drilling", "melee", 0);
    val::set("drilling", "mantle", 0);
    val::set("drilling", "offhand_weapons", 0);
    val::set("drilling", "allow_movement", 0);
    val::set("drilling", "sprint", 0);
    val::set("drilling", "fire", 0);
    val::set("drilling", "reload", 0);
    val::set("drilling", "weapon_pickup", 0);
    val::set("drilling", "weapon_switch", 0);
    val::set("drilling", "offhand_weapons", 0);
    val::set("drilling", "execution_victim", 0);
    val::set("drilling", "vehicle_use", 0);
    self function_35501b42058d4de9();
    return;
  }

  val::reset_all("drilling");
  self function_bb04491d50d9e43e();
}

function function_29d903a8de1ffd34(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player function_b2451d0fac313fbe(1);
}

function function_1931531a97158d1f() {
  self.var_6b9eefeff825604b = function_36a95c9de2ace25a("ob_weapon_stash_marker", 0, 1);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_6b9eefeff825604b, self.safe.origin + (0, 0, 85));
  waitframe();
  self.var_2a2f4483763847a0 = "current";
  function_6f02ac608d44fdbf(self.var_6b9eefeff825604b, 0);
  self.ping_owner = self.playerparticipants[0];
  self.ping_index = self.ping_owner scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, self.safe.origin + (0, 0, 85), self.var_6b9eefeff825604b);
  self waittill("activity_ended");
  function_765b706dc170e214(self.var_6b9eefeff825604b);
}

function function_3075c891e48a5474(var_27e49251bb3376ea, shouldping) {
  waitframe();
  thread function_1931531a97158d1f();

  if(isDefined(var_27e49251bb3376ea) && istrue(shouldping)) {
    waitframe();
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_6b9eefeff825604b, 0);
    var_27e49251bb3376ea scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, self.safe.origin + (0, 0, 85), self.var_6b9eefeff825604b);
  }
}