/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scoreboard.gsc
***********************************************/

processlobbyscoreboards() {
  _id_128B0();

  foreach(var_1 in level.players)
  _id_128A8(var_1);
}

_id_128B0() {
  if(level.multiteambased) {
    buildscoreboardtype("_encstr_99FA0AAD57B11D4B1D95C2D6");

    foreach(var_1 in level.players)
    var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", "_encstr_99FA0AAD57B11D4B1D95C2D6");

    if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
      setclientmatchdata("_encstr_BEFF0C0BA4DD880D7781C148BB07", -1);
      setclientmatchdata("_encstr_B15B0AC151E87AE71E589B92", -1);
      setclientmatchdata("_encstr_96010C581B362D56B9B42D1B636E", -1);
      setclientmatchdata("_encstr_83910D79C17844B79EA5622ACB7B97", -1);
      return;
    }
  } else if(level.teambased) {
    var_3 = getteamscore("_encstr_9A8507BA4040188D08");
    var_4 = getteamscore("_encstr_8E8405EA382B2A");
    var_5 = 0;
    var_6 = 0;

    foreach(var_1 in level.players) {
      if(isDefined(var_1.pers["_encstr_8AEF05472BC2D6"]) && var_1.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
        var_5 = var_5 + var_1.pers["_encstr_8E8D0697EB01F243"];
        var_6 = var_6 + var_1.pers["_encstr_8E0607055DBFB3919A"];
      }
    }

    var_9 = "_encstr_8D19048EA595";

    if(scripts\mp\utility\game::inovertime()) {
      if(scripts\mp\utility\game::istimetobeatrulegametype()) {
        if(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == "_encstr_8BBA05185F8B99") {
          if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
            setclientmatchdata("_encstr_B8A00A58C61B5A599B8A1512", 0);
            setclientmatchdata("_encstr_8AAA0816C3966E2AA884", 0);
          }

          var_9 = "_encstr_8D19048EA595";
        } else {
          if("_encstr_9A8507BA4040188D08" == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"])
            var_3++;
          else
            var_4++;

          if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
            setclientmatchdata("_encstr_B8A00A58C61B5A599B8A1512", scripts\engine\utility::ter_op("_encstr_9A8507BA4040188D08" == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
            setclientmatchdata("_encstr_8AAA0816C3966E2AA884", scripts\engine\utility::ter_op("_encstr_8E8405EA382B2A" == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_8AC00BAB7C452B05C2338B8B83"], game["_encstr_AD900E232359BABC98958F964BC1DCE2"]));
          }

          var_9 = game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"];
        }
      } else if(scripts\mp\utility\game::isscoretobeatrulegametype()) {}
    } else if(var_3 == var_4)
      var_9 = "_encstr_8D19048EA595";
    else if(var_3 > var_4)
      var_9 = "_encstr_9A8507BA4040188D08";
    else
      var_9 = "_encstr_8E8405EA382B2A";

    if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
      setclientmatchdata("_encstr_BEFF0C0BA4DD880D7781C148BB07", var_3);
      setclientmatchdata("_encstr_B15B0AC151E87AE71E589B92", var_4);
      setclientmatchdata("_encstr_96010C581B362D56B9B42D1B636E", var_5);
      setclientmatchdata("_encstr_83910D79C17844B79EA5622ACB7B97", var_6);
    }

    if(var_9 == "_encstr_8D19048EA595") {
      buildscoreboardtype("_encstr_9A8507BA4040188D08");
      buildscoreboardtype("_encstr_8E8405EA382B2A");

      foreach(var_1 in level.players) {
        var_11 = var_1.pers["_encstr_8AEF05472BC2D6"];

        if(!isDefined(var_11)) {
          continue;
        }
        if(var_11 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_11 == "_encstr_933E090A10B17DDFB3E522") {
          var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", "_encstr_9A8507BA4040188D08");
          continue;
        }

        var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", var_11);
      }

      return;
    }

    buildscoreboardtype(var_9);

    foreach(var_1 in level.players)
    var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", var_9);

    return;
  } else {
    buildscoreboardtype("_encstr_A7A408B9CA5D1D4E2C63");

    foreach(var_1 in level.players)
    var_1 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", "_encstr_A7A408B9CA5D1D4E2C63");

    if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
      setclientmatchdata("_encstr_BEFF0C0BA4DD880D7781C148BB07", -1);
      setclientmatchdata("_encstr_B15B0AC151E87AE71E589B92", -1);
      setclientmatchdata("_encstr_96010C581B362D56B9B42D1B636E", -1);
      setclientmatchdata("_encstr_83910D79C17844B79EA5622ACB7B97", -1);
    }
  }
}

_id_128A8(var_0) {
  if(isDefined(var_0.pers["_encstr_AA3B085BC34075B70E12"])) {
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AA36085CF78876831B33", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_ACF308A776873D952171", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8E370CD778566831971A1941611B", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_B682087A81953FAC7921", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A5DB07D65ADC361683", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AC3108F0CA876328CBC0", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"]);
    var_0 setplayerdata("_encstr_927C07D787E1823F38", "_encstr_954016D8EDB56BF6DCFA59E61DD23AD8CA6BB2B93AEB87C1", var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"]);
  }
}

setplayerscoreboardinfo() {
  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") == 0) {
    return;
  }
  var_0 = getclientmatchdata("_encstr_B14F16272F50C385C838965A3131C48A334BBB6F8F85CA6C");

  if(var_0 < 200) {
    if(isDefined(self.pers["_encstr_82FB06EB26785BD7"]))
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_82FB06EB26785BD7", self.pers["_encstr_82FB06EB26785BD7"]);

    if(isDefined(self.pers["_encstr_8E8D0697EB01F243"])) {
      var_1 = self.pers["_encstr_8E8D0697EB01F243"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8E8D0697EB01F243", var_1);
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_9707038CB6" || scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75")
      var_2 = self.assists;
    else if(isDefined(self.pers["_encstr_A1F308589BCD96CD476E"]))
      var_2 = self.pers["_encstr_A1F308589BCD96CD476E"];
    else
      var_2 = 0;

    setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_A1F308589BCD96CD476E", var_2);

    if(isDefined(self.pers["_encstr_8E0607055DBFB3919A"])) {
      var_3 = self.pers["_encstr_8E0607055DBFB3919A"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8E0607055DBFB3919A", var_3);
    }

    if(isDefined(self.pers["_encstr_8AEF05472BC2D6"])) {
      var_4 = self.pers["_encstr_8AEF05472BC2D6"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8AEF05472BC2D6", var_4);

      if(isDefined(game[self.pers["_encstr_8AEF05472BC2D6"]])) {
        var_5 = game[self.pers["_encstr_8AEF05472BC2D6"]];
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8D020899588DA3A5DB37", var_5);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      if(isDefined(self.playercardbackground)) {
        var_6 = self.playercardbackground;
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8A220C2BC3474E0BB9B17B9CB203", var_6);
      }
    } else if(isDefined(self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"])) {
      var_7 = self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_8A220C2BC3474E0BB9B17B9CB203", var_7);
    }

    if(isDefined(self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"])) {
      var_8 = self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_84220CB23C8E9CC2CD36DB27AC4C", var_8);
    }

    if(isDefined(self.timeplayed["_encstr_BE7D0633C08849E2"])) {
      var_9 = self.timeplayed["_encstr_BE7D0633C08849E2"];
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_881A0B47B4B6B2386316E59532", var_9);
    }

    if(isDefined(self.pers["_encstr_A51F05CB11A052"]) && isDefined(self.pers["_encstr_851207B317B203FA5A"])) {
      var_10 = scripts\mp\rank::getrank();
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_A51F05CB11A052", var_10);
    }

    if(isDefined(self.pers["_encstr_A1ED09400BA5D351227715"])) {
      var_11 = scripts\mp\rank::getprestigelevel();
      setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_A1ED09400BA5D351227715", var_11);
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      var_12 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::forest_barrel_damage_watch(self);

      for(var_13 = 0; var_13 < var_12.size; var_13++) {
        var_14 = "_encstr_856B0B8A18314A57A376AFCA1D" + var_13;
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, var_14, var_12[var_13]);
      }

      var_15 = scripts\mp\utility\game::round_vehicle_logic();

      if(var_15 == "_encstr_BE180419DAE9" || var_15 == "_encstr_8AE1099A0B999F2D28AF15" || var_15 == "_encstr_9B1F05BE4B9B52" || var_15 == "_encstr_866209ECEDB1197DEE0B4E") {
        var_16 = scripts\mp\gamescore::run_common_functions_stealth();
        var_17 = var_16[self.team];
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_99480A2B48EBFEB7B0A57E7C", var_17);
        var_18 = _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_121B4();
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_AA220C89385CB89F03B79FADC71F", var_18);
        var_19 = 0;

        if(isDefined(self._id_11A01))
          var_19 = self._id_11A01;

        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_97220CBD689B1D2AABF7B20217B3", var_19);
      } else if(var_15 == "_encstr_B18D0B5281530117EDEAC82033") {
        var_16 = scripts\mp\gamescore::run_common_functions_stealth();
        var_17 = var_16[self.team];
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_99480A2B48EBFEB7B0A57E7C", var_17);
        var_18 = _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::_id_121B4();
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_AA220C89385CB89F03B79FADC71F", var_18);
        var_19 = 0;

        if(isDefined(self._id_11A01))
          var_19 = self._id_11A01;

        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_97220CBD689B1D2AABF7B20217B3", var_19);
      } else if(var_15 == "_encstr_B4F40EE8C95685E657C92BAF43EA731D") {
        if(isDefined(self._id_13AB8))
          setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_99480A2B48EBFEB7B0A57E7C", self._id_13AB8);

        var_18 = _encstr_A238334E2ED323E39C2FA2B80BEF596B4AD745D3421ADFC0723319F037F5D189D33AB548DB834B714BC778E8E718EBC5AB353CE6F6::_id_121B2();
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_AA220C89385CB89F03B79FADC71F", var_18);
      } else if(var_15 == "_encstr_A254085207A6B7334B5A" || var_15 == "_encstr_AD300C932B4C969CD1D0AF911346") {
        if(isDefined(self._id_13AB8))
          setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_99480A2B48EBFEB7B0A57E7C", self._id_13AB8);

        var_18 = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::end_health();
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_AA220C89385CB89F03B79FADC71F", var_18);
      } else if(var_15 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_15 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") {} else if(isDefined(self._id_13AB8))
        setclientmatchdata("_encstr_9775086022BE1B413B8B", self.clientmatchdataid, "_encstr_99480A2B48EBFEB7B0A57E7C", self._id_13AB8);
    }

    var_0++;
    setclientmatchdata("_encstr_B14F16272F50C385C838965A3131C48A334BBB6F8F85CA6C", var_0);
  } else {}
}

computescoreboardslot(var_0, var_1) {
  if(var_0 == "_encstr_8BBA05185F8B99")
    return 0 + var_1;

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    return 200 + var_1;

  if(var_0 == "_encstr_9A8507BA4040188D08")
    return 400 + var_1;

  if(var_0 == "_encstr_8E8405EA382B2A")
    return 600 + var_1;

  if(var_0 == "_encstr_99FA0AAD57B11D4B1D95C2D6")
    return 800 + var_1;

  return 0;
}

buildscoreboardtype(var_0) {
  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") == 0) {
    return;
  }
  if(var_0 == "_encstr_99FA0AAD57B11D4B1D95C2D6") {
    var_1 = 0;

    foreach(var_3 in level.teamnamelist) {
      if(scripts\mp\menus::shouldmodesetsquads()) {
        foreach(var_5 in level.squaddata[var_3]) {
          if(!var_5.inuse) {
            continue;
          }
          var_6 = undefined;

          if(isDefined(level.placement) && isDefined(level.placement[var_3]))
            var_6 = level.placement[var_3][var_5.index];

          if(!isDefined(var_6))
            var_6 = var_5.players;

          foreach(var_8 in var_5.players) {
            scripts\mp\gamelogic::cargo_truck_mg_explode(var_8);
            setclientmatchdata("_encstr_B6550CF8EF0F13937295F7062F1B", computescoreboardslot("_encstr_99FA0AAD57B11D4B1D95C2D6", var_1), var_8.clientmatchdataid);
            var_1++;
          }
        }

        continue;
      }

      var_6 = undefined;

      if(isDefined(level.placement))
        var_6 = level.placement[var_3];

      if(!isDefined(var_6))
        var_6 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B");

      foreach(var_8 in var_6) {
        scripts\mp\gamelogic::cargo_truck_mg_explode(var_8);
        setclientmatchdata("_encstr_B6550CF8EF0F13937295F7062F1B", computescoreboardslot("_encstr_99FA0AAD57B11D4B1D95C2D6", var_1), var_8.clientmatchdataid);
        var_1++;
      }
    }
  } else if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    var_1 = 0;

    foreach(var_8 in level.placement["_encstr_AF1904A7F929"]) {
      setclientmatchdata("_encstr_B6550CF8EF0F13937295F7062F1B", computescoreboardslot(var_0, var_1), var_8.clientmatchdataid);
      var_1++;
    }
  } else {
    var_16 = scripts\mp\utility\game::getotherteam(var_0)[0];
    var_1 = 0;

    foreach(var_8 in level.placement[var_0]) {
      setclientmatchdata("_encstr_B6550CF8EF0F13937295F7062F1B", computescoreboardslot(var_0, var_1), var_8.clientmatchdataid);
      var_1++;
    }

    foreach(var_8 in level.placement[var_16]) {
      setclientmatchdata("_encstr_B6550CF8EF0F13937295F7062F1B", computescoreboardslot(var_0, var_1), var_8.clientmatchdataid);
      var_1++;
    }
  }
}