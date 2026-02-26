/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6ac5ce345bf4213b.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace doa_textbubble_playername;
class class_42946372: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function set_clientnum(localclientnum, value) {
    set_data(localclientnum, "clientnum", value);
  }

  function function_4f6e830d(localclientnum, value) {
    set_data(localclientnum, "offset_y", value);
  }

  function register_clientside() {
    cluielem::register_clientside("DOA_TextBubble_PlayerName");
  }

  function function_61312692(localclientnum, value) {
    set_data(localclientnum, "offset_x", value);
  }

  function function_7ddfdfef(localclientnum, value) {
    set_data(localclientnum, "offset_z", value);
  }

  function setup_clientfields(var_5a7b4b38, var_c05c67e2, var_5957697a, var_90efc226, var_b77f41ee) {
    cluielem::setup_clientfields("DOA_TextBubble_PlayerName");
  }

  function set_entnum(localclientnum, value) {
    set_data(localclientnum, "entnum", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_data(localclientnum, "entnum", 0);
    set_data(localclientnum, "clientnum", 0);
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

function register(var_5a7b4b38, var_c05c67e2, var_5957697a, var_90efc226, var_b77f41ee) {
  elem = new class_42946372();
  [[elem]] - > setup_clientfields(var_5a7b4b38, var_c05c67e2, var_5957697a, var_90efc226, var_b77f41ee);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"doa_textbubble_playername"])) {
    level.var_ae746e8f[#"doa_textbubble_playername"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"doa_textbubble_playername"])) {
    level.var_ae746e8f[#"doa_textbubble_playername"] = [];
  } else if(!isarray(level.var_ae746e8f[#"doa_textbubble_playername"])) {
    level.var_ae746e8f[#"doa_textbubble_playername"] = array(level.var_ae746e8f[#"doa_textbubble_playername"]);
  }

  level.var_ae746e8f[#"doa_textbubble_playername"][level.var_ae746e8f[#"doa_textbubble_playername"].size] = elem;
}

function register_clientside() {
  elem = new class_42946372();
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

function set_clientnum(localclientnum, value) {
  [[self]] - > set_clientnum(localclientnum, value);
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