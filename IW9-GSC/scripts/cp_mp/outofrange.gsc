/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\outofrange.gsc
***********************************************/

setupoutofrangewatcher(_id_616EA41542B3D45A, _id_096408B0D60660B1, _id_363C1035ED04723A, _id_0D9FFCA69374E542, _id_5A19DAFA23E95368, maxrangesq) {
  self.owner setclientomnvar("ui_out_of_range", 0);

  if(!isDefined(_id_096408B0D60660B1))
    _id_096408B0D60660B1 = _id_616EA41542B3D45A.origin;

  if(!isDefined(_id_5A19DAFA23E95368))
    _id_5A19DAFA23E95368 = 4000000;

  if(!isDefined(maxrangesq))
    maxrangesq = 16000000;

  if(isDefined(_id_363C1035ED04723A))
    _id_616EA41542B3D45A thread watchdistancefromentity(_id_363C1035ED04723A, _id_0D9FFCA69374E542, _id_5A19DAFA23E95368, maxrangesq);
  else
    _id_616EA41542B3D45A thread watchdistancefromstaticpoint(_id_096408B0D60660B1, _id_5A19DAFA23E95368, maxrangesq);
}

watchdistancefromentity(_id_363C1035ED04723A, _id_0D9FFCA69374E542, _id_5A19DAFA23E95368, maxrangesq) {
  self endon("death");

  if(!isDefined(_id_0D9FFCA69374E542))
    _id_0D9FFCA69374E542 = "tag_origin";

  for(;;) {
    if(!isDefined(_id_363C1035ED04723A)) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      return;
    }

    _id_096408B0D60660B1 = _id_363C1035ED04723A gettagorigin(_id_0D9FFCA69374E542);
    _id_332B8E9E4A668BAA = distancesquared(self.origin, _id_096408B0D60660B1);

    if(scripts\common\utility::iscp()) {
      _id_3369989E4AAB456A = _id_332B8E9E4A668BAA / maxrangesq;

      if(_id_3369989E4AAB456A <= 1)
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(_id_3369989E4AAB456A));
    }

    if(_id_332B8E9E4A668BAA >= _id_5A19DAFA23E95368)
      watchoutofrangestrength(_id_096408B0D60660B1, _id_5A19DAFA23E95368, maxrangesq, _id_363C1035ED04723A, _id_0D9FFCA69374E542);

    waitframe();
  }
}

watchdistancefromstaticpoint(_id_096408B0D60660B1, _id_5A19DAFA23E95368, maxrangesq) {
  self endon("death");

  for(;;) {
    _id_332B8E9E4A668BAA = distancesquared(self.origin, _id_096408B0D60660B1);

    if(scripts\common\utility::iscp()) {
      _id_3369989E4AAB456A = _id_332B8E9E4A668BAA / maxrangesq;

      if(_id_3369989E4AAB456A <= 1)
        self.owner setclientomnvar("ui_out_of_range_meter", sqrt(_id_3369989E4AAB456A));
    }

    if(_id_332B8E9E4A668BAA >= _id_5A19DAFA23E95368)
      watchoutofrangestrength(_id_096408B0D60660B1, _id_5A19DAFA23E95368, maxrangesq);

    waitframe();
  }
}

watchoutofrangestrength(_id_096408B0D60660B1, _id_5A19DAFA23E95368, maxrangesq, _id_363C1035ED04723A, _id_0D9FFCA69374E542) {
  for(;;) {
    if(isDefined(_id_363C1035ED04723A))
      _id_096408B0D60660B1 = _id_363C1035ED04723A gettagorigin(_id_0D9FFCA69374E542);

    _id_2EC38FD18649235A = distancesquared(self.origin, _id_096408B0D60660B1);
    _id_0EE7D4ED54A12819 = _id_2EC38FD18649235A / maxrangesq;
    self.owner setclientomnvar("ui_out_of_range", _id_0EE7D4ED54A12819);

    if(scripts\common\utility::iscp())
      self.owner setclientomnvar("ui_out_of_range_meter", sqrt(_id_0EE7D4ED54A12819));

    if(isDefined(self.owner.outofrangefunc))
      self.owner thread[[self.owner.outofrangefunc]](self.owner);

    if(_id_2EC38FD18649235A >= maxrangesq) {
      weapon = makeweapon("nuke_multi_mp");
      meansofdeath = "MOD_EXPLOSIVE";
      self.owner setclientomnvar("ui_out_of_range", 0);
      self dodamage(10000, self.origin, self.owner, self.owner, meansofdeath, weapon);
      break;
    } else if(_id_2EC38FD18649235A < _id_5A19DAFA23E95368) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      break;
    }

    waitframe();
  }
}