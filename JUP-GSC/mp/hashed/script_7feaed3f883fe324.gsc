/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7feaed3f883fe324.gsc
*************************************************/

#using script_32d93a194074fa6a;
#using script_6981400abfcd765c;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\rank;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#namespace br_powerups;

function autoexec main() {
  if(getdvarint(@ "hash_5f4c8ff726eb8e87", 0)) {
    level thread init();
  }

  debug_init();
}

function init() {
  scripts\cp_mp\powerups\powerups::init(&function_de43cee7dc74dcd7, &function_504645669cd3844f, 1);
  wait 1;
  root = powerups::function_ecdae672c660149e();
  bundle = powerups::function_e6f547b7f0a996ed();
  root.var_bb85b1a71407050c = getdvarfloat(@ "hash_7948f34b09080935", bundle.var_669205d9e4532cf1);
  root.var_831b3261f6362c60 = getdvarfloat(@ "hash_4e713f489454977f", bundle.var_b3bf16041ccae401);
  root.var_6d9f70a83fe0f7f9 = getdvarfloat(@ "hash_59bd7161c6f93044", bundle.var_d8d585d208a5d6e7);
  utility::registersharedfunc("powerups", "doPowerupScoreEvent", &function_2f0136fd318f2b9e);
  utility::registersharedfunc("powerups", "dropPowerup", &function_9097cec00b0a918a);
  level thread function_c00a33b9a89f6639();
}

function function_c00a33b9a89f6639() {
  level endon("game_ended");
  level waittill("prematch_fade_done");
  init_callbacks();
}

function init_callbacks() {
  root = powerups::function_ecdae672c660149e();

  if(root.var_bb85b1a71407050c > 0) {
    level callback::add("cache_opened", &function_e1be58260c40835e);
  }

  if(root.var_831b3261f6362c60 > 0) {
    level callback::add("player_death", &function_aea3555854e2a2c0);
    level callback::add("on_ai_killed", &function_482776d07f76084b);
  }
}

function function_aea3555854e2a2c0(params) {
  powerups::function_5bfe254c7e9aa4db();
  function_c6c9e69416294659(params.attacker);
}

function function_482776d07f76084b(params) {
  function_c6c9e69416294659(params.eattacker);
}

function function_c6c9e69416294659(attacker) {
  if(!isDefined(attacker) || attacker == self || !isPlayer(attacker) || attacker scripts\mp\gametypes\br_public::isplayeringulag()) {
    if(getdvarint(@ "hash_340406f5e0972920")) {
      if(!isDefined(attacker)) {
        function_a0bd8c322e7661ce(self.origin, "<dev string:x1c>", "<dev string:x4d>", 0);
      }

      if(attacker == self) {
        function_a0bd8c322e7661ce(self.origin, "<dev string:x54>", "<dev string:x4d>", 0);
      }

      if(!isPlayer(attacker)) {
        function_a0bd8c322e7661ce(self.origin, "<dev string:x7f>", "<dev string:x4d>", 0);
      }
    }

    return;
  }

  root = powerups::function_ecdae672c660149e();
  roll = randomfloatrange(0, 1);
  drop_chance = isPlayer(self) ? root.var_831b3261f6362c60 : root.var_6d9f70a83fe0f7f9;

  if(roll > drop_chance) {
    if(getdvarint(@ "hash_340406f5e0972920")) {
      str_killed = isPlayer(self) ? "<dev string:xaf>" : "<dev string:xb9>";
      function_a0bd8c322e7661ce(self.origin, "<dev string:xbf>" + str_killed + "<dev string:xd1>" + roll + "<dev string:xe5>" + drop_chance + "<dev string:xfa>", "<dev string:x4d>", 0);
    }

    return;
  }

  context = spawnStruct();
  context.player = attacker;
  context.victim = self;
  context.method = "kill";

  if(getdvarint(@ "hash_340406f5e0972920")) {
    str_killed = isPlayer(self) ? "<dev string:xaf>" : "<dev string:xb9>";
    function_a0bd8c322e7661ce(self.origin, "<dev string:xbf>" + str_killed + "<dev string:xd1>" + roll + "<dev string:xff>" + drop_chance + "<dev string:xfa>", "<dev string:x114>", 0);
  }

  level thread function_d5aec492bdff1104(self.origin, context);
}

function function_e1be58260c40835e(params) {
  root = powerups::function_ecdae672c660149e();

  if(params.player scripts\mp\gametypes\br_public::isplayeringulag()) {
    return;
  }

  roll = randomfloatrange(0, 1);

  if(roll > root.var_bb85b1a71407050c) {
    if(getdvarint(@ "hash_340406f5e0972920")) {
      function_a0bd8c322e7661ce(params.instance.origin, "<dev string:x11d>" + roll + "<dev string:xe5>" + root.var_bb85b1a71407050c + "<dev string:xfa>", "<dev string:x4d>", 0);
    }

    return;
  }

  [cache_yaw, cache_origin] = scripts\mp\gametypes\br_lootcache::function_cb377a5e11eef62c(params.instance);
  cache_origin = ter_op(isDefined(cache_origin), cache_origin, params.instance.origin);
  cache_forward = isDefined(cache_yaw) ? anglesToForward(params.instance.angles + (0, cache_yaw, 0)) : anglestoleft(params.instance.angles);
  spawn_origin = cache_origin + cache_forward * 50 + (0, 0, root.powerup_vars["drop_height_offset"]);
  context = spawnStruct();
  context.player = params.player;
  context.cache = params.instance;
  context.method = "cache";
  context.cache_origin = cache_origin;

  if(getdvarint(@ "hash_340406f5e0972920")) {
    function_a0bd8c322e7661ce(params.instance.origin, "<dev string:x11d>" + roll + "<dev string:xff>" + root.var_bb85b1a71407050c + "<dev string:xfa>", "<dev string:x114>", 0);
  }

  level thread function_d5aec492bdff1104(spawn_origin, context);
}

function function_d5aec492bdff1104(location, context) {
  root = powerups::function_ecdae672c660149e();

  if(isDefined(context)) {
    powerup = function_71bf1100ed637af1(location, context);
  } else {
    powerup = utility::array_random(root.var_211f18c4ee5c760f);
  }

  source = "undefined";

  switch (context.method) {
    case #"hash_dc0a55772fe305c5":
      source = "cache";
      break;
    case #"hash_611825599f1b56f9":
      source = isPlayer(context.victim) ? "player" : "ai";
      break;
  }

  function_cc7d2e0d5b5d6ad7(powerup, source);
  function_9097cec00b0a918a(powerup, location);
}

function function_71bf1100ed637af1(location, context) {
  if(getdvarint(@ "hash_340406f5e0972920")) {
    i_row = 0;
  }

  root = powerups::function_ecdae672c660149e();
  weights = [];
  sum = 0;

  foreach(powerup_ref in root.var_211f18c4ee5c760f) {
    if(isDefined(context.player.var_aea671476da3fc53) && context.player.var_aea671476da3fc53 == powerup_ref) {
      if(getdvarint(@ "hash_340406f5e0972920")) {
        function_a0bd8c322e7661ce(location, "<dev string:x144>" + powerup_ref + "<dev string:x151>", "<dev string:x4d>", i_row);
        i_row++;
      }

      continue;
    }

    info = powerups::function_519d44e54a9b8ae5(powerup_ref);

    if(isDefined(info.func_should_drop_with_regular_powerups)) {
      should_drop = [[info.func_should_drop_with_regular_powerups]]();

      if(!should_drop) {
        if(getdvarint(@ "hash_340406f5e0972920")) {
          function_a0bd8c322e7661ce(location, "<dev string:x144>" + powerup_ref + "<dev string:x17c>", "<dev string:x4d>", i_row);
          i_row++;
        }

        continue;
      }
    }

    chance = 1;

    switch (context.method) {
      case #"hash_611825599f1b56f9":
        chance = isDefined(info.var_b3bf16041ccae401) ? info.var_b3bf16041ccae401 : chance;
        break;
      case #"hash_dc0a55772fe305c5":
        chance = isDefined(info.var_669205d9e4532cf1) ? info.var_669205d9e4532cf1 : chance;
        break;
    }

    if(isDefined(info.var_58a4e1d475eb979b)) {
      chance = [[info.var_58a4e1d475eb979b]](chance, context);
    }

    if(chance <= 0) {
      if(getdvarint(@ "hash_340406f5e0972920")) {
        function_a0bd8c322e7661ce(location, "<dev string:x144>" + powerup_ref + "<dev string:x198>", "<dev string:x4d>", i_row);
        i_row++;
      }

      continue;
    }

    weight = int(1000 * chance);
    weights[powerup_ref] = weight;
    sum += weight;
  }

  random_int = randomintrange(0, sum);
  selected_ref = "";

  foreach(powerup_ref, weight in weights) {
    random_int -= weight;

    if(random_int <= 0) {
      selected_ref = powerup_ref;
      break;
    }
  }

  context.player.var_aea671476da3fc53 = selected_ref;

  if(getdvarint(@ "hash_340406f5e0972920")) {
    foreach(powerup_ref, weight in weights) {
      if(powerup_ref == selected_ref) {
        function_a0bd8c322e7661ce(location, "<dev string:x144>" + powerup_ref + "<dev string:x1b3>" + weight, "<dev string:x114>", i_row);
      } else {
        function_a0bd8c322e7661ce(location, "<dev string:x144>" + powerup_ref + "<dev string:x1b3>" + weight, "<dev string:x1c1>", i_row);
      }

      i_row++;
    }
  }

  return selected_ref;
}

function function_9097cec00b0a918a(powerup_ref, spawn_pos, var_a3bd3a0466a6a50b) {
  root = powerups::function_ecdae672c660149e();
  info = powerups::function_519d44e54a9b8ae5(powerup_ref);

  if(!isDefined(info.scriptable)) {
    return powerups::powerup_drop(powerup_ref, spawn_pos, var_a3bd3a0466a6a50b);
  }

  height_offset = (0, 0, root.powerup_vars["drop_height_offset"]);
  ground_pos = getgroundposition(spawn_pos, 1, 100) + height_offset;
  powerup = spawnscriptable(info.scriptable, ground_pos, (0, 0, 0));
  powerup setscriptablepartstate("effects", "spawn");
  powerup setscriptablepartstate("model", "show");
  powerup.ref = powerup_ref;
  platform_info = powerup scripts\common\utility::function_2e9e02e8bda61ef2();

  if(isDefined(platform_info) && !isDefined(platform_info.groundent.vehicletype)) {
    powerup utility::scriptable_setparententity(platform_info.groundent, platform_info.localorigin + height_offset, platform_info.localangles);
    powerup.trigger = spawn("trigger_radius", ground_pos, 0, 10, 10);
    powerup.trigger enablelinkTo();
    powerup.trigger linkTo(platform_info.groundent, "", platform_info.localorigin + height_offset, platform_info.localangles);
  } else {
    powerup.trigger = spawn("noent_volume_trigger_radius", ground_pos, 0, 10, 10);
  }

  powerup thread function_a6eb87ea91df000c();
  powerup thread function_26d7152de10f312f(1);
  powerup thread function_1e46f5354a009162();
  return powerup;
}

function function_a6eb87ea91df000c(var_a3bd3a0466a6a50b) {
  level endon("game_ended");
  self endon("powerup_grabbed");
  self endon("powerup_removed");
  self endon("death");
  powerup_info = function_519d44e54a9b8ae5(self.ref);
  lifetime = isDefined(var_a3bd3a0466a6a50b) ? var_a3bd3a0466a6a50b : powerup_info.var_7f552635d01b5fd5;
  blinktime = 10;
  var_445dbb4ca148e9b3 = 3;
  var_f21c923788289311 = lifetime - blinktime;
  wait var_f21c923788289311;
  self.blink_wait = 0.5;
  self.show_state = "blink_show_audio";
  childthread function_bc6da2635941d488();
  wait blinktime - var_445dbb4ca148e9b3;
  self.blink_wait = 0.25;
  self.show_state = "blink_show";
  wait var_445dbb4ca148e9b3;
  self setscriptablepartstate("blink", "off");
  self setscriptablepartstate("effects", "timed_out");
  self setscriptablepartstate("model", "hide");
  thread function_a5954aee8a02845e();
}

function function_bc6da2635941d488() {
  state = 1;

  while(true) {
    state = !state;
    state_name = state ? "blink_hide_audio" : self.show_state;
    self setscriptablepartstate("blink", state_name);
    wait self.blink_wait;
  }
}

function function_26d7152de10f312f(delay) {
  level endon("game_ended");
  self endon("powerup_removed");
  self endon("death");
  wait delay;
  root = powerups::function_ecdae672c660149e();
  info = function_519d44e54a9b8ae5(self.ref);

  while(true) {
    self.trigger waittill("trigger", ent);
    player = ent;

    if(isDefined(root.var_5cdeaceda00983a3)) {
      player = ent[[root.var_5cdeaceda00983a3]]();
    }

    if(!istrue(info.var_f9f899d9e6df9373) && !isPlayer(player)) {
      continue;
    }

    if(!istrue(info.powerupcanpickupinlaststand) && istrue(player.inlaststand)) {
      continue;
    }

    level thread function_eb64b9fa2d5352ee(self.ref);
    self setscriptablepartstate("effects", "grab");
    self setscriptablepartstate("model", "hide");

    if(isDefined(info.var_c5a9d2297ea16382)) {
      a_players = player function_a56a8b17eae57b09(self.ref, self.origin);

      foreach(powerup_player in a_players) {
        if(isalive(powerup_player)) {
          powerup_player function_e5d214c66b6e0082(info.var_c5a9d2297ea16382);
        }
      }
    }

    level callback::callback(#"player_powerup", {
      #player: player, #powerup: self
    });
    player powerups::powerup_activate(self.ref, self);
    player thread ftue_play(self.ref);
    self notify("powerup_grabbed", player);
    thread function_a5954aee8a02845e();
    return;
  }
}

function function_1e46f5354a009162() {
  self endon("death");
  self endon("powerup_removed");
  level waittill("game_ended");
  thread function_a5954aee8a02845e();
}

function function_e5d214c66b6e0082(alias) {
  soundname = tolower(alias);

  if(soundexists(soundname)) {
    if(!isDefined(self.var_20fab39312c88648)) {
      self.var_20fab39312c88648 = 0;
    }

    if(self.var_20fab39312c88648 - gettime() < 0) {
      soundlength = lookupsoundlength(soundname, 1);
      self.var_20fab39312c88648 = gettime() + soundlength;
      self playsoundtoplayer(soundname, self);
    }
  }
}

function private ftue_play(ref) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!namespace_493bf119b3b0c251::function_94b952789d039abb()) {
    return;
  }

  if(!isDefined(ref)) {
    return;
  }

  tip = hashcat(#"powerup_", ref);
  ftue_tip::function_9e0151baa208fe9e(tip);
  wait 10;
  params = {
    #duration: 10
  };
  ftue_tip::function_f339c5c73d11ea20(tip, 1, params);
}

function function_a5954aee8a02845e() {
  self notify("powerup_removed");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  wait 0.25;
  self freescriptable();
}

function function_de43cee7dc74dcd7(eventstring, points, victim) {
  if(!isPlayer(self) || scripts\mp\utility\player::isinlaststand(self)) {
    return;
  }

  scripts\mp\utility\points::doscoreevent(eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1);
}

function function_504645669cd3844f(value) {
  assert(isPlayer(self), "<dev string:x1cb>");
  self.point_scalar = value;
  scripts\mp\rank::addrankxpmultiplier(value, "br_poweurup");
}

function function_2f0136fd318f2b9e() {
  if(!isPlayer(self)) {
    return;
  }

  thread scripts\mp\utility\points::doscoreevent(#"br_powerup");
}

function function_eb64b9fa2d5352ee(powerup_name) {
  eventparams = [];
  eventparams[eventparams.size] = "powerup_name";
  eventparams[eventparams.size] = powerup_name;
  dlog_recordevent("dlog_event_br_powerup_collected", eventparams);
}

function function_cc7d2e0d5b5d6ad7(powerup_name, spawn_method) {
  eventparams = ["powerup_name", powerup_name, "spawn_method", spawn_method];
  dlog_recordevent("dlog_event_br_powerup_spawned", eventparams);
}

function debug_init() {
  devgui::function_6e7290c8ee4f558b("<dev string:x1fa>");
  devgui::function_a9a864379a098ad6("<dev string:x210>", "<dev string:x228>", &function_8d84a74b56d3e373);
  devgui::function_a9a864379a098ad6("<dev string:x24f>", "<dev string:x262>", &function_517f474edb3d3972);
  devgui::function_fe953f000498048f();
}

function function_8d84a74b56d3e373() {
  origin = level.player.origin + (0, 0, 500);
  info = powerups::function_519d44e54a9b8ae5("<dev string:x285>");
  scriptable_name = info.scriptable;
  ent = spawn("<dev string:x296>", origin);
  ent setModel("<dev string:x2a6>");
  powerup = spawnscriptable(scriptable_name, origin, (0, 0, 0));
  powerup setscriptablepartstate("<dev string:x2b4>", "<dev string:x2bf>");
  powerup utility::scriptable_setparententity(ent, (0, 0, 0), (0, 0, 0));
  ent thread function_f3d67f6efe03526b();
  ent = spawn("<dev string:x296>", origin);
  ent setModel("<dev string:x2a6>");
  powerup = spawnscriptable(scriptable_name, origin, (0, 0, 0));
  powerup setscriptablepartstate("<dev string:x2b4>", "<dev string:x2bf>");
  powerup utility::scriptable_setparententity(ent, (0, 0, 0), (0, 0, 0));
  ent thread function_f52df32abe0fc9ea();
  ent = spawn("<dev string:x296>", origin);
  ent setModel("<dev string:x2a6>");
  powerup = spawnscriptable(scriptable_name, origin, (0, 0, 0));
  powerup setscriptablepartstate("<dev string:x2b4>", "<dev string:x2bf>");
  powerup utility::scriptable_setparententity(ent, (0, 100, 0), (0, 0, 0));
  ent thread function_f52df42abe0fcc1d();
}

function function_f3d67f6efe03526b() {
  origin = self.origin;

  while(true) {
    newpos = origin;
    newpos += (0, 250, 0) * sin(gettime() * 0.05);
    newpos += (250, 0, 0) * cos(gettime() * 0.05);
    self.origin = newpos;
    waitframe();
  }
}

function function_f52df32abe0fc9ea() {
  origin = self.origin;

  while(true) {
    self moveTo(origin + (0, 0, -500), 3);
    wait 3;
    self moveTo(origin, 3);
    wait 3;
  }
}

function function_f52df42abe0fcc1d() {
  while(true) {
    self rotateby((0, 180, 0), 5);
    wait 5;
  }
}

function function_517f474edb3d3972() {
  if(!getdvarint(@ "hash_340406f5e0972920")) {
    function_16ba5e09063f2292();
    return;
  }

  function_3b22b1d8bd000324();
}

function function_16ba5e09063f2292() {
  setDvar(@ "hash_340406f5e0972920", 1);
  iprintlnbold("<dev string:x2c8>");
}

function function_3b22b1d8bd000324() {
  setDvar(@ "hash_340406f5e0972920", 0);
  iprintlnbold("<dev string:x2e6>");
  level notify("<dev string:x305>");
}

function function_a0bd8c322e7661ce(v_pos, str_print, str_color, i_row) {
  debug::debug_print3d(v_pos, str_print, str_color, undefined, "<dev string:x305>", undefined, 1, 0.15, 35 - 2 * i_row);
}

# /