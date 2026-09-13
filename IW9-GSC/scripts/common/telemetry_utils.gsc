/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\telemetry_utils.gsc
***********************************************/

_id_AACBBE63C26687AE(callback, func) {
  if(!isDefined(level._id_EC2C9117BD4B336B))
    level._id_EC2C9117BD4B336B = [];

  if(!isDefined(level._id_EC2C9117BD4B336B[callback]))
    level._id_EC2C9117BD4B336B[callback] = [];

  level._id_EC2C9117BD4B336B[callback][level._id_EC2C9117BD4B336B[callback].size] = func;
}

_id_9CE94B15EE6758EE(callback) {
  if(!isDefined(level._id_EC2C9117BD4B336B))
    return 0;

  if(!isDefined(level._id_EC2C9117BD4B336B[callback]))
    return 0;

  return 1;
}

_id_80820D6D364C1836(callback, data) {
  if(!_id_9CE94B15EE6758EE(callback)) {
    return;
  }
  if(isDefined(data)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_EC2C9117BD4B336B[callback].size; _id_AC0E594AC96AA3A8++)
      thread[[level._id_EC2C9117BD4B336B[callback][_id_AC0E594AC96AA3A8]]](data);
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_EC2C9117BD4B336B[callback].size; _id_AC0E594AC96AA3A8++)
      thread[[level._id_EC2C9117BD4B336B[callback][_id_AC0E594AC96AA3A8]]]();
  }
}

_id_1B15450E092933CF(basetime) {
  _id_FBDCFBD6233E2398 = basetime;

  if(isDefined(level.starttimefrommatchstart)) {
    _id_FBDCFBD6233E2398 = _id_FBDCFBD6233E2398 - level.starttimefrommatchstart;

    if(_id_FBDCFBD6233E2398 < 0)
      _id_FBDCFBD6233E2398 = 0;
  } else
    _id_FBDCFBD6233E2398 = 0;

  return _id_FBDCFBD6233E2398;
}

_id_50989A55805A440B() {
  _id_D3513ADD1F8263D7 = self playermounttype();

  if(isDefined(_id_D3513ADD1F8263D7)) {
    switch (_id_D3513ADD1F8263D7) {
      case "mount_left":
        return "MOUNT_LEFT";
      case "mount_right":
        return "MOUNT_RIGHT";
      case "mount_top":
        return "MOUNT_TOP";
    }
  }

  return "MOUNT_NONE";
}

_id_0892570944F6B6A2(_id_2C6CA80E296FED3A) {
  if(istrue(game["isLaunchChunk"]))
    return 0;

  if(!isDefined(_id_2C6CA80E296FED3A))
    return 0;
  else if(isagent(_id_2C6CA80E296FED3A))
    return 0;
  else if(!isPlayer(_id_2C6CA80E296FED3A))
    return 0;

  return 1;
}

_id_4B974D822D418A06(data) {
  if(!isDefined(data.player))
    return 0;

  if(!isDefined(data.player.pers))
    return 0;

  if(!isDefined(data.player.pers["telemetry"]))
    return 0;

  if(!isDefined(data.player.pers["telemetry"].life))
    return 0;

  return 1;
}

get_objective_type() {
  _id_3985F515E9F06D2C = "hub";

  if(isDefined(level.active_objectives_string))
    _id_3985F515E9F06D2C = level.active_objectives_string;
  else if(isDefined(level._id_A1C29F4029327195) && isDefined(level._id_A1C29F4029327195._id_1EF9D4ABEA418A7E)) {
    instance = level._id_A1C29F4029327195._id_1EF9D4ABEA418A7E;
    location = instance.targetname;

    if(isDefined(location))
      _id_3985F515E9F06D2C = location;
  } else if(isDefined(level._id_9FF590CA18F468B8))
    _id_3985F515E9F06D2C = level._id_9FF590CA18F468B8;

  return _id_3985F515E9F06D2C;
}

_id_0FF48D255C865806(_id_2C6CA80E296FED3A) {
  if(_id_0892570944F6B6A2(_id_2C6CA80E296FED3A))
    return _id_2C6CA80E296FED3A.clientid < level.maxlogclients;
  else
    return 0;
}

_id_B3FDF4781A09F420(player) {
  if(_id_0892570944F6B6A2(player) && !isbot(player) && getdvarint("dvar_5E2F0F222E2D7721") > 0) {
    _id_686DBB21602462E9 = player _meth_3A4B2D02238B8EE7();
    return _id_686DBB21602462E9 >= getdvarint("dvar_5E2F0F222E2D7721") * 1000;
  }

  return 0;
}

_id_766155419D15C501(player) {
  if(!_id_B3FDF4781A09F420(player) && player.pers["telemetry"]._id_7FF2028C00F8827D == 0)
    player.pers["telemetry"]._id_7FF2028C00F8827D = 1;
}

_id_86D327084EEBF87A(value) {
  if(!isDefined(value) || !isfloat(value))
    value = -1000000.0;

  return value;
}