/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7933519955f32c4e.gsc
*************************************************/

#using script_930a1e7bd882c1d;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\deathicons;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\music_and_dialog;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_147cc21b507a21ed;

function init() {
  var_1f065571b3854f0 = scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("infilSequence");
  level.var_b4e9d46918f067bb = getdvarint(@ "hash_c4a4576c5ca4960", 0) || var_1f065571b3854f0;
  level.var_a696a93807abb2fd = spawnStruct();
}

function function_b4e9d46918f067bb() {
  return level.var_b4e9d46918f067bb;
}

function main() {
  if(!function_b4e9d46918f067bb()) {
    return;
  }

  var_567639d26f6a140b = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(var_567639d26f6a140b)) {
    var_567639d26f6a140b hide();
  }

  level.brlatespawnplayer = &latespawnplayer;
  setdvarifuninitialized(@ "hash_4265a52f9f8a703", 1);
  setdvarifuninitialized(@ "hash_8be4acc5eebb19ca", 1);
  setdvarifuninitialized(@ "hash_e65dc975d6fcfca0", 0);
  level._effect["vfx_br_ac130_clouds"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_ac130_clouds");

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/mgl/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
    level._effect["vfx_br_infil_cloud_anim_moving"] = loadfx("vfx/mgl/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
    return;
  }

  level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
}

function function_5df8c6abd0b861cd() {
  if(!function_b4e9d46918f067bb()) {
    return;
  }

  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled) && !istrue(level.var_59ff09549058dda2)) {
    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("createC130PathStruct")) {
      c130pathstruct = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("createC130PathStruct");
    } else {
      c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path();
    }
  }

  level.var_a696a93807abb2fd.c130pathstruct = c130pathstruct;
}

function postprematch() {
  if(!function_b4e9d46918f067bb()) {
    return;
  }

  level.br_c130spawndone = 0;
  level.br_latejoininfilready = 0;

  if(!istrue(level.br_infils_disabled)) {
    setdvarifuninitialized(@ "hash_fc6ebbeb3426b854", 0);

    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("infilSequence")) {
      scripts\mp\gametypes\br_gametypes::runbrgametypefunc("infilSequence");
    } else {
      players = undefined;

      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getInfilPlayers")) {
        players = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getInfilPlayers");
      }

      assert(isDefined(level.var_a696a93807abb2fd.c130pathstruct));

      if(!getdvarint(@ "hash_fc6ebbeb3426b854", 0)) {
        beginbrc130playeraniminfilsequence(level.var_a696a93807abb2fd.c130pathstruct, "player", players);
      } else {
        beginbrc130playeraniminfilsequence(level.var_a696a93807abb2fd.c130pathstruct, "script_model");
      }

      level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();
    }

    return;
  }

  scripts\mp\flags::gameflagset("prematch_fade_done");
  waitframe();
  level.allowprematchdamage = 0;
  players = undefined;

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("getInfilPlayers")) {
    players = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("getInfilPlayers");
  }

  if(!isDefined(players) || players.size > 0) {
    waitforc130andforcespawnallplayers(players);
  }

  foreach(player in level.players) {
    player.plotarmor = undefined;
  }

  gameflagset("br_ready_to_jump");
}

function latespawnplayer() {
  self endon("disconnect");

  if(!function_b4e9d46918f067bb()) {
    return;
  }

  player = self;
  istutorial = scripts\mp\gametypes\br_public::istutorial() || scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf();

  if(getDvar(@ "hash_215446c7a0657e95") != "" || istutorial) {
    oldlatespawnplayer();
  } else if(!isalive(player)) {
    infilskipped = getdvarint(@ "hash_25ad2925d6075c8f", 0) == 2;
    latejoininfil = !istrue(level.br_c130spawndone) || !isDefined(level.latejoinersanimstruct);

    if(!infilskipped && latejoininfil) {
      var_a2e7df444a8aafa9 = isbot(player) && scripts\mp\gametypes\br_public::isbrpracticemode();

      while(!istrue(level.br_latejoininfilready) && !var_a2e7df444a8aafa9) {
        if(!var_a2e7df444a8aafa9) {
          player scripts\mp\gametypes\br::function_258c4f40dee8189a();
          player setclientomnvar("ui_br_transition_type", 4);
        }

        wait 0.3;
      }

      player thread latespawnsnatchtoc130();
    } else {
      player.br_isininfil = 0;
      player.br_infilstarted = 1;
      isuibot = player scripts\mp\gametypes\br::function_7dbb8165d792b06c();

      if(infilskipped && isbot(player) && !isuibot) {
        player.jumped = 1;
        player scripts\mp\playerlogic::addtoalivecount();
      }

      if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
        teamplayers = getteamdata(player.team, "players");

        if(!isDefined(teamplayers) || teamplayers.size == 0) {
          teamplayers = [self];
        }

        setupbrsquadleader(teamplayers);
      }

      if(isuibot) {
        player thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
      } else {
        player thread missedinfilplayerhandler();
      }
    }
  } else {
    assertmsg("<dev string:x1c>");
  }

  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_br_extended_load_screen", 0);
}

function oldlatespawnplayer() {
  self endon("disconnect");

  if(!function_b4e9d46918f067bb()) {
    return;
  }

  player = self;
  println("<dev string:x69>");

  if(!isalive(player)) {
    player scripts\mp\playerlogic::spawnplayer(0);
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
    if(level.teambased) {
      teamplayers = getteamdata(player.team, "players");

      if(!isDefined(teamplayers) || teamplayers.size == 0) {
        teamplayers = [self];
      }

      brsquadleader = setupbrsquadleader(teamplayers);

      if(isDefined(brsquadleader)) {
        println("<dev string:x8d>");
        registerbrsquadleaderjumpcommands(brsquadleader);
      } else {
        println("<dev string:xcb>");
      }
    } else {
      player scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 2);
      registerbrsquadleaderjumpcommands(player);
    }
  }

  player.br_infilstarted = 1;
}

function latespawnsnatchtoc130() {
  player = self;
  player endon("disconnect");

  if(!isalive(player)) {
    player.latetoinfil = 1;
    player scripts\mp\playerlogic::spawnplayer(0);
  }

  player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
  player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_legacy::lateSpawnSnatchToC130()");
  player.latetoinfil = undefined;
  player freezecontrols(1);

  if(player scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
    player.infilanimindex = 1;
  }

  if(!isDefined(player.infilanimindex) && level.teambased) {
    teamplayers = getteamdata(player.team, "players");
    possibleindices = [];

    for(i = 0; i < teamplayers.size - 1; i++) {
      possibleindices[i] = i + 2;
    }

    for(i = 0; i < possibleindices.size; i++) {
      used = 0;

      foreach(teamplayer in teamplayers) {
        if(teamplayer != player && teamplayer scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
          continue;
        }

        if(isDefined(teamplayer.infilanimindex) && isDefined(possibleindices[i]) && teamplayer.infilanimindex == possibleindices[i]) {
          used = 1;
          break;
        }
      }

      if(!used) {
        player.infilanimindex = possibleindices[i];
        break;
      }
    }
  }

  player playerjoininfil();
  player playerlinktopositionent(level.latejoinersanimstruct);
  player.c130 = level.latejoinersanimstruct.movingc130;
  player setOrigin(level.latejoinersanimstruct.movingc130.origin);
  player playerplayinfilloopanim(level.latejoinersanimstruct);
  waitframe();

  if(isDefined(player.team) && level.teambased) {
    teamplayers = getteamdata(player.team, "players");

    foreach(otherplayer in teamplayers) {
      player showtoplayer(otherplayer);
      otherplayer showtoplayer(player);
    }
  }

  if(!isbot(player)) {
    scripts\mp\gametypes\br_c130::orbitcam(level.br_ac130);
  }

  wait 0.5;
  player freezecontrols(0);
  player setclientomnvar("ui_br_transition_type", 0);
  player.br_infilstarted = 1;
}

function playerlinktopositionent(animstruct) {
  if(isai(self) && !istrue(self.hasspawned)) {
    return;
  }

  if(!isDefined(self.infilanimindex)) {
    self.infilanimindex = 1;
  }

  player_link_tag = "j_prop_" + self.infilanimindex;

  if(isent(animstruct.playerpositionents[player_link_tag])) {
    self playerlinkTo(animstruct.playerpositionents[player_link_tag], "tag_player");
  }
}

function function_35be50043c0855ae() {
  return getdvarint(@ "hash_9cea5b03e26fe23", 0);
}

function playinfilplayeranims(animstruct, players) {
  var_e4c30d4c191baae = getanimlength(level.br_anim["sdr_mp_infil_ac130_redux_player1"]);

  if(function_35be50043c0855ae()) {
    var_e4c30d4c191baae = 0;
  }

  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player thread[[level.parachutetakeweaponscb]]();
    player scripts\mp\gametypes\br::playerexecutionsdisable();
    player.c130 = animstruct.movingc130;
    player.plotarmor = 1;
    player playerlinktopositionent(animstruct);
    var_a1483d10035e2a59 = "sdr_mp_infil_ac130_redux_player" + player.infilanimindex;
    player playanimscriptsceneevent("scripted_scene", var_a1483d10035e2a59);
  }

  wait var_e4c30d4c191baae;
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player thread playerplayinfilloopanim(animstruct);
  }
}

function playerplayinfilloopanim(animstruct) {
  if(!isDefined(self.infilanimindex)) {
    self.infilanimindex = 1;
  }

  var_a1483d10035e2a59 = "sdr_mp_infil_ac130_loop_pl0" + self.infilanimindex;
  self playanimscriptsceneevent("scripted_scene", var_a1483d10035e2a59);
  thread watchinfiljumpanim(animstruct);
}

function watchinfiljumpanim(animstruct) {
  self endon("death_or_disconnect");

  if(!isDefined(level.infiljumpentsspawned)) {
    level.infiljumpentsspawned = 0;
  }

  self.hasspawnweapons = 0;
  self waittill("br_jump");
  teamplayers = getteamdata(self.team, "players");
  jumpplayers = [];

  if(self.jumptype == "leader") {
    foreach(player in teamplayers) {
      if(isDefined(player.infilanimindex)) {
        jumpplayers[jumpplayers.size] = player;
      }
    }
  } else if(self.jumptype == "solo" || self.jumptype == "outOfBounds") {
    jumpplayers = [self];
  }

  var_bee01cb211c7e185 = jumpplayers.size > 0;

  if(var_bee01cb211c7e185) {
    var_a2117ea816a8b7f1 = getdvarint(@ "hash_8be4acc5eebb19ca", 1) != 0;

    if(level.infiljumpentsspawned >= 100) {
      var_a2117ea816a8b7f1 = 0;
    }

    shouldteleport = undefined;

    if(var_a2117ea816a8b7f1) {
      shouldteleport = 0;
      [var_8dec95713ec1f7ba, var_4d261ef98868b4e6, var_66809387054fc02a] = getanimsforplanefacing(animstruct);
      var_9b145eb55513dbb5["parent"] = spawn("script_model", animstruct.movingc130.origin);
      level.infiljumpentsspawned++;
      var_9b145eb55513dbb5["parent"] setModel("generic_prop_x10");
      var_9b145eb55513dbb5["parent"] linkTo(animstruct.movingc130, "tag_body", (0, 0, 0), (0, 0, 0));

      foreach(player in jumpplayers) {
        if(!isDefined(player.infilanimindex)) {
          player.infilanimindex = 1;
        }

        player_link_tag = "j_prop_" + player.infilanimindex + 2;
        var_9b145eb55513dbb5[player_link_tag] = spawn("script_model", var_9b145eb55513dbb5["parent"] gettagorigin(player_link_tag));
        level.infiljumpentsspawned++;
        var_9b145eb55513dbb5[player_link_tag] setModel("tag_player");
        var_9b145eb55513dbb5[player_link_tag] linkTo(var_9b145eb55513dbb5["parent"], player_link_tag, (0, 0, 0), (0, 0, 0));
        player playerlinkTo(var_9b145eb55513dbb5[player_link_tag], "tag_player");
        player scripts\cp_mp\utility\player_utility::function_6fb380927695ee76(1);
        player playanimscriptsceneevent("scripted_scene", var_66809387054fc02a);
        player.infilanimindex = undefined;
        player.var_db122a8941dfee14 = undefined;
        player playlocalsound("evt_br_infil_jump_stinger");
        level thread playjumpsoundtosquad(player);
      }

      var_9b145eb55513dbb5["parent"] scriptmodelplayanim(var_8dec95713ec1f7ba, "prop");
      var_7a79e5c326955318 = getanimlength(var_4d261ef98868b4e6);
      var_886f7978500acb10 = 1;
      var_7a79e5c326955318 = max(var_7a79e5c326955318, var_886f7978500acb10 + 0.1);
      wait var_7a79e5c326955318 - var_886f7978500acb10;

      foreach(player in jumpplayers) {
        player cameradefault();
      }

      wait var_886f7978500acb10;

      foreach(ent in var_9b145eb55513dbb5) {
        ent delete();
        level.infiljumpentsspawned--;
      }
    } else {
      shouldteleport = 1;
      waittillframeend();
    }

    foreach(player in jumpplayers) {
      player.infilanimindex = undefined;
      player.var_db122a8941dfee14 = undefined;
      player stopanimscriptsceneevent();
      player notify("infil_jump_done");
      player scripts\mp\gametypes\br::playerexecutionsenable();
      player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onInfilJumpCompleted");
    }

    if(shouldteleport) {
      waitframe();

      if(isDefined(animstruct.movingc130)) {
        if(isDefined(animstruct.movingc130.playeroffsets) && isDefined(animstruct.movingc130.currentplayeroffset)) {
          foreach(player in jumpplayers) {
            offset = animstruct.movingc130.playeroffsets[animstruct.movingc130.currentplayeroffset];
            player setOrigin(animstruct.movingc130.origin + offset, 1, 1);
            animstruct.movingc130.currentplayeroffset++;

            if(animstruct.movingc130.currentplayeroffset == animstruct.movingc130.playeroffsets.size) {
              animstruct.movingc130.currentplayeroffset = 0;
            }

            player scripts\cp_mp\utility\player_utility::function_6fb380927695ee76(1);
            level thread playjumpsoundtosquad(player);
          }
        }
      }
    }
  }
}

function getanimsforplanefacing(animstruct) {
  var_522a77434d41564a = self getplayerangles(1);
  playerforward = anglesToForward(var_522a77434d41564a);
  planeforward = anglesToForward(animstruct.movingc130.angles);
  planeright = anglestoright(animstruct.movingc130.angles);
  dotforward = vectordot(playerforward, planeforward);
  dotright = vectordot(playerforward, planeright);
  cos45 = cos(45);

  if(dotforward < -1 * cos45) {
    return ["sdr_mp_infil_ac130_jump_genpropx10", level.br_anim["sdr_mp_infil_ac130_jump_genpropx10"], "sdr_mp_infil_ac130_jump"];
  }

  if(dotright > cos45) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_l", level.br_anim["sdr_mp_infil_ac130_jump_genpropx10_90_l"], "sdr_mp_infil_ac130_jump_90_l"];
  }

  if(dotright < -1 * cos45) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_90_r", level.br_anim["sdr_mp_infil_ac130_jump_genpropx10_90_r"], "sdr_mp_infil_ac130_jump_90_r"];
  }

  if(dotright > 0) {
    return ["sdr_mp_infil_ac130_jump_genpropx10_180_l", level.br_anim["sdr_mp_infil_ac130_jump_genpropx10_180_l"], "sdr_mp_infil_ac130_jump_180_l"];
  }

  return ["sdr_mp_infil_ac130_jump_genpropx10_180_r", level.br_anim["sdr_mp_infil_ac130_jump_genpropx10_180_r"], "sdr_mp_infil_ac130_jump_180_r"];
}

function playjumpsoundtosquad(player) {
  aliasname = "evt_br_infil_squadmate_jump";

  if(player scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
    aliasname = "evt_br_infil_squad_leader_jump";
  }

  player playsoundtoteam(aliasname, player.team, player);
}

function missedinfilplayerhandler() {
  player = self;
  player.br_infilstarted = 1;
  player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  player scripts\mp\gametypes\br_gulag::playergulagautowin("missedInfil", undefined, undefined, 1);
}

function playerjoininfil() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("joining_Infil");
  player = self;
  player.br_infilstarted = 1;

  if(!istrue(level.c130inbounds)) {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  player.health = player.maxhealth;
  player scripts\mp\gametypes\br_c130::spawnplayertoc130();
  player playersetupcontrolsforinfil();
  player scripts\mp\gametypes\br_public::updatebrscoreboardstat("isInInfilPlane", 1);
  level.infilstruct.playersinc130++;
  player scripts\mp\gametypes\br_public::function_64fa4c213439177f();
  player thread playercleanupinfilondisconnect();
}

function playersetupcontrolsforinfil(soloonly) {
  if(!isDefined(soloonly)) {
    soloonly = 0;
  }

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!soloonly) {
    self notifyonplayercommand("halo_jump_c130", "+gostand");
  } else {
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");
  }

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

function playercleanupinfilondisconnect() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0) {
    level.infilstruct.playersinc130--;
  }
}

function beginbrc130playeraniminfilsequence(c130pathstruct, infil_anim_type, players) {
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player setallstreamloaddist(-1);
  }

  level.infilstruct = spawnStruct();
  level.infilstruct.playersinc130 = 0;

  if(!isDefined(c130pathstruct)) {
    c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path();
  }

  level.infilstruct.c130pathstruct = c130pathstruct;
  scripts\mp\gametypes\br_c130::spawnc130(undefined, undefined, undefined, level.infilstruct.c130pathstruct);
  animstruct = buildac130infilanimstruct(level.br_ac130, infil_anim_type);
  level.latejoinersanimstruct = animstruct;
  infilvideopreload(players);

  if(isDefined(level.preinfilstreamfunc)) {
    [[level.preinfilstreamfunc]](animstruct);
  }

  level.infilcinematicactive = 1;
  level.allowprematchdamage = 0;
  level.br_ac130 thread gunship_updateplayercount();
  infilplayers = ter_op(isDefined(players), players, level.players);
  transitionplayerstoac130cinematic(infilplayers, infil_anim_type, animstruct.staticc130);

  if(scripts\mp\gametypes\br_public::isbrpracticemode() || scripts\mp\gametypes\br_public::isdmzbotpracticematch()) {
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(isDefined(player) && isPlayer(player)) {
        player notify("play_intro");
      }
    }
  }

  infilvideoplay(players);
  infilvideowaituntilcomplete(players);
  level thread infilallfadetoblack(0, 3.45, 0.6, undefined, players);
  playac130infilanim(animstruct, players);
  infilplayers = ter_op(isDefined(players), players, level.players);
  transitionplayersoutofac130cinematic(infilplayers, infil_anim_type);
  level.infilcinematicactive = 0;
  level.infilstruct.infil_anim_type = infil_anim_type;
  thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onInfilSequenceEnd", players);
  scripts\mp\gametypes\br_public::brleaderdialog("match_start", 0, players);
  istutorial = scripts\mp\gametypes\br_public::istutorial() || scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf();

  if(!istutorial) {
    var_cb130a107612fddf = getDvar(@ "hash_215446c7a0657e95") == "";
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!istrue(player.br_isininfil) && var_cb130a107612fddf) {
        continue;
      }

      player thread playerjoininfil();

      if(player isplayerheadless()) {
        registerheadlessinfil(player);
      }
    }

    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("addToC130Infil")) {
      level.br_ac130 scripts\mp\gametypes\br_gametypes::runbrgametypefunc("addToC130Infil");
    }
  }

  if(isDefined(level.headlessinfilplayers)) {
    level thread headlessinfils();
  }
}

function infilvideopreload(players) {
  videoname = "mp_donetsk_c130_intro";

  if(!isDefined(players)) {
    preloadcinematicforall(videoname);
    return;
  }

  foreach(player in players) {
    if(isDefined(player)) {
      player preloadcinematicforplayer(videoname);
    }
  }
}

function function_f94830ac89cbe22c(waittime) {
  wait waittime;
  self stopsounds();
}

function infilvideoplay(players) {
  infilplayers = ter_op(isDefined(players), players, level.players);
  allplayers = level.players.size == infilplayers.size;
  thread scripts\mp\music_and_dialog::stopsuspensemusic();

  if(allplayers) {
    setglobalsoundcontext("lobby_fade", "", 2);
  }

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!allplayers) {
      player setentitysoundcontext("lobby_fade", "", 2);
    }

    player playlocalsound("br_infil_part1_lr");

    if(function_35be50043c0855ae()) {
      player thread function_f94830ac89cbe22c(7);
    }

    player clearsoundsubmix("mp_br_lobby_fade", 1.5);
    player setsoundsubmix("solo_cin_igc_music", 0.5);
    br_infil_intro = function_17ee301cf0b5ba85("br_infil_intro");
    player setplayermusicstate(br_infil_intro);
  }

  videoname = "mp_donetsk_c130_intro";

  if(allplayers) {
    playcinematicforall(videoname);
  } else {
    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player playcinematicforplayer(videoname);
    }
  }

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!istrue(player.latetoinfil)) {
      player setclientomnvar("ui_br_bink_overlay_state", 3);
    }
  }
}

function infilvideocompletecallback(channel, val) {
  if(channel == "bink_complete") {
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self stopcinematicforplayer();
  }
}

function infilvideowaituntilcomplete(players) {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&infilvideocompletecallback);
  time = 3.2;
  wait time;
  infilplayers = ter_op(isDefined(players), players, level.players);

  if(isDefined(level.var_9d615a366ec2fb6f)) {
    level.var_9d615a366ec2fb6f = undefined;
  }

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player notify("beginC130");
  }

  if(isDefined(level.throwingknives)) {
    foreach(throwingknife in level.throwingknives) {
      if(isDefined(throwingknife)) {
        throwingknife thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
      }
    }
  }
}

function gunship_updateplayercount() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");
  var_512e1c239c8f0640 = getdvarint(@ "hash_57377f405b99ecd2", 0);

  if(var_512e1c239c8f0640) {
    level.infilstruct.var_129d4a6c887fcfa5 = level.players.size;

    if(isDefined(level.var_7b37b2193f163b9b) && isDefined(level.var_7b37b2193f163b9b.uibots)) {
      level.infilstruct.var_129d4a6c887fcfa5 += level.var_7b37b2193f163b9b.uibots.size;
    }
  }

  while(true) {
    if(var_512e1c239c8f0640) {
      setomnvar("ui_br_players_left_in_plane", level.infilstruct.var_129d4a6c887fcfa5);
    } else {
      setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);
    }

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

function spawnplayerpositionparentent(animstruct, ac130) {
  animstruct.playerpositionents["parent"] = spawn("script_model", ac130.origin);
  animstruct.playerpositionents["parent"] setModel("generic_prop_x5");
  animstruct.playerpositionents["parent"] linkTo(ac130, "", (0, 0, 0), (0, 0, 0));
}

function spawnplayerpositionent(animstruct, prop_tag) {
  animstruct.playerpositionents[prop_tag] = spawn("script_model", animstruct.playerpositionents["parent"] gettagorigin(prop_tag));
  animstruct.playerpositionents[prop_tag] setModel("tag_player");
  animstruct.playerpositionents[prop_tag] linkTo(animstruct.playerpositionents["parent"], prop_tag, (0, 0, 0), (0, 0, 0));
}

function buildac130infilanimstruct(movingc130, infil_anim_type) {
  animstruct = spawnStruct();

  if(isDefined(movingc130)) {
    movingc130.animstruct = animstruct;
    animstruct.movingc130 = movingc130;
  }

  animstruct.staticc130 = getEnt("infil_plane", "script_noteworthy");

  if(isDefined(animstruct.staticc130)) {
    animstruct.staticc130 show();
  } else {
    animstruct.staticc130 = spawn("script_model", getdvarvector(@ "br_infil_anim_pos", (0, 0, 0)));
    animstruct.staticc130 setModel("veh8_mil_air_acharlie130_magma_animated");
    animstruct.staticc130.cleanme = 1;
  }

  animstruct.cameraent = spawn("script_model", animstruct.staticc130.origin);
  animstruct.cameraent setModel("generic_prop_x5");

  if(isDefined(movingc130)) {
    animstruct.cameraentmoving = spawn("script_model", animstruct.movingc130.origin);
    animstruct.cameraentmoving setModel("generic_prop_x5");
    animstruct.cameraentmoving linkTo(animstruct.movingc130, "tag_origin", (0, 0, 0), (0, 0, 0));
    animstruct.cameraentmoving forcenetfieldhighlod(1);
  }

  spawnplayerpositionparentent(animstruct, animstruct.staticc130);

  if(infil_anim_type == "script_model") {
    animstruct.playerslot1 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot1 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot2 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot2 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot3 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot3 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot4 = spawn("script_model", animstruct.staticc130.origin);
    animstruct.playerslot4 setModel("fullbody_usmc_ar_br_infil");
    animstruct.playerslot1 linkTo(animstruct.playerpositionents["parent"], "j_prop_1", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot2 linkTo(animstruct.playerpositionents["parent"], "j_prop_2", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot3 linkTo(animstruct.playerpositionents["parent"], "j_prop_3", (0, 0, 0), (0, 0, 0));
    animstruct.playerslot4 linkTo(animstruct.playerpositionents["parent"], "j_prop_4", (0, 0, 0), (0, 0, 0));
    animstruct.infil_anim_type = "script_model";
  } else {
    var_589033938efc0461 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4"];

    foreach(prop_tag in var_589033938efc0461) {
      spawnplayerpositionent(animstruct, prop_tag);
    }

    animstruct.infil_anim_type = "player";
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    animstruct.aidoorchief = spawn("script_model", animstruct.staticc130.origin);
    animstruct.aidoorchief setModel("body_mp_western_otter_3_1_lod1");
    head = spawn("script_model", animstruct.aidoorchief gettagorigin("j_neck"));
    head setModel("head_mp_eastern_metalghost_1_1");
    head linkTo(animstruct.aidoorchief, "j_neck", (-9, 1, 0), (0, 0, 0));
  } else {
    animstruct.aidoorchief = spawn("script_model", animstruct.staticc130.origin);
    animstruct.aidoorchief setModel("fullbody_usmc_ar_br_infil");
  }

  if(isDefined(movingc130)) {
    animstruct.movingc130.innards linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
  }

  animstruct.aidoorchief linkTo(animstruct.playerpositionents["parent"], "j_prop_5", (0, 0, 0), (0, 0, 0));
  animstruct.cameraent linkTo(animstruct.staticc130, "", (0, 0, 0), (0, 0, 0));
  animstruct.cloudanimfx = spawnfx(level._effect["vfx_br_infil_cloud_anim"], animstruct.staticc130.origin);

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    animstruct.var_352d21900a2aa86f = spawnfx(level._effect["vfx_br_infil_cloud_anim_moving"], animstruct.movingc130.origin + (-500, 0, 0));
  }

  return animstruct;
}

function setuphudelemninfilblack(hudelem) {
  hudelem.x = 0;
  hudelem.y = 0;
  hudelem setshader("black", 640, 480);
  hudelem.alignx = "left";
  hudelem.aligny = "top";
  hudelem.horzalign = "fullscreen";
  hudelem.vertalign = "fullscreen";
  hudelem.sort = -1;
  hudelem setshowinrealism(1);
}

function infilallfadetoblack(fadeintime, timeblack, fadeouttime, var_bfd3cec846e4fbf7, players, var_69618eb692fc8288) {
  if(!isDefined(var_69618eb692fc8288)) {
    var_69618eb692fc8288 = 0;
  }

  infilplayers = ter_op(isDefined(players), players, level.players);
  allplayers = level.players.size == infilplayers.size;

  if(allplayers && !isDefined(level.infilblackoverlay)) {
    level.infilblackoverlay = newhudelem();
    setuphudelemninfilblack(level.infilblackoverlay);
  } else if(!allplayers) {
    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player.infilblackoverlay = newclienthudelem(player);
      setuphudelemninfilblack(player.infilblackoverlay);
    }
  }

  if(isDefined(fadeintime) && fadeintime > 0) {
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!var_69618eb692fc8288) {
        player setsoundsubmix("iw8_br_infil_fadeout", 0);
        player setsoundsubmix("mp_br_infil_music", 0);
      }

      if(!allplayers) {
        player.infilblackoverlay.alpha = 0;
        player.infilblackoverlay fadeovertime(fadeintime);
        player.infilblackoverlay.alpha = 1;
      }
    }

    if(allplayers) {
      level.infilblackoverlay.alpha = 0;
      level.infilblackoverlay fadeovertime(fadeouttime);
      level.infilblackoverlay.alpha = 1;
    }

    wait fadeintime;
  }

  if(allplayers) {
    level.infilblackoverlay.alpha = 1;
  }

  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!var_69618eb692fc8288) {
      player setsoundsubmix("mp_br_infil_anim", 0);
      player setsoundsubmix("mp_br_infil_ac130", 0);
    }

    if(!allplayers) {
      player.infilblackoverlay.alpha = 1;
    }
  }

  if(isDefined(var_bfd3cec846e4fbf7)) {
    level waittill(var_bfd3cec846e4fbf7);
  }

  if(isDefined(timeblack) && timeblack > 0) {
    wait timeblack;
  }

  if(isDefined(fadeouttime) && fadeouttime > 0) {
    if(allplayers) {
      level.infilblackoverlay.alpha = 1;
      level.infilblackoverlay fadeovertime(fadeouttime);
      level.infilblackoverlay.alpha = 0;
    }

    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!var_69618eb692fc8288) {
        player setclienttriggeraudiozone("mp_br_c130_infil_int", fadeouttime);
        player clearsoundsubmix("iw8_br_infil_fadeout", 2);
        player notify("deaths_door_exit");
        player scripts\common\damage_effects::function_a2b4e6088394bade();
      }

      if(!allplayers) {
        player.infilblackoverlay.alpha = 1;
        player.infilblackoverlay fadeovertime(fadeouttime);
        player.infilblackoverlay.alpha = 0;
      }
    }

    wait fadeouttime;
  }

  if(allplayers) {
    level.infilblackoverlay.alpha = 0;
    return;
  }

  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.infilblackoverlay)) {
      player.infilblackoverlay destroy();
    }

    player.infilblackoverlay = undefined;
  }
}

function transitionplayerstoac130cinematic(players, infil_anim_type, c130) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(c130)) {
      player.c130 = level.br_ac130;
    }

    if(!scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      player utility::hidehudenable();
    }

    if(player isnoclip()) {
      player noclip();
    }

    if(player isufo()) {
      player ufo();
    }
  }

  scripts\mp\deathicons::removealldeathicons();
  setomnvar("ui_hide_player_icons", 1);
  thread infilallfadetoblack(1, 1.5, 1, "prematch_respawn_finished", players);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player predictstreamposuntilcleared(c130.origin);
  }

  level.infiltransistioning = 1;
  waitandpause(1);
  waitframe();
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  setomnvar("ui_in_infil", 1);
  scripts\mp\flags::gameflagset("prematch_fade_done");
  waitforc130andforcespawnallplayers(players);
  level notify("prematch_respawn_finished");

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.sessionstate) || player.sessionstate == "spectator") {
      continue;
    }

    scripts\mp\gametypes\br_gametypes::function_d72afaccedfc946e("onPlayerTeleport", player, player.origin, c130.origin, "c130");
    player setOrigin(c130.origin);

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      player setclientomnvar("ui_options_menu", 0);
    }
  }

  waitandpause(1.5);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player clearpredictedstreampos();
    player endprematchskydiving();
    player.br_isininfil = 1;

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      player setclientomnvar("ui_options_menu", -1);
    }
  }

  if(infil_anim_type == "script_model") {
    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
      player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_legacy::transitionPlayersToAC130Cinematic()");
    }
  }
}

function waitforc130andforcespawnallplayers(players) {
  println("<dev string:x10b>");
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player endprematchskydiving();

    if(!isalive(player)) {
      player c130forcespawnplayer();
    } else {
      player.br_infilstarted = 1;
    }

    if(!isDefined(player)) {
      continue;
    }

    if(istrue(player.br_iseliminated)) {
      scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    }

    player notify("beginC130");
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
    if(level.teambased) {
      foreach(team in level.teamnamelist) {
        teamplayers = getteamdata(team, "players");
        brsquadleader = setupbrsquadleader(teamplayers);

        if(isDefined(brsquadleader)) {
          registerbrsquadleaderjumpcommands(brsquadleader);
          brsquadleader thread watchbrsquadleaderdisconnect(team);
        }

        scripts\mp\gametypes\br::updatesquadleaderpassstateforteam(team);
      }
    } else {
      infilplayers = ter_op(isDefined(players), players, level.players);

      foreach(player in infilplayers) {
        if(isDefined(player)) {
          registerbrsquadleaderjumpcommands(player);
        }
      }
    }
  }

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numLives"), 1);
  }

  level.snatchspawnalltoc130done = 1;
}

function c130forcespawnplayer() {
  self endon("disconnect");

  if(self.team == "codcaster") {
    return;
  }

  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  println("<dev string:x142>");
  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

function transitionplayersoutofac130cinematic(players, infil_anim_type) {
  scriptmodeltype = infil_anim_type == "script_model";

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player.instantclassswapallowed = 1;

    if(get_int_or_0(player.hidehudenabled) > 0) {
      player utility::hidehuddisable();
    }

    player visionsetfadetoblackforplayer("", 1);

    if(scriptmodeltype) {
      player scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
      player scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("br_infils_legacy::transitionPlayersOutOfAC130Cinematic()");
    }
  }

  setomnvar("ui_in_infil", -1);
  level.infiltransistioning = undefined;
}

function clearsoundsubmixmpbrinfilac130(players) {
  waitandpause(7.7);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player clearsoundsubmix("mp_br_infil_ac130", 30);
  }
}

function clearsoundsubmixmpbrinfilanim(players) {
  waitandpause(0.65);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player clearsoundsubmix("mp_br_infil_anim", 3);
  }
}

function clearsoundsubmixfadetoblackamb(players) {
  waitandpause(0.5);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 1);
  }
}

function setsoundsubmixfadetoblackamb(players) {
  waitandpause(2);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player clearsoundsubmix("solo_cin_igc_music", 0.5);
    player setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2);
  }
}

function playac130infilanim(animstruct, players) {
  thread setsoundsubmixfadetoblackamb(players);
  playac130animinternal(animstruct, players);
  transitionac130tomovinganim(animstruct, players);
  endac130infilanimsinternal(animstruct, players);
}

function playac130animinternal(animstruct, players) {
  animstruct endon("stopScene");
  forceindex = undefined;

  forceindex = getdvarint(@ "hash_441165c7b355dd1b", -1);

  if(animstruct.infil_anim_type == "player") {
    if(!isDefined(players)) {
      foreach(team in level.teamnamelist) {
        teamplayers = getteamdata(team, "players");
        possibleindices = [1, 2, 3, 4];

        foreach(index, player in teamplayers) {
          player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
          player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_legacy::playAC130AnimInternal() - if");
          player.infilanimindex = possibleindices[index % possibleindices.size];

          if(forceindex != -1) {
            player.infilanimindex = forceindex;
          }

          foreach(otherplayer in teamplayers) {
            player showtoplayer(otherplayer);
          }
        }
      }
    } else {
      foreach(player in players) {
        if(!isDefined(player)) {
          continue;
        }

        player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
        player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_legacy::playAC130AnimInternal() - else");
        player showtoplayer(player);
        player.infilanimindex = 1;
      }
    }
  } else {
    animindex = forceindex;

    if(animindex < 0) {
      animindex = 1;
    }

    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player.infilanimindex = animindex;
    }
  }

  var_e74da054403180a2 = 34;
  var_5eea6039c4f26fdf = 5.6;
  var_108437a9e3168337 = 50.7;
  var_63916e6c46c30b92 = 2;
  var_5004850b0ec526a1 = 4;

  var_e74da054403180a2 = getdvarfloat(@ "hash_3f7dc593f9b4e95c", var_e74da054403180a2);
  var_5eea6039c4f26fdf = getdvarfloat(@ "hash_679c9529942a3229", var_5eea6039c4f26fdf);
  var_108437a9e3168337 = getdvarfloat(@ "hash_601d2c6b86673b4", var_108437a9e3168337);
  var_63916e6c46c30b92 = getdvarfloat(@ "hash_dda086f6c3d3840f", var_63916e6c46c30b92);
  var_5004850b0ec526a1 = getdvarfloat(@ "hash_e3dc33638e3c4ed4", var_5004850b0ec526a1);

  starttimesec = ter_op(function_35be50043c0855ae(), 12.5, 0);
  animstruct.cameraent scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera", starttimesec);

  if(isDefined(animstruct.cameraentmoving)) {
    animstruct.cameraentmoving scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_cam", "camera", starttimesec);
  }

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 stoploopsound();
  }

  animstruct.aidoorchief hide();
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player setsoundsubmix("mp_br_infil_anim", 0);
    player setsoundsubmix("mp_br_infil_music", 0);
    player setsoundsubmix("mp_br_infil_ac130", 0);
    player setclienttriggeraudiozone("mp_br_c130_infil_int", 1);
    animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
    player cameraunlink();
    player cameralinkTo(animstruct.cameraent, animstruct.cameraentlinktag, 1, 1);
    player setclientdvar(@ "cg_fov", var_e74da054403180a2);
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield(var_5eea6039c4f26fdf, var_108437a9e3168337, var_63916e6c46c30b92, var_5004850b0ec526a1);
    player _freezelookcontrols(1);
    animstruct.aidoorchief showtoplayer(player);
  }

  thread clearsoundsubmixmpbrinfilanim(players);
  thread getlightingvalues();
  playFXOnTag(level._effect["vfx_br_ac130_clouds"], animstruct.staticc130, "tag_body");
  animstruct.staticc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "plane");
    animstruct.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_redux_players_ac130", "planeInnards");
  }

  animstruct.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_redux_character_link", "prop");

  if(animstruct.infil_anim_type == "script_model") {
    animstruct.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player1", "p1");
    animstruct.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player2", "p2");
    animstruct.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player3", "p3");
    animstruct.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_redux_player4", "p4");
  } else if(animstruct.infil_anim_type == "player") {
    thread playinfilplayeranims(animstruct, players);
  }

  animstruct.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_redux_doorchief", "doorchief");
  level thread offlight(animstruct);
  level thread redlight(animstruct);
  level thread greenlight(animstruct);
  level thread playerwind(animstruct, players);
  level thread cloud_cover(animstruct);
  level thread infil_light_dvars(animstruct);
  level thread delaystreamtomovingplane(animstruct, players);

  if(function_35be50043c0855ae()) {
    animstruct.cameraent waittillmatch("camera", "transition");
  } else {
    animstruct.cameraent waittill_match_or_timeout("camera", "transition", 30);
  }

  animstruct notify("infil_reset_light_dvars");
  level clearplayerwind(animstruct, players);
  whitefadeintime = 0.1;
  var_6dbf75f07032be02 = 0;
  whitefadeouttime = 0.2;
}

function transitionac130tomovinganim(animstruct, players) {
  var_d69c3085d8cf2730 = 65;
  var_decc5773bf6d2dc5 = 14;
  var_6642ae82a680f3e9 = 35;
  var_ce7b1c2d2f4235c0 = 2;
  var_5e0f870c68f3cfab = 4;

  var_d69c3085d8cf2730 = getdvarfloat(@ "hash_f80d61afa659d962", var_d69c3085d8cf2730);
  var_decc5773bf6d2dc5 = getdvarfloat(@ "hash_91844e25654ff137", var_decc5773bf6d2dc5);
  var_6642ae82a680f3e9 = getdvarfloat(@ "hash_12df3e4329486542", var_6642ae82a680f3e9);
  var_ce7b1c2d2f4235c0 = getdvarfloat(@ "hash_a5fccaf38e6c6141", var_ce7b1c2d2f4235c0);
  var_5e0f870c68f3cfab = getdvarfloat(@ "hash_78941d68c2877ae6", var_5e0f870c68f3cfab);

  if(isDefined(animstruct.cameraentmoving)) {
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player setallstreamloaddist(0);

      if(!isDefined(player.infilanimindex)) {
        player.infilanimindex = 1;
      }

      animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
      player cameraunlink();
      player cameralinkTo(animstruct.cameraentmoving, animstruct.cameraentlinktag, 1, 1);
      player setclientdvar(@ "cg_fov", var_d69c3085d8cf2730);
      player setphysicaldepthoffield(var_decc5773bf6d2dc5, var_6642ae82a680f3e9, var_ce7b1c2d2f4235c0, var_5e0f870c68f3cfab);
      player notify("infil_move");
    }

    thread clearsoundsubmixfadetoblackamb(players);
  } else {
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player setallstreamloaddist(0);
    }
  }

  if(isDefined(animstruct.cloudanimfx)) {
    if(isDefined(animstruct.movingc130)) {
      animstruct.cloudanimfx.origin = animstruct.movingc130.origin;
    }
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    if(isDefined(animstruct.var_352d21900a2aa86f) && isDefined(animstruct.movingc130)) {
      animstruct.var_352d21900a2aa86f.origin = animstruct.movingc130.origin;
    }
  }

  animstruct.staticc130 hide();
  animstruct.cameraent unlink();
  animstruct.playerpositionents["parent"] unlink();

  if(isDefined(animstruct.movingc130)) {
    animstruct.playerpositionents["parent"] linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
    animstruct.cameraent linkTo(animstruct.movingc130, "", (0, 0, 0), (0, 0, 0));
    animstruct.movingc130 notify("start_moving");
  }

  setomnvar("ui_hide_player_icons", 0);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player setclienttriggeraudiozone("mp_br_c130_infil_ext", 2);
  }

  thread clearsoundsubmixmpbrinfilac130(players);

  if(animstruct.infil_anim_type == "script_model") {
    animstruct.playerslot1 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl01", "p1");
    animstruct.playerslot2 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl02", "p2");
    animstruct.playerslot3 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl03", "p3");
    animstruct.playerslot4 scriptmodelplayanim("sdr_mp_infil_ac130_loop_pl04", "p4");
  }

  animstruct.aidoorchief scriptmodelplayanim("sdr_mp_infil_ac130_loop_doorchief", "doorchief");
  level thread playac130infilloopanims(animstruct);

  if(isDefined(animstruct.cameraentmoving)) {
    animstruct.cameraentmoving waittillmatch("camera", "end");
  }

  thread unfreezeplayercontrols(1.2, players);
}

function unfreezeplayercontrols(delaytime, players) {
  wait delaytime;
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player _freezelookcontrols(0);
  }
}

function endac130infilanimsinternal(animstruct, players) {
  thread lightsreset();
  stopFXOnTag(level._effect["vfx_br_ac130_clouds"], animstruct.staticc130, "tag_body");
  animstruct.staticc130 stoploopsound();

  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 playLoopSound("br_ac130_lp");
  }

  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player setallstreamloaddist(0);
    player cameraunlink();
    player setclientdvar(@ "cg_fov", 65);
    player disablephysicaldepthoffieldscripting();
    player setdof_default();
  }

  level thread stopstreamtomovingplane(animstruct, players);
}

function playac130infilloopanims(animstruct) {
  if(isDefined(animstruct.movingc130)) {
    animstruct.movingc130 scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "plane");
    animstruct.movingc130.innards scriptmodelplayanim("sdr_mp_infil_ac130_loop2_plane", "planeInnards");
  }

  animstruct.playerpositionents["parent"] scriptmodelplayanim("sdr_mp_infil_ac130_loop_genpropx10", "prop");
}

function offlight(animstruct) {
  var_620d0024527f448c = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(lightcontroller in var_620d0024527f448c) {
    lightcontroller setscriptablepartstate("light_blinking_slow", "light_off_hold", 1);
  }
}

function redlight(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "gored");
  var_620d0024527f448c = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(lightcontroller in var_620d0024527f448c) {
    lightcontroller setscriptablepartstate("light_blinking_slow", "light_on", 1);
  }
}

function greenlight(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "gogreen");
  var_620d0024527f448c = getentitylessscriptablearray("infil_blinking_light", "script_noteworthy");

  foreach(lightcontroller in var_620d0024527f448c) {
    lightcontroller setscriptablepartstate("light_blinking_slow", "light_jump", 1);
  }
}

function playerwind(animstruct, players) {
  if(function_35be50043c0855ae()) {
    return;
  }

  animstruct endon("stopScene");
  animstruct.staticc130 waittill_match_or_timeout("plane", "opendoor", 30);
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player) || isbot(player)) {
      continue;
    }

    player setwind("100", 1);
  }

  animstruct.aidoorchief setwind("100");
}

function clearplayerwind(animstruct, players) {
  infilplayers = ter_op(isDefined(players), players, level.players);

  foreach(player in infilplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player setwind("1");
    player.manualoverridewindmaterial = undefined;
  }

  animstruct.aidoorchief setwind("0");
}

function cloud_cover(animstruct) {
  animstruct endon("stopScene");
  animstruct.staticc130 waittillmatch("plane", "transitionstart");
  triggerfx(animstruct.cloudanimfx);

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    triggerfx(animstruct.var_352d21900a2aa86f);
  }
}

function infil_light_dvars(animstruct) {
  var_c3ed855fe7c983e3 = getdvarfloat(@ "hash_8667c0bb90c5bfc3");
  var_1800e53d66415e2d = getdvarint(@ "hash_63eb1893f96ac98d");
  var_5506432d2291c178 = getdvarint(@ "hash_1dde331a8e0153d8");
  var_488f9b9fe1ead0a6 = getdvarfloat(@ "sm_sunsamplesizenear");
  var_99598b81ba0f7519 = getdvarfloat(@ "hash_a589d43a51d526df");
  setDvar(@ "hash_8667c0bb90c5bfc3", 1000);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "sm_sunsamplesizenear", 0.25);
  setDvar(@ "hash_a589d43a51d526df", 0.5);
  animstruct waittill_either("infil_reset_light_dvars", "stopScene");
  setDvar(@ "hash_8667c0bb90c5bfc3", var_c3ed855fe7c983e3);
  setDvar(@ "hash_63eb1893f96ac98d", var_1800e53d66415e2d);
  setDvar(@ "hash_1dde331a8e0153d8", var_5506432d2291c178);
  setDvar(@ "sm_sunsamplesizenear", var_488f9b9fe1ead0a6);
  setDvar(@ "hash_a589d43a51d526df", var_99598b81ba0f7519);
}

function delaystreamtomovingplane(animstruct, players) {
  if(isDefined(animstruct.movingc130) && getdvarint(@ "hash_eb8a05afa7735e5f", 1) == 1) {
    delaytime = getdvarint(@ "hash_d01d0472d843d39e", 8);
    wait delaytime;
    streamorigin = animstruct.movingc130.origin;
    forward = getdvarint(@ "hash_7abcda2d7aabbe4c", 0);

    if(forward > 0) {
      dir = anglesToForward(animstruct.movingc130.angles);
      streamorigin = animstruct.movingc130.origin + dir * forward;
    }

    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player setpredictedstreamloaddist(0);
      player scripts\mp\gametypes\br_public::playerstreamhintlocation(streamorigin);
    }
  }
}

function stopstreamtomovingplane(animstruct, players) {
  if(isDefined(animstruct.movingc130) && getdvarint(@ "hash_eb8a05afa7735e5f", 1) == 1) {
    delaytime = getdvarint(@ "hash_b7c6d487b0f5506b", 5);
    wait delaytime;
    infilplayers = ter_op(isDefined(players), players, level.players);

    foreach(player in infilplayers) {
      if(!isDefined(player)) {
        continue;
      }

      player thread scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
    }
  }
}

function getlightingvalues() {}

function lightsreset() {}

function function_36ebdcea4a9d96ce(infil_anim_type) {
  level.infil_vignette_anim_type = infil_anim_type;
  var_b37140bfa8ba2461 = spawn("<dev string:x16b>", getdvarvector(@ "br_infil_anim_pos", (0, 0, 0)));
  var_b37140bfa8ba2461 setModel("<dev string:x17b>");
  var_b37140bfa8ba2461.cleanme = 1;
  var_b37140bfa8ba2461.innards = spawn("<dev string:x16b>", getdvarvector(@ "br_infil_anim_pos", (0, 0, 0)));
  var_b37140bfa8ba2461.innards setModel("<dev string:x1a6>");
  var_b37140bfa8ba2461.innards linkTo(var_b37140bfa8ba2461, "<dev string:x1ce>");
  var_b37140bfa8ba2461.innards.cleanme = 1;
  planestruct = buildac130infilanimstruct(var_b37140bfa8ba2461, infil_anim_type);
  transitionplayerstoac130cinematic(level.players, infil_anim_type, var_b37140bfa8ba2461);
  playac130infilanim(planestruct);
  transitionplayersoutofac130cinematic(level.players, infil_anim_type);
  scripts\mp\gametypes\br_public::cleanac130struct(planestruct);
  return planestruct;
}

function movetowithpause(point, time, accel, decel) {
  if(function_136f4218b1d719b9()) {
    thread movetopause(point, time, accel, decel);
    return;
  }

  self moveTo(point, time, accel, decel);
}

function rotatetowithpause(angles, time, accel, decel) {
  if(function_136f4218b1d719b9()) {
    thread rotatetopause(angles, time, accel, decel);
    return;
  }

  self rotateTo(angles, time, accel, decel);
}

function function_ec887b61b1baeba8(host) {
  animstruct = buildac130infilanimstruct(undefined, "<dev string:x16b>");
  models = [animstruct.cameraent, animstruct.staticc130, animstruct.playerpositionents["<dev string:x1d2>"], animstruct.playerslot1, animstruct.playerslot2, animstruct.playerslot3, animstruct.playerslot4, animstruct.aidoorchief];
  models = array_removeundefined(models);

  while(function_136f4218b1d719b9()) {
    function_9384c9ed097bf7b9(host, "<dev string:x1dc>");

    if(!function_136f4218b1d719b9()) {
      break;
    }

    startorigin = host.origin;
    startangles = host getplayerangles();
    animstruct.staticc130 show();
    animstruct.cameraentlinktag = undefined;
    function_3a001a7d1d9a2ca3(host, animstruct, models);
    transitionplayerstoac130cinematic([host], "<dev string:x16b>", animstruct.staticc130);
    thread playac130animinternal(animstruct);
    function_9384c9ed097bf7b9(host, "<dev string:x1ea>");
    endanimsequence(host, animstruct, models);
    endac130infilanimsinternal(animstruct);
    transitionplayersoutofac130cinematic([host], "<dev string:x16b>");
    host setOrigin(startorigin);
    host setplayerangles(startangles);
    wait 0.5;
  }

  scripts\mp\gametypes\br_public::cleanac130struct(animstruct);
}

function function_3a001a7d1d9a2ca3(player, animstruct, models) {
  level.var_ca629cf434263639 = 0;
  thread function_710d2b779609907d(player, models, animstruct);
  thread function_b51365f787d44355(player, animstruct);
}

function endanimsequence(player, animstruct, models) {
  level.var_ca629cf434263639 = undefined;
  animstruct notify("<dev string:x1f7>");

  foreach(model in models) {
    model scriptmodelclearanim();
  }
}

function function_9384c9ed097bf7b9(player, buttonstring) {
  while(player buttonPressed(buttonstring) && function_136f4218b1d719b9()) {
    waitframe();
  }

  while(!player buttonPressed(buttonstring) && function_136f4218b1d719b9()) {
    waitframe();
  }
}

function function_710d2b779609907d(player, models, animstruct) {
  animstruct endon("<dev string:x1f7>");

  while(true) {
    level.var_ca629cf434263639 = 0;

    while(player buttonPressed("<dev string:x1dc>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x1dc>")) {
      waitframe();
    }

    foreach(model in models) {
      model scriptmodelpauseanim(1);
    }

    level.var_ca629cf434263639 = 1;

    while(player buttonPressed("<dev string:x1dc>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x1dc>")) {
      waitframe();
    }

    foreach(model in models) {
      model scriptmodelpauseanim(0);
    }
  }
}

function function_b51365f787d44355(player, animstruct) {
  animstruct endon("<dev string:x1f7>");
  assert(isDefined(animstruct.cameraent));

  while(true) {
    while(!player buttonPressed("<dev string:x204>") || !isDefined(animstruct.cameraentlinktag)) {
      waitframe();
    }

    player scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
    player scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("<dev string:x20f>");
    player cameraunlink();
    player disablephysicaldepthoffieldscripting();
    player _freezelookcontrols(0);
    org = animstruct.cameraent gettagorigin(animstruct.cameraentlinktag) + (0, 0, -60);
    angles = animstruct.cameraent gettagangles(animstruct.cameraentlinktag);
    player setOrigin(org);
    player setplayerangles(angles);

    if(!player isufo()) {
      player ufo();
    }

    while(player buttonPressed("<dev string:x204>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x204>")) {
      waitframe();
    }

    if(player isufo()) {
      player ufo();
    }

    player cameralinkTo(animstruct.cameraent, animstruct.cameraentlinktag, 1, 1);
    player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
    player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("<dev string:x20f>");
    player enablephysicaldepthoffieldscripting();

    while(player buttonPressed("<dev string:x204>")) {
      waitframe();
    }
  }
}

function function_77108c1c4c1defef(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12) {
  self endon("<dev string:x234>");
  self endon("<dev string:x242>");
  function_3fc888ca7a09b8d(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
}

function function_3fc888ca7a09b8d(func, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12) {
  waitandpause(timer);

  if(isDefined(param12)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
    return;
  }

  if(isDefined(param11)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
    return;
  }

  if(isDefined(param10)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
    return;
  }

  if(isDefined(param9)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8, param9);
    return;
  }

  if(isDefined(param8)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7, param8);
    return;
  }

  if(isDefined(param7)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6, param7);
    return;
  }

  if(isDefined(param6)) {
    self builtin[[func]](param1, param2, param3, param4, param5, param6);
    return;
  }

  if(isDefined(param5)) {
    self builtin[[func]](param1, param2, param3, param4, param5);
    return;
  }

  if(isDefined(param4)) {
    self builtin[[func]](param1, param2, param3, param4);
    return;
  }

  if(isDefined(param3)) {
    self builtin[[func]](param1, param2, param3);
    return;
  }

  if(isDefined(param2)) {
    self builtin[[func]](param1, param2);
    return;
  }

  if(isDefined(param1)) {
    self builtin[[func]](param1);
    return;
  }

  self builtin[[func]]();
}

function movetopause(point, timesec, accel, decel) {
  self moveTo(point, timesec, accel, decel);

  while(timesec > 0) {
    waitframe();

    if(istrue(level.var_ca629cf434263639)) {
      self moveTo(self.origin, timesec, accel, decel);

      while(istrue(level.var_ca629cf434263639)) {
        waitframe();
      }

      self moveTo(point, timesec, accel, decel);
    }

    timesec -= level.framedurationseconds;
  }
}

function rotatetopause(angles, timesec, accel, decel) {
  self rotateTo(angles, timesec, accel, decel);

  while(timesec > 0) {
    waitframe();

    if(istrue(level.var_ca629cf434263639)) {
      self rotateTo(self.angles, timesec, accel, decel);

      while(istrue(level.var_ca629cf434263639)) {
        waitframe();
      }

      self rotateTo(angles, timesec, accel, decel);
    }

    timesec -= level.framedurationseconds;
  }
}

function function_b0f7742c6d38dbd1(animstruct) {
  entaxis = anglestoaxis(animstruct.movingc130.angles);
  entright = -1 * entaxis["<dev string:x24b>"];
  entup = entaxis["<dev string:x254>"];

  foreach(player in level.players) {
    slotnumber = player.infilanimindex - 1;
    prop_name = "<dev string:x25a>" + player.infilanimindex;
    cameraorigin = animstruct.cameraentmoving gettagorigin(prop_name);
    cameraangles = animstruct.cameraentmoving gettagangles(prop_name);
    baseorigin = player getvieworigin();
    rayorigin = cameraorigin;
    raydir = anglesToForward(cameraangles);
    planenormal = (raydir[0] * -1, raydir[1] * -1, 0);
    planenormal = vectorNormalize(planenormal);
    denominator = vectordot(planenormal, raydir);
    difference = baseorigin - rayorigin;
    t = vectordot(difference, planenormal) / denominator;
    result = rayorigin + t * raydir;
    offset = result - baseorigin;
    println("<dev string:x265>" + slotnumber + "<dev string:x282>" + offset[0] + "<dev string:x288>" + offset[1] + "<dev string:x288>" + offset[2] + "<dev string:x28d>");
    entorigin = baseorigin + entright * offset[0] + entup * offset[2];
    cameradistance = distance(cameraorigin, entorigin);
    var_cf201622a9fd5646 = entorigin - cameraorigin;
    var_cf201622a9fd5646 = vectorNormalize(var_cf201622a9fd5646);
    var_abdc396b57c7f955 = vectordot(raydir, var_cf201622a9fd5646);
    println("<dev string:x292>" + slotnumber + "<dev string:x2ae>" + cameradistance + "<dev string:x2be>" + var_abdc396b57c7f955 + "<dev string:x28d>");
    var_4200398f14c8db5 = cameraorigin - entorigin;
    var_629f52c3d96c0cb9 = length(var_4200398f14c8db5);
    var_867d9818ce7f2161 = acos(var_4200398f14c8db5[2] / var_629f52c3d96c0cb9);
    println("<dev string:x2c9>" + slotnumber + "<dev string:x2e8>" + var_629f52c3d96c0cb9 + "<dev string:x2f5>" + var_867d9818ce7f2161 + "<dev string:x28d>");
  }
}

function headlessinfils() {
  dist = distance(level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt);
  time = dist / scripts\mp\gametypes\br_c130::getc130speed() / level.headlessinfilplayers.size;

  for(i = 0; i < level.headlessinfilplayers.size; i++) {
    wait time;
    level.headlessinfilplayers[i] notify("halo_jump_c130");
  }

  level.headlessinfilplayers = undefined;
}

function registerheadlessinfil(player) {
  if(!isDefined(level.headlessinfilplayers)) {
    level.headlessinfilplayers = [];
  }

  level.headlessinfilplayers[level.headlessinfilplayers.size] = player;
}