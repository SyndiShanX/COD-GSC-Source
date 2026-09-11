/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ftd.gsc
***********************************************/

function init() {
  level._effect["vfx_br3_teleport_smoke"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_teleport_smoke");
  var_0 = getdvarint("scr_ftv_enable", 0);

  if(var_0) {
    teammarkedfor();
    var_1 = 1;
    thread ref_13245(var_1);
    return;
  }

  move_platform(1);
}

function teammarkedfor() {
  scripts\engine\scriptable::ref_12f5b("part_door", &petrograd_interaction_think);
  throwing_knife_cp_trytopickup();
  level.petobjectivefilter = [];
}

function ref_13245(var_0) {
  level endon("game_ended");
  var_1 = getentitylessscriptablearrayinradius("scriptable_br_fast_travel_door", "classname");
  var_2 = getentitylessscriptablearrayinradius("scriptable_br_fast_travel_light", "classname");
  var_3 = scripts\engine\utility::getStructArray("scriptable_br_fast_travel_arrival", "script_noteworthy");
  var_4 = getEntArray("ftv_trigger", "script_noteworthy");
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_8 = var_7.script_noteworthy;

    if(isDefined(var_8)) {
      var_9 = [];

      foreach(var_11 in var_2) {
        if(var_11.script_noteworthy == var_8) {
          var_9 = scripts\engine\utility::array_add(var_9, var_11);
        }
      }

      foreach(var_14 in var_3) {
        if(var_14.targetname == var_8) {
          foreach(var_16 in var_4) {
            if(var_16.targetname == var_8) {
              throwingknife_fire_begin_fx(var_7, var_9, var_14, var_16);
              var_5++;
              break;
            }
          }
        }
      }
    }
  }

  if(var_5 != var_1.size) {}

  if(var_5 > 0) {
    if(var_0) {
      level waittill("prematch_done");
    }

    thread ref_12126();
    thread atv_initcollision();

    foreach(var_7 in level.petobjectivefilter) {
      attackerinitammo(var_7);
    }

    return;
  }
}

function throwingknife_fire_begin_fx(var_0, var_1, var_2, var_3) {
  var_0.usable = 1;
  var_0.ref_13aeb = randomint(4);
  var_0.†•nËÂ9c» sðˆ Ô[Ks = var_1; var_0.destination = var_2; var_0.ph = var_3; var_0.ph.ref_121d7 = var_0; scripts\mp\utility\trigger::makeenterexittrigger(var_0.ph, &petrograd_interaction_delayed, undefined); level.petobjectivefilter[level.petobjectivefilter.size] = var_0;
  }

  function petrograd_interaction_think(var_0, var_1, var_2, var_3, var_4) {
    if(var_1 == "part_door" && isdoorscriptableclosed(var_2)) {
      if(istrue(var_0.usable) && !istrue(var_0.cankeepusingbomb)) {
        thread ref_12125(var_0);
        return;
      }

      return;
    }
  }

  function closedoorscriptable() {
    var_0 = "closed_" + self.script_noteworthy;
    self setscriptablepartstate("part_door", var_0);
  }

  function isdoorscriptableclosed(var_0) {
    if(var_0 == "inactive" || var_0 == "open" || var_0 == "disabled") {
      return 0;
    }

    return 1;
  }

  function attackerinitammo(var_0) {
    closedoorscriptable(var_0);
    ref_13145(var_0, "inactive");
    var_0.cankeepusingbomb = 0;
    thread ref_11d04();
  }

  function ref_12125(var_0) {
    var_1 = self;
    var_2 = var_0.origin - var_1.origin;

    if(vectordot(var_2, anglesToForward(var_1.angles)) <= 0) {
      return;
    }

    if(istrue(var_1.cankeepusingbomb)) {
      return;
    }

    level endon("game_ended");
    var_1 endon("ftd_close");
    var_1.ref_1269a = [];
    var_1 setscriptablepartstate("part_door", "open");
    var_1 notify("ftd_open");
    thread ref_13c4e();
    thread petrograd_lead_model();
  }

  function petrograd_interaction_delayed(var_0, var_1) {
    var_2 = var_1.ref_121d7;

    if(var_0 isinexecutionvictim() || var_0 isinexecutionattack()) {
      return;
    }

    thread ref_1386a(var_0, registerdonetsksubmap(var_0, var_2, 0), var_2);
  }

  function getspectators() {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(var_2 isspectatingplayer()) {
        if(self == var_2 getspectatingplayer()) {
          var_0 = scripts\engine\utility::array_add(var_0, var_2);
        }
      }
    }

    return var_0;
  }

  function ref_1386a(var_0, var_1, var_2) {
    var_3 = self;
    level endon("game_ended");
    var_3 endon("death");
    var_3 endon("disconnect");
    thread ref_126d0(var_3);
    var_4 = getspectators();

    foreach(var_6 in var_4) {
      ref_12853(var_6, var_2);
      ref_1277c(var_6, var_2);
    }

    ref_12853(var_3, var_2);
    ref_1277c(var_3, var_2);
    var_3 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
    wait 0.1;
    battle_tracks_updateexternallisteningzone(var_1, var_3);
    var_3 setOrigin(var_0);
    var_8 = var_1.angles;
    var_9 = (0, (var_8[1] + 180) % 360, 0);
    var_3 setplayerangles(var_9);
    wait 4;
    var_3.ref_12a49 = 1;
  }

  function ref_13c4e() {
    var_0 = self;
    level endon("game_ended");
    var_0 endon("ftd_close");
    var_0.ref_13b81 = gettime();
    var_0.ref_13b7c = undefined;

    for(;;) {
      if(isDefined(var_0.ref_13b7c) && (gettime() - var_0.ref_13b7c) / 1000 >= getdvarint("scr_br_ftd_InactiveTime", 10)) {
        thread heli_land_logic(var_0);
        return;
      }

      if((gettime() - var_0.ref_13b81) / 1000 >= getdvarint("scr_br_ftd_MaxOpenTime", 20)) {
        thread heli_land_logic(var_0);
        return;
      }

      wait 1;
    }
  }

  function petrograd_lead_model() {
    var_0 = self;
    level endon("game_ended");
    var_0 endon("end_ftd_queue");
    jumpiftrue(isDefined(var_0.petrograd_interactions_init)) LOC_00000026;
    var_0.petrograd_interactions_init = [];

    for(;;) {
      waitframe();

      if(!isDefined(var_0.petrograd_interactions_init) || var_0.petrograd_interactions_init.size <= 0) {
        var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
        continue;
      }

      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
      var_1 = var_0.petrograd_interactions_init[0];

      if(!isDefined(var_1) || !isalive(var_1)) {
        var_0.petrograd_interactions_init = ref_12c1a(var_0, var_1);
        var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
        var_1 notify("ftdqueue_travel_completed");
        continue;
      }

      thread play_vo_or_timeout(var_1, var_0);
      var_1 scripts\engine\utility::ref_143a5("player_done_warping", "death");
      var_0.petrograd_interactions_init = ref_12c1a(var_0, var_1);
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var_1 notify("ftdqueue_travel_completed");
    }
  }

  function battle_tracks_updateexternallisteningzone(var_0) {
    var_1 = self;

    if(!isDefined(var_0) || !isPlayer(var_0)) {
      return;
    }

    if(!isDefined(var_1.petrograd_interactions_init)) {
      var_1.petrograd_interactions_init = [];
    }

    if(scripts\engine\utility::array_contains(var_1.petrograd_interactions_init, var_0)) {
      return;
    }

    var_1.ref_13b7c = gettime();
    var_1.petrograd_interactions_init[var_1.petrograd_interactions_init.size] = var_0;
  }

  function ref_12c1a(var_0) {
    var_1 = self;
    var_2 = scripts\engine\utility::array_remove(var_1.petrograd_interactions_init, var_0);
    return var_2;
  }

  function ref_12853(var_0) {
    var_1 = self;
    var_1 skydive_cutparachuteon(var_0);
    var_1 setclientomnvar("ui_br_bink_overlay_state", 10);
  }

  function ref_1277c(var_0) {
    var_1 = self;
    var_1 preloadcinematicforplayer(var_0);
  }

  function ref_138f8() {
    var_0 = self;
    var_0 setclientomnvar("ui_br_bink_overlay_state", 5);
    wait 0.5;
    var_0 setclientomnvar("ui_br_bink_overlay_state", 0);
    var_0 skydive_cutparachuteoff();
  }

  function ref_126d0(var_0) {
    var_1 = self;
    level endon("game_ended");
    var_1 playerhide();
    var_1 freezecontrols(1);
    var_1 vehiclepinonminimap(1);
    var_1.validateboltent = 1;

    if(isDefined(var_0)) {
      var_0.ref_1269a[var_1.guid] = var_1;
    }

    var_2 = 8.5;
    var_3 = scripts\engine\utility::ref_143bd(var_2, "player_done_warping", "prematch_end", "ftdqueue_travel_completed", "death", "disconnect");

    if(isDefined(var_0)) {
      if(var_3 == "disconnect") {
        var_0.ref_1269a = scripts\engine\utility::array_removeundefined(var_0.ref_1269a);
        return;
      } else {
        var_0.ref_1269a = scripts\engine\utility::array_remove(var_0.ref_1269a, var_1);
      }
    }

    var_1 vehiclepinonminimap(0);
    var_1 freezecontrols(0);
    var_1 playershow();
    var_1.validateboltent = undefined;
    var_1 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    thread atv_outline();
  }

  function atv_outline() {
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    var_0 = spawn("script_model", self.origin);
    var_0.ref_129c7 = gettime();
    var_0.team = self.team;
    var_0 makeportableradar(self);
    level.disable_super_in_turret.ref_129c6[var_0 getentitynumber()] = var_0;
    wait 3;
    var_0 delete();
  }

  function play_vo_or_timeout(var_0, var_1) {
    var_2 = self;
    level endon("game_ended");
    var_2 endon("death");
    var_2 endon("disconnect");

    while(!istrue(var_2.ref_12a49)) {
      waitframe();
    }

    var_2.ref_12a49 = 0;
    var_3 = 7.5;
    var_2 scripts\mp\gametypes\br_public::ref_126b9(var_1, var_3);
    var_2 waittill("playerPrestreamComplete");
    wait 0.45;
    var_1 += (0, 0, 20);
    var_2 setOrigin(var_1);
    playFX(scripts\engine\utility::getfx("vfx_br3_teleport_smoke"), var_2.origin);
    var_2 playsoundtoplayer("sfx_underground_room_arrive", var_2);
    var_4 = var_0.angles;
    var_5 = (0, (var_4[1] + 180) % 360, 0);
    var_2 setplayerangles(var_5);
    waitframe();
    var_2 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    ref_138f8(var_2);
    var_6 = getspectators();

    foreach(var_8 in var_6) {
      ref_138f8(var_8);
    }

    var_2 notify("player_done_warping");
  }

  function registerdonetsksubmap(var_0, var_1) {
    var_2 = self;
    var_3 = var_0.destination.origin;

    if(var_1) {
      var_4 = var_0.ref_13aeb;
      var_0.ref_13aeb = (var_0.ref_13aeb + 1) % 4;
      var_5 = getdvarint("scr_br_ftd_ArrivalRadius", 50);

      for(var_6 = 0; var_6 < level.petplundertimer.size; var_6++) {
        var_7 = (var_4 + var_6) % 4;
        var_8 = var_3 + level.petplundertimer[var_7] * var_5;

        if(capsuletracepassed(var_8, 16, 32, var_2)) {
          return var_8;
        }

        var_9 = 10;

        for(var_10 = 0; var_10 < var_9; var_10++) {
          var_11 = anglesToForward((0, 360 * var_10 / var_9, 0)) * 3 * 16;
          var_12 = var_8 + var_11;

          if(capsuletracepassed(var_12, 16, 32, var_2)) {
            return var_12;
          }
        }
      }
    }

    return var_3;
  }

  function heli_land_logic(var_0) {
    var_1 = self;
    level endon("game_ended");
    var_1 endon("ftd_open");
    var_2 = var_1 getscriptablepartstate("part_door");

    if(var_2 != "inactive") {
      if(istrue(var_0)) {
        var_1 setscriptablepartstate("part_door", "disabled");
      } else {
        closedoorscriptable(var_1);
      }
    }

    if(isDefined(var_1.ref_1269a)) {
      var_1.usable = 0;

      while(var_1.ref_1269a.size != 0) {
        wait 0.1;
      }

      var_1.usable = 1;
    }

    var_1 notify("ftd_close");
    thread ref_13385();
  }

  function ref_13385() {
    var_0 = self;

    if(!isDefined(var_0.petrograd_interactions_init)) {
      return;
    }

    level endon("game_ended");
    wait 1;

    while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname)) {
      waitframe();
    }

    var_0 notify("end_ftd_queue");
    var_0.petrograd_interactions_init = undefined;
  }

  function ispointoutsidedisplayedsafecircle(var_0) {
    var_1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_2 = float(scripts\mp\gametypes\br_circle::getsafecircleradius());

    if(!isDefined(var_1) || !isDefined(var_2) || var_2 <= 0) {
      return false;
    }

    var_3 = distance2dsquared(var_0, var_1);

    if(var_3 >= var_2 * var_2) {
      return true;
    }

    return false;
  }

  function unblockclasschange() {
    var_0 = self;
    var_1 = getdvarint("scr_br_ftd_TimeUntilArrivalInDanger", 75);
    var_2 = 0;

    if(scripts\mp\gametypes\br_circle::getdangercircleradius() > 0) {
      var_2 = scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_0.origin) == 0;

      if(scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var_0.origin) < var_1) {
        var_2 = 1;
      }
    }

    return var_2;
  }

  function throwing_knife_cp_trytopickup() {
    level.petplundertimer = [];
    var_0 = (1, 0, 0);
    var_1 = 90;

    for(var_2 = 0; var_2 < 4; var_2++) {
      var_0 = rotatevector(var_0, (0, var_1, 0));
      level.petplundertimer[level.petplundertimer.size] = var_0;
    }
  }

  function ref_11d04() {
    level endon("game_ended");
    var_0 = self;
    var_1 = var_0.destination;

    for(;;) {
      var_2 = getdvarint("scr_br_ftd_ArrivalDangerRadius", 500);
      var_3 = getdvarint("scr_br_ftd_ExplosiveDangerRadiusSquared", 250000);

      if(!istrue(var_0.cankeepusingbomb) && unblockclasschange(var_1) == 1) {
        var_0.cankeepusingbomb = 1;
        thread heli_land_logic(var_0);
        ref_13145(var_0, "inactive");
      } else if(istrue(var_0.cankeepusingbomb) && unblockclasschange(var_1) == 0) {
        var_0.cankeepusingbomb = 0;
        closedoorscriptable(var_0);
      }

      if(!istrue(var_0.cankeepusingbomb)) {
        var_4 = getdvarint("scr_br_ftd_ArrivalDangerDistance", 220);
        var_5 = var_1.origin;
        var_6 = 0;

        foreach(var_8 in level.mines) {
          if(isDefined(var_8) && distancesquared(var_5, var_8.origin) <= var_3) {
            var_6 = 1;
            break;
          }
        }

        if(var_6 == 0) {
          var_10 = scripts\mp\utility\player::getplayersinradius(var_5, var_2);

          foreach(var_12 in var_10) {
            if(abs(var_12.origin[2] - var_5[2]) < 200) {
              var_6 = 1;
              break;
            }
          }
        }

        if(var_6 || ispointinsidecitykiller(var_1.origin)) {
          var_14 = "negative";
        } else if(ispointoutsidedisplayedsafecircle(var_2.origin)) {
          var_14 = "warning";
        } else {
          var_14 = "positive";
        }

        ref_13145(var_2, var_14);
      }

      wait 1;
    }
  }

  function ispointinsidecitykiller(var_0) {
    if(isDefined(level.gulagloadoutindex) && isDefined(level.gulagloadoutindex.instances)) {
      foreach(var_2 in level.gulagloadoutindex.instances) {
        if(_getlocationscircleinfluencedwithnoise::citykiller_ispointindamagezone(var_0, var_2)) {
          return true;
        }
      }
    }

    return false;
  }

  function ref_13145(var_0) {
    var_1 = self;

    if(isDefined(var_1) && isDefined(var_1.†•nËÂ9c» sðˆ Ô[Ks)) {
        foreach(var_3 in var_1.†•nËÂ9c» sðˆ Ô[Ks) {
            var_3 setscriptablepartstate("part_light", var_0);
          }

          return;
        }
      }

      function ref_12126() {
        wait 1;
        var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_hatch", "classname");

        foreach(var_2 in var_0) {
          var_2 setscriptablepartstate("hatch", "open");
        }

        var_4 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_door", "classname");

        foreach(var_6 in var_4) {
          var_6 setscriptablepartstate("door", "open");
        }
      }

      function atv_initcollision() {
        wait 1;
        var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_objective", "classname");

        foreach(var_2 in var_0) {
          var_2 setscriptablepartstate("objective", "open");
        }
      }

      function move_platform(var_0) {
        var_1 = getEntArray("ftv_killbox", "script_noteworthy");

        foreach(var_3 in var_1) {
          if(var_0) {
            thread ref_11cff(var_3);
            continue;
          }

          var_3 notify("remove_kill_trigger");
        }
      }

      function ref_11cff(var_0) {
        level endon("game_ended");
        var_0 endon("remove_kill_trigger");

        for(;;) {
          var_0 waittill("trigger", var_1);

          if(isPlayer(var_1)) {
            var_1 dodamage(10000, var_1.origin, var_0, var_0, "MOD_TRIGGER_HURT");
          }
        }
      }

      function left_side_spawn_adjuster(var_0) {
        if(var_0 == "spawn") {
          lengthmod();
          return;
        }
      }

      function lengthmod() {
        if(leaveforplayer()) {
          var_0 = level.players[0];
          var_1 = spawnStruct();
          var_1.angles = var_0.angles;
          var_1.origin = var_0.origin + anglesToForward(var_0.angles) * 100;
          level.petwatchtype[level.petwatchtype.size] = var_1;

          if(level.petwatchtype.size % 2 == 0) {
            var_2 = easepower("br_fast_travel_door", var_1.origin, var_1.angles);
            var_3 = lethal_boxes(var_2);
            var_4 = lengthdelta(level.petwatchtype[level.petwatchtype.size - 2]);
            var_5 = [var_3];
            throwingknife_fire_begin_fx(var_2, var_5, var_4);
            attackerinitammo(var_2);
            return;
          }

          var_2 = easepower("br_fast_travel_door", var_2.origin, var_2.angles);
          return;
        }
      }

      function lethal_boxes(var_0) {
        var_1 = (10, 0, 150);
        var_2 = rotatevector(var_1, var_0.angles);
        var_3 = easepower("br_fast_travel_light", var_0.origin + var_2, (-90, var_0.angles[1], 0));
        return var_3;
      }

      function lengthdelta(var_0) {
        var_1 = anglesToForward((0, (var_0.angles[1] + 180) % 360, 0));
        var_2 = spawn("script_origin", var_0.origin + 100 * var_1);
        return var_2;
      }

      function leaveforplayer() {
        if(isDefined(level.petwatchtype) == 0) {
          level.petwatchtype = [];
        }

        if(isDefined(level.petobjectivefilter) == 0) {
          teammarkedfor();
          return true;
        }

        if(level.petobjectivefilter.size < 16) {
          return true;
        }

        return false;
      }