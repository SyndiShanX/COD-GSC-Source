/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerstats_interface.gsc
************************************************/

setplayerstat(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!areplayerstatsenabled()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!scripts\mp\playerstats::isstatwritable_internal(_id_BE5D99E3162A7241)) {
    return;
  }
  scripts\mp\playerstats::setplayerstat_internal(value, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::writeplayerstat(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::updateparentratiosbuffered(_id_BE5D99E3162A7241);
}

setplayerstatbuffered(value, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!areplayerstatsenabled()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  patharray = [_id_59BE945B7442F9C1];
  patharray[patharray.size] = _id_59BE915B7442F328;
  patharray[patharray.size] = _id_59BE925B7442F55B;
  patharray[patharray.size] = _id_59BE975B7443005A;
  patharray[patharray.size] = _id_59BE985B7443028D;
  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!scripts\mp\playerstats::isstatwritable_internal(_id_BE5D99E3162A7241)) {
    return;
  }
  scripts\mp\playerstats::setplayerstat_internal(value, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::flagstatforbufferedwrite(_id_BE5D99E3162A7241);
  scripts\mp\playerstats::updateparentratiosbuffered(_id_BE5D99E3162A7241);
}

addtoplayerstat(_id_930290D7F474A0AE, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!areplayerstatsenabled()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!scripts\mp\playerstats::isstatwritable_internal(_id_BE5D99E3162A7241)) {
    return;
  }
  scripts\mp\playerstats::addtoplayerstat_internal(_id_930290D7F474A0AE, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::writeplayerstat(self.playerstats.values[_id_BE5D99E3162A7241], _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::updateparentratios(_id_BE5D99E3162A7241);
}

addtoplayerstatbuffered(_id_930290D7F474A0AE, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!areplayerstatsenabled()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!scripts\mp\playerstats::isstatwritable_internal(_id_BE5D99E3162A7241)) {
    return;
  }
  scripts\mp\playerstats::addtoplayerstat_internal(_id_930290D7F474A0AE, _id_BE5D99E3162A7241, _id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  scripts\mp\playerstats::flagstatforbufferedwrite(_id_BE5D99E3162A7241);
  scripts\mp\playerstats::updateparentratiosbuffered(_id_BE5D99E3162A7241);
}

getplayerstat(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  if(!areplayerstatsenabled())
    return undefined;

  if(isai(self))
    return 0;

  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  if(!isDefined(self.playerstats.values[_id_BE5D99E3162A7241]))
    self.playerstats.values[_id_BE5D99E3162A7241] = scripts\mp\playerstats::readplayerstat(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);

  return self.playerstats.values[_id_BE5D99E3162A7241];
}

areplayerstatsenabled() {
  return isDefined(level.playerstats) && istrue(level.playerstats.enabled);
}

areplayerstatsreadonly() {
  return level.playerstats.readonly > 0;
}

makeallplayerstatsreadonly() {
  level.playerstats.readonly++;
}

makeallplayerstatswritable() {
  level.playerstats.readonly--;
}

makeplayerstatreadonly(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  return scripts\mp\playerstats::modifystatwritability(_id_BE5D99E3162A7241, 0);
}

makeplayerstatwritable(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  return scripts\mp\playerstats::modifystatwritability(_id_BE5D99E3162A7241, 1);
}

isplayerstatwritable(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D) {
  _id_BE5D99E3162A7241 = scripts\mp\playerstats::getplayerstatpathkey(_id_59BE945B7442F9C1, _id_59BE915B7442F328, _id_59BE925B7442F55B, _id_59BE975B7443005A, _id_59BE985B7443028D);
  return scripts\mp\playerstats::isstatwritable_internal(_id_BE5D99E3162A7241);
}

makeplayerstatgroupreadonly(_id_14E8C48563B7348A) {
  scripts\mp\playerstats::modifystatgroupwritability(_id_14E8C48563B7348A, 0);
}

makeplayerstatgroupwritable(_id_14E8C48563B7348A) {
  scripts\mp\playerstats::modifystatgroupwritability(_id_14E8C48563B7348A, 1);
}

registerplayerstatratio(_id_8C83072B0421282C, _id_59381B551181653C, _id_DE2AD9F399EC5304) {
  _id_584994FAB4A8712B = level.playerstats;
  _id_75AF64168ADE09B6 = scripts\mp\playerstats::getplayerstatpathkey(_id_8C83072B0421282C[0], _id_8C83072B0421282C[1], _id_8C83072B0421282C[2], _id_8C83072B0421282C[3], _id_8C83072B0421282C[4]);
  _id_584994FAB4A8712B.ratios[_id_75AF64168ADE09B6] = [];
  _id_584994FAB4A8712B.ratios[_id_75AF64168ADE09B6]["numerator"] = _id_59381B551181653C;
  _id_584994FAB4A8712B.ratios[_id_75AF64168ADE09B6]["denominator"] = _id_DE2AD9F399EC5304;
  _id_9239B0AE7E345446 = scripts\mp\playerstats::getplayerstatpathkey(_id_59381B551181653C[0], _id_59381B551181653C[1], _id_59381B551181653C[2], _id_59381B551181653C[3], _id_59381B551181653C[4]);
  _id_C265966FFD9818BE = scripts\mp\playerstats::getplayerstatpathkey(_id_DE2AD9F399EC5304[0], _id_DE2AD9F399EC5304[1], _id_DE2AD9F399EC5304[2], _id_DE2AD9F399EC5304[3], _id_DE2AD9F399EC5304[4]);

  if(!isDefined(_id_584994FAB4A8712B.ratiochildren[_id_9239B0AE7E345446]))
    _id_584994FAB4A8712B.ratiochildren[_id_9239B0AE7E345446] = [_id_8C83072B0421282C];
  else
    _id_584994FAB4A8712B.ratiochildren[_id_9239B0AE7E345446][_id_584994FAB4A8712B.ratiochildren[_id_9239B0AE7E345446].size] = _id_8C83072B0421282C;

  if(!isDefined(_id_584994FAB4A8712B.ratiochildren[_id_C265966FFD9818BE]))
    _id_584994FAB4A8712B.ratiochildren[_id_C265966FFD9818BE] = [_id_8C83072B0421282C];
  else
    _id_584994FAB4A8712B.ratiochildren[_id_C265966FFD9818BE][_id_584994FAB4A8712B.ratiochildren[_id_C265966FFD9818BE].size] = _id_8C83072B0421282C;
}