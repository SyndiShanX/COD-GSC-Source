/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_braggingrights.gsc
***************************************************/

#include maps\mp\_utility;

resolveBraggingRights() {
  num_bragging_rights = GetNumBraggingRights();
  brarray = [];

  for(i = 0; i < num_bragging_rights; i++) {
    brarray[i] = [];
  }

  foreach(p in level.players) {
    if(IsAlive(p)) {
      br = p GetBraggingRight();

      if(br < num_bragging_rights) {
        curr_size = brarray[br].size;
        brarray[br][curr_size] = p;
      }
    }
  }

  foreach(i, br in brarray) {
    if(br.size > 1) {
      Print("Resolving BR conflict at : " + i);
      stat_accessor = TableLookupByRow("mp/braggingrights.csv", i, 2);

      highScore = undefined;
      winner = undefined;
      foreach(player in br) {
        playerValue = player getPlayerStat(stat_accessor);
        if(!isDefined(highScore) || playerValue > highScore) {
          winner = player;
          highScore = playerValue;
        }
      }

      foreach(player in br) {
        if(player == winner) {
          if(!isDefined(player.matchBonus)) {
            player.matchBonus = 0;
          }

          total_bonus = 0;
          foreach(p in br) {
            if(isDefined(p.matchBonus)) {
              total_bonus += p.matchBonus;
            }
          }

          player.matchBonus += total_bonus;

          Print("Bragging Rights Bonus: " + total_bonus + " For " + player.name + " \n");
        } else {
          Print("Bragging Rights LOST by " + player.name + " \n");
          player.braggingRightsLoser = true;
        }
      }
    }
  }

  foreach(p in level.players) {
    if(isDefined(p.braggingRightsLoser) && p.braggingRightsLoser) {
      p.matchBonus = 0;
    }
  }
}

GetNumBraggingRights() {
  line_num = -1;
  line_val = "temp";
  while(line_val != "") {
    line_num++;
    line_val = TableLookupByRow("mp/braggingrights.csv", line_num, 0);
  }

  return line_num;
}