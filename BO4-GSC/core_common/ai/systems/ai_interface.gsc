/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\ai_interface.gsc
***************************************************/

#namespace ai_interface;

autoexec main() {
  level.__ai_debuginterface = getdvarint(#"ai_debuginterface", 0);
}

private _checkvalue(archetype, attributename, value) {
  attribute = level.__ai_interface[archetype][attributename];

  switch (attribute[#"type"]) {
    case #"_interface_entity":
      break;
    case #"_interface_match":
      possiblevalues = attribute[#"values"];
      assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "<dev string:x38>" + value + "<dev string:x40>" + attributename + "<dev string:x75>");
      break;
    case #"_interface_numeric":
      maxvalue = attribute[#"max_value"];
      minvalue = attribute[#"min_value"];
      assert(isint(value) || isfloat(value), "<dev string:x7a>" + attributename + "<dev string:x8c>" + value + "<dev string:xaf>");
      assert(!isDefined(maxvalue) && !isDefined(minvalue) || value <= maxvalue && value >= minvalue, "<dev string:x38>" + value + "<dev string:xc5>" + minvalue + "<dev string:xeb>" + maxvalue + "<dev string:xef>");
      break;
    case #"_interface_vector":
      if(isDefined(value)) {
        assert(isvec(value), "<dev string:x7a>" + attributename + "<dev string:xf4>" + value + "<dev string:xaf>");
      }

      break;
    default:
      assert("<dev string:x116>" + attribute[#"type"] + "<dev string:x138>" + attributename + "<dev string:x75>");
      break;
  }
}

private _checkprerequisites(entity, attribute) {
  if(isDefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
    assert(isentity(entity) || isstruct(entity), "<dev string:x14c>");
    assert(isactor(entity) || isvehicle(entity) || isstruct(entity) || isbot(entity), "<dev string:x17e>");
    assert(isstring(attribute), "<dev string:x1ba>");
    assert(isarray(entity.__interface), "<dev string:x1e5>" + function_9e72a96(entity.archetype) + "<dev string:x1f3>" + "<dev string:x226>");
    assert(isarray(level.__ai_interface), "<dev string:x257>");
    assert(isarray(level.__ai_interface[entity.archetype]), "<dev string:x2a2>" + function_9e72a96(entity.archetype) + "<dev string:x2c6>");
    assert(isarray(level.__ai_interface[entity.archetype][attribute]), "<dev string:x7a>" + attribute + "<dev string:x2e0>" + function_9e72a96(entity.archetype) + "<dev string:x30c>");
    assert(isstring(level.__ai_interface[entity.archetype][attribute][#"type"]), "<dev string:x315>" + attribute + "<dev string:x75>");
  }
}

private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
  assert(ishash(archetype), "<dev string:x33d>");
  assert(ishash(attribute), "<dev string:x382>");
  assert(!isDefined(callbackfunction) || isfunctionptr(callbackfunction), "<dev string:x3c7>");
}

private _initializelevelinterface(archetype) {
  if(!isDefined(level.__ai_interface)) {
    level.__ai_interface = [];
  }

  if(!isDefined(level.__ai_interface[archetype])) {
    level.__ai_interface[archetype] = [];
  }
}

#namespace ai;

createinterfaceforentity(entity) {
  if(!isDefined(entity.__interface)) {
    entity.__interface = [];
  }
}

getaiattribute(entity, attribute) {
  ai_interface::_checkprerequisites(entity, attribute);

  if(!isDefined(entity.__interface[attribute])) {
    return level.__ai_interface[entity.archetype][attribute][#"default_value"];
  }

  return entity.__interface[attribute];
}

hasaiattribute(entity, attribute) {
  return isDefined(entity) && isDefined(attribute) && isDefined(entity.archetype) && isDefined(level.__ai_interface) && isDefined(level.__ai_interface[entity.archetype]) && isDefined(level.__ai_interface[entity.archetype][attribute]);
}

registerentityinterface(archetype, attribute, defaultvalue, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x419>" + archetype + "<dev string:x443>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_entity";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isDefined(possiblevalues) || isarray(possiblevalues), "<dev string:x447>");

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x419>" + archetype + "<dev string:x443>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_match";
  level.__ai_interface[archetype][attribute][#"values"] = possiblevalues;

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
  assert(!isDefined(minimum) || isint(minimum) || isfloat(minimum), "<dev string:x48d>");
  assert(!isDefined(maximum) || isint(maximum) || isfloat(maximum), "<dev string:x4cd>");
  assert(!isDefined(minimum) && !isDefined(maximum) || isDefined(minimum) && isDefined(maximum), "<dev string:x50d>");
  assert(!isDefined(minimum) && !isDefined(maximum) || minimum <= maximum, "<dev string:x7a>" + attribute + "<dev string:x563>" + "<dev string:x58e>");

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x419>" + archetype + "<dev string:x443>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"max_value"] = maximum;
  level.__ai_interface[archetype][attribute][#"min_value"] = minimum;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_numeric";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
  ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);

  ai_interface::_initializelevelinterface(archetype);
  assert(!isDefined(level.__ai_interface[archetype][attribute]), "<dev string:x38>" + attribute + "<dev string:x419>" + archetype + "<dev string:x443>");
  level.__ai_interface[archetype][attribute] = [];
  level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
  level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
  level.__ai_interface[archetype][attribute][#"type"] = "_interface_vector";

  ai_interface::_checkvalue(archetype, attribute, defaultvalue);
}

setaiattribute(entity, attribute, value) {
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