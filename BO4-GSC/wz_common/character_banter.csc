/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_banter.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace character_banter;

event_handler[event_10eed35b] function_d8f1209f(eventstruct) {
  if(eventstruct.eventid != 1) {
    return;
  }

  if(isDefined(level.var_1536cd6d) && level.var_1536cd6d) {
    return;
  }

  level.var_1536cd6d = 1;
  player1 = eventstruct.var_40209f44;
  player2 = eventstruct.var_3d136cd9;

  if(!isDefined(player1) || !isDefined(player2)) {
    return;
  }

  if(!player1 function_ca024039() || !player2 function_ca024039()) {
    return;
  }

  banters = function_86492662(player1, player2);

  if(banters.size <= 0) {
    return;
  }

  index = eventstruct.var_7e98b410 % banters.size;
  banter = banters[index];
  var_bfc07183 = player1 function_7b99157b();
  var_d6c29f87 = player2 function_7b99157b();
  level thread play_banter(var_bfc07183, var_d6c29f87, banter[2], banter[3]);
}

function_86492662(player1, player2) {
  banters = [];
  player1name = player1 getmpdialogname();
  player2name = player2 getmpdialogname();

  if(isDefined(player1name) && isDefined(player2name)) {
    rowcount = tablelookuprowcount(#"hash_5ec1825aeab754a2");

    for(i = 0; i < rowcount; i++) {
      row = tablelookuprow(#"hash_5ec1825aeab754a2", i);

      if(row[0] == player1name && row[1] == player2name) {
        banters[banters.size] = row;
      }
    }
  }

  return banters;
}

play_banter(player1, player2, alias1, alias2) {
  player1 endon(#"death");
  player2 endon(#"death");
  handle1 = player1 playSound(-1, alias1);

  if(handle1 >= 0) {
    while(soundplaying(handle1)) {
      waitframe(1);
    }
  }

  wait 0.2;
  player2 playSound(-1, alias2);
}

function_7b99157b() {
  if(isDefined(self getlocalclientnumber())) {
    foreach(player in getlocalplayers()) {
      if(player issplitscreenhost()) {
        return player;
      }
    }
  }

  return self;
}