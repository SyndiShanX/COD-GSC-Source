/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_train_quest.gsc
******************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_movingtrain;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\dmz_safes;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#namespace br_train_quest;

function init_if_enabled() {
  if(getdvarint(@ "hash_60355961ac1f1063", 1)) {
    init();
  }
}

function private init() {
  if(flag("br_train_quest_init")) {
    return;
  }

  flag_set("br_train_quest_init");
  scripts\mp\gametypes\dmz_safes::script_model_anims();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_train_safe", &function_26e694eaafebe73c);
  var_877172e593c7fb19 = br_movingtrain::function_3b5a11ea11e271c3("safe");
  var_877172e593c7fb19.spawncallback = &function_62bd404312cecada;

  if(getdvarint(@ "hash_83c8be3d091af886", 0)) {
    br_movingtrain::function_3ca2a4be197dfa5b(&function_82b1357d60ce224e);
  }

  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_c96d7535862e245c);
}

function private function_82b1357d60ce224e() {
  if(!isDefined(level.wztrain_info.trains["cargo_train"])) {
    return;
  }

  var_939c5aaee2bf2b49 = level.wztrain_info.trains["cargo_train"][3];
  br_movingtrain::function_fa04a5bfe00504bc(var_939c5aaee2bf2b49, "safe", "br_train_safe", (0, 50, -30), (0, -90, 0));
}

function private function_62bd404312cecada(type, origin, angles, traincar) {
  safe = spawn_safe((0, 0, 0), (0, 0, 0));
  safe function_ace8423d837f14d1(traincar, origin, angles);
  return safe;
}

function spawn_safe(origin, angles) {
  safe = spawnscriptable("br_train_safe", origin, angles);
  safe.curorigin = safe.origin;
  safe.offset3d = (0, 0, 15);
  safe scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = safe.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objid, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, safe.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::function_9cad42ac02eff950(objid);
  scripts\mp\objidpoolmanager::function_6ae37618bb04ea60(objid);
  safe setscriptablepartstate("objective", "active");
  safe.nearbyplayers = [];
  safe.var_625654e09b670910 = [];
  safe.var_743b148ac60bab37 = getdvarfloat(@ "hash_af88cd786b8dcdc2", 20);
  safe.var_252e232991e1d8e1 = getdvarfloat(@ "hash_88d714271f35dc40", 5);
  safe reset_safe();
  safe thread thread_safe_think();
  return safe;
}

function function_ace8423d837f14d1(carriage, offset, angles) {
  if(!isDefined(offset)) {
    offset = (0, -50, -30);
  }

  if(!isDefined(angles)) {
    angles = (0, 90, 0);
  }

  self.train = carriage.train_name;
  scriptable_setparententity(carriage, offset, angles);
  safe_marker = spawn("script_model", coordtransform((0, 0, 15), self.origin, self.angles));
  safe_marker setModel("tag_origin");
  safe_marker linkTo(carriage);
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, safe_marker);
}

function get_state() {
  return self getscriptablepartstate("br_train_safe");
}

function private function_45cac7fd4cb39f5b() {
  return self getscriptablepartstate("br_train_safe_drill");
}

function private is_reset() {
  return !isDefined(self.owner_team);
}

function private function_bd3c7b7340eedfc7(team) {
  return istrue(self.var_625654e09b670910[team]);
}

function private update_all() {
  function_c0b7aa55dfc0607d();
  function_8a22a9a44b0eaeae();
  function_e26de89b0b5fab71();
  update_usable();
  function_ed42d7d2676c096c();
}

function private function_c0b7aa55dfc0607d() {
  if(!isDefined(self.var_7aec0ca5b1db5909)) {
    self.var_7aec0ca5b1db5909 = [];
  }

  var_edf9599efff4cbd2 = [];
  state = get_state();
  is_visible = !is_reset() && state != "opening" && state != "open";

  if(is_visible) {
    foreach(nearby_player in self.nearbyplayers) {
      if(function_90893f0eee9ae7a8(nearby_player)) {
        var_edf9599efff4cbd2[var_edf9599efff4cbd2.size] = nearby_player;
      }
    }
  }

  new_shown = array_difference(var_edf9599efff4cbd2, self.var_7aec0ca5b1db5909);
  new_hidden = array_difference(self.var_7aec0ca5b1db5909, var_edf9599efff4cbd2);

  foreach(player in new_shown) {
    if(isDefined(player)) {
      scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(self.objidnum, player, 2, 2, function_1762caac04a1a01f(player));
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
    }
  }

  foreach(player in new_hidden) {
    if(isDefined(player)) {
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objidnum, player);
    }
  }

  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "current");
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
  self.var_7aec0ca5b1db5909 = var_edf9599efff4cbd2;
}

function private function_8a22a9a44b0eaeae() {
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, clamp(self.using_progress / self.var_743b148ac60bab37, 0.005, 1));
  objective_setownerteam(self.objidnum, self.owner_team);
  objective_setprogressteam(self.objidnum, self.owner_team);
}

function private function_e26de89b0b5fab71() {
  foreach(player in self.var_7aec0ca5b1db5909) {
    if(isDefined(player)) {
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, player);
      scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(self.objidnum, player, 2, 2, function_1762caac04a1a01f(player));
    }
  }
}

function private update_usable() {
  foreach(nearby_player in self.nearbyplayers) {
    if(function_90893f0eee9ae7a8(nearby_player)) {
      self enablescriptableplayeruse(nearby_player);
      continue;
    }

    self disablescriptableplayeruse(nearby_player);
  }
}

function private function_ed42d7d2676c096c() {
  safe_state = get_state();
  var_f95f3b110bbb0950 = function_45cac7fd4cb39f5b();
  var_dc17121088288479 = safe_state == "opening" || safe_state == "open";

  switch (var_f95f3b110bbb0950) {
    case #"hash_ed314c172f7890cc":
      if(var_dc17121088288479) {
        self setscriptablepartstate("br_train_safe_drill", "disabled");
      } else if(safe_state != "unusable") {
        self setscriptablepartstate("br_train_safe_drill", "paused");
      }

      break;
    case #"hash_5600cb846972d32b":
      if(var_dc17121088288479) {
        self setscriptablepartstate("br_train_safe_drill", "disabled");
      } else if(safe_state == "unusable") {
        self setscriptablepartstate("br_train_safe_drill", "unusable_drilling");
      }

      break;
    case #"hash_35bb36c485686365":
      if(!var_dc17121088288479) {
        self setscriptablepartstate("br_train_safe_drill", "disabled");
      } else if(safe_state == "unusable") {
        self setscriptablepartstate("br_train_safe_drill", "unusable_drilling");
      } else {
        self setscriptablepartstate("br_train_safe_drill", "paused");
      }

      break;
  }
}

function private function_9eb245bfdbb39a72(team) {
  thread_notify = "thread_mark_team_nearby_temporarily_" + team;
  fade_time = getdvarfloat(@ "hash_879c5ed2249a9fa2", 10);

  if(!isDefined(self.nearby_teams)) {
    self.nearby_teams = [];
  }

  var_cb62b97a1762b985 = isDefined(self.nearby_teams[team]);
  self.nearby_teams[team] = gettime() + fade_time * 1000;

  if(var_cb62b97a1762b985) {
    return;
  }

  team_players = [];

  foreach(player in level.players) {
    if(isDefined(player) && player.team == team) {
      team_players[team_players.size] = player;
    }
  }

  self.nearbyplayers = array_combine(self.nearbyplayers, team_players);
  function_c0b7aa55dfc0607d();

  while(true) {
    wait(self.nearby_teams[team] - gettime()) / 1000;

    if(self.nearby_teams[team] <= gettime()) {
      break;
    }
  }

  self.nearby_teams[team] = undefined;
  self.nearbyplayers = array_remove_array(self.nearbyplayers, team_players);
  function_c0b7aa55dfc0607d();
}

function private function_1762caac04a1a01f(player) {
  safe = self;

  if(!safe is_reset() && player.team == safe.owner_team) {
    if(isDefined(safe.player_using)) {
      return &"MP_BR_INGAME/OPENING_TRAIN_SAFE";
    } else {
      return &"MP_BR_INGAME/OPENING_TRAIN_SAFE_PAUSED";
    }

    return;
  }

  return &"MP_BR_INGAME/OPENING_TRAIN_SAFE_ENEMY";
}

function private function_26e694eaafebe73c(safe, part, state, player, bautouse, usestring) {
  switch (safe get_state()) {
    case #"hash_b19019dbf5761ea8":
      if(safe function_f5f0a46e1e8517f2(player)) {
        safe function_3e1d56470a8d5ec0(player);
      }

      break;
  }
}

function private function_90893f0eee9ae7a8(user) {
  return !function_bd3c7b7340eedfc7(user.team);
}

function private function_f5f0a46e1e8517f2(user) {
  safe = self;

  if(!function_90893f0eee9ae7a8(user)) {
    return false;
  }

  state = safe get_state();

  if(state != "usable_not_open" && state != "unusable") {
    return false;
  }

  if(!user useButtonPressed()) {
    return false;
  }

  if(!player::isreallyalive(user) || istrue(user.inlaststand)) {
    return false;
  }

  if(!istrue(user.var_2265f906389050a2)) {
    user_offset = coordtransformtranspose(user.origin, safe.origin, safe.angles);

    if(distance2dsquared((25, 0, 0), user_offset) > squared(70)) {
      return false;
    }

    if(abs(user_offset[2] - (25, 0, 0)[2]) > 70) {
      return false;
    }
  }

  return true;
}

function private thread_safe_think() {
  level endon("game_ended");
  childthread function_d3b6a03b8a361013();

  while(true) {
    switch (get_state()) {
      case #"hash_b19019dbf5761ea8":
        break;
      case #"hash_562e51cba903292e":
        if(!function_f5f0a46e1e8517f2(self.player_using)) {
          function_a26f0c9a6ae1db0();
          break;
        }

        thread function_9eb245bfdbb39a72(self.owner_team);
        self.using_progress += level.framedurationseconds;
        self.var_75f1dd344728cbc3 = max(self.var_75f1dd344728cbc3, self.using_progress - self.var_252e232991e1d8e1);
        function_8a22a9a44b0eaeae();

        if(self.using_progress >= self.var_743b148ac60bab37) {
          function_3afcd4789cb0ea68();
        }

        break;
    }

    waitframe();
  }
}

function private function_d3b6a03b8a361013() {
  while(true) {
    self waittill("cracking_fail");

    switch (get_state()) {
      case #"hash_562e51cba903292e":
        function_a26f0c9a6ae1db0();
        break;
    }
  }
}

function private function_59cb8a6196523b() {
  level endon("game_ended");

  while(true) {
    nearby = [];
    var_bf9ee0567dc58685 = 0;

    foreach(player in level.players) {
      var_4fd084daa45c79ff = distancesquared(self.origin, player.origin);

      if(isDefined(player.origin) && var_4fd084daa45c79ff < 10240000) {
        var_bf9ee0567dc58685 |= var_4fd084daa45c79ff < 640000;
        trainname = player scripts\cp_mp\utility\train_utility::function_31156831afc882ad();

        if(isDefined(trainname) && trainname == self.train) {
          nearby[nearby.size] = player;
        }
      }
    }

    self.nearbyplayers = nearby;
    function_c0b7aa55dfc0607d();

    if(nearby.size > 0 || var_bf9ee0567dc58685) {
      wait 1;
      continue;
    }

    wait 5;
  }
}

function private function_3afcd4789cb0ea68() {
  capturing_team = self.owner_team;
  namespace_c133516bfc1d803c::displayteamsplash(capturing_team, "dmz_safe_defend_unlocked");
  thread function_af479268b6eab7f8(capturing_team);
  function_1905649c9ef2cf4a();
  self.var_625654e09b670910[capturing_team] = 1;
  self setscriptablepartstate("objective", "inactive");
  thread function_23bf1944f3f41961();
}

function private function_af479268b6eab7f8(var_6d520edad329f3f9) {
  level endon("game_ended");
  wait 0.8;
  rewardcount = clamp(getdvarint(@ "hash_d93d798df6c38e2", 2), 0, 4);

  if(!isDefined(self.openindex) || self.openindex > 48) {
    self.openindex = 0;
  }

  offset = 0;

  for(tempcount = 0; tempcount < rewardcount; tempcount++) {
    items = getscriptcachecontents("br_train_safe", self.openindex);
    lootspawnorigin = coordtransform((18 + offset, 0, 10 + offset), self.origin, self.angles);
    lootspawnangles = combineangles(self.angles, (0, -70 + offset * 2, 0));
    scripts\mp\gametypes\br_quest_util::questrewarddropitems(var_6d520edad329f3f9, items, lootspawnorigin, lootspawnangles, 1, 3, 50);
    offset += 10;
    self.openindex += 1;
  }
}

function private function_23bf1944f3f41961() {
  level endon("game_ended");
  self notify("wait_and_reset");
  self endon("wait_and_reset");
  wait getdvarfloat(@ "hash_261eb9d7c6785c33", 90);
  reset_safe();
  locomotive = level.wztrain_info.trains[self.train][0];
  locomotive notify("reset_train_controls");
  thread function_c7092cc2487a6251();
}

function private reset_safe() {
  self.owner_team = undefined;
  function_63568197776112d7();
  function_a26f0c9a6ae1db0();
  self setscriptablepartstate("br_train_safe_drill", "unusable");
  self setscriptablepartstate("objective", "active");
}

function private function_63568197776112d7() {
  self.using_progress = 0;
  self.var_75f1dd344728cbc3 = 0;
}

function private function_a26f0c9a6ae1db0() {
  self setscriptablepartstate("br_train_safe", "usable_not_open");
  function_cec9c3105b644a92(undefined);
  self.using_progress = self.var_75f1dd344728cbc3;
  update_all();
}

function private function_3e1d56470a8d5ec0(player) {
  self setscriptablepartstate("br_train_safe", "unusable");

  if(!is_equal(self.owner_team, player.team)) {
    function_63568197776112d7();
  }

  function_cec9c3105b644a92(player);
  self.owner_team = player.team;
  thread wait_for_death(player);
  update_all();
  play_horn();
}

function private function_1905649c9ef2cf4a() {
  self setscriptablepartstate("br_train_safe", "opening");
  function_cec9c3105b644a92(undefined);
  update_all();
}

function private function_cec9c3105b644a92(player) {
  if(!isDefined(self.player_using) && !isDefined(player) || is_equal(self.player_using, player)) {
    return;
  }

  self.player_using = player;
  self notify("changed_player_using");

  if(isDefined(player)) {
    thread wait_for_death(player);
    thread wait_for_damage(player);

    if(function_45cac7fd4cb39f5b() == "unusable") {
      thread function_a51704dc689a141f(player);
      return;
    }

    thread function_fc170899dc42b4fa(player);
  }
}

function private function_a51704dc689a141f(player) {
  level endon("game_ended");
  player.var_2265f906389050a2 = 1;

  if(!dmz_safes::function_42d3f8081a96f0b0(self, "br_train_safe_drill", function_45cac7fd4cb39f5b(), player)) {
    self setscriptablepartstate("br_train_safe_drill", "unusable");
  }

  player.var_2265f906389050a2 = undefined;
  function_ed42d7d2676c096c();

  if(is_equal(self.player_using, player)) {
    thread function_fc170899dc42b4fa(player);
  }
}

function private wait_for_death(player) {
  level endon("game_ended");
  self endon("changed_player_using");

  while(true) {
    player waittill("death_or_disconnect");

    if(self.player_using == player) {
      self notify("cracking_fail");
    }
  }
}

function private wait_for_damage(player) {
  level endon("game_ended");
  self endon("changed_player_using");

  while(true) {
    player waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(self.player_using == player) {
      self notify("cracking_fail");
    }
  }
}

function private function_f2028674ae7ebd9(player) {
  return isDefined(self.weapobj) && player hasweapon(self.weapobj);
}

function private play_horn() {
  safe = self;

  if(!getdvarint(@ "hash_b54fb3e0bd6c530d", 1)) {
    return;
  }

  br_movingtrain::function_6ec6dbd953660756(safe.train, "veh_horn_cargotrain");
}

function private function_c7092cc2487a6251() {
  safe = self;

  if(!getdvarint(@ "hash_b54fb3e0bd6c530d", 1)) {
    return;
  }

  level endon("game_ended");
  br_movingtrain::function_6ec6dbd953660756(safe.train, "veh_horn_cargotrain");
  wait 3.5;
  br_movingtrain::function_6ec6dbd953660756(safe.train, "veh_horn_cargotrain");
  wait 3.5;
  br_movingtrain::function_6ec6dbd953660756(safe.train, "veh_horn_cargotrain");
}

function private function_fc170899dc42b4fa(player) {
  level endon("game_ended");
  safe = self;
  player dmz_safes::function_680b501eb7141c84(0, "train_safecracking");
  player thread function_640f73216599d215();

  if(is_equal(safe.player_using, player) && isreallyalive(player)) {
    waittill_any_ents(safe, "changed_player_using", player, "death_or_disconnect", player, "enter_live_ragdoll");
  }

  player function_58bb10638760ba9e();
  waitframe();

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player) && isreallyalive(player)) {
    player dmz_safes::function_680b501eb7141c84(1, "train_safecracking");
  }
}

function private function_640f73216599d215() {
  level endon("game_ended");
  player = self;
  player.var_8d9814f7e620f450 = 1;

  while(istrue(player.var_8d9814f7e620f450) && isDefined(player.gunnlessweapon)) {
    waitframe();
  }

  if(!istrue(player.var_8d9814f7e620f450)) {
    return;
  }

  player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();

  if(istrue(player.var_8d9814f7e620f450)) {
    player waittill("train_quest_gunless_off");
  }

  player scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
}

function private function_58bb10638760ba9e() {
  player = self;
  player.var_8d9814f7e620f450 = undefined;
  player notify("train_quest_gunless_off");
}

function private function_c96d7535862e245c(command, args) {
  firstplayer = level.players[0];

  if(!isDefined(firstplayer)) {
    return;
  }

  switch (command) {
    case #"hash_2899e5a679a1e049":
      if(!isDefined(args[0])) {
        break;
      }

      switch (args[0]) {
        case #"hash_9682e089e580b4b8":
          if(!isDefined(args[1])) {
            break;
          }

          switch (args[1]) {
            case #"hash_819aac6f5ae2fb78":
              playerorigin = firstplayer.origin;
              playerangles = firstplayer getplayerangles();
              playerforward = anglesToForward(playerangles);
              playerforward = (playerforward[0], playerforward[1], 0);
              playerforward = vectorNormalize(playerforward);
              spawnorigin = playerorigin + playerforward * 100 + (0, 0, 0);
              spawnangles = (0, playerangles[1] + 180, 0);
              safe = spawn_safe(spawnorigin, spawnangles);

              if(!isDefined(args[2])) {
                break;
              }

              if(args[2] == "attach") {
                safe function_ace8423d837f14d1(level.wztrain_info.trains["cargo_train"][3]);
              }

              break;
          }

          break;
      }

      break;
  }
}