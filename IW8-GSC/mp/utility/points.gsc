/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\points.gsc
***********************************************/

givestreakpointswithtext(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = scripts\mp\rank::getscoreinfovalue(var_0);

  var_3 = modifyunifiedpoints(var_0, var_3, var_1);
  scripts\mp\killstreaks\killstreaks::givestreakpoints(var_0, var_3);
  displayscoreeventpoints(var_3, var_0);
}

sec_sys_struct_1(var_0, var_1) {
  if(istrue(level.ignorescoring)) {
    return;
  }
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = scripts\mp\rank::getscoreinfovalue(var_0);

  thread scripts\mp\rank::giverankxp(var_0, var_2);
  thread scripts\mp\rank::scoreeventpopup(var_0);
}

giveunifiedpoints(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(istrue(level.ignorescoring) && !issubstr(var_0, "_encstr_A1BD075837DCD29B47") && !var_8) {
    return;
  }
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  if(isDefined(var_2))
    var_9 = var_2;
  else
    var_9 = scripts\mp\rank::getscoreinfovalue(var_0);

  scripts\mp\gamescore::giveplayerscore(var_0, var_9, var_4);
  var_9 = modifyunifiedpoints(var_0, var_9, var_1);

  if(isDefined(var_1)) {
    var_10 = scripts\mp\utility\weapon::mapweapon(var_1);
    var_11 = createheadicon(var_10);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_11, var_9, "_encstr_A1C3131D47FB01E9E10B58307307D7D907E2A81DA4");
  }

  if(isDefined(var_6))
    var_6.score = var_6.score + var_9;

  var_12 = var_0 == "_encstr_ABD70578F3D02C" || !scripts\mp\utility\game::matchmakinggame() && var_0 == "_encstr_92AE10AD275BC3CE4E047725C0377812A010";
  var_13 = scripts\mp\killstreaks\killstreaks::isbountyevent(var_0);
  var_14 = scripts\mp\killstreaks\killstreaks::iskillstreakkillevent(var_0);
  var_15 = istrue(self.isjuggernaut);
  var_16 = update_objective_setmlgbackground(var_1);
  var_17 = scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947");
  var_18 = !istrue(level.vocalloutstring);

  if((var_12 || var_14) && !scripts\mp\utility\perk::_hasperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC"))
    self.pers["_encstr_86CE0D1BA9C3F853B0B89B34E2EBB5"] = undefined;

  var_19 = var_14 && istrue(self.pers["_encstr_86CE0D1BA9C3F853B0B89B34E2EBB5"]) && istrue(var_5);

  if((var_12 || var_13 || var_19 || var_17) && (!var_15 || var_19 || var_17) && !var_16 && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && var_18) {
    if(scripts\cp_mp\utility\player_utility::_isalive())
      scripts\mp\killstreaks\killstreaks::givestreakpoints(var_0, 1, var_9);
  }

  if(isDefined(level._id_12073))
    [[level._id_12073]](self, var_9, var_0, var_7);

  scripts\mp\supers::givesuperpoints(var_9, var_0);

  if(!istrue(var_3)) {
    var_20 = var_9;
    thread scripts\mp\rank::giverankxp(var_0, var_20, var_1);
  }

  thread scripts\mp\events::killeventtextpopup(var_0, 0);
}

modifyunifiedpoints(var_0, var_1, var_2) {
  switch (var_0) {
    case "_encstr_B2BE0788BAF573592F":
      return 0;
    default:
      break;
  }

  var_3 = 0;
  var_1 = var_1 + var_3;

  if(isDefined(level.modifyunifiedpointscallback))
    var_1 = [[level.modifyunifiedpointscallback]](var_1, var_0, self, var_2);

  return int(var_1);
}

displayscoreeventpoints(var_0, var_1) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1) {
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

    if(scripts\mp\utility\game::issimultaneouskillenabled())
      var_8 = var_1 == "_encstr_ABD70578F3D02C";

    thread scripts\mp\rank::scorepointspopup(var_0, var_8);
  }
}

update_objective_setmlgbackground(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isstring(var_0))
    var_0 = getcompleteweaponname(var_0);

  switch (var_0.basename) {
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
      return 1;
  }

  return 0;
}

unset_relic_doomslayer(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isstring(var_0))
    var_0 = getcompleteweaponname(var_0);

  switch (var_0.basename) {
    case "_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683":
    case "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B":
    case "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817":
    case "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A":
    case "_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0":
      return 1;
  }

  return 0;
}