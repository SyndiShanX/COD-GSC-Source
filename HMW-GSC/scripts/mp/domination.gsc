main() {
  replaceFunc(maps\mp\gametypes\dom::updatescoreboarddom, ::updatescoreboarddom_stub); // cheap entrypoint
}

updatescoreboarddom_stub() {
  level endon("game_ended");

  halfTime = 0; //getMatchRulesData( "domData", "halfTime" );
  setDynamicDvar("scr_dom_halftime", halfTime);
  level.halftimeonscorelimit = halfTime;
  maps\mp\_utility::registerhalftimedvar("dom", halfTime);

  for (;;) {
    level waittill("connected", player);
    player thread maps\mp\gametypes\dom::updatecaptures();
    player thread maps\mp\gametypes\dom::updatedefends();
  }
}