/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\sound.gsc
***********************************************/

exploder_sound() {
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  self playSound(level.scr_sound[self.script_sound]);
}

playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0]))
      level.players[0] playlocalsound(var_0);
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }
        if(isDefined(var_4.pers["_encstr_8AEF05472BC2D6"]) && var_4.pers["_encstr_8AEF05472BC2D6"] == var_1 && !scripts\engine\utility::array_contains(var_2, var_4))
          var_4 playlocalsound(var_0);
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }
      if(isDefined(var_4.pers["_encstr_8AEF05472BC2D6"]) && var_4.pers["_encstr_8AEF05472BC2D6"] == var_1)
        var_4 playlocalsound(var_0);
    }

    return;
  } else if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(var_2, level.players[var_3]))
        level.players[var_3] playlocalsound(var_0);
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] issplitscreenplayer() && !level.players[var_3] issplitscreenplayerprimary()) {
        continue;
      }
      level.players[var_3] playlocalsound(var_0);
    }
  }
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0);
}

play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1))
    playsoundatpos(self gettagorigin(var_1), var_0);
  else
    playsoundatpos(self.origin, var_0);
}

playplayerandnpcsounds(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playSound(var_2, var_0);
}

playdeathsound(var_0) {
  if(istrue(level._id_133B4) || var_0 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    return;
  }
  var_1 = randomintrange(1, 8);
  var_2 = "_encstr_979608DF73C8E70B73A1";

  if(scripts\mp\utility\player::isfemale())
    var_2 = "_encstr_B82907C2887BC62B39";

  if(var_0 == "_encstr_87A10C9D24E997A01F21838F3D34" || var_0 == "_encstr_AB590C99ED78875F650F3951034D" && isPlayer(self)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      playplayerandnpcsounds(self, "_encstr_ACAB14C94B58EF64D92B70D1B96D0849AAF856C09A48", var_2 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_1);
    else
      playplayerandnpcsounds(self, "_encstr_ACAB14C94B58EF64D92B70D1B96D0849AAF856C09A48", var_2 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_1);
  } else if(istrue(self.iszombie) || istrue(level.setplayerselfrevivingextrainfo) && level.gametype == "_encstr_AAE507E8423F63C163" && self.team == "_encstr_8E8405EA382B2A")
    playplayerandnpcsounds(self, "_encstr_8B1512F25398590325B1E32A5E0C5F4DC8156973", "_encstr_959A16F45B26BE9B386CF58CCA85D1D0AF9DB237AC27B436");
  else if(isPlayer(self)) {
    if(self.team == "_encstr_8E8405EA382B2A")
      playplayerandnpcsounds(self, "_encstr_966112D891EBDF875398CB0281BF3FE3E1065943", var_2 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_1);
    else
      playplayerandnpcsounds(self, "_encstr_966112D891EBDF875398CB0281BF3FE3E1065943", var_2 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_1);
  } else if(self.team == "_encstr_8E8405EA382B2A")
    self playSound(var_2 + "_encstr_A52710BECD2D4E23C04133D38A6678DA8B91" + var_1);
  else
    self playSound(var_2 + "_encstr_A50311FA46CA0BD1A1FA2CD62BC95A8DB0DCFA" + var_1);
}

any_player_nearby_same_floor() {
  if(!isarray(level.amounttotal))
    level.amounttotal = [];

  if(!isent(level.ammotype))
    level.ammotype = spawn("_encstr_8A941B8BA78B102A492CFE2992076A0890DC4972DD4312852A27C202AB", (0, 0, 0));
}

besttime(var_0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var_0])) {
    return;
  }
  level.ammotype settransientsoundbank(var_0 + "_encstr_ABA7058B1663D8", 1);
  level.amounttotal[var_0] = level.amounttotal.size;
  return;
}

_id_12C2A(var_0) {
  any_player_nearby_same_floor();

  if(isDefined(level.amounttotal[var_0])) {
    level.ammotype settransientsoundbank(var_0 + "_encstr_ABA7058B1663D8", 0);
    level.amounttotal[var_0] = undefined;
  } else {}
}