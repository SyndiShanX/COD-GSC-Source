/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\respawn\cp_ac130_respawn.gsc
***************************************************/

function start_ac130_respawn_sequence(var0, var1, var2, var3) {
  if(!istrue(var3)) {
    if(!isDefined(level.br_ac130)) {
      var4 = get_path_over_players(var0, var2);
      thread spawnc130(var4);
    }
  }

  if(!isDefined(var1)) {
    var1 = level.players_in_respawn_queue;
  }

  foreach(var6 in var1) {
    if(istrue(var6.binc130)) {
      continue;
    }

    var6 scripts\cp\respawn\cp_respawn::do_resurrection_logic(var2);
    var6 notify("respawn_player", 1);
    thread start_black_screen(var6);
  }
}

function spawnc130(var0, var1, var2) {
  var3 = distance(var0.startpt, var0.endpt);
  var4 = var3 / 3044;

  if(istrue(var1)) {
    var2 endon("death");

    if(!isDefined(level.respawn_c130[var2.name])) {
      level.respawn_c130[var2.name] = gunship_spawn(var0.startpt, var0.endpt, var4, var1, var0, var2);
      level.respawn_c130[var2.name].ref_12205 = var0;
    }
  } else {
    level.br_ac130 = gunship_spawn(var0.startpt, var0.endpt, var4, undefined, var0);
  }

  return var4;
}

function gunship_spawn(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_model", var0);
  var6 setModel("veh8_mil_air_acharlie130_ks");
  var6 setCanDamage(0);
  var6.maxhealth = 100000;
  var6.health = var6.maxhealth;
  var6.dir = vectorNormalize(var1 - var0);
  var6.angles = vectortoangles(var6.dir);
  var6.dir = vectorNormalize(var1 - var0);
  var6.angles = vectortoangles(var6.dir);
  var6.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  var6.currentplayeroffset = 0;
  var6.player_queue = [];
  var6.ref_12205 = var4;
  thread gunship_startintroshake();

  if(istrue(var3)) {
    level.respawn_c130[var5.name] = var6;
    level.respawn_c130[var5.name] hide();
    thread ref_14460(level.respawn_c130[var5.name]);
    level.respawn_c130[var5.name] endon("death");
  } else {
    level.br_ac130 = var6;
  }

  while(var6.player_queue.size <= 0) {
    waitframe();
  }

  foreach(var8 in var6.player_queue) {}

  var6 moveTo(var1, var2);
  thread killaftertime(var6);
  var6 playLoopSound("iw8_ks_ac130_lp");
  return var6;
}

function ref_14460(var0) {
  self endon("death");
  var0 waittill("death");

  if(isDefined(self.innards)) {
    self.innards delete();
  }

  self delete();
}

function gunship_startintroshake() {
  self endon("death");
  var0 = level.scr_anim["gunship"]["gunship_intro"];
  var1 = getanimlength(var0);
  var2 = var1;
  var3 = 0.45;
  var4 = 0.05;

  while(var2 > 0) {
    earthquake(var3, var4, self.origin, 5000);
    var3 -= 0.01;

    if(var3 <= 0.12) {
      var3 = 0.12;
    }

    var2 -= var4;
    wait var4;
  }
}

function showicon() {
  var0 = scripts\cp\utility::nonobjective_requestobjectiveid(10);

  if(var0 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var0, "invisible", (0, 0, 0));
  scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var0, self);
  scripts\mp\objidpoolmanager::update_objective_state(var0, "active");
  var1 = "icon_minimap_dropship";
  scripts\mp\objidpoolmanager::update_objective_icon(var0, var1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var0, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var0);
  self.objid = var0;
}

function gunship_spawnvfx() {
  level endon("game_ended");

  if(!isDefined(level._effect["vfx_snatch_ac130_clouds"])) {
    return;
  }

  wait 1;
  playFXOnTag(level._effect["vfx_snatch_ac130_clouds"], self, "tag_body");
}

function killaftertime(var0) {
  level endon("game_ended");
  self endon("death");
  wait var0;

  if(isDefined(self.players)) {
    foreach(var2 in self.players) {
      if(!isDefined(var2)) {
        continue;
      }

      var2.jumptype = "outOfBounds";
      var2 notify("halo_kick_c130");
      var2 notify("halo_jump_c130");
      var2.kickedfromc130 = 1;
    }
  }

  wait 0.1;

  if(isDefined(self.innards)) {
    self.innards delete();
  }

  self delete();
}

function expandspawnpointbounds(var0) {
  var1 = [];
  var2 = [];

  foreach(var4 in var0) {
    var1 = expandmins(var1, var4);
    var2 = expandmaxs(var2, var4);
  }
}

function expandmins(var0, var1) {
  if(var0[0] > var1[0]) {
    var0 = (var1[0], var0[1], var0[2]);
  }

  if(var0[1] > var1[1]) {
    var0 = (var0[0], var1[1], var0[2]);
  }

  if(var0[2] > var1[2]) {
    var0 = (var0[0], var0[1], var1[2]);
  }

  return var0;
}

function expandmaxs(var0, var1) {
  if(var0[0] < var1[0]) {
    var0 = (var1[0], var0[1], var0[2]);
  }

  if(var0[1] < var1[1]) {
    var0 = (var0[0], var1[1], var0[2]);
  }

  if(var0[2] < var1[2]) {
    var0 = (var0[0], var0[1], var1[2]);
  }

  return var0;
}

function findboxcenter(var0, var1) {
  var2 = (0, 0, 0);
  var2 = var1 - var0;
  var2 = (var2[0] / 2, var2[1] / 2, var2[2] / 2) + var0;
  return var2;
}

function get_path_over_players(var0, var1, var2) {
  if(trial_ui_decrease_tries_remaining()) {
    return quest_assdistmax(var0, var1, var2);
  }

  return forcegivekillstreak(var0, var1);
}

function forcegivekillstreak(var0, var1) {
  var2 = 30000;
  var3 = 1000;
  var4 = 300;
  var5 = [];

  foreach(var7 in level.players) {
    if(!var7 isonground() || istrue(var7.inlaststand)) {
      continue;
    }

    var5 = scripts\engine\utility::array_add(var5, var7);
  }

  if(var5.size > 0) {
    var9 = getaverageorigin(var5);
  } else {
    var9 = scripts\engine\utility::drop_to_ground(var1);
  }

  if(isDefined(var2) && isPlayer(var2)) {
    var1 = var2.origin;
  }

  var9 = (var1[0], var1[1], 4333);
  var10 = [40000, 20000, 15000, 7000, 4500, 2500, 1000, 0];
  var11 = (0, randomfloatrange(0, 360), 0);
  var11 = (0, getdvarfloat("scr_br_c130PathAngle", var11[1]), 0);
  var12 = anglesToForward(var11);
  var13 = 2;
  var14 = var10[4];
  var15 = var9 - var12 * var14 + (0, 0, abs(4333 - var5));
  var16 = var9 + var12 * var14 * var13;
  var15 -= var12 * 3044 * 2;
  var16 += var12 * 3044;
  var15 = var1 + (-5000, 0, 4333);
  var16 = var1 + (5000, 0, 4333);
  var17 = spawnStruct();
  var17.startpt = var15;
  var17.endpt = var16;
  var17.angle = var11;
  var17.modevalidatekillstreakslot = var9;
  return var17;
}

function quest_assdistmax(var0, var1, var2) {
  if(!isDefined(level.initlethalmaxoffsetmap)) {
    return;
  }

  if(!isstring(level.initlethalmaxoffsetmap)) {
    return;
  }

  if(isDefined(level.initlocationcircle)) {
    level.initlethalmaxoffsetmap = level.initlocationcircle;
  }

  var3 = scripts\engine\utility::getStructArray(level.initlethalmaxoffsetmap, "targetname");
  var4 = var3[0];

  if(var3.size > 1) {
    if(isDefined(var3[1].name)) {
      var4 = var3[1];
    } else {
      var4 = var3[0];
    }
  }

  var5 = "";

  if(!isDefined(var4)) {
    if(isDefined(level.ref_12880) && level.ref_12880.size > 0) {
      for(var6 = level.ref_12880.size - 1; var6 >= 0; var6--) {
        if(isDefined(level.ref_12880[var6])) {
          var7 = scripts\engine\utility::getStructArray(level.ref_12880[var6], "targetname");

          if(isDefined(var7) && var7.size > 0) {
            var5 = level.ref_12880[var6];
          }

          break;
        }
      }

      if(var5 == "") {
        return forcegivekillstreak(var0, var1);
      }

      var3 = scripts\engine\utility::getStructArray(var5, "targetname");
      var4 = var3[0];

      if(var3.size > 1) {
        if(isDefined(var3[1].name)) {
          var4 = var3[1];
        } else {
          var4 = var3[0];
        }
      }

      level.initlethalmaxoffsetmap = var5;
    } else {
      return forcegivekillstreak(var1, var2);
    }
  }

  if(!scripts\engine\utility::array_contains(level.ref_12880, level.initlethalmaxoffsetmap)) {
    level.ref_12880 = scripts\engine\utility::array_add(level.ref_12880, level.initlethalmaxoffsetmap);
  }

  var8 = var4.origin;

  if(istrue(var2) && level.respawn_c130.size > 1) {
    if(level.respawn_c130.size % 2 == 0) {
      var9 = (var8[0], var8[1], 4633);
    } else {
      var9 = (var9[0], var9[1], 4033);
    }
  } else {
    var9 = (var9[0], var9[1], 4333);
  }

  var10 = (0, randomfloatrange(0, 360), 0);
  var10 = (0, getdvarfloat("scr_respawn_angles", var10[1]), 0);
  var11 = anglesToForward(var10);
  var12 = 7000;
  var13 = var9 - var11 * var12;
  var14 = var9 + var11 * var12;
  var13 -= var11 * getc130speed() * 7;
  var14 += var11 * getc130speed() * 5;
  var15 = spawnStruct();
  var15.startpt = var13;
  var15.endpt = var14;
  var15.modevalidatekillstreakslot = var9;
  var15.angle = vectortoangles(var11);
  var15.ref_11f8c = var9;
  return var15;
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

function ref_131d9() {
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

function getaverageorigin(var0) {
  var1 = (0, 0, 0);

  if(!var0.size) {
    return undefined;
  }

  foreach(var3 in var0) {
    var1 += var3.origin;
  }

  var5 = int(var1[0] / var0.size);
  var6 = int(var1[1] / var0.size);
  var7 = int(var1[2] / var0.size);
  var1 = (var5, var6, var7);
  return var1;
}

function start_black_screen(var0, var1) {
  var0 endon("disconnect");
  var0 playerhide();
  scripts\cp\cp_outofbounds::enableoobimmunity(var0);
  var0 setCanDamage(0);
  var0 setclientomnvar("ui_hide_hud", 1);
  var0 setclientomnvar("player_respawning", 1);
  var0 disableweapons();
  var2 = newclienthudelem(var0);
  var2.x = 0;
  var2.y = 0;
  var2.alignx = "left";
  var2.aligny = "top";
  var2.sort = 1;
  var2.horzalign = "fullscreen";
  var2.vertalign = "fullscreen";
  var2.alpha = 1;
  var2.foreground = 1;
  var2 setshader("black", 640, 480);
  var0.no_outline = 1;
  var0.no_team_outlines = 1;
  var0 scripts\cp\utility::giveperk("specialty_spygame");
  var0 scripts\cp\utility::giveperk("specialty_coldblooded");
  var0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
  var0 scripts\cp\utility::giveperk("specialty_heartbreaker");
  var0 scripts\cp\utility::freezecontrolswrapper(1);

  if(istrue(var1)) {
    var0 waittill("spawned_player");
    var0.no_outline = 1;
    var0.no_team_outlines = 1;
    var0 scripts\cp\utility::giveperk("specialty_spygame");
    var0 scripts\cp\utility::giveperk("specialty_coldblooded");
    var0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
    var0 scripts\cp\utility::giveperk("specialty_heartbreaker");
    var0 playerhide();

    while(!isDefined(level.respawn_c130[var0.name])) {
      wait 1;
    }

    var0 cameraset("cam_orbit_br_ac130");
    var0 setadditionalstreampos(level.respawn_c130[var0.name].origin, 1);
    var0 setOrigin(level.respawn_c130[var0.name].origin);
    var0 setplayerangles(level.respawn_c130[var0.name].angles);
    var0 playerlinkTo(level.respawn_c130[var0.name], "");
    var0 thread scripts\cp\cp_globallogic::open_loadout_menu();
    var0 notify("open_loadout_menu");
    var0 waittill("loadout_given");
    var0 thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1.5, 1, "white");

    if(level.gametype == "cp_survival") {
      var0 setclientomnvar("ui_session_state", "playing");

      if(!istrue(self.ref_11b20)) {
        var0 scripts\cp\cp_globallogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
      }
    }

    var0.no_outline = 1;
    var0.no_team_outlines = 1;
    var0 scripts\cp\utility::giveperk("specialty_spygame");
    var0 scripts\cp\utility::giveperk("specialty_coldblooded");
    var0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
    var0 scripts\cp\utility::giveperk("specialty_heartbreaker");
    level.respawn_c130[var0.name] show();
    wait 1;
    playfxontagforclients(level._effect["c130_clouds"], level.respawn_c130[var0.name], "tag_body", var0);
    playfxontagforclients(level._effect["c130_lights"], level.respawn_c130[var0.name], "tag_body", var0);
    var0 playerhide();
  } else {
    var0 waittill("spawned_player");
    playfxontagforclients(level._effect["c130_clouds"], level.br_ac130, "tag_body", var0);
    playfxontagforclients(level._effect["c130_lights"], level.br_ac130, "tag_body", var0);
  }

  var0 setclientomnvar("ui_hide_hud", 1);
  thread enable_damage_on_landing();
  thread spawn_player_into_c130(level, var0);

  if(!scripts\engine\utility::flag("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  var2 fadeovertime(4);
  var2.alpha = 0;
  wait 4;
  var0 enableweapons();
  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var2 destroy();
}

function spam_errors_as_prints(var0, var1) {
  self notify("spam_errors_as_prints" + var0.name);
  self endon("spam_errors_as_prints" + var0.name);

  for(;;) {
    iprintln(var0.name + " ^5 Is waiting for notify - ^1" + var1);
    wait 5;
  }
}

function enable_damage_on_landing() {
  scripts\engine\utility::ref_143a6("parachute_complete", "parachute_landed", "skydive_land");
  self setCanDamage(1);
  self.respawn_in_progress = undefined;
  self setclientomnvar("player_respawning", 0);
}

function spawn_player_into_c130(var0, var1) {
  var0 endon("disconnect");

  if(istrue(var1)) {
    level.respawn_c130[var0.name].player_queue = scripts\engine\utility::array_add(level.respawn_c130[var0.name].player_queue, var0);
  } else {
    level.br_ac130.player_queue = scripts\engine\utility::array_add(level.br_ac130.player_queue, var0);
  }

  var0.ref_12982 = 1;
  var0 unlink();
  var0 scripts\cp_mp\parachute::freefallstartdefault();

  if(istrue(var1)) {
    thread listenjump(var0, level.respawn_c130[var0.name]);

    if(!isbot(var0)) {
      thread orbitcam(var0);
    }
  } else {
    thread listenjump(var0, level.br_ac130);

    if(!isbot(var0)) {
      thread orbitcam(var0);
    }
  }

  var0.no_outline = 0;
  var0.no_team_outlines = 0;
  var0 scripts\cp\utility::_unsetperk("specialty_spygame");
  var0 scripts\cp\utility::_unsetperk("specialty_coldblooded");
  var0 scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
  var0 scripts\cp\utility::_unsetperk("specialty_heartbreaker");
  var0.br_infil_type = "c130";

  if(trial_ui_decrease_tries_remaining()) {
    if(istrue(var1)) {
      thread playerplaydepositanim(var0);
      return;
    }

    thread playerplaydepositanim(var0);
    return;
  }

  thread forcejumpaftertimeout(var0);
}

function orbitcam(var0) {
  self visionsetnakedforplayer("", 0);
  self setplayerangles(var0.ref_12205.angle);
  self playerlinkTo(var0, "");
  self cameraset("cam_orbit_br_ac130");
}

function playerplaydepositanim(var0) {
  var0 endon("death");
  self endon("disconnect");

  for(;;) {
    if(distance2dsquared(var0.origin, var0.ref_12205.modevalidatekillstreakslot) <= 1048576) {
      break;
    }

    waitframe();
  }

  self.jumptype = "objectiveJump";
  self notify("halo_jump_c130");
}

function forcejumpaftertimeout(var0) {
  wait var0;
  self.jumptype = "outOfBounds";
  self notify("halo_kick_c130");
  self notify("halo_jump_c130");
}

function listenjump(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("cancel_heli");
  self endon("br_jump");
  self waittill("halo_jump_c130");
  self setclientomnvar("player_respawning", 0);

  if(scripts\engine\utility::array_contains(var0.player_queue, self)) {
    var0.player_queue = scripts\engine\utility::array_remove(var0.player_queue, self);
  }

  self.ref_12982 = undefined;
  self cameradefault();
  self.br_infil_type = undefined;
  thread parachute(var0, var1, 0, 0);
  self notify("br_jump");
}

function parachute(var0, var1, var2, var3) {
  self unlink();

  if(isDefined(self.br_orbitcam)) {
    self.br_orbitcam delete();
  }

  if(isDefined(var0.playeroffsets) && isDefined(var0.currentplayeroffset)) {
    var4 = var0.playeroffsets[var0.currentplayeroffset];
    self setOrigin(var0.origin + var4, 1, 1);
    var0.currentplayeroffset++;

    if(var0.currentplayeroffset == var0.playeroffsets.size) {
      var0.currentplayeroffset = 0;
    }
  } else {
    var5 = anglesToForward(var0.angles) * var0.br_vieworigin;
    self setOrigin(var0.origin + var5, 1, 1);
  }

  waitframe();
  self playershow(1);

  if(istrue(var2)) {
    self setplayerangles((0, var0.angles[1] + 180, 0));
  } else {
    self setplayerangles(var0.ref_12205.angle);
  }

  var6 = (0, 0, 0);

  if(istrue(var3)) {
    var6 = anglesToForward(var0.angles) * 1522;
  }

  self setclientomnvar("ui_hide_hud", 0);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  thread scripts\cp_mp\parachute::startfreefall(1, 0, undefined, var6);
}

function setup_comms_obj_crate(var0) {
  var0.forcespawnangles = level.br_ac130.angles;
  var0 thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1, 1, "white");
  var0 spawn(level.br_ac130.origin, level.br_ac130.ref_12205.angle);
  var0 playerhide();
  var0 cameraset("cam_orbit_br_ac130");
  var0.bspawningviaac130 = 1;
  var1 = undefined;
  var0 scripts\cp\respawn\cp_respawn::camera_setup_for_lerping(var0, level.br_ac130);
}