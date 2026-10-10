/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\powerups\powerups.gsc
**************************************************/

#using script_72ef6b9f0cf1f55a;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#namespace powerups;

function init(var_cc680f1d779ccc51, var_40708f9ae5a8070e, var_42ae0bca056bb628) {
  init_powerups(&function_1bc17f51290823ab);
  root = function_ecdae672c660149e();
  root.var_cc680f1d779ccc51 = var_cc680f1d779ccc51;
  root.var_40708f9ae5a8070e = var_40708f9ae5a8070e;
  root.var_b0d3396c2b9e78d4 = &function_cad183d7f2f4f301;
  root.var_5a4c4a84060b59da = &function_5bfe254c7e9aa4db;
  root.var_5cdeaceda00983a3 = &function_f91870701cdc3aaa;
  utility::registersharedfunc("powerups", "showPowerupHud", &function_676437737684783f);
  init_fx();

  if(!istrue(var_42ae0bca056bb628)) {
    scripts\common\powerups::function_8ca4b49ee68720bf("on_zombie_ai_killed");
  }
}

function private init_fx() {
  level._effect["powerup_intro"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_powerup_spawn_in_green.vfx");
  level._effect["powerup_on"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_powerup_glow_green.vfx");
  level._effect["powerup_grabbed"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_powerup_glow_green_grab.vfx");
}

function private function_1bc17f51290823ab() {
  callback::add("player_laststand", &function_23cb67253c852e2a);
}

function private function_f91870701cdc3aaa() {
  player = undefined;
  activator_ent = self;

  if(isPlayer(activator_ent)) {
    player = activator_ent;
  }

  if(activator_ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(isDefined(activator_ent.owner) && isPlayer(activator_ent.owner)) {
      player = activator_ent.owner;
    }
  }

  return player;
}

function private function_cad183d7f2f4f301(hud_powerup, lifetime) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("powerup_hud_show_" + hud_powerup.str_powerup);
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(hud_powerup) || !isDefined(lifetime)) {
    return;
  }

  reveal_timer(hud_powerup, lifetime);
  var_eaffb8d26a6d3161 = 10;
  var_b6f5fb735ca50f7b = 5;
  var_905bfa0b020bf718 = max(0, lifetime - var_eaffb8d26a6d3161);
  var_ee6b5d9d51067ae3 = max(0, lifetime - var_905bfa0b020bf718 - var_b6f5fb735ca50f7b);
  end_wait = min(var_b6f5fb735ca50f7b, lifetime);
  wait var_905bfa0b020bf718;
  function_d28fa5295a04d555("hud_powerup_" + hud_powerup.str_powerup, "blink");
  wait var_ee6b5d9d51067ae3;
  function_d28fa5295a04d555("hud_powerup_" + hud_powerup.str_powerup, "blinkfast");
  wait end_wait;
}

function private function_5bfe254c7e9aa4db(str_powerup) {
  if(!isPlayer(self)) {
    return;
  }

  waitframe();

  if(!isalive(self)) {
    return;
  }

  refname = "hud_powerup_" + str_powerup;

  if(istrue(function_ada0825249682644(refname))) {
    function_fb3c9a259f146781(refname);
  }

  thread function_9717dc981f38ff6c();
}

function private reveal_timer(hud_powerup, n_lifetime) {
  show_timer(hud_powerup, n_lifetime, 1);
  thread function_9717dc981f38ff6c();
}

function function_676437737684783f(powerupref, n_lifetime) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  root = function_ecdae672c660149e();

  if(istrue(root.show_splash)) {
    thread function_c0d098ef786b87f6(powerupref, n_lifetime);
  }

  if(isDefined(n_lifetime) && n_lifetime > 0) {
    hud_powerup = function_587ecc90909a8c38(powerupref);
    init_timer(hud_powerup, n_lifetime);

    if(istrue(root.show_splash)) {
      waitdur = 3;
      msg = waittill_notify_or_timeout_return("powerup_hud_show_" + powerupref, waitdur);

      if(msg == "timeout") {
        powerup_hud_show(powerupref, n_lifetime - waitdur);
      }

      return;
    }

    powerup_hud_show(powerupref, n_lifetime);
  }
}

function private function_c0d098ef786b87f6(powerupref, n_lifetime) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  root = function_ecdae672c660149e();
  powerupid = root.var_eaf13acb539829eb[powerupref];

  for(i = 0; i < powerupid; i++) {
    waitframe();
  }

  self setclientomnvar("ui_powerup_splash", powerupid);
  self setclientomnvar("ui_powerup_splash_notify", gettime());
}

function private hide_timer(str_powerup, var_86b2c10e3c5de35e, var_72e0ea8e48ab3921) {
  assert(isPlayer(self));

  if(function_dd6c086a7d5e3b85() && !istrue(var_72e0ea8e48ab3921)) {
    return;
  }

  self endon("death_or_disconnect");
  level endon("game_ended");
  refname = "hud_powerup_" + str_powerup;
  player = self;
  isactive = player function_ada0825249682644(refname);

  if(!istrue(isactive)) {
    return;
  }

  player function_d28fa5295a04d555(refname, "hide");

  if(isDefined(var_86b2c10e3c5de35e) && var_86b2c10e3c5de35e > 0) {
    wait var_86b2c10e3c5de35e;
  }
}

function private show_timer(hud_powerup, n_lifetime, b_init, var_9f6f493675057d64) {
  assert(isPlayer(self));

  if(function_dd6c086a7d5e3b85()) {
    return;
  }

  self endon("death_or_disconnect");
  root = function_ecdae672c660149e();
  poweruplist = function_e6f547b7f0a996ed();
  assertex(isDefined(root.var_eaf13acb539829eb[hud_powerup.str_powerup]), "<dev string:x1c>" + hud_powerup.str_powerup + "<dev string:x31>");
  var_e66f8bc0f155720f = poweruplist.var_5a95e049dbbdc1ec;

  if(!isDefined(var_e66f8bc0f155720f) || var_e66f8bc0f155720f == "") {
    return;
  }

  player = self;
  index = hud_powerup.index;
  refname = "hud_powerup_" + hud_powerup.str_powerup;
  state = default_to(poweruplist.var_fec1fa2e735d7499, "");
  var_8d076e93bc8ccd99 = [];
  var_8d076e93bc8ccd99["bundle_index"] = root.var_eaf13acb539829eb[hud_powerup.str_powerup];
  var_8d076e93bc8ccd99["time"] = n_lifetime;
  isactive = player function_ada0825249682644(refname);

  if(!isactive) {
    init_timer(hud_powerup, n_lifetime, b_init, var_9f6f493675057d64);
    player function_d28fa5295a04d555(refname, state);
  } else {
    player function_d28fa5295a04d555(refname, "Show");
  }

  if(!istrue(var_9f6f493675057d64)) {
    player function_14a0ee2aaf9128c3(refname, var_8d076e93bc8ccd99, 0);
  }
}

function private init_timer(hud_powerup, n_lifetime, b_init, var_9f6f493675057d64) {
  assert(isPlayer(self));

  if(function_dd6c086a7d5e3b85()) {
    return;
  }

  self endon("death_or_disconnect");
  root = function_ecdae672c660149e();
  poweruplist = function_e6f547b7f0a996ed();
  assertex(isDefined(root.var_eaf13acb539829eb[hud_powerup.str_powerup]), "<dev string:x1c>" + hud_powerup.str_powerup + "<dev string:x31>");
  var_e66f8bc0f155720f = poweruplist.var_5a95e049dbbdc1ec;

  if(!isDefined(var_e66f8bc0f155720f) || var_e66f8bc0f155720f == "") {
    return;
  }

  player = self;
  index = hud_powerup.index;
  refname = "hud_powerup_" + hud_powerup.str_powerup;
  state = "Hide";
  var_8d076e93bc8ccd99 = [];
  var_8d076e93bc8ccd99["bundle_index"] = root.var_eaf13acb539829eb[hud_powerup.str_powerup];
  var_8d076e93bc8ccd99["time"] = n_lifetime;
  isactive = player function_ada0825249682644(refname);

  if(!isactive) {
    player function_90de31b2cbef19f9(refname, var_e66f8bc0f155720f);
    player function_d28fa5295a04d555(refname, state);
    player function_14a0ee2aaf9128c3(refname, var_8d076e93bc8ccd99, 0);

    if(!istrue(b_init)) {
      player thread function_9717dc981f38ff6c(hud_powerup.str_powerup);
    }
  }

  if(!istrue(var_9f6f493675057d64)) {
    player function_14a0ee2aaf9128c3(refname, var_8d076e93bc8ccd99, 0);
  }
}

function private function_9717dc981f38ff6c(str_powerup) {
  poweruplist = function_e6f547b7f0a996ed();
  anchorhorz = function_f845164fd6027e79(poweruplist.var_99a990e9f5ea961c);
  var_949530d3a6b789b3 = function_863b22a1564f8eb(poweruplist.var_40a95d7bb8872fa2);
  anchorx = default_to(poweruplist.var_fde517927a257ba7, 0);
  anchory = default_to(poweruplist.var_fde516927a257974, 0);
  stepx = default_to(poweruplist.var_3a83b92e9fcd024a, 0);
  stepy = default_to(poweruplist.var_3a83ba2e9fcd047d, 0);
  var_9445ccda1f06a14e = self.var_a0e1c0f50ca3ef0f;
  var_1df4c15ca0d10bca = float(var_9445ccda1f06a14e.size - 1) * 0.5;
  var_613803e654807723 = [];

  foreach(hp in var_9445ccda1f06a14e) {
    var_613803e654807723[var_613803e654807723.size] = hp;
  }

  foreach(i, hp in var_613803e654807723) {
    if(isDefined(str_powerup) && hp != str_powerup) {
      continue;
    }

    refname = "hud_powerup_" + hp;

    if(!istrue(function_ada0825249682644(refname))) {
      continue;
    }

    posx = (i - var_1df4c15ca0d10bca) * stepx + anchorx;
    posy = anchory + i * stepy;
    function_f4c37324750dc183(refname, posx, posy, anchorhorz, var_949530d3a6b789b3);
  }
}

function private function_dd6c086a7d5e3b85() {
  return istrue(self.inlaststand);
}

function private function_23cb67253c852e2a(params) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();

  if(isalive(self)) {
    root = function_ecdae672c660149e();

    foreach(ref, powerup in root.powerups) {
      thread hide_timer(ref, 0, 1);
    }
  }
}

function function_96e1cf53bdd43f1c(params) {
  if(!level flag("drop_powerups")) {
    return false;
  }

  if(!isPlayer(params.eattacker)) {
    return false;
  }

  root = function_ecdae672c660149e();

  if(istrue(root.no_powerups) || isDefined(params.weapon) && istrue(params.weapon.isheroweapon)) {
    return false;
  }

  if(istrue(root.use_powerup_volumes)) {
    volumes = getEntArray("no_powerups", "targetname");

    foreach(volume in volumes) {
      if(ispointinvolume(params.origin, volume)) {
        return false;
      }
    }
  }

  if(!ispointonnavmesh(params.origin)) {
    return false;
  }

  return true;
}