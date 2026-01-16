/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_end_game_flow.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\end_game_taunts;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("all_player");
#namespace end_game_flow;

function autoexec __init__sytem__() {
  system::register("end_game_flow", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "displayTop3Players", 1, 1, "int", & handletopthreeplayers, 0, 0);
  clientfield::register("world", "triggerScoreboardCamera", 1, 1, "int", & showscoreboard, 0, 0);
  clientfield::register("world", "playTop0Gesture", 1000, 3, "int", & handleplaytop0gesture, 0, 0);
  clientfield::register("world", "playTop1Gesture", 1000, 3, "int", & handleplaytop1gesture, 0, 0);
  clientfield::register("world", "playTop2Gesture", 1000, 3, "int", & handleplaytop2gesture, 0, 0);
  level thread streamerwatcher();
}

function setanimationonmodel(localclientnum, charactermodel, topplayerindex) {
  anim_name = end_game_taunts::getidleanimname(localclientnum, charactermodel, topplayerindex);
  if(isdefined(anim_name)) {
    charactermodel util::waittill_dobj(localclientnum);
    if(!charactermodel hasanimtree()) {
      charactermodel useanimtree($all_player);
    }
    charactermodel setanim(anim_name);
  }
}

function loadcharacteronmodel(localclientnum, charactermodel, topplayerindex) {
  assert(isdefined(charactermodel));
  bodymodel = gettopplayersbodymodel(localclientnum, topplayerindex);
  displaytopplayermodel = createuimodel(getuimodelforcontroller(localclientnum), "displayTopPlayer" + (topplayerindex + 1));
  setuimodelvalue(displaytopplayermodel, 1);
  if(!isdefined(bodymodel) || bodymodel == "") {
    setuimodelvalue(displaytopplayermodel, 0);
    return;
  }
  charactermodel setmodel(bodymodel);
  helmetmodel = gettopplayershelmetmodel(localclientnum, topplayerindex);
  if(!charactermodel isattached(helmetmodel, "")) {
    charactermodel.helmetmodel = helmetmodel;
    charactermodel attach(helmetmodel, "");
  }
  moderenderoptions = getcharactermoderenderoptions(currentsessionmode());
  bodyrenderoptions = gettopplayersbodyrenderoptions(localclientnum, topplayerindex);
  helmetrenderoptions = gettopplayershelmetrenderoptions(localclientnum, topplayerindex);
  weaponrenderoptions = gettopplayersweaponrenderoptions(localclientnum, topplayerindex);
  charactermodel.bodymodel = bodymodel;
  charactermodel.moderenderoptions = moderenderoptions;
  charactermodel.bodyrenderoptions = bodyrenderoptions;
  charactermodel.helmetrenderoptions = helmetrenderoptions;
  charactermodel.headrenderoptions = helmetrenderoptions;
  weapon_right = gettopplayersweaponinfo(localclientnum, topplayerindex);
  if(!isdefined(level.weaponnone)) {
    level.weaponnone = getweapon("none");
  }
  charactermodel setbodyrenderoptions(moderenderoptions, bodyrenderoptions, helmetrenderoptions, helmetrenderoptions);
  if(weapon_right["weapon"] == level.weaponnone) {
    weapon_right["weapon"] = getweapon("ar_standard");
    charactermodel.showcaseweapon = weapon_right["weapon"];
    charactermodel attachweapon(weapon_right["weapon"]);
  } else {
    charactermodel.showcaseweapon = weapon_right["weapon"];
    charactermodel.showcaseweaponrenderoptions = weaponrenderoptions;
    charactermodel.showcaseweaponacvi = weapon_right["acvi"];
    charactermodel attachweapon(weapon_right["weapon"], weaponrenderoptions, weapon_right["acvi"]);
    charactermodel useweaponhidetags(weapon_right["weapon"]);
  }
}

function setupmodelandanimation(localclientnum, charactermodel, topplayerindex) {
  charactermodel endon("entityshutdown");
  loadcharacteronmodel(localclientnum, charactermodel, topplayerindex);
  setanimationonmodel(localclientnum, charactermodel, topplayerindex);
}

function preparetopthreeplayers(localclientnum) {
  numclients = gettopscorercount(localclientnum);
  position = struct::get("endgame_top_players_struct", "targetname");
  if(!isdefined(position)) {
    return;
  }
  for (index = 0; index < 3; index++) {
    if(index < numclients) {
      model = spawn(localclientnum, position.origin, "script_model");
      loadcharacteronmodel(localclientnum, model, index);
      model hide();
      model sethighdetail(1);
    }
  }
}

function showtopthreeplayers(localclientnum) {
  level.topplayercharacters = [];
  topplayerscriptstructs = [];
  topplayerscriptstructs[0] = struct::get("TopPlayer1", "targetname");
  topplayerscriptstructs[1] = struct::get("TopPlayer2", "targetname");
  topplayerscriptstructs[2] = struct::get("TopPlayer3", "targetname");
  foreach(index, scriptstruct in topplayerscriptstructs) {
    level.topplayercharacters[index] = spawn(localclientnum, scriptstruct.origin, "script_model");
    level.topplayercharacters[index].angles = scriptstruct.angles;
  }
  numclients = gettopscorercount(localclientnum);
  foreach(index, charactermodel in level.topplayercharacters) {
    if(index < numclients) {
      thread setupmodelandanimation(localclientnum, charactermodel, index);
      if(index == 0) {
        thread end_game_taunts::playcurrenttaunt(localclientnum, charactermodel, index);
      }
    }
  }
  level thread end_game_taunts::check_force_taunt();
  level thread end_game_taunts::check_force_gesture();
  level thread end_game_taunts::draw_runner_up_bounds();
  position = struct::get("endgame_top_players_struct", "targetname");
  playmaincamxcam(localclientnum, level.endgamexcamname, 0, "cam_topscorers", "topscorers", position.origin, position.angles);
  playradiantexploder(localclientnum, "exploder_mp_endgame_lights");
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "displayTop3Players"), 1);
  thread spamuimodelvalue(localclientnum);
  thread checkforgestures(localclientnum);
}

function spamuimodelvalue(localclientnum) {
  while (true) {
    wait(0.25);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "displayTop3Players"), 1);
  }
}

function checkforgestures(localclientnum) {
  localplayers = getlocalplayers();
  for (i = 0; i < localplayers.size; i++) {
    thread checkforplayergestures(localclientnum, localplayers[i], i);
  }
}

function checkforplayergestures(localclientnum, localplayer, playerindex) {
  localtopplayerindex = localplayer gettopplayersindex(localclientnum);
  if(!isdefined(localtopplayerindex) || !isdefined(level.topplayercharacters) || localtopplayerindex >= level.topplayercharacters.size) {
    return;
  }
  charactermodel = level.topplayercharacters[localtopplayerindex];
  if(localtopplayerindex > 0) {
    wait(3);
  } else if(isdefined(charactermodel.playingtaunt)) {
    charactermodel waittill("tauntfinished");
  }
  showgestures(localclientnum, playerindex);
}

function showgestures(localclientnum, playerindex) {
  gesturesmodel = getuimodel(getuimodelforcontroller(localclientnum), "topPlayerInfo.showGestures");
  if(isdefined(gesturesmodel)) {
    setuimodelvalue(gesturesmodel, 1);
    allowactionslotinput(playerindex);
  }
}

function handleplaytop0gesture(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  handleplaygesture(localclientnum, 0, newval);
}

function handleplaytop1gesture(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  handleplaygesture(localclientnum, 1, newval);
}

function handleplaytop2gesture(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  handleplaygesture(localclientnum, 2, newval);
}

function handleplaygesture(localclientnum, topplayerindex, gesturetype) {
  if(gesturetype > 2 || !isdefined(level.topplayercharacters) || topplayerindex >= level.topplayercharacters.size) {
    return;
  }
  charactermodel = level.topplayercharacters[topplayerindex];
  if(isdefined(charactermodel.playingtaunt) || (isdefined(charactermodel.playinggesture) && charactermodel.playinggesture)) {
    return;
  }
  thread end_game_taunts::playgesturetype(localclientnum, charactermodel, topplayerindex, gesturetype);
}

function streamerwatcher() {
  while (true) {
    level waittill("streamfksl", localclientnum);
    preparetopthreeplayers(localclientnum);
    end_game_taunts::stream_epic_models();
  }
}

function handletopthreeplayers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(newval) && newval > 0 && isdefined(level.endgamexcamname)) {
    level.showedtopthreeplayers = 1;
    showtopthreeplayers(localclientnum);
  }
}

function showscoreboard(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(newval) && newval > 0 && isdefined(level.endgamexcamname)) {
    end_game_taunts::stop_stream_epic_models();
    end_game_taunts::deletecameraglass(undefined);
    position = struct::get("endgame_top_players_struct", "targetname");
    playmaincamxcam(localclientnum, level.endgamexcamname, 0, "cam_topscorers", "", position.origin, position.angles);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "forceScoreboard"), 1);
    level.inendgameflow = 1;
  }
}