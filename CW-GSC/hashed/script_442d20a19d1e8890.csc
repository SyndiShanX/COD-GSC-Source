/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_442d20a19d1e8890.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace incursion_infiltrationtitlecards;
class class_7c3faeda: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function register_clientside() {
    cluielem::register_clientside("Incursion_InfiltrationTitleCards");
  }

  function setup_clientfields(var_f1385203) {
    cluielem::setup_clientfields("Incursion_InfiltrationTitleCards");
    cluielem::add_clientfield("_state", 1, 4, "int");
    cluielem::add_clientfield("SelectedInfiltration", 1, 3, "int", var_f1385203);
  }

  function set_state(localclientnum, state_name) {
    if(#"defaultstate" == state_name) {
      set_data(localclientnum, "_state", 0);
      return;
    }

    if(#"hash_1c7fa28cf1485078" == state_name) {
      set_data(localclientnum, "_state", 1);
      return;
    }

    if(#"hash_41af72ac3698f06f" == state_name) {
      set_data(localclientnum, "_state", 2);
      return;
    }

    if(#"hash_5b1f56f3d27d25f0" == state_name) {
      set_data(localclientnum, "_state", 3);
      return;
    }

    if(#"hash_249ee0339eddec66" == state_name) {
      set_data(localclientnum, "_state", 4);
      return;
    }

    if(#"hash_55a524ad199904e9" == state_name) {
      set_data(localclientnum, "_state", 5);
      return;
    }

    if(#"hash_37b2af92df0bfd42" == state_name) {
      set_data(localclientnum, "_state", 6);
      return;
    }

    if(#"hash_30029804cf01e828" == state_name) {
      set_data(localclientnum, "_state", 7);
      return;
    }

    if(#"hash_386af01523f194e5" == state_name) {
      set_data(localclientnum, "_state", 8);
      return;
    }

    if(#"hash_c5a40437efffe76" == state_name) {
      set_data(localclientnum, "_state", 9);
      return;
    }

    if(#"hash_88bd3835c23cdbc" == state_name) {
      set_data(localclientnum, "_state", 10);
      return;
    }

    if(#"hash_55e75da288d110d4" == state_name) {
      set_data(localclientnum, "_state", 11);
      return;
    }

    if(#"hash_3eb38ea38a92fe35" == state_name) {
      set_data(localclientnum, "_state", 12);
      return;
    }

    if(#"hash_79efd6a9d00cac13" == state_name) {
      set_data(localclientnum, "_state", 13);
      return;
    }

    assertmsg("<dev string:x38>");
  }

  function function_ee0c7ef6(localclientnum, value) {
    set_data(localclientnum, "SelectedInfiltration", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_state(localclientnum, #"defaultstate");
    set_data(localclientnum, "SelectedInfiltration", 0);
  }
}

function register(var_f1385203) {
  elem = new class_7c3faeda();
  [[elem]] - > setup_clientfields(var_f1385203);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[# "incursion_infiltrationtitlecards"])) {
    level.var_ae746e8f[# "incursion_infiltrationtitlecards"] = [];
  }

  if(!isDefined(level.var_ae746e8f[# "incursion_infiltrationtitlecards"])) {
    level.var_ae746e8f[# "incursion_infiltrationtitlecards"] = [];
  } else if(!isarray(level.var_ae746e8f[# "incursion_infiltrationtitlecards"])) {
    level.var_ae746e8f[# "incursion_infiltrationtitlecards"] = array(level.var_ae746e8f[# "incursion_infiltrationtitlecards"]);
  }

  level.var_ae746e8f[# "incursion_infiltrationtitlecards"][level.var_ae746e8f[# "incursion_infiltrationtitlecards"].size] = elem;
}

function register_clientside() {
  elem = new class_7c3faeda();
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

function set_state(localclientnum, state_name) {
  [[self]] - > set_state(localclientnum, state_name);
}

function function_ee0c7ef6(localclientnum, value) {
  [[self]] - > function_ee0c7ef6(localclientnum, value);
}