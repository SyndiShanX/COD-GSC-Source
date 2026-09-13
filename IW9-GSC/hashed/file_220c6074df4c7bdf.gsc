/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_220c6074df4c7bdf.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_7BF6EE12B10EC682 = gettime();
  _id_4FEF774BC5A2767D = [];
  soundevents = bot _id_25B55D37E1B51DB1::_id_7E7DDFA33EFF2C11();

  foreach(event in soundevents) {
    if(!isDefined(event.owner)) {
      continue;
    }
    _id_0EBF0BCD780E61D5 = event.owner getentitynumber();
    _id_CDDE5078F529B40E = _id_4FEF774BC5A2767D[_id_0EBF0BCD780E61D5];

    if(!isDefined(_id_CDDE5078F529B40E)) {
      _id_CDDE5078F529B40E = spawnStruct();
      _id_CDDE5078F529B40E._id_58375251F390DE07 = 0;
      _id_4FEF774BC5A2767D[_id_0EBF0BCD780E61D5] = _id_CDDE5078F529B40E;
    }

    _id_CDDE5078F529B40E._id_58375251F390DE07++;
    _id_29728D2A6ECAE1C7 = self._id_E889B543C8E054AE._id_5E9293CAC9317139[event.type];
    dist = distance(event.pos, bot.origin);

    if(event.type == "footstep" || event.type == "footstep_walk" || event.type == "footstep_sprint")
      _id_29728D2A6ECAE1C7 = _id_29728D2A6ECAE1C7 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(dist, self._id_E889B543C8E054AE._id_1C1E326EDFAEE326, self._id_E889B543C8E054AE._id_B17CBF80B52DF82F);
    else
      _id_29728D2A6ECAE1C7 = _id_29728D2A6ECAE1C7 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(dist, self._id_E889B543C8E054AE._id_436444EBCB6BF7B3, self._id_E889B543C8E054AE._id_E8DE868E20882C8A);

    time = (_id_7BF6EE12B10EC682 - event.time) / 1000;
    _id_29728D2A6ECAE1C7 = _id_29728D2A6ECAE1C7 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(time, self._id_E889B543C8E054AE._id_50CF5A797D61AE47, self._id_E889B543C8E054AE._id_F65CAD93A3671678);

    if(!isDefined(_id_CDDE5078F529B40E._id_D414BA671EB56685) || _id_29728D2A6ECAE1C7 > _id_CDDE5078F529B40E._id_D414BA671EB56685) {
      _id_CDDE5078F529B40E._id_D414BA671EB56685 = _id_29728D2A6ECAE1C7;
      _id_CDDE5078F529B40E.event = event;
    }
  }

  _id_72BB89E60D3674DF = 0;
  _id_2A38F6E57D09B111 = undefined;

  foreach(_id_BD73C7ACC56CD20C in _id_4FEF774BC5A2767D) {
    if(_id_BD73C7ACC56CD20C.event.type == "can_see" || _id_BD73C7ACC56CD20C.event.type == "bullet_whizby")
      score = _id_BD73C7ACC56CD20C._id_D414BA671EB56685;
    else
      score = _id_BD73C7ACC56CD20C._id_D414BA671EB56685 + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_BD73C7ACC56CD20C._id_58375251F390DE07 - 1, self._id_E889B543C8E054AE._id_931B4359890CEF33, self._id_E889B543C8E054AE._id_188AE31C05E38B7C);

    if(score <= 0) {
      continue;
    }
    if(score > _id_72BB89E60D3674DF) {
      _id_72BB89E60D3674DF = score;
      _id_2A38F6E57D09B111 = _id_BD73C7ACC56CD20C;
    }
  }

  if(!isDefined(_id_2A38F6E57D09B111))
    return 0;

  _id_67CCE4B1942E19E5 = _id_2A38F6E57D09B111.event.pos;
  _id_E4B8C3D6E82A814B = _id_2A38F6E57D09B111.event.owner getentitynumber();
  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Search Threat Plus", _id_67CCE4B1942E19E5, "main", "$e" + _id_E4B8C3D6E82A814B, ::_id_35671B7B1A04BF58, self);
  return _id_72BB89E60D3674DF;
}

_id_35671B7B1A04BF58(bot) {
  pos = self._id_EC02147FEE952CE2;
  targetpos = _id_2695A20D4011076D::getrandompointincircle(pos, 128, undefined, undefined, 1, 1);
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, 128);
  result = bot scripts\engine\utility::waittill_any_in_array_return(["bad_path", "goal"]);

  if(result == "goal")
    return;
  else if(result == "bad_path")
    return result;
}