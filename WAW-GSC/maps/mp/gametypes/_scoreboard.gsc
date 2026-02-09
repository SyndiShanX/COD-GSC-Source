init() {
  switch (game["allies"]) {
    case "marines":
      setDvar("g_TeamName_Allies", &"MPUI_MARINE_SHORT");

      precacheShader("faction_128_american");
      setDvar("g_TeamIcon_Allies", "faction_128_american");
      setDvar("g_TeamColor_Allies", ".5 .5 .5");
      setDvar("g_ScoresColor_Allies", "0 0 0");

      break;

    case "russian":
      setDvar("g_TeamName_Allies", &"MPUI_RUSSIAN_SHORT");

      precacheShader("faction_128_soviet");
      setDvar("g_TeamIcon_Allies", "faction_128_soviet");
      setDvar("g_TeamColor_Allies", "0.6 0.64 0.69");
      setDvar("g_ScoresColor_Allies", "0.6 0.64 0.69");
      break;
  }

  switch (game["axis"]) {
    case "german":
      setDvar("g_TeamName_Axis", &"MPUI_GERMAN_SHORT");

      precacheShader("faction_128_german");
      setDvar("g_TeamIcon_Axis", "faction_128_german");
      setDvar("g_TeamColor_Axis", "0.65 0.57 0.41");
      setDvar("g_ScoresColor_Axis", "0.65 0.57 0.41");
      break;

    case "japanese":
      setDvar("g_TeamName_Axis", &"MPUI_JAPANESE_SHORT");

      precacheShader("faction_128_japan");
      setDvar("g_TeamIcon_Axis", "faction_128_japan");
      setDvar("g_TeamColor_Axis", "0.52 0.28 0.28");
      setDvar("g_ScoresColor_Axis", "0.52 0.28 0.28");
      break;
  }
  setDvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setDvar("g_ScoresColor_Free", ".76 .78 .10");

  setDvar("g_teamColor_MyTeam", ".4 .7 .4");
  setDvar("g_teamColor_EnemyTeam", "1 .315 0.35");
  setDvar("g_teamColor_MyTeamAlt", ".35 1 1"); //cyan
  setDvar("g_teamColor_EnemyTeamAlt", "1 .5 0"); //orange	

  setDvar("g_teamColor_Squad", ".315 0.35 1");
}