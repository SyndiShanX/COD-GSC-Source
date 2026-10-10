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

function function_8b532402ee55336e(bitoffset, bitwidth, var_49f3b7a464f1d70d, newvalue) {
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = (newvalue &mask) << bitoffset;
  var_f8f977081d3da8b4 = ~(mask << bitoffset);
  cleanedbase = var_49f3b7a464f1d70d &var_f8f977081d3da8b4;
  var_82a90e56e416fa55 = cleanedbase + var_a463992091f1d483;
  return var_82a90e56e416fa55;
}

function unpackvalue(bitoffset, bitwidth, packedvalue) {
  mask = int(pow(2, bitwidth)) - 1;
  var_a463992091f1d483 = packedvalue >> bitoffset &mask;
  return var_a463992091f1d483;
}

function function_63437fca39c681dc(var_e9d476a3809cb3f1, bitoffset, bitwidth, value) {
  prevvalue = self getclientomnvar(var_e9d476a3809cb3f1);
  var_82a90e56e416fa55 = function_8b532402ee55336e(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != var_82a90e56e416fa55) {
    self setclientomnvar(var_e9d476a3809cb3f1, var_82a90e56e416fa55);
  }
}

function function_40f3e4aeda0e3f00(var_e9d476a3809cb3f1, bitoffset, bitwidth) {
  value = self getclientomnvar(var_e9d476a3809cb3f1);
  var_26a6c0adbaffb03f = unpackvalue(bitoffset, bitwidth, value);
  return var_26a6c0adbaffb03f;
}

function function_d3cf7ff1a257e2c3(var_e9d476a3809cb3f1, bitoffset, bitwidth, value) {
  prevvalue = getomnvar(var_e9d476a3809cb3f1);
  var_82a90e56e416fa55 = function_8b532402ee55336e(bitoffset, bitwidth, prevvalue, value);

  if(prevvalue != var_82a90e56e416fa55) {
    setomnvar(var_e9d476a3809cb3f1, var_82a90e56e416fa55);
  }
}

function function_610e0cca26bba2f(var_e9d476a3809cb3f1, bitoffset, bitwidth) {
  value = getomnvar(var_e9d476a3809cb3f1);
  var_26a6c0adbaffb03f = unpackvalue(bitoffset, bitwidth, value);
  return var_26a6c0adbaffb03f;
}