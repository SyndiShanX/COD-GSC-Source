/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ending.gsc
***********************************************/

br_ending_init() {
  if(!mode_can_play_ending(getDvar("dvar_7611A2790A0BF7FE"))) {
    return;
  }
  setdvarifuninitialized("dvar_70411185C4A8BF09", 1);
  _id_A6B3FAE0395F75C3 = _id_9AFBEE75CFE14B8D();

  switch (_id_A6B3FAE0395F75C3) {
    case "mgl_ftue_tutorial":
      _id_062C595D55B88B26::_id_D32F459AB9F5E7AF();
      _id_58321BE04DCA3E61::_id_E04BD99E1BB6430B();
      break;
    case "chopper2":
      _id_062C595D55B88B26::_id_D32F459AB9F5E7AF();
      _id_1FC2350D8AEBB68E::_id_E04BD99E1BB6430B();
      break;
    case "chopper":
    default:
      _id_0F4678C9C2A5B24E::_id_E04BD99E1BB6430B();
      break;
  }

  thread _id_87F45430D8DE267A();
}

can_play_ending() {
  if(!getdvarint("dvar_70411185C4A8BF09"))
    return 0;

  if(!mode_can_play_ending(getDvar("dvar_7611A2790A0BF7FE")))
    return 0;

  if(istrue(level.br_skipending))
    return 0;

  return 1;
}

mode_can_play_ending(mode) {
  _id_9ED3490DC8C5E5A4 = 0;

  switch (mode) {
    case "gunroyale":
    case "vanilla":
    case "truckwar":
    case "zxp":
    case "aladdin":
    case "resurgence_mgl":
    case "zonecontrol":
    case "resurgence":
    case "mini_mgl":
    case "mini":
    case "jugg":
    case "champion":
    case "":
      _id_9ED3490DC8C5E5A4 = 1;
      break;
  }

  return _id_9ED3490DC8C5E5A4;
}

play_ending(winners, _id_CBFC3BA10CEFC8CE) {
  if(!can_play_ending()) {
    return;
  }
  level endon("endingSceneStop");
  winners = scripts\engine\utility::array_removeundefined(winners);
  winners = scripts\engine\utility::array_sort_with_func(winners, ::compare_higher_score);
  _id_E50B941AFD09E62E(winners);
  level notify("br_ending_start", winners);
  level.brdisablefinalkillcam = 1;
  _id_A6B3FAE0395F75C3 = _id_9AFBEE75CFE14B8D();
  animstruct = create_exfil_animstruct(winners, _id_CBFC3BA10CEFC8CE);
  animstruct set_ending_pack(_id_A6B3FAE0395F75C3, _id_CBFC3BA10CEFC8CE);
  winners = scripts\engine\utility::array_removeundefined(winners);
  winners = scripts\engine\utility::array_sort_with_func(winners, ::compare_higher_score);
  _id_E50B941AFD09E62E(winners);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    foreach(player in winners) {
      if(isDefined(player) && !_func_96D228FA8E72A818(player))
        player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    }
  }

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("exfilStart"))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("exfilStart", winners);

  winners = undefined;
  level.br_ending = animstruct;
  ending_viewing_players_setup(animstruct);
  player_rigs = ending_winning_players_setup(animstruct);
  clear_vehicles(animstruct.origin, 1000);
  _id_1ABB2E32FB5915C4();
  setomnvar("scriptable_loot_hide", 1);
  animstruct scripts\common\anim::anim_first_frame_solo(animstruct.cam, animstruct.packs[0].anime);

  foreach(player in level.players)
  player cameralinkTo(animstruct.cam, "tag_player", 1, 1);

  foreach(pack in animstruct.packs) {
    if(istrue(pack._id_52738E0A99ED242B)) {
      _id_575DDFF126402966 = 0;

      foreach(player in pack.players) {
        if(isDefined(player) && isPlayer(player) && isDefined(level.scr_anim[player.animname][pack.anime])) {
          _id_575DDFF126402966 = 1;
          break;
        }
      }

      if(!_id_575DDFF126402966)
        continue;
    }

    if(isDefined(pack.startfunc))
      animstruct[[pack.startfunc]](pack.paramarray);

    if(isDefined(pack.fov))
      _id_40F4C8F2B94C5CD9::allplayers_setfov(pack.fov);
    else
      _id_40F4C8F2B94C5CD9::_id_CF47AB3F9DEFE35B();

    if(isDefined(pack.fstop) && isDefined(pack._id_ED8206FEF1806FEF))
      _id_40F4C8F2B94C5CD9::allplayers_setphysicaldof(pack.fstop, pack._id_ED8206FEF1806FEF, pack.focusspeed, pack.aperturespeed, pack._id_C06551440B16249C);

    if(isDefined(pack._id_EEDB5FB15EB26BFA)) {
      foreach(player in level.players)[[pack._id_EEDB5FB15EB26BFA]](player, pack._id_5AB13B55D7CEFF80);
    }

    if(isDefined(pack.fx))
      playFX(scripts\engine\utility::getfx(pack.fx), pack.fxorigin, anglesToForward(pack.fxangles), anglestoup(pack.fxangles));

    if(pack.players.size > 0) {
      pack.players = scripts\engine\utility::array_removeundefined(pack.players);

      foreach(player in pack.players) {
        player dontinterpolate();

        if(isDefined(player.linkedtoent)) {
          if(!isPlayer(player)) {
            if(getdvarint("dvar_BC95D8892007EBFD", 1) && isDefined(player.player_rig._id_7D489A3282F9CCE0)) {
              _id_7D489A3282F9CCE0 = player.player_rig._id_7D489A3282F9CCE0;
              _id_7D489A3282F9CCE0 scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[_id_7D489A3282F9CCE0.animname][pack.anime], animstruct.origin, animstruct.angles, _id_7D489A3282F9CCE0.animname);
              _id_7D489A3282F9CCE0 thread scripts\common\notetrack::start_notetrack_wait(_id_7D489A3282F9CCE0, _id_7D489A3282F9CCE0.animname, pack.anime, _id_7D489A3282F9CCE0.animname, level.scr_anim[_id_7D489A3282F9CCE0.animname][pack.anime]);
            } else
              player.linkedtoent thread scripts\common\anim::anim_single_solo(player.player_rig, pack.anime, player.linkedtotag);
          } else
            player.linkedtoent thread scripts\mp\anim::anim_player_solo(player, player.player_rig, pack.anime, player.linkedtotag);

          continue;
        }

        if(!isPlayer(player)) {
          if(getdvarint("dvar_BC95D8892007EBFD", 1) && isDefined(player.player_rig._id_7D489A3282F9CCE0)) {
            _id_7D489A3282F9CCE0 = player.player_rig._id_7D489A3282F9CCE0;
            _id_7D489A3282F9CCE0 scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[_id_7D489A3282F9CCE0.animname][pack.anime], animstruct.origin, animstruct.angles, _id_7D489A3282F9CCE0.animname);
            _id_7D489A3282F9CCE0 thread scripts\common\notetrack::start_notetrack_wait(_id_7D489A3282F9CCE0, _id_7D489A3282F9CCE0.animname, pack.anime, _id_7D489A3282F9CCE0.animname, level.scr_anim[_id_7D489A3282F9CCE0.animname][pack.anime]);
          } else
            animstruct thread scripts\common\anim::anim_single_solo(player.player_rig, pack.anime);

          continue;
        }

        animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, pack.anime);
      }

      if(isDefined(animstruct.player_rigs)) {
        if(getdvarint("dvar_BC95D8892007EBFD", 1)) {
          foreach(rig in animstruct.player_rigs) {
            if(isDefined(rig._id_7D489A3282F9CCE0) && isDefined(level.scr_anim[rig._id_7D489A3282F9CCE0.animname][pack.anime])) {
              _id_7D489A3282F9CCE0 = rig._id_7D489A3282F9CCE0;
              _id_7D489A3282F9CCE0 scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[_id_7D489A3282F9CCE0.animname][pack.anime], animstruct.origin, animstruct.angles, _id_7D489A3282F9CCE0.animname);
              _id_7D489A3282F9CCE0 thread scripts\common\notetrack::start_notetrack_wait(_id_7D489A3282F9CCE0, _id_7D489A3282F9CCE0.animname, pack.anime, _id_7D489A3282F9CCE0.animname, level.scr_anim[_id_7D489A3282F9CCE0.animname][pack.anime]);
            }
          }
        } else {
          foreach(rig in animstruct.player_rigs) {
            if(isDefined(rig.player)) {
              continue;
            }
            if(!isDefined(level.scr_anim[rig.animname][pack.anime])) {
              continue;
            }
            if(isDefined(rig.linkedtoent)) {
              rig.linkedtoent thread scripts\common\anim::anim_single_solo(rig, pack.anime, rig.linkedtotag);
              continue;
            }

            animstruct thread scripts\common\anim::anim_single_solo(rig, pack.anime);
          }
        }
      }
    }

    if(pack.ents.size > 0) {
      foreach(ent in pack.ents) {
        if(!istrue(ent._id_6A704063A0555C1D))
          ent dontinterpolate();
      }

      animstruct thread scripts\common\anim::anim_single(pack.ents, pack.anime);
    }

    foreach(rig in pack._id_5BA8DB57A9811D96) {
      _id_2B16B22AC076FDA4 = scripts\engine\utility::ter_op(isDefined(level._id_556C00D8EA5240B9), level._id_556C00D8EA5240B9, "tag_origin");

      foreach(probe in rig._id_83D076584339CBE2) {
        origin_offset = probe.origin_offset;
        angles_offset = probe.angles_offset;

        if(!isDefined(angles_offset))
          angles_offset = (0, 0, 0);

        probe show();
        probe linkTo(rig._id_599217E02A6DA3FA, _id_2B16B22AC076FDA4, origin_offset, angles_offset);
      }

      foreach(light in rig.lights) {
        if(isDefined(light._id_F6F4314E3EB6DDCB))
          light setlightintensity(light._id_F6F4314E3EB6DDCB);
        else if(isDefined(light.original_intensity))
          light setlightintensity(light.original_intensity);

        origin_offset = light.origin_offset;
        angles_offset = light.angles_offset;

        if(!isDefined(angles_offset))
          angles_offset = (0, 0, 0);

        light linkTo(rig._id_599217E02A6DA3FA, _id_2B16B22AC076FDA4, origin_offset, angles_offset);
      }
    }

    animstruct thread _id_00C8FE26D4B964AD(pack);

    if(isDefined(pack._id_437B6BB41D98DF26)) {
      animstruct.cam dontinterpolate();
      animstruct thread scripts\common\anim::anim_single_solo(animstruct.cam, pack.anime);

      foreach(player in level.players) {
        player cameraunlink();
        player _meth_33010A90BCF48DB4(pack._id_437B6BB41D98DF26, 0, animstruct.origin, animstruct.angles, undefined, undefined, level._id_319696A4503E0E48);
      }

      _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(pack._id_437B6BB41D98DF26);
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - 0.033;
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - scripts\engine\utility::mod(_id_8355076D4ED3FC96, 0.05);
      level scripts\engine\utility::waittill_notify_or_timeout("br_ending_skip_scene", _id_8355076D4ED3FC96);
    } else {
      foreach(player in level.players) {
        player _meth_8FF8FD7841F6EBA2();
        player cameralinkTo(animstruct.cam, "tag_player", 1, 1);
      }

      animstruct.cam dontinterpolate();
      animstruct thread scripts\common\anim::anim_single_solo(animstruct.cam, pack.anime);
      scripts\engine\utility::waittill_any_ents(animstruct, pack.anime, level, "br_ending_skip_scene");
    }

    waitframe();

    if(isDefined(pack.endfunc))
      animstruct[[pack.endfunc]](pack._id_315361ABD838FAD4);
  }

  wait 1;
  _id_9D9D6ECB7D1FD8E3(level.br_ending);
}

_id_9D9D6ECB7D1FD8E3(animstruct) {
  if(isDefined(animstruct)) {
    foreach(pack in animstruct.packs) {
      foreach(ent in pack.ents) {
        if(isDefined(ent)) {
          if(isDefined(ent.linkedents))
            scripts\engine\utility::array_delete(ent.linkedents);

          ent delete();
        }
      }

      foreach(player in pack.players) {
        if(isDefined(player) && istrue(player.isdisconnectplayer)) {
          if(isDefined(player.player_rig)) {
            if(isDefined(player.player_rig._id_7D489A3282F9CCE0)) {
              if(isDefined(player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
                player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 delete();

              player.player_rig._id_7D489A3282F9CCE0 delete();
            }

            player.player_rig delete();
          }

          player delete();
        }
      }
    }

    if(isDefined(animstruct.cam))
      animstruct.cam delete();

    animstruct _id_CA521F2B25D09B0D();
  }

  _id_40F4C8F2B94C5CD9::_id_CF47AB3F9DEFE35B();
  _id_40F4C8F2B94C5CD9::allplayers_clearphysicaldof();

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.player_rig)) {
      if(isDefined(player.sessionstate) && player.sessionstate == "spectator")
        player setspectatedefaults(animstruct.origin, animstruct.angles);
      else
        player setOrigin(animstruct.origin);

      if(isDefined(player.player_rig._id_7D489A3282F9CCE0)) {
        if(isDefined(player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
          player.player_rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 delete();

        player.player_rig._id_7D489A3282F9CCE0 delete();
      }

      player.player_rig delete();
    }
  }

  foreach(rig in animstruct.player_rigs) {
    if(!isDefined(rig)) {
      continue;
    }
    if(isDefined(rig._id_7D489A3282F9CCE0)) {
      if(isDefined(rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2))
        rig._id_7D489A3282F9CCE0._id_7BC1C35C0AB292C2 delete();

      rig._id_7D489A3282F9CCE0 delete();
    }

    rig delete();
  }
}

_id_CA521F2B25D09B0D() {
  self notify("stopFadeRunner");

  if(isDefined(self.fadeoverlay))
    self.fadeoverlay destroy();
}

_id_00C8FE26D4B964AD(pack) {
  self notify("fadeRunner");
  self endon("fadeRunner");
  self endon("stopFadeRunner");

  if(!isDefined(self.fadeoverlay)) {
    overlay = newhudelem();
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader("black", 640, 480);
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay setshowinrealism(1);
    self.fadeoverlay = overlay;
  }

  if(!isDefined(pack._id_56508E6F58221410) && !isDefined(pack._id_9AB9FEFE4D2846B1)) {
    self.fadeoverlay.alpha = 0;
    return;
  }

  if(isDefined(pack._id_56508E6F58221410)) {
    self.fadeoverlay.alpha = 1;
    self.fadeoverlay fadeovertime(pack._id_56508E6F58221410);
    self.fadeoverlay.alpha = 0;
    wait(pack._id_56508E6F58221410);
  }

  if(isDefined(pack._id_9AB9FEFE4D2846B1)) {
    _id_43688048F0BB8340 = undefined;

    if(isDefined(pack._id_437B6BB41D98DF26)) {
      _id_8355076D4ED3FC96 = _func_4358B309FDCC6D44(pack._id_437B6BB41D98DF26);
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - 0.033;
      _id_8355076D4ED3FC96 = _id_8355076D4ED3FC96 - scripts\engine\utility::mod(_id_8355076D4ED3FC96, 0.05);
      _id_43688048F0BB8340 = _id_8355076D4ED3FC96;
    } else {
      _id_E26F44ACAD48DDD1 = level.scr_anim["endingCam"][pack.anime];
      animlength = getanimlength(_id_E26F44ACAD48DDD1);
      _id_43688048F0BB8340 = animlength;
    }

    if(isDefined(pack._id_56508E6F58221410))
      _id_43688048F0BB8340 = _id_43688048F0BB8340 - pack._id_56508E6F58221410;

    wait(_id_43688048F0BB8340 - pack._id_9AB9FEFE4D2846B1);
    self.fadeoverlay.alpha = 0;
    self.fadeoverlay fadeovertime(pack._id_9AB9FEFE4D2846B1);
    self.fadeoverlay.alpha = 1;
  }
}

compare_higher_score(_id_52A462A16496CF97, _id_52A463A16496D1CA) {
  return _id_52A462A16496CF97.pers["score"] > _id_52A463A16496D1CA.pers["score"];
}

_id_4B3D6AD67EBA0F73(_id_CF29D316C16E2753, _id_CF29D416C16E2986) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("compareTeamHigherScore"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("compareTeamHigherScore", _id_CF29D316C16E2753, _id_CF29D416C16E2986);

  _id_210753D1848D9BE3 = scripts\engine\utility::array_removeundefined(scripts\mp\utility\teams::getteamdata(_id_CF29D316C16E2753, "alivePlayers"));
  _id_462CCACDBC27588F = 0;

  foreach(player in _id_210753D1848D9BE3)
  _id_462CCACDBC27588F = _id_462CCACDBC27588F + player.pers["score"];

  _id_FE59255B52062994 = scripts\engine\utility::array_removeundefined(scripts\mp\utility\teams::getteamdata(_id_CF29D416C16E2986, "alivePlayers"));
  _id_E861F99F136BD454 = 0;

  foreach(player in _id_FE59255B52062994)
  _id_E861F99F136BD454 = _id_E861F99F136BD454 + player.pers["score"];

  return _id_462CCACDBC27588F > _id_E861F99F136BD454;
}

temp_debug_wait_and_stop_music_loop() {
  wait 25;

  foreach(player in level.players)
  player setplayermusicstate("");
}

ending_viewing_players_setup(animstruct) {
  level.brspawnplayersending = 1;
  level notify("brSpawnPlayersEnding");

  foreach(player in level.players) {
    player _meth_B88C89BB7CD1AB8E(animstruct.origin);
    player scripts\mp\utility\player::hidehudenable();
    player setcinematicmotionoverride("disabled");

    if(!istrue(player._id_A5C9FCD81C474AB0))
      player setclientomnvar("ui_br_squad_eliminated_active", 0);

    if(isDefined(player.sessionstate)) {
      if((player.team == "spectator" || player.team == "codcaster") && !getdvarint("dvar_CF7E9F3447526B4D", 0)) {
        continue;
      }
      if(player.sessionstate == "intermission" || player.sessionstate == "dead")
        player scripts\mp\utility\player::updatesessionstate("spectator");

      if(player.sessionstate == "spectator") {
        player setspectatedefaults(animstruct.cam.origin, animstruct.cam.angles);
        player spawn(animstruct.cam.origin, animstruct.cam.angles);
        continue;
      }

      player setOrigin(animstruct.origin + (0, 0, 100));
    }
  }
}

ending_winning_players_setup(animstruct) {
  players = animstruct.winners;
  spawnorigin = undefined;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.sessionstate) && player.sessionstate == "playing") {
      spawnorigin = player.origin;
      break;
    }
  }

  player_rigs = [];
  _id_D6ED024E641089E0 = 0;

  foreach(index, player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isPlayer(player)) {
      continue;
    }
    if((player.team == "spectator" || player.team == "codcaster") && !getdvarint("dvar_CF7E9F3447526B4D", 0)) {
      continue;
    }
    if(isDefined(player.sessionstate) && player.sessionstate != "playing") {
      player.forcespawnorigin = spawnorigin;
      player.alreadyaddedtoalivecount = 1;
      player scripts\mp\playerlogic::spawnplayer(0);
      player scripts\mp\utility\player::hidehudenable();
    }

    player player_equipment_use_stop();
    player player_abilities_disable();
    player.plotarmor = 1;
    player.oobimmunity = 1;
    player.linkedtoent = undefined;
    player.linkedtotag = undefined;
    player.winindex = _id_D6ED024E641089E0;
    _id_D6ED024E641089E0++;

    if(!isDefined(player.animname) || player.animname != player.brexfilanimname)
      player.animname = player.brexfilanimname;

    player thread player_set_weapon();
    player _id_40F4C8F2B94C5CD9::create_player_rig(player.animname, "viewhands_base_iw8", animstruct);

    if(getdvarint("dvar_BC95D8892007EBFD", 1))
      player _id_40F4C8F2B94C5CD9::_id_050962E9F971266E(player.animname, animstruct.origin);

    level thread _id_40F4C8F2B94C5CD9::ending_player_disconnect_thread(player);
    player_rigs[player_rigs.size] = player.player_rig;
  }

  return player_rigs;
}

_id_E50B941AFD09E62E(_id_03784E17637539B8) {
  if(!isDefined(_id_03784E17637539B8)) {
    return;
  }
  _id_03784E17637539B8 = scripts\engine\utility::array_removeundefined(_id_03784E17637539B8);
  _id_03784E17637539B8 = scripts\engine\utility::array_sort_with_func(_id_03784E17637539B8, ::compare_higher_score);
  _func_B716EE9A63B63254("winners", _id_03784E17637539B8);
}

_id_226B83F846D32FF2(_id_03784E17637539B8) {
  if(!isDefined(_id_03784E17637539B8)) {
    return;
  }
  _id_03784E17637539B8 = scripts\engine\utility::array_removeundefined(_id_03784E17637539B8);
  _id_03784E17637539B8 = scripts\engine\utility::array_sort_with_func(_id_03784E17637539B8, ::compare_higher_score);
  accolades = [];

  foreach(winner in _id_03784E17637539B8) {
    if(!isDefined(winner._id_AE06891211AF23BA)) {
      continue;
    }
    _id_CAA2AFB2CDCB7815 = level._id_E3FCA817C22E740D[winner._id_AE06891211AF23BA];
    accolades = scripts\engine\utility::array_add(accolades, _id_CAA2AFB2CDCB7815);
  }

  _func_B716EE9A63B63254("accolades", accolades);
}

player_equipment_use_stop() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self.vehicle);

  if(scripts\cp_mp\vehicles\vehicle::_id_A164FB69837475D5())
    scripts\cp_mp\vehicles\vehicle::_id_C2D52509BD96DC18();

  if(istrue(self.usingascender))
    scripts\cp_mp\auto_ascender::ascenderinstantstop();

  if(isDefined(self.remoteuav))
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();

  if(isDefined(self.currentturret))
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);

  if(isDefined(self.usingremote)) {
    vehicles = vehicle_getarray();

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.owner) && vehicle.owner == self) {
        if(isDefined(vehicle.helperdronetype))
          vehicle scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(1);
      }
    }
  }
}

player_abilities_disable() {
  if(!isPlayer(self)) {
    return;
  }
  scripts\mp\utility\player::_freezecontrols(1, undefined, "brEnding");
  _id_3B64EB40368C1450::set("brEnding", "offhand_weapons", 0);
  _id_3B64EB40368C1450::set("brEnding", "melee", 0);
  _id_3B64EB40368C1450::set("brEnding", "ads", 0);
  _id_3B64EB40368C1450::set("brEnding", "fire", 0);
  _id_3B64EB40368C1450::set("brEnding", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("brEnding", "vehicle_use", 0);
  self skydive_interrupt();
}

player_abilities_enable() {
  if(!isPlayer(self)) {
    return;
  }
  scripts\mp\utility\player::_freezecontrols(0, undefined, "brEnding");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("brEnding");
}

player_set_weapon() {
  _id_280ABCD08CBDCC79 = undefined;
  weapons = self getweaponslistprimaries();
  currentweapon = self getcurrentweapon();
  weapons = scripts\engine\utility::array_combine_unique([currentweapon], weapons);

  foreach(weapon in weapons) {
    if(isDefined(level._id_D3378A0C330F9718)) {
      if(!scripts\engine\utility::array_contains(level._id_D3378A0C330F9718, weapon.classname) || weapontype(weapon) == "riotshield")
        continue;
    } else if(weapon.classname != "rifle") {
      continue;
    }
    if(istrue(weapon.ismelee)) {
      continue;
    }
    _id_280ABCD08CBDCC79 = weapon;

    if(isDefined(_id_280ABCD08CBDCC79)) {
      break;
    }
  }

  if(!isnullweapon(self.currentweapon)) {
    self clearaccessory();
    self takeallweapons();
  } else
    waitframe();

  if(!isDefined(_id_280ABCD08CBDCC79))
    _id_280ABCD08CBDCC79 = _id_2669878CF5A1B6BC::buildweapon("iw9_ar_mike4", [], "none", "none");

  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_280ABCD08CBDCC79, undefined, undefined, 1);
  self.pers["primaryWeapon"] = getcompleteweaponname(_id_280ABCD08CBDCC79);
  self.primaryweapon = getcompleteweaponname(_id_280ABCD08CBDCC79);
  self.primaryweaponobj = _id_280ABCD08CBDCC79;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;

  if(isDefined(self.executionref))
    scripts\cp_mp\execution::_giveexecution(self.executionref);

  if(self getweaponammoclip(_id_280ABCD08CBDCC79) < 5)
    self setweaponammoclip(_id_280ABCD08CBDCC79, 5);

  _id_F9CEB9EB8DD4C604 = self switchtoweapon(_id_280ABCD08CBDCC79);
}

_id_9AFBEE75CFE14B8D() {
  type = getDvar("dvar_D3806641B576AD90", "chopper2");

  if(isDefined(level._id_D81F9416F44AB4BA))
    type = level._id_D81F9416F44AB4BA._id_747D19FAF68A7748;

  return type;
}

set_ending_pack(type, _id_CBFC3BA10CEFC8CE) {
  switch (type) {
    case "mgl_ftue_tutorial":
      _id_58321BE04DCA3E61::chopperexfil_pack(_id_CBFC3BA10CEFC8CE);
      break;
    case "chopper2":
      _id_1FC2350D8AEBB68E::chopperexfil_pack(_id_CBFC3BA10CEFC8CE);
      break;
    case "chopper":
    default:
      _id_0F4678C9C2A5B24E::chopperexfil_pack(_id_CBFC3BA10CEFC8CE);
      break;
  }
}

_id_2845C7AFF5B6D7B6(type) {
  switch (type) {
    case "chopper2":
      return _id_1FC2350D8AEBB68E::get_chopperexfil_transient();
    case "chopper":
    default:
      return _id_0F4678C9C2A5B24E::get_chopperexfil_transient();
  }
}

_id_5197CC12048F8766(type) {
  switch (type) {
    case "chopper2":
      return _id_1FC2350D8AEBB68E::_id_A5538B1593309BB0();
    case "chopper":
    default:
      return _id_0F4678C9C2A5B24E::_id_A5538B1593309BB0();
  }
}

create_exfil_animstruct(winners, _id_CBFC3BA10CEFC8CE) {
  struct = get_ending_struct(winners, _id_CBFC3BA10CEFC8CE);
  struct.winners = winners;
  struct.cam = struct _id_40F4C8F2B94C5CD9::create_cam();
  return struct;
}

_id_87F45430D8DE267A() {
  waittillframeend;
  level._id_0E4A685C0A836454 = _id_0BD87576B75AF246();
}

_id_0BD87576B75AF246() {
  if(level.script == "mp_br_mechanics" || level.script == "mp_br_mechanics_pm")
    return scripts\engine\utility::getStructArray("br_ending_spot", "targetname");
  else if(level.script == "mp_mgl_ftue_downtown")
    return _id_50C9687CCCD76C7F();
  else if(level.script == "mp_br_quarry")
    return mp_br_quarry_locations();
  else if(level.script == "mp_escape2")
    return _id_35C3E71A666E6CB2();
  else if(level.script == "mp_escape3")
    return _id_35C3E71A666E6CB2();
  else if(level.script == "mp_mgl_escape4")
    return _id_BCE27E24255486F0();
  else if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    return _id_D076DB51878A786B();
  else if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    return _id_DEF43D85B603EF19();
  else if(scripts\cp_mp\utility\game_utility::isdonetskmap())
    return mp_donetsk_locations();
  else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    return _id_C5C3D7914A4DF89A();
  else
    return [];
}

get_ending_struct(players, _id_CBFC3BA10CEFC8CE) {
  players = scripts\engine\utility::array_removeundefined(players);

  if(players.size > 0)
    origin = _id_40F4C8F2B94C5CD9::get_center_of_array(players);
  else
    origin = _id_CBFC3BA10CEFC8CE;

  _id_9E4E1482CB40C9C5 = sortbydistance(level._id_0E4A685C0A836454, origin);

  if(!isDefined(_id_9E4E1482CB40C9C5[0].angles))
    _id_9E4E1482CB40C9C5[0].angles = (0, 0, 0);

  return _id_9E4E1482CB40C9C5[0];
}

clear_vehicles(origin, radius) {
  vehicles = vehicle_getarrayinradius(origin, radius, 20000);

  foreach(vehicle in vehicles) {
    if(!istrue(vehicle._id_90ACDD32579DCB16))
      vehicle delete();
  }
}

_id_1ABB2E32FB5915C4() {
  foreach(player in level.br_ending.winners) {
    if(isDefined(player.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(player.laststandoutlineid, player);
      player.laststandoutlineid = undefined;
    }
  }
}

mp_donetsk_locations() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((-35516, -26964, -290.492), (0, -37.2493, 0), 1);
  _id_9E4E1482CB40C9C5[1] = create_struct((-24507.4, -31751.5, -118), (0, 24.7373, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((-18475.3, -38031.3, 1390), (0, 21.3294, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((-22962.6, -26693.8, -133.431), (0, -79.9927, 0), 1);
  _id_9E4E1482CB40C9C5[4] = create_struct((-21665.5, -27275.8, -148.989), (0, -36.6941, 0), 1);
  _id_9E4E1482CB40C9C5[5] = create_struct((-21726, -25961.2, -146), (0, -108.126, 0), 1);
  _id_9E4E1482CB40C9C5[6] = create_struct((-12285.8, -40588.5, 518.07), (0, -148.112, 0), 1);
  _id_9E4E1482CB40C9C5[7] = create_struct((-36409.6, -14177.9, -286.708), (0, -15.7255, 0), 1);
  _id_9E4E1482CB40C9C5[8] = create_struct((-30525.8, -17654.2, -234.947), (0, -127.959, 0), 1);
  _id_9E4E1482CB40C9C5[9] = create_struct((-17170.3, -31131.8, 264.201), (0, -174.161, 0), 1);
  _id_9E4E1482CB40C9C5[10] = create_struct((-28797.3, -17400, -241.606), (0, 16.8587, 0));
  _id_9E4E1482CB40C9C5[11] = create_struct((-18155.4, -27275.3, -224.811), (0, -121.999, 0), 1);
  _id_9E4E1482CB40C9C5[12] = create_struct((-9975.39, -38284.4, 344.1), (0, -46.4665, 0), 1);
  _id_9E4E1482CB40C9C5[13] = create_struct((-29281.2, -13754.2, -145.391), (0, -11.8112, 0));
  _id_9E4E1482CB40C9C5[14] = create_struct((-17821.6, -23448.4, -262), (0, 62.3774, 0), 1);
  _id_9E4E1482CB40C9C5[15] = create_struct((-18619.8, -20889.8, -257.189), (0, -71.9892, 0), 1);
  _id_9E4E1482CB40C9C5[16] = create_struct((-14480.9, -25405.9, -288.831), (0, 154.786, 0), 1);
  _id_9E4E1482CB40C9C5[17] = create_struct((-9256.33, -33580.9, 158.984), (0, 146.051, 0), 1);
  _id_9E4E1482CB40C9C5[18] = create_struct((-8492.02, -34971.8, 166.312), (0, 161.494, 0), 1);
  _id_9E4E1482CB40C9C5[19] = create_struct((-16599, -22468.6, -278.939), (0, 154.273, 0), 1);
  _id_9E4E1482CB40C9C5[20] = create_struct((-11999.8, -28038.4, -31.998), (0, 5.45263, 0), 1);
  _id_9E4E1482CB40C9C5[21] = create_struct((-32056.9, -9169.36, -306.919), (0, 71.9528, 0));
  _id_9E4E1482CB40C9C5[22] = create_struct((-23530.6, -14806.7, -69.1128), (0, -153.028, 0), 1);
  _id_9E4E1482CB40C9C5[23] = create_struct((-27480.3, -10672.5, -69.3776), (0, -3.16859, 0), 1);
  _id_9E4E1482CB40C9C5[24] = create_struct((-4660.23, -38889.8, 608.219), (0, 63.5175, 0), 1);
  _id_9E4E1482CB40C9C5[25] = create_struct((-10475.2, -27452, -31.9999), (0, 118.642, 0), 1);
  _id_9E4E1482CB40C9C5[26] = create_struct((-20693.1, -15175.3, -304), (0, -66.6904, 0));
  _id_9E4E1482CB40C9C5[27] = create_struct((-16776.3, -18894, -338.316), (0, -15.0922, 0), 1);
  _id_9E4E1482CB40C9C5[28] = create_struct((-26751, -7621.31, 40.6807), (0, 58.4382, 0));
  _id_9E4E1482CB40C9C5[29] = create_struct((-13668.5, -18519.2, -368), (0, -143.119, 0));
  _id_9E4E1482CB40C9C5[30] = create_struct((-22473.8, -10149.8, -301.138), (0, -70.3961, 0), 1);
  _id_9E4E1482CB40C9C5[31] = create_struct((-11184.8, -21061.9, -315.854), (0, 5.70909, 0), 1);
  _id_9E4E1482CB40C9C5[32] = create_struct((-30018.7, -4590.08, -316.327), (0, 23.8697, 0));
  _id_9E4E1482CB40C9C5[33] = create_struct((-4140.38, -30726.9, 278.381), (0, -144.114, 0));
  _id_9E4E1482CB40C9C5[34] = create_struct((-34822.4, -1184.25, -263.947), (0, -71.6069, 0), 1);
  _id_9E4E1482CB40C9C5[35] = create_struct((-26229.5, -4015.4, -313.889), (0, -117.77, 0), 1);
  _id_9E4E1482CB40C9C5[36] = create_struct((-30027.8, -1782.43, -313.225), (0, 175.937, 0));
  _id_9E4E1482CB40C9C5[37] = create_struct((-27619.2, -2302.54, -313.891), (0, -8.77301, 0), 1);
  _id_9E4E1482CB40C9C5[38] = create_struct((-7118.65, -19301.2, -144), (0, -5.73525, 0), 1);
  _id_9E4E1482CB40C9C5[39] = create_struct((-10491.1, -14985.5, -360), (0, -103.058, 0), 1);
  _id_9E4E1482CB40C9C5[40] = create_struct((-14283.6, -11003.1, -315.39), (0, 7.08201, 0));
  _id_9E4E1482CB40C9C5[41] = create_struct((-23169, -3966.54, -321.134), (0, -83.3339, 0), 1);
  _id_9E4E1482CB40C9C5[42] = create_struct((-8787.73, -15589.1, -367.949), (0, 100.158, 0), 1);
  _id_9E4E1482CB40C9C5[43] = create_struct((-817.503, -25527.6, -256.485), (0, -66.9498, 0), 1);
  _id_9E4E1482CB40C9C5[44] = create_struct((-14242.2, -8993.57, -285.128), (0, 40.3822, 0));
  _id_9E4E1482CB40C9C5[45] = create_struct((4555.72, -36115.3, -200.848), (0, -156.66, 0), 1);
  _id_9E4E1482CB40C9C5[46] = create_struct((1627.87, -28799.2, 312), (0, 150.838, 0), 1);
  _id_9E4E1482CB40C9C5[47] = create_struct((-9101.03, -10035.7, -320), (0, 33.7296, 0));
  _id_9E4E1482CB40C9C5[48] = create_struct((-6042.41, -13135.6, -363.999), (0, -134.727, 0), 1);
  _id_9E4E1482CB40C9C5[49] = create_struct((3185.75, -25611.3, -288.702), (0, 93.1862, 0), 1);
  _id_9E4E1482CB40C9C5[50] = create_struct((1792.7, -23147, -290.615), (0, -151.835, 0), 1);
  _id_9E4E1482CB40C9C5[51] = create_struct((-35463.8, 7869.36, 52.9549), (0, -93.1204, 0), 1);
  _id_9E4E1482CB40C9C5[52] = create_struct((-716.066, -18775.2, 934), (0, -148.79, 0));
  _id_9E4E1482CB40C9C5[53] = create_struct((1588.6, -20401.1, -285), (0, -58.1805, 0));
  _id_9E4E1482CB40C9C5[54] = create_struct((12452, -35755.6, -484), (0, -28.7822, 0), 1);
  _id_9E4E1482CB40C9C5[55] = create_struct((4648.29, -19224.9, -286.002), (0, 28.824, 0), 1);
  _id_9E4E1482CB40C9C5[56] = create_struct((-21706.1, 6555.31, -279.84), (0, 5.8398, 0), 1);
  _id_9E4E1482CB40C9C5[57] = create_struct((-16018.1, 4086.84, -318.486), (0, 3.79374, 0), 1);
  _id_9E4E1482CB40C9C5[58] = create_struct((-25374.2, 10918.1, -320), (0, 120.887, 0), 1);
  _id_9E4E1482CB40C9C5[59] = create_struct((-12119.8, 2981.18, -329.815), (0, 105.554, 0), 1);
  _id_9E4E1482CB40C9C5[60] = create_struct((-14767.3, 5096.92, -400.009), (0, 131.701, 0), 1);
  _id_9E4E1482CB40C9C5[61] = create_struct((8177.97, -19326, -286.002), (0, 91.7841, 0), 1);
  _id_9E4E1482CB40C9C5[62] = create_struct((15726.9, -35325.4, 318.345), (0, 151.377, 0), 1);
  _id_9E4E1482CB40C9C5[63] = create_struct((11454.7, -22581.5, -214.023), (0, -92.045, 0), 1);
  _id_9E4E1482CB40C9C5[64] = create_struct((-21126.1, 11662.1, -317.002), (0, -174.747, 0), 1);
  _id_9E4E1482CB40C9C5[65] = create_struct((-7293.09, 3009.49, -317.508), (0, -152.562, 0), 1);
  _id_9E4E1482CB40C9C5[66] = create_struct((17629.6, -32800.1, 15.9988), (0, 7.32444, 0), 1);
  _id_9E4E1482CB40C9C5[67] = create_struct((504.818, -3834.63, -336), (0, 66.6309, 0), 1);
  _id_9E4E1482CB40C9C5[68] = create_struct((-25415.2, 15191.1, -325.003), (0, -84.1954, 0), 1);
  _id_9E4E1482CB40C9C5[69] = create_struct((13957.3, -21816.1, -194), (0, -75.6819, 0), 1);
  _id_9E4E1482CB40C9C5[70] = create_struct((-10176, 6713.5, -400), (0, 75.3382, 0), 1);
  _id_9E4E1482CB40C9C5[71] = create_struct((-15327.9, 10742.1, -400), (0, 32.2232, 0), 1);
  _id_9E4E1482CB40C9C5[72] = create_struct((8420.99, -11753.6, 306), (0, 83.4712, 0), 1);
  _id_9E4E1482CB40C9C5[73] = create_struct((-22216, 14718, -64.0002), (0, -82.0633, 0), 1);
  _id_9E4E1482CB40C9C5[74] = create_struct((-17022, 11976.4, -322.43), (0, 105.663, 0), 1);
  _id_9E4E1482CB40C9C5[75] = create_struct((-30924.8, 19829.7, 205), (0, -69.3892, 0), 1);
  _id_9E4E1482CB40C9C5[76] = create_struct((-2024.99, 3060.21, -330.017), (0, -158.048, 0), 1);
  _id_9E4E1482CB40C9C5[77] = create_struct((-28136.9, 19575.5, -448.227), (0, -98.4958, 0), 1);
  _id_9E4E1482CB40C9C5[78] = create_struct((-12771.2, 11772.2, -326.973), (0, 19.9583, 0), 1);
  _id_9E4E1482CB40C9C5[79] = create_struct((22131, -32223, -440), (0, 119.727, 0), 1);
  _id_9E4E1482CB40C9C5[80] = create_struct((-5075.7, 7706.88, -323.004), (0, 133.054, 0), 1);
  _id_9E4E1482CB40C9C5[81] = create_struct((-22334.3, 18697.4, 688.005), (0, 140.553, 0), 1);
  _id_9E4E1482CB40C9C5[82] = create_struct((-25425.5, 20658.8, -448), (0, 0.274191, 0), 1);
  _id_9E4E1482CB40C9C5[83] = create_struct((23625.3, -31238.1, -563.054), (0, -52.2092, 0), 1);
  _id_9E4E1482CB40C9C5[84] = create_struct((-33327.4, 24789.2, 12.4296), (0, -44.4776, 0), 1);
  _id_9E4E1482CB40C9C5[85] = create_struct((21118.3, -22709.8, -232), (0, 42.769, 0));
  _id_9E4E1482CB40C9C5[86] = create_struct((-28418.1, 23715.5, -447.994), (0, -89.5397, 0), 1);
  _id_9E4E1482CB40C9C5[87] = create_struct((16769.7, -13392.7, 356.076), (0, -37.8018, 0));
  _id_9E4E1482CB40C9C5[88] = create_struct((-13952.5, 17259.8, -324), (0, -76.2444, 0), 1);
  _id_9E4E1482CB40C9C5[89] = create_struct((24205.4, -25029.5, -328.008), (0, 169.376, 0), 1);
  _id_9E4E1482CB40C9C5[90] = create_struct((12118.5, -3994.79, -340.649), (0, -23.2087, 0), 1);
  _id_9E4E1482CB40C9C5[91] = create_struct((-17899.8, 21527.3, -450.34), (0, -8.05977, 0), 1);
  _id_9E4E1482CB40C9C5[92] = create_struct((22217.9, -18422.9, 632), (0, 162.28, 0), 1);
  _id_9E4E1482CB40C9C5[93] = create_struct((21407.1, -16363.3, 1916.75), (0, -1.0712, 0), 1);
  _id_9E4E1482CB40C9C5[94] = create_struct((-2832.02, 13488.4, -319.985), (0, -0.230498, 0), 1);
  _id_9E4E1482CB40C9C5[95] = create_struct((3266.46, 9488.52, -317.067), (0, 97.6153, 0), 1);
  _id_9E4E1482CB40C9C5[96] = create_struct((22117.5, -13790.4, 256.102), (0, 135.758, 0), 1);
  _id_9E4E1482CB40C9C5[97] = create_struct((24850.9, -18555.2, -208.2), (0, -76.8969, 0), 1);
  _id_9E4E1482CB40C9C5[98] = create_struct((-23053.6, 27499.5, -460.201), (0, 83.541, 0), 1);
  _id_9E4E1482CB40C9C5[99] = create_struct((-8326.54, 20049.9, -257.261), (0, 110.381, 0), 1);
  _id_9E4E1482CB40C9C5[100] = create_struct((19238.7, -6573.38, -40), (0, -88.569, 0));
  _id_9E4E1482CB40C9C5[101] = create_struct((-36685.3, 33440.3, 1474.01), (0, -73.7051, 0), 1);
  _id_9E4E1482CB40C9C5[102] = create_struct((26569.7, -16938.2, -221.571), (0, 92.2376, 0), 1);
  _id_9E4E1482CB40C9C5[103] = create_struct((26412.2, -13112.5, -264), (0, 55.7859, 0), 1);
  _id_9E4E1482CB40C9C5[104] = create_struct((20248.8, -2154.65, -506.989), (0, 116.839, 0));
  _id_9E4E1482CB40C9C5[105] = create_struct((-6577.92, 23388.3, -448.004), (0, -101.867, 0), 1);
  _id_9E4E1482CB40C9C5[106] = create_struct((18069.7, 1558.6, -590.448), (0, -85.7224, 0), 1);
  _id_9E4E1482CB40C9C5[107] = create_struct((-10855.2, 27363.9, -259.411), (0, 148.092, 0), 1);
  _id_9E4E1482CB40C9C5[108] = create_struct((-2919.92, 22409.8, -446.75), (0, -78.7055, 0), 1);
  _id_9E4E1482CB40C9C5[109] = create_struct((-16866.8, 30593, -225.8), (0, -75.0401, 0), 1);
  _id_9E4E1482CB40C9C5[110] = create_struct((37954.1, -37722.9, -577.993), (0, 69.8195, 0), 1);
  _id_9E4E1482CB40C9C5[111] = create_struct((35023.3, -24338.2, -566), (0, 53.0156, 0), 1);
  _id_9E4E1482CB40C9C5[112] = create_struct((16187.4, 8712.66, -332.163), (0, -84.2018, 0), 1);
  _id_9E4E1482CB40C9C5[113] = create_struct((-25609.6, 36743.4, 348.439), (0, -160.438, 0));
  _id_9E4E1482CB40C9C5[114] = create_struct((-14068.2, 31959.7, -250.623), (0, -153.916, 0), 1);
  _id_9E4E1482CB40C9C5[115] = create_struct((29348.7, -8361.65, -424.006), (0, -81.6393, 0), 1);
  _id_9E4E1482CB40C9C5[116] = create_struct((8670.39, 18913.1, -303.729), (0, 105.535, 0), 1);
  _id_9E4E1482CB40C9C5[117] = create_struct((35020.4, -16139.2, -572.017), (0, 58.7604, 0), 1);
  _id_9E4E1482CB40C9C5[118] = create_struct((19630.8, 10158.6, -451.09), (0, -142.492, 0), 1);
  _id_9E4E1482CB40C9C5[119] = create_struct((43465.3, -36148.1, 51.093), (0, 112.905, 0));
  _id_9E4E1482CB40C9C5[120] = create_struct((-19560, 39017.6, -640), (0, 105.902, 0));
  _id_9E4E1482CB40C9C5[121] = create_struct((3395.98, 28640.1, 1.42773), (0, 135.948, 0), 1);
  _id_9E4E1482CB40C9C5[122] = create_struct((-12456.8, 38252.8, 0.642883), (0, 136.198, 0));
  _id_9E4E1482CB40C9C5[123] = create_struct((34810.3, -3657.19, -488), (0, -139.433, 0));
  _id_9E4E1482CB40C9C5[124] = create_struct((48307, -38482.1, 2272), (0, 54.6218, 0), 1);
  _id_9E4E1482CB40C9C5[125] = create_struct((17534.5, 19736.7, 318.301), (0, -103.234, 0), 1);
  _id_9E4E1482CB40C9C5[126] = create_struct((49054.6, -37186.3, 2272.02), (0, 62.8379, 0), 1);
  _id_9E4E1482CB40C9C5[127] = create_struct((-26149.3, 47192.9, 2703.16), (0, 36.4515, 0));
  _id_9E4E1482CB40C9C5[128] = create_struct((50932.9, -41318, 1347), (0, -109.525, 0), 1);
  _id_9E4E1482CB40C9C5[129] = create_struct((44159.8, -13820.7, -87.1293), (0, -7.88874, 0));
  _id_9E4E1482CB40C9C5[130] = create_struct((51090.6, -34587.3, 1343.9), (0, -9.93786, 0), 1);
  _id_9E4E1482CB40C9C5[131] = create_struct((32681, 7595.22, -497.554), (0, -48.5794, 0), 1);
  _id_9E4E1482CB40C9C5[132] = create_struct((35336.5, 3905.92, -551.754), (0, -23.8152, 0), 1);
  _id_9E4E1482CB40C9C5[133] = create_struct((52357.4, -33339, 1258.09), (0, -20.541, 0), 1);
  _id_9E4E1482CB40C9C5[134] = create_struct((-520.246, 39710.8, 2783), (0, -72.5011, 0), 1);
  _id_9E4E1482CB40C9C5[135] = create_struct((45634.6, -11566.6, -58.2778), (0, -151.105, 0), 1);
  _id_9E4E1482CB40C9C5[136] = create_struct((50376.7, -21886.4, -395.252), (0, -23.787, 0));
  _id_9E4E1482CB40C9C5[137] = create_struct((51570.2, -24783.1, -113.531), (0, 104.684, 0), 1);
  _id_9E4E1482CB40C9C5[138] = create_struct((39824, 1114.83, -424.993), (0, 138.361, 0), 1);
  _id_9E4E1482CB40C9C5[139] = create_struct((25390.7, 20043.1, 1343.21), (0, 135.63, 0), 1);
  _id_9E4E1482CB40C9C5[140] = create_struct((52294.1, -25802.7, -83.0376), (0, -19.67, 0), 1);
  _id_9E4E1482CB40C9C5[141] = create_struct((-11742.3, 47596, 1790.51), (0, -161.796, 0), 1);
  _id_9E4E1482CB40C9C5[142] = create_struct((44198.1, -4238.47, 266.547), (0, -102.295, 0));
  _id_9E4E1482CB40C9C5[143] = create_struct((48747.6, -12179.9, 14.8108), (0, -111.192, 0), 1);
  _id_9E4E1482CB40C9C5[144] = create_struct((46453.4, -6647.04, 208.457), (0, -15.0621, 0), 1);
  _id_9E4E1482CB40C9C5[145] = create_struct((12849.3, 34747.5, 2458.5), (0, -39.4017, 0), 1);
  _id_9E4E1482CB40C9C5[146] = create_struct((52493.1, -17205.6, -391.658), (0, 19.0522, 0), 1);
  _id_9E4E1482CB40C9C5[147] = create_struct((54470.9, -21095.7, -394.817), (0, -68.4661, 0));
  _id_9E4E1482CB40C9C5[148] = create_struct((-24417, 56523.2, 2659.76), (0, -129.922, 0), 1);
  _id_9E4E1482CB40C9C5[149] = create_struct((37257.1, 13799.8, 232), (0, 22.0809, 0), 1);
  _id_9E4E1482CB40C9C5[150] = create_struct((23294, 29633.7, 1019.7), (0, 17.9623, 0), 1);
  _id_9E4E1482CB40C9C5[151] = create_struct((-9892.05, 53353.9, 2428.22), (0, -25.4412, 0));
  _id_9E4E1482CB40C9C5[152] = create_struct((49428.4, 1843.77, 19.9863), (0, 175.256, 0), 1);
  _id_9E4E1482CB40C9C5[153] = create_struct((3411.24, 49881.5, 1032), (0, 83.1958, 0), 1);
  _id_9E4E1482CB40C9C5[154] = create_struct((57090, -11008.2, -433.158), (0, -94.4655, 0), 1);
  _id_9E4E1482CB40C9C5[155] = create_struct((20175.4, 39040, 957.372), (0, 82.8313, 0), 1);
  _id_9E4E1482CB40C9C5[156] = create_struct((-8255.86, 57148.3, 1071.37), (0, -11.2614, 0), 1);
  _id_9E4E1482CB40C9C5[157] = create_struct((51848.1, 3726.24, 29.3418), (0, 172.199, 0), 1);
  _id_9E4E1482CB40C9C5[158] = create_struct((50898.1, 6776.73, 29.7878), (0, -8.3196, 0), 1);
  _id_9E4E1482CB40C9C5[159] = create_struct((-17676, 62373.4, 1908.92), (0, -4.78614, 0));
  _id_9E4E1482CB40C9C5[160] = create_struct((12324.8, 47493.6, 1036), (0, -44.8196, 0), 1);
  _id_9E4E1482CB40C9C5[161] = create_struct((29716.1, 34472.4, 435.436), (0, -133.228, 0), 1);
  _id_9E4E1482CB40C9C5[162] = create_struct((37269.7, 27514, 190.688), (0, -36.7275, 0), 1);
  _id_9E4E1482CB40C9C5[163] = create_struct((46679.8, 17932.4, -352.184), (0, 157.463, 0), 1);
  _id_9E4E1482CB40C9C5[164] = create_struct((53649.7, 7546.33, 29.3552), (0, -107.59, 0), 1);
  _id_9E4E1482CB40C9C5[165] = create_struct((57918.4, 650.832, 41.0137), (0, 106.07, 0), 1);
  _id_9E4E1482CB40C9C5[166] = create_struct((7073.74, 57285.5, 1036), (0, 164.547, 0), 1);
  _id_9E4E1482CB40C9C5[167] = create_struct((27957.2, 43805.1, 1753.23), (0, -142.754, 0), 1);
  _id_9E4E1482CB40C9C5[168] = create_struct((20050.9, 52735.7, 1917.76), (0, 137.974, 0), 1);
  _id_9E4E1482CB40C9C5[169] = create_struct((43887.3, 31928.7, -198.527), (0, -93.8224, 0), 1);
  _id_9E4E1482CB40C9C5[170] = create_struct((44717.5, 39263.5, -42.8776), (0, -102.018, 0), 1);
  _id_9E4E1482CB40C9C5[171] = create_struct((37958.5, 47398, 944.177), (0, -119.853, 0), 1);
  return _id_9E4E1482CB40C9C5;
}

_id_50C9687CCCD76C7F() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = create_struct((26952, -6018, -454), (0, 50, 0));
  return _id_9E4E1482CB40C9C5;
}

mp_br_quarry_locations() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = create_struct((29786.7, 41132.6, 749.673), (0, -132.937, 0));
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = create_struct((31330.7, 43775.2, 685), (0, -111.923, 0));
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = create_struct((37671.1, 42532.2, 857.039), (0, -169.422, 0));
  _id_9E4E1482CB40C9C5[_id_9E4E1482CB40C9C5.size] = create_struct((40311.2, 44060.2, 1326.98), (0, 169.247, 0));
  return _id_9E4E1482CB40C9C5;
}

_id_35C3E71A666E6CB2() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((-3052, -3432.96, 569.921), (0, -17.561, 0));
  _id_9E4E1482CB40C9C5[1] = create_struct((13184, 6231.49, 987.665), (0, -168.487, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((1692.81, 8271, 530.205), (0, 15, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((-11464.6, -6999.94, 419.45), (0, 74.113, 0));
  _id_9E4E1482CB40C9C5[4] = create_struct((14031.4, -4991.84, 940.06), (0, -120.533, 0));
  return _id_9E4E1482CB40C9C5;
}

_id_BCE27E24255486F0() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((-438, -8424.5, 152), (0, 0, 0));
  _id_9E4E1482CB40C9C5[1] = create_struct((-4525.68, 1663.06, 707.792), (0, 78.8, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((-1087.67, 9912.43, 651.942), (0, 233.66, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((853.004, -5868.04, 704.038), (0, 14.257, 0));
  _id_9E4E1482CB40C9C5[4] = create_struct((2782.44, 89.107, 832.712), (0, 30, 0));
  return _id_9E4E1482CB40C9C5;
}

_id_D076DB51878A786B() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((-39369, -41359.9, 411.4), (0, 95.7673, 0));
  _id_9E4E1482CB40C9C5[1] = create_struct((-29293.8, -47264.3, 276), (0, -101.788, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((9846.07, 47782.9, 575.094), (0, 90.5157, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((-30254.6, -36462.8, 241.5), (0, -164.467, -2));
  _id_9E4E1482CB40C9C5[4] = create_struct((-21745.5, -51712, 261.833), (0, -71.035, 0));
  _id_9E4E1482CB40C9C5[5] = create_struct((-35403, -29096.8, 311.263), (0, 40.6488, 0));
  _id_9E4E1482CB40C9C5[6] = create_struct((-47587, -21495.3, 311.086), (0, -71.0138, 0));
  _id_9E4E1482CB40C9C5[7] = create_struct((-42779.8, -19913.7, 252.753), (0, 164.988, 0));
  _id_9E4E1482CB40C9C5[8] = create_struct((4933.63, 49820.8, 1907.15), (0, -23.6093, 0));
  _id_9E4E1482CB40C9C5[9] = create_struct((-53201.4, -16206.4, 254.664), (0, 114.356, 0));
  _id_9E4E1482CB40C9C5[10] = create_struct((-23649.7, -34362.4, 489.954), (0, -67.4042, 0));
  _id_9E4E1482CB40C9C5[11] = create_struct((-15872.1, -51561, 321.765), (0, -69.1303, 0));
  _id_9E4E1482CB40C9C5[12] = create_struct((-17394.6, -43027, 925), (0, 123.744, -1));
  _id_9E4E1482CB40C9C5[13] = create_struct((-36460.4, -17743.9, 262.875), (0, -43.5358, 0));
  _id_9E4E1482CB40C9C5[14] = create_struct((-28487, -23065.3, 265.088), (0, 105.75, 0));
  _id_9E4E1482CB40C9C5[15] = create_struct((-48507.7, -11325.2, 256.32), (0, 152.829, 0));
  _id_9E4E1482CB40C9C5[16] = create_struct((-12324.6, -34717.9, 477.875), (0, 61.9439, 0));
  _id_9E4E1482CB40C9C5[17] = create_struct((-23305.9, -16827.7, 341.438), (0, -84.3488, 0));
  _id_9E4E1482CB40C9C5[18] = create_struct((-6158.99, -41637.6, 518.924), (0, -22.1046, 0));
  _id_9E4E1482CB40C9C5[19] = create_struct((-14976, -24951.6, 636.613), (0, 151.061, 0));
  _id_9E4E1482CB40C9C5[20] = create_struct((-4178.91, -46745.5, 303.502), (0, 61.9816, 0));
  _id_9E4E1482CB40C9C5[21] = create_struct((-30650, -10325, 2126), (5, 2.45985, 0));
  _id_9E4E1482CB40C9C5[22] = create_struct((-46484.1, -2479.36, 680.235), (0, 119.324, 0));
  _id_9E4E1482CB40C9C5[23] = create_struct((-185.708, -49385.1, 255.524), (0, -163.12, 0));
  _id_9E4E1482CB40C9C5[24] = create_struct((26252, 29932, 581.266), (0, 45.5604, 0));
  _id_9E4E1482CB40C9C5[25] = create_struct((-4360.26, -31269.6, 969.544), (0, 56.5222, 0));
  _id_9E4E1482CB40C9C5[26] = create_struct((-35260.7, -2454.81, 2476), (0, 54.6803, 0));
  _id_9E4E1482CB40C9C5[27] = create_struct((-14228.9, -15620, 1163.5), (0, -154.979, 1.25));
  _id_9E4E1482CB40C9C5[28] = create_struct((4158.13, -43993.5, 176), (0, -14.6602, 0));
  _id_9E4E1482CB40C9C5[29] = create_struct((-3583.35, -24487.2, 4146.05), (0, -119.721, 0));
  _id_9E4E1482CB40C9C5[30] = create_struct((1180.52, -32284.5, 976.25), (0, -168.315, 0.35));
  _id_9E4E1482CB40C9C5[31] = create_struct((-48026.6, 6097.97, 844.851), (0, 77.9464, 0));
  _id_9E4E1482CB40C9C5[32] = create_struct((-25398, -1562.27, 1857.5), (1, 60.2075, -2));
  _id_9E4E1482CB40C9C5[33] = create_struct((8726.56, -45844, 163), (0, 136.397, 0));
  _id_9E4E1482CB40C9C5[34] = create_struct((-5041.36, -16403.4, 4479.42), (0, 87.4744, 0));
  _id_9E4E1482CB40C9C5[35] = create_struct((9676.73, -50696.4, 639.969), (0, -10.5105, 0));
  _id_9E4E1482CB40C9C5[36] = create_struct((-16550, -4060, 958.613), (-0.5, 30, 0));
  _id_9E4E1482CB40C9C5[37] = create_struct((-31625, 5585, 1891), (0, 125, 0));
  _id_9E4E1482CB40C9C5[38] = create_struct((11711.6, -41940.3, 485.582), (0, 1, 0));
  _id_9E4E1482CB40C9C5[39] = create_struct((-8732.49, -5994.88, 1598.15), (0, 80.6329, 0));
  _id_9E4E1482CB40C9C5[40] = create_struct((5434.9, -24162.8, 1326.97), (0, 159.264, 0));
  _id_9E4E1482CB40C9C5[41] = create_struct((-40733.9, 14174.4, -123.5), (2, 125, 2.5));
  _id_9E4E1482CB40C9C5[42] = create_struct((4750, -15650, 3497), (-2.85, -15, 7));
  _id_9E4E1482CB40C9C5[43] = create_struct((18225.7, -50999.2, 871), (-1, -78.7292, 0.5));
  _id_9E4E1482CB40C9C5[44] = create_struct((19025.3, -49611.4, 511.934), (0, -168.3, 0));
  _id_9E4E1482CB40C9C5[45] = create_struct((17782.6, -42117, 920.775), (0, -19.5421, 0));
  _id_9E4E1482CB40C9C5[46] = create_struct((-48377.1, 19041.2, 1217.25), (-0.5, -15.8246, 0));
  _id_9E4E1482CB40C9C5[47] = create_struct((15523.4, 39204.8, 255.938), (0, 76.2923, 0));
  _id_9E4E1482CB40C9C5[48] = create_struct((4538.59, -10057.1, 4543.89), (0, -130.971, 0));
  _id_9E4E1482CB40C9C5[49] = create_struct((21937, -58545.2, 147.88), (0, 119.109, 0));
  _id_9E4E1482CB40C9C5[50] = create_struct((-33235.5, 17573.9, -228), (0, 99.9766, 0.5));
  _id_9E4E1482CB40C9C5[51] = create_struct((-12441.4, 7037.31, 358.622), (0, -20, 0));
  _id_9E4E1482CB40C9C5[52] = create_struct((17315.8, -31542.1, 607), (0, 112.641, 0));
  _id_9E4E1482CB40C9C5[53] = create_struct((-2803.41, -55.0272, 1454.21), (0, 4.76951, 0));
  _id_9E4E1482CB40C9C5[54] = create_struct((-24331.9, 16686, -358.333), (0, 9.05438, 0));
  _id_9E4E1482CB40C9C5[55] = create_struct((-56085.7, 3379.49, 898), (0, -270, 0));
  _id_9E4E1482CB40C9C5[56] = create_struct((17215.6, -22731.1, 1055), (0, 39.6474, 0));
  _id_9E4E1482CB40C9C5[57] = create_struct((-6514.94, 11218.8, 592), (0, 30.8891, 0));
  _id_9E4E1482CB40C9C5[58] = create_struct((-32585, 25134.4, -511.239), (0, -33.0075, 0));
  _id_9E4E1482CB40C9C5[59] = create_struct((-17470.3, 19780.5, -392.649), (0, 20.1298, 0));
  _id_9E4E1482CB40C9C5[60] = create_struct((3548.84, 5114.94, 421.583), (0, 46.6346, 0));
  _id_9E4E1482CB40C9C5[61] = create_struct((14387.1, -6335, 715), (0, -98.2848, 1));
  _id_9E4E1482CB40C9C5[62] = create_struct((-41991.8, 30200.1, 2025.63), (0, -24.9884, 0));
  _id_9E4E1482CB40C9C5[63] = create_struct((22089.9, -13691.4, 2915.06), (0, 58.2134, 0));
  _id_9E4E1482CB40C9C5[64] = create_struct((-11129.3, 21448.3, -299.089), (0, 5.8959, 0));
  _id_9E4E1482CB40C9C5[65] = create_struct((32276.1, -35009.8, 207.74), (0, 77.5266, 0));
  _id_9E4E1482CB40C9C5[66] = create_struct((32336.5, -25973.6, 353.72), (0, 158.697, 0));
  _id_9E4E1482CB40C9C5[67] = create_struct((-7174.08, 52679.2, 239.168), (0, 128.794, 0));
  _id_9E4E1482CB40C9C5[68] = create_struct((-21004, 30769.5, -230.563), (0, 88.2455, 0));
  _id_9E4E1482CB40C9C5[69] = create_struct((-29194.6, 34650.9, -408.432), (0, 15.8698, 0));
  _id_9E4E1482CB40C9C5[70] = create_struct((7755.9, 13451.5, 438.777), (0, -120.067, 0));
  _id_9E4E1482CB40C9C5[71] = create_struct((15528.3, 5994, 212.282), (0, 91.2709, 0));
  _id_9E4E1482CB40C9C5[72] = create_struct((26061.1, -4868, 385), (0, -123.238, 0));
  _id_9E4E1482CB40C9C5[73] = create_struct((31881.8, -13364.7, 499.14), (0, 72.5817, 0));
  _id_9E4E1482CB40C9C5[74] = create_struct((-36472.2, 41051, 703), (1, 2.4043, 0));
  _id_9E4E1482CB40C9C5[75] = create_struct((22581.1, 4025.26, 244.94), (0, 81.3338, 0));
  _id_9E4E1482CB40C9C5[76] = create_struct((-12179.3, 34679.9, 430.319), (0, -152.652, 0));
  _id_9E4E1482CB40C9C5[77] = create_struct((-2243.12, 29566.9, 452.931), (0, 73.1947, 0));
  _id_9E4E1482CB40C9C5[78] = create_struct((44072.7, -33296.6, 207.72), (0, -76.6994, 0));
  _id_9E4E1482CB40C9C5[79] = create_struct((-22731, 41295, -446.5), (-3, -14.0896, 1.5));
  _id_9E4E1482CB40C9C5[80] = create_struct((9585.33, 23570.4, 776), (0, 74.3278, 0));
  _id_9E4E1482CB40C9C5[81] = create_struct((36886.3, -10514.8, 422), (0, -167.128, 0.25));
  _id_9E4E1482CB40C9C5[82] = create_struct((40514, -17488, 531.938), (0, 171.068, 0));
  _id_9E4E1482CB40C9C5[83] = create_struct((-29508.4, 44859, 573.102), (0, -163.57, 0));
  _id_9E4E1482CB40C9C5[84] = create_struct((35569.2, -6698.65, 557.819), (0, -128.877, 0.5));
  _id_9E4E1482CB40C9C5[85] = create_struct((20406.6, 14733.3, 257.426), (0, 12.3956, 0));
  _id_9E4E1482CB40C9C5[86] = create_struct((17904.3, 18536.6, 255.971), (0, -123.106, 0));
  _id_9E4E1482CB40C9C5[87] = create_struct((32405, 1793.53, 270), (0, 77.3216, 0));
  _id_9E4E1482CB40C9C5[88] = create_struct((25169.2, 13338.2, 637.388), (0, -164.852, 0));
  _id_9E4E1482CB40C9C5[89] = create_struct((22150.1, 17121.9, 261.5), (0, 164.697, 0));
  _id_9E4E1482CB40C9C5[90] = create_struct((-11247.3, 42680.1, 185.483), (0, 150.499, 0));
  _id_9E4E1482CB40C9C5[91] = create_struct((21292.6, 20519.8, 247), (0, 152.604, 0));
  _id_9E4E1482CB40C9C5[92] = create_struct((32849.4, 10107.7, 266.698), (0, 59.889, 0));
  _id_9E4E1482CB40C9C5[93] = create_struct((13305.4, 30399.8, 255.938), (0, 171.229, 0));
  _id_9E4E1482CB40C9C5[94] = create_struct((32664.4, 20853.7, 255.999), (0, 48.596, 0));
  _id_9E4E1482CB40C9C5[95] = create_struct((25393.2, 19456.5, 634.75), (0, 19.8145, 0));
  _id_9E4E1482CB40C9C5[96] = create_struct((6079.95, 36144.1, 263.445), (0, 63.2851, 0));
  _id_9E4E1482CB40C9C5[97] = create_struct((39795.8, 1449.49, 576.788), (0, 93.9671, 0));
  _id_9E4E1482CB40C9C5[98] = create_struct((28879.8, 16442.7, 256.799), (0, -160.889, 0.25));
  _id_9E4E1482CB40C9C5[99] = create_struct((45838.8, -8697.28, 759.432), (0.75, 44.0235, -0.25));
  _id_9E4E1482CB40C9C5[100] = create_struct((-457.835, 43987.8, 471), (0, 55.4758, 0));
  _id_9E4E1482CB40C9C5[101] = create_struct((-13222.4, 50413.4, 193.269), (0, 161.088, 0));
  _id_9E4E1482CB40C9C5[102] = create_struct((-18302.3, 53837.7, 393.263), (0, 167.93, 0));
  _id_9E4E1482CB40C9C5[103] = create_struct((-835.436, 19340, 444.436), (0, 69.0097, -0.25));
  _id_9E4E1482CB40C9C5[104] = create_struct((-19762.7, 8838, 883.25), (0, -170, 3.75));
  _id_9E4E1482CB40C9C5[105] = create_struct((-60338.7, -16083.2, 320), (0, 68.301, 0));
  return _id_9E4E1482CB40C9C5;
}

_id_DEF43D85B603EF19() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((-7620.78, -11682.3, 366.837), (0, -33.1582, 0));
  _id_9E4E1482CB40C9C5[1] = create_struct((-6996.9, 705.593, 514.562), (0, 75.9253, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((6241.23, -472.799, 466.366), (0, 120.736, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((2706.98, 8944.64, 386.568), (0, -67.1093, 0));
  return _id_9E4E1482CB40C9C5;
}

_id_C5C3D7914A4DF89A() {
  _id_9E4E1482CB40C9C5 = [];
  _id_9E4E1482CB40C9C5[0] = create_struct((13718.9, 247.214, 995), (0, 17, 0));
  _id_9E4E1482CB40C9C5[1] = create_struct((1692, 8271, 528), (0, 17, 0));
  _id_9E4E1482CB40C9C5[2] = create_struct((-11467.4, -6998.01, 420), (0, 74, 0));
  _id_9E4E1482CB40C9C5[3] = create_struct((14007.6, -5067.2, 947.8), (0, -112.29, 0));
  return _id_9E4E1482CB40C9C5;
}

create_struct(org, _id_8BC14603A27FA3E7, _id_252267264F5269FE) {
  struct = spawnStruct();
  struct.origin = org;
  struct.angles = _id_8BC14603A27FA3E7;
  return struct;
}