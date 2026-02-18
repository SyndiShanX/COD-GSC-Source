/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\dev.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\dev_class;
#using scripts\cp_common\gametypes\loadout;
#using scripts\cp_common\util;
#namespace dev;

function private autoexec __init__system__() {
  system::register(#"dev", &preinit, undefined, undefined, #"spawning_shared");
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  if(getdvarstring(#"scr_show_hq_spawns") == "<dev string:x38>") {
    setDvar(#"scr_show_hq_spawns", "<dev string:x38>");
  }

  thread testscriptruntimeerror();
  thread testdvars();
  thread devhelipathdebugdraw();
  thread devstraferunpathdebugdraw();
  setDvar(#"scr_giveperk", "<dev string:x38>");
  setDvar(#"scr_forceevent", "<dev string:x38>");
  setDvar(#"scr_draw_triggers", 0);
  thread equipment_dev_gui();
  thread grenade_dev_gui();
  setDvar(#"debug_dynamic_ai_spawning", 0);
  level.dem_spawns = [];

  if(level.gametype == "<dev string:x3c>") {
    extra_spawns = [];
    extra_spawns[0] = "<dev string:x43>";
    extra_spawns[1] = "<dev string:x5e>";
    extra_spawns[2] = "<dev string:x79>";
    extra_spawns[3] = "<dev string:x94>";

    for(i = 0; i < extra_spawns.size; i++) {
      points = getEntArray(extra_spawns[i], "<dev string:xaf>");

      if(isDefined(points) && points.size > 0) {
        level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
      }
    }
  }

  callback::on_connect(&on_player_connect);

  for(;;) {
    updatedevsettings();
    wait 0.5;
  }
}

function on_player_connect() {}

function warpalltohost(team) {
  host = util::gethostplayer();
  warpalltoplayer(team, host.name);
}

function warpalltoplayer(team, player) {
  players = getplayers();
  target = undefined;

  for(i = 0; i < players.size; i++) {
    if(players[i].name == player) {
      target = players[i];
      break;
    }
  }

  if(isDefined(target)) {
    origin = target.origin;
    nodes = getnodesinradius(origin, 128, 32, 128, #"path");
    angles = target getplayerangles();
    yaw = (0, angles[1], 0);
    forward = anglesToForward(yaw);
    spawn_origin = origin + forward * 128 + (0, 0, 16);

    if(!bullettracepassed(target getEye(), spawn_origin, 0, target)) {
      spawn_origin = undefined;
    }

    for(i = 0; i < players.size; i++) {
      if(players[i] == target) {
        continue;
      }

      if(isDefined(team)) {
        if(strstartswith(team, "<dev string:xbc>") && target.team == players[i].team) {
          continue;
        }

        if(strstartswith(team, "<dev string:xc8>") && target.team != players[i].team) {
          continue;
        }
      }

      teleport = origin;

      if(isDefined(spawn_origin)) {
        teleport = spawn_origin;
      } else if(nodes.size > 0) {
        node = array::random(nodes);
        teleport = node.origin;
      }

      players[i] setorigin(teleport);

      if(players[i] isinvehicle()) {
        vehicle = players[i] getvehicleoccupied();
        vehicle.origin = origin;
      }
    }
  }

  setDvar(#"scr_playerwarp", "<dev string:x38>");
}

function updatedevsettingszm() {
  if(level.players.size > 0) {
    if(getdvarint(#"hash_6efff55aa118c517", 0) == 3) {
      if(!isDefined(level.streamdumpteamindex)) {
        level.streamdumpteamindex = 0;
      } else {
        level.streamdumpteamindex++;
      }

      numpoints = 0;
      spawnpoints = [];
      location = level.scr_zm_map_start_location;

      if((location == "<dev string:xd7>" || location == "<dev string:x38>") && isDefined(level.default_start_location)) {
        location = level.default_start_location;
      }

      match_string = level.scr_zm_ui_gametype + "<dev string:xe2>" + location;

      if(level.streamdumpteamindex < level.teams.size) {
        structs = struct::get_array("<dev string:xe7>", "<dev string:xf8>");

        if(isDefined(structs)) {
          foreach(struct in structs) {
            if(isDefined(struct.script_string)) {
              tokens = strtok(struct.script_string, "<dev string:x10d>");

              foreach(token in tokens) {
                if(token == match_string) {
                  spawnpoints[spawnpoints.size] = struct;
                }
              }
            }
          }
        }

        if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
          spawnpoints = struct::get_array("<dev string:x112>", "<dev string:x12a>");
        }

        if(isDefined(spawnpoints)) {
          numpoints = spawnpoints.size;
        }
      }

      if(numpoints == 0) {
        setDvar(#"hash_6efff55aa118c517", 0);
        level.streamdumpteamindex = -1;
        return;
      }

      averageorigin = (0, 0, 0);
      averageangles = (0, 0, 0);

      foreach(spawnpoint in spawnpoints) {
        averageorigin += spawnpoint.origin / numpoints;
        averageangles += spawnpoint.angles / numpoints;
      }

      level.players[0] setplayerangles(averageangles);
      level.players[0] setorigin(averageorigin);
      waitframe(1);
      setDvar(#"hash_6efff55aa118c517", 2);
    }
  }
}

function updatedevsettings() {
  show_spawns = getdvarint(#"scr_showspawns", 0);
  show_start_spawns = getdvarint(#"scr_showstartspawns", 0);
  player = util::gethostplayer();
  updateminimapsetting();

  if(level.players.size > 0) {
    if(getdvarstring(#"scr_playerwarp") == "<dev string:x138>") {
      warpalltohost();
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x140>") {
      warpalltohost(getdvarstring(#"scr_playerwarp"));
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x150>") {
      warpalltohost(getdvarstring(#"scr_playerwarp"));
    } else if(strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:xbc>")) {
      name = getsubstr(getdvarstring(#"scr_playerwarp"), 8);
      warpalltoplayer(getdvarstring(#"scr_playerwarp"), name);
    } else if(strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:xc8>")) {
      name = getsubstr(getdvarstring(#"scr_playerwarp"), 11);
      warpalltoplayer(getdvarstring(#"scr_playerwarp"), name);
    } else if(strstartswith(getdvarstring(#"scr_playerwarp"), "<dev string:x163>")) {
      name = getsubstr(getdvarstring(#"scr_playerwarp"), 4);
      warpalltoplayer(undefined, name);
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x16b>") {
      players = getplayers();
      setDvar(#"scr_playerwarp", "<dev string:x38>");

      if(!isDefined(level.devgui_start_spawn_index)) {
        level.devgui_start_spawn_index = 0;
      }

      player = util::gethostplayer();
      spawns = level.spawn_start[player.pers[# "team"]];

      if(!isDefined(spawns) || spawns.size <= 0) {
        return;
      }

      for(i = 0; i < players.size; i++) {
        players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
        players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
      }

      level.devgui_start_spawn_index++;

      if(level.devgui_start_spawn_index >= spawns.size) {
        level.devgui_start_spawn_index = 0;
      }
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x17f>") {
      players = getplayers();
      setDvar(#"scr_playerwarp", "<dev string:x38>");

      if(!isDefined(level.devgui_start_spawn_index)) {
        level.devgui_start_spawn_index = 0;
      }

      player = util::gethostplayer();
      spawns = level.spawn_start[player.pers[# "team"]];

      if(!isDefined(spawns) || spawns.size <= 0) {
        return;
      }

      for(i = 0; i < players.size; i++) {
        players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
        players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
      }

      level.devgui_start_spawn_index--;

      if(level.devgui_start_spawn_index < 0) {
        level.devgui_start_spawn_index = spawns.size - 1;
      }
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x193>") {
      players = getplayers();
      setDvar(#"scr_playerwarp", "<dev string:x38>");
      spawns = level.spawnpoints;
      spawns = arraycombine(spawns, level.dem_spawns, 1, 0);

      if(!isDefined(level.devgui_spawn_index)) {
        level.devgui_spawn_index = 0;
      } else {
        level.devgui_spawn_index++;

        if(level.devgui_spawn_index >= spawns.size) {
          level.devgui_spawn_index = 0;
        }
      }

      if(!isDefined(spawns) || spawns.size <= 0) {
        return;
      }

      for(i = 0; i < players.size; i++) {
        players[i] setorigin(spawns[level.devgui_spawn_index].origin);
        players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
      }
    } else if(getdvarstring(#"scr_playerwarp") == "<dev string:x1a1>") {
      players = getplayers();
      setDvar(#"scr_playerwarp", "<dev string:x38>");
      spawns = level.spawnpoints;
      spawns = arraycombine(spawns, level.dem_spawns, 1, 0);

      if(!isDefined(level.devgui_spawn_index)) {
        level.devgui_spawn_index = 0;
      } else {
        level.devgui_spawn_index--;

        if(level.devgui_spawn_index < 0) {
          level.devgui_spawn_index = spawns.size - 1;
        }
      }

      if(!isDefined(spawns) || spawns.size <= 0) {
        return;
      }

      for(i = 0; i < players.size; i++) {
        players[i] setorigin(spawns[level.devgui_spawn_index].origin);
        players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
      }
    } else if(getdvarstring(#"scr_devgui_spawn") != "<dev string:x38>") {
      player = util::gethostplayer();

      if(!isDefined(player.devgui_spawn_active)) {
        player.devgui_spawn_active = 0;
      }

      if(!player.devgui_spawn_active) {
        iprintln("<dev string:x1af>");
        iprintln("<dev string:x1d5>");
        player.devgui_spawn_active = 1;
        player thread devgui_spawn_think();
      } else {
        player notify(#"devgui_spawn_think");
        player.devgui_spawn_active = 0;
        player setactionslot(3, "<dev string:x1f8>");
      }

      setDvar(#"scr_devgui_spawn", "<dev string:x38>");
    } else if(getdvarstring(#"scr_player_ammo") != "<dev string:x38>") {
      players = getplayers();

      if(!isDefined(level.devgui_unlimited_ammo)) {
        level.devgui_unlimited_ammo = 1;
      } else {
        level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
      }

      if(level.devgui_unlimited_ammo) {
        iprintln("<dev string:x203>");
      } else {
        iprintln("<dev string:x22b>");
      }

      for(i = 0; i < players.size; i++) {
        if(level.devgui_unlimited_ammo) {
          players[i] thread devgui_unlimited_ammo();
          continue;
        }

        players[i] notify(#"devgui_unlimited_ammo");
      }

      setDvar(#"scr_player_ammo", "<dev string:x38>");
    } else if(getdvarstring(#"scr_give_player_score") != "<dev string:x38>") {
      setDvar(#"scr_give_player_score", "<dev string:x38>");
    } else if(getdvarstring(#"scr_player_zero_ammo") != "<dev string:x38>") {
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        player = players[i];
        weapons = player getweaponslist();
        arrayremovevalue(weapons, level.weaponbasemelee);

        for(j = 0; j < weapons.size; j++) {
          if(weapons[j] == level.weaponnone) {
            continue;
          }

          player setweaponammostock(weapons[j], 0);
          player setweaponammoclip(weapons[j], 0);
        }
      }

      setDvar(#"scr_player_zero_ammo", "<dev string:x38>");
    } else if(getdvarstring(#"scr_emp_jammed") != "<dev string:x38>") {
      players = getplayers();

      for(i = 0; i < players.size; i++) {
        player = players[i];

        if(getdvarint(#"scr_emp_jammed", 0) == 0) {
          player setempjammed(0);
          continue;
        }

        player setempjammed(1);
      }

      setDvar(#"scr_emp_jammed", "<dev string:x38>");
    }

    if(getdvarint(#"hash_6efff55aa118c517", 0) == 3) {
      if(!isDefined(level.streamdumpteamindex)) {
        level.streamdumpteamindex = 0;
      } else {
        level.streamdumpteamindex++;
      }

      numpoints = 0;

      if(level.streamdumpteamindex < level.teams.size) {
        teamname = getarraykeys(level.teams)[level.streamdumpteamindex];

        if(isDefined(level.spawn_start[teamname])) {
          numpoints = level.spawn_start[teamname].size;
        }
      }

      if(numpoints == 0) {
        setDvar(#"hash_6efff55aa118c517", 0);
        level.streamdumpteamindex = -1;
      } else {
        averageorigin = (0, 0, 0);
        averageangles = (0, 0, 0);

        foreach(spawnpoint in level.spawn_start[teamname]) {
          averageorigin += spawnpoint.origin / numpoints;
          averageangles += spawnpoint.angles / numpoints;
        }

        level.players[0] setplayerangles(averageangles);
        level.players[0] setorigin(averageorigin);
        waitframe(1);
        setDvar(#"hash_6efff55aa118c517", 2);
      }
    }
  }

  if(getdvarstring(#"scr_forceevent") != "<dev string:x38>") {
    event = getdvarstring(#"scr_forceevent");
    player = util::gethostplayer();
    forward = anglesToForward(player.angles);
    right = anglestoright(player.angles);

    if(event == "<dev string:x256>") {
      player dodamage(1, player.origin + forward);
    } else if(event == "<dev string:x263>") {
      player dodamage(1, player.origin - forward);
    } else if(event == "<dev string:x26f>") {
      player dodamage(1, player.origin - right);
    } else if(event == "<dev string:x27b>") {
      player dodamage(1, player.origin + right);
    }

    setDvar(#"scr_forceevent", "<dev string:x38>");
  }

  if(getdvarstring(#"scr_takeperk") != "<dev string:x38>") {
    perk = getdvarstring(#"scr_takeperk");

    for(i = 0; i < level.players.size; i++) {
      level.players[i] unsetperk(perk);
      level.players[i].extraperks[perk] = undefined;
    }

    setDvar(#"scr_takeperk", "<dev string:x38>");
  }

  if(getdvarstring(#"scr_x_kills_y") != "<dev string:x38>") {
    nametokens = strtok(getdvarstring(#"scr_x_kills_y"), "<dev string:x10d>");

    if(nametokens.size > 1) {
      thread xkillsy(nametokens[0], nametokens[1]);
    }

    setDvar(#"scr_x_kills_y", "<dev string:x38>");
  }

  if(getdvarstring(#"scr_entdebug") != "<dev string:x38>") {
    ents = getEntArray();
    level.entarray = [];
    level.entcounts = [];
    level.entgroups = [];

    for(index = 0; index < ents.size; index++) {
      classname = ents[index].classname;

      if(!issubstr(classname, "<dev string:x288>")) {
        curent = ents[index];
        level.entarray[level.entarray.size] = curent;

        if(!isDefined(level.entcounts[classname])) {
          level.entcounts[classname] = 0;
        }

        level.entcounts[classname]++;

        if(!isDefined(level.entgroups[classname])) {
          level.entgroups[classname] = [];
        }

        level.entgroups[classname][level.entgroups[classname].size] = curent;
      }
    }
  }

  if(getdvarstring(#"scr_givetalent") == "<dev string:x292>") {
    players = getplayers();
    iprintln("<dev string:x297>");

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      player cleartalents();
      player loadout::giveloadout(player.team, player.curclass);
    }

    setDvar(#"scr_givetalent", "<dev string:x38>");
  }

  if(getdvarstring(#"scr_givetalent") != "<dev string:x38>") {
    talentname = getdvarstring(#"scr_givetalent");
    var_2fe3f7e3 = hash(talentname);
    players = getplayers();
    iprintln("<dev string:x2bd>" + talentname + "<dev string:x2dc>");

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      player addtalent(var_2fe3f7e3);
      player loadout::giveloadout(player.team, player.curclass);
    }

    setDvar(#"scr_givetalent", "<dev string:x38>");
  }
}

function waitthennotifyroundkillcam() {
  waitframe(1);
  level notify(#"play_final_killcam");
  setDvar(#"scr_force_roundkillcam", 0);
}

function waitthennotifyfinalkillcam() {
  waitframe(1);
  level notify(#"play_final_killcam");
  waitframe(1);
  setDvar(#"scr_force_finalkillcam", 0);
}

function devgui_spawn_think() {
  self notify(#"devgui_spawn_think");
  self endon(#"devgui_spawn_think", #"disconnect");
  dpad_left = 0;
  dpad_right = 0;

  for(;;) {
    self setactionslot(3, "<dev string:x38>");
    self setactionslot(4, "<dev string:x38>");

    if(!dpad_left && self buttonPressed("<dev string:x2e1>")) {
      setDvar(#"scr_playerwarp", "<dev string:x1a1>");
      dpad_left = 1;
    } else if(!self buttonPressed("<dev string:x2e1>")) {
      dpad_left = 0;
    }

    if(!dpad_right && self buttonPressed("<dev string:x2ee>")) {
      setDvar(#"scr_playerwarp", "<dev string:x193>");
      dpad_right = 1;
    } else if(!self buttonPressed("<dev string:x2ee>")) {
      dpad_right = 0;
    }

    waitframe(1);
  }
}

function devgui_unlimited_ammo() {
  self notify(#"devgui_unlimited_ammo");
  self endon(#"devgui_unlimited_ammo", #"disconnect");

  for(;;) {
    wait 1;
    primary_weapons = self getweaponslistprimaries();
    offhand_weapons_and_alts = array::exclude(self getweaponslist(1), primary_weapons);
    weapons = arraycombine(primary_weapons, offhand_weapons_and_alts, 0, 0);
    arrayremovevalue(weapons, level.weaponbasemelee);

    for(i = 0; i < weapons.size; i++) {
      weapon = weapons[i];

      if(weapon == level.weaponnone) {
        continue;
      }

      self givemaxammo(weapon);
    }
  }
}

function devgui_health_debug() {
  self notify(#"devgui_health_debug");
  self endon(#"devgui_health_debug", #"disconnect");
  x = 80;
  y = 40;
  self.debug_health_bar = newdebughudelem(self);
  self.debug_health_bar.x = x + 80;
  self.debug_health_bar.y = y + 2;
  self.debug_health_bar.alignx = "<dev string:x2fc>";
  self.debug_health_bar.aligny = "<dev string:x304>";
  self.debug_health_bar.horzalign = "<dev string:x30b>";
  self.debug_health_bar.vertalign = "<dev string:x30b>";
  self.debug_health_bar.alpha = 1;
  self.debug_health_bar.foreground = 1;
  self.debug_health_bar setshader(#"black", 1, 8);
  self.debug_health_text = newdebughudelem(self);
  self.debug_health_text.x = x + 80;
  self.debug_health_text.y = y;
  self.debug_health_text.alignx = "<dev string:x2fc>";
  self.debug_health_text.aligny = "<dev string:x304>";
  self.debug_health_text.horzalign = "<dev string:x30b>";
  self.debug_health_text.vertalign = "<dev string:x30b>";
  self.debug_health_text.alpha = 1;
  self.debug_health_text.fontscale = 1;
  self.debug_health_text.foreground = 1;

  if(!isDefined(self.maxhealth) || self.maxhealth <= 0) {
    self.maxhealth = 100;
  }

  for(;;) {
    waitframe(1);
    width = self.health / self.maxhealth * 300;
    width = int(max(width, 1));
    self.debug_health_bar setshader(#"black", width, 8);
    self.debug_health_text setvalue(self.health);
  }
}

function giveextraperks() {
  if(!isDefined(self.extraperks)) {
    return;
  }

  perks = getarraykeys(self.extraperks);

  for(i = 0; i < perks.size; i++) {
    println("<dev string:x319>" + self.name + "<dev string:x327>" + perks[i] + "<dev string:x335>");
    self setperk(perks[i]);
  }
}

function xkillsy(attackername, victimname) {
  attacker = undefined;
  victim = undefined;

  for(index = 0; index < level.players.size; index++) {
    if(level.players[index].name == attackername) {
      attacker = level.players[index];
      continue;
    }

    if(level.players[index].name == victimname) {
      victim = level.players[index];
    }
  }

  if(!isalive(attacker) || !isalive(victim)) {
    return;
  }

  victim thread[[level.callbackplayerdamage]](attacker, attacker, 1000, 0, "<dev string:x346>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x35a>", (0, 0, 0), 0, 0, (1, 0, 0));
}

function testscriptruntimeerrorassert() {
  wait 1;
  assert(0);
}

function testscriptruntimeerror2() {
  myundefined = "<dev string:x362>";

  if(myundefined == 1) {
    println("<dev string:x36a>");
  }
}

function testscriptruntimeerror1() {
  testscriptruntimeerror2();
}

function testscriptruntimeerror() {
  wait 5;

  for(;;) {
    if(getdvarstring(#"scr_testscriptruntimeerror", "<dev string:x35a>") != "<dev string:x35a>") {
      break;
    }

    wait 1;
  }

  myerror = getdvarstring(#"scr_testscriptruntimeerror");
  setDvar(#"scr_testscriptruntimeerror", "<dev string:x35a>");

  if(myerror == "<dev string:x393>") {
    testscriptruntimeerrorassert();
  } else {
    testscriptruntimeerror1();
  }

  thread testscriptruntimeerror();
}

function testdvars() {
  wait 5;

  for(;;) {
    if(getdvarstring(#"scr_testdvar") != "<dev string:x38>") {
      break;
    }

    wait 1;
  }

  tokens = strtok(getdvarstring(#"scr_testdvar"), "<dev string:x10d>");
  dvarname = tokens[0];
  dvarvalue = tokens[1];
  setDvar(dvarname, dvarvalue);
  setDvar(#"scr_testdvar", "<dev string:x38>");
  thread testdvars();
}

function showonespawnpoint(spawn_point, color, notification, height, print) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(print)) {
    print = spawn_point.classname;
  }

  center = spawn_point.origin;
  forward = anglesToForward(spawn_point.angles);
  right = anglestoright(spawn_point.angles);
  forward = vectorscale(forward, 16);
  right = vectorscale(right, 16);
  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
  a += (0, 0, height);
  b += (0, 0, height);
  c += (0, 0, height);
  d += (0, 0, height);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  center += (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = center + arrowhead_forward - arrowhead_right;
  c = center + arrowhead_forward + arrowhead_right;
  thread lineuntilnotified(center, a, color, 0, notification);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(a, c, color, 0, notification);
  thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
  return;
}

function print3duntilnotified(origin, text, color, alpha, scale, notification) {
  level endon(notification);

  for(;;) {
    print3d(origin, text, color, alpha, scale);
    waitframe(1);
  }
}

function lineuntilnotified(start, end, color, depthtest, notification) {
  level endon(notification);

  for(;;) {
    line(start, end, color, depthtest);
    waitframe(1);
  }
}

function dvar_turned_on(val) {
  if(val <= 0) {
    return 0;
  }

  return 1;
}

function new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array)) {
    level.hud_array = [];
  }

  if(!isDefined(level.hud_array[hud_name])) {
    level.hud_array[hud_name] = [];
  }

  hud = set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
  if(!isDefined(sort)) {
    sort = 1;
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(debug_hudelem)) {
    debug_hudelem = 20;
  }

  hud = newdebughudelem();
  hud.debug_hudelem = 1;
  hud.location = 0;
  hud.alignx = "<dev string:x2fc>";
  hud.aligny = "<dev string:x39d>";
  hud.foreground = 1;
  hud.fontscale = alpha;
  hud.sort = debug_hudelem;
  hud.alpha = sort;
  hud.x = y;
  hud.y = scale;
  hud.og_scale = alpha;

  if(isDefined(x)) {
    hud settext(x);
  }

  return hud;
}

function print_weapon_name() {
  self notify(#"print_weapon_name");
  self endon(#"print_weapon_name");
  wait 0.2;

  if(self isswitchingweapons()) {
    waitresult = self waittill(#"weapon_change_complete");
    fail_safe = 0;

    while(waitresult.weapon == level.weaponnone) {
      waitresult = self waittill(#"weapon_change_complete");
      waitframe(1);
      fail_safe++;

      if(fail_safe > 120) {
        break;
      }
    }
  } else {
    weapon = self getcurrentweapon();
  }

  printweaponname = getdvarint(#"scr_print_weapon_name", 1);

  if(printweaponname) {
    iprintlnbold(weapon.name);
  }
}

function set_equipment_list() {
  if(isDefined(level.dev_equipment)) {
    return;
  }

  level.dev_equipment = [];
}

function set_grenade_list() {
  if(isDefined(level.dev_grenade)) {
    return;
  }

  level.dev_grenade = [];
  level.dev_grenade[1] = getweapon(#"frag_grenade");
  level.dev_grenade[6] = getweapon(#"flash_grenade");
}

function take_all_grenades_and_equipment(player) {
  for(i = 0; i < level.dev_equipment.size; i++) {
    player takeweapon(level.dev_equipment[i + 1]);
  }

  for(i = 0; i < level.dev_grenade.size; i++) {
    player takeweapon(level.dev_grenade[i + 1]);
  }
}

function equipment_dev_gui() {
  set_equipment_list();
  set_grenade_list();
  setDvar(#"scr_give_equipment", "<dev string:x38>");

  while(true) {
    wait 0.5;
    devgui_int = getdvarint(#"scr_give_equipment", 0);

    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_equipment[devgui_int]);
      }

      setDvar(#"scr_give_equipment", 0);
    }
  }
}

function grenade_dev_gui() {
  set_equipment_list();
  set_grenade_list();
  setDvar(#"scr_give_grenade", "<dev string:x38>");

  while(true) {
    wait 0.5;
    devgui_int = getdvarint(#"scr_give_grenade", 0);

    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_grenade[devgui_int]);
      }

      setDvar(#"scr_give_grenade", 0);
    }
  }
}

function devstraferunpathdebugdraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);
  violet = (0.4, 0, 0.6);
  maxdrawtime = 10;
  drawtime = maxdrawtime;
  origintextoffset = (0, 0, -50);
  endonmsg = "<dev string:x3a7>";

  while(true) {
    if(getdvarint(#"scr_devstraferunpathdebugdraw", 0) > 0) {
      nodes = [];
      end = 0;
      node = getvehiclenode("<dev string:x3c8>", "<dev string:x12a>");

      if(!isDefined(node)) {
        println("<dev string:x3d9>");
        setDvar(#"scr_devstraferunpathdebugdraw", 0);
        continue;
      }

      while(isDefined(node.target)) {
        new_node = getvehiclenode(node.target, "<dev string:x12a>");

        foreach(n in nodes) {
          if(n == new_node) {
            end = 1;
          }
        }

        textscale = 30;

        if(drawtime == maxdrawtime) {
          node thread drawpathsegment(new_node, violet, violet, 1, textscale, origintextoffset, drawtime, endonmsg);
        }

        if(isDefined(node.script_noteworthy)) {
          textscale = 10;

          switch (node.script_noteworthy) {
            case # "strafe_start":
              textcolor = green;
              textalpha = 1;
              break;
            case # "strafe_stop":
              textcolor = red;
              textalpha = 1;
              break;
            case # "strafe_leave":
              textcolor = white;
              textalpha = 1;
              break;
          }

          switch (node.script_noteworthy) {
            case # "strafe_stop":
            case # "strafe_leave":
            case # "strafe_start":
              sides = 10;
              radius = 100;

              if(drawtime == maxdrawtime) {
                sphere(node.origin, radius, textcolor, textalpha, 1, sides, drawtime * 1000);
              }

              node draworiginlines();
              node drawnoteworthytext(textcolor, textalpha, textscale);
              break;
          }
        }

        if(end) {
          break;
        }

        nodes[nodes.size] = new_node;
        node = new_node;
      }

      drawtime -= 0.05;

      if(drawtime < 0) {
        drawtime = maxdrawtime;
      }

      waitframe(1);
      continue;
    }

    wait 1;
  }
}

function devhelipathdebugdraw() {
  white = (1, 1, 1);
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);
  textcolor = white;
  textalpha = 1;
  textscale = 1;
  maxdrawtime = 10;
  drawtime = maxdrawtime;
  origintextoffset = (0, 0, -50);
  endonmsg = "<dev string:x3f5>";

  while(true) {
    if(getdvarint(#"scr_devhelipathsdebugdraw", 0) > 0) {
      script_origins = getEntArray("<dev string:x412>", "<dev string:xaf>");

      foreach(ent in script_origins) {
        if(isDefined(ent.targetname)) {
          switch (ent.targetname) {
            case # "heli_start":
              textcolor = blue;
              textalpha = 1;
              textscale = 3;
              break;
            case # "heli_loop_start":
              textcolor = green;
              textalpha = 1;
              textscale = 3;
              break;
            case # "heli_attack_area":
              textcolor = red;
              textalpha = 1;
              textscale = 3;
              break;
            case # "heli_leave":
              textcolor = white;
              textalpha = 1;
              textscale = 3;
              break;
          }

          switch (ent.targetname) {
            case # "heli_leave":
            case # "heli_attack_area":
            case # "heli_start":
            case # "heli_loop_start":
              if(drawtime == maxdrawtime) {
                ent thread drawpath(textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg);
              }

              ent draworiginlines();
              ent drawtargetnametext(textcolor, textalpha, textscale);
              ent draworigintext(textcolor, textalpha, textscale, origintextoffset);
              break;
          }
        }
      }

      drawtime -= 0.05;

      if(drawtime < 0) {
        drawtime = maxdrawtime;
      }
    }

    if(getdvarint(#"scr_devhelipathsdebugdraw", 0) == 0) {
      level notify(endonmsg);
      drawtime = maxdrawtime;
      wait 1;
    }

    waitframe(1);
  }
}

function draworiginlines() {
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);
  line(self.origin, self.origin + anglesToForward(self.angles) * 10, red);
  line(self.origin, self.origin + anglestoright(self.angles) * 10, green);
  line(self.origin, self.origin + anglestoup(self.angles) * 10, blue);
}

function drawtargetnametext(textcolor, textalpha, textscale, textoffset) {
  if(!isDefined(textoffset)) {
    textoffset = (0, 0, 0);
  }

  print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
}

function drawnoteworthytext(textcolor, textalpha, textscale, textoffset) {
  if(!isDefined(textoffset)) {
    textoffset = (0, 0, 0);
  }

  print3d(self.origin + textoffset, self.script_noteworthy, textcolor, textalpha, textscale);
}

function draworigintext(textcolor, textalpha, textscale, textoffset) {
  if(!isDefined(textoffset)) {
    textoffset = (0, 0, 0);
  }

  originstring = "<dev string:x423>" + self.origin[0] + "<dev string:x428>" + self.origin[1] + "<dev string:x428>" + self.origin[2] + "<dev string:x42e>";
  print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
}

function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
  if(isDefined(self.script_airspeed)) {
    print3d(self.origin + (0, 0, textoffset[2] * 2), "<dev string:x433>" + self.script_airspeed, textcolor, textalpha, textscale);
  }

  if(isDefined(self.script_accel)) {
    print3d(self.origin + (0, 0, textoffset[2] * 3), "<dev string:x447>" + self.script_accel, textcolor, textalpha, textscale);
  }
}

function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
  level endon(endonmsg);
  ent = self;
  entfirsttarget = ent.targetname;

  while(isDefined(ent.target)) {
    enttarget = getent(ent.target, "<dev string:x12a>");
    ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);

    if(ent.targetname == "<dev string:x458>") {
      entfirsttarget = ent.target;
    } else if(ent.target == entfirsttarget) {
      break;
    }

    ent = enttarget;
    waitframe(1);
  }
}

function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
  level endon(endonmsg);

  while(drawtime > 0) {
    if(isDefined(self.targetname) && self.targetname == "<dev string:x3c8>") {
      print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }

    line(self.origin, enttarget.origin, linecolor);
    self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
    drawtime -= 0.05;
    waitframe(1);
  }
}