/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\respawn\cp_ac130_respawn.gsc
***************************************************/

function start_ac130_respawn_sequence(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3)) {
    if(!isDefined(level.br_ac130)) {
      var_4 = get_path_over_players(var_0, var_2);
      thread spawnc130(var_4);
    }
  }

  if(!isDefined(var_1)) {
    var_1 = level.players_in_respawn_queue;
  }

  foreach(var_6 in var_1) {
    if(istrue(var_6.binc130)) {
      continue;
    }

    var_6 scripts\cp\respawn\cp_respawn::do_resurrection_logic(var_2);
    var_6 notify("respawn_player", 1);
    thread start_black_screen(var_6);
  }
}

function spawnc130(var_0, var_1, var_2) {
  var_3 = distance(var_0.startpt, var_0.endpt);
  var_4 = var_3 / 3044;

  if(istrue(var_1)) {
    var_2 endon("death");

    if(!isDefined(level.respawn_c130[var_2.name])) {
      level.respawn_c130[var_2.name] = gunship_spawn(var_0.startpt, var_0.endpt, var_4, var_1, var_0, var_2);
      level.respawn_c130[var_2.name].ref_12205 = var_0;
    }
  } else {
    level.br_ac130 = gunship_spawn(var_0.startpt, var_0.endpt, var_4, undefined, var_0);
  }

  return var_4;
}

function gunship_spawn(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_0);
  var_6 setModel("veh8_mil_air_acharlie130_ks");
  var_6 setCanDamage(0);
  var_6.maxhealth = 100000;
  var_6.health = var_6.maxhealth;
  var_6.dir = vectorNormalize(var_1 - var_0);
  var_6.angles = vectortoangles(var_6.dir);
  var_6.dir = vectorNormalize(var_1 - var_0);
  var_6.angles = vectortoangles(var_6.dir);
  var_6.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  var_6.currentplayeroffset = 0;
  var_6.player_queue = [];
  var_6.ref_12205 = var_4;
  thread gunship_startintroshake();

  if(istrue(var_3)) {
    level.respawn_c130[var_5.name] = var_6;
    level.respawn_c130[var_5.name] hide();
    thread ref_14460(level.respawn_c130[var_5.name]);
    level.respawn_c130[var_5.name] endon("death");
  } else {
    level.br_ac130 = var_6;
  }

  while(var_6.player_queue.size <= 0) {
    waitframe();
  }

  foreach(var_8 in var_6.player_queue) {}

  var_6 moveTo(var_1, var_2);
  thread killaftertime(var_6);
  var_6 playLoopSound("iw8_ks_ac130_lp");
  return var_6;
}

function ref_14460(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self.innards)) {
    self.innards delete();
  }

  self delete();
}

function gunship_startintroshake() {
  self endon("death");
  var_0 = level.scr_anim["gunship"]["gunship_intro"];
  var_1 = getanimlength(var_0);
  var_2 = var_1;
  var_3 = 0.45;
  var_4 = 0.05;

  while(var_2 > 0) {
    earthquake(var_3, var_4, self.origin, 5000);
    var_3 -= 0.01;

    if(var_3 <= 0.12) {
      var_3 = 0.12;
    }

    var_2 -= var_4;
    wait var_4;
  }
}

function showicon() {
  var_0 = scripts\cp\utility::nonobjective_requestobjectiveid(10);

  if(var_0 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var_0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_0, "active");
  var_1 = "icon_minimap_dropship";
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
  self.objid = var_0;
}

function gunship_spawnvfx() {
  level endon("game_ended");

  if(!isDefined(level._effect["vfx_snatch_ac130_clouds"])) {
    return;
  }

  wait 1;
  playFXOnTag(level._effect["vfx_snatch_ac130_clouds"], self, "tag_body");
}

function killaftertime(var_0) {
  level endon("game_ended");
  self endon("death");
  wait var_0;

  if(isDefined(self.players)) {
    foreach(var_2 in self.players) {
      if(!isDefined(var_2)) {
        continue;
      }

      var_2.jumptype = "outOfBounds";
      var_2 notify("halo_kick_c130");
      var_2 notify("halo_jump_c130");
      var_2.kickedfromc130 = 1;
    }
  }

  wait 0.1;

  if(isDefined(self.innards)) {
    self.innards delete();
  }

  self delete();
}

function expandspawnpointbounds(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    var_1 = expandmins(var_1, var_4);
    var_2 = expandmaxs(var_2, var_4);
  }
}

function expandmins(var_0, var_1) {
  if(var_0[0] > var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] > var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] > var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

function expandmaxs(var_0, var_1) {
  if(var_0[0] < var_1[0]) {
    var_0 = (var_1[0], var_0[1], var_0[2]);
  }

  if(var_0[1] < var_1[1]) {
    var_0 = (var_0[0], var_1[1], var_0[2]);
  }

  if(var_0[2] < var_1[2]) {
    var_0 = (var_0[0], var_0[1], var_1[2]);
  }

  return var_0;
}

function findboxcenter(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_2 = var_1 - var_0;
  var_2 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_0;
  return var_2;
}

function get_path_over_players(var_0, var_1, var_2) {
  if(trial_ui_decrease_tries_remaining()) {
    return quest_assdistmax(var_0, var_1, var_2);
  }

  return forcegivekillstreak(var_0, var_1);
}

function forcegivekillstreak(var_0, var_1) {
  var_2 = 30000;
  var_3 = 1000;
  var_4 = 300;
  var_5 = [];

  foreach(var_7 in level.players) {
    if(!var_7 isonground() || istrue(var_7.inlaststand)) {
      continue;
    }

    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  if(var_5.size > 0) {
    var_9 = getaverageorigin(var_5);
  } else {
    var_9 = scripts\engine\utility::drop_to_ground(var_1);
  }

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_1 = var_2.origin;
  }

  var_9 = (var_1[0], var_1[1], 4333);
  var_10 = [40000, 20000, 15000, 7000, 4500, 2500, 1000, 0];
  var_11 = (0, randomfloatrange(0, 360), 0);
  var_11 = (0, getdvarfloat("scr_br_c130PathAngle", var_11[1]), 0);
  var_12 = anglesToForward(var_11);
  var_13 = 2;
  var_14 = var_10[4];
  var_15 = var_9 - var_12 * var_14 + (0, 0, abs(4333 - var_5));
  var_16 = var_9 + var_12 * var_14 * var_13;
  var_15 -= var_12 * 3044 * 2;
  var_16 += var_12 * 3044;
  var_15 = var_1 + (-5000, 0, 4333);
  var_16 = var_1 + (5000, 0, 4333);
  var_17 = spawnStruct();
  var_17.startpt = var_15;
  var_17.endpt = var_16;
  var_17.angle = var_11;
  var_17.modevalidatekillstreakslot = var_9;
  return var_17;
}

function quest_assdistmax(var_0, var_1, var_2) {
  if(!isDefined(level.initlethalmaxoffsetmap)) {
    return;
  }

  if(!isstring(level.initlethalmaxoffsetmap)) {
    return;
  }

  if(isDefined(level.initlocationcircle)) {
    level.initlethalmaxoffsetmap = level.initlocationcircle;
  }

  var_3 = scripts\engine\utility::getStructArray(level.initlethalmaxoffsetmap, "targetname");
  var_4 = var_3[0];

  if(var_3.size > 1) {
    if(isDefined(var_3[1].name)) {
      var_4 = var_3[1];
    } else {
      var_4 = var_3[0];
    }
  }

  var_5 = "";

  if(!isDefined(var_4)) {
    if(isDefined(level.ref_12880) && level.ref_12880.size > 0) {
      for(var_6 = level.ref_12880.size - 1; var_6 >= 0; var_6--) {
        if(isDefined(level.ref_12880[var_6])) {
          var_7 = scripts\engine\utility::getStructArray(level.ref_12880[var_6], "targetname");

          if(isDefined(var_7) && var_7.size > 0) {
            var_5 = level.ref_12880[var_6];
          }

          break;
        }
      }

      if(var_5 == "") {
        return forcegivekillstreak(var_0, var_1);
      }

      var_3 = scripts\engine\utility::getStructArray(var_5, "targetname");
      var_4 = var_3[0];

      if(var_3.size > 1) {
        if(isDefined(var_3[1].name)) {
          var_4 = var_3[1];
        } else {
          var_4 = var_3[0];
        }
      }

      level.initlethalmaxoffsetmap = var_5;
    } else {
      return forcegivekillstreak(var_1, var_2);
    }
  }

  if(!scripts\engine\utility::array_contains(level.ref_12880, level.initlethalmaxoffsetmap)) {
    level.ref_12880 = scripts\engine\utility::array_add(level.ref_12880, level.initlethalmaxoffsetmap);
  }

  var_8 = var_4.origin;

  if(istrue(var_2) && level.respawn_c130.size > 1) {
    if(level.respawn_c130.size % 2 == 0) {
      var_9 = (var_8[0], var_8[1], 4633);
    } else {
      var_9 = (var_9[0], var_9[1], 4033);
    }
  } else {
    var_9 = (var_9[0], var_9[1], 4333);
  }

  var_10 = (0, randomfloatrange(0, 360), 0);
  var_10 = (0, getdvarfloat("scr_respawn_angles", var_10[1]), 0);
  var_11 = anglesToForward(var_10);
  var_12 = 7000;
  var_13 = var_9 - var_11 * var_12;
  var_14 = var_9 + var_11 * var_12;
  var_13 -= var_11 * getc130speed() * 7;
  var_14 += var_11 * getc130speed() * 5;
  var_15 = spawnStruct();
  var_15.startpt = var_13;
  var_15.endpt = var_14;
  var_15.modevalidatekillstreakslot = var_9;
  var_15.angle = vectortoangles(var_11);
  var_15.ref_11F8C = var_9;
  return var_15;
}

function getc130speed() {
  return 3044;
}

function trial_ui_decrease_tries_remaining() {
  if(isDefined(level.initlocationcircle)) {
    return true;
  }

  if(scripts\engine\utility::getStructArray("respawn_point", "script_noteworthy").size > 0) {
    return true;
  }

  if(level.script == "cp_scaletest" || level.script == "cp_dwn_twn_2" || level.script == "cp_arms_dealer" || level.script == "cp_smuggler" || level.script == "cp_landlord") {
    return true;
  }

  return false;
}

function ref_131D9() {
  switch (level.script) {
    case "cp_scaletest":
      level.ref_12880 = ["plant_jammers", "infil_plane"];
      break;
    case "cp_dwn_twn_2":
      level.ref_12880 = ["ml_p1_intel"];
      break;
    case "cp_armsdealer_2":
      level.ref_12880 = ["plant_jammers"];
      break;
    case "cp_arms_dealer":
      level.ref_12880 = ["morales_1"];
      break;
    case "cp_smuggler":
      level.ref_12880 = ["obj_caches"];
      break;
    case "cp_landlord":
      level.ref_12880 = ["obj_tmtyl"];
      break;
    case "cp_landlord_2":
      level.ref_12880 = ["ba_mnu"];
      break;
  }
}

function getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size) {
    return undefined;
  }

  foreach(var_3 in var_0) {
    var_1 += var_3.origin;
  }

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

function start_black_screen(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 playerhide();
  scripts\cp\cp_outofbounds::enableoobimmunity(var_0);
  var_0 setCanDamage(0);
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_0 setclientomnvar("player_respawning", 1);
  var_0 disableweapons();
  var_2 = newclienthudelem(var_0);
  var_2.x = 0;
  var_2.y = 0;
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.sort = 1;
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = 1;
  var_2.foreground = 1;
  var_2 setshader("black", 640, 480);
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_0 scripts\cp\utility::giveperk("specialty_spygame");
  var_0 scripts\cp\utility::giveperk("specialty_coldblooded");
  var_0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
  var_0 scripts\cp\utility::giveperk("specialty_heartbreaker");
  var_0 scripts\cp\utility::freezecontrolswrapper(1);

  if(istrue(var_1)) {
    var_0 waittill("spawned_player");
    var_0.no_outline = 1;
    var_0.no_team_outlines = 1;
    var_0 scripts\cp\utility::giveperk("specialty_spygame");
    var_0 scripts\cp\utility::giveperk("specialty_coldblooded");
    var_0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
    var_0 scripts\cp\utility::giveperk("specialty_heartbreaker");
    var_0 playerhide();

    while(!isDefined(level.respawn_c130[var_0.name])) {
      wait 1;
    }

    var_0 cameraset("cam_orbit_br_ac130");
    var_0 setadditionalstreampos(level.respawn_c130[var_0.name].origin, 1);
    var_0 setOrigin(level.respawn_c130[var_0.name].origin);
    var_0 setplayerangles(level.respawn_c130[var_0.name].angles);
    var_0 playerlinkTo(level.respawn_c130[var_0.name], "");
    var_0 thread scripts\cp\cp_globallogic::open_loadout_menu();
    var_0 notify("open_loadout_menu");
    var_0 waittill("loadout_given");
    var_0 thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1.5, 1, "white");

    if(level.gametype == "cp_survival") {
      var_0 setclientomnvar("ui_session_state", "playing");

      if(!istrue(self.ref_11B20)) {
        var_0 scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
      }
    }

    var_0.no_outline = 1;
    var_0.no_team_outlines = 1;
    var_0 scripts\cp\utility::giveperk("specialty_spygame");
    var_0 scripts\cp\utility::giveperk("specialty_coldblooded");
    var_0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
    var_0 scripts\cp\utility::giveperk("specialty_heartbreaker");
    level.respawn_c130[var_0.name] show();
    wait 1;
    playfxontagforclients(level._effect["c130_clouds"], level.respawn_c130[var_0.name], "tag_body", var_0);
    playfxontagforclients(level._effect["c130_lights"], level.respawn_c130[var_0.name], "tag_body", var_0);
    var_0 playerhide();
  } else {
    var_0 waittill("spawned_player");
    playfxontagforclients(level._effect["c130_clouds"], level.br_ac130, "tag_body", var_0);
    playfxontagforclients(level._effect["c130_lights"], level.br_ac130, "tag_body", var_0);
  }

  var_0 setclientomnvar("ui_hide_hud", 1);
  thread enable_damage_on_landing();
  thread spawn_player_into_c130(level, var_0);

  if(!scripts\engine\utility::flag("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  var_2 fadeovertime(4);
  var_2.alpha = 0;
  wait 4;
  var_0 enableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_2 destroy();
}

function spam_errors_as_prints(var_0, var_1) {
  self notify("spam_errors_as_prints" + var_0.name);
  self endon("spam_errors_as_prints" + var_0.name);

  for(;;) {
    iprintln(var_0.name + " ^5 Is waiting for notify - ^1" + var_1);
    wait 5;
  }
}

function enable_damage_on_landing() {
  scripts\engine\utility::ref_143A6("parachute_complete", "parachute_landed", "skydive_land");
  self setCanDamage(1);
  self.respawn_in_progress = undefined;
  self setclientomnvar("player_respawning", 0);
}

function spawn_player_into_c130(var_0, var_1) {
  var_0 endon("disconnect");

  if(istrue(var_1)) {
    level.respawn_c130[var_0.name].player_queue = scripts\engine\utility::array_add(level.respawn_c130[var_0.name].player_queue, var_0);
  } else {
    level.br_ac130.player_queue = scripts\engine\utility::array_add(level.br_ac130.player_queue, var_0);
  }

  var_0.ref_12982 = 1;
  var_0 unlink();
  var_0 scripts\cp_mp\parachute::freefallstartdefault();

  if(istrue(var_1)) {
    thread listenjump(var_0, level.respawn_c130[var_0.name]);

    if(!isbot(var_0)) {
      thread orbitcam(var_0);
    }
  } else {
    thread listenjump(var_0, level.br_ac130);

    if(!isbot(var_0)) {
      thread orbitcam(var_0);
    }
  }

  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\utility::_unsetperk("specialty_spygame");
  var_0 scripts\cp\utility::_unsetperk("specialty_coldblooded");
  var_0 scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  var_0 scripts\cp\utility::_unsetperk("specialty_heartbreaker");
  var_0.br_infil_type = "c130";

  if(trial_ui_decrease_tries_remaining()) {
    if(istrue(var_1)) {
      thread playerplaydepositanim(var_0);
      return;
    }

    thread playerplaydepositanim(var_0);
    return;
  }

  thread forcejumpaftertimeout(var_0);
}

function orbitcam(var_0) {
  self visionsetnakedforplayer("", 0);
  self setplayerangles(var_0.ref_12205.angle);
  self playerlinkTo(var_0, "");
  self cameraset("cam_orbit_br_ac130");
}

function playerplaydepositanim(var_0) {
  var_0 endon("death");
  self endon("disconnect");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_0.ref_12205.modevalidatekillstreakslot) <= 1048576) {
      break;
    }

    waitframe();
  }

  self.jumptype = "objectiveJump";
  self notify("halo_jump_c130");
}

function forcejumpaftertimeout(var_0) {
  wait var_0;
  self.jumptype = "outOfBounds";
  self notify("halo_kick_c130");
  self notify("halo_jump_c130");
}

function listenjump(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("cancel_heli");
  self endon("br_jump");
  self waittill("halo_jump_c130");
  self setclientomnvar("player_respawning", 0);

  if(scripts\engine\utility::array_contains(var_0.player_queue, self)) {
    var_0.player_queue = scripts\engine\utility::array_remove(var_0.player_queue, self);
  }

  self.ref_12982 = undefined;
  self cameradefault();
  self.br_infil_type = undefined;
  thread parachute(var_0, var_1, 0, 0);
  self notify("br_jump");
}

function parachute(var_0, var_1, var_2, var_3) {
  self unlink();

  if(isDefined(self.br_orbitcam)) {
    self.br_orbitcam delete();
  }

  if(isDefined(var_0.playeroffsets) && isDefined(var_0.currentplayeroffset)) {
    var_4 = var_0.playeroffsets[var_0.currentplayeroffset];
    self setOrigin(var_0.origin + var_4, 1, 1);
    var_0.currentplayeroffset++;

    if(var_0.currentplayeroffset == var_0.playeroffsets.size) {
      var_0.currentplayeroffset = 0;
    }
  } else {
    var_5 = anglesToForward(var_0.angles) * var_0.br_vieworigin;
    self setOrigin(var_0.origin + var_5, 1, 1);
  }

  waitframe();
  self playershow(1);

  if(istrue(var_2)) {
    self setplayerangles((0, var_0.angles[1] + 180, 0));
  } else {
    self setplayerangles(var_0.ref_12205.angle);
  }

  var_6 = (0, 0, 0);

  if(istrue(var_3)) {
    var_6 = anglesToForward(var_0.angles) * 1522;
  }

  self setclientomnvar("ui_hide_hud", 0);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  thread scripts\cp_mp\parachute::startfreefall(1, 0, undefined, var_6);
}

function setup_comms_obj_crate(var_0) {
  var_0.forcespawnangles = level.br_ac130.angles;
  var_0 thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1, 1, "white");
  var_0 spawn(level.br_ac130.origin, level.br_ac130.ref_12205.angle);
  var_0 playerhide();
  var_0 cameraset("cam_orbit_br_ac130");
  var_0.bspawningviaac130 = 1;
  var_1 = undefined;
  var_0 scripts\cp\respawn\cp_respawn::camera_setup_for_lerping(var_0, level.br_ac130);
}