/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_742a29771db74d6f.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace zm_arcade_timer;

class czm_arcade_timer: cluielem {
  var var_57a3d576;

  function set_title(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "title", value);
  }

  function set_minutes(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "minutes", value);
  }

  function set_seconds(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "seconds", value);
  }

  function set_showzero(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "showzero", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "zm_arcade_timer", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("showzero", 1, 1, "int");
    cluielem::add_clientfield("seconds", 1, 6, "int");
    cluielem::add_clientfield("minutes", 1, 4, "int");
    cluielem::function_52818084("string", "title", 1);
  }

}

set_timer(player, var_348e23ad, var_ef67aac3) {
  self open_timer(player);
  n_minutes = int(floor(var_348e23ad / 60));
  n_seconds = int(var_348e23ad - n_minutes * 60);
  self set_minutes(player, n_minutes);
  self set_seconds(player, n_seconds);
  if(n_seconds < 10) {
    self set_showzero(player, 1);
  } else {
    self set_showzero(player, 0);
  }
  if(isDefined(var_ef67aac3)) {
    self set_title(player, var_ef67aac3);
  }
}

function_a9f676cf(str_notify) {
  foreach(player in level.players) {
    if(isDefined(level.var_49197edc) && level.var_49197edc is_open(player)) {
      level.var_49197edc close(player);
    }
  }
}

function_49fb9a81(player, var_348e23ad, var_ef67aac3, var_2de72807 = 0) {
  player endon(#"disconnect", # "hash_660dedc4af5b4336");
  level endoncallback( & function_a9f676cf, # "end_game");
  if(!var_2de72807) {
    player endoncallback( & function_1c9127dd, # "hash_2a4a6c3c411261d8");
  }
  self function_4ba8fb9c(player);
  if(var_2de72807 || !isDefined(player.var_8f5fe43e)) {
    player.var_8f5fe43e = var_ef67aac3;
  }
  while(var_348e23ad >= 0) {
    if(player.var_8f5fe43e === var_ef67aac3) {
      self set_timer(player, var_348e23ad, var_ef67aac3);
    }
    wait 1;
    var_348e23ad--;
    if(!isDefined(player.var_8f5fe43e)) {
      player.var_8f5fe43e = var_ef67aac3;
    }
  }
  if(player.var_8f5fe43e === var_ef67aac3) {
    player.var_8f5fe43e = undefined;
  }
  self function_7ccee86d(player, 0, var_ef67aac3);
}

function_1c9127dd(str_notify) {
  if(!isDefined(self.var_dcdf21b8)) {
    self.var_dcdf21b8 = 0;
  }
  if(self.var_dcdf21b8 > 0) {
    self.var_dcdf21b8--;
  }
}

function_4ba8fb9c(player) {
  if(!isDefined(player.var_dcdf21b8)) {
    player.var_dcdf21b8 = 0;
  }
  player.var_dcdf21b8++;
  self open_timer(player);
}

open_timer(player) {
  if(!self is_open(player)) {
    self open(player, 1);
  }
}

function_7ccee86d(player, b_force_close = 0, var_ef67aac3) {
  if(!isDefined(player.var_dcdf21b8)) {
    player.var_dcdf21b8 = 0;
  }
  player.var_dcdf21b8--;
  if(player.var_8f5fe43e === var_ef67aac3) {
    player.var_8f5fe43e = undefined;
  }
  if(self is_open(player) && (player.var_dcdf21b8 <= 0 || b_force_close)) {
    player.var_dcdf21b8 = 0;
    self close(player);
    player notify(#"hash_2a4a6c3c411261d8");
    player.var_8f5fe43e = undefined;
    if(b_force_close) {
      player notify(#"hash_660dedc4af5b4336");
    }
  }
}

register(uid) {
  elem = new czm_arcade_timer();
  [[elem]] - > setup_clientfields(uid);
  return elem;
}

open(player, persistent = 0) {
  [[self]] - > open(player, persistent);
}

close(player) {
  [[self]] - > close(player);
}

is_open(player) {
  return [[self]] - > function_76692f88(player);
}

set_showzero(player, value) {
  [[self]] - > set_showzero(player, value);
}

set_seconds(player, value) {
  [[self]] - > set_seconds(player, value);
}

set_minutes(player, value) {
  [[self]] - > set_minutes(player, value);
}

set_title(player, value) {
  [[self]] - > set_title(player, value);
}