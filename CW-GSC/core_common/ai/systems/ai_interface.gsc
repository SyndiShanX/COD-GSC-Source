/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\ai_interface.gsc
***************************************************/

#namespace ai_interface;

function autoexec main() {
  level.__ai_debuginterface = getdvarint(#"ai_debuginterface", 0);
}

function private _checkvalue(archetype, attributename, value) {
  attribute = level.__ai_interface[archetype][attributename];

  switch (attribute[#"type"]) {
    case # "_interface_entity":
      break;
    case # "_interface_match":
      possiblevalues = attribute[#"values"];
      assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "<dev string:x38>" + value + "<dev string:x41>" + attributename + "<dev string:x77>");
      break;
    case # "_interface_numeric":
      maxvalue = attribute[#"max_value"];
      minvalue = attribute[#"min_value"];
      assert(isint(value) || isfloat(value), "<dev string:x7d>" + attributename + "<dev string:x90>" + value + "<dev string:xb4>");
      assert(!isDefined(maxvalue) && !isDefined(minvalue) || value <= maxvalue && value >= minvalue, "<dev string:x38>" + value + "<dev string:xcb>" + minvalue + "<dev string:xf2>" + maxvalue + "<dev string:xf7>");
      break;
    case # "_interface_vector":
      if(isDefined(value)) {
        assert(isvec(value), "<dev string:x7d>" + attributename + "<dev string:xfd>" + value + "<dev string:xb4>");
      }

      break;
    default:
      assert("<dev string:x120>" + attribute[#"type"] + "<dev string:x143>" + attributename + "<dev string:x77>");
      break;
  }
}

function private _checkprerequisites(entity, attribute) {
  if(isDefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
    assert(isentity(entity) || isstruct(entity), "<dev string:x158>");
    assert(isactor(entity) || isvehicle(entity) || isstruct(entity) || isbot(entity), "<dev string:x18b>");
    assert(isstring(attribute), "<dev string:x1c8>");
    assert(isarray(entity.__interface), "<dev string:x1f4>" + function_9e72a96(entity.archetype) + "<dev string:x203>" + "<dev string:x237>");
    assert(isarray(level.__ai_interface), "<dev string:x269>");
    assert(isarray(level.__ai_interface[entity.archetype]), "<dev string:x2b5>" + function_9e72a96(entity.archetype) + "<dev string:x2da>");
    assert(isarray(level.__ai_interface[entity.archetype][attribute]), "<dev string:x7d>" + attribute + "<dev string:x2f5>" + function_9e72a96(entity.archetype) + "<dev string:x322>");
    assert(isstring(level.__ai_interface[entity.archetype][attribute][#"type"]), "<dev string:x32c>" + attribute + "<dev string:x77>");
  }
}

function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
  assert(ishash(archetype), "<dev string:x355>");
  assert(ishash(attribute), "<dev string:x39b>");
  assert(!isDefined(callbackfunction) || isfunctionptr(callbackfunction), "<dev string:x3e1>");
}

function private _initializelevelinterface(archetype) {
  if(!isDefined(level.__ai_interface)) {
    level.__ai_interface = [];
  }

  if(!isDefined(level.__ai_interface[archetype])) {
    level.__ai_interface[archetype] = [];
  }
}

#namespace ai;

function createinterfaceforentity(entity) {
  if(!isDefined(entity.__interface)) {
    entity.__interface = [];
  }
}

function getaiattribute(entity, attribute) {
  ai_interface::_checkprerequisites(entity, attribute);

  if(!isDefined(entity.__interface[attribute])) {
    return level.__ai_interface[entity.archetype][attribute][#"default_value"];
  }

  return entity.__interface[attribute];
}

function hasaiattribute(entity, attribute) {
  return isDefined(entity) && isDefined(attribute) && isDefined(entity.archetype) && isDefined(level.__ai_interface) && isDefined(level.__ai_interface[entity.archetype]) && isDefined(level.__ai_interface[entity.archetype][attribute]);
}

function registerentityinterface(archetype, attribute, defaultvalue, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x434>" + archetype + "<dev string:x45f>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_entity";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isDefined(possiblevalues) || isarray(possiblevalues), "<dev string:x464>");

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x434>" + archetype + "<dev string:x45f>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_match";
  level.__ai_interface[archetype][attribute][#"values"] = possiblevalues;

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isDefined(minimum) || isint(minimum) || isfloat(minimum), "<dev string:x4ab>");
  assert(!isDefined(maximum) || isint(maximum) || isfloat(maximum), "<dev string:x4ec>");
  assert(!isDefined(minimum) && !isDefined(maximum) || isDefined(minimum) && isDefined(maximum), "<dev string:x52d>");
  assert(!isDefined(minimum) && !isDefined(maximum) || minimum <= maximum, "<dev string:x7d>" + attribute + "<dev string:x584>" + "<dev string:x5b0>");

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x434>" + archetype + "<dev string:x45f>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"max_value"] = maximum;
  level.__ai_interface[archetype][attribute][#"min_value"] = minimum;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_numeric";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x434>" + archetype + "<dev string:x45f>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_vector";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

function setaiattribute(entity, attribute, value) {
  ai_interface::_checkprerequisites(entity, attribute);
  ai_interface::_checkvalue(entity.archetype, attribute, value);

  oldvalue = entity.__interface[attribute];

  if(!isDefined(oldvalue)) {
    oldvalue = level.__ai_interface[entity.archetype][attribute][#"default_value"];
  }

  entity.__interface[attribute] = value;
  callback = level.__ai_interface[entity.archetype][attribute][#"callback"];

  if(isfunctionptr(callback)) {
    [[callback]](entity, attribute, oldvalue, value);
  }
}