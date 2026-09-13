/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\challenges_cp.gsc
***********************************************/

init() {
  if(!scripts\cp_mp\challenges::challengesenabled())
    return;
}

_id_B7193191C525B263() {
  if(!istrue(game["stealth_was_broken"])) {
    _id_7665DCAD8B978321("Maintained stealth for Challenge");

    if(_id_24D5A807C593DC49()) {
      typeid = _func_96B7FC7E35353254("complete_mission_stealth");

      foreach(player in level.players)
      player _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
    }
  }
}

_id_472E90D2E14C4B53(eattacker) {
  _id_F275474AACD30C96 = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("equip_bunkerbuster");
  _id_7665DCAD8B978321("Player killed the Jugg with a drill charge.");

  if(_id_24D5A807C593DC49()) {
    _id_C5B28F88D9B3BFD7 = _id_BDFE9C25F2838F5D("juggernaut");
    eattacker _meth_DB073176839D77FB("75", [8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 32, 1, 13, _id_C5B28F88D9B3BFD7, 44, _id_F275474AACD30C96, 11, 1]);
  }
}

_id_5CCD46F74AF245D8() {
  _id_7665DCAD8B978321("Player has destroyed a vehicle");
  _id_C5B28F88D9B3BFD7 = _id_BDFE9C25F2838F5D("vehicle");

  if(_id_24D5A807C593DC49())
    self _meth_DB073176839D77FB("75", [8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 32, 1, 13, _id_C5B28F88D9B3BFD7, 11, 1]);
}

_id_38154B1C06023442(eattacker) {
  _id_C5B28F88D9B3BFD7 = _id_BDFE9C25F2838F5D();
  _id_7665DCAD8B978321("Demon Dog got a kill.");

  if(_id_24D5A807C593DC49()) {
    _id_C24E8FA2BC7818BC = 0;
    _id_C24E8FA2BC7818BC = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_C24E8FA2BC7818BC, 58);
    eattacker _meth_DB073176839D77FB("75", [8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 32, 1, 13, _id_C5B28F88D9B3BFD7, 11, 1, 12, _id_C24E8FA2BC7818BC]);
  }
}

_id_15C867E400749A3B() {
  if(istrue(self._id_CA56839B2E00EDCE)) {
    return;
  }
  _id_7665DCAD8B978321("Player has equipped Juggernaut");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("juggernaut");
    self _meth_DB073176839D77FB("113", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_CE271D4118A0475D(_id_676E18B47A5AD0EC) {
  _id_7665DCAD8B978321("Player has spent money");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("special");
    self _meth_DB073176839D77FB("47", [32, 1, 46, typeid, 31, _id_676E18B47A5AD0EC, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_D8B00758A4ECBDA7(item) {
  _id_7665DCAD8B978321("Player has successfully purchased an item" + item);

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254(item);
    self _meth_DB073176839D77FB("47", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_9EC128BA953AB4E0() {
  _id_7665DCAD8B978321("Player has destroyed a chopper using an MGL.");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("destroy_chopper_with_mgl");
    self _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_FC52996338C115D1() {
  _id_7665DCAD8B978321("Player has destroyed a chopper using a cruise missile.");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("destroy_chopper_with_cruise");
    self _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_3D55D46E36D8430B() {
  _id_7665DCAD8B978321("Player has filled their plates.");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("super_armor_drop");
    self _meth_DB073176839D77FB("113", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_613A81F77B1154D0(_id_BE2203D59EE928B6) {
  if(_id_BE2203D59EE928B6 < 5) {
    return;
  }
  typeid = _func_96B7FC7E35353254("cp_snapshot_five");
  _id_7665DCAD8B978321("Player has outlined 5 enemies at once");

  if(_id_24D5A807C593DC49())
    self _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, _id_BE2203D59EE928B6, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
}

_id_B036C3ABB6389913() {
  _id_7665DCAD8B978321("Player has successfully used a loadout crate");
  _id_0C34D57F3D8027C2 = 0;
  _id_0C34D57F3D8027C2 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_0C34D57F3D8027C2, 0);
  _id_8691AF1F100B771F = _func_96B7FC7E35353254("loot_supply_drop");

  if(_id_24D5A807C593DC49())
    self _meth_DB073176839D77FB("113", [32, 1, 85, _id_0C34D57F3D8027C2, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 46, _id_8691AF1F100B771F]);
}

_id_FF3FFCCAC94C5578(_id_AA1ED8F12D71A7A5, _id_CFBCB02C4E5EA638) {
  foreach(player in level.players) {
    _id_8D0ED9033CFAB106 = _id_862A7D40F77A77D6(_id_AA1ED8F12D71A7A5);
    missionid = _func_96B7FC7E35353254(_id_8D0ED9033CFAB106);
    modifiers = 0;

    if(!isDefined(player.modifiers))
      player.modifiers = [];

    player.modifiers["endGameMask"] = 0;

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
      player _id_266D25F14BE47E20("raidHardMode", 11);
      _id_7665DCAD8B978321("Players have completed on Hard Mode.");
    }

    if(!istrue(level._id_5A1E175009ECEC56)) {
      player _id_266D25F14BE47E20("lastStandNotEntered", 9);
      _id_7665DCAD8B978321("Players have completed the mission without anybody going down.");
    }

    if(!istrue(level._id_F091400016C92E56))
      player _id_266D25F14BE47E20("noPurchaseMade", 10);

    modifiers = player.modifiers["endGameMask"];
    _id_E7E2304CD16AE61E = player _id_5E5507D57BBBB709::_id_CC1CCC9E93B22C24();
    _id_AA83D0F8BB75BEA8 = _func_96B7FC7E35353254(_id_E7E2304CD16AE61E);
    _id_F8159225B84B2698 = player _id_0998572FF3C96EE5::_id_CBAA41C477D4C53F();
    _id_BA11A925EC503D8B = player _id_0998572FF3C96EE5::_id_34819F005DAD50A9();
    player _id_0998572FF3C96EE5::_id_96AB127821B24D8F(_id_BA11A925EC503D8B);
    _id_E8EC973EC9FE7D09 = player _id_5E5507D57BBBB709::_id_0CA8C9FF1FF9DB6E();
    _id_7F721E60F7D473C1 = _id_CFBCB02C4E5EA638;
    _id_7665DCAD8B978321("Player has completed the given mission");

    if(_id_24D5A807C593DC49())
      player _meth_DB073176839D77FB("62", [8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 32, 1, 79, _id_CFBCB02C4E5EA638, 118, _id_7F721E60F7D473C1, 125, _id_F8159225B84B2698, 97, _id_BA11A925EC503D8B, 80, missionid, 5, modifiers, 82, _id_AA83D0F8BB75BEA8, 96, _id_E8EC973EC9FE7D09]);

    _id_76C6444F1C3454AD = 0;
    _id_8F3E1B856A8C20B3 = "private_match";

    if(scripts\cp\utility::matchmakinggame()) {
      _id_76C6444F1C3454AD = getplaylistid();
      _id_8F3E1B856A8C20B3 = getplaylistname();
    }

    dlog_recordevent("dlog_event_cpdata_stars_rewarded", ["levelname", level.script, "playername", player.name, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "sharedaccount_uid", int(player scripts\cp\cp_analytics::_id_512417BDDBE63792()), "stars_earned", int(_id_CFBCB02C4E5EA638), "career_stars", int(player _id_0998572FF3C96EE5::_id_CBAA41C477D4C53F()), "playlist_id", int(_id_76C6444F1C3454AD), "playlist_name", _id_8F3E1B856A8C20B3]);
  }
}

_id_862A7D40F77A77D6(_id_8D0ED9033CFAB106) {
  switch (_id_8D0ED9033CFAB106) {
    case "cp_mission_esc":
      if(istrue(level._id_05F694EFAFEB95D7))
        return "high_ground_cp";

      return "denied_area_cp";
    case "cp_hydro":
      return "saba_hydro";
    case "cp_observatory":
      return "saba_observatory";
    case "cp_raid1":
      return "raid_s1";
    case "cp_raid1_trap":
      return "raid_s2";
    case "cp_raid1_boss1":
      return "raid_s3";
    case "cp_jugg_maze":
      return "raid_s4";
  }

  return undefined;
}

_id_51BBBA3794076BF4() {
  if(!isDefined(level._id_9DCC9F8CADBC7C6A)) {
    return;
  }
  if(level._id_9DCC9F8CADBC7C6A > 0) {
    return;
  }
  _id_7665DCAD8B978321("Players have completed wave 6 without a bomb being planted.");
  _id_B6CAF1BA75B1D921 = _func_96B7FC7E35353254("complete_defender_wave_6_no_bomb_plant");

  if(_id_24D5A807C593DC49()) {
    foreach(player in level.players)
    player _meth_DB073176839D77FB("49", [32, 1, 46, _id_B6CAF1BA75B1D921, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_A4F684E73D9EC4C6(eattacker) {
  if(isDefined(eattacker._id_AC19F9B9C6C841B9)) {
    if(eattacker._id_AC19F9B9C6C841B9 == "chopper") {
      _id_C5B28F88D9B3BFD7 = _id_BDFE9C25F2838F5D();
      _id_C24E8FA2BC7818BC = 0;
      _id_C24E8FA2BC7818BC = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_C24E8FA2BC7818BC, 54);
      _id_7665DCAD8B978321("Player has gotten a kill as the heli pilot");

      if(_id_24D5A807C593DC49())
        eattacker _meth_DB073176839D77FB("75", [8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6(), 32, 1, 13, _id_C5B28F88D9B3BFD7, 11, 1, 12, _id_C24E8FA2BC7818BC]);
    }
  }
}

_id_7EA6BAB94F0C5E45(_id_AA1ED8F12D71A7A5, objweapon, player) {
  if(isDefined(objweapon) && _id_AA1ED8F12D71A7A5 == "cp_mission_esc" && !istrue(level._id_05F694EFAFEB95D7)) {
    if(objweapon.basename != "c4_cp_noproj") {
      _id_7665DCAD8B978321("Player destroyed SAM without planting an explosive");

      if(_id_24D5A807C593DC49()) {
        typeid = _func_96B7FC7E35353254("sam_site_no_plant");
        player _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
      }
    }
  }
}

_id_66B45CB5DD35268C() {
  _id_7665DCAD8B978321("Player purchased a skip timer");

  if(_id_24D5A807C593DC49()) {
    typeid = _func_96B7FC7E35353254("defender_skip_timer");
    self _meth_DB073176839D77FB("113", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
  }
}

_id_BDFE9C25F2838F5D(_id_319F74ED8FA1A512) {
  if(!isDefined(_id_319F74ED8FA1A512))
    _id_319F74ED8FA1A512 = "";

  _id_C5B28F88D9B3BFD7 = 0;

  switch (_id_319F74ED8FA1A512) {
    case "juggernaut":
      _id_C5B28F88D9B3BFD7 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 8);
      break;
    case "vehicle":
      _id_C5B28F88D9B3BFD7 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 6);
      break;
    default:
      _id_C5B28F88D9B3BFD7 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_C5B28F88D9B3BFD7, 2);
      break;
  }

  return _id_C5B28F88D9B3BFD7;
}

_id_284BD74F0F8D5534(_id_FDDBE9CD3D35B217, _id_6859CF87418E7FA0) {
  self.modifiers[_id_FDDBE9CD3D35B217] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], _id_6859CF87418E7FA0);
}

_id_266D25F14BE47E20(_id_FDDBE9CD3D35B217, _id_6859CF87418E7FA0) {
  if(!isDefined(self.modifiers["endGameMask"]))
    self.modifiers["endGameMask"] = 0;

  self.modifiers[_id_FDDBE9CD3D35B217] = 1;
  self.modifiers["endGameMask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["endGameMask"], _id_6859CF87418E7FA0);
}

_id_7665DCAD8B978321(msg) {}

_id_24D5A807C593DC49() {
  return getdvarint("dvar_86F5418DEC919161", 1);
}

_id_2B0B870D1CF29ADD() {
  return scripts\cp_mp\challenges::getchallengegamemode();
}

_id_2FF6FAC4CF0827A6() {
  return scripts\cp_mp\challenges::_id_17C5D7FEB226E256();
}

_id_7D7322BF935AB06A(player, typeid) {
  player _meth_DB073176839D77FB("49", [32, 1, 46, typeid, 31, 1, 8, _id_2B0B870D1CF29ADD(), 9, _id_2FF6FAC4CF0827A6()]);
}