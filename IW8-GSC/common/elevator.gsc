/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\elevator.gsc
***********************************************/

init() {
  if(getDvar("_encstr_8F6D16E68DE4FACA8D95D985D1DEE4AF8C5ACDB0261B598C") == "_encstr_A34C02BB") {
    return;
  }
  var_0 = getEntArray("_encstr_93E80F65C95123AE1990C329E82D6567AB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0.size) {
    return;
  }
  precachestring(&"_encstr_97B31354981595288A7A497D1A50C498FA2425E415");
  precachestring(&"_encstr_A7CA12DDF52BECCFD1612DBE5D47DFE1F3894DDB");
  precachestring(&"_encstr_8D4F1BD013CFCB9993FF1F287D0CE7C921F9628B40756D2991E077FD73");
  thread elevator_update_global_dvars();
  level.elevators = [];
  level.elevator_callbutton_link_v = elevator_get_dvar_int("_encstr_A5E91FA7CF63E8603C0F934973171020AA2F611153BBC5B047A5BEE0DCCEE07893", "_encstr_970703271B");
  level.elevator_callbutton_link_h = elevator_get_dvar_int("_encstr_97E91F07D0838F82016D7BB6CDDF2B474938F3E370DBFCDB6FF009EDBBF5F23F70", "_encstr_A1180464A91B");
  build_elevators();
  position_elevators();
  elevator_call();

  if(!level.elevators.size) {
    return;
  }
  foreach(var_2 in level.elevators) {
    var_2 thread elevator_think();
    var_2 thread elevator_sound_think();
  }

  thread elevator_debug();
}

elevator_update_global_dvars() {
  for(;;) {
    level.elevator_accel = elevator_get_dvar("_encstr_84B913E61BE4BEB2B159D9C2E8B74EFAB08D8D56D8", "_encstr_8C18042292A3");
    level.elevator_decel = elevator_get_dvar("_encstr_A36C13E66CE4BEB236AC3BB0477B39F5462BD82B1B", "_encstr_8C18042292A3");
    level.elevator_music = elevator_get_dvar_int("_encstr_93EF1367B0E3EFE2610D5B96ED3FCBA7A8B8EF9758", "_encstr_A34C02BB");
    level.elevator_speed = elevator_get_dvar_int("_encstr_A95113B9C639D7598D2BCE588EF693D7E60E95B219", "_encstr_970703271B");
    level.elevator_innerdoorspeed = elevator_get_dvar_int("_encstr_886A1C60F6F2F82D0CEF1CC9A30FD51143EEB203AE756F277357DBA5ADD3", "_encstr_8B070326D0");
    level.elevator_outterdoorspeed = elevator_get_dvar_int("_encstr_BD9F1DFF56AB189302D5F031B3B028A938333BFC2B1A04888D4B4BCFE518E1", "_encstr_A5070398D8");
    level.elevator_return = elevator_get_dvar_int("_encstr_82AC148231C8070279839BBFD9903B4F9059FB8B8BC0", "_encstr_934C0218");
    level.elevator_waittime = elevator_get_dvar_int("_encstr_A2D9166EC6C9AF95B1569D583AEDC9BEBBC2B43A1D5A5BAC", "_encstr_8F4C026A");
    level.elevator_aggressive_call = elevator_get_dvar_int("_encstr_920D1D620E2531AD40F80367481872F9DB94EFDAE58F4BF96B90AF67089054", "_encstr_934C0218");
    level.elevator_debug = elevator_get_dvar_int("_encstr_979E0F2791284D4280E3938FFDB7BB9F70", "_encstr_934C0218");

    if(scripts\common\utility::issp())
      level.elevator_motion_detection = elevator_get_dvar_int("_encstr_817A1E6348B599DFC88D4E511DF0DBD123909B5AC0754113C16D254B35D86725", "_encstr_934C0218");
    else
      level.elevator_motion_detection = elevator_get_dvar_int("_encstr_817A1E6348B599DFC88D4E511DF0DBD123909B5AC0754113C16D254B35D86725", "_encstr_A34C02BB");

    wait 1;
  }
}

elevator_think() {
  elevator_fsm("_encstr_AC1A0427D1D9");
}

elevator_call() {
  foreach(var_1 in level.elevator_callbuttons)
  var_1 thread monitor_callbutton();
}

floor_override(var_0) {
  self endon("_encstr_86111032E8D5B336D0A7F2D74BE03B178821");
  self.floor_override = 0;
  self.overrider = undefined;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self.floor_override = 1;
    self.overrider = var_1;
    break;
  }

  self notify("_encstr_91900F1AF0C83F1A714FEEC54D20E45B65");
}

elevator_fsm(var_0) {
  self.estate = var_0;
  var_1 = get_housing_door_trigger();
  var_2 = get_housing_inside_trigger();

  for(;;) {
    if(self.estate == "_encstr_AC1A0427D1D9") {
      if(level.elevator_return && get_curfloor() != get_initfloor()) {
        self.moveto_floor = get_initfloor();
        thread floor_override(var_2);
        waittill_or_timeout("_encstr_91900F1AF0C83F1A714FEEC54D20E45B65", level.elevator_waittime);

        if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider))
          get_floor(self.overrider);

        self.estate = "_encstr_AF1A044FA5B1";
        continue;
      }

      for(;;) {
        if(self.moveto_floor == get_curfloor())
          var_3 = var_2 discrete_waittill("_encstr_8F5C086405E70FBA4B4A");
        else
          var_3 = "_encstr_B6D51082B01B534F4B08CAEF16B1239DB348";

        if(isstring(var_3) && var_3 == "_encstr_B6D51082B01B534F4B08CAEF16B1239DB348" && self.moveto_floor != get_curfloor()) {
          self.estate = "_encstr_AF1A044FA5B1";
          break;
        }

        if(isDefined(var_3) && isPlayer(var_3) && isalive(var_3)) {
          var_4 = var_3 istouching(var_2);
          var_5 = isDefined(var_2.motion_trigger) && var_3 istouching(var_2.motion_trigger);
          var_6 = var_4 || var_5;

          if(var_6) {
            var_7 = var_3;
            get_floor(var_7);

            if(self.moveto_floor == get_curfloor()) {
              continue;
            }
            self.estate = "_encstr_AF1A044FA5B1";
            break;
          }
        }
      }
    }

    if(self.estate == "_encstr_AF1A044FA5B1") {
      thread elevator_interrupt(var_1);
      var_8 = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(var_8);
      scripts\engine\utility::_id_143A5("_encstr_962F131BC6EDE656C8BE5AE6CD5993D732BDBD27E6", "_encstr_8DFD0C4F986395D31D451A13A5E9");

      if(self.elevator_interrupted) {
        self.estate = "_encstr_8A1A0419B113";
        continue;
      }

      self.estate = "_encstr_861A04DA11AE";
      continue;
    }

    if(self.estate == "_encstr_8A1A0419B113") {
      var_8 = get_curfloor();
      thread open_inner_doors();
      thread open_outer_doors(var_8);
      self waittill("_encstr_B42A0E77E210A0BBE45768B8425063F8" + var_8 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");

      if(self.elevator_interrupted) {
        self.estate = "_encstr_AF1A044FA5B1";
        continue;
      }

      self.estate = "_encstr_AC1A0427D1D9";
      continue;
    }

    if(self.estate == "_encstr_861A04DA11AE") {
      if(self.moveto_floor != get_curfloor()) {
        thread elevator_move(self.moveto_floor);
        self waittill("_encstr_AB2E0FA91D6DB8BF53A7C59787CA7C7804");
      }

      self.estate = "_encstr_8A1A0419B113";
      continue;
    }
  }
}

monitor_callbutton() {
  for(;;) {
    var_0 = discrete_waittill("_encstr_8F5C086405E70FBA4B4A");
    var_1 = undefined;
    var_2 = [];

    foreach(var_5, var_4 in self.e) {
      var_1 = var_5;
      var_2 = var_4;
    }

    var_6 = 0;

    foreach(var_8 in var_2) {
      var_9 = var_8 elevator_floor_update();

      if(!level.elevator_aggressive_call && !var_9) {
        if(var_8 get_curfloor() == var_1) {
          var_6 = 1;
          var_2 = [];
          break;
        }
      }
    }

    foreach(var_8 in var_2) {
      if(var_8.estate == "_encstr_AC1A0427D1D9") {
        var_8 call_elevator(var_1);
        var_6 = 1;

        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(var_6)
      self playSound("_encstr_9A590F63C4FF103013C28D0889E3D32897");
  }
}

call_elevator(var_0) {
  self.moveto_floor = var_0;
  var_1 = get_housing_inside_trigger();
  var_1 notify("_encstr_8F5C086405E70FBA4B4A", "_encstr_B6D51082B01B534F4B08CAEF16B1239DB348");

  if(level.elevator_motion_detection)
    var_1.motion_trigger notify("_encstr_8F5C086405E70FBA4B4A", "_encstr_B6D51082B01B534F4B08CAEF16B1239DB348");
}

get_floor(var_0) {
  var_1 = get_outer_doorsets();

  if(var_1.size == 2) {
    var_2 = get_curfloor();
    self.moveto_floor = !var_2;
    return;
  }

  var_0 setclientdvar("_encstr_A16D15502931FF4FF5F132AB600D876B4B18CEF43098AB", get_curfloor());

  for(;;) {
    var_0 waittill("_encstr_A22C0DDA2BCD5793AC9B83ED73B9B2", var_3, var_4);

    if(var_3 == "_encstr_AA37184DF12BB3B70DD063B99969D7AD102FD3D519F83E2BB86B") {
      if(var_4 != "_encstr_8BBA05185F8B99")
        self.moveto_floor = int(var_4);

      break;
    }
  }
}

elevator_interrupt(var_0) {
  self notify("_encstr_B6A9105ACD3ACA9327BAC1D1D7BB581D1BD0");
  level notify("_encstr_8D4621F798AF23BA494D507F60DEEDB11392729BE072FB736D9FAD51430E2ABF33BDC9");
  self endon("_encstr_B6A9105ACD3ACA9327BAC1D1D7BB581D1BD0");
  self endon("_encstr_86111032E8D5B336D0A7F2D74BE03B178821");
  self.elevator_interrupted = 0;
  wait 0.5;
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
  self notify("_encstr_8DFD0C4F986395D31D451A13A5E9");
  self.elevator_interrupted = 1;
}

elevator_floor_update() {
  var_0 = get_housing_mainframe();
  var_1 = var_0.origin;
  var_2 = 1;

  foreach(var_6, var_4 in get_outer_doorsets()) {
    var_5 = self.e["_encstr_9BA90699C67BDBC9" + var_6 + "_encstr_99430541EA7FD3"];

    if(var_1 == var_5) {
      self.e["_encstr_933B0ED8AE93932BDC3AF533C6DBDB4E"] = var_6;
      var_2 = 0;
    }
  }

  return var_2;
}

elevator_sound_think() {
  var_0 = get_housing_musak_model();

  if(level.elevator_music && isDefined(var_0))
    var_0 playLoopSound("_encstr_9A7110F5B92153515BD0437A38E755FFD81F");

  thread listen_for("_encstr_A6991419B2CFD620FD07E78326A5181E674A10EDFB07");
  thread listen_for("_encstr_87E314F60795B95ADCD9EB5ADCB9CA93AF467BF69CDC");
  thread listen_for("_encstr_962F131BC6EDE656C8BE5AE6CD5993D732BDBD27E6");
  thread listen_for("_encstr_A64F13E7486F409DBBD130D8EA97CE11C7BF1F55D3");

  foreach(var_3, var_2 in get_outer_doorsets()) {
    thread listen_for("_encstr_91D10FB185CF3BDA73B42FC0697F7A9AB1" + var_3 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
    thread listen_for("_encstr_9B420F0F3A6256A12D6298A6C0EF58DA27" + var_3 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
    thread listen_for("_encstr_AD570E9EE088EF49538109E828AF0646" + var_3 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
    thread listen_for("_encstr_B42A0E77E210A0BBE45768B8425063F8" + var_3 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  }

  thread listen_for("_encstr_8DFD0C4F986395D31D451A13A5E9");
  thread listen_for("_encstr_86111032E8D5B336D0A7F2D74BE03B178821");
  thread listen_for("_encstr_AB2E0FA91D6DB8BF53A7C59787CA7C7804");
}

listen_for(var_0) {
  for(;;) {
    self waittill(var_0);
    var_1 = get_housing_mainframe();

    if(issubstr(var_0, "_encstr_969A099833EF13AB92B7C8"))
      var_1 playSound("_encstr_BA0910D78DA0FE714DA7CFA3DFE68A2FA889");

    if(issubstr(var_0, "_encstr_BA1A099F132B4DF0455A3F"))
      var_1 playSound("_encstr_AA6D0FD35391EB269D28875636603BE708");

    if(var_0 == "_encstr_86111032E8D5B336D0A7F2D74BE03B178821") {
      var_1 playSound("_encstr_93DC0F56C6563BAFE4AE9B7DE6E8B0C947");
      var_1 playLoopSound("_encstr_91DC0EACB12BD9AF9CAECDFA63EDBDE0");
    }

    if(var_0 == "_encstr_8DFD0C4F986395D31D451A13A5E9")
      var_1 playSound("_encstr_8A8713F3546F8080BBD2F05BF9A7C04887A22B51D4");

    if(var_0 == "_encstr_AB2E0FA91D6DB8BF53A7C59787CA7C7804") {
      var_1 stoploopsound("_encstr_91DC0EACB12BD9AF9CAECDFA63EDBDE0");
      var_1 playSound("_encstr_96EE0D2B63959DAF9CAEE6F5CA9B23");
      var_1 playSound("_encstr_9A590F63C4FF103013C28D0889E3D32897");
    }
  }
}

position_elevators() {
  foreach(var_5, var_1 in level.elevators) {
    var_1.moveto_floor = var_1 get_curfloor();

    foreach(var_4, var_3 in var_1 get_outer_doorsets()) {
      if(var_1 get_curfloor() != var_4)
        var_1 thread close_outer_doors(var_4);
    }
  }
}

elevator_move(var_0) {
  self notify("_encstr_86111032E8D5B336D0A7F2D74BE03B178821");
  self endon("_encstr_86111032E8D5B336D0A7F2D74BE03B178821");
  var_1 = get_housing_mainframe();
  var_2 = self.e["_encstr_9BA90699C67BDBC9" + var_0 + "_encstr_99430541EA7FD3"] - var_1.origin;
  var_3 = level.elevator_speed;
  var_4 = abs(distance(self.e["_encstr_9BA90699C67BDBC9" + var_0 + "_encstr_99430541EA7FD3"], var_1.origin));
  var_5 = var_4 / var_3;
  var_1 moveTo(var_1.origin + var_2, var_5, var_5 * level.elevator_accel, var_5 * level.elevator_decel);

  foreach(var_7 in get_housing_children()) {
    var_8 = var_7.origin + var_2;

    if(!issubstr(var_7.classname, "_encstr_99EA0963DBD25FE4D146C7")) {
      var_7 moveTo(var_8, var_5, var_5 * level.elevator_accel, var_5 * level.elevator_decel);
      continue;
    }

    var_7.origin = var_8;
  }

  waittill_finish_moving(var_1, self.e["_encstr_9BA90699C67BDBC9" + var_0 + "_encstr_99430541EA7FD3"]);
  self notify("_encstr_AB2E0FA91D6DB8BF53A7C59787CA7C7804");
}

close_inner_doors() {
  self notify("_encstr_A6991419B2CFD620FD07E78326A5181E674A10EDFB07");
  self endon("_encstr_A6991419B2CFD620FD07E78326A5181E674A10EDFB07");
  self endon("_encstr_87E314F60795B95ADCD9EB5ADCB9CA93AF467BF69CDC");
  var_0 = get_housing_leftdoor();
  var_1 = get_housing_rightdoor();
  var_2 = get_housing_mainframe();
  var_3 = get_housing_closedpos();
  var_4 = (var_3[0], var_3[1], var_2.origin[2]);
  var_5 = level.elevator_innerdoorspeed;
  var_6 = abs(distance(var_0.origin, var_4));
  var_7 = var_6 / var_5;
  var_0 moveTo(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_1 moveTo(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  waittill_finish_moving(var_0, var_4, var_1, var_4);
  self notify("_encstr_962F131BC6EDE656C8BE5AE6CD5993D732BDBD27E6");
}

open_inner_doors() {
  self notify("_encstr_87E314F60795B95ADCD9EB5ADCB9CA93AF467BF69CDC");
  self endon("_encstr_87E314F60795B95ADCD9EB5ADCB9CA93AF467BF69CDC");
  var_0 = get_housing_leftdoor();
  var_1 = get_housing_rightdoor();
  var_2 = get_housing_mainframe();
  var_3 = get_housing_leftdoor_opened_pos();
  var_4 = get_housing_rightdoor_opened_pos();
  var_5 = (var_3[0], var_3[1], var_2.origin[2]);
  var_6 = (var_4[0], var_4[1], var_2.origin[2]);
  var_7 = level.elevator_innerdoorspeed;
  var_8 = abs(distance(var_5, var_6) * 0.5);
  var_9 = var_8 / var_7 * 0.5;
  var_0 moveTo(var_5, var_9, var_9 * 0.1, var_9 * 0.25);
  var_1 moveTo(var_6, var_9, var_9 * 0.1, var_9 * 0.25);
  waittill_finish_moving(var_0, var_5, var_1, var_6);
  self notify("_encstr_A64F13E7486F409DBBD130D8EA97CE11C7BF1F55D3");
}

close_outer_doors(var_0) {
  self notify("_encstr_91D10FB185CF3BDA73B42FC0697F7A9AB1" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  self endon("_encstr_91D10FB185CF3BDA73B42FC0697F7A9AB1" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  self endon("_encstr_9B420F0F3A6256A12D6298A6C0EF58DA27" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  var_1 = get_outer_leftdoor(var_0);
  var_2 = get_outer_rightdoor(var_0);
  var_3 = get_outer_leftdoor_openedpos(var_0);
  var_4 = get_outer_closedpos(var_0);
  var_5 = level.elevator_outterdoorspeed;
  var_6 = abs(distance(var_3, var_4));
  var_7 = var_6 / var_5;
  var_1 moveTo(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_2 moveTo(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  waittill_finish_moving(var_1, var_4, var_2, var_4);
  self notify("_encstr_AD570E9EE088EF49538109E828AF0646" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
}

open_outer_doors(var_0) {
  level notify("_encstr_850817AFE185535188C882C1817897CB666F7F736BB8EA0668");
  self notify("_encstr_9B420F0F3A6256A12D6298A6C0EF58DA27" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  self endon("_encstr_9B420F0F3A6256A12D6298A6C0EF58DA27" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
  var_1 = get_outer_leftdoor(var_0);
  var_2 = get_outer_rightdoor(var_0);
  var_3 = get_outer_leftdoor_openedpos(var_0);
  var_4 = get_outer_rightdoor_openedpos(var_0);
  var_5 = get_outer_closedpos(var_0);
  var_6 = level.elevator_outterdoorspeed;
  var_7 = abs(distance(var_3, var_5));
  var_8 = var_7 / var_6 * 0.5;
  var_1 moveTo(var_3, var_8, var_8 * 0.1, var_8 * 0.25);
  var_2 moveTo(var_4, var_8, var_8 * 0.1, var_8 * 0.25);
  waittill_finish_moving(var_1, var_3, var_2, var_4);
  self notify("_encstr_B42A0E77E210A0BBE45768B8425063F8" + var_0 + "_encstr_864B0D37E7DB20CDB381E188AA9BFE");
}

build_elevators() {
  var_0 = getEntArray("_encstr_93E80F65C95123AE1990C329E82D6567AB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_9A4C11250991E36ED95003E950D7A33FC8E0AF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_BD7411AD11E05357ED30C3197948B78AB8FB34", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_0) {
    var_5 = getEnt(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_6 = [];
    var_6[0] = min(var_4.origin[0], var_5.origin[0]);
    var_6[1] = max(var_4.origin[0], var_5.origin[0]);
    var_6[2] = min(var_4.origin[1], var_5.origin[1]);
    var_6[3] = max(var_4.origin[1], var_5.origin[1]);
    var_7 = spawnStruct();
    var_7.e["_encstr_840703024B"] = level.elevators.size;
    var_7.e["_encstr_ADE108D8220776805DA7"] = [];
    var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"] = [];

    foreach(var_9 in var_1) {
      if(var_9 isinbound(var_6)) {
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"][var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"].size] = var_9;

        if(var_9.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
          continue;
        }
        if(var_9.code_classname == "_encstr_8FA906CC80677438") {
          continue;
        }
        var_10 = getEnt(var_9.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_86D70AC81F2EE8E012E7BF8D"] = var_10;
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"] = var_10.origin;
        var_11 = getEnt(var_10.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_A1DC0B152B72B391C801C81583"] = var_11;
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"] = var_11.origin;
        var_12 = (var_10.origin - var_11.origin) * (0.5, 0.5, 0.5) + var_11.origin;
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_88151003E878EA696791756A0D012190ED60"] = var_12;
        var_13 = getEnt(var_11.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_88DF0DB9B070F3F740222B488745E5"] = var_13;
        var_14 = getEnt(var_13.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_ADE108D8220776805DA7"]["_encstr_86BF0FD07A4273293FEF8D86A14F31236A"] = var_14;
        var_14 make_discrete_trigger();
        var_14.motion_trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_9.origin, 0, 64, 128);
      }
    }

    var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"] = [];

    foreach(var_17 in var_2) {
      if(var_17 isinbound(var_6)) {
        var_18 = isDefined(var_17.script_noteworthy) && var_17.script_noteworthy == "_encstr_A2091406D407D30BDF39E0A0C33921288F48158B3EFF";
        var_19 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"].size;
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19] = [];
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_88151003E878EA696791756A0D012190ED60"] = var_17.origin;
        var_20 = getEnt(var_17.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_86D70AC81F2EE8E012E7BF8D"] = var_20;
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"] = var_20.origin;
        var_21 = getEnt(var_20.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_A1DC0B152B72B391C801C81583"] = var_21;
        var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"] = var_21.origin;

        if(var_18) {
          var_22 = var_17.origin - var_20.origin;
          var_17.origin = var_20.origin;
          var_20.origin = var_20.origin + var_22;
          var_21.origin = var_21.origin - var_22;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_88151003E878EA696791756A0D012190ED60"] = var_17.origin;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"] = var_20.origin;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_19]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"] = var_21.origin;
        }
      }
    }

    for(var_24 = 0; var_24 < var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"].size - 1; var_24++) {
      for(var_25 = 0; var_25 < var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"].size - 1 - var_24; var_25++) {
        if(var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_88151003E878EA696791756A0D012190ED60"][2] < var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_88151003E878EA696791756A0D012190ED60"][2]) {
          var_26 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_86D70AC81F2EE8E012E7BF8D"];
          var_27 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"];
          var_28 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_A1DC0B152B72B391C801C81583"];
          var_29 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"];
          var_30 = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_88151003E878EA696791756A0D012190ED60"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_86D70AC81F2EE8E012E7BF8D"] = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_86D70AC81F2EE8E012E7BF8D"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"] = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_A1DC0B152B72B391C801C81583"] = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_A1DC0B152B72B391C801C81583"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"] = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25]["_encstr_88151003E878EA696791756A0D012190ED60"] = var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_88151003E878EA696791756A0D012190ED60"];
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_86D70AC81F2EE8E012E7BF8D"] = var_26;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"] = var_27;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_A1DC0B152B72B391C801C81583"] = var_28;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"] = var_29;
          var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_25 + 1]["_encstr_88151003E878EA696791756A0D012190ED60"] = var_30;
        }
      }
    }

    var_31 = [];

    foreach(var_24, var_33 in var_7.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"]) {
      var_34 = var_7 get_housing_mainframe();
      var_31 = (var_34.origin[0], var_34.origin[1], var_33["_encstr_88151003E878EA696791756A0D012190ED60"][2]);
      var_7.e["_encstr_9BA90699C67BDBC9" + var_24 + "_encstr_99430541EA7FD3"] = var_31;

      if(var_34.origin == var_31) {
        var_7.e["_encstr_B45D0E09BD287BCFDFF889E28D201F32"] = var_24;
        var_7.e["_encstr_933B0ED8AE93932BDC3AF533C6DBDB4E"] = var_24;
      }
    }

    level.elevators[level.elevators.size] = var_7;
    var_4 delete();
    var_5 delete();
  }

  foreach(var_17 in var_2)
  var_17 delete();

  build_call_buttons();

  if(!level.elevator_motion_detection)
    setup_hints();

  foreach(var_39 in level.elevators) {
    var_40 = var_39 get_housing_primarylight();

    if(isDefined(var_40) && var_40.size) {
      foreach(var_42 in var_40)
      var_42 setlightintensity(0.75);
    }
  }
}

build_call_buttons() {
  level.elevator_callbuttons = getEntArray("_encstr_84D20E7A48E3BBA793A062574ED95BC5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.elevator_callbuttons) {
    var_1.e = [];
    var_2 = (0, 0, var_1.origin[2]);
    var_3 = (var_1.origin[0], var_1.origin[1], 0);
    var_4 = [];

    foreach(var_12, var_6 in level.elevators) {
      foreach(var_11, var_8 in var_6 get_outer_doorsets()) {
        var_9 = (0, 0, var_6.e["_encstr_9BA90699C67BDBC9" + var_11 + "_encstr_99430541EA7FD3"][2]);
        var_10 = (var_6.e["_encstr_9BA90699C67BDBC9" + var_11 + "_encstr_99430541EA7FD3"][0], var_6.e["_encstr_9BA90699C67BDBC9" + var_11 + "_encstr_99430541EA7FD3"][1], 0);

        if(abs(distance(var_2, var_9)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(var_3, var_10)) <= level.elevator_callbutton_link_h) {
            var_4[var_4.size] = var_6;
            var_1.e[var_11] = var_4;
          }
        }
      }
    }

    var_1 make_discrete_trigger();
    var_1.motion_trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin + (0, 0, -32), 0, 32, 64);
  }
}

setup_hints() {
  foreach(var_1 in level.elevators) {
    var_2 = var_1 get_housing_inside_trigger();
    var_3 = var_1 get_outer_doorsets();
    var_4 = var_3.size;
    var_2 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

    if(var_4 > 2) {
      var_2 setHintString(&"_encstr_8D4F1BD013CFCB9993FF1F287D0CE7C921F9628B40756D2991E077FD73");
      continue;
    }

    var_2 setHintString(&"_encstr_A7CA12DDF52BECCFD1612DBE5D47DFE1F3894DDB");
  }

  foreach(var_7 in level.elevator_callbuttons) {
    var_7 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    var_7 setHintString(&"_encstr_97B31354981595288A7A497D1A50C498FA2425E415");
  }
}

make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

discrete_waittill(var_0) {
  enable_trigger();

  if(level.elevator_motion_detection)
    self.motion_trigger waittill(var_0, var_1);
  else
    self waittill(var_0, var_1);

  disable_trigger();
  return var_1;
}

enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin = self.origin + (0, 0, 10000);

    if(isDefined(self.motion_trigger))
      self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, 10000);
  }
}

disable_trigger() {
  self notify("_encstr_A103102396DC164C36CAAF3A4EB49DB35993");

  if(self.enabled)
    thread disable_trigger_helper();
}

disable_trigger_helper() {
  self endon("_encstr_A103102396DC164C36CAAF3A4EB49DB35993");
  self.enabled = 0;
  wait 1.5;
  self.origin = self.origin + (0, 0, -10000);

  if(isDefined(self.motion_trigger))
    self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, -10000);
}

get_outer_doorset(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0];
}

get_outer_doorsets() {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"];
}

get_outer_closedpos(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0]["_encstr_88151003E878EA696791756A0D012190ED60"];
}

get_outer_leftdoor(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0]["_encstr_86D70AC81F2EE8E012E7BF8D"];
}

get_outer_rightdoor(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0]["_encstr_A1DC0B152B72B391C801C81583"];
}

get_outer_leftdoor_openedpos(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"];
}

get_outer_rightdoor_openedpos(var_0) {
  return self.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"][var_0]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"];
}

get_housing_children() {
  var_0 = [];
  var_1 = get_housing_door_trigger();
  var_2 = get_housing_inside_trigger();
  var_3 = var_2.motion_trigger;
  var_4 = get_housing_leftdoor();
  var_5 = get_housing_rightdoor();
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = var_2;
  var_0[var_0.size] = var_4;
  var_0[var_0.size] = var_5;

  if(isDefined(var_3))
    var_0[var_0.size] = var_3;

  var_6 = get_housing_models();

  foreach(var_8 in var_6)
  var_0[var_0.size] = var_8;

  var_10 = get_housing_primarylight();

  foreach(var_12 in var_10)
  var_0[var_0.size] = var_12;

  return var_0;
}

get_housing_mainframe() {
  var_0 = self.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"];
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.classname != "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && var_3.code_classname != "_encstr_8FA906CC80677438")
      var_1 = var_3;
  }

  return var_1;
}

get_housing_models() {
  var_0 = self.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_housing_primarylight() {
  var_0 = self.e["_encstr_ADE108D8220776805DA7"]["_encstr_8C430AB558A5CD669C586BB2"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "_encstr_8FA906CC80677438")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_housing_musak_model() {
  var_0 = get_housing_models();
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "_encstr_B6E90B22B03041C199C3EF9FC7")
      var_1 = var_3;
  }

  return var_1;
}

get_housing_door_trigger() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_88DF0DB9B070F3F740222B488745E5"];
}

get_housing_inside_trigger() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_86BF0FD07A4273293FEF8D86A14F31236A"];
}

get_housing_closedpos() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_88151003E878EA696791756A0D012190ED60"];
}

get_housing_leftdoor() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_86D70AC81F2EE8E012E7BF8D"];
}

get_housing_rightdoor() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_A1DC0B152B72B391C801C81583"];
}

get_housing_leftdoor_opened_pos() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_971815E935A2A35918C712486F67DF9B7D93C99FA217C6"];
}

get_housing_rightdoor_opened_pos() {
  return self.e["_encstr_ADE108D8220776805DA7"]["_encstr_834C169C2DCE43E8FA19B77B9CEBDE0759B92B19AF38F66E"];
}

get_curfloor() {
  var_0 = elevator_floor_update();
  return self.e["_encstr_933B0ED8AE93932BDC3AF533C6DBDB4E"];
}

get_initfloor() {
  return self.e["_encstr_B45D0E09BD287BCFDFF889E28D201F32"];
}

waittill_finish_moving(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) && !isDefined(var_3)) {
    var_2 = var_0;
    var_3 = var_1;
  }

  for(;;) {
    var_4 = var_0.origin;
    var_5 = var_2.origin;

    if(var_4 == var_1 && var_5 == var_3) {
      break;
    }

    wait 0.05;
  }
}

isinbound(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  return var_1 >= var_3 && var_1 <= var_4 && var_2 >= var_5 && var_2 <= var_6;
}

isinboundingspere(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = (var_3 + var_4) / 2;
  var_8 = (var_5 + var_6) / 2;
  var_9 = abs(distance((var_3, var_5, 0), (var_7, var_8, 0)));
  return abs(distance((var_1, var_2, 0), (var_7, var_8, 0))) < var_9;
}

waittill_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

elevator_get_dvar_int(var_0, var_1) {
  return int(elevator_get_dvar(var_0, var_1));
}

elevator_get_dvar(var_0, var_1) {
  if(getDvar(var_0) != "_encstr_B40101")
    return getdvarfloat(var_0);
  else {
    setDvar(var_0, var_1);
    return var_1;
  }
}

elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }
  for(;;) {
    if(level.elevator_debug != 2) {
      continue;
    }
    foreach(var_7, var_1 in level.elevators) {
      var_2 = var_1 get_housing_mainframe();
      var_3 = var_1 get_housing_musak_model();

      foreach(var_6, var_5 in var_1.e["_encstr_AA140EED57D1B293FA197BDB39372B1D"]) {}
    }

    foreach(var_9 in level.elevator_callbuttons) {
      foreach(var_16, var_5 in var_9.e) {
        var_11 = 0;

        foreach(var_15, var_13 in var_5) {
          var_11++;
          var_14 = var_9.origin + (0, 0, var_11 * -4);
        }
      }
    }

    wait 0.05;
  }
}