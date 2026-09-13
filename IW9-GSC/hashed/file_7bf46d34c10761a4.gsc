/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7bf46d34c10761a4.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_0D93C7EECED9FD57 = bot _id_47366BEB5BA9FA22::_id_7E7DDFA33EFF2C11()[0];
  _id_6F378A329663705A = _id_0D93C7EECED9FD57.numtouching[bot.team];
  _id_B5AEB4A2AE3657FD = (level._id_A18063A06C258143 - gettime()) / 1000;
  _id_72BB89E60D3674DF = self._id_E889B543C8E054AE.basescore;
  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_B5AEB4A2AE3657FD, self._id_E889B543C8E054AE._id_50CF5A797D61AE47, self._id_E889B543C8E054AE._id_F65CAD93A3671678);
  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + self._id_E889B543C8E054AE._id_224FD0F99E59F420[_id_6F378A329663705A];
  _id_5FF767C78F89F018 = _id_0D93C7EECED9FD57;

  if(_id_72BB89E60D3674DF < self._id_E889B543C8E054AE._id_CC2F39E2D76F6B7D) {
    _id_72BB89E60D3674DF = self._id_E889B543C8E054AE._id_CC2F39E2D76F6B7D;
    _id_5FF767C78F89F018 = _id_47366BEB5BA9FA22::_id_B4E30A9548AA351B();
  }

  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Capture Flag", _id_5FF767C78F89F018, "main", _id_5FF767C78F89F018.objectivekey, ::_id_35671B7B1A04BF58, self);
  return _id_72BB89E60D3674DF;
}

_id_35671B7B1A04BF58(bot) {
  _id_C915DFAEBD848F45 = self._id_EC02147FEE952CE2;
  _id_9920C1B439193F77 = 10;
  nodes = _id_62F98FD3D37278DC(_id_C915DFAEBD848F45);

  for(;;) {
    _id_E12D35DC8D670C95 = scripts\engine\utility::_id_7A2AAA4A09A4D250(nodes);
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E12D35DC8D670C95.origin, _id_9920C1B439193F77);
    result = scripts\engine\utility::waittill_any_ents_or_timeout_return(15, bot, "bad_path", bot, "long_path", bot, "goal");

    if(result == "goal")
      wait 1;
  }
}

_id_62F98FD3D37278DC(_id_C915DFAEBD848F45) {
  nodes = [];

  if(!isDefined(_id_C915DFAEBD848F45.nodes))
    nodes = _id_7F989E71B934C9FC::bot_get_valid_nodes_in_trigger(_id_C915DFAEBD848F45.trigger);

  if(nodes.size <= 0) {
    target = _id_C915DFAEBD848F45.trigger.target;
    _id_6F0350C82FC94C38 = getEntArray("script_origin", "classname");

    if(isDefined(_id_6F0350C82FC94C38)) {
      foreach(ent in _id_6F0350C82FC94C38) {
        if(isDefined(ent.targetname) && ent.targetname == target)
          nodes[nodes.size] = ent;
      }
    }
  }

  return nodes;
}