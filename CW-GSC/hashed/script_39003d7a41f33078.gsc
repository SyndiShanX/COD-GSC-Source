/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_39003d7a41f33078.gsc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\map;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_98521e8b;

function event_handler[level_init] function_9347830c(eventstruct) {
  clientfield::register("world", "" + # "hash_6789a69336880f89", 10000, 1, "int");
  var_b3160934 = function_1ead85cd();

  if(isDefined(var_b3160934)) {
    level.var_98c11047 = 1;
  }
}

function function_3143d817() {
  mapbundle = map::get_script_bundle();

  if(!isDefined(mapbundle.var_6bb20a3)) {
    return undefined;
  }

  return getscriptbundle(mapbundle.var_6bb20a3);
}

function function_f7961c39() {}

function function_d6b2318a() {
  var_4680e491 = function_3143d817();
  var_b3160934 = function_1ead85cd();

  if(!isDefined(var_b3160934)) {
    return;
  }

  level util::function_f6847a11();
  level clientfield::set("" + # "hash_6789a69336880f89", 1);

  if(isDefined(level.var_ecb89926)) {
    var_abb4b791 = getentitiesinradius(level.var_ecb89926, 1000, 12);
    var_abb4b791 = arraycombine(var_abb4b791, getentitiesinradius(level.var_ecb89926, 1000, 14), 0, 0);
    array::run_all(var_abb4b791, &hide);
  }

  var_46fa8f90 = isDefined(var_4680e491.blackscreentime) ? var_4680e491.blackscreentime : 0;
  var_c418a170 = isDefined(var_4680e491.var_73a4076) ? var_4680e491.var_73a4076 : 0;
  level lui::screen_fade_out(0);

  if(isarray(level.var_3eada96b) && level.var_3eada96b.size) {
    foreach(var_35762664 in level.var_3eada96b) {
      var_35762664 show();
      var_35762664 solid();
      var_35762664 sethighdetail(1);
    }
  }

  wait var_46fa8f90;
  level thread util::delay(float(function_60d95f53()) / 1000, undefined, &lui::screen_fade_in, var_c418a170);

  if(isarray(level.var_3eada96b) && level.var_3eada96b.size) {
    foreach(var_35762664 in level.var_3eada96b) {
      var_35762664 show();
      var_35762664 solid();
    }

    level.var_c30e610f = 1;
    level thread function_9cc2688d(var_b3160934);
    level scene::play(var_b3160934, level.var_3eada96b);
  }

  level clientfield::set("" + # "hash_6789a69336880f89", 0);
}

function function_9cc2688d(str_scene) {
  var_9d90ef8b = scene::function_12479eba(str_scene);
  n_delay = min(var_9d90ef8b, 3);
  wait n_delay;

  if(is_true(level.var_98c11047)) {
    util::preload_frontend();
  }
}

function function_364bc19c(outcome) {
  level.var_3eada96b = [];
  var_b3160934 = function_1ead85cd();

  if(isDefined(var_b3160934)) {
    var_f4bbfe3d = struct::get(var_b3160934, "scriptbundlename");

    if(isDefined(var_f4bbfe3d.origin)) {
      level.var_ecb89926 = var_f4bbfe3d.origin;
    }
  }

  if(isDefined(outcome.team) && isinarray(getarraykeys(level.teams), hash(outcome.team))) {
    a_players = getplayers(outcome.team);
  } else {
    a_players = outcome.players;
  }

  if(isarray(a_players)) {
    if(outcome.var_c1e98979 === 9 && !a_players.size && getdvarint(#"hash_767fdbb79f0c1368", 1)) {
      if(!isDefined(a_players)) {
        a_players = [];
      } else if(!isarray(a_players)) {
        a_players = array(a_players);
      }

      if(!isinarray(a_players, getplayers()[0])) {
        a_players[a_players.size] = getplayers()[0];
      }

      if(!isDefined(a_players)) {
        a_players = [];
      } else if(!isarray(a_players)) {
        a_players = array(a_players);
      }

      if(!isinarray(a_players, getplayers()[1])) {
        a_players[a_players.size] = getplayers()[1];
      }

      if(!isDefined(a_players)) {
        a_players = [];
      } else if(!isarray(a_players)) {
        a_players = array(a_players);
      }

      if(!isinarray(a_players, getplayers()[2])) {
        a_players[a_players.size] = getplayers()[2];
      }

      if(!isDefined(a_players)) {
        a_players = [];
      } else if(!isarray(a_players)) {
        a_players = array(a_players);
      }

      if(!isinarray(a_players, getplayers()[3])) {
        a_players[a_players.size] = getplayers()[3];
      }

      arrayremovevalue(a_players, undefined);
    }

    foreach(n_index, player in a_players) {
      if(n_index >= 4) {
        break;
      }

      if(isDefined(player)) {
        var_bb497eb0 = util::spawn_player_clone(player, undefined, undefined, 1);
        var_bb497eb0 function_5a1fa1a2(player);

        if(isDefined(level.var_ecb89926)) {
          var_bb497eb0 dontinterpolate();
          var_bb497eb0.origin = level.var_ecb89926;
        }

        var_bb497eb0 sethighdetail(1);
        var_bb497eb0 ghost();
        var_bb497eb0 notsolid();
        var_bb497eb0.var_e7622b1 = player getentitynumber();

        if(!isDefined(level.var_3eada96b)) {
          level.var_3eada96b = [];
        } else if(!isarray(level.var_3eada96b)) {
          level.var_3eada96b = array(level.var_3eada96b);
        }

        level.var_3eada96b[level.var_3eada96b.size] = var_bb497eb0;
      }
    }
  }
}

function function_5a1fa1a2(player) {
  weapon = player getcurrentweapon();
  var_2506506a = weapon.rootweapon;

  if(isDefined(player.class_num)) {
    var_23624e62 = player getloadoutweapon(player.class_num, "primary");
    var_7bd31de8 = var_23624e62.rootweapon;
  } else {
    var_23624e62 = weapon;
    var_7bd31de8 = var_23624e62.rootweapon;
  }

  if(isarray(level.var_b6405fbf) && isinarray(level.var_b6405fbf, var_2506506a.name) || weapon == level.weaponnone || !weapon.isprimary) {
    if(var_23624e62 === weapon) {
      weapon = getweapon(#"ar_accurate_t9");
      self animation::attach_weapon(weapon);
    } else if(isarray(level.var_b6405fbf) && isinarray(level.var_b6405fbf, var_7bd31de8.name)) {
      weapon = getweapon(#"ar_accurate_t9");
      self animation::attach_weapon(weapon);
    } else {
      weapon = var_23624e62;
      var_d71dafc1 = player function_ade49959(weapon);
      var_f34a225e = player function_8cbd254d(weapon);
      var_c071948 = player function_f0655be3(weapon);
      self animation::attach_weapon(weapon);
      self function_44adade0(var_d71dafc1);
      self function_9affc544(var_f34a225e);
      self function_cda62355(var_c071948);
    }
  }

  self.weapon = weapon;
  self.var_777951c = weapon;
}

function function_29597300() {
  var_b3160934 = function_1ead85cd();

  if(isDefined(var_b3160934)) {
    level thread scene::init_streamer(var_b3160934, getplayers());
  }
}

function function_1ead85cd() {
  var_4680e491 = function_3143d817();

  if(isarray(var_4680e491.var_36569447) && var_4680e491.var_36569447.size) {
    str_gametype = util::get_game_type();

    foreach(var_bfb161c in var_4680e491.var_36569447) {
      if(isDefined(var_bfb161c.var_d74b6b9c) && var_bfb161c.var_c967fe7d === str_gametype) {
        return var_bfb161c.var_d74b6b9c;
      }
    }
  }

  return var_4680e491.var_d74b6b9c;
}