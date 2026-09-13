/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4b51efc61b1c7ecf.gsc
***********************************************/

_id_107CEEC27ED3A473() {
  level thread _id_10F2F023F5565883();
  level thread _id_F55B1442AC75C589();
  level thread _id_F79BCC103DF0213A();
  level thread _id_9ACAA5F92C5261BD();
  level thread _id_F188849BD08F22D6();
  level thread _id_F3F2BC8E927991C4();
  level thread _id_3BE2EC6FAF39608C();
  level thread _id_7B6C5DD0845DBE56();
  level thread _id_1716CDE914106554();
  level thread _id_C5BCA194BAD2108C();
  level thread _id_BE434B8D9CD15E21();
  level thread _id_135AB43D3A20551F();
  scripts\engine\utility::flag_wait("intro_completed");
  level thread _id_507388E2F9D4526D();
  level thread _id_D3C1CE46DB195DA5();
  level thread _id_3E88AE4D0B868B9F();
  level thread _id_5505F3019DBEE526();
  level thread _id_95E8B2E35D399C8C();
  level thread _id_98F26E3CCDD73E84();
  level thread _id_60391AD3EC3CC4B3();
  level thread _id_E49ABB8107CF9C20();
  level thread _id_BDC838725A6B2972();
  level thread _id_092FBA02E84DFB3C();
  level thread _id_A60EF0D72EC9A644();
  level thread _id_5CBAE0F67D11A3D1();
  level thread _id_751E193E4D1F6FF2();
  level thread _id_99330A19E0ACAA05();
  level thread _id_2E0C9F3B6E655703();
  level thread _id_F902F98E99291610();
  level._id_E4457DA98181E336 = 0;
  level._id_0440A96296312FCD = 1;
}

_id_775CD164C569E279(alias, player) {
  level endon("game_ended");

  if(istrue(level.gameended)) {
    return;
  }
  _id_46F432042B3473D8 = _id_166B4F052DA169A7::get_sound_length(alias);
  waittime = gettime() + _id_46F432042B3473D8 + 3000;

  while((istrue(level._id_BFE5BB3BA83502E3) || istrue(level._id_7928AD1454C83E37)) && gettime() < waittime)
    waitframe();

  thread _id_011076D277676A63(_id_46F432042B3473D8);
  wait 0.1;

  if(isDefined(player)) {
    player.bcdisabled = 1;
    player _id_166B4F052DA169A7::try_to_play_vo(alias, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    player.bcdisabled = undefined;
  } else {
    foreach(player in level.players)
    player.bcdisabled = 1;

    level _id_166B4F052DA169A7::try_to_play_vo_on_team(alias, "allies");

    foreach(player in level.players)
    player.bcdisabled = undefined;
  }
}

_id_011076D277676A63(_id_46F432042B3473D8) {
  level endon("game_ended");
  level._id_BFE5BB3BA83502E3 = 1;
  wait(_id_46F432042B3473D8 + 0.5);
  level._id_BFE5BB3BA83502E3 = 0;
}

_id_23F764E736E39B94() {
  thread _id_221688A427C71B43();
  level endon("game_ended");
  level._id_72FAACD99FC4CC0E = 1;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_comradesthecavalryha");
  _id_775CD164C569E279("dx_cp_cpes_gifb_lasw_rightontimenikwelcom");
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_thanksfortheinvitela");
  wait 0.5;
  _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gifb_lasw_breaker1yankee7isons", "dx_cp_cpes_gifb_lasw_breaker1yourairsuppo"]));
  wait 0.5;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_breakerihavemissiles");
  wait 2;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_threatsneutralized");
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_hopeyouenjoyedthefir");
  wait 1.2;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_yankee7tobreaker1iha");
  wait 1;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_iwilldrawtokeepthemo");
  wait 1;
  _id_775CD164C569E279("dx_cp_cpes_gifb_niko_seeyouontheotherside");
  wait 1;
  _id_775CD164C569E279("dx_cp_cpes_gifb_lasw_breaker1thetargetgri");
  wait 1;

  foreach(player in level.players) {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BCA5E472447F8C73");
    wait 1;
  }

  level._id_72FAACD99FC4CC0E = undefined;
}

_id_7B6C5DD0845DBE56() {
  level endon("alertall");
  level endon("intro_completed");
  level endon("game_ended");

  for(;;) {
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(enemies.size > 10) {
      break;
    }

    wait 1;
  }

  wait 5;

  for(;;) {
    wait 1;
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(enemies.size > 0) {
      continue;
    }
    break;
  }

  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_goodwork");
  wait 1;

  foreach(player in level.players)
  scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[1], "stat_66D4835263B12EE1");

  wait 2;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_nowsetyourchargeonth");
}

_id_9ACAA5F92C5261BD() {
  level endon("game_ended");

  for(;;) {
    players = [];

    foreach(player in level.players)
    player._id_6E3257DCBA2C4998 = player.origin;

    wait(randomintrange(25, 45));

    foreach(player in level.players) {
      if(!isDefined(player._id_6E3257DCBA2C4998)) {
        player._id_6E3257DCBA2C4998 = player.origin;
        continue;
      }

      if(distancesquared(player.origin, player._id_6E3257DCBA2C4998) < squared(50)) {
        player thread _id_233A203E7E1CA4FA();
        continue;
      }

      return;
    }

    wait 1;
  }
}

_id_233A203E7E1CA4FA() {
  _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_ntro_lasw_breakerweneedtomoveq", "dx_cp_cpes_ntro_lasw_gettothetargetnow"]), self);
}

_id_D54228D3ECC90EAD() {
  level endon("game_ended");
  level endon("alertall");

  for(;;) {
    wait 0.05;

    if(!scripts\cp\utility::any_player_nearby((29656, 24352, 6832), squared(2100))) {
      continue;
    }
    if(istrue(level._id_704409D0747082DA)) {
      wait 0.5;
      continue;
    }

    alive = _id_0ADE6B081087938F();

    if(!alive) {
      return;
    }
    _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_youreapproachingthea");
    return;
  }
}

_id_0ADE6B081087938F() {
  alive = 0;

  foreach(guy in level._id_D0171628A971E82E) {
    if(!isalive(guy)) {
      continue;
    }
    alive = 1;
  }

  return alive;
}

_id_F3F2BC8E927991C4() {
  level endon("alertall");
  level endon("game_ended");
  wait 5;
  level thread _id_D54228D3ECC90EAD();
  level thread _id_CD0BC2DE74FD69D8();

  for(;;) {
    wait 0.2;

    if(istrue(level._id_704409D0747082DA)) {
      continue;
    }
    alive = _id_0ADE6B081087938F();

    if(!alive) {
      level notify("shackEnemiesKilled");

      while(istrue(level._id_BFE5BB3BA83502E3) || istrue(level._id_7928AD1454C83E37))
        wait 1;

      wait 0.5;
      scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[0], "stat_29C83D721F765AB4");
      wait 1;

      if(isDefined(level.players[1])) {
        scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[1], "stat_43C7DD1F0AD4B4AF");
        wait 1;
      }

      wait 0.25;
      _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_letsnotgettooexcited");
      wait 0.25;
      _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_theresaqtroopsstatio");
      wait 0.5;
      _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_takeanyammoorsupplie");
      wait 1;

      foreach(player in level.players) {
        scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_BCA5E472447F8C73");
        wait 1;
      }

      return;
    }
  }
}

_id_CD0BC2DE74FD69D8() {
  level endon("alertall");
  level endon("nearshack");
  level thread _id_B510D7F75D557A2C();

  for(;;) {
    wait 1;

    while(istrue(level._id_704409D0747082DA))
      wait 0.5;

    _id_6A617CDAE1A1625F = 0;

    foreach(player in level.players) {
      if(player.origin[1] < 23700 || player.origin[0] < 29000) {
        _id_8DD2942A05ACACFB = ["dx_cp_cpes_ntro_lasw_imseeingaguardshackn", "dx_cp_cpes_ntro_lasw_makesurethatguardsha", "dx_cp_cpes_ntro_lasw_dontpassupthatguards"];
        _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB), player);
        _id_6A617CDAE1A1625F = 1;
      }
    }

    if(_id_6A617CDAE1A1625F)
      return;
  }
}

_id_B510D7F75D557A2C() {
  level endon("alertall");

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby((29656, 24352, 6832), squared(250))) {
      wait 1;
      continue;
    }

    level notify("nearshack");
    return;
  }
}

_id_F188849BD08F22D6() {
  level endon("game_ended");

  for(;;) {
    level waittill("geiger_given", player);
    player thread _id_7CA964044E68AE74();
  }
}

_id_7CA964044E68AE74() {
  self endon("disconnect");
  level endon("alertall");
  wait 0.5;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_518DBCC3021DB184");
  wait 4;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_thatsgoodtohave", self);
  wait(_id_166B4F052DA169A7::get_sound_length("dx_cp_cpes_ntro_lasw_thatsgoodtohave") + 0.5);
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_keepittomonitorthear", self);
  wait(_id_166B4F052DA169A7::get_sound_length("dx_cp_cpes_ntro_lasw_keepittomonitorthear") + 0.5);
  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_BCA5E472447F8C73");
}

_id_3BE2EC6FAF39608C() {
  level endon("game_ended");
  trigger = getEnt("intro_samsiteverify", "targetname");
  trigger endon("death");

  while(!isDefined(level._id_065B39A7501C708E))
    wait 1;

  level._id_065B39A7501C708E endon("samsite_dead");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent) && !isDefined(ent.owner) || !isPlayer(ent.owner)) {
      continue;
    }
    if(istrue(ent._id_91368EBC2C0F042F)) {
      continue;
    }
    thread _id_798388DA55825D94(ent);
  }
}

_id_798388DA55825D94(ent) {
  ent._id_91368EBC2C0F042F = 1;

  if(isPlayer(ent)) {
    ent endon("death");
    _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_ntro_lasw_11yourenotmovingtowa", "dx_cp_cpes_ntro_lasw_12yourewideofyourmar", "dx_cp_cpes_ntro_lasw_breaker1getbackonmis"]), ent);
  } else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
    ent.owner endon("death");
    _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_ntro_lasw_11yourenotmovingtowa", "dx_cp_cpes_ntro_lasw_12yourewideofyourmar", "dx_cp_cpes_ntro_lasw_breaker1getbackonmis"]), ent.owner);
  }

  wait(randomintrange(15, 25));
  ent._id_91368EBC2C0F042F = undefined;
}

intro_dialogue() {
  level endon("game_ended");
  level endon("alertall");
  level endon("shackEnemiesKilled");
  level._id_704409D0747082DA = 1;
  wait 5;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_watcher1tobreakeryou");
  wait 1.5;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_yourfirstsamsitetarg");
  wait 2.5;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_yourecleartoengageal");
  wait 2;

  foreach(_id_87703F9F647EC52A in level.players) {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_87703F9F647EC52A, "stat_BCA5E472447F8C73");
    wait 1;
  }

  wait 0.5;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[0], "stat_59169AED8D3F8D14");
  wait 1.5;
  level._id_704409D0747082DA = 0;
}

_id_2315572ABC059BA1() {
  level endon("game_ended");
  self endon("death");
  _id_1313DF0E598A68EC = 0;
  level._id_FD5CEA4AD8370C36 = 1;

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < squared(6000)) {
        switch (self._id_D91F12B76628F311) {
          case "a":
            thread _id_EECFF0A87B66BB4A();
            _id_775CD164C569E279("dx_cp_cpes_gs2o_lasw_breaker1youareapproa");
            wait 1.5;
            _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1o_niko_iwilldrawfirefromtho", "dx_cp_cpes_gs1o_niko_whileyouengagethegro"]));
            wait 1.5;

            foreach(_id_87703F9F647EC52A in level.players) {
              scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_87703F9F647EC52A, "stat_BCA5E472447F8C73");
              wait 1;
            }

            wait 1.5;

            if(level._id_FD5CEA4AD8370C36) {
              _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1o_lasw_alrightbreaker1theyk_01", "dx_cp_cpes_gs1o_lasw_therellbenostealthhe_01", "dx_cp_cpes_gs1o_lasw_breaker1preparetorec_01"]));
              level._id_FD5CEA4AD8370C36 = 0;
            }

            break;
          case "b":
            thread _id_D6FFB86E492A8DC5();
            _id_775CD164C569E279("dx_cp_cpes_gs2o_lasw_breaker1youreapproac");
            _id_775CD164C569E279("dx_cp_cpes_gs1o_niko_allstationsihaveeyes_02");
            wait 0.25;
            _id_775CD164C569E279("dx_cp_cpes_gs1o_niko_iwilldrawfirefromthe");
            wait 0.5;

            foreach(_id_87703F9F647EC52A in level.players) {
              scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_87703F9F647EC52A, "stat_BCA5E472447F8C73");
              wait 1;
            }

            wait 1.5;

            if(level._id_FD5CEA4AD8370C36) {
              _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1o_lasw_alrightbreaker1theyk_01", "dx_cp_cpes_gs1o_lasw_therellbenostealthhe_01", "dx_cp_cpes_gs1o_lasw_breaker1preparetorec_01"]));
              level._id_FD5CEA4AD8370C36 = 0;
            }

            break;
          case "c":
            thread _id_EE0ACDD78017BFF0();
            _id_775CD164C569E279("dx_cp_cpes_gs2o_lasw_breaker1youreapproac_01");
            wait 1.5;

            if(level._id_FD5CEA4AD8370C36) {
              _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1o_lasw_alrightbreaker1theyk_01", "dx_cp_cpes_gs1o_lasw_therellbenostealthhe_01", "dx_cp_cpes_gs1o_lasw_breaker1preparetorec_01"]));
              level._id_FD5CEA4AD8370C36 = 0;
            }

            break;
        }

        return;
      }
    }

    wait 0.15;
  }
}

_id_507388E2F9D4526D() {
  level endon("game_ended");
  level endon("ready_to_escape");

  for(;;) {
    level waittill("spawned_vehicle", _id_FA890E641F17EA50);

    if(isDefined(_id_FA890E641F17EA50) && _id_FA890E641F17EA50 == "little_bird") {
      continue;
    }
    _id_775CD164C569E279("dx_cp_cpes_cveh_lasw_breakersbeadvisedyan");
    return;
  }
}

player_isshooting() {
  if(isDefined(self.lastweaponfiretimestart))
    return gettime() - self.lastweaponfiretimestart < 400;
  else
    return 0;
}

_id_D3C1CE46DB195DA5() {
  level endon("game_ended");

  for(;;) {
    level waittill("samsiteDestroyed", _id_D91F12B76628F311);

    if(!istrue(level._id_8C876D36B2B7C949)) {
      switch (_id_D91F12B76628F311) {
        case "a":
          _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1c_lasw_targetbravoisoffline", "dx_cp_cpes_gs1c_lasw_bravoisdowngreatwork"]));
          wait 1;
          _id_775CD164C569E279("dx_cp_cpes_gs1c_lasw_yankee7bravoisdestro");
          wait 0.5;
          _id_775CD164C569E279("dx_cp_cpes_gs1c_niko_myunendingpleasurela");

          if(level._id_358AB8DF65CBB5B4 < 3) {
            _id_8DD2942A05ACACFB = [];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "b"))
              _id_8DD2942A05ACACFB = ["dx_cp_cpes_gs1c_lasw_breaker1continuetota"];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "c"))
              _id_8DD2942A05ACACFB = scripts\engine\utility::array_add(_id_8DD2942A05ACACFB, "dx_cp_cpes_gs1c_lasw_breaker1continuetota_01");

            if(_id_8DD2942A05ACACFB.size)
              _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
          }

          break;
        case "b":
          _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1c_lasw_targetcharlieisoffli", "dx_cp_cpes_gs1c_lasw_charlieisdowngoodwor"]));
          wait 1;
          _id_775CD164C569E279("dx_cp_cpes_gs1c_lasw_yankee7charlieisdone");
          wait 0.5;
          _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1c_niko_thatwasfast", "dx_cp_cpes_gs1c_niko_iamdoingjustfinethan", "dx_cp_cpes_gs1c_niko_iwelcomethisnews"]));

          if(level._id_358AB8DF65CBB5B4 < 3) {
            _id_8DD2942A05ACACFB = [];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "a"))
              _id_8DD2942A05ACACFB = ["dx_cp_cpes_gs1c_lasw_breaker1continuetota_02"];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "c"))
              _id_8DD2942A05ACACFB = scripts\engine\utility::array_add(_id_8DD2942A05ACACFB, "dx_cp_cpes_gs1c_lasw_breaker1pushtotarget");

            if(_id_8DD2942A05ACACFB.size)
              _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
          }

          break;
        case "c":
          _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1c_lasw_targetdeltaisoffline", "dx_cp_cpes_gs1c_lasw_deltaisdowngoodwork"]));
          wait 1;
          _id_775CD164C569E279("dx_cp_cpes_gs1c_lasw_yankee7deltaisdestro");
          wait 0.5;
          _id_775CD164C569E279("dx_cp_cpes_gs1c_niko_ilovemywork");

          if(level._id_358AB8DF65CBB5B4 < 3) {
            _id_8DD2942A05ACACFB = [];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "a"))
              _id_8DD2942A05ACACFB = ["dx_cp_cpes_gs1c_lasw_breaker1continuetota_03"];

            if(!scripts\engine\utility::array_contains(game["samsites_completed"], "b"))
              _id_8DD2942A05ACACFB = scripts\engine\utility::array_add(_id_8DD2942A05ACACFB, "dx_cp_cpes_gs1c_lasw_breaker1continuetota_04");

            if(_id_8DD2942A05ACACFB.size)
              _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
          }

          break;
      }
    }

    wait 1.5;

    if(scripts\engine\utility::flag_exist("sites_destroyed") && scripts\engine\utility::flag("sites_destroyed")) {
      if(!istrue(level._id_8C876D36B2B7C949)) {
        level._id_364D5EFBFB7D1FAC = 1;
        _id_775CD164C569E279("dx_cp_cpes_gs3c_lasw_allstationsthisiswat");
        wait 3;
        _id_775CD164C569E279("dx_cp_cpes_gexf_lasw_thisjobsonlyhalfdone");
        wait 2;
        _id_775CD164C569E279("dx_cp_cpes_gexf_lasw_yankee7yourecleartot");
        wait 2;
        _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gexf_niko_perfecttiming", "dx_cp_cpes_gexf_niko_clockwork", "dx_cp_cpes_gexf_niko_copythat"]));
        wait 1;
        level._id_364D5EFBFB7D1FAC = 0;
        scripts\engine\utility::flag_wait("leaving_final_samsite");
      }

      level notify("start_exfil_nag");
      return;
    }
  }
}

_id_99330A19E0ACAA05() {
  level endon("game_ended");
  level endon("exfil_plane_spawned");
  scripts\engine\utility::flag_wait("ready_to_escape");
  level waittill("start_exfil_nag");

  while(istrue(level.isteamvoplaying))
    wait 0.05;

  wait 2;
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_gexf_lasw_breaker1lzcoordinate", "dx_cp_cpes_gexf_lasw_lzcoordinatesaremark", "dx_cp_cpes_gexf_lasw_youneedtogettothelzn", "dx_cp_cpes_gexf_lasw_gettotheextractionpo", "dx_cp_cpes_gexf_niko_whatthefuckistakings", "dx_cp_cpes_gexf_lasw_allbreakersmovetothe"];
  index = 0;

  for(;;) {
    wait(randomintrange(30, 60));

    while(istrue(level.isteamvoplaying))
      wait 0.05;

    if(randomint(100) > 50) {
      _id_775CD164C569E279(_id_8DD2942A05ACACFB[index]);
      index++;

      if(index >= _id_8DD2942A05ACACFB.size)
        index = 0;
    }
  }
}

_id_2E0C9F3B6E655703() {
  level endon("game_ended");
  level endon("escaped");
  level waittill("exfil_plane_spawned");
  wait 1;
  level._id_BDB99233B8F43C69 = 1;
  _id_775CD164C569E279("dx_cp_cpes_gexf_niko_yankee7enroutetothel");
  wait 5;
  _id_775CD164C569E279("dx_cp_cpes_gexf_niko_yankee7iswheelsdowna");
  _id_775CD164C569E279("dx_cp_cpes_gexf_niko_doorsopenletsgetthef");
  level._id_BDB99233B8F43C69 = undefined;
  _id_988E5674E990E8DA = ["dx_cp_cpes_gexf_niko_doorsopenletsroll"];
  _id_7E9DB673BE8E096F = ["dx_cp_cpes_gexf_niko_doorsopendriveonin", "dx_cp_cpes_gexf_niko_driveintothecargohol", "dx_cp_cpes_gexf_niko_driverightintothecar"];
  _id_88B5692C4CD79FCD = ["dx_cp_cpes_gexf_niko_doorsopenletsgetthef", "dx_cp_cpes_gexf_niko_doorsopenletsroll", "dx_cp_cpes_gexf_niko_plentyofroominbackfr"];

  for(;;) {
    wait(randomintrange(60, 75));
    player = level.c130 scripts\cp\utility::get_closest_living_player();

    if(distance(player.origin, level.c130.origin) > 1024) {
      _id_775CD164C569E279(scripts\engine\utility::random(_id_988E5674E990E8DA), player);
      continue;
    }

    if(isDefined(player.vehicle)) {
      _id_775CD164C569E279(scripts\engine\utility::random(_id_7E9DB673BE8E096F), player);
      continue;
    }

    _id_775CD164C569E279(scripts\engine\utility::random(_id_88B5692C4CD79FCD), player);
  }
}

_id_F902F98E99291610() {
  level endon("game_ended");
  level waittill("escaped");
  _id_775CD164C569E279("dx_cp_cpes_gexf_niko_welcomeaboardbreaker");
  wait 0.5;
  _id_775CD164C569E279("dx_cp_cpes_gexf_niko_laswellyourteamsload");
  wait 0.25;
  _id_775CD164C569E279("dx_cp_cpes_gexf_lasw_rogerthatmissionacco");
  wait 0.5;
  _id_775CD164C569E279("dx_cp_cpes_mcom_niko_copythatcallmeanytim");
}

_id_3E88AE4D0B868B9F() {
  level endon("game_ended");
  level waittill("dropping_bombs");
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_gs1c_lasw_breaker1eyesopenfort", "dx_cp_cpes_gs1c_lasw_watchoutforthosemine"];
  _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
}

_id_5505F3019DBEE526() {
  level endon("game_ended");
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_gs1c_lasw_carefulaqsgotminesdo", "dx_cp_cpes_gs1t_lasw_breakerstayclearofth", "dx_cp_cpes_gs1t_lasw_watchyourselvesoutth"];
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("c4_damaged");

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
    _id_A6A6A0EDBC6E329A = gettime() + 15000;
  }
}

_id_95E8B2E35D399C8C() {
  level endon("game_ended");
  _id_0592094E64D7A7E0 = ["dx_cp_cpes_gs1t_niko_breaker1beadvisedene", "dx_cp_cpes_gs1t_niko_breakersbeadvisedyou"];
  _id_A6A6A0EDBC6E329A = gettime();
  _id_4BC5FEE4300B6905 = 1;

  for(;;) {
    msg = level scripts\engine\utility::waittill_any_return_2("heli_inbound", "spawn_apache");

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    while(istrue(level._id_72FAACD99FC4CC0E) || istrue(level._id_BDB99233B8F43C69))
      wait 1;

    if(msg == "heli_inbound") {
      level._id_E4457DA98181E336 = 0;
      wait 2;

      if(istrue(_id_4BC5FEE4300B6905)) {
        thread _id_7DD903F3E30E81D6();
        _id_775CD164C569E279("dx_cp_cpes_cbhl_lasw_breaker1radarshowsan");
        _id_4BC5FEE4300B6905 = 0;
      } else
        _id_775CD164C569E279(scripts\engine\utility::random(_id_0592094E64D7A7E0));
    } else {
      wait 10;
      _id_775CD164C569E279("dx_cp_cpes_gs1t_niko_eyesupbreaker1enemyh");
      wait 0.5;
      _id_775CD164C569E279("dx_cp_cpes_gs1t_lasw_copythatnikbreakerwa");
    }

    _id_A6A6A0EDBC6E329A = gettime() + 5000;
  }
}

_id_98F26E3CCDD73E84() {
  level endon("game_ended");
  _id_4BC5FEE4300B6905 = 0;
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("heli_down", vehicle, player);

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    msg = "lb_down";

    if(vehicle.vehicletype == "veh_apache_cp")
      msg = "apache_down";

    wait 3;

    if(msg == "lb_down") {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_00ECDCF88F3403A7");

      foreach(_id_87703F9F647EC52A in level.players) {
        if(_id_87703F9F647EC52A == player) {
          continue;
        }
        wait 1.5;
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_87703F9F647EC52A, "stat_66D4835263B12EE1");
        wait 0.75;
      }

      if(!_id_4BC5FEE4300B6905) {
        _id_4BC5FEE4300B6905 = 1;
        _id_775CD164C569E279("dx_cp_cpes_cbhl_lasw_teamworkdontseemwork");
      }
    } else {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_00ECDCF88F3403A7");
      wait 2;
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_66D4835263B12EE1");
      wait 0.75;

      if(!istrue(level._id_B58EBFFAB31D4FF2)) {
        level._id_B58EBFFAB31D4FF2 = 1;
        _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1t_niko_ineverdoubtedyou"]));
        _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1t_lasw_alrightletsstayfocus", "dx_cp_cpes_gs1t_lasw_nothingtocelebrateye", "dx_cp_cpes_gs1t_lasw_focusonthenexttarget"]));
      } else
        _id_775CD164C569E279("dx_cp_cpes_gs1t_niko_iknewyouhadthatoneon");
    }

    _id_6EE5484560EC747C = undefined;

    foreach(_id_87703F9F647EC52A in level.players) {
      if(_id_87703F9F647EC52A == player) {
        continue;
      }
      _id_6EE5484560EC747C = _id_87703F9F647EC52A;
    }

    if(!isDefined(_id_6EE5484560EC747C)) {
      continue;
    }
    _id_A6A6A0EDBC6E329A = gettime() + 5000;
  }
}

_id_60391AD3EC3CC4B3() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_health", vehicle);

    if(istrue(vehicle._id_E2BAE4CA73FFB0AF)) {
      continue;
    }
    if(!isDefined(vehicle.owner)) {
      return;
    }
    vehicle._id_E2BAE4CA73FFB0AF = 1;
    wait 1;
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

    if(isDefined(driver))
      scripts\cp\cp_player_battlechatter::trysaylocalsound(driver, "stat_4B52069D6483FA32");
  }
}

_id_E49ABB8107CF9C20() {
  level endon("game_ended");
  _id_1238EA9FCD835D2F = gettime();
  _id_DE5CC6BC09C88ED1 = gettime();
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_ntro_lasw_itsabigvalleyavehicl", "dx_cp_cpes_ntro_lasw_youretooexposedonfoo", "dx_cp_cpes_trft_lasw_youregonnaneedtofind", "dx_cp_cpes_trft_lasw_lookforvehiclesparke", "dx_cp_cpes_trft_lasw_theremustbeothervehi", "dx_cp_cpes_trft_lasw_keeppressinglocatean"];
  firsttime = 1;
  _id_BEB945B622946089 = 0;

  for(;;) {
    level waittill("need_vehicle");
    wait 7;

    if(gettime() < _id_1238EA9FCD835D2F) {
      continue;
    }
    if(isDefined(level._id_CF3FE0AA65A4C526) && distance(scripts\cp\utility::get_center_point_of_array(level.players), level._id_CF3FE0AA65A4C526.origin) < 3500) {
      continue;
    }
    if(isDefined(level._id_CF3FDFAA65A4C2F3) && distance(scripts\cp\utility::get_center_point_of_array(level.players), level._id_CF3FDFAA65A4C2F3.origin) < 3500) {
      continue;
    }
    if(isDefined(level._id_CF3FDEAA65A4C0C0) && distance(scripts\cp\utility::get_center_point_of_array(level.players), level._id_CF3FDEAA65A4C0C0.origin) < 3500) {
      continue;
    }
    hasvehicle = 0;
    _id_92999672C7834084 = 0;
    vehicle = scripts\engine\utility::getclosest(scripts\cp\utility::get_center_point_of_array(level.players), level._id_7DA5E47838B88E6C, 8000);

    foreach(player in level.players) {
      if(isDefined(player.vehicle))
        hasvehicle = 1;

      if(!isDefined(vehicle)) {
        continue;
      }
      if(distancesquared(vehicle.origin, player.origin) < squared(1024))
        _id_92999672C7834084 = 1;
    }

    if(hasvehicle || _id_92999672C7834084) {
      continue;
    }
    if(istrue(firsttime)) {
      _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_breakeryouneedtosecu");
      wait 0.5;
      _id_775CD164C569E279("dx_cp_cpes_trft_lasw_aqvehiclesaremarkedo");

      foreach(player in level.players)
      player thread _id_CE434F51A9DE0A8C();

      firsttime = 0;
      _id_1238EA9FCD835D2F = gettime() + 80000;
      continue;
    }

    _id_775CD164C569E279(_id_8DD2942A05ACACFB[_id_BEB945B622946089]);
    _id_BEB945B622946089++;

    if(_id_BEB945B622946089 >= _id_8DD2942A05ACACFB.size)
      _id_BEB945B622946089 = 0;

    _id_1238EA9FCD835D2F = gettime() + 80000;
  }
}

_id_CE434F51A9DE0A8C() {
  self endon("death_or_disconnect");

  if(istrue(self._id_47702A442C42A782)) {
    return;
  }
  self._id_47702A442C42A782 = 1;
  self sethudtutorialmessage(&"CP_MISSION_ESC/TACMAP", 1);
  _id_DCCBEF94E114F58A = gettime() + 10000;

  while(gettime() < _id_DCCBEF94E114F58A && !self istacmapactive())
    waitframe();

  self clearhudtutorialmessage();
  self._id_47702A442C42A782 = undefined;
}

_id_BDC838725A6B2972() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();
  count = 0;

  for(;;) {
    level waittill("rpgincoming", target);

    if(gettime() > _id_A6A6A0EDBC6E329A) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(target, "stat_818E8617ACC1D296");
      _id_A6A6A0EDBC6E329A = gettime() + 90000;
    }
  }
}

_id_092FBA02E84DFB3C() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("rooftopenemy", player);

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    if(randomint(100) > 50)
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_14F86AF7D651B93F");
    else
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_52B2ADECC602D95C");

    wait 3;
    _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1c_lasw_watchtherooftopschec", "dx_cp_cpes_gs1c_lasw_headsupontheroofforc"]));
    _id_A6A6A0EDBC6E329A = gettime() + 45000;
  }
}

_id_A60EF0D72EC9A644() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("tower_destroyed", ent);
    wait 1.5;
    player = ent;

    if(isDefined(ent.owner))
      player = ent.owner;

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_66D4835263B12EE1");
    wait 2;
    _id_A6A6A0EDBC6E329A = gettime() + 15000;
  }
}

_id_0520102A1B253D1E() {
  level waittill("rpgincoming", target);
}

_id_10F2F023F5565883() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("stinger_fired", player, missile, _id_6D87867F43E1D612);
    _id_6D87867F43E1D612 thread _id_6EBC1B8716F04964(missile);
    wait 0.2;
  }
}

_id_6EBC1B8716F04964(missile) {
  self notify("waitforhit");
  self endon("waitforhit");
  self waittill("damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

  if(isDefined(inflictor) && inflictor == missile)
    level notify("lockonhit", attacker);
}

_id_F55B1442AC75C589() {
  level endon("game_ended");
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_cbhl_lasw_watchforcountermeasu", "dx_cp_cpes_cbhl_lasw_iftheydeployflaresre"];
  index = 0;
  _id_A6A6A0EDBC6E329A = gettime();
  firsttime = 0;

  for(;;) {
    level waittill("flares", player, _id_6D87867F43E1D612);
    wait 0.75;

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    wait 2;

    if(istrue(level._id_EDC36D7017B13BBD) && !istrue(firsttime)) {
      firsttime = 1;

      while(isDefined(_id_6D87867F43E1D612)) {
        _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1t_niko_sonofabitch", "dx_cp_cpes_gs1t_niko_wellfuck"]));
        wait 0.5;
        _id_775CD164C569E279(scripts\engine\utility::random(["dx_cp_cpes_gs1t_niko_theyhavecountermeasu", "dx_cp_cpes_gs1t_niko_aqbirdhasflares", "dx_cp_cpes_gs1t_niko_theycameprepared"]));
        wait 0.5;
        _id_775CD164C569E279("dx_cp_cpes_gs1t_niko_didntexpecttoseeflar");
        wait 0.5;
        _id_775CD164C569E279("dx_cp_cpes_gs1t_lasw_theymovedupintheworl");
        wait 0.5;
        _id_775CD164C569E279("dx_cp_cpes_gs1t_niko_weneedtosendthemback");
        wait 1;
        _id_775CD164C569E279("dx_cp_cpes_cbhl_lasw_countermeasureswilld");
        break;
      }
    } else {
      _id_775CD164C569E279(_id_8DD2942A05ACACFB[index], player);
      index++;

      if(index >= _id_8DD2942A05ACACFB.size)
        index = 0;
    }

    _id_A6A6A0EDBC6E329A = gettime() + 5000;
  }
}

_id_F79BCC103DF0213A() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();
  _id_BA723CC766B9796E = 0;
  _id_6A2FD1F4F467647E = 0;

  for(;;) {
    level waittill("lockonhit", player);
    wait 1;

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_66D4835263B12EE1");
    _id_A6A6A0EDBC6E329A = gettime() + 20000;
  }
}

_id_5CBAE0F67D11A3D1(trigger) {
  level endon("game_ended");

  if(!isDefined(trigger))
    trigger = getEnt("minefield_spawn", "targetname");

  trigger endon("death");

  for(;;) {
    if(!isDefined(trigger)) {
      return;
    }
    while(!trigger isnearanyplayer(8500))
      wait 0.1;

    _id_775CD164C569E279("dx_cp_cpes_gs1o_niko_allstationsbeadvised_01");
    wait 1;
    _id_775CD164C569E279("dx_cp_cpes_gs1o_lasw_goodeyesnik");
    _id_775CD164C569E279("dx_cp_cpes_gs1o_lasw_breakerswatchthegrou ");
    return;
  }
}

_id_1716CDE914106554() {
  level endon("game_ended");
  _id_A6A6A0EDBC6E329A = gettime();
  count = 0;

  for(;;) {
    level waittill("trophyused", player);

    if(gettime() < _id_A6A6A0EDBC6E329A) {
      continue;
    }
    wait 0.5;
    scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[0], "stat_2791DF8F0FEBAA08");
    _id_A6A6A0EDBC6E329A = gettime() + 5000;
  }
}

_id_C5BCA194BAD2108C() {
  level endon("game_ended");
  level endon("intro_completed");
  level endon("operator_dead");
  level waittill("launcher_fired");
  scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[0], "stat_ED1C8A7166B894AF");
  wait 4;
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_ntro_lasw_youneedtotakeoutthat", "dx_cp_cpes_ntro_lasw_rooftopmountainsideo", "dx_cp_cpes_ntro_lasw_youllneedtoworktoget"];
  _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
  _id_4AB8D65009761233 = ["dx_cp_cpes_ntro_lasw_youneedtotakeoutthat", "dx_cp_cpes_ntro_lasw_youllneedtoworktoget", "dx_cp_cpes_ntro_lasw_oneofyoudrawfiretheo"];
  _id_A0AB114F6606BB1C = scripts\engine\utility::create_deck(_id_4AB8D65009761233);

  for(;;) {
    wait(randomintrange(40, 60));

    if(!isDefined(level._id_E959C6E734621D0F._id_2C5E84C1F846661B) || !isalive(level._id_E959C6E734621D0F._id_2C5E84C1F846661B)) {
      return;
    }
    _id_920638735134843F = _id_A0AB114F6606BB1C scripts\engine\utility::deck_draw();
    _id_775CD164C569E279(_id_920638735134843F);
  }
}

_id_751E193E4D1F6FF2() {
  level endon("game_ended");
  index = 0;
  _id_A6A6A0EDBC6E329A = gettime();

  for(;;) {
    level waittill("samsite_launch");

    if(!istrue(level._id_E4457DA98181E336)) {
      continue;
    }
    wait 4;
    _id_A6A6A0EDBC6E329A = gettime() + 15000;
  }
}

_id_16EC2FF9721BFFE2() {}

_id_BE434B8D9CD15E21() {
  level endon("game_ended");
  level waittill("operator_dead", player);
  wait 1;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_7F659E0D3CE8B202");
  wait 1;

  foreach(_id_87703F9F647EC52A in level.players) {
    if(_id_87703F9F647EC52A == player) {
      continue;
    }
    scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "stat_66D4835263B12EE1");
  }

  wait 2;
  _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_theresnothintwocantd");
}

_id_CCD7A6907F25864A() {
  level endon("game_ended");

  for(;;) {
    level waittill("enemy_killed", eattacker, guy);

    if(guy != self) {
      continue;
    }
    level notify("operator_dead", eattacker);
    return;
  }
}

_id_C51B535A4296667C() {
  wait 0.5;
  _id_8DD2942A05ACACFB = ["dx_cp_cpes_ntro_lasw_standclearoftheblast", "dx_cp_cpes_ntro_lasw_standclearoftheblast_01"];
  level thread _id_775CD164C569E279(scripts\engine\utility::random(_id_8DD2942A05ACACFB));
}

_id_B9FBA7B87112A435() {
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_45C1622EFE49213A");
}

_id_0D7D2395BA06CF65() {
  wait 2;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_66D4835263B12EE1");
}

_id_135AB43D3A20551F() {
  level endon("game_ended");

  for(;;) {
    level waittill("geigerIntelGiven", player);
    level thread _id_775CD164C569E279("dx_cp_cpes_ntro_lasw_goodfindkeepyoureyeo", player);
  }
}

_id_7DD903F3E30E81D6() {
  wait 9;
  setmusicstate("mx_cp_mission_esc_drivetogrid");
}

_id_221688A427C71B43() {
  _func_A3901A965FC1D7DD("mx_cp_mission_esc_drivetogrid");
}

_id_EECFF0A87B66BB4A() {
  wait 1;
  setmusicstate("mx_cp_mission_esc_sambcombat");
}

_id_D6FFB86E492A8DC5() {
  wait 2;
  setmusicstate("mx_cp_mission_esc_samccombat");
}

_id_EE0ACDD78017BFF0() {
  wait 2.5;
  setmusicstate("mx_cp_mission_esc_samdcombat");
}