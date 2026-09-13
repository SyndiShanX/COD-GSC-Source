/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\equipment.gsc
***********************************************/

get_mine_ignore_list() {
  ignorelist = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders)
    ignorelist[ignorelist.size] = struct.ents[0];
  }

  linkedents = self getlinkedchildren(1);

  if(!isDefined(linkedents))
    linkedents = [];

  linkedents[linkedents.size] = self getlinkedparent();

  foreach(linkedent in linkedents) {
    if(isDefined(linkedent) && linkedent.classname == "grenade")
      ignorelist[ignorelist.size] = linkedent;
  }

  return ignorelist;
}

get_sticky_grenade_destination(grenade, _id_F432E8F2C3B65BAD, _id_76831D64528B6D31, _id_8DF3FF6D9DB28011, fusetime, data) {
  grenade endon("death");

  if(!isDefined(data))
    data = spawnStruct();

  if(!isDefined(data.contents))
    data.contents = get_grenade_cast_contents();

  if(!isDefined(data.divisions))
    data.divisions = 5;

  if(!isDefined(data.amortize))
    data.amortize = 1;

  if(!isDefined(data.ignorelist))
    data.ignorelist = [grenade, grenade.owner];

  if(!isDefined(data.ignorclutter))
    data.ignoreclutter = 1;

  if(!isDefined(fusetime))
    fusetime = 10;

  if(!isDefined(data.maxtime))
    data.maxtime = fusetime - fusetime * grenade.tickpercent;

  _id_46BCCF24774BA912 = data.maxtime / data.divisions;
  times[0] = 0;
  _id_E4B7E99A96C8829F[0] = grenade.origin;
  _id_CBE776EFC22487C7 = data.divisions;
  _id_198A19F5087C274D = anglesToForward(_id_F432E8F2C3B65BAD);
  _id_6DEA3F838287BDED = (0, 0, 1);
  vel = _id_198A19F5087C274D * _id_76831D64528B6D31 + _id_6DEA3F838287BDED * _id_8DF3FF6D9DB28011;
  _id_71B049FF6296DC2F = _id_6DEA3F838287BDED * vectordot(_id_6DEA3F838287BDED, vel);
  _id_60CECC5D1218A89E = vel - _id_71B049FF6296DC2F;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < data.divisions; _id_AC0E594AC96AA3A8++) {
    _id_B1EA6E95CD5257DD = times[_id_AC0E594AC96AA3A8 - 1];
    _id_CD5F2EF778B5875F = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8 - 1];
    nexttime = _id_AC0E594AC96AA3A8 * _id_46BCCF24774BA912;
    _id_3E6B57D717B688D8 = _id_60CECC5D1218A89E * nexttime;
    _id_46DE56D5EB869951 = _id_71B049FF6296DC2F * nexttime + (0, 0, -400) * nexttime * nexttime;
    _id_AC1DA71286DBEADF = _id_E4B7E99A96C8829F[0] + _id_3E6B57D717B688D8 + _id_46DE56D5EB869951;
    times[_id_AC0E594AC96AA3A8] = nexttime;
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = _id_AC1DA71286DBEADF;
    results = physics_raycast(_id_CD5F2EF778B5875F, _id_AC1DA71286DBEADF, data.contents, data.ignorelist, 1, "physicsquery_closest", data.ignoreclutter);

    if(isDefined(results) && results.size > 0) {
      data.destination = results[0]["position"];
      data.destinationnormal = results[0]["normal"];
      data.destinationentity = results[0]["entity"];
      data.destinationhit = 1;
      _id_EC7B20B1054D5D98 = _id_AC1DA71286DBEADF - _id_CD5F2EF778B5875F;
      _id_5805327F64D62D38 = length(_id_EC7B20B1054D5D98);
      _id_35EBF7955EC217CF = _id_EC7B20B1054D5D98 / _id_5805327F64D62D38;
      _id_75C0B9C719A5FC05 = _id_CD5F2EF778B5875F - data.destination;
      _id_59D191507790C7C9 = vectordot(_id_35EBF7955EC217CF, _id_75C0B9C719A5FC05);
      _id_FB921BEB20AA928D = clamp(_id_59D191507790C7C9 / _id_5805327F64D62D38, 0, 1);
      data.destinationtime = _id_B1EA6E95CD5257DD + _id_46BCCF24774BA912 * _id_FB921BEB20AA928D;
      break;
    } else if(_id_AC0E594AC96AA3A8 == data.divisions - 1) {
      data.destination = _id_AC1DA71286DBEADF;
      break;
    }

    if(data.amortize)
      waitframe();
  }

  return data;
}

get_grenade_cast_contents(_id_AAFB624F1DD4F653) {
  contents = undefined;

  if(istrue(_id_AAFB624F1DD4F653))
    contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy"]);
  else
    contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  return contents;
}

plant(grenade, data) {
  self endon("death_or_disconnect");
  grenade endon("death");
  grenade.releasegrenadeorigin = grenade.origin;
  grenade.releaseownerorigin = self.origin;
  grenade.releaseownereye = self getEye();
  grenade.releaseownerangles = self getgunangles();

  if(!isDefined(data.plantmaxtime))
    data.plantmaxtime = 0.5;

  if(!isDefined(data.plantmaxroll))
    data.plantmaxroll = 0;

  if(!isDefined(data.plantmindistbeloweye))
    data.plantmindistbeloweye = 12;

  if(!isDefined(data.plantmaxdistbelowownerfeet))
    data.plantmaxdistbelowownerfeet = 20;

  if(!isDefined(data.plantmindisteyetofeet))
    data.plantmindisteyetofeet = 45;

  if(!isDefined(data.plantnormalcos))
    data.plantnormalcos = 0.342;

  if(!isDefined(data.plantoffsetz))
    data.plantoffsetz = 1;

  plant_watch_stuck(grenade, data);
  _id_6EB1CCFDF22D82B7 = 0;
  position = data.notifyorigin;
  normal = data.notifynormal;
  _id_BF8E5F003146AF44 = data.notifyentity;
  _id_7DBDA545F37B475F = data.notifyhit;
  angles = undefined;

  if(!istrue(_id_7DBDA545F37B475F)) {
    position = data.calcorigin;
    normal = data.calcnormal;
    _id_BF8E5F003146AF44 = data.calcentity;
    _id_7DBDA545F37B475F = data.calchit;

    if(istrue(_id_7DBDA545F37B475F) && isDefined(_id_BF8E5F003146AF44) && _id_BF8E5F003146AF44 getnonstick())
      _id_7DBDA545F37B475F = undefined;

    contents = get_grenade_cast_contents(0);
    ignorelist = [grenade];
    caststart = self getEye() - (0, 0, 30);
    castend = caststart + anglesToForward(self getplayerangles(1)) * 20;
    results = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

    if(isDefined(results) && results.size > 0)
      _id_7DBDA545F37B475F = 0;
  } else
    angles = plant_clamp_angles(grenade.angles, data);

  if(istrue(_id_7DBDA545F37B475F)) {
    if(isDefined(normal) && vectordot(normal, (0, 0, 1)) < data.plantnormalcos)
      _id_6EB1CCFDF22D82B7 = 1;
    else {
      _id_F4EF78DE9CF3220A = vectordot(grenade.releaseownerorigin - position, (0, 0, 1));

      if(_id_F4EF78DE9CF3220A > 0) {
        if(_id_F4EF78DE9CF3220A > data.plantmaxdistbelowownerfeet)
          _id_6EB1CCFDF22D82B7 = 1;
      } else {
        _id_89CC128C05B322D1 = vectordot(grenade.releaseownereye - grenade.releaseownerorigin, (0, 0, 1));

        if(_id_89CC128C05B322D1 > data.plantmindisteyetofeet) {
          _id_AB4DB4E369E3FB13 = vectordot(grenade.releaseownereye - position, (0, 0, 1));

          if(_id_AB4DB4E369E3FB13 >= 0) {
            if(_id_AB4DB4E369E3FB13 < data.plantmindistbeloweye)
              _id_6EB1CCFDF22D82B7 = 1;
          } else
            _id_6EB1CCFDF22D82B7 = 1;
        }
      }
    }
  } else
    _id_6EB1CCFDF22D82B7 = 1;

  if(_id_6EB1CCFDF22D82B7) {
    contents = data.castcontents;

    if(!isDefined(contents))
      contents = get_grenade_cast_contents();

    ignorelist = [grenade];
    caststart = grenade.releaseownerorigin + (0, 0, 1);
    castend = caststart + (0, 0, -1 * data.plantmaxdistbelowownerfeet);
    results = physics_raycast(caststart, castend, contents, ignorelist, 1, "physicsquery_closest", 1);

    if(isDefined(results) && results.size > 0) {
      position = results[0]["position"];
      normal = results[0]["normal"];

      if(isDefined(normal) && vectordot(normal, (0, 0, 1)) < data.plantnormalcos)
        return 0;

      _id_28B3F77BB0070F33 = grenade.releaseownerangles * (0, 1, 0);

      if(isDefined(normal)) {
        angles = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(_id_28B3F77BB0070F33), normal);
        angles = plant_clamp_angles(angles, data);
      } else
        angles = _id_28B3F77BB0070F33;

      position = position + anglestoup(angles) * data.plantoffsetz;
      _id_BF8E5F003146AF44 = results[0]["entity"];
      grenade dontinterpolate();
      grenade.origin = position;
      grenade.angles = angles;
    } else
      return 0;
  } else {
    if(!isDefined(angles)) {
      _id_28B3F77BB0070F33 = grenade.releaseownerangles * (0, 1, 0);

      if(isDefined(normal)) {
        angles = scripts\mp\utility\script::vectortoanglessafe(anglesToForward(_id_28B3F77BB0070F33), normal);
        angles = plant_clamp_angles(angles, data);
      } else
        angles = _id_28B3F77BB0070F33;
    }

    position = position + anglestoup(angles) * data.plantoffsetz;
    grenade dontinterpolate();
    grenade.origin = position;
    grenade.angles = angles;
  }

  if(isDefined(_id_BF8E5F003146AF44))
    grenade linkTo(_id_BF8E5F003146AF44);

  return 1;
}

plant_watch_stuck(grenade, data) {
  childthread plant_watch_stuck_notify(grenade, data);
  childthread plant_watch_stuck_calculate(grenade, data);
  childthread plant_watch_stuck_timeout(grenade, data);
  data waittill("start_race");
  waittillframeend;
  data notify("end_race");
  return data;
}

plant_watch_stuck_notify(grenade, data) {
  data endon("end_race");
  grenade waittill("missile_stuck", stuckto);
  data.notifyorigin = grenade.origin;
  data.notifyangles = grenade.angles;
  data.notifyentity = stuckto;
  data.notifyhit = 1;
  data notify("start_race");
}

plant_watch_stuck_calculate(grenade, data) {
  data endon("end_race");
  data = get_sticky_grenade_destination(grenade, grenade.releaseownerangles, data.throwspeedforward, data.throwspeedup, data.castmaxtime, data);
  data.calcorigin = data.destination;
  data.calcnormal = data.destinationnormal;
  data.calcentity = data.destinationentity;
  data.calchit = data.destinationhit;
}

plant_watch_stuck_timeout(grenade, data) {
  data endon("end_race");
  wait(data.plantmaxtime);
  data notify("start_race");
}

plant_clamp_angles(angles, data) {
  pitch = 0;
  yaw = angles[1];
  roll = scripts\engine\utility::ter_op(data.plantmaxroll != 0, angles[2], 0);

  if(roll != 0) {
    if(roll > 0)
      roll = clamp(angles[2], 0, data.plantmaxroll);
    else
      roll = clamp(angles[2], -1 * data.plantmaxroll, 0);
  }

  return (pitch, yaw, roll);
}

watch_flight_collision() {
  _id_33A41321E4AD6EC3 = self.origin;

  for(;;) {
    self waittill("touching_platform", _id_36C12D04A03471D6);

    if(isDefined(_id_36C12D04A03471D6) && self istouching(_id_36C12D04A03471D6) && self.origin[2] - _id_33A41321E4AD6EC3[2] > 12) {
      self notify("collision_with_platform");
      return;
    }
  }
}