/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\friendicons.gsc
***********************************************/

init() {
  level.drawfriend = 0;
  game["_encstr_8D7610B8C73647CB6230756690E815877D38"] = scripts\mp\utility\teams::getteamheadicon("_encstr_9A8507BA4040188D08");
  game["_encstr_964F0E34AC0B32B4367BDCD7851E969B"] = scripts\mp\utility\teams::getteamheadicon("_encstr_8E8405EA382B2A");
  precacheshader("_encstr_817B102358A352F768084C6F1EB1CB5C15C0");
  level thread onplayerconnect();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);

  for(;;) {
    updatefriendiconsettings();
    wait 5;
  }
}

onplayerconnect() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread onplayerkilled();
  }
}

onplayerspawned() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  thread showfriendicon();
}

onplayerkilled() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8EB40E4C23415AC52951730BC8E2BDC3");
    self.headicon = "_encstr_B40101";
  }
}

showfriendicon() {
  if(level.drawfriend) {
    if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
      self.headicon = game["_encstr_8D7610B8C73647CB6230756690E815877D38"];
      self.headiconteam = "_encstr_9A8507BA4040188D08";
    } else {
      self.headicon = game["_encstr_964F0E34AC0B32B4367BDCD7851E969B"];
      self.headiconteam = "_encstr_8E8405EA382B2A";
    }
  }
}

updatefriendiconsettings() {
  var_0 = scripts\mp\utility\dvars::getintproperty("_encstr_95870F3FBB4A29FD03D253798B0725F867", level.drawfriend);

  if(level.drawfriend != var_0) {
    level.drawfriend = var_0;
    updatefriendicons();
  }
}

updatefriendicons() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.pers["_encstr_8AEF05472BC2D6"]) && var_2.pers["_encstr_8AEF05472BC2D6"] != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_2.sessionstate == "_encstr_877508C1D8C22F2DDC3B") {
      if(level.drawfriend) {
        if(var_2.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
          var_2.headicon = game["_encstr_8D7610B8C73647CB6230756690E815877D38"];
          var_2.headiconteam = "_encstr_9A8507BA4040188D08";
        } else {
          var_2.headicon = game["_encstr_964F0E34AC0B32B4367BDCD7851E969B"];
          var_2.headiconteam = "_encstr_8E8405EA382B2A";
        }

        continue;
      }

      var_0 = level.players;

      for(var_1 = 0; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1];

        if(isDefined(var_2.pers["_encstr_8AEF05472BC2D6"]) && var_2.pers["_encstr_8AEF05472BC2D6"] != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_2.sessionstate == "_encstr_877508C1D8C22F2DDC3B")
          var_2.headicon = "_encstr_B40101";
      }
    }
  }
}