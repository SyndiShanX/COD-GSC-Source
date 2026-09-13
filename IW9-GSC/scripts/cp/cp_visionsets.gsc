/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_visionsets.gsc
***********************************************/

vision_set_management() {
  _id_C77CE6671D293276 = undefined;
  player = undefined;

  for(;;) {
    level waittill("vision_set_change_request", _id_C77CE6671D293276, player, _id_0A1014EE6E2EA9F2, _id_CE7CD55E867A0F21);

    if(!isDefined(_id_C77CE6671D293276) && isDefined(_id_CE7CD55E867A0F21)) {
      if(!isstring(_id_CE7CD55E867A0F21)) {
        continue;
      }
      if(_id_CE7CD55E867A0F21 == "") {
        continue;
      }
      if(isDefined(player)) {
        if(!isPlayer(player)) {
          continue;
        }
        remove_visionset_specific_from_stack(player, _id_CE7CD55E867A0F21, _id_0A1014EE6E2EA9F2);
      } else {
        foreach(guy in level.players)
        remove_visionset_specific_from_stack(guy, _id_CE7CD55E867A0F21, _id_0A1014EE6E2EA9F2);
      }

      continue;
    }

    if(!isDefined(_id_C77CE6671D293276) || !isstring(_id_C77CE6671D293276)) {
      continue;
    }
    if(isDefined(player)) {
      if(!isPlayer(player)) {
        continue;
      }
      if(_id_C77CE6671D293276 == "")
        remove_visionset_from_stack(player, _id_0A1014EE6E2EA9F2);
      else
        add_visionset_to_stack(player, _id_C77CE6671D293276, _id_0A1014EE6E2EA9F2);

      continue;
    }

    foreach(guy in level.players) {
      if(_id_C77CE6671D293276 == "") {
        remove_visionset_from_stack(guy, _id_0A1014EE6E2EA9F2);
        continue;
      }

      add_visionset_to_stack(guy, _id_C77CE6671D293276, _id_0A1014EE6E2EA9F2);
    }
  }
}

create_visionset_stack(player) {
  player.visionset_stack = [""];
  player.visionset_pointer = player.visionset_stack.size - 1;
  player.current_visionset = player.visionset_stack[player.visionset_pointer];
  player visionsetnakedforplayer(player.current_visionset);
}

add_visionset_to_stack(player, _id_FC0043E95242D5CB, _id_0A1014EE6E2EA9F2) {
  player.old_visionset = player.visionset_stack[player.visionset_pointer];
  player.visionset_stack = scripts\engine\utility::array_add(player.visionset_stack, _id_FC0043E95242D5CB);
  player.visionset_pointer = player.visionset_stack.size - 1;
  player.current_visionset = player.visionset_stack[player.visionset_pointer];

  if(isDefined(_id_0A1014EE6E2EA9F2))
    player visionsetnakedforplayer(player.current_visionset, _id_0A1014EE6E2EA9F2);
  else
    player visionsetnakedforplayer(player.current_visionset);
}

remove_visionset_from_stack(player, _id_0A1014EE6E2EA9F2) {
  if(player.visionset_pointer <= 0) {} else {
    player.old_visionset = player.visionset_stack[player.visionset_pointer];
    player.visionset_stack = scripts\engine\utility::array_remove_index(player.visionset_stack, player.visionset_pointer);
    player.visionset_pointer--;
    player.current_visionset = player.visionset_stack[player.visionset_pointer];
  }

  if(isDefined(_id_0A1014EE6E2EA9F2))
    player visionsetnakedforplayer(player.current_visionset, _id_0A1014EE6E2EA9F2);
  else
    player visionsetnakedforplayer(player.current_visionset);
}

remove_visionset_specific_from_stack(player, _id_FC0043E95242D5CB, _id_0A1014EE6E2EA9F2) {
  if(player.visionset_pointer > 0) {
    player.visionset_stack = scripts\engine\utility::array_remove(player.visionset_stack, _id_FC0043E95242D5CB);
    player.visionset_pointer--;
    player.current_visionset = player.visionset_stack[player.visionset_pointer];
  }

  if(isDefined(player.current_visionset)) {
    if(isDefined(_id_0A1014EE6E2EA9F2))
      player visionsetnakedforplayer(player.current_visionset, _id_0A1014EE6E2EA9F2);
    else
      player visionsetnakedforplayer(player.current_visionset);
  }
}