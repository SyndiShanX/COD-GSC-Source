/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
***********************************************/

processepictaunt(_id_E29F06F057B7E344, _id_1812C7DD1624DC00, _id_7C7944E573770A11) {
  if(_id_1812C7DD1624DC00 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    spawnposition = level.camera_bro_shot.char_loc[_id_1812C7DD1624DC00].origin;
    spawnangles = level.camera_bro_shot.char_loc[_id_1812C7DD1624DC00].angles;

    if(isDefined(level.overridebroslot))
      _id_1812C7DD1624DC00 = level.overridebroslot - 1;
  } else {
    spawnposition = level.charactercac.origin;
    spawnangles = level.charactercac.angles;
    _id_1812C7DD1624DC00 = 0;
  }

  if(tauntinprogress(_id_1812C7DD1624DC00)) {
    return;
  }
  processtauntsound(_id_E29F06F057B7E344);
  deleteepictauntprops(_id_1812C7DD1624DC00);
  _id_70ECB085AE637DD3 = [];
  _id_7B967D0282DB45C6 = [];
  _id_EE7B03B3C11DFDBA = [];
  _id_82A4871F12DEAB59 = [];
  _id_1AE319F5B9E444BE = [];
  scriptableparts = [];
  scriptablestates = [];
  _id_8D4030ADF07C9980 = [];
  _id_F6D8E27292D6C487 = 0;
  _id_2372FCA1DCF655E7 = 0;
  _id_2AEBC2829E85250D = [];
  _id_DE7392BC3D3B9AC7 = [];
  _id_6362B2735BC6A060 = [];
  _id_333441E3306E4001 = [];
  _id_5CC9179D6C08DCE7 = [];
  _id_C1814436EBB28EC0 = 0;
  _id_CC2917C28ACE6BFD = 0;
  _id_95D759A18FED520D = [];
  _id_F06A863F7C8D9384 = [];
  _id_35728324A5C3B9FE = [];
  _id_E2CD8F5BF67E12CC = [];
  _id_F2039C9914FCDDAD = 0;
  _id_37C1E840C7CC8F00 = [];
  _id_F788385258E010B3 = 0;

  switch (_id_E29F06F057B7E344) {
    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(_id_7C7944E573770A11 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        _id_EE7B03B3C11DFDBA[0] = 10.0;
        _id_F06A863F7C8D9384[0] = 0.85;
        _id_F06A863F7C8D9384[1] = 2.05;
        _id_F06A863F7C8D9384[2] = 1.15;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(_id_7C7944E573770A11 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        _id_EE7B03B3C11DFDBA[0] = 10.0;
        _id_F06A863F7C8D9384[0] = 1.1;
        _id_F06A863F7C8D9384[1] = 2.7;
        _id_F06A863F7C8D9384[2] = 1.467;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(_id_7C7944E573770A11 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        _id_EE7B03B3C11DFDBA[0] = 10.0;
        _id_F06A863F7C8D9384[0] = 1.03;
        _id_F06A863F7C8D9384[1] = 2.76;
        _id_F06A863F7C8D9384[2] = 1.43;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_cod_champs":
      _id_EE7B03B3C11DFDBA[0] = 7.834;
      break;
    case "iw7_mp_taunt_super_blackhole":
      _id_EE7B03B3C11DFDBA[0] = 7.0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 20; _id_AC0E594AC96AA3A8++)
        _id_95D759A18FED520D[_id_AC0E594AC96AA3A8] = 2.6 + _id_AC0E594AC96AA3A8 * 0.1;

      break;
    case "iw7_mp_taunt_epic_grenade_toss_back01":
      _id_EE7B03B3C11DFDBA[0] = 8.0;
      _id_95D759A18FED520D[0] = 5.7;
      _id_95D759A18FED520D[1] = 6.15;
      _id_95D759A18FED520D[2] = 6.6;
      break;
    case "iw7_mp_taunt_super_warfighter_at_screen":
      _id_EE7B03B3C11DFDBA[0] = 6.6;
      _id_95D759A18FED520D[0] = 1.0;
      _id_95D759A18FED520D[1] = 1.2;
      _id_95D759A18FED520D[2] = 1.4;
      _id_95D759A18FED520D[3] = 1.6;
      _id_95D759A18FED520D[4] = 1.8;
      _id_95D759A18FED520D[5] = 2.0;
      _id_95D759A18FED520D[6] = 2.2;
      _id_95D759A18FED520D[7] = 2.4;
      break;
    case "iw7_mp_taunt_bio_spike":
      _id_EE7B03B3C11DFDBA[0] = 6.6;
      _id_95D759A18FED520D[0] = 1.65;
      _id_95D759A18FED520D[1] = 2.05;
      break;
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
    case "iw7_mp_taunt_synaptic_reaper_3rd":
      _id_EE7B03B3C11DFDBA[0] = 6.6;
      _id_CC2917C28ACE6BFD = 2.0;
      break;
    case "iw7_mp_taunt_killstreak_scorcher":
      _id_70ECB085AE637DD3[0] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      _id_7B967D0282DB45C6[0] = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      _id_EE7B03B3C11DFDBA[0] = 6.6;
      _id_70ECB085AE637DD3[1] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      _id_7B967D0282DB45C6[1] = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      _id_EE7B03B3C11DFDBA[1] = 6.6;
      _id_70ECB085AE637DD3[2] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      _id_7B967D0282DB45C6[2] = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      _id_EE7B03B3C11DFDBA[2] = 6.6;
      _id_CC2917C28ACE6BFD = 3.0;
      _id_F788385258E010B3 = 1;
      break;
    case "iw7_mp_taunt_killstreak_c8":
      _id_70ECB085AE637DD3[0] = "mp_robot_c8";
      _id_7B967D0282DB45C6[0] = "iw7_mp_taunt_killstreak_c8_robot";
      _id_EE7B03B3C11DFDBA[0] = 5.5;
      _id_82A4871F12DEAB59[0] = [];
      _id_82A4871F12DEAB59[0][0] = "weapon_c8_shield_top_mp";
      _id_82A4871F12DEAB59[0][1] = "weapon_c8_shield_bottom_mp";
      _id_1AE319F5B9E444BE[0] = [];
      _id_1AE319F5B9E444BE[0][0] = "j_wristshield";
      _id_1AE319F5B9E444BE[0][1] = "j_wristbtmshield";
      _id_CC2917C28ACE6BFD = 1.67;
      _id_95D759A18FED520D[0] = 5.15;
      break;
    case "IW7_mp_taunt_killstreak_apex01":
      _id_70ECB085AE637DD3[0] = "veh_mil_air_ca_oblivion_drone_mp";
      _id_7B967D0282DB45C6[0] = "IW7_mp_taunt_killstreak_apex01_apex";
      _id_EE7B03B3C11DFDBA[0] = 5.0;
      _id_95D759A18FED520D[0] = 2.0;
      _id_95D759A18FED520D[1] = 2.4;
      _id_95D759A18FED520D[2] = 2.6;
      _id_95D759A18FED520D[3] = 3.2;
      _id_95D759A18FED520D[4] = 3.6;
      _id_95D759A18FED520D[5] = 3.8;
      break;
    case "iw7_mp_taunt_killstreak_thor":
      _id_70ECB085AE637DD3[0] = "veh_mil_air_thor_wm";
      _id_70ECB085AE637DD3[1] = "sdf_mp_cruise_missile_01";
      _id_70ECB085AE637DD3[2] = "un_mp_jackal_exterior_missile";
      _id_70ECB085AE637DD3[3] = "un_mp_jackal_exterior_missile";
      _id_70ECB085AE637DD3[4] = "un_mp_jackal_exterior_missile";
      _id_70ECB085AE637DD3[5] = "un_mp_jackal_exterior_missile";
      _id_70ECB085AE637DD3[6] = "un_mp_jackal_exterior_missile";
      _id_7B967D0282DB45C6[0] = "iw7_mp_taunt_killstreak_thor_prop";
      _id_7B967D0282DB45C6[1] = "iw7_mp_taunt_killstreak_thor_missile01";
      _id_7B967D0282DB45C6[2] = "iw7_mp_taunt_killstreak_thor_missile02";
      _id_7B967D0282DB45C6[3] = "iw7_mp_taunt_killstreak_thor_missile03";
      _id_7B967D0282DB45C6[4] = "iw7_mp_taunt_killstreak_thor_missile04";
      _id_7B967D0282DB45C6[5] = "iw7_mp_taunt_killstreak_thor_missile05";
      _id_7B967D0282DB45C6[6] = "iw7_mp_taunt_killstreak_thor_missile05";
      _id_EE7B03B3C11DFDBA[0] = 7.47;
      _id_EE7B03B3C11DFDBA[1] = 3.76;
      _id_EE7B03B3C11DFDBA[2] = 4.7;
      _id_EE7B03B3C11DFDBA[3] = 4.7;
      _id_EE7B03B3C11DFDBA[4] = 4.7;
      _id_EE7B03B3C11DFDBA[5] = 4.7;
      _id_EE7B03B3C11DFDBA[6] = 4.7;
      _id_F6D8E27292D6C487 = 1;
      _id_2372FCA1DCF655E7 = 1.5;
      _id_CC2917C28ACE6BFD = 4.5;
      _id_F788385258E010B3 = 1;
      break;
    case "IW7_mp_taunt_adrenaline":
      _id_70ECB085AE637DD3[0] = "equipment_mp_nanoshot_wm";
      _id_7B967D0282DB45C6[0] = "IW7_mp_taunt_adrenaline_nano";
      _id_EE7B03B3C11DFDBA[0] = 10.0;
      _id_95D759A18FED520D[0] = 7.5;
      break;
    case "iw7_mp_taunt_super_shootdown":
      _id_70ECB085AE637DD3[0] = "veh_mil_air_un_uav";
      _id_7B967D0282DB45C6[0] = "iw7_mp_taunt_super_shootdown_uav";
      _id_EE7B03B3C11DFDBA[0] = 6.0;
      _id_95D759A18FED520D[0] = 3.75;
      break;
    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak":
      scriptableparts[0] = "cloak";
      scriptablestates[0] = "on";
      _id_8D4030ADF07C9980[0] = 0.01;
      scriptableparts[1] = "cloak";
      scriptablestates[1] = "off";
      _id_8D4030ADF07C9980[1] = 1.5;
      scriptableparts[2] = "cloak";
      scriptablestates[2] = "on";
      _id_8D4030ADF07C9980[2] = 3.2;
      scriptableparts[3] = "cloak";
      scriptablestates[3] = "off";
      _id_8D4030ADF07C9980[3] = 4.7;
      _id_EE7B03B3C11DFDBA[0] = 5.1;
      _id_F6D8E27292D6C487 = 1;
      _id_2372FCA1DCF655E7 = 2.0;
      break;
    case "iw7_mp_taunt_super_merc_steeldragon":
      _id_2AEBC2829E85250D[0] = 0.466;
      _id_DE7392BC3D3B9AC7[0] = 2.85;
      _id_6362B2735BC6A060[0] = "tag_accessory_right";
      _id_333441E3306E4001[0] = "tag_accessory_left";
      _id_5CC9179D6C08DCE7[0] = "vfx_taunt_steel_dragon";
      _id_EE7B03B3C11DFDBA[0] = 4.0;
      _id_95D759A18FED520D[0] = 0.5;
      _id_95D759A18FED520D[1] = 0.7;
      _id_95D759A18FED520D[2] = 0.9;
      _id_95D759A18FED520D[3] = 1.0;
      _id_95D759A18FED520D[4] = 1.2;
      _id_95D759A18FED520D[5] = 1.4;
      _id_95D759A18FED520D[6] = 1.6;
      _id_95D759A18FED520D[7] = 1.8;
      _id_95D759A18FED520D[8] = 2.0;
      _id_95D759A18FED520D[9] = 2.2;
      _id_95D759A18FED520D[10] = 2.4;
      _id_95D759A18FED520D[11] = 2.7;
      _id_95D759A18FED520D[12] = 2.9;
      _id_95D759A18FED520D[13] = 3.1;
      break;
    case "iw7_mp_taunt_killstreak_laser_strike":
      _id_EE7B03B3C11DFDBA[0] = 12.0;
      _id_35728324A5C3B9FE[0] = "vfx_bombard_antigrav_pre_expl";
      _id_35728324A5C3B9FE[1] = "vfx_bombard_projectile_trail";
      _id_F2039C9914FCDDAD = 0.2;
      _id_E2CD8F5BF67E12CC[0] = (0, 80, 0);
      _id_E2CD8F5BF67E12CC[1] = (75, 140, 0);
      _id_E2CD8F5BF67E12CC[2] = (-165, 250, 0);
      _id_E2CD8F5BF67E12CC[3] = (50, 200, 0);
      _id_E2CD8F5BF67E12CC[4] = (155, 250, 0);
      _id_E2CD8F5BF67E12CC[5] = (-75, 140, 0);
      _id_E2CD8F5BF67E12CC[6] = (-50, 200, 0);
      _id_37C1E840C7CC8F00[0] = 1.0;
      _id_37C1E840C7CC8F00[1] = 1.0;
      _id_37C1E840C7CC8F00[2] = 3.5;
      _id_95D759A18FED520D[0] = 3.5;
      _id_95D759A18FED520D[1] = 3.7;
      _id_95D759A18FED520D[2] = 3.9;
      _id_95D759A18FED520D[3] = 4.1;
      _id_95D759A18FED520D[4] = 4.3;
      _id_95D759A18FED520D[5] = 4.5;
      _id_95D759A18FED520D[6] = 4.7;
      _id_95D759A18FED520D[7] = 4.9;
      break;
    default:
      return;
  }

  level.broshotepictauntprops[_id_1812C7DD1624DC00] = [];
  level.broshotepictauntsubprops[_id_1812C7DD1624DC00] = [];

  if(_id_7C7944E573770A11 && _id_F6D8E27292D6C487) {
    if(!isDefined(level.queuedtaunts))
      level.queuedtaunts = [];

    if(isDefined(level.queuedtaunts[_id_E29F06F057B7E344])) {
      _id_52A8289D33EC4212 = gettime() - level.queuedtaunts[_id_E29F06F057B7E344];

      if(_id_52A8289D33EC4212 < _id_2372FCA1DCF655E7 * 1000)
        wait(_id_2372FCA1DCF655E7 - _id_52A8289D33EC4212 / 1000);
    }

    level.queuedtaunts[_id_E29F06F057B7E344] = gettime();
  }

  _id_C2120FCD901646C8 = (0, 0, 0);

  if(_id_F788385258E010B3 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1)
    _id_C2120FCD901646C8 = (180, 180, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_70ECB085AE637DD3.size; _id_AC0E594AC96AA3A8++) {
    _id_B9BF54C11065FDF7 = spawn("script_model", spawnposition);
    _id_B9BF54C11065FDF7 setModel(_id_70ECB085AE637DD3[_id_AC0E594AC96AA3A8]);
    _id_B9BF54C11065FDF7.angles = spawnangles + _id_C2120FCD901646C8;
    _id_B9BF54C11065FDF7 notsolid();
    _id_B9BF54C11065FDF7 dontinterpolate();
    _id_B9BF54C11065FDF7 scriptmodelplayanimdeltamotion(_id_7B967D0282DB45C6[_id_AC0E594AC96AA3A8]);

    if(!isDefined(level.broshotepictauntprops))
      level.broshotepictauntprops = [];

    level.broshotepictauntprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8] = _id_B9BF54C11065FDF7;

    if(!(isDefined(_id_82A4871F12DEAB59[_id_AC0E594AC96AA3A8]) && isarray(_id_82A4871F12DEAB59[_id_AC0E594AC96AA3A8]))) {
      continue;
    }
    level.broshotepictauntsubprops[_id_1812C7DD1624DC00] = [];

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_82A4871F12DEAB59[_id_AC0E594AC96AA3A8].size; _id_AC0E5C4AC96AAA41++) {
      _id_55AD208308916C5D = spawn("script_model", spawnposition);
      _id_55AD208308916C5D setModel(_id_82A4871F12DEAB59[_id_AC0E594AC96AA3A8][_id_AC0E5C4AC96AAA41]);
      _id_55AD208308916C5D.angles = spawnangles + _id_C2120FCD901646C8;
      _id_55AD208308916C5D notsolid();
      _id_55AD208308916C5D dontinterpolate();
      _id_55AD208308916C5D linkTo(_id_B9BF54C11065FDF7, _id_1AE319F5B9E444BE[_id_AC0E594AC96AA3A8][_id_AC0E5C4AC96AAA41], (0, 0, 0), (0, 0, 0));
      level.broshotepictauntsubprops[_id_1812C7DD1624DC00][_id_AC0E5C4AC96AAA41] = _id_55AD208308916C5D;
    }
  }

  _id_269BD78D1A7FC8B5 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EE7B03B3C11DFDBA.size; _id_AC0E594AC96AA3A8++)
    _id_269BD78D1A7FC8B5 = max(_id_269BD78D1A7FC8B5, _id_EE7B03B3C11DFDBA[_id_AC0E594AC96AA3A8]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < scriptableparts.size; _id_AC0E594AC96AA3A8++)
    thread doepictauntscriptablestep(_id_7C7944E573770A11, _id_1812C7DD1624DC00, scriptableparts[_id_AC0E594AC96AA3A8], scriptablestates[_id_AC0E594AC96AA3A8], _id_8D4030ADF07C9980[_id_AC0E594AC96AA3A8]);

  if(_id_7C7944E573770A11 == 0)
    _id_1ABB9E94A0CB8903 = getplayercharacter(-1);
  else
    _id_1ABB9E94A0CB8903 = getplayercharacter(_id_1812C7DD1624DC00);

  if(_id_7C7944E573770A11 != 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2AEBC2829E85250D.size; _id_AC0E594AC96AA3A8++)
      thread playbeamfx(_id_2AEBC2829E85250D[_id_AC0E594AC96AA3A8], _id_DE7392BC3D3B9AC7[_id_AC0E594AC96AA3A8], _id_5CC9179D6C08DCE7[_id_AC0E594AC96AA3A8], _id_6362B2735BC6A060[_id_AC0E594AC96AA3A8], _id_333441E3306E4001[_id_AC0E594AC96AA3A8], _id_1ABB9E94A0CB8903);
  }

  if(_id_7C7944E573770A11 != 0 && _id_C1814436EBB28EC0 > 0)
    thread doshellshock(_id_C1814436EBB28EC0);

  if(_id_7C7944E573770A11 != 0 && _id_CC2917C28ACE6BFD > 0)
    thread doearthquake(_id_CC2917C28ACE6BFD, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_95D759A18FED520D.size; _id_AC0E594AC96AA3A8++)
    thread doearthquake(_id_95D759A18FED520D[_id_AC0E594AC96AA3A8], 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F06A863F7C8D9384.size; _id_AC0E594AC96AA3A8++)
    thread dodisintegrate(_id_F06A863F7C8D9384[_id_AC0E594AC96AA3A8], _id_AC0E594AC96AA3A8);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E2CD8F5BF67E12CC.size; _id_AC0E594AC96AA3A8++) {
    fwd = anglesToForward(level.camera_bro_shot.basecam.angles);
    _id_07547892AEC22D58 = vectorNormalize((fwd[0], fwd[1], 0));
    _id_DB3321BEAAFAD16B = vectorcross(_id_07547892AEC22D58, (0, 0, 1));
    _id_A3649E1DA3F0A819 = _id_07547892AEC22D58 * _id_E2CD8F5BF67E12CC[_id_AC0E594AC96AA3A8][1];
    _id_14A85A5C7CF1A563 = _id_DB3321BEAAFAD16B * _id_E2CD8F5BF67E12CC[_id_AC0E594AC96AA3A8][0];
    _id_79AD84B5F137AFA8 = _id_A3649E1DA3F0A819 + _id_14A85A5C7CF1A563;

    if(_id_7C7944E573770A11 != 0)
      _id_EB381492A5DB110A = level.camera_bro_shot.char_loc[0].origin;
    else
      _id_EB381492A5DB110A = spawnposition;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_35728324A5C3B9FE.size; _id_AC0E5C4AC96AAA41++)
      thread dospawnvfx(_id_35728324A5C3B9FE[_id_AC0E5C4AC96AAA41], _id_37C1E840C7CC8F00[_id_AC0E5C4AC96AAA41] + _id_F2039C9914FCDDAD * _id_AC0E594AC96AA3A8, _id_79AD84B5F137AFA8, _id_EB381492A5DB110A);
  }

  thread cleanupepictauntprops(_id_1812C7DD1624DC00, _id_269BD78D1A7FC8B5, _id_E29F06F057B7E344);
}

dospawnvfx(fxname, _id_235DC2C513DBEFCC, fxoffset, _id_EB381492A5DB110A) {
  self endon("cancel_taunt_cleanup");
  wait(_id_235DC2C513DBEFCC);
  pos = _id_EB381492A5DB110A + fxoffset;
  fxtoplay = spawnfx(level._effect[fxname], pos);

  if(isDefined(fxtoplay)) {
    triggerfx(fxtoplay);
    fxtoplay thread delayfxdelete(12.0);
  }
}

delayfxdelete(time) {
  self endon("cancel_taunt_cleanup");
  wait(time);

  if(isDefined(self))
    self delete();
}

dodisintegrate(_id_235DC2C513DBEFCC, index) {
  self endon("cancel_taunt_cleanup");
  wait(_id_235DC2C513DBEFCC);

  if(isDefined(level.topplayers[index + 3]))
    level.topplayers[index + 3].bro hide(1);
}

playbeamfx(_id_235DC2C513DBEFCC, _id_6029710E4CAB57FF, fxname, _id_475232A059E96927, _id_98F120771ED00D22, _id_1ABB9E94A0CB8903) {
  self endon("cancel_taunt_cleanup");
  wait(_id_235DC2C513DBEFCC);
  _id_3C26A3416D083F56 = playfxontagsbetweenclients(level._effect[fxname], _id_1ABB9E94A0CB8903, _id_475232A059E96927, _id_1ABB9E94A0CB8903, _id_98F120771ED00D22);
  thread cleanupbeamfx(_id_3C26A3416D083F56, _id_6029710E4CAB57FF);
}

cleanupbeamfx(_id_3C26A3416D083F56, _id_6029710E4CAB57FF) {
  waittill_notify_or_timeout("cancel_taunt_cleanup", _id_6029710E4CAB57FF);
  _id_3C26A3416D083F56 delete();
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

doearthquake(_id_235DC2C513DBEFCC, _id_B5C99103C0C2BFC5) {
  self endon("cancel_taunt_cleanup");

  if(!isDefined(level.players)) {
    return;
  }
  wait(_id_235DC2C513DBEFCC);

  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }
    if(_id_B5C99103C0C2BFC5) {
      player earthquakeforplayer(0.5, 0.65, player.origin, 1000);
      continue;
    }

    player earthquakeforplayer(0.15, 0.25, player.origin, 1000);
  }
}

doshellshock(_id_235DC2C513DBEFCC) {
  self endon("cancel_taunt_cleanup");
  wait(_id_235DC2C513DBEFCC);

  foreach(player in level.players) {
    if(isbot(player))
      continue;
  }
}

getplayercharacter(_id_018DEC2DAED8E26A) {
  if(_id_018DEC2DAED8E26A == -1)
    _id_1ABB9E94A0CB8903 = level.charactercac;
  else
    _id_1ABB9E94A0CB8903 = level.topplayers[_id_018DEC2DAED8E26A].bro;

  return _id_1ABB9E94A0CB8903;
}

doepictauntscriptablestep(_id_7C7944E573770A11, _id_018DEC2DAED8E26A, part, state, time) {
  if(_id_7C7944E573770A11 == 0)
    _id_018DEC2DAED8E26A = -1;

  self endon("cancel_taunt_cleanup");
  thread listenepictauntscriptablecancel(_id_018DEC2DAED8E26A, part);
  wait(time);
  _id_1ABB9E94A0CB8903 = getplayercharacter(_id_018DEC2DAED8E26A);

  if(!isDefined(_id_1ABB9E94A0CB8903)) {
    return;
  }
  _id_1ABB9E94A0CB8903 setscriptablepartstate(part, state, 0);
}

listenepictauntscriptablecancel(_id_018DEC2DAED8E26A, part) {
  self waittill("cancel_taunt_cleanup");
  _id_1ABB9E94A0CB8903 = getplayercharacter(_id_018DEC2DAED8E26A);
  _id_1ABB9E94A0CB8903 setscriptablepartstate(part, "offImmediate", 0);
}

respawnclientcharacter() {
  _id_0C66757BC3746271 = level.charactercac.angles;
  _id_7617F8AFE5E202E9 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("script_character", _id_7617F8AFE5E202E9, 0, 0, 1, "MPClientCharacter");
  level.charactercac.angles = _id_0C66757BC3746271;
  deleteepictauntprops(0);

  if(isDefined(level.last_taunt_sfx)) {
    self stoplocalsound(level.last_taunt_sfx);

    if(soundexists(level.last_taunt_sfx + "_lsrs"))
      self stoplocalsound(level.last_taunt_sfx + "_lsrs");

    if(soundexists(level.last_taunt_sfx + "_lfe"))
      self stoplocalsound(level.last_taunt_sfx + "_lfe");

    level.last_taunt_sfx = undefined;
  }
}

tauntinprogress(_id_1812C7DD1624DC00) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[_id_1812C7DD1624DC00]) && level.broshotepictauntprops[_id_1812C7DD1624DC00].size > 0;
}

cleanupepictauntprops(_id_1812C7DD1624DC00, time, _id_E29F06F057B7E344) {
  self endon("cancel_taunt_cleanup");
  wait(time);
  level.taunts_done = 1;
  deleteepictauntprops(_id_1812C7DD1624DC00);
}

deleteepictauntprops(_id_1812C7DD1624DC00) {
  if(tauntinprogress(_id_1812C7DD1624DC00)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.broshotepictauntprops[_id_1812C7DD1624DC00].size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.broshotepictauntprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8])) {
        level.broshotepictauntprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8] scriptmodelclearanim();
        level.broshotepictauntprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8] delete();
      }
    }

    level.broshotepictauntprops[_id_1812C7DD1624DC00] = [];

    if(isDefined(level.broshotepictauntsubprops[_id_1812C7DD1624DC00]) && isarray(level.broshotepictauntsubprops[_id_1812C7DD1624DC00])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.broshotepictauntsubprops[_id_1812C7DD1624DC00].size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(level.broshotepictauntsubprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8])) {
          level.broshotepictauntsubprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8] scriptmodelclearanim();
          level.broshotepictauntsubprops[_id_1812C7DD1624DC00][_id_AC0E594AC96AA3A8] delete();
        }
      }

      level.broshotepictauntsubprops[_id_1812C7DD1624DC00] = [];
    }
  }

  self notify("cancel_taunt_cleanup");
}

processtauntsound(_id_AA58C038AB33E912) {
  if(!soundexists(_id_AA58C038AB33E912)) {
    return;
  }
  if(!isDefined(level.taunts_done))
    level.taunts_done = 0;

  if(!isDefined(level.taunts_used))
    level.taunts_used = [];

  if(soundexists(_id_AA58C038AB33E912)) {
    if(isDefined(level.last_taunt_sfx)) {
      self stoplocalsound(level.last_taunt_sfx);

      if(soundexists(level.last_taunt_sfx + "_lsrs"))
        self stoplocalsound(level.last_taunt_sfx + "_lsrs");

      if(soundexists(level.last_taunt_sfx + "_lfe"))
        self stoplocalsound(level.last_taunt_sfx + "_lfe");

      level.last_taunt_sfx = undefined;
    }

    playepicbroshotsound(_id_AA58C038AB33E912);
    level.taunts_used[level.taunts_used.size] = _id_AA58C038AB33E912;
    level.last_taunt_sfx = _id_AA58C038AB33E912;
  } else if(soundexists(_id_AA58C038AB33E912 + "_quiet")) {
    if(!array_contains(level.taunts_used, _id_AA58C038AB33E912)) {
      playepicbroshotsound(_id_AA58C038AB33E912 + "_quiet");
      level.taunts_used[level.taunts_used.size] = _id_AA58C038AB33E912;
      level.last_taunt_sfx = _id_AA58C038AB33E912 + "_quiet";
    }
  }
}

playepicbroshotsound(_id_135E53FC166E7B31) {
  if(isDefined(level.players)) {
    foreach(player in level.players) {
      if(!isbot(player))
        player playlocalsound(_id_135E53FC166E7B31);
    }
  } else
    self playlocalsound(_id_135E53FC166E7B31);
}

array_contains(array, compare) {
  if(array.size <= 0)
    return 0;

  foreach(_id_80EF668C09FFB70F in array) {
    if(_id_80EF668C09FFB70F == compare)
      return 1;
  }

  return 0;
}