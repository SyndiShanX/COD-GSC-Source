/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2a8fc67f80783750.gsc
***********************************************/

main() {
  level thread _id_1817B92DE68A78AA();
}

_id_1817B92DE68A78AA() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("create_script_initialized");
  wait 1;
  scripts\engine\utility::flag_init("laser_arrays_setup");
  wait 10;
  _id_8164F8B29CDABF6A = scripts\engine\utility::getStructArray("laserarray_origin", "script_noteworthy");
  _id_0A64BC439A6FA80D = 0;

  foreach(_id_EABB894A8CAD73C1 in _id_8164F8B29CDABF6A) {
    _id_EABB894A8CAD73C1._id_99DC01209965E399 = [];
    _id_1D5BA7ACBB276A26(_id_EABB894A8CAD73C1, _id_0A64BC439A6FA80D, _id_EABB894A8CAD73C1);
  }

  level._id_5933D8F675E4273D = _id_8164F8B29CDABF6A;

  foreach(_id_97F133AA2CBB461E in level._id_5933D8F675E4273D)
  _id_8AEC75A4411844BA(_id_97F133AA2CBB461E);

  scripts\engine\utility::flag_set("laser_arrays_setup");
}

_id_1D5BA7ACBB276A26(_id_EABB894A8CAD73C1, _id_0A64BC439A6FA80D, parent_struct) {
  _id_0A64BC439A6FA80D++;

  if(_id_0A64BC439A6FA80D == 1) {
    _id_EABB894A8CAD73C1._id_0A64BC439A6FA80D = 0;
    parent_struct._id_99DC01209965E399[parent_struct._id_99DC01209965E399.size] = _id_EABB894A8CAD73C1;
  }

  if(isDefined(_id_EABB894A8CAD73C1.target)) {
    _id_5D1F385401E4CC93 = scripts\engine\utility::getStructArray(_id_EABB894A8CAD73C1.target, "targetname");

    foreach(_id_887F2E6BEA2D6C52 in _id_5D1F385401E4CC93) {
      if(_id_887F2E6BEA2D6C52.script_noteworthy == "laserarray_target") {
        _id_887F2E6BEA2D6C52._id_0A64BC439A6FA80D = _id_0A64BC439A6FA80D;
        parent_struct._id_99DC01209965E399[parent_struct._id_99DC01209965E399.size] = _id_887F2E6BEA2D6C52;
        _id_1D5BA7ACBB276A26(_id_887F2E6BEA2D6C52, _id_0A64BC439A6FA80D, parent_struct);
        continue;
      }

      if(_id_887F2E6BEA2D6C52.script_noteworthy == "laserarray_defuse") {
        parent_struct._id_FF03DED389B65A7D = _id_887F2E6BEA2D6C52;
        level thread _id_271E34074B8FE73A(parent_struct._id_FF03DED389B65A7D, parent_struct);
        continue;
      }

      if(_id_887F2E6BEA2D6C52.script_noteworthy == "laserarray_sweeper_start")
        _id_EABB894A8CAD73C1._id_C80C50C3D81190DC = _id_887F2E6BEA2D6C52;
    }
  }
}

_id_271E34074B8FE73A(_id_FF03DED389B65A7D, parent_struct) {
  level endon("game_ended");

  if(!isDefined(_id_FF03DED389B65A7D.angles))
    _id_FF03DED389B65A7D.angles = (0, 0, 0);

  if(!isDefined(_id_FF03DED389B65A7D._id_F2E65E83142A7AF4))
    _id_FF03DED389B65A7D._id_F2E65E83142A7AF4 = [];

  if(!isDefined(scripts\engine\utility::array_find(_id_FF03DED389B65A7D._id_F2E65E83142A7AF4, parent_struct)))
    _id_FF03DED389B65A7D._id_F2E65E83142A7AF4[_id_FF03DED389B65A7D._id_F2E65E83142A7AF4.size] = parent_struct;

  if(isDefined(_id_FF03DED389B65A7D._id_C1ABC60CE5507E66)) {
    return;
  }
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 = spawn("script_model", _id_FF03DED389B65A7D.origin);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66.angles = _id_FF03DED389B65A7D.angles;
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setModel("offhand_2h_wm_c4_v0");
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66.targetname = "lasertraparay_defuse";
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66.parent = _id_FF03DED389B65A7D;

  if(isDefined(_id_FF03DED389B65A7D.target)) {
    _id_FF03DED389B65A7D._id_837178326DAF8AB5 = scripts\engine\utility::getStructArray(_id_FF03DED389B65A7D.target, "targetname");

    foreach(target in _id_FF03DED389B65A7D._id_837178326DAF8AB5) {
      target._id_C1ABC60CE5507E66 = _id_FF03DED389B65A7D._id_C1ABC60CE5507E66;
      target._id_5DCB7CB2E2361551 = _id_FF03DED389B65A7D;
    }
  }

  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 makeusable();
  hintstring = &"COOP_GAME_PLAY/DISABLE_TRAP";
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setHintString(hintstring);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setCursorHint("HINT_BUTTON");
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 sethintdisplayrange(128);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 sethintdisplayfov(80);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setuserange(48);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setusefov(50);
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 sethintonobstruction("show");
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 setuseholdduration("duration_medium");
  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 thread watch_for_damage_on_trap(parent_struct);

  for(;;) {
    _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 waittill("trigger", player);

    if(isPlayer(player)) {
      _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 makeunusable();
      level thread _id_091BDCD29D2BCB28(_id_FF03DED389B65A7D, player);
      player playlocalsound("grenade_pickup");
      thread _id_6AC084564C26345F(_id_FF03DED389B65A7D);
      return;
    }
  }
}

_id_6AC084564C26345F(_id_FF03DED389B65A7D) {
  if(isDefined(_id_FF03DED389B65A7D._id_837178326DAF8AB5)) {
    foreach(_id_E0D9D2880C046704 in _id_FF03DED389B65A7D._id_837178326DAF8AB5)
    _id_E0D9D2880C046704 notify("laser_destroyed");
  }

  foreach(_id_D4D884B520D4C4FE in _id_FF03DED389B65A7D._id_F2E65E83142A7AF4)
  _id_D4D884B520D4C4FE notify("laser_destroyed");

  _id_FF03DED389B65A7D._id_C1ABC60CE5507E66 delete();
}

_id_091BDCD29D2BCB28(_id_FF03DED389B65A7D, player) {
  level endon("game_ended");
  _id_E020078567E41613 = player launchgrenade("c4_mp", _id_FF03DED389B65A7D.origin, (0, 0, 0), 120);
  _id_E020078567E41613.owner = player;
  _id_E020078567E41613 waittill("missile_stuck");
  _id_E020078567E41613 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1, 1);
}

_id_8AEC75A4411844BA(_id_97F133AA2CBB461E) {
  if(!isDefined(_id_97F133AA2CBB461E._id_99DC01209965E399)) {
    return;
  }
  foreach(_id_9E5DFD7E4E61B618 in _id_97F133AA2CBB461E._id_99DC01209965E399)
  _id_BDC3651F32DE01C1(_id_9E5DFD7E4E61B618);

  for(_id_AC0E594AC96AA3A8 = _id_97F133AA2CBB461E._id_99DC01209965E399.size; _id_AC0E594AC96AA3A8 > 1; _id_AC0E594AC96AA3A8--) {
    _id_BB90868BCDD97EE9(_id_97F133AA2CBB461E._id_99DC01209965E399[_id_AC0E594AC96AA3A8 - 1], _id_97F133AA2CBB461E._id_99DC01209965E399[_id_AC0E594AC96AA3A8 - 2]);
    level thread _id_C415744D393290CD(_id_97F133AA2CBB461E._id_99DC01209965E399[_id_AC0E594AC96AA3A8 - 1]._id_C6807CAFB4BF3F2A, _id_97F133AA2CBB461E._id_99DC01209965E399[_id_AC0E594AC96AA3A8 - 2]._id_C6807CAFB4BF3F2A);
  }

  foreach(_id_9E5DFD7E4E61B618 in _id_97F133AA2CBB461E._id_99DC01209965E399) {
    level thread _id_E5CE76B6427F7E10(_id_9E5DFD7E4E61B618);
    level thread _id_0D6D69F7CED75C79(_id_9E5DFD7E4E61B618, _id_97F133AA2CBB461E);
    _id_9E5DFD7E4E61B618._id_97F133AA2CBB461E = _id_97F133AA2CBB461E;
  }
}

_id_BDC3651F32DE01C1(_id_573F54C927E2EB98) {
  _id_573F54C927E2EB98._id_C6807CAFB4BF3F2A = create_tag_origin(_id_573F54C927E2EB98.origin, _id_573F54C927E2EB98);
  _id_573F54C927E2EB98._id_C6807CAFB4BF3F2A._id_573F54C927E2EB98 = _id_573F54C927E2EB98;
}

_id_BB90868BCDD97EE9(first_struct, _id_36817947F1E4A157) {
  first_struct.fx_thermal_end = spawnfx(level._effect["vfx_laser_burn"], first_struct._id_C6807CAFB4BF3F2A.origin);
  triggerfx(first_struct.fx_thermal_end);
  first_struct.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer_nvg"], first_struct._id_C6807CAFB4BF3F2A, "tag_origin", _id_36817947F1E4A157._id_C6807CAFB4BF3F2A, "tag_origin");
}

create_tag_origin(spawn_pos, _id_A56C96B62623C721) {
  tag_origin = spawn("script_model", spawn_pos);
  tag_origin setModel("tag_origin");
  tag_origin thread clean_up_think(tag_origin, _id_A56C96B62623C721);
  return tag_origin;
}

clean_up_think(tag_origin, _id_A56C96B62623C721) {
  tag_origin endon("death");
  _id_A56C96B62623C721 waittill("death");
  tag_origin delete();
}

_id_E5CE76B6427F7E10(_id_573F54C927E2EB98) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("laser_arrays_setup");

  if(!isDefined(_id_573F54C927E2EB98._id_C80C50C3D81190DC)) {
    return;
  }
  _id_573F54C927E2EB98._id_F8690D8E26A297A5 = scripts\engine\utility::getStruct(_id_573F54C927E2EB98._id_C80C50C3D81190DC.target, "targetname");

  if(!isDefined(_id_573F54C927E2EB98._id_C80C50C3D81190DC) || !isDefined(_id_573F54C927E2EB98._id_F8690D8E26A297A5)) {
    return;
  }
  level thread _id_BFD6D3C3CB5CF316(_id_573F54C927E2EB98);
}

_id_BFD6D3C3CB5CF316(_id_EABB894A8CAD73C1) {
  level endon("game_ended");
  _id_EABB894A8CAD73C1 endon("laser_destroyed");

  if(isDefined(_id_EABB894A8CAD73C1.script_delay))
    wait(_id_EABB894A8CAD73C1.script_delay);

  if(!isDefined(_id_EABB894A8CAD73C1._id_C6807CAFB4BF3F2A) || !isent(_id_EABB894A8CAD73C1._id_C6807CAFB4BF3F2A)) {
    return;
  }
  _id_42F65B4B53C1F5D4 = 5;

  for(;;) {
    if(isDefined(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.script_duration))
      _id_42F65B4B53C1F5D4 = float(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.script_duration);

    _id_EABB894A8CAD73C1._id_C6807CAFB4BF3F2A moveTo(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.origin, _id_42F65B4B53C1F5D4);

    if(isDefined(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.delay) && float(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.delay) > 0)
      wait(_id_42F65B4B53C1F5D4 + float(_id_EABB894A8CAD73C1._id_C80C50C3D81190DC.delay));
    else
      wait(_id_42F65B4B53C1F5D4);

    if(isDefined(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.script_duration))
      _id_42F65B4B53C1F5D4 = float(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.script_duration);

    _id_EABB894A8CAD73C1._id_C6807CAFB4BF3F2A moveTo(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.origin, _id_42F65B4B53C1F5D4);

    if(isDefined(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.delay) && float(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.delay) > 0) {
      wait(_id_42F65B4B53C1F5D4 + float(_id_EABB894A8CAD73C1._id_F8690D8E26A297A5.delay));
      continue;
    }

    wait(_id_42F65B4B53C1F5D4);
  }
}

_id_9615AE5E4C123462(ent) {
  level endon("game_ended");
  ent endon("death");
  color = randomint(1);

  if(!isent(ent)) {
    return;
  }
  for(;;)
    wait 0.1;
}

_id_95ED9225CC943C09(_id_0A64BC439A6FA80D) {
  label = "x";

  switch (_id_0A64BC439A6FA80D) {
    case 1:
    case 0:
      label = "A";
      break;
    case 2:
      label = "B";
      break;
    case 3:
      label = "C";
      break;
    case 4:
      label = "D";
      break;
    case 5:
      label = "E";
      break;
    case 6:
      label = "F";
      break;
    case 7:
      label = "G";
      break;
    case 8:
      label = "H";
      break;
    case 9:
      label = "I";
      break;
    case 10:
      label = "J";
      break;
    case 11:
      label = "K";
      break;
    case 12:
      label = "L";
      break;
  }

  return label;
}

_id_C415744D393290CD(_id_9142677C3852E199, _id_F74CA99B757A2E28) {
  level endon("game_ended");
  _id_9142677C3852E199._id_573F54C927E2EB98 endon("laser_destroyed");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 2;
  _id_4F0FC1C36324AFFB = squared(2048);
  _id_DB9C2822E3D940DC = lengthsquared(_id_9142677C3852E199.origin - _id_F74CA99B757A2E28.origin);

  for(;;) {
    if(!scripts\cp\utility::any_player_nearby(_id_9142677C3852E199.origin, _id_4F0FC1C36324AFFB)) {
      wait 0.5;
      continue;
    }

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distancesquared(player.origin, _id_9142677C3852E199.origin) > _id_DB9C2822E3D940DC + _id_DB9C2822E3D940DC * 0.25) {
        continue;
      }
      if(distancesquared(player.origin, _id_F74CA99B757A2E28.origin) > _id_DB9C2822E3D940DC + _id_DB9C2822E3D940DC * 0.25) {
        continue;
      }
      _id_6D3AB3A23DD14DD7 = ["j_helmet", "j_head", "j_neck", "j_spineupper", "j_spinelower", "j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_wrist_ri", "j_wrist_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le", "j_ankle_ri", "j_ankle_le", "tag_eye", "tag_origin"];

      foreach(tag in _id_6D3AB3A23DD14DD7) {
        if(player tagexists(tag)) {
          _id_81127E016B847FDD = vectorfromlinetopoint(_id_9142677C3852E199.origin, _id_F74CA99B757A2E28.origin, player gettagorigin(tag));
          _id_D54E52983BC21ADD = length(_id_81127E016B847FDD);

          if(_id_D54E52983BC21ADD < 5) {
            level thread _id_C8F95E09465A43F6(player, _id_9142677C3852E199, _id_F74CA99B757A2E28);
            return;
          }
        }
      }
    }

    waitframe();
  }
}

_id_C8F95E09465A43F6(player, _id_9142677C3852E199, _id_F74CA99B757A2E28) {
  playFX(level._effect["vfx_laser_destroy"], _id_9142677C3852E199.origin);
  playFX(level._effect["vfx_laser_destroy"], _id_F74CA99B757A2E28.origin);
  _id_9142677C3852E199._id_573F54C927E2EB98._id_C6807CAFB4BF3F2A playSound("recon_drone_explode");
  level thread _id_C5D4CACF993E20E3(_id_9142677C3852E199._id_573F54C927E2EB98, player);

  if(isDefined(_id_9142677C3852E199._id_573F54C927E2EB98._id_97F133AA2CBB461E)) {
    if(isDefined(_id_9142677C3852E199._id_573F54C927E2EB98._id_97F133AA2CBB461E._id_C1ABC60CE5507E66)) {
      if(isDefined(_id_9142677C3852E199._id_573F54C927E2EB98._id_97F133AA2CBB461E._id_C1ABC60CE5507E66.parent))
        _id_6AC084564C26345F(_id_9142677C3852E199._id_573F54C927E2EB98._id_97F133AA2CBB461E._id_C1ABC60CE5507E66.parent);
    }
  }

  _id_9142677C3852E199._id_573F54C927E2EB98 notify("laser_destroyed");
}

_id_C5D4CACF993E20E3(_id_573F54C927E2EB98, victim, _id_AC0FFCD3A4D3ED84) {
  if(isDefined(_id_573F54C927E2EB98._id_97F133AA2CBB461E._id_99DC01209965E399) && !istrue(_id_AC0FFCD3A4D3ED84)) {
    foreach(_id_5B26E932474E06F7 in _id_573F54C927E2EB98._id_97F133AA2CBB461E._id_99DC01209965E399) {
      if(_id_5B26E932474E06F7 != _id_573F54C927E2EB98)
        level thread _id_C5D4CACF993E20E3(_id_5B26E932474E06F7, victim, 1);
    }
  }

  if(!isDefined(_id_573F54C927E2EB98._id_FF03DED389B65A7D)) {
    return;
  }
  if(isDefined(victim) && isPlayer(victim)) {
    victim._id_230A3287F9AD2965 = 1;
    victim.shouldskipdeathsshield = 1;
  }

  radiusdamage(_id_573F54C927E2EB98._id_FF03DED389B65A7D.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", _id_573F54C927E2EB98._id_FF03DED389B65A7D.origin);
  earthquake(0.45, 0.7, _id_573F54C927E2EB98._id_FF03DED389B65A7D.origin, 800);

  if(isDefined(level._id_2418F6A5C3E407A5))
    thread[[level._id_2418F6A5C3E407A5]](_id_573F54C927E2EB98._id_FF03DED389B65A7D.origin);

  if(isDefined(victim) && isPlayer(victim))
    victim _id_3E2F7FDFD94F71BA(victim);
}

_id_0D6D69F7CED75C79(_id_573F54C927E2EB98, _id_97F133AA2CBB461E) {
  level endon("game_ended");
  _id_573F54C927E2EB98 waittill("laser_destroyed");

  foreach(_id_5B26E932474E06F7 in _id_97F133AA2CBB461E._id_99DC01209965E399) {
    if(_id_5B26E932474E06F7 != _id_573F54C927E2EB98)
      _id_5B26E932474E06F7 notify("laser_destroyed");
  }

  if(isDefined(_id_573F54C927E2EB98._id_FF03DED389B65A7D) && isDefined(_id_573F54C927E2EB98._id_FF03DED389B65A7D._id_C1ABC60CE5507E66))
    _id_573F54C927E2EB98._id_FF03DED389B65A7D._id_C1ABC60CE5507E66 delete();

  if(isDefined(_id_573F54C927E2EB98.laser_end_ent_thermal))
    _id_573F54C927E2EB98.laser_end_ent_thermal delete();

  if(isDefined(_id_573F54C927E2EB98.fx_thermal))
    _id_573F54C927E2EB98.fx_thermal delete();

  if(isDefined(_id_573F54C927E2EB98.fx_thermal_end))
    _id_573F54C927E2EB98.fx_thermal_end delete();

  if(isDefined(_id_573F54C927E2EB98._id_C6807CAFB4BF3F2A))
    _id_573F54C927E2EB98._id_C6807CAFB4BF3F2A delete();

  if(isDefined(_id_573F54C927E2EB98))
    _id_573F54C927E2EB98 = undefined;
}

watch_for_damage_on_trap(parent_struct) {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self._id_ABBAA2FC2B3DA347 = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(!isexplosivedamagemod(meansofdeath)) {
      continue;
    }
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, damage, 1);
    self._id_ABBAA2FC2B3DA347++;
    self.health = 9999;
    self.maxhealth = 9999;

    if(isPlayer(attacker)) {
      _id_9142677C3852E199 = parent_struct._id_99DC01209965E399[0]._id_C6807CAFB4BF3F2A;
      _id_F74CA99B757A2E28 = parent_struct._id_99DC01209965E399[1]._id_C6807CAFB4BF3F2A;
      _id_4F0FC1C36324AFFB = squared(2048);
      _id_DB9C2822E3D940DC = lengthsquared(_id_9142677C3852E199.origin - _id_F74CA99B757A2E28.origin);
      player = attacker;

      if(distancesquared(attacker.origin, _id_9142677C3852E199.origin) > _id_DB9C2822E3D940DC + _id_DB9C2822E3D940DC * 0.25)
        player = undefined;

      level thread _id_C8F95E09465A43F6(player, _id_9142677C3852E199, _id_F74CA99B757A2E28);
    }
  }
}

_id_3E2F7FDFD94F71BA(player) {
  dir = -1 * anglesToForward(player.angles);
  _id_D01387BDA9E91E50 = player getvelocity();
  _id_ADC4B2BF275805C7 = length2d(_id_D01387BDA9E91E50);

  if(_id_ADC4B2BF275805C7 == 0)
    _id_ADC4B2BF275805C7 = 60;

  if(_id_ADC4B2BF275805C7 < 60)
    _id_ADC4B2BF275805C7 = 60;

  _id_E73621F0A50827AC = player getvelocity();
  _id_E73621F0A50827AC = (_id_E73621F0A50827AC[0], _id_E73621F0A50827AC[1], 0);
  _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);

  if(_id_2FDCE9F0DA5412E0 > 0) {
    _id_3173030081735E94 = dir * _id_ADC4B2BF275805C7;
    _id_80E3E9C318E99CF1 = _id_E73621F0A50827AC + _id_3173030081735E94;
    _id_2297D1C3903888ED = length2d(_id_80E3E9C318E99CF1);

    if(vectordot(_id_80E3E9C318E99CF1, _id_3173030081735E94) < 0) {
      right = vectorcross((0, 0, 1), dir);

      if(vectordot(right, _id_E73621F0A50827AC) > 0) {
        _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);
        _id_E73621F0A50827AC = right * _id_2FDCE9F0DA5412E0;
      } else {
        left = right * -1;
        _id_2FDCE9F0DA5412E0 = length2d(_id_E73621F0A50827AC);
        _id_E73621F0A50827AC = left * _id_2FDCE9F0DA5412E0;
      }

      _id_80E3E9C318E99CF1 = _id_E73621F0A50827AC + _id_3173030081735E94;
      _id_ADC4B2BF275805C7 = length2d(_id_80E3E9C318E99CF1);
    } else {
      if(_id_2FDCE9F0DA5412E0 > _id_ADC4B2BF275805C7)
        _id_ADC4B2BF275805C7 = _id_2FDCE9F0DA5412E0;

      dir = vectorNormalize(_id_80E3E9C318E99CF1);
    }
  }

  player knockback(dir, _id_ADC4B2BF275805C7);
}