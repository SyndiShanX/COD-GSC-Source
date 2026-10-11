/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_ending.gsc
*************************************************/

#using script_15eddb0fac236a22;
#using script_58321be04dca3e61;
#using script_62c595d55b88b26;
#using script_72d25fb2b703b6d5;
#using script_7e6380fafedd5f32;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\gametypes\br_ending_chopper;
#using scripts\mp\gametypes\br_ending_chopper2;
#using scripts\mp\gametypes\br_ending_chopper_to_hq;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\killstreaks\remoteuav;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_ending;

function br_ending_init() {
  if(!mode_can_play_ending(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5()) || getdvarint(@ "hash_3939d9bfb2b1103e", 0)) {
    return;
  }

  setdvarifuninitialized(@ "hash_70411185c4a8bf09", 1);

  setdvarifuninitialized(@ "hash_dd3266b5409a856b", 0);
  setdvarifuninitialized(@ "hash_19a406e3c51ce52f", 0);
  setdvarifuninitialized(@ "hash_2d200a3da7fb2518", 0);
  setdvarifuninitialized(@ "hash_85485bbe1bfbee98", 0);
  setdvarifuninitialized(@ "hash_5be228e043cb645a", 0);

  for(i = 0; i < 6; i++) {
    setdvarifuninitialized(hashcat(@ "hash_e340a5ee5afde790", string(i)), "<dev string:x1c>");
  }

  namespace_ab7fb53f62c7ae2e::accolades_init();
  var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();

  if(scripts\engine\utility::issharedfuncdefined("br_ending_" + var_a6b3fae0395f75c3, "exfil_init")) {
    [[scripts\engine\utility::getsharedfunc("br_ending_" + var_a6b3fae0395f75c3, "exfil_init")]]();
  } else {
    switch (var_a6b3fae0395f75c3) {
      case #"hash_db5ea3d88af86493":
        namespace_e62527f32363042f::function_e04bd99e1bb6430b();
        break;
      case #"hash_d9cfbe7fb5447f0e":
        scripts\mp\gametypes\br_ending_chopper2::function_e04bd99e1bb6430b();
        break;
      case #"hash_18208461fac4f35e":
      case #"hash_ce37a6540166b6f7":
        scripts\mp\gametypes\br_ending_chopper_to_hq::chopperhqexfil_init();
        break;
      case #"hash_1136bc3322c0a548":
      default:
        scripts\mp\gametypes\br_ending_chopper::function_e04bd99e1bb6430b();
        break;
    }
  }

  thread function_87f45430d8de267a();

  thread namespace_db13b5d5ab9bfe9c::function_9dd3d565e1ba2f03();
}

function function_43043ce856efd41b(player) {
  if(isDefined(level.var_fa77ea41af520470)) {
    player visionsetnakedforplayer(level.var_fa77ea41af520470, 0);
    return;
  }

  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_aeddd44c5b27b2d":
    case #"hash_bce1a7274538a78":
    case #"hash_3ebe34631513de1d":
    case #"hash_73e90c896fdaebc3":
      player visionsetnakedforplayer("", 0);
      break;
    default:
      player visionsetnakedforplayer("", 0);
      break;
  }
}

function can_play_ending() {
  if(!getdvarint(@ "hash_70411185c4a8bf09")) {
    return false;
  }

  if(!mode_can_play_ending(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5())) {
    return false;
  }

  if(istrue(level.br_skipending)) {
    return false;
  }

  return true;
}

function mode_can_play_ending(mode) {
  switch (mode) {
    case #"hash_a3f25a001a121f":
    case #"hash_16dd223e5a8b22c8":
    case #"hash_3c1c1566d7b3b870":
    case #"hash_4ce2691f06f171fc":
    case #"hash_5528f0c789755eb1":
    case #"hash_5549fae4e940416f":
    case #"hash_5e0a8ff36bce5106":
    case #"hash_7aeaa0d2fcc06674":
    case #"hash_8299694594ab149d":
    case #"hash_83058a20a2b7cb50":
    case #"hash_9196025f8ae8e51e":
    case #"hash_9e2cf91683f94012":
    case #"hash_bfabc434c59611fa":
    case #"hash_c79893a20318a9c2":
    case #"":
    case #"hash_d542616c7a17d00d":
    case #"hash_dddecc2751311914":
    case #"hash_fa21c4f6bd5e3815":
      return 1;
    default:
      return 0;
  }
}

function play_ending(winners, var_cbfc3ba10cefc8ce) {
  if(!can_play_ending()) {
    return;
  }

  level endon("endingSceneStop");

  foreach(player in level.players) {
    if(player isskydiving()) {
      player skydive_interrupt();
      player skydive_setbasejumpingstatus(0);
      player giveperk("specialty_falldamage");
    }
  }

  winners = array_removeundefined(winners);
  winners = array_sort_with_func(winners, &compare_higher_score);
  function_e50b941afd09e62e(winners);
  level notify("br_ending_start", winners);
  level.brdisablefinalkillcam = 1;

  winners = namespace_db13b5d5ab9bfe9c::function_38b44913b9bec05f(winners);

  if(!isDefined(level.var_285f57f09913c9e6)) {
    level.var_285f57f09913c9e6 = winners.size;
  }

  var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();
  var_bf0495a4761c14d0 = function_b5e265cde17f09d1(var_a6b3fae0395f75c3);
  animstruct = create_exfil_animstruct(var_a6b3fae0395f75c3, winners, var_cbfc3ba10cefc8ce, var_bf0495a4761c14d0);
  animstruct set_ending_pack(var_a6b3fae0395f75c3, var_cbfc3ba10cefc8ce);

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    foreach(player in winners) {
      player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("exfilStart")) {
    thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("exfilStart", winners);
  }

  winners = undefined;
  level.br_ending = animstruct;
  println("<dev string:x20>");

  if(var_bf0495a4761c14d0) {
    ending_viewing_players_setup(animstruct);
    ending_winning_players_setup(animstruct);
    clear_vehicles(animstruct.origin, 1000);
    clear_outlines();
    setomnvar("scriptable_loot_hide", 1);
    animstruct function_84068c30364b89cb();
  } else {
    ending_viewing_players_setup(animstruct);
    player_rigs = ending_winning_players_setup(animstruct);
    clear_vehicles(animstruct.origin, 1000);
    clear_outlines();
    setomnvar("scriptable_loot_hide", 1);
    animstruct anim_first_frame_solo(animstruct.cam, animstruct.packs[0].anime);

    foreach(player in level.players) {
      if(getdvarint(@ "hash_dd3266b5409a856b") && player ishost()) {
        continue;
      }

      player cameralinkTo(animstruct.cam, "tag_player", 1, 1);
    }

    foreach(pack in animstruct.packs) {
      println("<dev string:x58>" + pack.anime + "<dev string:x6b>");

      if(istrue(pack.var_52738e0a99ed242b)) {
        foundvalidplayer = 0;

        foreach(player in pack.players) {
          if(isDefined(player) && isPlayer(player) && isDefined(level.scr_anim[player.animname][pack.anime])) {
            foundvalidplayer = 1;
            break;
          }
        }

        if(!foundvalidplayer) {
          continue;
        }
      }

      if(isDefined(pack.startfunc)) {
        animstruct[[pack.startfunc]](pack.paramarray);
      }

      if(isDefined(pack.fov)) {
        allplayers_setfov(pack.fov);
      } else {
        function_cf47ab3f9defe35b();
      }

      if(isDefined(pack.fstop) && isDefined(pack.focusdist)) {
        allplayers_setphysicaldof(pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint);
      }

      if(isDefined(pack.playerfunc)) {
        foreach(player in level.players) {
          [[pack.playerfunc]](player, pack.var_5ab13b55d7ceff80);
        }
      }

      if(isDefined(pack.fx)) {
        playFX(getfx(pack.fx), pack.fxorigin, anglesToForward(pack.fxangles), anglestoup(pack.fxangles));
      }

      if(pack.players.size > 0) {
        pack.players = array_removeundefined(pack.players);

        foreach(player in pack.players) {
          player dontinterpolate();

          if(isDefined(player.linkedtoent)) {
            if(!isPlayer(player)) {
              if(getdvarint(@ "hash_bc95d8892007ebfd", 1) && isDefined(player.player_rig.avatar)) {
                avatar = player.player_rig.avatar;
                avatar scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[avatar.animname][pack.anime], animstruct.origin, animstruct.angles, avatar.animname);
                avatar thread scripts\common\notetrack::start_notetrack_wait(avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[avatar.animname][pack.anime]);
              } else {
                player.linkedtoent thread anim_single_solo(player.player_rig, pack.anime, player.linkedtotag);
              }
            } else {
              player.linkedtoent thread anim_player_solo(player, player.player_rig, pack.anime, player.linkedtotag);
            }

            continue;
          }

          if(!isPlayer(player)) {
            if(getdvarint(@ "hash_bc95d8892007ebfd", 1) && isDefined(player.player_rig.avatar)) {
              avatar = player.player_rig.avatar;
              avatar scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[avatar.animname][pack.anime], animstruct.origin, animstruct.angles, avatar.animname);
              avatar thread scripts\common\notetrack::start_notetrack_wait(avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[avatar.animname][pack.anime]);
            } else {
              animstruct thread anim_single_solo(player.player_rig, pack.anime);
            }

            continue;
          }

          animstruct thread anim_player_solo(player, player.player_rig, pack.anime);
        }

        if(isDefined(animstruct.player_rigs)) {
          if(getdvarint(@ "hash_bc95d8892007ebfd", 1)) {
            foreach(rig in animstruct.player_rigs) {
              if(isDefined(rig.avatar) && isDefined(level.scr_anim[rig.avatar.animname][pack.anime])) {
                avatar = rig.avatar;
                avatar scriptmodelplayanimdeltamotionfrompos(level.scr_eventanim[avatar.animname][pack.anime], animstruct.origin, animstruct.angles, avatar.animname);
                avatar thread scripts\common\notetrack::start_notetrack_wait(avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[avatar.animname][pack.anime]);
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
                rig.linkedtoent thread anim_single_solo(rig, pack.anime, rig.linkedtotag);
                continue;
              }

              animstruct thread anim_single_solo(rig, pack.anime);
            }
          }
        }
      }

      if(pack.ents.size > 0) {
        foreach(ent in pack.ents) {
          if(!istrue(ent.dontteleport)) {
            ent dontinterpolate();
          }
        }

        animstruct thread anim_single(pack.ents, pack.anime);
      }

      foreach(rig in pack.lightingrigs) {
        linkedtag = ter_op(isDefined(level.var_556c00d8ea5240b9), level.var_556c00d8ea5240b9, "tag_origin");

        foreach(probe in rig.probes) {
          origin_offset = probe.origin_offset;
          angles_offset = probe.angles_offset;

          if(!isDefined(angles_offset)) {
            angles_offset = (0, 0, 0);
          }

          probe show();
          probe linkTo(rig.linkent, linkedtag, origin_offset, angles_offset);
        }

        foreach(light in rig.lights) {
          if(isDefined(light.override_intensity)) {
            light setlightintensity(light.override_intensity);
          } else if(isDefined(light.original_intensity)) {
            light setlightintensity(light.original_intensity);
          }

          origin_offset = light.origin_offset;
          angles_offset = light.angles_offset;

          if(!isDefined(angles_offset)) {
            angles_offset = (0, 0, 0);
          }

          light linkTo(rig.linkent, linkedtag, origin_offset, angles_offset);
        }
      }

      animstruct thread faderunner(pack);

      if(isDefined(pack.xcamasset)) {
        animstruct.cam dontinterpolate();
        animstruct thread anim_single_solo(animstruct.cam, pack.anime);

        foreach(player in level.players) {
          player cameraunlink();

          if(getdvarint(@ "hash_dd3266b5409a856b") && player ishost()) {
            continue;
          }

          player playxcam(pack.xcamasset, 0, animstruct.origin, animstruct.angles, undefined, undefined, level.var_319696a4503e0e48);
        }

        xcamlength = getxcamlength(pack.xcamasset);
        xcamlength -= 0.033;
        xcamlength -= mod(xcamlength, 0.05);
        level waittill_notify_or_timeout("br_ending_skip_scene", xcamlength);
      } else {
        foreach(player in level.players) {
          player stopxcam();

          if(getdvarint(@ "hash_dd3266b5409a856b") && player ishost()) {
            continue;
          }

          player cameralinkTo(animstruct.cam, "tag_player", 1, 1);
        }

        animstruct.cam dontinterpolate();
        animstruct thread anim_single_solo(animstruct.cam, pack.anime);
        waittill_any_ents(animstruct, pack.anime, level, "br_ending_skip_scene");
      }

      waitframe();

      if(isDefined(pack.endfunc)) {
        animstruct[[pack.endfunc]](pack.var_315361abd838fad4);
      }
    }

    wait 1;
  }

  cleanup_ending(level.br_ending);

  if(isDefined(level.var_5cff8f177104dea5) && isfunction(level.var_5cff8f177104dea5)) {
    level[[level.var_5cff8f177104dea5]](level.br_ending);
  }
}

function function_84068c30364b89cb() {
  var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();

  if(scripts\engine\utility::issharedfuncdefined("br_ending_" + var_a6b3fae0395f75c3, "exfil_play")) {
    [[scripts\engine\utility::getsharedfunc("br_ending_" + var_a6b3fae0395f75c3, "exfil_play")]]();
    return;
  }

  switch (var_a6b3fae0395f75c3) {
    case #"hash_18208461fac4f35e":
      scripts\mp\gametypes\br_ending_chopper_to_hq::function_5396a4248f68364();
      break;
    case #"hash_ce37a6540166b6f7":
      namespace_91542927cd719085::function_bb2daf72d16fc6a7();
    default:
      break;
  }
}

function cleanup_ending(animstruct) {
  if(isDefined(animstruct)) {
    if(!istrue(animstruct.var_bf0495a4761c14d0)) {
      foreach(pack in animstruct.packs) {
        foreach(ent in pack.ents) {
          if(isDefined(ent)) {
            if(isDefined(ent.linkedents)) {
              array_delete(ent.linkedents);
            }

            ent delete();
          }
        }

        foreach(player in pack.players) {
          if(isDefined(player) && istrue(player.isdisconnectplayer)) {
            assert(!isPlayer(player));

            if(isDefined(player.player_rig)) {
              if(isDefined(player.player_rig.avatar)) {
                if(isDefined(player.player_rig.avatar.weaponent)) {
                  player.player_rig.avatar.weaponent delete();
                }

                player.player_rig.avatar delete();
              }

              player.player_rig delete();
            }

            player delete();
          }
        }
      }
    }

    if(isDefined(animstruct.cam)) {
      animstruct.cam delete();
    }

    animstruct stopfaderunner();
  }

  function_cf47ab3f9defe35b();
  allplayers_clearphysicaldof();

  foreach(player in level.players) {
    if(isDefined(player)) {
      player visionsetnakedforplayer("", 1);

      if(isDefined(player.sessionstate) && player.sessionstate == "spectator") {
        player setspectatedefaults(animstruct.origin, animstruct.angles);
      } else {
        player setOrigin(animstruct.origin);
      }

      if(isDefined(player.player_rig)) {
        if(isDefined(player.player_rig.avatar)) {
          if(isDefined(player.player_rig.avatar.weaponent)) {
            player.player_rig.avatar.weaponent delete();
          }

          player.player_rig.avatar delete();
        }

        player.player_rig delete();
      }
    }
  }

  if(!istrue(animstruct.var_bf0495a4761c14d0)) {
    foreach(rig in animstruct.player_rigs) {
      if(!isDefined(rig)) {
        continue;
      }

      if(isDefined(rig.avatar)) {
        if(isDefined(rig.avatar.weaponent)) {
          rig.avatar.weaponent delete();
        }

        rig.avatar delete();
      }

      rig delete();
    }
  }
}

function stopfaderunner() {
  self notify("stopFadeRunner");

  if(isDefined(self.fadeoverlay)) {
    self.fadeoverlay destroy();
  }
}

function faderunner(pack) {
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

  if(!isDefined(pack.fadeinlength) && !isDefined(pack.fadeoutlength)) {
    self.fadeoverlay.alpha = 0;
    return;
  }

  if(isDefined(pack.fadeinlength)) {
    self.fadeoverlay.alpha = 1;
    self.fadeoverlay fadeovertime(pack.fadeinlength);
    self.fadeoverlay.alpha = 0;
    wait pack.fadeinlength;
  }

  if(isDefined(pack.fadeoutlength)) {
    packlength = undefined;

    if(isDefined(pack.xcamasset)) {
      xcamlength = getxcamlength(pack.xcamasset);
      xcamlength -= 0.033;
      xcamlength -= mod(xcamlength, 0.05);
      packlength = xcamlength;
    } else {
      animref = level.scr_anim["endingCam"][pack.anime];
      animlength = getanimlength(animref);
      packlength = animlength;
    }

    if(isDefined(pack.fadeinlength)) {
      packlength -= pack.fadeinlength;
    }

    wait packlength - pack.fadeoutlength;
    self.fadeoverlay.alpha = 0;
    self.fadeoverlay fadeovertime(pack.fadeoutlength);
    self.fadeoverlay.alpha = 1;
  }
}

function compare_higher_score(player1, player2) {
  return player1.pers["score"] > player2.pers["score"];
}

function function_4b3d6ad67eba0f73(team1, team2) {
  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("compareTeamHigherScore")) {
    return scripts\mp\gametypes\br_gametypes::runbrgametypefunc("compareTeamHigherScore", team1, team2);
  }

  team1players = array_removeundefined(scripts\mp\utility\teams::getteamdata(team1, "alivePlayers"));
  team1score = 0;

  foreach(player in team1players) {
    team1score += player.pers["score"];
  }

  team2players = array_removeundefined(scripts\mp\utility\teams::getteamdata(team2, "alivePlayers"));
  team2score = 0;

  foreach(player in team2players) {
    team2score += player.pers["score"];
  }

  return team1score > team2score;
}

function temp_debug_wait_and_stop_music_loop() {
  wait 25;

  foreach(player in level.players) {
    player setplayermusicstate("");
  }
}

function ending_viewing_players_setup(animstruct) {
  level.brspawnplayersending = 1;
  level notify("brSpawnPlayersEnding");

  foreach(player in level.players) {
    function_43043ce856efd41b(player);

    if(getdvarint(@ "hash_dd3266b5409a856b") && player ishost()) {
      continue;
    }

    player function_b88c89bb7cd1ab8e(animstruct.origin);
    player utility::hidehudenable();
    player setcinematicmotionoverride("disabled");
    player setclientomnvar("ui_br_squad_eliminated_active", 0);

    if(isDefined(player.sessionstate)) {
      if((player.team == "spectator" || player.team == "codcaster") && !getdvarint(@ "hash_cf7e9f3447526b4d", 0)) {
        continue;
      }

      if(player.sessionstate == "intermission") {
        player updatesessionstate("spectator");
      }

      if(player.sessionstate == "spectator") {
        if(istrue(animstruct.var_bf0495a4761c14d0)) {
          player setspectatedefaults(animstruct.origin, animstruct.angles);
          player spawn(animstruct.origin, animstruct.angles);
        } else {
          player setspectatedefaults(animstruct.cam.origin, animstruct.cam.angles);
          player spawn(animstruct.cam.origin, animstruct.cam.angles);
        }

        continue;
      }

      player player_equipment_use_stop();
      player player_abilities_disable();
      player setOrigin(animstruct.origin + (0, 0, 100));
    }
  }
}

function ending_winning_players_setup(animstruct) {
  players = animstruct.winners;
  spawnorigin = undefined;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(istrue(level.var_ee1ed2411d6c889)) {
      player.var_1de5f8a93d593b45 = [];

      if(isDefined(player getcurrentweapon())) {
        player.var_1de5f8a93d593b45 = function_6d6af8144a5131f1(player.var_1de5f8a93d593b45, player getcurrentweapon());
      }

      if(isDefined(player.primaryweaponobj)) {
        player.var_1de5f8a93d593b45 = function_6d6af8144a5131f1(player.var_1de5f8a93d593b45, player.primaryweaponobj);
      }

      if(isDefined(player.secondaryweaponobj)) {
        player.var_1de5f8a93d593b45 = function_6d6af8144a5131f1(player.var_1de5f8a93d593b45, player.secondaryweaponobj);
      }
    }

    if(isDefined(player.sessionstate) && player.sessionstate == "playing") {
      spawnorigin = player.origin;
      break;
    }
  }

  player_rigs = [];
  ui_num = 0;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if((player.team == "spectator" || player.team == "codcaster") && !getdvarint(@ "hash_cf7e9f3447526b4d", 0)) {
      continue;
    }

    if(isDefined(player.sessionstate) && player.sessionstate != "playing") {
      player.forcespawnorigin = spawnorigin;
      player.alreadyaddedtoalivecount = 1;
      player scripts\mp\playerlogic::spawnplayer(0);

      if(!isDefined(player)) {
        continue;
      }

      player utility::hidehudenable();
    }

    player player_equipment_use_stop();
    player player_abilities_disable();
    player.plotarmor = 1;
    player.oobimmunity = 1;
    player.linkedtoent = undefined;
    player.linkedtotag = undefined;
    player.winindex = ui_num;
    ui_num++;

    if(!isDefined(player.animname) || player.animname != player.brexfilanimname) {
      player.animname = player.brexfilanimname;
    }

    if(getdvarint(@ "hash_5be228e043cb645a", 0) == 0) {
      player thread player_set_weapon();
    } else {
      player player_set_weapon();
    }

    if(istrue(animstruct.var_bf0495a4761c14d0)) {
      continue;
    }

    if(getdvarint(@ "hash_dd3266b5409a856b") && player ishost()) {
      continue;
    }

    player create_player_rig(player.animname, "viewhands_base_iw8", animstruct);

    if(getdvarint(@ "hash_bc95d8892007ebfd", 1)) {
      player function_50962e9f971266e(player.animname, animstruct.origin);
    }

    level thread ending_player_disconnect_thread(player);
    player_rigs[player_rigs.size] = player.player_rig;
  }

  return player_rigs;
}

function function_e50b941afd09e62e(winnerplayers) {
  if(!isDefined(winnerplayers)) {
    return;
  }

  winnerplayers = array_removeundefined(winnerplayers);
  winnerplayers = array_sort_with_func(winnerplayers, &compare_higher_score);
  function_b716ee9a63b63254("winners", winnerplayers);
  level.var_285f57f09913c9e6 = winnerplayers.size;
}

function function_226b83f846d32ff2(winnerplayers) {
  if(!isDefined(winnerplayers)) {
    return;
  }

  winnerplayers = array_removeundefined(winnerplayers);
  winnerplayers = array_sort_with_func(winnerplayers, &compare_higher_score);
  accolades = [];

  foreach(winner in winnerplayers) {
    if(!isDefined(winner.var_ae06891211af23ba)) {
      continue;
    }

    var_caa2afb2cdcb7815 = level.var_e3fca817c22e740d[winner.var_ae06891211af23ba];

    if(isDefined(winner.var_f090ccb984435bbc)) {
      var_caa2afb2cdcb7815 = level.var_e3fca817c22e740d[winner.var_f090ccb984435bbc];
    }

    assert(isDefined(var_caa2afb2cdcb7815));
    accolades = array_add(accolades, var_caa2afb2cdcb7815);
  }

  function_b716ee9a63b63254("accolades", accolades);
}

function player_equipment_use_stop() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self.vehicle);
  }

  if(scripts\cp_mp\vehicles\vehicle::function_a164fb69837475d5()) {
    scripts\cp_mp\vehicles\vehicle::exitexternalturret();
  }

  if(self isonascender()) {
    scripts\mp\gametypes\br_utility::function_fd357ca89e5e29d9();
  }

  if(isDefined(self.remoteuav)) {
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();
  }

  if(isDefined(self.currentturret)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);
  }

  if(isDefined(self.usingremote)) {
    vehicles = vehicle_getarray();

    foreach(vehicle in vehicles) {
      if(isDefined(vehicle.owner) && vehicle.owner == self) {
        if(isDefined(vehicle.helperdronetype)) {
          vehicle scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(1);
        }
      }
    }
  }
}

function player_abilities_disable() {
  if(!isPlayer(self)) {
    return;
  }

  _freezecontrols(1, undefined, "brEnding");
  val::set("brEnding", "offhand_weapons", 0);
  val::set("brEnding", "melee", 0);
  val::set("brEnding", "ads", 0);
  val::set("brEnding", "fire", 0);
  val::set("brEnding", "weapon_switch", 0);
  val::set("brEnding", "vehicle_use", 0);
  self skydive_interrupt();
}

function player_abilities_enable() {
  if(!isPlayer(self)) {
    return;
  }

  _freezecontrols(0, undefined, "brEnding");
  val::reset_all("brEnding");
}

function player_set_weapon() {
  switchweapon = undefined;

  if(istrue(level.var_ee1ed2411d6c889) && isDefined(self.var_1de5f8a93d593b45) && self.var_1de5f8a93d593b45.size > 0 && isDefined(level.var_d3378a0c330f9718)) {
    weapons = self.var_1de5f8a93d593b45;
    self clearaccessory();
    self takeallweapons();
    waitframe();

    foreach(weapon in weapons) {
      if(isnullweapon(weapon)) {
        continue;
      }

      if(!array_contains(level.var_d3378a0c330f9718, weapon.classname) || weapontype(weapon) == "riotshield") {
        continue;
      }

      if(istrue(weapon.ismelee)) {
        continue;
      }

      if(!isDefined(switchweapon)) {
        switchweapon = weapon;
      }
    }

    if(!isDefined(switchweapon)) {
      var_27dbaca9c38b6a69 = scripts\cp_mp\weapon::buildweapon("iw9_pi_golf17_mp");
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_27dbaca9c38b6a69);
      switchweapon = var_27dbaca9c38b6a69;
    }
  } else {
    weapons = self getweaponslistprimaries();
    currentweapon = self getcurrentweapon();
    weapons = array_combine_unique([currentweapon], weapons);

    foreach(weapon in weapons) {
      if(isDefined(level.var_d3378a0c330f9718)) {
        if(!array_contains(level.var_d3378a0c330f9718, weapon.classname) || weapontype(weapon) == "riotshield") {
          continue;
        }
      } else if(weapon.classname != "rifle" || scripts\mp\utility\weapon::issuperweapon(weapon)) {
        continue;
      }

      if(istrue(weapon.ismelee)) {
        continue;
      }

      switchweapon = weapon;

      if(isDefined(switchweapon)) {
        break;
      }
    }

    if(!isnullweapon(self.currentweapon)) {
      self clearaccessory();
      self takeallweapons();
    } else {
      waitframe();
    }

    if(!isDefined(switchweapon)) {
      switchweapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4", [], "none", "none");
    }
  }

  _giveweapon(switchweapon, undefined, undefined, 1);
  self.pers["primaryWeapon"] = getcompleteweaponname(switchweapon);
  self.primaryweapon = getcompleteweaponname(switchweapon);
  self.primaryweaponobj = switchweapon;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;
  self.var_441f016a57e14480 = switchweapon;
  namespace_6b49ddb858f34366::function_adcb155953291ec7(undefined, 1);

  if(isDefined(self.executionref)) {
    scripts\cp_mp\execution::_giveexecution(self.executionref);
  }

  if(self getweaponammoclip(switchweapon) < 5) {
    self setweaponammoclip(switchweapon, 5);
  }

  switched = self switchtoweaponimmediate(switchweapon);
}

function function_9afbee75cfe14b8d() {
  type = getDvar(@ "hash_d3806641b576ad90", "chopper_to_hq");

  if(isDefined(level.var_d81f9416f44ab4ba)) {
    type = level.var_d81f9416f44ab4ba.var_747d19faf68a7748;
  }

  return type;
}

function function_b5e265cde17f09d1(type) {
  switch (type) {
    case #"hash_18208461fac4f35e":
    case #"hash_8e482dd76314929c":
    case #"hash_ce37a6540166b6f7":
      return 1;
    default:
      return 0;
  }
}

function set_ending_pack(type, var_cbfc3ba10cefc8ce) {
  if(scripts\engine\utility::issharedfuncdefined("br_ending_" + type, "exfil_pack")) {
    self[[scripts\engine\utility::getsharedfunc("br_ending_" + type, "exfil_pack")]](var_cbfc3ba10cefc8ce);
    return;
  }

  switch (type) {
    case #"hash_db5ea3d88af86493":
      namespace_e62527f32363042f::chopperexfil_pack(var_cbfc3ba10cefc8ce);
      break;
    case #"hash_d9cfbe7fb5447f0e":
      scripts\mp\gametypes\br_ending_chopper2::chopperexfil_pack(var_cbfc3ba10cefc8ce);
      break;
    case #"hash_18208461fac4f35e":
      scripts\mp\gametypes\br_ending_chopper_to_hq::function_c0c06942d2085413(var_cbfc3ba10cefc8ce);
      break;
    case #"hash_ce37a6540166b6f7":
      namespace_91542927cd719085::function_ffa68c72485da6cc(var_cbfc3ba10cefc8ce);
      break;
    case #"hash_1136bc3322c0a548":
    default:
      scripts\mp\gametypes\br_ending_chopper::chopperexfil_pack(var_cbfc3ba10cefc8ce);
      break;
  }
}

function create_exfil_animstruct(var_a6b3fae0395f75c3, winners, var_cbfc3ba10cefc8ce, var_bf0495a4761c14d0) {
  struct = get_ending_struct(var_a6b3fae0395f75c3, winners, var_cbfc3ba10cefc8ce);
  struct.var_bf0495a4761c14d0 = var_bf0495a4761c14d0;

  if(isDefined(var_cbfc3ba10cefc8ce)) {
    println("<dev string:x95>" + struct.origin + "<dev string:xb2>" + distance(var_cbfc3ba10cefc8ce, struct.origin));
    println("<dev string:xd2>" + var_cbfc3ba10cefc8ce);
  }

  struct.winners = winners;

  if(!istrue(var_bf0495a4761c14d0)) {
    struct.cam = struct create_cam();
  }

  return struct;
}

function function_87f45430d8de267a() {
  waittillframeend();
  level.var_e4a685c0a836454 = function_bd87576b75af246();
  level.var_d3bb2db354fa9099 = [];
  level.var_d3bb2db354fa9099["cq_nuke"] = function_74fb520cb28210ad();
}

function function_bd87576b75af246() {
  if(level.script == "mp_br_mechanics" || level.script == "mp_jup_br_mechanics") {
    return getStructArray("br_ending_spot", "targetname");
  }

  if(level.script == "mp_mgl_ftue_downtown") {
    return function_50c9687cccd76c7f();
  }

  if(level.script == "mp_br_quarry") {
    return mp_br_quarry_locations();
  }

  if(level.script == "mp_escape2") {
    return function_35c3e71a666e6cb2();
  }

  if(level.script == "mp_escape3") {
    return function_35c3e71a666e6cb2();
  }

  if(level.script == "mp_mgl_escape4") {
    return function_bce27e24255486f0();
  }

  if(level.script == "mp_jup_escape5" || level.script == "mp_jup_escape5_hell") {
    return function_adb0a839c433d47();
  }

  if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
    return function_d076db51878a786b();
  }

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    return function_def43d85b603ef19();
  }

  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    return mp_donetsk_locations();
  }

  if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    return function_c5c3d7914a4df89a();
  }

  if(scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    return mp_jup_bigmap_locations();
  }

  if(scripts\cp_mp\utility\game_utility::function_314ff105a27cc131()) {
    return function_2727828d27cbdf05();
  }

  return [];
}

function function_74fb520cb28210ad() {
  if(scripts\cp_mp\utility\game_utility::function_eb4bce9b222e36ac()) {
    return function_5e3eb8b4dd5708d5();
  }

  return [];
}

function get_ending_struct(var_a6b3fae0395f75c3, players, var_cbfc3ba10cefc8ce) {
  players = array_removeundefined(players);

  if(players.size > 0) {
    origin = get_center_of_array(players);
  } else {
    origin = var_cbfc3ba10cefc8ce;
  }

  endingstructs = function_2979939f678d3ad1(var_a6b3fae0395f75c3);
  structs = sortbydistance(endingstructs, origin);

  if(!isDefined(structs[0].angles)) {
    structs[0].angles = (0, 0, 0);
  }

  return structs[0];
}

function function_2979939f678d3ad1(var_a6b3fae0395f75c3) {
  if(isDefined(level.var_d3bb2db354fa9099[var_a6b3fae0395f75c3]) && level.var_d3bb2db354fa9099[var_a6b3fae0395f75c3].size > 0) {
    return level.var_d3bb2db354fa9099[var_a6b3fae0395f75c3];
  }

  return level.var_e4a685c0a836454;
}

function clear_vehicles(origin, radius) {
  vehicles = vehicle_getarrayinradius(origin, radius, 20000);

  foreach(vehicle in vehicles) {
    if(!istrue(vehicle.endingvehicle)) {
      vehicle delete();
    }
  }
}

function clear_outlines() {
  foreach(player in level.br_ending.winners) {
    if(isDefined(player.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(player.laststandoutlineid, player);
      player.laststandoutlineid = undefined;
    }
  }
}

function mp_donetsk_locations() {
  structs = [];
  structs[0] = create_struct((-35516, -26964, -290.492), (0, -37.2493, 0), 1);
  structs[1] = create_struct((-24507.4, -31751.5, -118), (0, 24.7373, 0));
  structs[2] = create_struct((-18475.3, -38031.3, 1390), (0, 21.3294, 0));
  structs[3] = create_struct((-22962.6, -26693.8, -133.431), (0, -79.9927, 0), 1);
  structs[4] = create_struct((-21665.5, -27275.8, -148.989), (0, -36.6941, 0), 1);
  structs[5] = create_struct((-21726, -25961.2, -146), (0, -108.126, 0), 1);
  structs[6] = create_struct((-12285.8, -40588.5, 518.07), (0, -148.112, 0), 1);
  structs[7] = create_struct((-36409.6, -14177.9, -286.708), (0, -15.7255, 0), 1);
  structs[8] = create_struct((-30525.8, -17654.2, -234.947), (0, -127.959, 0), 1);
  structs[9] = create_struct((-17170.3, -31131.8, 264.201), (0, -174.161, 0), 1);
  structs[10] = create_struct((-28797.3, -17400, -241.606), (0, 16.8587, 0));
  structs[11] = create_struct((-18155.4, -27275.3, -224.811), (0, -121.999, 0), 1);
  structs[12] = create_struct((-9975.39, -38284.4, 344.1), (0, -46.4665, 0), 1);
  structs[13] = create_struct((-29281.2, -13754.2, -145.391), (0, -11.8112, 0));
  structs[14] = create_struct((-17821.6, -23448.4, -262), (0, 62.3774, 0), 1);
  structs[15] = create_struct((-18619.8, -20889.8, -257.189), (0, -71.9892, 0), 1);
  structs[16] = create_struct((-14480.9, -25405.9, -288.831), (0, 154.786, 0), 1);
  structs[17] = create_struct((-9256.33, -33580.9, 158.984), (0, 146.051, 0), 1);
  structs[18] = create_struct((-8492.02, -34971.8, 166.312), (0, 161.494, 0), 1);
  structs[19] = create_struct((-16599, -22468.6, -278.939), (0, 154.273, 0), 1);
  structs[20] = create_struct((-11999.8, -28038.4, -31.998), (0, 5.45263, 0), 1);
  structs[21] = create_struct((-32056.9, -9169.36, -306.919), (0, 71.9528, 0));
  structs[22] = create_struct((-23530.6, -14806.7, -69.1128), (0, -153.028, 0), 1);
  structs[23] = create_struct((-27480.3, -10672.5, -69.3776), (0, -3.16859, 0), 1);
  structs[24] = create_struct((-4660.23, -38889.8, 608.219), (0, 63.5175, 0), 1);
  structs[25] = create_struct((-10475.2, -27452, -31.9999), (0, 118.642, 0), 1);
  structs[26] = create_struct((-20693.1, -15175.3, -304), (0, -66.6904, 0));
  structs[27] = create_struct((-16776.3, -18894, -338.316), (0, -15.0922, 0), 1);
  structs[28] = create_struct((-26751, -7621.31, 40.6807), (0, 58.4382, 0));
  structs[29] = create_struct((-13668.5, -18519.2, -368), (0, -143.119, 0));
  structs[30] = create_struct((-22473.8, -10149.8, -301.138), (0, -70.3961, 0), 1);
  structs[31] = create_struct((-11184.8, -21061.9, -315.854), (0, 5.70909, 0), 1);
  structs[32] = create_struct((-30018.7, -4590.08, -316.327), (0, 23.8697, 0));
  structs[33] = create_struct((-4140.38, -30726.9, 278.381), (0, -144.114, 0));
  structs[34] = create_struct((-34822.4, -1184.25, -263.947), (0, -71.6069, 0), 1);
  structs[35] = create_struct((-26229.5, -4015.4, -313.889), (0, -117.77, 0), 1);
  structs[36] = create_struct((-30027.8, -1782.43, -313.225), (0, 175.937, 0));
  structs[37] = create_struct((-27619.2, -2302.54, -313.891), (0, -8.77301, 0), 1);
  structs[38] = create_struct((-7118.65, -19301.2, -144), (0, -5.73525, 0), 1);
  structs[39] = create_struct((-10491.1, -14985.5, -360), (0, -103.058, 0), 1);
  structs[40] = create_struct((-14283.6, -11003.1, -315.39), (0, 7.08201, 0));
  structs[41] = create_struct((-23169, -3966.54, -321.134), (0, -83.3339, 0), 1);
  structs[42] = create_struct((-8787.73, -15589.1, -367.949), (0, 100.158, 0), 1);
  structs[43] = create_struct((-817.503, -25527.6, -256.485), (0, -66.9498, 0), 1);
  structs[44] = create_struct((-14242.2, -8993.57, -285.128), (0, 40.3822, 0));
  structs[45] = create_struct((4555.72, -36115.3, -200.848), (0, -156.66, 0), 1);
  structs[46] = create_struct((1627.87, -28799.2, 312), (0, 150.838, 0), 1);
  structs[47] = create_struct((-9101.03, -10035.7, -320), (0, 33.7296, 0));
  structs[48] = create_struct((-6042.41, -13135.6, -363.999), (0, -134.727, 0), 1);
  structs[49] = create_struct((3185.75, -25611.3, -288.702), (0, 93.1862, 0), 1);
  structs[50] = create_struct((1792.7, -23147, -290.615), (0, -151.835, 0), 1);
  structs[51] = create_struct((-35463.8, 7869.36, 52.9549), (0, -93.1204, 0), 1);
  structs[52] = create_struct((-716.066, -18775.2, 934), (0, -148.79, 0));
  structs[53] = create_struct((1588.6, -20401.1, -285), (0, -58.1805, 0));
  structs[54] = create_struct((12452, -35755.6, -484), (0, -28.7822, 0), 1);
  structs[55] = create_struct((4648.29, -19224.9, -286.002), (0, 28.824, 0), 1);
  structs[56] = create_struct((-21706.1, 6555.31, -279.84), (0, 5.8398, 0), 1);
  structs[57] = create_struct((-16018.1, 4086.84, -318.486), (0, 3.79374, 0), 1);
  structs[58] = create_struct((-25374.2, 10918.1, -320), (0, 120.887, 0), 1);
  structs[59] = create_struct((-12119.8, 2981.18, -329.815), (0, 105.554, 0), 1);
  structs[60] = create_struct((-14767.3, 5096.92, -400.009), (0, 131.701, 0), 1);
  structs[61] = create_struct((8177.97, -19326, -286.002), (0, 91.7841, 0), 1);
  structs[62] = create_struct((15726.9, -35325.4, 318.345), (0, 151.377, 0), 1);
  structs[63] = create_struct((11454.7, -22581.5, -214.023), (0, -92.045, 0), 1);
  structs[64] = create_struct((-21126.1, 11662.1, -317.002), (0, -174.747, 0), 1);
  structs[65] = create_struct((-7293.09, 3009.49, -317.508), (0, -152.562, 0), 1);
  structs[66] = create_struct((17629.6, -32800.1, 15.9988), (0, 7.32444, 0), 1);
  structs[67] = create_struct((504.818, -3834.63, -449), (0, 66.6309, 0), 1);
  structs[68] = create_struct((-25415.2, 15191.1, -325.003), (0, -84.1954, 0), 1);
  structs[69] = create_struct((13957.3, -21816.1, -194), (0, -75.6819, 0), 1);
  structs[70] = create_struct((-10176, 6713.5, -400), (0, 75.3382, 0), 1);
  structs[71] = create_struct((-15327.9, 10742.1, -400), (0, 32.2232, 0), 1);
  structs[72] = create_struct((8420.99, -11753.6, 306), (0, 83.4712, 0), 1);
  structs[73] = create_struct((-22216, 14718, -64.0002), (0, -82.0633, 0), 1);
  structs[74] = create_struct((-17022, 11976.4, -322.43), (0, 105.663, 0), 1);
  structs[75] = create_struct((-30924.8, 19829.7, 205), (0, -69.3892, 0), 1);
  structs[76] = create_struct((-2024.99, 3060.21, -330.017), (0, -158.048, 0), 1);
  structs[77] = create_struct((-28136.9, 19575.5, -448.227), (0, -98.4958, 0), 1);
  structs[78] = create_struct((-12771.2, 11772.2, -326.973), (0, 19.9583, 0), 1);
  structs[79] = create_struct((22131, -32223, -440), (0, 119.727, 0), 1);
  structs[80] = create_struct((-5075.7, 7706.88, -323.004), (0, 133.054, 0), 1);
  structs[81] = create_struct((-22334.3, 18697.4, 688.005), (0, 140.553, 0), 1);
  structs[82] = create_struct((-25425.5, 20658.8, -448), (0, 0.274191, 0), 1);
  structs[83] = create_struct((23625.3, -31238.1, -563.054), (0, -52.2092, 0), 1);
  structs[84] = create_struct((-33327.4, 24789.2, 12.4296), (0, -44.4776, 0), 1);
  structs[85] = create_struct((21118.3, -22709.8, -232), (0, 42.769, 0));
  structs[86] = create_struct((-28418.1, 23715.5, -447.994), (0, -89.5397, 0), 1);
  structs[87] = create_struct((16769.7, -13392.7, 356.076), (0, -37.8018, 0));
  structs[88] = create_struct((-13952.5, 17259.8, -324), (0, -76.2444, 0), 1);
  structs[89] = create_struct((24205.4, -25029.5, -328.008), (0, 169.376, 0), 1);
  structs[90] = create_struct((12118.5, -3994.79, -340.649), (0, -23.2087, 0), 1);
  structs[91] = create_struct((-17899.8, 21527.3, -450.34), (0, -8.05977, 0), 1);
  structs[92] = create_struct((22217.9, -18422.9, 632), (0, 162.28, 0), 1);
  structs[93] = create_struct((21407.1, -16363.3, 1916.75), (0, -1.0712, 0), 1);
  structs[94] = create_struct((-2832.02, 13488.4, -319.985), (0, -0.230498, 0), 1);
  structs[95] = create_struct((3266.46, 9488.52, -317.067), (0, 97.6153, 0), 1);
  structs[96] = create_struct((22117.5, -13790.4, 256.102), (0, 135.758, 0), 1);
  structs[97] = create_struct((24850.9, -18555.2, -208.2), (0, -76.8969, 0), 1);
  structs[98] = create_struct((-23053.6, 27499.5, -460.201), (0, 83.541, 0), 1);
  structs[99] = create_struct((-8326.54, 20049.9, -257.261), (0, 110.381, 0), 1);
  structs[100] = create_struct((19238.7, -6573.38, -40), (0, -88.569, 0));
  structs[101] = create_struct((-36685.3, 33440.3, 1474.01), (0, -73.7051, 0), 1);
  structs[102] = create_struct((26569.7, -16938.2, -221.571), (0, 92.2376, 0), 1);
  structs[103] = create_struct((26412.2, -13112.5, -264), (0, 55.7859, 0), 1);
  structs[104] = create_struct((20248.8, -2154.65, -506.989), (0, 116.839, 0));
  structs[105] = create_struct((-6577.92, 23388.3, -448.004), (0, -101.867, 0), 1);
  structs[106] = create_struct((18069.7, 1558.6, -590.448), (0, -85.7224, 0), 1);
  structs[107] = create_struct((-10855.2, 27363.9, -259.411), (0, 148.092, 0), 1);
  structs[108] = create_struct((-2919.92, 22409.8, -446.75), (0, -78.7055, 0), 1);
  structs[109] = create_struct((-16866.8, 30593, -225.8), (0, -75.0401, 0), 1);
  structs[110] = create_struct((37954.1, -37722.9, -577.993), (0, 69.8195, 0), 1);
  structs[111] = create_struct((35023.3, -24338.2, -566), (0, 53.0156, 0), 1);
  structs[112] = create_struct((16187.4, 8712.66, -332.163), (0, -84.2018, 0), 1);
  structs[113] = create_struct((-25609.6, 36743.4, 348.439), (0, -160.438, 0));
  structs[114] = create_struct((-14068.2, 31959.7, -250.623), (0, -153.916, 0), 1);
  structs[115] = create_struct((29348.7, -8361.65, -424.006), (0, -81.6393, 0), 1);
  structs[116] = create_struct((8670.39, 18913.1, -303.729), (0, 105.535, 0), 1);
  structs[117] = create_struct((35020.4, -16139.2, -572.017), (0, 58.7604, 0), 1);
  structs[118] = create_struct((19630.8, 10158.6, -451.09), (0, -142.492, 0), 1);
  structs[119] = create_struct((43465.3, -36148.1, 51.093), (0, 112.905, 0));
  structs[120] = create_struct((-19560, 39017.6, -640), (0, 105.902, 0));
  structs[121] = create_struct((3395.98, 28640.1, 1.42773), (0, 135.948, 0), 1);
  structs[122] = create_struct((-12456.8, 38252.8, 0.642883), (0, 136.198, 0));
  structs[123] = create_struct((34810.3, -3657.19, -488), (0, -139.433, 0));
  structs[124] = create_struct((48307, -38482.1, 2272), (0, 54.6218, 0), 1);
  structs[125] = create_struct((17534.5, 19736.7, 318.301), (0, -103.234, 0), 1);
  structs[126] = create_struct((49054.6, -37186.3, 2272.02), (0, 62.8379, 0), 1);
  structs[127] = create_struct((-26149.3, 47192.9, 2703.16), (0, 36.4515, 0));
  structs[128] = create_struct((50932.9, -41318, 1347), (0, -109.525, 0), 1);
  structs[129] = create_struct((44159.8, -13820.7, -87.1293), (0, -7.88874, 0));
  structs[130] = create_struct((51090.6, -34587.3, 1343.9), (0, -9.93786, 0), 1);
  structs[131] = create_struct((32681, 7595.22, -497.554), (0, -48.5794, 0), 1);
  structs[132] = create_struct((35336.5, 3905.92, -551.754), (0, -23.8152, 0), 1);
  structs[133] = create_struct((52357.4, -33339, 1258.09), (0, -20.541, 0), 1);
  structs[134] = create_struct((-520.246, 39710.8, 2783), (0, -72.5011, 0), 1);
  structs[135] = create_struct((45634.6, -11566.6, -58.2778), (0, -151.105, 0), 1);
  structs[136] = create_struct((50376.7, -21886.4, -395.252), (0, -23.787, 0));
  structs[137] = create_struct((51570.2, -24783.1, -113.531), (0, 104.684, 0), 1);
  structs[138] = create_struct((39824, 1114.83, -424.993), (0, 138.361, 0), 1);
  structs[139] = create_struct((25390.7, 20043.1, 1343.21), (0, 135.63, 0), 1);
  structs[140] = create_struct((52294.1, -25802.7, -83.0376), (0, -19.67, 0), 1);
  structs[141] = create_struct((-11742.3, 47596, 1790.51), (0, -161.796, 0), 1);
  structs[142] = create_struct((44198.1, -4238.47, 266.547), (0, -102.295, 0));
  structs[143] = create_struct((48747.6, -12179.9, 14.8108), (0, -111.192, 0), 1);
  structs[144] = create_struct((46453.4, -6647.04, 208.457), (0, -15.0621, 0), 1);
  structs[145] = create_struct((12849.3, 34747.5, 2458.5), (0, -39.4017, 0), 1);
  structs[146] = create_struct((52493.1, -17205.6, -391.658), (0, 19.0522, 0), 1);
  structs[147] = create_struct((54470.9, -21095.7, -394.817), (0, -68.4661, 0));
  structs[148] = create_struct((-24417, 56523.2, 2659.76), (0, -129.922, 0), 1);
  structs[149] = create_struct((37257.1, 13799.8, 232), (0, 22.0809, 0), 1);
  structs[150] = create_struct((23294, 29633.7, 1019.7), (0, 17.9623, 0), 1);
  structs[151] = create_struct((-9892.05, 53353.9, 2428.22), (0, -25.4412, 0));
  structs[152] = create_struct((49428.4, 1843.77, 19.9863), (0, 175.256, 0), 1);
  structs[153] = create_struct((3411.24, 49881.5, 1032), (0, 83.1958, 0), 1);
  structs[154] = create_struct((57090, -11008.2, -433.158), (0, -94.4655, 0), 1);
  structs[155] = create_struct((20175.4, 39040, 957.372), (0, 82.8313, 0), 1);
  structs[156] = create_struct((-8255.86, 57148.3, 1071.37), (0, -11.2614, 0), 1);
  structs[157] = create_struct((51848.1, 3726.24, 29.3418), (0, 172.199, 0), 1);
  structs[158] = create_struct((50898.1, 6776.73, 29.7878), (0, -8.3196, 0), 1);
  structs[159] = create_struct((-17676, 62373.4, 1908.92), (0, -4.78614, 0));
  structs[160] = create_struct((12324.8, 47493.6, 1036), (0, -44.8196, 0), 1);
  structs[161] = create_struct((29716.1, 34472.4, 435.436), (0, -133.228, 0), 1);
  structs[162] = create_struct((37269.7, 27514, 190.688), (0, -36.7275, 0), 1);
  structs[163] = create_struct((46679.8, 17932.4, -352.184), (0, 157.463, 0), 1);
  structs[164] = create_struct((53649.7, 7546.33, 29.3552), (0, -107.59, 0), 1);
  structs[165] = create_struct((57918.4, 650.832, 41.0137), (0, 106.07, 0), 1);
  structs[166] = create_struct((7073.74, 57285.5, 1036), (0, 164.547, 0), 1);
  structs[167] = create_struct((27957.2, 43805.1, 1753.23), (0, -142.754, 0), 1);
  structs[168] = create_struct((20050.9, 52735.7, 1917.76), (0, 137.974, 0), 1);
  structs[169] = create_struct((43887.3, 31928.7, -198.527), (0, -93.8224, 0), 1);
  structs[170] = create_struct((44717.5, 39263.5, -42.8776), (0, -102.018, 0), 1);
  structs[171] = create_struct((37958.5, 47398, 944.177), (0, -119.853, 0), 1);
  return structs;
}

function function_50c9687cccd76c7f() {
  structs = [];
  structs[structs.size] = create_struct((26952, -6018, -454), (0, 50, 0));
  return structs;
}

function mp_br_quarry_locations() {
  structs = [];
  structs[structs.size] = create_struct((29786.7, 41132.6, 749.673), (0, -132.937, 0));
  structs[structs.size] = create_struct((31330.7, 43775.2, 685), (0, -111.923, 0));
  structs[structs.size] = create_struct((37671.1, 42532.2, 857.039), (0, -169.422, 0));
  structs[structs.size] = create_struct((40311.2, 44060.2, 1326.98), (0, 169.247, 0));
  return structs;
}

function function_35c3e71a666e6cb2() {
  structs = [];
  structs[0] = create_struct((-3052, -3432.96, 569.921), (0, -17.561, 0));
  structs[1] = create_struct((13184, 6231.49, 987.665), (0, -168.487, 0));
  structs[2] = create_struct((1692.81, 8271, 530.205), (0, 15, 0));
  structs[3] = create_struct((-11464.6, -6999.94, 419.45), (0, 74.113, 0));
  structs[4] = create_struct((14031.4, -4991.84, 940.06), (0, -120.533, 0));
  return structs;
}

function function_bce27e24255486f0() {
  structs = [];
  structs[0] = create_struct((-438, -8424.5, 152), (0, 0, 0));
  structs[1] = create_struct((-4525.68, 1663.06, 707.792), (0, 78.8, 0));
  structs[2] = create_struct((-1087.67, 9912.43, 651.942), (0, 233.66, 0));
  structs[3] = create_struct((853.004, -5868.04, 704.038), (0, 14.257, 0));
  structs[4] = create_struct((2782.44, 89.107, 832.712), (0, 281.983, 0));
  return structs;
}

function function_adb0a839c433d47() {
  structs = [];
  structs[0] = create_struct((340, -8608.5, 154.5), (0, 208.092, 0));
  structs[1] = create_struct((-4387.68, 3702.56, 619.292), (0, 0, 0));
  structs[2] = create_struct((-1064.06, -2665.39, 1253.71), (0, 350.48, 0));
  structs[3] = create_struct((-688.062, 6849.11, 1060.71), (0, 294.625, 0));
  structs[4] = create_struct((2757.94, -213.893, 840.212), (0, 288.868, 0));
  structs[5] = create_struct((-1310.06, 3814.61, 1068.21), (0, 151.424, 0));
  structs[6] = create_struct((-1637.5, -11137, 178), (0, 284.306, 0));
  return structs;
}

function function_d076db51878a786b() {
  structs = [];
  structs[0] = create_struct((-39369, -41359.9, 411.4), (0, 95.7673, 0));
  structs[1] = create_struct((-29293.8, -47264.3, 276), (0, -101.788, 0));
  structs[2] = create_struct((9846.07, 47782.9, 575.094), (0, 90.5157, 0));
  structs[3] = create_struct((-30254.6, -36462.8, 241.5), (0, -164.467, -2));
  structs[4] = create_struct((-21745.5, -51712, 261.833), (0, -71.035, 0));
  structs[5] = create_struct((-35403, -29096.8, 311.263), (0, 40.6488, 0));
  structs[6] = create_struct((-47587, -21495.3, 311.086), (0, -71.0138, 0));
  structs[7] = create_struct((-42779.8, -19913.7, 252.753), (0, 164.988, 0));
  structs[8] = create_struct((4933.63, 49820.8, 1907.15), (0, -23.6093, 0));
  structs[9] = create_struct((-53201.4, -16206.4, 254.664), (0, 114.356, 0));
  structs[10] = create_struct((-23649.7, -34362.4, 489.954), (0, -67.4042, 0));
  structs[11] = create_struct((-15872.1, -51561, 321.765), (0, -69.1303, 0));
  structs[12] = create_struct((-17394.6, -43027, 925), (0, 123.744, -1));
  structs[13] = create_struct((-36460.4, -17743.9, 262.875), (0, -43.5358, 0));
  structs[14] = create_struct((-28487, -23065.3, 265.088), (0, 105.75, 0));
  structs[15] = create_struct((-48507.7, -11325.2, 256.32), (0, 152.829, 0));
  structs[16] = create_struct((-12324.6, -34717.9, 477.875), (0, 61.9439, 0));
  structs[17] = create_struct((-23305.9, -16827.7, 341.438), (0, -84.3488, 0));
  structs[18] = create_struct((-6158.99, -41637.6, 518.924), (0, -22.1046, 0));
  structs[19] = create_struct((-14976, -24951.6, 636.613), (0, 151.061, 0));
  structs[20] = create_struct((-4178.91, -46745.5, 303.502), (0, 61.9816, 0));
  structs[21] = create_struct((-30650, -10325, 2126), (5, 2.45985, 0));
  structs[22] = create_struct((-46484.1, -2479.36, 680.235), (0, 119.324, 0));
  structs[23] = create_struct((-185.708, -49385.1, 255.524), (0, -163.12, 0));
  structs[24] = create_struct((25615.3, 31418.7, 463.43), (0, 45.5604, 0));
  structs[25] = create_struct((-4360.26, -31269.6, 969.544), (0, 56.5222, 0));
  structs[26] = create_struct((-35260.7, -2454.81, 2476), (0, 54.6803, 0));
  structs[27] = create_struct((-14228.9, -15620, 1163.5), (0, -154.979, 1.25));
  structs[28] = create_struct((4158.13, -43993.5, 176), (0, -14.6602, 0));
  structs[29] = create_struct((-3583.35, -24487.2, 4146.05), (0, -119.721, 0));
  structs[30] = create_struct((1180.52, -32284.5, 976.25), (0, -168.315, 0.35));
  structs[31] = create_struct((-48026.6, 6097.97, 844.851), (0, 77.9464, 0));
  structs[32] = create_struct((-25398, -1562.27, 1857.5), (1, 60.2075, -2));
  structs[33] = create_struct((8726.56, -45844, 163), (0, 136.397, 0));
  structs[34] = create_struct((-5041.36, -16403.4, 4479.42), (0, 87.4744, 0));
  structs[35] = create_struct((9676.73, -50696.4, 639.969), (0, -10.5105, 0));
  structs[36] = create_struct((-16550, -4060, 958.613), (-0.5, 30, 0));
  structs[37] = create_struct((-31625, 5585, 1891), (0, 125, 0));
  structs[38] = create_struct((11711.6, -41940.3, 485.582), (0, 1, 0));
  structs[39] = create_struct((-8732.49, -5994.88, 1598.15), (0, 80.6329, 0));
  structs[40] = create_struct((5434.9, -24162.8, 1326.97), (0, 159.264, 0));
  structs[41] = create_struct((-40733.9, 14174.4, -123.5), (2, 125, 2.5));
  structs[42] = create_struct((4750, -15650, 3497), (-2.85, -15, 7));
  structs[43] = create_struct((18225.7, -50999.2, 871), (-1, -78.7292, 0.5));
  structs[44] = create_struct((19025.3, -49611.4, 511.934), (0, -168.3, 0));
  structs[45] = create_struct((17782.6, -42117, 920.775), (0, -19.5421, 0));
  structs[46] = create_struct((-48377.1, 19041.2, 1217.25), (-0.5, -15.8246, 0));
  structs[47] = create_struct((15523.4, 39204.8, 255.938), (0, 76.2923, 0));
  structs[48] = create_struct((4538.59, -10057.1, 4543.89), (0, -130.971, 0));
  structs[49] = create_struct((21937, -58545.2, 147.88), (0, 119.109, 0));
  structs[50] = create_struct((-33235.5, 17573.9, -228), (0, 99.9766, 0.5));
  structs[51] = create_struct((-12441.4, 7037.31, 358.622), (0, -20, 0));
  structs[52] = create_struct((17315.8, -31542.1, 607), (0, 112.641, 0));
  structs[53] = create_struct((-2803.41, -55.0272, 1454.21), (0, 4.76951, 0));
  structs[54] = create_struct((-24331.9, 16686, -358.333), (0, 9.05438, 0));
  structs[55] = create_struct((-56085.7, 3379.49, 898), (0, -270, 0));
  structs[56] = create_struct((17215.6, -22731.1, 1055), (0, 39.6474, 0));
  structs[57] = create_struct((-6514.94, 11218.8, 592), (0, 30.8891, 0));
  structs[58] = create_struct((-32585, 25134.4, -511.239), (0, -33.0075, 0));
  structs[59] = create_struct((-17470.3, 19780.5, -392.649), (0, 20.1298, 0));
  structs[60] = create_struct((3548.84, 5114.94, 421.583), (0, 46.6346, 0));
  structs[61] = create_struct((14387.1, -6335, 715), (0, -98.2848, 1));
  structs[62] = create_struct((-41991.8, 30200.1, 2025.63), (0, -24.9884, 0));
  structs[63] = create_struct((22089.9, -13691.4, 2915.06), (0, 58.2134, 0));
  structs[64] = create_struct((-11129.3, 21448.3, -299.089), (0, 5.8959, 0));
  structs[65] = create_struct((32276.1, -35009.8, 207.74), (0, 77.5266, 0));
  structs[66] = create_struct((32336.5, -25973.6, 353.72), (0, 158.697, 0));
  structs[67] = create_struct((-7174.08, 52679.2, 239.168), (0, 128.794, 0));
  structs[68] = create_struct((-21004, 30769.5, -230.563), (0, 88.2455, 0));
  structs[69] = create_struct((-29194.6, 34650.9, -408.432), (0, 15.8698, 0));
  structs[70] = create_struct((7755.9, 13451.5, 438.777), (0, -120.067, 0));
  structs[71] = create_struct((15528.3, 5994, 212.282), (0, 91.2709, 0));
  structs[72] = create_struct((26061.1, -4868, 385), (0, -123.238, 0));
  structs[73] = create_struct((31881.8, -13364.7, 499.14), (0, 72.5817, 0));
  structs[74] = create_struct((-36472.2, 41051, 703), (1, 2.4043, 0));
  structs[75] = create_struct((22581.1, 4025.26, 244.94), (0, 81.3338, 0));
  structs[76] = create_struct((-12179.3, 34679.9, 430.319), (0, -152.652, 0));
  structs[77] = create_struct((-2243.12, 29566.9, 452.931), (0, 73.1947, 0));
  structs[78] = create_struct((44072.7, -33296.6, 207.72), (0, -76.6994, 0));
  structs[79] = create_struct((-22731, 41295, -446.5), (-3, -14.0896, 1.5));
  structs[80] = create_struct((9585.33, 23570.4, 776), (0, 74.3278, 0));
  structs[81] = create_struct((36886.3, -10514.8, 422), (0, -167.128, 0.25));
  structs[82] = create_struct((40514, -17488, 531.938), (0, 171.068, 0));
  structs[83] = create_struct((-29508.4, 44859, 573.102), (0, -163.57, 0));
  structs[84] = create_struct((35569.2, -6698.65, 557.819), (0, -128.877, 0.5));
  structs[85] = create_struct((20406.6, 14733.3, 257.426), (0, 12.3956, 0));
  structs[86] = create_struct((17904.3, 18536.6, 255.971), (0, -123.106, 0));
  structs[87] = create_struct((32405, 1793.53, 270), (0, 77.3216, 0));
  structs[88] = create_struct((25169.2, 13338.2, 637.388), (0, -164.852, 0));
  structs[89] = create_struct((22150.1, 17121.9, 261.5), (0, 164.697, 0));
  structs[90] = create_struct((-11247.3, 42680.1, 185.483), (0, 150.499, 0));
  structs[91] = create_struct((21292.6, 20519.8, 247), (0, 152.604, 0));
  structs[92] = create_struct((32849.4, 10107.7, 266.698), (0, 59.889, 0));
  structs[93] = create_struct((13305.4, 30399.8, 255.938), (0, 171.229, 0));
  structs[94] = create_struct((32664.4, 20853.7, 255.999), (0, 48.596, 0));
  structs[95] = create_struct((25393.2, 19456.5, 634.75), (0, 19.8145, 0));
  structs[96] = create_struct((6079.95, 36144.1, 263.445), (0, 63.2851, 0));
  structs[97] = create_struct((39795.8, 1449.49, 576.788), (0, 93.9671, 0));
  structs[98] = create_struct((28879.8, 16442.7, 256.799), (0, -160.889, 0.25));
  structs[99] = create_struct((45838.8, -8697.28, 759.432), (0.75, 44.0235, -0.25));
  structs[100] = create_struct((-457.835, 43987.8, 471), (0, 55.4758, 0));
  structs[101] = create_struct((-13222.4, 50413.4, 193.269), (0, 161.088, 0));
  structs[102] = create_struct((-18302.3, 53837.7, 393.263), (0, 167.93, 0));
  structs[103] = create_struct((-835.436, 19340, 444.436), (0, 69.0097, -0.25));
  structs[104] = create_struct((-19762.7, 8838, 883.25), (0, -170, 3.75));
  structs[105] = create_struct((-60338.7, -16083.2, 320), (0, 68.301, 0));
  return structs;
}

function function_def43d85b603ef19() {
  structs = [];
  structs[0] = create_struct((-7620.78, -11682.3, 366.837), (0, -33.1582, 0));
  structs[1] = create_struct((-6996.9, 705.593, 514.562), (0, 75.9253, 0));
  structs[2] = create_struct((6241.23, -472.799, 466.366), (0, 120.736, 0));
  structs[3] = create_struct((2706.98, 8944.64, 386.568), (0, -67.1093, 0));
  return structs;
}

function function_c5c3d7914a4df89a() {
  structs = [];
  structs[0] = create_struct((13718.9, 247.214, 995), (0, 17, 0));
  structs[1] = create_struct((1692, 8271, 528), (0, 17, 0));
  structs[2] = create_struct((-11467.4, -6998.01, 420), (0, 74, 0));
  structs[3] = create_struct((14007.6, -5067.2, 947.8), (0, -112.29, 0));

  iprintlnbold("<dev string:xeb>");

  return structs;
}

function mp_jup_bigmap_locations() {
  structs = [];
  structs[0] = create_struct((-34027.2, -37190, 2517.13), (0, 70.8628, 0));
  structs[1] = create_struct((-33612.9, -28188.4, 1202), (0, -23.8636, 0));
  structs[2] = create_struct((-22008, -40861.5, 2720.94), (0, 14.8914, 0));
  structs[3] = create_struct((-22607.8, -29183.1, 1701.81), (0, -149.729, 0));
  structs[4] = create_struct((-26032, -21445.7, 1697.94), (0, -10.6116, 0));
  structs[5] = create_struct((-10206.2, -42678, 2400.36), (0, -31.2536, 0));
  structs[6] = create_struct((-13646, -33713.1, 1916.13), (0, 162.854, 0));
  structs[7] = create_struct((-31637.4, -14425, 1423.24), (0, -2.55103, 0));
  structs[8] = create_struct((-32679.6, -9217.05, 1049.01), (0, -86.3225, 0));
  structs[9] = create_struct((-30049.7, -9418.54, 1526.88), (0, -179.222, 0));
  structs[10] = create_struct((-2548.18, -40727.9, 2716.23), (0, 4.66481, 0));
  structs[11] = create_struct((-9438.41, -26121, 1714.8), (0, -120.241, 0));
  structs[12] = create_struct((-15921.6, -17288.9, 1708.32), (0, -13.7871, 0));
  structs[13] = create_struct((-21766.7, -10015.4, 1504.94), (0, 136.75, 0));
  structs[14] = create_struct((-40437.3, -36.1174, 936), (0, 161.996, 0));
  structs[15] = create_struct((-36334.5, -279.252, 1008), (0, 101.209, 0));
  structs[16] = create_struct((-41447.1, 3360.58, 936), (0, -106.422, 0));
  structs[17] = create_struct((1924.22, -34281.6, 1959.92), (0, -179.038, 0));
  structs[18] = create_struct((-25890.2, -1908.45, 1012.24), (0, -27.9583, 0));
  structs[19] = create_struct((-4572.72, -18512.5, 1697.21), (0, 142.444, 0));
  structs[20] = create_struct((1281.89, -25447.5, 1706.43), (0, -19.7548, 0));
  structs[21] = create_struct((8481.72, -38869.3, 2917.67), (0, 23.9541, 0));
  structs[22] = create_struct((-17690.4, -2015.87, 1039.8), (0, 63.5672, 0));
  structs[23] = create_struct((-10074.9, -6502.44, 912.71), (0, -21.3151, 0));
  structs[24] = create_struct((-24669.3, 6484.95, 1069.74), (0, 103.827, 0));
  structs[25] = create_struct((-36569.3, 11567.4, 936), (0, -30.4598, 0));
  structs[26] = create_struct((-2018.1, -11457.5, 1639.14), (0, -139.045, 0));
  structs[27] = create_struct((6490.67, -17623.4, 2258), (0, -18.2263, 0));
  structs[28] = create_struct((12896.3, -29578.5, 2807.75), (0, 23.8521, 0));
  structs[29] = create_struct((-30597.1, 13765, 1004.27), (0, -4.67375, 0));
  structs[30] = create_struct((17379.4, -34760.7, 2800.19), (0, 126.496, 0));
  structs[31] = create_struct((-11675.4, 8003.31, 1356), (0, 135.142, 0));
  structs[32] = create_struct((1590.85, -3243.02, 2008), (0, -58.6617, 0));
  structs[33] = create_struct((-2841.8, 1252.9, 2008), (0, 12.5652, 0));
  structs[34] = create_struct((14464.2, -18065.3, 1769), (0, 66.5553, 0));
  structs[35] = create_struct((10201.7, -8331.71, 1868.82), (0, -5.85244, 0));
  structs[36] = create_struct((-21233.1, 19010, 1725.44), (0, -109.651, 0));
  structs[37] = create_struct((26671.2, -44595.5, 3474.46), (0, 143.564, 0));
  structs[38] = create_struct((25662.1, -37528.7, 3119.24), (0, -71.7453, 0));
  structs[39] = create_struct((-36348.9, 25484.9, 1136), (0, -94.1201, 0));
  structs[40] = create_struct((23449.9, -25999.6, 3099.47), (0, -122.359, 0));
  structs[41] = create_struct((12904.2, -6908.7, 1614.25), (0, 170.648, 0));
  structs[42] = create_struct((-30600.9, 26224.2, 1376), (0, -61.4455, 0));
  structs[43] = create_struct((5787.22, 4077.98, 1440.16), (0, 52.8755, 0));
  structs[44] = create_struct((-1671.32, 12598.5, 1039.43), (0, 82.1803, 0));
  structs[45] = create_struct((-13784.3, 20874.3, 2219.73), (0, -38.0312, 0));
  structs[46] = create_struct((-36572.3, 31710.2, 1136), (0, -159.347, 0));
  structs[47] = create_struct((-23398.4, 27480.7, 1929.5), (0, -98.0015, 0));
  structs[48] = create_struct((29624.5, -28127.6, 3227.78), (0, -1.1114, 0));
  structs[49] = create_struct((16975.8, -882.391, 1700), (0, 145.821, 0));
  structs[50] = create_struct((27437.4, -15784.8, 3068.75), (0, 57.3774, 0));
  structs[51] = create_struct((-900, 19200, 1000), (0, 0, 0));
  structs[52] = create_struct((4792.2, 14767.8, 1434.99), (0, -64.1787, 0));
  structs[53] = create_struct((-41836.1, 37512.8, 994.188), (0, -59.165, 0));
  structs[54] = create_struct((36637.1, -35111.3, 3336), (0, -46.3579, 0));
  structs[55] = create_struct((25254.5, -6464.63, 3171.67), (0, 62.807, 0));
  structs[56] = create_struct((-13934.9, 30404.5, 2536.09), (0, -74.3287, 0));
  structs[57] = create_struct((34862.4, -19153.8, 3044.8), (0, 65.5488, 0));
  structs[58] = create_struct((-27411.4, 38544.6, 1872), (0, -28.6968, 0));
  structs[59] = create_struct((-5798.45, 29311.9, 1110.34), (0, -16.5289, 0));
  structs[60] = create_struct((22408.1, 4308.67, 1830.71), (0, -17.9524, 0));
  structs[61] = create_struct((39538.5, -27785.6, 3262), (0, 130.142, 0));
  structs[62] = create_struct((12407.8, 15714.3, 907.992), (0, -20.7889, 0));
  structs[63] = create_struct((-36001, 43422.6, 1764.81), (0, 125.545, 0));
  structs[64] = create_struct((-19556.3, 40821.7, 2175.7), (0, -23.9147, 0));
  structs[65] = create_struct((34181, -4591.53, 2883.14), (0, -160.037, 0));
  structs[66] = create_struct((29998.1, 2367.48, 2000), (0, -98.1662, 0));
  structs[67] = create_struct((-11599.8, 38759.4, 2437.92), (0, 22.0178, 0));
  structs[68] = create_struct((5266.52, 29119.7, 981.228), (0, -21.2668, 0));
  structs[69] = create_struct((14600.6, 23987.2, 1529.42), (0, 157.023, 0));
  structs[70] = create_struct((23876.1, 15368.1, 1637.78), (0, -35.6981, 0));
  structs[71] = create_struct((42443.1, -12604.5, 2762.79), (0, -62.9285, 0));
  structs[72] = create_struct((1188.28, 38061.4, 1374.83), (0, -90.9912, 0));
  structs[73] = create_struct((31411, 11874.5, 2061.74), (0, -134.389, 0));
  structs[74] = create_struct((41184.4, -2063.93, 3030.39), (0, 94.329, 0));
  structs[75] = create_struct((25559.2, 22323.4, 1344.91), (0, 179.534, 0));
  structs[76] = create_struct((39125.6, 6579.18, 2903.32), (0, 45.0161, 0));
  structs[77] = create_struct((9084.49, 38420.7, 1209.19), (0, -20.2127, 0));
  structs[79] = create_struct((34026.3, 18394.4, 3069.16), (0, -44.0106, 0));
  structs[80] = create_struct((41518.1, 13008.1, 3128.52), (0, 128.408, 0));
  structs[81] = create_struct((32940.9, 28490.9, 1544), (0, 75.7533, 0));
  structs[82] = create_struct((25858.4, 38580.6, 941.269), (0, 43.4277, 0));
  structs[83] = create_struct((40502.1, 24140.6, 3005.72), (0, -1.83779, 0));
  structs[84] = create_struct((31305.1, 40841.3, 1395), (0, 30.6125, 0));
  structs[85] = create_struct((43372.6, 32192.2, 2576), (0, -55.2122, 0));
  structs[86] = create_struct((40540.1, 39990.9, 905.55), (0, 75.4344, 0));

  iprintlnbold("<dev string:x148>");

  return structs;
}

function function_5e3eb8b4dd5708d5() {
  structs = [];
  structs[0] = create_struct((-29500, 30100, 1855), (0, -90, 0));
  structs[1] = create_struct((-22000, 10050, 2475), (0, 0, 0));
  structs[2] = create_struct((6844, -4852, 2392), (0, -85, 0));
  structs[3] = create_struct((14778, -8979, 1805), (0, 30, 0));
  structs[4] = create_struct((-20530, -36210, 2670), (0, 30, 0));
  structs[5] = create_struct((-25118, 34068, 1444), (0, 180, 0));
  structs[6] = create_struct((-16796, 27118, 3063), (0, 0, 0));
  structs[7] = create_struct((-22150, 21450, 2015), (0, 180, 0));
  structs[8] = create_struct((2905, 27854, 998), (0, 0, 0));
  structs[9] = create_struct((-29056, 41358, 1550), (0, -10, 0));
  structs[10] = create_struct((-17375, -13248, 1850), (0, 10, 0));
  structs[11] = create_struct((4893, 8907, 1450), (0, 0, 0));
  structs[12] = create_struct((-3179, -18344, 1705), (0, 0, 0));
  structs[13] = create_struct((-15116, -23718, 1750), (0, -180, 0));
  structs[14] = create_struct((-24847, -23678, 1700), (0, -180, 0));
  structs[15] = create_struct((-13795, 11083, 1265), (0, 0, 0));
  structs[16] = create_struct((-1909, 2832, 2015), (0, 0, 0));
  structs[17] = create_struct((-25159, 143, 1100), (0, -40, 0));
  structs[18] = create_struct((-26222, 4597, 1032), (0, 0, 0));
  structs[19] = create_struct((43000, 33544, 2576), (0, 40, 0));
  structs[20] = create_struct((9818, 32924, 1200), (0, 0, 0));
  structs[21] = create_struct((8101, 22948, 1000), (0, 0, 0));
  structs[22] = create_struct((-3617, 37045, 1320), (0, 0, 0));
  structs[23] = create_struct((-2398, 24055, 921), (0, 30, 0));
  structs[24] = create_struct((37016, 18728, 3344), (0, -20, 0));
  structs[25] = create_struct((28784, 26320, 1384), (0, 45, 0));
  structs[26] = create_struct((24240, 33040, 1544), (0, -90, 0));
  structs[27] = create_struct((30576, 40320, 1000), (0, 15, 0));
  structs[28] = create_struct((-32391, 9699, 1000), (0, 0, 0));
  structs[29] = create_struct((-33424, 4975, 1000), (0, 0, 0));
  structs[30] = create_struct((33550, -11763, 2936.5), (0, 0, 0));
  structs[31] = create_struct((33535, 374, 2561), (0, 0, 0));
  structs[32] = create_struct((39244, 6018, 2902), (0, 5, 0));
  structs[33] = create_struct((41905, -4618, 3357), (0, 0, 0));
  structs[34] = create_struct((38453, -88, 2968), (0, 0, 0));
  structs[35] = create_struct((-3179, -18344, 1707), (0, 42, 0));
  structs[36] = create_struct((4200, -2300, 2008), (0, 100, 0));
  structs[37] = create_struct((6738, -16660, 2258), (0, 15, 0));
  structs[38] = create_struct((3912, -27512, 2152), (0, 15, 0));
  structs[39] = create_struct((9080, -24672, 1768), (0, 90, 0));
  structs[40] = create_struct((13632, -24928, 1704), (0, 90, 0));
  structs[41] = create_struct((28208, -31152, 3916), (0, 0, 0));
  structs[42] = create_struct((35320, -34688, 3016), (0, 0, 0));
  structs[43] = create_struct((26024, -40072, 3112), (0, 15, 0));
  structs[44] = create_struct((38080, -20472, 3056), (0, 0, 0));
  structs[45] = create_struct((43372.6, 32192.2, 2576), (0, 60, 0));
  structs[46] = create_struct((39125.6, 6579.18, 2903.32), (0, -30, 0));
  structs[47] = create_struct((-11599.8, 38759.4, 2437.92), (0, 0, 0));
  structs[48] = create_struct((29998.1, 2367.48, 2000), (0, -20, 0));
  structs[49] = create_struct((-36001, 43422.6, 1764.81), (0, -45, 0));
  structs[50] = create_struct((22408.1, 4308.67, 1830.71), (0, 180, 0));
  structs[51] = create_struct((-30600.9, 26224.2, 1376), (0, -10, 0));
  structs[52] = create_struct((23449.9, -25999.6, 3099.47), (0, 0, 0));
  structs[53] = create_struct((10201.7, -8331.71, 1868.82), (0, -90, 0));
  structs[54] = create_struct((-2018.1, -11457.5, 1639.14), (0, 0, 0));
  structs[55] = create_struct((6490.67, -17623.4, 2258), (0, 0, 0));
  structs[56] = create_struct((-33612.9, -28188.4, 1202), (0, 180, 0));
  structs[57] = create_struct((-22008, -40861.5, 2720.94), (0, 0, 0));
  structs[58] = create_struct((-26032, -21445.7, 1697.94), (0, 180, 0));
  structs[59] = create_struct((-31637.4, -14425, 1423.24), (0, 10, 0));
  structs[60] = create_struct((-32679.6, -9217.05, 1049.01), (0, 0, 0));
  structs[61] = create_struct((-30049.7, -9418.54, 1526.88), (0, -179.222, 0));
  structs[62] = create_struct((-2548.18, -40727.9, 2716.23), (0, 4.66481, 0));
  structs[63] = create_struct((-15921.6, -17288.9, 1708.32), (0, -13.7871, 0));
  structs[64] = create_struct((-21766.7, -10015.4, 1504.94), (0, 136.75, 0));
  structs[65] = create_struct((-40437.3, -36.1174, 936), (0, 161.996, 0));
  structs[66] = create_struct((-36334.5, -279.252, 1008), (0, 101.209, 0));
  structs[67] = create_struct((-41447.1, 3360.58, 936), (0, -106.422, 0));
  structs[68] = create_struct((-10074.9, -6502.44, 912.71), (0, -21.3151, 0));
  structs[69] = create_struct((-36569.3, 11567.4, 936), (0, -30.4598, 0));
  structs[70] = create_struct((-30597.1, 13765, 1004.27), (0, -4.67375, 0));
  structs[71] = create_struct((17379.4, -34760.7, 2800.19), (0, 126.496, 0));
  structs[72] = create_struct((1590.85, -3243.02, 2008), (0, -58.6617, 0));
  structs[73] = create_struct((-2841.8, 1252.9, 2008), (0, 12.5652, 0));
  structs[74] = create_struct((-21233.1, 19010, 1725.44), (0, -109.651, 0));
  structs[75] = create_struct((25662.1, -37528.7, 3119.24), (0, -71.7453, 0));
  structs[76] = create_struct((-36348.9, 25484.9, 1136), (0, -94.1201, 0));
  structs[77] = create_struct((12904.2, -6908.7, 1614.25), (0, 170.648, 0));
  structs[78] = create_struct((-13784.3, 20874.3, 2219.73), (0, -38.0312, 0));
  structs[79] = create_struct((-36572.3, 31710.2, 1136), (0, -159.347, 0));
  structs[80] = create_struct((29624.5, -28127.6, 3227.78), (0, -1.1114, 0));
  structs[81] = create_struct((16975.8, -882.391, 1700), (0, 145.821, 0));
  structs[82] = create_struct((-41836.1, 37512.8, 994.188), (0, -59.165, 0));
  structs[83] = create_struct((25254.5, -6464.63, 3171.67), (0, 62.807, 0));
  structs[84] = create_struct((-13934.9, 30404.5, 2536.09), (0, -74.3287, 0));
  structs[85] = create_struct((34862.4, -19153.8, 3044.8), (0, 65.5488, 0));
  structs[86] = create_struct((-27411.4, 38544.6, 1872), (0, -28.6968, 0));
  structs[87] = create_struct((-5798.45, 29311.9, 1110.34), (0, -16.5289, 0));
  structs[88] = create_struct((39538.5, -27785.6, 3262), (0, 130.142, 0));
  structs[89] = create_struct((42443.1, -12604.5, 2762.79), (0, -62.9285, 0));
  structs[90] = create_struct((1188.28, 38061.4, 1374.83), (0, -90.9912, 0));
  structs[91] = create_struct((31411, 11874.5, 2061.74), (0, -134.389, 0));
  structs[92] = create_struct((41184.4, -2063.93, 3030.39), (0, 94.329, 0));
  structs[93] = create_struct((25559.2, 22323.4, 1344.91), (0, 179.534, 0));
  structs[94] = create_struct((9084.49, 38420.7, 1209.19), (0, -20.2127, 0));
  structs[95] = create_struct((34026.3, 18394.4, 3069.16), (0, -44.0106, 0));
  structs[96] = create_struct((41518.1, 13008.1, 3128.52), (0, 128.408, 0));
  structs[97] = create_struct((32940.9, 28490.9, 1544), (0, 75.7533, 0));
  structs[98] = create_struct((25858.4, 38580.6, 941.269), (0, 43.4277, 0));
  structs[99] = create_struct((40540.1, 39990.9, 905.55), (0, 75.4344, 0));
  structs[100] = create_struct((-34027.2, -37190, 2517.13), (0, 70.8628, 0));
  structs[101] = create_struct((-22607.8, -29183.1, 1701.81), (0, -195, 0));
  structs[102] = create_struct((-10206.2, -42678, 2400.36), (0, -31.2536, 0));
  structs[103] = create_struct((-13646, -33713.1, 1916.13), (0, 162.854, 0));
  structs[104] = create_struct((-9438.41, -26121, 1714.8), (0, 60, 0));
  structs[105] = create_struct((1924.22, -34281.6, 1959.92), (0, -179.038, 0));
  structs[106] = create_struct((-25890.2, -1908.45, 1012.24), (0, -18, 0));
  structs[107] = create_struct((-4572.72, -18512.5, 1697.21), (0, 142.444, 0));
  structs[108] = create_struct((8481.72, -38869.3, 2917.67), (0, 23.9541, 0));
  structs[109] = create_struct((-24669.3, 6484.95, 1069.74), (0, 103.827, 0));
  structs[110] = create_struct((12896.3, -29578.5, 2807.75), (0, 23.8521, 0));
  structs[111] = create_struct((-11675.4, 8003.31, 1356), (0, 135.142, 0));
  structs[112] = create_struct((5787.22, 4077.98, 1440.16), (0, 52.8755, 0));
  structs[113] = create_struct((-1671.32, 12598.5, 1039.43), (0, 82.1803, 0));
  structs[114] = create_struct((-23398.4, 27480.7, 1929.5), (0, -98.0015, 0));
  structs[115] = create_struct((34181, -4591.53, 2883.14), (0, -160.037, 0));
  structs[116] = create_struct((14600.6, 23987.2, 1529.42), (0, 157.023, 0));
  return structs;
}

function function_2727828d27cbdf05() {
  structs = [];
  structs[0] = create_struct((-2908, 3114, 1430.5), (0, 30.1858, 0));
  structs[1] = create_struct((1093, 4959, 1115.5), (0, 258.801, 0));
  structs[2] = create_struct((-1550, 1481.5, 1150.5), (0, 12.51, 0));
  return structs;
}

function create_struct(org, ang, var_252267264f5269fe) {
  struct = spawnStruct();
  struct.origin = org;
  struct.angles = ang;

  struct.var_fcb6c737b5ecef23 = var_252267264f5269fe;

  return struct;
}