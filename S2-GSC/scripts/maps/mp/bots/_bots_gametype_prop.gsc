/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_prop.gsc
********************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::bot_prop_think;
  level.bot_funcs["know_enemies_on_start"] = undefined;
}

bot_prop_think() {
  self notify("bot_prop_think");
  self endon("bot_prop_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_0 = 0;

  for(;;) {
    waitframe();

    if(self.health <= 0) {
      continue;
    }
    if(self botgetpersonality() != "run_and_gun") {
      maps\mp\bots\_bots_util::_id_1AD5("run_and_gun");
    }

    if(bot_is_on_prop_team()) {
      if(self botgetscriptgoaltype() != "tactical") {
        var_1 = array_randomly_reduce_to_size(_getallnodes(), 512);
        var_2 = self botnodepick(var_1, var_1.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var_2)) {
          var_2 = self getnearestnode();
        }

        var_3 = self botsetscriptgoalnode(var_2, "tactical");

        if(var_3) {
          var_4 = common_scripts\utility::_id_A712(["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"]);

          if(var_4 == "goal") {
            self botsetflag("disable_movement", 1);
            self botsetflag("disable_rotation", 1);
          } else
            self botclearscriptgoal();
        }
      }

      continue;
    }

    if(!common_scripts\utility::_id_562E(self.phfrozen)) {
      if(!self _meth_86C2() && gettime() - var_0 > 10000) {
        var_5 = self._id_0088;

        if(!isDefined(var_5)) {
          foreach(var_7 in level.players) {
            if(!_isalliedsentient(self, var_7)) {
              var_5 = var_7;
            }
          }
        }

        if(isDefined(var_5) && !self botcanseeentity(var_5)) {
          var_9 = common_scripts\utility::random(_getallnodes());
          self botgetimperfectenemyinfo(var_5, var_9.origin);
          var_0 = gettime();
        } else
          self[[level._id_1A8F["default"]]]();
      }
    }
  }
}

bot_is_on_prop_team() {
  return self.team == game["defenders"];
}

array_randomly_reduce_to_size(var_0, var_1) {
  while(var_0.size > var_1) {
    var_2 = randomint(var_0.size);
    var_0[var_2] = var_0[var_0.size - 1];
    var_0[var_0.size - 1] = undefined;
  }

  return var_0;
}