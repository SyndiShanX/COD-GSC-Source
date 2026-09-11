/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\points.gsc
***********************************************/

function givestreakpointswithtext(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring)) {
    return;
  }

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  var_3 = modifyunifiedpoints(var_1, var_3, var_2);
  scripts\mp\killstreaks\killstreaks::givestreakpoints(var_1, var_3);
  displayscoreeventpoints(var_3, var_1);
}

function sec_sys_struct_1(var_0, var_1) {
  if(istrue(level.ignorescoring)) {
    return;
  }

  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  thread scripts\mp\rank::giverankxp(var_0, var_2);
  thread scripts\mp\rank::scoreeventpopup(var_0);
}

function giveunifiedpoints(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done");

  if(istrue(level.ignorescoring) && !issubstr(var_0, "assist") && !var_8) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(var_2)) {
    var_9 = var_2;
  } else {
    var_9 = scripts\mp\rank::getscoreinfovalue(var_1);
  }

  scripts\mp\gamescore::giveplayerscore(var_1, var_9, var_5);
  var_9 = modifyunifiedpoints(var_1, var_9, var_2);

  if(isDefined(var_2)) {
    var_10 = scripts\mp\utility\weapon::mapweapon(var_2);
    var_11 = createheadicon(var_10);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_11, var_9, "total_score_earned");
  }

  if(isDefined(var_7)) {
    var_7.score += var_9;
  }

  var_12 = var_1 == "kill" || !scripts\mp\utility\game::matchmakinggame() && var_1 == "last_stand_kill";
  var_13 = scripts\mp\killstreaks\killstreaks::isbountyevent(var_1);
  var_14 = scripts\mp\killstreaks\killstreaks::iskillstreakkillevent(var_1);
  var_15 = istrue(self.isjuggernaut);
  var_16 = update_objective_setmlgbackground(var_2);
  var_17 = scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak");
  var_18 = !istrue(level.vocalloutstring);

  if((var_12 || var_14) && !scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {
    self.pers["canKillChain"] = undefined;
  }

  var_19 = var_14 && istrue(self.pers["canKillChain"]) && istrue(var_6);

  if((var_12 || var_13 || var_19 || var_17) && (!var_15 || var_19 || var_17) && !var_16 && scripts\mp\utility\game::getgametype() != "br" && var_18) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      scripts\mp\killstreaks\killstreaks::givestreakpoints(var_1, 1, var_9);
    }
  }

  if(isDefined(level.ref_12073)) {
    [[level.ref_12073]](self, var_9, var_1, var_8);
  }

  scripts\mp\supers::givesuperpoints(var_9, var_1);

  if(!istrue(var_4)) {
    var_20 = var_9;
    thread scripts\mp\rank::giverankxp(var_1, var_20, var_2);
  }

  thread scripts\mp\events::killeventtextpopup(var_1, 0);
}

function modifyunifiedpoints(var_0, var_1, var_2) {
  switch (var_0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var_3 = 0;
  var_1 += var_3;

  if(isDefined(level.modifyunifiedpointscallback)) {
    var_1 = [[level.modifyunifiedpointscallback]](var_1, var_0, self, var_2);
  }

  return int(var_1);
}

function displayscoreeventpoints(var_0, var_1) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(level.codcasterenabled) {
    foreach(var_3 in level.players) {
      if(var_3 ismlgspectator()) {
        var_4 = var_3 getspectatingplayer();

        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();

          if(var_5 == var_6) {
            var_3 thread scripts\mp\rank::scorepointspopup(var_0);
            var_3 thread scripts\mp\rank::scoreeventpopup(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var_8 = 0;

    if(scripts\mp\utility\game::issimultaneouskillenabled()) {
      var_8 = var_1 == "kill";
    }

    thread scripts\mp\rank::scorepointspopup(var_0, var_8);
    return;
  }
}

function update_objective_setmlgbackground(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isstring(var_0)) {
    var_0 = getcompleteweaponname(var_0);
  }

  switch (var_0.basename) {
    case "tur_apc_rus_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
      return true;
  }

  return false;
}

function unset_relic_doomslayer(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isstring(var_0)) {
    var_0 = getcompleteweaponname(var_0);
  }

  switch (var_0.basename) {
    case "deploy_airdrop_mp":
    case "iw8_spotter_scope_mp":
    case "iw8_spotter_scope_mp_ch3":
    case "iw8_green_beam_mp":
    case "deploy_juggernaut_mp":
      return true;
  }

  return false;
}