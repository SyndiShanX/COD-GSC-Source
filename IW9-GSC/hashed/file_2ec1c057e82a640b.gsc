/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ec1c057e82a640b.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  victim = bot _id_E7B671A6A101C0DF();

  if(!isDefined(victim))
    return 0;

  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("revive_teammate", victim, "main", "", ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
  _id_47748EAD6297784B = distance(bot.origin, victim.origin);
  basescore = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_47748EAD6297784B, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);
  _id_C3F669F8CD557637 = bot _id_40E63DD222434655::_id_A0FBE39135AB0D35();
  _id_020E68057B05A543 = gettime() - _id_C3F669F8CD557637;
  _id_DA6670BE3BC98F68 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_020E68057B05A543, self._id_E889B543C8E054AE._id_6477B93FA7DB5161, self._id_E889B543C8E054AE._id_AFB9AC7095182AE5);
  basescore = basescore + _id_DA6670BE3BC98F68;
  basescore = basescore * self._id_E889B543C8E054AE._id_48B2040DB1860373;
  return basescore;
}

_id_E7B671A6A101C0DF() {
  aliveplayers = scripts\mp\utility\teams::getteamdata(self.team, "alivePlayers");

  foreach(victim in aliveplayers) {
    if(_id_AC3AB26CD0F25AAD(victim, self))
      return victim;
  }

  return undefined;
}

_id_35671B7B1A04BF58(bot) {
  _id_9ADB3CC75347D013 = 64;
  victim = self._id_EC02147FEE952CE2;
  victim endon("death_or_disconnect");

  for(;;) {
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(victim.origin, _id_9ADB3CC75347D013);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "bad_path")
      return result;
    else if(!_id_AC3AB26CD0F25AAD(victim, bot))
      return "Invalid victim";

    if(distancesquared(bot.origin, victim.origin) <= _id_9ADB3CC75347D013 * _id_9ADB3CC75347D013) {
      bot _id_40E63DD222434655::_id_8B201BCCC0AA3695(victim.origin);
      wait 0.5;
      bot botsetflag("disable_movement", 1);
      bot botclearscriptgoal();
      _id_E4C92E63BB46D4D4(bot, victim);
      return;
    }
  }
}

_id_E4C92E63BB46D4D4(reviver, victim) {
  _id_0E5486D00EBBA6E9 = level.laststandrevivetimer + 1;
  reviver botpressbutton("use", _id_0E5486D00EBBA6E9);
  wait(_id_0E5486D00EBBA6E9 + 0.5);
}

_id_AC3AB26CD0F25AAD(victim, reviver) {
  return _id_59FF79D681BB860C::isvalidplayer(victim) && victim != reviver && scripts\mp\utility\player::isinlaststand(victim) && _id_7E816FA0720D38A1::ispointincurrentcircle(victim.origin) && !victim _id_40E63DD222434655::_id_B74CF5EB822312CB(1);
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self botsetflag("disable_movement", 0);
}