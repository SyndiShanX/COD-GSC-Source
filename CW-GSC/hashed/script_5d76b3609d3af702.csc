/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5d76b3609d3af702.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_textbubble;
class class_b20c2804: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_4f6e830d(localclientnum, value) {
    set_data(localclientnum, "offset_y", value);
  }

  function register_clientside() {
    cluielem::register_clientside("DOA_TextBubble");
  }

  function function_61312692(localclientnum, value) {
    set_data(localclientnum, "offset_x", value);
  }

  function function_7ddfdfef(localclientnum, value) {
    set_data(localclientnum, "offset_z", value);
  }

  function setup_clientfields(var_5a7b4b38, textcallback, var_5957697a, var_90efc226, var_b77f41ee) {
    cluielem::setup_clientfields("DOA_TextBubble");
  }

  function set_entnum(localclientnum, value) {
    set_data(localclientnum, "entnum", value);
  }

  function set_text(localclientnum, value) {
    set_data(localclientnum, "text", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "entnum", 0);
    set_data(localclientnum, "text", #"");
    set_data(localclientnum, "offset_x", 0);
    set_data(localclientnum, "offset_y", 0);
    set_data(localclientnum, "offset_z", 0);
  }
}

function set_offset(localclientnum, offsetx, offsety, offsetz) {
  self function_61312692(localclientnum, offsetx);
  self function_4f6e830d(localclientnum, offsety);
  self function_7ddfdfef(localclientnum, offsetz);
}

function function_78098d4b(localclientnum, value) {
  [[self]] - > set_data(localclientnum, "boneTag", value);
}

function function_919052d(localclientnum, entnum, bonetag) {
  self set_entnum(localclientnum, entnum);
  self function_78098d4b(localclientnum, bonetag);
}

function register(var_5a7b4b38, textcallback, var_5957697a, var_90efc226, var_b77f41ee) {
  elem = new class_b20c2804();
  [[elem]] - > setup_clientfields(var_5a7b4b38, textcallback, var_5957697a, var_90efc226, var_b77f41ee);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "doa_textbubble"])) {
    level.var_ae746e8f[# "doa_textbubble"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "doa_textbubble"])) {
    level.var_ae746e8f[# "doa_textbubble"] = [];
  } else if(!isarray(level.var_ae746e8f[# "doa_textbubble"])) {
    level.var_ae746e8f[# "doa_textbubble"] = array(level.var_ae746e8f[# "doa_textbubble"]);
  }

  level.var_ae746e8f[# "doa_textbubble"][level.var_ae746e8f[# "doa_textbubble"].size] = elem;
}

function register_clientside() {
  elem = new class_b20c2804();
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

function set_entnum(localclientnum, value) {
  [[self]] - > set_entnum(localclientnum, value);
}

function set_text(localclientnum, value) {
  [[self]] - > set_text(localclientnum, value);
}

function function_61312692(localclientnum, value) {
  [[self]] - > function_61312692(localclientnum, value);
}

function function_4f6e830d(localclientnum, value) {
  [[self]] - > function_4f6e830d(localclientnum, value);
}

function function_7ddfdfef(localclientnum, value) {
  [[self]] - > function_7ddfdfef(localclientnum, value);
}