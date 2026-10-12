/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_visionsets.gsc
***********************************************/



#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_visionsets;

function vision_set_management() {
  var_c77ce6671d293276 = undefined;
  player = undefined;

  while(true) {
    level waittill("vision_set_change_request", var_c77ce6671d293276, player, transition_time, var_ce7cd55e867a0f21);

    if(!isDefined(var_c77ce6671d293276) && isDefined(var_ce7cd55e867a0f21)) {
      assertex(isstring(var_ce7cd55e867a0f21), "the Vision set string param should always be of string datatype");

      if(!isstring(var_ce7cd55e867a0f21)) {
        continue;
      }

      assertex(var_ce7cd55e867a0f21 != "", "the Vision set string to be removed should be a specific value and not closed quotes (Basic Vision Set)");

      if(var_ce7cd55e867a0f21 == "") {
        continue;
      }

      if(isDefined(player)) {
        assertex(isPlayer(player), "the Player param should always be of Player datatype");

        if(!isPlayer(player)) {
          continue;
        }

        remove_visionset_specific_from_stack(player, var_ce7cd55e867a0f21, transition_time);
      } else {
        foreach(guy in level.players) {
          remove_visionset_specific_from_stack(guy, var_ce7cd55e867a0f21, transition_time);
        }
      }

      continue;
    }

    assertex(isDefined(var_c77ce6671d293276), "Please pass a Vision set string with your notify");
    assertex(isstring(var_c77ce6671d293276), "the Vision set string param should always be of string datatype");

    if(!isDefined(var_c77ce6671d293276) || !isstring(var_c77ce6671d293276)) {
      continue;
    }

    if(isDefined(player)) {
      assertex(isPlayer(player), "the Player param should always be of Player datatype");

      if(!isPlayer(player)) {
        continue;
      }

      if(var_c77ce6671d293276 == "") {
        remove_visionset_from_stack(player, transition_time);
      } else {
        add_visionset_to_stack(player, var_c77ce6671d293276, transition_time);
      }

      continue;
    }

    foreach(guy in level.players) {
      if(var_c77ce6671d293276 == "") {
        remove_visionset_from_stack(guy, transition_time);
        continue;
      }

      add_visionset_to_stack(guy, var_c77ce6671d293276, transition_time);
    }
  }
}

function create_visionset_stack(player) {
  player.visionset_stack = [""];
  player.visionset_pointer = player.visionset_stack.size - 1;
  player.current_visionset = player.visionset_stack[player.visionset_pointer];
  player visionsetnakedforplayer(player.current_visionset, 0);
}

function add_visionset_to_stack(player, visionset, transition_time) {
  player.old_visionset = player.visionset_stack[player.visionset_pointer];
  player.visionset_stack = array_add(player.visionset_stack, visionset);
  player.visionset_pointer = player.visionset_stack.size - 1;
  player.current_visionset = player.visionset_stack[player.visionset_pointer];

  if(isDefined(transition_time)) {
    player visionsetnakedforplayer(player.current_visionset, transition_time);
    return;
  }

  player visionsetnakedforplayer(player.current_visionset);
}

function remove_visionset_from_stack(player, transition_time) {
  if(player.visionset_pointer <= 0) {} else {
    player.old_visionset = player.visionset_stack[player.visionset_pointer];
    player.visionset_stack = array_remove_index(player.visionset_stack, player.visionset_pointer);
    player.visionset_pointer--;
    player.current_visionset = player.visionset_stack[player.visionset_pointer];
  }

  if(isDefined(transition_time)) {
    player visionsetnakedforplayer(player.current_visionset, transition_time);
    return;
  }

  player visionsetnakedforplayer(player.current_visionset);
}

function remove_visionset_specific_from_stack(player, visionset, transition_time) {
  if(player.visionset_pointer > 0) {
    player.visionset_stack = array_remove(player.visionset_stack, visionset);
    player.visionset_pointer--;
    player.current_visionset = player.visionset_stack[player.visionset_pointer];
  }

  if(isDefined(player.current_visionset)) {
    if(isDefined(transition_time)) {
      player visionsetnakedforplayer(player.current_visionset, transition_time);
      return;
    }

    player visionsetnakedforplayer(player.current_visionset);
  }
}