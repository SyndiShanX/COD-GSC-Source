/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\vehicle_omnvar_utility.gsc
************************************************************/

vehomn_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  level.vehicle.omnvars = _id_962A30A9BB8C0F09;
  _id_962A30A9BB8C0F09.vehicledata = [];
}

vehomn_setvehicle(_id_7731ADEF63E19B0C, clients) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  id = _id_E2818AD39A3341B4.id;

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_vehicle", id);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_vehicle", id);
  }
}

vehomn_setcurrentseat(vehicle, _id_199B7EB356C9D5A9, _id_2C6CA80E296FED3A) {
  if(!isDefined(_id_2C6CA80E296FED3A)) {
    return;
  }
  _id_7731ADEF63E19B0C = vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();
  id = -1;

  if(isDefined(_id_7731ADEF63E19B0C)) {
    _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);

    if(isDefined(_id_199B7EB356C9D5A9)) {
      id = _id_E2818AD39A3341B4.seatids[_id_199B7EB356C9D5A9];

      if(istrue(_id_E2818AD39A3341B4._id_C0AC99D7D5E195A4) && _id_199B7EB356C9D5A9 != "gunner" && vehicle scripts\cp_mp\vehicles\vehicle_damage::_id_B9D5A379EB1AEFC7(_id_199B7EB356C9D5A9))
        id = id | 16;
    }
  }

  _id_2C6CA80E296FED3A setclientomnvar("ui_veh_current_seat", id);
}

vehomn_setnextseat(_id_7731ADEF63E19B0C, _id_199B7EB356C9D5A9, _id_2C6CA80E296FED3A) {
  if(!isDefined(_id_2C6CA80E296FED3A)) {
    return;
  }
  id = -1;

  if(isDefined(_id_199B7EB356C9D5A9)) {
    _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);
    id = _id_E2818AD39A3341B4.seatids[_id_199B7EB356C9D5A9];
  }

  _id_2C6CA80E296FED3A setclientomnvar("ui_veh_next_seat", id);
}

vehomn_setseatentity(_id_7731ADEF63E19B0C, _id_199B7EB356C9D5A9, _id_0005B0181BCD140F, clients) {
  id = -1;

  if(isDefined(_id_7731ADEF63E19B0C)) {
    _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);

    if(isDefined(_id_199B7EB356C9D5A9))
      id = _id_E2818AD39A3341B4.seatids[_id_199B7EB356C9D5A9];
  }

  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_occupant_0";
      break;
    case 1:
      omnvar = "ui_veh_occupant_1";
      break;
    case 2:
      omnvar = "ui_veh_occupant_2";
      break;
    case 3:
      omnvar = "ui_veh_occupant_3";
      break;
    case 4:
      omnvar = "ui_veh_occupant_4";
      break;
    case 5:
      omnvar = "ui_veh_occupant_5";
      break;
    case 6:
      omnvar = "ui_veh_occupant_6";
      break;
  }

  _id_8A36524E347D4AC2 = -1;

  if(isDefined(_id_0005B0181BCD140F))
    _id_8A36524E347D4AC2 = _id_0005B0181BCD140F getentitynumber();

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar(omnvar, _id_8A36524E347D4AC2);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar(omnvar, _id_8A36524E347D4AC2);
  }
}

vehomn_clearseatentity(_id_7731ADEF63E19B0C, _id_199B7EB356C9D5A9, clients) {
  vehomn_setseatentity(_id_7731ADEF63E19B0C, _id_199B7EB356C9D5A9, undefined, clients);
}

vehomn_sethealthpercent(_id_52616AAE7B55D981, clients) {
  if(!isDefined(_id_52616AAE7B55D981))
    _id_52616AAE7B55D981 = 0;

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_health_percent", int(_id_52616AAE7B55D981));
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_health_percent", int(_id_52616AAE7B55D981));
  }
}

vehomn_clearhealthpercent(clients) {
  vehomn_sethealthpercent(undefined, clients);
}

vehomn_showhealth(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_health", 1);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_show_health", 1);
  }
}

vehomn_hidehealth(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_health", 0);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_show_health", 0);
  }
}

vehomn_clearshowhealth(clients) {
  if(0)
    vehomn_showhealth(clients);
  else
    vehomn_hidehealth(clients);
}

vehomn_settimepercent(_id_03B0524215D2EAE6, clients) {
  if(!isDefined(_id_03B0524215D2EAE6))
    _id_03B0524215D2EAE6 = 0;

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_time_percent", int(_id_03B0524215D2EAE6));
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_time_percent", int(_id_03B0524215D2EAE6));
  }
}

vehomn_cleartimepercent(clients) {
  vehomn_settimepercent(undefined, clients);
}

vehomn_showtime(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_time", 1);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_show_time", 1);
  }
}

vehomn_hidetime(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_time", 0);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_show_time", 0);
  }
}

vehomn_clearshowtime(clients) {
  if(0)
    vehomn_showtime(clients);
  else
    vehomn_hidetime(clients);
}

_id_9DA76B0BE4B2A2D4(_id_61F3B8F68D8B872E, _id_29F1EA79ED2B40DD) {
  _id_A38D9412E2699429 = _id_F1C6C7FA7CC97826(_id_61F3B8F68D8B872E, _id_29F1EA79ED2B40DD);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self);
  vehomn_setfuelpercent(_id_A38D9412E2699429, occupants);
}

_id_272F4112182763BD(player, _id_61F3B8F68D8B872E, _id_29F1EA79ED2B40DD) {
  _id_A38D9412E2699429 = _id_F1C6C7FA7CC97826(_id_61F3B8F68D8B872E, _id_29F1EA79ED2B40DD);
  vehomn_setfuelpercent(_id_A38D9412E2699429, player);
}

_id_F1C6C7FA7CC97826(_id_61F3B8F68D8B872E, _id_29F1EA79ED2B40DD) {
  if(!isDefined(_id_61F3B8F68D8B872E))
    _id_61F3B8F68D8B872E = self._id_CF9BA498AF4E41E9;

  if(!isDefined(_id_29F1EA79ED2B40DD))
    _id_29F1EA79ED2B40DD = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(self.vehiclename)._id_29F1EA79ED2B40DD;

  return _id_61F3B8F68D8B872E / _id_29F1EA79ED2B40DD * 100;
}

vehomn_setfuelpercent(_id_15174A10ECA23D37, clients) {
  if(!isDefined(_id_15174A10ECA23D37))
    _id_15174A10ECA23D37 = 0;

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_fuel_percent", int(_id_15174A10ECA23D37));
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_fuel_percent", int(_id_15174A10ECA23D37));
  }
}

vehomn_clearfuelpercent(clients) {}

vehomn_showfuel(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_fuel", 1);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar("ui_veh_show_fuel", 1);
  }
}

vehomn_hidefuel(clients) {}

vehomn_clearshowfuel(clients) {}

vehomn_setammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, _id_1A947AFA7B4C8960, clients) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  id = _id_E2818AD39A3341B4.ammoids[_id_0F8C397F70608ABC];
  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_ammo_0";
      break;
    case 1:
      omnvar = "ui_veh_ammo_1";
      break;
    case 2:
      omnvar = "ui_veh_ammo_2";
      break;
  }

  if(!isDefined(_id_1A947AFA7B4C8960))
    _id_1A947AFA7B4C8960 = -1;
  else if(isstring(_id_1A947AFA7B4C8960) && _id_1A947AFA7B4C8960 == "infinite")
    _id_1A947AFA7B4C8960 = -2;

  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar(omnvar, _id_1A947AFA7B4C8960);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar(omnvar, _id_1A947AFA7B4C8960);
  }
}

vehomn_clearammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, clients) {
  vehomn_setammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, undefined, clients);
}

vehomn_showammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, _id_1A947AFA7B4C8960, clients) {
  vehomn_setammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, _id_1A947AFA7B4C8960, clients);
}

vehomn_hideammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, clients) {
  vehomn_setammo(_id_7731ADEF63E19B0C, _id_0F8C397F70608ABC, -1, clients);
}

vehomn_showwarning(_id_FDE9DA7FDAD4045C, clients, _id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);
  id = _id_E2818AD39A3341B4.warningbits[_id_FDE9DA7FDAD4045C];

  if(isDefined(clients)) {
    _id_721785E70A9BF412 = _id_E2818AD39A3341B4.warningstartcallbacks[_id_FDE9DA7FDAD4045C];

    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A setclientomnvarbit("ui_veh_warning", id, 1);

          if(isDefined(_id_721785E70A9BF412))
            thread[[_id_721785E70A9BF412]](_id_2C6CA80E296FED3A, "ui_veh_warning_omnvar_modified");
        }
      }
    } else if(isPlayer(clients)) {
      clients setclientomnvarbit("ui_veh_warning", id, 1);

      if(isDefined(_id_721785E70A9BF412))
        thread[[_id_721785E70A9BF412]](clients, "ui_veh_warning_omnvar_modified");
    }
  }
}

vehomn_hidewarning(_id_FDE9DA7FDAD4045C, clients, _id_7731ADEF63E19B0C) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C, 1);
  id = _id_E2818AD39A3341B4.warningbits[_id_FDE9DA7FDAD4045C];

  if(isDefined(clients)) {
    _id_4D7F98747CAAC78B = _id_E2818AD39A3341B4.warningendcallbacks[_id_FDE9DA7FDAD4045C];

    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A setclientomnvarbit("ui_veh_warning", id, 0);

          if(isDefined(_id_4D7F98747CAAC78B))
            thread[[_id_4D7F98747CAAC78B]](_id_2C6CA80E296FED3A, "ui_veh_warning_omnvar_modified");
        }
      }
    } else if(isPlayer(clients)) {
      clients setclientomnvarbit("ui_veh_warning", id, 0);

      if(isDefined(_id_4D7F98747CAAC78B))
        thread[[_id_4D7F98747CAAC78B]](clients, "ui_veh_warning_omnvar_modified");
    }
  }
}

vehomn_clearwarnings(clients, _id_7731ADEF63E19B0C) {
  if(isDefined(clients)) {
    _id_E2818AD39A3341B4 = undefined;

    if(isDefined(_id_7731ADEF63E19B0C))
      _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C, undefined, 1);

    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_warning", 0);
          _id_6F848816A946E419(_id_2C6CA80E296FED3A);

          if(isDefined(_id_E2818AD39A3341B4)) {
            foreach(_id_FDF4854FD7B654E7 in _id_E2818AD39A3341B4.warningclearcallbacks) {
              if(isDefined(_id_FDF4854FD7B654E7))
                thread[[_id_FDF4854FD7B654E7]](_id_2C6CA80E296FED3A);
            }
          }
        }
      }
    } else if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_warning", 0);
      _id_6F848816A946E419(clients);

      if(isDefined(_id_E2818AD39A3341B4)) {
        foreach(_id_FDF4854FD7B654E7 in _id_E2818AD39A3341B4.warningclearcallbacks) {
          if(isDefined(_id_FDF4854FD7B654E7))
            thread[[_id_FDF4854FD7B654E7]](clients);
        }
      }
    }
  }
}

_id_6F848816A946E419(_id_2C6CA80E296FED3A) {
  if(soundexists("uin_veh_warning_low_fuel"))
    _id_2C6CA80E296FED3A stoplocalsound("uin_veh_warning_low_fuel");

  if(soundexists("uin_veh_warning_low_fuel_heli"))
    _id_2C6CA80E296FED3A stoplocalsound("uin_veh_warning_low_fuel_heli");

  if(soundexists("uin_veh_warning_out_of_fuel"))
    _id_2C6CA80E296FED3A stoplocalsound("uin_veh_warning_out_of_fuel");

  if(soundexists("uin_veh_warning_out_of_fuel_heli"))
    _id_2C6CA80E296FED3A stoplocalsound("uin_veh_warning_out_of_fuel_heli");

  if(soundexists("veh_warning_missile_locking"))
    _id_2C6CA80E296FED3A stoplocalsound("veh_warning_missile_locking");

  if(soundexists("veh_warning_missile_incoming"))
    _id_2C6CA80E296FED3A stoplocalsound("veh_warning_missile_incoming");
}

vehomn_setrotation(_id_7731ADEF63E19B0C, _id_BEE205645342BF4C, _id_ACCD63D76646AE90, clients) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C);
  id = _id_E2818AD39A3341B4.rotationids[_id_BEE205645342BF4C];
  omnvar = undefined;

  switch (id) {
    case 0:
      omnvar = "ui_veh_degrees_0";
      break;
    case 1:
      omnvar = "ui_veh_degrees_1";
      break;
  }

  if(!isDefined(_id_ACCD63D76646AE90))
    _id_ACCD63D76646AE90 = 0;

  if(isDefined(clients)) {
    _id_02C0DC6323DDFA44 = _id_ACCD63D76646AE90 - floor(_id_ACCD63D76646AE90);

    if(_id_02C0DC6323DDFA44 >= 0.5)
      _id_ACCD63D76646AE90 = ceil(_id_ACCD63D76646AE90);
    else
      _id_ACCD63D76646AE90 = floor(_id_ACCD63D76646AE90);

    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          _id_2C6CA80E296FED3A setclientomnvar(omnvar, _id_ACCD63D76646AE90);
      }
    } else if(isPlayer(clients))
      clients setclientomnvar(omnvar, _id_ACCD63D76646AE90);
  }
}

vehomn_clearrotation(_id_7731ADEF63E19B0C, _id_BEE205645342BF4C, clients) {
  vehomn_setrotation(_id_7731ADEF63E19B0C, _id_BEE205645342BF4C, undefined, clients);
}

vehomn_showcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A notify("vehOmn_modified_controls");
          _id_2C6CA80E296FED3A.vehomncontrols = "show";
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_controls", 1);
        }
      }
    } else if(isPlayer(clients)) {
      clients notify("vehOmn_modified_controls");
      clients.vehomncontrols = "show";
      clients setclientomnvar("ui_veh_controls", 1);
    }
  }
}

vehomn_hidecontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A notify("vehOmn_modified_controls");
          _id_2C6CA80E296FED3A.vehomncontrols = "hide";
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_controls", 0);
        }
      }
    } else if(isPlayer(clients)) {
      clients notify("vehOmn_modified_controls");
      clients.vehomncontrols = "hide";
      clients setclientomnvar("ui_veh_controls", 0);
    }
  }
}

vehomn_fadeoutcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A))
          thread vehomn_fadeoutcontrolsforclient(_id_2C6CA80E296FED3A);
      }
    } else if(isPlayer(clients))
      thread vehomn_fadeoutcontrolsforclient(clients);
  }
}

vehomn_fadeoutcontrolsforclient(_id_2C6CA80E296FED3A) {
  _id_2C6CA80E296FED3A endon("death_or_disconnect");
  _id_2C6CA80E296FED3A endon("vehOmn_modified_controls");

  if(!isDefined(_id_2C6CA80E296FED3A.vehomncontrols) || _id_2C6CA80E296FED3A.vehomncontrols != "hide" && _id_2C6CA80E296FED3A.vehomncontrols != "fadeOut") {
    _id_2C6CA80E296FED3A.vehomncontrols = "fadeOut";
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_controls", 2);
    wait 3;
    thread vehomn_hidecontrols(_id_2C6CA80E296FED3A);
  }
}

vehomn_clearcontrols(clients) {
  if(isDefined(clients)) {
    if(isarray(clients)) {
      foreach(_id_2C6CA80E296FED3A in clients) {
        if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
          _id_2C6CA80E296FED3A.vehomncontrols = undefined;
          _id_2C6CA80E296FED3A setclientomnvar("ui_veh_controls", 0);
        }
      }
    } else if(isPlayer(clients)) {
      clients setclientomnvar("ui_veh_controls", 0);
      clients.vehomncontrols = undefined;
    }
  }
}

vehomn_controlsarefadedoutorhidden(_id_2C6CA80E296FED3A) {
  return !isDefined(_id_2C6CA80E296FED3A.vehomncontrols) || _id_2C6CA80E296FED3A.vehomncontrols == "fadeOut" || _id_2C6CA80E296FED3A.vehomncontrols == "hide";
}

vehomn_getleveldata() {
  return level.vehicle.omnvars;
}

vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).occupancy) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).occupancy.seatids))) {
    data = undefined;

    if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);
    else
      data = spawnStruct();

    if(!isDefined(data.occupancy))
      data.occupancy = spawnStruct();

    data.occupancy.seatids = [];
    data.occupancy.ammoids = [];
    data.occupancy.rotationids = [];
    data.occupancy.warningbits = [];
    data.occupancy.warningstartcallbacks = [];
    data.occupancy.warningendcallbacks = [];
    data.occupancy.warningclearcallbacks = [];
    data.occupancy.rotationrefsbyseatandweapon = [];
    data.occupancy.warningbits["burningDown"] = 1;
    data.occupancy.warningbits["missileLocking"] = 2;
    data.occupancy.warningbits["missileIncoming"] = 4;
    data.occupancy.warningbits["movementDisabled"] = 3;
    data.occupancy.warningbits["outOfFuel"] = 6;
    data.occupancy.warningbits["lowFuel"] = 5;
    data.occupancy.warningbits["BunkerBusterAttached"] = 7;
    data.occupancy.warningbits["shockStickAttached"] = 8;
    data.occupancy.warningbits["DDoSed"] = 9;
    data.occupancy.warningbits["locked"] = 10;
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).occupancy;
}

vehomn_clearleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667);

  if(isDefined(_id_E2818AD39A3341B4)) {
    _id_E2818AD39A3341B4.seatids = [];
    _id_E2818AD39A3341B4.ammoids = [];
    _id_E2818AD39A3341B4.rotationids = [];
    _id_E2818AD39A3341B4.warningbits = [];
    _id_E2818AD39A3341B4.warningstartcallbacks = [];
    _id_E2818AD39A3341B4.warningendcallbacks = [];
    _id_E2818AD39A3341B4.warningclearcallbacks = [];
    _id_E2818AD39A3341B4.id = undefined;
  }

  return _id_E2818AD39A3341B4;
}

vehomn_clearall(clients, _id_7731ADEF63E19B0C) {
  if(isarray(clients)) {
    foreach(_id_2C6CA80E296FED3A in clients)
    vehomn_clearallinternal(_id_2C6CA80E296FED3A, _id_7731ADEF63E19B0C);
  } else
    vehomn_clearallinternal(clients, _id_7731ADEF63E19B0C);
}

vehomn_clearallinternal(_id_2C6CA80E296FED3A, _id_7731ADEF63E19B0C) {
  if(isDefined(_id_2C6CA80E296FED3A) && isPlayer(_id_2C6CA80E296FED3A)) {
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_vehicle", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_current_seat", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_next_seat", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_0", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_1", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_2", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_3", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_4", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_5", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_occupant_6", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_health_percent", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_health", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_time_percent", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_time", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_fuel_percent", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_show_fuel", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_ammo_0", -1);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_ammo_1", -1);
    vehomn_clearwarnings(_id_2C6CA80E296FED3A, _id_7731ADEF63E19B0C);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_degrees_0", 0);
    _id_2C6CA80E296FED3A setclientomnvar("ui_veh_degrees_1", 0);
    vehomn_clearcontrols(_id_2C6CA80E296FED3A);
  }
}

vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, player) {
  vehomn_setvehicle(vehicle.vehiclename, player);
  vehomn_setcurrentseat(vehicle, _id_7558F98F3236963D, player);
  _id_94D4410A7169A784 = "uin_veh_warning_low_fuel";
  _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel";

  if(istrue(vehicle scripts\common\vehicle::ishelicopter())) {
    _id_94D4410A7169A784 = "uin_veh_warning_low_fuel_heli";
    _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel_heli";
  }

  _id_6FDBC1BB50C4D774 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle);

  if(isDefined(_id_FC7C7A874B43A31A))
    vehomn_clearseatentity(vehicle.vehiclename, _id_FC7C7A874B43A31A, _id_6FDBC1BB50C4D774);
  else {
    foreach(seatid, _id_F85572CD5F6117C6 in scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle)) {
      if(isDefined(_id_F85572CD5F6117C6) && _id_F85572CD5F6117C6 != player)
        vehomn_setseatentity(vehicle.vehiclename, seatid, _id_F85572CD5F6117C6, player);
    }
  }

  vehomn_setseatentity(vehicle.vehiclename, _id_7558F98F3236963D, player, _id_6FDBC1BB50C4D774);
  vehomn_updatenextseatomnvars(vehicle);

  if(vehicle.health < vehicle.maxhealth)
    vehomn_updateomnvarsondamage(vehicle);

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_A717A31AE35BA01C() && isDefined(vehicle._id_CF9BA498AF4E41E9)) {
    vehicle vehomn_showfuel(player);
    vehicle _id_272F4112182763BD(player);
  }

  vehomn_showcontrols(player);
  veh_updateomnvarsperframeforclient(vehicle, player, _id_7558F98F3236963D);
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(istrue(vehicle._id_15C05FE1C0F6DE03)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["BunkerBusterAttached"]))
      vehomn_showwarning("BunkerBusterAttached", player, vehicle.vehiclename);
  }

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(vehicle)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["missileLocking"]))
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(vehicle)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["missileIncoming"]))
      vehomn_showwarning("missileIncoming", player, vehicle.vehiclename);
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(vehicle)) {
    if(istrue(vehicle.islocked)) {
      if(isDefined(_id_E2818AD39A3341B4.warningbits["locked"]))
        vehomn_showwarning("locked", player, vehicle.vehiclename);
    } else if(vehicle scripts\cp_mp\emp_debuff::is_empd())
      vehomn_showwarning("DDoSed", player, vehicle.vehiclename);
    else if(isDefined(vehicle._id_CF9BA498AF4E41E9) && vehicle._id_CF9BA498AF4E41E9 <= 0 && isDefined(_id_E2818AD39A3341B4.warningbits["outOfFuel"]))
      vehomn_showwarning("outOfFuel", player, vehicle.vehiclename);
    else if(isDefined(_id_E2818AD39A3341B4.warningbits["movementDisabled"]))
      vehomn_showwarning("movementDisabled", player, vehicle.vehiclename);

    if(soundexists(_id_85DFCE1880D8E71D) && !isDefined(_id_FC7C7A874B43A31A)) {
      player stoplocalsound(_id_85DFCE1880D8E71D);
      player playlocalsound(_id_85DFCE1880D8E71D);
    }
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["burningDown"]))
      vehomn_showwarning("burningDown", player, vehicle.vehiclename);
  }

  if(isDefined(vehicle._id_CF9BA498AF4E41E9) && vehicle._id_CF9BA498AF4E41E9 <= 25 && vehicle._id_CF9BA498AF4E41E9 > 0) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["lowFuel"])) {
      vehomn_showwarning("lowFuel", player, vehicle.vehiclename);

      if(soundexists(_id_85DFCE1880D8E71D) && !isDefined(_id_FC7C7A874B43A31A)) {
        player stoplocalsound(_id_94D4410A7169A784);
        player playlocalsound(_id_94D4410A7169A784);
      }
    }
  }
}

_id_D2D9C09551D91164(vehicle, player) {
  vehomn_setvehicle(vehicle.vehiclename, player);
  _id_94D4410A7169A784 = "uin_veh_warning_low_fuel";
  _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel";

  foreach(seatid, _id_F85572CD5F6117C6 in scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle)) {
    if(isDefined(_id_F85572CD5F6117C6) && _id_F85572CD5F6117C6 != player)
      vehomn_setseatentity(vehicle.vehiclename, seatid, _id_F85572CD5F6117C6, player);
  }

  if(istrue(scripts\common\vehicle::ishelicopter())) {
    _id_94D4410A7169A784 = "uin_veh_warning_low_fuel_heli";
    _id_85DFCE1880D8E71D = "uin_veh_warning_out_of_fuel_heli";
  }

  if(vehicle.health < vehicle.maxhealth)
    vehomn_updateomnvarsondamage(vehicle);

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_A717A31AE35BA01C() && isDefined(vehicle._id_CF9BA498AF4E41E9)) {
    vehicle vehomn_showfuel(player);
    vehicle _id_272F4112182763BD(player);
  }

  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(scripts\cp_mp\utility\weapon_utility::_id_F18DBD353F3E1570(vehicle)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["missileLocking"]))
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
  }

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(vehicle)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["missileLocking"]))
      vehomn_showwarning("missileLocking", player, vehicle.vehiclename);
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(vehicle)) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["missileIncoming"]))
      vehomn_showwarning("missileIncoming", player, vehicle.vehiclename);
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(vehicle)) {
    if(istrue(vehicle.islocked)) {
      if(isDefined(_id_E2818AD39A3341B4.warningbits["locked"]))
        vehomn_showwarning("locked", player, vehicle.vehiclename);
    } else if(vehicle scripts\cp_mp\emp_debuff::is_empd())
      vehomn_showwarning("DDoSed", player, vehicle.vehiclename);
    else if(isDefined(vehicle._id_CF9BA498AF4E41E9) && vehicle._id_CF9BA498AF4E41E9 <= 0 && isDefined(_id_E2818AD39A3341B4.warningbits["outOfFuel"])) {
      vehomn_showwarning("outOfFuel", player, vehicle.vehiclename);

      if(soundexists(_id_85DFCE1880D8E71D))
        player playlocalsound(_id_85DFCE1880D8E71D);
    } else if(isDefined(_id_E2818AD39A3341B4.warningbits["movementDisabled"]))
      vehomn_showwarning("movementDisabled", player, vehicle.vehiclename);
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown()) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["burningDown"]))
      vehomn_showwarning("burningDown", player, vehicle.vehiclename);
  }

  if(isDefined(vehicle._id_CF9BA498AF4E41E9) && vehicle._id_CF9BA498AF4E41E9 <= 25 && vehicle._id_CF9BA498AF4E41E9 > 0) {
    if(isDefined(_id_E2818AD39A3341B4.warningbits["lowFuel"])) {
      vehomn_showwarning("lowFuel", player, vehicle.vehiclename);

      if(soundexists(_id_94D4410A7169A784))
        player playlocalsound(_id_94D4410A7169A784);
    }
  }
}

vehomn_updateomnvarsonseatexit(vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, player) {
  if(!isDefined(_id_7558F98F3236963D)) {
    if(isDefined(_id_FC7C7A874B43A31A)) {
      vehomn_clearall(player, vehicle.vehiclename);

      if(isDefined(vehicle)) {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle);
        vehomn_clearseatentity(vehicle.vehiclename, _id_FC7C7A874B43A31A, occupants);
        vehomn_updatenextseatomnvars(vehicle);
      }
    }
  }
}

_id_5211953231A09ED5(vehicle, player) {
  vehomn_clearall(player, vehicle.vehiclename);
}

vehomn_updateomnvarsondamage(vehicle, data) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);

  if(!isDefined(data))
    _id_559A0810819CF4F0 = int(clamp(vehicle.health / vehicle.maxhealth * 100, 0, 100));
  else
    _id_559A0810819CF4F0 = int(clamp((vehicle.health - data.damage) / vehicle.maxhealth * 100, 0, 100));

  vehomn_showhealth(occupants);
  vehomn_sethealthpercent(_id_559A0810819CF4F0, occupants);
}

vehomn_updateomnvarsperframe(vehicle, data) {
  if(!isDefined(data))
    data = spawnStruct();

  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(vehicle.vehiclename, undefined, 1);
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle);

  if(isDefined(occupants) && isDefined(_id_E2818AD39A3341B4)) {
    if(isDefined(occupants) && occupants.size > 0) {
      foreach(seatid, _id_F85572CD5F6117C6 in occupants) {
        if(isDefined(_id_F85572CD5F6117C6) && isPlayer(_id_F85572CD5F6117C6) && _id_F85572CD5F6117C6 scripts\cp_mp\utility\player_utility::_isalive())
          veh_updateomnvarsperframeforclient(vehicle, _id_F85572CD5F6117C6, seatid, data);
      }
    }
  }
}

veh_updateomnvarsperframeforclient(vehicle, _id_2C6CA80E296FED3A, seatid, data) {
  if(!isDefined(seatid))
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(vehicle, _id_2C6CA80E296FED3A);

  vehomn_updaterotationomnvarsperframeforclient(vehicle, _id_2C6CA80E296FED3A, seatid, data);
}

vehomn_updatenextseatomnvars(vehicle) {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

  foreach(seatid, _id_F85572CD5F6117C6 in occupants) {
    _id_9B1113F768B290D8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat(vehicle, _id_F85572CD5F6117C6, seatid);
    vehomn_setnextseat(vehicle.vehiclename, _id_9B1113F768B290D8, _id_F85572CD5F6117C6);
  }
}

vehomn_updaterotationomnvarsperframeforclient(vehicle, _id_2C6CA80E296FED3A, seatid, data) {
  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(vehicle.vehiclename);

  if(_id_E2818AD39A3341B4.rotationrefsbyseatandweapon.size > 0 && isDefined(_id_E2818AD39A3341B4.rotationrefsbyseatandweapon[seatid])) {
    _id_48449F38D385A654 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat(vehicle, seatid);
    _id_0C50B485A43752FD = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(vehicle.vehiclename, seatid);

    if(_id_48449F38D385A654) {
      if(isDefined(vehicle.objweapon)) {
        _id_BEE205645342BF4C = _id_E2818AD39A3341B4.rotationrefsbyseatandweapon[seatid][vehicle.objweapon.basename];

        if(isDefined(_id_BEE205645342BF4C)) {
          _id_451362A0C7F69E04 = invertangles(_id_2C6CA80E296FED3A getplayerangles());
          angles = vehicle.angles;
          _id_FAA27D4E426C646A = combineangles(_id_451362A0C7F69E04, angles);
          _id_F409375EBE2A27EC = angleclamp(_id_FAA27D4E426C646A[1]);
          vehomn_setrotation(vehicle.vehiclename, _id_BEE205645342BF4C, _id_F409375EBE2A27EC, _id_2C6CA80E296FED3A);
        }
      }
    } else {}

    _id_D22F47766862A420 = vehomn_getrotationentangles(vehicle, data);

    if(isDefined(_id_D22F47766862A420)) {
      foreach(weaponname, _id_BEE205645342BF4C in _id_E2818AD39A3341B4.rotationrefsbyseatandweapon[seatid]) {
        _id_FAA27D4E426C646A = _id_D22F47766862A420[weaponname];

        if(isDefined(_id_FAA27D4E426C646A)) {
          _id_F409375EBE2A27EC = angleclamp(_id_FAA27D4E426C646A[1]);
          vehomn_setrotation(vehicle.vehiclename, _id_BEE205645342BF4C, _id_F409375EBE2A27EC, _id_2C6CA80E296FED3A);
        }
      }
    }
  }
}

vehomn_getrotationentangles(vehicle, data) {
  if(isDefined(data) && isDefined(data.localangles))
    return data.rotationentangles;

  _id_E2818AD39A3341B4 = vehomn_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), 1);
  ents = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(vehicle);

  if(isDefined(_id_E2818AD39A3341B4._id_5A086ECCE9CE54AE) && isDefined(vehicle gettagorigin("tag_flash")))
    ents[_id_E2818AD39A3341B4._id_5A086ECCE9CE54AE] = vehicle;

  if(isDefined(ents) && ents.size > 0) {
    _id_FAA27D4E426C646A = [];
    _id_3199BD878B193472 = invertangles(vehicle.angles);

    foreach(weaponname, ent in ents)
    _id_FAA27D4E426C646A[weaponname] = combineangles(_id_3199BD878B193472, ent gettagangles("tag_flash"));

    if(isDefined(data))
      data.rotationentangles = _id_FAA27D4E426C646A;

    return _id_FAA27D4E426C646A;
  }

  return undefined;
}