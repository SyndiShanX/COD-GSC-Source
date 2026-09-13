/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3707f44961816b2f.gsc
***********************************************/

main() {
  precachemodel("electrical_office_security_lock_01_mp_red");
  precachemodel("electrical_office_security_lock_01_mp_green");
  level._id_09FAB40ED3326F8B = getDvar("dvar_A5CA3391D68537E7", "mp/subarea_tuning_mp_bio_lab.csv");
  level._id_4D8386ECA283E9C4 = "biolabs_";
  level thread _id_5DEF7AF2A9F04234::_id_C08668FE290FC31A();
  setDvar("dvar_62FEF4C88F74AE7C", 0);
  level._id_400484D15C2CFD6B = getdvarint("dvar_1E69EF33B46F5773", 400);
  level._id_FD915E8BD20B6D09 = _id_5C55C87B89467A29::_id_93E3FE0E5693889B;
  level.skipprematchdropspawn = 1;
  level._id_1789643B227CF471 = ::_id_972D10285EF59CD6;
  _id_61D3A28B91E42C52::main();
  _id_0FB5E517D78327F4::main();
  _id_4119B33581AF0142::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_212D755F358C87F4::main();
  level thread _id_260837D46C90D5E2::main();
  _id_4FF6C6ED304E05BB::init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("dmz_threat_bias", "customNationality", ::_id_90ABDBF9EE65BB1B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("threat_bias", "customFriendlyCheck", ::_id_50848C14636B3377);
  level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((2620, -2239, 1000), 0, 5000)];
  level._id_744DFABB8F946331 = ::_id_3114E3023D0EDF66;
  level._id_172E4B629498723C = ::_id_AB9B0BB33C9FC28F;
  level._id_FC458DDEC84C95A0 = ::_id_FC458DDEC84C95A0;
  level._id_AAB9F6CFC50F372F = ::ontimelimit;
  level._id_9D7687867D52AC75 = ::_id_9D7687867D52AC75;
  level._id_4D6759431590AF80 = ::_id_4D6759431590AF80;
  level._id_6D879681512CD627 = ::_id_6D879681512CD627;
  level._id_0E1CA44858CD8EA1 = ::_id_0E1CA44858CD8EA1;
  level._id_72E1667D06AB98DB = 1;
  level.prewaitandspawnclient = ::_id_32984D4A50907183;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.ttlos_suppressasserts = 1;
  level thread _id_D25CEFB87C9DB72D();
  level _id_11C3498B52EF78AA();
  level _id_B7AAFBF07974E295();
  level._id_67ABFC6A70AF2CCC = ::_id_01421D2332D0A4B9;
  level _id_57DA0E90D3AD2B71::_id_8777165F2FD37CE1();

  if(istrue(level._id_289DF80E1DED586F)) {
    level._id_6827E5668EBC95C0 = 1;
    level._id_1C8CBD78AF4920D0 = _id_2D9C29F869A29FCA::_id_CEE3B39981879330;
    level._id_39643776A698EFCE = ::_id_39643776A698EFCE;
    level._id_4B195D3DD0024B9C = "team_hundred_ninety_four";
    _id_48814951E916AF89::_id_C8393014DD7F8AB6();
    level thread _id_2D9C29F869A29FCA::_id_6D19FE96E8F91A3C("mp/reinforcement_events.csv");
    level thread _id_43D8CD9C9D19938C();
    _id_D4DB944803F0CD56();
    level._id_CE11405F66C0872E = "cvm2";
    level._id_B58C6275920EDF51 = "bds4";
  }

  _id_701449195235BE31::_id_E3752C40826A26D4();
  level thread _id_5C118165D3E98A42::_id_D8DE1E0BC05F3B3A("mp/dmz_biolab_elevator_pick.csv");
  level thread _id_7E32C4283965A098::_id_D62CE6271CADD6AD();
  level thread _id_2D9C29F869A29FCA::_id_3FB0D650BE8286CE();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  level thread _id_7E32C4283965A098::_id_D8DF6AC7C62A1EBA();
  level._id_E26F46A3B89CD3BB = getdvarint("dvar_9B4464211CD3A434", 30);
  level._id_A0F6CF876AB471E6 = getdvarint("dvar_174E9721C13FDDB9", 20);
  level._id_D99059956F0D1F3D = getdvarint("dvar_4EAA5933431CE770", 10);
  level._id_06B03A4FEAE848EA = getdvarint("dvar_C21D8127CB55A76D", 10);
  level._id_E14D6A1883B24ACC = getdvarint("dvar_7AA41E8E0E345629", 20);
  scripts\mp\compass::setupminimap("compass_map_mp_bio_lab");
  brinit();
  level thread _id_6AA5526ADEE3292E();
  level thread _id_F1FA5EB8C61DC286();
  level thread _id_0DDA586D27C1CEBE::init();
  level thread _id_018D92A94227452E();
  level thread _id_95C3237DDFEDED60();
  level thread _id_C14085508A258DAA();
  level thread _id_00F16A5EB9A335D5();
  level thread _id_B6D133C0B94DFB83();
  _id_B476BA3EB6794B55();
  _id_4EF38295E7BA94D2();

  if(getdvarint("dvar_AE32A8E0AFC7BD41", 0))
    level thread _id_B4A2657BE39CB0F7();

  _id_72AF5A878A9D3397::_id_F6C977AD89F51B9C(level.script, level.mapcorners);
  level thread _id_E195A599FEDEB50F();
}

brinit() {
  level.br_level = spawnStruct();
  _id_45B2B4A889E633FA::setc130heightoverrides(19000, 128);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  level.br_level.br_mapboundsfull = [];
  level.br_level.br_mapboundsfull[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapboundsfull[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0] * 0.95;
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0] * 0.95;
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1] * 0.95;
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1] * 0.95;
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (_id_C978C90E8E5AB1F7, _id_C978C80E8E5AAFC4, 0);
  level.br_level.br_mapbounds[1] = (_id_3C590D0EE220B409, _id_3C590C0EE220B1D6, 0);
  level.br_level.br_mapcenter = ((_id_3C590D0EE220B409 + _id_C978C90E8E5AB1F7) / 2, (_id_3C590C0EE220B1D6 + _id_C978C80E8E5AAFC4) / 2, 0);
  level.br_level.br_mapsize = (abs(_id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409), abs(_id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6), abs(level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride));
}

_id_B476BA3EB6794B55() {
  game["dialog"]["bio_lab_lpcon_brvo_intro"] = "dx_br_biol_lpcc_lbpa_brvo";
  game["dialog"]["bio_lab_lpcon_chrl_intro"] = "dx_br_biol_lpcc_lbpa_chrl";
  game["dialog"]["bio_lab_lpcon_dlta_intro"] = "dx_br_biol_lpcc_lbpa_dlta";
  game["dialog"]["bio_lab_lpcon_echo_intro"] = "dx_br_biol_lpcc_lbpa_echo";
  game["dialog"]["bio_lab_elevator_exfil_start"] = "dx_br_biol_annn_lbpa_exst";
  game["dialog"]["bio_lab_elevator_exfil_complete"] = "dx_br_biol_annn_lbpa_excm";
  game["dialog"]["bio_lab_squad_eliminated"] = "dx_br_biol_annn_lbpa_sqdl";
  game["dialog"]["bio_lab_three_squad_active"] = "dx_br_biol_annn_lbpa_sqdl";
  game["dialog"]["bio_lab_two_squad_active"] = "dx_br_biol_annn_lbpa_sqdl";
  game["dialog"]["bio_lab_one_squad_active"] = "dx_br_biol_annn_lbpa_sqdl";
  game["dialog"]["bio_lab_squad_extracted"] = "dx_br_biol_annn_lbpa_sqdx";
  game["dialog"]["bio_lab_squad_eliminated"] = "dx_br_biol_mode_ovld_sqdl";
  game["dialog"]["bio_lab_data_center_breach"] = "dx_br_biol_annn_lbpa_dtcb";
  game["dialog"]["bio_lab_server_hacked"] = "dx_br_biol_annn_lbpa_srvr";
  game["dialog"]["bio_lab_poison_gas"] = "dx_br_biol_annn_lbpa_psng";
  game["dialog"]["bio_lab_helo_exfil"] = "dx_br_biol_annn_lbpa_hlxf";
  game["dialog"]["bio_lab_lv3_armory_room_vo"] = "dx_br_biol_pzzl_lbpa_rmrb";
  game["dialog"]["bio_lab_reinforcement_coming"] = "dx_br_biol_rnfr_lbpa_gnrl";
  game["dialog"]["bio_lab_velikan_intro"] = "dx_br_biol_rnfr_lbpa_jggn";
  game["dialog"]["bio_lab_lv1_generator_room_vo"] = "dx_br_biol_rnfr_lbpa_gnrt";
  game["dialog"]["bio_lab_lv2_file_cabinets_vo"] = "dx_br_biol_rnfr_lbpa_rchv";
  game["dialog"]["bio_lab_lv3_security_storage_lab_vo"] = "dx_br_biol_rnfr_lbpa_crlb";
  game["dialog"]["bio_lab_extract_success"] = "dx_br_biol_mode_ovld_xtrc";
  game["dialog"]["bio_lab_helo_arriving"] = "dx_br_biol_mode_ovld_hlrr";
  game["dialog"]["bio_lab_helo_leaving"] = "dx_br_biol_mode_ovld_hllv";
  game["dialog"]["bio_lab_locks_hack_ongoing"] = "dx_br_biol_mode_ovld_slho";
  game["dialog"]["bio_lab_locks_hack_complete"] = "dx_br_biol_mode_ovld_slhc";
  game["dialog"]["bio_lab_minimap_lost"] = "dx_br_biol_mode_ovld_mnml";
  game["dialog"]["radiation_start_spread"] = "dx_br_dmzc_radn_ovld_rass";
  game["dialog"]["bio_lab_match_start_1"] = "dx_br_biol_mode_ovld_defenseresearchcente";
  game["dialog"]["bio_lab_match_start_2"] = "dx_br_biol_mode_ovld_ultra1securevaluable_01";
}

_id_D25CEFB87C9DB72D() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  level._id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
}

_id_0E1CA44858CD8EA1(dialog, _id_7F23D950A1672F12, players) {
  level endon("game_ended");

  if(istrue(_id_7F23D950A1672F12))
    level notify("pa_dialog_force_play");

  level endon("pa_dialog_force_play");
  _id_CB3339ECE72DBDEB = game["dialog"][dialog];

  if((!istrue(level._id_EB9576F309942FF4) || istrue(_id_7F23D950A1672F12)) && isDefined(_id_CB3339ECE72DBDEB)) {
    level._id_EB9576F309942FF4 = 1;

    if(!isDefined(players))
      level._id_2B4B28F7AE75B76A playSound(_id_CB3339ECE72DBDEB);
    else {
      foreach(player in players)
      level._id_2B4B28F7AE75B76A playsoundtoplayer(_id_CB3339ECE72DBDEB, player);
    }

    length = lookupsoundlength(_id_CB3339ECE72DBDEB);
    wait(length / 1000 + 1.0);

    switch (dialog) {
      case "bio_lab_lpcon_echo_intro":
        level notify("pa_dialog_lpcon_echo_intro_end");
        break;
      default:
        break;
    }

    level._id_EB9576F309942FF4 = 0;
  }
}

_id_00F16A5EB9A335D5() {
  level endon("game_ended");
  level waittill("match_start_real_countdown");
  _id_F5F821C46BFFC552 = scripts\engine\utility::getStructArray("gas_mask_node", "targetname");

  foreach(_id_EB257C77EFD28715 in _id_F5F821C46BFFC552) {
    if(isDefined(_id_EB257C77EFD28715)) {
      dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, _id_EB257C77EFD28715.origin, _id_EB257C77EFD28715.angles, undefined, 0, 0);
      _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask", _id_CB4FAD49263E20C4);
    }
  }
}

_id_C30C1A5D9C0F882A(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  return 0;
}

_id_3114E3023D0EDF66() {
  keys = getarraykeys(level.struct_class_names["script_noteworthy"]);
  _id_3BC8166F34E330ED = [];
  _id_F73ACB8BA1C2F0F5 = [];

  foreach(key in keys) {
    if(issubstr(key, "dmz_squadSpawnPoint_")) {
      foreach(node in level.struct_class_names["script_noteworthy"][key]) {
        if(!isDefined(_id_3BC8166F34E330ED[key])) {
          _id_3BC8166F34E330ED[key] = [];
          _id_F73ACB8BA1C2F0F5[_id_F73ACB8BA1C2F0F5.size] = key;
        }

        _id_3BC8166F34E330ED[key][_id_3BC8166F34E330ED[key].size] = node;
      }
    }
  }

  if(getdvarint("dvar_EEAAACA96BEF9602", 1) == 1) {
    foreach(key in _id_F73ACB8BA1C2F0F5) {
      _id_0C84F6220E6636C5 = undefined;

      if(getdvarint("dvar_ED1E1E5706D7F344", 0) == 1) {
        _id_C8B707C031223716 = undefined;
        _id_7FF111408565B812 = 0;

        foreach(_id_CE3B0178F58FFBF4 in _id_F73ACB8BA1C2F0F5) {
          if(_id_CE3B0178F58FFBF4 == key) {
            continue;
          }
          foreach(_id_51571F0C2D656751 in _id_3BC8166F34E330ED[_id_CE3B0178F58FFBF4]) {
            _id_636C8575D7A7768B = distancesquared(_id_3BC8166F34E330ED[key][0].origin, _id_51571F0C2D656751.origin);

            for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_3BC8166F34E330ED[key].size; _id_AC0E594AC96AA3A8++) {
              dist = distancesquared(_id_3BC8166F34E330ED[key][_id_AC0E594AC96AA3A8].origin, _id_51571F0C2D656751.origin);

              if(dist < _id_636C8575D7A7768B)
                _id_636C8575D7A7768B = dist;
            }

            if(_id_636C8575D7A7768B > _id_7FF111408565B812) {
              _id_7FF111408565B812 = _id_636C8575D7A7768B;
              _id_C8B707C031223716 = _id_51571F0C2D656751;
            }
          }
        }

        _id_0C84F6220E6636C5 = _id_C8B707C031223716;
      } else {
        switch (key) {
          case "dmz_squadSpawnPoint_preset_1":
            _id_0C84F6220E6636C5 = sortbydistance(_id_3BC8166F34E330ED["dmz_squadSpawnPoint_preset_4"], (-1670, -511, 16))[0];
            break;
          case "dmz_squadSpawnPoint_preset_2":
            _id_0C84F6220E6636C5 = sortbydistance(_id_3BC8166F34E330ED["dmz_squadSpawnPoint_preset_3"], (1444, 4330, 209))[0];
            break;
          case "dmz_squadSpawnPoint_preset_3":
            _id_0C84F6220E6636C5 = sortbydistance(_id_3BC8166F34E330ED["dmz_squadSpawnPoint_preset_2"], (-3373, 1453, 12))[0];
            break;
          case "dmz_squadSpawnPoint_preset_4":
            _id_0C84F6220E6636C5 = sortbydistance(_id_3BC8166F34E330ED["dmz_squadSpawnPoint_preset_1"], (-3295, 2340, 16))[0];
            break;
          default:
            break;
        }
      }

      if(isDefined(_id_0C84F6220E6636C5))
        _id_3BC8166F34E330ED[key][_id_3BC8166F34E330ED[key].size] = _id_0C84F6220E6636C5;
    }
  }

  return _id_3BC8166F34E330ED[_id_F73ACB8BA1C2F0F5[randomint(_id_3BC8166F34E330ED.size)]];
}

_id_FC458DDEC84C95A0(_id_7D04A3A2B5F14957, index) {
  if(!isDefined(_id_7D04A3A2B5F14957) || !isDefined(_id_7D04A3A2B5F14957.target) || index == 0 || index >= level.maxteamsize)
    return _id_7D04A3A2B5F14957;

  point = _id_7D04A3A2B5F14957;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < index; _id_AC0E594AC96AA3A8++) {
    point = scripts\engine\utility::getStruct(point.target, "targetname");

    if(!isDefined(point) || !isDefined(point.target)) {
      break;
    }
  }

  if(isDefined(point)) {
    _id_572211C19BA28F44 = scripts\engine\utility::drop_to_ground(point.origin, 20, 0);
    spawnpoint = spawnStruct();
    spawnpoint.origin = _id_572211C19BA28F44;
    spawnpoint.angles = point.angles;
    return spawnpoint;
  } else
    return _id_7D04A3A2B5F14957;
}

_id_9D7687867D52AC75() {
  return "dmz_weaponCase_picked_up_biolab";
}

_id_4D6759431590AF80(player) {
  _id_095A84DF7200112F = level.players;
  _id_DA96C8943126A950 = getaiarrayinradius(player.origin, 512);
  return scripts\engine\utility::array_combine(_id_095A84DF7200112F, _id_DA96C8943126A950);
}

_id_11C3498B52EF78AA() {
  _id_345D2CF492F05F1D = "floor_volume_";
  _id_546001DE6A010C77 = 3;
  _id_F4912D41BBBAFF28 = [];

  for(index = 0; index < _id_546001DE6A010C77; index++) {
    _id_D7F76D1C4EFF6C4B = spawnStruct();
    _id_D7F76D1C4EFF6C4B.ent = getEnt(_id_345D2CF492F05F1D + (index + 1), "script_noteworthy");
    _id_D7F76D1C4EFF6C4B._id_5DCB93DB1678CDAF = index;
    _id_F4912D41BBBAFF28[index] = _id_D7F76D1C4EFF6C4B;
  }

  level._id_F4912D41BBBAFF28 = _id_F4912D41BBBAFF28;
}

_id_B7AAFBF07974E295() {
  level._id_F2A8E4A4AF870513 = ["lv1_generator_room", "lv3_security_storage_lab", "lv3_side_lab", "lv2_file_cabinets", "lv3_armory_room"];
  level._id_029CED2D4D9A0BDE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F2A8E4A4AF870513.size; _id_AC0E594AC96AA3A8++)
    level._id_029CED2D4D9A0BDE[level._id_F2A8E4A4AF870513[_id_AC0E594AC96AA3A8]] = getEnt(level._id_F2A8E4A4AF870513[_id_AC0E594AC96AA3A8], "script_noteworthy");
}

_id_D4DB944803F0CD56() {
  if(getdvarint("dvar_4859370DE79B6267", 1) == 1)
    level thread _id_38757ECA8B2F5C7E::init();

  if(getdvarint("dvar_CDF7C89764653666", 1) == 1)
    level thread _id_A5871D47A3F4CEDF();
}

_id_A5871D47A3F4CEDF() {
  level endon("game_ended");
  _id_E108D0ABDB42CFF6 = ["lv1", "lv2", "lv3"];

  for(;;) {
    level waittill("lpcon_current_alert_level_updated", alertlevel);

    if(alertlevel >= 4) {
      wait 20;
      floor = scripts\engine\utility::random(_id_E108D0ABDB42CFF6);
      _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("boss_velikan_" + floor, undefined, undefined, ::_id_F5844A59A2AE7289);
      level thread _id_0E1CA44858CD8EA1("bio_lab_velikan_intro");
      break;
    }
  }
}

_id_F5844A59A2AE7289() {
  self._id_47BDE44B1ACEC603 = "velikan";
  _id_D7D7576D15EFC9C4 = getdvarint("dvar_E8E76632D2427F07", 200);
  self.helmethealth = _id_D7D7576D15EFC9C4;
  self._id_CFC69E5588A5BED6 = _id_D7D7576D15EFC9C4;
  _id_D61B9C5BE04A7A86 = getdvarint("dvar_A5223641A9909F83", 2300);
  self.armorhealth = _id_D61B9C5BE04A7A86;
  self._id_8790C077C95DB752 = _id_D61B9C5BE04A7A86;
  self._id_8C5C47F81A1869E5 = _id_24FBEDBA9A7A1EF4::_id_7D0D24665D72F13C;
  self._id_274D3A7704E351EF = 1;
  self.aggressivemode = 1;
  self._id_CBD87A0BC497B778 = 1;
  self._id_35DAF9AD83601ACE = 1;
  self.allowpain = 0;
  self.ignoresuppression = 1;

  if(getdvarint("dvar_2F83E02F5B876153", 1) == 1)
    _id_48814951E916AF89::_id_63A043D47490F90D(self, "brloot_plate_carrier_3_stealth", undefined, undefined, 1);

  self _meth_ AE41FBF799BA43F(1, "entity");
  _id_371B4C2AB5861E62::_id_1C3709E864D4E8D5(1);
  self._id_9AA77AB756FDCA82 = 9000;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_velikan_revealed", level.players);
  thread _id_D8265B61E3690716();
  thread _id_EAD560E17BDEC674();
}

_id_D8265B61E3690716() {
  level endon("game_ended");
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(self, "dropWeapon", 0);
  _id_48814951E916AF89::_id_63A043D47490F90D(self, "brloot_weapon_la_mike32_epic", undefined, 1, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(self, "loot_key_black_door_worn", undefined, 1, 1);
  self waittill("death", _id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    players = scripts\mp\utility\teams::getteamdata(_id_6181DE250AFA5BB6.team, "players");

    foreach(player in players) {
      if(!isDefined(player._id_8C8050D7D861D06C))
        player._id_8C8050D7D861D06C = 0;

      player._id_8C8050D7D861D06C++;
    }
  }
}

_id_EAD560E17BDEC674() {
  level endon("game_ended");
  self endon("death");
  _id_9F24038FD2E04755 = 1024;

  for(;;) {
    if(self.isopeningdoor && isDefined(self._blackboard.doortoopen) && !istrue(self._blackboard.door_opened)) {
      doorcenter = self[[self.fngetdoorcenter]](self._blackboard.doortoopen);
      _id_F195BAD2134DB294 = distance2dsquared(doorcenter, self.origin);

      if(_id_F195BAD2134DB294 < _id_9F24038FD2E04755) {
        scripts\asm\shared\utility::opendooratreasonabletime();
        self cleardooropen();
      }
    }

    wait 1;
  }
}

_id_4EF38295E7BA94D2() {
  _id_0995980EFC9B9A92 = getEntArray("mp_global_intermission", "classname");

  if(_id_0995980EFC9B9A92.size > 0) {
    _id_0995980EFC9B9A92[0].origin = (-1014, 1825, 552);
    _id_0995980EFC9B9A92[0].angles = (15, 15, 0);
  }
}

_id_AB9B0BB33C9FC28F(origin) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_F4912D41BBBAFF28.size; _id_AC0E594AC96AA3A8++) {
    if(ispointinvolume(origin, level._id_F4912D41BBBAFF28[_id_AC0E594AC96AA3A8].ent))
      return level._id_F4912D41BBBAFF28[_id_AC0E594AC96AA3A8]._id_5DCB93DB1678CDAF;
  }

  return undefined;
}

_id_6D879681512CD627(_id_0B672455A42D115B, _id_9B553BB5E16EF3FF) {
  _id_76CEA685A60C10F6 = _id_AB9B0BB33C9FC28F(_id_9B553BB5E16EF3FF);

  if(!_id_5C118165D3E98A42::_id_E81853B8E49151BA(_id_76CEA685A60C10F6))
    return 0;

  if(_id_0B672455A42D115B._id_6485CB51EB50DC9B == _id_76CEA685A60C10F6 || isDefined(level._id_0C37DDB982D3177D))
    return 1;

  return _id_0B672455A42D115B._id_6485CB51EB50DC9B != 2 && _id_76CEA685A60C10F6 != 2;
}

_id_6AA5526ADEE3292E() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door.script_noteworthy) && door.script_noteworthy == "locked_door") {
      door._id_DEF557E8FD5C6763 = ::_id_3C9EBC3DBF9C2AB8;
      continue;
    }

    if(isDefined(door._id_8F7EDDC9C0864A1B) && issubstr(door._id_8F7EDDC9C0864A1B, "third_floor") || issubstr(door._id_8F7EDDC9C0864A1B, "armory_room"))
      door._id_DEF557E8FD5C6763 = ::_id_ADB016554818CDB6;
  }
}

_id_3C9EBC3DBF9C2AB8(door, player) {
  _id_55171CF6D82389B2 = getscriptablearray(door.node.target, "targetname");

  foreach(_id_E71D90DD6D0F11F5 in _id_55171CF6D82389B2) {
    _id_E71D90DD6D0F11F5 setscriptablepartstate("light", "unlock");
    playsoundatpos(_id_E71D90DD6D0F11F5.origin, "br_keypad_confirm");
  }
}

_id_ADB016554818CDB6(door, player) {
  if(issubstr(door._id_8F7EDDC9C0864A1B, "third_floor")) {
    if(!isDefined(level._id_0C37DDB982D3177D)) {
      level._id_0C37DDB982D3177D = 1;
      player _id_D50D0A086958E440("stat_7F4E32E3118376D1", "doorsUnlocked");
    }
  } else if(issubstr(door._id_8F7EDDC9C0864A1B, "armory_room")) {
    if(!isDefined(level._id_899C36D7711CF275)) {
      level._id_899C36D7711CF275 = 1;
      player _id_D50D0A086958E440("stat_8F214DB6809E7A45", "doorsUnlocked");
    }
  }
}

_id_F1FA5EB8C61DC286() {
  level endon("game_ended");

  while(!isDefined(level._id_0E6BF347FCA0E305))
    waitframe();

  _id_A104C9A2CE03651B = scripts\engine\utility::getStructArray("dmz_safe_must_spawn", "script_noteworthy");
  _id_FC171D98B1FE8F6B = spawnStruct();
  _id_FC171D98B1FE8F6B.origin = (1246, 3200, 400);
  _id_FC171D98B1FE8F6B.angles = (0, 90, 0);
  _id_FC171D98B1FE8F6B._id_B205D90302DA2F07 = "biolabs_main";
  _id_FC171D98B1FE8F6B.script_noteworthy = "dmz_safe_must_spawn_weapon_case";
  _id_A104C9A2CE03651B[_id_A104C9A2CE03651B.size] = _id_FC171D98B1FE8F6B;
  _id_3AACF02225CA0DA5::_id_F9EC88C3D71324CD("brloot_weaponcase_black");

  foreach(_id_00CDDE8E8FC33AF4 in _id_A104C9A2CE03651B) {
    _id_CAA1515C4AD207EB = undefined;

    if(_id_00CDDE8E8FC33AF4.script_noteworthy == "dmz_safe_must_spawn_weapon_case")
      _id_CAA1515C4AD207EB = 18006;

    _id_662CBAC61C1AE7E2::_id_D2441B457FA14419(_id_00CDDE8E8FC33AF4, _id_CAA1515C4AD207EB);
  }
}

_id_972D10285EF59CD6(node) {
  if(node.script_noteworthy == "dmz_safe_must_spawn")
    return "dmz_biolab_safe_core_lab";
  else
    return "dmz_biolab_safe";
}

_id_39643776A698EFCE(tier) {
  switch (tier) {
    case 1:
      return scripts\engine\utility::random(["semtex_mp", "frag_grenade_mp", "gas_mp"]);
    case 2:
      return scripts\engine\utility::random(["semtex_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "decoy_grenade_mp"]);
    case 3:
      return scripts\engine\utility::random(["thermite_mp", "snapshot_grenade_mp", "decoy_grenade_mp"]);
    default:
      return undefined;
  }
}

_id_018D92A94227452E() {
  level endon("game_ended");
  level waittill("match_start_real_countdown");
  _id_3768A58EEF72D3D2 = scripts\engine\utility::getStructArray("dmz_safe", "script_noteworthy");
  _id_135E081B84EA2856 = scripts\engine\utility::getStructArray("dmz_safe_must_spawn", "script_noteworthy");
  level._id_86E3ED45FD12BF21 = _id_3768A58EEF72D3D2.size + _id_135E081B84EA2856.size;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", ::_id_B86CD1CA19B1DCBB);
}

_id_B86CD1CA19B1DCBB(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!istrue(instance._id_2F6D90A8A64D75FC)) {
    _id_F7035067E16DF948(20);
    _id_52C4C7423DA6A533 = level._id_F2A8E4A4AF870513;
    _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("safe_open_reinforcement", instance.origin, 64);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52C4C7423DA6A533.size; _id_AC0E594AC96AA3A8++) {
      if(ispointinvolume(instance.origin, level._id_029CED2D4D9A0BDE[_id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8]]))
        _id_2D9C29F869A29FCA::_id_7610D369D923704B("bio_lab_" + _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] + "_vo");
    }

    instance._id_2F6D90A8A64D75FC = 1;
  }
}

_id_01421D2332D0A4B9() {
  level thread _id_D93A11A247342773(self);
}

_id_D93A11A247342773(_id_32605DB102447D94) {
  wait 3;
  _id_52C4C7423DA6A533 = level._id_F2A8E4A4AF870513;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52C4C7423DA6A533.size; _id_AC0E594AC96AA3A8++) {
    if(ispointinvolume(_id_32605DB102447D94.origin, level._id_029CED2D4D9A0BDE[_id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8]])) {
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_" + _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] + "_captured", level.players);
      break;
    }
  }
}

_id_B6D133C0B94DFB83() {
  level endon("game_ended");
  _id_608B5DF3A17E09D3 = ["office_note_node", "green_note_node", "garage_note_node", "locker_note_node", "restaurant_note_node", "lab_note_node", "armory_note_node", "black_note_node", "blue_note_node", "hospital_note_node"];
  groups["office_note_node"] = [];
  groups["office_note_node"][groups["office_note_node"].size] = [1, ["interactable_note_security02"]];
  groups["office_note_node"][groups["office_note_node"].size] = [1, ["interactable_note_security01", "interactable_note_security03"]];
  groups["office_note_node"][groups["office_note_node"].size] = [1, ["interactable_note_miscellaneous03", "interactable_note_miscellaneous06"]];
  groups["green_note_node"] = [];
  groups["green_note_node"][groups["green_note_node"].size] = [1, ["interactable_note_miscellaneous01"]];
  groups["garage_note_node"] = [];
  groups["garage_note_node"][groups["garage_note_node"].size] = [1, ["interactable_note_miscellaneous02"]];
  groups["locker_note_node"] = [];
  groups["locker_note_node"][groups["garage_note_node"].size] = [2, ["interactable_note_miscellaneous07", "interactable_note_miscellaneous08", "interactable_note_miscellaneous10"]];
  groups["restaurant_note_node"] = [];
  groups["restaurant_note_node"][groups["restaurant_note_node"].size] = [1, ["interactable_note_miscellaneous09"]];
  groups["lab_note_node"] = [];
  groups["lab_note_node"][groups["lab_note_node"].size] = [1, ["interactable_notebook_researcher01"]];
  groups["lab_note_node"][groups["lab_note_node"].size] = [2, ["interactable_notebook_researcher02", "interactable_notebook_researcher03", "interactable_notebook_researcher04", "interactable_notebook_researcher05"]];
  groups["armory_note_node"] = [];
  groups["armory_note_node"][groups["armory_note_node"].size] = [1, ["interactable_notebook_officer01"]];
  groups["armory_note_node"][groups["armory_note_node"].size] = [1, ["interactable_notebook_officer02", undefined]];
  groups["black_note_node"] = [];
  groups["black_note_node"][groups["black_note_node"].size] = [1, ["interactable_notebook_officer03"]];
  groups["blue_note_node"] = [];
  groups["blue_note_node"][groups["blue_note_node"].size] = [1, ["interactable_notebook_officer04", "interactable_notebook_officer05"]];
  groups["hospital_note_node"] = [];
  groups["hospital_note_node"][groups["hospital_note_node"].size] = [1, ["interactable_notebook_medical01"]];
  groups["hospital_note_node"][groups["hospital_note_node"].size] = [1, ["interactable_notebook_medical02", "interactable_notebook_medical03"]];
  level waittill("match_start_real_countdown");

  foreach(_id_03007C5B5FC67992 in _id_608B5DF3A17E09D3) {
    nodes = scripts\engine\utility::getStructArray(_id_03007C5B5FC67992, "script_noteworthy");

    if(nodes.size > 0) {
      _id_0CEC63015027246B = scripts\engine\utility::array_randomize(nodes);
      _id_9A8979997C09AD76 = groups[_id_03007C5B5FC67992];
      _id_6B64CC5A249331EF = 0;

      foreach(group in _id_9A8979997C09AD76) {
        _id_193413008FE594EC = group[0];
        _id_C93358415AFAC330 = scripts\engine\utility::array_randomize(group[1]);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_193413008FE594EC; _id_AC0E594AC96AA3A8++) {
          item = _id_C93358415AFAC330[_id_AC0E594AC96AA3A8];

          if(isDefined(item)) {
            _id_891151F53EF6871B = (0, 0, 0);
            droporigin = _id_0CEC63015027246B[_id_6B64CC5A249331EF].origin;
            _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(droporigin, _id_891151F53EF6871B);
            _id_7E52B56769FA7774::spawnpickup(item, _id_CB4FAD49263E20C4, 1, 0);
            _id_6B64CC5A249331EF++;
          }
        }
      }
    }
  }
}

_id_95C3237DDFEDED60() {
  level endon("game_ended");
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_C49A8EF1A2B2E34B);
  level._id_EE8014E69E598710 = spawnStruct();
  level._id_EE8014E69E598710.capturetime = getdvarint("dvar_3F688557DFBC6BD8", 20);

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_A756B8F9BD080783 = scripts\engine\utility::getStruct("bio_data_center_hack", "script_noteworthy");

  for(;;) {
    level waittill("lpcon_current_alert_level_updated", alertlevel);

    if(alertlevel >= 3) {
      level._id_EE8014E69E598710.scriptable = _id_707EC36062DBE241(_id_A756B8F9BD080783);
      break;
    }
  }
}

_id_707EC36062DBE241(node) {
  _id_D17C5900F5FD0FEA = spawnscriptable("iw9_biolabs_data_center_hack", node.origin, (0, 0, 0));
  _id_D17C5900F5FD0FEA.capturetime = level._id_EE8014E69E598710.capturetime;
  _id_D17C5900F5FD0FEA.curorigin = _id_D17C5900F5FD0FEA.origin;
  _id_D17C5900F5FD0FEA.offset3d = (0, 0, 15);
  _id_D17C5900F5FD0FEA scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = _id_D17C5900F5FD0FEA.objidnum;
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(objid, _id_D17C5900F5FD0FEA.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::_id_A28E8535E00D34F3(objid);
  scripts\mp\objidpoolmanager::_id_6AE37618BB04EA60(objid);
  _id_D17C5900F5FD0FEA.node = node;
  node._id_D17C5900F5FD0FEA = _id_D17C5900F5FD0FEA;
  _id_D17C5900F5FD0FEA setscriptablepartstate("hack_point", "usable_not_hack");
  _id_76343924ED44E9D0 = 500;
  _id_D17C5900F5FD0FEA.trigger = spawn("trigger_radius", _id_D17C5900F5FD0FEA.node.origin, 0, _id_76343924ED44E9D0, _id_76343924ED44E9D0);
  _id_D17C5900F5FD0FEA.trigger scripts\engine\utility::trigger_off();
  _id_D17C5900F5FD0FEA thread _id_A2449C0A5C59855A(_id_D17C5900F5FD0FEA.trigger, _id_76343924ED44E9D0);
  return _id_D17C5900F5FD0FEA;
}

_id_A2449C0A5C59855A(trigger, radius) {
  level endon("game_ended");
  self endon("data_center_hacked");
  self._id_78122E18403A8DC4 = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.teams, player.team))
      self.teams[self.teams.size] = player.team;

    self._id_78122E18403A8DC4[self._id_78122E18403A8DC4.size] = player;
    childthread _id_3AD3ADE21C77AA53(trigger, player, radius);
  }
}

_id_3AD3ADE21C77AA53(trigger, player, radius) {
  _id_5BF0CCB545DC79B2 = squared(radius * 1.2);
  _id_201167EF5389470B = _id_AB9B0BB33C9FC28F(trigger.origin);

  while(isDefined(player) && isalive(player) && isDefined(trigger) && distance2dsquared(trigger.origin, player.origin) < _id_5BF0CCB545DC79B2 && _id_201167EF5389470B == _id_AB9B0BB33C9FC28F(player.origin))
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}

_id_C49A8EF1A2B2E34B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level endon("game_ended");

  if(state == "usable_not_hack") {
    instance setscriptablepartstate(part, "unusable_hacking");
    instance.teams = [player.team];
    instance.trigger scripts\engine\utility::trigger_on();
    scripts\mp\objidpoolmanager::update_objective_icon(instance.objidnum, "ui_map_icon_datacenter_hack");
    scripts\mp\objidpoolmanager::update_objective_setbackground(instance.objidnum, 1);
    scripts\mp\objidpoolmanager::update_objective_state(instance.objidnum, "current");
    scripts\mp\objidpoolmanager::objective_show_progress(instance.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(instance.objidnum, player.team);
    instance thread _id_2FA7C0CE5A46707F(player);
    wait 1.0;
  }
}

_id_2FA7C0CE5A46707F(hacker) {
  level endon("game_ended");
  _id_C5C6ECF6F8F9C5F5 = 100;
  self.progress = 0;
  _id_90FB369A18926018 = [];

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(isalive(hacker) && !scripts\mp\utility\player::isinlaststand(hacker) && hacker useButtonPressed() && distance2dsquared(self.origin, hacker.origin) < squared(_id_C5C6ECF6F8F9C5F5))
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      else {
        progress = 0;
        self.progress = 0;
        _id_90FB369A18926018 = _id_5ABC330466124394([], _id_90FB369A18926018, progress);
        scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
        self setscriptablepartstate("hack_point", "usable_not_hack");
        return;
      }

      progress = self.progress / self.capturetime;
      _id_90FB369A18926018 = _id_5ABC330466124394(self._id_78122E18403A8DC4, _id_90FB369A18926018, progress);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

      if(self.progress >= self.capturetime) {
        _id_70F93D3E6A67F524();
        return;
      }

      if(!istrue(self._id_8B5682BB8AAE1441)) {
        self._id_8B5682BB8AAE1441 = 1;
        _id_9D71CDF2360E7359();
      }
    }

    waitframe();
  }
}

_id_9D71CDF2360E7359() {
  _id_F7035067E16DF948(20);
  _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("hack_point_open_reinforcement", self.origin);
}

_id_5ABC330466124394(_id_78122E18403A8DC4, _id_90FB369A18926018, progress) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);
  _id_F6FD7B0E73C3270C = _id_90FB369A18926018;

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      if(scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(self.objidnum, player, 1, 2, &"MP_BIO_LAB/HACKING_DOOR")) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);
        _id_F6FD7B0E73C3270C = scripts\engine\utility::array_add(_id_F6FD7B0E73C3270C, player);
      }

      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
      _id_F6FD7B0E73C3270C = scripts\engine\utility::array_remove(_id_F6FD7B0E73C3270C, player);
    }
  }

  return _id_F6FD7B0E73C3270C;
}

_id_70F93D3E6A67F524() {
  self.trigger delete();

  foreach(team in self.teams) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self.objidnum, player);
      player setplayermusicstate("");
      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_903730F789CD3EA8");

      if(!isDefined(player.brmissionscompleted))
        player.brmissionscompleted = 0;

      player.brmissionscompleted++;
    }
  }

  scripts\mp\gameobjects::releaseid();
  self setscriptablepartstate("hack_point", "hacked");
  self notify("data_center_hacked");
  _id_0E1CA44858CD8EA1("bio_lab_server_hacked");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_data_center_hacked", level.players);
  level thread _id_F55B62486A35DB44();
}

_id_F55B62486A35DB44() {
  level endon("game_ended");
  wait 2;

  foreach(door in level._id_F64C6EF6F688A407) {
    if(isDefined(door._id_8F7EDDC9C0864A1B) && issubstr(door._id_8F7EDDC9C0864A1B, "armory_room"))
      door._id_65513AD5397A67EF = "activity_key_bio_lab";
  }
}

_id_B09BDA767D8E5510() {
  level endon("game_ended");

  while(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap"))
    waitframe();

  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", ::showminimap);
}

showminimap() {
  if(isDefined(self.minimapstatetracker) && self.minimapstatetracker == 0) {
    return;
  }
  scripts\mp\utility\player::showminimap();
}

_id_C14085508A258DAA() {
  level endon("game_ended");
  level thread _id_B09BDA767D8E5510();
  level waittill("matchStartTimer_done");
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_lab_match_start_1");
  wait 1;
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_lab_match_start_2");
  wait 4;
  _id_AB20D758351BCF28(3);
  wait 7;
  _id_AB20D758351BCF28(1);
  scripts\mp\compass::setupminimap("compass_map_mp_bio_lab_glitched");
  _id_5307834CD39B435C::_id_9FDF14C5AAC8CE53("bio_lab_minimap_lost");
  wait 3;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::hideminimap(1);
  }

  level.minimaponbydefault = 0;
  _id_AB20D758351BCF28(0);
}

_id_AB20D758351BCF28(_id_0C0AB0189903C9D4) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player setclientomnvar("ui_jammer_strength", _id_0C0AB0189903C9D4);
  }
}

ontimelimit() {
  if(!istrue(level._id_99EADAE60B4B76E4)) {
    level thread _id_7E32C4283965A098::_id_CC8CF9C935AC4C33();
    level thread checkendgame();
    level._id_99EADAE60B4B76E4 = 1;
  }
}

checkendgame() {
  _id_CC748B6D457627FE = level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[5];
  setomnvar("ui_hardpoint_timer", gettime() + _id_CC748B6D457627FE * 1000);
  wait(_id_CC748B6D457627FE);
  level notify("dmz_bio_lab_shutdown_all_elevators");
}

_id_D50D0A086958E440(event, _id_401C3A2E68AAB0FD) {
  if(!isDefined(self.team)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    player scripts\mp\utility\points::_id_0366980B6A8796AE(event);

    if(isDefined(_id_401C3A2E68AAB0FD) && _id_401C3A2E68AAB0FD == "doorsUnlocked") {
      if(!isDefined(player._id_BD3FCBFDEDA97E97))
        player._id_BD3FCBFDEDA97E97 = 0;

      player._id_BD3FCBFDEDA97E97++;
    }
  }
}

_id_32984D4A50907183(_id_9156B53BCF7CE573) {
  if(!istrue(_id_9156B53BCF7CE573)) {
    self setclientomnvar("ui_br_extended_load_screen", 1);
    thread _id_C993EB77452B234F();
  }
}

_id_C993EB77452B234F() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("player_active");
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

_id_B4A2657BE39CB0F7() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", player);

    if(isDefined(player))
      _id_0B7A9CE0A2282B79::_id_3B6AC6FDE1B3E84A(player);
  }
}

_id_88DA8F668FB08473() {
  _id_DD62A2ED6A6020E4 = [[2, 50], [3, 30], [3, 90], [3, 150], [3, 240], [4, 30], [4, 90], [4, 150], [4, 240], [4, 295]];
  _id_6A1A4BECACA01C55 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DD62A2ED6A6020E4.size; _id_AC0E594AC96AA3A8++) {
    _id_C7C462831D10BC7B = _id_DD62A2ED6A6020E4[_id_AC0E594AC96AA3A8][0];
    _id_8DFC0A6A9058E951 = _id_DD62A2ED6A6020E4[_id_AC0E594AC96AA3A8][1];

    if(!isDefined(_id_C7C462831D10BC7B) || !(_id_C7C462831D10BC7B > 0 && _id_C7C462831D10BC7B <= 5)) {
      continue;
    }
    if(!isDefined(_id_6A1A4BECACA01C55[_id_C7C462831D10BC7B]))
      _id_6A1A4BECACA01C55[_id_C7C462831D10BC7B] = [];

    if(_id_8DFC0A6A9058E951 > level._id_A7B62649C81B481A._id_6C28286E5A71C7CC[_id_C7C462831D10BC7B])
      continue;
    else {
      if(_id_6A1A4BECACA01C55[_id_C7C462831D10BC7B].size > 0) {
        _id_FEAE4FF45C9ACB85 = _id_6A1A4BECACA01C55[_id_C7C462831D10BC7B][_id_6A1A4BECACA01C55[_id_C7C462831D10BC7B].size - 1];

        if(_id_8DFC0A6A9058E951 != _id_FEAE4FF45C9ACB85)
          _id_6A1A4BECACA01C55[_id_C7C462831D10BC7B][_id_6A1A4BECACA01C55[_id_C7C462831D10BC7B].size] = _id_8DFC0A6A9058E951;

        continue;
      }

      _id_6A1A4BECACA01C55[_id_C7C462831D10BC7B][_id_6A1A4BECACA01C55[_id_C7C462831D10BC7B].size] = _id_8DFC0A6A9058E951;
    }
  }

  return _id_6A1A4BECACA01C55;
}

_id_F7035067E16DF948(_id_26DE0898FFB55B5E) {
  level thread _id_D0A0C33D43E5F33D(_id_26DE0898FFB55B5E);
}

_id_D0A0C33D43E5F33D(_id_26DE0898FFB55B5E) {
  level notify("time_events_stop_watching");
  level endon("game_ended");
  level endon("time_events_stop_watching");
  level._id_FFAA80D9780980E9 = 1;
  wait(_id_26DE0898FFB55B5E);
  level._id_FFAA80D9780980E9 = 0;
}

_id_43D8CD9C9D19938C() {
  level endon("game_ended");
  _id_6A1A4BECACA01C55 = _id_88DA8F668FB08473();
  level._id_FFAA80D9780980E9 = 0;

  for(;;) {
    level waittill("lpcon_current_alert_level_updated", alertlevel);

    if(!isDefined(_id_6A1A4BECACA01C55[alertlevel])) {
      continue;
    }
    _id_CFE20483B957C26B = 0;
    _id_8DFC0A6A9058E951 = 0;

    for(index = 0; index < _id_6A1A4BECACA01C55[alertlevel].size; index++) {
      _id_1D62BF67C3570B4F = _id_6A1A4BECACA01C55[alertlevel][index];
      _id_8DFC0A6A9058E951 = _id_1D62BF67C3570B4F - _id_CFE20483B957C26B;
      _id_CFE20483B957C26B = _id_1D62BF67C3570B4F;
      wait(_id_8DFC0A6A9058E951);

      if(_id_8DFC0A6A9058E951 >= 0 && !level._id_FFAA80D9780980E9)
        _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("time_" + _id_1D62BF67C3570B4F + "_" + alertlevel);
    }
  }
}

_id_E195A599FEDEB50F() {
  if(getdvarint("dvar_53C04E45FB1C6A13", 1) == 0) {
    return;
  }
  _id_BE6A845C01EFBE73 = scripts\engine\utility::getStructArray("spawnPackage_mainNode_friendly", "script_noteworthy");
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4("merc");
  level._id_CB61F2F08271E0BE = [];
  _id_CB61F2F08271E0BE = [];
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (1980, 2581, 258);
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (624, 1049, 258);
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (224, 2754, 258);
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (-1375, 1812, 261);
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (271, 1830, 105);
  _id_CB61F2F08271E0BE[_id_CB61F2F08271E0BE.size] = (1918, 1836, 72);

  foreach(origin in _id_CB61F2F08271E0BE) {
    struct = spawnStruct();
    struct.origin = origin;
    level._id_CB61F2F08271E0BE[level._id_CB61F2F08271E0BE.size] = struct;
  }

  level._id_98EB297041E18F1C = [];

  foreach(_id_F44BDB70807D60A9 in _id_BE6A845C01EFBE73) {
    if(!isDefined(_id_F44BDB70807D60A9.target)) {
      continue;
    }
    _id_9000AA3A8F0B6304 = spawnStruct();
    _id_9000AA3A8F0B6304._id_2EF873E30A270BCF = [];
    _id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094 = [];
    _id_DA8B6C7C8AD40CE1 = scripts\engine\utility::getStructArray(_id_F44BDB70807D60A9.target, "targetname");

    foreach(node in _id_DA8B6C7C8AD40CE1) {
      if(isDefined(node.script_noteworthy)) {
        script_noteworthy = tolower(node.script_noteworthy);

        if(issubstr(script_noteworthy, "guard"))
          _id_9000AA3A8F0B6304._id_2EF873E30A270BCF[_id_9000AA3A8F0B6304._id_2EF873E30A270BCF.size] = node;
        else if(issubstr(script_noteworthy, "patrolstart") || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(node, issubstr(script_noteworthy, "looped"));
          _id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094[_id_9000AA3A8F0B6304._id_D7BAAFC9B07F5094.size] = pathstruct;
        }
      }
    }

    _id_9000AA3A8F0B6304.origin = _id_371B4C2AB5861E62::getaverageorigin(_id_9000AA3A8F0B6304._id_2EF873E30A270BCF);
    level._id_98EB297041E18F1C[level._id_98EB297041E18F1C.size] = _id_9000AA3A8F0B6304;
  }

  wait 5;
  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("player_hs1_sc1", "merc");
  _id_A29542B03C0C020C();
}

_id_94338AB67615ED1E() {
  _id_39AF85A22B856F0C = [];
  _id_D2942D8DC1A8C16B = [];

  foreach(player in level.players) {
    if(scripts\engine\utility::array_contains(_id_39AF85A22B856F0C, player.team)) {
      continue;
    }
    level._id_98EB297041E18F1C = sortbydistance(level._id_98EB297041E18F1C, player.origin);
    _id_D2942D8DC1A8C16B[_id_D2942D8DC1A8C16B.size] = level._id_98EB297041E18F1C[0];
  }

  return _id_D2942D8DC1A8C16B;
}

_id_A29542B03C0C020C() {
  _id_AED1C21FACC1B720 = _id_94338AB67615ED1E();

  foreach(_id_9000AA3A8F0B6304 in _id_AED1C21FACC1B720) {
    _id_9000AA3A8F0B6304._id_8E5A9B658FA525ED = "merc";
    agents = _id_48814951E916AF89::_id_376608277AA1067C(_id_9000AA3A8F0B6304, 3, undefined, "absolute");

    if(!isDefined(agents)) {
      continue;
    }
    _id_454390E59977CA39 = scripts\engine\utility::random(level._id_CB61F2F08271E0BE).origin;
    _id_74B5B12BB6514385 = 0.1;

    foreach(agent in agents) {
      _id_371B4C2AB5861E62::_id_58203C3739D2D0C6(agent, "merc", 1);
      agent.aggressivemode = 1;
      agent thread _id_51E3600D1BDEB2D4(agent, _id_454390E59977CA39, _id_74B5B12BB6514385, 0);
      _id_74B5B12BB6514385 = _id_74B5B12BB6514385 + 0.25;
    }
  }
}

_id_51E3600D1BDEB2D4(agent, origin, _id_74B5B12BB6514385, _id_D9D03506425FCEF1) {
  agent endon("death");
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!isDefined(_id_74B5B12BB6514385))
    _id_74B5B12BB6514385 = 1;

  if(!isDefined(_id_D9D03506425FCEF1))
    _id_D9D03506425FCEF1 = randomfloatrange(_id_74B5B12BB6514385 * -0.5, _id_74B5B12BB6514385 * 0.5);

  wait(_id_74B5B12BB6514385 + _id_D9D03506425FCEF1);
  _id_5A4AF0D517342216 = 0;
  agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin);
}

_id_90ABDBF9EE65BB1B() {
  level._id_97718BB0CB314F6B = "ru";
  level._id_5D6209C724CFEAC7 = [];
  level._id_5D6209C724CFEAC7["merc"] = "merc";
  level._id_5D6209C724CFEAC7["biolab"] = "merc";

  foreach(group in level._id_5D6209C724CFEAC7)
  _id_371B4C2AB5861E62::_id_841F001AE930B5E4(group);

  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("player_hs1_sc1", "merc");
  _id_371B4C2AB5861E62::_id_3ACCE87FED325C8F("player_hs0_sc1", "merc");
}

_id_50848C14636B3377(agent, attacker, inflictor, meansofdeath) {
  if(!isDefined(attacker))
    return 0;

  if(!isPlayer(attacker))
    return 0;

  if(isDefined(attacker._id_97BEFA07A2CF366E) && istrue(attacker._id_97BEFA07A2CF366E[agent.threatbiasgroup]))
    return 0;

  _id_BB5F8AACF8D1F56A = agent getthreatbiasgroup();
  isenemy = 0;
  _id_869946FB307D9B67 = _id_371B4C2AB5861E62::_id_1BCA33010B895B0B(_id_BB5F8AACF8D1F56A);

  if(isDefined(_id_869946FB307D9B67))
    isenemy = !_id_371B4C2AB5861E62::_id_46C0DE7595D8CAB2(attacker, _id_869946FB307D9B67);

  if(istrue(isenemy))
    return 0;

  if(_id_BB5F8AACF8D1F56A == "merc" && (isPlayer(attacker) || isDefined(inflictor) && isDefined(inflictor.owner) && isPlayer(inflictor.owner))) {
    if(!isDefined(attacker._id_C669906A542B9BAF))
      attacker._id_C669906A542B9BAF = [];

    if(!isDefined(attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A]))
      attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A] = 0;

    attacker._id_C669906A542B9BAF[_id_BB5F8AACF8D1F56A]++;
    _id_4480C6CE37B2BDF3::_id_39ACEB03C0AACE46(attacker, meansofdeath);

    if(isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION")
      return 0;

    return 1;
  }

  return 0;
}