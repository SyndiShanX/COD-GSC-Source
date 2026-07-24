/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_shutter_controller.gsc
**********************************************************************/

_id_10198() {
  var_0 = getEntArray("emergency_shutter", "targetname");

  if(var_0.size == 0) {
    return;
  }
  _id_4951();
  level._id_10184 = [];

  foreach(var_5, var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::get_target_ent();
    var_3 setCanDamage(1);
    var_3 thread _id_10188(var_5);

    if(!isDefined(var_2.script_type)) {
      continue;
    }
    var_4 = [];
    var_4[0] = var_2;
    level._id_10184[var_5] = var_2;
  }
}

_id_4951() {
  level._id_10189 = [];
  var_0 = spawnStruct();
  var_0.type = "primary";
  var_0._id_1019F = 9;
  var_0._id_C262 = [];
  var_0._id_C262[0] = (-24.3415, 0, 95.2654);
  var_0._id_C262[1] = (23.9405, 0, 12.1391);
  var_0._id_C262[2] = (51.342, 0, -78.0285);
  var_0._id_C262[3] = (62.0425, 0, -171.536);
  var_0._id_C262[4] = (60.8716, 0, -264.707);
  var_0._id_C262[5] = (47.0917, 0, -356.41);
  var_0._id_C262[6] = (24.7373, 0, -444.643);
  var_0._id_C262[7] = (1.70255, 0, -533.001);
  var_0._id_C262[8] = (-22.7026, 0, -625.001);
  var_0._id_14A8 = [];
  var_0._id_14A8[0] = 341.0;
  var_0._id_14A8[1] = 351.8;
  var_0._id_14A8[2] = 0.2;
  var_0._id_14A8[3] = 6.5;
  var_0._id_14A8[4] = 11.8;
  var_0._id_14A8[5] = 15.0;
  var_0._id_14A8[6] = 15.4;
  var_0._id_14A8[7] = 16.0;
  var_0._id_14A8[8] = 16.2;
  level._id_10189["primary"] = var_0;
}

_id_10188(var_0) {
  self endon("cleanup");
  var_1 = 25;
  var_2 = undefined;

  for(var_3 = undefined; var_1 > 0; var_1 = var_1 - 5)
    self waittill("damage", var_4, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_3);

  var_15 = undefined;

  if(isDefined(var_3) && var_3 != (0, 0, 0)) {
    var_16 = vectortoangles(var_3);
    var_15 = scripts\engine\utility::spawn_tag_origin(var_2, var_16);
  }

  level._id_10184[var_0] _id_1018E();

  if(isDefined(var_15))
    var_15 delete();
}

_id_1018E() {
  self endon("cleanup");
  var_0 = self.script_type;
  self._id_3E64 = [];
  var_1 = 1;
  var_2 = self;
  self playLoopSound("scn_tele_door_looping");

  while(var_1 < level._id_10189[var_0]._id_1019F - 1) {
    var_3 = level._id_10189[var_0]._id_C262[var_1];
    var_4 = level._id_10189[var_0]._id_14A8[var_1];
    var_5 = spawn("script_model", self.origin);
    var_5 setModel("window_spaceport_shutter_b");
    var_5.angles = (var_4, self.angles[1], 0);
    var_6 = rotatevector(var_3, (0, self.angles[1], 0));
    var_5.origin = var_5.origin + var_6;
    self._id_3E64[var_1] = var_5;
    var_7 = anglestoup(var_5.angles) * -98;
    var_8 = var_5.origin + var_7;
    var_5 moveTo(var_8, 0.2);
    wait 0.25;
    var_9 = anglesToForward(var_5.angles) * -8;
    var_8 = var_5.origin + var_9;
    var_5 moveTo(var_8, 0.1);
    wait 0.15;
    var_5 playSound("scn_tele_door_close");
    var_2 = var_5;
    var_1++;
  }

  self stopsounds();
}

_id_40C3(var_0) {
  foreach(var_7, var_2 in level._id_10184) {
    if(!isDefined(var_2.script_parameters) || var_2.script_parameters != var_0) {
      continue;
    }
    if(isDefined(var_2._id_3E64)) {
      foreach(var_4 in var_2._id_3E64)
      var_4 delete();
    }

    var_6 = var_2 scripts\engine\utility::get_target_ent();

    if(isDefined(var_6)) {
      var_6 notify("cleanup");
      var_6 delete();
    }

    var_2 delete();
    level._id_10184[var_7] = undefined;
  }
}