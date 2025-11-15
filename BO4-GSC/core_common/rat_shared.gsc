/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\rat_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\util_shared;

#namespace rat;

init() {
  if(!isDefined(level.rat)) {
    level.rat = spawnStruct();
    level.rat.common = spawnStruct();
    level.rat.script_command_list = [];
    level.rat.playerskilled = 0;
    level.rat.var_cd4fd549 = 0;
    callback::on_player_killed(&function_cecf7c3d);
    addratscriptcmd("<dev string:x38>", &function_5fd1a95b);
    addratscriptcmd("<dev string:x4d>", &rscteleport);
    addratscriptcmd("<dev string:x58>", &function_51706559);
    addratscriptcmd("<dev string:x67>", &function_b2fe8b5a);
    addratscriptcmd("<dev string:x73>", &function_bff535fb);
    addratscriptcmd("<dev string:x82>", &function_220d66d8);
    addratscriptcmd("<dev string:x8e>", &function_be6e2f9f);
    addratscriptcmd("<dev string:x99>", &function_ff0fa082);
    addratscriptcmd("<dev string:xa9>", &function_aecb1023);
    addratscriptcmd("<dev string:xbd>", &function_90282828);
    addratscriptcmd("<dev string:xd0>", &function_3b51dc31);
    addratscriptcmd("<dev string:xde>", &function_a6d4d86b);
    addratscriptcmd("<dev string:xef>", &function_54b7f226);
    addratscriptcmd("<dev string:x103>", &function_1b77bedd);
    addratscriptcmd("<dev string:x116>", &rscsimulatescripterror);
    addratscriptcmd("<dev string:x12c>", &function_1f00a502);
    addratscriptcmd("<dev string:x140>", &function_696e6dd3);
    addratscriptcmd("<dev string:x14c>", &function_dec22d87);
    addratscriptcmd("<dev string:x162>", &function_e3ab4393);
    addratscriptcmd("<dev string:x17a>", &function_cb62ece6);
    addratscriptcmd("<dev string:x187>", &function_d197a150);
    addratscriptcmd("<dev string:x199>", &function_c4336b49);
    addratscriptcmd("<dev string:x1a8>", &function_ccc178f3);
    addratscriptcmd("<dev string:x1bf>", &function_2fa64525);
    addratscriptcmd("<dev string:x1ce>", &function_6fb461e2);
    addratscriptcmd("<dev string:x1e1>", &function_f52fc58b);
    addratscriptcmd("<dev string:x1f5>", &function_dbc9b57c);
    addratscriptcmd("<dev string:x206>", &function_4f3a7675);
    addratscriptcmd("<dev string:x215>", &function_458913b0);
    addratscriptcmd("<dev string:x22b>", &function_191d6974);
    addratscriptcmd("<dev string:x237>", &function_d1b632ff);
    addratscriptcmd("<dev string:x248>", &function_7d9a084b);
    addratscriptcmd("<dev string:x25e>", &function_1ac5a32b);
    addratscriptcmd("<dev string:x276>", &function_7992a479);
    addratscriptcmd("<dev string:x283>", &function_9efe300c);
  }
}

function_7d22c1c9() {
  level flagsys::set("<dev string:x295>");
}

function_65e13d0f() {
  level flagsys::clear("<dev string:x295>");
}

function_b4f2a076() {
  level flagsys::set("<dev string:x2b2>");
}

function_6aa20375() {
  level flagsys::clear("<dev string:x2b2>");
}

addratscriptcmd(commandname, functioncallback) {
  init();
  level.rat.script_command_list[commandname] = functioncallback;
}

event_handler[rat_scriptcommand] codecallback_ratscriptcommand(params) {
  init();
  assert(isDefined(params._cmd));
  assert(isDefined(params._id));
  assert(isDefined(level.rat.script_command_list[params._cmd]), "<dev string:x2cd>" + params._cmd);
  callback = level.rat.script_command_list[params._cmd];
  ret = level[[callback]](params);
  ratreportcommandresult(params._id, 1, ret);
}

getplayer(params) {
  if(isDefined(params._xuid)) {
    xuid = int(params._xuid);

    foreach(player in getplayers()) {
      if(!isDefined(player.bot)) {
        player_xuid = int(player getxuid(1));

        if(xuid == player_xuid) {
          return player;
        }
      }
    }

    ratreportcommandresult(params._id, 0, "<dev string:x2eb>");
    wait 1;
    return;
  }

  return util::gethostplayer();
}

function_5fd1a95b(params) {
  foreach(cmd, func in level.rat.script_command_list) {
    function_55e20e75(params._id, cmd);
  }
}

function_7992a479(params) {
  player = getplayer(params);
  weapon = getweapon(params.weaponname);
  player giveweapon(weapon);
}

function_1b77bedd(params) {
  if(isDefined(level.inprematchperiod)) {
    return level.inprematchperiod;
  }
}

rscteleport(params) {
  player = getplayer(params);
  pos = (float(params.x), float(params.y), float(params.z));
  player setorigin(pos);

  if(isDefined(params.ax)) {
    angles = (float(params.ax), float(params.ay), float(params.az));
    player setplayerangles(angles);
  }
}

function_696e6dd3(params) {
  player = getplayer(params);
  player setstance(params.stance);
}

function_b2fe8b5a(params) {
  player = getplayer(params);
  return player getstance();
}

function_cb62ece6(params) {
  player = getplayer(params);
  return player ismeleeing();
}

function_bff535fb(params) {
  player = getplayer(params);
  return player playerads();
}

function_220d66d8(params) {
  player = getplayer(params);
  return player.health;
}

function_be6e2f9f(params) {
  player = getplayer(params);

  if(isDefined(params.amount)) {
    player dodamage(int(params.amount), player getorigin());
    return;
  }

  player dodamage(1, player getorigin());
}

function_ff0fa082(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon.name)) {
    return currentweapon.name;
  }
}

function_7d9a084b(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon.name)) {
    return currentweapon.reloadtime;
  }
}

function_aecb1023(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getammocount(currentweapon);
}

function_90282828(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getweaponammoclip(currentweapon);
}

function_3b51dc31(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getweaponammoclipsize(currentweapon);
}

function_54b7f226(params) {
  player = getplayer(params);
  origin = player getorigin();
  function_55e20e75(params._id, origin);
  angles = player getplayerangles();
  function_55e20e75(params._id, angles);
}

function_a6d4d86b(params) {
  if(isDefined(params.var_185699f8)) {
    return getnumconnectedplayers(1);
  }

  return getnumconnectedplayers(0);
}

function_cecf7c3d() {
  if(isDefined(self.bot)) {
    level.rat.var_cd4fd549 += 1;
    return;
  }

  level.rat.playerskilled += 1;
}

function_d197a150(params) {
  return level.rat.playerskilled;
}

function_c4336b49(params) {
  return level.rat.var_cd4fd549;
}

function_51706559(params) {
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
}

function_dec22d87(params) {
  player = getplayer(params);
  forward = anglesToForward(player.angles);
  distance = 50;

  if(isDefined(params.distance)) {
    distance = float(params.distance);
  }

  spawn = player.origin + forward * distance;

  foreach(other_player in level.players) {
    if(other_player == player) {
      continue;
    }

    if(isDefined(params.var_5d792f96) && int(params.var_5d792f96) && !isDefined(other_player.bot)) {
      continue;
    }

    other_player setorigin(spawn);
  }
}

function_e3ab4393(params) {
  player = getplayer(params);
  forward = anglesToForward(player.angles);
  distance = 50;

  if(isDefined(params.distance)) {
    distance = float(params.distance);
  }

  spawn = player.origin + forward * distance;

  foreach(other_player in level.players) {
    if(isDefined(params.bot) && int(params.bot) && !isDefined(other_player.bot)) {
      continue;
    }

    if(player getteam() != other_player getteam()) {
      other_player setorigin(spawn);
      other_player setplayerangles(player.angles);
      return;
    }
  }

  ratreportcommandresult(params._id, 0, "<dev string:x312>");
}

function_1ac5a32b(params) {
  player = getplayer(params);
  forward = anglesToForward(player.angles);
  distance = 50;

  if(isDefined(params.distance)) {
    distance = float(params.distance);
  }

  front = player.origin + forward * distance;
  player setorigin(front);
}

function_ccc178f3(params) {
  player = getplayer(params);
  return player isplayinganimscripted();
}

function_6fb461e2(params) {
  player = getplayer(params);
  return !player arecontrolsfrozen();
}

function_2fa64525(params) {
  if(isDefined(params.flag)) {
    return flagsys::get(params.flag);
  }
}

function_1f00a502(params) {
  foreach(player in getplayers()) {
    if(isbot(player)) {
      return player.health;
    }
  }

  return -1;
}

function_4f3a7675(params) {
  if(isDefined(level.var_5efad16e)) {
    level[[level.var_5efad16e]]();
    return 1;
  }

  return 0;
}

function_d04e8397(name) {
  level flagsys::set("<dev string:x342>");
  level scene::play(name);
  level flagsys::clear("<dev string:x342>");
}

function_191d6974(params) {
  if(isDefined(params.name)) {
    level thread function_d04e8397(params.name);
    return;
  }

  ratreportcommandresult(params._id, 0, "<dev string:x34e>");
}

function_d1b632ff(params) {
  return flagsys::get("<dev string:x342>");
}

rscsimulatescripterror(params) {
  if(params.errorlevel == "<dev string:x367>") {
    assertmsg("<dev string:x36f>");
    return;
  }

  thisdoesntexist.orthis = 0;
}

rscrecteleport(params) {
  println("<dev string:x38a>");
  player = [[level.rat.common.gethostplayer]]();
  pos = player getorigin();
  angles = player getplayerangles();
  cmd = "<dev string:x3ae>" + pos[0] + "<dev string:x3c1>" + pos[1] + "<dev string:x3c7>" + pos[2] + "<dev string:x3cd>" + angles[0] + "<dev string:x3d4>" + angles[1] + "<dev string:x3db>" + angles[2];
  ratrecordmessage(0, "<dev string:x3e2>", cmd);
  setdvar(#"rat_record_teleport_request", 0);
}

function_f52fc58b(params) {
  num = 0;

  if(isDefined(params)) {
    if(isDefined(params.num)) {
      num = int(params.num);
    }
  }

  if(num > 0) {
    adddebugcommand("<dev string:x3f1>" + num);
  }
}

function_dbc9b57c(params) {
  num = 0;

  if(isDefined(params)) {
    if(isDefined(params.num)) {
      num = int(params.num);
    }
  }

  if(num > 0) {
    adddebugcommand("<dev string:x410>" + num);
  }
}

function_458913b0(params) {
  player = getplayer(params);
  toggleplayercontrol(player);
}

function_9efe300c(params) {
  player = getplayer(params);
  spawn = 0;
  team = "<dev string:x42c>";

  if(isDefined(params) && isDefined(params.spawn)) {
    if(isDefined(params.spawn)) {
      spawn = int(params.spawn);
    }

    if(isDefined(params.team)) {
      team = params.team;
    }
  }

  if(isDefined(level.spawn_start) && isDefined(level.spawn_start[team])) {
    player setorigin(level.spawn_start[team][spawn].origin);
    player setplayerangles(level.spawn_start[team][spawn].angles);
  }
}

