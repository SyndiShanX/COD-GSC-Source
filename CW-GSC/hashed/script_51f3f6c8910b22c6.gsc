/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_51f3f6c8910b22c6.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#namespace doa_textelement;
class class_df106b1: cluielem {
  var var_bf9c8c95;
  var var_d5213cbb;

  function open(player, flags = 0) {
    cluielem::open_luielem(player, flags);
  }

  function function_1a98dac6(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "textpayload", value);
  }

  function set_horizontal_alignment(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "horizontal_alignment", value);
  }

  function set_green(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
  }

  function set_fadeovertime(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
  }

  function close(player) {
    cluielem::close_luielem(player);
  }

  function set_height(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "height", value);
  }

  function set_blue(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
  }

  function setup_clientfields() {
    cluielem::setup_clientfields("DOA_TextElement");
    cluielem::add_clientfield("x", 1, 7, "int");
    cluielem::add_clientfield("y", 1, 6, "int");
    cluielem::add_clientfield("height", 1, 2, "int");
    cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
    cluielem::add_clientfield("alpha", 1, 4, "float");
    cluielem::add_clientfield("red", 1, 4, "float");
    cluielem::add_clientfield("green", 1, 4, "float");
    cluielem::add_clientfield("blue", 1, 4, "float");
    cluielem::function_dcb34c80("string", "text", 1);
    cluielem::add_clientfield("horizontal_alignment", 1, 2, "int");
    cluielem::add_clientfield("intpayload", 1, 32, "int");
    cluielem::function_dcb34c80("string", "textpayload", 1);
    cluielem::add_clientfield("scale", 1, 5, "float");
  }

  function set_y(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "y", value);
  }

  function function_9e089af4(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "intpayload", value);
  }

  function set_alpha(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "alpha", value);
  }

  function set_scale(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scale", value);
  }

  function set_x(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "x", value);
  }

  function set_text(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
  }

  function set_red(player, value) {
    player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
  }
}

function set_color(player, red, green, blue) {
  self set_red(player, red);
  self set_green(player, green);
  self set_blue(player, blue);
}

function fade(player, var_1a92607f, duration = 0) {
  self set_alpha(player, var_1a92607f);
  self set_fadeovertime(player, int(duration * 10));
}

function show(player, duration = 0) {
  self fade(player, 1, duration);
}

function hide(player, duration = 0) {
  self fade(player, 0, duration);
}

function function_e5898fd7(player, var_c6572d9b) {
  self set_x(player, int(var_c6572d9b / 15));
}

function function_58a135d3(player, var_d390c80e) {
  self set_y(player, int(var_d390c80e / 15));
}

function function_f97e9049(player, var_c6572d9b, var_d390c80e) {
  self function_e5898fd7(player, var_c6572d9b);
  self function_58a135d3(player, var_d390c80e);
}

function register() {
  elem = new class_df106b1();
  [[elem]] - > setup_clientfields();
  return elem;
}

function open(player, flags = 0) {
  [[self]] - > open(player, flags);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(player) {
  return [[self]] - > function_7bfd10e6(player);
}

function set_x(player, value) {
  [[self]] - > set_x(player, value);
}

function set_y(player, value) {
  [[self]] - > set_y(player, value);
}

function set_height(player, value) {
  [[self]] - > set_height(player, value);
}

function set_fadeovertime(player, value) {
  [[self]] - > set_fadeovertime(player, value);
}

function set_alpha(player, value) {
  [[self]] - > set_alpha(player, value);
}

function set_red(player, value) {
  [[self]] - > set_red(player, value);
}

function set_green(player, value) {
  [[self]] - > set_green(player, value);
}

function set_blue(player, value) {
  [[self]] - > set_blue(player, value);
}

function set_text(player, value) {
  [[self]] - > set_text(player, value);
}

function set_horizontal_alignment(player, value) {
  [[self]] - > set_horizontal_alignment(player, value);
}

function function_9e089af4(player, value) {
  [[self]] - > function_9e089af4(player, value);
}

function function_1a98dac6(player, value) {
  [[self]] - > function_1a98dac6(player, value);
}

function set_scale(player, value) {
  [[self]] - > set_scale(player, value);
}