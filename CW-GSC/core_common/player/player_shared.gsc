/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_shared.gsc
************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace player;

function private autoexec __init__system__() {
  system::register(#"player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("world", "gameplay_started", 1, 1, "int");
  clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int");
  clientfield::register("toplayer", "player_dof_settings", 1, 2, "int");

  if(util::is_frontend_map()) {
    return;
  }

  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  setDvar(#"hash_256144ebda864b87", 1);

  if(!isDefined(getdvarint(#"hash_8351525729015ab", 0))) {
    setDvar(#"hash_8351525729015ab", 0);
  }

  level.var_7d3ed2bf = currentsessionmode() != 4 && (isDefined(getgametypesetting(#"hash_6e051e440a6c3b91")) ? getgametypesetting(#"hash_6e051e440a6c3b91") : 0);
  level.var_68de7e10 = 1;
  level thread function_c518cf71();
}

function on_player_connect() {
  self.connect_time = gettime();
}

function spawn_player() {
  self endon(#"disconnect", #"joined_spectators");
  self notify(#"spawned");
  level notify(#"player_spawned");
  self notify(#"end_respawn");
  self set_spawn_variables();
  self luinotifyevent(#"player_spawned", 0);
  self function_8ba40d2f(#"player_spawned", 0);
  self setclientuivisibilityflag("killcam_nemesis", 0);
  self.sessionteam = self.team;
  function_73646bd9(self);
  self.sessionstate = "playing";
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.statusicon = "";
  self.damagedplayers = [];
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  self.afk = 0;
  self.laststunnedby = undefined;
  self.var_a010bd8f = undefined;
  self.var_9060b065 = undefined;
  self.lastflashedby = undefined;
  self.var_a7679005 = undefined;
  self.var_7ef2427c = undefined;
  self.var_e021fe43 = undefined;
  self.var_f866f320 = undefined;
  self.laststand = undefined;
  self.resurrect_not_allowed_by = undefined;
  self.revivingteammate = 0;
  self.burning = undefined;
  self.lastshotby = 127;
  self.maxhealth = self.spawnhealth;
  self.health = self.maxhealth;
  self function_9080887a();
  self.var_4a755632 = undefined;
  self.var_e03e3ae5 = undefined;

  if(self.pers[#"lives"] && !is_true(level.takelivesondeath)) {
    self.pers[#"lives"]--;
  }

  if(isDefined(game.lives) && is_true(game.lives[self.team]) && !is_true(level.takelivesondeath)) {
    game.lives[self.team]--;

    if(level.basegametype == "control") {
      self callback::callback(#"hash_7de173a0523c27c9", self);
    }
  }

  self.disabledweapon = 0;
  self util::resetusability();
  self reset_attacker_list();
  self resetfov();
}

function on_player_spawned() {
  if(util::is_frontend_map()) {
    return;
  }

  self function_619a5c20();

  if(!isDefined(level.var_2386648b)) {
    level.var_2386648b = 0;
  }

  if(sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
    snappedorigin = self get_snapped_spot_origin(self.origin);

    if(!self flag::get(#"shared_igc")) {
      self setorigin(snappedorigin);
    }
  }
}

function function_135acc2d(var_e2bc3a9f, update_rate) {
  max_clients = getdvarint(#"com_maxclients", 0);
  wait_time = max(float(function_60d95f53()) / 1000, update_rate / max_clients);
  var_3c59cda4 = int(ceil(wait_time / 1 / max_clients));
  var_bf4d050f = max_clients;

  while(level.var_68de7e10) {
    var_2a20944d = 0;
    var_7ac865f7 = max_clients;
    var_42016ec7 = var_bf4d050f + 1;

    if(var_42016ec7 >= max_clients) {
      var_42016ec7 = 0;
    }

    players = getplayers();

    if(players.size == 0) {
      waitframe(1);
      continue;
    }

    var_92c4d936 = 0;

    foreach(index, player in players) {
      player = players[index];
      player_num = player getentitynumber();

      if(player_num >= var_42016ec7) {
        break;
      }

      var_92c4d936++;
    }

    var_92c4d936 %= players.size;

    for(player_index = 0; player_index < players.size; player_index++) {
      actual_index = (player_index + var_92c4d936) % players.size;
      assert(actual_index < players.size);
      player = players[actual_index];

      if(player.sessionstate != "playing") {
        continue;
      }

      player[[var_e2bc3a9f]]();
      var_2a20944d++;
      var_bf4d050f = player getentitynumber();

      if(var_3c59cda4 <= var_2a20944d) {
        break;
      }
    }

    waitframe(1);
  }
}

function function_c518cf71() {
  update_rate = 0.1;

  if(sessionmodeiszombiesgame() || sessionmodeiscampaigngame()) {
    update_rate = 0.1;
  }

  if(sessionmodeiswarzonegame()) {
    return;
  }

  function_135acc2d(&function_8fef418b, update_rate);
}

function function_8fef418b() {
  if(!isDefined(self.last_valid_position)) {
    self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
  }

  if(!isDefined(self.last_valid_position)) {
    return;
  }

  if(isDefined(level.var_cdc822b) && ![[level.var_cdc822b]]()) {
    return;
  }

  playerradius = self getpathfindingradius();

  if(ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < sqr(playerradius) && sqr(self.origin[2] - self.last_valid_position[2]) < sqr(16)) {
    return;
  }

  if(self isplayerswimming()) {
    if(isDefined(self.var_5d991645)) {
      if(distancesquared(self.origin, self.var_5d991645) < sqr(playerradius)) {
        return;
      }
    }

    ground_pos = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[#"position"];

    if(!isDefined(ground_pos)) {
      return;
    }

    position = getclosestpointonnavmesh(ground_pos, 100, playerradius);

    if(isDefined(position)) {
      self.last_valid_position = position;
      self.var_5d991645 = self.origin;
    }

    return;
  }

  if(ispointonnavmesh(self.origin, self)) {
    self.last_valid_position = self.origin;
    return;
  }

  if(!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < sqr(32) && sqr(self.origin[2] - self.last_valid_position[2]) < sqr(32)) {
    return;
  }

  var_946a4954 = isDefined(level.var_946a4954) ? level.var_946a4954 : playerradius;
  position = getclosestpointonnavmesh(self.origin, 100, var_946a4954);

  if(isDefined(position)) {
    if(is_true(level.var_2386648b) || function_352d316e(self)) {
      player_position = self.origin + (0, 0, 20);
      var_f5df51f2 = position + (0, 0, 20);
      ignore_ent = undefined;

      if(self isinvehicle()) {
        ignore_ent = self getvehicleoccupied();
      }

      if(bullettracepassed(player_position, var_f5df51f2, 0, self, ignore_ent)) {
        self.last_valid_position = position;
      }
    } else {
      self.last_valid_position = position;
    }

    return;
  }

  if(isDefined(level.var_a6a84389)) {
    self.last_valid_position = self[[level.var_a6a84389]](playerradius);
  }
}

function function_31b5c778(origin, radius) {
  if(!isDefined(level.var_c227eda9)) {
    level.var_c227eda9 = 0;
  }

  level.var_c227eda9 = max(level.var_c227eda9, radius);

  if(!isDefined(level.var_f0de6634)) {
    level.var_f0de6634 = [];
  }

  level.var_f0de6634[level.var_f0de6634.size] = {
    #origin: origin, #radius_sq: sqr(radius)
  };
}

function function_352d316e(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isDefined(level.var_f0de6634) || level.var_f0de6634.size <= 0) {
    return false;
  }

  var_9101d730 = function_72d3bca6(level.var_f0de6634, player.origin, undefined, 0, level.var_c227eda9);

  foreach(area in var_9101d730) {
    if(isDefined(area) && distancesquared(player.origin, area.origin) < area.radius_sq) {
      return true;
    }
  }

  return false;
}

function take_weapons() {
  if(!is_true(self.gun_removed)) {
    self.gun_removed = 1;
    self._weapons = [];

    if(!isDefined(self._current_weapon)) {
      self._current_weapon = level.weaponnone;
    }

    w_current = self getcurrentweapon();

    if(w_current != level.weaponnone) {
      self._current_weapon = w_current;
    }

    a_weapon_list = self getweaponslist();

    if(self._current_weapon == level.weaponnone) {
      if(isDefined(a_weapon_list[0])) {
        self._current_weapon = a_weapon_list[0];
      }
    }

    foreach(weapon in a_weapon_list) {
      if(is_true(weapon.dniweapon)) {
        continue;
      }

      if(!isDefined(self._weapons)) {
        self._weapons = [];
      } else if(!isarray(self._weapons)) {
        self._weapons = array(self._weapons);
      }

      self._weapons[self._weapons.size] = get_weapondata(weapon);
    }

    foreach(weapon in a_weapon_list) {
      self takeweapon(weapon);
    }

    if(isDefined(level.detach_all_weapons)) {
      self[[level.detach_all_weapons]]();
    }
  }
}

function generate_weapon_data() {
  self._generated_weapons = [];

  if(!isDefined(self._generated_current_weapon)) {
    self._generated_current_weapon = level.weaponnone;
  }

  if(is_true(self.gun_removed) && isDefined(self._weapons)) {
    self._generated_weapons = arraycopy(self._weapons);
    self._generated_current_weapon = self._current_weapon;
    return;
  }

  w_current = self getcurrentweapon();

  if(w_current != level.weaponnone) {
    self._generated_current_weapon = w_current;
  }

  a_weapon_list = self getweaponslist();

  if(self._generated_current_weapon == level.weaponnone) {
    if(isDefined(a_weapon_list[0])) {
      self._generated_current_weapon = a_weapon_list[0];
    }
  }

  foreach(weapon in a_weapon_list) {
    if(is_true(weapon.dniweapon)) {
      continue;
    }

    if(!isDefined(self._generated_weapons)) {
      self._generated_weapons = [];
    } else if(!isarray(self._generated_weapons)) {
      self._generated_weapons = array(self._generated_weapons);
    }

    self._generated_weapons[self._generated_weapons.size] = get_weapondata(weapon);
  }
}

function give_back_weapons(b_immediate = 0) {
  if(isDefined(self._weapons)) {
    foreach(weapondata in self._weapons) {
      weapondata_give(weapondata);
    }

    if(isDefined(self._current_weapon) && self._current_weapon != level.weaponnone) {
      if(b_immediate) {
        self switchtoweaponimmediate(self._current_weapon);
      } else {
        self switchtoweapon(self._current_weapon);
      }
    } else {
      weapon = self loadout::function_18a77b37("primary");

      if(isDefined(weapon) && self hasweapon(weapon)) {
        switch_to_primary_weapon(b_immediate);
      }
    }
  }

  self._weapons = undefined;
  self.gun_removed = undefined;
}

function get_weapondata(weapon) {
  if(isDefined(level.var_51443ce5)) {
    return self[[level.var_51443ce5]](weapon);
  }

  weapondata = [];

  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }

  weapondata[#"weapon"] = weapon.rootweapon.name;
  weapondata[#"attachments"] = util::function_2146bd83(weapon);

  if(weapon != level.weaponnone) {
    weapondata[#"clip"] = self getweaponammoclip(weapon);
    weapondata[#"stock"] = self getweaponammostock(weapon);
    weapondata[#"fuel"] = self getweaponammofuel(weapon);
    weapondata[#"heat"] = self isweaponoverheating(1, weapon);
    weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
    weapondata[#"renderoptionsweapon"] = self function_ade49959(weapon);
    weapondata[#"hash_305a93e7a368c654"] = self function_8cbd254d(weapon);

    if(weapon.isriotshield) {
      weapondata[#"health"] = self.weaponhealth;
    }
  } else {
    weapondata[#"clip"] = 0;
    weapondata[#"stock"] = 0;
    weapondata[#"fuel"] = 0;
    weapondata[#"heat"] = 0;
    weapondata[#"overheat"] = 0;
  }

  if(weapon.dualwieldweapon != level.weaponnone) {
    weapondata[#"lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
  } else {
    weapondata[#"lh_clip"] = 0;
  }

  if(weapon.altweapon != level.weaponnone) {
    weapondata[#"alt_clip"] = self getweaponammoclip(weapon.altweapon);
    weapondata[#"alt_stock"] = self getweaponammostock(weapon.altweapon);
  } else {
    weapondata[#"alt_clip"] = 0;
    weapondata[#"alt_stock"] = 0;
  }

  return weapondata;
}

function weapondata_give(weapondata) {
  if(isDefined(level.var_bfbdc0cd)) {
    self[[level.var_bfbdc0cd]](weapondata);
    return;
  }

  weapon = util::get_weapon_by_name(weapondata[#"weapon"], weapondata[#"attachments"]);
  self giveweapon(weapon, weapondata[#"renderoptionsweapon"], weapondata[#"hash_305a93e7a368c654"]);

  if(weapon != level.weaponnone) {
    self setweaponammoclip(weapon, weapondata[#"clip"]);
    self setweaponammostock(weapon, weapondata[#"stock"]);

    if(isDefined(weapondata[#"fuel"])) {
      self setweaponammofuel(weapon, weapondata[#"fuel"]);
    }

    if(isDefined(weapondata[#"heat"]) && isDefined(weapondata[#"overheat"])) {
      self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
    }

    if(weapon.isriotshield && isDefined(weapondata[#"health"])) {
      self.weaponhealth = weapondata[#"health"];
    }
  }

  if(weapon.dualwieldweapon != level.weaponnone) {
    self setweaponammoclip(weapon.dualwieldweapon, weapondata[#"lh_clip"]);
  }

  if(weapon.altweapon != level.weaponnone) {
    self setweaponammoclip(weapon.altweapon, weapondata[#"alt_clip"]);
    self setweaponammostock(weapon.altweapon, weapondata[#"alt_stock"]);
  }
}

function switch_to_primary_weapon(b_immediate = 0, var_61bb3b76 = 0) {
  weapon = self loadout::function_18a77b37("primary");

  if(is_valid_weapon(weapon)) {
    if(b_immediate) {
      self switchtoweaponimmediate(weapon, var_61bb3b76);
      return;
    }

    self switchtoweapon(weapon, var_61bb3b76);
  }
}

function function_1bff13a1(b_immediate = 0, var_61bb3b76 = 0) {
  weapon = self loadout::function_18a77b37("secondary");

  if(is_valid_weapon(weapon)) {
    if(b_immediate) {
      self switchtoweaponimmediate(weapon, var_61bb3b76);
      return;
    }

    self switchtoweapon(weapon, var_61bb3b76);
  }
}

function fill_current_clip(var_aa12242d = 0) {
  w_current = self getcurrentweapon();

  if(w_current.isheavyweapon) {
    w_current = self loadout::function_18a77b37("primary");
  }

  if(isDefined(w_current) && self hasweapon(w_current)) {
    if(var_aa12242d) {
      var_61b58f30 = self getweaponammoclip(w_current);
      var_45193587 = self getweaponammostock(w_current);
      var_c22fa6b8 = w_current.clipsize - var_61b58f30;
      var_f2084708 = int(min(var_c22fa6b8, var_45193587));

      if(var_c22fa6b8 > 0 && var_f2084708 > 0) {
        self setweaponammoclip(w_current, var_61b58f30 + var_f2084708);
        self setweaponammostock(w_current, var_45193587 - var_f2084708);
      }

      if(isDefined(w_current.altweapon)) {
        var_4d29c04f = self getweaponammoclip(w_current.altweapon);
        var_a398bb57 = self getweaponammostock(w_current.altweapon);
        var_b5193f0f = w_current.altweapon.clipsize - var_4d29c04f;
        var_c95287ff = int(min(var_b5193f0f, var_a398bb57));

        if(var_b5193f0f > 0 && var_c95287ff > 0) {
          self setweaponammoclip(w_current.altweapon, var_4d29c04f + var_c95287ff);
          self setweaponammostock(w_current.altweapon, var_a398bb57 - var_c95287ff);
        }
      }

      return;
    }

    self setweaponammoclip(w_current, w_current.clipsize);

    if(isDefined(w_current.altweapon)) {
      self setweaponammoclip(w_current.altweapon, w_current.altweapon.clipsize);
    }
  }
}

function is_valid_weapon(weaponobject) {
  return isDefined(weaponobject) && weaponobject != level.weaponnone;
}

function is_spawn_protected() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(self.spawntime)) {
    self.spawntime = 0;
  }

  return gettime() - (isDefined(self.spawntime) ? self.spawntime : 0) <= int(level.spawnsystem.var_d9984264 * 1000);
}

function simple_respawn() {
  self[[level.onspawnplayer]](0);
}

function get_snapped_spot_origin(spot_position) {
  snap_max_height = 100;
  size = 15;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
  new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
  trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);

  if(trace[#"fraction"] < 1) {
    return trace[#"position"];
  }

  return spot_position;
}

function allow_stance_change(b_allow = 1) {
  if(b_allow) {
    self allowprone(1);
    self allowcrouch(1);
    self allowstand(1);
    return;
  }

  str_stance = self getstance();

  switch (str_stance) {
    case # "prone":
      self allowprone(1);
      self allowcrouch(0);
      self allowstand(0);
      break;
    case # "crouch":
      self allowprone(0);
      self allowcrouch(1);
      self allowstand(0);
      break;
    case # "stand":
      self allowprone(0);
      self allowcrouch(0);
      self allowstand(1);
      break;
  }
}

function set_spawn_variables() {
  self stopshellshock();
  self stoprumble("damage_heavy");
}

function reset_attacker_list() {
  self.attackers = [];
  self.attackerdata = [];
  self.attackerdamage = [];
  self.var_6ef09a14 = [];
  self.firsttimedamaged = 0;
}

function function_9080887a(var_cf05ebb7) {
  if(!isDefined(self.var_894f7879)) {
    self.var_894f7879 = [];
  }

  var_f7d37aa4 = 0;

  foreach(modifier in self.var_894f7879) {
    var_f7d37aa4 += modifier;
  }

  basemaxhealth = isDefined(var_cf05ebb7) ? var_cf05ebb7 : self.spawnhealth;
  self.var_66cb03ad = int(basemaxhealth + var_f7d37aa4 + (isDefined(level.var_90bb9821) ? level.var_90bb9821 : 0));

  if(self.var_66cb03ad < 1) {
    self.var_66cb03ad = 1;
  }
}

function function_d1768e8e() {
  self notify(#"fully_healed");
  callback::callback(#"fully_healed");
}

function function_c6fe9951() {
  self notify(#"done_healing");
  callback::callback(#"done_healing");
}

function function_2a67df65(modname, value, var_96a9fbf4, var_b861a047) {
  if(!isDefined(self.var_894f7879)) {
    self.var_894f7879 = [];
  }

  self function_74598aba(var_96a9fbf4);
  can_modify = 1;

  if(level.wound_disabled === 1 && value < 0) {
    can_modify = 0;
  }

  if(can_modify) {
    self.var_894f7879[modname] = value;
  }

  self function_9080887a();

  if(!is_true(var_b861a047)) {
    self function_b2b139e6();
  }
}

function function_b2b139e6() {
  if(isDefined(self.var_abe2db87)) {
    return;
  }

  if(self.health > self.var_66cb03ad) {
    self.health = self.var_66cb03ad;
    self function_d1768e8e();
  }
}

function function_b933de24(modname, var_b861a047) {
  if(isDefined(self)) {
    if(!isDefined(self.var_894f7879)) {
      self.var_894f7879 = [];
    }

    var_d87cedce = self.var_66cb03ad;
    self.var_894f7879[modname] = undefined;
    self function_9080887a();

    if(!is_true(var_b861a047)) {
      self function_b2b139e6();
    }
  }
}

function function_74598aba(var_96a9fbf4) {
  if(!isDefined(var_96a9fbf4)) {
    return;
  }

  foreach(modifier in var_96a9fbf4) {
    if(!isDefined(modifier)) {
      continue;
    }

    self function_b933de24(modifier.name, modifier.var_b861a047);
  }
}

function function_466d8a4b(var_b66879ad, team) {
  params = {
    #team: team, #var_b66879ad: var_b66879ad
  };
  self notify(#"joined_team", params);
  level notify(#"joined_team");
  self callback::callback(#"joined_team", params);
}

function function_6f6c29e(var_b66879ad) {
  params = {
    #team: # "spectator", #var_b66879ad: var_b66879ad
  };
  self notify(#"joined_spectator", params);
  level notify(#"joined_spectator");
  self callback::callback(#"on_joined_spectator", params);
}

function function_2f80d95b(player_func, ...) {
  players = getplayers();

  foreach(player in players) {
    util::single_func_argarray(player, player_func, vararg);
  }
}

function function_4dcd9a89(players, player_func, ...) {
  foreach(player in players) {
    util::single_func_argarray(player, player_func, vararg);
  }
}

function function_7629df88(team, player_func, ...) {
  players = getplayers();

  foreach(player in players) {
    if(player.team == team) {
      util::single_func_argarray(player, player_func, vararg);
    }
  }
}

function function_e7f18b20(player_func, ...) {
  players = getplayers();

  foreach(player in players) {
    if(!isDefined(player.pers[#"team"])) {
      continue;
    }

    util::single_func_argarray(player, player_func, vararg);
  }
}

function function_38de2d5a(notification) {
  players = getplayers();

  foreach(player in players) {
    player notify(notification);
  }
}

function init_heal(var_cd7b9255, var_e9c4ebeb) {
  var_84d04e6 = {
    #enabled: var_cd7b9255, #rate: 0, #var_bc840360: 0, #var_c8777194: var_e9c4ebeb, #var_b8c7d886: 0, #var_a1cac2f1: 0
  };

  if(!isDefined(self.heal)) {
    self.heal = var_84d04e6;
  }

  if(!isDefined(self.var_66cb03ad)) {
    self.var_66cb03ad = self.maxhealth;
  }
}

function figure_out_attacker(eattacker) {
  if(isDefined(eattacker) && !isPlayer(eattacker)) {
    team = self.team;

    if(isDefined(eattacker.script_owner)) {
      if(util::function_fbce7263(eattacker.script_owner.team, team)) {
        eattacker = eattacker.script_owner;
      }
    }

    if(isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }

    if(is_true(eattacker.var_97f1b32a) && isDefined(level.var_6ed50229)) {
      assert(isvehicle(eattacker));

      if(isvehicle(eattacker) && isDefined(eattacker.var_735382e) && isDefined(eattacker.var_a816f2cd)) {
        driver = eattacker getseatoccupant(0);

        if(!isDefined(driver)) {
          currenttime = gettime();

          if(currenttime - eattacker.var_a816f2cd <= int(level.var_6ed50229 * 1000)) {
            eattacker = eattacker.var_735382e;
          }
        }
      }
    }
  }

  return eattacker;
}

function function_803e2c82(weapon) {
  if(isPlayer(self)) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.type === # "melee") {
      weapon = currentweapon;
    } else {
      primaryweapon = self loadout::function_18a77b37("primary");
      secondaryweapon = self loadout::function_18a77b37("secondary");

      if(currentweapon === primaryweapon && secondaryweapon.type === # "melee") {
        weapon = secondaryweapon;
      } else if(currentweapon === secondaryweapon && primaryweapon.type === # "melee") {
        weapon = primaryweapon;
      }
    }
  }

  return weapon;
}

function function_4ca4d8c6(string, value) {
  assert(isDefined(string), "<dev string:x38>");

  if(isDefined(self) && isDefined(self.pers)) {
    self.pers[string] = value;
  }
}

function function_2abc116(string, defaultval) {
  assert(isDefined(string), "<dev string:x38>");

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[string])) {
    return self.pers[string];
  }

  return defaultval;
}

function function_3d288f14() {
  if(isbot(self)) {
    if(isDefined(self.var_30e2c3ec)) {
      return self.var_30e2c3ec;
    }

    rand = randomintrange(0, 3);

    switch (rand) {
      case 0:
        self.var_30e2c3ec = # "none";
        break;
      case 1:
        self.var_30e2c3ec = # "game";
        break;
      case 2:
        self.var_30e2c3ec = # "system";
        break;
    }

    return self.var_30e2c3ec;
  }

  status = self voipstatus();
  return status;
}

function function_d36b6597() {
  max_clients = getdvarint(#"com_maxclients", 0);
  assert(max_clients != 0);

  if(!isDefined(level.maxteamplayers)) {
    level.maxteamplayers = 0;
  }

  if(!isDefined(level.teamcount)) {
    level.teamcount = 0;
  }

  var_27e8a04e = max_clients;

  if((level.teamcount == 0 || max_clients == level.teamcount) && level.maxteamplayers > 0) {
    var_27e8a04e = level.maxteamplayers;
  } else if(level.teamcount > 0) {
    var_27e8a04e = max_clients;
  }

  return var_27e8a04e;
}

function private function_c70c4c93(party) {
  max_players = function_d36b6597();
  assert(max_players == 0 || party.var_a15e4438 <= max_players);

  if(isDefined(level.var_7d3ed2bf) && level.var_7d3ed2bf && !party.fill) {
    return max_players;
  }

  return party.var_a15e4438;
}

function function_1cec6cba(players) {
  var_ab9e77bf = [];

  var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);

  foreach(player in players) {
    party = player getparty();
    var_ab9e77bf[party.party_id] = function_c70c4c93(party);

    if(var_f8896168) {
      var_ab9e77bf[party.party_id] = party.var_a15e4438;
    }
  }

  var_6195506c = 0;

  foreach(count in var_ab9e77bf) {
    var_6195506c += count;
  }

  return var_6195506c;
}

function function_114b77dd(time, timeout) {
  if(self isstreamerready(-1, 1)) {
    return true;
  }

  if(!isDefined(timeout)) {
    timeout = getdvarint(#"hash_6974ec4bbf3b9e97");
  }

  if(!isDefined(time)) {
    time = gettime();
  }

  if(isDefined(self.connect_time) && self.connect_time + timeout < gettime()) {
    return true;
  }

  return false;
}

function function_51b57f72() {
  return getdvarint(#"hash_6974ec4bbf3b9e97");
}

function function_80e763a4() {
  level flag::set(#"hash_2210f8d75db6eda7");
}

function function_171bf4c0() {
  return level flag::get(#"hash_2210f8d75db6eda7");
}