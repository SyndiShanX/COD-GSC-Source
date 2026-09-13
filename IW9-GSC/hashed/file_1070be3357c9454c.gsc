/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1070be3357c9454c.gsc
***********************************************/

init() {
  _id_B2F29EC079807FBF = ["t10_sprint_variants", "t10_sprint_variant_a", "t10_sprint_variant_b", "t10_sprint_variant_c"];
  level._id_3BEDD0A92453A1DF = scripts\engine\utility::array_randomize(_id_B2F29EC079807FBF);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamnospectatorcallback(::_id_B9D238D0B3043270);
}

_id_FCB289B4D9D2198E() {
  return level._id_3BEDD0A92453A1DF;
}

_id_B9D238D0B3043270(player) {
  _id_5B48C7D50BDBD7F7 = _id_FCB289B4D9D2198E();

  if(_id_5B48C7D50BDBD7F7.size == 0) {
    return;
  }
  if(!isDefined(level.teamdata[player.team]["teamAddedCount"]))
    level.teamdata[player.team]["teamAddedCount"] = 0;

  _id_D4A9F3765962D3FC = level.teamdata[player.team]["teamAddedCount"] % _id_5B48C7D50BDBD7F7.size;
  player._id_A8DAB01D882B1E9F = _id_5B48C7D50BDBD7F7[_id_D4A9F3765962D3FC];
  player _id_B593A4A8E497FF86();
  level.teamdata[player.team]["teamAddedCount"]++;
}

_id_B0C47B36A5B76623(_id_FCB213F783A6DDA0) {
  self _meth_B4D14C500183CBD6(_id_FCB213F783A6DDA0);
}

_id_2A4ECAC859CA54D7() {
  return self._id_A8DAB01D882B1E9F;
}

_id_B593A4A8E497FF86() {
  if(!isDefined(self._id_A8DAB01D882B1E9F)) {
    return;
  }
  _id_B0C47B36A5B76623(self._id_A8DAB01D882B1E9F);
}