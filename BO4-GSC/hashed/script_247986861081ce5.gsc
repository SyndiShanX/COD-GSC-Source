/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_247986861081ce5.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\zm\zm_office_floors;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_ui_inventory;

#namespace namespace_ff847c6a;

init() {
  if(!isDefined(level.var_a7b0c29c)) {
    level.var_a7b0c29c = [];
  } else if(!isarray(level.var_a7b0c29c)) {
    level.var_a7b0c29c = array(level.var_a7b0c29c);
  }

  level.var_a7b0c29c[0] = {
    #start_func:&function_6882655b, 
    #end_func:&function_55f180c2, 
    #n_index: 1, 
    #n_target: 2
  };
  level.var_a7b0c29c[1] = {
    #start_func:&function_6882655b, 
    #end_func:&function_55f180c2, 
    #n_index: 2, 
    #n_target: 4
  };
  level.var_a7b0c29c[2] = {
    #start_func:&function_6882655b, 
    #end_func:&function_55f180c2, 
    #n_index: 3, 
    #n_target: 6
  };
  level.var_a7b0c29c[3] = {
    #start_func:&function_6882655b, 
    #end_func:&function_55f180c2, 
    #n_index: 4, 
    #n_target: 8
  };
  level.var_a7b0c29c[4] = {
    #start_func:&function_6882655b, 
    #end_func:&function_55f180c2, 
    #n_index: 5, 
    #n_target: 10
  };
  level.var_f0efd877 = 0;
  function_1525b94c();
  function_a5cebb9a(0);
  level thread function_1b350677();
}

function_1525b94c() {
  start_challenge(array::pop_front(level.var_a7b0c29c));
}

challenge_completed() {

  iprintlnbold("<dev string:x38>");

    wait 3;

  if(level.var_a7b0c29c.size == 0) {
    function_8bddfcc3();
    return;
  }

  function_1525b94c();
}

function_bc0ec5b3(b_activate) {
  level.var_f0efd877 = b_activate;
  function_a5cebb9a(level.var_f0efd877);
}

function_a5cebb9a(b_show) {
  if(b_show) {
    function_260958b(#"hash_7ed874a0ecdefd90", level.var_b92b8b07.n_index);
    return;
  }

  function_260958b(#"hash_7ed874a0ecdefd90", 0);
}

function_92df87d7() {
  level.var_31e395e4++;
  function_260958b(#"hash_518608853a37856e", level.var_31e395e4);

  if(level.var_31e395e4 >= level.var_b92b8b07.n_target) {
    function_5c99b476();
  }
}

function_f76df1da() {
  level.var_31e395e4 = 0;
  function_260958b(#"hash_518608853a37856e", level.var_31e395e4);
}

function_8bddfcc3() {

  iprintlnbold("<dev string:x5d>");

    level notify(#"hash_4d3a2c46c22b012e");
  function_bc0ec5b3(0);
}

function_1b350677() {
  level endon(#"hash_4d3a2c46c22b012e");

  while(true) {
    if(!level.var_f0efd877 && function_c32f5235()) {
      function_bc0ec5b3(1);
    } else if(level.var_f0efd877 && !function_c32f5235()) {
      function_bc0ec5b3(0);
    }

    wait 0.1;
  }
}

function_c32f5235() {
  foreach(e_player in level.activeplayers) {
    if(!e_player istouching(level.var_b4fcac11[3])) {
      return false;
    }
  }

  return true;
}

function_260958b(fieldname, value) {
  foreach(e_player in level.activeplayers) {
    level zm_ui_inventory::function_7df6bb60(fieldname, value, e_player);
  }
}

start_challenge(s_challenge) {
  level.var_b92b8b07 = s_challenge;
  function_f76df1da();
  function_a5cebb9a(1);
  [[level.var_b92b8b07.start_func]]();
}

function_5c99b476() {
  function_a5cebb9a(0);
  [[level.var_b92b8b07.end_func]]();
}

function_6882655b() {
  callback::on_ai_killed(&function_5e7d8d96);
  callback::on_player_damage(&function_b8b3c1e5);
}

function_5e7d8d96(s_params) {
  if(!level.var_f0efd877 || !isplayer(s_params.eattacker)) {
    return;
  }

  function_92df87d7();
}

function_b8b3c1e5(s_params) {
  function_f76df1da();
}

function_55f180c2() {
  callback::remove_on_ai_killed(&function_5e7d8d96);
  callback::remove_on_player_damage(&function_b8b3c1e5);
  challenge_completed();
}