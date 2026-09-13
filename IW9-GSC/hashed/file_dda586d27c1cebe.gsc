/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_dda586d27c1cebe.gsc
***********************************************/

init() {
  level endon("game_ended");
  level._id_71DC5E48C1267A14 = spawnStruct();
  _id_1376E9B22932CA20 = "dvar_1829A1208C528E73";
  level._id_71DC5E48C1267A14._id_588B734C8F3298F5 = getdvarint(_func_2EF675C13CA1C4AF(_id_1376E9B22932CA20, "spreadingDamage"), 1);
  level._id_71DC5E48C1267A14._id_DC1E1CAB01BBD55C = getdvarfloat(_func_2EF675C13CA1C4AF(_id_1376E9B22932CA20, "spreadingTickTime"), 1);
  level._id_71DC5E48C1267A14._id_8E8F488D08E4219C = getdvarfloat("dvar_335A6DD531E17186", 10);
  level._id_71DC5E48C1267A14._id_949268B797CBBB5D = getdvarfloat("dvar_80F6647C80A6FE1C", 20);
  _id_AC2FDAD03EB19A59();
  level._id_71DC5E48C1267A14.inited = 1;
}

_id_AC2FDAD03EB19A59() {
  level._id_71DC5E48C1267A14._id_195F903A1EB73FBB = 0;
  level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97 = [];
  _id_5836C6D53A5F99A2 = scripts\engine\utility::getStructArray("dmz_bio_lab_radiation_spawn", "script_noteworthy");

  foreach(node in _id_5836C6D53A5F99A2) {
    _id_67F14F8315CB0F2F = strtok(node.script_parameters, "|");
    _id_ABB4F47E8E5EA3C2 = int(_id_67F14F8315CB0F2F[0]);

    if(!isDefined(level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[_id_ABB4F47E8E5EA3C2]))
      level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[_id_ABB4F47E8E5EA3C2] = [];

    _id_61DCE5B9524FDE5E = level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[_id_ABB4F47E8E5EA3C2].size;
    _id_65B75B602C5EAC43 = strtok(_id_67F14F8315CB0F2F[1], "_");
    _id_40EA85AA56FCCDC4 = strtok(_id_67F14F8315CB0F2F[2], "_");
    struct = spawnStruct();
    struct._id_EDED8B6C3565A24C = int(_id_65B75B602C5EAC43[0]);
    struct.goalheight = int(_id_65B75B602C5EAC43[1]);
    struct.height = struct._id_EDED8B6C3565A24C;
    struct._id_ACC4F45C61ED5FF1 = int(_id_40EA85AA56FCCDC4[0]);
    struct.goalradius = int(_id_40EA85AA56FCCDC4[1]);
    struct.radius = struct._id_ACC4F45C61ED5FF1;
    struct._id_2FB858D06D406750 = int(_id_67F14F8315CB0F2F[3]);
    struct._id_9421D616EE332897 = 0;
    struct.startpoint = node.origin;
    struct._id_04400D6A8D876BD9 = int(_id_67F14F8315CB0F2F[4]);
    struct._id_419CC4153A9718B6 = _id_B8859DEF6560DF31(node, _id_67F14F8315CB0F2F[5]);
    level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[_id_ABB4F47E8E5EA3C2][_id_61DCE5B9524FDE5E] = struct;
  }
}

_id_B8859DEF6560DF31(node, scriptablestate) {
  if(!isDefined(node.angles))
    node.angles = (0, 0, 0);

  struct = spawnStruct();
  struct.state = scriptablestate;
  vfxent = spawn("script_model", node.origin);
  vfxent setModel("iw9_biolabs_radiation_vfx");
  vfxent.angles = node.angles;
  struct.vfxent = vfxent;
  return struct;
}

_id_A01F654E559EE5EC() {
  level endon("game_ended");

  if(!_id_DFA94748AF73C087()) {
    return;
  }
  wait 5;
  level _id_88E7CBCFEDB66392();
  level thread _id_A75A30F41AF1D381();
  level thread _id_5159A10761160159();
  level thread _id_006CC117E6090479();
  level _id_2D9C29F869A29FCA::_id_174FFC9E64F5CE0D();
  level._id_71DC5E48C1267A14._id_DBCD5CA316610306 = 1;
  level notify("dmz_bio_lab_radiation_started");
  _id_AD93F32DA114D467();
  level._id_71DC5E48C1267A14._id_DBCD5CA316610306 = 0;

  if(getdvarint("dvar_F22261D228E680B2", 1) == 1)
    level._id_71DC5E48C1267A14.starttime = gettime();

  level notify("dmz_bio_lab_radiation_complete");
}

_id_3528D4AECC341AAE() {
  level notify("dmz_bio_lab_radiation_clear");

  foreach(_id_C229310C9F8ADB7E in level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97) {
    foreach(_id_061663BFE5C01BA6 in _id_C229310C9F8ADB7E)
    _id_166CA7877DDBA755(_id_061663BFE5C01BA6);
  }

  level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97 = [];
  level._id_71DC5E48C1267A14._id_195F903A1EB73FBB = -1;
}

_id_28F7A303238284EE() {
  return isDefined(level._id_71DC5E48C1267A14) && istrue(level._id_71DC5E48C1267A14._id_DBCD5CA316610306);
}

_id_88E7CBCFEDB66392() {
  setmusicstate("mx_mp_br_ringclose_final_loop");
  setomnvar("ui_dmz_radiation_spreading", 1);

  foreach(player in level.players) {
    if(isalive(player))
      player playlocalsound("br_circle_closing");
  }
}

_id_AD93F32DA114D467() {
  level endon("game_ended");
  level endon("dmz_bio_lab_radiation_clear");

  while(_id_3C0AD5FCE1B17F47())
    waitframe();
}

_id_A75A30F41AF1D381() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      _id_FC60036BA7BF253A = undefined;

      if(isDefined(player.origin))
        _id_FC60036BA7BF253A = player scripts\mp\utility\player::getstancecenter();

      player _id_2872BC0992A4AA57(_id_FC60036BA7BF253A);
      _id_012ADDFE2FE32C7D(player);
    }

    foreach(agent in level.agentarray) {
      if(!isDefined(agent) || !isalive(agent)) {
        continue;
      }
      _id_FC60036BA7BF253A = agent scripts\mp\agents\agent_utility::_id_B071E509C0FB69B0();
      agent _id_2872BC0992A4AA57(_id_FC60036BA7BF253A);
    }

    waitframe();
  }
}

_id_006CC117E6090479() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(isalive(player) && scripts\cp_mp\gasmask::hasgasmask(player) && !istrue(player.gasmaskswapinprogress)) {
        if(player _id_26879895DB23C779()) {
          player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("radiation");
          continue;
        }

        player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("radiation");
      }
    }

    wait 1;
  }
}

_id_2872BC0992A4AA57(_id_1CFCCAC3E5778BBB) {
  self._id_A74C7438D9F9D5F1 = 0;

  if(!isDefined(_id_1CFCCAC3E5778BBB)) {
    return;
  }
  for(_id_A66D8DB791893E1D = 0; _id_A66D8DB791893E1D <= level._id_71DC5E48C1267A14._id_195F903A1EB73FBB; _id_A66D8DB791893E1D++) {
    foreach(_id_061663BFE5C01BA6 in level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[_id_A66D8DB791893E1D]) {
      _id_929A937DDE246EEA = _id_061663BFE5C01BA6.startpoint[2];
      _id_92BD9D7DDE4ACCA0 = _id_061663BFE5C01BA6.startpoint[2] + _id_061663BFE5C01BA6.height;

      if(_id_1CFCCAC3E5778BBB[2] >= _id_929A937DDE246EEA && _id_1CFCCAC3E5778BBB[2] <= _id_92BD9D7DDE4ACCA0) {
        _id_34B395F4B5CA0C66 = distance2d(_id_1CFCCAC3E5778BBB, _id_061663BFE5C01BA6.startpoint);

        if(_id_34B395F4B5CA0C66 < _id_061663BFE5C01BA6.radius) {
          self._id_A74C7438D9F9D5F1 = 1;
          return;
        }
      }
    }
  }
}

_id_C2063B3BAB34E2A8(_id_061663BFE5C01BA6) {
  _id_061663BFE5C01BA6._id_419CC4153A9718B6.vfxent setscriptablepartstate("gas", _id_061663BFE5C01BA6._id_419CC4153A9718B6.state, 1);
}

_id_166CA7877DDBA755(_id_061663BFE5C01BA6) {
  _id_061663BFE5C01BA6._id_419CC4153A9718B6.vfxent setscriptablepartstate("gas", "idle", 1);
  _id_061663BFE5C01BA6._id_419CC4153A9718B6.vfxent delete();
}

_id_5159A10761160159() {
  level endon("game_ended");
  _id_AF7D51C8ED0B82FD = level._id_71DC5E48C1267A14._id_588B734C8F3298F5;
  _id_634EC439D65CE447 = level._id_71DC5E48C1267A14._id_8E8F488D08E4219C;

  for(;;) {
    damagemultiplier = 1;

    if(isDefined(level._id_71DC5E48C1267A14) && isDefined(level._id_71DC5E48C1267A14.starttime)) {
      _id_6B7BEE46F2C6DA28 = (gettime() - level._id_71DC5E48C1267A14.starttime) / 1000;
      damagemultiplier = 1 + _id_6B7BEE46F2C6DA28 / level._id_71DC5E48C1267A14._id_949268B797CBBB5D;

      if(damagemultiplier > 30)
        level notify("dmz_radiation_complete");
    }

    foreach(player in level.players) {
      if(isalive(player) && !istrue(player.plotarmor) && player _id_26879895DB23C779())
        _id_C4A3072CE7B3F1FD(player, _id_AF7D51C8ED0B82FD * int(damagemultiplier));
    }

    foreach(agent in level.agentarray) {
      if(isalive(agent) && agent _id_26879895DB23C779())
        _id_6153AD0458D8F809(agent, _id_634EC439D65CE447);
    }

    wait(level._id_71DC5E48C1267A14._id_DC1E1CAB01BBD55C);
  }
}

_id_C4A3072CE7B3F1FD(player, damage) {
  if(scripts\cp_mp\gasmask::hasgasmask(player))
    player scripts\cp_mp\gasmask::processdamage(damage);
  else {
    if(player scripts\mp\utility\killstreak::isjuggernaut())
      damage = _id_29C32B7117E01180::modifybrgasdamage(damage);

    player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "armor");
    player _id_07C40FA80892A721::damagearmor(damage);

    if(randomint(100) >= 40)
      player thread _id_2695A20D4011076D::tryplaycoughaudio();
  }
}

_id_6153AD0458D8F809(agent, damage) {
  if(istrue(agent._id_65771500F49956C1)) {
    return;
  }
  _id_C7A4725D05BB7F22 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");

  if(isDefined(_id_C7A4725D05BB7F22) && _id_C7A4725D05BB7F22 == 3) {
    if(isDefined(agent.helmethealth) && agent.helmethealth > 0)
      return;
  }

  if(issubstr(agent.agent_type, "boss")) {
    return;
  }
  agent dodamage(damage, agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
}

_id_3C0AD5FCE1B17F47() {
  _id_95FBA6F49D059D62 = 1;

  foreach(_id_061663BFE5C01BA6 in level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97[level._id_71DC5E48C1267A14._id_195F903A1EB73FBB]) {
    if(_id_061663BFE5C01BA6._id_9421D616EE332897 > _id_061663BFE5C01BA6._id_2FB858D06D406750) {
      continue;
    }
    _id_95FBA6F49D059D62 = 0;

    if(_id_061663BFE5C01BA6._id_04400D6A8D876BD9 > 0) {
      _id_061663BFE5C01BA6._id_04400D6A8D876BD9 = _id_061663BFE5C01BA6._id_04400D6A8D876BD9 - level.framedurationseconds;
      continue;
    }

    if(_id_061663BFE5C01BA6._id_9421D616EE332897 == 0)
      _id_C2063B3BAB34E2A8(_id_061663BFE5C01BA6);

    _id_CD9EB3EBDB1CFFA0 = _id_061663BFE5C01BA6._id_9421D616EE332897 / _id_061663BFE5C01BA6._id_2FB858D06D406750;
    _id_061663BFE5C01BA6._id_9421D616EE332897 = _id_061663BFE5C01BA6._id_9421D616EE332897 + level.framedurationseconds;
    _id_061663BFE5C01BA6.radius = scripts\engine\math::lerp(_id_061663BFE5C01BA6._id_ACC4F45C61ED5FF1, _id_061663BFE5C01BA6.goalradius, _id_CD9EB3EBDB1CFFA0);
    _id_061663BFE5C01BA6.height = scripts\engine\math::lerp(_id_061663BFE5C01BA6._id_EDED8B6C3565A24C, _id_061663BFE5C01BA6.goalheight, _id_CD9EB3EBDB1CFFA0);
  }

  if(_id_95FBA6F49D059D62) {
    if(level._id_71DC5E48C1267A14._id_195F903A1EB73FBB + 1 == level._id_71DC5E48C1267A14._id_8B71EBC2DE5FBD97.size)
      return 0;

    level._id_71DC5E48C1267A14._id_195F903A1EB73FBB++;
    level notify("dmz_bio_lab_radiation_expansion_set_index_updated");
  }

  return 1;
}

_id_012ADDFE2FE32C7D(player) {
  if(player getscriptablehaspart("geiger")) {
    if(istrue(player.extracted) || !scripts\mp\utility\player::isreallyalive(player)) {
      if(isDefined(player._id_2B1421F4DF7179FB)) {
        player setscriptablepartstate("geiger", "off", 1);
        player._id_2B1421F4DF7179FB = undefined;
      }
    } else if(!isDefined(player._id_2B1421F4DF7179FB) || player _id_26879895DB23C779() != istrue(player._id_2B1421F4DF7179FB)) {
      if(player _id_26879895DB23C779())
        player setscriptablepartstate("geiger", "20cps", 1);
      else
        player setscriptablepartstate("geiger", "5cps", 1);

      player._id_2B1421F4DF7179FB = player _id_26879895DB23C779();
    }
  }
}

_id_26879895DB23C779() {
  return istrue(self._id_A74C7438D9F9D5F1);
}

_id_DFA94748AF73C087() {
  return isDefined(level._id_71DC5E48C1267A14) && istrue(level._id_71DC5E48C1267A14.inited);
}