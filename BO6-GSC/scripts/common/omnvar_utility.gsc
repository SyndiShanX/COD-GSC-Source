/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\omnvar_utility.gsc
*********************************************/

#namespace omnvar_utility;

function setcachedgameomnvar(omnvar, value) {
  if(!(isDefined(omnvar) && isDefined(value))) {
    return;
  }

  if(!isDefined(level.cachedomnars)) {
    level.cachedomnars = [];
  }

  shouldset = !isDefined(level.cachedomnars[omnvar]) || level.cachedomnars[omnvar] != value;
  level.cachedomnars[omnvar] = value;

  if(shouldset) {
    setomnvar(omnvar, value);
  }
}

function setcachedclientomnvar(omnvar, value) {
  if(!(isDefined(omnvar) && isDefined(self) && isDefined(value))) {
    return;
  }

  if(!isDefined(self.cachedomnars)) {
    self.cachedomnars = [];
  }

  shouldset = !isDefined(self.cachedomnars[omnvar]) || self.cachedomnars[omnvar] != value;
  self.cachedomnars[omnvar] = value;

  if(shouldset) {
    self setclientomnvar(omnvar, value);
  }
}

function repackomnvar(bitoffset, bitwidth, prevpackedvalue, newvalue) {
  mask = function_34301235e17ff00b(bitwidth);
  assert(newvalue <= mask, "<dev string:x24>" + newvalue + "<dev string:x41>" + bitwidth + "<dev string:x5d>");
  var_3f3eddb5d7f34352 = (newvalue &mask) << bitoffset;
  invertedmask = ~(mask << bitoffset);
  cleanedbase = prevpackedvalue &invertedmask;
  repackedvalue = cleanedbase + var_3f3eddb5d7f34352;
  return repackedvalue;
}

function unpackvalue(bitoffset, bitwidth, packedvalue) {
  mask = function_34301235e17ff00b(bitwidth);
  var_3f3eddb5d7f34352 = packedvalue >> bitoffset &mask;
  return var_3f3eddb5d7f34352;
}

function function_b4f7d6c26680e42d(omnvarname, bitoffset, bitwidth) {
  value = self getclientomnvar(omnvarname);
  unpackedvalue = unpackvalue(bitoffset, bitwidth, value);
  return unpackedvalue;
}

function function_2f680deb3a1c4401(omnvarname, bitoffset, bitwidth, value) {
  prevvalue = self getclientomnvar(omnvarname);
  repackedvalue = repackomnvar(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != repackedvalue) {
    self setclientomnvar(omnvarname, repackedvalue);
  }
}

function function_abf2dea711d8f552(omnvarname, bitoffset, bitwidth, value) {
  prevvalue = getomnvar(omnvarname);
  repackedvalue = repackomnvar(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != repackedvalue) {
    setomnvar(omnvarname, repackedvalue);
  }
}

function function_86d1d6ea2c7299c6(omnvarname, bitoffset, bitwidth) {
  value = getomnvar(omnvarname);
  unpackedvalue = unpackvalue(bitoffset, bitwidth, value);
  return unpackedvalue;
}

function function_34301235e17ff00b(bitwidth) {
  return (1 << bitwidth) - 1;
}