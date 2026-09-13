/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_cc652497df12a7.gsc
***********************************************/

main() {
  setup_callbacks();
  _id_A84AC36891EFF2CB();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::_id_F065EE35EB264BA6;
}

_id_A84AC36891EFF2CB() {}

_id_F065EE35EB264BA6() {
  self notify("bot_ko_think");
  self endon("bot_ko_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.next_flag_hide_time = 0;
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    _id_9F2085184CD247A7 = level._id_D63F297A45DD1F87 scripts\mp\gameobjects::getownerteam();

    if(_id_9F2085184CD247A7 == "none" || _id_9F2085184CD247A7 == "neutral") {
      clear_defend();
      self botsetscriptgoal(level._id_D63F297A45DD1F87.curorigin, 16, "critical");
    } else if(_id_9F2085184CD247A7 == self.team) {
      if(level._id_D63F297A45DD1F87.currentcarrier == self) {
        if(gettime() > self.next_flag_hide_time) {
          clear_defend();
          nodes = getnodesinradius(self.origin, 900, 0, 300);
          _id_7E939D9754FB78DE = self botnodepick(nodes, nodes.size * 0.15, "node_hide_anywhere");

          if(isDefined(_id_7E939D9754FB78DE)) {
            success = self botsetscriptgoalnode(_id_7E939D9754FB78DE, "critical");

            if(success)
              self.next_flag_hide_time = gettime() + 15000;
          }
        }
      } else if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
        clear_defend();
        self botclearscriptgoal();
        scripts\mp\bots\bots_strategy::bot_guard_player(level._id_D63F297A45DD1F87.currentcarrier, 500);
      }
    } else {
      clear_defend();
      self botsetscriptgoal(level._id_D63F297A45DD1F87.currentcarrier.origin, 16, "critical");
    }

    wait 0.05;
  }
}

clear_defend() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();
}