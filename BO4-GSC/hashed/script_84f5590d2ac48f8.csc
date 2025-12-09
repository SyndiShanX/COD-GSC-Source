/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_84f5590d2ac48f8.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace full_screen_movie;

class cfull_screen_movie: cluielem {
  function function_7d4e5f11(localclientnum, value) {
    set_data(localclientnum, "skippable", value);
  }

  function set_playoutromovie(localclientnum, value) {
    set_data(localclientnum, "playOutroMovie", value);
  }

  function set_additive(localclientnum, value) {
    set_data(localclientnum, "additive", value);
  }

  function set_looping(localclientnum, value) {
    set_data(localclientnum, "looping", value);
  }

  function set_showblackscreen(localclientnum, value) {
    set_data(localclientnum, "showBlackScreen", value);
  }

  function set_moviename(localclientnum, value) {
    set_data(localclientnum, "movieName", value);
  }

  function open(localclientnum) {
    cluielem::open(localclientnum, # "full_screen_movie");
  }

  function function_cf9c4603(localclientnum) {
    cluielem::function_cf9c4603(localclientnum);
    set_data(localclientnum, "movieName", # "");
    set_data(localclientnum, "showBlackScreen", 0);
    set_data(localclientnum, "looping", 0);
    set_data(localclientnum, "additive", 0);
    set_data(localclientnum, "playOutroMovie", 0);
    set_data(localclientnum, "skippable", 0);
  }

  function register_clientside(uid) {
    cluielem::register_clientside(uid);
  }

  function setup_clientfields(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d) {
    cluielem::setup_clientfields(uid);
    cluielem::function_52818084("moviefile", "movieName", 1);
    cluielem::add_clientfield("showBlackScreen", 1, 1, "int", var_a22272e);
    cluielem::add_clientfield("looping", 1, 1, "int", var_5b706c2c);
    cluielem::add_clientfield("additive", 1, 1, "int", var_e7e7a9a4);
    cluielem::add_clientfield("playOutroMovie", 1, 1, "int", var_f332688d);
    cluielem::add_clientfield("skippable", 1, 1, "int", var_c1b0ac4d);
  }

}

register(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d) {
  elem = new cfull_screen_movie();
  [[elem]] - > setup_clientfields(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d);
  return elem;
}

register_clientside(uid) {
  elem = new cfull_screen_movie();
  [[elem]] - > register_clientside(uid);
  return elem;
}

open(player) {
  [[self]] - > open(player);
}

close(player) {
  [[self]] - > close(player);
}

is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

set_moviename(localclientnum, value) {
  [[self]] - > set_moviename(localclientnum, value);
}

set_showblackscreen(localclientnum, value) {
  [[self]] - > set_showblackscreen(localclientnum, value);
}

set_looping(localclientnum, value) {
  [[self]] - > set_looping(localclientnum, value);
}

set_additive(localclientnum, value) {
  [[self]] - > set_additive(localclientnum, value);
}

set_playoutromovie(localclientnum, value) {
  [[self]] - > set_playoutromovie(localclientnum, value);
}

function_7d4e5f11(localclientnum, value) {
  [[self]] - > function_7d4e5f11(localclientnum, value);
}