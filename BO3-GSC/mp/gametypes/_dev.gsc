/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_dev.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_teamops;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_dev_class;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_hud_message;
#using scripts\mp\gametypes\_killcam;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_helicopter_gunner;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\mp\killstreaks\_uav;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\callbacks_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\killstreaks_shared;
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
  callback::on_connect(&on_player_connected);
  level.devongetormakebot = &getormakebot;
}

function init() {
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  thread testscriptruntimeerror();
  thread testdvars();
  thread addenemyheli();
  thread addtestcarepackage();
  thread watch_botsdvars();
  thread devhelipathdebugdraw();
  thread devstraferunpathdebugdraw();
  thread dev_class::dev_cac_init();
  thread globallogic_score::setplayermomentumdebug();
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  thread engagement_distance_debug_toggle();
  thread equipment_dev_gui();
  thread grenade_dev_gui();
  setdvar("", "");
  level.bot_overlay = 0;
  level.bot_threat = 0;
  level.bot_path = 0;
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
  for(;;) {
    updatedevsettings();
    wait(0.5);
  }
}

function on_player_connected() {
  if(isDefined(level.devgui_unlimited_ammo) && level.devgui_unlimited_ammo) {
    wait(1);
    self thread devgui_unlimited_ammo();
  }
}

function updatehardpoints() {
  keys = getarraykeys(level.killstreaks);
  for(i = 0; i < keys.size; i++) {
    dvar = level.killstreaks[keys[i]].devdvar;
    enemydvar = level.killstreaks[keys[i]].devenemydvar;
    host = util::gethostplayer();
    if(isDefined(dvar) && getdvarint(dvar) == 1) {
      if(keys[i] == "") {
        if(isDefined(level.vtol)) {
          iprintln("");
        } else {
          host killstreaks::give("" + keys[i]);
        }
      } else {
        foreach(player in level.players) {
          if(isDefined(level.usingmomentum) && level.usingmomentum && (isDefined(level.usingscorestreaks) && level.usingscorestreaks)) {
            player killstreaks::give("" + keys[i]);
            continue;
          }
          if(player util::is_bot()) {
            player.bot[""] = [];
            player.bot[""][0] = killstreaks::get_menu_name(keys[i]);
            killstreakweapon = killstreaks::get_killstreak_weapon(keys[i]);
            player killstreaks::give_weapon(killstreakweapon, 1);
            globallogic_score::_setplayermomentum(player, 2000);
            continue;
          }
          player killstreaks::give("" + keys[i]);
        }
      }
      setdvar(dvar, "");
    }
    if(isDefined(enemydvar) && getdvarint(enemydvar) == 1) {
      team = "";
      player = util::gethostplayer();
      if(isDefined(player.team)) {
        team = util::getotherteam(player.team);
      }
      ent = getormakebot(team);
      if(!isDefined(ent)) {
        println("");
        continue;
      }
      wait(1);
      ent killstreaks::give("" + keys[i]);
      setdvar(enemydvar, "");
    }
  }
}

function updateteamops() {
  teamops = getdvarstring(level.teamops_dvar);
  if(getdvarstring(level.teamops_dvar) != "") {
    teamops::startteamops(teamops);
    setdvar(level.teamops_dvar, "");
  }
}

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
  setdvar("", "");
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
        setdvar("", "");
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
        wait(5);
        setdvar("", "");
      }
    }
  }
}

function updatedevsettings() {
  show_spawns = getdvarint("");
  show_start_spawns = getdvarint("");
  player = util::gethostplayer();
  if(show_spawns >= 1) {
    show_spawns = 1;
  } else {
    show_spawns = 0;
  }
  if(show_start_spawns >= 1) {
    show_start_spawns = 1;
  } else {
    show_start_spawns = 0;
  }
  if(!isDefined(level.show_spawns) || level.show_spawns != show_spawns) {
    level.show_spawns = show_spawns;
    setdvar("", level.show_spawns);
    if(level.show_spawns) {
      showspawnpoints();
    } else {
      hidespawnpoints();
    }
  }
  if(!isDefined(level.show_start_spawns) || level.show_start_spawns != show_start_spawns) {
    level.show_start_spawns = show_start_spawns;
    setdvar("", level.show_start_spawns);
    if(level.show_start_spawns) {
      showstartspawnpoints();
    } else {
      hidestartspawnpoints();
    }
  }
  updateminimapsetting();
  if(level.players.size > 0) {
    updatehardpoints();
    updateteamops();
    playerwarp_string = getdvarstring("");
    if(playerwarp_string == "") {
      warpalltohost();
    } else {
      if(playerwarp_string == "") {
        warpalltohost(playerwarp_string);
      } else {
        if(playerwarp_string == "") {
          warpalltohost(playerwarp_string);
        } else {
          if(strstartswith(playerwarp_string, "")) {
            name = getsubstr(playerwarp_string, 8);
            warpalltoplayer(playerwarp_string, name);
          } else {
            if(strstartswith(playerwarp_string, "")) {
              name = getsubstr(playerwarp_string, 11);
              warpalltoplayer(playerwarp_string, name);
            } else {
              if(strstartswith(playerwarp_string, "")) {
                name = getsubstr(playerwarp_string, 4);
                warpalltoplayer(undefined, name);
              } else {
                if(playerwarp_string == "") {
                  players = getplayers();
                  setdvar("", "");
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
                  if(playerwarp_string == "") {
                    players = getplayers();
                    setdvar("", "");
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
                    if(playerwarp_string == "") {
                      players = getplayers();
                      setdvar("", "");
                      if(!isDefined(level.devgui_spawn_index)) {
                        level.devgui_spawn_index = 0;
                      }
                      spawns = level.spawnpoints;
                      spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                      if(!isDefined(spawns) || spawns.size <= 0) {
                        return;
                      }
                      for(i = 0; i < players.size; i++) {
                        players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                        players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                      }
                      level.devgui_spawn_index++;
                      if(level.devgui_spawn_index >= spawns.size) {
                        level.devgui_spawn_index = 0;
                      }
                    } else {
                      if(playerwarp_string == "") {
                        players = getplayers();
                        setdvar("", "");
                        if(!isDefined(level.devgui_spawn_index)) {
                          level.devgui_spawn_index = 0;
                        }
                        spawns = level.spawnpoints;
                        spawns = arraycombine(spawns, level.dem_spawns, 1, 0);
                        if(!isDefined(spawns) || spawns.size <= 0) {
                          return;
                        }
                        for(i = 0; i < players.size; i++) {
                          players[i] setorigin(spawns[level.devgui_spawn_index].origin);
                          players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
                        }
                        level.devgui_spawn_index--;
                        if(level.devgui_spawn_index < 0) {
                          level.devgui_spawn_index = spawns.size - 1;
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
                          setdvar("", "");
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
                            setdvar("", "");
                          } else {
                            if(getdvarstring("") != "") {
                              if(!isDefined(level.devgui_unlimited_momentum)) {
                                level.devgui_unlimited_momentum = 1;
                              } else {
                                level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
                              }
                              if(level.devgui_unlimited_momentum) {
                                iprintln("");
                                level thread devgui_unlimited_momentum();
                              } else {
                                iprintln("");
                                level notify("devgui_unlimited_momentum");
                              }
                              setdvar("", "");
                            } else {
                              if(getdvarstring("") != "") {
                                level thread devgui_increase_momentum(getdvarint(""));
                                setdvar("", "");
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
                                  setdvar("", "");
                                } else {
                                  if(getdvarstring("") != "") {
                                    players = getplayers();
                                    for(i = 0; i < players.size; i++) {
                                      player = players[i];
                                      if(getdvarstring("") == "") {
                                        player setempjammed(0);
                                        continue;
                                      }
                                      player setempjammed(1);
                                    }
                                    setdvar("", "");
                                  } else {
                                    if(getdvarstring("") != "") {
                                      if(!level.timerstopped) {
                                        iprintln("");
                                        globallogic_utils::pausetimer();
                                      } else {
                                        iprintln("");
                                        globallogic_utils::resumetimer();
                                      }
                                      setdvar("", "");
                                    } else {
                                      if(getdvarstring("") != "") {
                                        level globallogic::forceend();
                                        setdvar("", "");
                                      } else {
                                        if(getdvarstring("") != "") {
                                          players = getplayers();
                                          host = util::gethostplayer();
                                          if(!isDefined(host.devgui_health_debug)) {
                                            host.devgui_health_debug = 0;
                                          }
                                          if(host.devgui_health_debug) {
                                            host.devgui_health_debug = 0;
                                            for(i = 0; i < players.size; i++) {
                                              players[i] notify("devgui_health_debug");
                                              if(isDefined(players[i].debug_health_bar)) {
                                                players[i].debug_health_bar destroy();
                                                players[i].debug_health_text destroy();
                                                players[i].debug_health_bar = undefined;
                                                players[i].debug_health_text = undefined;
                                              }
                                            }
                                          } else {
                                            host.devgui_health_debug = 1;
                                            for(i = 0; i < players.size; i++) {
                                              players[i] thread devgui_health_debug();
                                            }
                                          }
                                          setdvar("", "");
                                        } else if(getdvarstring("") != "") {
                                          if(!isDefined(level.devgui_show_hq)) {
                                            level.devgui_show_hq = 0;
                                          }
                                          if(level.gametype == "" && isDefined(level.radios)) {
                                            if(!level.devgui_show_hq) {
                                              for(i = 0; i < level.radios.size; i++) {
                                                color = (1, 0, 0);
                                                level showonespawnpoint(level.radios[i], color, "", 32, "");
                                              }
                                            } else {
                                              level notify("hide_hq_points");
                                            }
                                            level.devgui_show_hq = !level.devgui_show_hq;
                                          }
                                          setdvar("", "");
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
        setdvar("", "");
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
        wait(5);
        setdvar("", "");
      }
    }
  }
  if(getdvarstring("") == "") {
    players = getplayers();
    iprintln("");
    for(i = 0; i < players.size; i++) {
      players[i] clearperks();
    }
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    perk = getdvarstring("");
    specialties = strtok(perk, "");
    players = getplayers();
    iprintln(("" + perk) + "");
    for(i = 0; i < players.size; i++) {
      for(j = 0; j < specialties.size; j++) {
        players[i] setperk(specialties[j]);
        players[i].extraperks[specialties[j]] = 1;
      }
    }
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    force_grenade_throw(getweapon(getdvarstring("")));
    setdvar("", "");
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
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    perk = getdvarstring("");
    for(i = 0; i < level.players.size; i++) {
      level.players[i] unsetperk(perk);
      level.players[i].extraperks[perk] = undefined;
    }
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    nametokens = strtok(getdvarstring(""), "");
    if(nametokens.size > 1) {
      thread xkillsy(nametokens[0], nametokens[1]);
    }
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    ownername = getdvarstring("");
    setdvar("", "");
    owner = undefined;
    for(index = 0; index < level.players.size; index++) {
      if(level.players[index].name == ownername) {
        owner = level.players[index];
      }
    }
    if(isDefined(owner)) {
      owner killstreaks::trigger_killstreak("");
    }
  }
  if(getdvarstring("") != "") {
    player.pers[""] = 0;
    player.pers[""] = 0;
    newrank = min(getdvarint(""), 54);
    newrank = max(newrank, 1);
    setdvar("", "");
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
    setdvar("", "");
  }
  if(getdvarstring("") != "") {
    for(i = 0; i < level.players.size; i++) {
      level.players[i] hud_message::oldnotifymessage(getdvarstring(""), getdvarstring(""), game[""][""]);
    }
    announcement(getdvarstring(""), 0);
    setdvar("", "");
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
  if(getdvarstring("") == "" && !isDefined(level.larry)) {
    thread larry_thread();
  } else if(getdvarstring("") == "") {
    level notify("kill_larry");
  }
  if(level.bot_overlay == 0 && getdvarint("") == 1) {
    level thread bot_overlay_think();
    level.bot_overlay = 1;
  } else if(level.bot_overlay == 1 && getdvarint("") == 0) {
    level bot_overlay_stop();
    level.bot_overlay = 0;
  }
  if(level.bot_threat == 0 && getdvarint("") == 1) {
    level thread bot_threat_think();
    level.bot_threat = 1;
  } else if(level.bot_threat == 1 && getdvarint("") == 0) {
    level bot_threat_stop();
    level.bot_threat = 0;
  }
  if(level.bot_path == 0 && getdvarint("") == 1) {
    level thread bot_path_think();
    level.bot_path = 1;
  } else if(level.bot_path == 1 && getdvarint("") == 0) {
    level bot_path_stop();
    level.bot_path = 0;
  }
  if(getdvarint("") == 1) {
    level thread killcam::do_final_killcam();
    level thread waitthennotifyfinalkillcam();
  }
  if(getdvarint("") == 1) {
    level thread killcam::do_final_killcam();
    level thread waitthennotifyroundkillcam();
  }
  if(!level.bot_overlay && !level.bot_threat && !level.bot_path) {
    level notify("bot_dpad_terminate");
  }
}

function waitthennotifyroundkillcam() {
  wait(0.05);
  level notify("play_final_killcam");
  setdvar("", 0);
}

function waitthennotifyfinalkillcam() {
  wait(0.05);
  level notify("play_final_killcam");
  wait(0.05);
  setdvar("", 0);
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
    if(!dpad_left && self buttonpressed("")) {
      setdvar("", "");
      dpad_left = 1;
    } else if(!self buttonpressed("")) {
      dpad_left = 0;
    }
    if(!dpad_right && self buttonpressed("")) {
      setdvar("", "");
      dpad_right = 1;
    } else if(!self buttonpressed("")) {
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
      if(killstreaks::is_killstreak_weapon(weapon)) {
        continue;
      }
      self givemaxammo(weapon);
    }
  }
}

function devgui_unlimited_momentum() {
  level notify("devgui_unlimited_momentum");
  level endon("devgui_unlimited_momentum");
  for(;;) {
    wait(1);
    players = getplayers();
    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }
      if(!isalive(player)) {
        continue;
      }
      if(player.sessionstate != "") {
        continue;
      }
      globallogic_score::_setplayermomentum(player, 5000);
    }
  }
}

function devgui_increase_momentum(score) {
  players = getplayers();
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(player.sessionstate != "") {
      continue;
    }
    player globallogic_score::giveplayermomentumnotification(score, &"", "");
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

function testscriptruntimeassertmsgassert() {
  wait(1);
  assertmsg("");
}

function testscriptruntimeerrormsgassert() {
  wait(1);
  errormsg("");
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
  setdvar("", "");
  if(myerror == "") {
    testscriptruntimeerrorassert();
  } else {
    if(myerror == "") {
      testscriptruntimeassertmsgassert();
    } else {
      if(myerror == "") {
        testscriptruntimeerrormsgassert();
      } else {
        testscriptruntimeerror1();
      }
    }
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
  setdvar(dvarname, dvarvalue);
  setdvar("", "");
  thread testdvars();
}

function addenemyheli() {
  wait(5);
  for(;;) {
    if(getdvarint("") > 0) {
      break;
    }
    wait(1);
  }
  enemyheli = getdvarint("");
  setdvar("", 0);
  team = "";
  player = util::gethostplayer();
  if(isDefined(player.pers[""])) {
    team = util::getotherteam(player.pers[""]);
  }
  ent = getormakebot(team);
  if(!isDefined(ent)) {
    println("");
    wait(1);
    thread addenemyheli();
    return;
  }
  switch (enemyheli) {
    case 1: {
      level.helilocation = ent.origin;
      ent thread helicopter::usekillstreakhelicopter("");
      wait(0.5);
      ent notify("confirm_location", level.helilocation);
      break;
    }
    case 2: {
      break;
    }
  }
  thread addenemyheli();
}

function getormakebot(team) {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i].team == team) {
      if(isDefined(level.players[i].pers[""]) && level.players[i].pers[""]) {
        return level.players[i];
      }
    }
  }
  ent = bot::add_bot(team);
  if(isDefined(ent)) {
    sound::play_on_players("");
    wait(1);
  }
  return ent;
}

function addtestcarepackage() {
  wait(5);
  for(;;) {
    if(getdvarint("") > 0) {
      break;
    }
    wait(1);
  }
  supplydrop = getdvarint("");
  team = "";
  player = util::gethostplayer();
  if(isDefined(player.pers[""])) {
    switch (supplydrop) {
      case 2: {
        team = util::getotherteam(player.pers[""]);
        break;
      }
      case 1:
      default: {
        team = player.pers[""];
        break;
      }
    }
  }
  setdvar("", 0);
  ent = getormakebot(team);
  if(!isDefined(ent)) {
    println("");
    wait(1);
    thread addtestcarepackage();
    return;
  }
  ent killstreakrules::killstreakstart("", team);
  ent thread supplydrop::helidelivercrate(ent.origin, getweapon(""), ent, team);
  thread addtestcarepackage();
}

function showonespawnpoint(spawn_point, color, notification, height, print) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }
  if(!isDefined(print)) {
    if(level.convert_spawns_to_structs) {
      print = spawn_point.targetname;
    } else {
      print = spawn_point.classname;
    }
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

function showspawnpoints() {
  if(isDefined(level.spawnpoints)) {
    color = (1, 1, 1);
    for(spawn_point_index = 0; spawn_point_index < level.spawnpoints.size; spawn_point_index++) {
      showonespawnpoint(level.spawnpoints[spawn_point_index], color, "");
    }
  }
  for(i = 0; i < level.dem_spawns.size; i++) {
    color = (0, 1, 0);
    showonespawnpoint(level.dem_spawns[i], color, "");
  }
}

function hidespawnpoints() {
  level notify("hide_spawnpoints");
}

function showstartspawnpoints() {
  if(!isDefined(level.spawn_start)) {
    return;
  }
  if(level.teambased) {
    team_colors = [];
    team_colors[""] = (1, 0, 1);
    team_colors[""] = (0, 1, 1);
    team_colors[""] = (1, 1, 0);
    team_colors[""] = (0, 1, 0);
    team_colors[""] = (0, 0, 1);
    team_colors[""] = (1, 0.7, 0);
    team_colors[""] = (0.25, 0.25, 1);
    team_colors[""] = (0.88, 0, 1);
    foreach(key, color in team_colors) {
      if(!isDefined(level.spawn_start[key])) {
        continue;
      }
      foreach(spawnpoint in level.spawn_start[key]) {
        showonespawnpoint(spawnpoint, color, "");
      }
    }
  } else {
    color = (1, 0, 1);
    foreach(spawnpoint in level.spawn_start) {
      showonespawnpoint(spawnpoint, color, "");
    }
  }
}

function hidestartspawnpoints() {
  level notify("hide_startspawnpoints");
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

function engagement_distance_debug_toggle() {
  level endon("kill_engage_dist_debug_toggle_watcher");
  if(!isDefined(getdvarint(""))) {
    setdvar("", "");
  }
  laststate = getdvarint("", 0);
  while(true) {
    currentstate = getdvarint("", 0);
    if(dvar_turned_on(currentstate) && !dvar_turned_on(laststate)) {
      weapon_engage_dists_init();
      thread debug_realtime_engage_dist();
      laststate = currentstate;
    } else if(!dvar_turned_on(currentstate) && dvar_turned_on(laststate)) {
      level notify("kill_all_engage_dist_debug");
      laststate = currentstate;
    }
    wait(0.3);
  }
}

function dvar_turned_on(val) {
  if(val <= 0) {
    return false;
  }
  return true;
}

function engagement_distance_debug_init() {
  level.debug_xpos = -50;
  level.debug_ypos = 250;
  level.debug_yinc = 18;
  level.debug_fontscale = 1.5;
  level.white = (1, 1, 1);
  level.green = (0, 1, 0);
  level.yellow = (1, 1, 0);
  level.red = (1, 0, 0);
  level.realtimeengagedist = newhudelem();
  level.realtimeengagedist.alignx = "";
  level.realtimeengagedist.fontscale = level.debug_fontscale;
  level.realtimeengagedist.x = level.debug_xpos;
  level.realtimeengagedist.y = level.debug_ypos;
  level.realtimeengagedist.color = level.white;
  level.realtimeengagedist settext("");
  xpos = level.debug_xpos + 207;
  level.realtimeengagedist_value = newhudelem();
  level.realtimeengagedist_value.alignx = "";
  level.realtimeengagedist_value.fontscale = level.debug_fontscale;
  level.realtimeengagedist_value.x = xpos;
  level.realtimeengagedist_value.y = level.debug_ypos;
  level.realtimeengagedist_value.color = level.white;
  level.realtimeengagedist_value setvalue(0);
  xpos = xpos + 37;
  level.realtimeengagedist_middle = newhudelem();
  level.realtimeengagedist_middle.alignx = "";
  level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
  level.realtimeengagedist_middle.x = xpos;
  level.realtimeengagedist_middle.y = level.debug_ypos;
  level.realtimeengagedist_middle.color = level.white;
  level.realtimeengagedist_middle settext("");
  xpos = xpos + 105;
  level.realtimeengagedist_offvalue = newhudelem();
  level.realtimeengagedist_offvalue.alignx = "";
  level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
  level.realtimeengagedist_offvalue.x = xpos;
  level.realtimeengagedist_offvalue.y = level.debug_ypos;
  level.realtimeengagedist_offvalue.color = level.white;
  level.realtimeengagedist_offvalue setvalue(0);
  hudobjarray = [];
  hudobjarray[0] = level.realtimeengagedist;
  hudobjarray[1] = level.realtimeengagedist_value;
  hudobjarray[2] = level.realtimeengagedist_middle;
  hudobjarray[3] = level.realtimeengagedist_offvalue;
  return hudobjarray;
}

function engage_dist_debug_hud_destroy(hudarray, killnotify) {
  level waittill(killnotify);
  for(i = 0; i < hudarray.size; i++) {
    hudarray[i] destroy();
  }
}

function weapon_engage_dists_init() {
  level.engagedists = [];
  genericpistol = spawnStruct();
  genericpistol.engagedistmin = 125;
  genericpistol.engagedistoptimal = 225;
  genericpistol.engagedistmulligan = 50;
  genericpistol.engagedistmax = 400;
  shotty = spawnStruct();
  shotty.engagedistmin = 50;
  shotty.engagedistoptimal = 200;
  shotty.engagedistmulligan = 75;
  shotty.engagedistmax = 350;
  genericsmg = spawnStruct();
  genericsmg.engagedistmin = 100;
  genericsmg.engagedistoptimal = 275;
  genericsmg.engagedistmulligan = 100;
  genericsmg.engagedistmax = 500;
  genericlmg = spawnStruct();
  genericlmg.engagedistmin = 325;
  genericlmg.engagedistoptimal = 550;
  genericlmg.engagedistmulligan = 150;
  genericlmg.engagedistmax = 850;
  genericriflesa = spawnStruct();
  genericriflesa.engagedistmin = 325;
  genericriflesa.engagedistoptimal = 550;
  genericriflesa.engagedistmulligan = 150;
  genericriflesa.engagedistmax = 850;
  genericriflebolt = spawnStruct();
  genericriflebolt.engagedistmin = 350;
  genericriflebolt.engagedistoptimal = 600;
  genericriflebolt.engagedistmulligan = 150;
  genericriflebolt.engagedistmax = 900;
  generichmg = spawnStruct();
  generichmg.engagedistmin = 390;
  generichmg.engagedistoptimal = 600;
  generichmg.engagedistmulligan = 100;
  generichmg.engagedistmax = 900;
  genericsniper = spawnStruct();
  genericsniper.engagedistmin = 950;
  genericsniper.engagedistoptimal = 1700;
  genericsniper.engagedistmulligan = 300;
  genericsniper.engagedistmax = 3000;
  engage_dists_add("", genericpistol);
  engage_dists_add("", genericpistol);
  engage_dists_add("", genericpistol);
  engage_dists_add("", genericpistol);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", genericsmg);
  engage_dists_add("", shotty);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericlmg);
  engage_dists_add("", genericriflesa);
  engage_dists_add("", genericriflesa);
  engage_dists_add("", genericriflesa);
  engage_dists_add("", genericriflesa);
  engage_dists_add("", genericriflebolt);
  engage_dists_add("", genericriflebolt);
  engage_dists_add("", genericriflebolt);
  engage_dists_add("", genericriflebolt);
  engage_dists_add("", genericriflebolt);
  engage_dists_add("", generichmg);
  engage_dists_add("", generichmg);
  engage_dists_add("", generichmg);
  engage_dists_add("", generichmg);
  engage_dists_add("", genericsniper);
  engage_dists_add("", genericsniper);
  engage_dists_add("", genericsniper);
  engage_dists_add("", genericsniper);
  engage_dists_add("", genericsniper);
  engage_dists_add("", genericsniper);
  level thread engage_dists_watcher();
}

function engage_dists_add(weaponname, values) {
  level.engagedists[getweapon(weaponname)] = values;
}

function get_engage_dists(weapon) {
  if(isDefined(level.engagedists[weapon])) {
    return level.engagedists[weapon];
  }
  return undefined;
}

function engage_dists_watcher() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_engage_dists_watcher");
  while(true) {
    player = util::gethostplayer();
    playerweapon = player getcurrentweapon();
    if(!isDefined(player.lastweapon)) {
      player.lastweapon = playerweapon;
    } else if(player.lastweapon == playerweapon) {
      wait(0.05);
      continue;
    }
    values = get_engage_dists(playerweapon);
    if(isDefined(values)) {
      level.weaponengagedistvalues = values;
    } else {
      level.weaponengagedistvalues = undefined;
    }
    player.lastweapon = playerweapon;
    wait(0.05);
  }
}

function debug_realtime_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_realtime_engagement_distance_debug");
  hudobjarray = engagement_distance_debug_init();
  level thread engage_dist_debug_hud_destroy(hudobjarray, "");
  level.debugrtengagedistcolor = level.green;
  player = util::gethostplayer();
  while(true) {
    lasttracepos = (0, 0, 0);
    direction = player getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    eye = (eye[0], eye[1], eye[2] + 20);
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, 10000), 1, player);
    tracepoint = trace[""];
    tracenormal = trace[""];
    tracedist = int(distance(eye, tracepoint));
    if(tracepoint != lasttracepos) {
      lasttracepos = tracepoint;
      if(!isDefined(level.weaponengagedistvalues)) {
        hudobj_changecolor(hudobjarray, level.white);
        hudobjarray engagedist_hud_changetext("", tracedist);
      } else {
        engagedistmin = level.weaponengagedistvalues.engagedistmin;
        engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
        engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
        engagedistmax = level.weaponengagedistvalues.engagedistmax;
        if(tracedist >= engagedistmin && tracedist <= engagedistmax) {
          if(tracedist >= (engagedistoptimal - engagedistmulligan) && tracedist <= (engagedistoptimal + engagedistmulligan)) {
            hudobjarray engagedist_hud_changetext("", tracedist);
            hudobj_changecolor(hudobjarray, level.green);
          } else {
            hudobjarray engagedist_hud_changetext("", tracedist);
            hudobj_changecolor(hudobjarray, level.yellow);
          }
        } else {
          if(tracedist < engagedistmin) {
            hudobj_changecolor(hudobjarray, level.red);
            hudobjarray engagedist_hud_changetext("", tracedist);
          } else if(tracedist > engagedistmax) {
            hudobj_changecolor(hudobjarray, level.red);
            hudobjarray engagedist_hud_changetext("", tracedist);
          }
        }
      }
    }
    thread plot_circle_fortime(1, 5, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    thread plot_circle_fortime(1, 1, 0.05, level.debugrtengagedistcolor, tracepoint, tracenormal);
    wait(0.05);
  }
}

function hudobj_changecolor(hudobjarray, newcolor) {
  for(i = 0; i < hudobjarray.size; i++) {
    hudobj = hudobjarray[i];
    if(hudobj.color != newcolor) {
      hudobj.color = newcolor;
      level.debugrtengagedistcolor = newcolor;
    }
  }
}

function engagedist_hud_changetext(engagedisttype, units) {
  if(!isDefined(level.lastdisttype)) {
    level.lastdisttype = "";
  }
  if(engagedisttype == "") {
    self[1] setvalue(units);
    self[2] settext("");
    self[3].alpha = 0;
  } else {
    if(engagedisttype == "") {
      self[1] setvalue(units);
      self[2] settext("");
      self[3].alpha = 0;
    } else {
      if(engagedisttype == "") {
        amountunder = level.weaponengagedistvalues.engagedistmin - units;
        self[1] setvalue(units);
        self[3] setvalue(amountunder);
        self[3].alpha = 1;
        if(level.lastdisttype != engagedisttype) {
          self[2] settext("");
        }
      } else {
        if(engagedisttype == "") {
          amountover = units - level.weaponengagedistvalues.engagedistmax;
          self[1] setvalue(units);
          self[3] setvalue(amountover);
          self[3].alpha = 1;
          if(level.lastdisttype != engagedisttype) {
            self[2] settext("");
          }
        } else if(engagedisttype == "") {
          self[1] setvalue(units);
          self[2] settext("");
          self[3].alpha = 0;
        }
      }
    }
  }
  level.lastdisttype = engagedisttype;
}

function plot_circle_fortime(radius1, radius2, time, color, origin, normal) {
  if(!isDefined(color)) {
    color = (0, 1, 0);
  }
  hangtime = 0.05;
  circleres = 6;
  hemires = circleres / 2;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0;
  timer = gettime() + (time * 1000);
  radius = radius1;
  while(gettime() < timer) {
    radius = radius2;
    angletoplayer = vectortoangles(normal);
    for(i = 0; i < circleres; i++) {
      plotpoints[plotpoints.size] = origin + (vectorscale(anglesToForward(angletoplayer + (rad, 90, 0)), radius));
      rad = rad + circleinc;
    }
    util::plot_points(plotpoints, color[0], color[1], color[2], hangtime);
    plotpoints = [];
    wait(hangtime);
  }
}

function larry_thread() {
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  level.larry = spawnStruct();
  player = util::gethostplayer();
  player thread larry_init(level.larry);
  level waittill("kill_larry");
  larry_hud_destroy(level.larry);
  if(isDefined(level.larry.model)) {
    level.larry.model delete();
  }
  if(isDefined(level.larry.ai)) {
    for(i = 0; i < level.larry.ai.size; i++) {
      kick(level.larry.ai[i] getentitynumber());
    }
  }
  level.larry = undefined;
}

function larry_init(larry) {
  level endon("kill_larry");
  larry_hud_init(larry);
  larry.model = spawn("", (0, 0, 0));
  larry.model setModel("");
  larry.ai = [];
  wait(0.1);
  for(;;) {
    wait(0.05);
    if(larry.ai.size > 0) {
      larry.model hide();
      continue;
    }
    direction = self getplayerangles();
    direction_vec = anglesToForward(direction);
    eye = self getEye();
    trace = bulletTrace(eye, eye + vectorscale(direction_vec, 8000), 0, undefined);
    dist = distance(eye, trace[""]);
    position = eye + (vectorscale(direction_vec, dist - 64));
    larry.model.origin = position;
    larry.model.angles = self.angles + vectorscale((0, 1, 0), 180);
    if(self usebuttonpressed()) {
      self larry_ai(larry);
      while(self usebuttonpressed()) {
        wait(0.05);
      }
    }
  }
}

function larry_ai(larry) {
  larry.ai[larry.ai.size] = bot::add_bot("");
  i = larry.ai.size - 1;
  larry.ai[i] thread larry_ai_thread(larry, larry.model.origin, larry.model.angles);
  larry.ai[i] thread larry_ai_damage(larry);
  larry.ai[i] thread larry_ai_health(larry);
}

function larry_ai_thread(larry, origin, angles) {
  level endon("kill_larry");
  for(;;) {
    self waittill("spawned_player");
    larry.menu[larry.menu_health] setvalue(self.health);
    larry.menu[larry.menu_damage] settext("");
    larry.menu[larry.menu_range] settext("");
    larry.menu[larry.menu_hitloc] settext("");
    larry.menu[larry.menu_weapon] settext("");
    larry.menu[larry.menu_perks] settext("");
    self setorigin(origin);
    self setplayerangles(angles);
    self clearperks();
  }
}

function larry_ai_damage(larry) {
  level endon("kill_larry");
  for(;;) {
    self waittill("damage", damage, attacker, dir, point);
    if(!isDefined(attacker)) {
      continue;
    }
    player = util::gethostplayer();
    if(!isDefined(player)) {
      continue;
    }
    if(attacker != player) {
      continue;
    }
    eye = player getEye();
    range = int(distance(eye, point));
    larry.menu[larry.menu_health] setvalue(self.health);
    larry.menu[larry.menu_damage] setvalue(damage);
    larry.menu[larry.menu_range] setvalue(range);
    if(isDefined(self.cac_debug_location)) {
      larry.menu[larry.menu_hitloc] settext(self.cac_debug_location);
    } else {
      larry.menu[larry.menu_hitloc] settext("");
    }
    if(isDefined(self.cac_debug_weapon)) {
      larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
      continue;
    }
    larry.menu[larry.menu_weapon] settext("");
  }
}

function larry_ai_health(larry) {
  level endon("kill_larry");
  for(;;) {
    wait(0.05);
    larry.menu[larry.menu_health] setvalue(self.health);
  }
}

function larry_hud_init(larry) {
  /
  #
  x = -45;
  y = 275;
  menu_name = "";
  larry.hud = new_hud(menu_name, undefined, x, y, 1);
  larry.hud setshader("", 135, 65);
  larry.hud.alignx = "";
  larry.hud.aligny = "";
  larry.hud.sort = 10;
  larry.hud.alpha = 0.6;
  larry.hud.color = vectorscale((0, 0, 1), 0.5);
  larry.menu[0] = new_hud(menu_name, "", x + 5, y + 10, 1);
  larry.menu[1] = new_hud(menu_name, "", x + 5, y + 20, 1);
  larry.menu[2] = new_hud(menu_name, "", x + 5, y + 30, 1);
  larry.menu[3] = new_hud(menu_name, "", x + 5, y + 40, 1);
  larry.menu[4] = new_hud(menu_name, "", x + 5, y + 50, 1);
  larry.cleartextmarker = newdebughudelem();
  larry.cleartextmarker.alpha = 0;
  larry.cleartextmarker settext("");
  larry.menu_health = larry.menu.size;
  larry.menu_damage = larry.menu.size + 1;
  larry.menu_range = larry.menu.size + 2;
  larry.menu_hitloc = larry.menu.size + 3;
  larry.menu_weapon = larry.menu.size + 4;
  larry.menu_perks = larry.menu.size + 5;
  x_offset = 70;
  larry.menu[larry.menu_health] = new_hud(menu_name, "", x + x_offset, y + 10, 1);
  larry.menu[larry.menu_damage] = new_hud(menu_name, "", x + x_offset, y + 20, 1);
  larry.menu[larry.menu_range] = new_hud(menu_name, "", x + x_offset, y + 30, 1);
  larry.menu[larry.menu_hitloc] = new_hud(menu_name, "", x + x_offset, y + 40, 1);
  larry.menu[larry.menu_weapon] = new_hud(menu_name, "", x + x_offset, y + 50, 1);
  larry.menu[larry.menu_perks] = new_hud(menu_name, "", x + x_offset, y + 60, 1);
}

function larry_hud_destroy(larry) {
  if(isDefined(larry.hud)) {
    larry.hud destroy();
    for(i = 0; i < larry.menu.size; i++) {
      larry.menu[i] destroy();
    }
    larry.cleartextmarker destroy();
  }
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

function watch_botsdvars() {
  hasplayerweaponprev = getdvarint("");
  grenadesonlyprev = getdvarint("");
  secondarygrenadesonlyprev = getdvarint("");
  while(true) {
    if(hasplayerweaponprev != getdvarint("")) {
      hasplayerweaponprev = getdvarint("");
      if(hasplayerweaponprev) {
        iprintlnbold("");
      } else {
        iprintlnbold("");
      }
    }
    if(grenadesonlyprev != getdvarint("")) {
      grenadesonlyprev = getdvarint("");
      if(grenadesonlyprev) {
        iprintlnbold("");
      } else {
        iprintlnbold("");
      }
    }
    if(secondarygrenadesonlyprev != getdvarint("")) {
      secondarygrenadesonlyprev = getdvarint("");
      if(secondarygrenadesonlyprev) {
        iprintlnbold("");
      } else {
        iprintlnbold("");
      }
    }
    wait(1);
  }
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
    if(self buttonpressed(dpad_modifier_button)) {
      if(!dpad_left && self buttonpressed("")) {
        self giveweaponnextattachment("");
        dpad_left = 1;
        self thread print_weapon_name();
      }
      if(!dpad_right && self buttonpressed("")) {
        self giveweaponnextattachment("");
        dpad_right = 1;
        self thread print_weapon_name();
      }
      if(!dpad_up && self buttonpressed("")) {
        self giveweaponnextattachment("");
        dpad_up = 1;
        self thread print_weapon_name();
      }
      if(!dpad_down && self buttonpressed("")) {
        self giveweaponnextattachment("");
        dpad_down = 1;
        self thread print_weapon_name();
      }
      if(!lstick_down && self buttonpressed("")) {
        self giveweaponnextattachment("");
        lstick_down = 1;
        self thread print_weapon_name();
      }
    }
    if(!self buttonpressed("")) {
      dpad_left = 0;
    }
    if(!self buttonpressed("")) {
      dpad_right = 0;
    }
    if(!self buttonpressed("")) {
      dpad_up = 0;
    }
    if(!self buttonpressed("")) {
      dpad_down = 0;
    }
    if(!self buttonpressed("")) {
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
  level.dev_equipment[10] = getweapon("");
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
  level.dev_grenade[11] = getweapon("");
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
  setdvar("", "");
  while(true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_equipment[devgui_int]);
      }
      setdvar("", "");
    }
  }
}

function grenade_dev_gui() {
  set_equipment_list();
  set_grenade_list();
  setdvar("", "");
  while(true) {
    wait(0.5);
    devgui_int = getdvarint("");
    if(devgui_int != 0) {
      for(i = 0; i < level.players.size; i++) {
        take_all_grenades_and_equipment(level.players[i]);
        level.players[i] giveweapon(level.dev_grenade[devgui_int]);
      }
      setdvar("", "");
    }
  }
}

function force_grenade_throw(weapon) {
  if(weapon == level.weaponnone) {
    return;
  }
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  host = util::gethostplayer();
  if(!isDefined(host.team)) {
    iprintln("");
    return;
  }
  bot = getormakebot(util::getotherteam(host.team));
  if(!isDefined(bot)) {
    iprintln("");
    return;
  }
  angles = host getplayerangles();
  angles = (0, angles[1], 0);
  dir = anglesToForward(angles);
  dir = vectornormalize(dir);
  origin = host getEye() + vectorscale(dir, 256);
  velocity = vectorscale(dir, -1024);
  grenade = bot magicgrenadeplayer(weapon, origin, velocity);
  grenade setteam(bot.team);
  grenade setowner(bot);
}

function bot_dpad_think() {
  level notify("bot_dpad_stop");
  level endon("bot_dpad_stop");
  level endon("bot_dpad_terminate");
  if(!isDefined(level.bot_index)) {
    level.bot_index = 0;
  }
  host = util::gethostplayer();
  while(!isDefined(host)) {
    wait(0.5);
    host = util::gethostplayer();
    level.bot_index = 0;
  }
  dpad_left = 0;
  dpad_right = 0;
  for(;;) {
    wait(0.05);
    host setactionslot(3, "");
    host setactionslot(4, "");
    players = getplayers();
    max = players.size;
    if(!dpad_left && host buttonpressed("")) {
      level.bot_index--;
      if(level.bot_index < 0) {
        level.bot_index = max - 1;
      }
      if(!players[level.bot_index] util::is_bot()) {
        continue;
      }
      dpad_left = 1;
    } else if(!host buttonpressed("")) {
      dpad_left = 0;
    }
    if(!dpad_right && host buttonpressed("")) {
      level.bot_index++;
      if(level.bot_index >= max) {
        level.bot_index = 0;
      }
      if(!players[level.bot_index] util::is_bot()) {
        continue;
      }
      dpad_right = 1;
    } else if(!host buttonpressed("")) {
      dpad_right = 0;
    }
    level notify("bot_index_changed");
  }
}

function bot_overlay_think() {
  level endon("bot_overlay_stop");
  level thread bot_dpad_think();
  iprintln("");
  iprintln("");
  for(;;) {
    if(getdvarint("") != level.bot_index) {
      setdvar("", level.bot_index);
    }
    level waittill("bot_index_changed");
  }
}

function bot_threat_think() {
  level endon("bot_threat_stop");
  level thread bot_dpad_think();
  iprintln("");
  iprintln("");
  for(;;) {
    if(getdvarint("") != level.bot_index) {
      setdvar("", level.bot_index);
    }
    level waittill("bot_index_changed");
  }
}

function bot_path_think() {
  level endon("bot_path_stop");
  level thread bot_dpad_think();
  iprintln("");
  iprintln("");
  for(;;) {
    if(getdvarint("") != level.bot_index) {
      setdvar("", level.bot_index);
    }
    level waittill("bot_index_changed");
  }
}

function bot_overlay_stop() {
  level notify("bot_overlay_stop");
  setdvar("", "");
}

function bot_path_stop() {
  level notify("bot_path_stop");
  setdvar("", "");
}

function bot_threat_stop() {
  level notify("bot_threat_stop");
  setdvar("", "");
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
    if(killstreaks::should_draw_debug("") > 0) {
      nodes = [];
      end = 0;
      node = getvehiclenode("", "");
      if(!isDefined(node)) {
        println("");
        setdvar("", "");
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
    if(player buttonpressed("")) {
      return node;
    }
    if(player buttonpressed("")) {
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
    if(player buttonpressed("")) {
      level notify("draw_pathnode_stop");
      return undefined;
    }
  }
  level thread draw_pathnode_think(start, (0, 1, 0));
  while(player buttonpressed("")) {
    wait(0.05);
  }
  end = undefined;
  while(!isDefined(end)) {
    end = node_get(player);
    if(player buttonpressed("")) {
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
    if(player buttonpressed("")) {
      return origin;
    }
    if(player buttonpressed("")) {
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
  while(player buttonpressed("")) {
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