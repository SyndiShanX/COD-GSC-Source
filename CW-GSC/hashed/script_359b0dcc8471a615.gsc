/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_359b0dcc8471a615.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\util_shared;
#namespace namespace_7fe06af4;

function event_handler[gametype_init] init(eventstruct) {
  clientfield::register("world", "" + # "hash_5e7d02ead4a03f50", 1, 2, "int");
}

function event_handler[gametype_start] main(eventstruct) {
  level thread mannequin_init();

  level thread devgui_init();

  if(!function_a23c96ea()) {
    return;
  }

  callback::on_game_playing(&on_game_playing);
  level.mannequin_mode = 0;
  level.var_ecb7b947 = 0;
  level.destructible_callbacks[#"headless"] = &function_e0136874;
}

function mannequin_init() {
  mannequins = getEntArray("ee_mannequin", "script_noteworthy");
  var_ecf867b5 = getEntArray("ee_mannequin_clip", "targetname");
  var_1c94845d = [];
  mannequins = array::randomize(mannequins);
  var_8091ece = mannequins.size;

  if(var_8091ece > 28) {
    var_8091ece = 28;
  }

  setDvar(#"hash_21da43870d56a220", var_8091ece);

  foreach(i, mannequin in mannequins) {
    var_4c9b75d1 = arraygetclosest(mannequin.origin, var_ecf867b5);

    if(i < 28) {
      if(isDefined(var_4c9b75d1)) {
        var_4c9b75d1 disconnectpaths();
      }

      continue;
    }

    if(isDefined(var_4c9b75d1)) {
      var_4c9b75d1 delete();
    }

    if(!isDefined(var_1c94845d)) {
      var_1c94845d = [];
    } else if(!isarray(var_1c94845d)) {
      var_1c94845d = array(var_1c94845d);
    }

    var_1c94845d[var_1c94845d.size] = mannequin;
  }

  array::delete_all(var_1c94845d);

  if(getdvarint(#"hash_42a5a4b0b2854ca1", 0)) {
    foreach(mannequin in mannequins) {
      if(isDefined(mannequin)) {
        mannequin thread function_fa68a2e6();
      }
    }
  }
}

function on_game_playing() {
  level.mannequin_time = gettime();

  level thread function_9c9ba5();

  level thread function_ee18bf8f();
}

function function_e0136874(destructible_event, attacker, weapon, piece_index, point, dir, mod) {
  if(!isDefined(level.mannequin_time)) {
    return;
  }

  mannequin_timelimit = int(getdvarint(#"mannequin_timelimit", 120) * 1000);

  if(gettime() < level.mannequin_time + mannequin_timelimit || !mannequin_timelimit) {
    level.var_ecb7b947++;
    var_fa149ac8 = getdvarint(#"hash_21da43870d56a220", 28);

    if(level.var_ecb7b947 >= var_fa149ac8 && level.mannequin_mode == 0) {
      level.destructible_callbacks[#"headless"] = undefined;
      level thread mannequin_mode();
    }
  }
}

function mannequin_mode() {
  function_a150d07b(1);
}

function function_a150d07b(randomize = 0) {
  if(randomize) {
    state = randomintrange(1, 3);
    setDvar(#"hash_41e6a8d79082e88", state);
  }

  if(!isDefined(state)) {
    state = getdvarint(#"hash_41e6a8d79082e88", 0);
  }

  if(level.var_ffae3a51 === state) {
    return;
  }

  level.var_ffae3a51 = state;

  if(state != 0) {
    level.var_97902f80 = 1;
    music::setmusicstate("ee_oneshot", undefined, 3);
  } else {
    music::setmusicstate("");
    level.var_97902f80 = 0;
  }

  level clientfield::set("" + # "hash_5e7d02ead4a03f50", state);
}

function function_a23c96ea() {
  if(getdvarint(#"nuketown_mannequin", 0)) {
    return true;
  }

  if(sessionmodeisonlinegame() && !sessionmodeisprivateonlinegame()) {
    return false;
  }

  return true;
}

function devgui_init() {
  waitframe(1);
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x83>" + mapname + "<dev string:x95>");
  adddebugcommand("<dev string:xc5>" + mapname + "<dev string:xd6>");
}

function function_9c9ba5() {
  level endon(#"game_ended");

  while(true) {
    wait 0.5;
    function_a150d07b();
  }
}

function function_ee18bf8f() {
  level endon(#"game_ended");

  while(true) {
    wait 0.5;
    state = getdvarint(#"hash_4c0f0935eafdfaa", 0);

    if(state || state === 2) {
      mannequin_mode();
      setDvar(#"hash_4c0f0935eafdfaa", 0);
    }
  }
}

function function_fa68a2e6() {
  self endon(#"death", #"headless");

  while(true) {
    sphere(self.origin, 16, (0, 1, 0));
    waitframe(1);
  }
}