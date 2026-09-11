/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\points.gsc
***********************************************/

function givestreakpointswithtext(var0, var1, var2) {
  if(istrue(level.ignorescoring)) {
    return;
  }

  if(isDefined(var2)) {
    var3 = var2;
  } else {
    var3 = scripts\mp\rank::getscoreinfovalue(var1);
  }

  var3 = modifyunifiedpoints(var1, var3, var2);
  scripts\mp\killstreaks\killstreaks::givestreakpoints(var1, var3);
  displayscoreeventpoints(var3, var1);
}

function sec_sys_struct_1(var0, var1) {
  if(istrue(level.ignorescoring)) {
    return;
  }

  var2 = undefined;

  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = scripts\mp\rank::getscoreinfovalue(var0);
  }

  thread scripts\mp\rank::giverankxp(var0, var2);
  thread scripts\mp\rank::scoreeventpopup(var0);
}

function giveunifiedpoints(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done");

  if(istrue(level.ignorescoring) && !issubstr(var0, "assist") && !var8) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(var2)) {
    var9 = var2;
  } else {
    var9 = scripts\mp\rank::getscoreinfovalue(var1);
  }

  scripts\mp\gamescore::giveplayerscore(var1, var9, var5);
  var9 = modifyunifiedpoints(var1, var9, var2);

  if(isDefined(var2)) {
    var10 = scripts\mp\utility\weapon::mapweapon(var2);
    var11 = createheadicon(var10);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var11, var9, "total_score_earned");
  }

  if(isDefined(var7)) {
    var7.score += var9;
  }

  var12 = var1 == "kill" || !scripts\mp\utility\game::matchmakinggame() && var1 == "last_stand_kill";
  var13 = scripts\mp\killstreaks\killstreaks::isbountyevent(var1);
  var14 = scripts\mp\killstreaks\killstreaks::iskillstreakkillevent(var1);
  var15 = istrue(self.isjuggernaut);
  var16 = update_objective_setmlgbackground(var2);
  var17 = scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak");
  var18 = !istrue(level.vocalloutstring);

  if((var12 || var14) && !scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {
    self.pers["canKillChain"] = undefined;
  }

  var19 = var14 && istrue(self.pers["canKillChain"]) && istrue(var6);

  if((var12 || var13 || var19 || var17) && (!var15 || var19 || var17) && !var16 && scripts\mp\utility\game::getgametype() != "br" && var18) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      scripts\mp\killstreaks\killstreaks::givestreakpoints(var1, 1, var9);
    }
  }

  if(isDefined(level.ref_12073)) {
    [[level.ref_12073]](self, var9, var1, var8);
  }

  scripts\mp\supers::givesuperpoints(var9, var1);

  if(!istrue(var4)) {
    var20 = var9;
    thread scripts\mp\rank::giverankxp(var1, var20, var2);
  }

  thread scripts\mp\events::killeventtextpopup(var1, 0);
}

function modifyunifiedpoints(var0, var1, var2) {
  switch (var0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var3 = 0;
  var1 += var3;

  if(isDefined(level.modifyunifiedpointscallback)) {
    var1 = [[level.modifyunifiedpointscallback]](var1, var0, self, var2);
  }

  return int(var1);
}

function displayscoreeventpoints(var0, var1) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(level.codcasterenabled) {
    foreach(var3 in level.players) {
      if(var3 ismlgspectator()) {
        var4 = var3 getspectatingplayer();

        if(isDefined(var4)) {
          var5 = var4 getentitynumber();
          var6 = self getentitynumber();

          if(var5 == var6) {
            var3 thread scripts\mp\rank::scorepointspopup(var0);
            var3 thread scripts\mp\rank::scoreeventpopup(var1);
          }
        }
      }
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var8 = 0;

    if(scripts\mp\utility\game::issimultaneouskillenabled()) {
      var8 = var1 == "kill";
    }

    thread scripts\mp\rank::scorepointspopup(var0, var8);
    return;
  }
}

function update_objective_setmlgbackground(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isstring(var0)) {
    var0 = getcompleteweaponname(var0);
  }

  switch (var0.basename) {
    case "tur_apc_rus_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
      return true;
  }

  return false;
}

function unset_relic_doomslayer(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isstring(var0)) {
    var0 = getcompleteweaponname(var0);
  }

  switch (var0.basename) {
    case "deploy_airdrop_mp":
    case "iw8_spotter_scope_mp":
    case "iw8_spotter_scope_mp_ch3":
    case "iw8_green_beam_mp":
    case "deploy_juggernaut_mp":
      return true;
  }

  return false;
}