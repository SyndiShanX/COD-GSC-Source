/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2676.gsc
*************************************************/

_id_E2FF(var_0) {
  level endon("game_ended");
  wait 1;
  var_1 = scripts\engine\utility::getstructarray("hvt", "targetname");
  var_2 = undefined;
  var_3 = undefined;
  level._id_15BB = 1;

  while(!isDefined(var_2)) {
    var_2 = _id_0015::_id_3B84("player", "allies");

    if(isDefined(var_2)) {
      foreach(var_5 in var_1) {
        if(var_5._id_CD99 == var_0) {
          var_3 = var_5.origin;
        }
      }

      var_2 thread[[var_2 _id_09EF::_id_1215("spawn")]](var_3, (0, 0, 0));
      var_2.team = "axis";
      var_2 scripts\mp\bots\bots_util::_id_28C4("veteran");
      var_2._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(var_2, var_2.team, "outline_nodepth_cyan", "lowest");
      continue;
    }

    waitframe();
  }

  var_2._id_F3FE = var_2 _id_07D6::_id_4069(var_2, (0, 0, 0));
  var_2._id_F3FE._id_A90C = 0;
  var_2._id_F3FE._id_A90B = 1;
  var_2._id_F3FE._id_A912 = 4.0;
  var_2._id_F3FE._id_1041A = "friendly";
  var_2._id_852E = 1;
  var_2._id_F3FE _id_07D6::_id_D61B("waypoint_blitz_defend");
  var_2 thread _id_7C1B(var_3);
  var_2 thread _id_7C1D();

  if(!isDefined(level._id_7C1C)) {
    level._id_7C1C = 0;
  }

  level._id_7C1C++;
  var_2 scripts\mp\equipment::_id_391D();
  level._id_F2AD = var_2;
}

_id_7C1B(var_0) {
  self _meth_8058(var_0, 20, "critical");
  var_1 = scripts\mp\bots\bots_util::_id_291C();
}

_id_7C28(var_0) {
  var_0._id_8D90 = scripts\mp\utility\outline::_id_ACD2(var_0, scripts\mp\utility\game::_id_6BE2(var_0.team)[0], "outline_depth_orange", "lowest");
  var_0._id_F3FE._id_1041A = "any";
  var_0._id_F3FE _id_07D6::_id_D61B("waypoint_blitz_defend", "waypoint_capture_kill");
  var_0 thread _id_7C1E();
}

_id_7C1E() {
  self endon("game_ended");
  wait 1.0;
  self._id_852E = 0;
}

_id_7C1A(var_0) {
  if(isDefined(var_0._id_8D90)) {
    scripts\mp\utility\outline::outlinedisable(var_0._id_8D90, var_0);
  }

  if(isDefined(var_0._id_ACE5)) {
    scripts\mp\utility\outline::outlinedisable(var_0._id_ACE5, var_0);
  }

  var_0 notify("hvt_timeout");
  var_0._id_A546 = 1;
  var_0 suicide();
}

_id_7C1D() {
  self endon("game_ended");
  self endon("hvt_timeout");
  self waittill("death");
  level._id_7C20++;
  self._id_F3FE _id_07D6::_id_C300();

  if(level._id_7C20 == 1) {
    game["attackers"] = "allies";
    game["defenders"] = "axis";

    if(isDefined(level._id_AB4C)) {
      [[level._id_AB4C]]("allies");
    }

    setomnvar("ui_hardpoint_timer", 0);
    setomnvar("ui_hardpoint", -1);
  }
}

_id_7C2D() {
  self endon("death");
  self endon("game_ended");
  var_0 = 0;

  for(;;) {
    var_1 = self _meth_815E();
    self _meth_8059(var_1, "critical");
    wait 0.25;
  }
}