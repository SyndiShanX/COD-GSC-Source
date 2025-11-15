/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\rat_shared.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace rat_shared;

function init() {
  if(!isDefined(level.rat)) {
    level.rat = spawnStruct();
    level.rat.common = spawnStruct();
    level.rat.script_command_list = [];
    addratscriptcmd("", & rscteleport);
    addratscriptcmd("", & rscteleportenemies);
    addratscriptcmd("", & rscsimulatescripterror);
    addratscriptcmd("", & rscrecteleport);
  }
}

function addratscriptcmd(commandname, functioncallback) {
  init();
  level.rat.script_command_list[commandname] = functioncallback;
}

function codecallback_ratscriptcommand(params) {
  init();
  assert(isDefined(params._cmd));
  assert(isDefined(params._id));
  assert(isDefined(level.rat.script_command_list[params._cmd]), "" + params._cmd);
  callback = level.rat.script_command_list[params._cmd];
  level thread[[callback]](params);
}

function rscteleport(params) {
  player = [[level.rat.common.gethostplayer]]();
  pos = (float(params.x), float(params.y), float(params.z));
  player setorigin(pos);
  if(isDefined(params.ax)) {
    angles = (float(params.ax), float(params.ay), float(params.az));
    player setplayerangles(angles);
  }
  ratreportcommandresult(params._id, 1);
}

function rscteleportenemies(params) {
  foreach(player in level.players) {
    if(!isDefined(player.bot)) {
      continue;
    }
    pos = (float(params.x), float(params.y), float(params.z));
    player setorigin(pos);
    if(isDefined(params.ax)) {
      angles = (float(params.ax), float(params.ay), float(params.az));
      player setplayerangles(angles);
    }
    if(!isDefined(params.all)) {
      break;
    }
  }
  ratreportcommandresult(params._id, 1);
}

function rscsimulatescripterror(params) {
  if(params.errorlevel == "") {
    assertmsg("");
  } else {
    thisdoesntexist.orthis = 0;
  }
  ratreportcommandresult(params._id, 1);
}

function rscrecteleport(params) {
  println("");
  player = [[level.rat.common.gethostplayer]]();
  pos = player getorigin();
  angles = player getplayerangles();
  cmd = (((((((((("" + pos[0]) + "") + pos[1]) + "") + pos[2]) + "") + angles[0]) + "") + angles[1]) + "") + angles[2];
  ratrecordmessage(0, "", cmd);
  setdvar("", "");
}