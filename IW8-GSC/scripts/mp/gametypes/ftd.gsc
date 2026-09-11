/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ftd.gsc
***********************************************/

function init() {
  level._effect["vfx_br3_teleport_smoke"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_teleport_smoke");
  var0 = getdvarint("scr_ftv_enable", 0);

  if(var0) {
    teammarkedfor();
    var1 = 1;
    thread ref_13245(var1);
    return;
  }

  move_platform(1);
}

function teammarkedfor() {
  scripts\engine\scriptable::ref_12f5b("part_door", &petrograd_interaction_think);
  throwing_knife_cp_trytopickup();
  level.petobjectivefilter = [];
}

function ref_13245(var0) {
  level endon("game_ended");
  var1 = getentitylessscriptablearrayinradius("scriptable_br_fast_travel_door", "classname");
  var2 = getentitylessscriptablearrayinradius("scriptable_br_fast_travel_light", "classname");
  var3 = scripts\engine\utility::getStructArray("scriptable_br_fast_travel_arrival", "script_noteworthy");
  var4 = getEntArray("ftv_trigger", "script_noteworthy");
  var5 = 0;

  foreach(var7 in var1) {
    var8 = var7.script_noteworthy;

    if(isDefined(var8)) {
      var9 = [];

      foreach(var11 in var2) {
        if(var11.script_noteworthy == var8) {
          var9 = scripts\engine\utility::array_add(var9, var11);
        }
      }

      foreach(var14 in var3) {
        if(var14.targetname == var8) {
          foreach(var16 in var4) {
            if(var16.targetname == var8) {
              throwingknife_fire_begin_fx(var7, var9, var14, var16);
              var5++;
              break;
            }
          }
        }
      }
    }
  }

  if(var5 != var1.size) {}

  if(var5 > 0) {
    if(var0) {
      level waittill("prematch_done");
    }

    thread ref_12126();
    thread atv_initcollision();

    foreach(var7 in level.petobjectivefilter) {
      attackerinitammo(var7);
    }

    return;
  }
}

function throwingknife_fire_begin_fx(var0, var1, var2, var3) {
  var0.usable = 1;
  var0.ref_13aeb = randomint(4);
  var0.†•nËÂ9c» sðˆ Ô[Ks = var1; var0.destination = var2; var0.ph = var3; var0.ph.ref_121d7 = var0; scripts\mp\utility\trigger::makeenterexittrigger(var0.ph, &petrograd_interaction_delayed, undefined); level.petobjectivefilter[level.petobjectivefilter.size] = var0;
  }

  function petrograd_interaction_think(var0, var1, var2, var3, var4) {
    if(var1 == "part_door" && isdoorscriptableclosed(var2)) {
      if(istrue(var0.usable) && !istrue(var0.cankeepusingbomb)) {
        thread ref_12125(var0);
        return;
      }

      return;
    }
  }

  function closedoorscriptable() {
    var0 = "closed_" + self.script_noteworthy;
    self setscriptablepartstate("part_door", var0);
  }

  function isdoorscriptableclosed(var0) {
    if(var0 == "inactive" || var0 == "open" || var0 == "disabled") {
      return 0;
    }

    return 1;
  }

  function attackerinitammo(var0) {
    closedoorscriptable(var0);
    ref_13145(var0, "inactive");
    var0.cankeepusingbomb = 0;
    thread ref_11d04();
  }

  function ref_12125(var0) {
    var1 = self;
    var2 = var0.origin - var1.origin;

    if(vectordot(var2, anglesToForward(var1.angles)) <= 0) {
      return;
    }

    if(istrue(var1.cankeepusingbomb)) {
      return;
    }

    level endon("game_ended");
    var1 endon("ftd_close");
    var1.ref_1269a = [];
    var1 setscriptablepartstate("part_door", "open");
    var1 notify("ftd_open");
    thread ref_13c4e();
    thread petrograd_lead_model();
  }

  function petrograd_interaction_delayed(var0, var1) {
    var2 = var1.ref_121d7;

    if(var0 isinexecutionvictim() || var0 isinexecutionattack()) {
      return;
    }

    thread ref_1386a(var0, registerdonetsksubmap(var0, var2, 0), var2);
  }

  function getspectators() {
    var0 = [];

    foreach(var2 in level.players) {
      if(var2 isspectatingplayer()) {
        if(self == var2 getspectatingplayer()) {
          var0 = scripts\engine\utility::array_add(var0, var2);
        }
      }
    }

    return var0;
  }

  function ref_1386a(var0, var1, var2) {
    var3 = self;
    level endon("game_ended");
    var3 endon("death");
    var3 endon("disconnect");
    thread ref_126d0(var3);
    var4 = getspectators();

    foreach(var6 in var4) {
      ref_12853(var6, var2);
      ref_1277c(var6, var2);
    }

    ref_12853(var3, var2);
    ref_1277c(var3, var2);
    var3 setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 0.5);
    wait 0.1;
    battle_tracks_updateexternallisteningzone(var1, var3);
    var3 setOrigin(var0);
    var8 = var1.angles;
    var9 = (0, (var8[1] + 180) % 360, 0);
    var3 setplayerangles(var9);
    wait 4;
    var3.ref_12a49 = 1;
  }

  function ref_13c4e() {
    var0 = self;
    level endon("game_ended");
    var0 endon("ftd_close");
    var0.ref_13b81 = gettime();
    var0.ref_13b7c = undefined;

    for(;;) {
      if(isDefined(var0.ref_13b7c) && (gettime() - var0.ref_13b7c) / 1000 >= getdvarint("scr_br_ftd_InactiveTime", 10)) {
        thread heli_land_logic(var0);
        return;
      }

      if((gettime() - var0.ref_13b81) / 1000 >= getdvarint("scr_br_ftd_MaxOpenTime", 20)) {
        thread heli_land_logic(var0);
        return;
      }

      wait 1;
    }
  }

  function petrograd_lead_model() {
    var0 = self;
    level endon("game_ended");
    var0 endon("end_ftd_queue");
    jumpiftrue(isDefined(var0.petrograd_interactions_init)) LOC_00000026;
    var0.petrograd_interactions_init = [];

    for(;;) {
      waitframe();

      if(!isDefined(var0.petrograd_interactions_init) || var0.petrograd_interactions_init.size <= 0) {
        var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
        continue;
      }

      var0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
      var1 = var0.petrograd_interactions_init[0];

      if(!isDefined(var1) || !isalive(var1)) {
        var0.petrograd_interactions_init = ref_12c1a(var0, var1);
        var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
        var1 notify("ftdqueue_travel_completed");
        continue;
      }

      thread play_vo_or_timeout(var1, var0);
      var1 scripts\engine\utility::ref_143a5("player_done_warping", "death");
      var0.petrograd_interactions_init = ref_12c1a(var0, var1);
      var0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var1 notify("ftdqueue_travel_completed");
    }
  }

  function battle_tracks_updateexternallisteningzone(var0) {
    var1 = self;

    if(!isDefined(var0) || !isPlayer(var0)) {
      return;
    }

    if(!isDefined(var1.petrograd_interactions_init)) {
      var1.petrograd_interactions_init = [];
    }

    if(scripts\engine\utility::array_contains(var1.petrograd_interactions_init, var0)) {
      return;
    }

    var1.ref_13b7c = gettime();
    var1.petrograd_interactions_init[var1.petrograd_interactions_init.size] = var0;
  }

  function ref_12c1a(var0) {
    var1 = self;
    var2 = scripts\engine\utility::array_remove(var1.petrograd_interactions_init, var0);
    return var2;
  }

  function ref_12853(var0) {
    var1 = self;
    var1 skydive_cutparachuteon(var0);
    var1 setclientomnvar("ui_br_bink_overlay_state", 10);
  }

  function ref_1277c(var0) {
    var1 = self;
    var1 preloadcinematicforplayer(var0);
  }

  function ref_138f8() {
    var0 = self;
    var0 setclientomnvar("ui_br_bink_overlay_state", 5);
    wait 0.5;
    var0 setclientomnvar("ui_br_bink_overlay_state", 0);
    var0 skydive_cutparachuteoff();
  }

  function ref_126d0(var0) {
    var1 = self;
    level endon("game_ended");
    var1 playerhide();
    var1 freezecontrols(1);
    var1 vehiclepinonminimap(1);
    var1.validateboltent = 1;

    if(isDefined(var0)) {
      var0.ref_1269a[var1.guid] = var1;
    }

    var2 = 8.5;
    var3 = scripts\engine\utility::ref_143bd(var2, "player_done_warping", "prematch_end", "ftdqueue_travel_completed", "death", "disconnect");

    if(isDefined(var0)) {
      if(var3 == "disconnect") {
        var0.ref_1269a = scripts\engine\utility::array_removeundefined(var0.ref_1269a);
        return;
      } else {
        var0.ref_1269a = scripts\engine\utility::array_remove(var0.ref_1269a, var1);
      }
    }

    var1 vehiclepinonminimap(0);
    var1 freezecontrols(0);
    var1 playershow();
    var1.validateboltent = undefined;
    var1 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    thread atv_outline();
  }

  function atv_outline() {
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    var0 = spawn("script_model", self.origin);
    var0.ref_129c7 = gettime();
    var0.team = self.team;
    var0 makeportableradar(self);
    level.disable_super_in_turret.ref_129c6[var0 getentitynumber()] = var0;
    wait 3;
    var0 delete();
  }

  function play_vo_or_timeout(var0, var1) {
    var2 = self;
    level endon("game_ended");
    var2 endon("death");
    var2 endon("disconnect");

    while(!istrue(var2.ref_12a49)) {
      waitframe();
    }

    var2.ref_12a49 = 0;
    var3 = 7.5;
    var2 scripts\mp\gametypes\br_public::ref_126b9(var1, var3);
    var2 waittill("playerPrestreamComplete");
    wait 0.45;
    var1 += (0, 0, 20);
    var2 setOrigin(var1);
    playFX(scripts\engine\utility::getfx("vfx_br3_teleport_smoke"), var2.origin);
    var2 playsoundtoplayer("sfx_underground_room_arrive", var2);
    var4 = var0.angles;
    var5 = (0, (var4[1] + 180) % 360, 0);
    var2 setplayerangles(var5);
    waitframe();
    var2 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
    ref_138f8(var2);
    var6 = getspectators();

    foreach(var8 in var6) {
      ref_138f8(var8);
    }

    var2 notify("player_done_warping");
  }

  function registerdonetsksubmap(var0, var1) {
    var2 = self;
    var3 = var0.destination.origin;

    if(var1) {
      var4 = var0.ref_13aeb;
      var0.ref_13aeb = (var0.ref_13aeb + 1) % 4;
      var5 = getdvarint("scr_br_ftd_ArrivalRadius", 50);

      for(var6 = 0; var6 < level.petplundertimer.size; var6++) {
        var7 = (var4 + var6) % 4;
        var8 = var3 + level.petplundertimer[var7] * var5;

        if(capsuletracepassed(var8, 16, 32, var2)) {
          return var8;
        }

        var9 = 10;

        for(var10 = 0; var10 < var9; var10++) {
          var11 = anglesToForward((0, 360 * var10 / var9, 0)) * 3 * 16;
          var12 = var8 + var11;

          if(capsuletracepassed(var12, 16, 32, var2)) {
            return var12;
          }
        }
      }
    }

    return var3;
  }

  function heli_land_logic(var0) {
    var1 = self;
    level endon("game_ended");
    var1 endon("ftd_open");
    var2 = var1 getscriptablepartstate("part_door");

    if(var2 != "inactive") {
      if(istrue(var0)) {
        var1 setscriptablepartstate("part_door", "disabled");
      } else {
        closedoorscriptable(var1);
      }
    }

    if(isDefined(var1.ref_1269a)) {
      var1.usable = 0;

      while(var1.ref_1269a.size != 0) {
        wait 0.1;
      }

      var1.usable = 1;
    }

    var1 notify("ftd_close");
    thread ref_13385();
  }

  function ref_13385() {
    var0 = self;

    if(!isDefined(var0.petrograd_interactions_init)) {
      return;
    }

    level endon("game_ended");
    wait 1;

    while(istrue(var0.tv_station_fastrope_one_infil_rider_start_targetname)) {
      waitframe();
    }

    var0 notify("end_ftd_queue");
    var0.petrograd_interactions_init = undefined;
  }

  function ispointoutsidedisplayedsafecircle(var0) {
    var1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var2 = float(scripts\mp\gametypes\br_circle::getsafecircleradius());

    if(!isDefined(var1) || !isDefined(var2) || var2 <= 0) {
      return false;
    }

    var3 = distance2dsquared(var0, var1);

    if(var3 >= var2 * var2) {
      return true;
    }

    return false;
  }

  function unblockclasschange() {
    var0 = self;
    var1 = getdvarint("scr_br_ftd_TimeUntilArrivalInDanger", 75);
    var2 = 0;

    if(scripts\mp\gametypes\br_circle::getdangercircleradius() > 0) {
      var2 = scripts\mp\gametypes\br_circle::updateprestreamrespawn(var0.origin) == 0;

      if(scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(var0.origin) < var1) {
        var2 = 1;
      }
    }

    return var2;
  }

  function throwing_knife_cp_trytopickup() {
    level.petplundertimer = [];
    var0 = (1, 0, 0);
    var1 = 90;

    for(var2 = 0; var2 < 4; var2++) {
      var0 = rotatevector(var0, (0, var1, 0));
      level.petplundertimer[level.petplundertimer.size] = var0;
    }
  }

  function ref_11d04() {
    level endon("game_ended");
    var0 = self;
    var1 = var0.destination;

    for(;;) {
      var2 = getdvarint("scr_br_ftd_ArrivalDangerRadius", 500);
      var3 = getdvarint("scr_br_ftd_ExplosiveDangerRadiusSquared", 250000);

      if(!istrue(var0.cankeepusingbomb) && unblockclasschange(var1) == 1) {
        var0.cankeepusingbomb = 1;
        thread heli_land_logic(var0);
        ref_13145(var0, "inactive");
      } else if(istrue(var0.cankeepusingbomb) && unblockclasschange(var1) == 0) {
        var0.cankeepusingbomb = 0;
        closedoorscriptable(var0);
      }

      if(!istrue(var0.cankeepusingbomb)) {
        var4 = getdvarint("scr_br_ftd_ArrivalDangerDistance", 220);
        var5 = var1.origin;
        var6 = 0;

        foreach(var8 in level.mines) {
          if(isDefined(var8) && distancesquared(var5, var8.origin) <= var3) {
            var6 = 1;
            break;
          }
        }

        if(var6 == 0) {
          var10 = scripts\mp\utility\player::getplayersinradius(var5, var2);

          foreach(var12 in var10) {
            if(abs(var12.origin[2] - var5[2]) < 200) {
              var6 = 1;
              break;
            }
          }
        }

        if(var6 || ispointinsidecitykiller(var1.origin)) {
          var14 = "negative";
        } else if(ispointoutsidedisplayedsafecircle(var2.origin)) {
          var14 = "warning";
        } else {
          var14 = "positive";
        }

        ref_13145(var2, var14);
      }

      wait 1;
    }
  }

  function ispointinsidecitykiller(var0) {
    if(isDefined(level.gulagloadoutindex) && isDefined(level.gulagloadoutindex.instances)) {
      foreach(var2 in level.gulagloadoutindex.instances) {
        if(_getlocationscircleinfluencedwithnoise::citykiller_ispointindamagezone(var0, var2)) {
          return true;
        }
      }
    }

    return false;
  }

  function ref_13145(var0) {
    var1 = self;

    if(isDefined(var1) && isDefined(var1.†•nËÂ9c» sðˆ Ô[Ks)) {
        foreach(var3 in var1.†•nËÂ9c» sðˆ Ô[Ks) {
            var3 setscriptablepartstate("part_light", var0);
          }

          return;
        }
      }

      function ref_12126() {
        wait 1;
        var0 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_hatch", "classname");

        foreach(var2 in var0) {
          var2 setscriptablepartstate("hatch", "open");
        }

        var4 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_door", "classname");

        foreach(var6 in var4) {
          var6 setscriptablepartstate("door", "open");
        }
      }

      function atv_initcollision() {
        wait 1;
        var0 = getentitylessscriptablearrayinradius("scriptable_scriptable_ftv_objective", "classname");

        foreach(var2 in var0) {
          var2 setscriptablepartstate("objective", "open");
        }
      }

      function move_platform(var0) {
        var1 = getEntArray("ftv_killbox", "script_noteworthy");

        foreach(var3 in var1) {
          if(var0) {
            thread ref_11cff(var3);
            continue;
          }

          var3 notify("remove_kill_trigger");
        }
      }

      function ref_11cff(var0) {
        level endon("game_ended");
        var0 endon("remove_kill_trigger");

        for(;;) {
          var0 waittill("trigger", var1);

          if(isPlayer(var1)) {
            var1 dodamage(10000, var1.origin, var0, var0, "MOD_TRIGGER_HURT");
          }
        }
      }

      function left_side_spawn_adjuster(var0) {
        if(var0 == "spawn") {
          lengthmod();
          return;
        }
      }

      function lengthmod() {
        if(leaveforplayer()) {
          var0 = level.players[0];
          var1 = spawnStruct();
          var1.angles = var0.angles;
          var1.origin = var0.origin + anglesToForward(var0.angles) * 100;
          level.petwatchtype[level.petwatchtype.size] = var1;

          if(level.petwatchtype.size % 2 == 0) {
            var2 = easepower("br_fast_travel_door", var1.origin, var1.angles);
            var3 = lethal_boxes(var2);
            var4 = lengthdelta(level.petwatchtype[level.petwatchtype.size - 2]);
            var5 = [var3];
            throwingknife_fire_begin_fx(var2, var5, var4);
            attackerinitammo(var2);
            return;
          }

          var2 = easepower("br_fast_travel_door", var2.origin, var2.angles);
          return;
        }
      }

      function lethal_boxes(var0) {
        var1 = (10, 0, 150);
        var2 = rotatevector(var1, var0.angles);
        var3 = easepower("br_fast_travel_light", var0.origin + var2, (-90, var0.angles[1], 0));
        return var3;
      }

      function lengthdelta(var0) {
        var1 = anglesToForward((0, (var0.angles[1] + 180) % 360, 0));
        var2 = spawn("script_origin", var0.origin + 100 * var1);
        return var2;
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