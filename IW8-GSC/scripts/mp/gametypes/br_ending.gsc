/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ending.gsc
***********************************************/

function define_as_level_infil_driver() {
  if(!ref_11C64(getDvar("scr_br_gametype"))) {
    return;
  }

  br_ending_override_init();
  setdvarifuninitialized("scr_br_ending_enabled", 1);
  setdvarifuninitialized("scr_br_exfil_5_chance", 0);

  if(_getdeathstatecode::vehicle_damage_loadtable()) {
    setdvarifuninitialized("scr_br_ending_6_enabled", 1);
  } else {
    setdvarifuninitialized("scr_br_ending_6_enabled", 0);
  }

  if(getdvarint("scr_br_ending_6_enabled", 0) == 1) {
    _getdeathstatecode::vehicle_damage_mp_init();
    return;
  }

  go_to_combat();
}

function br_ending_override_init() {
  level.brendingoverride = getDvar("scr_br_ending_override", "");
  var_0 = 0;

  switch (level.brendingoverride) {
    case "victory_screen":
      var_0 = scripts\mp\infilexfil\mp_br_ex_victory_screen::victoryscreenexfil_should_enable();
      break;
    default:
      break;
  }

  if(var_0) {
    switch (level.brendingoverride) {
      case "victory_screen":
        scripts\mp\infilexfil\mp_br_ex_victory_screen::victoryscreenexfil_init();
        break;
      default:
        break;
    }

    return;
  }
}

function gates_combat() {
  if(!getdvarint("scr_br_ending_enabled")) {
    return false;
  }

  if(!ref_11C64(getDvar("scr_br_gametype"))) {
    return false;
  }

  if(istrue(level.deletequestobjicon)) {
    return false;
  }

  return true;
}

function ref_11C64(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "bodycount":
    case "brdov":
    case "truckwar":
    case "zxp":
    case "gxp":
    case "mmp":
    case "respect":
    case "vov":
    case "mendota":
    case "tdbd":
    case "dbd":
    case "brz":
    case "olaride":
    case "rebirth_dbd_reverse":
    case "rebirth_dbd":
    case "rebirth_reverse":
    case "rebirth":
    case "mini":
    case "jugg":
    case "rat_race":
    case "":
      var_1 = 1;
      break;
  }

  return var_1;
}

function should_preload_ending_location() {
  if(_getdeathstatecode::vehicle_damage_loadtable() || getdvarint("scr_br_ending_6_enabled", 0)) {
    return true;
  }

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    return true;
  }

  if(isDefined(level.brendingoverrideinfo)) {
    return istrue(level.brendingoverrideinfo.preloadending);
  }

  return false;
}

function ref_13E00(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(should_preload_ending_location()) {
    var_2 = propminigamefinish(var_0, var_1, 1);

    if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingviewingplayerorigin)) {
      var_3 = level.brendingoverrideinfo.endingviewingplayerorigin;
    } else {
      var_3 = var_3[0].origin;
    }

    foreach(var_5 in level.players) {
      var_5 scripts\mp\gametypes\br_public::ref_126B9(var_3);
    }

    return;
  }
}

function ref_123DE(var_0, var_1) {
  if(!gates_combat()) {
    return;
  }

  level notify("stop_suspense_music");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, &hideleaderhashuntilpercent);
  ref_13FBC(var_0);
  level notify("br_ending_start");
  level.disable_back_light = 1;

  if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.overridewinnersfunc)) {
    var_0 = [[level.brendingoverrideinfo.overridewinnersfunc]](var_0);
  }

  var_2 = randomfloat(1) < getdvarfloat("scr_br_exfil_5_chance");
  var_3 = propmoveunlock();
  var_4 = init_door_ent_flags(var_3, var_0, var_1);

  if(var_2) {
    setomnvarforallclients("ui_br_bink_overlay_state", 0);
    thread onjoinedteamcb(level, 15);
    var_3 = "exfil5";
  }

  var_0 = undefined;
  level.defendkill = var_4;
  var_4.onping = var_3;
  ref_13082(var_4, var_3, var_1);
  nagstilflag(var_4);
  var_5 = name_fx(var_4);
  headicon_image(var_4.origin, 1000);
  hasscrapassist();
  clear_skydivevfx();
  var_4 scripts\common\anim::anim_first_frame_solo(var_4.gameending, var_4.ref_121B8[0].anime);

  foreach(var_7 in level.players) {
    var_7 cameradefault();
    var_7 cameralinkTo(var_4.gameending, "tag_player", 1, 1);
    thread nakeddrophandleloadout(var_7);

    if(isDefined(var_4.ref_142D0)) {
      var_7 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer(var_4.ref_142D0, 0);
    }
  }

  bush_onplayerconnect(var_4, 1);

  if(var_2) {
    var_9 = 5;
    playcinematicforall("ch2_s5_exfil_teaser_polina_bink", 1, 1);
    setomnvarforallclients("ui_br_bink_overlay_state", 10);
    wait var_9;
    ongrenadeused(var_4);
    setomnvarforallclients("ui_br_bink_overlay_state", 0);
  }

  wait 1;
  bush_concealment_monitor(var_4);
}

function bush_onplayerconnect(var_0, var_1) {
  foreach(var_3 in var_0.ref_121B8) {
    if(isDefined(var_3.startfunc)) {
      [[var_3.startfunc]](var_3.ref_121D4);
    }

    if(istrue(var_1) && isDefined(var_3.fx)) {
      if(isDefined(var_3.fxtag)) {
        playFXOnTag(scripts\engine\utility::getfx(var_3.fx), var_3.playerzombiejumpcleanup, var_3.fxtag);
      } else {
        playFX(scripts\engine\utility::getfx(var_3.fx), var_3.playerzombiemonitorinput, anglesToForward(var_3.playerzombiehud), anglestoup(var_3.playerzombiehud));
      }
    }

    if(var_3.players.size > 0) {
      var_3.players = scripts\engine\utility::array_removeundefined(var_3.players);

      foreach(var_5 in var_3.players) {
        var_5 dontinterpolate();

        if(isDefined(var_5.x1fin_playerdisconnect)) {
          if(!isPlayer(var_5)) {
            var_5.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_3.anime, var_5.x1fin_removequestinstance);
          } else {
            var_5.x1fin_playerdisconnect thread scripts\mp\anim::anim_player_solo(var_5, var_5.player_rig, var_3.anime, var_5.x1fin_removequestinstance);
          }

          continue;
        }

        if(!isPlayer(var_5)) {
          var_0 thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_3.anime);
          continue;
        }

        var_0 thread scripts\mp\anim::anim_player_solo(var_5, var_5.player_rig, var_3.anime);
      }

      if(isDefined(var_0.ref_124EA)) {
        foreach(var_8 in var_0.ref_124EA) {
          if(isDefined(var_8.player)) {
            continue;
          }

          if(isDefined(var_8.x1fin_playerdisconnect)) {
            var_8.x1fin_playerdisconnect thread scripts\common\anim::anim_single_solo(var_8, var_3.anime, var_8.x1fin_removequestinstance);
            continue;
          }

          var_0 thread scripts\common\anim::anim_single_solo(var_8, var_3.anime);
        }
      }
    }

    if(var_3.ents.size > 0) {
      foreach(var_11 in var_3.ents) {
        var_11 dontinterpolate();
      }

      var_0 thread scripts\common\anim::anim_single(var_3.ents, var_3.anime);
    }

    var_0.gameending dontinterpolate();
    var_0 scripts\common\anim::anim_single_solo(var_0.gameending, var_3.anime);
    waitframe();
    level.defendkill notify("scene_end");
  }

  level.defendkill notify("all_scenes_end");
}

function bush_concealment_monitor(var_0) {
  foreach(var_2 in var_0.ref_121B8) {
    foreach(var_4 in var_2.ents) {
      if(isDefined(var_4)) {
        if(isDefined(var_4.linkedents)) {
          scripts\engine\utility::array_delete(var_4.linkedents);
        }

        var_4 delete();
      }
    }
  }

  brking_onplayerconnect();

  foreach(var_8 in level.players) {
    if(isDefined(var_8) && isDefined(var_8.player_rig)) {
      if(isDefined(var_8.sessionstate) && var_8.sessionstate == "spectator") {
        var_8 setspectatedefaults(var_0.origin, var_0.angles);
      } else {
        var_8 setOrigin(var_0.origin);
      }

      var_8.player_rig delete();
    }
  }

  if(isDefined(var_0.gameending)) {
    var_0.gameending delete();
    return;
  }
}

function hideleaderhashuntilpercent(var_0, var_1) {
  return var_0.pers["score"] >= var_1.pers["score"];
}

function ref_13AEE() {
  wait 25;

  foreach(var_1 in level.players) {
    var_1 setplayermusicstate("");
  }
}

function nagstilflag(var_0) {
  level.endmatchcameratransitions = 1;
  level notify("brSpawnPlayersEnding");

  foreach(var_2 in level.players) {
    if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingviewingplayersetup)) {
      var_2 thread[[level.brendingoverrideinfo.endingviewingplayersetup]]();
    }

    var_2 predictstreampos(var_0.origin);
    var_2 scripts\mp\utility\player::hidehudenable();
    var_2 setcinematicmotionoverride("disabled");
    var_2 setclientomnvar("ui_br_squad_eliminated_active", 0);

    if(isDefined(var_2.sessionstate)) {
      if(var_2.sessionstate == "dead") {
        var_2 thread scripts\mp\playerlogic::spawnintermission(var_0.gameending);
      }

      if(var_2.sessionstate == "intermission") {
        var_2 scripts\mp\utility\player::updatesessionstate("spectator");
      }

      if(var_2.sessionstate == "spectator") {
        if(getdvarint("scr_br_ending_disable_spectating", 0)) {
          var_2 scripts\mp\gametypes\br_spectate::ref_1252A();
          var_2 scripts\mp\spectating::setdisabled();
        }

        var_2 setspectatedefaults(var_0.gameending.origin, var_0.gameending.angles);
        var_2 spawn(var_0.gameending.origin, var_0.gameending.angles);
        continue;
      }

      if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingviewingplayerorigin)) {
        var_2 setOrigin(level.brendingoverrideinfo.endingviewingplayerorigin);
      } else {
        var_2 setOrigin(var_0.origin + (0, 0, 100));
      }

      if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingviewingplayerangles)) {
        var_2 setplayerangles(level.brendingoverrideinfo.endingviewingplayerangles);
      }
    }
  }
}

function name_fx(var_0) {
  var_1 = var_0.winners;
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(isDefined(var_4.sessionstate) && var_4.sessionstate == "playing") {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = [];
  var_7 = 0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(!isPlayer(var_4)) {
      continue;
    }

    if(isDefined(var_4.sessionstate) && var_4.sessionstate != "playing") {
      var_4.forcespawnorigin = var_2;
      var_4 scripts\mp\playerlogic::spawnplayer(0);
    }

    namehud(var_4);
    var_9 = var_4 scripts\mp\teams::lookupcurrentoperator(var_4.team);
    var_10 = scripts\mp\teams::getoperatorgender(var_9);
    var_4.ref_145CA = var_7;
    var_7++;

    if(!isDefined(var_4.animname) || var_4.animname != var_4.disable_stealth_reinforcement_icon) {
      var_4.animname = var_4.disable_stealth_reinforcement_icon;
    }

    thread ref_124F0();
    create_player_rig(var_4, var_4.animname, "viewhands_base_iw8", var_0);
    thread nag_radius(level);
    var_6 = var_4.player_rig;
  }

  return var_6;
}

function namehud() {
  self playershow(1);
  ref_1248E();
  ref_12467();
  self.plotarmor = 1;
  scripts\mp\outofbounds::enableoobimmunity(self);
  self.x1fin_playerdisconnect = undefined;
  self.x1fin_removequestinstance = undefined;
}

function nearby_ai_combat_via_grenade(var_0) {
  var_1 = var_0.winners;
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(isDefined(var_4.sessionstate) && var_4.sessionstate == "playing") {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = 0;

  foreach(var_8 in var_1) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(!isPlayer(var_8)) {
      continue;
    }

    if(isDefined(var_8.player_rig)) {
      var_8.player_rig delete();
    }

    if(isDefined(var_8.sessionstate) && var_8.sessionstate != "playing") {
      var_8.forcespawnorigin = var_2;
      var_8 scripts\mp\playerlogic::spawnplayer(0);
    }

    namelocations(var_8);
    var_8.ref_145CA = undefined;
    thread ref_124F0();
  }

  brking_onplayerconnect();
}

function namelocations() {
  self playershow(1);
  ref_1248E();
  ref_12468();
  self.plotarmor = 0;
  scripts\mp\outofbounds::disableoobimmunity(self);
  self.x1fin_playerdisconnect = undefined;
  self.x1fin_removequestinstance = undefined;
}

function ref_13FBC(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, &hideleaderhashuntilpercent);
  var_1 = -1;
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_5 = 8 * var_2;
    var_1 &= ~(255 << var_5);
    var_1 |= var_4 getentitynumber() << var_5;
    var_2++;
  }

  setomnvarforallclients("ui_br_winners", var_1);
}

function init_death_animations(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1.uniform_suicide_truck_speed_manager = 1;
  var_1.disable_stealth_reinforcement_icon = "player0";
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  create_player_rig(var_1, var_1.disable_stealth_reinforcement_icon, "viewhands_base_iw8", var_0);
  var_1 linkTo(var_1.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  thread nag_radius(level, var_1);
  var_0.winners[0] = var_1;
}

function ref_1248E() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self.vehicle);
  }

  if(istrue(self.usingascender) && isDefined(self.cansticktoent)) {
    scripts\cp_mp\auto_ascender::canseesafecircleui();
  }

  if(isDefined(self.remoteuav)) {
    self.remoteuav scripts\mp\killstreaks\remoteuav::remoteuav_leave();
  }

  if(isDefined(self.currentturret)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_endplayeruse(self.currentturret);
  }

  if(isDefined(self.usingremote)) {
    var_0 = vehicle_getarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.owner) && var_2.owner == self) {
        if(isDefined(var_2.helperdronetype)) {
          var_2 scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(1);
        }
      }
    }

    return;
  }
}

function ref_12467() {
  if(!isPlayer(self)) {
    return;
  }

  self allowmovement(0);
  self allowjump(0);
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self disableweaponswitch();
  scripts\common\utility::allow_vehicle_use(0);
  self skydive_interrupt();
}

function ref_12468() {
  if(!isPlayer(self)) {
    return;
  }

  self allowmovement(1);
  self allowjump(1);
  self enableoffhandweapons();
  self allowmelee(1);
  self allowads(1);
  self allowfire(1);
  self enableweaponswitch();
}

function nag_radius(var_0, var_1) {
  var_2 = var_0.player_rig;
  var_3 = isPlayer(var_0);

  if(!isDefined(var_1)) {
    var_0 waittill("disconnect");
  } else {
    wait 0.1;
  }

  if(!isDefined(var_2)) {
    return;
  }

  playFXOnTag(scripts\engine\utility::getfx("player_disconnect"), var_2, "tag_player");
}

function ref_124F0() {
  if(istrue(self.isjuggernaut)) {
    return;
  }

  var_0 = undefined;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3.classname != "rifle" && var_3.classname != "spread" && var_3.classname != "mg" && var_3.classname != "sniper") {
      continue;
    }

    var_0 = var_3;

    if(isDefined(var_0)) {
      break;
    }
  }

  if(!nullweapon(self.currentweapon)) {
    self clearaccessory();
    self takeallweapons();
  } else {
    waitframe();
  }

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\class::fixcollision("s4_ar_stango44", "none", "none", 0);
  }

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    var_5 = [];
    var_5[var_5.size] = "s4_ar_stango44";
    var_5[var_5.size] = "iw8_ar_mike4";
    var_5[var_5.size] = "s4_sm_ppapa41";
    var_5[var_5.size] = "s4_mr_svictor40";
    var_0 = scripts\mp\class::fixcollision(var_5[randomint(var_5.size)], "none", "none", 0);
  }

  if(isDefined(level.brendingoverrideinfo) && istrue(level.brendingoverrideinfo.usefactionweapons)) {
    var_6 = 33;

    if(level.brendingoverrideinfo.exfiltypename) == "villains") {
    var_6 = 34;
  }

  var_1 = scripts\mp\class::fixcollision("s4_sm_mpapa40", "none", "none", var_6);
}

scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
self.pers["primaryWeapon"] = createheadicon(var_1);
self.primaryweapon = createheadicon(var_1);
self.primaryweaponobj = var_1;
self.secondaryweapon = undefined;
self.secondaryweaponobj = undefined;

if(self getweaponammoclip(var_1) < 5) {
  self setweaponammoclip(var_1, 5);
}

var_7 = self switchtoweapon(var_1);
}

function propmoveunlock() {
  var_0 = "chopper";

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    var_0 = "chopper_zxp";
  }

  if(getdvarint("scr_br_ending_6_enabled", 0) == 1) {
    var_0 = "jeep";
  }

  var_1 = getdvarint("scr_br_hvv_exfil", 0);

  if(var_1 == 1) {
    scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_init();
  } else if(var_1 == 2) {
    scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_init();
  }

  if(isDefined(level.brendingoverrideinfo)) {
    var_0 = level.brendingoverrideinfo.exfiltypename);
}

return var_0;
}

function ref_13082(var_0, var_1) {
  if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingpackoverridefunc)) {
    self[[level.brendingoverrideinfo.endingpackoverridefunc]](var_1);
    return;
  }

  switch (var_0) {
    case "chopper":
      givewincondition(var_1);
      break;
    case "jeep":
      _getdeathstatecode::vehicle_damage_getpristinestateminhealth(var_1);
      break;
    case "exfil5":
      oninteractionstarted(var_1);
      break;
    case "chopper_zxp":
      chopperzombieexfil_pack(var_1);
      break;
    case "heroes":
      scripts\mp\infilexfil\mp_br_ex_olaride::heroesexfil_pack(var_1);
      break;
    case "villains":
      scripts\mp\infilexfil\mp_br_ex_olaride::villainsexfil_pack(var_1);
      break;
    default:
      givewincondition(var_1);
      break;
  }
}

function init_door_ent_flags(var_0, var_1, var_2) {
  var_3 = propmatchslope(var_1, var_2);
  var_4 = undefined;

  switch (var_0) {
    case "chopper":
      var_4 = init_carepackages(var_3);
      break;
    case "jeep":
      var_4 = init_carepackages(var_3);
      break;
    default:
      var_4 = init_carepackages(var_3);
      break;
  }

  var_3.winners = var_1;
  var_3.gameending = var_4;
  return var_3;
}

function propmatchslope(var_0, var_1) {
  var_2 = propminigamefinish(var_0, var_1, 1);

  if(!isDefined(var_2[0].angles)) {
    var_2[0].angles = (0, 0, 0);
  }

  return var_2[0];
}

function propminigamefinish(var_0, var_1, var_2) {
  if(level.script == "mp_br_mechanics") {
    var_3 = scripts\engine\utility::getStructArray("br_ending_spot", "targetname");
  } else if(level.script == "mp_br_quarry") {
    var_3 = ref_11DC9();
  } else if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    var_3 = ref_11DC7();
  } else if(level.script == "mp_don4") {
    var_3 = ref_11DCD();
  } else if(level.script == "mp_wz_island") {
    var_3 = ref_11DF2();
  } else if(level.script == "mp_sm_island_1") {
    var_3 = ref_11DF3();
  } else {
    var_3 = ref_11DCE();
  }

  if(isDefined(level.brendingoverrideinfo) && isDefined(level.brendingoverrideinfo.endingstructsoverridefunc)) {
    var_3 = [[level.brendingoverrideinfo.endingstructsoverridefunc]](var_3);
  }

  if(istrue(var_3)) {
    return ref_134D2(var_3, var_3, var_3);
  }

  return var_3;
}

function ref_134D2(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::array_removeundefined(var_1);

  if(var_1.size > 0) {
    var_3 = get_center_of_array(var_1);
  } else {
    var_3 = var_3;
  }

  var_1 = sortbydistance(var_1, var_3);
  return var_1;
}

function headicon_image(var_0, var_1) {
  var_2 = tablesort(var_0, var_1, 20000);

  foreach(var_4 in var_2) {
    scripts\cp_mp\vehicles\vehicle::ref_14197(var_4);
  }
}

function hasscrapassist() {
  foreach(var_1 in level.defendkill.winners) {
    if(isDefined(var_1.watch_for_molotov_ambush_and_spawners)) {
      scripts\mp\utility\outline::outlinedisable(var_1.watch_for_molotov_ambush_and_spawners, var_1);
      var_1.watch_for_molotov_ambush_and_spawners = undefined;
    }
  }
}

function clear_skydivevfx() {
  foreach(var_1 in level.defendkill.winners) {
    if(isDefined(var_1)) {
      var_1 setscriptablepartstate("skydiveVfx", "default", 0);
    }
  }
}

function ref_11DCE() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, init_level_drop_structs((-35516, -26964, -290.492), (0, -37.2493, 0), 1));
}

function ref_11DCD() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, init_level_drop_structs((-35516, -26964, -290.492), (0, -37.2493, 0), 1));
}

function ref_11DF2() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, init_level_drop_structs((-20150, -19994, 888), (0, 90, 0)));
}

function ref_11DC9() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, init_level_drop_structs((29786.7, 41132.6, 749.673), (0, -132.937, 0)));
}

function ref_11DC7() {
  var_0 = [];

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    GscBinSkip0(0x2e, 0, init_level_drop_structs((-1161, 9916, 653), (0, 60, 0)));
  }

  GscBinSkip0(0x2e, 0, init_level_drop_structs((-3899, 2190, 693), (0, 159, 0)));
}

function ref_11DF3() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, init_level_drop_structs((-10348, -252, 337), (0, 270, 0)));
}

function init_level_drop_structs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  return var_3;
}

#using_animtree("script_model");

function init_carepackages() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  var_0 useanimtree(#animtree);
  var_0.animname = "endingCam";
  return var_0;
}

function musictriggerthink(var_0) {
  self notify("ending_fade_in");
  self endon("ending_fade_in");
  self endon("disconnect");
  var_1 = var_0 * 20;
  var_2 = 1;
  var_3 = 1 / var_1;
  self setclientomnvar("ui_world_fade", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 -= var_3;
    var_2 = max(var_2, 0);
    self setclientomnvar("ui_world_fade", var_2);
  }
}

function nag_get_in_heli(var_0) {
  self notify("ending_fade_out");
  self endon("ending_fade_out");
  self endon("disconnect");
  var_1 = var_0 * 20;
  var_2 = 0;
  var_3 = 1 / var_1;
  self setclientomnvar("ui_world_fade", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 += var_3;
    var_2 = min(var_2, 1);
    self setclientomnvar("ui_world_fade", var_2);
  }
}

function nakeddrophandleloadout(var_0) {
  self endon("disconnect");
  level.defendkill endon("scene_end");

  for(;;) {
    if(!self isspectatingplayer()) {
      waitframe();
      continue;
    }

    var_1 = self getspectatingplayer();

    if(isDefined(var_1)) {
      var_1 waittill("disconnect");
      self cameradefault();
      self cameralinkTo(var_0, "tag_player", 1, 1);
    }

    waitframe();
  }
}

#using_animtree("");

function create_player_rig(var_0, var_1, var_2, var_3) {
  self.animname = var_0;
  var_4 = var_2.origin;

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_5 = spawn("script_model", var_4);
  var_5.player = self;
  self.player_rig = var_5;
  self.player_rig setModel(var_1);
  self.player_rig hide();
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.ref_145CA = self.ref_145CA;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;

  if(!isDefined(var_2.ref_124EA)) {
    var_2.ref_124EA = [];
  }

  if(isPlayer(self)) {
    self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
    var_2.ref_124EA[var_2.ref_124EA.size] = self.player_rig;
  } else {
    self.player_rig.ref_145CA = 0;
  }

  self notify("rig_created");
}

function remove_player_rig() {
  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(self.player_rig)) {
    self.player_rig delete();
    return;
  }
}

function get_center_of_array(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);
  }

  if(var_0.size != 0) {
    return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
  }

  return undefined;
}

function givewincondition(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = processvoqueue();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_1 = getdvarfloat("scr_br_end_transient_wait", 6);
    wait var_1;
  }

  var_2 = ref_135CA("veh8_mil_air_blima_scriptmodel");
  var_2 hidepart("tag_main_rotor_blade_01");
  var_2 hidepart("tag_main_rotor_blade_02");
  var_2 hidepart("tag_main_rotor_blade_03");
  var_2 hidepart("tag_main_rotor_blade_04");
  var_2 hidepart("tag_tail_rotor_blade_01");
  var_2 hidepart("tag_tail_rotor_blade_02");
  var_2 hidepart("tag_tail_rotor_blade_03");
  var_2 hidepart("tag_tail_rotor_blade_04");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["head_mp_helicopter_crew", "j_spine4"];
  var_4 = [var_3];
  var_5 = "body_pilot_helicopter_british";
  var_6 = ref_135CA(var_5, undefined, var_4);
  self.ref_12D97 = var_6;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0) {
    init_death_animations(self);
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  var_7 = ref_135CA("equipment_fast_rope_wm_01_infil_heli_l");
  self.rope = var_7;
  self.gameending = init_carepackages();
  var_8 = [];
  GscBinSkip0(0x2e, 0, ref_135CA("misc_wm_ascender", "misc_wm_ascender0"));
}

function chopperzombieexfil_pack(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = processvoqueue();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_1 = getdvarfloat("scr_br_end_transient_wait", 6);
    wait var_1;
  }

  self.ref_142D0 = "mp_escape4_exfil_pm_zombie";
  var_2 = ref_135CA("veh8_mil_air_blima_scriptmodel");
  var_2 hidepart("tag_main_rotor_blade_01");
  var_2 hidepart("tag_main_rotor_blade_02");
  var_2 hidepart("tag_main_rotor_blade_03");
  var_2 hidepart("tag_main_rotor_blade_04");
  var_2 hidepart("tag_tail_rotor_blade_01");
  var_2 hidepart("tag_tail_rotor_blade_02");
  var_2 hidepart("tag_tail_rotor_blade_03");
  var_2 hidepart("tag_tail_rotor_blade_04");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["head_mp_helicopter_crew", "j_spine4"];
  var_4 = [var_3];
  var_5 = "body_pilot_helicopter_british";
  var_6 = ref_135CA(var_5, undefined, var_4);
  self.ref_12D97 = var_6;
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0) {
    init_death_animations(self);
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  var_7 = ref_135CA("equipment_fast_rope_wm_01_infil_heli_l");
  self.rope = var_7;
  self.gameending = init_carepackages();
  var_8 = [];
  GscBinSkip0(0x2e, 0, ref_135CA("misc_wm_ascender", "misc_wm_ascender0"));
}

function oninteractionstarted(var_0) {
  thread givestartingarmor(5, var_0);

  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = processvoqueue();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_1 = getdvarfloat("scr_br_end_transient_wait", 6);
    wait var_1;
  }

  var_2 = ref_135CA("veh8_mil_air_blima_scriptmodel");
  var_2 hidepart("tag_main_rotor_blade_01");
  var_2 hidepart("tag_main_rotor_blade_02");
  var_2 hidepart("tag_main_rotor_blade_03");
  var_2 hidepart("tag_main_rotor_blade_04");
  var_2 hidepart("tag_tail_rotor_blade_01");
  var_2 hidepart("tag_tail_rotor_blade_02");
  var_2 hidepart("tag_tail_rotor_blade_03");
  var_2 hidepart("tag_tail_rotor_blade_04");
  self.onkillingblow = var_2;
  givexpwithtext();
  var_3 = ["head_mp_helicopter_crew", "j_spine4"];
  var_4 = [var_3];
  var_5 = "body_pilot_helicopter_british";
  var_6 = ref_135CA(var_5, undefined, var_4);
  self.ref_12D97 = var_6;
  var_7 = ref_135CA("body_mp_rus_s4polina_02");
  self.ref_127E3 = var_7;
  var_8 = ["lm_rus_s4_sandbag_lrg_01_vm", "J_prop_2"];
  var_9 = ["me_fabric_canopy_01", "J_prop_3"];
  var_10 = [var_8, var_9];
  var_11 = ref_135CA("generic_prop_x5", undefined, var_10);
  self.ref_12909 = var_11;
  var_3 = ref_135CA("head_mp_rus_s4polina_01");
  var_7.head = var_3;
  var_12 = ref_135CA("vm_moscar32_01_comp");
  var_7.rifle = var_12;
  var_7.head hide();
  var_7.rifle hide();
  var_7 hide();
  var_11.linkedents[0] hide();
  var_11.linkedents[1] hide();
  var_11 hide();
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0) {
    init_death_animations(self);
  }

  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  var_13 = ref_135CA("equipment_fast_rope_wm_01_infil_heli_l");
  self.rope = var_13;
  self.gameending = init_carepackages();
  var_14 = [];
  GscBinSkip0(0x2e, 0, ref_135CA("misc_wm_ascender", "misc_wm_ascender0"));
}

function onhelmetsniped(var_0) {
  var_0.player scripts\mp\utility\infilexfil::givegunless();
}

function onhotfootplayerkilled(var_0) {
  setslowmotion(1, 0.25, 0.1);
}

function oninstanceremoved(var_0) {
  setslowmotion(0.25, 1, 0.1);
}

function ongulagendmatch(var_0) {
  level.defendkill.gameending notify("single anim", "end");
}

function ongrenadeused(var_0) {
  setomnvarforallclients("ui_world_fade", 1);
  level.defendkill.gameending notify("single anim", "end");
}

function onhack(var_0) {
  brking_ontimelimit(4.8, 130, 4, 8);
}

function processvoqueue() {
  switch (level.script) {
    case "mp_donetsk":
      return "mp_infil_br_donetsk_ending_chopper_tr";
    case "mp_donetsk2":
      return "mp_infil_br_donetsk2_ending_chopper_tr";
    case "mp_don3":
      return "mp_infil_br_don3_ending_chopper_tr";
    case "mp_br_quarry":
      return "mp_infil_br_quarry_ending_chopper_tr";
    case "mp_br_mechanics":
      return "mp_infil_br_mechanics_ending_chopper_tr";
    case "mp_kstenod":
      return "mp_infil_br_kstenod_ending_chopper_tr";
    case "mp_escape2":
      return "mp_infil_br_escape2_ending_chopper_tr";
    case "mp_escape2_pm":
      return "mp_infil_br_escape2_pm_ending_chopper_tr";
    case "mp_escape3":
      return "mp_infil_br_escape3_ending_chopper_tr";
    case "mp_escape4":
      return "mp_infil_br_escape4_ending_chopper_tr";
    case "mp_escape4_s5":
      return "mp_infil_br_escape4_ending_chopper_tr";
    case "mp_don4":
      return "mp_infil_br_don4_ending_chopper_tr";
    case "mp_don4_pm":
      return "mp_infil_br_don4_ending_chopper_tr";
    case "mp_wz_island":
      return "mp_infil_br_don4_ending_chopper_tr";
    case "mp_br_tut2":
      return "mp_infil_br_quarry_ending_chopper_tr";
    case "mp_sm_island_1":
      return "mp_infil_br_don4_ending_chopper_tr";
  }

  return "";
}

function givestartingarmor(var_0, var_1) {
  var_2 = self.origin + (0, 0, 1000);
  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = var_2 + var_3 * 3000;
  var_5 = spawn("script_model", var_4);
  var_5 playSound("br_exfil_incoming_heli_lr");
  var_5 moveTo(var_2, var_0);
  wait var_0;
  var_5 delete();
}

function givesuperpointsonprematchdone() {
  if(level.defendkill.winners.size == 0) {
    return;
  }

  var_0 = "mus_br3_exfil_intro_3player_intro";
  var_1 = "br_exfil_part1_3person_lr";

  if(level.defendkill.onping == "exfil5") {
    var_0 = "mus_br_exfil_intro_3player_pm_intro";
    var_1 = "br_exfil_part1_3person_lr";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "mus_br_exfil_intro_1player_polina_intro";
        var_1 = "br_exfil_part1_1person_polina_lr";
        break;
      case 2:
        var_0 = "mus_br_exfil_intro_2player_polina_intro";
        var_1 = "br_exfil_part1_2person_polina_lr";
        break;
      case 3:
        var_0 = "mus_br_exfil_intro_3player_polina_intro";
        var_1 = "br_exfil_part1_3person_polina_lr";
        break;
      case 4:
        var_0 = "mus_br_exfil_intro_4player_polina_intro";
        var_1 = "br_exfil_part1_4person_polina_lr";
        break;
    }

    soundsettimescalefactor("br_exfil_fx_unres_2d", 0);
    soundsettimescalefactor("br_exfil_lfe_unres_2d", 0);
    soundsettimescalefactor("music_lr", 0);
  } else if(level.defendkill.onping == "chopper_zxp") {
    var_0 = "mus_zxp3_zmb_exfil_3player_intro";
    var_1 = "br_exfil_part1_3person_lr";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "mus_zxp3_zmb_exfil_1player_intro";
        var_1 = "br_exfil_zmb_part1_1person_lr";
        break;
      case 2:
        var_0 = "mus_zxp3_zmb_exfil_2player_intro";
        var_1 = "br_exfil_zmb_part1_2person_lr";
        break;
      case 3:
        var_0 = "mus_zxp3_zmb_exfil_3player_intro";
        var_1 = "br_exfil_zmb_part1_3person_lr";
        break;
      case 4:
        var_0 = "mus_zxp3_zmb_exfil_4player_intro";
        var_1 = "br_exfil_zmb_part1_4person_lr";
        break;
    }
  } else {
    var_0 = "mus_br3_exfil_intro_3player_intro";
    var_1 = "br_exfil_part1_3person_lr";

    switch (level.defendkill.winners.size) {
      case 1:
        var_0 = "mus_br3_exfil_intro_1player_intro";
        var_1 = "br_exfil_part1_1person_lr";
        break;
      case 2:
        var_0 = "mus_br3_exfil_intro_2player_intro";
        var_1 = "br_exfil_part1_2person_lr";
        break;
      case 3:
        var_0 = "mus_br3_exfil_intro_3player_intro";
        var_1 = "br_exfil_part1_3person_lr";
        break;
      case 4:
        var_0 = "mus_br3_exfil_intro_4player_intro";
        var_1 = "br_exfil_part1_4person_lr";
        break;
    }
  }

  foreach(var_3 in level.players) {
    var_3 playlocalsound(var_1);
    var_3 playlocalsound(var_0);
  }

  waitframe();
  setmusicstate("");

  foreach(var_3 in level.players) {
    var_3 setsoundsubmix("mp_br_exfil_fade", 4);
  }
}

function giveteampoints() {
  if(level.defendkill.winners.size == 0) {
    return;
  }

  var_0 = "br_exfil_main_3player_pm";

  switch (level.defendkill.winners.size) {
    case 1:
      var_0 = "br3_exfil_intro_1player";
      break;
    case 2:
      var_0 = "br3_exfil_intro_2player";
      break;
    case 3:
      var_0 = "br3_exfil_intro_3player";
      break;
    case 4:
      var_0 = "br3_exfil_intro_4player";
      break;
  }

  setmusicstate(var_0);
}

function glgrenade(var_0) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  if(isDefined(level.defendkill.onping) && level.defendkill.onping != "exfil5") {
    foreach(var_2 in level.players) {
      var_2 playlocalsound("br_exfil_end_part_lr");
    }

    return;
  }
}

function glgrenadeparent(var_0) {
  thread givequestrewardref();
  thread givesuperpointsonprematchdone();

  if(!scripts\mp\gametypes\br_public::turret_headicon()) {
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  if(isDefined(level.defense_wave_send_support)) {
    level.defendkill.ref_12D97 show();

    foreach(var_2 in level.players) {
      var_2.player_rig unlink();
    }
  }

  brking_ontimelimit(2.8, 200);
}

function glint(var_0) {
  brking_ontimelimit(2.8, 250);
  thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_2 in level.defendkill.canspawnontacinsert) {
      var_2 show();
    }
  }

  foreach(var_5 in var_0) {
    if(isDefined(var_5)) {
      var_5 scripts\mp\utility\player::ref_1328C("60", 1);
    }
  }
}

function glintfx(var_0) {
  brking_ontimelimit(2.8, 250);

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    var_1 = 1;
    allplayers_setforcefov(80, var_1);
  }

  if(!isDefined(level.defense_wave_send_support)) {
    if(level.defendkill.winners.size < 4) {
      if(isDefined(level.defendkill.rope)) {
        level.defendkill.rope delete();
      }
    }
  }

  thread givequestrewardref();
  jumpiffalse(isDefined(level.defense_wave_send_support)) LOC_000000b8;

  foreach(var_3 in level.defendkill.canspawnontacinsert) {
    var_3 hide();
  }

  goto LOC_000000ea;
}

function onjoinspectators(var_0) {
  brking_ontimelimit(4.8, 92, 100, 100);
  brking_onplayerkilled(13);
  level.defendkill.ref_127E3 show();
  level.defendkill.ref_127E3 hidepart("j_helmet");
  level.defendkill.ref_127E3 hidepart("j_head");
  level.defendkill.ref_127E3.head show();
  level.defendkill.ref_127E3.rifle show();
  level.defendkill.ref_12909 show();
  level.defendkill.ref_12909.linkedents[0] show();

  if(!isDefined(level.defense_wave_send_support)) {
    if(level.defendkill.winners.size < 4) {
      if(isDefined(level.defendkill.rope)) {
        level.defendkill.rope delete();
      }
    }
  }

  jumpiffalse(isDefined(level.defense_wave_send_support)) LOC_00000118;

  foreach(var_2 in level.defendkill.canspawnontacinsert) {
    var_2 hide();
  }

  return;
}

function global_relic_amped_func(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclienttriggeraudiozone("br_exfil_heli_int", 0.05);
  }

  setomnvarforallclients("ui_br_end_game_splash_type", 13);
  brking_onplayerkilled(45);
  brking_ontimelimit(10, 18);
  thread givequestrewardref();

  if(level.defendkill.winners.size == 1) {
    thread glgrenade(1.266);
    return;
  }
}

function global_relic_landlocked_func(var_0) {
  setomnvarforallclients("ui_br_end_game_splash_type", 14);
  brking_onplayerkilled(50);
  brking_ontimelimit(11, 30);
  thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_2 in var_0) {
      var_2 hide();
    }
  } else {
    large_transport_initomnvars(var_0);
  }

  if(level.defendkill.winners.size == 2) {
    thread glgrenade(2.033);
    return;
  }
}

function global_relic_squadlink_func(var_0) {
  setomnvarforallclients("ui_br_end_game_splash_type", 15);
  brking_onplayerkilled(50);
  brking_ontimelimit(8, 14.5);
  thread givequestrewardref();

  if(level.defendkill.winners.size == 3) {
    thread glgrenade(2);
    return;
  }
}

function global_relic_team_prox_func(var_0) {
  setomnvarforallclients("ui_br_end_game_splash_type", 16);
  brking_onplayerkilled(55);
  brking_ontimelimit(3, 29);
  thread givequestrewardref();

  if(level.defendkill.winners.size == 4) {
    thread glgrenade(2.5);
    return;
  }
}

function global_stealth_broken_func(var_0) {
  foreach(var_2 in level.players) {
    var_2 clearclienttriggeraudiozone(0.1);
  }

  brking_onplayerkilled(65);
  brking_ontimelimit(2.8, 500);
  thread givequestrewardref();
}

function global_variables(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 scripts\mp\utility\player::ref_1328C("30", 1);
    }
  }
}

function globalrelicsfunc(var_0) {
  if(level.defendkill.winners.size == 1) {
    ref_138B4();
    return;
  }
}

function globalstruct(var_0) {
  if(level.defendkill.winners.size == 2) {
    ref_138B4();
    return;
  }
}

function go_investigate_loc(var_0) {
  if(level.defendkill.winners.size == 3) {
    ref_138B4();
    return;
  }
}

function go_patrol_the_maze(var_0) {
  if(!isDefined(level.defense_wave_send_support)) {
    setomnvarforallclients("ui_world_fade", 1);
    return;
  }
}

function ref_138B4() {
  level.defendkill.gameending notify("single anim", "end");
}

function givexpwithtext() {
  if(!isDefined(level.br_circle)) {
    return;
  }

  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }

  level.br_circle.dangercircleent brcirclemoveTo(self.origin[0], self.origin[1], 9000, 0.05);
}

function large_transport_initomnvars(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.linkedents)) {
      scripts\engine\utility::array_delete(var_2.linkedents);
    }

    var_2 delete();
  }
}

function givequestrewardref() {
  self endon("death");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("chopperExfil_rotorwash"), self, "tag_origin");
}

function chopper_zombie_playFX() {
  self endon("death");
  wait 0.1;
  playFX(scripts\engine\utility::getfx("chopperExfil_gas"), self.origin);
}

function go_to_combat() {
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");

  if(getdvarint("scr_br_zxp_exfil", 0) == 1) {
    level._effect["chopperExfil_rotorwash"] = loadfx("vfx/iw8_br/gameplay/vfx_esc4_zmb_blima_rotor_infil.vfx");
    level._effect["chopperExfil_gas"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_esc4_zmb_circle_gas_exfil_01.vfx");
    level._effect["vfx_tracer_front_straight"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_exfil_tracer_front_straight");
    return;
  }

  level._effect["chopperExfil_rotorwash"] = loadfx("vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx");
  level._effect["chopperExfil_gas"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_exfil_01.vfx");
}

function onjoinedteamcb(var_0, var_1) {
  wait var_0;
  preloadcinematicforall(var_1, 1, 0);
}

function chopperexfilzombie_sh005_start(var_0) {
  thread givequestrewardref();
  thread chopper_zombie_playFX();
  thread givesuperpointsonprematchdone();
  setomnvarforallclients("ui_br_end_game_splash_type", 17);

  if(isDefined(level.defense_wave_send_support)) {
    level.defendkill.ref_12D97 show();

    foreach(var_2 in level.players) {
      var_2.player_rig unlink();
    }
  }

  brking_ontimelimit(2.8, 200);
}

function chopperexfilzombie_sh010_start(var_0) {
  brking_ontimelimit(2.8, 150);
  allplayers_setforcefov(49);
  var_0 show();
  thread givequestrewardref();
}

function chopperexfilzombie_sh020_start(var_0) {
  var_1 = var_0["winners"];
  var_2 = var_0["gunner"];
  var_3 = var_0["zombiesToHide"];
  var_2 hide();

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  brking_ontimelimit(2.8, 250);
  allplayers_setforcefov(80);
  thread givequestrewardref();

  if(isDefined(level.defense_wave_send_support)) {
    foreach(var_8 in level.defendkill.canspawnontacinsert) {
      var_8 show();
    }
  }

  foreach(var_11 in var_1) {
    if(isDefined(var_11)) {
      var_11 scripts\mp\utility\player::ref_1328C("60", 1);
    }
  }
}

function shoot_gun_from_notetrack(var_0) {
  if(isDefined(self.player) && self.player tagexists("tag_flash")) {
    var_1 = self.player gettagorigin("tag_flash");
    var_2 = var_1 + anglesToForward(self.player gettagangles("tag_flash")) * 100;
    magicbullet(self.player.primaryweaponobj.basename, var_1, var_2);
    playFXOnTag(level._effect["vfx_tracer_front_straight"], self.player, "tag_flash");
    return;
  }
}

function shoot_gun_pistol_from_notetrack(var_0) {
  if(isDefined(self.player) && self.player tagexists("tag_flash")) {
    var_1 = self.player gettagorigin("tag_flash");
    var_2 = var_1 + anglesToForward(self.player gettagangles("tag_flash")) * 100;
    magicbullet("iw8_pi_papa320_mp", var_1, var_2);
    playFXOnTag(level._effect["vfx_tracer_front_straight"], self.player, "tag_flash");
    return;
  }
}

function shoot_sfx_from_notetrack(var_0) {
  var_1 = self gettagorigin("tag_origin");
  var_2 = var_1 + anglesToForward(self gettagangles("tag_origin")) * 100;
  magicbullet("iw8_ar_mike4_mp", var_1, var_2);
}

function brking_ontimelimit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 100;
  }

  if(!isDefined(var_3)) {
    var_3 = 100;
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6.ref_12F8A)) {
      var_6.ref_12F8A = 1;
      var_6 enablephysicaldepthoffieldscripting();
    }

    if(isDefined(var_4)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_3)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_2)) {
      var_6 setphysicaldepthoffield(var_0, var_1, var_2);
      continue;
    }

    var_6 setphysicaldepthoffield(var_0, var_1);
  }
}

function brking_onplayerkilled(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclientdvar("cg_fov", var_0);
  }
}

function allplayers_setforcefov(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_3 setclientdvar("cg_fov", var_0);
    var_3 setclientdvar("LTMOQONPQ", 1);

    if(istrue(var_1)) {
      thread resetfov();
    }
  }
}

function resetfov() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(level.defendkill, "all_scenes_end", level.defendkill, "scene_end");
  self setclientdvar("cg_fov", 65);
  self setclientdvar("LTMOQONPQ", 0);
}

function brking_onplayerconnect() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.ref_12F8A)) {
      var_1.ref_12F8A = undefined;
      var_1 disablephysicaldepthoffieldscripting();
    }
  }
}

function ref_12F84() {}

function init_bomb_objective(var_0) {
  var_1 = spawnStruct();
  var_1.ents = [];
  var_1.players = [];
  var_1.gameending = undefined;
  var_1.anime = var_0;
  var_1.ref_121B8 = [];
  return var_1;
}

function back_struct(var_0, var_1) {
  level.scr_anim[var_0.animname][self.anime] = var_1;
  level.scr_animname[var_0.animname][self.anime] = getanimname(var_1);
  self.ents[self.ents.size] = var_0;
}

function backendevent(var_0, var_1) {
  self.startfunc = var_1;
  self.ref_121D4 = var_0;
}

function back_vector(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  var_4 = undefined;

  if(!isDefined(var_0.disable_stealth_reinforcement_icon)) {
    var_4 = "player" + var_0 getentitynumber();
    var_0.animname = var_4;
    var_0.disable_stealth_reinforcement_icon = var_4;
  } else {
    var_4 = var_0.disable_stealth_reinforcement_icon;
  }

  self.players[self.players.size] = var_0;
  var_5 = var_1;

  if(isDefined(var_2)) {
    if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "female") {
      var_5 = var_2;
    }
  }

  if(isDefined(var_3)) {
    if(isDefined(var_0.isjuggernaut)) {
      var_5 = var_3;
    }
  }

  level.scr_anim[var_4][self.anime] = var_5;
  level.scr_eventanim[var_4][self.anime] = getanimname(var_5);
}

function awardstadiumblueprint(var_0) {
  self.gameending = 1;
  level.scr_anim["endingCam"][self.anime] = var_0;
}

function back_field_clip(var_0, var_1, var_2) {
  self.fx = var_0;
  self.playerzombiemonitorinput = var_1;
  self.playerzombiehud = var_2;
}

function ref_135CA(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel(var_0);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_3.animname = var_1;
  var_3 useanimtree(#animtree);

  if(isDefined(var_2)) {
    var_3.linkedents = [];

    foreach(var_5 in var_2) {
      var_6 = spawn("script_model", self.origin);
      var_6 setModel(var_5[0]);
      var_6 linkTo(var_3, var_5[1], (0, 0, 0), (0, 0, 0));
      var_3.linkedents[var_3.linkedents.size] = var_6;
    }
  }

  return var_3;
}

function back_door_enemy_watcher(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", self.origin);
  var_5 setModel(var_0);
  var_5 useanimtree(#animtree);

  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = var_1;
  }

  var_6.animname = var_6;
  level.scr_anim[var_6.animname]["br_ending"] = var_3;

  if(isDefined(var_4)) {
    level.scr_animname[var_6.animname]["br_ending"] = var_4;
  }

  if(isDefined(var_2)) {
    var_6.linkedents = [];

    foreach(var_8 in var_2) {
      var_9 = spawn("script_model", self.origin);
      var_9 setModel(var_8[0]);
      var_9 linkTo(var_6, var_8[1], (0, 0, 0), (0, 0, 0));
      var_6.linkedents[var_6.linkedents.size] = var_9;
    }
  }

  self.pack.models[self.pack.models.size] = var_6;
  return var_6;
}