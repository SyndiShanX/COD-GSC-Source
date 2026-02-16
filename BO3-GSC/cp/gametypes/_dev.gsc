/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_dev.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_dev_class;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\callbacks_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace dev;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, "");
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  thread testscriptruntimeerror();
  thread testdvars();
  thread devhelipathdebugdraw();
  thread devstraferunpathdebugdraw();
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  thread equipment_dev_gui();
  thread grenade_dev_gui();
  setDvar("", "");
  level.dem_spawns = [];
  if(level.gametype == "") {
    extra_spawns = [];
    extra_spawns[0] = "";
    extra_spawns[1] = "";
    extra_spawns[2] = "";
    extra_spawns[3] = "";
    for(i = 0; i < extra_spawns.size; i++) {
      points = getEntArray(extra_spawns[i], "");
      if(isDefined(points) && points.size > 0) {
        level.dem_spawns = arraycombine(level.dem_spawns, points, 1, 0);
      }
    }
  }
  callback::on_connect(&on_player_connect);
  for(;;) {
    updatedevsettings();
    wait(0.5);
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
    nodes = getnodesinradius(origin, 128, 32, 128, "");
    angles = target getplayerangles();
    yaw = (0, angles[1], 0);
    forward = anglesToForward(yaw);
    spawn_origin = (origin + (forward * 128)) + vectorscale((0, 0, 1), 16);
    if(!bullettracepassed(target getEye(), spawn_origin, 0, target)) {
      spawn_origin = undefined;
    }
    for(i = 0; i < players.size; i++) {
      if(players[i] == target) {
        continue;
      }
      if(isDefined(team)) {
        if(strstartswith(team, "") && target.team == players[i].team) {
          continue;
        }
        if(strstartswith(team, "") && target.team != players[i].team) {
          continue;
        }
      }
      if(isDefined(spawn_origin)) {
        players[i] setorigin(spawn_origin);
        continue;
      }
      if(nodes.size > 0) {
        node = array::random(nodes);
        players[i] setorigin(node.origin);
        continue;
      }
      players[i] setorigin(origin);
    }
  }
  setDvar("", "");
}

function updatedevsettingszm() {
  if(level.players.size > 0) {
    if(getdvarstring("") == "") {
      if(!isDefined(level.streamdumpteamindex)) {
        level.streamdumpteamindex = 0;
      } else {
        level.streamdumpteamindex++;
      }
      numpoints = 0;
      spawnpoints = [];
      location = level.scr_zm_map_start_location;
      if(location == "" || location == "" && isDefined(level.default_start_location)) {
        location = level.default_start_location;
      }
      match_string = (level.scr_zm_ui_gametype + "") + location;
      if(level.streamdumpteamindex < level.teams.size) {
        structs = struct::get_array("", "");
        if(isDefined(structs)) {
          foreach(struct in structs) {
            if(isDefined(struct.script_string)) {
              tokens = strtok(struct.script_string, "");
              foreach(token in tokens) {
                if(token == match_string) {
                  spawnpoints[spawnpoints.size] = struct;
                }
              }
            }
          }
        }
        if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
          spawnpoints = struct::get_array("", "");
        }
        if(isDefined(spawnpoints)) {
          numpoints = spawnpoints.size;
        }
      }
      if(numpoints == 0) {
        setDvar("", "");
        level.streamdumpteamindex = -1;
      } else {
        averageorigin = (0, 0, 0);
        averageangles = (0, 0, 0);
        foreach(spawnpoint in spawnpoints) {
          averageorigin = averageorigin + (spawnpoint.origin / numpoints);
          averageangles = averageangles + (spawnpoint.angles / numpoints);
        }
        level.players[0] setplayerangles(averageangles);
        level.players[0] setorigin(averageorigin);
        wait(0.05);
        setDvar("", "");
      }
    }
  }
}

function updatedevsettings() {
  show_spawns = getdvarint("");
  show_start_spawns = getdvarint("");
  player = util::gethostplayer();
  updateminimapsetting();
  if(level.players.size > 0) {
    if(getdvarstring("") == "") {
      warpalltohost();
    } else {
      if(getdvarstring("") == "") {
        warpalltohost(getdvarstring(""));
      } else {
        if(getdvarstring("") == "") {
          warpalltohost(getdvarstring(""));
        } else {
          if(strstartswith(getdvarstring(""), "")) {
            name = getsubstr(getdvarstring(""), 8);
            warpalltoplayer(getdvarstring(""), name);
          } else {
            if(strstartswith(getdvarstring(""), "")) {
              name = getsubstr(getdvarstring(""), 11);
              warpalltoplayer(getdvarstring(""), name);
            } else {
              if(strstartswith(getdvarstring(""), "")) {
                name = getsubstr(getdvarstring(""), 4);
                warpalltoplayer(undefined, name);
              } else {
                if(getdvarstring("") == "") {
                  players = getplayers();
                  setDvar("", "");
                  if(!isDefined(level.devgui_start_spawn_index)) {
                    level.devgui_start_spawn_index = 0;
                  }
                  player = util::gethostplayer();
                  spawns = level.spawn_start[player.pers[""]];
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
                } else {
                  if(getdvarstring("") == "") {
                    players = getplayers();
                    setDvar("", "");
                    if(!isDefined(level.devgui_start_spawn_index)) {
                      level.devgui_start_spawn_index = 0;
                    }
                    player = util::gethostplayer();
                    spawns = level.spawn_start[player.pers[""]];
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
                  } else {
                    if(getdvarstring("") == "") {
                      players = getplayers();
                      setDvar("", "");
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
                    } else {
                      if(getdvarstring("") == "") {
                        players = getplayers();
                        setDvar("", "");
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
                      } else {
                        if(getdvarstring("") != "") {
                          player = util::gethostplayer();
                          if(!isDefined(player.devgui_spawn_active)) {
                            player.devgui_spawn_active = 0;
                          }
                          if(!player.devgui_spawn_active) {
                            iprintln("");
                            iprintln("");
                            player.devgui_spawn_active = 1;
                            player thread devgui_spawn_think();
                          } else {
                            player notify("devgui_spawn_think");
                            player.devgui_spawn_active = 0;
                            player setactionslot(3, "");
                          }
                          setDvar("", "");
                        } else {
                          if(getdvarstring("") != "") {
                            players = getplayers();
                            if(!isDefined(level.devgui_unlimited_ammo)) {
                              level.devgui_unlimited_ammo = 1;
                            } else {
                              level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
                            }
                            if(level.devgui_unlimited_ammo) {
                              iprintln("");
                            } else {
                              iprintln("");
                            }
                            for(i = 0; i < players.size; i++) {
                              if(level.devgui_unlimited_ammo) {
                                players[i] thread devgui_unlimited_ammo();
                                continue;
                              }
                              players[i] notify("devgui_unlimited_ammo");
                            }
                            setDvar("", "");
                          } else {
                            if(getdvarstring("") != "") {
                              setDvar("", "");
                            } else {
                              if(getdvarstring("") != "") {
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
                                setDvar("", "");
                              } else if(getdvarstring("") != "") {
                                players = getplayers();
                                for(i = 0; i < players.size; i++) {
                                  player = players[i];
                                  if(getdvarstring("") == "") {
                                    player setempjammed(0);
                                    continue;
                                  }
                                  player setempjammed(1);
                                }
                                setDvar("", "");
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    if(getdvarstring("") == "") {
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
        setDvar("", "");
        level.streamdumpteamindex = -1;
      } else {
        averageorigin = (0, 0, 0);
        averageangles = (0, 0, 0);
        foreach(spawnpoint in level.spawn_start[teamname]) {
          averageorigin = averageorigin + (spawnpoint.origin / numpoints);
          averageangles = averageangles + (spawnpoint.angles / numpoints);
        }
        level.players[0] setplayerangles(averageangles);
        level.players[0] setorigin(averageorigin);
        wait(0.05);
        setDvar("", "");
      }
    }
  }
  if(getdvarstring("") != "") {
    event = getdvarstring("");
    player = util::gethostplayer();
    forward = anglesToForward(player.angles);
    right = anglestoright(player.angles);
    if(event == "") {
      player dodamage(1, player.origin + forward);
    } else {
      if(event == "") {
        player dodamage(1, player.origin - forward);
      } else {
        if(event == "") {
          player dodamage(1, player.origin - right);
        } else if(event == "") {
          player dodamage(1, player.origin + right);
        }
      }
    }
    setDvar("", "");
  }
  if(getdvarstring("") != "") {
    perk = getdvarstring("");
    for(i = 0; i < level.players.size; i++) {
      level.players[i] unsetperk(perk);
      level.players[i].extraperks[perk] = undefined;
    }
    setDvar("", "");
  }
  if(getdvarstring("") != "") {
    nametokens = strtok(getdvarstring(""), "");
    if(nametokens.size > 1) {
      thread xkillsy(nametokens[0], nametokens[1]);
    }
    setDvar("", "");
  }
  if(getdvarstring("") != "") {
    player.pers[""] = 0;
    player.pers[""] = 0;
    newrank = min(getdvarint(""), 54);
    newrank = max(newrank, 1);
    setDvar("", "");
    lastxp = 0;
    for(index = 0; index <= newrank; index++) {
      newxp = rank::getrankinfominxp(index);
      player thread rank::giverankxp("", newxp - lastxp);
      lastxp = newxp;
      wait(0.25);
      self notify("cancel_notify");
    }
  }
  if(getdvarstring("") != "") {
    player thread rank::giverankxp("", getdvarint(""), 1);
    setDvar("", "");
  }
  if(getdvarstring("") != "") {
    for(i = 0; i < level.players.size; i++) {
      level.players[i] hud_message::oldnotifymessage(getdvarstring(""), getdvarstring(""), game[""][""]);
    }
    announcement(getdvarstring(""), 0);
    setDvar("", "");
  }
  if(getdvarstring("") != "") {
    ents = getEntArray();
    level.entarray = [];
    level.entcounts = [];
    level.entgroups = [];
    for(index = 0; index < ents.size; index++) {
      classname = ents[index].classname;
      if(!issubstr(classname, "")) {
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
}

function devgui_spawn_think() {
  self notify("devgui_spawn_think");
  self endon("devgui_spawn_think");
  self endon("disconnect");
  dpad_left = 0;
  dpad_right = 0;
  for(;;) {
    self setactionslot(3, "");
    self setactionslot(4, "");
    if(!dpad_left && self buttonPressed("")) {
      setDvar("", "");
      dpad_left = 1;
    } else if(!self buttonPressed("")) {
      dpad_left = 0;
    }
    if(!dpad_right && self buttonPressed("")) {
      setDvar("", "");
      dpad_right = 1;
    } else if(!self buttonPressed("")) {
      dpad_right = 0;
    }
    wait(0.05);
  }
}

function devgui_unlimited_ammo() {
  self notify("devgui_unlimited_ammo");
  self endon("devgui_unlimited_ammo");
  self endon("disconnect");
  for(;;) {
    wait(1);
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
  self notify("devgui_health_debug");
  self endon("devgui_health_debug");
  self endon("disconnect");
  x = 80;
  y = 40;
  self.debug_health_bar = newclienthudelem(self);
  self.debug_health_bar.x = x + 80;
  self.debug_health_bar.y = y + 2;
  self.debug_health_bar.alignx = "";
  self.debug_health_bar.aligny = "";
  self.debug_health_bar.horzalign = "";
  self.debug_health_bar.vertalign = "";
  self.debug_health_bar.alpha = 1;
  self.debug_health_bar.foreground = 1;
  self.debug_health_bar setshader("", 1, 8);
  self.debug_health_text = newclienthudelem(self);
  self.debug_health_text.x = x + 80;
  self.debug_health_text.y = y;
  self.debug_health_text.alignx = "";
  self.debug_health_text.aligny = "";
  self.debug_health_text.horzalign = "";
  self.debug_health_text.vertalign = "";
  self.debug_health_text.alpha = 1;
  self.debug_health_text.fontscale = 1;
  self.debug_health_text.foreground = 1;
  if(!isDefined(self.maxhealth) || self.maxhealth <= 0) {
    self.maxhealth = 100;
  }
  for(;;) {
    wait(0.05);
    width = (self.health / self.maxhealth) * 300;
    width = int(max(width, 1));
    self.debug_health_bar setshader("", width, 8);
    self.debug_health_text setvalue(self.health);
  }
}

function giveextraperks() {
  if(!isDefined(self.extraperks)) {
    return;
  }
  perks = getarraykeys(self.extraperks);
  for(i = 0; i < perks.size; i++) {
    println(((("" + self.name) + "") + perks[i]) + "");
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
  victim thread[[level.callbackplayerdamage]](attacker, attacker, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", (0, 0, 0), 0, 0, (1, 0, 0));
}

function testscriptruntimeerrorassert() {
  wait(1);
  assert(0);
}

function testscriptruntimeerror2() {
  myundefined = "";
  if(myundefined == 1) {
    println("");
  }
}

function testscriptruntimeerror1() {
  testscriptruntimeerror2();
}

function testscriptruntimeerror() {
  wait(5);
  for(;;) {
    if(getdvarstring("") != "") {
      break;
    }
    wait(1);
  }
  myerror = getdvarstring("");
  setDvar("", "");
  if(myerror == "") {
    testscriptruntimeerrorassert();
  } else {
    testscriptruntimeerror1();
  }
  thread testscriptruntimeerror();
}

function testdvars() {
  wait(5);
  for(;;) {
    if(getdvarstring("") != "") {
      break;
    }
    wait(1);
  }
  tokens = strtok(getdvarstring(""), "");
  dvarname = tokens[0];
  dvarvalue = tokens[1];
  setDvar(dvarname, dvarvalue);
  setDvar("", "");
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
  a = (center + forward) - right;
  b = (center + forward) + right;
  c = (center - forward) + right;
  d = (center - forward) - right;
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  thread lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
  thread lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
  a = a + (0, 0, height);
  b = b + (0, 0, height);
  c = c + (0, 0, height);
  d = d + (0, 0, height);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(b, c, color, 0, notification);
  thread lineuntilnotified(c, d, color, 0, notification);
  thread lineuntilnotified(d, a, color, 0, notification);
  center = center + (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = (center + arrowhead_forward) - arrowhead_right;
  c = (center + arrowhead_forward) + arrowhead_right;
  thread lineuntilnotified(center, a, color, 0, notification);
  thread lineuntilnotified(a, b, color, 0, notification);
  thread lineuntilnotified(a, c, color, 0, notification);
  thread print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
}

function print3duntilnotified(origin, text, color, alpha, scale, notification) {
  level endon(notification);
  for(;;) {
    print3d(origin, text, color, alpha, scale);
    wait(0.05);
  }
}

function lineuntilnotified(start, end, color, depthtest, notification) {
  level endon(notification);
  for(;;) {
    line(start, end, color, depthtest);
    wait(0.05);
  }
}

function dvar_turned_on(val) {
  if(val <= 0) {
    return false;
  }
  return true;
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
  /
  #
  if(!isDefined(alpha)) {
    alpha = 1;
  }
  if(!isDefined(scale)) {
    scale = 1;
  }
  if(!isDefined(sort)) {
    sort = 20;
  }
  hud = newdebughudelem();
  hud.debug_hudelem = 1;
  hud.location = 0;
  hud.alignx = "";
  hud.aligny = "";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;
  if(isDefined(text)) {
    hud settext(text);
  }
  return hud;
}

function getattachmentchangemodifierbutton() {
  return "";
}

function watchattachmentchange() {
  self endon("disconnect");
  clientnum = self getentitynumber();
  if(clientnum != 0) {
    return;
  }
  dpad_left = 0;
  dpad_right = 0;
  dpad_up = 0;
  dpad_down = 0;
  lstick_down = 0;
  dpad_modifier_button = getattachmentchangemodifierbutton();
  for(;;) {
    if(self buttonPressed(dpad_modifier_button)) {
      if(!dpad_left && self buttonPressed("")) {
        self giveweaponnextattachment("");
        dpad_left = 1;
        self thread print_weapon_name();
      }
      if(!dpad_right && self buttonPressed("")) {
        self giveweaponnextattachment("");
        dpad_right = 1;
        self thread print_weapon_name();
      }
      if(!dpad_up && self buttonPressed("")) {
        self giveweaponnextattachment("");
        dpad_up = 1;
        self thread print_weapon_name();
      }
      if(!dpad_down && self buttonPressed("")) {
        self giveweaponnextattachment("");
        dpad_down = 1;
        self thread print_weapon_name();
      }
      if(!lstick_down && self buttonPressed("")) {
        self giveweaponnextattachment("");
        lstick_down = 1;
        self thread print_weapon_name();
      }
    }
    if(!self buttonPressed("")) {
      dpad_left = 0;
    }
    if(!self buttonPressed("")) {
      dpad_right = 0;
    }
    if(!self buttonPressed("")) {
      dpad_up = 0;
    }
    if(!self buttonPressed("")) {
      dpad_down = 0;
    }
    if(!self buttonPressed("")) {
      lstick_down = 0;
    }
    wait(0.05);
  }
}

function print_weapon_name() {
  self notify("print_weapon_name");
  self endon("print_weapon_name");
  wait(0.2);
  if(self isswitchingweapons()) {
    self waittill("weapon_change_complete", weapon);
    fail_safe = 0;
    while(weapon == level.weaponnone) {
      self waittill("weapon_change_complete", weapon);
      wait(0.05);
      fail_safe++;
      if(fail_safe > 120) {
        break;
      }
    }
  } else {
    weapon = self getcurrentweapon();
  }
  printweaponname = getdvarint("", 1);
  if(printweaponname) {
    iprintlnbold(weapon.name);
  }
}

function set_equipment_list() {
  if(isDefined(level.dev_equipment)) {
    return;
  }
  level.dev_equipment = [];
  level.dev_equipment[1] = getweapon("");
  level.dev_equipment[2] = getweapon("");
  level.dev_equipment[3] = getweapon("");
  level.dev_equipment[4] = getweapon("");
  level.dev_equipment[5] = getweapon("");
  level.dev_equipment[6] = getweapon("");
  level.dev_equipment[7] = getweapon("");
  level.dev_equipment[8] = getweapon("");
  level.dev_equipment[9] = getweapon("");
}

function set_grenade_list() {
  if(isDefined(level.dev_grenade)) {
    return;
  }
  level.dev_grenade = [];
  level.dev_grenade[1] = getweapon("");
  level.dev_grenade[2] = getweapon("");
  level.dev_grenade[3] = getweapon("");
  level.dev_grenade[4] = getweapon("");
  level.dev_grenade[5] = getweapon("");
  level.dev_grenade[6] = getweapon("");
  level.dev_grenade[7] = getweapon("");
  level.dev_grenade[8] = getweapon("");
  level.dev_grenade[9] = getweapon("");
  level.dev_grenade[10] = getweapon("");
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
  setDvar("", "");
  while(true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_equipment[devgui_int]);
      }
      setDvar("", "");
    }
  }
}

function grenade_dev_gui() {
  set_equipment_list();
  set_grenade_list();
  setDvar("", "");
  while(true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_grenade[devgui_int]);
      }
      setDvar("", "");
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
  origintextoffset = vectorscale((0, 0, -1), 50);
  endonmsg = "";
  while(true) {
    if(getdvarint("") > 0) {
      nodes = [];
      end = 0;
      node = getvehiclenode("", "");
      if(!isDefined(node)) {
        println("");
        setDvar("", "");
        continue;
      }
      while(isDefined(node.target)) {
        new_node = getvehiclenode(node.target, "");
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
            case "": {
              textcolor = green;
              textalpha = 1;
              break;
            }
            case "": {
              textcolor = red;
              textalpha = 1;
              break;
            }
            case "": {
              textcolor = white;
              textalpha = 1;
              break;
            }
          }
          switch (node.script_noteworthy) {
            case "":
            case "":
            case "": {
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
        }
        if(end) {
          break;
        }
        nodes[nodes.size] = new_node;
        node = new_node;
      }
      drawtime = drawtime - 0.05;
      if(drawtime < 0) {
        drawtime = maxdrawtime;
      }
      wait(0.05);
    } else {
      wait(1);
    }
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
  origintextoffset = vectorscale((0, 0, -1), 50);
  endonmsg = "";
  while(true) {
    if(getdvarint("") > 0) {
      script_origins = getEntArray("", "");
      foreach(ent in script_origins) {
        if(isDefined(ent.targetname)) {
          switch (ent.targetname) {
            case "": {
              textcolor = blue;
              textalpha = 1;
              textscale = 3;
              break;
            }
            case "": {
              textcolor = green;
              textalpha = 1;
              textscale = 3;
              break;
            }
            case "": {
              textcolor = red;
              textalpha = 1;
              textscale = 3;
              break;
            }
            case "": {
              textcolor = white;
              textalpha = 1;
              textscale = 3;
              break;
            }
          }
          switch (ent.targetname) {
            case "":
            case "":
            case "":
            case "": {
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
      }
      drawtime = drawtime - 0.05;
      if(drawtime < 0) {
        drawtime = maxdrawtime;
      }
    }
    if(getdvarint("") == 0) {
      level notify(endonmsg);
      drawtime = maxdrawtime;
      wait(1);
    }
    wait(0.05);
  }
}

function draworiginlines() {
  red = (1, 0, 0);
  green = (0, 1, 0);
  blue = (0, 0, 1);
  line(self.origin, self.origin + (anglesToForward(self.angles) * 10), red);
  line(self.origin, self.origin + (anglestoright(self.angles) * 10), green);
  line(self.origin, self.origin + (anglestoup(self.angles) * 10), blue);
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
  originstring = ((((("" + self.origin[0]) + "") + self.origin[1]) + "") + self.origin[2]) + "";
  print3d(self.origin + textoffset, originstring, textcolor, textalpha, textscale);
}

function drawspeedacceltext(textcolor, textalpha, textscale, textoffset) {
  if(isDefined(self.script_airspeed)) {
    print3d(self.origin + (0, 0, textoffset[2] * 2), "" + self.script_airspeed, textcolor, textalpha, textscale);
  }
  if(isDefined(self.script_accel)) {
    print3d(self.origin + (0, 0, textoffset[2] * 3), "" + self.script_accel, textcolor, textalpha, textscale);
  }
}

function drawpath(linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
  level endon(endonmsg);
  ent = self;
  entfirsttarget = ent.targetname;
  while(isDefined(ent.target)) {
    enttarget = getent(ent.target, "");
    ent thread drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg);
    if(ent.targetname == "") {
      entfirsttarget = ent.target;
    } else if(ent.target == entfirsttarget) {
      break;
    }
    ent = enttarget;
    wait(0.05);
  }
}

function drawpathsegment(enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg) {
  level endon(endonmsg);
  while(drawtime > 0) {
    if(isDefined(self.targetname) && self.targetname == "") {
      print3d(self.origin + textoffset, self.targetname, textcolor, textalpha, textscale);
    }
    line(self.origin, enttarget.origin, linecolor);
    self drawspeedacceltext(textcolor, textalpha, textscale, textoffset);
    drawtime = drawtime - 0.05;
    wait(0.05);
  }
}

function get_lookat_origin(player) {
  angles = player getplayerangles();
  forward = anglesToForward(angles);
  dir = vectorscale(forward, 8000);
  eye = player getEye();
  trace = bulletTrace(eye, eye + dir, 0, undefined);
  return trace[""];
}

function draw_pathnode(node, color) {
  if(!isDefined(color)) {
    color = (1, 0, 1);
  }
  box(node.origin, vectorscale((-1, -1, 0), 16), vectorscale((1, 1, 1), 16), 0, color, 1, 0, 1);
}

function draw_pathnode_think(node, color) {
  level endon("draw_pathnode_stop");
  for(;;) {
    draw_pathnode(node, color);
    wait(0.05);
  }
}

function draw_pathnodes_stop() {
  wait(5);
  level notify("draw_pathnode_stop");
}

function node_get(player) {
  for(;;) {
    wait(0.05);
    origin = get_lookat_origin(player);
    node = getnearestnode(origin);
    if(!isDefined(node)) {
      continue;
    }
    if(player buttonPressed("")) {
      return node;
    }
    if(player buttonPressed("")) {
      return undefined;
    }
    if(node.type == "") {
      draw_pathnode(node, (1, 0, 1));
      continue;
    }
    draw_pathnode(node, (0.85, 0.85, 0.1));
  }
}

function dev_get_node_pair() {
  player = util::gethostplayer();
  start = undefined;
  while(!isDefined(start)) {
    start = node_get(player);
    if(player buttonPressed("")) {
      level notify("draw_pathnode_stop");
      return undefined;
    }
  }
  level thread draw_pathnode_think(start, (0, 1, 0));
  while(player buttonPressed("")) {
    wait(0.05);
  }
  end = undefined;
  while(!isDefined(end)) {
    end = node_get(player);
    if(player buttonPressed("")) {
      level notify("draw_pathnode_stop");
      return undefined;
    }
  }
  level thread draw_pathnode_think(end, (0, 1, 0));
  level thread draw_pathnodes_stop();
  array = [];
  array[0] = start;
  array[1] = end;
  return array;
}

function draw_point(origin, color) {
  if(!isDefined(color)) {
    color = (1, 0, 1);
  }
  sphere(origin, 16, color, 0.25, 0, 16, 1);
}

function point_get(player) {
  for(;;) {
    wait(0.05);
    origin = get_lookat_origin(player);
    if(player buttonPressed("")) {
      return origin;
    }
    if(player buttonPressed("")) {
      return undefined;
    }
    draw_point(origin, (1, 0, 1));
  }
}

function dev_get_point_pair() {
  player = util::gethostplayer();
  start = undefined;
  points = [];
  while(!isDefined(start)) {
    start = point_get(player);
    if(!isDefined(start)) {
      return points;
    }
  }
  while(player buttonPressed("")) {
    wait(0.05);
  }
  end = undefined;
  while(!isDefined(end)) {
    end = point_get(player);
    if(!isDefined(end)) {
      return points;
    }
  }
  points[0] = start;
  points[1] = end;
  return points;
}