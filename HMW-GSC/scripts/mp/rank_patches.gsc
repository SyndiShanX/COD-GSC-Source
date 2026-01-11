main() {
  // we remove iprintlns
  replacefunc(maps\mp\gametypes\_rank::updaterankannouncehud, ::updaterankannouncehud_stub);
}

updaterankannouncehud_stub() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  var_0 = self.pers["team"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!maps\mp\_utility::levelflag("game_over")) {
    level common_scripts\utility::waittill_notify_or_timeout("game_over", 0.25);
  }

  var_1 = self.pers["rank"];
  var_2 = self.pers["prestige"];

  if((var_1 + 1) % 50 == 0) {
    var_3 = var_1 + 1;
    maps\mp\gametypes\_missions::processchallenge("ch_" + var_3 + "_paragon");
  }

  thread maps\mp\gametypes\_hud_message::rankupsplashnotify("ranked_up", var_1, var_2);

  if(var_1 <= level.maxrank) {
    var_4 = level.ranktable[var_1][1];
    var_5 = int(var_4[var_4.size - 1]);

    if(var_5 > 1) {
      return;
    }
  }
}