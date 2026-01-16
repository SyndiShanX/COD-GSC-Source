/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ctf.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\util_shared;

#namespace ctf;

event_handler[gametype_init] main(eventstruct) {
  callback::on_localclient_connect(&on_localclient_connect);
  clientfield::register("scriptmover", "ctf_flag_away", 17000, 1, "int", &setctfaway, 0, 0);
  clientfield::register("allplayers", "ctf_flag_carried", 17000, 1, "int", &function_4db33d0, 0, 1);
  clientfield::register("worlduimodel", "CTFLevelInfo.bestTimeAllies", 17000, 9, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "CTFLevelInfo.bestTimeAxis", 17000, 9, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "CTFLevelInfo.flagCarrierAllies", 17000, 7, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "CTFLevelInfo.flagCarrierAxis", 17000, 7, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "CTFLevelInfo.flagStateAllies", 17000, 2, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "CTFLevelInfo.flagStateAxis", 17000, 2, "int", undefined, 0, 0);
  clientfield::register("worlduimodel", "ctf_reset_score", 17000, 1, "int", &ctf_reset_score, 0, 0);
  forcestreamxmodel(#"p8_mp_flag_pole_1_blackops", 8, -1);
  forcestreamxmodel(#"p8_mp_flag_pole_1_blackops_alt", 8, -1);
  forcestreamxmodel(#"p8_mp_flag_pole_1_mercs", 8, -1);
  forcestreamxmodel(#"p8_mp_flag_pole_1_mercs_alt", 8, -1);
}

ctf_reset_score(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  gamescoremodel = getuimodel(getuimodelforcontroller(localclientnum), "GameScore");
  playerscoremodel = getuimodel(gamescoremodel, "playerScore");
  enemyscoremodel = getuimodel(gamescoremodel, "enemyScore");
  setuimodelvalue(playerscoremodel, 0);
  setuimodelvalue(enemyscoremodel, 0);
}

on_localclient_connect(localclientnum) {
  level.var_8b7ba196[localclientnum] = util::getnextobjid(localclientnum);
  objective_add(localclientnum, level.var_8b7ba196[localclientnum], "invisible", #"flag_taken", (0, 0, 0), util::get_other_team(function_9b3f0ed1(localclientnum)));
  level thread function_27ecd662(localclientnum);
}

function_27ecd662(localclientnum) {
  player = function_27673a7(localclientnum);
  player endon(#"disconnect");

  while(true) {
    enemies = getplayers(localclientnum);
    player = function_27673a7(localclientnum);
    var_3b68ee3f = undefined;

    foreach(enemy in enemies) {
      if(enemy.team == player.team) {
        continue;
      }

      if(isDefined(enemy.var_b0256c7b) && enemy.var_b0256c7b) {
        var_3b68ee3f = enemy.origin;
        break;
      }
    }

    if(isDefined(var_3b68ee3f)) {
      var_b13a6419 = gettime();
      objective_setstate(localclientnum, level.var_8b7ba196[localclientnum], "active");
      objective_setposition(localclientnum, level.var_8b7ba196[localclientnum], var_3b68ee3f);

      while(var_b13a6419 + 2000 > gettime() && isDefined(enemy) && enemy.var_b0256c7b) {
        waitframe(1);
      }

      continue;
    }

    objective_setstate(localclientnum, level.var_8b7ba196[localclientnum], "invisible");
    waitframe(1);
  }
}

setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  team = self.team;
  setflagasaway(localclientnum, team, newval);
  self thread clearctfaway(localclientnum, team);
}

clearctfaway(localclientnum, team) {
  self waittill(#"death");
  setflagasaway(localclientnum, team, 0);
}

function_4db33d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_b0256c7b = newval;
}