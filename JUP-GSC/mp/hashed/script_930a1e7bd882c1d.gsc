/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_930a1e7bd882c1d.gsc
************************************************/

#using script_75377e59f5becac8;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\utility\teams;
#namespace namespace_e7bbffdd71331a9a;

function spawn_script_model(modelname, animname, extramodels) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);

  if(!isDefined(animname)) {
    animname = modelname;
  }

  model.animname = animname;

  if(isDefined(extramodels)) {
    model.linkedents = [];

    foreach(modeltag in extramodels) {
      extra = spawn("script_model", self.origin);
      extra setModel(modeltag[0]);
      extra forcenetfieldhighlod(1);
      extra linkTo(model, modeltag[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

  return model;
}

function function_c880edba9face762(scenename) {
  origin_name = "infil_" + scenename + "_light_origin";
  orgstruct = getStruct(origin_name, "targetname");

  if(!isDefined(level.lighting_rigs)) {
    level.lighting_rigs = [];
  }

  level.lighting_rigs[origin_name] = orgstruct;
}

function function_fce988291dbc4649(scenename) {
  if(!isDefined(level.lighting_rigs)) {
    return undefined;
  }

  origin_name = "infil_" + scenename + "_light_origin";
  return level.lighting_rigs[origin_name];
}

function function_8c2d124dbef4fa60(scenename, linkent) {
  rig = spawnStruct();
  var_5e0676140eecdf2d = "infil_" + scenename + "_probe";
  light_name = "infil_" + scenename + "_light";
  probes = getEntArray(var_5e0676140eecdf2d, "script_noteworthy");
  lights = getEntArray(light_name, "targetname");
  orgstruct = function_fce988291dbc4649(scenename);

  if(!isDefined(probes)) {
    return undefined;
  }

  foreach(probe in probes) {
    if(!isDefined(probe)) {
      return undefined;
    }
  }

  if(!isDefined(lights)) {
    return undefined;
  }

  foreach(light in lights) {
    if(!isDefined(light)) {
      return undefined;
    }
  }

  if(!isDefined(orgstruct)) {
    return undefined;
  }

  orgorigin = orgstruct.origin;
  var_3694a4e650566a39 = orgstruct.angles;

  if(!isDefined(var_3694a4e650566a39)) {
    var_3694a4e650566a39 = (0, 0, 0);
  }

  foreach(probe in probes) {
    if(!isDefined(probe.origin_offset) && !isDefined(probe.angles_offset)) {
      var_542e3e93b710380f = probe.origin;
      var_7434c0613f2501b1 = probe.angles;

      if(!isDefined(var_7434c0613f2501b1)) {
        var_7434c0613f2501b1 = (0, 0, 0);
      }

      probe.origin_offset = var_542e3e93b710380f - orgorigin;
      probe.angles_offset = var_7434c0613f2501b1 - var_3694a4e650566a39;
    }
  }

  foreach(light in lights) {
    if(!isDefined(light.origin_offset) && !isDefined(light.angles_offset)) {
      lightorigin = light.origin;
      lightangles = light.angles;

      if(!isDefined(light.angles)) {
        lightangles = (0, 0, 0);
      }

      light.origin_offset = lightorigin - orgorigin;
      light.angles_offset = lightangles - var_3694a4e650566a39;
    }
  }

  rig.probes = probes;
  rig.lights = lights;
  rig.linkent = linkent;
  function_89a2405953b84136(rig, 1);
  return rig;
}

function private function_89a2405953b84136(rig, override_og) {
  if(!isDefined(rig)) {
    return;
  }

  foreach(probe in rig.probes) {
    probe hide();
  }

  foreach(light in rig.lights) {
    if(override_og && !isDefined(light.original_intensity)) {
      light.original_intensity = light getlightintensity();
    }

    light setlightintensity(0);
  }
}

function create_animpack(anime, islooping) {
  pack = spawnStruct();
  pack.ents = [];
  pack.staticents = [];
  pack.playerpositions = [];
  pack.var_3bd5282b118d27f8 = [];
  pack.lightingrigs = [];
  pack.anime = anime;
  pack.islooping = istrue(islooping);
  return pack;
}

function function_2d4c340dd3908b2d(fov) {
  self.fov = fov;
}

function function_b8f86028bcc64f84(fstop, focusdist, focusspeed, aperturespeed, focalpoint) {
  self.fstop = fstop;
  self.focusdist = focusdist;
  self.focusspeed = focusspeed;
  self.aperturespeed = aperturespeed;
  self.focalpoint = focalpoint;
}

function add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self.var_c65bb75cce61100f = paramarray;
}

function function_e718ba63d511fcde(paramarray, func) {
  self.playerfunc = func;
  self.var_5ab13b55d7ceff80 = paramarray;
}

function add_pack_modelanim(ent, animation) {
  assert(isDefined(ent.animname));
  assert(isDefined(self.anime));
  level.scr_anim[ent.animname][self.anime] = animation;
  self.ents[self.ents.size] = ent;
}

function function_a44bdab6357b7210(ent) {
  self.staticents[self.staticents.size] = ent;
}

function function_707983b9fdb53c55(rig) {
  self.lightingrigs[self.lightingrigs.size] = rig;
}

function function_ad0bcac98781e0ab(ent, animation, var_1ef3b90415513455) {
  index = self.playerpositions.size;
  newstruct = spawnStruct();
  newstruct.ent = ent;
  newstruct.animation = animation;
  newstruct.animname = getanimname(animation);

  if(isDefined(var_1ef3b90415513455)) {
    newstruct.animationfem = var_1ef3b90415513455;
    newstruct.animnamefem = getanimname(var_1ef3b90415513455);
  }

  self.playerpositions[index] = newstruct;
}

function function_f7fc8b110c478968(ent, animation) {
  assert(isDefined(ent.animname));
  assert(isDefined(self.anime));
  level.scr_anim[ent.animname][self.anime] = animation;
  self.var_3bd5282b118d27f8[self.var_3bd5282b118d27f8.size] = ent;
}

function function_d4561ab1ba4f5de9(ent, var_e6783d526b4a7212, animation, xcamasset, xcamfunction) {
  assert(!isDefined(self.camerainfo));
  self.camerainfo = spawnStruct();
  self.camerainfo.ent = ent;
  self.camerainfo.var_e6783d526b4a7212 = var_e6783d526b4a7212;

  if(isDefined(xcamasset)) {
    self.camerainfo.xcamasset = xcamasset;
    self.camerainfo.xcamfunction = xcamfunction;

    if(!self.islooping) {
      xcamlength = getxcamlength(xcamasset);
      xcamlength -= 0.033;
      xcamlength -= mod(xcamlength, 0.05);
      self.camerainfo.xcamlength = xcamlength;
    }

    return;
  }

  if(!self.islooping) {
    self.camerainfo.animlength = getanimlength(animation);
  }
}

function add_pack_fx(fxid, origin, angles) {
  self.fx = fxid;
  self.fxorigin = origin;
  self.fxangles = angles;
}

function add_pack_playeranim(player, var_f8896cb359eab159, var_b1e61449da6ba188) {
  if(!isDefined(player)) {
    return;
  }

  animname = undefined;

  if(!isDefined(player.brexfilanimname)) {
    animname = "player" + player getentitynumber();
    player.animname = animname;
    player.brexfilanimname = animname;
  } else {
    animname = player.brexfilanimname;
  }

  animation = var_f8896cb359eab159;

  if(isDefined(var_b1e61449da6ba188)) {
    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female") {
      animation = var_b1e61449da6ba188;
    }
  }

  level.scr_anim[animname][self.anime] = animation;
  level.scr_eventanim[animname][self.anime] = getanimname(animation);
  self.players[self.players.size] = player;
}

function function_ad12d29d41483e8a(statename, func) {
  assert(!isDefined(level.infilstruct.statecallbacks[statename]));
  level.infilstruct.statecallbacks[statename] = func;
}

function function_226e337633a44059(var_4f748fb021262dba, var_c242a4a69c2beed3) {
  level.infilstruct.var_6d575c4dfa5d6788 = var_4f748fb021262dba;

  if(isDefined(var_c242a4a69c2beed3)) {
    level.infilstruct.var_ad3c883fbff215b5 = var_c242a4a69c2beed3;
    return;
  }

  level.infilstruct.var_ad3c883fbff215b5 = undefined;
}

function function_f18696ac7694ed9() {
  if(isDefined(level.infilstruct.var_ad3c883fbff215b5) && isDefined(self.var_db122a8941dfee14) && self.var_db122a8941dfee14 == 1) {
    return level.infilstruct.var_ad3c883fbff215b5;
  }

  if(isarray(level.infilstruct.var_6d575c4dfa5d6788)) {
    slotnumber = 0;

    if(isDefined(self.infilanimindex)) {
      slotnumber = self.infilanimindex - 1;
    }

    assert(slotnumber < level.infilstruct.var_6d575c4dfa5d6788.size);
    return level.infilstruct.var_6d575c4dfa5d6788[slotnumber];
  }

  return level.infilstruct.var_6d575c4dfa5d6788;
}

function allplayers_setfov(fov) {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setclientdvar(@ "cg_fov", fov);
    player setclientdvar(@ "hash_71c6c0b8428e44a7", 1);
  }
}

function function_cf47ab3f9defe35b() {
  if(istrue(level.infilstruct.var_12c912ee9672fa1)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      player setclientdvar(@ "cg_fov", 65);
      player setclientdvar(@ "hash_86bf34d5f48fa435", 65);
    }

    return;
  }

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setclientdvar(@ "cg_fov", 65);
    player setclientdvar(@ "hash_86bf34d5f48fa435", 65);
    player setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
  }
}

function allplayers_setphysicaldof(fstop, focusdist, focusspeed, aperturespeed, focalpoint) {
  if(!isDefined(focusspeed)) {
    focusspeed = 100;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 100;
  }

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.var_1f0a019572c9f8e2)) {
      player.var_1f0a019572c9f8e2 = 1;
      player enablephysicaldepthoffieldscripting();
    }

    if(isDefined(focalpoint)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed, aperturespeed, focalpoint);
      continue;
    }

    if(isDefined(aperturespeed)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed, aperturespeed);
      continue;
    }

    if(isDefined(focusspeed)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed);
      continue;
    }

    player setphysicaldepthoffield(fstop, focusdist);
  }
}

function allplayers_clearphysicaldof() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.var_1f0a019572c9f8e2)) {
      player.var_1f0a019572c9f8e2 = undefined;
      player disablephysicaldepthoffieldscripting();
    }
  }
}

function function_d328d1b2bd6822bd(fadedowntime) {
  assert(!isDefined(level.infilblackoverlay));
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
  level.infilblackoverlay = overlay;

  if(isDefined(fadedowntime) && fadedowntime > 0) {
    level.infilblackoverlay.alpha = 0;
    level.infilblackoverlay fadeovertime(fadedowntime);
    level.infilblackoverlay.alpha = 1;
    return;
  }

  level.infilblackoverlay.alpha = 1;
}

function function_32bc1d39bf81ce95(var_1bb7594c18d17443) {
  assert(isDefined(level.infilblackoverlay));

  if(isDefined(var_1bb7594c18d17443) && var_1bb7594c18d17443 > 0) {
    level.infilblackoverlay.alpha = 1;
    level.infilblackoverlay fadeovertime(var_1bb7594c18d17443);
    level.infilblackoverlay.alpha = 0;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      player scripts\common\damage_effects::function_a2b4e6088394bade();
      player notify("deaths_door_exit");
      player clearsoundsubmix("mp_br_lobby_fade", 0);
    }

    return;
  }

  level.infilblackoverlay.alpha = 0;
}

function function_743f088f49ccc99d() {
  assert(isDefined(level.infilblackoverlay));
  level.infilblackoverlay destroy();
  level.infilblackoverlay = undefined;
}

function function_ea856ec0b3c4cfc6(fadedowntime, players, fadename) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player function_10f93bb3f3966751(fadedowntime, fadename);
  }
}

function function_10f93bb3f3966751(fadedowntime, fadename) {
  function_a38b2e30e799e9b7(fadedowntime, fadename);
  spectators = scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();

  if(spectators.size > 0) {
    foreach(viewer in spectators) {
      viewer function_a38b2e30e799e9b7(fadedowntime, fadename);
    }
  }
}

function function_a38b2e30e799e9b7(fadedowntime, fadename) {
  assert(isDefined(fadename));

  if(!isDefined(self.var_cd09849e16631c71)) {
    self.var_cd09849e16631c71 = [];
  }

  assert(!isDefined(self.var_cd09849e16631c71[fadename]));

  if(isDefined(self.var_cd09849e16631c71[fadename])) {
    return;
  }

  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay.archived = 0;
  overlay setshowinrealism(1);

  if(isDefined(fadedowntime) && fadedowntime > 0) {
    overlay.alpha = 0;
    overlay fadeovertime(fadedowntime);
    overlay.alpha = 1;
  } else {
    overlay.alpha = 1;
  }

  self.var_cd09849e16631c71[fadename] = overlay;
}

function function_7f3ad8fe6df1b8fe(var_1bb7594c18d17443, players, fadename) {
  level thread function_6b9a694ac71b6342(var_1bb7594c18d17443, players, fadename);
}

function private function_6b9a694ac71b6342(var_1bb7594c18d17443, players, fadename) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player function_1162dbfdb942d179(var_1bb7594c18d17443, fadename);
    spectators = player scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();

    if(spectators.size > 0) {
      foreach(viewer in spectators) {
        viewer function_1162dbfdb942d179(var_1bb7594c18d17443, fadename);
      }
    }
  }

  wait var_1bb7594c18d17443;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player function_46b5c06f8d7ac31(fadename);
    spectators = player scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();

    if(spectators.size > 0) {
      foreach(viewer in spectators) {
        viewer function_46b5c06f8d7ac31(fadename);
      }
    }
  }
}

function function_1162dbfdb942d179(var_1bb7594c18d17443, fadename) {
  assert(isDefined(fadename));

  if(isbot(self) && (!isDefined(self.var_cd09849e16631c71) || !isDefined(self.var_cd09849e16631c71[fadename]))) {
    return;
  }

  assert(isDefined(self.var_cd09849e16631c71));
  assert(isDefined(self.var_cd09849e16631c71[fadename]));
  overlay = self.var_cd09849e16631c71[fadename];

  if(isDefined(var_1bb7594c18d17443) && var_1bb7594c18d17443 > 0) {
    if(isDefined(overlay)) {
      overlay.alpha = 1;
      overlay fadeovertime(var_1bb7594c18d17443);
      overlay.alpha = 0;
    }

    scripts\common\damage_effects::function_a2b4e6088394bade();
    self clearsoundsubmix("mp_br_lobby_fade", 0);
    return;
  }

  if(isDefined(overlay)) {
    overlay.alpha = 0;
  }
}

function function_46b5c06f8d7ac31(fadename) {
  if(isbot(self) && (!isDefined(self.var_cd09849e16631c71) || !isDefined(self.var_cd09849e16631c71[fadename]))) {
    return;
  }

  assert(isDefined(self.var_cd09849e16631c71));
  assert(isDefined(self.var_cd09849e16631c71[fadename]));
  self.var_cd09849e16631c71[fadename] destroy();
  self.var_cd09849e16631c71[fadename] = undefined;

  if(self.var_cd09849e16631c71.size == 0) {
    self.var_cd09849e16631c71 = undefined;
  }
}

function endprematchskydiving() {
  var_98eaf83fc88a156e = 5;
  assertex(isPlayer(self), "<dev string:x1c>");
  player = self;
  player skydive_setdeploymentstatus(0);
  player skydive_setbasejumpingstatus(0);

  if(isDefined(player.ffsm_state)) {
    player.ffsm_state = var_98eaf83fc88a156e;
  }

  player scripts\cp_mp\parachute::parachutecleanup();
}

function function_583f118c4064ca21(players) {
  hidetest = 0;

  hidetest = getdvarint(@ "hash_484dde7ceb1b8065", 0) != 0;

  var_2c13b756b0aa6dcf = isDefined(players) && players.size != level.players.size;

  foreach(team in level.teamnamelist) {
    teamplayers = getteamdata(team, "players");

    foreach(player in teamplayers) {
      if(var_2c13b756b0aa6dcf && !array_contains(players, player)) {
        continue;
      }

      if(!namespace_56a3588493afc984::function_60597da56f99d304(player)) {
        continue;
      }

      player function_a593971d75d82113();
      player function_379bb555405c16bb("br_infils_util::refreshTeamVisibility()");

      if(!hidetest) {
        foreach(otherplayer in teamplayers) {
          player showtoplayer(otherplayer);
        }
      }
    }
  }
}

function function_423115ed15f21e05(team) {
  hidetest = 0;

  hidetest = getdvarint(@ "hash_484dde7ceb1b8065", 0) != 0;

  teamplayers = getteamdata(team, "players");

  foreach(player in teamplayers) {
    if(!namespace_56a3588493afc984::function_60597da56f99d304(player)) {
      continue;
    }

    player function_a593971d75d82113();
    player function_379bb555405c16bb("br_infils_util::refreshTeamVisibilityForTeam()");

    if(!hidetest) {
      foreach(otherplayer in teamplayers) {
        player showtoplayer(otherplayer);
      }
    }
  }
}

function registerbrsquadleaderjumpcommands(brsquadleader) {
  if(!istrue(brsquadleader.jumpcomandsregistered)) {
    brsquadleader.jumpcomandsregistered = 1;
    brsquadleader scripts\mp\gametypes\br_public::updatebrscoreboardstat("jumpMasterState", 2);
    brsquadleader notifyonplayercommand("halo_jump_c130", "+gostand");
    brsquadleader notifyonplayercommand("br_break_squad", "+breath_sprint");
  }
}

function watchbrsquadleaderdisconnect(team) {
  waittill_any_2("death", "disconnect");
  teamplayers = getteamdata(team, "players");
  brsquadleader = setupbrsquadleader(teamplayers);

  if(isDefined(brsquadleader)) {
    registerbrsquadleaderjumpcommands(brsquadleader);
    brsquadleader thread watchbrsquadleaderdisconnect(team);
  }
}

function setupbrsquadleader(teamplayers) {
  if(teamplayers.size == 0) {
    return undefined;
  }

  brsquadleader = undefined;

  foreach(player in teamplayers) {
    if(isDefined(player) && player scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
      return player;
    }
  }

  foreach(player in teamplayers) {
    if(level.onlinegame && player isfireteamleader()) {
      brsquadleader = player;
      break;
    }
  }

  if(!isDefined(brsquadleader)) {
    var_11a39090e204313a = 0;

    var_11a39090e204313a = getdvarint(@ "hash_e65dc975d6fcfca0", 0) != 0;

    numplayerschecked = 0;

    foreach(player in teamplayers) {
      var_921910f60d54cfa6 = var_11a39090e204313a == isbot(player);

      if(var_921910f60d54cfa6) {
        numplayerschecked++;
        var_54a63825d837afe3 = 1 / numplayerschecked;

        if(randomfloat(1) < var_54a63825d837afe3) {
          brsquadleader = player;
        }
      }
    }
  }

  if(!isDefined(brsquadleader)) {
    foreach(player in teamplayers) {
      brsquadleader = player;
      break;
    }
  }

  if(!isDefined(brsquadleader)) {
    return undefined;
  }

  brsquadleader scripts\mp\gametypes\br::setplayerbrsquadleader(1);

  foreach(player in teamplayers) {
    if(player != brsquadleader) {
      player scripts\mp\gametypes\br::setplayerbrsquadleader(0);
    }

    infilstatus = ter_op(player scripts\mp\gametypes\br_public::isplayerbrsquadleader(), 2, 1);
    scripts\mp\gametypes\br_c130::setteammateomnvarsforplayer(player, teamplayers, infilstatus);
  }

  return brsquadleader;
}

function function_6d8ac534ad288aa5(player) {
  forceindex = undefined;
  possibleindices = [1, 2, 3, 4];
  teamplayers = getteamdata(player.team, "players");
  assert(teamplayers.size <= possibleindices.size);
  player.var_db122a8941dfee14 = teamplayers.size;

  foreach(teamplayer in teamplayers) {
    if(teamplayer == player) {
      continue;
    }

    if(isDefined(teamplayer.infilanimindex)) {
      possibleindices = array_remove(possibleindices, teamplayer.infilanimindex);
    }

    if(teamplayer scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
      possibleindices = array_remove(possibleindices, 1);
    }
  }

  if(possibleindices.size == 0) {
    possibleindices[0] = 1;
  }

  player.infilanimindex = possibleindices[0];

  forceindex = getdvarint(@ "hash_441165c7b355dd1b", -1);

  if(forceindex > 0) {
    player.infilanimindex = forceindex;
  }
}

function getinfilspawnoffset() {
  return getdvarfloat(@ "scr_br_dropspawnoffsetminz", 11400);
}

function function_136f4218b1d719b9() {
  return getdvarint(@ "hash_8545857262882e35", 0) != 0;
}

function function_2c3987dd5672427f(timesec) {
  if(function_136f4218b1d719b9()) {
    while(timesec > 0) {
      waitframe();

      while(istrue(level.var_ca629cf434263639)) {
        waitframe();
      }

      timesec -= level.framedurationseconds;
    }

    return 1;
  }

  return 0;
}

function function_8663da4077fa7e20() {
  movinginfil = 1;

  if(function_136f4218b1d719b9()) {
    movinginfil = getdvarint(@ "hash_f6b3b7c2e066bf97", 0);
  }

  return movinginfil;
}

function waitandpause(timesec) {
  if(function_2c3987dd5672427f(timesec)) {
    return;
  }

  wait timesec;
}

function function_6199c35f4cf4524c(func) {
  assert(isDefined(level.var_16da1e546dc92a4c));
  level.var_16da1e546dc92a4c[level.var_16da1e546dc92a4c.size] = func;
}

function function_e66f664ad726f2e() {
  var_14bd067261dc7f99 = "";

  switch (level.script) {
    case #"hash_bce1a7274538a78":
    case #"hash_73e90c896fdaebc3":
      var_14bd067261dc7f99 = "mp_infil_br_jup_wz2_intro_tr";
      break;
    case #"hash_aeddd44c5b27b2d":
      var_14bd067261dc7f99 = "mp_infil_br_jup_bm_live_wz2_intro_tr";
      break;
    case #"hash_3ebe34631513de1d":
      var_14bd067261dc7f99 = "mp_infil_br_jup_mech_intro_tr";
      break;
    case #"hash_da8f14763f037922":
      var_14bd067261dc7f99 = "mp_infil_br_jup_sm_island_2_wz2_intro_tr";
      break;
  }

  if(var_14bd067261dc7f99 != "") {
    unloadinfiltransient(var_14bd067261dc7f99);
  }
}

function function_d870904da7b1ff7d(lights, lightson) {
  if(lightson) {
    intensities = [];
    intensities["infil_light_01"] = 2000 * 7.95545e-05;
    intensities["infil_light_02"] = 3000 * 7.95545e-05;
    intensities["infil_light_03"] = 75 * 7.95545e-05;

    foreach(light in lights) {
      if(isDefined(light.name) && isDefined(intensities[light.name])) {
        light setlightintensity(intensities[light.name]);
      }

      light forcenetfieldhighlod(1);
    }

    return;
  }

  foreach(light in lights) {
    light setlightintensity(1 * 7.95545e-05);
    light forcenetfieldhighlod(0);
  }
}

function function_d8f828d3c82061b7(lights, lightson) {
  if(lightson) {
    intensities = [];
    intensities["exfil_light_01"] = 500 * 7.95545e-05;
    intensities["exfil_light_02"] = 1250 * 7.95545e-05;

    foreach(light in lights) {
      light setlightintensity(intensities[light.name]);
    }

    return;
  }

  foreach(light in lights) {
    light setlightintensity(1 * 7.95545e-05);
  }
}

function function_362cf2eeebce4c73(lights, lightson) {
  if(lightson) {
    intensities = [];
    intensities["cq_exfil_light_01"] = 1000 * 7.95545e-05;
    intensities["cq_exfil_light_02"] = 1000 * 7.95545e-05;
    intensities["cq_exfil_light_03"] = 1250 * 7.95545e-05;
    intensities["cq_exfil_light_04"] = 500 * 7.95545e-05;
    intensities["cq_exfil_light_05"] = 500 * 7.95545e-05;

    foreach(light in lights) {
      light setlightintensity(intensities[light.name]);
    }

    return;
  }

  foreach(light in lights) {
    light setlightintensity(1 * 7.95545e-05);
  }
}

function function_4d5d7485513f045(lights, lightson) {
  if(lightson) {
    intensities = [];
    intensities["2ndry_light_01"] = 250 * 7.95545e-05;
    intensities["2ndry_light_02"] = 1000 * 7.95545e-05;
    intensities["2ndry_light_03"] = 500 * 7.95545e-05;

    foreach(light in lights) {
      light setlightintensity(intensities[light.name]);
    }

    return;
  }

  foreach(light in lights) {
    light setlightintensity(1 * 7.95545e-05);
  }
}

function function_b281515d61bd0774(lights, lightson) {
  if(lightson) {
    intensities = [];
    intensities["accolade_light_01"] = 750 * 7.95545e-05;
    intensities["accolade_light_02"] = 1000 * 7.95545e-05;
    intensities["accolade_light_03"] = 1000 * 7.95545e-05;

    foreach(light in lights) {
      light setlightintensity(intensities[light.name]);
    }

    return;
  }

  foreach(light in lights) {
    light setlightintensity(1 * 7.95545e-05);
  }
}

function function_42f1462f1d4193af(lights) {
  infillights = getEntArray("infil_light", "targetname");
  var_d2326d24cb1fd3a2 = getEntArray("exfil_light", "targetname");
  var_3b31e0da499ed5ae = getEntArray("cq_exfil_light", "targetname");
  var_65f8c709d2f9cf4 = getEntArray("2ndry_light", "targetname");
  var_e45eb5dd4051778e = getEntArray("accolade_light", "targetname");

  switch (lights) {
    case #"hash_cf4e05b68aeba31a":
      function_d870904da7b1ff7d(infillights, 1);
      function_d8f828d3c82061b7(var_d2326d24cb1fd3a2, 0);
      function_362cf2eeebce4c73(var_3b31e0da499ed5ae, 0);
      function_4d5d7485513f045(var_65f8c709d2f9cf4, 0);
      function_b281515d61bd0774(var_e45eb5dd4051778e, 0);
      break;
    case #"hash_8dabe7b0b667b264":
      function_d870904da7b1ff7d(infillights, 0);
      function_d8f828d3c82061b7(var_d2326d24cb1fd3a2, 1);
      function_362cf2eeebce4c73(var_3b31e0da499ed5ae, 0);
      function_4d5d7485513f045(var_65f8c709d2f9cf4, 0);
      function_b281515d61bd0774(var_e45eb5dd4051778e, 0);
      break;
    case #"hash_4856b940c7c5b675":
      function_d870904da7b1ff7d(infillights, 0);
      function_d8f828d3c82061b7(var_d2326d24cb1fd3a2, 0);
      function_362cf2eeebce4c73(var_3b31e0da499ed5ae, 1);
      function_4d5d7485513f045(var_65f8c709d2f9cf4, 0);
      function_b281515d61bd0774(var_e45eb5dd4051778e, 0);
      break;
    case #"hash_f020299c866e4289":
      function_d870904da7b1ff7d(infillights, 0);
      function_d8f828d3c82061b7(var_d2326d24cb1fd3a2, 0);
      function_362cf2eeebce4c73(var_3b31e0da499ed5ae, 0);
      function_4d5d7485513f045(var_65f8c709d2f9cf4, 1);
      function_b281515d61bd0774(var_e45eb5dd4051778e, 0);
      break;
    case #"hash_96702057c0bd388":
      function_d870904da7b1ff7d(infillights, 0);
      function_d8f828d3c82061b7(var_d2326d24cb1fd3a2, 0);
      function_362cf2eeebce4c73(var_3b31e0da499ed5ae, 0);
      function_4d5d7485513f045(var_65f8c709d2f9cf4, 0);
      function_b281515d61bd0774(var_e45eb5dd4051778e, 1);
      break;
    default:
      break;
  }
}

function function_2bbe7f3e487520c6() {
  infillights = getEntArray("infil_light", "targetname");
  function_d870904da7b1ff7d(infillights, 0);
}

function function_59e8b4ed75ca8b92() {
  return !scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.skipprematch) || !isDefined(level.infilstruct) || !isDefined(level.infilstruct.var_eb0cd5e47dbbfd6a) || istrue(level.infilstruct.var_1cf4fe3c9d7da8a2) || !getdvarint(@ "hash_f49bd659b301fbb0", 1);
}