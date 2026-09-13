/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\omnvar_utility.gsc
****************************************************/

setcachedgameomnvar(omnvar, value) {
  if(!isDefined(omnvar) || !isDefined(value)) {
    return;
  }
  if(!isDefined(level.cachedomnars))
    level.cachedomnars = [];

  _id_7551517E1BE634EE = !isDefined(level.cachedomnars[omnvar]) || level.cachedomnars[omnvar] != value;
  level.cachedomnars[omnvar] = value;

  if(_id_7551517E1BE634EE)
    setomnvar(omnvar, value);
}

setcachedclientomnvar(omnvar, value) {
  if(!isDefined(self) || !isDefined(omnvar) || !isDefined(value)) {
    return;
  }
  if(!isDefined(self.cachedomnars))
    self.cachedomnars = [];

  _id_7551517E1BE634EE = !isDefined(self.cachedomnars[omnvar]) || self.cachedomnars[omnvar] != value;
  self.cachedomnars[omnvar] = value;

  if(_id_7551517E1BE634EE)
    self setclientomnvar(omnvar, value);
}

_id_8B532402EE55336E(_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_49F3B7A464F1D70D, _id_8F617FFD000EB682) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (_id_8F617FFD000EB682 &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_ED711AEAF5E8CB76 = _id_49F3B7A464F1D70D &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  return _id_82A90E56E416FA55;
}

_id_63437FCA39C681DC(_id_E9D476A3809CB3F1, _id_64571E3AECCD1A07, _id_8534515023AFC188, value) {
  _id_EE27F3F198276535 = self getclientomnvar(_id_E9D476A3809CB3F1);
  _id_82A90E56E416FA55 = _id_8B532402EE55336E(_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_EE27F3F198276535, value);

  if(_id_EE27F3F198276535 != _id_82A90E56E416FA55)
    self setclientomnvar(_id_E9D476A3809CB3F1, _id_82A90E56E416FA55);
}

_id_D3CF7FF1A257E2C3(_id_E9D476A3809CB3F1, _id_64571E3AECCD1A07, _id_8534515023AFC188, value) {
  _id_EE27F3F198276535 = getomnvar(_id_E9D476A3809CB3F1);
  _id_82A90E56E416FA55 = _id_8B532402EE55336E(_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_EE27F3F198276535, value);

  if(_id_EE27F3F198276535 != _id_82A90E56E416FA55)
    setomnvar(_id_E9D476A3809CB3F1, _id_82A90E56E416FA55);
}