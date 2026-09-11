/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_bombardment.gsc
***************************************************************/

function init() {
  var0 = spawnStruct();
  var0.ref_140cf = &ref_140cf;
  var0.attackerswaittime = &attackerswaittime;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.weight = getdvarfloat("scr_br_pe_bombardment_weight", 1);
    scripts\mp\gametypes\br_publicevents::ref_12b35(5, var0);
  }

  function postinitfunc() {
    if(getdvarint("scr_br_pe_bombardment_cluster", 1)) {
      game["dialog"]["lep_bomb_shelter"] = "lep_bomb_shelter";
      return;
    }

    game["dialog"]["ebr_alert_missile_10"] = "ebr_alert_missile_10";
    game["dialog"]["ebr_alert_missile_20"] = "ebr_alert_missile_20";
    game["dialog"]["ebr_alert_missile_30"] = "ebr_alert_missile_30";
    _hidesafecircleui::stopusingbomb();
  }

  function ref_140cf() {
    return false;
  }

  function attackerswaittime() {
    scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_bombardment_start");
    var0 = getdvarfloat("scr_bombardment_radius", 3000);

    if(isDefined(level.delay_turn_laser_trap_back_on)) {
      var1 = [[level.delay_turn_laser_trap_back_on]]();
    } else {
      var1 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle(0.2, 0.8);
    }

    var2 = getdvarfloat("scr_bombardment_duration", 70);
    thread crates_delete_early(level, var1, var1);

    if(getdvarint("scr_br_pe_bombardment_cluster", 1)) {
      level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_bomb_shelter", undefined, undefined, 1);
      thread ref_1383a(level, var1, var1);
      return;
    }

    var3 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
    scripts\mp\gametypes\br_public::brleaderdialog(var3[randomintrange(0, 3)], 1, level.players);
    _hidesafecircleui::changetimertoovertimetimer(var1, undefined, var2, var1);
  }

  function ref_1383a(var0, var1, var2) {
    self notify("br_pe_bombardment");
    self endon("br_pe_bombardment");
    self endon("game_ended");
    var3 = 2 * level.framedurationseconds;
    var4 = 5;
    var5 = getdvarint("scr_br_pe_bombardment_strike_radius", 100);
    var6 = getdvarint("scr_br_pe_bombardment_strike_notify_radius", 100);
    var7 = gettime() + var2 * 1000;

    while(gettime() < var7) {
      level.create_digit_models = [];

      for(var8 = 0; var8 < var4; var8++) {
        var9 = scripts\mp\gametypes\br_gametype_lep::do_spawn_vo_callout(var0, var1);

        if(!isDefined(var9)) {
          break;
        }

        level thread scripts\mp\gametypes\br_gametype_lep::dropbrprimaryweapons(var9, var5, var6);

        if(getdvarint("scr_br_pe_bombardment_stun", 0)) {
          level thread _hidesafecircleui::chase(10, var9);
        }

        wait var3;
      }

      wait 20;
    }
  }

  function crates_delete_early(var0, var1, var2) {
    level endon("game_ended");
    var3 = getmaxobjectivecount(var0[0], var0[1], var1);
    wait var2;
    var3 delete();
  }

  function helidrivabledeathall() {
    if(!isDefined(self)) {
      return;
    }

    var0 = getdvarint("scr_br_pe_bombardment_dmg_max", 150);
    var1 = getdvarint("scr_br_pe_bombardment_dmg_min", 25);
    radiusdamage(self.origin, 256, var0, var1, self, "MOD_EXPLOSIVE", "toma_proj_mp");
  }