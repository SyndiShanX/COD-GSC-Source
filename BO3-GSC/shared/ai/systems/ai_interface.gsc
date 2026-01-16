/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\ai_interface.gsc
*************************************************/

#namespace ai_interface;

function autoexec main() {
  level.__ai_debuginterface = getdvarint("");
}

function private _checkvalue(archetype, attributename, value) {
  attribute = level.__ai_interface[archetype][attributename];
  switch (attribute[""]) {
    case "": {
      possiblevalues = attribute[""];
      assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), ((("" + value) + "") + attributename) + "");
      break;
    }
    case "": {
      maxvalue = attribute[""];
      minvalue = attribute[""];
      assert(isint(value) || isfloat(value), ((("" + attributename) + "") + value) + "");
      assert(!isdefined(maxvalue) && !isdefined(minvalue) || (value <= maxvalue && value >= minvalue), ((((("" + value) + "") + minvalue) + "") + maxvalue) + "");
      break;
    }
    case "": {
      if(isdefined(value)) {
        assert(isvec(value), ((("" + attributename) + "") + value) + "");
      }
      break;
    }
    default: {
      assert(((("" + attribute[""]) + "") + attributename) + "");
      break;
    }
  }
}

function private _checkprerequisites(entity, attribute) {
  /# /
  #
  assert(isentity(entity), "");
  assert(isactor(entity) || isvehicle(entity), "");
  assert(isstring(attribute), "");
  if(isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
    assert(isarray(entity.__interface), (("" + entity.archetype) + "") + "");
    assert(isarray(level.__ai_interface), "");
    assert(isarray(level.__ai_interface[entity.archetype]), ("" + entity.archetype) + "");
    assert(isarray(level.__ai_interface[entity.archetype][attribute]), ((("" + attribute) + "") + entity.archetype) + "");
    assert(isstring(level.__ai_interface[entity.archetype][attribute][""]), ("" + attribute) + "");
  }
}

function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
  /# /
  #
  assert(isstring(archetype), "");
  assert(isstring(attribute), "");
  assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "");
}

function private _initializelevelinterface(archetype) {
  if(!isdefined(level.__ai_interface)) {
    level.__ai_interface = [];
  }
  if(!isdefined(level.__ai_interface[archetype])) {
    level.__ai_interface[archetype] = [];
  }
}

#namespace ai;

function createinterfaceforentity(entity) {
  if(!isdefined(entity.__interface)) {
    entity.__interface = [];
  }
}

function getaiattribute(entity, attribute) {
  ai_interface::_checkprerequisites(entity, attribute);
  if(!isdefined(entity.__interface[attribute])) {
    return level.__ai_interface[entity.archetype][attribute]["default_value"];
  }
  return entity.__interface[attribute];
}

function hasaiattribute(entity, attribute) {
  return isdefined(entity) && isdefined(attribute) && isdefined(entity.archetype) && isdefined(level.__ai_interface) && isdefined(level.__ai_interface[entity.archetype]) && isdefined(level.__ai_interface[entity.archetype][attribute]);
}

function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isdefined(possiblevalues) || isarray(possiblevalues), "");
  ai_interface::_initializelevelinterface(archetype);
  /# /
  #
  assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute]["type"] = "_interface_match";
  level.__ai_interface[archetype][attribute]["values"] = possiblevalues;
  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "");
  assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "");
  assert(!isdefined(minimum) && !isdefined(maximum) || (isdefined(minimum) && isdefined(maximum)), "");
  assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, (("" + attribute) + "") + "");
  ai_interface::_initializelevelinterface(archetype);
  /# /
  #
  assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute]["max_value"] = maximum;
  level.__ai_interface[archetype][attribute]["min_value"] = minimum;
  level.__ai_interface[archetype][attribute]["type"] = "_interface_numeric";
  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  ai_interface::_initializelevelinterface(archetype);
  /# /
  #
  assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute]["type"] = "_interface_vector";
  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function setaiattribute(entity, attribute, value) {
  ai_interface::_checkprerequisites(entity, attribute);
  ai_interface::_checkvalue(entity.archetype, attribute, value);
  oldvalue = entity.__interface[attribute];
  if(!isdefined(oldvalue)) {
    oldvalue = level.__ai_interface[entity.archetype][attribute]["default_value"];
  }
  entity.__interface[attribute] = value;
  callback = level.__ai_interface[entity.archetype][attribute]["callback"];
  if(isfunctionptr(callback)) {
    [
      [callback]
    ](entity, attribute, oldvalue, value);
  }
}