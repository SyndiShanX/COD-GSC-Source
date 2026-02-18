/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_41540e991952b0c1.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_bannerelement;
class class_1bec696c: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function set_horizontal_alignment(localclientnum, value) {
    set_data(localclientnum, "horizontal_alignment", value);
  }

  function set_green(localclientnum, value) {
    set_data(localclientnum, "green", value);
  }

  function set_fadeovertime(localclientnum, value) {
    set_data(localclientnum, "fadeOverTime", value);
  }

  function register_clientside() {
    cluielem::register_clientside("DOA_BannerElement");
  }

  function set_height(localclientnum, value) {
    set_data(localclientnum, "height", value);
  }

  function set_blue(localclientnum, value) {
    set_data(localclientnum, "blue", value);
  }

  function setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_766e2bbb) {
    cluielem::setup_clientfields("DOA_BannerElement");
    cluielem::add_clientfield("x", 1, 7, "int", ycallback);
    cluielem::add_clientfield("y", 1, 6, "int", heightcallback);
    cluielem::add_clientfield("height", 1, 2, "int", fadeovertimecallback);
    cluielem::add_clientfield("fadeOverTime", 1, 5, "int", alphacallback);
    cluielem::add_clientfield("alpha", 1, 4, "float", redcallback);
    cluielem::add_clientfield("red", 1, 4, "float", greencallback);
    cluielem::add_clientfield("green", 1, 4, "float", bluecallback);
    cluielem::add_clientfield("blue", 1, 4, "float", textcallback);
    cluielem::function_dcb34c80("string", "text", 1);
    cluielem::add_clientfield("horizontal_alignment", 1, 2, "int", horizontal_alignmentcallback);
    cluielem::add_clientfield("scale", 1, 6, "float", var_766e2bbb);
  }

  function set_y(localclientnum, value) {
    set_data(localclientnum, "y", value);
  }

  function set_alpha(localclientnum, value) {
    set_data(localclientnum, "alpha", value);
  }

  function set_scale(localclientnum, value) {
    set_data(localclientnum, "scale", value);
  }

  function set_x(localclientnum, value) {
    set_data(localclientnum, "x", value);
  }

  function set_text(localclientnum, value) {
    set_data(localclientnum, "text", value);
  }

  function set_red(localclientnum, value) {
    set_data(localclientnum, "red", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "x", 0);
    set_data(localclientnum, "y", 0);
    set_data(localclientnum, "height", 0);
    set_data(localclientnum, "fadeOverTime", 0);
    set_data(localclientnum, "alpha", 0);
    set_data(localclientnum, "red", 0);
    set_data(localclientnum, "green", 0);
    set_data(localclientnum, "blue", 0);
    set_data(localclientnum, "text", #"");
    set_data(localclientnum, "horizontal_alignment", 0);
    set_data(localclientnum, "scale", 0);
  }
}

function set_color(localclientnum, red, green, blue) {
  self set_red(localclientnum, red);
  self set_green(localclientnum, green);
  self set_blue(localclientnum, blue);
}

function fade(localclientnum, var_1a92607f, duration = 0) {
  self set_alpha(localclientnum, var_1a92607f);
  self set_fadeovertime(localclientnum, int(duration * 10));
}

function show(localclientnum, duration = 0) {
  self fade(localclientnum, 1, duration);
}

function hide(localclientnum, duration = 0) {
  self fade(localclientnum, 0, duration);
}

function function_e5898fd7(localclientnum, var_c6572d9b) {
  self set_x(localclientnum, int(var_c6572d9b / 15));
}

function function_58a135d3(localclientnum, var_d390c80e) {
  self set_y(localclientnum, int(var_d390c80e / 15));
}

function function_f97e9049(localclientnum, var_c6572d9b, var_d390c80e) {
  self function_e5898fd7(localclientnum, var_c6572d9b);
  self function_58a135d3(localclientnum, var_d390c80e);
}

function register(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_766e2bbb) {
  elem = new class_1bec696c();
  [[elem]] - > setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_766e2bbb);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "doa_bannerelement"])) {
    level.var_ae746e8f[# "doa_bannerelement"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "doa_bannerelement"])) {
    level.var_ae746e8f[# "doa_bannerelement"] = [];
  } else if(!isarray(level.var_ae746e8f[# "doa_bannerelement"])) {
    level.var_ae746e8f[# "doa_bannerelement"] = array(level.var_ae746e8f[# "doa_bannerelement"]);
  }

  level.var_ae746e8f[# "doa_bannerelement"][level.var_ae746e8f[# "doa_bannerelement"].size] = elem;
}

function register_clientside() {
  elem = new class_1bec696c();
  [[elem]] - > register_clientside();
  return elem;
}

function open(player) {
  [[self]] - > open(player);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

function set_x(localclientnum, value) {
  [[self]] - > set_x(localclientnum, value);
}

function set_y(localclientnum, value) {
  [[self]] - > set_y(localclientnum, value);
}

function set_height(localclientnum, value) {
  [[self]] - > set_height(localclientnum, value);
}

function set_fadeovertime(localclientnum, value) {
  [[self]] - > set_fadeovertime(localclientnum, value);
}

function set_alpha(localclientnum, value) {
  [[self]] - > set_alpha(localclientnum, value);
}

function set_red(localclientnum, value) {
  [[self]] - > set_red(localclientnum, value);
}

function set_green(localclientnum, value) {
  [[self]] - > set_green(localclientnum, value);
}

function set_blue(localclientnum, value) {
  [[self]] - > set_blue(localclientnum, value);
}

function set_text(localclientnum, value) {
  [[self]] - > set_text(localclientnum, value);
}

function set_horizontal_alignment(localclientnum, value) {
  [[self]] - > set_horizontal_alignment(localclientnum, value);
}

function set_scale(localclientnum, value) {
  [[self]] - > set_scale(localclientnum, value);
}