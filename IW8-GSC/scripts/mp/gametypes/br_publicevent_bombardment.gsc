/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_bombardment.gsc
***************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.ref_140cf = &ref_140cf;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.postinitfunc = &postinitfunc;
  var_0.weight = getdvarfloat("scr_br_pe_bombardment_weight", 1);
  scripts\mp\gametypes\br_publicevents::ref_12b35(5, var_0);
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
  var_0 = getdvarfloat("scr_bombardment_radius", 3000);

  if(isDefined(level.delay_turn_laser_trap_back_on)) {
    var_1 = [[level.delay_turn_laser_trap_back_on]]();
  } else {
    var_1 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle(0.2, 0.8);
  }

  var_2 = getdvarfloat("scr_bombardment_duration", 70);
  thread crates_delete_early(level, var_1, var_1);

  if(getdvarint("scr_br_pe_bombardment_cluster", 1)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("lep_bomb_shelter", undefined, undefined, 1);
    thread ref_1383a(level, var_1, var_1);
    return;
  }

  var_3 = ["ebr_alert_missile_10", "ebr_alert_missile_20", "ebr_alert_missile_30"];
  scripts\mp\gametypes\br_public::brleaderdialog(var_3[randomintrange(0, 3)], 1, level.players);
  _hidesafecircleui::changetimertoovertimetimer(var_1, undefined, var_2, var_1);
}

function ref_1383a(var_0, var_1, var_2) {
  self notify("br_pe_bombardment");
  self endon("br_pe_bombardment");
  self endon("game_ended");
  var_3 = 2 * level.framedurationseconds;
  var_4 = 5;
  var_5 = getdvarint("scr_br_pe_bombardment_strike_radius", 100);
  var_6 = getdvarint("scr_br_pe_bombardment_strike_notify_radius", 100);
  var_7 = gettime() + var_2 * 1000;

  while(gettime() < var_7) {
    level.create_digit_models = [];

    for(var_8 = 0; var_8 < var_4; var_8++) {
      var_9 = scripts\mp\gametypes\br_gametype_lep::do_spawn_vo_callout(var_0, var_1);

      if(!isDefined(var_9)) {
        break;
      }

      level thread scripts\mp\gametypes\br_gametype_lep::dropbrprimaryweapons(var_9, var_5, var_6);

      if(getdvarint("scr_br_pe_bombardment_stun", 0)) {
        level thread _hidesafecircleui::chase(10, var_9);
      }

      wait var_3;
    }

    wait 20;
  }
}

function crates_delete_early(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  wait var_2;
  var_3 delete();
}

function helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }

  var_0 = getdvarint("scr_br_pe_bombardment_dmg_max", 150);
  var_1 = getdvarint("scr_br_pe_bombardment_dmg_min", 25);
  radiusdamage(self.origin, 256, var_0, var_1, self, "MOD_EXPLOSIVE", "toma_proj_mp");
}