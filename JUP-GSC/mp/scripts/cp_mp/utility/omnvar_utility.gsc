/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\omnvar_utility.gsc
*******************************************************/

#namespace omnvar_utility;

function setcachedgameomnvar(omnvar, value) {
  if(!isDefined(omnvar) || !isDefined(value)) {
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
  if(!isDefined(self) || !isDefined(omnvar) || !isDefined(value)) {
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
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (newvalue &mask) << bitoffset;
  invertedmask = ~(mask << bitoffset);
  cleanedbase = prevpackedvalue &invertedmask;
  repackedvalue = cleanedbase + var_a463992091f1d483;
  return repackedvalue;
}

function unpackvalue(bitoffset, bitwidth, packedvalue) {
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = packedvalue >> bitoffset &mask;
  return var_a463992091f1d483;
}

function function_63437fca39c681dc(omnvarname, bitoffset, bitwidth, value) {
  prevvalue = self getclientomnvar(omnvarname);
  repackedvalue = repackomnvar(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != repackedvalue) {
    self setclientomnvar(omnvarname, repackedvalue);
  }
}

function function_40f3e4aeda0e3f00(omnvarname, bitoffset, bitwidth) {
  value = self getclientomnvar(omnvarname);
  unpackedvalue = unpackvalue(bitoffset, bitwidth, value);
  return unpackedvalue;
}

function function_d3cf7ff1a257e2c3(omnvarname, bitoffset, bitwidth, value) {
  prevvalue = getomnvar(omnvarname);
  repackedvalue = repackomnvar(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != repackedvalue) {
    setomnvar(omnvarname, repackedvalue);
  }
}

function function_610e0cca26bba2f(omnvarname, bitoffset, bitwidth) {
  value = getomnvar(omnvarname);
  unpackedvalue = unpackvalue(bitoffset, bitwidth, value);
  return unpackedvalue;
}