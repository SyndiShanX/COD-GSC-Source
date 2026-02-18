/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\rat_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace rat;

function init() {
  if(!isDefined(level.rat)) {
    level.rat = spawnStruct();
    level.rat.common = spawnStruct();
    level.rat.script_command_list = [];
    level.rat.playerskilled = 0;
    level.rat.var_cd4fd549 = 0;
    callback::on_player_killed(&function_cecf7c3d);
    level.rat.var_44083397 = [];
    addratscriptcmd("<dev string:x38>", &function_5fd1a95b);
    addratscriptcmd("<dev string:x4e>", &rscteleport);
    addratscriptcmd("<dev string:x5a>", &function_51706559);
    addratscriptcmd("<dev string:x6a>", &function_b2fe8b5a);
    addratscriptcmd("<dev string:x77>", &function_bff535fb);
    addratscriptcmd("<dev string:x87>", &function_220d66d8);
    addratscriptcmd("<dev string:x94>", &function_be6e2f9f);
    addratscriptcmd("<dev string:xa0>", &function_ff0fa082);
    addratscriptcmd("<dev string:xb1>", &function_aecb1023);
    addratscriptcmd("<dev string:xc6>", &function_90282828);
    addratscriptcmd("<dev string:xda>", &function_3b51dc31);
    addratscriptcmd("<dev string:xe9>", &function_a6d4d86b);
    addratscriptcmd("<dev string:xfb>", &function_54b7f226);
    addratscriptcmd("<dev string:x110>", &function_1b77bedd);
    addratscriptcmd("<dev string:x124>", &rscsimulatescripterror);
    addratscriptcmd("<dev string:x13b>", &function_1f00a502);
    addratscriptcmd("<dev string:x150>", &function_696e6dd3);
    addratscriptcmd("<dev string:x15d>", &function_dec22d87);
    addratscriptcmd("<dev string:x174>", &function_e3ab4393);
    addratscriptcmd("<dev string:x18d>", &function_d5c8e330);
    addratscriptcmd("<dev string:x19f>", &function_dff6f575);
    addratscriptcmd("<dev string:x1ab>", &function_d197a150);
    addratscriptcmd("<dev string:x1be>", &function_c4336b49);
    addratscriptcmd("<dev string:x1ce>", &function_ccc178f3);
    addratscriptcmd("<dev string:x1e6>", &function_2fa64525);
    addratscriptcmd("<dev string:x1f6>", &function_6fb461e2);
    addratscriptcmd("<dev string:x20a>", &function_f52fc58b);
    addratscriptcmd("<dev string:x21f>", &function_dbc9b57c);
    addratscriptcmd("<dev string:x231>", &function_4f3a7675);
    addratscriptcmd("<dev string:x241>", &function_458913b0);
    addratscriptcmd("<dev string:x258>", &function_191d6974);
    addratscriptcmd("<dev string:x265>", &function_d1b632ff);
    addratscriptcmd("<dev string:x277>", &function_7d9a084b);
    addratscriptcmd("<dev string:x28e>", &function_1ac5a32b);
    addratscriptcmd("<dev string:x2a7>", &function_7992a479);
    addratscriptcmd("<dev string:x2b5>", &function_9efe300c);
  }
}

function function_7d22c1c9() {
  level flag::set("<dev string:x2c8>");
}

function function_65e13d0f() {
  level flag::clear("<dev string:x2c8>");
}

function function_b4f2a076() {
  level flag::set("<dev string:x2e6>");
}

function function_6aa20375() {
  level flag::clear("<dev string:x2e6>");
}

function addratscriptcmd(commandname, functioncallback) {
  init();
  level.rat.script_command_list[commandname] = functioncallback;
}

function event_handler[rat_scriptcommand] codecallback_ratscriptcommand(params) {
  init();
  assert(isDefined(params._cmd));
  assert(isDefined(params._id));
  assert(isDefined(level.rat.script_command_list[params._cmd]), "<dev string:x302>" + params._cmd);
  callback = level.rat.script_command_list[params._cmd];
  ret = level[[callback]](params);
  ratreportcommandresult(params._id, 1, ret);
}

function getplayer(params) {
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

    ratreportcommandresult(params._id, 0, "<dev string:x321>");
    wait 1;
    return;
  }

  return util::gethostplayer();
}

function function_5fd1a95b(params) {
  foreach(cmd, func in level.rat.script_command_list) {
    function_55e20e75(params._id, cmd);
  }
}

function function_7992a479(params) {
  player = getplayer(params);
  weapon = getweapon(params.weaponname);
  player giveweapon(weapon);
}

function function_1b77bedd(params) {
  if(isDefined(level.inprematchperiod)) {
    return level.inprematchperiod;
  }
}

function rscteleport(params) {
  player = getplayer(params);
  pos = (float(params.x), float(params.y), float(params.z));
  player setorigin(pos);

  if(isDefined(params.ax)) {
    angles = (float(params.ax), float(params.ay), float(params.az));
    player setplayerangles(angles);
  }
}

function function_696e6dd3(params) {
  player = getplayer(params);
  player setstance(params.stance);
}

function function_b2fe8b5a(params) {
  player = getplayer(params);
  return player getstance();
}

function function_ccc8790a(params) {
  level endon(#"hash_5ce872746ed86569");
  player = getplayer(params);
  xuid = int(player getxuid(1));
  level.rat.var_44083397[xuid] = 0;

  while(!level.rat.var_44083397[xuid]) {
    level.rat.var_44083397[xuid] = player ismeleeing();
    wait 0.01;
  }
}

function function_d5c8e330(params) {
  level thread function_ccc8790a(params);
}

function function_dff6f575(params) {
  player = getplayer(params);
  xuid = int(player getxuid(1));
  var_faf86e88 = level.rat.var_44083397[xuid];

  if(!var_faf86e88) {
    level notify(#"hash_5ce872746ed86569");
  }

  return var_faf86e88;
}

function function_bff535fb(params) {
  player = getplayer(params);
  return player playerads();
}

function function_220d66d8(params) {
  player = getplayer(params);
  return player.health;
}

function function_be6e2f9f(params) {
  player = getplayer(params);

  if(isDefined(params.amount)) {
    player dodamage(int(params.amount), player getorigin());
    return;
  }

  player dodamage(1, player getorigin());
}

function function_ff0fa082(params) {
  player = getplayer(params);

  if(!isDefined(player)) {
    return "<dev string:x349>";
  }

  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon.name)) {
    return currentweapon.name;
  }
}

function function_7d9a084b(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon.name)) {
    return currentweapon.reloadtime;
  }
}

function function_aecb1023(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getammocount(currentweapon);
}

function function_90282828(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getweaponammoclip(currentweapon);
}

function function_3b51dc31(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getweaponammoclipsize(currentweapon);
}

function function_54b7f226(params) {
  player = getplayer(params);
  origin = player getorigin();
  function_55e20e75(params._id, origin);
  angles = player getplayerangles();
  function_55e20e75(params._id, angles);
}

function function_a6d4d86b(params) {
  if(isDefined(params.var_185699f8)) {
    return getnumconnectedplayers(1);
  }

  return getnumconnectedplayers(0);
}

function function_cecf7c3d(params) {
  if(isDefined(self.bot)) {
    level.rat.var_cd4fd549 += 1;
    return;
  }

  level.rat.playerskilled += 1;
}

function function_d197a150(params) {
  return level.rat.playerskilled;
}

function function_c4336b49(params) {
  return level.rat.var_cd4fd549;
}

function function_51706559(params) {
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

function function_dec22d87(params) {
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

function function_e3ab4393(params) {
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

  ratreportcommandresult(params._id, 0, "<dev string:x34d>");
}

function function_1ac5a32b(params) {
  player = getplayer(params);
  forward = anglesToForward(player.angles);
  distance = 50;

  if(isDefined(params.distance)) {
    distance = float(params.distance);
  }

  front = player.origin + forward * distance;
  player setorigin(front);
}

function function_ccc178f3(params) {
  player = getplayer(params);
  return player isplayinganimscripted();
}

function function_6fb461e2(params) {
  player = getplayer(params);

  if(isDefined(player)) {
    return !player arecontrolsfrozen();
  }

  return 0;
}

function function_2fa64525(params) {
  if(isDefined(params.flag)) {
    return flag::get(params.flag);
  }
}

function function_1f00a502(params) {
  foreach(player in getplayers()) {
    if(isbot(player)) {
      return player.health;
    }
  }

  return -1;
}

function function_4f3a7675(params) {
  if(isDefined(level.var_5efad16e)) {
    level[[level.var_5efad16e]]();
    return 1;
  }

  return 0;
}

function function_d04e8397(name) {
  level flag::set("<dev string:x37e>");
  level scene::play(name);
  level flag::clear("<dev string:x37e>");
}

function function_191d6974(params) {
  if(isDefined(params.name)) {
    level thread function_d04e8397(params.name);
    return;
  }

  ratreportcommandresult(params._id, 0, "<dev string:x38b>");
}

function function_d1b632ff(params) {
  return flag::get("<dev string:x37e>");
}

function rscsimulatescripterror(params) {
  if(params.errorlevel == "<dev string:x3a5>") {
    assertmsg("<dev string:x3ae>");
    return;
  }

  thisdoesntexist.orthis = 0;
}

function rscrecteleport(params) {
  println("<dev string:x3ca>");
  player = [[level.rat.common.gethostplayer]]();
  pos = player getorigin();
  angles = player getplayerangles();
  cmd = "<dev string:x3ef>" + pos[0] + "<dev string:x403>" + pos[1] + "<dev string:x40a>" + pos[2] + "<dev string:x411>" + angles[0] + "<dev string:x419>" + angles[1] + "<dev string:x421>" + angles[2];
  ratrecordmessage(0, "<dev string:x429>", cmd);
  setDvar(#"rat_record_teleport_request", 0);
}

function function_f52fc58b(params) {
  num = 0;

  if(isDefined(params)) {
    if(isDefined(params.num)) {
      num = int(params.num);
    }
  }

  if(num > 0) {
    adddebugcommand("<dev string:x439>" + num);
  }
}

function function_dbc9b57c(params) {
  num = 0;

  if(isDefined(params)) {
    if(isDefined(params.num)) {
      num = int(params.num);
    }
  }

  if(num > 0) {
    adddebugcommand("<dev string:x459>" + num);
  }
}

function function_458913b0(params) {
  player = getplayer(params);
  toggleplayercontrol(player);
}

function function_9efe300c(params) {
  player = getplayer(params);
  spawn = 0;
  team = "<dev string:x476>";

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