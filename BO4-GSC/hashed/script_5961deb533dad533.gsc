/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_5961deb533dad533.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace luielembar;

class cluielembar: cluielem {
  var var_57a3d576;

  function set_bar_percent(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "bar_percent", value);
  }

  function set_blue(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
  }

  function set_green(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "green", value);
  }

  function set_red(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "red", value);
  }

  function set_alpha(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "alpha", value);
  }

  function set_fadeovertime(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
  }

  function set_height(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "height", value);
  }

  function set_width(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "width", value);
  }

  function set_y(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "y", value);
  }

  function set_x(player, value) {
    player clientfield::function_8fe7322a(var_57a3d576, "x", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function open(player, persistent = 0) {
    cluielem::open_luielem(player, "LUIelemBar", persistent);
  }

  function setup_clientfields(uid) {
    cluielem::setup_clientfields(uid);
    cluielem::add_clientfield("x", 1, 7, "int");
    cluielem::add_clientfield("y", 1, 6, "int");
    cluielem::add_clientfield("width", 1, 6, "int");
    cluielem::add_clientfield("height", 1, 6, "int");
    cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
    cluielem::add_clientfield("alpha", 1, 4, "float");
    cluielem::add_clientfield("red", 1, 4, "float");
    cluielem::add_clientfield("green", 1, 4, "float");
    cluielem::add_clientfield("blue", 1, 4, "float");
    cluielem::add_clientfield("bar_percent", 1, 6, "float");
  }

}

set_color(player, red, green, blue) {
  self set_red(player, red);
  self set_green(player, green);
  self set_blue(player, blue);
}

fade(player, var_b43a1f03, duration = 0) {
  self set_alpha(player, var_b43a1f03);
  self set_fadeovertime(player, int(duration * 10));
}

show(player, duration = 0) {
  self fade(player, 1, duration);
}

hide(player, duration = 0) {
  self fade(player, 0, duration);
}

function_9afa3156(player, var_5c38c80f) {
  self set_x(player, int(var_5c38c80f / 15));
}

function_56b41599(player, var_36364da6) {
  self set_y(player, int(var_36364da6 / 15));
}

function_ec358cb5(player, var_5c38c80f, var_36364da6) {
  self function_9afa3156(player, var_5c38c80f);
  self function_56b41599(player, var_36364da6);
}

function_a6bbb523(player, width, height) {
  self set_width(player, int(width / 4));
  self set_height(player, int(height / 4));
}

register(uid) {
  elem = new cluielembar();
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

set_x(player, value) {
  [[self]] - > set_x(player, value);
}

set_y(player, value) {
  [[self]] - > set_y(player, value);
}

set_width(player, value) {
  [[self]] - > set_width(player, value);
}

set_height(player, value) {
  [[self]] - > set_height(player, value);
}

set_fadeovertime(player, value) {
  [[self]] - > set_fadeovertime(player, value);
}

set_alpha(player, value) {
  [[self]] - > set_alpha(player, value);
}

set_red(player, value) {
  [[self]] - > set_red(player, value);
}

set_green(player, value) {
  [[self]] - > set_green(player, value);
}

set_blue(player, value) {
  [[self]] - > set_blue(player, value);
}

set_bar_percent(player, value) {
  [[self]] - > set_bar_percent(player, value);
}