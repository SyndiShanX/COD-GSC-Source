/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock.gsc
***********************************************/

#include script_71e26f08f03b7a7a;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_world_fixup;

#namespace character_unlock;

autoexec __init__system__() {
  system::register(#"character_unlock", &__init__, undefined, #"character_unlock_fixup");
}

__init__() {
  level.var_b3681acb = isDefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 1;
  callback::on_item_pickup(&function_6e8037ca);
  callback::add_callback(#"on_drop_inventory", &on_drop_inventory);
  callback::add_callback(#"on_end_game", &on_end_game);
  callback::on_disconnect(&on_player_disconnect);
}

function_b3681acb() {

  if(getdvar(#"scr_debug_character_unlocks", 0) == 1) {
    return true;
  }

    return level.var_b3681acb && isDefined(level.onlinegame) && level.onlinegame && isDefined(level.rankedmatch) && level.rankedmatch;
}

function_d89ef6af(unlock_name) {
  switch (unlock_name) {
    case #"hash_178221dd8299137b":
      return true;
    case #"hash_8c7045e78561cf4":
      return true;
    case #"hash_3532d912b12917c9":
      return true;
    case #"hash_517bb26004a9c12b":
      return true;
    case #"hash_263de5e9fa6d16ea":
      return true;
    case #"hash_74709eb5a08139fb":
      return true;
  }

  return false;
}

function_d7e6fa92(unlock_name) {
  var_9ba1646c = level.var_7d8da246[unlock_name];
  assert(isDefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x50>");

  if(!isDefined(var_9ba1646c)) {
    return false;
  }

  var_2b469a7d = var_9ba1646c.var_2b469a7d;

  if(function_d89ef6af(unlock_name)) {
    if(isDefined(stats::get_stat(#"unlockedtags", var_2b469a7d)) && stats::get_stat(#"unlockedtags", var_2b469a7d)) {
      return true;
    }

    return false;
  }

  if(isDefined(stats::get_stat(#"characters", var_2b469a7d, #"unlocked")) && stats::get_stat(#"characters", var_2b469a7d, #"unlocked")) {
    return true;
  }

  return false;
}

function_f0406288(unlock_name) {
  if(!level function_b3681acb()) {
    return false;
  }

  if(self function_d7e6fa92(unlock_name)) {
    return false;
  }

  if(isDefined(self.var_474dff5e) && isDefined(self.var_474dff5e[unlock_name]) && self.var_474dff5e[unlock_name]) {
    return true;
  }

  var_9ba1646c = level.var_7d8da246[unlock_name];
  item_name = var_9ba1646c.required_item;
  required_item = self item_inventory::function_7fe4ce88(item_name);

  if(isDefined(required_item)) {
    return true;
  }

  return false;
}

function_c70bcc7a(unlock_name) {
  if(!level function_b3681acb()) {
    return false;
  }

  if(self function_d7e6fa92(unlock_name)) {
    return false;
  }

  if(!isDefined(self.var_c53589da) || !isDefined(self.var_c53589da[unlock_name])) {
    return false;
  }

  return true;
}

function_6e8037ca(params) {
  if(!level function_b3681acb()) {
    return;
  }

  if(level.inprematchperiod) {
    return;
  }

  itementry = params.item.itementry;

  if(!isDefined(itementry)) {
    return;
  }

  if(!isDefined(itementry.unlockableitemref)) {
    return;
  }

  foreach(unlock_name, var_9ba1646c in level.var_7d8da246) {
    if(self function_d7e6fa92(unlock_name)) {
      itembundle = getscriptbundle(var_9ba1646c.required_item);

      if(!isDefined(itembundle) || !isDefined(itembundle.unlockableitemref)) {
        continue;
      }

      itemindex = getitemindexfromref(itembundle.unlockableitemref);

      if(itemindex == 0) {
        continue;
      }

      self luinotifyevent(#"character_unlock_update", 2, 1, itemindex);
      continue;
    }

    item_name = var_9ba1646c.required_item;

    if(itementry.name === item_name) {
      if(!isDefined(self.var_c53589da)) {
        self.var_c53589da = [];
      }

      if(!isDefined(self.var_c53589da[unlock_name])) {
        var_c5c8fd39 = {
          #var_e7e238a4: []
        };

        foreach(condition in var_9ba1646c.var_3845495) {
          var_c5c8fd39.var_e7e238a4[condition] = 0;
        }

        self.var_c53589da[unlock_name] = var_c5c8fd39;
      }

      break;
    }
  }

  self callback::callback(#"hash_48bcdfea6f43fecb", params.item);
}

function_c8beca5e(unlock_name, var_1d208aea, state) {
  if(!level function_b3681acb()) {
    return;
  }

  if(level.inprematchperiod) {
    return;
  }

  var_9ba1646c = level.var_7d8da246[unlock_name];

  assert(isDefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x50>");
  assert(isinarray(var_9ba1646c.var_3845495, var_1d208aea), "<dev string:x61>" + function_9e72a96(var_1d208aea) + "<dev string:x73>" + function_9e72a96(unlock_name));
  assert(isinarray(array(0, 1, 2), state), "<dev string:x90>" + function_9e72a96(var_1d208aea) + "<dev string:xc4>" + function_9e72a96(unlock_name));

    if(!self function_c70bcc7a(unlock_name)) {
      assertmsg("<dev string:xd3>" + unlock_name + "<dev string:x103>");
      return;
    }

  current_state = self.var_c53589da[unlock_name].var_e7e238a4[var_1d208aea];

  if(current_state == 2) {
    return;
  }

  self.var_c53589da[unlock_name].var_e7e238a4[var_1d208aea] = state;
  self function_20b0ca2e(unlock_name);

  if(var_1d208aea != #"hash_3f07579f66b464e8") {
    if(!isalive(self) || isDefined(level.gameended) && level.gameended) {
      self function_fb689837();
    }
  }
}

function_20b0ca2e(unlock_name) {
  var_9ba1646c = level.var_7d8da246[unlock_name];
  assert(isDefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x50>");
  itembundle = getscriptbundle(var_9ba1646c.required_item);

  if(!isDefined(itembundle.unlockableitemref)) {
    return;
  }

  itemindex = getitemindexfromref(itembundle.unlockableitemref);

  if(itemindex == 0) {
    return;
  }

  var_93e871fc = var_9ba1646c.var_3845495;

  switch (var_9ba1646c.var_3845495.size) {
    case 1:
      self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]]);
      break;
    case 2:
      self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]]);
      break;
    case 3:
      self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]]);
      break;
    case 4:
      self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[3]]);
      break;
    case 5:
      self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[3]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[4]]);
      break;
    default:
      break;
  }
}

function_54fc60f5(player, character) {
  if(isDefined(player) && isplayer(player) && isDefined(character)) {
    player_xuid = player getxuid(1);

    if(isDefined(player_xuid)) {
      data = {
        #game_time: function_f8d53445(), 
        #player_xuid: int(player_xuid), 
        #character: character
      };
      function_92d1707f(#"hash_17e83c78e2a73ed1", data);
    }
  }
}

function_fb689837() {
  if(!isDefined(self.var_c53589da)) {
    return;
  }

  foreach(unlock_name, var_c5c8fd39 in self.var_c53589da) {
    if(!self function_f0406288(unlock_name)) {
      continue;
    }

    var_b3895a2 = 1;

    foreach(var_1d208aea, var_b7ed23ab in var_c5c8fd39.var_e7e238a4) {
      if(var_1d208aea != #"hash_3f07579f66b464e8" && var_b7ed23ab != 1) {
        var_b3895a2 = 0;
        break;
      }
    }

    if(!var_b3895a2) {
      continue;
    }

    self function_c8beca5e(unlock_name, #"hash_3f07579f66b464e8", 1);
    var_9ba1646c = level.var_7d8da246[unlock_name];

    if(isDefined(var_9ba1646c)) {
      var_2b469a7d = var_9ba1646c.var_2b469a7d;
    }

    if(isDefined(var_2b469a7d)) {
      if(function_d89ef6af(unlock_name)) {
        self stats::set_stat(#"unlockedtags", var_2b469a7d, 1);
      } else {
        self stats::set_stat(#"characters", var_2b469a7d, #"unlocked", 1);
        self stats::function_d40764f3(#"character_quests_completed", 1);
      }

      function_54fc60f5(self, var_2b469a7d);
      var_ade8d0e9 = {
        #character: var_2b469a7d
      };
      self callback::callback(#"on_character_unlock", var_ade8d0e9);
    }
  }
}

on_drop_inventory(player) {
  if(!isplayer(player)) {
    return;
  }

  if(!isDefined(player.var_474dff5e)) {
    player.var_474dff5e = [];
  }

  foreach(unlock_name, var_9ba1646c in level.var_7d8da246) {
    item_name = var_9ba1646c.required_item;
    required_item = player item_inventory::function_7fe4ce88(item_name);

    if(isDefined(required_item)) {
      player.var_474dff5e[unlock_name] = 1;
    }
  }

  if(!isalive(player)) {
    player function_fb689837();
  }
}

on_player_disconnect() {
  if(!isplayer(self)) {
    return;
  }

  self function_fb689837();
}

on_end_game() {
  players = getplayers();

  foreach(player in players) {
    player function_fb689837();
  }
}

function_d2294476(var_2ab9d3bd, replacementcount, var_3afaa57b) {
  if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
    replacementcount = 1;
  }

  namespace_3d2704b3::function_f0297225(var_2ab9d3bd, replacementcount, var_3afaa57b);
}